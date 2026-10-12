
/home/runner/work/_temp/numeric-layout-baseline/floats-diagnostic:     file format elf64-x86-64


Disassembly of section .init:

0000000000002000 <_init>:
    2000:	f3 0f 1e fa          	endbr64
    2004:	48 83 ec 08          	sub    $0x8,%rsp
    2008:	48 8b 05 b9 1f 01 00 	mov    0x11fb9(%rip),%rax        # 13fc8 <__gmon_start__@Base>
    200f:	48 85 c0             	test   %rax,%rax
    2012:	74 02                	je     2016 <_init+0x16>
    2014:	ff d0                	call   *%rax
    2016:	48 83 c4 08          	add    $0x8,%rsp
    201a:	c3                   	ret

Disassembly of section .plt:

0000000000002020 <getenv@plt-0x10>:
    2020:	ff 35 ca 1f 01 00    	push   0x11fca(%rip)        # 13ff0 <_GLOBAL_OFFSET_TABLE_+0x8>
    2026:	ff 25 cc 1f 01 00    	jmp    *0x11fcc(%rip)        # 13ff8 <_GLOBAL_OFFSET_TABLE_+0x10>
    202c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000002030 <getenv@plt>:
    2030:	ff 25 ca 1f 01 00    	jmp    *0x11fca(%rip)        # 14000 <getenv@GLIBC_2.2.5>
    2036:	68 00 00 00 00       	push   $0x0
    203b:	e9 e0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002040 <dl_iterate_phdr@plt>:
    2040:	ff 25 c2 1f 01 00    	jmp    *0x11fc2(%rip)        # 14008 <dl_iterate_phdr@GLIBC_2.2.5>
    2046:	68 01 00 00 00       	push   $0x1
    204b:	e9 d0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002050 <free@plt>:
    2050:	ff 25 ba 1f 01 00    	jmp    *0x11fba(%rip)        # 14010 <free@GLIBC_2.2.5>
    2056:	68 02 00 00 00       	push   $0x2
    205b:	e9 c0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002060 <recv@plt>:
    2060:	ff 25 b2 1f 01 00    	jmp    *0x11fb2(%rip)        # 14018 <recv@GLIBC_2.2.5>
    2066:	68 03 00 00 00       	push   $0x3
    206b:	e9 b0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002070 <abort@plt>:
    2070:	ff 25 aa 1f 01 00    	jmp    *0x11faa(%rip)        # 14020 <abort@GLIBC_2.2.5>
    2076:	68 04 00 00 00       	push   $0x4
    207b:	e9 a0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002080 <__errno_location@plt>:
    2080:	ff 25 a2 1f 01 00    	jmp    *0x11fa2(%rip)        # 14028 <__errno_location@GLIBC_2.2.5>
    2086:	68 05 00 00 00       	push   $0x5
    208b:	e9 90 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002090 <strncmp@plt>:
    2090:	ff 25 9a 1f 01 00    	jmp    *0x11f9a(%rip)        # 14030 <strncmp@GLIBC_2.2.5>
    2096:	68 06 00 00 00       	push   $0x6
    209b:	e9 80 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020a0 <_exit@plt>:
    20a0:	ff 25 92 1f 01 00    	jmp    *0x11f92(%rip)        # 14038 <_exit@GLIBC_2.2.5>
    20a6:	68 07 00 00 00       	push   $0x7
    20ab:	e9 70 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020b0 <strcpy@plt>:
    20b0:	ff 25 8a 1f 01 00    	jmp    *0x11f8a(%rip)        # 14040 <strcpy@GLIBC_2.2.5>
    20b6:	68 08 00 00 00       	push   $0x8
    20bb:	e9 60 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020c0 <sendmsg@plt>:
    20c0:	ff 25 82 1f 01 00    	jmp    *0x11f82(%rip)        # 14048 <sendmsg@GLIBC_2.2.5>
    20c6:	68 09 00 00 00       	push   $0x9
    20cb:	e9 50 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020d0 <sigaction@plt>:
    20d0:	ff 25 7a 1f 01 00    	jmp    *0x11f7a(%rip)        # 14050 <sigaction@GLIBC_2.2.5>
    20d6:	68 0a 00 00 00       	push   $0xa
    20db:	e9 40 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020e0 <fread@plt>:
    20e0:	ff 25 72 1f 01 00    	jmp    *0x11f72(%rip)        # 14058 <fread@GLIBC_2.2.5>
    20e6:	68 0b 00 00 00       	push   $0xb
    20eb:	e9 30 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020f0 <strtod@plt>:
    20f0:	ff 25 6a 1f 01 00    	jmp    *0x11f6a(%rip)        # 14060 <strtod@GLIBC_2.2.5>
    20f6:	68 0c 00 00 00       	push   $0xc
    20fb:	e9 20 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002100 <vsnprintf@plt>:
    2100:	ff 25 62 1f 01 00    	jmp    *0x11f62(%rip)        # 14068 <vsnprintf@GLIBC_2.2.5>
    2106:	68 0d 00 00 00       	push   $0xd
    210b:	e9 10 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002110 <fcntl@plt>:
    2110:	ff 25 5a 1f 01 00    	jmp    *0x11f5a(%rip)        # 14070 <fcntl@GLIBC_2.2.5>
    2116:	68 0e 00 00 00       	push   $0xe
    211b:	e9 00 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002120 <clock_gettime@plt>:
    2120:	ff 25 52 1f 01 00    	jmp    *0x11f52(%rip)        # 14078 <clock_gettime@GLIBC_2.17>
    2126:	68 0f 00 00 00       	push   $0xf
    212b:	e9 f0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002130 <write@plt>:
    2130:	ff 25 4a 1f 01 00    	jmp    *0x11f4a(%rip)        # 14080 <write@GLIBC_2.2.5>
    2136:	68 10 00 00 00       	push   $0x10
    213b:	e9 e0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002140 <fclose@plt>:
    2140:	ff 25 42 1f 01 00    	jmp    *0x11f42(%rip)        # 14088 <fclose@GLIBC_2.2.5>
    2146:	68 11 00 00 00       	push   $0x11
    214b:	e9 d0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002150 <shutdown@plt>:
    2150:	ff 25 3a 1f 01 00    	jmp    *0x11f3a(%rip)        # 14090 <shutdown@GLIBC_2.2.5>
    2156:	68 12 00 00 00       	push   $0x12
    215b:	e9 c0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002160 <strlen@plt>:
    2160:	ff 25 32 1f 01 00    	jmp    *0x11f32(%rip)        # 14098 <strlen@GLIBC_2.2.5>
    2166:	68 13 00 00 00       	push   $0x13
    216b:	e9 b0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002170 <getuid@plt>:
    2170:	ff 25 2a 1f 01 00    	jmp    *0x11f2a(%rip)        # 140a0 <getuid@GLIBC_2.2.5>
    2176:	68 14 00 00 00       	push   $0x14
    217b:	e9 a0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002180 <mmap@plt>:
    2180:	ff 25 22 1f 01 00    	jmp    *0x11f22(%rip)        # 140a8 <mmap@GLIBC_2.2.5>
    2186:	68 15 00 00 00       	push   $0x15
    218b:	e9 90 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002190 <send@plt>:
    2190:	ff 25 1a 1f 01 00    	jmp    *0x11f1a(%rip)        # 140b0 <send@GLIBC_2.2.5>
    2196:	68 16 00 00 00       	push   $0x16
    219b:	e9 80 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021a0 <strchr@plt>:
    21a0:	ff 25 12 1f 01 00    	jmp    *0x11f12(%rip)        # 140b8 <strchr@GLIBC_2.2.5>
    21a6:	68 17 00 00 00       	push   $0x17
    21ab:	e9 70 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021b0 <printf@plt>:
    21b0:	ff 25 0a 1f 01 00    	jmp    *0x11f0a(%rip)        # 140c0 <printf@GLIBC_2.2.5>
    21b6:	68 18 00 00 00       	push   $0x18
    21bb:	e9 60 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021c0 <snprintf@plt>:
    21c0:	ff 25 02 1f 01 00    	jmp    *0x11f02(%rip)        # 140c8 <snprintf@GLIBC_2.2.5>
    21c6:	68 19 00 00 00       	push   $0x19
    21cb:	e9 50 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021d0 <ftruncate@plt>:
    21d0:	ff 25 fa 1e 01 00    	jmp    *0x11efa(%rip)        # 140d0 <ftruncate@GLIBC_2.2.5>
    21d6:	68 1a 00 00 00       	push   $0x1a
    21db:	e9 40 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021e0 <fputs@plt>:
    21e0:	ff 25 f2 1e 01 00    	jmp    *0x11ef2(%rip)        # 140d8 <fputs@GLIBC_2.2.5>
    21e6:	68 1b 00 00 00       	push   $0x1b
    21eb:	e9 30 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021f0 <strtof@plt>:
    21f0:	ff 25 ea 1e 01 00    	jmp    *0x11eea(%rip)        # 140e0 <strtof@GLIBC_2.2.5>
    21f6:	68 1c 00 00 00       	push   $0x1c
    21fb:	e9 20 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002200 <memset@plt>:
    2200:	ff 25 e2 1e 01 00    	jmp    *0x11ee2(%rip)        # 140e8 <memset@GLIBC_2.2.5>
    2206:	68 1d 00 00 00       	push   $0x1d
    220b:	e9 10 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002210 <fgetc@plt>:
    2210:	ff 25 da 1e 01 00    	jmp    *0x11eda(%rip)        # 140f0 <fgetc@GLIBC_2.2.5>
    2216:	68 1e 00 00 00       	push   $0x1e
    221b:	e9 00 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002220 <close@plt>:
    2220:	ff 25 d2 1e 01 00    	jmp    *0x11ed2(%rip)        # 140f8 <close@GLIBC_2.2.5>
    2226:	68 1f 00 00 00       	push   $0x1f
    222b:	e9 f0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002230 <fputc@plt>:
    2230:	ff 25 ca 1e 01 00    	jmp    *0x11eca(%rip)        # 14100 <fputc@GLIBC_2.2.5>
    2236:	68 20 00 00 00       	push   $0x20
    223b:	e9 e0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002240 <sched_yield@plt>:
    2240:	ff 25 c2 1e 01 00    	jmp    *0x11ec2(%rip)        # 14108 <sched_yield@GLIBC_2.2.5>
    2246:	68 21 00 00 00       	push   $0x21
    224b:	e9 d0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002250 <memchr@plt>:
    2250:	ff 25 ba 1e 01 00    	jmp    *0x11eba(%rip)        # 14110 <memchr@GLIBC_2.2.5>
    2256:	68 22 00 00 00       	push   $0x22
    225b:	e9 c0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002260 <memcmp@plt>:
    2260:	ff 25 b2 1e 01 00    	jmp    *0x11eb2(%rip)        # 14118 <memcmp@GLIBC_2.2.5>
    2266:	68 23 00 00 00       	push   $0x23
    226b:	e9 b0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002270 <pthread_attr_init@plt>:
    2270:	ff 25 aa 1e 01 00    	jmp    *0x11eaa(%rip)        # 14120 <pthread_attr_init@GLIBC_2.2.5>
    2276:	68 24 00 00 00       	push   $0x24
    227b:	e9 a0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002280 <fgets@plt>:
    2280:	ff 25 a2 1e 01 00    	jmp    *0x11ea2(%rip)        # 14128 <fgets@GLIBC_2.2.5>
    2286:	68 25 00 00 00       	push   $0x25
    228b:	e9 90 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002290 <getsockopt@plt>:
    2290:	ff 25 9a 1e 01 00    	jmp    *0x11e9a(%rip)        # 14130 <getsockopt@GLIBC_2.2.5>
    2296:	68 26 00 00 00       	push   $0x26
    229b:	e9 80 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022a0 <_setjmp@plt>:
    22a0:	ff 25 92 1e 01 00    	jmp    *0x11e92(%rip)        # 14138 <_setjmp@GLIBC_2.2.5>
    22a6:	68 27 00 00 00       	push   $0x27
    22ab:	e9 70 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022b0 <strtoull@plt>:
    22b0:	ff 25 8a 1e 01 00    	jmp    *0x11e8a(%rip)        # 14140 <strtoull@GLIBC_2.2.5>
    22b6:	68 28 00 00 00       	push   $0x28
    22bb:	e9 60 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022c0 <strcmp@plt>:
    22c0:	ff 25 82 1e 01 00    	jmp    *0x11e82(%rip)        # 14148 <strcmp@GLIBC_2.2.5>
    22c6:	68 29 00 00 00       	push   $0x29
    22cb:	e9 50 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022d0 <signal@plt>:
    22d0:	ff 25 7a 1e 01 00    	jmp    *0x11e7a(%rip)        # 14150 <signal@GLIBC_2.2.5>
    22d6:	68 2a 00 00 00       	push   $0x2a
    22db:	e9 40 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022e0 <fprintf@plt>:
    22e0:	ff 25 72 1e 01 00    	jmp    *0x11e72(%rip)        # 14158 <fprintf@GLIBC_2.2.5>
    22e6:	68 2b 00 00 00       	push   $0x2b
    22eb:	e9 30 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022f0 <syscall@plt>:
    22f0:	ff 25 6a 1e 01 00    	jmp    *0x11e6a(%rip)        # 14160 <syscall@GLIBC_2.2.5>
    22f6:	68 2c 00 00 00       	push   $0x2c
    22fb:	e9 20 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002300 <sigemptyset@plt>:
    2300:	ff 25 62 1e 01 00    	jmp    *0x11e62(%rip)        # 14168 <sigemptyset@GLIBC_2.2.5>
    2306:	68 2d 00 00 00       	push   $0x2d
    230b:	e9 10 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002310 <strtol@plt>:
    2310:	ff 25 5a 1e 01 00    	jmp    *0x11e5a(%rip)        # 14170 <strtol@GLIBC_2.2.5>
    2316:	68 2e 00 00 00       	push   $0x2e
    231b:	e9 00 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002320 <memcpy@plt>:
    2320:	ff 25 52 1e 01 00    	jmp    *0x11e52(%rip)        # 14178 <memcpy@GLIBC_2.14>
    2326:	68 2f 00 00 00       	push   $0x2f
    232b:	e9 f0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002330 <malloc@plt>:
    2330:	ff 25 4a 1e 01 00    	jmp    *0x11e4a(%rip)        # 14180 <malloc@GLIBC_2.2.5>
    2336:	68 30 00 00 00       	push   $0x30
    233b:	e9 e0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002340 <fflush@plt>:
    2340:	ff 25 42 1e 01 00    	jmp    *0x11e42(%rip)        # 14188 <fflush@GLIBC_2.2.5>
    2346:	68 31 00 00 00       	push   $0x31
    234b:	e9 d0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002350 <listen@plt>:
    2350:	ff 25 3a 1e 01 00    	jmp    *0x11e3a(%rip)        # 14190 <listen@GLIBC_2.2.5>
    2356:	68 32 00 00 00       	push   $0x32
    235b:	e9 c0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002360 <bcmp@plt>:
    2360:	ff 25 32 1e 01 00    	jmp    *0x11e32(%rip)        # 14198 <bcmp@GLIBC_2.2.5>
    2366:	68 33 00 00 00       	push   $0x33
    236b:	e9 b0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002370 <realloc@plt>:
    2370:	ff 25 2a 1e 01 00    	jmp    *0x11e2a(%rip)        # 141a0 <realloc@GLIBC_2.2.5>
    2376:	68 34 00 00 00       	push   $0x34
    237b:	e9 a0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002380 <munmap@plt>:
    2380:	ff 25 22 1e 01 00    	jmp    *0x11e22(%rip)        # 141a8 <munmap@GLIBC_2.2.5>
    2386:	68 35 00 00 00       	push   $0x35
    238b:	e9 90 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002390 <recvmsg@plt>:
    2390:	ff 25 1a 1e 01 00    	jmp    *0x11e1a(%rip)        # 141b0 <recvmsg@GLIBC_2.2.5>
    2396:	68 36 00 00 00       	push   $0x36
    239b:	e9 80 fc ff ff       	jmp    2020 <_init+0x20>

00000000000023a0 <setvbuf@plt>:
    23a0:	ff 25 12 1e 01 00    	jmp    *0x11e12(%rip)        # 141b8 <setvbuf@GLIBC_2.2.5>
    23a6:	68 37 00 00 00       	push   $0x37
    23ab:	e9 70 fc ff ff       	jmp    2020 <_init+0x20>

00000000000023b0 <poll@plt>:
    23b0:	ff 25 0a 1e 01 00    	jmp    *0x11e0a(%rip)        # 141c0 <poll@GLIBC_2.2.5>
    23b6:	68 38 00 00 00       	push   $0x38
    23bb:	e9 60 fc ff ff       	jmp    2020 <_init+0x20>

00000000000023c0 <bind@plt>:
    23c0:	ff 25 02 1e 01 00    	jmp    *0x11e02(%rip)        # 141c8 <bind@GLIBC_2.2.5>
    23c6:	68 39 00 00 00       	push   $0x39
    23cb:	e9 50 fc ff ff       	jmp    2020 <_init+0x20>

00000000000023d0 <pthread_create@plt>:
    23d0:	ff 25 fa 1d 01 00    	jmp    *0x11dfa(%rip)        # 141d0 <pthread_create@GLIBC_2.34>
    23d6:	68 3a 00 00 00       	push   $0x3a
    23db:	e9 40 fc ff ff       	jmp    2020 <_init+0x20>

00000000000023e0 <madvise@plt>:
    23e0:	ff 25 f2 1d 01 00    	jmp    *0x11df2(%rip)        # 141d8 <madvise@GLIBC_2.2.5>
    23e6:	68 3b 00 00 00       	push   $0x3b
    23eb:	e9 30 fc ff ff       	jmp    2020 <_init+0x20>

00000000000023f0 <atol@plt>:
    23f0:	ff 25 ea 1d 01 00    	jmp    *0x11dea(%rip)        # 141e0 <atol@GLIBC_2.2.5>
    23f6:	68 3c 00 00 00       	push   $0x3c
    23fb:	e9 20 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002400 <mprotect@plt>:
    2400:	ff 25 e2 1d 01 00    	jmp    *0x11de2(%rip)        # 141e8 <mprotect@GLIBC_2.2.5>
    2406:	68 3d 00 00 00       	push   $0x3d
    240b:	e9 10 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002410 <fopen@plt>:
    2410:	ff 25 da 1d 01 00    	jmp    *0x11dda(%rip)        # 141f0 <fopen@GLIBC_2.2.5>
    2416:	68 3e 00 00 00       	push   $0x3e
    241b:	e9 00 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002420 <sysconf@plt>:
    2420:	ff 25 d2 1d 01 00    	jmp    *0x11dd2(%rip)        # 141f8 <sysconf@GLIBC_2.2.5>
    2426:	68 3f 00 00 00       	push   $0x3f
    242b:	e9 f0 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002430 <accept@plt>:
    2430:	ff 25 ca 1d 01 00    	jmp    *0x11dca(%rip)        # 14200 <accept@GLIBC_2.2.5>
    2436:	68 40 00 00 00       	push   $0x40
    243b:	e9 e0 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002440 <__cxa_atexit@plt>:
    2440:	ff 25 c2 1d 01 00    	jmp    *0x11dc2(%rip)        # 14208 <__cxa_atexit@GLIBC_2.2.5>
    2446:	68 41 00 00 00       	push   $0x41
    244b:	e9 d0 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002450 <atoi@plt>:
    2450:	ff 25 ba 1d 01 00    	jmp    *0x11dba(%rip)        # 14210 <atoi@GLIBC_2.2.5>
    2456:	68 42 00 00 00       	push   $0x42
    245b:	e9 c0 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002460 <sprintf@plt>:
    2460:	ff 25 b2 1d 01 00    	jmp    *0x11db2(%rip)        # 14218 <sprintf@GLIBC_2.2.5>
    2466:	68 43 00 00 00       	push   $0x43
    246b:	e9 b0 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002470 <exit@plt>:
    2470:	ff 25 aa 1d 01 00    	jmp    *0x11daa(%rip)        # 14220 <exit@GLIBC_2.2.5>
    2476:	68 44 00 00 00       	push   $0x44
    247b:	e9 a0 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002480 <connect@plt>:
    2480:	ff 25 a2 1d 01 00    	jmp    *0x11da2(%rip)        # 14228 <connect@GLIBC_2.2.5>
    2486:	68 45 00 00 00       	push   $0x45
    248b:	e9 90 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002490 <fwrite@plt>:
    2490:	ff 25 9a 1d 01 00    	jmp    *0x11d9a(%rip)        # 14230 <fwrite@GLIBC_2.2.5>
    2496:	68 46 00 00 00       	push   $0x46
    249b:	e9 80 fb ff ff       	jmp    2020 <_init+0x20>

00000000000024a0 <getrlimit@plt>:
    24a0:	ff 25 92 1d 01 00    	jmp    *0x11d92(%rip)        # 14238 <getrlimit@GLIBC_2.2.5>
    24a6:	68 47 00 00 00       	push   $0x47
    24ab:	e9 70 fb ff ff       	jmp    2020 <_init+0x20>

00000000000024b0 <pthread_join@plt>:
    24b0:	ff 25 8a 1d 01 00    	jmp    *0x11d8a(%rip)        # 14240 <pthread_join@GLIBC_2.34>
    24b6:	68 48 00 00 00       	push   $0x48
    24bb:	e9 60 fb ff ff       	jmp    2020 <_init+0x20>

00000000000024c0 <sigaltstack@plt>:
    24c0:	ff 25 82 1d 01 00    	jmp    *0x11d82(%rip)        # 14248 <sigaltstack@GLIBC_2.2.5>
    24c6:	68 49 00 00 00       	push   $0x49
    24cb:	e9 50 fb ff ff       	jmp    2020 <_init+0x20>

00000000000024d0 <fstat@plt>:
    24d0:	ff 25 7a 1d 01 00    	jmp    *0x11d7a(%rip)        # 14250 <fstat@GLIBC_2.33>
    24d6:	68 4a 00 00 00       	push   $0x4a
    24db:	e9 40 fb ff ff       	jmp    2020 <_init+0x20>

00000000000024e0 <strstr@plt>:
    24e0:	ff 25 72 1d 01 00    	jmp    *0x11d72(%rip)        # 14258 <strstr@GLIBC_2.2.5>
    24e6:	68 4b 00 00 00       	push   $0x4b
    24eb:	e9 30 fb ff ff       	jmp    2020 <_init+0x20>

00000000000024f0 <__ctype_b_loc@plt>:
    24f0:	ff 25 6a 1d 01 00    	jmp    *0x11d6a(%rip)        # 14260 <__ctype_b_loc@GLIBC_2.3>
    24f6:	68 4c 00 00 00       	push   $0x4c
    24fb:	e9 20 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002500 <socket@plt>:
    2500:	ff 25 62 1d 01 00    	jmp    *0x11d62(%rip)        # 14268 <socket@GLIBC_2.2.5>
    2506:	68 4d 00 00 00       	push   $0x4d
    250b:	e9 10 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002510 <pthread_attr_setstacksize@plt>:
    2510:	ff 25 5a 1d 01 00    	jmp    *0x11d5a(%rip)        # 14270 <pthread_attr_setstacksize@GLIBC_2.34>
    2516:	68 4e 00 00 00       	push   $0x4e
    251b:	e9 00 fb ff ff       	jmp    2020 <_init+0x20>

Disassembly of section .plt.got:

0000000000002520 <__cxa_finalize@plt>:
    2520:	ff 25 b2 1a 01 00    	jmp    *0x11ab2(%rip)        # 13fd8 <__cxa_finalize@GLIBC_2.2.5>
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
    254f:	ff 15 53 1a 01 00    	call   *0x11a53(%rip)        # 13fa8 <__libc_start_main@GLIBC_2.34>
    2555:	f4                   	hlt
    2556:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    255d:	00 00 00 

0000000000002560 <deregister_tm_clones>:
    2560:	48 8d 3d 21 38 01 00 	lea    0x13821(%rip),%rdi        # 15d88 <__TMC_END__>
    2567:	48 8d 05 1a 38 01 00 	lea    0x1381a(%rip),%rax        # 15d88 <__TMC_END__>
    256e:	48 39 f8             	cmp    %rdi,%rax
    2571:	74 15                	je     2588 <deregister_tm_clones+0x28>
    2573:	48 8b 05 36 1a 01 00 	mov    0x11a36(%rip),%rax        # 13fb0 <_ITM_deregisterTMCloneTable@Base>
    257a:	48 85 c0             	test   %rax,%rax
    257d:	74 09                	je     2588 <deregister_tm_clones+0x28>
    257f:	ff e0                	jmp    *%rax
    2581:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    2588:	c3                   	ret
    2589:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002590 <register_tm_clones>:
    2590:	48 8d 3d f1 37 01 00 	lea    0x137f1(%rip),%rdi        # 15d88 <__TMC_END__>
    2597:	48 8d 35 ea 37 01 00 	lea    0x137ea(%rip),%rsi        # 15d88 <__TMC_END__>
    259e:	48 29 fe             	sub    %rdi,%rsi
    25a1:	48 89 f0             	mov    %rsi,%rax
    25a4:	48 c1 ee 3f          	shr    $0x3f,%rsi
    25a8:	48 c1 f8 03          	sar    $0x3,%rax
    25ac:	48 01 c6             	add    %rax,%rsi
    25af:	48 d1 fe             	sar    $1,%rsi
    25b2:	74 14                	je     25c8 <register_tm_clones+0x38>
    25b4:	48 8b 05 15 1a 01 00 	mov    0x11a15(%rip),%rax        # 13fd0 <_ITM_registerTMCloneTable@Base>
    25bb:	48 85 c0             	test   %rax,%rax
    25be:	74 08                	je     25c8 <register_tm_clones+0x38>
    25c0:	ff e0                	jmp    *%rax
    25c2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    25c8:	c3                   	ret
    25c9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000025d0 <__do_global_dtors_aux>:
    25d0:	f3 0f 1e fa          	endbr64
    25d4:	80 3d b5 37 01 00 00 	cmpb   $0x0,0x137b5(%rip)        # 15d90 <completed.0>
    25db:	75 2b                	jne    2608 <__do_global_dtors_aux+0x38>
    25dd:	55                   	push   %rbp
    25de:	48 83 3d f2 19 01 00 	cmpq   $0x0,0x119f2(%rip)        # 13fd8 <__cxa_finalize@GLIBC_2.2.5>
    25e5:	00 
    25e6:	48 89 e5             	mov    %rsp,%rbp
    25e9:	74 0c                	je     25f7 <__do_global_dtors_aux+0x27>
    25eb:	48 8b 3d 8e 1c 01 00 	mov    0x11c8e(%rip),%rdi        # 14280 <__dso_handle>
    25f2:	e8 29 ff ff ff       	call   2520 <__cxa_finalize@plt>
    25f7:	e8 64 ff ff ff       	call   2560 <deregister_tm_clones>
    25fc:	c6 05 8d 37 01 00 01 	movb   $0x1,0x1378d(%rip)        # 15d90 <completed.0>
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
    2627:	48 8d 05 62 12 01 00 	lea    0x11262(%rip),%rax        # 13890 <fwp_fn_table>
    262e:	48 89 05 6b 37 01 00 	mov    %rax,0x1376b(%rip)        # 15da0 <fwp_fns>
    2635:	4c 8b 35 7c 19 01 00 	mov    0x1197c(%rip),%r14        # 13fb8 <stdout@GLIBC_2.2.5>
    263c:	49 8b 06             	mov    (%r14),%rax
    263f:	48 89 05 62 37 01 00 	mov    %rax,0x13762(%rip)        # 15da8 <fwp_prog_out>
    2646:	89 3d 64 37 01 00    	mov    %edi,0x13764(%rip)        # 15db0 <fwp_argc>
    264c:	48 89 35 65 37 01 00 	mov    %rsi,0x13765(%rip)        # 15db8 <fwp_argv>
    2653:	48 8d 35 66 37 01 00 	lea    0x13766(%rip),%rsi        # 15dc0 <fwp_start_time>
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
    2696:	48 8b 35 eb 1b 01 00 	mov    0x11beb(%rip),%rsi        # 14288 <fwp_main_stack>
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
    26e6:	48 89 0d 9b 1b 01 00 	mov    %rcx,0x11b9b(%rip)        # 14288 <fwp_main_stack>
    26ed:	e8 8e 00 00 00       	call   2780 <fwp_main_thread>
    26f2:	eb 0c                	jmp    2700 <original_main+0xe0>
    26f4:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    26f9:	31 f6                	xor    %esi,%esi
    26fb:	e8 b0 fd ff ff       	call   24b0 <pthread_join@plt>
    2700:	49 8b 3e             	mov    (%r14),%rdi
    2703:	e8 38 fc ff ff       	call   2340 <fflush@plt>
    2708:	8b 05 c2 36 01 00    	mov    0x136c2(%rip),%eax        # 15dd0 <fwp_exit_code>
    270e:	48 83 c4 58          	add    $0x58,%rsp
    2712:	5b                   	pop    %rbx
    2713:	41 5e                	pop    %r14
    2715:	c3                   	ret
    2716:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    271d:	00 00 00 

0000000000002720 <fwp_seed_rng>:
    2720:	53                   	push   %rbx
    2721:	48 83 ec 20          	sub    $0x20,%rsp
    2725:	48 8d 3d 4b c1 00 00 	lea    0xc14b(%rip),%rdi        # e877 <exec_in_fp0+0x217>
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
    278c:	48 8b 3d f5 1a 01 00 	mov    0x11af5(%rip),%rdi        # 14288 <fwp_main_stack>
    2793:	e8 d8 33 00 00       	call   5b70 <fwp_stack_guard_init>
    2798:	48 8b 05 c1 14 01 00 	mov    0x114c1(%rip),%rax        # 13c60 <exec_scripts+0x10>
    279f:	48 89 05 4a 36 01 00 	mov    %rax,0x1364a(%rip)        # 15df0 <fwp_cli_scripts+0x10>
    27a6:	0f 28 05 a3 14 01 00 	movaps 0x114a3(%rip),%xmm0        # 13c50 <exec_scripts>
    27ad:	0f 29 05 2c 36 01 00 	movaps %xmm0,0x1362c(%rip)        # 15de0 <fwp_cli_scripts>
    27b4:	48 8d 05 f5 bc 00 00 	lea    0xbcf5(%rip),%rax        # e4b0 <exec_man>
    27bb:	48 89 05 36 36 01 00 	mov    %rax,0x13636(%rip)        # 15df8 <fwp_cli_man>
    27c2:	c6 05 37 36 01 00 01 	movb   $0x1,0x13637(%rip)        # 15e00 <fwp_cli_single>
    27c9:	8b 3d e1 35 01 00    	mov    0x135e1(%rip),%edi        # 15db0 <fwp_argc>
    27cf:	48 8b 35 e2 35 01 00 	mov    0x135e2(%rip),%rsi        # 15db8 <fwp_argv>
    27d6:	e8 75 34 00 00       	call   5c50 <fwp_exec>
    27db:	89 05 ef 35 01 00    	mov    %eax,0x135ef(%rip)        # 15dd0 <fwp_exit_code>
    27e1:	48 8b 05 d0 17 01 00 	mov    0x117d0(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
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
    280f:	48 8d 05 7a 10 01 00 	lea    0x1107a(%rip),%rax        # 13890 <fwp_fn_table>
    2816:	48 89 05 83 35 01 00 	mov    %rax,0x13583(%rip)        # 15da0 <fwp_fns>
    281d:	f2 0f 10 05 e3 b7 00 	movsd  0xb7e3(%rip),%xmm0        # e008 <_IO_stdin_used+0x8>
    2824:	00 
    2825:	e8 b6 01 00 00       	call   29e0 <fwp_from_f64>
    282a:	49 89 c6             	mov    %rax,%r14
    282d:	48 89 c7             	mov    %rax,%rdi
    2830:	e8 3b 01 00 00       	call   2970 <f3>
    2835:	48 89 c3             	mov    %rax,%rbx
    2838:	b8 7e 00 00 00       	mov    $0x7e,%eax
    283d:	83 7b 04 03          	cmpl   $0x3,0x4(%rbx)
    2841:	75 71                	jne    28b4 <main+0xb4>
    2843:	b8 7f 00 00 00       	mov    $0x7f,%eax
    2848:	4c 39 73 08          	cmp    %r14,0x8(%rbx)
    284c:	75 66                	jne    28b4 <main+0xb4>
    284e:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    2852:	f2 0f 10 05 b6 b7 00 	movsd  0xb7b6(%rip),%xmm0        # e010 <_IO_stdin_used+0x10>
    2859:	00 
    285a:	e8 81 01 00 00       	call   29e0 <fwp_from_f64>
    285f:	49 39 c6             	cmp    %rax,%r14
    2862:	75 4b                	jne    28af <main+0xaf>
    2864:	4c 8b 73 18          	mov    0x18(%rbx),%r14
    2868:	f2 0f 10 05 a8 b7 00 	movsd  0xb7a8(%rip),%xmm0        # e018 <_IO_stdin_used+0x18>
    286f:	00 
    2870:	e8 6b 01 00 00       	call   29e0 <fwp_from_f64>
    2875:	49 39 c6             	cmp    %rax,%r14
    2878:	b8 7f 00 00 00       	mov    $0x7f,%eax
    287d:	75 35                	jne    28b4 <main+0xb4>
    287f:	48 8d 3d ea bd 00 00 	lea    0xbdea(%rip),%rdi        # e670 <exec_in_fp0+0x10>
    2886:	be 18 00 00 00       	mov    $0x18,%esi
    288b:	ba 08 00 00 00       	mov    $0x8,%edx
    2890:	31 c0                	xor    %eax,%eax
    2892:	e8 19 f9 ff ff       	call   21b0 <printf@plt>
    2897:	48 89 df             	mov    %rbx,%rdi
    289a:	e8 51 01 00 00       	call   29f0 <fwp_rc_release_last>
    289f:	85 c0                	test   %eax,%eax
    28a1:	74 16                	je     28b9 <main+0xb9>
    28a3:	48 89 df             	mov    %rbx,%rdi
    28a6:	e8 75 01 00 00       	call   2a20 <fwp_rc_free_obj>
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
    28c4:	83 3d b1 29 01 00 00 	cmpl   $0x0,0x129b1(%rip)        # 1527c <fwp_gc+0xfec>
    28cb:	75 05                	jne    28d2 <fwp_gc_start+0x12>
    28cd:	e8 fe 0a 00 00       	call   33d0 <fwp_gc_init>
    28d2:	48 89 1d 3f 2a 01 00 	mov    %rbx,0x12a3f(%rip)        # 15318 <fwp_gc+0x1088>
    28d9:	48 8d 3d 70 a1 00 00 	lea    0xa170(%rip),%rdi        # ca50 <fwp_gc_find_data>
    28e0:	31 f6                	xor    %esi,%esi
    28e2:	e8 59 f7 ff ff       	call   2040 <dl_iterate_phdr@plt>
    28e7:	83 3d 92 29 01 00 00 	cmpl   $0x0,0x12992(%rip)        # 15280 <fwp_gc+0xff0>
    28ee:	0f 95 c1             	setne  %cl
    28f1:	83 3d 28 2b 01 00 00 	cmpl   $0x0,0x12b28(%rip)        # 15420 <fwp_gc+0x1190>
    28f8:	0f 9f c0             	setg   %al
    28fb:	20 c8                	and    %cl,%al
    28fd:	0f b6 c8             	movzbl %al,%ecx
    2900:	89 0d 7e 29 01 00    	mov    %ecx,0x1297e(%rip)        # 15284 <fwp_gc+0xff4>
    2906:	83 3d 7f 29 01 00 00 	cmpl   $0x0,0x1297f(%rip)        # 1528c <fwp_gc+0xffc>
    290d:	74 16                	je     2925 <fwp_gc_start+0x65>
    290f:	48 8d 3d 1a a2 00 00 	lea    0xa21a(%rip),%rdi        # cb30 <fwp_gc_report>
    2916:	e8 85 a7 00 00       	call   d0a0 <atexit>
    291b:	83 3d 62 29 01 00 00 	cmpl   $0x0,0x12962(%rip)        # 15284 <fwp_gc+0xff4>
    2922:	0f 95 c0             	setne  %al
    2925:	84 c0                	test   %al,%al
    2927:	74 43                	je     296c <fwp_gc_start+0xac>
    2929:	48 83 3d 7f 29 01 00 	cmpq   $0x0,0x1297f(%rip)        # 152b0 <fwp_gc+0x1020>
    2930:	00 
    2931:	74 39                	je     296c <fwp_gc_start+0xac>
    2933:	48 8b 05 66 2b 01 00 	mov    0x12b66(%rip),%rax        # 154a0 <fwp_gc+0x1210>
    293a:	48 2b 05 4f 19 01 00 	sub    0x1194f(%rip),%rax        # 14290 <fwp_gc>
    2941:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    2946:	f2 0f 58 05 2a 2b 01 	addsd  0x12b2a(%rip),%xmm0        # 15478 <fwp_gc+0x11e8>
    294d:	00 
    294e:	f2 0f 11 05 22 2b 01 	movsd  %xmm0,0x12b22(%rip)        # 15478 <fwp_gc+0x11e8>
    2955:	00 
    2956:	48 c7 05 3f 2b 01 00 	movq   $0x0,0x12b3f(%rip)        # 154a0 <fwp_gc+0x1210>
    295d:	00 00 00 00 
    2961:	48 c7 05 24 19 01 00 	movq   $0x0,0x11924(%rip)        # 14290 <fwp_gc>
    2968:	00 00 00 00 
    296c:	5b                   	pop    %rbx
    296d:	c3                   	ret
    296e:	66 90                	xchg   %ax,%ax

0000000000002970 <f3>:
    2970:	53                   	push   %rbx
    2971:	48 83 ec 30          	sub    $0x30,%rsp
    2975:	e8 96 06 00 00       	call   3010 <fwp_f64>
    297a:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    297f:	e8 ec a3 00 00       	call   cd70 <w3>
    2984:	f2 0f 10 44 24 18    	movsd  0x18(%rsp),%xmm0
    298a:	e8 51 00 00 00       	call   29e0 <fwp_from_f64>
    298f:	48 89 04 24          	mov    %rax,(%rsp)
    2993:	f2 0f 10 44 24 20    	movsd  0x20(%rsp),%xmm0
    2999:	e8 42 00 00 00       	call   29e0 <fwp_from_f64>
    299e:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    29a3:	f2 0f 10 44 24 28    	movsd  0x28(%rsp),%xmm0
    29a9:	e8 32 00 00 00       	call   29e0 <fwp_from_f64>
    29ae:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    29b3:	48 89 e6             	mov    %rsp,%rsi
    29b6:	bf 03 00 00 00       	mov    $0x3,%edi
    29bb:	e8 a0 06 00 00       	call   3060 <fwp_record>
    29c0:	48 89 c3             	mov    %rax,%rbx
    29c3:	48 89 c7             	mov    %rax,%rdi
    29c6:	e8 55 06 00 00       	call   3020 <fwp_rc_fresh>
    29cb:	48 89 d8             	mov    %rbx,%rax
    29ce:	48 83 c4 30          	add    $0x30,%rsp
    29d2:	5b                   	pop    %rbx
    29d3:	c3                   	ret
    29d4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    29db:	00 00 00 00 00 

00000000000029e0 <fwp_from_f64>:
    29e0:	66 48 0f 7e c0       	movq   %xmm0,%rax
    29e5:	c3                   	ret
    29e6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    29ed:	00 00 00 

00000000000029f0 <fwp_rc_release_last>:
    29f0:	50                   	push   %rax
    29f1:	e8 4a 04 00 00       	call   2e40 <fwp_rc_slot>
    29f6:	48 89 c7             	mov    %rax,%rdi
    29f9:	31 c0                	xor    %eax,%eax
    29fb:	48 85 ff             	test   %rdi,%rdi
    29fe:	74 1a                	je     2a1a <fwp_rc_release_last+0x2a>
    2a00:	0f b6 07             	movzbl (%rdi),%eax
    2a03:	85 c0                	test   %eax,%eax
    2a05:	74 13                	je     2a1a <fwp_rc_release_last+0x2a>
    2a07:	83 f8 01             	cmp    $0x1,%eax
    2a0a:	75 07                	jne    2a13 <fwp_rc_release_last+0x23>
    2a0c:	b8 01 00 00 00       	mov    $0x1,%eax
    2a11:	59                   	pop    %rcx
    2a12:	c3                   	ret
    2a13:	e8 c8 a3 00 00       	call   cde0 <fwp_rc_drop_slot>
    2a18:	31 c0                	xor    %eax,%eax
    2a1a:	59                   	pop    %rcx
    2a1b:	c3                   	ret
    2a1c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000002a20 <fwp_rc_free_obj>:
    2a20:	41 56                	push   %r14
    2a22:	53                   	push   %rbx
    2a23:	50                   	push   %rax
    2a24:	48 89 fb             	mov    %rdi,%rbx
    2a27:	e8 c4 2d 00 00       	call   57f0 <fwp_rc_last>
    2a2c:	85 c0                	test   %eax,%eax
    2a2e:	0f 84 83 00 00 00    	je     2ab7 <fwp_rc_free_obj+0x97>
    2a34:	8b 0d 76 32 01 00    	mov    0x13276(%rip),%ecx        # 15cb0 <fwp_reuse_verify>
    2a3a:	85 c9                	test   %ecx,%ecx
    2a3c:	78 13                	js     2a51 <fwp_rc_free_obj+0x31>
    2a3e:	85 c9                	test   %ecx,%ecx
    2a40:	74 47                	je     2a89 <fwp_rc_free_obj+0x69>
    2a42:	48 89 df             	mov    %rbx,%rdi
    2a45:	48 83 c4 08          	add    $0x8,%rsp
    2a49:	5b                   	pop    %rbx
    2a4a:	41 5e                	pop    %r14
    2a4c:	e9 df a3 00 00       	jmp    ce30 <fwp_rc_poison>
    2a51:	48 8d 3d 0e be 00 00 	lea    0xbe0e(%rip),%rdi        # e866 <exec_in_fp0+0x206>
    2a58:	e8 d3 f5 ff ff       	call   2030 <getenv@plt>
    2a5d:	31 c9                	xor    %ecx,%ecx
    2a5f:	48 85 c0             	test   %rax,%rax
    2a62:	74 1b                	je     2a7f <fwp_rc_free_obj+0x5f>
    2a64:	80 38 00             	cmpb   $0x0,(%rax)
    2a67:	74 16                	je     2a7f <fwp_rc_free_obj+0x5f>
    2a69:	48 8d 35 28 c9 00 00 	lea    0xc928(%rip),%rsi        # f398 <exec_in_fp0+0xd38>
    2a70:	48 89 c7             	mov    %rax,%rdi
    2a73:	e8 48 f8 ff ff       	call   22c0 <strcmp@plt>
    2a78:	31 c9                	xor    %ecx,%ecx
    2a7a:	85 c0                	test   %eax,%eax
    2a7c:	0f 95 c1             	setne  %cl
    2a7f:	89 0d 2b 32 01 00    	mov    %ecx,0x1322b(%rip)        # 15cb0 <fwp_reuse_verify>
    2a85:	85 c9                	test   %ecx,%ecx
    2a87:	75 b9                	jne    2a42 <fwp_rc_free_obj+0x22>
    2a89:	4c 8b 35 00 18 01 00 	mov    0x11800(%rip),%r14        # 14290 <fwp_gc>
    2a90:	48 89 df             	mov    %rbx,%rdi
    2a93:	e8 78 2d 00 00       	call   5810 <fwp_mem_free>
    2a98:	48 8b 05 f1 17 01 00 	mov    0x117f1(%rip),%rax        # 14290 <fwp_gc>
    2a9f:	4c 29 f0             	sub    %r14,%rax
    2aa2:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    2aa7:	f2 0f 58 05 e9 29 01 	addsd  0x129e9(%rip),%xmm0        # 15498 <fwp_gc+0x1208>
    2aae:	00 
    2aaf:	f2 0f 11 05 e1 29 01 	movsd  %xmm0,0x129e1(%rip)        # 15498 <fwp_gc+0x1208>
    2ab6:	00 
    2ab7:	48 83 c4 08          	add    $0x8,%rsp
    2abb:	5b                   	pop    %rbx
    2abc:	41 5e                	pop    %r14
    2abe:	c3                   	ret
    2abf:	90                   	nop

0000000000002ac0 <e0>:
    2ac0:	50                   	push   %rax
    2ac1:	48 8b 3f             	mov    (%rdi),%rdi
    2ac4:	e8 e7 01 00 00       	call   2cb0 <f0>
    2ac9:	48 89 c7             	mov    %rax,%rdi
    2acc:	58                   	pop    %rax
    2acd:	e9 ce 01 00 00       	jmp    2ca0 <fwp_rc_shared>
    2ad2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2ad9:	1f 84 00 00 00 00 00 

0000000000002ae0 <e1>:
    2ae0:	50                   	push   %rax
    2ae1:	48 8b 3f             	mov    (%rdi),%rdi
    2ae4:	e8 27 24 00 00       	call   4f10 <f1>
    2ae9:	48 89 c7             	mov    %rax,%rdi
    2aec:	58                   	pop    %rax
    2aed:	e9 ae 01 00 00       	jmp    2ca0 <fwp_rc_shared>
    2af2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2af9:	1f 84 00 00 00 00 00 

0000000000002b00 <e2>:
    2b00:	50                   	push   %rax
    2b01:	48 8b 3f             	mov    (%rdi),%rdi
    2b04:	e8 b7 24 00 00       	call   4fc0 <f2>
    2b09:	48 89 c7             	mov    %rax,%rdi
    2b0c:	58                   	pop    %rax
    2b0d:	e9 8e 01 00 00       	jmp    2ca0 <fwp_rc_shared>
    2b12:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2b19:	1f 84 00 00 00 00 00 

0000000000002b20 <e3>:
    2b20:	50                   	push   %rax
    2b21:	48 8b 3f             	mov    (%rdi),%rdi
    2b24:	e8 47 fe ff ff       	call   2970 <f3>
    2b29:	48 89 c7             	mov    %rax,%rdi
    2b2c:	58                   	pop    %rax
    2b2d:	e9 6e 01 00 00       	jmp    2ca0 <fwp_rc_shared>
    2b32:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2b39:	1f 84 00 00 00 00 00 

0000000000002b40 <e4>:
    2b40:	50                   	push   %rax
    2b41:	48 8b 3f             	mov    (%rdi),%rdi
    2b44:	e8 87 2f 00 00       	call   5ad0 <f4>
    2b49:	48 89 c7             	mov    %rax,%rdi
    2b4c:	58                   	pop    %rax
    2b4d:	e9 4e 01 00 00       	jmp    2ca0 <fwp_rc_shared>
    2b52:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2b59:	1f 84 00 00 00 00 00 

0000000000002b60 <e6>:
    2b60:	50                   	push   %rax
    2b61:	48 8b 07             	mov    (%rdi),%rax
    2b64:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2b68:	48 89 c7             	mov    %rax,%rdi
    2b6b:	e8 b0 2f 00 00       	call   5b20 <f6>
    2b70:	48 89 c7             	mov    %rax,%rdi
    2b73:	58                   	pop    %rax
    2b74:	e9 27 01 00 00       	jmp    2ca0 <fwp_rc_shared>
    2b79:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002b80 <e10>:
    2b80:	50                   	push   %rax
    2b81:	48 8b 3f             	mov    (%rdi),%rdi
    2b84:	e8 c7 2f 00 00       	call   5b50 <f10>
    2b89:	48 89 c7             	mov    %rax,%rdi
    2b8c:	58                   	pop    %rax
    2b8d:	e9 0e 01 00 00       	jmp    2ca0 <fwp_rc_shared>
    2b92:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2b99:	1f 84 00 00 00 00 00 

0000000000002ba0 <e12>:
    2ba0:	50                   	push   %rax
    2ba1:	48 8b 07             	mov    (%rdi),%rax
    2ba4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2ba8:	48 89 c7             	mov    %rax,%rdi
    2bab:	e8 b0 28 00 00       	call   5460 <f12>
    2bb0:	48 89 c7             	mov    %rax,%rdi
    2bb3:	58                   	pop    %rax
    2bb4:	e9 e7 00 00 00       	jmp    2ca0 <fwp_rc_shared>
    2bb9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002bc0 <e14>:
    2bc0:	50                   	push   %rax
    2bc1:	48 8b 07             	mov    (%rdi),%rax
    2bc4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2bc8:	48 89 c7             	mov    %rax,%rdi
    2bcb:	e8 b0 28 00 00       	call   5480 <f14>
    2bd0:	48 89 c7             	mov    %rax,%rdi
    2bd3:	58                   	pop    %rax
    2bd4:	e9 c7 00 00 00       	jmp    2ca0 <fwp_rc_shared>
    2bd9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002be0 <e16>:
    2be0:	50                   	push   %rax
    2be1:	48 8b 07             	mov    (%rdi),%rax
    2be4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2be8:	48 89 c7             	mov    %rax,%rdi
    2beb:	e8 c0 28 00 00       	call   54b0 <f16>
    2bf0:	48 89 c7             	mov    %rax,%rdi
    2bf3:	58                   	pop    %rax
    2bf4:	e9 a7 00 00 00       	jmp    2ca0 <fwp_rc_shared>
    2bf9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002c00 <e18>:
    2c00:	50                   	push   %rax
    2c01:	48 8b 07             	mov    (%rdi),%rax
    2c04:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2c08:	48 89 c7             	mov    %rax,%rdi
    2c0b:	e8 d0 28 00 00       	call   54e0 <f18>
    2c10:	48 89 c7             	mov    %rax,%rdi
    2c13:	58                   	pop    %rax
    2c14:	e9 87 00 00 00       	jmp    2ca0 <fwp_rc_shared>
    2c19:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002c20 <e20>:
    2c20:	50                   	push   %rax
    2c21:	48 8b 07             	mov    (%rdi),%rax
    2c24:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2c28:	48 89 c7             	mov    %rax,%rdi
    2c2b:	e8 f0 28 00 00       	call   5520 <f20>
    2c30:	48 89 c7             	mov    %rax,%rdi
    2c33:	58                   	pop    %rax
    2c34:	eb 6a                	jmp    2ca0 <fwp_rc_shared>
    2c36:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2c3d:	00 00 00 

0000000000002c40 <e22>:
    2c40:	50                   	push   %rax
    2c41:	48 8b 07             	mov    (%rdi),%rax
    2c44:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2c48:	48 89 c7             	mov    %rax,%rdi
    2c4b:	e8 20 29 00 00       	call   5570 <f22>
    2c50:	48 89 c7             	mov    %rax,%rdi
    2c53:	58                   	pop    %rax
    2c54:	eb 4a                	jmp    2ca0 <fwp_rc_shared>
    2c56:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2c5d:	00 00 00 

0000000000002c60 <e24>:
    2c60:	50                   	push   %rax
    2c61:	48 8b 07             	mov    (%rdi),%rax
    2c64:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2c68:	48 89 c7             	mov    %rax,%rdi
    2c6b:	e8 50 29 00 00       	call   55c0 <f24>
    2c70:	48 89 c7             	mov    %rax,%rdi
    2c73:	58                   	pop    %rax
    2c74:	eb 2a                	jmp    2ca0 <fwp_rc_shared>
    2c76:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2c7d:	00 00 00 

0000000000002c80 <e26>:
    2c80:	50                   	push   %rax
    2c81:	48 8b 07             	mov    (%rdi),%rax
    2c84:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2c88:	48 89 c7             	mov    %rax,%rdi
    2c8b:	e8 90 29 00 00       	call   5620 <f26>
    2c90:	48 89 c7             	mov    %rax,%rdi
    2c93:	58                   	pop    %rax
    2c94:	eb 0a                	jmp    2ca0 <fwp_rc_shared>
    2c96:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2c9d:	00 00 00 

0000000000002ca0 <fwp_rc_shared>:
    2ca0:	53                   	push   %rbx
    2ca1:	48 89 fb             	mov    %rdi,%rbx
    2ca4:	e8 77 00 00 00       	call   2d20 <fwp_rc_share>
    2ca9:	48 89 d8             	mov    %rbx,%rax
    2cac:	5b                   	pop    %rbx
    2cad:	c3                   	ret
    2cae:	66 90                	xchg   %ax,%ax

0000000000002cb0 <f0>:
    2cb0:	53                   	push   %rbx
    2cb1:	48 83 ec 30          	sub    $0x30,%rsp
    2cb5:	e8 56 03 00 00       	call   3010 <fwp_f64>
    2cba:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    2cbf:	e8 1c 03 00 00       	call   2fe0 <w0>
    2cc4:	f2 0f 10 44 24 18    	movsd  0x18(%rsp),%xmm0
    2cca:	e8 11 fd ff ff       	call   29e0 <fwp_from_f64>
    2ccf:	48 89 04 24          	mov    %rax,(%rsp)
    2cd3:	f2 0f 10 44 24 20    	movsd  0x20(%rsp),%xmm0
    2cd9:	e8 02 fd ff ff       	call   29e0 <fwp_from_f64>
    2cde:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    2ce3:	f2 0f 10 44 24 28    	movsd  0x28(%rsp),%xmm0
    2ce9:	e8 f2 fc ff ff       	call   29e0 <fwp_from_f64>
    2cee:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    2cf3:	48 89 e6             	mov    %rsp,%rsi
    2cf6:	bf 03 00 00 00       	mov    $0x3,%edi
    2cfb:	e8 60 03 00 00       	call   3060 <fwp_record>
    2d00:	48 89 c3             	mov    %rax,%rbx
    2d03:	48 89 c7             	mov    %rax,%rdi
    2d06:	e8 15 03 00 00       	call   3020 <fwp_rc_fresh>
    2d0b:	48 89 d8             	mov    %rbx,%rax
    2d0e:	48 83 c4 30          	add    $0x30,%rsp
    2d12:	5b                   	pop    %rbx
    2d13:	c3                   	ret
    2d14:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    2d1b:	00 00 00 00 00 

0000000000002d20 <fwp_rc_share>:
    2d20:	41 57                	push   %r15
    2d22:	41 56                	push   %r14
    2d24:	41 55                	push   %r13
    2d26:	41 54                	push   %r12
    2d28:	53                   	push   %rbx
    2d29:	48 81 ec 00 02 00 00 	sub    $0x200,%rsp
    2d30:	48 89 fb             	mov    %rdi,%rbx
    2d33:	e8 08 01 00 00       	call   2e40 <fwp_rc_slot>
    2d38:	48 85 c0             	test   %rax,%rax
    2d3b:	0f 84 ec 00 00 00    	je     2e2d <fwp_rc_share+0x10d>
    2d41:	80 38 00             	cmpb   $0x0,(%rax)
    2d44:	0f 84 e3 00 00 00    	je     2e2d <fwp_rc_share+0x10d>
    2d4a:	48 89 c7             	mov    %rax,%rdi
    2d4d:	e8 5e 01 00 00       	call   2eb0 <fwp_rc_clear_slot>
    2d52:	48 89 1c 24          	mov    %rbx,(%rsp)
    2d56:	41 be 01 00 00 00    	mov    $0x1,%r14d
    2d5c:	eb 0b                	jmp    2d69 <fwp_rc_share+0x49>
    2d5e:	66 90                	xchg   %ax,%ax
    2d60:	4d 85 f6             	test   %r14,%r14
    2d63:	0f 84 c4 00 00 00    	je     2e2d <fwp_rc_share+0x10d>
    2d69:	4e 8b 7c f4 f8       	mov    -0x8(%rsp,%r14,8),%r15
    2d6e:	49 ff ce             	dec    %r14
    2d71:	4c 89 ff             	mov    %r15,%rdi
    2d74:	48 2b 3d 45 25 01 00 	sub    0x12545(%rip),%rdi        # 152c0 <fwp_gc+0x1030>
    2d7b:	48 c1 ef 10          	shr    $0x10,%rdi
    2d7f:	48 8b 05 82 25 01 00 	mov    0x12582(%rip),%rax        # 15308 <fwp_gc+0x1078>
    2d86:	48 69 cf 28 12 00 00 	imul   $0x1228,%rdi,%rcx
    2d8d:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    2d92:	74 cc                	je     2d60 <fwp_rc_share+0x40>
    2d94:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    2d98:	80 fa 02             	cmp    $0x2,%dl
    2d9b:	75 13                	jne    2db0 <fwp_rc_share+0x90>
    2d9d:	4c 8b 64 08 18       	mov    0x18(%rax,%rcx,1),%r12
    2da2:	eb 33                	jmp    2dd7 <fwp_rc_share+0xb7>
    2da4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    2dab:	00 00 00 00 00 
    2db0:	44 8b 64 08 08       	mov    0x8(%rax,%rcx,1),%r12d
    2db5:	80 fa 01             	cmp    $0x1,%dl
    2db8:	75 1d                	jne    2dd7 <fwp_rc_share+0xb7>
    2dba:	41 0f b7 d7          	movzwl %r15w,%edx
    2dbe:	44 8b 7c 08 20       	mov    0x20(%rax,%rcx,1),%r15d
    2dc3:	4c 0f af fa          	imul   %rdx,%r15
    2dc7:	49 c1 ef 20          	shr    $0x20,%r15
    2dcb:	e8 00 01 00 00       	call   2ed0 <fwp_gc_chunk_addr>
    2dd0:	4d 0f af fc          	imul   %r12,%r15
    2dd4:	49 01 c7             	add    %rax,%r15
    2dd7:	49 83 fc 08          	cmp    $0x8,%r12
    2ddb:	72 83                	jb     2d60 <fwp_rc_share+0x40>
    2ddd:	49 c1 ec 03          	shr    $0x3,%r12
    2de1:	45 31 ed             	xor    %r13d,%r13d
    2de4:	eb 16                	jmp    2dfc <fwp_rc_share+0xdc>
    2de6:	48 89 df             	mov    %rbx,%rdi
    2de9:	e8 32 ff ff ff       	call   2d20 <fwp_rc_share>
    2dee:	66 90                	xchg   %ax,%ax
    2df0:	49 ff c5             	inc    %r13
    2df3:	4d 39 ec             	cmp    %r13,%r12
    2df6:	0f 84 64 ff ff ff    	je     2d60 <fwp_rc_share+0x40>
    2dfc:	4b 8b 1c ef          	mov    (%r15,%r13,8),%rbx
    2e00:	48 89 df             	mov    %rbx,%rdi
    2e03:	e8 38 00 00 00       	call   2e40 <fwp_rc_slot>
    2e08:	48 85 c0             	test   %rax,%rax
    2e0b:	74 e3                	je     2df0 <fwp_rc_share+0xd0>
    2e0d:	80 38 00             	cmpb   $0x0,(%rax)
    2e10:	74 de                	je     2df0 <fwp_rc_share+0xd0>
    2e12:	49 83 fe 3f          	cmp    $0x3f,%r14
    2e16:	77 ce                	ja     2de6 <fwp_rc_share+0xc6>
    2e18:	48 89 c7             	mov    %rax,%rdi
    2e1b:	e8 90 00 00 00       	call   2eb0 <fwp_rc_clear_slot>
    2e20:	4b 8b 04 ef          	mov    (%r15,%r13,8),%rax
    2e24:	4a 89 04 f4          	mov    %rax,(%rsp,%r14,8)
    2e28:	49 ff c6             	inc    %r14
    2e2b:	eb c3                	jmp    2df0 <fwp_rc_share+0xd0>
    2e2d:	48 81 c4 00 02 00 00 	add    $0x200,%rsp
    2e34:	5b                   	pop    %rbx
    2e35:	41 5c                	pop    %r12
    2e37:	41 5d                	pop    %r13
    2e39:	41 5e                	pop    %r14
    2e3b:	41 5f                	pop    %r15
    2e3d:	c3                   	ret
    2e3e:	66 90                	xchg   %ax,%ax

0000000000002e40 <fwp_rc_slot>:
    2e40:	48 2b 3d 79 24 01 00 	sub    0x12479(%rip),%rdi        # 152c0 <fwp_gc+0x1030>
    2e47:	48 8b 05 9a 24 01 00 	mov    0x1249a(%rip),%rax        # 152e8 <fwp_gc+0x1058>
    2e4e:	48 c1 e0 10          	shl    $0x10,%rax
    2e52:	48 39 c7             	cmp    %rax,%rdi
    2e55:	73 51                	jae    2ea8 <fwp_rc_slot+0x68>
    2e57:	48 8b 05 aa 24 01 00 	mov    0x124aa(%rip),%rax        # 15308 <fwp_gc+0x1078>
    2e5e:	48 89 f9             	mov    %rdi,%rcx
    2e61:	48 c1 e9 10          	shr    $0x10,%rcx
    2e65:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    2e6c:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    2e70:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    2e77:	75 0f                	jne    2e88 <fwp_rc_slot+0x48>
    2e79:	80 fa 02             	cmp    $0x2,%dl
    2e7c:	75 0a                	jne    2e88 <fwp_rc_slot+0x48>
    2e7e:	48 01 c8             	add    %rcx,%rax
    2e81:	48 05 28 02 00 00    	add    $0x228,%rax
    2e87:	c3                   	ret
    2e88:	80 fa 01             	cmp    $0x1,%dl
    2e8b:	75 1b                	jne    2ea8 <fwp_rc_slot+0x68>
    2e8d:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    2e91:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    2e95:	48 0f af f8          	imul   %rax,%rdi
    2e99:	48 c1 ef 20          	shr    $0x20,%rdi
    2e9d:	48 8d 04 17          	lea    (%rdi,%rdx,1),%rax
    2ea1:	48 05 28 02 00 00    	add    $0x228,%rax
    2ea7:	c3                   	ret
    2ea8:	31 c0                	xor    %eax,%eax
    2eaa:	c3                   	ret
    2eab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000002eb0 <fwp_rc_clear_slot>:
    2eb0:	80 3f ff             	cmpb   $0xff,(%rdi)
    2eb3:	74 04                	je     2eb9 <fwp_rc_clear_slot+0x9>
    2eb5:	c6 07 00             	movb   $0x0,(%rdi)
    2eb8:	c3                   	ret
    2eb9:	53                   	push   %rbx
    2eba:	48 89 fb             	mov    %rdi,%rbx
    2ebd:	e8 1e 00 00 00       	call   2ee0 <fwp_rc_forget_slot>
    2ec2:	48 89 df             	mov    %rbx,%rdi
    2ec5:	5b                   	pop    %rbx
    2ec6:	c6 07 00             	movb   $0x0,(%rdi)
    2ec9:	c3                   	ret
    2eca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000002ed0 <fwp_gc_chunk_addr>:
    2ed0:	48 89 f8             	mov    %rdi,%rax
    2ed3:	48 c1 e0 10          	shl    $0x10,%rax
    2ed7:	48 03 05 e2 23 01 00 	add    0x123e2(%rip),%rax        # 152c0 <fwp_gc+0x1030>
    2ede:	c3                   	ret
    2edf:	90                   	nop

0000000000002ee0 <fwp_rc_forget_slot>:
    2ee0:	50                   	push   %rax
    2ee1:	80 3f ff             	cmpb   $0xff,(%rdi)
    2ee4:	74 02                	je     2ee8 <fwp_rc_forget_slot+0x8>
    2ee6:	58                   	pop    %rax
    2ee7:	c3                   	ret
    2ee8:	e8 33 00 00 00       	call   2f20 <fwp_rc_wide_link>
    2eed:	48 8b 38             	mov    (%rax),%rdi
    2ef0:	48 85 ff             	test   %rdi,%rdi
    2ef3:	74 15                	je     2f0a <fwp_rc_forget_slot+0x2a>
    2ef5:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    2ef9:	48 89 08             	mov    %rcx,(%rax)
    2efc:	e8 4f f1 ff ff       	call   2050 <free@plt>
    2f01:	48 ff 0d a0 2d 01 00 	decq   0x12da0(%rip)        # 15ca8 <fwp_gc+0x1a18>
    2f08:	58                   	pop    %rax
    2f09:	c3                   	ret
    2f0a:	48 8d 3d 10 b8 00 00 	lea    0xb810(%rip),%rdi        # e721 <exec_in_fp0+0xc1>
    2f11:	e8 6a 00 00 00       	call   2f80 <fwp_trap>
    2f16:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2f1d:	00 00 00 

0000000000002f20 <fwp_rc_wide_link>:
    2f20:	48 89 f8             	mov    %rdi,%rax
    2f23:	48 c1 e8 11          	shr    $0x11,%rax
    2f27:	31 f8                	xor    %edi,%eax
    2f29:	89 c1                	mov    %eax,%ecx
    2f2b:	c1 e9 09             	shr    $0x9,%ecx
    2f2e:	31 c1                	xor    %eax,%ecx
    2f30:	0f b6 c9             	movzbl %cl,%ecx
    2f33:	48 8d 15 56 13 01 00 	lea    0x11356(%rip),%rdx        # 14290 <fwp_gc>
    2f3a:	48 8d 04 ca          	lea    (%rdx,%rcx,8),%rax
    2f3e:	48 05 18 12 00 00    	add    $0x1218,%rax
    2f44:	48 8b 8c ca 18 12 00 	mov    0x1218(%rdx,%rcx,8),%rcx
    2f4b:	00 
    2f4c:	48 85 c9             	test   %rcx,%rcx
    2f4f:	74 24                	je     2f75 <fwp_rc_wide_link+0x55>
    2f51:	48 39 39             	cmp    %rdi,(%rcx)
    2f54:	74 1f                	je     2f75 <fwp_rc_wide_link+0x55>
    2f56:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2f5d:	00 00 00 
    2f60:	48 89 c8             	mov    %rcx,%rax
    2f63:	48 8b 49 10          	mov    0x10(%rcx),%rcx
    2f67:	48 85 c9             	test   %rcx,%rcx
    2f6a:	74 05                	je     2f71 <fwp_rc_wide_link+0x51>
    2f6c:	48 39 39             	cmp    %rdi,(%rcx)
    2f6f:	75 ef                	jne    2f60 <fwp_rc_wide_link+0x40>
    2f71:	48 83 c0 10          	add    $0x10,%rax
    2f75:	c3                   	ret
    2f76:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2f7d:	00 00 00 

0000000000002f80 <fwp_trap>:
    2f80:	53                   	push   %rbx
    2f81:	48 89 fb             	mov    %rdi,%rbx
    2f84:	e8 27 00 00 00       	call   2fb0 <fwp_flush>
    2f89:	48 8b 05 50 10 01 00 	mov    0x11050(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    2f90:	48 8b 38             	mov    (%rax),%rdi
    2f93:	48 8d 35 ae b7 00 00 	lea    0xb7ae(%rip),%rsi        # e748 <exec_in_fp0+0xe8>
    2f9a:	48 89 da             	mov    %rbx,%rdx
    2f9d:	31 c0                	xor    %eax,%eax
    2f9f:	e8 3c f3 ff ff       	call   22e0 <fprintf@plt>
    2fa4:	bf 65 00 00 00       	mov    $0x65,%edi
    2fa9:	e8 c2 f4 ff ff       	call   2470 <exit@plt>
    2fae:	66 90                	xchg   %ax,%ax

0000000000002fb0 <fwp_flush>:
    2fb0:	50                   	push   %rax
    2fb1:	48 8b 3d f0 2d 01 00 	mov    0x12df0(%rip),%rdi        # 15da8 <fwp_prog_out>
    2fb8:	48 85 ff             	test   %rdi,%rdi
    2fbb:	74 05                	je     2fc2 <fwp_flush+0x12>
    2fbd:	e8 7e f3 ff ff       	call   2340 <fflush@plt>
    2fc2:	48 8b 05 ef 0f 01 00 	mov    0x10fef(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    2fc9:	48 8b 38             	mov    (%rax),%rdi
    2fcc:	58                   	pop    %rax
    2fcd:	e9 6e f3 ff ff       	jmp    2340 <fflush@plt>
    2fd2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2fd9:	1f 84 00 00 00 00 00 

0000000000002fe0 <w0>:
    2fe0:	53                   	push   %rbx
    2fe1:	48 89 fb             	mov    %rdi,%rbx
    2fe4:	e8 f7 f9 ff ff       	call   29e0 <fwp_from_f64>
    2fe9:	48 89 c7             	mov    %rax,%rdi
    2fec:	e8 1f 00 00 00       	call   3010 <fwp_f64>
    2ff1:	f2 0f 11 03          	movsd  %xmm0,(%rbx)
    2ff5:	f2 0f 11 43 08       	movsd  %xmm0,0x8(%rbx)
    2ffa:	f2 0f 11 43 10       	movsd  %xmm0,0x10(%rbx)
    2fff:	48 89 d8             	mov    %rbx,%rax
    3002:	5b                   	pop    %rbx
    3003:	c3                   	ret
    3004:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    300b:	00 00 00 00 00 

0000000000003010 <fwp_f64>:
    3010:	66 48 0f 6e c7       	movq   %rdi,%xmm0
    3015:	c3                   	ret
    3016:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    301d:	00 00 00 

0000000000003020 <fwp_rc_fresh>:
    3020:	41 56                	push   %r14
    3022:	53                   	push   %rbx
    3023:	50                   	push   %rax
    3024:	48 89 fb             	mov    %rdi,%rbx
    3027:	e8 14 fe ff ff       	call   2e40 <fwp_rc_slot>
    302c:	48 85 c0             	test   %rax,%rax
    302f:	74 08                	je     3039 <fwp_rc_fresh+0x19>
    3031:	80 38 ff             	cmpb   $0xff,(%rax)
    3034:	74 0e                	je     3044 <fwp_rc_fresh+0x24>
    3036:	c6 00 01             	movb   $0x1,(%rax)
    3039:	48 89 d8             	mov    %rbx,%rax
    303c:	48 83 c4 08          	add    $0x8,%rsp
    3040:	5b                   	pop    %rbx
    3041:	41 5e                	pop    %r14
    3043:	c3                   	ret
    3044:	48 89 c7             	mov    %rax,%rdi
    3047:	49 89 c6             	mov    %rax,%r14
    304a:	e8 91 fe ff ff       	call   2ee0 <fwp_rc_forget_slot>
    304f:	4c 89 f0             	mov    %r14,%rax
    3052:	eb e2                	jmp    3036 <fwp_rc_fresh+0x16>
    3054:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    305b:	00 00 00 00 00 

0000000000003060 <fwp_record>:
    3060:	85 ff                	test   %edi,%edi
    3062:	74 09                	je     306d <fwp_record+0xd>
    3064:	48 89 f2             	mov    %rsi,%rdx
    3067:	89 fe                	mov    %edi,%esi
    3069:	31 ff                	xor    %edi,%edi
    306b:	eb 03                	jmp    3070 <fwp_data>
    306d:	31 c0                	xor    %eax,%eax
    306f:	c3                   	ret

0000000000003070 <fwp_data>:
    3070:	55                   	push   %rbp
    3071:	41 57                	push   %r15
    3073:	41 56                	push   %r14
    3075:	53                   	push   %rbx
    3076:	50                   	push   %rax
    3077:	89 fd                	mov    %edi,%ebp
    3079:	85 f6                	test   %esi,%esi
    307b:	0f 84 a1 00 00 00    	je     3122 <fwp_data+0xb2>
    3081:	48 89 d3             	mov    %rdx,%rbx
    3084:	41 89 f6             	mov    %esi,%r14d
    3087:	4a 8d 3c f5 08 00 00 	lea    0x8(,%r14,8),%rdi
    308e:	00 
    308f:	41 89 f7             	mov    %esi,%r15d
    3092:	e8 d9 00 00 00       	call   3170 <fwp_alloc_init>
    3097:	89 28                	mov    %ebp,(%rax)
    3099:	44 89 78 04          	mov    %r15d,0x4(%rax)
    309d:	41 83 ff 08          	cmp    $0x8,%r15d
    30a1:	72 10                	jb     30b3 <fwp_data+0x43>
    30a3:	48 89 c1             	mov    %rax,%rcx
    30a6:	48 29 d9             	sub    %rbx,%rcx
    30a9:	48 83 c1 08          	add    $0x8,%rcx
    30ad:	48 83 f9 20          	cmp    $0x20,%rcx
    30b1:	73 73                	jae    3126 <fwp_data+0xb6>
    30b3:	31 c9                	xor    %ecx,%ecx
    30b5:	4c 89 f6             	mov    %r14,%rsi
    30b8:	48 89 ca             	mov    %rcx,%rdx
    30bb:	48 83 e6 03          	and    $0x3,%rsi
    30bf:	74 20                	je     30e1 <fwp_data+0x71>
    30c1:	48 89 ca             	mov    %rcx,%rdx
    30c4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    30cb:	00 00 00 00 00 
    30d0:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    30d4:	48 89 7c d0 08       	mov    %rdi,0x8(%rax,%rdx,8)
    30d9:	48 ff c2             	inc    %rdx
    30dc:	48 ff ce             	dec    %rsi
    30df:	75 ef                	jne    30d0 <fwp_data+0x60>
    30e1:	4c 29 f1             	sub    %r14,%rcx
    30e4:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    30e8:	77 7b                	ja     3165 <fwp_data+0xf5>
    30ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    30f0:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    30f4:	48 89 4c d0 08       	mov    %rcx,0x8(%rax,%rdx,8)
    30f9:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    30fe:	48 89 4c d0 10       	mov    %rcx,0x10(%rax,%rdx,8)
    3103:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    3108:	48 89 4c d0 18       	mov    %rcx,0x18(%rax,%rdx,8)
    310d:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    3112:	48 89 4c d0 20       	mov    %rcx,0x20(%rax,%rdx,8)
    3117:	48 83 c2 04          	add    $0x4,%rdx
    311b:	49 39 d6             	cmp    %rdx,%r14
    311e:	75 d0                	jne    30f0 <fwp_data+0x80>
    3120:	eb 43                	jmp    3165 <fwp_data+0xf5>
    3122:	89 e8                	mov    %ebp,%eax
    3124:	eb 3f                	jmp    3165 <fwp_data+0xf5>
    3126:	44 89 f1             	mov    %r14d,%ecx
    3129:	83 e1 fc             	and    $0xfffffffc,%ecx
    312c:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
    3133:	00 
    3134:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    3138:	31 f6                	xor    %esi,%esi
    313a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    3140:	0f 10 04 33          	movups (%rbx,%rsi,1),%xmm0
    3144:	0f 10 4c 33 10       	movups 0x10(%rbx,%rsi,1),%xmm1
    3149:	0f 11 44 30 08       	movups %xmm0,0x8(%rax,%rsi,1)
    314e:	0f 11 4c 30 18       	movups %xmm1,0x18(%rax,%rsi,1)
    3153:	48 83 c6 20          	add    $0x20,%rsi
    3157:	48 39 f2             	cmp    %rsi,%rdx
    315a:	75 e4                	jne    3140 <fwp_data+0xd0>
    315c:	4c 39 f1             	cmp    %r14,%rcx
    315f:	0f 85 50 ff ff ff    	jne    30b5 <fwp_data+0x45>
    3165:	48 83 c4 08          	add    $0x8,%rsp
    3169:	5b                   	pop    %rbx
    316a:	41 5e                	pop    %r14
    316c:	41 5f                	pop    %r15
    316e:	5d                   	pop    %rbp
    316f:	c3                   	ret

0000000000003170 <fwp_alloc_init>:
    3170:	53                   	push   %rbx
    3171:	48 89 fa             	mov    %rdi,%rdx
    3174:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    317b:	0f 87 a7 00 00 00    	ja     3228 <fwp_alloc_init+0xb8>
    3181:	48 8d 42 0f          	lea    0xf(%rdx),%rax
    3185:	48 c1 e8 04          	shr    $0x4,%rax
    3189:	48 8d 35 00 11 01 00 	lea    0x11100(%rip),%rsi        # 14290 <fwp_gc>
    3190:	0f b6 bc 30 e8 0b 00 	movzbl 0xbe8(%rax,%rsi,1),%edi
    3197:	00 
    3198:	8b 84 be 48 0b 00 00 	mov    0xb48(%rsi,%rdi,4),%eax
    319f:	48 8b 0d ea 10 01 00 	mov    0x110ea(%rip),%rcx        # 14290 <fwp_gc>
    31a6:	49 89 c8             	mov    %rcx,%r8
    31a9:	49 29 c0             	sub    %rax,%r8
    31ac:	4c 89 05 dd 10 01 00 	mov    %r8,0x110dd(%rip)        # 14290 <fwp_gc>
    31b3:	78 6c                	js     3221 <fwp_alloc_init+0xb1>
    31b5:	48 8d 3c 7f          	lea    (%rdi,%rdi,2),%rdi
    31b9:	4c 8d 04 fe          	lea    (%rsi,%rdi,8),%r8
    31bd:	49 83 c0 08          	add    $0x8,%r8
    31c1:	49 8b 18             	mov    (%r8),%rbx
    31c4:	48 85 db             	test   %rbx,%rbx
    31c7:	74 32                	je     31fb <fwp_alloc_init+0x8b>
    31c9:	48 8b 0b             	mov    (%rbx),%rcx
    31cc:	48 f7 d1             	not    %rcx
    31cf:	49 89 08             	mov    %rcx,(%r8)
    31d2:	81 e2 f8 7f 00 00    	and    $0x7ff8,%edx
    31d8:	48 39 c2             	cmp    %rax,%rdx
    31db:	73 19                	jae    31f6 <fwp_alloc_init+0x86>
    31dd:	48 8d 3c 13          	lea    (%rbx,%rdx,1),%rdi
    31e1:	48 f7 d2             	not    %rdx
    31e4:	48 01 c2             	add    %rax,%rdx
    31e7:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    31eb:	48 83 c2 08          	add    $0x8,%rdx
    31ef:	31 f6                	xor    %esi,%esi
    31f1:	e8 0a f0 ff ff       	call   2200 <memset@plt>
    31f6:	48 89 d8             	mov    %rbx,%rax
    31f9:	5b                   	pop    %rbx
    31fa:	c3                   	ret
    31fb:	48 8b 5c fe 10       	mov    0x10(%rsi,%rdi,8),%rbx
    3200:	4c 8b 44 fe 18       	mov    0x18(%rsi,%rdi,8),%r8
    3205:	49 29 d8             	sub    %rbx,%r8
    3208:	49 39 c0             	cmp    %rax,%r8
    320b:	72 14                	jb     3221 <fwp_alloc_init+0xb1>
    320d:	48 8d 34 fe          	lea    (%rsi,%rdi,8),%rsi
    3211:	48 83 c6 10          	add    $0x10,%rsi
    3215:	48 8d 3c 03          	lea    (%rbx,%rax,1),%rdi
    3219:	48 89 3e             	mov    %rdi,(%rsi)
    321c:	48 85 db             	test   %rbx,%rbx
    321f:	75 b1                	jne    31d2 <fwp_alloc_init+0x62>
    3221:	48 89 0d 68 10 01 00 	mov    %rcx,0x11068(%rip)        # 14290 <fwp_gc>
    3228:	48 89 d7             	mov    %rdx,%rdi
    322b:	31 f6                	xor    %esi,%esi
    322d:	5b                   	pop    %rbx
    322e:	eb 00                	jmp    3230 <fwp_gc_alloc>

0000000000003230 <fwp_gc_alloc>:
    3230:	53                   	push   %rbx
    3231:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    3238:	77 6c                	ja     32a6 <fwp_gc_alloc+0x76>
    323a:	48 8d 4f 0f          	lea    0xf(%rdi),%rcx
    323e:	48 c1 e9 04          	shr    $0x4,%rcx
    3242:	48 8d 05 47 10 01 00 	lea    0x11047(%rip),%rax        # 14290 <fwp_gc>
    3249:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    3250:	00 
    3251:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    3258:	48 29 15 31 10 01 00 	sub    %rdx,0x11031(%rip)        # 14290 <fwp_gc>
    325f:	78 45                	js     32a6 <fwp_gc_alloc+0x76>
    3261:	41 89 f0             	mov    %esi,%r8d
    3264:	4d 69 c0 c0 03 00 00 	imul   $0x3c0,%r8,%r8
    326b:	4c 01 c0             	add    %r8,%rax
    326e:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    3272:	4c 8d 04 c8          	lea    (%rax,%rcx,8),%r8
    3276:	49 83 c0 08          	add    $0x8,%r8
    327a:	49 8b 18             	mov    (%r8),%rbx
    327d:	48 85 db             	test   %rbx,%rbx
    3280:	74 12                	je     3294 <fwp_gc_alloc+0x64>
    3282:	48 8b 03             	mov    (%rbx),%rax
    3285:	48 f7 d0             	not    %rax
    3288:	49 89 00             	mov    %rax,(%r8)
    328b:	83 fe 01             	cmp    $0x1,%esi
    328e:	48 0f 44 d7          	cmove  %rdi,%rdx
    3292:	eb 2e                	jmp    32c2 <fwp_gc_alloc+0x92>
    3294:	48 8b 5c c8 10       	mov    0x10(%rax,%rcx,8),%rbx
    3299:	4c 8b 44 c8 18       	mov    0x18(%rax,%rcx,8),%r8
    329e:	49 29 d8             	sub    %rbx,%r8
    32a1:	49 39 d0             	cmp    %rdx,%r8
    32a4:	73 03                	jae    32a9 <fwp_gc_alloc+0x79>
    32a6:	5b                   	pop    %rbx
    32a7:	eb 37                	jmp    32e0 <fwp_gc_alloc_slow>
    32a9:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    32ad:	48 83 c0 10          	add    $0x10,%rax
    32b1:	48 8d 0c 13          	lea    (%rbx,%rdx,1),%rcx
    32b5:	48 89 08             	mov    %rcx,(%rax)
    32b8:	83 fe 01             	cmp    $0x1,%esi
    32bb:	48 0f 45 fa          	cmovne %rdx,%rdi
    32bf:	48 89 fa             	mov    %rdi,%rdx
    32c2:	48 89 df             	mov    %rbx,%rdi
    32c5:	31 f6                	xor    %esi,%esi
    32c7:	e8 34 ef ff ff       	call   2200 <memset@plt>
    32cc:	48 89 d8             	mov    %rbx,%rax
    32cf:	5b                   	pop    %rbx
    32d0:	c3                   	ret
    32d1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    32d8:	0f 1f 84 00 00 00 00 
    32df:	00 

00000000000032e0 <fwp_gc_alloc_slow>:
    32e0:	55                   	push   %rbp
    32e1:	41 57                	push   %r15
    32e3:	41 56                	push   %r14
    32e5:	41 54                	push   %r12
    32e7:	53                   	push   %rbx
    32e8:	89 f5                	mov    %esi,%ebp
    32ea:	48 89 fb             	mov    %rdi,%rbx
    32ed:	83 3d 88 1f 01 00 00 	cmpl   $0x0,0x11f88(%rip)        # 1527c <fwp_gc+0xfec>
    32f4:	74 1b                	je     3311 <fwp_gc_alloc_slow+0x31>
    32f6:	48 81 fb 01 40 00 00 	cmp    $0x4001,%rbx
    32fd:	72 20                	jb     331f <fwp_gc_alloc_slow+0x3f>
    32ff:	48 89 df             	mov    %rbx,%rdi
    3302:	89 ee                	mov    %ebp,%esi
    3304:	5b                   	pop    %rbx
    3305:	41 5c                	pop    %r12
    3307:	41 5e                	pop    %r14
    3309:	41 5f                	pop    %r15
    330b:	5d                   	pop    %rbp
    330c:	e9 9f 03 00 00       	jmp    36b0 <fwp_gc_alloc_big>
    3311:	e8 ba 00 00 00       	call   33d0 <fwp_gc_init>
    3316:	48 81 fb 01 40 00 00 	cmp    $0x4001,%rbx
    331d:	73 e0                	jae    32ff <fwp_gc_alloc_slow+0x1f>
    331f:	48 8d 43 0f          	lea    0xf(%rbx),%rax
    3323:	48 c1 e8 04          	shr    $0x4,%rax
    3327:	4c 8d 25 62 0f 01 00 	lea    0x10f62(%rip),%r12        # 14290 <fwp_gc>
    332e:	46 0f b6 bc 20 e8 0b 	movzbl 0xbe8(%rax,%r12,1),%r15d
    3335:	00 00 
    3337:	47 8b b4 bc 48 0b 00 	mov    0xb48(%r12,%r15,4),%r14d
    333e:	00 
    333f:	48 83 3d 49 0f 01 00 	cmpq   $0x0,0x10f49(%rip)        # 14290 <fwp_gc>
    3346:	00 
    3347:	79 05                	jns    334e <fwp_gc_alloc_slow+0x6e>
    3349:	e8 b2 04 00 00       	call   3800 <fwp_gc_spent>
    334e:	89 e8                	mov    %ebp,%eax
    3350:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    3357:	49 01 c4             	add    %rax,%r12
    335a:	4b 8d 0c 7f          	lea    (%r15,%r15,2),%rcx
    335e:	49 8d 04 cc          	lea    (%r12,%rcx,8),%rax
    3362:	48 83 c0 08          	add    $0x8,%rax
    3366:	49 8b 7c cc 08       	mov    0x8(%r12,%rcx,8),%rdi
    336b:	48 85 ff             	test   %rdi,%rdi
    336e:	74 08                	je     3378 <fwp_gc_alloc_slow+0x98>
    3370:	48 8b 0f             	mov    (%rdi),%rcx
    3373:	48 f7 d1             	not    %rcx
    3376:	eb 30                	jmp    33a8 <fwp_gc_alloc_slow+0xc8>
    3378:	49 8b 7c cc 10       	mov    0x10(%r12,%rcx,8),%rdi
    337d:	49 8b 54 cc 18       	mov    0x18(%r12,%rcx,8),%rdx
    3382:	48 29 fa             	sub    %rdi,%rdx
    3385:	4c 39 f2             	cmp    %r14,%rdx
    3388:	73 12                	jae    339c <fwp_gc_alloc_slow+0xbc>
    338a:	48 89 c7             	mov    %rax,%rdi
    338d:	44 89 fe             	mov    %r15d,%esi
    3390:	89 ea                	mov    %ebp,%edx
    3392:	e8 39 05 00 00       	call   38d0 <fwp_gc_refill>
    3397:	48 89 c7             	mov    %rax,%rdi
    339a:	eb 0f                	jmp    33ab <fwp_gc_alloc_slow+0xcb>
    339c:	49 8d 04 cc          	lea    (%r12,%rcx,8),%rax
    33a0:	48 83 c0 10          	add    $0x10,%rax
    33a4:	4a 8d 0c 37          	lea    (%rdi,%r14,1),%rcx
    33a8:	48 89 08             	mov    %rcx,(%rax)
    33ab:	83 fd 01             	cmp    $0x1,%ebp
    33ae:	4c 0f 44 f3          	cmove  %rbx,%r14
    33b2:	31 f6                	xor    %esi,%esi
    33b4:	4c 89 f2             	mov    %r14,%rdx
    33b7:	5b                   	pop    %rbx
    33b8:	41 5c                	pop    %r12
    33ba:	41 5e                	pop    %r14
    33bc:	41 5f                	pop    %r15
    33be:	5d                   	pop    %rbp
    33bf:	e9 3c ee ff ff       	jmp    2200 <memset@plt>
    33c4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    33cb:	00 00 00 00 00 

00000000000033d0 <fwp_gc_init>:
    33d0:	53                   	push   %rbx
    33d1:	48 83 ec 10          	sub    $0x10,%rsp
    33d5:	c7 05 9d 1e 01 00 01 	movl   $0x1,0x11e9d(%rip)        # 1527c <fwp_gc+0xfec>
    33dc:	00 00 00 
    33df:	0f 28 05 6a ac 00 00 	movaps 0xac6a(%rip),%xmm0        # e050 <_IO_stdin_used+0x50>
    33e6:	0f 11 05 eb 19 01 00 	movups %xmm0,0x119eb(%rip)        # 14dd8 <fwp_gc+0xb48>
    33ed:	0f 28 05 6c ac 00 00 	movaps 0xac6c(%rip),%xmm0        # e060 <_IO_stdin_used+0x60>
    33f4:	0f 11 05 ed 19 01 00 	movups %xmm0,0x119ed(%rip)        # 14de8 <fwp_gc+0xb58>
    33fb:	0f 28 05 6e ac 00 00 	movaps 0xac6e(%rip),%xmm0        # e070 <_IO_stdin_used+0x70>
    3402:	0f 11 05 ef 19 01 00 	movups %xmm0,0x119ef(%rip)        # 14df8 <fwp_gc+0xb68>
    3409:	0f 28 05 70 ac 00 00 	movaps 0xac70(%rip),%xmm0        # e080 <_IO_stdin_used+0x80>
    3410:	0f 11 05 f1 19 01 00 	movups %xmm0,0x119f1(%rip)        # 14e08 <fwp_gc+0xb78>
    3417:	0f 28 05 72 ac 00 00 	movaps 0xac72(%rip),%xmm0        # e090 <_IO_stdin_used+0x90>
    341e:	0f 11 05 f3 19 01 00 	movups %xmm0,0x119f3(%rip)        # 14e18 <fwp_gc+0xb88>
    3425:	0f 28 05 74 ac 00 00 	movaps 0xac74(%rip),%xmm0        # e0a0 <_IO_stdin_used+0xa0>
    342c:	0f 11 05 f5 19 01 00 	movups %xmm0,0x119f5(%rip)        # 14e28 <fwp_gc+0xb98>
    3433:	0f 28 05 76 ac 00 00 	movaps 0xac76(%rip),%xmm0        # e0b0 <_IO_stdin_used+0xb0>
    343a:	0f 11 05 f7 19 01 00 	movups %xmm0,0x119f7(%rip)        # 14e38 <fwp_gc+0xba8>
    3441:	0f 28 05 78 ac 00 00 	movaps 0xac78(%rip),%xmm0        # e0c0 <_IO_stdin_used+0xc0>
    3448:	0f 11 05 f9 19 01 00 	movups %xmm0,0x119f9(%rip)        # 14e48 <fwp_gc+0xbb8>
    344f:	0f 28 05 7a ac 00 00 	movaps 0xac7a(%rip),%xmm0        # e0d0 <_IO_stdin_used+0xd0>
    3456:	0f 11 05 fb 19 01 00 	movups %xmm0,0x119fb(%rip)        # 14e58 <fwp_gc+0xbc8>
    345d:	0f 28 05 7c ac 00 00 	movaps 0xac7c(%rip),%xmm0        # e0e0 <_IO_stdin_used+0xe0>
    3464:	0f 11 05 fd 19 01 00 	movups %xmm0,0x119fd(%rip)        # 14e68 <fwp_gc+0xbd8>
    346b:	31 c9                	xor    %ecx,%ecx
    346d:	48 8d 05 1c 0e 01 00 	lea    0x10e1c(%rip),%rax        # 14290 <fwp_gc>
    3474:	31 d2                	xor    %edx,%edx
    3476:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    347d:	00 00 00 
    3480:	89 d6                	mov    %edx,%esi
    3482:	c1 e6 04             	shl    $0x4,%esi
    3485:	48 ff c9             	dec    %rcx
    3488:	48 89 cf             	mov    %rcx,%rdi
    348b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    3490:	48 89 f9             	mov    %rdi,%rcx
    3493:	48 ff c7             	inc    %rdi
    3496:	3b b4 88 4c 0b 00 00 	cmp    0xb4c(%rax,%rcx,4),%esi
    349d:	77 f1                	ja     3490 <fwp_gc_init+0xc0>
    349f:	40 88 bc 02 e8 0b 00 	mov    %dil,0xbe8(%rdx,%rax,1)
    34a6:	00 
    34a7:	48 89 d6             	mov    %rdx,%rsi
    34aa:	48 83 ce 01          	or     $0x1,%rsi
    34ae:	48 81 fe 01 04 00 00 	cmp    $0x401,%rsi
    34b5:	74 26                	je     34dd <fwp_gc_init+0x10d>
    34b7:	89 f7                	mov    %esi,%edi
    34b9:	c1 e7 04             	shl    $0x4,%edi
    34bc:	0f 1f 40 00          	nopl   0x0(%rax)
    34c0:	49 89 c8             	mov    %rcx,%r8
    34c3:	48 ff c1             	inc    %rcx
    34c6:	42 3b bc 80 4c 0b 00 	cmp    0xb4c(%rax,%r8,4),%edi
    34cd:	00 
    34ce:	77 f0                	ja     34c0 <fwp_gc_init+0xf0>
    34d0:	88 8c 06 e8 0b 00 00 	mov    %cl,0xbe8(%rsi,%rax,1)
    34d7:	48 83 c2 02          	add    $0x2,%rdx
    34db:	eb a3                	jmp    3480 <fwp_gc_init+0xb0>
    34dd:	48 b8 00 00 00 00 10 	movabs $0x1000000000,%rax
    34e4:	00 00 00 
    34e7:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    34ec:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    34f1:	e8 ba 04 00 00       	call   39b0 <fwp_gc_reserve>
    34f6:	48 85 c0             	test   %rax,%rax
    34f9:	0f 84 ab 01 00 00    	je     36aa <fwp_gc_init+0x2da>
    34ff:	48 89 05 c2 1d 01 00 	mov    %rax,0x11dc2(%rip)        # 152c8 <fwp_gc+0x1038>
    3506:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    350b:	48 8d 91 00 00 01 00 	lea    0x10000(%rcx),%rdx
    3512:	48 89 15 b7 1d 01 00 	mov    %rdx,0x11db7(%rip)        # 152d0 <fwp_gc+0x1040>
    3519:	48 05 ff ff 00 00    	add    $0xffff,%rax
    351f:	48 25 00 00 ff ff    	and    $0xffffffffffff0000,%rax
    3525:	48 89 05 94 1d 01 00 	mov    %rax,0x11d94(%rip)        # 152c0 <fwp_gc+0x1030>
    352c:	48 c1 e9 10          	shr    $0x10,%rcx
    3530:	48 89 0d a9 1d 01 00 	mov    %rcx,0x11da9(%rip)        # 152e0 <fwp_gc+0x1050>
    3537:	48 69 f1 28 12 00 00 	imul   $0x1228,%rcx,%rsi
    353e:	48 89 35 cb 1d 01 00 	mov    %rsi,0x11dcb(%rip)        # 15310 <fwp_gc+0x1080>
    3545:	31 ff                	xor    %edi,%edi
    3547:	31 d2                	xor    %edx,%edx
    3549:	b9 22 40 00 00       	mov    $0x4022,%ecx
    354e:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    3554:	45 31 c9             	xor    %r9d,%r9d
    3557:	e8 24 ec ff ff       	call   2180 <mmap@plt>
    355c:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    3560:	0f 84 44 01 00 00    	je     36aa <fwp_gc_init+0x2da>
    3566:	48 89 05 9b 1d 01 00 	mov    %rax,0x11d9b(%rip)        # 15308 <fwp_gc+0x1078>
    356d:	48 8d 3d e3 b1 00 00 	lea    0xb1e3(%rip),%rdi        # e757 <exec_in_fp0+0xf7>
    3574:	e8 b7 ea ff ff       	call   2030 <getenv@plt>
    3579:	48 85 c0             	test   %rax,%rax
    357c:	74 2e                	je     35ac <fwp_gc_init+0x1dc>
    357e:	48 89 c3             	mov    %rax,%rbx
    3581:	48 8d 35 d6 b1 00 00 	lea    0xb1d6(%rip),%rsi        # e75e <exec_in_fp0+0xfe>
    3588:	48 89 c7             	mov    %rax,%rdi
    358b:	e8 30 ed ff ff       	call   22c0 <strcmp@plt>
    3590:	85 c0                	test   %eax,%eax
    3592:	74 1f                	je     35b3 <fwp_gc_init+0x1e3>
    3594:	48 8d 35 fd bd 00 00 	lea    0xbdfd(%rip),%rsi        # f398 <exec_in_fp0+0xd38>
    359b:	48 89 df             	mov    %rbx,%rdi
    359e:	e8 1d ed ff ff       	call   22c0 <strcmp@plt>
    35a3:	31 c9                	xor    %ecx,%ecx
    35a5:	85 c0                	test   %eax,%eax
    35a7:	0f 95 c1             	setne  %cl
    35aa:	eb 09                	jmp    35b5 <fwp_gc_init+0x1e5>
    35ac:	b9 01 00 00 00       	mov    $0x1,%ecx
    35b1:	eb 02                	jmp    35b5 <fwp_gc_init+0x1e5>
    35b3:	31 c9                	xor    %ecx,%ecx
    35b5:	89 0d c5 1c 01 00    	mov    %ecx,0x11cc5(%rip)        # 15280 <fwp_gc+0xff0>
    35bb:	48 8d 3d a0 b1 00 00 	lea    0xb1a0(%rip),%rdi        # e762 <exec_in_fp0+0x102>
    35c2:	e8 69 ea ff ff       	call   2030 <getenv@plt>
    35c7:	31 c9                	xor    %ecx,%ecx
    35c9:	48 85 c0             	test   %rax,%rax
    35cc:	74 1b                	je     35e9 <fwp_gc_init+0x219>
    35ce:	80 38 00             	cmpb   $0x0,(%rax)
    35d1:	74 16                	je     35e9 <fwp_gc_init+0x219>
    35d3:	48 8d 35 be bd 00 00 	lea    0xbdbe(%rip),%rsi        # f398 <exec_in_fp0+0xd38>
    35da:	48 89 c7             	mov    %rax,%rdi
    35dd:	e8 de ec ff ff       	call   22c0 <strcmp@plt>
    35e2:	31 c9                	xor    %ecx,%ecx
    35e4:	85 c0                	test   %eax,%eax
    35e6:	0f 95 c1             	setne  %cl
    35e9:	89 0d 9d 1c 01 00    	mov    %ecx,0x11c9d(%rip)        # 1528c <fwp_gc+0xffc>
    35ef:	48 8d 3d 61 b1 00 00 	lea    0xb161(%rip),%rdi        # e757 <exec_in_fp0+0xf7>
    35f6:	e8 35 ea ff ff       	call   2030 <getenv@plt>
    35fb:	48 85 c0             	test   %rax,%rax
    35fe:	74 18                	je     3618 <fwp_gc_init+0x248>
    3600:	48 8d 35 68 b1 00 00 	lea    0xb168(%rip),%rsi        # e76f <exec_in_fp0+0x10f>
    3607:	48 89 c7             	mov    %rax,%rdi
    360a:	e8 b1 ec ff ff       	call   22c0 <strcmp@plt>
    360f:	31 c9                	xor    %ecx,%ecx
    3611:	85 c0                	test   %eax,%eax
    3613:	0f 95 c1             	setne  %cl
    3616:	eb 05                	jmp    361d <fwp_gc_init+0x24d>
    3618:	b9 01 00 00 00       	mov    $0x1,%ecx
    361d:	89 0d 6d 1c 01 00    	mov    %ecx,0x11c6d(%rip)        # 15290 <fwp_gc+0x1000>
    3623:	c7 05 6b 1c 01 00 01 	movl   $0x1,0x11c6b(%rip)        # 15298 <fwp_gc+0x1008>
    362a:	00 00 00 
    362d:	48 8d 3d 40 b1 00 00 	lea    0xb140(%rip),%rdi        # e774 <exec_in_fp0+0x114>
    3634:	e8 f7 e9 ff ff       	call   2030 <getenv@plt>
    3639:	31 c9                	xor    %ecx,%ecx
    363b:	48 85 c0             	test   %rax,%rax
    363e:	74 1b                	je     365b <fwp_gc_init+0x28b>
    3640:	80 38 00             	cmpb   $0x0,(%rax)
    3643:	74 16                	je     365b <fwp_gc_init+0x28b>
    3645:	48 8d 35 4c bd 00 00 	lea    0xbd4c(%rip),%rsi        # f398 <exec_in_fp0+0xd38>
    364c:	48 89 c7             	mov    %rax,%rdi
    364f:	e8 6c ec ff ff       	call   22c0 <strcmp@plt>
    3654:	31 c9                	xor    %ecx,%ecx
    3656:	85 c0                	test   %eax,%eax
    3658:	0f 95 c1             	setne  %cl
    365b:	89 0d 33 1c 01 00    	mov    %ecx,0x11c33(%rip)        # 15294 <fwp_gc+0x1004>
    3661:	48 8d 3d 1a b1 00 00 	lea    0xb11a(%rip),%rdi        # e782 <exec_in_fp0+0x122>
    3668:	e8 c3 e9 ff ff       	call   2030 <getenv@plt>
    366d:	48 85 c0             	test   %rax,%rax
    3670:	74 0a                	je     367c <fwp_gc_init+0x2ac>
    3672:	48 89 c7             	mov    %rax,%rdi
    3675:	e8 76 ed ff ff       	call   23f0 <atol@plt>
    367a:	eb 02                	jmp    367e <fwp_gc_init+0x2ae>
    367c:	31 c0                	xor    %eax,%eax
    367e:	31 c9                	xor    %ecx,%ecx
    3680:	48 85 c0             	test   %rax,%rax
    3683:	48 0f 4f c8          	cmovg  %rax,%rcx
    3687:	48 89 0d 22 1c 01 00 	mov    %rcx,0x11c22(%rip)        # 152b0 <fwp_gc+0x1020>
    368e:	48 c7 05 07 1e 01 00 	movq   $0x800000,0x11e07(%rip)        # 154a0 <fwp_gc+0x1210>
    3695:	00 00 80 00 
    3699:	48 c7 05 ec 0b 01 00 	movq   $0x800000,0x10bec(%rip)        # 14290 <fwp_gc>
    36a0:	00 00 80 00 
    36a4:	48 83 c4 10          	add    $0x10,%rsp
    36a8:	5b                   	pop    %rbx
    36a9:	c3                   	ret
    36aa:	e8 71 03 00 00       	call   3a20 <fwp_gc_oom>
    36af:	90                   	nop

00000000000036b0 <fwp_gc_alloc_big>:
    36b0:	55                   	push   %rbp
    36b1:	41 57                	push   %r15
    36b3:	41 56                	push   %r14
    36b5:	41 54                	push   %r12
    36b7:	53                   	push   %rbx
    36b8:	48 b8 01 00 00 00 00 	movabs $0x4000000000000001,%rax
    36bf:	00 00 40 
    36c2:	48 39 c7             	cmp    %rax,%rdi
    36c5:	0f 83 28 01 00 00    	jae    37f3 <fwp_gc_alloc_big+0x143>
    36cb:	89 f5                	mov    %esi,%ebp
    36cd:	48 89 fb             	mov    %rdi,%rbx
    36d0:	48 29 3d b9 0b 01 00 	sub    %rdi,0x10bb9(%rip)        # 14290 <fwp_gc>
    36d7:	79 05                	jns    36de <fwp_gc_alloc_big+0x2e>
    36d9:	e8 22 01 00 00       	call   3800 <fwp_gc_spent>
    36de:	4c 8d bb ff ff 00 00 	lea    0xffff(%rbx),%r15
    36e5:	49 c1 ef 10          	shr    $0x10,%r15
    36e9:	4c 89 ff             	mov    %r15,%rdi
    36ec:	e8 5f 03 00 00       	call   3a50 <fwp_gc_chunks>
    36f1:	49 89 c6             	mov    %rax,%r14
    36f4:	48 8b 05 0d 1c 01 00 	mov    0x11c0d(%rip),%rax        # 15308 <fwp_gc+0x1078>
    36fb:	4d 69 e6 28 12 00 00 	imul   $0x1228,%r14,%r12
    3702:	42 c6 04 20 02       	movb   $0x2,(%rax,%r12,1)
    3707:	42 88 6c 20 01       	mov    %bpl,0x1(%rax,%r12,1)
    370c:	66 42 c7 44 20 03 00 	movw   $0x100,0x3(%rax,%r12,1)
    3713:	01 
    3714:	46 89 7c 20 10       	mov    %r15d,0x10(%rax,%r12,1)
    3719:	4a 89 5c 20 18       	mov    %rbx,0x18(%rax,%r12,1)
    371e:	4a 8d 3c 20          	lea    (%rax,%r12,1),%rdi
    3722:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    3729:	e8 82 f7 ff ff       	call   2eb0 <fwp_rc_clear_slot>
    372e:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    3735:	0f 82 9b 00 00 00    	jb     37d6 <fwp_gc_alloc_big+0x126>
    373b:	49 83 ff 03          	cmp    $0x3,%r15
    373f:	b9 02 00 00 00       	mov    $0x2,%ecx
    3744:	49 0f 43 cf          	cmovae %r15,%rcx
    3748:	48 8b 05 b9 1b 01 00 	mov    0x11bb9(%rip),%rax        # 15308 <fwp_gc+0x1078>
    374f:	48 ff c9             	dec    %rcx
    3752:	ba 01 00 00 00       	mov    $0x1,%edx
    3757:	48 81 fb 01 00 02 00 	cmp    $0x20001,%rbx
    375e:	72 59                	jb     37b9 <fwp_gc_alloc_big+0x109>
    3760:	49 8d 34 04          	lea    (%r12,%rax,1),%rsi
    3764:	48 81 c6 60 24 00 00 	add    $0x2460,%rsi
    376b:	48 89 cf             	mov    %rcx,%rdi
    376e:	48 83 e7 fe          	and    $0xfffffffffffffffe,%rdi
    3772:	48 f7 df             	neg    %rdi
    3775:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    377c:	00 00 00 00 
    3780:	c6 86 c8 ed ff ff 03 	movb   $0x3,-0x1238(%rsi)
    3787:	c6 86 cc ed ff ff 01 	movb   $0x1,-0x1234(%rsi)
    378e:	44 89 b6 d8 ed ff ff 	mov    %r14d,-0x1228(%rsi)
    3795:	c6 46 f0 03          	movb   $0x3,-0x10(%rsi)
    3799:	c6 46 f4 01          	movb   $0x1,-0xc(%rsi)
    379d:	44 89 36             	mov    %r14d,(%rsi)
    37a0:	48 81 c6 50 24 00 00 	add    $0x2450,%rsi
    37a7:	4c 8d 04 17          	lea    (%rdi,%rdx,1),%r8
    37ab:	49 83 c0 02          	add    $0x2,%r8
    37af:	48 83 c2 02          	add    $0x2,%rdx
    37b3:	49 83 f8 01          	cmp    $0x1,%r8
    37b7:	75 c7                	jne    3780 <fwp_gc_alloc_big+0xd0>
    37b9:	f6 c1 01             	test   $0x1,%cl
    37bc:	74 18                	je     37d6 <fwp_gc_alloc_big+0x126>
    37be:	4c 01 e0             	add    %r12,%rax
    37c1:	48 69 ca 28 12 00 00 	imul   $0x1228,%rdx,%rcx
    37c8:	c6 04 08 03          	movb   $0x3,(%rax,%rcx,1)
    37cc:	c6 44 08 04 01       	movb   $0x1,0x4(%rax,%rcx,1)
    37d1:	44 89 74 08 10       	mov    %r14d,0x10(%rax,%rcx,1)
    37d6:	4c 89 f7             	mov    %r14,%rdi
    37d9:	e8 f2 f6 ff ff       	call   2ed0 <fwp_gc_chunk_addr>
    37de:	48 89 c7             	mov    %rax,%rdi
    37e1:	31 f6                	xor    %esi,%esi
    37e3:	48 89 da             	mov    %rbx,%rdx
    37e6:	5b                   	pop    %rbx
    37e7:	41 5c                	pop    %r12
    37e9:	41 5e                	pop    %r14
    37eb:	41 5f                	pop    %r15
    37ed:	5d                   	pop    %rbp
    37ee:	e9 0d ea ff ff       	jmp    2200 <memset@plt>
    37f3:	e8 28 02 00 00       	call   3a20 <fwp_gc_oom>
    37f8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    37ff:	00 

0000000000003800 <fwp_gc_spent>:
    3800:	50                   	push   %rax
    3801:	83 3d 74 1a 01 00 00 	cmpl   $0x0,0x11a74(%rip)        # 1527c <fwp_gc+0xfec>
    3808:	75 05                	jne    380f <fwp_gc_spent+0xf>
    380a:	e8 c1 fb ff ff       	call   33d0 <fwp_gc_init>
    380f:	8b 05 6f 1a 01 00    	mov    0x11a6f(%rip),%eax        # 15284 <fwp_gc+0xff4>
    3815:	85 c0                	test   %eax,%eax
    3817:	74 6d                	je     3886 <fwp_gc_spent+0x86>
    3819:	48 8b 0d 90 1a 01 00 	mov    0x11a90(%rip),%rcx        # 152b0 <fwp_gc+0x1020>
    3820:	48 85 c9             	test   %rcx,%rcx
    3823:	74 61                	je     3886 <fwp_gc_spent+0x86>
    3825:	48 8b 05 8c 1a 01 00 	mov    0x11a8c(%rip),%rax        # 152b8 <fwp_gc+0x1028>
    382c:	48 ff c0             	inc    %rax
    382f:	48 89 05 82 1a 01 00 	mov    %rax,0x11a82(%rip)        # 152b8 <fwp_gc+0x1028>
    3836:	48 39 c8             	cmp    %rcx,%rax
    3839:	7c 10                	jl     384b <fwp_gc_spent+0x4b>
    383b:	48 c7 05 72 1a 01 00 	movq   $0x0,0x11a72(%rip)        # 152b8 <fwp_gc+0x1028>
    3842:	00 00 00 00 
    3846:	e8 85 03 00 00       	call   3bd0 <fwp_gc_collect>
    384b:	48 8b 05 4e 1c 01 00 	mov    0x11c4e(%rip),%rax        # 154a0 <fwp_gc+0x1210>
    3852:	48 2b 05 37 0a 01 00 	sub    0x10a37(%rip),%rax        # 14290 <fwp_gc>
    3859:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    385e:	f2 0f 58 05 12 1c 01 	addsd  0x11c12(%rip),%xmm0        # 15478 <fwp_gc+0x11e8>
    3865:	00 
    3866:	f2 0f 11 05 0a 1c 01 	movsd  %xmm0,0x11c0a(%rip)        # 15478 <fwp_gc+0x11e8>
    386d:	00 
    386e:	48 c7 05 27 1c 01 00 	movq   $0x0,0x11c27(%rip)        # 154a0 <fwp_gc+0x1210>
    3875:	00 00 00 00 
    3879:	48 c7 05 0c 0a 01 00 	movq   $0x0,0x10a0c(%rip)        # 14290 <fwp_gc>
    3880:	00 00 00 00 
    3884:	58                   	pop    %rax
    3885:	c3                   	ret
    3886:	85 c0                	test   %eax,%eax
    3888:	74 06                	je     3890 <fwp_gc_spent+0x90>
    388a:	58                   	pop    %rax
    388b:	e9 40 03 00 00       	jmp    3bd0 <fwp_gc_collect>
    3890:	48 8b 05 09 1c 01 00 	mov    0x11c09(%rip),%rax        # 154a0 <fwp_gc+0x1210>
    3897:	48 2b 05 f2 09 01 00 	sub    0x109f2(%rip),%rax        # 14290 <fwp_gc>
    389e:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    38a3:	f2 0f 58 05 cd 1b 01 	addsd  0x11bcd(%rip),%xmm0        # 15478 <fwp_gc+0x11e8>
    38aa:	00 
    38ab:	f2 0f 11 05 c5 1b 01 	movsd  %xmm0,0x11bc5(%rip)        # 15478 <fwp_gc+0x11e8>
    38b2:	00 
    38b3:	48 c7 05 e2 1b 01 00 	movq   $0x800000,0x11be2(%rip)        # 154a0 <fwp_gc+0x1210>
    38ba:	00 00 80 00 
    38be:	48 c7 05 c7 09 01 00 	movq   $0x800000,0x109c7(%rip)        # 14290 <fwp_gc>
    38c5:	00 00 80 00 
    38c9:	58                   	pop    %rax
    38ca:	c3                   	ret
    38cb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000038d0 <fwp_gc_refill>:
    38d0:	55                   	push   %rbp
    38d1:	41 57                	push   %r15
    38d3:	41 56                	push   %r14
    38d5:	53                   	push   %rbx
    38d6:	50                   	push   %rax
    38d7:	89 d5                	mov    %edx,%ebp
    38d9:	41 89 f7             	mov    %esi,%r15d
    38dc:	48 89 fb             	mov    %rdi,%rbx
    38df:	bf 01 00 00 00       	mov    $0x1,%edi
    38e4:	e8 67 01 00 00       	call   3a50 <fwp_gc_chunks>
    38e9:	49 89 c6             	mov    %rax,%r14
    38ec:	48 8b 0d 15 1a 01 00 	mov    0x11a15(%rip),%rcx        # 15308 <fwp_gc+0x1078>
    38f3:	48 8d 05 96 09 01 00 	lea    0x10996(%rip),%rax        # 14290 <fwp_gc>
    38fa:	49 69 f6 28 12 00 00 	imul   $0x1228,%r14,%rsi
    3901:	48 8d 3c 31          	lea    (%rcx,%rsi,1),%rdi
    3905:	c6 04 31 01          	movb   $0x1,(%rcx,%rsi,1)
    3909:	40 88 6c 31 01       	mov    %bpl,0x1(%rcx,%rsi,1)
    390e:	44 88 7c 31 02       	mov    %r15b,0x2(%rcx,%rsi,1)
    3913:	c6 44 31 04 01       	movb   $0x1,0x4(%rcx,%rsi,1)
    3918:	44 89 fa             	mov    %r15d,%edx
    391b:	44 8b 84 90 48 0b 00 	mov    0xb48(%rax,%rdx,4),%r8d
    3922:	00 
    3923:	44 89 44 31 08       	mov    %r8d,0x8(%rcx,%rsi,1)
    3928:	b8 00 00 01 00       	mov    $0x10000,%eax
    392d:	31 d2                	xor    %edx,%edx
    392f:	41 f7 f0             	div    %r8d
    3932:	89 44 31 0c          	mov    %eax,0xc(%rcx,%rsi,1)
    3936:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    393b:	4c 01 c0             	add    %r8,%rax
    393e:	48 0f ba e0 20       	bt     $0x20,%rax
    3943:	73 07                	jae    394c <fwp_gc_refill+0x7c>
    3945:	31 d2                	xor    %edx,%edx
    3947:	49 f7 f0             	div    %r8
    394a:	eb 05                	jmp    3951 <fwp_gc_refill+0x81>
    394c:	31 d2                	xor    %edx,%edx
    394e:	41 f7 f0             	div    %r8d
    3951:	4c 8d 3c 31          	lea    (%rcx,%rsi,1),%r15
    3955:	49 83 c7 08          	add    $0x8,%r15
    3959:	89 44 31 20          	mov    %eax,0x20(%rcx,%rsi,1)
    395d:	e8 4e 15 00 00       	call   4eb0 <fwp_rc_clear_chunk>
    3962:	4c 89 f7             	mov    %r14,%rdi
    3965:	e8 66 f5 ff ff       	call   2ed0 <fwp_gc_chunk_addr>
    396a:	83 3d 23 19 01 00 00 	cmpl   $0x0,0x11923(%rip)        # 15294 <fwp_gc+0x1004>
    3971:	74 15                	je     3988 <fwp_gc_refill+0xb8>
    3973:	ba 00 00 01 00       	mov    $0x10000,%edx
    3978:	48 89 c7             	mov    %rax,%rdi
    397b:	31 f6                	xor    %esi,%esi
    397d:	49 89 c6             	mov    %rax,%r14
    3980:	e8 7b e8 ff ff       	call   2200 <memset@plt>
    3985:	4c 89 f0             	mov    %r14,%rax
    3988:	41 8b 0f             	mov    (%r15),%ecx
    398b:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    398f:	48 89 53 08          	mov    %rdx,0x8(%rbx)
    3993:	41 8b 57 04          	mov    0x4(%r15),%edx
    3997:	48 0f af d1          	imul   %rcx,%rdx
    399b:	48 01 c2             	add    %rax,%rdx
    399e:	48 89 53 10          	mov    %rdx,0x10(%rbx)
    39a2:	48 83 c4 08          	add    $0x8,%rsp
    39a6:	5b                   	pop    %rbx
    39a7:	41 5e                	pop    %r14
    39a9:	41 5f                	pop    %r15
    39ab:	5d                   	pop    %rbp
    39ac:	c3                   	ret
    39ad:	0f 1f 00             	nopl   (%rax)

00000000000039b0 <fwp_gc_reserve>:
    39b0:	41 56                	push   %r14
    39b2:	53                   	push   %rbx
    39b3:	50                   	push   %rax
    39b4:	4c 8b 37             	mov    (%rdi),%r14
    39b7:	49 81 fe 00 00 00 10 	cmp    $0x10000000,%r14
    39be:	72 47                	jb     3a07 <fwp_gc_reserve+0x57>
    39c0:	48 89 fb             	mov    %rdi,%rbx
    39c3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    39ca:	84 00 00 00 00 00 
    39d0:	49 8d b6 00 00 01 00 	lea    0x10000(%r14),%rsi
    39d7:	31 ff                	xor    %edi,%edi
    39d9:	31 d2                	xor    %edx,%edx
    39db:	b9 22 40 00 00       	mov    $0x4022,%ecx
    39e0:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    39e6:	45 31 c9             	xor    %r9d,%r9d
    39e9:	e8 92 e7 ff ff       	call   2180 <mmap@plt>
    39ee:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    39f2:	75 17                	jne    3a0b <fwp_gc_reserve+0x5b>
    39f4:	4c 89 f0             	mov    %r14,%rax
    39f7:	48 c1 e8 02          	shr    $0x2,%rax
    39fb:	49 81 fe ff ff ff 3f 	cmp    $0x3fffffff,%r14
    3a02:	49 89 c6             	mov    %rax,%r14
    3a05:	77 c9                	ja     39d0 <fwp_gc_reserve+0x20>
    3a07:	31 c0                	xor    %eax,%eax
    3a09:	eb 03                	jmp    3a0e <fwp_gc_reserve+0x5e>
    3a0b:	4c 89 33             	mov    %r14,(%rbx)
    3a0e:	48 83 c4 08          	add    $0x8,%rsp
    3a12:	5b                   	pop    %rbx
    3a13:	41 5e                	pop    %r14
    3a15:	c3                   	ret
    3a16:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    3a1d:	00 00 00 

0000000000003a20 <fwp_gc_oom>:
    3a20:	50                   	push   %rax
    3a21:	48 8b 05 b8 05 01 00 	mov    0x105b8(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    3a28:	48 8b 08             	mov    (%rax),%rcx
    3a2b:	48 8d 3d 5e ad 00 00 	lea    0xad5e(%rip),%rdi        # e790 <exec_in_fp0+0x130>
    3a32:	be 13 00 00 00       	mov    $0x13,%esi
    3a37:	ba 01 00 00 00       	mov    $0x1,%edx
    3a3c:	e8 4f ea ff ff       	call   2490 <fwrite@plt>
    3a41:	bf 66 00 00 00       	mov    $0x66,%edi
    3a46:	e8 25 ea ff ff       	call   2470 <exit@plt>
    3a4b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000003a50 <fwp_gc_chunks>:
    3a50:	41 56                	push   %r14
    3a52:	53                   	push   %rbx
    3a53:	50                   	push   %rax
    3a54:	48 89 fb             	mov    %rdi,%rbx
    3a57:	31 d2                	xor    %edx,%edx
    3a59:	48 83 ff 01          	cmp    $0x1,%rdi
    3a5d:	0f 95 c2             	setne  %dl
    3a60:	48 8d 0d 29 08 01 00 	lea    0x10829(%rip),%rcx        # 14290 <fwp_gc>
    3a67:	48 8b 84 d1 68 10 00 	mov    0x1068(%rcx,%rdx,8),%rax
    3a6e:	00 
    3a6f:	4c 8b 35 72 18 01 00 	mov    0x11872(%rip),%r14        # 152e8 <fwp_gc+0x1058>
    3a76:	48 89 c7             	mov    %rax,%rdi
    3a79:	4c 29 f7             	sub    %r14,%rdi
    3a7c:	73 61                	jae    3adf <fwp_gc_chunks+0x8f>
    3a7e:	48 8d 34 d5 68 10 00 	lea    0x1068(,%rdx,8),%rsi
    3a85:	00 
    3a86:	4c 69 c0 28 12 00 00 	imul   $0x1228,%rax,%r8
    3a8d:	4c 03 05 74 18 01 00 	add    0x11874(%rip),%r8        # 15308 <fwp_gc+0x1078>
    3a94:	31 d2                	xor    %edx,%edx
    3a96:	45 31 c9             	xor    %r9d,%r9d
    3a99:	eb 17                	jmp    3ab2 <fwp_gc_chunks+0x62>
    3a9b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    3aa0:	45 31 c9             	xor    %r9d,%r9d
    3aa3:	48 ff ca             	dec    %rdx
    3aa6:	49 81 c0 28 12 00 00 	add    $0x1228,%r8
    3aad:	48 39 d7             	cmp    %rdx,%rdi
    3ab0:	74 30                	je     3ae2 <fwp_gc_chunks+0x92>
    3ab2:	41 80 38 00          	cmpb   $0x0,(%r8)
    3ab6:	75 e8                	jne    3aa0 <fwp_gc_chunks+0x50>
    3ab8:	49 ff c1             	inc    %r9
    3abb:	49 39 d9             	cmp    %rbx,%r9
    3abe:	75 e3                	jne    3aa3 <fwp_gc_chunks+0x53>
    3ac0:	48 ff c0             	inc    %rax
    3ac3:	48 89 c7             	mov    %rax,%rdi
    3ac6:	48 29 d7             	sub    %rdx,%rdi
    3ac9:	48 89 3c 0e          	mov    %rdi,(%rsi,%rcx,1)
    3acd:	48 29 1d 9c 19 01 00 	sub    %rbx,0x1199c(%rip)        # 15470 <fwp_gc+0x11e0>
    3ad4:	48 29 d8             	sub    %rbx,%rax
    3ad7:	48 29 d0             	sub    %rdx,%rax
    3ada:	49 89 c6             	mov    %rax,%r14
    3add:	eb 33                	jmp    3b12 <fwp_gc_chunks+0xc2>
    3adf:	45 31 c9             	xor    %r9d,%r9d
    3ae2:	4d 29 ce             	sub    %r9,%r14
    3ae5:	4c 29 0d 84 19 01 00 	sub    %r9,0x11984(%rip)        # 15470 <fwp_gc+0x11e0>
    3aec:	4c 01 f3             	add    %r14,%rbx
    3aef:	48 89 df             	mov    %rbx,%rdi
    3af2:	e8 29 00 00 00       	call   3b20 <fwp_gc_commit>
    3af7:	48 89 1d ea 17 01 00 	mov    %rbx,0x117ea(%rip)        # 152e8 <fwp_gc+0x1058>
    3afe:	48 c1 e3 10          	shl    $0x10,%rbx
    3b02:	48 3b 1d cf 17 01 00 	cmp    0x117cf(%rip),%rbx        # 152d8 <fwp_gc+0x1048>
    3b09:	76 07                	jbe    3b12 <fwp_gc_chunks+0xc2>
    3b0b:	48 89 1d c6 17 01 00 	mov    %rbx,0x117c6(%rip)        # 152d8 <fwp_gc+0x1048>
    3b12:	4c 89 f0             	mov    %r14,%rax
    3b15:	48 83 c4 08          	add    $0x8,%rsp
    3b19:	5b                   	pop    %rbx
    3b1a:	41 5e                	pop    %r14
    3b1c:	c3                   	ret
    3b1d:	0f 1f 00             	nopl   (%rax)

0000000000003b20 <fwp_gc_commit>:
    3b20:	53                   	push   %rbx
    3b21:	48 89 fb             	mov    %rdi,%rbx
    3b24:	48 8b 3d c5 17 01 00 	mov    0x117c5(%rip),%rdi        # 152f0 <fwp_gc+0x1060>
    3b2b:	48 39 df             	cmp    %rbx,%rdi
    3b2e:	0f 83 8f 00 00 00    	jae    3bc3 <fwp_gc_commit+0xa3>
    3b34:	48 8b 05 a5 17 01 00 	mov    0x117a5(%rip),%rax        # 152e0 <fwp_gc+0x1050>
    3b3b:	48 39 d8             	cmp    %rbx,%rax
    3b3e:	0f 82 81 00 00 00    	jb     3bc5 <fwp_gc_commit+0xa5>
    3b44:	48 83 c3 40          	add    $0x40,%rbx
    3b48:	48 39 c3             	cmp    %rax,%rbx
    3b4b:	48 0f 43 d8          	cmovae %rax,%rbx
    3b4f:	48 89 de             	mov    %rbx,%rsi
    3b52:	48 29 fe             	sub    %rdi,%rsi
    3b55:	48 c1 e7 10          	shl    $0x10,%rdi
    3b59:	48 03 3d 60 17 01 00 	add    0x11760(%rip),%rdi        # 152c0 <fwp_gc+0x1030>
    3b60:	48 c1 e6 10          	shl    $0x10,%rsi
    3b64:	ba 03 00 00 00       	mov    $0x3,%edx
    3b69:	e8 92 e8 ff ff       	call   2400 <mprotect@plt>
    3b6e:	85 c0                	test   %eax,%eax
    3b70:	75 53                	jne    3bc5 <fwp_gc_commit+0xa5>
    3b72:	bf 1e 00 00 00       	mov    $0x1e,%edi
    3b77:	e8 a4 e8 ff ff       	call   2420 <sysconf@plt>
    3b7c:	48 8b 0d 85 17 01 00 	mov    0x11785(%rip),%rcx        # 15308 <fwp_gc+0x1078>
    3b83:	48 69 3d 62 17 01 00 	imul   $0x1228,0x11762(%rip),%rdi        # 152f0 <fwp_gc+0x1060>
    3b8a:	28 12 00 00 
    3b8e:	48 01 cf             	add    %rcx,%rdi
    3b91:	48 69 d3 28 12 00 00 	imul   $0x1228,%rbx,%rdx
    3b98:	48 01 ca             	add    %rcx,%rdx
    3b9b:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    3b9f:	48 ff ce             	dec    %rsi
    3ba2:	48 f7 d8             	neg    %rax
    3ba5:	48 21 c7             	and    %rax,%rdi
    3ba8:	48 21 c6             	and    %rax,%rsi
    3bab:	48 29 fe             	sub    %rdi,%rsi
    3bae:	ba 03 00 00 00       	mov    $0x3,%edx
    3bb3:	e8 48 e8 ff ff       	call   2400 <mprotect@plt>
    3bb8:	85 c0                	test   %eax,%eax
    3bba:	75 09                	jne    3bc5 <fwp_gc_commit+0xa5>
    3bbc:	48 89 1d 2d 17 01 00 	mov    %rbx,0x1172d(%rip)        # 152f0 <fwp_gc+0x1060>
    3bc3:	5b                   	pop    %rbx
    3bc4:	c3                   	ret
    3bc5:	e8 56 fe ff ff       	call   3a20 <fwp_gc_oom>
    3bca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000003bd0 <fwp_gc_collect>:
    3bd0:	83 3d b1 16 01 00 00 	cmpl   $0x0,0x116b1(%rip)        # 15288 <fwp_gc+0xff8>
    3bd7:	74 01                	je     3bda <fwp_gc_collect+0xa>
    3bd9:	c3                   	ret
    3bda:	55                   	push   %rbp
    3bdb:	48 89 e5             	mov    %rsp,%rbp
    3bde:	41 57                	push   %r15
    3be0:	41 56                	push   %r14
    3be2:	41 55                	push   %r13
    3be4:	41 54                	push   %r12
    3be6:	53                   	push   %rbx
    3be7:	48 81 ec e8 00 00 00 	sub    $0xe8,%rsp
    3bee:	c7 05 90 16 01 00 01 	movl   $0x1,0x11690(%rip)        # 15288 <fwp_gc+0xff8>
    3bf5:	00 00 00 
    3bf8:	48 8d 75 b8          	lea    -0x48(%rbp),%rsi
    3bfc:	bf 01 00 00 00       	mov    $0x1,%edi
    3c01:	e8 1a e5 ff ff       	call   2120 <clock_gettime@plt>
    3c06:	48 8b 05 93 18 01 00 	mov    0x11893(%rip),%rax        # 154a0 <fwp_gc+0x1210>
    3c0d:	48 2b 05 7c 06 01 00 	sub    0x1067c(%rip),%rax        # 14290 <fwp_gc>
    3c14:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    3c19:	f2 0f 58 05 57 18 01 	addsd  0x11857(%rip),%xmm0        # 15478 <fwp_gc+0x11e8>
    3c20:	00 
    3c21:	f2 0f 11 05 4f 18 01 	movsd  %xmm0,0x1184f(%rip)        # 15478 <fwp_gc+0x11e8>
    3c28:	00 
    3c29:	83 3d 60 16 01 00 00 	cmpl   $0x0,0x11660(%rip)        # 15290 <fwp_gc+0x1000>
    3c30:	0f 94 c0             	sete   %al
    3c33:	83 3d 5e 16 01 00 00 	cmpl   $0x0,0x1165e(%rip)        # 15298 <fwp_gc+0x1008>
    3c3a:	0f 95 c3             	setne  %bl
    3c3d:	08 c3                	or     %al,%bl
    3c3f:	80 fb 01             	cmp    $0x1,%bl
    3c42:	75 3e                	jne    3c82 <fwp_gc_collect+0xb2>
    3c44:	e8 b7 01 00 00       	call   3e00 <fwp_gc_clear_marks>
    3c49:	48 8d bd f0 fe ff ff 	lea    -0x110(%rbp),%rdi
    3c50:	e8 4b e6 ff ff       	call   22a0 <_setjmp@plt>
    3c55:	48 c7 05 30 18 01 00 	movq   $0x0,0x11830(%rip)        # 15490 <fwp_gc+0x1200>
    3c5c:	00 00 00 00 
    3c60:	e8 1b 02 00 00       	call   3e80 <fwp_gc_mark_all>
    3c65:	e8 36 07 00 00       	call   43a0 <fwp_gc_finalize>
    3c6a:	e8 c1 07 00 00       	call   4430 <fwp_gc_sweep>
    3c6f:	48 8b 05 f2 17 01 00 	mov    0x117f2(%rip),%rax        # 15468 <fwp_gc+0x11d8>
    3c76:	48 ff c0             	inc    %rax
    3c79:	48 89 05 e8 17 01 00 	mov    %rax,0x117e8(%rip)        # 15468 <fwp_gc+0x11d8>
    3c80:	eb 51                	jmp    3cd3 <fwp_gc_collect+0x103>
    3c82:	48 8d bd f0 fe ff ff 	lea    -0x110(%rbp),%rdi
    3c89:	e8 12 e6 ff ff       	call   22a0 <_setjmp@plt>
    3c8e:	48 c7 05 f7 17 01 00 	movq   $0x0,0x117f7(%rip)        # 15490 <fwp_gc+0x1200>
    3c95:	00 00 00 00 
    3c99:	e8 e2 01 00 00       	call   3e80 <fwp_gc_mark_all>
    3c9e:	e8 fd 01 00 00       	call   3ea0 <fwp_gc_scan_old_filled>
    3ca3:	83 3d ea 15 01 00 00 	cmpl   $0x0,0x115ea(%rip)        # 15294 <fwp_gc+0x1004>
    3caa:	74 05                	je     3cb1 <fwp_gc_collect+0xe1>
    3cac:	e8 2f 03 00 00       	call   3fe0 <fwp_gc_verify_minor>
    3cb1:	e8 ea 06 00 00       	call   43a0 <fwp_gc_finalize>
    3cb6:	e8 75 07 00 00       	call   4430 <fwp_gc_sweep>
    3cbb:	48 8b 05 a6 17 01 00 	mov    0x117a6(%rip),%rax        # 15468 <fwp_gc+0x11d8>
    3cc2:	48 ff c0             	inc    %rax
    3cc5:	48 89 05 9c 17 01 00 	mov    %rax,0x1179c(%rip)        # 15468 <fwp_gc+0x11d8>
    3ccc:	48 ff 05 d5 15 01 00 	incq   0x115d5(%rip)        # 152a8 <fwp_gc+0x1018>
    3cd3:	48 89 c1             	mov    %rax,%rcx
    3cd6:	48 8b 05 7b 17 01 00 	mov    0x1177b(%rip),%rax        # 15458 <fwp_gc+0x11c8>
    3cdd:	48 3b 05 7c 17 01 00 	cmp    0x1177c(%rip),%rax        # 15460 <fwp_gc+0x11d0>
    3ce4:	76 07                	jbe    3ced <fwp_gc_collect+0x11d>
    3ce6:	48 89 05 73 17 01 00 	mov    %rax,0x11773(%rip)        # 15460 <fwp_gc+0x11d0>
    3ced:	84 db                	test   %bl,%bl
    3cef:	74 0b                	je     3cfc <fwp_gc_collect+0x12c>
    3cf1:	48 89 05 a8 15 01 00 	mov    %rax,0x115a8(%rip)        # 152a0 <fwp_gc+0x1010>
    3cf8:	31 d2                	xor    %edx,%edx
    3cfa:	eb 2d                	jmp    3d29 <fwp_gc_collect+0x159>
    3cfc:	48 8b 15 9d 15 01 00 	mov    0x1159d(%rip),%rdx        # 152a0 <fwp_gc+0x1010>
    3d03:	48 89 d6             	mov    %rdx,%rsi
    3d06:	48 d1 ee             	shr    $1,%rsi
    3d09:	48 01 d6             	add    %rdx,%rsi
    3d0c:	48 81 fe 01 00 00 01 	cmp    $0x1000001,%rsi
    3d13:	ba 00 00 00 01       	mov    $0x1000000,%edx
    3d18:	48 0f 43 d6          	cmovae %rsi,%rdx
    3d1c:	31 f6                	xor    %esi,%esi
    3d1e:	48 39 d0             	cmp    %rdx,%rax
    3d21:	0f 97 c2             	seta   %dl
    3d24:	40 88 d6             	mov    %dl,%sil
    3d27:	89 f2                	mov    %esi,%edx
    3d29:	f6 c1 07             	test   $0x7,%cl
    3d2c:	b9 01 00 00 00       	mov    $0x1,%ecx
    3d31:	0f 45 ca             	cmovne %edx,%ecx
    3d34:	48 83 3d 74 15 01 00 	cmpq   $0x0,0x11574(%rip)        # 152b0 <fwp_gc+0x1020>
    3d3b:	00 
    3d3c:	0f 44 ca             	cmove  %edx,%ecx
    3d3f:	89 0d 53 15 01 00    	mov    %ecx,0x11553(%rip)        # 15298 <fwp_gc+0x1008>
    3d45:	83 3d 44 15 01 00 00 	cmpl   $0x0,0x11544(%rip)        # 15290 <fwp_gc+0x1000>
    3d4c:	0f 94 c1             	sete   %cl
    3d4f:	48 d3 e0             	shl    %cl,%rax
    3d52:	f2 48 0f 2c 0d 35 17 	cvttsd2si 0x11735(%rip),%rcx        # 15490 <fwp_gc+0x1200>
    3d59:	01 00 
    3d5b:	48 01 c1             	add    %rax,%rcx
    3d5e:	48 81 f9 01 00 80 00 	cmp    $0x800001,%rcx
    3d65:	b8 00 00 80 00       	mov    $0x800000,%eax
    3d6a:	48 0f 4d c1          	cmovge %rcx,%rax
    3d6e:	48 89 05 2b 17 01 00 	mov    %rax,0x1172b(%rip)        # 154a0 <fwp_gc+0x1210>
    3d75:	48 89 05 14 05 01 00 	mov    %rax,0x10514(%rip)        # 14290 <fwp_gc>
    3d7c:	48 8d 75 c8          	lea    -0x38(%rbp),%rsi
    3d80:	bf 01 00 00 00       	mov    $0x1,%edi
    3d85:	e8 96 e3 ff ff       	call   2120 <clock_gettime@plt>
    3d8a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    3d8e:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
    3d92:	48 2b 45 b8          	sub    -0x48(%rbp),%rax
    3d96:	f2 48 0f 2a c8       	cvtsi2sd %rax,%xmm1
    3d9b:	f2 0f 59 0d 7d a2 00 	mulsd  0xa27d(%rip),%xmm1        # e020 <_IO_stdin_used+0x20>
    3da2:	00 
    3da3:	48 2b 4d c0          	sub    -0x40(%rbp),%rcx
    3da7:	0f 57 c0             	xorps  %xmm0,%xmm0
    3daa:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    3daf:	f2 0f 5e 05 71 a2 00 	divsd  0xa271(%rip),%xmm0        # e028 <_IO_stdin_used+0x28>
    3db6:	00 
    3db7:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
    3dbb:	f2 0f 10 0d bd 16 01 	movsd  0x116bd(%rip),%xmm1        # 15480 <fwp_gc+0x11f0>
    3dc2:	00 
    3dc3:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
    3dc7:	f2 0f 11 0d b1 16 01 	movsd  %xmm1,0x116b1(%rip)        # 15480 <fwp_gc+0x11f0>
    3dce:	00 
    3dcf:	66 0f 2e 05 b1 16 01 	ucomisd 0x116b1(%rip),%xmm0        # 15488 <fwp_gc+0x11f8>
    3dd6:	00 
    3dd7:	48 8d a4 24 e8 00 00 	lea    0xe8(%rsp),%rsp
    3dde:	00 
    3ddf:	5b                   	pop    %rbx
    3de0:	41 5c                	pop    %r12
    3de2:	41 5d                	pop    %r13
    3de4:	41 5e                	pop    %r14
    3de6:	41 5f                	pop    %r15
    3de8:	5d                   	pop    %rbp
    3de9:	76 08                	jbe    3df3 <fwp_gc_collect+0x223>
    3deb:	f2 0f 11 05 95 16 01 	movsd  %xmm0,0x11695(%rip)        # 15488 <fwp_gc+0x11f8>
    3df2:	00 
    3df3:	c7 05 8b 14 01 00 00 	movl   $0x0,0x1148b(%rip)        # 15288 <fwp_gc+0xff8>
    3dfa:	00 00 00 
    3dfd:	c3                   	ret
    3dfe:	66 90                	xchg   %ax,%ax

0000000000003e00 <fwp_gc_clear_marks>:
    3e00:	48 8b 05 e1 14 01 00 	mov    0x114e1(%rip),%rax        # 152e8 <fwp_gc+0x1058>
    3e07:	48 85 c0             	test   %rax,%rax
    3e0a:	74 69                	je     3e75 <fwp_gc_clear_marks+0x75>
    3e0c:	41 56                	push   %r14
    3e0e:	53                   	push   %rbx
    3e0f:	50                   	push   %rax
    3e10:	48 8b 0d f1 14 01 00 	mov    0x114f1(%rip),%rcx        # 15308 <fwp_gc+0x1078>
    3e17:	31 db                	xor    %ebx,%ebx
    3e19:	45 31 f6             	xor    %r14d,%r14d
    3e1c:	eb 16                	jmp    3e34 <fwp_gc_clear_marks+0x34>
    3e1e:	66 90                	xchg   %ax,%ax
    3e20:	c6 44 19 03 00       	movb   $0x0,0x3(%rcx,%rbx,1)
    3e25:	49 ff c6             	inc    %r14
    3e28:	48 81 c3 28 12 00 00 	add    $0x1228,%rbx
    3e2f:	49 39 c6             	cmp    %rax,%r14
    3e32:	73 3a                	jae    3e6e <fwp_gc_clear_marks+0x6e>
    3e34:	0f b6 14 19          	movzbl (%rcx,%rbx,1),%edx
    3e38:	83 fa 02             	cmp    $0x2,%edx
    3e3b:	74 e3                	je     3e20 <fwp_gc_clear_marks+0x20>
    3e3d:	83 fa 01             	cmp    $0x1,%edx
    3e40:	75 e3                	jne    3e25 <fwp_gc_clear_marks+0x25>
    3e42:	48 8d 3c 19          	lea    (%rcx,%rbx,1),%rdi
    3e46:	48 83 c7 28          	add    $0x28,%rdi
    3e4a:	8b 54 19 0c          	mov    0xc(%rcx,%rbx,1),%edx
    3e4e:	83 c2 3f             	add    $0x3f,%edx
    3e51:	c1 ea 03             	shr    $0x3,%edx
    3e54:	83 e2 f8             	and    $0xfffffff8,%edx
    3e57:	31 f6                	xor    %esi,%esi
    3e59:	e8 a2 e3 ff ff       	call   2200 <memset@plt>
    3e5e:	48 8b 0d a3 14 01 00 	mov    0x114a3(%rip),%rcx        # 15308 <fwp_gc+0x1078>
    3e65:	48 8b 05 7c 14 01 00 	mov    0x1147c(%rip),%rax        # 152e8 <fwp_gc+0x1058>
    3e6c:	eb b7                	jmp    3e25 <fwp_gc_clear_marks+0x25>
    3e6e:	48 83 c4 08          	add    $0x8,%rsp
    3e72:	5b                   	pop    %rbx
    3e73:	41 5e                	pop    %r14
    3e75:	c3                   	ret
    3e76:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    3e7d:	00 00 00 

0000000000003e80 <fwp_gc_mark_all>:
    3e80:	50                   	push   %rax
    3e81:	e8 4a 0c 00 00       	call   4ad0 <fwp_gc_sp>
    3e86:	48 89 c7             	mov    %rax,%rdi
    3e89:	e8 32 0c 00 00       	call   4ac0 <fwp_gc_scan_stacks>
    3e8e:	e8 4d 0c 00 00       	call   4ae0 <fwp_gc_drain>
    3e93:	e8 98 0c 00 00       	call   4b30 <fwp_gc_scan_data>
    3e98:	58                   	pop    %rax
    3e99:	e9 42 0c 00 00       	jmp    4ae0 <fwp_gc_drain>
    3e9e:	66 90                	xchg   %ax,%ax

0000000000003ea0 <fwp_gc_scan_old_filled>:
    3ea0:	48 83 3d 40 14 01 00 	cmpq   $0x0,0x11440(%rip)        # 152e8 <fwp_gc+0x1058>
    3ea7:	00 
    3ea8:	0f 84 32 0c 00 00    	je     4ae0 <fwp_gc_drain>
    3eae:	55                   	push   %rbp
    3eaf:	41 57                	push   %r15
    3eb1:	41 56                	push   %r14
    3eb3:	41 55                	push   %r13
    3eb5:	41 54                	push   %r12
    3eb7:	53                   	push   %rbx
    3eb8:	48 83 ec 18          	sub    $0x18,%rsp
    3ebc:	31 c0                	xor    %eax,%eax
    3ebe:	eb 14                	jmp    3ed4 <fwp_gc_scan_old_filled+0x34>
    3ec0:	48 8b 04 24          	mov    (%rsp),%rax
    3ec4:	48 ff c0             	inc    %rax
    3ec7:	48 3b 05 1a 14 01 00 	cmp    0x1141a(%rip),%rax        # 152e8 <fwp_gc+0x1058>
    3ece:	0f 83 f6 00 00 00    	jae    3fca <fwp_gc_scan_old_filled+0x12a>
    3ed4:	48 8b 0d 2d 14 01 00 	mov    0x1142d(%rip),%rcx        # 15308 <fwp_gc+0x1078>
    3edb:	48 89 04 24          	mov    %rax,(%rsp)
    3edf:	48 69 e8 28 12 00 00 	imul   $0x1228,%rax,%rbp
    3ee6:	80 7c 29 01 02       	cmpb   $0x2,0x1(%rcx,%rbp,1)
    3eeb:	75 d3                	jne    3ec0 <fwp_gc_scan_old_filled+0x20>
    3eed:	48 89 cb             	mov    %rcx,%rbx
    3ef0:	0f b6 04 29          	movzbl (%rcx,%rbp,1),%eax
    3ef4:	83 f8 02             	cmp    $0x2,%eax
    3ef7:	0f 84 a7 00 00 00    	je     3fa4 <fwp_gc_scan_old_filled+0x104>
    3efd:	83 f8 01             	cmp    $0x1,%eax
    3f00:	75 be                	jne    3ec0 <fwp_gc_scan_old_filled+0x20>
    3f02:	48 8b 3c 24          	mov    (%rsp),%rdi
    3f06:	e8 c5 ef ff ff       	call   2ed0 <fwp_gc_chunk_addr>
    3f0b:	49 89 c6             	mov    %rax,%r14
    3f0e:	8b 44 2b 0c          	mov    0xc(%rbx,%rbp,1),%eax
    3f12:	83 c0 3f             	add    $0x3f,%eax
    3f15:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    3f1a:	83 f8 40             	cmp    $0x40,%eax
    3f1d:	72 a1                	jb     3ec0 <fwp_gc_scan_old_filled+0x20>
    3f1f:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    3f24:	c1 e8 06             	shr    $0x6,%eax
    3f27:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    3f2c:	4c 8d 2c 2b          	lea    (%rbx,%rbp,1),%r13
    3f30:	49 83 c5 08          	add    $0x8,%r13
    3f34:	48 01 eb             	add    %rbp,%rbx
    3f37:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
    3f3c:	45 31 ff             	xor    %r15d,%r15d
    3f3f:	eb 1d                	jmp    3f5e <fwp_gc_scan_old_filled+0xbe>
    3f41:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3f48:	0f 1f 84 00 00 00 00 
    3f4f:	00 
    3f50:	49 ff c7             	inc    %r15
    3f53:	4c 3b 7c 24 08       	cmp    0x8(%rsp),%r15
    3f58:	0f 84 62 ff ff ff    	je     3ec0 <fwp_gc_scan_old_filled+0x20>
    3f5e:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    3f63:	4e 8b 64 f8 28       	mov    0x28(%rax,%r15,8),%r12
    3f68:	4d 85 e4             	test   %r12,%r12
    3f6b:	74 e3                	je     3f50 <fwp_gc_scan_old_filled+0xb0>
    3f6d:	4c 89 fd             	mov    %r15,%rbp
    3f70:	48 c1 e5 06          	shl    $0x6,%rbp
    3f74:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    3f7b:	00 00 00 00 00 
    3f80:	f3 49 0f bc fc       	tzcnt  %r12,%rdi
    3f85:	48 09 ef             	or     %rbp,%rdi
    3f88:	49 8d 5c 24 ff       	lea    -0x1(%r12),%rbx
    3f8d:	41 8b 75 00          	mov    0x0(%r13),%esi
    3f91:	48 0f af fe          	imul   %rsi,%rdi
    3f95:	4c 01 f7             	add    %r14,%rdi
    3f98:	e8 03 0e 00 00       	call   4da0 <fwp_gc_push>
    3f9d:	49 21 dc             	and    %rbx,%r12
    3fa0:	75 de                	jne    3f80 <fwp_gc_scan_old_filled+0xe0>
    3fa2:	eb ac                	jmp    3f50 <fwp_gc_scan_old_filled+0xb0>
    3fa4:	80 7c 2b 03 00       	cmpb   $0x0,0x3(%rbx,%rbp,1)
    3fa9:	0f 84 11 ff ff ff    	je     3ec0 <fwp_gc_scan_old_filled+0x20>
    3faf:	48 8b 3c 24          	mov    (%rsp),%rdi
    3fb3:	e8 18 ef ff ff       	call   2ed0 <fwp_gc_chunk_addr>
    3fb8:	48 8b 74 2b 18       	mov    0x18(%rbx,%rbp,1),%rsi
    3fbd:	48 89 c7             	mov    %rax,%rdi
    3fc0:	e8 db 0d 00 00       	call   4da0 <fwp_gc_push>
    3fc5:	e9 f6 fe ff ff       	jmp    3ec0 <fwp_gc_scan_old_filled+0x20>
    3fca:	48 83 c4 18          	add    $0x18,%rsp
    3fce:	5b                   	pop    %rbx
    3fcf:	41 5c                	pop    %r12
    3fd1:	41 5d                	pop    %r13
    3fd3:	41 5e                	pop    %r14
    3fd5:	41 5f                	pop    %r15
    3fd7:	5d                   	pop    %rbp
    3fd8:	e9 03 0b 00 00       	jmp    4ae0 <fwp_gc_drain>
    3fdd:	0f 1f 00             	nopl   (%rax)

0000000000003fe0 <fwp_gc_verify_minor>:
    3fe0:	55                   	push   %rbp
    3fe1:	41 57                	push   %r15
    3fe3:	41 56                	push   %r14
    3fe5:	41 55                	push   %r13
    3fe7:	41 54                	push   %r12
    3fe9:	53                   	push   %rbx
    3fea:	48 83 ec 58          	sub    $0x58,%rsp
    3fee:	4c 8b 2d f3 12 01 00 	mov    0x112f3(%rip),%r13        # 152e8 <fwp_gc+0x1058>
    3ff5:	4c 89 ef             	mov    %r13,%rdi
    3ff8:	48 c1 e7 09          	shl    $0x9,%rdi
    3ffc:	e8 2f e3 ff ff       	call   2330 <malloc@plt>
    4001:	48 89 c3             	mov    %rax,%rbx
    4004:	49 83 fd 01          	cmp    $0x1,%r13
    4008:	4c 89 ef             	mov    %r13,%rdi
    400b:	48 83 d7 00          	adc    $0x0,%rdi
    400f:	48 89 7c 24 30       	mov    %rdi,0x30(%rsp)
    4014:	e8 17 e3 ff ff       	call   2330 <malloc@plt>
    4019:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
    401e:	48 85 db             	test   %rbx,%rbx
    4021:	0f 84 74 03 00 00    	je     439b <fwp_gc_verify_minor+0x3bb>
    4027:	49 89 c7             	mov    %rax,%r15
    402a:	48 85 c0             	test   %rax,%rax
    402d:	0f 84 68 03 00 00    	je     439b <fwp_gc_verify_minor+0x3bb>
    4033:	4d 85 ed             	test   %r13,%r13
    4036:	74 1c                	je     4054 <fwp_gc_verify_minor+0x74>
    4038:	48 8b 0d c9 12 01 00 	mov    0x112c9(%rip),%rcx        # 15308 <fwp_gc+0x1078>
    403f:	49 83 fd 01          	cmp    $0x1,%r13
    4043:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
    4048:	75 19                	jne    4063 <fwp_gc_verify_minor+0x83>
    404a:	4d 89 ec             	mov    %r13,%r12
    404d:	31 ed                	xor    %ebp,%ebp
    404f:	e9 81 00 00 00       	jmp    40d5 <fwp_gc_verify_minor+0xf5>
    4054:	e8 a7 fd ff ff       	call   3e00 <fwp_gc_clear_marks>
    4059:	e8 22 fe ff ff       	call   3e80 <fwp_gc_mark_all>
    405e:	e9 13 03 00 00       	jmp    4376 <fwp_gc_verify_minor+0x396>
    4063:	4d 89 ec             	mov    %r13,%r12
    4066:	49 83 e5 fe          	and    $0xfffffffffffffffe,%r13
    406a:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    406f:	48 8d 98 00 02 00 00 	lea    0x200(%rax),%rbx
    4076:	4c 8d b1 50 12 00 00 	lea    0x1250(%rcx),%r14
    407d:	31 ed                	xor    %ebp,%ebp
    407f:	90                   	nop
    4080:	48 8d bb 00 fe ff ff 	lea    -0x200(%rbx),%rdi
    4087:	49 8d b6 d8 ed ff ff 	lea    -0x1228(%r14),%rsi
    408e:	ba 00 02 00 00       	mov    $0x200,%edx
    4093:	e8 88 e2 ff ff       	call   2320 <memcpy@plt>
    4098:	41 0f b6 86 b3 ed ff 	movzbl -0x124d(%r14),%eax
    409f:	ff 
    40a0:	41 88 04 2f          	mov    %al,(%r15,%rbp,1)
    40a4:	ba 00 02 00 00       	mov    $0x200,%edx
    40a9:	48 89 df             	mov    %rbx,%rdi
    40ac:	4c 89 f6             	mov    %r14,%rsi
    40af:	e8 6c e2 ff ff       	call   2320 <memcpy@plt>
    40b4:	41 0f b6 46 db       	movzbl -0x25(%r14),%eax
    40b9:	41 88 44 2f 01       	mov    %al,0x1(%r15,%rbp,1)
    40be:	48 83 c5 02          	add    $0x2,%rbp
    40c2:	48 81 c3 00 04 00 00 	add    $0x400,%rbx
    40c9:	49 81 c6 50 24 00 00 	add    $0x2450,%r14
    40d0:	49 39 ed             	cmp    %rbp,%r13
    40d3:	75 ab                	jne    4080 <fwp_gc_verify_minor+0xa0>
    40d5:	4d 89 e5             	mov    %r12,%r13
    40d8:	41 f6 c5 01          	test   $0x1,%r13b
    40dc:	74 34                	je     4112 <fwp_gc_verify_minor+0x132>
    40de:	48 89 ef             	mov    %rbp,%rdi
    40e1:	48 c1 e7 09          	shl    $0x9,%rdi
    40e5:	48 03 7c 24 20       	add    0x20(%rsp),%rdi
    40ea:	48 69 dd 28 12 00 00 	imul   $0x1228,%rbp,%rbx
    40f1:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    40f6:	49 8d 34 1e          	lea    (%r14,%rbx,1),%rsi
    40fa:	48 83 c6 28          	add    $0x28,%rsi
    40fe:	ba 00 02 00 00       	mov    $0x200,%edx
    4103:	e8 18 e2 ff ff       	call   2320 <memcpy@plt>
    4108:	41 0f b6 44 1e 03    	movzbl 0x3(%r14,%rbx,1),%eax
    410e:	41 88 04 2f          	mov    %al,(%r15,%rbp,1)
    4112:	e8 e9 fc ff ff       	call   3e00 <fwp_gc_clear_marks>
    4117:	e8 64 fd ff ff       	call   3e80 <fwp_gc_mark_all>
    411c:	4d 85 ed             	test   %r13,%r13
    411f:	0f 84 51 02 00 00    	je     4376 <fwp_gc_verify_minor+0x396>
    4125:	48 8b 1d dc 11 01 00 	mov    0x111dc(%rip),%rbx        # 15308 <fwp_gc+0x1078>
    412c:	48 8d 43 28          	lea    0x28(%rbx),%rax
    4130:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    4135:	31 ff                	xor    %edi,%edi
    4137:	eb 30                	jmp    4169 <fwp_gc_verify_minor+0x189>
    4139:	4d 85 c9             	test   %r9,%r9
    413c:	0f 85 b8 00 00 00    	jne    41fa <fwp_gc_verify_minor+0x21a>
    4142:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4149:	1f 84 00 00 00 00 00 
    4150:	48 ff c7             	inc    %rdi
    4153:	48 81 c1 00 02 00 00 	add    $0x200,%rcx
    415a:	48 05 28 12 00 00    	add    $0x1228,%rax
    4160:	4c 39 ef             	cmp    %r13,%rdi
    4163:	0f 84 0d 02 00 00    	je     4376 <fwp_gc_verify_minor+0x396>
    4169:	4c 69 f7 28 12 00 00 	imul   $0x1228,%rdi,%r14
    4170:	42 0f b6 2c 33       	movzbl (%rbx,%r14,1),%ebp
    4175:	83 fd 02             	cmp    $0x2,%ebp
    4178:	74 66                	je     41e0 <fwp_gc_verify_minor+0x200>
    417a:	83 fd 01             	cmp    $0x1,%ebp
    417d:	75 d1                	jne    4150 <fwp_gc_verify_minor+0x170>
    417f:	42 8b 54 33 0c       	mov    0xc(%rbx,%r14,1),%edx
    4184:	83 c2 3f             	add    $0x3f,%edx
    4187:	83 fa 40             	cmp    $0x40,%edx
    418a:	72 c4                	jb     4150 <fwp_gc_verify_minor+0x170>
    418c:	c1 ea 06             	shr    $0x6,%edx
    418f:	31 f6                	xor    %esi,%esi
    4191:	45 31 e4             	xor    %r12d,%r12d
    4194:	45 31 c0             	xor    %r8d,%r8d
    4197:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    419e:	00 00 
    41a0:	4e 8b 0c c1          	mov    (%rcx,%r8,8),%r9
    41a4:	49 f7 d1             	not    %r9
    41a7:	4e 23 0c c0          	and    (%rax,%r8,8),%r9
    41ab:	4d 89 e2             	mov    %r12,%r10
    41ae:	f3 4d 0f bc e1       	tzcnt  %r9,%r12
    41b3:	49 01 f4             	add    %rsi,%r12
    41b6:	4d 85 c9             	test   %r9,%r9
    41b9:	4d 0f 44 e2          	cmove  %r10,%r12
    41bd:	49 ff c0             	inc    %r8
    41c0:	49 39 d0             	cmp    %rdx,%r8
    41c3:	0f 83 70 ff ff ff    	jae    4139 <fwp_gc_verify_minor+0x159>
    41c9:	48 83 c6 40          	add    $0x40,%rsi
    41cd:	4d 85 c9             	test   %r9,%r9
    41d0:	74 ce                	je     41a0 <fwp_gc_verify_minor+0x1c0>
    41d2:	e9 62 ff ff ff       	jmp    4139 <fwp_gc_verify_minor+0x159>
    41d7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    41de:	00 00 
    41e0:	42 80 7c 33 03 00    	cmpb   $0x0,0x3(%rbx,%r14,1)
    41e6:	0f 84 64 ff ff ff    	je     4150 <fwp_gc_verify_minor+0x170>
    41ec:	41 80 3c 3f 00       	cmpb   $0x0,(%r15,%rdi,1)
    41f1:	0f 85 59 ff ff ff    	jne    4150 <fwp_gc_verify_minor+0x170>
    41f7:	45 31 e4             	xor    %r12d,%r12d
    41fa:	e8 d1 ec ff ff       	call   2ed0 <fwp_gc_chunk_addr>
    41ff:	46 8b 7c 33 08       	mov    0x8(%rbx,%r14,1),%r15d
    4204:	4d 0f af e7          	imul   %r15,%r12
    4208:	49 01 c4             	add    %rax,%r12
    420b:	40 80 fd 01          	cmp    $0x1,%bpl
    420f:	74 05                	je     4216 <fwp_gc_verify_minor+0x236>
    4211:	4e 8b 7c 33 18       	mov    0x18(%rbx,%r14,1),%r15
    4216:	48 8b 05 c3 fd 00 00 	mov    0xfdc3(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    421d:	48 8b 38             	mov    (%rax),%rdi
    4220:	42 0f b6 4c 33 01    	movzbl 0x1(%rbx,%r14,1),%ecx
    4226:	48 8d 35 77 a5 00 00 	lea    0xa577(%rip),%rsi        # e7a4 <exec_in_fp0+0x144>
    422d:	4c 89 e2             	mov    %r12,%rdx
    4230:	4d 89 f8             	mov    %r15,%r8
    4233:	31 c0                	xor    %eax,%eax
    4235:	e8 a6 e0 ff ff       	call   22e0 <fprintf@plt>
    423a:	4d 01 e7             	add    %r12,%r15
    423d:	45 31 ed             	xor    %r13d,%r13d
    4240:	4c 89 7c 24 40       	mov    %r15,0x40(%rsp)
    4245:	eb 17                	jmp    425e <fwp_gc_verify_minor+0x27e>
    4247:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    424e:	00 00 
    4250:	49 ff c5             	inc    %r13
    4253:	4c 3b 6c 24 30       	cmp    0x30(%rsp),%r13
    4258:	0f 84 38 01 00 00    	je     4396 <fwp_gc_verify_minor+0x3b6>
    425e:	48 8b 05 a3 10 01 00 	mov    0x110a3(%rip),%rax        # 15308 <fwp_gc+0x1078>
    4265:	49 69 cd 28 12 00 00 	imul   $0x1228,%r13,%rcx
    426c:	80 3c 08 01          	cmpb   $0x1,(%rax,%rcx,1)
    4270:	75 de                	jne    4250 <fwp_gc_verify_minor+0x270>
    4272:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    4277:	74 d7                	je     4250 <fwp_gc_verify_minor+0x270>
    4279:	8b 5c 08 0c          	mov    0xc(%rax,%rcx,1),%ebx
    427d:	85 db                	test   %ebx,%ebx
    427f:	74 cf                	je     4250 <fwp_gc_verify_minor+0x270>
    4281:	48 01 c8             	add    %rcx,%rax
    4284:	48 ff c0             	inc    %rax
    4287:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    428c:	4c 89 e8             	mov    %r13,%rax
    428f:	48 c1 e0 09          	shl    $0x9,%rax
    4293:	48 03 44 24 20       	add    0x20(%rsp),%rax
    4298:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    429d:	31 ed                	xor    %ebp,%ebp
    429f:	4c 89 6c 24 38       	mov    %r13,0x38(%rsp)
    42a4:	eb 21                	jmp    42c7 <fwp_gc_verify_minor+0x2e7>
    42a6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    42ad:	00 00 00 
    42b0:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    42b5:	8b 58 0b             	mov    0xb(%rax),%ebx
    42b8:	4c 8b 6c 24 38       	mov    0x38(%rsp),%r13
    42bd:	48 ff c5             	inc    %rbp
    42c0:	89 d8                	mov    %ebx,%eax
    42c2:	48 39 c5             	cmp    %rax,%rbp
    42c5:	73 89                	jae    4250 <fwp_gc_verify_minor+0x270>
    42c7:	48 89 e8             	mov    %rbp,%rax
    42ca:	48 c1 e8 06          	shr    $0x6,%rax
    42ce:	48 8b 4c 24 50       	mov    0x50(%rsp),%rcx
    42d3:	48 8b 04 c1          	mov    (%rcx,%rax,8),%rax
    42d7:	48 0f a3 e8          	bt     %rbp,%rax
    42db:	73 e0                	jae    42bd <fwp_gc_verify_minor+0x2dd>
    42dd:	4c 89 ef             	mov    %r13,%rdi
    42e0:	e8 eb eb ff ff       	call   2ed0 <fwp_gc_chunk_addr>
    42e5:	48 89 c2             	mov    %rax,%rdx
    42e8:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    42ed:	44 8b 70 07          	mov    0x7(%rax),%r14d
    42f1:	49 83 fe 08          	cmp    $0x8,%r14
    42f5:	72 c6                	jb     42bd <fwp_gc_verify_minor+0x2dd>
    42f7:	45 89 f0             	mov    %r14d,%r8d
    42fa:	4c 0f af f5          	imul   %rbp,%r14
    42fe:	48 89 d3             	mov    %rdx,%rbx
    4301:	4c 01 f3             	add    %r14,%rbx
    4304:	45 31 ed             	xor    %r13d,%r13d
    4307:	48 89 54 24 48       	mov    %rdx,0x48(%rsp)
    430c:	eb 10                	jmp    431e <fwp_gc_verify_minor+0x33e>
    430e:	66 90                	xchg   %ax,%ax
    4310:	49 ff c5             	inc    %r13
    4313:	44 89 c0             	mov    %r8d,%eax
    4316:	c1 e8 03             	shr    $0x3,%eax
    4319:	49 39 c5             	cmp    %rax,%r13
    431c:	73 92                	jae    42b0 <fwp_gc_verify_minor+0x2d0>
    431e:	4a 8b 04 eb          	mov    (%rbx,%r13,8),%rax
    4322:	4c 39 e0             	cmp    %r12,%rax
    4325:	72 e9                	jb     4310 <fwp_gc_verify_minor+0x330>
    4327:	4c 39 f8             	cmp    %r15,%rax
    432a:	73 e4                	jae    4310 <fwp_gc_verify_minor+0x330>
    432c:	48 8b 05 ad fc 00 00 	mov    0xfcad(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    4333:	48 8b 38             	mov    (%rax),%rdi
    4336:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
    433b:	41 0f b6 0f          	movzbl (%r15),%ecx
    433f:	42 0f 10 04 32       	movups (%rdx,%r14,1),%xmm0
    4344:	4a 8b 44 32 10       	mov    0x10(%rdx,%r14,1),%rax
    4349:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    434e:	0f 11 04 24          	movups %xmm0,(%rsp)
    4352:	48 8d 35 a5 a4 00 00 	lea    0xa4a5(%rip),%rsi        # e7fe <exec_in_fp0+0x19e>
    4359:	48 89 da             	mov    %rbx,%rdx
    435c:	4d 89 e9             	mov    %r13,%r9
    435f:	31 c0                	xor    %eax,%eax
    4361:	e8 7a df ff ff       	call   22e0 <fprintf@plt>
    4366:	48 8b 54 24 48       	mov    0x48(%rsp),%rdx
    436b:	45 8b 47 07          	mov    0x7(%r15),%r8d
    436f:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
    4374:	eb 9a                	jmp    4310 <fwp_gc_verify_minor+0x330>
    4376:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    437b:	e8 d0 dc ff ff       	call   2050 <free@plt>
    4380:	4c 89 ff             	mov    %r15,%rdi
    4383:	48 83 c4 58          	add    $0x58,%rsp
    4387:	5b                   	pop    %rbx
    4388:	41 5c                	pop    %r12
    438a:	41 5d                	pop    %r13
    438c:	41 5e                	pop    %r14
    438e:	41 5f                	pop    %r15
    4390:	5d                   	pop    %rbp
    4391:	e9 ba dc ff ff       	jmp    2050 <free@plt>
    4396:	e8 d5 dc ff ff       	call   2070 <abort@plt>
    439b:	e8 80 f6 ff ff       	call   3a20 <fwp_gc_oom>

00000000000043a0 <fwp_gc_finalize>:
    43a0:	41 57                	push   %r15
    43a2:	41 56                	push   %r14
    43a4:	41 55                	push   %r13
    43a6:	41 54                	push   %r12
    43a8:	53                   	push   %rbx
    43a9:	4c 8b 3d 98 10 01 00 	mov    0x11098(%rip),%r15        # 15448 <fwp_gc+0x11b8>
    43b0:	4d 85 ff             	test   %r15,%r15
    43b3:	74 71                	je     4426 <fwp_gc_finalize+0x86>
    43b5:	4c 8b 25 84 10 01 00 	mov    0x11084(%rip),%r12        # 15440 <fwp_gc+0x11b0>
    43bc:	45 31 f6             	xor    %r14d,%r14d
    43bf:	eb 46                	jmp    4407 <fwp_gc_finalize+0x67>
    43c1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    43c8:	0f 1f 84 00 00 00 00 
    43cf:	00 
    43d0:	4d 01 e5             	add    %r12,%r13
    43d3:	49 8b 45 08          	mov    0x8(%r13),%rax
    43d7:	49 ff cf             	dec    %r15
    43da:	4c 89 3d 67 10 01 00 	mov    %r15,0x11067(%rip)        # 15448 <fwp_gc+0x11b8>
    43e1:	49 c1 e7 04          	shl    $0x4,%r15
    43e5:	43 0f 10 04 3c       	movups (%r12,%r15,1),%xmm0
    43ea:	41 0f 11 45 00       	movups %xmm0,0x0(%r13)
    43ef:	48 89 df             	mov    %rbx,%rdi
    43f2:	ff d0                	call   *%rax
    43f4:	4c 8b 25 45 10 01 00 	mov    0x11045(%rip),%r12        # 15440 <fwp_gc+0x11b0>
    43fb:	4c 8b 3d 46 10 01 00 	mov    0x11046(%rip),%r15        # 15448 <fwp_gc+0x11b8>
    4402:	4d 39 fe             	cmp    %r15,%r14
    4405:	73 1f                	jae    4426 <fwp_gc_finalize+0x86>
    4407:	4d 89 f5             	mov    %r14,%r13
    440a:	49 c1 e5 04          	shl    $0x4,%r13
    440e:	4b 8b 1c 2c          	mov    (%r12,%r13,1),%rbx
    4412:	48 89 df             	mov    %rbx,%rdi
    4415:	e8 06 0a 00 00       	call   4e20 <fwp_gc_marked>
    441a:	85 c0                	test   %eax,%eax
    441c:	74 b2                	je     43d0 <fwp_gc_finalize+0x30>
    441e:	49 ff c6             	inc    %r14
    4421:	4d 39 fe             	cmp    %r15,%r14
    4424:	72 e1                	jb     4407 <fwp_gc_finalize+0x67>
    4426:	5b                   	pop    %rbx
    4427:	41 5c                	pop    %r12
    4429:	41 5d                	pop    %r13
    442b:	41 5e                	pop    %r14
    442d:	41 5f                	pop    %r15
    442f:	c3                   	ret

0000000000004430 <fwp_gc_sweep>:
    4430:	55                   	push   %rbp
    4431:	41 57                	push   %r15
    4433:	41 56                	push   %r14
    4435:	41 55                	push   %r13
    4437:	41 54                	push   %r12
    4439:	53                   	push   %rbx
    443a:	48 83 ec 28          	sub    $0x28,%rsp
    443e:	48 8d 3d 53 fe 00 00 	lea    0xfe53(%rip),%rdi        # 14298 <fwp_gc+0x8>
    4445:	45 31 ff             	xor    %r15d,%r15d
    4448:	ba 40 0b 00 00       	mov    $0xb40,%edx
    444d:	31 f6                	xor    %esi,%esi
    444f:	e8 ac dd ff ff       	call   2200 <memset@plt>
    4454:	48 83 3d 8c 0e 01 00 	cmpq   $0x0,0x10e8c(%rip)        # 152e8 <fwp_gc+0x1058>
    445b:	00 
    445c:	0f 84 06 05 00 00    	je     4968 <fwp_gc_sweep+0x538>
    4462:	31 c0                	xor    %eax,%eax
    4464:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    4469:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    4470:	55 55 55 
    4473:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    447a:	33 33 33 
    447d:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    4484:	0f 0f 0f 
    4487:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    448e:	01 01 01 
    4491:	66 0f 6f 2d 57 9c 00 	movdqa 0x9c57(%rip),%xmm5        # e0f0 <_IO_stdin_used+0xf0>
    4498:	00 
    4499:	66 0f 6f 35 5f 9c 00 	movdqa 0x9c5f(%rip),%xmm6        # e100 <_IO_stdin_used+0x100>
    44a0:	00 
    44a1:	66 0f 6f 3d 67 9c 00 	movdqa 0x9c67(%rip),%xmm7        # e110 <_IO_stdin_used+0x110>
    44a8:	00 
    44a9:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    44ae:	45 31 ff             	xor    %r15d,%r15d
    44b1:	31 db                	xor    %ebx,%ebx
    44b3:	eb 63                	jmp    4518 <fwp_gc_sweep+0xe8>
    44b5:	4c 8b 64 24 10       	mov    0x10(%rsp),%r12
    44ba:	4c 89 e7             	mov    %r12,%rdi
    44bd:	e8 ee 09 00 00       	call   4eb0 <fwp_rc_clear_chunk>
    44c2:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    44c7:	66 0f 6f 3d 41 9c 00 	movdqa 0x9c41(%rip),%xmm7        # e110 <_IO_stdin_used+0x110>
    44ce:	00 
    44cf:	66 0f 6f 35 29 9c 00 	movdqa 0x9c29(%rip),%xmm6        # e100 <_IO_stdin_used+0x100>
    44d6:	00 
    44d7:	66 0f 6f 2d 11 9c 00 	movdqa 0x9c11(%rip),%xmm5        # e0f0 <_IO_stdin_used+0xf0>
    44de:	00 
    44df:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    44e6:	01 01 01 
    44e9:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    44f0:	0f 0f 0f 
    44f3:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    44fa:	33 33 33 
    44fd:	41 c6 04 24 00       	movb   $0x0,(%r12)
    4502:	49 ff c7             	inc    %r15
    4505:	48 ff c3             	inc    %rbx
    4508:	48 8b 05 d9 0d 01 00 	mov    0x10dd9(%rip),%rax        # 152e8 <fwp_gc+0x1058>
    450f:	48 39 c3             	cmp    %rax,%rbx
    4512:	0f 83 59 04 00 00    	jae    4971 <fwp_gc_sweep+0x541>
    4518:	4c 8b 2d e9 0d 01 00 	mov    0x10de9(%rip),%r13        # 15308 <fwp_gc+0x1078>
    451f:	4c 69 e3 28 12 00 00 	imul   $0x1228,%rbx,%r12
    4526:	43 0f b6 44 25 00    	movzbl 0x0(%r13,%r12,1),%eax
    452c:	85 c0                	test   %eax,%eax
    452e:	74 d2                	je     4502 <fwp_gc_sweep+0xd2>
    4530:	83 f8 01             	cmp    $0x1,%eax
    4533:	74 2b                	je     4560 <fwp_gc_sweep+0x130>
    4535:	83 f8 02             	cmp    $0x2,%eax
    4538:	75 cb                	jne    4505 <fwp_gc_sweep+0xd5>
    453a:	47 8b 74 25 10       	mov    0x10(%r13,%r12,1),%r14d
    453f:	43 80 7c 25 03 00    	cmpb   $0x0,0x3(%r13,%r12,1)
    4545:	74 4c                	je     4593 <fwp_gc_sweep+0x163>
    4547:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    454c:	4b 03 44 25 18       	add    0x18(%r13,%r12,1),%rax
    4551:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    4556:	e9 f8 03 00 00       	jmp    4953 <fwp_gc_sweep+0x523>
    455b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    4560:	4b 8d 04 2c          	lea    (%r12,%r13,1),%rax
    4564:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    4569:	43 8b 6c 25 0c       	mov    0xc(%r13,%r12,1),%ebp
    456e:	48 85 ed             	test   %rbp,%rbp
    4571:	0f 84 3e ff ff ff    	je     44b5 <fwp_gc_sweep+0x85>
    4577:	48 8d 55 3f          	lea    0x3f(%rbp),%rdx
    457b:	48 89 d0             	mov    %rdx,%rax
    457e:	48 c1 e8 06          	shr    $0x6,%rax
    4582:	81 fd c1 00 00 00    	cmp    $0xc1,%ebp
    4588:	73 75                	jae    45ff <fwp_gc_sweep+0x1cf>
    458a:	31 d2                	xor    %edx,%edx
    458c:	31 c9                	xor    %ecx,%ecx
    458e:	e9 3c 01 00 00       	jmp    46cf <fwp_gc_sweep+0x29f>
    4593:	4b 8d 3c 2c          	lea    (%r12,%r13,1),%rdi
    4597:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    459e:	e8 0d e9 ff ff       	call   2eb0 <fwp_rc_clear_slot>
    45a3:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    45a8:	66 0f 6f 3d 60 9b 00 	movdqa 0x9b60(%rip),%xmm7        # e110 <_IO_stdin_used+0x110>
    45af:	00 
    45b0:	66 0f 6f 35 48 9b 00 	movdqa 0x9b48(%rip),%xmm6        # e100 <_IO_stdin_used+0x100>
    45b7:	00 
    45b8:	66 0f 6f 2d 30 9b 00 	movdqa 0x9b30(%rip),%xmm5        # e0f0 <_IO_stdin_used+0xf0>
    45bf:	00 
    45c0:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    45c7:	01 01 01 
    45ca:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    45d1:	0f 0f 0f 
    45d4:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    45db:	33 33 33 
    45de:	4d 85 f6             	test   %r14,%r14
    45e1:	0f 84 69 03 00 00    	je     4950 <fwp_gc_sweep+0x520>
    45e7:	48 8b 05 1a 0d 01 00 	mov    0x10d1a(%rip),%rax        # 15308 <fwp_gc+0x1078>
    45ee:	41 83 fe 04          	cmp    $0x4,%r14d
    45f2:	0f 83 e6 02 00 00    	jae    48de <fwp_gc_sweep+0x4ae>
    45f8:	31 c9                	xor    %ecx,%ecx
    45fa:	e9 19 03 00 00       	jmp    4918 <fwp_gc_sweep+0x4e8>
    45ff:	89 c1                	mov    %eax,%ecx
    4601:	83 e1 fc             	and    $0xfffffffc,%ecx
    4604:	4b 8d 34 2c          	lea    (%r12,%r13,1),%rsi
    4608:	48 83 c6 38          	add    $0x38,%rsi
    460c:	48 c1 ea 03          	shr    $0x3,%rdx
    4610:	83 e2 e0             	and    $0xffffffe0,%edx
    4613:	66 0f ef c0          	pxor   %xmm0,%xmm0
    4617:	31 ff                	xor    %edi,%edi
    4619:	66 0f ef c9          	pxor   %xmm1,%xmm1
    461d:	0f 1f 00             	nopl   (%rax)
    4620:	f3 0f 6f 5c 3e f0    	movdqu -0x10(%rsi,%rdi,1),%xmm3
    4626:	f3 0f 6f 14 3e       	movdqu (%rsi,%rdi,1),%xmm2
    462b:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    462f:	66 0f 71 d4 01       	psrlw  $0x1,%xmm4
    4634:	66 0f db e5          	pand   %xmm5,%xmm4
    4638:	66 0f f8 dc          	psubb  %xmm4,%xmm3
    463c:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    4640:	66 0f db e6          	pand   %xmm6,%xmm4
    4644:	66 0f 71 d3 02       	psrlw  $0x2,%xmm3
    4649:	66 0f db de          	pand   %xmm6,%xmm3
    464d:	66 0f fc dc          	paddb  %xmm4,%xmm3
    4651:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    4655:	66 0f 71 d4 04       	psrlw  $0x4,%xmm4
    465a:	66 0f fc e3          	paddb  %xmm3,%xmm4
    465e:	66 0f db e7          	pand   %xmm7,%xmm4
    4662:	66 41 0f f6 e0       	psadbw %xmm8,%xmm4
    4667:	66 0f d4 c4          	paddq  %xmm4,%xmm0
    466b:	66 0f 6f da          	movdqa %xmm2,%xmm3
    466f:	66 0f 71 d3 01       	psrlw  $0x1,%xmm3
    4674:	66 0f db dd          	pand   %xmm5,%xmm3
    4678:	66 0f f8 d3          	psubb  %xmm3,%xmm2
    467c:	66 0f 6f da          	movdqa %xmm2,%xmm3
    4680:	66 0f db de          	pand   %xmm6,%xmm3
    4684:	66 0f 71 d2 02       	psrlw  $0x2,%xmm2
    4689:	66 0f db d6          	pand   %xmm6,%xmm2
    468d:	66 0f fc d3          	paddb  %xmm3,%xmm2
    4691:	66 0f 6f da          	movdqa %xmm2,%xmm3
    4695:	66 0f 71 d3 04       	psrlw  $0x4,%xmm3
    469a:	66 0f fc da          	paddb  %xmm2,%xmm3
    469e:	66 0f db df          	pand   %xmm7,%xmm3
    46a2:	66 41 0f f6 d8       	psadbw %xmm8,%xmm3
    46a7:	66 0f d4 cb          	paddq  %xmm3,%xmm1
    46ab:	48 83 c7 20          	add    $0x20,%rdi
    46af:	48 39 fa             	cmp    %rdi,%rdx
    46b2:	0f 85 68 ff ff ff    	jne    4620 <fwp_gc_sweep+0x1f0>
    46b8:	66 0f d4 c8          	paddq  %xmm0,%xmm1
    46bc:	66 0f 70 c1 ee       	pshufd $0xee,%xmm1,%xmm0
    46c1:	66 0f d4 c1          	paddq  %xmm1,%xmm0
    46c5:	66 48 0f 7e c2       	movq   %xmm0,%rdx
    46ca:	48 39 c8             	cmp    %rcx,%rax
    46cd:	74 51                	je     4720 <fwp_gc_sweep+0x2f0>
    46cf:	4b 8d 34 2c          	lea    (%r12,%r13,1),%rsi
    46d3:	48 83 c6 28          	add    $0x28,%rsi
    46d7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    46de:	00 00 
    46e0:	48 8b 3c ce          	mov    (%rsi,%rcx,8),%rdi
    46e4:	49 89 f8             	mov    %rdi,%r8
    46e7:	49 d1 e8             	shr    $1,%r8
    46ea:	4d 21 f0             	and    %r14,%r8
    46ed:	4c 29 c7             	sub    %r8,%rdi
    46f0:	49 89 f8             	mov    %rdi,%r8
    46f3:	4d 21 c8             	and    %r9,%r8
    46f6:	48 c1 ef 02          	shr    $0x2,%rdi
    46fa:	4c 21 cf             	and    %r9,%rdi
    46fd:	4c 01 c7             	add    %r8,%rdi
    4700:	49 89 f8             	mov    %rdi,%r8
    4703:	49 c1 e8 04          	shr    $0x4,%r8
    4707:	49 01 f8             	add    %rdi,%r8
    470a:	4d 21 d0             	and    %r10,%r8
    470d:	4d 0f af c3          	imul   %r11,%r8
    4711:	49 c1 e8 38          	shr    $0x38,%r8
    4715:	4c 01 c2             	add    %r8,%rdx
    4718:	48 ff c1             	inc    %rcx
    471b:	48 39 c8             	cmp    %rcx,%rax
    471e:	75 c0                	jne    46e0 <fwp_gc_sweep+0x2b0>
    4720:	48 85 d2             	test   %rdx,%rdx
    4723:	0f 84 8c fd ff ff    	je     44b5 <fwp_gc_sweep+0x85>
    4729:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    472e:	43 8b 44 25 08       	mov    0x8(%r13,%r12,1),%eax
    4733:	48 0f af d0          	imul   %rax,%rdx
    4737:	48 01 54 24 08       	add    %rdx,0x8(%rsp)
    473c:	47 0f b6 74 25 01    	movzbl 0x1(%r13,%r12,1),%r14d
    4742:	47 0f b6 7c 25 02    	movzbl 0x2(%r13,%r12,1),%r15d
    4748:	48 89 df             	mov    %rbx,%rdi
    474b:	e8 80 e7 ff ff       	call   2ed0 <fwp_gc_chunk_addr>
    4750:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    4755:	48 85 ed             	test   %rbp,%rbp
    4758:	0f 84 31 01 00 00    	je     488f <fwp_gc_sweep+0x45f>
    475e:	49 69 c6 c0 03 00 00 	imul   $0x3c0,%r14,%rax
    4765:	48 8d 0d 24 fb 00 00 	lea    0xfb24(%rip),%rcx        # 14290 <fwp_gc>
    476c:	48 01 c8             	add    %rcx,%rax
    476f:	4f 8d 34 2c          	lea    (%r12,%r13,1),%r14
    4773:	49 83 c6 08          	add    $0x8,%r14
    4777:	4b 8d 0c 7f          	lea    (%r15,%r15,2),%rcx
    477b:	4c 8d 3c c8          	lea    (%rax,%rcx,8),%r15
    477f:	49 83 c7 08          	add    $0x8,%r15
    4783:	49 01 ec             	add    %rbp,%r12
    4786:	4d 01 ec             	add    %r13,%r12
    4789:	49 81 c4 27 02 00 00 	add    $0x227,%r12
    4790:	48 ff cd             	dec    %rbp
    4793:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    479a:	33 33 33 
    479d:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    47a4:	0f 0f 0f 
    47a7:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    47ae:	01 01 01 
    47b1:	66 0f 6f 2d 37 99 00 	movdqa 0x9937(%rip),%xmm5        # e0f0 <_IO_stdin_used+0xf0>
    47b8:	00 
    47b9:	66 0f 6f 35 3f 99 00 	movdqa 0x993f(%rip),%xmm6        # e100 <_IO_stdin_used+0x100>
    47c0:	00 
    47c1:	66 0f 6f 3d 47 99 00 	movdqa 0x9947(%rip),%xmm7        # e110 <_IO_stdin_used+0x110>
    47c8:	00 
    47c9:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    47ce:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    47d3:	eb 69                	jmp    483e <fwp_gc_sweep+0x40e>
    47d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    47dc:	00 00 00 00 
    47e0:	4c 89 e7             	mov    %r12,%rdi
    47e3:	e8 c8 e6 ff ff       	call   2eb0 <fwp_rc_clear_slot>
    47e8:	49 8b 07             	mov    (%r15),%rax
    47eb:	48 f7 d0             	not    %rax
    47ee:	49 89 45 00          	mov    %rax,0x0(%r13)
    47f2:	4d 89 2f             	mov    %r13,(%r15)
    47f5:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    47fc:	33 33 33 
    47ff:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    4806:	0f 0f 0f 
    4809:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    4810:	01 01 01 
    4813:	66 0f 6f 2d d5 98 00 	movdqa 0x98d5(%rip),%xmm5        # e0f0 <_IO_stdin_used+0xf0>
    481a:	00 
    481b:	66 0f 6f 35 dd 98 00 	movdqa 0x98dd(%rip),%xmm6        # e100 <_IO_stdin_used+0x100>
    4822:	00 
    4823:	66 0f 6f 3d e5 98 00 	movdqa 0x98e5(%rip),%xmm7        # e110 <_IO_stdin_used+0x110>
    482a:	00 
    482b:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    4830:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    4835:	49 ff cc             	dec    %r12
    4838:	48 83 c5 ff          	add    $0xffffffffffffffff,%rbp
    483c:	73 3d                	jae    487b <fwp_gc_sweep+0x44b>
    483e:	48 89 e8             	mov    %rbp,%rax
    4841:	48 c1 e8 06          	shr    $0x6,%rax
    4845:	48 8b 44 c1 28       	mov    0x28(%rcx,%rax,8),%rax
    484a:	48 0f a3 e8          	bt     %rbp,%rax
    484e:	72 e5                	jb     4835 <fwp_gc_sweep+0x405>
    4850:	41 8b 16             	mov    (%r14),%edx
    4853:	49 89 ed             	mov    %rbp,%r13
    4856:	4c 0f af ea          	imul   %rdx,%r13
    485a:	4c 03 6c 24 20       	add    0x20(%rsp),%r13
    485f:	83 3d 2e 0a 01 00 00 	cmpl   $0x0,0x10a2e(%rip)        # 15294 <fwp_gc+0x1004>
    4866:	0f 84 74 ff ff ff    	je     47e0 <fwp_gc_sweep+0x3b0>
    486c:	4c 89 ef             	mov    %r13,%rdi
    486f:	31 f6                	xor    %esi,%esi
    4871:	e8 8a d9 ff ff       	call   2200 <memset@plt>
    4876:	e9 65 ff ff ff       	jmp    47e0 <fwp_gc_sweep+0x3b0>
    487b:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    4880:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    4887:	55 55 55 
    488a:	e9 76 fc ff ff       	jmp    4505 <fwp_gc_sweep+0xd5>
    488f:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    4894:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    489b:	55 55 55 
    489e:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    48a5:	33 33 33 
    48a8:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    48af:	0f 0f 0f 
    48b2:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    48b9:	01 01 01 
    48bc:	66 0f 6f 2d 2c 98 00 	movdqa 0x982c(%rip),%xmm5        # e0f0 <_IO_stdin_used+0xf0>
    48c3:	00 
    48c4:	66 0f 6f 35 34 98 00 	movdqa 0x9834(%rip),%xmm6        # e100 <_IO_stdin_used+0x100>
    48cb:	00 
    48cc:	66 0f 6f 3d 3c 98 00 	movdqa 0x983c(%rip),%xmm7        # e110 <_IO_stdin_used+0x110>
    48d3:	00 
    48d4:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    48d9:	e9 27 fc ff ff       	jmp    4505 <fwp_gc_sweep+0xd5>
    48de:	4a 8d 14 20          	lea    (%rax,%r12,1),%rdx
    48e2:	44 89 f6             	mov    %r14d,%esi
    48e5:	83 e6 fc             	and    $0xfffffffc,%esi
    48e8:	31 c9                	xor    %ecx,%ecx
    48ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    48f0:	c6 02 00             	movb   $0x0,(%rdx)
    48f3:	c6 82 28 12 00 00 00 	movb   $0x0,0x1228(%rdx)
    48fa:	c6 82 50 24 00 00 00 	movb   $0x0,0x2450(%rdx)
    4901:	c6 82 78 36 00 00 00 	movb   $0x0,0x3678(%rdx)
    4908:	48 83 c1 04          	add    $0x4,%rcx
    490c:	48 81 c2 a0 48 00 00 	add    $0x48a0,%rdx
    4913:	48 39 ce             	cmp    %rcx,%rsi
    4916:	75 d8                	jne    48f0 <fwp_gc_sweep+0x4c0>
    4918:	44 89 f2             	mov    %r14d,%edx
    491b:	83 e2 03             	and    $0x3,%edx
    491e:	74 30                	je     4950 <fwp_gc_sweep+0x520>
    4920:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    4927:	4c 01 e1             	add    %r12,%rcx
    492a:	48 01 c8             	add    %rcx,%rax
    492d:	48 69 ca 28 12 00 00 	imul   $0x1228,%rdx,%rcx
    4934:	31 d2                	xor    %edx,%edx
    4936:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    493d:	00 00 00 
    4940:	c6 04 10 00          	movb   $0x0,(%rax,%rdx,1)
    4944:	48 81 c2 28 12 00 00 	add    $0x1228,%rdx
    494b:	48 39 d1             	cmp    %rdx,%rcx
    494e:	75 f0                	jne    4940 <fwp_gc_sweep+0x510>
    4950:	4d 01 f7             	add    %r14,%r15
    4953:	4c 01 f3             	add    %r14,%rbx
    4956:	48 ff cb             	dec    %rbx
    4959:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    4960:	55 55 55 
    4963:	e9 9d fb ff ff       	jmp    4505 <fwp_gc_sweep+0xd5>
    4968:	31 c0                	xor    %eax,%eax
    496a:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    496f:	31 c0                	xor    %eax,%eax
    4971:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    4976:	48 89 15 db 0a 01 00 	mov    %rdx,0x10adb(%rip)        # 15458 <fwp_gc+0x11c8>
    497d:	4c 89 3d ec 0a 01 00 	mov    %r15,0x10aec(%rip)        # 15470 <fwp_gc+0x11e0>
    4984:	48 81 fa 01 00 00 01 	cmp    $0x1000001,%rdx
    498b:	b9 00 00 00 01       	mov    $0x1000000,%ecx
    4990:	48 0f 43 ca          	cmovae %rdx,%rcx
    4994:	48 c1 e9 10          	shr    $0x10,%rcx
    4998:	66 0f ef c0          	pxor   %xmm0,%xmm0
    499c:	f3 0f 7f 05 54 09 01 	movdqu %xmm0,0x10954(%rip)        # 152f8 <fwp_gc+0x1068>
    49a3:	00 
    49a4:	49 29 cf             	sub    %rcx,%r15
    49a7:	0f 86 01 01 00 00    	jbe    4aae <fwp_gc_sweep+0x67e>
    49ad:	48 85 c0             	test   %rax,%rax
    49b0:	0f 84 f8 00 00 00    	je     4aae <fwp_gc_sweep+0x67e>
    49b6:	4d 85 ff             	test   %r15,%r15
    49b9:	0f 84 ef 00 00 00    	je     4aae <fwp_gc_sweep+0x67e>
    49bf:	48 8b 0d 42 09 01 00 	mov    0x10942(%rip),%rcx        # 15308 <fwp_gc+0x1078>
    49c6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    49cd:	00 00 00 
    49d0:	48 8d 58 ff          	lea    -0x1(%rax),%rbx
    49d4:	48 69 d3 28 12 00 00 	imul   $0x1228,%rbx,%rdx
    49db:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
    49df:	0f 85 b8 00 00 00    	jne    4a9d <fwp_gc_sweep+0x66d>
    49e5:	4c 89 ff             	mov    %r15,%rdi
    49e8:	49 ff cf             	dec    %r15
    49eb:	80 7c 11 04 00       	cmpb   $0x0,0x4(%rcx,%rdx,1)
    49f0:	0f 84 a7 00 00 00    	je     4a9d <fwp_gc_sweep+0x66d>
    49f6:	48 01 ca             	add    %rcx,%rdx
    49f9:	48 83 c2 04          	add    $0x4,%rdx
    49fd:	c6 02 00             	movb   $0x0,(%rdx)
    4a00:	41 be 01 00 00 00    	mov    $0x1,%r14d
    4a06:	48 85 db             	test   %rbx,%rbx
    4a09:	74 6f                	je     4a7a <fwp_gc_sweep+0x64a>
    4a0b:	4d 85 ff             	test   %r15,%r15
    4a0e:	74 6a                	je     4a7a <fwp_gc_sweep+0x64a>
    4a10:	ba 02 00 00 00       	mov    $0x2,%edx
    4a15:	48 29 c2             	sub    %rax,%rdx
    4a18:	48 69 c0 28 12 00 00 	imul   $0x1228,%rax,%rax
    4a1f:	48 01 c1             	add    %rax,%rcx
    4a22:	48 81 c1 b4 db ff ff 	add    $0xffffffffffffdbb4,%rcx
    4a29:	be 02 00 00 00       	mov    $0x2,%esi
    4a2e:	48 29 fe             	sub    %rdi,%rsi
    4a31:	b8 01 00 00 00       	mov    $0x1,%eax
    4a36:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    4a3d:	00 00 00 
    4a40:	80 79 fc 00          	cmpb   $0x0,-0x4(%rcx)
    4a44:	75 31                	jne    4a77 <fwp_gc_sweep+0x647>
    4a46:	80 39 00             	cmpb   $0x0,(%rcx)
    4a49:	74 2c                	je     4a77 <fwp_gc_sweep+0x647>
    4a4b:	48 ff cb             	dec    %rbx
    4a4e:	48 8d 3c 02          	lea    (%rdx,%rax,1),%rdi
    4a52:	49 ff cf             	dec    %r15
    4a55:	c6 01 00             	movb   $0x0,(%rcx)
    4a58:	4c 8d 70 01          	lea    0x1(%rax),%r14
    4a5c:	48 83 ff 01          	cmp    $0x1,%rdi
    4a60:	74 18                	je     4a7a <fwp_gc_sweep+0x64a>
    4a62:	48 01 f0             	add    %rsi,%rax
    4a65:	48 81 c1 d8 ed ff ff 	add    $0xffffffffffffedd8,%rcx
    4a6c:	48 83 f8 01          	cmp    $0x1,%rax
    4a70:	4c 89 f0             	mov    %r14,%rax
    4a73:	75 cb                	jne    4a40 <fwp_gc_sweep+0x610>
    4a75:	eb 03                	jmp    4a7a <fwp_gc_sweep+0x64a>
    4a77:	49 89 c6             	mov    %rax,%r14
    4a7a:	48 89 df             	mov    %rbx,%rdi
    4a7d:	e8 4e e4 ff ff       	call   2ed0 <fwp_gc_chunk_addr>
    4a82:	49 c1 e6 10          	shl    $0x10,%r14
    4a86:	48 89 c7             	mov    %rax,%rdi
    4a89:	4c 89 f6             	mov    %r14,%rsi
    4a8c:	ba 04 00 00 00       	mov    $0x4,%edx
    4a91:	e8 4a d9 ff ff       	call   23e0 <madvise@plt>
    4a96:	48 8b 0d 6b 08 01 00 	mov    0x1086b(%rip),%rcx        # 15308 <fwp_gc+0x1078>
    4a9d:	48 89 d8             	mov    %rbx,%rax
    4aa0:	48 85 db             	test   %rbx,%rbx
    4aa3:	74 09                	je     4aae <fwp_gc_sweep+0x67e>
    4aa5:	4d 85 ff             	test   %r15,%r15
    4aa8:	0f 85 22 ff ff ff    	jne    49d0 <fwp_gc_sweep+0x5a0>
    4aae:	48 83 c4 28          	add    $0x28,%rsp
    4ab2:	5b                   	pop    %rbx
    4ab3:	41 5c                	pop    %r12
    4ab5:	41 5d                	pop    %r13
    4ab7:	41 5e                	pop    %r14
    4ab9:	41 5f                	pop    %r15
    4abb:	5d                   	pop    %rbp
    4abc:	c3                   	ret
    4abd:	0f 1f 00             	nopl   (%rax)

0000000000004ac0 <fwp_gc_scan_stacks>:
    4ac0:	48 8b 35 51 08 01 00 	mov    0x10851(%rip),%rsi        # 15318 <fwp_gc+0x1088>
    4ac7:	e9 04 01 00 00       	jmp    4bd0 <fwp_gc_scan_root>
    4acc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000004ad0 <fwp_gc_sp>:
    4ad0:	55                   	push   %rbp
    4ad1:	48 89 e5             	mov    %rsp,%rbp
    4ad4:	48 89 e8             	mov    %rbp,%rax
    4ad7:	5d                   	pop    %rbp
    4ad8:	c3                   	ret
    4ad9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000004ae0 <fwp_gc_drain>:
    4ae0:	48 8b 05 49 09 01 00 	mov    0x10949(%rip),%rax        # 15430 <fwp_gc+0x11a0>
    4ae7:	48 85 c0             	test   %rax,%rax
    4aea:	74 3c                	je     4b28 <fwp_gc_drain+0x48>
    4aec:	50                   	push   %rax
    4aed:	0f 1f 00             	nopl   (%rax)
    4af0:	48 8b 0d 31 09 01 00 	mov    0x10931(%rip),%rcx        # 15428 <fwp_gc+0x1198>
    4af7:	48 ff c8             	dec    %rax
    4afa:	48 89 05 2f 09 01 00 	mov    %rax,0x1092f(%rip)        # 15430 <fwp_gc+0x11a0>
    4b01:	48 c1 e0 04          	shl    $0x4,%rax
    4b05:	48 8b 3c 01          	mov    (%rcx,%rax,1),%rdi
    4b09:	48 8b 74 01 08       	mov    0x8(%rcx,%rax,1),%rsi
    4b0e:	48 01 fe             	add    %rdi,%rsi
    4b11:	31 d2                	xor    %edx,%edx
    4b13:	e8 e8 00 00 00       	call   4c00 <fwp_gc_scan>
    4b18:	48 8b 05 11 09 01 00 	mov    0x10911(%rip),%rax        # 15430 <fwp_gc+0x11a0>
    4b1f:	48 85 c0             	test   %rax,%rax
    4b22:	75 cc                	jne    4af0 <fwp_gc_drain+0x10>
    4b24:	48 83 c4 08          	add    $0x8,%rsp
    4b28:	c3                   	ret
    4b29:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000004b30 <fwp_gc_scan_data>:
    4b30:	83 3d e9 08 01 00 00 	cmpl   $0x0,0x108e9(%rip)        # 15420 <fwp_gc+0x1190>
    4b37:	0f 8e 87 00 00 00    	jle    4bc4 <fwp_gc_scan_data+0x94>
    4b3d:	41 57                	push   %r15
    4b3f:	41 56                	push   %r14
    4b41:	41 55                	push   %r13
    4b43:	41 54                	push   %r12
    4b45:	53                   	push   %rbx
    4b46:	4c 8d 25 db 07 01 00 	lea    0x107db(%rip),%r12        # 15328 <fwp_gc+0x1098>
    4b4d:	45 31 ed             	xor    %r13d,%r13d
    4b50:	48 8d 1d 39 f7 00 00 	lea    0xf739(%rip),%rbx        # 14290 <fwp_gc>
    4b57:	4c 8d 35 52 11 01 00 	lea    0x11152(%rip),%r14        # 15cb0 <fwp_reuse_verify>
    4b5e:	eb 1d                	jmp    4b7d <fwp_gc_scan_data+0x4d>
    4b60:	4c 89 fe             	mov    %r15,%rsi
    4b63:	31 d2                	xor    %edx,%edx
    4b65:	e8 96 00 00 00       	call   4c00 <fwp_gc_scan>
    4b6a:	49 ff c5             	inc    %r13
    4b6d:	48 63 05 ac 08 01 00 	movslq 0x108ac(%rip),%rax        # 15420 <fwp_gc+0x1190>
    4b74:	49 83 c4 10          	add    $0x10,%r12
    4b78:	49 39 c5             	cmp    %rax,%r13
    4b7b:	7d 3e                	jge    4bbb <fwp_gc_scan_data+0x8b>
    4b7d:	49 8b 7c 24 f8       	mov    -0x8(%r12),%rdi
    4b82:	49 8b 04 24          	mov    (%r12),%rax
    4b86:	4c 8d 3c 07          	lea    (%rdi,%rax,1),%r15
    4b8a:	0f 57 c0             	xorps  %xmm0,%xmm0
    4b8d:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    4b92:	f2 0f 58 05 f6 08 01 	addsd  0x108f6(%rip),%xmm0        # 15490 <fwp_gc+0x1200>
    4b99:	00 
    4b9a:	f2 0f 11 05 ee 08 01 	movsd  %xmm0,0x108ee(%rip)        # 15490 <fwp_gc+0x1200>
    4ba1:	00 
    4ba2:	48 39 df             	cmp    %rbx,%rdi
    4ba5:	77 b9                	ja     4b60 <fwp_gc_scan_data+0x30>
    4ba7:	4d 39 f7             	cmp    %r14,%r15
    4baa:	72 b4                	jb     4b60 <fwp_gc_scan_data+0x30>
    4bac:	48 89 de             	mov    %rbx,%rsi
    4baf:	31 d2                	xor    %edx,%edx
    4bb1:	e8 4a 00 00 00       	call   4c00 <fwp_gc_scan>
    4bb6:	4c 89 f7             	mov    %r14,%rdi
    4bb9:	eb a5                	jmp    4b60 <fwp_gc_scan_data+0x30>
    4bbb:	5b                   	pop    %rbx
    4bbc:	41 5c                	pop    %r12
    4bbe:	41 5d                	pop    %r13
    4bc0:	41 5e                	pop    %r14
    4bc2:	41 5f                	pop    %r15
    4bc4:	c3                   	ret
    4bc5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    4bcc:	00 00 00 00 

0000000000004bd0 <fwp_gc_scan_root>:
    4bd0:	48 85 ff             	test   %rdi,%rdi
    4bd3:	74 24                	je     4bf9 <fwp_gc_scan_root+0x29>
    4bd5:	48 89 f0             	mov    %rsi,%rax
    4bd8:	48 29 f8             	sub    %rdi,%rax
    4bdb:	76 1c                	jbe    4bf9 <fwp_gc_scan_root+0x29>
    4bdd:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    4be2:	f2 0f 58 05 a6 08 01 	addsd  0x108a6(%rip),%xmm0        # 15490 <fwp_gc+0x1200>
    4be9:	00 
    4bea:	f2 0f 11 05 9e 08 01 	movsd  %xmm0,0x1089e(%rip)        # 15490 <fwp_gc+0x1200>
    4bf1:	00 
    4bf2:	ba 01 00 00 00       	mov    $0x1,%edx
    4bf7:	eb 07                	jmp    4c00 <fwp_gc_scan>
    4bf9:	c3                   	ret
    4bfa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000004c00 <fwp_gc_scan>:
    4c00:	55                   	push   %rbp
    4c01:	41 57                	push   %r15
    4c03:	41 56                	push   %r14
    4c05:	41 55                	push   %r13
    4c07:	41 54                	push   %r12
    4c09:	53                   	push   %rbx
    4c0a:	50                   	push   %rax
    4c0b:	49 89 ff             	mov    %rdi,%r15
    4c0e:	49 83 c7 07          	add    $0x7,%r15
    4c12:	49 83 e7 f8          	and    $0xfffffffffffffff8,%r15
    4c16:	49 8d 47 08          	lea    0x8(%r15),%rax
    4c1a:	48 39 f0             	cmp    %rsi,%rax
    4c1d:	76 0f                	jbe    4c2e <fwp_gc_scan+0x2e>
    4c1f:	48 83 c4 08          	add    $0x8,%rsp
    4c23:	5b                   	pop    %rbx
    4c24:	41 5c                	pop    %r12
    4c26:	41 5d                	pop    %r13
    4c28:	41 5e                	pop    %r14
    4c2a:	41 5f                	pop    %r15
    4c2c:	5d                   	pop    %rbp
    4c2d:	c3                   	ret
    4c2e:	89 d3                	mov    %edx,%ebx
    4c30:	49 89 f6             	mov    %rsi,%r14
    4c33:	4c 8b 2d 86 06 01 00 	mov    0x10686(%rip),%r13        # 152c0 <fwp_gc+0x1030>
    4c3a:	48 8b 2d a7 06 01 00 	mov    0x106a7(%rip),%rbp        # 152e8 <fwp_gc+0x1058>
    4c41:	48 c1 e5 10          	shl    $0x10,%rbp
    4c45:	eb 30                	jmp    4c77 <fwp_gc_scan+0x77>
    4c47:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    4c4e:	00 00 
    4c50:	4c 89 e7             	mov    %r12,%rdi
    4c53:	e8 38 00 00 00       	call   4c90 <fwp_gc_mark>
    4c58:	85 db                	test   %ebx,%ebx
    4c5a:	74 0b                	je     4c67 <fwp_gc_scan+0x67>
    4c5c:	49 ff cc             	dec    %r12
    4c5f:	4c 89 e7             	mov    %r12,%rdi
    4c62:	e8 29 00 00 00       	call   4c90 <fwp_gc_mark>
    4c67:	49 8d 47 08          	lea    0x8(%r15),%rax
    4c6b:	49 83 c7 10          	add    $0x10,%r15
    4c6f:	4d 39 f7             	cmp    %r14,%r15
    4c72:	49 89 c7             	mov    %rax,%r15
    4c75:	77 a8                	ja     4c1f <fwp_gc_scan+0x1f>
    4c77:	4d 8b 27             	mov    (%r15),%r12
    4c7a:	4c 89 e0             	mov    %r12,%rax
    4c7d:	4c 29 e8             	sub    %r13,%rax
    4c80:	48 39 e8             	cmp    %rbp,%rax
    4c83:	72 cb                	jb     4c50 <fwp_gc_scan+0x50>
    4c85:	85 db                	test   %ebx,%ebx
    4c87:	74 de                	je     4c67 <fwp_gc_scan+0x67>
    4c89:	48 39 e8             	cmp    %rbp,%rax
    4c8c:	74 ce                	je     4c5c <fwp_gc_scan+0x5c>
    4c8e:	eb d7                	jmp    4c67 <fwp_gc_scan+0x67>

0000000000004c90 <fwp_gc_mark>:
    4c90:	41 56                	push   %r14
    4c92:	53                   	push   %rbx
    4c93:	50                   	push   %rax
    4c94:	49 89 fe             	mov    %rdi,%r14
    4c97:	48 89 e6             	mov    %rsp,%rsi
    4c9a:	e8 d1 00 00 00       	call   4d70 <fwp_gc_chunk_of>
    4c9f:	48 85 c0             	test   %rax,%rax
    4ca2:	0f 84 98 00 00 00    	je     4d40 <fwp_gc_mark+0xb0>
    4ca8:	0f b6 08             	movzbl (%rax),%ecx
    4cab:	83 f9 03             	cmp    $0x3,%ecx
    4cae:	74 6b                	je     4d1b <fwp_gc_mark+0x8b>
    4cb0:	83 f9 02             	cmp    $0x2,%ecx
    4cb3:	74 7b                	je     4d30 <fwp_gc_mark+0xa0>
    4cb5:	83 f9 01             	cmp    $0x1,%ecx
    4cb8:	0f 85 82 00 00 00    	jne    4d40 <fwp_gc_mark+0xb0>
    4cbe:	8b 58 08             	mov    0x8(%rax),%ebx
    4cc1:	41 0f b7 ce          	movzwl %r14w,%ecx
    4cc5:	48 89 c6             	mov    %rax,%rsi
    4cc8:	89 c8                	mov    %ecx,%eax
    4cca:	31 d2                	xor    %edx,%edx
    4ccc:	f7 f3                	div    %ebx
    4cce:	41 89 c6             	mov    %eax,%r14d
    4cd1:	3b 46 0c             	cmp    0xc(%rsi),%eax
    4cd4:	73 6a                	jae    4d40 <fwp_gc_mark+0xb0>
    4cd6:	48 89 f0             	mov    %rsi,%rax
    4cd9:	ba 01 00 00 00       	mov    $0x1,%edx
    4cde:	44 89 f1             	mov    %r14d,%ecx
    4ce1:	48 d3 e2             	shl    %cl,%rdx
    4ce4:	44 89 f1             	mov    %r14d,%ecx
    4ce7:	c1 e9 06             	shr    $0x6,%ecx
    4cea:	48 8b 74 ce 28       	mov    0x28(%rsi,%rcx,8),%rsi
    4cef:	4c 0f a3 f6          	bt     %r14,%rsi
    4cf3:	72 4b                	jb     4d40 <fwp_gc_mark+0xb0>
    4cf5:	48 09 d6             	or     %rdx,%rsi
    4cf8:	48 89 74 c8 28       	mov    %rsi,0x28(%rax,%rcx,8)
    4cfd:	80 78 01 01          	cmpb   $0x1,0x1(%rax)
    4d01:	74 3d                	je     4d40 <fwp_gc_mark+0xb0>
    4d03:	48 8b 3c 24          	mov    (%rsp),%rdi
    4d07:	e8 c4 e1 ff ff       	call   2ed0 <fwp_gc_chunk_addr>
    4d0c:	4c 0f af f3          	imul   %rbx,%r14
    4d10:	49 01 c6             	add    %rax,%r14
    4d13:	4c 89 f7             	mov    %r14,%rdi
    4d16:	48 89 de             	mov    %rbx,%rsi
    4d19:	eb 40                	jmp    4d5b <fwp_gc_mark+0xcb>
    4d1b:	8b 40 10             	mov    0x10(%rax),%eax
    4d1e:	48 89 04 24          	mov    %rax,(%rsp)
    4d22:	48 69 c0 28 12 00 00 	imul   $0x1228,%rax,%rax
    4d29:	48 03 05 d8 05 01 00 	add    0x105d8(%rip),%rax        # 15308 <fwp_gc+0x1078>
    4d30:	80 78 03 00          	cmpb   $0x0,0x3(%rax)
    4d34:	75 0a                	jne    4d40 <fwp_gc_mark+0xb0>
    4d36:	c6 40 03 01          	movb   $0x1,0x3(%rax)
    4d3a:	80 78 01 01          	cmpb   $0x1,0x1(%rax)
    4d3e:	75 08                	jne    4d48 <fwp_gc_mark+0xb8>
    4d40:	48 83 c4 08          	add    $0x8,%rsp
    4d44:	5b                   	pop    %rbx
    4d45:	41 5e                	pop    %r14
    4d47:	c3                   	ret
    4d48:	48 8b 3c 24          	mov    (%rsp),%rdi
    4d4c:	48 89 c3             	mov    %rax,%rbx
    4d4f:	e8 7c e1 ff ff       	call   2ed0 <fwp_gc_chunk_addr>
    4d54:	48 8b 73 18          	mov    0x18(%rbx),%rsi
    4d58:	48 89 c7             	mov    %rax,%rdi
    4d5b:	48 83 c4 08          	add    $0x8,%rsp
    4d5f:	5b                   	pop    %rbx
    4d60:	41 5e                	pop    %r14
    4d62:	eb 3c                	jmp    4da0 <fwp_gc_push>
    4d64:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    4d6b:	00 00 00 00 00 

0000000000004d70 <fwp_gc_chunk_of>:
    4d70:	48 2b 3d 49 05 01 00 	sub    0x10549(%rip),%rdi        # 152c0 <fwp_gc+0x1030>
    4d77:	48 8b 05 6a 05 01 00 	mov    0x1056a(%rip),%rax        # 152e8 <fwp_gc+0x1058>
    4d7e:	48 c1 e0 10          	shl    $0x10,%rax
    4d82:	48 39 c7             	cmp    %rax,%rdi
    4d85:	73 16                	jae    4d9d <fwp_gc_chunk_of+0x2d>
    4d87:	48 c1 ef 10          	shr    $0x10,%rdi
    4d8b:	48 89 3e             	mov    %rdi,(%rsi)
    4d8e:	48 69 c7 28 12 00 00 	imul   $0x1228,%rdi,%rax
    4d95:	48 03 05 6c 05 01 00 	add    0x1056c(%rip),%rax        # 15308 <fwp_gc+0x1078>
    4d9c:	c3                   	ret
    4d9d:	31 c0                	xor    %eax,%eax
    4d9f:	c3                   	ret

0000000000004da0 <fwp_gc_push>:
    4da0:	41 56                	push   %r14
    4da2:	53                   	push   %rbx
    4da3:	50                   	push   %rax
    4da4:	48 89 f3             	mov    %rsi,%rbx
    4da7:	49 89 fe             	mov    %rdi,%r14
    4daa:	48 8b 0d 7f 06 01 00 	mov    0x1067f(%rip),%rcx        # 15430 <fwp_gc+0x11a0>
    4db1:	48 8b 05 70 06 01 00 	mov    0x10670(%rip),%rax        # 15428 <fwp_gc+0x1198>
    4db8:	48 3b 0d 79 06 01 00 	cmp    0x10679(%rip),%rcx        # 15438 <fwp_gc+0x11a8>
    4dbf:	75 36                	jne    4df7 <fwp_gc_push+0x57>
    4dc1:	48 8d 14 09          	lea    (%rcx,%rcx,1),%rdx
    4dc5:	48 85 c9             	test   %rcx,%rcx
    4dc8:	be 00 10 00 00       	mov    $0x1000,%esi
    4dcd:	48 0f 45 f2          	cmovne %rdx,%rsi
    4dd1:	48 89 35 60 06 01 00 	mov    %rsi,0x10660(%rip)        # 15438 <fwp_gc+0x11a8>
    4dd8:	48 c1 e6 04          	shl    $0x4,%rsi
    4ddc:	48 89 c7             	mov    %rax,%rdi
    4ddf:	e8 8c d5 ff ff       	call   2370 <realloc@plt>
    4de4:	48 89 05 3d 06 01 00 	mov    %rax,0x1063d(%rip)        # 15428 <fwp_gc+0x1198>
    4deb:	48 85 c0             	test   %rax,%rax
    4dee:	74 29                	je     4e19 <fwp_gc_push+0x79>
    4df0:	48 8b 0d 39 06 01 00 	mov    0x10639(%rip),%rcx        # 15430 <fwp_gc+0x11a0>
    4df7:	48 89 ca             	mov    %rcx,%rdx
    4dfa:	48 c1 e2 04          	shl    $0x4,%rdx
    4dfe:	4c 89 34 10          	mov    %r14,(%rax,%rdx,1)
    4e02:	48 89 5c 10 08       	mov    %rbx,0x8(%rax,%rdx,1)
    4e07:	48 ff c1             	inc    %rcx
    4e0a:	48 89 0d 1f 06 01 00 	mov    %rcx,0x1061f(%rip)        # 15430 <fwp_gc+0x11a0>
    4e11:	48 83 c4 08          	add    $0x8,%rsp
    4e15:	5b                   	pop    %rbx
    4e16:	41 5e                	pop    %r14
    4e18:	c3                   	ret
    4e19:	e8 02 ec ff ff       	call   3a20 <fwp_gc_oom>
    4e1e:	66 90                	xchg   %ax,%ax

0000000000004e20 <fwp_gc_marked>:
    4e20:	53                   	push   %rbx
    4e21:	48 83 ec 10          	sub    $0x10,%rsp
    4e25:	48 89 fb             	mov    %rdi,%rbx
    4e28:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    4e2d:	e8 3e ff ff ff       	call   4d70 <fwp_gc_chunk_of>
    4e32:	48 85 c0             	test   %rax,%rax
    4e35:	74 36                	je     4e6d <fwp_gc_marked+0x4d>
    4e37:	0f b6 08             	movzbl (%rax),%ecx
    4e3a:	80 f9 03             	cmp    $0x3,%cl
    4e3d:	75 19                	jne    4e58 <fwp_gc_marked+0x38>
    4e3f:	48 8b 0d c2 04 01 00 	mov    0x104c2(%rip),%rcx        # 15308 <fwp_gc+0x1078>
    4e46:	8b 40 10             	mov    0x10(%rax),%eax
    4e49:	48 69 d0 28 12 00 00 	imul   $0x1228,%rax,%rdx
    4e50:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    4e54:	0f b6 0c 11          	movzbl (%rcx,%rdx,1),%ecx
    4e58:	80 f9 01             	cmp    $0x1,%cl
    4e5b:	74 17                	je     4e74 <fwp_gc_marked+0x54>
    4e5d:	0f b6 d1             	movzbl %cl,%edx
    4e60:	31 c9                	xor    %ecx,%ecx
    4e62:	83 fa 02             	cmp    $0x2,%edx
    4e65:	75 33                	jne    4e9a <fwp_gc_marked+0x7a>
    4e67:	0f b6 48 03          	movzbl 0x3(%rax),%ecx
    4e6b:	eb 2d                	jmp    4e9a <fwp_gc_marked+0x7a>
    4e6d:	b9 01 00 00 00       	mov    $0x1,%ecx
    4e72:	eb 26                	jmp    4e9a <fwp_gc_marked+0x7a>
    4e74:	0f b7 cb             	movzwl %bx,%ecx
    4e77:	48 89 c6             	mov    %rax,%rsi
    4e7a:	89 c8                	mov    %ecx,%eax
    4e7c:	31 d2                	xor    %edx,%edx
    4e7e:	f7 76 08             	divl   0x8(%rsi)
    4e81:	89 c1                	mov    %eax,%ecx
    4e83:	c1 e9 03             	shr    $0x3,%ecx
    4e86:	81 e1 f8 1f 00 00    	and    $0x1ff8,%ecx
    4e8c:	48 8b 54 0e 28       	mov    0x28(%rsi,%rcx,1),%rdx
    4e91:	31 c9                	xor    %ecx,%ecx
    4e93:	48 0f a3 c2          	bt     %rax,%rdx
    4e97:	0f 92 c1             	setb   %cl
    4e9a:	89 c8                	mov    %ecx,%eax
    4e9c:	48 83 c4 10          	add    $0x10,%rsp
    4ea0:	5b                   	pop    %rbx
    4ea1:	c3                   	ret
    4ea2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4ea9:	1f 84 00 00 00 00 00 

0000000000004eb0 <fwp_rc_clear_chunk>:
    4eb0:	41 57                	push   %r15
    4eb2:	41 56                	push   %r14
    4eb4:	53                   	push   %rbx
    4eb5:	48 89 fb             	mov    %rdi,%rbx
    4eb8:	48 83 3d e8 0d 01 00 	cmpq   $0x0,0x10de8(%rip)        # 15ca8 <fwp_gc+0x1a18>
    4ebf:	00 
    4ec0:	74 2c                	je     4eee <fwp_rc_clear_chunk+0x3e>
    4ec2:	4c 8d b3 28 02 00 00 	lea    0x228(%rbx),%r14
    4ec9:	45 31 ff             	xor    %r15d,%r15d
    4ecc:	eb 0e                	jmp    4edc <fwp_rc_clear_chunk+0x2c>
    4ece:	66 90                	xchg   %ax,%ax
    4ed0:	49 ff c7             	inc    %r15
    4ed3:	49 81 ff 00 10 00 00 	cmp    $0x1000,%r15
    4eda:	74 12                	je     4eee <fwp_rc_clear_chunk+0x3e>
    4edc:	43 80 3c 3e ff       	cmpb   $0xff,(%r14,%r15,1)
    4ee1:	75 ed                	jne    4ed0 <fwp_rc_clear_chunk+0x20>
    4ee3:	4b 8d 3c 3e          	lea    (%r14,%r15,1),%rdi
    4ee7:	e8 f4 df ff ff       	call   2ee0 <fwp_rc_forget_slot>
    4eec:	eb e2                	jmp    4ed0 <fwp_rc_clear_chunk+0x20>
    4eee:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    4ef5:	ba 00 10 00 00       	mov    $0x1000,%edx
    4efa:	48 89 df             	mov    %rbx,%rdi
    4efd:	31 f6                	xor    %esi,%esi
    4eff:	5b                   	pop    %rbx
    4f00:	41 5e                	pop    %r14
    4f02:	41 5f                	pop    %r15
    4f04:	e9 f7 d2 ff ff       	jmp    2200 <memset@plt>
    4f09:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000004f10 <f1>:
    4f10:	53                   	push   %rbx
    4f11:	48 83 ec 30          	sub    $0x30,%rsp
    4f15:	e8 86 00 00 00       	call   4fa0 <fwp_f32>
    4f1a:	e8 61 00 00 00       	call   4f80 <w1>
    4f1f:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    4f24:	f3 0f 11 4c 24 04    	movss  %xmm1,0x4(%rsp)
    4f2a:	e8 81 00 00 00       	call   4fb0 <fwp_from_f32>
    4f2f:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    4f34:	0f 28 44 24 20       	movaps 0x20(%rsp),%xmm0
    4f39:	0f c6 c0 55          	shufps $0x55,%xmm0,%xmm0
    4f3d:	e8 6e 00 00 00       	call   4fb0 <fwp_from_f32>
    4f42:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    4f47:	f3 0f 10 44 24 04    	movss  0x4(%rsp),%xmm0
    4f4d:	e8 5e 00 00 00       	call   4fb0 <fwp_from_f32>
    4f52:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    4f57:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    4f5c:	bf 03 00 00 00       	mov    $0x3,%edi
    4f61:	e8 fa e0 ff ff       	call   3060 <fwp_record>
    4f66:	48 89 c3             	mov    %rax,%rbx
    4f69:	48 89 c7             	mov    %rax,%rdi
    4f6c:	e8 af e0 ff ff       	call   3020 <fwp_rc_fresh>
    4f71:	48 89 d8             	mov    %rbx,%rax
    4f74:	48 83 c4 30          	add    $0x30,%rsp
    4f78:	5b                   	pop    %rbx
    4f79:	c3                   	ret
    4f7a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000004f80 <w1>:
    4f80:	50                   	push   %rax
    4f81:	e8 2a 00 00 00       	call   4fb0 <fwp_from_f32>
    4f86:	48 89 c7             	mov    %rax,%rdi
    4f89:	e8 12 00 00 00       	call   4fa0 <fwp_f32>
    4f8e:	0f 28 d0             	movaps %xmm0,%xmm2
    4f91:	0f c6 d0 00          	shufps $0x0,%xmm0,%xmm2
    4f95:	0f 28 c8             	movaps %xmm0,%xmm1
    4f98:	0f 28 c2             	movaps %xmm2,%xmm0
    4f9b:	58                   	pop    %rax
    4f9c:	c3                   	ret
    4f9d:	0f 1f 00             	nopl   (%rax)

0000000000004fa0 <fwp_f32>:
    4fa0:	66 0f 6e c7          	movd   %edi,%xmm0
    4fa4:	c3                   	ret
    4fa5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    4fac:	00 00 00 00 

0000000000004fb0 <fwp_from_f32>:
    4fb0:	66 0f 7e c0          	movd   %xmm0,%eax
    4fb4:	c3                   	ret
    4fb5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    4fbc:	00 00 00 00 

0000000000004fc0 <f2>:
    4fc0:	55                   	push   %rbp
    4fc1:	41 57                	push   %r15
    4fc3:	41 56                	push   %r14
    4fc5:	41 55                	push   %r13
    4fc7:	41 54                	push   %r12
    4fc9:	53                   	push   %rbx
    4fca:	48 81 ec e8 00 00 00 	sub    $0xe8,%rsp
    4fd1:	48 89 fe             	mov    %rdi,%rsi
    4fd4:	48 8d bc 24 90 00 00 	lea    0x90(%rsp),%rdi
    4fdb:	00 
    4fdc:	e8 ff 00 00 00       	call   50e0 <w2>
    4fe1:	48 8b 84 24 90 00 00 	mov    0x90(%rsp),%rax
    4fe8:	00 
    4fe9:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    4fee:	48 8b 8c 24 98 00 00 	mov    0x98(%rsp),%rcx
    4ff5:	00 
    4ff6:	48 89 0c 24          	mov    %rcx,(%rsp)
    4ffa:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    4fff:	48 89 4c 24 58       	mov    %rcx,0x58(%rsp)
    5004:	4c 8b a4 24 a0 00 00 	mov    0xa0(%rsp),%r12
    500b:	00 
    500c:	4c 89 64 24 60       	mov    %r12,0x60(%rsp)
    5011:	4c 8b ac 24 a8 00 00 	mov    0xa8(%rsp),%r13
    5018:	00 
    5019:	4c 89 6c 24 68       	mov    %r13,0x68(%rsp)
    501e:	48 8b ac 24 b0 00 00 	mov    0xb0(%rsp),%rbp
    5025:	00 
    5026:	48 89 6c 24 70       	mov    %rbp,0x70(%rsp)
    502b:	48 8b 9c 24 b8 00 00 	mov    0xb8(%rsp),%rbx
    5032:	00 
    5033:	48 89 5c 24 78       	mov    %rbx,0x78(%rsp)
    5038:	4c 8b b4 24 c0 00 00 	mov    0xc0(%rsp),%r14
    503f:	00 
    5040:	4c 89 b4 24 80 00 00 	mov    %r14,0x80(%rsp)
    5047:	00 
    5048:	4c 8b bc 24 c8 00 00 	mov    0xc8(%rsp),%r15
    504f:	00 
    5050:	4c 89 bc 24 88 00 00 	mov    %r15,0x88(%rsp)
    5057:	00 
    5058:	48 8d 35 91 03 00 00 	lea    0x391(%rip),%rsi        # 53f0 <fwp_owner_release7>
    505f:	48 8d bc 24 d0 00 00 	lea    0xd0(%rsp),%rdi
    5066:	00 
    5067:	48 8d 54 24 50       	lea    0x50(%rsp),%rdx
    506c:	e8 5f 03 00 00       	call   53d0 <fwp_cleanup_push>
    5071:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    5076:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    507b:	48 8b 04 24          	mov    (%rsp),%rax
    507f:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    5084:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
    5089:	4c 89 6c 24 28       	mov    %r13,0x28(%rsp)
    508e:	48 89 6c 24 30       	mov    %rbp,0x30(%rsp)
    5093:	48 89 5c 24 38       	mov    %rbx,0x38(%rsp)
    5098:	4c 89 74 24 40       	mov    %r14,0x40(%rsp)
    509d:	4c 89 7c 24 48       	mov    %r15,0x48(%rsp)
    50a2:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    50a7:	bf 08 00 00 00       	mov    $0x8,%edi
    50ac:	e8 af df ff ff       	call   3060 <fwp_record>
    50b1:	49 89 c6             	mov    %rax,%r14
    50b4:	48 89 c7             	mov    %rax,%rdi
    50b7:	e8 64 df ff ff       	call   3020 <fwp_rc_fresh>
    50bc:	48 8d bc 24 d0 00 00 	lea    0xd0(%rsp),%rdi
    50c3:	00 
    50c4:	e8 77 03 00 00       	call   5440 <fwp_cleanup_pop>
    50c9:	4c 89 f0             	mov    %r14,%rax
    50cc:	48 81 c4 e8 00 00 00 	add    $0xe8,%rsp
    50d3:	5b                   	pop    %rbx
    50d4:	41 5c                	pop    %r12
    50d6:	41 5d                	pop    %r13
    50d8:	41 5e                	pop    %r14
    50da:	41 5f                	pop    %r15
    50dc:	5d                   	pop    %rbp
    50dd:	c3                   	ret
    50de:	66 90                	xchg   %ax,%ax

00000000000050e0 <w2>:
    50e0:	55                   	push   %rbp
    50e1:	41 57                	push   %r15
    50e3:	41 56                	push   %r14
    50e5:	41 55                	push   %r13
    50e7:	41 54                	push   %r12
    50e9:	53                   	push   %rbx
    50ea:	48 81 ec b8 01 00 00 	sub    $0x1b8,%rsp
    50f1:	49 89 f6             	mov    %rsi,%r14
    50f4:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
    50f9:	48 89 f7             	mov    %rsi,%rdi
    50fc:	48 c7 c6 80 ff ff ff 	mov    $0xffffffffffffff80,%rsi
    5103:	e8 58 03 00 00       	call   5460 <f12>
    5108:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    510d:	49 89 c7             	mov    %rax,%r15
    5110:	48 8d 35 59 03 00 00 	lea    0x359(%rip),%rsi        # 5470 <fwp_owner_release0>
    5117:	4c 8d ac 24 a0 01 00 	lea    0x1a0(%rsp),%r13
    511e:	00 
    511f:	48 8d 54 24 30       	lea    0x30(%rsp),%rdx
    5124:	4c 89 ef             	mov    %r13,%rdi
    5127:	e8 a4 02 00 00       	call   53d0 <fwp_cleanup_push>
    512c:	be ff 00 00 00       	mov    $0xff,%esi
    5131:	4c 89 f7             	mov    %r14,%rdi
    5134:	e8 47 03 00 00       	call   5480 <f14>
    5139:	49 89 c4             	mov    %rax,%r12
    513c:	4c 89 ef             	mov    %r13,%rdi
    513f:	e8 fc 02 00 00       	call   5440 <fwp_cleanup_pop>
    5144:	4c 89 7c 24 38       	mov    %r15,0x38(%rsp)
    5149:	4c 89 64 24 40       	mov    %r12,0x40(%rsp)
    514e:	48 8d 35 3b 03 00 00 	lea    0x33b(%rip),%rsi        # 5490 <fwp_owner_release1>
    5155:	4c 8d ac 24 88 01 00 	lea    0x188(%rsp),%r13
    515c:	00 
    515d:	48 8d 54 24 38       	lea    0x38(%rsp),%rdx
    5162:	4c 89 ef             	mov    %r13,%rdi
    5165:	e8 66 02 00 00       	call   53d0 <fwp_cleanup_push>
    516a:	4c 89 f7             	mov    %r14,%rdi
    516d:	48 c7 c6 00 80 ff ff 	mov    $0xffffffffffff8000,%rsi
    5174:	e8 37 03 00 00       	call   54b0 <f16>
    5179:	48 89 c5             	mov    %rax,%rbp
    517c:	4c 89 ef             	mov    %r13,%rdi
    517f:	e8 bc 02 00 00       	call   5440 <fwp_cleanup_pop>
    5184:	4c 89 7c 24 48       	mov    %r15,0x48(%rsp)
    5189:	4c 89 64 24 50       	mov    %r12,0x50(%rsp)
    518e:	48 89 6c 24 58       	mov    %rbp,0x58(%rsp)
    5193:	48 8d 35 26 03 00 00 	lea    0x326(%rip),%rsi        # 54c0 <fwp_owner_release2>
    519a:	48 8d 9c 24 70 01 00 	lea    0x170(%rsp),%rbx
    51a1:	00 
    51a2:	48 8d 54 24 48       	lea    0x48(%rsp),%rdx
    51a7:	48 89 df             	mov    %rbx,%rdi
    51aa:	e8 21 02 00 00       	call   53d0 <fwp_cleanup_push>
    51af:	be ff ff 00 00       	mov    $0xffff,%esi
    51b4:	4c 89 f7             	mov    %r14,%rdi
    51b7:	e8 24 03 00 00       	call   54e0 <f18>
    51bc:	49 89 c5             	mov    %rax,%r13
    51bf:	48 89 df             	mov    %rbx,%rdi
    51c2:	e8 79 02 00 00       	call   5440 <fwp_cleanup_pop>
    51c7:	4c 89 7c 24 60       	mov    %r15,0x60(%rsp)
    51cc:	4c 89 3c 24          	mov    %r15,(%rsp)
    51d0:	4c 89 64 24 68       	mov    %r12,0x68(%rsp)
    51d5:	4c 89 e3             	mov    %r12,%rbx
    51d8:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
    51dd:	48 89 6c 24 70       	mov    %rbp,0x70(%rsp)
    51e2:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
    51e7:	4c 89 6c 24 78       	mov    %r13,0x78(%rsp)
    51ec:	48 8d 35 fd 02 00 00 	lea    0x2fd(%rip),%rsi        # 54f0 <fwp_owner_release3>
    51f3:	48 8d bc 24 40 01 00 	lea    0x140(%rsp),%rdi
    51fa:	00 
    51fb:	48 8d 54 24 60       	lea    0x60(%rsp),%rdx
    5200:	e8 cb 01 00 00       	call   53d0 <fwp_cleanup_push>
    5205:	4c 89 f7             	mov    %r14,%rdi
    5208:	48 c7 c6 00 00 00 80 	mov    $0xffffffff80000000,%rsi
    520f:	e8 0c 03 00 00       	call   5520 <f20>
    5214:	49 89 c4             	mov    %rax,%r12
    5217:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    521c:	48 8d bc 24 40 01 00 	lea    0x140(%rsp),%rdi
    5223:	00 
    5224:	e8 17 02 00 00       	call   5440 <fwp_cleanup_pop>
    5229:	4c 89 bc 24 80 00 00 	mov    %r15,0x80(%rsp)
    5230:	00 
    5231:	48 89 9c 24 88 00 00 	mov    %rbx,0x88(%rsp)
    5238:	00 
    5239:	48 89 ac 24 90 00 00 	mov    %rbp,0x90(%rsp)
    5240:	00 
    5241:	4c 89 ac 24 98 00 00 	mov    %r13,0x98(%rsp)
    5248:	00 
    5249:	4c 89 a4 24 a0 00 00 	mov    %r12,0xa0(%rsp)
    5250:	00 
    5251:	48 8d 35 d8 02 00 00 	lea    0x2d8(%rip),%rsi        # 5530 <fwp_owner_release4>
    5258:	4c 8d a4 24 58 01 00 	lea    0x158(%rsp),%r12
    525f:	00 
    5260:	48 8d 94 24 80 00 00 	lea    0x80(%rsp),%rdx
    5267:	00 
    5268:	4c 89 e7             	mov    %r12,%rdi
    526b:	e8 60 01 00 00       	call   53d0 <fwp_cleanup_push>
    5270:	b8 00 00 00 80       	mov    $0x80000000,%eax
    5275:	48 8d b0 ff ff ff 7f 	lea    0x7fffffff(%rax),%rsi
    527c:	4c 89 f7             	mov    %r14,%rdi
    527f:	4c 89 f3             	mov    %r14,%rbx
    5282:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    5287:	e8 e4 02 00 00       	call   5570 <f22>
    528c:	49 89 c7             	mov    %rax,%r15
    528f:	4c 89 e7             	mov    %r12,%rdi
    5292:	e8 a9 01 00 00       	call   5440 <fwp_cleanup_pop>
    5297:	48 8b 04 24          	mov    (%rsp),%rax
    529b:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
    52a2:	00 
    52a3:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
    52a8:	48 89 ac 24 b0 00 00 	mov    %rbp,0xb0(%rsp)
    52af:	00 
    52b0:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    52b5:	4c 89 a4 24 b8 00 00 	mov    %r12,0xb8(%rsp)
    52bc:	00 
    52bd:	4c 89 ac 24 c0 00 00 	mov    %r13,0xc0(%rsp)
    52c4:	00 
    52c5:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
    52ca:	4c 89 b4 24 c8 00 00 	mov    %r14,0xc8(%rsp)
    52d1:	00 
    52d2:	4c 89 bc 24 d0 00 00 	mov    %r15,0xd0(%rsp)
    52d9:	00 
    52da:	48 8d 35 9f 02 00 00 	lea    0x29f(%rip),%rsi        # 5580 <fwp_owner_release5>
    52e1:	48 8d bc 24 28 01 00 	lea    0x128(%rsp),%rdi
    52e8:	00 
    52e9:	48 8d 94 24 a8 00 00 	lea    0xa8(%rsp),%rdx
    52f0:	00 
    52f1:	e8 da 00 00 00       	call   53d0 <fwp_cleanup_push>
    52f6:	be 00 00 00 80       	mov    $0x80000000,%esi
    52fb:	48 89 df             	mov    %rbx,%rdi
    52fe:	e8 bd 02 00 00       	call   55c0 <f24>
    5303:	48 89 c3             	mov    %rax,%rbx
    5306:	48 8d bc 24 28 01 00 	lea    0x128(%rsp),%rdi
    530d:	00 
    530e:	e8 2d 01 00 00       	call   5440 <fwp_cleanup_pop>
    5313:	48 8b 04 24          	mov    (%rsp),%rax
    5317:	48 89 84 24 d8 00 00 	mov    %rax,0xd8(%rsp)
    531e:	00 
    531f:	48 89 ac 24 e0 00 00 	mov    %rbp,0xe0(%rsp)
    5326:	00 
    5327:	4c 89 a4 24 e8 00 00 	mov    %r12,0xe8(%rsp)
    532e:	00 
    532f:	4c 89 ac 24 f0 00 00 	mov    %r13,0xf0(%rsp)
    5336:	00 
    5337:	4c 89 b4 24 f8 00 00 	mov    %r14,0xf8(%rsp)
    533e:	00 
    533f:	4c 89 bc 24 00 01 00 	mov    %r15,0x100(%rsp)
    5346:	00 
    5347:	48 89 9c 24 08 01 00 	mov    %rbx,0x108(%rsp)
    534e:	00 
    534f:	48 8d 35 7a 02 00 00 	lea    0x27a(%rip),%rsi        # 55d0 <fwp_owner_release6>
    5356:	48 8d bc 24 10 01 00 	lea    0x110(%rsp),%rdi
    535d:	00 
    535e:	48 8d 94 24 d8 00 00 	lea    0xd8(%rsp),%rdx
    5365:	00 
    5366:	e8 65 00 00 00       	call   53d0 <fwp_cleanup_push>
    536b:	48 be 00 00 00 00 00 	movabs $0x8000000000000000,%rsi
    5372:	00 00 80 
    5375:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    537a:	e8 a1 02 00 00       	call   5620 <f26>
    537f:	49 89 c6             	mov    %rax,%r14
    5382:	48 8d bc 24 10 01 00 	lea    0x110(%rsp),%rdi
    5389:	00 
    538a:	e8 b1 00 00 00       	call   5440 <fwp_cleanup_pop>
    538f:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    5394:	48 8b 0c 24          	mov    (%rsp),%rcx
    5398:	48 89 08             	mov    %rcx,(%rax)
    539b:	48 89 68 08          	mov    %rbp,0x8(%rax)
    539f:	4c 89 60 10          	mov    %r12,0x10(%rax)
    53a3:	4c 89 68 18          	mov    %r13,0x18(%rax)
    53a7:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    53ac:	48 89 48 20          	mov    %rcx,0x20(%rax)
    53b0:	4c 89 78 28          	mov    %r15,0x28(%rax)
    53b4:	48 89 58 30          	mov    %rbx,0x30(%rax)
    53b8:	4c 89 70 38          	mov    %r14,0x38(%rax)
    53bc:	48 81 c4 b8 01 00 00 	add    $0x1b8,%rsp
    53c3:	5b                   	pop    %rbx
    53c4:	41 5c                	pop    %r12
    53c6:	41 5d                	pop    %r13
    53c8:	41 5e                	pop    %r14
    53ca:	41 5f                	pop    %r15
    53cc:	5d                   	pop    %rbp
    53cd:	c3                   	ret
    53ce:	66 90                	xchg   %ax,%ax

00000000000053d0 <fwp_cleanup_push>:
    53d0:	48 8b 05 01 0a 01 00 	mov    0x10a01(%rip),%rax        # 15dd8 <fwp_cleanups>
    53d7:	48 89 07             	mov    %rax,(%rdi)
    53da:	48 89 77 08          	mov    %rsi,0x8(%rdi)
    53de:	48 89 57 10          	mov    %rdx,0x10(%rdi)
    53e2:	48 89 3d ef 09 01 00 	mov    %rdi,0x109ef(%rip)        # 15dd8 <fwp_cleanups>
    53e9:	c3                   	ret
    53ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000053f0 <fwp_owner_release7>:
    53f0:	53                   	push   %rbx
    53f1:	48 89 fb             	mov    %rdi,%rbx
    53f4:	48 8b 3f             	mov    (%rdi),%rdi
    53f7:	e8 34 03 00 00       	call   5730 <fwp_drop0>
    53fc:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    5400:	e8 eb 05 00 00       	call   59f0 <fwp_drop1>
    5405:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    5409:	e8 02 06 00 00       	call   5a10 <fwp_drop2>
    540e:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    5412:	e8 19 06 00 00       	call   5a30 <fwp_drop3>
    5417:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    541b:	e8 30 06 00 00       	call   5a50 <fwp_drop4>
    5420:	48 8b 7b 28          	mov    0x28(%rbx),%rdi
    5424:	e8 47 06 00 00       	call   5a70 <fwp_drop5>
    5429:	48 8b 7b 30          	mov    0x30(%rbx),%rdi
    542d:	e8 5e 06 00 00       	call   5a90 <fwp_drop6>
    5432:	48 8b 7b 38          	mov    0x38(%rbx),%rdi
    5436:	5b                   	pop    %rbx
    5437:	e9 74 06 00 00       	jmp    5ab0 <fwp_drop7>
    543c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000005440 <fwp_cleanup_pop>:
    5440:	48 39 3d 91 09 01 00 	cmp    %rdi,0x10991(%rip)        # 15dd8 <fwp_cleanups>
    5447:	75 0b                	jne    5454 <fwp_cleanup_pop+0x14>
    5449:	48 8b 07             	mov    (%rdi),%rax
    544c:	48 89 05 85 09 01 00 	mov    %rax,0x10985(%rip)        # 15dd8 <fwp_cleanups>
    5453:	c3                   	ret
    5454:	50                   	push   %rax
    5455:	e8 16 cc ff ff       	call   2070 <abort@plt>
    545a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000005460 <f12>:
    5460:	e9 cb 01 00 00       	jmp    5630 <fwp_p_array_make_typed>
    5465:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    546c:	00 00 00 00 

0000000000005470 <fwp_owner_release0>:
    5470:	48 8b 3f             	mov    (%rdi),%rdi
    5473:	e9 b8 02 00 00       	jmp    5730 <fwp_drop0>
    5478:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    547f:	00 

0000000000005480 <f14>:
    5480:	e9 ab 01 00 00       	jmp    5630 <fwp_p_array_make_typed>
    5485:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    548c:	00 00 00 00 

0000000000005490 <fwp_owner_release1>:
    5490:	53                   	push   %rbx
    5491:	48 89 fb             	mov    %rdi,%rbx
    5494:	48 8b 3f             	mov    (%rdi),%rdi
    5497:	e8 94 02 00 00       	call   5730 <fwp_drop0>
    549c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    54a0:	5b                   	pop    %rbx
    54a1:	e9 4a 05 00 00       	jmp    59f0 <fwp_drop1>
    54a6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    54ad:	00 00 00 

00000000000054b0 <f16>:
    54b0:	e9 7b 01 00 00       	jmp    5630 <fwp_p_array_make_typed>
    54b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    54bc:	00 00 00 00 

00000000000054c0 <fwp_owner_release2>:
    54c0:	53                   	push   %rbx
    54c1:	48 89 fb             	mov    %rdi,%rbx
    54c4:	48 8b 3f             	mov    (%rdi),%rdi
    54c7:	e8 64 02 00 00       	call   5730 <fwp_drop0>
    54cc:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    54d0:	e8 1b 05 00 00       	call   59f0 <fwp_drop1>
    54d5:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    54d9:	5b                   	pop    %rbx
    54da:	e9 31 05 00 00       	jmp    5a10 <fwp_drop2>
    54df:	90                   	nop

00000000000054e0 <f18>:
    54e0:	e9 4b 01 00 00       	jmp    5630 <fwp_p_array_make_typed>
    54e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    54ec:	00 00 00 00 

00000000000054f0 <fwp_owner_release3>:
    54f0:	53                   	push   %rbx
    54f1:	48 89 fb             	mov    %rdi,%rbx
    54f4:	48 8b 3f             	mov    (%rdi),%rdi
    54f7:	e8 34 02 00 00       	call   5730 <fwp_drop0>
    54fc:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    5500:	e8 eb 04 00 00       	call   59f0 <fwp_drop1>
    5505:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    5509:	e8 02 05 00 00       	call   5a10 <fwp_drop2>
    550e:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    5512:	5b                   	pop    %rbx
    5513:	e9 18 05 00 00       	jmp    5a30 <fwp_drop3>
    5518:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    551f:	00 

0000000000005520 <f20>:
    5520:	e9 0b 01 00 00       	jmp    5630 <fwp_p_array_make_typed>
    5525:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    552c:	00 00 00 00 

0000000000005530 <fwp_owner_release4>:
    5530:	53                   	push   %rbx
    5531:	48 89 fb             	mov    %rdi,%rbx
    5534:	48 8b 3f             	mov    (%rdi),%rdi
    5537:	e8 f4 01 00 00       	call   5730 <fwp_drop0>
    553c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    5540:	e8 ab 04 00 00       	call   59f0 <fwp_drop1>
    5545:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    5549:	e8 c2 04 00 00       	call   5a10 <fwp_drop2>
    554e:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    5552:	e8 d9 04 00 00       	call   5a30 <fwp_drop3>
    5557:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    555b:	5b                   	pop    %rbx
    555c:	e9 ef 04 00 00       	jmp    5a50 <fwp_drop4>
    5561:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5568:	0f 1f 84 00 00 00 00 
    556f:	00 

0000000000005570 <f22>:
    5570:	e9 bb 00 00 00       	jmp    5630 <fwp_p_array_make_typed>
    5575:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    557c:	00 00 00 00 

0000000000005580 <fwp_owner_release5>:
    5580:	53                   	push   %rbx
    5581:	48 89 fb             	mov    %rdi,%rbx
    5584:	48 8b 3f             	mov    (%rdi),%rdi
    5587:	e8 a4 01 00 00       	call   5730 <fwp_drop0>
    558c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    5590:	e8 5b 04 00 00       	call   59f0 <fwp_drop1>
    5595:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    5599:	e8 72 04 00 00       	call   5a10 <fwp_drop2>
    559e:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    55a2:	e8 89 04 00 00       	call   5a30 <fwp_drop3>
    55a7:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    55ab:	e8 a0 04 00 00       	call   5a50 <fwp_drop4>
    55b0:	48 8b 7b 28          	mov    0x28(%rbx),%rdi
    55b4:	5b                   	pop    %rbx
    55b5:	e9 b6 04 00 00       	jmp    5a70 <fwp_drop5>
    55ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000055c0 <f24>:
    55c0:	eb 6e                	jmp    5630 <fwp_p_array_make_typed>
    55c2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    55c9:	1f 84 00 00 00 00 00 

00000000000055d0 <fwp_owner_release6>:
    55d0:	53                   	push   %rbx
    55d1:	48 89 fb             	mov    %rdi,%rbx
    55d4:	48 8b 3f             	mov    (%rdi),%rdi
    55d7:	e8 54 01 00 00       	call   5730 <fwp_drop0>
    55dc:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    55e0:	e8 0b 04 00 00       	call   59f0 <fwp_drop1>
    55e5:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    55e9:	e8 22 04 00 00       	call   5a10 <fwp_drop2>
    55ee:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    55f2:	e8 39 04 00 00       	call   5a30 <fwp_drop3>
    55f7:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    55fb:	e8 50 04 00 00       	call   5a50 <fwp_drop4>
    5600:	48 8b 7b 28          	mov    0x28(%rbx),%rdi
    5604:	e8 67 04 00 00       	call   5a70 <fwp_drop5>
    5609:	48 8b 7b 30          	mov    0x30(%rbx),%rdi
    560d:	5b                   	pop    %rbx
    560e:	e9 7d 04 00 00       	jmp    5a90 <fwp_drop6>
    5613:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    561a:	84 00 00 00 00 00 

0000000000005620 <f26>:
    5620:	eb 0e                	jmp    5630 <fwp_p_array_make_typed>
    5622:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5629:	1f 84 00 00 00 00 00 

0000000000005630 <fwp_p_array_make_typed>:
    5630:	41 56                	push   %r14
    5632:	53                   	push   %rbx
    5633:	50                   	push   %rax
    5634:	48 89 f3             	mov    %rsi,%rbx
    5637:	e8 64 00 00 00       	call   56a0 <fwp_count_arg>
    563c:	49 89 c6             	mov    %rax,%r14
    563f:	48 89 c7             	mov    %rax,%rdi
    5642:	e8 69 00 00 00       	call   56b0 <fwp_array_typed_new>
    5647:	4d 85 f6             	test   %r14,%r14
    564a:	74 48                	je     5694 <fwp_p_array_make_typed+0x64>
    564c:	49 83 fe 04          	cmp    $0x4,%r14
    5650:	73 04                	jae    5656 <fwp_p_array_make_typed+0x26>
    5652:	31 c9                	xor    %ecx,%ecx
    5654:	eb 31                	jmp    5687 <fwp_p_array_make_typed+0x57>
    5656:	4c 89 f1             	mov    %r14,%rcx
    5659:	48 83 e1 fc          	and    $0xfffffffffffffffc,%rcx
    565d:	66 48 0f 6e c3       	movq   %rbx,%xmm0
    5662:	66 0f 70 c0 44       	pshufd $0x44,%xmm0,%xmm0
    5667:	31 d2                	xor    %edx,%edx
    5669:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    5670:	f3 0f 7f 44 d0 08    	movdqu %xmm0,0x8(%rax,%rdx,8)
    5676:	f3 0f 7f 44 d0 18    	movdqu %xmm0,0x18(%rax,%rdx,8)
    567c:	48 83 c2 04          	add    $0x4,%rdx
    5680:	48 39 d1             	cmp    %rdx,%rcx
    5683:	75 eb                	jne    5670 <fwp_p_array_make_typed+0x40>
    5685:	eb 08                	jmp    568f <fwp_p_array_make_typed+0x5f>
    5687:	48 89 5c c8 08       	mov    %rbx,0x8(%rax,%rcx,8)
    568c:	48 ff c1             	inc    %rcx
    568f:	49 39 ce             	cmp    %rcx,%r14
    5692:	75 f3                	jne    5687 <fwp_p_array_make_typed+0x57>
    5694:	48 83 c4 08          	add    $0x8,%rsp
    5698:	5b                   	pop    %rbx
    5699:	41 5e                	pop    %r14
    569b:	c3                   	ret
    569c:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000056a0 <fwp_count_arg>:
    56a0:	31 c0                	xor    %eax,%eax
    56a2:	48 85 ff             	test   %rdi,%rdi
    56a5:	48 0f 4f c7          	cmovg  %rdi,%rax
    56a9:	c3                   	ret
    56aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000056b0 <fwp_array_typed_new>:
    56b0:	50                   	push   %rax
    56b1:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    56b8:	ff ff 1f 
    56bb:	48 39 c7             	cmp    %rax,%rdi
    56be:	73 0e                	jae    56ce <fwp_array_typed_new+0x1e>
    56c0:	e8 1b 00 00 00       	call   56e0 <fwp_arr_new>
    56c5:	48 89 c7             	mov    %rax,%rdi
    56c8:	58                   	pop    %rax
    56c9:	e9 52 d9 ff ff       	jmp    3020 <fwp_rc_fresh>
    56ce:	48 8d 3d 81 91 00 00 	lea    0x9181(%rip),%rdi        # e856 <exec_in_fp0+0x1f6>
    56d5:	e8 a6 d8 ff ff       	call   2f80 <fwp_trap>
    56da:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000056e0 <fwp_arr_new>:
    56e0:	53                   	push   %rbx
    56e1:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    56e8:	ff ff 1f 
    56eb:	48 39 c7             	cmp    %rax,%rdi
    56ee:	73 15                	jae    5705 <fwp_arr_new+0x25>
    56f0:	48 89 fb             	mov    %rdi,%rbx
    56f3:	48 8d 3c fd 08 00 00 	lea    0x8(,%rdi,8),%rdi
    56fa:	00 
    56fb:	e8 20 00 00 00       	call   5720 <fwp_alloc>
    5700:	48 89 18             	mov    %rbx,(%rax)
    5703:	5b                   	pop    %rbx
    5704:	c3                   	ret
    5705:	48 8d 3d 4a 91 00 00 	lea    0x914a(%rip),%rdi        # e856 <exec_in_fp0+0x1f6>
    570c:	e8 6f d8 ff ff       	call   2f80 <fwp_trap>
    5711:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5718:	0f 1f 84 00 00 00 00 
    571f:	00 

0000000000005720 <fwp_alloc>:
    5720:	be 02 00 00 00       	mov    $0x2,%esi
    5725:	e9 06 db ff ff       	jmp    3230 <fwp_gc_alloc>
    572a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000005730 <fwp_drop0>:
    5730:	53                   	push   %rbx
    5731:	48 89 fb             	mov    %rdi,%rbx
    5734:	e8 b7 d2 ff ff       	call   29f0 <fwp_rc_release_last>
    5739:	85 c0                	test   %eax,%eax
    573b:	74 06                	je     5743 <fwp_drop0+0x13>
    573d:	48 89 df             	mov    %rbx,%rdi
    5740:	5b                   	pop    %rbx
    5741:	eb 0d                	jmp    5750 <fwp_rc_free_arr>
    5743:	5b                   	pop    %rbx
    5744:	c3                   	ret
    5745:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    574c:	00 00 00 00 

0000000000005750 <fwp_rc_free_arr>:
    5750:	41 56                	push   %r14
    5752:	53                   	push   %rbx
    5753:	50                   	push   %rax
    5754:	48 89 fb             	mov    %rdi,%rbx
    5757:	e8 94 00 00 00       	call   57f0 <fwp_rc_last>
    575c:	85 c0                	test   %eax,%eax
    575e:	74 7d                	je     57dd <fwp_rc_free_arr+0x8d>
    5760:	8b 0d 4a 05 01 00    	mov    0x1054a(%rip),%ecx        # 15cb0 <fwp_reuse_verify>
    5766:	85 c9                	test   %ecx,%ecx
    5768:	78 0d                	js     5777 <fwp_rc_free_arr+0x27>
    576a:	85 c9                	test   %ecx,%ecx
    576c:	74 41                	je     57af <fwp_rc_free_arr+0x5f>
    576e:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    5775:	eb 66                	jmp    57dd <fwp_rc_free_arr+0x8d>
    5777:	48 8d 3d e8 90 00 00 	lea    0x90e8(%rip),%rdi        # e866 <exec_in_fp0+0x206>
    577e:	e8 ad c8 ff ff       	call   2030 <getenv@plt>
    5783:	31 c9                	xor    %ecx,%ecx
    5785:	48 85 c0             	test   %rax,%rax
    5788:	74 1b                	je     57a5 <fwp_rc_free_arr+0x55>
    578a:	80 38 00             	cmpb   $0x0,(%rax)
    578d:	74 16                	je     57a5 <fwp_rc_free_arr+0x55>
    578f:	48 8d 35 02 9c 00 00 	lea    0x9c02(%rip),%rsi        # f398 <exec_in_fp0+0xd38>
    5796:	48 89 c7             	mov    %rax,%rdi
    5799:	e8 22 cb ff ff       	call   22c0 <strcmp@plt>
    579e:	31 c9                	xor    %ecx,%ecx
    57a0:	85 c0                	test   %eax,%eax
    57a2:	0f 95 c1             	setne  %cl
    57a5:	89 0d 05 05 01 00    	mov    %ecx,0x10505(%rip)        # 15cb0 <fwp_reuse_verify>
    57ab:	85 c9                	test   %ecx,%ecx
    57ad:	75 bf                	jne    576e <fwp_rc_free_arr+0x1e>
    57af:	4c 8b 35 da ea 00 00 	mov    0xeada(%rip),%r14        # 14290 <fwp_gc>
    57b6:	48 89 df             	mov    %rbx,%rdi
    57b9:	e8 52 00 00 00       	call   5810 <fwp_mem_free>
    57be:	48 8b 05 cb ea 00 00 	mov    0xeacb(%rip),%rax        # 14290 <fwp_gc>
    57c5:	4c 29 f0             	sub    %r14,%rax
    57c8:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    57cd:	f2 0f 58 05 c3 fc 00 	addsd  0xfcc3(%rip),%xmm0        # 15498 <fwp_gc+0x1208>
    57d4:	00 
    57d5:	f2 0f 11 05 bb fc 00 	movsd  %xmm0,0xfcbb(%rip)        # 15498 <fwp_gc+0x1208>
    57dc:	00 
    57dd:	48 83 c4 08          	add    $0x8,%rsp
    57e1:	5b                   	pop    %rbx
    57e2:	41 5e                	pop    %r14
    57e4:	c3                   	ret
    57e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    57ec:	00 00 00 00 

00000000000057f0 <fwp_rc_last>:
    57f0:	50                   	push   %rax
    57f1:	e8 4a d6 ff ff       	call   2e40 <fwp_rc_slot>
    57f6:	48 85 c0             	test   %rax,%rax
    57f9:	74 0d                	je     5808 <fwp_rc_last+0x18>
    57fb:	48 89 c1             	mov    %rax,%rcx
    57fe:	31 c0                	xor    %eax,%eax
    5800:	80 39 01             	cmpb   $0x1,(%rcx)
    5803:	0f 94 c0             	sete   %al
    5806:	59                   	pop    %rcx
    5807:	c3                   	ret
    5808:	31 c0                	xor    %eax,%eax
    580a:	59                   	pop    %rcx
    580b:	c3                   	ret
    580c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000005810 <fwp_mem_free>:
    5810:	48 85 ff             	test   %rdi,%rdi
    5813:	0f 84 c7 01 00 00    	je     59e0 <fwp_mem_free+0x1d0>
    5819:	41 57                	push   %r15
    581b:	41 56                	push   %r14
    581d:	53                   	push   %rbx
    581e:	48 83 ec 10          	sub    $0x10,%rsp
    5822:	49 89 ff             	mov    %rdi,%r15
    5825:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    582a:	e8 41 f5 ff ff       	call   4d70 <fwp_gc_chunk_of>
    582f:	48 85 c0             	test   %rax,%rax
    5832:	0f 84 9f 01 00 00    	je     59d7 <fwp_mem_free+0x1c7>
    5838:	49 89 c6             	mov    %rax,%r14
    583b:	0f b6 00             	movzbl (%rax),%eax
    583e:	83 f8 02             	cmp    $0x2,%eax
    5841:	0f 84 96 00 00 00    	je     58dd <fwp_mem_free+0xcd>
    5847:	83 f8 01             	cmp    $0x1,%eax
    584a:	0f 85 87 01 00 00    	jne    59d7 <fwp_mem_free+0x1c7>
    5850:	41 0f b6 46 01       	movzbl 0x1(%r14),%eax
    5855:	41 0f b6 4e 02       	movzbl 0x2(%r14),%ecx
    585a:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    5861:	48 8d 35 28 ea 00 00 	lea    0xea28(%rip),%rsi        # 14290 <fwp_gc>
    5868:	48 01 c6             	add    %rax,%rsi
    586b:	48 8d 3c 49          	lea    (%rcx,%rcx,2),%rdi
    586f:	41 0f b7 c7          	movzwl %r15w,%eax
    5873:	31 d2                	xor    %edx,%edx
    5875:	41 f7 76 08          	divl   0x8(%r14)
    5879:	48 c7 c2 fe ff ff ff 	mov    $0xfffffffffffffffe,%rdx
    5880:	89 c1                	mov    %eax,%ecx
    5882:	48 d3 c2             	rol    %cl,%rdx
    5885:	48 8d 1c fe          	lea    (%rsi,%rdi,8),%rbx
    5889:	48 83 c3 08          	add    $0x8,%rbx
    588d:	49 8d 3c 06          	lea    (%r14,%rax,1),%rdi
    5891:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    5898:	c1 e8 03             	shr    $0x3,%eax
    589b:	25 f8 1f 00 00       	and    $0x1ff8,%eax
    58a0:	49 21 54 06 28       	and    %rdx,0x28(%r14,%rax,1)
    58a5:	e8 06 d6 ff ff       	call   2eb0 <fwp_rc_clear_slot>
    58aa:	83 3d e3 f9 00 00 00 	cmpl   $0x0,0xf9e3(%rip)        # 15294 <fwp_gc+0x1004>
    58b1:	74 0e                	je     58c1 <fwp_mem_free+0xb1>
    58b3:	41 8b 56 08          	mov    0x8(%r14),%edx
    58b7:	4c 89 ff             	mov    %r15,%rdi
    58ba:	31 f6                	xor    %esi,%esi
    58bc:	e8 3f c9 ff ff       	call   2200 <memset@plt>
    58c1:	48 8b 03             	mov    (%rbx),%rax
    58c4:	48 f7 d0             	not    %rax
    58c7:	49 89 07             	mov    %rax,(%r15)
    58ca:	4c 89 3b             	mov    %r15,(%rbx)
    58cd:	41 8b 46 08          	mov    0x8(%r14),%eax
    58d1:	48 01 05 b8 e9 00 00 	add    %rax,0xe9b8(%rip)        # 14290 <fwp_gc>
    58d8:	e9 fa 00 00 00       	jmp    59d7 <fwp_mem_free+0x1c7>
    58dd:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    58e2:	48 89 df             	mov    %rbx,%rdi
    58e5:	e8 e6 d5 ff ff       	call   2ed0 <fwp_gc_chunk_addr>
    58ea:	4c 39 f8             	cmp    %r15,%rax
    58ed:	0f 85 e4 00 00 00    	jne    59d7 <fwp_mem_free+0x1c7>
    58f3:	49 8b 46 18          	mov    0x18(%r14),%rax
    58f7:	48 01 05 92 e9 00 00 	add    %rax,0xe992(%rip)        # 14290 <fwp_gc>
    58fe:	41 c6 46 03 00       	movb   $0x0,0x3(%r14)
    5903:	4c 89 f7             	mov    %r14,%rdi
    5906:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    590d:	e8 9e d5 ff ff       	call   2eb0 <fwp_rc_clear_slot>
    5912:	41 8b 46 10          	mov    0x10(%r14),%eax
    5916:	48 85 c0             	test   %rax,%rax
    5919:	0f 84 91 00 00 00    	je     59b0 <fwp_mem_free+0x1a0>
    591f:	48 8b 0d e2 f9 00 00 	mov    0xf9e2(%rip),%rcx        # 15308 <fwp_gc+0x1078>
    5926:	48 69 f3 28 12 00 00 	imul   $0x1228,%rbx,%rsi
    592d:	89 c2                	mov    %eax,%edx
    592f:	83 e2 03             	and    $0x3,%edx
    5932:	83 f8 04             	cmp    $0x4,%eax
    5935:	73 04                	jae    593b <fwp_mem_free+0x12b>
    5937:	31 ff                	xor    %edi,%edi
    5939:	eb 41                	jmp    597c <fwp_mem_free+0x16c>
    593b:	4c 8d 04 31          	lea    (%rcx,%rsi,1),%r8
    593f:	41 89 c1             	mov    %eax,%r9d
    5942:	41 83 e1 fc          	and    $0xfffffffc,%r9d
    5946:	31 ff                	xor    %edi,%edi
    5948:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    594f:	00 
    5950:	41 c6 00 00          	movb   $0x0,(%r8)
    5954:	41 c6 80 28 12 00 00 	movb   $0x0,0x1228(%r8)
    595b:	00 
    595c:	41 c6 80 50 24 00 00 	movb   $0x0,0x2450(%r8)
    5963:	00 
    5964:	41 c6 80 78 36 00 00 	movb   $0x0,0x3678(%r8)
    596b:	00 
    596c:	48 83 c7 04          	add    $0x4,%rdi
    5970:	49 81 c0 a0 48 00 00 	add    $0x48a0,%r8
    5977:	49 39 f9             	cmp    %rdi,%r9
    597a:	75 d4                	jne    5950 <fwp_mem_free+0x140>
    597c:	48 85 d2             	test   %rdx,%rdx
    597f:	74 2f                	je     59b0 <fwp_mem_free+0x1a0>
    5981:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    5988:	48 01 f7             	add    %rsi,%rdi
    598b:	48 01 f9             	add    %rdi,%rcx
    598e:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5995:	31 f6                	xor    %esi,%esi
    5997:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    599e:	00 00 
    59a0:	c6 04 31 00          	movb   $0x0,(%rcx,%rsi,1)
    59a4:	48 81 c6 28 12 00 00 	add    $0x1228,%rsi
    59ab:	48 39 f2             	cmp    %rsi,%rdx
    59ae:	75 f0                	jne    59a0 <fwp_mem_free+0x190>
    59b0:	48 01 05 b9 fa 00 00 	add    %rax,0xfab9(%rip)        # 15470 <fwp_gc+0x11e0>
    59b7:	48 3b 1d 42 f9 00 00 	cmp    0xf942(%rip),%rbx        # 15300 <fwp_gc+0x1070>
    59be:	73 07                	jae    59c7 <fwp_mem_free+0x1b7>
    59c0:	48 89 1d 39 f9 00 00 	mov    %rbx,0xf939(%rip)        # 15300 <fwp_gc+0x1070>
    59c7:	48 3b 1d 2a f9 00 00 	cmp    0xf92a(%rip),%rbx        # 152f8 <fwp_gc+0x1068>
    59ce:	73 07                	jae    59d7 <fwp_mem_free+0x1c7>
    59d0:	48 89 1d 21 f9 00 00 	mov    %rbx,0xf921(%rip)        # 152f8 <fwp_gc+0x1068>
    59d7:	48 83 c4 10          	add    $0x10,%rsp
    59db:	5b                   	pop    %rbx
    59dc:	41 5e                	pop    %r14
    59de:	41 5f                	pop    %r15
    59e0:	c3                   	ret
    59e1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    59e8:	0f 1f 84 00 00 00 00 
    59ef:	00 

00000000000059f0 <fwp_drop1>:
    59f0:	53                   	push   %rbx
    59f1:	48 89 fb             	mov    %rdi,%rbx
    59f4:	e8 f7 cf ff ff       	call   29f0 <fwp_rc_release_last>
    59f9:	85 c0                	test   %eax,%eax
    59fb:	74 09                	je     5a06 <fwp_drop1+0x16>
    59fd:	48 89 df             	mov    %rbx,%rdi
    5a00:	5b                   	pop    %rbx
    5a01:	e9 4a fd ff ff       	jmp    5750 <fwp_rc_free_arr>
    5a06:	5b                   	pop    %rbx
    5a07:	c3                   	ret
    5a08:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    5a0f:	00 

0000000000005a10 <fwp_drop2>:
    5a10:	53                   	push   %rbx
    5a11:	48 89 fb             	mov    %rdi,%rbx
    5a14:	e8 d7 cf ff ff       	call   29f0 <fwp_rc_release_last>
    5a19:	85 c0                	test   %eax,%eax
    5a1b:	74 09                	je     5a26 <fwp_drop2+0x16>
    5a1d:	48 89 df             	mov    %rbx,%rdi
    5a20:	5b                   	pop    %rbx
    5a21:	e9 2a fd ff ff       	jmp    5750 <fwp_rc_free_arr>
    5a26:	5b                   	pop    %rbx
    5a27:	c3                   	ret
    5a28:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    5a2f:	00 

0000000000005a30 <fwp_drop3>:
    5a30:	53                   	push   %rbx
    5a31:	48 89 fb             	mov    %rdi,%rbx
    5a34:	e8 b7 cf ff ff       	call   29f0 <fwp_rc_release_last>
    5a39:	85 c0                	test   %eax,%eax
    5a3b:	74 09                	je     5a46 <fwp_drop3+0x16>
    5a3d:	48 89 df             	mov    %rbx,%rdi
    5a40:	5b                   	pop    %rbx
    5a41:	e9 0a fd ff ff       	jmp    5750 <fwp_rc_free_arr>
    5a46:	5b                   	pop    %rbx
    5a47:	c3                   	ret
    5a48:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    5a4f:	00 

0000000000005a50 <fwp_drop4>:
    5a50:	53                   	push   %rbx
    5a51:	48 89 fb             	mov    %rdi,%rbx
    5a54:	e8 97 cf ff ff       	call   29f0 <fwp_rc_release_last>
    5a59:	85 c0                	test   %eax,%eax
    5a5b:	74 09                	je     5a66 <fwp_drop4+0x16>
    5a5d:	48 89 df             	mov    %rbx,%rdi
    5a60:	5b                   	pop    %rbx
    5a61:	e9 ea fc ff ff       	jmp    5750 <fwp_rc_free_arr>
    5a66:	5b                   	pop    %rbx
    5a67:	c3                   	ret
    5a68:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    5a6f:	00 

0000000000005a70 <fwp_drop5>:
    5a70:	53                   	push   %rbx
    5a71:	48 89 fb             	mov    %rdi,%rbx
    5a74:	e8 77 cf ff ff       	call   29f0 <fwp_rc_release_last>
    5a79:	85 c0                	test   %eax,%eax
    5a7b:	74 09                	je     5a86 <fwp_drop5+0x16>
    5a7d:	48 89 df             	mov    %rbx,%rdi
    5a80:	5b                   	pop    %rbx
    5a81:	e9 ca fc ff ff       	jmp    5750 <fwp_rc_free_arr>
    5a86:	5b                   	pop    %rbx
    5a87:	c3                   	ret
    5a88:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    5a8f:	00 

0000000000005a90 <fwp_drop6>:
    5a90:	53                   	push   %rbx
    5a91:	48 89 fb             	mov    %rdi,%rbx
    5a94:	e8 57 cf ff ff       	call   29f0 <fwp_rc_release_last>
    5a99:	85 c0                	test   %eax,%eax
    5a9b:	74 09                	je     5aa6 <fwp_drop6+0x16>
    5a9d:	48 89 df             	mov    %rbx,%rdi
    5aa0:	5b                   	pop    %rbx
    5aa1:	e9 aa fc ff ff       	jmp    5750 <fwp_rc_free_arr>
    5aa6:	5b                   	pop    %rbx
    5aa7:	c3                   	ret
    5aa8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    5aaf:	00 

0000000000005ab0 <fwp_drop7>:
    5ab0:	53                   	push   %rbx
    5ab1:	48 89 fb             	mov    %rdi,%rbx
    5ab4:	e8 37 cf ff ff       	call   29f0 <fwp_rc_release_last>
    5ab9:	85 c0                	test   %eax,%eax
    5abb:	74 09                	je     5ac6 <fwp_drop7+0x16>
    5abd:	48 89 df             	mov    %rbx,%rdi
    5ac0:	5b                   	pop    %rbx
    5ac1:	e9 8a fc ff ff       	jmp    5750 <fwp_rc_free_arr>
    5ac6:	5b                   	pop    %rbx
    5ac7:	c3                   	ret
    5ac8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    5acf:	00 

0000000000005ad0 <f4>:
    5ad0:	50                   	push   %rax
    5ad1:	e8 3a d5 ff ff       	call   3010 <fwp_f64>
    5ad6:	e8 15 00 00 00       	call   5af0 <w4>
    5adb:	58                   	pop    %rax
    5adc:	e9 ff ce ff ff       	jmp    29e0 <fwp_from_f64>
    5ae1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5ae8:	0f 1f 84 00 00 00 00 
    5aef:	00 

0000000000005af0 <w4>:
    5af0:	50                   	push   %rax
    5af1:	e8 ea ce ff ff       	call   29e0 <fwp_from_f64>
    5af6:	48 bf 00 00 00 00 00 	movabs $0x3fc0000000000000,%rdi
    5afd:	00 c0 3f 
    5b00:	48 89 c6             	mov    %rax,%rsi
    5b03:	e8 18 00 00 00       	call   5b20 <f6>
    5b08:	48 89 c7             	mov    %rax,%rdi
    5b0b:	58                   	pop    %rax
    5b0c:	e9 ff d4 ff ff       	jmp    3010 <fwp_f64>
    5b11:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5b18:	0f 1f 84 00 00 00 00 
    5b1f:	00 

0000000000005b20 <f6>:
    5b20:	53                   	push   %rbx
    5b21:	48 83 ec 10          	sub    $0x10,%rsp
    5b25:	48 89 fb             	mov    %rdi,%rbx
    5b28:	48 89 f7             	mov    %rsi,%rdi
    5b2b:	e8 e0 d4 ff ff       	call   3010 <fwp_f64>
    5b30:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    5b36:	48 89 df             	mov    %rbx,%rdi
    5b39:	e8 d2 d4 ff ff       	call   3010 <fwp_f64>
    5b3e:	f2 0f 58 44 24 08    	addsd  0x8(%rsp),%xmm0
    5b44:	48 83 c4 10          	add    $0x10,%rsp
    5b48:	5b                   	pop    %rbx
    5b49:	e9 92 ce ff ff       	jmp    29e0 <fwp_from_f64>
    5b4e:	66 90                	xchg   %ax,%ax

0000000000005b50 <f10>:
    5b50:	50                   	push   %rax
    5b51:	e8 ba d4 ff ff       	call   3010 <fwp_f64>
    5b56:	0f 57 05 c3 85 00 00 	xorps  0x85c3(%rip),%xmm0        # e120 <_IO_stdin_used+0x120>
    5b5d:	58                   	pop    %rax
    5b5e:	e9 7d ce ff ff       	jmp    29e0 <fwp_from_f64>
    5b63:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5b6a:	84 00 00 00 00 00 

0000000000005b70 <fwp_stack_guard_init>:
    5b70:	53                   	push   %rbx
    5b71:	48 81 ec c0 00 00 00 	sub    $0xc0,%rsp
    5b78:	48 8d 44 24 0f       	lea    0xf(%rsp),%rax
    5b7d:	48 89 05 84 02 01 00 	mov    %rax,0x10284(%rip)        # 15e08 <fwp_main_stack_top>
    5b84:	48 89 3d 85 02 01 00 	mov    %rdi,0x10285(%rip)        # 15e10 <fwp_main_stack_size>
    5b8b:	48 8d 05 8e 02 01 00 	lea    0x1028e(%rip),%rax        # 15e20 <fwp_stack_guard_init.alt>
    5b92:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    5b97:	48 c7 44 24 20 00 00 	movq   $0x10000,0x20(%rsp)
    5b9e:	01 00 
    5ba0:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%rsp)
    5ba7:	00 
    5ba8:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    5bad:	31 f6                	xor    %esi,%esi
    5baf:	e8 0c c9 ff ff       	call   24c0 <sigaltstack@plt>
    5bb4:	85 c0                	test   %eax,%eax
    5bb6:	0f 85 80 00 00 00    	jne    5c3c <fwp_stack_guard_init+0xcc>
    5bbc:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    5bc1:	0f 57 c0             	xorps  %xmm0,%xmm0
    5bc4:	0f 11 84 24 b0 00 00 	movups %xmm0,0xb0(%rsp)
    5bcb:	00 
    5bcc:	0f 11 84 24 a0 00 00 	movups %xmm0,0xa0(%rsp)
    5bd3:	00 
    5bd4:	0f 11 84 24 90 00 00 	movups %xmm0,0x90(%rsp)
    5bdb:	00 
    5bdc:	0f 11 84 24 80 00 00 	movups %xmm0,0x80(%rsp)
    5be3:	00 
    5be4:	0f 11 44 24 70       	movups %xmm0,0x70(%rsp)
    5be9:	0f 11 44 24 60       	movups %xmm0,0x60(%rsp)
    5bee:	0f 11 44 24 50       	movups %xmm0,0x50(%rsp)
    5bf3:	0f 11 44 24 40       	movups %xmm0,0x40(%rsp)
    5bf8:	0f 11 44 24 30       	movups %xmm0,0x30(%rsp)
    5bfd:	48 8d 05 7c 07 00 00 	lea    0x77c(%rip),%rax        # 6380 <fwp_segv>
    5c04:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    5c09:	c7 84 24 b0 00 00 00 	movl   $0x8000004,0xb0(%rsp)
    5c10:	04 00 00 08 
    5c14:	e8 e7 c6 ff ff       	call   2300 <sigemptyset@plt>
    5c19:	48 8d 5c 24 28       	lea    0x28(%rsp),%rbx
    5c1e:	bf 0b 00 00 00       	mov    $0xb,%edi
    5c23:	48 89 de             	mov    %rbx,%rsi
    5c26:	31 d2                	xor    %edx,%edx
    5c28:	e8 a3 c4 ff ff       	call   20d0 <sigaction@plt>
    5c2d:	bf 07 00 00 00       	mov    $0x7,%edi
    5c32:	48 89 de             	mov    %rbx,%rsi
    5c35:	31 d2                	xor    %edx,%edx
    5c37:	e8 94 c4 ff ff       	call   20d0 <sigaction@plt>
    5c3c:	48 81 c4 c0 00 00 00 	add    $0xc0,%rsp
    5c43:	5b                   	pop    %rbx
    5c44:	c3                   	ret
    5c45:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    5c4c:	00 00 00 00 

0000000000005c50 <fwp_exec>:
    5c50:	55                   	push   %rbp
    5c51:	41 57                	push   %r15
    5c53:	41 56                	push   %r14
    5c55:	41 55                	push   %r13
    5c57:	41 54                	push   %r12
    5c59:	53                   	push   %rbx
    5c5a:	48 81 ec 58 01 00 00 	sub    $0x158,%rsp
    5c61:	49 89 f7             	mov    %rsi,%r15
    5c64:	41 89 fd             	mov    %edi,%r13d
    5c67:	41 8d 5d ff          	lea    -0x1(%r13),%ebx
    5c6b:	80 3d 8e 01 01 00 01 	cmpb   $0x1,0x1018e(%rip)        # 15e00 <fwp_cli_single>
    5c72:	75 16                	jne    5c8a <fwp_exec+0x3a>
    5c74:	49 8d 77 08          	lea    0x8(%r15),%rsi
    5c78:	89 df                	mov    %ebx,%edi
    5c7a:	e8 91 07 00 00       	call   6410 <fwp_generated>
    5c7f:	41 89 c6             	mov    %eax,%r14d
    5c82:	85 c0                	test   %eax,%eax
    5c84:	0f 89 1a 01 00 00    	jns    5da4 <fwp_exec+0x154>
    5c8a:	89 5c 24 18          	mov    %ebx,0x18(%rsp)
    5c8e:	49 63 fd             	movslq %r13d,%rdi
    5c91:	48 c1 e7 03          	shl    $0x3,%rdi
    5c95:	48 89 7c 24 48       	mov    %rdi,0x48(%rsp)
    5c9a:	e8 81 fa ff ff       	call   5720 <fwp_alloc>
    5c9f:	49 89 c4             	mov    %rax,%r12
    5ca2:	41 83 fd 02          	cmp    $0x2,%r13d
    5ca6:	7c 30                	jl     5cd8 <fwp_exec+0x88>
    5ca8:	8b 6c 24 18          	mov    0x18(%rsp),%ebp
    5cac:	31 db                	xor    %ebx,%ebx
    5cae:	66 90                	xchg   %ax,%ax
    5cb0:	4c 8d 73 01          	lea    0x1(%rbx),%r14
    5cb4:	4d 8b 6c df 08       	mov    0x8(%r15,%rbx,8),%r13
    5cb9:	4c 89 ef             	mov    %r13,%rdi
    5cbc:	e8 9f c4 ff ff       	call   2160 <strlen@plt>
    5cc1:	4c 89 ef             	mov    %r13,%rdi
    5cc4:	48 89 c6             	mov    %rax,%rsi
    5cc7:	e8 a4 08 00 00       	call   6570 <fwp_str_lossy>
    5ccc:	49 89 04 dc          	mov    %rax,(%r12,%rbx,8)
    5cd0:	4c 89 f3             	mov    %r14,%rbx
    5cd3:	4c 39 f5             	cmp    %r14,%rbp
    5cd6:	75 d8                	jne    5cb0 <fwp_exec+0x60>
    5cd8:	bf 08 00 00 00       	mov    $0x8,%edi
    5cdd:	e8 3e fa ff ff       	call   5720 <fwp_alloc>
    5ce2:	bf 01 00 00 00       	mov    $0x1,%edi
    5ce7:	e8 64 0a 00 00       	call   6750 <fwp_alloc_leaf>
    5cec:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
    5cf1:	e8 2a fa ff ff       	call   5720 <fwp_alloc>
    5cf6:	49 89 c6             	mov    %rax,%r14
    5cf9:	48 8d 4c 24 2c       	lea    0x2c(%rsp),%rcx
    5cfe:	8b 7c 24 18          	mov    0x18(%rsp),%edi
    5d02:	4c 89 e6             	mov    %r12,%rsi
    5d05:	48 89 c2             	mov    %rax,%rdx
    5d08:	e8 53 0a 00 00       	call   6760 <fwp_cli_parse>
    5d0d:	83 f8 02             	cmp    $0x2,%eax
    5d10:	74 32                	je     5d44 <fwp_exec+0xf4>
    5d12:	83 f8 01             	cmp    $0x1,%eax
    5d15:	75 5d                	jne    5d74 <fwp_exec+0x124>
    5d17:	48 8b 1d 9a e2 00 00 	mov    0xe29a(%rip),%rbx        # 13fb8 <stdout@GLIBC_2.2.5>
    5d1e:	48 8b 0b             	mov    (%rbx),%rcx
    5d21:	48 8d 3d 21 97 00 00 	lea    0x9721(%rip),%rdi        # f449 <exec_in_fp0+0xde9>
    5d28:	be 72 00 00 00       	mov    $0x72,%esi
    5d2d:	ba 01 00 00 00       	mov    $0x1,%edx
    5d32:	e8 59 c7 ff ff       	call   2490 <fwrite@plt>
    5d37:	48 8b 3b             	mov    (%rbx),%rdi
    5d3a:	e8 01 c6 ff ff       	call   2340 <fflush@plt>
    5d3f:	45 31 f6             	xor    %r14d,%r14d
    5d42:	eb 60                	jmp    5da4 <fwp_exec+0x154>
    5d44:	48 8d 3d 6c 93 00 00 	lea    0x936c(%rip),%rdi        # f0b7 <exec_in_fp0+0xa57>
    5d4b:	48 8d 15 57 89 00 00 	lea    0x8957(%rip),%rdx        # e6a9 <exec_in_fp0+0x49>
    5d52:	45 31 f6             	xor    %r14d,%r14d
    5d55:	be 06 00 00 00       	mov    $0x6,%esi
    5d5a:	31 c9                	xor    %ecx,%ecx
    5d5c:	31 c0                	xor    %eax,%eax
    5d5e:	e8 4d c4 ff ff       	call   21b0 <printf@plt>
    5d63:	48 8b 05 4e e2 00 00 	mov    0xe24e(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    5d6a:	48 8b 38             	mov    (%rax),%rdi
    5d6d:	e8 ce c5 ff ff       	call   2340 <fflush@plt>
    5d72:	eb 30                	jmp    5da4 <fwp_exec+0x154>
    5d74:	bf 10 00 00 00       	mov    $0x10,%edi
    5d79:	e8 a2 f9 ff ff       	call   5720 <fwp_alloc>
    5d7e:	49 89 c7             	mov    %rax,%r15
    5d81:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%rsp)
    5d88:	00 
    5d89:	8b 74 24 2c          	mov    0x2c(%rsp),%esi
    5d8d:	48 8d 4c 24 14       	lea    0x14(%rsp),%rcx
    5d92:	4c 89 f7             	mov    %r14,%rdi
    5d95:	48 89 c2             	mov    %rax,%rdx
    5d98:	e8 23 0c 00 00       	call   69c0 <fwp_bind_positional>
    5d9d:	41 89 c6             	mov    %eax,%r14d
    5da0:	85 c0                	test   %eax,%eax
    5da2:	74 15                	je     5db9 <fwp_exec+0x169>
    5da4:	44 89 f0             	mov    %r14d,%eax
    5da7:	48 81 c4 58 01 00 00 	add    $0x158,%rsp
    5dae:	5b                   	pop    %rbx
    5daf:	41 5c                	pop    %r12
    5db1:	41 5d                	pop    %r13
    5db3:	41 5e                	pop    %r14
    5db5:	41 5f                	pop    %r15
    5db7:	5d                   	pop    %rbp
    5db8:	c3                   	ret
    5db9:	48 8d 3d 00 93 00 00 	lea    0x9300(%rip),%rdi        # f0c0 <exec_in_fp0+0xa60>
    5dc0:	e8 6b c2 ff ff       	call   2030 <getenv@plt>
    5dc5:	48 85 c0             	test   %rax,%rax
    5dc8:	74 27                	je     5df1 <fwp_exec+0x1a1>
    5dca:	48 8d 35 f7 92 00 00 	lea    0x92f7(%rip),%rsi        # f0c8 <exec_in_fp0+0xa68>
    5dd1:	48 89 c7             	mov    %rax,%rdi
    5dd4:	e8 e7 c4 ff ff       	call   22c0 <strcmp@plt>
    5dd9:	31 c9                	xor    %ecx,%ecx
    5ddb:	85 c0                	test   %eax,%eax
    5ddd:	0f 94 c1             	sete   %cl
    5de0:	89 0d 3a 00 02 00    	mov    %ecx,0x2003a(%rip)        # 25e20 <fwp_exec_binary_out>
    5de6:	75 26                	jne    5e0e <fwp_exec+0x1be>
    5de8:	48 8b 05 f1 e1 00 00 	mov    0xe1f1(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    5def:	eb 24                	jmp    5e15 <fwp_exec+0x1c5>
    5df1:	c7 05 25 00 02 00 00 	movl   $0x0,0x20025(%rip)        # 25e20 <fwp_exec_binary_out>
    5df8:	00 00 00 
    5dfb:	48 8b 05 b6 e1 00 00 	mov    0xe1b6(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    5e02:	48 8b 00             	mov    (%rax),%rax
    5e05:	48 89 05 9c ff 00 00 	mov    %rax,0xff9c(%rip)        # 15da8 <fwp_prog_out>
    5e0c:	eb 33                	jmp    5e41 <fwp_exec+0x1f1>
    5e0e:	48 8b 05 a3 e1 00 00 	mov    0xe1a3(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    5e15:	48 8b 00             	mov    (%rax),%rax
    5e18:	48 89 05 89 ff 00 00 	mov    %rax,0xff89(%rip)        # 15da8 <fwp_prog_out>
    5e1f:	75 20                	jne    5e41 <fwp_exec+0x1f1>
    5e21:	e8 da 0b 00 00       	call   6a00 <fwp_pipe_out_start>
    5e26:	48 8d 3d f3 87 00 00 	lea    0x87f3(%rip),%rdi        # e620 <exec_out_header0>
    5e2d:	be 3c 00 00 00       	mov    $0x3c,%esi
    5e32:	e8 99 0c 00 00       	call   6ad0 <fwp_pipe_write>
    5e37:	e8 44 0d 00 00       	call   6b80 <fwp_pipe_flush>
    5e3c:	e8 6f 0d 00 00       	call   6bb0 <fwp_pipe_out_ready>
    5e41:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%rsp)
    5e48:	00 
    5e49:	83 7c 24 14 00       	cmpl   $0x0,0x14(%rsp)
    5e4e:	0f 84 57 01 00 00    	je     5fab <fwp_exec+0x35b>
    5e54:	48 8b 1d 65 e1 00 00 	mov    0xe165(%rip),%rbx        # 13fc0 <stdin@GLIBC_2.2.5>
    5e5b:	48 8b 3b             	mov    (%rbx),%rdi
    5e5e:	b9 00 00 10 00       	mov    $0x100000,%ecx
    5e63:	31 f6                	xor    %esi,%esi
    5e65:	31 d2                	xor    %edx,%edx
    5e67:	e8 34 c5 ff ff       	call   23a0 <setvbuf@plt>
    5e6c:	48 8b 0b             	mov    (%rbx),%rcx
    5e6f:	48 8d 3d ae ff 01 00 	lea    0x1ffae(%rip),%rdi        # 25e24 <fwp_in_pend>
    5e76:	be 01 00 00 00       	mov    $0x1,%esi
    5e7b:	ba 04 00 00 00       	mov    $0x4,%edx
    5e80:	e8 5b c2 ff ff       	call   20e0 <fread@plt>
    5e85:	89 05 9d ff 01 00    	mov    %eax,0x1ff9d(%rip)        # 25e28 <fwp_in_npend>
    5e8b:	c7 05 97 ff 01 00 00 	movl   $0x0,0x1ff97(%rip)        # 25e2c <fwp_in_ppos>
    5e92:	00 00 00 
    5e95:	41 b4 01             	mov    $0x1,%r12b
    5e98:	83 f8 04             	cmp    $0x4,%eax
    5e9b:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    5ea0:	0f 85 d3 01 00 00    	jne    6079 <fwp_exec+0x429>
    5ea6:	81 3d 74 ff 01 00 46 	cmpl   $0x31505746,0x1ff74(%rip)        # 25e24 <fwp_in_pend>
    5ead:	57 50 31 
    5eb0:	0f 85 c3 01 00 00    	jne    6079 <fwp_exec+0x429>
    5eb6:	c7 05 6c ff 01 00 04 	movl   $0x4,0x1ff6c(%rip)        # 25e2c <fwp_in_ppos>
    5ebd:	00 00 00 
    5ec0:	48 8d 7c 24 03       	lea    0x3(%rsp),%rdi
    5ec5:	be 01 00 00 00       	mov    $0x1,%esi
    5eca:	e8 41 0e 00 00       	call   6d10 <fwp_read_exact>
    5ecf:	85 c0                	test   %eax,%eax
    5ed1:	0f 84 c3 03 00 00    	je     629a <fwp_exec+0x64a>
    5ed7:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
    5edc:	e8 2f 0f 00 00       	call   6e10 <fwp_stdin_leb>
    5ee1:	83 f8 01             	cmp    $0x1,%eax
    5ee4:	0f 85 99 03 00 00    	jne    6283 <fwp_exec+0x633>
    5eea:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    5eef:	48 83 f8 40          	cmp    $0x40,%rax
    5ef3:	41 bd 40 00 00 00    	mov    $0x40,%r13d
    5ef9:	4c 0f 42 e8          	cmovb  %rax,%r13
    5efd:	48 85 c0             	test   %rax,%rax
    5f00:	0f 84 e2 00 00 00    	je     5fe8 <fwp_exec+0x398>
    5f06:	45 31 f6             	xor    %r14d,%r14d
    5f09:	4c 8d 7c 24 50       	lea    0x50(%rsp),%r15
    5f0e:	31 ed                	xor    %ebp,%ebp
    5f10:	eb 4a                	jmp    5f5c <fwp_exec+0x30c>
    5f12:	be 06 00 00 00       	mov    $0x6,%esi
    5f17:	4c 89 ff             	mov    %r15,%rdi
    5f1a:	e8 f1 0d 00 00       	call   6d10 <fwp_read_exact>
    5f1f:	85 c0                	test   %eax,%eax
    5f21:	0f 84 73 03 00 00    	je     629a <fwp_exec+0x64a>
    5f27:	8b 44 24 50          	mov    0x50(%rsp),%eax
    5f2b:	b9 55 44 53 5f       	mov    $0x5f534455,%ecx
    5f30:	31 c8                	xor    %ecx,%eax
    5f32:	0f b7 4c 24 54       	movzwl 0x54(%rsp),%ecx
    5f37:	81 f1 56 31 00 00    	xor    $0x3156,%ecx
    5f3d:	09 c1                	or     %eax,%ecx
    5f3f:	b8 01 00 00 00       	mov    $0x1,%eax
    5f44:	0f 44 e8             	cmove  %eax,%ebp
    5f47:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
    5f4e:	00 00 
    5f50:	49 ff c6             	inc    %r14
    5f53:	4d 39 ee             	cmp    %r13,%r14
    5f56:	0f 84 8e 00 00 00    	je     5fea <fwp_exec+0x39a>
    5f5c:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    5f61:	e8 2a 0f 00 00       	call   6e90 <fwp_stdin_name_len>
    5f66:	83 f8 01             	cmp    $0x1,%eax
    5f69:	0f 85 14 03 00 00    	jne    6283 <fwp_exec+0x633>
    5f6f:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    5f74:	48 85 db             	test   %rbx,%rbx
    5f77:	74 ce                	je     5f47 <fwp_exec+0x2f7>
    5f79:	48 83 fb 06          	cmp    $0x6,%rbx
    5f7d:	74 93                	je     5f12 <fwp_exec+0x2c2>
    5f7f:	90                   	nop
    5f80:	48 81 fb 00 01 00 00 	cmp    $0x100,%rbx
    5f87:	41 bc 00 01 00 00    	mov    $0x100,%r12d
    5f8d:	4c 0f 42 e3          	cmovb  %rbx,%r12
    5f91:	4c 89 ff             	mov    %r15,%rdi
    5f94:	4c 89 e6             	mov    %r12,%rsi
    5f97:	e8 74 0d 00 00       	call   6d10 <fwp_read_exact>
    5f9c:	85 c0                	test   %eax,%eax
    5f9e:	0f 84 f6 02 00 00    	je     629a <fwp_exec+0x64a>
    5fa4:	4c 29 e3             	sub    %r12,%rbx
    5fa7:	75 d7                	jne    5f80 <fwp_exec+0x330>
    5fa9:	eb 9c                	jmp    5f47 <fwp_exec+0x2f7>
    5fab:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
    5fb0:	4c 89 ff             	mov    %r15,%rdi
    5fb3:	e8 98 0c 00 00       	call   6c50 <fwp_exec_call>
    5fb8:	48 89 c3             	mov    %rax,%rbx
    5fbb:	48 8b 3d e6 fd 00 00 	mov    0xfde6(%rip),%rdi        # 15da8 <fwp_prog_out>
    5fc2:	e8 79 c3 ff ff       	call   2340 <fflush@plt>
    5fc7:	41 be 01 00 00 00    	mov    $0x1,%r14d
    5fcd:	83 7c 24 04 00       	cmpl   $0x0,0x4(%rsp)
    5fd2:	0f 85 83 02 00 00    	jne    625b <fwp_exec+0x60b>
    5fd8:	48 89 df             	mov    %rbx,%rdi
    5fdb:	e8 20 0d 00 00       	call   6d00 <fwp_emit_result>
    5fe0:	45 31 f6             	xor    %r14d,%r14d
    5fe3:	e9 73 02 00 00       	jmp    625b <fwp_exec+0x60b>
    5fe8:	31 ed                	xor    %ebp,%ebp
    5fea:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    5fef:	be 10 00 00 00       	mov    $0x10,%esi
    5ff4:	e8 17 0d 00 00       	call   6d10 <fwp_read_exact>
    5ff9:	85 c0                	test   %eax,%eax
    5ffb:	0f 84 99 02 00 00    	je     629a <fwp_exec+0x64a>
    6001:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    6006:	e8 85 0e 00 00       	call   6e90 <fwp_stdin_name_len>
    600b:	83 f8 01             	cmp    $0x1,%eax
    600e:	0f 85 6f 02 00 00    	jne    6283 <fwp_exec+0x633>
    6014:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    6019:	49 8d 7f 01          	lea    0x1(%r15),%rdi
    601d:	e8 2e 07 00 00       	call   6750 <fwp_alloc_leaf>
    6022:	49 89 c6             	mov    %rax,%r14
    6025:	4d 85 ff             	test   %r15,%r15
    6028:	74 13                	je     603d <fwp_exec+0x3ed>
    602a:	4c 89 f7             	mov    %r14,%rdi
    602d:	4c 89 fe             	mov    %r15,%rsi
    6030:	e8 db 0c 00 00       	call   6d10 <fwp_read_exact>
    6035:	85 c0                	test   %eax,%eax
    6037:	0f 84 5d 02 00 00    	je     629a <fwp_exec+0x64a>
    603d:	43 c6 04 3e 00       	movb   $0x0,(%r14,%r15,1)
    6042:	0f b6 4c 24 03       	movzbl 0x3(%rsp),%ecx
    6047:	83 f9 01             	cmp    $0x1,%ecx
    604a:	0f 85 ab 02 00 00    	jne    62fb <fwp_exec+0x6ab>
    6050:	66 0f 6f 44 24 30    	movdqa 0x30(%rsp),%xmm0
    6056:	66 0f 74 05 d2 80 00 	pcmpeqb 0x80d2(%rip),%xmm0        # e130 <_IO_stdin_used+0x130>
    605d:	00 
    605e:	66 0f d7 c0          	pmovmskb %xmm0,%eax
    6062:	3d ff ff 00 00       	cmp    $0xffff,%eax
    6067:	0f 85 af 02 00 00    	jne    631c <fwp_exec+0x6cc>
    606d:	85 ed                	test   %ebp,%ebp
    606f:	74 05                	je     6076 <fwp_exec+0x426>
    6071:	e8 4a 0e 00 00       	call   6ec0 <fwp_pipe_in_offer>
    6076:	45 31 e4             	xor    %r12d,%r12d
    6079:	66 0f ef c0          	pxor   %xmm0,%xmm0
    607d:	66 0f 7f 44 24 50    	movdqa %xmm0,0x50(%rsp)
    6083:	48 c7 44 24 60 00 00 	movq   $0x0,0x60(%rsp)
    608a:	00 00 
    608c:	45 31 ff             	xor    %r15d,%r15d
    608f:	45 31 f6             	xor    %r14d,%r14d
    6092:	eb 35                	jmp    60c9 <fwp_exec+0x479>
    6094:	48 89 ef             	mov    %rbp,%rdi
    6097:	4c 89 ee             	mov    %r13,%rsi
    609a:	e8 21 0f 00 00       	call   6fc0 <fwp_pipe_in_switch>
    609f:	bb 10 00 00 00       	mov    $0x10,%ebx
    60a4:	48 8d 35 99 90 00 00 	lea    0x9099(%rip),%rsi        # f144 <exec_in_fp0+0xae4>
    60ab:	85 c0                	test   %eax,%eax
    60ad:	0f 84 6b 01 00 00    	je     621e <fwp_exec+0x5ce>
    60b3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    60ba:	84 00 00 00 00 00 
    60c0:	83 fb 0f             	cmp    $0xf,%ebx
    60c3:	0f 84 83 01 00 00    	je     624c <fwp_exec+0x5fc>
    60c9:	45 84 e4             	test   %r12b,%r12b
    60cc:	0f 84 9e 00 00 00    	je     6170 <fwp_exec+0x520>
    60d2:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    60d7:	e8 44 15 00 00       	call   7620 <fwp_read_text_line>
    60dc:	4c 8b 7c 24 50       	mov    0x50(%rsp),%r15
    60e1:	85 c0                	test   %eax,%eax
    60e3:	0f 84 63 01 00 00    	je     624c <fwp_exec+0x5fc>
    60e9:	4d 85 ff             	test   %r15,%r15
    60ec:	4c 89 ff             	mov    %r15,%rdi
    60ef:	48 8d 05 c0 8f 00 00 	lea    0x8fc0(%rip),%rax        # f0b6 <exec_in_fp0+0xa56>
    60f6:	48 0f 44 f8          	cmove  %rax,%rdi
    60fa:	48 8b 74 24 58       	mov    0x58(%rsp),%rsi
    60ff:	e8 6c 04 00 00       	call   6570 <fwp_str_lossy>
    6104:	48 89 c5             	mov    %rax,%rbp
    6107:	4c 8d 68 08          	lea    0x8(%rax),%r13
    610b:	48 8b 30             	mov    (%rax),%rsi
    610e:	4c 89 ef             	mov    %r13,%rdi
    6111:	48 8d 54 24 20       	lea    0x20(%rsp),%rdx
    6116:	e8 e5 07 00 00       	call   6900 <fwp_parse_text>
    611b:	85 c0                	test   %eax,%eax
    611d:	0f 84 a1 01 00 00    	je     62c4 <fwp_exec+0x674>
    6123:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    6128:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    612d:	48 89 07             	mov    %rax,(%rdi)
    6130:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
    6135:	e8 16 0b 00 00       	call   6c50 <fwp_exec_call>
    613a:	49 89 c5             	mov    %rax,%r13
    613d:	48 8b 3d 64 fc 00 00 	mov    0xfc64(%rip),%rdi        # 15da8 <fwp_prog_out>
    6144:	e8 f7 c1 ff ff       	call   2340 <fflush@plt>
    6149:	83 7c 24 04 00       	cmpl   $0x0,0x4(%rsp)
    614e:	0f 85 f2 00 00 00    	jne    6246 <fwp_exec+0x5f6>
    6154:	4c 89 ef             	mov    %r13,%rdi
    6157:	e8 a4 0b 00 00       	call   6d00 <fwp_emit_result>
    615c:	e8 1f 0a 00 00       	call   6b80 <fwp_pipe_flush>
    6161:	31 db                	xor    %ebx,%ebx
    6163:	e9 58 ff ff ff       	jmp    60c0 <fwp_exec+0x470>
    6168:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    616f:	00 
    6170:	be 01 00 00 00       	mov    $0x1,%esi
    6175:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    617a:	e8 91 0b 00 00       	call   6d10 <fwp_read_exact>
    617f:	bb 0f 00 00 00       	mov    $0xf,%ebx
    6184:	85 c0                	test   %eax,%eax
    6186:	0f 84 34 ff ff ff    	je     60c0 <fwp_exec+0x470>
    618c:	be 04 00 00 00       	mov    $0x4,%esi
    6191:	48 8d 7c 24 09       	lea    0x9(%rsp),%rdi
    6196:	e8 75 0b 00 00       	call   6d10 <fwp_read_exact>
    619b:	48 8d 35 8d 8f 00 00 	lea    0x8f8d(%rip),%rsi        # f12f <exec_in_fp0+0xacf>
    61a2:	85 c0                	test   %eax,%eax
    61a4:	74 78                	je     621e <fwp_exec+0x5ce>
    61a6:	44 8b 6c 24 09       	mov    0x9(%rsp),%r13d
    61ab:	49 8d 7d 01          	lea    0x1(%r13),%rdi
    61af:	e8 9c 05 00 00       	call   6750 <fwp_alloc_leaf>
    61b4:	48 89 c5             	mov    %rax,%rbp
    61b7:	4d 85 ed             	test   %r13,%r13
    61ba:	74 16                	je     61d2 <fwp_exec+0x582>
    61bc:	48 89 ef             	mov    %rbp,%rdi
    61bf:	4c 89 ee             	mov    %r13,%rsi
    61c2:	e8 49 0b 00 00       	call   6d10 <fwp_read_exact>
    61c7:	48 8d 35 61 8f 00 00 	lea    0x8f61(%rip),%rsi        # f12f <exec_in_fp0+0xacf>
    61ce:	85 c0                	test   %eax,%eax
    61d0:	74 4c                	je     621e <fwp_exec+0x5ce>
    61d2:	0f b6 44 24 08       	movzbl 0x8(%rsp),%eax
    61d7:	85 c0                	test   %eax,%eax
    61d9:	0f 84 e1 fe ff ff    	je     60c0 <fwp_exec+0x470>
    61df:	83 f8 02             	cmp    $0x2,%eax
    61e2:	0f 84 ac fe ff ff    	je     6094 <fwp_exec+0x444>
    61e8:	48 89 6c 24 30       	mov    %rbp,0x30(%rsp)
    61ed:	4c 89 6c 24 38       	mov    %r13,0x38(%rsp)
    61f2:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    61f9:	00 00 
    61fb:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    6200:	48 8d 35 21 fb 00 00 	lea    0xfb21(%rip),%rsi        # 15d28 <d0>
    6207:	48 8d 54 24 20       	lea    0x20(%rsp),%rdx
    620c:	e8 cf 0f 00 00       	call   71e0 <fwp_decode>
    6211:	85 c0                	test   %eax,%eax
    6213:	0f 85 0a ff ff ff    	jne    6123 <fwp_exec+0x4d3>
    6219:	e9 2c 01 00 00       	jmp    634a <fwp_exec+0x6fa>
    621e:	48 8b 05 bb dd 00 00 	mov    0xddbb(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    6225:	48 8b 38             	mov    (%rax),%rdi
    6228:	48 8d 15 7a 84 00 00 	lea    0x847a(%rip),%rdx        # e6a9 <exec_in_fp0+0x49>
    622f:	31 c0                	xor    %eax,%eax
    6231:	e8 aa c0 ff ff       	call   22e0 <fprintf@plt>
    6236:	41 be 03 00 00 00    	mov    $0x3,%r14d
    623c:	bb 0f 00 00 00       	mov    $0xf,%ebx
    6241:	e9 7a fe ff ff       	jmp    60c0 <fwp_exec+0x470>
    6246:	41 be 01 00 00 00    	mov    $0x1,%r14d
    624c:	31 ff                	xor    %edi,%edi
    624e:	e8 bd f5 ff ff       	call   5810 <fwp_mem_free>
    6253:	4c 89 ff             	mov    %r15,%rdi
    6256:	e8 f5 bd ff ff       	call   2050 <free@plt>
    625b:	83 3d be fb 01 00 00 	cmpl   $0x0,0x1fbbe(%rip)        # 25e20 <fwp_exec_binary_out>
    6262:	0f 84 fb fa ff ff    	je     5d63 <fwp_exec+0x113>
    6268:	48 8d 3d ac 83 00 00 	lea    0x83ac(%rip),%rdi        # e61b <fwp_exec.end>
    626f:	be 05 00 00 00       	mov    $0x5,%esi
    6274:	e8 57 08 00 00       	call   6ad0 <fwp_pipe_write>
    6279:	e8 b2 14 00 00       	call   7730 <fwp_pipe_out_end>
    627e:	e9 e0 fa ff ff       	jmp    5d63 <fwp_exec+0x113>
    6283:	85 c0                	test   %eax,%eax
    6285:	79 13                	jns    629a <fwp_exec+0x64a>
    6287:	48 8b 05 52 dd 00 00 	mov    0xdd52(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    628e:	48 8b 38             	mov    (%rax),%rdi
    6291:	48 8d 35 fc 8e 00 00 	lea    0x8efc(%rip),%rsi        # f194 <exec_in_fp0+0xb34>
    6298:	eb 11                	jmp    62ab <fwp_exec+0x65b>
    629a:	48 8b 05 3f dd 00 00 	mov    0xdd3f(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    62a1:	48 8b 38             	mov    (%rax),%rdi
    62a4:	48 8d 35 f9 8e 00 00 	lea    0x8ef9(%rip),%rsi        # f1a4 <exec_in_fp0+0xb44>
    62ab:	48 8d 15 f7 83 00 00 	lea    0x83f7(%rip),%rdx        # e6a9 <exec_in_fp0+0x49>
    62b2:	31 c0                	xor    %eax,%eax
    62b4:	e8 27 c0 ff ff       	call   22e0 <fprintf@plt>
    62b9:	41 be 03 00 00 00    	mov    $0x3,%r14d
    62bf:	e9 e0 fa ff ff       	jmp    5da4 <fwp_exec+0x154>
    62c4:	48 8b 05 15 dd 00 00 	mov    0xdd15(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    62cb:	48 8b 38             	mov    (%rax),%rdi
    62ce:	8b 4d 00             	mov    0x0(%rbp),%ecx
    62d1:	48 8d 35 97 8e 00 00 	lea    0x8e97(%rip),%rsi        # f16f <exec_in_fp0+0xb0f>
    62d8:	48 8d 15 ca 83 00 00 	lea    0x83ca(%rip),%rdx        # e6a9 <exec_in_fp0+0x49>
    62df:	4c 8d 0d d6 91 00 00 	lea    0x91d6(%rip),%r9        # f4bc <exec_in_fp0+0xe5c>
    62e6:	4d 89 e8             	mov    %r13,%r8
    62e9:	31 c0                	xor    %eax,%eax
    62eb:	e8 f0 bf ff ff       	call   22e0 <fprintf@plt>
    62f0:	41 be 03 00 00 00    	mov    $0x3,%r14d
    62f6:	e9 51 ff ff ff       	jmp    624c <fwp_exec+0x5fc>
    62fb:	48 8b 05 de dc 00 00 	mov    0xdcde(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    6302:	48 8b 38             	mov    (%rax),%rdi
    6305:	48 8d 35 cc 8d 00 00 	lea    0x8dcc(%rip),%rsi        # f0d8 <exec_in_fp0+0xa78>
    630c:	48 8d 15 96 83 00 00 	lea    0x8396(%rip),%rdx        # e6a9 <exec_in_fp0+0x49>
    6313:	31 c0                	xor    %eax,%eax
    6315:	e8 c6 bf ff ff       	call   22e0 <fprintf@plt>
    631a:	eb 9d                	jmp    62b9 <fwp_exec+0x669>
    631c:	48 8b 05 bd dc 00 00 	mov    0xdcbd(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    6323:	48 8b 38             	mov    (%rax),%rdi
    6326:	48 8d 35 d0 8d 00 00 	lea    0x8dd0(%rip),%rsi        # f0fd <exec_in_fp0+0xa9d>
    632d:	48 8d 15 75 83 00 00 	lea    0x8375(%rip),%rdx        # e6a9 <exec_in_fp0+0x49>
    6334:	48 8d 0d 81 91 00 00 	lea    0x9181(%rip),%rcx        # f4bc <exec_in_fp0+0xe5c>
    633b:	4d 89 f0             	mov    %r14,%r8
    633e:	31 c0                	xor    %eax,%eax
    6340:	e8 9b bf ff ff       	call   22e0 <fprintf@plt>
    6345:	e9 6f ff ff ff       	jmp    62b9 <fwp_exec+0x669>
    634a:	48 8b 05 8f dc 00 00 	mov    0xdc8f(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    6351:	48 8b 38             	mov    (%rax),%rdi
    6354:	48 8d 35 ff 8d 00 00 	lea    0x8dff(%rip),%rsi        # f15a <exec_in_fp0+0xafa>
    635b:	48 8d 15 47 83 00 00 	lea    0x8347(%rip),%rdx        # e6a9 <exec_in_fp0+0x49>
    6362:	31 c0                	xor    %eax,%eax
    6364:	e8 77 bf ff ff       	call   22e0 <fprintf@plt>
    6369:	41 be 03 00 00 00    	mov    $0x3,%r14d
    636f:	e9 d8 fe ff ff       	jmp    624c <fwp_exec+0x5fc>
    6374:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    637b:	00 00 00 00 00 

0000000000006380 <fwp_segv>:
    6380:	53                   	push   %rbx
    6381:	48 8b 15 80 fa 00 00 	mov    0xfa80(%rip),%rdx        # 15e08 <fwp_main_stack_top>
    6388:	48 85 d2             	test   %rdx,%rdx
    638b:	74 29                	je     63b6 <fwp_segv+0x36>
    638d:	48 8b 46 10          	mov    0x10(%rsi),%rax
    6391:	48 2b 15 78 fa 00 00 	sub    0xfa78(%rip),%rdx        # 15e10 <fwp_main_stack_size>
    6398:	48 8d b2 00 00 f0 ff 	lea    -0x100000(%rdx),%rsi
    639f:	48 81 c2 00 00 10 00 	add    $0x100000,%rdx
    63a6:	89 fb                	mov    %edi,%ebx
    63a8:	48 89 c7             	mov    %rax,%rdi
    63ab:	e8 40 00 00 00       	call   63f0 <fwp_near>
    63b0:	89 df                	mov    %ebx,%edi
    63b2:	85 c0                	test   %eax,%eax
    63b4:	75 08                	jne    63be <fwp_segv+0x3e>
    63b6:	31 f6                	xor    %esi,%esi
    63b8:	5b                   	pop    %rbx
    63b9:	e9 12 bf ff ff       	jmp    22d0 <signal@plt>
    63be:	e8 ed cb ff ff       	call   2fb0 <fwp_flush>
    63c3:	48 8d 35 36 82 00 00 	lea    0x8236(%rip),%rsi        # e600 <fwp_segv.msg>
    63ca:	ba 1a 00 00 00       	mov    $0x1a,%edx
    63cf:	bf 02 00 00 00       	mov    $0x2,%edi
    63d4:	e8 57 bd ff ff       	call   2130 <write@plt>
    63d9:	bf 65 00 00 00       	mov    $0x65,%edi
    63de:	e8 bd bc ff ff       	call   20a0 <_exit@plt>
    63e3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    63ea:	84 00 00 00 00 00 

00000000000063f0 <fwp_near>:
    63f0:	48 39 f7             	cmp    %rsi,%rdi
    63f3:	0f 93 c0             	setae  %al
    63f6:	48 39 d7             	cmp    %rdx,%rdi
    63f9:	0f 92 c1             	setb   %cl
    63fc:	20 c1                	and    %al,%cl
    63fe:	0f b6 c1             	movzbl %cl,%eax
    6401:	c3                   	ret
    6402:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6409:	1f 84 00 00 00 00 00 

0000000000006410 <fwp_generated>:
    6410:	55                   	push   %rbp
    6411:	41 57                	push   %r15
    6413:	41 56                	push   %r14
    6415:	53                   	push   %rbx
    6416:	50                   	push   %rax
    6417:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    641c:	85 ff                	test   %edi,%edi
    641e:	0f 8e 14 01 00 00    	jle    6538 <fwp_generated+0x128>
    6424:	89 fd                	mov    %edi,%ebp
    6426:	49 89 f7             	mov    %rsi,%r15
    6429:	4c 8b 36             	mov    (%rsi),%r14
    642c:	48 8d 35 87 8d 00 00 	lea    0x8d87(%rip),%rsi        # f1ba <exec_in_fp0+0xb5a>
    6433:	4c 89 f7             	mov    %r14,%rdi
    6436:	e8 85 be ff ff       	call   22c0 <strcmp@plt>
    643b:	85 c0                	test   %eax,%eax
    643d:	74 34                	je     6473 <fwp_generated+0x63>
    643f:	48 8d 35 7a 8d 00 00 	lea    0x8d7a(%rip),%rsi        # f1c0 <exec_in_fp0+0xb60>
    6446:	ba 0d 00 00 00       	mov    $0xd,%edx
    644b:	4c 89 f7             	mov    %r14,%rdi
    644e:	e8 3d bc ff ff       	call   2090 <strncmp@plt>
    6453:	85 c0                	test   %eax,%eax
    6455:	0f 85 dd 00 00 00    	jne    6538 <fwp_generated+0x128>
    645b:	41 0f b6 46 0d       	movzbl 0xd(%r14),%eax
    6460:	85 c0                	test   %eax,%eax
    6462:	74 2c                	je     6490 <fwp_generated+0x80>
    6464:	83 f8 3d             	cmp    $0x3d,%eax
    6467:	0f 85 cb 00 00 00    	jne    6538 <fwp_generated+0x128>
    646d:	49 83 c6 0e          	add    $0xe,%r14
    6471:	eb 2a                	jmp    649d <fwp_generated+0x8d>
    6473:	48 8b 3d 7e f9 00 00 	mov    0xf97e(%rip),%rdi        # 15df8 <fwp_cli_man>
    647a:	48 8b 05 37 db 00 00 	mov    0xdb37(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    6481:	48 8b 30             	mov    (%rax),%rsi
    6484:	e8 57 bd ff ff       	call   21e0 <fputs@plt>
    6489:	31 db                	xor    %ebx,%ebx
    648b:	e9 a8 00 00 00       	jmp    6538 <fwp_generated+0x128>
    6490:	83 fd 01             	cmp    $0x1,%ebp
    6493:	0f 84 ac 00 00 00    	je     6545 <fwp_generated+0x135>
    6499:	4d 8b 77 08          	mov    0x8(%r15),%r14
    649d:	48 8d 35 68 8d 00 00 	lea    0x8d68(%rip),%rsi        # f20c <exec_in_fp0+0xbac>
    64a4:	4c 89 f7             	mov    %r14,%rdi
    64a7:	e8 14 be ff ff       	call   22c0 <strcmp@plt>
    64ac:	31 db                	xor    %ebx,%ebx
    64ae:	85 c0                	test   %eax,%eax
    64b0:	74 63                	je     6515 <fwp_generated+0x105>
    64b2:	48 8d 35 58 8d 00 00 	lea    0x8d58(%rip),%rsi        # f211 <exec_in_fp0+0xbb1>
    64b9:	4c 89 f7             	mov    %r14,%rdi
    64bc:	e8 ff bd ff ff       	call   22c0 <strcmp@plt>
    64c1:	85 c0                	test   %eax,%eax
    64c3:	74 54                	je     6519 <fwp_generated+0x109>
    64c5:	48 8d 35 49 8d 00 00 	lea    0x8d49(%rip),%rsi        # f215 <exec_in_fp0+0xbb5>
    64cc:	4c 89 f7             	mov    %r14,%rdi
    64cf:	e8 ec bd ff ff       	call   22c0 <strcmp@plt>
    64d4:	b9 02 00 00 00       	mov    $0x2,%ecx
    64d9:	85 c0                	test   %eax,%eax
    64db:	74 41                	je     651e <fwp_generated+0x10e>
    64dd:	4c 89 f7             	mov    %r14,%rdi
    64e0:	e8 7b bc ff ff       	call   2160 <strlen@plt>
    64e5:	4c 89 f7             	mov    %r14,%rdi
    64e8:	48 89 c6             	mov    %rax,%rsi
    64eb:	e8 80 00 00 00       	call   6570 <fwp_str_lossy>
    64f0:	48 8b 0d e9 da 00 00 	mov    0xdae9(%rip),%rcx        # 13fe0 <stderr@GLIBC_2.2.5>
    64f7:	48 8b 39             	mov    (%rcx),%rdi
    64fa:	48 8d 48 08          	lea    0x8(%rax),%rcx
    64fe:	48 8d 35 15 8d 00 00 	lea    0x8d15(%rip),%rsi        # f21a <exec_in_fp0+0xbba>
    6505:	48 8d 15 9d 81 00 00 	lea    0x819d(%rip),%rdx        # e6a9 <exec_in_fp0+0x49>
    650c:	31 c0                	xor    %eax,%eax
    650e:	e8 cd bd ff ff       	call   22e0 <fprintf@plt>
    6513:	eb 4f                	jmp    6564 <fwp_generated+0x154>
    6515:	31 c9                	xor    %ecx,%ecx
    6517:	eb 05                	jmp    651e <fwp_generated+0x10e>
    6519:	b9 01 00 00 00       	mov    $0x1,%ecx
    651e:	48 8d 05 bb f8 00 00 	lea    0xf8bb(%rip),%rax        # 15de0 <fwp_cli_scripts>
    6525:	48 8b 3c c8          	mov    (%rax,%rcx,8),%rdi
    6529:	48 8b 05 88 da 00 00 	mov    0xda88(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    6530:	48 8b 30             	mov    (%rax),%rsi
    6533:	e8 a8 bc ff ff       	call   21e0 <fputs@plt>
    6538:	89 d8                	mov    %ebx,%eax
    653a:	48 83 c4 08          	add    $0x8,%rsp
    653e:	5b                   	pop    %rbx
    653f:	41 5e                	pop    %r14
    6541:	41 5f                	pop    %r15
    6543:	5d                   	pop    %rbp
    6544:	c3                   	ret
    6545:	48 8b 05 94 da 00 00 	mov    0xda94(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    654c:	48 8b 38             	mov    (%rax),%rdi
    654f:	48 8d 35 78 8c 00 00 	lea    0x8c78(%rip),%rsi        # f1ce <exec_in_fp0+0xb6e>
    6556:	48 8d 15 4c 81 00 00 	lea    0x814c(%rip),%rdx        # e6a9 <exec_in_fp0+0x49>
    655d:	31 c0                	xor    %eax,%eax
    655f:	e8 7c bd ff ff       	call   22e0 <fprintf@plt>
    6564:	bb 02 00 00 00       	mov    $0x2,%ebx
    6569:	eb cd                	jmp    6538 <fwp_generated+0x128>
    656b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006570 <fwp_str_lossy>:
    6570:	55                   	push   %rbp
    6571:	41 57                	push   %r15
    6573:	41 56                	push   %r14
    6575:	41 55                	push   %r13
    6577:	41 54                	push   %r12
    6579:	53                   	push   %rbx
    657a:	48 83 ec 18          	sub    $0x18,%rsp
    657e:	48 89 f3             	mov    %rsi,%rbx
    6581:	49 89 fe             	mov    %rdi,%r14
    6584:	e8 27 12 00 00       	call   77b0 <fwp_valid_utf8>
    6589:	85 c0                	test   %eax,%eax
    658b:	74 19                	je     65a6 <fwp_str_lossy+0x36>
    658d:	4c 89 f7             	mov    %r14,%rdi
    6590:	48 89 de             	mov    %rbx,%rsi
    6593:	48 83 c4 18          	add    $0x18,%rsp
    6597:	5b                   	pop    %rbx
    6598:	41 5c                	pop    %r12
    659a:	41 5d                	pop    %r13
    659c:	41 5e                	pop    %r14
    659e:	41 5f                	pop    %r15
    65a0:	5d                   	pop    %rbp
    65a1:	e9 6a 13 00 00       	jmp    7910 <fwp_str_new>
    65a6:	0f 57 c0             	xorps  %xmm0,%xmm0
    65a9:	0f 29 04 24          	movaps %xmm0,(%rsp)
    65ad:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    65b4:	00 00 
    65b6:	48 85 db             	test   %rbx,%rbx
    65b9:	0f 84 72 01 00 00    	je     6731 <fwp_str_lossy+0x1c1>
    65bf:	45 31 ed             	xor    %r13d,%r13d
    65c2:	49 89 e7             	mov    %rsp,%r15
    65c5:	4c 8d 25 7a 8c 00 00 	lea    0x8c7a(%rip),%r12        # f246 <exec_in_fp0+0xbe6>
    65cc:	eb 19                	jmp    65e7 <fwp_str_lossy+0x77>
    65ce:	66 90                	xchg   %ax,%ax
    65d0:	4c 89 ff             	mov    %r15,%rdi
    65d3:	4c 89 e6             	mov    %r12,%rsi
    65d6:	e8 95 13 00 00       	call   7970 <buf_puts>
    65db:	49 89 ed             	mov    %rbp,%r13
    65de:	48 39 dd             	cmp    %rbx,%rbp
    65e1:	0f 83 4a 01 00 00    	jae    6731 <fwp_str_lossy+0x1c1>
    65e7:	43 0f b6 04 2e       	movzbl (%r14,%r13,1),%eax
    65ec:	84 c0                	test   %al,%al
    65ee:	78 20                	js     6610 <fwp_str_lossy+0xa0>
    65f0:	0f be f0             	movsbl %al,%esi
    65f3:	4c 89 ff             	mov    %r15,%rdi
    65f6:	e8 55 13 00 00       	call   7950 <buf_putc>
    65fb:	49 ff c5             	inc    %r13
    65fe:	4c 89 ed             	mov    %r13,%rbp
    6601:	eb d8                	jmp    65db <fwp_str_lossy+0x6b>
    6603:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    660a:	84 00 00 00 00 00 
    6610:	8d 48 20             	lea    0x20(%rax),%ecx
    6613:	80 f9 e1             	cmp    $0xe1,%cl
    6616:	77 34                	ja     664c <fwp_str_lossy+0xdc>
    6618:	89 c2                	mov    %eax,%edx
    661a:	80 e2 f0             	and    $0xf0,%dl
    661d:	80 fa e0             	cmp    $0xe0,%dl
    6620:	0f 85 cb 00 00 00    	jne    66f1 <fwp_str_lossy+0x181>
    6626:	3c e0                	cmp    $0xe0,%al
    6628:	40 0f 94 c6          	sete   %sil
    662c:	40 c0 e6 05          	shl    $0x5,%sil
    6630:	40 80 ce 80          	or     $0x80,%sil
    6634:	31 ff                	xor    %edi,%edi
    6636:	3c ed                	cmp    $0xed,%al
    6638:	40 0f 95 c7          	setne  %dil
    663c:	c1 e7 05             	shl    $0x5,%edi
    663f:	81 cf 9f 00 00 00    	or     $0x9f,%edi
    6645:	b8 02 00 00 00       	mov    $0x2,%eax
    664a:	eb 0d                	jmp    6659 <fwp_str_lossy+0xe9>
    664c:	bf bf 00 00 00       	mov    $0xbf,%edi
    6651:	40 b6 80             	mov    $0x80,%sil
    6654:	b8 01 00 00 00       	mov    $0x1,%eax
    6659:	31 d2                	xor    %edx,%edx
    665b:	49 8d 6d 01          	lea    0x1(%r13),%rbp
    665f:	48 39 dd             	cmp    %rbx,%rbp
    6662:	0f 83 68 ff ff ff    	jae    65d0 <fwp_str_lossy+0x60>
    6668:	45 0f b6 04 2e       	movzbl (%r14,%rbp,1),%r8d
    666d:	41 38 f0             	cmp    %sil,%r8b
    6670:	0f 82 5a ff ff ff    	jb     65d0 <fwp_str_lossy+0x60>
    6676:	44 39 c7             	cmp    %r8d,%edi
    6679:	0f 82 51 ff ff ff    	jb     65d0 <fwp_str_lossy+0x60>
    667f:	49 8d 6d 02          	lea    0x2(%r13),%rbp
    6683:	be 01 00 00 00       	mov    $0x1,%esi
    6688:	80 f9 e1             	cmp    $0xe1,%cl
    668b:	77 45                	ja     66d2 <fwp_str_lossy+0x162>
    668d:	48 39 dd             	cmp    %rbx,%rbp
    6690:	73 40                	jae    66d2 <fwp_str_lossy+0x162>
    6692:	41 0f b6 0c 2e       	movzbl (%r14,%rbp,1),%ecx
    6697:	80 e1 c0             	and    $0xc0,%cl
    669a:	80 f9 80             	cmp    $0x80,%cl
    669d:	75 33                	jne    66d2 <fwp_str_lossy+0x162>
    669f:	49 8d 6d 03          	lea    0x3(%r13),%rbp
    66a3:	48 39 dd             	cmp    %rbx,%rbp
    66a6:	0f 93 c1             	setae  %cl
    66a9:	80 f2 01             	xor    $0x1,%dl
    66ac:	be 02 00 00 00       	mov    $0x2,%esi
    66b1:	08 ca                	or     %cl,%dl
    66b3:	75 1d                	jne    66d2 <fwp_str_lossy+0x162>
    66b5:	43 0f b6 4c 2e 03    	movzbl 0x3(%r14,%r13,1),%ecx
    66bb:	80 e1 c0             	and    $0xc0,%cl
    66be:	31 f6                	xor    %esi,%esi
    66c0:	80 f9 80             	cmp    $0x80,%cl
    66c3:	0f 94 c1             	sete   %cl
    66c6:	75 04                	jne    66cc <fwp_str_lossy+0x15c>
    66c8:	49 8d 6d 04          	lea    0x4(%r13),%rbp
    66cc:	40 88 ce             	mov    %cl,%sil
    66cf:	83 ce 02             	or     $0x2,%esi
    66d2:	39 c6                	cmp    %eax,%esi
    66d4:	0f 85 f6 fe ff ff    	jne    65d0 <fwp_str_lossy+0x60>
    66da:	4b 8d 34 2e          	lea    (%r14,%r13,1),%rsi
    66de:	48 89 ea             	mov    %rbp,%rdx
    66e1:	4c 29 ea             	sub    %r13,%rdx
    66e4:	4c 89 ff             	mov    %r15,%rdi
    66e7:	e8 b4 12 00 00       	call   79a0 <buf_put>
    66ec:	e9 ea fe ff ff       	jmp    65db <fwp_str_lossy+0x6b>
    66f1:	8d 50 10             	lea    0x10(%rax),%edx
    66f4:	80 fa 04             	cmp    $0x4,%dl
    66f7:	77 28                	ja     6721 <fwp_str_lossy+0x1b1>
    66f9:	3c f0                	cmp    $0xf0,%al
    66fb:	40 0f 94 c6          	sete   %sil
    66ff:	bf 8f 00 00 00       	mov    $0x8f,%edi
    6704:	3c f4                	cmp    $0xf4,%al
    6706:	74 05                	je     670d <fwp_str_lossy+0x19d>
    6708:	bf bf 00 00 00       	mov    $0xbf,%edi
    670d:	40 c0 e6 04          	shl    $0x4,%sil
    6711:	40 80 ce 80          	or     $0x80,%sil
    6715:	b8 03 00 00 00       	mov    $0x3,%eax
    671a:	b2 01                	mov    $0x1,%dl
    671c:	e9 3a ff ff ff       	jmp    665b <fwp_str_lossy+0xeb>
    6721:	4c 89 ff             	mov    %r15,%rdi
    6724:	4c 89 e6             	mov    %r12,%rsi
    6727:	e8 44 12 00 00       	call   7970 <buf_puts>
    672c:	e9 ca fe ff ff       	jmp    65fb <fwp_str_lossy+0x8b>
    6731:	48 89 e7             	mov    %rsp,%rdi
    6734:	e8 a7 12 00 00       	call   79e0 <buf_to_str>
    6739:	48 83 c4 18          	add    $0x18,%rsp
    673d:	5b                   	pop    %rbx
    673e:	41 5c                	pop    %r12
    6740:	41 5d                	pop    %r13
    6742:	41 5e                	pop    %r14
    6744:	41 5f                	pop    %r15
    6746:	5d                   	pop    %rbp
    6747:	c3                   	ret
    6748:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    674f:	00 

0000000000006750 <fwp_alloc_leaf>:
    6750:	be 01 00 00 00       	mov    $0x1,%esi
    6755:	e9 d6 ca ff ff       	jmp    3230 <fwp_gc_alloc>
    675a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000006760 <fwp_cli_parse>:
    6760:	c7 01 00 00 00 00    	movl   $0x0,(%rcx)
    6766:	85 ff                	test   %edi,%edi
    6768:	0f 8e 6d 01 00 00    	jle    68db <fwp_cli_parse+0x17b>
    676e:	55                   	push   %rbp
    676f:	41 57                	push   %r15
    6771:	41 56                	push   %r14
    6773:	41 55                	push   %r13
    6775:	41 54                	push   %r12
    6777:	53                   	push   %rbx
    6778:	48 83 ec 28          	sub    $0x28,%rsp
    677c:	41 89 f8             	mov    %edi,%r8d
    677f:	4d 89 c1             	mov    %r8,%r9
    6782:	49 f7 d9             	neg    %r9
    6785:	40 b5 01             	mov    $0x1,%bpl
    6788:	45 31 ff             	xor    %r15d,%r15d
    678b:	41 be 01 00 00 00    	mov    $0x1,%r14d
    6791:	31 db                	xor    %ebx,%ebx
    6793:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
    6798:	48 89 74 24 18       	mov    %rsi,0x18(%rsp)
    679d:	4c 89 44 24 10       	mov    %r8,0x10(%rsp)
    67a2:	4c 89 4c 24 08       	mov    %r9,0x8(%rsp)
    67a7:	48 89 0c 24          	mov    %rcx,(%rsp)
    67ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    67b0:	4e 8b 6c f6 f8       	mov    -0x8(%rsi,%r14,8),%r13
    67b5:	85 db                	test   %ebx,%ebx
    67b7:	75 37                	jne    67f0 <fwp_cli_parse+0x90>
    67b9:	4d 8b 65 00          	mov    0x0(%r13),%r12
    67bd:	49 83 fc 02          	cmp    $0x2,%r12
    67c1:	72 2d                	jb     67f0 <fwp_cli_parse+0x90>
    67c3:	49 8d 7d 08          	lea    0x8(%r13),%rdi
    67c7:	80 3f 2d             	cmpb   $0x2d,(%rdi)
    67ca:	75 24                	jne    67f0 <fwp_cli_parse+0x90>
    67cc:	e8 ff 12 00 00       	call   7ad0 <fwp_is_number_arg>
    67d1:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    67d6:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    67db:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    67e0:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    67e5:	48 8b 0c 24          	mov    (%rsp),%rcx
    67e9:	85 c0                	test   %eax,%eax
    67eb:	74 2f                	je     681c <fwp_cli_parse+0xbc>
    67ed:	0f 1f 00             	nopl   (%rax)
    67f0:	49 63 c7             	movslq %r15d,%rax
    67f3:	41 8d 7f 01          	lea    0x1(%r15),%edi
    67f7:	89 39                	mov    %edi,(%rcx)
    67f9:	4c 89 2c c2          	mov    %r13,(%rdx,%rax,8)
    67fd:	41 89 ff             	mov    %edi,%r15d
    6800:	4d 39 c6             	cmp    %r8,%r14
    6803:	40 0f 92 c5          	setb   %bpl
    6807:	4b 8d 04 31          	lea    (%r9,%r14,1),%rax
    680b:	48 ff c0             	inc    %rax
    680e:	49 ff c6             	inc    %r14
    6811:	48 83 f8 01          	cmp    $0x1,%rax
    6815:	75 99                	jne    67b0 <fwp_cli_parse+0x50>
    6817:	e9 a9 00 00 00       	jmp    68c5 <fwp_cli_parse+0x165>
    681c:	41 0f b6 45 09       	movzbl 0x9(%r13),%eax
    6821:	49 83 fc 02          	cmp    $0x2,%r12
    6825:	75 1a                	jne    6841 <fwp_cli_parse+0xe1>
    6827:	bb 01 00 00 00       	mov    $0x1,%ebx
    682c:	3c 2d                	cmp    $0x2d,%al
    682e:	74 d0                	je     6800 <fwp_cli_parse+0xa0>
    6830:	31 db                	xor    %ebx,%ebx
    6832:	49 83 fc 02          	cmp    $0x2,%r12
    6836:	75 b8                	jne    67f0 <fwp_cli_parse+0x90>
    6838:	3c 68                	cmp    $0x68,%al
    683a:	75 b4                	jne    67f0 <fwp_cli_parse+0x90>
    683c:	e9 84 00 00 00       	jmp    68c5 <fwp_cli_parse+0x165>
    6841:	31 db                	xor    %ebx,%ebx
    6843:	3c 2d                	cmp    $0x2d,%al
    6845:	75 a9                	jne    67f0 <fwp_cli_parse+0x90>
    6847:	49 8d 5d 0a          	lea    0xa(%r13),%rbx
    684b:	49 83 c4 fe          	add    $0xfffffffffffffffe,%r12
    684f:	48 89 df             	mov    %rbx,%rdi
    6852:	be 3d 00 00 00       	mov    $0x3d,%esi
    6857:	4c 89 e2             	mov    %r12,%rdx
    685a:	e8 f1 b9 ff ff       	call   2250 <memchr@plt>
    685f:	48 89 c1             	mov    %rax,%rcx
    6862:	48 29 d9             	sub    %rbx,%rcx
    6865:	48 85 c0             	test   %rax,%rax
    6868:	49 0f 44 cc          	cmove  %r12,%rcx
    686c:	75 38                	jne    68a6 <fwp_cli_parse+0x146>
    686e:	48 83 f9 04          	cmp    $0x4,%rcx
    6872:	48 8b 0c 24          	mov    (%rsp),%rcx
    6876:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    687b:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    6880:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    6885:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    688a:	75 13                	jne    689f <fwp_cli_parse+0x13f>
    688c:	81 3b 68 65 6c 70    	cmpl   $0x706c6568,(%rbx)
    6892:	bb 00 00 00 00       	mov    $0x0,%ebx
    6897:	0f 85 53 ff ff ff    	jne    67f0 <fwp_cli_parse+0x90>
    689d:	eb 26                	jmp    68c5 <fwp_cli_parse+0x165>
    689f:	31 db                	xor    %ebx,%ebx
    68a1:	e9 4a ff ff ff       	jmp    67f0 <fwp_cli_parse+0x90>
    68a6:	48 8b 0c 24          	mov    (%rsp),%rcx
    68aa:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    68af:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    68b4:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    68b9:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    68be:	31 db                	xor    %ebx,%ebx
    68c0:	e9 2b ff ff ff       	jmp    67f0 <fwp_cli_parse+0x90>
    68c5:	40 0f b6 c5          	movzbl %bpl,%eax
    68c9:	83 e0 01             	and    $0x1,%eax
    68cc:	48 83 c4 28          	add    $0x28,%rsp
    68d0:	5b                   	pop    %rbx
    68d1:	41 5c                	pop    %r12
    68d3:	41 5d                	pop    %r13
    68d5:	41 5e                	pop    %r14
    68d7:	41 5f                	pop    %r15
    68d9:	5d                   	pop    %rbp
    68da:	c3                   	ret
    68db:	31 c0                	xor    %eax,%eax
    68dd:	c3                   	ret
    68de:	66 90                	xchg   %ax,%ax

00000000000068e0 <fwp_usage_error>:
    68e0:	48 8b 05 f9 d6 00 00 	mov    0xd6f9(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    68e7:	48 8b 38             	mov    (%rax),%rdi
    68ea:	48 8d 35 f2 89 00 00 	lea    0x89f2(%rip),%rsi        # f2e3 <exec_in_fp0+0xc83>
    68f1:	48 8d 15 fe 8a 00 00 	lea    0x8afe(%rip),%rdx        # f3f6 <exec_in_fp0+0xd96>
    68f8:	31 c0                	xor    %eax,%eax
    68fa:	e9 e1 b9 ff ff       	jmp    22e0 <fprintf@plt>
    68ff:	90                   	nop

0000000000006900 <fwp_parse_text>:
    6900:	48 83 ec 18          	sub    $0x18,%rsp
    6904:	48 89 d1             	mov    %rdx,%rcx
    6907:	48 89 3c 24          	mov    %rdi,(%rsp)
    690b:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    6910:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    6917:	00 00 
    6919:	48 8d 35 08 f4 00 00 	lea    0xf408(%rip),%rsi        # 15d28 <d0>
    6920:	48 89 e7             	mov    %rsp,%rdi
    6923:	ba 01 00 00 00       	mov    $0x1,%edx
    6928:	e8 a3 16 00 00       	call   7fd0 <tp_value>
    692d:	85 c0                	test   %eax,%eax
    692f:	74 1c                	je     694d <fwp_parse_text+0x4d>
    6931:	48 89 e7             	mov    %rsp,%rdi
    6934:	e8 c7 1f 00 00       	call   8900 <tp_ws>
    6939:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    693e:	31 c0                	xor    %eax,%eax
    6940:	48 3b 4c 24 08       	cmp    0x8(%rsp),%rcx
    6945:	0f 94 c0             	sete   %al
    6948:	48 83 c4 18          	add    $0x18,%rsp
    694c:	c3                   	ret
    694d:	31 c0                	xor    %eax,%eax
    694f:	48 83 c4 18          	add    $0x18,%rsp
    6953:	c3                   	ret
    6954:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    695b:	00 00 00 00 00 

0000000000006960 <fwp_parse_arg>:
    6960:	53                   	push   %rbx
    6961:	48 83 ec 10          	sub    $0x10,%rsp
    6965:	89 fb                	mov    %edi,%ebx
    6967:	48 8b 06             	mov    (%rsi),%rax
    696a:	48 8d 7e 08          	lea    0x8(%rsi),%rdi
    696e:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    6973:	48 89 c6             	mov    %rax,%rsi
    6976:	e8 85 12 00 00       	call   7c00 <fwp_cli_value>
    697b:	89 c1                	mov    %eax,%ecx
    697d:	b8 01 00 00 00       	mov    $0x1,%eax
    6982:	85 c9                	test   %ecx,%ecx
    6984:	74 06                	je     698c <fwp_parse_arg+0x2c>
    6986:	48 83 c4 10          	add    $0x10,%rsp
    698a:	5b                   	pop    %rbx
    698b:	c3                   	ret
    698c:	48 8b 05 4d d6 00 00 	mov    0xd64d(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    6993:	48 8b 38             	mov    (%rax),%rdi
    6996:	ff c3                	inc    %ebx
    6998:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
    699d:	49 83 c0 08          	add    $0x8,%r8
    69a1:	48 8d 35 2a 89 00 00 	lea    0x892a(%rip),%rsi        # f2d2 <exec_in_fp0+0xc72>
    69a8:	48 8d 15 fa 7c 00 00 	lea    0x7cfa(%rip),%rdx        # e6a9 <exec_in_fp0+0x49>
    69af:	89 d9                	mov    %ebx,%ecx
    69b1:	31 c0                	xor    %eax,%eax
    69b3:	e8 28 b9 ff ff       	call   22e0 <fprintf@plt>
    69b8:	31 c0                	xor    %eax,%eax
    69ba:	eb ca                	jmp    6986 <fwp_parse_arg+0x26>
    69bc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000069c0 <fwp_bind_positional>:
    69c0:	50                   	push   %rax
    69c1:	31 c0                	xor    %eax,%eax
    69c3:	85 f6                	test   %esi,%esi
    69c5:	0f 9e c0             	setle  %al
    69c8:	89 01                	mov    %eax,(%rcx)
    69ca:	83 fe 01             	cmp    $0x1,%esi
    69cd:	76 0c                	jbe    69db <fwp_bind_positional+0x1b>
    69cf:	e8 0c ff ff ff       	call   68e0 <fwp_usage_error>
    69d4:	b8 02 00 00 00       	mov    $0x2,%eax
    69d9:	59                   	pop    %rcx
    69da:	c3                   	ret
    69db:	31 c0                	xor    %eax,%eax
    69dd:	83 fe 01             	cmp    $0x1,%esi
    69e0:	75 f7                	jne    69d9 <fwp_bind_positional+0x19>
    69e2:	48 8b 37             	mov    (%rdi),%rsi
    69e5:	31 ff                	xor    %edi,%edi
    69e7:	e8 74 ff ff ff       	call   6960 <fwp_parse_arg>
    69ec:	89 c1                	mov    %eax,%ecx
    69ee:	31 c0                	xor    %eax,%eax
    69f0:	85 c9                	test   %ecx,%ecx
    69f2:	0f 94 c0             	sete   %al
    69f5:	01 c0                	add    %eax,%eax
    69f7:	59                   	pop    %rcx
    69f8:	c3                   	ret
    69f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000006a00 <fwp_pipe_out_start>:
    6a00:	41 56                	push   %r14
    6a02:	53                   	push   %rbx
    6a03:	48 81 ec 08 01 00 00 	sub    $0x108,%rsp
    6a0a:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    6a0f:	bf 01 00 00 00       	mov    $0x1,%edi
    6a14:	e8 b7 ba ff ff       	call   24d0 <fstat@plt>
    6a19:	85 c0                	test   %eax,%eax
    6a1b:	0f 85 82 00 00 00    	jne    6aa3 <fwp_pipe_out_start+0xa3>
    6a21:	b8 00 f0 00 00       	mov    $0xf000,%eax
    6a26:	23 44 24 20          	and    0x20(%rsp),%eax
    6a2a:	3d 00 10 00 00       	cmp    $0x1000,%eax
    6a2f:	75 72                	jne    6aa3 <fwp_pipe_out_start+0xa3>
    6a31:	bf 01 00 00 00       	mov    $0x1,%edi
    6a36:	be 07 04 00 00       	mov    $0x407,%esi
    6a3b:	ba 00 00 10 00       	mov    $0x100000,%edx
    6a40:	31 c0                	xor    %eax,%eax
    6a42:	e8 c9 b6 ff ff       	call   2110 <fcntl@plt>
    6a47:	e8 24 36 00 00       	call   a070 <fwp_transport_off>
    6a4c:	85 c0                	test   %eax,%eax
    6a4e:	75 53                	jne    6aa3 <fwp_pipe_out_start+0xa3>
    6a50:	bf 01 00 00 00       	mov    $0x1,%edi
    6a55:	be 01 08 08 00       	mov    $0x80801,%esi
    6a5a:	31 d2                	xor    %edx,%edx
    6a5c:	e8 9f ba ff ff       	call   2500 <socket@plt>
    6a61:	85 c0                	test   %eax,%eax
    6a63:	78 3e                	js     6aa3 <fwp_pipe_out_start+0xa3>
    6a65:	89 c3                	mov    %eax,%ebx
    6a67:	4c 8d b4 24 9a 00 00 	lea    0x9a(%rsp),%r14
    6a6e:	00 
    6a6f:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    6a74:	4c 89 f7             	mov    %r14,%rdi
    6a77:	e8 24 36 00 00       	call   a0a0 <fwp_pipe_addr>
    6a7c:	89 df                	mov    %ebx,%edi
    6a7e:	4c 89 f6             	mov    %r14,%rsi
    6a81:	89 c2                	mov    %eax,%edx
    6a83:	e8 38 b9 ff ff       	call   23c0 <bind@plt>
    6a88:	85 c0                	test   %eax,%eax
    6a8a:	75 10                	jne    6a9c <fwp_pipe_out_start+0x9c>
    6a8c:	89 df                	mov    %ebx,%edi
    6a8e:	be 01 00 00 00       	mov    $0x1,%esi
    6a93:	e8 b8 b8 ff ff       	call   2350 <listen@plt>
    6a98:	85 c0                	test   %eax,%eax
    6a9a:	74 12                	je     6aae <fwp_pipe_out_start+0xae>
    6a9c:	89 df                	mov    %ebx,%edi
    6a9e:	e8 7d b7 ff ff       	call   2220 <close@plt>
    6aa3:	48 81 c4 08 01 00 00 	add    $0x108,%rsp
    6aaa:	5b                   	pop    %rbx
    6aab:	41 5e                	pop    %r14
    6aad:	c3                   	ret
    6aae:	89 1d 00 f2 00 00    	mov    %ebx,0xf200(%rip)        # 15cb4 <fwp_po_listen>
    6ab4:	e8 37 36 00 00       	call   a0f0 <fwp_now_ns>
    6ab9:	48 b9 00 f2 05 2a 01 	movabs $0x12a05f200,%rcx
    6ac0:	00 00 00 
    6ac3:	48 01 c1             	add    %rax,%rcx
    6ac6:	48 89 0d 6b f3 01 00 	mov    %rcx,0x1f36b(%rip)        # 25e38 <fwp_po_give_up>
    6acd:	eb d4                	jmp    6aa3 <fwp_pipe_out_start+0xa3>
    6acf:	90                   	nop

0000000000006ad0 <fwp_pipe_write>:
    6ad0:	41 57                	push   %r15
    6ad2:	41 56                	push   %r14
    6ad4:	53                   	push   %rbx
    6ad5:	48 89 f3             	mov    %rsi,%rbx
    6ad8:	8b 05 62 f3 01 00    	mov    0x1f362(%rip),%eax        # 25e40 <fwp_po_kind>
    6ade:	83 f8 01             	cmp    $0x1,%eax
    6ae1:	74 12                	je     6af5 <fwp_pipe_write+0x25>
    6ae3:	83 f8 02             	cmp    $0x2,%eax
    6ae6:	75 46                	jne    6b2e <fwp_pipe_write+0x5e>
    6ae8:	48 89 de             	mov    %rbx,%rsi
    6aeb:	5b                   	pop    %rbx
    6aec:	41 5e                	pop    %r14
    6aee:	41 5f                	pop    %r15
    6af0:	e9 2b 36 00 00       	jmp    a120 <fwp_ring_put>
    6af5:	49 89 fe             	mov    %rdi,%r14
    6af8:	48 8b 05 49 f3 01 00 	mov    0x1f349(%rip),%rax        # 25e48 <fwp_po_len>
    6aff:	48 01 d8             	add    %rbx,%rax
    6b02:	48 3d 01 00 01 00    	cmp    $0x10001,%rax
    6b08:	72 05                	jb     6b0f <fwp_pipe_write+0x3f>
    6b0a:	e8 71 37 00 00       	call   a280 <fwp_po_flush_sock>
    6b0f:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    6b16:	72 32                	jb     6b4a <fwp_pipe_write+0x7a>
    6b18:	8b 3d 9a f1 00 00    	mov    0xf19a(%rip),%edi        # 15cb8 <fwp_po_sock>
    6b1e:	4c 89 f6             	mov    %r14,%rsi
    6b21:	48 89 da             	mov    %rbx,%rdx
    6b24:	5b                   	pop    %rbx
    6b25:	41 5e                	pop    %r14
    6b27:	41 5f                	pop    %r15
    6b29:	e9 82 37 00 00       	jmp    a2b0 <fwp_po_write_raw>
    6b2e:	48 8b 05 83 d4 00 00 	mov    0xd483(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    6b35:	48 8b 08             	mov    (%rax),%rcx
    6b38:	be 01 00 00 00       	mov    $0x1,%esi
    6b3d:	48 89 da             	mov    %rbx,%rdx
    6b40:	5b                   	pop    %rbx
    6b41:	41 5e                	pop    %r14
    6b43:	41 5f                	pop    %r15
    6b45:	e9 46 b9 ff ff       	jmp    2490 <fwrite@plt>
    6b4a:	4c 8b 3d f7 f2 01 00 	mov    0x1f2f7(%rip),%r15        # 25e48 <fwp_po_len>
    6b51:	48 8d 3d f8 f2 01 00 	lea    0x1f2f8(%rip),%rdi        # 25e50 <fwp_po_buf>
    6b58:	4c 01 ff             	add    %r15,%rdi
    6b5b:	4c 89 f6             	mov    %r14,%rsi
    6b5e:	48 89 da             	mov    %rbx,%rdx
    6b61:	e8 ba b7 ff ff       	call   2320 <memcpy@plt>
    6b66:	49 01 df             	add    %rbx,%r15
    6b69:	4c 89 3d d8 f2 01 00 	mov    %r15,0x1f2d8(%rip)        # 25e48 <fwp_po_len>
    6b70:	5b                   	pop    %rbx
    6b71:	41 5e                	pop    %r14
    6b73:	41 5f                	pop    %r15
    6b75:	c3                   	ret
    6b76:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    6b7d:	00 00 00 

0000000000006b80 <fwp_pipe_flush>:
    6b80:	8b 05 ba f2 01 00    	mov    0x1f2ba(%rip),%eax        # 25e40 <fwp_po_kind>
    6b86:	85 c0                	test   %eax,%eax
    6b88:	74 0a                	je     6b94 <fwp_pipe_flush+0x14>
    6b8a:	83 f8 01             	cmp    $0x1,%eax
    6b8d:	75 1b                	jne    6baa <fwp_pipe_flush+0x2a>
    6b8f:	e9 ec 36 00 00       	jmp    a280 <fwp_po_flush_sock>
    6b94:	50                   	push   %rax
    6b95:	48 8b 05 1c d4 00 00 	mov    0xd41c(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    6b9c:	48 8b 38             	mov    (%rax),%rdi
    6b9f:	e8 9c b7 ff ff       	call   2340 <fflush@plt>
    6ba4:	58                   	pop    %rax
    6ba5:	e9 e6 39 00 00       	jmp    a590 <fwp_pipe_poll>
    6baa:	c3                   	ret
    6bab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006bb0 <fwp_pipe_out_ready>:
    6bb0:	48 83 ec 18          	sub    $0x18,%rsp
    6bb4:	48 8d 3d 66 87 00 00 	lea    0x8766(%rip),%rdi        # f321 <exec_in_fp0+0xcc1>
    6bbb:	e8 70 b4 ff ff       	call   2030 <getenv@plt>
    6bc0:	48 85 c0             	test   %rax,%rax
    6bc3:	74 79                	je     6c3e <fwp_pipe_out_ready+0x8e>
    6bc5:	83 3d e8 f0 00 00 00 	cmpl   $0x0,0xf0e8(%rip)        # 15cb4 <fwp_po_listen>
    6bcc:	78 70                	js     6c3e <fwp_pipe_out_ready+0x8e>
    6bce:	80 38 00             	cmpb   $0x0,(%rax)
    6bd1:	74 6b                	je     6c3e <fwp_pipe_out_ready+0x8e>
    6bd3:	48 89 c7             	mov    %rax,%rdi
    6bd6:	31 f6                	xor    %esi,%esi
    6bd8:	ba 0a 00 00 00       	mov    $0xa,%edx
    6bdd:	e8 2e b7 ff ff       	call   2310 <strtol@plt>
    6be2:	8b 0d cc f0 00 00    	mov    0xf0cc(%rip),%ecx        # 15cb4 <fwp_po_listen>
    6be8:	89 0c 24             	mov    %ecx,(%rsp)
    6beb:	48 b9 01 00 00 00 01 	movabs $0x100000001,%rcx
    6bf2:	00 00 00 
    6bf5:	48 89 4c 24 04       	mov    %rcx,0x4(%rsp)
    6bfa:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%rsp)
    6c01:	00 
    6c02:	48 85 c0             	test   %rax,%rax
    6c05:	7e 37                	jle    6c3e <fwp_pipe_out_ready+0x8e>
    6c07:	48 3d ff ff ff 7f    	cmp    $0x7fffffff,%rax
    6c0d:	ba ff ff ff 7f       	mov    $0x7fffffff,%edx
    6c12:	48 0f 4c d0          	cmovl  %rax,%rdx
    6c16:	48 89 e7             	mov    %rsp,%rdi
    6c19:	be 02 00 00 00       	mov    $0x2,%esi
    6c1e:	e8 8d b7 ff ff       	call   23b0 <poll@plt>
    6c23:	85 c0                	test   %eax,%eax
    6c25:	7e 17                	jle    6c3e <fwp_pipe_out_ready+0x8e>
    6c27:	f6 44 24 06 01       	testb  $0x1,0x6(%rsp)
    6c2c:	74 10                	je     6c3e <fwp_pipe_out_ready+0x8e>
    6c2e:	48 c7 05 27 f2 02 00 	movq   $0x0,0x2f227(%rip)        # 35e60 <fwp_po_next_check>
    6c35:	00 00 00 00 
    6c39:	e8 52 39 00 00       	call   a590 <fwp_pipe_poll>
    6c3e:	48 83 c4 18          	add    $0x18,%rsp
    6c42:	c3                   	ret
    6c43:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6c4a:	84 00 00 00 00 00 

0000000000006c50 <fwp_exec_call>:
    6c50:	41 56                	push   %r14
    6c52:	53                   	push   %rbx
    6c53:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
    6c5a:	48 89 f3             	mov    %rsi,%rbx
    6c5d:	49 89 fe             	mov    %rdi,%r14
    6c60:	48 8b 05 01 f2 02 00 	mov    0x2f201(%rip),%rax        # 35e68 <fwp_handlers>
    6c67:	48 89 84 24 d0 00 00 	mov    %rax,0xd0(%rsp)
    6c6e:	00 
    6c6f:	48 c7 84 24 e8 00 00 	movq   $0x0,0xe8(%rsp)
    6c76:	00 00 00 00 00 
    6c7b:	48 8b 05 56 f1 00 00 	mov    0xf156(%rip),%rax        # 15dd8 <fwp_cleanups>
    6c82:	48 89 84 24 f0 00 00 	mov    %rax,0xf0(%rsp)
    6c89:	00 
    6c8a:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    6c8f:	48 89 3d d2 f1 02 00 	mov    %rdi,0x2f1d2(%rip)        # 35e68 <fwp_handlers>
    6c96:	e8 05 b6 ff ff       	call   22a0 <_setjmp@plt>
    6c9b:	85 c0                	test   %eax,%eax
    6c9d:	74 32                	je     6cd1 <fwp_exec_call+0x81>
    6c9f:	48 8b 84 24 d0 00 00 	mov    0xd0(%rsp),%rax
    6ca6:	00 
    6ca7:	48 89 05 ba f1 02 00 	mov    %rax,0x2f1ba(%rip)        # 35e68 <fwp_handlers>
    6cae:	e8 fd c2 ff ff       	call   2fb0 <fwp_flush>
    6cb3:	48 8b bc 24 d8 00 00 	mov    0xd8(%rsp),%rdi
    6cba:	00 
    6cbb:	48 8b b4 24 e0 00 00 	mov    0xe0(%rsp),%rsi
    6cc2:	00 
    6cc3:	e8 18 41 00 00       	call   ade0 <fwp_exec_error>
    6cc8:	b9 01 00 00 00       	mov    $0x1,%ecx
    6ccd:	31 c0                	xor    %eax,%eax
    6ccf:	eb 21                	jmp    6cf2 <fwp_exec_call+0xa2>
    6cd1:	e8 ea 40 00 00       	call   adc0 <fwp_pap>
    6cd6:	48 89 c7             	mov    %rax,%rdi
    6cd9:	4c 89 f6             	mov    %r14,%rsi
    6cdc:	e8 1f 3c 00 00       	call   a900 <fwp_apply>
    6ce1:	48 8b 8c 24 d0 00 00 	mov    0xd0(%rsp),%rcx
    6ce8:	00 
    6ce9:	48 89 0d 78 f1 02 00 	mov    %rcx,0x2f178(%rip)        # 35e68 <fwp_handlers>
    6cf0:	31 c9                	xor    %ecx,%ecx
    6cf2:	89 0b                	mov    %ecx,(%rbx)
    6cf4:	48 81 c4 f8 00 00 00 	add    $0xf8,%rsp
    6cfb:	5b                   	pop    %rbx
    6cfc:	41 5e                	pop    %r14
    6cfe:	c3                   	ret
    6cff:	90                   	nop

0000000000006d00 <fwp_emit_result>:
    6d00:	e9 4b 55 00 00       	jmp    c250 <fwp_emit>
    6d05:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    6d0c:	00 00 00 00 

0000000000006d10 <fwp_read_exact>:
    6d10:	41 57                	push   %r15
    6d12:	41 56                	push   %r14
    6d14:	53                   	push   %rbx
    6d15:	48 89 f3             	mov    %rsi,%rbx
    6d18:	49 89 fe             	mov    %rdi,%r14
    6d1b:	45 31 ff             	xor    %r15d,%r15d
    6d1e:	48 85 f6             	test   %rsi,%rsi
    6d21:	0f 84 b9 00 00 00    	je     6de0 <fwp_read_exact+0xd0>
    6d27:	8b 05 fb f0 01 00    	mov    0x1f0fb(%rip),%eax        # 25e28 <fwp_in_npend>
    6d2d:	8b 0d f9 f0 01 00    	mov    0x1f0f9(%rip),%ecx        # 25e2c <fwp_in_ppos>
    6d33:	39 c1                	cmp    %eax,%ecx
    6d35:	0f 8d a5 00 00 00    	jge    6de0 <fwp_read_exact+0xd0>
    6d3b:	48 98                	cltq
    6d3d:	48 63 f1             	movslq %ecx,%rsi
    6d40:	48 89 f2             	mov    %rsi,%rdx
    6d43:	48 f7 d2             	not    %rdx
    6d46:	48 01 c2             	add    %rax,%rdx
    6d49:	48 8d 4b ff          	lea    -0x1(%rbx),%rcx
    6d4d:	48 39 ca             	cmp    %rcx,%rdx
    6d50:	48 0f 43 d1          	cmovae %rcx,%rdx
    6d54:	48 ff c2             	inc    %rdx
    6d57:	48 83 fa 20          	cmp    $0x20,%rdx
    6d5b:	72 16                	jb     6d73 <fwp_read_exact+0x63>
    6d5d:	48 8d 3d c0 f0 01 00 	lea    0x1f0c0(%rip),%rdi        # 25e24 <fwp_in_pend>
    6d64:	4d 89 f0             	mov    %r14,%r8
    6d67:	49 29 f0             	sub    %rsi,%r8
    6d6a:	49 29 f8             	sub    %rdi,%r8
    6d6d:	49 83 f8 20          	cmp    $0x20,%r8
    6d71:	73 27                	jae    6d9a <fwp_read_exact+0x8a>
    6d73:	45 31 ff             	xor    %r15d,%r15d
    6d76:	48 89 f1             	mov    %rsi,%rcx
    6d79:	48 8d 15 a4 f0 01 00 	lea    0x1f0a4(%rip),%rdx        # 25e24 <fwp_in_pend>
    6d80:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6d84:	48 ff c1             	inc    %rcx
    6d87:	43 88 34 3e          	mov    %sil,(%r14,%r15,1)
    6d8b:	49 ff c7             	inc    %r15
    6d8e:	49 39 df             	cmp    %rbx,%r15
    6d91:	73 3f                	jae    6dd2 <fwp_read_exact+0xc2>
    6d93:	48 39 c1             	cmp    %rax,%rcx
    6d96:	7c e8                	jl     6d80 <fwp_read_exact+0x70>
    6d98:	eb 38                	jmp    6dd2 <fwp_read_exact+0xc2>
    6d9a:	49 89 d7             	mov    %rdx,%r15
    6d9d:	49 83 e7 e0          	and    $0xffffffffffffffe0,%r15
    6da1:	49 8d 0c 37          	lea    (%r15,%rsi,1),%rcx
    6da5:	48 01 fe             	add    %rdi,%rsi
    6da8:	48 83 c6 10          	add    $0x10,%rsi
    6dac:	31 ff                	xor    %edi,%edi
    6dae:	66 90                	xchg   %ax,%ax
    6db0:	0f 10 44 3e f0       	movups -0x10(%rsi,%rdi,1),%xmm0
    6db5:	0f 10 0c 3e          	movups (%rsi,%rdi,1),%xmm1
    6db9:	41 0f 11 04 3e       	movups %xmm0,(%r14,%rdi,1)
    6dbe:	41 0f 11 4c 3e 10    	movups %xmm1,0x10(%r14,%rdi,1)
    6dc4:	48 83 c7 20          	add    $0x20,%rdi
    6dc8:	49 39 ff             	cmp    %rdi,%r15
    6dcb:	75 e3                	jne    6db0 <fwp_read_exact+0xa0>
    6dcd:	4c 39 fa             	cmp    %r15,%rdx
    6dd0:	75 a7                	jne    6d79 <fwp_read_exact+0x69>
    6dd2:	89 0d 54 f0 01 00    	mov    %ecx,0x1f054(%rip)        # 25e2c <fwp_in_ppos>
    6dd8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6ddf:	00 
    6de0:	48 89 de             	mov    %rbx,%rsi
    6de3:	4c 29 fe             	sub    %r15,%rsi
    6de6:	76 15                	jbe    6dfd <fwp_read_exact+0xed>
    6de8:	4b 8d 3c 3e          	lea    (%r14,%r15,1),%rdi
    6dec:	e8 3f 58 00 00       	call   c630 <fwp_pipe_read>
    6df1:	49 01 c7             	add    %rax,%r15
    6df4:	48 85 c0             	test   %rax,%rax
    6df7:	75 e7                	jne    6de0 <fwp_read_exact+0xd0>
    6df9:	31 c0                	xor    %eax,%eax
    6dfb:	eb 05                	jmp    6e02 <fwp_read_exact+0xf2>
    6dfd:	b8 01 00 00 00       	mov    $0x1,%eax
    6e02:	5b                   	pop    %rbx
    6e03:	41 5e                	pop    %r14
    6e05:	41 5f                	pop    %r15
    6e07:	c3                   	ret
    6e08:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6e0f:	00 

0000000000006e10 <fwp_stdin_leb>:
    6e10:	41 57                	push   %r15
    6e12:	41 56                	push   %r14
    6e14:	53                   	push   %rbx
    6e15:	48 83 ec 10          	sub    $0x10,%rsp
    6e19:	48 89 fb             	mov    %rdi,%rbx
    6e1c:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    6e23:	49 c7 c6 f9 ff ff ff 	mov    $0xfffffffffffffff9,%r14
    6e2a:	4c 8d 7c 24 0f       	lea    0xf(%rsp),%r15
    6e2f:	90                   	nop
    6e30:	be 01 00 00 00       	mov    $0x1,%esi
    6e35:	4c 89 ff             	mov    %r15,%rdi
    6e38:	e8 d3 fe ff ff       	call   6d10 <fwp_read_exact>
    6e3d:	85 c0                	test   %eax,%eax
    6e3f:	74 35                	je     6e76 <fwp_stdin_leb+0x66>
    6e41:	0f b6 44 24 0f       	movzbl 0xf(%rsp),%eax
    6e46:	49 83 fe 38          	cmp    $0x38,%r14
    6e4a:	75 07                	jne    6e53 <fwp_stdin_leb+0x43>
    6e4c:	89 c1                	mov    %eax,%ecx
    6e4e:	80 e1 7e             	and    $0x7e,%cl
    6e51:	75 1c                	jne    6e6f <fwp_stdin_leb+0x5f>
    6e53:	49 83 c6 07          	add    $0x7,%r14
    6e57:	89 c2                	mov    %eax,%edx
    6e59:	83 e2 7f             	and    $0x7f,%edx
    6e5c:	44 89 f1             	mov    %r14d,%ecx
    6e5f:	48 d3 e2             	shl    %cl,%rdx
    6e62:	48 09 13             	or     %rdx,(%rbx)
    6e65:	84 c0                	test   %al,%al
    6e67:	79 11                	jns    6e7a <fwp_stdin_leb+0x6a>
    6e69:	49 83 fe 38          	cmp    $0x38,%r14
    6e6d:	76 c1                	jbe    6e30 <fwp_stdin_leb+0x20>
    6e6f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    6e74:	eb 09                	jmp    6e7f <fwp_stdin_leb+0x6f>
    6e76:	31 c0                	xor    %eax,%eax
    6e78:	eb 05                	jmp    6e7f <fwp_stdin_leb+0x6f>
    6e7a:	b8 01 00 00 00       	mov    $0x1,%eax
    6e7f:	48 83 c4 10          	add    $0x10,%rsp
    6e83:	5b                   	pop    %rbx
    6e84:	41 5e                	pop    %r14
    6e86:	41 5f                	pop    %r15
    6e88:	c3                   	ret
    6e89:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000006e90 <fwp_stdin_name_len>:
    6e90:	53                   	push   %rbx
    6e91:	48 89 fb             	mov    %rdi,%rbx
    6e94:	e8 77 ff ff ff       	call   6e10 <fwp_stdin_leb>
    6e99:	83 f8 01             	cmp    $0x1,%eax
    6e9c:	75 0e                	jne    6eac <fwp_stdin_name_len+0x1c>
    6e9e:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    6ea3:	48 81 3b 00 00 10 00 	cmpq   $0x100000,(%rbx)
    6eaa:	77 02                	ja     6eae <fwp_stdin_name_len+0x1e>
    6eac:	89 c1                	mov    %eax,%ecx
    6eae:	89 c8                	mov    %ecx,%eax
    6eb0:	5b                   	pop    %rbx
    6eb1:	c3                   	ret
    6eb2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6eb9:	1f 84 00 00 00 00 00 

0000000000006ec0 <fwp_pipe_in_offer>:
    6ec0:	55                   	push   %rbp
    6ec1:	41 57                	push   %r15
    6ec3:	41 56                	push   %r14
    6ec5:	53                   	push   %rbx
    6ec6:	48 81 ec 08 01 00 00 	sub    $0x108,%rsp
    6ecd:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    6ed2:	31 ff                	xor    %edi,%edi
    6ed4:	e8 f7 b5 ff ff       	call   24d0 <fstat@plt>
    6ed9:	85 c0                	test   %eax,%eax
    6edb:	0f 85 a5 00 00 00    	jne    6f86 <fwp_pipe_in_offer+0xc6>
    6ee1:	b8 00 f0 00 00       	mov    $0xf000,%eax
    6ee6:	23 44 24 20          	and    0x20(%rsp),%eax
    6eea:	3d 00 10 00 00       	cmp    $0x1000,%eax
    6eef:	0f 85 91 00 00 00    	jne    6f86 <fwp_pipe_in_offer+0xc6>
    6ef5:	bf 01 00 00 00       	mov    $0x1,%edi
    6efa:	be 01 00 08 00       	mov    $0x80001,%esi
    6eff:	31 d2                	xor    %edx,%edx
    6f01:	e8 fa b5 ff ff       	call   2500 <socket@plt>
    6f06:	85 c0                	test   %eax,%eax
    6f08:	78 7c                	js     6f86 <fwp_pipe_in_offer+0xc6>
    6f0a:	89 c3                	mov    %eax,%ebx
    6f0c:	48 8d bc 24 9a 00 00 	lea    0x9a(%rsp),%rdi
    6f13:	00 
    6f14:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    6f19:	e8 82 31 00 00       	call   a0a0 <fwp_pipe_addr>
    6f1e:	41 89 c6             	mov    %eax,%r14d
    6f21:	48 8d 3d bf 83 00 00 	lea    0x83bf(%rip),%rdi        # f2e7 <exec_in_fp0+0xc87>
    6f28:	e8 03 b1 ff ff       	call   2030 <getenv@plt>
    6f2d:	49 89 c7             	mov    %rax,%r15
    6f30:	e8 3b 31 00 00       	call   a070 <fwp_transport_off>
    6f35:	89 c5                	mov    %eax,%ebp
    6f37:	c7 04 24 46 57 50 54 	movl   $0x54505746,(%rsp)
    6f3e:	85 c0                	test   %eax,%eax
    6f40:	74 04                	je     6f46 <fwp_pipe_in_offer+0x86>
    6f42:	31 c0                	xor    %eax,%eax
    6f44:	eb 1f                	jmp    6f65 <fwp_pipe_in_offer+0xa5>
    6f46:	4d 85 ff             	test   %r15,%r15
    6f49:	74 18                	je     6f63 <fwp_pipe_in_offer+0xa3>
    6f4b:	48 8d 35 68 84 00 00 	lea    0x8468(%rip),%rsi        # f3ba <exec_in_fp0+0xd5a>
    6f52:	4c 89 ff             	mov    %r15,%rdi
    6f55:	e8 66 b3 ff ff       	call   22c0 <strcmp@plt>
    6f5a:	83 f8 01             	cmp    $0x1,%eax
    6f5d:	b0 02                	mov    $0x2,%al
    6f5f:	1c 00                	sbb    $0x0,%al
    6f61:	eb 02                	jmp    6f65 <fwp_pipe_in_offer+0xa5>
    6f63:	b0 02                	mov    $0x2,%al
    6f65:	88 44 24 04          	mov    %al,0x4(%rsp)
    6f69:	48 8d b4 24 9a 00 00 	lea    0x9a(%rsp),%rsi
    6f70:	00 
    6f71:	89 df                	mov    %ebx,%edi
    6f73:	44 89 f2             	mov    %r14d,%edx
    6f76:	e8 05 b5 ff ff       	call   2480 <connect@plt>
    6f7b:	85 c0                	test   %eax,%eax
    6f7d:	74 15                	je     6f94 <fwp_pipe_in_offer+0xd4>
    6f7f:	89 df                	mov    %ebx,%edi
    6f81:	e8 9a b2 ff ff       	call   2220 <close@plt>
    6f86:	48 81 c4 08 01 00 00 	add    $0x108,%rsp
    6f8d:	5b                   	pop    %rbx
    6f8e:	41 5e                	pop    %r14
    6f90:	41 5f                	pop    %r15
    6f92:	5d                   	pop    %rbp
    6f93:	c3                   	ret
    6f94:	48 89 e6             	mov    %rsp,%rsi
    6f97:	ba 05 00 00 00       	mov    $0x5,%edx
    6f9c:	89 df                	mov    %ebx,%edi
    6f9e:	b9 00 40 00 00       	mov    $0x4000,%ecx
    6fa3:	e8 e8 b1 ff ff       	call   2190 <send@plt>
    6fa8:	85 ed                	test   %ebp,%ebp
    6faa:	75 d3                	jne    6f7f <fwp_pipe_in_offer+0xbf>
    6fac:	48 83 f8 05          	cmp    $0x5,%rax
    6fb0:	75 cd                	jne    6f7f <fwp_pipe_in_offer+0xbf>
    6fb2:	89 1d 08 ed 00 00    	mov    %ebx,0xed08(%rip)        # 15cc0 <fwp_pi_sock>
    6fb8:	eb cc                	jmp    6f86 <fwp_pipe_in_offer+0xc6>
    6fba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000006fc0 <fwp_pipe_in_switch>:
    6fc0:	55                   	push   %rbp
    6fc1:	41 57                	push   %r15
    6fc3:	41 56                	push   %r14
    6fc5:	53                   	push   %rbx
    6fc6:	48 81 ec 08 01 00 00 	sub    $0x108,%rsp
    6fcd:	31 db                	xor    %ebx,%ebx
    6fcf:	48 83 fe 01          	cmp    $0x1,%rsi
    6fd3:	0f 85 f6 01 00 00    	jne    71cf <fwp_pipe_in_switch+0x20f>
    6fd9:	48 89 f8             	mov    %rdi,%rax
    6fdc:	8b 3d de ec 00 00    	mov    0xecde(%rip),%edi        # 15cc0 <fwp_pi_sock>
    6fe2:	85 ff                	test   %edi,%edi
    6fe4:	0f 88 e5 01 00 00    	js     71cf <fwp_pipe_in_switch+0x20f>
    6fea:	83 3d 83 ee 02 00 00 	cmpl   $0x0,0x2ee83(%rip)        # 35e74 <fwp_pi_kind>
    6ff1:	0f 85 d8 01 00 00    	jne    71cf <fwp_pipe_in_switch+0x20f>
    6ff7:	0f b6 00             	movzbl (%rax),%eax
    6ffa:	83 f8 02             	cmp    $0x2,%eax
    6ffd:	74 29                	je     7028 <fwp_pipe_in_switch+0x68>
    6fff:	83 f8 01             	cmp    $0x1,%eax
    7002:	0f 85 c7 01 00 00    	jne    71cf <fwp_pipe_in_switch+0x20f>
    7008:	c7 05 62 ee 02 00 01 	movl   $0x1,0x2ee62(%rip)        # 35e74 <fwp_pi_kind>
    700f:	00 00 00 
    7012:	48 8d 3d b8 80 00 00 	lea    0x80b8(%rip),%rdi        # f0d1 <exec_in_fp0+0xa71>
    7019:	e8 32 58 00 00       	call   c850 <fwp_pipe_report>
    701e:	bb 01 00 00 00       	mov    $0x1,%ebx
    7023:	e9 a7 01 00 00       	jmp    71cf <fwp_pipe_in_switch+0x20f>
    7028:	48 8d 44 24 0f       	lea    0xf(%rsp),%rax
    702d:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    7032:	48 c7 44 24 58 01 00 	movq   $0x1,0x58(%rsp)
    7039:	00 00 
    703b:	0f 57 c0             	xorps  %xmm0,%xmm0
    703e:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    7043:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    7048:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    704d:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    7054:	00 00 
    7056:	48 8d 44 24 50       	lea    0x50(%rsp),%rax
    705b:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    7060:	48 c7 44 24 28 01 00 	movq   $0x1,0x28(%rsp)
    7067:	00 00 
    7069:	48 8d 44 24 60       	lea    0x60(%rsp),%rax
    706e:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    7073:	48 c7 44 24 38 18 00 	movq   $0x18,0x38(%rsp)
    707a:	00 00 
    707c:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    7081:	ba 00 00 00 40       	mov    $0x40000000,%edx
    7086:	e8 05 b3 ff ff       	call   2390 <recvmsg@plt>
    708b:	31 db                	xor    %ebx,%ebx
    708d:	48 83 f8 01          	cmp    $0x1,%rax
    7091:	0f 85 38 01 00 00    	jne    71cf <fwp_pipe_in_switch+0x20f>
    7097:	48 83 7c 24 38 10    	cmpq   $0x10,0x38(%rsp)
    709d:	0f 82 2c 01 00 00    	jb     71cf <fwp_pipe_in_switch+0x20f>
    70a3:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    70a8:	48 85 c0             	test   %rax,%rax
    70ab:	0f 84 1e 01 00 00    	je     71cf <fwp_pipe_in_switch+0x20f>
    70b1:	83 78 0c 01          	cmpl   $0x1,0xc(%rax)
    70b5:	0f 85 14 01 00 00    	jne    71cf <fwp_pipe_in_switch+0x20f>
    70bb:	8b 68 10             	mov    0x10(%rax),%ebp
    70be:	48 8d 74 24 78       	lea    0x78(%rsp),%rsi
    70c3:	89 ef                	mov    %ebp,%edi
    70c5:	e8 06 b4 ff ff       	call   24d0 <fstat@plt>
    70ca:	85 c0                	test   %eax,%eax
    70cc:	0f 85 f4 00 00 00    	jne    71c6 <fwp_pipe_in_switch+0x206>
    70d2:	4c 8b b4 24 a8 00 00 	mov    0xa8(%rsp),%r14
    70d9:	00 
    70da:	49 81 fe 00 10 00 00 	cmp    $0x1000,%r14
    70e1:	0f 86 df 00 00 00    	jbe    71c6 <fwp_pipe_in_switch+0x206>
    70e7:	31 db                	xor    %ebx,%ebx
    70e9:	31 ff                	xor    %edi,%edi
    70eb:	4c 89 f6             	mov    %r14,%rsi
    70ee:	ba 03 00 00 00       	mov    $0x3,%edx
    70f3:	b9 01 00 00 00       	mov    $0x1,%ecx
    70f8:	41 89 e8             	mov    %ebp,%r8d
    70fb:	45 31 c9             	xor    %r9d,%r9d
    70fe:	e8 7d b0 ff ff       	call   2180 <mmap@plt>
    7103:	49 89 c7             	mov    %rax,%r15
    7106:	89 ef                	mov    %ebp,%edi
    7108:	e8 13 b1 ff ff       	call   2220 <close@plt>
    710d:	49 83 ff ff          	cmp    $0xffffffffffffffff,%r15
    7111:	0f 84 b8 00 00 00    	je     71cf <fwp_pipe_in_switch+0x20f>
    7117:	41 81 3f 46 57 50 53 	cmpl   $0x53505746,(%r15)
    711e:	0f 85 ab 00 00 00    	jne    71cf <fwp_pipe_in_switch+0x20f>
    7124:	41 83 7f 04 01       	cmpl   $0x1,0x4(%r15)
    7129:	0f 85 a0 00 00 00    	jne    71cf <fwp_pipe_in_switch+0x20f>
    712f:	49 8b 47 08          	mov    0x8(%r15),%rax
    7133:	48 85 c0             	test   %rax,%rax
    7136:	0f 84 93 00 00 00    	je     71cf <fwp_pipe_in_switch+0x20f>
    713c:	48 89 c1             	mov    %rax,%rcx
    713f:	48 d1 e9             	shr    $1,%rcx
    7142:	48 ba 55 55 55 55 55 	movabs $0x5555555555555555,%rdx
    7149:	55 55 55 
    714c:	48 21 ca             	and    %rcx,%rdx
    714f:	48 89 c1             	mov    %rax,%rcx
    7152:	48 29 d1             	sub    %rdx,%rcx
    7155:	48 ba 33 33 33 33 33 	movabs $0x3333333333333333,%rdx
    715c:	33 33 33 
    715f:	48 89 ce             	mov    %rcx,%rsi
    7162:	48 21 d6             	and    %rdx,%rsi
    7165:	48 c1 e9 02          	shr    $0x2,%rcx
    7169:	48 21 d1             	and    %rdx,%rcx
    716c:	48 01 f1             	add    %rsi,%rcx
    716f:	48 89 ca             	mov    %rcx,%rdx
    7172:	48 c1 ea 04          	shr    $0x4,%rdx
    7176:	48 01 ca             	add    %rcx,%rdx
    7179:	48 b9 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%rcx
    7180:	0f 0f 0f 
    7183:	48 21 d1             	and    %rdx,%rcx
    7186:	48 ba 01 01 01 01 01 	movabs $0x101010101010101,%rdx
    718d:	01 01 01 
    7190:	48 0f af d1          	imul   %rcx,%rdx
    7194:	48 c1 ea 38          	shr    $0x38,%rdx
    7198:	83 fa 01             	cmp    $0x1,%edx
    719b:	77 32                	ja     71cf <fwp_pipe_in_switch+0x20f>
    719d:	49 81 c6 00 f0 ff ff 	add    $0xfffffffffffff000,%r14
    71a4:	4c 39 f0             	cmp    %r14,%rax
    71a7:	77 26                	ja     71cf <fwp_pipe_in_switch+0x20f>
    71a9:	4c 89 3d c8 ec 02 00 	mov    %r15,0x2ecc8(%rip)        # 35e78 <fwp_pi_ring>
    71b0:	c7 05 ba ec 02 00 02 	movl   $0x2,0x2ecba(%rip)        # 35e74 <fwp_pi_kind>
    71b7:	00 00 00 
    71ba:	48 8d 3d fd 81 00 00 	lea    0x81fd(%rip),%rdi        # f3be <exec_in_fp0+0xd5e>
    71c1:	e9 53 fe ff ff       	jmp    7019 <fwp_pipe_in_switch+0x59>
    71c6:	89 ef                	mov    %ebp,%edi
    71c8:	e8 53 b0 ff ff       	call   2220 <close@plt>
    71cd:	31 db                	xor    %ebx,%ebx
    71cf:	89 d8                	mov    %ebx,%eax
    71d1:	48 81 c4 08 01 00 00 	add    $0x108,%rsp
    71d8:	5b                   	pop    %rbx
    71d9:	41 5e                	pop    %r14
    71db:	41 5f                	pop    %r15
    71dd:	5d                   	pop    %rbp
    71de:	c3                   	ret
    71df:	90                   	nop

00000000000071e0 <fwp_decode>:
    71e0:	55                   	push   %rbp
    71e1:	41 57                	push   %r15
    71e3:	41 56                	push   %r14
    71e5:	41 55                	push   %r13
    71e7:	41 54                	push   %r12
    71e9:	53                   	push   %rbx
    71ea:	48 83 ec 38          	sub    $0x38,%rsp
    71ee:	8b 06                	mov    (%rsi),%eax
    71f0:	45 31 f6             	xor    %r14d,%r14d
    71f3:	48 83 f8 15          	cmp    $0x15,%rax
    71f7:	77 47                	ja     7240 <fwp_decode+0x60>
    71f9:	48 89 d3             	mov    %rdx,%rbx
    71fc:	49 89 f4             	mov    %rsi,%r12
    71ff:	49 89 ff             	mov    %rdi,%r15
    7202:	48 8d 0d 87 6f 00 00 	lea    0x6f87(%rip),%rcx        # e190 <_IO_stdin_used+0x190>
    7209:	48 63 14 81          	movslq (%rcx,%rax,4),%rdx
    720d:	48 01 ca             	add    %rcx,%rdx
    7210:	ff e2                	jmp    *%rdx
    7212:	31 c9                	xor    %ecx,%ecx
    7214:	83 f8 0a             	cmp    $0xa,%eax
    7217:	0f 95 c1             	setne  %cl
    721a:	8d 34 8d 04 00 00 00 	lea    0x4(,%rcx,4),%esi
    7221:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7226:	4c 89 ff             	mov    %r15,%rdi
    7229:	e8 72 56 00 00       	call   c8a0 <rd_le>
    722e:	85 c0                	test   %eax,%eax
    7230:	74 0e                	je     7240 <fwp_decode+0x60>
    7232:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    7237:	48 89 03             	mov    %rax,(%rbx)
    723a:	41 be 01 00 00 00    	mov    $0x1,%r14d
    7240:	44 89 f0             	mov    %r14d,%eax
    7243:	48 83 c4 38          	add    $0x38,%rsp
    7247:	5b                   	pop    %rbx
    7248:	41 5c                	pop    %r12
    724a:	41 5d                	pop    %r13
    724c:	41 5e                	pop    %r14
    724e:	41 5f                	pop    %r15
    7250:	5d                   	pop    %rbp
    7251:	c3                   	ret
    7252:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    7257:	4c 89 ff             	mov    %r15,%rdi
    725a:	e8 01 57 00 00       	call   c960 <rd_leb>
    725f:	45 31 f6             	xor    %r14d,%r14d
    7262:	85 c0                	test   %eax,%eax
    7264:	74 da                	je     7240 <fwp_decode+0x60>
    7266:	4c 8b 6c 24 08       	mov    0x8(%rsp),%r13
    726b:	4d 3b 6f 08          	cmp    0x8(%r15),%r13
    726f:	77 cf                	ja     7240 <fwp_decode+0x60>
    7271:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    7276:	4c 89 ff             	mov    %r15,%rdi
    7279:	4c 89 ee             	mov    %r13,%rsi
    727c:	e8 5f 57 00 00       	call   c9e0 <rd_take>
    7281:	85 c0                	test   %eax,%eax
    7283:	74 bb                	je     7240 <fwp_decode+0x60>
    7285:	41 83 3c 24 0c       	cmpl   $0xc,(%r12)
    728a:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    728f:	75 0f                	jne    72a0 <fwp_decode+0xc0>
    7291:	4c 89 ff             	mov    %r15,%rdi
    7294:	4c 89 ee             	mov    %r13,%rsi
    7297:	e8 14 05 00 00       	call   77b0 <fwp_valid_utf8>
    729c:	85 c0                	test   %eax,%eax
    729e:	74 a0                	je     7240 <fwp_decode+0x60>
    72a0:	4c 89 ff             	mov    %r15,%rdi
    72a3:	4c 89 ee             	mov    %r13,%rsi
    72a6:	e8 65 06 00 00       	call   7910 <fwp_str_new>
    72ab:	eb 8a                	jmp    7237 <fwp_decode+0x57>
    72ad:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    72b2:	4c 89 ff             	mov    %r15,%rdi
    72b5:	be 01 00 00 00       	mov    $0x1,%esi
    72ba:	e8 e1 55 00 00       	call   c8a0 <rd_le>
    72bf:	85 c0                	test   %eax,%eax
    72c1:	0f 84 79 ff ff ff    	je     7240 <fwp_decode+0x60>
    72c7:	48 0f be 44 24 08    	movsbq 0x8(%rsp),%rax
    72cd:	e9 65 ff ff ff       	jmp    7237 <fwp_decode+0x57>
    72d2:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    72d7:	4c 89 ff             	mov    %r15,%rdi
    72da:	be 08 00 00 00       	mov    $0x8,%esi
    72df:	e8 bc 55 00 00       	call   c8a0 <rd_le>
    72e4:	45 31 f6             	xor    %r14d,%r14d
    72e7:	85 c0                	test   %eax,%eax
    72e9:	0f 84 51 ff ff ff    	je     7240 <fwp_decode+0x60>
    72ef:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    72f4:	4c 89 ff             	mov    %r15,%rdi
    72f7:	be 08 00 00 00       	mov    $0x8,%esi
    72fc:	e8 9f 55 00 00       	call   c8a0 <rd_le>
    7301:	85 c0                	test   %eax,%eax
    7303:	0f 84 37 ff ff ff    	je     7240 <fwp_decode+0x60>
    7309:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    730e:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    7313:	41 83 3c 24 04       	cmpl   $0x4,(%r12)
    7318:	0f 85 d1 02 00 00    	jne    75ef <fwp_decode+0x40f>
    731e:	e8 9d 24 00 00       	call   97c0 <fwp_box_i128>
    7323:	e9 0f ff ff ff       	jmp    7237 <fwp_decode+0x57>
    7328:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    732d:	4c 89 ff             	mov    %r15,%rdi
    7330:	e8 2b 56 00 00       	call   c960 <rd_leb>
    7335:	85 c0                	test   %eax,%eax
    7337:	0f 84 03 ff ff ff    	je     7240 <fwp_decode+0x60>
    733d:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    7342:	49 3b 6f 08          	cmp    0x8(%r15),%rbp
    7346:	0f 87 f4 fe ff ff    	ja     7240 <fwp_decode+0x60>
    734c:	4c 8d 35 dd ea 01 00 	lea    0x1eadd(%rip),%r14        # 25e30 <fwp_empty_map>
    7353:	48 85 ed             	test   %rbp,%rbp
    7356:	0f 84 9d 02 00 00    	je     75f9 <fwp_decode+0x419>
    735c:	4c 8d 6c 24 18       	lea    0x18(%rsp),%r13
    7361:	eb 20                	jmp    7383 <fwp_decode+0x1a3>
    7363:	31 f6                	xor    %esi,%esi
    7365:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    736a:	49 8b 4c 24 38       	mov    0x38(%r12),%rcx
    736f:	4c 89 f2             	mov    %r14,%rdx
    7372:	e8 89 1c 00 00       	call   9000 <fwp_p_map_insert>
    7377:	49 89 c6             	mov    %rax,%r14
    737a:	48 ff cd             	dec    %rbp
    737d:	0f 84 76 02 00 00    	je     75f9 <fwp_decode+0x419>
    7383:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
    738a:	00 00 
    738c:	49 8b 74 24 38       	mov    0x38(%r12),%rsi
    7391:	4c 89 ff             	mov    %r15,%rdi
    7394:	4c 89 ea             	mov    %r13,%rdx
    7397:	e8 44 fe ff ff       	call   71e0 <fwp_decode>
    739c:	85 c0                	test   %eax,%eax
    739e:	0f 84 69 02 00 00    	je     760d <fwp_decode+0x42d>
    73a4:	41 83 3c 24 12       	cmpl   $0x12,(%r12)
    73a9:	75 b8                	jne    7363 <fwp_decode+0x183>
    73ab:	49 8b 74 24 40       	mov    0x40(%r12),%rsi
    73b0:	4c 89 ff             	mov    %r15,%rdi
    73b3:	48 8d 54 24 30       	lea    0x30(%rsp),%rdx
    73b8:	e8 23 fe ff ff       	call   71e0 <fwp_decode>
    73bd:	85 c0                	test   %eax,%eax
    73bf:	0f 84 48 02 00 00    	je     760d <fwp_decode+0x42d>
    73c5:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    73ca:	eb 99                	jmp    7365 <fwp_decode+0x185>
    73cc:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    73d1:	4c 89 ff             	mov    %r15,%rdi
    73d4:	e8 87 55 00 00       	call   c960 <rd_leb>
    73d9:	85 c0                	test   %eax,%eax
    73db:	0f 84 5f fe ff ff    	je     7240 <fwp_decode+0x60>
    73e1:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
    73e6:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    73eb:	49 3b 5f 08          	cmp    0x8(%r15),%rbx
    73ef:	0f 87 4b fe ff ff    	ja     7240 <fwp_decode+0x60>
    73f5:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    73fc:	00 
    73fd:	e8 1e e3 ff ff       	call   5720 <fwp_alloc>
    7402:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    7407:	48 85 db             	test   %rbx,%rbx
    740a:	74 35                	je     7441 <fwp_decode+0x261>
    740c:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
    7411:	49 89 dd             	mov    %rbx,%r13
    7414:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    741b:	00 00 00 00 00 
    7420:	49 8b 74 24 38       	mov    0x38(%r12),%rsi
    7425:	4c 89 ff             	mov    %r15,%rdi
    7428:	48 89 ea             	mov    %rbp,%rdx
    742b:	e8 b0 fd ff ff       	call   71e0 <fwp_decode>
    7430:	85 c0                	test   %eax,%eax
    7432:	0f 84 08 fe ff ff    	je     7240 <fwp_decode+0x60>
    7438:	48 83 c5 08          	add    $0x8,%rbp
    743c:	49 ff cd             	dec    %r13
    743f:	75 df                	jne    7420 <fwp_decode+0x240>
    7441:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    7446:	48 89 de             	mov    %rbx,%rsi
    7449:	e8 a2 02 00 00       	call   76f0 <fwp_list_from>
    744e:	41 83 3c 24 11       	cmpl   $0x11,(%r12)
    7453:	0f 85 b4 00 00 00    	jne    750d <fwp_decode+0x32d>
    7459:	48 89 c7             	mov    %rax,%rdi
    745c:	e8 4f 1a 00 00       	call   8eb0 <fwp_p_array_from_list>
    7461:	e9 a7 00 00 00       	jmp    750d <fwp_decode+0x32d>
    7466:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    746b:	4c 89 ff             	mov    %r15,%rdi
    746e:	e8 ed 54 00 00       	call   c960 <rd_leb>
    7473:	85 c0                	test   %eax,%eax
    7475:	0f 84 c5 fd ff ff    	je     7240 <fwp_decode+0x60>
    747b:	4c 8b 6c 24 08       	mov    0x8(%rsp),%r13
    7480:	49 63 44 24 10       	movslq 0x10(%r12),%rax
    7485:	49 39 c5             	cmp    %rax,%r13
    7488:	0f 83 b2 fd ff ff    	jae    7240 <fwp_decode+0x60>
    748e:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
    7493:	49 8b 44 24 28       	mov    0x28(%r12),%rax
    7498:	4a 63 1c a8          	movslq (%rax,%r13,4),%rbx
    749c:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    74a3:	00 
    74a4:	e8 77 e2 ff ff       	call   5720 <fwp_alloc>
    74a9:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    74ae:	89 d8                	mov    %ebx,%eax
    74b0:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    74b5:	48 85 db             	test   %rbx,%rbx
    74b8:	7e 41                	jle    74fb <fwp_decode+0x31b>
    74ba:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    74bf:	48 8d 2c c5 00 00 00 	lea    0x0(,%rax,8),%rbp
    74c6:	00 
    74c7:	45 31 f6             	xor    %r14d,%r14d
    74ca:	31 db                	xor    %ebx,%ebx
    74cc:	49 8b 44 24 30       	mov    0x30(%r12),%rax
    74d1:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    74d5:	48 8b 34 18          	mov    (%rax,%rbx,1),%rsi
    74d9:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    74de:	48 8d 14 18          	lea    (%rax,%rbx,1),%rdx
    74e2:	4c 89 ff             	mov    %r15,%rdi
    74e5:	e8 f6 fc ff ff       	call   71e0 <fwp_decode>
    74ea:	85 c0                	test   %eax,%eax
    74ec:	0f 84 4e fd ff ff    	je     7240 <fwp_decode+0x60>
    74f2:	48 83 c3 08          	add    $0x8,%rbx
    74f6:	48 39 dd             	cmp    %rbx,%rbp
    74f9:	75 d1                	jne    74cc <fwp_decode+0x2ec>
    74fb:	44 89 ef             	mov    %r13d,%edi
    74fe:	48 8b 74 24 28       	mov    0x28(%rsp),%rsi
    7503:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
    7508:	e8 63 bb ff ff       	call   3070 <fwp_data>
    750d:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    7512:	48 89 01             	mov    %rax,(%rcx)
    7515:	e9 20 fd ff ff       	jmp    723a <fwp_decode+0x5a>
    751a:	be 01 00 00 00       	mov    $0x1,%esi
    751f:	e9 fd fc ff ff       	jmp    7221 <fwp_decode+0x41>
    7524:	be 02 00 00 00       	mov    $0x2,%esi
    7529:	e9 f3 fc ff ff       	jmp    7221 <fwp_decode+0x41>
    752e:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7533:	4c 89 ff             	mov    %r15,%rdi
    7536:	be 02 00 00 00       	mov    $0x2,%esi
    753b:	e8 60 53 00 00       	call   c8a0 <rd_le>
    7540:	85 c0                	test   %eax,%eax
    7542:	0f 84 f8 fc ff ff    	je     7240 <fwp_decode+0x60>
    7548:	48 0f bf 44 24 08    	movswq 0x8(%rsp),%rax
    754e:	e9 e4 fc ff ff       	jmp    7237 <fwp_decode+0x57>
    7553:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7558:	4c 89 ff             	mov    %r15,%rdi
    755b:	be 04 00 00 00       	mov    $0x4,%esi
    7560:	e8 3b 53 00 00       	call   c8a0 <rd_le>
    7565:	85 c0                	test   %eax,%eax
    7567:	0f 84 d3 fc ff ff    	je     7240 <fwp_decode+0x60>
    756d:	48 63 44 24 08       	movslq 0x8(%rsp),%rax
    7572:	e9 c0 fc ff ff       	jmp    7237 <fwp_decode+0x57>
    7577:	be 04 00 00 00       	mov    $0x4,%esi
    757c:	e9 a0 fc ff ff       	jmp    7221 <fwp_decode+0x41>
    7581:	49 63 7c 24 10       	movslq 0x10(%r12),%rdi
    7586:	48 85 ff             	test   %rdi,%rdi
    7589:	74 76                	je     7601 <fwp_decode+0x421>
    758b:	48 c1 e7 03          	shl    $0x3,%rdi
    758f:	e8 8c e1 ff ff       	call   5720 <fwp_alloc>
    7594:	41 8b 7c 24 10       	mov    0x10(%r12),%edi
    7599:	85 ff                	test   %edi,%edi
    759b:	7e 45                	jle    75e2 <fwp_decode+0x402>
    759d:	45 31 f6             	xor    %r14d,%r14d
    75a0:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    75a5:	48 89 c5             	mov    %rax,%rbp
    75a8:	45 31 ed             	xor    %r13d,%r13d
    75ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    75b0:	49 8b 44 24 20       	mov    0x20(%r12),%rax
    75b5:	4a 8b 34 e8          	mov    (%rax,%r13,8),%rsi
    75b9:	4c 89 ff             	mov    %r15,%rdi
    75bc:	48 89 ea             	mov    %rbp,%rdx
    75bf:	e8 1c fc ff ff       	call   71e0 <fwp_decode>
    75c4:	85 c0                	test   %eax,%eax
    75c6:	0f 84 74 fc ff ff    	je     7240 <fwp_decode+0x60>
    75cc:	49 ff c5             	inc    %r13
    75cf:	49 63 7c 24 10       	movslq 0x10(%r12),%rdi
    75d4:	48 83 c5 08          	add    $0x8,%rbp
    75d8:	49 39 fd             	cmp    %rdi,%r13
    75db:	7c d3                	jl     75b0 <fwp_decode+0x3d0>
    75dd:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    75e2:	48 89 c6             	mov    %rax,%rsi
    75e5:	e8 76 ba ff ff       	call   3060 <fwp_record>
    75ea:	e9 48 fc ff ff       	jmp    7237 <fwp_decode+0x57>
    75ef:	e8 7c 20 00 00       	call   9670 <fwp_box_u128>
    75f4:	e9 3e fc ff ff       	jmp    7237 <fwp_decode+0x57>
    75f9:	4c 89 33             	mov    %r14,(%rbx)
    75fc:	e9 39 fc ff ff       	jmp    723a <fwp_decode+0x5a>
    7601:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    7608:	e9 2d fc ff ff       	jmp    723a <fwp_decode+0x5a>
    760d:	45 31 f6             	xor    %r14d,%r14d
    7610:	e9 2b fc ff ff       	jmp    7240 <fwp_decode+0x60>
    7615:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    761c:	00 00 00 00 

0000000000007620 <fwp_read_text_line>:
    7620:	53                   	push   %rbx
    7621:	48 89 fb             	mov    %rdi,%rbx
    7624:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
    762b:	00 
    762c:	e8 df 53 00 00       	call   ca10 <fwp_getc>
    7631:	83 f8 ff             	cmp    $0xffffffff,%eax
    7634:	74 59                	je     768f <fwp_read_text_line+0x6f>
    7636:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    763d:	00 00 00 
    7640:	83 f8 0a             	cmp    $0xa,%eax
    7643:	74 1a                	je     765f <fwp_read_text_line+0x3f>
    7645:	0f be f0             	movsbl %al,%esi
    7648:	48 89 df             	mov    %rbx,%rdi
    764b:	e8 00 03 00 00       	call   7950 <buf_putc>
    7650:	e8 bb 53 00 00       	call   ca10 <fwp_getc>
    7655:	83 f8 ff             	cmp    $0xffffffff,%eax
    7658:	75 e6                	jne    7640 <fwp_read_text_line+0x20>
    765a:	48 8b 03             	mov    (%rbx),%rax
    765d:	eb 1c                	jmp    767b <fwp_read_text_line+0x5b>
    765f:	48 8b 03             	mov    (%rbx),%rax
    7662:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    7666:	48 85 c9             	test   %rcx,%rcx
    7669:	74 10                	je     767b <fwp_read_text_line+0x5b>
    766b:	80 7c 08 ff 0d       	cmpb   $0xd,-0x1(%rax,%rcx,1)
    7670:	75 12                	jne    7684 <fwp_read_text_line+0x64>
    7672:	48 ff c9             	dec    %rcx
    7675:	48 89 4b 08          	mov    %rcx,0x8(%rbx)
    7679:	eb 05                	jmp    7680 <fwp_read_text_line+0x60>
    767b:	48 85 c0             	test   %rax,%rax
    767e:	74 08                	je     7688 <fwp_read_text_line+0x68>
    7680:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    7684:	c6 04 08 00          	movb   $0x0,(%rax,%rcx,1)
    7688:	b8 01 00 00 00       	mov    $0x1,%eax
    768d:	5b                   	pop    %rbx
    768e:	c3                   	ret
    768f:	31 c0                	xor    %eax,%eax
    7691:	5b                   	pop    %rbx
    7692:	c3                   	ret
    7693:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    769a:	84 00 00 00 00 00 

00000000000076a0 <fwp_mem_realloc>:
    76a0:	41 57                	push   %r15
    76a2:	41 56                	push   %r14
    76a4:	53                   	push   %rbx
    76a5:	49 89 d6             	mov    %rdx,%r14
    76a8:	49 89 f7             	mov    %rsi,%r15
    76ab:	48 89 fb             	mov    %rdi,%rbx
    76ae:	48 89 d7             	mov    %rdx,%rdi
    76b1:	e8 6a e0 ff ff       	call   5720 <fwp_alloc>
    76b6:	48 85 db             	test   %rbx,%rbx
    76b9:	74 23                	je     76de <fwp_mem_realloc+0x3e>
    76bb:	4d 39 f7             	cmp    %r14,%r15
    76be:	4d 0f 42 f7          	cmovb  %r15,%r14
    76c2:	48 89 c7             	mov    %rax,%rdi
    76c5:	48 89 de             	mov    %rbx,%rsi
    76c8:	4c 89 f2             	mov    %r14,%rdx
    76cb:	49 89 c6             	mov    %rax,%r14
    76ce:	e8 4d ac ff ff       	call   2320 <memcpy@plt>
    76d3:	48 89 df             	mov    %rbx,%rdi
    76d6:	e8 35 e1 ff ff       	call   5810 <fwp_mem_free>
    76db:	4c 89 f0             	mov    %r14,%rax
    76de:	5b                   	pop    %rbx
    76df:	41 5e                	pop    %r14
    76e1:	41 5f                	pop    %r15
    76e3:	c3                   	ret
    76e4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    76eb:	00 00 00 00 00 

00000000000076f0 <fwp_list_from>:
    76f0:	41 56                	push   %r14
    76f2:	53                   	push   %rbx
    76f3:	50                   	push   %rax
    76f4:	48 89 fb             	mov    %rdi,%rbx
    76f7:	48 85 f6             	test   %rsi,%rsi
    76fa:	74 28                	je     7724 <fwp_list_from+0x34>
    76fc:	49 89 f6             	mov    %rsi,%r14
    76ff:	31 c0                	xor    %eax,%eax
    7701:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7708:	0f 1f 84 00 00 00 00 
    770f:	00 
    7710:	4a 8b 7c f3 f8       	mov    -0x8(%rbx,%r14,8),%rdi
    7715:	48 89 c6             	mov    %rax,%rsi
    7718:	e8 63 06 00 00       	call   7d80 <fwp_cons>
    771d:	49 ff ce             	dec    %r14
    7720:	75 ee                	jne    7710 <fwp_list_from+0x20>
    7722:	eb 02                	jmp    7726 <fwp_list_from+0x36>
    7724:	31 c0                	xor    %eax,%eax
    7726:	48 83 c4 08          	add    $0x8,%rsp
    772a:	5b                   	pop    %rbx
    772b:	41 5e                	pop    %r14
    772d:	c3                   	ret
    772e:	66 90                	xchg   %ax,%ax

0000000000007730 <fwp_pipe_out_end>:
    7730:	50                   	push   %rax
    7731:	8b 05 09 e7 01 00    	mov    0x1e709(%rip),%eax        # 25e40 <fwp_po_kind>
    7737:	83 f8 02             	cmp    $0x2,%eax
    773a:	74 1c                	je     7758 <fwp_pipe_out_end+0x28>
    773c:	83 f8 01             	cmp    $0x1,%eax
    773f:	75 3d                	jne    777e <fwp_pipe_out_end+0x4e>
    7741:	e8 3a 2b 00 00       	call   a280 <fwp_po_flush_sock>
    7746:	8b 3d 6c e5 00 00    	mov    0xe56c(%rip),%edi        # 15cb8 <fwp_po_sock>
    774c:	be 01 00 00 00       	mov    $0x1,%esi
    7751:	e8 fa a9 ff ff       	call   2150 <shutdown@plt>
    7756:	eb 35                	jmp    778d <fwp_pipe_out_end+0x5d>
    7758:	48 8b 35 f1 e6 02 00 	mov    0x2e6f1(%rip),%rsi        # 35e50 <fwp_po_ring>
    775f:	c7 86 40 01 00 00 01 	movl   $0x1,0x140(%rsi)
    7766:	00 00 00 
    7769:	48 8d be c0 00 00 00 	lea    0xc0(%rsi),%rdi
    7770:	48 81 c6 c4 00 00 00 	add    $0xc4,%rsi
    7777:	e8 14 2d 00 00       	call   a490 <fwp_ring_wake>
    777c:	eb 0f                	jmp    778d <fwp_pipe_out_end+0x5d>
    777e:	48 8b 05 33 c8 00 00 	mov    0xc833(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    7785:	48 8b 38             	mov    (%rax),%rdi
    7788:	e8 b3 ab ff ff       	call   2340 <fflush@plt>
    778d:	8b 3d 21 e5 00 00    	mov    0xe521(%rip),%edi        # 15cb4 <fwp_po_listen>
    7793:	85 ff                	test   %edi,%edi
    7795:	78 0f                	js     77a6 <fwp_pipe_out_end+0x76>
    7797:	e8 84 aa ff ff       	call   2220 <close@plt>
    779c:	c7 05 0e e5 00 00 ff 	movl   $0xffffffff,0xe50e(%rip)        # 15cb4 <fwp_po_listen>
    77a3:	ff ff ff 
    77a6:	58                   	pop    %rax
    77a7:	c3                   	ret
    77a8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    77af:	00 

00000000000077b0 <fwp_valid_utf8>:
    77b0:	48 85 f6             	test   %rsi,%rsi
    77b3:	0f 84 48 01 00 00    	je     7901 <fwp_valid_utf8+0x151>
    77b9:	53                   	push   %rbx
    77ba:	31 c9                	xor    %ecx,%ecx
    77bc:	eb 0e                	jmp    77cc <fwp_valid_utf8+0x1c>
    77be:	66 90                	xchg   %ax,%ax
    77c0:	48 ff c1             	inc    %rcx
    77c3:	48 39 f1             	cmp    %rsi,%rcx
    77c6:	0f 83 2e 01 00 00    	jae    78fa <fwp_valid_utf8+0x14a>
    77cc:	44 0f b6 14 0f       	movzbl (%rdi,%rcx,1),%r10d
    77d1:	45 84 d2             	test   %r10b,%r10b
    77d4:	79 ea                	jns    77c0 <fwp_valid_utf8+0x10>
    77d6:	41 8d 42 3e          	lea    0x3e(%r10),%eax
    77da:	3c 1e                	cmp    $0x1e,%al
    77dc:	73 12                	jae    77f0 <fwp_valid_utf8+0x40>
    77de:	ba 80 00 00 00       	mov    $0x80,%edx
    77e3:	b8 01 00 00 00       	mov    $0x1,%eax
    77e8:	41 b8 1f 00 00 00    	mov    $0x1f,%r8d
    77ee:	eb 37                	jmp    7827 <fwp_valid_utf8+0x77>
    77f0:	44 89 d0             	mov    %r10d,%eax
    77f3:	24 f0                	and    $0xf0,%al
    77f5:	3c e0                	cmp    $0xe0,%al
    77f7:	75 12                	jne    780b <fwp_valid_utf8+0x5b>
    77f9:	ba 00 08 00 00       	mov    $0x800,%edx
    77fe:	b8 02 00 00 00       	mov    $0x2,%eax
    7803:	41 b8 0f 00 00 00    	mov    $0xf,%r8d
    7809:	eb 1c                	jmp    7827 <fwp_valid_utf8+0x77>
    780b:	41 8d 42 10          	lea    0x10(%r10),%eax
    780f:	3c 04                	cmp    $0x4,%al
    7811:	0f 87 f0 00 00 00    	ja     7907 <fwp_valid_utf8+0x157>
    7817:	ba 00 00 01 00       	mov    $0x10000,%edx
    781c:	b8 03 00 00 00       	mov    $0x3,%eax
    7821:	41 b8 07 00 00 00    	mov    $0x7,%r8d
    7827:	41 89 c1             	mov    %eax,%r9d
    782a:	4e 8d 1c 09          	lea    (%rcx,%r9,1),%r11
    782e:	31 c0                	xor    %eax,%eax
    7830:	49 39 f3             	cmp    %rsi,%r11
    7833:	0f 83 c6 00 00 00    	jae    78ff <fwp_valid_utf8+0x14f>
    7839:	44 0f b6 5c 0f 01    	movzbl 0x1(%rdi,%rcx,1),%r11d
    783f:	44 89 db             	mov    %r11d,%ebx
    7842:	83 e3 c0             	and    $0xffffffc0,%ebx
    7845:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
    784b:	0f 85 ae 00 00 00    	jne    78ff <fwp_valid_utf8+0x14f>
    7851:	45 21 d0             	and    %r10d,%r8d
    7854:	45 8d 51 01          	lea    0x1(%r9),%r10d
    7858:	44 89 c3             	mov    %r8d,%ebx
    785b:	c1 e3 06             	shl    $0x6,%ebx
    785e:	41 83 e3 3f          	and    $0x3f,%r11d
    7862:	41 09 db             	or     %ebx,%r11d
    7865:	41 83 fa 02          	cmp    $0x2,%r10d
    7869:	75 0d                	jne    7878 <fwp_valid_utf8+0xc8>
    786b:	45 89 da             	mov    %r11d,%r10d
    786e:	41 39 d2             	cmp    %edx,%r10d
    7871:	73 62                	jae    78d5 <fwp_valid_utf8+0x125>
    7873:	e9 87 00 00 00       	jmp    78ff <fwp_valid_utf8+0x14f>
    7878:	44 0f b6 44 0f 02    	movzbl 0x2(%rdi,%rcx,1),%r8d
    787e:	44 89 c3             	mov    %r8d,%ebx
    7881:	83 e3 c0             	and    $0xffffffc0,%ebx
    7884:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
    788a:	75 73                	jne    78ff <fwp_valid_utf8+0x14f>
    788c:	44 89 db             	mov    %r11d,%ebx
    788f:	c1 e3 06             	shl    $0x6,%ebx
    7892:	41 83 e0 3f          	and    $0x3f,%r8d
    7896:	41 09 d8             	or     %ebx,%r8d
    7899:	41 83 fa 03          	cmp    $0x3,%r10d
    789d:	75 0d                	jne    78ac <fwp_valid_utf8+0xfc>
    789f:	45 89 c2             	mov    %r8d,%r10d
    78a2:	45 89 d8             	mov    %r11d,%r8d
    78a5:	41 39 d2             	cmp    %edx,%r10d
    78a8:	73 2b                	jae    78d5 <fwp_valid_utf8+0x125>
    78aa:	eb 53                	jmp    78ff <fwp_valid_utf8+0x14f>
    78ac:	44 0f b6 54 0f 03    	movzbl 0x3(%rdi,%rcx,1),%r10d
    78b2:	45 89 d3             	mov    %r10d,%r11d
    78b5:	41 83 e3 c0          	and    $0xffffffc0,%r11d
    78b9:	41 81 fb 80 00 00 00 	cmp    $0x80,%r11d
    78c0:	75 3d                	jne    78ff <fwp_valid_utf8+0x14f>
    78c2:	45 89 c3             	mov    %r8d,%r11d
    78c5:	41 c1 e3 06          	shl    $0x6,%r11d
    78c9:	41 83 e2 3f          	and    $0x3f,%r10d
    78cd:	45 09 da             	or     %r11d,%r10d
    78d0:	41 39 d2             	cmp    %edx,%r10d
    78d3:	72 2a                	jb     78ff <fwp_valid_utf8+0x14f>
    78d5:	41 81 fa ff ff 10 00 	cmp    $0x10ffff,%r10d
    78dc:	77 21                	ja     78ff <fwp_valid_utf8+0x14f>
    78de:	41 83 e0 e0          	and    $0xffffffe0,%r8d
    78e2:	41 81 f8 60 03 00 00 	cmp    $0x360,%r8d
    78e9:	74 14                	je     78ff <fwp_valid_utf8+0x14f>
    78eb:	4c 01 c9             	add    %r9,%rcx
    78ee:	48 ff c1             	inc    %rcx
    78f1:	48 39 f1             	cmp    %rsi,%rcx
    78f4:	0f 82 d2 fe ff ff    	jb     77cc <fwp_valid_utf8+0x1c>
    78fa:	b8 01 00 00 00       	mov    $0x1,%eax
    78ff:	5b                   	pop    %rbx
    7900:	c3                   	ret
    7901:	b8 01 00 00 00       	mov    $0x1,%eax
    7906:	c3                   	ret
    7907:	31 c0                	xor    %eax,%eax
    7909:	5b                   	pop    %rbx
    790a:	c3                   	ret
    790b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000007910 <fwp_str_new>:
    7910:	41 57                	push   %r15
    7912:	41 56                	push   %r14
    7914:	53                   	push   %rbx
    7915:	48 89 f3             	mov    %rsi,%rbx
    7918:	49 89 fe             	mov    %rdi,%r14
    791b:	48 8d 7e 09          	lea    0x9(%rsi),%rdi
    791f:	e8 2c ee ff ff       	call   6750 <fwp_alloc_leaf>
    7924:	49 89 c7             	mov    %rax,%r15
    7927:	48 89 18             	mov    %rbx,(%rax)
    792a:	48 8d 78 08          	lea    0x8(%rax),%rdi
    792e:	4c 89 f6             	mov    %r14,%rsi
    7931:	48 89 da             	mov    %rbx,%rdx
    7934:	e8 e7 a9 ff ff       	call   2320 <memcpy@plt>
    7939:	41 c6 44 1f 08 00    	movb   $0x0,0x8(%r15,%rbx,1)
    793f:	4c 89 f8             	mov    %r15,%rax
    7942:	5b                   	pop    %rbx
    7943:	41 5e                	pop    %r14
    7945:	41 5f                	pop    %r15
    7947:	c3                   	ret
    7948:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    794f:	00 

0000000000007950 <buf_putc>:
    7950:	50                   	push   %rax
    7951:	40 88 74 24 07       	mov    %sil,0x7(%rsp)
    7956:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
    795b:	ba 01 00 00 00       	mov    $0x1,%edx
    7960:	e8 3b 00 00 00       	call   79a0 <buf_put>
    7965:	58                   	pop    %rax
    7966:	c3                   	ret
    7967:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    796e:	00 00 

0000000000007970 <buf_puts>:
    7970:	41 56                	push   %r14
    7972:	53                   	push   %rbx
    7973:	50                   	push   %rax
    7974:	48 89 f3             	mov    %rsi,%rbx
    7977:	49 89 fe             	mov    %rdi,%r14
    797a:	48 89 f7             	mov    %rsi,%rdi
    797d:	e8 de a7 ff ff       	call   2160 <strlen@plt>
    7982:	4c 89 f7             	mov    %r14,%rdi
    7985:	48 89 de             	mov    %rbx,%rsi
    7988:	48 89 c2             	mov    %rax,%rdx
    798b:	48 83 c4 08          	add    $0x8,%rsp
    798f:	5b                   	pop    %rbx
    7990:	41 5e                	pop    %r14
    7992:	eb 0c                	jmp    79a0 <buf_put>
    7994:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    799b:	00 00 00 00 00 

00000000000079a0 <buf_put>:
    79a0:	41 57                	push   %r15
    79a2:	41 56                	push   %r14
    79a4:	53                   	push   %rbx
    79a5:	48 89 d3             	mov    %rdx,%rbx
    79a8:	49 89 f6             	mov    %rsi,%r14
    79ab:	49 89 ff             	mov    %rdi,%r15
    79ae:	48 89 d6             	mov    %rdx,%rsi
    79b1:	e8 6a 00 00 00       	call   7a20 <buf_grow>
    79b6:	49 8b 3f             	mov    (%r15),%rdi
    79b9:	49 03 7f 08          	add    0x8(%r15),%rdi
    79bd:	4c 89 f6             	mov    %r14,%rsi
    79c0:	48 89 da             	mov    %rbx,%rdx
    79c3:	e8 58 a9 ff ff       	call   2320 <memcpy@plt>
    79c8:	49 03 5f 08          	add    0x8(%r15),%rbx
    79cc:	49 89 5f 08          	mov    %rbx,0x8(%r15)
    79d0:	49 8b 07             	mov    (%r15),%rax
    79d3:	c6 04 18 00          	movb   $0x0,(%rax,%rbx,1)
    79d7:	5b                   	pop    %rbx
    79d8:	41 5e                	pop    %r14
    79da:	41 5f                	pop    %r15
    79dc:	c3                   	ret
    79dd:	0f 1f 00             	nopl   (%rax)

00000000000079e0 <buf_to_str>:
    79e0:	41 56                	push   %r14
    79e2:	53                   	push   %rbx
    79e3:	50                   	push   %rax
    79e4:	48 89 fb             	mov    %rdi,%rbx
    79e7:	48 8b 07             	mov    (%rdi),%rax
    79ea:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    79ee:	48 85 c0             	test   %rax,%rax
    79f1:	48 8d 3d be 76 00 00 	lea    0x76be(%rip),%rdi        # f0b6 <exec_in_fp0+0xa56>
    79f8:	48 0f 45 f8          	cmovne %rax,%rdi
    79fc:	e8 0f ff ff ff       	call   7910 <fwp_str_new>
    7a01:	49 89 c6             	mov    %rax,%r14
    7a04:	48 8b 3b             	mov    (%rbx),%rdi
    7a07:	e8 44 a6 ff ff       	call   2050 <free@plt>
    7a0c:	4c 89 f0             	mov    %r14,%rax
    7a0f:	48 83 c4 08          	add    $0x8,%rsp
    7a13:	5b                   	pop    %rbx
    7a14:	41 5e                	pop    %r14
    7a16:	c3                   	ret
    7a17:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    7a1e:	00 00 

0000000000007a20 <buf_grow>:
    7a20:	41 56                	push   %r14
    7a22:	53                   	push   %rbx
    7a23:	50                   	push   %rax
    7a24:	48 8b 47 08          	mov    0x8(%rdi),%rax
    7a28:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    7a2c:	74 73                	je     7aa1 <buf_grow+0x81>
    7a2e:	48 c7 c1 fe ff ff ff 	mov    $0xfffffffffffffffe,%rcx
    7a35:	48 29 c1             	sub    %rax,%rcx
    7a38:	48 39 f1             	cmp    %rsi,%rcx
    7a3b:	72 64                	jb     7aa1 <buf_grow+0x81>
    7a3d:	48 89 fb             	mov    %rdi,%rbx
    7a40:	48 01 f0             	add    %rsi,%rax
    7a43:	48 ff c0             	inc    %rax
    7a46:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    7a4a:	48 39 c8             	cmp    %rcx,%rax
    7a4d:	76 4a                	jbe    7a99 <buf_grow+0x79>
    7a4f:	48 85 c9             	test   %rcx,%rcx
    7a52:	41 be 40 00 00 00    	mov    $0x40,%r14d
    7a58:	4c 0f 45 f1          	cmovne %rcx,%r14
    7a5c:	49 39 c6             	cmp    %rax,%r14
    7a5f:	73 21                	jae    7a82 <buf_grow+0x62>
    7a61:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7a68:	0f 1f 84 00 00 00 00 
    7a6f:	00 
    7a70:	4d 85 f6             	test   %r14,%r14
    7a73:	78 0a                	js     7a7f <buf_grow+0x5f>
    7a75:	4d 01 f6             	add    %r14,%r14
    7a78:	49 39 c6             	cmp    %rax,%r14
    7a7b:	72 f3                	jb     7a70 <buf_grow+0x50>
    7a7d:	eb 03                	jmp    7a82 <buf_grow+0x62>
    7a7f:	49 89 c6             	mov    %rax,%r14
    7a82:	48 8b 3b             	mov    (%rbx),%rdi
    7a85:	4c 89 f6             	mov    %r14,%rsi
    7a88:	e8 e3 a8 ff ff       	call   2370 <realloc@plt>
    7a8d:	48 85 c0             	test   %rax,%rax
    7a90:	74 0f                	je     7aa1 <buf_grow+0x81>
    7a92:	48 89 03             	mov    %rax,(%rbx)
    7a95:	4c 89 73 10          	mov    %r14,0x10(%rbx)
    7a99:	48 83 c4 08          	add    $0x8,%rsp
    7a9d:	5b                   	pop    %rbx
    7a9e:	41 5e                	pop    %r14
    7aa0:	c3                   	ret
    7aa1:	48 8b 05 38 c5 00 00 	mov    0xc538(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    7aa8:	48 8b 08             	mov    (%rax),%rcx
    7aab:	48 8d 3d de 6c 00 00 	lea    0x6cde(%rip),%rdi        # e790 <exec_in_fp0+0x130>
    7ab2:	be 13 00 00 00       	mov    $0x13,%esi
    7ab7:	ba 01 00 00 00       	mov    $0x1,%edx
    7abc:	e8 cf a9 ff ff       	call   2490 <fwrite@plt>
    7ac1:	bf 66 00 00 00       	mov    $0x66,%edi
    7ac6:	e8 a5 a9 ff ff       	call   2470 <exit@plt>
    7acb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000007ad0 <fwp_is_number_arg>:
    7ad0:	31 c0                	xor    %eax,%eax
    7ad2:	80 3f 2d             	cmpb   $0x2d,(%rdi)
    7ad5:	75 19                	jne    7af0 <fwp_is_number_arg+0x20>
    7ad7:	0f b6 4f 01          	movzbl 0x1(%rdi),%ecx
    7adb:	8d 51 d0             	lea    -0x30(%rcx),%edx
    7ade:	b8 01 00 00 00       	mov    $0x1,%eax
    7ae3:	80 fa 0a             	cmp    $0xa,%dl
    7ae6:	72 08                	jb     7af0 <fwp_is_number_arg+0x20>
    7ae8:	31 c0                	xor    %eax,%eax
    7aea:	80 f9 2e             	cmp    $0x2e,%cl
    7aed:	0f 94 c0             	sete   %al
    7af0:	c3                   	ret
    7af1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7af8:	0f 1f 84 00 00 00 00 
    7aff:	00 

0000000000007b00 <fwp_strf>:
    7b00:	55                   	push   %rbp
    7b01:	41 57                	push   %r15
    7b03:	41 56                	push   %r14
    7b05:	41 55                	push   %r13
    7b07:	41 54                	push   %r12
    7b09:	53                   	push   %rbx
    7b0a:	48 81 ec d8 00 00 00 	sub    $0xd8,%rsp
    7b11:	48 89 fb             	mov    %rdi,%rbx
    7b14:	48 89 74 24 28       	mov    %rsi,0x28(%rsp)
    7b19:	48 89 54 24 30       	mov    %rdx,0x30(%rsp)
    7b1e:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
    7b23:	4c 89 44 24 40       	mov    %r8,0x40(%rsp)
    7b28:	4c 89 4c 24 48       	mov    %r9,0x48(%rsp)
    7b2d:	84 c0                	test   %al,%al
    7b2f:	74 37                	je     7b68 <fwp_strf+0x68>
    7b31:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
    7b36:	0f 29 4c 24 60       	movaps %xmm1,0x60(%rsp)
    7b3b:	0f 29 54 24 70       	movaps %xmm2,0x70(%rsp)
    7b40:	0f 29 9c 24 80 00 00 	movaps %xmm3,0x80(%rsp)
    7b47:	00 
    7b48:	0f 29 a4 24 90 00 00 	movaps %xmm4,0x90(%rsp)
    7b4f:	00 
    7b50:	0f 29 ac 24 a0 00 00 	movaps %xmm5,0xa0(%rsp)
    7b57:	00 
    7b58:	0f 29 b4 24 b0 00 00 	movaps %xmm6,0xb0(%rsp)
    7b5f:	00 
    7b60:	0f 29 bc 24 c0 00 00 	movaps %xmm7,0xc0(%rsp)
    7b67:	00 
    7b68:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    7b6d:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    7b72:	48 8d 84 24 10 01 00 	lea    0x110(%rsp),%rax
    7b79:	00 
    7b7a:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    7b7f:	48 bd 08 00 00 00 30 	movabs $0x3000000008,%rbp
    7b86:	00 00 00 
    7b89:	48 89 2c 24          	mov    %rbp,(%rsp)
    7b8d:	49 89 e6             	mov    %rsp,%r14
    7b90:	31 ff                	xor    %edi,%edi
    7b92:	31 f6                	xor    %esi,%esi
    7b94:	48 89 da             	mov    %rbx,%rdx
    7b97:	4c 89 f1             	mov    %r14,%rcx
    7b9a:	e8 61 a5 ff ff       	call   2100 <vsnprintf@plt>
    7b9f:	4c 63 f8             	movslq %eax,%r15
    7ba2:	4d 8d 67 01          	lea    0x1(%r15),%r12
    7ba6:	4c 89 e7             	mov    %r12,%rdi
    7ba9:	e8 a2 eb ff ff       	call   6750 <fwp_alloc_leaf>
    7bae:	49 89 c5             	mov    %rax,%r13
    7bb1:	48 89 2c 24          	mov    %rbp,(%rsp)
    7bb5:	48 8d 84 24 10 01 00 	lea    0x110(%rsp),%rax
    7bbc:	00 
    7bbd:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    7bc2:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    7bc7:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    7bcc:	4c 89 ef             	mov    %r13,%rdi
    7bcf:	4c 89 e6             	mov    %r12,%rsi
    7bd2:	48 89 da             	mov    %rbx,%rdx
    7bd5:	4c 89 f1             	mov    %r14,%rcx
    7bd8:	e8 23 a5 ff ff       	call   2100 <vsnprintf@plt>
    7bdd:	4c 89 ef             	mov    %r13,%rdi
    7be0:	4c 89 fe             	mov    %r15,%rsi
    7be3:	e8 28 fd ff ff       	call   7910 <fwp_str_new>
    7be8:	48 81 c4 d8 00 00 00 	add    $0xd8,%rsp
    7bef:	5b                   	pop    %rbx
    7bf0:	41 5c                	pop    %r12
    7bf2:	41 5d                	pop    %r13
    7bf4:	41 5e                	pop    %r14
    7bf6:	41 5f                	pop    %r15
    7bf8:	5d                   	pop    %rbp
    7bf9:	c3                   	ret
    7bfa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000007c00 <fwp_cli_value>:
    7c00:	55                   	push   %rbp
    7c01:	41 57                	push   %r15
    7c03:	41 56                	push   %r14
    7c05:	41 55                	push   %r13
    7c07:	41 54                	push   %r12
    7c09:	53                   	push   %rbx
    7c0a:	48 83 ec 58          	sub    $0x58,%rsp
    7c0e:	49 89 cf             	mov    %rcx,%r15
    7c11:	48 89 d3             	mov    %rdx,%rbx
    7c14:	49 89 f6             	mov    %rsi,%r14
    7c17:	49 89 fc             	mov    %rdi,%r12
    7c1a:	e8 91 01 00 00       	call   7db0 <fwp_is_enum>
    7c1f:	85 c0                	test   %eax,%eax
    7c21:	0f 84 ef 00 00 00    	je     7d16 <fwp_cli_value+0x116>
    7c27:	48 89 5c 24 38       	mov    %rbx,0x38(%rsp)
    7c2c:	0f 57 c0             	xorps  %xmm0,%xmm0
    7c2f:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    7c34:	48 c7 44 24 50 00 00 	movq   $0x0,0x50(%rsp)
    7c3b:	00 00 
    7c3d:	0f 29 04 24          	movaps %xmm0,(%rsp)
    7c41:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    7c48:	00 00 
    7c4a:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
    7c4f:	4c 89 e6             	mov    %r12,%rsi
    7c52:	4c 89 74 24 30       	mov    %r14,0x30(%rsp)
    7c57:	4c 89 f2             	mov    %r14,%rdx
    7c5a:	e8 d1 01 00 00       	call   7e30 <fwp_loose>
    7c5f:	4c 8b 6c 24 40       	mov    0x40(%rsp),%r13
    7c64:	31 db                	xor    %ebx,%ebx
    7c66:	83 3d cb e0 00 00 00 	cmpl   $0x0,0xe0cb(%rip)        # 15d38 <d0+0x10>
    7c6d:	41 be ff ff ff ff    	mov    $0xffffffff,%r14d
    7c73:	7e 7a                	jle    7cef <fwp_cli_value+0xef>
    7c75:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
    7c7a:	48 85 ed             	test   %rbp,%rbp
    7c7d:	74 70                	je     7cef <fwp_cli_value+0xef>
    7c7f:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
    7c84:	4c 89 7c 24 28       	mov    %r15,0x28(%rsp)
    7c89:	45 31 ff             	xor    %r15d,%r15d
    7c8c:	48 89 e3             	mov    %rsp,%rbx
    7c8f:	90                   	nop
    7c90:	48 8b 05 a9 e0 00 00 	mov    0xe0a9(%rip),%rax        # 15d40 <d0+0x18>
    7c97:	4e 8b 24 f8          	mov    (%rax,%r15,8),%r12
    7c9b:	4c 89 e7             	mov    %r12,%rdi
    7c9e:	e8 bd a4 ff ff       	call   2160 <strlen@plt>
    7ca3:	48 89 df             	mov    %rbx,%rdi
    7ca6:	4c 89 e6             	mov    %r12,%rsi
    7ca9:	48 89 c2             	mov    %rax,%rdx
    7cac:	e8 7f 01 00 00       	call   7e30 <fwp_loose>
    7cb1:	48 39 6c 24 08       	cmp    %rbp,0x8(%rsp)
    7cb6:	75 15                	jne    7ccd <fwp_cli_value+0xcd>
    7cb8:	48 8b 3c 24          	mov    (%rsp),%rdi
    7cbc:	4c 89 ee             	mov    %r13,%rsi
    7cbf:	48 89 ea             	mov    %rbp,%rdx
    7cc2:	e8 99 a6 ff ff       	call   2360 <bcmp@plt>
    7cc7:	85 c0                	test   %eax,%eax
    7cc9:	45 0f 44 f7          	cmove  %r15d,%r14d
    7ccd:	49 ff c7             	inc    %r15
    7cd0:	48 63 05 61 e0 00 00 	movslq 0xe061(%rip),%rax        # 15d38 <d0+0x10>
    7cd7:	49 39 c7             	cmp    %rax,%r15
    7cda:	7d 05                	jge    7ce1 <fwp_cli_value+0xe1>
    7cdc:	45 85 f6             	test   %r14d,%r14d
    7cdf:	78 af                	js     7c90 <fwp_cli_value+0x90>
    7ce1:	48 8b 1c 24          	mov    (%rsp),%rbx
    7ce5:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
    7cea:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
    7cef:	4c 89 ef             	mov    %r13,%rdi
    7cf2:	e8 59 a3 ff ff       	call   2050 <free@plt>
    7cf7:	48 89 df             	mov    %rbx,%rdi
    7cfa:	e8 51 a3 ff ff       	call   2050 <free@plt>
    7cff:	45 85 f6             	test   %r14d,%r14d
    7d02:	78 3e                	js     7d42 <fwp_cli_value+0x142>
    7d04:	44 89 f0             	mov    %r14d,%eax
    7d07:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
    7d0c:	48 89 01             	mov    %rax,(%rcx)
    7d0f:	bb 01 00 00 00       	mov    $0x1,%ebx
    7d14:	eb 50                	jmp    7d66 <fwp_cli_value+0x166>
    7d16:	4c 89 e7             	mov    %r12,%rdi
    7d19:	4c 89 f6             	mov    %r14,%rsi
    7d1c:	48 89 da             	mov    %rbx,%rdx
    7d1f:	e8 dc eb ff ff       	call   6900 <fwp_parse_text>
    7d24:	bb 01 00 00 00       	mov    $0x1,%ebx
    7d29:	85 c0                	test   %eax,%eax
    7d2b:	75 39                	jne    7d66 <fwp_cli_value+0x166>
    7d2d:	48 8d 3d 38 75 00 00 	lea    0x7538(%rip),%rdi        # f26c <exec_in_fp0+0xc0c>
    7d34:	48 8d 0d 81 77 00 00 	lea    0x7781(%rip),%rcx        # f4bc <exec_in_fp0+0xe5c>
    7d3b:	31 db                	xor    %ebx,%ebx
    7d3d:	44 89 f6             	mov    %r14d,%esi
    7d40:	eb 17                	jmp    7d59 <fwp_cli_value+0x159>
    7d42:	e8 69 01 00 00       	call   7eb0 <fwp_choices>
    7d47:	48 8d 48 08          	lea    0x8(%rax),%rcx
    7d4b:	48 8d 3d 02 75 00 00 	lea    0x7502(%rip),%rdi        # f254 <exec_in_fp0+0xbf4>
    7d52:	31 db                	xor    %ebx,%ebx
    7d54:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    7d59:	4c 89 e2             	mov    %r12,%rdx
    7d5c:	31 c0                	xor    %eax,%eax
    7d5e:	e8 9d fd ff ff       	call   7b00 <fwp_strf>
    7d63:	49 89 07             	mov    %rax,(%r15)
    7d66:	89 d8                	mov    %ebx,%eax
    7d68:	48 83 c4 58          	add    $0x58,%rsp
    7d6c:	5b                   	pop    %rbx
    7d6d:	41 5c                	pop    %r12
    7d6f:	41 5d                	pop    %r13
    7d71:	41 5e                	pop    %r14
    7d73:	41 5f                	pop    %r15
    7d75:	5d                   	pop    %rbp
    7d76:	c3                   	ret
    7d77:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    7d7e:	00 00 

0000000000007d80 <fwp_cons>:
    7d80:	48 83 ec 18          	sub    $0x18,%rsp
    7d84:	48 89 3c 24          	mov    %rdi,(%rsp)
    7d88:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    7d8d:	48 89 e2             	mov    %rsp,%rdx
    7d90:	bf 01 00 00 00       	mov    $0x1,%edi
    7d95:	be 02 00 00 00       	mov    $0x2,%esi
    7d9a:	e8 d1 b2 ff ff       	call   3070 <fwp_data>
    7d9f:	48 83 c4 18          	add    $0x18,%rsp
    7da3:	c3                   	ret
    7da4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    7dab:	00 00 00 00 00 

0000000000007db0 <fwp_is_enum>:
    7db0:	31 c0                	xor    %eax,%eax
    7db2:	83 3d 6f df 00 00 0e 	cmpl   $0xe,0xdf6f(%rip)        # 15d28 <d0>
    7db9:	75 67                	jne    7e22 <fwp_is_enum+0x72>
    7dbb:	53                   	push   %rbx
    7dbc:	8b 1d 76 df 00 00    	mov    0xdf76(%rip),%ebx        # 15d38 <d0+0x10>
    7dc2:	85 db                	test   %ebx,%ebx
    7dc4:	74 5b                	je     7e21 <fwp_is_enum+0x71>
    7dc6:	48 8b 3d 63 df 00 00 	mov    0xdf63(%rip),%rdi        # 15d30 <d0+0x8>
    7dcd:	48 85 ff             	test   %rdi,%rdi
    7dd0:	74 14                	je     7de6 <fwp_is_enum+0x36>
    7dd2:	48 8d 35 ad 74 00 00 	lea    0x74ad(%rip),%rsi        # f286 <exec_in_fp0+0xc26>
    7dd9:	e8 e2 a4 ff ff       	call   22c0 <strcmp@plt>
    7dde:	89 c1                	mov    %eax,%ecx
    7de0:	31 c0                	xor    %eax,%eax
    7de2:	85 c9                	test   %ecx,%ecx
    7de4:	74 3b                	je     7e21 <fwp_is_enum+0x71>
    7de6:	85 db                	test   %ebx,%ebx
    7de8:	7e 32                	jle    7e1c <fwp_is_enum+0x6c>
    7dea:	48 8b 0d 5f df 00 00 	mov    0xdf5f(%rip),%rcx        # 15d50 <d0+0x28>
    7df1:	83 39 00             	cmpl   $0x0,(%rcx)
    7df4:	75 2b                	jne    7e21 <fwp_is_enum+0x71>
    7df6:	b8 01 00 00 00       	mov    $0x1,%eax
    7dfb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7e00:	48 89 c2             	mov    %rax,%rdx
    7e03:	48 39 c3             	cmp    %rax,%rbx
    7e06:	74 0a                	je     7e12 <fwp_is_enum+0x62>
    7e08:	48 8d 42 01          	lea    0x1(%rdx),%rax
    7e0c:	83 3c 91 00          	cmpl   $0x0,(%rcx,%rdx,4)
    7e10:	74 ee                	je     7e00 <fwp_is_enum+0x50>
    7e12:	31 c0                	xor    %eax,%eax
    7e14:	48 39 da             	cmp    %rbx,%rdx
    7e17:	0f 93 c0             	setae  %al
    7e1a:	eb 05                	jmp    7e21 <fwp_is_enum+0x71>
    7e1c:	b8 01 00 00 00       	mov    $0x1,%eax
    7e21:	5b                   	pop    %rbx
    7e22:	c3                   	ret
    7e23:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7e2a:	84 00 00 00 00 00 

0000000000007e30 <fwp_loose>:
    7e30:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
    7e37:	00 
    7e38:	48 85 d2             	test   %rdx,%rdx
    7e3b:	74 63                	je     7ea0 <fwp_loose+0x70>
    7e3d:	41 57                	push   %r15
    7e3f:	41 56                	push   %r14
    7e41:	41 54                	push   %r12
    7e43:	53                   	push   %rbx
    7e44:	50                   	push   %rax
    7e45:	48 89 d3             	mov    %rdx,%rbx
    7e48:	49 89 f6             	mov    %rsi,%r14
    7e4b:	49 89 ff             	mov    %rdi,%r15
    7e4e:	45 31 e4             	xor    %r12d,%r12d
    7e51:	eb 15                	jmp    7e68 <fwp_loose+0x38>
    7e53:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7e5a:	84 00 00 00 00 00 
    7e60:	49 ff c4             	inc    %r12
    7e63:	4c 39 e3             	cmp    %r12,%rbx
    7e66:	74 2d                	je     7e95 <fwp_loose+0x65>
    7e68:	43 0f b6 04 26       	movzbl (%r14,%r12,1),%eax
    7e6d:	83 f8 2d             	cmp    $0x2d,%eax
    7e70:	74 ee                	je     7e60 <fwp_loose+0x30>
    7e72:	83 f8 5f             	cmp    $0x5f,%eax
    7e75:	74 e9                	je     7e60 <fwp_loose+0x30>
    7e77:	8d 48 bf             	lea    -0x41(%rax),%ecx
    7e7a:	0f b6 d0             	movzbl %al,%edx
    7e7d:	0c 20                	or     $0x20,%al
    7e7f:	80 f9 1a             	cmp    $0x1a,%cl
    7e82:	0f b6 c0             	movzbl %al,%eax
    7e85:	0f 43 c2             	cmovae %edx,%eax
    7e88:	0f be f0             	movsbl %al,%esi
    7e8b:	4c 89 ff             	mov    %r15,%rdi
    7e8e:	e8 bd fa ff ff       	call   7950 <buf_putc>
    7e93:	eb cb                	jmp    7e60 <fwp_loose+0x30>
    7e95:	48 83 c4 08          	add    $0x8,%rsp
    7e99:	5b                   	pop    %rbx
    7e9a:	41 5c                	pop    %r12
    7e9c:	41 5e                	pop    %r14
    7e9e:	41 5f                	pop    %r15
    7ea0:	c3                   	ret
    7ea1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7ea8:	0f 1f 84 00 00 00 00 
    7eaf:	00 

0000000000007eb0 <fwp_choices>:
    7eb0:	41 57                	push   %r15
    7eb2:	41 56                	push   %r14
    7eb4:	53                   	push   %rbx
    7eb5:	48 83 ec 20          	sub    $0x20,%rsp
    7eb9:	0f 57 c0             	xorps  %xmm0,%xmm0
    7ebc:	0f 29 04 24          	movaps %xmm0,(%rsp)
    7ec0:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    7ec7:	00 00 
    7ec9:	83 3d 68 de 00 00 00 	cmpl   $0x0,0xde68(%rip)        # 15d38 <d0+0x10>
    7ed0:	7e 5b                	jle    7f2d <fwp_choices+0x7d>
    7ed2:	48 8b 05 67 de 00 00 	mov    0xde67(%rip),%rax        # 15d40 <d0+0x18>
    7ed9:	48 8b 30             	mov    (%rax),%rsi
    7edc:	48 89 e7             	mov    %rsp,%rdi
    7edf:	e8 5c 00 00 00       	call   7f40 <fwp_kebab>
    7ee4:	83 3d 4d de 00 00 02 	cmpl   $0x2,0xde4d(%rip)        # 15d38 <d0+0x10>
    7eeb:	7c 40                	jl     7f2d <fwp_choices+0x7d>
    7eed:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    7ef3:	48 8d 1d 91 73 00 00 	lea    0x7391(%rip),%rbx        # f28b <exec_in_fp0+0xc2b>
    7efa:	49 89 e6             	mov    %rsp,%r14
    7efd:	0f 1f 00             	nopl   (%rax)
    7f00:	4c 89 f7             	mov    %r14,%rdi
    7f03:	48 89 de             	mov    %rbx,%rsi
    7f06:	e8 65 fa ff ff       	call   7970 <buf_puts>
    7f0b:	48 8b 05 2e de 00 00 	mov    0xde2e(%rip),%rax        # 15d40 <d0+0x18>
    7f12:	4a 8b 34 f8          	mov    (%rax,%r15,8),%rsi
    7f16:	4c 89 f7             	mov    %r14,%rdi
    7f19:	e8 22 00 00 00       	call   7f40 <fwp_kebab>
    7f1e:	49 ff c7             	inc    %r15
    7f21:	48 63 05 10 de 00 00 	movslq 0xde10(%rip),%rax        # 15d38 <d0+0x10>
    7f28:	49 39 c7             	cmp    %rax,%r15
    7f2b:	7c d3                	jl     7f00 <fwp_choices+0x50>
    7f2d:	48 89 e7             	mov    %rsp,%rdi
    7f30:	e8 ab fa ff ff       	call   79e0 <buf_to_str>
    7f35:	48 83 c4 20          	add    $0x20,%rsp
    7f39:	5b                   	pop    %rbx
    7f3a:	41 5e                	pop    %r14
    7f3c:	41 5f                	pop    %r15
    7f3e:	c3                   	ret
    7f3f:	90                   	nop

0000000000007f40 <fwp_kebab>:
    7f40:	41 57                	push   %r15
    7f42:	41 56                	push   %r14
    7f44:	53                   	push   %rbx
    7f45:	44 0f b6 3e          	movzbl (%rsi),%r15d
    7f49:	45 84 ff             	test   %r15b,%r15b
    7f4c:	74 71                	je     7fbf <fwp_kebab+0x7f>
    7f4e:	48 89 f3             	mov    %rsi,%rbx
    7f51:	49 89 fe             	mov    %rdi,%r14
    7f54:	48 ff c3             	inc    %rbx
    7f57:	31 c0                	xor    %eax,%eax
    7f59:	eb 36                	jmp    7f91 <fwp_kebab+0x51>
    7f5b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7f60:	41 0f be f7          	movsbl %r15b,%esi
    7f64:	4c 89 f7             	mov    %r14,%rdi
    7f67:	e8 e4 f9 ff ff       	call   7950 <buf_putc>
    7f6c:	41 8d 47 9f          	lea    -0x61(%r15),%eax
    7f70:	3c 1a                	cmp    $0x1a,%al
    7f72:	0f 92 c0             	setb   %al
    7f75:	41 80 c7 d0          	add    $0xd0,%r15b
    7f79:	41 80 ff 0a          	cmp    $0xa,%r15b
    7f7d:	0f 92 c1             	setb   %cl
    7f80:	08 c1                	or     %al,%cl
    7f82:	0f b6 c1             	movzbl %cl,%eax
    7f85:	44 0f b6 3b          	movzbl (%rbx),%r15d
    7f89:	48 ff c3             	inc    %rbx
    7f8c:	45 84 ff             	test   %r15b,%r15b
    7f8f:	74 2e                	je     7fbf <fwp_kebab+0x7f>
    7f91:	41 8d 4f bf          	lea    -0x41(%r15),%ecx
    7f95:	80 f9 19             	cmp    $0x19,%cl
    7f98:	77 c6                	ja     7f60 <fwp_kebab+0x20>
    7f9a:	85 c0                	test   %eax,%eax
    7f9c:	74 0d                	je     7fab <fwp_kebab+0x6b>
    7f9e:	4c 89 f7             	mov    %r14,%rdi
    7fa1:	be 2d 00 00 00       	mov    $0x2d,%esi
    7fa6:	e8 a5 f9 ff ff       	call   7950 <buf_putc>
    7fab:	41 80 cf 20          	or     $0x20,%r15b
    7faf:	41 0f be f7          	movsbl %r15b,%esi
    7fb3:	4c 89 f7             	mov    %r14,%rdi
    7fb6:	e8 95 f9 ff ff       	call   7950 <buf_putc>
    7fbb:	31 c0                	xor    %eax,%eax
    7fbd:	eb c6                	jmp    7f85 <fwp_kebab+0x45>
    7fbf:	5b                   	pop    %rbx
    7fc0:	41 5e                	pop    %r14
    7fc2:	41 5f                	pop    %r15
    7fc4:	c3                   	ret
    7fc5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    7fcc:	00 00 00 00 

0000000000007fd0 <tp_value>:
    7fd0:	55                   	push   %rbp
    7fd1:	41 57                	push   %r15
    7fd3:	41 56                	push   %r14
    7fd5:	41 55                	push   %r13
    7fd7:	41 54                	push   %r12
    7fd9:	53                   	push   %rbx
    7fda:	48 81 ec a8 01 00 00 	sub    $0x1a8,%rsp
    7fe1:	48 89 cd             	mov    %rcx,%rbp
    7fe4:	49 89 f6             	mov    %rsi,%r14
    7fe7:	49 89 ff             	mov    %rdi,%r15
    7fea:	85 d2                	test   %edx,%edx
    7fec:	74 4c                	je     803a <tp_value+0x6a>
    7fee:	41 83 3e 0c          	cmpl   $0xc,(%r14)
    7ff2:	75 46                	jne    803a <tp_value+0x6a>
    7ff4:	4d 8b 77 08          	mov    0x8(%r15),%r14
    7ff8:	49 8b 47 10          	mov    0x10(%r15),%rax
    7ffc:	4d 8b 27             	mov    (%r15),%r12
    7fff:	49 01 c4             	add    %rax,%r12
    8002:	49 29 c6             	sub    %rax,%r14
    8005:	4c 89 e7             	mov    %r12,%rdi
    8008:	4c 89 f6             	mov    %r14,%rsi
    800b:	e8 a0 f7 ff ff       	call   77b0 <fwp_valid_utf8>
    8010:	85 c0                	test   %eax,%eax
    8012:	0f 84 e9 07 00 00    	je     8801 <tp_value+0x831>
    8018:	4c 89 e7             	mov    %r12,%rdi
    801b:	4c 89 f6             	mov    %r14,%rsi
    801e:	e8 ed f8 ff ff       	call   7910 <fwp_str_new>
    8023:	48 89 45 00          	mov    %rax,0x0(%rbp)
    8027:	49 8b 47 08          	mov    0x8(%r15),%rax
    802b:	49 89 47 10          	mov    %rax,0x10(%r15)
    802f:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    8035:	e9 ca 07 00 00       	jmp    8804 <tp_value+0x834>
    803a:	41 89 d5             	mov    %edx,%r13d
    803d:	4c 89 ff             	mov    %r15,%rdi
    8040:	e8 bb 08 00 00       	call   8900 <tp_ws>
    8045:	41 8b 06             	mov    (%r14),%eax
    8048:	45 31 e4             	xor    %r12d,%r12d
    804b:	48 83 f8 15          	cmp    $0x15,%rax
    804f:	0f 87 af 07 00 00    	ja     8804 <tp_value+0x834>
    8055:	48 8d 0d 8c 61 00 00 	lea    0x618c(%rip),%rcx        # e1e8 <_IO_stdin_used+0x1e8>
    805c:	48 63 14 81          	movslq (%rcx,%rax,4),%rdx
    8060:	48 01 ca             	add    %rcx,%rdx
    8063:	ff e2                	jmp    *%rdx
    8065:	4c 89 ff             	mov    %r15,%rdi
    8068:	4c 89 f6             	mov    %r14,%rsi
    806b:	48 89 ea             	mov    %rbp,%rdx
    806e:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    8075:	5b                   	pop    %rbx
    8076:	41 5c                	pop    %r12
    8078:	41 5d                	pop    %r13
    807a:	41 5e                	pop    %r14
    807c:	41 5f                	pop    %r15
    807e:	5d                   	pop    %rbp
    807f:	e9 cc 08 00 00       	jmp    8950 <tp_int>
    8084:	41 0f 10 46 38       	movups 0x38(%r14),%xmm0
    8089:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    808e:	31 c9                	xor    %ecx,%ecx
    8090:	83 f8 13             	cmp    $0x13,%eax
    8093:	0f 94 c1             	sete   %cl
    8096:	0f 57 c0             	xorps  %xmm0,%xmm0
    8099:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    809e:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    80a5:	00 00 
    80a7:	89 4c 24 48          	mov    %ecx,0x48(%rsp)
    80ab:	48 8d 05 ee 71 00 00 	lea    0x71ee(%rip),%rax        # f2a0 <exec_in_fp0+0xc40>
    80b2:	48 8d 35 eb 71 00 00 	lea    0x71eb(%rip),%rsi        # f2a4 <exec_in_fp0+0xc44>
    80b9:	48 0f 44 f0          	cmove  %rax,%rsi
    80bd:	4c 89 ff             	mov    %r15,%rdi
    80c0:	e8 fb 0b 00 00       	call   8cc0 <tp_eat>
    80c5:	45 31 e4             	xor    %r12d,%r12d
    80c8:	85 c0                	test   %eax,%eax
    80ca:	0f 84 34 07 00 00    	je     8804 <tp_value+0x834>
    80d0:	48 8d 35 a3 72 00 00 	lea    0x72a3(%rip),%rsi        # f37a <exec_in_fp0+0xd1a>
    80d7:	48 8d 15 d0 72 00 00 	lea    0x72d0(%rip),%rdx        # f3ae <exec_in_fp0+0xd4e>
    80de:	48 8d 0d 7b 0e 00 00 	lea    0xe7b(%rip),%rcx        # 8f60 <tp_kv_item>
    80e5:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
    80ea:	4c 89 ff             	mov    %r15,%rdi
    80ed:	e8 2e 0c 00 00       	call   8d20 <tp_list_of>
    80f2:	85 c0                	test   %eax,%eax
    80f4:	0f 84 a1 03 00 00    	je     849b <tp_value+0x4cb>
    80fa:	48 83 7c 24 38 00    	cmpq   $0x0,0x38(%rsp)
    8100:	0f 84 2b 05 00 00    	je     8631 <tp_value+0x661>
    8106:	48 8d 05 23 dd 01 00 	lea    0x1dd23(%rip),%rax        # 25e30 <fwp_empty_map>
    810d:	31 db                	xor    %ebx,%ebx
    810f:	90                   	nop
    8110:	48 8b 4c 24 30       	mov    0x30(%rsp),%rcx
    8115:	48 8b 3c d9          	mov    (%rcx,%rbx,8),%rdi
    8119:	48 8b 74 d9 08       	mov    0x8(%rcx,%rbx,8),%rsi
    811e:	49 8b 4e 38          	mov    0x38(%r14),%rcx
    8122:	48 89 c2             	mov    %rax,%rdx
    8125:	e8 d6 0e 00 00       	call   9000 <fwp_p_map_insert>
    812a:	48 83 c3 02          	add    $0x2,%rbx
    812e:	48 3b 5c 24 38       	cmp    0x38(%rsp),%rbx
    8133:	72 db                	jb     8110 <tp_value+0x140>
    8135:	e9 fe 04 00 00       	jmp    8638 <tp_value+0x668>
    813a:	0f 57 c0             	xorps  %xmm0,%xmm0
    813d:	0f 11 44 24 38       	movups %xmm0,0x38(%rsp)
    8142:	0f 11 44 24 28       	movups %xmm0,0x28(%rsp)
    8147:	48 c7 44 24 48 00 00 	movq   $0x0,0x48(%rsp)
    814e:	00 00 
    8150:	49 8b 4e 38          	mov    0x38(%r14),%rcx
    8154:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
    8159:	83 f8 11             	cmp    $0x11,%eax
    815c:	75 17                	jne    8175 <tp_value+0x1a5>
    815e:	48 8d 35 35 71 00 00 	lea    0x7135(%rip),%rsi        # f29a <exec_in_fp0+0xc3a>
    8165:	4c 89 ff             	mov    %r15,%rdi
    8168:	e8 53 0b 00 00       	call   8cc0 <tp_eat>
    816d:	85 c0                	test   %eax,%eax
    816f:	0f 84 8c 06 00 00    	je     8801 <tp_value+0x831>
    8175:	48 8d 35 ea 71 00 00 	lea    0x71ea(%rip),%rsi        # f366 <exec_in_fp0+0xd06>
    817c:	48 8d 15 66 65 00 00 	lea    0x6566(%rip),%rdx        # e6e9 <exec_in_fp0+0x89>
    8183:	48 8d 0d e6 0c 00 00 	lea    0xce6(%rip),%rcx        # 8e70 <tp_elem_item>
    818a:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
    818f:	4c 89 ff             	mov    %r15,%rdi
    8192:	e8 89 0b 00 00       	call   8d20 <tp_list_of>
    8197:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    819c:	85 c0                	test   %eax,%eax
    819e:	0f 84 06 03 00 00    	je     84aa <tp_value+0x4da>
    81a4:	48 8b 74 24 38       	mov    0x38(%rsp),%rsi
    81a9:	e8 42 f5 ff ff       	call   76f0 <fwp_list_from>
    81ae:	49 89 c7             	mov    %rax,%r15
    81b1:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    81b6:	e8 55 d6 ff ff       	call   5810 <fwp_mem_free>
    81bb:	41 83 3e 11          	cmpl   $0x11,(%r14)
    81bf:	75 0b                	jne    81cc <tp_value+0x1fc>
    81c1:	4c 89 ff             	mov    %r15,%rdi
    81c4:	e8 e7 0c 00 00       	call   8eb0 <fwp_p_array_from_list>
    81c9:	49 89 c7             	mov    %rax,%r15
    81cc:	4c 89 7d 00          	mov    %r15,0x0(%rbp)
    81d0:	e9 5a fe ff ff       	jmp    802f <tp_value+0x5f>
    81d5:	4c 89 ff             	mov    %r15,%rdi
    81d8:	4c 89 f6             	mov    %r14,%rsi
    81db:	48 89 ea             	mov    %rbp,%rdx
    81de:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    81e5:	5b                   	pop    %rbx
    81e6:	41 5c                	pop    %r12
    81e8:	41 5d                	pop    %r13
    81ea:	41 5e                	pop    %r14
    81ec:	41 5f                	pop    %r15
    81ee:	5d                   	pop    %rbp
    81ef:	e9 bc 07 00 00       	jmp    89b0 <tp_float>
    81f4:	45 85 ed             	test   %r13d,%r13d
    81f7:	0f 85 f7 fd ff ff    	jne    7ff4 <tp_value+0x24>
    81fd:	4c 89 ff             	mov    %r15,%rdi
    8200:	48 89 ee             	mov    %rbp,%rsi
    8203:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    820a:	5b                   	pop    %rbx
    820b:	41 5c                	pop    %r12
    820d:	41 5d                	pop    %r13
    820f:	41 5e                	pop    %r14
    8211:	41 5f                	pop    %r15
    8213:	5d                   	pop    %rbp
    8214:	e9 57 08 00 00       	jmp    8a70 <tp_quoted>
    8219:	0f 57 c0             	xorps  %xmm0,%xmm0
    821c:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    8221:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    8226:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    822b:	48 8d 35 5c 70 00 00 	lea    0x705c(%rip),%rsi        # f28e <exec_in_fp0+0xc2e>
    8232:	4c 89 ff             	mov    %r15,%rdi
    8235:	e8 86 0a 00 00       	call   8cc0 <tp_eat>
    823a:	45 31 e4             	xor    %r12d,%r12d
    823d:	85 c0                	test   %eax,%eax
    823f:	0f 84 6f 02 00 00    	je     84b4 <tp_value+0x4e4>
    8245:	48 8d 35 1a 71 00 00 	lea    0x711a(%rip),%rsi        # f366 <exec_in_fp0+0xd06>
    824c:	48 8d 15 96 64 00 00 	lea    0x6496(%rip),%rdx        # e6e9 <exec_in_fp0+0x89>
    8253:	48 8d 0d 46 0b 00 00 	lea    0xb46(%rip),%rcx        # 8da0 <tp_byte_item>
    825a:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
    825f:	4c 89 ff             	mov    %r15,%rdi
    8262:	e8 b9 0a 00 00       	call   8d20 <tp_list_of>
    8267:	85 c0                	test   %eax,%eax
    8269:	0f 84 2c 02 00 00    	je     849b <tp_value+0x4cb>
    826f:	0f 57 c0             	xorps  %xmm0,%xmm0
    8272:	0f 29 84 24 20 01 00 	movaps %xmm0,0x120(%rsp)
    8279:	00 
    827a:	48 c7 84 24 30 01 00 	movq   $0x0,0x130(%rsp)
    8281:	00 00 00 00 00 
    8286:	48 83 7c 24 38 00    	cmpq   $0x0,0x38(%rsp)
    828c:	74 2d                	je     82bb <tp_value+0x2eb>
    828e:	31 db                	xor    %ebx,%ebx
    8290:	4c 8d b4 24 20 01 00 	lea    0x120(%rsp),%r14
    8297:	00 
    8298:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    829f:	00 
    82a0:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    82a5:	0f be 34 d8          	movsbl (%rax,%rbx,8),%esi
    82a9:	4c 89 f7             	mov    %r14,%rdi
    82ac:	e8 9f f6 ff ff       	call   7950 <buf_putc>
    82b1:	48 ff c3             	inc    %rbx
    82b4:	48 3b 5c 24 38       	cmp    0x38(%rsp),%rbx
    82b9:	72 e5                	jb     82a0 <tp_value+0x2d0>
    82bb:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    82c0:	e8 4b d5 ff ff       	call   5810 <fwp_mem_free>
    82c5:	48 8d bc 24 20 01 00 	lea    0x120(%rsp),%rdi
    82cc:	00 
    82cd:	e8 0e f7 ff ff       	call   79e0 <buf_to_str>
    82d2:	48 89 45 00          	mov    %rax,0x0(%rbp)
    82d6:	e9 54 fd ff ff       	jmp    802f <tp_value+0x5f>
    82db:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    82e0:	ba 00 01 00 00       	mov    $0x100,%edx
    82e5:	4c 89 ff             	mov    %r15,%rdi
    82e8:	e8 f3 0a 00 00       	call   8de0 <tp_token>
    82ed:	45 31 e4             	xor    %r12d,%r12d
    82f0:	48 83 f8 02          	cmp    $0x2,%rax
    82f4:	0f 82 0a 05 00 00    	jb     8804 <tp_value+0x834>
    82fa:	80 7c 24 20 30       	cmpb   $0x30,0x20(%rsp)
    82ff:	0f 85 ff 04 00 00    	jne    8804 <tp_value+0x834>
    8305:	80 7c 24 21 74       	cmpb   $0x74,0x21(%rsp)
    830a:	0f 85 f4 04 00 00    	jne    8804 <tp_value+0x834>
    8310:	48 8d 48 fe          	lea    -0x2(%rax),%rcx
    8314:	49 63 56 48          	movslq 0x48(%r14),%rdx
    8318:	48 39 d1             	cmp    %rdx,%rcx
    831b:	0f 87 e3 04 00 00    	ja     8804 <tp_value+0x834>
    8321:	48 83 f8 03          	cmp    $0x3,%rax
    8325:	0f 82 21 05 00 00    	jb     884c <tp_value+0x87c>
    832b:	ba 02 00 00 00       	mov    $0x2,%edx
    8330:	31 c9                	xor    %ecx,%ecx
    8332:	e9 3d 01 00 00       	jmp    8474 <tp_value+0x4a4>
    8337:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    833c:	ba 10 00 00 00       	mov    $0x10,%edx
    8341:	4c 89 ff             	mov    %r15,%rdi
    8344:	e8 97 0a 00 00       	call   8de0 <tp_token>
    8349:	8b 44 24 20          	mov    0x20(%rsp),%eax
    834d:	89 c1                	mov    %eax,%ecx
    834f:	81 f1 2b 31 00 00    	xor    $0x312b,%ecx
    8355:	0f b6 54 24 22       	movzbl 0x22(%rsp),%edx
    835a:	66 09 ca             	or     %cx,%dx
    835d:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    8363:	74 2d                	je     8392 <tp_value+0x3c2>
    8365:	66 83 f8 31          	cmp    $0x31,%ax
    8369:	74 27                	je     8392 <tp_value+0x3c2>
    836b:	45 31 e4             	xor    %r12d,%r12d
    836e:	66 83 f8 30          	cmp    $0x30,%ax
    8372:	74 1e                	je     8392 <tp_value+0x3c2>
    8374:	b8 2d 31 00 00       	mov    $0x312d,%eax
    8379:	33 44 24 20          	xor    0x20(%rsp),%eax
    837d:	0f b6 4c 24 22       	movzbl 0x22(%rsp),%ecx
    8382:	66 09 c1             	or     %ax,%cx
    8385:	0f 85 79 04 00 00    	jne    8804 <tp_value+0x834>
    838b:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    8392:	4c 89 65 00          	mov    %r12,0x0(%rbp)
    8396:	e9 94 fc ff ff       	jmp    802f <tp_value+0x5f>
    839b:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    839f:	48 85 ff             	test   %rdi,%rdi
    83a2:	0f 84 18 01 00 00    	je     84c0 <tp_value+0x4f0>
    83a8:	48 8d 35 f9 6e 00 00 	lea    0x6ef9(%rip),%rsi        # f2a8 <exec_in_fp0+0xc48>
    83af:	e8 0c 9f ff ff       	call   22c0 <strcmp@plt>
    83b4:	85 c0                	test   %eax,%eax
    83b6:	0f 84 23 03 00 00    	je     86df <tp_value+0x70f>
    83bc:	4c 89 ff             	mov    %r15,%rdi
    83bf:	e8 3c 05 00 00       	call   8900 <tp_ws>
    83c4:	4d 8b 6e 08          	mov    0x8(%r14),%r13
    83c8:	4c 89 ef             	mov    %r13,%rdi
    83cb:	e8 90 9d ff ff       	call   2160 <strlen@plt>
    83d0:	49 89 c4             	mov    %rax,%r12
    83d3:	49 8b 47 08          	mov    0x8(%r15),%rax
    83d7:	49 8b 5f 10          	mov    0x10(%r15),%rbx
    83db:	48 29 d8             	sub    %rbx,%rax
    83de:	4c 39 e0             	cmp    %r12,%rax
    83e1:	0f 82 c4 01 00 00    	jb     85ab <tp_value+0x5db>
    83e7:	49 8b 3f             	mov    (%r15),%rdi
    83ea:	48 01 df             	add    %rbx,%rdi
    83ed:	4c 89 ee             	mov    %r13,%rsi
    83f0:	4c 89 e2             	mov    %r12,%rdx
    83f3:	e8 68 9f ff ff       	call   2360 <bcmp@plt>
    83f8:	85 c0                	test   %eax,%eax
    83fa:	0f 85 ab 01 00 00    	jne    85ab <tp_value+0x5db>
    8400:	4c 01 e3             	add    %r12,%rbx
    8403:	49 89 5f 10          	mov    %rbx,0x10(%r15)
    8407:	e9 9f 01 00 00       	jmp    85ab <tp_value+0x5db>
    840c:	48 89 2c 24          	mov    %rbp,(%rsp)
    8410:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8415:	4c 89 ff             	mov    %r15,%rdi
    8418:	e8 d3 0e 00 00       	call   92f0 <tp_ident>
    841d:	41 8b 5e 10          	mov    0x10(%r14),%ebx
    8421:	85 db                	test   %ebx,%ebx
    8423:	4c 89 74 24 08       	mov    %r14,0x8(%rsp)
    8428:	0f 8e 9c 01 00 00    	jle    85ca <tp_value+0x5fa>
    842e:	4d 8b 66 18          	mov    0x18(%r14),%r12
    8432:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    8437:	45 31 f6             	xor    %r14d,%r14d
    843a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8440:	4b 8b 3c f4          	mov    (%r12,%r14,8),%rdi
    8444:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8449:	e8 72 9e ff ff       	call   22c0 <strcmp@plt>
    844e:	85 c0                	test   %eax,%eax
    8450:	41 0f 44 ee          	cmove  %r14d,%ebp
    8454:	49 ff c6             	inc    %r14
    8457:	4c 39 f3             	cmp    %r14,%rbx
    845a:	75 e4                	jne    8440 <tp_value+0x470>
    845c:	e9 6e 01 00 00       	jmp    85cf <tp_value+0x5ff>
    8461:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    8465:	48 ff c9             	dec    %rcx
    8468:	48 ff c2             	inc    %rdx
    846b:	48 39 d0             	cmp    %rdx,%rax
    846e:	0f 84 da 03 00 00    	je     884e <tp_value+0x87e>
    8474:	0f b6 74 14 20       	movzbl 0x20(%rsp,%rdx,1),%esi
    8479:	83 fe 30             	cmp    $0x30,%esi
    847c:	74 17                	je     8495 <tp_value+0x4c5>
    847e:	83 fe 2d             	cmp    $0x2d,%esi
    8481:	74 de                	je     8461 <tp_value+0x491>
    8483:	83 fe 2b             	cmp    $0x2b,%esi
    8486:	0f 85 75 03 00 00    	jne    8801 <tp_value+0x831>
    848c:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    8490:	48 ff c1             	inc    %rcx
    8493:	eb d3                	jmp    8468 <tp_value+0x498>
    8495:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    8499:	eb cd                	jmp    8468 <tp_value+0x498>
    849b:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    84a0:	e8 6b d3 ff ff       	call   5810 <fwp_mem_free>
    84a5:	e9 5a 03 00 00       	jmp    8804 <tp_value+0x834>
    84aa:	e8 61 d3 ff ff       	call   5810 <fwp_mem_free>
    84af:	e9 4d 03 00 00       	jmp    8801 <tp_value+0x831>
    84b4:	31 ff                	xor    %edi,%edi
    84b6:	e8 55 d3 ff ff       	call   5810 <fwp_mem_free>
    84bb:	e9 44 03 00 00       	jmp    8804 <tp_value+0x834>
    84c0:	49 63 7e 10          	movslq 0x10(%r14),%rdi
    84c4:	48 85 ff             	test   %rdi,%rdi
    84c7:	0f 84 4c 03 00 00    	je     8819 <tp_value+0x849>
    84cd:	41 83 7e 48 00       	cmpl   $0x0,0x48(%r14)
    84d2:	0f 84 d3 00 00 00    	je     85ab <tp_value+0x5db>
    84d8:	48 c1 e7 03          	shl    $0x3,%rdi
    84dc:	e8 3f d2 ff ff       	call   5720 <fwp_alloc>
    84e1:	48 89 c3             	mov    %rax,%rbx
    84e4:	48 8d 35 cd 6d 00 00 	lea    0x6dcd(%rip),%rsi        # f2b8 <exec_in_fp0+0xc58>
    84eb:	4c 89 ff             	mov    %r15,%rdi
    84ee:	e8 cd 07 00 00       	call   8cc0 <tp_eat>
    84f3:	85 c0                	test   %eax,%eax
    84f5:	0f 84 09 03 00 00    	je     8804 <tp_value+0x834>
    84fb:	48 89 2c 24          	mov    %rbp,(%rsp)
    84ff:	41 83 7e 10 00       	cmpl   $0x0,0x10(%r14)
    8504:	7e 77                	jle    857d <tp_value+0x5ad>
    8506:	49 8b 46 20          	mov    0x20(%r14),%rax
    850a:	48 8b 30             	mov    (%rax),%rsi
    850d:	4c 89 ff             	mov    %r15,%rdi
    8510:	31 d2                	xor    %edx,%edx
    8512:	48 89 d9             	mov    %rbx,%rcx
    8515:	e8 b6 fa ff ff       	call   7fd0 <tp_value>
    851a:	85 c0                	test   %eax,%eax
    851c:	0f 84 df 02 00 00    	je     8801 <tp_value+0x831>
    8522:	41 83 7e 10 02       	cmpl   $0x2,0x10(%r14)
    8527:	7c 54                	jl     857d <tp_value+0x5ad>
    8529:	48 89 dd             	mov    %rbx,%rbp
    852c:	48 83 c5 08          	add    $0x8,%rbp
    8530:	41 bd 01 00 00 00    	mov    $0x1,%r13d
    8536:	4c 89 ff             	mov    %r15,%rdi
    8539:	48 8d 35 7a 6d 00 00 	lea    0x6d7a(%rip),%rsi        # f2ba <exec_in_fp0+0xc5a>
    8540:	e8 7b 07 00 00       	call   8cc0 <tp_eat>
    8545:	85 c0                	test   %eax,%eax
    8547:	0f 84 b4 02 00 00    	je     8801 <tp_value+0x831>
    854d:	49 8b 46 20          	mov    0x20(%r14),%rax
    8551:	4a 8b 34 e8          	mov    (%rax,%r13,8),%rsi
    8555:	45 31 e4             	xor    %r12d,%r12d
    8558:	4c 89 ff             	mov    %r15,%rdi
    855b:	31 d2                	xor    %edx,%edx
    855d:	48 89 e9             	mov    %rbp,%rcx
    8560:	e8 6b fa ff ff       	call   7fd0 <tp_value>
    8565:	85 c0                	test   %eax,%eax
    8567:	0f 84 97 02 00 00    	je     8804 <tp_value+0x834>
    856d:	49 ff c5             	inc    %r13
    8570:	49 63 46 10          	movslq 0x10(%r14),%rax
    8574:	48 83 c5 08          	add    $0x8,%rbp
    8578:	49 39 c5             	cmp    %rax,%r13
    857b:	7c b9                	jl     8536 <tp_value+0x566>
    857d:	48 8d 35 f9 6d 00 00 	lea    0x6df9(%rip),%rsi        # f37d <exec_in_fp0+0xd1d>
    8584:	4c 89 ff             	mov    %r15,%rdi
    8587:	e8 34 07 00 00       	call   8cc0 <tp_eat>
    858c:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    8592:	85 c0                	test   %eax,%eax
    8594:	0f 84 6a 02 00 00    	je     8804 <tp_value+0x834>
    859a:	41 8b 7e 10          	mov    0x10(%r14),%edi
    859e:	48 89 de             	mov    %rbx,%rsi
    85a1:	e8 ba aa ff ff       	call   3060 <fwp_record>
    85a6:	e9 28 01 00 00       	jmp    86d3 <tp_value+0x703>
    85ab:	4c 89 ff             	mov    %r15,%rdi
    85ae:	4c 89 f6             	mov    %r14,%rsi
    85b1:	48 89 ea             	mov    %rbp,%rdx
    85b4:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    85bb:	5b                   	pop    %rbx
    85bc:	41 5c                	pop    %r12
    85be:	41 5d                	pop    %r13
    85c0:	41 5e                	pop    %r14
    85c2:	41 5f                	pop    %r15
    85c4:	5d                   	pop    %rbp
    85c5:	e9 56 0b 00 00       	jmp    9120 <tp_record_body>
    85ca:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    85cf:	45 85 ed             	test   %r13d,%r13d
    85d2:	74 7a                	je     864e <tp_value+0x67e>
    85d4:	85 ed                	test   %ebp,%ebp
    85d6:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    85db:	79 76                	jns    8653 <tp_value+0x683>
    85dd:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    85e1:	45 31 e4             	xor    %r12d,%r12d
    85e4:	48 85 ff             	test   %rdi,%rdi
    85e7:	0f 84 17 02 00 00    	je     8804 <tp_value+0x834>
    85ed:	48 8d 35 92 6c 00 00 	lea    0x6c92(%rip),%rsi        # f286 <exec_in_fp0+0xc26>
    85f4:	e8 c7 9c ff ff       	call   22c0 <strcmp@plt>
    85f9:	85 c0                	test   %eax,%eax
    85fb:	0f 85 03 02 00 00    	jne    8804 <tp_value+0x834>
    8601:	8b 44 24 20          	mov    0x20(%rsp),%eax
    8605:	89 c1                	mov    %eax,%ecx
    8607:	81 f1 74 72 75 65    	xor    $0x65757274,%ecx
    860d:	0f b6 54 24 24       	movzbl 0x24(%rsp),%edx
    8612:	09 ca                	or     %ecx,%edx
    8614:	b9 01 00 00 00       	mov    $0x1,%ecx
    8619:	0f 44 e9             	cmove  %ecx,%ebp
    861c:	35 66 61 6c 73       	xor    $0x736c6166,%eax
    8621:	0f b7 4c 24 24       	movzwl 0x24(%rsp),%ecx
    8626:	83 f1 65             	xor    $0x65,%ecx
    8629:	09 c1                	or     %eax,%ecx
    862b:	75 26                	jne    8653 <tp_value+0x683>
    862d:	31 ed                	xor    %ebp,%ebp
    862f:	eb 2a                	jmp    865b <tp_value+0x68b>
    8631:	48 8d 05 f8 d7 01 00 	lea    0x1d7f8(%rip),%rax        # 25e30 <fwp_empty_map>
    8638:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    863d:	48 89 c3             	mov    %rax,%rbx
    8640:	e8 cb d1 ff ff       	call   5810 <fwp_mem_free>
    8645:	48 89 5d 00          	mov    %rbx,0x0(%rbp)
    8649:	e9 e1 f9 ff ff       	jmp    802f <tp_value+0x5f>
    864e:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    8653:	85 ed                	test   %ebp,%ebp
    8655:	0f 88 a6 01 00 00    	js     8801 <tp_value+0x831>
    865b:	48 8b 43 28          	mov    0x28(%rbx),%rax
    865f:	41 89 ed             	mov    %ebp,%r13d
    8662:	4a 63 1c a8          	movslq (%rax,%r13,4),%rbx
    8666:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    866d:	00 
    866e:	e8 ad d0 ff ff       	call   5720 <fwp_alloc>
    8673:	48 89 c5             	mov    %rax,%rbp
    8676:	89 d8                	mov    %ebx,%eax
    8678:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    867d:	48 85 db             	test   %rbx,%rbx
    8680:	7e 41                	jle    86c3 <tp_value+0x6f3>
    8682:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    8687:	48 8d 1c c5 00 00 00 	lea    0x0(,%rax,8),%rbx
    868e:	00 
    868f:	45 31 e4             	xor    %r12d,%r12d
    8692:	45 31 f6             	xor    %r14d,%r14d
    8695:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    869a:	48 8b 40 30          	mov    0x30(%rax),%rax
    869e:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    86a2:	4a 8b 34 30          	mov    (%rax,%r14,1),%rsi
    86a6:	49 8d 14 2e          	lea    (%r14,%rbp,1),%rdx
    86aa:	4c 89 ff             	mov    %r15,%rdi
    86ad:	e8 fe 0c 00 00       	call   93b0 <tp_atom>
    86b2:	85 c0                	test   %eax,%eax
    86b4:	0f 84 4a 01 00 00    	je     8804 <tp_value+0x834>
    86ba:	49 83 c6 08          	add    $0x8,%r14
    86be:	4c 39 f3             	cmp    %r14,%rbx
    86c1:	75 d2                	jne    8695 <tp_value+0x6c5>
    86c3:	44 89 ef             	mov    %r13d,%edi
    86c6:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    86cb:	48 89 ea             	mov    %rbp,%rdx
    86ce:	e8 9d a9 ff ff       	call   3070 <fwp_data>
    86d3:	48 8b 0c 24          	mov    (%rsp),%rcx
    86d7:	48 89 01             	mov    %rax,(%rcx)
    86da:	e9 50 f9 ff ff       	jmp    802f <tp_value+0x5f>
    86df:	48 89 2c 24          	mov    %rbp,(%rsp)
    86e3:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    86e8:	ba 80 00 00 00       	mov    $0x80,%edx
    86ed:	4c 89 ff             	mov    %r15,%rdi
    86f0:	48 89 f3             	mov    %rsi,%rbx
    86f3:	e8 e8 06 00 00       	call   8de0 <tp_token>
    86f8:	49 89 c7             	mov    %rax,%r15
    86fb:	4c 8d 24 04          	lea    (%rsp,%rax,1),%r12
    86ff:	49 83 c4 20          	add    $0x20,%r12
    8703:	41 be 08 00 00 00    	mov    $0x8,%r14d
    8709:	eb 0e                	jmp    8719 <tp_value+0x749>
    870b:	49 83 c6 10          	add    $0x10,%r14
    870f:	49 83 fe 68          	cmp    $0x68,%r14
    8713:	0f 84 e8 00 00 00    	je     8801 <tp_value+0x831>
    8719:	48 8d 05 50 b5 00 00 	lea    0xb550(%rip),%rax        # 13c70 <tp_value.units>
    8720:	49 8b 6c 06 f8       	mov    -0x8(%r14,%rax,1),%rbp
    8725:	48 89 ef             	mov    %rbp,%rdi
    8728:	e8 33 9a ff ff       	call   2160 <strlen@plt>
    872d:	4d 89 fd             	mov    %r15,%r13
    8730:	49 29 c5             	sub    %rax,%r13
    8733:	76 d6                	jbe    870b <tp_value+0x73b>
    8735:	4c 89 e7             	mov    %r12,%rdi
    8738:	48 29 c7             	sub    %rax,%rdi
    873b:	48 89 ee             	mov    %rbp,%rsi
    873e:	e8 7d 9b ff ff       	call   22c0 <strcmp@plt>
    8743:	85 c0                	test   %eax,%eax
    8745:	75 c4                	jne    870b <tp_value+0x73b>
    8747:	48 8d ac 24 20 01 00 	lea    0x120(%rsp),%rbp
    874e:	00 
    874f:	48 89 ef             	mov    %rbp,%rdi
    8752:	48 89 de             	mov    %rbx,%rsi
    8755:	4c 89 ea             	mov    %r13,%rdx
    8758:	e8 c3 9b ff ff       	call   2320 <memcpy@plt>
    875d:	42 c6 84 2c 20 01 00 	movb   $0x0,0x120(%rsp,%r13,1)
    8764:	00 00 
    8766:	48 89 ef             	mov    %rbp,%rdi
    8769:	4c 89 ee             	mov    %r13,%rsi
    876c:	e8 6f 09 00 00       	call   90e0 <fwp_valid_int>
    8771:	85 c0                	test   %eax,%eax
    8773:	74 96                	je     870b <tp_value+0x73b>
    8775:	0f b6 b4 24 20 01 00 	movzbl 0x120(%rsp),%esi
    877c:	00 
    877d:	8d 4e d5             	lea    -0x2b(%rsi),%ecx
    8780:	31 c0                	xor    %eax,%eax
    8782:	f6 c1 fd             	test   $0xfd,%cl
    8785:	0f 94 c0             	sete   %al
    8788:	44 0f b6 94 04 20 01 	movzbl 0x120(%rsp,%rax,1),%r10d
    878f:	00 00 
    8791:	45 31 e4             	xor    %r12d,%r12d
    8794:	45 84 d2             	test   %r10b,%r10b
    8797:	0f 84 ba 00 00 00    	je     8857 <tp_value+0x887>
    879d:	48 8d 8c 24 20 01 00 	lea    0x120(%rsp),%rcx
    87a4:	00 
    87a5:	48 01 c1             	add    %rax,%rcx
    87a8:	48 ff c1             	inc    %rcx
    87ab:	31 c0                	xor    %eax,%eax
    87ad:	bf 0a 00 00 00       	mov    $0xa,%edi
    87b2:	49 b9 00 00 00 00 00 	movabs $0x8000000000000000,%r9
    87b9:	00 00 80 
    87bc:	45 31 c0             	xor    %r8d,%r8d
    87bf:	48 8b 1c 24          	mov    (%rsp),%rbx
    87c3:	48 f7 e7             	mul    %rdi
    87c6:	4f 8d 04 80          	lea    (%r8,%r8,4),%r8
    87ca:	4a 8d 14 42          	lea    (%rdx,%r8,2),%rdx
    87ce:	45 0f be c2          	movsbl %r10b,%r8d
    87d2:	41 83 c0 d0          	add    $0xffffffd0,%r8d
    87d6:	4d 63 d0             	movslq %r8d,%r10
    87d9:	4d 89 d0             	mov    %r10,%r8
    87dc:	49 c1 f8 3f          	sar    $0x3f,%r8
    87e0:	4c 01 d0             	add    %r10,%rax
    87e3:	49 11 d0             	adc    %rdx,%r8
    87e6:	49 39 c1             	cmp    %rax,%r9
    87e9:	ba 00 00 00 00       	mov    $0x0,%edx
    87ee:	4c 19 c2             	sbb    %r8,%rdx
    87f1:	7c 0e                	jl     8801 <tp_value+0x831>
    87f3:	44 0f b6 11          	movzbl (%rcx),%r10d
    87f7:	48 ff c1             	inc    %rcx
    87fa:	45 84 d2             	test   %r10b,%r10b
    87fd:	75 c4                	jne    87c3 <tp_value+0x7f3>
    87ff:	eb 5f                	jmp    8860 <tp_value+0x890>
    8801:	45 31 e4             	xor    %r12d,%r12d
    8804:	44 89 e0             	mov    %r12d,%eax
    8807:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    880e:	5b                   	pop    %rbx
    880f:	41 5c                	pop    %r12
    8811:	41 5d                	pop    %r13
    8813:	41 5e                	pop    %r14
    8815:	41 5f                	pop    %r15
    8817:	5d                   	pop    %rbp
    8818:	c3                   	ret
    8819:	48 8d 35 98 6a 00 00 	lea    0x6a98(%rip),%rsi        # f2b8 <exec_in_fp0+0xc58>
    8820:	4c 89 ff             	mov    %r15,%rdi
    8823:	e8 98 04 00 00       	call   8cc0 <tp_eat>
    8828:	85 c0                	test   %eax,%eax
    882a:	74 d8                	je     8804 <tp_value+0x834>
    882c:	48 8d 35 4a 6b 00 00 	lea    0x6b4a(%rip),%rsi        # f37d <exec_in_fp0+0xd1d>
    8833:	4c 89 ff             	mov    %r15,%rdi
    8836:	e8 85 04 00 00       	call   8cc0 <tp_eat>
    883b:	85 c0                	test   %eax,%eax
    883d:	74 c5                	je     8804 <tp_value+0x834>
    883f:	48 c7 45 00 00 00 00 	movq   $0x0,0x0(%rbp)
    8846:	00 
    8847:	e9 e3 f7 ff ff       	jmp    802f <tp_value+0x5f>
    884c:	31 c9                	xor    %ecx,%ecx
    884e:	48 89 4d 00          	mov    %rcx,0x0(%rbp)
    8852:	e9 d8 f7 ff ff       	jmp    802f <tp_value+0x5f>
    8857:	31 c0                	xor    %eax,%eax
    8859:	45 31 c0             	xor    %r8d,%r8d
    885c:	48 8b 1c 24          	mov    (%rsp),%rbx
    8860:	48 89 c1             	mov    %rax,%rcx
    8863:	48 f7 d9             	neg    %rcx
    8866:	bf 00 00 00 00       	mov    $0x0,%edi
    886b:	4c 19 c7             	sbb    %r8,%rdi
    886e:	40 80 fe 2d          	cmp    $0x2d,%sil
    8872:	49 0f 45 f8          	cmovne %r8,%rdi
    8876:	48 0f 45 c8          	cmovne %rax,%rcx
    887a:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    8881:	ff ff 7f 
    8884:	48 39 c8             	cmp    %rcx,%rax
    8887:	b8 00 00 00 00       	mov    $0x0,%eax
    888c:	48 19 f8             	sbb    %rdi,%rax
    888f:	0f 8c 6f ff ff ff    	jl     8804 <tp_value+0x834>
    8895:	48 8d 05 d4 b3 00 00 	lea    0xb3d4(%rip),%rax        # 13c70 <tp_value.units>
    889c:	49 8b 34 06          	mov    (%r14,%rax,1),%rsi
    88a0:	48 89 c8             	mov    %rcx,%rax
    88a3:	48 f7 e6             	mul    %rsi
    88a6:	48 0f af fe          	imul   %rsi,%rdi
    88aa:	48 c1 fe 3f          	sar    $0x3f,%rsi
    88ae:	48 0f af f1          	imul   %rcx,%rsi
    88b2:	48 01 d6             	add    %rdx,%rsi
    88b5:	48 01 f7             	add    %rsi,%rdi
    88b8:	48 b9 00 00 00 00 00 	movabs $0x8000000000000000,%rcx
    88bf:	00 00 80 
    88c2:	48 01 c1             	add    %rax,%rcx
    88c5:	48 83 d7 ff          	adc    $0xffffffffffffffff,%rdi
    88c9:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
    88cd:	0f 85 31 ff ff ff    	jne    8804 <tp_value+0x834>
    88d3:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    88d8:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    88de:	48 8d 74 24 18       	lea    0x18(%rsp),%rsi
    88e3:	bf 01 00 00 00       	mov    $0x1,%edi
    88e8:	e8 73 a7 ff ff       	call   3060 <fwp_record>
    88ed:	48 89 03             	mov    %rax,(%rbx)
    88f0:	e9 0f ff ff ff       	jmp    8804 <tp_value+0x834>
    88f5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    88fc:	00 00 00 00 

0000000000008900 <tp_ws>:
    8900:	48 8b 47 08          	mov    0x8(%rdi),%rax
    8904:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    8908:	48 39 c1             	cmp    %rax,%rcx
    890b:	73 39                	jae    8946 <tp_ws+0x46>
    890d:	48 8b 17             	mov    (%rdi),%rdx
    8910:	48 f7 d8             	neg    %rax
    8913:	48 ff c1             	inc    %rcx
    8916:	48 be 00 26 00 00 01 	movabs $0x100002600,%rsi
    891d:	00 00 00 
    8920:	44 0f b6 44 0a ff    	movzbl -0x1(%rdx,%rcx,1),%r8d
    8926:	49 83 f8 20          	cmp    $0x20,%r8
    892a:	77 1a                	ja     8946 <tp_ws+0x46>
    892c:	4c 0f a3 c6          	bt     %r8,%rsi
    8930:	73 14                	jae    8946 <tp_ws+0x46>
    8932:	48 89 4f 10          	mov    %rcx,0x10(%rdi)
    8936:	4c 8d 04 08          	lea    (%rax,%rcx,1),%r8
    893a:	49 ff c0             	inc    %r8
    893d:	48 ff c1             	inc    %rcx
    8940:	49 83 f8 01          	cmp    $0x1,%r8
    8944:	75 da                	jne    8920 <tp_ws+0x20>
    8946:	c3                   	ret
    8947:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    894e:	00 00 

0000000000008950 <tp_int>:
    8950:	55                   	push   %rbp
    8951:	41 56                	push   %r14
    8953:	53                   	push   %rbx
    8954:	48 81 ec 80 00 00 00 	sub    $0x80,%rsp
    895b:	48 89 d3             	mov    %rdx,%rbx
    895e:	49 89 f6             	mov    %rsi,%r14
    8961:	48 89 e6             	mov    %rsp,%rsi
    8964:	ba 80 00 00 00       	mov    $0x80,%edx
    8969:	e8 72 04 00 00       	call   8de0 <tp_token>
    896e:	31 ed                	xor    %ebp,%ebp
    8970:	48 83 f8 7f          	cmp    $0x7f,%rax
    8974:	77 28                	ja     899e <tp_int+0x4e>
    8976:	48 89 e7             	mov    %rsp,%rdi
    8979:	e8 d2 0a 00 00       	call   9450 <fwp_cstr>
    897e:	41 8b 36             	mov    (%r14),%esi
    8981:	41 8b 56 48          	mov    0x48(%r14),%edx
    8985:	48 89 c7             	mov    %rax,%rdi
    8988:	e8 e3 0a 00 00       	call   9470 <fwp_p_parse_int>
    898d:	48 85 c0             	test   %rax,%rax
    8990:	74 0c                	je     899e <tp_int+0x4e>
    8992:	48 8b 40 08          	mov    0x8(%rax),%rax
    8996:	48 89 03             	mov    %rax,(%rbx)
    8999:	bd 01 00 00 00       	mov    $0x1,%ebp
    899e:	89 e8                	mov    %ebp,%eax
    89a0:	48 81 c4 80 00 00 00 	add    $0x80,%rsp
    89a7:	5b                   	pop    %rbx
    89a8:	41 5e                	pop    %r14
    89aa:	5d                   	pop    %rbp
    89ab:	c3                   	ret
    89ac:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000089b0 <tp_float>:
    89b0:	41 56                	push   %r14
    89b2:	53                   	push   %rbx
    89b3:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    89ba:	48 89 d3             	mov    %rdx,%rbx
    89bd:	49 89 f6             	mov    %rsi,%r14
    89c0:	48 89 e6             	mov    %rsp,%rsi
    89c3:	ba 80 00 00 00       	mov    $0x80,%edx
    89c8:	e8 13 04 00 00       	call   8de0 <tp_token>
    89cd:	31 c9                	xor    %ecx,%ecx
    89cf:	48 83 f8 7f          	cmp    $0x7f,%rax
    89d3:	0f 87 84 00 00 00    	ja     8a5d <tp_float+0xad>
    89d9:	8b 0c 24             	mov    (%rsp),%ecx
    89dc:	81 f9 69 6e 66 00    	cmp    $0x666e69,%ecx
    89e2:	75 0a                	jne    89ee <tp_float+0x3e>
    89e4:	f2 0f 10 05 44 56 00 	movsd  0x5644(%rip),%xmm0        # e030 <_IO_stdin_used+0x30>
    89eb:	00 
    89ec:	eb 5f                	jmp    8a4d <tp_float+0x9d>
    89ee:	ba 2d 69 6e 66       	mov    $0x666e692d,%edx
    89f3:	33 14 24             	xor    (%rsp),%edx
    89f6:	0f b6 74 24 04       	movzbl 0x4(%rsp),%esi
    89fb:	09 d6                	or     %edx,%esi
    89fd:	74 12                	je     8a11 <tp_float+0x61>
    89ff:	81 f9 4e 61 4e 00    	cmp    $0x4e614e,%ecx
    8a05:	75 14                	jne    8a1b <tp_float+0x6b>
    8a07:	f2 0f 10 05 31 56 00 	movsd  0x5631(%rip),%xmm0        # e040 <_IO_stdin_used+0x40>
    8a0e:	00 
    8a0f:	eb 3c                	jmp    8a4d <tp_float+0x9d>
    8a11:	f2 0f 10 05 1f 56 00 	movsd  0x561f(%rip),%xmm0        # e038 <_IO_stdin_used+0x38>
    8a18:	00 
    8a19:	eb 32                	jmp    8a4d <tp_float+0x9d>
    8a1b:	48 89 e7             	mov    %rsp,%rdi
    8a1e:	48 89 c6             	mov    %rax,%rsi
    8a21:	e8 7a 0e 00 00       	call   98a0 <fwp_valid_float>
    8a26:	31 c9                	xor    %ecx,%ecx
    8a28:	85 c0                	test   %eax,%eax
    8a2a:	74 31                	je     8a5d <tp_float+0xad>
    8a2c:	41 83 3e 0a          	cmpl   $0xa,(%r14)
    8a30:	75 11                	jne    8a43 <tp_float+0x93>
    8a32:	48 89 e7             	mov    %rsp,%rdi
    8a35:	31 f6                	xor    %esi,%esi
    8a37:	e8 b4 97 ff ff       	call   21f0 <strtof@plt>
    8a3c:	e8 6f c5 ff ff       	call   4fb0 <fwp_from_f32>
    8a41:	eb 12                	jmp    8a55 <tp_float+0xa5>
    8a43:	48 89 e7             	mov    %rsp,%rdi
    8a46:	31 f6                	xor    %esi,%esi
    8a48:	e8 a3 96 ff ff       	call   20f0 <strtod@plt>
    8a4d:	41 8b 3e             	mov    (%r14),%edi
    8a50:	e8 3b 0f 00 00       	call   9990 <fwp_float_of>
    8a55:	48 89 03             	mov    %rax,(%rbx)
    8a58:	b9 01 00 00 00       	mov    $0x1,%ecx
    8a5d:	89 c8                	mov    %ecx,%eax
    8a5f:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
    8a66:	5b                   	pop    %rbx
    8a67:	41 5e                	pop    %r14
    8a69:	c3                   	ret
    8a6a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000008a70 <tp_quoted>:
    8a70:	55                   	push   %rbp
    8a71:	41 57                	push   %r15
    8a73:	41 56                	push   %r14
    8a75:	41 55                	push   %r13
    8a77:	41 54                	push   %r12
    8a79:	53                   	push   %rbx
    8a7a:	48 83 ec 18          	sub    $0x18,%rsp
    8a7e:	49 89 f6             	mov    %rsi,%r14
    8a81:	49 89 ff             	mov    %rdi,%r15
    8a84:	e8 77 fe ff ff       	call   8900 <tp_ws>
    8a89:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    8a8d:	49 8b 6f 10          	mov    0x10(%r15),%rbp
    8a91:	31 db                	xor    %ebx,%ebx
    8a93:	4c 39 ed             	cmp    %r13,%rbp
    8a96:	0f 83 0d 02 00 00    	jae    8ca9 <tp_quoted+0x239>
    8a9c:	49 8b 07             	mov    (%r15),%rax
    8a9f:	80 3c 28 22          	cmpb   $0x22,(%rax,%rbp,1)
    8aa3:	0f 85 00 02 00 00    	jne    8ca9 <tp_quoted+0x239>
    8aa9:	48 ff c5             	inc    %rbp
    8aac:	49 89 6f 10          	mov    %rbp,0x10(%r15)
    8ab0:	0f 57 c0             	xorps  %xmm0,%xmm0
    8ab3:	0f 29 04 24          	movaps %xmm0,(%rsp)
    8ab7:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    8abe:	00 00 
    8ac0:	31 db                	xor    %ebx,%ebx
    8ac2:	4c 39 ed             	cmp    %r13,%rbp
    8ac5:	0f 83 8d 01 00 00    	jae    8c58 <tp_quoted+0x1e8>
    8acb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8ad0:	4d 8b 27             	mov    (%r15),%r12
    8ad3:	48 8d 4d 01          	lea    0x1(%rbp),%rcx
    8ad7:	49 89 4f 10          	mov    %rcx,0x10(%r15)
    8adb:	41 0f b6 04 2c       	movzbl (%r12,%rbp,1),%eax
    8ae0:	83 f8 5c             	cmp    $0x5c,%eax
    8ae3:	74 2b                	je     8b10 <tp_quoted+0xa0>
    8ae5:	83 f8 22             	cmp    $0x22,%eax
    8ae8:	0f 84 8b 01 00 00    	je     8c79 <tp_quoted+0x209>
    8aee:	0f be f0             	movsbl %al,%esi
    8af1:	48 89 e7             	mov    %rsp,%rdi
    8af4:	e8 57 ee ff ff       	call   7950 <buf_putc>
    8af9:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    8afd:	49 8b 6f 10          	mov    0x10(%r15),%rbp
    8b01:	4c 39 ed             	cmp    %r13,%rbp
    8b04:	72 ca                	jb     8ad0 <tp_quoted+0x60>
    8b06:	e9 63 01 00 00       	jmp    8c6e <tp_quoted+0x1fe>
    8b0b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8b10:	4c 39 e9             	cmp    %r13,%rcx
    8b13:	0f 83 48 01 00 00    	jae    8c61 <tp_quoted+0x1f1>
    8b19:	48 8d 45 02          	lea    0x2(%rbp),%rax
    8b1d:	49 89 47 10          	mov    %rax,0x10(%r15)
    8b21:	41 0f b6 4c 2c 01    	movzbl 0x1(%r12,%rbp,1),%ecx
    8b27:	8d 51 a4             	lea    -0x5c(%rcx),%edx
    8b2a:	83 fa 19             	cmp    $0x19,%edx
    8b2d:	77 1a                	ja     8b49 <tp_quoted+0xd9>
    8b2f:	48 8d 35 0a 57 00 00 	lea    0x570a(%rip),%rsi        # e240 <_IO_stdin_used+0x240>
    8b36:	48 63 0c 96          	movslq (%rsi,%rdx,4),%rcx
    8b3a:	48 01 f1             	add    %rsi,%rcx
    8b3d:	ff e1                	jmp    *%rcx
    8b3f:	48 89 e7             	mov    %rsp,%rdi
    8b42:	be 5c 00 00 00       	mov    $0x5c,%esi
    8b47:	eb ab                	jmp    8af4 <tp_quoted+0x84>
    8b49:	83 f9 22             	cmp    $0x22,%ecx
    8b4c:	0f 84 bf 00 00 00    	je     8c11 <tp_quoted+0x1a1>
    8b52:	83 f9 30             	cmp    $0x30,%ecx
    8b55:	0f 85 06 01 00 00    	jne    8c61 <tp_quoted+0x1f1>
    8b5b:	48 89 e7             	mov    %rsp,%rdi
    8b5e:	31 f6                	xor    %esi,%esi
    8b60:	eb 92                	jmp    8af4 <tp_quoted+0x84>
    8b62:	48 89 e7             	mov    %rsp,%rdi
    8b65:	be 09 00 00 00       	mov    $0x9,%esi
    8b6a:	eb 88                	jmp    8af4 <tp_quoted+0x84>
    8b6c:	48 89 e7             	mov    %rsp,%rdi
    8b6f:	be 0d 00 00 00       	mov    $0xd,%esi
    8b74:	e9 7b ff ff ff       	jmp    8af4 <tp_quoted+0x84>
    8b79:	48 89 e7             	mov    %rsp,%rdi
    8b7c:	be 0a 00 00 00       	mov    $0xa,%esi
    8b81:	e9 6e ff ff ff       	jmp    8af4 <tp_quoted+0x84>
    8b86:	4c 39 e8             	cmp    %r13,%rax
    8b89:	0f 83 d2 00 00 00    	jae    8c61 <tp_quoted+0x1f1>
    8b8f:	41 80 3c 04 7b       	cmpb   $0x7b,(%r12,%rax,1)
    8b94:	0f 85 c7 00 00 00    	jne    8c61 <tp_quoted+0x1f1>
    8b9a:	48 8d 45 03          	lea    0x3(%rbp),%rax
    8b9e:	49 89 47 10          	mov    %rax,0x10(%r15)
    8ba2:	4c 39 e8             	cmp    %r13,%rax
    8ba5:	0f 83 b6 00 00 00    	jae    8c61 <tp_quoted+0x1f1>
    8bab:	e8 40 99 ff ff       	call   24f0 <__ctype_b_loc@plt>
    8bb0:	48 8b 08             	mov    (%rax),%rcx
    8bb3:	48 8d 55 04          	lea    0x4(%rbp),%rdx
    8bb7:	49 8d 3c 2c          	lea    (%r12,%rbp,1),%rdi
    8bbb:	48 83 c7 03          	add    $0x3,%rdi
    8bbf:	49 29 ed             	sub    %rbp,%r13
    8bc2:	49 83 c5 fd          	add    $0xfffffffffffffffd,%r13
    8bc6:	31 c0                	xor    %eax,%eax
    8bc8:	31 f6                	xor    %esi,%esi
    8bca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8bd0:	44 0f b6 04 07       	movzbl (%rdi,%rax,1),%r8d
    8bd5:	42 f6 44 41 01 10    	testb  $0x10,0x1(%rcx,%r8,2)
    8bdb:	74 41                	je     8c1e <tp_quoted+0x1ae>
    8bdd:	4c 8d 04 02          	lea    (%rdx,%rax,1),%r8
    8be1:	4d 89 47 10          	mov    %r8,0x10(%r15)
    8be5:	44 0f be 04 07       	movsbl (%rdi,%rax,1),%r8d
    8bea:	c1 e6 04             	shl    $0x4,%esi
    8bed:	45 8d 48 d0          	lea    -0x30(%r8),%r9d
    8bf1:	45 89 c2             	mov    %r8d,%r10d
    8bf4:	41 83 ca 20          	or     $0x20,%r10d
    8bf8:	41 83 c2 a9          	add    $0xffffffa9,%r10d
    8bfc:	41 83 f8 3a          	cmp    $0x3a,%r8d
    8c00:	45 0f 4c d1          	cmovl  %r9d,%r10d
    8c04:	44 01 d6             	add    %r10d,%esi
    8c07:	48 ff c0             	inc    %rax
    8c0a:	49 39 c5             	cmp    %rax,%r13
    8c0d:	75 c1                	jne    8bd0 <tp_quoted+0x160>
    8c0f:	eb 50                	jmp    8c61 <tp_quoted+0x1f1>
    8c11:	48 89 e7             	mov    %rsp,%rdi
    8c14:	be 22 00 00 00       	mov    $0x22,%esi
    8c19:	e9 d6 fe ff ff       	jmp    8af4 <tp_quoted+0x84>
    8c1e:	85 c0                	test   %eax,%eax
    8c20:	74 3f                	je     8c61 <tp_quoted+0x1f1>
    8c22:	41 80 f8 7d          	cmp    $0x7d,%r8b
    8c26:	75 39                	jne    8c61 <tp_quoted+0x1f1>
    8c28:	81 fe ff ff 10 00    	cmp    $0x10ffff,%esi
    8c2e:	77 31                	ja     8c61 <tp_quoted+0x1f1>
    8c30:	89 f1                	mov    %esi,%ecx
    8c32:	81 e1 00 f8 ff ff    	and    $0xfffff800,%ecx
    8c38:	81 f9 00 d8 00 00    	cmp    $0xd800,%ecx
    8c3e:	74 21                	je     8c61 <tp_quoted+0x1f1>
    8c40:	48 01 e8             	add    %rbp,%rax
    8c43:	48 83 c0 04          	add    $0x4,%rax
    8c47:	49 89 47 10          	mov    %rax,0x10(%r15)
    8c4b:	48 89 e7             	mov    %rsp,%rdi
    8c4e:	e8 5d 0d 00 00       	call   99b0 <fwp_utf8_put>
    8c53:	e9 a1 fe ff ff       	jmp    8af9 <tp_quoted+0x89>
    8c58:	31 ff                	xor    %edi,%edi
    8c5a:	e8 f1 93 ff ff       	call   2050 <free@plt>
    8c5f:	eb 48                	jmp    8ca9 <tp_quoted+0x239>
    8c61:	48 8b 3c 24          	mov    (%rsp),%rdi
    8c65:	e8 e6 93 ff ff       	call   2050 <free@plt>
    8c6a:	31 db                	xor    %ebx,%ebx
    8c6c:	eb 3b                	jmp    8ca9 <tp_quoted+0x239>
    8c6e:	48 8b 3c 24          	mov    (%rsp),%rdi
    8c72:	e8 d9 93 ff ff       	call   2050 <free@plt>
    8c77:	eb 30                	jmp    8ca9 <tp_quoted+0x239>
    8c79:	48 8b 1c 24          	mov    (%rsp),%rbx
    8c7d:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    8c82:	48 85 db             	test   %rbx,%rbx
    8c85:	48 8d 3d 2a 64 00 00 	lea    0x642a(%rip),%rdi        # f0b6 <exec_in_fp0+0xa56>
    8c8c:	48 0f 45 fb          	cmovne %rbx,%rdi
    8c90:	e8 1b eb ff ff       	call   77b0 <fwp_valid_utf8>
    8c95:	85 c0                	test   %eax,%eax
    8c97:	74 21                	je     8cba <tp_quoted+0x24a>
    8c99:	48 89 e7             	mov    %rsp,%rdi
    8c9c:	e8 3f ed ff ff       	call   79e0 <buf_to_str>
    8ca1:	49 89 06             	mov    %rax,(%r14)
    8ca4:	bb 01 00 00 00       	mov    $0x1,%ebx
    8ca9:	89 d8                	mov    %ebx,%eax
    8cab:	48 83 c4 18          	add    $0x18,%rsp
    8caf:	5b                   	pop    %rbx
    8cb0:	41 5c                	pop    %r12
    8cb2:	41 5d                	pop    %r13
    8cb4:	41 5e                	pop    %r14
    8cb6:	41 5f                	pop    %r15
    8cb8:	5d                   	pop    %rbp
    8cb9:	c3                   	ret
    8cba:	48 89 df             	mov    %rbx,%rdi
    8cbd:	eb a6                	jmp    8c65 <tp_quoted+0x1f5>
    8cbf:	90                   	nop

0000000000008cc0 <tp_eat>:
    8cc0:	55                   	push   %rbp
    8cc1:	41 57                	push   %r15
    8cc3:	41 56                	push   %r14
    8cc5:	53                   	push   %rbx
    8cc6:	50                   	push   %rax
    8cc7:	49 89 f6             	mov    %rsi,%r14
    8cca:	48 89 fb             	mov    %rdi,%rbx
    8ccd:	e8 2e fc ff ff       	call   8900 <tp_ws>
    8cd2:	4c 89 f7             	mov    %r14,%rdi
    8cd5:	e8 86 94 ff ff       	call   2160 <strlen@plt>
    8cda:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    8cde:	4c 8b 7b 10          	mov    0x10(%rbx),%r15
    8ce2:	4c 29 f9             	sub    %r15,%rcx
    8ce5:	31 ed                	xor    %ebp,%ebp
    8ce7:	48 39 c1             	cmp    %rax,%rcx
    8cea:	72 24                	jb     8d10 <tp_eat+0x50>
    8cec:	48 8b 3b             	mov    (%rbx),%rdi
    8cef:	4c 01 ff             	add    %r15,%rdi
    8cf2:	4c 89 f6             	mov    %r14,%rsi
    8cf5:	49 89 c6             	mov    %rax,%r14
    8cf8:	48 89 c2             	mov    %rax,%rdx
    8cfb:	e8 60 96 ff ff       	call   2360 <bcmp@plt>
    8d00:	85 c0                	test   %eax,%eax
    8d02:	75 0c                	jne    8d10 <tp_eat+0x50>
    8d04:	4d 01 f7             	add    %r14,%r15
    8d07:	4c 89 7b 10          	mov    %r15,0x10(%rbx)
    8d0b:	bd 01 00 00 00       	mov    $0x1,%ebp
    8d10:	89 e8                	mov    %ebp,%eax
    8d12:	48 83 c4 08          	add    $0x8,%rsp
    8d16:	5b                   	pop    %rbx
    8d17:	41 5e                	pop    %r14
    8d19:	41 5f                	pop    %r15
    8d1b:	5d                   	pop    %rbp
    8d1c:	c3                   	ret
    8d1d:	0f 1f 00             	nopl   (%rax)

0000000000008d20 <tp_list_of>:
    8d20:	55                   	push   %rbp
    8d21:	41 57                	push   %r15
    8d23:	41 56                	push   %r14
    8d25:	41 55                	push   %r13
    8d27:	41 54                	push   %r12
    8d29:	53                   	push   %rbx
    8d2a:	50                   	push   %rax
    8d2b:	4d 89 c6             	mov    %r8,%r14
    8d2e:	49 89 cf             	mov    %rcx,%r15
    8d31:	49 89 d4             	mov    %rdx,%r12
    8d34:	49 89 fd             	mov    %rdi,%r13
    8d37:	e8 84 ff ff ff       	call   8cc0 <tp_eat>
    8d3c:	31 db                	xor    %ebx,%ebx
    8d3e:	85 c0                	test   %eax,%eax
    8d40:	74 14                	je     8d56 <tp_list_of+0x36>
    8d42:	4c 89 ef             	mov    %r13,%rdi
    8d45:	4c 89 e6             	mov    %r12,%rsi
    8d48:	e8 73 ff ff ff       	call   8cc0 <tp_eat>
    8d4d:	85 c0                	test   %eax,%eax
    8d4f:	74 16                	je     8d67 <tp_list_of+0x47>
    8d51:	bb 01 00 00 00       	mov    $0x1,%ebx
    8d56:	89 d8                	mov    %ebx,%eax
    8d58:	48 83 c4 08          	add    $0x8,%rsp
    8d5c:	5b                   	pop    %rbx
    8d5d:	41 5c                	pop    %r12
    8d5f:	41 5d                	pop    %r13
    8d61:	41 5e                	pop    %r14
    8d63:	41 5f                	pop    %r15
    8d65:	5d                   	pop    %rbp
    8d66:	c3                   	ret
    8d67:	48 8d 2d 4c 65 00 00 	lea    0x654c(%rip),%rbp        # f2ba <exec_in_fp0+0xc5a>
    8d6e:	66 90                	xchg   %ax,%ax
    8d70:	4c 89 ef             	mov    %r13,%rdi
    8d73:	4c 89 f6             	mov    %r14,%rsi
    8d76:	41 ff d7             	call   *%r15
    8d79:	85 c0                	test   %eax,%eax
    8d7b:	74 d9                	je     8d56 <tp_list_of+0x36>
    8d7d:	4c 89 ef             	mov    %r13,%rdi
    8d80:	4c 89 e6             	mov    %r12,%rsi
    8d83:	e8 38 ff ff ff       	call   8cc0 <tp_eat>
    8d88:	85 c0                	test   %eax,%eax
    8d8a:	75 c5                	jne    8d51 <tp_list_of+0x31>
    8d8c:	4c 89 ef             	mov    %r13,%rdi
    8d8f:	48 89 ee             	mov    %rbp,%rsi
    8d92:	e8 29 ff ff ff       	call   8cc0 <tp_eat>
    8d97:	85 c0                	test   %eax,%eax
    8d99:	75 d5                	jne    8d70 <tp_list_of+0x50>
    8d9b:	eb b9                	jmp    8d56 <tp_list_of+0x36>
    8d9d:	0f 1f 00             	nopl   (%rax)

0000000000008da0 <tp_byte_item>:
    8da0:	53                   	push   %rbx
    8da1:	48 83 ec 10          	sub    $0x10,%rsp
    8da5:	48 89 f3             	mov    %rsi,%rbx
    8da8:	48 8d 35 21 af 00 00 	lea    0xaf21(%rip),%rsi        # 13cd0 <tp_byte_item.u8d>
    8daf:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    8db4:	e8 97 fb ff ff       	call   8950 <tp_int>
    8db9:	85 c0                	test   %eax,%eax
    8dbb:	74 14                	je     8dd1 <tp_byte_item+0x31>
    8dbd:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    8dc2:	48 89 df             	mov    %rbx,%rdi
    8dc5:	e8 96 0c 00 00       	call   9a60 <tp_push>
    8dca:	b8 01 00 00 00       	mov    $0x1,%eax
    8dcf:	eb 02                	jmp    8dd3 <tp_byte_item+0x33>
    8dd1:	31 c0                	xor    %eax,%eax
    8dd3:	48 83 c4 10          	add    $0x10,%rsp
    8dd7:	5b                   	pop    %rbx
    8dd8:	c3                   	ret
    8dd9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000008de0 <tp_token>:
    8de0:	55                   	push   %rbp
    8de1:	41 57                	push   %r15
    8de3:	41 56                	push   %r14
    8de5:	41 55                	push   %r13
    8de7:	41 54                	push   %r12
    8de9:	53                   	push   %rbx
    8dea:	50                   	push   %rax
    8deb:	49 89 d7             	mov    %rdx,%r15
    8dee:	48 89 34 24          	mov    %rsi,(%rsp)
    8df2:	48 89 fb             	mov    %rdi,%rbx
    8df5:	e8 06 fb ff ff       	call   8900 <tp_ws>
    8dfa:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    8dfe:	4c 8b 23             	mov    (%rbx),%r12
    8e01:	4c 8b 6b 08          	mov    0x8(%rbx),%r13
    8e05:	4c 89 f5             	mov    %r14,%rbp
    8e08:	4d 39 ee             	cmp    %r13,%r14
    8e0b:	73 20                	jae    8e2d <tp_token+0x4d>
    8e0d:	4c 89 f5             	mov    %r14,%rbp
    8e10:	41 0f be 3c 2c       	movsbl (%r12,%rbp,1),%edi
    8e15:	e8 a6 0c 00 00       	call   9ac0 <tp_is_delim>
    8e1a:	85 c0                	test   %eax,%eax
    8e1c:	75 0f                	jne    8e2d <tp_token+0x4d>
    8e1e:	48 ff c5             	inc    %rbp
    8e21:	48 89 6b 10          	mov    %rbp,0x10(%rbx)
    8e25:	49 39 ed             	cmp    %rbp,%r13
    8e28:	75 e6                	jne    8e10 <tp_token+0x30>
    8e2a:	4c 89 ed             	mov    %r13,%rbp
    8e2d:	4c 29 f5             	sub    %r14,%rbp
    8e30:	4d 8d 6f ff          	lea    -0x1(%r15),%r13
    8e34:	4c 39 fd             	cmp    %r15,%rbp
    8e37:	4c 0f 42 ed          	cmovb  %rbp,%r13
    8e3b:	4d 01 f4             	add    %r14,%r12
    8e3e:	4c 8b 3c 24          	mov    (%rsp),%r15
    8e42:	4c 89 ff             	mov    %r15,%rdi
    8e45:	4c 89 e6             	mov    %r12,%rsi
    8e48:	4c 89 ea             	mov    %r13,%rdx
    8e4b:	e8 d0 94 ff ff       	call   2320 <memcpy@plt>
    8e50:	43 c6 04 2f 00       	movb   $0x0,(%r15,%r13,1)
    8e55:	48 8b 43 10          	mov    0x10(%rbx),%rax
    8e59:	4c 29 f0             	sub    %r14,%rax
    8e5c:	48 83 c4 08          	add    $0x8,%rsp
    8e60:	5b                   	pop    %rbx
    8e61:	41 5c                	pop    %r12
    8e63:	41 5d                	pop    %r13
    8e65:	41 5e                	pop    %r14
    8e67:	41 5f                	pop    %r15
    8e69:	5d                   	pop    %rbp
    8e6a:	c3                   	ret
    8e6b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000008e70 <tp_elem_item>:
    8e70:	55                   	push   %rbp
    8e71:	53                   	push   %rbx
    8e72:	50                   	push   %rax
    8e73:	48 89 f3             	mov    %rsi,%rbx
    8e76:	48 8b 36             	mov    (%rsi),%rsi
    8e79:	31 ed                	xor    %ebp,%ebp
    8e7b:	48 89 e1             	mov    %rsp,%rcx
    8e7e:	31 d2                	xor    %edx,%edx
    8e80:	e8 4b f1 ff ff       	call   7fd0 <tp_value>
    8e85:	85 c0                	test   %eax,%eax
    8e87:	74 11                	je     8e9a <tp_elem_item+0x2a>
    8e89:	48 8b 34 24          	mov    (%rsp),%rsi
    8e8d:	48 89 df             	mov    %rbx,%rdi
    8e90:	e8 cb 0b 00 00       	call   9a60 <tp_push>
    8e95:	bd 01 00 00 00       	mov    $0x1,%ebp
    8e9a:	89 e8                	mov    %ebp,%eax
    8e9c:	48 83 c4 08          	add    $0x8,%rsp
    8ea0:	5b                   	pop    %rbx
    8ea1:	5d                   	pop    %rbp
    8ea2:	c3                   	ret
    8ea3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8eaa:	84 00 00 00 00 00 

0000000000008eb0 <fwp_p_array_from_list>:
    8eb0:	41 56                	push   %r14
    8eb2:	53                   	push   %rbx
    8eb3:	50                   	push   %rax
    8eb4:	48 89 fb             	mov    %rdi,%rbx
    8eb7:	e8 44 0c 00 00       	call   9b00 <fwp_list_len>
    8ebc:	49 89 c6             	mov    %rax,%r14
    8ebf:	48 89 c7             	mov    %rax,%rdi
    8ec2:	e8 19 c8 ff ff       	call   56e0 <fwp_arr_new>
    8ec7:	4d 85 f6             	test   %r14,%r14
    8eca:	0f 84 84 00 00 00    	je     8f54 <fwp_p_array_from_list+0xa4>
    8ed0:	44 89 f1             	mov    %r14d,%ecx
    8ed3:	83 e1 03             	and    $0x3,%ecx
    8ed6:	49 83 fe 04          	cmp    $0x4,%r14
    8eda:	73 04                	jae    8ee0 <fwp_p_array_from_list+0x30>
    8edc:	31 d2                	xor    %edx,%edx
    8ede:	eb 4d                	jmp    8f2d <fwp_p_array_from_list+0x7d>
    8ee0:	49 83 e6 fc          	and    $0xfffffffffffffffc,%r14
    8ee4:	31 d2                	xor    %edx,%edx
    8ee6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    8eed:	00 00 00 
    8ef0:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    8ef4:	48 89 74 d0 08       	mov    %rsi,0x8(%rax,%rdx,8)
    8ef9:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    8efd:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
    8f01:	48 89 7c d0 10       	mov    %rdi,0x10(%rax,%rdx,8)
    8f06:	48 8b 76 10          	mov    0x10(%rsi),%rsi
    8f0a:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
    8f0e:	48 89 7c d0 18       	mov    %rdi,0x18(%rax,%rdx,8)
    8f13:	48 8b 76 10          	mov    0x10(%rsi),%rsi
    8f17:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
    8f1b:	48 89 7c d0 20       	mov    %rdi,0x20(%rax,%rdx,8)
    8f20:	48 8b 5e 10          	mov    0x10(%rsi),%rbx
    8f24:	48 83 c2 04          	add    $0x4,%rdx
    8f28:	49 39 d6             	cmp    %rdx,%r14
    8f2b:	75 c3                	jne    8ef0 <fwp_p_array_from_list+0x40>
    8f2d:	48 85 c9             	test   %rcx,%rcx
    8f30:	74 22                	je     8f54 <fwp_p_array_from_list+0xa4>
    8f32:	48 8d 14 d0          	lea    (%rax,%rdx,8),%rdx
    8f36:	48 83 c2 08          	add    $0x8,%rdx
    8f3a:	31 f6                	xor    %esi,%esi
    8f3c:	0f 1f 40 00          	nopl   0x0(%rax)
    8f40:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    8f44:	48 89 3c f2          	mov    %rdi,(%rdx,%rsi,8)
    8f48:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    8f4c:	48 ff c6             	inc    %rsi
    8f4f:	48 39 f1             	cmp    %rsi,%rcx
    8f52:	75 ec                	jne    8f40 <fwp_p_array_from_list+0x90>
    8f54:	48 83 c4 08          	add    $0x8,%rsp
    8f58:	5b                   	pop    %rbx
    8f59:	41 5e                	pop    %r14
    8f5b:	c3                   	ret
    8f5c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000008f60 <tp_kv_item>:
    8f60:	41 57                	push   %r15
    8f62:	41 56                	push   %r14
    8f64:	53                   	push   %rbx
    8f65:	48 83 ec 10          	sub    $0x10,%rsp
    8f69:	48 89 f3             	mov    %rsi,%rbx
    8f6c:	49 89 ff             	mov    %rdi,%r15
    8f6f:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
    8f76:	00 
    8f77:	48 8b 36             	mov    (%rsi),%rsi
    8f7a:	45 31 f6             	xor    %r14d,%r14d
    8f7d:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    8f82:	31 d2                	xor    %edx,%edx
    8f84:	e8 47 f0 ff ff       	call   7fd0 <tp_value>
    8f89:	85 c0                	test   %eax,%eax
    8f8b:	74 27                	je     8fb4 <tp_kv_item+0x54>
    8f8d:	45 31 f6             	xor    %r14d,%r14d
    8f90:	83 7b 28 00          	cmpl   $0x0,0x28(%rbx)
    8f94:	74 2b                	je     8fc1 <tp_kv_item+0x61>
    8f96:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    8f9b:	48 89 df             	mov    %rbx,%rdi
    8f9e:	e8 bd 0a 00 00       	call   9a60 <tp_push>
    8fa3:	48 89 df             	mov    %rbx,%rdi
    8fa6:	4c 89 f6             	mov    %r14,%rsi
    8fa9:	e8 b2 0a 00 00       	call   9a60 <tp_push>
    8fae:	41 be 01 00 00 00    	mov    $0x1,%r14d
    8fb4:	44 89 f0             	mov    %r14d,%eax
    8fb7:	48 83 c4 10          	add    $0x10,%rsp
    8fbb:	5b                   	pop    %rbx
    8fbc:	41 5e                	pop    %r14
    8fbe:	41 5f                	pop    %r15
    8fc0:	c3                   	ret
    8fc1:	48 8d 35 06 63 00 00 	lea    0x6306(%rip),%rsi        # f2ce <exec_in_fp0+0xc6e>
    8fc8:	4c 89 ff             	mov    %r15,%rdi
    8fcb:	e8 f0 fc ff ff       	call   8cc0 <tp_eat>
    8fd0:	85 c0                	test   %eax,%eax
    8fd2:	74 e0                	je     8fb4 <tp_kv_item+0x54>
    8fd4:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    8fd8:	45 31 f6             	xor    %r14d,%r14d
    8fdb:	48 89 e1             	mov    %rsp,%rcx
    8fde:	4c 89 ff             	mov    %r15,%rdi
    8fe1:	31 d2                	xor    %edx,%edx
    8fe3:	e8 e8 ef ff ff       	call   7fd0 <tp_value>
    8fe8:	85 c0                	test   %eax,%eax
    8fea:	74 c8                	je     8fb4 <tp_kv_item+0x54>
    8fec:	4c 8b 34 24          	mov    (%rsp),%r14
    8ff0:	eb a4                	jmp    8f96 <tp_kv_item+0x36>
    8ff2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8ff9:	1f 84 00 00 00 00 00 

0000000000009000 <fwp_p_map_insert>:
    9000:	55                   	push   %rbp
    9001:	41 57                	push   %r15
    9003:	41 56                	push   %r14
    9005:	41 55                	push   %r13
    9007:	41 54                	push   %r12
    9009:	53                   	push   %rbx
    900a:	48 83 ec 18          	sub    $0x18,%rsp
    900e:	49 89 d6             	mov    %rdx,%r14
    9011:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    9016:	48 89 fe             	mov    %rdi,%rsi
    9019:	48 8d 44 24 04       	lea    0x4(%rsp),%rax
    901e:	48 89 d7             	mov    %rdx,%rdi
    9021:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
    9026:	48 89 ca             	mov    %rcx,%rdx
    9029:	48 89 c1             	mov    %rax,%rcx
    902c:	e8 ef 0a 00 00       	call   9b20 <fwp_map_find>
    9031:	48 89 c5             	mov    %rax,%rbp
    9034:	4d 8b 3e             	mov    (%r14),%r15
    9037:	44 8b 64 24 04       	mov    0x4(%rsp),%r12d
    903c:	31 ff                	xor    %edi,%edi
    903e:	45 85 e4             	test   %r12d,%r12d
    9041:	40 0f 94 c7          	sete   %dil
    9045:	4c 01 ff             	add    %r15,%rdi
    9048:	e8 23 0c 00 00       	call   9c70 <fwp_map_alloc>
    904d:	49 89 c5             	mov    %rax,%r13
    9050:	48 8d 58 08          	lea    0x8(%rax),%rbx
    9054:	49 83 c6 08          	add    $0x8,%r14
    9058:	45 85 e4             	test   %r12d,%r12d
    905b:	74 22                	je     907f <fwp_p_map_insert+0x7f>
    905d:	49 c1 e7 04          	shl    $0x4,%r15
    9061:	48 89 df             	mov    %rbx,%rdi
    9064:	4c 89 f6             	mov    %r14,%rsi
    9067:	4c 89 fa             	mov    %r15,%rdx
    906a:	e8 b1 92 ff ff       	call   2320 <memcpy@plt>
    906f:	48 c1 e5 04          	shl    $0x4,%rbp
    9073:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    9078:	49 89 44 2d 10       	mov    %rax,0x10(%r13,%rbp,1)
    907d:	eb 46                	jmp    90c5 <fwp_p_map_insert+0xc5>
    907f:	49 89 ec             	mov    %rbp,%r12
    9082:	49 c1 e4 04          	shl    $0x4,%r12
    9086:	48 89 df             	mov    %rbx,%rdi
    9089:	4c 89 f6             	mov    %r14,%rsi
    908c:	4c 89 e2             	mov    %r12,%rdx
    908f:	e8 8c 92 ff ff       	call   2320 <memcpy@plt>
    9094:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    9099:	4b 89 44 25 08       	mov    %rax,0x8(%r13,%r12,1)
    909e:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    90a3:	4b 89 44 25 10       	mov    %rax,0x10(%r13,%r12,1)
    90a8:	4a 8d 3c 23          	lea    (%rbx,%r12,1),%rdi
    90ac:	48 83 c7 10          	add    $0x10,%rdi
    90b0:	4d 01 f4             	add    %r14,%r12
    90b3:	49 29 ef             	sub    %rbp,%r15
    90b6:	49 c1 e7 04          	shl    $0x4,%r15
    90ba:	4c 89 e6             	mov    %r12,%rsi
    90bd:	4c 89 fa             	mov    %r15,%rdx
    90c0:	e8 5b 92 ff ff       	call   2320 <memcpy@plt>
    90c5:	4c 89 e8             	mov    %r13,%rax
    90c8:	48 83 c4 18          	add    $0x18,%rsp
    90cc:	5b                   	pop    %rbx
    90cd:	41 5c                	pop    %r12
    90cf:	41 5d                	pop    %r13
    90d1:	41 5e                	pop    %r14
    90d3:	41 5f                	pop    %r15
    90d5:	5d                   	pop    %rbp
    90d6:	c3                   	ret
    90d7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    90de:	00 00 

00000000000090e0 <fwp_valid_int>:
    90e0:	31 c0                	xor    %eax,%eax
    90e2:	48 85 f6             	test   %rsi,%rsi
    90e5:	74 32                	je     9119 <fwp_valid_int+0x39>
    90e7:	0f b6 17             	movzbl (%rdi),%edx
    90ea:	80 c2 d5             	add    $0xd5,%dl
    90ed:	31 c9                	xor    %ecx,%ecx
    90ef:	f6 c2 fd             	test   $0xfd,%dl
    90f2:	0f 94 c1             	sete   %cl
    90f5:	48 39 f1             	cmp    %rsi,%rcx
    90f8:	74 1f                	je     9119 <fwp_valid_int+0x39>
    90fa:	73 18                	jae    9114 <fwp_valid_int+0x34>
    90fc:	0f 1f 40 00          	nopl   0x0(%rax)
    9100:	0f b6 14 0f          	movzbl (%rdi,%rcx,1),%edx
    9104:	80 c2 c6             	add    $0xc6,%dl
    9107:	80 fa f5             	cmp    $0xf5,%dl
    910a:	76 0d                	jbe    9119 <fwp_valid_int+0x39>
    910c:	48 ff c1             	inc    %rcx
    910f:	48 39 ce             	cmp    %rcx,%rsi
    9112:	75 ec                	jne    9100 <fwp_valid_int+0x20>
    9114:	b8 01 00 00 00       	mov    $0x1,%eax
    9119:	c3                   	ret
    911a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000009120 <tp_record_body>:
    9120:	55                   	push   %rbp
    9121:	41 57                	push   %r15
    9123:	41 56                	push   %r14
    9125:	41 55                	push   %r13
    9127:	41 54                	push   %r12
    9129:	53                   	push   %rbx
    912a:	48 81 ec 28 01 00 00 	sub    $0x128,%rsp
    9131:	48 89 d3             	mov    %rdx,%rbx
    9134:	49 89 f5             	mov    %rsi,%r13
    9137:	48 89 fd             	mov    %rdi,%rbp
    913a:	48 63 46 10          	movslq 0x10(%rsi),%rax
    913e:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    9145:	00 
    9146:	e8 d5 c5 ff ff       	call   5720 <fwp_alloc>
    914b:	49 89 c7             	mov    %rax,%r15
    914e:	49 63 7d 10          	movslq 0x10(%r13),%rdi
    9152:	48 ff c7             	inc    %rdi
    9155:	e8 f6 d5 ff ff       	call   6750 <fwp_alloc_leaf>
    915a:	49 89 c4             	mov    %rax,%r12
    915d:	49 63 55 10          	movslq 0x10(%r13),%rdx
    9161:	48 ff c2             	inc    %rdx
    9164:	45 31 f6             	xor    %r14d,%r14d
    9167:	48 89 c7             	mov    %rax,%rdi
    916a:	31 f6                	xor    %esi,%esi
    916c:	e8 8f 90 ff ff       	call   2200 <memset@plt>
    9171:	48 8d 35 02 62 00 00 	lea    0x6202(%rip),%rsi        # f37a <exec_in_fp0+0xd1a>
    9178:	48 89 ef             	mov    %rbp,%rdi
    917b:	e8 40 fb ff ff       	call   8cc0 <tp_eat>
    9180:	85 c0                	test   %eax,%eax
    9182:	0f 84 3b 01 00 00    	je     92c3 <tp_record_body+0x1a3>
    9188:	48 8d 35 1f 62 00 00 	lea    0x621f(%rip),%rsi        # f3ae <exec_in_fp0+0xd4e>
    918f:	48 89 ef             	mov    %rbp,%rdi
    9192:	e8 29 fb ff ff       	call   8cc0 <tp_eat>
    9197:	85 c0                	test   %eax,%eax
    9199:	74 3e                	je     91d9 <tp_record_body+0xb9>
    919b:	41 8b 7d 10          	mov    0x10(%r13),%edi
    919f:	85 ff                	test   %edi,%edi
    91a1:	7e 20                	jle    91c3 <tp_record_body+0xa3>
    91a3:	45 31 f6             	xor    %r14d,%r14d
    91a6:	31 c0                	xor    %eax,%eax
    91a8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    91af:	00 
    91b0:	41 80 3c 04 00       	cmpb   $0x0,(%r12,%rax,1)
    91b5:	0f 84 08 01 00 00    	je     92c3 <tp_record_body+0x1a3>
    91bb:	48 ff c0             	inc    %rax
    91be:	48 39 c7             	cmp    %rax,%rdi
    91c1:	75 ed                	jne    91b0 <tp_record_body+0x90>
    91c3:	4c 89 fe             	mov    %r15,%rsi
    91c6:	e8 95 9e ff ff       	call   3060 <fwp_record>
    91cb:	48 89 03             	mov    %rax,(%rbx)
    91ce:	41 be 01 00 00 00    	mov    $0x1,%r14d
    91d4:	e9 ea 00 00 00       	jmp    92c3 <tp_record_body+0x1a3>
    91d9:	48 89 1c 24          	mov    %rbx,(%rsp)
    91dd:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    91e2:	48 89 ef             	mov    %rbp,%rdi
    91e5:	e8 06 01 00 00       	call   92f0 <tp_ident>
    91ea:	41 8b 45 10          	mov    0x10(%r13),%eax
    91ee:	85 c0                	test   %eax,%eax
    91f0:	0f 8e ca 00 00 00    	jle    92c0 <tp_record_body+0x1a0>
    91f6:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    91fb:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    9200:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
    9205:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    920a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9210:	4d 8b 65 18          	mov    0x18(%r13),%r12
    9214:	41 89 c7             	mov    %eax,%r15d
    9217:	41 be ff ff ff ff    	mov    $0xffffffff,%r14d
    921d:	31 ed                	xor    %ebp,%ebp
    921f:	90                   	nop
    9220:	49 8b 3c ec          	mov    (%r12,%rbp,8),%rdi
    9224:	48 89 de             	mov    %rbx,%rsi
    9227:	e8 94 90 ff ff       	call   22c0 <strcmp@plt>
    922c:	85 c0                	test   %eax,%eax
    922e:	44 0f 44 f5          	cmove  %ebp,%r14d
    9232:	48 ff c5             	inc    %rbp
    9235:	49 39 ef             	cmp    %rbp,%r15
    9238:	75 e6                	jne    9220 <tp_record_body+0x100>
    923a:	45 85 f6             	test   %r14d,%r14d
    923d:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    9242:	4c 8b 64 24 10       	mov    0x10(%rsp),%r12
    9247:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    924c:	78 72                	js     92c0 <tp_record_body+0x1a0>
    924e:	48 89 ef             	mov    %rbp,%rdi
    9251:	48 8d 35 78 60 00 00 	lea    0x6078(%rip),%rsi        # f2d0 <exec_in_fp0+0xc70>
    9258:	e8 63 fa ff ff       	call   8cc0 <tp_eat>
    925d:	85 c0                	test   %eax,%eax
    925f:	74 5f                	je     92c0 <tp_record_body+0x1a0>
    9261:	49 8b 45 20          	mov    0x20(%r13),%rax
    9265:	45 89 f6             	mov    %r14d,%r14d
    9268:	4a 8b 34 f0          	mov    (%rax,%r14,8),%rsi
    926c:	4b 8d 0c f7          	lea    (%r15,%r14,8),%rcx
    9270:	48 89 ef             	mov    %rbp,%rdi
    9273:	31 d2                	xor    %edx,%edx
    9275:	e8 56 ed ff ff       	call   7fd0 <tp_value>
    927a:	85 c0                	test   %eax,%eax
    927c:	74 42                	je     92c0 <tp_record_body+0x1a0>
    927e:	43 c6 04 34 01       	movb   $0x1,(%r12,%r14,1)
    9283:	48 89 ef             	mov    %rbp,%rdi
    9286:	48 8d 35 21 61 00 00 	lea    0x6121(%rip),%rsi        # f3ae <exec_in_fp0+0xd4e>
    928d:	e8 2e fa ff ff       	call   8cc0 <tp_eat>
    9292:	85 c0                	test   %eax,%eax
    9294:	75 42                	jne    92d8 <tp_record_body+0x1b8>
    9296:	48 89 ef             	mov    %rbp,%rdi
    9299:	48 8d 35 1a 60 00 00 	lea    0x601a(%rip),%rsi        # f2ba <exec_in_fp0+0xc5a>
    92a0:	e8 1b fa ff ff       	call   8cc0 <tp_eat>
    92a5:	85 c0                	test   %eax,%eax
    92a7:	74 17                	je     92c0 <tp_record_body+0x1a0>
    92a9:	48 89 ef             	mov    %rbp,%rdi
    92ac:	48 89 de             	mov    %rbx,%rsi
    92af:	e8 3c 00 00 00       	call   92f0 <tp_ident>
    92b4:	41 8b 45 10          	mov    0x10(%r13),%eax
    92b8:	85 c0                	test   %eax,%eax
    92ba:	0f 8f 50 ff ff ff    	jg     9210 <tp_record_body+0xf0>
    92c0:	45 31 f6             	xor    %r14d,%r14d
    92c3:	44 89 f0             	mov    %r14d,%eax
    92c6:	48 81 c4 28 01 00 00 	add    $0x128,%rsp
    92cd:	5b                   	pop    %rbx
    92ce:	41 5c                	pop    %r12
    92d0:	41 5d                	pop    %r13
    92d2:	41 5e                	pop    %r14
    92d4:	41 5f                	pop    %r15
    92d6:	5d                   	pop    %rbp
    92d7:	c3                   	ret
    92d8:	48 8b 1c 24          	mov    (%rsp),%rbx
    92dc:	e9 ba fe ff ff       	jmp    919b <tp_record_body+0x7b>
    92e1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    92e8:	0f 1f 84 00 00 00 00 
    92ef:	00 

00000000000092f0 <tp_ident>:
    92f0:	41 56                	push   %r14
    92f2:	53                   	push   %rbx
    92f3:	50                   	push   %rax
    92f4:	48 89 f3             	mov    %rsi,%rbx
    92f7:	49 89 fe             	mov    %rdi,%r14
    92fa:	e8 01 f6 ff ff       	call   8900 <tp_ws>
    92ff:	49 8b 46 10          	mov    0x10(%r14),%rax
    9303:	49 8b 36             	mov    (%r14),%rsi
    9306:	49 8b 56 08          	mov    0x8(%r14),%rdx
    930a:	48 89 c1             	mov    %rax,%rcx
    930d:	48 39 d0             	cmp    %rdx,%rax
    9310:	73 63                	jae    9375 <tp_ident+0x85>
    9312:	48 bf 03 00 00 00 00 	movabs $0x4000000000003,%rdi
    9319:	00 04 00 
    931c:	48 89 c1             	mov    %rax,%rcx
    931f:	eb 1b                	jmp    933c <tp_ident+0x4c>
    9321:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9328:	0f 1f 84 00 00 00 00 
    932f:	00 
    9330:	48 ff c1             	inc    %rcx
    9333:	49 89 4e 10          	mov    %rcx,0x10(%r14)
    9337:	48 39 ca             	cmp    %rcx,%rdx
    933a:	74 36                	je     9372 <tp_ident+0x82>
    933c:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
    9341:	45 8d 48 d0          	lea    -0x30(%r8),%r9d
    9345:	41 80 f9 0a          	cmp    $0xa,%r9b
    9349:	72 e5                	jb     9330 <tp_ident+0x40>
    934b:	45 89 c1             	mov    %r8d,%r9d
    934e:	41 80 e1 df          	and    $0xdf,%r9b
    9352:	41 80 c1 bf          	add    $0xbf,%r9b
    9356:	41 80 f9 1a          	cmp    $0x1a,%r9b
    935a:	72 d4                	jb     9330 <tp_ident+0x40>
    935c:	45 0f b6 c0          	movzbl %r8b,%r8d
    9360:	41 83 c0 d3          	add    $0xffffffd3,%r8d
    9364:	41 83 f8 32          	cmp    $0x32,%r8d
    9368:	77 0b                	ja     9375 <tp_ident+0x85>
    936a:	4c 0f a3 c7          	bt     %r8,%rdi
    936e:	72 c0                	jb     9330 <tp_ident+0x40>
    9370:	eb 03                	jmp    9375 <tp_ident+0x85>
    9372:	48 89 d1             	mov    %rdx,%rcx
    9375:	48 29 c1             	sub    %rax,%rcx
    9378:	48 81 f9 ff 00 00 00 	cmp    $0xff,%rcx
    937f:	41 be ff 00 00 00    	mov    $0xff,%r14d
    9385:	4c 0f 42 f1          	cmovb  %rcx,%r14
    9389:	48 01 c6             	add    %rax,%rsi
    938c:	48 89 df             	mov    %rbx,%rdi
    938f:	4c 89 f2             	mov    %r14,%rdx
    9392:	e8 89 8f ff ff       	call   2320 <memcpy@plt>
    9397:	42 c6 04 33 00       	movb   $0x0,(%rbx,%r14,1)
    939c:	48 83 c4 08          	add    $0x8,%rsp
    93a0:	5b                   	pop    %rbx
    93a1:	41 5e                	pop    %r14
    93a3:	c3                   	ret
    93a4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    93ab:	00 00 00 00 00 

00000000000093b0 <tp_atom>:
    93b0:	41 57                	push   %r15
    93b2:	41 56                	push   %r14
    93b4:	53                   	push   %rbx
    93b5:	49 89 d6             	mov    %rdx,%r14
    93b8:	49 89 f7             	mov    %rsi,%r15
    93bb:	48 89 fb             	mov    %rdi,%rbx
    93be:	e8 3d f5 ff ff       	call   8900 <tp_ws>
    93c3:	41 83 3f 10          	cmpl   $0x10,(%r15)
    93c7:	75 07                	jne    93d0 <tp_atom+0x20>
    93c9:	49 83 7f 08 00       	cmpq   $0x0,0x8(%r15)
    93ce:	74 5e                	je     942e <tp_atom+0x7e>
    93d0:	31 c0                	xor    %eax,%eax
    93d2:	48 8b 4b 10          	mov    0x10(%rbx),%rcx
    93d6:	48 3b 4b 08          	cmp    0x8(%rbx),%rcx
    93da:	73 0e                	jae    93ea <tp_atom+0x3a>
    93dc:	48 8b 13             	mov    (%rbx),%rdx
    93df:	80 3c 0a 28          	cmpb   $0x28,(%rdx,%rcx,1)
    93e3:	0f 95 c2             	setne  %dl
    93e6:	08 c2                	or     %al,%dl
    93e8:	74 15                	je     93ff <tp_atom+0x4f>
    93ea:	48 89 df             	mov    %rbx,%rdi
    93ed:	4c 89 fe             	mov    %r15,%rsi
    93f0:	31 d2                	xor    %edx,%edx
    93f2:	4c 89 f1             	mov    %r14,%rcx
    93f5:	5b                   	pop    %rbx
    93f6:	41 5e                	pop    %r14
    93f8:	41 5f                	pop    %r15
    93fa:	e9 d1 eb ff ff       	jmp    7fd0 <tp_value>
    93ff:	48 ff c1             	inc    %rcx
    9402:	48 89 4b 10          	mov    %rcx,0x10(%rbx)
    9406:	48 89 df             	mov    %rbx,%rdi
    9409:	4c 89 fe             	mov    %r15,%rsi
    940c:	31 d2                	xor    %edx,%edx
    940e:	4c 89 f1             	mov    %r14,%rcx
    9411:	e8 ba eb ff ff       	call   7fd0 <tp_value>
    9416:	85 c0                	test   %eax,%eax
    9418:	74 25                	je     943f <tp_atom+0x8f>
    941a:	48 8d 35 5c 5f 00 00 	lea    0x5f5c(%rip),%rsi        # f37d <exec_in_fp0+0xd1d>
    9421:	48 89 df             	mov    %rbx,%rdi
    9424:	5b                   	pop    %rbx
    9425:	41 5e                	pop    %r14
    9427:	41 5f                	pop    %r15
    9429:	e9 92 f8 ff ff       	jmp    8cc0 <tp_eat>
    942e:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    9433:	74 12                	je     9447 <tp_atom+0x97>
    9435:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
    943a:	0f 95 c0             	setne  %al
    943d:	eb 93                	jmp    93d2 <tp_atom+0x22>
    943f:	31 c0                	xor    %eax,%eax
    9441:	5b                   	pop    %rbx
    9442:	41 5e                	pop    %r14
    9444:	41 5f                	pop    %r15
    9446:	c3                   	ret
    9447:	b0 01                	mov    $0x1,%al
    9449:	eb 87                	jmp    93d2 <tp_atom+0x22>
    944b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000009450 <fwp_cstr>:
    9450:	53                   	push   %rbx
    9451:	48 89 fb             	mov    %rdi,%rbx
    9454:	e8 07 8d ff ff       	call   2160 <strlen@plt>
    9459:	48 89 df             	mov    %rbx,%rdi
    945c:	48 89 c6             	mov    %rax,%rsi
    945f:	5b                   	pop    %rbx
    9460:	e9 ab e4 ff ff       	jmp    7910 <fwp_str_new>
    9465:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    946c:	00 00 00 00 

0000000000009470 <fwp_p_parse_int>:
    9470:	55                   	push   %rbp
    9471:	41 57                	push   %r15
    9473:	41 56                	push   %r14
    9475:	41 55                	push   %r13
    9477:	41 54                	push   %r12
    9479:	53                   	push   %rbx
    947a:	48 83 ec 18          	sub    $0x18,%rsp
    947e:	89 d3                	mov    %edx,%ebx
    9480:	89 f5                	mov    %esi,%ebp
    9482:	49 89 fe             	mov    %rdi,%r14
    9485:	4c 8b 3f             	mov    (%rdi),%r15
    9488:	49 83 c6 08          	add    $0x8,%r14
    948c:	4c 89 f7             	mov    %r14,%rdi
    948f:	4c 89 fe             	mov    %r15,%rsi
    9492:	e8 49 fc ff ff       	call   90e0 <fwp_valid_int>
    9497:	85 c0                	test   %eax,%eax
    9499:	0f 84 1a 01 00 00    	je     95b9 <fwp_p_parse_int+0x149>
    949f:	41 0f b6 06          	movzbl (%r14),%eax
    94a3:	31 ff                	xor    %edi,%edi
    94a5:	3c 2d                	cmp    $0x2d,%al
    94a7:	0f 94 c1             	sete   %cl
    94aa:	3c 2b                	cmp    $0x2b,%al
    94ac:	0f 94 c0             	sete   %al
    94af:	08 c8                	or     %cl,%al
    94b1:	44 0f b6 e0          	movzbl %al,%r12d
    94b5:	4d 39 e7             	cmp    %r12,%r15
    94b8:	0f 86 d0 00 00 00    	jbe    958e <fwp_p_parse_int+0x11e>
    94be:	88 4c 24 07          	mov    %cl,0x7(%rsp)
    94c2:	89 6c 24 08          	mov    %ebp,0x8(%rsp)
    94c6:	89 5c 24 0c          	mov    %ebx,0xc(%rsp)
    94ca:	bf 0a 00 00 00       	mov    $0xa,%edi
    94cf:	48 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rbx
    94d6:	cc cc cc 
    94d9:	48 bd cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbp
    94e0:	cc cc cc 
    94e3:	31 f6                	xor    %esi,%esi
    94e5:	45 31 db             	xor    %r11d,%r11d
    94e8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    94ef:	00 
    94f0:	4d 89 dd             	mov    %r11,%r13
    94f3:	49 89 f0             	mov    %rsi,%r8
    94f6:	48 89 f0             	mov    %rsi,%rax
    94f9:	48 f7 e7             	mul    %rdi
    94fc:	4b 8d 0c 9b          	lea    (%r11,%r11,4),%rcx
    9500:	48 8d 0c 4a          	lea    (%rdx,%rcx,2),%rcx
    9504:	43 0f be 14 26       	movsbl (%r14,%r12,1),%edx
    9509:	83 c2 d0             	add    $0xffffffd0,%edx
    950c:	48 63 d2             	movslq %edx,%rdx
    950f:	49 89 d3             	mov    %rdx,%r11
    9512:	49 c1 fb 3f          	sar    $0x3f,%r11
    9516:	48 89 c6             	mov    %rax,%rsi
    9519:	48 01 d6             	add    %rdx,%rsi
    951c:	49 11 cb             	adc    %rcx,%r11
    951f:	4d 89 d9             	mov    %r11,%r9
    9522:	49 0f a4 f1 3f       	shld   $0x3f,%rsi,%r9
    9527:	4c 89 d9             	mov    %r11,%rcx
    952a:	48 d1 e9             	shr    $1,%rcx
    952d:	4d 89 ca             	mov    %r9,%r10
    9530:	49 01 ca             	add    %rcx,%r10
    9533:	49 83 d2 00          	adc    $0x0,%r10
    9537:	4c 89 d0             	mov    %r10,%rax
    953a:	48 f7 e3             	mul    %rbx
    953d:	48 c1 ea 02          	shr    $0x2,%rdx
    9541:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9545:	49 29 c2             	sub    %rax,%r10
    9548:	4d 29 d1             	sub    %r10,%r9
    954b:	48 83 d9 00          	sbb    $0x0,%rcx
    954f:	4d 89 ca             	mov    %r9,%r10
    9552:	4c 0f af d5          	imul   %rbp,%r10
    9556:	4c 89 c8             	mov    %r9,%rax
    9559:	48 f7 e3             	mul    %rbx
    955c:	4c 01 d2             	add    %r10,%rdx
    955f:	48 0f af cb          	imul   %rbx,%rcx
    9563:	48 01 d1             	add    %rdx,%rcx
    9566:	4c 31 e9             	xor    %r13,%rcx
    9569:	4c 31 c0             	xor    %r8,%rax
    956c:	48 09 c8             	or     %rcx,%rax
    956f:	75 48                	jne    95b9 <fwp_p_parse_int+0x149>
    9571:	49 ff c4             	inc    %r12
    9574:	4d 39 e7             	cmp    %r12,%r15
    9577:	0f 85 73 ff ff ff    	jne    94f0 <fwp_p_parse_int+0x80>
    957d:	8b 5c 24 0c          	mov    0xc(%rsp),%ebx
    9581:	8b 6c 24 08          	mov    0x8(%rsp),%ebp
    9585:	31 ff                	xor    %edi,%edi
    9587:	0f b6 4c 24 07       	movzbl 0x7(%rsp),%ecx
    958c:	eb 05                	jmp    9593 <fwp_p_parse_int+0x123>
    958e:	31 f6                	xor    %esi,%esi
    9590:	45 31 db             	xor    %r11d,%r11d
    9593:	40 88 cf             	mov    %cl,%dil
    9596:	4c 8d 4c 24 10       	lea    0x10(%rsp),%r9
    959b:	4c 89 da             	mov    %r11,%rdx
    959e:	89 e9                	mov    %ebp,%ecx
    95a0:	41 89 d8             	mov    %ebx,%r8d
    95a3:	e8 28 00 00 00       	call   95d0 <fwp_int_in_range>
    95a8:	48 85 c0             	test   %rax,%rax
    95ab:	74 0c                	je     95b9 <fwp_p_parse_int+0x149>
    95ad:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    95b2:	e8 99 00 00 00       	call   9650 <fwp_some>
    95b7:	eb 02                	jmp    95bb <fwp_p_parse_int+0x14b>
    95b9:	31 c0                	xor    %eax,%eax
    95bb:	48 83 c4 18          	add    $0x18,%rsp
    95bf:	5b                   	pop    %rbx
    95c0:	41 5c                	pop    %r12
    95c2:	41 5d                	pop    %r13
    95c4:	41 5e                	pop    %r14
    95c6:	41 5f                	pop    %r15
    95c8:	5d                   	pop    %rbp
    95c9:	c3                   	ret
    95ca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000095d0 <fwp_int_in_range>:
    95d0:	53                   	push   %rbx
    95d1:	83 f9 09             	cmp    $0x9,%ecx
    95d4:	75 24                	jne    95fa <fwp_int_in_range+0x2a>
    95d6:	85 ff                	test   %edi,%edi
    95d8:	74 08                	je     95e2 <fwp_int_in_range+0x12>
    95da:	48 89 f0             	mov    %rsi,%rax
    95dd:	48 09 d0             	or     %rdx,%rax
    95e0:	75 3c                	jne    961e <fwp_int_in_range+0x4e>
    95e2:	48 89 f7             	mov    %rsi,%rdi
    95e5:	48 89 d6             	mov    %rdx,%rsi
    95e8:	4c 89 cb             	mov    %r9,%rbx
    95eb:	e8 80 00 00 00       	call   9670 <fwp_box_u128>
    95f0:	48 89 03             	mov    %rax,(%rbx)
    95f3:	b8 01 00 00 00       	mov    $0x1,%eax
    95f8:	5b                   	pop    %rbx
    95f9:	c3                   	ret
    95fa:	48 89 f0             	mov    %rsi,%rax
    95fd:	48 f7 d8             	neg    %rax
    9600:	48 b8 00 00 00 00 00 	movabs $0x8000000000000000,%rax
    9607:	00 00 80 
    960a:	49 89 c2             	mov    %rax,%r10
    960d:	49 19 d2             	sbb    %rdx,%r10
    9610:	72 0c                	jb     961e <fwp_int_in_range+0x4e>
    9612:	85 ff                	test   %edi,%edi
    9614:	75 0c                	jne    9622 <fwp_int_in_range+0x52>
    9616:	48 31 d0             	xor    %rdx,%rax
    9619:	48 09 f0             	or     %rsi,%rax
    961c:	75 04                	jne    9622 <fwp_int_in_range+0x52>
    961e:	31 c0                	xor    %eax,%eax
    9620:	5b                   	pop    %rbx
    9621:	c3                   	ret
    9622:	31 c0                	xor    %eax,%eax
    9624:	49 89 f2             	mov    %rsi,%r10
    9627:	49 f7 da             	neg    %r10
    962a:	48 19 d0             	sbb    %rdx,%rax
    962d:	85 ff                	test   %edi,%edi
    962f:	4c 0f 44 d6          	cmove  %rsi,%r10
    9633:	48 0f 44 c2          	cmove  %rdx,%rax
    9637:	4c 89 d7             	mov    %r10,%rdi
    963a:	48 89 c6             	mov    %rax,%rsi
    963d:	89 ca                	mov    %ecx,%edx
    963f:	44 89 c1             	mov    %r8d,%ecx
    9642:	4d 89 c8             	mov    %r9,%r8
    9645:	e8 56 00 00 00       	call   96a0 <fwp_int_fits>
    964a:	89 c0                	mov    %eax,%eax
    964c:	5b                   	pop    %rbx
    964d:	c3                   	ret
    964e:	66 90                	xchg   %ax,%ax

0000000000009650 <fwp_some>:
    9650:	50                   	push   %rax
    9651:	48 89 3c 24          	mov    %rdi,(%rsp)
    9655:	48 89 e2             	mov    %rsp,%rdx
    9658:	bf 01 00 00 00       	mov    $0x1,%edi
    965d:	be 01 00 00 00       	mov    $0x1,%esi
    9662:	e8 09 9a ff ff       	call   3070 <fwp_data>
    9667:	59                   	pop    %rcx
    9668:	c3                   	ret
    9669:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000009670 <fwp_box_u128>:
    9670:	41 56                	push   %r14
    9672:	53                   	push   %rbx
    9673:	50                   	push   %rax
    9674:	48 89 f3             	mov    %rsi,%rbx
    9677:	49 89 fe             	mov    %rdi,%r14
    967a:	bf 10 00 00 00       	mov    $0x10,%edi
    967f:	e8 cc d0 ff ff       	call   6750 <fwp_alloc_leaf>
    9684:	48 89 58 08          	mov    %rbx,0x8(%rax)
    9688:	4c 89 30             	mov    %r14,(%rax)
    968b:	48 83 c4 08          	add    $0x8,%rsp
    968f:	5b                   	pop    %rbx
    9690:	41 5e                	pop    %r14
    9692:	c3                   	ret
    9693:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    969a:	84 00 00 00 00 00 

00000000000096a0 <fwp_int_fits>:
    96a0:	41 57                	push   %r15
    96a2:	41 56                	push   %r14
    96a4:	53                   	push   %rbx
    96a5:	31 c0                	xor    %eax,%eax
    96a7:	83 fa 14             	cmp    $0x14,%edx
    96aa:	0f 87 02 01 00 00    	ja     97b2 <fwp_int_fits+0x112>
    96b0:	89 d2                	mov    %edx,%edx
    96b2:	4c 8d 0d ef 4b 00 00 	lea    0x4bef(%rip),%r9        # e2a8 <_IO_stdin_used+0x2a8>
    96b9:	49 63 14 91          	movslq (%r9,%rdx,4),%rdx
    96bd:	4c 01 ca             	add    %r9,%rdx
    96c0:	ff e2                	jmp    *%rdx
    96c2:	48 89 f9             	mov    %rdi,%rcx
    96c5:	48 83 c1 80          	add    $0xffffffffffffff80,%rcx
    96c9:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    96cd:	48 81 f9 00 ff ff ff 	cmp    $0xffffffffffffff00,%rcx
    96d4:	eb 3b                	jmp    9711 <fwp_int_fits+0x71>
    96d6:	48 89 f9             	mov    %rdi,%rcx
    96d9:	48 81 c1 00 00 00 80 	add    $0xffffffff80000000,%rcx
    96e0:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    96e4:	48 ba 00 00 00 00 ff 	movabs $0xffffffff00000000,%rdx
    96eb:	ff ff ff 
    96ee:	48 39 d1             	cmp    %rdx,%rcx
    96f1:	eb 1e                	jmp    9711 <fwp_int_fits+0x71>
    96f3:	31 c0                	xor    %eax,%eax
    96f5:	b9 ff 00 00 00       	mov    $0xff,%ecx
    96fa:	eb 2b                	jmp    9727 <fwp_int_fits+0x87>
    96fc:	48 89 f9             	mov    %rdi,%rcx
    96ff:	48 81 c1 00 80 ff ff 	add    $0xffffffffffff8000,%rcx
    9706:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    970a:	48 81 f9 00 00 ff ff 	cmp    $0xffffffffffff0000,%rcx
    9711:	48 83 de ff          	sbb    $0xffffffffffffffff,%rsi
    9715:	0f 83 8f 00 00 00    	jae    97aa <fwp_int_fits+0x10a>
    971b:	e9 92 00 00 00       	jmp    97b2 <fwp_int_fits+0x112>
    9720:	31 c0                	xor    %eax,%eax
    9722:	b9 ff ff 00 00       	mov    $0xffff,%ecx
    9727:	48 39 f9             	cmp    %rdi,%rcx
    972a:	b9 00 00 00 00       	mov    $0x0,%ecx
    972f:	48 19 f1             	sbb    %rsi,%rcx
    9732:	73 76                	jae    97aa <fwp_int_fits+0x10a>
    9734:	eb 7c                	jmp    97b2 <fwp_int_fits+0x112>
    9736:	48 89 f9             	mov    %rdi,%rcx
    9739:	48 c1 e9 20          	shr    $0x20,%rcx
    973d:	48 09 f1             	or     %rsi,%rcx
    9740:	74 68                	je     97aa <fwp_int_fits+0x10a>
    9742:	eb 6e                	jmp    97b2 <fwp_int_fits+0x112>
    9744:	48 b9 00 00 00 00 00 	movabs $0x8000000000000000,%rcx
    974b:	00 00 80 
    974e:	48 01 f9             	add    %rdi,%rcx
    9751:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    9755:	48 83 fe ff          	cmp    $0xffffffffffffffff,%rsi
    9759:	74 4f                	je     97aa <fwp_int_fits+0x10a>
    975b:	eb 55                	jmp    97b2 <fwp_int_fits+0x112>
    975d:	4c 89 c3             	mov    %r8,%rbx
    9760:	e8 5b 00 00 00       	call   97c0 <fwp_box_i128>
    9765:	49 89 d8             	mov    %rbx,%r8
    9768:	48 89 c7             	mov    %rax,%rdi
    976b:	eb 3d                	jmp    97aa <fwp_int_fits+0x10a>
    976d:	4c 89 c3             	mov    %r8,%rbx
    9770:	49 89 fe             	mov    %rdi,%r14
    9773:	89 cf                	mov    %ecx,%edi
    9775:	49 89 f7             	mov    %rsi,%r15
    9778:	e8 73 00 00 00       	call   97f0 <fwp_tint_max>
    977d:	48 89 c1             	mov    %rax,%rcx
    9780:	31 c0                	xor    %eax,%eax
    9782:	49 89 c8             	mov    %rcx,%r8
    9785:	49 f7 d8             	neg    %r8
    9788:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    978e:	49 19 d1             	sbb    %rdx,%r9
    9791:	4c 39 f1             	cmp    %r14,%rcx
    9794:	4c 19 fa             	sbb    %r15,%rdx
    9797:	7c 19                	jl     97b2 <fwp_int_fits+0x112>
    9799:	4c 89 fe             	mov    %r15,%rsi
    979c:	4c 89 f7             	mov    %r14,%rdi
    979f:	4d 39 c6             	cmp    %r8,%r14
    97a2:	4c 19 ce             	sbb    %r9,%rsi
    97a5:	49 89 d8             	mov    %rbx,%r8
    97a8:	7c 08                	jl     97b2 <fwp_int_fits+0x112>
    97aa:	49 89 38             	mov    %rdi,(%r8)
    97ad:	b8 01 00 00 00       	mov    $0x1,%eax
    97b2:	5b                   	pop    %rbx
    97b3:	41 5e                	pop    %r14
    97b5:	41 5f                	pop    %r15
    97b7:	c3                   	ret
    97b8:	48 85 f6             	test   %rsi,%rsi
    97bb:	74 ed                	je     97aa <fwp_int_fits+0x10a>
    97bd:	eb f3                	jmp    97b2 <fwp_int_fits+0x112>
    97bf:	90                   	nop

00000000000097c0 <fwp_box_i128>:
    97c0:	41 56                	push   %r14
    97c2:	53                   	push   %rbx
    97c3:	50                   	push   %rax
    97c4:	48 89 f3             	mov    %rsi,%rbx
    97c7:	49 89 fe             	mov    %rdi,%r14
    97ca:	bf 10 00 00 00       	mov    $0x10,%edi
    97cf:	e8 7c cf ff ff       	call   6750 <fwp_alloc_leaf>
    97d4:	48 89 58 08          	mov    %rbx,0x8(%rax)
    97d8:	4c 89 30             	mov    %r14,(%rax)
    97db:	48 83 c4 08          	add    $0x8,%rsp
    97df:	5b                   	pop    %rbx
    97e0:	41 5e                	pop    %r14
    97e2:	c3                   	ret
    97e3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    97ea:	84 00 00 00 00 00 

00000000000097f0 <fwp_tint_max>:
    97f0:	85 ff                	test   %edi,%edi
    97f2:	7e 27                	jle    981b <fwp_tint_max+0x2b>
    97f4:	8d 47 ff             	lea    -0x1(%rdi),%eax
    97f7:	83 f8 4f             	cmp    $0x4f,%eax
    97fa:	41 b8 4f 00 00 00    	mov    $0x4f,%r8d
    9800:	44 0f 42 c0          	cmovb  %eax,%r8d
    9804:	41 ff c0             	inc    %r8d
    9807:	44 89 c6             	mov    %r8d,%esi
    980a:	83 e6 07             	and    $0x7,%esi
    980d:	83 ff 08             	cmp    $0x8,%edi
    9810:	73 11                	jae    9823 <fwp_tint_max+0x33>
    9812:	b8 01 00 00 00       	mov    $0x1,%eax
    9817:	31 c9                	xor    %ecx,%ecx
    9819:	eb 38                	jmp    9853 <fwp_tint_max+0x63>
    981b:	31 c0                	xor    %eax,%eax
    981d:	31 c9                	xor    %ecx,%ecx
    981f:	48 89 ca             	mov    %rcx,%rdx
    9822:	c3                   	ret
    9823:	41 81 e0 f8 00 00 00 	and    $0xf8,%r8d
    982a:	b8 01 00 00 00       	mov    $0x1,%eax
    982f:	31 c9                	xor    %ecx,%ecx
    9831:	bf a1 19 00 00       	mov    $0x19a1,%edi
    9836:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    983d:	00 00 00 
    9840:	48 f7 e7             	mul    %rdi
    9843:	48 69 c9 a1 19 00 00 	imul   $0x19a1,%rcx,%rcx
    984a:	48 01 d1             	add    %rdx,%rcx
    984d:	41 83 c0 f8          	add    $0xfffffff8,%r8d
    9851:	75 ed                	jne    9840 <fwp_tint_max+0x50>
    9853:	85 f6                	test   %esi,%esi
    9855:	74 17                	je     986e <fwp_tint_max+0x7e>
    9857:	bf 03 00 00 00       	mov    $0x3,%edi
    985c:	0f 1f 40 00          	nopl   0x0(%rax)
    9860:	48 f7 e7             	mul    %rdi
    9863:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    9867:	48 01 d1             	add    %rdx,%rcx
    986a:	ff ce                	dec    %esi
    986c:	75 f2                	jne    9860 <fwp_tint_max+0x70>
    986e:	48 83 c0 ff          	add    $0xffffffffffffffff,%rax
    9872:	48 83 d1 ff          	adc    $0xffffffffffffffff,%rcx
    9876:	48 89 ca             	mov    %rcx,%rdx
    9879:	48 c1 ea 3f          	shr    $0x3f,%rdx
    987d:	48 01 c2             	add    %rax,%rdx
    9880:	48 89 d0             	mov    %rdx,%rax
    9883:	48 83 d1 00          	adc    $0x0,%rcx
    9887:	48 0f ac c8 01       	shrd   $0x1,%rcx,%rax
    988c:	48 d1 f9             	sar    $1,%rcx
    988f:	48 89 ca             	mov    %rcx,%rdx
    9892:	c3                   	ret
    9893:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    989a:	84 00 00 00 00 00 

00000000000098a0 <fwp_valid_float>:
    98a0:	48 85 f6             	test   %rsi,%rsi
    98a3:	74 0e                	je     98b3 <fwp_valid_float+0x13>
    98a5:	0f b6 07             	movzbl (%rdi),%eax
    98a8:	04 d5                	add    $0xd5,%al
    98aa:	31 d2                	xor    %edx,%edx
    98ac:	a8 fd                	test   $0xfd,%al
    98ae:	0f 94 c2             	sete   %dl
    98b1:	eb 02                	jmp    98b5 <fwp_valid_float+0x15>
    98b3:	31 d2                	xor    %edx,%edx
    98b5:	41 b1 01             	mov    $0x1,%r9b
    98b8:	49 89 d0             	mov    %rdx,%r8
    98bb:	48 39 f2             	cmp    %rsi,%rdx
    98be:	73 1d                	jae    98dd <fwp_valid_float+0x3d>
    98c0:	42 0f b6 04 07       	movzbl (%rdi,%r8,1),%eax
    98c5:	8d 48 d0             	lea    -0x30(%rax),%ecx
    98c8:	80 f9 09             	cmp    $0x9,%cl
    98cb:	77 15                	ja     98e2 <fwp_valid_float+0x42>
    98cd:	49 ff c0             	inc    %r8
    98d0:	4c 39 c6             	cmp    %r8,%rsi
    98d3:	75 eb                	jne    98c0 <fwp_valid_float+0x20>
    98d5:	49 89 f0             	mov    %rsi,%r8
    98d8:	48 89 f1             	mov    %rsi,%rcx
    98db:	eb 38                	jmp    9915 <fwp_valid_float+0x75>
    98dd:	48 89 d1             	mov    %rdx,%rcx
    98e0:	eb 33                	jmp    9915 <fwp_valid_float+0x75>
    98e2:	3c 2e                	cmp    $0x2e,%al
    98e4:	75 2c                	jne    9912 <fwp_valid_float+0x72>
    98e6:	49 8d 48 01          	lea    0x1(%r8),%rcx
    98ea:	48 39 f1             	cmp    %rsi,%rcx
    98ed:	73 16                	jae    9905 <fwp_valid_float+0x65>
    98ef:	90                   	nop
    98f0:	0f b6 04 0f          	movzbl (%rdi,%rcx,1),%eax
    98f4:	04 d0                	add    $0xd0,%al
    98f6:	3c 09                	cmp    $0x9,%al
    98f8:	77 0b                	ja     9905 <fwp_valid_float+0x65>
    98fa:	48 ff c1             	inc    %rcx
    98fd:	48 39 f1             	cmp    %rsi,%rcx
    9900:	72 ee                	jb     98f0 <fwp_valid_float+0x50>
    9902:	48 89 f1             	mov    %rsi,%rcx
    9905:	48 8d 41 ff          	lea    -0x1(%rcx),%rax
    9909:	4c 39 c0             	cmp    %r8,%rax
    990c:	41 0f 94 c1          	sete   %r9b
    9910:	eb 03                	jmp    9915 <fwp_valid_float+0x75>
    9912:	4c 89 c1             	mov    %r8,%rcx
    9915:	31 c0                	xor    %eax,%eax
    9917:	49 39 d0             	cmp    %rdx,%r8
    991a:	75 06                	jne    9922 <fwp_valid_float+0x82>
    991c:	45 84 c9             	test   %r9b,%r9b
    991f:	74 01                	je     9922 <fwp_valid_float+0x82>
    9921:	c3                   	ret
    9922:	48 39 f1             	cmp    %rsi,%rcx
    9925:	73 58                	jae    997f <fwp_valid_float+0xdf>
    9927:	0f b6 14 0f          	movzbl (%rdi,%rcx,1),%edx
    992b:	83 ca 20             	or     $0x20,%edx
    992e:	83 fa 65             	cmp    $0x65,%edx
    9931:	75 4c                	jne    997f <fwp_valid_float+0xdf>
    9933:	48 8d 51 01          	lea    0x1(%rcx),%rdx
    9937:	48 39 f2             	cmp    %rsi,%rdx
    993a:	73 18                	jae    9954 <fwp_valid_float+0xb4>
    993c:	44 0f b6 04 17       	movzbl (%rdi,%rdx,1),%r8d
    9941:	41 83 f8 2d          	cmp    $0x2d,%r8d
    9945:	74 06                	je     994d <fwp_valid_float+0xad>
    9947:	41 83 f8 2b          	cmp    $0x2b,%r8d
    994b:	75 07                	jne    9954 <fwp_valid_float+0xb4>
    994d:	48 83 c1 02          	add    $0x2,%rcx
    9951:	48 89 ca             	mov    %rcx,%rdx
    9954:	48 39 f2             	cmp    %rsi,%rdx
    9957:	73 c8                	jae    9921 <fwp_valid_float+0x81>
    9959:	48 89 d1             	mov    %rdx,%rcx
    995c:	0f 1f 40 00          	nopl   0x0(%rax)
    9960:	44 0f b6 04 0f       	movzbl (%rdi,%rcx,1),%r8d
    9965:	41 80 c0 d0          	add    $0xd0,%r8b
    9969:	41 80 f8 09          	cmp    $0x9,%r8b
    996d:	77 0b                	ja     997a <fwp_valid_float+0xda>
    996f:	48 ff c1             	inc    %rcx
    9972:	48 39 ce             	cmp    %rcx,%rsi
    9975:	75 e9                	jne    9960 <fwp_valid_float+0xc0>
    9977:	48 89 f1             	mov    %rsi,%rcx
    997a:	48 39 d1             	cmp    %rdx,%rcx
    997d:	74 a2                	je     9921 <fwp_valid_float+0x81>
    997f:	31 c0                	xor    %eax,%eax
    9981:	48 39 f1             	cmp    %rsi,%rcx
    9984:	0f 94 c0             	sete   %al
    9987:	c3                   	ret
    9988:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    998f:	00 

0000000000009990 <fwp_float_of>:
    9990:	83 ff 0a             	cmp    $0xa,%edi
    9993:	0f 85 47 90 ff ff    	jne    29e0 <fwp_from_f64>
    9999:	f2 0f 5a c0          	cvtsd2ss %xmm0,%xmm0
    999d:	e9 0e b6 ff ff       	jmp    4fb0 <fwp_from_f32>
    99a2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    99a9:	1f 84 00 00 00 00 00 

00000000000099b0 <fwp_utf8_put>:
    99b0:	50                   	push   %rax
    99b1:	83 fe 7f             	cmp    $0x7f,%esi
    99b4:	77 0f                	ja     99c5 <fwp_utf8_put+0x15>
    99b6:	40 88 74 24 04       	mov    %sil,0x4(%rsp)
    99bb:	ba 01 00 00 00       	mov    $0x1,%edx
    99c0:	e9 8e 00 00 00       	jmp    9a53 <fwp_utf8_put+0xa3>
    99c5:	89 f0                	mov    %esi,%eax
    99c7:	81 fe ff 07 00 00    	cmp    $0x7ff,%esi
    99cd:	77 1d                	ja     99ec <fwp_utf8_put+0x3c>
    99cf:	c1 e8 06             	shr    $0x6,%eax
    99d2:	0c c0                	or     $0xc0,%al
    99d4:	88 44 24 04          	mov    %al,0x4(%rsp)
    99d8:	40 80 e6 3f          	and    $0x3f,%sil
    99dc:	40 80 ce 80          	or     $0x80,%sil
    99e0:	40 88 74 24 05       	mov    %sil,0x5(%rsp)
    99e5:	ba 02 00 00 00       	mov    $0x2,%edx
    99ea:	eb 67                	jmp    9a53 <fwp_utf8_put+0xa3>
    99ec:	81 fe ff ff 00 00    	cmp    $0xffff,%esi
    99f2:	77 2a                	ja     9a1e <fwp_utf8_put+0x6e>
    99f4:	c1 e8 0c             	shr    $0xc,%eax
    99f7:	0c e0                	or     $0xe0,%al
    99f9:	88 44 24 04          	mov    %al,0x4(%rsp)
    99fd:	89 f0                	mov    %esi,%eax
    99ff:	c1 e8 06             	shr    $0x6,%eax
    9a02:	24 3f                	and    $0x3f,%al
    9a04:	0c 80                	or     $0x80,%al
    9a06:	88 44 24 05          	mov    %al,0x5(%rsp)
    9a0a:	40 80 e6 3f          	and    $0x3f,%sil
    9a0e:	40 80 ce 80          	or     $0x80,%sil
    9a12:	40 88 74 24 06       	mov    %sil,0x6(%rsp)
    9a17:	ba 03 00 00 00       	mov    $0x3,%edx
    9a1c:	eb 35                	jmp    9a53 <fwp_utf8_put+0xa3>
    9a1e:	c1 e8 12             	shr    $0x12,%eax
    9a21:	0c f0                	or     $0xf0,%al
    9a23:	88 44 24 04          	mov    %al,0x4(%rsp)
    9a27:	89 f0                	mov    %esi,%eax
    9a29:	c1 e8 0c             	shr    $0xc,%eax
    9a2c:	24 3f                	and    $0x3f,%al
    9a2e:	0c 80                	or     $0x80,%al
    9a30:	88 44 24 05          	mov    %al,0x5(%rsp)
    9a34:	89 f0                	mov    %esi,%eax
    9a36:	c1 e8 06             	shr    $0x6,%eax
    9a39:	24 3f                	and    $0x3f,%al
    9a3b:	0c 80                	or     $0x80,%al
    9a3d:	88 44 24 06          	mov    %al,0x6(%rsp)
    9a41:	40 80 e6 3f          	and    $0x3f,%sil
    9a45:	40 80 ce 80          	or     $0x80,%sil
    9a49:	40 88 74 24 07       	mov    %sil,0x7(%rsp)
    9a4e:	ba 04 00 00 00       	mov    $0x4,%edx
    9a53:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
    9a58:	e8 43 df ff ff       	call   79a0 <buf_put>
    9a5d:	58                   	pop    %rax
    9a5e:	c3                   	ret
    9a5f:	90                   	nop

0000000000009a60 <tp_push>:
    9a60:	41 56                	push   %r14
    9a62:	53                   	push   %rbx
    9a63:	50                   	push   %rax
    9a64:	48 89 f3             	mov    %rsi,%rbx
    9a67:	49 89 fe             	mov    %rdi,%r14
    9a6a:	48 8b 77 18          	mov    0x18(%rdi),%rsi
    9a6e:	48 3b 77 20          	cmp    0x20(%rdi),%rsi
    9a72:	75 2f                	jne    9aa3 <tp_push+0x43>
    9a74:	48 8d 04 36          	lea    (%rsi,%rsi,1),%rax
    9a78:	48 85 f6             	test   %rsi,%rsi
    9a7b:	ba 08 00 00 00       	mov    $0x8,%edx
    9a80:	48 0f 45 d0          	cmovne %rax,%rdx
    9a84:	49 89 56 20          	mov    %rdx,0x20(%r14)
    9a88:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    9a8c:	48 c1 e6 03          	shl    $0x3,%rsi
    9a90:	48 c1 e2 03          	shl    $0x3,%rdx
    9a94:	e8 07 dc ff ff       	call   76a0 <fwp_mem_realloc>
    9a99:	49 89 46 10          	mov    %rax,0x10(%r14)
    9a9d:	49 8b 76 18          	mov    0x18(%r14),%rsi
    9aa1:	eb 04                	jmp    9aa7 <tp_push+0x47>
    9aa3:	49 8b 46 10          	mov    0x10(%r14),%rax
    9aa7:	48 8d 4e 01          	lea    0x1(%rsi),%rcx
    9aab:	49 89 4e 18          	mov    %rcx,0x18(%r14)
    9aaf:	48 89 1c f0          	mov    %rbx,(%rax,%rsi,8)
    9ab3:	48 83 c4 08          	add    $0x8,%rsp
    9ab7:	5b                   	pop    %rbx
    9ab8:	41 5e                	pop    %r14
    9aba:	c3                   	ret
    9abb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000009ac0 <tp_is_delim>:
    9ac0:	b8 01 00 00 00       	mov    $0x1,%eax
    9ac5:	83 ff 2c             	cmp    $0x2c,%edi
    9ac8:	77 13                	ja     9add <tp_is_delim+0x1d>
    9aca:	89 f9                	mov    %edi,%ecx
    9acc:	48 ba 00 26 00 00 01 	movabs $0x130100002600,%rdx
    9ad3:	13 00 00 
    9ad6:	48 0f a3 ca          	bt     %rcx,%rdx
    9ada:	73 01                	jae    9add <tp_is_delim+0x1d>
    9adc:	c3                   	ret
    9add:	83 ff 5d             	cmp    $0x5d,%edi
    9ae0:	74 fa                	je     9adc <tp_is_delim+0x1c>
    9ae2:	83 ff 7d             	cmp    $0x7d,%edi
    9ae5:	74 f5                	je     9adc <tp_is_delim+0x1c>
    9ae7:	31 c0                	xor    %eax,%eax
    9ae9:	40 80 ff 3a          	cmp    $0x3a,%dil
    9aed:	0f 94 c0             	sete   %al
    9af0:	c3                   	ret
    9af1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9af8:	0f 1f 84 00 00 00 00 
    9aff:	00 

0000000000009b00 <fwp_list_len>:
    9b00:	31 c0                	xor    %eax,%eax
    9b02:	48 85 ff             	test   %rdi,%rdi
    9b05:	74 15                	je     9b1c <fwp_list_len+0x1c>
    9b07:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    9b0e:	00 00 
    9b10:	48 ff c0             	inc    %rax
    9b13:	48 8b 7f 10          	mov    0x10(%rdi),%rdi
    9b17:	48 85 ff             	test   %rdi,%rdi
    9b1a:	75 f4                	jne    9b10 <fwp_list_len+0x10>
    9b1c:	c3                   	ret
    9b1d:	0f 1f 00             	nopl   (%rax)

0000000000009b20 <fwp_map_find>:
    9b20:	55                   	push   %rbp
    9b21:	41 57                	push   %r15
    9b23:	41 56                	push   %r14
    9b25:	41 55                	push   %r13
    9b27:	41 54                	push   %r12
    9b29:	53                   	push   %rbx
    9b2a:	50                   	push   %rax
    9b2b:	49 89 f6             	mov    %rsi,%r14
    9b2e:	49 89 ff             	mov    %rdi,%r15
    9b31:	48 8b 2f             	mov    (%rdi),%rbp
    9b34:	8b 02                	mov    (%rdx),%eax
    9b36:	83 f8 04             	cmp    $0x4,%eax
    9b39:	72 53                	jb     9b8e <fwp_map_find+0x6e>
    9b3b:	83 c0 fb             	add    $0xfffffffb,%eax
    9b3e:	83 f8 04             	cmp    $0x4,%eax
    9b41:	0f 83 a3 00 00 00    	jae    9bea <fwp_map_find+0xca>
    9b47:	48 85 ed             	test   %rbp,%rbp
    9b4a:	0f 84 f7 00 00 00    	je     9c47 <fwp_map_find+0x127>
    9b50:	31 f6                	xor    %esi,%esi
    9b52:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    9b59:	ff ff 1f 
    9b5c:	eb 0a                	jmp    9b68 <fwp_map_find+0x48>
    9b5e:	66 90                	xchg   %ax,%ax
    9b60:	4c 89 e5             	mov    %r12,%rbp
    9b63:	48 39 ee             	cmp    %rbp,%rsi
    9b66:	73 74                	jae    9bdc <fwp_map_find+0xbc>
    9b68:	48 8d 14 2e          	lea    (%rsi,%rbp,1),%rdx
    9b6c:	49 89 d4             	mov    %rdx,%r12
    9b6f:	49 d1 ec             	shr    $1,%r12
    9b72:	48 21 c2             	and    %rax,%rdx
    9b75:	49 8b 54 d7 08       	mov    0x8(%r15,%rdx,8),%rdx
    9b7a:	4c 39 f2             	cmp    %r14,%rdx
    9b7d:	74 64                	je     9be3 <fwp_map_find+0xc3>
    9b7f:	73 df                	jae    9b60 <fwp_map_find+0x40>
    9b81:	49 ff c4             	inc    %r12
    9b84:	4c 89 e6             	mov    %r12,%rsi
    9b87:	48 39 ee             	cmp    %rbp,%rsi
    9b8a:	72 dc                	jb     9b68 <fwp_map_find+0x48>
    9b8c:	eb 4e                	jmp    9bdc <fwp_map_find+0xbc>
    9b8e:	48 85 ed             	test   %rbp,%rbp
    9b91:	0f 84 b0 00 00 00    	je     9c47 <fwp_map_find+0x127>
    9b97:	31 f6                	xor    %esi,%esi
    9b99:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    9ba0:	ff ff 1f 
    9ba3:	eb 13                	jmp    9bb8 <fwp_map_find+0x98>
    9ba5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    9bac:	00 00 00 00 
    9bb0:	4c 89 e5             	mov    %r12,%rbp
    9bb3:	48 39 ee             	cmp    %rbp,%rsi
    9bb6:	73 24                	jae    9bdc <fwp_map_find+0xbc>
    9bb8:	48 8d 14 2e          	lea    (%rsi,%rbp,1),%rdx
    9bbc:	49 89 d4             	mov    %rdx,%r12
    9bbf:	49 d1 ec             	shr    $1,%r12
    9bc2:	48 21 c2             	and    %rax,%rdx
    9bc5:	49 8b 54 d7 08       	mov    0x8(%r15,%rdx,8),%rdx
    9bca:	4c 39 f2             	cmp    %r14,%rdx
    9bcd:	74 14                	je     9be3 <fwp_map_find+0xc3>
    9bcf:	7d df                	jge    9bb0 <fwp_map_find+0x90>
    9bd1:	49 ff c4             	inc    %r12
    9bd4:	4c 89 e6             	mov    %r12,%rsi
    9bd7:	48 39 ee             	cmp    %rbp,%rsi
    9bda:	72 dc                	jb     9bb8 <fwp_map_find+0x98>
    9bdc:	31 c0                	xor    %eax,%eax
    9bde:	49 89 f4             	mov    %rsi,%r12
    9be1:	eb 69                	jmp    9c4c <fwp_map_find+0x12c>
    9be3:	b8 01 00 00 00       	mov    $0x1,%eax
    9be8:	eb 62                	jmp    9c4c <fwp_map_find+0x12c>
    9bea:	48 85 ed             	test   %rbp,%rbp
    9bed:	74 58                	je     9c47 <fwp_map_find+0x127>
    9bef:	49 89 d5             	mov    %rdx,%r13
    9bf2:	48 89 0c 24          	mov    %rcx,(%rsp)
    9bf6:	31 db                	xor    %ebx,%ebx
    9bf8:	eb 0e                	jmp    9c08 <fwp_map_find+0xe8>
    9bfa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9c00:	4c 89 e5             	mov    %r12,%rbp
    9c03:	48 39 eb             	cmp    %rbp,%rbx
    9c06:	73 38                	jae    9c40 <fwp_map_find+0x120>
    9c08:	48 8d 04 2b          	lea    (%rbx,%rbp,1),%rax
    9c0c:	49 89 c4             	mov    %rax,%r12
    9c0f:	49 d1 ec             	shr    $1,%r12
    9c12:	48 b9 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rcx
    9c19:	ff ff 1f 
    9c1c:	48 21 c8             	and    %rcx,%rax
    9c1f:	49 8b 7c c7 08       	mov    0x8(%r15,%rax,8),%rdi
    9c24:	4c 89 f6             	mov    %r14,%rsi
    9c27:	4c 89 ea             	mov    %r13,%rdx
    9c2a:	e8 61 00 00 00       	call   9c90 <fwp_cmp>
    9c2f:	85 c0                	test   %eax,%eax
    9c31:	74 2d                	je     9c60 <fwp_map_find+0x140>
    9c33:	79 cb                	jns    9c00 <fwp_map_find+0xe0>
    9c35:	49 ff c4             	inc    %r12
    9c38:	4c 89 e3             	mov    %r12,%rbx
    9c3b:	48 39 eb             	cmp    %rbp,%rbx
    9c3e:	72 c8                	jb     9c08 <fwp_map_find+0xe8>
    9c40:	31 c0                	xor    %eax,%eax
    9c42:	49 89 dc             	mov    %rbx,%r12
    9c45:	eb 1e                	jmp    9c65 <fwp_map_find+0x145>
    9c47:	31 c0                	xor    %eax,%eax
    9c49:	45 31 e4             	xor    %r12d,%r12d
    9c4c:	89 01                	mov    %eax,(%rcx)
    9c4e:	4c 89 e0             	mov    %r12,%rax
    9c51:	48 83 c4 08          	add    $0x8,%rsp
    9c55:	5b                   	pop    %rbx
    9c56:	41 5c                	pop    %r12
    9c58:	41 5d                	pop    %r13
    9c5a:	41 5e                	pop    %r14
    9c5c:	41 5f                	pop    %r15
    9c5e:	5d                   	pop    %rbp
    9c5f:	c3                   	ret
    9c60:	b8 01 00 00 00       	mov    $0x1,%eax
    9c65:	48 8b 0c 24          	mov    (%rsp),%rcx
    9c69:	eb e1                	jmp    9c4c <fwp_map_find+0x12c>
    9c6b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000009c70 <fwp_map_alloc>:
    9c70:	53                   	push   %rbx
    9c71:	48 89 fb             	mov    %rdi,%rbx
    9c74:	48 c1 e7 04          	shl    $0x4,%rdi
    9c78:	48 83 cf 08          	or     $0x8,%rdi
    9c7c:	e8 9f ba ff ff       	call   5720 <fwp_alloc>
    9c81:	48 89 18             	mov    %rbx,(%rax)
    9c84:	5b                   	pop    %rbx
    9c85:	c3                   	ret
    9c86:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    9c8d:	00 00 00 

0000000000009c90 <fwp_cmp>:
    9c90:	55                   	push   %rbp
    9c91:	41 57                	push   %r15
    9c93:	41 56                	push   %r14
    9c95:	41 55                	push   %r13
    9c97:	41 54                	push   %r12
    9c99:	53                   	push   %rbx
    9c9a:	48 83 ec 18          	sub    $0x18,%rsp
    9c9e:	48 89 f3             	mov    %rsi,%rbx
    9ca1:	49 89 fe             	mov    %rdi,%r14
    9ca4:	44 8b 2a             	mov    (%rdx),%r13d
    9ca7:	49 83 fd 15          	cmp    $0x15,%r13
    9cab:	77 25                	ja     9cd2 <fwp_cmp+0x42>
    9cad:	49 89 d7             	mov    %rdx,%r15
    9cb0:	48 8d 05 45 46 00 00 	lea    0x4645(%rip),%rax        # e2fc <_IO_stdin_used+0x2fc>
    9cb7:	4a 63 0c a8          	movslq (%rax,%r13,4),%rcx
    9cbb:	48 01 c1             	add    %rax,%rcx
    9cbe:	ff e1                	jmp    *%rcx
    9cc0:	31 c9                	xor    %ecx,%ecx
    9cc2:	49 39 de             	cmp    %rbx,%r14
    9cc5:	0f 9f c1             	setg   %cl
    9cc8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9ccd:	0f 4d c1             	cmovge %ecx,%eax
    9cd0:	eb 10                	jmp    9ce2 <fwp_cmp+0x52>
    9cd2:	31 c9                	xor    %ecx,%ecx
    9cd4:	49 39 de             	cmp    %rbx,%r14
    9cd7:	0f 97 c1             	seta   %cl
    9cda:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9cdf:	0f 43 c1             	cmovae %ecx,%eax
    9ce2:	48 83 c4 18          	add    $0x18,%rsp
    9ce6:	5b                   	pop    %rbx
    9ce7:	41 5c                	pop    %r12
    9ce9:	41 5d                	pop    %r13
    9ceb:	41 5e                	pop    %r14
    9ced:	41 5f                	pop    %r15
    9cef:	5d                   	pop    %rbp
    9cf0:	c3                   	ret
    9cf1:	4d 8b 3e             	mov    (%r14),%r15
    9cf4:	4c 8b 23             	mov    (%rbx),%r12
    9cf7:	49 83 c6 08          	add    $0x8,%r14
    9cfb:	48 83 c3 08          	add    $0x8,%rbx
    9cff:	4d 39 e7             	cmp    %r12,%r15
    9d02:	4c 89 e2             	mov    %r12,%rdx
    9d05:	49 0f 42 d7          	cmovb  %r15,%rdx
    9d09:	4c 89 f7             	mov    %r14,%rdi
    9d0c:	48 89 de             	mov    %rbx,%rsi
    9d0f:	e8 4c 85 ff ff       	call   2260 <memcmp@plt>
    9d14:	85 c0                	test   %eax,%eax
    9d16:	0f 84 ce 02 00 00    	je     9fea <fwp_cmp+0x35a>
    9d1c:	c1 f8 1f             	sar    $0x1f,%eax
    9d1f:	83 c8 01             	or     $0x1,%eax
    9d22:	eb be                	jmp    9ce2 <fwp_cmp+0x52>
    9d24:	49 8b 06             	mov    (%r14),%rax
    9d27:	48 8b 2b             	mov    (%rbx),%rbp
    9d2a:	48 39 e8             	cmp    %rbp,%rax
    9d2d:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    9d32:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    9d37:	48 0f 42 e8          	cmovb  %rax,%rbp
    9d3b:	48 85 ed             	test   %rbp,%rbp
    9d3e:	74 54                	je     9d94 <fwp_cmp+0x104>
    9d40:	49 8b 47 38          	mov    0x38(%r15),%rax
    9d44:	48 89 04 24          	mov    %rax,(%rsp)
    9d48:	41 bc 10 00 00 00    	mov    $0x10,%r12d
    9d4e:	eb 09                	jmp    9d59 <fwp_cmp+0xc9>
    9d50:	49 83 c4 10          	add    $0x10,%r12
    9d54:	48 ff cd             	dec    %rbp
    9d57:	74 3b                	je     9d94 <fwp_cmp+0x104>
    9d59:	4b 8b 7c 26 f8       	mov    -0x8(%r14,%r12,1),%rdi
    9d5e:	4a 8b 74 23 f8       	mov    -0x8(%rbx,%r12,1),%rsi
    9d63:	48 8b 14 24          	mov    (%rsp),%rdx
    9d67:	e8 24 ff ff ff       	call   9c90 <fwp_cmp>
    9d6c:	85 c0                	test   %eax,%eax
    9d6e:	0f 85 6e ff ff ff    	jne    9ce2 <fwp_cmp+0x52>
    9d74:	41 83 fd 12          	cmp    $0x12,%r13d
    9d78:	75 d6                	jne    9d50 <fwp_cmp+0xc0>
    9d7a:	4b 8b 3c 26          	mov    (%r14,%r12,1),%rdi
    9d7e:	4a 8b 34 23          	mov    (%rbx,%r12,1),%rsi
    9d82:	49 8b 57 40          	mov    0x40(%r15),%rdx
    9d86:	e8 05 ff ff ff       	call   9c90 <fwp_cmp>
    9d8b:	85 c0                	test   %eax,%eax
    9d8d:	74 c1                	je     9d50 <fwp_cmp+0xc0>
    9d8f:	e9 4e ff ff ff       	jmp    9ce2 <fwp_cmp+0x52>
    9d94:	31 c9                	xor    %ecx,%ecx
    9d96:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    9d9b:	48 39 44 24 10       	cmp    %rax,0x10(%rsp)
    9da0:	e9 32 ff ff ff       	jmp    9cd7 <fwp_cmp+0x47>
    9da5:	4c 89 f7             	mov    %r14,%rdi
    9da8:	e8 73 02 00 00       	call   a020 <fwp_u128>
    9dad:	49 89 c7             	mov    %rax,%r15
    9db0:	49 89 d6             	mov    %rdx,%r14
    9db3:	48 89 df             	mov    %rbx,%rdi
    9db6:	e8 65 02 00 00       	call   a020 <fwp_u128>
    9dbb:	48 89 c1             	mov    %rax,%rcx
    9dbe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9dc3:	49 39 cf             	cmp    %rcx,%r15
    9dc6:	4c 89 f6             	mov    %r14,%rsi
    9dc9:	48 19 d6             	sbb    %rdx,%rsi
    9dcc:	0f 82 10 ff ff ff    	jb     9ce2 <fwp_cmp+0x52>
    9dd2:	4c 39 f9             	cmp    %r15,%rcx
    9dd5:	4c 19 f2             	sbb    %r14,%rdx
    9dd8:	0f 92 c0             	setb   %al
    9ddb:	0f b6 c0             	movzbl %al,%eax
    9dde:	e9 ff fe ff ff       	jmp    9ce2 <fwp_cmp+0x52>
    9de3:	4c 89 f7             	mov    %r14,%rdi
    9de6:	e8 b5 b1 ff ff       	call   4fa0 <fwp_f32>
    9deb:	e8 40 02 00 00       	call   a030 <fwp_total_key32>
    9df0:	89 c5                	mov    %eax,%ebp
    9df2:	48 89 df             	mov    %rbx,%rdi
    9df5:	e8 a6 b1 ff ff       	call   4fa0 <fwp_f32>
    9dfa:	e8 31 02 00 00       	call   a030 <fwp_total_key32>
    9dff:	89 c1                	mov    %eax,%ecx
    9e01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9e06:	39 cd                	cmp    %ecx,%ebp
    9e08:	0f 8c d4 fe ff ff    	jl     9ce2 <fwp_cmp+0x52>
    9e0e:	eb 2e                	jmp    9e3e <fwp_cmp+0x1ae>
    9e10:	4c 89 f7             	mov    %r14,%rdi
    9e13:	e8 f8 91 ff ff       	call   3010 <fwp_f64>
    9e18:	e8 23 02 00 00       	call   a040 <fwp_total_key64>
    9e1d:	49 89 c6             	mov    %rax,%r14
    9e20:	48 89 df             	mov    %rbx,%rdi
    9e23:	e8 e8 91 ff ff       	call   3010 <fwp_f64>
    9e28:	e8 13 02 00 00       	call   a040 <fwp_total_key64>
    9e2d:	48 89 c1             	mov    %rax,%rcx
    9e30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9e35:	49 39 ce             	cmp    %rcx,%r14
    9e38:	0f 8c a4 fe ff ff    	jl     9ce2 <fwp_cmp+0x52>
    9e3e:	0f 9f c0             	setg   %al
    9e41:	0f b6 c0             	movzbl %al,%eax
    9e44:	e9 99 fe ff ff       	jmp    9ce2 <fwp_cmp+0x52>
    9e49:	4c 89 f7             	mov    %r14,%rdi
    9e4c:	e8 bf 01 00 00       	call   a010 <fwp_i128>
    9e51:	49 89 c7             	mov    %rax,%r15
    9e54:	49 89 d6             	mov    %rdx,%r14
    9e57:	48 89 df             	mov    %rbx,%rdi
    9e5a:	e8 b1 01 00 00       	call   a010 <fwp_i128>
    9e5f:	48 89 c1             	mov    %rax,%rcx
    9e62:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9e67:	49 39 cf             	cmp    %rcx,%r15
    9e6a:	4c 89 f6             	mov    %r14,%rsi
    9e6d:	48 19 d6             	sbb    %rdx,%rsi
    9e70:	0f 8c 6c fe ff ff    	jl     9ce2 <fwp_cmp+0x52>
    9e76:	4c 39 f9             	cmp    %r15,%rcx
    9e79:	4c 19 f2             	sbb    %r14,%rdx
    9e7c:	0f 9c c0             	setl   %al
    9e7f:	0f b6 c0             	movzbl %al,%eax
    9e82:	e9 5b fe ff ff       	jmp    9ce2 <fwp_cmp+0x52>
    9e87:	4d 85 f6             	test   %r14,%r14
    9e8a:	0f 94 c0             	sete   %al
    9e8d:	74 3e                	je     9ecd <fwp_cmp+0x23d>
    9e8f:	48 85 db             	test   %rbx,%rbx
    9e92:	74 39                	je     9ecd <fwp_cmp+0x23d>
    9e94:	4d 8b 7f 38          	mov    0x38(%r15),%r15
    9e98:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    9e9f:	00 
    9ea0:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    9ea4:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    9ea8:	4c 89 fa             	mov    %r15,%rdx
    9eab:	e8 e0 fd ff ff       	call   9c90 <fwp_cmp>
    9eb0:	85 c0                	test   %eax,%eax
    9eb2:	0f 85 2a fe ff ff    	jne    9ce2 <fwp_cmp+0x52>
    9eb8:	4d 8b 76 10          	mov    0x10(%r14),%r14
    9ebc:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    9ec0:	4d 85 f6             	test   %r14,%r14
    9ec3:	0f 94 c0             	sete   %al
    9ec6:	74 05                	je     9ecd <fwp_cmp+0x23d>
    9ec8:	48 85 db             	test   %rbx,%rbx
    9ecb:	75 d3                	jne    9ea0 <fwp_cmp+0x210>
    9ecd:	48 85 db             	test   %rbx,%rbx
    9ed0:	0f 95 c1             	setne  %cl
    9ed3:	08 c1                	or     %al,%cl
    9ed5:	80 f1 01             	xor    $0x1,%cl
    9ed8:	0f b6 c9             	movzbl %cl,%ecx
    9edb:	84 c0                	test   %al,%al
    9edd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9ee2:	0f 44 c1             	cmove  %ecx,%eax
    9ee5:	48 85 db             	test   %rbx,%rbx
    9ee8:	0f 44 c1             	cmove  %ecx,%eax
    9eeb:	e9 f2 fd ff ff       	jmp    9ce2 <fwp_cmp+0x52>
    9ef0:	45 8b 67 10          	mov    0x10(%r15),%r12d
    9ef4:	45 85 e4             	test   %r12d,%r12d
    9ef7:	0f 8e f7 00 00 00    	jle    9ff4 <fwp_cmp+0x364>
    9efd:	4d 8b 7f 20          	mov    0x20(%r15),%r15
    9f01:	45 31 ed             	xor    %r13d,%r13d
    9f04:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    9f0b:	00 00 00 00 00 
    9f10:	4b 8b 7c ee 08       	mov    0x8(%r14,%r13,8),%rdi
    9f15:	4a 8b 74 eb 08       	mov    0x8(%rbx,%r13,8),%rsi
    9f1a:	4b 8b 14 ef          	mov    (%r15,%r13,8),%rdx
    9f1e:	e8 6d fd ff ff       	call   9c90 <fwp_cmp>
    9f23:	85 c0                	test   %eax,%eax
    9f25:	0f 85 b7 fd ff ff    	jne    9ce2 <fwp_cmp+0x52>
    9f2b:	49 ff c5             	inc    %r13
    9f2e:	31 c0                	xor    %eax,%eax
    9f30:	4d 39 ec             	cmp    %r13,%r12
    9f33:	75 db                	jne    9f10 <fwp_cmp+0x280>
    9f35:	e9 a8 fd ff ff       	jmp    9ce2 <fwp_cmp+0x52>
    9f3a:	49 8b 06             	mov    (%r14),%rax
    9f3d:	4c 8b 2b             	mov    (%rbx),%r13
    9f40:	4c 39 e8             	cmp    %r13,%rax
    9f43:	4c 89 ed             	mov    %r13,%rbp
    9f46:	48 89 04 24          	mov    %rax,(%rsp)
    9f4a:	48 0f 42 e8          	cmovb  %rax,%rbp
    9f4e:	48 85 ed             	test   %rbp,%rbp
    9f51:	74 2f                	je     9f82 <fwp_cmp+0x2f2>
    9f53:	4d 8b 7f 38          	mov    0x38(%r15),%r15
    9f57:	45 31 e4             	xor    %r12d,%r12d
    9f5a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9f60:	4b 8b 7c e6 08       	mov    0x8(%r14,%r12,8),%rdi
    9f65:	4a 8b 74 e3 08       	mov    0x8(%rbx,%r12,8),%rsi
    9f6a:	4c 89 fa             	mov    %r15,%rdx
    9f6d:	e8 1e fd ff ff       	call   9c90 <fwp_cmp>
    9f72:	85 c0                	test   %eax,%eax
    9f74:	0f 85 68 fd ff ff    	jne    9ce2 <fwp_cmp+0x52>
    9f7a:	49 ff c4             	inc    %r12
    9f7d:	4c 39 e5             	cmp    %r12,%rbp
    9f80:	75 de                	jne    9f60 <fwp_cmp+0x2d0>
    9f82:	31 c9                	xor    %ecx,%ecx
    9f84:	4c 39 2c 24          	cmp    %r13,(%rsp)
    9f88:	e9 4a fd ff ff       	jmp    9cd7 <fwp_cmp+0x47>
    9f8d:	4c 89 f7             	mov    %r14,%rdi
    9f90:	e8 cb 00 00 00       	call   a060 <fwp_tag>
    9f95:	89 c5                	mov    %eax,%ebp
    9f97:	48 89 df             	mov    %rbx,%rdi
    9f9a:	e8 c1 00 00 00       	call   a060 <fwp_tag>
    9f9f:	39 c5                	cmp    %eax,%ebp
    9fa1:	75 58                	jne    9ffb <fwp_cmp+0x36b>
    9fa3:	49 8b 4f 28          	mov    0x28(%r15),%rcx
    9fa7:	89 e8                	mov    %ebp,%eax
    9fa9:	44 8b 24 81          	mov    (%rcx,%rax,4),%r12d
    9fad:	45 85 e4             	test   %r12d,%r12d
    9fb0:	7e 42                	jle    9ff4 <fwp_cmp+0x364>
    9fb2:	49 8b 4f 30          	mov    0x30(%r15),%rcx
    9fb6:	4c 8b 3c c1          	mov    (%rcx,%rax,8),%r15
    9fba:	45 31 ed             	xor    %r13d,%r13d
    9fbd:	0f 1f 00             	nopl   (%rax)
    9fc0:	4b 8b 7c ee 08       	mov    0x8(%r14,%r13,8),%rdi
    9fc5:	4a 8b 74 eb 08       	mov    0x8(%rbx,%r13,8),%rsi
    9fca:	4b 8b 14 ef          	mov    (%r15,%r13,8),%rdx
    9fce:	e8 bd fc ff ff       	call   9c90 <fwp_cmp>
    9fd3:	85 c0                	test   %eax,%eax
    9fd5:	0f 85 07 fd ff ff    	jne    9ce2 <fwp_cmp+0x52>
    9fdb:	49 ff c5             	inc    %r13
    9fde:	31 c0                	xor    %eax,%eax
    9fe0:	4d 39 ec             	cmp    %r13,%r12
    9fe3:	75 db                	jne    9fc0 <fwp_cmp+0x330>
    9fe5:	e9 f8 fc ff ff       	jmp    9ce2 <fwp_cmp+0x52>
    9fea:	31 c9                	xor    %ecx,%ecx
    9fec:	4d 39 e7             	cmp    %r12,%r15
    9fef:	e9 e3 fc ff ff       	jmp    9cd7 <fwp_cmp+0x47>
    9ff4:	31 c0                	xor    %eax,%eax
    9ff6:	e9 e7 fc ff ff       	jmp    9ce2 <fwp_cmp+0x52>
    9ffb:	0f 97 c0             	seta   %al
    9ffe:	0f b6 c8             	movzbl %al,%ecx
    a001:	e9 d4 fc ff ff       	jmp    9cda <fwp_cmp+0x4a>
    a006:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    a00d:	00 00 00 

000000000000a010 <fwp_i128>:
    a010:	48 8b 07             	mov    (%rdi),%rax
    a013:	48 8b 57 08          	mov    0x8(%rdi),%rdx
    a017:	c3                   	ret
    a018:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a01f:	00 

000000000000a020 <fwp_u128>:
    a020:	48 8b 07             	mov    (%rdi),%rax
    a023:	48 8b 57 08          	mov    0x8(%rdi),%rdx
    a027:	c3                   	ret
    a028:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a02f:	00 

000000000000a030 <fwp_total_key32>:
    a030:	66 0f 7e c1          	movd   %xmm0,%ecx
    a034:	89 c8                	mov    %ecx,%eax
    a036:	c1 f8 1f             	sar    $0x1f,%eax
    a039:	d1 e8                	shr    $1,%eax
    a03b:	31 c8                	xor    %ecx,%eax
    a03d:	c3                   	ret
    a03e:	66 90                	xchg   %ax,%ax

000000000000a040 <fwp_total_key64>:
    a040:	66 48 0f 7e c1       	movq   %xmm0,%rcx
    a045:	48 89 c8             	mov    %rcx,%rax
    a048:	48 c1 f8 3f          	sar    $0x3f,%rax
    a04c:	48 d1 e8             	shr    $1,%rax
    a04f:	48 31 c8             	xor    %rcx,%rax
    a052:	c3                   	ret
    a053:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a05a:	84 00 00 00 00 00 

000000000000a060 <fwp_tag>:
    a060:	48 89 f8             	mov    %rdi,%rax
    a063:	48 81 ff ff 0f 00 00 	cmp    $0xfff,%rdi
    a06a:	76 02                	jbe    a06e <fwp_tag+0xe>
    a06c:	8b 00                	mov    (%rax),%eax
    a06e:	c3                   	ret
    a06f:	90                   	nop

000000000000a070 <fwp_transport_off>:
    a070:	50                   	push   %rax
    a071:	48 8d 3d 6f 52 00 00 	lea    0x526f(%rip),%rdi        # f2e7 <exec_in_fp0+0xc87>
    a078:	e8 b3 7f ff ff       	call   2030 <getenv@plt>
    a07d:	48 85 c0             	test   %rax,%rax
    a080:	74 1a                	je     a09c <fwp_transport_off+0x2c>
    a082:	48 8d 35 6c 52 00 00 	lea    0x526c(%rip),%rsi        # f2f5 <exec_in_fp0+0xc95>
    a089:	48 89 c7             	mov    %rax,%rdi
    a08c:	e8 2f 82 ff ff       	call   22c0 <strcmp@plt>
    a091:	89 c1                	mov    %eax,%ecx
    a093:	31 c0                	xor    %eax,%eax
    a095:	85 c9                	test   %ecx,%ecx
    a097:	0f 94 c0             	sete   %al
    a09a:	59                   	pop    %rcx
    a09b:	c3                   	ret
    a09c:	31 c0                	xor    %eax,%eax
    a09e:	59                   	pop    %rcx
    a09f:	c3                   	ret

000000000000a0a0 <fwp_pipe_addr>:
    a0a0:	50                   	push   %rax
    a0a1:	0f 57 c0             	xorps  %xmm0,%xmm0
    a0a4:	0f 11 47 5e          	movups %xmm0,0x5e(%rdi)
    a0a8:	0f 11 47 52          	movups %xmm0,0x52(%rdi)
    a0ac:	0f 11 47 42          	movups %xmm0,0x42(%rdi)
    a0b0:	0f 11 47 32          	movups %xmm0,0x32(%rdi)
    a0b4:	0f 11 47 22          	movups %xmm0,0x22(%rdi)
    a0b8:	0f 11 47 12          	movups %xmm0,0x12(%rdi)
    a0bc:	0f 11 47 02          	movups %xmm0,0x2(%rdi)
    a0c0:	66 c7 07 01 00       	movw   $0x1,(%rdi)
    a0c5:	48 83 c7 03          	add    $0x3,%rdi
    a0c9:	48 8b 0e             	mov    (%rsi),%rcx
    a0cc:	4c 8b 46 08          	mov    0x8(%rsi),%r8
    a0d0:	48 8d 15 24 52 00 00 	lea    0x5224(%rip),%rdx        # f2fb <exec_in_fp0+0xc9b>
    a0d7:	be 6b 00 00 00       	mov    $0x6b,%esi
    a0dc:	31 c0                	xor    %eax,%eax
    a0de:	e8 dd 80 ff ff       	call   21c0 <snprintf@plt>
    a0e3:	83 c0 03             	add    $0x3,%eax
    a0e6:	59                   	pop    %rcx
    a0e7:	c3                   	ret
    a0e8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a0ef:	00 

000000000000a0f0 <fwp_now_ns>:
    a0f0:	48 83 ec 18          	sub    $0x18,%rsp
    a0f4:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    a0f9:	bf 01 00 00 00       	mov    $0x1,%edi
    a0fe:	e8 1d 80 ff ff       	call   2120 <clock_gettime@plt>
    a103:	48 69 44 24 08 00 ca 	imul   $0x3b9aca00,0x8(%rsp),%rax
    a10a:	9a 3b 
    a10c:	48 03 44 24 10       	add    0x10(%rsp),%rax
    a111:	48 83 c4 18          	add    $0x18,%rsp
    a115:	c3                   	ret
    a116:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    a11d:	00 00 00 

000000000000a120 <fwp_ring_put>:
    a120:	55                   	push   %rbp
    a121:	41 57                	push   %r15
    a123:	41 56                	push   %r14
    a125:	41 55                	push   %r13
    a127:	41 54                	push   %r12
    a129:	53                   	push   %rbx
    a12a:	48 83 ec 38          	sub    $0x38,%rsp
    a12e:	48 89 3c 24          	mov    %rdi,(%rsp)
    a132:	48 85 f6             	test   %rsi,%rsi
    a135:	0f 84 27 01 00 00    	je     a262 <fwp_ring_put+0x142>
    a13b:	f6 05 16 bd 02 00 01 	testb  $0x1,0x2bd16(%rip)        # 35e58 <fwp_po_gone>
    a142:	0f 85 1a 01 00 00    	jne    a262 <fwp_ring_put+0x142>
    a148:	48 89 f3             	mov    %rsi,%rbx
    a14b:	4c 8b 3d fe bc 02 00 	mov    0x2bcfe(%rip),%r15        # 35e50 <fwp_po_ring>
    a152:	49 8d 87 00 10 00 00 	lea    0x1000(%r15),%rax
    a159:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    a15e:	49 8d 87 c0 00 00 00 	lea    0xc0(%r15),%rax
    a165:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    a16a:	49 8d 87 c4 00 00 00 	lea    0xc4(%r15),%rax
    a171:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    a176:	49 8d 87 00 01 00 00 	lea    0x100(%r15),%rax
    a17d:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    a182:	49 8d 87 04 01 00 00 	lea    0x104(%r15),%rax
    a189:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    a18e:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    a193:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a19a:	84 00 00 00 00 00 
    a1a0:	4d 8b 67 40          	mov    0x40(%r15),%r12
    a1a4:	49 8b af 80 00 00 00 	mov    0x80(%r15),%rbp
    a1ab:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    a1af:	4c 29 e5             	sub    %r12,%rbp
    a1b2:	4c 01 ed             	add    %r13,%rbp
    a1b5:	74 69                	je     a220 <fwp_ring_put+0x100>
    a1b7:	48 39 eb             	cmp    %rbp,%rbx
    a1ba:	48 0f 42 eb          	cmovb  %rbx,%rbp
    a1be:	49 8d 7d ff          	lea    -0x1(%r13),%rdi
    a1c2:	4c 21 e7             	and    %r12,%rdi
    a1c5:	49 29 fd             	sub    %rdi,%r13
    a1c8:	4c 39 ed             	cmp    %r13,%rbp
    a1cb:	4c 0f 42 ed          	cmovb  %rbp,%r13
    a1cf:	4c 01 f7             	add    %r14,%rdi
    a1d2:	48 89 5c 24 30       	mov    %rbx,0x30(%rsp)
    a1d7:	48 8b 1c 24          	mov    (%rsp),%rbx
    a1db:	48 89 de             	mov    %rbx,%rsi
    a1de:	4c 89 ea             	mov    %r13,%rdx
    a1e1:	e8 3a 81 ff ff       	call   2320 <memcpy@plt>
    a1e6:	4a 8d 34 2b          	lea    (%rbx,%r13,1),%rsi
    a1ea:	48 89 ea             	mov    %rbp,%rdx
    a1ed:	4c 29 ea             	sub    %r13,%rdx
    a1f0:	4c 89 f7             	mov    %r14,%rdi
    a1f3:	e8 28 81 ff ff       	call   2320 <memcpy@plt>
    a1f8:	49 01 ec             	add    %rbp,%r12
    a1fb:	4d 89 67 40          	mov    %r12,0x40(%r15)
    a1ff:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    a204:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    a209:	e8 82 02 00 00       	call   a490 <fwp_ring_wake>
    a20e:	48 01 eb             	add    %rbp,%rbx
    a211:	48 89 1c 24          	mov    %rbx,(%rsp)
    a215:	48 8b 5c 24 30       	mov    0x30(%rsp),%rbx
    a21a:	48 29 eb             	sub    %rbp,%rbx
    a21d:	eb 31                	jmp    a250 <fwp_ring_put+0x130>
    a21f:	90                   	nop
    a220:	44 8b 05 91 ba 00 00 	mov    0xba91(%rip),%r8d        # 15cb8 <fwp_po_sock>
    a227:	4c 89 ff             	mov    %r15,%rdi
    a22a:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    a22f:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    a234:	48 8d 0d 35 02 00 00 	lea    0x235(%rip),%rcx        # a470 <fwp_ring_has_space>
    a23b:	e8 f0 00 00 00       	call   a330 <fwp_ring_wait>
    a240:	85 c0                	test   %eax,%eax
    a242:	75 0c                	jne    a250 <fwp_ring_put+0x130>
    a244:	c6 05 0d bc 02 00 01 	movb   $0x1,0x2bc0d(%rip)        # 35e58 <fwp_po_gone>
    a24b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    a250:	48 85 db             	test   %rbx,%rbx
    a253:	74 0d                	je     a262 <fwp_ring_put+0x142>
    a255:	f6 05 fc bb 02 00 01 	testb  $0x1,0x2bbfc(%rip)        # 35e58 <fwp_po_gone>
    a25c:	0f 84 3e ff ff ff    	je     a1a0 <fwp_ring_put+0x80>
    a262:	48 83 c4 38          	add    $0x38,%rsp
    a266:	5b                   	pop    %rbx
    a267:	41 5c                	pop    %r12
    a269:	41 5d                	pop    %r13
    a26b:	41 5e                	pop    %r14
    a26d:	41 5f                	pop    %r15
    a26f:	5d                   	pop    %rbp
    a270:	c3                   	ret
    a271:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a278:	0f 1f 84 00 00 00 00 
    a27f:	00 

000000000000a280 <fwp_po_flush_sock>:
    a280:	48 8b 15 c1 bb 01 00 	mov    0x1bbc1(%rip),%rdx        # 25e48 <fwp_po_len>
    a287:	48 85 d2             	test   %rdx,%rdx
    a28a:	74 17                	je     a2a3 <fwp_po_flush_sock+0x23>
    a28c:	50                   	push   %rax
    a28d:	8b 3d 25 ba 00 00    	mov    0xba25(%rip),%edi        # 15cb8 <fwp_po_sock>
    a293:	48 8d 35 b6 bb 01 00 	lea    0x1bbb6(%rip),%rsi        # 25e50 <fwp_po_buf>
    a29a:	e8 11 00 00 00       	call   a2b0 <fwp_po_write_raw>
    a29f:	48 83 c4 08          	add    $0x8,%rsp
    a2a3:	48 c7 05 9a bb 01 00 	movq   $0x0,0x1bb9a(%rip)        # 25e48 <fwp_po_len>
    a2aa:	00 00 00 00 
    a2ae:	c3                   	ret
    a2af:	90                   	nop

000000000000a2b0 <fwp_po_write_raw>:
    a2b0:	48 85 d2             	test   %rdx,%rdx
    a2b3:	74 70                	je     a325 <fwp_po_write_raw+0x75>
    a2b5:	f6 05 9c bb 02 00 01 	testb  $0x1,0x2bb9c(%rip)        # 35e58 <fwp_po_gone>
    a2bc:	75 67                	jne    a325 <fwp_po_write_raw+0x75>
    a2be:	55                   	push   %rbp
    a2bf:	41 56                	push   %r14
    a2c1:	53                   	push   %rbx
    a2c2:	48 89 d3             	mov    %rdx,%rbx
    a2c5:	49 89 f6             	mov    %rsi,%r14
    a2c8:	89 fd                	mov    %edi,%ebp
    a2ca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    a2d0:	89 ef                	mov    %ebp,%edi
    a2d2:	4c 89 f6             	mov    %r14,%rsi
    a2d5:	48 89 da             	mov    %rbx,%rdx
    a2d8:	b9 00 40 00 00       	mov    $0x4000,%ecx
    a2dd:	e8 ae 7e ff ff       	call   2190 <send@plt>
    a2e2:	48 85 c0             	test   %rax,%rax
    a2e5:	78 19                	js     a300 <fwp_po_write_raw+0x50>
    a2e7:	74 31                	je     a31a <fwp_po_write_raw+0x6a>
    a2e9:	49 01 c6             	add    %rax,%r14
    a2ec:	48 29 c3             	sub    %rax,%rbx
    a2ef:	eb 19                	jmp    a30a <fwp_po_write_raw+0x5a>
    a2f1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a2f8:	0f 1f 84 00 00 00 00 
    a2ff:	00 
    a300:	e8 7b 7d ff ff       	call   2080 <__errno_location@plt>
    a305:	83 38 04             	cmpl   $0x4,(%rax)
    a308:	75 10                	jne    a31a <fwp_po_write_raw+0x6a>
    a30a:	48 85 db             	test   %rbx,%rbx
    a30d:	74 12                	je     a321 <fwp_po_write_raw+0x71>
    a30f:	f6 05 42 bb 02 00 01 	testb  $0x1,0x2bb42(%rip)        # 35e58 <fwp_po_gone>
    a316:	74 b8                	je     a2d0 <fwp_po_write_raw+0x20>
    a318:	eb 07                	jmp    a321 <fwp_po_write_raw+0x71>
    a31a:	c6 05 37 bb 02 00 01 	movb   $0x1,0x2bb37(%rip)        # 35e58 <fwp_po_gone>
    a321:	5b                   	pop    %rbx
    a322:	41 5e                	pop    %r14
    a324:	5d                   	pop    %rbp
    a325:	c3                   	ret
    a326:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    a32d:	00 00 00 

000000000000a330 <fwp_ring_wait>:
    a330:	55                   	push   %rbp
    a331:	41 57                	push   %r15
    a333:	41 56                	push   %r14
    a335:	41 55                	push   %r13
    a337:	41 54                	push   %r12
    a339:	53                   	push   %rbx
    a33a:	50                   	push   %rax
    a33b:	44 89 44 24 04       	mov    %r8d,0x4(%rsp)
    a340:	49 89 cf             	mov    %rcx,%r15
    a343:	49 89 d6             	mov    %rdx,%r14
    a346:	49 89 f4             	mov    %rsi,%r12
    a349:	49 89 fd             	mov    %rdi,%r13
    a34c:	8b 0d 6a b9 00 00    	mov    0xb96a(%rip),%ecx        # 15cbc <fwp_ring_spin>
    a352:	85 c9                	test   %ecx,%ecx
    a354:	78 06                	js     a35c <fwp_ring_wait+0x2c>
    a356:	85 c9                	test   %ecx,%ecx
    a358:	75 1f                	jne    a379 <fwp_ring_wait+0x49>
    a35a:	eb 6f                	jmp    a3cb <fwp_ring_wait+0x9b>
    a35c:	bf 54 00 00 00       	mov    $0x54,%edi
    a361:	e8 ba 80 ff ff       	call   2420 <sysconf@plt>
    a366:	31 c9                	xor    %ecx,%ecx
    a368:	48 83 f8 02          	cmp    $0x2,%rax
    a36c:	0f 9d c1             	setge  %cl
    a36f:	89 0d 47 b9 00 00    	mov    %ecx,0xb947(%rip)        # 15cbc <fwp_ring_spin>
    a375:	85 c9                	test   %ecx,%ecx
    a377:	74 52                	je     a3cb <fwp_ring_wait+0x9b>
    a379:	4c 89 ef             	mov    %r13,%rdi
    a37c:	41 ff d7             	call   *%r15
    a37f:	89 c1                	mov    %eax,%ecx
    a381:	b8 01 00 00 00       	mov    $0x1,%eax
    a386:	85 c9                	test   %ecx,%ecx
    a388:	75 6a                	jne    a3f4 <fwp_ring_wait+0xc4>
    a38a:	bd 01 00 00 00       	mov    $0x1,%ebp
    a38f:	31 db                	xor    %ebx,%ebx
    a391:	eb 19                	jmp    a3ac <fwp_ring_wait+0x7c>
    a393:	48 05 50 c3 00 00    	add    $0xc350,%rax
    a399:	48 89 c3             	mov    %rax,%rbx
    a39c:	0f 1f 40 00          	nopl   0x0(%rax)
    a3a0:	ff c5                	inc    %ebp
    a3a2:	4c 89 ef             	mov    %r13,%rdi
    a3a5:	41 ff d7             	call   *%r15
    a3a8:	85 c0                	test   %eax,%eax
    a3aa:	75 43                	jne    a3ef <fwp_ring_wait+0xbf>
    a3ac:	e8 ff 00 00 00       	call   a4b0 <fwp_cpu_relax>
    a3b1:	40 f6 c5 3f          	test   $0x3f,%bpl
    a3b5:	75 e9                	jne    a3a0 <fwp_ring_wait+0x70>
    a3b7:	e8 84 7e ff ff       	call   2240 <sched_yield@plt>
    a3bc:	e8 2f fd ff ff       	call   a0f0 <fwp_now_ns>
    a3c1:	48 85 db             	test   %rbx,%rbx
    a3c4:	74 cd                	je     a393 <fwp_ring_wait+0x63>
    a3c6:	48 39 d8             	cmp    %rbx,%rax
    a3c9:	7e d5                	jle    a3a0 <fwp_ring_wait+0x70>
    a3cb:	41 8b 2c 24          	mov    (%r12),%ebp
    a3cf:	b8 01 00 00 00       	mov    $0x1,%eax
    a3d4:	41 87 06             	xchg   %eax,(%r14)
    a3d7:	0f ae f0             	mfence
    a3da:	4c 89 ef             	mov    %r13,%rdi
    a3dd:	41 ff d7             	call   *%r15
    a3e0:	85 c0                	test   %eax,%eax
    a3e2:	8b 5c 24 04          	mov    0x4(%rsp),%ebx
    a3e6:	74 41                	je     a429 <fwp_ring_wait+0xf9>
    a3e8:	41 c7 06 00 00 00 00 	movl   $0x0,(%r14)
    a3ef:	b8 01 00 00 00       	mov    $0x1,%eax
    a3f4:	48 83 c4 08          	add    $0x8,%rsp
    a3f8:	5b                   	pop    %rbx
    a3f9:	41 5c                	pop    %r12
    a3fb:	41 5d                	pop    %r13
    a3fd:	41 5e                	pop    %r14
    a3ff:	41 5f                	pop    %r15
    a401:	5d                   	pop    %rbp
    a402:	c3                   	ret
    a403:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a40a:	84 00 00 00 00 00 
    a410:	41 8b 2c 24          	mov    (%r12),%ebp
    a414:	b8 01 00 00 00       	mov    $0x1,%eax
    a419:	41 87 06             	xchg   %eax,(%r14)
    a41c:	0f ae f0             	mfence
    a41f:	4c 89 ef             	mov    %r13,%rdi
    a422:	41 ff d7             	call   *%r15
    a425:	85 c0                	test   %eax,%eax
    a427:	75 bf                	jne    a3e8 <fwp_ring_wait+0xb8>
    a429:	4c 89 e7             	mov    %r12,%rdi
    a42c:	31 f6                	xor    %esi,%esi
    a42e:	89 ea                	mov    %ebp,%edx
    a430:	b9 64 00 00 00       	mov    $0x64,%ecx
    a435:	e8 86 00 00 00       	call   a4c0 <fwp_futex>
    a43a:	48 89 c5             	mov    %rax,%rbp
    a43d:	41 c7 06 00 00 00 00 	movl   $0x0,(%r14)
    a444:	4c 89 ef             	mov    %r13,%rdi
    a447:	41 ff d7             	call   *%r15
    a44a:	85 c0                	test   %eax,%eax
    a44c:	75 a1                	jne    a3ef <fwp_ring_wait+0xbf>
    a44e:	48 85 ed             	test   %rbp,%rbp
    a451:	74 bd                	je     a410 <fwp_ring_wait+0xe0>
    a453:	e8 28 7c ff ff       	call   2080 <__errno_location@plt>
    a458:	83 38 6e             	cmpl   $0x6e,(%rax)
    a45b:	75 b3                	jne    a410 <fwp_ring_wait+0xe0>
    a45d:	89 df                	mov    %ebx,%edi
    a45f:	e8 cc 00 00 00       	call   a530 <fwp_sock_gone>
    a464:	85 c0                	test   %eax,%eax
    a466:	74 a8                	je     a410 <fwp_ring_wait+0xe0>
    a468:	31 c0                	xor    %eax,%eax
    a46a:	eb 88                	jmp    a3f4 <fwp_ring_wait+0xc4>
    a46c:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000a470 <fwp_ring_has_space>:
    a470:	48 8b 8f 80 00 00 00 	mov    0x80(%rdi),%rcx
    a477:	48 2b 4f 40          	sub    0x40(%rdi),%rcx
    a47b:	31 c0                	xor    %eax,%eax
    a47d:	48 03 4f 08          	add    0x8(%rdi),%rcx
    a481:	0f 95 c0             	setne  %al
    a484:	c3                   	ret
    a485:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a48c:	00 00 00 00 

000000000000a490 <fwp_ring_wake>:
    a490:	0f ae f0             	mfence
    a493:	8b 06                	mov    (%rsi),%eax
    a495:	85 c0                	test   %eax,%eax
    a497:	74 14                	je     a4ad <fwp_ring_wake+0x1d>
    a499:	f0 ff 07             	lock incl (%rdi)
    a49c:	be 01 00 00 00       	mov    $0x1,%esi
    a4a1:	ba ff ff ff 7f       	mov    $0x7fffffff,%edx
    a4a6:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    a4ab:	eb 13                	jmp    a4c0 <fwp_futex>
    a4ad:	c3                   	ret
    a4ae:	66 90                	xchg   %ax,%ax

000000000000a4b0 <fwp_cpu_relax>:
    a4b0:	f3 90                	pause
    a4b2:	c3                   	ret
    a4b3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a4ba:	84 00 00 00 00 00 

000000000000a4c0 <fwp_futex>:
    a4c0:	48 83 ec 18          	sub    $0x18,%rsp
    a4c4:	89 c8                	mov    %ecx,%eax
    a4c6:	89 d1                	mov    %edx,%ecx
    a4c8:	89 f2                	mov    %esi,%edx
    a4ca:	48 89 fe             	mov    %rdi,%rsi
    a4cd:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
    a4d4:	00 00 
    a4d6:	48 98                	cltq
    a4d8:	48 69 f8 d3 4d 62 10 	imul   $0x10624dd3,%rax,%rdi
    a4df:	49 89 f8             	mov    %rdi,%r8
    a4e2:	49 c1 e8 3f          	shr    $0x3f,%r8
    a4e6:	48 c1 ff 26          	sar    $0x26,%rdi
    a4ea:	44 01 c7             	add    %r8d,%edi
    a4ed:	69 ff e8 03 00 00    	imul   $0x3e8,%edi,%edi
    a4f3:	41 89 c0             	mov    %eax,%r8d
    a4f6:	41 29 f8             	sub    %edi,%r8d
    a4f9:	41 69 f8 40 42 0f 00 	imul   $0xf4240,%r8d,%edi
    a500:	48 63 ff             	movslq %edi,%rdi
    a503:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    a508:	31 ff                	xor    %edi,%edi
    a50a:	85 c0                	test   %eax,%eax
    a50c:	4c 8d 44 24 08       	lea    0x8(%rsp),%r8
    a511:	4c 0f 48 c7          	cmovs  %rdi,%r8
    a515:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    a51c:	bf ca 00 00 00       	mov    $0xca,%edi
    a521:	45 31 c9             	xor    %r9d,%r9d
    a524:	31 c0                	xor    %eax,%eax
    a526:	e8 c5 7d ff ff       	call   22f0 <syscall@plt>
    a52b:	48 83 c4 18          	add    $0x18,%rsp
    a52f:	c3                   	ret

000000000000a530 <fwp_sock_gone>:
    a530:	55                   	push   %rbp
    a531:	53                   	push   %rbx
    a532:	48 83 ec 18          	sub    $0x18,%rsp
    a536:	89 fb                	mov    %edi,%ebx
    a538:	89 7c 24 10          	mov    %edi,0x10(%rsp)
    a53c:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%rsp)
    a543:	00 
    a544:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    a549:	31 ed                	xor    %ebp,%ebp
    a54b:	be 01 00 00 00       	mov    $0x1,%esi
    a550:	31 d2                	xor    %edx,%edx
    a552:	e8 59 7e ff ff       	call   23b0 <poll@plt>
    a557:	85 c0                	test   %eax,%eax
    a559:	7e 2b                	jle    a586 <fwp_sock_gone+0x56>
    a55b:	bd 01 00 00 00       	mov    $0x1,%ebp
    a560:	f6 44 24 16 18       	testb  $0x18,0x16(%rsp)
    a565:	75 1f                	jne    a586 <fwp_sock_gone+0x56>
    a567:	48 8d 74 24 0f       	lea    0xf(%rsp),%rsi
    a56c:	ba 01 00 00 00       	mov    $0x1,%edx
    a571:	89 df                	mov    %ebx,%edi
    a573:	b9 42 00 00 00       	mov    $0x42,%ecx
    a578:	e8 e3 7a ff ff       	call   2060 <recv@plt>
    a57d:	31 ed                	xor    %ebp,%ebp
    a57f:	48 85 c0             	test   %rax,%rax
    a582:	40 0f 94 c5          	sete   %bpl
    a586:	89 e8                	mov    %ebp,%eax
    a588:	48 83 c4 18          	add    $0x18,%rsp
    a58c:	5b                   	pop    %rbx
    a58d:	5d                   	pop    %rbp
    a58e:	c3                   	ret
    a58f:	90                   	nop

000000000000a590 <fwp_pipe_poll>:
    a590:	83 3d 1d b7 00 00 00 	cmpl   $0x0,0xb71d(%rip)        # 15cb4 <fwp_po_listen>
    a597:	0f 88 9b 01 00 00    	js     a738 <fwp_pipe_poll+0x1a8>
    a59d:	55                   	push   %rbp
    a59e:	41 57                	push   %r15
    a5a0:	41 56                	push   %r14
    a5a2:	53                   	push   %rbx
    a5a3:	48 83 ec 28          	sub    $0x28,%rsp
    a5a7:	e8 44 fb ff ff       	call   a0f0 <fwp_now_ns>
    a5ac:	48 3b 05 ad b8 02 00 	cmp    0x2b8ad(%rip),%rax        # 35e60 <fwp_po_next_check>
    a5b3:	0f 8c 75 01 00 00    	jl     a72e <fwp_pipe_poll+0x19e>
    a5b9:	49 89 c6             	mov    %rax,%r14
    a5bc:	48 05 40 42 0f 00    	add    $0xf4240,%rax
    a5c2:	48 89 05 97 b8 02 00 	mov    %rax,0x2b897(%rip)        # 35e60 <fwp_po_next_check>
    a5c9:	8b 3d e5 b6 00 00    	mov    0xb6e5(%rip),%edi        # 15cb4 <fwp_po_listen>
    a5cf:	31 f6                	xor    %esi,%esi
    a5d1:	31 d2                	xor    %edx,%edx
    a5d3:	e8 58 7e ff ff       	call   2430 <accept@plt>
    a5d8:	85 c0                	test   %eax,%eax
    a5da:	0f 88 10 01 00 00    	js     a6f0 <fwp_pipe_poll+0x160>
    a5e0:	89 c3                	mov    %eax,%ebx
    a5e2:	8b 3d cc b6 00 00    	mov    0xb6cc(%rip),%edi        # 15cb4 <fwp_po_listen>
    a5e8:	e8 33 7c ff ff       	call   2220 <close@plt>
    a5ed:	c7 05 bd b6 00 00 ff 	movl   $0xffffffff,0xb6bd(%rip)        # 15cb4 <fwp_po_listen>
    a5f4:	ff ff ff 
    a5f7:	89 df                	mov    %ebx,%edi
    a5f9:	be 02 00 00 00       	mov    $0x2,%esi
    a5fe:	ba 01 00 00 00       	mov    $0x1,%edx
    a603:	31 c0                	xor    %eax,%eax
    a605:	e8 06 7b ff ff       	call   2110 <fcntl@plt>
    a60a:	89 df                	mov    %ebx,%edi
    a60c:	be 03 00 00 00       	mov    $0x3,%esi
    a611:	31 c0                	xor    %eax,%eax
    a613:	e8 f8 7a ff ff       	call   2110 <fcntl@plt>
    a618:	25 ff f7 ff ff       	and    $0xfffff7ff,%eax
    a61d:	89 df                	mov    %ebx,%edi
    a61f:	be 04 00 00 00       	mov    $0x4,%esi
    a624:	89 c2                	mov    %eax,%edx
    a626:	31 c0                	xor    %eax,%eax
    a628:	e8 e3 7a ff ff       	call   2110 <fcntl@plt>
    a62d:	c7 44 24 18 0c 00 00 	movl   $0xc,0x18(%rsp)
    a634:	00 
    a635:	89 5c 24 10          	mov    %ebx,0x10(%rsp)
    a639:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%rsp)
    a640:	00 
    a641:	48 8d 4c 24 1c       	lea    0x1c(%rsp),%rcx
    a646:	4c 8d 44 24 18       	lea    0x18(%rsp),%r8
    a64b:	89 df                	mov    %ebx,%edi
    a64d:	be 01 00 00 00       	mov    $0x1,%esi
    a652:	ba 11 00 00 00       	mov    $0x11,%edx
    a657:	e8 34 7c ff ff       	call   2290 <getsockopt@plt>
    a65c:	85 c0                	test   %eax,%eax
    a65e:	0f 85 c3 00 00 00    	jne    a727 <fwp_pipe_poll+0x197>
    a664:	8b 6c 24 20          	mov    0x20(%rsp),%ebp
    a668:	e8 03 7b ff ff       	call   2170 <getuid@plt>
    a66d:	39 c5                	cmp    %eax,%ebp
    a66f:	0f 85 b2 00 00 00    	jne    a727 <fwp_pipe_poll+0x197>
    a675:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    a67a:	be 01 00 00 00       	mov    $0x1,%esi
    a67f:	ba e8 03 00 00       	mov    $0x3e8,%edx
    a684:	e8 27 7d ff ff       	call   23b0 <poll@plt>
    a689:	85 c0                	test   %eax,%eax
    a68b:	0f 8e 96 00 00 00    	jle    a727 <fwp_pipe_poll+0x197>
    a691:	48 8d 74 24 03       	lea    0x3(%rsp),%rsi
    a696:	ba 05 00 00 00       	mov    $0x5,%edx
    a69b:	89 df                	mov    %ebx,%edi
    a69d:	31 c9                	xor    %ecx,%ecx
    a69f:	e8 bc 79 ff ff       	call   2060 <recv@plt>
    a6a4:	48 85 c0             	test   %rax,%rax
    a6a7:	7e 7e                	jle    a727 <fwp_pipe_poll+0x197>
    a6a9:	49 89 c6             	mov    %rax,%r14
    a6ac:	4c 8d 7c 24 10       	lea    0x10(%rsp),%r15
    a6b1:	49 83 fe 04          	cmp    $0x4,%r14
    a6b5:	77 59                	ja     a710 <fwp_pipe_poll+0x180>
    a6b7:	be 01 00 00 00       	mov    $0x1,%esi
    a6bc:	4c 89 ff             	mov    %r15,%rdi
    a6bf:	ba e8 03 00 00       	mov    $0x3e8,%edx
    a6c4:	e8 e7 7c ff ff       	call   23b0 <poll@plt>
    a6c9:	85 c0                	test   %eax,%eax
    a6cb:	7e 5a                	jle    a727 <fwp_pipe_poll+0x197>
    a6cd:	4a 8d 34 34          	lea    (%rsp,%r14,1),%rsi
    a6d1:	48 83 c6 03          	add    $0x3,%rsi
    a6d5:	ba 05 00 00 00       	mov    $0x5,%edx
    a6da:	4c 29 f2             	sub    %r14,%rdx
    a6dd:	89 df                	mov    %ebx,%edi
    a6df:	31 c9                	xor    %ecx,%ecx
    a6e1:	e8 7a 79 ff ff       	call   2060 <recv@plt>
    a6e6:	49 01 c6             	add    %rax,%r14
    a6e9:	48 85 c0             	test   %rax,%rax
    a6ec:	7f c3                	jg     a6b1 <fwp_pipe_poll+0x121>
    a6ee:	eb 37                	jmp    a727 <fwp_pipe_poll+0x197>
    a6f0:	4c 3b 35 41 b7 01 00 	cmp    0x1b741(%rip),%r14        # 25e38 <fwp_po_give_up>
    a6f7:	7e 35                	jle    a72e <fwp_pipe_poll+0x19e>
    a6f9:	8b 3d b5 b5 00 00    	mov    0xb5b5(%rip),%edi        # 15cb4 <fwp_po_listen>
    a6ff:	e8 1c 7b ff ff       	call   2220 <close@plt>
    a704:	c7 05 a6 b5 00 00 ff 	movl   $0xffffffff,0xb5a6(%rip)        # 15cb4 <fwp_po_listen>
    a70b:	ff ff ff 
    a70e:	eb 1e                	jmp    a72e <fwp_pipe_poll+0x19e>
    a710:	81 7c 24 03 46 57 50 	cmpl   $0x54505746,0x3(%rsp)
    a717:	54 
    a718:	75 0d                	jne    a727 <fwp_pipe_poll+0x197>
    a71a:	0f b6 44 24 07       	movzbl 0x7(%rsp),%eax
    a71f:	8d 48 fd             	lea    -0x3(%rax),%ecx
    a722:	80 f9 fd             	cmp    $0xfd,%cl
    a725:	77 12                	ja     a739 <fwp_pipe_poll+0x1a9>
    a727:	89 df                	mov    %ebx,%edi
    a729:	e8 f2 7a ff ff       	call   2220 <close@plt>
    a72e:	48 83 c4 28          	add    $0x28,%rsp
    a732:	5b                   	pop    %rbx
    a733:	41 5e                	pop    %r14
    a735:	41 5f                	pop    %r15
    a737:	5d                   	pop    %rbp
    a738:	c3                   	ret
    a739:	89 1d 79 b5 00 00    	mov    %ebx,0xb579(%rip)        # 15cb8 <fwp_po_sock>
    a73f:	bb 01 00 00 00       	mov    $0x1,%ebx
    a744:	3c 02                	cmp    $0x2,%al
    a746:	75 10                	jne    a758 <fwp_pipe_poll+0x1c8>
    a748:	e8 53 00 00 00       	call   a7a0 <fwp_po_make_ring>
    a74d:	83 f8 01             	cmp    $0x1,%eax
    a750:	bb 02 00 00 00       	mov    $0x2,%ebx
    a755:	83 db 00             	sbb    $0x0,%ebx
    a758:	c7 44 24 08 02 01 00 	movl   $0x102,0x8(%rsp)
    a75f:	00 
    a760:	c6 44 24 0c 00       	movb   $0x0,0xc(%rsp)
    a765:	88 5c 24 0d          	mov    %bl,0xd(%rsp)
    a769:	4c 8b 35 48 98 00 00 	mov    0x9848(%rip),%r14        # 13fb8 <stdout@GLIBC_2.2.5>
    a770:	49 8b 0e             	mov    (%r14),%rcx
    a773:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    a778:	be 01 00 00 00       	mov    $0x1,%esi
    a77d:	ba 06 00 00 00       	mov    $0x6,%edx
    a782:	e8 09 7d ff ff       	call   2490 <fwrite@plt>
    a787:	49 8b 3e             	mov    (%r14),%rdi
    a78a:	e8 b1 7b ff ff       	call   2340 <fflush@plt>
    a78f:	89 1d ab b6 01 00    	mov    %ebx,0x1b6ab(%rip)        # 25e40 <fwp_po_kind>
    a795:	eb 97                	jmp    a72e <fwp_pipe_poll+0x19e>
    a797:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    a79e:	00 00 

000000000000a7a0 <fwp_po_make_ring>:
    a7a0:	55                   	push   %rbp
    a7a1:	41 57                	push   %r15
    a7a3:	41 56                	push   %r14
    a7a5:	53                   	push   %rbx
    a7a6:	48 83 ec 68          	sub    $0x68,%rsp
    a7aa:	48 8d 35 62 4b 00 00 	lea    0x4b62(%rip),%rsi        # f313 <exec_in_fp0+0xcb3>
    a7b1:	31 ed                	xor    %ebp,%ebp
    a7b3:	bf 3f 01 00 00       	mov    $0x13f,%edi
    a7b8:	ba 01 00 00 00       	mov    $0x1,%edx
    a7bd:	31 c0                	xor    %eax,%eax
    a7bf:	e8 2c 7b ff ff       	call   22f0 <syscall@plt>
    a7c4:	48 89 c3             	mov    %rax,%rbx
    a7c7:	85 db                	test   %ebx,%ebx
    a7c9:	78 17                	js     a7e2 <fwp_po_make_ring+0x42>
    a7cb:	be 00 10 10 00       	mov    $0x101000,%esi
    a7d0:	89 df                	mov    %ebx,%edi
    a7d2:	e8 f9 79 ff ff       	call   21d0 <ftruncate@plt>
    a7d7:	85 c0                	test   %eax,%eax
    a7d9:	74 14                	je     a7ef <fwp_po_make_ring+0x4f>
    a7db:	89 df                	mov    %ebx,%edi
    a7dd:	e8 3e 7a ff ff       	call   2220 <close@plt>
    a7e2:	89 e8                	mov    %ebp,%eax
    a7e4:	48 83 c4 68          	add    $0x68,%rsp
    a7e8:	5b                   	pop    %rbx
    a7e9:	41 5e                	pop    %r14
    a7eb:	41 5f                	pop    %r15
    a7ed:	5d                   	pop    %rbp
    a7ee:	c3                   	ret
    a7ef:	be 00 10 10 00       	mov    $0x101000,%esi
    a7f4:	31 ff                	xor    %edi,%edi
    a7f6:	ba 03 00 00 00       	mov    $0x3,%edx
    a7fb:	b9 01 00 00 00       	mov    $0x1,%ecx
    a800:	41 89 d8             	mov    %ebx,%r8d
    a803:	45 31 c9             	xor    %r9d,%r9d
    a806:	e8 75 79 ff ff       	call   2180 <mmap@plt>
    a80b:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    a80f:	74 ca                	je     a7db <fwp_po_make_ring+0x3b>
    a811:	49 89 c6             	mov    %rax,%r14
    a814:	48 b8 46 57 50 53 01 	movabs $0x153505746,%rax
    a81b:	00 00 00 
    a81e:	49 89 06             	mov    %rax,(%r14)
    a821:	49 c7 46 08 00 00 10 	movq   $0x100000,0x8(%r14)
    a828:	00 
    a829:	c6 44 24 07 53       	movb   $0x53,0x7(%rsp)
    a82e:	48 8d 44 24 07       	lea    0x7(%rsp),%rax
    a833:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    a838:	48 c7 44 24 28 01 00 	movq   $0x1,0x28(%rsp)
    a83f:	00 00 
    a841:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
    a848:	00 00 
    a84a:	0f 57 c0             	xorps  %xmm0,%xmm0
    a84d:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    a852:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
    a857:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    a85c:	48 c7 44 24 60 00 00 	movq   $0x0,0x60(%rsp)
    a863:	00 00 
    a865:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    a86a:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    a86f:	48 c7 44 24 48 01 00 	movq   $0x1,0x48(%rsp)
    a876:	00 00 
    a878:	48 8d 44 24 08       	lea    0x8(%rsp),%rax
    a87d:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    a882:	48 c7 44 24 58 18 00 	movq   $0x18,0x58(%rsp)
    a889:	00 00 
    a88b:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
    a892:	00 00 00 
    a895:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    a89a:	48 c7 44 24 08 14 00 	movq   $0x14,0x8(%rsp)
    a8a1:	00 00 
    a8a3:	89 5c 24 18          	mov    %ebx,0x18(%rsp)
    a8a7:	8b 3d 0b b4 00 00    	mov    0xb40b(%rip),%edi        # 15cb8 <fwp_po_sock>
    a8ad:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
    a8b2:	ba 00 40 00 00       	mov    $0x4000,%edx
    a8b7:	e8 04 78 ff ff       	call   20c0 <sendmsg@plt>
    a8bc:	49 89 c7             	mov    %rax,%r15
    a8bf:	89 df                	mov    %ebx,%edi
    a8c1:	e8 5a 79 ff ff       	call   2220 <close@plt>
    a8c6:	49 83 ff 01          	cmp    $0x1,%r15
    a8ca:	75 11                	jne    a8dd <fwp_po_make_ring+0x13d>
    a8cc:	4c 89 35 7d b5 02 00 	mov    %r14,0x2b57d(%rip)        # 35e50 <fwp_po_ring>
    a8d3:	bd 01 00 00 00       	mov    $0x1,%ebp
    a8d8:	e9 05 ff ff ff       	jmp    a7e2 <fwp_po_make_ring+0x42>
    a8dd:	be 00 10 10 00       	mov    $0x101000,%esi
    a8e2:	4c 89 f7             	mov    %r14,%rdi
    a8e5:	e8 96 7a ff ff       	call   2380 <munmap@plt>
    a8ea:	31 ed                	xor    %ebp,%ebp
    a8ec:	e9 f1 fe ff ff       	jmp    a7e2 <fwp_po_make_ring+0x42>
    a8f1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a8f8:	0f 1f 84 00 00 00 00 
    a8ff:	00 

000000000000a900 <fwp_apply>:
    a900:	55                   	push   %rbp
    a901:	48 89 e5             	mov    %rsp,%rbp
    a904:	41 57                	push   %r15
    a906:	41 56                	push   %r14
    a908:	41 55                	push   %r13
    a90a:	41 54                	push   %r12
    a90c:	53                   	push   %rbx
    a90d:	48 83 ec 18          	sub    $0x18,%rsp
    a911:	48 89 f3             	mov    %rsi,%rbx
    a914:	49 89 ff             	mov    %rdi,%r15
    a917:	be 01 00 00 00       	mov    $0x1,%esi
    a91c:	eb 1e                	jmp    a93c <fwp_apply+0x3c>
    a91e:	66 90                	xchg   %ax,%ax
    a920:	4a 8d 1c f3          	lea    (%rbx,%r14,8),%rbx
    a924:	31 c9                	xor    %ecx,%ecx
    a926:	49 89 c7             	mov    %rax,%r15
    a929:	4c 8b 75 c8          	mov    -0x38(%rbp),%r14
    a92d:	48 8b 65 c0          	mov    -0x40(%rbp),%rsp
    a931:	89 d6                	mov    %edx,%esi
    a933:	83 f9 01             	cmp    $0x1,%ecx
    a936:	0f 84 ff 03 00 00    	je     ad3b <fwp_apply+0x43b>
    a93c:	48 8b 05 5d b4 00 00 	mov    0xb45d(%rip),%rax        # 15da0 <fwp_fns>
    a943:	41 8b 0f             	mov    (%r15),%ecx
    a946:	45 8b 67 04          	mov    0x4(%r15),%r12d
    a94a:	48 c1 e1 05          	shl    $0x5,%rcx
    a94e:	44 8b 2c 08          	mov    (%rax,%rcx,1),%r13d
    a952:	4d 85 e4             	test   %r12,%r12
    a955:	75 39                	jne    a990 <fwp_apply+0x90>
    a957:	41 8d 55 ff          	lea    -0x1(%r13),%edx
    a95b:	39 f2                	cmp    %esi,%edx
    a95d:	73 31                	jae    a990 <fwp_apply+0x90>
    a95f:	49 89 f7             	mov    %rsi,%r15
    a962:	48 89 df             	mov    %rbx,%rdi
    a965:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    a969:	4c 89 fe             	mov    %r15,%rsi
    a96c:	49 89 c7             	mov    %rax,%r15
    a96f:	44 39 ee             	cmp    %r13d,%esi
    a972:	0f 84 c0 03 00 00    	je     ad38 <fwp_apply+0x438>
    a978:	4a 8d 1c eb          	lea    (%rbx,%r13,8),%rbx
    a97c:	44 29 ee             	sub    %r13d,%esi
    a97f:	b9 03 00 00 00       	mov    $0x3,%ecx
    a984:	83 f9 01             	cmp    $0x1,%ecx
    a987:	75 b3                	jne    a93c <fwp_apply+0x3c>
    a989:	e9 ad 03 00 00       	jmp    ad3b <fwp_apply+0x43b>
    a98e:	66 90                	xchg   %ax,%ax
    a990:	4c 89 75 c8          	mov    %r14,-0x38(%rbp)
    a994:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    a998:	45 8d 34 34          	lea    (%r12,%rsi,1),%r14d
    a99c:	45 39 ee             	cmp    %r13d,%r14d
    a99f:	0f 82 1a 02 00 00    	jb     abbf <fwp_apply+0x2bf>
    a9a5:	48 89 65 c0          	mov    %rsp,-0x40(%rbp)
    a9a9:	45 89 eb             	mov    %r13d,%r11d
    a9ac:	41 83 fd 02          	cmp    $0x2,%r13d
    a9b0:	ba 01 00 00 00       	mov    $0x1,%edx
    a9b5:	41 0f 43 d5          	cmovae %r13d,%edx
    a9b9:	48 8d 14 d5 0f 00 00 	lea    0xf(,%rdx,8),%rdx
    a9c0:	00 
    a9c1:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
    a9c5:	48 89 e7             	mov    %rsp,%rdi
    a9c8:	48 29 d7             	sub    %rdx,%rdi
    a9cb:	48 89 fc             	mov    %rdi,%rsp
    a9ce:	4d 85 e4             	test   %r12,%r12
    a9d1:	0f 84 c9 00 00 00    	je     aaa0 <fwp_apply+0x1a0>
    a9d7:	41 83 fc 04          	cmp    $0x4,%r12d
    a9db:	72 10                	jb     a9ed <fwp_apply+0xed>
    a9dd:	48 89 fa             	mov    %rdi,%rdx
    a9e0:	4c 29 fa             	sub    %r15,%rdx
    a9e3:	48 83 c2 f8          	add    $0xfffffffffffffff8,%rdx
    a9e7:	48 83 fa 20          	cmp    $0x20,%rdx
    a9eb:	73 65                	jae    aa52 <fwp_apply+0x152>
    a9ed:	31 d2                	xor    %edx,%edx
    a9ef:	4d 89 e0             	mov    %r12,%r8
    a9f2:	48 89 d6             	mov    %rdx,%rsi
    a9f5:	49 83 e0 03          	and    $0x3,%r8
    a9f9:	74 16                	je     aa11 <fwp_apply+0x111>
    a9fb:	48 89 d6             	mov    %rdx,%rsi
    a9fe:	66 90                	xchg   %ax,%ax
    aa00:	4d 8b 4c f7 08       	mov    0x8(%r15,%rsi,8),%r9
    aa05:	4c 89 0c f7          	mov    %r9,(%rdi,%rsi,8)
    aa09:	48 ff c6             	inc    %rsi
    aa0c:	49 ff c8             	dec    %r8
    aa0f:	75 ef                	jne    aa00 <fwp_apply+0x100>
    aa11:	4c 29 e2             	sub    %r12,%rdx
    aa14:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    aa18:	0f 87 82 00 00 00    	ja     aaa0 <fwp_apply+0x1a0>
    aa1e:	66 90                	xchg   %ax,%ax
    aa20:	49 8b 54 f7 08       	mov    0x8(%r15,%rsi,8),%rdx
    aa25:	48 89 14 f7          	mov    %rdx,(%rdi,%rsi,8)
    aa29:	49 8b 54 f7 10       	mov    0x10(%r15,%rsi,8),%rdx
    aa2e:	48 89 54 f7 08       	mov    %rdx,0x8(%rdi,%rsi,8)
    aa33:	49 8b 54 f7 18       	mov    0x18(%r15,%rsi,8),%rdx
    aa38:	48 89 54 f7 10       	mov    %rdx,0x10(%rdi,%rsi,8)
    aa3d:	49 8b 54 f7 20       	mov    0x20(%r15,%rsi,8),%rdx
    aa42:	48 89 54 f7 18       	mov    %rdx,0x18(%rdi,%rsi,8)
    aa47:	48 83 c6 04          	add    $0x4,%rsi
    aa4b:	49 39 f4             	cmp    %rsi,%r12
    aa4e:	75 d0                	jne    aa20 <fwp_apply+0x120>
    aa50:	eb 4e                	jmp    aaa0 <fwp_apply+0x1a0>
    aa52:	44 89 e2             	mov    %r12d,%edx
    aa55:	83 e2 fc             	and    $0xfffffffc,%edx
    aa58:	4a 8d 34 e5 00 00 00 	lea    0x0(,%r12,8),%rsi
    aa5f:	00 
    aa60:	48 83 e6 e0          	and    $0xffffffffffffffe0,%rsi
    aa64:	45 31 c0             	xor    %r8d,%r8d
    aa67:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    aa6e:	00 00 
    aa70:	43 0f 10 44 07 08    	movups 0x8(%r15,%r8,1),%xmm0
    aa76:	43 0f 10 4c 07 18    	movups 0x18(%r15,%r8,1),%xmm1
    aa7c:	42 0f 29 04 07       	movaps %xmm0,(%rdi,%r8,1)
    aa81:	42 0f 29 4c 07 10    	movaps %xmm1,0x10(%rdi,%r8,1)
    aa87:	49 83 c0 20          	add    $0x20,%r8
    aa8b:	4c 39 c6             	cmp    %r8,%rsi
    aa8e:	75 e0                	jne    aa70 <fwp_apply+0x170>
    aa90:	4c 39 e2             	cmp    %r12,%rdx
    aa93:	0f 85 56 ff ff ff    	jne    a9ef <fwp_apply+0xef>
    aa99:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    aaa0:	45 29 e3             	sub    %r12d,%r11d
    aaa3:	45 89 de             	mov    %r11d,%r14d
    aaa6:	45 39 e5             	cmp    %r12d,%r13d
    aaa9:	0f 84 85 00 00 00    	je     ab34 <fwp_apply+0x234>
    aaaf:	41 83 fb 0e          	cmp    $0xe,%r11d
    aab3:	0f 83 a0 00 00 00    	jae    ab59 <fwp_apply+0x259>
    aab9:	31 d2                	xor    %edx,%edx
    aabb:	4d 89 f0             	mov    %r14,%r8
    aabe:	48 89 d6             	mov    %rdx,%rsi
    aac1:	49 83 e0 03          	and    $0x3,%r8
    aac5:	74 1d                	je     aae4 <fwp_apply+0x1e4>
    aac7:	48 89 d6             	mov    %rdx,%rsi
    aaca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    aad0:	4c 8b 0c f3          	mov    (%rbx,%rsi,8),%r9
    aad4:	45 8d 14 34          	lea    (%r12,%rsi,1),%r10d
    aad8:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    aadc:	48 ff c6             	inc    %rsi
    aadf:	49 ff c8             	dec    %r8
    aae2:	75 ec                	jne    aad0 <fwp_apply+0x1d0>
    aae4:	4c 29 f2             	sub    %r14,%rdx
    aae7:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    aaeb:	77 47                	ja     ab34 <fwp_apply+0x234>
    aaed:	0f 1f 00             	nopl   (%rax)
    aaf0:	48 8b 14 f3          	mov    (%rbx,%rsi,8),%rdx
    aaf4:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    aaf8:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    aafc:	48 8b 54 f3 08       	mov    0x8(%rbx,%rsi,8),%rdx
    ab01:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    ab05:	41 ff c0             	inc    %r8d
    ab08:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    ab0c:	48 8b 54 f3 10       	mov    0x10(%rbx,%rsi,8),%rdx
    ab11:	45 8d 44 34 02       	lea    0x2(%r12,%rsi,1),%r8d
    ab16:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    ab1a:	48 8b 54 f3 18       	mov    0x18(%rbx,%rsi,8),%rdx
    ab1f:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    ab23:	41 83 c0 03          	add    $0x3,%r8d
    ab27:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    ab2b:	48 83 c6 04          	add    $0x4,%rsi
    ab2f:	49 39 f6             	cmp    %rsi,%r14
    ab32:	75 bc                	jne    aaf0 <fwp_apply+0x1f0>
    ab34:	45 89 dc             	mov    %r11d,%r12d
    ab37:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    ab3b:	b9 01 00 00 00       	mov    $0x1,%ecx
    ab40:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    ab44:	89 f2                	mov    %esi,%edx
    ab46:	44 29 e2             	sub    %r12d,%edx
    ab49:	0f 85 d1 fd ff ff    	jne    a920 <fwp_apply+0x20>
    ab4f:	89 f2                	mov    %esi,%edx
    ab51:	49 89 c6             	mov    %rax,%r14
    ab54:	e9 d4 fd ff ff       	jmp    a92d <fwp_apply+0x2d>
    ab59:	49 8d 56 ff          	lea    -0x1(%r14),%rdx
    ab5d:	89 d6                	mov    %edx,%esi
    ab5f:	44 01 e6             	add    %r12d,%esi
    ab62:	0f 82 51 ff ff ff    	jb     aab9 <fwp_apply+0x1b9>
    ab68:	48 c1 ea 20          	shr    $0x20,%rdx
    ab6c:	ba 00 00 00 00       	mov    $0x0,%edx
    ab71:	0f 85 44 ff ff ff    	jne    aabb <fwp_apply+0x1bb>
    ab77:	4a 8d 14 e7          	lea    (%rdi,%r12,8),%rdx
    ab7b:	48 29 da             	sub    %rbx,%rdx
    ab7e:	48 83 fa 20          	cmp    $0x20,%rdx
    ab82:	0f 82 31 ff ff ff    	jb     aab9 <fwp_apply+0x1b9>
    ab88:	44 89 f2             	mov    %r14d,%edx
    ab8b:	83 e2 fc             	and    $0xfffffffc,%edx
    ab8e:	31 f6                	xor    %esi,%esi
    ab90:	0f 10 04 f3          	movups (%rbx,%rsi,8),%xmm0
    ab94:	0f 10 4c f3 10       	movups 0x10(%rbx,%rsi,8),%xmm1
    ab99:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    ab9d:	42 0f 11 04 c7       	movups %xmm0,(%rdi,%r8,8)
    aba2:	42 0f 11 4c c7 10    	movups %xmm1,0x10(%rdi,%r8,8)
    aba8:	48 83 c6 04          	add    $0x4,%rsi
    abac:	48 39 f2             	cmp    %rsi,%rdx
    abaf:	75 df                	jne    ab90 <fwp_apply+0x290>
    abb1:	4c 39 f2             	cmp    %r14,%rdx
    abb4:	0f 85 01 ff ff ff    	jne    aabb <fwp_apply+0x1bb>
    abba:	e9 75 ff ff ff       	jmp    ab34 <fwp_apply+0x234>
    abbf:	44 89 f0             	mov    %r14d,%eax
    abc2:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    abc9:	00 
    abca:	e8 51 ab ff ff       	call   5720 <fwp_alloc>
    abcf:	41 8b 0f             	mov    (%r15),%ecx
    abd2:	89 08                	mov    %ecx,(%rax)
    abd4:	44 89 70 04          	mov    %r14d,0x4(%rax)
    abd8:	49 89 c6             	mov    %rax,%r14
    abdb:	4d 85 e4             	test   %r12,%r12
    abde:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    abe2:	0f 84 b9 00 00 00    	je     aca1 <fwp_apply+0x3a1>
    abe8:	31 c0                	xor    %eax,%eax
    abea:	41 83 fc 06          	cmp    $0x6,%r12d
    abee:	72 46                	jb     ac36 <fwp_apply+0x336>
    abf0:	4c 89 f1             	mov    %r14,%rcx
    abf3:	4c 29 f9             	sub    %r15,%rcx
    abf6:	48 83 f9 20          	cmp    $0x20,%rcx
    abfa:	72 3a                	jb     ac36 <fwp_apply+0x336>
    abfc:	44 89 e0             	mov    %r12d,%eax
    abff:	83 e0 fc             	and    $0xfffffffc,%eax
    ac02:	4a 8d 0c e5 00 00 00 	lea    0x0(,%r12,8),%rcx
    ac09:	00 
    ac0a:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    ac0e:	31 d2                	xor    %edx,%edx
    ac10:	41 0f 10 44 17 08    	movups 0x8(%r15,%rdx,1),%xmm0
    ac16:	41 0f 10 4c 17 18    	movups 0x18(%r15,%rdx,1),%xmm1
    ac1c:	41 0f 11 44 16 08    	movups %xmm0,0x8(%r14,%rdx,1)
    ac22:	41 0f 11 4c 16 18    	movups %xmm1,0x18(%r14,%rdx,1)
    ac28:	48 83 c2 20          	add    $0x20,%rdx
    ac2c:	48 39 d1             	cmp    %rdx,%rcx
    ac2f:	75 df                	jne    ac10 <fwp_apply+0x310>
    ac31:	4c 39 e0             	cmp    %r12,%rax
    ac34:	74 6b                	je     aca1 <fwp_apply+0x3a1>
    ac36:	4c 89 e2             	mov    %r12,%rdx
    ac39:	48 89 c1             	mov    %rax,%rcx
    ac3c:	48 83 e2 03          	and    $0x3,%rdx
    ac40:	74 20                	je     ac62 <fwp_apply+0x362>
    ac42:	48 89 c1             	mov    %rax,%rcx
    ac45:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    ac4c:	00 00 00 00 
    ac50:	49 8b 74 cf 08       	mov    0x8(%r15,%rcx,8),%rsi
    ac55:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    ac5a:	48 ff c1             	inc    %rcx
    ac5d:	48 ff ca             	dec    %rdx
    ac60:	75 ee                	jne    ac50 <fwp_apply+0x350>
    ac62:	4c 29 e0             	sub    %r12,%rax
    ac65:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    ac69:	77 36                	ja     aca1 <fwp_apply+0x3a1>
    ac6b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    ac70:	49 8b 44 cf 08       	mov    0x8(%r15,%rcx,8),%rax
    ac75:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    ac7a:	49 8b 44 cf 10       	mov    0x10(%r15,%rcx,8),%rax
    ac7f:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    ac84:	49 8b 44 cf 18       	mov    0x18(%r15,%rcx,8),%rax
    ac89:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    ac8e:	49 8b 44 cf 20       	mov    0x20(%r15,%rcx,8),%rax
    ac93:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    ac98:	48 83 c1 04          	add    $0x4,%rcx
    ac9c:	49 39 cc             	cmp    %rcx,%r12
    ac9f:	75 cf                	jne    ac70 <fwp_apply+0x370>
    aca1:	85 ff                	test   %edi,%edi
    aca3:	0f 84 92 00 00 00    	je     ad3b <fwp_apply+0x43b>
    aca9:	89 f8                	mov    %edi,%eax
    acab:	83 ff 14             	cmp    $0x14,%edi
    acae:	0f 83 99 00 00 00    	jae    ad4d <fwp_apply+0x44d>
    acb4:	31 c9                	xor    %ecx,%ecx
    acb6:	48 89 c6             	mov    %rax,%rsi
    acb9:	48 89 ca             	mov    %rcx,%rdx
    acbc:	48 83 e6 03          	and    $0x3,%rsi
    acc0:	74 23                	je     ace5 <fwp_apply+0x3e5>
    acc2:	48 89 ca             	mov    %rcx,%rdx
    acc5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    accc:	00 00 00 00 
    acd0:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    acd4:	45 8d 04 14          	lea    (%r12,%rdx,1),%r8d
    acd8:	4b 89 7c c6 08       	mov    %rdi,0x8(%r14,%r8,8)
    acdd:	48 ff c2             	inc    %rdx
    ace0:	48 ff ce             	dec    %rsi
    ace3:	75 eb                	jne    acd0 <fwp_apply+0x3d0>
    ace5:	48 29 c1             	sub    %rax,%rcx
    ace8:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    acec:	77 4d                	ja     ad3b <fwp_apply+0x43b>
    acee:	66 90                	xchg   %ax,%ax
    acf0:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    acf4:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    acf8:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    acfd:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    ad02:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    ad06:	ff c6                	inc    %esi
    ad08:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    ad0d:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    ad12:	41 8d 74 14 02       	lea    0x2(%r12,%rdx,1),%esi
    ad17:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    ad1c:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    ad21:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    ad25:	83 c6 03             	add    $0x3,%esi
    ad28:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    ad2d:	48 83 c2 04          	add    $0x4,%rdx
    ad31:	48 39 d0             	cmp    %rdx,%rax
    ad34:	75 ba                	jne    acf0 <fwp_apply+0x3f0>
    ad36:	eb 03                	jmp    ad3b <fwp_apply+0x43b>
    ad38:	4d 89 fe             	mov    %r15,%r14
    ad3b:	4c 89 f0             	mov    %r14,%rax
    ad3e:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    ad42:	5b                   	pop    %rbx
    ad43:	41 5c                	pop    %r12
    ad45:	41 5d                	pop    %r13
    ad47:	41 5e                	pop    %r14
    ad49:	41 5f                	pop    %r15
    ad4b:	5d                   	pop    %rbp
    ad4c:	c3                   	ret
    ad4d:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    ad51:	31 c9                	xor    %ecx,%ecx
    ad53:	89 d6                	mov    %edx,%esi
    ad55:	44 01 e6             	add    %r12d,%esi
    ad58:	0f 82 58 ff ff ff    	jb     acb6 <fwp_apply+0x3b6>
    ad5e:	48 c1 ea 20          	shr    $0x20,%rdx
    ad62:	0f 85 4e ff ff ff    	jne    acb6 <fwp_apply+0x3b6>
    ad68:	4b 8d 0c e6          	lea    (%r14,%r12,8),%rcx
    ad6c:	48 29 d9             	sub    %rbx,%rcx
    ad6f:	48 83 c1 08          	add    $0x8,%rcx
    ad73:	48 83 f9 20          	cmp    $0x20,%rcx
    ad77:	0f 82 37 ff ff ff    	jb     acb4 <fwp_apply+0x3b4>
    ad7d:	89 c1                	mov    %eax,%ecx
    ad7f:	83 e1 fc             	and    $0xfffffffc,%ecx
    ad82:	31 d2                	xor    %edx,%edx
    ad84:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    ad8b:	00 00 00 00 00 
    ad90:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    ad94:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    ad99:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    ad9d:	41 0f 11 44 f6 08    	movups %xmm0,0x8(%r14,%rsi,8)
    ada3:	41 0f 11 4c f6 18    	movups %xmm1,0x18(%r14,%rsi,8)
    ada9:	48 83 c2 04          	add    $0x4,%rdx
    adad:	48 39 d1             	cmp    %rdx,%rcx
    adb0:	75 de                	jne    ad90 <fwp_apply+0x490>
    adb2:	48 39 c1             	cmp    %rax,%rcx
    adb5:	0f 85 fb fe ff ff    	jne    acb6 <fwp_apply+0x3b6>
    adbb:	e9 7b ff ff ff       	jmp    ad3b <fwp_apply+0x43b>

000000000000adc0 <fwp_pap>:
    adc0:	50                   	push   %rax
    adc1:	bf 08 00 00 00       	mov    $0x8,%edi
    adc6:	e8 55 a9 ff ff       	call   5720 <fwp_alloc>
    adcb:	48 c7 00 03 00 00 00 	movq   $0x3,(%rax)
    add2:	59                   	pop    %rcx
    add3:	c3                   	ret
    add4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    addb:	00 00 00 00 00 

000000000000ade0 <fwp_exec_error>:
    ade0:	41 57                	push   %r15
    ade2:	41 56                	push   %r14
    ade4:	53                   	push   %rbx
    ade5:	48 89 f3             	mov    %rsi,%rbx
    ade8:	49 89 fe             	mov    %rdi,%r14
    adeb:	e8 90 bd ff ff       	call   6b80 <fwp_pipe_flush>
    adf0:	4c 8b 3d e9 91 00 00 	mov    0x91e9(%rip),%r15        # 13fe0 <stderr@GLIBC_2.2.5>
    adf7:	49 8b 3f             	mov    (%r15),%rdi
    adfa:	48 8d 35 33 45 00 00 	lea    0x4533(%rip),%rsi        # f334 <exec_in_fp0+0xcd4>
    ae01:	48 8d 15 a1 38 00 00 	lea    0x38a1(%rip),%rdx        # e6a9 <exec_in_fp0+0x49>
    ae08:	31 c0                	xor    %eax,%eax
    ae0a:	e8 d1 74 ff ff       	call   22e0 <fprintf@plt>
    ae0f:	83 3b 10             	cmpl   $0x10,(%rbx)
    ae12:	75 1f                	jne    ae33 <fwp_exec_error+0x53>
    ae14:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    ae18:	48 85 ff             	test   %rdi,%rdi
    ae1b:	74 16                	je     ae33 <fwp_exec_error+0x53>
    ae1d:	48 8d 35 15 45 00 00 	lea    0x4515(%rip),%rsi        # f339 <exec_in_fp0+0xcd9>
    ae24:	e8 97 74 ff ff       	call   22c0 <strcmp@plt>
    ae29:	85 c0                	test   %eax,%eax
    ae2b:	75 06                	jne    ae33 <fwp_exec_error+0x53>
    ae2d:	83 7b 10 02          	cmpl   $0x2,0x10(%rbx)
    ae31:	74 20                	je     ae53 <fwp_exec_error+0x73>
    ae33:	49 8b 17             	mov    (%r15),%rdx
    ae36:	4c 89 f7             	mov    %r14,%rdi
    ae39:	48 89 de             	mov    %rbx,%rsi
    ae3c:	e8 2f 00 00 00       	call   ae70 <fwp_display_top>
    ae41:	49 8b 37             	mov    (%r15),%rsi
    ae44:	bf 0a 00 00 00       	mov    $0xa,%edi
    ae49:	5b                   	pop    %rbx
    ae4a:	41 5e                	pop    %r14
    ae4c:	41 5f                	pop    %r15
    ae4e:	e9 dd 73 ff ff       	jmp    2230 <fputc@plt>
    ae53:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    ae57:	48 8b 17             	mov    (%rdi),%rdx
    ae5a:	48 83 c7 08          	add    $0x8,%rdi
    ae5e:	49 8b 0f             	mov    (%r15),%rcx
    ae61:	be 01 00 00 00       	mov    $0x1,%esi
    ae66:	e8 25 76 ff ff       	call   2490 <fwrite@plt>
    ae6b:	eb d4                	jmp    ae41 <fwp_exec_error+0x61>
    ae6d:	0f 1f 00             	nopl   (%rax)

000000000000ae70 <fwp_display_top>:
    ae70:	53                   	push   %rbx
    ae71:	48 83 ec 20          	sub    $0x20,%rsp
    ae75:	48 89 d3             	mov    %rdx,%rbx
    ae78:	48 89 f2             	mov    %rsi,%rdx
    ae7b:	48 89 fe             	mov    %rdi,%rsi
    ae7e:	0f 57 c0             	xorps  %xmm0,%xmm0
    ae81:	0f 29 04 24          	movaps %xmm0,(%rsp)
    ae85:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    ae8c:	00 00 
    ae8e:	48 89 e7             	mov    %rsp,%rdi
    ae91:	b9 01 00 00 00       	mov    $0x1,%ecx
    ae96:	e8 35 00 00 00       	call   aed0 <fwp_write>
    ae9b:	48 8b 3c 24          	mov    (%rsp),%rdi
    ae9f:	48 85 ff             	test   %rdi,%rdi
    aea2:	74 18                	je     aebc <fwp_display_top+0x4c>
    aea4:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    aea9:	be 01 00 00 00       	mov    $0x1,%esi
    aeae:	48 89 d9             	mov    %rbx,%rcx
    aeb1:	e8 da 75 ff ff       	call   2490 <fwrite@plt>
    aeb6:	48 8b 3c 24          	mov    (%rsp),%rdi
    aeba:	eb 02                	jmp    aebe <fwp_display_top+0x4e>
    aebc:	31 ff                	xor    %edi,%edi
    aebe:	e8 8d 71 ff ff       	call   2050 <free@plt>
    aec3:	48 83 c4 20          	add    $0x20,%rsp
    aec7:	5b                   	pop    %rbx
    aec8:	c3                   	ret
    aec9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000aed0 <fwp_write>:
    aed0:	55                   	push   %rbp
    aed1:	41 57                	push   %r15
    aed3:	41 56                	push   %r14
    aed5:	41 55                	push   %r13
    aed7:	41 54                	push   %r12
    aed9:	53                   	push   %rbx
    aeda:	48 81 ec 28 02 00 00 	sub    $0x228,%rsp
    aee1:	8b 02                	mov    (%rdx),%eax
    aee3:	48 83 f8 19          	cmp    $0x19,%rax
    aee7:	0f 87 3f 05 00 00    	ja     b42c <fwp_write+0x55c>
    aeed:	49 89 f5             	mov    %rsi,%r13
    aef0:	48 89 fb             	mov    %rdi,%rbx
    aef3:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
    aef8:	48 8d 15 55 34 00 00 	lea    0x3455(%rip),%rdx        # e354 <_IO_stdin_used+0x354>
    aeff:	48 63 34 82          	movslq (%rdx,%rax,4),%rsi
    af03:	48 01 d6             	add    %rdx,%rsi
    af06:	ff e6                	jmp    *%rsi
    af08:	48 8d 15 32 44 00 00 	lea    0x4432(%rip),%rdx        # f341 <exec_in_fp0+0xce1>
    af0f:	eb 07                	jmp    af18 <fwp_write+0x48>
    af11:	48 8d 15 f1 43 00 00 	lea    0x43f1(%rip),%rdx        # f309 <exec_in_fp0+0xca9>
    af18:	4c 8d 7c 24 20       	lea    0x20(%rsp),%r15
    af1d:	be 00 02 00 00       	mov    $0x200,%esi
    af22:	4c 89 ff             	mov    %r15,%rdi
    af25:	4c 89 e9             	mov    %r13,%rcx
    af28:	31 c0                	xor    %eax,%eax
    af2a:	e8 91 72 ff ff       	call   21c0 <snprintf@plt>
    af2f:	48 89 df             	mov    %rbx,%rdi
    af32:	4c 89 fe             	mov    %r15,%rsi
    af35:	e9 ed 04 00 00       	jmp    b427 <fwp_write+0x557>
    af3a:	83 f8 13             	cmp    $0x13,%eax
    af3d:	48 8d 05 2e 44 00 00 	lea    0x442e(%rip),%rax        # f372 <exec_in_fp0+0xd12>
    af44:	48 8d 35 2c 44 00 00 	lea    0x442c(%rip),%rsi        # f377 <exec_in_fp0+0xd17>
    af4b:	48 0f 44 f0          	cmove  %rax,%rsi
    af4f:	48 89 df             	mov    %rbx,%rdi
    af52:	e8 19 ca ff ff       	call   7970 <buf_puts>
    af57:	49 83 7d 00 00       	cmpq   $0x0,0x0(%r13)
    af5c:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    af61:	0f 84 cb 00 00 00    	je     b032 <fwp_write+0x162>
    af67:	4d 89 ec             	mov    %r13,%r12
    af6a:	48 8b 50 38          	mov    0x38(%rax),%rdx
    af6e:	48 89 df             	mov    %rbx,%rdi
    af71:	4c 89 eb             	mov    %r13,%rbx
    af74:	49 8b 74 24 08       	mov    0x8(%r12),%rsi
    af79:	49 89 c6             	mov    %rax,%r14
    af7c:	49 89 ff             	mov    %rdi,%r15
    af7f:	31 c9                	xor    %ecx,%ecx
    af81:	e8 4a ff ff ff       	call   aed0 <fwp_write>
    af86:	41 83 3e 12          	cmpl   $0x12,(%r14)
    af8a:	75 29                	jne    afb5 <fwp_write+0xe5>
    af8c:	48 8d 35 a3 43 00 00 	lea    0x43a3(%rip),%rsi        # f336 <exec_in_fp0+0xcd6>
    af93:	4d 89 fe             	mov    %r15,%r14
    af96:	4c 89 ff             	mov    %r15,%rdi
    af99:	e8 d2 c9 ff ff       	call   7970 <buf_puts>
    af9e:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    afa2:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    afa7:	48 8b 50 40          	mov    0x40(%rax),%rdx
    afab:	4c 89 ff             	mov    %r15,%rdi
    afae:	31 c9                	xor    %ecx,%ecx
    afb0:	e8 1b ff ff ff       	call   aed0 <fwp_write>
    afb5:	48 83 3b 02          	cmpq   $0x2,(%rbx)
    afb9:	4c 89 fb             	mov    %r15,%rbx
    afbc:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    afc1:	72 6f                	jb     b032 <fwp_write+0x162>
    afc3:	4d 8d 74 24 20       	lea    0x20(%r12),%r14
    afc8:	bd 01 00 00 00       	mov    $0x1,%ebp
    afcd:	4c 8d 2d b7 42 00 00 	lea    0x42b7(%rip),%r13        # f28b <exec_in_fp0+0xc2b>
    afd4:	eb 17                	jmp    afed <fwp_write+0x11d>
    afd6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    afdd:	00 00 00 
    afe0:	48 ff c5             	inc    %rbp
    afe3:	49 83 c6 10          	add    $0x10,%r14
    afe7:	49 3b 2c 24          	cmp    (%r12),%rbp
    afeb:	73 45                	jae    b032 <fwp_write+0x162>
    afed:	48 89 df             	mov    %rbx,%rdi
    aff0:	4c 89 ee             	mov    %r13,%rsi
    aff3:	e8 78 c9 ff ff       	call   7970 <buf_puts>
    aff8:	49 8b 76 f8          	mov    -0x8(%r14),%rsi
    affc:	49 8b 57 38          	mov    0x38(%r15),%rdx
    b000:	48 89 df             	mov    %rbx,%rdi
    b003:	31 c9                	xor    %ecx,%ecx
    b005:	e8 c6 fe ff ff       	call   aed0 <fwp_write>
    b00a:	41 83 3f 12          	cmpl   $0x12,(%r15)
    b00e:	75 d0                	jne    afe0 <fwp_write+0x110>
    b010:	48 89 df             	mov    %rbx,%rdi
    b013:	48 8d 35 1c 43 00 00 	lea    0x431c(%rip),%rsi        # f336 <exec_in_fp0+0xcd6>
    b01a:	e8 51 c9 ff ff       	call   7970 <buf_puts>
    b01f:	49 8b 36             	mov    (%r14),%rsi
    b022:	49 8b 57 40          	mov    0x40(%r15),%rdx
    b026:	48 89 df             	mov    %rbx,%rdi
    b029:	31 c9                	xor    %ecx,%ecx
    b02b:	e8 a0 fe ff ff       	call   aed0 <fwp_write>
    b030:	eb ae                	jmp    afe0 <fwp_write+0x110>
    b032:	48 89 df             	mov    %rbx,%rdi
    b035:	be 7d 00 00 00       	mov    $0x7d,%esi
    b03a:	e9 48 05 00 00       	jmp    b587 <fwp_write+0x6b7>
    b03f:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    b044:	4d 8b 67 08          	mov    0x8(%r15),%r12
    b048:	4d 85 e4             	test   %r12,%r12
    b04b:	0f 84 38 04 00 00    	je     b489 <fwp_write+0x5b9>
    b051:	48 8d 35 50 42 00 00 	lea    0x4250(%rip),%rsi        # f2a8 <exec_in_fp0+0xc48>
    b058:	4c 89 e7             	mov    %r12,%rdi
    b05b:	e8 60 72 ff ff       	call   22c0 <strcmp@plt>
    b060:	85 c0                	test   %eax,%eax
    b062:	0f 84 44 05 00 00    	je     b5ac <fwp_write+0x6dc>
    b068:	4d 8d 77 10          	lea    0x10(%r15),%r14
    b06c:	48 89 df             	mov    %rbx,%rdi
    b06f:	4c 89 e6             	mov    %r12,%rsi
    b072:	e8 f9 c8 ff ff       	call   7970 <buf_puts>
    b077:	48 89 df             	mov    %rbx,%rdi
    b07a:	be 20 00 00 00       	mov    $0x20,%esi
    b07f:	e8 cc c8 ff ff       	call   7950 <buf_putc>
    b084:	31 ed                	xor    %ebp,%ebp
    b086:	e9 1f 04 00 00       	jmp    b4aa <fwp_write+0x5da>
    b08b:	4c 89 ef             	mov    %r13,%rdi
    b08e:	e8 cd ef ff ff       	call   a060 <fwp_tag>
    b093:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    b098:	49 8b 4f 18          	mov    0x18(%r15),%rcx
    b09c:	41 89 c6             	mov    %eax,%r14d
    b09f:	4a 8b 34 f1          	mov    (%rcx,%r14,8),%rsi
    b0a3:	48 89 df             	mov    %rbx,%rdi
    b0a6:	e8 c5 c8 ff ff       	call   7970 <buf_puts>
    b0ab:	49 8b 47 28          	mov    0x28(%r15),%rax
    b0af:	42 83 3c b0 00       	cmpl   $0x0,(%rax,%r14,4)
    b0b4:	0f 8e 72 03 00 00    	jle    b42c <fwp_write+0x55c>
    b0ba:	4c 89 f1             	mov    %r14,%rcx
    b0bd:	45 31 f6             	xor    %r14d,%r14d
    b0c0:	4c 89 6c 24 18       	mov    %r13,0x18(%rsp)
    b0c5:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
    b0ca:	eb 3d                	jmp    b109 <fwp_write+0x239>
    b0cc:	0f 1f 40 00          	nopl   0x0(%rax)
    b0d0:	48 89 dd             	mov    %rbx,%rbp
    b0d3:	48 89 df             	mov    %rbx,%rdi
    b0d6:	4c 89 e6             	mov    %r12,%rsi
    b0d9:	4c 89 ea             	mov    %r13,%rdx
    b0dc:	31 c9                	xor    %ecx,%ecx
    b0de:	e8 ed fd ff ff       	call   aed0 <fwp_write>
    b0e3:	49 ff c6             	inc    %r14
    b0e6:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    b0eb:	49 8b 47 28          	mov    0x28(%r15),%rax
    b0ef:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    b0f4:	48 63 04 88          	movslq (%rax,%rcx,4),%rax
    b0f8:	49 39 c6             	cmp    %rax,%r14
    b0fb:	4c 8b 6c 24 18       	mov    0x18(%rsp),%r13
    b100:	48 89 eb             	mov    %rbp,%rbx
    b103:	0f 8d 23 03 00 00    	jge    b42c <fwp_write+0x55c>
    b109:	4f 8b 64 f5 08       	mov    0x8(%r13,%r14,8),%r12
    b10e:	49 8b 47 30          	mov    0x30(%r15),%rax
    b112:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    b116:	4e 8b 2c f0          	mov    (%rax,%r14,8),%r13
    b11a:	48 89 df             	mov    %rbx,%rdi
    b11d:	be 20 00 00 00       	mov    $0x20,%esi
    b122:	e8 29 c8 ff ff       	call   7950 <buf_putc>
    b127:	4c 89 e7             	mov    %r12,%rdi
    b12a:	4c 89 ee             	mov    %r13,%rsi
    b12d:	e8 8e 0e 00 00       	call   bfc0 <fwp_needs_parens>
    b132:	85 c0                	test   %eax,%eax
    b134:	74 9a                	je     b0d0 <fwp_write+0x200>
    b136:	48 89 df             	mov    %rbx,%rdi
    b139:	be 28 00 00 00       	mov    $0x28,%esi
    b13e:	e8 0d c8 ff ff       	call   7950 <buf_putc>
    b143:	48 89 df             	mov    %rbx,%rdi
    b146:	4c 89 e6             	mov    %r12,%rsi
    b149:	4c 89 ea             	mov    %r13,%rdx
    b14c:	31 c9                	xor    %ecx,%ecx
    b14e:	e8 7d fd ff ff       	call   aed0 <fwp_write>
    b153:	48 89 dd             	mov    %rbx,%rbp
    b156:	48 89 df             	mov    %rbx,%rdi
    b159:	be 29 00 00 00       	mov    $0x29,%esi
    b15e:	e8 ed c7 ff ff       	call   7950 <buf_putc>
    b163:	e9 7b ff ff ff       	jmp    b0e3 <fwp_write+0x213>
    b168:	4c 89 ef             	mov    %r13,%rdi
    b16b:	e8 a0 7e ff ff       	call   3010 <fwp_f64>
    b170:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    b175:	4c 89 f7             	mov    %r14,%rdi
    b178:	e8 93 08 00 00       	call   ba10 <fwp_fmt_f64>
    b17d:	e9 9f 02 00 00       	jmp    b421 <fwp_write+0x551>
    b182:	48 89 df             	mov    %rbx,%rdi
    b185:	be 3c 00 00 00       	mov    $0x3c,%esi
    b18a:	e8 c1 c7 ff ff       	call   7950 <buf_putc>
    b18f:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    b194:	48 8b 70 08          	mov    0x8(%rax),%rsi
    b198:	48 89 df             	mov    %rbx,%rdi
    b19b:	e9 d7 02 00 00       	jmp    b477 <fwp_write+0x5a7>
    b1a0:	48 8d 35 aa 41 00 00 	lea    0x41aa(%rip),%rsi        # f351 <exec_in_fp0+0xcf1>
    b1a7:	e9 99 02 00 00       	jmp    b445 <fwp_write+0x575>
    b1ac:	49 8d 75 08          	lea    0x8(%r13),%rsi
    b1b0:	49 8b 55 00          	mov    0x0(%r13),%rdx
    b1b4:	48 89 df             	mov    %rbx,%rdi
    b1b7:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b1be:	85 c9                	test   %ecx,%ecx
    b1c0:	0f 84 d7 03 00 00    	je     b59d <fwp_write+0x6cd>
    b1c6:	5b                   	pop    %rbx
    b1c7:	41 5c                	pop    %r12
    b1c9:	41 5d                	pop    %r13
    b1cb:	41 5e                	pop    %r14
    b1cd:	41 5f                	pop    %r15
    b1cf:	5d                   	pop    %rbp
    b1d0:	e9 cb c7 ff ff       	jmp    79a0 <buf_put>
    b1d5:	4c 89 ef             	mov    %r13,%rdi
    b1d8:	e8 43 ee ff ff       	call   a020 <fwp_u128>
    b1dd:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    b1e2:	4c 89 f7             	mov    %r14,%rdi
    b1e5:	48 89 c6             	mov    %rax,%rsi
    b1e8:	e8 13 04 00 00       	call   b600 <fwp_fmt_u128>
    b1ed:	e9 2f 02 00 00       	jmp    b421 <fwp_write+0x551>
    b1f2:	4c 89 ef             	mov    %r13,%rdi
    b1f5:	e8 16 ee ff ff       	call   a010 <fwp_i128>
    b1fa:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    b1ff:	4c 89 f7             	mov    %r14,%rdi
    b202:	48 89 c6             	mov    %rax,%rsi
    b205:	e8 d6 03 00 00       	call   b5e0 <fwp_fmt_i128>
    b20a:	e9 12 02 00 00       	jmp    b421 <fwp_write+0x551>
    b20f:	48 89 df             	mov    %rbx,%rdi
    b212:	be 5b 00 00 00       	mov    $0x5b,%esi
    b217:	e8 34 c7 ff ff       	call   7950 <buf_putc>
    b21c:	4d 85 ed             	test   %r13,%r13
    b21f:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    b224:	0f 84 d5 01 00 00    	je     b3ff <fwp_write+0x52f>
    b22a:	49 8b 57 38          	mov    0x38(%r15),%rdx
    b22e:	49 8b 75 08          	mov    0x8(%r13),%rsi
    b232:	48 89 df             	mov    %rbx,%rdi
    b235:	31 c9                	xor    %ecx,%ecx
    b237:	e8 94 fc ff ff       	call   aed0 <fwp_write>
    b23c:	4d 8b 65 10          	mov    0x10(%r13),%r12
    b240:	4d 85 e4             	test   %r12,%r12
    b243:	0f 84 b6 01 00 00    	je     b3ff <fwp_write+0x52f>
    b249:	4c 8d 35 3b 40 00 00 	lea    0x403b(%rip),%r14        # f28b <exec_in_fp0+0xc2b>
    b250:	48 89 df             	mov    %rbx,%rdi
    b253:	4c 89 f6             	mov    %r14,%rsi
    b256:	e8 15 c7 ff ff       	call   7970 <buf_puts>
    b25b:	49 8b 74 24 08       	mov    0x8(%r12),%rsi
    b260:	49 8b 57 38          	mov    0x38(%r15),%rdx
    b264:	48 89 df             	mov    %rbx,%rdi
    b267:	31 c9                	xor    %ecx,%ecx
    b269:	e8 62 fc ff ff       	call   aed0 <fwp_write>
    b26e:	4d 8b 64 24 10       	mov    0x10(%r12),%r12
    b273:	4d 85 e4             	test   %r12,%r12
    b276:	75 d8                	jne    b250 <fwp_write+0x380>
    b278:	e9 82 01 00 00       	jmp    b3ff <fwp_write+0x52f>
    b27d:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    b282:	8b 50 48             	mov    0x48(%rax),%edx
    b285:	48 89 df             	mov    %rbx,%rdi
    b288:	4c 89 ee             	mov    %r13,%rsi
    b28b:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b292:	5b                   	pop    %rbx
    b293:	41 5c                	pop    %r12
    b295:	41 5d                	pop    %r13
    b297:	41 5e                	pop    %r14
    b299:	41 5f                	pop    %r15
    b29b:	5d                   	pop    %rbp
    b29c:	e9 2f 08 00 00       	jmp    bad0 <fwp_trits>
    b2a1:	49 83 fd ff          	cmp    $0xffffffffffffffff,%r13
    b2a5:	48 8d 05 eb 3f 00 00 	lea    0x3feb(%rip),%rax        # f297 <exec_in_fp0+0xc37>
    b2ac:	48 8d 0d e5 40 00 00 	lea    0x40e5(%rip),%rcx        # f398 <exec_in_fp0+0xd38>
    b2b3:	48 0f 44 c8          	cmove  %rax,%rcx
    b2b7:	49 83 fd 01          	cmp    $0x1,%r13
    b2bb:	48 8d 35 d2 3f 00 00 	lea    0x3fd2(%rip),%rsi        # f294 <exec_in_fp0+0xc34>
    b2c2:	48 0f 45 f1          	cmovne %rcx,%rsi
    b2c6:	e9 7a 01 00 00       	jmp    b445 <fwp_write+0x575>
    b2cb:	48 8d 35 99 40 00 00 	lea    0x4099(%rip),%rsi        # f36b <exec_in_fp0+0xd0b>
    b2d2:	48 89 df             	mov    %rbx,%rdi
    b2d5:	e8 96 c6 ff ff       	call   7970 <buf_puts>
    b2da:	49 83 7d 00 00       	cmpq   $0x0,0x0(%r13)
    b2df:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    b2e4:	0f 84 15 01 00 00    	je     b3ff <fwp_write+0x52f>
    b2ea:	49 8b 57 38          	mov    0x38(%r15),%rdx
    b2ee:	49 8b 75 08          	mov    0x8(%r13),%rsi
    b2f2:	48 89 df             	mov    %rbx,%rdi
    b2f5:	31 c9                	xor    %ecx,%ecx
    b2f7:	e8 d4 fb ff ff       	call   aed0 <fwp_write>
    b2fc:	49 83 7d 00 02       	cmpq   $0x2,0x0(%r13)
    b301:	0f 82 f8 00 00 00    	jb     b3ff <fwp_write+0x52f>
    b307:	41 be 01 00 00 00    	mov    $0x1,%r14d
    b30d:	4c 8d 25 77 3f 00 00 	lea    0x3f77(%rip),%r12        # f28b <exec_in_fp0+0xc2b>
    b314:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b31b:	00 00 00 00 00 
    b320:	48 89 df             	mov    %rbx,%rdi
    b323:	4c 89 e6             	mov    %r12,%rsi
    b326:	e8 45 c6 ff ff       	call   7970 <buf_puts>
    b32b:	4b 8b 74 f5 08       	mov    0x8(%r13,%r14,8),%rsi
    b330:	49 8b 57 38          	mov    0x38(%r15),%rdx
    b334:	48 89 df             	mov    %rbx,%rdi
    b337:	31 c9                	xor    %ecx,%ecx
    b339:	e8 92 fb ff ff       	call   aed0 <fwp_write>
    b33e:	49 ff c6             	inc    %r14
    b341:	4d 3b 75 00          	cmp    0x0(%r13),%r14
    b345:	72 d9                	jb     b320 <fwp_write+0x450>
    b347:	e9 b3 00 00 00       	jmp    b3ff <fwp_write+0x52f>
    b34c:	48 8d 35 0e 40 00 00 	lea    0x400e(%rip),%rsi        # f361 <exec_in_fp0+0xd01>
    b353:	48 89 df             	mov    %rbx,%rdi
    b356:	e8 15 c6 ff ff       	call   7970 <buf_puts>
    b35b:	49 83 7d 00 00       	cmpq   $0x0,0x0(%r13)
    b360:	0f 84 99 00 00 00    	je     b3ff <fwp_write+0x52f>
    b366:	4c 89 ed             	mov    %r13,%rbp
    b369:	41 0f b6 4d 08       	movzbl 0x8(%r13),%ecx
    b36e:	48 8d 15 f3 3f 00 00 	lea    0x3ff3(%rip),%rdx        # f368 <exec_in_fp0+0xd08>
    b375:	4c 8d 7c 24 20       	lea    0x20(%rsp),%r15
    b37a:	be 00 02 00 00       	mov    $0x200,%esi
    b37f:	4c 89 ff             	mov    %r15,%rdi
    b382:	31 c0                	xor    %eax,%eax
    b384:	e8 37 6e ff ff       	call   21c0 <snprintf@plt>
    b389:	48 89 df             	mov    %rbx,%rdi
    b38c:	4c 89 fe             	mov    %r15,%rsi
    b38f:	e8 dc c5 ff ff       	call   7970 <buf_puts>
    b394:	49 83 7d 00 02       	cmpq   $0x2,0x0(%r13)
    b399:	72 64                	jb     b3ff <fwp_write+0x52f>
    b39b:	41 be 09 00 00 00    	mov    $0x9,%r14d
    b3a1:	4c 8d 3d e3 3e 00 00 	lea    0x3ee3(%rip),%r15        # f28b <exec_in_fp0+0xc2b>
    b3a8:	4c 8d 25 b9 3f 00 00 	lea    0x3fb9(%rip),%r12        # f368 <exec_in_fp0+0xd08>
    b3af:	4c 8d 6c 24 20       	lea    0x20(%rsp),%r13
    b3b4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b3bb:	00 00 00 00 00 
    b3c0:	48 89 df             	mov    %rbx,%rdi
    b3c3:	4c 89 fe             	mov    %r15,%rsi
    b3c6:	e8 a5 c5 ff ff       	call   7970 <buf_puts>
    b3cb:	42 0f b6 4c 35 00    	movzbl 0x0(%rbp,%r14,1),%ecx
    b3d1:	be 00 02 00 00       	mov    $0x200,%esi
    b3d6:	4c 89 ef             	mov    %r13,%rdi
    b3d9:	4c 89 e2             	mov    %r12,%rdx
    b3dc:	31 c0                	xor    %eax,%eax
    b3de:	e8 dd 6d ff ff       	call   21c0 <snprintf@plt>
    b3e3:	48 89 df             	mov    %rbx,%rdi
    b3e6:	4c 89 ee             	mov    %r13,%rsi
    b3e9:	e8 82 c5 ff ff       	call   7970 <buf_puts>
    b3ee:	49 8d 46 01          	lea    0x1(%r14),%rax
    b3f2:	49 83 c6 f9          	add    $0xfffffffffffffff9,%r14
    b3f6:	4c 3b 75 00          	cmp    0x0(%rbp),%r14
    b3fa:	49 89 c6             	mov    %rax,%r14
    b3fd:	72 c1                	jb     b3c0 <fwp_write+0x4f0>
    b3ff:	48 89 df             	mov    %rbx,%rdi
    b402:	be 5d 00 00 00       	mov    $0x5d,%esi
    b407:	e9 7b 01 00 00       	jmp    b587 <fwp_write+0x6b7>
    b40c:	4c 89 ef             	mov    %r13,%rdi
    b40f:	e8 8c 9b ff ff       	call   4fa0 <fwp_f32>
    b414:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    b419:	4c 89 f7             	mov    %r14,%rdi
    b41c:	e8 ef 03 00 00       	call   b810 <fwp_fmt_f32>
    b421:	48 89 df             	mov    %rbx,%rdi
    b424:	4c 89 f6             	mov    %r14,%rsi
    b427:	e8 44 c5 ff ff       	call   7970 <buf_puts>
    b42c:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b433:	5b                   	pop    %rbx
    b434:	41 5c                	pop    %r12
    b436:	41 5d                	pop    %r13
    b438:	41 5e                	pop    %r14
    b43a:	41 5f                	pop    %r15
    b43c:	5d                   	pop    %rbp
    b43d:	c3                   	ret
    b43e:	48 8d 35 01 3f 00 00 	lea    0x3f01(%rip),%rsi        # f346 <exec_in_fp0+0xce6>
    b445:	48 89 df             	mov    %rbx,%rdi
    b448:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b44f:	5b                   	pop    %rbx
    b450:	41 5c                	pop    %r12
    b452:	41 5d                	pop    %r13
    b454:	41 5e                	pop    %r14
    b456:	41 5f                	pop    %r15
    b458:	5d                   	pop    %rbp
    b459:	e9 12 c5 ff ff       	jmp    7970 <buf_puts>
    b45e:	48 8d 35 f5 3e 00 00 	lea    0x3ef5(%rip),%rsi        # f35a <exec_in_fp0+0xcfa>
    b465:	48 89 df             	mov    %rbx,%rdi
    b468:	e8 03 c5 ff ff       	call   7970 <buf_puts>
    b46d:	49 83 c5 10          	add    $0x10,%r13
    b471:	48 89 df             	mov    %rbx,%rdi
    b474:	4c 89 ee             	mov    %r13,%rsi
    b477:	e8 f4 c4 ff ff       	call   7970 <buf_puts>
    b47c:	48 89 df             	mov    %rbx,%rdi
    b47f:	be 3e 00 00 00       	mov    $0x3e,%esi
    b484:	e9 fe 00 00 00       	jmp    b587 <fwp_write+0x6b7>
    b489:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    b48e:	0f 84 35 01 00 00    	je     b5c9 <fwp_write+0x6f9>
    b494:	4d 8d 77 10          	lea    0x10(%r15),%r14
    b498:	4d 85 e4             	test   %r12,%r12
    b49b:	0f 94 c0             	sete   %al
    b49e:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
    b4a3:	40 0f 95 c5          	setne  %bpl
    b4a7:	40 20 c5             	and    %al,%bpl
    b4aa:	40 84 ed             	test   %bpl,%bpl
    b4ad:	b8 28 00 00 00       	mov    $0x28,%eax
    b4b2:	be 7b 00 00 00       	mov    $0x7b,%esi
    b4b7:	0f 45 f0             	cmovne %eax,%esi
    b4ba:	48 89 df             	mov    %rbx,%rdi
    b4bd:	e8 8e c4 ff ff       	call   7950 <buf_putc>
    b4c2:	41 83 3e 00          	cmpl   $0x0,(%r14)
    b4c6:	0f 8e a8 00 00 00    	jle    b574 <fwp_write+0x6a4>
    b4cc:	40 84 ed             	test   %bpl,%bpl
    b4cf:	75 1e                	jne    b4ef <fwp_write+0x61f>
    b4d1:	49 8b 47 18          	mov    0x18(%r15),%rax
    b4d5:	48 8b 30             	mov    (%rax),%rsi
    b4d8:	48 89 df             	mov    %rbx,%rdi
    b4db:	e8 90 c4 ff ff       	call   7970 <buf_puts>
    b4e0:	48 8d 35 98 3e 00 00 	lea    0x3e98(%rip),%rsi        # f37f <exec_in_fp0+0xd1f>
    b4e7:	48 89 df             	mov    %rbx,%rdi
    b4ea:	e8 81 c4 ff ff       	call   7970 <buf_puts>
    b4ef:	49 8b 75 08          	mov    0x8(%r13),%rsi
    b4f3:	49 8b 47 20          	mov    0x20(%r15),%rax
    b4f7:	48 8b 10             	mov    (%rax),%rdx
    b4fa:	48 89 df             	mov    %rbx,%rdi
    b4fd:	31 c9                	xor    %ecx,%ecx
    b4ff:	e8 cc f9 ff ff       	call   aed0 <fwp_write>
    b504:	41 83 7f 10 02       	cmpl   $0x2,0x10(%r15)
    b509:	7c 69                	jl     b574 <fwp_write+0x6a4>
    b50b:	41 be 01 00 00 00    	mov    $0x1,%r14d
    b511:	4c 8d 25 73 3d 00 00 	lea    0x3d73(%rip),%r12        # f28b <exec_in_fp0+0xc2b>
    b518:	eb 29                	jmp    b543 <fwp_write+0x673>
    b51a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    b520:	4b 8b 74 f5 08       	mov    0x8(%r13,%r14,8),%rsi
    b525:	49 8b 47 20          	mov    0x20(%r15),%rax
    b529:	4a 8b 14 f0          	mov    (%rax,%r14,8),%rdx
    b52d:	48 89 df             	mov    %rbx,%rdi
    b530:	31 c9                	xor    %ecx,%ecx
    b532:	e8 99 f9 ff ff       	call   aed0 <fwp_write>
    b537:	49 ff c6             	inc    %r14
    b53a:	49 63 47 10          	movslq 0x10(%r15),%rax
    b53e:	49 39 c6             	cmp    %rax,%r14
    b541:	7d 31                	jge    b574 <fwp_write+0x6a4>
    b543:	48 89 df             	mov    %rbx,%rdi
    b546:	4c 89 e6             	mov    %r12,%rsi
    b549:	e8 22 c4 ff ff       	call   7970 <buf_puts>
    b54e:	40 84 ed             	test   %bpl,%bpl
    b551:	75 cd                	jne    b520 <fwp_write+0x650>
    b553:	49 8b 47 18          	mov    0x18(%r15),%rax
    b557:	4a 8b 34 f0          	mov    (%rax,%r14,8),%rsi
    b55b:	48 89 df             	mov    %rbx,%rdi
    b55e:	e8 0d c4 ff ff       	call   7970 <buf_puts>
    b563:	48 89 df             	mov    %rbx,%rdi
    b566:	48 8d 35 12 3e 00 00 	lea    0x3e12(%rip),%rsi        # f37f <exec_in_fp0+0xd1f>
    b56d:	e8 fe c3 ff ff       	call   7970 <buf_puts>
    b572:	eb ac                	jmp    b520 <fwp_write+0x650>
    b574:	40 84 ed             	test   %bpl,%bpl
    b577:	b8 29 00 00 00       	mov    $0x29,%eax
    b57c:	be 7d 00 00 00       	mov    $0x7d,%esi
    b581:	0f 45 f0             	cmovne %eax,%esi
    b584:	48 89 df             	mov    %rbx,%rdi
    b587:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b58e:	5b                   	pop    %rbx
    b58f:	41 5c                	pop    %r12
    b591:	41 5d                	pop    %r13
    b593:	41 5e                	pop    %r14
    b595:	41 5f                	pop    %r15
    b597:	5d                   	pop    %rbp
    b598:	e9 b3 c3 ff ff       	jmp    7950 <buf_putc>
    b59d:	5b                   	pop    %rbx
    b59e:	41 5c                	pop    %r12
    b5a0:	41 5d                	pop    %r13
    b5a2:	41 5e                	pop    %r14
    b5a4:	41 5f                	pop    %r15
    b5a6:	5d                   	pop    %rbp
    b5a7:	e9 14 06 00 00       	jmp    bbc0 <fwp_escape>
    b5ac:	49 8b 75 08          	mov    0x8(%r13),%rsi
    b5b0:	48 89 f2             	mov    %rsi,%rdx
    b5b3:	48 c1 fa 3f          	sar    $0x3f,%rdx
    b5b7:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    b5bc:	4c 89 f7             	mov    %r14,%rdi
    b5bf:	e8 0c 07 00 00       	call   bcd0 <fwp_fmt_duration>
    b5c4:	e9 58 fe ff ff       	jmp    b421 <fwp_write+0x551>
    b5c9:	48 8d 35 ac 3d 00 00 	lea    0x3dac(%rip),%rsi        # f37c <exec_in_fp0+0xd1c>
    b5d0:	e9 70 fe ff ff       	jmp    b445 <fwp_write+0x575>
    b5d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b5dc:	00 00 00 00 

000000000000b5e0 <fwp_fmt_i128>:
    b5e0:	48 85 d2             	test   %rdx,%rdx
    b5e3:	79 1b                	jns    b600 <fwp_fmt_u128>
    b5e5:	c6 07 2d             	movb   $0x2d,(%rdi)
    b5e8:	48 ff c7             	inc    %rdi
    b5eb:	31 c0                	xor    %eax,%eax
    b5ed:	48 f7 de             	neg    %rsi
    b5f0:	48 19 d0             	sbb    %rdx,%rax
    b5f3:	48 89 c2             	mov    %rax,%rdx
    b5f6:	eb 08                	jmp    b600 <fwp_fmt_u128>
    b5f8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    b5ff:	00 

000000000000b600 <fwp_fmt_u128>:
    b600:	41 56                	push   %r14
    b602:	53                   	push   %rbx
    b603:	48 89 f0             	mov    %rsi,%rax
    b606:	48 09 d0             	or     %rdx,%rax
    b609:	0f 84 9d 00 00 00    	je     b6ac <fwp_fmt_u128+0xac>
    b60f:	48 89 d1             	mov    %rdx,%rcx
    b612:	45 31 d2             	xor    %r10d,%r10d
    b615:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    b61c:	cc cc cc 
    b61f:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
    b626:	cc cc cc 
    b629:	49 89 d6             	mov    %rdx,%r14
    b62c:	0f 1f 40 00          	nopl   0x0(%rax)
    b630:	49 89 c8             	mov    %rcx,%r8
    b633:	49 0f a4 f0 3f       	shld   $0x3f,%rsi,%r8
    b638:	49 d1 ee             	shr    $1,%r14
    b63b:	4d 89 c1             	mov    %r8,%r9
    b63e:	4d 01 f1             	add    %r14,%r9
    b641:	49 83 d1 00          	adc    $0x0,%r9
    b645:	4c 89 c8             	mov    %r9,%rax
    b648:	49 f7 e3             	mul    %r11
    b64b:	48 c1 ea 02          	shr    $0x2,%rdx
    b64f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    b653:	49 29 c1             	sub    %rax,%r9
    b656:	4d 29 c8             	sub    %r9,%r8
    b659:	49 83 de 00          	sbb    $0x0,%r14
    b65d:	4d 89 c1             	mov    %r8,%r9
    b660:	4c 0f af cb          	imul   %rbx,%r9
    b664:	4c 89 c0             	mov    %r8,%rax
    b667:	49 f7 e3             	mul    %r11
    b66a:	4c 01 ca             	add    %r9,%rdx
    b66d:	4d 0f af f3          	imul   %r11,%r14
    b671:	49 01 d6             	add    %rdx,%r14
    b674:	48 89 c2             	mov    %rax,%rdx
    b677:	48 01 c2             	add    %rax,%rdx
    b67a:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
    b67e:	41 89 f0             	mov    %esi,%r8d
    b681:	41 29 d0             	sub    %edx,%r8d
    b684:	41 80 c8 30          	or     $0x30,%r8b
    b688:	46 88 44 14 b8       	mov    %r8b,-0x48(%rsp,%r10,1)
    b68d:	49 ff c2             	inc    %r10
    b690:	48 83 fe 0a          	cmp    $0xa,%rsi
    b694:	48 83 d9 00          	sbb    $0x0,%rcx
    b698:	48 89 c6             	mov    %rax,%rsi
    b69b:	4c 89 f1             	mov    %r14,%rcx
    b69e:	73 90                	jae    b630 <fwp_fmt_u128+0x30>
    b6a0:	45 85 d2             	test   %r10d,%r10d
    b6a3:	7f 12                	jg     b6b7 <fwp_fmt_u128+0xb7>
    b6a5:	31 c0                	xor    %eax,%eax
    b6a7:	e9 56 01 00 00       	jmp    b802 <fwp_fmt_u128+0x202>
    b6ac:	c6 44 24 b8 30       	movb   $0x30,-0x48(%rsp)
    b6b1:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    b6b7:	44 89 d0             	mov    %r10d,%eax
    b6ba:	41 83 fa 08          	cmp    $0x8,%r10d
    b6be:	73 0a                	jae    b6ca <fwp_fmt_u128+0xca>
    b6c0:	31 c9                	xor    %ecx,%ecx
    b6c2:	48 89 c2             	mov    %rax,%rdx
    b6c5:	e9 10 01 00 00       	jmp    b7da <fwp_fmt_u128+0x1da>
    b6ca:	83 f8 20             	cmp    $0x20,%eax
    b6cd:	73 07                	jae    b6d6 <fwp_fmt_u128+0xd6>
    b6cf:	31 c9                	xor    %ecx,%ecx
    b6d1:	e9 a4 00 00 00       	jmp    b77a <fwp_fmt_u128+0x17a>
    b6d6:	89 c1                	mov    %eax,%ecx
    b6d8:	81 e1 e0 ff ff 7f    	and    $0x7fffffe0,%ecx
    b6de:	48 8d 54 24 b8       	lea    -0x48(%rsp),%rdx
    b6e3:	48 01 c2             	add    %rax,%rdx
    b6e6:	48 83 c2 f0          	add    $0xfffffffffffffff0,%rdx
    b6ea:	31 f6                	xor    %esi,%esi
    b6ec:	66 0f ef c0          	pxor   %xmm0,%xmm0
    b6f0:	f3 0f 6f 4a f0       	movdqu -0x10(%rdx),%xmm1
    b6f5:	f3 0f 6f 12          	movdqu (%rdx),%xmm2
    b6f9:	66 0f 6f da          	movdqa %xmm2,%xmm3
    b6fd:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    b701:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    b706:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    b70b:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    b710:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    b714:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    b719:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    b71e:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    b723:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    b727:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    b72b:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    b72f:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    b734:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    b739:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    b73e:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    b742:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    b747:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    b74c:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    b751:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    b755:	f3 0f 7f 14 37       	movdqu %xmm2,(%rdi,%rsi,1)
    b75a:	f3 0f 7f 4c 37 10    	movdqu %xmm1,0x10(%rdi,%rsi,1)
    b760:	48 83 c6 20          	add    $0x20,%rsi
    b764:	48 83 c2 e0          	add    $0xffffffffffffffe0,%rdx
    b768:	48 39 f1             	cmp    %rsi,%rcx
    b76b:	75 83                	jne    b6f0 <fwp_fmt_u128+0xf0>
    b76d:	48 39 c1             	cmp    %rax,%rcx
    b770:	0f 84 8c 00 00 00    	je     b802 <fwp_fmt_u128+0x202>
    b776:	a8 18                	test   $0x18,%al
    b778:	74 5b                	je     b7d5 <fwp_fmt_u128+0x1d5>
    b77a:	48 89 ce             	mov    %rcx,%rsi
    b77d:	89 c1                	mov    %eax,%ecx
    b77f:	81 e1 f8 ff ff 7f    	and    $0x7ffffff8,%ecx
    b785:	89 c2                	mov    %eax,%edx
    b787:	83 e2 07             	and    $0x7,%edx
    b78a:	49 89 c0             	mov    %rax,%r8
    b78d:	49 29 f0             	sub    %rsi,%r8
    b790:	49 01 e0             	add    %rsp,%r8
    b793:	49 83 c0 b0          	add    $0xffffffffffffffb0,%r8
    b797:	66 0f ef c0          	pxor   %xmm0,%xmm0
    b79b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    b7a0:	f3 41 0f 7e 08       	movq   (%r8),%xmm1
    b7a5:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    b7a9:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    b7ae:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    b7b3:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    b7b8:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    b7bc:	66 0f d6 0c 37       	movq   %xmm1,(%rdi,%rsi,1)
    b7c1:	48 83 c6 08          	add    $0x8,%rsi
    b7c5:	49 83 c0 f8          	add    $0xfffffffffffffff8,%r8
    b7c9:	48 39 f1             	cmp    %rsi,%rcx
    b7cc:	75 d2                	jne    b7a0 <fwp_fmt_u128+0x1a0>
    b7ce:	48 39 c1             	cmp    %rax,%rcx
    b7d1:	75 07                	jne    b7da <fwp_fmt_u128+0x1da>
    b7d3:	eb 2d                	jmp    b802 <fwp_fmt_u128+0x202>
    b7d5:	89 c2                	mov    %eax,%edx
    b7d7:	83 e2 1f             	and    $0x1f,%edx
    b7da:	48 8d 74 24 b8       	lea    -0x48(%rsp),%rsi
    b7df:	48 01 f2             	add    %rsi,%rdx
    b7e2:	48 ff ca             	dec    %rdx
    b7e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b7ec:	00 00 00 00 
    b7f0:	0f b6 32             	movzbl (%rdx),%esi
    b7f3:	40 88 34 0f          	mov    %sil,(%rdi,%rcx,1)
    b7f7:	48 ff c1             	inc    %rcx
    b7fa:	48 ff ca             	dec    %rdx
    b7fd:	48 39 c8             	cmp    %rcx,%rax
    b800:	75 ee                	jne    b7f0 <fwp_fmt_u128+0x1f0>
    b802:	c6 04 07 00          	movb   $0x0,(%rdi,%rax,1)
    b806:	5b                   	pop    %rbx
    b807:	41 5e                	pop    %r14
    b809:	c3                   	ret
    b80a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000b810 <fwp_fmt_f32>:
    b810:	53                   	push   %rbx
    b811:	48 83 ec 20          	sub    $0x20,%rsp
    b815:	48 89 fb             	mov    %rdi,%rbx
    b818:	0f 2e c0             	ucomiss %xmm0,%xmm0
    b81b:	0f 8a d8 01 00 00    	jp     b9f9 <fwp_fmt_f32+0x1e9>
    b821:	0f 28 c8             	movaps %xmm0,%xmm1
    b824:	0f 28 05 15 29 00 00 	movaps 0x2915(%rip),%xmm0        # e140 <_IO_stdin_used+0x140>
    b82b:	0f 54 c1             	andps  %xmm1,%xmm0
    b82e:	0f 2e 05 cf 27 00 00 	ucomiss 0x27cf(%rip),%xmm0        # e004 <_IO_stdin_used+0x4>
    b835:	72 25                	jb     b85c <fwp_fmt_f32+0x4c>
    b837:	0f 57 c0             	xorps  %xmm0,%xmm0
    b83a:	0f 2e c8             	ucomiss %xmm0,%xmm1
    b83d:	48 8d 05 7f 3a 00 00 	lea    0x3a7f(%rip),%rax        # f2c3 <exec_in_fp0+0xc63>
    b844:	48 8d 35 77 3a 00 00 	lea    0x3a77(%rip),%rsi        # f2c2 <exec_in_fp0+0xc62>
    b84b:	48 0f 47 f0          	cmova  %rax,%rsi
    b84f:	48 89 df             	mov    %rbx,%rdi
    b852:	48 83 c4 20          	add    $0x20,%rsp
    b856:	5b                   	pop    %rbx
    b857:	e9 54 68 ff ff       	jmp    20b0 <strcpy@plt>
    b85c:	0f 57 c0             	xorps  %xmm0,%xmm0
    b85f:	f3 0f 5a c1          	cvtss2sd %xmm1,%xmm0
    b863:	48 89 df             	mov    %rbx,%rdi
    b866:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    b86c:	be 01 00 00 00       	mov    $0x1,%esi
    b871:	0f 29 4c 24 10       	movaps %xmm1,0x10(%rsp)
    b876:	e8 95 07 00 00       	call   c010 <fwp_format_g>
    b87b:	48 89 df             	mov    %rbx,%rdi
    b87e:	31 f6                	xor    %esi,%esi
    b880:	e8 6b 69 ff ff       	call   21f0 <strtof@plt>
    b885:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b88a:	75 06                	jne    b892 <fwp_fmt_f32+0x82>
    b88c:	0f 8b 5a 01 00 00    	jnp    b9ec <fwp_fmt_f32+0x1dc>
    b892:	48 89 df             	mov    %rbx,%rdi
    b895:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b89b:	be 02 00 00 00       	mov    $0x2,%esi
    b8a0:	e8 6b 07 00 00       	call   c010 <fwp_format_g>
    b8a5:	48 89 df             	mov    %rbx,%rdi
    b8a8:	31 f6                	xor    %esi,%esi
    b8aa:	e8 41 69 ff ff       	call   21f0 <strtof@plt>
    b8af:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b8b4:	75 06                	jne    b8bc <fwp_fmt_f32+0xac>
    b8b6:	0f 8b 30 01 00 00    	jnp    b9ec <fwp_fmt_f32+0x1dc>
    b8bc:	48 89 df             	mov    %rbx,%rdi
    b8bf:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b8c5:	be 03 00 00 00       	mov    $0x3,%esi
    b8ca:	e8 41 07 00 00       	call   c010 <fwp_format_g>
    b8cf:	48 89 df             	mov    %rbx,%rdi
    b8d2:	31 f6                	xor    %esi,%esi
    b8d4:	e8 17 69 ff ff       	call   21f0 <strtof@plt>
    b8d9:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b8de:	75 06                	jne    b8e6 <fwp_fmt_f32+0xd6>
    b8e0:	0f 8b 06 01 00 00    	jnp    b9ec <fwp_fmt_f32+0x1dc>
    b8e6:	48 89 df             	mov    %rbx,%rdi
    b8e9:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b8ef:	be 04 00 00 00       	mov    $0x4,%esi
    b8f4:	e8 17 07 00 00       	call   c010 <fwp_format_g>
    b8f9:	48 89 df             	mov    %rbx,%rdi
    b8fc:	31 f6                	xor    %esi,%esi
    b8fe:	e8 ed 68 ff ff       	call   21f0 <strtof@plt>
    b903:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b908:	75 06                	jne    b910 <fwp_fmt_f32+0x100>
    b90a:	0f 8b dc 00 00 00    	jnp    b9ec <fwp_fmt_f32+0x1dc>
    b910:	48 89 df             	mov    %rbx,%rdi
    b913:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b919:	be 05 00 00 00       	mov    $0x5,%esi
    b91e:	e8 ed 06 00 00       	call   c010 <fwp_format_g>
    b923:	48 89 df             	mov    %rbx,%rdi
    b926:	31 f6                	xor    %esi,%esi
    b928:	e8 c3 68 ff ff       	call   21f0 <strtof@plt>
    b92d:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b932:	75 06                	jne    b93a <fwp_fmt_f32+0x12a>
    b934:	0f 8b b2 00 00 00    	jnp    b9ec <fwp_fmt_f32+0x1dc>
    b93a:	48 89 df             	mov    %rbx,%rdi
    b93d:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b943:	be 06 00 00 00       	mov    $0x6,%esi
    b948:	e8 c3 06 00 00       	call   c010 <fwp_format_g>
    b94d:	48 89 df             	mov    %rbx,%rdi
    b950:	31 f6                	xor    %esi,%esi
    b952:	e8 99 68 ff ff       	call   21f0 <strtof@plt>
    b957:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b95c:	75 06                	jne    b964 <fwp_fmt_f32+0x154>
    b95e:	0f 8b 88 00 00 00    	jnp    b9ec <fwp_fmt_f32+0x1dc>
    b964:	48 89 df             	mov    %rbx,%rdi
    b967:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b96d:	be 07 00 00 00       	mov    $0x7,%esi
    b972:	e8 99 06 00 00       	call   c010 <fwp_format_g>
    b977:	48 89 df             	mov    %rbx,%rdi
    b97a:	31 f6                	xor    %esi,%esi
    b97c:	e8 6f 68 ff ff       	call   21f0 <strtof@plt>
    b981:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b986:	75 02                	jne    b98a <fwp_fmt_f32+0x17a>
    b988:	7b 62                	jnp    b9ec <fwp_fmt_f32+0x1dc>
    b98a:	48 89 df             	mov    %rbx,%rdi
    b98d:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b993:	be 08 00 00 00       	mov    $0x8,%esi
    b998:	e8 73 06 00 00       	call   c010 <fwp_format_g>
    b99d:	48 89 df             	mov    %rbx,%rdi
    b9a0:	31 f6                	xor    %esi,%esi
    b9a2:	e8 49 68 ff ff       	call   21f0 <strtof@plt>
    b9a7:	0f 28 4c 24 10       	movaps 0x10(%rsp),%xmm1
    b9ac:	0f 2e c1             	ucomiss %xmm1,%xmm0
    b9af:	75 02                	jne    b9b3 <fwp_fmt_f32+0x1a3>
    b9b1:	7b 39                	jnp    b9ec <fwp_fmt_f32+0x1dc>
    b9b3:	48 89 df             	mov    %rbx,%rdi
    b9b6:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b9bc:	be 09 00 00 00       	mov    $0x9,%esi
    b9c1:	e8 4a 06 00 00       	call   c010 <fwp_format_g>
    b9c6:	48 89 df             	mov    %rbx,%rdi
    b9c9:	31 f6                	xor    %esi,%esi
    b9cb:	e8 20 68 ff ff       	call   21f0 <strtof@plt>
    b9d0:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b9d5:	75 02                	jne    b9d9 <fwp_fmt_f32+0x1c9>
    b9d7:	7b 13                	jnp    b9ec <fwp_fmt_f32+0x1dc>
    b9d9:	48 89 df             	mov    %rbx,%rdi
    b9dc:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b9e2:	be 09 00 00 00       	mov    $0x9,%esi
    b9e7:	e8 24 06 00 00       	call   c010 <fwp_format_g>
    b9ec:	48 89 df             	mov    %rbx,%rdi
    b9ef:	48 83 c4 20          	add    $0x20,%rsp
    b9f3:	5b                   	pop    %rbx
    b9f4:	e9 97 07 00 00       	jmp    c190 <fwp_finish_float>
    b9f9:	c7 03 4e 61 4e 00    	movl   $0x4e614e,(%rbx)
    b9ff:	48 83 c4 20          	add    $0x20,%rsp
    ba03:	5b                   	pop    %rbx
    ba04:	c3                   	ret
    ba05:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    ba0c:	00 00 00 00 

000000000000ba10 <fwp_fmt_f64>:
    ba10:	55                   	push   %rbp
    ba11:	53                   	push   %rbx
    ba12:	48 83 ec 18          	sub    $0x18,%rsp
    ba16:	48 89 fb             	mov    %rdi,%rbx
    ba19:	66 0f 2e c0          	ucomisd %xmm0,%xmm0
    ba1d:	0f 8a 98 00 00 00    	jp     babb <fwp_fmt_f64+0xab>
    ba23:	66 0f 28 c8          	movapd %xmm0,%xmm1
    ba27:	66 0f 28 05 21 27 00 	movapd 0x2721(%rip),%xmm0        # e150 <_IO_stdin_used+0x150>
    ba2e:	00 
    ba2f:	66 0f 54 c1          	andpd  %xmm1,%xmm0
    ba33:	66 0f 2e 05 f5 25 00 	ucomisd 0x25f5(%rip),%xmm0        # e030 <_IO_stdin_used+0x30>
    ba3a:	00 
    ba3b:	72 28                	jb     ba65 <fwp_fmt_f64+0x55>
    ba3d:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    ba41:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
    ba45:	48 8d 05 77 38 00 00 	lea    0x3877(%rip),%rax        # f2c3 <exec_in_fp0+0xc63>
    ba4c:	48 8d 35 6f 38 00 00 	lea    0x386f(%rip),%rsi        # f2c2 <exec_in_fp0+0xc62>
    ba53:	48 0f 47 f0          	cmova  %rax,%rsi
    ba57:	48 89 df             	mov    %rbx,%rdi
    ba5a:	48 83 c4 18          	add    $0x18,%rsp
    ba5e:	5b                   	pop    %rbx
    ba5f:	5d                   	pop    %rbp
    ba60:	e9 4b 66 ff ff       	jmp    20b0 <strcpy@plt>
    ba65:	bd 01 00 00 00       	mov    $0x1,%ebp
    ba6a:	66 0f 29 0c 24       	movapd %xmm1,(%rsp)
    ba6f:	90                   	nop
    ba70:	48 89 df             	mov    %rbx,%rdi
    ba73:	66 0f 28 c1          	movapd %xmm1,%xmm0
    ba77:	89 ee                	mov    %ebp,%esi
    ba79:	e8 92 05 00 00       	call   c010 <fwp_format_g>
    ba7e:	48 89 df             	mov    %rbx,%rdi
    ba81:	31 f6                	xor    %esi,%esi
    ba83:	e8 68 66 ff ff       	call   20f0 <strtod@plt>
    ba88:	66 0f 28 0c 24       	movapd (%rsp),%xmm1
    ba8d:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
    ba91:	75 02                	jne    ba95 <fwp_fmt_f64+0x85>
    ba93:	7b 18                	jnp    baad <fwp_fmt_f64+0x9d>
    ba95:	ff c5                	inc    %ebp
    ba97:	83 fd 12             	cmp    $0x12,%ebp
    ba9a:	75 d4                	jne    ba70 <fwp_fmt_f64+0x60>
    ba9c:	48 89 df             	mov    %rbx,%rdi
    ba9f:	66 0f 28 c1          	movapd %xmm1,%xmm0
    baa3:	be 11 00 00 00       	mov    $0x11,%esi
    baa8:	e8 63 05 00 00       	call   c010 <fwp_format_g>
    baad:	48 89 df             	mov    %rbx,%rdi
    bab0:	48 83 c4 18          	add    $0x18,%rsp
    bab4:	5b                   	pop    %rbx
    bab5:	5d                   	pop    %rbp
    bab6:	e9 d5 06 00 00       	jmp    c190 <fwp_finish_float>
    babb:	c7 03 4e 61 4e 00    	movl   $0x4e614e,(%rbx)
    bac1:	48 83 c4 18          	add    $0x18,%rsp
    bac5:	5b                   	pop    %rbx
    bac6:	5d                   	pop    %rbp
    bac7:	c3                   	ret
    bac8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    bacf:	00 

000000000000bad0 <fwp_trits>:
    bad0:	55                   	push   %rbp
    bad1:	41 57                	push   %r15
    bad3:	41 56                	push   %r14
    bad5:	53                   	push   %rbx
    bad6:	50                   	push   %rax
    bad7:	89 d5                	mov    %edx,%ebp
    bad9:	49 89 f6             	mov    %rsi,%r14
    badc:	48 89 fb             	mov    %rdi,%rbx
    badf:	4c 63 fa             	movslq %edx,%r15
    bae2:	49 8d 7f 03          	lea    0x3(%r15),%rdi
    bae6:	e8 65 ac ff ff       	call   6750 <fwp_alloc_leaf>
    baeb:	48 89 c6             	mov    %rax,%rsi
    baee:	66 c7 00 30 74       	movw   $0x7430,(%rax)
    baf3:	45 85 ff             	test   %r15d,%r15d
    baf6:	0f 8e 9f 00 00 00    	jle    bb9b <fwp_trits+0xcb>
    bafc:	89 e9                	mov    %ebp,%ecx
    bafe:	48 8d 3c 31          	lea    (%rcx,%rsi,1),%rdi
    bb02:	48 ff c7             	inc    %rdi
    bb05:	48 f7 d9             	neg    %rcx
    bb08:	45 31 c0             	xor    %r8d,%r8d
    bb0b:	49 b9 56 55 55 55 55 	movabs $0x5555555555555556,%r9
    bb12:	55 55 55 
    bb15:	eb 35                	jmp    bb4c <fwp_trits+0x7c>
    bb17:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    bb1e:	00 00 
    bb20:	41 b3 30             	mov    $0x30,%r11b
    bb23:	46 88 1c 07          	mov    %r11b,(%rdi,%r8,1)
    bb27:	48 85 d2             	test   %rdx,%rdx
    bb2a:	0f 95 c2             	setne  %dl
    bb2d:	4d 85 f6             	test   %r14,%r14
    bb30:	41 0f 98 c3          	sets   %r11b
    bb34:	41 20 d3             	and    %dl,%r11b
    bb37:	41 0f b6 d3          	movzbl %r11b,%edx
    bb3b:	48 29 d0             	sub    %rdx,%rax
    bb3e:	4c 01 d0             	add    %r10,%rax
    bb41:	49 ff c8             	dec    %r8
    bb44:	49 89 c6             	mov    %rax,%r14
    bb47:	4c 39 c1             	cmp    %r8,%rcx
    bb4a:	74 4f                	je     bb9b <fwp_trits+0xcb>
    bb4c:	4c 89 f0             	mov    %r14,%rax
    bb4f:	49 f7 e9             	imul   %r9
    bb52:	48 89 d0             	mov    %rdx,%rax
    bb55:	48 c1 e8 3f          	shr    $0x3f,%rax
    bb59:	48 01 d0             	add    %rdx,%rax
    bb5c:	4c 8d 14 40          	lea    (%rax,%rax,2),%r10
    bb60:	4c 89 f2             	mov    %r14,%rdx
    bb63:	4c 29 d2             	sub    %r10,%rdx
    bb66:	49 f7 da             	neg    %r10
    bb69:	4d 01 f2             	add    %r14,%r10
    bb6c:	49 83 c2 03          	add    $0x3,%r10
    bb70:	48 83 fa fd          	cmp    $0xfffffffffffffffd,%rdx
    bb74:	4c 0f 42 d2          	cmovb  %rdx,%r10
    bb78:	4d 85 d2             	test   %r10,%r10
    bb7b:	74 a3                	je     bb20 <fwp_trits+0x50>
    bb7d:	49 83 fa 01          	cmp    $0x1,%r10
    bb81:	75 0d                	jne    bb90 <fwp_trits+0xc0>
    bb83:	41 b3 2b             	mov    $0x2b,%r11b
    bb86:	45 31 d2             	xor    %r10d,%r10d
    bb89:	eb 98                	jmp    bb23 <fwp_trits+0x53>
    bb8b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    bb90:	41 b3 2d             	mov    $0x2d,%r11b
    bb93:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    bb99:	eb 88                	jmp    bb23 <fwp_trits+0x53>
    bb9b:	42 c6 44 3e 02 00    	movb   $0x0,0x2(%rsi,%r15,1)
    bba1:	48 89 df             	mov    %rbx,%rdi
    bba4:	48 83 c4 08          	add    $0x8,%rsp
    bba8:	5b                   	pop    %rbx
    bba9:	41 5e                	pop    %r14
    bbab:	41 5f                	pop    %r15
    bbad:	5d                   	pop    %rbp
    bbae:	e9 bd bd ff ff       	jmp    7970 <buf_puts>
    bbb3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    bbba:	84 00 00 00 00 00 

000000000000bbc0 <fwp_escape>:
    bbc0:	55                   	push   %rbp
    bbc1:	41 57                	push   %r15
    bbc3:	41 56                	push   %r14
    bbc5:	41 55                	push   %r13
    bbc7:	41 54                	push   %r12
    bbc9:	53                   	push   %rbx
    bbca:	48 83 ec 18          	sub    $0x18,%rsp
    bbce:	48 89 d3             	mov    %rdx,%rbx
    bbd1:	49 89 f7             	mov    %rsi,%r15
    bbd4:	49 89 fe             	mov    %rdi,%r14
    bbd7:	be 22 00 00 00       	mov    $0x22,%esi
    bbdc:	e8 6f bd ff ff       	call   7950 <buf_putc>
    bbe1:	48 85 db             	test   %rbx,%rbx
    bbe4:	0f 84 c7 00 00 00    	je     bcb1 <fwp_escape+0xf1>
    bbea:	48 89 e5             	mov    %rsp,%rbp
    bbed:	4c 8d 2d c8 27 00 00 	lea    0x27c8(%rip),%r13        # e3bc <_IO_stdin_used+0x3bc>
    bbf4:	45 31 e4             	xor    %r12d,%r12d
    bbf7:	eb 28                	jmp    bc21 <fwp_escape+0x61>
    bbf9:	4c 89 f7             	mov    %r14,%rdi
    bbfc:	48 8d 35 a3 37 00 00 	lea    0x37a3(%rip),%rsi        # f3a6 <exec_in_fp0+0xd46>
    bc03:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    bc0a:	84 00 00 00 00 00 
    bc10:	e8 5b bd ff ff       	call   7970 <buf_puts>
    bc15:	49 ff c4             	inc    %r12
    bc18:	4c 39 e3             	cmp    %r12,%rbx
    bc1b:	0f 84 90 00 00 00    	je     bcb1 <fwp_escape+0xf1>
    bc21:	43 0f b6 0c 27       	movzbl (%r15,%r12,1),%ecx
    bc26:	8d 41 f7             	lea    -0x9(%rcx),%eax
    bc29:	83 f8 19             	cmp    $0x19,%eax
    bc2c:	77 22                	ja     bc50 <fwp_escape+0x90>
    bc2e:	49 63 44 85 00       	movslq 0x0(%r13,%rax,4),%rax
    bc33:	4c 01 e8             	add    %r13,%rax
    bc36:	ff e0                	jmp    *%rax
    bc38:	4c 89 f7             	mov    %r14,%rdi
    bc3b:	48 8d 35 61 37 00 00 	lea    0x3761(%rip),%rsi        # f3a3 <exec_in_fp0+0xd43>
    bc42:	eb cc                	jmp    bc10 <fwp_escape+0x50>
    bc44:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    bc4b:	00 00 00 00 00 
    bc50:	83 f9 5c             	cmp    $0x5c,%ecx
    bc53:	75 0c                	jne    bc61 <fwp_escape+0xa1>
    bc55:	4c 89 f7             	mov    %r14,%rdi
    bc58:	48 8d 35 3e 37 00 00 	lea    0x373e(%rip),%rsi        # f39d <exec_in_fp0+0xd3d>
    bc5f:	eb af                	jmp    bc10 <fwp_escape+0x50>
    bc61:	80 f9 20             	cmp    $0x20,%cl
    bc64:	72 2a                	jb     bc90 <fwp_escape+0xd0>
    bc66:	80 f9 7f             	cmp    $0x7f,%cl
    bc69:	74 25                	je     bc90 <fwp_escape+0xd0>
    bc6b:	0f be f1             	movsbl %cl,%esi
    bc6e:	4c 89 f7             	mov    %r14,%rdi
    bc71:	e8 da bc ff ff       	call   7950 <buf_putc>
    bc76:	eb 9d                	jmp    bc15 <fwp_escape+0x55>
    bc78:	4c 89 f7             	mov    %r14,%rdi
    bc7b:	48 8d 35 18 37 00 00 	lea    0x3718(%rip),%rsi        # f39a <exec_in_fp0+0xd3a>
    bc82:	eb 8c                	jmp    bc10 <fwp_escape+0x50>
    bc84:	4c 89 f7             	mov    %r14,%rdi
    bc87:	48 8d 35 12 37 00 00 	lea    0x3712(%rip),%rsi        # f3a0 <exec_in_fp0+0xd40>
    bc8e:	eb 80                	jmp    bc10 <fwp_escape+0x50>
    bc90:	be 10 00 00 00       	mov    $0x10,%esi
    bc95:	48 89 ef             	mov    %rbp,%rdi
    bc98:	48 8d 15 0a 37 00 00 	lea    0x370a(%rip),%rdx        # f3a9 <exec_in_fp0+0xd49>
    bc9f:	31 c0                	xor    %eax,%eax
    bca1:	e8 1a 65 ff ff       	call   21c0 <snprintf@plt>
    bca6:	4c 89 f7             	mov    %r14,%rdi
    bca9:	48 89 ee             	mov    %rbp,%rsi
    bcac:	e9 5f ff ff ff       	jmp    bc10 <fwp_escape+0x50>
    bcb1:	4c 89 f7             	mov    %r14,%rdi
    bcb4:	be 22 00 00 00       	mov    $0x22,%esi
    bcb9:	48 83 c4 18          	add    $0x18,%rsp
    bcbd:	5b                   	pop    %rbx
    bcbe:	41 5c                	pop    %r12
    bcc0:	41 5d                	pop    %r13
    bcc2:	41 5e                	pop    %r14
    bcc4:	41 5f                	pop    %r15
    bcc6:	5d                   	pop    %rbp
    bcc7:	e9 84 bc ff ff       	jmp    7950 <buf_putc>
    bccc:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000bcd0 <fwp_fmt_duration>:
    bcd0:	41 57                	push   %r15
    bcd2:	41 56                	push   %r14
    bcd4:	41 54                	push   %r12
    bcd6:	53                   	push   %rbx
    bcd7:	48 83 ec 48          	sub    $0x48,%rsp
    bcdb:	49 89 d0             	mov    %rdx,%r8
    bcde:	48 89 fb             	mov    %rdi,%rbx
    bce1:	48 89 f0             	mov    %rsi,%rax
    bce4:	48 09 d0             	or     %rdx,%rax
    bce7:	0f 84 1b 02 00 00    	je     bf08 <fwp_fmt_duration+0x238>
    bced:	48 b9 1d 3f c2 25 d6 	movabs $0xd2fe1d625c23f1d,%rcx
    bcf4:	e1 2f 0d 
    bcf7:	48 bf 0d b1 f3 e4 99 	movabs $0x1c52799e4f3b10d,%rdi
    bcfe:	27 c5 01 
    bd01:	48 89 f0             	mov    %rsi,%rax
    bd04:	48 f7 e7             	mul    %rdi
    bd07:	48 0f af ce          	imul   %rsi,%rcx
    bd0b:	48 01 ca             	add    %rcx,%rdx
    bd0e:	49 0f af f8          	imul   %r8,%rdi
    bd12:	48 01 d7             	add    %rdx,%rdi
    bd15:	48 b9 00 a0 34 52 a3 	movabs $0x6baf6aa35234a000,%rcx
    bd1c:	6a af 6b 
    bd1f:	48 01 c1             	add    %rax,%rcx
    bd22:	48 b8 37 f9 ff e2 04 	movabs $0x4e2fff937,%rax
    bd29:	00 00 00 
    bd2c:	48 11 f8             	adc    %rdi,%rax
    bd2f:	48 89 c2             	mov    %rax,%rdx
    bd32:	48 0f ac ca 0d       	shrd   $0xd,%rcx,%rdx
    bd37:	48 0f a4 c8 33       	shld   $0x33,%rcx,%rax
    bd3c:	48 b9 4b 23 35 aa f6 	movabs $0x9376baf6aa35234b,%rcx
    bd43:	ba 76 93 
    bd46:	48 39 c8             	cmp    %rcx,%rax
    bd49:	48 81 da ff 2f 4e 00 	sbb    $0x4e2fff,%rdx
    bd50:	0f 82 d9 01 00 00    	jb     bf2f <fwp_fmt_duration+0x25f>
    bd56:	48 b9 b3 b2 61 36 8c 	movabs $0xc5ce3b8c3661b2b3,%rcx
    bd5d:	3b ce c5 
    bd60:	48 bf c3 5f 47 6a 04 	movabs $0x1a8d52046a475fc3,%rdi
    bd67:	52 8d 1a 
    bd6a:	48 89 f0             	mov    %rsi,%rax
    bd6d:	48 f7 e7             	mul    %rdi
    bd70:	48 0f af ce          	imul   %rsi,%rcx
    bd74:	48 01 ca             	add    %rcx,%rdx
    bd77:	49 0f af f8          	imul   %r8,%rdi
    bd7b:	48 01 d7             	add    %rdx,%rdi
    bd7e:	48 b9 00 a8 16 d1 91 	movabs $0x4f473f91d116a800,%rcx
    bd85:	3f 47 4f 
    bd88:	48 01 c1             	add    %rax,%rcx
    bd8b:	48 b8 3f 9a ff 4c 49 	movabs $0x494cff9a3f,%rax
    bd92:	00 00 00 
    bd95:	48 11 f8             	adc    %rdi,%rax
    bd98:	48 89 c2             	mov    %rax,%rdx
    bd9b:	48 0f ac ca 0b       	shrd   $0xb,%rcx,%rdx
    bda0:	48 0f a4 c8 35       	shld   $0x35,%rcx,%rax
    bda5:	48 b9 ab 45 74 e4 cf 	movabs $0x8fd3d1cfe47445ab,%rcx
    bdac:	d1 d3 8f 
    bdaf:	48 39 c8             	cmp    %rcx,%rax
    bdb2:	48 81 da e6 3f 53 12 	sbb    $0x12533fe6,%rdx
    bdb9:	0f 82 7f 01 00 00    	jb     bf3e <fwp_fmt_duration+0x26e>
    bdbf:	48 b9 7e 78 b9 2f 37 	movabs $0x97157d372fb9787e,%rcx
    bdc6:	7d 15 97 
    bdc9:	48 0f af ce          	imul   %rsi,%rcx
    bdcd:	48 bf 6d 9c 2e 3a 42 	movabs $0x8e47ce423a2e9c6d,%rdi
    bdd4:	ce 47 8e 
    bdd7:	48 89 f0             	mov    %rsi,%rax
    bdda:	48 f7 e7             	mul    %rdi
    bddd:	48 01 ca             	add    %rcx,%rdx
    bde0:	49 0f af f8          	imul   %r8,%rdi
    bde4:	48 01 d7             	add    %rdx,%rdi
    bde7:	48 b9 00 46 54 40 8b 	movabs $0xa52cb98b40544600,%rcx
    bdee:	b9 2c a5 
    bdf1:	48 01 c1             	add    %rax,%rcx
    bdf4:	48 b8 b5 09 fa 82 4b 	movabs $0x44b82fa09b5,%rax
    bdfb:	04 00 00 
    bdfe:	48 11 f8             	adc    %rdi,%rax
    be01:	48 89 c2             	mov    %rax,%rdx
    be04:	48 0f ac ca 09       	shrd   $0x9,%rcx,%rdx
    be09:	48 0f a4 c8 37       	shld   $0x37,%rcx,%rax
    be0e:	48 b9 47 54 40 8b b9 	movabs $0xb5a52cb98b405447,%rcx
    be15:	2c a5 b5 
    be18:	48 39 c8             	cmp    %rcx,%rax
    be1b:	48 b8 09 fa 82 4b 04 	movabs $0x44b82fa09,%rax
    be22:	00 00 00 
    be25:	48 19 c2             	sbb    %rax,%rdx
    be28:	0f 82 22 01 00 00    	jb     bf50 <fwp_fmt_duration+0x280>
    be2e:	48 b9 cb d5 8f 4d f2 	movabs $0xc57e23f24d8fd5cb,%rcx
    be35:	23 7e c5 
    be38:	48 0f af ce          	imul   %rsi,%rcx
    be3c:	48 bf 39 61 c2 68 56 	movabs $0x790fb65668c26139,%rdi
    be43:	b6 0f 79 
    be46:	48 89 f0             	mov    %rsi,%rax
    be49:	48 f7 e7             	mul    %rdi
    be4c:	48 01 ca             	add    %rcx,%rdx
    be4f:	49 0f af f8          	imul   %r8,%rdi
    be53:	48 01 d7             	add    %rdx,%rdi
    be56:	48 b9 00 0b 27 69 fe 	movabs $0xa6d698fe69270b00,%rcx
    be5d:	98 d6 a6 
    be60:	48 01 c1             	add    %rax,%rcx
    be63:	48 b8 b1 bd 16 f4 de 	movabs $0x218def416bdb1,%rax
    be6a:	18 02 00 
    be6d:	48 11 f8             	adc    %rdi,%rax
    be70:	48 89 c2             	mov    %rax,%rdx
    be73:	48 0f ac ca 06       	shrd   $0x6,%rcx,%rdx
    be78:	48 0f a4 c8 3a       	shld   $0x3a,%rcx,%rax
    be7d:	48 b9 59 38 49 f3 c7 	movabs $0x8d36b4c7f3493859,%rcx
    be84:	b4 36 8d 
    be87:	48 39 c8             	cmp    %rcx,%rax
    be8a:	48 b8 ed b5 a0 f7 c6 	movabs $0x10c6f7a0b5ed,%rax
    be91:	10 00 00 
    be94:	48 19 c2             	sbb    %rax,%rdx
    be97:	0f 82 c0 00 00 00    	jb     bf5d <fwp_fmt_duration+0x28d>
    be9d:	48 b9 5a 64 3b df 4f 	movabs $0x6e978d4fdf3b645a,%rcx
    bea4:	8d 97 6e 
    bea7:	48 0f af ce          	imul   %rsi,%rcx
    beab:	48 bf d5 78 e9 26 31 	movabs $0x1cac083126e978d5,%rdi
    beb2:	08 ac 1c 
    beb5:	48 89 f0             	mov    %rsi,%rax
    beb8:	48 f7 e7             	mul    %rdi
    bebb:	48 01 ca             	add    %rcx,%rdx
    bebe:	49 0f af f8          	imul   %r8,%rdi
    bec2:	48 01 d7             	add    %rdx,%rdi
    bec5:	48 b9 48 62 10 58 39 	movabs $0x76c8b43958106248,%rcx
    becc:	b4 c8 76 
    becf:	48 01 c1             	add    %rax,%rcx
    bed2:	48 b8 be 9f 1a 2f dd 	movabs $0x10624dd2f1a9fbe,%rax
    bed9:	24 06 01 
    bedc:	48 11 f8             	adc    %rdi,%rax
    bedf:	48 89 c2             	mov    %rax,%rdx
    bee2:	48 0f ac ca 03       	shrd   $0x3,%rcx,%rdx
    bee7:	48 0f a4 c8 3d       	shld   $0x3d,%rcx,%rax
    beec:	48 b9 93 18 04 56 0e 	movabs $0x9db22d0e56041893,%rcx
    bef3:	2d b2 9d 
    bef6:	48 39 c8             	cmp    %rcx,%rax
    bef9:	48 b8 ef a7 c6 4b 37 	movabs $0x4189374bc6a7ef,%rax
    bf00:	89 41 00 
    bf03:	48 19 c2             	sbb    %rax,%rdx
    bf06:	72 62                	jb     bf6a <fwp_fmt_duration+0x29a>
    bf08:	49 89 e6             	mov    %rsp,%r14
    bf0b:	4c 89 f7             	mov    %r14,%rdi
    bf0e:	4c 89 c2             	mov    %r8,%rdx
    bf11:	e8 ca f6 ff ff       	call   b5e0 <fwp_fmt_i128>
    bf16:	48 8d 35 98 34 00 00 	lea    0x3498(%rip),%rsi        # f3b5 <exec_in_fp0+0xd55>
    bf1d:	48 89 df             	mov    %rbx,%rdi
    bf20:	4c 89 f2             	mov    %r14,%rdx
    bf23:	31 c0                	xor    %eax,%eax
    bf25:	e8 36 65 ff ff       	call   2460 <sprintf@plt>
    bf2a:	e9 84 00 00 00       	jmp    bfb3 <fwp_fmt_duration+0x2e3>
    bf2f:	48 ba 00 a0 b8 30 46 	movabs $0x34630b8a000,%rdx
    bf36:	03 00 00 
    bf39:	45 31 ff             	xor    %r15d,%r15d
    bf3c:	eb 37                	jmp    bf75 <fwp_fmt_duration+0x2a5>
    bf3e:	48 ba 00 58 47 f8 0d 	movabs $0xdf8475800,%rdx
    bf45:	00 00 00 
    bf48:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    bf4e:	eb 25                	jmp    bf75 <fwp_fmt_duration+0x2a5>
    bf50:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
    bf55:	41 bf 02 00 00 00    	mov    $0x2,%r15d
    bf5b:	eb 18                	jmp    bf75 <fwp_fmt_duration+0x2a5>
    bf5d:	ba 40 42 0f 00       	mov    $0xf4240,%edx
    bf62:	41 bf 03 00 00 00    	mov    $0x3,%r15d
    bf68:	eb 0b                	jmp    bf75 <fwp_fmt_duration+0x2a5>
    bf6a:	ba e8 03 00 00       	mov    $0x3e8,%edx
    bf6f:	41 bf 04 00 00 00    	mov    $0x4,%r15d
    bf75:	31 c9                	xor    %ecx,%ecx
    bf77:	41 c1 e7 04          	shl    $0x4,%r15d
    bf7b:	4c 8d 25 ae 7d 00 00 	lea    0x7dae(%rip),%r12        # 13d30 <fwp_fmt_duration.units>
    bf82:	48 89 f7             	mov    %rsi,%rdi
    bf85:	4c 89 c6             	mov    %r8,%rsi
    bf88:	e8 63 0f 00 00       	call   cef0 <__divti3>
    bf8d:	49 89 e6             	mov    %rsp,%r14
    bf90:	4c 89 f7             	mov    %r14,%rdi
    bf93:	48 89 c6             	mov    %rax,%rsi
    bf96:	e8 45 f6 ff ff       	call   b5e0 <fwp_fmt_i128>
    bf9b:	4b 8b 0c 27          	mov    (%r15,%r12,1),%rcx
    bf9f:	48 8d 35 0a 34 00 00 	lea    0x340a(%rip),%rsi        # f3b0 <exec_in_fp0+0xd50>
    bfa6:	48 89 df             	mov    %rbx,%rdi
    bfa9:	4c 89 f2             	mov    %r14,%rdx
    bfac:	31 c0                	xor    %eax,%eax
    bfae:	e8 ad 64 ff ff       	call   2460 <sprintf@plt>
    bfb3:	48 83 c4 48          	add    $0x48,%rsp
    bfb7:	5b                   	pop    %rbx
    bfb8:	41 5c                	pop    %r12
    bfba:	41 5e                	pop    %r14
    bfbc:	41 5f                	pop    %r15
    bfbe:	c3                   	ret
    bfbf:	90                   	nop

000000000000bfc0 <fwp_needs_parens>:
    bfc0:	8b 06                	mov    (%rsi),%eax
    bfc2:	83 f8 10             	cmp    $0x10,%eax
    bfc5:	74 16                	je     bfdd <fwp_needs_parens+0x1d>
    bfc7:	83 f8 0e             	cmp    $0xe,%eax
    bfca:	0f 85 30 02 00 00    	jne    c200 <fwp_is_negative>
    bfd0:	31 c0                	xor    %eax,%eax
    bfd2:	48 81 ff 00 10 00 00 	cmp    $0x1000,%rdi
    bfd9:	0f 93 c0             	setae  %al
    bfdc:	c3                   	ret
    bfdd:	48 8b 46 08          	mov    0x8(%rsi),%rax
    bfe1:	48 85 c0             	test   %rax,%rax
    bfe4:	0f 84 16 02 00 00    	je     c200 <fwp_is_negative>
    bfea:	50                   	push   %rax
    bfeb:	48 8d 35 b6 32 00 00 	lea    0x32b6(%rip),%rsi        # f2a8 <exec_in_fp0+0xc48>
    bff2:	48 89 c7             	mov    %rax,%rdi
    bff5:	e8 c6 62 ff ff       	call   22c0 <strcmp@plt>
    bffa:	89 c1                	mov    %eax,%ecx
    bffc:	31 c0                	xor    %eax,%eax
    bffe:	85 c9                	test   %ecx,%ecx
    c000:	0f 95 c0             	setne  %al
    c003:	48 83 c4 08          	add    $0x8,%rsp
    c007:	c3                   	ret
    c008:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c00f:	00 

000000000000c010 <fwp_format_g>:
    c010:	55                   	push   %rbp
    c011:	41 57                	push   %r15
    c013:	41 56                	push   %r14
    c015:	41 55                	push   %r13
    c017:	41 54                	push   %r12
    c019:	53                   	push   %rbx
    c01a:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    c021:	89 f5                	mov    %esi,%ebp
    c023:	48 89 fb             	mov    %rdi,%rbx
    c026:	ff cd                	dec    %ebp
    c028:	48 8d 15 54 33 00 00 	lea    0x3354(%rip),%rdx        # f383 <exec_in_fp0+0xd23>
    c02f:	4c 8d 64 24 50       	lea    0x50(%rsp),%r12
    c034:	be 40 00 00 00       	mov    $0x40,%esi
    c039:	4c 89 e7             	mov    %r12,%rdi
    c03c:	89 e9                	mov    %ebp,%ecx
    c03e:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    c044:	b0 01                	mov    $0x1,%al
    c046:	e8 75 61 ff ff       	call   21c0 <snprintf@plt>
    c04b:	4c 89 e7             	mov    %r12,%rdi
    c04e:	be 65 00 00 00       	mov    $0x65,%esi
    c053:	e8 48 61 ff ff       	call   21a0 <strchr@plt>
    c058:	49 89 c7             	mov    %rax,%r15
    c05b:	48 8d 78 01          	lea    0x1(%rax),%rdi
    c05f:	e8 ec 63 ff ff       	call   2450 <atoi@plt>
    c064:	41 89 c6             	mov    %eax,%r14d
    c067:	41 8d 46 ef          	lea    -0x11(%r14),%eax
    c06b:	83 f8 e9             	cmp    $0xffffffe9,%eax
    c06e:	77 58                	ja     c0c8 <fwp_format_g+0xb8>
    c070:	4d 29 e7             	sub    %r12,%r15
    c073:	4c 8d 6c 24 10       	lea    0x10(%rsp),%r13
    c078:	4c 89 ef             	mov    %r13,%rdi
    c07b:	4c 89 e6             	mov    %r12,%rsi
    c07e:	4c 89 fa             	mov    %r15,%rdx
    c081:	e8 9a 62 ff ff       	call   2320 <memcpy@plt>
    c086:	42 c6 44 3c 10 00    	movb   $0x0,0x10(%rsp,%r15,1)
    c08c:	4c 89 ef             	mov    %r13,%rdi
    c08f:	be 2e 00 00 00       	mov    $0x2e,%esi
    c094:	e8 07 61 ff ff       	call   21a0 <strchr@plt>
    c099:	48 85 c0             	test   %rax,%rax
    c09c:	0f 84 91 00 00 00    	je     c133 <fwp_format_g+0x123>
    c0a2:	4d 85 ff             	test   %r15,%r15
    c0a5:	0f 84 88 00 00 00    	je     c133 <fwp_format_g+0x123>
    c0ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    c0b0:	42 0f b6 44 3c 0f    	movzbl 0xf(%rsp,%r15,1),%eax
    c0b6:	83 f8 30             	cmp    $0x30,%eax
    c0b9:	75 6d                	jne    c128 <fwp_format_g+0x118>
    c0bb:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    c0c1:	49 ff cf             	dec    %r15
    c0c4:	75 ea                	jne    c0b0 <fwp_format_g+0xa0>
    c0c6:	eb 6b                	jmp    c133 <fwp_format_g+0x123>
    c0c8:	44 29 f5             	sub    %r14d,%ebp
    c0cb:	31 c9                	xor    %ecx,%ecx
    c0cd:	85 ed                	test   %ebp,%ebp
    c0cf:	0f 4f cd             	cmovg  %ebp,%ecx
    c0d2:	48 8d 15 b9 32 00 00 	lea    0x32b9(%rip),%rdx        # f392 <exec_in_fp0+0xd32>
    c0d9:	be 90 01 00 00       	mov    $0x190,%esi
    c0de:	48 89 df             	mov    %rbx,%rdi
    c0e1:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    c0e7:	b0 01                	mov    $0x1,%al
    c0e9:	e8 d2 60 ff ff       	call   21c0 <snprintf@plt>
    c0ee:	48 89 df             	mov    %rbx,%rdi
    c0f1:	e8 6a 60 ff ff       	call   2160 <strlen@plt>
    c0f6:	49 89 c6             	mov    %rax,%r14
    c0f9:	48 89 df             	mov    %rbx,%rdi
    c0fc:	be 2e 00 00 00       	mov    $0x2e,%esi
    c101:	e8 9a 60 ff ff       	call   21a0 <strchr@plt>
    c106:	48 85 c0             	test   %rax,%rax
    c109:	74 5b                	je     c166 <fwp_format_g+0x156>
    c10b:	4d 85 f6             	test   %r14,%r14
    c10e:	74 56                	je     c166 <fwp_format_g+0x156>
    c110:	42 0f b6 44 33 ff    	movzbl -0x1(%rbx,%r14,1),%eax
    c116:	83 f8 30             	cmp    $0x30,%eax
    c119:	75 5d                	jne    c178 <fwp_format_g+0x168>
    c11b:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    c121:	49 ff ce             	dec    %r14
    c124:	75 ea                	jne    c110 <fwp_format_g+0x100>
    c126:	eb 3e                	jmp    c166 <fwp_format_g+0x156>
    c128:	83 f8 2e             	cmp    $0x2e,%eax
    c12b:	75 06                	jne    c133 <fwp_format_g+0x123>
    c12d:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    c133:	44 89 f0             	mov    %r14d,%eax
    c136:	c1 e8 1f             	shr    $0x1f,%eax
    c139:	44 8d 04 45 2b 00 00 	lea    0x2b(,%rax,2),%r8d
    c140:	00 
    c141:	45 89 f1             	mov    %r14d,%r9d
    c144:	41 f7 d9             	neg    %r9d
    c147:	45 0f 48 ce          	cmovs  %r14d,%r9d
    c14b:	48 8d 15 36 32 00 00 	lea    0x3236(%rip),%rdx        # f388 <exec_in_fp0+0xd28>
    c152:	48 8d 4c 24 10       	lea    0x10(%rsp),%rcx
    c157:	be 90 01 00 00       	mov    $0x190,%esi
    c15c:	48 89 df             	mov    %rbx,%rdi
    c15f:	31 c0                	xor    %eax,%eax
    c161:	e8 5a 60 ff ff       	call   21c0 <snprintf@plt>
    c166:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    c16d:	5b                   	pop    %rbx
    c16e:	41 5c                	pop    %r12
    c170:	41 5d                	pop    %r13
    c172:	41 5e                	pop    %r14
    c174:	41 5f                	pop    %r15
    c176:	5d                   	pop    %rbp
    c177:	c3                   	ret
    c178:	83 f8 2e             	cmp    $0x2e,%eax
    c17b:	75 e9                	jne    c166 <fwp_format_g+0x156>
    c17d:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    c183:	eb e1                	jmp    c166 <fwp_format_g+0x156>
    c185:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    c18c:	00 00 00 00 

000000000000c190 <fwp_finish_float>:
    c190:	53                   	push   %rbx
    c191:	48 89 fb             	mov    %rdi,%rbx
    c194:	be 2e 00 00 00       	mov    $0x2e,%esi
    c199:	e8 02 60 ff ff       	call   21a0 <strchr@plt>
    c19e:	48 85 c0             	test   %rax,%rax
    c1a1:	74 02                	je     c1a5 <fwp_finish_float+0x15>
    c1a3:	5b                   	pop    %rbx
    c1a4:	c3                   	ret
    c1a5:	48 89 df             	mov    %rbx,%rdi
    c1a8:	be 65 00 00 00       	mov    $0x65,%esi
    c1ad:	e8 ee 5f ff ff       	call   21a0 <strchr@plt>
    c1b2:	48 85 c0             	test   %rax,%rax
    c1b5:	75 ec                	jne    c1a3 <fwp_finish_float+0x13>
    c1b7:	48 8d 35 05 31 00 00 	lea    0x3105(%rip),%rsi        # f2c3 <exec_in_fp0+0xc63>
    c1be:	48 89 df             	mov    %rbx,%rdi
    c1c1:	e8 1a 63 ff ff       	call   24e0 <strstr@plt>
    c1c6:	48 85 c0             	test   %rax,%rax
    c1c9:	75 d8                	jne    c1a3 <fwp_finish_float+0x13>
    c1cb:	48 8d 35 f5 30 00 00 	lea    0x30f5(%rip),%rsi        # f2c7 <exec_in_fp0+0xc67>
    c1d2:	48 89 df             	mov    %rbx,%rdi
    c1d5:	e8 06 63 ff ff       	call   24e0 <strstr@plt>
    c1da:	48 85 c0             	test   %rax,%rax
    c1dd:	75 c4                	jne    c1a3 <fwp_finish_float+0x13>
    c1df:	48 89 df             	mov    %rbx,%rdi
    c1e2:	e8 79 5f ff ff       	call   2160 <strlen@plt>
    c1e7:	66 c7 04 03 2e 30    	movw   $0x302e,(%rbx,%rax,1)
    c1ed:	c6 44 03 02 00       	movb   $0x0,0x2(%rbx,%rax,1)
    c1f2:	5b                   	pop    %rbx
    c1f3:	c3                   	ret
    c1f4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    c1fb:	00 00 00 00 00 

000000000000c200 <fwp_is_negative>:
    c200:	50                   	push   %rax
    c201:	8b 0e                	mov    (%rsi),%ecx
    c203:	31 c0                	xor    %eax,%eax
    c205:	48 83 f9 0b          	cmp    $0xb,%rcx
    c209:	77 16                	ja     c221 <fwp_is_negative+0x21>
    c20b:	48 8d 15 12 22 00 00 	lea    0x2212(%rip),%rdx        # e424 <_IO_stdin_used+0x424>
    c212:	48 63 0c 8a          	movslq (%rdx,%rcx,4),%rcx
    c216:	48 01 d1             	add    %rdx,%rcx
    c219:	ff e1                	jmp    *%rcx
    c21b:	48 c1 ef 3f          	shr    $0x3f,%rdi
    c21f:	89 f8                	mov    %edi,%eax
    c221:	59                   	pop    %rcx
    c222:	c3                   	ret
    c223:	e8 78 8d ff ff       	call   4fa0 <fwp_f32>
    c228:	0f 50 c0             	movmskps %xmm0,%eax
    c22b:	eb 09                	jmp    c236 <fwp_is_negative+0x36>
    c22d:	e8 de 6d ff ff       	call   3010 <fwp_f64>
    c232:	66 0f 50 c0          	movmskpd %xmm0,%eax
    c236:	83 e0 01             	and    $0x1,%eax
    c239:	59                   	pop    %rcx
    c23a:	c3                   	ret
    c23b:	e8 d0 dd ff ff       	call   a010 <fwp_i128>
    c240:	48 89 d0             	mov    %rdx,%rax
    c243:	48 c1 e8 3f          	shr    $0x3f,%rax
    c247:	59                   	pop    %rcx
    c248:	c3                   	ret
    c249:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000c250 <fwp_emit>:
    c250:	53                   	push   %rbx
    c251:	48 83 ec 30          	sub    $0x30,%rsp
    c255:	48 89 f8             	mov    %rdi,%rax
    c258:	83 3d c1 9b 01 00 00 	cmpl   $0x0,0x19bc1(%rip)        # 25e20 <fwp_exec_binary_out>
    c25f:	74 66                	je     c2c7 <fwp_emit+0x77>
    c261:	0f 57 c0             	xorps  %xmm0,%xmm0
    c264:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    c269:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    c270:	00 00 
    c272:	48 8d 15 4f 9a 00 00 	lea    0x9a4f(%rip),%rdx        # 15cc8 <d1>
    c279:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    c27e:	48 89 c6             	mov    %rax,%rsi
    c281:	e8 9a 00 00 00       	call   c320 <fwp_encode>
    c286:	c6 44 24 0b 01       	movb   $0x1,0xb(%rsp)
    c28b:	8b 44 24 18          	mov    0x18(%rsp),%eax
    c28f:	89 44 24 0c          	mov    %eax,0xc(%rsp)
    c293:	48 8d 7c 24 0b       	lea    0xb(%rsp),%rdi
    c298:	be 05 00 00 00       	mov    $0x5,%esi
    c29d:	e8 2e a8 ff ff       	call   6ad0 <fwp_pipe_write>
    c2a2:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    c2a7:	48 85 f6             	test   %rsi,%rsi
    c2aa:	74 0a                	je     c2b6 <fwp_emit+0x66>
    c2ac:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    c2b1:	e8 1a a8 ff ff       	call   6ad0 <fwp_pipe_write>
    c2b6:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    c2bb:	e8 90 5d ff ff       	call   2050 <free@plt>
    c2c0:	e8 9b 02 00 00       	call   c560 <fwp_pipe_frame_done>
    c2c5:	eb 1c                	jmp    c2e3 <fwp_emit+0x93>
    c2c7:	83 3d fa 99 00 00 10 	cmpl   $0x10,0x99fa(%rip)        # 15cc8 <d1>
    c2ce:	75 19                	jne    c2e9 <fwp_emit+0x99>
    c2d0:	83 3d 01 9a 00 00 00 	cmpl   $0x0,0x9a01(%rip)        # 15cd8 <d1+0x10>
    c2d7:	75 10                	jne    c2e9 <fwp_emit+0x99>
    c2d9:	48 83 3d ef 99 00 00 	cmpq   $0x0,0x99ef(%rip)        # 15cd0 <d1+0x8>
    c2e0:	00 
    c2e1:	75 06                	jne    c2e9 <fwp_emit+0x99>
    c2e3:	48 83 c4 30          	add    $0x30,%rsp
    c2e7:	5b                   	pop    %rbx
    c2e8:	c3                   	ret
    c2e9:	48 8b 1d c8 7c 00 00 	mov    0x7cc8(%rip),%rbx        # 13fb8 <stdout@GLIBC_2.2.5>
    c2f0:	48 8b 13             	mov    (%rbx),%rdx
    c2f3:	48 8d 35 ce 99 00 00 	lea    0x99ce(%rip),%rsi        # 15cc8 <d1>
    c2fa:	48 89 c7             	mov    %rax,%rdi
    c2fd:	e8 6e eb ff ff       	call   ae70 <fwp_display_top>
    c302:	48 8b 33             	mov    (%rbx),%rsi
    c305:	bf 0a 00 00 00       	mov    $0xa,%edi
    c30a:	48 83 c4 30          	add    $0x30,%rsp
    c30e:	5b                   	pop    %rbx
    c30f:	e9 1c 5f ff ff       	jmp    2230 <fputc@plt>
    c314:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    c31b:	00 00 00 00 00 

000000000000c320 <fwp_encode>:
    c320:	41 57                	push   %r15
    c322:	41 56                	push   %r14
    c324:	41 55                	push   %r13
    c326:	41 54                	push   %r12
    c328:	53                   	push   %rbx
    c329:	8b 02                	mov    (%rdx),%eax
    c32b:	48 83 f8 15          	cmp    $0x15,%rax
    c32f:	0f 87 14 02 00 00    	ja     c549 <fwp_encode+0x229>
    c335:	49 89 d7             	mov    %rdx,%r15
    c338:	49 89 f6             	mov    %rsi,%r14
    c33b:	48 89 fb             	mov    %rdi,%rbx
    c33e:	48 8d 0d 0f 21 00 00 	lea    0x210f(%rip),%rcx        # e454 <_IO_stdin_used+0x454>
    c345:	48 63 04 81          	movslq (%rcx,%rax,4),%rax
    c349:	48 01 c8             	add    %rcx,%rax
    c34c:	ff e0                	jmp    *%rax
    c34e:	48 89 df             	mov    %rbx,%rdi
    c351:	4c 89 f6             	mov    %r14,%rsi
    c354:	ba 01 00 00 00       	mov    $0x1,%edx
    c359:	e9 77 01 00 00       	jmp    c4d5 <fwp_encode+0x1b5>
    c35e:	48 89 df             	mov    %rbx,%rdi
    c361:	4c 89 f6             	mov    %r14,%rsi
    c364:	ba 04 00 00 00       	mov    $0x4,%edx
    c369:	e9 67 01 00 00       	jmp    c4d5 <fwp_encode+0x1b5>
    c36e:	49 8b 36             	mov    (%r14),%rsi
    c371:	48 89 df             	mov    %rbx,%rdi
    c374:	e8 57 02 00 00       	call   c5d0 <fwp_leb128>
    c379:	49 8b 16             	mov    (%r14),%rdx
    c37c:	49 83 c6 08          	add    $0x8,%r14
    c380:	48 89 df             	mov    %rbx,%rdi
    c383:	4c 89 f6             	mov    %r14,%rsi
    c386:	5b                   	pop    %rbx
    c387:	41 5c                	pop    %r12
    c389:	41 5d                	pop    %r13
    c38b:	41 5e                	pop    %r14
    c38d:	41 5f                	pop    %r15
    c38f:	e9 0c b6 ff ff       	jmp    79a0 <buf_put>
    c394:	48 89 df             	mov    %rbx,%rdi
    c397:	4c 89 f6             	mov    %r14,%rsi
    c39a:	ba 02 00 00 00       	mov    $0x2,%edx
    c39f:	e9 31 01 00 00       	jmp    c4d5 <fwp_encode+0x1b5>
    c3a4:	49 8b 36             	mov    (%r14),%rsi
    c3a7:	48 89 df             	mov    %rbx,%rdi
    c3aa:	e8 21 02 00 00       	call   c5d0 <fwp_leb128>
    c3af:	49 83 3e 00          	cmpq   $0x0,(%r14)
    c3b3:	0f 84 90 01 00 00    	je     c549 <fwp_encode+0x229>
    c3b9:	4d 8d 66 10          	lea    0x10(%r14),%r12
    c3bd:	45 31 ed             	xor    %r13d,%r13d
    c3c0:	eb 1e                	jmp    c3e0 <fwp_encode+0xc0>
    c3c2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c3c9:	1f 84 00 00 00 00 00 
    c3d0:	49 ff c5             	inc    %r13
    c3d3:	49 83 c4 10          	add    $0x10,%r12
    c3d7:	4d 3b 2e             	cmp    (%r14),%r13
    c3da:	0f 83 69 01 00 00    	jae    c549 <fwp_encode+0x229>
    c3e0:	49 8b 74 24 f8       	mov    -0x8(%r12),%rsi
    c3e5:	49 8b 57 38          	mov    0x38(%r15),%rdx
    c3e9:	48 89 df             	mov    %rbx,%rdi
    c3ec:	e8 2f ff ff ff       	call   c320 <fwp_encode>
    c3f1:	41 83 3f 12          	cmpl   $0x12,(%r15)
    c3f5:	75 d9                	jne    c3d0 <fwp_encode+0xb0>
    c3f7:	49 8b 34 24          	mov    (%r12),%rsi
    c3fb:	49 8b 57 40          	mov    0x40(%r15),%rdx
    c3ff:	48 89 df             	mov    %rbx,%rdi
    c402:	e8 19 ff ff ff       	call   c320 <fwp_encode>
    c407:	eb c7                	jmp    c3d0 <fwp_encode+0xb0>
    c409:	4c 89 f7             	mov    %r14,%rdi
    c40c:	e8 4f dc ff ff       	call   a060 <fwp_tag>
    c411:	41 89 c4             	mov    %eax,%r12d
    c414:	48 89 df             	mov    %rbx,%rdi
    c417:	4c 89 e6             	mov    %r12,%rsi
    c41a:	e8 b1 01 00 00       	call   c5d0 <fwp_leb128>
    c41f:	49 8b 47 28          	mov    0x28(%r15),%rax
    c423:	42 83 3c a0 00       	cmpl   $0x0,(%rax,%r12,4)
    c428:	0f 8e 1b 01 00 00    	jle    c549 <fwp_encode+0x229>
    c42e:	45 31 ed             	xor    %r13d,%r13d
    c431:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c438:	0f 1f 84 00 00 00 00 
    c43f:	00 
    c440:	4b 8b 74 ee 08       	mov    0x8(%r14,%r13,8),%rsi
    c445:	49 8b 47 30          	mov    0x30(%r15),%rax
    c449:	4a 8b 04 e0          	mov    (%rax,%r12,8),%rax
    c44d:	4a 8b 14 e8          	mov    (%rax,%r13,8),%rdx
    c451:	48 89 df             	mov    %rbx,%rdi
    c454:	e8 c7 fe ff ff       	call   c320 <fwp_encode>
    c459:	49 ff c5             	inc    %r13
    c45c:	49 8b 47 28          	mov    0x28(%r15),%rax
    c460:	4a 63 04 a0          	movslq (%rax,%r12,4),%rax
    c464:	49 39 c5             	cmp    %rax,%r13
    c467:	7c d7                	jl     c440 <fwp_encode+0x120>
    c469:	e9 db 00 00 00       	jmp    c549 <fwp_encode+0x229>
    c46e:	4c 89 f7             	mov    %r14,%rdi
    c471:	e8 9a db ff ff       	call   a010 <fwp_i128>
    c476:	eb 3f                	jmp    c4b7 <fwp_encode+0x197>
    c478:	4c 89 f7             	mov    %r14,%rdi
    c47b:	e8 80 d6 ff ff       	call   9b00 <fwp_list_len>
    c480:	48 89 df             	mov    %rbx,%rdi
    c483:	48 89 c6             	mov    %rax,%rsi
    c486:	e8 45 01 00 00       	call   c5d0 <fwp_leb128>
    c48b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    c490:	4d 85 f6             	test   %r14,%r14
    c493:	0f 84 b0 00 00 00    	je     c549 <fwp_encode+0x229>
    c499:	49 8b 76 08          	mov    0x8(%r14),%rsi
    c49d:	49 8b 57 38          	mov    0x38(%r15),%rdx
    c4a1:	48 89 df             	mov    %rbx,%rdi
    c4a4:	e8 77 fe ff ff       	call   c320 <fwp_encode>
    c4a9:	4d 8b 76 10          	mov    0x10(%r14),%r14
    c4ad:	eb e1                	jmp    c490 <fwp_encode+0x170>
    c4af:	4c 89 f7             	mov    %r14,%rdi
    c4b2:	e8 69 db ff ff       	call   a020 <fwp_u128>
    c4b7:	49 89 d6             	mov    %rdx,%r14
    c4ba:	48 89 df             	mov    %rbx,%rdi
    c4bd:	48 89 c6             	mov    %rax,%rsi
    c4c0:	ba 08 00 00 00       	mov    $0x8,%edx
    c4c5:	e8 b6 00 00 00       	call   c580 <fwp_le>
    c4ca:	48 89 df             	mov    %rbx,%rdi
    c4cd:	4c 89 f6             	mov    %r14,%rsi
    c4d0:	ba 08 00 00 00       	mov    $0x8,%edx
    c4d5:	5b                   	pop    %rbx
    c4d6:	41 5c                	pop    %r12
    c4d8:	41 5d                	pop    %r13
    c4da:	41 5e                	pop    %r14
    c4dc:	41 5f                	pop    %r15
    c4de:	e9 9d 00 00 00       	jmp    c580 <fwp_le>
    c4e3:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    c4e8:	7e 5f                	jle    c549 <fwp_encode+0x229>
    c4ea:	45 31 e4             	xor    %r12d,%r12d
    c4ed:	0f 1f 00             	nopl   (%rax)
    c4f0:	4b 8b 74 e6 08       	mov    0x8(%r14,%r12,8),%rsi
    c4f5:	49 8b 47 20          	mov    0x20(%r15),%rax
    c4f9:	4a 8b 14 e0          	mov    (%rax,%r12,8),%rdx
    c4fd:	48 89 df             	mov    %rbx,%rdi
    c500:	e8 1b fe ff ff       	call   c320 <fwp_encode>
    c505:	49 ff c4             	inc    %r12
    c508:	49 63 47 10          	movslq 0x10(%r15),%rax
    c50c:	49 39 c4             	cmp    %rax,%r12
    c50f:	7c df                	jl     c4f0 <fwp_encode+0x1d0>
    c511:	eb 36                	jmp    c549 <fwp_encode+0x229>
    c513:	49 8b 36             	mov    (%r14),%rsi
    c516:	48 89 df             	mov    %rbx,%rdi
    c519:	e8 b2 00 00 00       	call   c5d0 <fwp_leb128>
    c51e:	49 83 3e 00          	cmpq   $0x0,(%r14)
    c522:	74 25                	je     c549 <fwp_encode+0x229>
    c524:	45 31 e4             	xor    %r12d,%r12d
    c527:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    c52e:	00 00 
    c530:	4b 8b 74 e6 08       	mov    0x8(%r14,%r12,8),%rsi
    c535:	49 8b 57 38          	mov    0x38(%r15),%rdx
    c539:	48 89 df             	mov    %rbx,%rdi
    c53c:	e8 df fd ff ff       	call   c320 <fwp_encode>
    c541:	49 ff c4             	inc    %r12
    c544:	4d 3b 26             	cmp    (%r14),%r12
    c547:	72 e7                	jb     c530 <fwp_encode+0x210>
    c549:	5b                   	pop    %rbx
    c54a:	41 5c                	pop    %r12
    c54c:	41 5d                	pop    %r13
    c54e:	41 5e                	pop    %r14
    c550:	41 5f                	pop    %r15
    c552:	c3                   	ret
    c553:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c55a:	84 00 00 00 00 00 

000000000000c560 <fwp_pipe_frame_done>:
    c560:	83 3d 4d 97 00 00 00 	cmpl   $0x0,0x974d(%rip)        # 15cb4 <fwp_po_listen>
    c567:	78 16                	js     c57f <fwp_pipe_frame_done+0x1f>
    c569:	8b 05 01 99 02 00    	mov    0x29901(%rip),%eax        # 35e70 <fwp_po_frames>
    c56f:	ff c0                	inc    %eax
    c571:	89 05 f9 98 02 00    	mov    %eax,0x298f9(%rip)        # 35e70 <fwp_po_frames>
    c577:	a8 3f                	test   $0x3f,%al
    c579:	0f 84 11 e0 ff ff    	je     a590 <fwp_pipe_poll>
    c57f:	c3                   	ret

000000000000c580 <fwp_le>:
    c580:	85 d2                	test   %edx,%edx
    c582:	7e 44                	jle    c5c8 <fwp_le+0x48>
    c584:	41 57                	push   %r15
    c586:	41 56                	push   %r14
    c588:	41 54                	push   %r12
    c58a:	53                   	push   %rbx
    c58b:	50                   	push   %rax
    c58c:	48 89 f3             	mov    %rsi,%rbx
    c58f:	49 89 fe             	mov    %rdi,%r14
    c592:	41 89 d4             	mov    %edx,%r12d
    c595:	49 c1 e4 03          	shl    $0x3,%r12
    c599:	45 31 ff             	xor    %r15d,%r15d
    c59c:	0f 1f 40 00          	nopl   0x0(%rax)
    c5a0:	48 89 d8             	mov    %rbx,%rax
    c5a3:	44 89 f9             	mov    %r15d,%ecx
    c5a6:	48 d3 e8             	shr    %cl,%rax
    c5a9:	0f be f0             	movsbl %al,%esi
    c5ac:	4c 89 f7             	mov    %r14,%rdi
    c5af:	e8 9c b3 ff ff       	call   7950 <buf_putc>
    c5b4:	49 83 c7 08          	add    $0x8,%r15
    c5b8:	4d 39 fc             	cmp    %r15,%r12
    c5bb:	75 e3                	jne    c5a0 <fwp_le+0x20>
    c5bd:	48 83 c4 08          	add    $0x8,%rsp
    c5c1:	5b                   	pop    %rbx
    c5c2:	41 5c                	pop    %r12
    c5c4:	41 5e                	pop    %r14
    c5c6:	41 5f                	pop    %r15
    c5c8:	c3                   	ret
    c5c9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000c5d0 <fwp_leb128>:
    c5d0:	41 57                	push   %r15
    c5d2:	41 56                	push   %r14
    c5d4:	53                   	push   %rbx
    c5d5:	49 89 f6             	mov    %rsi,%r14
    c5d8:	48 89 fb             	mov    %rdi,%rbx
    c5db:	48 81 fe 80 00 00 00 	cmp    $0x80,%rsi
    c5e2:	73 05                	jae    c5e9 <fwp_leb128+0x19>
    c5e4:	4d 89 f7             	mov    %r14,%r15
    c5e7:	eb 27                	jmp    c610 <fwp_leb128+0x40>
    c5e9:	4d 89 f7             	mov    %r14,%r15
    c5ec:	0f 1f 40 00          	nopl   0x0(%rax)
    c5f0:	49 c1 ef 07          	shr    $0x7,%r15
    c5f4:	44 89 f0             	mov    %r14d,%eax
    c5f7:	0c 80                	or     $0x80,%al
    c5f9:	0f be f0             	movsbl %al,%esi
    c5fc:	48 89 df             	mov    %rbx,%rdi
    c5ff:	e8 4c b3 ff ff       	call   7950 <buf_putc>
    c604:	49 81 fe ff 3f 00 00 	cmp    $0x3fff,%r14
    c60b:	4d 89 fe             	mov    %r15,%r14
    c60e:	77 e0                	ja     c5f0 <fwp_leb128+0x20>
    c610:	41 0f be f7          	movsbl %r15b,%esi
    c614:	48 89 df             	mov    %rbx,%rdi
    c617:	5b                   	pop    %rbx
    c618:	41 5e                	pop    %r14
    c61a:	41 5f                	pop    %r15
    c61c:	e9 2f b3 ff ff       	jmp    7950 <buf_putc>
    c621:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c628:	0f 1f 84 00 00 00 00 
    c62f:	00 

000000000000c630 <fwp_pipe_read>:
    c630:	55                   	push   %rbp
    c631:	41 57                	push   %r15
    c633:	41 56                	push   %r14
    c635:	41 55                	push   %r13
    c637:	41 54                	push   %r12
    c639:	53                   	push   %rbx
    c63a:	50                   	push   %rax
    c63b:	48 89 f3             	mov    %rsi,%rbx
    c63e:	8b 05 30 98 02 00    	mov    0x29830(%rip),%eax        # 35e74 <fwp_pi_kind>
    c644:	83 f8 01             	cmp    $0x1,%eax
    c647:	0f 84 89 00 00 00    	je     c6d6 <fwp_pipe_read+0xa6>
    c64d:	83 f8 02             	cmp    $0x2,%eax
    c650:	0f 85 d7 00 00 00    	jne    c72d <fwp_pipe_read+0xfd>
    c656:	48 89 3c 24          	mov    %rdi,(%rsp)
    c65a:	4c 8b 25 17 98 02 00 	mov    0x29817(%rip),%r12        # 35e78 <fwp_pi_ring>
    c661:	4d 8d ac 24 c0 00 00 	lea    0xc0(%r12),%r13
    c668:	00 
    c669:	49 8d ac 24 c4 00 00 	lea    0xc4(%r12),%rbp
    c670:	00 
    c671:	4c 8d 35 b8 01 00 00 	lea    0x1b8(%rip),%r14        # c830 <fwp_ring_has_data>
    c678:	45 31 ff             	xor    %r15d,%r15d
    c67b:	eb 23                	jmp    c6a0 <fwp_pipe_read+0x70>
    c67d:	0f 1f 00             	nopl   (%rax)
    c680:	44 8b 05 39 96 00 00 	mov    0x9639(%rip),%r8d        # 15cc0 <fwp_pi_sock>
    c687:	4c 89 e7             	mov    %r12,%rdi
    c68a:	4c 89 ee             	mov    %r13,%rsi
    c68d:	48 89 ea             	mov    %rbp,%rdx
    c690:	4c 89 f1             	mov    %r14,%rcx
    c693:	e8 98 dc ff ff       	call   a330 <fwp_ring_wait>
    c698:	85 c0                	test   %eax,%eax
    c69a:	0f 84 6c 01 00 00    	je     c80c <fwp_pipe_read+0x1dc>
    c6a0:	49 8b 4c 24 40       	mov    0x40(%r12),%rcx
    c6a5:	49 8b 84 24 80 00 00 	mov    0x80(%r12),%rax
    c6ac:	00 
    c6ad:	48 29 c1             	sub    %rax,%rcx
    c6b0:	0f 85 9c 00 00 00    	jne    c752 <fwp_pipe_read+0x122>
    c6b6:	41 8b 84 24 40 01 00 	mov    0x140(%r12),%eax
    c6bd:	00 
    c6be:	85 c0                	test   %eax,%eax
    c6c0:	74 be                	je     c680 <fwp_pipe_read+0x50>
    c6c2:	49 8b 44 24 40       	mov    0x40(%r12),%rax
    c6c7:	49 3b 84 24 80 00 00 	cmp    0x80(%r12),%rax
    c6ce:	00 
    c6cf:	75 af                	jne    c680 <fwp_pipe_read+0x50>
    c6d1:	e9 36 01 00 00       	jmp    c80c <fwp_pipe_read+0x1dc>
    c6d6:	4c 8b 35 a3 97 02 00 	mov    0x297a3(%rip),%r14        # 35e80 <fwp_pi_pos>
    c6dd:	4c 8b 3d a4 97 02 00 	mov    0x297a4(%rip),%r15        # 35e88 <fwp_pi_len>
    c6e4:	4d 39 fe             	cmp    %r15,%r14
    c6e7:	0f 85 f9 00 00 00    	jne    c7e6 <fwp_pipe_read+0x1b6>
    c6ed:	49 89 fc             	mov    %rdi,%r12
    c6f0:	4c 8d 35 99 97 02 00 	lea    0x29799(%rip),%r14        # 35e90 <fwp_pi_buf>
    c6f7:	45 31 ff             	xor    %r15d,%r15d
    c6fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    c700:	8b 3d ba 95 00 00    	mov    0x95ba(%rip),%edi        # 15cc0 <fwp_pi_sock>
    c706:	ba 00 00 01 00       	mov    $0x10000,%edx
    c70b:	4c 89 f6             	mov    %r14,%rsi
    c70e:	31 c9                	xor    %ecx,%ecx
    c710:	e8 4b 59 ff ff       	call   2060 <recv@plt>
    c715:	48 85 c0             	test   %rax,%rax
    c718:	0f 89 b6 00 00 00    	jns    c7d4 <fwp_pipe_read+0x1a4>
    c71e:	e8 5d 59 ff ff       	call   2080 <__errno_location@plt>
    c723:	83 38 04             	cmpl   $0x4,(%rax)
    c726:	74 d8                	je     c700 <fwp_pipe_read+0xd0>
    c728:	e9 df 00 00 00       	jmp    c80c <fwp_pipe_read+0x1dc>
    c72d:	48 8b 05 8c 78 00 00 	mov    0x788c(%rip),%rax        # 13fc0 <stdin@GLIBC_2.2.5>
    c734:	48 8b 08             	mov    (%rax),%rcx
    c737:	be 01 00 00 00       	mov    $0x1,%esi
    c73c:	48 89 da             	mov    %rbx,%rdx
    c73f:	48 83 c4 08          	add    $0x8,%rsp
    c743:	5b                   	pop    %rbx
    c744:	41 5c                	pop    %r12
    c746:	41 5d                	pop    %r13
    c748:	41 5e                	pop    %r14
    c74a:	41 5f                	pop    %r15
    c74c:	5d                   	pop    %rbp
    c74d:	e9 8e 59 ff ff       	jmp    20e0 <fread@plt>
    c752:	48 39 d9             	cmp    %rbx,%rcx
    c755:	48 0f 42 d9          	cmovb  %rcx,%rbx
    c759:	4d 8b 74 24 08       	mov    0x8(%r12),%r14
    c75e:	49 8d 4e ff          	lea    -0x1(%r14),%rcx
    c762:	48 21 c1             	and    %rax,%rcx
    c765:	49 29 ce             	sub    %rcx,%r14
    c768:	4c 39 f3             	cmp    %r14,%rbx
    c76b:	4c 0f 42 f3          	cmovb  %rbx,%r14
    c76f:	4d 8d bc 24 00 10 00 	lea    0x1000(%r12),%r15
    c776:	00 
    c777:	49 8d 34 0c          	lea    (%r12,%rcx,1),%rsi
    c77b:	48 81 c6 00 10 00 00 	add    $0x1000,%rsi
    c782:	4c 8b 2c 24          	mov    (%rsp),%r13
    c786:	4c 89 ef             	mov    %r13,%rdi
    c789:	4c 89 f2             	mov    %r14,%rdx
    c78c:	e8 8f 5b ff ff       	call   2320 <memcpy@plt>
    c791:	4d 01 f5             	add    %r14,%r13
    c794:	48 89 da             	mov    %rbx,%rdx
    c797:	4c 29 f2             	sub    %r14,%rdx
    c79a:	4c 89 ef             	mov    %r13,%rdi
    c79d:	4c 89 fe             	mov    %r15,%rsi
    c7a0:	e8 7b 5b ff ff       	call   2320 <memcpy@plt>
    c7a5:	49 8b 84 24 80 00 00 	mov    0x80(%r12),%rax
    c7ac:	00 
    c7ad:	48 01 d8             	add    %rbx,%rax
    c7b0:	49 89 84 24 80 00 00 	mov    %rax,0x80(%r12)
    c7b7:	00 
    c7b8:	49 8d bc 24 00 01 00 	lea    0x100(%r12),%rdi
    c7bf:	00 
    c7c0:	49 81 c4 04 01 00 00 	add    $0x104,%r12
    c7c7:	4c 89 e6             	mov    %r12,%rsi
    c7ca:	e8 c1 dc ff ff       	call   a490 <fwp_ring_wake>
    c7cf:	49 89 df             	mov    %rbx,%r15
    c7d2:	eb 38                	jmp    c80c <fwp_pipe_read+0x1dc>
    c7d4:	74 48                	je     c81e <fwp_pipe_read+0x1ee>
    c7d6:	4c 89 e7             	mov    %r12,%rdi
    c7d9:	48 89 05 a8 96 02 00 	mov    %rax,0x296a8(%rip)        # 35e88 <fwp_pi_len>
    c7e0:	45 31 f6             	xor    %r14d,%r14d
    c7e3:	49 89 c7             	mov    %rax,%r15
    c7e6:	4d 29 f7             	sub    %r14,%r15
    c7e9:	49 39 df             	cmp    %rbx,%r15
    c7ec:	4c 0f 43 fb          	cmovae %rbx,%r15
    c7f0:	48 8d 35 99 96 02 00 	lea    0x29699(%rip),%rsi        # 35e90 <fwp_pi_buf>
    c7f7:	4c 01 f6             	add    %r14,%rsi
    c7fa:	4c 89 fa             	mov    %r15,%rdx
    c7fd:	e8 1e 5b ff ff       	call   2320 <memcpy@plt>
    c802:	4d 01 fe             	add    %r15,%r14
    c805:	4c 89 35 74 96 02 00 	mov    %r14,0x29674(%rip)        # 35e80 <fwp_pi_pos>
    c80c:	4c 89 f8             	mov    %r15,%rax
    c80f:	48 83 c4 08          	add    $0x8,%rsp
    c813:	5b                   	pop    %rbx
    c814:	41 5c                	pop    %r12
    c816:	41 5d                	pop    %r13
    c818:	41 5e                	pop    %r14
    c81a:	41 5f                	pop    %r15
    c81c:	5d                   	pop    %rbp
    c81d:	c3                   	ret
    c81e:	45 31 ff             	xor    %r15d,%r15d
    c821:	eb e9                	jmp    c80c <fwp_pipe_read+0x1dc>
    c823:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c82a:	84 00 00 00 00 00 

000000000000c830 <fwp_ring_has_data>:
    c830:	48 8b 4f 40          	mov    0x40(%rdi),%rcx
    c834:	b8 01 00 00 00       	mov    $0x1,%eax
    c839:	48 3b 8f 80 00 00 00 	cmp    0x80(%rdi),%rcx
    c840:	75 0d                	jne    c84f <fwp_ring_has_data+0x1f>
    c842:	8b 8f 40 01 00 00    	mov    0x140(%rdi),%ecx
    c848:	31 c0                	xor    %eax,%eax
    c84a:	85 c9                	test   %ecx,%ecx
    c84c:	0f 95 c0             	setne  %al
    c84f:	c3                   	ret

000000000000c850 <fwp_pipe_report>:
    c850:	53                   	push   %rbx
    c851:	48 89 fb             	mov    %rdi,%rbx
    c854:	48 8d 3d 6a 2b 00 00 	lea    0x2b6a(%rip),%rdi        # f3c5 <exec_in_fp0+0xd65>
    c85b:	e8 d0 57 ff ff       	call   2030 <getenv@plt>
    c860:	48 85 c0             	test   %rax,%rax
    c863:	74 18                	je     c87d <fwp_pipe_report+0x2d>
    c865:	80 38 00             	cmpb   $0x0,(%rax)
    c868:	74 13                	je     c87d <fwp_pipe_report+0x2d>
    c86a:	48 8d 35 27 2b 00 00 	lea    0x2b27(%rip),%rsi        # f398 <exec_in_fp0+0xd38>
    c871:	48 89 c7             	mov    %rax,%rdi
    c874:	e8 47 5a ff ff       	call   22c0 <strcmp@plt>
    c879:	85 c0                	test   %eax,%eax
    c87b:	75 02                	jne    c87f <fwp_pipe_report+0x2f>
    c87d:	5b                   	pop    %rbx
    c87e:	c3                   	ret
    c87f:	48 8b 05 5a 77 00 00 	mov    0x775a(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    c886:	48 8b 38             	mov    (%rax),%rdi
    c889:	48 8d 35 4a 2b 00 00 	lea    0x2b4a(%rip),%rsi        # f3da <exec_in_fp0+0xd7a>
    c890:	48 89 da             	mov    %rbx,%rdx
    c893:	31 c0                	xor    %eax,%eax
    c895:	5b                   	pop    %rbx
    c896:	e9 45 5a ff ff       	jmp    22e0 <fprintf@plt>
    c89b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000c8a0 <rd_le>:
    c8a0:	55                   	push   %rbp
    c8a1:	41 56                	push   %r14
    c8a3:	53                   	push   %rbx
    c8a4:	48 83 ec 10          	sub    $0x10,%rsp
    c8a8:	48 89 d3             	mov    %rdx,%rbx
    c8ab:	89 f5                	mov    %esi,%ebp
    c8ad:	41 89 f6             	mov    %esi,%r14d
    c8b0:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    c8b5:	4c 89 f6             	mov    %r14,%rsi
    c8b8:	e8 23 01 00 00       	call   c9e0 <rd_take>
    c8bd:	85 c0                	test   %eax,%eax
    c8bf:	74 20                	je     c8e1 <rd_le+0x41>
    c8c1:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    c8c8:	b8 01 00 00 00       	mov    $0x1,%eax
    c8cd:	85 ed                	test   %ebp,%ebp
    c8cf:	7e 7d                	jle    c94e <rd_le+0xae>
    c8d1:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    c8d6:	83 fd 01             	cmp    $0x1,%ebp
    c8d9:	75 0a                	jne    c8e5 <rd_le+0x45>
    c8db:	31 d2                	xor    %edx,%edx
    c8dd:	31 ff                	xor    %edi,%edi
    c8df:	eb 55                	jmp    c936 <rd_le+0x96>
    c8e1:	31 c0                	xor    %eax,%eax
    c8e3:	eb 69                	jmp    c94e <rd_le+0xae>
    c8e5:	45 89 f0             	mov    %r14d,%r8d
    c8e8:	41 81 e0 fe ff ff 7f 	and    $0x7ffffffe,%r8d
    c8ef:	41 b9 08 00 00 00    	mov    $0x8,%r9d
    c8f5:	31 d2                	xor    %edx,%edx
    c8f7:	31 ff                	xor    %edi,%edi
    c8f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    c900:	44 0f b6 14 16       	movzbl (%rsi,%rdx,1),%r10d
    c905:	41 8d 49 f8          	lea    -0x8(%r9),%ecx
    c909:	80 e1 f0             	and    $0xf0,%cl
    c90c:	49 d3 e2             	shl    %cl,%r10
    c90f:	49 09 fa             	or     %rdi,%r10
    c912:	4c 89 13             	mov    %r10,(%rbx)
    c915:	0f b6 7c 16 01       	movzbl 0x1(%rsi,%rdx,1),%edi
    c91a:	44 89 c9             	mov    %r9d,%ecx
    c91d:	80 e1 f8             	and    $0xf8,%cl
    c920:	48 d3 e7             	shl    %cl,%rdi
    c923:	4c 09 d7             	or     %r10,%rdi
    c926:	48 89 3b             	mov    %rdi,(%rbx)
    c929:	48 83 c2 02          	add    $0x2,%rdx
    c92d:	49 83 c1 10          	add    $0x10,%r9
    c931:	49 39 d0             	cmp    %rdx,%r8
    c934:	75 ca                	jne    c900 <rd_le+0x60>
    c936:	41 f6 c6 01          	test   $0x1,%r14b
    c93a:	74 12                	je     c94e <rd_le+0xae>
    c93c:	0f b6 34 16          	movzbl (%rsi,%rdx,1),%esi
    c940:	c1 e2 03             	shl    $0x3,%edx
    c943:	89 d1                	mov    %edx,%ecx
    c945:	48 d3 e6             	shl    %cl,%rsi
    c948:	48 09 fe             	or     %rdi,%rsi
    c94b:	48 89 33             	mov    %rsi,(%rbx)
    c94e:	48 83 c4 10          	add    $0x10,%rsp
    c952:	5b                   	pop    %rbx
    c953:	41 5e                	pop    %r14
    c955:	5d                   	pop    %rbp
    c956:	c3                   	ret
    c957:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    c95e:	00 00 

000000000000c960 <rd_leb>:
    c960:	41 57                	push   %r15
    c962:	41 56                	push   %r14
    c964:	41 54                	push   %r12
    c966:	53                   	push   %rbx
    c967:	50                   	push   %rax
    c968:	48 89 f3             	mov    %rsi,%rbx
    c96b:	49 89 fe             	mov    %rdi,%r14
    c96e:	48 c7 06 00 00 00 00 	movq   $0x0,(%rsi)
    c975:	49 c7 c7 f9 ff ff ff 	mov    $0xfffffffffffffff9,%r15
    c97c:	49 89 e4             	mov    %rsp,%r12
    c97f:	90                   	nop
    c980:	be 01 00 00 00       	mov    $0x1,%esi
    c985:	4c 89 f7             	mov    %r14,%rdi
    c988:	4c 89 e2             	mov    %r12,%rdx
    c98b:	e8 50 00 00 00       	call   c9e0 <rd_take>
    c990:	85 c0                	test   %eax,%eax
    c992:	74 2f                	je     c9c3 <rd_leb+0x63>
    c994:	48 8b 04 24          	mov    (%rsp),%rax
    c998:	0f b6 10             	movzbl (%rax),%edx
    c99b:	49 83 ff 38          	cmp    $0x38,%r15
    c99f:	75 07                	jne    c9a8 <rd_leb+0x48>
    c9a1:	89 d1                	mov    %edx,%ecx
    c9a3:	80 e1 7e             	and    $0x7e,%cl
    c9a6:	75 1b                	jne    c9c3 <rd_leb+0x63>
    c9a8:	49 83 c7 07          	add    $0x7,%r15
    c9ac:	83 e2 7f             	and    $0x7f,%edx
    c9af:	44 89 f9             	mov    %r15d,%ecx
    c9b2:	48 d3 e2             	shl    %cl,%rdx
    c9b5:	48 09 13             	or     %rdx,(%rbx)
    c9b8:	80 38 00             	cmpb   $0x0,(%rax)
    c9bb:	79 0a                	jns    c9c7 <rd_leb+0x67>
    c9bd:	49 83 ff 38          	cmp    $0x38,%r15
    c9c1:	76 bd                	jbe    c980 <rd_leb+0x20>
    c9c3:	31 c0                	xor    %eax,%eax
    c9c5:	eb 05                	jmp    c9cc <rd_leb+0x6c>
    c9c7:	b8 01 00 00 00       	mov    $0x1,%eax
    c9cc:	48 83 c4 08          	add    $0x8,%rsp
    c9d0:	5b                   	pop    %rbx
    c9d1:	41 5c                	pop    %r12
    c9d3:	41 5e                	pop    %r14
    c9d5:	41 5f                	pop    %r15
    c9d7:	c3                   	ret
    c9d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c9df:	00 

000000000000c9e0 <rd_take>:
    c9e0:	4c 8b 47 08          	mov    0x8(%rdi),%r8
    c9e4:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    c9e8:	49 29 c8             	sub    %rcx,%r8
    c9eb:	31 c0                	xor    %eax,%eax
    c9ed:	49 39 f0             	cmp    %rsi,%r8
    c9f0:	72 15                	jb     ca07 <rd_take+0x27>
    c9f2:	48 8b 07             	mov    (%rdi),%rax
    c9f5:	48 01 c8             	add    %rcx,%rax
    c9f8:	48 89 02             	mov    %rax,(%rdx)
    c9fb:	48 01 ce             	add    %rcx,%rsi
    c9fe:	48 89 77 10          	mov    %rsi,0x10(%rdi)
    ca02:	b8 01 00 00 00       	mov    $0x1,%eax
    ca07:	c3                   	ret
    ca08:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    ca0f:	00 

000000000000ca10 <fwp_getc>:
    ca10:	48 63 05 15 94 01 00 	movslq 0x19415(%rip),%rax        # 25e2c <fwp_in_ppos>
    ca17:	3b 05 0b 94 01 00    	cmp    0x1940b(%rip),%eax        # 25e28 <fwp_in_npend>
    ca1d:	7d 15                	jge    ca34 <fwp_getc+0x24>
    ca1f:	8d 48 01             	lea    0x1(%rax),%ecx
    ca22:	89 0d 04 94 01 00    	mov    %ecx,0x19404(%rip)        # 25e2c <fwp_in_ppos>
    ca28:	48 8d 0d f5 93 01 00 	lea    0x193f5(%rip),%rcx        # 25e24 <fwp_in_pend>
    ca2f:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax
    ca33:	c3                   	ret
    ca34:	48 8b 05 85 75 00 00 	mov    0x7585(%rip),%rax        # 13fc0 <stdin@GLIBC_2.2.5>
    ca3b:	48 8b 38             	mov    (%rax),%rdi
    ca3e:	e9 cd 57 ff ff       	jmp    2210 <fgetc@plt>
    ca43:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ca4a:	84 00 00 00 00 00 

000000000000ca50 <fwp_gc_find_data>:
    ca50:	0f b7 77 18          	movzwl 0x18(%rdi),%esi
    ca54:	48 85 f6             	test   %rsi,%rsi
    ca57:	0f 84 be 00 00 00    	je     cb1b <fwp_gc_find_data+0xcb>
    ca5d:	53                   	push   %rbx
    ca5e:	48 8b 07             	mov    (%rdi),%rax
    ca61:	4c 8b 47 10          	mov    0x10(%rdi),%r8
    ca65:	48 6b ce 38          	imul   $0x38,%rsi,%rcx
    ca69:	45 31 c9             	xor    %r9d,%r9d
    ca6c:	48 8d 15 1d 78 00 00 	lea    0x781d(%rip),%rdx        # 14290 <fwp_gc>
    ca73:	41 bb 01 00 00 00    	mov    $0x1,%r11d
    ca79:	45 31 d2             	xor    %r10d,%r10d
    ca7c:	eb 0b                	jmp    ca89 <fwp_gc_find_data+0x39>
    ca7e:	66 90                	xchg   %ax,%ax
    ca80:	49 83 c1 38          	add    $0x38,%r9
    ca84:	4c 39 c9             	cmp    %r9,%rcx
    ca87:	74 22                	je     caab <fwp_gc_find_data+0x5b>
    ca89:	43 83 3c 08 01       	cmpl   $0x1,(%r8,%r9,1)
    ca8e:	75 f0                	jne    ca80 <fwp_gc_find_data+0x30>
    ca90:	4b 8b 5c 08 10       	mov    0x10(%r8,%r9,1),%rbx
    ca95:	48 01 c3             	add    %rax,%rbx
    ca98:	48 39 d3             	cmp    %rdx,%rbx
    ca9b:	77 e3                	ja     ca80 <fwp_gc_find_data+0x30>
    ca9d:	4b 03 5c 08 28       	add    0x28(%r8,%r9,1),%rbx
    caa2:	48 39 d3             	cmp    %rdx,%rbx
    caa5:	45 0f 47 d3          	cmova  %r11d,%r10d
    caa9:	eb d5                	jmp    ca80 <fwp_gc_find_data+0x30>
    caab:	31 c0                	xor    %eax,%eax
    caad:	45 85 d2             	test   %r10d,%r10d
    cab0:	0f 95 c0             	setne  %al
    cab3:	74 6e                	je     cb23 <fwp_gc_find_data+0xd3>
    cab5:	66 85 f6             	test   %si,%si
    cab8:	74 69                	je     cb23 <fwp_gc_find_data+0xd3>
    caba:	8b 05 60 89 00 00    	mov    0x8960(%rip),%eax        # 15420 <fwp_gc+0x1190>
    cac0:	48 8b 77 10          	mov    0x10(%rdi),%rsi
    cac4:	45 31 c0             	xor    %r8d,%r8d
    cac7:	eb 10                	jmp    cad9 <fwp_gc_find_data+0x89>
    cac9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    cad0:	49 83 c0 38          	add    $0x38,%r8
    cad4:	4c 39 c1             	cmp    %r8,%rcx
    cad7:	74 45                	je     cb1e <fwp_gc_find_data+0xce>
    cad9:	42 83 3c 06 01       	cmpl   $0x1,(%rsi,%r8,1)
    cade:	75 f0                	jne    cad0 <fwp_gc_find_data+0x80>
    cae0:	42 f6 44 06 04 02    	testb  $0x2,0x4(%rsi,%r8,1)
    cae6:	74 e8                	je     cad0 <fwp_gc_find_data+0x80>
    cae8:	83 f8 10             	cmp    $0x10,%eax
    caeb:	74 31                	je     cb1e <fwp_gc_find_data+0xce>
    caed:	4e 8b 4c 06 10       	mov    0x10(%rsi,%r8,1),%r9
    caf2:	4c 03 0f             	add    (%rdi),%r9
    caf5:	4c 63 d0             	movslq %eax,%r10
    caf8:	49 c1 e2 04          	shl    $0x4,%r10
    cafc:	4d 89 8c 12 90 10 00 	mov    %r9,0x1090(%r10,%rdx,1)
    cb03:	00 
    cb04:	4e 8b 4c 06 28       	mov    0x28(%rsi,%r8,1),%r9
    cb09:	4d 89 8c 12 98 10 00 	mov    %r9,0x1098(%r10,%rdx,1)
    cb10:	00 
    cb11:	ff c0                	inc    %eax
    cb13:	89 05 07 89 00 00    	mov    %eax,0x8907(%rip)        # 15420 <fwp_gc+0x1190>
    cb19:	eb b5                	jmp    cad0 <fwp_gc_find_data+0x80>
    cb1b:	31 c0                	xor    %eax,%eax
    cb1d:	c3                   	ret
    cb1e:	b8 01 00 00 00       	mov    $0x1,%eax
    cb23:	5b                   	pop    %rbx
    cb24:	c3                   	ret
    cb25:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    cb2c:	00 00 00 00 

000000000000cb30 <fwp_gc_report>:
    cb30:	41 57                	push   %r15
    cb32:	41 56                	push   %r14
    cb34:	53                   	push   %rbx
    cb35:	48 83 ec 50          	sub    $0x50,%rsp
    cb39:	48 8b 05 60 89 00 00 	mov    0x8960(%rip),%rax        # 154a0 <fwp_gc+0x1210>
    cb40:	48 8b 0d 49 77 00 00 	mov    0x7749(%rip),%rcx        # 14290 <fwp_gc>
    cb47:	48 29 c8             	sub    %rcx,%rax
    cb4a:	f2 48 0f 2a c8       	cvtsi2sd %rax,%xmm1
    cb4f:	f2 0f 58 0d 21 89 00 	addsd  0x8921(%rip),%xmm1        # 15478 <fwp_gc+0x11e8>
    cb56:	00 
    cb57:	f2 0f 11 0d 19 89 00 	movsd  %xmm1,0x8919(%rip)        # 15478 <fwp_gc+0x11e8>
    cb5e:	00 
    cb5f:	48 89 0d 3a 89 00 00 	mov    %rcx,0x893a(%rip)        # 154a0 <fwp_gc+0x1210>
    cb66:	48 8b 05 73 74 00 00 	mov    0x7473(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    cb6d:	4c 8b 38             	mov    (%rax),%r15
    cb70:	48 8b 1d f1 88 00 00 	mov    0x88f1(%rip),%rbx        # 15468 <fwp_gc+0x11d8>
    cb77:	4c 8b 35 2a 87 00 00 	mov    0x872a(%rip),%r14        # 152a8 <fwp_gc+0x1018>
    cb7e:	f2 0f 10 15 12 89 00 	movsd  0x8912(%rip),%xmm2        # 15498 <fwp_gc+0x1208>
    cb85:	00 
    cb86:	f2 0f 58 ca          	addsd  %xmm2,%xmm1
    cb8a:	f2 0f 10 05 b6 14 00 	movsd  0x14b6(%rip),%xmm0        # e048 <_IO_stdin_used+0x48>
    cb91:	00 
    cb92:	f2 0f 59 c8          	mulsd  %xmm0,%xmm1
    cb96:	f2 0f 11 4c 24 18    	movsd  %xmm1,0x18(%rsp)
    cb9c:	f2 0f 59 d0          	mulsd  %xmm0,%xmm2
    cba0:	f2 0f 11 54 24 10    	movsd  %xmm2,0x10(%rsp)
    cba6:	f2 0f 10 0d 2a 87 00 	movsd  0x872a(%rip),%xmm1        # 152d8 <fwp_gc+0x1048>
    cbad:	00 
    cbae:	66 0f 28 15 aa 15 00 	movapd 0x15aa(%rip),%xmm2        # e160 <_IO_stdin_used+0x160>
    cbb5:	00 
    cbb6:	0f 14 ca             	unpcklps %xmm2,%xmm1
    cbb9:	66 0f 28 1d af 15 00 	movapd 0x15af(%rip),%xmm3        # e170 <_IO_stdin_used+0x170>
    cbc0:	00 
    cbc1:	66 0f 5c cb          	subpd  %xmm3,%xmm1
    cbc5:	66 0f 28 e1          	movapd %xmm1,%xmm4
    cbc9:	66 0f 15 e1          	unpckhpd %xmm1,%xmm4
    cbcd:	f2 0f 58 e1          	addsd  %xmm1,%xmm4
    cbd1:	f2 0f 59 e0          	mulsd  %xmm0,%xmm4
    cbd5:	66 0f 29 64 24 40    	movapd %xmm4,0x40(%rsp)
    cbdb:	f2 0f 10 0d 75 88 00 	movsd  0x8875(%rip),%xmm1        # 15458 <fwp_gc+0x11c8>
    cbe2:	00 
    cbe3:	0f 14 ca             	unpcklps %xmm2,%xmm1
    cbe6:	66 0f 5c cb          	subpd  %xmm3,%xmm1
    cbea:	66 0f 28 e1          	movapd %xmm1,%xmm4
    cbee:	66 0f 15 e1          	unpckhpd %xmm1,%xmm4
    cbf2:	f2 0f 58 e1          	addsd  %xmm1,%xmm4
    cbf6:	f2 0f 59 e0          	mulsd  %xmm0,%xmm4
    cbfa:	66 0f 29 64 24 30    	movapd %xmm4,0x30(%rsp)
    cc00:	f2 0f 10 0d 58 88 00 	movsd  0x8858(%rip),%xmm1        # 15460 <fwp_gc+0x11d0>
    cc07:	00 
    cc08:	0f 14 ca             	unpcklps %xmm2,%xmm1
    cc0b:	66 0f 5c cb          	subpd  %xmm3,%xmm1
    cc0f:	66 0f 28 d1          	movapd %xmm1,%xmm2
    cc13:	66 0f 15 d1          	unpckhpd %xmm1,%xmm2
    cc17:	f2 0f 58 d1          	addsd  %xmm1,%xmm2
    cc1b:	f2 0f 59 d0          	mulsd  %xmm0,%xmm2
    cc1f:	66 0f 29 54 24 20    	movapd %xmm2,0x20(%rsp)
    cc25:	f2 0f 10 05 53 88 00 	movsd  0x8853(%rip),%xmm0        # 15480 <fwp_gc+0x11f0>
    cc2c:	00 
    cc2d:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    cc33:	f2 0f 10 05 4d 88 00 	movsd  0x884d(%rip),%xmm0        # 15488 <fwp_gc+0x11f8>
    cc3a:	00 
    cc3b:	f2 0f 11 04 24       	movsd  %xmm0,(%rsp)
    cc40:	e8 6b 00 00 00       	call   ccb0 <fwp_gc_status_kb>
    cc45:	83 3d 38 86 00 00 00 	cmpl   $0x0,0x8638(%rip)        # 15284 <fwp_gc+0xff4>
    cc4c:	48 8d 0d 22 29 00 00 	lea    0x2922(%rip),%rcx        # f575 <exec_in_fp0+0xf15>
    cc53:	4c 8d 0d 5c 24 00 00 	lea    0x245c(%rip),%r9        # f0b6 <exec_in_fp0+0xa56>
    cc5a:	4c 0f 44 c9          	cmove  %rcx,%r9
    cc5e:	48 8d 35 5b 28 00 00 	lea    0x285b(%rip),%rsi        # f4c0 <exec_in_fp0+0xe60>
    cc65:	4c 89 ff             	mov    %r15,%rdi
    cc68:	48 89 da             	mov    %rbx,%rdx
    cc6b:	4c 89 f1             	mov    %r14,%rcx
    cc6e:	f2 0f 10 44 24 18    	movsd  0x18(%rsp),%xmm0
    cc74:	f2 0f 10 4c 24 10    	movsd  0x10(%rsp),%xmm1
    cc7a:	0f 28 54 24 40       	movaps 0x40(%rsp),%xmm2
    cc7f:	0f 28 5c 24 30       	movaps 0x30(%rsp),%xmm3
    cc84:	0f 28 64 24 20       	movaps 0x20(%rsp),%xmm4
    cc89:	f2 0f 10 6c 24 08    	movsd  0x8(%rsp),%xmm5
    cc8f:	f2 0f 10 34 24       	movsd  (%rsp),%xmm6
    cc94:	49 89 c0             	mov    %rax,%r8
    cc97:	b0 07                	mov    $0x7,%al
    cc99:	48 83 c4 50          	add    $0x50,%rsp
    cc9d:	5b                   	pop    %rbx
    cc9e:	41 5e                	pop    %r14
    cca0:	41 5f                	pop    %r15
    cca2:	e9 39 56 ff ff       	jmp    22e0 <fprintf@plt>
    cca7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    ccae:	00 00 

000000000000ccb0 <fwp_gc_status_kb>:
    ccb0:	55                   	push   %rbp
    ccb1:	41 57                	push   %r15
    ccb3:	41 56                	push   %r14
    ccb5:	41 54                	push   %r12
    ccb7:	53                   	push   %rbx
    ccb8:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
    ccbf:	48 8d 3d c1 28 00 00 	lea    0x28c1(%rip),%rdi        # f587 <exec_in_fp0+0xf27>
    ccc6:	48 8d 35 da 26 00 00 	lea    0x26da(%rip),%rsi        # f3a7 <exec_in_fp0+0xd47>
    cccd:	e8 3e 57 ff ff       	call   2410 <fopen@plt>
    ccd2:	48 85 c0             	test   %rax,%rax
    ccd5:	74 7d                	je     cd54 <fwp_gc_status_kb+0xa4>
    ccd7:	48 89 c3             	mov    %rax,%rbx
    ccda:	48 89 e7             	mov    %rsp,%rdi
    ccdd:	be 00 01 00 00       	mov    $0x100,%esi
    cce2:	48 89 c2             	mov    %rax,%rdx
    cce5:	e8 96 55 ff ff       	call   2280 <fgets@plt>
    ccea:	49 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%r14
    ccf1:	48 85 c0             	test   %rax,%rax
    ccf4:	74 54                	je     cd4a <fwp_gc_status_kb+0x9a>
    ccf6:	4c 8d 7c 24 06       	lea    0x6(%rsp),%r15
    ccfb:	bd 56 6d 48 57       	mov    $0x57486d56,%ebp
    cd00:	49 89 e4             	mov    %rsp,%r12
    cd03:	eb 20                	jmp    cd25 <fwp_gc_status_kb+0x75>
    cd05:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    cd0c:	00 00 00 00 
    cd10:	4c 89 e7             	mov    %r12,%rdi
    cd13:	be 00 01 00 00       	mov    $0x100,%esi
    cd18:	48 89 da             	mov    %rbx,%rdx
    cd1b:	e8 60 55 ff ff       	call   2280 <fgets@plt>
    cd20:	48 85 c0             	test   %rax,%rax
    cd23:	74 25                	je     cd4a <fwp_gc_status_kb+0x9a>
    cd25:	8b 04 24             	mov    (%rsp),%eax
    cd28:	31 e8                	xor    %ebp,%eax
    cd2a:	0f b6 4c 24 04       	movzbl 0x4(%rsp),%ecx
    cd2f:	83 f1 4d             	xor    $0x4d,%ecx
    cd32:	09 c1                	or     %eax,%ecx
    cd34:	75 da                	jne    cd10 <fwp_gc_status_kb+0x60>
    cd36:	80 7c 24 05 3a       	cmpb   $0x3a,0x5(%rsp)
    cd3b:	75 d3                	jne    cd10 <fwp_gc_status_kb+0x60>
    cd3d:	4c 89 ff             	mov    %r15,%rdi
    cd40:	e8 ab 56 ff ff       	call   23f0 <atol@plt>
    cd45:	49 89 c6             	mov    %rax,%r14
    cd48:	eb c6                	jmp    cd10 <fwp_gc_status_kb+0x60>
    cd4a:	48 89 df             	mov    %rbx,%rdi
    cd4d:	e8 ee 53 ff ff       	call   2140 <fclose@plt>
    cd52:	eb 07                	jmp    cd5b <fwp_gc_status_kb+0xab>
    cd54:	49 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%r14
    cd5b:	4c 89 f0             	mov    %r14,%rax
    cd5e:	48 81 c4 00 01 00 00 	add    $0x100,%rsp
    cd65:	5b                   	pop    %rbx
    cd66:	41 5c                	pop    %r12
    cd68:	41 5e                	pop    %r14
    cd6a:	41 5f                	pop    %r15
    cd6c:	5d                   	pop    %rbp
    cd6d:	c3                   	ret
    cd6e:	66 90                	xchg   %ax,%ax

000000000000cd70 <w3>:
    cd70:	41 57                	push   %r15
    cd72:	41 56                	push   %r14
    cd74:	41 54                	push   %r12
    cd76:	53                   	push   %rbx
    cd77:	50                   	push   %rax
    cd78:	48 89 fb             	mov    %rdi,%rbx
    cd7b:	e8 60 5c ff ff       	call   29e0 <fwp_from_f64>
    cd80:	49 89 c6             	mov    %rax,%r14
    cd83:	48 bf 00 00 00 00 00 	movabs $0x3fd0000000000000,%rdi
    cd8a:	00 d0 3f 
    cd8d:	48 89 c6             	mov    %rax,%rsi
    cd90:	e8 8b 8d ff ff       	call   5b20 <f6>
    cd95:	49 89 c7             	mov    %rax,%r15
    cd98:	4c 89 f7             	mov    %r14,%rdi
    cd9b:	e8 b0 8d ff ff       	call   5b50 <f10>
    cda0:	49 89 c4             	mov    %rax,%r12
    cda3:	4c 89 f7             	mov    %r14,%rdi
    cda6:	e8 65 62 ff ff       	call   3010 <fwp_f64>
    cdab:	f2 0f 11 03          	movsd  %xmm0,(%rbx)
    cdaf:	4c 89 ff             	mov    %r15,%rdi
    cdb2:	e8 59 62 ff ff       	call   3010 <fwp_f64>
    cdb7:	f2 0f 11 43 08       	movsd  %xmm0,0x8(%rbx)
    cdbc:	4c 89 e7             	mov    %r12,%rdi
    cdbf:	e8 4c 62 ff ff       	call   3010 <fwp_f64>
    cdc4:	f2 0f 11 43 10       	movsd  %xmm0,0x10(%rbx)
    cdc9:	48 89 d8             	mov    %rbx,%rax
    cdcc:	48 83 c4 08          	add    $0x8,%rsp
    cdd0:	5b                   	pop    %rbx
    cdd1:	41 5c                	pop    %r12
    cdd3:	41 5e                	pop    %r14
    cdd5:	41 5f                	pop    %r15
    cdd7:	c3                   	ret
    cdd8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    cddf:	00 

000000000000cde0 <fwp_rc_drop_slot>:
    cde0:	0f b6 07             	movzbl (%rdi),%eax
    cde3:	3c ff                	cmp    $0xff,%al
    cde5:	74 09                	je     cdf0 <fwp_rc_wide_drop>
    cde7:	3c 02                	cmp    $0x2,%al
    cde9:	72 04                	jb     cdef <fwp_rc_drop_slot+0xf>
    cdeb:	fe c8                	dec    %al
    cded:	88 07                	mov    %al,(%rdi)
    cdef:	c3                   	ret

000000000000cdf0 <fwp_rc_wide_drop>:
    cdf0:	53                   	push   %rbx
    cdf1:	48 89 fb             	mov    %rdi,%rbx
    cdf4:	e8 27 61 ff ff       	call   2f20 <fwp_rc_wide_link>
    cdf9:	48 8b 00             	mov    (%rax),%rax
    cdfc:	48 85 c0             	test   %rax,%rax
    cdff:	74 21                	je     ce22 <fwp_rc_wide_drop+0x32>
    ce01:	48 8b 48 08          	mov    0x8(%rax),%rcx
    ce05:	48 ff c9             	dec    %rcx
    ce08:	48 89 48 08          	mov    %rcx,0x8(%rax)
    ce0c:	48 81 f9 fe 00 00 00 	cmp    $0xfe,%rcx
    ce13:	75 0b                	jne    ce20 <fwp_rc_wide_drop+0x30>
    ce15:	48 89 df             	mov    %rbx,%rdi
    ce18:	e8 c3 60 ff ff       	call   2ee0 <fwp_rc_forget_slot>
    ce1d:	c6 03 fe             	movb   $0xfe,(%rbx)
    ce20:	5b                   	pop    %rbx
    ce21:	c3                   	ret
    ce22:	48 8d 3d f8 18 00 00 	lea    0x18f8(%rip),%rdi        # e721 <exec_in_fp0+0xc1>
    ce29:	e8 52 61 ff ff       	call   2f80 <fwp_trap>
    ce2e:	66 90                	xchg   %ax,%ax

000000000000ce30 <fwp_rc_poison>:
    ce30:	53                   	push   %rbx
    ce31:	48 89 f9             	mov    %rdi,%rcx
    ce34:	48 2b 0d 85 84 00 00 	sub    0x8485(%rip),%rcx        # 152c0 <fwp_gc+0x1030>
    ce3b:	48 8b 05 c6 84 00 00 	mov    0x84c6(%rip),%rax        # 15308 <fwp_gc+0x1078>
    ce42:	48 c1 e9 10          	shr    $0x10,%rcx
    ce46:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    ce4d:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    ce52:	75 0d                	jne    ce61 <fwp_rc_poison+0x31>
    ce54:	80 3c 08 02          	cmpb   $0x2,(%rax,%rcx,1)
    ce58:	75 1e                	jne    ce78 <fwp_rc_poison+0x48>
    ce5a:	48 8b 54 08 18       	mov    0x18(%rax,%rcx,1),%rdx
    ce5f:	eb 1b                	jmp    ce7c <fwp_rc_poison+0x4c>
    ce61:	c7 07 ad de 00 00    	movl   $0xdead,(%rdi)
    ce67:	8b 47 04             	mov    0x4(%rdi),%eax
    ce6a:	48 85 c0             	test   %rax,%rax
    ce6d:	74 7e                	je     ceed <fwp_rc_poison+0xbd>
    ce6f:	83 f8 04             	cmp    $0x4,%eax
    ce72:	73 22                	jae    ce96 <fwp_rc_poison+0x66>
    ce74:	31 c9                	xor    %ecx,%ecx
    ce76:	eb 50                	jmp    cec8 <fwp_rc_poison+0x98>
    ce78:	8b 54 08 08          	mov    0x8(%rax,%rcx,1),%edx
    ce7c:	48 89 fb             	mov    %rdi,%rbx
    ce7f:	be dd 00 00 00       	mov    $0xdd,%esi
    ce84:	e8 77 53 ff ff       	call   2200 <memset@plt>
    ce89:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    ce90:	c6 43 08 00          	movb   $0x0,0x8(%rbx)
    ce94:	5b                   	pop    %rbx
    ce95:	c3                   	ret
    ce96:	89 c1                	mov    %eax,%ecx
    ce98:	83 e1 fc             	and    $0xfffffffc,%ecx
    ce9b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    cea2:	00 
    cea3:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    cea7:	31 f6                	xor    %esi,%esi
    cea9:	0f 28 05 d0 12 00 00 	movaps 0x12d0(%rip),%xmm0        # e180 <_IO_stdin_used+0x180>
    ceb0:	0f 11 44 37 08       	movups %xmm0,0x8(%rdi,%rsi,1)
    ceb5:	0f 11 44 37 18       	movups %xmm0,0x18(%rdi,%rsi,1)
    ceba:	48 83 c6 20          	add    $0x20,%rsi
    cebe:	48 39 f2             	cmp    %rsi,%rdx
    cec1:	75 ed                	jne    ceb0 <fwp_rc_poison+0x80>
    cec3:	48 39 c1             	cmp    %rax,%rcx
    cec6:	74 25                	je     ceed <fwp_rc_poison+0xbd>
    cec8:	48 ba ef be ad de ef 	movabs $0xdeadbeefdeadbeef,%rdx
    cecf:	be ad de 
    ced2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ced9:	1f 84 00 00 00 00 00 
    cee0:	48 89 54 cf 08       	mov    %rdx,0x8(%rdi,%rcx,8)
    cee5:	48 ff c1             	inc    %rcx
    cee8:	48 39 c8             	cmp    %rcx,%rax
    ceeb:	75 f3                	jne    cee0 <fwp_rc_poison+0xb0>
    ceed:	5b                   	pop    %rbx
    ceee:	c3                   	ret
    ceef:	90                   	nop

000000000000cef0 <__divti3>:
    cef0:	f3 0f 1e fa          	endbr64
    cef4:	55                   	push   %rbp
    cef5:	49 89 f8             	mov    %rdi,%r8
    cef8:	49 89 d2             	mov    %rdx,%r10
    cefb:	49 89 cb             	mov    %rcx,%r11
    cefe:	31 ff                	xor    %edi,%edi
    cf00:	48 89 e5             	mov    %rsp,%rbp
    cf03:	41 56                	push   %r14
    cf05:	53                   	push   %rbx
    cf06:	48 85 f6             	test   %rsi,%rsi
    cf09:	79 13                	jns    cf1e <__divti3+0x2e>
    cf0b:	45 31 c9             	xor    %r9d,%r9d
    cf0e:	49 f7 d8             	neg    %r8
    cf11:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
    cf18:	49 19 f1             	sbb    %rsi,%r9
    cf1b:	4c 89 ce             	mov    %r9,%rsi
    cf1e:	4c 89 da             	mov    %r11,%rdx
    cf21:	4d 85 db             	test   %r11,%r11
    cf24:	0f 88 f6 00 00 00    	js     d020 <__divti3+0x130>
    cf2a:	4d 89 d6             	mov    %r10,%r14
    cf2d:	75 31                	jne    cf60 <__divti3+0x70>
    cf2f:	4c 39 f6             	cmp    %r14,%rsi
    cf32:	0f 83 b8 00 00 00    	jae    cff0 <__divti3+0x100>
    cf38:	48 89 f2             	mov    %rsi,%rdx
    cf3b:	31 f6                	xor    %esi,%esi
    cf3d:	4c 89 c0             	mov    %r8,%rax
    cf40:	49 f7 f6             	div    %r14
    cf43:	48 89 f2             	mov    %rsi,%rdx
    cf46:	48 85 ff             	test   %rdi,%rdi
    cf49:	74 0a                	je     cf55 <__divti3+0x65>
    cf4b:	48 f7 d8             	neg    %rax
    cf4e:	48 83 d2 00          	adc    $0x0,%rdx
    cf52:	48 f7 da             	neg    %rdx
    cf55:	5b                   	pop    %rbx
    cf56:	41 5e                	pop    %r14
    cf58:	5d                   	pop    %rbp
    cf59:	c3                   	ret
    cf5a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    cf60:	4c 39 de             	cmp    %r11,%rsi
    cf63:	0f 82 d5 00 00 00    	jb     d03e <__divti3+0x14e>
    cf69:	4d 0f bd d3          	bsr    %r11,%r10
    cf6d:	41 83 f2 3f          	xor    $0x3f,%r10d
    cf71:	44 89 d1             	mov    %r10d,%ecx
    cf74:	b8 40 00 00 00       	mov    $0x40,%eax
    cf79:	4c 89 f3             	mov    %r14,%rbx
    cf7c:	4d 89 f1             	mov    %r14,%r9
    cf7f:	48 d3 e2             	shl    %cl,%rdx
    cf82:	49 63 ca             	movslq %r10d,%rcx
    cf85:	49 89 f3             	mov    %rsi,%r11
    cf88:	48 29 c8             	sub    %rcx,%rax
    cf8b:	89 c1                	mov    %eax,%ecx
    cf8d:	48 d3 eb             	shr    %cl,%rbx
    cf90:	44 89 d1             	mov    %r10d,%ecx
    cf93:	49 d3 e1             	shl    %cl,%r9
    cf96:	89 c1                	mov    %eax,%ecx
    cf98:	48 09 d3             	or     %rdx,%rbx
    cf9b:	4c 89 c2             	mov    %r8,%rdx
    cf9e:	49 d3 eb             	shr    %cl,%r11
    cfa1:	44 89 d1             	mov    %r10d,%ecx
    cfa4:	48 d3 e6             	shl    %cl,%rsi
    cfa7:	89 c1                	mov    %eax,%ecx
    cfa9:	48 d3 ea             	shr    %cl,%rdx
    cfac:	48 89 d0             	mov    %rdx,%rax
    cfaf:	4c 89 da             	mov    %r11,%rdx
    cfb2:	48 09 f0             	or     %rsi,%rax
    cfb5:	48 f7 f3             	div    %rbx
    cfb8:	49 89 d3             	mov    %rdx,%r11
    cfbb:	48 89 c6             	mov    %rax,%rsi
    cfbe:	49 f7 e1             	mul    %r9
    cfc1:	49 39 d3             	cmp    %rdx,%r11
    cfc4:	0f 82 be 00 00 00    	jb     d088 <__divti3+0x198>
    cfca:	44 89 d1             	mov    %r10d,%ecx
    cfcd:	49 d3 e0             	shl    %cl,%r8
    cfd0:	49 39 c0             	cmp    %rax,%r8
    cfd3:	73 09                	jae    cfde <__divti3+0xee>
    cfd5:	49 39 d3             	cmp    %rdx,%r11
    cfd8:	0f 84 aa 00 00 00    	je     d088 <__divti3+0x198>
    cfde:	48 89 f0             	mov    %rsi,%rax
    cfe1:	31 f6                	xor    %esi,%esi
    cfe3:	e9 5b ff ff ff       	jmp    cf43 <__divti3+0x53>
    cfe8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    cfef:	00 
    cff0:	4d 85 f6             	test   %r14,%r14
    cff3:	75 0d                	jne    d002 <__divti3+0x112>
    cff5:	b8 01 00 00 00       	mov    $0x1,%eax
    cffa:	31 d2                	xor    %edx,%edx
    cffc:	49 f7 f6             	div    %r14
    cfff:	49 89 c6             	mov    %rax,%r14
    d002:	48 89 f0             	mov    %rsi,%rax
    d005:	31 d2                	xor    %edx,%edx
    d007:	49 f7 f6             	div    %r14
    d00a:	48 89 c6             	mov    %rax,%rsi
    d00d:	4c 89 c0             	mov    %r8,%rax
    d010:	49 f7 f6             	div    %r14
    d013:	e9 2b ff ff ff       	jmp    cf43 <__divti3+0x53>
    d018:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    d01f:	00 
    d020:	49 f7 da             	neg    %r10
    d023:	48 f7 d7             	not    %rdi
    d026:	49 83 d3 00          	adc    $0x0,%r11
    d02a:	4d 89 d6             	mov    %r10,%r14
    d02d:	49 f7 db             	neg    %r11
    d030:	4c 89 da             	mov    %r11,%rdx
    d033:	0f 84 f6 fe ff ff    	je     cf2f <__divti3+0x3f>
    d039:	4c 39 de             	cmp    %r11,%rsi
    d03c:	73 12                	jae    d050 <__divti3+0x160>
    d03e:	31 f6                	xor    %esi,%esi
    d040:	31 c0                	xor    %eax,%eax
    d042:	e9 fc fe ff ff       	jmp    cf43 <__divti3+0x53>
    d047:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    d04e:	00 00 
    d050:	49 0f bd c3          	bsr    %r11,%rax
    d054:	48 83 f0 3f          	xor    $0x3f,%rax
    d058:	41 89 c2             	mov    %eax,%r10d
    d05b:	85 c0                	test   %eax,%eax
    d05d:	0f 85 0e ff ff ff    	jne    cf71 <__divti3+0x81>
    d063:	49 39 f3             	cmp    %rsi,%r11
    d066:	72 0d                	jb     d075 <__divti3+0x185>
    d068:	31 f6                	xor    %esi,%esi
    d06a:	31 c0                	xor    %eax,%eax
    d06c:	4d 39 f0             	cmp    %r14,%r8
    d06f:	0f 82 ce fe ff ff    	jb     cf43 <__divti3+0x53>
    d075:	31 f6                	xor    %esi,%esi
    d077:	b8 01 00 00 00       	mov    $0x1,%eax
    d07c:	e9 c2 fe ff ff       	jmp    cf43 <__divti3+0x53>
    d081:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    d088:	48 8d 46 ff          	lea    -0x1(%rsi),%rax
    d08c:	31 f6                	xor    %esi,%esi
    d08e:	e9 b0 fe ff ff       	jmp    cf43 <__divti3+0x53>
    d093:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    d09a:	00 00 00 
    d09d:	0f 1f 00             	nopl   (%rax)

000000000000d0a0 <atexit>:
    d0a0:	f3 0f 1e fa          	endbr64
    d0a4:	48 8b 15 d5 71 00 00 	mov    0x71d5(%rip),%rdx        # 14280 <__dso_handle>
    d0ab:	31 f6                	xor    %esi,%esi
    d0ad:	e9 8e 53 ff ff       	jmp    2440 <__cxa_atexit@plt>

Disassembly of section .fini:

000000000000d0b4 <_fini>:
    d0b4:	f3 0f 1e fa          	endbr64
    d0b8:	48 83 ec 08          	sub    $0x8,%rsp
    d0bc:	48 83 c4 08          	add    $0x8,%rsp
    d0c0:	c3                   	ret
