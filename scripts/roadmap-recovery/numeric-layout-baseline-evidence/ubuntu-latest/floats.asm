
/home/runner/work/_temp/numeric-layout-baseline/floats-diagnostic:     file format elf64-x86-64


Disassembly of section .init:

0000000000002000 <_init>:
    2000:	f3 0f 1e fa          	endbr64
    2004:	48 83 ec 08          	sub    $0x8,%rsp
    2008:	48 8b 05 b9 0f 01 00 	mov    0x10fb9(%rip),%rax        # 12fc8 <__gmon_start__@Base>
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

00000000000020d0 <sigaction@plt>:
    20d0:	ff 25 7a 0f 01 00    	jmp    *0x10f7a(%rip)        # 13050 <sigaction@GLIBC_2.2.5>
    20d6:	68 0a 00 00 00       	push   $0xa
    20db:	e9 40 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020e0 <fread@plt>:
    20e0:	ff 25 72 0f 01 00    	jmp    *0x10f72(%rip)        # 13058 <fread@GLIBC_2.2.5>
    20e6:	68 0b 00 00 00       	push   $0xb
    20eb:	e9 30 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020f0 <strtod@plt>:
    20f0:	ff 25 6a 0f 01 00    	jmp    *0x10f6a(%rip)        # 13060 <strtod@GLIBC_2.2.5>
    20f6:	68 0c 00 00 00       	push   $0xc
    20fb:	e9 20 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002100 <vsnprintf@plt>:
    2100:	ff 25 62 0f 01 00    	jmp    *0x10f62(%rip)        # 13068 <vsnprintf@GLIBC_2.2.5>
    2106:	68 0d 00 00 00       	push   $0xd
    210b:	e9 10 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002110 <fcntl@plt>:
    2110:	ff 25 5a 0f 01 00    	jmp    *0x10f5a(%rip)        # 13070 <fcntl@GLIBC_2.2.5>
    2116:	68 0e 00 00 00       	push   $0xe
    211b:	e9 00 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002120 <clock_gettime@plt>:
    2120:	ff 25 52 0f 01 00    	jmp    *0x10f52(%rip)        # 13078 <clock_gettime@GLIBC_2.17>
    2126:	68 0f 00 00 00       	push   $0xf
    212b:	e9 f0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002130 <write@plt>:
    2130:	ff 25 4a 0f 01 00    	jmp    *0x10f4a(%rip)        # 13080 <write@GLIBC_2.2.5>
    2136:	68 10 00 00 00       	push   $0x10
    213b:	e9 e0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002140 <fclose@plt>:
    2140:	ff 25 42 0f 01 00    	jmp    *0x10f42(%rip)        # 13088 <fclose@GLIBC_2.2.5>
    2146:	68 11 00 00 00       	push   $0x11
    214b:	e9 d0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002150 <shutdown@plt>:
    2150:	ff 25 3a 0f 01 00    	jmp    *0x10f3a(%rip)        # 13090 <shutdown@GLIBC_2.2.5>
    2156:	68 12 00 00 00       	push   $0x12
    215b:	e9 c0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002160 <strlen@plt>:
    2160:	ff 25 32 0f 01 00    	jmp    *0x10f32(%rip)        # 13098 <strlen@GLIBC_2.2.5>
    2166:	68 13 00 00 00       	push   $0x13
    216b:	e9 b0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002170 <getuid@plt>:
    2170:	ff 25 2a 0f 01 00    	jmp    *0x10f2a(%rip)        # 130a0 <getuid@GLIBC_2.2.5>
    2176:	68 14 00 00 00       	push   $0x14
    217b:	e9 a0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002180 <mmap@plt>:
    2180:	ff 25 22 0f 01 00    	jmp    *0x10f22(%rip)        # 130a8 <mmap@GLIBC_2.2.5>
    2186:	68 15 00 00 00       	push   $0x15
    218b:	e9 90 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002190 <send@plt>:
    2190:	ff 25 1a 0f 01 00    	jmp    *0x10f1a(%rip)        # 130b0 <send@GLIBC_2.2.5>
    2196:	68 16 00 00 00       	push   $0x16
    219b:	e9 80 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021a0 <strchr@plt>:
    21a0:	ff 25 12 0f 01 00    	jmp    *0x10f12(%rip)        # 130b8 <strchr@GLIBC_2.2.5>
    21a6:	68 17 00 00 00       	push   $0x17
    21ab:	e9 70 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021b0 <printf@plt>:
    21b0:	ff 25 0a 0f 01 00    	jmp    *0x10f0a(%rip)        # 130c0 <printf@GLIBC_2.2.5>
    21b6:	68 18 00 00 00       	push   $0x18
    21bb:	e9 60 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021c0 <snprintf@plt>:
    21c0:	ff 25 02 0f 01 00    	jmp    *0x10f02(%rip)        # 130c8 <snprintf@GLIBC_2.2.5>
    21c6:	68 19 00 00 00       	push   $0x19
    21cb:	e9 50 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021d0 <ftruncate@plt>:
    21d0:	ff 25 fa 0e 01 00    	jmp    *0x10efa(%rip)        # 130d0 <ftruncate@GLIBC_2.2.5>
    21d6:	68 1a 00 00 00       	push   $0x1a
    21db:	e9 40 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021e0 <fputs@plt>:
    21e0:	ff 25 f2 0e 01 00    	jmp    *0x10ef2(%rip)        # 130d8 <fputs@GLIBC_2.2.5>
    21e6:	68 1b 00 00 00       	push   $0x1b
    21eb:	e9 30 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021f0 <strtof@plt>:
    21f0:	ff 25 ea 0e 01 00    	jmp    *0x10eea(%rip)        # 130e0 <strtof@GLIBC_2.2.5>
    21f6:	68 1c 00 00 00       	push   $0x1c
    21fb:	e9 20 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002200 <memset@plt>:
    2200:	ff 25 e2 0e 01 00    	jmp    *0x10ee2(%rip)        # 130e8 <memset@GLIBC_2.2.5>
    2206:	68 1d 00 00 00       	push   $0x1d
    220b:	e9 10 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002210 <fgetc@plt>:
    2210:	ff 25 da 0e 01 00    	jmp    *0x10eda(%rip)        # 130f0 <fgetc@GLIBC_2.2.5>
    2216:	68 1e 00 00 00       	push   $0x1e
    221b:	e9 00 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002220 <close@plt>:
    2220:	ff 25 d2 0e 01 00    	jmp    *0x10ed2(%rip)        # 130f8 <close@GLIBC_2.2.5>
    2226:	68 1f 00 00 00       	push   $0x1f
    222b:	e9 f0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002230 <fputc@plt>:
    2230:	ff 25 ca 0e 01 00    	jmp    *0x10eca(%rip)        # 13100 <fputc@GLIBC_2.2.5>
    2236:	68 20 00 00 00       	push   $0x20
    223b:	e9 e0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002240 <sched_yield@plt>:
    2240:	ff 25 c2 0e 01 00    	jmp    *0x10ec2(%rip)        # 13108 <sched_yield@GLIBC_2.2.5>
    2246:	68 21 00 00 00       	push   $0x21
    224b:	e9 d0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002250 <memchr@plt>:
    2250:	ff 25 ba 0e 01 00    	jmp    *0x10eba(%rip)        # 13110 <memchr@GLIBC_2.2.5>
    2256:	68 22 00 00 00       	push   $0x22
    225b:	e9 c0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002260 <memcmp@plt>:
    2260:	ff 25 b2 0e 01 00    	jmp    *0x10eb2(%rip)        # 13118 <memcmp@GLIBC_2.2.5>
    2266:	68 23 00 00 00       	push   $0x23
    226b:	e9 b0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002270 <pthread_attr_init@plt>:
    2270:	ff 25 aa 0e 01 00    	jmp    *0x10eaa(%rip)        # 13120 <pthread_attr_init@GLIBC_2.2.5>
    2276:	68 24 00 00 00       	push   $0x24
    227b:	e9 a0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002280 <fgets@plt>:
    2280:	ff 25 a2 0e 01 00    	jmp    *0x10ea2(%rip)        # 13128 <fgets@GLIBC_2.2.5>
    2286:	68 25 00 00 00       	push   $0x25
    228b:	e9 90 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002290 <getsockopt@plt>:
    2290:	ff 25 9a 0e 01 00    	jmp    *0x10e9a(%rip)        # 13130 <getsockopt@GLIBC_2.2.5>
    2296:	68 26 00 00 00       	push   $0x26
    229b:	e9 80 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022a0 <_setjmp@plt>:
    22a0:	ff 25 92 0e 01 00    	jmp    *0x10e92(%rip)        # 13138 <_setjmp@GLIBC_2.2.5>
    22a6:	68 27 00 00 00       	push   $0x27
    22ab:	e9 70 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022b0 <strtoull@plt>:
    22b0:	ff 25 8a 0e 01 00    	jmp    *0x10e8a(%rip)        # 13140 <strtoull@GLIBC_2.2.5>
    22b6:	68 28 00 00 00       	push   $0x28
    22bb:	e9 60 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022c0 <strcmp@plt>:
    22c0:	ff 25 82 0e 01 00    	jmp    *0x10e82(%rip)        # 13148 <strcmp@GLIBC_2.2.5>
    22c6:	68 29 00 00 00       	push   $0x29
    22cb:	e9 50 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022d0 <signal@plt>:
    22d0:	ff 25 7a 0e 01 00    	jmp    *0x10e7a(%rip)        # 13150 <signal@GLIBC_2.2.5>
    22d6:	68 2a 00 00 00       	push   $0x2a
    22db:	e9 40 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022e0 <fprintf@plt>:
    22e0:	ff 25 72 0e 01 00    	jmp    *0x10e72(%rip)        # 13158 <fprintf@GLIBC_2.2.5>
    22e6:	68 2b 00 00 00       	push   $0x2b
    22eb:	e9 30 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022f0 <syscall@plt>:
    22f0:	ff 25 6a 0e 01 00    	jmp    *0x10e6a(%rip)        # 13160 <syscall@GLIBC_2.2.5>
    22f6:	68 2c 00 00 00       	push   $0x2c
    22fb:	e9 20 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002300 <sigemptyset@plt>:
    2300:	ff 25 62 0e 01 00    	jmp    *0x10e62(%rip)        # 13168 <sigemptyset@GLIBC_2.2.5>
    2306:	68 2d 00 00 00       	push   $0x2d
    230b:	e9 10 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002310 <strtol@plt>:
    2310:	ff 25 5a 0e 01 00    	jmp    *0x10e5a(%rip)        # 13170 <strtol@GLIBC_2.2.5>
    2316:	68 2e 00 00 00       	push   $0x2e
    231b:	e9 00 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002320 <memcpy@plt>:
    2320:	ff 25 52 0e 01 00    	jmp    *0x10e52(%rip)        # 13178 <memcpy@GLIBC_2.14>
    2326:	68 2f 00 00 00       	push   $0x2f
    232b:	e9 f0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002330 <malloc@plt>:
    2330:	ff 25 4a 0e 01 00    	jmp    *0x10e4a(%rip)        # 13180 <malloc@GLIBC_2.2.5>
    2336:	68 30 00 00 00       	push   $0x30
    233b:	e9 e0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002340 <fflush@plt>:
    2340:	ff 25 42 0e 01 00    	jmp    *0x10e42(%rip)        # 13188 <fflush@GLIBC_2.2.5>
    2346:	68 31 00 00 00       	push   $0x31
    234b:	e9 d0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002350 <listen@plt>:
    2350:	ff 25 3a 0e 01 00    	jmp    *0x10e3a(%rip)        # 13190 <listen@GLIBC_2.2.5>
    2356:	68 32 00 00 00       	push   $0x32
    235b:	e9 c0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002360 <bcmp@plt>:
    2360:	ff 25 32 0e 01 00    	jmp    *0x10e32(%rip)        # 13198 <bcmp@GLIBC_2.2.5>
    2366:	68 33 00 00 00       	push   $0x33
    236b:	e9 b0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002370 <realloc@plt>:
    2370:	ff 25 2a 0e 01 00    	jmp    *0x10e2a(%rip)        # 131a0 <realloc@GLIBC_2.2.5>
    2376:	68 34 00 00 00       	push   $0x34
    237b:	e9 a0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002380 <munmap@plt>:
    2380:	ff 25 22 0e 01 00    	jmp    *0x10e22(%rip)        # 131a8 <munmap@GLIBC_2.2.5>
    2386:	68 35 00 00 00       	push   $0x35
    238b:	e9 90 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002390 <recvmsg@plt>:
    2390:	ff 25 1a 0e 01 00    	jmp    *0x10e1a(%rip)        # 131b0 <recvmsg@GLIBC_2.2.5>
    2396:	68 36 00 00 00       	push   $0x36
    239b:	e9 80 fc ff ff       	jmp    2020 <_init+0x20>

00000000000023a0 <setvbuf@plt>:
    23a0:	ff 25 12 0e 01 00    	jmp    *0x10e12(%rip)        # 131b8 <setvbuf@GLIBC_2.2.5>
    23a6:	68 37 00 00 00       	push   $0x37
    23ab:	e9 70 fc ff ff       	jmp    2020 <_init+0x20>

00000000000023b0 <poll@plt>:
    23b0:	ff 25 0a 0e 01 00    	jmp    *0x10e0a(%rip)        # 131c0 <poll@GLIBC_2.2.5>
    23b6:	68 38 00 00 00       	push   $0x38
    23bb:	e9 60 fc ff ff       	jmp    2020 <_init+0x20>

00000000000023c0 <bind@plt>:
    23c0:	ff 25 02 0e 01 00    	jmp    *0x10e02(%rip)        # 131c8 <bind@GLIBC_2.2.5>
    23c6:	68 39 00 00 00       	push   $0x39
    23cb:	e9 50 fc ff ff       	jmp    2020 <_init+0x20>

00000000000023d0 <pthread_create@plt>:
    23d0:	ff 25 fa 0d 01 00    	jmp    *0x10dfa(%rip)        # 131d0 <pthread_create@GLIBC_2.34>
    23d6:	68 3a 00 00 00       	push   $0x3a
    23db:	e9 40 fc ff ff       	jmp    2020 <_init+0x20>

00000000000023e0 <madvise@plt>:
    23e0:	ff 25 f2 0d 01 00    	jmp    *0x10df2(%rip)        # 131d8 <madvise@GLIBC_2.2.5>
    23e6:	68 3b 00 00 00       	push   $0x3b
    23eb:	e9 30 fc ff ff       	jmp    2020 <_init+0x20>

00000000000023f0 <atol@plt>:
    23f0:	ff 25 ea 0d 01 00    	jmp    *0x10dea(%rip)        # 131e0 <atol@GLIBC_2.2.5>
    23f6:	68 3c 00 00 00       	push   $0x3c
    23fb:	e9 20 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002400 <mprotect@plt>:
    2400:	ff 25 e2 0d 01 00    	jmp    *0x10de2(%rip)        # 131e8 <mprotect@GLIBC_2.2.5>
    2406:	68 3d 00 00 00       	push   $0x3d
    240b:	e9 10 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002410 <fopen@plt>:
    2410:	ff 25 da 0d 01 00    	jmp    *0x10dda(%rip)        # 131f0 <fopen@GLIBC_2.2.5>
    2416:	68 3e 00 00 00       	push   $0x3e
    241b:	e9 00 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002420 <sysconf@plt>:
    2420:	ff 25 d2 0d 01 00    	jmp    *0x10dd2(%rip)        # 131f8 <sysconf@GLIBC_2.2.5>
    2426:	68 3f 00 00 00       	push   $0x3f
    242b:	e9 f0 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002430 <accept@plt>:
    2430:	ff 25 ca 0d 01 00    	jmp    *0x10dca(%rip)        # 13200 <accept@GLIBC_2.2.5>
    2436:	68 40 00 00 00       	push   $0x40
    243b:	e9 e0 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002440 <__cxa_atexit@plt>:
    2440:	ff 25 c2 0d 01 00    	jmp    *0x10dc2(%rip)        # 13208 <__cxa_atexit@GLIBC_2.2.5>
    2446:	68 41 00 00 00       	push   $0x41
    244b:	e9 d0 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002450 <atoi@plt>:
    2450:	ff 25 ba 0d 01 00    	jmp    *0x10dba(%rip)        # 13210 <atoi@GLIBC_2.2.5>
    2456:	68 42 00 00 00       	push   $0x42
    245b:	e9 c0 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002460 <sprintf@plt>:
    2460:	ff 25 b2 0d 01 00    	jmp    *0x10db2(%rip)        # 13218 <sprintf@GLIBC_2.2.5>
    2466:	68 43 00 00 00       	push   $0x43
    246b:	e9 b0 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002470 <exit@plt>:
    2470:	ff 25 aa 0d 01 00    	jmp    *0x10daa(%rip)        # 13220 <exit@GLIBC_2.2.5>
    2476:	68 44 00 00 00       	push   $0x44
    247b:	e9 a0 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002480 <connect@plt>:
    2480:	ff 25 a2 0d 01 00    	jmp    *0x10da2(%rip)        # 13228 <connect@GLIBC_2.2.5>
    2486:	68 45 00 00 00       	push   $0x45
    248b:	e9 90 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002490 <fwrite@plt>:
    2490:	ff 25 9a 0d 01 00    	jmp    *0x10d9a(%rip)        # 13230 <fwrite@GLIBC_2.2.5>
    2496:	68 46 00 00 00       	push   $0x46
    249b:	e9 80 fb ff ff       	jmp    2020 <_init+0x20>

00000000000024a0 <getrlimit@plt>:
    24a0:	ff 25 92 0d 01 00    	jmp    *0x10d92(%rip)        # 13238 <getrlimit@GLIBC_2.2.5>
    24a6:	68 47 00 00 00       	push   $0x47
    24ab:	e9 70 fb ff ff       	jmp    2020 <_init+0x20>

00000000000024b0 <pthread_join@plt>:
    24b0:	ff 25 8a 0d 01 00    	jmp    *0x10d8a(%rip)        # 13240 <pthread_join@GLIBC_2.34>
    24b6:	68 48 00 00 00       	push   $0x48
    24bb:	e9 60 fb ff ff       	jmp    2020 <_init+0x20>

00000000000024c0 <sigaltstack@plt>:
    24c0:	ff 25 82 0d 01 00    	jmp    *0x10d82(%rip)        # 13248 <sigaltstack@GLIBC_2.2.5>
    24c6:	68 49 00 00 00       	push   $0x49
    24cb:	e9 50 fb ff ff       	jmp    2020 <_init+0x20>

00000000000024d0 <fstat@plt>:
    24d0:	ff 25 7a 0d 01 00    	jmp    *0x10d7a(%rip)        # 13250 <fstat@GLIBC_2.33>
    24d6:	68 4a 00 00 00       	push   $0x4a
    24db:	e9 40 fb ff ff       	jmp    2020 <_init+0x20>

00000000000024e0 <strstr@plt>:
    24e0:	ff 25 72 0d 01 00    	jmp    *0x10d72(%rip)        # 13258 <strstr@GLIBC_2.2.5>
    24e6:	68 4b 00 00 00       	push   $0x4b
    24eb:	e9 30 fb ff ff       	jmp    2020 <_init+0x20>

00000000000024f0 <__ctype_b_loc@plt>:
    24f0:	ff 25 6a 0d 01 00    	jmp    *0x10d6a(%rip)        # 13260 <__ctype_b_loc@GLIBC_2.3>
    24f6:	68 4c 00 00 00       	push   $0x4c
    24fb:	e9 20 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002500 <socket@plt>:
    2500:	ff 25 62 0d 01 00    	jmp    *0x10d62(%rip)        # 13268 <socket@GLIBC_2.2.5>
    2506:	68 4d 00 00 00       	push   $0x4d
    250b:	e9 10 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002510 <pthread_attr_setstacksize@plt>:
    2510:	ff 25 5a 0d 01 00    	jmp    *0x10d5a(%rip)        # 13270 <pthread_attr_setstacksize@GLIBC_2.34>
    2516:	68 4e 00 00 00       	push   $0x4e
    251b:	e9 00 fb ff ff       	jmp    2020 <_init+0x20>

Disassembly of section .plt.got:

0000000000002520 <__cxa_finalize@plt>:
    2520:	ff 25 b2 0a 01 00    	jmp    *0x10ab2(%rip)        # 12fd8 <__cxa_finalize@GLIBC_2.2.5>
    2526:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

0000000000002530 <_start>:
    2530:	f3 0f 1e fa          	endbr64
    2534:	31 ed                	xor    %ebp,%ebp
    2536:	49 89 d1             	mov    %rdx,%r9
    2539:	5e                   	pop    %rsi
    253a:	48 89 e2             	mov    %rsp,%rdx
    253d:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
    2541:	50                   	push   %rax
    2542:	54                   	push   %rsp
    2543:	45 31 c0             	xor    %r8d,%r8d
    2546:	31 c9                	xor    %ecx,%ecx
    2548:	48 8d 3d b1 02 00 00 	lea    0x2b1(%rip),%rdi        # 2800 <main>
    254f:	ff 15 53 0a 01 00    	call   *0x10a53(%rip)        # 12fa8 <__libc_start_main@GLIBC_2.34>
    2555:	f4                   	hlt
    2556:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    255d:	00 00 00 

0000000000002560 <deregister_tm_clones>:
    2560:	48 8d 3d 21 28 01 00 	lea    0x12821(%rip),%rdi        # 14d88 <__TMC_END__>
    2567:	48 8d 05 1a 28 01 00 	lea    0x1281a(%rip),%rax        # 14d88 <__TMC_END__>
    256e:	48 39 f8             	cmp    %rdi,%rax
    2571:	74 15                	je     2588 <deregister_tm_clones+0x28>
    2573:	48 8b 05 36 0a 01 00 	mov    0x10a36(%rip),%rax        # 12fb0 <_ITM_deregisterTMCloneTable@Base>
    257a:	48 85 c0             	test   %rax,%rax
    257d:	74 09                	je     2588 <deregister_tm_clones+0x28>
    257f:	ff e0                	jmp    *%rax
    2581:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    2588:	c3                   	ret
    2589:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002590 <register_tm_clones>:
    2590:	48 8d 3d f1 27 01 00 	lea    0x127f1(%rip),%rdi        # 14d88 <__TMC_END__>
    2597:	48 8d 35 ea 27 01 00 	lea    0x127ea(%rip),%rsi        # 14d88 <__TMC_END__>
    259e:	48 29 fe             	sub    %rdi,%rsi
    25a1:	48 89 f0             	mov    %rsi,%rax
    25a4:	48 c1 ee 3f          	shr    $0x3f,%rsi
    25a8:	48 c1 f8 03          	sar    $0x3,%rax
    25ac:	48 01 c6             	add    %rax,%rsi
    25af:	48 d1 fe             	sar    $1,%rsi
    25b2:	74 14                	je     25c8 <register_tm_clones+0x38>
    25b4:	48 8b 05 15 0a 01 00 	mov    0x10a15(%rip),%rax        # 12fd0 <_ITM_registerTMCloneTable@Base>
    25bb:	48 85 c0             	test   %rax,%rax
    25be:	74 08                	je     25c8 <register_tm_clones+0x38>
    25c0:	ff e0                	jmp    *%rax
    25c2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    25c8:	c3                   	ret
    25c9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000025d0 <__do_global_dtors_aux>:
    25d0:	f3 0f 1e fa          	endbr64
    25d4:	80 3d b5 27 01 00 00 	cmpb   $0x0,0x127b5(%rip)        # 14d90 <completed.0>
    25db:	75 2b                	jne    2608 <__do_global_dtors_aux+0x38>
    25dd:	55                   	push   %rbp
    25de:	48 83 3d f2 09 01 00 	cmpq   $0x0,0x109f2(%rip)        # 12fd8 <__cxa_finalize@GLIBC_2.2.5>
    25e5:	00 
    25e6:	48 89 e5             	mov    %rsp,%rbp
    25e9:	74 0c                	je     25f7 <__do_global_dtors_aux+0x27>
    25eb:	48 8b 3d 8e 0c 01 00 	mov    0x10c8e(%rip),%rdi        # 13280 <__dso_handle>
    25f2:	e8 29 ff ff ff       	call   2520 <__cxa_finalize@plt>
    25f7:	e8 64 ff ff ff       	call   2560 <deregister_tm_clones>
    25fc:	c6 05 8d 27 01 00 01 	movb   $0x1,0x1278d(%rip)        # 14d90 <completed.0>
    2603:	5d                   	pop    %rbp
    2604:	c3                   	ret
    2605:	0f 1f 00             	nopl   (%rax)
    2608:	c3                   	ret
    2609:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002610 <frame_dummy>:
    2610:	f3 0f 1e fa          	endbr64
    2614:	e9 77 ff ff ff       	jmp    2590 <register_tm_clones>
    2619:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002620 <original_main>:
    2620:	41 56                	push   %r14
    2622:	53                   	push   %rbx
    2623:	48 83 ec 58          	sub    $0x58,%rsp
    2627:	48 8d 05 e2 02 01 00 	lea    0x102e2(%rip),%rax        # 12910 <fwp_fn_table>
    262e:	48 89 05 6b 27 01 00 	mov    %rax,0x1276b(%rip)        # 14da0 <fwp_fns>
    2635:	4c 8b 35 7c 09 01 00 	mov    0x1097c(%rip),%r14        # 12fb8 <stdout@GLIBC_2.2.5>
    263c:	49 8b 06             	mov    (%r14),%rax
    263f:	48 89 05 62 27 01 00 	mov    %rax,0x12762(%rip)        # 14da8 <fwp_prog_out>
    2646:	89 3d 64 27 01 00    	mov    %edi,0x12764(%rip)        # 14db0 <fwp_argc>
    264c:	48 89 35 65 27 01 00 	mov    %rsi,0x12765(%rip)        # 14db8 <fwp_argv>
    2653:	48 8d 35 66 27 01 00 	lea    0x12766(%rip),%rsi        # 14dc0 <fwp_start_time>
    265a:	bf 01 00 00 00       	mov    $0x1,%edi
    265f:	e8 bc fa ff ff       	call   2120 <clock_gettime@plt>
    2664:	e8 b7 00 00 00       	call   2720 <fwp_seed_rng>
    2669:	49 8b 3e             	mov    (%r14),%rdi
    266c:	b9 00 00 01 00       	mov    $0x10000,%ecx
    2671:	31 f6                	xor    %esi,%esi
    2673:	31 d2                	xor    %edx,%edx
    2675:	e8 26 fd ff ff       	call   23a0 <setvbuf@plt>
    267a:	be 01 00 00 00       	mov    $0x1,%esi
    267f:	bf 0d 00 00 00       	mov    $0xd,%edi
    2684:	e8 47 fc ff ff       	call   22d0 <signal@plt>
    2689:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    268e:	48 89 df             	mov    %rbx,%rdi
    2691:	e8 da fb ff ff       	call   2270 <pthread_attr_init@plt>
    2696:	48 8b 35 eb 0b 01 00 	mov    0x10beb(%rip),%rsi        # 13288 <fwp_main_stack>
    269d:	48 89 df             	mov    %rbx,%rdi
    26a0:	e8 6b fe ff ff       	call   2510 <pthread_attr_setstacksize@plt>
    26a5:	48 8d 15 d4 00 00 00 	lea    0xd4(%rip),%rdx        # 2780 <fwp_main_thread>
    26ac:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    26b1:	48 89 de             	mov    %rbx,%rsi
    26b4:	31 c9                	xor    %ecx,%ecx
    26b6:	e8 15 fd ff ff       	call   23d0 <pthread_create@plt>
    26bb:	85 c0                	test   %eax,%eax
    26bd:	74 35                	je     26f4 <original_main+0xd4>
    26bf:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    26c4:	bf 03 00 00 00       	mov    $0x3,%edi
    26c9:	e8 d2 fd ff ff       	call   24a0 <getrlimit@plt>
    26ce:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    26d3:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
    26d7:	ba 00 00 80 00       	mov    $0x800000,%edx
    26dc:	48 0f 44 ca          	cmove  %rdx,%rcx
    26e0:	85 c0                	test   %eax,%eax
    26e2:	48 0f 45 ca          	cmovne %rdx,%rcx
    26e6:	48 89 0d 9b 0b 01 00 	mov    %rcx,0x10b9b(%rip)        # 13288 <fwp_main_stack>
    26ed:	e8 8e 00 00 00       	call   2780 <fwp_main_thread>
    26f2:	eb 0c                	jmp    2700 <original_main+0xe0>
    26f4:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    26f9:	31 f6                	xor    %esi,%esi
    26fb:	e8 b0 fd ff ff       	call   24b0 <pthread_join@plt>
    2700:	49 8b 3e             	mov    (%r14),%rdi
    2703:	e8 38 fc ff ff       	call   2340 <fflush@plt>
    2708:	8b 05 c2 26 01 00    	mov    0x126c2(%rip),%eax        # 14dd0 <fwp_exit_code>
    270e:	48 83 c4 58          	add    $0x58,%rsp
    2712:	5b                   	pop    %rbx
    2713:	41 5e                	pop    %r14
    2715:	c3                   	ret
    2716:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    271d:	00 00 00 

0000000000002720 <fwp_seed_rng>:
    2720:	53                   	push   %rbx
    2721:	48 83 ec 20          	sub    $0x20,%rsp
    2725:	48 8d 3d 3d b1 00 00 	lea    0xb13d(%rip),%rdi        # d869 <exec_in_fp0+0x209>
    272c:	e8 ff f8 ff ff       	call   2030 <getenv@plt>
    2731:	48 85 c0             	test   %rax,%rax
    2734:	74 24                	je     275a <fwp_seed_rng+0x3a>
    2736:	48 89 c3             	mov    %rax,%rbx
    2739:	80 38 00             	cmpb   $0x0,(%rax)
    273c:	74 1c                	je     275a <fwp_seed_rng+0x3a>
    273e:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    2743:	48 89 df             	mov    %rbx,%rdi
    2746:	ba 0a 00 00 00       	mov    $0xa,%edx
    274b:	e8 60 fb ff ff       	call   22b0 <strtoull@plt>
    2750:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    2755:	80 38 00             	cmpb   $0x0,(%rax)
    2758:	74 12                	je     276c <fwp_seed_rng+0x4c>
    275a:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    275f:	31 ff                	xor    %edi,%edi
    2761:	e8 ba f9 ff ff       	call   2120 <clock_gettime@plt>
    2766:	48 83 c4 20          	add    $0x20,%rsp
    276a:	5b                   	pop    %rbx
    276b:	c3                   	ret
    276c:	0f b6 03             	movzbl (%rbx),%eax
    276f:	83 f8 2d             	cmp    $0x2d,%eax
    2772:	74 e6                	je     275a <fwp_seed_rng+0x3a>
    2774:	83 f8 2b             	cmp    $0x2b,%eax
    2777:	74 e1                	je     275a <fwp_seed_rng+0x3a>
    2779:	eb eb                	jmp    2766 <fwp_seed_rng+0x46>
    277b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000002780 <fwp_main_thread>:
    2780:	55                   	push   %rbp
    2781:	48 89 e5             	mov    %rsp,%rbp
    2784:	48 89 ef             	mov    %rbp,%rdi
    2787:	e8 34 01 00 00       	call   28c0 <fwp_gc_start>
    278c:	48 8b 3d f5 0a 01 00 	mov    0x10af5(%rip),%rdi        # 13288 <fwp_main_stack>
    2793:	e8 68 31 00 00       	call   5900 <fwp_stack_guard_init>
    2798:	48 8b 05 c1 04 01 00 	mov    0x104c1(%rip),%rax        # 12c60 <exec_scripts+0x10>
    279f:	48 89 05 4a 26 01 00 	mov    %rax,0x1264a(%rip)        # 14df0 <fwp_cli_scripts+0x10>
    27a6:	0f 28 05 a3 04 01 00 	movaps 0x104a3(%rip),%xmm0        # 12c50 <exec_scripts>
    27ad:	0f 29 05 2c 26 01 00 	movaps %xmm0,0x1262c(%rip)        # 14de0 <fwp_cli_scripts>
    27b4:	48 8d 05 f5 ac 00 00 	lea    0xacf5(%rip),%rax        # d4b0 <exec_man>
    27bb:	48 89 05 36 26 01 00 	mov    %rax,0x12636(%rip)        # 14df8 <fwp_cli_man>
    27c2:	c6 05 37 26 01 00 01 	movb   $0x1,0x12637(%rip)        # 14e00 <fwp_cli_single>
    27c9:	8b 3d e1 25 01 00    	mov    0x125e1(%rip),%edi        # 14db0 <fwp_argc>
    27cf:	48 8b 35 e2 25 01 00 	mov    0x125e2(%rip),%rsi        # 14db8 <fwp_argv>
    27d6:	e8 05 32 00 00       	call   59e0 <fwp_exec>
    27db:	89 05 ef 25 01 00    	mov    %eax,0x125ef(%rip)        # 14dd0 <fwp_exit_code>
    27e1:	48 8b 05 d0 07 01 00 	mov    0x107d0(%rip),%rax        # 12fb8 <stdout@GLIBC_2.2.5>
    27e8:	48 8b 38             	mov    (%rax),%rdi
    27eb:	e8 50 fb ff ff       	call   2340 <fflush@plt>
    27f0:	31 c0                	xor    %eax,%eax
    27f2:	5d                   	pop    %rbp
    27f3:	c3                   	ret
    27f4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    27fb:	00 00 00 00 00 

0000000000002800 <main>:
    2800:	55                   	push   %rbp
    2801:	48 89 e5             	mov    %rsp,%rbp
    2804:	41 56                	push   %r14
    2806:	53                   	push   %rbx
    2807:	48 89 ef             	mov    %rbp,%rdi
    280a:	e8 b1 00 00 00       	call   28c0 <fwp_gc_start>
    280f:	48 8d 05 fa 00 01 00 	lea    0x100fa(%rip),%rax        # 12910 <fwp_fn_table>
    2816:	48 89 05 83 25 01 00 	mov    %rax,0x12583(%rip)        # 14da0 <fwp_fns>
    281d:	f2 0f 10 05 e3 a7 00 	movsd  0xa7e3(%rip),%xmm0        # d008 <_IO_stdin_used+0x8>
    2824:	00 
    2825:	e8 86 01 00 00       	call   29b0 <fwp_from_f64>
    282a:	49 89 c6             	mov    %rax,%r14
    282d:	48 89 c7             	mov    %rax,%rdi
    2830:	e8 3b 01 00 00       	call   2970 <f1>
    2835:	48 89 c3             	mov    %rax,%rbx
    2838:	b8 7e 00 00 00       	mov    $0x7e,%eax
    283d:	83 7b 04 03          	cmpl   $0x3,0x4(%rbx)
    2841:	75 71                	jne    28b4 <main+0xb4>
    2843:	b8 7f 00 00 00       	mov    $0x7f,%eax
    2848:	4c 39 73 08          	cmp    %r14,0x8(%rbx)
    284c:	75 66                	jne    28b4 <main+0xb4>
    284e:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    2852:	f2 0f 10 05 b6 a7 00 	movsd  0xa7b6(%rip),%xmm0        # d010 <_IO_stdin_used+0x10>
    2859:	00 
    285a:	e8 51 01 00 00       	call   29b0 <fwp_from_f64>
    285f:	49 39 c6             	cmp    %rax,%r14
    2862:	75 4b                	jne    28af <main+0xaf>
    2864:	4c 8b 73 18          	mov    0x18(%rbx),%r14
    2868:	f2 0f 10 05 a8 a7 00 	movsd  0xa7a8(%rip),%xmm0        # d018 <_IO_stdin_used+0x18>
    286f:	00 
    2870:	e8 3b 01 00 00       	call   29b0 <fwp_from_f64>
    2875:	49 39 c6             	cmp    %rax,%r14
    2878:	b8 7f 00 00 00       	mov    $0x7f,%eax
    287d:	75 35                	jne    28b4 <main+0xb4>
    287f:	48 8d 3d ea ad 00 00 	lea    0xadea(%rip),%rdi        # d670 <exec_in_fp0+0x10>
    2886:	be 18 00 00 00       	mov    $0x18,%esi
    288b:	ba 08 00 00 00       	mov    $0x8,%edx
    2890:	31 c0                	xor    %eax,%eax
    2892:	e8 19 f9 ff ff       	call   21b0 <printf@plt>
    2897:	48 89 df             	mov    %rbx,%rdi
    289a:	e8 21 01 00 00       	call   29c0 <fwp_rc_release_last>
    289f:	85 c0                	test   %eax,%eax
    28a1:	74 16                	je     28b9 <main+0xb9>
    28a3:	48 89 df             	mov    %rbx,%rdi
    28a6:	e8 45 01 00 00       	call   29f0 <fwp_rc_free_obj>
    28ab:	31 c0                	xor    %eax,%eax
    28ad:	eb 05                	jmp    28b4 <main+0xb4>
    28af:	b8 7f 00 00 00       	mov    $0x7f,%eax
    28b4:	5b                   	pop    %rbx
    28b5:	41 5e                	pop    %r14
    28b7:	5d                   	pop    %rbp
    28b8:	c3                   	ret
    28b9:	b8 80 00 00 00       	mov    $0x80,%eax
    28be:	eb f4                	jmp    28b4 <main+0xb4>

00000000000028c0 <fwp_gc_start>:
    28c0:	53                   	push   %rbx
    28c1:	48 89 fb             	mov    %rdi,%rbx
    28c4:	83 3d b1 19 01 00 00 	cmpl   $0x0,0x119b1(%rip)        # 1427c <fwp_gc+0xfec>
    28cb:	75 05                	jne    28d2 <fwp_gc_start+0x12>
    28cd:	e8 0e 0f 00 00       	call   37e0 <fwp_gc_init>
    28d2:	48 89 1d 3f 1a 01 00 	mov    %rbx,0x11a3f(%rip)        # 14318 <fwp_gc+0x1088>
    28d9:	48 8d 3d 10 9f 00 00 	lea    0x9f10(%rip),%rdi        # c7f0 <fwp_gc_find_data>
    28e0:	31 f6                	xor    %esi,%esi
    28e2:	e8 59 f7 ff ff       	call   2040 <dl_iterate_phdr@plt>
    28e7:	83 3d 92 19 01 00 00 	cmpl   $0x0,0x11992(%rip)        # 14280 <fwp_gc+0xff0>
    28ee:	0f 95 c1             	setne  %cl
    28f1:	83 3d 28 1b 01 00 00 	cmpl   $0x0,0x11b28(%rip)        # 14420 <fwp_gc+0x1190>
    28f8:	0f 9f c0             	setg   %al
    28fb:	20 c8                	and    %cl,%al
    28fd:	0f b6 c8             	movzbl %al,%ecx
    2900:	89 0d 7e 19 01 00    	mov    %ecx,0x1197e(%rip)        # 14284 <fwp_gc+0xff4>
    2906:	83 3d 7f 19 01 00 00 	cmpl   $0x0,0x1197f(%rip)        # 1428c <fwp_gc+0xffc>
    290d:	74 16                	je     2925 <fwp_gc_start+0x65>
    290f:	48 8d 3d ba 9f 00 00 	lea    0x9fba(%rip),%rdi        # c8d0 <fwp_gc_report>
    2916:	e8 f5 a4 00 00       	call   ce10 <atexit>
    291b:	83 3d 62 19 01 00 00 	cmpl   $0x0,0x11962(%rip)        # 14284 <fwp_gc+0xff4>
    2922:	0f 95 c0             	setne  %al
    2925:	84 c0                	test   %al,%al
    2927:	74 43                	je     296c <fwp_gc_start+0xac>
    2929:	48 83 3d 7f 19 01 00 	cmpq   $0x0,0x1197f(%rip)        # 142b0 <fwp_gc+0x1020>
    2930:	00 
    2931:	74 39                	je     296c <fwp_gc_start+0xac>
    2933:	48 8b 05 66 1b 01 00 	mov    0x11b66(%rip),%rax        # 144a0 <fwp_gc+0x1210>
    293a:	48 2b 05 4f 09 01 00 	sub    0x1094f(%rip),%rax        # 13290 <fwp_gc>
    2941:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    2946:	f2 0f 58 05 2a 1b 01 	addsd  0x11b2a(%rip),%xmm0        # 14478 <fwp_gc+0x11e8>
    294d:	00 
    294e:	f2 0f 11 05 22 1b 01 	movsd  %xmm0,0x11b22(%rip)        # 14478 <fwp_gc+0x11e8>
    2955:	00 
    2956:	48 c7 05 3f 1b 01 00 	movq   $0x0,0x11b3f(%rip)        # 144a0 <fwp_gc+0x1210>
    295d:	00 00 00 00 
    2961:	48 c7 05 24 09 01 00 	movq   $0x0,0x10924(%rip)        # 13290 <fwp_gc>
    2968:	00 00 00 00 
    296c:	5b                   	pop    %rbx
    296d:	c3                   	ret
    296e:	66 90                	xchg   %ax,%ax

0000000000002970 <f1>:
    2970:	53                   	push   %rbx
    2971:	48 83 ec 20          	sub    $0x20,%rsp
    2975:	48 89 fe             	mov    %rdi,%rsi
    2978:	48 8d 5c 24 08       	lea    0x8(%rsp),%rbx
    297d:	48 89 df             	mov    %rbx,%rdi
    2980:	e8 8b a1 00 00       	call   cb10 <w1>
    2985:	bf 03 00 00 00       	mov    $0x3,%edi
    298a:	48 89 de             	mov    %rbx,%rsi
    298d:	e8 9e 09 00 00       	call   3330 <fwp_record>
    2992:	48 89 c3             	mov    %rax,%rbx
    2995:	48 89 c7             	mov    %rax,%rdi
    2998:	e8 53 09 00 00       	call   32f0 <fwp_rc_fresh>
    299d:	48 89 d8             	mov    %rbx,%rax
    29a0:	48 83 c4 20          	add    $0x20,%rsp
    29a4:	5b                   	pop    %rbx
    29a5:	c3                   	ret
    29a6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    29ad:	00 00 00 

00000000000029b0 <fwp_from_f64>:
    29b0:	66 48 0f 7e c0       	movq   %xmm0,%rax
    29b5:	c3                   	ret
    29b6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    29bd:	00 00 00 

00000000000029c0 <fwp_rc_release_last>:
    29c0:	50                   	push   %rax
    29c1:	e8 2a 04 00 00       	call   2df0 <fwp_rc_slot>
    29c6:	48 89 c7             	mov    %rax,%rdi
    29c9:	31 c0                	xor    %eax,%eax
    29cb:	48 85 ff             	test   %rdi,%rdi
    29ce:	74 1a                	je     29ea <fwp_rc_release_last+0x2a>
    29d0:	0f b6 07             	movzbl (%rdi),%eax
    29d3:	85 c0                	test   %eax,%eax
    29d5:	74 13                	je     29ea <fwp_rc_release_last+0x2a>
    29d7:	83 f8 01             	cmp    $0x1,%eax
    29da:	75 07                	jne    29e3 <fwp_rc_release_last+0x23>
    29dc:	b8 01 00 00 00       	mov    $0x1,%eax
    29e1:	59                   	pop    %rcx
    29e2:	c3                   	ret
    29e3:	e8 68 a1 00 00       	call   cb50 <fwp_rc_drop_slot>
    29e8:	31 c0                	xor    %eax,%eax
    29ea:	59                   	pop    %rcx
    29eb:	c3                   	ret
    29ec:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000029f0 <fwp_rc_free_obj>:
    29f0:	41 56                	push   %r14
    29f2:	53                   	push   %rbx
    29f3:	50                   	push   %rax
    29f4:	48 89 fb             	mov    %rdi,%rbx
    29f7:	e8 e4 29 00 00       	call   53e0 <fwp_rc_last>
    29fc:	85 c0                	test   %eax,%eax
    29fe:	0f 84 83 00 00 00    	je     2a87 <fwp_rc_free_obj+0x97>
    2a04:	8b 0d a6 22 01 00    	mov    0x122a6(%rip),%ecx        # 14cb0 <fwp_reuse_verify>
    2a0a:	85 c9                	test   %ecx,%ecx
    2a0c:	78 13                	js     2a21 <fwp_rc_free_obj+0x31>
    2a0e:	85 c9                	test   %ecx,%ecx
    2a10:	74 47                	je     2a59 <fwp_rc_free_obj+0x69>
    2a12:	48 89 df             	mov    %rbx,%rdi
    2a15:	48 83 c4 08          	add    $0x8,%rsp
    2a19:	5b                   	pop    %rbx
    2a1a:	41 5e                	pop    %r14
    2a1c:	e9 7f a1 00 00       	jmp    cba0 <fwp_rc_poison>
    2a21:	48 8d 3d 30 ae 00 00 	lea    0xae30(%rip),%rdi        # d858 <exec_in_fp0+0x1f8>
    2a28:	e8 03 f6 ff ff       	call   2030 <getenv@plt>
    2a2d:	31 c9                	xor    %ecx,%ecx
    2a2f:	48 85 c0             	test   %rax,%rax
    2a32:	74 1b                	je     2a4f <fwp_rc_free_obj+0x5f>
    2a34:	80 38 00             	cmpb   $0x0,(%rax)
    2a37:	74 16                	je     2a4f <fwp_rc_free_obj+0x5f>
    2a39:	48 8d 35 4a b9 00 00 	lea    0xb94a(%rip),%rsi        # e38a <exec_in_fp0+0xd2a>
    2a40:	48 89 c7             	mov    %rax,%rdi
    2a43:	e8 78 f8 ff ff       	call   22c0 <strcmp@plt>
    2a48:	31 c9                	xor    %ecx,%ecx
    2a4a:	85 c0                	test   %eax,%eax
    2a4c:	0f 95 c1             	setne  %cl
    2a4f:	89 0d 5b 22 01 00    	mov    %ecx,0x1225b(%rip)        # 14cb0 <fwp_reuse_verify>
    2a55:	85 c9                	test   %ecx,%ecx
    2a57:	75 b9                	jne    2a12 <fwp_rc_free_obj+0x22>
    2a59:	4c 8b 35 30 08 01 00 	mov    0x10830(%rip),%r14        # 13290 <fwp_gc>
    2a60:	48 89 df             	mov    %rbx,%rdi
    2a63:	e8 98 29 00 00       	call   5400 <fwp_mem_free>
    2a68:	48 8b 05 21 08 01 00 	mov    0x10821(%rip),%rax        # 13290 <fwp_gc>
    2a6f:	4c 29 f0             	sub    %r14,%rax
    2a72:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    2a77:	f2 0f 58 05 19 1a 01 	addsd  0x11a19(%rip),%xmm0        # 14498 <fwp_gc+0x1208>
    2a7e:	00 
    2a7f:	f2 0f 11 05 11 1a 01 	movsd  %xmm0,0x11a11(%rip)        # 14498 <fwp_gc+0x1208>
    2a86:	00 
    2a87:	48 83 c4 08          	add    $0x8,%rsp
    2a8b:	5b                   	pop    %rbx
    2a8c:	41 5e                	pop    %r14
    2a8e:	c3                   	ret
    2a8f:	90                   	nop

0000000000002a90 <e0>:
    2a90:	50                   	push   %rax
    2a91:	48 8b 3f             	mov    (%rdi),%rdi
    2a94:	e8 a7 01 00 00       	call   2c40 <f0>
    2a99:	48 89 c7             	mov    %rax,%rdi
    2a9c:	58                   	pop    %rax
    2a9d:	e9 8e 01 00 00       	jmp    2c30 <fwp_rc_shared>
    2aa2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2aa9:	1f 84 00 00 00 00 00 

0000000000002ab0 <e1>:
    2ab0:	50                   	push   %rax
    2ab1:	48 8b 3f             	mov    (%rdi),%rdi
    2ab4:	e8 b7 fe ff ff       	call   2970 <f1>
    2ab9:	48 89 c7             	mov    %rax,%rdi
    2abc:	58                   	pop    %rax
    2abd:	e9 6e 01 00 00       	jmp    2c30 <fwp_rc_shared>
    2ac2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2ac9:	1f 84 00 00 00 00 00 

0000000000002ad0 <e2>:
    2ad0:	50                   	push   %rax
    2ad1:	48 8b 3f             	mov    (%rdi),%rdi
    2ad4:	e8 b7 2d 00 00       	call   5890 <f2>
    2ad9:	48 89 c7             	mov    %rax,%rdi
    2adc:	58                   	pop    %rax
    2add:	e9 4e 01 00 00       	jmp    2c30 <fwp_rc_shared>
    2ae2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2ae9:	1f 84 00 00 00 00 00 

0000000000002af0 <e4>:
    2af0:	50                   	push   %rax
    2af1:	48 8b 07             	mov    (%rdi),%rax
    2af4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2af8:	48 89 c7             	mov    %rax,%rdi
    2afb:	e8 a0 2d 00 00       	call   58a0 <f4>
    2b00:	48 89 c7             	mov    %rax,%rdi
    2b03:	58                   	pop    %rax
    2b04:	e9 27 01 00 00       	jmp    2c30 <fwp_rc_shared>
    2b09:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002b10 <e8>:
    2b10:	50                   	push   %rax
    2b11:	48 8b 3f             	mov    (%rdi),%rdi
    2b14:	e8 c7 2d 00 00       	call   58e0 <f8>
    2b19:	48 89 c7             	mov    %rax,%rdi
    2b1c:	58                   	pop    %rax
    2b1d:	e9 0e 01 00 00       	jmp    2c30 <fwp_rc_shared>
    2b22:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2b29:	1f 84 00 00 00 00 00 

0000000000002b30 <e10>:
    2b30:	50                   	push   %rax
    2b31:	48 8b 07             	mov    (%rdi),%rax
    2b34:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2b38:	48 89 c7             	mov    %rax,%rdi
    2b3b:	e8 30 08 00 00       	call   3370 <f10>
    2b40:	48 89 c7             	mov    %rax,%rdi
    2b43:	58                   	pop    %rax
    2b44:	e9 e7 00 00 00       	jmp    2c30 <fwp_rc_shared>
    2b49:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002b50 <e12>:
    2b50:	50                   	push   %rax
    2b51:	48 8b 07             	mov    (%rdi),%rax
    2b54:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2b58:	48 89 c7             	mov    %rax,%rdi
    2b5b:	e8 30 08 00 00       	call   3390 <f12>
    2b60:	48 89 c7             	mov    %rax,%rdi
    2b63:	58                   	pop    %rax
    2b64:	e9 c7 00 00 00       	jmp    2c30 <fwp_rc_shared>
    2b69:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002b70 <e14>:
    2b70:	50                   	push   %rax
    2b71:	48 8b 07             	mov    (%rdi),%rax
    2b74:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2b78:	48 89 c7             	mov    %rax,%rdi
    2b7b:	e8 40 08 00 00       	call   33c0 <f14>
    2b80:	48 89 c7             	mov    %rax,%rdi
    2b83:	58                   	pop    %rax
    2b84:	e9 a7 00 00 00       	jmp    2c30 <fwp_rc_shared>
    2b89:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002b90 <e16>:
    2b90:	50                   	push   %rax
    2b91:	48 8b 07             	mov    (%rdi),%rax
    2b94:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2b98:	48 89 c7             	mov    %rax,%rdi
    2b9b:	e8 50 08 00 00       	call   33f0 <f16>
    2ba0:	48 89 c7             	mov    %rax,%rdi
    2ba3:	58                   	pop    %rax
    2ba4:	e9 87 00 00 00       	jmp    2c30 <fwp_rc_shared>
    2ba9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002bb0 <e18>:
    2bb0:	50                   	push   %rax
    2bb1:	48 8b 07             	mov    (%rdi),%rax
    2bb4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2bb8:	48 89 c7             	mov    %rax,%rdi
    2bbb:	e8 70 08 00 00       	call   3430 <f18>
    2bc0:	48 89 c7             	mov    %rax,%rdi
    2bc3:	58                   	pop    %rax
    2bc4:	eb 6a                	jmp    2c30 <fwp_rc_shared>
    2bc6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2bcd:	00 00 00 

0000000000002bd0 <e20>:
    2bd0:	50                   	push   %rax
    2bd1:	48 8b 07             	mov    (%rdi),%rax
    2bd4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2bd8:	48 89 c7             	mov    %rax,%rdi
    2bdb:	e8 a0 08 00 00       	call   3480 <f20>
    2be0:	48 89 c7             	mov    %rax,%rdi
    2be3:	58                   	pop    %rax
    2be4:	eb 4a                	jmp    2c30 <fwp_rc_shared>
    2be6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2bed:	00 00 00 

0000000000002bf0 <e22>:
    2bf0:	50                   	push   %rax
    2bf1:	48 8b 07             	mov    (%rdi),%rax
    2bf4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2bf8:	48 89 c7             	mov    %rax,%rdi
    2bfb:	e8 d0 08 00 00       	call   34d0 <f22>
    2c00:	48 89 c7             	mov    %rax,%rdi
    2c03:	58                   	pop    %rax
    2c04:	eb 2a                	jmp    2c30 <fwp_rc_shared>
    2c06:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2c0d:	00 00 00 

0000000000002c10 <e24>:
    2c10:	50                   	push   %rax
    2c11:	48 8b 07             	mov    (%rdi),%rax
    2c14:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2c18:	48 89 c7             	mov    %rax,%rdi
    2c1b:	e8 10 09 00 00       	call   3530 <f24>
    2c20:	48 89 c7             	mov    %rax,%rdi
    2c23:	58                   	pop    %rax
    2c24:	eb 0a                	jmp    2c30 <fwp_rc_shared>
    2c26:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2c2d:	00 00 00 

0000000000002c30 <fwp_rc_shared>:
    2c30:	53                   	push   %rbx
    2c31:	48 89 fb             	mov    %rdi,%rbx
    2c34:	e8 97 00 00 00       	call   2cd0 <fwp_rc_share>
    2c39:	48 89 d8             	mov    %rbx,%rax
    2c3c:	5b                   	pop    %rbx
    2c3d:	c3                   	ret
    2c3e:	66 90                	xchg   %ax,%ax

0000000000002c40 <f0>:
    2c40:	41 56                	push   %r14
    2c42:	53                   	push   %rbx
    2c43:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    2c4a:	48 89 fe             	mov    %rdi,%rsi
    2c4d:	48 8d 5c 24 40       	lea    0x40(%rsp),%rbx
    2c52:	48 89 df             	mov    %rbx,%rdi
    2c55:	e8 36 03 00 00       	call   2f90 <w0>
    2c5a:	0f 28 44 24 40       	movaps 0x40(%rsp),%xmm0
    2c5f:	0f 28 4c 24 50       	movaps 0x50(%rsp),%xmm1
    2c64:	0f 28 54 24 60       	movaps 0x60(%rsp),%xmm2
    2c69:	0f 28 5c 24 70       	movaps 0x70(%rsp),%xmm3
    2c6e:	0f 29 04 24          	movaps %xmm0,(%rsp)
    2c72:	0f 29 4c 24 10       	movaps %xmm1,0x10(%rsp)
    2c77:	0f 29 54 24 20       	movaps %xmm2,0x20(%rsp)
    2c7c:	0f 29 5c 24 30       	movaps %xmm3,0x30(%rsp)
    2c81:	48 8d 35 18 06 00 00 	lea    0x618(%rip),%rsi        # 32a0 <fwp_owner_release7>
    2c88:	4c 8d b4 24 80 00 00 	lea    0x80(%rsp),%r14
    2c8f:	00 
    2c90:	48 89 e2             	mov    %rsp,%rdx
    2c93:	4c 89 f7             	mov    %r14,%rdi
    2c96:	e8 e5 05 00 00       	call   3280 <fwp_cleanup_push>
    2c9b:	bf 08 00 00 00       	mov    $0x8,%edi
    2ca0:	48 89 de             	mov    %rbx,%rsi
    2ca3:	e8 88 06 00 00       	call   3330 <fwp_record>
    2ca8:	48 89 c3             	mov    %rax,%rbx
    2cab:	48 89 c7             	mov    %rax,%rdi
    2cae:	e8 3d 06 00 00       	call   32f0 <fwp_rc_fresh>
    2cb3:	4c 89 f7             	mov    %r14,%rdi
    2cb6:	e8 95 06 00 00       	call   3350 <fwp_cleanup_pop>
    2cbb:	48 89 d8             	mov    %rbx,%rax
    2cbe:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    2cc5:	5b                   	pop    %rbx
    2cc6:	41 5e                	pop    %r14
    2cc8:	c3                   	ret
    2cc9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002cd0 <fwp_rc_share>:
    2cd0:	41 57                	push   %r15
    2cd2:	41 56                	push   %r14
    2cd4:	41 55                	push   %r13
    2cd6:	41 54                	push   %r12
    2cd8:	53                   	push   %rbx
    2cd9:	48 81 ec 00 02 00 00 	sub    $0x200,%rsp
    2ce0:	48 89 fb             	mov    %rdi,%rbx
    2ce3:	e8 08 01 00 00       	call   2df0 <fwp_rc_slot>
    2ce8:	48 85 c0             	test   %rax,%rax
    2ceb:	0f 84 ec 00 00 00    	je     2ddd <fwp_rc_share+0x10d>
    2cf1:	80 38 00             	cmpb   $0x0,(%rax)
    2cf4:	0f 84 e3 00 00 00    	je     2ddd <fwp_rc_share+0x10d>
    2cfa:	48 89 c7             	mov    %rax,%rdi
    2cfd:	e8 5e 01 00 00       	call   2e60 <fwp_rc_clear_slot>
    2d02:	48 89 1c 24          	mov    %rbx,(%rsp)
    2d06:	41 be 01 00 00 00    	mov    $0x1,%r14d
    2d0c:	eb 0b                	jmp    2d19 <fwp_rc_share+0x49>
    2d0e:	66 90                	xchg   %ax,%ax
    2d10:	4d 85 f6             	test   %r14,%r14
    2d13:	0f 84 c4 00 00 00    	je     2ddd <fwp_rc_share+0x10d>
    2d19:	4e 8b 7c f4 f8       	mov    -0x8(%rsp,%r14,8),%r15
    2d1e:	49 ff ce             	dec    %r14
    2d21:	4c 89 ff             	mov    %r15,%rdi
    2d24:	48 2b 3d 95 15 01 00 	sub    0x11595(%rip),%rdi        # 142c0 <fwp_gc+0x1030>
    2d2b:	48 c1 ef 10          	shr    $0x10,%rdi
    2d2f:	48 8b 05 d2 15 01 00 	mov    0x115d2(%rip),%rax        # 14308 <fwp_gc+0x1078>
    2d36:	48 69 cf 28 12 00 00 	imul   $0x1228,%rdi,%rcx
    2d3d:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    2d42:	74 cc                	je     2d10 <fwp_rc_share+0x40>
    2d44:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    2d48:	80 fa 02             	cmp    $0x2,%dl
    2d4b:	75 13                	jne    2d60 <fwp_rc_share+0x90>
    2d4d:	4c 8b 64 08 18       	mov    0x18(%rax,%rcx,1),%r12
    2d52:	eb 33                	jmp    2d87 <fwp_rc_share+0xb7>
    2d54:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    2d5b:	00 00 00 00 00 
    2d60:	44 8b 64 08 08       	mov    0x8(%rax,%rcx,1),%r12d
    2d65:	80 fa 01             	cmp    $0x1,%dl
    2d68:	75 1d                	jne    2d87 <fwp_rc_share+0xb7>
    2d6a:	41 0f b7 d7          	movzwl %r15w,%edx
    2d6e:	44 8b 7c 08 20       	mov    0x20(%rax,%rcx,1),%r15d
    2d73:	4c 0f af fa          	imul   %rdx,%r15
    2d77:	49 c1 ef 20          	shr    $0x20,%r15
    2d7b:	e8 00 01 00 00       	call   2e80 <fwp_gc_chunk_addr>
    2d80:	4d 0f af fc          	imul   %r12,%r15
    2d84:	49 01 c7             	add    %rax,%r15
    2d87:	49 83 fc 08          	cmp    $0x8,%r12
    2d8b:	72 83                	jb     2d10 <fwp_rc_share+0x40>
    2d8d:	49 c1 ec 03          	shr    $0x3,%r12
    2d91:	45 31 ed             	xor    %r13d,%r13d
    2d94:	eb 16                	jmp    2dac <fwp_rc_share+0xdc>
    2d96:	48 89 df             	mov    %rbx,%rdi
    2d99:	e8 32 ff ff ff       	call   2cd0 <fwp_rc_share>
    2d9e:	66 90                	xchg   %ax,%ax
    2da0:	49 ff c5             	inc    %r13
    2da3:	4d 39 ec             	cmp    %r13,%r12
    2da6:	0f 84 64 ff ff ff    	je     2d10 <fwp_rc_share+0x40>
    2dac:	4b 8b 1c ef          	mov    (%r15,%r13,8),%rbx
    2db0:	48 89 df             	mov    %rbx,%rdi
    2db3:	e8 38 00 00 00       	call   2df0 <fwp_rc_slot>
    2db8:	48 85 c0             	test   %rax,%rax
    2dbb:	74 e3                	je     2da0 <fwp_rc_share+0xd0>
    2dbd:	80 38 00             	cmpb   $0x0,(%rax)
    2dc0:	74 de                	je     2da0 <fwp_rc_share+0xd0>
    2dc2:	49 83 fe 3f          	cmp    $0x3f,%r14
    2dc6:	77 ce                	ja     2d96 <fwp_rc_share+0xc6>
    2dc8:	48 89 c7             	mov    %rax,%rdi
    2dcb:	e8 90 00 00 00       	call   2e60 <fwp_rc_clear_slot>
    2dd0:	4b 8b 04 ef          	mov    (%r15,%r13,8),%rax
    2dd4:	4a 89 04 f4          	mov    %rax,(%rsp,%r14,8)
    2dd8:	49 ff c6             	inc    %r14
    2ddb:	eb c3                	jmp    2da0 <fwp_rc_share+0xd0>
    2ddd:	48 81 c4 00 02 00 00 	add    $0x200,%rsp
    2de4:	5b                   	pop    %rbx
    2de5:	41 5c                	pop    %r12
    2de7:	41 5d                	pop    %r13
    2de9:	41 5e                	pop    %r14
    2deb:	41 5f                	pop    %r15
    2ded:	c3                   	ret
    2dee:	66 90                	xchg   %ax,%ax

0000000000002df0 <fwp_rc_slot>:
    2df0:	48 2b 3d c9 14 01 00 	sub    0x114c9(%rip),%rdi        # 142c0 <fwp_gc+0x1030>
    2df7:	48 8b 05 ea 14 01 00 	mov    0x114ea(%rip),%rax        # 142e8 <fwp_gc+0x1058>
    2dfe:	48 c1 e0 10          	shl    $0x10,%rax
    2e02:	48 39 c7             	cmp    %rax,%rdi
    2e05:	73 51                	jae    2e58 <fwp_rc_slot+0x68>
    2e07:	48 8b 05 fa 14 01 00 	mov    0x114fa(%rip),%rax        # 14308 <fwp_gc+0x1078>
    2e0e:	48 89 f9             	mov    %rdi,%rcx
    2e11:	48 c1 e9 10          	shr    $0x10,%rcx
    2e15:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    2e1c:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    2e20:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    2e27:	75 0f                	jne    2e38 <fwp_rc_slot+0x48>
    2e29:	80 fa 02             	cmp    $0x2,%dl
    2e2c:	75 0a                	jne    2e38 <fwp_rc_slot+0x48>
    2e2e:	48 01 c8             	add    %rcx,%rax
    2e31:	48 05 28 02 00 00    	add    $0x228,%rax
    2e37:	c3                   	ret
    2e38:	80 fa 01             	cmp    $0x1,%dl
    2e3b:	75 1b                	jne    2e58 <fwp_rc_slot+0x68>
    2e3d:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    2e41:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    2e45:	48 0f af f8          	imul   %rax,%rdi
    2e49:	48 c1 ef 20          	shr    $0x20,%rdi
    2e4d:	48 8d 04 17          	lea    (%rdi,%rdx,1),%rax
    2e51:	48 05 28 02 00 00    	add    $0x228,%rax
    2e57:	c3                   	ret
    2e58:	31 c0                	xor    %eax,%eax
    2e5a:	c3                   	ret
    2e5b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000002e60 <fwp_rc_clear_slot>:
    2e60:	80 3f ff             	cmpb   $0xff,(%rdi)
    2e63:	74 04                	je     2e69 <fwp_rc_clear_slot+0x9>
    2e65:	c6 07 00             	movb   $0x0,(%rdi)
    2e68:	c3                   	ret
    2e69:	53                   	push   %rbx
    2e6a:	48 89 fb             	mov    %rdi,%rbx
    2e6d:	e8 1e 00 00 00       	call   2e90 <fwp_rc_forget_slot>
    2e72:	48 89 df             	mov    %rbx,%rdi
    2e75:	5b                   	pop    %rbx
    2e76:	c6 07 00             	movb   $0x0,(%rdi)
    2e79:	c3                   	ret
    2e7a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000002e80 <fwp_gc_chunk_addr>:
    2e80:	48 89 f8             	mov    %rdi,%rax
    2e83:	48 c1 e0 10          	shl    $0x10,%rax
    2e87:	48 03 05 32 14 01 00 	add    0x11432(%rip),%rax        # 142c0 <fwp_gc+0x1030>
    2e8e:	c3                   	ret
    2e8f:	90                   	nop

0000000000002e90 <fwp_rc_forget_slot>:
    2e90:	50                   	push   %rax
    2e91:	80 3f ff             	cmpb   $0xff,(%rdi)
    2e94:	74 02                	je     2e98 <fwp_rc_forget_slot+0x8>
    2e96:	58                   	pop    %rax
    2e97:	c3                   	ret
    2e98:	e8 33 00 00 00       	call   2ed0 <fwp_rc_wide_link>
    2e9d:	48 8b 38             	mov    (%rax),%rdi
    2ea0:	48 85 ff             	test   %rdi,%rdi
    2ea3:	74 15                	je     2eba <fwp_rc_forget_slot+0x2a>
    2ea5:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    2ea9:	48 89 08             	mov    %rcx,(%rax)
    2eac:	e8 9f f1 ff ff       	call   2050 <free@plt>
    2eb1:	48 ff 0d f0 1d 01 00 	decq   0x11df0(%rip)        # 14ca8 <fwp_gc+0x1a18>
    2eb8:	58                   	pop    %rax
    2eb9:	c3                   	ret
    2eba:	48 8d 3d 52 a8 00 00 	lea    0xa852(%rip),%rdi        # d713 <exec_in_fp0+0xb3>
    2ec1:	e8 6a 00 00 00       	call   2f30 <fwp_trap>
    2ec6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2ecd:	00 00 00 

0000000000002ed0 <fwp_rc_wide_link>:
    2ed0:	48 89 f8             	mov    %rdi,%rax
    2ed3:	48 c1 e8 11          	shr    $0x11,%rax
    2ed7:	31 f8                	xor    %edi,%eax
    2ed9:	89 c1                	mov    %eax,%ecx
    2edb:	c1 e9 09             	shr    $0x9,%ecx
    2ede:	31 c1                	xor    %eax,%ecx
    2ee0:	0f b6 c9             	movzbl %cl,%ecx
    2ee3:	48 8d 15 a6 03 01 00 	lea    0x103a6(%rip),%rdx        # 13290 <fwp_gc>
    2eea:	48 8d 04 ca          	lea    (%rdx,%rcx,8),%rax
    2eee:	48 05 18 12 00 00    	add    $0x1218,%rax
    2ef4:	48 8b 8c ca 18 12 00 	mov    0x1218(%rdx,%rcx,8),%rcx
    2efb:	00 
    2efc:	48 85 c9             	test   %rcx,%rcx
    2eff:	74 24                	je     2f25 <fwp_rc_wide_link+0x55>
    2f01:	48 39 39             	cmp    %rdi,(%rcx)
    2f04:	74 1f                	je     2f25 <fwp_rc_wide_link+0x55>
    2f06:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2f0d:	00 00 00 
    2f10:	48 89 c8             	mov    %rcx,%rax
    2f13:	48 8b 49 10          	mov    0x10(%rcx),%rcx
    2f17:	48 85 c9             	test   %rcx,%rcx
    2f1a:	74 05                	je     2f21 <fwp_rc_wide_link+0x51>
    2f1c:	48 39 39             	cmp    %rdi,(%rcx)
    2f1f:	75 ef                	jne    2f10 <fwp_rc_wide_link+0x40>
    2f21:	48 83 c0 10          	add    $0x10,%rax
    2f25:	c3                   	ret
    2f26:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2f2d:	00 00 00 

0000000000002f30 <fwp_trap>:
    2f30:	53                   	push   %rbx
    2f31:	48 89 fb             	mov    %rdi,%rbx
    2f34:	e8 27 00 00 00       	call   2f60 <fwp_flush>
    2f39:	48 8b 05 a0 00 01 00 	mov    0x100a0(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    2f40:	48 8b 38             	mov    (%rax),%rdi
    2f43:	48 8d 35 f0 a7 00 00 	lea    0xa7f0(%rip),%rsi        # d73a <exec_in_fp0+0xda>
    2f4a:	48 89 da             	mov    %rbx,%rdx
    2f4d:	31 c0                	xor    %eax,%eax
    2f4f:	e8 8c f3 ff ff       	call   22e0 <fprintf@plt>
    2f54:	bf 65 00 00 00       	mov    $0x65,%edi
    2f59:	e8 12 f5 ff ff       	call   2470 <exit@plt>
    2f5e:	66 90                	xchg   %ax,%ax

0000000000002f60 <fwp_flush>:
    2f60:	50                   	push   %rax
    2f61:	48 8b 3d 40 1e 01 00 	mov    0x11e40(%rip),%rdi        # 14da8 <fwp_prog_out>
    2f68:	48 85 ff             	test   %rdi,%rdi
    2f6b:	74 05                	je     2f72 <fwp_flush+0x12>
    2f6d:	e8 ce f3 ff ff       	call   2340 <fflush@plt>
    2f72:	48 8b 05 3f 00 01 00 	mov    0x1003f(%rip),%rax        # 12fb8 <stdout@GLIBC_2.2.5>
    2f79:	48 8b 38             	mov    (%rax),%rdi
    2f7c:	58                   	pop    %rax
    2f7d:	e9 be f3 ff ff       	jmp    2340 <fflush@plt>
    2f82:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2f89:	1f 84 00 00 00 00 00 

0000000000002f90 <w0>:
    2f90:	55                   	push   %rbp
    2f91:	41 57                	push   %r15
    2f93:	41 56                	push   %r14
    2f95:	41 55                	push   %r13
    2f97:	41 54                	push   %r12
    2f99:	53                   	push   %rbx
    2f9a:	48 81 ec b8 01 00 00 	sub    $0x1b8,%rsp
    2fa1:	49 89 f6             	mov    %rsi,%r14
    2fa4:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
    2fa9:	48 89 f7             	mov    %rsi,%rdi
    2fac:	48 c7 c6 80 ff ff ff 	mov    $0xffffffffffffff80,%rsi
    2fb3:	e8 b8 03 00 00       	call   3370 <f10>
    2fb8:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    2fbd:	49 89 c7             	mov    %rax,%r15
    2fc0:	48 8d 35 b9 03 00 00 	lea    0x3b9(%rip),%rsi        # 3380 <fwp_owner_release0>
    2fc7:	4c 8d ac 24 a0 01 00 	lea    0x1a0(%rsp),%r13
    2fce:	00 
    2fcf:	48 8d 54 24 30       	lea    0x30(%rsp),%rdx
    2fd4:	4c 89 ef             	mov    %r13,%rdi
    2fd7:	e8 a4 02 00 00       	call   3280 <fwp_cleanup_push>
    2fdc:	be ff 00 00 00       	mov    $0xff,%esi
    2fe1:	4c 89 f7             	mov    %r14,%rdi
    2fe4:	e8 a7 03 00 00       	call   3390 <f12>
    2fe9:	49 89 c4             	mov    %rax,%r12
    2fec:	4c 89 ef             	mov    %r13,%rdi
    2fef:	e8 5c 03 00 00       	call   3350 <fwp_cleanup_pop>
    2ff4:	4c 89 7c 24 38       	mov    %r15,0x38(%rsp)
    2ff9:	4c 89 64 24 40       	mov    %r12,0x40(%rsp)
    2ffe:	48 8d 35 9b 03 00 00 	lea    0x39b(%rip),%rsi        # 33a0 <fwp_owner_release1>
    3005:	4c 8d ac 24 88 01 00 	lea    0x188(%rsp),%r13
    300c:	00 
    300d:	48 8d 54 24 38       	lea    0x38(%rsp),%rdx
    3012:	4c 89 ef             	mov    %r13,%rdi
    3015:	e8 66 02 00 00       	call   3280 <fwp_cleanup_push>
    301a:	4c 89 f7             	mov    %r14,%rdi
    301d:	48 c7 c6 00 80 ff ff 	mov    $0xffffffffffff8000,%rsi
    3024:	e8 97 03 00 00       	call   33c0 <f14>
    3029:	48 89 c5             	mov    %rax,%rbp
    302c:	4c 89 ef             	mov    %r13,%rdi
    302f:	e8 1c 03 00 00       	call   3350 <fwp_cleanup_pop>
    3034:	4c 89 7c 24 48       	mov    %r15,0x48(%rsp)
    3039:	4c 89 64 24 50       	mov    %r12,0x50(%rsp)
    303e:	48 89 6c 24 58       	mov    %rbp,0x58(%rsp)
    3043:	48 8d 35 86 03 00 00 	lea    0x386(%rip),%rsi        # 33d0 <fwp_owner_release2>
    304a:	48 8d 9c 24 70 01 00 	lea    0x170(%rsp),%rbx
    3051:	00 
    3052:	48 8d 54 24 48       	lea    0x48(%rsp),%rdx
    3057:	48 89 df             	mov    %rbx,%rdi
    305a:	e8 21 02 00 00       	call   3280 <fwp_cleanup_push>
    305f:	be ff ff 00 00       	mov    $0xffff,%esi
    3064:	4c 89 f7             	mov    %r14,%rdi
    3067:	e8 84 03 00 00       	call   33f0 <f16>
    306c:	49 89 c5             	mov    %rax,%r13
    306f:	48 89 df             	mov    %rbx,%rdi
    3072:	e8 d9 02 00 00       	call   3350 <fwp_cleanup_pop>
    3077:	4c 89 7c 24 60       	mov    %r15,0x60(%rsp)
    307c:	4c 89 3c 24          	mov    %r15,(%rsp)
    3080:	4c 89 64 24 68       	mov    %r12,0x68(%rsp)
    3085:	4c 89 e3             	mov    %r12,%rbx
    3088:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
    308d:	48 89 6c 24 70       	mov    %rbp,0x70(%rsp)
    3092:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
    3097:	4c 89 6c 24 78       	mov    %r13,0x78(%rsp)
    309c:	48 8d 35 5d 03 00 00 	lea    0x35d(%rip),%rsi        # 3400 <fwp_owner_release3>
    30a3:	48 8d bc 24 40 01 00 	lea    0x140(%rsp),%rdi
    30aa:	00 
    30ab:	48 8d 54 24 60       	lea    0x60(%rsp),%rdx
    30b0:	e8 cb 01 00 00       	call   3280 <fwp_cleanup_push>
    30b5:	4c 89 f7             	mov    %r14,%rdi
    30b8:	48 c7 c6 00 00 00 80 	mov    $0xffffffff80000000,%rsi
    30bf:	e8 6c 03 00 00       	call   3430 <f18>
    30c4:	49 89 c4             	mov    %rax,%r12
    30c7:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    30cc:	48 8d bc 24 40 01 00 	lea    0x140(%rsp),%rdi
    30d3:	00 
    30d4:	e8 77 02 00 00       	call   3350 <fwp_cleanup_pop>
    30d9:	4c 89 bc 24 80 00 00 	mov    %r15,0x80(%rsp)
    30e0:	00 
    30e1:	48 89 9c 24 88 00 00 	mov    %rbx,0x88(%rsp)
    30e8:	00 
    30e9:	48 89 ac 24 90 00 00 	mov    %rbp,0x90(%rsp)
    30f0:	00 
    30f1:	4c 89 ac 24 98 00 00 	mov    %r13,0x98(%rsp)
    30f8:	00 
    30f9:	4c 89 a4 24 a0 00 00 	mov    %r12,0xa0(%rsp)
    3100:	00 
    3101:	48 8d 35 38 03 00 00 	lea    0x338(%rip),%rsi        # 3440 <fwp_owner_release4>
    3108:	4c 8d a4 24 58 01 00 	lea    0x158(%rsp),%r12
    310f:	00 
    3110:	48 8d 94 24 80 00 00 	lea    0x80(%rsp),%rdx
    3117:	00 
    3118:	4c 89 e7             	mov    %r12,%rdi
    311b:	e8 60 01 00 00       	call   3280 <fwp_cleanup_push>
    3120:	b8 00 00 00 80       	mov    $0x80000000,%eax
    3125:	48 8d b0 ff ff ff 7f 	lea    0x7fffffff(%rax),%rsi
    312c:	4c 89 f7             	mov    %r14,%rdi
    312f:	4c 89 f3             	mov    %r14,%rbx
    3132:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    3137:	e8 44 03 00 00       	call   3480 <f20>
    313c:	49 89 c7             	mov    %rax,%r15
    313f:	4c 89 e7             	mov    %r12,%rdi
    3142:	e8 09 02 00 00       	call   3350 <fwp_cleanup_pop>
    3147:	48 8b 04 24          	mov    (%rsp),%rax
    314b:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
    3152:	00 
    3153:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
    3158:	48 89 ac 24 b0 00 00 	mov    %rbp,0xb0(%rsp)
    315f:	00 
    3160:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    3165:	4c 89 a4 24 b8 00 00 	mov    %r12,0xb8(%rsp)
    316c:	00 
    316d:	4c 89 ac 24 c0 00 00 	mov    %r13,0xc0(%rsp)
    3174:	00 
    3175:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
    317a:	4c 89 b4 24 c8 00 00 	mov    %r14,0xc8(%rsp)
    3181:	00 
    3182:	4c 89 bc 24 d0 00 00 	mov    %r15,0xd0(%rsp)
    3189:	00 
    318a:	48 8d 35 ff 02 00 00 	lea    0x2ff(%rip),%rsi        # 3490 <fwp_owner_release5>
    3191:	48 8d bc 24 28 01 00 	lea    0x128(%rsp),%rdi
    3198:	00 
    3199:	48 8d 94 24 a8 00 00 	lea    0xa8(%rsp),%rdx
    31a0:	00 
    31a1:	e8 da 00 00 00       	call   3280 <fwp_cleanup_push>
    31a6:	be 00 00 00 80       	mov    $0x80000000,%esi
    31ab:	48 89 df             	mov    %rbx,%rdi
    31ae:	e8 1d 03 00 00       	call   34d0 <f22>
    31b3:	48 89 c3             	mov    %rax,%rbx
    31b6:	48 8d bc 24 28 01 00 	lea    0x128(%rsp),%rdi
    31bd:	00 
    31be:	e8 8d 01 00 00       	call   3350 <fwp_cleanup_pop>
    31c3:	48 8b 04 24          	mov    (%rsp),%rax
    31c7:	48 89 84 24 d8 00 00 	mov    %rax,0xd8(%rsp)
    31ce:	00 
    31cf:	48 89 ac 24 e0 00 00 	mov    %rbp,0xe0(%rsp)
    31d6:	00 
    31d7:	4c 89 a4 24 e8 00 00 	mov    %r12,0xe8(%rsp)
    31de:	00 
    31df:	4c 89 ac 24 f0 00 00 	mov    %r13,0xf0(%rsp)
    31e6:	00 
    31e7:	4c 89 b4 24 f8 00 00 	mov    %r14,0xf8(%rsp)
    31ee:	00 
    31ef:	4c 89 bc 24 00 01 00 	mov    %r15,0x100(%rsp)
    31f6:	00 
    31f7:	48 89 9c 24 08 01 00 	mov    %rbx,0x108(%rsp)
    31fe:	00 
    31ff:	48 8d 35 da 02 00 00 	lea    0x2da(%rip),%rsi        # 34e0 <fwp_owner_release6>
    3206:	48 8d bc 24 10 01 00 	lea    0x110(%rsp),%rdi
    320d:	00 
    320e:	48 8d 94 24 d8 00 00 	lea    0xd8(%rsp),%rdx
    3215:	00 
    3216:	e8 65 00 00 00       	call   3280 <fwp_cleanup_push>
    321b:	48 be 00 00 00 00 00 	movabs $0x8000000000000000,%rsi
    3222:	00 00 80 
    3225:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    322a:	e8 01 03 00 00       	call   3530 <f24>
    322f:	49 89 c6             	mov    %rax,%r14
    3232:	48 8d bc 24 10 01 00 	lea    0x110(%rsp),%rdi
    3239:	00 
    323a:	e8 11 01 00 00       	call   3350 <fwp_cleanup_pop>
    323f:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    3244:	48 8b 0c 24          	mov    (%rsp),%rcx
    3248:	48 89 08             	mov    %rcx,(%rax)
    324b:	48 89 68 08          	mov    %rbp,0x8(%rax)
    324f:	4c 89 60 10          	mov    %r12,0x10(%rax)
    3253:	4c 89 68 18          	mov    %r13,0x18(%rax)
    3257:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    325c:	48 89 48 20          	mov    %rcx,0x20(%rax)
    3260:	4c 89 78 28          	mov    %r15,0x28(%rax)
    3264:	48 89 58 30          	mov    %rbx,0x30(%rax)
    3268:	4c 89 70 38          	mov    %r14,0x38(%rax)
    326c:	48 81 c4 b8 01 00 00 	add    $0x1b8,%rsp
    3273:	5b                   	pop    %rbx
    3274:	41 5c                	pop    %r12
    3276:	41 5d                	pop    %r13
    3278:	41 5e                	pop    %r14
    327a:	41 5f                	pop    %r15
    327c:	5d                   	pop    %rbp
    327d:	c3                   	ret
    327e:	66 90                	xchg   %ax,%ax

0000000000003280 <fwp_cleanup_push>:
    3280:	48 8b 05 51 1b 01 00 	mov    0x11b51(%rip),%rax        # 14dd8 <fwp_cleanups>
    3287:	48 89 07             	mov    %rax,(%rdi)
    328a:	48 89 77 08          	mov    %rsi,0x8(%rdi)
    328e:	48 89 57 10          	mov    %rdx,0x10(%rdi)
    3292:	48 89 3d 3f 1b 01 00 	mov    %rdi,0x11b3f(%rip)        # 14dd8 <fwp_cleanups>
    3299:	c3                   	ret
    329a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000032a0 <fwp_owner_release7>:
    32a0:	53                   	push   %rbx
    32a1:	48 89 fb             	mov    %rdi,%rbx
    32a4:	48 8b 3f             	mov    (%rdi),%rdi
    32a7:	e8 74 20 00 00       	call   5320 <fwp_drop0>
    32ac:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    32b0:	e8 2b 23 00 00       	call   55e0 <fwp_drop1>
    32b5:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    32b9:	e8 42 23 00 00       	call   5600 <fwp_drop2>
    32be:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    32c2:	e8 59 23 00 00       	call   5620 <fwp_drop3>
    32c7:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    32cb:	e8 70 23 00 00       	call   5640 <fwp_drop4>
    32d0:	48 8b 7b 28          	mov    0x28(%rbx),%rdi
    32d4:	e8 87 23 00 00       	call   5660 <fwp_drop5>
    32d9:	48 8b 7b 30          	mov    0x30(%rbx),%rdi
    32dd:	e8 9e 23 00 00       	call   5680 <fwp_drop6>
    32e2:	48 8b 7b 38          	mov    0x38(%rbx),%rdi
    32e6:	5b                   	pop    %rbx
    32e7:	e9 b4 23 00 00       	jmp    56a0 <fwp_drop7>
    32ec:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000032f0 <fwp_rc_fresh>:
    32f0:	41 56                	push   %r14
    32f2:	53                   	push   %rbx
    32f3:	50                   	push   %rax
    32f4:	48 89 fb             	mov    %rdi,%rbx
    32f7:	e8 f4 fa ff ff       	call   2df0 <fwp_rc_slot>
    32fc:	48 85 c0             	test   %rax,%rax
    32ff:	74 08                	je     3309 <fwp_rc_fresh+0x19>
    3301:	80 38 ff             	cmpb   $0xff,(%rax)
    3304:	74 0e                	je     3314 <fwp_rc_fresh+0x24>
    3306:	c6 00 01             	movb   $0x1,(%rax)
    3309:	48 89 d8             	mov    %rbx,%rax
    330c:	48 83 c4 08          	add    $0x8,%rsp
    3310:	5b                   	pop    %rbx
    3311:	41 5e                	pop    %r14
    3313:	c3                   	ret
    3314:	48 89 c7             	mov    %rax,%rdi
    3317:	49 89 c6             	mov    %rax,%r14
    331a:	e8 71 fb ff ff       	call   2e90 <fwp_rc_forget_slot>
    331f:	4c 89 f0             	mov    %r14,%rax
    3322:	eb e2                	jmp    3306 <fwp_rc_fresh+0x16>
    3324:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    332b:	00 00 00 00 00 

0000000000003330 <fwp_record>:
    3330:	85 ff                	test   %edi,%edi
    3332:	74 0c                	je     3340 <fwp_record+0x10>
    3334:	48 89 f2             	mov    %rsi,%rdx
    3337:	89 fe                	mov    %edi,%esi
    3339:	31 ff                	xor    %edi,%edi
    333b:	e9 80 23 00 00       	jmp    56c0 <fwp_data>
    3340:	31 c0                	xor    %eax,%eax
    3342:	c3                   	ret
    3343:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    334a:	84 00 00 00 00 00 

0000000000003350 <fwp_cleanup_pop>:
    3350:	48 39 3d 81 1a 01 00 	cmp    %rdi,0x11a81(%rip)        # 14dd8 <fwp_cleanups>
    3357:	75 0b                	jne    3364 <fwp_cleanup_pop+0x14>
    3359:	48 8b 07             	mov    (%rdi),%rax
    335c:	48 89 05 75 1a 01 00 	mov    %rax,0x11a75(%rip)        # 14dd8 <fwp_cleanups>
    3363:	c3                   	ret
    3364:	50                   	push   %rax
    3365:	e8 06 ed ff ff       	call   2070 <abort@plt>
    336a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000003370 <f10>:
    3370:	e9 cb 01 00 00       	jmp    3540 <fwp_p_array_make_typed>
    3375:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    337c:	00 00 00 00 

0000000000003380 <fwp_owner_release0>:
    3380:	48 8b 3f             	mov    (%rdi),%rdi
    3383:	e9 98 1f 00 00       	jmp    5320 <fwp_drop0>
    3388:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    338f:	00 

0000000000003390 <f12>:
    3390:	e9 ab 01 00 00       	jmp    3540 <fwp_p_array_make_typed>
    3395:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    339c:	00 00 00 00 

00000000000033a0 <fwp_owner_release1>:
    33a0:	53                   	push   %rbx
    33a1:	48 89 fb             	mov    %rdi,%rbx
    33a4:	48 8b 3f             	mov    (%rdi),%rdi
    33a7:	e8 74 1f 00 00       	call   5320 <fwp_drop0>
    33ac:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    33b0:	5b                   	pop    %rbx
    33b1:	e9 2a 22 00 00       	jmp    55e0 <fwp_drop1>
    33b6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    33bd:	00 00 00 

00000000000033c0 <f14>:
    33c0:	e9 7b 01 00 00       	jmp    3540 <fwp_p_array_make_typed>
    33c5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    33cc:	00 00 00 00 

00000000000033d0 <fwp_owner_release2>:
    33d0:	53                   	push   %rbx
    33d1:	48 89 fb             	mov    %rdi,%rbx
    33d4:	48 8b 3f             	mov    (%rdi),%rdi
    33d7:	e8 44 1f 00 00       	call   5320 <fwp_drop0>
    33dc:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    33e0:	e8 fb 21 00 00       	call   55e0 <fwp_drop1>
    33e5:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    33e9:	5b                   	pop    %rbx
    33ea:	e9 11 22 00 00       	jmp    5600 <fwp_drop2>
    33ef:	90                   	nop

00000000000033f0 <f16>:
    33f0:	e9 4b 01 00 00       	jmp    3540 <fwp_p_array_make_typed>
    33f5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    33fc:	00 00 00 00 

0000000000003400 <fwp_owner_release3>:
    3400:	53                   	push   %rbx
    3401:	48 89 fb             	mov    %rdi,%rbx
    3404:	48 8b 3f             	mov    (%rdi),%rdi
    3407:	e8 14 1f 00 00       	call   5320 <fwp_drop0>
    340c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    3410:	e8 cb 21 00 00       	call   55e0 <fwp_drop1>
    3415:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    3419:	e8 e2 21 00 00       	call   5600 <fwp_drop2>
    341e:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    3422:	5b                   	pop    %rbx
    3423:	e9 f8 21 00 00       	jmp    5620 <fwp_drop3>
    3428:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    342f:	00 

0000000000003430 <f18>:
    3430:	e9 0b 01 00 00       	jmp    3540 <fwp_p_array_make_typed>
    3435:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    343c:	00 00 00 00 

0000000000003440 <fwp_owner_release4>:
    3440:	53                   	push   %rbx
    3441:	48 89 fb             	mov    %rdi,%rbx
    3444:	48 8b 3f             	mov    (%rdi),%rdi
    3447:	e8 d4 1e 00 00       	call   5320 <fwp_drop0>
    344c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    3450:	e8 8b 21 00 00       	call   55e0 <fwp_drop1>
    3455:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    3459:	e8 a2 21 00 00       	call   5600 <fwp_drop2>
    345e:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    3462:	e8 b9 21 00 00       	call   5620 <fwp_drop3>
    3467:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    346b:	5b                   	pop    %rbx
    346c:	e9 cf 21 00 00       	jmp    5640 <fwp_drop4>
    3471:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3478:	0f 1f 84 00 00 00 00 
    347f:	00 

0000000000003480 <f20>:
    3480:	e9 bb 00 00 00       	jmp    3540 <fwp_p_array_make_typed>
    3485:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    348c:	00 00 00 00 

0000000000003490 <fwp_owner_release5>:
    3490:	53                   	push   %rbx
    3491:	48 89 fb             	mov    %rdi,%rbx
    3494:	48 8b 3f             	mov    (%rdi),%rdi
    3497:	e8 84 1e 00 00       	call   5320 <fwp_drop0>
    349c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    34a0:	e8 3b 21 00 00       	call   55e0 <fwp_drop1>
    34a5:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    34a9:	e8 52 21 00 00       	call   5600 <fwp_drop2>
    34ae:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    34b2:	e8 69 21 00 00       	call   5620 <fwp_drop3>
    34b7:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    34bb:	e8 80 21 00 00       	call   5640 <fwp_drop4>
    34c0:	48 8b 7b 28          	mov    0x28(%rbx),%rdi
    34c4:	5b                   	pop    %rbx
    34c5:	e9 96 21 00 00       	jmp    5660 <fwp_drop5>
    34ca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000034d0 <f22>:
    34d0:	eb 6e                	jmp    3540 <fwp_p_array_make_typed>
    34d2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    34d9:	1f 84 00 00 00 00 00 

00000000000034e0 <fwp_owner_release6>:
    34e0:	53                   	push   %rbx
    34e1:	48 89 fb             	mov    %rdi,%rbx
    34e4:	48 8b 3f             	mov    (%rdi),%rdi
    34e7:	e8 34 1e 00 00       	call   5320 <fwp_drop0>
    34ec:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    34f0:	e8 eb 20 00 00       	call   55e0 <fwp_drop1>
    34f5:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    34f9:	e8 02 21 00 00       	call   5600 <fwp_drop2>
    34fe:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    3502:	e8 19 21 00 00       	call   5620 <fwp_drop3>
    3507:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    350b:	e8 30 21 00 00       	call   5640 <fwp_drop4>
    3510:	48 8b 7b 28          	mov    0x28(%rbx),%rdi
    3514:	e8 47 21 00 00       	call   5660 <fwp_drop5>
    3519:	48 8b 7b 30          	mov    0x30(%rbx),%rdi
    351d:	5b                   	pop    %rbx
    351e:	e9 5d 21 00 00       	jmp    5680 <fwp_drop6>
    3523:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    352a:	84 00 00 00 00 00 

0000000000003530 <f24>:
    3530:	eb 0e                	jmp    3540 <fwp_p_array_make_typed>
    3532:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3539:	1f 84 00 00 00 00 00 

0000000000003540 <fwp_p_array_make_typed>:
    3540:	41 56                	push   %r14
    3542:	53                   	push   %rbx
    3543:	50                   	push   %rax
    3544:	48 89 f3             	mov    %rsi,%rbx
    3547:	e8 64 00 00 00       	call   35b0 <fwp_count_arg>
    354c:	49 89 c6             	mov    %rax,%r14
    354f:	48 89 c7             	mov    %rax,%rdi
    3552:	e8 69 00 00 00       	call   35c0 <fwp_array_typed_new>
    3557:	4d 85 f6             	test   %r14,%r14
    355a:	74 48                	je     35a4 <fwp_p_array_make_typed+0x64>
    355c:	49 83 fe 04          	cmp    $0x4,%r14
    3560:	73 04                	jae    3566 <fwp_p_array_make_typed+0x26>
    3562:	31 c9                	xor    %ecx,%ecx
    3564:	eb 31                	jmp    3597 <fwp_p_array_make_typed+0x57>
    3566:	4c 89 f1             	mov    %r14,%rcx
    3569:	48 83 e1 fc          	and    $0xfffffffffffffffc,%rcx
    356d:	66 48 0f 6e c3       	movq   %rbx,%xmm0
    3572:	66 0f 70 c0 44       	pshufd $0x44,%xmm0,%xmm0
    3577:	31 d2                	xor    %edx,%edx
    3579:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    3580:	f3 0f 7f 44 d0 08    	movdqu %xmm0,0x8(%rax,%rdx,8)
    3586:	f3 0f 7f 44 d0 18    	movdqu %xmm0,0x18(%rax,%rdx,8)
    358c:	48 83 c2 04          	add    $0x4,%rdx
    3590:	48 39 d1             	cmp    %rdx,%rcx
    3593:	75 eb                	jne    3580 <fwp_p_array_make_typed+0x40>
    3595:	eb 08                	jmp    359f <fwp_p_array_make_typed+0x5f>
    3597:	48 89 5c c8 08       	mov    %rbx,0x8(%rax,%rcx,8)
    359c:	48 ff c1             	inc    %rcx
    359f:	49 39 ce             	cmp    %rcx,%r14
    35a2:	75 f3                	jne    3597 <fwp_p_array_make_typed+0x57>
    35a4:	48 83 c4 08          	add    $0x8,%rsp
    35a8:	5b                   	pop    %rbx
    35a9:	41 5e                	pop    %r14
    35ab:	c3                   	ret
    35ac:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000035b0 <fwp_count_arg>:
    35b0:	31 c0                	xor    %eax,%eax
    35b2:	48 85 ff             	test   %rdi,%rdi
    35b5:	48 0f 4f c7          	cmovg  %rdi,%rax
    35b9:	c3                   	ret
    35ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000035c0 <fwp_array_typed_new>:
    35c0:	50                   	push   %rax
    35c1:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    35c8:	ff ff 1f 
    35cb:	48 39 c7             	cmp    %rax,%rdi
    35ce:	73 0e                	jae    35de <fwp_array_typed_new+0x1e>
    35d0:	e8 1b 00 00 00       	call   35f0 <fwp_arr_new>
    35d5:	48 89 c7             	mov    %rax,%rdi
    35d8:	58                   	pop    %rax
    35d9:	e9 12 fd ff ff       	jmp    32f0 <fwp_rc_fresh>
    35de:	48 8d 3d 64 a1 00 00 	lea    0xa164(%rip),%rdi        # d749 <exec_in_fp0+0xe9>
    35e5:	e8 46 f9 ff ff       	call   2f30 <fwp_trap>
    35ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000035f0 <fwp_arr_new>:
    35f0:	53                   	push   %rbx
    35f1:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    35f8:	ff ff 1f 
    35fb:	48 39 c7             	cmp    %rax,%rdi
    35fe:	73 15                	jae    3615 <fwp_arr_new+0x25>
    3600:	48 89 fb             	mov    %rdi,%rbx
    3603:	48 8d 3c fd 08 00 00 	lea    0x8(,%rdi,8),%rdi
    360a:	00 
    360b:	e8 20 00 00 00       	call   3630 <fwp_alloc>
    3610:	48 89 18             	mov    %rbx,(%rax)
    3613:	5b                   	pop    %rbx
    3614:	c3                   	ret
    3615:	48 8d 3d 2d a1 00 00 	lea    0xa12d(%rip),%rdi        # d749 <exec_in_fp0+0xe9>
    361c:	e8 0f f9 ff ff       	call   2f30 <fwp_trap>
    3621:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3628:	0f 1f 84 00 00 00 00 
    362f:	00 

0000000000003630 <fwp_alloc>:
    3630:	be 02 00 00 00       	mov    $0x2,%esi
    3635:	eb 09                	jmp    3640 <fwp_gc_alloc>
    3637:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    363e:	00 00 

0000000000003640 <fwp_gc_alloc>:
    3640:	53                   	push   %rbx
    3641:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    3648:	77 6c                	ja     36b6 <fwp_gc_alloc+0x76>
    364a:	48 8d 4f 0f          	lea    0xf(%rdi),%rcx
    364e:	48 c1 e9 04          	shr    $0x4,%rcx
    3652:	48 8d 05 37 fc 00 00 	lea    0xfc37(%rip),%rax        # 13290 <fwp_gc>
    3659:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    3660:	00 
    3661:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    3668:	48 29 15 21 fc 00 00 	sub    %rdx,0xfc21(%rip)        # 13290 <fwp_gc>
    366f:	78 45                	js     36b6 <fwp_gc_alloc+0x76>
    3671:	41 89 f0             	mov    %esi,%r8d
    3674:	4d 69 c0 c0 03 00 00 	imul   $0x3c0,%r8,%r8
    367b:	4c 01 c0             	add    %r8,%rax
    367e:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    3682:	4c 8d 04 c8          	lea    (%rax,%rcx,8),%r8
    3686:	49 83 c0 08          	add    $0x8,%r8
    368a:	49 8b 18             	mov    (%r8),%rbx
    368d:	48 85 db             	test   %rbx,%rbx
    3690:	74 12                	je     36a4 <fwp_gc_alloc+0x64>
    3692:	48 8b 03             	mov    (%rbx),%rax
    3695:	48 f7 d0             	not    %rax
    3698:	49 89 00             	mov    %rax,(%r8)
    369b:	83 fe 01             	cmp    $0x1,%esi
    369e:	48 0f 44 d7          	cmove  %rdi,%rdx
    36a2:	eb 2e                	jmp    36d2 <fwp_gc_alloc+0x92>
    36a4:	48 8b 5c c8 10       	mov    0x10(%rax,%rcx,8),%rbx
    36a9:	4c 8b 44 c8 18       	mov    0x18(%rax,%rcx,8),%r8
    36ae:	49 29 d8             	sub    %rbx,%r8
    36b1:	49 39 d0             	cmp    %rdx,%r8
    36b4:	73 03                	jae    36b9 <fwp_gc_alloc+0x79>
    36b6:	5b                   	pop    %rbx
    36b7:	eb 37                	jmp    36f0 <fwp_gc_alloc_slow>
    36b9:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    36bd:	48 83 c0 10          	add    $0x10,%rax
    36c1:	48 8d 0c 13          	lea    (%rbx,%rdx,1),%rcx
    36c5:	48 89 08             	mov    %rcx,(%rax)
    36c8:	83 fe 01             	cmp    $0x1,%esi
    36cb:	48 0f 45 fa          	cmovne %rdx,%rdi
    36cf:	48 89 fa             	mov    %rdi,%rdx
    36d2:	48 89 df             	mov    %rbx,%rdi
    36d5:	31 f6                	xor    %esi,%esi
    36d7:	e8 24 eb ff ff       	call   2200 <memset@plt>
    36dc:	48 89 d8             	mov    %rbx,%rax
    36df:	5b                   	pop    %rbx
    36e0:	c3                   	ret
    36e1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    36e8:	0f 1f 84 00 00 00 00 
    36ef:	00 

00000000000036f0 <fwp_gc_alloc_slow>:
    36f0:	55                   	push   %rbp
    36f1:	41 57                	push   %r15
    36f3:	41 56                	push   %r14
    36f5:	41 54                	push   %r12
    36f7:	53                   	push   %rbx
    36f8:	89 f5                	mov    %esi,%ebp
    36fa:	48 89 fb             	mov    %rdi,%rbx
    36fd:	83 3d 78 0b 01 00 00 	cmpl   $0x0,0x10b78(%rip)        # 1427c <fwp_gc+0xfec>
    3704:	74 1b                	je     3721 <fwp_gc_alloc_slow+0x31>
    3706:	48 81 fb 01 40 00 00 	cmp    $0x4001,%rbx
    370d:	72 20                	jb     372f <fwp_gc_alloc_slow+0x3f>
    370f:	48 89 df             	mov    %rbx,%rdi
    3712:	89 ee                	mov    %ebp,%esi
    3714:	5b                   	pop    %rbx
    3715:	41 5c                	pop    %r12
    3717:	41 5e                	pop    %r14
    3719:	41 5f                	pop    %r15
    371b:	5d                   	pop    %rbp
    371c:	e9 9f 03 00 00       	jmp    3ac0 <fwp_gc_alloc_big>
    3721:	e8 ba 00 00 00       	call   37e0 <fwp_gc_init>
    3726:	48 81 fb 01 40 00 00 	cmp    $0x4001,%rbx
    372d:	73 e0                	jae    370f <fwp_gc_alloc_slow+0x1f>
    372f:	48 8d 43 0f          	lea    0xf(%rbx),%rax
    3733:	48 c1 e8 04          	shr    $0x4,%rax
    3737:	4c 8d 25 52 fb 00 00 	lea    0xfb52(%rip),%r12        # 13290 <fwp_gc>
    373e:	46 0f b6 bc 20 e8 0b 	movzbl 0xbe8(%rax,%r12,1),%r15d
    3745:	00 00 
    3747:	47 8b b4 bc 48 0b 00 	mov    0xb48(%r12,%r15,4),%r14d
    374e:	00 
    374f:	48 83 3d 39 fb 00 00 	cmpq   $0x0,0xfb39(%rip)        # 13290 <fwp_gc>
    3756:	00 
    3757:	79 05                	jns    375e <fwp_gc_alloc_slow+0x6e>
    3759:	e8 b2 04 00 00       	call   3c10 <fwp_gc_spent>
    375e:	89 e8                	mov    %ebp,%eax
    3760:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    3767:	49 01 c4             	add    %rax,%r12
    376a:	4b 8d 0c 7f          	lea    (%r15,%r15,2),%rcx
    376e:	49 8d 04 cc          	lea    (%r12,%rcx,8),%rax
    3772:	48 83 c0 08          	add    $0x8,%rax
    3776:	49 8b 7c cc 08       	mov    0x8(%r12,%rcx,8),%rdi
    377b:	48 85 ff             	test   %rdi,%rdi
    377e:	74 08                	je     3788 <fwp_gc_alloc_slow+0x98>
    3780:	48 8b 0f             	mov    (%rdi),%rcx
    3783:	48 f7 d1             	not    %rcx
    3786:	eb 30                	jmp    37b8 <fwp_gc_alloc_slow+0xc8>
    3788:	49 8b 7c cc 10       	mov    0x10(%r12,%rcx,8),%rdi
    378d:	49 8b 54 cc 18       	mov    0x18(%r12,%rcx,8),%rdx
    3792:	48 29 fa             	sub    %rdi,%rdx
    3795:	4c 39 f2             	cmp    %r14,%rdx
    3798:	73 12                	jae    37ac <fwp_gc_alloc_slow+0xbc>
    379a:	48 89 c7             	mov    %rax,%rdi
    379d:	44 89 fe             	mov    %r15d,%esi
    37a0:	89 ea                	mov    %ebp,%edx
    37a2:	e8 39 05 00 00       	call   3ce0 <fwp_gc_refill>
    37a7:	48 89 c7             	mov    %rax,%rdi
    37aa:	eb 0f                	jmp    37bb <fwp_gc_alloc_slow+0xcb>
    37ac:	49 8d 04 cc          	lea    (%r12,%rcx,8),%rax
    37b0:	48 83 c0 10          	add    $0x10,%rax
    37b4:	4a 8d 0c 37          	lea    (%rdi,%r14,1),%rcx
    37b8:	48 89 08             	mov    %rcx,(%rax)
    37bb:	83 fd 01             	cmp    $0x1,%ebp
    37be:	4c 0f 44 f3          	cmove  %rbx,%r14
    37c2:	31 f6                	xor    %esi,%esi
    37c4:	4c 89 f2             	mov    %r14,%rdx
    37c7:	5b                   	pop    %rbx
    37c8:	41 5c                	pop    %r12
    37ca:	41 5e                	pop    %r14
    37cc:	41 5f                	pop    %r15
    37ce:	5d                   	pop    %rbp
    37cf:	e9 2c ea ff ff       	jmp    2200 <memset@plt>
    37d4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    37db:	00 00 00 00 00 

00000000000037e0 <fwp_gc_init>:
    37e0:	53                   	push   %rbx
    37e1:	48 83 ec 10          	sub    $0x10,%rsp
    37e5:	c7 05 8d 0a 01 00 01 	movl   $0x1,0x10a8d(%rip)        # 1427c <fwp_gc+0xfec>
    37ec:	00 00 00 
    37ef:	0f 28 05 5a 98 00 00 	movaps 0x985a(%rip),%xmm0        # d050 <_IO_stdin_used+0x50>
    37f6:	0f 11 05 db 05 01 00 	movups %xmm0,0x105db(%rip)        # 13dd8 <fwp_gc+0xb48>
    37fd:	0f 28 05 5c 98 00 00 	movaps 0x985c(%rip),%xmm0        # d060 <_IO_stdin_used+0x60>
    3804:	0f 11 05 dd 05 01 00 	movups %xmm0,0x105dd(%rip)        # 13de8 <fwp_gc+0xb58>
    380b:	0f 28 05 5e 98 00 00 	movaps 0x985e(%rip),%xmm0        # d070 <_IO_stdin_used+0x70>
    3812:	0f 11 05 df 05 01 00 	movups %xmm0,0x105df(%rip)        # 13df8 <fwp_gc+0xb68>
    3819:	0f 28 05 60 98 00 00 	movaps 0x9860(%rip),%xmm0        # d080 <_IO_stdin_used+0x80>
    3820:	0f 11 05 e1 05 01 00 	movups %xmm0,0x105e1(%rip)        # 13e08 <fwp_gc+0xb78>
    3827:	0f 28 05 62 98 00 00 	movaps 0x9862(%rip),%xmm0        # d090 <_IO_stdin_used+0x90>
    382e:	0f 11 05 e3 05 01 00 	movups %xmm0,0x105e3(%rip)        # 13e18 <fwp_gc+0xb88>
    3835:	0f 28 05 64 98 00 00 	movaps 0x9864(%rip),%xmm0        # d0a0 <_IO_stdin_used+0xa0>
    383c:	0f 11 05 e5 05 01 00 	movups %xmm0,0x105e5(%rip)        # 13e28 <fwp_gc+0xb98>
    3843:	0f 28 05 66 98 00 00 	movaps 0x9866(%rip),%xmm0        # d0b0 <_IO_stdin_used+0xb0>
    384a:	0f 11 05 e7 05 01 00 	movups %xmm0,0x105e7(%rip)        # 13e38 <fwp_gc+0xba8>
    3851:	0f 28 05 68 98 00 00 	movaps 0x9868(%rip),%xmm0        # d0c0 <_IO_stdin_used+0xc0>
    3858:	0f 11 05 e9 05 01 00 	movups %xmm0,0x105e9(%rip)        # 13e48 <fwp_gc+0xbb8>
    385f:	0f 28 05 6a 98 00 00 	movaps 0x986a(%rip),%xmm0        # d0d0 <_IO_stdin_used+0xd0>
    3866:	0f 11 05 eb 05 01 00 	movups %xmm0,0x105eb(%rip)        # 13e58 <fwp_gc+0xbc8>
    386d:	0f 28 05 6c 98 00 00 	movaps 0x986c(%rip),%xmm0        # d0e0 <_IO_stdin_used+0xe0>
    3874:	0f 11 05 ed 05 01 00 	movups %xmm0,0x105ed(%rip)        # 13e68 <fwp_gc+0xbd8>
    387b:	31 c9                	xor    %ecx,%ecx
    387d:	48 8d 05 0c fa 00 00 	lea    0xfa0c(%rip),%rax        # 13290 <fwp_gc>
    3884:	31 d2                	xor    %edx,%edx
    3886:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    388d:	00 00 00 
    3890:	89 d6                	mov    %edx,%esi
    3892:	c1 e6 04             	shl    $0x4,%esi
    3895:	48 ff c9             	dec    %rcx
    3898:	48 89 cf             	mov    %rcx,%rdi
    389b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    38a0:	48 89 f9             	mov    %rdi,%rcx
    38a3:	48 ff c7             	inc    %rdi
    38a6:	3b b4 88 4c 0b 00 00 	cmp    0xb4c(%rax,%rcx,4),%esi
    38ad:	77 f1                	ja     38a0 <fwp_gc_init+0xc0>
    38af:	40 88 bc 02 e8 0b 00 	mov    %dil,0xbe8(%rdx,%rax,1)
    38b6:	00 
    38b7:	48 89 d6             	mov    %rdx,%rsi
    38ba:	48 83 ce 01          	or     $0x1,%rsi
    38be:	48 81 fe 01 04 00 00 	cmp    $0x401,%rsi
    38c5:	74 26                	je     38ed <fwp_gc_init+0x10d>
    38c7:	89 f7                	mov    %esi,%edi
    38c9:	c1 e7 04             	shl    $0x4,%edi
    38cc:	0f 1f 40 00          	nopl   0x0(%rax)
    38d0:	49 89 c8             	mov    %rcx,%r8
    38d3:	48 ff c1             	inc    %rcx
    38d6:	42 3b bc 80 4c 0b 00 	cmp    0xb4c(%rax,%r8,4),%edi
    38dd:	00 
    38de:	77 f0                	ja     38d0 <fwp_gc_init+0xf0>
    38e0:	88 8c 06 e8 0b 00 00 	mov    %cl,0xbe8(%rsi,%rax,1)
    38e7:	48 83 c2 02          	add    $0x2,%rdx
    38eb:	eb a3                	jmp    3890 <fwp_gc_init+0xb0>
    38ed:	48 b8 00 00 00 00 10 	movabs $0x1000000000,%rax
    38f4:	00 00 00 
    38f7:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    38fc:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    3901:	e8 ba 04 00 00       	call   3dc0 <fwp_gc_reserve>
    3906:	48 85 c0             	test   %rax,%rax
    3909:	0f 84 ab 01 00 00    	je     3aba <fwp_gc_init+0x2da>
    390f:	48 89 05 b2 09 01 00 	mov    %rax,0x109b2(%rip)        # 142c8 <fwp_gc+0x1038>
    3916:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    391b:	48 8d 91 00 00 01 00 	lea    0x10000(%rcx),%rdx
    3922:	48 89 15 a7 09 01 00 	mov    %rdx,0x109a7(%rip)        # 142d0 <fwp_gc+0x1040>
    3929:	48 05 ff ff 00 00    	add    $0xffff,%rax
    392f:	48 25 00 00 ff ff    	and    $0xffffffffffff0000,%rax
    3935:	48 89 05 84 09 01 00 	mov    %rax,0x10984(%rip)        # 142c0 <fwp_gc+0x1030>
    393c:	48 c1 e9 10          	shr    $0x10,%rcx
    3940:	48 89 0d 99 09 01 00 	mov    %rcx,0x10999(%rip)        # 142e0 <fwp_gc+0x1050>
    3947:	48 69 f1 28 12 00 00 	imul   $0x1228,%rcx,%rsi
    394e:	48 89 35 bb 09 01 00 	mov    %rsi,0x109bb(%rip)        # 14310 <fwp_gc+0x1080>
    3955:	31 ff                	xor    %edi,%edi
    3957:	31 d2                	xor    %edx,%edx
    3959:	b9 22 40 00 00       	mov    $0x4022,%ecx
    395e:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    3964:	45 31 c9             	xor    %r9d,%r9d
    3967:	e8 14 e8 ff ff       	call   2180 <mmap@plt>
    396c:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    3970:	0f 84 44 01 00 00    	je     3aba <fwp_gc_init+0x2da>
    3976:	48 89 05 8b 09 01 00 	mov    %rax,0x1098b(%rip)        # 14308 <fwp_gc+0x1078>
    397d:	48 8d 3d d5 9d 00 00 	lea    0x9dd5(%rip),%rdi        # d759 <exec_in_fp0+0xf9>
    3984:	e8 a7 e6 ff ff       	call   2030 <getenv@plt>
    3989:	48 85 c0             	test   %rax,%rax
    398c:	74 2e                	je     39bc <fwp_gc_init+0x1dc>
    398e:	48 89 c3             	mov    %rax,%rbx
    3991:	48 8d 35 c8 9d 00 00 	lea    0x9dc8(%rip),%rsi        # d760 <exec_in_fp0+0x100>
    3998:	48 89 c7             	mov    %rax,%rdi
    399b:	e8 20 e9 ff ff       	call   22c0 <strcmp@plt>
    39a0:	85 c0                	test   %eax,%eax
    39a2:	74 1f                	je     39c3 <fwp_gc_init+0x1e3>
    39a4:	48 8d 35 df a9 00 00 	lea    0xa9df(%rip),%rsi        # e38a <exec_in_fp0+0xd2a>
    39ab:	48 89 df             	mov    %rbx,%rdi
    39ae:	e8 0d e9 ff ff       	call   22c0 <strcmp@plt>
    39b3:	31 c9                	xor    %ecx,%ecx
    39b5:	85 c0                	test   %eax,%eax
    39b7:	0f 95 c1             	setne  %cl
    39ba:	eb 09                	jmp    39c5 <fwp_gc_init+0x1e5>
    39bc:	b9 01 00 00 00       	mov    $0x1,%ecx
    39c1:	eb 02                	jmp    39c5 <fwp_gc_init+0x1e5>
    39c3:	31 c9                	xor    %ecx,%ecx
    39c5:	89 0d b5 08 01 00    	mov    %ecx,0x108b5(%rip)        # 14280 <fwp_gc+0xff0>
    39cb:	48 8d 3d 92 9d 00 00 	lea    0x9d92(%rip),%rdi        # d764 <exec_in_fp0+0x104>
    39d2:	e8 59 e6 ff ff       	call   2030 <getenv@plt>
    39d7:	31 c9                	xor    %ecx,%ecx
    39d9:	48 85 c0             	test   %rax,%rax
    39dc:	74 1b                	je     39f9 <fwp_gc_init+0x219>
    39de:	80 38 00             	cmpb   $0x0,(%rax)
    39e1:	74 16                	je     39f9 <fwp_gc_init+0x219>
    39e3:	48 8d 35 a0 a9 00 00 	lea    0xa9a0(%rip),%rsi        # e38a <exec_in_fp0+0xd2a>
    39ea:	48 89 c7             	mov    %rax,%rdi
    39ed:	e8 ce e8 ff ff       	call   22c0 <strcmp@plt>
    39f2:	31 c9                	xor    %ecx,%ecx
    39f4:	85 c0                	test   %eax,%eax
    39f6:	0f 95 c1             	setne  %cl
    39f9:	89 0d 8d 08 01 00    	mov    %ecx,0x1088d(%rip)        # 1428c <fwp_gc+0xffc>
    39ff:	48 8d 3d 53 9d 00 00 	lea    0x9d53(%rip),%rdi        # d759 <exec_in_fp0+0xf9>
    3a06:	e8 25 e6 ff ff       	call   2030 <getenv@plt>
    3a0b:	48 85 c0             	test   %rax,%rax
    3a0e:	74 18                	je     3a28 <fwp_gc_init+0x248>
    3a10:	48 8d 35 5a 9d 00 00 	lea    0x9d5a(%rip),%rsi        # d771 <exec_in_fp0+0x111>
    3a17:	48 89 c7             	mov    %rax,%rdi
    3a1a:	e8 a1 e8 ff ff       	call   22c0 <strcmp@plt>
    3a1f:	31 c9                	xor    %ecx,%ecx
    3a21:	85 c0                	test   %eax,%eax
    3a23:	0f 95 c1             	setne  %cl
    3a26:	eb 05                	jmp    3a2d <fwp_gc_init+0x24d>
    3a28:	b9 01 00 00 00       	mov    $0x1,%ecx
    3a2d:	89 0d 5d 08 01 00    	mov    %ecx,0x1085d(%rip)        # 14290 <fwp_gc+0x1000>
    3a33:	c7 05 5b 08 01 00 01 	movl   $0x1,0x1085b(%rip)        # 14298 <fwp_gc+0x1008>
    3a3a:	00 00 00 
    3a3d:	48 8d 3d 32 9d 00 00 	lea    0x9d32(%rip),%rdi        # d776 <exec_in_fp0+0x116>
    3a44:	e8 e7 e5 ff ff       	call   2030 <getenv@plt>
    3a49:	31 c9                	xor    %ecx,%ecx
    3a4b:	48 85 c0             	test   %rax,%rax
    3a4e:	74 1b                	je     3a6b <fwp_gc_init+0x28b>
    3a50:	80 38 00             	cmpb   $0x0,(%rax)
    3a53:	74 16                	je     3a6b <fwp_gc_init+0x28b>
    3a55:	48 8d 35 2e a9 00 00 	lea    0xa92e(%rip),%rsi        # e38a <exec_in_fp0+0xd2a>
    3a5c:	48 89 c7             	mov    %rax,%rdi
    3a5f:	e8 5c e8 ff ff       	call   22c0 <strcmp@plt>
    3a64:	31 c9                	xor    %ecx,%ecx
    3a66:	85 c0                	test   %eax,%eax
    3a68:	0f 95 c1             	setne  %cl
    3a6b:	89 0d 23 08 01 00    	mov    %ecx,0x10823(%rip)        # 14294 <fwp_gc+0x1004>
    3a71:	48 8d 3d 0c 9d 00 00 	lea    0x9d0c(%rip),%rdi        # d784 <exec_in_fp0+0x124>
    3a78:	e8 b3 e5 ff ff       	call   2030 <getenv@plt>
    3a7d:	48 85 c0             	test   %rax,%rax
    3a80:	74 0a                	je     3a8c <fwp_gc_init+0x2ac>
    3a82:	48 89 c7             	mov    %rax,%rdi
    3a85:	e8 66 e9 ff ff       	call   23f0 <atol@plt>
    3a8a:	eb 02                	jmp    3a8e <fwp_gc_init+0x2ae>
    3a8c:	31 c0                	xor    %eax,%eax
    3a8e:	31 c9                	xor    %ecx,%ecx
    3a90:	48 85 c0             	test   %rax,%rax
    3a93:	48 0f 4f c8          	cmovg  %rax,%rcx
    3a97:	48 89 0d 12 08 01 00 	mov    %rcx,0x10812(%rip)        # 142b0 <fwp_gc+0x1020>
    3a9e:	48 c7 05 f7 09 01 00 	movq   $0x800000,0x109f7(%rip)        # 144a0 <fwp_gc+0x1210>
    3aa5:	00 00 80 00 
    3aa9:	48 c7 05 dc f7 00 00 	movq   $0x800000,0xf7dc(%rip)        # 13290 <fwp_gc>
    3ab0:	00 00 80 00 
    3ab4:	48 83 c4 10          	add    $0x10,%rsp
    3ab8:	5b                   	pop    %rbx
    3ab9:	c3                   	ret
    3aba:	e8 71 03 00 00       	call   3e30 <fwp_gc_oom>
    3abf:	90                   	nop

0000000000003ac0 <fwp_gc_alloc_big>:
    3ac0:	55                   	push   %rbp
    3ac1:	41 57                	push   %r15
    3ac3:	41 56                	push   %r14
    3ac5:	41 54                	push   %r12
    3ac7:	53                   	push   %rbx
    3ac8:	48 b8 01 00 00 00 00 	movabs $0x4000000000000001,%rax
    3acf:	00 00 40 
    3ad2:	48 39 c7             	cmp    %rax,%rdi
    3ad5:	0f 83 28 01 00 00    	jae    3c03 <fwp_gc_alloc_big+0x143>
    3adb:	89 f5                	mov    %esi,%ebp
    3add:	48 89 fb             	mov    %rdi,%rbx
    3ae0:	48 29 3d a9 f7 00 00 	sub    %rdi,0xf7a9(%rip)        # 13290 <fwp_gc>
    3ae7:	79 05                	jns    3aee <fwp_gc_alloc_big+0x2e>
    3ae9:	e8 22 01 00 00       	call   3c10 <fwp_gc_spent>
    3aee:	4c 8d bb ff ff 00 00 	lea    0xffff(%rbx),%r15
    3af5:	49 c1 ef 10          	shr    $0x10,%r15
    3af9:	4c 89 ff             	mov    %r15,%rdi
    3afc:	e8 5f 03 00 00       	call   3e60 <fwp_gc_chunks>
    3b01:	49 89 c6             	mov    %rax,%r14
    3b04:	48 8b 05 fd 07 01 00 	mov    0x107fd(%rip),%rax        # 14308 <fwp_gc+0x1078>
    3b0b:	4d 69 e6 28 12 00 00 	imul   $0x1228,%r14,%r12
    3b12:	42 c6 04 20 02       	movb   $0x2,(%rax,%r12,1)
    3b17:	42 88 6c 20 01       	mov    %bpl,0x1(%rax,%r12,1)
    3b1c:	66 42 c7 44 20 03 00 	movw   $0x100,0x3(%rax,%r12,1)
    3b23:	01 
    3b24:	46 89 7c 20 10       	mov    %r15d,0x10(%rax,%r12,1)
    3b29:	4a 89 5c 20 18       	mov    %rbx,0x18(%rax,%r12,1)
    3b2e:	4a 8d 3c 20          	lea    (%rax,%r12,1),%rdi
    3b32:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    3b39:	e8 22 f3 ff ff       	call   2e60 <fwp_rc_clear_slot>
    3b3e:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    3b45:	0f 82 9b 00 00 00    	jb     3be6 <fwp_gc_alloc_big+0x126>
    3b4b:	49 83 ff 03          	cmp    $0x3,%r15
    3b4f:	b9 02 00 00 00       	mov    $0x2,%ecx
    3b54:	49 0f 43 cf          	cmovae %r15,%rcx
    3b58:	48 8b 05 a9 07 01 00 	mov    0x107a9(%rip),%rax        # 14308 <fwp_gc+0x1078>
    3b5f:	48 ff c9             	dec    %rcx
    3b62:	ba 01 00 00 00       	mov    $0x1,%edx
    3b67:	48 81 fb 01 00 02 00 	cmp    $0x20001,%rbx
    3b6e:	72 59                	jb     3bc9 <fwp_gc_alloc_big+0x109>
    3b70:	49 8d 34 04          	lea    (%r12,%rax,1),%rsi
    3b74:	48 81 c6 60 24 00 00 	add    $0x2460,%rsi
    3b7b:	48 89 cf             	mov    %rcx,%rdi
    3b7e:	48 83 e7 fe          	and    $0xfffffffffffffffe,%rdi
    3b82:	48 f7 df             	neg    %rdi
    3b85:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    3b8c:	00 00 00 00 
    3b90:	c6 86 c8 ed ff ff 03 	movb   $0x3,-0x1238(%rsi)
    3b97:	c6 86 cc ed ff ff 01 	movb   $0x1,-0x1234(%rsi)
    3b9e:	44 89 b6 d8 ed ff ff 	mov    %r14d,-0x1228(%rsi)
    3ba5:	c6 46 f0 03          	movb   $0x3,-0x10(%rsi)
    3ba9:	c6 46 f4 01          	movb   $0x1,-0xc(%rsi)
    3bad:	44 89 36             	mov    %r14d,(%rsi)
    3bb0:	48 81 c6 50 24 00 00 	add    $0x2450,%rsi
    3bb7:	4c 8d 04 17          	lea    (%rdi,%rdx,1),%r8
    3bbb:	49 83 c0 02          	add    $0x2,%r8
    3bbf:	48 83 c2 02          	add    $0x2,%rdx
    3bc3:	49 83 f8 01          	cmp    $0x1,%r8
    3bc7:	75 c7                	jne    3b90 <fwp_gc_alloc_big+0xd0>
    3bc9:	f6 c1 01             	test   $0x1,%cl
    3bcc:	74 18                	je     3be6 <fwp_gc_alloc_big+0x126>
    3bce:	4c 01 e0             	add    %r12,%rax
    3bd1:	48 69 ca 28 12 00 00 	imul   $0x1228,%rdx,%rcx
    3bd8:	c6 04 08 03          	movb   $0x3,(%rax,%rcx,1)
    3bdc:	c6 44 08 04 01       	movb   $0x1,0x4(%rax,%rcx,1)
    3be1:	44 89 74 08 10       	mov    %r14d,0x10(%rax,%rcx,1)
    3be6:	4c 89 f7             	mov    %r14,%rdi
    3be9:	e8 92 f2 ff ff       	call   2e80 <fwp_gc_chunk_addr>
    3bee:	48 89 c7             	mov    %rax,%rdi
    3bf1:	31 f6                	xor    %esi,%esi
    3bf3:	48 89 da             	mov    %rbx,%rdx
    3bf6:	5b                   	pop    %rbx
    3bf7:	41 5c                	pop    %r12
    3bf9:	41 5e                	pop    %r14
    3bfb:	41 5f                	pop    %r15
    3bfd:	5d                   	pop    %rbp
    3bfe:	e9 fd e5 ff ff       	jmp    2200 <memset@plt>
    3c03:	e8 28 02 00 00       	call   3e30 <fwp_gc_oom>
    3c08:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    3c0f:	00 

0000000000003c10 <fwp_gc_spent>:
    3c10:	50                   	push   %rax
    3c11:	83 3d 64 06 01 00 00 	cmpl   $0x0,0x10664(%rip)        # 1427c <fwp_gc+0xfec>
    3c18:	75 05                	jne    3c1f <fwp_gc_spent+0xf>
    3c1a:	e8 c1 fb ff ff       	call   37e0 <fwp_gc_init>
    3c1f:	8b 05 5f 06 01 00    	mov    0x1065f(%rip),%eax        # 14284 <fwp_gc+0xff4>
    3c25:	85 c0                	test   %eax,%eax
    3c27:	74 6d                	je     3c96 <fwp_gc_spent+0x86>
    3c29:	48 8b 0d 80 06 01 00 	mov    0x10680(%rip),%rcx        # 142b0 <fwp_gc+0x1020>
    3c30:	48 85 c9             	test   %rcx,%rcx
    3c33:	74 61                	je     3c96 <fwp_gc_spent+0x86>
    3c35:	48 8b 05 7c 06 01 00 	mov    0x1067c(%rip),%rax        # 142b8 <fwp_gc+0x1028>
    3c3c:	48 ff c0             	inc    %rax
    3c3f:	48 89 05 72 06 01 00 	mov    %rax,0x10672(%rip)        # 142b8 <fwp_gc+0x1028>
    3c46:	48 39 c8             	cmp    %rcx,%rax
    3c49:	7c 10                	jl     3c5b <fwp_gc_spent+0x4b>
    3c4b:	48 c7 05 62 06 01 00 	movq   $0x0,0x10662(%rip)        # 142b8 <fwp_gc+0x1028>
    3c52:	00 00 00 00 
    3c56:	e8 85 03 00 00       	call   3fe0 <fwp_gc_collect>
    3c5b:	48 8b 05 3e 08 01 00 	mov    0x1083e(%rip),%rax        # 144a0 <fwp_gc+0x1210>
    3c62:	48 2b 05 27 f6 00 00 	sub    0xf627(%rip),%rax        # 13290 <fwp_gc>
    3c69:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    3c6e:	f2 0f 58 05 02 08 01 	addsd  0x10802(%rip),%xmm0        # 14478 <fwp_gc+0x11e8>
    3c75:	00 
    3c76:	f2 0f 11 05 fa 07 01 	movsd  %xmm0,0x107fa(%rip)        # 14478 <fwp_gc+0x11e8>
    3c7d:	00 
    3c7e:	48 c7 05 17 08 01 00 	movq   $0x0,0x10817(%rip)        # 144a0 <fwp_gc+0x1210>
    3c85:	00 00 00 00 
    3c89:	48 c7 05 fc f5 00 00 	movq   $0x0,0xf5fc(%rip)        # 13290 <fwp_gc>
    3c90:	00 00 00 00 
    3c94:	58                   	pop    %rax
    3c95:	c3                   	ret
    3c96:	85 c0                	test   %eax,%eax
    3c98:	74 06                	je     3ca0 <fwp_gc_spent+0x90>
    3c9a:	58                   	pop    %rax
    3c9b:	e9 40 03 00 00       	jmp    3fe0 <fwp_gc_collect>
    3ca0:	48 8b 05 f9 07 01 00 	mov    0x107f9(%rip),%rax        # 144a0 <fwp_gc+0x1210>
    3ca7:	48 2b 05 e2 f5 00 00 	sub    0xf5e2(%rip),%rax        # 13290 <fwp_gc>
    3cae:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    3cb3:	f2 0f 58 05 bd 07 01 	addsd  0x107bd(%rip),%xmm0        # 14478 <fwp_gc+0x11e8>
    3cba:	00 
    3cbb:	f2 0f 11 05 b5 07 01 	movsd  %xmm0,0x107b5(%rip)        # 14478 <fwp_gc+0x11e8>
    3cc2:	00 
    3cc3:	48 c7 05 d2 07 01 00 	movq   $0x800000,0x107d2(%rip)        # 144a0 <fwp_gc+0x1210>
    3cca:	00 00 80 00 
    3cce:	48 c7 05 b7 f5 00 00 	movq   $0x800000,0xf5b7(%rip)        # 13290 <fwp_gc>
    3cd5:	00 00 80 00 
    3cd9:	58                   	pop    %rax
    3cda:	c3                   	ret
    3cdb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000003ce0 <fwp_gc_refill>:
    3ce0:	55                   	push   %rbp
    3ce1:	41 57                	push   %r15
    3ce3:	41 56                	push   %r14
    3ce5:	53                   	push   %rbx
    3ce6:	50                   	push   %rax
    3ce7:	89 d5                	mov    %edx,%ebp
    3ce9:	41 89 f7             	mov    %esi,%r15d
    3cec:	48 89 fb             	mov    %rdi,%rbx
    3cef:	bf 01 00 00 00       	mov    $0x1,%edi
    3cf4:	e8 67 01 00 00       	call   3e60 <fwp_gc_chunks>
    3cf9:	49 89 c6             	mov    %rax,%r14
    3cfc:	48 8b 0d 05 06 01 00 	mov    0x10605(%rip),%rcx        # 14308 <fwp_gc+0x1078>
    3d03:	48 8d 05 86 f5 00 00 	lea    0xf586(%rip),%rax        # 13290 <fwp_gc>
    3d0a:	49 69 f6 28 12 00 00 	imul   $0x1228,%r14,%rsi
    3d11:	48 8d 3c 31          	lea    (%rcx,%rsi,1),%rdi
    3d15:	c6 04 31 01          	movb   $0x1,(%rcx,%rsi,1)
    3d19:	40 88 6c 31 01       	mov    %bpl,0x1(%rcx,%rsi,1)
    3d1e:	44 88 7c 31 02       	mov    %r15b,0x2(%rcx,%rsi,1)
    3d23:	c6 44 31 04 01       	movb   $0x1,0x4(%rcx,%rsi,1)
    3d28:	44 89 fa             	mov    %r15d,%edx
    3d2b:	44 8b 84 90 48 0b 00 	mov    0xb48(%rax,%rdx,4),%r8d
    3d32:	00 
    3d33:	44 89 44 31 08       	mov    %r8d,0x8(%rcx,%rsi,1)
    3d38:	b8 00 00 01 00       	mov    $0x10000,%eax
    3d3d:	31 d2                	xor    %edx,%edx
    3d3f:	41 f7 f0             	div    %r8d
    3d42:	89 44 31 0c          	mov    %eax,0xc(%rcx,%rsi,1)
    3d46:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3d4b:	4c 01 c0             	add    %r8,%rax
    3d4e:	48 0f ba e0 20       	bt     $0x20,%rax
    3d53:	73 07                	jae    3d5c <fwp_gc_refill+0x7c>
    3d55:	31 d2                	xor    %edx,%edx
    3d57:	49 f7 f0             	div    %r8
    3d5a:	eb 05                	jmp    3d61 <fwp_gc_refill+0x81>
    3d5c:	31 d2                	xor    %edx,%edx
    3d5e:	41 f7 f0             	div    %r8d
    3d61:	4c 8d 3c 31          	lea    (%rcx,%rsi,1),%r15
    3d65:	49 83 c7 08          	add    $0x8,%r15
    3d69:	89 44 31 20          	mov    %eax,0x20(%rcx,%rsi,1)
    3d6d:	e8 4e 15 00 00       	call   52c0 <fwp_rc_clear_chunk>
    3d72:	4c 89 f7             	mov    %r14,%rdi
    3d75:	e8 06 f1 ff ff       	call   2e80 <fwp_gc_chunk_addr>
    3d7a:	83 3d 13 05 01 00 00 	cmpl   $0x0,0x10513(%rip)        # 14294 <fwp_gc+0x1004>
    3d81:	74 15                	je     3d98 <fwp_gc_refill+0xb8>
    3d83:	ba 00 00 01 00       	mov    $0x10000,%edx
    3d88:	48 89 c7             	mov    %rax,%rdi
    3d8b:	31 f6                	xor    %esi,%esi
    3d8d:	49 89 c6             	mov    %rax,%r14
    3d90:	e8 6b e4 ff ff       	call   2200 <memset@plt>
    3d95:	4c 89 f0             	mov    %r14,%rax
    3d98:	41 8b 0f             	mov    (%r15),%ecx
    3d9b:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    3d9f:	48 89 53 08          	mov    %rdx,0x8(%rbx)
    3da3:	41 8b 57 04          	mov    0x4(%r15),%edx
    3da7:	48 0f af d1          	imul   %rcx,%rdx
    3dab:	48 01 c2             	add    %rax,%rdx
    3dae:	48 89 53 10          	mov    %rdx,0x10(%rbx)
    3db2:	48 83 c4 08          	add    $0x8,%rsp
    3db6:	5b                   	pop    %rbx
    3db7:	41 5e                	pop    %r14
    3db9:	41 5f                	pop    %r15
    3dbb:	5d                   	pop    %rbp
    3dbc:	c3                   	ret
    3dbd:	0f 1f 00             	nopl   (%rax)

0000000000003dc0 <fwp_gc_reserve>:
    3dc0:	41 56                	push   %r14
    3dc2:	53                   	push   %rbx
    3dc3:	50                   	push   %rax
    3dc4:	4c 8b 37             	mov    (%rdi),%r14
    3dc7:	49 81 fe 00 00 00 10 	cmp    $0x10000000,%r14
    3dce:	72 47                	jb     3e17 <fwp_gc_reserve+0x57>
    3dd0:	48 89 fb             	mov    %rdi,%rbx
    3dd3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3dda:	84 00 00 00 00 00 
    3de0:	49 8d b6 00 00 01 00 	lea    0x10000(%r14),%rsi
    3de7:	31 ff                	xor    %edi,%edi
    3de9:	31 d2                	xor    %edx,%edx
    3deb:	b9 22 40 00 00       	mov    $0x4022,%ecx
    3df0:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    3df6:	45 31 c9             	xor    %r9d,%r9d
    3df9:	e8 82 e3 ff ff       	call   2180 <mmap@plt>
    3dfe:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    3e02:	75 17                	jne    3e1b <fwp_gc_reserve+0x5b>
    3e04:	4c 89 f0             	mov    %r14,%rax
    3e07:	48 c1 e8 02          	shr    $0x2,%rax
    3e0b:	49 81 fe ff ff ff 3f 	cmp    $0x3fffffff,%r14
    3e12:	49 89 c6             	mov    %rax,%r14
    3e15:	77 c9                	ja     3de0 <fwp_gc_reserve+0x20>
    3e17:	31 c0                	xor    %eax,%eax
    3e19:	eb 03                	jmp    3e1e <fwp_gc_reserve+0x5e>
    3e1b:	4c 89 33             	mov    %r14,(%rbx)
    3e1e:	48 83 c4 08          	add    $0x8,%rsp
    3e22:	5b                   	pop    %rbx
    3e23:	41 5e                	pop    %r14
    3e25:	c3                   	ret
    3e26:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    3e2d:	00 00 00 

0000000000003e30 <fwp_gc_oom>:
    3e30:	50                   	push   %rax
    3e31:	48 8b 05 a8 f1 00 00 	mov    0xf1a8(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    3e38:	48 8b 08             	mov    (%rax),%rcx
    3e3b:	48 8d 3d 50 99 00 00 	lea    0x9950(%rip),%rdi        # d792 <exec_in_fp0+0x132>
    3e42:	be 13 00 00 00       	mov    $0x13,%esi
    3e47:	ba 01 00 00 00       	mov    $0x1,%edx
    3e4c:	e8 3f e6 ff ff       	call   2490 <fwrite@plt>
    3e51:	bf 66 00 00 00       	mov    $0x66,%edi
    3e56:	e8 15 e6 ff ff       	call   2470 <exit@plt>
    3e5b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000003e60 <fwp_gc_chunks>:
    3e60:	41 56                	push   %r14
    3e62:	53                   	push   %rbx
    3e63:	50                   	push   %rax
    3e64:	48 89 fb             	mov    %rdi,%rbx
    3e67:	31 d2                	xor    %edx,%edx
    3e69:	48 83 ff 01          	cmp    $0x1,%rdi
    3e6d:	0f 95 c2             	setne  %dl
    3e70:	48 8d 0d 19 f4 00 00 	lea    0xf419(%rip),%rcx        # 13290 <fwp_gc>
    3e77:	48 8b 84 d1 68 10 00 	mov    0x1068(%rcx,%rdx,8),%rax
    3e7e:	00 
    3e7f:	4c 8b 35 62 04 01 00 	mov    0x10462(%rip),%r14        # 142e8 <fwp_gc+0x1058>
    3e86:	48 89 c7             	mov    %rax,%rdi
    3e89:	4c 29 f7             	sub    %r14,%rdi
    3e8c:	73 61                	jae    3eef <fwp_gc_chunks+0x8f>
    3e8e:	48 8d 34 d5 68 10 00 	lea    0x1068(,%rdx,8),%rsi
    3e95:	00 
    3e96:	4c 69 c0 28 12 00 00 	imul   $0x1228,%rax,%r8
    3e9d:	4c 03 05 64 04 01 00 	add    0x10464(%rip),%r8        # 14308 <fwp_gc+0x1078>
    3ea4:	31 d2                	xor    %edx,%edx
    3ea6:	45 31 c9             	xor    %r9d,%r9d
    3ea9:	eb 17                	jmp    3ec2 <fwp_gc_chunks+0x62>
    3eab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    3eb0:	45 31 c9             	xor    %r9d,%r9d
    3eb3:	48 ff ca             	dec    %rdx
    3eb6:	49 81 c0 28 12 00 00 	add    $0x1228,%r8
    3ebd:	48 39 d7             	cmp    %rdx,%rdi
    3ec0:	74 30                	je     3ef2 <fwp_gc_chunks+0x92>
    3ec2:	41 80 38 00          	cmpb   $0x0,(%r8)
    3ec6:	75 e8                	jne    3eb0 <fwp_gc_chunks+0x50>
    3ec8:	49 ff c1             	inc    %r9
    3ecb:	49 39 d9             	cmp    %rbx,%r9
    3ece:	75 e3                	jne    3eb3 <fwp_gc_chunks+0x53>
    3ed0:	48 ff c0             	inc    %rax
    3ed3:	48 89 c7             	mov    %rax,%rdi
    3ed6:	48 29 d7             	sub    %rdx,%rdi
    3ed9:	48 89 3c 0e          	mov    %rdi,(%rsi,%rcx,1)
    3edd:	48 29 1d 8c 05 01 00 	sub    %rbx,0x1058c(%rip)        # 14470 <fwp_gc+0x11e0>
    3ee4:	48 29 d8             	sub    %rbx,%rax
    3ee7:	48 29 d0             	sub    %rdx,%rax
    3eea:	49 89 c6             	mov    %rax,%r14
    3eed:	eb 33                	jmp    3f22 <fwp_gc_chunks+0xc2>
    3eef:	45 31 c9             	xor    %r9d,%r9d
    3ef2:	4d 29 ce             	sub    %r9,%r14
    3ef5:	4c 29 0d 74 05 01 00 	sub    %r9,0x10574(%rip)        # 14470 <fwp_gc+0x11e0>
    3efc:	4c 01 f3             	add    %r14,%rbx
    3eff:	48 89 df             	mov    %rbx,%rdi
    3f02:	e8 29 00 00 00       	call   3f30 <fwp_gc_commit>
    3f07:	48 89 1d da 03 01 00 	mov    %rbx,0x103da(%rip)        # 142e8 <fwp_gc+0x1058>
    3f0e:	48 c1 e3 10          	shl    $0x10,%rbx
    3f12:	48 3b 1d bf 03 01 00 	cmp    0x103bf(%rip),%rbx        # 142d8 <fwp_gc+0x1048>
    3f19:	76 07                	jbe    3f22 <fwp_gc_chunks+0xc2>
    3f1b:	48 89 1d b6 03 01 00 	mov    %rbx,0x103b6(%rip)        # 142d8 <fwp_gc+0x1048>
    3f22:	4c 89 f0             	mov    %r14,%rax
    3f25:	48 83 c4 08          	add    $0x8,%rsp
    3f29:	5b                   	pop    %rbx
    3f2a:	41 5e                	pop    %r14
    3f2c:	c3                   	ret
    3f2d:	0f 1f 00             	nopl   (%rax)

0000000000003f30 <fwp_gc_commit>:
    3f30:	53                   	push   %rbx
    3f31:	48 89 fb             	mov    %rdi,%rbx
    3f34:	48 8b 3d b5 03 01 00 	mov    0x103b5(%rip),%rdi        # 142f0 <fwp_gc+0x1060>
    3f3b:	48 39 df             	cmp    %rbx,%rdi
    3f3e:	0f 83 8f 00 00 00    	jae    3fd3 <fwp_gc_commit+0xa3>
    3f44:	48 8b 05 95 03 01 00 	mov    0x10395(%rip),%rax        # 142e0 <fwp_gc+0x1050>
    3f4b:	48 39 d8             	cmp    %rbx,%rax
    3f4e:	0f 82 81 00 00 00    	jb     3fd5 <fwp_gc_commit+0xa5>
    3f54:	48 83 c3 40          	add    $0x40,%rbx
    3f58:	48 39 c3             	cmp    %rax,%rbx
    3f5b:	48 0f 43 d8          	cmovae %rax,%rbx
    3f5f:	48 89 de             	mov    %rbx,%rsi
    3f62:	48 29 fe             	sub    %rdi,%rsi
    3f65:	48 c1 e7 10          	shl    $0x10,%rdi
    3f69:	48 03 3d 50 03 01 00 	add    0x10350(%rip),%rdi        # 142c0 <fwp_gc+0x1030>
    3f70:	48 c1 e6 10          	shl    $0x10,%rsi
    3f74:	ba 03 00 00 00       	mov    $0x3,%edx
    3f79:	e8 82 e4 ff ff       	call   2400 <mprotect@plt>
    3f7e:	85 c0                	test   %eax,%eax
    3f80:	75 53                	jne    3fd5 <fwp_gc_commit+0xa5>
    3f82:	bf 1e 00 00 00       	mov    $0x1e,%edi
    3f87:	e8 94 e4 ff ff       	call   2420 <sysconf@plt>
    3f8c:	48 8b 0d 75 03 01 00 	mov    0x10375(%rip),%rcx        # 14308 <fwp_gc+0x1078>
    3f93:	48 69 3d 52 03 01 00 	imul   $0x1228,0x10352(%rip),%rdi        # 142f0 <fwp_gc+0x1060>
    3f9a:	28 12 00 00 
    3f9e:	48 01 cf             	add    %rcx,%rdi
    3fa1:	48 69 d3 28 12 00 00 	imul   $0x1228,%rbx,%rdx
    3fa8:	48 01 ca             	add    %rcx,%rdx
    3fab:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    3faf:	48 ff ce             	dec    %rsi
    3fb2:	48 f7 d8             	neg    %rax
    3fb5:	48 21 c7             	and    %rax,%rdi
    3fb8:	48 21 c6             	and    %rax,%rsi
    3fbb:	48 29 fe             	sub    %rdi,%rsi
    3fbe:	ba 03 00 00 00       	mov    $0x3,%edx
    3fc3:	e8 38 e4 ff ff       	call   2400 <mprotect@plt>
    3fc8:	85 c0                	test   %eax,%eax
    3fca:	75 09                	jne    3fd5 <fwp_gc_commit+0xa5>
    3fcc:	48 89 1d 1d 03 01 00 	mov    %rbx,0x1031d(%rip)        # 142f0 <fwp_gc+0x1060>
    3fd3:	5b                   	pop    %rbx
    3fd4:	c3                   	ret
    3fd5:	e8 56 fe ff ff       	call   3e30 <fwp_gc_oom>
    3fda:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000003fe0 <fwp_gc_collect>:
    3fe0:	83 3d a1 02 01 00 00 	cmpl   $0x0,0x102a1(%rip)        # 14288 <fwp_gc+0xff8>
    3fe7:	74 01                	je     3fea <fwp_gc_collect+0xa>
    3fe9:	c3                   	ret
    3fea:	55                   	push   %rbp
    3feb:	48 89 e5             	mov    %rsp,%rbp
    3fee:	41 57                	push   %r15
    3ff0:	41 56                	push   %r14
    3ff2:	41 55                	push   %r13
    3ff4:	41 54                	push   %r12
    3ff6:	53                   	push   %rbx
    3ff7:	48 81 ec e8 00 00 00 	sub    $0xe8,%rsp
    3ffe:	c7 05 80 02 01 00 01 	movl   $0x1,0x10280(%rip)        # 14288 <fwp_gc+0xff8>
    4005:	00 00 00 
    4008:	48 8d 75 b8          	lea    -0x48(%rbp),%rsi
    400c:	bf 01 00 00 00       	mov    $0x1,%edi
    4011:	e8 0a e1 ff ff       	call   2120 <clock_gettime@plt>
    4016:	48 8b 05 83 04 01 00 	mov    0x10483(%rip),%rax        # 144a0 <fwp_gc+0x1210>
    401d:	48 2b 05 6c f2 00 00 	sub    0xf26c(%rip),%rax        # 13290 <fwp_gc>
    4024:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    4029:	f2 0f 58 05 47 04 01 	addsd  0x10447(%rip),%xmm0        # 14478 <fwp_gc+0x11e8>
    4030:	00 
    4031:	f2 0f 11 05 3f 04 01 	movsd  %xmm0,0x1043f(%rip)        # 14478 <fwp_gc+0x11e8>
    4038:	00 
    4039:	83 3d 50 02 01 00 00 	cmpl   $0x0,0x10250(%rip)        # 14290 <fwp_gc+0x1000>
    4040:	0f 94 c0             	sete   %al
    4043:	83 3d 4e 02 01 00 00 	cmpl   $0x0,0x1024e(%rip)        # 14298 <fwp_gc+0x1008>
    404a:	0f 95 c3             	setne  %bl
    404d:	08 c3                	or     %al,%bl
    404f:	80 fb 01             	cmp    $0x1,%bl
    4052:	75 3e                	jne    4092 <fwp_gc_collect+0xb2>
    4054:	e8 b7 01 00 00       	call   4210 <fwp_gc_clear_marks>
    4059:	48 8d bd f0 fe ff ff 	lea    -0x110(%rbp),%rdi
    4060:	e8 3b e2 ff ff       	call   22a0 <_setjmp@plt>
    4065:	48 c7 05 20 04 01 00 	movq   $0x0,0x10420(%rip)        # 14490 <fwp_gc+0x1200>
    406c:	00 00 00 00 
    4070:	e8 1b 02 00 00       	call   4290 <fwp_gc_mark_all>
    4075:	e8 36 07 00 00       	call   47b0 <fwp_gc_finalize>
    407a:	e8 c1 07 00 00       	call   4840 <fwp_gc_sweep>
    407f:	48 8b 05 e2 03 01 00 	mov    0x103e2(%rip),%rax        # 14468 <fwp_gc+0x11d8>
    4086:	48 ff c0             	inc    %rax
    4089:	48 89 05 d8 03 01 00 	mov    %rax,0x103d8(%rip)        # 14468 <fwp_gc+0x11d8>
    4090:	eb 51                	jmp    40e3 <fwp_gc_collect+0x103>
    4092:	48 8d bd f0 fe ff ff 	lea    -0x110(%rbp),%rdi
    4099:	e8 02 e2 ff ff       	call   22a0 <_setjmp@plt>
    409e:	48 c7 05 e7 03 01 00 	movq   $0x0,0x103e7(%rip)        # 14490 <fwp_gc+0x1200>
    40a5:	00 00 00 00 
    40a9:	e8 e2 01 00 00       	call   4290 <fwp_gc_mark_all>
    40ae:	e8 fd 01 00 00       	call   42b0 <fwp_gc_scan_old_filled>
    40b3:	83 3d da 01 01 00 00 	cmpl   $0x0,0x101da(%rip)        # 14294 <fwp_gc+0x1004>
    40ba:	74 05                	je     40c1 <fwp_gc_collect+0xe1>
    40bc:	e8 2f 03 00 00       	call   43f0 <fwp_gc_verify_minor>
    40c1:	e8 ea 06 00 00       	call   47b0 <fwp_gc_finalize>
    40c6:	e8 75 07 00 00       	call   4840 <fwp_gc_sweep>
    40cb:	48 8b 05 96 03 01 00 	mov    0x10396(%rip),%rax        # 14468 <fwp_gc+0x11d8>
    40d2:	48 ff c0             	inc    %rax
    40d5:	48 89 05 8c 03 01 00 	mov    %rax,0x1038c(%rip)        # 14468 <fwp_gc+0x11d8>
    40dc:	48 ff 05 c5 01 01 00 	incq   0x101c5(%rip)        # 142a8 <fwp_gc+0x1018>
    40e3:	48 89 c1             	mov    %rax,%rcx
    40e6:	48 8b 05 6b 03 01 00 	mov    0x1036b(%rip),%rax        # 14458 <fwp_gc+0x11c8>
    40ed:	48 3b 05 6c 03 01 00 	cmp    0x1036c(%rip),%rax        # 14460 <fwp_gc+0x11d0>
    40f4:	76 07                	jbe    40fd <fwp_gc_collect+0x11d>
    40f6:	48 89 05 63 03 01 00 	mov    %rax,0x10363(%rip)        # 14460 <fwp_gc+0x11d0>
    40fd:	84 db                	test   %bl,%bl
    40ff:	74 0b                	je     410c <fwp_gc_collect+0x12c>
    4101:	48 89 05 98 01 01 00 	mov    %rax,0x10198(%rip)        # 142a0 <fwp_gc+0x1010>
    4108:	31 d2                	xor    %edx,%edx
    410a:	eb 2d                	jmp    4139 <fwp_gc_collect+0x159>
    410c:	48 8b 15 8d 01 01 00 	mov    0x1018d(%rip),%rdx        # 142a0 <fwp_gc+0x1010>
    4113:	48 89 d6             	mov    %rdx,%rsi
    4116:	48 d1 ee             	shr    $1,%rsi
    4119:	48 01 d6             	add    %rdx,%rsi
    411c:	48 81 fe 01 00 00 01 	cmp    $0x1000001,%rsi
    4123:	ba 00 00 00 01       	mov    $0x1000000,%edx
    4128:	48 0f 43 d6          	cmovae %rsi,%rdx
    412c:	31 f6                	xor    %esi,%esi
    412e:	48 39 d0             	cmp    %rdx,%rax
    4131:	0f 97 c2             	seta   %dl
    4134:	40 88 d6             	mov    %dl,%sil
    4137:	89 f2                	mov    %esi,%edx
    4139:	f6 c1 07             	test   $0x7,%cl
    413c:	b9 01 00 00 00       	mov    $0x1,%ecx
    4141:	0f 45 ca             	cmovne %edx,%ecx
    4144:	48 83 3d 64 01 01 00 	cmpq   $0x0,0x10164(%rip)        # 142b0 <fwp_gc+0x1020>
    414b:	00 
    414c:	0f 44 ca             	cmove  %edx,%ecx
    414f:	89 0d 43 01 01 00    	mov    %ecx,0x10143(%rip)        # 14298 <fwp_gc+0x1008>
    4155:	83 3d 34 01 01 00 00 	cmpl   $0x0,0x10134(%rip)        # 14290 <fwp_gc+0x1000>
    415c:	0f 94 c1             	sete   %cl
    415f:	48 d3 e0             	shl    %cl,%rax
    4162:	f2 48 0f 2c 0d 25 03 	cvttsd2si 0x10325(%rip),%rcx        # 14490 <fwp_gc+0x1200>
    4169:	01 00 
    416b:	48 01 c1             	add    %rax,%rcx
    416e:	48 81 f9 01 00 80 00 	cmp    $0x800001,%rcx
    4175:	b8 00 00 80 00       	mov    $0x800000,%eax
    417a:	48 0f 4d c1          	cmovge %rcx,%rax
    417e:	48 89 05 1b 03 01 00 	mov    %rax,0x1031b(%rip)        # 144a0 <fwp_gc+0x1210>
    4185:	48 89 05 04 f1 00 00 	mov    %rax,0xf104(%rip)        # 13290 <fwp_gc>
    418c:	48 8d 75 c8          	lea    -0x38(%rbp),%rsi
    4190:	bf 01 00 00 00       	mov    $0x1,%edi
    4195:	e8 86 df ff ff       	call   2120 <clock_gettime@plt>
    419a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    419e:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
    41a2:	48 2b 45 b8          	sub    -0x48(%rbp),%rax
    41a6:	f2 48 0f 2a c8       	cvtsi2sd %rax,%xmm1
    41ab:	f2 0f 59 0d 6d 8e 00 	mulsd  0x8e6d(%rip),%xmm1        # d020 <_IO_stdin_used+0x20>
    41b2:	00 
    41b3:	48 2b 4d c0          	sub    -0x40(%rbp),%rcx
    41b7:	0f 57 c0             	xorps  %xmm0,%xmm0
    41ba:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    41bf:	f2 0f 5e 05 61 8e 00 	divsd  0x8e61(%rip),%xmm0        # d028 <_IO_stdin_used+0x28>
    41c6:	00 
    41c7:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
    41cb:	f2 0f 10 0d ad 02 01 	movsd  0x102ad(%rip),%xmm1        # 14480 <fwp_gc+0x11f0>
    41d2:	00 
    41d3:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
    41d7:	f2 0f 11 0d a1 02 01 	movsd  %xmm1,0x102a1(%rip)        # 14480 <fwp_gc+0x11f0>
    41de:	00 
    41df:	66 0f 2e 05 a1 02 01 	ucomisd 0x102a1(%rip),%xmm0        # 14488 <fwp_gc+0x11f8>
    41e6:	00 
    41e7:	48 8d a4 24 e8 00 00 	lea    0xe8(%rsp),%rsp
    41ee:	00 
    41ef:	5b                   	pop    %rbx
    41f0:	41 5c                	pop    %r12
    41f2:	41 5d                	pop    %r13
    41f4:	41 5e                	pop    %r14
    41f6:	41 5f                	pop    %r15
    41f8:	5d                   	pop    %rbp
    41f9:	76 08                	jbe    4203 <fwp_gc_collect+0x223>
    41fb:	f2 0f 11 05 85 02 01 	movsd  %xmm0,0x10285(%rip)        # 14488 <fwp_gc+0x11f8>
    4202:	00 
    4203:	c7 05 7b 00 01 00 00 	movl   $0x0,0x1007b(%rip)        # 14288 <fwp_gc+0xff8>
    420a:	00 00 00 
    420d:	c3                   	ret
    420e:	66 90                	xchg   %ax,%ax

0000000000004210 <fwp_gc_clear_marks>:
    4210:	48 8b 05 d1 00 01 00 	mov    0x100d1(%rip),%rax        # 142e8 <fwp_gc+0x1058>
    4217:	48 85 c0             	test   %rax,%rax
    421a:	74 69                	je     4285 <fwp_gc_clear_marks+0x75>
    421c:	41 56                	push   %r14
    421e:	53                   	push   %rbx
    421f:	50                   	push   %rax
    4220:	48 8b 0d e1 00 01 00 	mov    0x100e1(%rip),%rcx        # 14308 <fwp_gc+0x1078>
    4227:	31 db                	xor    %ebx,%ebx
    4229:	45 31 f6             	xor    %r14d,%r14d
    422c:	eb 16                	jmp    4244 <fwp_gc_clear_marks+0x34>
    422e:	66 90                	xchg   %ax,%ax
    4230:	c6 44 19 03 00       	movb   $0x0,0x3(%rcx,%rbx,1)
    4235:	49 ff c6             	inc    %r14
    4238:	48 81 c3 28 12 00 00 	add    $0x1228,%rbx
    423f:	49 39 c6             	cmp    %rax,%r14
    4242:	73 3a                	jae    427e <fwp_gc_clear_marks+0x6e>
    4244:	0f b6 14 19          	movzbl (%rcx,%rbx,1),%edx
    4248:	83 fa 02             	cmp    $0x2,%edx
    424b:	74 e3                	je     4230 <fwp_gc_clear_marks+0x20>
    424d:	83 fa 01             	cmp    $0x1,%edx
    4250:	75 e3                	jne    4235 <fwp_gc_clear_marks+0x25>
    4252:	48 8d 3c 19          	lea    (%rcx,%rbx,1),%rdi
    4256:	48 83 c7 28          	add    $0x28,%rdi
    425a:	8b 54 19 0c          	mov    0xc(%rcx,%rbx,1),%edx
    425e:	83 c2 3f             	add    $0x3f,%edx
    4261:	c1 ea 03             	shr    $0x3,%edx
    4264:	83 e2 f8             	and    $0xfffffff8,%edx
    4267:	31 f6                	xor    %esi,%esi
    4269:	e8 92 df ff ff       	call   2200 <memset@plt>
    426e:	48 8b 0d 93 00 01 00 	mov    0x10093(%rip),%rcx        # 14308 <fwp_gc+0x1078>
    4275:	48 8b 05 6c 00 01 00 	mov    0x1006c(%rip),%rax        # 142e8 <fwp_gc+0x1058>
    427c:	eb b7                	jmp    4235 <fwp_gc_clear_marks+0x25>
    427e:	48 83 c4 08          	add    $0x8,%rsp
    4282:	5b                   	pop    %rbx
    4283:	41 5e                	pop    %r14
    4285:	c3                   	ret
    4286:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    428d:	00 00 00 

0000000000004290 <fwp_gc_mark_all>:
    4290:	50                   	push   %rax
    4291:	e8 4a 0c 00 00       	call   4ee0 <fwp_gc_sp>
    4296:	48 89 c7             	mov    %rax,%rdi
    4299:	e8 32 0c 00 00       	call   4ed0 <fwp_gc_scan_stacks>
    429e:	e8 4d 0c 00 00       	call   4ef0 <fwp_gc_drain>
    42a3:	e8 98 0c 00 00       	call   4f40 <fwp_gc_scan_data>
    42a8:	58                   	pop    %rax
    42a9:	e9 42 0c 00 00       	jmp    4ef0 <fwp_gc_drain>
    42ae:	66 90                	xchg   %ax,%ax

00000000000042b0 <fwp_gc_scan_old_filled>:
    42b0:	48 83 3d 30 00 01 00 	cmpq   $0x0,0x10030(%rip)        # 142e8 <fwp_gc+0x1058>
    42b7:	00 
    42b8:	0f 84 32 0c 00 00    	je     4ef0 <fwp_gc_drain>
    42be:	55                   	push   %rbp
    42bf:	41 57                	push   %r15
    42c1:	41 56                	push   %r14
    42c3:	41 55                	push   %r13
    42c5:	41 54                	push   %r12
    42c7:	53                   	push   %rbx
    42c8:	48 83 ec 18          	sub    $0x18,%rsp
    42cc:	31 c0                	xor    %eax,%eax
    42ce:	eb 14                	jmp    42e4 <fwp_gc_scan_old_filled+0x34>
    42d0:	48 8b 04 24          	mov    (%rsp),%rax
    42d4:	48 ff c0             	inc    %rax
    42d7:	48 3b 05 0a 00 01 00 	cmp    0x1000a(%rip),%rax        # 142e8 <fwp_gc+0x1058>
    42de:	0f 83 f6 00 00 00    	jae    43da <fwp_gc_scan_old_filled+0x12a>
    42e4:	48 8b 0d 1d 00 01 00 	mov    0x1001d(%rip),%rcx        # 14308 <fwp_gc+0x1078>
    42eb:	48 89 04 24          	mov    %rax,(%rsp)
    42ef:	48 69 e8 28 12 00 00 	imul   $0x1228,%rax,%rbp
    42f6:	80 7c 29 01 02       	cmpb   $0x2,0x1(%rcx,%rbp,1)
    42fb:	75 d3                	jne    42d0 <fwp_gc_scan_old_filled+0x20>
    42fd:	48 89 cb             	mov    %rcx,%rbx
    4300:	0f b6 04 29          	movzbl (%rcx,%rbp,1),%eax
    4304:	83 f8 02             	cmp    $0x2,%eax
    4307:	0f 84 a7 00 00 00    	je     43b4 <fwp_gc_scan_old_filled+0x104>
    430d:	83 f8 01             	cmp    $0x1,%eax
    4310:	75 be                	jne    42d0 <fwp_gc_scan_old_filled+0x20>
    4312:	48 8b 3c 24          	mov    (%rsp),%rdi
    4316:	e8 65 eb ff ff       	call   2e80 <fwp_gc_chunk_addr>
    431b:	49 89 c6             	mov    %rax,%r14
    431e:	8b 44 2b 0c          	mov    0xc(%rbx,%rbp,1),%eax
    4322:	83 c0 3f             	add    $0x3f,%eax
    4325:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    432a:	83 f8 40             	cmp    $0x40,%eax
    432d:	72 a1                	jb     42d0 <fwp_gc_scan_old_filled+0x20>
    432f:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    4334:	c1 e8 06             	shr    $0x6,%eax
    4337:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    433c:	4c 8d 2c 2b          	lea    (%rbx,%rbp,1),%r13
    4340:	49 83 c5 08          	add    $0x8,%r13
    4344:	48 01 eb             	add    %rbp,%rbx
    4347:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
    434c:	45 31 ff             	xor    %r15d,%r15d
    434f:	eb 1d                	jmp    436e <fwp_gc_scan_old_filled+0xbe>
    4351:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4358:	0f 1f 84 00 00 00 00 
    435f:	00 
    4360:	49 ff c7             	inc    %r15
    4363:	4c 3b 7c 24 08       	cmp    0x8(%rsp),%r15
    4368:	0f 84 62 ff ff ff    	je     42d0 <fwp_gc_scan_old_filled+0x20>
    436e:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    4373:	4e 8b 64 f8 28       	mov    0x28(%rax,%r15,8),%r12
    4378:	4d 85 e4             	test   %r12,%r12
    437b:	74 e3                	je     4360 <fwp_gc_scan_old_filled+0xb0>
    437d:	4c 89 fd             	mov    %r15,%rbp
    4380:	48 c1 e5 06          	shl    $0x6,%rbp
    4384:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    438b:	00 00 00 00 00 
    4390:	f3 49 0f bc fc       	tzcnt  %r12,%rdi
    4395:	48 09 ef             	or     %rbp,%rdi
    4398:	49 8d 5c 24 ff       	lea    -0x1(%r12),%rbx
    439d:	41 8b 75 00          	mov    0x0(%r13),%esi
    43a1:	48 0f af fe          	imul   %rsi,%rdi
    43a5:	4c 01 f7             	add    %r14,%rdi
    43a8:	e8 03 0e 00 00       	call   51b0 <fwp_gc_push>
    43ad:	49 21 dc             	and    %rbx,%r12
    43b0:	75 de                	jne    4390 <fwp_gc_scan_old_filled+0xe0>
    43b2:	eb ac                	jmp    4360 <fwp_gc_scan_old_filled+0xb0>
    43b4:	80 7c 2b 03 00       	cmpb   $0x0,0x3(%rbx,%rbp,1)
    43b9:	0f 84 11 ff ff ff    	je     42d0 <fwp_gc_scan_old_filled+0x20>
    43bf:	48 8b 3c 24          	mov    (%rsp),%rdi
    43c3:	e8 b8 ea ff ff       	call   2e80 <fwp_gc_chunk_addr>
    43c8:	48 8b 74 2b 18       	mov    0x18(%rbx,%rbp,1),%rsi
    43cd:	48 89 c7             	mov    %rax,%rdi
    43d0:	e8 db 0d 00 00       	call   51b0 <fwp_gc_push>
    43d5:	e9 f6 fe ff ff       	jmp    42d0 <fwp_gc_scan_old_filled+0x20>
    43da:	48 83 c4 18          	add    $0x18,%rsp
    43de:	5b                   	pop    %rbx
    43df:	41 5c                	pop    %r12
    43e1:	41 5d                	pop    %r13
    43e3:	41 5e                	pop    %r14
    43e5:	41 5f                	pop    %r15
    43e7:	5d                   	pop    %rbp
    43e8:	e9 03 0b 00 00       	jmp    4ef0 <fwp_gc_drain>
    43ed:	0f 1f 00             	nopl   (%rax)

00000000000043f0 <fwp_gc_verify_minor>:
    43f0:	55                   	push   %rbp
    43f1:	41 57                	push   %r15
    43f3:	41 56                	push   %r14
    43f5:	41 55                	push   %r13
    43f7:	41 54                	push   %r12
    43f9:	53                   	push   %rbx
    43fa:	48 83 ec 58          	sub    $0x58,%rsp
    43fe:	4c 8b 2d e3 fe 00 00 	mov    0xfee3(%rip),%r13        # 142e8 <fwp_gc+0x1058>
    4405:	4c 89 ef             	mov    %r13,%rdi
    4408:	48 c1 e7 09          	shl    $0x9,%rdi
    440c:	e8 1f df ff ff       	call   2330 <malloc@plt>
    4411:	48 89 c3             	mov    %rax,%rbx
    4414:	49 83 fd 01          	cmp    $0x1,%r13
    4418:	4c 89 ef             	mov    %r13,%rdi
    441b:	48 83 d7 00          	adc    $0x0,%rdi
    441f:	48 89 7c 24 30       	mov    %rdi,0x30(%rsp)
    4424:	e8 07 df ff ff       	call   2330 <malloc@plt>
    4429:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
    442e:	48 85 db             	test   %rbx,%rbx
    4431:	0f 84 74 03 00 00    	je     47ab <fwp_gc_verify_minor+0x3bb>
    4437:	49 89 c7             	mov    %rax,%r15
    443a:	48 85 c0             	test   %rax,%rax
    443d:	0f 84 68 03 00 00    	je     47ab <fwp_gc_verify_minor+0x3bb>
    4443:	4d 85 ed             	test   %r13,%r13
    4446:	74 1c                	je     4464 <fwp_gc_verify_minor+0x74>
    4448:	48 8b 0d b9 fe 00 00 	mov    0xfeb9(%rip),%rcx        # 14308 <fwp_gc+0x1078>
    444f:	49 83 fd 01          	cmp    $0x1,%r13
    4453:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
    4458:	75 19                	jne    4473 <fwp_gc_verify_minor+0x83>
    445a:	4d 89 ec             	mov    %r13,%r12
    445d:	31 ed                	xor    %ebp,%ebp
    445f:	e9 81 00 00 00       	jmp    44e5 <fwp_gc_verify_minor+0xf5>
    4464:	e8 a7 fd ff ff       	call   4210 <fwp_gc_clear_marks>
    4469:	e8 22 fe ff ff       	call   4290 <fwp_gc_mark_all>
    446e:	e9 13 03 00 00       	jmp    4786 <fwp_gc_verify_minor+0x396>
    4473:	4d 89 ec             	mov    %r13,%r12
    4476:	49 83 e5 fe          	and    $0xfffffffffffffffe,%r13
    447a:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    447f:	48 8d 98 00 02 00 00 	lea    0x200(%rax),%rbx
    4486:	4c 8d b1 50 12 00 00 	lea    0x1250(%rcx),%r14
    448d:	31 ed                	xor    %ebp,%ebp
    448f:	90                   	nop
    4490:	48 8d bb 00 fe ff ff 	lea    -0x200(%rbx),%rdi
    4497:	49 8d b6 d8 ed ff ff 	lea    -0x1228(%r14),%rsi
    449e:	ba 00 02 00 00       	mov    $0x200,%edx
    44a3:	e8 78 de ff ff       	call   2320 <memcpy@plt>
    44a8:	41 0f b6 86 b3 ed ff 	movzbl -0x124d(%r14),%eax
    44af:	ff 
    44b0:	41 88 04 2f          	mov    %al,(%r15,%rbp,1)
    44b4:	ba 00 02 00 00       	mov    $0x200,%edx
    44b9:	48 89 df             	mov    %rbx,%rdi
    44bc:	4c 89 f6             	mov    %r14,%rsi
    44bf:	e8 5c de ff ff       	call   2320 <memcpy@plt>
    44c4:	41 0f b6 46 db       	movzbl -0x25(%r14),%eax
    44c9:	41 88 44 2f 01       	mov    %al,0x1(%r15,%rbp,1)
    44ce:	48 83 c5 02          	add    $0x2,%rbp
    44d2:	48 81 c3 00 04 00 00 	add    $0x400,%rbx
    44d9:	49 81 c6 50 24 00 00 	add    $0x2450,%r14
    44e0:	49 39 ed             	cmp    %rbp,%r13
    44e3:	75 ab                	jne    4490 <fwp_gc_verify_minor+0xa0>
    44e5:	4d 89 e5             	mov    %r12,%r13
    44e8:	41 f6 c5 01          	test   $0x1,%r13b
    44ec:	74 34                	je     4522 <fwp_gc_verify_minor+0x132>
    44ee:	48 89 ef             	mov    %rbp,%rdi
    44f1:	48 c1 e7 09          	shl    $0x9,%rdi
    44f5:	48 03 7c 24 20       	add    0x20(%rsp),%rdi
    44fa:	48 69 dd 28 12 00 00 	imul   $0x1228,%rbp,%rbx
    4501:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    4506:	49 8d 34 1e          	lea    (%r14,%rbx,1),%rsi
    450a:	48 83 c6 28          	add    $0x28,%rsi
    450e:	ba 00 02 00 00       	mov    $0x200,%edx
    4513:	e8 08 de ff ff       	call   2320 <memcpy@plt>
    4518:	41 0f b6 44 1e 03    	movzbl 0x3(%r14,%rbx,1),%eax
    451e:	41 88 04 2f          	mov    %al,(%r15,%rbp,1)
    4522:	e8 e9 fc ff ff       	call   4210 <fwp_gc_clear_marks>
    4527:	e8 64 fd ff ff       	call   4290 <fwp_gc_mark_all>
    452c:	4d 85 ed             	test   %r13,%r13
    452f:	0f 84 51 02 00 00    	je     4786 <fwp_gc_verify_minor+0x396>
    4535:	48 8b 1d cc fd 00 00 	mov    0xfdcc(%rip),%rbx        # 14308 <fwp_gc+0x1078>
    453c:	48 8d 43 28          	lea    0x28(%rbx),%rax
    4540:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    4545:	31 ff                	xor    %edi,%edi
    4547:	eb 30                	jmp    4579 <fwp_gc_verify_minor+0x189>
    4549:	4d 85 c9             	test   %r9,%r9
    454c:	0f 85 b8 00 00 00    	jne    460a <fwp_gc_verify_minor+0x21a>
    4552:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4559:	1f 84 00 00 00 00 00 
    4560:	48 ff c7             	inc    %rdi
    4563:	48 81 c1 00 02 00 00 	add    $0x200,%rcx
    456a:	48 05 28 12 00 00    	add    $0x1228,%rax
    4570:	4c 39 ef             	cmp    %r13,%rdi
    4573:	0f 84 0d 02 00 00    	je     4786 <fwp_gc_verify_minor+0x396>
    4579:	4c 69 f7 28 12 00 00 	imul   $0x1228,%rdi,%r14
    4580:	42 0f b6 2c 33       	movzbl (%rbx,%r14,1),%ebp
    4585:	83 fd 02             	cmp    $0x2,%ebp
    4588:	74 66                	je     45f0 <fwp_gc_verify_minor+0x200>
    458a:	83 fd 01             	cmp    $0x1,%ebp
    458d:	75 d1                	jne    4560 <fwp_gc_verify_minor+0x170>
    458f:	42 8b 54 33 0c       	mov    0xc(%rbx,%r14,1),%edx
    4594:	83 c2 3f             	add    $0x3f,%edx
    4597:	83 fa 40             	cmp    $0x40,%edx
    459a:	72 c4                	jb     4560 <fwp_gc_verify_minor+0x170>
    459c:	c1 ea 06             	shr    $0x6,%edx
    459f:	31 f6                	xor    %esi,%esi
    45a1:	45 31 e4             	xor    %r12d,%r12d
    45a4:	45 31 c0             	xor    %r8d,%r8d
    45a7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    45ae:	00 00 
    45b0:	4e 8b 0c c1          	mov    (%rcx,%r8,8),%r9
    45b4:	49 f7 d1             	not    %r9
    45b7:	4e 23 0c c0          	and    (%rax,%r8,8),%r9
    45bb:	4d 89 e2             	mov    %r12,%r10
    45be:	f3 4d 0f bc e1       	tzcnt  %r9,%r12
    45c3:	49 01 f4             	add    %rsi,%r12
    45c6:	4d 85 c9             	test   %r9,%r9
    45c9:	4d 0f 44 e2          	cmove  %r10,%r12
    45cd:	49 ff c0             	inc    %r8
    45d0:	49 39 d0             	cmp    %rdx,%r8
    45d3:	0f 83 70 ff ff ff    	jae    4549 <fwp_gc_verify_minor+0x159>
    45d9:	48 83 c6 40          	add    $0x40,%rsi
    45dd:	4d 85 c9             	test   %r9,%r9
    45e0:	74 ce                	je     45b0 <fwp_gc_verify_minor+0x1c0>
    45e2:	e9 62 ff ff ff       	jmp    4549 <fwp_gc_verify_minor+0x159>
    45e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    45ee:	00 00 
    45f0:	42 80 7c 33 03 00    	cmpb   $0x0,0x3(%rbx,%r14,1)
    45f6:	0f 84 64 ff ff ff    	je     4560 <fwp_gc_verify_minor+0x170>
    45fc:	41 80 3c 3f 00       	cmpb   $0x0,(%r15,%rdi,1)
    4601:	0f 85 59 ff ff ff    	jne    4560 <fwp_gc_verify_minor+0x170>
    4607:	45 31 e4             	xor    %r12d,%r12d
    460a:	e8 71 e8 ff ff       	call   2e80 <fwp_gc_chunk_addr>
    460f:	46 8b 7c 33 08       	mov    0x8(%rbx,%r14,1),%r15d
    4614:	4d 0f af e7          	imul   %r15,%r12
    4618:	49 01 c4             	add    %rax,%r12
    461b:	40 80 fd 01          	cmp    $0x1,%bpl
    461f:	74 05                	je     4626 <fwp_gc_verify_minor+0x236>
    4621:	4e 8b 7c 33 18       	mov    0x18(%rbx,%r14,1),%r15
    4626:	48 8b 05 b3 e9 00 00 	mov    0xe9b3(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    462d:	48 8b 38             	mov    (%rax),%rdi
    4630:	42 0f b6 4c 33 01    	movzbl 0x1(%rbx,%r14,1),%ecx
    4636:	48 8d 35 69 91 00 00 	lea    0x9169(%rip),%rsi        # d7a6 <exec_in_fp0+0x146>
    463d:	4c 89 e2             	mov    %r12,%rdx
    4640:	4d 89 f8             	mov    %r15,%r8
    4643:	31 c0                	xor    %eax,%eax
    4645:	e8 96 dc ff ff       	call   22e0 <fprintf@plt>
    464a:	4d 01 e7             	add    %r12,%r15
    464d:	45 31 ed             	xor    %r13d,%r13d
    4650:	4c 89 7c 24 40       	mov    %r15,0x40(%rsp)
    4655:	eb 17                	jmp    466e <fwp_gc_verify_minor+0x27e>
    4657:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    465e:	00 00 
    4660:	49 ff c5             	inc    %r13
    4663:	4c 3b 6c 24 30       	cmp    0x30(%rsp),%r13
    4668:	0f 84 38 01 00 00    	je     47a6 <fwp_gc_verify_minor+0x3b6>
    466e:	48 8b 05 93 fc 00 00 	mov    0xfc93(%rip),%rax        # 14308 <fwp_gc+0x1078>
    4675:	49 69 cd 28 12 00 00 	imul   $0x1228,%r13,%rcx
    467c:	80 3c 08 01          	cmpb   $0x1,(%rax,%rcx,1)
    4680:	75 de                	jne    4660 <fwp_gc_verify_minor+0x270>
    4682:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    4687:	74 d7                	je     4660 <fwp_gc_verify_minor+0x270>
    4689:	8b 5c 08 0c          	mov    0xc(%rax,%rcx,1),%ebx
    468d:	85 db                	test   %ebx,%ebx
    468f:	74 cf                	je     4660 <fwp_gc_verify_minor+0x270>
    4691:	48 01 c8             	add    %rcx,%rax
    4694:	48 ff c0             	inc    %rax
    4697:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    469c:	4c 89 e8             	mov    %r13,%rax
    469f:	48 c1 e0 09          	shl    $0x9,%rax
    46a3:	48 03 44 24 20       	add    0x20(%rsp),%rax
    46a8:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    46ad:	31 ed                	xor    %ebp,%ebp
    46af:	4c 89 6c 24 38       	mov    %r13,0x38(%rsp)
    46b4:	eb 21                	jmp    46d7 <fwp_gc_verify_minor+0x2e7>
    46b6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    46bd:	00 00 00 
    46c0:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    46c5:	8b 58 0b             	mov    0xb(%rax),%ebx
    46c8:	4c 8b 6c 24 38       	mov    0x38(%rsp),%r13
    46cd:	48 ff c5             	inc    %rbp
    46d0:	89 d8                	mov    %ebx,%eax
    46d2:	48 39 c5             	cmp    %rax,%rbp
    46d5:	73 89                	jae    4660 <fwp_gc_verify_minor+0x270>
    46d7:	48 89 e8             	mov    %rbp,%rax
    46da:	48 c1 e8 06          	shr    $0x6,%rax
    46de:	48 8b 4c 24 50       	mov    0x50(%rsp),%rcx
    46e3:	48 8b 04 c1          	mov    (%rcx,%rax,8),%rax
    46e7:	48 0f a3 e8          	bt     %rbp,%rax
    46eb:	73 e0                	jae    46cd <fwp_gc_verify_minor+0x2dd>
    46ed:	4c 89 ef             	mov    %r13,%rdi
    46f0:	e8 8b e7 ff ff       	call   2e80 <fwp_gc_chunk_addr>
    46f5:	48 89 c2             	mov    %rax,%rdx
    46f8:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    46fd:	44 8b 70 07          	mov    0x7(%rax),%r14d
    4701:	49 83 fe 08          	cmp    $0x8,%r14
    4705:	72 c6                	jb     46cd <fwp_gc_verify_minor+0x2dd>
    4707:	45 89 f0             	mov    %r14d,%r8d
    470a:	4c 0f af f5          	imul   %rbp,%r14
    470e:	48 89 d3             	mov    %rdx,%rbx
    4711:	4c 01 f3             	add    %r14,%rbx
    4714:	45 31 ed             	xor    %r13d,%r13d
    4717:	48 89 54 24 48       	mov    %rdx,0x48(%rsp)
    471c:	eb 10                	jmp    472e <fwp_gc_verify_minor+0x33e>
    471e:	66 90                	xchg   %ax,%ax
    4720:	49 ff c5             	inc    %r13
    4723:	44 89 c0             	mov    %r8d,%eax
    4726:	c1 e8 03             	shr    $0x3,%eax
    4729:	49 39 c5             	cmp    %rax,%r13
    472c:	73 92                	jae    46c0 <fwp_gc_verify_minor+0x2d0>
    472e:	4a 8b 04 eb          	mov    (%rbx,%r13,8),%rax
    4732:	4c 39 e0             	cmp    %r12,%rax
    4735:	72 e9                	jb     4720 <fwp_gc_verify_minor+0x330>
    4737:	4c 39 f8             	cmp    %r15,%rax
    473a:	73 e4                	jae    4720 <fwp_gc_verify_minor+0x330>
    473c:	48 8b 05 9d e8 00 00 	mov    0xe89d(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    4743:	48 8b 38             	mov    (%rax),%rdi
    4746:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
    474b:	41 0f b6 0f          	movzbl (%r15),%ecx
    474f:	42 0f 10 04 32       	movups (%rdx,%r14,1),%xmm0
    4754:	4a 8b 44 32 10       	mov    0x10(%rdx,%r14,1),%rax
    4759:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    475e:	0f 11 04 24          	movups %xmm0,(%rsp)
    4762:	48 8d 35 97 90 00 00 	lea    0x9097(%rip),%rsi        # d800 <exec_in_fp0+0x1a0>
    4769:	48 89 da             	mov    %rbx,%rdx
    476c:	4d 89 e9             	mov    %r13,%r9
    476f:	31 c0                	xor    %eax,%eax
    4771:	e8 6a db ff ff       	call   22e0 <fprintf@plt>
    4776:	48 8b 54 24 48       	mov    0x48(%rsp),%rdx
    477b:	45 8b 47 07          	mov    0x7(%r15),%r8d
    477f:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
    4784:	eb 9a                	jmp    4720 <fwp_gc_verify_minor+0x330>
    4786:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    478b:	e8 c0 d8 ff ff       	call   2050 <free@plt>
    4790:	4c 89 ff             	mov    %r15,%rdi
    4793:	48 83 c4 58          	add    $0x58,%rsp
    4797:	5b                   	pop    %rbx
    4798:	41 5c                	pop    %r12
    479a:	41 5d                	pop    %r13
    479c:	41 5e                	pop    %r14
    479e:	41 5f                	pop    %r15
    47a0:	5d                   	pop    %rbp
    47a1:	e9 aa d8 ff ff       	jmp    2050 <free@plt>
    47a6:	e8 c5 d8 ff ff       	call   2070 <abort@plt>
    47ab:	e8 80 f6 ff ff       	call   3e30 <fwp_gc_oom>

00000000000047b0 <fwp_gc_finalize>:
    47b0:	41 57                	push   %r15
    47b2:	41 56                	push   %r14
    47b4:	41 55                	push   %r13
    47b6:	41 54                	push   %r12
    47b8:	53                   	push   %rbx
    47b9:	4c 8b 3d 88 fc 00 00 	mov    0xfc88(%rip),%r15        # 14448 <fwp_gc+0x11b8>
    47c0:	4d 85 ff             	test   %r15,%r15
    47c3:	74 71                	je     4836 <fwp_gc_finalize+0x86>
    47c5:	4c 8b 25 74 fc 00 00 	mov    0xfc74(%rip),%r12        # 14440 <fwp_gc+0x11b0>
    47cc:	45 31 f6             	xor    %r14d,%r14d
    47cf:	eb 46                	jmp    4817 <fwp_gc_finalize+0x67>
    47d1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    47d8:	0f 1f 84 00 00 00 00 
    47df:	00 
    47e0:	4d 01 e5             	add    %r12,%r13
    47e3:	49 8b 45 08          	mov    0x8(%r13),%rax
    47e7:	49 ff cf             	dec    %r15
    47ea:	4c 89 3d 57 fc 00 00 	mov    %r15,0xfc57(%rip)        # 14448 <fwp_gc+0x11b8>
    47f1:	49 c1 e7 04          	shl    $0x4,%r15
    47f5:	43 0f 10 04 3c       	movups (%r12,%r15,1),%xmm0
    47fa:	41 0f 11 45 00       	movups %xmm0,0x0(%r13)
    47ff:	48 89 df             	mov    %rbx,%rdi
    4802:	ff d0                	call   *%rax
    4804:	4c 8b 25 35 fc 00 00 	mov    0xfc35(%rip),%r12        # 14440 <fwp_gc+0x11b0>
    480b:	4c 8b 3d 36 fc 00 00 	mov    0xfc36(%rip),%r15        # 14448 <fwp_gc+0x11b8>
    4812:	4d 39 fe             	cmp    %r15,%r14
    4815:	73 1f                	jae    4836 <fwp_gc_finalize+0x86>
    4817:	4d 89 f5             	mov    %r14,%r13
    481a:	49 c1 e5 04          	shl    $0x4,%r13
    481e:	4b 8b 1c 2c          	mov    (%r12,%r13,1),%rbx
    4822:	48 89 df             	mov    %rbx,%rdi
    4825:	e8 06 0a 00 00       	call   5230 <fwp_gc_marked>
    482a:	85 c0                	test   %eax,%eax
    482c:	74 b2                	je     47e0 <fwp_gc_finalize+0x30>
    482e:	49 ff c6             	inc    %r14
    4831:	4d 39 fe             	cmp    %r15,%r14
    4834:	72 e1                	jb     4817 <fwp_gc_finalize+0x67>
    4836:	5b                   	pop    %rbx
    4837:	41 5c                	pop    %r12
    4839:	41 5d                	pop    %r13
    483b:	41 5e                	pop    %r14
    483d:	41 5f                	pop    %r15
    483f:	c3                   	ret

0000000000004840 <fwp_gc_sweep>:
    4840:	55                   	push   %rbp
    4841:	41 57                	push   %r15
    4843:	41 56                	push   %r14
    4845:	41 55                	push   %r13
    4847:	41 54                	push   %r12
    4849:	53                   	push   %rbx
    484a:	48 83 ec 28          	sub    $0x28,%rsp
    484e:	48 8d 3d 43 ea 00 00 	lea    0xea43(%rip),%rdi        # 13298 <fwp_gc+0x8>
    4855:	45 31 ff             	xor    %r15d,%r15d
    4858:	ba 40 0b 00 00       	mov    $0xb40,%edx
    485d:	31 f6                	xor    %esi,%esi
    485f:	e8 9c d9 ff ff       	call   2200 <memset@plt>
    4864:	48 83 3d 7c fa 00 00 	cmpq   $0x0,0xfa7c(%rip)        # 142e8 <fwp_gc+0x1058>
    486b:	00 
    486c:	0f 84 06 05 00 00    	je     4d78 <fwp_gc_sweep+0x538>
    4872:	31 c0                	xor    %eax,%eax
    4874:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    4879:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    4880:	55 55 55 
    4883:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    488a:	33 33 33 
    488d:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    4894:	0f 0f 0f 
    4897:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    489e:	01 01 01 
    48a1:	66 0f 6f 2d 47 88 00 	movdqa 0x8847(%rip),%xmm5        # d0f0 <_IO_stdin_used+0xf0>
    48a8:	00 
    48a9:	66 0f 6f 35 4f 88 00 	movdqa 0x884f(%rip),%xmm6        # d100 <_IO_stdin_used+0x100>
    48b0:	00 
    48b1:	66 0f 6f 3d 57 88 00 	movdqa 0x8857(%rip),%xmm7        # d110 <_IO_stdin_used+0x110>
    48b8:	00 
    48b9:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    48be:	45 31 ff             	xor    %r15d,%r15d
    48c1:	31 db                	xor    %ebx,%ebx
    48c3:	eb 63                	jmp    4928 <fwp_gc_sweep+0xe8>
    48c5:	4c 8b 64 24 10       	mov    0x10(%rsp),%r12
    48ca:	4c 89 e7             	mov    %r12,%rdi
    48cd:	e8 ee 09 00 00       	call   52c0 <fwp_rc_clear_chunk>
    48d2:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    48d7:	66 0f 6f 3d 31 88 00 	movdqa 0x8831(%rip),%xmm7        # d110 <_IO_stdin_used+0x110>
    48de:	00 
    48df:	66 0f 6f 35 19 88 00 	movdqa 0x8819(%rip),%xmm6        # d100 <_IO_stdin_used+0x100>
    48e6:	00 
    48e7:	66 0f 6f 2d 01 88 00 	movdqa 0x8801(%rip),%xmm5        # d0f0 <_IO_stdin_used+0xf0>
    48ee:	00 
    48ef:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    48f6:	01 01 01 
    48f9:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    4900:	0f 0f 0f 
    4903:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    490a:	33 33 33 
    490d:	41 c6 04 24 00       	movb   $0x0,(%r12)
    4912:	49 ff c7             	inc    %r15
    4915:	48 ff c3             	inc    %rbx
    4918:	48 8b 05 c9 f9 00 00 	mov    0xf9c9(%rip),%rax        # 142e8 <fwp_gc+0x1058>
    491f:	48 39 c3             	cmp    %rax,%rbx
    4922:	0f 83 59 04 00 00    	jae    4d81 <fwp_gc_sweep+0x541>
    4928:	4c 8b 2d d9 f9 00 00 	mov    0xf9d9(%rip),%r13        # 14308 <fwp_gc+0x1078>
    492f:	4c 69 e3 28 12 00 00 	imul   $0x1228,%rbx,%r12
    4936:	43 0f b6 44 25 00    	movzbl 0x0(%r13,%r12,1),%eax
    493c:	85 c0                	test   %eax,%eax
    493e:	74 d2                	je     4912 <fwp_gc_sweep+0xd2>
    4940:	83 f8 01             	cmp    $0x1,%eax
    4943:	74 2b                	je     4970 <fwp_gc_sweep+0x130>
    4945:	83 f8 02             	cmp    $0x2,%eax
    4948:	75 cb                	jne    4915 <fwp_gc_sweep+0xd5>
    494a:	47 8b 74 25 10       	mov    0x10(%r13,%r12,1),%r14d
    494f:	43 80 7c 25 03 00    	cmpb   $0x0,0x3(%r13,%r12,1)
    4955:	74 4c                	je     49a3 <fwp_gc_sweep+0x163>
    4957:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    495c:	4b 03 44 25 18       	add    0x18(%r13,%r12,1),%rax
    4961:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    4966:	e9 f8 03 00 00       	jmp    4d63 <fwp_gc_sweep+0x523>
    496b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    4970:	4b 8d 04 2c          	lea    (%r12,%r13,1),%rax
    4974:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    4979:	43 8b 6c 25 0c       	mov    0xc(%r13,%r12,1),%ebp
    497e:	48 85 ed             	test   %rbp,%rbp
    4981:	0f 84 3e ff ff ff    	je     48c5 <fwp_gc_sweep+0x85>
    4987:	48 8d 55 3f          	lea    0x3f(%rbp),%rdx
    498b:	48 89 d0             	mov    %rdx,%rax
    498e:	48 c1 e8 06          	shr    $0x6,%rax
    4992:	81 fd c1 00 00 00    	cmp    $0xc1,%ebp
    4998:	73 75                	jae    4a0f <fwp_gc_sweep+0x1cf>
    499a:	31 d2                	xor    %edx,%edx
    499c:	31 c9                	xor    %ecx,%ecx
    499e:	e9 3c 01 00 00       	jmp    4adf <fwp_gc_sweep+0x29f>
    49a3:	4b 8d 3c 2c          	lea    (%r12,%r13,1),%rdi
    49a7:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    49ae:	e8 ad e4 ff ff       	call   2e60 <fwp_rc_clear_slot>
    49b3:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    49b8:	66 0f 6f 3d 50 87 00 	movdqa 0x8750(%rip),%xmm7        # d110 <_IO_stdin_used+0x110>
    49bf:	00 
    49c0:	66 0f 6f 35 38 87 00 	movdqa 0x8738(%rip),%xmm6        # d100 <_IO_stdin_used+0x100>
    49c7:	00 
    49c8:	66 0f 6f 2d 20 87 00 	movdqa 0x8720(%rip),%xmm5        # d0f0 <_IO_stdin_used+0xf0>
    49cf:	00 
    49d0:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    49d7:	01 01 01 
    49da:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    49e1:	0f 0f 0f 
    49e4:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    49eb:	33 33 33 
    49ee:	4d 85 f6             	test   %r14,%r14
    49f1:	0f 84 69 03 00 00    	je     4d60 <fwp_gc_sweep+0x520>
    49f7:	48 8b 05 0a f9 00 00 	mov    0xf90a(%rip),%rax        # 14308 <fwp_gc+0x1078>
    49fe:	41 83 fe 04          	cmp    $0x4,%r14d
    4a02:	0f 83 e6 02 00 00    	jae    4cee <fwp_gc_sweep+0x4ae>
    4a08:	31 c9                	xor    %ecx,%ecx
    4a0a:	e9 19 03 00 00       	jmp    4d28 <fwp_gc_sweep+0x4e8>
    4a0f:	89 c1                	mov    %eax,%ecx
    4a11:	83 e1 fc             	and    $0xfffffffc,%ecx
    4a14:	4b 8d 34 2c          	lea    (%r12,%r13,1),%rsi
    4a18:	48 83 c6 38          	add    $0x38,%rsi
    4a1c:	48 c1 ea 03          	shr    $0x3,%rdx
    4a20:	83 e2 e0             	and    $0xffffffe0,%edx
    4a23:	66 0f ef c0          	pxor   %xmm0,%xmm0
    4a27:	31 ff                	xor    %edi,%edi
    4a29:	66 0f ef c9          	pxor   %xmm1,%xmm1
    4a2d:	0f 1f 00             	nopl   (%rax)
    4a30:	f3 0f 6f 5c 3e f0    	movdqu -0x10(%rsi,%rdi,1),%xmm3
    4a36:	f3 0f 6f 14 3e       	movdqu (%rsi,%rdi,1),%xmm2
    4a3b:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    4a3f:	66 0f 71 d4 01       	psrlw  $0x1,%xmm4
    4a44:	66 0f db e5          	pand   %xmm5,%xmm4
    4a48:	66 0f f8 dc          	psubb  %xmm4,%xmm3
    4a4c:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    4a50:	66 0f db e6          	pand   %xmm6,%xmm4
    4a54:	66 0f 71 d3 02       	psrlw  $0x2,%xmm3
    4a59:	66 0f db de          	pand   %xmm6,%xmm3
    4a5d:	66 0f fc dc          	paddb  %xmm4,%xmm3
    4a61:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    4a65:	66 0f 71 d4 04       	psrlw  $0x4,%xmm4
    4a6a:	66 0f fc e3          	paddb  %xmm3,%xmm4
    4a6e:	66 0f db e7          	pand   %xmm7,%xmm4
    4a72:	66 41 0f f6 e0       	psadbw %xmm8,%xmm4
    4a77:	66 0f d4 c4          	paddq  %xmm4,%xmm0
    4a7b:	66 0f 6f da          	movdqa %xmm2,%xmm3
    4a7f:	66 0f 71 d3 01       	psrlw  $0x1,%xmm3
    4a84:	66 0f db dd          	pand   %xmm5,%xmm3
    4a88:	66 0f f8 d3          	psubb  %xmm3,%xmm2
    4a8c:	66 0f 6f da          	movdqa %xmm2,%xmm3
    4a90:	66 0f db de          	pand   %xmm6,%xmm3
    4a94:	66 0f 71 d2 02       	psrlw  $0x2,%xmm2
    4a99:	66 0f db d6          	pand   %xmm6,%xmm2
    4a9d:	66 0f fc d3          	paddb  %xmm3,%xmm2
    4aa1:	66 0f 6f da          	movdqa %xmm2,%xmm3
    4aa5:	66 0f 71 d3 04       	psrlw  $0x4,%xmm3
    4aaa:	66 0f fc da          	paddb  %xmm2,%xmm3
    4aae:	66 0f db df          	pand   %xmm7,%xmm3
    4ab2:	66 41 0f f6 d8       	psadbw %xmm8,%xmm3
    4ab7:	66 0f d4 cb          	paddq  %xmm3,%xmm1
    4abb:	48 83 c7 20          	add    $0x20,%rdi
    4abf:	48 39 fa             	cmp    %rdi,%rdx
    4ac2:	0f 85 68 ff ff ff    	jne    4a30 <fwp_gc_sweep+0x1f0>
    4ac8:	66 0f d4 c8          	paddq  %xmm0,%xmm1
    4acc:	66 0f 70 c1 ee       	pshufd $0xee,%xmm1,%xmm0
    4ad1:	66 0f d4 c1          	paddq  %xmm1,%xmm0
    4ad5:	66 48 0f 7e c2       	movq   %xmm0,%rdx
    4ada:	48 39 c8             	cmp    %rcx,%rax
    4add:	74 51                	je     4b30 <fwp_gc_sweep+0x2f0>
    4adf:	4b 8d 34 2c          	lea    (%r12,%r13,1),%rsi
    4ae3:	48 83 c6 28          	add    $0x28,%rsi
    4ae7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    4aee:	00 00 
    4af0:	48 8b 3c ce          	mov    (%rsi,%rcx,8),%rdi
    4af4:	49 89 f8             	mov    %rdi,%r8
    4af7:	49 d1 e8             	shr    $1,%r8
    4afa:	4d 21 f0             	and    %r14,%r8
    4afd:	4c 29 c7             	sub    %r8,%rdi
    4b00:	49 89 f8             	mov    %rdi,%r8
    4b03:	4d 21 c8             	and    %r9,%r8
    4b06:	48 c1 ef 02          	shr    $0x2,%rdi
    4b0a:	4c 21 cf             	and    %r9,%rdi
    4b0d:	4c 01 c7             	add    %r8,%rdi
    4b10:	49 89 f8             	mov    %rdi,%r8
    4b13:	49 c1 e8 04          	shr    $0x4,%r8
    4b17:	49 01 f8             	add    %rdi,%r8
    4b1a:	4d 21 d0             	and    %r10,%r8
    4b1d:	4d 0f af c3          	imul   %r11,%r8
    4b21:	49 c1 e8 38          	shr    $0x38,%r8
    4b25:	4c 01 c2             	add    %r8,%rdx
    4b28:	48 ff c1             	inc    %rcx
    4b2b:	48 39 c8             	cmp    %rcx,%rax
    4b2e:	75 c0                	jne    4af0 <fwp_gc_sweep+0x2b0>
    4b30:	48 85 d2             	test   %rdx,%rdx
    4b33:	0f 84 8c fd ff ff    	je     48c5 <fwp_gc_sweep+0x85>
    4b39:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    4b3e:	43 8b 44 25 08       	mov    0x8(%r13,%r12,1),%eax
    4b43:	48 0f af d0          	imul   %rax,%rdx
    4b47:	48 01 54 24 08       	add    %rdx,0x8(%rsp)
    4b4c:	47 0f b6 74 25 01    	movzbl 0x1(%r13,%r12,1),%r14d
    4b52:	47 0f b6 7c 25 02    	movzbl 0x2(%r13,%r12,1),%r15d
    4b58:	48 89 df             	mov    %rbx,%rdi
    4b5b:	e8 20 e3 ff ff       	call   2e80 <fwp_gc_chunk_addr>
    4b60:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    4b65:	48 85 ed             	test   %rbp,%rbp
    4b68:	0f 84 31 01 00 00    	je     4c9f <fwp_gc_sweep+0x45f>
    4b6e:	49 69 c6 c0 03 00 00 	imul   $0x3c0,%r14,%rax
    4b75:	48 8d 0d 14 e7 00 00 	lea    0xe714(%rip),%rcx        # 13290 <fwp_gc>
    4b7c:	48 01 c8             	add    %rcx,%rax
    4b7f:	4f 8d 34 2c          	lea    (%r12,%r13,1),%r14
    4b83:	49 83 c6 08          	add    $0x8,%r14
    4b87:	4b 8d 0c 7f          	lea    (%r15,%r15,2),%rcx
    4b8b:	4c 8d 3c c8          	lea    (%rax,%rcx,8),%r15
    4b8f:	49 83 c7 08          	add    $0x8,%r15
    4b93:	49 01 ec             	add    %rbp,%r12
    4b96:	4d 01 ec             	add    %r13,%r12
    4b99:	49 81 c4 27 02 00 00 	add    $0x227,%r12
    4ba0:	48 ff cd             	dec    %rbp
    4ba3:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    4baa:	33 33 33 
    4bad:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    4bb4:	0f 0f 0f 
    4bb7:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    4bbe:	01 01 01 
    4bc1:	66 0f 6f 2d 27 85 00 	movdqa 0x8527(%rip),%xmm5        # d0f0 <_IO_stdin_used+0xf0>
    4bc8:	00 
    4bc9:	66 0f 6f 35 2f 85 00 	movdqa 0x852f(%rip),%xmm6        # d100 <_IO_stdin_used+0x100>
    4bd0:	00 
    4bd1:	66 0f 6f 3d 37 85 00 	movdqa 0x8537(%rip),%xmm7        # d110 <_IO_stdin_used+0x110>
    4bd8:	00 
    4bd9:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    4bde:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    4be3:	eb 69                	jmp    4c4e <fwp_gc_sweep+0x40e>
    4be5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    4bec:	00 00 00 00 
    4bf0:	4c 89 e7             	mov    %r12,%rdi
    4bf3:	e8 68 e2 ff ff       	call   2e60 <fwp_rc_clear_slot>
    4bf8:	49 8b 07             	mov    (%r15),%rax
    4bfb:	48 f7 d0             	not    %rax
    4bfe:	49 89 45 00          	mov    %rax,0x0(%r13)
    4c02:	4d 89 2f             	mov    %r13,(%r15)
    4c05:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    4c0c:	33 33 33 
    4c0f:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    4c16:	0f 0f 0f 
    4c19:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    4c20:	01 01 01 
    4c23:	66 0f 6f 2d c5 84 00 	movdqa 0x84c5(%rip),%xmm5        # d0f0 <_IO_stdin_used+0xf0>
    4c2a:	00 
    4c2b:	66 0f 6f 35 cd 84 00 	movdqa 0x84cd(%rip),%xmm6        # d100 <_IO_stdin_used+0x100>
    4c32:	00 
    4c33:	66 0f 6f 3d d5 84 00 	movdqa 0x84d5(%rip),%xmm7        # d110 <_IO_stdin_used+0x110>
    4c3a:	00 
    4c3b:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    4c40:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    4c45:	49 ff cc             	dec    %r12
    4c48:	48 83 c5 ff          	add    $0xffffffffffffffff,%rbp
    4c4c:	73 3d                	jae    4c8b <fwp_gc_sweep+0x44b>
    4c4e:	48 89 e8             	mov    %rbp,%rax
    4c51:	48 c1 e8 06          	shr    $0x6,%rax
    4c55:	48 8b 44 c1 28       	mov    0x28(%rcx,%rax,8),%rax
    4c5a:	48 0f a3 e8          	bt     %rbp,%rax
    4c5e:	72 e5                	jb     4c45 <fwp_gc_sweep+0x405>
    4c60:	41 8b 16             	mov    (%r14),%edx
    4c63:	49 89 ed             	mov    %rbp,%r13
    4c66:	4c 0f af ea          	imul   %rdx,%r13
    4c6a:	4c 03 6c 24 20       	add    0x20(%rsp),%r13
    4c6f:	83 3d 1e f6 00 00 00 	cmpl   $0x0,0xf61e(%rip)        # 14294 <fwp_gc+0x1004>
    4c76:	0f 84 74 ff ff ff    	je     4bf0 <fwp_gc_sweep+0x3b0>
    4c7c:	4c 89 ef             	mov    %r13,%rdi
    4c7f:	31 f6                	xor    %esi,%esi
    4c81:	e8 7a d5 ff ff       	call   2200 <memset@plt>
    4c86:	e9 65 ff ff ff       	jmp    4bf0 <fwp_gc_sweep+0x3b0>
    4c8b:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    4c90:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    4c97:	55 55 55 
    4c9a:	e9 76 fc ff ff       	jmp    4915 <fwp_gc_sweep+0xd5>
    4c9f:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    4ca4:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    4cab:	55 55 55 
    4cae:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    4cb5:	33 33 33 
    4cb8:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    4cbf:	0f 0f 0f 
    4cc2:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    4cc9:	01 01 01 
    4ccc:	66 0f 6f 2d 1c 84 00 	movdqa 0x841c(%rip),%xmm5        # d0f0 <_IO_stdin_used+0xf0>
    4cd3:	00 
    4cd4:	66 0f 6f 35 24 84 00 	movdqa 0x8424(%rip),%xmm6        # d100 <_IO_stdin_used+0x100>
    4cdb:	00 
    4cdc:	66 0f 6f 3d 2c 84 00 	movdqa 0x842c(%rip),%xmm7        # d110 <_IO_stdin_used+0x110>
    4ce3:	00 
    4ce4:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    4ce9:	e9 27 fc ff ff       	jmp    4915 <fwp_gc_sweep+0xd5>
    4cee:	4a 8d 14 20          	lea    (%rax,%r12,1),%rdx
    4cf2:	44 89 f6             	mov    %r14d,%esi
    4cf5:	83 e6 fc             	and    $0xfffffffc,%esi
    4cf8:	31 c9                	xor    %ecx,%ecx
    4cfa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    4d00:	c6 02 00             	movb   $0x0,(%rdx)
    4d03:	c6 82 28 12 00 00 00 	movb   $0x0,0x1228(%rdx)
    4d0a:	c6 82 50 24 00 00 00 	movb   $0x0,0x2450(%rdx)
    4d11:	c6 82 78 36 00 00 00 	movb   $0x0,0x3678(%rdx)
    4d18:	48 83 c1 04          	add    $0x4,%rcx
    4d1c:	48 81 c2 a0 48 00 00 	add    $0x48a0,%rdx
    4d23:	48 39 ce             	cmp    %rcx,%rsi
    4d26:	75 d8                	jne    4d00 <fwp_gc_sweep+0x4c0>
    4d28:	44 89 f2             	mov    %r14d,%edx
    4d2b:	83 e2 03             	and    $0x3,%edx
    4d2e:	74 30                	je     4d60 <fwp_gc_sweep+0x520>
    4d30:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    4d37:	4c 01 e1             	add    %r12,%rcx
    4d3a:	48 01 c8             	add    %rcx,%rax
    4d3d:	48 69 ca 28 12 00 00 	imul   $0x1228,%rdx,%rcx
    4d44:	31 d2                	xor    %edx,%edx
    4d46:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    4d4d:	00 00 00 
    4d50:	c6 04 10 00          	movb   $0x0,(%rax,%rdx,1)
    4d54:	48 81 c2 28 12 00 00 	add    $0x1228,%rdx
    4d5b:	48 39 d1             	cmp    %rdx,%rcx
    4d5e:	75 f0                	jne    4d50 <fwp_gc_sweep+0x510>
    4d60:	4d 01 f7             	add    %r14,%r15
    4d63:	4c 01 f3             	add    %r14,%rbx
    4d66:	48 ff cb             	dec    %rbx
    4d69:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    4d70:	55 55 55 
    4d73:	e9 9d fb ff ff       	jmp    4915 <fwp_gc_sweep+0xd5>
    4d78:	31 c0                	xor    %eax,%eax
    4d7a:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    4d7f:	31 c0                	xor    %eax,%eax
    4d81:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    4d86:	48 89 15 cb f6 00 00 	mov    %rdx,0xf6cb(%rip)        # 14458 <fwp_gc+0x11c8>
    4d8d:	4c 89 3d dc f6 00 00 	mov    %r15,0xf6dc(%rip)        # 14470 <fwp_gc+0x11e0>
    4d94:	48 81 fa 01 00 00 01 	cmp    $0x1000001,%rdx
    4d9b:	b9 00 00 00 01       	mov    $0x1000000,%ecx
    4da0:	48 0f 43 ca          	cmovae %rdx,%rcx
    4da4:	48 c1 e9 10          	shr    $0x10,%rcx
    4da8:	66 0f ef c0          	pxor   %xmm0,%xmm0
    4dac:	f3 0f 7f 05 44 f5 00 	movdqu %xmm0,0xf544(%rip)        # 142f8 <fwp_gc+0x1068>
    4db3:	00 
    4db4:	49 29 cf             	sub    %rcx,%r15
    4db7:	0f 86 01 01 00 00    	jbe    4ebe <fwp_gc_sweep+0x67e>
    4dbd:	48 85 c0             	test   %rax,%rax
    4dc0:	0f 84 f8 00 00 00    	je     4ebe <fwp_gc_sweep+0x67e>
    4dc6:	4d 85 ff             	test   %r15,%r15
    4dc9:	0f 84 ef 00 00 00    	je     4ebe <fwp_gc_sweep+0x67e>
    4dcf:	48 8b 0d 32 f5 00 00 	mov    0xf532(%rip),%rcx        # 14308 <fwp_gc+0x1078>
    4dd6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    4ddd:	00 00 00 
    4de0:	48 8d 58 ff          	lea    -0x1(%rax),%rbx
    4de4:	48 69 d3 28 12 00 00 	imul   $0x1228,%rbx,%rdx
    4deb:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
    4def:	0f 85 b8 00 00 00    	jne    4ead <fwp_gc_sweep+0x66d>
    4df5:	4c 89 ff             	mov    %r15,%rdi
    4df8:	49 ff cf             	dec    %r15
    4dfb:	80 7c 11 04 00       	cmpb   $0x0,0x4(%rcx,%rdx,1)
    4e00:	0f 84 a7 00 00 00    	je     4ead <fwp_gc_sweep+0x66d>
    4e06:	48 01 ca             	add    %rcx,%rdx
    4e09:	48 83 c2 04          	add    $0x4,%rdx
    4e0d:	c6 02 00             	movb   $0x0,(%rdx)
    4e10:	41 be 01 00 00 00    	mov    $0x1,%r14d
    4e16:	48 85 db             	test   %rbx,%rbx
    4e19:	74 6f                	je     4e8a <fwp_gc_sweep+0x64a>
    4e1b:	4d 85 ff             	test   %r15,%r15
    4e1e:	74 6a                	je     4e8a <fwp_gc_sweep+0x64a>
    4e20:	ba 02 00 00 00       	mov    $0x2,%edx
    4e25:	48 29 c2             	sub    %rax,%rdx
    4e28:	48 69 c0 28 12 00 00 	imul   $0x1228,%rax,%rax
    4e2f:	48 01 c1             	add    %rax,%rcx
    4e32:	48 81 c1 b4 db ff ff 	add    $0xffffffffffffdbb4,%rcx
    4e39:	be 02 00 00 00       	mov    $0x2,%esi
    4e3e:	48 29 fe             	sub    %rdi,%rsi
    4e41:	b8 01 00 00 00       	mov    $0x1,%eax
    4e46:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    4e4d:	00 00 00 
    4e50:	80 79 fc 00          	cmpb   $0x0,-0x4(%rcx)
    4e54:	75 31                	jne    4e87 <fwp_gc_sweep+0x647>
    4e56:	80 39 00             	cmpb   $0x0,(%rcx)
    4e59:	74 2c                	je     4e87 <fwp_gc_sweep+0x647>
    4e5b:	48 ff cb             	dec    %rbx
    4e5e:	48 8d 3c 02          	lea    (%rdx,%rax,1),%rdi
    4e62:	49 ff cf             	dec    %r15
    4e65:	c6 01 00             	movb   $0x0,(%rcx)
    4e68:	4c 8d 70 01          	lea    0x1(%rax),%r14
    4e6c:	48 83 ff 01          	cmp    $0x1,%rdi
    4e70:	74 18                	je     4e8a <fwp_gc_sweep+0x64a>
    4e72:	48 01 f0             	add    %rsi,%rax
    4e75:	48 81 c1 d8 ed ff ff 	add    $0xffffffffffffedd8,%rcx
    4e7c:	48 83 f8 01          	cmp    $0x1,%rax
    4e80:	4c 89 f0             	mov    %r14,%rax
    4e83:	75 cb                	jne    4e50 <fwp_gc_sweep+0x610>
    4e85:	eb 03                	jmp    4e8a <fwp_gc_sweep+0x64a>
    4e87:	49 89 c6             	mov    %rax,%r14
    4e8a:	48 89 df             	mov    %rbx,%rdi
    4e8d:	e8 ee df ff ff       	call   2e80 <fwp_gc_chunk_addr>
    4e92:	49 c1 e6 10          	shl    $0x10,%r14
    4e96:	48 89 c7             	mov    %rax,%rdi
    4e99:	4c 89 f6             	mov    %r14,%rsi
    4e9c:	ba 04 00 00 00       	mov    $0x4,%edx
    4ea1:	e8 3a d5 ff ff       	call   23e0 <madvise@plt>
    4ea6:	48 8b 0d 5b f4 00 00 	mov    0xf45b(%rip),%rcx        # 14308 <fwp_gc+0x1078>
    4ead:	48 89 d8             	mov    %rbx,%rax
    4eb0:	48 85 db             	test   %rbx,%rbx
    4eb3:	74 09                	je     4ebe <fwp_gc_sweep+0x67e>
    4eb5:	4d 85 ff             	test   %r15,%r15
    4eb8:	0f 85 22 ff ff ff    	jne    4de0 <fwp_gc_sweep+0x5a0>
    4ebe:	48 83 c4 28          	add    $0x28,%rsp
    4ec2:	5b                   	pop    %rbx
    4ec3:	41 5c                	pop    %r12
    4ec5:	41 5d                	pop    %r13
    4ec7:	41 5e                	pop    %r14
    4ec9:	41 5f                	pop    %r15
    4ecb:	5d                   	pop    %rbp
    4ecc:	c3                   	ret
    4ecd:	0f 1f 00             	nopl   (%rax)

0000000000004ed0 <fwp_gc_scan_stacks>:
    4ed0:	48 8b 35 41 f4 00 00 	mov    0xf441(%rip),%rsi        # 14318 <fwp_gc+0x1088>
    4ed7:	e9 04 01 00 00       	jmp    4fe0 <fwp_gc_scan_root>
    4edc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000004ee0 <fwp_gc_sp>:
    4ee0:	55                   	push   %rbp
    4ee1:	48 89 e5             	mov    %rsp,%rbp
    4ee4:	48 89 e8             	mov    %rbp,%rax
    4ee7:	5d                   	pop    %rbp
    4ee8:	c3                   	ret
    4ee9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000004ef0 <fwp_gc_drain>:
    4ef0:	48 8b 05 39 f5 00 00 	mov    0xf539(%rip),%rax        # 14430 <fwp_gc+0x11a0>
    4ef7:	48 85 c0             	test   %rax,%rax
    4efa:	74 3c                	je     4f38 <fwp_gc_drain+0x48>
    4efc:	50                   	push   %rax
    4efd:	0f 1f 00             	nopl   (%rax)
    4f00:	48 8b 0d 21 f5 00 00 	mov    0xf521(%rip),%rcx        # 14428 <fwp_gc+0x1198>
    4f07:	48 ff c8             	dec    %rax
    4f0a:	48 89 05 1f f5 00 00 	mov    %rax,0xf51f(%rip)        # 14430 <fwp_gc+0x11a0>
    4f11:	48 c1 e0 04          	shl    $0x4,%rax
    4f15:	48 8b 3c 01          	mov    (%rcx,%rax,1),%rdi
    4f19:	48 8b 74 01 08       	mov    0x8(%rcx,%rax,1),%rsi
    4f1e:	48 01 fe             	add    %rdi,%rsi
    4f21:	31 d2                	xor    %edx,%edx
    4f23:	e8 e8 00 00 00       	call   5010 <fwp_gc_scan>
    4f28:	48 8b 05 01 f5 00 00 	mov    0xf501(%rip),%rax        # 14430 <fwp_gc+0x11a0>
    4f2f:	48 85 c0             	test   %rax,%rax
    4f32:	75 cc                	jne    4f00 <fwp_gc_drain+0x10>
    4f34:	48 83 c4 08          	add    $0x8,%rsp
    4f38:	c3                   	ret
    4f39:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000004f40 <fwp_gc_scan_data>:
    4f40:	83 3d d9 f4 00 00 00 	cmpl   $0x0,0xf4d9(%rip)        # 14420 <fwp_gc+0x1190>
    4f47:	0f 8e 87 00 00 00    	jle    4fd4 <fwp_gc_scan_data+0x94>
    4f4d:	41 57                	push   %r15
    4f4f:	41 56                	push   %r14
    4f51:	41 55                	push   %r13
    4f53:	41 54                	push   %r12
    4f55:	53                   	push   %rbx
    4f56:	4c 8d 25 cb f3 00 00 	lea    0xf3cb(%rip),%r12        # 14328 <fwp_gc+0x1098>
    4f5d:	45 31 ed             	xor    %r13d,%r13d
    4f60:	48 8d 1d 29 e3 00 00 	lea    0xe329(%rip),%rbx        # 13290 <fwp_gc>
    4f67:	4c 8d 35 42 fd 00 00 	lea    0xfd42(%rip),%r14        # 14cb0 <fwp_reuse_verify>
    4f6e:	eb 1d                	jmp    4f8d <fwp_gc_scan_data+0x4d>
    4f70:	4c 89 fe             	mov    %r15,%rsi
    4f73:	31 d2                	xor    %edx,%edx
    4f75:	e8 96 00 00 00       	call   5010 <fwp_gc_scan>
    4f7a:	49 ff c5             	inc    %r13
    4f7d:	48 63 05 9c f4 00 00 	movslq 0xf49c(%rip),%rax        # 14420 <fwp_gc+0x1190>
    4f84:	49 83 c4 10          	add    $0x10,%r12
    4f88:	49 39 c5             	cmp    %rax,%r13
    4f8b:	7d 3e                	jge    4fcb <fwp_gc_scan_data+0x8b>
    4f8d:	49 8b 7c 24 f8       	mov    -0x8(%r12),%rdi
    4f92:	49 8b 04 24          	mov    (%r12),%rax
    4f96:	4c 8d 3c 07          	lea    (%rdi,%rax,1),%r15
    4f9a:	0f 57 c0             	xorps  %xmm0,%xmm0
    4f9d:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    4fa2:	f2 0f 58 05 e6 f4 00 	addsd  0xf4e6(%rip),%xmm0        # 14490 <fwp_gc+0x1200>
    4fa9:	00 
    4faa:	f2 0f 11 05 de f4 00 	movsd  %xmm0,0xf4de(%rip)        # 14490 <fwp_gc+0x1200>
    4fb1:	00 
    4fb2:	48 39 df             	cmp    %rbx,%rdi
    4fb5:	77 b9                	ja     4f70 <fwp_gc_scan_data+0x30>
    4fb7:	4d 39 f7             	cmp    %r14,%r15
    4fba:	72 b4                	jb     4f70 <fwp_gc_scan_data+0x30>
    4fbc:	48 89 de             	mov    %rbx,%rsi
    4fbf:	31 d2                	xor    %edx,%edx
    4fc1:	e8 4a 00 00 00       	call   5010 <fwp_gc_scan>
    4fc6:	4c 89 f7             	mov    %r14,%rdi
    4fc9:	eb a5                	jmp    4f70 <fwp_gc_scan_data+0x30>
    4fcb:	5b                   	pop    %rbx
    4fcc:	41 5c                	pop    %r12
    4fce:	41 5d                	pop    %r13
    4fd0:	41 5e                	pop    %r14
    4fd2:	41 5f                	pop    %r15
    4fd4:	c3                   	ret
    4fd5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    4fdc:	00 00 00 00 

0000000000004fe0 <fwp_gc_scan_root>:
    4fe0:	48 85 ff             	test   %rdi,%rdi
    4fe3:	74 24                	je     5009 <fwp_gc_scan_root+0x29>
    4fe5:	48 89 f0             	mov    %rsi,%rax
    4fe8:	48 29 f8             	sub    %rdi,%rax
    4feb:	76 1c                	jbe    5009 <fwp_gc_scan_root+0x29>
    4fed:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    4ff2:	f2 0f 58 05 96 f4 00 	addsd  0xf496(%rip),%xmm0        # 14490 <fwp_gc+0x1200>
    4ff9:	00 
    4ffa:	f2 0f 11 05 8e f4 00 	movsd  %xmm0,0xf48e(%rip)        # 14490 <fwp_gc+0x1200>
    5001:	00 
    5002:	ba 01 00 00 00       	mov    $0x1,%edx
    5007:	eb 07                	jmp    5010 <fwp_gc_scan>
    5009:	c3                   	ret
    500a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000005010 <fwp_gc_scan>:
    5010:	55                   	push   %rbp
    5011:	41 57                	push   %r15
    5013:	41 56                	push   %r14
    5015:	41 55                	push   %r13
    5017:	41 54                	push   %r12
    5019:	53                   	push   %rbx
    501a:	50                   	push   %rax
    501b:	49 89 ff             	mov    %rdi,%r15
    501e:	49 83 c7 07          	add    $0x7,%r15
    5022:	49 83 e7 f8          	and    $0xfffffffffffffff8,%r15
    5026:	49 8d 47 08          	lea    0x8(%r15),%rax
    502a:	48 39 f0             	cmp    %rsi,%rax
    502d:	76 0f                	jbe    503e <fwp_gc_scan+0x2e>
    502f:	48 83 c4 08          	add    $0x8,%rsp
    5033:	5b                   	pop    %rbx
    5034:	41 5c                	pop    %r12
    5036:	41 5d                	pop    %r13
    5038:	41 5e                	pop    %r14
    503a:	41 5f                	pop    %r15
    503c:	5d                   	pop    %rbp
    503d:	c3                   	ret
    503e:	89 d3                	mov    %edx,%ebx
    5040:	49 89 f6             	mov    %rsi,%r14
    5043:	4c 8b 2d 76 f2 00 00 	mov    0xf276(%rip),%r13        # 142c0 <fwp_gc+0x1030>
    504a:	48 8b 2d 97 f2 00 00 	mov    0xf297(%rip),%rbp        # 142e8 <fwp_gc+0x1058>
    5051:	48 c1 e5 10          	shl    $0x10,%rbp
    5055:	eb 30                	jmp    5087 <fwp_gc_scan+0x77>
    5057:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    505e:	00 00 
    5060:	4c 89 e7             	mov    %r12,%rdi
    5063:	e8 38 00 00 00       	call   50a0 <fwp_gc_mark>
    5068:	85 db                	test   %ebx,%ebx
    506a:	74 0b                	je     5077 <fwp_gc_scan+0x67>
    506c:	49 ff cc             	dec    %r12
    506f:	4c 89 e7             	mov    %r12,%rdi
    5072:	e8 29 00 00 00       	call   50a0 <fwp_gc_mark>
    5077:	49 8d 47 08          	lea    0x8(%r15),%rax
    507b:	49 83 c7 10          	add    $0x10,%r15
    507f:	4d 39 f7             	cmp    %r14,%r15
    5082:	49 89 c7             	mov    %rax,%r15
    5085:	77 a8                	ja     502f <fwp_gc_scan+0x1f>
    5087:	4d 8b 27             	mov    (%r15),%r12
    508a:	4c 89 e0             	mov    %r12,%rax
    508d:	4c 29 e8             	sub    %r13,%rax
    5090:	48 39 e8             	cmp    %rbp,%rax
    5093:	72 cb                	jb     5060 <fwp_gc_scan+0x50>
    5095:	85 db                	test   %ebx,%ebx
    5097:	74 de                	je     5077 <fwp_gc_scan+0x67>
    5099:	48 39 e8             	cmp    %rbp,%rax
    509c:	74 ce                	je     506c <fwp_gc_scan+0x5c>
    509e:	eb d7                	jmp    5077 <fwp_gc_scan+0x67>

00000000000050a0 <fwp_gc_mark>:
    50a0:	41 56                	push   %r14
    50a2:	53                   	push   %rbx
    50a3:	50                   	push   %rax
    50a4:	49 89 fe             	mov    %rdi,%r14
    50a7:	48 89 e6             	mov    %rsp,%rsi
    50aa:	e8 d1 00 00 00       	call   5180 <fwp_gc_chunk_of>
    50af:	48 85 c0             	test   %rax,%rax
    50b2:	0f 84 98 00 00 00    	je     5150 <fwp_gc_mark+0xb0>
    50b8:	0f b6 08             	movzbl (%rax),%ecx
    50bb:	83 f9 03             	cmp    $0x3,%ecx
    50be:	74 6b                	je     512b <fwp_gc_mark+0x8b>
    50c0:	83 f9 02             	cmp    $0x2,%ecx
    50c3:	74 7b                	je     5140 <fwp_gc_mark+0xa0>
    50c5:	83 f9 01             	cmp    $0x1,%ecx
    50c8:	0f 85 82 00 00 00    	jne    5150 <fwp_gc_mark+0xb0>
    50ce:	8b 58 08             	mov    0x8(%rax),%ebx
    50d1:	41 0f b7 ce          	movzwl %r14w,%ecx
    50d5:	48 89 c6             	mov    %rax,%rsi
    50d8:	89 c8                	mov    %ecx,%eax
    50da:	31 d2                	xor    %edx,%edx
    50dc:	f7 f3                	div    %ebx
    50de:	41 89 c6             	mov    %eax,%r14d
    50e1:	3b 46 0c             	cmp    0xc(%rsi),%eax
    50e4:	73 6a                	jae    5150 <fwp_gc_mark+0xb0>
    50e6:	48 89 f0             	mov    %rsi,%rax
    50e9:	ba 01 00 00 00       	mov    $0x1,%edx
    50ee:	44 89 f1             	mov    %r14d,%ecx
    50f1:	48 d3 e2             	shl    %cl,%rdx
    50f4:	44 89 f1             	mov    %r14d,%ecx
    50f7:	c1 e9 06             	shr    $0x6,%ecx
    50fa:	48 8b 74 ce 28       	mov    0x28(%rsi,%rcx,8),%rsi
    50ff:	4c 0f a3 f6          	bt     %r14,%rsi
    5103:	72 4b                	jb     5150 <fwp_gc_mark+0xb0>
    5105:	48 09 d6             	or     %rdx,%rsi
    5108:	48 89 74 c8 28       	mov    %rsi,0x28(%rax,%rcx,8)
    510d:	80 78 01 01          	cmpb   $0x1,0x1(%rax)
    5111:	74 3d                	je     5150 <fwp_gc_mark+0xb0>
    5113:	48 8b 3c 24          	mov    (%rsp),%rdi
    5117:	e8 64 dd ff ff       	call   2e80 <fwp_gc_chunk_addr>
    511c:	4c 0f af f3          	imul   %rbx,%r14
    5120:	49 01 c6             	add    %rax,%r14
    5123:	4c 89 f7             	mov    %r14,%rdi
    5126:	48 89 de             	mov    %rbx,%rsi
    5129:	eb 40                	jmp    516b <fwp_gc_mark+0xcb>
    512b:	8b 40 10             	mov    0x10(%rax),%eax
    512e:	48 89 04 24          	mov    %rax,(%rsp)
    5132:	48 69 c0 28 12 00 00 	imul   $0x1228,%rax,%rax
    5139:	48 03 05 c8 f1 00 00 	add    0xf1c8(%rip),%rax        # 14308 <fwp_gc+0x1078>
    5140:	80 78 03 00          	cmpb   $0x0,0x3(%rax)
    5144:	75 0a                	jne    5150 <fwp_gc_mark+0xb0>
    5146:	c6 40 03 01          	movb   $0x1,0x3(%rax)
    514a:	80 78 01 01          	cmpb   $0x1,0x1(%rax)
    514e:	75 08                	jne    5158 <fwp_gc_mark+0xb8>
    5150:	48 83 c4 08          	add    $0x8,%rsp
    5154:	5b                   	pop    %rbx
    5155:	41 5e                	pop    %r14
    5157:	c3                   	ret
    5158:	48 8b 3c 24          	mov    (%rsp),%rdi
    515c:	48 89 c3             	mov    %rax,%rbx
    515f:	e8 1c dd ff ff       	call   2e80 <fwp_gc_chunk_addr>
    5164:	48 8b 73 18          	mov    0x18(%rbx),%rsi
    5168:	48 89 c7             	mov    %rax,%rdi
    516b:	48 83 c4 08          	add    $0x8,%rsp
    516f:	5b                   	pop    %rbx
    5170:	41 5e                	pop    %r14
    5172:	eb 3c                	jmp    51b0 <fwp_gc_push>
    5174:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    517b:	00 00 00 00 00 

0000000000005180 <fwp_gc_chunk_of>:
    5180:	48 2b 3d 39 f1 00 00 	sub    0xf139(%rip),%rdi        # 142c0 <fwp_gc+0x1030>
    5187:	48 8b 05 5a f1 00 00 	mov    0xf15a(%rip),%rax        # 142e8 <fwp_gc+0x1058>
    518e:	48 c1 e0 10          	shl    $0x10,%rax
    5192:	48 39 c7             	cmp    %rax,%rdi
    5195:	73 16                	jae    51ad <fwp_gc_chunk_of+0x2d>
    5197:	48 c1 ef 10          	shr    $0x10,%rdi
    519b:	48 89 3e             	mov    %rdi,(%rsi)
    519e:	48 69 c7 28 12 00 00 	imul   $0x1228,%rdi,%rax
    51a5:	48 03 05 5c f1 00 00 	add    0xf15c(%rip),%rax        # 14308 <fwp_gc+0x1078>
    51ac:	c3                   	ret
    51ad:	31 c0                	xor    %eax,%eax
    51af:	c3                   	ret

00000000000051b0 <fwp_gc_push>:
    51b0:	41 56                	push   %r14
    51b2:	53                   	push   %rbx
    51b3:	50                   	push   %rax
    51b4:	48 89 f3             	mov    %rsi,%rbx
    51b7:	49 89 fe             	mov    %rdi,%r14
    51ba:	48 8b 0d 6f f2 00 00 	mov    0xf26f(%rip),%rcx        # 14430 <fwp_gc+0x11a0>
    51c1:	48 8b 05 60 f2 00 00 	mov    0xf260(%rip),%rax        # 14428 <fwp_gc+0x1198>
    51c8:	48 3b 0d 69 f2 00 00 	cmp    0xf269(%rip),%rcx        # 14438 <fwp_gc+0x11a8>
    51cf:	75 36                	jne    5207 <fwp_gc_push+0x57>
    51d1:	48 8d 14 09          	lea    (%rcx,%rcx,1),%rdx
    51d5:	48 85 c9             	test   %rcx,%rcx
    51d8:	be 00 10 00 00       	mov    $0x1000,%esi
    51dd:	48 0f 45 f2          	cmovne %rdx,%rsi
    51e1:	48 89 35 50 f2 00 00 	mov    %rsi,0xf250(%rip)        # 14438 <fwp_gc+0x11a8>
    51e8:	48 c1 e6 04          	shl    $0x4,%rsi
    51ec:	48 89 c7             	mov    %rax,%rdi
    51ef:	e8 7c d1 ff ff       	call   2370 <realloc@plt>
    51f4:	48 89 05 2d f2 00 00 	mov    %rax,0xf22d(%rip)        # 14428 <fwp_gc+0x1198>
    51fb:	48 85 c0             	test   %rax,%rax
    51fe:	74 29                	je     5229 <fwp_gc_push+0x79>
    5200:	48 8b 0d 29 f2 00 00 	mov    0xf229(%rip),%rcx        # 14430 <fwp_gc+0x11a0>
    5207:	48 89 ca             	mov    %rcx,%rdx
    520a:	48 c1 e2 04          	shl    $0x4,%rdx
    520e:	4c 89 34 10          	mov    %r14,(%rax,%rdx,1)
    5212:	48 89 5c 10 08       	mov    %rbx,0x8(%rax,%rdx,1)
    5217:	48 ff c1             	inc    %rcx
    521a:	48 89 0d 0f f2 00 00 	mov    %rcx,0xf20f(%rip)        # 14430 <fwp_gc+0x11a0>
    5221:	48 83 c4 08          	add    $0x8,%rsp
    5225:	5b                   	pop    %rbx
    5226:	41 5e                	pop    %r14
    5228:	c3                   	ret
    5229:	e8 02 ec ff ff       	call   3e30 <fwp_gc_oom>
    522e:	66 90                	xchg   %ax,%ax

0000000000005230 <fwp_gc_marked>:
    5230:	53                   	push   %rbx
    5231:	48 83 ec 10          	sub    $0x10,%rsp
    5235:	48 89 fb             	mov    %rdi,%rbx
    5238:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    523d:	e8 3e ff ff ff       	call   5180 <fwp_gc_chunk_of>
    5242:	48 85 c0             	test   %rax,%rax
    5245:	74 36                	je     527d <fwp_gc_marked+0x4d>
    5247:	0f b6 08             	movzbl (%rax),%ecx
    524a:	80 f9 03             	cmp    $0x3,%cl
    524d:	75 19                	jne    5268 <fwp_gc_marked+0x38>
    524f:	48 8b 0d b2 f0 00 00 	mov    0xf0b2(%rip),%rcx        # 14308 <fwp_gc+0x1078>
    5256:	8b 40 10             	mov    0x10(%rax),%eax
    5259:	48 69 d0 28 12 00 00 	imul   $0x1228,%rax,%rdx
    5260:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5264:	0f b6 0c 11          	movzbl (%rcx,%rdx,1),%ecx
    5268:	80 f9 01             	cmp    $0x1,%cl
    526b:	74 17                	je     5284 <fwp_gc_marked+0x54>
    526d:	0f b6 d1             	movzbl %cl,%edx
    5270:	31 c9                	xor    %ecx,%ecx
    5272:	83 fa 02             	cmp    $0x2,%edx
    5275:	75 33                	jne    52aa <fwp_gc_marked+0x7a>
    5277:	0f b6 48 03          	movzbl 0x3(%rax),%ecx
    527b:	eb 2d                	jmp    52aa <fwp_gc_marked+0x7a>
    527d:	b9 01 00 00 00       	mov    $0x1,%ecx
    5282:	eb 26                	jmp    52aa <fwp_gc_marked+0x7a>
    5284:	0f b7 cb             	movzwl %bx,%ecx
    5287:	48 89 c6             	mov    %rax,%rsi
    528a:	89 c8                	mov    %ecx,%eax
    528c:	31 d2                	xor    %edx,%edx
    528e:	f7 76 08             	divl   0x8(%rsi)
    5291:	89 c1                	mov    %eax,%ecx
    5293:	c1 e9 03             	shr    $0x3,%ecx
    5296:	81 e1 f8 1f 00 00    	and    $0x1ff8,%ecx
    529c:	48 8b 54 0e 28       	mov    0x28(%rsi,%rcx,1),%rdx
    52a1:	31 c9                	xor    %ecx,%ecx
    52a3:	48 0f a3 c2          	bt     %rax,%rdx
    52a7:	0f 92 c1             	setb   %cl
    52aa:	89 c8                	mov    %ecx,%eax
    52ac:	48 83 c4 10          	add    $0x10,%rsp
    52b0:	5b                   	pop    %rbx
    52b1:	c3                   	ret
    52b2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    52b9:	1f 84 00 00 00 00 00 

00000000000052c0 <fwp_rc_clear_chunk>:
    52c0:	41 57                	push   %r15
    52c2:	41 56                	push   %r14
    52c4:	53                   	push   %rbx
    52c5:	48 89 fb             	mov    %rdi,%rbx
    52c8:	48 83 3d d8 f9 00 00 	cmpq   $0x0,0xf9d8(%rip)        # 14ca8 <fwp_gc+0x1a18>
    52cf:	00 
    52d0:	74 2c                	je     52fe <fwp_rc_clear_chunk+0x3e>
    52d2:	4c 8d b3 28 02 00 00 	lea    0x228(%rbx),%r14
    52d9:	45 31 ff             	xor    %r15d,%r15d
    52dc:	eb 0e                	jmp    52ec <fwp_rc_clear_chunk+0x2c>
    52de:	66 90                	xchg   %ax,%ax
    52e0:	49 ff c7             	inc    %r15
    52e3:	49 81 ff 00 10 00 00 	cmp    $0x1000,%r15
    52ea:	74 12                	je     52fe <fwp_rc_clear_chunk+0x3e>
    52ec:	43 80 3c 3e ff       	cmpb   $0xff,(%r14,%r15,1)
    52f1:	75 ed                	jne    52e0 <fwp_rc_clear_chunk+0x20>
    52f3:	4b 8d 3c 3e          	lea    (%r14,%r15,1),%rdi
    52f7:	e8 94 db ff ff       	call   2e90 <fwp_rc_forget_slot>
    52fc:	eb e2                	jmp    52e0 <fwp_rc_clear_chunk+0x20>
    52fe:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    5305:	ba 00 10 00 00       	mov    $0x1000,%edx
    530a:	48 89 df             	mov    %rbx,%rdi
    530d:	31 f6                	xor    %esi,%esi
    530f:	5b                   	pop    %rbx
    5310:	41 5e                	pop    %r14
    5312:	41 5f                	pop    %r15
    5314:	e9 e7 ce ff ff       	jmp    2200 <memset@plt>
    5319:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000005320 <fwp_drop0>:
    5320:	53                   	push   %rbx
    5321:	48 89 fb             	mov    %rdi,%rbx
    5324:	e8 97 d6 ff ff       	call   29c0 <fwp_rc_release_last>
    5329:	85 c0                	test   %eax,%eax
    532b:	74 06                	je     5333 <fwp_drop0+0x13>
    532d:	48 89 df             	mov    %rbx,%rdi
    5330:	5b                   	pop    %rbx
    5331:	eb 0d                	jmp    5340 <fwp_rc_free_arr>
    5333:	5b                   	pop    %rbx
    5334:	c3                   	ret
    5335:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    533c:	00 00 00 00 

0000000000005340 <fwp_rc_free_arr>:
    5340:	41 56                	push   %r14
    5342:	53                   	push   %rbx
    5343:	50                   	push   %rax
    5344:	48 89 fb             	mov    %rdi,%rbx
    5347:	e8 94 00 00 00       	call   53e0 <fwp_rc_last>
    534c:	85 c0                	test   %eax,%eax
    534e:	74 7d                	je     53cd <fwp_rc_free_arr+0x8d>
    5350:	8b 0d 5a f9 00 00    	mov    0xf95a(%rip),%ecx        # 14cb0 <fwp_reuse_verify>
    5356:	85 c9                	test   %ecx,%ecx
    5358:	78 0d                	js     5367 <fwp_rc_free_arr+0x27>
    535a:	85 c9                	test   %ecx,%ecx
    535c:	74 41                	je     539f <fwp_rc_free_arr+0x5f>
    535e:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    5365:	eb 66                	jmp    53cd <fwp_rc_free_arr+0x8d>
    5367:	48 8d 3d ea 84 00 00 	lea    0x84ea(%rip),%rdi        # d858 <exec_in_fp0+0x1f8>
    536e:	e8 bd cc ff ff       	call   2030 <getenv@plt>
    5373:	31 c9                	xor    %ecx,%ecx
    5375:	48 85 c0             	test   %rax,%rax
    5378:	74 1b                	je     5395 <fwp_rc_free_arr+0x55>
    537a:	80 38 00             	cmpb   $0x0,(%rax)
    537d:	74 16                	je     5395 <fwp_rc_free_arr+0x55>
    537f:	48 8d 35 04 90 00 00 	lea    0x9004(%rip),%rsi        # e38a <exec_in_fp0+0xd2a>
    5386:	48 89 c7             	mov    %rax,%rdi
    5389:	e8 32 cf ff ff       	call   22c0 <strcmp@plt>
    538e:	31 c9                	xor    %ecx,%ecx
    5390:	85 c0                	test   %eax,%eax
    5392:	0f 95 c1             	setne  %cl
    5395:	89 0d 15 f9 00 00    	mov    %ecx,0xf915(%rip)        # 14cb0 <fwp_reuse_verify>
    539b:	85 c9                	test   %ecx,%ecx
    539d:	75 bf                	jne    535e <fwp_rc_free_arr+0x1e>
    539f:	4c 8b 35 ea de 00 00 	mov    0xdeea(%rip),%r14        # 13290 <fwp_gc>
    53a6:	48 89 df             	mov    %rbx,%rdi
    53a9:	e8 52 00 00 00       	call   5400 <fwp_mem_free>
    53ae:	48 8b 05 db de 00 00 	mov    0xdedb(%rip),%rax        # 13290 <fwp_gc>
    53b5:	4c 29 f0             	sub    %r14,%rax
    53b8:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    53bd:	f2 0f 58 05 d3 f0 00 	addsd  0xf0d3(%rip),%xmm0        # 14498 <fwp_gc+0x1208>
    53c4:	00 
    53c5:	f2 0f 11 05 cb f0 00 	movsd  %xmm0,0xf0cb(%rip)        # 14498 <fwp_gc+0x1208>
    53cc:	00 
    53cd:	48 83 c4 08          	add    $0x8,%rsp
    53d1:	5b                   	pop    %rbx
    53d2:	41 5e                	pop    %r14
    53d4:	c3                   	ret
    53d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    53dc:	00 00 00 00 

00000000000053e0 <fwp_rc_last>:
    53e0:	50                   	push   %rax
    53e1:	e8 0a da ff ff       	call   2df0 <fwp_rc_slot>
    53e6:	48 85 c0             	test   %rax,%rax
    53e9:	74 0d                	je     53f8 <fwp_rc_last+0x18>
    53eb:	48 89 c1             	mov    %rax,%rcx
    53ee:	31 c0                	xor    %eax,%eax
    53f0:	80 39 01             	cmpb   $0x1,(%rcx)
    53f3:	0f 94 c0             	sete   %al
    53f6:	59                   	pop    %rcx
    53f7:	c3                   	ret
    53f8:	31 c0                	xor    %eax,%eax
    53fa:	59                   	pop    %rcx
    53fb:	c3                   	ret
    53fc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000005400 <fwp_mem_free>:
    5400:	48 85 ff             	test   %rdi,%rdi
    5403:	0f 84 c7 01 00 00    	je     55d0 <fwp_mem_free+0x1d0>
    5409:	41 57                	push   %r15
    540b:	41 56                	push   %r14
    540d:	53                   	push   %rbx
    540e:	48 83 ec 10          	sub    $0x10,%rsp
    5412:	49 89 ff             	mov    %rdi,%r15
    5415:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    541a:	e8 61 fd ff ff       	call   5180 <fwp_gc_chunk_of>
    541f:	48 85 c0             	test   %rax,%rax
    5422:	0f 84 9f 01 00 00    	je     55c7 <fwp_mem_free+0x1c7>
    5428:	49 89 c6             	mov    %rax,%r14
    542b:	0f b6 00             	movzbl (%rax),%eax
    542e:	83 f8 02             	cmp    $0x2,%eax
    5431:	0f 84 96 00 00 00    	je     54cd <fwp_mem_free+0xcd>
    5437:	83 f8 01             	cmp    $0x1,%eax
    543a:	0f 85 87 01 00 00    	jne    55c7 <fwp_mem_free+0x1c7>
    5440:	41 0f b6 46 01       	movzbl 0x1(%r14),%eax
    5445:	41 0f b6 4e 02       	movzbl 0x2(%r14),%ecx
    544a:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    5451:	48 8d 35 38 de 00 00 	lea    0xde38(%rip),%rsi        # 13290 <fwp_gc>
    5458:	48 01 c6             	add    %rax,%rsi
    545b:	48 8d 3c 49          	lea    (%rcx,%rcx,2),%rdi
    545f:	41 0f b7 c7          	movzwl %r15w,%eax
    5463:	31 d2                	xor    %edx,%edx
    5465:	41 f7 76 08          	divl   0x8(%r14)
    5469:	48 c7 c2 fe ff ff ff 	mov    $0xfffffffffffffffe,%rdx
    5470:	89 c1                	mov    %eax,%ecx
    5472:	48 d3 c2             	rol    %cl,%rdx
    5475:	48 8d 1c fe          	lea    (%rsi,%rdi,8),%rbx
    5479:	48 83 c3 08          	add    $0x8,%rbx
    547d:	49 8d 3c 06          	lea    (%r14,%rax,1),%rdi
    5481:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    5488:	c1 e8 03             	shr    $0x3,%eax
    548b:	25 f8 1f 00 00       	and    $0x1ff8,%eax
    5490:	49 21 54 06 28       	and    %rdx,0x28(%r14,%rax,1)
    5495:	e8 c6 d9 ff ff       	call   2e60 <fwp_rc_clear_slot>
    549a:	83 3d f3 ed 00 00 00 	cmpl   $0x0,0xedf3(%rip)        # 14294 <fwp_gc+0x1004>
    54a1:	74 0e                	je     54b1 <fwp_mem_free+0xb1>
    54a3:	41 8b 56 08          	mov    0x8(%r14),%edx
    54a7:	4c 89 ff             	mov    %r15,%rdi
    54aa:	31 f6                	xor    %esi,%esi
    54ac:	e8 4f cd ff ff       	call   2200 <memset@plt>
    54b1:	48 8b 03             	mov    (%rbx),%rax
    54b4:	48 f7 d0             	not    %rax
    54b7:	49 89 07             	mov    %rax,(%r15)
    54ba:	4c 89 3b             	mov    %r15,(%rbx)
    54bd:	41 8b 46 08          	mov    0x8(%r14),%eax
    54c1:	48 01 05 c8 dd 00 00 	add    %rax,0xddc8(%rip)        # 13290 <fwp_gc>
    54c8:	e9 fa 00 00 00       	jmp    55c7 <fwp_mem_free+0x1c7>
    54cd:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    54d2:	48 89 df             	mov    %rbx,%rdi
    54d5:	e8 a6 d9 ff ff       	call   2e80 <fwp_gc_chunk_addr>
    54da:	4c 39 f8             	cmp    %r15,%rax
    54dd:	0f 85 e4 00 00 00    	jne    55c7 <fwp_mem_free+0x1c7>
    54e3:	49 8b 46 18          	mov    0x18(%r14),%rax
    54e7:	48 01 05 a2 dd 00 00 	add    %rax,0xdda2(%rip)        # 13290 <fwp_gc>
    54ee:	41 c6 46 03 00       	movb   $0x0,0x3(%r14)
    54f3:	4c 89 f7             	mov    %r14,%rdi
    54f6:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    54fd:	e8 5e d9 ff ff       	call   2e60 <fwp_rc_clear_slot>
    5502:	41 8b 46 10          	mov    0x10(%r14),%eax
    5506:	48 85 c0             	test   %rax,%rax
    5509:	0f 84 91 00 00 00    	je     55a0 <fwp_mem_free+0x1a0>
    550f:	48 8b 0d f2 ed 00 00 	mov    0xedf2(%rip),%rcx        # 14308 <fwp_gc+0x1078>
    5516:	48 69 f3 28 12 00 00 	imul   $0x1228,%rbx,%rsi
    551d:	89 c2                	mov    %eax,%edx
    551f:	83 e2 03             	and    $0x3,%edx
    5522:	83 f8 04             	cmp    $0x4,%eax
    5525:	73 04                	jae    552b <fwp_mem_free+0x12b>
    5527:	31 ff                	xor    %edi,%edi
    5529:	eb 41                	jmp    556c <fwp_mem_free+0x16c>
    552b:	4c 8d 04 31          	lea    (%rcx,%rsi,1),%r8
    552f:	41 89 c1             	mov    %eax,%r9d
    5532:	41 83 e1 fc          	and    $0xfffffffc,%r9d
    5536:	31 ff                	xor    %edi,%edi
    5538:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    553f:	00 
    5540:	41 c6 00 00          	movb   $0x0,(%r8)
    5544:	41 c6 80 28 12 00 00 	movb   $0x0,0x1228(%r8)
    554b:	00 
    554c:	41 c6 80 50 24 00 00 	movb   $0x0,0x2450(%r8)
    5553:	00 
    5554:	41 c6 80 78 36 00 00 	movb   $0x0,0x3678(%r8)
    555b:	00 
    555c:	48 83 c7 04          	add    $0x4,%rdi
    5560:	49 81 c0 a0 48 00 00 	add    $0x48a0,%r8
    5567:	49 39 f9             	cmp    %rdi,%r9
    556a:	75 d4                	jne    5540 <fwp_mem_free+0x140>
    556c:	48 85 d2             	test   %rdx,%rdx
    556f:	74 2f                	je     55a0 <fwp_mem_free+0x1a0>
    5571:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    5578:	48 01 f7             	add    %rsi,%rdi
    557b:	48 01 f9             	add    %rdi,%rcx
    557e:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5585:	31 f6                	xor    %esi,%esi
    5587:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    558e:	00 00 
    5590:	c6 04 31 00          	movb   $0x0,(%rcx,%rsi,1)
    5594:	48 81 c6 28 12 00 00 	add    $0x1228,%rsi
    559b:	48 39 f2             	cmp    %rsi,%rdx
    559e:	75 f0                	jne    5590 <fwp_mem_free+0x190>
    55a0:	48 01 05 c9 ee 00 00 	add    %rax,0xeec9(%rip)        # 14470 <fwp_gc+0x11e0>
    55a7:	48 3b 1d 52 ed 00 00 	cmp    0xed52(%rip),%rbx        # 14300 <fwp_gc+0x1070>
    55ae:	73 07                	jae    55b7 <fwp_mem_free+0x1b7>
    55b0:	48 89 1d 49 ed 00 00 	mov    %rbx,0xed49(%rip)        # 14300 <fwp_gc+0x1070>
    55b7:	48 3b 1d 3a ed 00 00 	cmp    0xed3a(%rip),%rbx        # 142f8 <fwp_gc+0x1068>
    55be:	73 07                	jae    55c7 <fwp_mem_free+0x1c7>
    55c0:	48 89 1d 31 ed 00 00 	mov    %rbx,0xed31(%rip)        # 142f8 <fwp_gc+0x1068>
    55c7:	48 83 c4 10          	add    $0x10,%rsp
    55cb:	5b                   	pop    %rbx
    55cc:	41 5e                	pop    %r14
    55ce:	41 5f                	pop    %r15
    55d0:	c3                   	ret
    55d1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    55d8:	0f 1f 84 00 00 00 00 
    55df:	00 

00000000000055e0 <fwp_drop1>:
    55e0:	53                   	push   %rbx
    55e1:	48 89 fb             	mov    %rdi,%rbx
    55e4:	e8 d7 d3 ff ff       	call   29c0 <fwp_rc_release_last>
    55e9:	85 c0                	test   %eax,%eax
    55eb:	74 09                	je     55f6 <fwp_drop1+0x16>
    55ed:	48 89 df             	mov    %rbx,%rdi
    55f0:	5b                   	pop    %rbx
    55f1:	e9 4a fd ff ff       	jmp    5340 <fwp_rc_free_arr>
    55f6:	5b                   	pop    %rbx
    55f7:	c3                   	ret
    55f8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    55ff:	00 

0000000000005600 <fwp_drop2>:
    5600:	53                   	push   %rbx
    5601:	48 89 fb             	mov    %rdi,%rbx
    5604:	e8 b7 d3 ff ff       	call   29c0 <fwp_rc_release_last>
    5609:	85 c0                	test   %eax,%eax
    560b:	74 09                	je     5616 <fwp_drop2+0x16>
    560d:	48 89 df             	mov    %rbx,%rdi
    5610:	5b                   	pop    %rbx
    5611:	e9 2a fd ff ff       	jmp    5340 <fwp_rc_free_arr>
    5616:	5b                   	pop    %rbx
    5617:	c3                   	ret
    5618:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    561f:	00 

0000000000005620 <fwp_drop3>:
    5620:	53                   	push   %rbx
    5621:	48 89 fb             	mov    %rdi,%rbx
    5624:	e8 97 d3 ff ff       	call   29c0 <fwp_rc_release_last>
    5629:	85 c0                	test   %eax,%eax
    562b:	74 09                	je     5636 <fwp_drop3+0x16>
    562d:	48 89 df             	mov    %rbx,%rdi
    5630:	5b                   	pop    %rbx
    5631:	e9 0a fd ff ff       	jmp    5340 <fwp_rc_free_arr>
    5636:	5b                   	pop    %rbx
    5637:	c3                   	ret
    5638:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    563f:	00 

0000000000005640 <fwp_drop4>:
    5640:	53                   	push   %rbx
    5641:	48 89 fb             	mov    %rdi,%rbx
    5644:	e8 77 d3 ff ff       	call   29c0 <fwp_rc_release_last>
    5649:	85 c0                	test   %eax,%eax
    564b:	74 09                	je     5656 <fwp_drop4+0x16>
    564d:	48 89 df             	mov    %rbx,%rdi
    5650:	5b                   	pop    %rbx
    5651:	e9 ea fc ff ff       	jmp    5340 <fwp_rc_free_arr>
    5656:	5b                   	pop    %rbx
    5657:	c3                   	ret
    5658:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    565f:	00 

0000000000005660 <fwp_drop5>:
    5660:	53                   	push   %rbx
    5661:	48 89 fb             	mov    %rdi,%rbx
    5664:	e8 57 d3 ff ff       	call   29c0 <fwp_rc_release_last>
    5669:	85 c0                	test   %eax,%eax
    566b:	74 09                	je     5676 <fwp_drop5+0x16>
    566d:	48 89 df             	mov    %rbx,%rdi
    5670:	5b                   	pop    %rbx
    5671:	e9 ca fc ff ff       	jmp    5340 <fwp_rc_free_arr>
    5676:	5b                   	pop    %rbx
    5677:	c3                   	ret
    5678:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    567f:	00 

0000000000005680 <fwp_drop6>:
    5680:	53                   	push   %rbx
    5681:	48 89 fb             	mov    %rdi,%rbx
    5684:	e8 37 d3 ff ff       	call   29c0 <fwp_rc_release_last>
    5689:	85 c0                	test   %eax,%eax
    568b:	74 09                	je     5696 <fwp_drop6+0x16>
    568d:	48 89 df             	mov    %rbx,%rdi
    5690:	5b                   	pop    %rbx
    5691:	e9 aa fc ff ff       	jmp    5340 <fwp_rc_free_arr>
    5696:	5b                   	pop    %rbx
    5697:	c3                   	ret
    5698:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    569f:	00 

00000000000056a0 <fwp_drop7>:
    56a0:	53                   	push   %rbx
    56a1:	48 89 fb             	mov    %rdi,%rbx
    56a4:	e8 17 d3 ff ff       	call   29c0 <fwp_rc_release_last>
    56a9:	85 c0                	test   %eax,%eax
    56ab:	74 09                	je     56b6 <fwp_drop7+0x16>
    56ad:	48 89 df             	mov    %rbx,%rdi
    56b0:	5b                   	pop    %rbx
    56b1:	e9 8a fc ff ff       	jmp    5340 <fwp_rc_free_arr>
    56b6:	5b                   	pop    %rbx
    56b7:	c3                   	ret
    56b8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    56bf:	00 

00000000000056c0 <fwp_data>:
    56c0:	55                   	push   %rbp
    56c1:	41 57                	push   %r15
    56c3:	41 56                	push   %r14
    56c5:	53                   	push   %rbx
    56c6:	50                   	push   %rax
    56c7:	89 fd                	mov    %edi,%ebp
    56c9:	85 f6                	test   %esi,%esi
    56cb:	0f 84 a1 00 00 00    	je     5772 <fwp_data+0xb2>
    56d1:	48 89 d3             	mov    %rdx,%rbx
    56d4:	41 89 f6             	mov    %esi,%r14d
    56d7:	4a 8d 3c f5 08 00 00 	lea    0x8(,%r14,8),%rdi
    56de:	00 
    56df:	41 89 f7             	mov    %esi,%r15d
    56e2:	e8 d9 00 00 00       	call   57c0 <fwp_alloc_init>
    56e7:	89 28                	mov    %ebp,(%rax)
    56e9:	44 89 78 04          	mov    %r15d,0x4(%rax)
    56ed:	41 83 ff 08          	cmp    $0x8,%r15d
    56f1:	72 10                	jb     5703 <fwp_data+0x43>
    56f3:	48 89 c1             	mov    %rax,%rcx
    56f6:	48 29 d9             	sub    %rbx,%rcx
    56f9:	48 83 c1 08          	add    $0x8,%rcx
    56fd:	48 83 f9 20          	cmp    $0x20,%rcx
    5701:	73 73                	jae    5776 <fwp_data+0xb6>
    5703:	31 c9                	xor    %ecx,%ecx
    5705:	4c 89 f6             	mov    %r14,%rsi
    5708:	48 89 ca             	mov    %rcx,%rdx
    570b:	48 83 e6 03          	and    $0x3,%rsi
    570f:	74 20                	je     5731 <fwp_data+0x71>
    5711:	48 89 ca             	mov    %rcx,%rdx
    5714:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    571b:	00 00 00 00 00 
    5720:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    5724:	48 89 7c d0 08       	mov    %rdi,0x8(%rax,%rdx,8)
    5729:	48 ff c2             	inc    %rdx
    572c:	48 ff ce             	dec    %rsi
    572f:	75 ef                	jne    5720 <fwp_data+0x60>
    5731:	4c 29 f1             	sub    %r14,%rcx
    5734:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    5738:	77 7b                	ja     57b5 <fwp_data+0xf5>
    573a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    5740:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    5744:	48 89 4c d0 08       	mov    %rcx,0x8(%rax,%rdx,8)
    5749:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    574e:	48 89 4c d0 10       	mov    %rcx,0x10(%rax,%rdx,8)
    5753:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    5758:	48 89 4c d0 18       	mov    %rcx,0x18(%rax,%rdx,8)
    575d:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    5762:	48 89 4c d0 20       	mov    %rcx,0x20(%rax,%rdx,8)
    5767:	48 83 c2 04          	add    $0x4,%rdx
    576b:	49 39 d6             	cmp    %rdx,%r14
    576e:	75 d0                	jne    5740 <fwp_data+0x80>
    5770:	eb 43                	jmp    57b5 <fwp_data+0xf5>
    5772:	89 e8                	mov    %ebp,%eax
    5774:	eb 3f                	jmp    57b5 <fwp_data+0xf5>
    5776:	44 89 f1             	mov    %r14d,%ecx
    5779:	83 e1 fc             	and    $0xfffffffc,%ecx
    577c:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
    5783:	00 
    5784:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    5788:	31 f6                	xor    %esi,%esi
    578a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    5790:	0f 10 04 33          	movups (%rbx,%rsi,1),%xmm0
    5794:	0f 10 4c 33 10       	movups 0x10(%rbx,%rsi,1),%xmm1
    5799:	0f 11 44 30 08       	movups %xmm0,0x8(%rax,%rsi,1)
    579e:	0f 11 4c 30 18       	movups %xmm1,0x18(%rax,%rsi,1)
    57a3:	48 83 c6 20          	add    $0x20,%rsi
    57a7:	48 39 f2             	cmp    %rsi,%rdx
    57aa:	75 e4                	jne    5790 <fwp_data+0xd0>
    57ac:	4c 39 f1             	cmp    %r14,%rcx
    57af:	0f 85 50 ff ff ff    	jne    5705 <fwp_data+0x45>
    57b5:	48 83 c4 08          	add    $0x8,%rsp
    57b9:	5b                   	pop    %rbx
    57ba:	41 5e                	pop    %r14
    57bc:	41 5f                	pop    %r15
    57be:	5d                   	pop    %rbp
    57bf:	c3                   	ret

00000000000057c0 <fwp_alloc_init>:
    57c0:	53                   	push   %rbx
    57c1:	48 89 fa             	mov    %rdi,%rdx
    57c4:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    57cb:	0f 87 a7 00 00 00    	ja     5878 <fwp_alloc_init+0xb8>
    57d1:	48 8d 42 0f          	lea    0xf(%rdx),%rax
    57d5:	48 c1 e8 04          	shr    $0x4,%rax
    57d9:	48 8d 35 b0 da 00 00 	lea    0xdab0(%rip),%rsi        # 13290 <fwp_gc>
    57e0:	0f b6 bc 30 e8 0b 00 	movzbl 0xbe8(%rax,%rsi,1),%edi
    57e7:	00 
    57e8:	8b 84 be 48 0b 00 00 	mov    0xb48(%rsi,%rdi,4),%eax
    57ef:	48 8b 0d 9a da 00 00 	mov    0xda9a(%rip),%rcx        # 13290 <fwp_gc>
    57f6:	49 89 c8             	mov    %rcx,%r8
    57f9:	49 29 c0             	sub    %rax,%r8
    57fc:	4c 89 05 8d da 00 00 	mov    %r8,0xda8d(%rip)        # 13290 <fwp_gc>
    5803:	78 6c                	js     5871 <fwp_alloc_init+0xb1>
    5805:	48 8d 3c 7f          	lea    (%rdi,%rdi,2),%rdi
    5809:	4c 8d 04 fe          	lea    (%rsi,%rdi,8),%r8
    580d:	49 83 c0 08          	add    $0x8,%r8
    5811:	49 8b 18             	mov    (%r8),%rbx
    5814:	48 85 db             	test   %rbx,%rbx
    5817:	74 32                	je     584b <fwp_alloc_init+0x8b>
    5819:	48 8b 0b             	mov    (%rbx),%rcx
    581c:	48 f7 d1             	not    %rcx
    581f:	49 89 08             	mov    %rcx,(%r8)
    5822:	81 e2 f8 7f 00 00    	and    $0x7ff8,%edx
    5828:	48 39 c2             	cmp    %rax,%rdx
    582b:	73 19                	jae    5846 <fwp_alloc_init+0x86>
    582d:	48 8d 3c 13          	lea    (%rbx,%rdx,1),%rdi
    5831:	48 f7 d2             	not    %rdx
    5834:	48 01 c2             	add    %rax,%rdx
    5837:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    583b:	48 83 c2 08          	add    $0x8,%rdx
    583f:	31 f6                	xor    %esi,%esi
    5841:	e8 ba c9 ff ff       	call   2200 <memset@plt>
    5846:	48 89 d8             	mov    %rbx,%rax
    5849:	5b                   	pop    %rbx
    584a:	c3                   	ret
    584b:	48 8b 5c fe 10       	mov    0x10(%rsi,%rdi,8),%rbx
    5850:	4c 8b 44 fe 18       	mov    0x18(%rsi,%rdi,8),%r8
    5855:	49 29 d8             	sub    %rbx,%r8
    5858:	49 39 c0             	cmp    %rax,%r8
    585b:	72 14                	jb     5871 <fwp_alloc_init+0xb1>
    585d:	48 8d 34 fe          	lea    (%rsi,%rdi,8),%rsi
    5861:	48 83 c6 10          	add    $0x10,%rsi
    5865:	48 8d 3c 03          	lea    (%rbx,%rax,1),%rdi
    5869:	48 89 3e             	mov    %rdi,(%rsi)
    586c:	48 85 db             	test   %rbx,%rbx
    586f:	75 b1                	jne    5822 <fwp_alloc_init+0x62>
    5871:	48 89 0d 18 da 00 00 	mov    %rcx,0xda18(%rip)        # 13290 <fwp_gc>
    5878:	48 89 d7             	mov    %rdx,%rdi
    587b:	31 f6                	xor    %esi,%esi
    587d:	5b                   	pop    %rbx
    587e:	e9 bd dd ff ff       	jmp    3640 <fwp_gc_alloc>
    5883:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    588a:	84 00 00 00 00 00 

0000000000005890 <f2>:
    5890:	48 89 fe             	mov    %rdi,%rsi
    5893:	48 bf 00 00 00 00 00 	movabs $0x3fc0000000000000,%rdi
    589a:	00 c0 3f 
    589d:	eb 01                	jmp    58a0 <f4>
    589f:	90                   	nop

00000000000058a0 <f4>:
    58a0:	53                   	push   %rbx
    58a1:	48 83 ec 10          	sub    $0x10,%rsp
    58a5:	48 89 fb             	mov    %rdi,%rbx
    58a8:	48 89 f7             	mov    %rsi,%rdi
    58ab:	e8 20 00 00 00       	call   58d0 <fwp_f64>
    58b0:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    58b6:	48 89 df             	mov    %rbx,%rdi
    58b9:	e8 12 00 00 00       	call   58d0 <fwp_f64>
    58be:	f2 0f 58 44 24 08    	addsd  0x8(%rsp),%xmm0
    58c4:	48 83 c4 10          	add    $0x10,%rsp
    58c8:	5b                   	pop    %rbx
    58c9:	e9 e2 d0 ff ff       	jmp    29b0 <fwp_from_f64>
    58ce:	66 90                	xchg   %ax,%ax

00000000000058d0 <fwp_f64>:
    58d0:	66 48 0f 6e c7       	movq   %rdi,%xmm0
    58d5:	c3                   	ret
    58d6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    58dd:	00 00 00 

00000000000058e0 <f8>:
    58e0:	50                   	push   %rax
    58e1:	e8 ea ff ff ff       	call   58d0 <fwp_f64>
    58e6:	0f 57 05 33 78 00 00 	xorps  0x7833(%rip),%xmm0        # d120 <_IO_stdin_used+0x120>
    58ed:	58                   	pop    %rax
    58ee:	e9 bd d0 ff ff       	jmp    29b0 <fwp_from_f64>
    58f3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    58fa:	84 00 00 00 00 00 

0000000000005900 <fwp_stack_guard_init>:
    5900:	53                   	push   %rbx
    5901:	48 81 ec c0 00 00 00 	sub    $0xc0,%rsp
    5908:	48 8d 44 24 0f       	lea    0xf(%rsp),%rax
    590d:	48 89 05 f4 f4 00 00 	mov    %rax,0xf4f4(%rip)        # 14e08 <fwp_main_stack_top>
    5914:	48 89 3d f5 f4 00 00 	mov    %rdi,0xf4f5(%rip)        # 14e10 <fwp_main_stack_size>
    591b:	48 8d 05 fe f4 00 00 	lea    0xf4fe(%rip),%rax        # 14e20 <fwp_stack_guard_init.alt>
    5922:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    5927:	48 c7 44 24 20 00 00 	movq   $0x10000,0x20(%rsp)
    592e:	01 00 
    5930:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%rsp)
    5937:	00 
    5938:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    593d:	31 f6                	xor    %esi,%esi
    593f:	e8 7c cb ff ff       	call   24c0 <sigaltstack@plt>
    5944:	85 c0                	test   %eax,%eax
    5946:	0f 85 80 00 00 00    	jne    59cc <fwp_stack_guard_init+0xcc>
    594c:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    5951:	0f 57 c0             	xorps  %xmm0,%xmm0
    5954:	0f 11 84 24 b0 00 00 	movups %xmm0,0xb0(%rsp)
    595b:	00 
    595c:	0f 11 84 24 a0 00 00 	movups %xmm0,0xa0(%rsp)
    5963:	00 
    5964:	0f 11 84 24 90 00 00 	movups %xmm0,0x90(%rsp)
    596b:	00 
    596c:	0f 11 84 24 80 00 00 	movups %xmm0,0x80(%rsp)
    5973:	00 
    5974:	0f 11 44 24 70       	movups %xmm0,0x70(%rsp)
    5979:	0f 11 44 24 60       	movups %xmm0,0x60(%rsp)
    597e:	0f 11 44 24 50       	movups %xmm0,0x50(%rsp)
    5983:	0f 11 44 24 40       	movups %xmm0,0x40(%rsp)
    5988:	0f 11 44 24 30       	movups %xmm0,0x30(%rsp)
    598d:	48 8d 05 7c 07 00 00 	lea    0x77c(%rip),%rax        # 6110 <fwp_segv>
    5994:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    5999:	c7 84 24 b0 00 00 00 	movl   $0x8000004,0xb0(%rsp)
    59a0:	04 00 00 08 
    59a4:	e8 57 c9 ff ff       	call   2300 <sigemptyset@plt>
    59a9:	48 8d 5c 24 28       	lea    0x28(%rsp),%rbx
    59ae:	bf 0b 00 00 00       	mov    $0xb,%edi
    59b3:	48 89 de             	mov    %rbx,%rsi
    59b6:	31 d2                	xor    %edx,%edx
    59b8:	e8 13 c7 ff ff       	call   20d0 <sigaction@plt>
    59bd:	bf 07 00 00 00       	mov    $0x7,%edi
    59c2:	48 89 de             	mov    %rbx,%rsi
    59c5:	31 d2                	xor    %edx,%edx
    59c7:	e8 04 c7 ff ff       	call   20d0 <sigaction@plt>
    59cc:	48 81 c4 c0 00 00 00 	add    $0xc0,%rsp
    59d3:	5b                   	pop    %rbx
    59d4:	c3                   	ret
    59d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    59dc:	00 00 00 00 

00000000000059e0 <fwp_exec>:
    59e0:	55                   	push   %rbp
    59e1:	41 57                	push   %r15
    59e3:	41 56                	push   %r14
    59e5:	41 55                	push   %r13
    59e7:	41 54                	push   %r12
    59e9:	53                   	push   %rbx
    59ea:	48 81 ec 58 01 00 00 	sub    $0x158,%rsp
    59f1:	49 89 f7             	mov    %rsi,%r15
    59f4:	41 89 fd             	mov    %edi,%r13d
    59f7:	41 8d 5d ff          	lea    -0x1(%r13),%ebx
    59fb:	80 3d fe f3 00 00 01 	cmpb   $0x1,0xf3fe(%rip)        # 14e00 <fwp_cli_single>
    5a02:	75 16                	jne    5a1a <fwp_exec+0x3a>
    5a04:	49 8d 77 08          	lea    0x8(%r15),%rsi
    5a08:	89 df                	mov    %ebx,%edi
    5a0a:	e8 91 07 00 00       	call   61a0 <fwp_generated>
    5a0f:	41 89 c6             	mov    %eax,%r14d
    5a12:	85 c0                	test   %eax,%eax
    5a14:	0f 89 1a 01 00 00    	jns    5b34 <fwp_exec+0x154>
    5a1a:	89 5c 24 18          	mov    %ebx,0x18(%rsp)
    5a1e:	49 63 fd             	movslq %r13d,%rdi
    5a21:	48 c1 e7 03          	shl    $0x3,%rdi
    5a25:	48 89 7c 24 48       	mov    %rdi,0x48(%rsp)
    5a2a:	e8 01 dc ff ff       	call   3630 <fwp_alloc>
    5a2f:	49 89 c4             	mov    %rax,%r12
    5a32:	41 83 fd 02          	cmp    $0x2,%r13d
    5a36:	7c 30                	jl     5a68 <fwp_exec+0x88>
    5a38:	8b 6c 24 18          	mov    0x18(%rsp),%ebp
    5a3c:	31 db                	xor    %ebx,%ebx
    5a3e:	66 90                	xchg   %ax,%ax
    5a40:	4c 8d 73 01          	lea    0x1(%rbx),%r14
    5a44:	4d 8b 6c df 08       	mov    0x8(%r15,%rbx,8),%r13
    5a49:	4c 89 ef             	mov    %r13,%rdi
    5a4c:	e8 0f c7 ff ff       	call   2160 <strlen@plt>
    5a51:	4c 89 ef             	mov    %r13,%rdi
    5a54:	48 89 c6             	mov    %rax,%rsi
    5a57:	e8 a4 08 00 00       	call   6300 <fwp_str_lossy>
    5a5c:	49 89 04 dc          	mov    %rax,(%r12,%rbx,8)
    5a60:	4c 89 f3             	mov    %r14,%rbx
    5a63:	4c 39 f5             	cmp    %r14,%rbp
    5a66:	75 d8                	jne    5a40 <fwp_exec+0x60>
    5a68:	bf 08 00 00 00       	mov    $0x8,%edi
    5a6d:	e8 be db ff ff       	call   3630 <fwp_alloc>
    5a72:	bf 01 00 00 00       	mov    $0x1,%edi
    5a77:	e8 64 0a 00 00       	call   64e0 <fwp_alloc_leaf>
    5a7c:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
    5a81:	e8 aa db ff ff       	call   3630 <fwp_alloc>
    5a86:	49 89 c6             	mov    %rax,%r14
    5a89:	48 8d 4c 24 2c       	lea    0x2c(%rsp),%rcx
    5a8e:	8b 7c 24 18          	mov    0x18(%rsp),%edi
    5a92:	4c 89 e6             	mov    %r12,%rsi
    5a95:	48 89 c2             	mov    %rax,%rdx
    5a98:	e8 53 0a 00 00       	call   64f0 <fwp_cli_parse>
    5a9d:	83 f8 02             	cmp    $0x2,%eax
    5aa0:	74 32                	je     5ad4 <fwp_exec+0xf4>
    5aa2:	83 f8 01             	cmp    $0x1,%eax
    5aa5:	75 5d                	jne    5b04 <fwp_exec+0x124>
    5aa7:	48 8b 1d 0a d5 00 00 	mov    0xd50a(%rip),%rbx        # 12fb8 <stdout@GLIBC_2.2.5>
    5aae:	48 8b 0b             	mov    (%rbx),%rcx
    5ab1:	48 8d 3d 83 89 00 00 	lea    0x8983(%rip),%rdi        # e43b <exec_in_fp0+0xddb>
    5ab8:	be 72 00 00 00       	mov    $0x72,%esi
    5abd:	ba 01 00 00 00       	mov    $0x1,%edx
    5ac2:	e8 c9 c9 ff ff       	call   2490 <fwrite@plt>
    5ac7:	48 8b 3b             	mov    (%rbx),%rdi
    5aca:	e8 71 c8 ff ff       	call   2340 <fflush@plt>
    5acf:	45 31 f6             	xor    %r14d,%r14d
    5ad2:	eb 60                	jmp    5b34 <fwp_exec+0x154>
    5ad4:	48 8d 3d ce 85 00 00 	lea    0x85ce(%rip),%rdi        # e0a9 <exec_in_fp0+0xa49>
    5adb:	48 8d 15 b9 7b 00 00 	lea    0x7bb9(%rip),%rdx        # d69b <exec_in_fp0+0x3b>
    5ae2:	45 31 f6             	xor    %r14d,%r14d
    5ae5:	be 06 00 00 00       	mov    $0x6,%esi
    5aea:	31 c9                	xor    %ecx,%ecx
    5aec:	31 c0                	xor    %eax,%eax
    5aee:	e8 bd c6 ff ff       	call   21b0 <printf@plt>
    5af3:	48 8b 05 be d4 00 00 	mov    0xd4be(%rip),%rax        # 12fb8 <stdout@GLIBC_2.2.5>
    5afa:	48 8b 38             	mov    (%rax),%rdi
    5afd:	e8 3e c8 ff ff       	call   2340 <fflush@plt>
    5b02:	eb 30                	jmp    5b34 <fwp_exec+0x154>
    5b04:	bf 10 00 00 00       	mov    $0x10,%edi
    5b09:	e8 22 db ff ff       	call   3630 <fwp_alloc>
    5b0e:	49 89 c7             	mov    %rax,%r15
    5b11:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%rsp)
    5b18:	00 
    5b19:	8b 74 24 2c          	mov    0x2c(%rsp),%esi
    5b1d:	48 8d 4c 24 14       	lea    0x14(%rsp),%rcx
    5b22:	4c 89 f7             	mov    %r14,%rdi
    5b25:	48 89 c2             	mov    %rax,%rdx
    5b28:	e8 23 0c 00 00       	call   6750 <fwp_bind_positional>
    5b2d:	41 89 c6             	mov    %eax,%r14d
    5b30:	85 c0                	test   %eax,%eax
    5b32:	74 15                	je     5b49 <fwp_exec+0x169>
    5b34:	44 89 f0             	mov    %r14d,%eax
    5b37:	48 81 c4 58 01 00 00 	add    $0x158,%rsp
    5b3e:	5b                   	pop    %rbx
    5b3f:	41 5c                	pop    %r12
    5b41:	41 5d                	pop    %r13
    5b43:	41 5e                	pop    %r14
    5b45:	41 5f                	pop    %r15
    5b47:	5d                   	pop    %rbp
    5b48:	c3                   	ret
    5b49:	48 8d 3d 62 85 00 00 	lea    0x8562(%rip),%rdi        # e0b2 <exec_in_fp0+0xa52>
    5b50:	e8 db c4 ff ff       	call   2030 <getenv@plt>
    5b55:	48 85 c0             	test   %rax,%rax
    5b58:	74 27                	je     5b81 <fwp_exec+0x1a1>
    5b5a:	48 8d 35 59 85 00 00 	lea    0x8559(%rip),%rsi        # e0ba <exec_in_fp0+0xa5a>
    5b61:	48 89 c7             	mov    %rax,%rdi
    5b64:	e8 57 c7 ff ff       	call   22c0 <strcmp@plt>
    5b69:	31 c9                	xor    %ecx,%ecx
    5b6b:	85 c0                	test   %eax,%eax
    5b6d:	0f 94 c1             	sete   %cl
    5b70:	89 0d aa f2 01 00    	mov    %ecx,0x1f2aa(%rip)        # 24e20 <fwp_exec_binary_out>
    5b76:	75 26                	jne    5b9e <fwp_exec+0x1be>
    5b78:	48 8b 05 61 d4 00 00 	mov    0xd461(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    5b7f:	eb 24                	jmp    5ba5 <fwp_exec+0x1c5>
    5b81:	c7 05 95 f2 01 00 00 	movl   $0x0,0x1f295(%rip)        # 24e20 <fwp_exec_binary_out>
    5b88:	00 00 00 
    5b8b:	48 8b 05 26 d4 00 00 	mov    0xd426(%rip),%rax        # 12fb8 <stdout@GLIBC_2.2.5>
    5b92:	48 8b 00             	mov    (%rax),%rax
    5b95:	48 89 05 0c f2 00 00 	mov    %rax,0xf20c(%rip)        # 14da8 <fwp_prog_out>
    5b9c:	eb 33                	jmp    5bd1 <fwp_exec+0x1f1>
    5b9e:	48 8b 05 13 d4 00 00 	mov    0xd413(%rip),%rax        # 12fb8 <stdout@GLIBC_2.2.5>
    5ba5:	48 8b 00             	mov    (%rax),%rax
    5ba8:	48 89 05 f9 f1 00 00 	mov    %rax,0xf1f9(%rip)        # 14da8 <fwp_prog_out>
    5baf:	75 20                	jne    5bd1 <fwp_exec+0x1f1>
    5bb1:	e8 da 0b 00 00       	call   6790 <fwp_pipe_out_start>
    5bb6:	48 8d 3d 63 7a 00 00 	lea    0x7a63(%rip),%rdi        # d620 <exec_out_header0>
    5bbd:	be 3c 00 00 00       	mov    $0x3c,%esi
    5bc2:	e8 99 0c 00 00       	call   6860 <fwp_pipe_write>
    5bc7:	e8 44 0d 00 00       	call   6910 <fwp_pipe_flush>
    5bcc:	e8 6f 0d 00 00       	call   6940 <fwp_pipe_out_ready>
    5bd1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%rsp)
    5bd8:	00 
    5bd9:	83 7c 24 14 00       	cmpl   $0x0,0x14(%rsp)
    5bde:	0f 84 57 01 00 00    	je     5d3b <fwp_exec+0x35b>
    5be4:	48 8b 1d d5 d3 00 00 	mov    0xd3d5(%rip),%rbx        # 12fc0 <stdin@GLIBC_2.2.5>
    5beb:	48 8b 3b             	mov    (%rbx),%rdi
    5bee:	b9 00 00 10 00       	mov    $0x100000,%ecx
    5bf3:	31 f6                	xor    %esi,%esi
    5bf5:	31 d2                	xor    %edx,%edx
    5bf7:	e8 a4 c7 ff ff       	call   23a0 <setvbuf@plt>
    5bfc:	48 8b 0b             	mov    (%rbx),%rcx
    5bff:	48 8d 3d 1e f2 01 00 	lea    0x1f21e(%rip),%rdi        # 24e24 <fwp_in_pend>
    5c06:	be 01 00 00 00       	mov    $0x1,%esi
    5c0b:	ba 04 00 00 00       	mov    $0x4,%edx
    5c10:	e8 cb c4 ff ff       	call   20e0 <fread@plt>
    5c15:	89 05 0d f2 01 00    	mov    %eax,0x1f20d(%rip)        # 24e28 <fwp_in_npend>
    5c1b:	c7 05 07 f2 01 00 00 	movl   $0x0,0x1f207(%rip)        # 24e2c <fwp_in_ppos>
    5c22:	00 00 00 
    5c25:	41 b4 01             	mov    $0x1,%r12b
    5c28:	83 f8 04             	cmp    $0x4,%eax
    5c2b:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    5c30:	0f 85 d3 01 00 00    	jne    5e09 <fwp_exec+0x429>
    5c36:	81 3d e4 f1 01 00 46 	cmpl   $0x31505746,0x1f1e4(%rip)        # 24e24 <fwp_in_pend>
    5c3d:	57 50 31 
    5c40:	0f 85 c3 01 00 00    	jne    5e09 <fwp_exec+0x429>
    5c46:	c7 05 dc f1 01 00 04 	movl   $0x4,0x1f1dc(%rip)        # 24e2c <fwp_in_ppos>
    5c4d:	00 00 00 
    5c50:	48 8d 7c 24 03       	lea    0x3(%rsp),%rdi
    5c55:	be 01 00 00 00       	mov    $0x1,%esi
    5c5a:	e8 41 0e 00 00       	call   6aa0 <fwp_read_exact>
    5c5f:	85 c0                	test   %eax,%eax
    5c61:	0f 84 c3 03 00 00    	je     602a <fwp_exec+0x64a>
    5c67:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
    5c6c:	e8 2f 0f 00 00       	call   6ba0 <fwp_stdin_leb>
    5c71:	83 f8 01             	cmp    $0x1,%eax
    5c74:	0f 85 99 03 00 00    	jne    6013 <fwp_exec+0x633>
    5c7a:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    5c7f:	48 83 f8 40          	cmp    $0x40,%rax
    5c83:	41 bd 40 00 00 00    	mov    $0x40,%r13d
    5c89:	4c 0f 42 e8          	cmovb  %rax,%r13
    5c8d:	48 85 c0             	test   %rax,%rax
    5c90:	0f 84 e2 00 00 00    	je     5d78 <fwp_exec+0x398>
    5c96:	45 31 f6             	xor    %r14d,%r14d
    5c99:	4c 8d 7c 24 50       	lea    0x50(%rsp),%r15
    5c9e:	31 ed                	xor    %ebp,%ebp
    5ca0:	eb 4a                	jmp    5cec <fwp_exec+0x30c>
    5ca2:	be 06 00 00 00       	mov    $0x6,%esi
    5ca7:	4c 89 ff             	mov    %r15,%rdi
    5caa:	e8 f1 0d 00 00       	call   6aa0 <fwp_read_exact>
    5caf:	85 c0                	test   %eax,%eax
    5cb1:	0f 84 73 03 00 00    	je     602a <fwp_exec+0x64a>
    5cb7:	8b 44 24 50          	mov    0x50(%rsp),%eax
    5cbb:	b9 55 44 53 5f       	mov    $0x5f534455,%ecx
    5cc0:	31 c8                	xor    %ecx,%eax
    5cc2:	0f b7 4c 24 54       	movzwl 0x54(%rsp),%ecx
    5cc7:	81 f1 56 31 00 00    	xor    $0x3156,%ecx
    5ccd:	09 c1                	or     %eax,%ecx
    5ccf:	b8 01 00 00 00       	mov    $0x1,%eax
    5cd4:	0f 44 e8             	cmove  %eax,%ebp
    5cd7:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
    5cde:	00 00 
    5ce0:	49 ff c6             	inc    %r14
    5ce3:	4d 39 ee             	cmp    %r13,%r14
    5ce6:	0f 84 8e 00 00 00    	je     5d7a <fwp_exec+0x39a>
    5cec:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    5cf1:	e8 2a 0f 00 00       	call   6c20 <fwp_stdin_name_len>
    5cf6:	83 f8 01             	cmp    $0x1,%eax
    5cf9:	0f 85 14 03 00 00    	jne    6013 <fwp_exec+0x633>
    5cff:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    5d04:	48 85 db             	test   %rbx,%rbx
    5d07:	74 ce                	je     5cd7 <fwp_exec+0x2f7>
    5d09:	48 83 fb 06          	cmp    $0x6,%rbx
    5d0d:	74 93                	je     5ca2 <fwp_exec+0x2c2>
    5d0f:	90                   	nop
    5d10:	48 81 fb 00 01 00 00 	cmp    $0x100,%rbx
    5d17:	41 bc 00 01 00 00    	mov    $0x100,%r12d
    5d1d:	4c 0f 42 e3          	cmovb  %rbx,%r12
    5d21:	4c 89 ff             	mov    %r15,%rdi
    5d24:	4c 89 e6             	mov    %r12,%rsi
    5d27:	e8 74 0d 00 00       	call   6aa0 <fwp_read_exact>
    5d2c:	85 c0                	test   %eax,%eax
    5d2e:	0f 84 f6 02 00 00    	je     602a <fwp_exec+0x64a>
    5d34:	4c 29 e3             	sub    %r12,%rbx
    5d37:	75 d7                	jne    5d10 <fwp_exec+0x330>
    5d39:	eb 9c                	jmp    5cd7 <fwp_exec+0x2f7>
    5d3b:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
    5d40:	4c 89 ff             	mov    %r15,%rdi
    5d43:	e8 98 0c 00 00       	call   69e0 <fwp_exec_call>
    5d48:	48 89 c3             	mov    %rax,%rbx
    5d4b:	48 8b 3d 56 f0 00 00 	mov    0xf056(%rip),%rdi        # 14da8 <fwp_prog_out>
    5d52:	e8 e9 c5 ff ff       	call   2340 <fflush@plt>
    5d57:	41 be 01 00 00 00    	mov    $0x1,%r14d
    5d5d:	83 7c 24 04 00       	cmpl   $0x0,0x4(%rsp)
    5d62:	0f 85 83 02 00 00    	jne    5feb <fwp_exec+0x60b>
    5d68:	48 89 df             	mov    %rbx,%rdi
    5d6b:	e8 20 0d 00 00       	call   6a90 <fwp_emit_result>
    5d70:	45 31 f6             	xor    %r14d,%r14d
    5d73:	e9 73 02 00 00       	jmp    5feb <fwp_exec+0x60b>
    5d78:	31 ed                	xor    %ebp,%ebp
    5d7a:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    5d7f:	be 10 00 00 00       	mov    $0x10,%esi
    5d84:	e8 17 0d 00 00       	call   6aa0 <fwp_read_exact>
    5d89:	85 c0                	test   %eax,%eax
    5d8b:	0f 84 99 02 00 00    	je     602a <fwp_exec+0x64a>
    5d91:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    5d96:	e8 85 0e 00 00       	call   6c20 <fwp_stdin_name_len>
    5d9b:	83 f8 01             	cmp    $0x1,%eax
    5d9e:	0f 85 6f 02 00 00    	jne    6013 <fwp_exec+0x633>
    5da4:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    5da9:	49 8d 7f 01          	lea    0x1(%r15),%rdi
    5dad:	e8 2e 07 00 00       	call   64e0 <fwp_alloc_leaf>
    5db2:	49 89 c6             	mov    %rax,%r14
    5db5:	4d 85 ff             	test   %r15,%r15
    5db8:	74 13                	je     5dcd <fwp_exec+0x3ed>
    5dba:	4c 89 f7             	mov    %r14,%rdi
    5dbd:	4c 89 fe             	mov    %r15,%rsi
    5dc0:	e8 db 0c 00 00       	call   6aa0 <fwp_read_exact>
    5dc5:	85 c0                	test   %eax,%eax
    5dc7:	0f 84 5d 02 00 00    	je     602a <fwp_exec+0x64a>
    5dcd:	43 c6 04 3e 00       	movb   $0x0,(%r14,%r15,1)
    5dd2:	0f b6 4c 24 03       	movzbl 0x3(%rsp),%ecx
    5dd7:	83 f9 01             	cmp    $0x1,%ecx
    5dda:	0f 85 ab 02 00 00    	jne    608b <fwp_exec+0x6ab>
    5de0:	66 0f 6f 44 24 30    	movdqa 0x30(%rsp),%xmm0
    5de6:	66 0f 74 05 42 73 00 	pcmpeqb 0x7342(%rip),%xmm0        # d130 <_IO_stdin_used+0x130>
    5ded:	00 
    5dee:	66 0f d7 c0          	pmovmskb %xmm0,%eax
    5df2:	3d ff ff 00 00       	cmp    $0xffff,%eax
    5df7:	0f 85 af 02 00 00    	jne    60ac <fwp_exec+0x6cc>
    5dfd:	85 ed                	test   %ebp,%ebp
    5dff:	74 05                	je     5e06 <fwp_exec+0x426>
    5e01:	e8 4a 0e 00 00       	call   6c50 <fwp_pipe_in_offer>
    5e06:	45 31 e4             	xor    %r12d,%r12d
    5e09:	66 0f ef c0          	pxor   %xmm0,%xmm0
    5e0d:	66 0f 7f 44 24 50    	movdqa %xmm0,0x50(%rsp)
    5e13:	48 c7 44 24 60 00 00 	movq   $0x0,0x60(%rsp)
    5e1a:	00 00 
    5e1c:	45 31 ff             	xor    %r15d,%r15d
    5e1f:	45 31 f6             	xor    %r14d,%r14d
    5e22:	eb 35                	jmp    5e59 <fwp_exec+0x479>
    5e24:	48 89 ef             	mov    %rbp,%rdi
    5e27:	4c 89 ee             	mov    %r13,%rsi
    5e2a:	e8 21 0f 00 00       	call   6d50 <fwp_pipe_in_switch>
    5e2f:	bb 10 00 00 00       	mov    $0x10,%ebx
    5e34:	48 8d 35 fb 82 00 00 	lea    0x82fb(%rip),%rsi        # e136 <exec_in_fp0+0xad6>
    5e3b:	85 c0                	test   %eax,%eax
    5e3d:	0f 84 6b 01 00 00    	je     5fae <fwp_exec+0x5ce>
    5e43:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5e4a:	84 00 00 00 00 00 
    5e50:	83 fb 0f             	cmp    $0xf,%ebx
    5e53:	0f 84 83 01 00 00    	je     5fdc <fwp_exec+0x5fc>
    5e59:	45 84 e4             	test   %r12b,%r12b
    5e5c:	0f 84 9e 00 00 00    	je     5f00 <fwp_exec+0x520>
    5e62:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    5e67:	e8 44 15 00 00       	call   73b0 <fwp_read_text_line>
    5e6c:	4c 8b 7c 24 50       	mov    0x50(%rsp),%r15
    5e71:	85 c0                	test   %eax,%eax
    5e73:	0f 84 63 01 00 00    	je     5fdc <fwp_exec+0x5fc>
    5e79:	4d 85 ff             	test   %r15,%r15
    5e7c:	4c 89 ff             	mov    %r15,%rdi
    5e7f:	48 8d 05 22 82 00 00 	lea    0x8222(%rip),%rax        # e0a8 <exec_in_fp0+0xa48>
    5e86:	48 0f 44 f8          	cmove  %rax,%rdi
    5e8a:	48 8b 74 24 58       	mov    0x58(%rsp),%rsi
    5e8f:	e8 6c 04 00 00       	call   6300 <fwp_str_lossy>
    5e94:	48 89 c5             	mov    %rax,%rbp
    5e97:	4c 8d 68 08          	lea    0x8(%rax),%r13
    5e9b:	48 8b 30             	mov    (%rax),%rsi
    5e9e:	4c 89 ef             	mov    %r13,%rdi
    5ea1:	48 8d 54 24 20       	lea    0x20(%rsp),%rdx
    5ea6:	e8 e5 07 00 00       	call   6690 <fwp_parse_text>
    5eab:	85 c0                	test   %eax,%eax
    5ead:	0f 84 a1 01 00 00    	je     6054 <fwp_exec+0x674>
    5eb3:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    5eb8:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    5ebd:	48 89 07             	mov    %rax,(%rdi)
    5ec0:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
    5ec5:	e8 16 0b 00 00       	call   69e0 <fwp_exec_call>
    5eca:	49 89 c5             	mov    %rax,%r13
    5ecd:	48 8b 3d d4 ee 00 00 	mov    0xeed4(%rip),%rdi        # 14da8 <fwp_prog_out>
    5ed4:	e8 67 c4 ff ff       	call   2340 <fflush@plt>
    5ed9:	83 7c 24 04 00       	cmpl   $0x0,0x4(%rsp)
    5ede:	0f 85 f2 00 00 00    	jne    5fd6 <fwp_exec+0x5f6>
    5ee4:	4c 89 ef             	mov    %r13,%rdi
    5ee7:	e8 a4 0b 00 00       	call   6a90 <fwp_emit_result>
    5eec:	e8 1f 0a 00 00       	call   6910 <fwp_pipe_flush>
    5ef1:	31 db                	xor    %ebx,%ebx
    5ef3:	e9 58 ff ff ff       	jmp    5e50 <fwp_exec+0x470>
    5ef8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    5eff:	00 
    5f00:	be 01 00 00 00       	mov    $0x1,%esi
    5f05:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    5f0a:	e8 91 0b 00 00       	call   6aa0 <fwp_read_exact>
    5f0f:	bb 0f 00 00 00       	mov    $0xf,%ebx
    5f14:	85 c0                	test   %eax,%eax
    5f16:	0f 84 34 ff ff ff    	je     5e50 <fwp_exec+0x470>
    5f1c:	be 04 00 00 00       	mov    $0x4,%esi
    5f21:	48 8d 7c 24 09       	lea    0x9(%rsp),%rdi
    5f26:	e8 75 0b 00 00       	call   6aa0 <fwp_read_exact>
    5f2b:	48 8d 35 ef 81 00 00 	lea    0x81ef(%rip),%rsi        # e121 <exec_in_fp0+0xac1>
    5f32:	85 c0                	test   %eax,%eax
    5f34:	74 78                	je     5fae <fwp_exec+0x5ce>
    5f36:	44 8b 6c 24 09       	mov    0x9(%rsp),%r13d
    5f3b:	49 8d 7d 01          	lea    0x1(%r13),%rdi
    5f3f:	e8 9c 05 00 00       	call   64e0 <fwp_alloc_leaf>
    5f44:	48 89 c5             	mov    %rax,%rbp
    5f47:	4d 85 ed             	test   %r13,%r13
    5f4a:	74 16                	je     5f62 <fwp_exec+0x582>
    5f4c:	48 89 ef             	mov    %rbp,%rdi
    5f4f:	4c 89 ee             	mov    %r13,%rsi
    5f52:	e8 49 0b 00 00       	call   6aa0 <fwp_read_exact>
    5f57:	48 8d 35 c3 81 00 00 	lea    0x81c3(%rip),%rsi        # e121 <exec_in_fp0+0xac1>
    5f5e:	85 c0                	test   %eax,%eax
    5f60:	74 4c                	je     5fae <fwp_exec+0x5ce>
    5f62:	0f b6 44 24 08       	movzbl 0x8(%rsp),%eax
    5f67:	85 c0                	test   %eax,%eax
    5f69:	0f 84 e1 fe ff ff    	je     5e50 <fwp_exec+0x470>
    5f6f:	83 f8 02             	cmp    $0x2,%eax
    5f72:	0f 84 ac fe ff ff    	je     5e24 <fwp_exec+0x444>
    5f78:	48 89 6c 24 30       	mov    %rbp,0x30(%rsp)
    5f7d:	4c 89 6c 24 38       	mov    %r13,0x38(%rsp)
    5f82:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    5f89:	00 00 
    5f8b:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    5f90:	48 8d 35 91 ed 00 00 	lea    0xed91(%rip),%rsi        # 14d28 <d0>
    5f97:	48 8d 54 24 20       	lea    0x20(%rsp),%rdx
    5f9c:	e8 cf 0f 00 00       	call   6f70 <fwp_decode>
    5fa1:	85 c0                	test   %eax,%eax
    5fa3:	0f 85 0a ff ff ff    	jne    5eb3 <fwp_exec+0x4d3>
    5fa9:	e9 2c 01 00 00       	jmp    60da <fwp_exec+0x6fa>
    5fae:	48 8b 05 2b d0 00 00 	mov    0xd02b(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    5fb5:	48 8b 38             	mov    (%rax),%rdi
    5fb8:	48 8d 15 dc 76 00 00 	lea    0x76dc(%rip),%rdx        # d69b <exec_in_fp0+0x3b>
    5fbf:	31 c0                	xor    %eax,%eax
    5fc1:	e8 1a c3 ff ff       	call   22e0 <fprintf@plt>
    5fc6:	41 be 03 00 00 00    	mov    $0x3,%r14d
    5fcc:	bb 0f 00 00 00       	mov    $0xf,%ebx
    5fd1:	e9 7a fe ff ff       	jmp    5e50 <fwp_exec+0x470>
    5fd6:	41 be 01 00 00 00    	mov    $0x1,%r14d
    5fdc:	31 ff                	xor    %edi,%edi
    5fde:	e8 1d f4 ff ff       	call   5400 <fwp_mem_free>
    5fe3:	4c 89 ff             	mov    %r15,%rdi
    5fe6:	e8 65 c0 ff ff       	call   2050 <free@plt>
    5feb:	83 3d 2e ee 01 00 00 	cmpl   $0x0,0x1ee2e(%rip)        # 24e20 <fwp_exec_binary_out>
    5ff2:	0f 84 fb fa ff ff    	je     5af3 <fwp_exec+0x113>
    5ff8:	48 8d 3d 1c 76 00 00 	lea    0x761c(%rip),%rdi        # d61b <fwp_exec.end>
    5fff:	be 05 00 00 00       	mov    $0x5,%esi
    6004:	e8 57 08 00 00       	call   6860 <fwp_pipe_write>
    6009:	e8 b2 14 00 00       	call   74c0 <fwp_pipe_out_end>
    600e:	e9 e0 fa ff ff       	jmp    5af3 <fwp_exec+0x113>
    6013:	85 c0                	test   %eax,%eax
    6015:	79 13                	jns    602a <fwp_exec+0x64a>
    6017:	48 8b 05 c2 cf 00 00 	mov    0xcfc2(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    601e:	48 8b 38             	mov    (%rax),%rdi
    6021:	48 8d 35 5e 81 00 00 	lea    0x815e(%rip),%rsi        # e186 <exec_in_fp0+0xb26>
    6028:	eb 11                	jmp    603b <fwp_exec+0x65b>
    602a:	48 8b 05 af cf 00 00 	mov    0xcfaf(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    6031:	48 8b 38             	mov    (%rax),%rdi
    6034:	48 8d 35 5b 81 00 00 	lea    0x815b(%rip),%rsi        # e196 <exec_in_fp0+0xb36>
    603b:	48 8d 15 59 76 00 00 	lea    0x7659(%rip),%rdx        # d69b <exec_in_fp0+0x3b>
    6042:	31 c0                	xor    %eax,%eax
    6044:	e8 97 c2 ff ff       	call   22e0 <fprintf@plt>
    6049:	41 be 03 00 00 00    	mov    $0x3,%r14d
    604f:	e9 e0 fa ff ff       	jmp    5b34 <fwp_exec+0x154>
    6054:	48 8b 05 85 cf 00 00 	mov    0xcf85(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    605b:	48 8b 38             	mov    (%rax),%rdi
    605e:	8b 4d 00             	mov    0x0(%rbp),%ecx
    6061:	48 8d 35 f9 80 00 00 	lea    0x80f9(%rip),%rsi        # e161 <exec_in_fp0+0xb01>
    6068:	48 8d 15 2c 76 00 00 	lea    0x762c(%rip),%rdx        # d69b <exec_in_fp0+0x3b>
    606f:	4c 8d 0d 38 84 00 00 	lea    0x8438(%rip),%r9        # e4ae <exec_in_fp0+0xe4e>
    6076:	4d 89 e8             	mov    %r13,%r8
    6079:	31 c0                	xor    %eax,%eax
    607b:	e8 60 c2 ff ff       	call   22e0 <fprintf@plt>
    6080:	41 be 03 00 00 00    	mov    $0x3,%r14d
    6086:	e9 51 ff ff ff       	jmp    5fdc <fwp_exec+0x5fc>
    608b:	48 8b 05 4e cf 00 00 	mov    0xcf4e(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    6092:	48 8b 38             	mov    (%rax),%rdi
    6095:	48 8d 35 2e 80 00 00 	lea    0x802e(%rip),%rsi        # e0ca <exec_in_fp0+0xa6a>
    609c:	48 8d 15 f8 75 00 00 	lea    0x75f8(%rip),%rdx        # d69b <exec_in_fp0+0x3b>
    60a3:	31 c0                	xor    %eax,%eax
    60a5:	e8 36 c2 ff ff       	call   22e0 <fprintf@plt>
    60aa:	eb 9d                	jmp    6049 <fwp_exec+0x669>
    60ac:	48 8b 05 2d cf 00 00 	mov    0xcf2d(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    60b3:	48 8b 38             	mov    (%rax),%rdi
    60b6:	48 8d 35 32 80 00 00 	lea    0x8032(%rip),%rsi        # e0ef <exec_in_fp0+0xa8f>
    60bd:	48 8d 15 d7 75 00 00 	lea    0x75d7(%rip),%rdx        # d69b <exec_in_fp0+0x3b>
    60c4:	48 8d 0d e3 83 00 00 	lea    0x83e3(%rip),%rcx        # e4ae <exec_in_fp0+0xe4e>
    60cb:	4d 89 f0             	mov    %r14,%r8
    60ce:	31 c0                	xor    %eax,%eax
    60d0:	e8 0b c2 ff ff       	call   22e0 <fprintf@plt>
    60d5:	e9 6f ff ff ff       	jmp    6049 <fwp_exec+0x669>
    60da:	48 8b 05 ff ce 00 00 	mov    0xceff(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    60e1:	48 8b 38             	mov    (%rax),%rdi
    60e4:	48 8d 35 61 80 00 00 	lea    0x8061(%rip),%rsi        # e14c <exec_in_fp0+0xaec>
    60eb:	48 8d 15 a9 75 00 00 	lea    0x75a9(%rip),%rdx        # d69b <exec_in_fp0+0x3b>
    60f2:	31 c0                	xor    %eax,%eax
    60f4:	e8 e7 c1 ff ff       	call   22e0 <fprintf@plt>
    60f9:	41 be 03 00 00 00    	mov    $0x3,%r14d
    60ff:	e9 d8 fe ff ff       	jmp    5fdc <fwp_exec+0x5fc>
    6104:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    610b:	00 00 00 00 00 

0000000000006110 <fwp_segv>:
    6110:	53                   	push   %rbx
    6111:	48 8b 15 f0 ec 00 00 	mov    0xecf0(%rip),%rdx        # 14e08 <fwp_main_stack_top>
    6118:	48 85 d2             	test   %rdx,%rdx
    611b:	74 29                	je     6146 <fwp_segv+0x36>
    611d:	48 8b 46 10          	mov    0x10(%rsi),%rax
    6121:	48 2b 15 e8 ec 00 00 	sub    0xece8(%rip),%rdx        # 14e10 <fwp_main_stack_size>
    6128:	48 8d b2 00 00 f0 ff 	lea    -0x100000(%rdx),%rsi
    612f:	48 81 c2 00 00 10 00 	add    $0x100000,%rdx
    6136:	89 fb                	mov    %edi,%ebx
    6138:	48 89 c7             	mov    %rax,%rdi
    613b:	e8 40 00 00 00       	call   6180 <fwp_near>
    6140:	89 df                	mov    %ebx,%edi
    6142:	85 c0                	test   %eax,%eax
    6144:	75 08                	jne    614e <fwp_segv+0x3e>
    6146:	31 f6                	xor    %esi,%esi
    6148:	5b                   	pop    %rbx
    6149:	e9 82 c1 ff ff       	jmp    22d0 <signal@plt>
    614e:	e8 0d ce ff ff       	call   2f60 <fwp_flush>
    6153:	48 8d 35 a6 74 00 00 	lea    0x74a6(%rip),%rsi        # d600 <fwp_segv.msg>
    615a:	ba 1a 00 00 00       	mov    $0x1a,%edx
    615f:	bf 02 00 00 00       	mov    $0x2,%edi
    6164:	e8 c7 bf ff ff       	call   2130 <write@plt>
    6169:	bf 65 00 00 00       	mov    $0x65,%edi
    616e:	e8 2d bf ff ff       	call   20a0 <_exit@plt>
    6173:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    617a:	84 00 00 00 00 00 

0000000000006180 <fwp_near>:
    6180:	48 39 f7             	cmp    %rsi,%rdi
    6183:	0f 93 c0             	setae  %al
    6186:	48 39 d7             	cmp    %rdx,%rdi
    6189:	0f 92 c1             	setb   %cl
    618c:	20 c1                	and    %al,%cl
    618e:	0f b6 c1             	movzbl %cl,%eax
    6191:	c3                   	ret
    6192:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6199:	1f 84 00 00 00 00 00 

00000000000061a0 <fwp_generated>:
    61a0:	55                   	push   %rbp
    61a1:	41 57                	push   %r15
    61a3:	41 56                	push   %r14
    61a5:	53                   	push   %rbx
    61a6:	50                   	push   %rax
    61a7:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    61ac:	85 ff                	test   %edi,%edi
    61ae:	0f 8e 14 01 00 00    	jle    62c8 <fwp_generated+0x128>
    61b4:	89 fd                	mov    %edi,%ebp
    61b6:	49 89 f7             	mov    %rsi,%r15
    61b9:	4c 8b 36             	mov    (%rsi),%r14
    61bc:	48 8d 35 e9 7f 00 00 	lea    0x7fe9(%rip),%rsi        # e1ac <exec_in_fp0+0xb4c>
    61c3:	4c 89 f7             	mov    %r14,%rdi
    61c6:	e8 f5 c0 ff ff       	call   22c0 <strcmp@plt>
    61cb:	85 c0                	test   %eax,%eax
    61cd:	74 34                	je     6203 <fwp_generated+0x63>
    61cf:	48 8d 35 dc 7f 00 00 	lea    0x7fdc(%rip),%rsi        # e1b2 <exec_in_fp0+0xb52>
    61d6:	ba 0d 00 00 00       	mov    $0xd,%edx
    61db:	4c 89 f7             	mov    %r14,%rdi
    61de:	e8 ad be ff ff       	call   2090 <strncmp@plt>
    61e3:	85 c0                	test   %eax,%eax
    61e5:	0f 85 dd 00 00 00    	jne    62c8 <fwp_generated+0x128>
    61eb:	41 0f b6 46 0d       	movzbl 0xd(%r14),%eax
    61f0:	85 c0                	test   %eax,%eax
    61f2:	74 2c                	je     6220 <fwp_generated+0x80>
    61f4:	83 f8 3d             	cmp    $0x3d,%eax
    61f7:	0f 85 cb 00 00 00    	jne    62c8 <fwp_generated+0x128>
    61fd:	49 83 c6 0e          	add    $0xe,%r14
    6201:	eb 2a                	jmp    622d <fwp_generated+0x8d>
    6203:	48 8b 3d ee eb 00 00 	mov    0xebee(%rip),%rdi        # 14df8 <fwp_cli_man>
    620a:	48 8b 05 a7 cd 00 00 	mov    0xcda7(%rip),%rax        # 12fb8 <stdout@GLIBC_2.2.5>
    6211:	48 8b 30             	mov    (%rax),%rsi
    6214:	e8 c7 bf ff ff       	call   21e0 <fputs@plt>
    6219:	31 db                	xor    %ebx,%ebx
    621b:	e9 a8 00 00 00       	jmp    62c8 <fwp_generated+0x128>
    6220:	83 fd 01             	cmp    $0x1,%ebp
    6223:	0f 84 ac 00 00 00    	je     62d5 <fwp_generated+0x135>
    6229:	4d 8b 77 08          	mov    0x8(%r15),%r14
    622d:	48 8d 35 ca 7f 00 00 	lea    0x7fca(%rip),%rsi        # e1fe <exec_in_fp0+0xb9e>
    6234:	4c 89 f7             	mov    %r14,%rdi
    6237:	e8 84 c0 ff ff       	call   22c0 <strcmp@plt>
    623c:	31 db                	xor    %ebx,%ebx
    623e:	85 c0                	test   %eax,%eax
    6240:	74 63                	je     62a5 <fwp_generated+0x105>
    6242:	48 8d 35 ba 7f 00 00 	lea    0x7fba(%rip),%rsi        # e203 <exec_in_fp0+0xba3>
    6249:	4c 89 f7             	mov    %r14,%rdi
    624c:	e8 6f c0 ff ff       	call   22c0 <strcmp@plt>
    6251:	85 c0                	test   %eax,%eax
    6253:	74 54                	je     62a9 <fwp_generated+0x109>
    6255:	48 8d 35 ab 7f 00 00 	lea    0x7fab(%rip),%rsi        # e207 <exec_in_fp0+0xba7>
    625c:	4c 89 f7             	mov    %r14,%rdi
    625f:	e8 5c c0 ff ff       	call   22c0 <strcmp@plt>
    6264:	b9 02 00 00 00       	mov    $0x2,%ecx
    6269:	85 c0                	test   %eax,%eax
    626b:	74 41                	je     62ae <fwp_generated+0x10e>
    626d:	4c 89 f7             	mov    %r14,%rdi
    6270:	e8 eb be ff ff       	call   2160 <strlen@plt>
    6275:	4c 89 f7             	mov    %r14,%rdi
    6278:	48 89 c6             	mov    %rax,%rsi
    627b:	e8 80 00 00 00       	call   6300 <fwp_str_lossy>
    6280:	48 8b 0d 59 cd 00 00 	mov    0xcd59(%rip),%rcx        # 12fe0 <stderr@GLIBC_2.2.5>
    6287:	48 8b 39             	mov    (%rcx),%rdi
    628a:	48 8d 48 08          	lea    0x8(%rax),%rcx
    628e:	48 8d 35 77 7f 00 00 	lea    0x7f77(%rip),%rsi        # e20c <exec_in_fp0+0xbac>
    6295:	48 8d 15 ff 73 00 00 	lea    0x73ff(%rip),%rdx        # d69b <exec_in_fp0+0x3b>
    629c:	31 c0                	xor    %eax,%eax
    629e:	e8 3d c0 ff ff       	call   22e0 <fprintf@plt>
    62a3:	eb 4f                	jmp    62f4 <fwp_generated+0x154>
    62a5:	31 c9                	xor    %ecx,%ecx
    62a7:	eb 05                	jmp    62ae <fwp_generated+0x10e>
    62a9:	b9 01 00 00 00       	mov    $0x1,%ecx
    62ae:	48 8d 05 2b eb 00 00 	lea    0xeb2b(%rip),%rax        # 14de0 <fwp_cli_scripts>
    62b5:	48 8b 3c c8          	mov    (%rax,%rcx,8),%rdi
    62b9:	48 8b 05 f8 cc 00 00 	mov    0xccf8(%rip),%rax        # 12fb8 <stdout@GLIBC_2.2.5>
    62c0:	48 8b 30             	mov    (%rax),%rsi
    62c3:	e8 18 bf ff ff       	call   21e0 <fputs@plt>
    62c8:	89 d8                	mov    %ebx,%eax
    62ca:	48 83 c4 08          	add    $0x8,%rsp
    62ce:	5b                   	pop    %rbx
    62cf:	41 5e                	pop    %r14
    62d1:	41 5f                	pop    %r15
    62d3:	5d                   	pop    %rbp
    62d4:	c3                   	ret
    62d5:	48 8b 05 04 cd 00 00 	mov    0xcd04(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    62dc:	48 8b 38             	mov    (%rax),%rdi
    62df:	48 8d 35 da 7e 00 00 	lea    0x7eda(%rip),%rsi        # e1c0 <exec_in_fp0+0xb60>
    62e6:	48 8d 15 ae 73 00 00 	lea    0x73ae(%rip),%rdx        # d69b <exec_in_fp0+0x3b>
    62ed:	31 c0                	xor    %eax,%eax
    62ef:	e8 ec bf ff ff       	call   22e0 <fprintf@plt>
    62f4:	bb 02 00 00 00       	mov    $0x2,%ebx
    62f9:	eb cd                	jmp    62c8 <fwp_generated+0x128>
    62fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006300 <fwp_str_lossy>:
    6300:	55                   	push   %rbp
    6301:	41 57                	push   %r15
    6303:	41 56                	push   %r14
    6305:	41 55                	push   %r13
    6307:	41 54                	push   %r12
    6309:	53                   	push   %rbx
    630a:	48 83 ec 18          	sub    $0x18,%rsp
    630e:	48 89 f3             	mov    %rsi,%rbx
    6311:	49 89 fe             	mov    %rdi,%r14
    6314:	e8 27 12 00 00       	call   7540 <fwp_valid_utf8>
    6319:	85 c0                	test   %eax,%eax
    631b:	74 19                	je     6336 <fwp_str_lossy+0x36>
    631d:	4c 89 f7             	mov    %r14,%rdi
    6320:	48 89 de             	mov    %rbx,%rsi
    6323:	48 83 c4 18          	add    $0x18,%rsp
    6327:	5b                   	pop    %rbx
    6328:	41 5c                	pop    %r12
    632a:	41 5d                	pop    %r13
    632c:	41 5e                	pop    %r14
    632e:	41 5f                	pop    %r15
    6330:	5d                   	pop    %rbp
    6331:	e9 6a 13 00 00       	jmp    76a0 <fwp_str_new>
    6336:	0f 57 c0             	xorps  %xmm0,%xmm0
    6339:	0f 29 04 24          	movaps %xmm0,(%rsp)
    633d:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    6344:	00 00 
    6346:	48 85 db             	test   %rbx,%rbx
    6349:	0f 84 72 01 00 00    	je     64c1 <fwp_str_lossy+0x1c1>
    634f:	45 31 ed             	xor    %r13d,%r13d
    6352:	49 89 e7             	mov    %rsp,%r15
    6355:	4c 8d 25 dc 7e 00 00 	lea    0x7edc(%rip),%r12        # e238 <exec_in_fp0+0xbd8>
    635c:	eb 19                	jmp    6377 <fwp_str_lossy+0x77>
    635e:	66 90                	xchg   %ax,%ax
    6360:	4c 89 ff             	mov    %r15,%rdi
    6363:	4c 89 e6             	mov    %r12,%rsi
    6366:	e8 95 13 00 00       	call   7700 <buf_puts>
    636b:	49 89 ed             	mov    %rbp,%r13
    636e:	48 39 dd             	cmp    %rbx,%rbp
    6371:	0f 83 4a 01 00 00    	jae    64c1 <fwp_str_lossy+0x1c1>
    6377:	43 0f b6 04 2e       	movzbl (%r14,%r13,1),%eax
    637c:	84 c0                	test   %al,%al
    637e:	78 20                	js     63a0 <fwp_str_lossy+0xa0>
    6380:	0f be f0             	movsbl %al,%esi
    6383:	4c 89 ff             	mov    %r15,%rdi
    6386:	e8 55 13 00 00       	call   76e0 <buf_putc>
    638b:	49 ff c5             	inc    %r13
    638e:	4c 89 ed             	mov    %r13,%rbp
    6391:	eb d8                	jmp    636b <fwp_str_lossy+0x6b>
    6393:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    639a:	84 00 00 00 00 00 
    63a0:	8d 48 20             	lea    0x20(%rax),%ecx
    63a3:	80 f9 e1             	cmp    $0xe1,%cl
    63a6:	77 34                	ja     63dc <fwp_str_lossy+0xdc>
    63a8:	89 c2                	mov    %eax,%edx
    63aa:	80 e2 f0             	and    $0xf0,%dl
    63ad:	80 fa e0             	cmp    $0xe0,%dl
    63b0:	0f 85 cb 00 00 00    	jne    6481 <fwp_str_lossy+0x181>
    63b6:	3c e0                	cmp    $0xe0,%al
    63b8:	40 0f 94 c6          	sete   %sil
    63bc:	40 c0 e6 05          	shl    $0x5,%sil
    63c0:	40 80 ce 80          	or     $0x80,%sil
    63c4:	31 ff                	xor    %edi,%edi
    63c6:	3c ed                	cmp    $0xed,%al
    63c8:	40 0f 95 c7          	setne  %dil
    63cc:	c1 e7 05             	shl    $0x5,%edi
    63cf:	81 cf 9f 00 00 00    	or     $0x9f,%edi
    63d5:	b8 02 00 00 00       	mov    $0x2,%eax
    63da:	eb 0d                	jmp    63e9 <fwp_str_lossy+0xe9>
    63dc:	bf bf 00 00 00       	mov    $0xbf,%edi
    63e1:	40 b6 80             	mov    $0x80,%sil
    63e4:	b8 01 00 00 00       	mov    $0x1,%eax
    63e9:	31 d2                	xor    %edx,%edx
    63eb:	49 8d 6d 01          	lea    0x1(%r13),%rbp
    63ef:	48 39 dd             	cmp    %rbx,%rbp
    63f2:	0f 83 68 ff ff ff    	jae    6360 <fwp_str_lossy+0x60>
    63f8:	45 0f b6 04 2e       	movzbl (%r14,%rbp,1),%r8d
    63fd:	41 38 f0             	cmp    %sil,%r8b
    6400:	0f 82 5a ff ff ff    	jb     6360 <fwp_str_lossy+0x60>
    6406:	44 39 c7             	cmp    %r8d,%edi
    6409:	0f 82 51 ff ff ff    	jb     6360 <fwp_str_lossy+0x60>
    640f:	49 8d 6d 02          	lea    0x2(%r13),%rbp
    6413:	be 01 00 00 00       	mov    $0x1,%esi
    6418:	80 f9 e1             	cmp    $0xe1,%cl
    641b:	77 45                	ja     6462 <fwp_str_lossy+0x162>
    641d:	48 39 dd             	cmp    %rbx,%rbp
    6420:	73 40                	jae    6462 <fwp_str_lossy+0x162>
    6422:	41 0f b6 0c 2e       	movzbl (%r14,%rbp,1),%ecx
    6427:	80 e1 c0             	and    $0xc0,%cl
    642a:	80 f9 80             	cmp    $0x80,%cl
    642d:	75 33                	jne    6462 <fwp_str_lossy+0x162>
    642f:	49 8d 6d 03          	lea    0x3(%r13),%rbp
    6433:	48 39 dd             	cmp    %rbx,%rbp
    6436:	0f 93 c1             	setae  %cl
    6439:	80 f2 01             	xor    $0x1,%dl
    643c:	be 02 00 00 00       	mov    $0x2,%esi
    6441:	08 ca                	or     %cl,%dl
    6443:	75 1d                	jne    6462 <fwp_str_lossy+0x162>
    6445:	43 0f b6 4c 2e 03    	movzbl 0x3(%r14,%r13,1),%ecx
    644b:	80 e1 c0             	and    $0xc0,%cl
    644e:	31 f6                	xor    %esi,%esi
    6450:	80 f9 80             	cmp    $0x80,%cl
    6453:	0f 94 c1             	sete   %cl
    6456:	75 04                	jne    645c <fwp_str_lossy+0x15c>
    6458:	49 8d 6d 04          	lea    0x4(%r13),%rbp
    645c:	40 88 ce             	mov    %cl,%sil
    645f:	83 ce 02             	or     $0x2,%esi
    6462:	39 c6                	cmp    %eax,%esi
    6464:	0f 85 f6 fe ff ff    	jne    6360 <fwp_str_lossy+0x60>
    646a:	4b 8d 34 2e          	lea    (%r14,%r13,1),%rsi
    646e:	48 89 ea             	mov    %rbp,%rdx
    6471:	4c 29 ea             	sub    %r13,%rdx
    6474:	4c 89 ff             	mov    %r15,%rdi
    6477:	e8 b4 12 00 00       	call   7730 <buf_put>
    647c:	e9 ea fe ff ff       	jmp    636b <fwp_str_lossy+0x6b>
    6481:	8d 50 10             	lea    0x10(%rax),%edx
    6484:	80 fa 04             	cmp    $0x4,%dl
    6487:	77 28                	ja     64b1 <fwp_str_lossy+0x1b1>
    6489:	3c f0                	cmp    $0xf0,%al
    648b:	40 0f 94 c6          	sete   %sil
    648f:	bf 8f 00 00 00       	mov    $0x8f,%edi
    6494:	3c f4                	cmp    $0xf4,%al
    6496:	74 05                	je     649d <fwp_str_lossy+0x19d>
    6498:	bf bf 00 00 00       	mov    $0xbf,%edi
    649d:	40 c0 e6 04          	shl    $0x4,%sil
    64a1:	40 80 ce 80          	or     $0x80,%sil
    64a5:	b8 03 00 00 00       	mov    $0x3,%eax
    64aa:	b2 01                	mov    $0x1,%dl
    64ac:	e9 3a ff ff ff       	jmp    63eb <fwp_str_lossy+0xeb>
    64b1:	4c 89 ff             	mov    %r15,%rdi
    64b4:	4c 89 e6             	mov    %r12,%rsi
    64b7:	e8 44 12 00 00       	call   7700 <buf_puts>
    64bc:	e9 ca fe ff ff       	jmp    638b <fwp_str_lossy+0x8b>
    64c1:	48 89 e7             	mov    %rsp,%rdi
    64c4:	e8 a7 12 00 00       	call   7770 <buf_to_str>
    64c9:	48 83 c4 18          	add    $0x18,%rsp
    64cd:	5b                   	pop    %rbx
    64ce:	41 5c                	pop    %r12
    64d0:	41 5d                	pop    %r13
    64d2:	41 5e                	pop    %r14
    64d4:	41 5f                	pop    %r15
    64d6:	5d                   	pop    %rbp
    64d7:	c3                   	ret
    64d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    64df:	00 

00000000000064e0 <fwp_alloc_leaf>:
    64e0:	be 01 00 00 00       	mov    $0x1,%esi
    64e5:	e9 56 d1 ff ff       	jmp    3640 <fwp_gc_alloc>
    64ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000064f0 <fwp_cli_parse>:
    64f0:	c7 01 00 00 00 00    	movl   $0x0,(%rcx)
    64f6:	85 ff                	test   %edi,%edi
    64f8:	0f 8e 6d 01 00 00    	jle    666b <fwp_cli_parse+0x17b>
    64fe:	55                   	push   %rbp
    64ff:	41 57                	push   %r15
    6501:	41 56                	push   %r14
    6503:	41 55                	push   %r13
    6505:	41 54                	push   %r12
    6507:	53                   	push   %rbx
    6508:	48 83 ec 28          	sub    $0x28,%rsp
    650c:	41 89 f8             	mov    %edi,%r8d
    650f:	4d 89 c1             	mov    %r8,%r9
    6512:	49 f7 d9             	neg    %r9
    6515:	40 b5 01             	mov    $0x1,%bpl
    6518:	45 31 ff             	xor    %r15d,%r15d
    651b:	41 be 01 00 00 00    	mov    $0x1,%r14d
    6521:	31 db                	xor    %ebx,%ebx
    6523:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
    6528:	48 89 74 24 18       	mov    %rsi,0x18(%rsp)
    652d:	4c 89 44 24 10       	mov    %r8,0x10(%rsp)
    6532:	4c 89 4c 24 08       	mov    %r9,0x8(%rsp)
    6537:	48 89 0c 24          	mov    %rcx,(%rsp)
    653b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    6540:	4e 8b 6c f6 f8       	mov    -0x8(%rsi,%r14,8),%r13
    6545:	85 db                	test   %ebx,%ebx
    6547:	75 37                	jne    6580 <fwp_cli_parse+0x90>
    6549:	4d 8b 65 00          	mov    0x0(%r13),%r12
    654d:	49 83 fc 02          	cmp    $0x2,%r12
    6551:	72 2d                	jb     6580 <fwp_cli_parse+0x90>
    6553:	49 8d 7d 08          	lea    0x8(%r13),%rdi
    6557:	80 3f 2d             	cmpb   $0x2d,(%rdi)
    655a:	75 24                	jne    6580 <fwp_cli_parse+0x90>
    655c:	e8 ff 12 00 00       	call   7860 <fwp_is_number_arg>
    6561:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    6566:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    656b:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    6570:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    6575:	48 8b 0c 24          	mov    (%rsp),%rcx
    6579:	85 c0                	test   %eax,%eax
    657b:	74 2f                	je     65ac <fwp_cli_parse+0xbc>
    657d:	0f 1f 00             	nopl   (%rax)
    6580:	49 63 c7             	movslq %r15d,%rax
    6583:	41 8d 7f 01          	lea    0x1(%r15),%edi
    6587:	89 39                	mov    %edi,(%rcx)
    6589:	4c 89 2c c2          	mov    %r13,(%rdx,%rax,8)
    658d:	41 89 ff             	mov    %edi,%r15d
    6590:	4d 39 c6             	cmp    %r8,%r14
    6593:	40 0f 92 c5          	setb   %bpl
    6597:	4b 8d 04 31          	lea    (%r9,%r14,1),%rax
    659b:	48 ff c0             	inc    %rax
    659e:	49 ff c6             	inc    %r14
    65a1:	48 83 f8 01          	cmp    $0x1,%rax
    65a5:	75 99                	jne    6540 <fwp_cli_parse+0x50>
    65a7:	e9 a9 00 00 00       	jmp    6655 <fwp_cli_parse+0x165>
    65ac:	41 0f b6 45 09       	movzbl 0x9(%r13),%eax
    65b1:	49 83 fc 02          	cmp    $0x2,%r12
    65b5:	75 1a                	jne    65d1 <fwp_cli_parse+0xe1>
    65b7:	bb 01 00 00 00       	mov    $0x1,%ebx
    65bc:	3c 2d                	cmp    $0x2d,%al
    65be:	74 d0                	je     6590 <fwp_cli_parse+0xa0>
    65c0:	31 db                	xor    %ebx,%ebx
    65c2:	49 83 fc 02          	cmp    $0x2,%r12
    65c6:	75 b8                	jne    6580 <fwp_cli_parse+0x90>
    65c8:	3c 68                	cmp    $0x68,%al
    65ca:	75 b4                	jne    6580 <fwp_cli_parse+0x90>
    65cc:	e9 84 00 00 00       	jmp    6655 <fwp_cli_parse+0x165>
    65d1:	31 db                	xor    %ebx,%ebx
    65d3:	3c 2d                	cmp    $0x2d,%al
    65d5:	75 a9                	jne    6580 <fwp_cli_parse+0x90>
    65d7:	49 8d 5d 0a          	lea    0xa(%r13),%rbx
    65db:	49 83 c4 fe          	add    $0xfffffffffffffffe,%r12
    65df:	48 89 df             	mov    %rbx,%rdi
    65e2:	be 3d 00 00 00       	mov    $0x3d,%esi
    65e7:	4c 89 e2             	mov    %r12,%rdx
    65ea:	e8 61 bc ff ff       	call   2250 <memchr@plt>
    65ef:	48 89 c1             	mov    %rax,%rcx
    65f2:	48 29 d9             	sub    %rbx,%rcx
    65f5:	48 85 c0             	test   %rax,%rax
    65f8:	49 0f 44 cc          	cmove  %r12,%rcx
    65fc:	75 38                	jne    6636 <fwp_cli_parse+0x146>
    65fe:	48 83 f9 04          	cmp    $0x4,%rcx
    6602:	48 8b 0c 24          	mov    (%rsp),%rcx
    6606:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    660b:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    6610:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    6615:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    661a:	75 13                	jne    662f <fwp_cli_parse+0x13f>
    661c:	81 3b 68 65 6c 70    	cmpl   $0x706c6568,(%rbx)
    6622:	bb 00 00 00 00       	mov    $0x0,%ebx
    6627:	0f 85 53 ff ff ff    	jne    6580 <fwp_cli_parse+0x90>
    662d:	eb 26                	jmp    6655 <fwp_cli_parse+0x165>
    662f:	31 db                	xor    %ebx,%ebx
    6631:	e9 4a ff ff ff       	jmp    6580 <fwp_cli_parse+0x90>
    6636:	48 8b 0c 24          	mov    (%rsp),%rcx
    663a:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    663f:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    6644:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    6649:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    664e:	31 db                	xor    %ebx,%ebx
    6650:	e9 2b ff ff ff       	jmp    6580 <fwp_cli_parse+0x90>
    6655:	40 0f b6 c5          	movzbl %bpl,%eax
    6659:	83 e0 01             	and    $0x1,%eax
    665c:	48 83 c4 28          	add    $0x28,%rsp
    6660:	5b                   	pop    %rbx
    6661:	41 5c                	pop    %r12
    6663:	41 5d                	pop    %r13
    6665:	41 5e                	pop    %r14
    6667:	41 5f                	pop    %r15
    6669:	5d                   	pop    %rbp
    666a:	c3                   	ret
    666b:	31 c0                	xor    %eax,%eax
    666d:	c3                   	ret
    666e:	66 90                	xchg   %ax,%ax

0000000000006670 <fwp_usage_error>:
    6670:	48 8b 05 69 c9 00 00 	mov    0xc969(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    6677:	48 8b 38             	mov    (%rax),%rdi
    667a:	48 8d 35 54 7c 00 00 	lea    0x7c54(%rip),%rsi        # e2d5 <exec_in_fp0+0xc75>
    6681:	48 8d 15 60 7d 00 00 	lea    0x7d60(%rip),%rdx        # e3e8 <exec_in_fp0+0xd88>
    6688:	31 c0                	xor    %eax,%eax
    668a:	e9 51 bc ff ff       	jmp    22e0 <fprintf@plt>
    668f:	90                   	nop

0000000000006690 <fwp_parse_text>:
    6690:	48 83 ec 18          	sub    $0x18,%rsp
    6694:	48 89 d1             	mov    %rdx,%rcx
    6697:	48 89 3c 24          	mov    %rdi,(%rsp)
    669b:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    66a0:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    66a7:	00 00 
    66a9:	48 8d 35 78 e6 00 00 	lea    0xe678(%rip),%rsi        # 14d28 <d0>
    66b0:	48 89 e7             	mov    %rsp,%rdi
    66b3:	ba 01 00 00 00       	mov    $0x1,%edx
    66b8:	e8 a3 16 00 00       	call   7d60 <tp_value>
    66bd:	85 c0                	test   %eax,%eax
    66bf:	74 1c                	je     66dd <fwp_parse_text+0x4d>
    66c1:	48 89 e7             	mov    %rsp,%rdi
    66c4:	e8 c7 1f 00 00       	call   8690 <tp_ws>
    66c9:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    66ce:	31 c0                	xor    %eax,%eax
    66d0:	48 3b 4c 24 08       	cmp    0x8(%rsp),%rcx
    66d5:	0f 94 c0             	sete   %al
    66d8:	48 83 c4 18          	add    $0x18,%rsp
    66dc:	c3                   	ret
    66dd:	31 c0                	xor    %eax,%eax
    66df:	48 83 c4 18          	add    $0x18,%rsp
    66e3:	c3                   	ret
    66e4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    66eb:	00 00 00 00 00 

00000000000066f0 <fwp_parse_arg>:
    66f0:	53                   	push   %rbx
    66f1:	48 83 ec 10          	sub    $0x10,%rsp
    66f5:	89 fb                	mov    %edi,%ebx
    66f7:	48 8b 06             	mov    (%rsi),%rax
    66fa:	48 8d 7e 08          	lea    0x8(%rsi),%rdi
    66fe:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    6703:	48 89 c6             	mov    %rax,%rsi
    6706:	e8 85 12 00 00       	call   7990 <fwp_cli_value>
    670b:	89 c1                	mov    %eax,%ecx
    670d:	b8 01 00 00 00       	mov    $0x1,%eax
    6712:	85 c9                	test   %ecx,%ecx
    6714:	74 06                	je     671c <fwp_parse_arg+0x2c>
    6716:	48 83 c4 10          	add    $0x10,%rsp
    671a:	5b                   	pop    %rbx
    671b:	c3                   	ret
    671c:	48 8b 05 bd c8 00 00 	mov    0xc8bd(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    6723:	48 8b 38             	mov    (%rax),%rdi
    6726:	ff c3                	inc    %ebx
    6728:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
    672d:	49 83 c0 08          	add    $0x8,%r8
    6731:	48 8d 35 8c 7b 00 00 	lea    0x7b8c(%rip),%rsi        # e2c4 <exec_in_fp0+0xc64>
    6738:	48 8d 15 5c 6f 00 00 	lea    0x6f5c(%rip),%rdx        # d69b <exec_in_fp0+0x3b>
    673f:	89 d9                	mov    %ebx,%ecx
    6741:	31 c0                	xor    %eax,%eax
    6743:	e8 98 bb ff ff       	call   22e0 <fprintf@plt>
    6748:	31 c0                	xor    %eax,%eax
    674a:	eb ca                	jmp    6716 <fwp_parse_arg+0x26>
    674c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000006750 <fwp_bind_positional>:
    6750:	50                   	push   %rax
    6751:	31 c0                	xor    %eax,%eax
    6753:	85 f6                	test   %esi,%esi
    6755:	0f 9e c0             	setle  %al
    6758:	89 01                	mov    %eax,(%rcx)
    675a:	83 fe 01             	cmp    $0x1,%esi
    675d:	76 0c                	jbe    676b <fwp_bind_positional+0x1b>
    675f:	e8 0c ff ff ff       	call   6670 <fwp_usage_error>
    6764:	b8 02 00 00 00       	mov    $0x2,%eax
    6769:	59                   	pop    %rcx
    676a:	c3                   	ret
    676b:	31 c0                	xor    %eax,%eax
    676d:	83 fe 01             	cmp    $0x1,%esi
    6770:	75 f7                	jne    6769 <fwp_bind_positional+0x19>
    6772:	48 8b 37             	mov    (%rdi),%rsi
    6775:	31 ff                	xor    %edi,%edi
    6777:	e8 74 ff ff ff       	call   66f0 <fwp_parse_arg>
    677c:	89 c1                	mov    %eax,%ecx
    677e:	31 c0                	xor    %eax,%eax
    6780:	85 c9                	test   %ecx,%ecx
    6782:	0f 94 c0             	sete   %al
    6785:	01 c0                	add    %eax,%eax
    6787:	59                   	pop    %rcx
    6788:	c3                   	ret
    6789:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000006790 <fwp_pipe_out_start>:
    6790:	41 56                	push   %r14
    6792:	53                   	push   %rbx
    6793:	48 81 ec 08 01 00 00 	sub    $0x108,%rsp
    679a:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    679f:	bf 01 00 00 00       	mov    $0x1,%edi
    67a4:	e8 27 bd ff ff       	call   24d0 <fstat@plt>
    67a9:	85 c0                	test   %eax,%eax
    67ab:	0f 85 82 00 00 00    	jne    6833 <fwp_pipe_out_start+0xa3>
    67b1:	b8 00 f0 00 00       	mov    $0xf000,%eax
    67b6:	23 44 24 20          	and    0x20(%rsp),%eax
    67ba:	3d 00 10 00 00       	cmp    $0x1000,%eax
    67bf:	75 72                	jne    6833 <fwp_pipe_out_start+0xa3>
    67c1:	bf 01 00 00 00       	mov    $0x1,%edi
    67c6:	be 07 04 00 00       	mov    $0x407,%esi
    67cb:	ba 00 00 10 00       	mov    $0x100000,%edx
    67d0:	31 c0                	xor    %eax,%eax
    67d2:	e8 39 b9 ff ff       	call   2110 <fcntl@plt>
    67d7:	e8 34 36 00 00       	call   9e10 <fwp_transport_off>
    67dc:	85 c0                	test   %eax,%eax
    67de:	75 53                	jne    6833 <fwp_pipe_out_start+0xa3>
    67e0:	bf 01 00 00 00       	mov    $0x1,%edi
    67e5:	be 01 08 08 00       	mov    $0x80801,%esi
    67ea:	31 d2                	xor    %edx,%edx
    67ec:	e8 0f bd ff ff       	call   2500 <socket@plt>
    67f1:	85 c0                	test   %eax,%eax
    67f3:	78 3e                	js     6833 <fwp_pipe_out_start+0xa3>
    67f5:	89 c3                	mov    %eax,%ebx
    67f7:	4c 8d b4 24 9a 00 00 	lea    0x9a(%rsp),%r14
    67fe:	00 
    67ff:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    6804:	4c 89 f7             	mov    %r14,%rdi
    6807:	e8 34 36 00 00       	call   9e40 <fwp_pipe_addr>
    680c:	89 df                	mov    %ebx,%edi
    680e:	4c 89 f6             	mov    %r14,%rsi
    6811:	89 c2                	mov    %eax,%edx
    6813:	e8 a8 bb ff ff       	call   23c0 <bind@plt>
    6818:	85 c0                	test   %eax,%eax
    681a:	75 10                	jne    682c <fwp_pipe_out_start+0x9c>
    681c:	89 df                	mov    %ebx,%edi
    681e:	be 01 00 00 00       	mov    $0x1,%esi
    6823:	e8 28 bb ff ff       	call   2350 <listen@plt>
    6828:	85 c0                	test   %eax,%eax
    682a:	74 12                	je     683e <fwp_pipe_out_start+0xae>
    682c:	89 df                	mov    %ebx,%edi
    682e:	e8 ed b9 ff ff       	call   2220 <close@plt>
    6833:	48 81 c4 08 01 00 00 	add    $0x108,%rsp
    683a:	5b                   	pop    %rbx
    683b:	41 5e                	pop    %r14
    683d:	c3                   	ret
    683e:	89 1d 70 e4 00 00    	mov    %ebx,0xe470(%rip)        # 14cb4 <fwp_po_listen>
    6844:	e8 47 36 00 00       	call   9e90 <fwp_now_ns>
    6849:	48 b9 00 f2 05 2a 01 	movabs $0x12a05f200,%rcx
    6850:	00 00 00 
    6853:	48 01 c1             	add    %rax,%rcx
    6856:	48 89 0d db e5 01 00 	mov    %rcx,0x1e5db(%rip)        # 24e38 <fwp_po_give_up>
    685d:	eb d4                	jmp    6833 <fwp_pipe_out_start+0xa3>
    685f:	90                   	nop

0000000000006860 <fwp_pipe_write>:
    6860:	41 57                	push   %r15
    6862:	41 56                	push   %r14
    6864:	53                   	push   %rbx
    6865:	48 89 f3             	mov    %rsi,%rbx
    6868:	8b 05 d2 e5 01 00    	mov    0x1e5d2(%rip),%eax        # 24e40 <fwp_po_kind>
    686e:	83 f8 01             	cmp    $0x1,%eax
    6871:	74 12                	je     6885 <fwp_pipe_write+0x25>
    6873:	83 f8 02             	cmp    $0x2,%eax
    6876:	75 46                	jne    68be <fwp_pipe_write+0x5e>
    6878:	48 89 de             	mov    %rbx,%rsi
    687b:	5b                   	pop    %rbx
    687c:	41 5e                	pop    %r14
    687e:	41 5f                	pop    %r15
    6880:	e9 3b 36 00 00       	jmp    9ec0 <fwp_ring_put>
    6885:	49 89 fe             	mov    %rdi,%r14
    6888:	48 8b 05 b9 e5 01 00 	mov    0x1e5b9(%rip),%rax        # 24e48 <fwp_po_len>
    688f:	48 01 d8             	add    %rbx,%rax
    6892:	48 3d 01 00 01 00    	cmp    $0x10001,%rax
    6898:	72 05                	jb     689f <fwp_pipe_write+0x3f>
    689a:	e8 81 37 00 00       	call   a020 <fwp_po_flush_sock>
    689f:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    68a6:	72 32                	jb     68da <fwp_pipe_write+0x7a>
    68a8:	8b 3d 0a e4 00 00    	mov    0xe40a(%rip),%edi        # 14cb8 <fwp_po_sock>
    68ae:	4c 89 f6             	mov    %r14,%rsi
    68b1:	48 89 da             	mov    %rbx,%rdx
    68b4:	5b                   	pop    %rbx
    68b5:	41 5e                	pop    %r14
    68b7:	41 5f                	pop    %r15
    68b9:	e9 92 37 00 00       	jmp    a050 <fwp_po_write_raw>
    68be:	48 8b 05 f3 c6 00 00 	mov    0xc6f3(%rip),%rax        # 12fb8 <stdout@GLIBC_2.2.5>
    68c5:	48 8b 08             	mov    (%rax),%rcx
    68c8:	be 01 00 00 00       	mov    $0x1,%esi
    68cd:	48 89 da             	mov    %rbx,%rdx
    68d0:	5b                   	pop    %rbx
    68d1:	41 5e                	pop    %r14
    68d3:	41 5f                	pop    %r15
    68d5:	e9 b6 bb ff ff       	jmp    2490 <fwrite@plt>
    68da:	4c 8b 3d 67 e5 01 00 	mov    0x1e567(%rip),%r15        # 24e48 <fwp_po_len>
    68e1:	48 8d 3d 68 e5 01 00 	lea    0x1e568(%rip),%rdi        # 24e50 <fwp_po_buf>
    68e8:	4c 01 ff             	add    %r15,%rdi
    68eb:	4c 89 f6             	mov    %r14,%rsi
    68ee:	48 89 da             	mov    %rbx,%rdx
    68f1:	e8 2a ba ff ff       	call   2320 <memcpy@plt>
    68f6:	49 01 df             	add    %rbx,%r15
    68f9:	4c 89 3d 48 e5 01 00 	mov    %r15,0x1e548(%rip)        # 24e48 <fwp_po_len>
    6900:	5b                   	pop    %rbx
    6901:	41 5e                	pop    %r14
    6903:	41 5f                	pop    %r15
    6905:	c3                   	ret
    6906:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    690d:	00 00 00 

0000000000006910 <fwp_pipe_flush>:
    6910:	8b 05 2a e5 01 00    	mov    0x1e52a(%rip),%eax        # 24e40 <fwp_po_kind>
    6916:	85 c0                	test   %eax,%eax
    6918:	74 0a                	je     6924 <fwp_pipe_flush+0x14>
    691a:	83 f8 01             	cmp    $0x1,%eax
    691d:	75 1b                	jne    693a <fwp_pipe_flush+0x2a>
    691f:	e9 fc 36 00 00       	jmp    a020 <fwp_po_flush_sock>
    6924:	50                   	push   %rax
    6925:	48 8b 05 8c c6 00 00 	mov    0xc68c(%rip),%rax        # 12fb8 <stdout@GLIBC_2.2.5>
    692c:	48 8b 38             	mov    (%rax),%rdi
    692f:	e8 0c ba ff ff       	call   2340 <fflush@plt>
    6934:	58                   	pop    %rax
    6935:	e9 f6 39 00 00       	jmp    a330 <fwp_pipe_poll>
    693a:	c3                   	ret
    693b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006940 <fwp_pipe_out_ready>:
    6940:	48 83 ec 18          	sub    $0x18,%rsp
    6944:	48 8d 3d c8 79 00 00 	lea    0x79c8(%rip),%rdi        # e313 <exec_in_fp0+0xcb3>
    694b:	e8 e0 b6 ff ff       	call   2030 <getenv@plt>
    6950:	48 85 c0             	test   %rax,%rax
    6953:	74 79                	je     69ce <fwp_pipe_out_ready+0x8e>
    6955:	83 3d 58 e3 00 00 00 	cmpl   $0x0,0xe358(%rip)        # 14cb4 <fwp_po_listen>
    695c:	78 70                	js     69ce <fwp_pipe_out_ready+0x8e>
    695e:	80 38 00             	cmpb   $0x0,(%rax)
    6961:	74 6b                	je     69ce <fwp_pipe_out_ready+0x8e>
    6963:	48 89 c7             	mov    %rax,%rdi
    6966:	31 f6                	xor    %esi,%esi
    6968:	ba 0a 00 00 00       	mov    $0xa,%edx
    696d:	e8 9e b9 ff ff       	call   2310 <strtol@plt>
    6972:	8b 0d 3c e3 00 00    	mov    0xe33c(%rip),%ecx        # 14cb4 <fwp_po_listen>
    6978:	89 0c 24             	mov    %ecx,(%rsp)
    697b:	48 b9 01 00 00 00 01 	movabs $0x100000001,%rcx
    6982:	00 00 00 
    6985:	48 89 4c 24 04       	mov    %rcx,0x4(%rsp)
    698a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%rsp)
    6991:	00 
    6992:	48 85 c0             	test   %rax,%rax
    6995:	7e 37                	jle    69ce <fwp_pipe_out_ready+0x8e>
    6997:	48 3d ff ff ff 7f    	cmp    $0x7fffffff,%rax
    699d:	ba ff ff ff 7f       	mov    $0x7fffffff,%edx
    69a2:	48 0f 4c d0          	cmovl  %rax,%rdx
    69a6:	48 89 e7             	mov    %rsp,%rdi
    69a9:	be 02 00 00 00       	mov    $0x2,%esi
    69ae:	e8 fd b9 ff ff       	call   23b0 <poll@plt>
    69b3:	85 c0                	test   %eax,%eax
    69b5:	7e 17                	jle    69ce <fwp_pipe_out_ready+0x8e>
    69b7:	f6 44 24 06 01       	testb  $0x1,0x6(%rsp)
    69bc:	74 10                	je     69ce <fwp_pipe_out_ready+0x8e>
    69be:	48 c7 05 97 e4 02 00 	movq   $0x0,0x2e497(%rip)        # 34e60 <fwp_po_next_check>
    69c5:	00 00 00 00 
    69c9:	e8 62 39 00 00       	call   a330 <fwp_pipe_poll>
    69ce:	48 83 c4 18          	add    $0x18,%rsp
    69d2:	c3                   	ret
    69d3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    69da:	84 00 00 00 00 00 

00000000000069e0 <fwp_exec_call>:
    69e0:	41 56                	push   %r14
    69e2:	53                   	push   %rbx
    69e3:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
    69ea:	48 89 f3             	mov    %rsi,%rbx
    69ed:	49 89 fe             	mov    %rdi,%r14
    69f0:	48 8b 05 71 e4 02 00 	mov    0x2e471(%rip),%rax        # 34e68 <fwp_handlers>
    69f7:	48 89 84 24 d0 00 00 	mov    %rax,0xd0(%rsp)
    69fe:	00 
    69ff:	48 c7 84 24 e8 00 00 	movq   $0x0,0xe8(%rsp)
    6a06:	00 00 00 00 00 
    6a0b:	48 8b 05 c6 e3 00 00 	mov    0xe3c6(%rip),%rax        # 14dd8 <fwp_cleanups>
    6a12:	48 89 84 24 f0 00 00 	mov    %rax,0xf0(%rsp)
    6a19:	00 
    6a1a:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    6a1f:	48 89 3d 42 e4 02 00 	mov    %rdi,0x2e442(%rip)        # 34e68 <fwp_handlers>
    6a26:	e8 75 b8 ff ff       	call   22a0 <_setjmp@plt>
    6a2b:	85 c0                	test   %eax,%eax
    6a2d:	74 32                	je     6a61 <fwp_exec_call+0x81>
    6a2f:	48 8b 84 24 d0 00 00 	mov    0xd0(%rsp),%rax
    6a36:	00 
    6a37:	48 89 05 2a e4 02 00 	mov    %rax,0x2e42a(%rip)        # 34e68 <fwp_handlers>
    6a3e:	e8 1d c5 ff ff       	call   2f60 <fwp_flush>
    6a43:	48 8b bc 24 d8 00 00 	mov    0xd8(%rsp),%rdi
    6a4a:	00 
    6a4b:	48 8b b4 24 e0 00 00 	mov    0xe0(%rsp),%rsi
    6a52:	00 
    6a53:	e8 28 41 00 00       	call   ab80 <fwp_exec_error>
    6a58:	b9 01 00 00 00       	mov    $0x1,%ecx
    6a5d:	31 c0                	xor    %eax,%eax
    6a5f:	eb 21                	jmp    6a82 <fwp_exec_call+0xa2>
    6a61:	e8 fa 40 00 00       	call   ab60 <fwp_pap>
    6a66:	48 89 c7             	mov    %rax,%rdi
    6a69:	4c 89 f6             	mov    %r14,%rsi
    6a6c:	e8 2f 3c 00 00       	call   a6a0 <fwp_apply>
    6a71:	48 8b 8c 24 d0 00 00 	mov    0xd0(%rsp),%rcx
    6a78:	00 
    6a79:	48 89 0d e8 e3 02 00 	mov    %rcx,0x2e3e8(%rip)        # 34e68 <fwp_handlers>
    6a80:	31 c9                	xor    %ecx,%ecx
    6a82:	89 0b                	mov    %ecx,(%rbx)
    6a84:	48 81 c4 f8 00 00 00 	add    $0xf8,%rsp
    6a8b:	5b                   	pop    %rbx
    6a8c:	41 5e                	pop    %r14
    6a8e:	c3                   	ret
    6a8f:	90                   	nop

0000000000006a90 <fwp_emit_result>:
    6a90:	e9 5b 55 00 00       	jmp    bff0 <fwp_emit>
    6a95:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    6a9c:	00 00 00 00 

0000000000006aa0 <fwp_read_exact>:
    6aa0:	41 57                	push   %r15
    6aa2:	41 56                	push   %r14
    6aa4:	53                   	push   %rbx
    6aa5:	48 89 f3             	mov    %rsi,%rbx
    6aa8:	49 89 fe             	mov    %rdi,%r14
    6aab:	45 31 ff             	xor    %r15d,%r15d
    6aae:	48 85 f6             	test   %rsi,%rsi
    6ab1:	0f 84 b9 00 00 00    	je     6b70 <fwp_read_exact+0xd0>
    6ab7:	8b 05 6b e3 01 00    	mov    0x1e36b(%rip),%eax        # 24e28 <fwp_in_npend>
    6abd:	8b 0d 69 e3 01 00    	mov    0x1e369(%rip),%ecx        # 24e2c <fwp_in_ppos>
    6ac3:	39 c1                	cmp    %eax,%ecx
    6ac5:	0f 8d a5 00 00 00    	jge    6b70 <fwp_read_exact+0xd0>
    6acb:	48 98                	cltq
    6acd:	48 63 f1             	movslq %ecx,%rsi
    6ad0:	48 89 f2             	mov    %rsi,%rdx
    6ad3:	48 f7 d2             	not    %rdx
    6ad6:	48 01 c2             	add    %rax,%rdx
    6ad9:	48 8d 4b ff          	lea    -0x1(%rbx),%rcx
    6add:	48 39 ca             	cmp    %rcx,%rdx
    6ae0:	48 0f 43 d1          	cmovae %rcx,%rdx
    6ae4:	48 ff c2             	inc    %rdx
    6ae7:	48 83 fa 20          	cmp    $0x20,%rdx
    6aeb:	72 16                	jb     6b03 <fwp_read_exact+0x63>
    6aed:	48 8d 3d 30 e3 01 00 	lea    0x1e330(%rip),%rdi        # 24e24 <fwp_in_pend>
    6af4:	4d 89 f0             	mov    %r14,%r8
    6af7:	49 29 f0             	sub    %rsi,%r8
    6afa:	49 29 f8             	sub    %rdi,%r8
    6afd:	49 83 f8 20          	cmp    $0x20,%r8
    6b01:	73 27                	jae    6b2a <fwp_read_exact+0x8a>
    6b03:	45 31 ff             	xor    %r15d,%r15d
    6b06:	48 89 f1             	mov    %rsi,%rcx
    6b09:	48 8d 15 14 e3 01 00 	lea    0x1e314(%rip),%rdx        # 24e24 <fwp_in_pend>
    6b10:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6b14:	48 ff c1             	inc    %rcx
    6b17:	43 88 34 3e          	mov    %sil,(%r14,%r15,1)
    6b1b:	49 ff c7             	inc    %r15
    6b1e:	49 39 df             	cmp    %rbx,%r15
    6b21:	73 3f                	jae    6b62 <fwp_read_exact+0xc2>
    6b23:	48 39 c1             	cmp    %rax,%rcx
    6b26:	7c e8                	jl     6b10 <fwp_read_exact+0x70>
    6b28:	eb 38                	jmp    6b62 <fwp_read_exact+0xc2>
    6b2a:	49 89 d7             	mov    %rdx,%r15
    6b2d:	49 83 e7 e0          	and    $0xffffffffffffffe0,%r15
    6b31:	49 8d 0c 37          	lea    (%r15,%rsi,1),%rcx
    6b35:	48 01 fe             	add    %rdi,%rsi
    6b38:	48 83 c6 10          	add    $0x10,%rsi
    6b3c:	31 ff                	xor    %edi,%edi
    6b3e:	66 90                	xchg   %ax,%ax
    6b40:	0f 10 44 3e f0       	movups -0x10(%rsi,%rdi,1),%xmm0
    6b45:	0f 10 0c 3e          	movups (%rsi,%rdi,1),%xmm1
    6b49:	41 0f 11 04 3e       	movups %xmm0,(%r14,%rdi,1)
    6b4e:	41 0f 11 4c 3e 10    	movups %xmm1,0x10(%r14,%rdi,1)
    6b54:	48 83 c7 20          	add    $0x20,%rdi
    6b58:	49 39 ff             	cmp    %rdi,%r15
    6b5b:	75 e3                	jne    6b40 <fwp_read_exact+0xa0>
    6b5d:	4c 39 fa             	cmp    %r15,%rdx
    6b60:	75 a7                	jne    6b09 <fwp_read_exact+0x69>
    6b62:	89 0d c4 e2 01 00    	mov    %ecx,0x1e2c4(%rip)        # 24e2c <fwp_in_ppos>
    6b68:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6b6f:	00 
    6b70:	48 89 de             	mov    %rbx,%rsi
    6b73:	4c 29 fe             	sub    %r15,%rsi
    6b76:	76 15                	jbe    6b8d <fwp_read_exact+0xed>
    6b78:	4b 8d 3c 3e          	lea    (%r14,%r15,1),%rdi
    6b7c:	e8 4f 58 00 00       	call   c3d0 <fwp_pipe_read>
    6b81:	49 01 c7             	add    %rax,%r15
    6b84:	48 85 c0             	test   %rax,%rax
    6b87:	75 e7                	jne    6b70 <fwp_read_exact+0xd0>
    6b89:	31 c0                	xor    %eax,%eax
    6b8b:	eb 05                	jmp    6b92 <fwp_read_exact+0xf2>
    6b8d:	b8 01 00 00 00       	mov    $0x1,%eax
    6b92:	5b                   	pop    %rbx
    6b93:	41 5e                	pop    %r14
    6b95:	41 5f                	pop    %r15
    6b97:	c3                   	ret
    6b98:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6b9f:	00 

0000000000006ba0 <fwp_stdin_leb>:
    6ba0:	41 57                	push   %r15
    6ba2:	41 56                	push   %r14
    6ba4:	53                   	push   %rbx
    6ba5:	48 83 ec 10          	sub    $0x10,%rsp
    6ba9:	48 89 fb             	mov    %rdi,%rbx
    6bac:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    6bb3:	49 c7 c6 f9 ff ff ff 	mov    $0xfffffffffffffff9,%r14
    6bba:	4c 8d 7c 24 0f       	lea    0xf(%rsp),%r15
    6bbf:	90                   	nop
    6bc0:	be 01 00 00 00       	mov    $0x1,%esi
    6bc5:	4c 89 ff             	mov    %r15,%rdi
    6bc8:	e8 d3 fe ff ff       	call   6aa0 <fwp_read_exact>
    6bcd:	85 c0                	test   %eax,%eax
    6bcf:	74 35                	je     6c06 <fwp_stdin_leb+0x66>
    6bd1:	0f b6 44 24 0f       	movzbl 0xf(%rsp),%eax
    6bd6:	49 83 fe 38          	cmp    $0x38,%r14
    6bda:	75 07                	jne    6be3 <fwp_stdin_leb+0x43>
    6bdc:	89 c1                	mov    %eax,%ecx
    6bde:	80 e1 7e             	and    $0x7e,%cl
    6be1:	75 1c                	jne    6bff <fwp_stdin_leb+0x5f>
    6be3:	49 83 c6 07          	add    $0x7,%r14
    6be7:	89 c2                	mov    %eax,%edx
    6be9:	83 e2 7f             	and    $0x7f,%edx
    6bec:	44 89 f1             	mov    %r14d,%ecx
    6bef:	48 d3 e2             	shl    %cl,%rdx
    6bf2:	48 09 13             	or     %rdx,(%rbx)
    6bf5:	84 c0                	test   %al,%al
    6bf7:	79 11                	jns    6c0a <fwp_stdin_leb+0x6a>
    6bf9:	49 83 fe 38          	cmp    $0x38,%r14
    6bfd:	76 c1                	jbe    6bc0 <fwp_stdin_leb+0x20>
    6bff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    6c04:	eb 09                	jmp    6c0f <fwp_stdin_leb+0x6f>
    6c06:	31 c0                	xor    %eax,%eax
    6c08:	eb 05                	jmp    6c0f <fwp_stdin_leb+0x6f>
    6c0a:	b8 01 00 00 00       	mov    $0x1,%eax
    6c0f:	48 83 c4 10          	add    $0x10,%rsp
    6c13:	5b                   	pop    %rbx
    6c14:	41 5e                	pop    %r14
    6c16:	41 5f                	pop    %r15
    6c18:	c3                   	ret
    6c19:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000006c20 <fwp_stdin_name_len>:
    6c20:	53                   	push   %rbx
    6c21:	48 89 fb             	mov    %rdi,%rbx
    6c24:	e8 77 ff ff ff       	call   6ba0 <fwp_stdin_leb>
    6c29:	83 f8 01             	cmp    $0x1,%eax
    6c2c:	75 0e                	jne    6c3c <fwp_stdin_name_len+0x1c>
    6c2e:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    6c33:	48 81 3b 00 00 10 00 	cmpq   $0x100000,(%rbx)
    6c3a:	77 02                	ja     6c3e <fwp_stdin_name_len+0x1e>
    6c3c:	89 c1                	mov    %eax,%ecx
    6c3e:	89 c8                	mov    %ecx,%eax
    6c40:	5b                   	pop    %rbx
    6c41:	c3                   	ret
    6c42:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6c49:	1f 84 00 00 00 00 00 

0000000000006c50 <fwp_pipe_in_offer>:
    6c50:	55                   	push   %rbp
    6c51:	41 57                	push   %r15
    6c53:	41 56                	push   %r14
    6c55:	53                   	push   %rbx
    6c56:	48 81 ec 08 01 00 00 	sub    $0x108,%rsp
    6c5d:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    6c62:	31 ff                	xor    %edi,%edi
    6c64:	e8 67 b8 ff ff       	call   24d0 <fstat@plt>
    6c69:	85 c0                	test   %eax,%eax
    6c6b:	0f 85 a5 00 00 00    	jne    6d16 <fwp_pipe_in_offer+0xc6>
    6c71:	b8 00 f0 00 00       	mov    $0xf000,%eax
    6c76:	23 44 24 20          	and    0x20(%rsp),%eax
    6c7a:	3d 00 10 00 00       	cmp    $0x1000,%eax
    6c7f:	0f 85 91 00 00 00    	jne    6d16 <fwp_pipe_in_offer+0xc6>
    6c85:	bf 01 00 00 00       	mov    $0x1,%edi
    6c8a:	be 01 00 08 00       	mov    $0x80001,%esi
    6c8f:	31 d2                	xor    %edx,%edx
    6c91:	e8 6a b8 ff ff       	call   2500 <socket@plt>
    6c96:	85 c0                	test   %eax,%eax
    6c98:	78 7c                	js     6d16 <fwp_pipe_in_offer+0xc6>
    6c9a:	89 c3                	mov    %eax,%ebx
    6c9c:	48 8d bc 24 9a 00 00 	lea    0x9a(%rsp),%rdi
    6ca3:	00 
    6ca4:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    6ca9:	e8 92 31 00 00       	call   9e40 <fwp_pipe_addr>
    6cae:	41 89 c6             	mov    %eax,%r14d
    6cb1:	48 8d 3d 21 76 00 00 	lea    0x7621(%rip),%rdi        # e2d9 <exec_in_fp0+0xc79>
    6cb8:	e8 73 b3 ff ff       	call   2030 <getenv@plt>
    6cbd:	49 89 c7             	mov    %rax,%r15
    6cc0:	e8 4b 31 00 00       	call   9e10 <fwp_transport_off>
    6cc5:	89 c5                	mov    %eax,%ebp
    6cc7:	c7 04 24 46 57 50 54 	movl   $0x54505746,(%rsp)
    6cce:	85 c0                	test   %eax,%eax
    6cd0:	74 04                	je     6cd6 <fwp_pipe_in_offer+0x86>
    6cd2:	31 c0                	xor    %eax,%eax
    6cd4:	eb 1f                	jmp    6cf5 <fwp_pipe_in_offer+0xa5>
    6cd6:	4d 85 ff             	test   %r15,%r15
    6cd9:	74 18                	je     6cf3 <fwp_pipe_in_offer+0xa3>
    6cdb:	48 8d 35 ca 76 00 00 	lea    0x76ca(%rip),%rsi        # e3ac <exec_in_fp0+0xd4c>
    6ce2:	4c 89 ff             	mov    %r15,%rdi
    6ce5:	e8 d6 b5 ff ff       	call   22c0 <strcmp@plt>
    6cea:	83 f8 01             	cmp    $0x1,%eax
    6ced:	b0 02                	mov    $0x2,%al
    6cef:	1c 00                	sbb    $0x0,%al
    6cf1:	eb 02                	jmp    6cf5 <fwp_pipe_in_offer+0xa5>
    6cf3:	b0 02                	mov    $0x2,%al
    6cf5:	88 44 24 04          	mov    %al,0x4(%rsp)
    6cf9:	48 8d b4 24 9a 00 00 	lea    0x9a(%rsp),%rsi
    6d00:	00 
    6d01:	89 df                	mov    %ebx,%edi
    6d03:	44 89 f2             	mov    %r14d,%edx
    6d06:	e8 75 b7 ff ff       	call   2480 <connect@plt>
    6d0b:	85 c0                	test   %eax,%eax
    6d0d:	74 15                	je     6d24 <fwp_pipe_in_offer+0xd4>
    6d0f:	89 df                	mov    %ebx,%edi
    6d11:	e8 0a b5 ff ff       	call   2220 <close@plt>
    6d16:	48 81 c4 08 01 00 00 	add    $0x108,%rsp
    6d1d:	5b                   	pop    %rbx
    6d1e:	41 5e                	pop    %r14
    6d20:	41 5f                	pop    %r15
    6d22:	5d                   	pop    %rbp
    6d23:	c3                   	ret
    6d24:	48 89 e6             	mov    %rsp,%rsi
    6d27:	ba 05 00 00 00       	mov    $0x5,%edx
    6d2c:	89 df                	mov    %ebx,%edi
    6d2e:	b9 00 40 00 00       	mov    $0x4000,%ecx
    6d33:	e8 58 b4 ff ff       	call   2190 <send@plt>
    6d38:	85 ed                	test   %ebp,%ebp
    6d3a:	75 d3                	jne    6d0f <fwp_pipe_in_offer+0xbf>
    6d3c:	48 83 f8 05          	cmp    $0x5,%rax
    6d40:	75 cd                	jne    6d0f <fwp_pipe_in_offer+0xbf>
    6d42:	89 1d 78 df 00 00    	mov    %ebx,0xdf78(%rip)        # 14cc0 <fwp_pi_sock>
    6d48:	eb cc                	jmp    6d16 <fwp_pipe_in_offer+0xc6>
    6d4a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000006d50 <fwp_pipe_in_switch>:
    6d50:	55                   	push   %rbp
    6d51:	41 57                	push   %r15
    6d53:	41 56                	push   %r14
    6d55:	53                   	push   %rbx
    6d56:	48 81 ec 08 01 00 00 	sub    $0x108,%rsp
    6d5d:	31 db                	xor    %ebx,%ebx
    6d5f:	48 83 fe 01          	cmp    $0x1,%rsi
    6d63:	0f 85 f6 01 00 00    	jne    6f5f <fwp_pipe_in_switch+0x20f>
    6d69:	48 89 f8             	mov    %rdi,%rax
    6d6c:	8b 3d 4e df 00 00    	mov    0xdf4e(%rip),%edi        # 14cc0 <fwp_pi_sock>
    6d72:	85 ff                	test   %edi,%edi
    6d74:	0f 88 e5 01 00 00    	js     6f5f <fwp_pipe_in_switch+0x20f>
    6d7a:	83 3d f3 e0 02 00 00 	cmpl   $0x0,0x2e0f3(%rip)        # 34e74 <fwp_pi_kind>
    6d81:	0f 85 d8 01 00 00    	jne    6f5f <fwp_pipe_in_switch+0x20f>
    6d87:	0f b6 00             	movzbl (%rax),%eax
    6d8a:	83 f8 02             	cmp    $0x2,%eax
    6d8d:	74 29                	je     6db8 <fwp_pipe_in_switch+0x68>
    6d8f:	83 f8 01             	cmp    $0x1,%eax
    6d92:	0f 85 c7 01 00 00    	jne    6f5f <fwp_pipe_in_switch+0x20f>
    6d98:	c7 05 d2 e0 02 00 01 	movl   $0x1,0x2e0d2(%rip)        # 34e74 <fwp_pi_kind>
    6d9f:	00 00 00 
    6da2:	48 8d 3d 1a 73 00 00 	lea    0x731a(%rip),%rdi        # e0c3 <exec_in_fp0+0xa63>
    6da9:	e8 42 58 00 00       	call   c5f0 <fwp_pipe_report>
    6dae:	bb 01 00 00 00       	mov    $0x1,%ebx
    6db3:	e9 a7 01 00 00       	jmp    6f5f <fwp_pipe_in_switch+0x20f>
    6db8:	48 8d 44 24 0f       	lea    0xf(%rsp),%rax
    6dbd:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    6dc2:	48 c7 44 24 58 01 00 	movq   $0x1,0x58(%rsp)
    6dc9:	00 00 
    6dcb:	0f 57 c0             	xorps  %xmm0,%xmm0
    6dce:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    6dd3:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    6dd8:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    6ddd:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    6de4:	00 00 
    6de6:	48 8d 44 24 50       	lea    0x50(%rsp),%rax
    6deb:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    6df0:	48 c7 44 24 28 01 00 	movq   $0x1,0x28(%rsp)
    6df7:	00 00 
    6df9:	48 8d 44 24 60       	lea    0x60(%rsp),%rax
    6dfe:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    6e03:	48 c7 44 24 38 18 00 	movq   $0x18,0x38(%rsp)
    6e0a:	00 00 
    6e0c:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    6e11:	ba 00 00 00 40       	mov    $0x40000000,%edx
    6e16:	e8 75 b5 ff ff       	call   2390 <recvmsg@plt>
    6e1b:	31 db                	xor    %ebx,%ebx
    6e1d:	48 83 f8 01          	cmp    $0x1,%rax
    6e21:	0f 85 38 01 00 00    	jne    6f5f <fwp_pipe_in_switch+0x20f>
    6e27:	48 83 7c 24 38 10    	cmpq   $0x10,0x38(%rsp)
    6e2d:	0f 82 2c 01 00 00    	jb     6f5f <fwp_pipe_in_switch+0x20f>
    6e33:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    6e38:	48 85 c0             	test   %rax,%rax
    6e3b:	0f 84 1e 01 00 00    	je     6f5f <fwp_pipe_in_switch+0x20f>
    6e41:	83 78 0c 01          	cmpl   $0x1,0xc(%rax)
    6e45:	0f 85 14 01 00 00    	jne    6f5f <fwp_pipe_in_switch+0x20f>
    6e4b:	8b 68 10             	mov    0x10(%rax),%ebp
    6e4e:	48 8d 74 24 78       	lea    0x78(%rsp),%rsi
    6e53:	89 ef                	mov    %ebp,%edi
    6e55:	e8 76 b6 ff ff       	call   24d0 <fstat@plt>
    6e5a:	85 c0                	test   %eax,%eax
    6e5c:	0f 85 f4 00 00 00    	jne    6f56 <fwp_pipe_in_switch+0x206>
    6e62:	4c 8b b4 24 a8 00 00 	mov    0xa8(%rsp),%r14
    6e69:	00 
    6e6a:	49 81 fe 00 10 00 00 	cmp    $0x1000,%r14
    6e71:	0f 86 df 00 00 00    	jbe    6f56 <fwp_pipe_in_switch+0x206>
    6e77:	31 db                	xor    %ebx,%ebx
    6e79:	31 ff                	xor    %edi,%edi
    6e7b:	4c 89 f6             	mov    %r14,%rsi
    6e7e:	ba 03 00 00 00       	mov    $0x3,%edx
    6e83:	b9 01 00 00 00       	mov    $0x1,%ecx
    6e88:	41 89 e8             	mov    %ebp,%r8d
    6e8b:	45 31 c9             	xor    %r9d,%r9d
    6e8e:	e8 ed b2 ff ff       	call   2180 <mmap@plt>
    6e93:	49 89 c7             	mov    %rax,%r15
    6e96:	89 ef                	mov    %ebp,%edi
    6e98:	e8 83 b3 ff ff       	call   2220 <close@plt>
    6e9d:	49 83 ff ff          	cmp    $0xffffffffffffffff,%r15
    6ea1:	0f 84 b8 00 00 00    	je     6f5f <fwp_pipe_in_switch+0x20f>
    6ea7:	41 81 3f 46 57 50 53 	cmpl   $0x53505746,(%r15)
    6eae:	0f 85 ab 00 00 00    	jne    6f5f <fwp_pipe_in_switch+0x20f>
    6eb4:	41 83 7f 04 01       	cmpl   $0x1,0x4(%r15)
    6eb9:	0f 85 a0 00 00 00    	jne    6f5f <fwp_pipe_in_switch+0x20f>
    6ebf:	49 8b 47 08          	mov    0x8(%r15),%rax
    6ec3:	48 85 c0             	test   %rax,%rax
    6ec6:	0f 84 93 00 00 00    	je     6f5f <fwp_pipe_in_switch+0x20f>
    6ecc:	48 89 c1             	mov    %rax,%rcx
    6ecf:	48 d1 e9             	shr    $1,%rcx
    6ed2:	48 ba 55 55 55 55 55 	movabs $0x5555555555555555,%rdx
    6ed9:	55 55 55 
    6edc:	48 21 ca             	and    %rcx,%rdx
    6edf:	48 89 c1             	mov    %rax,%rcx
    6ee2:	48 29 d1             	sub    %rdx,%rcx
    6ee5:	48 ba 33 33 33 33 33 	movabs $0x3333333333333333,%rdx
    6eec:	33 33 33 
    6eef:	48 89 ce             	mov    %rcx,%rsi
    6ef2:	48 21 d6             	and    %rdx,%rsi
    6ef5:	48 c1 e9 02          	shr    $0x2,%rcx
    6ef9:	48 21 d1             	and    %rdx,%rcx
    6efc:	48 01 f1             	add    %rsi,%rcx
    6eff:	48 89 ca             	mov    %rcx,%rdx
    6f02:	48 c1 ea 04          	shr    $0x4,%rdx
    6f06:	48 01 ca             	add    %rcx,%rdx
    6f09:	48 b9 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%rcx
    6f10:	0f 0f 0f 
    6f13:	48 21 d1             	and    %rdx,%rcx
    6f16:	48 ba 01 01 01 01 01 	movabs $0x101010101010101,%rdx
    6f1d:	01 01 01 
    6f20:	48 0f af d1          	imul   %rcx,%rdx
    6f24:	48 c1 ea 38          	shr    $0x38,%rdx
    6f28:	83 fa 01             	cmp    $0x1,%edx
    6f2b:	77 32                	ja     6f5f <fwp_pipe_in_switch+0x20f>
    6f2d:	49 81 c6 00 f0 ff ff 	add    $0xfffffffffffff000,%r14
    6f34:	4c 39 f0             	cmp    %r14,%rax
    6f37:	77 26                	ja     6f5f <fwp_pipe_in_switch+0x20f>
    6f39:	4c 89 3d 38 df 02 00 	mov    %r15,0x2df38(%rip)        # 34e78 <fwp_pi_ring>
    6f40:	c7 05 2a df 02 00 02 	movl   $0x2,0x2df2a(%rip)        # 34e74 <fwp_pi_kind>
    6f47:	00 00 00 
    6f4a:	48 8d 3d 5f 74 00 00 	lea    0x745f(%rip),%rdi        # e3b0 <exec_in_fp0+0xd50>
    6f51:	e9 53 fe ff ff       	jmp    6da9 <fwp_pipe_in_switch+0x59>
    6f56:	89 ef                	mov    %ebp,%edi
    6f58:	e8 c3 b2 ff ff       	call   2220 <close@plt>
    6f5d:	31 db                	xor    %ebx,%ebx
    6f5f:	89 d8                	mov    %ebx,%eax
    6f61:	48 81 c4 08 01 00 00 	add    $0x108,%rsp
    6f68:	5b                   	pop    %rbx
    6f69:	41 5e                	pop    %r14
    6f6b:	41 5f                	pop    %r15
    6f6d:	5d                   	pop    %rbp
    6f6e:	c3                   	ret
    6f6f:	90                   	nop

0000000000006f70 <fwp_decode>:
    6f70:	55                   	push   %rbp
    6f71:	41 57                	push   %r15
    6f73:	41 56                	push   %r14
    6f75:	41 55                	push   %r13
    6f77:	41 54                	push   %r12
    6f79:	53                   	push   %rbx
    6f7a:	48 83 ec 38          	sub    $0x38,%rsp
    6f7e:	8b 06                	mov    (%rsi),%eax
    6f80:	45 31 f6             	xor    %r14d,%r14d
    6f83:	48 83 f8 15          	cmp    $0x15,%rax
    6f87:	77 47                	ja     6fd0 <fwp_decode+0x60>
    6f89:	48 89 d3             	mov    %rdx,%rbx
    6f8c:	49 89 f4             	mov    %rsi,%r12
    6f8f:	49 89 ff             	mov    %rdi,%r15
    6f92:	48 8d 0d f7 61 00 00 	lea    0x61f7(%rip),%rcx        # d190 <_IO_stdin_used+0x190>
    6f99:	48 63 14 81          	movslq (%rcx,%rax,4),%rdx
    6f9d:	48 01 ca             	add    %rcx,%rdx
    6fa0:	ff e2                	jmp    *%rdx
    6fa2:	31 c9                	xor    %ecx,%ecx
    6fa4:	83 f8 0a             	cmp    $0xa,%eax
    6fa7:	0f 95 c1             	setne  %cl
    6faa:	8d 34 8d 04 00 00 00 	lea    0x4(,%rcx,4),%esi
    6fb1:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    6fb6:	4c 89 ff             	mov    %r15,%rdi
    6fb9:	e8 82 56 00 00       	call   c640 <rd_le>
    6fbe:	85 c0                	test   %eax,%eax
    6fc0:	74 0e                	je     6fd0 <fwp_decode+0x60>
    6fc2:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    6fc7:	48 89 03             	mov    %rax,(%rbx)
    6fca:	41 be 01 00 00 00    	mov    $0x1,%r14d
    6fd0:	44 89 f0             	mov    %r14d,%eax
    6fd3:	48 83 c4 38          	add    $0x38,%rsp
    6fd7:	5b                   	pop    %rbx
    6fd8:	41 5c                	pop    %r12
    6fda:	41 5d                	pop    %r13
    6fdc:	41 5e                	pop    %r14
    6fde:	41 5f                	pop    %r15
    6fe0:	5d                   	pop    %rbp
    6fe1:	c3                   	ret
    6fe2:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    6fe7:	4c 89 ff             	mov    %r15,%rdi
    6fea:	e8 11 57 00 00       	call   c700 <rd_leb>
    6fef:	45 31 f6             	xor    %r14d,%r14d
    6ff2:	85 c0                	test   %eax,%eax
    6ff4:	74 da                	je     6fd0 <fwp_decode+0x60>
    6ff6:	4c 8b 6c 24 08       	mov    0x8(%rsp),%r13
    6ffb:	4d 3b 6f 08          	cmp    0x8(%r15),%r13
    6fff:	77 cf                	ja     6fd0 <fwp_decode+0x60>
    7001:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    7006:	4c 89 ff             	mov    %r15,%rdi
    7009:	4c 89 ee             	mov    %r13,%rsi
    700c:	e8 6f 57 00 00       	call   c780 <rd_take>
    7011:	85 c0                	test   %eax,%eax
    7013:	74 bb                	je     6fd0 <fwp_decode+0x60>
    7015:	41 83 3c 24 0c       	cmpl   $0xc,(%r12)
    701a:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    701f:	75 0f                	jne    7030 <fwp_decode+0xc0>
    7021:	4c 89 ff             	mov    %r15,%rdi
    7024:	4c 89 ee             	mov    %r13,%rsi
    7027:	e8 14 05 00 00       	call   7540 <fwp_valid_utf8>
    702c:	85 c0                	test   %eax,%eax
    702e:	74 a0                	je     6fd0 <fwp_decode+0x60>
    7030:	4c 89 ff             	mov    %r15,%rdi
    7033:	4c 89 ee             	mov    %r13,%rsi
    7036:	e8 65 06 00 00       	call   76a0 <fwp_str_new>
    703b:	eb 8a                	jmp    6fc7 <fwp_decode+0x57>
    703d:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7042:	4c 89 ff             	mov    %r15,%rdi
    7045:	be 01 00 00 00       	mov    $0x1,%esi
    704a:	e8 f1 55 00 00       	call   c640 <rd_le>
    704f:	85 c0                	test   %eax,%eax
    7051:	0f 84 79 ff ff ff    	je     6fd0 <fwp_decode+0x60>
    7057:	48 0f be 44 24 08    	movsbq 0x8(%rsp),%rax
    705d:	e9 65 ff ff ff       	jmp    6fc7 <fwp_decode+0x57>
    7062:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7067:	4c 89 ff             	mov    %r15,%rdi
    706a:	be 08 00 00 00       	mov    $0x8,%esi
    706f:	e8 cc 55 00 00       	call   c640 <rd_le>
    7074:	45 31 f6             	xor    %r14d,%r14d
    7077:	85 c0                	test   %eax,%eax
    7079:	0f 84 51 ff ff ff    	je     6fd0 <fwp_decode+0x60>
    707f:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    7084:	4c 89 ff             	mov    %r15,%rdi
    7087:	be 08 00 00 00       	mov    $0x8,%esi
    708c:	e8 af 55 00 00       	call   c640 <rd_le>
    7091:	85 c0                	test   %eax,%eax
    7093:	0f 84 37 ff ff ff    	je     6fd0 <fwp_decode+0x60>
    7099:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    709e:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    70a3:	41 83 3c 24 04       	cmpl   $0x4,(%r12)
    70a8:	0f 85 d1 02 00 00    	jne    737f <fwp_decode+0x40f>
    70ae:	e8 9d 24 00 00       	call   9550 <fwp_box_i128>
    70b3:	e9 0f ff ff ff       	jmp    6fc7 <fwp_decode+0x57>
    70b8:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    70bd:	4c 89 ff             	mov    %r15,%rdi
    70c0:	e8 3b 56 00 00       	call   c700 <rd_leb>
    70c5:	85 c0                	test   %eax,%eax
    70c7:	0f 84 03 ff ff ff    	je     6fd0 <fwp_decode+0x60>
    70cd:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    70d2:	49 3b 6f 08          	cmp    0x8(%r15),%rbp
    70d6:	0f 87 f4 fe ff ff    	ja     6fd0 <fwp_decode+0x60>
    70dc:	4c 8d 35 4d dd 01 00 	lea    0x1dd4d(%rip),%r14        # 24e30 <fwp_empty_map>
    70e3:	48 85 ed             	test   %rbp,%rbp
    70e6:	0f 84 9d 02 00 00    	je     7389 <fwp_decode+0x419>
    70ec:	4c 8d 6c 24 18       	lea    0x18(%rsp),%r13
    70f1:	eb 20                	jmp    7113 <fwp_decode+0x1a3>
    70f3:	31 f6                	xor    %esi,%esi
    70f5:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    70fa:	49 8b 4c 24 38       	mov    0x38(%r12),%rcx
    70ff:	4c 89 f2             	mov    %r14,%rdx
    7102:	e8 89 1c 00 00       	call   8d90 <fwp_p_map_insert>
    7107:	49 89 c6             	mov    %rax,%r14
    710a:	48 ff cd             	dec    %rbp
    710d:	0f 84 76 02 00 00    	je     7389 <fwp_decode+0x419>
    7113:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
    711a:	00 00 
    711c:	49 8b 74 24 38       	mov    0x38(%r12),%rsi
    7121:	4c 89 ff             	mov    %r15,%rdi
    7124:	4c 89 ea             	mov    %r13,%rdx
    7127:	e8 44 fe ff ff       	call   6f70 <fwp_decode>
    712c:	85 c0                	test   %eax,%eax
    712e:	0f 84 69 02 00 00    	je     739d <fwp_decode+0x42d>
    7134:	41 83 3c 24 12       	cmpl   $0x12,(%r12)
    7139:	75 b8                	jne    70f3 <fwp_decode+0x183>
    713b:	49 8b 74 24 40       	mov    0x40(%r12),%rsi
    7140:	4c 89 ff             	mov    %r15,%rdi
    7143:	48 8d 54 24 30       	lea    0x30(%rsp),%rdx
    7148:	e8 23 fe ff ff       	call   6f70 <fwp_decode>
    714d:	85 c0                	test   %eax,%eax
    714f:	0f 84 48 02 00 00    	je     739d <fwp_decode+0x42d>
    7155:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    715a:	eb 99                	jmp    70f5 <fwp_decode+0x185>
    715c:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    7161:	4c 89 ff             	mov    %r15,%rdi
    7164:	e8 97 55 00 00       	call   c700 <rd_leb>
    7169:	85 c0                	test   %eax,%eax
    716b:	0f 84 5f fe ff ff    	je     6fd0 <fwp_decode+0x60>
    7171:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
    7176:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    717b:	49 3b 5f 08          	cmp    0x8(%r15),%rbx
    717f:	0f 87 4b fe ff ff    	ja     6fd0 <fwp_decode+0x60>
    7185:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    718c:	00 
    718d:	e8 9e c4 ff ff       	call   3630 <fwp_alloc>
    7192:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    7197:	48 85 db             	test   %rbx,%rbx
    719a:	74 35                	je     71d1 <fwp_decode+0x261>
    719c:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
    71a1:	49 89 dd             	mov    %rbx,%r13
    71a4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    71ab:	00 00 00 00 00 
    71b0:	49 8b 74 24 38       	mov    0x38(%r12),%rsi
    71b5:	4c 89 ff             	mov    %r15,%rdi
    71b8:	48 89 ea             	mov    %rbp,%rdx
    71bb:	e8 b0 fd ff ff       	call   6f70 <fwp_decode>
    71c0:	85 c0                	test   %eax,%eax
    71c2:	0f 84 08 fe ff ff    	je     6fd0 <fwp_decode+0x60>
    71c8:	48 83 c5 08          	add    $0x8,%rbp
    71cc:	49 ff cd             	dec    %r13
    71cf:	75 df                	jne    71b0 <fwp_decode+0x240>
    71d1:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    71d6:	48 89 de             	mov    %rbx,%rsi
    71d9:	e8 a2 02 00 00       	call   7480 <fwp_list_from>
    71de:	41 83 3c 24 11       	cmpl   $0x11,(%r12)
    71e3:	0f 85 b4 00 00 00    	jne    729d <fwp_decode+0x32d>
    71e9:	48 89 c7             	mov    %rax,%rdi
    71ec:	e8 4f 1a 00 00       	call   8c40 <fwp_p_array_from_list>
    71f1:	e9 a7 00 00 00       	jmp    729d <fwp_decode+0x32d>
    71f6:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    71fb:	4c 89 ff             	mov    %r15,%rdi
    71fe:	e8 fd 54 00 00       	call   c700 <rd_leb>
    7203:	85 c0                	test   %eax,%eax
    7205:	0f 84 c5 fd ff ff    	je     6fd0 <fwp_decode+0x60>
    720b:	4c 8b 6c 24 08       	mov    0x8(%rsp),%r13
    7210:	49 63 44 24 10       	movslq 0x10(%r12),%rax
    7215:	49 39 c5             	cmp    %rax,%r13
    7218:	0f 83 b2 fd ff ff    	jae    6fd0 <fwp_decode+0x60>
    721e:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
    7223:	49 8b 44 24 28       	mov    0x28(%r12),%rax
    7228:	4a 63 1c a8          	movslq (%rax,%r13,4),%rbx
    722c:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    7233:	00 
    7234:	e8 f7 c3 ff ff       	call   3630 <fwp_alloc>
    7239:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    723e:	89 d8                	mov    %ebx,%eax
    7240:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    7245:	48 85 db             	test   %rbx,%rbx
    7248:	7e 41                	jle    728b <fwp_decode+0x31b>
    724a:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    724f:	48 8d 2c c5 00 00 00 	lea    0x0(,%rax,8),%rbp
    7256:	00 
    7257:	45 31 f6             	xor    %r14d,%r14d
    725a:	31 db                	xor    %ebx,%ebx
    725c:	49 8b 44 24 30       	mov    0x30(%r12),%rax
    7261:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    7265:	48 8b 34 18          	mov    (%rax,%rbx,1),%rsi
    7269:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    726e:	48 8d 14 18          	lea    (%rax,%rbx,1),%rdx
    7272:	4c 89 ff             	mov    %r15,%rdi
    7275:	e8 f6 fc ff ff       	call   6f70 <fwp_decode>
    727a:	85 c0                	test   %eax,%eax
    727c:	0f 84 4e fd ff ff    	je     6fd0 <fwp_decode+0x60>
    7282:	48 83 c3 08          	add    $0x8,%rbx
    7286:	48 39 dd             	cmp    %rbx,%rbp
    7289:	75 d1                	jne    725c <fwp_decode+0x2ec>
    728b:	44 89 ef             	mov    %r13d,%edi
    728e:	48 8b 74 24 28       	mov    0x28(%rsp),%rsi
    7293:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
    7298:	e8 23 e4 ff ff       	call   56c0 <fwp_data>
    729d:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    72a2:	48 89 01             	mov    %rax,(%rcx)
    72a5:	e9 20 fd ff ff       	jmp    6fca <fwp_decode+0x5a>
    72aa:	be 01 00 00 00       	mov    $0x1,%esi
    72af:	e9 fd fc ff ff       	jmp    6fb1 <fwp_decode+0x41>
    72b4:	be 02 00 00 00       	mov    $0x2,%esi
    72b9:	e9 f3 fc ff ff       	jmp    6fb1 <fwp_decode+0x41>
    72be:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    72c3:	4c 89 ff             	mov    %r15,%rdi
    72c6:	be 02 00 00 00       	mov    $0x2,%esi
    72cb:	e8 70 53 00 00       	call   c640 <rd_le>
    72d0:	85 c0                	test   %eax,%eax
    72d2:	0f 84 f8 fc ff ff    	je     6fd0 <fwp_decode+0x60>
    72d8:	48 0f bf 44 24 08    	movswq 0x8(%rsp),%rax
    72de:	e9 e4 fc ff ff       	jmp    6fc7 <fwp_decode+0x57>
    72e3:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    72e8:	4c 89 ff             	mov    %r15,%rdi
    72eb:	be 04 00 00 00       	mov    $0x4,%esi
    72f0:	e8 4b 53 00 00       	call   c640 <rd_le>
    72f5:	85 c0                	test   %eax,%eax
    72f7:	0f 84 d3 fc ff ff    	je     6fd0 <fwp_decode+0x60>
    72fd:	48 63 44 24 08       	movslq 0x8(%rsp),%rax
    7302:	e9 c0 fc ff ff       	jmp    6fc7 <fwp_decode+0x57>
    7307:	be 04 00 00 00       	mov    $0x4,%esi
    730c:	e9 a0 fc ff ff       	jmp    6fb1 <fwp_decode+0x41>
    7311:	49 63 7c 24 10       	movslq 0x10(%r12),%rdi
    7316:	48 85 ff             	test   %rdi,%rdi
    7319:	74 76                	je     7391 <fwp_decode+0x421>
    731b:	48 c1 e7 03          	shl    $0x3,%rdi
    731f:	e8 0c c3 ff ff       	call   3630 <fwp_alloc>
    7324:	41 8b 7c 24 10       	mov    0x10(%r12),%edi
    7329:	85 ff                	test   %edi,%edi
    732b:	7e 45                	jle    7372 <fwp_decode+0x402>
    732d:	45 31 f6             	xor    %r14d,%r14d
    7330:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    7335:	48 89 c5             	mov    %rax,%rbp
    7338:	45 31 ed             	xor    %r13d,%r13d
    733b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7340:	49 8b 44 24 20       	mov    0x20(%r12),%rax
    7345:	4a 8b 34 e8          	mov    (%rax,%r13,8),%rsi
    7349:	4c 89 ff             	mov    %r15,%rdi
    734c:	48 89 ea             	mov    %rbp,%rdx
    734f:	e8 1c fc ff ff       	call   6f70 <fwp_decode>
    7354:	85 c0                	test   %eax,%eax
    7356:	0f 84 74 fc ff ff    	je     6fd0 <fwp_decode+0x60>
    735c:	49 ff c5             	inc    %r13
    735f:	49 63 7c 24 10       	movslq 0x10(%r12),%rdi
    7364:	48 83 c5 08          	add    $0x8,%rbp
    7368:	49 39 fd             	cmp    %rdi,%r13
    736b:	7c d3                	jl     7340 <fwp_decode+0x3d0>
    736d:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    7372:	48 89 c6             	mov    %rax,%rsi
    7375:	e8 b6 bf ff ff       	call   3330 <fwp_record>
    737a:	e9 48 fc ff ff       	jmp    6fc7 <fwp_decode+0x57>
    737f:	e8 7c 20 00 00       	call   9400 <fwp_box_u128>
    7384:	e9 3e fc ff ff       	jmp    6fc7 <fwp_decode+0x57>
    7389:	4c 89 33             	mov    %r14,(%rbx)
    738c:	e9 39 fc ff ff       	jmp    6fca <fwp_decode+0x5a>
    7391:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    7398:	e9 2d fc ff ff       	jmp    6fca <fwp_decode+0x5a>
    739d:	45 31 f6             	xor    %r14d,%r14d
    73a0:	e9 2b fc ff ff       	jmp    6fd0 <fwp_decode+0x60>
    73a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    73ac:	00 00 00 00 

00000000000073b0 <fwp_read_text_line>:
    73b0:	53                   	push   %rbx
    73b1:	48 89 fb             	mov    %rdi,%rbx
    73b4:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
    73bb:	00 
    73bc:	e8 ef 53 00 00       	call   c7b0 <fwp_getc>
    73c1:	83 f8 ff             	cmp    $0xffffffff,%eax
    73c4:	74 59                	je     741f <fwp_read_text_line+0x6f>
    73c6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    73cd:	00 00 00 
    73d0:	83 f8 0a             	cmp    $0xa,%eax
    73d3:	74 1a                	je     73ef <fwp_read_text_line+0x3f>
    73d5:	0f be f0             	movsbl %al,%esi
    73d8:	48 89 df             	mov    %rbx,%rdi
    73db:	e8 00 03 00 00       	call   76e0 <buf_putc>
    73e0:	e8 cb 53 00 00       	call   c7b0 <fwp_getc>
    73e5:	83 f8 ff             	cmp    $0xffffffff,%eax
    73e8:	75 e6                	jne    73d0 <fwp_read_text_line+0x20>
    73ea:	48 8b 03             	mov    (%rbx),%rax
    73ed:	eb 1c                	jmp    740b <fwp_read_text_line+0x5b>
    73ef:	48 8b 03             	mov    (%rbx),%rax
    73f2:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    73f6:	48 85 c9             	test   %rcx,%rcx
    73f9:	74 10                	je     740b <fwp_read_text_line+0x5b>
    73fb:	80 7c 08 ff 0d       	cmpb   $0xd,-0x1(%rax,%rcx,1)
    7400:	75 12                	jne    7414 <fwp_read_text_line+0x64>
    7402:	48 ff c9             	dec    %rcx
    7405:	48 89 4b 08          	mov    %rcx,0x8(%rbx)
    7409:	eb 05                	jmp    7410 <fwp_read_text_line+0x60>
    740b:	48 85 c0             	test   %rax,%rax
    740e:	74 08                	je     7418 <fwp_read_text_line+0x68>
    7410:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    7414:	c6 04 08 00          	movb   $0x0,(%rax,%rcx,1)
    7418:	b8 01 00 00 00       	mov    $0x1,%eax
    741d:	5b                   	pop    %rbx
    741e:	c3                   	ret
    741f:	31 c0                	xor    %eax,%eax
    7421:	5b                   	pop    %rbx
    7422:	c3                   	ret
    7423:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    742a:	84 00 00 00 00 00 

0000000000007430 <fwp_mem_realloc>:
    7430:	41 57                	push   %r15
    7432:	41 56                	push   %r14
    7434:	53                   	push   %rbx
    7435:	49 89 d6             	mov    %rdx,%r14
    7438:	49 89 f7             	mov    %rsi,%r15
    743b:	48 89 fb             	mov    %rdi,%rbx
    743e:	48 89 d7             	mov    %rdx,%rdi
    7441:	e8 ea c1 ff ff       	call   3630 <fwp_alloc>
    7446:	48 85 db             	test   %rbx,%rbx
    7449:	74 23                	je     746e <fwp_mem_realloc+0x3e>
    744b:	4d 39 f7             	cmp    %r14,%r15
    744e:	4d 0f 42 f7          	cmovb  %r15,%r14
    7452:	48 89 c7             	mov    %rax,%rdi
    7455:	48 89 de             	mov    %rbx,%rsi
    7458:	4c 89 f2             	mov    %r14,%rdx
    745b:	49 89 c6             	mov    %rax,%r14
    745e:	e8 bd ae ff ff       	call   2320 <memcpy@plt>
    7463:	48 89 df             	mov    %rbx,%rdi
    7466:	e8 95 df ff ff       	call   5400 <fwp_mem_free>
    746b:	4c 89 f0             	mov    %r14,%rax
    746e:	5b                   	pop    %rbx
    746f:	41 5e                	pop    %r14
    7471:	41 5f                	pop    %r15
    7473:	c3                   	ret
    7474:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    747b:	00 00 00 00 00 

0000000000007480 <fwp_list_from>:
    7480:	41 56                	push   %r14
    7482:	53                   	push   %rbx
    7483:	50                   	push   %rax
    7484:	48 89 fb             	mov    %rdi,%rbx
    7487:	48 85 f6             	test   %rsi,%rsi
    748a:	74 28                	je     74b4 <fwp_list_from+0x34>
    748c:	49 89 f6             	mov    %rsi,%r14
    748f:	31 c0                	xor    %eax,%eax
    7491:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7498:	0f 1f 84 00 00 00 00 
    749f:	00 
    74a0:	4a 8b 7c f3 f8       	mov    -0x8(%rbx,%r14,8),%rdi
    74a5:	48 89 c6             	mov    %rax,%rsi
    74a8:	e8 63 06 00 00       	call   7b10 <fwp_cons>
    74ad:	49 ff ce             	dec    %r14
    74b0:	75 ee                	jne    74a0 <fwp_list_from+0x20>
    74b2:	eb 02                	jmp    74b6 <fwp_list_from+0x36>
    74b4:	31 c0                	xor    %eax,%eax
    74b6:	48 83 c4 08          	add    $0x8,%rsp
    74ba:	5b                   	pop    %rbx
    74bb:	41 5e                	pop    %r14
    74bd:	c3                   	ret
    74be:	66 90                	xchg   %ax,%ax

00000000000074c0 <fwp_pipe_out_end>:
    74c0:	50                   	push   %rax
    74c1:	8b 05 79 d9 01 00    	mov    0x1d979(%rip),%eax        # 24e40 <fwp_po_kind>
    74c7:	83 f8 02             	cmp    $0x2,%eax
    74ca:	74 1c                	je     74e8 <fwp_pipe_out_end+0x28>
    74cc:	83 f8 01             	cmp    $0x1,%eax
    74cf:	75 3d                	jne    750e <fwp_pipe_out_end+0x4e>
    74d1:	e8 4a 2b 00 00       	call   a020 <fwp_po_flush_sock>
    74d6:	8b 3d dc d7 00 00    	mov    0xd7dc(%rip),%edi        # 14cb8 <fwp_po_sock>
    74dc:	be 01 00 00 00       	mov    $0x1,%esi
    74e1:	e8 6a ac ff ff       	call   2150 <shutdown@plt>
    74e6:	eb 35                	jmp    751d <fwp_pipe_out_end+0x5d>
    74e8:	48 8b 35 61 d9 02 00 	mov    0x2d961(%rip),%rsi        # 34e50 <fwp_po_ring>
    74ef:	c7 86 40 01 00 00 01 	movl   $0x1,0x140(%rsi)
    74f6:	00 00 00 
    74f9:	48 8d be c0 00 00 00 	lea    0xc0(%rsi),%rdi
    7500:	48 81 c6 c4 00 00 00 	add    $0xc4,%rsi
    7507:	e8 24 2d 00 00       	call   a230 <fwp_ring_wake>
    750c:	eb 0f                	jmp    751d <fwp_pipe_out_end+0x5d>
    750e:	48 8b 05 a3 ba 00 00 	mov    0xbaa3(%rip),%rax        # 12fb8 <stdout@GLIBC_2.2.5>
    7515:	48 8b 38             	mov    (%rax),%rdi
    7518:	e8 23 ae ff ff       	call   2340 <fflush@plt>
    751d:	8b 3d 91 d7 00 00    	mov    0xd791(%rip),%edi        # 14cb4 <fwp_po_listen>
    7523:	85 ff                	test   %edi,%edi
    7525:	78 0f                	js     7536 <fwp_pipe_out_end+0x76>
    7527:	e8 f4 ac ff ff       	call   2220 <close@plt>
    752c:	c7 05 7e d7 00 00 ff 	movl   $0xffffffff,0xd77e(%rip)        # 14cb4 <fwp_po_listen>
    7533:	ff ff ff 
    7536:	58                   	pop    %rax
    7537:	c3                   	ret
    7538:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    753f:	00 

0000000000007540 <fwp_valid_utf8>:
    7540:	48 85 f6             	test   %rsi,%rsi
    7543:	0f 84 48 01 00 00    	je     7691 <fwp_valid_utf8+0x151>
    7549:	53                   	push   %rbx
    754a:	31 c9                	xor    %ecx,%ecx
    754c:	eb 0e                	jmp    755c <fwp_valid_utf8+0x1c>
    754e:	66 90                	xchg   %ax,%ax
    7550:	48 ff c1             	inc    %rcx
    7553:	48 39 f1             	cmp    %rsi,%rcx
    7556:	0f 83 2e 01 00 00    	jae    768a <fwp_valid_utf8+0x14a>
    755c:	44 0f b6 14 0f       	movzbl (%rdi,%rcx,1),%r10d
    7561:	45 84 d2             	test   %r10b,%r10b
    7564:	79 ea                	jns    7550 <fwp_valid_utf8+0x10>
    7566:	41 8d 42 3e          	lea    0x3e(%r10),%eax
    756a:	3c 1e                	cmp    $0x1e,%al
    756c:	73 12                	jae    7580 <fwp_valid_utf8+0x40>
    756e:	ba 80 00 00 00       	mov    $0x80,%edx
    7573:	b8 01 00 00 00       	mov    $0x1,%eax
    7578:	41 b8 1f 00 00 00    	mov    $0x1f,%r8d
    757e:	eb 37                	jmp    75b7 <fwp_valid_utf8+0x77>
    7580:	44 89 d0             	mov    %r10d,%eax
    7583:	24 f0                	and    $0xf0,%al
    7585:	3c e0                	cmp    $0xe0,%al
    7587:	75 12                	jne    759b <fwp_valid_utf8+0x5b>
    7589:	ba 00 08 00 00       	mov    $0x800,%edx
    758e:	b8 02 00 00 00       	mov    $0x2,%eax
    7593:	41 b8 0f 00 00 00    	mov    $0xf,%r8d
    7599:	eb 1c                	jmp    75b7 <fwp_valid_utf8+0x77>
    759b:	41 8d 42 10          	lea    0x10(%r10),%eax
    759f:	3c 04                	cmp    $0x4,%al
    75a1:	0f 87 f0 00 00 00    	ja     7697 <fwp_valid_utf8+0x157>
    75a7:	ba 00 00 01 00       	mov    $0x10000,%edx
    75ac:	b8 03 00 00 00       	mov    $0x3,%eax
    75b1:	41 b8 07 00 00 00    	mov    $0x7,%r8d
    75b7:	41 89 c1             	mov    %eax,%r9d
    75ba:	4e 8d 1c 09          	lea    (%rcx,%r9,1),%r11
    75be:	31 c0                	xor    %eax,%eax
    75c0:	49 39 f3             	cmp    %rsi,%r11
    75c3:	0f 83 c6 00 00 00    	jae    768f <fwp_valid_utf8+0x14f>
    75c9:	44 0f b6 5c 0f 01    	movzbl 0x1(%rdi,%rcx,1),%r11d
    75cf:	44 89 db             	mov    %r11d,%ebx
    75d2:	83 e3 c0             	and    $0xffffffc0,%ebx
    75d5:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
    75db:	0f 85 ae 00 00 00    	jne    768f <fwp_valid_utf8+0x14f>
    75e1:	45 21 d0             	and    %r10d,%r8d
    75e4:	45 8d 51 01          	lea    0x1(%r9),%r10d
    75e8:	44 89 c3             	mov    %r8d,%ebx
    75eb:	c1 e3 06             	shl    $0x6,%ebx
    75ee:	41 83 e3 3f          	and    $0x3f,%r11d
    75f2:	41 09 db             	or     %ebx,%r11d
    75f5:	41 83 fa 02          	cmp    $0x2,%r10d
    75f9:	75 0d                	jne    7608 <fwp_valid_utf8+0xc8>
    75fb:	45 89 da             	mov    %r11d,%r10d
    75fe:	41 39 d2             	cmp    %edx,%r10d
    7601:	73 62                	jae    7665 <fwp_valid_utf8+0x125>
    7603:	e9 87 00 00 00       	jmp    768f <fwp_valid_utf8+0x14f>
    7608:	44 0f b6 44 0f 02    	movzbl 0x2(%rdi,%rcx,1),%r8d
    760e:	44 89 c3             	mov    %r8d,%ebx
    7611:	83 e3 c0             	and    $0xffffffc0,%ebx
    7614:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
    761a:	75 73                	jne    768f <fwp_valid_utf8+0x14f>
    761c:	44 89 db             	mov    %r11d,%ebx
    761f:	c1 e3 06             	shl    $0x6,%ebx
    7622:	41 83 e0 3f          	and    $0x3f,%r8d
    7626:	41 09 d8             	or     %ebx,%r8d
    7629:	41 83 fa 03          	cmp    $0x3,%r10d
    762d:	75 0d                	jne    763c <fwp_valid_utf8+0xfc>
    762f:	45 89 c2             	mov    %r8d,%r10d
    7632:	45 89 d8             	mov    %r11d,%r8d
    7635:	41 39 d2             	cmp    %edx,%r10d
    7638:	73 2b                	jae    7665 <fwp_valid_utf8+0x125>
    763a:	eb 53                	jmp    768f <fwp_valid_utf8+0x14f>
    763c:	44 0f b6 54 0f 03    	movzbl 0x3(%rdi,%rcx,1),%r10d
    7642:	45 89 d3             	mov    %r10d,%r11d
    7645:	41 83 e3 c0          	and    $0xffffffc0,%r11d
    7649:	41 81 fb 80 00 00 00 	cmp    $0x80,%r11d
    7650:	75 3d                	jne    768f <fwp_valid_utf8+0x14f>
    7652:	45 89 c3             	mov    %r8d,%r11d
    7655:	41 c1 e3 06          	shl    $0x6,%r11d
    7659:	41 83 e2 3f          	and    $0x3f,%r10d
    765d:	45 09 da             	or     %r11d,%r10d
    7660:	41 39 d2             	cmp    %edx,%r10d
    7663:	72 2a                	jb     768f <fwp_valid_utf8+0x14f>
    7665:	41 81 fa ff ff 10 00 	cmp    $0x10ffff,%r10d
    766c:	77 21                	ja     768f <fwp_valid_utf8+0x14f>
    766e:	41 83 e0 e0          	and    $0xffffffe0,%r8d
    7672:	41 81 f8 60 03 00 00 	cmp    $0x360,%r8d
    7679:	74 14                	je     768f <fwp_valid_utf8+0x14f>
    767b:	4c 01 c9             	add    %r9,%rcx
    767e:	48 ff c1             	inc    %rcx
    7681:	48 39 f1             	cmp    %rsi,%rcx
    7684:	0f 82 d2 fe ff ff    	jb     755c <fwp_valid_utf8+0x1c>
    768a:	b8 01 00 00 00       	mov    $0x1,%eax
    768f:	5b                   	pop    %rbx
    7690:	c3                   	ret
    7691:	b8 01 00 00 00       	mov    $0x1,%eax
    7696:	c3                   	ret
    7697:	31 c0                	xor    %eax,%eax
    7699:	5b                   	pop    %rbx
    769a:	c3                   	ret
    769b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000076a0 <fwp_str_new>:
    76a0:	41 57                	push   %r15
    76a2:	41 56                	push   %r14
    76a4:	53                   	push   %rbx
    76a5:	48 89 f3             	mov    %rsi,%rbx
    76a8:	49 89 fe             	mov    %rdi,%r14
    76ab:	48 8d 7e 09          	lea    0x9(%rsi),%rdi
    76af:	e8 2c ee ff ff       	call   64e0 <fwp_alloc_leaf>
    76b4:	49 89 c7             	mov    %rax,%r15
    76b7:	48 89 18             	mov    %rbx,(%rax)
    76ba:	48 8d 78 08          	lea    0x8(%rax),%rdi
    76be:	4c 89 f6             	mov    %r14,%rsi
    76c1:	48 89 da             	mov    %rbx,%rdx
    76c4:	e8 57 ac ff ff       	call   2320 <memcpy@plt>
    76c9:	41 c6 44 1f 08 00    	movb   $0x0,0x8(%r15,%rbx,1)
    76cf:	4c 89 f8             	mov    %r15,%rax
    76d2:	5b                   	pop    %rbx
    76d3:	41 5e                	pop    %r14
    76d5:	41 5f                	pop    %r15
    76d7:	c3                   	ret
    76d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    76df:	00 

00000000000076e0 <buf_putc>:
    76e0:	50                   	push   %rax
    76e1:	40 88 74 24 07       	mov    %sil,0x7(%rsp)
    76e6:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
    76eb:	ba 01 00 00 00       	mov    $0x1,%edx
    76f0:	e8 3b 00 00 00       	call   7730 <buf_put>
    76f5:	58                   	pop    %rax
    76f6:	c3                   	ret
    76f7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    76fe:	00 00 

0000000000007700 <buf_puts>:
    7700:	41 56                	push   %r14
    7702:	53                   	push   %rbx
    7703:	50                   	push   %rax
    7704:	48 89 f3             	mov    %rsi,%rbx
    7707:	49 89 fe             	mov    %rdi,%r14
    770a:	48 89 f7             	mov    %rsi,%rdi
    770d:	e8 4e aa ff ff       	call   2160 <strlen@plt>
    7712:	4c 89 f7             	mov    %r14,%rdi
    7715:	48 89 de             	mov    %rbx,%rsi
    7718:	48 89 c2             	mov    %rax,%rdx
    771b:	48 83 c4 08          	add    $0x8,%rsp
    771f:	5b                   	pop    %rbx
    7720:	41 5e                	pop    %r14
    7722:	eb 0c                	jmp    7730 <buf_put>
    7724:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    772b:	00 00 00 00 00 

0000000000007730 <buf_put>:
    7730:	41 57                	push   %r15
    7732:	41 56                	push   %r14
    7734:	53                   	push   %rbx
    7735:	48 89 d3             	mov    %rdx,%rbx
    7738:	49 89 f6             	mov    %rsi,%r14
    773b:	49 89 ff             	mov    %rdi,%r15
    773e:	48 89 d6             	mov    %rdx,%rsi
    7741:	e8 6a 00 00 00       	call   77b0 <buf_grow>
    7746:	49 8b 3f             	mov    (%r15),%rdi
    7749:	49 03 7f 08          	add    0x8(%r15),%rdi
    774d:	4c 89 f6             	mov    %r14,%rsi
    7750:	48 89 da             	mov    %rbx,%rdx
    7753:	e8 c8 ab ff ff       	call   2320 <memcpy@plt>
    7758:	49 03 5f 08          	add    0x8(%r15),%rbx
    775c:	49 89 5f 08          	mov    %rbx,0x8(%r15)
    7760:	49 8b 07             	mov    (%r15),%rax
    7763:	c6 04 18 00          	movb   $0x0,(%rax,%rbx,1)
    7767:	5b                   	pop    %rbx
    7768:	41 5e                	pop    %r14
    776a:	41 5f                	pop    %r15
    776c:	c3                   	ret
    776d:	0f 1f 00             	nopl   (%rax)

0000000000007770 <buf_to_str>:
    7770:	41 56                	push   %r14
    7772:	53                   	push   %rbx
    7773:	50                   	push   %rax
    7774:	48 89 fb             	mov    %rdi,%rbx
    7777:	48 8b 07             	mov    (%rdi),%rax
    777a:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    777e:	48 85 c0             	test   %rax,%rax
    7781:	48 8d 3d 20 69 00 00 	lea    0x6920(%rip),%rdi        # e0a8 <exec_in_fp0+0xa48>
    7788:	48 0f 45 f8          	cmovne %rax,%rdi
    778c:	e8 0f ff ff ff       	call   76a0 <fwp_str_new>
    7791:	49 89 c6             	mov    %rax,%r14
    7794:	48 8b 3b             	mov    (%rbx),%rdi
    7797:	e8 b4 a8 ff ff       	call   2050 <free@plt>
    779c:	4c 89 f0             	mov    %r14,%rax
    779f:	48 83 c4 08          	add    $0x8,%rsp
    77a3:	5b                   	pop    %rbx
    77a4:	41 5e                	pop    %r14
    77a6:	c3                   	ret
    77a7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    77ae:	00 00 

00000000000077b0 <buf_grow>:
    77b0:	41 56                	push   %r14
    77b2:	53                   	push   %rbx
    77b3:	50                   	push   %rax
    77b4:	48 8b 47 08          	mov    0x8(%rdi),%rax
    77b8:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    77bc:	74 73                	je     7831 <buf_grow+0x81>
    77be:	48 c7 c1 fe ff ff ff 	mov    $0xfffffffffffffffe,%rcx
    77c5:	48 29 c1             	sub    %rax,%rcx
    77c8:	48 39 f1             	cmp    %rsi,%rcx
    77cb:	72 64                	jb     7831 <buf_grow+0x81>
    77cd:	48 89 fb             	mov    %rdi,%rbx
    77d0:	48 01 f0             	add    %rsi,%rax
    77d3:	48 ff c0             	inc    %rax
    77d6:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    77da:	48 39 c8             	cmp    %rcx,%rax
    77dd:	76 4a                	jbe    7829 <buf_grow+0x79>
    77df:	48 85 c9             	test   %rcx,%rcx
    77e2:	41 be 40 00 00 00    	mov    $0x40,%r14d
    77e8:	4c 0f 45 f1          	cmovne %rcx,%r14
    77ec:	49 39 c6             	cmp    %rax,%r14
    77ef:	73 21                	jae    7812 <buf_grow+0x62>
    77f1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    77f8:	0f 1f 84 00 00 00 00 
    77ff:	00 
    7800:	4d 85 f6             	test   %r14,%r14
    7803:	78 0a                	js     780f <buf_grow+0x5f>
    7805:	4d 01 f6             	add    %r14,%r14
    7808:	49 39 c6             	cmp    %rax,%r14
    780b:	72 f3                	jb     7800 <buf_grow+0x50>
    780d:	eb 03                	jmp    7812 <buf_grow+0x62>
    780f:	49 89 c6             	mov    %rax,%r14
    7812:	48 8b 3b             	mov    (%rbx),%rdi
    7815:	4c 89 f6             	mov    %r14,%rsi
    7818:	e8 53 ab ff ff       	call   2370 <realloc@plt>
    781d:	48 85 c0             	test   %rax,%rax
    7820:	74 0f                	je     7831 <buf_grow+0x81>
    7822:	48 89 03             	mov    %rax,(%rbx)
    7825:	4c 89 73 10          	mov    %r14,0x10(%rbx)
    7829:	48 83 c4 08          	add    $0x8,%rsp
    782d:	5b                   	pop    %rbx
    782e:	41 5e                	pop    %r14
    7830:	c3                   	ret
    7831:	48 8b 05 a8 b7 00 00 	mov    0xb7a8(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    7838:	48 8b 08             	mov    (%rax),%rcx
    783b:	48 8d 3d 50 5f 00 00 	lea    0x5f50(%rip),%rdi        # d792 <exec_in_fp0+0x132>
    7842:	be 13 00 00 00       	mov    $0x13,%esi
    7847:	ba 01 00 00 00       	mov    $0x1,%edx
    784c:	e8 3f ac ff ff       	call   2490 <fwrite@plt>
    7851:	bf 66 00 00 00       	mov    $0x66,%edi
    7856:	e8 15 ac ff ff       	call   2470 <exit@plt>
    785b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000007860 <fwp_is_number_arg>:
    7860:	31 c0                	xor    %eax,%eax
    7862:	80 3f 2d             	cmpb   $0x2d,(%rdi)
    7865:	75 19                	jne    7880 <fwp_is_number_arg+0x20>
    7867:	0f b6 4f 01          	movzbl 0x1(%rdi),%ecx
    786b:	8d 51 d0             	lea    -0x30(%rcx),%edx
    786e:	b8 01 00 00 00       	mov    $0x1,%eax
    7873:	80 fa 0a             	cmp    $0xa,%dl
    7876:	72 08                	jb     7880 <fwp_is_number_arg+0x20>
    7878:	31 c0                	xor    %eax,%eax
    787a:	80 f9 2e             	cmp    $0x2e,%cl
    787d:	0f 94 c0             	sete   %al
    7880:	c3                   	ret
    7881:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7888:	0f 1f 84 00 00 00 00 
    788f:	00 

0000000000007890 <fwp_strf>:
    7890:	55                   	push   %rbp
    7891:	41 57                	push   %r15
    7893:	41 56                	push   %r14
    7895:	41 55                	push   %r13
    7897:	41 54                	push   %r12
    7899:	53                   	push   %rbx
    789a:	48 81 ec d8 00 00 00 	sub    $0xd8,%rsp
    78a1:	48 89 fb             	mov    %rdi,%rbx
    78a4:	48 89 74 24 28       	mov    %rsi,0x28(%rsp)
    78a9:	48 89 54 24 30       	mov    %rdx,0x30(%rsp)
    78ae:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
    78b3:	4c 89 44 24 40       	mov    %r8,0x40(%rsp)
    78b8:	4c 89 4c 24 48       	mov    %r9,0x48(%rsp)
    78bd:	84 c0                	test   %al,%al
    78bf:	74 37                	je     78f8 <fwp_strf+0x68>
    78c1:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
    78c6:	0f 29 4c 24 60       	movaps %xmm1,0x60(%rsp)
    78cb:	0f 29 54 24 70       	movaps %xmm2,0x70(%rsp)
    78d0:	0f 29 9c 24 80 00 00 	movaps %xmm3,0x80(%rsp)
    78d7:	00 
    78d8:	0f 29 a4 24 90 00 00 	movaps %xmm4,0x90(%rsp)
    78df:	00 
    78e0:	0f 29 ac 24 a0 00 00 	movaps %xmm5,0xa0(%rsp)
    78e7:	00 
    78e8:	0f 29 b4 24 b0 00 00 	movaps %xmm6,0xb0(%rsp)
    78ef:	00 
    78f0:	0f 29 bc 24 c0 00 00 	movaps %xmm7,0xc0(%rsp)
    78f7:	00 
    78f8:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    78fd:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    7902:	48 8d 84 24 10 01 00 	lea    0x110(%rsp),%rax
    7909:	00 
    790a:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    790f:	48 bd 08 00 00 00 30 	movabs $0x3000000008,%rbp
    7916:	00 00 00 
    7919:	48 89 2c 24          	mov    %rbp,(%rsp)
    791d:	49 89 e6             	mov    %rsp,%r14
    7920:	31 ff                	xor    %edi,%edi
    7922:	31 f6                	xor    %esi,%esi
    7924:	48 89 da             	mov    %rbx,%rdx
    7927:	4c 89 f1             	mov    %r14,%rcx
    792a:	e8 d1 a7 ff ff       	call   2100 <vsnprintf@plt>
    792f:	4c 63 f8             	movslq %eax,%r15
    7932:	4d 8d 67 01          	lea    0x1(%r15),%r12
    7936:	4c 89 e7             	mov    %r12,%rdi
    7939:	e8 a2 eb ff ff       	call   64e0 <fwp_alloc_leaf>
    793e:	49 89 c5             	mov    %rax,%r13
    7941:	48 89 2c 24          	mov    %rbp,(%rsp)
    7945:	48 8d 84 24 10 01 00 	lea    0x110(%rsp),%rax
    794c:	00 
    794d:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    7952:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    7957:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    795c:	4c 89 ef             	mov    %r13,%rdi
    795f:	4c 89 e6             	mov    %r12,%rsi
    7962:	48 89 da             	mov    %rbx,%rdx
    7965:	4c 89 f1             	mov    %r14,%rcx
    7968:	e8 93 a7 ff ff       	call   2100 <vsnprintf@plt>
    796d:	4c 89 ef             	mov    %r13,%rdi
    7970:	4c 89 fe             	mov    %r15,%rsi
    7973:	e8 28 fd ff ff       	call   76a0 <fwp_str_new>
    7978:	48 81 c4 d8 00 00 00 	add    $0xd8,%rsp
    797f:	5b                   	pop    %rbx
    7980:	41 5c                	pop    %r12
    7982:	41 5d                	pop    %r13
    7984:	41 5e                	pop    %r14
    7986:	41 5f                	pop    %r15
    7988:	5d                   	pop    %rbp
    7989:	c3                   	ret
    798a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000007990 <fwp_cli_value>:
    7990:	55                   	push   %rbp
    7991:	41 57                	push   %r15
    7993:	41 56                	push   %r14
    7995:	41 55                	push   %r13
    7997:	41 54                	push   %r12
    7999:	53                   	push   %rbx
    799a:	48 83 ec 58          	sub    $0x58,%rsp
    799e:	49 89 cf             	mov    %rcx,%r15
    79a1:	48 89 d3             	mov    %rdx,%rbx
    79a4:	49 89 f6             	mov    %rsi,%r14
    79a7:	49 89 fc             	mov    %rdi,%r12
    79aa:	e8 91 01 00 00       	call   7b40 <fwp_is_enum>
    79af:	85 c0                	test   %eax,%eax
    79b1:	0f 84 ef 00 00 00    	je     7aa6 <fwp_cli_value+0x116>
    79b7:	48 89 5c 24 38       	mov    %rbx,0x38(%rsp)
    79bc:	0f 57 c0             	xorps  %xmm0,%xmm0
    79bf:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    79c4:	48 c7 44 24 50 00 00 	movq   $0x0,0x50(%rsp)
    79cb:	00 00 
    79cd:	0f 29 04 24          	movaps %xmm0,(%rsp)
    79d1:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    79d8:	00 00 
    79da:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
    79df:	4c 89 e6             	mov    %r12,%rsi
    79e2:	4c 89 74 24 30       	mov    %r14,0x30(%rsp)
    79e7:	4c 89 f2             	mov    %r14,%rdx
    79ea:	e8 d1 01 00 00       	call   7bc0 <fwp_loose>
    79ef:	4c 8b 6c 24 40       	mov    0x40(%rsp),%r13
    79f4:	31 db                	xor    %ebx,%ebx
    79f6:	83 3d 3b d3 00 00 00 	cmpl   $0x0,0xd33b(%rip)        # 14d38 <d0+0x10>
    79fd:	41 be ff ff ff ff    	mov    $0xffffffff,%r14d
    7a03:	7e 7a                	jle    7a7f <fwp_cli_value+0xef>
    7a05:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
    7a0a:	48 85 ed             	test   %rbp,%rbp
    7a0d:	74 70                	je     7a7f <fwp_cli_value+0xef>
    7a0f:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
    7a14:	4c 89 7c 24 28       	mov    %r15,0x28(%rsp)
    7a19:	45 31 ff             	xor    %r15d,%r15d
    7a1c:	48 89 e3             	mov    %rsp,%rbx
    7a1f:	90                   	nop
    7a20:	48 8b 05 19 d3 00 00 	mov    0xd319(%rip),%rax        # 14d40 <d0+0x18>
    7a27:	4e 8b 24 f8          	mov    (%rax,%r15,8),%r12
    7a2b:	4c 89 e7             	mov    %r12,%rdi
    7a2e:	e8 2d a7 ff ff       	call   2160 <strlen@plt>
    7a33:	48 89 df             	mov    %rbx,%rdi
    7a36:	4c 89 e6             	mov    %r12,%rsi
    7a39:	48 89 c2             	mov    %rax,%rdx
    7a3c:	e8 7f 01 00 00       	call   7bc0 <fwp_loose>
    7a41:	48 39 6c 24 08       	cmp    %rbp,0x8(%rsp)
    7a46:	75 15                	jne    7a5d <fwp_cli_value+0xcd>
    7a48:	48 8b 3c 24          	mov    (%rsp),%rdi
    7a4c:	4c 89 ee             	mov    %r13,%rsi
    7a4f:	48 89 ea             	mov    %rbp,%rdx
    7a52:	e8 09 a9 ff ff       	call   2360 <bcmp@plt>
    7a57:	85 c0                	test   %eax,%eax
    7a59:	45 0f 44 f7          	cmove  %r15d,%r14d
    7a5d:	49 ff c7             	inc    %r15
    7a60:	48 63 05 d1 d2 00 00 	movslq 0xd2d1(%rip),%rax        # 14d38 <d0+0x10>
    7a67:	49 39 c7             	cmp    %rax,%r15
    7a6a:	7d 05                	jge    7a71 <fwp_cli_value+0xe1>
    7a6c:	45 85 f6             	test   %r14d,%r14d
    7a6f:	78 af                	js     7a20 <fwp_cli_value+0x90>
    7a71:	48 8b 1c 24          	mov    (%rsp),%rbx
    7a75:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
    7a7a:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
    7a7f:	4c 89 ef             	mov    %r13,%rdi
    7a82:	e8 c9 a5 ff ff       	call   2050 <free@plt>
    7a87:	48 89 df             	mov    %rbx,%rdi
    7a8a:	e8 c1 a5 ff ff       	call   2050 <free@plt>
    7a8f:	45 85 f6             	test   %r14d,%r14d
    7a92:	78 3e                	js     7ad2 <fwp_cli_value+0x142>
    7a94:	44 89 f0             	mov    %r14d,%eax
    7a97:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
    7a9c:	48 89 01             	mov    %rax,(%rcx)
    7a9f:	bb 01 00 00 00       	mov    $0x1,%ebx
    7aa4:	eb 50                	jmp    7af6 <fwp_cli_value+0x166>
    7aa6:	4c 89 e7             	mov    %r12,%rdi
    7aa9:	4c 89 f6             	mov    %r14,%rsi
    7aac:	48 89 da             	mov    %rbx,%rdx
    7aaf:	e8 dc eb ff ff       	call   6690 <fwp_parse_text>
    7ab4:	bb 01 00 00 00       	mov    $0x1,%ebx
    7ab9:	85 c0                	test   %eax,%eax
    7abb:	75 39                	jne    7af6 <fwp_cli_value+0x166>
    7abd:	48 8d 3d 9a 67 00 00 	lea    0x679a(%rip),%rdi        # e25e <exec_in_fp0+0xbfe>
    7ac4:	48 8d 0d e3 69 00 00 	lea    0x69e3(%rip),%rcx        # e4ae <exec_in_fp0+0xe4e>
    7acb:	31 db                	xor    %ebx,%ebx
    7acd:	44 89 f6             	mov    %r14d,%esi
    7ad0:	eb 17                	jmp    7ae9 <fwp_cli_value+0x159>
    7ad2:	e8 69 01 00 00       	call   7c40 <fwp_choices>
    7ad7:	48 8d 48 08          	lea    0x8(%rax),%rcx
    7adb:	48 8d 3d 64 67 00 00 	lea    0x6764(%rip),%rdi        # e246 <exec_in_fp0+0xbe6>
    7ae2:	31 db                	xor    %ebx,%ebx
    7ae4:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    7ae9:	4c 89 e2             	mov    %r12,%rdx
    7aec:	31 c0                	xor    %eax,%eax
    7aee:	e8 9d fd ff ff       	call   7890 <fwp_strf>
    7af3:	49 89 07             	mov    %rax,(%r15)
    7af6:	89 d8                	mov    %ebx,%eax
    7af8:	48 83 c4 58          	add    $0x58,%rsp
    7afc:	5b                   	pop    %rbx
    7afd:	41 5c                	pop    %r12
    7aff:	41 5d                	pop    %r13
    7b01:	41 5e                	pop    %r14
    7b03:	41 5f                	pop    %r15
    7b05:	5d                   	pop    %rbp
    7b06:	c3                   	ret
    7b07:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    7b0e:	00 00 

0000000000007b10 <fwp_cons>:
    7b10:	48 83 ec 18          	sub    $0x18,%rsp
    7b14:	48 89 3c 24          	mov    %rdi,(%rsp)
    7b18:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    7b1d:	48 89 e2             	mov    %rsp,%rdx
    7b20:	bf 01 00 00 00       	mov    $0x1,%edi
    7b25:	be 02 00 00 00       	mov    $0x2,%esi
    7b2a:	e8 91 db ff ff       	call   56c0 <fwp_data>
    7b2f:	48 83 c4 18          	add    $0x18,%rsp
    7b33:	c3                   	ret
    7b34:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    7b3b:	00 00 00 00 00 

0000000000007b40 <fwp_is_enum>:
    7b40:	31 c0                	xor    %eax,%eax
    7b42:	83 3d df d1 00 00 0e 	cmpl   $0xe,0xd1df(%rip)        # 14d28 <d0>
    7b49:	75 67                	jne    7bb2 <fwp_is_enum+0x72>
    7b4b:	53                   	push   %rbx
    7b4c:	8b 1d e6 d1 00 00    	mov    0xd1e6(%rip),%ebx        # 14d38 <d0+0x10>
    7b52:	85 db                	test   %ebx,%ebx
    7b54:	74 5b                	je     7bb1 <fwp_is_enum+0x71>
    7b56:	48 8b 3d d3 d1 00 00 	mov    0xd1d3(%rip),%rdi        # 14d30 <d0+0x8>
    7b5d:	48 85 ff             	test   %rdi,%rdi
    7b60:	74 14                	je     7b76 <fwp_is_enum+0x36>
    7b62:	48 8d 35 0f 67 00 00 	lea    0x670f(%rip),%rsi        # e278 <exec_in_fp0+0xc18>
    7b69:	e8 52 a7 ff ff       	call   22c0 <strcmp@plt>
    7b6e:	89 c1                	mov    %eax,%ecx
    7b70:	31 c0                	xor    %eax,%eax
    7b72:	85 c9                	test   %ecx,%ecx
    7b74:	74 3b                	je     7bb1 <fwp_is_enum+0x71>
    7b76:	85 db                	test   %ebx,%ebx
    7b78:	7e 32                	jle    7bac <fwp_is_enum+0x6c>
    7b7a:	48 8b 0d cf d1 00 00 	mov    0xd1cf(%rip),%rcx        # 14d50 <d0+0x28>
    7b81:	83 39 00             	cmpl   $0x0,(%rcx)
    7b84:	75 2b                	jne    7bb1 <fwp_is_enum+0x71>
    7b86:	b8 01 00 00 00       	mov    $0x1,%eax
    7b8b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7b90:	48 89 c2             	mov    %rax,%rdx
    7b93:	48 39 c3             	cmp    %rax,%rbx
    7b96:	74 0a                	je     7ba2 <fwp_is_enum+0x62>
    7b98:	48 8d 42 01          	lea    0x1(%rdx),%rax
    7b9c:	83 3c 91 00          	cmpl   $0x0,(%rcx,%rdx,4)
    7ba0:	74 ee                	je     7b90 <fwp_is_enum+0x50>
    7ba2:	31 c0                	xor    %eax,%eax
    7ba4:	48 39 da             	cmp    %rbx,%rdx
    7ba7:	0f 93 c0             	setae  %al
    7baa:	eb 05                	jmp    7bb1 <fwp_is_enum+0x71>
    7bac:	b8 01 00 00 00       	mov    $0x1,%eax
    7bb1:	5b                   	pop    %rbx
    7bb2:	c3                   	ret
    7bb3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7bba:	84 00 00 00 00 00 

0000000000007bc0 <fwp_loose>:
    7bc0:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
    7bc7:	00 
    7bc8:	48 85 d2             	test   %rdx,%rdx
    7bcb:	74 63                	je     7c30 <fwp_loose+0x70>
    7bcd:	41 57                	push   %r15
    7bcf:	41 56                	push   %r14
    7bd1:	41 54                	push   %r12
    7bd3:	53                   	push   %rbx
    7bd4:	50                   	push   %rax
    7bd5:	48 89 d3             	mov    %rdx,%rbx
    7bd8:	49 89 f6             	mov    %rsi,%r14
    7bdb:	49 89 ff             	mov    %rdi,%r15
    7bde:	45 31 e4             	xor    %r12d,%r12d
    7be1:	eb 15                	jmp    7bf8 <fwp_loose+0x38>
    7be3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7bea:	84 00 00 00 00 00 
    7bf0:	49 ff c4             	inc    %r12
    7bf3:	4c 39 e3             	cmp    %r12,%rbx
    7bf6:	74 2d                	je     7c25 <fwp_loose+0x65>
    7bf8:	43 0f b6 04 26       	movzbl (%r14,%r12,1),%eax
    7bfd:	83 f8 2d             	cmp    $0x2d,%eax
    7c00:	74 ee                	je     7bf0 <fwp_loose+0x30>
    7c02:	83 f8 5f             	cmp    $0x5f,%eax
    7c05:	74 e9                	je     7bf0 <fwp_loose+0x30>
    7c07:	8d 48 bf             	lea    -0x41(%rax),%ecx
    7c0a:	0f b6 d0             	movzbl %al,%edx
    7c0d:	0c 20                	or     $0x20,%al
    7c0f:	80 f9 1a             	cmp    $0x1a,%cl
    7c12:	0f b6 c0             	movzbl %al,%eax
    7c15:	0f 43 c2             	cmovae %edx,%eax
    7c18:	0f be f0             	movsbl %al,%esi
    7c1b:	4c 89 ff             	mov    %r15,%rdi
    7c1e:	e8 bd fa ff ff       	call   76e0 <buf_putc>
    7c23:	eb cb                	jmp    7bf0 <fwp_loose+0x30>
    7c25:	48 83 c4 08          	add    $0x8,%rsp
    7c29:	5b                   	pop    %rbx
    7c2a:	41 5c                	pop    %r12
    7c2c:	41 5e                	pop    %r14
    7c2e:	41 5f                	pop    %r15
    7c30:	c3                   	ret
    7c31:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7c38:	0f 1f 84 00 00 00 00 
    7c3f:	00 

0000000000007c40 <fwp_choices>:
    7c40:	41 57                	push   %r15
    7c42:	41 56                	push   %r14
    7c44:	53                   	push   %rbx
    7c45:	48 83 ec 20          	sub    $0x20,%rsp
    7c49:	0f 57 c0             	xorps  %xmm0,%xmm0
    7c4c:	0f 29 04 24          	movaps %xmm0,(%rsp)
    7c50:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    7c57:	00 00 
    7c59:	83 3d d8 d0 00 00 00 	cmpl   $0x0,0xd0d8(%rip)        # 14d38 <d0+0x10>
    7c60:	7e 5b                	jle    7cbd <fwp_choices+0x7d>
    7c62:	48 8b 05 d7 d0 00 00 	mov    0xd0d7(%rip),%rax        # 14d40 <d0+0x18>
    7c69:	48 8b 30             	mov    (%rax),%rsi
    7c6c:	48 89 e7             	mov    %rsp,%rdi
    7c6f:	e8 5c 00 00 00       	call   7cd0 <fwp_kebab>
    7c74:	83 3d bd d0 00 00 02 	cmpl   $0x2,0xd0bd(%rip)        # 14d38 <d0+0x10>
    7c7b:	7c 40                	jl     7cbd <fwp_choices+0x7d>
    7c7d:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    7c83:	48 8d 1d f3 65 00 00 	lea    0x65f3(%rip),%rbx        # e27d <exec_in_fp0+0xc1d>
    7c8a:	49 89 e6             	mov    %rsp,%r14
    7c8d:	0f 1f 00             	nopl   (%rax)
    7c90:	4c 89 f7             	mov    %r14,%rdi
    7c93:	48 89 de             	mov    %rbx,%rsi
    7c96:	e8 65 fa ff ff       	call   7700 <buf_puts>
    7c9b:	48 8b 05 9e d0 00 00 	mov    0xd09e(%rip),%rax        # 14d40 <d0+0x18>
    7ca2:	4a 8b 34 f8          	mov    (%rax,%r15,8),%rsi
    7ca6:	4c 89 f7             	mov    %r14,%rdi
    7ca9:	e8 22 00 00 00       	call   7cd0 <fwp_kebab>
    7cae:	49 ff c7             	inc    %r15
    7cb1:	48 63 05 80 d0 00 00 	movslq 0xd080(%rip),%rax        # 14d38 <d0+0x10>
    7cb8:	49 39 c7             	cmp    %rax,%r15
    7cbb:	7c d3                	jl     7c90 <fwp_choices+0x50>
    7cbd:	48 89 e7             	mov    %rsp,%rdi
    7cc0:	e8 ab fa ff ff       	call   7770 <buf_to_str>
    7cc5:	48 83 c4 20          	add    $0x20,%rsp
    7cc9:	5b                   	pop    %rbx
    7cca:	41 5e                	pop    %r14
    7ccc:	41 5f                	pop    %r15
    7cce:	c3                   	ret
    7ccf:	90                   	nop

0000000000007cd0 <fwp_kebab>:
    7cd0:	41 57                	push   %r15
    7cd2:	41 56                	push   %r14
    7cd4:	53                   	push   %rbx
    7cd5:	44 0f b6 3e          	movzbl (%rsi),%r15d
    7cd9:	45 84 ff             	test   %r15b,%r15b
    7cdc:	74 71                	je     7d4f <fwp_kebab+0x7f>
    7cde:	48 89 f3             	mov    %rsi,%rbx
    7ce1:	49 89 fe             	mov    %rdi,%r14
    7ce4:	48 ff c3             	inc    %rbx
    7ce7:	31 c0                	xor    %eax,%eax
    7ce9:	eb 36                	jmp    7d21 <fwp_kebab+0x51>
    7ceb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7cf0:	41 0f be f7          	movsbl %r15b,%esi
    7cf4:	4c 89 f7             	mov    %r14,%rdi
    7cf7:	e8 e4 f9 ff ff       	call   76e0 <buf_putc>
    7cfc:	41 8d 47 9f          	lea    -0x61(%r15),%eax
    7d00:	3c 1a                	cmp    $0x1a,%al
    7d02:	0f 92 c0             	setb   %al
    7d05:	41 80 c7 d0          	add    $0xd0,%r15b
    7d09:	41 80 ff 0a          	cmp    $0xa,%r15b
    7d0d:	0f 92 c1             	setb   %cl
    7d10:	08 c1                	or     %al,%cl
    7d12:	0f b6 c1             	movzbl %cl,%eax
    7d15:	44 0f b6 3b          	movzbl (%rbx),%r15d
    7d19:	48 ff c3             	inc    %rbx
    7d1c:	45 84 ff             	test   %r15b,%r15b
    7d1f:	74 2e                	je     7d4f <fwp_kebab+0x7f>
    7d21:	41 8d 4f bf          	lea    -0x41(%r15),%ecx
    7d25:	80 f9 19             	cmp    $0x19,%cl
    7d28:	77 c6                	ja     7cf0 <fwp_kebab+0x20>
    7d2a:	85 c0                	test   %eax,%eax
    7d2c:	74 0d                	je     7d3b <fwp_kebab+0x6b>
    7d2e:	4c 89 f7             	mov    %r14,%rdi
    7d31:	be 2d 00 00 00       	mov    $0x2d,%esi
    7d36:	e8 a5 f9 ff ff       	call   76e0 <buf_putc>
    7d3b:	41 80 cf 20          	or     $0x20,%r15b
    7d3f:	41 0f be f7          	movsbl %r15b,%esi
    7d43:	4c 89 f7             	mov    %r14,%rdi
    7d46:	e8 95 f9 ff ff       	call   76e0 <buf_putc>
    7d4b:	31 c0                	xor    %eax,%eax
    7d4d:	eb c6                	jmp    7d15 <fwp_kebab+0x45>
    7d4f:	5b                   	pop    %rbx
    7d50:	41 5e                	pop    %r14
    7d52:	41 5f                	pop    %r15
    7d54:	c3                   	ret
    7d55:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    7d5c:	00 00 00 00 

0000000000007d60 <tp_value>:
    7d60:	55                   	push   %rbp
    7d61:	41 57                	push   %r15
    7d63:	41 56                	push   %r14
    7d65:	41 55                	push   %r13
    7d67:	41 54                	push   %r12
    7d69:	53                   	push   %rbx
    7d6a:	48 81 ec a8 01 00 00 	sub    $0x1a8,%rsp
    7d71:	48 89 cd             	mov    %rcx,%rbp
    7d74:	49 89 f6             	mov    %rsi,%r14
    7d77:	49 89 ff             	mov    %rdi,%r15
    7d7a:	85 d2                	test   %edx,%edx
    7d7c:	74 4c                	je     7dca <tp_value+0x6a>
    7d7e:	41 83 3e 0c          	cmpl   $0xc,(%r14)
    7d82:	75 46                	jne    7dca <tp_value+0x6a>
    7d84:	4d 8b 77 08          	mov    0x8(%r15),%r14
    7d88:	49 8b 47 10          	mov    0x10(%r15),%rax
    7d8c:	4d 8b 27             	mov    (%r15),%r12
    7d8f:	49 01 c4             	add    %rax,%r12
    7d92:	49 29 c6             	sub    %rax,%r14
    7d95:	4c 89 e7             	mov    %r12,%rdi
    7d98:	4c 89 f6             	mov    %r14,%rsi
    7d9b:	e8 a0 f7 ff ff       	call   7540 <fwp_valid_utf8>
    7da0:	85 c0                	test   %eax,%eax
    7da2:	0f 84 e9 07 00 00    	je     8591 <tp_value+0x831>
    7da8:	4c 89 e7             	mov    %r12,%rdi
    7dab:	4c 89 f6             	mov    %r14,%rsi
    7dae:	e8 ed f8 ff ff       	call   76a0 <fwp_str_new>
    7db3:	48 89 45 00          	mov    %rax,0x0(%rbp)
    7db7:	49 8b 47 08          	mov    0x8(%r15),%rax
    7dbb:	49 89 47 10          	mov    %rax,0x10(%r15)
    7dbf:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    7dc5:	e9 ca 07 00 00       	jmp    8594 <tp_value+0x834>
    7dca:	41 89 d5             	mov    %edx,%r13d
    7dcd:	4c 89 ff             	mov    %r15,%rdi
    7dd0:	e8 bb 08 00 00       	call   8690 <tp_ws>
    7dd5:	41 8b 06             	mov    (%r14),%eax
    7dd8:	45 31 e4             	xor    %r12d,%r12d
    7ddb:	48 83 f8 15          	cmp    $0x15,%rax
    7ddf:	0f 87 af 07 00 00    	ja     8594 <tp_value+0x834>
    7de5:	48 8d 0d fc 53 00 00 	lea    0x53fc(%rip),%rcx        # d1e8 <_IO_stdin_used+0x1e8>
    7dec:	48 63 14 81          	movslq (%rcx,%rax,4),%rdx
    7df0:	48 01 ca             	add    %rcx,%rdx
    7df3:	ff e2                	jmp    *%rdx
    7df5:	4c 89 ff             	mov    %r15,%rdi
    7df8:	4c 89 f6             	mov    %r14,%rsi
    7dfb:	48 89 ea             	mov    %rbp,%rdx
    7dfe:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    7e05:	5b                   	pop    %rbx
    7e06:	41 5c                	pop    %r12
    7e08:	41 5d                	pop    %r13
    7e0a:	41 5e                	pop    %r14
    7e0c:	41 5f                	pop    %r15
    7e0e:	5d                   	pop    %rbp
    7e0f:	e9 cc 08 00 00       	jmp    86e0 <tp_int>
    7e14:	41 0f 10 46 38       	movups 0x38(%r14),%xmm0
    7e19:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    7e1e:	31 c9                	xor    %ecx,%ecx
    7e20:	83 f8 13             	cmp    $0x13,%eax
    7e23:	0f 94 c1             	sete   %cl
    7e26:	0f 57 c0             	xorps  %xmm0,%xmm0
    7e29:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    7e2e:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    7e35:	00 00 
    7e37:	89 4c 24 48          	mov    %ecx,0x48(%rsp)
    7e3b:	48 8d 05 50 64 00 00 	lea    0x6450(%rip),%rax        # e292 <exec_in_fp0+0xc32>
    7e42:	48 8d 35 4d 64 00 00 	lea    0x644d(%rip),%rsi        # e296 <exec_in_fp0+0xc36>
    7e49:	48 0f 44 f0          	cmove  %rax,%rsi
    7e4d:	4c 89 ff             	mov    %r15,%rdi
    7e50:	e8 fb 0b 00 00       	call   8a50 <tp_eat>
    7e55:	45 31 e4             	xor    %r12d,%r12d
    7e58:	85 c0                	test   %eax,%eax
    7e5a:	0f 84 34 07 00 00    	je     8594 <tp_value+0x834>
    7e60:	48 8d 35 05 65 00 00 	lea    0x6505(%rip),%rsi        # e36c <exec_in_fp0+0xd0c>
    7e67:	48 8d 15 32 65 00 00 	lea    0x6532(%rip),%rdx        # e3a0 <exec_in_fp0+0xd40>
    7e6e:	48 8d 0d 7b 0e 00 00 	lea    0xe7b(%rip),%rcx        # 8cf0 <tp_kv_item>
    7e75:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
    7e7a:	4c 89 ff             	mov    %r15,%rdi
    7e7d:	e8 2e 0c 00 00       	call   8ab0 <tp_list_of>
    7e82:	85 c0                	test   %eax,%eax
    7e84:	0f 84 a1 03 00 00    	je     822b <tp_value+0x4cb>
    7e8a:	48 83 7c 24 38 00    	cmpq   $0x0,0x38(%rsp)
    7e90:	0f 84 2b 05 00 00    	je     83c1 <tp_value+0x661>
    7e96:	48 8d 05 93 cf 01 00 	lea    0x1cf93(%rip),%rax        # 24e30 <fwp_empty_map>
    7e9d:	31 db                	xor    %ebx,%ebx
    7e9f:	90                   	nop
    7ea0:	48 8b 4c 24 30       	mov    0x30(%rsp),%rcx
    7ea5:	48 8b 3c d9          	mov    (%rcx,%rbx,8),%rdi
    7ea9:	48 8b 74 d9 08       	mov    0x8(%rcx,%rbx,8),%rsi
    7eae:	49 8b 4e 38          	mov    0x38(%r14),%rcx
    7eb2:	48 89 c2             	mov    %rax,%rdx
    7eb5:	e8 d6 0e 00 00       	call   8d90 <fwp_p_map_insert>
    7eba:	48 83 c3 02          	add    $0x2,%rbx
    7ebe:	48 3b 5c 24 38       	cmp    0x38(%rsp),%rbx
    7ec3:	72 db                	jb     7ea0 <tp_value+0x140>
    7ec5:	e9 fe 04 00 00       	jmp    83c8 <tp_value+0x668>
    7eca:	0f 57 c0             	xorps  %xmm0,%xmm0
    7ecd:	0f 11 44 24 38       	movups %xmm0,0x38(%rsp)
    7ed2:	0f 11 44 24 28       	movups %xmm0,0x28(%rsp)
    7ed7:	48 c7 44 24 48 00 00 	movq   $0x0,0x48(%rsp)
    7ede:	00 00 
    7ee0:	49 8b 4e 38          	mov    0x38(%r14),%rcx
    7ee4:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
    7ee9:	83 f8 11             	cmp    $0x11,%eax
    7eec:	75 17                	jne    7f05 <tp_value+0x1a5>
    7eee:	48 8d 35 97 63 00 00 	lea    0x6397(%rip),%rsi        # e28c <exec_in_fp0+0xc2c>
    7ef5:	4c 89 ff             	mov    %r15,%rdi
    7ef8:	e8 53 0b 00 00       	call   8a50 <tp_eat>
    7efd:	85 c0                	test   %eax,%eax
    7eff:	0f 84 8c 06 00 00    	je     8591 <tp_value+0x831>
    7f05:	48 8d 35 4c 64 00 00 	lea    0x644c(%rip),%rsi        # e358 <exec_in_fp0+0xcf8>
    7f0c:	48 8d 15 c8 57 00 00 	lea    0x57c8(%rip),%rdx        # d6db <exec_in_fp0+0x7b>
    7f13:	48 8d 0d e6 0c 00 00 	lea    0xce6(%rip),%rcx        # 8c00 <tp_elem_item>
    7f1a:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
    7f1f:	4c 89 ff             	mov    %r15,%rdi
    7f22:	e8 89 0b 00 00       	call   8ab0 <tp_list_of>
    7f27:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    7f2c:	85 c0                	test   %eax,%eax
    7f2e:	0f 84 06 03 00 00    	je     823a <tp_value+0x4da>
    7f34:	48 8b 74 24 38       	mov    0x38(%rsp),%rsi
    7f39:	e8 42 f5 ff ff       	call   7480 <fwp_list_from>
    7f3e:	49 89 c7             	mov    %rax,%r15
    7f41:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    7f46:	e8 b5 d4 ff ff       	call   5400 <fwp_mem_free>
    7f4b:	41 83 3e 11          	cmpl   $0x11,(%r14)
    7f4f:	75 0b                	jne    7f5c <tp_value+0x1fc>
    7f51:	4c 89 ff             	mov    %r15,%rdi
    7f54:	e8 e7 0c 00 00       	call   8c40 <fwp_p_array_from_list>
    7f59:	49 89 c7             	mov    %rax,%r15
    7f5c:	4c 89 7d 00          	mov    %r15,0x0(%rbp)
    7f60:	e9 5a fe ff ff       	jmp    7dbf <tp_value+0x5f>
    7f65:	4c 89 ff             	mov    %r15,%rdi
    7f68:	4c 89 f6             	mov    %r14,%rsi
    7f6b:	48 89 ea             	mov    %rbp,%rdx
    7f6e:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    7f75:	5b                   	pop    %rbx
    7f76:	41 5c                	pop    %r12
    7f78:	41 5d                	pop    %r13
    7f7a:	41 5e                	pop    %r14
    7f7c:	41 5f                	pop    %r15
    7f7e:	5d                   	pop    %rbp
    7f7f:	e9 bc 07 00 00       	jmp    8740 <tp_float>
    7f84:	45 85 ed             	test   %r13d,%r13d
    7f87:	0f 85 f7 fd ff ff    	jne    7d84 <tp_value+0x24>
    7f8d:	4c 89 ff             	mov    %r15,%rdi
    7f90:	48 89 ee             	mov    %rbp,%rsi
    7f93:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    7f9a:	5b                   	pop    %rbx
    7f9b:	41 5c                	pop    %r12
    7f9d:	41 5d                	pop    %r13
    7f9f:	41 5e                	pop    %r14
    7fa1:	41 5f                	pop    %r15
    7fa3:	5d                   	pop    %rbp
    7fa4:	e9 57 08 00 00       	jmp    8800 <tp_quoted>
    7fa9:	0f 57 c0             	xorps  %xmm0,%xmm0
    7fac:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    7fb1:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    7fb6:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    7fbb:	48 8d 35 be 62 00 00 	lea    0x62be(%rip),%rsi        # e280 <exec_in_fp0+0xc20>
    7fc2:	4c 89 ff             	mov    %r15,%rdi
    7fc5:	e8 86 0a 00 00       	call   8a50 <tp_eat>
    7fca:	45 31 e4             	xor    %r12d,%r12d
    7fcd:	85 c0                	test   %eax,%eax
    7fcf:	0f 84 6f 02 00 00    	je     8244 <tp_value+0x4e4>
    7fd5:	48 8d 35 7c 63 00 00 	lea    0x637c(%rip),%rsi        # e358 <exec_in_fp0+0xcf8>
    7fdc:	48 8d 15 f8 56 00 00 	lea    0x56f8(%rip),%rdx        # d6db <exec_in_fp0+0x7b>
    7fe3:	48 8d 0d 46 0b 00 00 	lea    0xb46(%rip),%rcx        # 8b30 <tp_byte_item>
    7fea:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
    7fef:	4c 89 ff             	mov    %r15,%rdi
    7ff2:	e8 b9 0a 00 00       	call   8ab0 <tp_list_of>
    7ff7:	85 c0                	test   %eax,%eax
    7ff9:	0f 84 2c 02 00 00    	je     822b <tp_value+0x4cb>
    7fff:	0f 57 c0             	xorps  %xmm0,%xmm0
    8002:	0f 29 84 24 20 01 00 	movaps %xmm0,0x120(%rsp)
    8009:	00 
    800a:	48 c7 84 24 30 01 00 	movq   $0x0,0x130(%rsp)
    8011:	00 00 00 00 00 
    8016:	48 83 7c 24 38 00    	cmpq   $0x0,0x38(%rsp)
    801c:	74 2d                	je     804b <tp_value+0x2eb>
    801e:	31 db                	xor    %ebx,%ebx
    8020:	4c 8d b4 24 20 01 00 	lea    0x120(%rsp),%r14
    8027:	00 
    8028:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    802f:	00 
    8030:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    8035:	0f be 34 d8          	movsbl (%rax,%rbx,8),%esi
    8039:	4c 89 f7             	mov    %r14,%rdi
    803c:	e8 9f f6 ff ff       	call   76e0 <buf_putc>
    8041:	48 ff c3             	inc    %rbx
    8044:	48 3b 5c 24 38       	cmp    0x38(%rsp),%rbx
    8049:	72 e5                	jb     8030 <tp_value+0x2d0>
    804b:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    8050:	e8 ab d3 ff ff       	call   5400 <fwp_mem_free>
    8055:	48 8d bc 24 20 01 00 	lea    0x120(%rsp),%rdi
    805c:	00 
    805d:	e8 0e f7 ff ff       	call   7770 <buf_to_str>
    8062:	48 89 45 00          	mov    %rax,0x0(%rbp)
    8066:	e9 54 fd ff ff       	jmp    7dbf <tp_value+0x5f>
    806b:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8070:	ba 00 01 00 00       	mov    $0x100,%edx
    8075:	4c 89 ff             	mov    %r15,%rdi
    8078:	e8 f3 0a 00 00       	call   8b70 <tp_token>
    807d:	45 31 e4             	xor    %r12d,%r12d
    8080:	48 83 f8 02          	cmp    $0x2,%rax
    8084:	0f 82 0a 05 00 00    	jb     8594 <tp_value+0x834>
    808a:	80 7c 24 20 30       	cmpb   $0x30,0x20(%rsp)
    808f:	0f 85 ff 04 00 00    	jne    8594 <tp_value+0x834>
    8095:	80 7c 24 21 74       	cmpb   $0x74,0x21(%rsp)
    809a:	0f 85 f4 04 00 00    	jne    8594 <tp_value+0x834>
    80a0:	48 8d 48 fe          	lea    -0x2(%rax),%rcx
    80a4:	49 63 56 48          	movslq 0x48(%r14),%rdx
    80a8:	48 39 d1             	cmp    %rdx,%rcx
    80ab:	0f 87 e3 04 00 00    	ja     8594 <tp_value+0x834>
    80b1:	48 83 f8 03          	cmp    $0x3,%rax
    80b5:	0f 82 21 05 00 00    	jb     85dc <tp_value+0x87c>
    80bb:	ba 02 00 00 00       	mov    $0x2,%edx
    80c0:	31 c9                	xor    %ecx,%ecx
    80c2:	e9 3d 01 00 00       	jmp    8204 <tp_value+0x4a4>
    80c7:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    80cc:	ba 10 00 00 00       	mov    $0x10,%edx
    80d1:	4c 89 ff             	mov    %r15,%rdi
    80d4:	e8 97 0a 00 00       	call   8b70 <tp_token>
    80d9:	8b 44 24 20          	mov    0x20(%rsp),%eax
    80dd:	89 c1                	mov    %eax,%ecx
    80df:	81 f1 2b 31 00 00    	xor    $0x312b,%ecx
    80e5:	0f b6 54 24 22       	movzbl 0x22(%rsp),%edx
    80ea:	66 09 ca             	or     %cx,%dx
    80ed:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    80f3:	74 2d                	je     8122 <tp_value+0x3c2>
    80f5:	66 83 f8 31          	cmp    $0x31,%ax
    80f9:	74 27                	je     8122 <tp_value+0x3c2>
    80fb:	45 31 e4             	xor    %r12d,%r12d
    80fe:	66 83 f8 30          	cmp    $0x30,%ax
    8102:	74 1e                	je     8122 <tp_value+0x3c2>
    8104:	b8 2d 31 00 00       	mov    $0x312d,%eax
    8109:	33 44 24 20          	xor    0x20(%rsp),%eax
    810d:	0f b6 4c 24 22       	movzbl 0x22(%rsp),%ecx
    8112:	66 09 c1             	or     %ax,%cx
    8115:	0f 85 79 04 00 00    	jne    8594 <tp_value+0x834>
    811b:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    8122:	4c 89 65 00          	mov    %r12,0x0(%rbp)
    8126:	e9 94 fc ff ff       	jmp    7dbf <tp_value+0x5f>
    812b:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    812f:	48 85 ff             	test   %rdi,%rdi
    8132:	0f 84 18 01 00 00    	je     8250 <tp_value+0x4f0>
    8138:	48 8d 35 5b 61 00 00 	lea    0x615b(%rip),%rsi        # e29a <exec_in_fp0+0xc3a>
    813f:	e8 7c a1 ff ff       	call   22c0 <strcmp@plt>
    8144:	85 c0                	test   %eax,%eax
    8146:	0f 84 23 03 00 00    	je     846f <tp_value+0x70f>
    814c:	4c 89 ff             	mov    %r15,%rdi
    814f:	e8 3c 05 00 00       	call   8690 <tp_ws>
    8154:	4d 8b 6e 08          	mov    0x8(%r14),%r13
    8158:	4c 89 ef             	mov    %r13,%rdi
    815b:	e8 00 a0 ff ff       	call   2160 <strlen@plt>
    8160:	49 89 c4             	mov    %rax,%r12
    8163:	49 8b 47 08          	mov    0x8(%r15),%rax
    8167:	49 8b 5f 10          	mov    0x10(%r15),%rbx
    816b:	48 29 d8             	sub    %rbx,%rax
    816e:	4c 39 e0             	cmp    %r12,%rax
    8171:	0f 82 c4 01 00 00    	jb     833b <tp_value+0x5db>
    8177:	49 8b 3f             	mov    (%r15),%rdi
    817a:	48 01 df             	add    %rbx,%rdi
    817d:	4c 89 ee             	mov    %r13,%rsi
    8180:	4c 89 e2             	mov    %r12,%rdx
    8183:	e8 d8 a1 ff ff       	call   2360 <bcmp@plt>
    8188:	85 c0                	test   %eax,%eax
    818a:	0f 85 ab 01 00 00    	jne    833b <tp_value+0x5db>
    8190:	4c 01 e3             	add    %r12,%rbx
    8193:	49 89 5f 10          	mov    %rbx,0x10(%r15)
    8197:	e9 9f 01 00 00       	jmp    833b <tp_value+0x5db>
    819c:	48 89 2c 24          	mov    %rbp,(%rsp)
    81a0:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    81a5:	4c 89 ff             	mov    %r15,%rdi
    81a8:	e8 d3 0e 00 00       	call   9080 <tp_ident>
    81ad:	41 8b 5e 10          	mov    0x10(%r14),%ebx
    81b1:	85 db                	test   %ebx,%ebx
    81b3:	4c 89 74 24 08       	mov    %r14,0x8(%rsp)
    81b8:	0f 8e 9c 01 00 00    	jle    835a <tp_value+0x5fa>
    81be:	4d 8b 66 18          	mov    0x18(%r14),%r12
    81c2:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    81c7:	45 31 f6             	xor    %r14d,%r14d
    81ca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    81d0:	4b 8b 3c f4          	mov    (%r12,%r14,8),%rdi
    81d4:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    81d9:	e8 e2 a0 ff ff       	call   22c0 <strcmp@plt>
    81de:	85 c0                	test   %eax,%eax
    81e0:	41 0f 44 ee          	cmove  %r14d,%ebp
    81e4:	49 ff c6             	inc    %r14
    81e7:	4c 39 f3             	cmp    %r14,%rbx
    81ea:	75 e4                	jne    81d0 <tp_value+0x470>
    81ec:	e9 6e 01 00 00       	jmp    835f <tp_value+0x5ff>
    81f1:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    81f5:	48 ff c9             	dec    %rcx
    81f8:	48 ff c2             	inc    %rdx
    81fb:	48 39 d0             	cmp    %rdx,%rax
    81fe:	0f 84 da 03 00 00    	je     85de <tp_value+0x87e>
    8204:	0f b6 74 14 20       	movzbl 0x20(%rsp,%rdx,1),%esi
    8209:	83 fe 30             	cmp    $0x30,%esi
    820c:	74 17                	je     8225 <tp_value+0x4c5>
    820e:	83 fe 2d             	cmp    $0x2d,%esi
    8211:	74 de                	je     81f1 <tp_value+0x491>
    8213:	83 fe 2b             	cmp    $0x2b,%esi
    8216:	0f 85 75 03 00 00    	jne    8591 <tp_value+0x831>
    821c:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    8220:	48 ff c1             	inc    %rcx
    8223:	eb d3                	jmp    81f8 <tp_value+0x498>
    8225:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    8229:	eb cd                	jmp    81f8 <tp_value+0x498>
    822b:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    8230:	e8 cb d1 ff ff       	call   5400 <fwp_mem_free>
    8235:	e9 5a 03 00 00       	jmp    8594 <tp_value+0x834>
    823a:	e8 c1 d1 ff ff       	call   5400 <fwp_mem_free>
    823f:	e9 4d 03 00 00       	jmp    8591 <tp_value+0x831>
    8244:	31 ff                	xor    %edi,%edi
    8246:	e8 b5 d1 ff ff       	call   5400 <fwp_mem_free>
    824b:	e9 44 03 00 00       	jmp    8594 <tp_value+0x834>
    8250:	49 63 7e 10          	movslq 0x10(%r14),%rdi
    8254:	48 85 ff             	test   %rdi,%rdi
    8257:	0f 84 4c 03 00 00    	je     85a9 <tp_value+0x849>
    825d:	41 83 7e 48 00       	cmpl   $0x0,0x48(%r14)
    8262:	0f 84 d3 00 00 00    	je     833b <tp_value+0x5db>
    8268:	48 c1 e7 03          	shl    $0x3,%rdi
    826c:	e8 bf b3 ff ff       	call   3630 <fwp_alloc>
    8271:	48 89 c3             	mov    %rax,%rbx
    8274:	48 8d 35 2f 60 00 00 	lea    0x602f(%rip),%rsi        # e2aa <exec_in_fp0+0xc4a>
    827b:	4c 89 ff             	mov    %r15,%rdi
    827e:	e8 cd 07 00 00       	call   8a50 <tp_eat>
    8283:	85 c0                	test   %eax,%eax
    8285:	0f 84 09 03 00 00    	je     8594 <tp_value+0x834>
    828b:	48 89 2c 24          	mov    %rbp,(%rsp)
    828f:	41 83 7e 10 00       	cmpl   $0x0,0x10(%r14)
    8294:	7e 77                	jle    830d <tp_value+0x5ad>
    8296:	49 8b 46 20          	mov    0x20(%r14),%rax
    829a:	48 8b 30             	mov    (%rax),%rsi
    829d:	4c 89 ff             	mov    %r15,%rdi
    82a0:	31 d2                	xor    %edx,%edx
    82a2:	48 89 d9             	mov    %rbx,%rcx
    82a5:	e8 b6 fa ff ff       	call   7d60 <tp_value>
    82aa:	85 c0                	test   %eax,%eax
    82ac:	0f 84 df 02 00 00    	je     8591 <tp_value+0x831>
    82b2:	41 83 7e 10 02       	cmpl   $0x2,0x10(%r14)
    82b7:	7c 54                	jl     830d <tp_value+0x5ad>
    82b9:	48 89 dd             	mov    %rbx,%rbp
    82bc:	48 83 c5 08          	add    $0x8,%rbp
    82c0:	41 bd 01 00 00 00    	mov    $0x1,%r13d
    82c6:	4c 89 ff             	mov    %r15,%rdi
    82c9:	48 8d 35 dc 5f 00 00 	lea    0x5fdc(%rip),%rsi        # e2ac <exec_in_fp0+0xc4c>
    82d0:	e8 7b 07 00 00       	call   8a50 <tp_eat>
    82d5:	85 c0                	test   %eax,%eax
    82d7:	0f 84 b4 02 00 00    	je     8591 <tp_value+0x831>
    82dd:	49 8b 46 20          	mov    0x20(%r14),%rax
    82e1:	4a 8b 34 e8          	mov    (%rax,%r13,8),%rsi
    82e5:	45 31 e4             	xor    %r12d,%r12d
    82e8:	4c 89 ff             	mov    %r15,%rdi
    82eb:	31 d2                	xor    %edx,%edx
    82ed:	48 89 e9             	mov    %rbp,%rcx
    82f0:	e8 6b fa ff ff       	call   7d60 <tp_value>
    82f5:	85 c0                	test   %eax,%eax
    82f7:	0f 84 97 02 00 00    	je     8594 <tp_value+0x834>
    82fd:	49 ff c5             	inc    %r13
    8300:	49 63 46 10          	movslq 0x10(%r14),%rax
    8304:	48 83 c5 08          	add    $0x8,%rbp
    8308:	49 39 c5             	cmp    %rax,%r13
    830b:	7c b9                	jl     82c6 <tp_value+0x566>
    830d:	48 8d 35 5b 60 00 00 	lea    0x605b(%rip),%rsi        # e36f <exec_in_fp0+0xd0f>
    8314:	4c 89 ff             	mov    %r15,%rdi
    8317:	e8 34 07 00 00       	call   8a50 <tp_eat>
    831c:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    8322:	85 c0                	test   %eax,%eax
    8324:	0f 84 6a 02 00 00    	je     8594 <tp_value+0x834>
    832a:	41 8b 7e 10          	mov    0x10(%r14),%edi
    832e:	48 89 de             	mov    %rbx,%rsi
    8331:	e8 fa af ff ff       	call   3330 <fwp_record>
    8336:	e9 28 01 00 00       	jmp    8463 <tp_value+0x703>
    833b:	4c 89 ff             	mov    %r15,%rdi
    833e:	4c 89 f6             	mov    %r14,%rsi
    8341:	48 89 ea             	mov    %rbp,%rdx
    8344:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    834b:	5b                   	pop    %rbx
    834c:	41 5c                	pop    %r12
    834e:	41 5d                	pop    %r13
    8350:	41 5e                	pop    %r14
    8352:	41 5f                	pop    %r15
    8354:	5d                   	pop    %rbp
    8355:	e9 56 0b 00 00       	jmp    8eb0 <tp_record_body>
    835a:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    835f:	45 85 ed             	test   %r13d,%r13d
    8362:	74 7a                	je     83de <tp_value+0x67e>
    8364:	85 ed                	test   %ebp,%ebp
    8366:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    836b:	79 76                	jns    83e3 <tp_value+0x683>
    836d:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    8371:	45 31 e4             	xor    %r12d,%r12d
    8374:	48 85 ff             	test   %rdi,%rdi
    8377:	0f 84 17 02 00 00    	je     8594 <tp_value+0x834>
    837d:	48 8d 35 f4 5e 00 00 	lea    0x5ef4(%rip),%rsi        # e278 <exec_in_fp0+0xc18>
    8384:	e8 37 9f ff ff       	call   22c0 <strcmp@plt>
    8389:	85 c0                	test   %eax,%eax
    838b:	0f 85 03 02 00 00    	jne    8594 <tp_value+0x834>
    8391:	8b 44 24 20          	mov    0x20(%rsp),%eax
    8395:	89 c1                	mov    %eax,%ecx
    8397:	81 f1 74 72 75 65    	xor    $0x65757274,%ecx
    839d:	0f b6 54 24 24       	movzbl 0x24(%rsp),%edx
    83a2:	09 ca                	or     %ecx,%edx
    83a4:	b9 01 00 00 00       	mov    $0x1,%ecx
    83a9:	0f 44 e9             	cmove  %ecx,%ebp
    83ac:	35 66 61 6c 73       	xor    $0x736c6166,%eax
    83b1:	0f b7 4c 24 24       	movzwl 0x24(%rsp),%ecx
    83b6:	83 f1 65             	xor    $0x65,%ecx
    83b9:	09 c1                	or     %eax,%ecx
    83bb:	75 26                	jne    83e3 <tp_value+0x683>
    83bd:	31 ed                	xor    %ebp,%ebp
    83bf:	eb 2a                	jmp    83eb <tp_value+0x68b>
    83c1:	48 8d 05 68 ca 01 00 	lea    0x1ca68(%rip),%rax        # 24e30 <fwp_empty_map>
    83c8:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    83cd:	48 89 c3             	mov    %rax,%rbx
    83d0:	e8 2b d0 ff ff       	call   5400 <fwp_mem_free>
    83d5:	48 89 5d 00          	mov    %rbx,0x0(%rbp)
    83d9:	e9 e1 f9 ff ff       	jmp    7dbf <tp_value+0x5f>
    83de:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    83e3:	85 ed                	test   %ebp,%ebp
    83e5:	0f 88 a6 01 00 00    	js     8591 <tp_value+0x831>
    83eb:	48 8b 43 28          	mov    0x28(%rbx),%rax
    83ef:	41 89 ed             	mov    %ebp,%r13d
    83f2:	4a 63 1c a8          	movslq (%rax,%r13,4),%rbx
    83f6:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    83fd:	00 
    83fe:	e8 2d b2 ff ff       	call   3630 <fwp_alloc>
    8403:	48 89 c5             	mov    %rax,%rbp
    8406:	89 d8                	mov    %ebx,%eax
    8408:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    840d:	48 85 db             	test   %rbx,%rbx
    8410:	7e 41                	jle    8453 <tp_value+0x6f3>
    8412:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    8417:	48 8d 1c c5 00 00 00 	lea    0x0(,%rax,8),%rbx
    841e:	00 
    841f:	45 31 e4             	xor    %r12d,%r12d
    8422:	45 31 f6             	xor    %r14d,%r14d
    8425:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    842a:	48 8b 40 30          	mov    0x30(%rax),%rax
    842e:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    8432:	4a 8b 34 30          	mov    (%rax,%r14,1),%rsi
    8436:	49 8d 14 2e          	lea    (%r14,%rbp,1),%rdx
    843a:	4c 89 ff             	mov    %r15,%rdi
    843d:	e8 fe 0c 00 00       	call   9140 <tp_atom>
    8442:	85 c0                	test   %eax,%eax
    8444:	0f 84 4a 01 00 00    	je     8594 <tp_value+0x834>
    844a:	49 83 c6 08          	add    $0x8,%r14
    844e:	4c 39 f3             	cmp    %r14,%rbx
    8451:	75 d2                	jne    8425 <tp_value+0x6c5>
    8453:	44 89 ef             	mov    %r13d,%edi
    8456:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    845b:	48 89 ea             	mov    %rbp,%rdx
    845e:	e8 5d d2 ff ff       	call   56c0 <fwp_data>
    8463:	48 8b 0c 24          	mov    (%rsp),%rcx
    8467:	48 89 01             	mov    %rax,(%rcx)
    846a:	e9 50 f9 ff ff       	jmp    7dbf <tp_value+0x5f>
    846f:	48 89 2c 24          	mov    %rbp,(%rsp)
    8473:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8478:	ba 80 00 00 00       	mov    $0x80,%edx
    847d:	4c 89 ff             	mov    %r15,%rdi
    8480:	48 89 f3             	mov    %rsi,%rbx
    8483:	e8 e8 06 00 00       	call   8b70 <tp_token>
    8488:	49 89 c7             	mov    %rax,%r15
    848b:	4c 8d 24 04          	lea    (%rsp,%rax,1),%r12
    848f:	49 83 c4 20          	add    $0x20,%r12
    8493:	41 be 08 00 00 00    	mov    $0x8,%r14d
    8499:	eb 0e                	jmp    84a9 <tp_value+0x749>
    849b:	49 83 c6 10          	add    $0x10,%r14
    849f:	49 83 fe 68          	cmp    $0x68,%r14
    84a3:	0f 84 e8 00 00 00    	je     8591 <tp_value+0x831>
    84a9:	48 8d 05 c0 a7 00 00 	lea    0xa7c0(%rip),%rax        # 12c70 <tp_value.units>
    84b0:	49 8b 6c 06 f8       	mov    -0x8(%r14,%rax,1),%rbp
    84b5:	48 89 ef             	mov    %rbp,%rdi
    84b8:	e8 a3 9c ff ff       	call   2160 <strlen@plt>
    84bd:	4d 89 fd             	mov    %r15,%r13
    84c0:	49 29 c5             	sub    %rax,%r13
    84c3:	76 d6                	jbe    849b <tp_value+0x73b>
    84c5:	4c 89 e7             	mov    %r12,%rdi
    84c8:	48 29 c7             	sub    %rax,%rdi
    84cb:	48 89 ee             	mov    %rbp,%rsi
    84ce:	e8 ed 9d ff ff       	call   22c0 <strcmp@plt>
    84d3:	85 c0                	test   %eax,%eax
    84d5:	75 c4                	jne    849b <tp_value+0x73b>
    84d7:	48 8d ac 24 20 01 00 	lea    0x120(%rsp),%rbp
    84de:	00 
    84df:	48 89 ef             	mov    %rbp,%rdi
    84e2:	48 89 de             	mov    %rbx,%rsi
    84e5:	4c 89 ea             	mov    %r13,%rdx
    84e8:	e8 33 9e ff ff       	call   2320 <memcpy@plt>
    84ed:	42 c6 84 2c 20 01 00 	movb   $0x0,0x120(%rsp,%r13,1)
    84f4:	00 00 
    84f6:	48 89 ef             	mov    %rbp,%rdi
    84f9:	4c 89 ee             	mov    %r13,%rsi
    84fc:	e8 6f 09 00 00       	call   8e70 <fwp_valid_int>
    8501:	85 c0                	test   %eax,%eax
    8503:	74 96                	je     849b <tp_value+0x73b>
    8505:	0f b6 b4 24 20 01 00 	movzbl 0x120(%rsp),%esi
    850c:	00 
    850d:	8d 4e d5             	lea    -0x2b(%rsi),%ecx
    8510:	31 c0                	xor    %eax,%eax
    8512:	f6 c1 fd             	test   $0xfd,%cl
    8515:	0f 94 c0             	sete   %al
    8518:	44 0f b6 94 04 20 01 	movzbl 0x120(%rsp,%rax,1),%r10d
    851f:	00 00 
    8521:	45 31 e4             	xor    %r12d,%r12d
    8524:	45 84 d2             	test   %r10b,%r10b
    8527:	0f 84 ba 00 00 00    	je     85e7 <tp_value+0x887>
    852d:	48 8d 8c 24 20 01 00 	lea    0x120(%rsp),%rcx
    8534:	00 
    8535:	48 01 c1             	add    %rax,%rcx
    8538:	48 ff c1             	inc    %rcx
    853b:	31 c0                	xor    %eax,%eax
    853d:	bf 0a 00 00 00       	mov    $0xa,%edi
    8542:	49 b9 00 00 00 00 00 	movabs $0x8000000000000000,%r9
    8549:	00 00 80 
    854c:	45 31 c0             	xor    %r8d,%r8d
    854f:	48 8b 1c 24          	mov    (%rsp),%rbx
    8553:	48 f7 e7             	mul    %rdi
    8556:	4f 8d 04 80          	lea    (%r8,%r8,4),%r8
    855a:	4a 8d 14 42          	lea    (%rdx,%r8,2),%rdx
    855e:	45 0f be c2          	movsbl %r10b,%r8d
    8562:	41 83 c0 d0          	add    $0xffffffd0,%r8d
    8566:	4d 63 d0             	movslq %r8d,%r10
    8569:	4d 89 d0             	mov    %r10,%r8
    856c:	49 c1 f8 3f          	sar    $0x3f,%r8
    8570:	4c 01 d0             	add    %r10,%rax
    8573:	49 11 d0             	adc    %rdx,%r8
    8576:	49 39 c1             	cmp    %rax,%r9
    8579:	ba 00 00 00 00       	mov    $0x0,%edx
    857e:	4c 19 c2             	sbb    %r8,%rdx
    8581:	7c 0e                	jl     8591 <tp_value+0x831>
    8583:	44 0f b6 11          	movzbl (%rcx),%r10d
    8587:	48 ff c1             	inc    %rcx
    858a:	45 84 d2             	test   %r10b,%r10b
    858d:	75 c4                	jne    8553 <tp_value+0x7f3>
    858f:	eb 5f                	jmp    85f0 <tp_value+0x890>
    8591:	45 31 e4             	xor    %r12d,%r12d
    8594:	44 89 e0             	mov    %r12d,%eax
    8597:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    859e:	5b                   	pop    %rbx
    859f:	41 5c                	pop    %r12
    85a1:	41 5d                	pop    %r13
    85a3:	41 5e                	pop    %r14
    85a5:	41 5f                	pop    %r15
    85a7:	5d                   	pop    %rbp
    85a8:	c3                   	ret
    85a9:	48 8d 35 fa 5c 00 00 	lea    0x5cfa(%rip),%rsi        # e2aa <exec_in_fp0+0xc4a>
    85b0:	4c 89 ff             	mov    %r15,%rdi
    85b3:	e8 98 04 00 00       	call   8a50 <tp_eat>
    85b8:	85 c0                	test   %eax,%eax
    85ba:	74 d8                	je     8594 <tp_value+0x834>
    85bc:	48 8d 35 ac 5d 00 00 	lea    0x5dac(%rip),%rsi        # e36f <exec_in_fp0+0xd0f>
    85c3:	4c 89 ff             	mov    %r15,%rdi
    85c6:	e8 85 04 00 00       	call   8a50 <tp_eat>
    85cb:	85 c0                	test   %eax,%eax
    85cd:	74 c5                	je     8594 <tp_value+0x834>
    85cf:	48 c7 45 00 00 00 00 	movq   $0x0,0x0(%rbp)
    85d6:	00 
    85d7:	e9 e3 f7 ff ff       	jmp    7dbf <tp_value+0x5f>
    85dc:	31 c9                	xor    %ecx,%ecx
    85de:	48 89 4d 00          	mov    %rcx,0x0(%rbp)
    85e2:	e9 d8 f7 ff ff       	jmp    7dbf <tp_value+0x5f>
    85e7:	31 c0                	xor    %eax,%eax
    85e9:	45 31 c0             	xor    %r8d,%r8d
    85ec:	48 8b 1c 24          	mov    (%rsp),%rbx
    85f0:	48 89 c1             	mov    %rax,%rcx
    85f3:	48 f7 d9             	neg    %rcx
    85f6:	bf 00 00 00 00       	mov    $0x0,%edi
    85fb:	4c 19 c7             	sbb    %r8,%rdi
    85fe:	40 80 fe 2d          	cmp    $0x2d,%sil
    8602:	49 0f 45 f8          	cmovne %r8,%rdi
    8606:	48 0f 45 c8          	cmovne %rax,%rcx
    860a:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    8611:	ff ff 7f 
    8614:	48 39 c8             	cmp    %rcx,%rax
    8617:	b8 00 00 00 00       	mov    $0x0,%eax
    861c:	48 19 f8             	sbb    %rdi,%rax
    861f:	0f 8c 6f ff ff ff    	jl     8594 <tp_value+0x834>
    8625:	48 8d 05 44 a6 00 00 	lea    0xa644(%rip),%rax        # 12c70 <tp_value.units>
    862c:	49 8b 34 06          	mov    (%r14,%rax,1),%rsi
    8630:	48 89 c8             	mov    %rcx,%rax
    8633:	48 f7 e6             	mul    %rsi
    8636:	48 0f af fe          	imul   %rsi,%rdi
    863a:	48 c1 fe 3f          	sar    $0x3f,%rsi
    863e:	48 0f af f1          	imul   %rcx,%rsi
    8642:	48 01 d6             	add    %rdx,%rsi
    8645:	48 01 f7             	add    %rsi,%rdi
    8648:	48 b9 00 00 00 00 00 	movabs $0x8000000000000000,%rcx
    864f:	00 00 80 
    8652:	48 01 c1             	add    %rax,%rcx
    8655:	48 83 d7 ff          	adc    $0xffffffffffffffff,%rdi
    8659:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
    865d:	0f 85 31 ff ff ff    	jne    8594 <tp_value+0x834>
    8663:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    8668:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    866e:	48 8d 74 24 18       	lea    0x18(%rsp),%rsi
    8673:	bf 01 00 00 00       	mov    $0x1,%edi
    8678:	e8 b3 ac ff ff       	call   3330 <fwp_record>
    867d:	48 89 03             	mov    %rax,(%rbx)
    8680:	e9 0f ff ff ff       	jmp    8594 <tp_value+0x834>
    8685:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    868c:	00 00 00 00 

0000000000008690 <tp_ws>:
    8690:	48 8b 47 08          	mov    0x8(%rdi),%rax
    8694:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    8698:	48 39 c1             	cmp    %rax,%rcx
    869b:	73 39                	jae    86d6 <tp_ws+0x46>
    869d:	48 8b 17             	mov    (%rdi),%rdx
    86a0:	48 f7 d8             	neg    %rax
    86a3:	48 ff c1             	inc    %rcx
    86a6:	48 be 00 26 00 00 01 	movabs $0x100002600,%rsi
    86ad:	00 00 00 
    86b0:	44 0f b6 44 0a ff    	movzbl -0x1(%rdx,%rcx,1),%r8d
    86b6:	49 83 f8 20          	cmp    $0x20,%r8
    86ba:	77 1a                	ja     86d6 <tp_ws+0x46>
    86bc:	4c 0f a3 c6          	bt     %r8,%rsi
    86c0:	73 14                	jae    86d6 <tp_ws+0x46>
    86c2:	48 89 4f 10          	mov    %rcx,0x10(%rdi)
    86c6:	4c 8d 04 08          	lea    (%rax,%rcx,1),%r8
    86ca:	49 ff c0             	inc    %r8
    86cd:	48 ff c1             	inc    %rcx
    86d0:	49 83 f8 01          	cmp    $0x1,%r8
    86d4:	75 da                	jne    86b0 <tp_ws+0x20>
    86d6:	c3                   	ret
    86d7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    86de:	00 00 

00000000000086e0 <tp_int>:
    86e0:	55                   	push   %rbp
    86e1:	41 56                	push   %r14
    86e3:	53                   	push   %rbx
    86e4:	48 81 ec 80 00 00 00 	sub    $0x80,%rsp
    86eb:	48 89 d3             	mov    %rdx,%rbx
    86ee:	49 89 f6             	mov    %rsi,%r14
    86f1:	48 89 e6             	mov    %rsp,%rsi
    86f4:	ba 80 00 00 00       	mov    $0x80,%edx
    86f9:	e8 72 04 00 00       	call   8b70 <tp_token>
    86fe:	31 ed                	xor    %ebp,%ebp
    8700:	48 83 f8 7f          	cmp    $0x7f,%rax
    8704:	77 28                	ja     872e <tp_int+0x4e>
    8706:	48 89 e7             	mov    %rsp,%rdi
    8709:	e8 d2 0a 00 00       	call   91e0 <fwp_cstr>
    870e:	41 8b 36             	mov    (%r14),%esi
    8711:	41 8b 56 48          	mov    0x48(%r14),%edx
    8715:	48 89 c7             	mov    %rax,%rdi
    8718:	e8 e3 0a 00 00       	call   9200 <fwp_p_parse_int>
    871d:	48 85 c0             	test   %rax,%rax
    8720:	74 0c                	je     872e <tp_int+0x4e>
    8722:	48 8b 40 08          	mov    0x8(%rax),%rax
    8726:	48 89 03             	mov    %rax,(%rbx)
    8729:	bd 01 00 00 00       	mov    $0x1,%ebp
    872e:	89 e8                	mov    %ebp,%eax
    8730:	48 81 c4 80 00 00 00 	add    $0x80,%rsp
    8737:	5b                   	pop    %rbx
    8738:	41 5e                	pop    %r14
    873a:	5d                   	pop    %rbp
    873b:	c3                   	ret
    873c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000008740 <tp_float>:
    8740:	41 56                	push   %r14
    8742:	53                   	push   %rbx
    8743:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    874a:	48 89 d3             	mov    %rdx,%rbx
    874d:	49 89 f6             	mov    %rsi,%r14
    8750:	48 89 e6             	mov    %rsp,%rsi
    8753:	ba 80 00 00 00       	mov    $0x80,%edx
    8758:	e8 13 04 00 00       	call   8b70 <tp_token>
    875d:	31 c9                	xor    %ecx,%ecx
    875f:	48 83 f8 7f          	cmp    $0x7f,%rax
    8763:	0f 87 84 00 00 00    	ja     87ed <tp_float+0xad>
    8769:	8b 0c 24             	mov    (%rsp),%ecx
    876c:	81 f9 69 6e 66 00    	cmp    $0x666e69,%ecx
    8772:	75 0a                	jne    877e <tp_float+0x3e>
    8774:	f2 0f 10 05 b4 48 00 	movsd  0x48b4(%rip),%xmm0        # d030 <_IO_stdin_used+0x30>
    877b:	00 
    877c:	eb 5f                	jmp    87dd <tp_float+0x9d>
    877e:	ba 2d 69 6e 66       	mov    $0x666e692d,%edx
    8783:	33 14 24             	xor    (%rsp),%edx
    8786:	0f b6 74 24 04       	movzbl 0x4(%rsp),%esi
    878b:	09 d6                	or     %edx,%esi
    878d:	74 12                	je     87a1 <tp_float+0x61>
    878f:	81 f9 4e 61 4e 00    	cmp    $0x4e614e,%ecx
    8795:	75 14                	jne    87ab <tp_float+0x6b>
    8797:	f2 0f 10 05 a1 48 00 	movsd  0x48a1(%rip),%xmm0        # d040 <_IO_stdin_used+0x40>
    879e:	00 
    879f:	eb 3c                	jmp    87dd <tp_float+0x9d>
    87a1:	f2 0f 10 05 8f 48 00 	movsd  0x488f(%rip),%xmm0        # d038 <_IO_stdin_used+0x38>
    87a8:	00 
    87a9:	eb 32                	jmp    87dd <tp_float+0x9d>
    87ab:	48 89 e7             	mov    %rsp,%rdi
    87ae:	48 89 c6             	mov    %rax,%rsi
    87b1:	e8 7a 0e 00 00       	call   9630 <fwp_valid_float>
    87b6:	31 c9                	xor    %ecx,%ecx
    87b8:	85 c0                	test   %eax,%eax
    87ba:	74 31                	je     87ed <tp_float+0xad>
    87bc:	41 83 3e 0a          	cmpl   $0xa,(%r14)
    87c0:	75 11                	jne    87d3 <tp_float+0x93>
    87c2:	48 89 e7             	mov    %rsp,%rdi
    87c5:	31 f6                	xor    %esi,%esi
    87c7:	e8 24 9a ff ff       	call   21f0 <strtof@plt>
    87cc:	e8 4f 0f 00 00       	call   9720 <fwp_from_f32>
    87d1:	eb 12                	jmp    87e5 <tp_float+0xa5>
    87d3:	48 89 e7             	mov    %rsp,%rdi
    87d6:	31 f6                	xor    %esi,%esi
    87d8:	e8 13 99 ff ff       	call   20f0 <strtod@plt>
    87dd:	41 8b 3e             	mov    (%r14),%edi
    87e0:	e8 4b 0f 00 00       	call   9730 <fwp_float_of>
    87e5:	48 89 03             	mov    %rax,(%rbx)
    87e8:	b9 01 00 00 00       	mov    $0x1,%ecx
    87ed:	89 c8                	mov    %ecx,%eax
    87ef:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
    87f6:	5b                   	pop    %rbx
    87f7:	41 5e                	pop    %r14
    87f9:	c3                   	ret
    87fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000008800 <tp_quoted>:
    8800:	55                   	push   %rbp
    8801:	41 57                	push   %r15
    8803:	41 56                	push   %r14
    8805:	41 55                	push   %r13
    8807:	41 54                	push   %r12
    8809:	53                   	push   %rbx
    880a:	48 83 ec 18          	sub    $0x18,%rsp
    880e:	49 89 f6             	mov    %rsi,%r14
    8811:	49 89 ff             	mov    %rdi,%r15
    8814:	e8 77 fe ff ff       	call   8690 <tp_ws>
    8819:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    881d:	49 8b 6f 10          	mov    0x10(%r15),%rbp
    8821:	31 db                	xor    %ebx,%ebx
    8823:	4c 39 ed             	cmp    %r13,%rbp
    8826:	0f 83 0d 02 00 00    	jae    8a39 <tp_quoted+0x239>
    882c:	49 8b 07             	mov    (%r15),%rax
    882f:	80 3c 28 22          	cmpb   $0x22,(%rax,%rbp,1)
    8833:	0f 85 00 02 00 00    	jne    8a39 <tp_quoted+0x239>
    8839:	48 ff c5             	inc    %rbp
    883c:	49 89 6f 10          	mov    %rbp,0x10(%r15)
    8840:	0f 57 c0             	xorps  %xmm0,%xmm0
    8843:	0f 29 04 24          	movaps %xmm0,(%rsp)
    8847:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    884e:	00 00 
    8850:	31 db                	xor    %ebx,%ebx
    8852:	4c 39 ed             	cmp    %r13,%rbp
    8855:	0f 83 8d 01 00 00    	jae    89e8 <tp_quoted+0x1e8>
    885b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8860:	4d 8b 27             	mov    (%r15),%r12
    8863:	48 8d 4d 01          	lea    0x1(%rbp),%rcx
    8867:	49 89 4f 10          	mov    %rcx,0x10(%r15)
    886b:	41 0f b6 04 2c       	movzbl (%r12,%rbp,1),%eax
    8870:	83 f8 5c             	cmp    $0x5c,%eax
    8873:	74 2b                	je     88a0 <tp_quoted+0xa0>
    8875:	83 f8 22             	cmp    $0x22,%eax
    8878:	0f 84 8b 01 00 00    	je     8a09 <tp_quoted+0x209>
    887e:	0f be f0             	movsbl %al,%esi
    8881:	48 89 e7             	mov    %rsp,%rdi
    8884:	e8 57 ee ff ff       	call   76e0 <buf_putc>
    8889:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    888d:	49 8b 6f 10          	mov    0x10(%r15),%rbp
    8891:	4c 39 ed             	cmp    %r13,%rbp
    8894:	72 ca                	jb     8860 <tp_quoted+0x60>
    8896:	e9 63 01 00 00       	jmp    89fe <tp_quoted+0x1fe>
    889b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    88a0:	4c 39 e9             	cmp    %r13,%rcx
    88a3:	0f 83 48 01 00 00    	jae    89f1 <tp_quoted+0x1f1>
    88a9:	48 8d 45 02          	lea    0x2(%rbp),%rax
    88ad:	49 89 47 10          	mov    %rax,0x10(%r15)
    88b1:	41 0f b6 4c 2c 01    	movzbl 0x1(%r12,%rbp,1),%ecx
    88b7:	8d 51 a4             	lea    -0x5c(%rcx),%edx
    88ba:	83 fa 19             	cmp    $0x19,%edx
    88bd:	77 1a                	ja     88d9 <tp_quoted+0xd9>
    88bf:	48 8d 35 7a 49 00 00 	lea    0x497a(%rip),%rsi        # d240 <_IO_stdin_used+0x240>
    88c6:	48 63 0c 96          	movslq (%rsi,%rdx,4),%rcx
    88ca:	48 01 f1             	add    %rsi,%rcx
    88cd:	ff e1                	jmp    *%rcx
    88cf:	48 89 e7             	mov    %rsp,%rdi
    88d2:	be 5c 00 00 00       	mov    $0x5c,%esi
    88d7:	eb ab                	jmp    8884 <tp_quoted+0x84>
    88d9:	83 f9 22             	cmp    $0x22,%ecx
    88dc:	0f 84 bf 00 00 00    	je     89a1 <tp_quoted+0x1a1>
    88e2:	83 f9 30             	cmp    $0x30,%ecx
    88e5:	0f 85 06 01 00 00    	jne    89f1 <tp_quoted+0x1f1>
    88eb:	48 89 e7             	mov    %rsp,%rdi
    88ee:	31 f6                	xor    %esi,%esi
    88f0:	eb 92                	jmp    8884 <tp_quoted+0x84>
    88f2:	48 89 e7             	mov    %rsp,%rdi
    88f5:	be 09 00 00 00       	mov    $0x9,%esi
    88fa:	eb 88                	jmp    8884 <tp_quoted+0x84>
    88fc:	48 89 e7             	mov    %rsp,%rdi
    88ff:	be 0d 00 00 00       	mov    $0xd,%esi
    8904:	e9 7b ff ff ff       	jmp    8884 <tp_quoted+0x84>
    8909:	48 89 e7             	mov    %rsp,%rdi
    890c:	be 0a 00 00 00       	mov    $0xa,%esi
    8911:	e9 6e ff ff ff       	jmp    8884 <tp_quoted+0x84>
    8916:	4c 39 e8             	cmp    %r13,%rax
    8919:	0f 83 d2 00 00 00    	jae    89f1 <tp_quoted+0x1f1>
    891f:	41 80 3c 04 7b       	cmpb   $0x7b,(%r12,%rax,1)
    8924:	0f 85 c7 00 00 00    	jne    89f1 <tp_quoted+0x1f1>
    892a:	48 8d 45 03          	lea    0x3(%rbp),%rax
    892e:	49 89 47 10          	mov    %rax,0x10(%r15)
    8932:	4c 39 e8             	cmp    %r13,%rax
    8935:	0f 83 b6 00 00 00    	jae    89f1 <tp_quoted+0x1f1>
    893b:	e8 b0 9b ff ff       	call   24f0 <__ctype_b_loc@plt>
    8940:	48 8b 08             	mov    (%rax),%rcx
    8943:	48 8d 55 04          	lea    0x4(%rbp),%rdx
    8947:	49 8d 3c 2c          	lea    (%r12,%rbp,1),%rdi
    894b:	48 83 c7 03          	add    $0x3,%rdi
    894f:	49 29 ed             	sub    %rbp,%r13
    8952:	49 83 c5 fd          	add    $0xfffffffffffffffd,%r13
    8956:	31 c0                	xor    %eax,%eax
    8958:	31 f6                	xor    %esi,%esi
    895a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8960:	44 0f b6 04 07       	movzbl (%rdi,%rax,1),%r8d
    8965:	42 f6 44 41 01 10    	testb  $0x10,0x1(%rcx,%r8,2)
    896b:	74 41                	je     89ae <tp_quoted+0x1ae>
    896d:	4c 8d 04 02          	lea    (%rdx,%rax,1),%r8
    8971:	4d 89 47 10          	mov    %r8,0x10(%r15)
    8975:	44 0f be 04 07       	movsbl (%rdi,%rax,1),%r8d
    897a:	c1 e6 04             	shl    $0x4,%esi
    897d:	45 8d 48 d0          	lea    -0x30(%r8),%r9d
    8981:	45 89 c2             	mov    %r8d,%r10d
    8984:	41 83 ca 20          	or     $0x20,%r10d
    8988:	41 83 c2 a9          	add    $0xffffffa9,%r10d
    898c:	41 83 f8 3a          	cmp    $0x3a,%r8d
    8990:	45 0f 4c d1          	cmovl  %r9d,%r10d
    8994:	44 01 d6             	add    %r10d,%esi
    8997:	48 ff c0             	inc    %rax
    899a:	49 39 c5             	cmp    %rax,%r13
    899d:	75 c1                	jne    8960 <tp_quoted+0x160>
    899f:	eb 50                	jmp    89f1 <tp_quoted+0x1f1>
    89a1:	48 89 e7             	mov    %rsp,%rdi
    89a4:	be 22 00 00 00       	mov    $0x22,%esi
    89a9:	e9 d6 fe ff ff       	jmp    8884 <tp_quoted+0x84>
    89ae:	85 c0                	test   %eax,%eax
    89b0:	74 3f                	je     89f1 <tp_quoted+0x1f1>
    89b2:	41 80 f8 7d          	cmp    $0x7d,%r8b
    89b6:	75 39                	jne    89f1 <tp_quoted+0x1f1>
    89b8:	81 fe ff ff 10 00    	cmp    $0x10ffff,%esi
    89be:	77 31                	ja     89f1 <tp_quoted+0x1f1>
    89c0:	89 f1                	mov    %esi,%ecx
    89c2:	81 e1 00 f8 ff ff    	and    $0xfffff800,%ecx
    89c8:	81 f9 00 d8 00 00    	cmp    $0xd800,%ecx
    89ce:	74 21                	je     89f1 <tp_quoted+0x1f1>
    89d0:	48 01 e8             	add    %rbp,%rax
    89d3:	48 83 c0 04          	add    $0x4,%rax
    89d7:	49 89 47 10          	mov    %rax,0x10(%r15)
    89db:	48 89 e7             	mov    %rsp,%rdi
    89de:	e8 5d 0d 00 00       	call   9740 <fwp_utf8_put>
    89e3:	e9 a1 fe ff ff       	jmp    8889 <tp_quoted+0x89>
    89e8:	31 ff                	xor    %edi,%edi
    89ea:	e8 61 96 ff ff       	call   2050 <free@plt>
    89ef:	eb 48                	jmp    8a39 <tp_quoted+0x239>
    89f1:	48 8b 3c 24          	mov    (%rsp),%rdi
    89f5:	e8 56 96 ff ff       	call   2050 <free@plt>
    89fa:	31 db                	xor    %ebx,%ebx
    89fc:	eb 3b                	jmp    8a39 <tp_quoted+0x239>
    89fe:	48 8b 3c 24          	mov    (%rsp),%rdi
    8a02:	e8 49 96 ff ff       	call   2050 <free@plt>
    8a07:	eb 30                	jmp    8a39 <tp_quoted+0x239>
    8a09:	48 8b 1c 24          	mov    (%rsp),%rbx
    8a0d:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    8a12:	48 85 db             	test   %rbx,%rbx
    8a15:	48 8d 3d 8c 56 00 00 	lea    0x568c(%rip),%rdi        # e0a8 <exec_in_fp0+0xa48>
    8a1c:	48 0f 45 fb          	cmovne %rbx,%rdi
    8a20:	e8 1b eb ff ff       	call   7540 <fwp_valid_utf8>
    8a25:	85 c0                	test   %eax,%eax
    8a27:	74 21                	je     8a4a <tp_quoted+0x24a>
    8a29:	48 89 e7             	mov    %rsp,%rdi
    8a2c:	e8 3f ed ff ff       	call   7770 <buf_to_str>
    8a31:	49 89 06             	mov    %rax,(%r14)
    8a34:	bb 01 00 00 00       	mov    $0x1,%ebx
    8a39:	89 d8                	mov    %ebx,%eax
    8a3b:	48 83 c4 18          	add    $0x18,%rsp
    8a3f:	5b                   	pop    %rbx
    8a40:	41 5c                	pop    %r12
    8a42:	41 5d                	pop    %r13
    8a44:	41 5e                	pop    %r14
    8a46:	41 5f                	pop    %r15
    8a48:	5d                   	pop    %rbp
    8a49:	c3                   	ret
    8a4a:	48 89 df             	mov    %rbx,%rdi
    8a4d:	eb a6                	jmp    89f5 <tp_quoted+0x1f5>
    8a4f:	90                   	nop

0000000000008a50 <tp_eat>:
    8a50:	55                   	push   %rbp
    8a51:	41 57                	push   %r15
    8a53:	41 56                	push   %r14
    8a55:	53                   	push   %rbx
    8a56:	50                   	push   %rax
    8a57:	49 89 f6             	mov    %rsi,%r14
    8a5a:	48 89 fb             	mov    %rdi,%rbx
    8a5d:	e8 2e fc ff ff       	call   8690 <tp_ws>
    8a62:	4c 89 f7             	mov    %r14,%rdi
    8a65:	e8 f6 96 ff ff       	call   2160 <strlen@plt>
    8a6a:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    8a6e:	4c 8b 7b 10          	mov    0x10(%rbx),%r15
    8a72:	4c 29 f9             	sub    %r15,%rcx
    8a75:	31 ed                	xor    %ebp,%ebp
    8a77:	48 39 c1             	cmp    %rax,%rcx
    8a7a:	72 24                	jb     8aa0 <tp_eat+0x50>
    8a7c:	48 8b 3b             	mov    (%rbx),%rdi
    8a7f:	4c 01 ff             	add    %r15,%rdi
    8a82:	4c 89 f6             	mov    %r14,%rsi
    8a85:	49 89 c6             	mov    %rax,%r14
    8a88:	48 89 c2             	mov    %rax,%rdx
    8a8b:	e8 d0 98 ff ff       	call   2360 <bcmp@plt>
    8a90:	85 c0                	test   %eax,%eax
    8a92:	75 0c                	jne    8aa0 <tp_eat+0x50>
    8a94:	4d 01 f7             	add    %r14,%r15
    8a97:	4c 89 7b 10          	mov    %r15,0x10(%rbx)
    8a9b:	bd 01 00 00 00       	mov    $0x1,%ebp
    8aa0:	89 e8                	mov    %ebp,%eax
    8aa2:	48 83 c4 08          	add    $0x8,%rsp
    8aa6:	5b                   	pop    %rbx
    8aa7:	41 5e                	pop    %r14
    8aa9:	41 5f                	pop    %r15
    8aab:	5d                   	pop    %rbp
    8aac:	c3                   	ret
    8aad:	0f 1f 00             	nopl   (%rax)

0000000000008ab0 <tp_list_of>:
    8ab0:	55                   	push   %rbp
    8ab1:	41 57                	push   %r15
    8ab3:	41 56                	push   %r14
    8ab5:	41 55                	push   %r13
    8ab7:	41 54                	push   %r12
    8ab9:	53                   	push   %rbx
    8aba:	50                   	push   %rax
    8abb:	4d 89 c6             	mov    %r8,%r14
    8abe:	49 89 cf             	mov    %rcx,%r15
    8ac1:	49 89 d4             	mov    %rdx,%r12
    8ac4:	49 89 fd             	mov    %rdi,%r13
    8ac7:	e8 84 ff ff ff       	call   8a50 <tp_eat>
    8acc:	31 db                	xor    %ebx,%ebx
    8ace:	85 c0                	test   %eax,%eax
    8ad0:	74 14                	je     8ae6 <tp_list_of+0x36>
    8ad2:	4c 89 ef             	mov    %r13,%rdi
    8ad5:	4c 89 e6             	mov    %r12,%rsi
    8ad8:	e8 73 ff ff ff       	call   8a50 <tp_eat>
    8add:	85 c0                	test   %eax,%eax
    8adf:	74 16                	je     8af7 <tp_list_of+0x47>
    8ae1:	bb 01 00 00 00       	mov    $0x1,%ebx
    8ae6:	89 d8                	mov    %ebx,%eax
    8ae8:	48 83 c4 08          	add    $0x8,%rsp
    8aec:	5b                   	pop    %rbx
    8aed:	41 5c                	pop    %r12
    8aef:	41 5d                	pop    %r13
    8af1:	41 5e                	pop    %r14
    8af3:	41 5f                	pop    %r15
    8af5:	5d                   	pop    %rbp
    8af6:	c3                   	ret
    8af7:	48 8d 2d ae 57 00 00 	lea    0x57ae(%rip),%rbp        # e2ac <exec_in_fp0+0xc4c>
    8afe:	66 90                	xchg   %ax,%ax
    8b00:	4c 89 ef             	mov    %r13,%rdi
    8b03:	4c 89 f6             	mov    %r14,%rsi
    8b06:	41 ff d7             	call   *%r15
    8b09:	85 c0                	test   %eax,%eax
    8b0b:	74 d9                	je     8ae6 <tp_list_of+0x36>
    8b0d:	4c 89 ef             	mov    %r13,%rdi
    8b10:	4c 89 e6             	mov    %r12,%rsi
    8b13:	e8 38 ff ff ff       	call   8a50 <tp_eat>
    8b18:	85 c0                	test   %eax,%eax
    8b1a:	75 c5                	jne    8ae1 <tp_list_of+0x31>
    8b1c:	4c 89 ef             	mov    %r13,%rdi
    8b1f:	48 89 ee             	mov    %rbp,%rsi
    8b22:	e8 29 ff ff ff       	call   8a50 <tp_eat>
    8b27:	85 c0                	test   %eax,%eax
    8b29:	75 d5                	jne    8b00 <tp_list_of+0x50>
    8b2b:	eb b9                	jmp    8ae6 <tp_list_of+0x36>
    8b2d:	0f 1f 00             	nopl   (%rax)

0000000000008b30 <tp_byte_item>:
    8b30:	53                   	push   %rbx
    8b31:	48 83 ec 10          	sub    $0x10,%rsp
    8b35:	48 89 f3             	mov    %rsi,%rbx
    8b38:	48 8d 35 91 a1 00 00 	lea    0xa191(%rip),%rsi        # 12cd0 <tp_byte_item.u8d>
    8b3f:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    8b44:	e8 97 fb ff ff       	call   86e0 <tp_int>
    8b49:	85 c0                	test   %eax,%eax
    8b4b:	74 14                	je     8b61 <tp_byte_item+0x31>
    8b4d:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    8b52:	48 89 df             	mov    %rbx,%rdi
    8b55:	e8 96 0c 00 00       	call   97f0 <tp_push>
    8b5a:	b8 01 00 00 00       	mov    $0x1,%eax
    8b5f:	eb 02                	jmp    8b63 <tp_byte_item+0x33>
    8b61:	31 c0                	xor    %eax,%eax
    8b63:	48 83 c4 10          	add    $0x10,%rsp
    8b67:	5b                   	pop    %rbx
    8b68:	c3                   	ret
    8b69:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000008b70 <tp_token>:
    8b70:	55                   	push   %rbp
    8b71:	41 57                	push   %r15
    8b73:	41 56                	push   %r14
    8b75:	41 55                	push   %r13
    8b77:	41 54                	push   %r12
    8b79:	53                   	push   %rbx
    8b7a:	50                   	push   %rax
    8b7b:	49 89 d7             	mov    %rdx,%r15
    8b7e:	48 89 34 24          	mov    %rsi,(%rsp)
    8b82:	48 89 fb             	mov    %rdi,%rbx
    8b85:	e8 06 fb ff ff       	call   8690 <tp_ws>
    8b8a:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    8b8e:	4c 8b 23             	mov    (%rbx),%r12
    8b91:	4c 8b 6b 08          	mov    0x8(%rbx),%r13
    8b95:	4c 89 f5             	mov    %r14,%rbp
    8b98:	4d 39 ee             	cmp    %r13,%r14
    8b9b:	73 20                	jae    8bbd <tp_token+0x4d>
    8b9d:	4c 89 f5             	mov    %r14,%rbp
    8ba0:	41 0f be 3c 2c       	movsbl (%r12,%rbp,1),%edi
    8ba5:	e8 a6 0c 00 00       	call   9850 <tp_is_delim>
    8baa:	85 c0                	test   %eax,%eax
    8bac:	75 0f                	jne    8bbd <tp_token+0x4d>
    8bae:	48 ff c5             	inc    %rbp
    8bb1:	48 89 6b 10          	mov    %rbp,0x10(%rbx)
    8bb5:	49 39 ed             	cmp    %rbp,%r13
    8bb8:	75 e6                	jne    8ba0 <tp_token+0x30>
    8bba:	4c 89 ed             	mov    %r13,%rbp
    8bbd:	4c 29 f5             	sub    %r14,%rbp
    8bc0:	4d 8d 6f ff          	lea    -0x1(%r15),%r13
    8bc4:	4c 39 fd             	cmp    %r15,%rbp
    8bc7:	4c 0f 42 ed          	cmovb  %rbp,%r13
    8bcb:	4d 01 f4             	add    %r14,%r12
    8bce:	4c 8b 3c 24          	mov    (%rsp),%r15
    8bd2:	4c 89 ff             	mov    %r15,%rdi
    8bd5:	4c 89 e6             	mov    %r12,%rsi
    8bd8:	4c 89 ea             	mov    %r13,%rdx
    8bdb:	e8 40 97 ff ff       	call   2320 <memcpy@plt>
    8be0:	43 c6 04 2f 00       	movb   $0x0,(%r15,%r13,1)
    8be5:	48 8b 43 10          	mov    0x10(%rbx),%rax
    8be9:	4c 29 f0             	sub    %r14,%rax
    8bec:	48 83 c4 08          	add    $0x8,%rsp
    8bf0:	5b                   	pop    %rbx
    8bf1:	41 5c                	pop    %r12
    8bf3:	41 5d                	pop    %r13
    8bf5:	41 5e                	pop    %r14
    8bf7:	41 5f                	pop    %r15
    8bf9:	5d                   	pop    %rbp
    8bfa:	c3                   	ret
    8bfb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000008c00 <tp_elem_item>:
    8c00:	55                   	push   %rbp
    8c01:	53                   	push   %rbx
    8c02:	50                   	push   %rax
    8c03:	48 89 f3             	mov    %rsi,%rbx
    8c06:	48 8b 36             	mov    (%rsi),%rsi
    8c09:	31 ed                	xor    %ebp,%ebp
    8c0b:	48 89 e1             	mov    %rsp,%rcx
    8c0e:	31 d2                	xor    %edx,%edx
    8c10:	e8 4b f1 ff ff       	call   7d60 <tp_value>
    8c15:	85 c0                	test   %eax,%eax
    8c17:	74 11                	je     8c2a <tp_elem_item+0x2a>
    8c19:	48 8b 34 24          	mov    (%rsp),%rsi
    8c1d:	48 89 df             	mov    %rbx,%rdi
    8c20:	e8 cb 0b 00 00       	call   97f0 <tp_push>
    8c25:	bd 01 00 00 00       	mov    $0x1,%ebp
    8c2a:	89 e8                	mov    %ebp,%eax
    8c2c:	48 83 c4 08          	add    $0x8,%rsp
    8c30:	5b                   	pop    %rbx
    8c31:	5d                   	pop    %rbp
    8c32:	c3                   	ret
    8c33:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8c3a:	84 00 00 00 00 00 

0000000000008c40 <fwp_p_array_from_list>:
    8c40:	41 56                	push   %r14
    8c42:	53                   	push   %rbx
    8c43:	50                   	push   %rax
    8c44:	48 89 fb             	mov    %rdi,%rbx
    8c47:	e8 44 0c 00 00       	call   9890 <fwp_list_len>
    8c4c:	49 89 c6             	mov    %rax,%r14
    8c4f:	48 89 c7             	mov    %rax,%rdi
    8c52:	e8 99 a9 ff ff       	call   35f0 <fwp_arr_new>
    8c57:	4d 85 f6             	test   %r14,%r14
    8c5a:	0f 84 84 00 00 00    	je     8ce4 <fwp_p_array_from_list+0xa4>
    8c60:	44 89 f1             	mov    %r14d,%ecx
    8c63:	83 e1 03             	and    $0x3,%ecx
    8c66:	49 83 fe 04          	cmp    $0x4,%r14
    8c6a:	73 04                	jae    8c70 <fwp_p_array_from_list+0x30>
    8c6c:	31 d2                	xor    %edx,%edx
    8c6e:	eb 4d                	jmp    8cbd <fwp_p_array_from_list+0x7d>
    8c70:	49 83 e6 fc          	and    $0xfffffffffffffffc,%r14
    8c74:	31 d2                	xor    %edx,%edx
    8c76:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    8c7d:	00 00 00 
    8c80:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    8c84:	48 89 74 d0 08       	mov    %rsi,0x8(%rax,%rdx,8)
    8c89:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    8c8d:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
    8c91:	48 89 7c d0 10       	mov    %rdi,0x10(%rax,%rdx,8)
    8c96:	48 8b 76 10          	mov    0x10(%rsi),%rsi
    8c9a:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
    8c9e:	48 89 7c d0 18       	mov    %rdi,0x18(%rax,%rdx,8)
    8ca3:	48 8b 76 10          	mov    0x10(%rsi),%rsi
    8ca7:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
    8cab:	48 89 7c d0 20       	mov    %rdi,0x20(%rax,%rdx,8)
    8cb0:	48 8b 5e 10          	mov    0x10(%rsi),%rbx
    8cb4:	48 83 c2 04          	add    $0x4,%rdx
    8cb8:	49 39 d6             	cmp    %rdx,%r14
    8cbb:	75 c3                	jne    8c80 <fwp_p_array_from_list+0x40>
    8cbd:	48 85 c9             	test   %rcx,%rcx
    8cc0:	74 22                	je     8ce4 <fwp_p_array_from_list+0xa4>
    8cc2:	48 8d 14 d0          	lea    (%rax,%rdx,8),%rdx
    8cc6:	48 83 c2 08          	add    $0x8,%rdx
    8cca:	31 f6                	xor    %esi,%esi
    8ccc:	0f 1f 40 00          	nopl   0x0(%rax)
    8cd0:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    8cd4:	48 89 3c f2          	mov    %rdi,(%rdx,%rsi,8)
    8cd8:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    8cdc:	48 ff c6             	inc    %rsi
    8cdf:	48 39 f1             	cmp    %rsi,%rcx
    8ce2:	75 ec                	jne    8cd0 <fwp_p_array_from_list+0x90>
    8ce4:	48 83 c4 08          	add    $0x8,%rsp
    8ce8:	5b                   	pop    %rbx
    8ce9:	41 5e                	pop    %r14
    8ceb:	c3                   	ret
    8cec:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000008cf0 <tp_kv_item>:
    8cf0:	41 57                	push   %r15
    8cf2:	41 56                	push   %r14
    8cf4:	53                   	push   %rbx
    8cf5:	48 83 ec 10          	sub    $0x10,%rsp
    8cf9:	48 89 f3             	mov    %rsi,%rbx
    8cfc:	49 89 ff             	mov    %rdi,%r15
    8cff:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
    8d06:	00 
    8d07:	48 8b 36             	mov    (%rsi),%rsi
    8d0a:	45 31 f6             	xor    %r14d,%r14d
    8d0d:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    8d12:	31 d2                	xor    %edx,%edx
    8d14:	e8 47 f0 ff ff       	call   7d60 <tp_value>
    8d19:	85 c0                	test   %eax,%eax
    8d1b:	74 27                	je     8d44 <tp_kv_item+0x54>
    8d1d:	45 31 f6             	xor    %r14d,%r14d
    8d20:	83 7b 28 00          	cmpl   $0x0,0x28(%rbx)
    8d24:	74 2b                	je     8d51 <tp_kv_item+0x61>
    8d26:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    8d2b:	48 89 df             	mov    %rbx,%rdi
    8d2e:	e8 bd 0a 00 00       	call   97f0 <tp_push>
    8d33:	48 89 df             	mov    %rbx,%rdi
    8d36:	4c 89 f6             	mov    %r14,%rsi
    8d39:	e8 b2 0a 00 00       	call   97f0 <tp_push>
    8d3e:	41 be 01 00 00 00    	mov    $0x1,%r14d
    8d44:	44 89 f0             	mov    %r14d,%eax
    8d47:	48 83 c4 10          	add    $0x10,%rsp
    8d4b:	5b                   	pop    %rbx
    8d4c:	41 5e                	pop    %r14
    8d4e:	41 5f                	pop    %r15
    8d50:	c3                   	ret
    8d51:	48 8d 35 68 55 00 00 	lea    0x5568(%rip),%rsi        # e2c0 <exec_in_fp0+0xc60>
    8d58:	4c 89 ff             	mov    %r15,%rdi
    8d5b:	e8 f0 fc ff ff       	call   8a50 <tp_eat>
    8d60:	85 c0                	test   %eax,%eax
    8d62:	74 e0                	je     8d44 <tp_kv_item+0x54>
    8d64:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    8d68:	45 31 f6             	xor    %r14d,%r14d
    8d6b:	48 89 e1             	mov    %rsp,%rcx
    8d6e:	4c 89 ff             	mov    %r15,%rdi
    8d71:	31 d2                	xor    %edx,%edx
    8d73:	e8 e8 ef ff ff       	call   7d60 <tp_value>
    8d78:	85 c0                	test   %eax,%eax
    8d7a:	74 c8                	je     8d44 <tp_kv_item+0x54>
    8d7c:	4c 8b 34 24          	mov    (%rsp),%r14
    8d80:	eb a4                	jmp    8d26 <tp_kv_item+0x36>
    8d82:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8d89:	1f 84 00 00 00 00 00 

0000000000008d90 <fwp_p_map_insert>:
    8d90:	55                   	push   %rbp
    8d91:	41 57                	push   %r15
    8d93:	41 56                	push   %r14
    8d95:	41 55                	push   %r13
    8d97:	41 54                	push   %r12
    8d99:	53                   	push   %rbx
    8d9a:	48 83 ec 18          	sub    $0x18,%rsp
    8d9e:	49 89 d6             	mov    %rdx,%r14
    8da1:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    8da6:	48 89 fe             	mov    %rdi,%rsi
    8da9:	48 8d 44 24 04       	lea    0x4(%rsp),%rax
    8dae:	48 89 d7             	mov    %rdx,%rdi
    8db1:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
    8db6:	48 89 ca             	mov    %rcx,%rdx
    8db9:	48 89 c1             	mov    %rax,%rcx
    8dbc:	e8 ef 0a 00 00       	call   98b0 <fwp_map_find>
    8dc1:	48 89 c5             	mov    %rax,%rbp
    8dc4:	4d 8b 3e             	mov    (%r14),%r15
    8dc7:	44 8b 64 24 04       	mov    0x4(%rsp),%r12d
    8dcc:	31 ff                	xor    %edi,%edi
    8dce:	45 85 e4             	test   %r12d,%r12d
    8dd1:	40 0f 94 c7          	sete   %dil
    8dd5:	4c 01 ff             	add    %r15,%rdi
    8dd8:	e8 23 0c 00 00       	call   9a00 <fwp_map_alloc>
    8ddd:	49 89 c5             	mov    %rax,%r13
    8de0:	48 8d 58 08          	lea    0x8(%rax),%rbx
    8de4:	49 83 c6 08          	add    $0x8,%r14
    8de8:	45 85 e4             	test   %r12d,%r12d
    8deb:	74 22                	je     8e0f <fwp_p_map_insert+0x7f>
    8ded:	49 c1 e7 04          	shl    $0x4,%r15
    8df1:	48 89 df             	mov    %rbx,%rdi
    8df4:	4c 89 f6             	mov    %r14,%rsi
    8df7:	4c 89 fa             	mov    %r15,%rdx
    8dfa:	e8 21 95 ff ff       	call   2320 <memcpy@plt>
    8dff:	48 c1 e5 04          	shl    $0x4,%rbp
    8e03:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    8e08:	49 89 44 2d 10       	mov    %rax,0x10(%r13,%rbp,1)
    8e0d:	eb 46                	jmp    8e55 <fwp_p_map_insert+0xc5>
    8e0f:	49 89 ec             	mov    %rbp,%r12
    8e12:	49 c1 e4 04          	shl    $0x4,%r12
    8e16:	48 89 df             	mov    %rbx,%rdi
    8e19:	4c 89 f6             	mov    %r14,%rsi
    8e1c:	4c 89 e2             	mov    %r12,%rdx
    8e1f:	e8 fc 94 ff ff       	call   2320 <memcpy@plt>
    8e24:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    8e29:	4b 89 44 25 08       	mov    %rax,0x8(%r13,%r12,1)
    8e2e:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    8e33:	4b 89 44 25 10       	mov    %rax,0x10(%r13,%r12,1)
    8e38:	4a 8d 3c 23          	lea    (%rbx,%r12,1),%rdi
    8e3c:	48 83 c7 10          	add    $0x10,%rdi
    8e40:	4d 01 f4             	add    %r14,%r12
    8e43:	49 29 ef             	sub    %rbp,%r15
    8e46:	49 c1 e7 04          	shl    $0x4,%r15
    8e4a:	4c 89 e6             	mov    %r12,%rsi
    8e4d:	4c 89 fa             	mov    %r15,%rdx
    8e50:	e8 cb 94 ff ff       	call   2320 <memcpy@plt>
    8e55:	4c 89 e8             	mov    %r13,%rax
    8e58:	48 83 c4 18          	add    $0x18,%rsp
    8e5c:	5b                   	pop    %rbx
    8e5d:	41 5c                	pop    %r12
    8e5f:	41 5d                	pop    %r13
    8e61:	41 5e                	pop    %r14
    8e63:	41 5f                	pop    %r15
    8e65:	5d                   	pop    %rbp
    8e66:	c3                   	ret
    8e67:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    8e6e:	00 00 

0000000000008e70 <fwp_valid_int>:
    8e70:	31 c0                	xor    %eax,%eax
    8e72:	48 85 f6             	test   %rsi,%rsi
    8e75:	74 32                	je     8ea9 <fwp_valid_int+0x39>
    8e77:	0f b6 17             	movzbl (%rdi),%edx
    8e7a:	80 c2 d5             	add    $0xd5,%dl
    8e7d:	31 c9                	xor    %ecx,%ecx
    8e7f:	f6 c2 fd             	test   $0xfd,%dl
    8e82:	0f 94 c1             	sete   %cl
    8e85:	48 39 f1             	cmp    %rsi,%rcx
    8e88:	74 1f                	je     8ea9 <fwp_valid_int+0x39>
    8e8a:	73 18                	jae    8ea4 <fwp_valid_int+0x34>
    8e8c:	0f 1f 40 00          	nopl   0x0(%rax)
    8e90:	0f b6 14 0f          	movzbl (%rdi,%rcx,1),%edx
    8e94:	80 c2 c6             	add    $0xc6,%dl
    8e97:	80 fa f5             	cmp    $0xf5,%dl
    8e9a:	76 0d                	jbe    8ea9 <fwp_valid_int+0x39>
    8e9c:	48 ff c1             	inc    %rcx
    8e9f:	48 39 ce             	cmp    %rcx,%rsi
    8ea2:	75 ec                	jne    8e90 <fwp_valid_int+0x20>
    8ea4:	b8 01 00 00 00       	mov    $0x1,%eax
    8ea9:	c3                   	ret
    8eaa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000008eb0 <tp_record_body>:
    8eb0:	55                   	push   %rbp
    8eb1:	41 57                	push   %r15
    8eb3:	41 56                	push   %r14
    8eb5:	41 55                	push   %r13
    8eb7:	41 54                	push   %r12
    8eb9:	53                   	push   %rbx
    8eba:	48 81 ec 28 01 00 00 	sub    $0x128,%rsp
    8ec1:	48 89 d3             	mov    %rdx,%rbx
    8ec4:	49 89 f5             	mov    %rsi,%r13
    8ec7:	48 89 fd             	mov    %rdi,%rbp
    8eca:	48 63 46 10          	movslq 0x10(%rsi),%rax
    8ece:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    8ed5:	00 
    8ed6:	e8 55 a7 ff ff       	call   3630 <fwp_alloc>
    8edb:	49 89 c7             	mov    %rax,%r15
    8ede:	49 63 7d 10          	movslq 0x10(%r13),%rdi
    8ee2:	48 ff c7             	inc    %rdi
    8ee5:	e8 f6 d5 ff ff       	call   64e0 <fwp_alloc_leaf>
    8eea:	49 89 c4             	mov    %rax,%r12
    8eed:	49 63 55 10          	movslq 0x10(%r13),%rdx
    8ef1:	48 ff c2             	inc    %rdx
    8ef4:	45 31 f6             	xor    %r14d,%r14d
    8ef7:	48 89 c7             	mov    %rax,%rdi
    8efa:	31 f6                	xor    %esi,%esi
    8efc:	e8 ff 92 ff ff       	call   2200 <memset@plt>
    8f01:	48 8d 35 64 54 00 00 	lea    0x5464(%rip),%rsi        # e36c <exec_in_fp0+0xd0c>
    8f08:	48 89 ef             	mov    %rbp,%rdi
    8f0b:	e8 40 fb ff ff       	call   8a50 <tp_eat>
    8f10:	85 c0                	test   %eax,%eax
    8f12:	0f 84 3b 01 00 00    	je     9053 <tp_record_body+0x1a3>
    8f18:	48 8d 35 81 54 00 00 	lea    0x5481(%rip),%rsi        # e3a0 <exec_in_fp0+0xd40>
    8f1f:	48 89 ef             	mov    %rbp,%rdi
    8f22:	e8 29 fb ff ff       	call   8a50 <tp_eat>
    8f27:	85 c0                	test   %eax,%eax
    8f29:	74 3e                	je     8f69 <tp_record_body+0xb9>
    8f2b:	41 8b 7d 10          	mov    0x10(%r13),%edi
    8f2f:	85 ff                	test   %edi,%edi
    8f31:	7e 20                	jle    8f53 <tp_record_body+0xa3>
    8f33:	45 31 f6             	xor    %r14d,%r14d
    8f36:	31 c0                	xor    %eax,%eax
    8f38:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    8f3f:	00 
    8f40:	41 80 3c 04 00       	cmpb   $0x0,(%r12,%rax,1)
    8f45:	0f 84 08 01 00 00    	je     9053 <tp_record_body+0x1a3>
    8f4b:	48 ff c0             	inc    %rax
    8f4e:	48 39 c7             	cmp    %rax,%rdi
    8f51:	75 ed                	jne    8f40 <tp_record_body+0x90>
    8f53:	4c 89 fe             	mov    %r15,%rsi
    8f56:	e8 d5 a3 ff ff       	call   3330 <fwp_record>
    8f5b:	48 89 03             	mov    %rax,(%rbx)
    8f5e:	41 be 01 00 00 00    	mov    $0x1,%r14d
    8f64:	e9 ea 00 00 00       	jmp    9053 <tp_record_body+0x1a3>
    8f69:	48 89 1c 24          	mov    %rbx,(%rsp)
    8f6d:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8f72:	48 89 ef             	mov    %rbp,%rdi
    8f75:	e8 06 01 00 00       	call   9080 <tp_ident>
    8f7a:	41 8b 45 10          	mov    0x10(%r13),%eax
    8f7e:	85 c0                	test   %eax,%eax
    8f80:	0f 8e ca 00 00 00    	jle    9050 <tp_record_body+0x1a0>
    8f86:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    8f8b:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    8f90:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
    8f95:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    8f9a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8fa0:	4d 8b 65 18          	mov    0x18(%r13),%r12
    8fa4:	41 89 c7             	mov    %eax,%r15d
    8fa7:	41 be ff ff ff ff    	mov    $0xffffffff,%r14d
    8fad:	31 ed                	xor    %ebp,%ebp
    8faf:	90                   	nop
    8fb0:	49 8b 3c ec          	mov    (%r12,%rbp,8),%rdi
    8fb4:	48 89 de             	mov    %rbx,%rsi
    8fb7:	e8 04 93 ff ff       	call   22c0 <strcmp@plt>
    8fbc:	85 c0                	test   %eax,%eax
    8fbe:	44 0f 44 f5          	cmove  %ebp,%r14d
    8fc2:	48 ff c5             	inc    %rbp
    8fc5:	49 39 ef             	cmp    %rbp,%r15
    8fc8:	75 e6                	jne    8fb0 <tp_record_body+0x100>
    8fca:	45 85 f6             	test   %r14d,%r14d
    8fcd:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    8fd2:	4c 8b 64 24 10       	mov    0x10(%rsp),%r12
    8fd7:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    8fdc:	78 72                	js     9050 <tp_record_body+0x1a0>
    8fde:	48 89 ef             	mov    %rbp,%rdi
    8fe1:	48 8d 35 da 52 00 00 	lea    0x52da(%rip),%rsi        # e2c2 <exec_in_fp0+0xc62>
    8fe8:	e8 63 fa ff ff       	call   8a50 <tp_eat>
    8fed:	85 c0                	test   %eax,%eax
    8fef:	74 5f                	je     9050 <tp_record_body+0x1a0>
    8ff1:	49 8b 45 20          	mov    0x20(%r13),%rax
    8ff5:	45 89 f6             	mov    %r14d,%r14d
    8ff8:	4a 8b 34 f0          	mov    (%rax,%r14,8),%rsi
    8ffc:	4b 8d 0c f7          	lea    (%r15,%r14,8),%rcx
    9000:	48 89 ef             	mov    %rbp,%rdi
    9003:	31 d2                	xor    %edx,%edx
    9005:	e8 56 ed ff ff       	call   7d60 <tp_value>
    900a:	85 c0                	test   %eax,%eax
    900c:	74 42                	je     9050 <tp_record_body+0x1a0>
    900e:	43 c6 04 34 01       	movb   $0x1,(%r12,%r14,1)
    9013:	48 89 ef             	mov    %rbp,%rdi
    9016:	48 8d 35 83 53 00 00 	lea    0x5383(%rip),%rsi        # e3a0 <exec_in_fp0+0xd40>
    901d:	e8 2e fa ff ff       	call   8a50 <tp_eat>
    9022:	85 c0                	test   %eax,%eax
    9024:	75 42                	jne    9068 <tp_record_body+0x1b8>
    9026:	48 89 ef             	mov    %rbp,%rdi
    9029:	48 8d 35 7c 52 00 00 	lea    0x527c(%rip),%rsi        # e2ac <exec_in_fp0+0xc4c>
    9030:	e8 1b fa ff ff       	call   8a50 <tp_eat>
    9035:	85 c0                	test   %eax,%eax
    9037:	74 17                	je     9050 <tp_record_body+0x1a0>
    9039:	48 89 ef             	mov    %rbp,%rdi
    903c:	48 89 de             	mov    %rbx,%rsi
    903f:	e8 3c 00 00 00       	call   9080 <tp_ident>
    9044:	41 8b 45 10          	mov    0x10(%r13),%eax
    9048:	85 c0                	test   %eax,%eax
    904a:	0f 8f 50 ff ff ff    	jg     8fa0 <tp_record_body+0xf0>
    9050:	45 31 f6             	xor    %r14d,%r14d
    9053:	44 89 f0             	mov    %r14d,%eax
    9056:	48 81 c4 28 01 00 00 	add    $0x128,%rsp
    905d:	5b                   	pop    %rbx
    905e:	41 5c                	pop    %r12
    9060:	41 5d                	pop    %r13
    9062:	41 5e                	pop    %r14
    9064:	41 5f                	pop    %r15
    9066:	5d                   	pop    %rbp
    9067:	c3                   	ret
    9068:	48 8b 1c 24          	mov    (%rsp),%rbx
    906c:	e9 ba fe ff ff       	jmp    8f2b <tp_record_body+0x7b>
    9071:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9078:	0f 1f 84 00 00 00 00 
    907f:	00 

0000000000009080 <tp_ident>:
    9080:	41 56                	push   %r14
    9082:	53                   	push   %rbx
    9083:	50                   	push   %rax
    9084:	48 89 f3             	mov    %rsi,%rbx
    9087:	49 89 fe             	mov    %rdi,%r14
    908a:	e8 01 f6 ff ff       	call   8690 <tp_ws>
    908f:	49 8b 46 10          	mov    0x10(%r14),%rax
    9093:	49 8b 36             	mov    (%r14),%rsi
    9096:	49 8b 56 08          	mov    0x8(%r14),%rdx
    909a:	48 89 c1             	mov    %rax,%rcx
    909d:	48 39 d0             	cmp    %rdx,%rax
    90a0:	73 63                	jae    9105 <tp_ident+0x85>
    90a2:	48 bf 03 00 00 00 00 	movabs $0x4000000000003,%rdi
    90a9:	00 04 00 
    90ac:	48 89 c1             	mov    %rax,%rcx
    90af:	eb 1b                	jmp    90cc <tp_ident+0x4c>
    90b1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    90b8:	0f 1f 84 00 00 00 00 
    90bf:	00 
    90c0:	48 ff c1             	inc    %rcx
    90c3:	49 89 4e 10          	mov    %rcx,0x10(%r14)
    90c7:	48 39 ca             	cmp    %rcx,%rdx
    90ca:	74 36                	je     9102 <tp_ident+0x82>
    90cc:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
    90d1:	45 8d 48 d0          	lea    -0x30(%r8),%r9d
    90d5:	41 80 f9 0a          	cmp    $0xa,%r9b
    90d9:	72 e5                	jb     90c0 <tp_ident+0x40>
    90db:	45 89 c1             	mov    %r8d,%r9d
    90de:	41 80 e1 df          	and    $0xdf,%r9b
    90e2:	41 80 c1 bf          	add    $0xbf,%r9b
    90e6:	41 80 f9 1a          	cmp    $0x1a,%r9b
    90ea:	72 d4                	jb     90c0 <tp_ident+0x40>
    90ec:	45 0f b6 c0          	movzbl %r8b,%r8d
    90f0:	41 83 c0 d3          	add    $0xffffffd3,%r8d
    90f4:	41 83 f8 32          	cmp    $0x32,%r8d
    90f8:	77 0b                	ja     9105 <tp_ident+0x85>
    90fa:	4c 0f a3 c7          	bt     %r8,%rdi
    90fe:	72 c0                	jb     90c0 <tp_ident+0x40>
    9100:	eb 03                	jmp    9105 <tp_ident+0x85>
    9102:	48 89 d1             	mov    %rdx,%rcx
    9105:	48 29 c1             	sub    %rax,%rcx
    9108:	48 81 f9 ff 00 00 00 	cmp    $0xff,%rcx
    910f:	41 be ff 00 00 00    	mov    $0xff,%r14d
    9115:	4c 0f 42 f1          	cmovb  %rcx,%r14
    9119:	48 01 c6             	add    %rax,%rsi
    911c:	48 89 df             	mov    %rbx,%rdi
    911f:	4c 89 f2             	mov    %r14,%rdx
    9122:	e8 f9 91 ff ff       	call   2320 <memcpy@plt>
    9127:	42 c6 04 33 00       	movb   $0x0,(%rbx,%r14,1)
    912c:	48 83 c4 08          	add    $0x8,%rsp
    9130:	5b                   	pop    %rbx
    9131:	41 5e                	pop    %r14
    9133:	c3                   	ret
    9134:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    913b:	00 00 00 00 00 

0000000000009140 <tp_atom>:
    9140:	41 57                	push   %r15
    9142:	41 56                	push   %r14
    9144:	53                   	push   %rbx
    9145:	49 89 d6             	mov    %rdx,%r14
    9148:	49 89 f7             	mov    %rsi,%r15
    914b:	48 89 fb             	mov    %rdi,%rbx
    914e:	e8 3d f5 ff ff       	call   8690 <tp_ws>
    9153:	41 83 3f 10          	cmpl   $0x10,(%r15)
    9157:	75 07                	jne    9160 <tp_atom+0x20>
    9159:	49 83 7f 08 00       	cmpq   $0x0,0x8(%r15)
    915e:	74 5e                	je     91be <tp_atom+0x7e>
    9160:	31 c0                	xor    %eax,%eax
    9162:	48 8b 4b 10          	mov    0x10(%rbx),%rcx
    9166:	48 3b 4b 08          	cmp    0x8(%rbx),%rcx
    916a:	73 0e                	jae    917a <tp_atom+0x3a>
    916c:	48 8b 13             	mov    (%rbx),%rdx
    916f:	80 3c 0a 28          	cmpb   $0x28,(%rdx,%rcx,1)
    9173:	0f 95 c2             	setne  %dl
    9176:	08 c2                	or     %al,%dl
    9178:	74 15                	je     918f <tp_atom+0x4f>
    917a:	48 89 df             	mov    %rbx,%rdi
    917d:	4c 89 fe             	mov    %r15,%rsi
    9180:	31 d2                	xor    %edx,%edx
    9182:	4c 89 f1             	mov    %r14,%rcx
    9185:	5b                   	pop    %rbx
    9186:	41 5e                	pop    %r14
    9188:	41 5f                	pop    %r15
    918a:	e9 d1 eb ff ff       	jmp    7d60 <tp_value>
    918f:	48 ff c1             	inc    %rcx
    9192:	48 89 4b 10          	mov    %rcx,0x10(%rbx)
    9196:	48 89 df             	mov    %rbx,%rdi
    9199:	4c 89 fe             	mov    %r15,%rsi
    919c:	31 d2                	xor    %edx,%edx
    919e:	4c 89 f1             	mov    %r14,%rcx
    91a1:	e8 ba eb ff ff       	call   7d60 <tp_value>
    91a6:	85 c0                	test   %eax,%eax
    91a8:	74 25                	je     91cf <tp_atom+0x8f>
    91aa:	48 8d 35 be 51 00 00 	lea    0x51be(%rip),%rsi        # e36f <exec_in_fp0+0xd0f>
    91b1:	48 89 df             	mov    %rbx,%rdi
    91b4:	5b                   	pop    %rbx
    91b5:	41 5e                	pop    %r14
    91b7:	41 5f                	pop    %r15
    91b9:	e9 92 f8 ff ff       	jmp    8a50 <tp_eat>
    91be:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    91c3:	74 12                	je     91d7 <tp_atom+0x97>
    91c5:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
    91ca:	0f 95 c0             	setne  %al
    91cd:	eb 93                	jmp    9162 <tp_atom+0x22>
    91cf:	31 c0                	xor    %eax,%eax
    91d1:	5b                   	pop    %rbx
    91d2:	41 5e                	pop    %r14
    91d4:	41 5f                	pop    %r15
    91d6:	c3                   	ret
    91d7:	b0 01                	mov    $0x1,%al
    91d9:	eb 87                	jmp    9162 <tp_atom+0x22>
    91db:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000091e0 <fwp_cstr>:
    91e0:	53                   	push   %rbx
    91e1:	48 89 fb             	mov    %rdi,%rbx
    91e4:	e8 77 8f ff ff       	call   2160 <strlen@plt>
    91e9:	48 89 df             	mov    %rbx,%rdi
    91ec:	48 89 c6             	mov    %rax,%rsi
    91ef:	5b                   	pop    %rbx
    91f0:	e9 ab e4 ff ff       	jmp    76a0 <fwp_str_new>
    91f5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    91fc:	00 00 00 00 

0000000000009200 <fwp_p_parse_int>:
    9200:	55                   	push   %rbp
    9201:	41 57                	push   %r15
    9203:	41 56                	push   %r14
    9205:	41 55                	push   %r13
    9207:	41 54                	push   %r12
    9209:	53                   	push   %rbx
    920a:	48 83 ec 18          	sub    $0x18,%rsp
    920e:	89 d3                	mov    %edx,%ebx
    9210:	89 f5                	mov    %esi,%ebp
    9212:	49 89 fe             	mov    %rdi,%r14
    9215:	4c 8b 3f             	mov    (%rdi),%r15
    9218:	49 83 c6 08          	add    $0x8,%r14
    921c:	4c 89 f7             	mov    %r14,%rdi
    921f:	4c 89 fe             	mov    %r15,%rsi
    9222:	e8 49 fc ff ff       	call   8e70 <fwp_valid_int>
    9227:	85 c0                	test   %eax,%eax
    9229:	0f 84 1a 01 00 00    	je     9349 <fwp_p_parse_int+0x149>
    922f:	41 0f b6 06          	movzbl (%r14),%eax
    9233:	31 ff                	xor    %edi,%edi
    9235:	3c 2d                	cmp    $0x2d,%al
    9237:	0f 94 c1             	sete   %cl
    923a:	3c 2b                	cmp    $0x2b,%al
    923c:	0f 94 c0             	sete   %al
    923f:	08 c8                	or     %cl,%al
    9241:	44 0f b6 e0          	movzbl %al,%r12d
    9245:	4d 39 e7             	cmp    %r12,%r15
    9248:	0f 86 d0 00 00 00    	jbe    931e <fwp_p_parse_int+0x11e>
    924e:	88 4c 24 07          	mov    %cl,0x7(%rsp)
    9252:	89 6c 24 08          	mov    %ebp,0x8(%rsp)
    9256:	89 5c 24 0c          	mov    %ebx,0xc(%rsp)
    925a:	bf 0a 00 00 00       	mov    $0xa,%edi
    925f:	48 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rbx
    9266:	cc cc cc 
    9269:	48 bd cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbp
    9270:	cc cc cc 
    9273:	31 f6                	xor    %esi,%esi
    9275:	45 31 db             	xor    %r11d,%r11d
    9278:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    927f:	00 
    9280:	4d 89 dd             	mov    %r11,%r13
    9283:	49 89 f0             	mov    %rsi,%r8
    9286:	48 89 f0             	mov    %rsi,%rax
    9289:	48 f7 e7             	mul    %rdi
    928c:	4b 8d 0c 9b          	lea    (%r11,%r11,4),%rcx
    9290:	48 8d 0c 4a          	lea    (%rdx,%rcx,2),%rcx
    9294:	43 0f be 14 26       	movsbl (%r14,%r12,1),%edx
    9299:	83 c2 d0             	add    $0xffffffd0,%edx
    929c:	48 63 d2             	movslq %edx,%rdx
    929f:	49 89 d3             	mov    %rdx,%r11
    92a2:	49 c1 fb 3f          	sar    $0x3f,%r11
    92a6:	48 89 c6             	mov    %rax,%rsi
    92a9:	48 01 d6             	add    %rdx,%rsi
    92ac:	49 11 cb             	adc    %rcx,%r11
    92af:	4d 89 d9             	mov    %r11,%r9
    92b2:	49 0f a4 f1 3f       	shld   $0x3f,%rsi,%r9
    92b7:	4c 89 d9             	mov    %r11,%rcx
    92ba:	48 d1 e9             	shr    $1,%rcx
    92bd:	4d 89 ca             	mov    %r9,%r10
    92c0:	49 01 ca             	add    %rcx,%r10
    92c3:	49 83 d2 00          	adc    $0x0,%r10
    92c7:	4c 89 d0             	mov    %r10,%rax
    92ca:	48 f7 e3             	mul    %rbx
    92cd:	48 c1 ea 02          	shr    $0x2,%rdx
    92d1:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    92d5:	49 29 c2             	sub    %rax,%r10
    92d8:	4d 29 d1             	sub    %r10,%r9
    92db:	48 83 d9 00          	sbb    $0x0,%rcx
    92df:	4d 89 ca             	mov    %r9,%r10
    92e2:	4c 0f af d5          	imul   %rbp,%r10
    92e6:	4c 89 c8             	mov    %r9,%rax
    92e9:	48 f7 e3             	mul    %rbx
    92ec:	4c 01 d2             	add    %r10,%rdx
    92ef:	48 0f af cb          	imul   %rbx,%rcx
    92f3:	48 01 d1             	add    %rdx,%rcx
    92f6:	4c 31 e9             	xor    %r13,%rcx
    92f9:	4c 31 c0             	xor    %r8,%rax
    92fc:	48 09 c8             	or     %rcx,%rax
    92ff:	75 48                	jne    9349 <fwp_p_parse_int+0x149>
    9301:	49 ff c4             	inc    %r12
    9304:	4d 39 e7             	cmp    %r12,%r15
    9307:	0f 85 73 ff ff ff    	jne    9280 <fwp_p_parse_int+0x80>
    930d:	8b 5c 24 0c          	mov    0xc(%rsp),%ebx
    9311:	8b 6c 24 08          	mov    0x8(%rsp),%ebp
    9315:	31 ff                	xor    %edi,%edi
    9317:	0f b6 4c 24 07       	movzbl 0x7(%rsp),%ecx
    931c:	eb 05                	jmp    9323 <fwp_p_parse_int+0x123>
    931e:	31 f6                	xor    %esi,%esi
    9320:	45 31 db             	xor    %r11d,%r11d
    9323:	40 88 cf             	mov    %cl,%dil
    9326:	4c 8d 4c 24 10       	lea    0x10(%rsp),%r9
    932b:	4c 89 da             	mov    %r11,%rdx
    932e:	89 e9                	mov    %ebp,%ecx
    9330:	41 89 d8             	mov    %ebx,%r8d
    9333:	e8 28 00 00 00       	call   9360 <fwp_int_in_range>
    9338:	48 85 c0             	test   %rax,%rax
    933b:	74 0c                	je     9349 <fwp_p_parse_int+0x149>
    933d:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    9342:	e8 99 00 00 00       	call   93e0 <fwp_some>
    9347:	eb 02                	jmp    934b <fwp_p_parse_int+0x14b>
    9349:	31 c0                	xor    %eax,%eax
    934b:	48 83 c4 18          	add    $0x18,%rsp
    934f:	5b                   	pop    %rbx
    9350:	41 5c                	pop    %r12
    9352:	41 5d                	pop    %r13
    9354:	41 5e                	pop    %r14
    9356:	41 5f                	pop    %r15
    9358:	5d                   	pop    %rbp
    9359:	c3                   	ret
    935a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000009360 <fwp_int_in_range>:
    9360:	53                   	push   %rbx
    9361:	83 f9 09             	cmp    $0x9,%ecx
    9364:	75 24                	jne    938a <fwp_int_in_range+0x2a>
    9366:	85 ff                	test   %edi,%edi
    9368:	74 08                	je     9372 <fwp_int_in_range+0x12>
    936a:	48 89 f0             	mov    %rsi,%rax
    936d:	48 09 d0             	or     %rdx,%rax
    9370:	75 3c                	jne    93ae <fwp_int_in_range+0x4e>
    9372:	48 89 f7             	mov    %rsi,%rdi
    9375:	48 89 d6             	mov    %rdx,%rsi
    9378:	4c 89 cb             	mov    %r9,%rbx
    937b:	e8 80 00 00 00       	call   9400 <fwp_box_u128>
    9380:	48 89 03             	mov    %rax,(%rbx)
    9383:	b8 01 00 00 00       	mov    $0x1,%eax
    9388:	5b                   	pop    %rbx
    9389:	c3                   	ret
    938a:	48 89 f0             	mov    %rsi,%rax
    938d:	48 f7 d8             	neg    %rax
    9390:	48 b8 00 00 00 00 00 	movabs $0x8000000000000000,%rax
    9397:	00 00 80 
    939a:	49 89 c2             	mov    %rax,%r10
    939d:	49 19 d2             	sbb    %rdx,%r10
    93a0:	72 0c                	jb     93ae <fwp_int_in_range+0x4e>
    93a2:	85 ff                	test   %edi,%edi
    93a4:	75 0c                	jne    93b2 <fwp_int_in_range+0x52>
    93a6:	48 31 d0             	xor    %rdx,%rax
    93a9:	48 09 f0             	or     %rsi,%rax
    93ac:	75 04                	jne    93b2 <fwp_int_in_range+0x52>
    93ae:	31 c0                	xor    %eax,%eax
    93b0:	5b                   	pop    %rbx
    93b1:	c3                   	ret
    93b2:	31 c0                	xor    %eax,%eax
    93b4:	49 89 f2             	mov    %rsi,%r10
    93b7:	49 f7 da             	neg    %r10
    93ba:	48 19 d0             	sbb    %rdx,%rax
    93bd:	85 ff                	test   %edi,%edi
    93bf:	4c 0f 44 d6          	cmove  %rsi,%r10
    93c3:	48 0f 44 c2          	cmove  %rdx,%rax
    93c7:	4c 89 d7             	mov    %r10,%rdi
    93ca:	48 89 c6             	mov    %rax,%rsi
    93cd:	89 ca                	mov    %ecx,%edx
    93cf:	44 89 c1             	mov    %r8d,%ecx
    93d2:	4d 89 c8             	mov    %r9,%r8
    93d5:	e8 56 00 00 00       	call   9430 <fwp_int_fits>
    93da:	89 c0                	mov    %eax,%eax
    93dc:	5b                   	pop    %rbx
    93dd:	c3                   	ret
    93de:	66 90                	xchg   %ax,%ax

00000000000093e0 <fwp_some>:
    93e0:	50                   	push   %rax
    93e1:	48 89 3c 24          	mov    %rdi,(%rsp)
    93e5:	48 89 e2             	mov    %rsp,%rdx
    93e8:	bf 01 00 00 00       	mov    $0x1,%edi
    93ed:	be 01 00 00 00       	mov    $0x1,%esi
    93f2:	e8 c9 c2 ff ff       	call   56c0 <fwp_data>
    93f7:	59                   	pop    %rcx
    93f8:	c3                   	ret
    93f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000009400 <fwp_box_u128>:
    9400:	41 56                	push   %r14
    9402:	53                   	push   %rbx
    9403:	50                   	push   %rax
    9404:	48 89 f3             	mov    %rsi,%rbx
    9407:	49 89 fe             	mov    %rdi,%r14
    940a:	bf 10 00 00 00       	mov    $0x10,%edi
    940f:	e8 cc d0 ff ff       	call   64e0 <fwp_alloc_leaf>
    9414:	48 89 58 08          	mov    %rbx,0x8(%rax)
    9418:	4c 89 30             	mov    %r14,(%rax)
    941b:	48 83 c4 08          	add    $0x8,%rsp
    941f:	5b                   	pop    %rbx
    9420:	41 5e                	pop    %r14
    9422:	c3                   	ret
    9423:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    942a:	84 00 00 00 00 00 

0000000000009430 <fwp_int_fits>:
    9430:	41 57                	push   %r15
    9432:	41 56                	push   %r14
    9434:	53                   	push   %rbx
    9435:	31 c0                	xor    %eax,%eax
    9437:	83 fa 14             	cmp    $0x14,%edx
    943a:	0f 87 02 01 00 00    	ja     9542 <fwp_int_fits+0x112>
    9440:	89 d2                	mov    %edx,%edx
    9442:	4c 8d 0d 5f 3e 00 00 	lea    0x3e5f(%rip),%r9        # d2a8 <_IO_stdin_used+0x2a8>
    9449:	49 63 14 91          	movslq (%r9,%rdx,4),%rdx
    944d:	4c 01 ca             	add    %r9,%rdx
    9450:	ff e2                	jmp    *%rdx
    9452:	48 89 f9             	mov    %rdi,%rcx
    9455:	48 83 c1 80          	add    $0xffffffffffffff80,%rcx
    9459:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    945d:	48 81 f9 00 ff ff ff 	cmp    $0xffffffffffffff00,%rcx
    9464:	eb 3b                	jmp    94a1 <fwp_int_fits+0x71>
    9466:	48 89 f9             	mov    %rdi,%rcx
    9469:	48 81 c1 00 00 00 80 	add    $0xffffffff80000000,%rcx
    9470:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    9474:	48 ba 00 00 00 00 ff 	movabs $0xffffffff00000000,%rdx
    947b:	ff ff ff 
    947e:	48 39 d1             	cmp    %rdx,%rcx
    9481:	eb 1e                	jmp    94a1 <fwp_int_fits+0x71>
    9483:	31 c0                	xor    %eax,%eax
    9485:	b9 ff 00 00 00       	mov    $0xff,%ecx
    948a:	eb 2b                	jmp    94b7 <fwp_int_fits+0x87>
    948c:	48 89 f9             	mov    %rdi,%rcx
    948f:	48 81 c1 00 80 ff ff 	add    $0xffffffffffff8000,%rcx
    9496:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    949a:	48 81 f9 00 00 ff ff 	cmp    $0xffffffffffff0000,%rcx
    94a1:	48 83 de ff          	sbb    $0xffffffffffffffff,%rsi
    94a5:	0f 83 8f 00 00 00    	jae    953a <fwp_int_fits+0x10a>
    94ab:	e9 92 00 00 00       	jmp    9542 <fwp_int_fits+0x112>
    94b0:	31 c0                	xor    %eax,%eax
    94b2:	b9 ff ff 00 00       	mov    $0xffff,%ecx
    94b7:	48 39 f9             	cmp    %rdi,%rcx
    94ba:	b9 00 00 00 00       	mov    $0x0,%ecx
    94bf:	48 19 f1             	sbb    %rsi,%rcx
    94c2:	73 76                	jae    953a <fwp_int_fits+0x10a>
    94c4:	eb 7c                	jmp    9542 <fwp_int_fits+0x112>
    94c6:	48 89 f9             	mov    %rdi,%rcx
    94c9:	48 c1 e9 20          	shr    $0x20,%rcx
    94cd:	48 09 f1             	or     %rsi,%rcx
    94d0:	74 68                	je     953a <fwp_int_fits+0x10a>
    94d2:	eb 6e                	jmp    9542 <fwp_int_fits+0x112>
    94d4:	48 b9 00 00 00 00 00 	movabs $0x8000000000000000,%rcx
    94db:	00 00 80 
    94de:	48 01 f9             	add    %rdi,%rcx
    94e1:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    94e5:	48 83 fe ff          	cmp    $0xffffffffffffffff,%rsi
    94e9:	74 4f                	je     953a <fwp_int_fits+0x10a>
    94eb:	eb 55                	jmp    9542 <fwp_int_fits+0x112>
    94ed:	4c 89 c3             	mov    %r8,%rbx
    94f0:	e8 5b 00 00 00       	call   9550 <fwp_box_i128>
    94f5:	49 89 d8             	mov    %rbx,%r8
    94f8:	48 89 c7             	mov    %rax,%rdi
    94fb:	eb 3d                	jmp    953a <fwp_int_fits+0x10a>
    94fd:	4c 89 c3             	mov    %r8,%rbx
    9500:	49 89 fe             	mov    %rdi,%r14
    9503:	89 cf                	mov    %ecx,%edi
    9505:	49 89 f7             	mov    %rsi,%r15
    9508:	e8 73 00 00 00       	call   9580 <fwp_tint_max>
    950d:	48 89 c1             	mov    %rax,%rcx
    9510:	31 c0                	xor    %eax,%eax
    9512:	49 89 c8             	mov    %rcx,%r8
    9515:	49 f7 d8             	neg    %r8
    9518:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    951e:	49 19 d1             	sbb    %rdx,%r9
    9521:	4c 39 f1             	cmp    %r14,%rcx
    9524:	4c 19 fa             	sbb    %r15,%rdx
    9527:	7c 19                	jl     9542 <fwp_int_fits+0x112>
    9529:	4c 89 fe             	mov    %r15,%rsi
    952c:	4c 89 f7             	mov    %r14,%rdi
    952f:	4d 39 c6             	cmp    %r8,%r14
    9532:	4c 19 ce             	sbb    %r9,%rsi
    9535:	49 89 d8             	mov    %rbx,%r8
    9538:	7c 08                	jl     9542 <fwp_int_fits+0x112>
    953a:	49 89 38             	mov    %rdi,(%r8)
    953d:	b8 01 00 00 00       	mov    $0x1,%eax
    9542:	5b                   	pop    %rbx
    9543:	41 5e                	pop    %r14
    9545:	41 5f                	pop    %r15
    9547:	c3                   	ret
    9548:	48 85 f6             	test   %rsi,%rsi
    954b:	74 ed                	je     953a <fwp_int_fits+0x10a>
    954d:	eb f3                	jmp    9542 <fwp_int_fits+0x112>
    954f:	90                   	nop

0000000000009550 <fwp_box_i128>:
    9550:	41 56                	push   %r14
    9552:	53                   	push   %rbx
    9553:	50                   	push   %rax
    9554:	48 89 f3             	mov    %rsi,%rbx
    9557:	49 89 fe             	mov    %rdi,%r14
    955a:	bf 10 00 00 00       	mov    $0x10,%edi
    955f:	e8 7c cf ff ff       	call   64e0 <fwp_alloc_leaf>
    9564:	48 89 58 08          	mov    %rbx,0x8(%rax)
    9568:	4c 89 30             	mov    %r14,(%rax)
    956b:	48 83 c4 08          	add    $0x8,%rsp
    956f:	5b                   	pop    %rbx
    9570:	41 5e                	pop    %r14
    9572:	c3                   	ret
    9573:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    957a:	84 00 00 00 00 00 

0000000000009580 <fwp_tint_max>:
    9580:	85 ff                	test   %edi,%edi
    9582:	7e 27                	jle    95ab <fwp_tint_max+0x2b>
    9584:	8d 47 ff             	lea    -0x1(%rdi),%eax
    9587:	83 f8 4f             	cmp    $0x4f,%eax
    958a:	41 b8 4f 00 00 00    	mov    $0x4f,%r8d
    9590:	44 0f 42 c0          	cmovb  %eax,%r8d
    9594:	41 ff c0             	inc    %r8d
    9597:	44 89 c6             	mov    %r8d,%esi
    959a:	83 e6 07             	and    $0x7,%esi
    959d:	83 ff 08             	cmp    $0x8,%edi
    95a0:	73 11                	jae    95b3 <fwp_tint_max+0x33>
    95a2:	b8 01 00 00 00       	mov    $0x1,%eax
    95a7:	31 c9                	xor    %ecx,%ecx
    95a9:	eb 38                	jmp    95e3 <fwp_tint_max+0x63>
    95ab:	31 c0                	xor    %eax,%eax
    95ad:	31 c9                	xor    %ecx,%ecx
    95af:	48 89 ca             	mov    %rcx,%rdx
    95b2:	c3                   	ret
    95b3:	41 81 e0 f8 00 00 00 	and    $0xf8,%r8d
    95ba:	b8 01 00 00 00       	mov    $0x1,%eax
    95bf:	31 c9                	xor    %ecx,%ecx
    95c1:	bf a1 19 00 00       	mov    $0x19a1,%edi
    95c6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    95cd:	00 00 00 
    95d0:	48 f7 e7             	mul    %rdi
    95d3:	48 69 c9 a1 19 00 00 	imul   $0x19a1,%rcx,%rcx
    95da:	48 01 d1             	add    %rdx,%rcx
    95dd:	41 83 c0 f8          	add    $0xfffffff8,%r8d
    95e1:	75 ed                	jne    95d0 <fwp_tint_max+0x50>
    95e3:	85 f6                	test   %esi,%esi
    95e5:	74 17                	je     95fe <fwp_tint_max+0x7e>
    95e7:	bf 03 00 00 00       	mov    $0x3,%edi
    95ec:	0f 1f 40 00          	nopl   0x0(%rax)
    95f0:	48 f7 e7             	mul    %rdi
    95f3:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    95f7:	48 01 d1             	add    %rdx,%rcx
    95fa:	ff ce                	dec    %esi
    95fc:	75 f2                	jne    95f0 <fwp_tint_max+0x70>
    95fe:	48 83 c0 ff          	add    $0xffffffffffffffff,%rax
    9602:	48 83 d1 ff          	adc    $0xffffffffffffffff,%rcx
    9606:	48 89 ca             	mov    %rcx,%rdx
    9609:	48 c1 ea 3f          	shr    $0x3f,%rdx
    960d:	48 01 c2             	add    %rax,%rdx
    9610:	48 89 d0             	mov    %rdx,%rax
    9613:	48 83 d1 00          	adc    $0x0,%rcx
    9617:	48 0f ac c8 01       	shrd   $0x1,%rcx,%rax
    961c:	48 d1 f9             	sar    $1,%rcx
    961f:	48 89 ca             	mov    %rcx,%rdx
    9622:	c3                   	ret
    9623:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    962a:	84 00 00 00 00 00 

0000000000009630 <fwp_valid_float>:
    9630:	48 85 f6             	test   %rsi,%rsi
    9633:	74 0e                	je     9643 <fwp_valid_float+0x13>
    9635:	0f b6 07             	movzbl (%rdi),%eax
    9638:	04 d5                	add    $0xd5,%al
    963a:	31 d2                	xor    %edx,%edx
    963c:	a8 fd                	test   $0xfd,%al
    963e:	0f 94 c2             	sete   %dl
    9641:	eb 02                	jmp    9645 <fwp_valid_float+0x15>
    9643:	31 d2                	xor    %edx,%edx
    9645:	41 b1 01             	mov    $0x1,%r9b
    9648:	49 89 d0             	mov    %rdx,%r8
    964b:	48 39 f2             	cmp    %rsi,%rdx
    964e:	73 1d                	jae    966d <fwp_valid_float+0x3d>
    9650:	42 0f b6 04 07       	movzbl (%rdi,%r8,1),%eax
    9655:	8d 48 d0             	lea    -0x30(%rax),%ecx
    9658:	80 f9 09             	cmp    $0x9,%cl
    965b:	77 15                	ja     9672 <fwp_valid_float+0x42>
    965d:	49 ff c0             	inc    %r8
    9660:	4c 39 c6             	cmp    %r8,%rsi
    9663:	75 eb                	jne    9650 <fwp_valid_float+0x20>
    9665:	49 89 f0             	mov    %rsi,%r8
    9668:	48 89 f1             	mov    %rsi,%rcx
    966b:	eb 38                	jmp    96a5 <fwp_valid_float+0x75>
    966d:	48 89 d1             	mov    %rdx,%rcx
    9670:	eb 33                	jmp    96a5 <fwp_valid_float+0x75>
    9672:	3c 2e                	cmp    $0x2e,%al
    9674:	75 2c                	jne    96a2 <fwp_valid_float+0x72>
    9676:	49 8d 48 01          	lea    0x1(%r8),%rcx
    967a:	48 39 f1             	cmp    %rsi,%rcx
    967d:	73 16                	jae    9695 <fwp_valid_float+0x65>
    967f:	90                   	nop
    9680:	0f b6 04 0f          	movzbl (%rdi,%rcx,1),%eax
    9684:	04 d0                	add    $0xd0,%al
    9686:	3c 09                	cmp    $0x9,%al
    9688:	77 0b                	ja     9695 <fwp_valid_float+0x65>
    968a:	48 ff c1             	inc    %rcx
    968d:	48 39 f1             	cmp    %rsi,%rcx
    9690:	72 ee                	jb     9680 <fwp_valid_float+0x50>
    9692:	48 89 f1             	mov    %rsi,%rcx
    9695:	48 8d 41 ff          	lea    -0x1(%rcx),%rax
    9699:	4c 39 c0             	cmp    %r8,%rax
    969c:	41 0f 94 c1          	sete   %r9b
    96a0:	eb 03                	jmp    96a5 <fwp_valid_float+0x75>
    96a2:	4c 89 c1             	mov    %r8,%rcx
    96a5:	31 c0                	xor    %eax,%eax
    96a7:	49 39 d0             	cmp    %rdx,%r8
    96aa:	75 06                	jne    96b2 <fwp_valid_float+0x82>
    96ac:	45 84 c9             	test   %r9b,%r9b
    96af:	74 01                	je     96b2 <fwp_valid_float+0x82>
    96b1:	c3                   	ret
    96b2:	48 39 f1             	cmp    %rsi,%rcx
    96b5:	73 58                	jae    970f <fwp_valid_float+0xdf>
    96b7:	0f b6 14 0f          	movzbl (%rdi,%rcx,1),%edx
    96bb:	83 ca 20             	or     $0x20,%edx
    96be:	83 fa 65             	cmp    $0x65,%edx
    96c1:	75 4c                	jne    970f <fwp_valid_float+0xdf>
    96c3:	48 8d 51 01          	lea    0x1(%rcx),%rdx
    96c7:	48 39 f2             	cmp    %rsi,%rdx
    96ca:	73 18                	jae    96e4 <fwp_valid_float+0xb4>
    96cc:	44 0f b6 04 17       	movzbl (%rdi,%rdx,1),%r8d
    96d1:	41 83 f8 2d          	cmp    $0x2d,%r8d
    96d5:	74 06                	je     96dd <fwp_valid_float+0xad>
    96d7:	41 83 f8 2b          	cmp    $0x2b,%r8d
    96db:	75 07                	jne    96e4 <fwp_valid_float+0xb4>
    96dd:	48 83 c1 02          	add    $0x2,%rcx
    96e1:	48 89 ca             	mov    %rcx,%rdx
    96e4:	48 39 f2             	cmp    %rsi,%rdx
    96e7:	73 c8                	jae    96b1 <fwp_valid_float+0x81>
    96e9:	48 89 d1             	mov    %rdx,%rcx
    96ec:	0f 1f 40 00          	nopl   0x0(%rax)
    96f0:	44 0f b6 04 0f       	movzbl (%rdi,%rcx,1),%r8d
    96f5:	41 80 c0 d0          	add    $0xd0,%r8b
    96f9:	41 80 f8 09          	cmp    $0x9,%r8b
    96fd:	77 0b                	ja     970a <fwp_valid_float+0xda>
    96ff:	48 ff c1             	inc    %rcx
    9702:	48 39 ce             	cmp    %rcx,%rsi
    9705:	75 e9                	jne    96f0 <fwp_valid_float+0xc0>
    9707:	48 89 f1             	mov    %rsi,%rcx
    970a:	48 39 d1             	cmp    %rdx,%rcx
    970d:	74 a2                	je     96b1 <fwp_valid_float+0x81>
    970f:	31 c0                	xor    %eax,%eax
    9711:	48 39 f1             	cmp    %rsi,%rcx
    9714:	0f 94 c0             	sete   %al
    9717:	c3                   	ret
    9718:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    971f:	00 

0000000000009720 <fwp_from_f32>:
    9720:	66 0f 7e c0          	movd   %xmm0,%eax
    9724:	c3                   	ret
    9725:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    972c:	00 00 00 00 

0000000000009730 <fwp_float_of>:
    9730:	83 ff 0a             	cmp    $0xa,%edi
    9733:	0f 85 77 92 ff ff    	jne    29b0 <fwp_from_f64>
    9739:	f2 0f 5a c0          	cvtsd2ss %xmm0,%xmm0
    973d:	eb e1                	jmp    9720 <fwp_from_f32>
    973f:	90                   	nop

0000000000009740 <fwp_utf8_put>:
    9740:	50                   	push   %rax
    9741:	83 fe 7f             	cmp    $0x7f,%esi
    9744:	77 0f                	ja     9755 <fwp_utf8_put+0x15>
    9746:	40 88 74 24 04       	mov    %sil,0x4(%rsp)
    974b:	ba 01 00 00 00       	mov    $0x1,%edx
    9750:	e9 8e 00 00 00       	jmp    97e3 <fwp_utf8_put+0xa3>
    9755:	89 f0                	mov    %esi,%eax
    9757:	81 fe ff 07 00 00    	cmp    $0x7ff,%esi
    975d:	77 1d                	ja     977c <fwp_utf8_put+0x3c>
    975f:	c1 e8 06             	shr    $0x6,%eax
    9762:	0c c0                	or     $0xc0,%al
    9764:	88 44 24 04          	mov    %al,0x4(%rsp)
    9768:	40 80 e6 3f          	and    $0x3f,%sil
    976c:	40 80 ce 80          	or     $0x80,%sil
    9770:	40 88 74 24 05       	mov    %sil,0x5(%rsp)
    9775:	ba 02 00 00 00       	mov    $0x2,%edx
    977a:	eb 67                	jmp    97e3 <fwp_utf8_put+0xa3>
    977c:	81 fe ff ff 00 00    	cmp    $0xffff,%esi
    9782:	77 2a                	ja     97ae <fwp_utf8_put+0x6e>
    9784:	c1 e8 0c             	shr    $0xc,%eax
    9787:	0c e0                	or     $0xe0,%al
    9789:	88 44 24 04          	mov    %al,0x4(%rsp)
    978d:	89 f0                	mov    %esi,%eax
    978f:	c1 e8 06             	shr    $0x6,%eax
    9792:	24 3f                	and    $0x3f,%al
    9794:	0c 80                	or     $0x80,%al
    9796:	88 44 24 05          	mov    %al,0x5(%rsp)
    979a:	40 80 e6 3f          	and    $0x3f,%sil
    979e:	40 80 ce 80          	or     $0x80,%sil
    97a2:	40 88 74 24 06       	mov    %sil,0x6(%rsp)
    97a7:	ba 03 00 00 00       	mov    $0x3,%edx
    97ac:	eb 35                	jmp    97e3 <fwp_utf8_put+0xa3>
    97ae:	c1 e8 12             	shr    $0x12,%eax
    97b1:	0c f0                	or     $0xf0,%al
    97b3:	88 44 24 04          	mov    %al,0x4(%rsp)
    97b7:	89 f0                	mov    %esi,%eax
    97b9:	c1 e8 0c             	shr    $0xc,%eax
    97bc:	24 3f                	and    $0x3f,%al
    97be:	0c 80                	or     $0x80,%al
    97c0:	88 44 24 05          	mov    %al,0x5(%rsp)
    97c4:	89 f0                	mov    %esi,%eax
    97c6:	c1 e8 06             	shr    $0x6,%eax
    97c9:	24 3f                	and    $0x3f,%al
    97cb:	0c 80                	or     $0x80,%al
    97cd:	88 44 24 06          	mov    %al,0x6(%rsp)
    97d1:	40 80 e6 3f          	and    $0x3f,%sil
    97d5:	40 80 ce 80          	or     $0x80,%sil
    97d9:	40 88 74 24 07       	mov    %sil,0x7(%rsp)
    97de:	ba 04 00 00 00       	mov    $0x4,%edx
    97e3:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
    97e8:	e8 43 df ff ff       	call   7730 <buf_put>
    97ed:	58                   	pop    %rax
    97ee:	c3                   	ret
    97ef:	90                   	nop

00000000000097f0 <tp_push>:
    97f0:	41 56                	push   %r14
    97f2:	53                   	push   %rbx
    97f3:	50                   	push   %rax
    97f4:	48 89 f3             	mov    %rsi,%rbx
    97f7:	49 89 fe             	mov    %rdi,%r14
    97fa:	48 8b 77 18          	mov    0x18(%rdi),%rsi
    97fe:	48 3b 77 20          	cmp    0x20(%rdi),%rsi
    9802:	75 2f                	jne    9833 <tp_push+0x43>
    9804:	48 8d 04 36          	lea    (%rsi,%rsi,1),%rax
    9808:	48 85 f6             	test   %rsi,%rsi
    980b:	ba 08 00 00 00       	mov    $0x8,%edx
    9810:	48 0f 45 d0          	cmovne %rax,%rdx
    9814:	49 89 56 20          	mov    %rdx,0x20(%r14)
    9818:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    981c:	48 c1 e6 03          	shl    $0x3,%rsi
    9820:	48 c1 e2 03          	shl    $0x3,%rdx
    9824:	e8 07 dc ff ff       	call   7430 <fwp_mem_realloc>
    9829:	49 89 46 10          	mov    %rax,0x10(%r14)
    982d:	49 8b 76 18          	mov    0x18(%r14),%rsi
    9831:	eb 04                	jmp    9837 <tp_push+0x47>
    9833:	49 8b 46 10          	mov    0x10(%r14),%rax
    9837:	48 8d 4e 01          	lea    0x1(%rsi),%rcx
    983b:	49 89 4e 18          	mov    %rcx,0x18(%r14)
    983f:	48 89 1c f0          	mov    %rbx,(%rax,%rsi,8)
    9843:	48 83 c4 08          	add    $0x8,%rsp
    9847:	5b                   	pop    %rbx
    9848:	41 5e                	pop    %r14
    984a:	c3                   	ret
    984b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000009850 <tp_is_delim>:
    9850:	b8 01 00 00 00       	mov    $0x1,%eax
    9855:	83 ff 2c             	cmp    $0x2c,%edi
    9858:	77 13                	ja     986d <tp_is_delim+0x1d>
    985a:	89 f9                	mov    %edi,%ecx
    985c:	48 ba 00 26 00 00 01 	movabs $0x130100002600,%rdx
    9863:	13 00 00 
    9866:	48 0f a3 ca          	bt     %rcx,%rdx
    986a:	73 01                	jae    986d <tp_is_delim+0x1d>
    986c:	c3                   	ret
    986d:	83 ff 5d             	cmp    $0x5d,%edi
    9870:	74 fa                	je     986c <tp_is_delim+0x1c>
    9872:	83 ff 7d             	cmp    $0x7d,%edi
    9875:	74 f5                	je     986c <tp_is_delim+0x1c>
    9877:	31 c0                	xor    %eax,%eax
    9879:	40 80 ff 3a          	cmp    $0x3a,%dil
    987d:	0f 94 c0             	sete   %al
    9880:	c3                   	ret
    9881:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9888:	0f 1f 84 00 00 00 00 
    988f:	00 

0000000000009890 <fwp_list_len>:
    9890:	31 c0                	xor    %eax,%eax
    9892:	48 85 ff             	test   %rdi,%rdi
    9895:	74 15                	je     98ac <fwp_list_len+0x1c>
    9897:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    989e:	00 00 
    98a0:	48 ff c0             	inc    %rax
    98a3:	48 8b 7f 10          	mov    0x10(%rdi),%rdi
    98a7:	48 85 ff             	test   %rdi,%rdi
    98aa:	75 f4                	jne    98a0 <fwp_list_len+0x10>
    98ac:	c3                   	ret
    98ad:	0f 1f 00             	nopl   (%rax)

00000000000098b0 <fwp_map_find>:
    98b0:	55                   	push   %rbp
    98b1:	41 57                	push   %r15
    98b3:	41 56                	push   %r14
    98b5:	41 55                	push   %r13
    98b7:	41 54                	push   %r12
    98b9:	53                   	push   %rbx
    98ba:	50                   	push   %rax
    98bb:	49 89 f6             	mov    %rsi,%r14
    98be:	49 89 ff             	mov    %rdi,%r15
    98c1:	48 8b 2f             	mov    (%rdi),%rbp
    98c4:	8b 02                	mov    (%rdx),%eax
    98c6:	83 f8 04             	cmp    $0x4,%eax
    98c9:	72 53                	jb     991e <fwp_map_find+0x6e>
    98cb:	83 c0 fb             	add    $0xfffffffb,%eax
    98ce:	83 f8 04             	cmp    $0x4,%eax
    98d1:	0f 83 a3 00 00 00    	jae    997a <fwp_map_find+0xca>
    98d7:	48 85 ed             	test   %rbp,%rbp
    98da:	0f 84 f7 00 00 00    	je     99d7 <fwp_map_find+0x127>
    98e0:	31 f6                	xor    %esi,%esi
    98e2:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    98e9:	ff ff 1f 
    98ec:	eb 0a                	jmp    98f8 <fwp_map_find+0x48>
    98ee:	66 90                	xchg   %ax,%ax
    98f0:	4c 89 e5             	mov    %r12,%rbp
    98f3:	48 39 ee             	cmp    %rbp,%rsi
    98f6:	73 74                	jae    996c <fwp_map_find+0xbc>
    98f8:	48 8d 14 2e          	lea    (%rsi,%rbp,1),%rdx
    98fc:	49 89 d4             	mov    %rdx,%r12
    98ff:	49 d1 ec             	shr    $1,%r12
    9902:	48 21 c2             	and    %rax,%rdx
    9905:	49 8b 54 d7 08       	mov    0x8(%r15,%rdx,8),%rdx
    990a:	4c 39 f2             	cmp    %r14,%rdx
    990d:	74 64                	je     9973 <fwp_map_find+0xc3>
    990f:	73 df                	jae    98f0 <fwp_map_find+0x40>
    9911:	49 ff c4             	inc    %r12
    9914:	4c 89 e6             	mov    %r12,%rsi
    9917:	48 39 ee             	cmp    %rbp,%rsi
    991a:	72 dc                	jb     98f8 <fwp_map_find+0x48>
    991c:	eb 4e                	jmp    996c <fwp_map_find+0xbc>
    991e:	48 85 ed             	test   %rbp,%rbp
    9921:	0f 84 b0 00 00 00    	je     99d7 <fwp_map_find+0x127>
    9927:	31 f6                	xor    %esi,%esi
    9929:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    9930:	ff ff 1f 
    9933:	eb 13                	jmp    9948 <fwp_map_find+0x98>
    9935:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    993c:	00 00 00 00 
    9940:	4c 89 e5             	mov    %r12,%rbp
    9943:	48 39 ee             	cmp    %rbp,%rsi
    9946:	73 24                	jae    996c <fwp_map_find+0xbc>
    9948:	48 8d 14 2e          	lea    (%rsi,%rbp,1),%rdx
    994c:	49 89 d4             	mov    %rdx,%r12
    994f:	49 d1 ec             	shr    $1,%r12
    9952:	48 21 c2             	and    %rax,%rdx
    9955:	49 8b 54 d7 08       	mov    0x8(%r15,%rdx,8),%rdx
    995a:	4c 39 f2             	cmp    %r14,%rdx
    995d:	74 14                	je     9973 <fwp_map_find+0xc3>
    995f:	7d df                	jge    9940 <fwp_map_find+0x90>
    9961:	49 ff c4             	inc    %r12
    9964:	4c 89 e6             	mov    %r12,%rsi
    9967:	48 39 ee             	cmp    %rbp,%rsi
    996a:	72 dc                	jb     9948 <fwp_map_find+0x98>
    996c:	31 c0                	xor    %eax,%eax
    996e:	49 89 f4             	mov    %rsi,%r12
    9971:	eb 69                	jmp    99dc <fwp_map_find+0x12c>
    9973:	b8 01 00 00 00       	mov    $0x1,%eax
    9978:	eb 62                	jmp    99dc <fwp_map_find+0x12c>
    997a:	48 85 ed             	test   %rbp,%rbp
    997d:	74 58                	je     99d7 <fwp_map_find+0x127>
    997f:	49 89 d5             	mov    %rdx,%r13
    9982:	48 89 0c 24          	mov    %rcx,(%rsp)
    9986:	31 db                	xor    %ebx,%ebx
    9988:	eb 0e                	jmp    9998 <fwp_map_find+0xe8>
    998a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9990:	4c 89 e5             	mov    %r12,%rbp
    9993:	48 39 eb             	cmp    %rbp,%rbx
    9996:	73 38                	jae    99d0 <fwp_map_find+0x120>
    9998:	48 8d 04 2b          	lea    (%rbx,%rbp,1),%rax
    999c:	49 89 c4             	mov    %rax,%r12
    999f:	49 d1 ec             	shr    $1,%r12
    99a2:	48 b9 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rcx
    99a9:	ff ff 1f 
    99ac:	48 21 c8             	and    %rcx,%rax
    99af:	49 8b 7c c7 08       	mov    0x8(%r15,%rax,8),%rdi
    99b4:	4c 89 f6             	mov    %r14,%rsi
    99b7:	4c 89 ea             	mov    %r13,%rdx
    99ba:	e8 61 00 00 00       	call   9a20 <fwp_cmp>
    99bf:	85 c0                	test   %eax,%eax
    99c1:	74 2d                	je     99f0 <fwp_map_find+0x140>
    99c3:	79 cb                	jns    9990 <fwp_map_find+0xe0>
    99c5:	49 ff c4             	inc    %r12
    99c8:	4c 89 e3             	mov    %r12,%rbx
    99cb:	48 39 eb             	cmp    %rbp,%rbx
    99ce:	72 c8                	jb     9998 <fwp_map_find+0xe8>
    99d0:	31 c0                	xor    %eax,%eax
    99d2:	49 89 dc             	mov    %rbx,%r12
    99d5:	eb 1e                	jmp    99f5 <fwp_map_find+0x145>
    99d7:	31 c0                	xor    %eax,%eax
    99d9:	45 31 e4             	xor    %r12d,%r12d
    99dc:	89 01                	mov    %eax,(%rcx)
    99de:	4c 89 e0             	mov    %r12,%rax
    99e1:	48 83 c4 08          	add    $0x8,%rsp
    99e5:	5b                   	pop    %rbx
    99e6:	41 5c                	pop    %r12
    99e8:	41 5d                	pop    %r13
    99ea:	41 5e                	pop    %r14
    99ec:	41 5f                	pop    %r15
    99ee:	5d                   	pop    %rbp
    99ef:	c3                   	ret
    99f0:	b8 01 00 00 00       	mov    $0x1,%eax
    99f5:	48 8b 0c 24          	mov    (%rsp),%rcx
    99f9:	eb e1                	jmp    99dc <fwp_map_find+0x12c>
    99fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000009a00 <fwp_map_alloc>:
    9a00:	53                   	push   %rbx
    9a01:	48 89 fb             	mov    %rdi,%rbx
    9a04:	48 c1 e7 04          	shl    $0x4,%rdi
    9a08:	48 83 cf 08          	or     $0x8,%rdi
    9a0c:	e8 1f 9c ff ff       	call   3630 <fwp_alloc>
    9a11:	48 89 18             	mov    %rbx,(%rax)
    9a14:	5b                   	pop    %rbx
    9a15:	c3                   	ret
    9a16:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    9a1d:	00 00 00 

0000000000009a20 <fwp_cmp>:
    9a20:	55                   	push   %rbp
    9a21:	41 57                	push   %r15
    9a23:	41 56                	push   %r14
    9a25:	41 55                	push   %r13
    9a27:	41 54                	push   %r12
    9a29:	53                   	push   %rbx
    9a2a:	48 83 ec 18          	sub    $0x18,%rsp
    9a2e:	48 89 f3             	mov    %rsi,%rbx
    9a31:	49 89 fe             	mov    %rdi,%r14
    9a34:	44 8b 2a             	mov    (%rdx),%r13d
    9a37:	49 83 fd 15          	cmp    $0x15,%r13
    9a3b:	77 25                	ja     9a62 <fwp_cmp+0x42>
    9a3d:	49 89 d7             	mov    %rdx,%r15
    9a40:	48 8d 05 b5 38 00 00 	lea    0x38b5(%rip),%rax        # d2fc <_IO_stdin_used+0x2fc>
    9a47:	4a 63 0c a8          	movslq (%rax,%r13,4),%rcx
    9a4b:	48 01 c1             	add    %rax,%rcx
    9a4e:	ff e1                	jmp    *%rcx
    9a50:	31 c9                	xor    %ecx,%ecx
    9a52:	49 39 de             	cmp    %rbx,%r14
    9a55:	0f 9f c1             	setg   %cl
    9a58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9a5d:	0f 4d c1             	cmovge %ecx,%eax
    9a60:	eb 10                	jmp    9a72 <fwp_cmp+0x52>
    9a62:	31 c9                	xor    %ecx,%ecx
    9a64:	49 39 de             	cmp    %rbx,%r14
    9a67:	0f 97 c1             	seta   %cl
    9a6a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9a6f:	0f 43 c1             	cmovae %ecx,%eax
    9a72:	48 83 c4 18          	add    $0x18,%rsp
    9a76:	5b                   	pop    %rbx
    9a77:	41 5c                	pop    %r12
    9a79:	41 5d                	pop    %r13
    9a7b:	41 5e                	pop    %r14
    9a7d:	41 5f                	pop    %r15
    9a7f:	5d                   	pop    %rbp
    9a80:	c3                   	ret
    9a81:	4d 8b 3e             	mov    (%r14),%r15
    9a84:	4c 8b 23             	mov    (%rbx),%r12
    9a87:	49 83 c6 08          	add    $0x8,%r14
    9a8b:	48 83 c3 08          	add    $0x8,%rbx
    9a8f:	4d 39 e7             	cmp    %r12,%r15
    9a92:	4c 89 e2             	mov    %r12,%rdx
    9a95:	49 0f 42 d7          	cmovb  %r15,%rdx
    9a99:	4c 89 f7             	mov    %r14,%rdi
    9a9c:	48 89 de             	mov    %rbx,%rsi
    9a9f:	e8 bc 87 ff ff       	call   2260 <memcmp@plt>
    9aa4:	85 c0                	test   %eax,%eax
    9aa6:	0f 84 ce 02 00 00    	je     9d7a <fwp_cmp+0x35a>
    9aac:	c1 f8 1f             	sar    $0x1f,%eax
    9aaf:	83 c8 01             	or     $0x1,%eax
    9ab2:	eb be                	jmp    9a72 <fwp_cmp+0x52>
    9ab4:	49 8b 06             	mov    (%r14),%rax
    9ab7:	48 8b 2b             	mov    (%rbx),%rbp
    9aba:	48 39 e8             	cmp    %rbp,%rax
    9abd:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    9ac2:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    9ac7:	48 0f 42 e8          	cmovb  %rax,%rbp
    9acb:	48 85 ed             	test   %rbp,%rbp
    9ace:	74 54                	je     9b24 <fwp_cmp+0x104>
    9ad0:	49 8b 47 38          	mov    0x38(%r15),%rax
    9ad4:	48 89 04 24          	mov    %rax,(%rsp)
    9ad8:	41 bc 10 00 00 00    	mov    $0x10,%r12d
    9ade:	eb 09                	jmp    9ae9 <fwp_cmp+0xc9>
    9ae0:	49 83 c4 10          	add    $0x10,%r12
    9ae4:	48 ff cd             	dec    %rbp
    9ae7:	74 3b                	je     9b24 <fwp_cmp+0x104>
    9ae9:	4b 8b 7c 26 f8       	mov    -0x8(%r14,%r12,1),%rdi
    9aee:	4a 8b 74 23 f8       	mov    -0x8(%rbx,%r12,1),%rsi
    9af3:	48 8b 14 24          	mov    (%rsp),%rdx
    9af7:	e8 24 ff ff ff       	call   9a20 <fwp_cmp>
    9afc:	85 c0                	test   %eax,%eax
    9afe:	0f 85 6e ff ff ff    	jne    9a72 <fwp_cmp+0x52>
    9b04:	41 83 fd 12          	cmp    $0x12,%r13d
    9b08:	75 d6                	jne    9ae0 <fwp_cmp+0xc0>
    9b0a:	4b 8b 3c 26          	mov    (%r14,%r12,1),%rdi
    9b0e:	4a 8b 34 23          	mov    (%rbx,%r12,1),%rsi
    9b12:	49 8b 57 40          	mov    0x40(%r15),%rdx
    9b16:	e8 05 ff ff ff       	call   9a20 <fwp_cmp>
    9b1b:	85 c0                	test   %eax,%eax
    9b1d:	74 c1                	je     9ae0 <fwp_cmp+0xc0>
    9b1f:	e9 4e ff ff ff       	jmp    9a72 <fwp_cmp+0x52>
    9b24:	31 c9                	xor    %ecx,%ecx
    9b26:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    9b2b:	48 39 44 24 10       	cmp    %rax,0x10(%rsp)
    9b30:	e9 32 ff ff ff       	jmp    9a67 <fwp_cmp+0x47>
    9b35:	4c 89 f7             	mov    %r14,%rdi
    9b38:	e8 73 02 00 00       	call   9db0 <fwp_u128>
    9b3d:	49 89 c7             	mov    %rax,%r15
    9b40:	49 89 d6             	mov    %rdx,%r14
    9b43:	48 89 df             	mov    %rbx,%rdi
    9b46:	e8 65 02 00 00       	call   9db0 <fwp_u128>
    9b4b:	48 89 c1             	mov    %rax,%rcx
    9b4e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9b53:	49 39 cf             	cmp    %rcx,%r15
    9b56:	4c 89 f6             	mov    %r14,%rsi
    9b59:	48 19 d6             	sbb    %rdx,%rsi
    9b5c:	0f 82 10 ff ff ff    	jb     9a72 <fwp_cmp+0x52>
    9b62:	4c 39 f9             	cmp    %r15,%rcx
    9b65:	4c 19 f2             	sbb    %r14,%rdx
    9b68:	0f 92 c0             	setb   %al
    9b6b:	0f b6 c0             	movzbl %al,%eax
    9b6e:	e9 ff fe ff ff       	jmp    9a72 <fwp_cmp+0x52>
    9b73:	4c 89 f7             	mov    %r14,%rdi
    9b76:	e8 55 02 00 00       	call   9dd0 <fwp_f32>
    9b7b:	e8 40 02 00 00       	call   9dc0 <fwp_total_key32>
    9b80:	89 c5                	mov    %eax,%ebp
    9b82:	48 89 df             	mov    %rbx,%rdi
    9b85:	e8 46 02 00 00       	call   9dd0 <fwp_f32>
    9b8a:	e8 31 02 00 00       	call   9dc0 <fwp_total_key32>
    9b8f:	89 c1                	mov    %eax,%ecx
    9b91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9b96:	39 cd                	cmp    %ecx,%ebp
    9b98:	0f 8c d4 fe ff ff    	jl     9a72 <fwp_cmp+0x52>
    9b9e:	eb 2e                	jmp    9bce <fwp_cmp+0x1ae>
    9ba0:	4c 89 f7             	mov    %r14,%rdi
    9ba3:	e8 28 bd ff ff       	call   58d0 <fwp_f64>
    9ba8:	e8 33 02 00 00       	call   9de0 <fwp_total_key64>
    9bad:	49 89 c6             	mov    %rax,%r14
    9bb0:	48 89 df             	mov    %rbx,%rdi
    9bb3:	e8 18 bd ff ff       	call   58d0 <fwp_f64>
    9bb8:	e8 23 02 00 00       	call   9de0 <fwp_total_key64>
    9bbd:	48 89 c1             	mov    %rax,%rcx
    9bc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9bc5:	49 39 ce             	cmp    %rcx,%r14
    9bc8:	0f 8c a4 fe ff ff    	jl     9a72 <fwp_cmp+0x52>
    9bce:	0f 9f c0             	setg   %al
    9bd1:	0f b6 c0             	movzbl %al,%eax
    9bd4:	e9 99 fe ff ff       	jmp    9a72 <fwp_cmp+0x52>
    9bd9:	4c 89 f7             	mov    %r14,%rdi
    9bdc:	e8 bf 01 00 00       	call   9da0 <fwp_i128>
    9be1:	49 89 c7             	mov    %rax,%r15
    9be4:	49 89 d6             	mov    %rdx,%r14
    9be7:	48 89 df             	mov    %rbx,%rdi
    9bea:	e8 b1 01 00 00       	call   9da0 <fwp_i128>
    9bef:	48 89 c1             	mov    %rax,%rcx
    9bf2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9bf7:	49 39 cf             	cmp    %rcx,%r15
    9bfa:	4c 89 f6             	mov    %r14,%rsi
    9bfd:	48 19 d6             	sbb    %rdx,%rsi
    9c00:	0f 8c 6c fe ff ff    	jl     9a72 <fwp_cmp+0x52>
    9c06:	4c 39 f9             	cmp    %r15,%rcx
    9c09:	4c 19 f2             	sbb    %r14,%rdx
    9c0c:	0f 9c c0             	setl   %al
    9c0f:	0f b6 c0             	movzbl %al,%eax
    9c12:	e9 5b fe ff ff       	jmp    9a72 <fwp_cmp+0x52>
    9c17:	4d 85 f6             	test   %r14,%r14
    9c1a:	0f 94 c0             	sete   %al
    9c1d:	74 3e                	je     9c5d <fwp_cmp+0x23d>
    9c1f:	48 85 db             	test   %rbx,%rbx
    9c22:	74 39                	je     9c5d <fwp_cmp+0x23d>
    9c24:	4d 8b 7f 38          	mov    0x38(%r15),%r15
    9c28:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    9c2f:	00 
    9c30:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    9c34:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    9c38:	4c 89 fa             	mov    %r15,%rdx
    9c3b:	e8 e0 fd ff ff       	call   9a20 <fwp_cmp>
    9c40:	85 c0                	test   %eax,%eax
    9c42:	0f 85 2a fe ff ff    	jne    9a72 <fwp_cmp+0x52>
    9c48:	4d 8b 76 10          	mov    0x10(%r14),%r14
    9c4c:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    9c50:	4d 85 f6             	test   %r14,%r14
    9c53:	0f 94 c0             	sete   %al
    9c56:	74 05                	je     9c5d <fwp_cmp+0x23d>
    9c58:	48 85 db             	test   %rbx,%rbx
    9c5b:	75 d3                	jne    9c30 <fwp_cmp+0x210>
    9c5d:	48 85 db             	test   %rbx,%rbx
    9c60:	0f 95 c1             	setne  %cl
    9c63:	08 c1                	or     %al,%cl
    9c65:	80 f1 01             	xor    $0x1,%cl
    9c68:	0f b6 c9             	movzbl %cl,%ecx
    9c6b:	84 c0                	test   %al,%al
    9c6d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9c72:	0f 44 c1             	cmove  %ecx,%eax
    9c75:	48 85 db             	test   %rbx,%rbx
    9c78:	0f 44 c1             	cmove  %ecx,%eax
    9c7b:	e9 f2 fd ff ff       	jmp    9a72 <fwp_cmp+0x52>
    9c80:	45 8b 67 10          	mov    0x10(%r15),%r12d
    9c84:	45 85 e4             	test   %r12d,%r12d
    9c87:	0f 8e f7 00 00 00    	jle    9d84 <fwp_cmp+0x364>
    9c8d:	4d 8b 7f 20          	mov    0x20(%r15),%r15
    9c91:	45 31 ed             	xor    %r13d,%r13d
    9c94:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    9c9b:	00 00 00 00 00 
    9ca0:	4b 8b 7c ee 08       	mov    0x8(%r14,%r13,8),%rdi
    9ca5:	4a 8b 74 eb 08       	mov    0x8(%rbx,%r13,8),%rsi
    9caa:	4b 8b 14 ef          	mov    (%r15,%r13,8),%rdx
    9cae:	e8 6d fd ff ff       	call   9a20 <fwp_cmp>
    9cb3:	85 c0                	test   %eax,%eax
    9cb5:	0f 85 b7 fd ff ff    	jne    9a72 <fwp_cmp+0x52>
    9cbb:	49 ff c5             	inc    %r13
    9cbe:	31 c0                	xor    %eax,%eax
    9cc0:	4d 39 ec             	cmp    %r13,%r12
    9cc3:	75 db                	jne    9ca0 <fwp_cmp+0x280>
    9cc5:	e9 a8 fd ff ff       	jmp    9a72 <fwp_cmp+0x52>
    9cca:	49 8b 06             	mov    (%r14),%rax
    9ccd:	4c 8b 2b             	mov    (%rbx),%r13
    9cd0:	4c 39 e8             	cmp    %r13,%rax
    9cd3:	4c 89 ed             	mov    %r13,%rbp
    9cd6:	48 89 04 24          	mov    %rax,(%rsp)
    9cda:	48 0f 42 e8          	cmovb  %rax,%rbp
    9cde:	48 85 ed             	test   %rbp,%rbp
    9ce1:	74 2f                	je     9d12 <fwp_cmp+0x2f2>
    9ce3:	4d 8b 7f 38          	mov    0x38(%r15),%r15
    9ce7:	45 31 e4             	xor    %r12d,%r12d
    9cea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9cf0:	4b 8b 7c e6 08       	mov    0x8(%r14,%r12,8),%rdi
    9cf5:	4a 8b 74 e3 08       	mov    0x8(%rbx,%r12,8),%rsi
    9cfa:	4c 89 fa             	mov    %r15,%rdx
    9cfd:	e8 1e fd ff ff       	call   9a20 <fwp_cmp>
    9d02:	85 c0                	test   %eax,%eax
    9d04:	0f 85 68 fd ff ff    	jne    9a72 <fwp_cmp+0x52>
    9d0a:	49 ff c4             	inc    %r12
    9d0d:	4c 39 e5             	cmp    %r12,%rbp
    9d10:	75 de                	jne    9cf0 <fwp_cmp+0x2d0>
    9d12:	31 c9                	xor    %ecx,%ecx
    9d14:	4c 39 2c 24          	cmp    %r13,(%rsp)
    9d18:	e9 4a fd ff ff       	jmp    9a67 <fwp_cmp+0x47>
    9d1d:	4c 89 f7             	mov    %r14,%rdi
    9d20:	e8 db 00 00 00       	call   9e00 <fwp_tag>
    9d25:	89 c5                	mov    %eax,%ebp
    9d27:	48 89 df             	mov    %rbx,%rdi
    9d2a:	e8 d1 00 00 00       	call   9e00 <fwp_tag>
    9d2f:	39 c5                	cmp    %eax,%ebp
    9d31:	75 58                	jne    9d8b <fwp_cmp+0x36b>
    9d33:	49 8b 4f 28          	mov    0x28(%r15),%rcx
    9d37:	89 e8                	mov    %ebp,%eax
    9d39:	44 8b 24 81          	mov    (%rcx,%rax,4),%r12d
    9d3d:	45 85 e4             	test   %r12d,%r12d
    9d40:	7e 42                	jle    9d84 <fwp_cmp+0x364>
    9d42:	49 8b 4f 30          	mov    0x30(%r15),%rcx
    9d46:	4c 8b 3c c1          	mov    (%rcx,%rax,8),%r15
    9d4a:	45 31 ed             	xor    %r13d,%r13d
    9d4d:	0f 1f 00             	nopl   (%rax)
    9d50:	4b 8b 7c ee 08       	mov    0x8(%r14,%r13,8),%rdi
    9d55:	4a 8b 74 eb 08       	mov    0x8(%rbx,%r13,8),%rsi
    9d5a:	4b 8b 14 ef          	mov    (%r15,%r13,8),%rdx
    9d5e:	e8 bd fc ff ff       	call   9a20 <fwp_cmp>
    9d63:	85 c0                	test   %eax,%eax
    9d65:	0f 85 07 fd ff ff    	jne    9a72 <fwp_cmp+0x52>
    9d6b:	49 ff c5             	inc    %r13
    9d6e:	31 c0                	xor    %eax,%eax
    9d70:	4d 39 ec             	cmp    %r13,%r12
    9d73:	75 db                	jne    9d50 <fwp_cmp+0x330>
    9d75:	e9 f8 fc ff ff       	jmp    9a72 <fwp_cmp+0x52>
    9d7a:	31 c9                	xor    %ecx,%ecx
    9d7c:	4d 39 e7             	cmp    %r12,%r15
    9d7f:	e9 e3 fc ff ff       	jmp    9a67 <fwp_cmp+0x47>
    9d84:	31 c0                	xor    %eax,%eax
    9d86:	e9 e7 fc ff ff       	jmp    9a72 <fwp_cmp+0x52>
    9d8b:	0f 97 c0             	seta   %al
    9d8e:	0f b6 c8             	movzbl %al,%ecx
    9d91:	e9 d4 fc ff ff       	jmp    9a6a <fwp_cmp+0x4a>
    9d96:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    9d9d:	00 00 00 

0000000000009da0 <fwp_i128>:
    9da0:	48 8b 07             	mov    (%rdi),%rax
    9da3:	48 8b 57 08          	mov    0x8(%rdi),%rdx
    9da7:	c3                   	ret
    9da8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    9daf:	00 

0000000000009db0 <fwp_u128>:
    9db0:	48 8b 07             	mov    (%rdi),%rax
    9db3:	48 8b 57 08          	mov    0x8(%rdi),%rdx
    9db7:	c3                   	ret
    9db8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    9dbf:	00 

0000000000009dc0 <fwp_total_key32>:
    9dc0:	66 0f 7e c1          	movd   %xmm0,%ecx
    9dc4:	89 c8                	mov    %ecx,%eax
    9dc6:	c1 f8 1f             	sar    $0x1f,%eax
    9dc9:	d1 e8                	shr    $1,%eax
    9dcb:	31 c8                	xor    %ecx,%eax
    9dcd:	c3                   	ret
    9dce:	66 90                	xchg   %ax,%ax

0000000000009dd0 <fwp_f32>:
    9dd0:	66 0f 6e c7          	movd   %edi,%xmm0
    9dd4:	c3                   	ret
    9dd5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    9ddc:	00 00 00 00 

0000000000009de0 <fwp_total_key64>:
    9de0:	66 48 0f 7e c1       	movq   %xmm0,%rcx
    9de5:	48 89 c8             	mov    %rcx,%rax
    9de8:	48 c1 f8 3f          	sar    $0x3f,%rax
    9dec:	48 d1 e8             	shr    $1,%rax
    9def:	48 31 c8             	xor    %rcx,%rax
    9df2:	c3                   	ret
    9df3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9dfa:	84 00 00 00 00 00 

0000000000009e00 <fwp_tag>:
    9e00:	48 89 f8             	mov    %rdi,%rax
    9e03:	48 81 ff ff 0f 00 00 	cmp    $0xfff,%rdi
    9e0a:	76 02                	jbe    9e0e <fwp_tag+0xe>
    9e0c:	8b 00                	mov    (%rax),%eax
    9e0e:	c3                   	ret
    9e0f:	90                   	nop

0000000000009e10 <fwp_transport_off>:
    9e10:	50                   	push   %rax
    9e11:	48 8d 3d c1 44 00 00 	lea    0x44c1(%rip),%rdi        # e2d9 <exec_in_fp0+0xc79>
    9e18:	e8 13 82 ff ff       	call   2030 <getenv@plt>
    9e1d:	48 85 c0             	test   %rax,%rax
    9e20:	74 1a                	je     9e3c <fwp_transport_off+0x2c>
    9e22:	48 8d 35 be 44 00 00 	lea    0x44be(%rip),%rsi        # e2e7 <exec_in_fp0+0xc87>
    9e29:	48 89 c7             	mov    %rax,%rdi
    9e2c:	e8 8f 84 ff ff       	call   22c0 <strcmp@plt>
    9e31:	89 c1                	mov    %eax,%ecx
    9e33:	31 c0                	xor    %eax,%eax
    9e35:	85 c9                	test   %ecx,%ecx
    9e37:	0f 94 c0             	sete   %al
    9e3a:	59                   	pop    %rcx
    9e3b:	c3                   	ret
    9e3c:	31 c0                	xor    %eax,%eax
    9e3e:	59                   	pop    %rcx
    9e3f:	c3                   	ret

0000000000009e40 <fwp_pipe_addr>:
    9e40:	50                   	push   %rax
    9e41:	0f 57 c0             	xorps  %xmm0,%xmm0
    9e44:	0f 11 47 5e          	movups %xmm0,0x5e(%rdi)
    9e48:	0f 11 47 52          	movups %xmm0,0x52(%rdi)
    9e4c:	0f 11 47 42          	movups %xmm0,0x42(%rdi)
    9e50:	0f 11 47 32          	movups %xmm0,0x32(%rdi)
    9e54:	0f 11 47 22          	movups %xmm0,0x22(%rdi)
    9e58:	0f 11 47 12          	movups %xmm0,0x12(%rdi)
    9e5c:	0f 11 47 02          	movups %xmm0,0x2(%rdi)
    9e60:	66 c7 07 01 00       	movw   $0x1,(%rdi)
    9e65:	48 83 c7 03          	add    $0x3,%rdi
    9e69:	48 8b 0e             	mov    (%rsi),%rcx
    9e6c:	4c 8b 46 08          	mov    0x8(%rsi),%r8
    9e70:	48 8d 15 76 44 00 00 	lea    0x4476(%rip),%rdx        # e2ed <exec_in_fp0+0xc8d>
    9e77:	be 6b 00 00 00       	mov    $0x6b,%esi
    9e7c:	31 c0                	xor    %eax,%eax
    9e7e:	e8 3d 83 ff ff       	call   21c0 <snprintf@plt>
    9e83:	83 c0 03             	add    $0x3,%eax
    9e86:	59                   	pop    %rcx
    9e87:	c3                   	ret
    9e88:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    9e8f:	00 

0000000000009e90 <fwp_now_ns>:
    9e90:	48 83 ec 18          	sub    $0x18,%rsp
    9e94:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    9e99:	bf 01 00 00 00       	mov    $0x1,%edi
    9e9e:	e8 7d 82 ff ff       	call   2120 <clock_gettime@plt>
    9ea3:	48 69 44 24 08 00 ca 	imul   $0x3b9aca00,0x8(%rsp),%rax
    9eaa:	9a 3b 
    9eac:	48 03 44 24 10       	add    0x10(%rsp),%rax
    9eb1:	48 83 c4 18          	add    $0x18,%rsp
    9eb5:	c3                   	ret
    9eb6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    9ebd:	00 00 00 

0000000000009ec0 <fwp_ring_put>:
    9ec0:	55                   	push   %rbp
    9ec1:	41 57                	push   %r15
    9ec3:	41 56                	push   %r14
    9ec5:	41 55                	push   %r13
    9ec7:	41 54                	push   %r12
    9ec9:	53                   	push   %rbx
    9eca:	48 83 ec 38          	sub    $0x38,%rsp
    9ece:	48 89 3c 24          	mov    %rdi,(%rsp)
    9ed2:	48 85 f6             	test   %rsi,%rsi
    9ed5:	0f 84 27 01 00 00    	je     a002 <fwp_ring_put+0x142>
    9edb:	f6 05 76 af 02 00 01 	testb  $0x1,0x2af76(%rip)        # 34e58 <fwp_po_gone>
    9ee2:	0f 85 1a 01 00 00    	jne    a002 <fwp_ring_put+0x142>
    9ee8:	48 89 f3             	mov    %rsi,%rbx
    9eeb:	4c 8b 3d 5e af 02 00 	mov    0x2af5e(%rip),%r15        # 34e50 <fwp_po_ring>
    9ef2:	49 8d 87 00 10 00 00 	lea    0x1000(%r15),%rax
    9ef9:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    9efe:	49 8d 87 c0 00 00 00 	lea    0xc0(%r15),%rax
    9f05:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    9f0a:	49 8d 87 c4 00 00 00 	lea    0xc4(%r15),%rax
    9f11:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    9f16:	49 8d 87 00 01 00 00 	lea    0x100(%r15),%rax
    9f1d:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    9f22:	49 8d 87 04 01 00 00 	lea    0x104(%r15),%rax
    9f29:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    9f2e:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    9f33:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9f3a:	84 00 00 00 00 00 
    9f40:	4d 8b 67 40          	mov    0x40(%r15),%r12
    9f44:	49 8b af 80 00 00 00 	mov    0x80(%r15),%rbp
    9f4b:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    9f4f:	4c 29 e5             	sub    %r12,%rbp
    9f52:	4c 01 ed             	add    %r13,%rbp
    9f55:	74 69                	je     9fc0 <fwp_ring_put+0x100>
    9f57:	48 39 eb             	cmp    %rbp,%rbx
    9f5a:	48 0f 42 eb          	cmovb  %rbx,%rbp
    9f5e:	49 8d 7d ff          	lea    -0x1(%r13),%rdi
    9f62:	4c 21 e7             	and    %r12,%rdi
    9f65:	49 29 fd             	sub    %rdi,%r13
    9f68:	4c 39 ed             	cmp    %r13,%rbp
    9f6b:	4c 0f 42 ed          	cmovb  %rbp,%r13
    9f6f:	4c 01 f7             	add    %r14,%rdi
    9f72:	48 89 5c 24 30       	mov    %rbx,0x30(%rsp)
    9f77:	48 8b 1c 24          	mov    (%rsp),%rbx
    9f7b:	48 89 de             	mov    %rbx,%rsi
    9f7e:	4c 89 ea             	mov    %r13,%rdx
    9f81:	e8 9a 83 ff ff       	call   2320 <memcpy@plt>
    9f86:	4a 8d 34 2b          	lea    (%rbx,%r13,1),%rsi
    9f8a:	48 89 ea             	mov    %rbp,%rdx
    9f8d:	4c 29 ea             	sub    %r13,%rdx
    9f90:	4c 89 f7             	mov    %r14,%rdi
    9f93:	e8 88 83 ff ff       	call   2320 <memcpy@plt>
    9f98:	49 01 ec             	add    %rbp,%r12
    9f9b:	4d 89 67 40          	mov    %r12,0x40(%r15)
    9f9f:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    9fa4:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    9fa9:	e8 82 02 00 00       	call   a230 <fwp_ring_wake>
    9fae:	48 01 eb             	add    %rbp,%rbx
    9fb1:	48 89 1c 24          	mov    %rbx,(%rsp)
    9fb5:	48 8b 5c 24 30       	mov    0x30(%rsp),%rbx
    9fba:	48 29 eb             	sub    %rbp,%rbx
    9fbd:	eb 31                	jmp    9ff0 <fwp_ring_put+0x130>
    9fbf:	90                   	nop
    9fc0:	44 8b 05 f1 ac 00 00 	mov    0xacf1(%rip),%r8d        # 14cb8 <fwp_po_sock>
    9fc7:	4c 89 ff             	mov    %r15,%rdi
    9fca:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    9fcf:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    9fd4:	48 8d 0d 35 02 00 00 	lea    0x235(%rip),%rcx        # a210 <fwp_ring_has_space>
    9fdb:	e8 f0 00 00 00       	call   a0d0 <fwp_ring_wait>
    9fe0:	85 c0                	test   %eax,%eax
    9fe2:	75 0c                	jne    9ff0 <fwp_ring_put+0x130>
    9fe4:	c6 05 6d ae 02 00 01 	movb   $0x1,0x2ae6d(%rip)        # 34e58 <fwp_po_gone>
    9feb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    9ff0:	48 85 db             	test   %rbx,%rbx
    9ff3:	74 0d                	je     a002 <fwp_ring_put+0x142>
    9ff5:	f6 05 5c ae 02 00 01 	testb  $0x1,0x2ae5c(%rip)        # 34e58 <fwp_po_gone>
    9ffc:	0f 84 3e ff ff ff    	je     9f40 <fwp_ring_put+0x80>
    a002:	48 83 c4 38          	add    $0x38,%rsp
    a006:	5b                   	pop    %rbx
    a007:	41 5c                	pop    %r12
    a009:	41 5d                	pop    %r13
    a00b:	41 5e                	pop    %r14
    a00d:	41 5f                	pop    %r15
    a00f:	5d                   	pop    %rbp
    a010:	c3                   	ret
    a011:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a018:	0f 1f 84 00 00 00 00 
    a01f:	00 

000000000000a020 <fwp_po_flush_sock>:
    a020:	48 8b 15 21 ae 01 00 	mov    0x1ae21(%rip),%rdx        # 24e48 <fwp_po_len>
    a027:	48 85 d2             	test   %rdx,%rdx
    a02a:	74 17                	je     a043 <fwp_po_flush_sock+0x23>
    a02c:	50                   	push   %rax
    a02d:	8b 3d 85 ac 00 00    	mov    0xac85(%rip),%edi        # 14cb8 <fwp_po_sock>
    a033:	48 8d 35 16 ae 01 00 	lea    0x1ae16(%rip),%rsi        # 24e50 <fwp_po_buf>
    a03a:	e8 11 00 00 00       	call   a050 <fwp_po_write_raw>
    a03f:	48 83 c4 08          	add    $0x8,%rsp
    a043:	48 c7 05 fa ad 01 00 	movq   $0x0,0x1adfa(%rip)        # 24e48 <fwp_po_len>
    a04a:	00 00 00 00 
    a04e:	c3                   	ret
    a04f:	90                   	nop

000000000000a050 <fwp_po_write_raw>:
    a050:	48 85 d2             	test   %rdx,%rdx
    a053:	74 70                	je     a0c5 <fwp_po_write_raw+0x75>
    a055:	f6 05 fc ad 02 00 01 	testb  $0x1,0x2adfc(%rip)        # 34e58 <fwp_po_gone>
    a05c:	75 67                	jne    a0c5 <fwp_po_write_raw+0x75>
    a05e:	55                   	push   %rbp
    a05f:	41 56                	push   %r14
    a061:	53                   	push   %rbx
    a062:	48 89 d3             	mov    %rdx,%rbx
    a065:	49 89 f6             	mov    %rsi,%r14
    a068:	89 fd                	mov    %edi,%ebp
    a06a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    a070:	89 ef                	mov    %ebp,%edi
    a072:	4c 89 f6             	mov    %r14,%rsi
    a075:	48 89 da             	mov    %rbx,%rdx
    a078:	b9 00 40 00 00       	mov    $0x4000,%ecx
    a07d:	e8 0e 81 ff ff       	call   2190 <send@plt>
    a082:	48 85 c0             	test   %rax,%rax
    a085:	78 19                	js     a0a0 <fwp_po_write_raw+0x50>
    a087:	74 31                	je     a0ba <fwp_po_write_raw+0x6a>
    a089:	49 01 c6             	add    %rax,%r14
    a08c:	48 29 c3             	sub    %rax,%rbx
    a08f:	eb 19                	jmp    a0aa <fwp_po_write_raw+0x5a>
    a091:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a098:	0f 1f 84 00 00 00 00 
    a09f:	00 
    a0a0:	e8 db 7f ff ff       	call   2080 <__errno_location@plt>
    a0a5:	83 38 04             	cmpl   $0x4,(%rax)
    a0a8:	75 10                	jne    a0ba <fwp_po_write_raw+0x6a>
    a0aa:	48 85 db             	test   %rbx,%rbx
    a0ad:	74 12                	je     a0c1 <fwp_po_write_raw+0x71>
    a0af:	f6 05 a2 ad 02 00 01 	testb  $0x1,0x2ada2(%rip)        # 34e58 <fwp_po_gone>
    a0b6:	74 b8                	je     a070 <fwp_po_write_raw+0x20>
    a0b8:	eb 07                	jmp    a0c1 <fwp_po_write_raw+0x71>
    a0ba:	c6 05 97 ad 02 00 01 	movb   $0x1,0x2ad97(%rip)        # 34e58 <fwp_po_gone>
    a0c1:	5b                   	pop    %rbx
    a0c2:	41 5e                	pop    %r14
    a0c4:	5d                   	pop    %rbp
    a0c5:	c3                   	ret
    a0c6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    a0cd:	00 00 00 

000000000000a0d0 <fwp_ring_wait>:
    a0d0:	55                   	push   %rbp
    a0d1:	41 57                	push   %r15
    a0d3:	41 56                	push   %r14
    a0d5:	41 55                	push   %r13
    a0d7:	41 54                	push   %r12
    a0d9:	53                   	push   %rbx
    a0da:	50                   	push   %rax
    a0db:	44 89 44 24 04       	mov    %r8d,0x4(%rsp)
    a0e0:	49 89 cf             	mov    %rcx,%r15
    a0e3:	49 89 d6             	mov    %rdx,%r14
    a0e6:	49 89 f4             	mov    %rsi,%r12
    a0e9:	49 89 fd             	mov    %rdi,%r13
    a0ec:	8b 0d ca ab 00 00    	mov    0xabca(%rip),%ecx        # 14cbc <fwp_ring_spin>
    a0f2:	85 c9                	test   %ecx,%ecx
    a0f4:	78 06                	js     a0fc <fwp_ring_wait+0x2c>
    a0f6:	85 c9                	test   %ecx,%ecx
    a0f8:	75 1f                	jne    a119 <fwp_ring_wait+0x49>
    a0fa:	eb 6f                	jmp    a16b <fwp_ring_wait+0x9b>
    a0fc:	bf 54 00 00 00       	mov    $0x54,%edi
    a101:	e8 1a 83 ff ff       	call   2420 <sysconf@plt>
    a106:	31 c9                	xor    %ecx,%ecx
    a108:	48 83 f8 02          	cmp    $0x2,%rax
    a10c:	0f 9d c1             	setge  %cl
    a10f:	89 0d a7 ab 00 00    	mov    %ecx,0xaba7(%rip)        # 14cbc <fwp_ring_spin>
    a115:	85 c9                	test   %ecx,%ecx
    a117:	74 52                	je     a16b <fwp_ring_wait+0x9b>
    a119:	4c 89 ef             	mov    %r13,%rdi
    a11c:	41 ff d7             	call   *%r15
    a11f:	89 c1                	mov    %eax,%ecx
    a121:	b8 01 00 00 00       	mov    $0x1,%eax
    a126:	85 c9                	test   %ecx,%ecx
    a128:	75 6a                	jne    a194 <fwp_ring_wait+0xc4>
    a12a:	bd 01 00 00 00       	mov    $0x1,%ebp
    a12f:	31 db                	xor    %ebx,%ebx
    a131:	eb 19                	jmp    a14c <fwp_ring_wait+0x7c>
    a133:	48 05 50 c3 00 00    	add    $0xc350,%rax
    a139:	48 89 c3             	mov    %rax,%rbx
    a13c:	0f 1f 40 00          	nopl   0x0(%rax)
    a140:	ff c5                	inc    %ebp
    a142:	4c 89 ef             	mov    %r13,%rdi
    a145:	41 ff d7             	call   *%r15
    a148:	85 c0                	test   %eax,%eax
    a14a:	75 43                	jne    a18f <fwp_ring_wait+0xbf>
    a14c:	e8 ff 00 00 00       	call   a250 <fwp_cpu_relax>
    a151:	40 f6 c5 3f          	test   $0x3f,%bpl
    a155:	75 e9                	jne    a140 <fwp_ring_wait+0x70>
    a157:	e8 e4 80 ff ff       	call   2240 <sched_yield@plt>
    a15c:	e8 2f fd ff ff       	call   9e90 <fwp_now_ns>
    a161:	48 85 db             	test   %rbx,%rbx
    a164:	74 cd                	je     a133 <fwp_ring_wait+0x63>
    a166:	48 39 d8             	cmp    %rbx,%rax
    a169:	7e d5                	jle    a140 <fwp_ring_wait+0x70>
    a16b:	41 8b 2c 24          	mov    (%r12),%ebp
    a16f:	b8 01 00 00 00       	mov    $0x1,%eax
    a174:	41 87 06             	xchg   %eax,(%r14)
    a177:	0f ae f0             	mfence
    a17a:	4c 89 ef             	mov    %r13,%rdi
    a17d:	41 ff d7             	call   *%r15
    a180:	85 c0                	test   %eax,%eax
    a182:	8b 5c 24 04          	mov    0x4(%rsp),%ebx
    a186:	74 41                	je     a1c9 <fwp_ring_wait+0xf9>
    a188:	41 c7 06 00 00 00 00 	movl   $0x0,(%r14)
    a18f:	b8 01 00 00 00       	mov    $0x1,%eax
    a194:	48 83 c4 08          	add    $0x8,%rsp
    a198:	5b                   	pop    %rbx
    a199:	41 5c                	pop    %r12
    a19b:	41 5d                	pop    %r13
    a19d:	41 5e                	pop    %r14
    a19f:	41 5f                	pop    %r15
    a1a1:	5d                   	pop    %rbp
    a1a2:	c3                   	ret
    a1a3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a1aa:	84 00 00 00 00 00 
    a1b0:	41 8b 2c 24          	mov    (%r12),%ebp
    a1b4:	b8 01 00 00 00       	mov    $0x1,%eax
    a1b9:	41 87 06             	xchg   %eax,(%r14)
    a1bc:	0f ae f0             	mfence
    a1bf:	4c 89 ef             	mov    %r13,%rdi
    a1c2:	41 ff d7             	call   *%r15
    a1c5:	85 c0                	test   %eax,%eax
    a1c7:	75 bf                	jne    a188 <fwp_ring_wait+0xb8>
    a1c9:	4c 89 e7             	mov    %r12,%rdi
    a1cc:	31 f6                	xor    %esi,%esi
    a1ce:	89 ea                	mov    %ebp,%edx
    a1d0:	b9 64 00 00 00       	mov    $0x64,%ecx
    a1d5:	e8 86 00 00 00       	call   a260 <fwp_futex>
    a1da:	48 89 c5             	mov    %rax,%rbp
    a1dd:	41 c7 06 00 00 00 00 	movl   $0x0,(%r14)
    a1e4:	4c 89 ef             	mov    %r13,%rdi
    a1e7:	41 ff d7             	call   *%r15
    a1ea:	85 c0                	test   %eax,%eax
    a1ec:	75 a1                	jne    a18f <fwp_ring_wait+0xbf>
    a1ee:	48 85 ed             	test   %rbp,%rbp
    a1f1:	74 bd                	je     a1b0 <fwp_ring_wait+0xe0>
    a1f3:	e8 88 7e ff ff       	call   2080 <__errno_location@plt>
    a1f8:	83 38 6e             	cmpl   $0x6e,(%rax)
    a1fb:	75 b3                	jne    a1b0 <fwp_ring_wait+0xe0>
    a1fd:	89 df                	mov    %ebx,%edi
    a1ff:	e8 cc 00 00 00       	call   a2d0 <fwp_sock_gone>
    a204:	85 c0                	test   %eax,%eax
    a206:	74 a8                	je     a1b0 <fwp_ring_wait+0xe0>
    a208:	31 c0                	xor    %eax,%eax
    a20a:	eb 88                	jmp    a194 <fwp_ring_wait+0xc4>
    a20c:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000a210 <fwp_ring_has_space>:
    a210:	48 8b 8f 80 00 00 00 	mov    0x80(%rdi),%rcx
    a217:	48 2b 4f 40          	sub    0x40(%rdi),%rcx
    a21b:	31 c0                	xor    %eax,%eax
    a21d:	48 03 4f 08          	add    0x8(%rdi),%rcx
    a221:	0f 95 c0             	setne  %al
    a224:	c3                   	ret
    a225:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a22c:	00 00 00 00 

000000000000a230 <fwp_ring_wake>:
    a230:	0f ae f0             	mfence
    a233:	8b 06                	mov    (%rsi),%eax
    a235:	85 c0                	test   %eax,%eax
    a237:	74 14                	je     a24d <fwp_ring_wake+0x1d>
    a239:	f0 ff 07             	lock incl (%rdi)
    a23c:	be 01 00 00 00       	mov    $0x1,%esi
    a241:	ba ff ff ff 7f       	mov    $0x7fffffff,%edx
    a246:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    a24b:	eb 13                	jmp    a260 <fwp_futex>
    a24d:	c3                   	ret
    a24e:	66 90                	xchg   %ax,%ax

000000000000a250 <fwp_cpu_relax>:
    a250:	f3 90                	pause
    a252:	c3                   	ret
    a253:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a25a:	84 00 00 00 00 00 

000000000000a260 <fwp_futex>:
    a260:	48 83 ec 18          	sub    $0x18,%rsp
    a264:	89 c8                	mov    %ecx,%eax
    a266:	89 d1                	mov    %edx,%ecx
    a268:	89 f2                	mov    %esi,%edx
    a26a:	48 89 fe             	mov    %rdi,%rsi
    a26d:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
    a274:	00 00 
    a276:	48 98                	cltq
    a278:	48 69 f8 d3 4d 62 10 	imul   $0x10624dd3,%rax,%rdi
    a27f:	49 89 f8             	mov    %rdi,%r8
    a282:	49 c1 e8 3f          	shr    $0x3f,%r8
    a286:	48 c1 ff 26          	sar    $0x26,%rdi
    a28a:	44 01 c7             	add    %r8d,%edi
    a28d:	69 ff e8 03 00 00    	imul   $0x3e8,%edi,%edi
    a293:	41 89 c0             	mov    %eax,%r8d
    a296:	41 29 f8             	sub    %edi,%r8d
    a299:	41 69 f8 40 42 0f 00 	imul   $0xf4240,%r8d,%edi
    a2a0:	48 63 ff             	movslq %edi,%rdi
    a2a3:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    a2a8:	31 ff                	xor    %edi,%edi
    a2aa:	85 c0                	test   %eax,%eax
    a2ac:	4c 8d 44 24 08       	lea    0x8(%rsp),%r8
    a2b1:	4c 0f 48 c7          	cmovs  %rdi,%r8
    a2b5:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    a2bc:	bf ca 00 00 00       	mov    $0xca,%edi
    a2c1:	45 31 c9             	xor    %r9d,%r9d
    a2c4:	31 c0                	xor    %eax,%eax
    a2c6:	e8 25 80 ff ff       	call   22f0 <syscall@plt>
    a2cb:	48 83 c4 18          	add    $0x18,%rsp
    a2cf:	c3                   	ret

000000000000a2d0 <fwp_sock_gone>:
    a2d0:	55                   	push   %rbp
    a2d1:	53                   	push   %rbx
    a2d2:	48 83 ec 18          	sub    $0x18,%rsp
    a2d6:	89 fb                	mov    %edi,%ebx
    a2d8:	89 7c 24 10          	mov    %edi,0x10(%rsp)
    a2dc:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%rsp)
    a2e3:	00 
    a2e4:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    a2e9:	31 ed                	xor    %ebp,%ebp
    a2eb:	be 01 00 00 00       	mov    $0x1,%esi
    a2f0:	31 d2                	xor    %edx,%edx
    a2f2:	e8 b9 80 ff ff       	call   23b0 <poll@plt>
    a2f7:	85 c0                	test   %eax,%eax
    a2f9:	7e 2b                	jle    a326 <fwp_sock_gone+0x56>
    a2fb:	bd 01 00 00 00       	mov    $0x1,%ebp
    a300:	f6 44 24 16 18       	testb  $0x18,0x16(%rsp)
    a305:	75 1f                	jne    a326 <fwp_sock_gone+0x56>
    a307:	48 8d 74 24 0f       	lea    0xf(%rsp),%rsi
    a30c:	ba 01 00 00 00       	mov    $0x1,%edx
    a311:	89 df                	mov    %ebx,%edi
    a313:	b9 42 00 00 00       	mov    $0x42,%ecx
    a318:	e8 43 7d ff ff       	call   2060 <recv@plt>
    a31d:	31 ed                	xor    %ebp,%ebp
    a31f:	48 85 c0             	test   %rax,%rax
    a322:	40 0f 94 c5          	sete   %bpl
    a326:	89 e8                	mov    %ebp,%eax
    a328:	48 83 c4 18          	add    $0x18,%rsp
    a32c:	5b                   	pop    %rbx
    a32d:	5d                   	pop    %rbp
    a32e:	c3                   	ret
    a32f:	90                   	nop

000000000000a330 <fwp_pipe_poll>:
    a330:	83 3d 7d a9 00 00 00 	cmpl   $0x0,0xa97d(%rip)        # 14cb4 <fwp_po_listen>
    a337:	0f 88 9b 01 00 00    	js     a4d8 <fwp_pipe_poll+0x1a8>
    a33d:	55                   	push   %rbp
    a33e:	41 57                	push   %r15
    a340:	41 56                	push   %r14
    a342:	53                   	push   %rbx
    a343:	48 83 ec 28          	sub    $0x28,%rsp
    a347:	e8 44 fb ff ff       	call   9e90 <fwp_now_ns>
    a34c:	48 3b 05 0d ab 02 00 	cmp    0x2ab0d(%rip),%rax        # 34e60 <fwp_po_next_check>
    a353:	0f 8c 75 01 00 00    	jl     a4ce <fwp_pipe_poll+0x19e>
    a359:	49 89 c6             	mov    %rax,%r14
    a35c:	48 05 40 42 0f 00    	add    $0xf4240,%rax
    a362:	48 89 05 f7 aa 02 00 	mov    %rax,0x2aaf7(%rip)        # 34e60 <fwp_po_next_check>
    a369:	8b 3d 45 a9 00 00    	mov    0xa945(%rip),%edi        # 14cb4 <fwp_po_listen>
    a36f:	31 f6                	xor    %esi,%esi
    a371:	31 d2                	xor    %edx,%edx
    a373:	e8 b8 80 ff ff       	call   2430 <accept@plt>
    a378:	85 c0                	test   %eax,%eax
    a37a:	0f 88 10 01 00 00    	js     a490 <fwp_pipe_poll+0x160>
    a380:	89 c3                	mov    %eax,%ebx
    a382:	8b 3d 2c a9 00 00    	mov    0xa92c(%rip),%edi        # 14cb4 <fwp_po_listen>
    a388:	e8 93 7e ff ff       	call   2220 <close@plt>
    a38d:	c7 05 1d a9 00 00 ff 	movl   $0xffffffff,0xa91d(%rip)        # 14cb4 <fwp_po_listen>
    a394:	ff ff ff 
    a397:	89 df                	mov    %ebx,%edi
    a399:	be 02 00 00 00       	mov    $0x2,%esi
    a39e:	ba 01 00 00 00       	mov    $0x1,%edx
    a3a3:	31 c0                	xor    %eax,%eax
    a3a5:	e8 66 7d ff ff       	call   2110 <fcntl@plt>
    a3aa:	89 df                	mov    %ebx,%edi
    a3ac:	be 03 00 00 00       	mov    $0x3,%esi
    a3b1:	31 c0                	xor    %eax,%eax
    a3b3:	e8 58 7d ff ff       	call   2110 <fcntl@plt>
    a3b8:	25 ff f7 ff ff       	and    $0xfffff7ff,%eax
    a3bd:	89 df                	mov    %ebx,%edi
    a3bf:	be 04 00 00 00       	mov    $0x4,%esi
    a3c4:	89 c2                	mov    %eax,%edx
    a3c6:	31 c0                	xor    %eax,%eax
    a3c8:	e8 43 7d ff ff       	call   2110 <fcntl@plt>
    a3cd:	c7 44 24 18 0c 00 00 	movl   $0xc,0x18(%rsp)
    a3d4:	00 
    a3d5:	89 5c 24 10          	mov    %ebx,0x10(%rsp)
    a3d9:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%rsp)
    a3e0:	00 
    a3e1:	48 8d 4c 24 1c       	lea    0x1c(%rsp),%rcx
    a3e6:	4c 8d 44 24 18       	lea    0x18(%rsp),%r8
    a3eb:	89 df                	mov    %ebx,%edi
    a3ed:	be 01 00 00 00       	mov    $0x1,%esi
    a3f2:	ba 11 00 00 00       	mov    $0x11,%edx
    a3f7:	e8 94 7e ff ff       	call   2290 <getsockopt@plt>
    a3fc:	85 c0                	test   %eax,%eax
    a3fe:	0f 85 c3 00 00 00    	jne    a4c7 <fwp_pipe_poll+0x197>
    a404:	8b 6c 24 20          	mov    0x20(%rsp),%ebp
    a408:	e8 63 7d ff ff       	call   2170 <getuid@plt>
    a40d:	39 c5                	cmp    %eax,%ebp
    a40f:	0f 85 b2 00 00 00    	jne    a4c7 <fwp_pipe_poll+0x197>
    a415:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    a41a:	be 01 00 00 00       	mov    $0x1,%esi
    a41f:	ba e8 03 00 00       	mov    $0x3e8,%edx
    a424:	e8 87 7f ff ff       	call   23b0 <poll@plt>
    a429:	85 c0                	test   %eax,%eax
    a42b:	0f 8e 96 00 00 00    	jle    a4c7 <fwp_pipe_poll+0x197>
    a431:	48 8d 74 24 03       	lea    0x3(%rsp),%rsi
    a436:	ba 05 00 00 00       	mov    $0x5,%edx
    a43b:	89 df                	mov    %ebx,%edi
    a43d:	31 c9                	xor    %ecx,%ecx
    a43f:	e8 1c 7c ff ff       	call   2060 <recv@plt>
    a444:	48 85 c0             	test   %rax,%rax
    a447:	7e 7e                	jle    a4c7 <fwp_pipe_poll+0x197>
    a449:	49 89 c6             	mov    %rax,%r14
    a44c:	4c 8d 7c 24 10       	lea    0x10(%rsp),%r15
    a451:	49 83 fe 04          	cmp    $0x4,%r14
    a455:	77 59                	ja     a4b0 <fwp_pipe_poll+0x180>
    a457:	be 01 00 00 00       	mov    $0x1,%esi
    a45c:	4c 89 ff             	mov    %r15,%rdi
    a45f:	ba e8 03 00 00       	mov    $0x3e8,%edx
    a464:	e8 47 7f ff ff       	call   23b0 <poll@plt>
    a469:	85 c0                	test   %eax,%eax
    a46b:	7e 5a                	jle    a4c7 <fwp_pipe_poll+0x197>
    a46d:	4a 8d 34 34          	lea    (%rsp,%r14,1),%rsi
    a471:	48 83 c6 03          	add    $0x3,%rsi
    a475:	ba 05 00 00 00       	mov    $0x5,%edx
    a47a:	4c 29 f2             	sub    %r14,%rdx
    a47d:	89 df                	mov    %ebx,%edi
    a47f:	31 c9                	xor    %ecx,%ecx
    a481:	e8 da 7b ff ff       	call   2060 <recv@plt>
    a486:	49 01 c6             	add    %rax,%r14
    a489:	48 85 c0             	test   %rax,%rax
    a48c:	7f c3                	jg     a451 <fwp_pipe_poll+0x121>
    a48e:	eb 37                	jmp    a4c7 <fwp_pipe_poll+0x197>
    a490:	4c 3b 35 a1 a9 01 00 	cmp    0x1a9a1(%rip),%r14        # 24e38 <fwp_po_give_up>
    a497:	7e 35                	jle    a4ce <fwp_pipe_poll+0x19e>
    a499:	8b 3d 15 a8 00 00    	mov    0xa815(%rip),%edi        # 14cb4 <fwp_po_listen>
    a49f:	e8 7c 7d ff ff       	call   2220 <close@plt>
    a4a4:	c7 05 06 a8 00 00 ff 	movl   $0xffffffff,0xa806(%rip)        # 14cb4 <fwp_po_listen>
    a4ab:	ff ff ff 
    a4ae:	eb 1e                	jmp    a4ce <fwp_pipe_poll+0x19e>
    a4b0:	81 7c 24 03 46 57 50 	cmpl   $0x54505746,0x3(%rsp)
    a4b7:	54 
    a4b8:	75 0d                	jne    a4c7 <fwp_pipe_poll+0x197>
    a4ba:	0f b6 44 24 07       	movzbl 0x7(%rsp),%eax
    a4bf:	8d 48 fd             	lea    -0x3(%rax),%ecx
    a4c2:	80 f9 fd             	cmp    $0xfd,%cl
    a4c5:	77 12                	ja     a4d9 <fwp_pipe_poll+0x1a9>
    a4c7:	89 df                	mov    %ebx,%edi
    a4c9:	e8 52 7d ff ff       	call   2220 <close@plt>
    a4ce:	48 83 c4 28          	add    $0x28,%rsp
    a4d2:	5b                   	pop    %rbx
    a4d3:	41 5e                	pop    %r14
    a4d5:	41 5f                	pop    %r15
    a4d7:	5d                   	pop    %rbp
    a4d8:	c3                   	ret
    a4d9:	89 1d d9 a7 00 00    	mov    %ebx,0xa7d9(%rip)        # 14cb8 <fwp_po_sock>
    a4df:	bb 01 00 00 00       	mov    $0x1,%ebx
    a4e4:	3c 02                	cmp    $0x2,%al
    a4e6:	75 10                	jne    a4f8 <fwp_pipe_poll+0x1c8>
    a4e8:	e8 53 00 00 00       	call   a540 <fwp_po_make_ring>
    a4ed:	83 f8 01             	cmp    $0x1,%eax
    a4f0:	bb 02 00 00 00       	mov    $0x2,%ebx
    a4f5:	83 db 00             	sbb    $0x0,%ebx
    a4f8:	c7 44 24 08 02 01 00 	movl   $0x102,0x8(%rsp)
    a4ff:	00 
    a500:	c6 44 24 0c 00       	movb   $0x0,0xc(%rsp)
    a505:	88 5c 24 0d          	mov    %bl,0xd(%rsp)
    a509:	4c 8b 35 a8 8a 00 00 	mov    0x8aa8(%rip),%r14        # 12fb8 <stdout@GLIBC_2.2.5>
    a510:	49 8b 0e             	mov    (%r14),%rcx
    a513:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    a518:	be 01 00 00 00       	mov    $0x1,%esi
    a51d:	ba 06 00 00 00       	mov    $0x6,%edx
    a522:	e8 69 7f ff ff       	call   2490 <fwrite@plt>
    a527:	49 8b 3e             	mov    (%r14),%rdi
    a52a:	e8 11 7e ff ff       	call   2340 <fflush@plt>
    a52f:	89 1d 0b a9 01 00    	mov    %ebx,0x1a90b(%rip)        # 24e40 <fwp_po_kind>
    a535:	eb 97                	jmp    a4ce <fwp_pipe_poll+0x19e>
    a537:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    a53e:	00 00 

000000000000a540 <fwp_po_make_ring>:
    a540:	55                   	push   %rbp
    a541:	41 57                	push   %r15
    a543:	41 56                	push   %r14
    a545:	53                   	push   %rbx
    a546:	48 83 ec 68          	sub    $0x68,%rsp
    a54a:	48 8d 35 b4 3d 00 00 	lea    0x3db4(%rip),%rsi        # e305 <exec_in_fp0+0xca5>
    a551:	31 ed                	xor    %ebp,%ebp
    a553:	bf 3f 01 00 00       	mov    $0x13f,%edi
    a558:	ba 01 00 00 00       	mov    $0x1,%edx
    a55d:	31 c0                	xor    %eax,%eax
    a55f:	e8 8c 7d ff ff       	call   22f0 <syscall@plt>
    a564:	48 89 c3             	mov    %rax,%rbx
    a567:	85 db                	test   %ebx,%ebx
    a569:	78 17                	js     a582 <fwp_po_make_ring+0x42>
    a56b:	be 00 10 10 00       	mov    $0x101000,%esi
    a570:	89 df                	mov    %ebx,%edi
    a572:	e8 59 7c ff ff       	call   21d0 <ftruncate@plt>
    a577:	85 c0                	test   %eax,%eax
    a579:	74 14                	je     a58f <fwp_po_make_ring+0x4f>
    a57b:	89 df                	mov    %ebx,%edi
    a57d:	e8 9e 7c ff ff       	call   2220 <close@plt>
    a582:	89 e8                	mov    %ebp,%eax
    a584:	48 83 c4 68          	add    $0x68,%rsp
    a588:	5b                   	pop    %rbx
    a589:	41 5e                	pop    %r14
    a58b:	41 5f                	pop    %r15
    a58d:	5d                   	pop    %rbp
    a58e:	c3                   	ret
    a58f:	be 00 10 10 00       	mov    $0x101000,%esi
    a594:	31 ff                	xor    %edi,%edi
    a596:	ba 03 00 00 00       	mov    $0x3,%edx
    a59b:	b9 01 00 00 00       	mov    $0x1,%ecx
    a5a0:	41 89 d8             	mov    %ebx,%r8d
    a5a3:	45 31 c9             	xor    %r9d,%r9d
    a5a6:	e8 d5 7b ff ff       	call   2180 <mmap@plt>
    a5ab:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    a5af:	74 ca                	je     a57b <fwp_po_make_ring+0x3b>
    a5b1:	49 89 c6             	mov    %rax,%r14
    a5b4:	48 b8 46 57 50 53 01 	movabs $0x153505746,%rax
    a5bb:	00 00 00 
    a5be:	49 89 06             	mov    %rax,(%r14)
    a5c1:	49 c7 46 08 00 00 10 	movq   $0x100000,0x8(%r14)
    a5c8:	00 
    a5c9:	c6 44 24 07 53       	movb   $0x53,0x7(%rsp)
    a5ce:	48 8d 44 24 07       	lea    0x7(%rsp),%rax
    a5d3:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    a5d8:	48 c7 44 24 28 01 00 	movq   $0x1,0x28(%rsp)
    a5df:	00 00 
    a5e1:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
    a5e8:	00 00 
    a5ea:	0f 57 c0             	xorps  %xmm0,%xmm0
    a5ed:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    a5f2:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
    a5f7:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    a5fc:	48 c7 44 24 60 00 00 	movq   $0x0,0x60(%rsp)
    a603:	00 00 
    a605:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    a60a:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    a60f:	48 c7 44 24 48 01 00 	movq   $0x1,0x48(%rsp)
    a616:	00 00 
    a618:	48 8d 44 24 08       	lea    0x8(%rsp),%rax
    a61d:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    a622:	48 c7 44 24 58 18 00 	movq   $0x18,0x58(%rsp)
    a629:	00 00 
    a62b:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
    a632:	00 00 00 
    a635:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    a63a:	48 c7 44 24 08 14 00 	movq   $0x14,0x8(%rsp)
    a641:	00 00 
    a643:	89 5c 24 18          	mov    %ebx,0x18(%rsp)
    a647:	8b 3d 6b a6 00 00    	mov    0xa66b(%rip),%edi        # 14cb8 <fwp_po_sock>
    a64d:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
    a652:	ba 00 40 00 00       	mov    $0x4000,%edx
    a657:	e8 64 7a ff ff       	call   20c0 <sendmsg@plt>
    a65c:	49 89 c7             	mov    %rax,%r15
    a65f:	89 df                	mov    %ebx,%edi
    a661:	e8 ba 7b ff ff       	call   2220 <close@plt>
    a666:	49 83 ff 01          	cmp    $0x1,%r15
    a66a:	75 11                	jne    a67d <fwp_po_make_ring+0x13d>
    a66c:	4c 89 35 dd a7 02 00 	mov    %r14,0x2a7dd(%rip)        # 34e50 <fwp_po_ring>
    a673:	bd 01 00 00 00       	mov    $0x1,%ebp
    a678:	e9 05 ff ff ff       	jmp    a582 <fwp_po_make_ring+0x42>
    a67d:	be 00 10 10 00       	mov    $0x101000,%esi
    a682:	4c 89 f7             	mov    %r14,%rdi
    a685:	e8 f6 7c ff ff       	call   2380 <munmap@plt>
    a68a:	31 ed                	xor    %ebp,%ebp
    a68c:	e9 f1 fe ff ff       	jmp    a582 <fwp_po_make_ring+0x42>
    a691:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a698:	0f 1f 84 00 00 00 00 
    a69f:	00 

000000000000a6a0 <fwp_apply>:
    a6a0:	55                   	push   %rbp
    a6a1:	48 89 e5             	mov    %rsp,%rbp
    a6a4:	41 57                	push   %r15
    a6a6:	41 56                	push   %r14
    a6a8:	41 55                	push   %r13
    a6aa:	41 54                	push   %r12
    a6ac:	53                   	push   %rbx
    a6ad:	48 83 ec 18          	sub    $0x18,%rsp
    a6b1:	48 89 f3             	mov    %rsi,%rbx
    a6b4:	49 89 ff             	mov    %rdi,%r15
    a6b7:	be 01 00 00 00       	mov    $0x1,%esi
    a6bc:	eb 1e                	jmp    a6dc <fwp_apply+0x3c>
    a6be:	66 90                	xchg   %ax,%ax
    a6c0:	4a 8d 1c f3          	lea    (%rbx,%r14,8),%rbx
    a6c4:	31 c9                	xor    %ecx,%ecx
    a6c6:	49 89 c7             	mov    %rax,%r15
    a6c9:	4c 8b 75 c8          	mov    -0x38(%rbp),%r14
    a6cd:	48 8b 65 c0          	mov    -0x40(%rbp),%rsp
    a6d1:	89 d6                	mov    %edx,%esi
    a6d3:	83 f9 01             	cmp    $0x1,%ecx
    a6d6:	0f 84 ff 03 00 00    	je     aadb <fwp_apply+0x43b>
    a6dc:	48 8b 05 bd a6 00 00 	mov    0xa6bd(%rip),%rax        # 14da0 <fwp_fns>
    a6e3:	41 8b 0f             	mov    (%r15),%ecx
    a6e6:	45 8b 67 04          	mov    0x4(%r15),%r12d
    a6ea:	48 c1 e1 05          	shl    $0x5,%rcx
    a6ee:	44 8b 2c 08          	mov    (%rax,%rcx,1),%r13d
    a6f2:	4d 85 e4             	test   %r12,%r12
    a6f5:	75 39                	jne    a730 <fwp_apply+0x90>
    a6f7:	41 8d 55 ff          	lea    -0x1(%r13),%edx
    a6fb:	39 f2                	cmp    %esi,%edx
    a6fd:	73 31                	jae    a730 <fwp_apply+0x90>
    a6ff:	49 89 f7             	mov    %rsi,%r15
    a702:	48 89 df             	mov    %rbx,%rdi
    a705:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    a709:	4c 89 fe             	mov    %r15,%rsi
    a70c:	49 89 c7             	mov    %rax,%r15
    a70f:	44 39 ee             	cmp    %r13d,%esi
    a712:	0f 84 c0 03 00 00    	je     aad8 <fwp_apply+0x438>
    a718:	4a 8d 1c eb          	lea    (%rbx,%r13,8),%rbx
    a71c:	44 29 ee             	sub    %r13d,%esi
    a71f:	b9 03 00 00 00       	mov    $0x3,%ecx
    a724:	83 f9 01             	cmp    $0x1,%ecx
    a727:	75 b3                	jne    a6dc <fwp_apply+0x3c>
    a729:	e9 ad 03 00 00       	jmp    aadb <fwp_apply+0x43b>
    a72e:	66 90                	xchg   %ax,%ax
    a730:	4c 89 75 c8          	mov    %r14,-0x38(%rbp)
    a734:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    a738:	45 8d 34 34          	lea    (%r12,%rsi,1),%r14d
    a73c:	45 39 ee             	cmp    %r13d,%r14d
    a73f:	0f 82 1a 02 00 00    	jb     a95f <fwp_apply+0x2bf>
    a745:	48 89 65 c0          	mov    %rsp,-0x40(%rbp)
    a749:	45 89 eb             	mov    %r13d,%r11d
    a74c:	41 83 fd 02          	cmp    $0x2,%r13d
    a750:	ba 01 00 00 00       	mov    $0x1,%edx
    a755:	41 0f 43 d5          	cmovae %r13d,%edx
    a759:	48 8d 14 d5 0f 00 00 	lea    0xf(,%rdx,8),%rdx
    a760:	00 
    a761:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
    a765:	48 89 e7             	mov    %rsp,%rdi
    a768:	48 29 d7             	sub    %rdx,%rdi
    a76b:	48 89 fc             	mov    %rdi,%rsp
    a76e:	4d 85 e4             	test   %r12,%r12
    a771:	0f 84 c9 00 00 00    	je     a840 <fwp_apply+0x1a0>
    a777:	41 83 fc 04          	cmp    $0x4,%r12d
    a77b:	72 10                	jb     a78d <fwp_apply+0xed>
    a77d:	48 89 fa             	mov    %rdi,%rdx
    a780:	4c 29 fa             	sub    %r15,%rdx
    a783:	48 83 c2 f8          	add    $0xfffffffffffffff8,%rdx
    a787:	48 83 fa 20          	cmp    $0x20,%rdx
    a78b:	73 65                	jae    a7f2 <fwp_apply+0x152>
    a78d:	31 d2                	xor    %edx,%edx
    a78f:	4d 89 e0             	mov    %r12,%r8
    a792:	48 89 d6             	mov    %rdx,%rsi
    a795:	49 83 e0 03          	and    $0x3,%r8
    a799:	74 16                	je     a7b1 <fwp_apply+0x111>
    a79b:	48 89 d6             	mov    %rdx,%rsi
    a79e:	66 90                	xchg   %ax,%ax
    a7a0:	4d 8b 4c f7 08       	mov    0x8(%r15,%rsi,8),%r9
    a7a5:	4c 89 0c f7          	mov    %r9,(%rdi,%rsi,8)
    a7a9:	48 ff c6             	inc    %rsi
    a7ac:	49 ff c8             	dec    %r8
    a7af:	75 ef                	jne    a7a0 <fwp_apply+0x100>
    a7b1:	4c 29 e2             	sub    %r12,%rdx
    a7b4:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    a7b8:	0f 87 82 00 00 00    	ja     a840 <fwp_apply+0x1a0>
    a7be:	66 90                	xchg   %ax,%ax
    a7c0:	49 8b 54 f7 08       	mov    0x8(%r15,%rsi,8),%rdx
    a7c5:	48 89 14 f7          	mov    %rdx,(%rdi,%rsi,8)
    a7c9:	49 8b 54 f7 10       	mov    0x10(%r15,%rsi,8),%rdx
    a7ce:	48 89 54 f7 08       	mov    %rdx,0x8(%rdi,%rsi,8)
    a7d3:	49 8b 54 f7 18       	mov    0x18(%r15,%rsi,8),%rdx
    a7d8:	48 89 54 f7 10       	mov    %rdx,0x10(%rdi,%rsi,8)
    a7dd:	49 8b 54 f7 20       	mov    0x20(%r15,%rsi,8),%rdx
    a7e2:	48 89 54 f7 18       	mov    %rdx,0x18(%rdi,%rsi,8)
    a7e7:	48 83 c6 04          	add    $0x4,%rsi
    a7eb:	49 39 f4             	cmp    %rsi,%r12
    a7ee:	75 d0                	jne    a7c0 <fwp_apply+0x120>
    a7f0:	eb 4e                	jmp    a840 <fwp_apply+0x1a0>
    a7f2:	44 89 e2             	mov    %r12d,%edx
    a7f5:	83 e2 fc             	and    $0xfffffffc,%edx
    a7f8:	4a 8d 34 e5 00 00 00 	lea    0x0(,%r12,8),%rsi
    a7ff:	00 
    a800:	48 83 e6 e0          	and    $0xffffffffffffffe0,%rsi
    a804:	45 31 c0             	xor    %r8d,%r8d
    a807:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    a80e:	00 00 
    a810:	43 0f 10 44 07 08    	movups 0x8(%r15,%r8,1),%xmm0
    a816:	43 0f 10 4c 07 18    	movups 0x18(%r15,%r8,1),%xmm1
    a81c:	42 0f 29 04 07       	movaps %xmm0,(%rdi,%r8,1)
    a821:	42 0f 29 4c 07 10    	movaps %xmm1,0x10(%rdi,%r8,1)
    a827:	49 83 c0 20          	add    $0x20,%r8
    a82b:	4c 39 c6             	cmp    %r8,%rsi
    a82e:	75 e0                	jne    a810 <fwp_apply+0x170>
    a830:	4c 39 e2             	cmp    %r12,%rdx
    a833:	0f 85 56 ff ff ff    	jne    a78f <fwp_apply+0xef>
    a839:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    a840:	45 29 e3             	sub    %r12d,%r11d
    a843:	45 89 de             	mov    %r11d,%r14d
    a846:	45 39 e5             	cmp    %r12d,%r13d
    a849:	0f 84 85 00 00 00    	je     a8d4 <fwp_apply+0x234>
    a84f:	41 83 fb 0e          	cmp    $0xe,%r11d
    a853:	0f 83 a0 00 00 00    	jae    a8f9 <fwp_apply+0x259>
    a859:	31 d2                	xor    %edx,%edx
    a85b:	4d 89 f0             	mov    %r14,%r8
    a85e:	48 89 d6             	mov    %rdx,%rsi
    a861:	49 83 e0 03          	and    $0x3,%r8
    a865:	74 1d                	je     a884 <fwp_apply+0x1e4>
    a867:	48 89 d6             	mov    %rdx,%rsi
    a86a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    a870:	4c 8b 0c f3          	mov    (%rbx,%rsi,8),%r9
    a874:	45 8d 14 34          	lea    (%r12,%rsi,1),%r10d
    a878:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    a87c:	48 ff c6             	inc    %rsi
    a87f:	49 ff c8             	dec    %r8
    a882:	75 ec                	jne    a870 <fwp_apply+0x1d0>
    a884:	4c 29 f2             	sub    %r14,%rdx
    a887:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    a88b:	77 47                	ja     a8d4 <fwp_apply+0x234>
    a88d:	0f 1f 00             	nopl   (%rax)
    a890:	48 8b 14 f3          	mov    (%rbx,%rsi,8),%rdx
    a894:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    a898:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    a89c:	48 8b 54 f3 08       	mov    0x8(%rbx,%rsi,8),%rdx
    a8a1:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    a8a5:	41 ff c0             	inc    %r8d
    a8a8:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    a8ac:	48 8b 54 f3 10       	mov    0x10(%rbx,%rsi,8),%rdx
    a8b1:	45 8d 44 34 02       	lea    0x2(%r12,%rsi,1),%r8d
    a8b6:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    a8ba:	48 8b 54 f3 18       	mov    0x18(%rbx,%rsi,8),%rdx
    a8bf:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    a8c3:	41 83 c0 03          	add    $0x3,%r8d
    a8c7:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    a8cb:	48 83 c6 04          	add    $0x4,%rsi
    a8cf:	49 39 f6             	cmp    %rsi,%r14
    a8d2:	75 bc                	jne    a890 <fwp_apply+0x1f0>
    a8d4:	45 89 dc             	mov    %r11d,%r12d
    a8d7:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    a8db:	b9 01 00 00 00       	mov    $0x1,%ecx
    a8e0:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    a8e4:	89 f2                	mov    %esi,%edx
    a8e6:	44 29 e2             	sub    %r12d,%edx
    a8e9:	0f 85 d1 fd ff ff    	jne    a6c0 <fwp_apply+0x20>
    a8ef:	89 f2                	mov    %esi,%edx
    a8f1:	49 89 c6             	mov    %rax,%r14
    a8f4:	e9 d4 fd ff ff       	jmp    a6cd <fwp_apply+0x2d>
    a8f9:	49 8d 56 ff          	lea    -0x1(%r14),%rdx
    a8fd:	89 d6                	mov    %edx,%esi
    a8ff:	44 01 e6             	add    %r12d,%esi
    a902:	0f 82 51 ff ff ff    	jb     a859 <fwp_apply+0x1b9>
    a908:	48 c1 ea 20          	shr    $0x20,%rdx
    a90c:	ba 00 00 00 00       	mov    $0x0,%edx
    a911:	0f 85 44 ff ff ff    	jne    a85b <fwp_apply+0x1bb>
    a917:	4a 8d 14 e7          	lea    (%rdi,%r12,8),%rdx
    a91b:	48 29 da             	sub    %rbx,%rdx
    a91e:	48 83 fa 20          	cmp    $0x20,%rdx
    a922:	0f 82 31 ff ff ff    	jb     a859 <fwp_apply+0x1b9>
    a928:	44 89 f2             	mov    %r14d,%edx
    a92b:	83 e2 fc             	and    $0xfffffffc,%edx
    a92e:	31 f6                	xor    %esi,%esi
    a930:	0f 10 04 f3          	movups (%rbx,%rsi,8),%xmm0
    a934:	0f 10 4c f3 10       	movups 0x10(%rbx,%rsi,8),%xmm1
    a939:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    a93d:	42 0f 11 04 c7       	movups %xmm0,(%rdi,%r8,8)
    a942:	42 0f 11 4c c7 10    	movups %xmm1,0x10(%rdi,%r8,8)
    a948:	48 83 c6 04          	add    $0x4,%rsi
    a94c:	48 39 f2             	cmp    %rsi,%rdx
    a94f:	75 df                	jne    a930 <fwp_apply+0x290>
    a951:	4c 39 f2             	cmp    %r14,%rdx
    a954:	0f 85 01 ff ff ff    	jne    a85b <fwp_apply+0x1bb>
    a95a:	e9 75 ff ff ff       	jmp    a8d4 <fwp_apply+0x234>
    a95f:	44 89 f0             	mov    %r14d,%eax
    a962:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    a969:	00 
    a96a:	e8 c1 8c ff ff       	call   3630 <fwp_alloc>
    a96f:	41 8b 0f             	mov    (%r15),%ecx
    a972:	89 08                	mov    %ecx,(%rax)
    a974:	44 89 70 04          	mov    %r14d,0x4(%rax)
    a978:	49 89 c6             	mov    %rax,%r14
    a97b:	4d 85 e4             	test   %r12,%r12
    a97e:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    a982:	0f 84 b9 00 00 00    	je     aa41 <fwp_apply+0x3a1>
    a988:	31 c0                	xor    %eax,%eax
    a98a:	41 83 fc 06          	cmp    $0x6,%r12d
    a98e:	72 46                	jb     a9d6 <fwp_apply+0x336>
    a990:	4c 89 f1             	mov    %r14,%rcx
    a993:	4c 29 f9             	sub    %r15,%rcx
    a996:	48 83 f9 20          	cmp    $0x20,%rcx
    a99a:	72 3a                	jb     a9d6 <fwp_apply+0x336>
    a99c:	44 89 e0             	mov    %r12d,%eax
    a99f:	83 e0 fc             	and    $0xfffffffc,%eax
    a9a2:	4a 8d 0c e5 00 00 00 	lea    0x0(,%r12,8),%rcx
    a9a9:	00 
    a9aa:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    a9ae:	31 d2                	xor    %edx,%edx
    a9b0:	41 0f 10 44 17 08    	movups 0x8(%r15,%rdx,1),%xmm0
    a9b6:	41 0f 10 4c 17 18    	movups 0x18(%r15,%rdx,1),%xmm1
    a9bc:	41 0f 11 44 16 08    	movups %xmm0,0x8(%r14,%rdx,1)
    a9c2:	41 0f 11 4c 16 18    	movups %xmm1,0x18(%r14,%rdx,1)
    a9c8:	48 83 c2 20          	add    $0x20,%rdx
    a9cc:	48 39 d1             	cmp    %rdx,%rcx
    a9cf:	75 df                	jne    a9b0 <fwp_apply+0x310>
    a9d1:	4c 39 e0             	cmp    %r12,%rax
    a9d4:	74 6b                	je     aa41 <fwp_apply+0x3a1>
    a9d6:	4c 89 e2             	mov    %r12,%rdx
    a9d9:	48 89 c1             	mov    %rax,%rcx
    a9dc:	48 83 e2 03          	and    $0x3,%rdx
    a9e0:	74 20                	je     aa02 <fwp_apply+0x362>
    a9e2:	48 89 c1             	mov    %rax,%rcx
    a9e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a9ec:	00 00 00 00 
    a9f0:	49 8b 74 cf 08       	mov    0x8(%r15,%rcx,8),%rsi
    a9f5:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    a9fa:	48 ff c1             	inc    %rcx
    a9fd:	48 ff ca             	dec    %rdx
    aa00:	75 ee                	jne    a9f0 <fwp_apply+0x350>
    aa02:	4c 29 e0             	sub    %r12,%rax
    aa05:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    aa09:	77 36                	ja     aa41 <fwp_apply+0x3a1>
    aa0b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    aa10:	49 8b 44 cf 08       	mov    0x8(%r15,%rcx,8),%rax
    aa15:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    aa1a:	49 8b 44 cf 10       	mov    0x10(%r15,%rcx,8),%rax
    aa1f:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    aa24:	49 8b 44 cf 18       	mov    0x18(%r15,%rcx,8),%rax
    aa29:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    aa2e:	49 8b 44 cf 20       	mov    0x20(%r15,%rcx,8),%rax
    aa33:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    aa38:	48 83 c1 04          	add    $0x4,%rcx
    aa3c:	49 39 cc             	cmp    %rcx,%r12
    aa3f:	75 cf                	jne    aa10 <fwp_apply+0x370>
    aa41:	85 ff                	test   %edi,%edi
    aa43:	0f 84 92 00 00 00    	je     aadb <fwp_apply+0x43b>
    aa49:	89 f8                	mov    %edi,%eax
    aa4b:	83 ff 14             	cmp    $0x14,%edi
    aa4e:	0f 83 99 00 00 00    	jae    aaed <fwp_apply+0x44d>
    aa54:	31 c9                	xor    %ecx,%ecx
    aa56:	48 89 c6             	mov    %rax,%rsi
    aa59:	48 89 ca             	mov    %rcx,%rdx
    aa5c:	48 83 e6 03          	and    $0x3,%rsi
    aa60:	74 23                	je     aa85 <fwp_apply+0x3e5>
    aa62:	48 89 ca             	mov    %rcx,%rdx
    aa65:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    aa6c:	00 00 00 00 
    aa70:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    aa74:	45 8d 04 14          	lea    (%r12,%rdx,1),%r8d
    aa78:	4b 89 7c c6 08       	mov    %rdi,0x8(%r14,%r8,8)
    aa7d:	48 ff c2             	inc    %rdx
    aa80:	48 ff ce             	dec    %rsi
    aa83:	75 eb                	jne    aa70 <fwp_apply+0x3d0>
    aa85:	48 29 c1             	sub    %rax,%rcx
    aa88:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    aa8c:	77 4d                	ja     aadb <fwp_apply+0x43b>
    aa8e:	66 90                	xchg   %ax,%ax
    aa90:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    aa94:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    aa98:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    aa9d:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    aaa2:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    aaa6:	ff c6                	inc    %esi
    aaa8:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    aaad:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    aab2:	41 8d 74 14 02       	lea    0x2(%r12,%rdx,1),%esi
    aab7:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    aabc:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    aac1:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    aac5:	83 c6 03             	add    $0x3,%esi
    aac8:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    aacd:	48 83 c2 04          	add    $0x4,%rdx
    aad1:	48 39 d0             	cmp    %rdx,%rax
    aad4:	75 ba                	jne    aa90 <fwp_apply+0x3f0>
    aad6:	eb 03                	jmp    aadb <fwp_apply+0x43b>
    aad8:	4d 89 fe             	mov    %r15,%r14
    aadb:	4c 89 f0             	mov    %r14,%rax
    aade:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    aae2:	5b                   	pop    %rbx
    aae3:	41 5c                	pop    %r12
    aae5:	41 5d                	pop    %r13
    aae7:	41 5e                	pop    %r14
    aae9:	41 5f                	pop    %r15
    aaeb:	5d                   	pop    %rbp
    aaec:	c3                   	ret
    aaed:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    aaf1:	31 c9                	xor    %ecx,%ecx
    aaf3:	89 d6                	mov    %edx,%esi
    aaf5:	44 01 e6             	add    %r12d,%esi
    aaf8:	0f 82 58 ff ff ff    	jb     aa56 <fwp_apply+0x3b6>
    aafe:	48 c1 ea 20          	shr    $0x20,%rdx
    ab02:	0f 85 4e ff ff ff    	jne    aa56 <fwp_apply+0x3b6>
    ab08:	4b 8d 0c e6          	lea    (%r14,%r12,8),%rcx
    ab0c:	48 29 d9             	sub    %rbx,%rcx
    ab0f:	48 83 c1 08          	add    $0x8,%rcx
    ab13:	48 83 f9 20          	cmp    $0x20,%rcx
    ab17:	0f 82 37 ff ff ff    	jb     aa54 <fwp_apply+0x3b4>
    ab1d:	89 c1                	mov    %eax,%ecx
    ab1f:	83 e1 fc             	and    $0xfffffffc,%ecx
    ab22:	31 d2                	xor    %edx,%edx
    ab24:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    ab2b:	00 00 00 00 00 
    ab30:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    ab34:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    ab39:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    ab3d:	41 0f 11 44 f6 08    	movups %xmm0,0x8(%r14,%rsi,8)
    ab43:	41 0f 11 4c f6 18    	movups %xmm1,0x18(%r14,%rsi,8)
    ab49:	48 83 c2 04          	add    $0x4,%rdx
    ab4d:	48 39 d1             	cmp    %rdx,%rcx
    ab50:	75 de                	jne    ab30 <fwp_apply+0x490>
    ab52:	48 39 c1             	cmp    %rax,%rcx
    ab55:	0f 85 fb fe ff ff    	jne    aa56 <fwp_apply+0x3b6>
    ab5b:	e9 7b ff ff ff       	jmp    aadb <fwp_apply+0x43b>

000000000000ab60 <fwp_pap>:
    ab60:	50                   	push   %rax
    ab61:	bf 08 00 00 00       	mov    $0x8,%edi
    ab66:	e8 c5 8a ff ff       	call   3630 <fwp_alloc>
    ab6b:	48 c7 00 01 00 00 00 	movq   $0x1,(%rax)
    ab72:	59                   	pop    %rcx
    ab73:	c3                   	ret
    ab74:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    ab7b:	00 00 00 00 00 

000000000000ab80 <fwp_exec_error>:
    ab80:	41 57                	push   %r15
    ab82:	41 56                	push   %r14
    ab84:	53                   	push   %rbx
    ab85:	48 89 f3             	mov    %rsi,%rbx
    ab88:	49 89 fe             	mov    %rdi,%r14
    ab8b:	e8 80 bd ff ff       	call   6910 <fwp_pipe_flush>
    ab90:	4c 8b 3d 49 84 00 00 	mov    0x8449(%rip),%r15        # 12fe0 <stderr@GLIBC_2.2.5>
    ab97:	49 8b 3f             	mov    (%r15),%rdi
    ab9a:	48 8d 35 85 37 00 00 	lea    0x3785(%rip),%rsi        # e326 <exec_in_fp0+0xcc6>
    aba1:	48 8d 15 f3 2a 00 00 	lea    0x2af3(%rip),%rdx        # d69b <exec_in_fp0+0x3b>
    aba8:	31 c0                	xor    %eax,%eax
    abaa:	e8 31 77 ff ff       	call   22e0 <fprintf@plt>
    abaf:	83 3b 10             	cmpl   $0x10,(%rbx)
    abb2:	75 1f                	jne    abd3 <fwp_exec_error+0x53>
    abb4:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    abb8:	48 85 ff             	test   %rdi,%rdi
    abbb:	74 16                	je     abd3 <fwp_exec_error+0x53>
    abbd:	48 8d 35 67 37 00 00 	lea    0x3767(%rip),%rsi        # e32b <exec_in_fp0+0xccb>
    abc4:	e8 f7 76 ff ff       	call   22c0 <strcmp@plt>
    abc9:	85 c0                	test   %eax,%eax
    abcb:	75 06                	jne    abd3 <fwp_exec_error+0x53>
    abcd:	83 7b 10 02          	cmpl   $0x2,0x10(%rbx)
    abd1:	74 20                	je     abf3 <fwp_exec_error+0x73>
    abd3:	49 8b 17             	mov    (%r15),%rdx
    abd6:	4c 89 f7             	mov    %r14,%rdi
    abd9:	48 89 de             	mov    %rbx,%rsi
    abdc:	e8 2f 00 00 00       	call   ac10 <fwp_display_top>
    abe1:	49 8b 37             	mov    (%r15),%rsi
    abe4:	bf 0a 00 00 00       	mov    $0xa,%edi
    abe9:	5b                   	pop    %rbx
    abea:	41 5e                	pop    %r14
    abec:	41 5f                	pop    %r15
    abee:	e9 3d 76 ff ff       	jmp    2230 <fputc@plt>
    abf3:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    abf7:	48 8b 17             	mov    (%rdi),%rdx
    abfa:	48 83 c7 08          	add    $0x8,%rdi
    abfe:	49 8b 0f             	mov    (%r15),%rcx
    ac01:	be 01 00 00 00       	mov    $0x1,%esi
    ac06:	e8 85 78 ff ff       	call   2490 <fwrite@plt>
    ac0b:	eb d4                	jmp    abe1 <fwp_exec_error+0x61>
    ac0d:	0f 1f 00             	nopl   (%rax)

000000000000ac10 <fwp_display_top>:
    ac10:	53                   	push   %rbx
    ac11:	48 83 ec 20          	sub    $0x20,%rsp
    ac15:	48 89 d3             	mov    %rdx,%rbx
    ac18:	48 89 f2             	mov    %rsi,%rdx
    ac1b:	48 89 fe             	mov    %rdi,%rsi
    ac1e:	0f 57 c0             	xorps  %xmm0,%xmm0
    ac21:	0f 29 04 24          	movaps %xmm0,(%rsp)
    ac25:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    ac2c:	00 00 
    ac2e:	48 89 e7             	mov    %rsp,%rdi
    ac31:	b9 01 00 00 00       	mov    $0x1,%ecx
    ac36:	e8 35 00 00 00       	call   ac70 <fwp_write>
    ac3b:	48 8b 3c 24          	mov    (%rsp),%rdi
    ac3f:	48 85 ff             	test   %rdi,%rdi
    ac42:	74 18                	je     ac5c <fwp_display_top+0x4c>
    ac44:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    ac49:	be 01 00 00 00       	mov    $0x1,%esi
    ac4e:	48 89 d9             	mov    %rbx,%rcx
    ac51:	e8 3a 78 ff ff       	call   2490 <fwrite@plt>
    ac56:	48 8b 3c 24          	mov    (%rsp),%rdi
    ac5a:	eb 02                	jmp    ac5e <fwp_display_top+0x4e>
    ac5c:	31 ff                	xor    %edi,%edi
    ac5e:	e8 ed 73 ff ff       	call   2050 <free@plt>
    ac63:	48 83 c4 20          	add    $0x20,%rsp
    ac67:	5b                   	pop    %rbx
    ac68:	c3                   	ret
    ac69:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000ac70 <fwp_write>:
    ac70:	55                   	push   %rbp
    ac71:	41 57                	push   %r15
    ac73:	41 56                	push   %r14
    ac75:	41 55                	push   %r13
    ac77:	41 54                	push   %r12
    ac79:	53                   	push   %rbx
    ac7a:	48 81 ec 28 02 00 00 	sub    $0x228,%rsp
    ac81:	8b 02                	mov    (%rdx),%eax
    ac83:	48 83 f8 19          	cmp    $0x19,%rax
    ac87:	0f 87 3f 05 00 00    	ja     b1cc <fwp_write+0x55c>
    ac8d:	49 89 f5             	mov    %rsi,%r13
    ac90:	48 89 fb             	mov    %rdi,%rbx
    ac93:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
    ac98:	48 8d 15 b5 26 00 00 	lea    0x26b5(%rip),%rdx        # d354 <_IO_stdin_used+0x354>
    ac9f:	48 63 34 82          	movslq (%rdx,%rax,4),%rsi
    aca3:	48 01 d6             	add    %rdx,%rsi
    aca6:	ff e6                	jmp    *%rsi
    aca8:	48 8d 15 84 36 00 00 	lea    0x3684(%rip),%rdx        # e333 <exec_in_fp0+0xcd3>
    acaf:	eb 07                	jmp    acb8 <fwp_write+0x48>
    acb1:	48 8d 15 43 36 00 00 	lea    0x3643(%rip),%rdx        # e2fb <exec_in_fp0+0xc9b>
    acb8:	4c 8d 7c 24 20       	lea    0x20(%rsp),%r15
    acbd:	be 00 02 00 00       	mov    $0x200,%esi
    acc2:	4c 89 ff             	mov    %r15,%rdi
    acc5:	4c 89 e9             	mov    %r13,%rcx
    acc8:	31 c0                	xor    %eax,%eax
    acca:	e8 f1 74 ff ff       	call   21c0 <snprintf@plt>
    accf:	48 89 df             	mov    %rbx,%rdi
    acd2:	4c 89 fe             	mov    %r15,%rsi
    acd5:	e9 ed 04 00 00       	jmp    b1c7 <fwp_write+0x557>
    acda:	83 f8 13             	cmp    $0x13,%eax
    acdd:	48 8d 05 80 36 00 00 	lea    0x3680(%rip),%rax        # e364 <exec_in_fp0+0xd04>
    ace4:	48 8d 35 7e 36 00 00 	lea    0x367e(%rip),%rsi        # e369 <exec_in_fp0+0xd09>
    aceb:	48 0f 44 f0          	cmove  %rax,%rsi
    acef:	48 89 df             	mov    %rbx,%rdi
    acf2:	e8 09 ca ff ff       	call   7700 <buf_puts>
    acf7:	49 83 7d 00 00       	cmpq   $0x0,0x0(%r13)
    acfc:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    ad01:	0f 84 cb 00 00 00    	je     add2 <fwp_write+0x162>
    ad07:	4d 89 ec             	mov    %r13,%r12
    ad0a:	48 8b 50 38          	mov    0x38(%rax),%rdx
    ad0e:	48 89 df             	mov    %rbx,%rdi
    ad11:	4c 89 eb             	mov    %r13,%rbx
    ad14:	49 8b 74 24 08       	mov    0x8(%r12),%rsi
    ad19:	49 89 c6             	mov    %rax,%r14
    ad1c:	49 89 ff             	mov    %rdi,%r15
    ad1f:	31 c9                	xor    %ecx,%ecx
    ad21:	e8 4a ff ff ff       	call   ac70 <fwp_write>
    ad26:	41 83 3e 12          	cmpl   $0x12,(%r14)
    ad2a:	75 29                	jne    ad55 <fwp_write+0xe5>
    ad2c:	48 8d 35 f5 35 00 00 	lea    0x35f5(%rip),%rsi        # e328 <exec_in_fp0+0xcc8>
    ad33:	4d 89 fe             	mov    %r15,%r14
    ad36:	4c 89 ff             	mov    %r15,%rdi
    ad39:	e8 c2 c9 ff ff       	call   7700 <buf_puts>
    ad3e:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    ad42:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    ad47:	48 8b 50 40          	mov    0x40(%rax),%rdx
    ad4b:	4c 89 ff             	mov    %r15,%rdi
    ad4e:	31 c9                	xor    %ecx,%ecx
    ad50:	e8 1b ff ff ff       	call   ac70 <fwp_write>
    ad55:	48 83 3b 02          	cmpq   $0x2,(%rbx)
    ad59:	4c 89 fb             	mov    %r15,%rbx
    ad5c:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    ad61:	72 6f                	jb     add2 <fwp_write+0x162>
    ad63:	4d 8d 74 24 20       	lea    0x20(%r12),%r14
    ad68:	bd 01 00 00 00       	mov    $0x1,%ebp
    ad6d:	4c 8d 2d 09 35 00 00 	lea    0x3509(%rip),%r13        # e27d <exec_in_fp0+0xc1d>
    ad74:	eb 17                	jmp    ad8d <fwp_write+0x11d>
    ad76:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    ad7d:	00 00 00 
    ad80:	48 ff c5             	inc    %rbp
    ad83:	49 83 c6 10          	add    $0x10,%r14
    ad87:	49 3b 2c 24          	cmp    (%r12),%rbp
    ad8b:	73 45                	jae    add2 <fwp_write+0x162>
    ad8d:	48 89 df             	mov    %rbx,%rdi
    ad90:	4c 89 ee             	mov    %r13,%rsi
    ad93:	e8 68 c9 ff ff       	call   7700 <buf_puts>
    ad98:	49 8b 76 f8          	mov    -0x8(%r14),%rsi
    ad9c:	49 8b 57 38          	mov    0x38(%r15),%rdx
    ada0:	48 89 df             	mov    %rbx,%rdi
    ada3:	31 c9                	xor    %ecx,%ecx
    ada5:	e8 c6 fe ff ff       	call   ac70 <fwp_write>
    adaa:	41 83 3f 12          	cmpl   $0x12,(%r15)
    adae:	75 d0                	jne    ad80 <fwp_write+0x110>
    adb0:	48 89 df             	mov    %rbx,%rdi
    adb3:	48 8d 35 6e 35 00 00 	lea    0x356e(%rip),%rsi        # e328 <exec_in_fp0+0xcc8>
    adba:	e8 41 c9 ff ff       	call   7700 <buf_puts>
    adbf:	49 8b 36             	mov    (%r14),%rsi
    adc2:	49 8b 57 40          	mov    0x40(%r15),%rdx
    adc6:	48 89 df             	mov    %rbx,%rdi
    adc9:	31 c9                	xor    %ecx,%ecx
    adcb:	e8 a0 fe ff ff       	call   ac70 <fwp_write>
    add0:	eb ae                	jmp    ad80 <fwp_write+0x110>
    add2:	48 89 df             	mov    %rbx,%rdi
    add5:	be 7d 00 00 00       	mov    $0x7d,%esi
    adda:	e9 48 05 00 00       	jmp    b327 <fwp_write+0x6b7>
    addf:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    ade4:	4d 8b 67 08          	mov    0x8(%r15),%r12
    ade8:	4d 85 e4             	test   %r12,%r12
    adeb:	0f 84 38 04 00 00    	je     b229 <fwp_write+0x5b9>
    adf1:	48 8d 35 a2 34 00 00 	lea    0x34a2(%rip),%rsi        # e29a <exec_in_fp0+0xc3a>
    adf8:	4c 89 e7             	mov    %r12,%rdi
    adfb:	e8 c0 74 ff ff       	call   22c0 <strcmp@plt>
    ae00:	85 c0                	test   %eax,%eax
    ae02:	0f 84 44 05 00 00    	je     b34c <fwp_write+0x6dc>
    ae08:	4d 8d 77 10          	lea    0x10(%r15),%r14
    ae0c:	48 89 df             	mov    %rbx,%rdi
    ae0f:	4c 89 e6             	mov    %r12,%rsi
    ae12:	e8 e9 c8 ff ff       	call   7700 <buf_puts>
    ae17:	48 89 df             	mov    %rbx,%rdi
    ae1a:	be 20 00 00 00       	mov    $0x20,%esi
    ae1f:	e8 bc c8 ff ff       	call   76e0 <buf_putc>
    ae24:	31 ed                	xor    %ebp,%ebp
    ae26:	e9 1f 04 00 00       	jmp    b24a <fwp_write+0x5da>
    ae2b:	4c 89 ef             	mov    %r13,%rdi
    ae2e:	e8 cd ef ff ff       	call   9e00 <fwp_tag>
    ae33:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    ae38:	49 8b 4f 18          	mov    0x18(%r15),%rcx
    ae3c:	41 89 c6             	mov    %eax,%r14d
    ae3f:	4a 8b 34 f1          	mov    (%rcx,%r14,8),%rsi
    ae43:	48 89 df             	mov    %rbx,%rdi
    ae46:	e8 b5 c8 ff ff       	call   7700 <buf_puts>
    ae4b:	49 8b 47 28          	mov    0x28(%r15),%rax
    ae4f:	42 83 3c b0 00       	cmpl   $0x0,(%rax,%r14,4)
    ae54:	0f 8e 72 03 00 00    	jle    b1cc <fwp_write+0x55c>
    ae5a:	4c 89 f1             	mov    %r14,%rcx
    ae5d:	45 31 f6             	xor    %r14d,%r14d
    ae60:	4c 89 6c 24 18       	mov    %r13,0x18(%rsp)
    ae65:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
    ae6a:	eb 3d                	jmp    aea9 <fwp_write+0x239>
    ae6c:	0f 1f 40 00          	nopl   0x0(%rax)
    ae70:	48 89 dd             	mov    %rbx,%rbp
    ae73:	48 89 df             	mov    %rbx,%rdi
    ae76:	4c 89 e6             	mov    %r12,%rsi
    ae79:	4c 89 ea             	mov    %r13,%rdx
    ae7c:	31 c9                	xor    %ecx,%ecx
    ae7e:	e8 ed fd ff ff       	call   ac70 <fwp_write>
    ae83:	49 ff c6             	inc    %r14
    ae86:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    ae8b:	49 8b 47 28          	mov    0x28(%r15),%rax
    ae8f:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    ae94:	48 63 04 88          	movslq (%rax,%rcx,4),%rax
    ae98:	49 39 c6             	cmp    %rax,%r14
    ae9b:	4c 8b 6c 24 18       	mov    0x18(%rsp),%r13
    aea0:	48 89 eb             	mov    %rbp,%rbx
    aea3:	0f 8d 23 03 00 00    	jge    b1cc <fwp_write+0x55c>
    aea9:	4f 8b 64 f5 08       	mov    0x8(%r13,%r14,8),%r12
    aeae:	49 8b 47 30          	mov    0x30(%r15),%rax
    aeb2:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    aeb6:	4e 8b 2c f0          	mov    (%rax,%r14,8),%r13
    aeba:	48 89 df             	mov    %rbx,%rdi
    aebd:	be 20 00 00 00       	mov    $0x20,%esi
    aec2:	e8 19 c8 ff ff       	call   76e0 <buf_putc>
    aec7:	4c 89 e7             	mov    %r12,%rdi
    aeca:	4c 89 ee             	mov    %r13,%rsi
    aecd:	e8 8e 0e 00 00       	call   bd60 <fwp_needs_parens>
    aed2:	85 c0                	test   %eax,%eax
    aed4:	74 9a                	je     ae70 <fwp_write+0x200>
    aed6:	48 89 df             	mov    %rbx,%rdi
    aed9:	be 28 00 00 00       	mov    $0x28,%esi
    aede:	e8 fd c7 ff ff       	call   76e0 <buf_putc>
    aee3:	48 89 df             	mov    %rbx,%rdi
    aee6:	4c 89 e6             	mov    %r12,%rsi
    aee9:	4c 89 ea             	mov    %r13,%rdx
    aeec:	31 c9                	xor    %ecx,%ecx
    aeee:	e8 7d fd ff ff       	call   ac70 <fwp_write>
    aef3:	48 89 dd             	mov    %rbx,%rbp
    aef6:	48 89 df             	mov    %rbx,%rdi
    aef9:	be 29 00 00 00       	mov    $0x29,%esi
    aefe:	e8 dd c7 ff ff       	call   76e0 <buf_putc>
    af03:	e9 7b ff ff ff       	jmp    ae83 <fwp_write+0x213>
    af08:	4c 89 ef             	mov    %r13,%rdi
    af0b:	e8 c0 a9 ff ff       	call   58d0 <fwp_f64>
    af10:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    af15:	4c 89 f7             	mov    %r14,%rdi
    af18:	e8 93 08 00 00       	call   b7b0 <fwp_fmt_f64>
    af1d:	e9 9f 02 00 00       	jmp    b1c1 <fwp_write+0x551>
    af22:	48 89 df             	mov    %rbx,%rdi
    af25:	be 3c 00 00 00       	mov    $0x3c,%esi
    af2a:	e8 b1 c7 ff ff       	call   76e0 <buf_putc>
    af2f:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    af34:	48 8b 70 08          	mov    0x8(%rax),%rsi
    af38:	48 89 df             	mov    %rbx,%rdi
    af3b:	e9 d7 02 00 00       	jmp    b217 <fwp_write+0x5a7>
    af40:	48 8d 35 fc 33 00 00 	lea    0x33fc(%rip),%rsi        # e343 <exec_in_fp0+0xce3>
    af47:	e9 99 02 00 00       	jmp    b1e5 <fwp_write+0x575>
    af4c:	49 8d 75 08          	lea    0x8(%r13),%rsi
    af50:	49 8b 55 00          	mov    0x0(%r13),%rdx
    af54:	48 89 df             	mov    %rbx,%rdi
    af57:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    af5e:	85 c9                	test   %ecx,%ecx
    af60:	0f 84 d7 03 00 00    	je     b33d <fwp_write+0x6cd>
    af66:	5b                   	pop    %rbx
    af67:	41 5c                	pop    %r12
    af69:	41 5d                	pop    %r13
    af6b:	41 5e                	pop    %r14
    af6d:	41 5f                	pop    %r15
    af6f:	5d                   	pop    %rbp
    af70:	e9 bb c7 ff ff       	jmp    7730 <buf_put>
    af75:	4c 89 ef             	mov    %r13,%rdi
    af78:	e8 33 ee ff ff       	call   9db0 <fwp_u128>
    af7d:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    af82:	4c 89 f7             	mov    %r14,%rdi
    af85:	48 89 c6             	mov    %rax,%rsi
    af88:	e8 13 04 00 00       	call   b3a0 <fwp_fmt_u128>
    af8d:	e9 2f 02 00 00       	jmp    b1c1 <fwp_write+0x551>
    af92:	4c 89 ef             	mov    %r13,%rdi
    af95:	e8 06 ee ff ff       	call   9da0 <fwp_i128>
    af9a:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    af9f:	4c 89 f7             	mov    %r14,%rdi
    afa2:	48 89 c6             	mov    %rax,%rsi
    afa5:	e8 d6 03 00 00       	call   b380 <fwp_fmt_i128>
    afaa:	e9 12 02 00 00       	jmp    b1c1 <fwp_write+0x551>
    afaf:	48 89 df             	mov    %rbx,%rdi
    afb2:	be 5b 00 00 00       	mov    $0x5b,%esi
    afb7:	e8 24 c7 ff ff       	call   76e0 <buf_putc>
    afbc:	4d 85 ed             	test   %r13,%r13
    afbf:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    afc4:	0f 84 d5 01 00 00    	je     b19f <fwp_write+0x52f>
    afca:	49 8b 57 38          	mov    0x38(%r15),%rdx
    afce:	49 8b 75 08          	mov    0x8(%r13),%rsi
    afd2:	48 89 df             	mov    %rbx,%rdi
    afd5:	31 c9                	xor    %ecx,%ecx
    afd7:	e8 94 fc ff ff       	call   ac70 <fwp_write>
    afdc:	4d 8b 65 10          	mov    0x10(%r13),%r12
    afe0:	4d 85 e4             	test   %r12,%r12
    afe3:	0f 84 b6 01 00 00    	je     b19f <fwp_write+0x52f>
    afe9:	4c 8d 35 8d 32 00 00 	lea    0x328d(%rip),%r14        # e27d <exec_in_fp0+0xc1d>
    aff0:	48 89 df             	mov    %rbx,%rdi
    aff3:	4c 89 f6             	mov    %r14,%rsi
    aff6:	e8 05 c7 ff ff       	call   7700 <buf_puts>
    affb:	49 8b 74 24 08       	mov    0x8(%r12),%rsi
    b000:	49 8b 57 38          	mov    0x38(%r15),%rdx
    b004:	48 89 df             	mov    %rbx,%rdi
    b007:	31 c9                	xor    %ecx,%ecx
    b009:	e8 62 fc ff ff       	call   ac70 <fwp_write>
    b00e:	4d 8b 64 24 10       	mov    0x10(%r12),%r12
    b013:	4d 85 e4             	test   %r12,%r12
    b016:	75 d8                	jne    aff0 <fwp_write+0x380>
    b018:	e9 82 01 00 00       	jmp    b19f <fwp_write+0x52f>
    b01d:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    b022:	8b 50 48             	mov    0x48(%rax),%edx
    b025:	48 89 df             	mov    %rbx,%rdi
    b028:	4c 89 ee             	mov    %r13,%rsi
    b02b:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b032:	5b                   	pop    %rbx
    b033:	41 5c                	pop    %r12
    b035:	41 5d                	pop    %r13
    b037:	41 5e                	pop    %r14
    b039:	41 5f                	pop    %r15
    b03b:	5d                   	pop    %rbp
    b03c:	e9 2f 08 00 00       	jmp    b870 <fwp_trits>
    b041:	49 83 fd ff          	cmp    $0xffffffffffffffff,%r13
    b045:	48 8d 05 3d 32 00 00 	lea    0x323d(%rip),%rax        # e289 <exec_in_fp0+0xc29>
    b04c:	48 8d 0d 37 33 00 00 	lea    0x3337(%rip),%rcx        # e38a <exec_in_fp0+0xd2a>
    b053:	48 0f 44 c8          	cmove  %rax,%rcx
    b057:	49 83 fd 01          	cmp    $0x1,%r13
    b05b:	48 8d 35 24 32 00 00 	lea    0x3224(%rip),%rsi        # e286 <exec_in_fp0+0xc26>
    b062:	48 0f 45 f1          	cmovne %rcx,%rsi
    b066:	e9 7a 01 00 00       	jmp    b1e5 <fwp_write+0x575>
    b06b:	48 8d 35 eb 32 00 00 	lea    0x32eb(%rip),%rsi        # e35d <exec_in_fp0+0xcfd>
    b072:	48 89 df             	mov    %rbx,%rdi
    b075:	e8 86 c6 ff ff       	call   7700 <buf_puts>
    b07a:	49 83 7d 00 00       	cmpq   $0x0,0x0(%r13)
    b07f:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    b084:	0f 84 15 01 00 00    	je     b19f <fwp_write+0x52f>
    b08a:	49 8b 57 38          	mov    0x38(%r15),%rdx
    b08e:	49 8b 75 08          	mov    0x8(%r13),%rsi
    b092:	48 89 df             	mov    %rbx,%rdi
    b095:	31 c9                	xor    %ecx,%ecx
    b097:	e8 d4 fb ff ff       	call   ac70 <fwp_write>
    b09c:	49 83 7d 00 02       	cmpq   $0x2,0x0(%r13)
    b0a1:	0f 82 f8 00 00 00    	jb     b19f <fwp_write+0x52f>
    b0a7:	41 be 01 00 00 00    	mov    $0x1,%r14d
    b0ad:	4c 8d 25 c9 31 00 00 	lea    0x31c9(%rip),%r12        # e27d <exec_in_fp0+0xc1d>
    b0b4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b0bb:	00 00 00 00 00 
    b0c0:	48 89 df             	mov    %rbx,%rdi
    b0c3:	4c 89 e6             	mov    %r12,%rsi
    b0c6:	e8 35 c6 ff ff       	call   7700 <buf_puts>
    b0cb:	4b 8b 74 f5 08       	mov    0x8(%r13,%r14,8),%rsi
    b0d0:	49 8b 57 38          	mov    0x38(%r15),%rdx
    b0d4:	48 89 df             	mov    %rbx,%rdi
    b0d7:	31 c9                	xor    %ecx,%ecx
    b0d9:	e8 92 fb ff ff       	call   ac70 <fwp_write>
    b0de:	49 ff c6             	inc    %r14
    b0e1:	4d 3b 75 00          	cmp    0x0(%r13),%r14
    b0e5:	72 d9                	jb     b0c0 <fwp_write+0x450>
    b0e7:	e9 b3 00 00 00       	jmp    b19f <fwp_write+0x52f>
    b0ec:	48 8d 35 60 32 00 00 	lea    0x3260(%rip),%rsi        # e353 <exec_in_fp0+0xcf3>
    b0f3:	48 89 df             	mov    %rbx,%rdi
    b0f6:	e8 05 c6 ff ff       	call   7700 <buf_puts>
    b0fb:	49 83 7d 00 00       	cmpq   $0x0,0x0(%r13)
    b100:	0f 84 99 00 00 00    	je     b19f <fwp_write+0x52f>
    b106:	4c 89 ed             	mov    %r13,%rbp
    b109:	41 0f b6 4d 08       	movzbl 0x8(%r13),%ecx
    b10e:	48 8d 15 45 32 00 00 	lea    0x3245(%rip),%rdx        # e35a <exec_in_fp0+0xcfa>
    b115:	4c 8d 7c 24 20       	lea    0x20(%rsp),%r15
    b11a:	be 00 02 00 00       	mov    $0x200,%esi
    b11f:	4c 89 ff             	mov    %r15,%rdi
    b122:	31 c0                	xor    %eax,%eax
    b124:	e8 97 70 ff ff       	call   21c0 <snprintf@plt>
    b129:	48 89 df             	mov    %rbx,%rdi
    b12c:	4c 89 fe             	mov    %r15,%rsi
    b12f:	e8 cc c5 ff ff       	call   7700 <buf_puts>
    b134:	49 83 7d 00 02       	cmpq   $0x2,0x0(%r13)
    b139:	72 64                	jb     b19f <fwp_write+0x52f>
    b13b:	41 be 09 00 00 00    	mov    $0x9,%r14d
    b141:	4c 8d 3d 35 31 00 00 	lea    0x3135(%rip),%r15        # e27d <exec_in_fp0+0xc1d>
    b148:	4c 8d 25 0b 32 00 00 	lea    0x320b(%rip),%r12        # e35a <exec_in_fp0+0xcfa>
    b14f:	4c 8d 6c 24 20       	lea    0x20(%rsp),%r13
    b154:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b15b:	00 00 00 00 00 
    b160:	48 89 df             	mov    %rbx,%rdi
    b163:	4c 89 fe             	mov    %r15,%rsi
    b166:	e8 95 c5 ff ff       	call   7700 <buf_puts>
    b16b:	42 0f b6 4c 35 00    	movzbl 0x0(%rbp,%r14,1),%ecx
    b171:	be 00 02 00 00       	mov    $0x200,%esi
    b176:	4c 89 ef             	mov    %r13,%rdi
    b179:	4c 89 e2             	mov    %r12,%rdx
    b17c:	31 c0                	xor    %eax,%eax
    b17e:	e8 3d 70 ff ff       	call   21c0 <snprintf@plt>
    b183:	48 89 df             	mov    %rbx,%rdi
    b186:	4c 89 ee             	mov    %r13,%rsi
    b189:	e8 72 c5 ff ff       	call   7700 <buf_puts>
    b18e:	49 8d 46 01          	lea    0x1(%r14),%rax
    b192:	49 83 c6 f9          	add    $0xfffffffffffffff9,%r14
    b196:	4c 3b 75 00          	cmp    0x0(%rbp),%r14
    b19a:	49 89 c6             	mov    %rax,%r14
    b19d:	72 c1                	jb     b160 <fwp_write+0x4f0>
    b19f:	48 89 df             	mov    %rbx,%rdi
    b1a2:	be 5d 00 00 00       	mov    $0x5d,%esi
    b1a7:	e9 7b 01 00 00       	jmp    b327 <fwp_write+0x6b7>
    b1ac:	4c 89 ef             	mov    %r13,%rdi
    b1af:	e8 1c ec ff ff       	call   9dd0 <fwp_f32>
    b1b4:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    b1b9:	4c 89 f7             	mov    %r14,%rdi
    b1bc:	e8 ef 03 00 00       	call   b5b0 <fwp_fmt_f32>
    b1c1:	48 89 df             	mov    %rbx,%rdi
    b1c4:	4c 89 f6             	mov    %r14,%rsi
    b1c7:	e8 34 c5 ff ff       	call   7700 <buf_puts>
    b1cc:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b1d3:	5b                   	pop    %rbx
    b1d4:	41 5c                	pop    %r12
    b1d6:	41 5d                	pop    %r13
    b1d8:	41 5e                	pop    %r14
    b1da:	41 5f                	pop    %r15
    b1dc:	5d                   	pop    %rbp
    b1dd:	c3                   	ret
    b1de:	48 8d 35 53 31 00 00 	lea    0x3153(%rip),%rsi        # e338 <exec_in_fp0+0xcd8>
    b1e5:	48 89 df             	mov    %rbx,%rdi
    b1e8:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b1ef:	5b                   	pop    %rbx
    b1f0:	41 5c                	pop    %r12
    b1f2:	41 5d                	pop    %r13
    b1f4:	41 5e                	pop    %r14
    b1f6:	41 5f                	pop    %r15
    b1f8:	5d                   	pop    %rbp
    b1f9:	e9 02 c5 ff ff       	jmp    7700 <buf_puts>
    b1fe:	48 8d 35 47 31 00 00 	lea    0x3147(%rip),%rsi        # e34c <exec_in_fp0+0xcec>
    b205:	48 89 df             	mov    %rbx,%rdi
    b208:	e8 f3 c4 ff ff       	call   7700 <buf_puts>
    b20d:	49 83 c5 10          	add    $0x10,%r13
    b211:	48 89 df             	mov    %rbx,%rdi
    b214:	4c 89 ee             	mov    %r13,%rsi
    b217:	e8 e4 c4 ff ff       	call   7700 <buf_puts>
    b21c:	48 89 df             	mov    %rbx,%rdi
    b21f:	be 3e 00 00 00       	mov    $0x3e,%esi
    b224:	e9 fe 00 00 00       	jmp    b327 <fwp_write+0x6b7>
    b229:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    b22e:	0f 84 35 01 00 00    	je     b369 <fwp_write+0x6f9>
    b234:	4d 8d 77 10          	lea    0x10(%r15),%r14
    b238:	4d 85 e4             	test   %r12,%r12
    b23b:	0f 94 c0             	sete   %al
    b23e:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
    b243:	40 0f 95 c5          	setne  %bpl
    b247:	40 20 c5             	and    %al,%bpl
    b24a:	40 84 ed             	test   %bpl,%bpl
    b24d:	b8 28 00 00 00       	mov    $0x28,%eax
    b252:	be 7b 00 00 00       	mov    $0x7b,%esi
    b257:	0f 45 f0             	cmovne %eax,%esi
    b25a:	48 89 df             	mov    %rbx,%rdi
    b25d:	e8 7e c4 ff ff       	call   76e0 <buf_putc>
    b262:	41 83 3e 00          	cmpl   $0x0,(%r14)
    b266:	0f 8e a8 00 00 00    	jle    b314 <fwp_write+0x6a4>
    b26c:	40 84 ed             	test   %bpl,%bpl
    b26f:	75 1e                	jne    b28f <fwp_write+0x61f>
    b271:	49 8b 47 18          	mov    0x18(%r15),%rax
    b275:	48 8b 30             	mov    (%rax),%rsi
    b278:	48 89 df             	mov    %rbx,%rdi
    b27b:	e8 80 c4 ff ff       	call   7700 <buf_puts>
    b280:	48 8d 35 ea 30 00 00 	lea    0x30ea(%rip),%rsi        # e371 <exec_in_fp0+0xd11>
    b287:	48 89 df             	mov    %rbx,%rdi
    b28a:	e8 71 c4 ff ff       	call   7700 <buf_puts>
    b28f:	49 8b 75 08          	mov    0x8(%r13),%rsi
    b293:	49 8b 47 20          	mov    0x20(%r15),%rax
    b297:	48 8b 10             	mov    (%rax),%rdx
    b29a:	48 89 df             	mov    %rbx,%rdi
    b29d:	31 c9                	xor    %ecx,%ecx
    b29f:	e8 cc f9 ff ff       	call   ac70 <fwp_write>
    b2a4:	41 83 7f 10 02       	cmpl   $0x2,0x10(%r15)
    b2a9:	7c 69                	jl     b314 <fwp_write+0x6a4>
    b2ab:	41 be 01 00 00 00    	mov    $0x1,%r14d
    b2b1:	4c 8d 25 c5 2f 00 00 	lea    0x2fc5(%rip),%r12        # e27d <exec_in_fp0+0xc1d>
    b2b8:	eb 29                	jmp    b2e3 <fwp_write+0x673>
    b2ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    b2c0:	4b 8b 74 f5 08       	mov    0x8(%r13,%r14,8),%rsi
    b2c5:	49 8b 47 20          	mov    0x20(%r15),%rax
    b2c9:	4a 8b 14 f0          	mov    (%rax,%r14,8),%rdx
    b2cd:	48 89 df             	mov    %rbx,%rdi
    b2d0:	31 c9                	xor    %ecx,%ecx
    b2d2:	e8 99 f9 ff ff       	call   ac70 <fwp_write>
    b2d7:	49 ff c6             	inc    %r14
    b2da:	49 63 47 10          	movslq 0x10(%r15),%rax
    b2de:	49 39 c6             	cmp    %rax,%r14
    b2e1:	7d 31                	jge    b314 <fwp_write+0x6a4>
    b2e3:	48 89 df             	mov    %rbx,%rdi
    b2e6:	4c 89 e6             	mov    %r12,%rsi
    b2e9:	e8 12 c4 ff ff       	call   7700 <buf_puts>
    b2ee:	40 84 ed             	test   %bpl,%bpl
    b2f1:	75 cd                	jne    b2c0 <fwp_write+0x650>
    b2f3:	49 8b 47 18          	mov    0x18(%r15),%rax
    b2f7:	4a 8b 34 f0          	mov    (%rax,%r14,8),%rsi
    b2fb:	48 89 df             	mov    %rbx,%rdi
    b2fe:	e8 fd c3 ff ff       	call   7700 <buf_puts>
    b303:	48 89 df             	mov    %rbx,%rdi
    b306:	48 8d 35 64 30 00 00 	lea    0x3064(%rip),%rsi        # e371 <exec_in_fp0+0xd11>
    b30d:	e8 ee c3 ff ff       	call   7700 <buf_puts>
    b312:	eb ac                	jmp    b2c0 <fwp_write+0x650>
    b314:	40 84 ed             	test   %bpl,%bpl
    b317:	b8 29 00 00 00       	mov    $0x29,%eax
    b31c:	be 7d 00 00 00       	mov    $0x7d,%esi
    b321:	0f 45 f0             	cmovne %eax,%esi
    b324:	48 89 df             	mov    %rbx,%rdi
    b327:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b32e:	5b                   	pop    %rbx
    b32f:	41 5c                	pop    %r12
    b331:	41 5d                	pop    %r13
    b333:	41 5e                	pop    %r14
    b335:	41 5f                	pop    %r15
    b337:	5d                   	pop    %rbp
    b338:	e9 a3 c3 ff ff       	jmp    76e0 <buf_putc>
    b33d:	5b                   	pop    %rbx
    b33e:	41 5c                	pop    %r12
    b340:	41 5d                	pop    %r13
    b342:	41 5e                	pop    %r14
    b344:	41 5f                	pop    %r15
    b346:	5d                   	pop    %rbp
    b347:	e9 14 06 00 00       	jmp    b960 <fwp_escape>
    b34c:	49 8b 75 08          	mov    0x8(%r13),%rsi
    b350:	48 89 f2             	mov    %rsi,%rdx
    b353:	48 c1 fa 3f          	sar    $0x3f,%rdx
    b357:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    b35c:	4c 89 f7             	mov    %r14,%rdi
    b35f:	e8 0c 07 00 00       	call   ba70 <fwp_fmt_duration>
    b364:	e9 58 fe ff ff       	jmp    b1c1 <fwp_write+0x551>
    b369:	48 8d 35 fe 2f 00 00 	lea    0x2ffe(%rip),%rsi        # e36e <exec_in_fp0+0xd0e>
    b370:	e9 70 fe ff ff       	jmp    b1e5 <fwp_write+0x575>
    b375:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b37c:	00 00 00 00 

000000000000b380 <fwp_fmt_i128>:
    b380:	48 85 d2             	test   %rdx,%rdx
    b383:	79 1b                	jns    b3a0 <fwp_fmt_u128>
    b385:	c6 07 2d             	movb   $0x2d,(%rdi)
    b388:	48 ff c7             	inc    %rdi
    b38b:	31 c0                	xor    %eax,%eax
    b38d:	48 f7 de             	neg    %rsi
    b390:	48 19 d0             	sbb    %rdx,%rax
    b393:	48 89 c2             	mov    %rax,%rdx
    b396:	eb 08                	jmp    b3a0 <fwp_fmt_u128>
    b398:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    b39f:	00 

000000000000b3a0 <fwp_fmt_u128>:
    b3a0:	41 56                	push   %r14
    b3a2:	53                   	push   %rbx
    b3a3:	48 89 f0             	mov    %rsi,%rax
    b3a6:	48 09 d0             	or     %rdx,%rax
    b3a9:	0f 84 9d 00 00 00    	je     b44c <fwp_fmt_u128+0xac>
    b3af:	48 89 d1             	mov    %rdx,%rcx
    b3b2:	45 31 d2             	xor    %r10d,%r10d
    b3b5:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    b3bc:	cc cc cc 
    b3bf:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
    b3c6:	cc cc cc 
    b3c9:	49 89 d6             	mov    %rdx,%r14
    b3cc:	0f 1f 40 00          	nopl   0x0(%rax)
    b3d0:	49 89 c8             	mov    %rcx,%r8
    b3d3:	49 0f a4 f0 3f       	shld   $0x3f,%rsi,%r8
    b3d8:	49 d1 ee             	shr    $1,%r14
    b3db:	4d 89 c1             	mov    %r8,%r9
    b3de:	4d 01 f1             	add    %r14,%r9
    b3e1:	49 83 d1 00          	adc    $0x0,%r9
    b3e5:	4c 89 c8             	mov    %r9,%rax
    b3e8:	49 f7 e3             	mul    %r11
    b3eb:	48 c1 ea 02          	shr    $0x2,%rdx
    b3ef:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    b3f3:	49 29 c1             	sub    %rax,%r9
    b3f6:	4d 29 c8             	sub    %r9,%r8
    b3f9:	49 83 de 00          	sbb    $0x0,%r14
    b3fd:	4d 89 c1             	mov    %r8,%r9
    b400:	4c 0f af cb          	imul   %rbx,%r9
    b404:	4c 89 c0             	mov    %r8,%rax
    b407:	49 f7 e3             	mul    %r11
    b40a:	4c 01 ca             	add    %r9,%rdx
    b40d:	4d 0f af f3          	imul   %r11,%r14
    b411:	49 01 d6             	add    %rdx,%r14
    b414:	48 89 c2             	mov    %rax,%rdx
    b417:	48 01 c2             	add    %rax,%rdx
    b41a:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
    b41e:	41 89 f0             	mov    %esi,%r8d
    b421:	41 29 d0             	sub    %edx,%r8d
    b424:	41 80 c8 30          	or     $0x30,%r8b
    b428:	46 88 44 14 b8       	mov    %r8b,-0x48(%rsp,%r10,1)
    b42d:	49 ff c2             	inc    %r10
    b430:	48 83 fe 0a          	cmp    $0xa,%rsi
    b434:	48 83 d9 00          	sbb    $0x0,%rcx
    b438:	48 89 c6             	mov    %rax,%rsi
    b43b:	4c 89 f1             	mov    %r14,%rcx
    b43e:	73 90                	jae    b3d0 <fwp_fmt_u128+0x30>
    b440:	45 85 d2             	test   %r10d,%r10d
    b443:	7f 12                	jg     b457 <fwp_fmt_u128+0xb7>
    b445:	31 c0                	xor    %eax,%eax
    b447:	e9 56 01 00 00       	jmp    b5a2 <fwp_fmt_u128+0x202>
    b44c:	c6 44 24 b8 30       	movb   $0x30,-0x48(%rsp)
    b451:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    b457:	44 89 d0             	mov    %r10d,%eax
    b45a:	41 83 fa 08          	cmp    $0x8,%r10d
    b45e:	73 0a                	jae    b46a <fwp_fmt_u128+0xca>
    b460:	31 c9                	xor    %ecx,%ecx
    b462:	48 89 c2             	mov    %rax,%rdx
    b465:	e9 10 01 00 00       	jmp    b57a <fwp_fmt_u128+0x1da>
    b46a:	83 f8 20             	cmp    $0x20,%eax
    b46d:	73 07                	jae    b476 <fwp_fmt_u128+0xd6>
    b46f:	31 c9                	xor    %ecx,%ecx
    b471:	e9 a4 00 00 00       	jmp    b51a <fwp_fmt_u128+0x17a>
    b476:	89 c1                	mov    %eax,%ecx
    b478:	81 e1 e0 ff ff 7f    	and    $0x7fffffe0,%ecx
    b47e:	48 8d 54 24 b8       	lea    -0x48(%rsp),%rdx
    b483:	48 01 c2             	add    %rax,%rdx
    b486:	48 83 c2 f0          	add    $0xfffffffffffffff0,%rdx
    b48a:	31 f6                	xor    %esi,%esi
    b48c:	66 0f ef c0          	pxor   %xmm0,%xmm0
    b490:	f3 0f 6f 4a f0       	movdqu -0x10(%rdx),%xmm1
    b495:	f3 0f 6f 12          	movdqu (%rdx),%xmm2
    b499:	66 0f 6f da          	movdqa %xmm2,%xmm3
    b49d:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    b4a1:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    b4a6:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    b4ab:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    b4b0:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    b4b4:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    b4b9:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    b4be:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    b4c3:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    b4c7:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    b4cb:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    b4cf:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    b4d4:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    b4d9:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    b4de:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    b4e2:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    b4e7:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    b4ec:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    b4f1:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    b4f5:	f3 0f 7f 14 37       	movdqu %xmm2,(%rdi,%rsi,1)
    b4fa:	f3 0f 7f 4c 37 10    	movdqu %xmm1,0x10(%rdi,%rsi,1)
    b500:	48 83 c6 20          	add    $0x20,%rsi
    b504:	48 83 c2 e0          	add    $0xffffffffffffffe0,%rdx
    b508:	48 39 f1             	cmp    %rsi,%rcx
    b50b:	75 83                	jne    b490 <fwp_fmt_u128+0xf0>
    b50d:	48 39 c1             	cmp    %rax,%rcx
    b510:	0f 84 8c 00 00 00    	je     b5a2 <fwp_fmt_u128+0x202>
    b516:	a8 18                	test   $0x18,%al
    b518:	74 5b                	je     b575 <fwp_fmt_u128+0x1d5>
    b51a:	48 89 ce             	mov    %rcx,%rsi
    b51d:	89 c1                	mov    %eax,%ecx
    b51f:	81 e1 f8 ff ff 7f    	and    $0x7ffffff8,%ecx
    b525:	89 c2                	mov    %eax,%edx
    b527:	83 e2 07             	and    $0x7,%edx
    b52a:	49 89 c0             	mov    %rax,%r8
    b52d:	49 29 f0             	sub    %rsi,%r8
    b530:	49 01 e0             	add    %rsp,%r8
    b533:	49 83 c0 b0          	add    $0xffffffffffffffb0,%r8
    b537:	66 0f ef c0          	pxor   %xmm0,%xmm0
    b53b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    b540:	f3 41 0f 7e 08       	movq   (%r8),%xmm1
    b545:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    b549:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    b54e:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    b553:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    b558:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    b55c:	66 0f d6 0c 37       	movq   %xmm1,(%rdi,%rsi,1)
    b561:	48 83 c6 08          	add    $0x8,%rsi
    b565:	49 83 c0 f8          	add    $0xfffffffffffffff8,%r8
    b569:	48 39 f1             	cmp    %rsi,%rcx
    b56c:	75 d2                	jne    b540 <fwp_fmt_u128+0x1a0>
    b56e:	48 39 c1             	cmp    %rax,%rcx
    b571:	75 07                	jne    b57a <fwp_fmt_u128+0x1da>
    b573:	eb 2d                	jmp    b5a2 <fwp_fmt_u128+0x202>
    b575:	89 c2                	mov    %eax,%edx
    b577:	83 e2 1f             	and    $0x1f,%edx
    b57a:	48 8d 74 24 b8       	lea    -0x48(%rsp),%rsi
    b57f:	48 01 f2             	add    %rsi,%rdx
    b582:	48 ff ca             	dec    %rdx
    b585:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b58c:	00 00 00 00 
    b590:	0f b6 32             	movzbl (%rdx),%esi
    b593:	40 88 34 0f          	mov    %sil,(%rdi,%rcx,1)
    b597:	48 ff c1             	inc    %rcx
    b59a:	48 ff ca             	dec    %rdx
    b59d:	48 39 c8             	cmp    %rcx,%rax
    b5a0:	75 ee                	jne    b590 <fwp_fmt_u128+0x1f0>
    b5a2:	c6 04 07 00          	movb   $0x0,(%rdi,%rax,1)
    b5a6:	5b                   	pop    %rbx
    b5a7:	41 5e                	pop    %r14
    b5a9:	c3                   	ret
    b5aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000b5b0 <fwp_fmt_f32>:
    b5b0:	53                   	push   %rbx
    b5b1:	48 83 ec 20          	sub    $0x20,%rsp
    b5b5:	48 89 fb             	mov    %rdi,%rbx
    b5b8:	0f 2e c0             	ucomiss %xmm0,%xmm0
    b5bb:	0f 8a d8 01 00 00    	jp     b799 <fwp_fmt_f32+0x1e9>
    b5c1:	0f 28 c8             	movaps %xmm0,%xmm1
    b5c4:	0f 28 05 75 1b 00 00 	movaps 0x1b75(%rip),%xmm0        # d140 <_IO_stdin_used+0x140>
    b5cb:	0f 54 c1             	andps  %xmm1,%xmm0
    b5ce:	0f 2e 05 2f 1a 00 00 	ucomiss 0x1a2f(%rip),%xmm0        # d004 <_IO_stdin_used+0x4>
    b5d5:	72 25                	jb     b5fc <fwp_fmt_f32+0x4c>
    b5d7:	0f 57 c0             	xorps  %xmm0,%xmm0
    b5da:	0f 2e c8             	ucomiss %xmm0,%xmm1
    b5dd:	48 8d 05 d1 2c 00 00 	lea    0x2cd1(%rip),%rax        # e2b5 <exec_in_fp0+0xc55>
    b5e4:	48 8d 35 c9 2c 00 00 	lea    0x2cc9(%rip),%rsi        # e2b4 <exec_in_fp0+0xc54>
    b5eb:	48 0f 47 f0          	cmova  %rax,%rsi
    b5ef:	48 89 df             	mov    %rbx,%rdi
    b5f2:	48 83 c4 20          	add    $0x20,%rsp
    b5f6:	5b                   	pop    %rbx
    b5f7:	e9 b4 6a ff ff       	jmp    20b0 <strcpy@plt>
    b5fc:	0f 57 c0             	xorps  %xmm0,%xmm0
    b5ff:	f3 0f 5a c1          	cvtss2sd %xmm1,%xmm0
    b603:	48 89 df             	mov    %rbx,%rdi
    b606:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    b60c:	be 01 00 00 00       	mov    $0x1,%esi
    b611:	0f 29 4c 24 10       	movaps %xmm1,0x10(%rsp)
    b616:	e8 95 07 00 00       	call   bdb0 <fwp_format_g>
    b61b:	48 89 df             	mov    %rbx,%rdi
    b61e:	31 f6                	xor    %esi,%esi
    b620:	e8 cb 6b ff ff       	call   21f0 <strtof@plt>
    b625:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b62a:	75 06                	jne    b632 <fwp_fmt_f32+0x82>
    b62c:	0f 8b 5a 01 00 00    	jnp    b78c <fwp_fmt_f32+0x1dc>
    b632:	48 89 df             	mov    %rbx,%rdi
    b635:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b63b:	be 02 00 00 00       	mov    $0x2,%esi
    b640:	e8 6b 07 00 00       	call   bdb0 <fwp_format_g>
    b645:	48 89 df             	mov    %rbx,%rdi
    b648:	31 f6                	xor    %esi,%esi
    b64a:	e8 a1 6b ff ff       	call   21f0 <strtof@plt>
    b64f:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b654:	75 06                	jne    b65c <fwp_fmt_f32+0xac>
    b656:	0f 8b 30 01 00 00    	jnp    b78c <fwp_fmt_f32+0x1dc>
    b65c:	48 89 df             	mov    %rbx,%rdi
    b65f:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b665:	be 03 00 00 00       	mov    $0x3,%esi
    b66a:	e8 41 07 00 00       	call   bdb0 <fwp_format_g>
    b66f:	48 89 df             	mov    %rbx,%rdi
    b672:	31 f6                	xor    %esi,%esi
    b674:	e8 77 6b ff ff       	call   21f0 <strtof@plt>
    b679:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b67e:	75 06                	jne    b686 <fwp_fmt_f32+0xd6>
    b680:	0f 8b 06 01 00 00    	jnp    b78c <fwp_fmt_f32+0x1dc>
    b686:	48 89 df             	mov    %rbx,%rdi
    b689:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b68f:	be 04 00 00 00       	mov    $0x4,%esi
    b694:	e8 17 07 00 00       	call   bdb0 <fwp_format_g>
    b699:	48 89 df             	mov    %rbx,%rdi
    b69c:	31 f6                	xor    %esi,%esi
    b69e:	e8 4d 6b ff ff       	call   21f0 <strtof@plt>
    b6a3:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b6a8:	75 06                	jne    b6b0 <fwp_fmt_f32+0x100>
    b6aa:	0f 8b dc 00 00 00    	jnp    b78c <fwp_fmt_f32+0x1dc>
    b6b0:	48 89 df             	mov    %rbx,%rdi
    b6b3:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b6b9:	be 05 00 00 00       	mov    $0x5,%esi
    b6be:	e8 ed 06 00 00       	call   bdb0 <fwp_format_g>
    b6c3:	48 89 df             	mov    %rbx,%rdi
    b6c6:	31 f6                	xor    %esi,%esi
    b6c8:	e8 23 6b ff ff       	call   21f0 <strtof@plt>
    b6cd:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b6d2:	75 06                	jne    b6da <fwp_fmt_f32+0x12a>
    b6d4:	0f 8b b2 00 00 00    	jnp    b78c <fwp_fmt_f32+0x1dc>
    b6da:	48 89 df             	mov    %rbx,%rdi
    b6dd:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b6e3:	be 06 00 00 00       	mov    $0x6,%esi
    b6e8:	e8 c3 06 00 00       	call   bdb0 <fwp_format_g>
    b6ed:	48 89 df             	mov    %rbx,%rdi
    b6f0:	31 f6                	xor    %esi,%esi
    b6f2:	e8 f9 6a ff ff       	call   21f0 <strtof@plt>
    b6f7:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b6fc:	75 06                	jne    b704 <fwp_fmt_f32+0x154>
    b6fe:	0f 8b 88 00 00 00    	jnp    b78c <fwp_fmt_f32+0x1dc>
    b704:	48 89 df             	mov    %rbx,%rdi
    b707:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b70d:	be 07 00 00 00       	mov    $0x7,%esi
    b712:	e8 99 06 00 00       	call   bdb0 <fwp_format_g>
    b717:	48 89 df             	mov    %rbx,%rdi
    b71a:	31 f6                	xor    %esi,%esi
    b71c:	e8 cf 6a ff ff       	call   21f0 <strtof@plt>
    b721:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b726:	75 02                	jne    b72a <fwp_fmt_f32+0x17a>
    b728:	7b 62                	jnp    b78c <fwp_fmt_f32+0x1dc>
    b72a:	48 89 df             	mov    %rbx,%rdi
    b72d:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b733:	be 08 00 00 00       	mov    $0x8,%esi
    b738:	e8 73 06 00 00       	call   bdb0 <fwp_format_g>
    b73d:	48 89 df             	mov    %rbx,%rdi
    b740:	31 f6                	xor    %esi,%esi
    b742:	e8 a9 6a ff ff       	call   21f0 <strtof@plt>
    b747:	0f 28 4c 24 10       	movaps 0x10(%rsp),%xmm1
    b74c:	0f 2e c1             	ucomiss %xmm1,%xmm0
    b74f:	75 02                	jne    b753 <fwp_fmt_f32+0x1a3>
    b751:	7b 39                	jnp    b78c <fwp_fmt_f32+0x1dc>
    b753:	48 89 df             	mov    %rbx,%rdi
    b756:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b75c:	be 09 00 00 00       	mov    $0x9,%esi
    b761:	e8 4a 06 00 00       	call   bdb0 <fwp_format_g>
    b766:	48 89 df             	mov    %rbx,%rdi
    b769:	31 f6                	xor    %esi,%esi
    b76b:	e8 80 6a ff ff       	call   21f0 <strtof@plt>
    b770:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b775:	75 02                	jne    b779 <fwp_fmt_f32+0x1c9>
    b777:	7b 13                	jnp    b78c <fwp_fmt_f32+0x1dc>
    b779:	48 89 df             	mov    %rbx,%rdi
    b77c:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b782:	be 09 00 00 00       	mov    $0x9,%esi
    b787:	e8 24 06 00 00       	call   bdb0 <fwp_format_g>
    b78c:	48 89 df             	mov    %rbx,%rdi
    b78f:	48 83 c4 20          	add    $0x20,%rsp
    b793:	5b                   	pop    %rbx
    b794:	e9 97 07 00 00       	jmp    bf30 <fwp_finish_float>
    b799:	c7 03 4e 61 4e 00    	movl   $0x4e614e,(%rbx)
    b79f:	48 83 c4 20          	add    $0x20,%rsp
    b7a3:	5b                   	pop    %rbx
    b7a4:	c3                   	ret
    b7a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b7ac:	00 00 00 00 

000000000000b7b0 <fwp_fmt_f64>:
    b7b0:	55                   	push   %rbp
    b7b1:	53                   	push   %rbx
    b7b2:	48 83 ec 18          	sub    $0x18,%rsp
    b7b6:	48 89 fb             	mov    %rdi,%rbx
    b7b9:	66 0f 2e c0          	ucomisd %xmm0,%xmm0
    b7bd:	0f 8a 98 00 00 00    	jp     b85b <fwp_fmt_f64+0xab>
    b7c3:	66 0f 28 c8          	movapd %xmm0,%xmm1
    b7c7:	66 0f 28 05 81 19 00 	movapd 0x1981(%rip),%xmm0        # d150 <_IO_stdin_used+0x150>
    b7ce:	00 
    b7cf:	66 0f 54 c1          	andpd  %xmm1,%xmm0
    b7d3:	66 0f 2e 05 55 18 00 	ucomisd 0x1855(%rip),%xmm0        # d030 <_IO_stdin_used+0x30>
    b7da:	00 
    b7db:	72 28                	jb     b805 <fwp_fmt_f64+0x55>
    b7dd:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    b7e1:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
    b7e5:	48 8d 05 c9 2a 00 00 	lea    0x2ac9(%rip),%rax        # e2b5 <exec_in_fp0+0xc55>
    b7ec:	48 8d 35 c1 2a 00 00 	lea    0x2ac1(%rip),%rsi        # e2b4 <exec_in_fp0+0xc54>
    b7f3:	48 0f 47 f0          	cmova  %rax,%rsi
    b7f7:	48 89 df             	mov    %rbx,%rdi
    b7fa:	48 83 c4 18          	add    $0x18,%rsp
    b7fe:	5b                   	pop    %rbx
    b7ff:	5d                   	pop    %rbp
    b800:	e9 ab 68 ff ff       	jmp    20b0 <strcpy@plt>
    b805:	bd 01 00 00 00       	mov    $0x1,%ebp
    b80a:	66 0f 29 0c 24       	movapd %xmm1,(%rsp)
    b80f:	90                   	nop
    b810:	48 89 df             	mov    %rbx,%rdi
    b813:	66 0f 28 c1          	movapd %xmm1,%xmm0
    b817:	89 ee                	mov    %ebp,%esi
    b819:	e8 92 05 00 00       	call   bdb0 <fwp_format_g>
    b81e:	48 89 df             	mov    %rbx,%rdi
    b821:	31 f6                	xor    %esi,%esi
    b823:	e8 c8 68 ff ff       	call   20f0 <strtod@plt>
    b828:	66 0f 28 0c 24       	movapd (%rsp),%xmm1
    b82d:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
    b831:	75 02                	jne    b835 <fwp_fmt_f64+0x85>
    b833:	7b 18                	jnp    b84d <fwp_fmt_f64+0x9d>
    b835:	ff c5                	inc    %ebp
    b837:	83 fd 12             	cmp    $0x12,%ebp
    b83a:	75 d4                	jne    b810 <fwp_fmt_f64+0x60>
    b83c:	48 89 df             	mov    %rbx,%rdi
    b83f:	66 0f 28 c1          	movapd %xmm1,%xmm0
    b843:	be 11 00 00 00       	mov    $0x11,%esi
    b848:	e8 63 05 00 00       	call   bdb0 <fwp_format_g>
    b84d:	48 89 df             	mov    %rbx,%rdi
    b850:	48 83 c4 18          	add    $0x18,%rsp
    b854:	5b                   	pop    %rbx
    b855:	5d                   	pop    %rbp
    b856:	e9 d5 06 00 00       	jmp    bf30 <fwp_finish_float>
    b85b:	c7 03 4e 61 4e 00    	movl   $0x4e614e,(%rbx)
    b861:	48 83 c4 18          	add    $0x18,%rsp
    b865:	5b                   	pop    %rbx
    b866:	5d                   	pop    %rbp
    b867:	c3                   	ret
    b868:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    b86f:	00 

000000000000b870 <fwp_trits>:
    b870:	55                   	push   %rbp
    b871:	41 57                	push   %r15
    b873:	41 56                	push   %r14
    b875:	53                   	push   %rbx
    b876:	50                   	push   %rax
    b877:	89 d5                	mov    %edx,%ebp
    b879:	49 89 f6             	mov    %rsi,%r14
    b87c:	48 89 fb             	mov    %rdi,%rbx
    b87f:	4c 63 fa             	movslq %edx,%r15
    b882:	49 8d 7f 03          	lea    0x3(%r15),%rdi
    b886:	e8 55 ac ff ff       	call   64e0 <fwp_alloc_leaf>
    b88b:	48 89 c6             	mov    %rax,%rsi
    b88e:	66 c7 00 30 74       	movw   $0x7430,(%rax)
    b893:	45 85 ff             	test   %r15d,%r15d
    b896:	0f 8e 9f 00 00 00    	jle    b93b <fwp_trits+0xcb>
    b89c:	89 e9                	mov    %ebp,%ecx
    b89e:	48 8d 3c 31          	lea    (%rcx,%rsi,1),%rdi
    b8a2:	48 ff c7             	inc    %rdi
    b8a5:	48 f7 d9             	neg    %rcx
    b8a8:	45 31 c0             	xor    %r8d,%r8d
    b8ab:	49 b9 56 55 55 55 55 	movabs $0x5555555555555556,%r9
    b8b2:	55 55 55 
    b8b5:	eb 35                	jmp    b8ec <fwp_trits+0x7c>
    b8b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    b8be:	00 00 
    b8c0:	41 b3 30             	mov    $0x30,%r11b
    b8c3:	46 88 1c 07          	mov    %r11b,(%rdi,%r8,1)
    b8c7:	48 85 d2             	test   %rdx,%rdx
    b8ca:	0f 95 c2             	setne  %dl
    b8cd:	4d 85 f6             	test   %r14,%r14
    b8d0:	41 0f 98 c3          	sets   %r11b
    b8d4:	41 20 d3             	and    %dl,%r11b
    b8d7:	41 0f b6 d3          	movzbl %r11b,%edx
    b8db:	48 29 d0             	sub    %rdx,%rax
    b8de:	4c 01 d0             	add    %r10,%rax
    b8e1:	49 ff c8             	dec    %r8
    b8e4:	49 89 c6             	mov    %rax,%r14
    b8e7:	4c 39 c1             	cmp    %r8,%rcx
    b8ea:	74 4f                	je     b93b <fwp_trits+0xcb>
    b8ec:	4c 89 f0             	mov    %r14,%rax
    b8ef:	49 f7 e9             	imul   %r9
    b8f2:	48 89 d0             	mov    %rdx,%rax
    b8f5:	48 c1 e8 3f          	shr    $0x3f,%rax
    b8f9:	48 01 d0             	add    %rdx,%rax
    b8fc:	4c 8d 14 40          	lea    (%rax,%rax,2),%r10
    b900:	4c 89 f2             	mov    %r14,%rdx
    b903:	4c 29 d2             	sub    %r10,%rdx
    b906:	49 f7 da             	neg    %r10
    b909:	4d 01 f2             	add    %r14,%r10
    b90c:	49 83 c2 03          	add    $0x3,%r10
    b910:	48 83 fa fd          	cmp    $0xfffffffffffffffd,%rdx
    b914:	4c 0f 42 d2          	cmovb  %rdx,%r10
    b918:	4d 85 d2             	test   %r10,%r10
    b91b:	74 a3                	je     b8c0 <fwp_trits+0x50>
    b91d:	49 83 fa 01          	cmp    $0x1,%r10
    b921:	75 0d                	jne    b930 <fwp_trits+0xc0>
    b923:	41 b3 2b             	mov    $0x2b,%r11b
    b926:	45 31 d2             	xor    %r10d,%r10d
    b929:	eb 98                	jmp    b8c3 <fwp_trits+0x53>
    b92b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    b930:	41 b3 2d             	mov    $0x2d,%r11b
    b933:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    b939:	eb 88                	jmp    b8c3 <fwp_trits+0x53>
    b93b:	42 c6 44 3e 02 00    	movb   $0x0,0x2(%rsi,%r15,1)
    b941:	48 89 df             	mov    %rbx,%rdi
    b944:	48 83 c4 08          	add    $0x8,%rsp
    b948:	5b                   	pop    %rbx
    b949:	41 5e                	pop    %r14
    b94b:	41 5f                	pop    %r15
    b94d:	5d                   	pop    %rbp
    b94e:	e9 ad bd ff ff       	jmp    7700 <buf_puts>
    b953:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b95a:	84 00 00 00 00 00 

000000000000b960 <fwp_escape>:
    b960:	55                   	push   %rbp
    b961:	41 57                	push   %r15
    b963:	41 56                	push   %r14
    b965:	41 55                	push   %r13
    b967:	41 54                	push   %r12
    b969:	53                   	push   %rbx
    b96a:	48 83 ec 18          	sub    $0x18,%rsp
    b96e:	48 89 d3             	mov    %rdx,%rbx
    b971:	49 89 f7             	mov    %rsi,%r15
    b974:	49 89 fe             	mov    %rdi,%r14
    b977:	be 22 00 00 00       	mov    $0x22,%esi
    b97c:	e8 5f bd ff ff       	call   76e0 <buf_putc>
    b981:	48 85 db             	test   %rbx,%rbx
    b984:	0f 84 c7 00 00 00    	je     ba51 <fwp_escape+0xf1>
    b98a:	48 89 e5             	mov    %rsp,%rbp
    b98d:	4c 8d 2d 28 1a 00 00 	lea    0x1a28(%rip),%r13        # d3bc <_IO_stdin_used+0x3bc>
    b994:	45 31 e4             	xor    %r12d,%r12d
    b997:	eb 28                	jmp    b9c1 <fwp_escape+0x61>
    b999:	4c 89 f7             	mov    %r14,%rdi
    b99c:	48 8d 35 f5 29 00 00 	lea    0x29f5(%rip),%rsi        # e398 <exec_in_fp0+0xd38>
    b9a3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b9aa:	84 00 00 00 00 00 
    b9b0:	e8 4b bd ff ff       	call   7700 <buf_puts>
    b9b5:	49 ff c4             	inc    %r12
    b9b8:	4c 39 e3             	cmp    %r12,%rbx
    b9bb:	0f 84 90 00 00 00    	je     ba51 <fwp_escape+0xf1>
    b9c1:	43 0f b6 0c 27       	movzbl (%r15,%r12,1),%ecx
    b9c6:	8d 41 f7             	lea    -0x9(%rcx),%eax
    b9c9:	83 f8 19             	cmp    $0x19,%eax
    b9cc:	77 22                	ja     b9f0 <fwp_escape+0x90>
    b9ce:	49 63 44 85 00       	movslq 0x0(%r13,%rax,4),%rax
    b9d3:	4c 01 e8             	add    %r13,%rax
    b9d6:	ff e0                	jmp    *%rax
    b9d8:	4c 89 f7             	mov    %r14,%rdi
    b9db:	48 8d 35 b3 29 00 00 	lea    0x29b3(%rip),%rsi        # e395 <exec_in_fp0+0xd35>
    b9e2:	eb cc                	jmp    b9b0 <fwp_escape+0x50>
    b9e4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b9eb:	00 00 00 00 00 
    b9f0:	83 f9 5c             	cmp    $0x5c,%ecx
    b9f3:	75 0c                	jne    ba01 <fwp_escape+0xa1>
    b9f5:	4c 89 f7             	mov    %r14,%rdi
    b9f8:	48 8d 35 90 29 00 00 	lea    0x2990(%rip),%rsi        # e38f <exec_in_fp0+0xd2f>
    b9ff:	eb af                	jmp    b9b0 <fwp_escape+0x50>
    ba01:	80 f9 20             	cmp    $0x20,%cl
    ba04:	72 2a                	jb     ba30 <fwp_escape+0xd0>
    ba06:	80 f9 7f             	cmp    $0x7f,%cl
    ba09:	74 25                	je     ba30 <fwp_escape+0xd0>
    ba0b:	0f be f1             	movsbl %cl,%esi
    ba0e:	4c 89 f7             	mov    %r14,%rdi
    ba11:	e8 ca bc ff ff       	call   76e0 <buf_putc>
    ba16:	eb 9d                	jmp    b9b5 <fwp_escape+0x55>
    ba18:	4c 89 f7             	mov    %r14,%rdi
    ba1b:	48 8d 35 6a 29 00 00 	lea    0x296a(%rip),%rsi        # e38c <exec_in_fp0+0xd2c>
    ba22:	eb 8c                	jmp    b9b0 <fwp_escape+0x50>
    ba24:	4c 89 f7             	mov    %r14,%rdi
    ba27:	48 8d 35 64 29 00 00 	lea    0x2964(%rip),%rsi        # e392 <exec_in_fp0+0xd32>
    ba2e:	eb 80                	jmp    b9b0 <fwp_escape+0x50>
    ba30:	be 10 00 00 00       	mov    $0x10,%esi
    ba35:	48 89 ef             	mov    %rbp,%rdi
    ba38:	48 8d 15 5c 29 00 00 	lea    0x295c(%rip),%rdx        # e39b <exec_in_fp0+0xd3b>
    ba3f:	31 c0                	xor    %eax,%eax
    ba41:	e8 7a 67 ff ff       	call   21c0 <snprintf@plt>
    ba46:	4c 89 f7             	mov    %r14,%rdi
    ba49:	48 89 ee             	mov    %rbp,%rsi
    ba4c:	e9 5f ff ff ff       	jmp    b9b0 <fwp_escape+0x50>
    ba51:	4c 89 f7             	mov    %r14,%rdi
    ba54:	be 22 00 00 00       	mov    $0x22,%esi
    ba59:	48 83 c4 18          	add    $0x18,%rsp
    ba5d:	5b                   	pop    %rbx
    ba5e:	41 5c                	pop    %r12
    ba60:	41 5d                	pop    %r13
    ba62:	41 5e                	pop    %r14
    ba64:	41 5f                	pop    %r15
    ba66:	5d                   	pop    %rbp
    ba67:	e9 74 bc ff ff       	jmp    76e0 <buf_putc>
    ba6c:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000ba70 <fwp_fmt_duration>:
    ba70:	41 57                	push   %r15
    ba72:	41 56                	push   %r14
    ba74:	41 54                	push   %r12
    ba76:	53                   	push   %rbx
    ba77:	48 83 ec 48          	sub    $0x48,%rsp
    ba7b:	49 89 d0             	mov    %rdx,%r8
    ba7e:	48 89 fb             	mov    %rdi,%rbx
    ba81:	48 89 f0             	mov    %rsi,%rax
    ba84:	48 09 d0             	or     %rdx,%rax
    ba87:	0f 84 1b 02 00 00    	je     bca8 <fwp_fmt_duration+0x238>
    ba8d:	48 b9 1d 3f c2 25 d6 	movabs $0xd2fe1d625c23f1d,%rcx
    ba94:	e1 2f 0d 
    ba97:	48 bf 0d b1 f3 e4 99 	movabs $0x1c52799e4f3b10d,%rdi
    ba9e:	27 c5 01 
    baa1:	48 89 f0             	mov    %rsi,%rax
    baa4:	48 f7 e7             	mul    %rdi
    baa7:	48 0f af ce          	imul   %rsi,%rcx
    baab:	48 01 ca             	add    %rcx,%rdx
    baae:	49 0f af f8          	imul   %r8,%rdi
    bab2:	48 01 d7             	add    %rdx,%rdi
    bab5:	48 b9 00 a0 34 52 a3 	movabs $0x6baf6aa35234a000,%rcx
    babc:	6a af 6b 
    babf:	48 01 c1             	add    %rax,%rcx
    bac2:	48 b8 37 f9 ff e2 04 	movabs $0x4e2fff937,%rax
    bac9:	00 00 00 
    bacc:	48 11 f8             	adc    %rdi,%rax
    bacf:	48 89 c2             	mov    %rax,%rdx
    bad2:	48 0f ac ca 0d       	shrd   $0xd,%rcx,%rdx
    bad7:	48 0f a4 c8 33       	shld   $0x33,%rcx,%rax
    badc:	48 b9 4b 23 35 aa f6 	movabs $0x9376baf6aa35234b,%rcx
    bae3:	ba 76 93 
    bae6:	48 39 c8             	cmp    %rcx,%rax
    bae9:	48 81 da ff 2f 4e 00 	sbb    $0x4e2fff,%rdx
    baf0:	0f 82 d9 01 00 00    	jb     bccf <fwp_fmt_duration+0x25f>
    baf6:	48 b9 b3 b2 61 36 8c 	movabs $0xc5ce3b8c3661b2b3,%rcx
    bafd:	3b ce c5 
    bb00:	48 bf c3 5f 47 6a 04 	movabs $0x1a8d52046a475fc3,%rdi
    bb07:	52 8d 1a 
    bb0a:	48 89 f0             	mov    %rsi,%rax
    bb0d:	48 f7 e7             	mul    %rdi
    bb10:	48 0f af ce          	imul   %rsi,%rcx
    bb14:	48 01 ca             	add    %rcx,%rdx
    bb17:	49 0f af f8          	imul   %r8,%rdi
    bb1b:	48 01 d7             	add    %rdx,%rdi
    bb1e:	48 b9 00 a8 16 d1 91 	movabs $0x4f473f91d116a800,%rcx
    bb25:	3f 47 4f 
    bb28:	48 01 c1             	add    %rax,%rcx
    bb2b:	48 b8 3f 9a ff 4c 49 	movabs $0x494cff9a3f,%rax
    bb32:	00 00 00 
    bb35:	48 11 f8             	adc    %rdi,%rax
    bb38:	48 89 c2             	mov    %rax,%rdx
    bb3b:	48 0f ac ca 0b       	shrd   $0xb,%rcx,%rdx
    bb40:	48 0f a4 c8 35       	shld   $0x35,%rcx,%rax
    bb45:	48 b9 ab 45 74 e4 cf 	movabs $0x8fd3d1cfe47445ab,%rcx
    bb4c:	d1 d3 8f 
    bb4f:	48 39 c8             	cmp    %rcx,%rax
    bb52:	48 81 da e6 3f 53 12 	sbb    $0x12533fe6,%rdx
    bb59:	0f 82 7f 01 00 00    	jb     bcde <fwp_fmt_duration+0x26e>
    bb5f:	48 b9 7e 78 b9 2f 37 	movabs $0x97157d372fb9787e,%rcx
    bb66:	7d 15 97 
    bb69:	48 0f af ce          	imul   %rsi,%rcx
    bb6d:	48 bf 6d 9c 2e 3a 42 	movabs $0x8e47ce423a2e9c6d,%rdi
    bb74:	ce 47 8e 
    bb77:	48 89 f0             	mov    %rsi,%rax
    bb7a:	48 f7 e7             	mul    %rdi
    bb7d:	48 01 ca             	add    %rcx,%rdx
    bb80:	49 0f af f8          	imul   %r8,%rdi
    bb84:	48 01 d7             	add    %rdx,%rdi
    bb87:	48 b9 00 46 54 40 8b 	movabs $0xa52cb98b40544600,%rcx
    bb8e:	b9 2c a5 
    bb91:	48 01 c1             	add    %rax,%rcx
    bb94:	48 b8 b5 09 fa 82 4b 	movabs $0x44b82fa09b5,%rax
    bb9b:	04 00 00 
    bb9e:	48 11 f8             	adc    %rdi,%rax
    bba1:	48 89 c2             	mov    %rax,%rdx
    bba4:	48 0f ac ca 09       	shrd   $0x9,%rcx,%rdx
    bba9:	48 0f a4 c8 37       	shld   $0x37,%rcx,%rax
    bbae:	48 b9 47 54 40 8b b9 	movabs $0xb5a52cb98b405447,%rcx
    bbb5:	2c a5 b5 
    bbb8:	48 39 c8             	cmp    %rcx,%rax
    bbbb:	48 b8 09 fa 82 4b 04 	movabs $0x44b82fa09,%rax
    bbc2:	00 00 00 
    bbc5:	48 19 c2             	sbb    %rax,%rdx
    bbc8:	0f 82 22 01 00 00    	jb     bcf0 <fwp_fmt_duration+0x280>
    bbce:	48 b9 cb d5 8f 4d f2 	movabs $0xc57e23f24d8fd5cb,%rcx
    bbd5:	23 7e c5 
    bbd8:	48 0f af ce          	imul   %rsi,%rcx
    bbdc:	48 bf 39 61 c2 68 56 	movabs $0x790fb65668c26139,%rdi
    bbe3:	b6 0f 79 
    bbe6:	48 89 f0             	mov    %rsi,%rax
    bbe9:	48 f7 e7             	mul    %rdi
    bbec:	48 01 ca             	add    %rcx,%rdx
    bbef:	49 0f af f8          	imul   %r8,%rdi
    bbf3:	48 01 d7             	add    %rdx,%rdi
    bbf6:	48 b9 00 0b 27 69 fe 	movabs $0xa6d698fe69270b00,%rcx
    bbfd:	98 d6 a6 
    bc00:	48 01 c1             	add    %rax,%rcx
    bc03:	48 b8 b1 bd 16 f4 de 	movabs $0x218def416bdb1,%rax
    bc0a:	18 02 00 
    bc0d:	48 11 f8             	adc    %rdi,%rax
    bc10:	48 89 c2             	mov    %rax,%rdx
    bc13:	48 0f ac ca 06       	shrd   $0x6,%rcx,%rdx
    bc18:	48 0f a4 c8 3a       	shld   $0x3a,%rcx,%rax
    bc1d:	48 b9 59 38 49 f3 c7 	movabs $0x8d36b4c7f3493859,%rcx
    bc24:	b4 36 8d 
    bc27:	48 39 c8             	cmp    %rcx,%rax
    bc2a:	48 b8 ed b5 a0 f7 c6 	movabs $0x10c6f7a0b5ed,%rax
    bc31:	10 00 00 
    bc34:	48 19 c2             	sbb    %rax,%rdx
    bc37:	0f 82 c0 00 00 00    	jb     bcfd <fwp_fmt_duration+0x28d>
    bc3d:	48 b9 5a 64 3b df 4f 	movabs $0x6e978d4fdf3b645a,%rcx
    bc44:	8d 97 6e 
    bc47:	48 0f af ce          	imul   %rsi,%rcx
    bc4b:	48 bf d5 78 e9 26 31 	movabs $0x1cac083126e978d5,%rdi
    bc52:	08 ac 1c 
    bc55:	48 89 f0             	mov    %rsi,%rax
    bc58:	48 f7 e7             	mul    %rdi
    bc5b:	48 01 ca             	add    %rcx,%rdx
    bc5e:	49 0f af f8          	imul   %r8,%rdi
    bc62:	48 01 d7             	add    %rdx,%rdi
    bc65:	48 b9 48 62 10 58 39 	movabs $0x76c8b43958106248,%rcx
    bc6c:	b4 c8 76 
    bc6f:	48 01 c1             	add    %rax,%rcx
    bc72:	48 b8 be 9f 1a 2f dd 	movabs $0x10624dd2f1a9fbe,%rax
    bc79:	24 06 01 
    bc7c:	48 11 f8             	adc    %rdi,%rax
    bc7f:	48 89 c2             	mov    %rax,%rdx
    bc82:	48 0f ac ca 03       	shrd   $0x3,%rcx,%rdx
    bc87:	48 0f a4 c8 3d       	shld   $0x3d,%rcx,%rax
    bc8c:	48 b9 93 18 04 56 0e 	movabs $0x9db22d0e56041893,%rcx
    bc93:	2d b2 9d 
    bc96:	48 39 c8             	cmp    %rcx,%rax
    bc99:	48 b8 ef a7 c6 4b 37 	movabs $0x4189374bc6a7ef,%rax
    bca0:	89 41 00 
    bca3:	48 19 c2             	sbb    %rax,%rdx
    bca6:	72 62                	jb     bd0a <fwp_fmt_duration+0x29a>
    bca8:	49 89 e6             	mov    %rsp,%r14
    bcab:	4c 89 f7             	mov    %r14,%rdi
    bcae:	4c 89 c2             	mov    %r8,%rdx
    bcb1:	e8 ca f6 ff ff       	call   b380 <fwp_fmt_i128>
    bcb6:	48 8d 35 ea 26 00 00 	lea    0x26ea(%rip),%rsi        # e3a7 <exec_in_fp0+0xd47>
    bcbd:	48 89 df             	mov    %rbx,%rdi
    bcc0:	4c 89 f2             	mov    %r14,%rdx
    bcc3:	31 c0                	xor    %eax,%eax
    bcc5:	e8 96 67 ff ff       	call   2460 <sprintf@plt>
    bcca:	e9 84 00 00 00       	jmp    bd53 <fwp_fmt_duration+0x2e3>
    bccf:	48 ba 00 a0 b8 30 46 	movabs $0x34630b8a000,%rdx
    bcd6:	03 00 00 
    bcd9:	45 31 ff             	xor    %r15d,%r15d
    bcdc:	eb 37                	jmp    bd15 <fwp_fmt_duration+0x2a5>
    bcde:	48 ba 00 58 47 f8 0d 	movabs $0xdf8475800,%rdx
    bce5:	00 00 00 
    bce8:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    bcee:	eb 25                	jmp    bd15 <fwp_fmt_duration+0x2a5>
    bcf0:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
    bcf5:	41 bf 02 00 00 00    	mov    $0x2,%r15d
    bcfb:	eb 18                	jmp    bd15 <fwp_fmt_duration+0x2a5>
    bcfd:	ba 40 42 0f 00       	mov    $0xf4240,%edx
    bd02:	41 bf 03 00 00 00    	mov    $0x3,%r15d
    bd08:	eb 0b                	jmp    bd15 <fwp_fmt_duration+0x2a5>
    bd0a:	ba e8 03 00 00       	mov    $0x3e8,%edx
    bd0f:	41 bf 04 00 00 00    	mov    $0x4,%r15d
    bd15:	31 c9                	xor    %ecx,%ecx
    bd17:	41 c1 e7 04          	shl    $0x4,%r15d
    bd1b:	4c 8d 25 0e 70 00 00 	lea    0x700e(%rip),%r12        # 12d30 <fwp_fmt_duration.units>
    bd22:	48 89 f7             	mov    %rsi,%rdi
    bd25:	4c 89 c6             	mov    %r8,%rsi
    bd28:	e8 33 0f 00 00       	call   cc60 <__divti3>
    bd2d:	49 89 e6             	mov    %rsp,%r14
    bd30:	4c 89 f7             	mov    %r14,%rdi
    bd33:	48 89 c6             	mov    %rax,%rsi
    bd36:	e8 45 f6 ff ff       	call   b380 <fwp_fmt_i128>
    bd3b:	4b 8b 0c 27          	mov    (%r15,%r12,1),%rcx
    bd3f:	48 8d 35 5c 26 00 00 	lea    0x265c(%rip),%rsi        # e3a2 <exec_in_fp0+0xd42>
    bd46:	48 89 df             	mov    %rbx,%rdi
    bd49:	4c 89 f2             	mov    %r14,%rdx
    bd4c:	31 c0                	xor    %eax,%eax
    bd4e:	e8 0d 67 ff ff       	call   2460 <sprintf@plt>
    bd53:	48 83 c4 48          	add    $0x48,%rsp
    bd57:	5b                   	pop    %rbx
    bd58:	41 5c                	pop    %r12
    bd5a:	41 5e                	pop    %r14
    bd5c:	41 5f                	pop    %r15
    bd5e:	c3                   	ret
    bd5f:	90                   	nop

000000000000bd60 <fwp_needs_parens>:
    bd60:	8b 06                	mov    (%rsi),%eax
    bd62:	83 f8 10             	cmp    $0x10,%eax
    bd65:	74 16                	je     bd7d <fwp_needs_parens+0x1d>
    bd67:	83 f8 0e             	cmp    $0xe,%eax
    bd6a:	0f 85 30 02 00 00    	jne    bfa0 <fwp_is_negative>
    bd70:	31 c0                	xor    %eax,%eax
    bd72:	48 81 ff 00 10 00 00 	cmp    $0x1000,%rdi
    bd79:	0f 93 c0             	setae  %al
    bd7c:	c3                   	ret
    bd7d:	48 8b 46 08          	mov    0x8(%rsi),%rax
    bd81:	48 85 c0             	test   %rax,%rax
    bd84:	0f 84 16 02 00 00    	je     bfa0 <fwp_is_negative>
    bd8a:	50                   	push   %rax
    bd8b:	48 8d 35 08 25 00 00 	lea    0x2508(%rip),%rsi        # e29a <exec_in_fp0+0xc3a>
    bd92:	48 89 c7             	mov    %rax,%rdi
    bd95:	e8 26 65 ff ff       	call   22c0 <strcmp@plt>
    bd9a:	89 c1                	mov    %eax,%ecx
    bd9c:	31 c0                	xor    %eax,%eax
    bd9e:	85 c9                	test   %ecx,%ecx
    bda0:	0f 95 c0             	setne  %al
    bda3:	48 83 c4 08          	add    $0x8,%rsp
    bda7:	c3                   	ret
    bda8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    bdaf:	00 

000000000000bdb0 <fwp_format_g>:
    bdb0:	55                   	push   %rbp
    bdb1:	41 57                	push   %r15
    bdb3:	41 56                	push   %r14
    bdb5:	41 55                	push   %r13
    bdb7:	41 54                	push   %r12
    bdb9:	53                   	push   %rbx
    bdba:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    bdc1:	89 f5                	mov    %esi,%ebp
    bdc3:	48 89 fb             	mov    %rdi,%rbx
    bdc6:	ff cd                	dec    %ebp
    bdc8:	48 8d 15 a6 25 00 00 	lea    0x25a6(%rip),%rdx        # e375 <exec_in_fp0+0xd15>
    bdcf:	4c 8d 64 24 50       	lea    0x50(%rsp),%r12
    bdd4:	be 40 00 00 00       	mov    $0x40,%esi
    bdd9:	4c 89 e7             	mov    %r12,%rdi
    bddc:	89 e9                	mov    %ebp,%ecx
    bdde:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    bde4:	b0 01                	mov    $0x1,%al
    bde6:	e8 d5 63 ff ff       	call   21c0 <snprintf@plt>
    bdeb:	4c 89 e7             	mov    %r12,%rdi
    bdee:	be 65 00 00 00       	mov    $0x65,%esi
    bdf3:	e8 a8 63 ff ff       	call   21a0 <strchr@plt>
    bdf8:	49 89 c7             	mov    %rax,%r15
    bdfb:	48 8d 78 01          	lea    0x1(%rax),%rdi
    bdff:	e8 4c 66 ff ff       	call   2450 <atoi@plt>
    be04:	41 89 c6             	mov    %eax,%r14d
    be07:	41 8d 46 ef          	lea    -0x11(%r14),%eax
    be0b:	83 f8 e9             	cmp    $0xffffffe9,%eax
    be0e:	77 58                	ja     be68 <fwp_format_g+0xb8>
    be10:	4d 29 e7             	sub    %r12,%r15
    be13:	4c 8d 6c 24 10       	lea    0x10(%rsp),%r13
    be18:	4c 89 ef             	mov    %r13,%rdi
    be1b:	4c 89 e6             	mov    %r12,%rsi
    be1e:	4c 89 fa             	mov    %r15,%rdx
    be21:	e8 fa 64 ff ff       	call   2320 <memcpy@plt>
    be26:	42 c6 44 3c 10 00    	movb   $0x0,0x10(%rsp,%r15,1)
    be2c:	4c 89 ef             	mov    %r13,%rdi
    be2f:	be 2e 00 00 00       	mov    $0x2e,%esi
    be34:	e8 67 63 ff ff       	call   21a0 <strchr@plt>
    be39:	48 85 c0             	test   %rax,%rax
    be3c:	0f 84 91 00 00 00    	je     bed3 <fwp_format_g+0x123>
    be42:	4d 85 ff             	test   %r15,%r15
    be45:	0f 84 88 00 00 00    	je     bed3 <fwp_format_g+0x123>
    be4b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    be50:	42 0f b6 44 3c 0f    	movzbl 0xf(%rsp,%r15,1),%eax
    be56:	83 f8 30             	cmp    $0x30,%eax
    be59:	75 6d                	jne    bec8 <fwp_format_g+0x118>
    be5b:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    be61:	49 ff cf             	dec    %r15
    be64:	75 ea                	jne    be50 <fwp_format_g+0xa0>
    be66:	eb 6b                	jmp    bed3 <fwp_format_g+0x123>
    be68:	44 29 f5             	sub    %r14d,%ebp
    be6b:	31 c9                	xor    %ecx,%ecx
    be6d:	85 ed                	test   %ebp,%ebp
    be6f:	0f 4f cd             	cmovg  %ebp,%ecx
    be72:	48 8d 15 0b 25 00 00 	lea    0x250b(%rip),%rdx        # e384 <exec_in_fp0+0xd24>
    be79:	be 90 01 00 00       	mov    $0x190,%esi
    be7e:	48 89 df             	mov    %rbx,%rdi
    be81:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    be87:	b0 01                	mov    $0x1,%al
    be89:	e8 32 63 ff ff       	call   21c0 <snprintf@plt>
    be8e:	48 89 df             	mov    %rbx,%rdi
    be91:	e8 ca 62 ff ff       	call   2160 <strlen@plt>
    be96:	49 89 c6             	mov    %rax,%r14
    be99:	48 89 df             	mov    %rbx,%rdi
    be9c:	be 2e 00 00 00       	mov    $0x2e,%esi
    bea1:	e8 fa 62 ff ff       	call   21a0 <strchr@plt>
    bea6:	48 85 c0             	test   %rax,%rax
    bea9:	74 5b                	je     bf06 <fwp_format_g+0x156>
    beab:	4d 85 f6             	test   %r14,%r14
    beae:	74 56                	je     bf06 <fwp_format_g+0x156>
    beb0:	42 0f b6 44 33 ff    	movzbl -0x1(%rbx,%r14,1),%eax
    beb6:	83 f8 30             	cmp    $0x30,%eax
    beb9:	75 5d                	jne    bf18 <fwp_format_g+0x168>
    bebb:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    bec1:	49 ff ce             	dec    %r14
    bec4:	75 ea                	jne    beb0 <fwp_format_g+0x100>
    bec6:	eb 3e                	jmp    bf06 <fwp_format_g+0x156>
    bec8:	83 f8 2e             	cmp    $0x2e,%eax
    becb:	75 06                	jne    bed3 <fwp_format_g+0x123>
    becd:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    bed3:	44 89 f0             	mov    %r14d,%eax
    bed6:	c1 e8 1f             	shr    $0x1f,%eax
    bed9:	44 8d 04 45 2b 00 00 	lea    0x2b(,%rax,2),%r8d
    bee0:	00 
    bee1:	45 89 f1             	mov    %r14d,%r9d
    bee4:	41 f7 d9             	neg    %r9d
    bee7:	45 0f 48 ce          	cmovs  %r14d,%r9d
    beeb:	48 8d 15 88 24 00 00 	lea    0x2488(%rip),%rdx        # e37a <exec_in_fp0+0xd1a>
    bef2:	48 8d 4c 24 10       	lea    0x10(%rsp),%rcx
    bef7:	be 90 01 00 00       	mov    $0x190,%esi
    befc:	48 89 df             	mov    %rbx,%rdi
    beff:	31 c0                	xor    %eax,%eax
    bf01:	e8 ba 62 ff ff       	call   21c0 <snprintf@plt>
    bf06:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    bf0d:	5b                   	pop    %rbx
    bf0e:	41 5c                	pop    %r12
    bf10:	41 5d                	pop    %r13
    bf12:	41 5e                	pop    %r14
    bf14:	41 5f                	pop    %r15
    bf16:	5d                   	pop    %rbp
    bf17:	c3                   	ret
    bf18:	83 f8 2e             	cmp    $0x2e,%eax
    bf1b:	75 e9                	jne    bf06 <fwp_format_g+0x156>
    bf1d:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    bf23:	eb e1                	jmp    bf06 <fwp_format_g+0x156>
    bf25:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    bf2c:	00 00 00 00 

000000000000bf30 <fwp_finish_float>:
    bf30:	53                   	push   %rbx
    bf31:	48 89 fb             	mov    %rdi,%rbx
    bf34:	be 2e 00 00 00       	mov    $0x2e,%esi
    bf39:	e8 62 62 ff ff       	call   21a0 <strchr@plt>
    bf3e:	48 85 c0             	test   %rax,%rax
    bf41:	74 02                	je     bf45 <fwp_finish_float+0x15>
    bf43:	5b                   	pop    %rbx
    bf44:	c3                   	ret
    bf45:	48 89 df             	mov    %rbx,%rdi
    bf48:	be 65 00 00 00       	mov    $0x65,%esi
    bf4d:	e8 4e 62 ff ff       	call   21a0 <strchr@plt>
    bf52:	48 85 c0             	test   %rax,%rax
    bf55:	75 ec                	jne    bf43 <fwp_finish_float+0x13>
    bf57:	48 8d 35 57 23 00 00 	lea    0x2357(%rip),%rsi        # e2b5 <exec_in_fp0+0xc55>
    bf5e:	48 89 df             	mov    %rbx,%rdi
    bf61:	e8 7a 65 ff ff       	call   24e0 <strstr@plt>
    bf66:	48 85 c0             	test   %rax,%rax
    bf69:	75 d8                	jne    bf43 <fwp_finish_float+0x13>
    bf6b:	48 8d 35 47 23 00 00 	lea    0x2347(%rip),%rsi        # e2b9 <exec_in_fp0+0xc59>
    bf72:	48 89 df             	mov    %rbx,%rdi
    bf75:	e8 66 65 ff ff       	call   24e0 <strstr@plt>
    bf7a:	48 85 c0             	test   %rax,%rax
    bf7d:	75 c4                	jne    bf43 <fwp_finish_float+0x13>
    bf7f:	48 89 df             	mov    %rbx,%rdi
    bf82:	e8 d9 61 ff ff       	call   2160 <strlen@plt>
    bf87:	66 c7 04 03 2e 30    	movw   $0x302e,(%rbx,%rax,1)
    bf8d:	c6 44 03 02 00       	movb   $0x0,0x2(%rbx,%rax,1)
    bf92:	5b                   	pop    %rbx
    bf93:	c3                   	ret
    bf94:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    bf9b:	00 00 00 00 00 

000000000000bfa0 <fwp_is_negative>:
    bfa0:	50                   	push   %rax
    bfa1:	8b 0e                	mov    (%rsi),%ecx
    bfa3:	31 c0                	xor    %eax,%eax
    bfa5:	48 83 f9 0b          	cmp    $0xb,%rcx
    bfa9:	77 16                	ja     bfc1 <fwp_is_negative+0x21>
    bfab:	48 8d 15 72 14 00 00 	lea    0x1472(%rip),%rdx        # d424 <_IO_stdin_used+0x424>
    bfb2:	48 63 0c 8a          	movslq (%rdx,%rcx,4),%rcx
    bfb6:	48 01 d1             	add    %rdx,%rcx
    bfb9:	ff e1                	jmp    *%rcx
    bfbb:	48 c1 ef 3f          	shr    $0x3f,%rdi
    bfbf:	89 f8                	mov    %edi,%eax
    bfc1:	59                   	pop    %rcx
    bfc2:	c3                   	ret
    bfc3:	e8 08 de ff ff       	call   9dd0 <fwp_f32>
    bfc8:	0f 50 c0             	movmskps %xmm0,%eax
    bfcb:	eb 09                	jmp    bfd6 <fwp_is_negative+0x36>
    bfcd:	e8 fe 98 ff ff       	call   58d0 <fwp_f64>
    bfd2:	66 0f 50 c0          	movmskpd %xmm0,%eax
    bfd6:	83 e0 01             	and    $0x1,%eax
    bfd9:	59                   	pop    %rcx
    bfda:	c3                   	ret
    bfdb:	e8 c0 dd ff ff       	call   9da0 <fwp_i128>
    bfe0:	48 89 d0             	mov    %rdx,%rax
    bfe3:	48 c1 e8 3f          	shr    $0x3f,%rax
    bfe7:	59                   	pop    %rcx
    bfe8:	c3                   	ret
    bfe9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000bff0 <fwp_emit>:
    bff0:	53                   	push   %rbx
    bff1:	48 83 ec 30          	sub    $0x30,%rsp
    bff5:	48 89 f8             	mov    %rdi,%rax
    bff8:	83 3d 21 8e 01 00 00 	cmpl   $0x0,0x18e21(%rip)        # 24e20 <fwp_exec_binary_out>
    bfff:	74 66                	je     c067 <fwp_emit+0x77>
    c001:	0f 57 c0             	xorps  %xmm0,%xmm0
    c004:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    c009:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    c010:	00 00 
    c012:	48 8d 15 af 8c 00 00 	lea    0x8caf(%rip),%rdx        # 14cc8 <d1>
    c019:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    c01e:	48 89 c6             	mov    %rax,%rsi
    c021:	e8 9a 00 00 00       	call   c0c0 <fwp_encode>
    c026:	c6 44 24 0b 01       	movb   $0x1,0xb(%rsp)
    c02b:	8b 44 24 18          	mov    0x18(%rsp),%eax
    c02f:	89 44 24 0c          	mov    %eax,0xc(%rsp)
    c033:	48 8d 7c 24 0b       	lea    0xb(%rsp),%rdi
    c038:	be 05 00 00 00       	mov    $0x5,%esi
    c03d:	e8 1e a8 ff ff       	call   6860 <fwp_pipe_write>
    c042:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    c047:	48 85 f6             	test   %rsi,%rsi
    c04a:	74 0a                	je     c056 <fwp_emit+0x66>
    c04c:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    c051:	e8 0a a8 ff ff       	call   6860 <fwp_pipe_write>
    c056:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    c05b:	e8 f0 5f ff ff       	call   2050 <free@plt>
    c060:	e8 9b 02 00 00       	call   c300 <fwp_pipe_frame_done>
    c065:	eb 1c                	jmp    c083 <fwp_emit+0x93>
    c067:	83 3d 5a 8c 00 00 10 	cmpl   $0x10,0x8c5a(%rip)        # 14cc8 <d1>
    c06e:	75 19                	jne    c089 <fwp_emit+0x99>
    c070:	83 3d 61 8c 00 00 00 	cmpl   $0x0,0x8c61(%rip)        # 14cd8 <d1+0x10>
    c077:	75 10                	jne    c089 <fwp_emit+0x99>
    c079:	48 83 3d 4f 8c 00 00 	cmpq   $0x0,0x8c4f(%rip)        # 14cd0 <d1+0x8>
    c080:	00 
    c081:	75 06                	jne    c089 <fwp_emit+0x99>
    c083:	48 83 c4 30          	add    $0x30,%rsp
    c087:	5b                   	pop    %rbx
    c088:	c3                   	ret
    c089:	48 8b 1d 28 6f 00 00 	mov    0x6f28(%rip),%rbx        # 12fb8 <stdout@GLIBC_2.2.5>
    c090:	48 8b 13             	mov    (%rbx),%rdx
    c093:	48 8d 35 2e 8c 00 00 	lea    0x8c2e(%rip),%rsi        # 14cc8 <d1>
    c09a:	48 89 c7             	mov    %rax,%rdi
    c09d:	e8 6e eb ff ff       	call   ac10 <fwp_display_top>
    c0a2:	48 8b 33             	mov    (%rbx),%rsi
    c0a5:	bf 0a 00 00 00       	mov    $0xa,%edi
    c0aa:	48 83 c4 30          	add    $0x30,%rsp
    c0ae:	5b                   	pop    %rbx
    c0af:	e9 7c 61 ff ff       	jmp    2230 <fputc@plt>
    c0b4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    c0bb:	00 00 00 00 00 

000000000000c0c0 <fwp_encode>:
    c0c0:	41 57                	push   %r15
    c0c2:	41 56                	push   %r14
    c0c4:	41 55                	push   %r13
    c0c6:	41 54                	push   %r12
    c0c8:	53                   	push   %rbx
    c0c9:	8b 02                	mov    (%rdx),%eax
    c0cb:	48 83 f8 15          	cmp    $0x15,%rax
    c0cf:	0f 87 14 02 00 00    	ja     c2e9 <fwp_encode+0x229>
    c0d5:	49 89 d7             	mov    %rdx,%r15
    c0d8:	49 89 f6             	mov    %rsi,%r14
    c0db:	48 89 fb             	mov    %rdi,%rbx
    c0de:	48 8d 0d 6f 13 00 00 	lea    0x136f(%rip),%rcx        # d454 <_IO_stdin_used+0x454>
    c0e5:	48 63 04 81          	movslq (%rcx,%rax,4),%rax
    c0e9:	48 01 c8             	add    %rcx,%rax
    c0ec:	ff e0                	jmp    *%rax
    c0ee:	48 89 df             	mov    %rbx,%rdi
    c0f1:	4c 89 f6             	mov    %r14,%rsi
    c0f4:	ba 01 00 00 00       	mov    $0x1,%edx
    c0f9:	e9 77 01 00 00       	jmp    c275 <fwp_encode+0x1b5>
    c0fe:	48 89 df             	mov    %rbx,%rdi
    c101:	4c 89 f6             	mov    %r14,%rsi
    c104:	ba 04 00 00 00       	mov    $0x4,%edx
    c109:	e9 67 01 00 00       	jmp    c275 <fwp_encode+0x1b5>
    c10e:	49 8b 36             	mov    (%r14),%rsi
    c111:	48 89 df             	mov    %rbx,%rdi
    c114:	e8 57 02 00 00       	call   c370 <fwp_leb128>
    c119:	49 8b 16             	mov    (%r14),%rdx
    c11c:	49 83 c6 08          	add    $0x8,%r14
    c120:	48 89 df             	mov    %rbx,%rdi
    c123:	4c 89 f6             	mov    %r14,%rsi
    c126:	5b                   	pop    %rbx
    c127:	41 5c                	pop    %r12
    c129:	41 5d                	pop    %r13
    c12b:	41 5e                	pop    %r14
    c12d:	41 5f                	pop    %r15
    c12f:	e9 fc b5 ff ff       	jmp    7730 <buf_put>
    c134:	48 89 df             	mov    %rbx,%rdi
    c137:	4c 89 f6             	mov    %r14,%rsi
    c13a:	ba 02 00 00 00       	mov    $0x2,%edx
    c13f:	e9 31 01 00 00       	jmp    c275 <fwp_encode+0x1b5>
    c144:	49 8b 36             	mov    (%r14),%rsi
    c147:	48 89 df             	mov    %rbx,%rdi
    c14a:	e8 21 02 00 00       	call   c370 <fwp_leb128>
    c14f:	49 83 3e 00          	cmpq   $0x0,(%r14)
    c153:	0f 84 90 01 00 00    	je     c2e9 <fwp_encode+0x229>
    c159:	4d 8d 66 10          	lea    0x10(%r14),%r12
    c15d:	45 31 ed             	xor    %r13d,%r13d
    c160:	eb 1e                	jmp    c180 <fwp_encode+0xc0>
    c162:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c169:	1f 84 00 00 00 00 00 
    c170:	49 ff c5             	inc    %r13
    c173:	49 83 c4 10          	add    $0x10,%r12
    c177:	4d 3b 2e             	cmp    (%r14),%r13
    c17a:	0f 83 69 01 00 00    	jae    c2e9 <fwp_encode+0x229>
    c180:	49 8b 74 24 f8       	mov    -0x8(%r12),%rsi
    c185:	49 8b 57 38          	mov    0x38(%r15),%rdx
    c189:	48 89 df             	mov    %rbx,%rdi
    c18c:	e8 2f ff ff ff       	call   c0c0 <fwp_encode>
    c191:	41 83 3f 12          	cmpl   $0x12,(%r15)
    c195:	75 d9                	jne    c170 <fwp_encode+0xb0>
    c197:	49 8b 34 24          	mov    (%r12),%rsi
    c19b:	49 8b 57 40          	mov    0x40(%r15),%rdx
    c19f:	48 89 df             	mov    %rbx,%rdi
    c1a2:	e8 19 ff ff ff       	call   c0c0 <fwp_encode>
    c1a7:	eb c7                	jmp    c170 <fwp_encode+0xb0>
    c1a9:	4c 89 f7             	mov    %r14,%rdi
    c1ac:	e8 4f dc ff ff       	call   9e00 <fwp_tag>
    c1b1:	41 89 c4             	mov    %eax,%r12d
    c1b4:	48 89 df             	mov    %rbx,%rdi
    c1b7:	4c 89 e6             	mov    %r12,%rsi
    c1ba:	e8 b1 01 00 00       	call   c370 <fwp_leb128>
    c1bf:	49 8b 47 28          	mov    0x28(%r15),%rax
    c1c3:	42 83 3c a0 00       	cmpl   $0x0,(%rax,%r12,4)
    c1c8:	0f 8e 1b 01 00 00    	jle    c2e9 <fwp_encode+0x229>
    c1ce:	45 31 ed             	xor    %r13d,%r13d
    c1d1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c1d8:	0f 1f 84 00 00 00 00 
    c1df:	00 
    c1e0:	4b 8b 74 ee 08       	mov    0x8(%r14,%r13,8),%rsi
    c1e5:	49 8b 47 30          	mov    0x30(%r15),%rax
    c1e9:	4a 8b 04 e0          	mov    (%rax,%r12,8),%rax
    c1ed:	4a 8b 14 e8          	mov    (%rax,%r13,8),%rdx
    c1f1:	48 89 df             	mov    %rbx,%rdi
    c1f4:	e8 c7 fe ff ff       	call   c0c0 <fwp_encode>
    c1f9:	49 ff c5             	inc    %r13
    c1fc:	49 8b 47 28          	mov    0x28(%r15),%rax
    c200:	4a 63 04 a0          	movslq (%rax,%r12,4),%rax
    c204:	49 39 c5             	cmp    %rax,%r13
    c207:	7c d7                	jl     c1e0 <fwp_encode+0x120>
    c209:	e9 db 00 00 00       	jmp    c2e9 <fwp_encode+0x229>
    c20e:	4c 89 f7             	mov    %r14,%rdi
    c211:	e8 8a db ff ff       	call   9da0 <fwp_i128>
    c216:	eb 3f                	jmp    c257 <fwp_encode+0x197>
    c218:	4c 89 f7             	mov    %r14,%rdi
    c21b:	e8 70 d6 ff ff       	call   9890 <fwp_list_len>
    c220:	48 89 df             	mov    %rbx,%rdi
    c223:	48 89 c6             	mov    %rax,%rsi
    c226:	e8 45 01 00 00       	call   c370 <fwp_leb128>
    c22b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    c230:	4d 85 f6             	test   %r14,%r14
    c233:	0f 84 b0 00 00 00    	je     c2e9 <fwp_encode+0x229>
    c239:	49 8b 76 08          	mov    0x8(%r14),%rsi
    c23d:	49 8b 57 38          	mov    0x38(%r15),%rdx
    c241:	48 89 df             	mov    %rbx,%rdi
    c244:	e8 77 fe ff ff       	call   c0c0 <fwp_encode>
    c249:	4d 8b 76 10          	mov    0x10(%r14),%r14
    c24d:	eb e1                	jmp    c230 <fwp_encode+0x170>
    c24f:	4c 89 f7             	mov    %r14,%rdi
    c252:	e8 59 db ff ff       	call   9db0 <fwp_u128>
    c257:	49 89 d6             	mov    %rdx,%r14
    c25a:	48 89 df             	mov    %rbx,%rdi
    c25d:	48 89 c6             	mov    %rax,%rsi
    c260:	ba 08 00 00 00       	mov    $0x8,%edx
    c265:	e8 b6 00 00 00       	call   c320 <fwp_le>
    c26a:	48 89 df             	mov    %rbx,%rdi
    c26d:	4c 89 f6             	mov    %r14,%rsi
    c270:	ba 08 00 00 00       	mov    $0x8,%edx
    c275:	5b                   	pop    %rbx
    c276:	41 5c                	pop    %r12
    c278:	41 5d                	pop    %r13
    c27a:	41 5e                	pop    %r14
    c27c:	41 5f                	pop    %r15
    c27e:	e9 9d 00 00 00       	jmp    c320 <fwp_le>
    c283:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    c288:	7e 5f                	jle    c2e9 <fwp_encode+0x229>
    c28a:	45 31 e4             	xor    %r12d,%r12d
    c28d:	0f 1f 00             	nopl   (%rax)
    c290:	4b 8b 74 e6 08       	mov    0x8(%r14,%r12,8),%rsi
    c295:	49 8b 47 20          	mov    0x20(%r15),%rax
    c299:	4a 8b 14 e0          	mov    (%rax,%r12,8),%rdx
    c29d:	48 89 df             	mov    %rbx,%rdi
    c2a0:	e8 1b fe ff ff       	call   c0c0 <fwp_encode>
    c2a5:	49 ff c4             	inc    %r12
    c2a8:	49 63 47 10          	movslq 0x10(%r15),%rax
    c2ac:	49 39 c4             	cmp    %rax,%r12
    c2af:	7c df                	jl     c290 <fwp_encode+0x1d0>
    c2b1:	eb 36                	jmp    c2e9 <fwp_encode+0x229>
    c2b3:	49 8b 36             	mov    (%r14),%rsi
    c2b6:	48 89 df             	mov    %rbx,%rdi
    c2b9:	e8 b2 00 00 00       	call   c370 <fwp_leb128>
    c2be:	49 83 3e 00          	cmpq   $0x0,(%r14)
    c2c2:	74 25                	je     c2e9 <fwp_encode+0x229>
    c2c4:	45 31 e4             	xor    %r12d,%r12d
    c2c7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    c2ce:	00 00 
    c2d0:	4b 8b 74 e6 08       	mov    0x8(%r14,%r12,8),%rsi
    c2d5:	49 8b 57 38          	mov    0x38(%r15),%rdx
    c2d9:	48 89 df             	mov    %rbx,%rdi
    c2dc:	e8 df fd ff ff       	call   c0c0 <fwp_encode>
    c2e1:	49 ff c4             	inc    %r12
    c2e4:	4d 3b 26             	cmp    (%r14),%r12
    c2e7:	72 e7                	jb     c2d0 <fwp_encode+0x210>
    c2e9:	5b                   	pop    %rbx
    c2ea:	41 5c                	pop    %r12
    c2ec:	41 5d                	pop    %r13
    c2ee:	41 5e                	pop    %r14
    c2f0:	41 5f                	pop    %r15
    c2f2:	c3                   	ret
    c2f3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c2fa:	84 00 00 00 00 00 

000000000000c300 <fwp_pipe_frame_done>:
    c300:	83 3d ad 89 00 00 00 	cmpl   $0x0,0x89ad(%rip)        # 14cb4 <fwp_po_listen>
    c307:	78 16                	js     c31f <fwp_pipe_frame_done+0x1f>
    c309:	8b 05 61 8b 02 00    	mov    0x28b61(%rip),%eax        # 34e70 <fwp_po_frames>
    c30f:	ff c0                	inc    %eax
    c311:	89 05 59 8b 02 00    	mov    %eax,0x28b59(%rip)        # 34e70 <fwp_po_frames>
    c317:	a8 3f                	test   $0x3f,%al
    c319:	0f 84 11 e0 ff ff    	je     a330 <fwp_pipe_poll>
    c31f:	c3                   	ret

000000000000c320 <fwp_le>:
    c320:	85 d2                	test   %edx,%edx
    c322:	7e 44                	jle    c368 <fwp_le+0x48>
    c324:	41 57                	push   %r15
    c326:	41 56                	push   %r14
    c328:	41 54                	push   %r12
    c32a:	53                   	push   %rbx
    c32b:	50                   	push   %rax
    c32c:	48 89 f3             	mov    %rsi,%rbx
    c32f:	49 89 fe             	mov    %rdi,%r14
    c332:	41 89 d4             	mov    %edx,%r12d
    c335:	49 c1 e4 03          	shl    $0x3,%r12
    c339:	45 31 ff             	xor    %r15d,%r15d
    c33c:	0f 1f 40 00          	nopl   0x0(%rax)
    c340:	48 89 d8             	mov    %rbx,%rax
    c343:	44 89 f9             	mov    %r15d,%ecx
    c346:	48 d3 e8             	shr    %cl,%rax
    c349:	0f be f0             	movsbl %al,%esi
    c34c:	4c 89 f7             	mov    %r14,%rdi
    c34f:	e8 8c b3 ff ff       	call   76e0 <buf_putc>
    c354:	49 83 c7 08          	add    $0x8,%r15
    c358:	4d 39 fc             	cmp    %r15,%r12
    c35b:	75 e3                	jne    c340 <fwp_le+0x20>
    c35d:	48 83 c4 08          	add    $0x8,%rsp
    c361:	5b                   	pop    %rbx
    c362:	41 5c                	pop    %r12
    c364:	41 5e                	pop    %r14
    c366:	41 5f                	pop    %r15
    c368:	c3                   	ret
    c369:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000c370 <fwp_leb128>:
    c370:	41 57                	push   %r15
    c372:	41 56                	push   %r14
    c374:	53                   	push   %rbx
    c375:	49 89 f6             	mov    %rsi,%r14
    c378:	48 89 fb             	mov    %rdi,%rbx
    c37b:	48 81 fe 80 00 00 00 	cmp    $0x80,%rsi
    c382:	73 05                	jae    c389 <fwp_leb128+0x19>
    c384:	4d 89 f7             	mov    %r14,%r15
    c387:	eb 27                	jmp    c3b0 <fwp_leb128+0x40>
    c389:	4d 89 f7             	mov    %r14,%r15
    c38c:	0f 1f 40 00          	nopl   0x0(%rax)
    c390:	49 c1 ef 07          	shr    $0x7,%r15
    c394:	44 89 f0             	mov    %r14d,%eax
    c397:	0c 80                	or     $0x80,%al
    c399:	0f be f0             	movsbl %al,%esi
    c39c:	48 89 df             	mov    %rbx,%rdi
    c39f:	e8 3c b3 ff ff       	call   76e0 <buf_putc>
    c3a4:	49 81 fe ff 3f 00 00 	cmp    $0x3fff,%r14
    c3ab:	4d 89 fe             	mov    %r15,%r14
    c3ae:	77 e0                	ja     c390 <fwp_leb128+0x20>
    c3b0:	41 0f be f7          	movsbl %r15b,%esi
    c3b4:	48 89 df             	mov    %rbx,%rdi
    c3b7:	5b                   	pop    %rbx
    c3b8:	41 5e                	pop    %r14
    c3ba:	41 5f                	pop    %r15
    c3bc:	e9 1f b3 ff ff       	jmp    76e0 <buf_putc>
    c3c1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c3c8:	0f 1f 84 00 00 00 00 
    c3cf:	00 

000000000000c3d0 <fwp_pipe_read>:
    c3d0:	55                   	push   %rbp
    c3d1:	41 57                	push   %r15
    c3d3:	41 56                	push   %r14
    c3d5:	41 55                	push   %r13
    c3d7:	41 54                	push   %r12
    c3d9:	53                   	push   %rbx
    c3da:	50                   	push   %rax
    c3db:	48 89 f3             	mov    %rsi,%rbx
    c3de:	8b 05 90 8a 02 00    	mov    0x28a90(%rip),%eax        # 34e74 <fwp_pi_kind>
    c3e4:	83 f8 01             	cmp    $0x1,%eax
    c3e7:	0f 84 89 00 00 00    	je     c476 <fwp_pipe_read+0xa6>
    c3ed:	83 f8 02             	cmp    $0x2,%eax
    c3f0:	0f 85 d7 00 00 00    	jne    c4cd <fwp_pipe_read+0xfd>
    c3f6:	48 89 3c 24          	mov    %rdi,(%rsp)
    c3fa:	4c 8b 25 77 8a 02 00 	mov    0x28a77(%rip),%r12        # 34e78 <fwp_pi_ring>
    c401:	4d 8d ac 24 c0 00 00 	lea    0xc0(%r12),%r13
    c408:	00 
    c409:	49 8d ac 24 c4 00 00 	lea    0xc4(%r12),%rbp
    c410:	00 
    c411:	4c 8d 35 b8 01 00 00 	lea    0x1b8(%rip),%r14        # c5d0 <fwp_ring_has_data>
    c418:	45 31 ff             	xor    %r15d,%r15d
    c41b:	eb 23                	jmp    c440 <fwp_pipe_read+0x70>
    c41d:	0f 1f 00             	nopl   (%rax)
    c420:	44 8b 05 99 88 00 00 	mov    0x8899(%rip),%r8d        # 14cc0 <fwp_pi_sock>
    c427:	4c 89 e7             	mov    %r12,%rdi
    c42a:	4c 89 ee             	mov    %r13,%rsi
    c42d:	48 89 ea             	mov    %rbp,%rdx
    c430:	4c 89 f1             	mov    %r14,%rcx
    c433:	e8 98 dc ff ff       	call   a0d0 <fwp_ring_wait>
    c438:	85 c0                	test   %eax,%eax
    c43a:	0f 84 6c 01 00 00    	je     c5ac <fwp_pipe_read+0x1dc>
    c440:	49 8b 4c 24 40       	mov    0x40(%r12),%rcx
    c445:	49 8b 84 24 80 00 00 	mov    0x80(%r12),%rax
    c44c:	00 
    c44d:	48 29 c1             	sub    %rax,%rcx
    c450:	0f 85 9c 00 00 00    	jne    c4f2 <fwp_pipe_read+0x122>
    c456:	41 8b 84 24 40 01 00 	mov    0x140(%r12),%eax
    c45d:	00 
    c45e:	85 c0                	test   %eax,%eax
    c460:	74 be                	je     c420 <fwp_pipe_read+0x50>
    c462:	49 8b 44 24 40       	mov    0x40(%r12),%rax
    c467:	49 3b 84 24 80 00 00 	cmp    0x80(%r12),%rax
    c46e:	00 
    c46f:	75 af                	jne    c420 <fwp_pipe_read+0x50>
    c471:	e9 36 01 00 00       	jmp    c5ac <fwp_pipe_read+0x1dc>
    c476:	4c 8b 35 03 8a 02 00 	mov    0x28a03(%rip),%r14        # 34e80 <fwp_pi_pos>
    c47d:	4c 8b 3d 04 8a 02 00 	mov    0x28a04(%rip),%r15        # 34e88 <fwp_pi_len>
    c484:	4d 39 fe             	cmp    %r15,%r14
    c487:	0f 85 f9 00 00 00    	jne    c586 <fwp_pipe_read+0x1b6>
    c48d:	49 89 fc             	mov    %rdi,%r12
    c490:	4c 8d 35 f9 89 02 00 	lea    0x289f9(%rip),%r14        # 34e90 <fwp_pi_buf>
    c497:	45 31 ff             	xor    %r15d,%r15d
    c49a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    c4a0:	8b 3d 1a 88 00 00    	mov    0x881a(%rip),%edi        # 14cc0 <fwp_pi_sock>
    c4a6:	ba 00 00 01 00       	mov    $0x10000,%edx
    c4ab:	4c 89 f6             	mov    %r14,%rsi
    c4ae:	31 c9                	xor    %ecx,%ecx
    c4b0:	e8 ab 5b ff ff       	call   2060 <recv@plt>
    c4b5:	48 85 c0             	test   %rax,%rax
    c4b8:	0f 89 b6 00 00 00    	jns    c574 <fwp_pipe_read+0x1a4>
    c4be:	e8 bd 5b ff ff       	call   2080 <__errno_location@plt>
    c4c3:	83 38 04             	cmpl   $0x4,(%rax)
    c4c6:	74 d8                	je     c4a0 <fwp_pipe_read+0xd0>
    c4c8:	e9 df 00 00 00       	jmp    c5ac <fwp_pipe_read+0x1dc>
    c4cd:	48 8b 05 ec 6a 00 00 	mov    0x6aec(%rip),%rax        # 12fc0 <stdin@GLIBC_2.2.5>
    c4d4:	48 8b 08             	mov    (%rax),%rcx
    c4d7:	be 01 00 00 00       	mov    $0x1,%esi
    c4dc:	48 89 da             	mov    %rbx,%rdx
    c4df:	48 83 c4 08          	add    $0x8,%rsp
    c4e3:	5b                   	pop    %rbx
    c4e4:	41 5c                	pop    %r12
    c4e6:	41 5d                	pop    %r13
    c4e8:	41 5e                	pop    %r14
    c4ea:	41 5f                	pop    %r15
    c4ec:	5d                   	pop    %rbp
    c4ed:	e9 ee 5b ff ff       	jmp    20e0 <fread@plt>
    c4f2:	48 39 d9             	cmp    %rbx,%rcx
    c4f5:	48 0f 42 d9          	cmovb  %rcx,%rbx
    c4f9:	4d 8b 74 24 08       	mov    0x8(%r12),%r14
    c4fe:	49 8d 4e ff          	lea    -0x1(%r14),%rcx
    c502:	48 21 c1             	and    %rax,%rcx
    c505:	49 29 ce             	sub    %rcx,%r14
    c508:	4c 39 f3             	cmp    %r14,%rbx
    c50b:	4c 0f 42 f3          	cmovb  %rbx,%r14
    c50f:	4d 8d bc 24 00 10 00 	lea    0x1000(%r12),%r15
    c516:	00 
    c517:	49 8d 34 0c          	lea    (%r12,%rcx,1),%rsi
    c51b:	48 81 c6 00 10 00 00 	add    $0x1000,%rsi
    c522:	4c 8b 2c 24          	mov    (%rsp),%r13
    c526:	4c 89 ef             	mov    %r13,%rdi
    c529:	4c 89 f2             	mov    %r14,%rdx
    c52c:	e8 ef 5d ff ff       	call   2320 <memcpy@plt>
    c531:	4d 01 f5             	add    %r14,%r13
    c534:	48 89 da             	mov    %rbx,%rdx
    c537:	4c 29 f2             	sub    %r14,%rdx
    c53a:	4c 89 ef             	mov    %r13,%rdi
    c53d:	4c 89 fe             	mov    %r15,%rsi
    c540:	e8 db 5d ff ff       	call   2320 <memcpy@plt>
    c545:	49 8b 84 24 80 00 00 	mov    0x80(%r12),%rax
    c54c:	00 
    c54d:	48 01 d8             	add    %rbx,%rax
    c550:	49 89 84 24 80 00 00 	mov    %rax,0x80(%r12)
    c557:	00 
    c558:	49 8d bc 24 00 01 00 	lea    0x100(%r12),%rdi
    c55f:	00 
    c560:	49 81 c4 04 01 00 00 	add    $0x104,%r12
    c567:	4c 89 e6             	mov    %r12,%rsi
    c56a:	e8 c1 dc ff ff       	call   a230 <fwp_ring_wake>
    c56f:	49 89 df             	mov    %rbx,%r15
    c572:	eb 38                	jmp    c5ac <fwp_pipe_read+0x1dc>
    c574:	74 48                	je     c5be <fwp_pipe_read+0x1ee>
    c576:	4c 89 e7             	mov    %r12,%rdi
    c579:	48 89 05 08 89 02 00 	mov    %rax,0x28908(%rip)        # 34e88 <fwp_pi_len>
    c580:	45 31 f6             	xor    %r14d,%r14d
    c583:	49 89 c7             	mov    %rax,%r15
    c586:	4d 29 f7             	sub    %r14,%r15
    c589:	49 39 df             	cmp    %rbx,%r15
    c58c:	4c 0f 43 fb          	cmovae %rbx,%r15
    c590:	48 8d 35 f9 88 02 00 	lea    0x288f9(%rip),%rsi        # 34e90 <fwp_pi_buf>
    c597:	4c 01 f6             	add    %r14,%rsi
    c59a:	4c 89 fa             	mov    %r15,%rdx
    c59d:	e8 7e 5d ff ff       	call   2320 <memcpy@plt>
    c5a2:	4d 01 fe             	add    %r15,%r14
    c5a5:	4c 89 35 d4 88 02 00 	mov    %r14,0x288d4(%rip)        # 34e80 <fwp_pi_pos>
    c5ac:	4c 89 f8             	mov    %r15,%rax
    c5af:	48 83 c4 08          	add    $0x8,%rsp
    c5b3:	5b                   	pop    %rbx
    c5b4:	41 5c                	pop    %r12
    c5b6:	41 5d                	pop    %r13
    c5b8:	41 5e                	pop    %r14
    c5ba:	41 5f                	pop    %r15
    c5bc:	5d                   	pop    %rbp
    c5bd:	c3                   	ret
    c5be:	45 31 ff             	xor    %r15d,%r15d
    c5c1:	eb e9                	jmp    c5ac <fwp_pipe_read+0x1dc>
    c5c3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c5ca:	84 00 00 00 00 00 

000000000000c5d0 <fwp_ring_has_data>:
    c5d0:	48 8b 4f 40          	mov    0x40(%rdi),%rcx
    c5d4:	b8 01 00 00 00       	mov    $0x1,%eax
    c5d9:	48 3b 8f 80 00 00 00 	cmp    0x80(%rdi),%rcx
    c5e0:	75 0d                	jne    c5ef <fwp_ring_has_data+0x1f>
    c5e2:	8b 8f 40 01 00 00    	mov    0x140(%rdi),%ecx
    c5e8:	31 c0                	xor    %eax,%eax
    c5ea:	85 c9                	test   %ecx,%ecx
    c5ec:	0f 95 c0             	setne  %al
    c5ef:	c3                   	ret

000000000000c5f0 <fwp_pipe_report>:
    c5f0:	53                   	push   %rbx
    c5f1:	48 89 fb             	mov    %rdi,%rbx
    c5f4:	48 8d 3d bc 1d 00 00 	lea    0x1dbc(%rip),%rdi        # e3b7 <exec_in_fp0+0xd57>
    c5fb:	e8 30 5a ff ff       	call   2030 <getenv@plt>
    c600:	48 85 c0             	test   %rax,%rax
    c603:	74 18                	je     c61d <fwp_pipe_report+0x2d>
    c605:	80 38 00             	cmpb   $0x0,(%rax)
    c608:	74 13                	je     c61d <fwp_pipe_report+0x2d>
    c60a:	48 8d 35 79 1d 00 00 	lea    0x1d79(%rip),%rsi        # e38a <exec_in_fp0+0xd2a>
    c611:	48 89 c7             	mov    %rax,%rdi
    c614:	e8 a7 5c ff ff       	call   22c0 <strcmp@plt>
    c619:	85 c0                	test   %eax,%eax
    c61b:	75 02                	jne    c61f <fwp_pipe_report+0x2f>
    c61d:	5b                   	pop    %rbx
    c61e:	c3                   	ret
    c61f:	48 8b 05 ba 69 00 00 	mov    0x69ba(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    c626:	48 8b 38             	mov    (%rax),%rdi
    c629:	48 8d 35 9c 1d 00 00 	lea    0x1d9c(%rip),%rsi        # e3cc <exec_in_fp0+0xd6c>
    c630:	48 89 da             	mov    %rbx,%rdx
    c633:	31 c0                	xor    %eax,%eax
    c635:	5b                   	pop    %rbx
    c636:	e9 a5 5c ff ff       	jmp    22e0 <fprintf@plt>
    c63b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000c640 <rd_le>:
    c640:	55                   	push   %rbp
    c641:	41 56                	push   %r14
    c643:	53                   	push   %rbx
    c644:	48 83 ec 10          	sub    $0x10,%rsp
    c648:	48 89 d3             	mov    %rdx,%rbx
    c64b:	89 f5                	mov    %esi,%ebp
    c64d:	41 89 f6             	mov    %esi,%r14d
    c650:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    c655:	4c 89 f6             	mov    %r14,%rsi
    c658:	e8 23 01 00 00       	call   c780 <rd_take>
    c65d:	85 c0                	test   %eax,%eax
    c65f:	74 20                	je     c681 <rd_le+0x41>
    c661:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    c668:	b8 01 00 00 00       	mov    $0x1,%eax
    c66d:	85 ed                	test   %ebp,%ebp
    c66f:	7e 7d                	jle    c6ee <rd_le+0xae>
    c671:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    c676:	83 fd 01             	cmp    $0x1,%ebp
    c679:	75 0a                	jne    c685 <rd_le+0x45>
    c67b:	31 d2                	xor    %edx,%edx
    c67d:	31 ff                	xor    %edi,%edi
    c67f:	eb 55                	jmp    c6d6 <rd_le+0x96>
    c681:	31 c0                	xor    %eax,%eax
    c683:	eb 69                	jmp    c6ee <rd_le+0xae>
    c685:	45 89 f0             	mov    %r14d,%r8d
    c688:	41 81 e0 fe ff ff 7f 	and    $0x7ffffffe,%r8d
    c68f:	41 b9 08 00 00 00    	mov    $0x8,%r9d
    c695:	31 d2                	xor    %edx,%edx
    c697:	31 ff                	xor    %edi,%edi
    c699:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    c6a0:	44 0f b6 14 16       	movzbl (%rsi,%rdx,1),%r10d
    c6a5:	41 8d 49 f8          	lea    -0x8(%r9),%ecx
    c6a9:	80 e1 f0             	and    $0xf0,%cl
    c6ac:	49 d3 e2             	shl    %cl,%r10
    c6af:	49 09 fa             	or     %rdi,%r10
    c6b2:	4c 89 13             	mov    %r10,(%rbx)
    c6b5:	0f b6 7c 16 01       	movzbl 0x1(%rsi,%rdx,1),%edi
    c6ba:	44 89 c9             	mov    %r9d,%ecx
    c6bd:	80 e1 f8             	and    $0xf8,%cl
    c6c0:	48 d3 e7             	shl    %cl,%rdi
    c6c3:	4c 09 d7             	or     %r10,%rdi
    c6c6:	48 89 3b             	mov    %rdi,(%rbx)
    c6c9:	48 83 c2 02          	add    $0x2,%rdx
    c6cd:	49 83 c1 10          	add    $0x10,%r9
    c6d1:	49 39 d0             	cmp    %rdx,%r8
    c6d4:	75 ca                	jne    c6a0 <rd_le+0x60>
    c6d6:	41 f6 c6 01          	test   $0x1,%r14b
    c6da:	74 12                	je     c6ee <rd_le+0xae>
    c6dc:	0f b6 34 16          	movzbl (%rsi,%rdx,1),%esi
    c6e0:	c1 e2 03             	shl    $0x3,%edx
    c6e3:	89 d1                	mov    %edx,%ecx
    c6e5:	48 d3 e6             	shl    %cl,%rsi
    c6e8:	48 09 fe             	or     %rdi,%rsi
    c6eb:	48 89 33             	mov    %rsi,(%rbx)
    c6ee:	48 83 c4 10          	add    $0x10,%rsp
    c6f2:	5b                   	pop    %rbx
    c6f3:	41 5e                	pop    %r14
    c6f5:	5d                   	pop    %rbp
    c6f6:	c3                   	ret
    c6f7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    c6fe:	00 00 

000000000000c700 <rd_leb>:
    c700:	41 57                	push   %r15
    c702:	41 56                	push   %r14
    c704:	41 54                	push   %r12
    c706:	53                   	push   %rbx
    c707:	50                   	push   %rax
    c708:	48 89 f3             	mov    %rsi,%rbx
    c70b:	49 89 fe             	mov    %rdi,%r14
    c70e:	48 c7 06 00 00 00 00 	movq   $0x0,(%rsi)
    c715:	49 c7 c7 f9 ff ff ff 	mov    $0xfffffffffffffff9,%r15
    c71c:	49 89 e4             	mov    %rsp,%r12
    c71f:	90                   	nop
    c720:	be 01 00 00 00       	mov    $0x1,%esi
    c725:	4c 89 f7             	mov    %r14,%rdi
    c728:	4c 89 e2             	mov    %r12,%rdx
    c72b:	e8 50 00 00 00       	call   c780 <rd_take>
    c730:	85 c0                	test   %eax,%eax
    c732:	74 2f                	je     c763 <rd_leb+0x63>
    c734:	48 8b 04 24          	mov    (%rsp),%rax
    c738:	0f b6 10             	movzbl (%rax),%edx
    c73b:	49 83 ff 38          	cmp    $0x38,%r15
    c73f:	75 07                	jne    c748 <rd_leb+0x48>
    c741:	89 d1                	mov    %edx,%ecx
    c743:	80 e1 7e             	and    $0x7e,%cl
    c746:	75 1b                	jne    c763 <rd_leb+0x63>
    c748:	49 83 c7 07          	add    $0x7,%r15
    c74c:	83 e2 7f             	and    $0x7f,%edx
    c74f:	44 89 f9             	mov    %r15d,%ecx
    c752:	48 d3 e2             	shl    %cl,%rdx
    c755:	48 09 13             	or     %rdx,(%rbx)
    c758:	80 38 00             	cmpb   $0x0,(%rax)
    c75b:	79 0a                	jns    c767 <rd_leb+0x67>
    c75d:	49 83 ff 38          	cmp    $0x38,%r15
    c761:	76 bd                	jbe    c720 <rd_leb+0x20>
    c763:	31 c0                	xor    %eax,%eax
    c765:	eb 05                	jmp    c76c <rd_leb+0x6c>
    c767:	b8 01 00 00 00       	mov    $0x1,%eax
    c76c:	48 83 c4 08          	add    $0x8,%rsp
    c770:	5b                   	pop    %rbx
    c771:	41 5c                	pop    %r12
    c773:	41 5e                	pop    %r14
    c775:	41 5f                	pop    %r15
    c777:	c3                   	ret
    c778:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c77f:	00 

000000000000c780 <rd_take>:
    c780:	4c 8b 47 08          	mov    0x8(%rdi),%r8
    c784:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    c788:	49 29 c8             	sub    %rcx,%r8
    c78b:	31 c0                	xor    %eax,%eax
    c78d:	49 39 f0             	cmp    %rsi,%r8
    c790:	72 15                	jb     c7a7 <rd_take+0x27>
    c792:	48 8b 07             	mov    (%rdi),%rax
    c795:	48 01 c8             	add    %rcx,%rax
    c798:	48 89 02             	mov    %rax,(%rdx)
    c79b:	48 01 ce             	add    %rcx,%rsi
    c79e:	48 89 77 10          	mov    %rsi,0x10(%rdi)
    c7a2:	b8 01 00 00 00       	mov    $0x1,%eax
    c7a7:	c3                   	ret
    c7a8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c7af:	00 

000000000000c7b0 <fwp_getc>:
    c7b0:	48 63 05 75 86 01 00 	movslq 0x18675(%rip),%rax        # 24e2c <fwp_in_ppos>
    c7b7:	3b 05 6b 86 01 00    	cmp    0x1866b(%rip),%eax        # 24e28 <fwp_in_npend>
    c7bd:	7d 15                	jge    c7d4 <fwp_getc+0x24>
    c7bf:	8d 48 01             	lea    0x1(%rax),%ecx
    c7c2:	89 0d 64 86 01 00    	mov    %ecx,0x18664(%rip)        # 24e2c <fwp_in_ppos>
    c7c8:	48 8d 0d 55 86 01 00 	lea    0x18655(%rip),%rcx        # 24e24 <fwp_in_pend>
    c7cf:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax
    c7d3:	c3                   	ret
    c7d4:	48 8b 05 e5 67 00 00 	mov    0x67e5(%rip),%rax        # 12fc0 <stdin@GLIBC_2.2.5>
    c7db:	48 8b 38             	mov    (%rax),%rdi
    c7de:	e9 2d 5a ff ff       	jmp    2210 <fgetc@plt>
    c7e3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c7ea:	84 00 00 00 00 00 

000000000000c7f0 <fwp_gc_find_data>:
    c7f0:	0f b7 77 18          	movzwl 0x18(%rdi),%esi
    c7f4:	48 85 f6             	test   %rsi,%rsi
    c7f7:	0f 84 be 00 00 00    	je     c8bb <fwp_gc_find_data+0xcb>
    c7fd:	53                   	push   %rbx
    c7fe:	48 8b 07             	mov    (%rdi),%rax
    c801:	4c 8b 47 10          	mov    0x10(%rdi),%r8
    c805:	48 6b ce 38          	imul   $0x38,%rsi,%rcx
    c809:	45 31 c9             	xor    %r9d,%r9d
    c80c:	48 8d 15 7d 6a 00 00 	lea    0x6a7d(%rip),%rdx        # 13290 <fwp_gc>
    c813:	41 bb 01 00 00 00    	mov    $0x1,%r11d
    c819:	45 31 d2             	xor    %r10d,%r10d
    c81c:	eb 0b                	jmp    c829 <fwp_gc_find_data+0x39>
    c81e:	66 90                	xchg   %ax,%ax
    c820:	49 83 c1 38          	add    $0x38,%r9
    c824:	4c 39 c9             	cmp    %r9,%rcx
    c827:	74 22                	je     c84b <fwp_gc_find_data+0x5b>
    c829:	43 83 3c 08 01       	cmpl   $0x1,(%r8,%r9,1)
    c82e:	75 f0                	jne    c820 <fwp_gc_find_data+0x30>
    c830:	4b 8b 5c 08 10       	mov    0x10(%r8,%r9,1),%rbx
    c835:	48 01 c3             	add    %rax,%rbx
    c838:	48 39 d3             	cmp    %rdx,%rbx
    c83b:	77 e3                	ja     c820 <fwp_gc_find_data+0x30>
    c83d:	4b 03 5c 08 28       	add    0x28(%r8,%r9,1),%rbx
    c842:	48 39 d3             	cmp    %rdx,%rbx
    c845:	45 0f 47 d3          	cmova  %r11d,%r10d
    c849:	eb d5                	jmp    c820 <fwp_gc_find_data+0x30>
    c84b:	31 c0                	xor    %eax,%eax
    c84d:	45 85 d2             	test   %r10d,%r10d
    c850:	0f 95 c0             	setne  %al
    c853:	74 6e                	je     c8c3 <fwp_gc_find_data+0xd3>
    c855:	66 85 f6             	test   %si,%si
    c858:	74 69                	je     c8c3 <fwp_gc_find_data+0xd3>
    c85a:	8b 05 c0 7b 00 00    	mov    0x7bc0(%rip),%eax        # 14420 <fwp_gc+0x1190>
    c860:	48 8b 77 10          	mov    0x10(%rdi),%rsi
    c864:	45 31 c0             	xor    %r8d,%r8d
    c867:	eb 10                	jmp    c879 <fwp_gc_find_data+0x89>
    c869:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    c870:	49 83 c0 38          	add    $0x38,%r8
    c874:	4c 39 c1             	cmp    %r8,%rcx
    c877:	74 45                	je     c8be <fwp_gc_find_data+0xce>
    c879:	42 83 3c 06 01       	cmpl   $0x1,(%rsi,%r8,1)
    c87e:	75 f0                	jne    c870 <fwp_gc_find_data+0x80>
    c880:	42 f6 44 06 04 02    	testb  $0x2,0x4(%rsi,%r8,1)
    c886:	74 e8                	je     c870 <fwp_gc_find_data+0x80>
    c888:	83 f8 10             	cmp    $0x10,%eax
    c88b:	74 31                	je     c8be <fwp_gc_find_data+0xce>
    c88d:	4e 8b 4c 06 10       	mov    0x10(%rsi,%r8,1),%r9
    c892:	4c 03 0f             	add    (%rdi),%r9
    c895:	4c 63 d0             	movslq %eax,%r10
    c898:	49 c1 e2 04          	shl    $0x4,%r10
    c89c:	4d 89 8c 12 90 10 00 	mov    %r9,0x1090(%r10,%rdx,1)
    c8a3:	00 
    c8a4:	4e 8b 4c 06 28       	mov    0x28(%rsi,%r8,1),%r9
    c8a9:	4d 89 8c 12 98 10 00 	mov    %r9,0x1098(%r10,%rdx,1)
    c8b0:	00 
    c8b1:	ff c0                	inc    %eax
    c8b3:	89 05 67 7b 00 00    	mov    %eax,0x7b67(%rip)        # 14420 <fwp_gc+0x1190>
    c8b9:	eb b5                	jmp    c870 <fwp_gc_find_data+0x80>
    c8bb:	31 c0                	xor    %eax,%eax
    c8bd:	c3                   	ret
    c8be:	b8 01 00 00 00       	mov    $0x1,%eax
    c8c3:	5b                   	pop    %rbx
    c8c4:	c3                   	ret
    c8c5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    c8cc:	00 00 00 00 

000000000000c8d0 <fwp_gc_report>:
    c8d0:	41 57                	push   %r15
    c8d2:	41 56                	push   %r14
    c8d4:	53                   	push   %rbx
    c8d5:	48 83 ec 50          	sub    $0x50,%rsp
    c8d9:	48 8b 05 c0 7b 00 00 	mov    0x7bc0(%rip),%rax        # 144a0 <fwp_gc+0x1210>
    c8e0:	48 8b 0d a9 69 00 00 	mov    0x69a9(%rip),%rcx        # 13290 <fwp_gc>
    c8e7:	48 29 c8             	sub    %rcx,%rax
    c8ea:	f2 48 0f 2a c8       	cvtsi2sd %rax,%xmm1
    c8ef:	f2 0f 58 0d 81 7b 00 	addsd  0x7b81(%rip),%xmm1        # 14478 <fwp_gc+0x11e8>
    c8f6:	00 
    c8f7:	f2 0f 11 0d 79 7b 00 	movsd  %xmm1,0x7b79(%rip)        # 14478 <fwp_gc+0x11e8>
    c8fe:	00 
    c8ff:	48 89 0d 9a 7b 00 00 	mov    %rcx,0x7b9a(%rip)        # 144a0 <fwp_gc+0x1210>
    c906:	48 8b 05 d3 66 00 00 	mov    0x66d3(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    c90d:	4c 8b 38             	mov    (%rax),%r15
    c910:	48 8b 1d 51 7b 00 00 	mov    0x7b51(%rip),%rbx        # 14468 <fwp_gc+0x11d8>
    c917:	4c 8b 35 8a 79 00 00 	mov    0x798a(%rip),%r14        # 142a8 <fwp_gc+0x1018>
    c91e:	f2 0f 10 15 72 7b 00 	movsd  0x7b72(%rip),%xmm2        # 14498 <fwp_gc+0x1208>
    c925:	00 
    c926:	f2 0f 58 ca          	addsd  %xmm2,%xmm1
    c92a:	f2 0f 10 05 16 07 00 	movsd  0x716(%rip),%xmm0        # d048 <_IO_stdin_used+0x48>
    c931:	00 
    c932:	f2 0f 59 c8          	mulsd  %xmm0,%xmm1
    c936:	f2 0f 11 4c 24 18    	movsd  %xmm1,0x18(%rsp)
    c93c:	f2 0f 59 d0          	mulsd  %xmm0,%xmm2
    c940:	f2 0f 11 54 24 10    	movsd  %xmm2,0x10(%rsp)
    c946:	f2 0f 10 0d 8a 79 00 	movsd  0x798a(%rip),%xmm1        # 142d8 <fwp_gc+0x1048>
    c94d:	00 
    c94e:	66 0f 28 15 0a 08 00 	movapd 0x80a(%rip),%xmm2        # d160 <_IO_stdin_used+0x160>
    c955:	00 
    c956:	0f 14 ca             	unpcklps %xmm2,%xmm1
    c959:	66 0f 28 1d 0f 08 00 	movapd 0x80f(%rip),%xmm3        # d170 <_IO_stdin_used+0x170>
    c960:	00 
    c961:	66 0f 5c cb          	subpd  %xmm3,%xmm1
    c965:	66 0f 28 e1          	movapd %xmm1,%xmm4
    c969:	66 0f 15 e1          	unpckhpd %xmm1,%xmm4
    c96d:	f2 0f 58 e1          	addsd  %xmm1,%xmm4
    c971:	f2 0f 59 e0          	mulsd  %xmm0,%xmm4
    c975:	66 0f 29 64 24 40    	movapd %xmm4,0x40(%rsp)
    c97b:	f2 0f 10 0d d5 7a 00 	movsd  0x7ad5(%rip),%xmm1        # 14458 <fwp_gc+0x11c8>
    c982:	00 
    c983:	0f 14 ca             	unpcklps %xmm2,%xmm1
    c986:	66 0f 5c cb          	subpd  %xmm3,%xmm1
    c98a:	66 0f 28 e1          	movapd %xmm1,%xmm4
    c98e:	66 0f 15 e1          	unpckhpd %xmm1,%xmm4
    c992:	f2 0f 58 e1          	addsd  %xmm1,%xmm4
    c996:	f2 0f 59 e0          	mulsd  %xmm0,%xmm4
    c99a:	66 0f 29 64 24 30    	movapd %xmm4,0x30(%rsp)
    c9a0:	f2 0f 10 0d b8 7a 00 	movsd  0x7ab8(%rip),%xmm1        # 14460 <fwp_gc+0x11d0>
    c9a7:	00 
    c9a8:	0f 14 ca             	unpcklps %xmm2,%xmm1
    c9ab:	66 0f 5c cb          	subpd  %xmm3,%xmm1
    c9af:	66 0f 28 d1          	movapd %xmm1,%xmm2
    c9b3:	66 0f 15 d1          	unpckhpd %xmm1,%xmm2
    c9b7:	f2 0f 58 d1          	addsd  %xmm1,%xmm2
    c9bb:	f2 0f 59 d0          	mulsd  %xmm0,%xmm2
    c9bf:	66 0f 29 54 24 20    	movapd %xmm2,0x20(%rsp)
    c9c5:	f2 0f 10 05 b3 7a 00 	movsd  0x7ab3(%rip),%xmm0        # 14480 <fwp_gc+0x11f0>
    c9cc:	00 
    c9cd:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    c9d3:	f2 0f 10 05 ad 7a 00 	movsd  0x7aad(%rip),%xmm0        # 14488 <fwp_gc+0x11f8>
    c9da:	00 
    c9db:	f2 0f 11 04 24       	movsd  %xmm0,(%rsp)
    c9e0:	e8 6b 00 00 00       	call   ca50 <fwp_gc_status_kb>
    c9e5:	83 3d 98 78 00 00 00 	cmpl   $0x0,0x7898(%rip)        # 14284 <fwp_gc+0xff4>
    c9ec:	48 8d 0d 76 1b 00 00 	lea    0x1b76(%rip),%rcx        # e569 <exec_in_fp0+0xf09>
    c9f3:	4c 8d 0d ae 16 00 00 	lea    0x16ae(%rip),%r9        # e0a8 <exec_in_fp0+0xa48>
    c9fa:	4c 0f 44 c9          	cmove  %rcx,%r9
    c9fe:	48 8d 35 af 1a 00 00 	lea    0x1aaf(%rip),%rsi        # e4b4 <exec_in_fp0+0xe54>
    ca05:	4c 89 ff             	mov    %r15,%rdi
    ca08:	48 89 da             	mov    %rbx,%rdx
    ca0b:	4c 89 f1             	mov    %r14,%rcx
    ca0e:	f2 0f 10 44 24 18    	movsd  0x18(%rsp),%xmm0
    ca14:	f2 0f 10 4c 24 10    	movsd  0x10(%rsp),%xmm1
    ca1a:	0f 28 54 24 40       	movaps 0x40(%rsp),%xmm2
    ca1f:	0f 28 5c 24 30       	movaps 0x30(%rsp),%xmm3
    ca24:	0f 28 64 24 20       	movaps 0x20(%rsp),%xmm4
    ca29:	f2 0f 10 6c 24 08    	movsd  0x8(%rsp),%xmm5
    ca2f:	f2 0f 10 34 24       	movsd  (%rsp),%xmm6
    ca34:	49 89 c0             	mov    %rax,%r8
    ca37:	b0 07                	mov    $0x7,%al
    ca39:	48 83 c4 50          	add    $0x50,%rsp
    ca3d:	5b                   	pop    %rbx
    ca3e:	41 5e                	pop    %r14
    ca40:	41 5f                	pop    %r15
    ca42:	e9 99 58 ff ff       	jmp    22e0 <fprintf@plt>
    ca47:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    ca4e:	00 00 

000000000000ca50 <fwp_gc_status_kb>:
    ca50:	55                   	push   %rbp
    ca51:	41 57                	push   %r15
    ca53:	41 56                	push   %r14
    ca55:	41 54                	push   %r12
    ca57:	53                   	push   %rbx
    ca58:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
    ca5f:	48 8d 3d 15 1b 00 00 	lea    0x1b15(%rip),%rdi        # e57b <exec_in_fp0+0xf1b>
    ca66:	48 8d 35 2c 19 00 00 	lea    0x192c(%rip),%rsi        # e399 <exec_in_fp0+0xd39>
    ca6d:	e8 9e 59 ff ff       	call   2410 <fopen@plt>
    ca72:	48 85 c0             	test   %rax,%rax
    ca75:	74 7d                	je     caf4 <fwp_gc_status_kb+0xa4>
    ca77:	48 89 c3             	mov    %rax,%rbx
    ca7a:	48 89 e7             	mov    %rsp,%rdi
    ca7d:	be 00 01 00 00       	mov    $0x100,%esi
    ca82:	48 89 c2             	mov    %rax,%rdx
    ca85:	e8 f6 57 ff ff       	call   2280 <fgets@plt>
    ca8a:	49 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%r14
    ca91:	48 85 c0             	test   %rax,%rax
    ca94:	74 54                	je     caea <fwp_gc_status_kb+0x9a>
    ca96:	4c 8d 7c 24 06       	lea    0x6(%rsp),%r15
    ca9b:	bd 56 6d 48 57       	mov    $0x57486d56,%ebp
    caa0:	49 89 e4             	mov    %rsp,%r12
    caa3:	eb 20                	jmp    cac5 <fwp_gc_status_kb+0x75>
    caa5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    caac:	00 00 00 00 
    cab0:	4c 89 e7             	mov    %r12,%rdi
    cab3:	be 00 01 00 00       	mov    $0x100,%esi
    cab8:	48 89 da             	mov    %rbx,%rdx
    cabb:	e8 c0 57 ff ff       	call   2280 <fgets@plt>
    cac0:	48 85 c0             	test   %rax,%rax
    cac3:	74 25                	je     caea <fwp_gc_status_kb+0x9a>
    cac5:	8b 04 24             	mov    (%rsp),%eax
    cac8:	31 e8                	xor    %ebp,%eax
    caca:	0f b6 4c 24 04       	movzbl 0x4(%rsp),%ecx
    cacf:	83 f1 4d             	xor    $0x4d,%ecx
    cad2:	09 c1                	or     %eax,%ecx
    cad4:	75 da                	jne    cab0 <fwp_gc_status_kb+0x60>
    cad6:	80 7c 24 05 3a       	cmpb   $0x3a,0x5(%rsp)
    cadb:	75 d3                	jne    cab0 <fwp_gc_status_kb+0x60>
    cadd:	4c 89 ff             	mov    %r15,%rdi
    cae0:	e8 0b 59 ff ff       	call   23f0 <atol@plt>
    cae5:	49 89 c6             	mov    %rax,%r14
    cae8:	eb c6                	jmp    cab0 <fwp_gc_status_kb+0x60>
    caea:	48 89 df             	mov    %rbx,%rdi
    caed:	e8 4e 56 ff ff       	call   2140 <fclose@plt>
    caf2:	eb 07                	jmp    cafb <fwp_gc_status_kb+0xab>
    caf4:	49 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%r14
    cafb:	4c 89 f0             	mov    %r14,%rax
    cafe:	48 81 c4 00 01 00 00 	add    $0x100,%rsp
    cb05:	5b                   	pop    %rbx
    cb06:	41 5c                	pop    %r12
    cb08:	41 5e                	pop    %r14
    cb0a:	41 5f                	pop    %r15
    cb0c:	5d                   	pop    %rbp
    cb0d:	c3                   	ret
    cb0e:	66 90                	xchg   %ax,%ax

000000000000cb10 <w1>:
    cb10:	41 57                	push   %r15
    cb12:	41 56                	push   %r14
    cb14:	53                   	push   %rbx
    cb15:	48 89 f3             	mov    %rsi,%rbx
    cb18:	49 89 fe             	mov    %rdi,%r14
    cb1b:	48 bf 00 00 00 00 00 	movabs $0x3fd0000000000000,%rdi
    cb22:	00 d0 3f 
    cb25:	e8 76 8d ff ff       	call   58a0 <f4>
    cb2a:	49 89 c7             	mov    %rax,%r15
    cb2d:	48 89 df             	mov    %rbx,%rdi
    cb30:	e8 ab 8d ff ff       	call   58e0 <f8>
    cb35:	49 89 1e             	mov    %rbx,(%r14)
    cb38:	4d 89 7e 08          	mov    %r15,0x8(%r14)
    cb3c:	49 89 46 10          	mov    %rax,0x10(%r14)
    cb40:	4c 89 f0             	mov    %r14,%rax
    cb43:	5b                   	pop    %rbx
    cb44:	41 5e                	pop    %r14
    cb46:	41 5f                	pop    %r15
    cb48:	c3                   	ret
    cb49:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000cb50 <fwp_rc_drop_slot>:
    cb50:	0f b6 07             	movzbl (%rdi),%eax
    cb53:	3c ff                	cmp    $0xff,%al
    cb55:	74 09                	je     cb60 <fwp_rc_wide_drop>
    cb57:	3c 02                	cmp    $0x2,%al
    cb59:	72 04                	jb     cb5f <fwp_rc_drop_slot+0xf>
    cb5b:	fe c8                	dec    %al
    cb5d:	88 07                	mov    %al,(%rdi)
    cb5f:	c3                   	ret

000000000000cb60 <fwp_rc_wide_drop>:
    cb60:	53                   	push   %rbx
    cb61:	48 89 fb             	mov    %rdi,%rbx
    cb64:	e8 67 63 ff ff       	call   2ed0 <fwp_rc_wide_link>
    cb69:	48 8b 00             	mov    (%rax),%rax
    cb6c:	48 85 c0             	test   %rax,%rax
    cb6f:	74 21                	je     cb92 <fwp_rc_wide_drop+0x32>
    cb71:	48 8b 48 08          	mov    0x8(%rax),%rcx
    cb75:	48 ff c9             	dec    %rcx
    cb78:	48 89 48 08          	mov    %rcx,0x8(%rax)
    cb7c:	48 81 f9 fe 00 00 00 	cmp    $0xfe,%rcx
    cb83:	75 0b                	jne    cb90 <fwp_rc_wide_drop+0x30>
    cb85:	48 89 df             	mov    %rbx,%rdi
    cb88:	e8 03 63 ff ff       	call   2e90 <fwp_rc_forget_slot>
    cb8d:	c6 03 fe             	movb   $0xfe,(%rbx)
    cb90:	5b                   	pop    %rbx
    cb91:	c3                   	ret
    cb92:	48 8d 3d 7a 0b 00 00 	lea    0xb7a(%rip),%rdi        # d713 <exec_in_fp0+0xb3>
    cb99:	e8 92 63 ff ff       	call   2f30 <fwp_trap>
    cb9e:	66 90                	xchg   %ax,%ax

000000000000cba0 <fwp_rc_poison>:
    cba0:	53                   	push   %rbx
    cba1:	48 89 f9             	mov    %rdi,%rcx
    cba4:	48 2b 0d 15 77 00 00 	sub    0x7715(%rip),%rcx        # 142c0 <fwp_gc+0x1030>
    cbab:	48 8b 05 56 77 00 00 	mov    0x7756(%rip),%rax        # 14308 <fwp_gc+0x1078>
    cbb2:	48 c1 e9 10          	shr    $0x10,%rcx
    cbb6:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    cbbd:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    cbc2:	75 0d                	jne    cbd1 <fwp_rc_poison+0x31>
    cbc4:	80 3c 08 02          	cmpb   $0x2,(%rax,%rcx,1)
    cbc8:	75 1e                	jne    cbe8 <fwp_rc_poison+0x48>
    cbca:	48 8b 54 08 18       	mov    0x18(%rax,%rcx,1),%rdx
    cbcf:	eb 1b                	jmp    cbec <fwp_rc_poison+0x4c>
    cbd1:	c7 07 ad de 00 00    	movl   $0xdead,(%rdi)
    cbd7:	8b 47 04             	mov    0x4(%rdi),%eax
    cbda:	48 85 c0             	test   %rax,%rax
    cbdd:	74 7e                	je     cc5d <fwp_rc_poison+0xbd>
    cbdf:	83 f8 04             	cmp    $0x4,%eax
    cbe2:	73 22                	jae    cc06 <fwp_rc_poison+0x66>
    cbe4:	31 c9                	xor    %ecx,%ecx
    cbe6:	eb 50                	jmp    cc38 <fwp_rc_poison+0x98>
    cbe8:	8b 54 08 08          	mov    0x8(%rax,%rcx,1),%edx
    cbec:	48 89 fb             	mov    %rdi,%rbx
    cbef:	be dd 00 00 00       	mov    $0xdd,%esi
    cbf4:	e8 07 56 ff ff       	call   2200 <memset@plt>
    cbf9:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    cc00:	c6 43 08 00          	movb   $0x0,0x8(%rbx)
    cc04:	5b                   	pop    %rbx
    cc05:	c3                   	ret
    cc06:	89 c1                	mov    %eax,%ecx
    cc08:	83 e1 fc             	and    $0xfffffffc,%ecx
    cc0b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    cc12:	00 
    cc13:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    cc17:	31 f6                	xor    %esi,%esi
    cc19:	0f 28 05 60 05 00 00 	movaps 0x560(%rip),%xmm0        # d180 <_IO_stdin_used+0x180>
    cc20:	0f 11 44 37 08       	movups %xmm0,0x8(%rdi,%rsi,1)
    cc25:	0f 11 44 37 18       	movups %xmm0,0x18(%rdi,%rsi,1)
    cc2a:	48 83 c6 20          	add    $0x20,%rsi
    cc2e:	48 39 f2             	cmp    %rsi,%rdx
    cc31:	75 ed                	jne    cc20 <fwp_rc_poison+0x80>
    cc33:	48 39 c1             	cmp    %rax,%rcx
    cc36:	74 25                	je     cc5d <fwp_rc_poison+0xbd>
    cc38:	48 ba ef be ad de ef 	movabs $0xdeadbeefdeadbeef,%rdx
    cc3f:	be ad de 
    cc42:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    cc49:	1f 84 00 00 00 00 00 
    cc50:	48 89 54 cf 08       	mov    %rdx,0x8(%rdi,%rcx,8)
    cc55:	48 ff c1             	inc    %rcx
    cc58:	48 39 c8             	cmp    %rcx,%rax
    cc5b:	75 f3                	jne    cc50 <fwp_rc_poison+0xb0>
    cc5d:	5b                   	pop    %rbx
    cc5e:	c3                   	ret
    cc5f:	90                   	nop

000000000000cc60 <__divti3>:
    cc60:	f3 0f 1e fa          	endbr64
    cc64:	55                   	push   %rbp
    cc65:	49 89 f8             	mov    %rdi,%r8
    cc68:	49 89 d2             	mov    %rdx,%r10
    cc6b:	49 89 cb             	mov    %rcx,%r11
    cc6e:	31 ff                	xor    %edi,%edi
    cc70:	48 89 e5             	mov    %rsp,%rbp
    cc73:	41 56                	push   %r14
    cc75:	53                   	push   %rbx
    cc76:	48 85 f6             	test   %rsi,%rsi
    cc79:	79 13                	jns    cc8e <__divti3+0x2e>
    cc7b:	45 31 c9             	xor    %r9d,%r9d
    cc7e:	49 f7 d8             	neg    %r8
    cc81:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
    cc88:	49 19 f1             	sbb    %rsi,%r9
    cc8b:	4c 89 ce             	mov    %r9,%rsi
    cc8e:	4c 89 da             	mov    %r11,%rdx
    cc91:	4d 85 db             	test   %r11,%r11
    cc94:	0f 88 f6 00 00 00    	js     cd90 <__divti3+0x130>
    cc9a:	4d 89 d6             	mov    %r10,%r14
    cc9d:	75 31                	jne    ccd0 <__divti3+0x70>
    cc9f:	4c 39 f6             	cmp    %r14,%rsi
    cca2:	0f 83 b8 00 00 00    	jae    cd60 <__divti3+0x100>
    cca8:	48 89 f2             	mov    %rsi,%rdx
    ccab:	31 f6                	xor    %esi,%esi
    ccad:	4c 89 c0             	mov    %r8,%rax
    ccb0:	49 f7 f6             	div    %r14
    ccb3:	48 89 f2             	mov    %rsi,%rdx
    ccb6:	48 85 ff             	test   %rdi,%rdi
    ccb9:	74 0a                	je     ccc5 <__divti3+0x65>
    ccbb:	48 f7 d8             	neg    %rax
    ccbe:	48 83 d2 00          	adc    $0x0,%rdx
    ccc2:	48 f7 da             	neg    %rdx
    ccc5:	5b                   	pop    %rbx
    ccc6:	41 5e                	pop    %r14
    ccc8:	5d                   	pop    %rbp
    ccc9:	c3                   	ret
    ccca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    ccd0:	4c 39 de             	cmp    %r11,%rsi
    ccd3:	0f 82 d5 00 00 00    	jb     cdae <__divti3+0x14e>
    ccd9:	4d 0f bd d3          	bsr    %r11,%r10
    ccdd:	41 83 f2 3f          	xor    $0x3f,%r10d
    cce1:	44 89 d1             	mov    %r10d,%ecx
    cce4:	b8 40 00 00 00       	mov    $0x40,%eax
    cce9:	4c 89 f3             	mov    %r14,%rbx
    ccec:	4d 89 f1             	mov    %r14,%r9
    ccef:	48 d3 e2             	shl    %cl,%rdx
    ccf2:	49 63 ca             	movslq %r10d,%rcx
    ccf5:	49 89 f3             	mov    %rsi,%r11
    ccf8:	48 29 c8             	sub    %rcx,%rax
    ccfb:	89 c1                	mov    %eax,%ecx
    ccfd:	48 d3 eb             	shr    %cl,%rbx
    cd00:	44 89 d1             	mov    %r10d,%ecx
    cd03:	49 d3 e1             	shl    %cl,%r9
    cd06:	89 c1                	mov    %eax,%ecx
    cd08:	48 09 d3             	or     %rdx,%rbx
    cd0b:	4c 89 c2             	mov    %r8,%rdx
    cd0e:	49 d3 eb             	shr    %cl,%r11
    cd11:	44 89 d1             	mov    %r10d,%ecx
    cd14:	48 d3 e6             	shl    %cl,%rsi
    cd17:	89 c1                	mov    %eax,%ecx
    cd19:	48 d3 ea             	shr    %cl,%rdx
    cd1c:	48 89 d0             	mov    %rdx,%rax
    cd1f:	4c 89 da             	mov    %r11,%rdx
    cd22:	48 09 f0             	or     %rsi,%rax
    cd25:	48 f7 f3             	div    %rbx
    cd28:	49 89 d3             	mov    %rdx,%r11
    cd2b:	48 89 c6             	mov    %rax,%rsi
    cd2e:	49 f7 e1             	mul    %r9
    cd31:	49 39 d3             	cmp    %rdx,%r11
    cd34:	0f 82 be 00 00 00    	jb     cdf8 <__divti3+0x198>
    cd3a:	44 89 d1             	mov    %r10d,%ecx
    cd3d:	49 d3 e0             	shl    %cl,%r8
    cd40:	49 39 c0             	cmp    %rax,%r8
    cd43:	73 09                	jae    cd4e <__divti3+0xee>
    cd45:	49 39 d3             	cmp    %rdx,%r11
    cd48:	0f 84 aa 00 00 00    	je     cdf8 <__divti3+0x198>
    cd4e:	48 89 f0             	mov    %rsi,%rax
    cd51:	31 f6                	xor    %esi,%esi
    cd53:	e9 5b ff ff ff       	jmp    ccb3 <__divti3+0x53>
    cd58:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    cd5f:	00 
    cd60:	4d 85 f6             	test   %r14,%r14
    cd63:	75 0d                	jne    cd72 <__divti3+0x112>
    cd65:	b8 01 00 00 00       	mov    $0x1,%eax
    cd6a:	31 d2                	xor    %edx,%edx
    cd6c:	49 f7 f6             	div    %r14
    cd6f:	49 89 c6             	mov    %rax,%r14
    cd72:	48 89 f0             	mov    %rsi,%rax
    cd75:	31 d2                	xor    %edx,%edx
    cd77:	49 f7 f6             	div    %r14
    cd7a:	48 89 c6             	mov    %rax,%rsi
    cd7d:	4c 89 c0             	mov    %r8,%rax
    cd80:	49 f7 f6             	div    %r14
    cd83:	e9 2b ff ff ff       	jmp    ccb3 <__divti3+0x53>
    cd88:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    cd8f:	00 
    cd90:	49 f7 da             	neg    %r10
    cd93:	48 f7 d7             	not    %rdi
    cd96:	49 83 d3 00          	adc    $0x0,%r11
    cd9a:	4d 89 d6             	mov    %r10,%r14
    cd9d:	49 f7 db             	neg    %r11
    cda0:	4c 89 da             	mov    %r11,%rdx
    cda3:	0f 84 f6 fe ff ff    	je     cc9f <__divti3+0x3f>
    cda9:	4c 39 de             	cmp    %r11,%rsi
    cdac:	73 12                	jae    cdc0 <__divti3+0x160>
    cdae:	31 f6                	xor    %esi,%esi
    cdb0:	31 c0                	xor    %eax,%eax
    cdb2:	e9 fc fe ff ff       	jmp    ccb3 <__divti3+0x53>
    cdb7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    cdbe:	00 00 
    cdc0:	49 0f bd c3          	bsr    %r11,%rax
    cdc4:	48 83 f0 3f          	xor    $0x3f,%rax
    cdc8:	41 89 c2             	mov    %eax,%r10d
    cdcb:	85 c0                	test   %eax,%eax
    cdcd:	0f 85 0e ff ff ff    	jne    cce1 <__divti3+0x81>
    cdd3:	49 39 f3             	cmp    %rsi,%r11
    cdd6:	72 0d                	jb     cde5 <__divti3+0x185>
    cdd8:	31 f6                	xor    %esi,%esi
    cdda:	31 c0                	xor    %eax,%eax
    cddc:	4d 39 f0             	cmp    %r14,%r8
    cddf:	0f 82 ce fe ff ff    	jb     ccb3 <__divti3+0x53>
    cde5:	31 f6                	xor    %esi,%esi
    cde7:	b8 01 00 00 00       	mov    $0x1,%eax
    cdec:	e9 c2 fe ff ff       	jmp    ccb3 <__divti3+0x53>
    cdf1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    cdf8:	48 8d 46 ff          	lea    -0x1(%rsi),%rax
    cdfc:	31 f6                	xor    %esi,%esi
    cdfe:	e9 b0 fe ff ff       	jmp    ccb3 <__divti3+0x53>
    ce03:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    ce0a:	00 00 00 
    ce0d:	0f 1f 00             	nopl   (%rax)

000000000000ce10 <atexit>:
    ce10:	f3 0f 1e fa          	endbr64
    ce14:	48 8b 15 65 64 00 00 	mov    0x6465(%rip),%rdx        # 13280 <__dso_handle>
    ce1b:	31 f6                	xor    %esi,%esi
    ce1d:	e9 1e 56 ff ff       	jmp    2440 <__cxa_atexit@plt>

Disassembly of section .fini:

000000000000ce24 <_fini>:
    ce24:	f3 0f 1e fa          	endbr64
    ce28:	48 83 ec 08          	sub    $0x8,%rsp
    ce2c:	48 83 c4 08          	add    $0x8,%rsp
    ce30:	c3                   	ret
