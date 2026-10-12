
/home/runner/work/_temp/numeric-layout-baseline/bits32-diagnostic:     file format elf64-x86-64


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

00000000000020d0 <puts@plt>:
    20d0:	ff 25 7a 1f 01 00    	jmp    *0x11f7a(%rip)        # 14050 <puts@GLIBC_2.2.5>
    20d6:	68 0a 00 00 00       	push   $0xa
    20db:	e9 40 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020e0 <sigaction@plt>:
    20e0:	ff 25 72 1f 01 00    	jmp    *0x11f72(%rip)        # 14058 <sigaction@GLIBC_2.2.5>
    20e6:	68 0b 00 00 00       	push   $0xb
    20eb:	e9 30 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020f0 <fread@plt>:
    20f0:	ff 25 6a 1f 01 00    	jmp    *0x11f6a(%rip)        # 14060 <fread@GLIBC_2.2.5>
    20f6:	68 0c 00 00 00       	push   $0xc
    20fb:	e9 20 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002100 <strtod@plt>:
    2100:	ff 25 62 1f 01 00    	jmp    *0x11f62(%rip)        # 14068 <strtod@GLIBC_2.2.5>
    2106:	68 0d 00 00 00       	push   $0xd
    210b:	e9 10 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002110 <vsnprintf@plt>:
    2110:	ff 25 5a 1f 01 00    	jmp    *0x11f5a(%rip)        # 14070 <vsnprintf@GLIBC_2.2.5>
    2116:	68 0e 00 00 00       	push   $0xe
    211b:	e9 00 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002120 <fcntl@plt>:
    2120:	ff 25 52 1f 01 00    	jmp    *0x11f52(%rip)        # 14078 <fcntl@GLIBC_2.2.5>
    2126:	68 0f 00 00 00       	push   $0xf
    212b:	e9 f0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002130 <clock_gettime@plt>:
    2130:	ff 25 4a 1f 01 00    	jmp    *0x11f4a(%rip)        # 14080 <clock_gettime@GLIBC_2.17>
    2136:	68 10 00 00 00       	push   $0x10
    213b:	e9 e0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002140 <write@plt>:
    2140:	ff 25 42 1f 01 00    	jmp    *0x11f42(%rip)        # 14088 <write@GLIBC_2.2.5>
    2146:	68 11 00 00 00       	push   $0x11
    214b:	e9 d0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002150 <fclose@plt>:
    2150:	ff 25 3a 1f 01 00    	jmp    *0x11f3a(%rip)        # 14090 <fclose@GLIBC_2.2.5>
    2156:	68 12 00 00 00       	push   $0x12
    215b:	e9 c0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002160 <shutdown@plt>:
    2160:	ff 25 32 1f 01 00    	jmp    *0x11f32(%rip)        # 14098 <shutdown@GLIBC_2.2.5>
    2166:	68 13 00 00 00       	push   $0x13
    216b:	e9 b0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002170 <strlen@plt>:
    2170:	ff 25 2a 1f 01 00    	jmp    *0x11f2a(%rip)        # 140a0 <strlen@GLIBC_2.2.5>
    2176:	68 14 00 00 00       	push   $0x14
    217b:	e9 a0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002180 <getuid@plt>:
    2180:	ff 25 22 1f 01 00    	jmp    *0x11f22(%rip)        # 140a8 <getuid@GLIBC_2.2.5>
    2186:	68 15 00 00 00       	push   $0x15
    218b:	e9 90 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002190 <mmap@plt>:
    2190:	ff 25 1a 1f 01 00    	jmp    *0x11f1a(%rip)        # 140b0 <mmap@GLIBC_2.2.5>
    2196:	68 16 00 00 00       	push   $0x16
    219b:	e9 80 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021a0 <send@plt>:
    21a0:	ff 25 12 1f 01 00    	jmp    *0x11f12(%rip)        # 140b8 <send@GLIBC_2.2.5>
    21a6:	68 17 00 00 00       	push   $0x17
    21ab:	e9 70 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021b0 <strchr@plt>:
    21b0:	ff 25 0a 1f 01 00    	jmp    *0x11f0a(%rip)        # 140c0 <strchr@GLIBC_2.2.5>
    21b6:	68 18 00 00 00       	push   $0x18
    21bb:	e9 60 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021c0 <printf@plt>:
    21c0:	ff 25 02 1f 01 00    	jmp    *0x11f02(%rip)        # 140c8 <printf@GLIBC_2.2.5>
    21c6:	68 19 00 00 00       	push   $0x19
    21cb:	e9 50 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021d0 <snprintf@plt>:
    21d0:	ff 25 fa 1e 01 00    	jmp    *0x11efa(%rip)        # 140d0 <snprintf@GLIBC_2.2.5>
    21d6:	68 1a 00 00 00       	push   $0x1a
    21db:	e9 40 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021e0 <ftruncate@plt>:
    21e0:	ff 25 f2 1e 01 00    	jmp    *0x11ef2(%rip)        # 140d8 <ftruncate@GLIBC_2.2.5>
    21e6:	68 1b 00 00 00       	push   $0x1b
    21eb:	e9 30 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021f0 <fputs@plt>:
    21f0:	ff 25 ea 1e 01 00    	jmp    *0x11eea(%rip)        # 140e0 <fputs@GLIBC_2.2.5>
    21f6:	68 1c 00 00 00       	push   $0x1c
    21fb:	e9 20 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002200 <strtof@plt>:
    2200:	ff 25 e2 1e 01 00    	jmp    *0x11ee2(%rip)        # 140e8 <strtof@GLIBC_2.2.5>
    2206:	68 1d 00 00 00       	push   $0x1d
    220b:	e9 10 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002210 <memset@plt>:
    2210:	ff 25 da 1e 01 00    	jmp    *0x11eda(%rip)        # 140f0 <memset@GLIBC_2.2.5>
    2216:	68 1e 00 00 00       	push   $0x1e
    221b:	e9 00 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002220 <fgetc@plt>:
    2220:	ff 25 d2 1e 01 00    	jmp    *0x11ed2(%rip)        # 140f8 <fgetc@GLIBC_2.2.5>
    2226:	68 1f 00 00 00       	push   $0x1f
    222b:	e9 f0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002230 <close@plt>:
    2230:	ff 25 ca 1e 01 00    	jmp    *0x11eca(%rip)        # 14100 <close@GLIBC_2.2.5>
    2236:	68 20 00 00 00       	push   $0x20
    223b:	e9 e0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002240 <fputc@plt>:
    2240:	ff 25 c2 1e 01 00    	jmp    *0x11ec2(%rip)        # 14108 <fputc@GLIBC_2.2.5>
    2246:	68 21 00 00 00       	push   $0x21
    224b:	e9 d0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002250 <sched_yield@plt>:
    2250:	ff 25 ba 1e 01 00    	jmp    *0x11eba(%rip)        # 14110 <sched_yield@GLIBC_2.2.5>
    2256:	68 22 00 00 00       	push   $0x22
    225b:	e9 c0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002260 <memchr@plt>:
    2260:	ff 25 b2 1e 01 00    	jmp    *0x11eb2(%rip)        # 14118 <memchr@GLIBC_2.2.5>
    2266:	68 23 00 00 00       	push   $0x23
    226b:	e9 b0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002270 <memcmp@plt>:
    2270:	ff 25 aa 1e 01 00    	jmp    *0x11eaa(%rip)        # 14120 <memcmp@GLIBC_2.2.5>
    2276:	68 24 00 00 00       	push   $0x24
    227b:	e9 a0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002280 <pthread_attr_init@plt>:
    2280:	ff 25 a2 1e 01 00    	jmp    *0x11ea2(%rip)        # 14128 <pthread_attr_init@GLIBC_2.2.5>
    2286:	68 25 00 00 00       	push   $0x25
    228b:	e9 90 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002290 <fgets@plt>:
    2290:	ff 25 9a 1e 01 00    	jmp    *0x11e9a(%rip)        # 14130 <fgets@GLIBC_2.2.5>
    2296:	68 26 00 00 00       	push   $0x26
    229b:	e9 80 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022a0 <getsockopt@plt>:
    22a0:	ff 25 92 1e 01 00    	jmp    *0x11e92(%rip)        # 14138 <getsockopt@GLIBC_2.2.5>
    22a6:	68 27 00 00 00       	push   $0x27
    22ab:	e9 70 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022b0 <_setjmp@plt>:
    22b0:	ff 25 8a 1e 01 00    	jmp    *0x11e8a(%rip)        # 14140 <_setjmp@GLIBC_2.2.5>
    22b6:	68 28 00 00 00       	push   $0x28
    22bb:	e9 60 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022c0 <strtoull@plt>:
    22c0:	ff 25 82 1e 01 00    	jmp    *0x11e82(%rip)        # 14148 <strtoull@GLIBC_2.2.5>
    22c6:	68 29 00 00 00       	push   $0x29
    22cb:	e9 50 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022d0 <strcmp@plt>:
    22d0:	ff 25 7a 1e 01 00    	jmp    *0x11e7a(%rip)        # 14150 <strcmp@GLIBC_2.2.5>
    22d6:	68 2a 00 00 00       	push   $0x2a
    22db:	e9 40 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022e0 <signal@plt>:
    22e0:	ff 25 72 1e 01 00    	jmp    *0x11e72(%rip)        # 14158 <signal@GLIBC_2.2.5>
    22e6:	68 2b 00 00 00       	push   $0x2b
    22eb:	e9 30 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022f0 <fprintf@plt>:
    22f0:	ff 25 6a 1e 01 00    	jmp    *0x11e6a(%rip)        # 14160 <fprintf@GLIBC_2.2.5>
    22f6:	68 2c 00 00 00       	push   $0x2c
    22fb:	e9 20 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002300 <syscall@plt>:
    2300:	ff 25 62 1e 01 00    	jmp    *0x11e62(%rip)        # 14168 <syscall@GLIBC_2.2.5>
    2306:	68 2d 00 00 00       	push   $0x2d
    230b:	e9 10 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002310 <sigemptyset@plt>:
    2310:	ff 25 5a 1e 01 00    	jmp    *0x11e5a(%rip)        # 14170 <sigemptyset@GLIBC_2.2.5>
    2316:	68 2e 00 00 00       	push   $0x2e
    231b:	e9 00 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002320 <strtol@plt>:
    2320:	ff 25 52 1e 01 00    	jmp    *0x11e52(%rip)        # 14178 <strtol@GLIBC_2.2.5>
    2326:	68 2f 00 00 00       	push   $0x2f
    232b:	e9 f0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002330 <memcpy@plt>:
    2330:	ff 25 4a 1e 01 00    	jmp    *0x11e4a(%rip)        # 14180 <memcpy@GLIBC_2.14>
    2336:	68 30 00 00 00       	push   $0x30
    233b:	e9 e0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002340 <malloc@plt>:
    2340:	ff 25 42 1e 01 00    	jmp    *0x11e42(%rip)        # 14188 <malloc@GLIBC_2.2.5>
    2346:	68 31 00 00 00       	push   $0x31
    234b:	e9 d0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002350 <fflush@plt>:
    2350:	ff 25 3a 1e 01 00    	jmp    *0x11e3a(%rip)        # 14190 <fflush@GLIBC_2.2.5>
    2356:	68 32 00 00 00       	push   $0x32
    235b:	e9 c0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002360 <listen@plt>:
    2360:	ff 25 32 1e 01 00    	jmp    *0x11e32(%rip)        # 14198 <listen@GLIBC_2.2.5>
    2366:	68 33 00 00 00       	push   $0x33
    236b:	e9 b0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002370 <bcmp@plt>:
    2370:	ff 25 2a 1e 01 00    	jmp    *0x11e2a(%rip)        # 141a0 <bcmp@GLIBC_2.2.5>
    2376:	68 34 00 00 00       	push   $0x34
    237b:	e9 a0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002380 <realloc@plt>:
    2380:	ff 25 22 1e 01 00    	jmp    *0x11e22(%rip)        # 141a8 <realloc@GLIBC_2.2.5>
    2386:	68 35 00 00 00       	push   $0x35
    238b:	e9 90 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002390 <munmap@plt>:
    2390:	ff 25 1a 1e 01 00    	jmp    *0x11e1a(%rip)        # 141b0 <munmap@GLIBC_2.2.5>
    2396:	68 36 00 00 00       	push   $0x36
    239b:	e9 80 fc ff ff       	jmp    2020 <_init+0x20>

00000000000023a0 <recvmsg@plt>:
    23a0:	ff 25 12 1e 01 00    	jmp    *0x11e12(%rip)        # 141b8 <recvmsg@GLIBC_2.2.5>
    23a6:	68 37 00 00 00       	push   $0x37
    23ab:	e9 70 fc ff ff       	jmp    2020 <_init+0x20>

00000000000023b0 <setvbuf@plt>:
    23b0:	ff 25 0a 1e 01 00    	jmp    *0x11e0a(%rip)        # 141c0 <setvbuf@GLIBC_2.2.5>
    23b6:	68 38 00 00 00       	push   $0x38
    23bb:	e9 60 fc ff ff       	jmp    2020 <_init+0x20>

00000000000023c0 <poll@plt>:
    23c0:	ff 25 02 1e 01 00    	jmp    *0x11e02(%rip)        # 141c8 <poll@GLIBC_2.2.5>
    23c6:	68 39 00 00 00       	push   $0x39
    23cb:	e9 50 fc ff ff       	jmp    2020 <_init+0x20>

00000000000023d0 <bind@plt>:
    23d0:	ff 25 fa 1d 01 00    	jmp    *0x11dfa(%rip)        # 141d0 <bind@GLIBC_2.2.5>
    23d6:	68 3a 00 00 00       	push   $0x3a
    23db:	e9 40 fc ff ff       	jmp    2020 <_init+0x20>

00000000000023e0 <pthread_create@plt>:
    23e0:	ff 25 f2 1d 01 00    	jmp    *0x11df2(%rip)        # 141d8 <pthread_create@GLIBC_2.34>
    23e6:	68 3b 00 00 00       	push   $0x3b
    23eb:	e9 30 fc ff ff       	jmp    2020 <_init+0x20>

00000000000023f0 <madvise@plt>:
    23f0:	ff 25 ea 1d 01 00    	jmp    *0x11dea(%rip)        # 141e0 <madvise@GLIBC_2.2.5>
    23f6:	68 3c 00 00 00       	push   $0x3c
    23fb:	e9 20 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002400 <atol@plt>:
    2400:	ff 25 e2 1d 01 00    	jmp    *0x11de2(%rip)        # 141e8 <atol@GLIBC_2.2.5>
    2406:	68 3d 00 00 00       	push   $0x3d
    240b:	e9 10 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002410 <mprotect@plt>:
    2410:	ff 25 da 1d 01 00    	jmp    *0x11dda(%rip)        # 141f0 <mprotect@GLIBC_2.2.5>
    2416:	68 3e 00 00 00       	push   $0x3e
    241b:	e9 00 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002420 <fopen@plt>:
    2420:	ff 25 d2 1d 01 00    	jmp    *0x11dd2(%rip)        # 141f8 <fopen@GLIBC_2.2.5>
    2426:	68 3f 00 00 00       	push   $0x3f
    242b:	e9 f0 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002430 <sysconf@plt>:
    2430:	ff 25 ca 1d 01 00    	jmp    *0x11dca(%rip)        # 14200 <sysconf@GLIBC_2.2.5>
    2436:	68 40 00 00 00       	push   $0x40
    243b:	e9 e0 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002440 <accept@plt>:
    2440:	ff 25 c2 1d 01 00    	jmp    *0x11dc2(%rip)        # 14208 <accept@GLIBC_2.2.5>
    2446:	68 41 00 00 00       	push   $0x41
    244b:	e9 d0 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002450 <__cxa_atexit@plt>:
    2450:	ff 25 ba 1d 01 00    	jmp    *0x11dba(%rip)        # 14210 <__cxa_atexit@GLIBC_2.2.5>
    2456:	68 42 00 00 00       	push   $0x42
    245b:	e9 c0 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002460 <atoi@plt>:
    2460:	ff 25 b2 1d 01 00    	jmp    *0x11db2(%rip)        # 14218 <atoi@GLIBC_2.2.5>
    2466:	68 43 00 00 00       	push   $0x43
    246b:	e9 b0 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002470 <sprintf@plt>:
    2470:	ff 25 aa 1d 01 00    	jmp    *0x11daa(%rip)        # 14220 <sprintf@GLIBC_2.2.5>
    2476:	68 44 00 00 00       	push   $0x44
    247b:	e9 a0 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002480 <exit@plt>:
    2480:	ff 25 a2 1d 01 00    	jmp    *0x11da2(%rip)        # 14228 <exit@GLIBC_2.2.5>
    2486:	68 45 00 00 00       	push   $0x45
    248b:	e9 90 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002490 <connect@plt>:
    2490:	ff 25 9a 1d 01 00    	jmp    *0x11d9a(%rip)        # 14230 <connect@GLIBC_2.2.5>
    2496:	68 46 00 00 00       	push   $0x46
    249b:	e9 80 fb ff ff       	jmp    2020 <_init+0x20>

00000000000024a0 <fwrite@plt>:
    24a0:	ff 25 92 1d 01 00    	jmp    *0x11d92(%rip)        # 14238 <fwrite@GLIBC_2.2.5>
    24a6:	68 47 00 00 00       	push   $0x47
    24ab:	e9 70 fb ff ff       	jmp    2020 <_init+0x20>

00000000000024b0 <getrlimit@plt>:
    24b0:	ff 25 8a 1d 01 00    	jmp    *0x11d8a(%rip)        # 14240 <getrlimit@GLIBC_2.2.5>
    24b6:	68 48 00 00 00       	push   $0x48
    24bb:	e9 60 fb ff ff       	jmp    2020 <_init+0x20>

00000000000024c0 <pthread_join@plt>:
    24c0:	ff 25 82 1d 01 00    	jmp    *0x11d82(%rip)        # 14248 <pthread_join@GLIBC_2.34>
    24c6:	68 49 00 00 00       	push   $0x49
    24cb:	e9 50 fb ff ff       	jmp    2020 <_init+0x20>

00000000000024d0 <sigaltstack@plt>:
    24d0:	ff 25 7a 1d 01 00    	jmp    *0x11d7a(%rip)        # 14250 <sigaltstack@GLIBC_2.2.5>
    24d6:	68 4a 00 00 00       	push   $0x4a
    24db:	e9 40 fb ff ff       	jmp    2020 <_init+0x20>

00000000000024e0 <fstat@plt>:
    24e0:	ff 25 72 1d 01 00    	jmp    *0x11d72(%rip)        # 14258 <fstat@GLIBC_2.33>
    24e6:	68 4b 00 00 00       	push   $0x4b
    24eb:	e9 30 fb ff ff       	jmp    2020 <_init+0x20>

00000000000024f0 <strstr@plt>:
    24f0:	ff 25 6a 1d 01 00    	jmp    *0x11d6a(%rip)        # 14260 <strstr@GLIBC_2.2.5>
    24f6:	68 4c 00 00 00       	push   $0x4c
    24fb:	e9 20 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002500 <__ctype_b_loc@plt>:
    2500:	ff 25 62 1d 01 00    	jmp    *0x11d62(%rip)        # 14268 <__ctype_b_loc@GLIBC_2.3>
    2506:	68 4d 00 00 00       	push   $0x4d
    250b:	e9 10 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002510 <socket@plt>:
    2510:	ff 25 5a 1d 01 00    	jmp    *0x11d5a(%rip)        # 14270 <socket@GLIBC_2.2.5>
    2516:	68 4e 00 00 00       	push   $0x4e
    251b:	e9 00 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002520 <pthread_attr_setstacksize@plt>:
    2520:	ff 25 52 1d 01 00    	jmp    *0x11d52(%rip)        # 14278 <pthread_attr_setstacksize@GLIBC_2.34>
    2526:	68 4f 00 00 00       	push   $0x4f
    252b:	e9 f0 fa ff ff       	jmp    2020 <_init+0x20>

Disassembly of section .plt.got:

0000000000002530 <__cxa_finalize@plt>:
    2530:	ff 25 a2 1a 01 00    	jmp    *0x11aa2(%rip)        # 13fd8 <__cxa_finalize@GLIBC_2.2.5>
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
    255f:	ff 15 43 1a 01 00    	call   *0x11a43(%rip)        # 13fa8 <__libc_start_main@GLIBC_2.34>
    2565:	f4                   	hlt
    2566:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    256d:	00 00 00 

0000000000002570 <deregister_tm_clones>:
    2570:	48 8d 3d 19 38 01 00 	lea    0x13819(%rip),%rdi        # 15d90 <__TMC_END__>
    2577:	48 8d 05 12 38 01 00 	lea    0x13812(%rip),%rax        # 15d90 <__TMC_END__>
    257e:	48 39 f8             	cmp    %rdi,%rax
    2581:	74 15                	je     2598 <deregister_tm_clones+0x28>
    2583:	48 8b 05 26 1a 01 00 	mov    0x11a26(%rip),%rax        # 13fb0 <_ITM_deregisterTMCloneTable@Base>
    258a:	48 85 c0             	test   %rax,%rax
    258d:	74 09                	je     2598 <deregister_tm_clones+0x28>
    258f:	ff e0                	jmp    *%rax
    2591:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    2598:	c3                   	ret
    2599:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000025a0 <register_tm_clones>:
    25a0:	48 8d 3d e9 37 01 00 	lea    0x137e9(%rip),%rdi        # 15d90 <__TMC_END__>
    25a7:	48 8d 35 e2 37 01 00 	lea    0x137e2(%rip),%rsi        # 15d90 <__TMC_END__>
    25ae:	48 29 fe             	sub    %rdi,%rsi
    25b1:	48 89 f0             	mov    %rsi,%rax
    25b4:	48 c1 ee 3f          	shr    $0x3f,%rsi
    25b8:	48 c1 f8 03          	sar    $0x3,%rax
    25bc:	48 01 c6             	add    %rax,%rsi
    25bf:	48 d1 fe             	sar    $1,%rsi
    25c2:	74 14                	je     25d8 <register_tm_clones+0x38>
    25c4:	48 8b 05 05 1a 01 00 	mov    0x11a05(%rip),%rax        # 13fd0 <_ITM_registerTMCloneTable@Base>
    25cb:	48 85 c0             	test   %rax,%rax
    25ce:	74 08                	je     25d8 <register_tm_clones+0x38>
    25d0:	ff e0                	jmp    *%rax
    25d2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    25d8:	c3                   	ret
    25d9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000025e0 <__do_global_dtors_aux>:
    25e0:	f3 0f 1e fa          	endbr64
    25e4:	80 3d a5 37 01 00 00 	cmpb   $0x0,0x137a5(%rip)        # 15d90 <__TMC_END__>
    25eb:	75 2b                	jne    2618 <__do_global_dtors_aux+0x38>
    25ed:	55                   	push   %rbp
    25ee:	48 83 3d e2 19 01 00 	cmpq   $0x0,0x119e2(%rip)        # 13fd8 <__cxa_finalize@GLIBC_2.2.5>
    25f5:	00 
    25f6:	48 89 e5             	mov    %rsp,%rbp
    25f9:	74 0c                	je     2607 <__do_global_dtors_aux+0x27>
    25fb:	48 8b 3d 86 1c 01 00 	mov    0x11c86(%rip),%rdi        # 14288 <__dso_handle>
    2602:	e8 29 ff ff ff       	call   2530 <__cxa_finalize@plt>
    2607:	e8 64 ff ff ff       	call   2570 <deregister_tm_clones>
    260c:	c6 05 7d 37 01 00 01 	movb   $0x1,0x1377d(%rip)        # 15d90 <__TMC_END__>
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
    2637:	48 8d 05 52 12 01 00 	lea    0x11252(%rip),%rax        # 13890 <fwp_fn_table>
    263e:	48 89 05 5b 37 01 00 	mov    %rax,0x1375b(%rip)        # 15da0 <fwp_fns>
    2645:	4c 8b 35 6c 19 01 00 	mov    0x1196c(%rip),%r14        # 13fb8 <stdout@GLIBC_2.2.5>
    264c:	49 8b 06             	mov    (%r14),%rax
    264f:	48 89 05 52 37 01 00 	mov    %rax,0x13752(%rip)        # 15da8 <fwp_prog_out>
    2656:	89 3d 54 37 01 00    	mov    %edi,0x13754(%rip)        # 15db0 <fwp_argc>
    265c:	48 89 35 55 37 01 00 	mov    %rsi,0x13755(%rip)        # 15db8 <fwp_argv>
    2663:	48 8d 35 56 37 01 00 	lea    0x13756(%rip),%rsi        # 15dc0 <fwp_start_time>
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
    26a6:	48 8b 35 e3 1b 01 00 	mov    0x11be3(%rip),%rsi        # 14290 <fwp_main_stack>
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
    26f6:	48 89 0d 93 1b 01 00 	mov    %rcx,0x11b93(%rip)        # 14290 <fwp_main_stack>
    26fd:	e8 8e 00 00 00       	call   2790 <fwp_main_thread>
    2702:	eb 0c                	jmp    2710 <original_main+0xe0>
    2704:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    2709:	31 f6                	xor    %esi,%esi
    270b:	e8 b0 fd ff ff       	call   24c0 <pthread_join@plt>
    2710:	49 8b 3e             	mov    (%r14),%rdi
    2713:	e8 38 fc ff ff       	call   2350 <fflush@plt>
    2718:	8b 05 b2 36 01 00    	mov    0x136b2(%rip),%eax        # 15dd0 <fwp_exit_code>
    271e:	48 83 c4 58          	add    $0x58,%rsp
    2722:	5b                   	pop    %rbx
    2723:	41 5e                	pop    %r14
    2725:	c3                   	ret
    2726:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    272d:	00 00 00 

0000000000002730 <fwp_seed_rng>:
    2730:	53                   	push   %rbx
    2731:	48 83 ec 20          	sub    $0x20,%rsp
    2735:	48 8d 3d 1e c1 00 00 	lea    0xc11e(%rip),%rdi        # e85a <exec_in_fp0+0x20a>
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
    2797:	e8 e4 01 00 00       	call   2980 <fwp_gc_start>
    279c:	48 8b 3d ed 1a 01 00 	mov    0x11aed(%rip),%rdi        # 14290 <fwp_main_stack>
    27a3:	e8 b8 34 00 00       	call   5c60 <fwp_stack_guard_init>
    27a8:	48 8b 05 b1 14 01 00 	mov    0x114b1(%rip),%rax        # 13c60 <exec_scripts+0x10>
    27af:	48 89 05 3a 36 01 00 	mov    %rax,0x1363a(%rip)        # 15df0 <fwp_cli_scripts+0x10>
    27b6:	0f 28 05 93 14 01 00 	movaps 0x11493(%rip),%xmm0        # 13c50 <exec_scripts>
    27bd:	0f 29 05 1c 36 01 00 	movaps %xmm0,0x1361c(%rip)        # 15de0 <fwp_cli_scripts>
    27c4:	48 8d 05 d5 bc 00 00 	lea    0xbcd5(%rip),%rax        # e4a0 <exec_man>
    27cb:	48 89 05 26 36 01 00 	mov    %rax,0x13626(%rip)        # 15df8 <fwp_cli_man>
    27d2:	c6 05 27 36 01 00 01 	movb   $0x1,0x13627(%rip)        # 15e00 <fwp_cli_single>
    27d9:	8b 3d d1 35 01 00    	mov    0x135d1(%rip),%edi        # 15db0 <fwp_argc>
    27df:	48 8b 35 d2 35 01 00 	mov    0x135d2(%rip),%rsi        # 15db8 <fwp_argv>
    27e6:	e8 55 35 00 00       	call   5d40 <fwp_exec>
    27eb:	89 05 df 35 01 00    	mov    %eax,0x135df(%rip)        # 15dd0 <fwp_exit_code>
    27f1:	48 8b 05 c0 17 01 00 	mov    0x117c0(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
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
    2814:	41 56                	push   %r14
    2816:	53                   	push   %rbx
    2817:	48 89 ef             	mov    %rbp,%rdi
    281a:	e8 61 01 00 00       	call   2980 <fwp_gc_start>
    281f:	48 8d 05 6a 10 01 00 	lea    0x1106a(%rip),%rax        # 13890 <fwp_fn_table>
    2826:	48 89 05 73 35 01 00 	mov    %rax,0x13573(%rip)        # 15da0 <fwp_fns>
    282d:	31 ff                	xor    %edi,%edi
    282f:	e8 fc 01 00 00       	call   2a30 <f1>
    2834:	48 89 c3             	mov    %rax,%rbx
    2837:	b8 82 00 00 00       	mov    $0x82,%eax
    283c:	48 83 7b 08 00       	cmpq   $0x0,0x8(%rbx)
    2841:	75 0e                	jne    2851 <main+0x41>
    2843:	48 83 7b 10 00       	cmpq   $0x0,0x10(%rbx)
    2848:	75 07                	jne    2851 <main+0x41>
    284a:	48 83 7b 18 00       	cmpq   $0x0,0x18(%rbx)
    284f:	74 05                	je     2856 <main+0x46>
    2851:	5b                   	pop    %rbx
    2852:	41 5e                	pop    %r14
    2854:	5d                   	pop    %rbp
    2855:	c3                   	ret
    2856:	48 89 df             	mov    %rbx,%rdi
    2859:	e8 42 02 00 00       	call   2aa0 <fwp_rc_release_last>
    285e:	85 c0                	test   %eax,%eax
    2860:	0f 84 04 01 00 00    	je     296a <main+0x15a>
    2866:	41 be 00 00 00 80    	mov    $0x80000000,%r14d
    286c:	48 89 df             	mov    %rbx,%rdi
    286f:	e8 5c 02 00 00       	call   2ad0 <fwp_rc_free_obj>
    2874:	bf 00 00 00 80       	mov    $0x80000000,%edi
    2879:	e8 b2 01 00 00       	call   2a30 <f1>
    287e:	4c 39 70 08          	cmp    %r14,0x8(%rax)
    2882:	0f 85 ec 00 00 00    	jne    2974 <main+0x164>
    2888:	48 89 c3             	mov    %rax,%rbx
    288b:	4c 39 70 10          	cmp    %r14,0x10(%rax)
    288f:	b8 82 00 00 00       	mov    $0x82,%eax
    2894:	75 bb                	jne    2851 <main+0x41>
    2896:	4c 39 73 18          	cmp    %r14,0x18(%rbx)
    289a:	75 b5                	jne    2851 <main+0x41>
    289c:	48 89 df             	mov    %rbx,%rdi
    289f:	e8 fc 01 00 00       	call   2aa0 <fwp_rc_release_last>
    28a4:	85 c0                	test   %eax,%eax
    28a6:	0f 84 be 00 00 00    	je     296a <main+0x15a>
    28ac:	48 89 df             	mov    %rbx,%rdi
    28af:	e8 1c 02 00 00       	call   2ad0 <fwp_rc_free_obj>
    28b4:	bf 34 12 c0 7f       	mov    $0x7fc01234,%edi
    28b9:	e8 72 01 00 00       	call   2a30 <f1>
    28be:	48 81 78 08 34 12 c0 	cmpq   $0x7fc01234,0x8(%rax)
    28c5:	7f 
    28c6:	0f 85 a8 00 00 00    	jne    2974 <main+0x164>
    28cc:	48 89 c3             	mov    %rax,%rbx
    28cf:	48 81 78 10 34 12 c0 	cmpq   $0x7fc01234,0x10(%rax)
    28d6:	7f 
    28d7:	b8 82 00 00 00       	mov    $0x82,%eax
    28dc:	0f 85 6f ff ff ff    	jne    2851 <main+0x41>
    28e2:	48 81 7b 18 34 12 c0 	cmpq   $0x7fc01234,0x18(%rbx)
    28e9:	7f 
    28ea:	0f 85 61 ff ff ff    	jne    2851 <main+0x41>
    28f0:	48 89 df             	mov    %rbx,%rdi
    28f3:	e8 a8 01 00 00       	call   2aa0 <fwp_rc_release_last>
    28f8:	85 c0                	test   %eax,%eax
    28fa:	74 6e                	je     296a <main+0x15a>
    28fc:	48 89 df             	mov    %rbx,%rdi
    28ff:	e8 cc 01 00 00       	call   2ad0 <fwp_rc_free_obj>
    2904:	bf 34 12 80 7f       	mov    $0x7f801234,%edi
    2909:	e8 22 01 00 00       	call   2a30 <f1>
    290e:	48 81 78 08 34 12 80 	cmpq   $0x7f801234,0x8(%rax)
    2915:	7f 
    2916:	75 5c                	jne    2974 <main+0x164>
    2918:	48 81 78 10 34 12 80 	cmpq   $0x7f801234,0x10(%rax)
    291f:	7f 
    2920:	75 52                	jne    2974 <main+0x164>
    2922:	48 89 c3             	mov    %rax,%rbx
    2925:	48 81 78 18 34 12 80 	cmpq   $0x7f801234,0x18(%rax)
    292c:	7f 
    292d:	b8 82 00 00 00       	mov    $0x82,%eax
    2932:	0f 85 19 ff ff ff    	jne    2851 <main+0x41>
    2938:	48 89 df             	mov    %rbx,%rdi
    293b:	e8 60 01 00 00       	call   2aa0 <fwp_rc_release_last>
    2940:	89 c1                	mov    %eax,%ecx
    2942:	b8 83 00 00 00       	mov    $0x83,%eax
    2947:	85 c9                	test   %ecx,%ecx
    2949:	0f 84 02 ff ff ff    	je     2851 <main+0x41>
    294f:	48 89 df             	mov    %rbx,%rdi
    2952:	e8 79 01 00 00       	call   2ad0 <fwp_rc_free_obj>
    2957:	48 8d 3d 02 bd 00 00 	lea    0xbd02(%rip),%rdi        # e660 <exec_in_fp0+0x10>
    295e:	e8 6d f7 ff ff       	call   20d0 <puts@plt>
    2963:	31 c0                	xor    %eax,%eax
    2965:	e9 e7 fe ff ff       	jmp    2851 <main+0x41>
    296a:	b8 83 00 00 00       	mov    $0x83,%eax
    296f:	e9 dd fe ff ff       	jmp    2851 <main+0x41>
    2974:	b8 82 00 00 00       	mov    $0x82,%eax
    2979:	e9 d3 fe ff ff       	jmp    2851 <main+0x41>
    297e:	66 90                	xchg   %ax,%ax

0000000000002980 <fwp_gc_start>:
    2980:	53                   	push   %rbx
    2981:	48 89 fb             	mov    %rdi,%rbx
    2984:	83 3d f9 28 01 00 00 	cmpl   $0x0,0x128f9(%rip)        # 15284 <fwp_gc+0xfec>
    298b:	75 05                	jne    2992 <fwp_gc_start+0x12>
    298d:	e8 fe 0a 00 00       	call   3490 <fwp_gc_init>
    2992:	48 89 1d 87 29 01 00 	mov    %rbx,0x12987(%rip)        # 15320 <fwp_gc+0x1088>
    2999:	48 8d 3d b0 a1 00 00 	lea    0xa1b0(%rip),%rdi        # cb50 <fwp_gc_find_data>
    29a0:	31 f6                	xor    %esi,%esi
    29a2:	e8 99 f6 ff ff       	call   2040 <dl_iterate_phdr@plt>
    29a7:	83 3d da 28 01 00 00 	cmpl   $0x0,0x128da(%rip)        # 15288 <fwp_gc+0xff0>
    29ae:	0f 95 c1             	setne  %cl
    29b1:	83 3d 70 2a 01 00 00 	cmpl   $0x0,0x12a70(%rip)        # 15428 <fwp_gc+0x1190>
    29b8:	0f 9f c0             	setg   %al
    29bb:	20 c8                	and    %cl,%al
    29bd:	0f b6 c8             	movzbl %al,%ecx
    29c0:	89 0d c6 28 01 00    	mov    %ecx,0x128c6(%rip)        # 1528c <fwp_gc+0xff4>
    29c6:	83 3d c7 28 01 00 00 	cmpl   $0x0,0x128c7(%rip)        # 15294 <fwp_gc+0xffc>
    29cd:	74 16                	je     29e5 <fwp_gc_start+0x65>
    29cf:	48 8d 3d 5a a2 00 00 	lea    0xa25a(%rip),%rdi        # cc30 <fwp_gc_report>
    29d6:	e8 75 a7 00 00       	call   d150 <atexit>
    29db:	83 3d aa 28 01 00 00 	cmpl   $0x0,0x128aa(%rip)        # 1528c <fwp_gc+0xff4>
    29e2:	0f 95 c0             	setne  %al
    29e5:	84 c0                	test   %al,%al
    29e7:	74 43                	je     2a2c <fwp_gc_start+0xac>
    29e9:	48 83 3d c7 28 01 00 	cmpq   $0x0,0x128c7(%rip)        # 152b8 <fwp_gc+0x1020>
    29f0:	00 
    29f1:	74 39                	je     2a2c <fwp_gc_start+0xac>
    29f3:	48 8b 05 ae 2a 01 00 	mov    0x12aae(%rip),%rax        # 154a8 <fwp_gc+0x1210>
    29fa:	48 2b 05 97 18 01 00 	sub    0x11897(%rip),%rax        # 14298 <fwp_gc>
    2a01:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    2a06:	f2 0f 58 05 72 2a 01 	addsd  0x12a72(%rip),%xmm0        # 15480 <fwp_gc+0x11e8>
    2a0d:	00 
    2a0e:	f2 0f 11 05 6a 2a 01 	movsd  %xmm0,0x12a6a(%rip)        # 15480 <fwp_gc+0x11e8>
    2a15:	00 
    2a16:	48 c7 05 87 2a 01 00 	movq   $0x0,0x12a87(%rip)        # 154a8 <fwp_gc+0x1210>
    2a1d:	00 00 00 00 
    2a21:	48 c7 05 6c 18 01 00 	movq   $0x0,0x1186c(%rip)        # 14298 <fwp_gc>
    2a28:	00 00 00 00 
    2a2c:	5b                   	pop    %rbx
    2a2d:	c3                   	ret
    2a2e:	66 90                	xchg   %ax,%ax

0000000000002a30 <f1>:
    2a30:	53                   	push   %rbx
    2a31:	48 83 ec 30          	sub    $0x30,%rsp
    2a35:	e8 f6 76 00 00       	call   a130 <fwp_f32>
    2a3a:	e8 31 a4 00 00       	call   ce70 <w1>
    2a3f:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    2a44:	f3 0f 11 4c 24 04    	movss  %xmm1,0x4(%rsp)
    2a4a:	e8 31 70 00 00       	call   9a80 <fwp_from_f32>
    2a4f:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    2a54:	0f 28 44 24 20       	movaps 0x20(%rsp),%xmm0
    2a59:	0f c6 c0 55          	shufps $0x55,%xmm0,%xmm0
    2a5d:	e8 1e 70 00 00       	call   9a80 <fwp_from_f32>
    2a62:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    2a67:	f3 0f 10 44 24 04    	movss  0x4(%rsp),%xmm0
    2a6d:	e8 0e 70 00 00       	call   9a80 <fwp_from_f32>
    2a72:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    2a77:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    2a7c:	bf 03 00 00 00       	mov    $0x3,%edi
    2a81:	e8 8a 06 00 00       	call   3110 <fwp_record>
    2a86:	48 89 c3             	mov    %rax,%rbx
    2a89:	48 89 c7             	mov    %rax,%rdi
    2a8c:	e8 3f 06 00 00       	call   30d0 <fwp_rc_fresh>
    2a91:	48 89 d8             	mov    %rbx,%rax
    2a94:	48 83 c4 30          	add    $0x30,%rsp
    2a98:	5b                   	pop    %rbx
    2a99:	c3                   	ret
    2a9a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000002aa0 <fwp_rc_release_last>:
    2aa0:	50                   	push   %rax
    2aa1:	e8 4a 04 00 00       	call   2ef0 <fwp_rc_slot>
    2aa6:	48 89 c7             	mov    %rax,%rdi
    2aa9:	31 c0                	xor    %eax,%eax
    2aab:	48 85 ff             	test   %rdi,%rdi
    2aae:	74 1a                	je     2aca <fwp_rc_release_last+0x2a>
    2ab0:	0f b6 07             	movzbl (%rdi),%eax
    2ab3:	85 c0                	test   %eax,%eax
    2ab5:	74 13                	je     2aca <fwp_rc_release_last+0x2a>
    2ab7:	83 f8 01             	cmp    $0x1,%eax
    2aba:	75 07                	jne    2ac3 <fwp_rc_release_last+0x23>
    2abc:	b8 01 00 00 00       	mov    $0x1,%eax
    2ac1:	59                   	pop    %rcx
    2ac2:	c3                   	ret
    2ac3:	e8 c8 a3 00 00       	call   ce90 <fwp_rc_drop_slot>
    2ac8:	31 c0                	xor    %eax,%eax
    2aca:	59                   	pop    %rcx
    2acb:	c3                   	ret
    2acc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000002ad0 <fwp_rc_free_obj>:
    2ad0:	41 56                	push   %r14
    2ad2:	53                   	push   %rbx
    2ad3:	50                   	push   %rax
    2ad4:	48 89 fb             	mov    %rdi,%rbx
    2ad7:	e8 24 2d 00 00       	call   5800 <fwp_rc_last>
    2adc:	85 c0                	test   %eax,%eax
    2ade:	0f 84 83 00 00 00    	je     2b67 <fwp_rc_free_obj+0x97>
    2ae4:	8b 0d ce 31 01 00    	mov    0x131ce(%rip),%ecx        # 15cb8 <fwp_reuse_verify>
    2aea:	85 c9                	test   %ecx,%ecx
    2aec:	78 13                	js     2b01 <fwp_rc_free_obj+0x31>
    2aee:	85 c9                	test   %ecx,%ecx
    2af0:	74 47                	je     2b39 <fwp_rc_free_obj+0x69>
    2af2:	48 89 df             	mov    %rbx,%rdi
    2af5:	48 83 c4 08          	add    $0x8,%rsp
    2af9:	5b                   	pop    %rbx
    2afa:	41 5e                	pop    %r14
    2afc:	e9 df a3 00 00       	jmp    cee0 <fwp_rc_poison>
    2b01:	48 8d 3d 41 bd 00 00 	lea    0xbd41(%rip),%rdi        # e849 <exec_in_fp0+0x1f9>
    2b08:	e8 23 f5 ff ff       	call   2030 <getenv@plt>
    2b0d:	31 c9                	xor    %ecx,%ecx
    2b0f:	48 85 c0             	test   %rax,%rax
    2b12:	74 1b                	je     2b2f <fwp_rc_free_obj+0x5f>
    2b14:	80 38 00             	cmpb   $0x0,(%rax)
    2b17:	74 16                	je     2b2f <fwp_rc_free_obj+0x5f>
    2b19:	48 8d 35 5b c8 00 00 	lea    0xc85b(%rip),%rsi        # f37b <exec_in_fp0+0xd2b>
    2b20:	48 89 c7             	mov    %rax,%rdi
    2b23:	e8 a8 f7 ff ff       	call   22d0 <strcmp@plt>
    2b28:	31 c9                	xor    %ecx,%ecx
    2b2a:	85 c0                	test   %eax,%eax
    2b2c:	0f 95 c1             	setne  %cl
    2b2f:	89 0d 83 31 01 00    	mov    %ecx,0x13183(%rip)        # 15cb8 <fwp_reuse_verify>
    2b35:	85 c9                	test   %ecx,%ecx
    2b37:	75 b9                	jne    2af2 <fwp_rc_free_obj+0x22>
    2b39:	4c 8b 35 58 17 01 00 	mov    0x11758(%rip),%r14        # 14298 <fwp_gc>
    2b40:	48 89 df             	mov    %rbx,%rdi
    2b43:	e8 d8 2c 00 00       	call   5820 <fwp_mem_free>
    2b48:	48 8b 05 49 17 01 00 	mov    0x11749(%rip),%rax        # 14298 <fwp_gc>
    2b4f:	4c 29 f0             	sub    %r14,%rax
    2b52:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    2b57:	f2 0f 58 05 41 29 01 	addsd  0x12941(%rip),%xmm0        # 154a0 <fwp_gc+0x1208>
    2b5e:	00 
    2b5f:	f2 0f 11 05 39 29 01 	movsd  %xmm0,0x12939(%rip)        # 154a0 <fwp_gc+0x1208>
    2b66:	00 
    2b67:	48 83 c4 08          	add    $0x8,%rsp
    2b6b:	5b                   	pop    %rbx
    2b6c:	41 5e                	pop    %r14
    2b6e:	c3                   	ret
    2b6f:	90                   	nop

0000000000002b70 <e0>:
    2b70:	50                   	push   %rax
    2b71:	48 8b 3f             	mov    (%rdi),%rdi
    2b74:	e8 e7 01 00 00       	call   2d60 <f0>
    2b79:	48 89 c7             	mov    %rax,%rdi
    2b7c:	58                   	pop    %rax
    2b7d:	e9 ce 01 00 00       	jmp    2d50 <fwp_rc_shared>
    2b82:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2b89:	1f 84 00 00 00 00 00 

0000000000002b90 <e1>:
    2b90:	50                   	push   %rax
    2b91:	48 8b 3f             	mov    (%rdi),%rdi
    2b94:	e8 97 fe ff ff       	call   2a30 <f1>
    2b99:	48 89 c7             	mov    %rax,%rdi
    2b9c:	58                   	pop    %rax
    2b9d:	e9 ae 01 00 00       	jmp    2d50 <fwp_rc_shared>
    2ba2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2ba9:	1f 84 00 00 00 00 00 

0000000000002bb0 <e2>:
    2bb0:	50                   	push   %rax
    2bb1:	48 8b 3f             	mov    (%rdi),%rdi
    2bb4:	e8 17 24 00 00       	call   4fd0 <f2>
    2bb9:	48 89 c7             	mov    %rax,%rdi
    2bbc:	58                   	pop    %rax
    2bbd:	e9 8e 01 00 00       	jmp    2d50 <fwp_rc_shared>
    2bc2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2bc9:	1f 84 00 00 00 00 00 

0000000000002bd0 <e3>:
    2bd0:	50                   	push   %rax
    2bd1:	48 8b 3f             	mov    (%rdi),%rdi
    2bd4:	e8 07 2f 00 00       	call   5ae0 <f3>
    2bd9:	48 89 c7             	mov    %rax,%rdi
    2bdc:	58                   	pop    %rax
    2bdd:	e9 6e 01 00 00       	jmp    2d50 <fwp_rc_shared>
    2be2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2be9:	1f 84 00 00 00 00 00 

0000000000002bf0 <e4>:
    2bf0:	50                   	push   %rax
    2bf1:	48 8b 3f             	mov    (%rdi),%rdi
    2bf4:	e8 17 30 00 00       	call   5c10 <f4>
    2bf9:	48 89 c7             	mov    %rax,%rdi
    2bfc:	58                   	pop    %rax
    2bfd:	e9 4e 01 00 00       	jmp    2d50 <fwp_rc_shared>
    2c02:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2c09:	1f 84 00 00 00 00 00 

0000000000002c10 <e6>:
    2c10:	50                   	push   %rax
    2c11:	48 8b 07             	mov    (%rdi),%rax
    2c14:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2c18:	48 89 c7             	mov    %rax,%rdi
    2c1b:	e8 a0 2f 00 00       	call   5bc0 <f6>
    2c20:	48 89 c7             	mov    %rax,%rdi
    2c23:	58                   	pop    %rax
    2c24:	e9 27 01 00 00       	jmp    2d50 <fwp_rc_shared>
    2c29:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002c30 <e10>:
    2c30:	50                   	push   %rax
    2c31:	48 8b 3f             	mov    (%rdi),%rdi
    2c34:	e8 b7 2f 00 00       	call   5bf0 <f10>
    2c39:	48 89 c7             	mov    %rax,%rdi
    2c3c:	58                   	pop    %rax
    2c3d:	e9 0e 01 00 00       	jmp    2d50 <fwp_rc_shared>
    2c42:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2c49:	1f 84 00 00 00 00 00 

0000000000002c50 <e12>:
    2c50:	50                   	push   %rax
    2c51:	48 8b 07             	mov    (%rdi),%rax
    2c54:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2c58:	48 89 c7             	mov    %rax,%rdi
    2c5b:	e8 10 28 00 00       	call   5470 <f12>
    2c60:	48 89 c7             	mov    %rax,%rdi
    2c63:	58                   	pop    %rax
    2c64:	e9 e7 00 00 00       	jmp    2d50 <fwp_rc_shared>
    2c69:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002c70 <e14>:
    2c70:	50                   	push   %rax
    2c71:	48 8b 07             	mov    (%rdi),%rax
    2c74:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2c78:	48 89 c7             	mov    %rax,%rdi
    2c7b:	e8 10 28 00 00       	call   5490 <f14>
    2c80:	48 89 c7             	mov    %rax,%rdi
    2c83:	58                   	pop    %rax
    2c84:	e9 c7 00 00 00       	jmp    2d50 <fwp_rc_shared>
    2c89:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002c90 <e16>:
    2c90:	50                   	push   %rax
    2c91:	48 8b 07             	mov    (%rdi),%rax
    2c94:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2c98:	48 89 c7             	mov    %rax,%rdi
    2c9b:	e8 20 28 00 00       	call   54c0 <f16>
    2ca0:	48 89 c7             	mov    %rax,%rdi
    2ca3:	58                   	pop    %rax
    2ca4:	e9 a7 00 00 00       	jmp    2d50 <fwp_rc_shared>
    2ca9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002cb0 <e18>:
    2cb0:	50                   	push   %rax
    2cb1:	48 8b 07             	mov    (%rdi),%rax
    2cb4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2cb8:	48 89 c7             	mov    %rax,%rdi
    2cbb:	e8 30 28 00 00       	call   54f0 <f18>
    2cc0:	48 89 c7             	mov    %rax,%rdi
    2cc3:	58                   	pop    %rax
    2cc4:	e9 87 00 00 00       	jmp    2d50 <fwp_rc_shared>
    2cc9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002cd0 <e20>:
    2cd0:	50                   	push   %rax
    2cd1:	48 8b 07             	mov    (%rdi),%rax
    2cd4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2cd8:	48 89 c7             	mov    %rax,%rdi
    2cdb:	e8 50 28 00 00       	call   5530 <f20>
    2ce0:	48 89 c7             	mov    %rax,%rdi
    2ce3:	58                   	pop    %rax
    2ce4:	eb 6a                	jmp    2d50 <fwp_rc_shared>
    2ce6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2ced:	00 00 00 

0000000000002cf0 <e22>:
    2cf0:	50                   	push   %rax
    2cf1:	48 8b 07             	mov    (%rdi),%rax
    2cf4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2cf8:	48 89 c7             	mov    %rax,%rdi
    2cfb:	e8 80 28 00 00       	call   5580 <f22>
    2d00:	48 89 c7             	mov    %rax,%rdi
    2d03:	58                   	pop    %rax
    2d04:	eb 4a                	jmp    2d50 <fwp_rc_shared>
    2d06:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2d0d:	00 00 00 

0000000000002d10 <e24>:
    2d10:	50                   	push   %rax
    2d11:	48 8b 07             	mov    (%rdi),%rax
    2d14:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2d18:	48 89 c7             	mov    %rax,%rdi
    2d1b:	e8 b0 28 00 00       	call   55d0 <f24>
    2d20:	48 89 c7             	mov    %rax,%rdi
    2d23:	58                   	pop    %rax
    2d24:	eb 2a                	jmp    2d50 <fwp_rc_shared>
    2d26:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2d2d:	00 00 00 

0000000000002d30 <e26>:
    2d30:	50                   	push   %rax
    2d31:	48 8b 07             	mov    (%rdi),%rax
    2d34:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2d38:	48 89 c7             	mov    %rax,%rdi
    2d3b:	e8 f0 28 00 00       	call   5630 <f26>
    2d40:	48 89 c7             	mov    %rax,%rdi
    2d43:	58                   	pop    %rax
    2d44:	eb 0a                	jmp    2d50 <fwp_rc_shared>
    2d46:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2d4d:	00 00 00 

0000000000002d50 <fwp_rc_shared>:
    2d50:	53                   	push   %rbx
    2d51:	48 89 fb             	mov    %rdi,%rbx
    2d54:	e8 77 00 00 00       	call   2dd0 <fwp_rc_share>
    2d59:	48 89 d8             	mov    %rbx,%rax
    2d5c:	5b                   	pop    %rbx
    2d5d:	c3                   	ret
    2d5e:	66 90                	xchg   %ax,%ax

0000000000002d60 <f0>:
    2d60:	53                   	push   %rbx
    2d61:	48 83 ec 30          	sub    $0x30,%rsp
    2d65:	e8 56 03 00 00       	call   30c0 <fwp_f64>
    2d6a:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    2d6f:	e8 1c 03 00 00       	call   3090 <w0>
    2d74:	f2 0f 10 44 24 18    	movsd  0x18(%rsp),%xmm0
    2d7a:	e8 a1 03 00 00       	call   3120 <fwp_from_f64>
    2d7f:	48 89 04 24          	mov    %rax,(%rsp)
    2d83:	f2 0f 10 44 24 20    	movsd  0x20(%rsp),%xmm0
    2d89:	e8 92 03 00 00       	call   3120 <fwp_from_f64>
    2d8e:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    2d93:	f2 0f 10 44 24 28    	movsd  0x28(%rsp),%xmm0
    2d99:	e8 82 03 00 00       	call   3120 <fwp_from_f64>
    2d9e:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    2da3:	48 89 e6             	mov    %rsp,%rsi
    2da6:	bf 03 00 00 00       	mov    $0x3,%edi
    2dab:	e8 60 03 00 00       	call   3110 <fwp_record>
    2db0:	48 89 c3             	mov    %rax,%rbx
    2db3:	48 89 c7             	mov    %rax,%rdi
    2db6:	e8 15 03 00 00       	call   30d0 <fwp_rc_fresh>
    2dbb:	48 89 d8             	mov    %rbx,%rax
    2dbe:	48 83 c4 30          	add    $0x30,%rsp
    2dc2:	5b                   	pop    %rbx
    2dc3:	c3                   	ret
    2dc4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    2dcb:	00 00 00 00 00 

0000000000002dd0 <fwp_rc_share>:
    2dd0:	41 57                	push   %r15
    2dd2:	41 56                	push   %r14
    2dd4:	41 55                	push   %r13
    2dd6:	41 54                	push   %r12
    2dd8:	53                   	push   %rbx
    2dd9:	48 81 ec 00 02 00 00 	sub    $0x200,%rsp
    2de0:	48 89 fb             	mov    %rdi,%rbx
    2de3:	e8 08 01 00 00       	call   2ef0 <fwp_rc_slot>
    2de8:	48 85 c0             	test   %rax,%rax
    2deb:	0f 84 ec 00 00 00    	je     2edd <fwp_rc_share+0x10d>
    2df1:	80 38 00             	cmpb   $0x0,(%rax)
    2df4:	0f 84 e3 00 00 00    	je     2edd <fwp_rc_share+0x10d>
    2dfa:	48 89 c7             	mov    %rax,%rdi
    2dfd:	e8 5e 01 00 00       	call   2f60 <fwp_rc_clear_slot>
    2e02:	48 89 1c 24          	mov    %rbx,(%rsp)
    2e06:	41 be 01 00 00 00    	mov    $0x1,%r14d
    2e0c:	eb 0b                	jmp    2e19 <fwp_rc_share+0x49>
    2e0e:	66 90                	xchg   %ax,%ax
    2e10:	4d 85 f6             	test   %r14,%r14
    2e13:	0f 84 c4 00 00 00    	je     2edd <fwp_rc_share+0x10d>
    2e19:	4e 8b 7c f4 f8       	mov    -0x8(%rsp,%r14,8),%r15
    2e1e:	49 ff ce             	dec    %r14
    2e21:	4c 89 ff             	mov    %r15,%rdi
    2e24:	48 2b 3d 9d 24 01 00 	sub    0x1249d(%rip),%rdi        # 152c8 <fwp_gc+0x1030>
    2e2b:	48 c1 ef 10          	shr    $0x10,%rdi
    2e2f:	48 8b 05 da 24 01 00 	mov    0x124da(%rip),%rax        # 15310 <fwp_gc+0x1078>
    2e36:	48 69 cf 28 12 00 00 	imul   $0x1228,%rdi,%rcx
    2e3d:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    2e42:	74 cc                	je     2e10 <fwp_rc_share+0x40>
    2e44:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    2e48:	80 fa 02             	cmp    $0x2,%dl
    2e4b:	75 13                	jne    2e60 <fwp_rc_share+0x90>
    2e4d:	4c 8b 64 08 18       	mov    0x18(%rax,%rcx,1),%r12
    2e52:	eb 33                	jmp    2e87 <fwp_rc_share+0xb7>
    2e54:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    2e5b:	00 00 00 00 00 
    2e60:	44 8b 64 08 08       	mov    0x8(%rax,%rcx,1),%r12d
    2e65:	80 fa 01             	cmp    $0x1,%dl
    2e68:	75 1d                	jne    2e87 <fwp_rc_share+0xb7>
    2e6a:	41 0f b7 d7          	movzwl %r15w,%edx
    2e6e:	44 8b 7c 08 20       	mov    0x20(%rax,%rcx,1),%r15d
    2e73:	4c 0f af fa          	imul   %rdx,%r15
    2e77:	49 c1 ef 20          	shr    $0x20,%r15
    2e7b:	e8 00 01 00 00       	call   2f80 <fwp_gc_chunk_addr>
    2e80:	4d 0f af fc          	imul   %r12,%r15
    2e84:	49 01 c7             	add    %rax,%r15
    2e87:	49 83 fc 08          	cmp    $0x8,%r12
    2e8b:	72 83                	jb     2e10 <fwp_rc_share+0x40>
    2e8d:	49 c1 ec 03          	shr    $0x3,%r12
    2e91:	45 31 ed             	xor    %r13d,%r13d
    2e94:	eb 16                	jmp    2eac <fwp_rc_share+0xdc>
    2e96:	48 89 df             	mov    %rbx,%rdi
    2e99:	e8 32 ff ff ff       	call   2dd0 <fwp_rc_share>
    2e9e:	66 90                	xchg   %ax,%ax
    2ea0:	49 ff c5             	inc    %r13
    2ea3:	4d 39 ec             	cmp    %r13,%r12
    2ea6:	0f 84 64 ff ff ff    	je     2e10 <fwp_rc_share+0x40>
    2eac:	4b 8b 1c ef          	mov    (%r15,%r13,8),%rbx
    2eb0:	48 89 df             	mov    %rbx,%rdi
    2eb3:	e8 38 00 00 00       	call   2ef0 <fwp_rc_slot>
    2eb8:	48 85 c0             	test   %rax,%rax
    2ebb:	74 e3                	je     2ea0 <fwp_rc_share+0xd0>
    2ebd:	80 38 00             	cmpb   $0x0,(%rax)
    2ec0:	74 de                	je     2ea0 <fwp_rc_share+0xd0>
    2ec2:	49 83 fe 3f          	cmp    $0x3f,%r14
    2ec6:	77 ce                	ja     2e96 <fwp_rc_share+0xc6>
    2ec8:	48 89 c7             	mov    %rax,%rdi
    2ecb:	e8 90 00 00 00       	call   2f60 <fwp_rc_clear_slot>
    2ed0:	4b 8b 04 ef          	mov    (%r15,%r13,8),%rax
    2ed4:	4a 89 04 f4          	mov    %rax,(%rsp,%r14,8)
    2ed8:	49 ff c6             	inc    %r14
    2edb:	eb c3                	jmp    2ea0 <fwp_rc_share+0xd0>
    2edd:	48 81 c4 00 02 00 00 	add    $0x200,%rsp
    2ee4:	5b                   	pop    %rbx
    2ee5:	41 5c                	pop    %r12
    2ee7:	41 5d                	pop    %r13
    2ee9:	41 5e                	pop    %r14
    2eeb:	41 5f                	pop    %r15
    2eed:	c3                   	ret
    2eee:	66 90                	xchg   %ax,%ax

0000000000002ef0 <fwp_rc_slot>:
    2ef0:	48 2b 3d d1 23 01 00 	sub    0x123d1(%rip),%rdi        # 152c8 <fwp_gc+0x1030>
    2ef7:	48 8b 05 f2 23 01 00 	mov    0x123f2(%rip),%rax        # 152f0 <fwp_gc+0x1058>
    2efe:	48 c1 e0 10          	shl    $0x10,%rax
    2f02:	48 39 c7             	cmp    %rax,%rdi
    2f05:	73 51                	jae    2f58 <fwp_rc_slot+0x68>
    2f07:	48 8b 05 02 24 01 00 	mov    0x12402(%rip),%rax        # 15310 <fwp_gc+0x1078>
    2f0e:	48 89 f9             	mov    %rdi,%rcx
    2f11:	48 c1 e9 10          	shr    $0x10,%rcx
    2f15:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    2f1c:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    2f20:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    2f27:	75 0f                	jne    2f38 <fwp_rc_slot+0x48>
    2f29:	80 fa 02             	cmp    $0x2,%dl
    2f2c:	75 0a                	jne    2f38 <fwp_rc_slot+0x48>
    2f2e:	48 01 c8             	add    %rcx,%rax
    2f31:	48 05 28 02 00 00    	add    $0x228,%rax
    2f37:	c3                   	ret
    2f38:	80 fa 01             	cmp    $0x1,%dl
    2f3b:	75 1b                	jne    2f58 <fwp_rc_slot+0x68>
    2f3d:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    2f41:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    2f45:	48 0f af f8          	imul   %rax,%rdi
    2f49:	48 c1 ef 20          	shr    $0x20,%rdi
    2f4d:	48 8d 04 17          	lea    (%rdi,%rdx,1),%rax
    2f51:	48 05 28 02 00 00    	add    $0x228,%rax
    2f57:	c3                   	ret
    2f58:	31 c0                	xor    %eax,%eax
    2f5a:	c3                   	ret
    2f5b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000002f60 <fwp_rc_clear_slot>:
    2f60:	80 3f ff             	cmpb   $0xff,(%rdi)
    2f63:	74 04                	je     2f69 <fwp_rc_clear_slot+0x9>
    2f65:	c6 07 00             	movb   $0x0,(%rdi)
    2f68:	c3                   	ret
    2f69:	53                   	push   %rbx
    2f6a:	48 89 fb             	mov    %rdi,%rbx
    2f6d:	e8 1e 00 00 00       	call   2f90 <fwp_rc_forget_slot>
    2f72:	48 89 df             	mov    %rbx,%rdi
    2f75:	5b                   	pop    %rbx
    2f76:	c6 07 00             	movb   $0x0,(%rdi)
    2f79:	c3                   	ret
    2f7a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000002f80 <fwp_gc_chunk_addr>:
    2f80:	48 89 f8             	mov    %rdi,%rax
    2f83:	48 c1 e0 10          	shl    $0x10,%rax
    2f87:	48 03 05 3a 23 01 00 	add    0x1233a(%rip),%rax        # 152c8 <fwp_gc+0x1030>
    2f8e:	c3                   	ret
    2f8f:	90                   	nop

0000000000002f90 <fwp_rc_forget_slot>:
    2f90:	50                   	push   %rax
    2f91:	80 3f ff             	cmpb   $0xff,(%rdi)
    2f94:	74 02                	je     2f98 <fwp_rc_forget_slot+0x8>
    2f96:	58                   	pop    %rax
    2f97:	c3                   	ret
    2f98:	e8 33 00 00 00       	call   2fd0 <fwp_rc_wide_link>
    2f9d:	48 8b 38             	mov    (%rax),%rdi
    2fa0:	48 85 ff             	test   %rdi,%rdi
    2fa3:	74 15                	je     2fba <fwp_rc_forget_slot+0x2a>
    2fa5:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    2fa9:	48 89 08             	mov    %rcx,(%rax)
    2fac:	e8 9f f0 ff ff       	call   2050 <free@plt>
    2fb1:	48 ff 0d f8 2c 01 00 	decq   0x12cf8(%rip)        # 15cb0 <fwp_gc+0x1a18>
    2fb8:	58                   	pop    %rax
    2fb9:	c3                   	ret
    2fba:	48 8d 3d 43 b7 00 00 	lea    0xb743(%rip),%rdi        # e704 <exec_in_fp0+0xb4>
    2fc1:	e8 6a 00 00 00       	call   3030 <fwp_trap>
    2fc6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2fcd:	00 00 00 

0000000000002fd0 <fwp_rc_wide_link>:
    2fd0:	48 89 f8             	mov    %rdi,%rax
    2fd3:	48 c1 e8 11          	shr    $0x11,%rax
    2fd7:	31 f8                	xor    %edi,%eax
    2fd9:	89 c1                	mov    %eax,%ecx
    2fdb:	c1 e9 09             	shr    $0x9,%ecx
    2fde:	31 c1                	xor    %eax,%ecx
    2fe0:	0f b6 c9             	movzbl %cl,%ecx
    2fe3:	48 8d 15 ae 12 01 00 	lea    0x112ae(%rip),%rdx        # 14298 <fwp_gc>
    2fea:	48 8d 04 ca          	lea    (%rdx,%rcx,8),%rax
    2fee:	48 05 18 12 00 00    	add    $0x1218,%rax
    2ff4:	48 8b 8c ca 18 12 00 	mov    0x1218(%rdx,%rcx,8),%rcx
    2ffb:	00 
    2ffc:	48 85 c9             	test   %rcx,%rcx
    2fff:	74 24                	je     3025 <fwp_rc_wide_link+0x55>
    3001:	48 39 39             	cmp    %rdi,(%rcx)
    3004:	74 1f                	je     3025 <fwp_rc_wide_link+0x55>
    3006:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    300d:	00 00 00 
    3010:	48 89 c8             	mov    %rcx,%rax
    3013:	48 8b 49 10          	mov    0x10(%rcx),%rcx
    3017:	48 85 c9             	test   %rcx,%rcx
    301a:	74 05                	je     3021 <fwp_rc_wide_link+0x51>
    301c:	48 39 39             	cmp    %rdi,(%rcx)
    301f:	75 ef                	jne    3010 <fwp_rc_wide_link+0x40>
    3021:	48 83 c0 10          	add    $0x10,%rax
    3025:	c3                   	ret
    3026:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    302d:	00 00 00 

0000000000003030 <fwp_trap>:
    3030:	53                   	push   %rbx
    3031:	48 89 fb             	mov    %rdi,%rbx
    3034:	e8 27 00 00 00       	call   3060 <fwp_flush>
    3039:	48 8b 05 a0 0f 01 00 	mov    0x10fa0(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    3040:	48 8b 38             	mov    (%rax),%rdi
    3043:	48 8d 35 e1 b6 00 00 	lea    0xb6e1(%rip),%rsi        # e72b <exec_in_fp0+0xdb>
    304a:	48 89 da             	mov    %rbx,%rdx
    304d:	31 c0                	xor    %eax,%eax
    304f:	e8 9c f2 ff ff       	call   22f0 <fprintf@plt>
    3054:	bf 65 00 00 00       	mov    $0x65,%edi
    3059:	e8 22 f4 ff ff       	call   2480 <exit@plt>
    305e:	66 90                	xchg   %ax,%ax

0000000000003060 <fwp_flush>:
    3060:	50                   	push   %rax
    3061:	48 8b 3d 40 2d 01 00 	mov    0x12d40(%rip),%rdi        # 15da8 <fwp_prog_out>
    3068:	48 85 ff             	test   %rdi,%rdi
    306b:	74 05                	je     3072 <fwp_flush+0x12>
    306d:	e8 de f2 ff ff       	call   2350 <fflush@plt>
    3072:	48 8b 05 3f 0f 01 00 	mov    0x10f3f(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    3079:	48 8b 38             	mov    (%rax),%rdi
    307c:	58                   	pop    %rax
    307d:	e9 ce f2 ff ff       	jmp    2350 <fflush@plt>
    3082:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3089:	1f 84 00 00 00 00 00 

0000000000003090 <w0>:
    3090:	53                   	push   %rbx
    3091:	48 89 fb             	mov    %rdi,%rbx
    3094:	e8 87 00 00 00       	call   3120 <fwp_from_f64>
    3099:	48 89 c7             	mov    %rax,%rdi
    309c:	e8 1f 00 00 00       	call   30c0 <fwp_f64>
    30a1:	f2 0f 11 03          	movsd  %xmm0,(%rbx)
    30a5:	f2 0f 11 43 08       	movsd  %xmm0,0x8(%rbx)
    30aa:	f2 0f 11 43 10       	movsd  %xmm0,0x10(%rbx)
    30af:	48 89 d8             	mov    %rbx,%rax
    30b2:	5b                   	pop    %rbx
    30b3:	c3                   	ret
    30b4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    30bb:	00 00 00 00 00 

00000000000030c0 <fwp_f64>:
    30c0:	66 48 0f 6e c7       	movq   %rdi,%xmm0
    30c5:	c3                   	ret
    30c6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    30cd:	00 00 00 

00000000000030d0 <fwp_rc_fresh>:
    30d0:	41 56                	push   %r14
    30d2:	53                   	push   %rbx
    30d3:	50                   	push   %rax
    30d4:	48 89 fb             	mov    %rdi,%rbx
    30d7:	e8 14 fe ff ff       	call   2ef0 <fwp_rc_slot>
    30dc:	48 85 c0             	test   %rax,%rax
    30df:	74 08                	je     30e9 <fwp_rc_fresh+0x19>
    30e1:	80 38 ff             	cmpb   $0xff,(%rax)
    30e4:	74 0e                	je     30f4 <fwp_rc_fresh+0x24>
    30e6:	c6 00 01             	movb   $0x1,(%rax)
    30e9:	48 89 d8             	mov    %rbx,%rax
    30ec:	48 83 c4 08          	add    $0x8,%rsp
    30f0:	5b                   	pop    %rbx
    30f1:	41 5e                	pop    %r14
    30f3:	c3                   	ret
    30f4:	48 89 c7             	mov    %rax,%rdi
    30f7:	49 89 c6             	mov    %rax,%r14
    30fa:	e8 91 fe ff ff       	call   2f90 <fwp_rc_forget_slot>
    30ff:	4c 89 f0             	mov    %r14,%rax
    3102:	eb e2                	jmp    30e6 <fwp_rc_fresh+0x16>
    3104:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    310b:	00 00 00 00 00 

0000000000003110 <fwp_record>:
    3110:	85 ff                	test   %edi,%edi
    3112:	74 09                	je     311d <fwp_record+0xd>
    3114:	48 89 f2             	mov    %rsi,%rdx
    3117:	89 fe                	mov    %edi,%esi
    3119:	31 ff                	xor    %edi,%edi
    311b:	eb 13                	jmp    3130 <fwp_data>
    311d:	31 c0                	xor    %eax,%eax
    311f:	c3                   	ret

0000000000003120 <fwp_from_f64>:
    3120:	66 48 0f 7e c0       	movq   %xmm0,%rax
    3125:	c3                   	ret
    3126:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    312d:	00 00 00 

0000000000003130 <fwp_data>:
    3130:	55                   	push   %rbp
    3131:	41 57                	push   %r15
    3133:	41 56                	push   %r14
    3135:	53                   	push   %rbx
    3136:	50                   	push   %rax
    3137:	89 fd                	mov    %edi,%ebp
    3139:	85 f6                	test   %esi,%esi
    313b:	0f 84 a1 00 00 00    	je     31e2 <fwp_data+0xb2>
    3141:	48 89 d3             	mov    %rdx,%rbx
    3144:	41 89 f6             	mov    %esi,%r14d
    3147:	4a 8d 3c f5 08 00 00 	lea    0x8(,%r14,8),%rdi
    314e:	00 
    314f:	41 89 f7             	mov    %esi,%r15d
    3152:	e8 d9 00 00 00       	call   3230 <fwp_alloc_init>
    3157:	89 28                	mov    %ebp,(%rax)
    3159:	44 89 78 04          	mov    %r15d,0x4(%rax)
    315d:	41 83 ff 08          	cmp    $0x8,%r15d
    3161:	72 10                	jb     3173 <fwp_data+0x43>
    3163:	48 89 c1             	mov    %rax,%rcx
    3166:	48 29 d9             	sub    %rbx,%rcx
    3169:	48 83 c1 08          	add    $0x8,%rcx
    316d:	48 83 f9 20          	cmp    $0x20,%rcx
    3171:	73 73                	jae    31e6 <fwp_data+0xb6>
    3173:	31 c9                	xor    %ecx,%ecx
    3175:	4c 89 f6             	mov    %r14,%rsi
    3178:	48 89 ca             	mov    %rcx,%rdx
    317b:	48 83 e6 03          	and    $0x3,%rsi
    317f:	74 20                	je     31a1 <fwp_data+0x71>
    3181:	48 89 ca             	mov    %rcx,%rdx
    3184:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    318b:	00 00 00 00 00 
    3190:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    3194:	48 89 7c d0 08       	mov    %rdi,0x8(%rax,%rdx,8)
    3199:	48 ff c2             	inc    %rdx
    319c:	48 ff ce             	dec    %rsi
    319f:	75 ef                	jne    3190 <fwp_data+0x60>
    31a1:	4c 29 f1             	sub    %r14,%rcx
    31a4:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    31a8:	77 7b                	ja     3225 <fwp_data+0xf5>
    31aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    31b0:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    31b4:	48 89 4c d0 08       	mov    %rcx,0x8(%rax,%rdx,8)
    31b9:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    31be:	48 89 4c d0 10       	mov    %rcx,0x10(%rax,%rdx,8)
    31c3:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    31c8:	48 89 4c d0 18       	mov    %rcx,0x18(%rax,%rdx,8)
    31cd:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    31d2:	48 89 4c d0 20       	mov    %rcx,0x20(%rax,%rdx,8)
    31d7:	48 83 c2 04          	add    $0x4,%rdx
    31db:	49 39 d6             	cmp    %rdx,%r14
    31de:	75 d0                	jne    31b0 <fwp_data+0x80>
    31e0:	eb 43                	jmp    3225 <fwp_data+0xf5>
    31e2:	89 e8                	mov    %ebp,%eax
    31e4:	eb 3f                	jmp    3225 <fwp_data+0xf5>
    31e6:	44 89 f1             	mov    %r14d,%ecx
    31e9:	83 e1 fc             	and    $0xfffffffc,%ecx
    31ec:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
    31f3:	00 
    31f4:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    31f8:	31 f6                	xor    %esi,%esi
    31fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    3200:	0f 10 04 33          	movups (%rbx,%rsi,1),%xmm0
    3204:	0f 10 4c 33 10       	movups 0x10(%rbx,%rsi,1),%xmm1
    3209:	0f 11 44 30 08       	movups %xmm0,0x8(%rax,%rsi,1)
    320e:	0f 11 4c 30 18       	movups %xmm1,0x18(%rax,%rsi,1)
    3213:	48 83 c6 20          	add    $0x20,%rsi
    3217:	48 39 f2             	cmp    %rsi,%rdx
    321a:	75 e4                	jne    3200 <fwp_data+0xd0>
    321c:	4c 39 f1             	cmp    %r14,%rcx
    321f:	0f 85 50 ff ff ff    	jne    3175 <fwp_data+0x45>
    3225:	48 83 c4 08          	add    $0x8,%rsp
    3229:	5b                   	pop    %rbx
    322a:	41 5e                	pop    %r14
    322c:	41 5f                	pop    %r15
    322e:	5d                   	pop    %rbp
    322f:	c3                   	ret

0000000000003230 <fwp_alloc_init>:
    3230:	53                   	push   %rbx
    3231:	48 89 fa             	mov    %rdi,%rdx
    3234:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    323b:	0f 87 a7 00 00 00    	ja     32e8 <fwp_alloc_init+0xb8>
    3241:	48 8d 42 0f          	lea    0xf(%rdx),%rax
    3245:	48 c1 e8 04          	shr    $0x4,%rax
    3249:	48 8d 35 48 10 01 00 	lea    0x11048(%rip),%rsi        # 14298 <fwp_gc>
    3250:	0f b6 bc 30 e8 0b 00 	movzbl 0xbe8(%rax,%rsi,1),%edi
    3257:	00 
    3258:	8b 84 be 48 0b 00 00 	mov    0xb48(%rsi,%rdi,4),%eax
    325f:	48 8b 0d 32 10 01 00 	mov    0x11032(%rip),%rcx        # 14298 <fwp_gc>
    3266:	49 89 c8             	mov    %rcx,%r8
    3269:	49 29 c0             	sub    %rax,%r8
    326c:	4c 89 05 25 10 01 00 	mov    %r8,0x11025(%rip)        # 14298 <fwp_gc>
    3273:	78 6c                	js     32e1 <fwp_alloc_init+0xb1>
    3275:	48 8d 3c 7f          	lea    (%rdi,%rdi,2),%rdi
    3279:	4c 8d 04 fe          	lea    (%rsi,%rdi,8),%r8
    327d:	49 83 c0 08          	add    $0x8,%r8
    3281:	49 8b 18             	mov    (%r8),%rbx
    3284:	48 85 db             	test   %rbx,%rbx
    3287:	74 32                	je     32bb <fwp_alloc_init+0x8b>
    3289:	48 8b 0b             	mov    (%rbx),%rcx
    328c:	48 f7 d1             	not    %rcx
    328f:	49 89 08             	mov    %rcx,(%r8)
    3292:	81 e2 f8 7f 00 00    	and    $0x7ff8,%edx
    3298:	48 39 c2             	cmp    %rax,%rdx
    329b:	73 19                	jae    32b6 <fwp_alloc_init+0x86>
    329d:	48 8d 3c 13          	lea    (%rbx,%rdx,1),%rdi
    32a1:	48 f7 d2             	not    %rdx
    32a4:	48 01 c2             	add    %rax,%rdx
    32a7:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    32ab:	48 83 c2 08          	add    $0x8,%rdx
    32af:	31 f6                	xor    %esi,%esi
    32b1:	e8 5a ef ff ff       	call   2210 <memset@plt>
    32b6:	48 89 d8             	mov    %rbx,%rax
    32b9:	5b                   	pop    %rbx
    32ba:	c3                   	ret
    32bb:	48 8b 5c fe 10       	mov    0x10(%rsi,%rdi,8),%rbx
    32c0:	4c 8b 44 fe 18       	mov    0x18(%rsi,%rdi,8),%r8
    32c5:	49 29 d8             	sub    %rbx,%r8
    32c8:	49 39 c0             	cmp    %rax,%r8
    32cb:	72 14                	jb     32e1 <fwp_alloc_init+0xb1>
    32cd:	48 8d 34 fe          	lea    (%rsi,%rdi,8),%rsi
    32d1:	48 83 c6 10          	add    $0x10,%rsi
    32d5:	48 8d 3c 03          	lea    (%rbx,%rax,1),%rdi
    32d9:	48 89 3e             	mov    %rdi,(%rsi)
    32dc:	48 85 db             	test   %rbx,%rbx
    32df:	75 b1                	jne    3292 <fwp_alloc_init+0x62>
    32e1:	48 89 0d b0 0f 01 00 	mov    %rcx,0x10fb0(%rip)        # 14298 <fwp_gc>
    32e8:	48 89 d7             	mov    %rdx,%rdi
    32eb:	31 f6                	xor    %esi,%esi
    32ed:	5b                   	pop    %rbx
    32ee:	eb 00                	jmp    32f0 <fwp_gc_alloc>

00000000000032f0 <fwp_gc_alloc>:
    32f0:	53                   	push   %rbx
    32f1:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    32f8:	77 6c                	ja     3366 <fwp_gc_alloc+0x76>
    32fa:	48 8d 4f 0f          	lea    0xf(%rdi),%rcx
    32fe:	48 c1 e9 04          	shr    $0x4,%rcx
    3302:	48 8d 05 8f 0f 01 00 	lea    0x10f8f(%rip),%rax        # 14298 <fwp_gc>
    3309:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    3310:	00 
    3311:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    3318:	48 29 15 79 0f 01 00 	sub    %rdx,0x10f79(%rip)        # 14298 <fwp_gc>
    331f:	78 45                	js     3366 <fwp_gc_alloc+0x76>
    3321:	41 89 f0             	mov    %esi,%r8d
    3324:	4d 69 c0 c0 03 00 00 	imul   $0x3c0,%r8,%r8
    332b:	4c 01 c0             	add    %r8,%rax
    332e:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    3332:	4c 8d 04 c8          	lea    (%rax,%rcx,8),%r8
    3336:	49 83 c0 08          	add    $0x8,%r8
    333a:	49 8b 18             	mov    (%r8),%rbx
    333d:	48 85 db             	test   %rbx,%rbx
    3340:	74 12                	je     3354 <fwp_gc_alloc+0x64>
    3342:	48 8b 03             	mov    (%rbx),%rax
    3345:	48 f7 d0             	not    %rax
    3348:	49 89 00             	mov    %rax,(%r8)
    334b:	83 fe 01             	cmp    $0x1,%esi
    334e:	48 0f 44 d7          	cmove  %rdi,%rdx
    3352:	eb 2e                	jmp    3382 <fwp_gc_alloc+0x92>
    3354:	48 8b 5c c8 10       	mov    0x10(%rax,%rcx,8),%rbx
    3359:	4c 8b 44 c8 18       	mov    0x18(%rax,%rcx,8),%r8
    335e:	49 29 d8             	sub    %rbx,%r8
    3361:	49 39 d0             	cmp    %rdx,%r8
    3364:	73 03                	jae    3369 <fwp_gc_alloc+0x79>
    3366:	5b                   	pop    %rbx
    3367:	eb 37                	jmp    33a0 <fwp_gc_alloc_slow>
    3369:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    336d:	48 83 c0 10          	add    $0x10,%rax
    3371:	48 8d 0c 13          	lea    (%rbx,%rdx,1),%rcx
    3375:	48 89 08             	mov    %rcx,(%rax)
    3378:	83 fe 01             	cmp    $0x1,%esi
    337b:	48 0f 45 fa          	cmovne %rdx,%rdi
    337f:	48 89 fa             	mov    %rdi,%rdx
    3382:	48 89 df             	mov    %rbx,%rdi
    3385:	31 f6                	xor    %esi,%esi
    3387:	e8 84 ee ff ff       	call   2210 <memset@plt>
    338c:	48 89 d8             	mov    %rbx,%rax
    338f:	5b                   	pop    %rbx
    3390:	c3                   	ret
    3391:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3398:	0f 1f 84 00 00 00 00 
    339f:	00 

00000000000033a0 <fwp_gc_alloc_slow>:
    33a0:	55                   	push   %rbp
    33a1:	41 57                	push   %r15
    33a3:	41 56                	push   %r14
    33a5:	41 54                	push   %r12
    33a7:	53                   	push   %rbx
    33a8:	89 f5                	mov    %esi,%ebp
    33aa:	48 89 fb             	mov    %rdi,%rbx
    33ad:	83 3d d0 1e 01 00 00 	cmpl   $0x0,0x11ed0(%rip)        # 15284 <fwp_gc+0xfec>
    33b4:	74 1b                	je     33d1 <fwp_gc_alloc_slow+0x31>
    33b6:	48 81 fb 01 40 00 00 	cmp    $0x4001,%rbx
    33bd:	72 20                	jb     33df <fwp_gc_alloc_slow+0x3f>
    33bf:	48 89 df             	mov    %rbx,%rdi
    33c2:	89 ee                	mov    %ebp,%esi
    33c4:	5b                   	pop    %rbx
    33c5:	41 5c                	pop    %r12
    33c7:	41 5e                	pop    %r14
    33c9:	41 5f                	pop    %r15
    33cb:	5d                   	pop    %rbp
    33cc:	e9 9f 03 00 00       	jmp    3770 <fwp_gc_alloc_big>
    33d1:	e8 ba 00 00 00       	call   3490 <fwp_gc_init>
    33d6:	48 81 fb 01 40 00 00 	cmp    $0x4001,%rbx
    33dd:	73 e0                	jae    33bf <fwp_gc_alloc_slow+0x1f>
    33df:	48 8d 43 0f          	lea    0xf(%rbx),%rax
    33e3:	48 c1 e8 04          	shr    $0x4,%rax
    33e7:	4c 8d 25 aa 0e 01 00 	lea    0x10eaa(%rip),%r12        # 14298 <fwp_gc>
    33ee:	46 0f b6 bc 20 e8 0b 	movzbl 0xbe8(%rax,%r12,1),%r15d
    33f5:	00 00 
    33f7:	47 8b b4 bc 48 0b 00 	mov    0xb48(%r12,%r15,4),%r14d
    33fe:	00 
    33ff:	48 83 3d 91 0e 01 00 	cmpq   $0x0,0x10e91(%rip)        # 14298 <fwp_gc>
    3406:	00 
    3407:	79 05                	jns    340e <fwp_gc_alloc_slow+0x6e>
    3409:	e8 b2 04 00 00       	call   38c0 <fwp_gc_spent>
    340e:	89 e8                	mov    %ebp,%eax
    3410:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    3417:	49 01 c4             	add    %rax,%r12
    341a:	4b 8d 0c 7f          	lea    (%r15,%r15,2),%rcx
    341e:	49 8d 04 cc          	lea    (%r12,%rcx,8),%rax
    3422:	48 83 c0 08          	add    $0x8,%rax
    3426:	49 8b 7c cc 08       	mov    0x8(%r12,%rcx,8),%rdi
    342b:	48 85 ff             	test   %rdi,%rdi
    342e:	74 08                	je     3438 <fwp_gc_alloc_slow+0x98>
    3430:	48 8b 0f             	mov    (%rdi),%rcx
    3433:	48 f7 d1             	not    %rcx
    3436:	eb 30                	jmp    3468 <fwp_gc_alloc_slow+0xc8>
    3438:	49 8b 7c cc 10       	mov    0x10(%r12,%rcx,8),%rdi
    343d:	49 8b 54 cc 18       	mov    0x18(%r12,%rcx,8),%rdx
    3442:	48 29 fa             	sub    %rdi,%rdx
    3445:	4c 39 f2             	cmp    %r14,%rdx
    3448:	73 12                	jae    345c <fwp_gc_alloc_slow+0xbc>
    344a:	48 89 c7             	mov    %rax,%rdi
    344d:	44 89 fe             	mov    %r15d,%esi
    3450:	89 ea                	mov    %ebp,%edx
    3452:	e8 39 05 00 00       	call   3990 <fwp_gc_refill>
    3457:	48 89 c7             	mov    %rax,%rdi
    345a:	eb 0f                	jmp    346b <fwp_gc_alloc_slow+0xcb>
    345c:	49 8d 04 cc          	lea    (%r12,%rcx,8),%rax
    3460:	48 83 c0 10          	add    $0x10,%rax
    3464:	4a 8d 0c 37          	lea    (%rdi,%r14,1),%rcx
    3468:	48 89 08             	mov    %rcx,(%rax)
    346b:	83 fd 01             	cmp    $0x1,%ebp
    346e:	4c 0f 44 f3          	cmove  %rbx,%r14
    3472:	31 f6                	xor    %esi,%esi
    3474:	4c 89 f2             	mov    %r14,%rdx
    3477:	5b                   	pop    %rbx
    3478:	41 5c                	pop    %r12
    347a:	41 5e                	pop    %r14
    347c:	41 5f                	pop    %r15
    347e:	5d                   	pop    %rbp
    347f:	e9 8c ed ff ff       	jmp    2210 <memset@plt>
    3484:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    348b:	00 00 00 00 00 

0000000000003490 <fwp_gc_init>:
    3490:	53                   	push   %rbx
    3491:	48 83 ec 10          	sub    $0x10,%rsp
    3495:	c7 05 e5 1d 01 00 01 	movl   $0x1,0x11de5(%rip)        # 15284 <fwp_gc+0xfec>
    349c:	00 00 00 
    349f:	0f 28 05 6a ab 00 00 	movaps 0xab6a(%rip),%xmm0        # e010 <_IO_stdin_used+0x10>
    34a6:	0f 11 05 33 19 01 00 	movups %xmm0,0x11933(%rip)        # 14de0 <fwp_gc+0xb48>
    34ad:	0f 28 05 6c ab 00 00 	movaps 0xab6c(%rip),%xmm0        # e020 <_IO_stdin_used+0x20>
    34b4:	0f 11 05 35 19 01 00 	movups %xmm0,0x11935(%rip)        # 14df0 <fwp_gc+0xb58>
    34bb:	0f 28 05 6e ab 00 00 	movaps 0xab6e(%rip),%xmm0        # e030 <_IO_stdin_used+0x30>
    34c2:	0f 11 05 37 19 01 00 	movups %xmm0,0x11937(%rip)        # 14e00 <fwp_gc+0xb68>
    34c9:	0f 28 05 70 ab 00 00 	movaps 0xab70(%rip),%xmm0        # e040 <_IO_stdin_used+0x40>
    34d0:	0f 11 05 39 19 01 00 	movups %xmm0,0x11939(%rip)        # 14e10 <fwp_gc+0xb78>
    34d7:	0f 28 05 72 ab 00 00 	movaps 0xab72(%rip),%xmm0        # e050 <_IO_stdin_used+0x50>
    34de:	0f 11 05 3b 19 01 00 	movups %xmm0,0x1193b(%rip)        # 14e20 <fwp_gc+0xb88>
    34e5:	0f 28 05 74 ab 00 00 	movaps 0xab74(%rip),%xmm0        # e060 <_IO_stdin_used+0x60>
    34ec:	0f 11 05 3d 19 01 00 	movups %xmm0,0x1193d(%rip)        # 14e30 <fwp_gc+0xb98>
    34f3:	0f 28 05 76 ab 00 00 	movaps 0xab76(%rip),%xmm0        # e070 <_IO_stdin_used+0x70>
    34fa:	0f 11 05 3f 19 01 00 	movups %xmm0,0x1193f(%rip)        # 14e40 <fwp_gc+0xba8>
    3501:	0f 28 05 78 ab 00 00 	movaps 0xab78(%rip),%xmm0        # e080 <_IO_stdin_used+0x80>
    3508:	0f 11 05 41 19 01 00 	movups %xmm0,0x11941(%rip)        # 14e50 <fwp_gc+0xbb8>
    350f:	0f 28 05 7a ab 00 00 	movaps 0xab7a(%rip),%xmm0        # e090 <_IO_stdin_used+0x90>
    3516:	0f 11 05 43 19 01 00 	movups %xmm0,0x11943(%rip)        # 14e60 <fwp_gc+0xbc8>
    351d:	0f 28 05 7c ab 00 00 	movaps 0xab7c(%rip),%xmm0        # e0a0 <_IO_stdin_used+0xa0>
    3524:	0f 11 05 45 19 01 00 	movups %xmm0,0x11945(%rip)        # 14e70 <fwp_gc+0xbd8>
    352b:	31 c9                	xor    %ecx,%ecx
    352d:	48 8d 05 64 0d 01 00 	lea    0x10d64(%rip),%rax        # 14298 <fwp_gc>
    3534:	31 d2                	xor    %edx,%edx
    3536:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    353d:	00 00 00 
    3540:	89 d6                	mov    %edx,%esi
    3542:	c1 e6 04             	shl    $0x4,%esi
    3545:	48 ff c9             	dec    %rcx
    3548:	48 89 cf             	mov    %rcx,%rdi
    354b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    3550:	48 89 f9             	mov    %rdi,%rcx
    3553:	48 ff c7             	inc    %rdi
    3556:	3b b4 88 4c 0b 00 00 	cmp    0xb4c(%rax,%rcx,4),%esi
    355d:	77 f1                	ja     3550 <fwp_gc_init+0xc0>
    355f:	40 88 bc 02 e8 0b 00 	mov    %dil,0xbe8(%rdx,%rax,1)
    3566:	00 
    3567:	48 89 d6             	mov    %rdx,%rsi
    356a:	48 83 ce 01          	or     $0x1,%rsi
    356e:	48 81 fe 01 04 00 00 	cmp    $0x401,%rsi
    3575:	74 26                	je     359d <fwp_gc_init+0x10d>
    3577:	89 f7                	mov    %esi,%edi
    3579:	c1 e7 04             	shl    $0x4,%edi
    357c:	0f 1f 40 00          	nopl   0x0(%rax)
    3580:	49 89 c8             	mov    %rcx,%r8
    3583:	48 ff c1             	inc    %rcx
    3586:	42 3b bc 80 4c 0b 00 	cmp    0xb4c(%rax,%r8,4),%edi
    358d:	00 
    358e:	77 f0                	ja     3580 <fwp_gc_init+0xf0>
    3590:	88 8c 06 e8 0b 00 00 	mov    %cl,0xbe8(%rsi,%rax,1)
    3597:	48 83 c2 02          	add    $0x2,%rdx
    359b:	eb a3                	jmp    3540 <fwp_gc_init+0xb0>
    359d:	48 b8 00 00 00 00 10 	movabs $0x1000000000,%rax
    35a4:	00 00 00 
    35a7:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    35ac:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    35b1:	e8 ba 04 00 00       	call   3a70 <fwp_gc_reserve>
    35b6:	48 85 c0             	test   %rax,%rax
    35b9:	0f 84 ab 01 00 00    	je     376a <fwp_gc_init+0x2da>
    35bf:	48 89 05 0a 1d 01 00 	mov    %rax,0x11d0a(%rip)        # 152d0 <fwp_gc+0x1038>
    35c6:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    35cb:	48 8d 91 00 00 01 00 	lea    0x10000(%rcx),%rdx
    35d2:	48 89 15 ff 1c 01 00 	mov    %rdx,0x11cff(%rip)        # 152d8 <fwp_gc+0x1040>
    35d9:	48 05 ff ff 00 00    	add    $0xffff,%rax
    35df:	48 25 00 00 ff ff    	and    $0xffffffffffff0000,%rax
    35e5:	48 89 05 dc 1c 01 00 	mov    %rax,0x11cdc(%rip)        # 152c8 <fwp_gc+0x1030>
    35ec:	48 c1 e9 10          	shr    $0x10,%rcx
    35f0:	48 89 0d f1 1c 01 00 	mov    %rcx,0x11cf1(%rip)        # 152e8 <fwp_gc+0x1050>
    35f7:	48 69 f1 28 12 00 00 	imul   $0x1228,%rcx,%rsi
    35fe:	48 89 35 13 1d 01 00 	mov    %rsi,0x11d13(%rip)        # 15318 <fwp_gc+0x1080>
    3605:	31 ff                	xor    %edi,%edi
    3607:	31 d2                	xor    %edx,%edx
    3609:	b9 22 40 00 00       	mov    $0x4022,%ecx
    360e:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    3614:	45 31 c9             	xor    %r9d,%r9d
    3617:	e8 74 eb ff ff       	call   2190 <mmap@plt>
    361c:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    3620:	0f 84 44 01 00 00    	je     376a <fwp_gc_init+0x2da>
    3626:	48 89 05 e3 1c 01 00 	mov    %rax,0x11ce3(%rip)        # 15310 <fwp_gc+0x1078>
    362d:	48 8d 3d 06 b1 00 00 	lea    0xb106(%rip),%rdi        # e73a <exec_in_fp0+0xea>
    3634:	e8 f7 e9 ff ff       	call   2030 <getenv@plt>
    3639:	48 85 c0             	test   %rax,%rax
    363c:	74 2e                	je     366c <fwp_gc_init+0x1dc>
    363e:	48 89 c3             	mov    %rax,%rbx
    3641:	48 8d 35 f9 b0 00 00 	lea    0xb0f9(%rip),%rsi        # e741 <exec_in_fp0+0xf1>
    3648:	48 89 c7             	mov    %rax,%rdi
    364b:	e8 80 ec ff ff       	call   22d0 <strcmp@plt>
    3650:	85 c0                	test   %eax,%eax
    3652:	74 1f                	je     3673 <fwp_gc_init+0x1e3>
    3654:	48 8d 35 20 bd 00 00 	lea    0xbd20(%rip),%rsi        # f37b <exec_in_fp0+0xd2b>
    365b:	48 89 df             	mov    %rbx,%rdi
    365e:	e8 6d ec ff ff       	call   22d0 <strcmp@plt>
    3663:	31 c9                	xor    %ecx,%ecx
    3665:	85 c0                	test   %eax,%eax
    3667:	0f 95 c1             	setne  %cl
    366a:	eb 09                	jmp    3675 <fwp_gc_init+0x1e5>
    366c:	b9 01 00 00 00       	mov    $0x1,%ecx
    3671:	eb 02                	jmp    3675 <fwp_gc_init+0x1e5>
    3673:	31 c9                	xor    %ecx,%ecx
    3675:	89 0d 0d 1c 01 00    	mov    %ecx,0x11c0d(%rip)        # 15288 <fwp_gc+0xff0>
    367b:	48 8d 3d c3 b0 00 00 	lea    0xb0c3(%rip),%rdi        # e745 <exec_in_fp0+0xf5>
    3682:	e8 a9 e9 ff ff       	call   2030 <getenv@plt>
    3687:	31 c9                	xor    %ecx,%ecx
    3689:	48 85 c0             	test   %rax,%rax
    368c:	74 1b                	je     36a9 <fwp_gc_init+0x219>
    368e:	80 38 00             	cmpb   $0x0,(%rax)
    3691:	74 16                	je     36a9 <fwp_gc_init+0x219>
    3693:	48 8d 35 e1 bc 00 00 	lea    0xbce1(%rip),%rsi        # f37b <exec_in_fp0+0xd2b>
    369a:	48 89 c7             	mov    %rax,%rdi
    369d:	e8 2e ec ff ff       	call   22d0 <strcmp@plt>
    36a2:	31 c9                	xor    %ecx,%ecx
    36a4:	85 c0                	test   %eax,%eax
    36a6:	0f 95 c1             	setne  %cl
    36a9:	89 0d e5 1b 01 00    	mov    %ecx,0x11be5(%rip)        # 15294 <fwp_gc+0xffc>
    36af:	48 8d 3d 84 b0 00 00 	lea    0xb084(%rip),%rdi        # e73a <exec_in_fp0+0xea>
    36b6:	e8 75 e9 ff ff       	call   2030 <getenv@plt>
    36bb:	48 85 c0             	test   %rax,%rax
    36be:	74 18                	je     36d8 <fwp_gc_init+0x248>
    36c0:	48 8d 35 8b b0 00 00 	lea    0xb08b(%rip),%rsi        # e752 <exec_in_fp0+0x102>
    36c7:	48 89 c7             	mov    %rax,%rdi
    36ca:	e8 01 ec ff ff       	call   22d0 <strcmp@plt>
    36cf:	31 c9                	xor    %ecx,%ecx
    36d1:	85 c0                	test   %eax,%eax
    36d3:	0f 95 c1             	setne  %cl
    36d6:	eb 05                	jmp    36dd <fwp_gc_init+0x24d>
    36d8:	b9 01 00 00 00       	mov    $0x1,%ecx
    36dd:	89 0d b5 1b 01 00    	mov    %ecx,0x11bb5(%rip)        # 15298 <fwp_gc+0x1000>
    36e3:	c7 05 b3 1b 01 00 01 	movl   $0x1,0x11bb3(%rip)        # 152a0 <fwp_gc+0x1008>
    36ea:	00 00 00 
    36ed:	48 8d 3d 63 b0 00 00 	lea    0xb063(%rip),%rdi        # e757 <exec_in_fp0+0x107>
    36f4:	e8 37 e9 ff ff       	call   2030 <getenv@plt>
    36f9:	31 c9                	xor    %ecx,%ecx
    36fb:	48 85 c0             	test   %rax,%rax
    36fe:	74 1b                	je     371b <fwp_gc_init+0x28b>
    3700:	80 38 00             	cmpb   $0x0,(%rax)
    3703:	74 16                	je     371b <fwp_gc_init+0x28b>
    3705:	48 8d 35 6f bc 00 00 	lea    0xbc6f(%rip),%rsi        # f37b <exec_in_fp0+0xd2b>
    370c:	48 89 c7             	mov    %rax,%rdi
    370f:	e8 bc eb ff ff       	call   22d0 <strcmp@plt>
    3714:	31 c9                	xor    %ecx,%ecx
    3716:	85 c0                	test   %eax,%eax
    3718:	0f 95 c1             	setne  %cl
    371b:	89 0d 7b 1b 01 00    	mov    %ecx,0x11b7b(%rip)        # 1529c <fwp_gc+0x1004>
    3721:	48 8d 3d 3d b0 00 00 	lea    0xb03d(%rip),%rdi        # e765 <exec_in_fp0+0x115>
    3728:	e8 03 e9 ff ff       	call   2030 <getenv@plt>
    372d:	48 85 c0             	test   %rax,%rax
    3730:	74 0a                	je     373c <fwp_gc_init+0x2ac>
    3732:	48 89 c7             	mov    %rax,%rdi
    3735:	e8 c6 ec ff ff       	call   2400 <atol@plt>
    373a:	eb 02                	jmp    373e <fwp_gc_init+0x2ae>
    373c:	31 c0                	xor    %eax,%eax
    373e:	31 c9                	xor    %ecx,%ecx
    3740:	48 85 c0             	test   %rax,%rax
    3743:	48 0f 4f c8          	cmovg  %rax,%rcx
    3747:	48 89 0d 6a 1b 01 00 	mov    %rcx,0x11b6a(%rip)        # 152b8 <fwp_gc+0x1020>
    374e:	48 c7 05 4f 1d 01 00 	movq   $0x800000,0x11d4f(%rip)        # 154a8 <fwp_gc+0x1210>
    3755:	00 00 80 00 
    3759:	48 c7 05 34 0b 01 00 	movq   $0x800000,0x10b34(%rip)        # 14298 <fwp_gc>
    3760:	00 00 80 00 
    3764:	48 83 c4 10          	add    $0x10,%rsp
    3768:	5b                   	pop    %rbx
    3769:	c3                   	ret
    376a:	e8 71 03 00 00       	call   3ae0 <fwp_gc_oom>
    376f:	90                   	nop

0000000000003770 <fwp_gc_alloc_big>:
    3770:	55                   	push   %rbp
    3771:	41 57                	push   %r15
    3773:	41 56                	push   %r14
    3775:	41 54                	push   %r12
    3777:	53                   	push   %rbx
    3778:	48 b8 01 00 00 00 00 	movabs $0x4000000000000001,%rax
    377f:	00 00 40 
    3782:	48 39 c7             	cmp    %rax,%rdi
    3785:	0f 83 28 01 00 00    	jae    38b3 <fwp_gc_alloc_big+0x143>
    378b:	89 f5                	mov    %esi,%ebp
    378d:	48 89 fb             	mov    %rdi,%rbx
    3790:	48 29 3d 01 0b 01 00 	sub    %rdi,0x10b01(%rip)        # 14298 <fwp_gc>
    3797:	79 05                	jns    379e <fwp_gc_alloc_big+0x2e>
    3799:	e8 22 01 00 00       	call   38c0 <fwp_gc_spent>
    379e:	4c 8d bb ff ff 00 00 	lea    0xffff(%rbx),%r15
    37a5:	49 c1 ef 10          	shr    $0x10,%r15
    37a9:	4c 89 ff             	mov    %r15,%rdi
    37ac:	e8 5f 03 00 00       	call   3b10 <fwp_gc_chunks>
    37b1:	49 89 c6             	mov    %rax,%r14
    37b4:	48 8b 05 55 1b 01 00 	mov    0x11b55(%rip),%rax        # 15310 <fwp_gc+0x1078>
    37bb:	4d 69 e6 28 12 00 00 	imul   $0x1228,%r14,%r12
    37c2:	42 c6 04 20 02       	movb   $0x2,(%rax,%r12,1)
    37c7:	42 88 6c 20 01       	mov    %bpl,0x1(%rax,%r12,1)
    37cc:	66 42 c7 44 20 03 00 	movw   $0x100,0x3(%rax,%r12,1)
    37d3:	01 
    37d4:	46 89 7c 20 10       	mov    %r15d,0x10(%rax,%r12,1)
    37d9:	4a 89 5c 20 18       	mov    %rbx,0x18(%rax,%r12,1)
    37de:	4a 8d 3c 20          	lea    (%rax,%r12,1),%rdi
    37e2:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    37e9:	e8 72 f7 ff ff       	call   2f60 <fwp_rc_clear_slot>
    37ee:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    37f5:	0f 82 9b 00 00 00    	jb     3896 <fwp_gc_alloc_big+0x126>
    37fb:	49 83 ff 03          	cmp    $0x3,%r15
    37ff:	b9 02 00 00 00       	mov    $0x2,%ecx
    3804:	49 0f 43 cf          	cmovae %r15,%rcx
    3808:	48 8b 05 01 1b 01 00 	mov    0x11b01(%rip),%rax        # 15310 <fwp_gc+0x1078>
    380f:	48 ff c9             	dec    %rcx
    3812:	ba 01 00 00 00       	mov    $0x1,%edx
    3817:	48 81 fb 01 00 02 00 	cmp    $0x20001,%rbx
    381e:	72 59                	jb     3879 <fwp_gc_alloc_big+0x109>
    3820:	49 8d 34 04          	lea    (%r12,%rax,1),%rsi
    3824:	48 81 c6 60 24 00 00 	add    $0x2460,%rsi
    382b:	48 89 cf             	mov    %rcx,%rdi
    382e:	48 83 e7 fe          	and    $0xfffffffffffffffe,%rdi
    3832:	48 f7 df             	neg    %rdi
    3835:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    383c:	00 00 00 00 
    3840:	c6 86 c8 ed ff ff 03 	movb   $0x3,-0x1238(%rsi)
    3847:	c6 86 cc ed ff ff 01 	movb   $0x1,-0x1234(%rsi)
    384e:	44 89 b6 d8 ed ff ff 	mov    %r14d,-0x1228(%rsi)
    3855:	c6 46 f0 03          	movb   $0x3,-0x10(%rsi)
    3859:	c6 46 f4 01          	movb   $0x1,-0xc(%rsi)
    385d:	44 89 36             	mov    %r14d,(%rsi)
    3860:	48 81 c6 50 24 00 00 	add    $0x2450,%rsi
    3867:	4c 8d 04 17          	lea    (%rdi,%rdx,1),%r8
    386b:	49 83 c0 02          	add    $0x2,%r8
    386f:	48 83 c2 02          	add    $0x2,%rdx
    3873:	49 83 f8 01          	cmp    $0x1,%r8
    3877:	75 c7                	jne    3840 <fwp_gc_alloc_big+0xd0>
    3879:	f6 c1 01             	test   $0x1,%cl
    387c:	74 18                	je     3896 <fwp_gc_alloc_big+0x126>
    387e:	4c 01 e0             	add    %r12,%rax
    3881:	48 69 ca 28 12 00 00 	imul   $0x1228,%rdx,%rcx
    3888:	c6 04 08 03          	movb   $0x3,(%rax,%rcx,1)
    388c:	c6 44 08 04 01       	movb   $0x1,0x4(%rax,%rcx,1)
    3891:	44 89 74 08 10       	mov    %r14d,0x10(%rax,%rcx,1)
    3896:	4c 89 f7             	mov    %r14,%rdi
    3899:	e8 e2 f6 ff ff       	call   2f80 <fwp_gc_chunk_addr>
    389e:	48 89 c7             	mov    %rax,%rdi
    38a1:	31 f6                	xor    %esi,%esi
    38a3:	48 89 da             	mov    %rbx,%rdx
    38a6:	5b                   	pop    %rbx
    38a7:	41 5c                	pop    %r12
    38a9:	41 5e                	pop    %r14
    38ab:	41 5f                	pop    %r15
    38ad:	5d                   	pop    %rbp
    38ae:	e9 5d e9 ff ff       	jmp    2210 <memset@plt>
    38b3:	e8 28 02 00 00       	call   3ae0 <fwp_gc_oom>
    38b8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    38bf:	00 

00000000000038c0 <fwp_gc_spent>:
    38c0:	50                   	push   %rax
    38c1:	83 3d bc 19 01 00 00 	cmpl   $0x0,0x119bc(%rip)        # 15284 <fwp_gc+0xfec>
    38c8:	75 05                	jne    38cf <fwp_gc_spent+0xf>
    38ca:	e8 c1 fb ff ff       	call   3490 <fwp_gc_init>
    38cf:	8b 05 b7 19 01 00    	mov    0x119b7(%rip),%eax        # 1528c <fwp_gc+0xff4>
    38d5:	85 c0                	test   %eax,%eax
    38d7:	74 6d                	je     3946 <fwp_gc_spent+0x86>
    38d9:	48 8b 0d d8 19 01 00 	mov    0x119d8(%rip),%rcx        # 152b8 <fwp_gc+0x1020>
    38e0:	48 85 c9             	test   %rcx,%rcx
    38e3:	74 61                	je     3946 <fwp_gc_spent+0x86>
    38e5:	48 8b 05 d4 19 01 00 	mov    0x119d4(%rip),%rax        # 152c0 <fwp_gc+0x1028>
    38ec:	48 ff c0             	inc    %rax
    38ef:	48 89 05 ca 19 01 00 	mov    %rax,0x119ca(%rip)        # 152c0 <fwp_gc+0x1028>
    38f6:	48 39 c8             	cmp    %rcx,%rax
    38f9:	7c 10                	jl     390b <fwp_gc_spent+0x4b>
    38fb:	48 c7 05 ba 19 01 00 	movq   $0x0,0x119ba(%rip)        # 152c0 <fwp_gc+0x1028>
    3902:	00 00 00 00 
    3906:	e8 85 03 00 00       	call   3c90 <fwp_gc_collect>
    390b:	48 8b 05 96 1b 01 00 	mov    0x11b96(%rip),%rax        # 154a8 <fwp_gc+0x1210>
    3912:	48 2b 05 7f 09 01 00 	sub    0x1097f(%rip),%rax        # 14298 <fwp_gc>
    3919:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    391e:	f2 0f 58 05 5a 1b 01 	addsd  0x11b5a(%rip),%xmm0        # 15480 <fwp_gc+0x11e8>
    3925:	00 
    3926:	f2 0f 11 05 52 1b 01 	movsd  %xmm0,0x11b52(%rip)        # 15480 <fwp_gc+0x11e8>
    392d:	00 
    392e:	48 c7 05 6f 1b 01 00 	movq   $0x0,0x11b6f(%rip)        # 154a8 <fwp_gc+0x1210>
    3935:	00 00 00 00 
    3939:	48 c7 05 54 09 01 00 	movq   $0x0,0x10954(%rip)        # 14298 <fwp_gc>
    3940:	00 00 00 00 
    3944:	58                   	pop    %rax
    3945:	c3                   	ret
    3946:	85 c0                	test   %eax,%eax
    3948:	74 06                	je     3950 <fwp_gc_spent+0x90>
    394a:	58                   	pop    %rax
    394b:	e9 40 03 00 00       	jmp    3c90 <fwp_gc_collect>
    3950:	48 8b 05 51 1b 01 00 	mov    0x11b51(%rip),%rax        # 154a8 <fwp_gc+0x1210>
    3957:	48 2b 05 3a 09 01 00 	sub    0x1093a(%rip),%rax        # 14298 <fwp_gc>
    395e:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    3963:	f2 0f 58 05 15 1b 01 	addsd  0x11b15(%rip),%xmm0        # 15480 <fwp_gc+0x11e8>
    396a:	00 
    396b:	f2 0f 11 05 0d 1b 01 	movsd  %xmm0,0x11b0d(%rip)        # 15480 <fwp_gc+0x11e8>
    3972:	00 
    3973:	48 c7 05 2a 1b 01 00 	movq   $0x800000,0x11b2a(%rip)        # 154a8 <fwp_gc+0x1210>
    397a:	00 00 80 00 
    397e:	48 c7 05 0f 09 01 00 	movq   $0x800000,0x1090f(%rip)        # 14298 <fwp_gc>
    3985:	00 00 80 00 
    3989:	58                   	pop    %rax
    398a:	c3                   	ret
    398b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000003990 <fwp_gc_refill>:
    3990:	55                   	push   %rbp
    3991:	41 57                	push   %r15
    3993:	41 56                	push   %r14
    3995:	53                   	push   %rbx
    3996:	50                   	push   %rax
    3997:	89 d5                	mov    %edx,%ebp
    3999:	41 89 f7             	mov    %esi,%r15d
    399c:	48 89 fb             	mov    %rdi,%rbx
    399f:	bf 01 00 00 00       	mov    $0x1,%edi
    39a4:	e8 67 01 00 00       	call   3b10 <fwp_gc_chunks>
    39a9:	49 89 c6             	mov    %rax,%r14
    39ac:	48 8b 0d 5d 19 01 00 	mov    0x1195d(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    39b3:	48 8d 05 de 08 01 00 	lea    0x108de(%rip),%rax        # 14298 <fwp_gc>
    39ba:	49 69 f6 28 12 00 00 	imul   $0x1228,%r14,%rsi
    39c1:	48 8d 3c 31          	lea    (%rcx,%rsi,1),%rdi
    39c5:	c6 04 31 01          	movb   $0x1,(%rcx,%rsi,1)
    39c9:	40 88 6c 31 01       	mov    %bpl,0x1(%rcx,%rsi,1)
    39ce:	44 88 7c 31 02       	mov    %r15b,0x2(%rcx,%rsi,1)
    39d3:	c6 44 31 04 01       	movb   $0x1,0x4(%rcx,%rsi,1)
    39d8:	44 89 fa             	mov    %r15d,%edx
    39db:	44 8b 84 90 48 0b 00 	mov    0xb48(%rax,%rdx,4),%r8d
    39e2:	00 
    39e3:	44 89 44 31 08       	mov    %r8d,0x8(%rcx,%rsi,1)
    39e8:	b8 00 00 01 00       	mov    $0x10000,%eax
    39ed:	31 d2                	xor    %edx,%edx
    39ef:	41 f7 f0             	div    %r8d
    39f2:	89 44 31 0c          	mov    %eax,0xc(%rcx,%rsi,1)
    39f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    39fb:	4c 01 c0             	add    %r8,%rax
    39fe:	48 0f ba e0 20       	bt     $0x20,%rax
    3a03:	73 07                	jae    3a0c <fwp_gc_refill+0x7c>
    3a05:	31 d2                	xor    %edx,%edx
    3a07:	49 f7 f0             	div    %r8
    3a0a:	eb 05                	jmp    3a11 <fwp_gc_refill+0x81>
    3a0c:	31 d2                	xor    %edx,%edx
    3a0e:	41 f7 f0             	div    %r8d
    3a11:	4c 8d 3c 31          	lea    (%rcx,%rsi,1),%r15
    3a15:	49 83 c7 08          	add    $0x8,%r15
    3a19:	89 44 31 20          	mov    %eax,0x20(%rcx,%rsi,1)
    3a1d:	e8 4e 15 00 00       	call   4f70 <fwp_rc_clear_chunk>
    3a22:	4c 89 f7             	mov    %r14,%rdi
    3a25:	e8 56 f5 ff ff       	call   2f80 <fwp_gc_chunk_addr>
    3a2a:	83 3d 6b 18 01 00 00 	cmpl   $0x0,0x1186b(%rip)        # 1529c <fwp_gc+0x1004>
    3a31:	74 15                	je     3a48 <fwp_gc_refill+0xb8>
    3a33:	ba 00 00 01 00       	mov    $0x10000,%edx
    3a38:	48 89 c7             	mov    %rax,%rdi
    3a3b:	31 f6                	xor    %esi,%esi
    3a3d:	49 89 c6             	mov    %rax,%r14
    3a40:	e8 cb e7 ff ff       	call   2210 <memset@plt>
    3a45:	4c 89 f0             	mov    %r14,%rax
    3a48:	41 8b 0f             	mov    (%r15),%ecx
    3a4b:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    3a4f:	48 89 53 08          	mov    %rdx,0x8(%rbx)
    3a53:	41 8b 57 04          	mov    0x4(%r15),%edx
    3a57:	48 0f af d1          	imul   %rcx,%rdx
    3a5b:	48 01 c2             	add    %rax,%rdx
    3a5e:	48 89 53 10          	mov    %rdx,0x10(%rbx)
    3a62:	48 83 c4 08          	add    $0x8,%rsp
    3a66:	5b                   	pop    %rbx
    3a67:	41 5e                	pop    %r14
    3a69:	41 5f                	pop    %r15
    3a6b:	5d                   	pop    %rbp
    3a6c:	c3                   	ret
    3a6d:	0f 1f 00             	nopl   (%rax)

0000000000003a70 <fwp_gc_reserve>:
    3a70:	41 56                	push   %r14
    3a72:	53                   	push   %rbx
    3a73:	50                   	push   %rax
    3a74:	4c 8b 37             	mov    (%rdi),%r14
    3a77:	49 81 fe 00 00 00 10 	cmp    $0x10000000,%r14
    3a7e:	72 47                	jb     3ac7 <fwp_gc_reserve+0x57>
    3a80:	48 89 fb             	mov    %rdi,%rbx
    3a83:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3a8a:	84 00 00 00 00 00 
    3a90:	49 8d b6 00 00 01 00 	lea    0x10000(%r14),%rsi
    3a97:	31 ff                	xor    %edi,%edi
    3a99:	31 d2                	xor    %edx,%edx
    3a9b:	b9 22 40 00 00       	mov    $0x4022,%ecx
    3aa0:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    3aa6:	45 31 c9             	xor    %r9d,%r9d
    3aa9:	e8 e2 e6 ff ff       	call   2190 <mmap@plt>
    3aae:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    3ab2:	75 17                	jne    3acb <fwp_gc_reserve+0x5b>
    3ab4:	4c 89 f0             	mov    %r14,%rax
    3ab7:	48 c1 e8 02          	shr    $0x2,%rax
    3abb:	49 81 fe ff ff ff 3f 	cmp    $0x3fffffff,%r14
    3ac2:	49 89 c6             	mov    %rax,%r14
    3ac5:	77 c9                	ja     3a90 <fwp_gc_reserve+0x20>
    3ac7:	31 c0                	xor    %eax,%eax
    3ac9:	eb 03                	jmp    3ace <fwp_gc_reserve+0x5e>
    3acb:	4c 89 33             	mov    %r14,(%rbx)
    3ace:	48 83 c4 08          	add    $0x8,%rsp
    3ad2:	5b                   	pop    %rbx
    3ad3:	41 5e                	pop    %r14
    3ad5:	c3                   	ret
    3ad6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    3add:	00 00 00 

0000000000003ae0 <fwp_gc_oom>:
    3ae0:	50                   	push   %rax
    3ae1:	48 8b 05 f8 04 01 00 	mov    0x104f8(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    3ae8:	48 8b 08             	mov    (%rax),%rcx
    3aeb:	48 8d 3d 81 ac 00 00 	lea    0xac81(%rip),%rdi        # e773 <exec_in_fp0+0x123>
    3af2:	be 13 00 00 00       	mov    $0x13,%esi
    3af7:	ba 01 00 00 00       	mov    $0x1,%edx
    3afc:	e8 9f e9 ff ff       	call   24a0 <fwrite@plt>
    3b01:	bf 66 00 00 00       	mov    $0x66,%edi
    3b06:	e8 75 e9 ff ff       	call   2480 <exit@plt>
    3b0b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000003b10 <fwp_gc_chunks>:
    3b10:	41 56                	push   %r14
    3b12:	53                   	push   %rbx
    3b13:	50                   	push   %rax
    3b14:	48 89 fb             	mov    %rdi,%rbx
    3b17:	31 d2                	xor    %edx,%edx
    3b19:	48 83 ff 01          	cmp    $0x1,%rdi
    3b1d:	0f 95 c2             	setne  %dl
    3b20:	48 8d 0d 71 07 01 00 	lea    0x10771(%rip),%rcx        # 14298 <fwp_gc>
    3b27:	48 8b 84 d1 68 10 00 	mov    0x1068(%rcx,%rdx,8),%rax
    3b2e:	00 
    3b2f:	4c 8b 35 ba 17 01 00 	mov    0x117ba(%rip),%r14        # 152f0 <fwp_gc+0x1058>
    3b36:	48 89 c7             	mov    %rax,%rdi
    3b39:	4c 29 f7             	sub    %r14,%rdi
    3b3c:	73 61                	jae    3b9f <fwp_gc_chunks+0x8f>
    3b3e:	48 8d 34 d5 68 10 00 	lea    0x1068(,%rdx,8),%rsi
    3b45:	00 
    3b46:	4c 69 c0 28 12 00 00 	imul   $0x1228,%rax,%r8
    3b4d:	4c 03 05 bc 17 01 00 	add    0x117bc(%rip),%r8        # 15310 <fwp_gc+0x1078>
    3b54:	31 d2                	xor    %edx,%edx
    3b56:	45 31 c9             	xor    %r9d,%r9d
    3b59:	eb 17                	jmp    3b72 <fwp_gc_chunks+0x62>
    3b5b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    3b60:	45 31 c9             	xor    %r9d,%r9d
    3b63:	48 ff ca             	dec    %rdx
    3b66:	49 81 c0 28 12 00 00 	add    $0x1228,%r8
    3b6d:	48 39 d7             	cmp    %rdx,%rdi
    3b70:	74 30                	je     3ba2 <fwp_gc_chunks+0x92>
    3b72:	41 80 38 00          	cmpb   $0x0,(%r8)
    3b76:	75 e8                	jne    3b60 <fwp_gc_chunks+0x50>
    3b78:	49 ff c1             	inc    %r9
    3b7b:	49 39 d9             	cmp    %rbx,%r9
    3b7e:	75 e3                	jne    3b63 <fwp_gc_chunks+0x53>
    3b80:	48 ff c0             	inc    %rax
    3b83:	48 89 c7             	mov    %rax,%rdi
    3b86:	48 29 d7             	sub    %rdx,%rdi
    3b89:	48 89 3c 0e          	mov    %rdi,(%rsi,%rcx,1)
    3b8d:	48 29 1d e4 18 01 00 	sub    %rbx,0x118e4(%rip)        # 15478 <fwp_gc+0x11e0>
    3b94:	48 29 d8             	sub    %rbx,%rax
    3b97:	48 29 d0             	sub    %rdx,%rax
    3b9a:	49 89 c6             	mov    %rax,%r14
    3b9d:	eb 33                	jmp    3bd2 <fwp_gc_chunks+0xc2>
    3b9f:	45 31 c9             	xor    %r9d,%r9d
    3ba2:	4d 29 ce             	sub    %r9,%r14
    3ba5:	4c 29 0d cc 18 01 00 	sub    %r9,0x118cc(%rip)        # 15478 <fwp_gc+0x11e0>
    3bac:	4c 01 f3             	add    %r14,%rbx
    3baf:	48 89 df             	mov    %rbx,%rdi
    3bb2:	e8 29 00 00 00       	call   3be0 <fwp_gc_commit>
    3bb7:	48 89 1d 32 17 01 00 	mov    %rbx,0x11732(%rip)        # 152f0 <fwp_gc+0x1058>
    3bbe:	48 c1 e3 10          	shl    $0x10,%rbx
    3bc2:	48 3b 1d 17 17 01 00 	cmp    0x11717(%rip),%rbx        # 152e0 <fwp_gc+0x1048>
    3bc9:	76 07                	jbe    3bd2 <fwp_gc_chunks+0xc2>
    3bcb:	48 89 1d 0e 17 01 00 	mov    %rbx,0x1170e(%rip)        # 152e0 <fwp_gc+0x1048>
    3bd2:	4c 89 f0             	mov    %r14,%rax
    3bd5:	48 83 c4 08          	add    $0x8,%rsp
    3bd9:	5b                   	pop    %rbx
    3bda:	41 5e                	pop    %r14
    3bdc:	c3                   	ret
    3bdd:	0f 1f 00             	nopl   (%rax)

0000000000003be0 <fwp_gc_commit>:
    3be0:	53                   	push   %rbx
    3be1:	48 89 fb             	mov    %rdi,%rbx
    3be4:	48 8b 3d 0d 17 01 00 	mov    0x1170d(%rip),%rdi        # 152f8 <fwp_gc+0x1060>
    3beb:	48 39 df             	cmp    %rbx,%rdi
    3bee:	0f 83 8f 00 00 00    	jae    3c83 <fwp_gc_commit+0xa3>
    3bf4:	48 8b 05 ed 16 01 00 	mov    0x116ed(%rip),%rax        # 152e8 <fwp_gc+0x1050>
    3bfb:	48 39 d8             	cmp    %rbx,%rax
    3bfe:	0f 82 81 00 00 00    	jb     3c85 <fwp_gc_commit+0xa5>
    3c04:	48 83 c3 40          	add    $0x40,%rbx
    3c08:	48 39 c3             	cmp    %rax,%rbx
    3c0b:	48 0f 43 d8          	cmovae %rax,%rbx
    3c0f:	48 89 de             	mov    %rbx,%rsi
    3c12:	48 29 fe             	sub    %rdi,%rsi
    3c15:	48 c1 e7 10          	shl    $0x10,%rdi
    3c19:	48 03 3d a8 16 01 00 	add    0x116a8(%rip),%rdi        # 152c8 <fwp_gc+0x1030>
    3c20:	48 c1 e6 10          	shl    $0x10,%rsi
    3c24:	ba 03 00 00 00       	mov    $0x3,%edx
    3c29:	e8 e2 e7 ff ff       	call   2410 <mprotect@plt>
    3c2e:	85 c0                	test   %eax,%eax
    3c30:	75 53                	jne    3c85 <fwp_gc_commit+0xa5>
    3c32:	bf 1e 00 00 00       	mov    $0x1e,%edi
    3c37:	e8 f4 e7 ff ff       	call   2430 <sysconf@plt>
    3c3c:	48 8b 0d cd 16 01 00 	mov    0x116cd(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    3c43:	48 69 3d aa 16 01 00 	imul   $0x1228,0x116aa(%rip),%rdi        # 152f8 <fwp_gc+0x1060>
    3c4a:	28 12 00 00 
    3c4e:	48 01 cf             	add    %rcx,%rdi
    3c51:	48 69 d3 28 12 00 00 	imul   $0x1228,%rbx,%rdx
    3c58:	48 01 ca             	add    %rcx,%rdx
    3c5b:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    3c5f:	48 ff ce             	dec    %rsi
    3c62:	48 f7 d8             	neg    %rax
    3c65:	48 21 c7             	and    %rax,%rdi
    3c68:	48 21 c6             	and    %rax,%rsi
    3c6b:	48 29 fe             	sub    %rdi,%rsi
    3c6e:	ba 03 00 00 00       	mov    $0x3,%edx
    3c73:	e8 98 e7 ff ff       	call   2410 <mprotect@plt>
    3c78:	85 c0                	test   %eax,%eax
    3c7a:	75 09                	jne    3c85 <fwp_gc_commit+0xa5>
    3c7c:	48 89 1d 75 16 01 00 	mov    %rbx,0x11675(%rip)        # 152f8 <fwp_gc+0x1060>
    3c83:	5b                   	pop    %rbx
    3c84:	c3                   	ret
    3c85:	e8 56 fe ff ff       	call   3ae0 <fwp_gc_oom>
    3c8a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000003c90 <fwp_gc_collect>:
    3c90:	83 3d f9 15 01 00 00 	cmpl   $0x0,0x115f9(%rip)        # 15290 <fwp_gc+0xff8>
    3c97:	74 01                	je     3c9a <fwp_gc_collect+0xa>
    3c99:	c3                   	ret
    3c9a:	55                   	push   %rbp
    3c9b:	48 89 e5             	mov    %rsp,%rbp
    3c9e:	41 57                	push   %r15
    3ca0:	41 56                	push   %r14
    3ca2:	41 55                	push   %r13
    3ca4:	41 54                	push   %r12
    3ca6:	53                   	push   %rbx
    3ca7:	48 81 ec e8 00 00 00 	sub    $0xe8,%rsp
    3cae:	c7 05 d8 15 01 00 01 	movl   $0x1,0x115d8(%rip)        # 15290 <fwp_gc+0xff8>
    3cb5:	00 00 00 
    3cb8:	48 8d 75 b8          	lea    -0x48(%rbp),%rsi
    3cbc:	bf 01 00 00 00       	mov    $0x1,%edi
    3cc1:	e8 6a e4 ff ff       	call   2130 <clock_gettime@plt>
    3cc6:	48 8b 05 db 17 01 00 	mov    0x117db(%rip),%rax        # 154a8 <fwp_gc+0x1210>
    3ccd:	48 2b 05 c4 05 01 00 	sub    0x105c4(%rip),%rax        # 14298 <fwp_gc>
    3cd4:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    3cd9:	f2 0f 58 05 9f 17 01 	addsd  0x1179f(%rip),%xmm0        # 15480 <fwp_gc+0x11e8>
    3ce0:	00 
    3ce1:	f2 0f 11 05 97 17 01 	movsd  %xmm0,0x11797(%rip)        # 15480 <fwp_gc+0x11e8>
    3ce8:	00 
    3ce9:	83 3d a8 15 01 00 00 	cmpl   $0x0,0x115a8(%rip)        # 15298 <fwp_gc+0x1000>
    3cf0:	0f 94 c0             	sete   %al
    3cf3:	83 3d a6 15 01 00 00 	cmpl   $0x0,0x115a6(%rip)        # 152a0 <fwp_gc+0x1008>
    3cfa:	0f 95 c3             	setne  %bl
    3cfd:	08 c3                	or     %al,%bl
    3cff:	80 fb 01             	cmp    $0x1,%bl
    3d02:	75 3e                	jne    3d42 <fwp_gc_collect+0xb2>
    3d04:	e8 b7 01 00 00       	call   3ec0 <fwp_gc_clear_marks>
    3d09:	48 8d bd f0 fe ff ff 	lea    -0x110(%rbp),%rdi
    3d10:	e8 9b e5 ff ff       	call   22b0 <_setjmp@plt>
    3d15:	48 c7 05 78 17 01 00 	movq   $0x0,0x11778(%rip)        # 15498 <fwp_gc+0x1200>
    3d1c:	00 00 00 00 
    3d20:	e8 1b 02 00 00       	call   3f40 <fwp_gc_mark_all>
    3d25:	e8 36 07 00 00       	call   4460 <fwp_gc_finalize>
    3d2a:	e8 c1 07 00 00       	call   44f0 <fwp_gc_sweep>
    3d2f:	48 8b 05 3a 17 01 00 	mov    0x1173a(%rip),%rax        # 15470 <fwp_gc+0x11d8>
    3d36:	48 ff c0             	inc    %rax
    3d39:	48 89 05 30 17 01 00 	mov    %rax,0x11730(%rip)        # 15470 <fwp_gc+0x11d8>
    3d40:	eb 51                	jmp    3d93 <fwp_gc_collect+0x103>
    3d42:	48 8d bd f0 fe ff ff 	lea    -0x110(%rbp),%rdi
    3d49:	e8 62 e5 ff ff       	call   22b0 <_setjmp@plt>
    3d4e:	48 c7 05 3f 17 01 00 	movq   $0x0,0x1173f(%rip)        # 15498 <fwp_gc+0x1200>
    3d55:	00 00 00 00 
    3d59:	e8 e2 01 00 00       	call   3f40 <fwp_gc_mark_all>
    3d5e:	e8 fd 01 00 00       	call   3f60 <fwp_gc_scan_old_filled>
    3d63:	83 3d 32 15 01 00 00 	cmpl   $0x0,0x11532(%rip)        # 1529c <fwp_gc+0x1004>
    3d6a:	74 05                	je     3d71 <fwp_gc_collect+0xe1>
    3d6c:	e8 2f 03 00 00       	call   40a0 <fwp_gc_verify_minor>
    3d71:	e8 ea 06 00 00       	call   4460 <fwp_gc_finalize>
    3d76:	e8 75 07 00 00       	call   44f0 <fwp_gc_sweep>
    3d7b:	48 8b 05 ee 16 01 00 	mov    0x116ee(%rip),%rax        # 15470 <fwp_gc+0x11d8>
    3d82:	48 ff c0             	inc    %rax
    3d85:	48 89 05 e4 16 01 00 	mov    %rax,0x116e4(%rip)        # 15470 <fwp_gc+0x11d8>
    3d8c:	48 ff 05 1d 15 01 00 	incq   0x1151d(%rip)        # 152b0 <fwp_gc+0x1018>
    3d93:	48 89 c1             	mov    %rax,%rcx
    3d96:	48 8b 05 c3 16 01 00 	mov    0x116c3(%rip),%rax        # 15460 <fwp_gc+0x11c8>
    3d9d:	48 3b 05 c4 16 01 00 	cmp    0x116c4(%rip),%rax        # 15468 <fwp_gc+0x11d0>
    3da4:	76 07                	jbe    3dad <fwp_gc_collect+0x11d>
    3da6:	48 89 05 bb 16 01 00 	mov    %rax,0x116bb(%rip)        # 15468 <fwp_gc+0x11d0>
    3dad:	84 db                	test   %bl,%bl
    3daf:	74 0b                	je     3dbc <fwp_gc_collect+0x12c>
    3db1:	48 89 05 f0 14 01 00 	mov    %rax,0x114f0(%rip)        # 152a8 <fwp_gc+0x1010>
    3db8:	31 d2                	xor    %edx,%edx
    3dba:	eb 2d                	jmp    3de9 <fwp_gc_collect+0x159>
    3dbc:	48 8b 15 e5 14 01 00 	mov    0x114e5(%rip),%rdx        # 152a8 <fwp_gc+0x1010>
    3dc3:	48 89 d6             	mov    %rdx,%rsi
    3dc6:	48 d1 ee             	shr    $1,%rsi
    3dc9:	48 01 d6             	add    %rdx,%rsi
    3dcc:	48 81 fe 01 00 00 01 	cmp    $0x1000001,%rsi
    3dd3:	ba 00 00 00 01       	mov    $0x1000000,%edx
    3dd8:	48 0f 43 d6          	cmovae %rsi,%rdx
    3ddc:	31 f6                	xor    %esi,%esi
    3dde:	48 39 d0             	cmp    %rdx,%rax
    3de1:	0f 97 c2             	seta   %dl
    3de4:	40 88 d6             	mov    %dl,%sil
    3de7:	89 f2                	mov    %esi,%edx
    3de9:	f6 c1 07             	test   $0x7,%cl
    3dec:	b9 01 00 00 00       	mov    $0x1,%ecx
    3df1:	0f 45 ca             	cmovne %edx,%ecx
    3df4:	48 83 3d bc 14 01 00 	cmpq   $0x0,0x114bc(%rip)        # 152b8 <fwp_gc+0x1020>
    3dfb:	00 
    3dfc:	0f 44 ca             	cmove  %edx,%ecx
    3dff:	89 0d 9b 14 01 00    	mov    %ecx,0x1149b(%rip)        # 152a0 <fwp_gc+0x1008>
    3e05:	83 3d 8c 14 01 00 00 	cmpl   $0x0,0x1148c(%rip)        # 15298 <fwp_gc+0x1000>
    3e0c:	0f 94 c1             	sete   %cl
    3e0f:	48 d3 e0             	shl    %cl,%rax
    3e12:	f2 48 0f 2c 0d 7d 16 	cvttsd2si 0x1167d(%rip),%rcx        # 15498 <fwp_gc+0x1200>
    3e19:	01 00 
    3e1b:	48 01 c1             	add    %rax,%rcx
    3e1e:	48 81 f9 01 00 80 00 	cmp    $0x800001,%rcx
    3e25:	b8 00 00 80 00       	mov    $0x800000,%eax
    3e2a:	48 0f 4d c1          	cmovge %rcx,%rax
    3e2e:	48 89 05 73 16 01 00 	mov    %rax,0x11673(%rip)        # 154a8 <fwp_gc+0x1210>
    3e35:	48 89 05 5c 04 01 00 	mov    %rax,0x1045c(%rip)        # 14298 <fwp_gc>
    3e3c:	48 8d 75 c8          	lea    -0x38(%rbp),%rsi
    3e40:	bf 01 00 00 00       	mov    $0x1,%edi
    3e45:	e8 e6 e2 ff ff       	call   2130 <clock_gettime@plt>
    3e4a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    3e4e:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
    3e52:	48 2b 45 b8          	sub    -0x48(%rbp),%rax
    3e56:	f2 48 0f 2a c8       	cvtsi2sd %rax,%xmm1
    3e5b:	f2 0f 59 0d ed a2 00 	mulsd  0xa2ed(%rip),%xmm1        # e150 <_IO_stdin_used+0x150>
    3e62:	00 
    3e63:	48 2b 4d c0          	sub    -0x40(%rbp),%rcx
    3e67:	0f 57 c0             	xorps  %xmm0,%xmm0
    3e6a:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    3e6f:	f2 0f 5e 05 e1 a2 00 	divsd  0xa2e1(%rip),%xmm0        # e158 <_IO_stdin_used+0x158>
    3e76:	00 
    3e77:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
    3e7b:	f2 0f 10 0d 05 16 01 	movsd  0x11605(%rip),%xmm1        # 15488 <fwp_gc+0x11f0>
    3e82:	00 
    3e83:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
    3e87:	f2 0f 11 0d f9 15 01 	movsd  %xmm1,0x115f9(%rip)        # 15488 <fwp_gc+0x11f0>
    3e8e:	00 
    3e8f:	66 0f 2e 05 f9 15 01 	ucomisd 0x115f9(%rip),%xmm0        # 15490 <fwp_gc+0x11f8>
    3e96:	00 
    3e97:	48 8d a4 24 e8 00 00 	lea    0xe8(%rsp),%rsp
    3e9e:	00 
    3e9f:	5b                   	pop    %rbx
    3ea0:	41 5c                	pop    %r12
    3ea2:	41 5d                	pop    %r13
    3ea4:	41 5e                	pop    %r14
    3ea6:	41 5f                	pop    %r15
    3ea8:	5d                   	pop    %rbp
    3ea9:	76 08                	jbe    3eb3 <fwp_gc_collect+0x223>
    3eab:	f2 0f 11 05 dd 15 01 	movsd  %xmm0,0x115dd(%rip)        # 15490 <fwp_gc+0x11f8>
    3eb2:	00 
    3eb3:	c7 05 d3 13 01 00 00 	movl   $0x0,0x113d3(%rip)        # 15290 <fwp_gc+0xff8>
    3eba:	00 00 00 
    3ebd:	c3                   	ret
    3ebe:	66 90                	xchg   %ax,%ax

0000000000003ec0 <fwp_gc_clear_marks>:
    3ec0:	48 8b 05 29 14 01 00 	mov    0x11429(%rip),%rax        # 152f0 <fwp_gc+0x1058>
    3ec7:	48 85 c0             	test   %rax,%rax
    3eca:	74 69                	je     3f35 <fwp_gc_clear_marks+0x75>
    3ecc:	41 56                	push   %r14
    3ece:	53                   	push   %rbx
    3ecf:	50                   	push   %rax
    3ed0:	48 8b 0d 39 14 01 00 	mov    0x11439(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    3ed7:	31 db                	xor    %ebx,%ebx
    3ed9:	45 31 f6             	xor    %r14d,%r14d
    3edc:	eb 16                	jmp    3ef4 <fwp_gc_clear_marks+0x34>
    3ede:	66 90                	xchg   %ax,%ax
    3ee0:	c6 44 19 03 00       	movb   $0x0,0x3(%rcx,%rbx,1)
    3ee5:	49 ff c6             	inc    %r14
    3ee8:	48 81 c3 28 12 00 00 	add    $0x1228,%rbx
    3eef:	49 39 c6             	cmp    %rax,%r14
    3ef2:	73 3a                	jae    3f2e <fwp_gc_clear_marks+0x6e>
    3ef4:	0f b6 14 19          	movzbl (%rcx,%rbx,1),%edx
    3ef8:	83 fa 02             	cmp    $0x2,%edx
    3efb:	74 e3                	je     3ee0 <fwp_gc_clear_marks+0x20>
    3efd:	83 fa 01             	cmp    $0x1,%edx
    3f00:	75 e3                	jne    3ee5 <fwp_gc_clear_marks+0x25>
    3f02:	48 8d 3c 19          	lea    (%rcx,%rbx,1),%rdi
    3f06:	48 83 c7 28          	add    $0x28,%rdi
    3f0a:	8b 54 19 0c          	mov    0xc(%rcx,%rbx,1),%edx
    3f0e:	83 c2 3f             	add    $0x3f,%edx
    3f11:	c1 ea 03             	shr    $0x3,%edx
    3f14:	83 e2 f8             	and    $0xfffffff8,%edx
    3f17:	31 f6                	xor    %esi,%esi
    3f19:	e8 f2 e2 ff ff       	call   2210 <memset@plt>
    3f1e:	48 8b 0d eb 13 01 00 	mov    0x113eb(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    3f25:	48 8b 05 c4 13 01 00 	mov    0x113c4(%rip),%rax        # 152f0 <fwp_gc+0x1058>
    3f2c:	eb b7                	jmp    3ee5 <fwp_gc_clear_marks+0x25>
    3f2e:	48 83 c4 08          	add    $0x8,%rsp
    3f32:	5b                   	pop    %rbx
    3f33:	41 5e                	pop    %r14
    3f35:	c3                   	ret
    3f36:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    3f3d:	00 00 00 

0000000000003f40 <fwp_gc_mark_all>:
    3f40:	50                   	push   %rax
    3f41:	e8 4a 0c 00 00       	call   4b90 <fwp_gc_sp>
    3f46:	48 89 c7             	mov    %rax,%rdi
    3f49:	e8 32 0c 00 00       	call   4b80 <fwp_gc_scan_stacks>
    3f4e:	e8 4d 0c 00 00       	call   4ba0 <fwp_gc_drain>
    3f53:	e8 98 0c 00 00       	call   4bf0 <fwp_gc_scan_data>
    3f58:	58                   	pop    %rax
    3f59:	e9 42 0c 00 00       	jmp    4ba0 <fwp_gc_drain>
    3f5e:	66 90                	xchg   %ax,%ax

0000000000003f60 <fwp_gc_scan_old_filled>:
    3f60:	48 83 3d 88 13 01 00 	cmpq   $0x0,0x11388(%rip)        # 152f0 <fwp_gc+0x1058>
    3f67:	00 
    3f68:	0f 84 32 0c 00 00    	je     4ba0 <fwp_gc_drain>
    3f6e:	55                   	push   %rbp
    3f6f:	41 57                	push   %r15
    3f71:	41 56                	push   %r14
    3f73:	41 55                	push   %r13
    3f75:	41 54                	push   %r12
    3f77:	53                   	push   %rbx
    3f78:	48 83 ec 18          	sub    $0x18,%rsp
    3f7c:	31 c0                	xor    %eax,%eax
    3f7e:	eb 14                	jmp    3f94 <fwp_gc_scan_old_filled+0x34>
    3f80:	48 8b 04 24          	mov    (%rsp),%rax
    3f84:	48 ff c0             	inc    %rax
    3f87:	48 3b 05 62 13 01 00 	cmp    0x11362(%rip),%rax        # 152f0 <fwp_gc+0x1058>
    3f8e:	0f 83 f6 00 00 00    	jae    408a <fwp_gc_scan_old_filled+0x12a>
    3f94:	48 8b 0d 75 13 01 00 	mov    0x11375(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    3f9b:	48 89 04 24          	mov    %rax,(%rsp)
    3f9f:	48 69 e8 28 12 00 00 	imul   $0x1228,%rax,%rbp
    3fa6:	80 7c 29 01 02       	cmpb   $0x2,0x1(%rcx,%rbp,1)
    3fab:	75 d3                	jne    3f80 <fwp_gc_scan_old_filled+0x20>
    3fad:	48 89 cb             	mov    %rcx,%rbx
    3fb0:	0f b6 04 29          	movzbl (%rcx,%rbp,1),%eax
    3fb4:	83 f8 02             	cmp    $0x2,%eax
    3fb7:	0f 84 a7 00 00 00    	je     4064 <fwp_gc_scan_old_filled+0x104>
    3fbd:	83 f8 01             	cmp    $0x1,%eax
    3fc0:	75 be                	jne    3f80 <fwp_gc_scan_old_filled+0x20>
    3fc2:	48 8b 3c 24          	mov    (%rsp),%rdi
    3fc6:	e8 b5 ef ff ff       	call   2f80 <fwp_gc_chunk_addr>
    3fcb:	49 89 c6             	mov    %rax,%r14
    3fce:	8b 44 2b 0c          	mov    0xc(%rbx,%rbp,1),%eax
    3fd2:	83 c0 3f             	add    $0x3f,%eax
    3fd5:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    3fda:	83 f8 40             	cmp    $0x40,%eax
    3fdd:	72 a1                	jb     3f80 <fwp_gc_scan_old_filled+0x20>
    3fdf:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    3fe4:	c1 e8 06             	shr    $0x6,%eax
    3fe7:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    3fec:	4c 8d 2c 2b          	lea    (%rbx,%rbp,1),%r13
    3ff0:	49 83 c5 08          	add    $0x8,%r13
    3ff4:	48 01 eb             	add    %rbp,%rbx
    3ff7:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
    3ffc:	45 31 ff             	xor    %r15d,%r15d
    3fff:	eb 1d                	jmp    401e <fwp_gc_scan_old_filled+0xbe>
    4001:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4008:	0f 1f 84 00 00 00 00 
    400f:	00 
    4010:	49 ff c7             	inc    %r15
    4013:	4c 3b 7c 24 08       	cmp    0x8(%rsp),%r15
    4018:	0f 84 62 ff ff ff    	je     3f80 <fwp_gc_scan_old_filled+0x20>
    401e:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    4023:	4e 8b 64 f8 28       	mov    0x28(%rax,%r15,8),%r12
    4028:	4d 85 e4             	test   %r12,%r12
    402b:	74 e3                	je     4010 <fwp_gc_scan_old_filled+0xb0>
    402d:	4c 89 fd             	mov    %r15,%rbp
    4030:	48 c1 e5 06          	shl    $0x6,%rbp
    4034:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    403b:	00 00 00 00 00 
    4040:	f3 49 0f bc fc       	tzcnt  %r12,%rdi
    4045:	48 09 ef             	or     %rbp,%rdi
    4048:	49 8d 5c 24 ff       	lea    -0x1(%r12),%rbx
    404d:	41 8b 75 00          	mov    0x0(%r13),%esi
    4051:	48 0f af fe          	imul   %rsi,%rdi
    4055:	4c 01 f7             	add    %r14,%rdi
    4058:	e8 03 0e 00 00       	call   4e60 <fwp_gc_push>
    405d:	49 21 dc             	and    %rbx,%r12
    4060:	75 de                	jne    4040 <fwp_gc_scan_old_filled+0xe0>
    4062:	eb ac                	jmp    4010 <fwp_gc_scan_old_filled+0xb0>
    4064:	80 7c 2b 03 00       	cmpb   $0x0,0x3(%rbx,%rbp,1)
    4069:	0f 84 11 ff ff ff    	je     3f80 <fwp_gc_scan_old_filled+0x20>
    406f:	48 8b 3c 24          	mov    (%rsp),%rdi
    4073:	e8 08 ef ff ff       	call   2f80 <fwp_gc_chunk_addr>
    4078:	48 8b 74 2b 18       	mov    0x18(%rbx,%rbp,1),%rsi
    407d:	48 89 c7             	mov    %rax,%rdi
    4080:	e8 db 0d 00 00       	call   4e60 <fwp_gc_push>
    4085:	e9 f6 fe ff ff       	jmp    3f80 <fwp_gc_scan_old_filled+0x20>
    408a:	48 83 c4 18          	add    $0x18,%rsp
    408e:	5b                   	pop    %rbx
    408f:	41 5c                	pop    %r12
    4091:	41 5d                	pop    %r13
    4093:	41 5e                	pop    %r14
    4095:	41 5f                	pop    %r15
    4097:	5d                   	pop    %rbp
    4098:	e9 03 0b 00 00       	jmp    4ba0 <fwp_gc_drain>
    409d:	0f 1f 00             	nopl   (%rax)

00000000000040a0 <fwp_gc_verify_minor>:
    40a0:	55                   	push   %rbp
    40a1:	41 57                	push   %r15
    40a3:	41 56                	push   %r14
    40a5:	41 55                	push   %r13
    40a7:	41 54                	push   %r12
    40a9:	53                   	push   %rbx
    40aa:	48 83 ec 58          	sub    $0x58,%rsp
    40ae:	4c 8b 2d 3b 12 01 00 	mov    0x1123b(%rip),%r13        # 152f0 <fwp_gc+0x1058>
    40b5:	4c 89 ef             	mov    %r13,%rdi
    40b8:	48 c1 e7 09          	shl    $0x9,%rdi
    40bc:	e8 7f e2 ff ff       	call   2340 <malloc@plt>
    40c1:	48 89 c3             	mov    %rax,%rbx
    40c4:	49 83 fd 01          	cmp    $0x1,%r13
    40c8:	4c 89 ef             	mov    %r13,%rdi
    40cb:	48 83 d7 00          	adc    $0x0,%rdi
    40cf:	48 89 7c 24 30       	mov    %rdi,0x30(%rsp)
    40d4:	e8 67 e2 ff ff       	call   2340 <malloc@plt>
    40d9:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
    40de:	48 85 db             	test   %rbx,%rbx
    40e1:	0f 84 74 03 00 00    	je     445b <fwp_gc_verify_minor+0x3bb>
    40e7:	49 89 c7             	mov    %rax,%r15
    40ea:	48 85 c0             	test   %rax,%rax
    40ed:	0f 84 68 03 00 00    	je     445b <fwp_gc_verify_minor+0x3bb>
    40f3:	4d 85 ed             	test   %r13,%r13
    40f6:	74 1c                	je     4114 <fwp_gc_verify_minor+0x74>
    40f8:	48 8b 0d 11 12 01 00 	mov    0x11211(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    40ff:	49 83 fd 01          	cmp    $0x1,%r13
    4103:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
    4108:	75 19                	jne    4123 <fwp_gc_verify_minor+0x83>
    410a:	4d 89 ec             	mov    %r13,%r12
    410d:	31 ed                	xor    %ebp,%ebp
    410f:	e9 81 00 00 00       	jmp    4195 <fwp_gc_verify_minor+0xf5>
    4114:	e8 a7 fd ff ff       	call   3ec0 <fwp_gc_clear_marks>
    4119:	e8 22 fe ff ff       	call   3f40 <fwp_gc_mark_all>
    411e:	e9 13 03 00 00       	jmp    4436 <fwp_gc_verify_minor+0x396>
    4123:	4d 89 ec             	mov    %r13,%r12
    4126:	49 83 e5 fe          	and    $0xfffffffffffffffe,%r13
    412a:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    412f:	48 8d 98 00 02 00 00 	lea    0x200(%rax),%rbx
    4136:	4c 8d b1 50 12 00 00 	lea    0x1250(%rcx),%r14
    413d:	31 ed                	xor    %ebp,%ebp
    413f:	90                   	nop
    4140:	48 8d bb 00 fe ff ff 	lea    -0x200(%rbx),%rdi
    4147:	49 8d b6 d8 ed ff ff 	lea    -0x1228(%r14),%rsi
    414e:	ba 00 02 00 00       	mov    $0x200,%edx
    4153:	e8 d8 e1 ff ff       	call   2330 <memcpy@plt>
    4158:	41 0f b6 86 b3 ed ff 	movzbl -0x124d(%r14),%eax
    415f:	ff 
    4160:	41 88 04 2f          	mov    %al,(%r15,%rbp,1)
    4164:	ba 00 02 00 00       	mov    $0x200,%edx
    4169:	48 89 df             	mov    %rbx,%rdi
    416c:	4c 89 f6             	mov    %r14,%rsi
    416f:	e8 bc e1 ff ff       	call   2330 <memcpy@plt>
    4174:	41 0f b6 46 db       	movzbl -0x25(%r14),%eax
    4179:	41 88 44 2f 01       	mov    %al,0x1(%r15,%rbp,1)
    417e:	48 83 c5 02          	add    $0x2,%rbp
    4182:	48 81 c3 00 04 00 00 	add    $0x400,%rbx
    4189:	49 81 c6 50 24 00 00 	add    $0x2450,%r14
    4190:	49 39 ed             	cmp    %rbp,%r13
    4193:	75 ab                	jne    4140 <fwp_gc_verify_minor+0xa0>
    4195:	4d 89 e5             	mov    %r12,%r13
    4198:	41 f6 c5 01          	test   $0x1,%r13b
    419c:	74 34                	je     41d2 <fwp_gc_verify_minor+0x132>
    419e:	48 89 ef             	mov    %rbp,%rdi
    41a1:	48 c1 e7 09          	shl    $0x9,%rdi
    41a5:	48 03 7c 24 20       	add    0x20(%rsp),%rdi
    41aa:	48 69 dd 28 12 00 00 	imul   $0x1228,%rbp,%rbx
    41b1:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    41b6:	49 8d 34 1e          	lea    (%r14,%rbx,1),%rsi
    41ba:	48 83 c6 28          	add    $0x28,%rsi
    41be:	ba 00 02 00 00       	mov    $0x200,%edx
    41c3:	e8 68 e1 ff ff       	call   2330 <memcpy@plt>
    41c8:	41 0f b6 44 1e 03    	movzbl 0x3(%r14,%rbx,1),%eax
    41ce:	41 88 04 2f          	mov    %al,(%r15,%rbp,1)
    41d2:	e8 e9 fc ff ff       	call   3ec0 <fwp_gc_clear_marks>
    41d7:	e8 64 fd ff ff       	call   3f40 <fwp_gc_mark_all>
    41dc:	4d 85 ed             	test   %r13,%r13
    41df:	0f 84 51 02 00 00    	je     4436 <fwp_gc_verify_minor+0x396>
    41e5:	48 8b 1d 24 11 01 00 	mov    0x11124(%rip),%rbx        # 15310 <fwp_gc+0x1078>
    41ec:	48 8d 43 28          	lea    0x28(%rbx),%rax
    41f0:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    41f5:	31 ff                	xor    %edi,%edi
    41f7:	eb 30                	jmp    4229 <fwp_gc_verify_minor+0x189>
    41f9:	4d 85 c9             	test   %r9,%r9
    41fc:	0f 85 b8 00 00 00    	jne    42ba <fwp_gc_verify_minor+0x21a>
    4202:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4209:	1f 84 00 00 00 00 00 
    4210:	48 ff c7             	inc    %rdi
    4213:	48 81 c1 00 02 00 00 	add    $0x200,%rcx
    421a:	48 05 28 12 00 00    	add    $0x1228,%rax
    4220:	4c 39 ef             	cmp    %r13,%rdi
    4223:	0f 84 0d 02 00 00    	je     4436 <fwp_gc_verify_minor+0x396>
    4229:	4c 69 f7 28 12 00 00 	imul   $0x1228,%rdi,%r14
    4230:	42 0f b6 2c 33       	movzbl (%rbx,%r14,1),%ebp
    4235:	83 fd 02             	cmp    $0x2,%ebp
    4238:	74 66                	je     42a0 <fwp_gc_verify_minor+0x200>
    423a:	83 fd 01             	cmp    $0x1,%ebp
    423d:	75 d1                	jne    4210 <fwp_gc_verify_minor+0x170>
    423f:	42 8b 54 33 0c       	mov    0xc(%rbx,%r14,1),%edx
    4244:	83 c2 3f             	add    $0x3f,%edx
    4247:	83 fa 40             	cmp    $0x40,%edx
    424a:	72 c4                	jb     4210 <fwp_gc_verify_minor+0x170>
    424c:	c1 ea 06             	shr    $0x6,%edx
    424f:	31 f6                	xor    %esi,%esi
    4251:	45 31 e4             	xor    %r12d,%r12d
    4254:	45 31 c0             	xor    %r8d,%r8d
    4257:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    425e:	00 00 
    4260:	4e 8b 0c c1          	mov    (%rcx,%r8,8),%r9
    4264:	49 f7 d1             	not    %r9
    4267:	4e 23 0c c0          	and    (%rax,%r8,8),%r9
    426b:	4d 89 e2             	mov    %r12,%r10
    426e:	f3 4d 0f bc e1       	tzcnt  %r9,%r12
    4273:	49 01 f4             	add    %rsi,%r12
    4276:	4d 85 c9             	test   %r9,%r9
    4279:	4d 0f 44 e2          	cmove  %r10,%r12
    427d:	49 ff c0             	inc    %r8
    4280:	49 39 d0             	cmp    %rdx,%r8
    4283:	0f 83 70 ff ff ff    	jae    41f9 <fwp_gc_verify_minor+0x159>
    4289:	48 83 c6 40          	add    $0x40,%rsi
    428d:	4d 85 c9             	test   %r9,%r9
    4290:	74 ce                	je     4260 <fwp_gc_verify_minor+0x1c0>
    4292:	e9 62 ff ff ff       	jmp    41f9 <fwp_gc_verify_minor+0x159>
    4297:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    429e:	00 00 
    42a0:	42 80 7c 33 03 00    	cmpb   $0x0,0x3(%rbx,%r14,1)
    42a6:	0f 84 64 ff ff ff    	je     4210 <fwp_gc_verify_minor+0x170>
    42ac:	41 80 3c 3f 00       	cmpb   $0x0,(%r15,%rdi,1)
    42b1:	0f 85 59 ff ff ff    	jne    4210 <fwp_gc_verify_minor+0x170>
    42b7:	45 31 e4             	xor    %r12d,%r12d
    42ba:	e8 c1 ec ff ff       	call   2f80 <fwp_gc_chunk_addr>
    42bf:	46 8b 7c 33 08       	mov    0x8(%rbx,%r14,1),%r15d
    42c4:	4d 0f af e7          	imul   %r15,%r12
    42c8:	49 01 c4             	add    %rax,%r12
    42cb:	40 80 fd 01          	cmp    $0x1,%bpl
    42cf:	74 05                	je     42d6 <fwp_gc_verify_minor+0x236>
    42d1:	4e 8b 7c 33 18       	mov    0x18(%rbx,%r14,1),%r15
    42d6:	48 8b 05 03 fd 00 00 	mov    0xfd03(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    42dd:	48 8b 38             	mov    (%rax),%rdi
    42e0:	42 0f b6 4c 33 01    	movzbl 0x1(%rbx,%r14,1),%ecx
    42e6:	48 8d 35 9a a4 00 00 	lea    0xa49a(%rip),%rsi        # e787 <exec_in_fp0+0x137>
    42ed:	4c 89 e2             	mov    %r12,%rdx
    42f0:	4d 89 f8             	mov    %r15,%r8
    42f3:	31 c0                	xor    %eax,%eax
    42f5:	e8 f6 df ff ff       	call   22f0 <fprintf@plt>
    42fa:	4d 01 e7             	add    %r12,%r15
    42fd:	45 31 ed             	xor    %r13d,%r13d
    4300:	4c 89 7c 24 40       	mov    %r15,0x40(%rsp)
    4305:	eb 17                	jmp    431e <fwp_gc_verify_minor+0x27e>
    4307:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    430e:	00 00 
    4310:	49 ff c5             	inc    %r13
    4313:	4c 3b 6c 24 30       	cmp    0x30(%rsp),%r13
    4318:	0f 84 38 01 00 00    	je     4456 <fwp_gc_verify_minor+0x3b6>
    431e:	48 8b 05 eb 0f 01 00 	mov    0x10feb(%rip),%rax        # 15310 <fwp_gc+0x1078>
    4325:	49 69 cd 28 12 00 00 	imul   $0x1228,%r13,%rcx
    432c:	80 3c 08 01          	cmpb   $0x1,(%rax,%rcx,1)
    4330:	75 de                	jne    4310 <fwp_gc_verify_minor+0x270>
    4332:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    4337:	74 d7                	je     4310 <fwp_gc_verify_minor+0x270>
    4339:	8b 5c 08 0c          	mov    0xc(%rax,%rcx,1),%ebx
    433d:	85 db                	test   %ebx,%ebx
    433f:	74 cf                	je     4310 <fwp_gc_verify_minor+0x270>
    4341:	48 01 c8             	add    %rcx,%rax
    4344:	48 ff c0             	inc    %rax
    4347:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    434c:	4c 89 e8             	mov    %r13,%rax
    434f:	48 c1 e0 09          	shl    $0x9,%rax
    4353:	48 03 44 24 20       	add    0x20(%rsp),%rax
    4358:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    435d:	31 ed                	xor    %ebp,%ebp
    435f:	4c 89 6c 24 38       	mov    %r13,0x38(%rsp)
    4364:	eb 21                	jmp    4387 <fwp_gc_verify_minor+0x2e7>
    4366:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    436d:	00 00 00 
    4370:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    4375:	8b 58 0b             	mov    0xb(%rax),%ebx
    4378:	4c 8b 6c 24 38       	mov    0x38(%rsp),%r13
    437d:	48 ff c5             	inc    %rbp
    4380:	89 d8                	mov    %ebx,%eax
    4382:	48 39 c5             	cmp    %rax,%rbp
    4385:	73 89                	jae    4310 <fwp_gc_verify_minor+0x270>
    4387:	48 89 e8             	mov    %rbp,%rax
    438a:	48 c1 e8 06          	shr    $0x6,%rax
    438e:	48 8b 4c 24 50       	mov    0x50(%rsp),%rcx
    4393:	48 8b 04 c1          	mov    (%rcx,%rax,8),%rax
    4397:	48 0f a3 e8          	bt     %rbp,%rax
    439b:	73 e0                	jae    437d <fwp_gc_verify_minor+0x2dd>
    439d:	4c 89 ef             	mov    %r13,%rdi
    43a0:	e8 db eb ff ff       	call   2f80 <fwp_gc_chunk_addr>
    43a5:	48 89 c2             	mov    %rax,%rdx
    43a8:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    43ad:	44 8b 70 07          	mov    0x7(%rax),%r14d
    43b1:	49 83 fe 08          	cmp    $0x8,%r14
    43b5:	72 c6                	jb     437d <fwp_gc_verify_minor+0x2dd>
    43b7:	45 89 f0             	mov    %r14d,%r8d
    43ba:	4c 0f af f5          	imul   %rbp,%r14
    43be:	48 89 d3             	mov    %rdx,%rbx
    43c1:	4c 01 f3             	add    %r14,%rbx
    43c4:	45 31 ed             	xor    %r13d,%r13d
    43c7:	48 89 54 24 48       	mov    %rdx,0x48(%rsp)
    43cc:	eb 10                	jmp    43de <fwp_gc_verify_minor+0x33e>
    43ce:	66 90                	xchg   %ax,%ax
    43d0:	49 ff c5             	inc    %r13
    43d3:	44 89 c0             	mov    %r8d,%eax
    43d6:	c1 e8 03             	shr    $0x3,%eax
    43d9:	49 39 c5             	cmp    %rax,%r13
    43dc:	73 92                	jae    4370 <fwp_gc_verify_minor+0x2d0>
    43de:	4a 8b 04 eb          	mov    (%rbx,%r13,8),%rax
    43e2:	4c 39 e0             	cmp    %r12,%rax
    43e5:	72 e9                	jb     43d0 <fwp_gc_verify_minor+0x330>
    43e7:	4c 39 f8             	cmp    %r15,%rax
    43ea:	73 e4                	jae    43d0 <fwp_gc_verify_minor+0x330>
    43ec:	48 8b 05 ed fb 00 00 	mov    0xfbed(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    43f3:	48 8b 38             	mov    (%rax),%rdi
    43f6:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
    43fb:	41 0f b6 0f          	movzbl (%r15),%ecx
    43ff:	42 0f 10 04 32       	movups (%rdx,%r14,1),%xmm0
    4404:	4a 8b 44 32 10       	mov    0x10(%rdx,%r14,1),%rax
    4409:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    440e:	0f 11 04 24          	movups %xmm0,(%rsp)
    4412:	48 8d 35 c8 a3 00 00 	lea    0xa3c8(%rip),%rsi        # e7e1 <exec_in_fp0+0x191>
    4419:	48 89 da             	mov    %rbx,%rdx
    441c:	4d 89 e9             	mov    %r13,%r9
    441f:	31 c0                	xor    %eax,%eax
    4421:	e8 ca de ff ff       	call   22f0 <fprintf@plt>
    4426:	48 8b 54 24 48       	mov    0x48(%rsp),%rdx
    442b:	45 8b 47 07          	mov    0x7(%r15),%r8d
    442f:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
    4434:	eb 9a                	jmp    43d0 <fwp_gc_verify_minor+0x330>
    4436:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    443b:	e8 10 dc ff ff       	call   2050 <free@plt>
    4440:	4c 89 ff             	mov    %r15,%rdi
    4443:	48 83 c4 58          	add    $0x58,%rsp
    4447:	5b                   	pop    %rbx
    4448:	41 5c                	pop    %r12
    444a:	41 5d                	pop    %r13
    444c:	41 5e                	pop    %r14
    444e:	41 5f                	pop    %r15
    4450:	5d                   	pop    %rbp
    4451:	e9 fa db ff ff       	jmp    2050 <free@plt>
    4456:	e8 15 dc ff ff       	call   2070 <abort@plt>
    445b:	e8 80 f6 ff ff       	call   3ae0 <fwp_gc_oom>

0000000000004460 <fwp_gc_finalize>:
    4460:	41 57                	push   %r15
    4462:	41 56                	push   %r14
    4464:	41 55                	push   %r13
    4466:	41 54                	push   %r12
    4468:	53                   	push   %rbx
    4469:	4c 8b 3d e0 0f 01 00 	mov    0x10fe0(%rip),%r15        # 15450 <fwp_gc+0x11b8>
    4470:	4d 85 ff             	test   %r15,%r15
    4473:	74 71                	je     44e6 <fwp_gc_finalize+0x86>
    4475:	4c 8b 25 cc 0f 01 00 	mov    0x10fcc(%rip),%r12        # 15448 <fwp_gc+0x11b0>
    447c:	45 31 f6             	xor    %r14d,%r14d
    447f:	eb 46                	jmp    44c7 <fwp_gc_finalize+0x67>
    4481:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4488:	0f 1f 84 00 00 00 00 
    448f:	00 
    4490:	4d 01 e5             	add    %r12,%r13
    4493:	49 8b 45 08          	mov    0x8(%r13),%rax
    4497:	49 ff cf             	dec    %r15
    449a:	4c 89 3d af 0f 01 00 	mov    %r15,0x10faf(%rip)        # 15450 <fwp_gc+0x11b8>
    44a1:	49 c1 e7 04          	shl    $0x4,%r15
    44a5:	43 0f 10 04 3c       	movups (%r12,%r15,1),%xmm0
    44aa:	41 0f 11 45 00       	movups %xmm0,0x0(%r13)
    44af:	48 89 df             	mov    %rbx,%rdi
    44b2:	ff d0                	call   *%rax
    44b4:	4c 8b 25 8d 0f 01 00 	mov    0x10f8d(%rip),%r12        # 15448 <fwp_gc+0x11b0>
    44bb:	4c 8b 3d 8e 0f 01 00 	mov    0x10f8e(%rip),%r15        # 15450 <fwp_gc+0x11b8>
    44c2:	4d 39 fe             	cmp    %r15,%r14
    44c5:	73 1f                	jae    44e6 <fwp_gc_finalize+0x86>
    44c7:	4d 89 f5             	mov    %r14,%r13
    44ca:	49 c1 e5 04          	shl    $0x4,%r13
    44ce:	4b 8b 1c 2c          	mov    (%r12,%r13,1),%rbx
    44d2:	48 89 df             	mov    %rbx,%rdi
    44d5:	e8 06 0a 00 00       	call   4ee0 <fwp_gc_marked>
    44da:	85 c0                	test   %eax,%eax
    44dc:	74 b2                	je     4490 <fwp_gc_finalize+0x30>
    44de:	49 ff c6             	inc    %r14
    44e1:	4d 39 fe             	cmp    %r15,%r14
    44e4:	72 e1                	jb     44c7 <fwp_gc_finalize+0x67>
    44e6:	5b                   	pop    %rbx
    44e7:	41 5c                	pop    %r12
    44e9:	41 5d                	pop    %r13
    44eb:	41 5e                	pop    %r14
    44ed:	41 5f                	pop    %r15
    44ef:	c3                   	ret

00000000000044f0 <fwp_gc_sweep>:
    44f0:	55                   	push   %rbp
    44f1:	41 57                	push   %r15
    44f3:	41 56                	push   %r14
    44f5:	41 55                	push   %r13
    44f7:	41 54                	push   %r12
    44f9:	53                   	push   %rbx
    44fa:	48 83 ec 28          	sub    $0x28,%rsp
    44fe:	48 8d 3d 9b fd 00 00 	lea    0xfd9b(%rip),%rdi        # 142a0 <fwp_gc+0x8>
    4505:	45 31 ff             	xor    %r15d,%r15d
    4508:	ba 40 0b 00 00       	mov    $0xb40,%edx
    450d:	31 f6                	xor    %esi,%esi
    450f:	e8 fc dc ff ff       	call   2210 <memset@plt>
    4514:	48 83 3d d4 0d 01 00 	cmpq   $0x0,0x10dd4(%rip)        # 152f0 <fwp_gc+0x1058>
    451b:	00 
    451c:	0f 84 06 05 00 00    	je     4a28 <fwp_gc_sweep+0x538>
    4522:	31 c0                	xor    %eax,%eax
    4524:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    4529:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    4530:	55 55 55 
    4533:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    453a:	33 33 33 
    453d:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    4544:	0f 0f 0f 
    4547:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    454e:	01 01 01 
    4551:	66 0f 6f 2d 57 9b 00 	movdqa 0x9b57(%rip),%xmm5        # e0b0 <_IO_stdin_used+0xb0>
    4558:	00 
    4559:	66 0f 6f 35 5f 9b 00 	movdqa 0x9b5f(%rip),%xmm6        # e0c0 <_IO_stdin_used+0xc0>
    4560:	00 
    4561:	66 0f 6f 3d 67 9b 00 	movdqa 0x9b67(%rip),%xmm7        # e0d0 <_IO_stdin_used+0xd0>
    4568:	00 
    4569:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    456e:	45 31 ff             	xor    %r15d,%r15d
    4571:	31 db                	xor    %ebx,%ebx
    4573:	eb 63                	jmp    45d8 <fwp_gc_sweep+0xe8>
    4575:	4c 8b 64 24 10       	mov    0x10(%rsp),%r12
    457a:	4c 89 e7             	mov    %r12,%rdi
    457d:	e8 ee 09 00 00       	call   4f70 <fwp_rc_clear_chunk>
    4582:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    4587:	66 0f 6f 3d 41 9b 00 	movdqa 0x9b41(%rip),%xmm7        # e0d0 <_IO_stdin_used+0xd0>
    458e:	00 
    458f:	66 0f 6f 35 29 9b 00 	movdqa 0x9b29(%rip),%xmm6        # e0c0 <_IO_stdin_used+0xc0>
    4596:	00 
    4597:	66 0f 6f 2d 11 9b 00 	movdqa 0x9b11(%rip),%xmm5        # e0b0 <_IO_stdin_used+0xb0>
    459e:	00 
    459f:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    45a6:	01 01 01 
    45a9:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    45b0:	0f 0f 0f 
    45b3:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    45ba:	33 33 33 
    45bd:	41 c6 04 24 00       	movb   $0x0,(%r12)
    45c2:	49 ff c7             	inc    %r15
    45c5:	48 ff c3             	inc    %rbx
    45c8:	48 8b 05 21 0d 01 00 	mov    0x10d21(%rip),%rax        # 152f0 <fwp_gc+0x1058>
    45cf:	48 39 c3             	cmp    %rax,%rbx
    45d2:	0f 83 59 04 00 00    	jae    4a31 <fwp_gc_sweep+0x541>
    45d8:	4c 8b 2d 31 0d 01 00 	mov    0x10d31(%rip),%r13        # 15310 <fwp_gc+0x1078>
    45df:	4c 69 e3 28 12 00 00 	imul   $0x1228,%rbx,%r12
    45e6:	43 0f b6 44 25 00    	movzbl 0x0(%r13,%r12,1),%eax
    45ec:	85 c0                	test   %eax,%eax
    45ee:	74 d2                	je     45c2 <fwp_gc_sweep+0xd2>
    45f0:	83 f8 01             	cmp    $0x1,%eax
    45f3:	74 2b                	je     4620 <fwp_gc_sweep+0x130>
    45f5:	83 f8 02             	cmp    $0x2,%eax
    45f8:	75 cb                	jne    45c5 <fwp_gc_sweep+0xd5>
    45fa:	47 8b 74 25 10       	mov    0x10(%r13,%r12,1),%r14d
    45ff:	43 80 7c 25 03 00    	cmpb   $0x0,0x3(%r13,%r12,1)
    4605:	74 4c                	je     4653 <fwp_gc_sweep+0x163>
    4607:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    460c:	4b 03 44 25 18       	add    0x18(%r13,%r12,1),%rax
    4611:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    4616:	e9 f8 03 00 00       	jmp    4a13 <fwp_gc_sweep+0x523>
    461b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    4620:	4b 8d 04 2c          	lea    (%r12,%r13,1),%rax
    4624:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    4629:	43 8b 6c 25 0c       	mov    0xc(%r13,%r12,1),%ebp
    462e:	48 85 ed             	test   %rbp,%rbp
    4631:	0f 84 3e ff ff ff    	je     4575 <fwp_gc_sweep+0x85>
    4637:	48 8d 55 3f          	lea    0x3f(%rbp),%rdx
    463b:	48 89 d0             	mov    %rdx,%rax
    463e:	48 c1 e8 06          	shr    $0x6,%rax
    4642:	81 fd c1 00 00 00    	cmp    $0xc1,%ebp
    4648:	73 75                	jae    46bf <fwp_gc_sweep+0x1cf>
    464a:	31 d2                	xor    %edx,%edx
    464c:	31 c9                	xor    %ecx,%ecx
    464e:	e9 3c 01 00 00       	jmp    478f <fwp_gc_sweep+0x29f>
    4653:	4b 8d 3c 2c          	lea    (%r12,%r13,1),%rdi
    4657:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    465e:	e8 fd e8 ff ff       	call   2f60 <fwp_rc_clear_slot>
    4663:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    4668:	66 0f 6f 3d 60 9a 00 	movdqa 0x9a60(%rip),%xmm7        # e0d0 <_IO_stdin_used+0xd0>
    466f:	00 
    4670:	66 0f 6f 35 48 9a 00 	movdqa 0x9a48(%rip),%xmm6        # e0c0 <_IO_stdin_used+0xc0>
    4677:	00 
    4678:	66 0f 6f 2d 30 9a 00 	movdqa 0x9a30(%rip),%xmm5        # e0b0 <_IO_stdin_used+0xb0>
    467f:	00 
    4680:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    4687:	01 01 01 
    468a:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    4691:	0f 0f 0f 
    4694:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    469b:	33 33 33 
    469e:	4d 85 f6             	test   %r14,%r14
    46a1:	0f 84 69 03 00 00    	je     4a10 <fwp_gc_sweep+0x520>
    46a7:	48 8b 05 62 0c 01 00 	mov    0x10c62(%rip),%rax        # 15310 <fwp_gc+0x1078>
    46ae:	41 83 fe 04          	cmp    $0x4,%r14d
    46b2:	0f 83 e6 02 00 00    	jae    499e <fwp_gc_sweep+0x4ae>
    46b8:	31 c9                	xor    %ecx,%ecx
    46ba:	e9 19 03 00 00       	jmp    49d8 <fwp_gc_sweep+0x4e8>
    46bf:	89 c1                	mov    %eax,%ecx
    46c1:	83 e1 fc             	and    $0xfffffffc,%ecx
    46c4:	4b 8d 34 2c          	lea    (%r12,%r13,1),%rsi
    46c8:	48 83 c6 38          	add    $0x38,%rsi
    46cc:	48 c1 ea 03          	shr    $0x3,%rdx
    46d0:	83 e2 e0             	and    $0xffffffe0,%edx
    46d3:	66 0f ef c0          	pxor   %xmm0,%xmm0
    46d7:	31 ff                	xor    %edi,%edi
    46d9:	66 0f ef c9          	pxor   %xmm1,%xmm1
    46dd:	0f 1f 00             	nopl   (%rax)
    46e0:	f3 0f 6f 5c 3e f0    	movdqu -0x10(%rsi,%rdi,1),%xmm3
    46e6:	f3 0f 6f 14 3e       	movdqu (%rsi,%rdi,1),%xmm2
    46eb:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    46ef:	66 0f 71 d4 01       	psrlw  $0x1,%xmm4
    46f4:	66 0f db e5          	pand   %xmm5,%xmm4
    46f8:	66 0f f8 dc          	psubb  %xmm4,%xmm3
    46fc:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    4700:	66 0f db e6          	pand   %xmm6,%xmm4
    4704:	66 0f 71 d3 02       	psrlw  $0x2,%xmm3
    4709:	66 0f db de          	pand   %xmm6,%xmm3
    470d:	66 0f fc dc          	paddb  %xmm4,%xmm3
    4711:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    4715:	66 0f 71 d4 04       	psrlw  $0x4,%xmm4
    471a:	66 0f fc e3          	paddb  %xmm3,%xmm4
    471e:	66 0f db e7          	pand   %xmm7,%xmm4
    4722:	66 41 0f f6 e0       	psadbw %xmm8,%xmm4
    4727:	66 0f d4 c4          	paddq  %xmm4,%xmm0
    472b:	66 0f 6f da          	movdqa %xmm2,%xmm3
    472f:	66 0f 71 d3 01       	psrlw  $0x1,%xmm3
    4734:	66 0f db dd          	pand   %xmm5,%xmm3
    4738:	66 0f f8 d3          	psubb  %xmm3,%xmm2
    473c:	66 0f 6f da          	movdqa %xmm2,%xmm3
    4740:	66 0f db de          	pand   %xmm6,%xmm3
    4744:	66 0f 71 d2 02       	psrlw  $0x2,%xmm2
    4749:	66 0f db d6          	pand   %xmm6,%xmm2
    474d:	66 0f fc d3          	paddb  %xmm3,%xmm2
    4751:	66 0f 6f da          	movdqa %xmm2,%xmm3
    4755:	66 0f 71 d3 04       	psrlw  $0x4,%xmm3
    475a:	66 0f fc da          	paddb  %xmm2,%xmm3
    475e:	66 0f db df          	pand   %xmm7,%xmm3
    4762:	66 41 0f f6 d8       	psadbw %xmm8,%xmm3
    4767:	66 0f d4 cb          	paddq  %xmm3,%xmm1
    476b:	48 83 c7 20          	add    $0x20,%rdi
    476f:	48 39 fa             	cmp    %rdi,%rdx
    4772:	0f 85 68 ff ff ff    	jne    46e0 <fwp_gc_sweep+0x1f0>
    4778:	66 0f d4 c8          	paddq  %xmm0,%xmm1
    477c:	66 0f 70 c1 ee       	pshufd $0xee,%xmm1,%xmm0
    4781:	66 0f d4 c1          	paddq  %xmm1,%xmm0
    4785:	66 48 0f 7e c2       	movq   %xmm0,%rdx
    478a:	48 39 c8             	cmp    %rcx,%rax
    478d:	74 51                	je     47e0 <fwp_gc_sweep+0x2f0>
    478f:	4b 8d 34 2c          	lea    (%r12,%r13,1),%rsi
    4793:	48 83 c6 28          	add    $0x28,%rsi
    4797:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    479e:	00 00 
    47a0:	48 8b 3c ce          	mov    (%rsi,%rcx,8),%rdi
    47a4:	49 89 f8             	mov    %rdi,%r8
    47a7:	49 d1 e8             	shr    $1,%r8
    47aa:	4d 21 f0             	and    %r14,%r8
    47ad:	4c 29 c7             	sub    %r8,%rdi
    47b0:	49 89 f8             	mov    %rdi,%r8
    47b3:	4d 21 c8             	and    %r9,%r8
    47b6:	48 c1 ef 02          	shr    $0x2,%rdi
    47ba:	4c 21 cf             	and    %r9,%rdi
    47bd:	4c 01 c7             	add    %r8,%rdi
    47c0:	49 89 f8             	mov    %rdi,%r8
    47c3:	49 c1 e8 04          	shr    $0x4,%r8
    47c7:	49 01 f8             	add    %rdi,%r8
    47ca:	4d 21 d0             	and    %r10,%r8
    47cd:	4d 0f af c3          	imul   %r11,%r8
    47d1:	49 c1 e8 38          	shr    $0x38,%r8
    47d5:	4c 01 c2             	add    %r8,%rdx
    47d8:	48 ff c1             	inc    %rcx
    47db:	48 39 c8             	cmp    %rcx,%rax
    47de:	75 c0                	jne    47a0 <fwp_gc_sweep+0x2b0>
    47e0:	48 85 d2             	test   %rdx,%rdx
    47e3:	0f 84 8c fd ff ff    	je     4575 <fwp_gc_sweep+0x85>
    47e9:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    47ee:	43 8b 44 25 08       	mov    0x8(%r13,%r12,1),%eax
    47f3:	48 0f af d0          	imul   %rax,%rdx
    47f7:	48 01 54 24 08       	add    %rdx,0x8(%rsp)
    47fc:	47 0f b6 74 25 01    	movzbl 0x1(%r13,%r12,1),%r14d
    4802:	47 0f b6 7c 25 02    	movzbl 0x2(%r13,%r12,1),%r15d
    4808:	48 89 df             	mov    %rbx,%rdi
    480b:	e8 70 e7 ff ff       	call   2f80 <fwp_gc_chunk_addr>
    4810:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    4815:	48 85 ed             	test   %rbp,%rbp
    4818:	0f 84 31 01 00 00    	je     494f <fwp_gc_sweep+0x45f>
    481e:	49 69 c6 c0 03 00 00 	imul   $0x3c0,%r14,%rax
    4825:	48 8d 0d 6c fa 00 00 	lea    0xfa6c(%rip),%rcx        # 14298 <fwp_gc>
    482c:	48 01 c8             	add    %rcx,%rax
    482f:	4f 8d 34 2c          	lea    (%r12,%r13,1),%r14
    4833:	49 83 c6 08          	add    $0x8,%r14
    4837:	4b 8d 0c 7f          	lea    (%r15,%r15,2),%rcx
    483b:	4c 8d 3c c8          	lea    (%rax,%rcx,8),%r15
    483f:	49 83 c7 08          	add    $0x8,%r15
    4843:	49 01 ec             	add    %rbp,%r12
    4846:	4d 01 ec             	add    %r13,%r12
    4849:	49 81 c4 27 02 00 00 	add    $0x227,%r12
    4850:	48 ff cd             	dec    %rbp
    4853:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    485a:	33 33 33 
    485d:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    4864:	0f 0f 0f 
    4867:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    486e:	01 01 01 
    4871:	66 0f 6f 2d 37 98 00 	movdqa 0x9837(%rip),%xmm5        # e0b0 <_IO_stdin_used+0xb0>
    4878:	00 
    4879:	66 0f 6f 35 3f 98 00 	movdqa 0x983f(%rip),%xmm6        # e0c0 <_IO_stdin_used+0xc0>
    4880:	00 
    4881:	66 0f 6f 3d 47 98 00 	movdqa 0x9847(%rip),%xmm7        # e0d0 <_IO_stdin_used+0xd0>
    4888:	00 
    4889:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    488e:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    4893:	eb 69                	jmp    48fe <fwp_gc_sweep+0x40e>
    4895:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    489c:	00 00 00 00 
    48a0:	4c 89 e7             	mov    %r12,%rdi
    48a3:	e8 b8 e6 ff ff       	call   2f60 <fwp_rc_clear_slot>
    48a8:	49 8b 07             	mov    (%r15),%rax
    48ab:	48 f7 d0             	not    %rax
    48ae:	49 89 45 00          	mov    %rax,0x0(%r13)
    48b2:	4d 89 2f             	mov    %r13,(%r15)
    48b5:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    48bc:	33 33 33 
    48bf:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    48c6:	0f 0f 0f 
    48c9:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    48d0:	01 01 01 
    48d3:	66 0f 6f 2d d5 97 00 	movdqa 0x97d5(%rip),%xmm5        # e0b0 <_IO_stdin_used+0xb0>
    48da:	00 
    48db:	66 0f 6f 35 dd 97 00 	movdqa 0x97dd(%rip),%xmm6        # e0c0 <_IO_stdin_used+0xc0>
    48e2:	00 
    48e3:	66 0f 6f 3d e5 97 00 	movdqa 0x97e5(%rip),%xmm7        # e0d0 <_IO_stdin_used+0xd0>
    48ea:	00 
    48eb:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    48f0:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    48f5:	49 ff cc             	dec    %r12
    48f8:	48 83 c5 ff          	add    $0xffffffffffffffff,%rbp
    48fc:	73 3d                	jae    493b <fwp_gc_sweep+0x44b>
    48fe:	48 89 e8             	mov    %rbp,%rax
    4901:	48 c1 e8 06          	shr    $0x6,%rax
    4905:	48 8b 44 c1 28       	mov    0x28(%rcx,%rax,8),%rax
    490a:	48 0f a3 e8          	bt     %rbp,%rax
    490e:	72 e5                	jb     48f5 <fwp_gc_sweep+0x405>
    4910:	41 8b 16             	mov    (%r14),%edx
    4913:	49 89 ed             	mov    %rbp,%r13
    4916:	4c 0f af ea          	imul   %rdx,%r13
    491a:	4c 03 6c 24 20       	add    0x20(%rsp),%r13
    491f:	83 3d 76 09 01 00 00 	cmpl   $0x0,0x10976(%rip)        # 1529c <fwp_gc+0x1004>
    4926:	0f 84 74 ff ff ff    	je     48a0 <fwp_gc_sweep+0x3b0>
    492c:	4c 89 ef             	mov    %r13,%rdi
    492f:	31 f6                	xor    %esi,%esi
    4931:	e8 da d8 ff ff       	call   2210 <memset@plt>
    4936:	e9 65 ff ff ff       	jmp    48a0 <fwp_gc_sweep+0x3b0>
    493b:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    4940:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    4947:	55 55 55 
    494a:	e9 76 fc ff ff       	jmp    45c5 <fwp_gc_sweep+0xd5>
    494f:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    4954:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    495b:	55 55 55 
    495e:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    4965:	33 33 33 
    4968:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    496f:	0f 0f 0f 
    4972:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    4979:	01 01 01 
    497c:	66 0f 6f 2d 2c 97 00 	movdqa 0x972c(%rip),%xmm5        # e0b0 <_IO_stdin_used+0xb0>
    4983:	00 
    4984:	66 0f 6f 35 34 97 00 	movdqa 0x9734(%rip),%xmm6        # e0c0 <_IO_stdin_used+0xc0>
    498b:	00 
    498c:	66 0f 6f 3d 3c 97 00 	movdqa 0x973c(%rip),%xmm7        # e0d0 <_IO_stdin_used+0xd0>
    4993:	00 
    4994:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    4999:	e9 27 fc ff ff       	jmp    45c5 <fwp_gc_sweep+0xd5>
    499e:	4a 8d 14 20          	lea    (%rax,%r12,1),%rdx
    49a2:	44 89 f6             	mov    %r14d,%esi
    49a5:	83 e6 fc             	and    $0xfffffffc,%esi
    49a8:	31 c9                	xor    %ecx,%ecx
    49aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    49b0:	c6 02 00             	movb   $0x0,(%rdx)
    49b3:	c6 82 28 12 00 00 00 	movb   $0x0,0x1228(%rdx)
    49ba:	c6 82 50 24 00 00 00 	movb   $0x0,0x2450(%rdx)
    49c1:	c6 82 78 36 00 00 00 	movb   $0x0,0x3678(%rdx)
    49c8:	48 83 c1 04          	add    $0x4,%rcx
    49cc:	48 81 c2 a0 48 00 00 	add    $0x48a0,%rdx
    49d3:	48 39 ce             	cmp    %rcx,%rsi
    49d6:	75 d8                	jne    49b0 <fwp_gc_sweep+0x4c0>
    49d8:	44 89 f2             	mov    %r14d,%edx
    49db:	83 e2 03             	and    $0x3,%edx
    49de:	74 30                	je     4a10 <fwp_gc_sweep+0x520>
    49e0:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    49e7:	4c 01 e1             	add    %r12,%rcx
    49ea:	48 01 c8             	add    %rcx,%rax
    49ed:	48 69 ca 28 12 00 00 	imul   $0x1228,%rdx,%rcx
    49f4:	31 d2                	xor    %edx,%edx
    49f6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    49fd:	00 00 00 
    4a00:	c6 04 10 00          	movb   $0x0,(%rax,%rdx,1)
    4a04:	48 81 c2 28 12 00 00 	add    $0x1228,%rdx
    4a0b:	48 39 d1             	cmp    %rdx,%rcx
    4a0e:	75 f0                	jne    4a00 <fwp_gc_sweep+0x510>
    4a10:	4d 01 f7             	add    %r14,%r15
    4a13:	4c 01 f3             	add    %r14,%rbx
    4a16:	48 ff cb             	dec    %rbx
    4a19:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    4a20:	55 55 55 
    4a23:	e9 9d fb ff ff       	jmp    45c5 <fwp_gc_sweep+0xd5>
    4a28:	31 c0                	xor    %eax,%eax
    4a2a:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    4a2f:	31 c0                	xor    %eax,%eax
    4a31:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    4a36:	48 89 15 23 0a 01 00 	mov    %rdx,0x10a23(%rip)        # 15460 <fwp_gc+0x11c8>
    4a3d:	4c 89 3d 34 0a 01 00 	mov    %r15,0x10a34(%rip)        # 15478 <fwp_gc+0x11e0>
    4a44:	48 81 fa 01 00 00 01 	cmp    $0x1000001,%rdx
    4a4b:	b9 00 00 00 01       	mov    $0x1000000,%ecx
    4a50:	48 0f 43 ca          	cmovae %rdx,%rcx
    4a54:	48 c1 e9 10          	shr    $0x10,%rcx
    4a58:	66 0f ef c0          	pxor   %xmm0,%xmm0
    4a5c:	f3 0f 7f 05 9c 08 01 	movdqu %xmm0,0x1089c(%rip)        # 15300 <fwp_gc+0x1068>
    4a63:	00 
    4a64:	49 29 cf             	sub    %rcx,%r15
    4a67:	0f 86 01 01 00 00    	jbe    4b6e <fwp_gc_sweep+0x67e>
    4a6d:	48 85 c0             	test   %rax,%rax
    4a70:	0f 84 f8 00 00 00    	je     4b6e <fwp_gc_sweep+0x67e>
    4a76:	4d 85 ff             	test   %r15,%r15
    4a79:	0f 84 ef 00 00 00    	je     4b6e <fwp_gc_sweep+0x67e>
    4a7f:	48 8b 0d 8a 08 01 00 	mov    0x1088a(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    4a86:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    4a8d:	00 00 00 
    4a90:	48 8d 58 ff          	lea    -0x1(%rax),%rbx
    4a94:	48 69 d3 28 12 00 00 	imul   $0x1228,%rbx,%rdx
    4a9b:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
    4a9f:	0f 85 b8 00 00 00    	jne    4b5d <fwp_gc_sweep+0x66d>
    4aa5:	4c 89 ff             	mov    %r15,%rdi
    4aa8:	49 ff cf             	dec    %r15
    4aab:	80 7c 11 04 00       	cmpb   $0x0,0x4(%rcx,%rdx,1)
    4ab0:	0f 84 a7 00 00 00    	je     4b5d <fwp_gc_sweep+0x66d>
    4ab6:	48 01 ca             	add    %rcx,%rdx
    4ab9:	48 83 c2 04          	add    $0x4,%rdx
    4abd:	c6 02 00             	movb   $0x0,(%rdx)
    4ac0:	41 be 01 00 00 00    	mov    $0x1,%r14d
    4ac6:	48 85 db             	test   %rbx,%rbx
    4ac9:	74 6f                	je     4b3a <fwp_gc_sweep+0x64a>
    4acb:	4d 85 ff             	test   %r15,%r15
    4ace:	74 6a                	je     4b3a <fwp_gc_sweep+0x64a>
    4ad0:	ba 02 00 00 00       	mov    $0x2,%edx
    4ad5:	48 29 c2             	sub    %rax,%rdx
    4ad8:	48 69 c0 28 12 00 00 	imul   $0x1228,%rax,%rax
    4adf:	48 01 c1             	add    %rax,%rcx
    4ae2:	48 81 c1 b4 db ff ff 	add    $0xffffffffffffdbb4,%rcx
    4ae9:	be 02 00 00 00       	mov    $0x2,%esi
    4aee:	48 29 fe             	sub    %rdi,%rsi
    4af1:	b8 01 00 00 00       	mov    $0x1,%eax
    4af6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    4afd:	00 00 00 
    4b00:	80 79 fc 00          	cmpb   $0x0,-0x4(%rcx)
    4b04:	75 31                	jne    4b37 <fwp_gc_sweep+0x647>
    4b06:	80 39 00             	cmpb   $0x0,(%rcx)
    4b09:	74 2c                	je     4b37 <fwp_gc_sweep+0x647>
    4b0b:	48 ff cb             	dec    %rbx
    4b0e:	48 8d 3c 02          	lea    (%rdx,%rax,1),%rdi
    4b12:	49 ff cf             	dec    %r15
    4b15:	c6 01 00             	movb   $0x0,(%rcx)
    4b18:	4c 8d 70 01          	lea    0x1(%rax),%r14
    4b1c:	48 83 ff 01          	cmp    $0x1,%rdi
    4b20:	74 18                	je     4b3a <fwp_gc_sweep+0x64a>
    4b22:	48 01 f0             	add    %rsi,%rax
    4b25:	48 81 c1 d8 ed ff ff 	add    $0xffffffffffffedd8,%rcx
    4b2c:	48 83 f8 01          	cmp    $0x1,%rax
    4b30:	4c 89 f0             	mov    %r14,%rax
    4b33:	75 cb                	jne    4b00 <fwp_gc_sweep+0x610>
    4b35:	eb 03                	jmp    4b3a <fwp_gc_sweep+0x64a>
    4b37:	49 89 c6             	mov    %rax,%r14
    4b3a:	48 89 df             	mov    %rbx,%rdi
    4b3d:	e8 3e e4 ff ff       	call   2f80 <fwp_gc_chunk_addr>
    4b42:	49 c1 e6 10          	shl    $0x10,%r14
    4b46:	48 89 c7             	mov    %rax,%rdi
    4b49:	4c 89 f6             	mov    %r14,%rsi
    4b4c:	ba 04 00 00 00       	mov    $0x4,%edx
    4b51:	e8 9a d8 ff ff       	call   23f0 <madvise@plt>
    4b56:	48 8b 0d b3 07 01 00 	mov    0x107b3(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    4b5d:	48 89 d8             	mov    %rbx,%rax
    4b60:	48 85 db             	test   %rbx,%rbx
    4b63:	74 09                	je     4b6e <fwp_gc_sweep+0x67e>
    4b65:	4d 85 ff             	test   %r15,%r15
    4b68:	0f 85 22 ff ff ff    	jne    4a90 <fwp_gc_sweep+0x5a0>
    4b6e:	48 83 c4 28          	add    $0x28,%rsp
    4b72:	5b                   	pop    %rbx
    4b73:	41 5c                	pop    %r12
    4b75:	41 5d                	pop    %r13
    4b77:	41 5e                	pop    %r14
    4b79:	41 5f                	pop    %r15
    4b7b:	5d                   	pop    %rbp
    4b7c:	c3                   	ret
    4b7d:	0f 1f 00             	nopl   (%rax)

0000000000004b80 <fwp_gc_scan_stacks>:
    4b80:	48 8b 35 99 07 01 00 	mov    0x10799(%rip),%rsi        # 15320 <fwp_gc+0x1088>
    4b87:	e9 04 01 00 00       	jmp    4c90 <fwp_gc_scan_root>
    4b8c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000004b90 <fwp_gc_sp>:
    4b90:	55                   	push   %rbp
    4b91:	48 89 e5             	mov    %rsp,%rbp
    4b94:	48 89 e8             	mov    %rbp,%rax
    4b97:	5d                   	pop    %rbp
    4b98:	c3                   	ret
    4b99:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000004ba0 <fwp_gc_drain>:
    4ba0:	48 8b 05 91 08 01 00 	mov    0x10891(%rip),%rax        # 15438 <fwp_gc+0x11a0>
    4ba7:	48 85 c0             	test   %rax,%rax
    4baa:	74 3c                	je     4be8 <fwp_gc_drain+0x48>
    4bac:	50                   	push   %rax
    4bad:	0f 1f 00             	nopl   (%rax)
    4bb0:	48 8b 0d 79 08 01 00 	mov    0x10879(%rip),%rcx        # 15430 <fwp_gc+0x1198>
    4bb7:	48 ff c8             	dec    %rax
    4bba:	48 89 05 77 08 01 00 	mov    %rax,0x10877(%rip)        # 15438 <fwp_gc+0x11a0>
    4bc1:	48 c1 e0 04          	shl    $0x4,%rax
    4bc5:	48 8b 3c 01          	mov    (%rcx,%rax,1),%rdi
    4bc9:	48 8b 74 01 08       	mov    0x8(%rcx,%rax,1),%rsi
    4bce:	48 01 fe             	add    %rdi,%rsi
    4bd1:	31 d2                	xor    %edx,%edx
    4bd3:	e8 e8 00 00 00       	call   4cc0 <fwp_gc_scan>
    4bd8:	48 8b 05 59 08 01 00 	mov    0x10859(%rip),%rax        # 15438 <fwp_gc+0x11a0>
    4bdf:	48 85 c0             	test   %rax,%rax
    4be2:	75 cc                	jne    4bb0 <fwp_gc_drain+0x10>
    4be4:	48 83 c4 08          	add    $0x8,%rsp
    4be8:	c3                   	ret
    4be9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000004bf0 <fwp_gc_scan_data>:
    4bf0:	83 3d 31 08 01 00 00 	cmpl   $0x0,0x10831(%rip)        # 15428 <fwp_gc+0x1190>
    4bf7:	0f 8e 87 00 00 00    	jle    4c84 <fwp_gc_scan_data+0x94>
    4bfd:	41 57                	push   %r15
    4bff:	41 56                	push   %r14
    4c01:	41 55                	push   %r13
    4c03:	41 54                	push   %r12
    4c05:	53                   	push   %rbx
    4c06:	4c 8d 25 23 07 01 00 	lea    0x10723(%rip),%r12        # 15330 <fwp_gc+0x1098>
    4c0d:	45 31 ed             	xor    %r13d,%r13d
    4c10:	48 8d 1d 81 f6 00 00 	lea    0xf681(%rip),%rbx        # 14298 <fwp_gc>
    4c17:	4c 8d 35 9a 10 01 00 	lea    0x1109a(%rip),%r14        # 15cb8 <fwp_reuse_verify>
    4c1e:	eb 1d                	jmp    4c3d <fwp_gc_scan_data+0x4d>
    4c20:	4c 89 fe             	mov    %r15,%rsi
    4c23:	31 d2                	xor    %edx,%edx
    4c25:	e8 96 00 00 00       	call   4cc0 <fwp_gc_scan>
    4c2a:	49 ff c5             	inc    %r13
    4c2d:	48 63 05 f4 07 01 00 	movslq 0x107f4(%rip),%rax        # 15428 <fwp_gc+0x1190>
    4c34:	49 83 c4 10          	add    $0x10,%r12
    4c38:	49 39 c5             	cmp    %rax,%r13
    4c3b:	7d 3e                	jge    4c7b <fwp_gc_scan_data+0x8b>
    4c3d:	49 8b 7c 24 f8       	mov    -0x8(%r12),%rdi
    4c42:	49 8b 04 24          	mov    (%r12),%rax
    4c46:	4c 8d 3c 07          	lea    (%rdi,%rax,1),%r15
    4c4a:	0f 57 c0             	xorps  %xmm0,%xmm0
    4c4d:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    4c52:	f2 0f 58 05 3e 08 01 	addsd  0x1083e(%rip),%xmm0        # 15498 <fwp_gc+0x1200>
    4c59:	00 
    4c5a:	f2 0f 11 05 36 08 01 	movsd  %xmm0,0x10836(%rip)        # 15498 <fwp_gc+0x1200>
    4c61:	00 
    4c62:	48 39 df             	cmp    %rbx,%rdi
    4c65:	77 b9                	ja     4c20 <fwp_gc_scan_data+0x30>
    4c67:	4d 39 f7             	cmp    %r14,%r15
    4c6a:	72 b4                	jb     4c20 <fwp_gc_scan_data+0x30>
    4c6c:	48 89 de             	mov    %rbx,%rsi
    4c6f:	31 d2                	xor    %edx,%edx
    4c71:	e8 4a 00 00 00       	call   4cc0 <fwp_gc_scan>
    4c76:	4c 89 f7             	mov    %r14,%rdi
    4c79:	eb a5                	jmp    4c20 <fwp_gc_scan_data+0x30>
    4c7b:	5b                   	pop    %rbx
    4c7c:	41 5c                	pop    %r12
    4c7e:	41 5d                	pop    %r13
    4c80:	41 5e                	pop    %r14
    4c82:	41 5f                	pop    %r15
    4c84:	c3                   	ret
    4c85:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    4c8c:	00 00 00 00 

0000000000004c90 <fwp_gc_scan_root>:
    4c90:	48 85 ff             	test   %rdi,%rdi
    4c93:	74 24                	je     4cb9 <fwp_gc_scan_root+0x29>
    4c95:	48 89 f0             	mov    %rsi,%rax
    4c98:	48 29 f8             	sub    %rdi,%rax
    4c9b:	76 1c                	jbe    4cb9 <fwp_gc_scan_root+0x29>
    4c9d:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    4ca2:	f2 0f 58 05 ee 07 01 	addsd  0x107ee(%rip),%xmm0        # 15498 <fwp_gc+0x1200>
    4ca9:	00 
    4caa:	f2 0f 11 05 e6 07 01 	movsd  %xmm0,0x107e6(%rip)        # 15498 <fwp_gc+0x1200>
    4cb1:	00 
    4cb2:	ba 01 00 00 00       	mov    $0x1,%edx
    4cb7:	eb 07                	jmp    4cc0 <fwp_gc_scan>
    4cb9:	c3                   	ret
    4cba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000004cc0 <fwp_gc_scan>:
    4cc0:	55                   	push   %rbp
    4cc1:	41 57                	push   %r15
    4cc3:	41 56                	push   %r14
    4cc5:	41 55                	push   %r13
    4cc7:	41 54                	push   %r12
    4cc9:	53                   	push   %rbx
    4cca:	50                   	push   %rax
    4ccb:	49 89 ff             	mov    %rdi,%r15
    4cce:	49 83 c7 07          	add    $0x7,%r15
    4cd2:	49 83 e7 f8          	and    $0xfffffffffffffff8,%r15
    4cd6:	49 8d 47 08          	lea    0x8(%r15),%rax
    4cda:	48 39 f0             	cmp    %rsi,%rax
    4cdd:	76 0f                	jbe    4cee <fwp_gc_scan+0x2e>
    4cdf:	48 83 c4 08          	add    $0x8,%rsp
    4ce3:	5b                   	pop    %rbx
    4ce4:	41 5c                	pop    %r12
    4ce6:	41 5d                	pop    %r13
    4ce8:	41 5e                	pop    %r14
    4cea:	41 5f                	pop    %r15
    4cec:	5d                   	pop    %rbp
    4ced:	c3                   	ret
    4cee:	89 d3                	mov    %edx,%ebx
    4cf0:	49 89 f6             	mov    %rsi,%r14
    4cf3:	4c 8b 2d ce 05 01 00 	mov    0x105ce(%rip),%r13        # 152c8 <fwp_gc+0x1030>
    4cfa:	48 8b 2d ef 05 01 00 	mov    0x105ef(%rip),%rbp        # 152f0 <fwp_gc+0x1058>
    4d01:	48 c1 e5 10          	shl    $0x10,%rbp
    4d05:	eb 30                	jmp    4d37 <fwp_gc_scan+0x77>
    4d07:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    4d0e:	00 00 
    4d10:	4c 89 e7             	mov    %r12,%rdi
    4d13:	e8 38 00 00 00       	call   4d50 <fwp_gc_mark>
    4d18:	85 db                	test   %ebx,%ebx
    4d1a:	74 0b                	je     4d27 <fwp_gc_scan+0x67>
    4d1c:	49 ff cc             	dec    %r12
    4d1f:	4c 89 e7             	mov    %r12,%rdi
    4d22:	e8 29 00 00 00       	call   4d50 <fwp_gc_mark>
    4d27:	49 8d 47 08          	lea    0x8(%r15),%rax
    4d2b:	49 83 c7 10          	add    $0x10,%r15
    4d2f:	4d 39 f7             	cmp    %r14,%r15
    4d32:	49 89 c7             	mov    %rax,%r15
    4d35:	77 a8                	ja     4cdf <fwp_gc_scan+0x1f>
    4d37:	4d 8b 27             	mov    (%r15),%r12
    4d3a:	4c 89 e0             	mov    %r12,%rax
    4d3d:	4c 29 e8             	sub    %r13,%rax
    4d40:	48 39 e8             	cmp    %rbp,%rax
    4d43:	72 cb                	jb     4d10 <fwp_gc_scan+0x50>
    4d45:	85 db                	test   %ebx,%ebx
    4d47:	74 de                	je     4d27 <fwp_gc_scan+0x67>
    4d49:	48 39 e8             	cmp    %rbp,%rax
    4d4c:	74 ce                	je     4d1c <fwp_gc_scan+0x5c>
    4d4e:	eb d7                	jmp    4d27 <fwp_gc_scan+0x67>

0000000000004d50 <fwp_gc_mark>:
    4d50:	41 56                	push   %r14
    4d52:	53                   	push   %rbx
    4d53:	50                   	push   %rax
    4d54:	49 89 fe             	mov    %rdi,%r14
    4d57:	48 89 e6             	mov    %rsp,%rsi
    4d5a:	e8 d1 00 00 00       	call   4e30 <fwp_gc_chunk_of>
    4d5f:	48 85 c0             	test   %rax,%rax
    4d62:	0f 84 98 00 00 00    	je     4e00 <fwp_gc_mark+0xb0>
    4d68:	0f b6 08             	movzbl (%rax),%ecx
    4d6b:	83 f9 03             	cmp    $0x3,%ecx
    4d6e:	74 6b                	je     4ddb <fwp_gc_mark+0x8b>
    4d70:	83 f9 02             	cmp    $0x2,%ecx
    4d73:	74 7b                	je     4df0 <fwp_gc_mark+0xa0>
    4d75:	83 f9 01             	cmp    $0x1,%ecx
    4d78:	0f 85 82 00 00 00    	jne    4e00 <fwp_gc_mark+0xb0>
    4d7e:	8b 58 08             	mov    0x8(%rax),%ebx
    4d81:	41 0f b7 ce          	movzwl %r14w,%ecx
    4d85:	48 89 c6             	mov    %rax,%rsi
    4d88:	89 c8                	mov    %ecx,%eax
    4d8a:	31 d2                	xor    %edx,%edx
    4d8c:	f7 f3                	div    %ebx
    4d8e:	41 89 c6             	mov    %eax,%r14d
    4d91:	3b 46 0c             	cmp    0xc(%rsi),%eax
    4d94:	73 6a                	jae    4e00 <fwp_gc_mark+0xb0>
    4d96:	48 89 f0             	mov    %rsi,%rax
    4d99:	ba 01 00 00 00       	mov    $0x1,%edx
    4d9e:	44 89 f1             	mov    %r14d,%ecx
    4da1:	48 d3 e2             	shl    %cl,%rdx
    4da4:	44 89 f1             	mov    %r14d,%ecx
    4da7:	c1 e9 06             	shr    $0x6,%ecx
    4daa:	48 8b 74 ce 28       	mov    0x28(%rsi,%rcx,8),%rsi
    4daf:	4c 0f a3 f6          	bt     %r14,%rsi
    4db3:	72 4b                	jb     4e00 <fwp_gc_mark+0xb0>
    4db5:	48 09 d6             	or     %rdx,%rsi
    4db8:	48 89 74 c8 28       	mov    %rsi,0x28(%rax,%rcx,8)
    4dbd:	80 78 01 01          	cmpb   $0x1,0x1(%rax)
    4dc1:	74 3d                	je     4e00 <fwp_gc_mark+0xb0>
    4dc3:	48 8b 3c 24          	mov    (%rsp),%rdi
    4dc7:	e8 b4 e1 ff ff       	call   2f80 <fwp_gc_chunk_addr>
    4dcc:	4c 0f af f3          	imul   %rbx,%r14
    4dd0:	49 01 c6             	add    %rax,%r14
    4dd3:	4c 89 f7             	mov    %r14,%rdi
    4dd6:	48 89 de             	mov    %rbx,%rsi
    4dd9:	eb 40                	jmp    4e1b <fwp_gc_mark+0xcb>
    4ddb:	8b 40 10             	mov    0x10(%rax),%eax
    4dde:	48 89 04 24          	mov    %rax,(%rsp)
    4de2:	48 69 c0 28 12 00 00 	imul   $0x1228,%rax,%rax
    4de9:	48 03 05 20 05 01 00 	add    0x10520(%rip),%rax        # 15310 <fwp_gc+0x1078>
    4df0:	80 78 03 00          	cmpb   $0x0,0x3(%rax)
    4df4:	75 0a                	jne    4e00 <fwp_gc_mark+0xb0>
    4df6:	c6 40 03 01          	movb   $0x1,0x3(%rax)
    4dfa:	80 78 01 01          	cmpb   $0x1,0x1(%rax)
    4dfe:	75 08                	jne    4e08 <fwp_gc_mark+0xb8>
    4e00:	48 83 c4 08          	add    $0x8,%rsp
    4e04:	5b                   	pop    %rbx
    4e05:	41 5e                	pop    %r14
    4e07:	c3                   	ret
    4e08:	48 8b 3c 24          	mov    (%rsp),%rdi
    4e0c:	48 89 c3             	mov    %rax,%rbx
    4e0f:	e8 6c e1 ff ff       	call   2f80 <fwp_gc_chunk_addr>
    4e14:	48 8b 73 18          	mov    0x18(%rbx),%rsi
    4e18:	48 89 c7             	mov    %rax,%rdi
    4e1b:	48 83 c4 08          	add    $0x8,%rsp
    4e1f:	5b                   	pop    %rbx
    4e20:	41 5e                	pop    %r14
    4e22:	eb 3c                	jmp    4e60 <fwp_gc_push>
    4e24:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    4e2b:	00 00 00 00 00 

0000000000004e30 <fwp_gc_chunk_of>:
    4e30:	48 2b 3d 91 04 01 00 	sub    0x10491(%rip),%rdi        # 152c8 <fwp_gc+0x1030>
    4e37:	48 8b 05 b2 04 01 00 	mov    0x104b2(%rip),%rax        # 152f0 <fwp_gc+0x1058>
    4e3e:	48 c1 e0 10          	shl    $0x10,%rax
    4e42:	48 39 c7             	cmp    %rax,%rdi
    4e45:	73 16                	jae    4e5d <fwp_gc_chunk_of+0x2d>
    4e47:	48 c1 ef 10          	shr    $0x10,%rdi
    4e4b:	48 89 3e             	mov    %rdi,(%rsi)
    4e4e:	48 69 c7 28 12 00 00 	imul   $0x1228,%rdi,%rax
    4e55:	48 03 05 b4 04 01 00 	add    0x104b4(%rip),%rax        # 15310 <fwp_gc+0x1078>
    4e5c:	c3                   	ret
    4e5d:	31 c0                	xor    %eax,%eax
    4e5f:	c3                   	ret

0000000000004e60 <fwp_gc_push>:
    4e60:	41 56                	push   %r14
    4e62:	53                   	push   %rbx
    4e63:	50                   	push   %rax
    4e64:	48 89 f3             	mov    %rsi,%rbx
    4e67:	49 89 fe             	mov    %rdi,%r14
    4e6a:	48 8b 0d c7 05 01 00 	mov    0x105c7(%rip),%rcx        # 15438 <fwp_gc+0x11a0>
    4e71:	48 8b 05 b8 05 01 00 	mov    0x105b8(%rip),%rax        # 15430 <fwp_gc+0x1198>
    4e78:	48 3b 0d c1 05 01 00 	cmp    0x105c1(%rip),%rcx        # 15440 <fwp_gc+0x11a8>
    4e7f:	75 36                	jne    4eb7 <fwp_gc_push+0x57>
    4e81:	48 8d 14 09          	lea    (%rcx,%rcx,1),%rdx
    4e85:	48 85 c9             	test   %rcx,%rcx
    4e88:	be 00 10 00 00       	mov    $0x1000,%esi
    4e8d:	48 0f 45 f2          	cmovne %rdx,%rsi
    4e91:	48 89 35 a8 05 01 00 	mov    %rsi,0x105a8(%rip)        # 15440 <fwp_gc+0x11a8>
    4e98:	48 c1 e6 04          	shl    $0x4,%rsi
    4e9c:	48 89 c7             	mov    %rax,%rdi
    4e9f:	e8 dc d4 ff ff       	call   2380 <realloc@plt>
    4ea4:	48 89 05 85 05 01 00 	mov    %rax,0x10585(%rip)        # 15430 <fwp_gc+0x1198>
    4eab:	48 85 c0             	test   %rax,%rax
    4eae:	74 29                	je     4ed9 <fwp_gc_push+0x79>
    4eb0:	48 8b 0d 81 05 01 00 	mov    0x10581(%rip),%rcx        # 15438 <fwp_gc+0x11a0>
    4eb7:	48 89 ca             	mov    %rcx,%rdx
    4eba:	48 c1 e2 04          	shl    $0x4,%rdx
    4ebe:	4c 89 34 10          	mov    %r14,(%rax,%rdx,1)
    4ec2:	48 89 5c 10 08       	mov    %rbx,0x8(%rax,%rdx,1)
    4ec7:	48 ff c1             	inc    %rcx
    4eca:	48 89 0d 67 05 01 00 	mov    %rcx,0x10567(%rip)        # 15438 <fwp_gc+0x11a0>
    4ed1:	48 83 c4 08          	add    $0x8,%rsp
    4ed5:	5b                   	pop    %rbx
    4ed6:	41 5e                	pop    %r14
    4ed8:	c3                   	ret
    4ed9:	e8 02 ec ff ff       	call   3ae0 <fwp_gc_oom>
    4ede:	66 90                	xchg   %ax,%ax

0000000000004ee0 <fwp_gc_marked>:
    4ee0:	53                   	push   %rbx
    4ee1:	48 83 ec 10          	sub    $0x10,%rsp
    4ee5:	48 89 fb             	mov    %rdi,%rbx
    4ee8:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    4eed:	e8 3e ff ff ff       	call   4e30 <fwp_gc_chunk_of>
    4ef2:	48 85 c0             	test   %rax,%rax
    4ef5:	74 36                	je     4f2d <fwp_gc_marked+0x4d>
    4ef7:	0f b6 08             	movzbl (%rax),%ecx
    4efa:	80 f9 03             	cmp    $0x3,%cl
    4efd:	75 19                	jne    4f18 <fwp_gc_marked+0x38>
    4eff:	48 8b 0d 0a 04 01 00 	mov    0x1040a(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    4f06:	8b 40 10             	mov    0x10(%rax),%eax
    4f09:	48 69 d0 28 12 00 00 	imul   $0x1228,%rax,%rdx
    4f10:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    4f14:	0f b6 0c 11          	movzbl (%rcx,%rdx,1),%ecx
    4f18:	80 f9 01             	cmp    $0x1,%cl
    4f1b:	74 17                	je     4f34 <fwp_gc_marked+0x54>
    4f1d:	0f b6 d1             	movzbl %cl,%edx
    4f20:	31 c9                	xor    %ecx,%ecx
    4f22:	83 fa 02             	cmp    $0x2,%edx
    4f25:	75 33                	jne    4f5a <fwp_gc_marked+0x7a>
    4f27:	0f b6 48 03          	movzbl 0x3(%rax),%ecx
    4f2b:	eb 2d                	jmp    4f5a <fwp_gc_marked+0x7a>
    4f2d:	b9 01 00 00 00       	mov    $0x1,%ecx
    4f32:	eb 26                	jmp    4f5a <fwp_gc_marked+0x7a>
    4f34:	0f b7 cb             	movzwl %bx,%ecx
    4f37:	48 89 c6             	mov    %rax,%rsi
    4f3a:	89 c8                	mov    %ecx,%eax
    4f3c:	31 d2                	xor    %edx,%edx
    4f3e:	f7 76 08             	divl   0x8(%rsi)
    4f41:	89 c1                	mov    %eax,%ecx
    4f43:	c1 e9 03             	shr    $0x3,%ecx
    4f46:	81 e1 f8 1f 00 00    	and    $0x1ff8,%ecx
    4f4c:	48 8b 54 0e 28       	mov    0x28(%rsi,%rcx,1),%rdx
    4f51:	31 c9                	xor    %ecx,%ecx
    4f53:	48 0f a3 c2          	bt     %rax,%rdx
    4f57:	0f 92 c1             	setb   %cl
    4f5a:	89 c8                	mov    %ecx,%eax
    4f5c:	48 83 c4 10          	add    $0x10,%rsp
    4f60:	5b                   	pop    %rbx
    4f61:	c3                   	ret
    4f62:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4f69:	1f 84 00 00 00 00 00 

0000000000004f70 <fwp_rc_clear_chunk>:
    4f70:	41 57                	push   %r15
    4f72:	41 56                	push   %r14
    4f74:	53                   	push   %rbx
    4f75:	48 89 fb             	mov    %rdi,%rbx
    4f78:	48 83 3d 30 0d 01 00 	cmpq   $0x0,0x10d30(%rip)        # 15cb0 <fwp_gc+0x1a18>
    4f7f:	00 
    4f80:	74 2c                	je     4fae <fwp_rc_clear_chunk+0x3e>
    4f82:	4c 8d b3 28 02 00 00 	lea    0x228(%rbx),%r14
    4f89:	45 31 ff             	xor    %r15d,%r15d
    4f8c:	eb 0e                	jmp    4f9c <fwp_rc_clear_chunk+0x2c>
    4f8e:	66 90                	xchg   %ax,%ax
    4f90:	49 ff c7             	inc    %r15
    4f93:	49 81 ff 00 10 00 00 	cmp    $0x1000,%r15
    4f9a:	74 12                	je     4fae <fwp_rc_clear_chunk+0x3e>
    4f9c:	43 80 3c 3e ff       	cmpb   $0xff,(%r14,%r15,1)
    4fa1:	75 ed                	jne    4f90 <fwp_rc_clear_chunk+0x20>
    4fa3:	4b 8d 3c 3e          	lea    (%r14,%r15,1),%rdi
    4fa7:	e8 e4 df ff ff       	call   2f90 <fwp_rc_forget_slot>
    4fac:	eb e2                	jmp    4f90 <fwp_rc_clear_chunk+0x20>
    4fae:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    4fb5:	ba 00 10 00 00       	mov    $0x1000,%edx
    4fba:	48 89 df             	mov    %rbx,%rdi
    4fbd:	31 f6                	xor    %esi,%esi
    4fbf:	5b                   	pop    %rbx
    4fc0:	41 5e                	pop    %r14
    4fc2:	41 5f                	pop    %r15
    4fc4:	e9 47 d2 ff ff       	jmp    2210 <memset@plt>
    4fc9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000004fd0 <f2>:
    4fd0:	55                   	push   %rbp
    4fd1:	41 57                	push   %r15
    4fd3:	41 56                	push   %r14
    4fd5:	41 55                	push   %r13
    4fd7:	41 54                	push   %r12
    4fd9:	53                   	push   %rbx
    4fda:	48 81 ec e8 00 00 00 	sub    $0xe8,%rsp
    4fe1:	48 89 fe             	mov    %rdi,%rsi
    4fe4:	48 8d bc 24 90 00 00 	lea    0x90(%rsp),%rdi
    4feb:	00 
    4fec:	e8 ff 00 00 00       	call   50f0 <w2>
    4ff1:	48 8b 84 24 90 00 00 	mov    0x90(%rsp),%rax
    4ff8:	00 
    4ff9:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    4ffe:	48 8b 8c 24 98 00 00 	mov    0x98(%rsp),%rcx
    5005:	00 
    5006:	48 89 0c 24          	mov    %rcx,(%rsp)
    500a:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    500f:	48 89 4c 24 58       	mov    %rcx,0x58(%rsp)
    5014:	4c 8b a4 24 a0 00 00 	mov    0xa0(%rsp),%r12
    501b:	00 
    501c:	4c 89 64 24 60       	mov    %r12,0x60(%rsp)
    5021:	4c 8b ac 24 a8 00 00 	mov    0xa8(%rsp),%r13
    5028:	00 
    5029:	4c 89 6c 24 68       	mov    %r13,0x68(%rsp)
    502e:	48 8b ac 24 b0 00 00 	mov    0xb0(%rsp),%rbp
    5035:	00 
    5036:	48 89 6c 24 70       	mov    %rbp,0x70(%rsp)
    503b:	48 8b 9c 24 b8 00 00 	mov    0xb8(%rsp),%rbx
    5042:	00 
    5043:	48 89 5c 24 78       	mov    %rbx,0x78(%rsp)
    5048:	4c 8b b4 24 c0 00 00 	mov    0xc0(%rsp),%r14
    504f:	00 
    5050:	4c 89 b4 24 80 00 00 	mov    %r14,0x80(%rsp)
    5057:	00 
    5058:	4c 8b bc 24 c8 00 00 	mov    0xc8(%rsp),%r15
    505f:	00 
    5060:	4c 89 bc 24 88 00 00 	mov    %r15,0x88(%rsp)
    5067:	00 
    5068:	48 8d 35 91 03 00 00 	lea    0x391(%rip),%rsi        # 5400 <fwp_owner_release7>
    506f:	48 8d bc 24 d0 00 00 	lea    0xd0(%rsp),%rdi
    5076:	00 
    5077:	48 8d 54 24 50       	lea    0x50(%rsp),%rdx
    507c:	e8 5f 03 00 00       	call   53e0 <fwp_cleanup_push>
    5081:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    5086:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    508b:	48 8b 04 24          	mov    (%rsp),%rax
    508f:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    5094:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
    5099:	4c 89 6c 24 28       	mov    %r13,0x28(%rsp)
    509e:	48 89 6c 24 30       	mov    %rbp,0x30(%rsp)
    50a3:	48 89 5c 24 38       	mov    %rbx,0x38(%rsp)
    50a8:	4c 89 74 24 40       	mov    %r14,0x40(%rsp)
    50ad:	4c 89 7c 24 48       	mov    %r15,0x48(%rsp)
    50b2:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    50b7:	bf 08 00 00 00       	mov    $0x8,%edi
    50bc:	e8 4f e0 ff ff       	call   3110 <fwp_record>
    50c1:	49 89 c6             	mov    %rax,%r14
    50c4:	48 89 c7             	mov    %rax,%rdi
    50c7:	e8 04 e0 ff ff       	call   30d0 <fwp_rc_fresh>
    50cc:	48 8d bc 24 d0 00 00 	lea    0xd0(%rsp),%rdi
    50d3:	00 
    50d4:	e8 77 03 00 00       	call   5450 <fwp_cleanup_pop>
    50d9:	4c 89 f0             	mov    %r14,%rax
    50dc:	48 81 c4 e8 00 00 00 	add    $0xe8,%rsp
    50e3:	5b                   	pop    %rbx
    50e4:	41 5c                	pop    %r12
    50e6:	41 5d                	pop    %r13
    50e8:	41 5e                	pop    %r14
    50ea:	41 5f                	pop    %r15
    50ec:	5d                   	pop    %rbp
    50ed:	c3                   	ret
    50ee:	66 90                	xchg   %ax,%ax

00000000000050f0 <w2>:
    50f0:	55                   	push   %rbp
    50f1:	41 57                	push   %r15
    50f3:	41 56                	push   %r14
    50f5:	41 55                	push   %r13
    50f7:	41 54                	push   %r12
    50f9:	53                   	push   %rbx
    50fa:	48 81 ec b8 01 00 00 	sub    $0x1b8,%rsp
    5101:	49 89 f6             	mov    %rsi,%r14
    5104:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
    5109:	48 89 f7             	mov    %rsi,%rdi
    510c:	48 c7 c6 80 ff ff ff 	mov    $0xffffffffffffff80,%rsi
    5113:	e8 58 03 00 00       	call   5470 <f12>
    5118:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    511d:	49 89 c7             	mov    %rax,%r15
    5120:	48 8d 35 59 03 00 00 	lea    0x359(%rip),%rsi        # 5480 <fwp_owner_release0>
    5127:	4c 8d ac 24 a0 01 00 	lea    0x1a0(%rsp),%r13
    512e:	00 
    512f:	48 8d 54 24 30       	lea    0x30(%rsp),%rdx
    5134:	4c 89 ef             	mov    %r13,%rdi
    5137:	e8 a4 02 00 00       	call   53e0 <fwp_cleanup_push>
    513c:	be ff 00 00 00       	mov    $0xff,%esi
    5141:	4c 89 f7             	mov    %r14,%rdi
    5144:	e8 47 03 00 00       	call   5490 <f14>
    5149:	49 89 c4             	mov    %rax,%r12
    514c:	4c 89 ef             	mov    %r13,%rdi
    514f:	e8 fc 02 00 00       	call   5450 <fwp_cleanup_pop>
    5154:	4c 89 7c 24 38       	mov    %r15,0x38(%rsp)
    5159:	4c 89 64 24 40       	mov    %r12,0x40(%rsp)
    515e:	48 8d 35 3b 03 00 00 	lea    0x33b(%rip),%rsi        # 54a0 <fwp_owner_release1>
    5165:	4c 8d ac 24 88 01 00 	lea    0x188(%rsp),%r13
    516c:	00 
    516d:	48 8d 54 24 38       	lea    0x38(%rsp),%rdx
    5172:	4c 89 ef             	mov    %r13,%rdi
    5175:	e8 66 02 00 00       	call   53e0 <fwp_cleanup_push>
    517a:	4c 89 f7             	mov    %r14,%rdi
    517d:	48 c7 c6 00 80 ff ff 	mov    $0xffffffffffff8000,%rsi
    5184:	e8 37 03 00 00       	call   54c0 <f16>
    5189:	48 89 c5             	mov    %rax,%rbp
    518c:	4c 89 ef             	mov    %r13,%rdi
    518f:	e8 bc 02 00 00       	call   5450 <fwp_cleanup_pop>
    5194:	4c 89 7c 24 48       	mov    %r15,0x48(%rsp)
    5199:	4c 89 64 24 50       	mov    %r12,0x50(%rsp)
    519e:	48 89 6c 24 58       	mov    %rbp,0x58(%rsp)
    51a3:	48 8d 35 26 03 00 00 	lea    0x326(%rip),%rsi        # 54d0 <fwp_owner_release2>
    51aa:	48 8d 9c 24 70 01 00 	lea    0x170(%rsp),%rbx
    51b1:	00 
    51b2:	48 8d 54 24 48       	lea    0x48(%rsp),%rdx
    51b7:	48 89 df             	mov    %rbx,%rdi
    51ba:	e8 21 02 00 00       	call   53e0 <fwp_cleanup_push>
    51bf:	be ff ff 00 00       	mov    $0xffff,%esi
    51c4:	4c 89 f7             	mov    %r14,%rdi
    51c7:	e8 24 03 00 00       	call   54f0 <f18>
    51cc:	49 89 c5             	mov    %rax,%r13
    51cf:	48 89 df             	mov    %rbx,%rdi
    51d2:	e8 79 02 00 00       	call   5450 <fwp_cleanup_pop>
    51d7:	4c 89 7c 24 60       	mov    %r15,0x60(%rsp)
    51dc:	4c 89 3c 24          	mov    %r15,(%rsp)
    51e0:	4c 89 64 24 68       	mov    %r12,0x68(%rsp)
    51e5:	4c 89 e3             	mov    %r12,%rbx
    51e8:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
    51ed:	48 89 6c 24 70       	mov    %rbp,0x70(%rsp)
    51f2:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
    51f7:	4c 89 6c 24 78       	mov    %r13,0x78(%rsp)
    51fc:	48 8d 35 fd 02 00 00 	lea    0x2fd(%rip),%rsi        # 5500 <fwp_owner_release3>
    5203:	48 8d bc 24 40 01 00 	lea    0x140(%rsp),%rdi
    520a:	00 
    520b:	48 8d 54 24 60       	lea    0x60(%rsp),%rdx
    5210:	e8 cb 01 00 00       	call   53e0 <fwp_cleanup_push>
    5215:	4c 89 f7             	mov    %r14,%rdi
    5218:	48 c7 c6 00 00 00 80 	mov    $0xffffffff80000000,%rsi
    521f:	e8 0c 03 00 00       	call   5530 <f20>
    5224:	49 89 c4             	mov    %rax,%r12
    5227:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    522c:	48 8d bc 24 40 01 00 	lea    0x140(%rsp),%rdi
    5233:	00 
    5234:	e8 17 02 00 00       	call   5450 <fwp_cleanup_pop>
    5239:	4c 89 bc 24 80 00 00 	mov    %r15,0x80(%rsp)
    5240:	00 
    5241:	48 89 9c 24 88 00 00 	mov    %rbx,0x88(%rsp)
    5248:	00 
    5249:	48 89 ac 24 90 00 00 	mov    %rbp,0x90(%rsp)
    5250:	00 
    5251:	4c 89 ac 24 98 00 00 	mov    %r13,0x98(%rsp)
    5258:	00 
    5259:	4c 89 a4 24 a0 00 00 	mov    %r12,0xa0(%rsp)
    5260:	00 
    5261:	48 8d 35 d8 02 00 00 	lea    0x2d8(%rip),%rsi        # 5540 <fwp_owner_release4>
    5268:	4c 8d a4 24 58 01 00 	lea    0x158(%rsp),%r12
    526f:	00 
    5270:	48 8d 94 24 80 00 00 	lea    0x80(%rsp),%rdx
    5277:	00 
    5278:	4c 89 e7             	mov    %r12,%rdi
    527b:	e8 60 01 00 00       	call   53e0 <fwp_cleanup_push>
    5280:	b8 00 00 00 80       	mov    $0x80000000,%eax
    5285:	48 8d b0 ff ff ff 7f 	lea    0x7fffffff(%rax),%rsi
    528c:	4c 89 f7             	mov    %r14,%rdi
    528f:	4c 89 f3             	mov    %r14,%rbx
    5292:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    5297:	e8 e4 02 00 00       	call   5580 <f22>
    529c:	49 89 c7             	mov    %rax,%r15
    529f:	4c 89 e7             	mov    %r12,%rdi
    52a2:	e8 a9 01 00 00       	call   5450 <fwp_cleanup_pop>
    52a7:	48 8b 04 24          	mov    (%rsp),%rax
    52ab:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
    52b2:	00 
    52b3:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
    52b8:	48 89 ac 24 b0 00 00 	mov    %rbp,0xb0(%rsp)
    52bf:	00 
    52c0:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    52c5:	4c 89 a4 24 b8 00 00 	mov    %r12,0xb8(%rsp)
    52cc:	00 
    52cd:	4c 89 ac 24 c0 00 00 	mov    %r13,0xc0(%rsp)
    52d4:	00 
    52d5:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
    52da:	4c 89 b4 24 c8 00 00 	mov    %r14,0xc8(%rsp)
    52e1:	00 
    52e2:	4c 89 bc 24 d0 00 00 	mov    %r15,0xd0(%rsp)
    52e9:	00 
    52ea:	48 8d 35 9f 02 00 00 	lea    0x29f(%rip),%rsi        # 5590 <fwp_owner_release5>
    52f1:	48 8d bc 24 28 01 00 	lea    0x128(%rsp),%rdi
    52f8:	00 
    52f9:	48 8d 94 24 a8 00 00 	lea    0xa8(%rsp),%rdx
    5300:	00 
    5301:	e8 da 00 00 00       	call   53e0 <fwp_cleanup_push>
    5306:	be 00 00 00 80       	mov    $0x80000000,%esi
    530b:	48 89 df             	mov    %rbx,%rdi
    530e:	e8 bd 02 00 00       	call   55d0 <f24>
    5313:	48 89 c3             	mov    %rax,%rbx
    5316:	48 8d bc 24 28 01 00 	lea    0x128(%rsp),%rdi
    531d:	00 
    531e:	e8 2d 01 00 00       	call   5450 <fwp_cleanup_pop>
    5323:	48 8b 04 24          	mov    (%rsp),%rax
    5327:	48 89 84 24 d8 00 00 	mov    %rax,0xd8(%rsp)
    532e:	00 
    532f:	48 89 ac 24 e0 00 00 	mov    %rbp,0xe0(%rsp)
    5336:	00 
    5337:	4c 89 a4 24 e8 00 00 	mov    %r12,0xe8(%rsp)
    533e:	00 
    533f:	4c 89 ac 24 f0 00 00 	mov    %r13,0xf0(%rsp)
    5346:	00 
    5347:	4c 89 b4 24 f8 00 00 	mov    %r14,0xf8(%rsp)
    534e:	00 
    534f:	4c 89 bc 24 00 01 00 	mov    %r15,0x100(%rsp)
    5356:	00 
    5357:	48 89 9c 24 08 01 00 	mov    %rbx,0x108(%rsp)
    535e:	00 
    535f:	48 8d 35 7a 02 00 00 	lea    0x27a(%rip),%rsi        # 55e0 <fwp_owner_release6>
    5366:	48 8d bc 24 10 01 00 	lea    0x110(%rsp),%rdi
    536d:	00 
    536e:	48 8d 94 24 d8 00 00 	lea    0xd8(%rsp),%rdx
    5375:	00 
    5376:	e8 65 00 00 00       	call   53e0 <fwp_cleanup_push>
    537b:	48 be 00 00 00 00 00 	movabs $0x8000000000000000,%rsi
    5382:	00 00 80 
    5385:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    538a:	e8 a1 02 00 00       	call   5630 <f26>
    538f:	49 89 c6             	mov    %rax,%r14
    5392:	48 8d bc 24 10 01 00 	lea    0x110(%rsp),%rdi
    5399:	00 
    539a:	e8 b1 00 00 00       	call   5450 <fwp_cleanup_pop>
    539f:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    53a4:	48 8b 0c 24          	mov    (%rsp),%rcx
    53a8:	48 89 08             	mov    %rcx,(%rax)
    53ab:	48 89 68 08          	mov    %rbp,0x8(%rax)
    53af:	4c 89 60 10          	mov    %r12,0x10(%rax)
    53b3:	4c 89 68 18          	mov    %r13,0x18(%rax)
    53b7:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    53bc:	48 89 48 20          	mov    %rcx,0x20(%rax)
    53c0:	4c 89 78 28          	mov    %r15,0x28(%rax)
    53c4:	48 89 58 30          	mov    %rbx,0x30(%rax)
    53c8:	4c 89 70 38          	mov    %r14,0x38(%rax)
    53cc:	48 81 c4 b8 01 00 00 	add    $0x1b8,%rsp
    53d3:	5b                   	pop    %rbx
    53d4:	41 5c                	pop    %r12
    53d6:	41 5d                	pop    %r13
    53d8:	41 5e                	pop    %r14
    53da:	41 5f                	pop    %r15
    53dc:	5d                   	pop    %rbp
    53dd:	c3                   	ret
    53de:	66 90                	xchg   %ax,%ax

00000000000053e0 <fwp_cleanup_push>:
    53e0:	48 8b 05 f1 09 01 00 	mov    0x109f1(%rip),%rax        # 15dd8 <fwp_cleanups>
    53e7:	48 89 07             	mov    %rax,(%rdi)
    53ea:	48 89 77 08          	mov    %rsi,0x8(%rdi)
    53ee:	48 89 57 10          	mov    %rdx,0x10(%rdi)
    53f2:	48 89 3d df 09 01 00 	mov    %rdi,0x109df(%rip)        # 15dd8 <fwp_cleanups>
    53f9:	c3                   	ret
    53fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000005400 <fwp_owner_release7>:
    5400:	53                   	push   %rbx
    5401:	48 89 fb             	mov    %rdi,%rbx
    5404:	48 8b 3f             	mov    (%rdi),%rdi
    5407:	e8 34 03 00 00       	call   5740 <fwp_drop0>
    540c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    5410:	e8 eb 05 00 00       	call   5a00 <fwp_drop1>
    5415:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    5419:	e8 02 06 00 00       	call   5a20 <fwp_drop2>
    541e:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    5422:	e8 19 06 00 00       	call   5a40 <fwp_drop3>
    5427:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    542b:	e8 30 06 00 00       	call   5a60 <fwp_drop4>
    5430:	48 8b 7b 28          	mov    0x28(%rbx),%rdi
    5434:	e8 47 06 00 00       	call   5a80 <fwp_drop5>
    5439:	48 8b 7b 30          	mov    0x30(%rbx),%rdi
    543d:	e8 5e 06 00 00       	call   5aa0 <fwp_drop6>
    5442:	48 8b 7b 38          	mov    0x38(%rbx),%rdi
    5446:	5b                   	pop    %rbx
    5447:	e9 74 06 00 00       	jmp    5ac0 <fwp_drop7>
    544c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000005450 <fwp_cleanup_pop>:
    5450:	48 39 3d 81 09 01 00 	cmp    %rdi,0x10981(%rip)        # 15dd8 <fwp_cleanups>
    5457:	75 0b                	jne    5464 <fwp_cleanup_pop+0x14>
    5459:	48 8b 07             	mov    (%rdi),%rax
    545c:	48 89 05 75 09 01 00 	mov    %rax,0x10975(%rip)        # 15dd8 <fwp_cleanups>
    5463:	c3                   	ret
    5464:	50                   	push   %rax
    5465:	e8 06 cc ff ff       	call   2070 <abort@plt>
    546a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000005470 <f12>:
    5470:	e9 cb 01 00 00       	jmp    5640 <fwp_p_array_make_typed>
    5475:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    547c:	00 00 00 00 

0000000000005480 <fwp_owner_release0>:
    5480:	48 8b 3f             	mov    (%rdi),%rdi
    5483:	e9 b8 02 00 00       	jmp    5740 <fwp_drop0>
    5488:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    548f:	00 

0000000000005490 <f14>:
    5490:	e9 ab 01 00 00       	jmp    5640 <fwp_p_array_make_typed>
    5495:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    549c:	00 00 00 00 

00000000000054a0 <fwp_owner_release1>:
    54a0:	53                   	push   %rbx
    54a1:	48 89 fb             	mov    %rdi,%rbx
    54a4:	48 8b 3f             	mov    (%rdi),%rdi
    54a7:	e8 94 02 00 00       	call   5740 <fwp_drop0>
    54ac:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    54b0:	5b                   	pop    %rbx
    54b1:	e9 4a 05 00 00       	jmp    5a00 <fwp_drop1>
    54b6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    54bd:	00 00 00 

00000000000054c0 <f16>:
    54c0:	e9 7b 01 00 00       	jmp    5640 <fwp_p_array_make_typed>
    54c5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    54cc:	00 00 00 00 

00000000000054d0 <fwp_owner_release2>:
    54d0:	53                   	push   %rbx
    54d1:	48 89 fb             	mov    %rdi,%rbx
    54d4:	48 8b 3f             	mov    (%rdi),%rdi
    54d7:	e8 64 02 00 00       	call   5740 <fwp_drop0>
    54dc:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    54e0:	e8 1b 05 00 00       	call   5a00 <fwp_drop1>
    54e5:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    54e9:	5b                   	pop    %rbx
    54ea:	e9 31 05 00 00       	jmp    5a20 <fwp_drop2>
    54ef:	90                   	nop

00000000000054f0 <f18>:
    54f0:	e9 4b 01 00 00       	jmp    5640 <fwp_p_array_make_typed>
    54f5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    54fc:	00 00 00 00 

0000000000005500 <fwp_owner_release3>:
    5500:	53                   	push   %rbx
    5501:	48 89 fb             	mov    %rdi,%rbx
    5504:	48 8b 3f             	mov    (%rdi),%rdi
    5507:	e8 34 02 00 00       	call   5740 <fwp_drop0>
    550c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    5510:	e8 eb 04 00 00       	call   5a00 <fwp_drop1>
    5515:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    5519:	e8 02 05 00 00       	call   5a20 <fwp_drop2>
    551e:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    5522:	5b                   	pop    %rbx
    5523:	e9 18 05 00 00       	jmp    5a40 <fwp_drop3>
    5528:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    552f:	00 

0000000000005530 <f20>:
    5530:	e9 0b 01 00 00       	jmp    5640 <fwp_p_array_make_typed>
    5535:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    553c:	00 00 00 00 

0000000000005540 <fwp_owner_release4>:
    5540:	53                   	push   %rbx
    5541:	48 89 fb             	mov    %rdi,%rbx
    5544:	48 8b 3f             	mov    (%rdi),%rdi
    5547:	e8 f4 01 00 00       	call   5740 <fwp_drop0>
    554c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    5550:	e8 ab 04 00 00       	call   5a00 <fwp_drop1>
    5555:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    5559:	e8 c2 04 00 00       	call   5a20 <fwp_drop2>
    555e:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    5562:	e8 d9 04 00 00       	call   5a40 <fwp_drop3>
    5567:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    556b:	5b                   	pop    %rbx
    556c:	e9 ef 04 00 00       	jmp    5a60 <fwp_drop4>
    5571:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5578:	0f 1f 84 00 00 00 00 
    557f:	00 

0000000000005580 <f22>:
    5580:	e9 bb 00 00 00       	jmp    5640 <fwp_p_array_make_typed>
    5585:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    558c:	00 00 00 00 

0000000000005590 <fwp_owner_release5>:
    5590:	53                   	push   %rbx
    5591:	48 89 fb             	mov    %rdi,%rbx
    5594:	48 8b 3f             	mov    (%rdi),%rdi
    5597:	e8 a4 01 00 00       	call   5740 <fwp_drop0>
    559c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    55a0:	e8 5b 04 00 00       	call   5a00 <fwp_drop1>
    55a5:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    55a9:	e8 72 04 00 00       	call   5a20 <fwp_drop2>
    55ae:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    55b2:	e8 89 04 00 00       	call   5a40 <fwp_drop3>
    55b7:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    55bb:	e8 a0 04 00 00       	call   5a60 <fwp_drop4>
    55c0:	48 8b 7b 28          	mov    0x28(%rbx),%rdi
    55c4:	5b                   	pop    %rbx
    55c5:	e9 b6 04 00 00       	jmp    5a80 <fwp_drop5>
    55ca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000055d0 <f24>:
    55d0:	eb 6e                	jmp    5640 <fwp_p_array_make_typed>
    55d2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    55d9:	1f 84 00 00 00 00 00 

00000000000055e0 <fwp_owner_release6>:
    55e0:	53                   	push   %rbx
    55e1:	48 89 fb             	mov    %rdi,%rbx
    55e4:	48 8b 3f             	mov    (%rdi),%rdi
    55e7:	e8 54 01 00 00       	call   5740 <fwp_drop0>
    55ec:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    55f0:	e8 0b 04 00 00       	call   5a00 <fwp_drop1>
    55f5:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    55f9:	e8 22 04 00 00       	call   5a20 <fwp_drop2>
    55fe:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    5602:	e8 39 04 00 00       	call   5a40 <fwp_drop3>
    5607:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    560b:	e8 50 04 00 00       	call   5a60 <fwp_drop4>
    5610:	48 8b 7b 28          	mov    0x28(%rbx),%rdi
    5614:	e8 67 04 00 00       	call   5a80 <fwp_drop5>
    5619:	48 8b 7b 30          	mov    0x30(%rbx),%rdi
    561d:	5b                   	pop    %rbx
    561e:	e9 7d 04 00 00       	jmp    5aa0 <fwp_drop6>
    5623:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    562a:	84 00 00 00 00 00 

0000000000005630 <f26>:
    5630:	eb 0e                	jmp    5640 <fwp_p_array_make_typed>
    5632:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5639:	1f 84 00 00 00 00 00 

0000000000005640 <fwp_p_array_make_typed>:
    5640:	41 56                	push   %r14
    5642:	53                   	push   %rbx
    5643:	50                   	push   %rax
    5644:	48 89 f3             	mov    %rsi,%rbx
    5647:	e8 64 00 00 00       	call   56b0 <fwp_count_arg>
    564c:	49 89 c6             	mov    %rax,%r14
    564f:	48 89 c7             	mov    %rax,%rdi
    5652:	e8 69 00 00 00       	call   56c0 <fwp_array_typed_new>
    5657:	4d 85 f6             	test   %r14,%r14
    565a:	74 48                	je     56a4 <fwp_p_array_make_typed+0x64>
    565c:	49 83 fe 04          	cmp    $0x4,%r14
    5660:	73 04                	jae    5666 <fwp_p_array_make_typed+0x26>
    5662:	31 c9                	xor    %ecx,%ecx
    5664:	eb 31                	jmp    5697 <fwp_p_array_make_typed+0x57>
    5666:	4c 89 f1             	mov    %r14,%rcx
    5669:	48 83 e1 fc          	and    $0xfffffffffffffffc,%rcx
    566d:	66 48 0f 6e c3       	movq   %rbx,%xmm0
    5672:	66 0f 70 c0 44       	pshufd $0x44,%xmm0,%xmm0
    5677:	31 d2                	xor    %edx,%edx
    5679:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    5680:	f3 0f 7f 44 d0 08    	movdqu %xmm0,0x8(%rax,%rdx,8)
    5686:	f3 0f 7f 44 d0 18    	movdqu %xmm0,0x18(%rax,%rdx,8)
    568c:	48 83 c2 04          	add    $0x4,%rdx
    5690:	48 39 d1             	cmp    %rdx,%rcx
    5693:	75 eb                	jne    5680 <fwp_p_array_make_typed+0x40>
    5695:	eb 08                	jmp    569f <fwp_p_array_make_typed+0x5f>
    5697:	48 89 5c c8 08       	mov    %rbx,0x8(%rax,%rcx,8)
    569c:	48 ff c1             	inc    %rcx
    569f:	49 39 ce             	cmp    %rcx,%r14
    56a2:	75 f3                	jne    5697 <fwp_p_array_make_typed+0x57>
    56a4:	48 83 c4 08          	add    $0x8,%rsp
    56a8:	5b                   	pop    %rbx
    56a9:	41 5e                	pop    %r14
    56ab:	c3                   	ret
    56ac:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000056b0 <fwp_count_arg>:
    56b0:	31 c0                	xor    %eax,%eax
    56b2:	48 85 ff             	test   %rdi,%rdi
    56b5:	48 0f 4f c7          	cmovg  %rdi,%rax
    56b9:	c3                   	ret
    56ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000056c0 <fwp_array_typed_new>:
    56c0:	50                   	push   %rax
    56c1:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    56c8:	ff ff 1f 
    56cb:	48 39 c7             	cmp    %rax,%rdi
    56ce:	73 0e                	jae    56de <fwp_array_typed_new+0x1e>
    56d0:	e8 1b 00 00 00       	call   56f0 <fwp_arr_new>
    56d5:	48 89 c7             	mov    %rax,%rdi
    56d8:	58                   	pop    %rax
    56d9:	e9 f2 d9 ff ff       	jmp    30d0 <fwp_rc_fresh>
    56de:	48 8d 3d 54 91 00 00 	lea    0x9154(%rip),%rdi        # e839 <exec_in_fp0+0x1e9>
    56e5:	e8 46 d9 ff ff       	call   3030 <fwp_trap>
    56ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000056f0 <fwp_arr_new>:
    56f0:	53                   	push   %rbx
    56f1:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    56f8:	ff ff 1f 
    56fb:	48 39 c7             	cmp    %rax,%rdi
    56fe:	73 15                	jae    5715 <fwp_arr_new+0x25>
    5700:	48 89 fb             	mov    %rdi,%rbx
    5703:	48 8d 3c fd 08 00 00 	lea    0x8(,%rdi,8),%rdi
    570a:	00 
    570b:	e8 20 00 00 00       	call   5730 <fwp_alloc>
    5710:	48 89 18             	mov    %rbx,(%rax)
    5713:	5b                   	pop    %rbx
    5714:	c3                   	ret
    5715:	48 8d 3d 1d 91 00 00 	lea    0x911d(%rip),%rdi        # e839 <exec_in_fp0+0x1e9>
    571c:	e8 0f d9 ff ff       	call   3030 <fwp_trap>
    5721:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5728:	0f 1f 84 00 00 00 00 
    572f:	00 

0000000000005730 <fwp_alloc>:
    5730:	be 02 00 00 00       	mov    $0x2,%esi
    5735:	e9 b6 db ff ff       	jmp    32f0 <fwp_gc_alloc>
    573a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000005740 <fwp_drop0>:
    5740:	53                   	push   %rbx
    5741:	48 89 fb             	mov    %rdi,%rbx
    5744:	e8 57 d3 ff ff       	call   2aa0 <fwp_rc_release_last>
    5749:	85 c0                	test   %eax,%eax
    574b:	74 06                	je     5753 <fwp_drop0+0x13>
    574d:	48 89 df             	mov    %rbx,%rdi
    5750:	5b                   	pop    %rbx
    5751:	eb 0d                	jmp    5760 <fwp_rc_free_arr>
    5753:	5b                   	pop    %rbx
    5754:	c3                   	ret
    5755:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    575c:	00 00 00 00 

0000000000005760 <fwp_rc_free_arr>:
    5760:	41 56                	push   %r14
    5762:	53                   	push   %rbx
    5763:	50                   	push   %rax
    5764:	48 89 fb             	mov    %rdi,%rbx
    5767:	e8 94 00 00 00       	call   5800 <fwp_rc_last>
    576c:	85 c0                	test   %eax,%eax
    576e:	74 7d                	je     57ed <fwp_rc_free_arr+0x8d>
    5770:	8b 0d 42 05 01 00    	mov    0x10542(%rip),%ecx        # 15cb8 <fwp_reuse_verify>
    5776:	85 c9                	test   %ecx,%ecx
    5778:	78 0d                	js     5787 <fwp_rc_free_arr+0x27>
    577a:	85 c9                	test   %ecx,%ecx
    577c:	74 41                	je     57bf <fwp_rc_free_arr+0x5f>
    577e:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    5785:	eb 66                	jmp    57ed <fwp_rc_free_arr+0x8d>
    5787:	48 8d 3d bb 90 00 00 	lea    0x90bb(%rip),%rdi        # e849 <exec_in_fp0+0x1f9>
    578e:	e8 9d c8 ff ff       	call   2030 <getenv@plt>
    5793:	31 c9                	xor    %ecx,%ecx
    5795:	48 85 c0             	test   %rax,%rax
    5798:	74 1b                	je     57b5 <fwp_rc_free_arr+0x55>
    579a:	80 38 00             	cmpb   $0x0,(%rax)
    579d:	74 16                	je     57b5 <fwp_rc_free_arr+0x55>
    579f:	48 8d 35 d5 9b 00 00 	lea    0x9bd5(%rip),%rsi        # f37b <exec_in_fp0+0xd2b>
    57a6:	48 89 c7             	mov    %rax,%rdi
    57a9:	e8 22 cb ff ff       	call   22d0 <strcmp@plt>
    57ae:	31 c9                	xor    %ecx,%ecx
    57b0:	85 c0                	test   %eax,%eax
    57b2:	0f 95 c1             	setne  %cl
    57b5:	89 0d fd 04 01 00    	mov    %ecx,0x104fd(%rip)        # 15cb8 <fwp_reuse_verify>
    57bb:	85 c9                	test   %ecx,%ecx
    57bd:	75 bf                	jne    577e <fwp_rc_free_arr+0x1e>
    57bf:	4c 8b 35 d2 ea 00 00 	mov    0xead2(%rip),%r14        # 14298 <fwp_gc>
    57c6:	48 89 df             	mov    %rbx,%rdi
    57c9:	e8 52 00 00 00       	call   5820 <fwp_mem_free>
    57ce:	48 8b 05 c3 ea 00 00 	mov    0xeac3(%rip),%rax        # 14298 <fwp_gc>
    57d5:	4c 29 f0             	sub    %r14,%rax
    57d8:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    57dd:	f2 0f 58 05 bb fc 00 	addsd  0xfcbb(%rip),%xmm0        # 154a0 <fwp_gc+0x1208>
    57e4:	00 
    57e5:	f2 0f 11 05 b3 fc 00 	movsd  %xmm0,0xfcb3(%rip)        # 154a0 <fwp_gc+0x1208>
    57ec:	00 
    57ed:	48 83 c4 08          	add    $0x8,%rsp
    57f1:	5b                   	pop    %rbx
    57f2:	41 5e                	pop    %r14
    57f4:	c3                   	ret
    57f5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    57fc:	00 00 00 00 

0000000000005800 <fwp_rc_last>:
    5800:	50                   	push   %rax
    5801:	e8 ea d6 ff ff       	call   2ef0 <fwp_rc_slot>
    5806:	48 85 c0             	test   %rax,%rax
    5809:	74 0d                	je     5818 <fwp_rc_last+0x18>
    580b:	48 89 c1             	mov    %rax,%rcx
    580e:	31 c0                	xor    %eax,%eax
    5810:	80 39 01             	cmpb   $0x1,(%rcx)
    5813:	0f 94 c0             	sete   %al
    5816:	59                   	pop    %rcx
    5817:	c3                   	ret
    5818:	31 c0                	xor    %eax,%eax
    581a:	59                   	pop    %rcx
    581b:	c3                   	ret
    581c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000005820 <fwp_mem_free>:
    5820:	48 85 ff             	test   %rdi,%rdi
    5823:	0f 84 c7 01 00 00    	je     59f0 <fwp_mem_free+0x1d0>
    5829:	41 57                	push   %r15
    582b:	41 56                	push   %r14
    582d:	53                   	push   %rbx
    582e:	48 83 ec 10          	sub    $0x10,%rsp
    5832:	49 89 ff             	mov    %rdi,%r15
    5835:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    583a:	e8 f1 f5 ff ff       	call   4e30 <fwp_gc_chunk_of>
    583f:	48 85 c0             	test   %rax,%rax
    5842:	0f 84 9f 01 00 00    	je     59e7 <fwp_mem_free+0x1c7>
    5848:	49 89 c6             	mov    %rax,%r14
    584b:	0f b6 00             	movzbl (%rax),%eax
    584e:	83 f8 02             	cmp    $0x2,%eax
    5851:	0f 84 96 00 00 00    	je     58ed <fwp_mem_free+0xcd>
    5857:	83 f8 01             	cmp    $0x1,%eax
    585a:	0f 85 87 01 00 00    	jne    59e7 <fwp_mem_free+0x1c7>
    5860:	41 0f b6 46 01       	movzbl 0x1(%r14),%eax
    5865:	41 0f b6 4e 02       	movzbl 0x2(%r14),%ecx
    586a:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    5871:	48 8d 35 20 ea 00 00 	lea    0xea20(%rip),%rsi        # 14298 <fwp_gc>
    5878:	48 01 c6             	add    %rax,%rsi
    587b:	48 8d 3c 49          	lea    (%rcx,%rcx,2),%rdi
    587f:	41 0f b7 c7          	movzwl %r15w,%eax
    5883:	31 d2                	xor    %edx,%edx
    5885:	41 f7 76 08          	divl   0x8(%r14)
    5889:	48 c7 c2 fe ff ff ff 	mov    $0xfffffffffffffffe,%rdx
    5890:	89 c1                	mov    %eax,%ecx
    5892:	48 d3 c2             	rol    %cl,%rdx
    5895:	48 8d 1c fe          	lea    (%rsi,%rdi,8),%rbx
    5899:	48 83 c3 08          	add    $0x8,%rbx
    589d:	49 8d 3c 06          	lea    (%r14,%rax,1),%rdi
    58a1:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    58a8:	c1 e8 03             	shr    $0x3,%eax
    58ab:	25 f8 1f 00 00       	and    $0x1ff8,%eax
    58b0:	49 21 54 06 28       	and    %rdx,0x28(%r14,%rax,1)
    58b5:	e8 a6 d6 ff ff       	call   2f60 <fwp_rc_clear_slot>
    58ba:	83 3d db f9 00 00 00 	cmpl   $0x0,0xf9db(%rip)        # 1529c <fwp_gc+0x1004>
    58c1:	74 0e                	je     58d1 <fwp_mem_free+0xb1>
    58c3:	41 8b 56 08          	mov    0x8(%r14),%edx
    58c7:	4c 89 ff             	mov    %r15,%rdi
    58ca:	31 f6                	xor    %esi,%esi
    58cc:	e8 3f c9 ff ff       	call   2210 <memset@plt>
    58d1:	48 8b 03             	mov    (%rbx),%rax
    58d4:	48 f7 d0             	not    %rax
    58d7:	49 89 07             	mov    %rax,(%r15)
    58da:	4c 89 3b             	mov    %r15,(%rbx)
    58dd:	41 8b 46 08          	mov    0x8(%r14),%eax
    58e1:	48 01 05 b0 e9 00 00 	add    %rax,0xe9b0(%rip)        # 14298 <fwp_gc>
    58e8:	e9 fa 00 00 00       	jmp    59e7 <fwp_mem_free+0x1c7>
    58ed:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    58f2:	48 89 df             	mov    %rbx,%rdi
    58f5:	e8 86 d6 ff ff       	call   2f80 <fwp_gc_chunk_addr>
    58fa:	4c 39 f8             	cmp    %r15,%rax
    58fd:	0f 85 e4 00 00 00    	jne    59e7 <fwp_mem_free+0x1c7>
    5903:	49 8b 46 18          	mov    0x18(%r14),%rax
    5907:	48 01 05 8a e9 00 00 	add    %rax,0xe98a(%rip)        # 14298 <fwp_gc>
    590e:	41 c6 46 03 00       	movb   $0x0,0x3(%r14)
    5913:	4c 89 f7             	mov    %r14,%rdi
    5916:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    591d:	e8 3e d6 ff ff       	call   2f60 <fwp_rc_clear_slot>
    5922:	41 8b 46 10          	mov    0x10(%r14),%eax
    5926:	48 85 c0             	test   %rax,%rax
    5929:	0f 84 91 00 00 00    	je     59c0 <fwp_mem_free+0x1a0>
    592f:	48 8b 0d da f9 00 00 	mov    0xf9da(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    5936:	48 69 f3 28 12 00 00 	imul   $0x1228,%rbx,%rsi
    593d:	89 c2                	mov    %eax,%edx
    593f:	83 e2 03             	and    $0x3,%edx
    5942:	83 f8 04             	cmp    $0x4,%eax
    5945:	73 04                	jae    594b <fwp_mem_free+0x12b>
    5947:	31 ff                	xor    %edi,%edi
    5949:	eb 41                	jmp    598c <fwp_mem_free+0x16c>
    594b:	4c 8d 04 31          	lea    (%rcx,%rsi,1),%r8
    594f:	41 89 c1             	mov    %eax,%r9d
    5952:	41 83 e1 fc          	and    $0xfffffffc,%r9d
    5956:	31 ff                	xor    %edi,%edi
    5958:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    595f:	00 
    5960:	41 c6 00 00          	movb   $0x0,(%r8)
    5964:	41 c6 80 28 12 00 00 	movb   $0x0,0x1228(%r8)
    596b:	00 
    596c:	41 c6 80 50 24 00 00 	movb   $0x0,0x2450(%r8)
    5973:	00 
    5974:	41 c6 80 78 36 00 00 	movb   $0x0,0x3678(%r8)
    597b:	00 
    597c:	48 83 c7 04          	add    $0x4,%rdi
    5980:	49 81 c0 a0 48 00 00 	add    $0x48a0,%r8
    5987:	49 39 f9             	cmp    %rdi,%r9
    598a:	75 d4                	jne    5960 <fwp_mem_free+0x140>
    598c:	48 85 d2             	test   %rdx,%rdx
    598f:	74 2f                	je     59c0 <fwp_mem_free+0x1a0>
    5991:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    5998:	48 01 f7             	add    %rsi,%rdi
    599b:	48 01 f9             	add    %rdi,%rcx
    599e:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    59a5:	31 f6                	xor    %esi,%esi
    59a7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    59ae:	00 00 
    59b0:	c6 04 31 00          	movb   $0x0,(%rcx,%rsi,1)
    59b4:	48 81 c6 28 12 00 00 	add    $0x1228,%rsi
    59bb:	48 39 f2             	cmp    %rsi,%rdx
    59be:	75 f0                	jne    59b0 <fwp_mem_free+0x190>
    59c0:	48 01 05 b1 fa 00 00 	add    %rax,0xfab1(%rip)        # 15478 <fwp_gc+0x11e0>
    59c7:	48 3b 1d 3a f9 00 00 	cmp    0xf93a(%rip),%rbx        # 15308 <fwp_gc+0x1070>
    59ce:	73 07                	jae    59d7 <fwp_mem_free+0x1b7>
    59d0:	48 89 1d 31 f9 00 00 	mov    %rbx,0xf931(%rip)        # 15308 <fwp_gc+0x1070>
    59d7:	48 3b 1d 22 f9 00 00 	cmp    0xf922(%rip),%rbx        # 15300 <fwp_gc+0x1068>
    59de:	73 07                	jae    59e7 <fwp_mem_free+0x1c7>
    59e0:	48 89 1d 19 f9 00 00 	mov    %rbx,0xf919(%rip)        # 15300 <fwp_gc+0x1068>
    59e7:	48 83 c4 10          	add    $0x10,%rsp
    59eb:	5b                   	pop    %rbx
    59ec:	41 5e                	pop    %r14
    59ee:	41 5f                	pop    %r15
    59f0:	c3                   	ret
    59f1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    59f8:	0f 1f 84 00 00 00 00 
    59ff:	00 

0000000000005a00 <fwp_drop1>:
    5a00:	53                   	push   %rbx
    5a01:	48 89 fb             	mov    %rdi,%rbx
    5a04:	e8 97 d0 ff ff       	call   2aa0 <fwp_rc_release_last>
    5a09:	85 c0                	test   %eax,%eax
    5a0b:	74 09                	je     5a16 <fwp_drop1+0x16>
    5a0d:	48 89 df             	mov    %rbx,%rdi
    5a10:	5b                   	pop    %rbx
    5a11:	e9 4a fd ff ff       	jmp    5760 <fwp_rc_free_arr>
    5a16:	5b                   	pop    %rbx
    5a17:	c3                   	ret
    5a18:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    5a1f:	00 

0000000000005a20 <fwp_drop2>:
    5a20:	53                   	push   %rbx
    5a21:	48 89 fb             	mov    %rdi,%rbx
    5a24:	e8 77 d0 ff ff       	call   2aa0 <fwp_rc_release_last>
    5a29:	85 c0                	test   %eax,%eax
    5a2b:	74 09                	je     5a36 <fwp_drop2+0x16>
    5a2d:	48 89 df             	mov    %rbx,%rdi
    5a30:	5b                   	pop    %rbx
    5a31:	e9 2a fd ff ff       	jmp    5760 <fwp_rc_free_arr>
    5a36:	5b                   	pop    %rbx
    5a37:	c3                   	ret
    5a38:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    5a3f:	00 

0000000000005a40 <fwp_drop3>:
    5a40:	53                   	push   %rbx
    5a41:	48 89 fb             	mov    %rdi,%rbx
    5a44:	e8 57 d0 ff ff       	call   2aa0 <fwp_rc_release_last>
    5a49:	85 c0                	test   %eax,%eax
    5a4b:	74 09                	je     5a56 <fwp_drop3+0x16>
    5a4d:	48 89 df             	mov    %rbx,%rdi
    5a50:	5b                   	pop    %rbx
    5a51:	e9 0a fd ff ff       	jmp    5760 <fwp_rc_free_arr>
    5a56:	5b                   	pop    %rbx
    5a57:	c3                   	ret
    5a58:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    5a5f:	00 

0000000000005a60 <fwp_drop4>:
    5a60:	53                   	push   %rbx
    5a61:	48 89 fb             	mov    %rdi,%rbx
    5a64:	e8 37 d0 ff ff       	call   2aa0 <fwp_rc_release_last>
    5a69:	85 c0                	test   %eax,%eax
    5a6b:	74 09                	je     5a76 <fwp_drop4+0x16>
    5a6d:	48 89 df             	mov    %rbx,%rdi
    5a70:	5b                   	pop    %rbx
    5a71:	e9 ea fc ff ff       	jmp    5760 <fwp_rc_free_arr>
    5a76:	5b                   	pop    %rbx
    5a77:	c3                   	ret
    5a78:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    5a7f:	00 

0000000000005a80 <fwp_drop5>:
    5a80:	53                   	push   %rbx
    5a81:	48 89 fb             	mov    %rdi,%rbx
    5a84:	e8 17 d0 ff ff       	call   2aa0 <fwp_rc_release_last>
    5a89:	85 c0                	test   %eax,%eax
    5a8b:	74 09                	je     5a96 <fwp_drop5+0x16>
    5a8d:	48 89 df             	mov    %rbx,%rdi
    5a90:	5b                   	pop    %rbx
    5a91:	e9 ca fc ff ff       	jmp    5760 <fwp_rc_free_arr>
    5a96:	5b                   	pop    %rbx
    5a97:	c3                   	ret
    5a98:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    5a9f:	00 

0000000000005aa0 <fwp_drop6>:
    5aa0:	53                   	push   %rbx
    5aa1:	48 89 fb             	mov    %rdi,%rbx
    5aa4:	e8 f7 cf ff ff       	call   2aa0 <fwp_rc_release_last>
    5aa9:	85 c0                	test   %eax,%eax
    5aab:	74 09                	je     5ab6 <fwp_drop6+0x16>
    5aad:	48 89 df             	mov    %rbx,%rdi
    5ab0:	5b                   	pop    %rbx
    5ab1:	e9 aa fc ff ff       	jmp    5760 <fwp_rc_free_arr>
    5ab6:	5b                   	pop    %rbx
    5ab7:	c3                   	ret
    5ab8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    5abf:	00 

0000000000005ac0 <fwp_drop7>:
    5ac0:	53                   	push   %rbx
    5ac1:	48 89 fb             	mov    %rdi,%rbx
    5ac4:	e8 d7 cf ff ff       	call   2aa0 <fwp_rc_release_last>
    5ac9:	85 c0                	test   %eax,%eax
    5acb:	74 09                	je     5ad6 <fwp_drop7+0x16>
    5acd:	48 89 df             	mov    %rbx,%rdi
    5ad0:	5b                   	pop    %rbx
    5ad1:	e9 8a fc ff ff       	jmp    5760 <fwp_rc_free_arr>
    5ad6:	5b                   	pop    %rbx
    5ad7:	c3                   	ret
    5ad8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    5adf:	00 

0000000000005ae0 <f3>:
    5ae0:	53                   	push   %rbx
    5ae1:	48 83 ec 30          	sub    $0x30,%rsp
    5ae5:	e8 d6 d5 ff ff       	call   30c0 <fwp_f64>
    5aea:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    5aef:	e8 5c 00 00 00       	call   5b50 <w3>
    5af4:	f2 0f 10 44 24 18    	movsd  0x18(%rsp),%xmm0
    5afa:	e8 21 d6 ff ff       	call   3120 <fwp_from_f64>
    5aff:	48 89 04 24          	mov    %rax,(%rsp)
    5b03:	f2 0f 10 44 24 20    	movsd  0x20(%rsp),%xmm0
    5b09:	e8 12 d6 ff ff       	call   3120 <fwp_from_f64>
    5b0e:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    5b13:	f2 0f 10 44 24 28    	movsd  0x28(%rsp),%xmm0
    5b19:	e8 02 d6 ff ff       	call   3120 <fwp_from_f64>
    5b1e:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    5b23:	48 89 e6             	mov    %rsp,%rsi
    5b26:	bf 03 00 00 00       	mov    $0x3,%edi
    5b2b:	e8 e0 d5 ff ff       	call   3110 <fwp_record>
    5b30:	48 89 c3             	mov    %rax,%rbx
    5b33:	48 89 c7             	mov    %rax,%rdi
    5b36:	e8 95 d5 ff ff       	call   30d0 <fwp_rc_fresh>
    5b3b:	48 89 d8             	mov    %rbx,%rax
    5b3e:	48 83 c4 30          	add    $0x30,%rsp
    5b42:	5b                   	pop    %rbx
    5b43:	c3                   	ret
    5b44:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    5b4b:	00 00 00 00 00 

0000000000005b50 <w3>:
    5b50:	41 57                	push   %r15
    5b52:	41 56                	push   %r14
    5b54:	41 54                	push   %r12
    5b56:	53                   	push   %rbx
    5b57:	50                   	push   %rax
    5b58:	48 89 fb             	mov    %rdi,%rbx
    5b5b:	e8 c0 d5 ff ff       	call   3120 <fwp_from_f64>
    5b60:	49 89 c6             	mov    %rax,%r14
    5b63:	48 bf 00 00 00 00 00 	movabs $0x3fd0000000000000,%rdi
    5b6a:	00 d0 3f 
    5b6d:	48 89 c6             	mov    %rax,%rsi
    5b70:	e8 4b 00 00 00       	call   5bc0 <f6>
    5b75:	49 89 c7             	mov    %rax,%r15
    5b78:	4c 89 f7             	mov    %r14,%rdi
    5b7b:	e8 70 00 00 00       	call   5bf0 <f10>
    5b80:	49 89 c4             	mov    %rax,%r12
    5b83:	4c 89 f7             	mov    %r14,%rdi
    5b86:	e8 35 d5 ff ff       	call   30c0 <fwp_f64>
    5b8b:	f2 0f 11 03          	movsd  %xmm0,(%rbx)
    5b8f:	4c 89 ff             	mov    %r15,%rdi
    5b92:	e8 29 d5 ff ff       	call   30c0 <fwp_f64>
    5b97:	f2 0f 11 43 08       	movsd  %xmm0,0x8(%rbx)
    5b9c:	4c 89 e7             	mov    %r12,%rdi
    5b9f:	e8 1c d5 ff ff       	call   30c0 <fwp_f64>
    5ba4:	f2 0f 11 43 10       	movsd  %xmm0,0x10(%rbx)
    5ba9:	48 89 d8             	mov    %rbx,%rax
    5bac:	48 83 c4 08          	add    $0x8,%rsp
    5bb0:	5b                   	pop    %rbx
    5bb1:	41 5c                	pop    %r12
    5bb3:	41 5e                	pop    %r14
    5bb5:	41 5f                	pop    %r15
    5bb7:	c3                   	ret
    5bb8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    5bbf:	00 

0000000000005bc0 <f6>:
    5bc0:	53                   	push   %rbx
    5bc1:	48 83 ec 10          	sub    $0x10,%rsp
    5bc5:	48 89 fb             	mov    %rdi,%rbx
    5bc8:	48 89 f7             	mov    %rsi,%rdi
    5bcb:	e8 f0 d4 ff ff       	call   30c0 <fwp_f64>
    5bd0:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    5bd6:	48 89 df             	mov    %rbx,%rdi
    5bd9:	e8 e2 d4 ff ff       	call   30c0 <fwp_f64>
    5bde:	f2 0f 58 44 24 08    	addsd  0x8(%rsp),%xmm0
    5be4:	48 83 c4 10          	add    $0x10,%rsp
    5be8:	5b                   	pop    %rbx
    5be9:	e9 32 d5 ff ff       	jmp    3120 <fwp_from_f64>
    5bee:	66 90                	xchg   %ax,%ax

0000000000005bf0 <f10>:
    5bf0:	50                   	push   %rax
    5bf1:	e8 ca d4 ff ff       	call   30c0 <fwp_f64>
    5bf6:	0f 57 05 e3 84 00 00 	xorps  0x84e3(%rip),%xmm0        # e0e0 <_IO_stdin_used+0xe0>
    5bfd:	58                   	pop    %rax
    5bfe:	e9 1d d5 ff ff       	jmp    3120 <fwp_from_f64>
    5c03:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5c0a:	84 00 00 00 00 00 

0000000000005c10 <f4>:
    5c10:	50                   	push   %rax
    5c11:	e8 aa d4 ff ff       	call   30c0 <fwp_f64>
    5c16:	e8 15 00 00 00       	call   5c30 <w4>
    5c1b:	58                   	pop    %rax
    5c1c:	e9 ff d4 ff ff       	jmp    3120 <fwp_from_f64>
    5c21:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5c28:	0f 1f 84 00 00 00 00 
    5c2f:	00 

0000000000005c30 <w4>:
    5c30:	50                   	push   %rax
    5c31:	e8 ea d4 ff ff       	call   3120 <fwp_from_f64>
    5c36:	48 bf 00 00 00 00 00 	movabs $0x3fc0000000000000,%rdi
    5c3d:	00 c0 3f 
    5c40:	48 89 c6             	mov    %rax,%rsi
    5c43:	e8 78 ff ff ff       	call   5bc0 <f6>
    5c48:	48 89 c7             	mov    %rax,%rdi
    5c4b:	58                   	pop    %rax
    5c4c:	e9 6f d4 ff ff       	jmp    30c0 <fwp_f64>
    5c51:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5c58:	0f 1f 84 00 00 00 00 
    5c5f:	00 

0000000000005c60 <fwp_stack_guard_init>:
    5c60:	53                   	push   %rbx
    5c61:	48 81 ec c0 00 00 00 	sub    $0xc0,%rsp
    5c68:	48 8d 44 24 0f       	lea    0xf(%rsp),%rax
    5c6d:	48 89 05 94 01 01 00 	mov    %rax,0x10194(%rip)        # 15e08 <fwp_main_stack_top>
    5c74:	48 89 3d 95 01 01 00 	mov    %rdi,0x10195(%rip)        # 15e10 <fwp_main_stack_size>
    5c7b:	48 8d 05 9e 01 01 00 	lea    0x1019e(%rip),%rax        # 15e20 <fwp_stack_guard_init.alt>
    5c82:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    5c87:	48 c7 44 24 20 00 00 	movq   $0x10000,0x20(%rsp)
    5c8e:	01 00 
    5c90:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%rsp)
    5c97:	00 
    5c98:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    5c9d:	31 f6                	xor    %esi,%esi
    5c9f:	e8 2c c8 ff ff       	call   24d0 <sigaltstack@plt>
    5ca4:	85 c0                	test   %eax,%eax
    5ca6:	0f 85 80 00 00 00    	jne    5d2c <fwp_stack_guard_init+0xcc>
    5cac:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    5cb1:	0f 57 c0             	xorps  %xmm0,%xmm0
    5cb4:	0f 11 84 24 b0 00 00 	movups %xmm0,0xb0(%rsp)
    5cbb:	00 
    5cbc:	0f 11 84 24 a0 00 00 	movups %xmm0,0xa0(%rsp)
    5cc3:	00 
    5cc4:	0f 11 84 24 90 00 00 	movups %xmm0,0x90(%rsp)
    5ccb:	00 
    5ccc:	0f 11 84 24 80 00 00 	movups %xmm0,0x80(%rsp)
    5cd3:	00 
    5cd4:	0f 11 44 24 70       	movups %xmm0,0x70(%rsp)
    5cd9:	0f 11 44 24 60       	movups %xmm0,0x60(%rsp)
    5cde:	0f 11 44 24 50       	movups %xmm0,0x50(%rsp)
    5ce3:	0f 11 44 24 40       	movups %xmm0,0x40(%rsp)
    5ce8:	0f 11 44 24 30       	movups %xmm0,0x30(%rsp)
    5ced:	48 8d 05 7c 07 00 00 	lea    0x77c(%rip),%rax        # 6470 <fwp_segv>
    5cf4:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    5cf9:	c7 84 24 b0 00 00 00 	movl   $0x8000004,0xb0(%rsp)
    5d00:	04 00 00 08 
    5d04:	e8 07 c6 ff ff       	call   2310 <sigemptyset@plt>
    5d09:	48 8d 5c 24 28       	lea    0x28(%rsp),%rbx
    5d0e:	bf 0b 00 00 00       	mov    $0xb,%edi
    5d13:	48 89 de             	mov    %rbx,%rsi
    5d16:	31 d2                	xor    %edx,%edx
    5d18:	e8 c3 c3 ff ff       	call   20e0 <sigaction@plt>
    5d1d:	bf 07 00 00 00       	mov    $0x7,%edi
    5d22:	48 89 de             	mov    %rbx,%rsi
    5d25:	31 d2                	xor    %edx,%edx
    5d27:	e8 b4 c3 ff ff       	call   20e0 <sigaction@plt>
    5d2c:	48 81 c4 c0 00 00 00 	add    $0xc0,%rsp
    5d33:	5b                   	pop    %rbx
    5d34:	c3                   	ret
    5d35:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    5d3c:	00 00 00 00 

0000000000005d40 <fwp_exec>:
    5d40:	55                   	push   %rbp
    5d41:	41 57                	push   %r15
    5d43:	41 56                	push   %r14
    5d45:	41 55                	push   %r13
    5d47:	41 54                	push   %r12
    5d49:	53                   	push   %rbx
    5d4a:	48 81 ec 58 01 00 00 	sub    $0x158,%rsp
    5d51:	49 89 f7             	mov    %rsi,%r15
    5d54:	41 89 fd             	mov    %edi,%r13d
    5d57:	41 8d 5d ff          	lea    -0x1(%r13),%ebx
    5d5b:	80 3d 9e 00 01 00 01 	cmpb   $0x1,0x1009e(%rip)        # 15e00 <fwp_cli_single>
    5d62:	75 16                	jne    5d7a <fwp_exec+0x3a>
    5d64:	49 8d 77 08          	lea    0x8(%r15),%rsi
    5d68:	89 df                	mov    %ebx,%edi
    5d6a:	e8 91 07 00 00       	call   6500 <fwp_generated>
    5d6f:	41 89 c6             	mov    %eax,%r14d
    5d72:	85 c0                	test   %eax,%eax
    5d74:	0f 89 1a 01 00 00    	jns    5e94 <fwp_exec+0x154>
    5d7a:	89 5c 24 18          	mov    %ebx,0x18(%rsp)
    5d7e:	49 63 fd             	movslq %r13d,%rdi
    5d81:	48 c1 e7 03          	shl    $0x3,%rdi
    5d85:	48 89 7c 24 48       	mov    %rdi,0x48(%rsp)
    5d8a:	e8 a1 f9 ff ff       	call   5730 <fwp_alloc>
    5d8f:	49 89 c4             	mov    %rax,%r12
    5d92:	41 83 fd 02          	cmp    $0x2,%r13d
    5d96:	7c 30                	jl     5dc8 <fwp_exec+0x88>
    5d98:	8b 6c 24 18          	mov    0x18(%rsp),%ebp
    5d9c:	31 db                	xor    %ebx,%ebx
    5d9e:	66 90                	xchg   %ax,%ax
    5da0:	4c 8d 73 01          	lea    0x1(%rbx),%r14
    5da4:	4d 8b 6c df 08       	mov    0x8(%r15,%rbx,8),%r13
    5da9:	4c 89 ef             	mov    %r13,%rdi
    5dac:	e8 bf c3 ff ff       	call   2170 <strlen@plt>
    5db1:	4c 89 ef             	mov    %r13,%rdi
    5db4:	48 89 c6             	mov    %rax,%rsi
    5db7:	e8 a4 08 00 00       	call   6660 <fwp_str_lossy>
    5dbc:	49 89 04 dc          	mov    %rax,(%r12,%rbx,8)
    5dc0:	4c 89 f3             	mov    %r14,%rbx
    5dc3:	4c 39 f5             	cmp    %r14,%rbp
    5dc6:	75 d8                	jne    5da0 <fwp_exec+0x60>
    5dc8:	bf 08 00 00 00       	mov    $0x8,%edi
    5dcd:	e8 5e f9 ff ff       	call   5730 <fwp_alloc>
    5dd2:	bf 01 00 00 00       	mov    $0x1,%edi
    5dd7:	e8 64 0a 00 00       	call   6840 <fwp_alloc_leaf>
    5ddc:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
    5de1:	e8 4a f9 ff ff       	call   5730 <fwp_alloc>
    5de6:	49 89 c6             	mov    %rax,%r14
    5de9:	48 8d 4c 24 2c       	lea    0x2c(%rsp),%rcx
    5dee:	8b 7c 24 18          	mov    0x18(%rsp),%edi
    5df2:	4c 89 e6             	mov    %r12,%rsi
    5df5:	48 89 c2             	mov    %rax,%rdx
    5df8:	e8 53 0a 00 00       	call   6850 <fwp_cli_parse>
    5dfd:	83 f8 02             	cmp    $0x2,%eax
    5e00:	74 32                	je     5e34 <fwp_exec+0xf4>
    5e02:	83 f8 01             	cmp    $0x1,%eax
    5e05:	75 5d                	jne    5e64 <fwp_exec+0x124>
    5e07:	48 8b 1d aa e1 00 00 	mov    0xe1aa(%rip),%rbx        # 13fb8 <stdout@GLIBC_2.2.5>
    5e0e:	48 8b 0b             	mov    (%rbx),%rcx
    5e11:	48 8d 3d 14 96 00 00 	lea    0x9614(%rip),%rdi        # f42c <exec_in_fp0+0xddc>
    5e18:	be 72 00 00 00       	mov    $0x72,%esi
    5e1d:	ba 01 00 00 00       	mov    $0x1,%edx
    5e22:	e8 79 c6 ff ff       	call   24a0 <fwrite@plt>
    5e27:	48 8b 3b             	mov    (%rbx),%rdi
    5e2a:	e8 21 c5 ff ff       	call   2350 <fflush@plt>
    5e2f:	45 31 f6             	xor    %r14d,%r14d
    5e32:	eb 60                	jmp    5e94 <fwp_exec+0x154>
    5e34:	48 8d 3d 5f 92 00 00 	lea    0x925f(%rip),%rdi        # f09a <exec_in_fp0+0xa4a>
    5e3b:	48 8d 15 3e 88 00 00 	lea    0x883e(%rip),%rdx        # e680 <exec_in_fp0+0x30>
    5e42:	45 31 f6             	xor    %r14d,%r14d
    5e45:	be 06 00 00 00       	mov    $0x6,%esi
    5e4a:	31 c9                	xor    %ecx,%ecx
    5e4c:	31 c0                	xor    %eax,%eax
    5e4e:	e8 6d c3 ff ff       	call   21c0 <printf@plt>
    5e53:	48 8b 05 5e e1 00 00 	mov    0xe15e(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    5e5a:	48 8b 38             	mov    (%rax),%rdi
    5e5d:	e8 ee c4 ff ff       	call   2350 <fflush@plt>
    5e62:	eb 30                	jmp    5e94 <fwp_exec+0x154>
    5e64:	bf 10 00 00 00       	mov    $0x10,%edi
    5e69:	e8 c2 f8 ff ff       	call   5730 <fwp_alloc>
    5e6e:	49 89 c7             	mov    %rax,%r15
    5e71:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%rsp)
    5e78:	00 
    5e79:	8b 74 24 2c          	mov    0x2c(%rsp),%esi
    5e7d:	48 8d 4c 24 14       	lea    0x14(%rsp),%rcx
    5e82:	4c 89 f7             	mov    %r14,%rdi
    5e85:	48 89 c2             	mov    %rax,%rdx
    5e88:	e8 23 0c 00 00       	call   6ab0 <fwp_bind_positional>
    5e8d:	41 89 c6             	mov    %eax,%r14d
    5e90:	85 c0                	test   %eax,%eax
    5e92:	74 15                	je     5ea9 <fwp_exec+0x169>
    5e94:	44 89 f0             	mov    %r14d,%eax
    5e97:	48 81 c4 58 01 00 00 	add    $0x158,%rsp
    5e9e:	5b                   	pop    %rbx
    5e9f:	41 5c                	pop    %r12
    5ea1:	41 5d                	pop    %r13
    5ea3:	41 5e                	pop    %r14
    5ea5:	41 5f                	pop    %r15
    5ea7:	5d                   	pop    %rbp
    5ea8:	c3                   	ret
    5ea9:	48 8d 3d f3 91 00 00 	lea    0x91f3(%rip),%rdi        # f0a3 <exec_in_fp0+0xa53>
    5eb0:	e8 7b c1 ff ff       	call   2030 <getenv@plt>
    5eb5:	48 85 c0             	test   %rax,%rax
    5eb8:	74 27                	je     5ee1 <fwp_exec+0x1a1>
    5eba:	48 8d 35 ea 91 00 00 	lea    0x91ea(%rip),%rsi        # f0ab <exec_in_fp0+0xa5b>
    5ec1:	48 89 c7             	mov    %rax,%rdi
    5ec4:	e8 07 c4 ff ff       	call   22d0 <strcmp@plt>
    5ec9:	31 c9                	xor    %ecx,%ecx
    5ecb:	85 c0                	test   %eax,%eax
    5ecd:	0f 94 c1             	sete   %cl
    5ed0:	89 0d 4a ff 01 00    	mov    %ecx,0x1ff4a(%rip)        # 25e20 <fwp_exec_binary_out>
    5ed6:	75 26                	jne    5efe <fwp_exec+0x1be>
    5ed8:	48 8b 05 01 e1 00 00 	mov    0xe101(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    5edf:	eb 24                	jmp    5f05 <fwp_exec+0x1c5>
    5ee1:	c7 05 35 ff 01 00 00 	movl   $0x0,0x1ff35(%rip)        # 25e20 <fwp_exec_binary_out>
    5ee8:	00 00 00 
    5eeb:	48 8b 05 c6 e0 00 00 	mov    0xe0c6(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    5ef2:	48 8b 00             	mov    (%rax),%rax
    5ef5:	48 89 05 ac fe 00 00 	mov    %rax,0xfeac(%rip)        # 15da8 <fwp_prog_out>
    5efc:	eb 33                	jmp    5f31 <fwp_exec+0x1f1>
    5efe:	48 8b 05 b3 e0 00 00 	mov    0xe0b3(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    5f05:	48 8b 00             	mov    (%rax),%rax
    5f08:	48 89 05 99 fe 00 00 	mov    %rax,0xfe99(%rip)        # 15da8 <fwp_prog_out>
    5f0f:	75 20                	jne    5f31 <fwp_exec+0x1f1>
    5f11:	e8 da 0b 00 00       	call   6af0 <fwp_pipe_out_start>
    5f16:	48 8d 3d f3 86 00 00 	lea    0x86f3(%rip),%rdi        # e610 <exec_out_header0>
    5f1d:	be 3c 00 00 00       	mov    $0x3c,%esi
    5f22:	e8 99 0c 00 00       	call   6bc0 <fwp_pipe_write>
    5f27:	e8 44 0d 00 00       	call   6c70 <fwp_pipe_flush>
    5f2c:	e8 6f 0d 00 00       	call   6ca0 <fwp_pipe_out_ready>
    5f31:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%rsp)
    5f38:	00 
    5f39:	83 7c 24 14 00       	cmpl   $0x0,0x14(%rsp)
    5f3e:	0f 84 57 01 00 00    	je     609b <fwp_exec+0x35b>
    5f44:	48 8b 1d 75 e0 00 00 	mov    0xe075(%rip),%rbx        # 13fc0 <stdin@GLIBC_2.2.5>
    5f4b:	48 8b 3b             	mov    (%rbx),%rdi
    5f4e:	b9 00 00 10 00       	mov    $0x100000,%ecx
    5f53:	31 f6                	xor    %esi,%esi
    5f55:	31 d2                	xor    %edx,%edx
    5f57:	e8 54 c4 ff ff       	call   23b0 <setvbuf@plt>
    5f5c:	48 8b 0b             	mov    (%rbx),%rcx
    5f5f:	48 8d 3d be fe 01 00 	lea    0x1febe(%rip),%rdi        # 25e24 <fwp_in_pend>
    5f66:	be 01 00 00 00       	mov    $0x1,%esi
    5f6b:	ba 04 00 00 00       	mov    $0x4,%edx
    5f70:	e8 7b c1 ff ff       	call   20f0 <fread@plt>
    5f75:	89 05 ad fe 01 00    	mov    %eax,0x1fead(%rip)        # 25e28 <fwp_in_npend>
    5f7b:	c7 05 a7 fe 01 00 00 	movl   $0x0,0x1fea7(%rip)        # 25e2c <fwp_in_ppos>
    5f82:	00 00 00 
    5f85:	41 b4 01             	mov    $0x1,%r12b
    5f88:	83 f8 04             	cmp    $0x4,%eax
    5f8b:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    5f90:	0f 85 d3 01 00 00    	jne    6169 <fwp_exec+0x429>
    5f96:	81 3d 84 fe 01 00 46 	cmpl   $0x31505746,0x1fe84(%rip)        # 25e24 <fwp_in_pend>
    5f9d:	57 50 31 
    5fa0:	0f 85 c3 01 00 00    	jne    6169 <fwp_exec+0x429>
    5fa6:	c7 05 7c fe 01 00 04 	movl   $0x4,0x1fe7c(%rip)        # 25e2c <fwp_in_ppos>
    5fad:	00 00 00 
    5fb0:	48 8d 7c 24 03       	lea    0x3(%rsp),%rdi
    5fb5:	be 01 00 00 00       	mov    $0x1,%esi
    5fba:	e8 41 0e 00 00       	call   6e00 <fwp_read_exact>
    5fbf:	85 c0                	test   %eax,%eax
    5fc1:	0f 84 c3 03 00 00    	je     638a <fwp_exec+0x64a>
    5fc7:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
    5fcc:	e8 2f 0f 00 00       	call   6f00 <fwp_stdin_leb>
    5fd1:	83 f8 01             	cmp    $0x1,%eax
    5fd4:	0f 85 99 03 00 00    	jne    6373 <fwp_exec+0x633>
    5fda:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    5fdf:	48 83 f8 40          	cmp    $0x40,%rax
    5fe3:	41 bd 40 00 00 00    	mov    $0x40,%r13d
    5fe9:	4c 0f 42 e8          	cmovb  %rax,%r13
    5fed:	48 85 c0             	test   %rax,%rax
    5ff0:	0f 84 e2 00 00 00    	je     60d8 <fwp_exec+0x398>
    5ff6:	45 31 f6             	xor    %r14d,%r14d
    5ff9:	4c 8d 7c 24 50       	lea    0x50(%rsp),%r15
    5ffe:	31 ed                	xor    %ebp,%ebp
    6000:	eb 4a                	jmp    604c <fwp_exec+0x30c>
    6002:	be 06 00 00 00       	mov    $0x6,%esi
    6007:	4c 89 ff             	mov    %r15,%rdi
    600a:	e8 f1 0d 00 00       	call   6e00 <fwp_read_exact>
    600f:	85 c0                	test   %eax,%eax
    6011:	0f 84 73 03 00 00    	je     638a <fwp_exec+0x64a>
    6017:	8b 44 24 50          	mov    0x50(%rsp),%eax
    601b:	b9 55 44 53 5f       	mov    $0x5f534455,%ecx
    6020:	31 c8                	xor    %ecx,%eax
    6022:	0f b7 4c 24 54       	movzwl 0x54(%rsp),%ecx
    6027:	81 f1 56 31 00 00    	xor    $0x3156,%ecx
    602d:	09 c1                	or     %eax,%ecx
    602f:	b8 01 00 00 00       	mov    $0x1,%eax
    6034:	0f 44 e8             	cmove  %eax,%ebp
    6037:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
    603e:	00 00 
    6040:	49 ff c6             	inc    %r14
    6043:	4d 39 ee             	cmp    %r13,%r14
    6046:	0f 84 8e 00 00 00    	je     60da <fwp_exec+0x39a>
    604c:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    6051:	e8 2a 0f 00 00       	call   6f80 <fwp_stdin_name_len>
    6056:	83 f8 01             	cmp    $0x1,%eax
    6059:	0f 85 14 03 00 00    	jne    6373 <fwp_exec+0x633>
    605f:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    6064:	48 85 db             	test   %rbx,%rbx
    6067:	74 ce                	je     6037 <fwp_exec+0x2f7>
    6069:	48 83 fb 06          	cmp    $0x6,%rbx
    606d:	74 93                	je     6002 <fwp_exec+0x2c2>
    606f:	90                   	nop
    6070:	48 81 fb 00 01 00 00 	cmp    $0x100,%rbx
    6077:	41 bc 00 01 00 00    	mov    $0x100,%r12d
    607d:	4c 0f 42 e3          	cmovb  %rbx,%r12
    6081:	4c 89 ff             	mov    %r15,%rdi
    6084:	4c 89 e6             	mov    %r12,%rsi
    6087:	e8 74 0d 00 00       	call   6e00 <fwp_read_exact>
    608c:	85 c0                	test   %eax,%eax
    608e:	0f 84 f6 02 00 00    	je     638a <fwp_exec+0x64a>
    6094:	4c 29 e3             	sub    %r12,%rbx
    6097:	75 d7                	jne    6070 <fwp_exec+0x330>
    6099:	eb 9c                	jmp    6037 <fwp_exec+0x2f7>
    609b:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
    60a0:	4c 89 ff             	mov    %r15,%rdi
    60a3:	e8 98 0c 00 00       	call   6d40 <fwp_exec_call>
    60a8:	48 89 c3             	mov    %rax,%rbx
    60ab:	48 8b 3d f6 fc 00 00 	mov    0xfcf6(%rip),%rdi        # 15da8 <fwp_prog_out>
    60b2:	e8 99 c2 ff ff       	call   2350 <fflush@plt>
    60b7:	41 be 01 00 00 00    	mov    $0x1,%r14d
    60bd:	83 7c 24 04 00       	cmpl   $0x0,0x4(%rsp)
    60c2:	0f 85 83 02 00 00    	jne    634b <fwp_exec+0x60b>
    60c8:	48 89 df             	mov    %rbx,%rdi
    60cb:	e8 20 0d 00 00       	call   6df0 <fwp_emit_result>
    60d0:	45 31 f6             	xor    %r14d,%r14d
    60d3:	e9 73 02 00 00       	jmp    634b <fwp_exec+0x60b>
    60d8:	31 ed                	xor    %ebp,%ebp
    60da:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    60df:	be 10 00 00 00       	mov    $0x10,%esi
    60e4:	e8 17 0d 00 00       	call   6e00 <fwp_read_exact>
    60e9:	85 c0                	test   %eax,%eax
    60eb:	0f 84 99 02 00 00    	je     638a <fwp_exec+0x64a>
    60f1:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    60f6:	e8 85 0e 00 00       	call   6f80 <fwp_stdin_name_len>
    60fb:	83 f8 01             	cmp    $0x1,%eax
    60fe:	0f 85 6f 02 00 00    	jne    6373 <fwp_exec+0x633>
    6104:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    6109:	49 8d 7f 01          	lea    0x1(%r15),%rdi
    610d:	e8 2e 07 00 00       	call   6840 <fwp_alloc_leaf>
    6112:	49 89 c6             	mov    %rax,%r14
    6115:	4d 85 ff             	test   %r15,%r15
    6118:	74 13                	je     612d <fwp_exec+0x3ed>
    611a:	4c 89 f7             	mov    %r14,%rdi
    611d:	4c 89 fe             	mov    %r15,%rsi
    6120:	e8 db 0c 00 00       	call   6e00 <fwp_read_exact>
    6125:	85 c0                	test   %eax,%eax
    6127:	0f 84 5d 02 00 00    	je     638a <fwp_exec+0x64a>
    612d:	43 c6 04 3e 00       	movb   $0x0,(%r14,%r15,1)
    6132:	0f b6 4c 24 03       	movzbl 0x3(%rsp),%ecx
    6137:	83 f9 01             	cmp    $0x1,%ecx
    613a:	0f 85 ab 02 00 00    	jne    63eb <fwp_exec+0x6ab>
    6140:	66 0f 6f 44 24 30    	movdqa 0x30(%rsp),%xmm0
    6146:	66 0f 74 05 a2 7f 00 	pcmpeqb 0x7fa2(%rip),%xmm0        # e0f0 <_IO_stdin_used+0xf0>
    614d:	00 
    614e:	66 0f d7 c0          	pmovmskb %xmm0,%eax
    6152:	3d ff ff 00 00       	cmp    $0xffff,%eax
    6157:	0f 85 af 02 00 00    	jne    640c <fwp_exec+0x6cc>
    615d:	85 ed                	test   %ebp,%ebp
    615f:	74 05                	je     6166 <fwp_exec+0x426>
    6161:	e8 4a 0e 00 00       	call   6fb0 <fwp_pipe_in_offer>
    6166:	45 31 e4             	xor    %r12d,%r12d
    6169:	66 0f ef c0          	pxor   %xmm0,%xmm0
    616d:	66 0f 7f 44 24 50    	movdqa %xmm0,0x50(%rsp)
    6173:	48 c7 44 24 60 00 00 	movq   $0x0,0x60(%rsp)
    617a:	00 00 
    617c:	45 31 ff             	xor    %r15d,%r15d
    617f:	45 31 f6             	xor    %r14d,%r14d
    6182:	eb 35                	jmp    61b9 <fwp_exec+0x479>
    6184:	48 89 ef             	mov    %rbp,%rdi
    6187:	4c 89 ee             	mov    %r13,%rsi
    618a:	e8 21 0f 00 00       	call   70b0 <fwp_pipe_in_switch>
    618f:	bb 10 00 00 00       	mov    $0x10,%ebx
    6194:	48 8d 35 8c 8f 00 00 	lea    0x8f8c(%rip),%rsi        # f127 <exec_in_fp0+0xad7>
    619b:	85 c0                	test   %eax,%eax
    619d:	0f 84 6b 01 00 00    	je     630e <fwp_exec+0x5ce>
    61a3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    61aa:	84 00 00 00 00 00 
    61b0:	83 fb 0f             	cmp    $0xf,%ebx
    61b3:	0f 84 83 01 00 00    	je     633c <fwp_exec+0x5fc>
    61b9:	45 84 e4             	test   %r12b,%r12b
    61bc:	0f 84 9e 00 00 00    	je     6260 <fwp_exec+0x520>
    61c2:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    61c7:	e8 44 15 00 00       	call   7710 <fwp_read_text_line>
    61cc:	4c 8b 7c 24 50       	mov    0x50(%rsp),%r15
    61d1:	85 c0                	test   %eax,%eax
    61d3:	0f 84 63 01 00 00    	je     633c <fwp_exec+0x5fc>
    61d9:	4d 85 ff             	test   %r15,%r15
    61dc:	4c 89 ff             	mov    %r15,%rdi
    61df:	48 8d 05 ba 8b 00 00 	lea    0x8bba(%rip),%rax        # eda0 <exec_in_fp0+0x750>
    61e6:	48 0f 44 f8          	cmove  %rax,%rdi
    61ea:	48 8b 74 24 58       	mov    0x58(%rsp),%rsi
    61ef:	e8 6c 04 00 00       	call   6660 <fwp_str_lossy>
    61f4:	48 89 c5             	mov    %rax,%rbp
    61f7:	4c 8d 68 08          	lea    0x8(%rax),%r13
    61fb:	48 8b 30             	mov    (%rax),%rsi
    61fe:	4c 89 ef             	mov    %r13,%rdi
    6201:	48 8d 54 24 20       	lea    0x20(%rsp),%rdx
    6206:	e8 e5 07 00 00       	call   69f0 <fwp_parse_text>
    620b:	85 c0                	test   %eax,%eax
    620d:	0f 84 a1 01 00 00    	je     63b4 <fwp_exec+0x674>
    6213:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    6218:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    621d:	48 89 07             	mov    %rax,(%rdi)
    6220:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
    6225:	e8 16 0b 00 00       	call   6d40 <fwp_exec_call>
    622a:	49 89 c5             	mov    %rax,%r13
    622d:	48 8b 3d 74 fb 00 00 	mov    0xfb74(%rip),%rdi        # 15da8 <fwp_prog_out>
    6234:	e8 17 c1 ff ff       	call   2350 <fflush@plt>
    6239:	83 7c 24 04 00       	cmpl   $0x0,0x4(%rsp)
    623e:	0f 85 f2 00 00 00    	jne    6336 <fwp_exec+0x5f6>
    6244:	4c 89 ef             	mov    %r13,%rdi
    6247:	e8 a4 0b 00 00       	call   6df0 <fwp_emit_result>
    624c:	e8 1f 0a 00 00       	call   6c70 <fwp_pipe_flush>
    6251:	31 db                	xor    %ebx,%ebx
    6253:	e9 58 ff ff ff       	jmp    61b0 <fwp_exec+0x470>
    6258:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    625f:	00 
    6260:	be 01 00 00 00       	mov    $0x1,%esi
    6265:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    626a:	e8 91 0b 00 00       	call   6e00 <fwp_read_exact>
    626f:	bb 0f 00 00 00       	mov    $0xf,%ebx
    6274:	85 c0                	test   %eax,%eax
    6276:	0f 84 34 ff ff ff    	je     61b0 <fwp_exec+0x470>
    627c:	be 04 00 00 00       	mov    $0x4,%esi
    6281:	48 8d 7c 24 09       	lea    0x9(%rsp),%rdi
    6286:	e8 75 0b 00 00       	call   6e00 <fwp_read_exact>
    628b:	48 8d 35 80 8e 00 00 	lea    0x8e80(%rip),%rsi        # f112 <exec_in_fp0+0xac2>
    6292:	85 c0                	test   %eax,%eax
    6294:	74 78                	je     630e <fwp_exec+0x5ce>
    6296:	44 8b 6c 24 09       	mov    0x9(%rsp),%r13d
    629b:	49 8d 7d 01          	lea    0x1(%r13),%rdi
    629f:	e8 9c 05 00 00       	call   6840 <fwp_alloc_leaf>
    62a4:	48 89 c5             	mov    %rax,%rbp
    62a7:	4d 85 ed             	test   %r13,%r13
    62aa:	74 16                	je     62c2 <fwp_exec+0x582>
    62ac:	48 89 ef             	mov    %rbp,%rdi
    62af:	4c 89 ee             	mov    %r13,%rsi
    62b2:	e8 49 0b 00 00       	call   6e00 <fwp_read_exact>
    62b7:	48 8d 35 54 8e 00 00 	lea    0x8e54(%rip),%rsi        # f112 <exec_in_fp0+0xac2>
    62be:	85 c0                	test   %eax,%eax
    62c0:	74 4c                	je     630e <fwp_exec+0x5ce>
    62c2:	0f b6 44 24 08       	movzbl 0x8(%rsp),%eax
    62c7:	85 c0                	test   %eax,%eax
    62c9:	0f 84 e1 fe ff ff    	je     61b0 <fwp_exec+0x470>
    62cf:	83 f8 02             	cmp    $0x2,%eax
    62d2:	0f 84 ac fe ff ff    	je     6184 <fwp_exec+0x444>
    62d8:	48 89 6c 24 30       	mov    %rbp,0x30(%rsp)
    62dd:	4c 89 6c 24 38       	mov    %r13,0x38(%rsp)
    62e2:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    62e9:	00 00 
    62eb:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    62f0:	48 8d 35 39 fa 00 00 	lea    0xfa39(%rip),%rsi        # 15d30 <d0>
    62f7:	48 8d 54 24 20       	lea    0x20(%rsp),%rdx
    62fc:	e8 cf 0f 00 00       	call   72d0 <fwp_decode>
    6301:	85 c0                	test   %eax,%eax
    6303:	0f 85 0a ff ff ff    	jne    6213 <fwp_exec+0x4d3>
    6309:	e9 2c 01 00 00       	jmp    643a <fwp_exec+0x6fa>
    630e:	48 8b 05 cb dc 00 00 	mov    0xdccb(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    6315:	48 8b 38             	mov    (%rax),%rdi
    6318:	48 8d 15 61 83 00 00 	lea    0x8361(%rip),%rdx        # e680 <exec_in_fp0+0x30>
    631f:	31 c0                	xor    %eax,%eax
    6321:	e8 ca bf ff ff       	call   22f0 <fprintf@plt>
    6326:	41 be 03 00 00 00    	mov    $0x3,%r14d
    632c:	bb 0f 00 00 00       	mov    $0xf,%ebx
    6331:	e9 7a fe ff ff       	jmp    61b0 <fwp_exec+0x470>
    6336:	41 be 01 00 00 00    	mov    $0x1,%r14d
    633c:	31 ff                	xor    %edi,%edi
    633e:	e8 dd f4 ff ff       	call   5820 <fwp_mem_free>
    6343:	4c 89 ff             	mov    %r15,%rdi
    6346:	e8 05 bd ff ff       	call   2050 <free@plt>
    634b:	83 3d ce fa 01 00 00 	cmpl   $0x0,0x1face(%rip)        # 25e20 <fwp_exec_binary_out>
    6352:	0f 84 fb fa ff ff    	je     5e53 <fwp_exec+0x113>
    6358:	48 8d 3d ac 82 00 00 	lea    0x82ac(%rip),%rdi        # e60b <fwp_exec.end>
    635f:	be 05 00 00 00       	mov    $0x5,%esi
    6364:	e8 57 08 00 00       	call   6bc0 <fwp_pipe_write>
    6369:	e8 b2 14 00 00       	call   7820 <fwp_pipe_out_end>
    636e:	e9 e0 fa ff ff       	jmp    5e53 <fwp_exec+0x113>
    6373:	85 c0                	test   %eax,%eax
    6375:	79 13                	jns    638a <fwp_exec+0x64a>
    6377:	48 8b 05 62 dc 00 00 	mov    0xdc62(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    637e:	48 8b 38             	mov    (%rax),%rdi
    6381:	48 8d 35 ef 8d 00 00 	lea    0x8def(%rip),%rsi        # f177 <exec_in_fp0+0xb27>
    6388:	eb 11                	jmp    639b <fwp_exec+0x65b>
    638a:	48 8b 05 4f dc 00 00 	mov    0xdc4f(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    6391:	48 8b 38             	mov    (%rax),%rdi
    6394:	48 8d 35 ec 8d 00 00 	lea    0x8dec(%rip),%rsi        # f187 <exec_in_fp0+0xb37>
    639b:	48 8d 15 de 82 00 00 	lea    0x82de(%rip),%rdx        # e680 <exec_in_fp0+0x30>
    63a2:	31 c0                	xor    %eax,%eax
    63a4:	e8 47 bf ff ff       	call   22f0 <fprintf@plt>
    63a9:	41 be 03 00 00 00    	mov    $0x3,%r14d
    63af:	e9 e0 fa ff ff       	jmp    5e94 <fwp_exec+0x154>
    63b4:	48 8b 05 25 dc 00 00 	mov    0xdc25(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    63bb:	48 8b 38             	mov    (%rax),%rdi
    63be:	8b 4d 00             	mov    0x0(%rbp),%ecx
    63c1:	48 8d 35 8a 8d 00 00 	lea    0x8d8a(%rip),%rsi        # f152 <exec_in_fp0+0xb02>
    63c8:	48 8d 15 b1 82 00 00 	lea    0x82b1(%rip),%rdx        # e680 <exec_in_fp0+0x30>
    63cf:	4c 8d 0d c9 90 00 00 	lea    0x90c9(%rip),%r9        # f49f <exec_in_fp0+0xe4f>
    63d6:	4d 89 e8             	mov    %r13,%r8
    63d9:	31 c0                	xor    %eax,%eax
    63db:	e8 10 bf ff ff       	call   22f0 <fprintf@plt>
    63e0:	41 be 03 00 00 00    	mov    $0x3,%r14d
    63e6:	e9 51 ff ff ff       	jmp    633c <fwp_exec+0x5fc>
    63eb:	48 8b 05 ee db 00 00 	mov    0xdbee(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    63f2:	48 8b 38             	mov    (%rax),%rdi
    63f5:	48 8d 35 bf 8c 00 00 	lea    0x8cbf(%rip),%rsi        # f0bb <exec_in_fp0+0xa6b>
    63fc:	48 8d 15 7d 82 00 00 	lea    0x827d(%rip),%rdx        # e680 <exec_in_fp0+0x30>
    6403:	31 c0                	xor    %eax,%eax
    6405:	e8 e6 be ff ff       	call   22f0 <fprintf@plt>
    640a:	eb 9d                	jmp    63a9 <fwp_exec+0x669>
    640c:	48 8b 05 cd db 00 00 	mov    0xdbcd(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    6413:	48 8b 38             	mov    (%rax),%rdi
    6416:	48 8d 35 c3 8c 00 00 	lea    0x8cc3(%rip),%rsi        # f0e0 <exec_in_fp0+0xa90>
    641d:	48 8d 15 5c 82 00 00 	lea    0x825c(%rip),%rdx        # e680 <exec_in_fp0+0x30>
    6424:	48 8d 0d 74 90 00 00 	lea    0x9074(%rip),%rcx        # f49f <exec_in_fp0+0xe4f>
    642b:	4d 89 f0             	mov    %r14,%r8
    642e:	31 c0                	xor    %eax,%eax
    6430:	e8 bb be ff ff       	call   22f0 <fprintf@plt>
    6435:	e9 6f ff ff ff       	jmp    63a9 <fwp_exec+0x669>
    643a:	48 8b 05 9f db 00 00 	mov    0xdb9f(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    6441:	48 8b 38             	mov    (%rax),%rdi
    6444:	48 8d 35 f2 8c 00 00 	lea    0x8cf2(%rip),%rsi        # f13d <exec_in_fp0+0xaed>
    644b:	48 8d 15 2e 82 00 00 	lea    0x822e(%rip),%rdx        # e680 <exec_in_fp0+0x30>
    6452:	31 c0                	xor    %eax,%eax
    6454:	e8 97 be ff ff       	call   22f0 <fprintf@plt>
    6459:	41 be 03 00 00 00    	mov    $0x3,%r14d
    645f:	e9 d8 fe ff ff       	jmp    633c <fwp_exec+0x5fc>
    6464:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    646b:	00 00 00 00 00 

0000000000006470 <fwp_segv>:
    6470:	53                   	push   %rbx
    6471:	48 8b 15 90 f9 00 00 	mov    0xf990(%rip),%rdx        # 15e08 <fwp_main_stack_top>
    6478:	48 85 d2             	test   %rdx,%rdx
    647b:	74 29                	je     64a6 <fwp_segv+0x36>
    647d:	48 8b 46 10          	mov    0x10(%rsi),%rax
    6481:	48 2b 15 88 f9 00 00 	sub    0xf988(%rip),%rdx        # 15e10 <fwp_main_stack_size>
    6488:	48 8d b2 00 00 f0 ff 	lea    -0x100000(%rdx),%rsi
    648f:	48 81 c2 00 00 10 00 	add    $0x100000,%rdx
    6496:	89 fb                	mov    %edi,%ebx
    6498:	48 89 c7             	mov    %rax,%rdi
    649b:	e8 40 00 00 00       	call   64e0 <fwp_near>
    64a0:	89 df                	mov    %ebx,%edi
    64a2:	85 c0                	test   %eax,%eax
    64a4:	75 08                	jne    64ae <fwp_segv+0x3e>
    64a6:	31 f6                	xor    %esi,%esi
    64a8:	5b                   	pop    %rbx
    64a9:	e9 32 be ff ff       	jmp    22e0 <signal@plt>
    64ae:	e8 ad cb ff ff       	call   3060 <fwp_flush>
    64b3:	48 8d 35 36 81 00 00 	lea    0x8136(%rip),%rsi        # e5f0 <fwp_segv.msg>
    64ba:	ba 1a 00 00 00       	mov    $0x1a,%edx
    64bf:	bf 02 00 00 00       	mov    $0x2,%edi
    64c4:	e8 77 bc ff ff       	call   2140 <write@plt>
    64c9:	bf 65 00 00 00       	mov    $0x65,%edi
    64ce:	e8 cd bb ff ff       	call   20a0 <_exit@plt>
    64d3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    64da:	84 00 00 00 00 00 

00000000000064e0 <fwp_near>:
    64e0:	48 39 f7             	cmp    %rsi,%rdi
    64e3:	0f 93 c0             	setae  %al
    64e6:	48 39 d7             	cmp    %rdx,%rdi
    64e9:	0f 92 c1             	setb   %cl
    64ec:	20 c1                	and    %al,%cl
    64ee:	0f b6 c1             	movzbl %cl,%eax
    64f1:	c3                   	ret
    64f2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    64f9:	1f 84 00 00 00 00 00 

0000000000006500 <fwp_generated>:
    6500:	55                   	push   %rbp
    6501:	41 57                	push   %r15
    6503:	41 56                	push   %r14
    6505:	53                   	push   %rbx
    6506:	50                   	push   %rax
    6507:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    650c:	85 ff                	test   %edi,%edi
    650e:	0f 8e 14 01 00 00    	jle    6628 <fwp_generated+0x128>
    6514:	89 fd                	mov    %edi,%ebp
    6516:	49 89 f7             	mov    %rsi,%r15
    6519:	4c 8b 36             	mov    (%rsi),%r14
    651c:	48 8d 35 7a 8c 00 00 	lea    0x8c7a(%rip),%rsi        # f19d <exec_in_fp0+0xb4d>
    6523:	4c 89 f7             	mov    %r14,%rdi
    6526:	e8 a5 bd ff ff       	call   22d0 <strcmp@plt>
    652b:	85 c0                	test   %eax,%eax
    652d:	74 34                	je     6563 <fwp_generated+0x63>
    652f:	48 8d 35 6d 8c 00 00 	lea    0x8c6d(%rip),%rsi        # f1a3 <exec_in_fp0+0xb53>
    6536:	ba 0d 00 00 00       	mov    $0xd,%edx
    653b:	4c 89 f7             	mov    %r14,%rdi
    653e:	e8 4d bb ff ff       	call   2090 <strncmp@plt>
    6543:	85 c0                	test   %eax,%eax
    6545:	0f 85 dd 00 00 00    	jne    6628 <fwp_generated+0x128>
    654b:	41 0f b6 46 0d       	movzbl 0xd(%r14),%eax
    6550:	85 c0                	test   %eax,%eax
    6552:	74 2c                	je     6580 <fwp_generated+0x80>
    6554:	83 f8 3d             	cmp    $0x3d,%eax
    6557:	0f 85 cb 00 00 00    	jne    6628 <fwp_generated+0x128>
    655d:	49 83 c6 0e          	add    $0xe,%r14
    6561:	eb 2a                	jmp    658d <fwp_generated+0x8d>
    6563:	48 8b 3d 8e f8 00 00 	mov    0xf88e(%rip),%rdi        # 15df8 <fwp_cli_man>
    656a:	48 8b 05 47 da 00 00 	mov    0xda47(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    6571:	48 8b 30             	mov    (%rax),%rsi
    6574:	e8 77 bc ff ff       	call   21f0 <fputs@plt>
    6579:	31 db                	xor    %ebx,%ebx
    657b:	e9 a8 00 00 00       	jmp    6628 <fwp_generated+0x128>
    6580:	83 fd 01             	cmp    $0x1,%ebp
    6583:	0f 84 ac 00 00 00    	je     6635 <fwp_generated+0x135>
    6589:	4d 8b 77 08          	mov    0x8(%r15),%r14
    658d:	48 8d 35 5b 8c 00 00 	lea    0x8c5b(%rip),%rsi        # f1ef <exec_in_fp0+0xb9f>
    6594:	4c 89 f7             	mov    %r14,%rdi
    6597:	e8 34 bd ff ff       	call   22d0 <strcmp@plt>
    659c:	31 db                	xor    %ebx,%ebx
    659e:	85 c0                	test   %eax,%eax
    65a0:	74 63                	je     6605 <fwp_generated+0x105>
    65a2:	48 8d 35 4b 8c 00 00 	lea    0x8c4b(%rip),%rsi        # f1f4 <exec_in_fp0+0xba4>
    65a9:	4c 89 f7             	mov    %r14,%rdi
    65ac:	e8 1f bd ff ff       	call   22d0 <strcmp@plt>
    65b1:	85 c0                	test   %eax,%eax
    65b3:	74 54                	je     6609 <fwp_generated+0x109>
    65b5:	48 8d 35 3c 8c 00 00 	lea    0x8c3c(%rip),%rsi        # f1f8 <exec_in_fp0+0xba8>
    65bc:	4c 89 f7             	mov    %r14,%rdi
    65bf:	e8 0c bd ff ff       	call   22d0 <strcmp@plt>
    65c4:	b9 02 00 00 00       	mov    $0x2,%ecx
    65c9:	85 c0                	test   %eax,%eax
    65cb:	74 41                	je     660e <fwp_generated+0x10e>
    65cd:	4c 89 f7             	mov    %r14,%rdi
    65d0:	e8 9b bb ff ff       	call   2170 <strlen@plt>
    65d5:	4c 89 f7             	mov    %r14,%rdi
    65d8:	48 89 c6             	mov    %rax,%rsi
    65db:	e8 80 00 00 00       	call   6660 <fwp_str_lossy>
    65e0:	48 8b 0d f9 d9 00 00 	mov    0xd9f9(%rip),%rcx        # 13fe0 <stderr@GLIBC_2.2.5>
    65e7:	48 8b 39             	mov    (%rcx),%rdi
    65ea:	48 8d 48 08          	lea    0x8(%rax),%rcx
    65ee:	48 8d 35 08 8c 00 00 	lea    0x8c08(%rip),%rsi        # f1fd <exec_in_fp0+0xbad>
    65f5:	48 8d 15 84 80 00 00 	lea    0x8084(%rip),%rdx        # e680 <exec_in_fp0+0x30>
    65fc:	31 c0                	xor    %eax,%eax
    65fe:	e8 ed bc ff ff       	call   22f0 <fprintf@plt>
    6603:	eb 4f                	jmp    6654 <fwp_generated+0x154>
    6605:	31 c9                	xor    %ecx,%ecx
    6607:	eb 05                	jmp    660e <fwp_generated+0x10e>
    6609:	b9 01 00 00 00       	mov    $0x1,%ecx
    660e:	48 8d 05 cb f7 00 00 	lea    0xf7cb(%rip),%rax        # 15de0 <fwp_cli_scripts>
    6615:	48 8b 3c c8          	mov    (%rax,%rcx,8),%rdi
    6619:	48 8b 05 98 d9 00 00 	mov    0xd998(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    6620:	48 8b 30             	mov    (%rax),%rsi
    6623:	e8 c8 bb ff ff       	call   21f0 <fputs@plt>
    6628:	89 d8                	mov    %ebx,%eax
    662a:	48 83 c4 08          	add    $0x8,%rsp
    662e:	5b                   	pop    %rbx
    662f:	41 5e                	pop    %r14
    6631:	41 5f                	pop    %r15
    6633:	5d                   	pop    %rbp
    6634:	c3                   	ret
    6635:	48 8b 05 a4 d9 00 00 	mov    0xd9a4(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    663c:	48 8b 38             	mov    (%rax),%rdi
    663f:	48 8d 35 6b 8b 00 00 	lea    0x8b6b(%rip),%rsi        # f1b1 <exec_in_fp0+0xb61>
    6646:	48 8d 15 33 80 00 00 	lea    0x8033(%rip),%rdx        # e680 <exec_in_fp0+0x30>
    664d:	31 c0                	xor    %eax,%eax
    664f:	e8 9c bc ff ff       	call   22f0 <fprintf@plt>
    6654:	bb 02 00 00 00       	mov    $0x2,%ebx
    6659:	eb cd                	jmp    6628 <fwp_generated+0x128>
    665b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006660 <fwp_str_lossy>:
    6660:	55                   	push   %rbp
    6661:	41 57                	push   %r15
    6663:	41 56                	push   %r14
    6665:	41 55                	push   %r13
    6667:	41 54                	push   %r12
    6669:	53                   	push   %rbx
    666a:	48 83 ec 18          	sub    $0x18,%rsp
    666e:	48 89 f3             	mov    %rsi,%rbx
    6671:	49 89 fe             	mov    %rdi,%r14
    6674:	e8 27 12 00 00       	call   78a0 <fwp_valid_utf8>
    6679:	85 c0                	test   %eax,%eax
    667b:	74 19                	je     6696 <fwp_str_lossy+0x36>
    667d:	4c 89 f7             	mov    %r14,%rdi
    6680:	48 89 de             	mov    %rbx,%rsi
    6683:	48 83 c4 18          	add    $0x18,%rsp
    6687:	5b                   	pop    %rbx
    6688:	41 5c                	pop    %r12
    668a:	41 5d                	pop    %r13
    668c:	41 5e                	pop    %r14
    668e:	41 5f                	pop    %r15
    6690:	5d                   	pop    %rbp
    6691:	e9 6a 13 00 00       	jmp    7a00 <fwp_str_new>
    6696:	0f 57 c0             	xorps  %xmm0,%xmm0
    6699:	0f 29 04 24          	movaps %xmm0,(%rsp)
    669d:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    66a4:	00 00 
    66a6:	48 85 db             	test   %rbx,%rbx
    66a9:	0f 84 72 01 00 00    	je     6821 <fwp_str_lossy+0x1c1>
    66af:	45 31 ed             	xor    %r13d,%r13d
    66b2:	49 89 e7             	mov    %rsp,%r15
    66b5:	4c 8d 25 6d 8b 00 00 	lea    0x8b6d(%rip),%r12        # f229 <exec_in_fp0+0xbd9>
    66bc:	eb 19                	jmp    66d7 <fwp_str_lossy+0x77>
    66be:	66 90                	xchg   %ax,%ax
    66c0:	4c 89 ff             	mov    %r15,%rdi
    66c3:	4c 89 e6             	mov    %r12,%rsi
    66c6:	e8 95 13 00 00       	call   7a60 <buf_puts>
    66cb:	49 89 ed             	mov    %rbp,%r13
    66ce:	48 39 dd             	cmp    %rbx,%rbp
    66d1:	0f 83 4a 01 00 00    	jae    6821 <fwp_str_lossy+0x1c1>
    66d7:	43 0f b6 04 2e       	movzbl (%r14,%r13,1),%eax
    66dc:	84 c0                	test   %al,%al
    66de:	78 20                	js     6700 <fwp_str_lossy+0xa0>
    66e0:	0f be f0             	movsbl %al,%esi
    66e3:	4c 89 ff             	mov    %r15,%rdi
    66e6:	e8 55 13 00 00       	call   7a40 <buf_putc>
    66eb:	49 ff c5             	inc    %r13
    66ee:	4c 89 ed             	mov    %r13,%rbp
    66f1:	eb d8                	jmp    66cb <fwp_str_lossy+0x6b>
    66f3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    66fa:	84 00 00 00 00 00 
    6700:	8d 48 20             	lea    0x20(%rax),%ecx
    6703:	80 f9 e1             	cmp    $0xe1,%cl
    6706:	77 34                	ja     673c <fwp_str_lossy+0xdc>
    6708:	89 c2                	mov    %eax,%edx
    670a:	80 e2 f0             	and    $0xf0,%dl
    670d:	80 fa e0             	cmp    $0xe0,%dl
    6710:	0f 85 cb 00 00 00    	jne    67e1 <fwp_str_lossy+0x181>
    6716:	3c e0                	cmp    $0xe0,%al
    6718:	40 0f 94 c6          	sete   %sil
    671c:	40 c0 e6 05          	shl    $0x5,%sil
    6720:	40 80 ce 80          	or     $0x80,%sil
    6724:	31 ff                	xor    %edi,%edi
    6726:	3c ed                	cmp    $0xed,%al
    6728:	40 0f 95 c7          	setne  %dil
    672c:	c1 e7 05             	shl    $0x5,%edi
    672f:	81 cf 9f 00 00 00    	or     $0x9f,%edi
    6735:	b8 02 00 00 00       	mov    $0x2,%eax
    673a:	eb 0d                	jmp    6749 <fwp_str_lossy+0xe9>
    673c:	bf bf 00 00 00       	mov    $0xbf,%edi
    6741:	40 b6 80             	mov    $0x80,%sil
    6744:	b8 01 00 00 00       	mov    $0x1,%eax
    6749:	31 d2                	xor    %edx,%edx
    674b:	49 8d 6d 01          	lea    0x1(%r13),%rbp
    674f:	48 39 dd             	cmp    %rbx,%rbp
    6752:	0f 83 68 ff ff ff    	jae    66c0 <fwp_str_lossy+0x60>
    6758:	45 0f b6 04 2e       	movzbl (%r14,%rbp,1),%r8d
    675d:	41 38 f0             	cmp    %sil,%r8b
    6760:	0f 82 5a ff ff ff    	jb     66c0 <fwp_str_lossy+0x60>
    6766:	44 39 c7             	cmp    %r8d,%edi
    6769:	0f 82 51 ff ff ff    	jb     66c0 <fwp_str_lossy+0x60>
    676f:	49 8d 6d 02          	lea    0x2(%r13),%rbp
    6773:	be 01 00 00 00       	mov    $0x1,%esi
    6778:	80 f9 e1             	cmp    $0xe1,%cl
    677b:	77 45                	ja     67c2 <fwp_str_lossy+0x162>
    677d:	48 39 dd             	cmp    %rbx,%rbp
    6780:	73 40                	jae    67c2 <fwp_str_lossy+0x162>
    6782:	41 0f b6 0c 2e       	movzbl (%r14,%rbp,1),%ecx
    6787:	80 e1 c0             	and    $0xc0,%cl
    678a:	80 f9 80             	cmp    $0x80,%cl
    678d:	75 33                	jne    67c2 <fwp_str_lossy+0x162>
    678f:	49 8d 6d 03          	lea    0x3(%r13),%rbp
    6793:	48 39 dd             	cmp    %rbx,%rbp
    6796:	0f 93 c1             	setae  %cl
    6799:	80 f2 01             	xor    $0x1,%dl
    679c:	be 02 00 00 00       	mov    $0x2,%esi
    67a1:	08 ca                	or     %cl,%dl
    67a3:	75 1d                	jne    67c2 <fwp_str_lossy+0x162>
    67a5:	43 0f b6 4c 2e 03    	movzbl 0x3(%r14,%r13,1),%ecx
    67ab:	80 e1 c0             	and    $0xc0,%cl
    67ae:	31 f6                	xor    %esi,%esi
    67b0:	80 f9 80             	cmp    $0x80,%cl
    67b3:	0f 94 c1             	sete   %cl
    67b6:	75 04                	jne    67bc <fwp_str_lossy+0x15c>
    67b8:	49 8d 6d 04          	lea    0x4(%r13),%rbp
    67bc:	40 88 ce             	mov    %cl,%sil
    67bf:	83 ce 02             	or     $0x2,%esi
    67c2:	39 c6                	cmp    %eax,%esi
    67c4:	0f 85 f6 fe ff ff    	jne    66c0 <fwp_str_lossy+0x60>
    67ca:	4b 8d 34 2e          	lea    (%r14,%r13,1),%rsi
    67ce:	48 89 ea             	mov    %rbp,%rdx
    67d1:	4c 29 ea             	sub    %r13,%rdx
    67d4:	4c 89 ff             	mov    %r15,%rdi
    67d7:	e8 b4 12 00 00       	call   7a90 <buf_put>
    67dc:	e9 ea fe ff ff       	jmp    66cb <fwp_str_lossy+0x6b>
    67e1:	8d 50 10             	lea    0x10(%rax),%edx
    67e4:	80 fa 04             	cmp    $0x4,%dl
    67e7:	77 28                	ja     6811 <fwp_str_lossy+0x1b1>
    67e9:	3c f0                	cmp    $0xf0,%al
    67eb:	40 0f 94 c6          	sete   %sil
    67ef:	bf 8f 00 00 00       	mov    $0x8f,%edi
    67f4:	3c f4                	cmp    $0xf4,%al
    67f6:	74 05                	je     67fd <fwp_str_lossy+0x19d>
    67f8:	bf bf 00 00 00       	mov    $0xbf,%edi
    67fd:	40 c0 e6 04          	shl    $0x4,%sil
    6801:	40 80 ce 80          	or     $0x80,%sil
    6805:	b8 03 00 00 00       	mov    $0x3,%eax
    680a:	b2 01                	mov    $0x1,%dl
    680c:	e9 3a ff ff ff       	jmp    674b <fwp_str_lossy+0xeb>
    6811:	4c 89 ff             	mov    %r15,%rdi
    6814:	4c 89 e6             	mov    %r12,%rsi
    6817:	e8 44 12 00 00       	call   7a60 <buf_puts>
    681c:	e9 ca fe ff ff       	jmp    66eb <fwp_str_lossy+0x8b>
    6821:	48 89 e7             	mov    %rsp,%rdi
    6824:	e8 a7 12 00 00       	call   7ad0 <buf_to_str>
    6829:	48 83 c4 18          	add    $0x18,%rsp
    682d:	5b                   	pop    %rbx
    682e:	41 5c                	pop    %r12
    6830:	41 5d                	pop    %r13
    6832:	41 5e                	pop    %r14
    6834:	41 5f                	pop    %r15
    6836:	5d                   	pop    %rbp
    6837:	c3                   	ret
    6838:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    683f:	00 

0000000000006840 <fwp_alloc_leaf>:
    6840:	be 01 00 00 00       	mov    $0x1,%esi
    6845:	e9 a6 ca ff ff       	jmp    32f0 <fwp_gc_alloc>
    684a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000006850 <fwp_cli_parse>:
    6850:	c7 01 00 00 00 00    	movl   $0x0,(%rcx)
    6856:	85 ff                	test   %edi,%edi
    6858:	0f 8e 6d 01 00 00    	jle    69cb <fwp_cli_parse+0x17b>
    685e:	55                   	push   %rbp
    685f:	41 57                	push   %r15
    6861:	41 56                	push   %r14
    6863:	41 55                	push   %r13
    6865:	41 54                	push   %r12
    6867:	53                   	push   %rbx
    6868:	48 83 ec 28          	sub    $0x28,%rsp
    686c:	41 89 f8             	mov    %edi,%r8d
    686f:	4d 89 c1             	mov    %r8,%r9
    6872:	49 f7 d9             	neg    %r9
    6875:	40 b5 01             	mov    $0x1,%bpl
    6878:	45 31 ff             	xor    %r15d,%r15d
    687b:	41 be 01 00 00 00    	mov    $0x1,%r14d
    6881:	31 db                	xor    %ebx,%ebx
    6883:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
    6888:	48 89 74 24 18       	mov    %rsi,0x18(%rsp)
    688d:	4c 89 44 24 10       	mov    %r8,0x10(%rsp)
    6892:	4c 89 4c 24 08       	mov    %r9,0x8(%rsp)
    6897:	48 89 0c 24          	mov    %rcx,(%rsp)
    689b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    68a0:	4e 8b 6c f6 f8       	mov    -0x8(%rsi,%r14,8),%r13
    68a5:	85 db                	test   %ebx,%ebx
    68a7:	75 37                	jne    68e0 <fwp_cli_parse+0x90>
    68a9:	4d 8b 65 00          	mov    0x0(%r13),%r12
    68ad:	49 83 fc 02          	cmp    $0x2,%r12
    68b1:	72 2d                	jb     68e0 <fwp_cli_parse+0x90>
    68b3:	49 8d 7d 08          	lea    0x8(%r13),%rdi
    68b7:	80 3f 2d             	cmpb   $0x2d,(%rdi)
    68ba:	75 24                	jne    68e0 <fwp_cli_parse+0x90>
    68bc:	e8 ff 12 00 00       	call   7bc0 <fwp_is_number_arg>
    68c1:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    68c6:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    68cb:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    68d0:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    68d5:	48 8b 0c 24          	mov    (%rsp),%rcx
    68d9:	85 c0                	test   %eax,%eax
    68db:	74 2f                	je     690c <fwp_cli_parse+0xbc>
    68dd:	0f 1f 00             	nopl   (%rax)
    68e0:	49 63 c7             	movslq %r15d,%rax
    68e3:	41 8d 7f 01          	lea    0x1(%r15),%edi
    68e7:	89 39                	mov    %edi,(%rcx)
    68e9:	4c 89 2c c2          	mov    %r13,(%rdx,%rax,8)
    68ed:	41 89 ff             	mov    %edi,%r15d
    68f0:	4d 39 c6             	cmp    %r8,%r14
    68f3:	40 0f 92 c5          	setb   %bpl
    68f7:	4b 8d 04 31          	lea    (%r9,%r14,1),%rax
    68fb:	48 ff c0             	inc    %rax
    68fe:	49 ff c6             	inc    %r14
    6901:	48 83 f8 01          	cmp    $0x1,%rax
    6905:	75 99                	jne    68a0 <fwp_cli_parse+0x50>
    6907:	e9 a9 00 00 00       	jmp    69b5 <fwp_cli_parse+0x165>
    690c:	41 0f b6 45 09       	movzbl 0x9(%r13),%eax
    6911:	49 83 fc 02          	cmp    $0x2,%r12
    6915:	75 1a                	jne    6931 <fwp_cli_parse+0xe1>
    6917:	bb 01 00 00 00       	mov    $0x1,%ebx
    691c:	3c 2d                	cmp    $0x2d,%al
    691e:	74 d0                	je     68f0 <fwp_cli_parse+0xa0>
    6920:	31 db                	xor    %ebx,%ebx
    6922:	49 83 fc 02          	cmp    $0x2,%r12
    6926:	75 b8                	jne    68e0 <fwp_cli_parse+0x90>
    6928:	3c 68                	cmp    $0x68,%al
    692a:	75 b4                	jne    68e0 <fwp_cli_parse+0x90>
    692c:	e9 84 00 00 00       	jmp    69b5 <fwp_cli_parse+0x165>
    6931:	31 db                	xor    %ebx,%ebx
    6933:	3c 2d                	cmp    $0x2d,%al
    6935:	75 a9                	jne    68e0 <fwp_cli_parse+0x90>
    6937:	49 8d 5d 0a          	lea    0xa(%r13),%rbx
    693b:	49 83 c4 fe          	add    $0xfffffffffffffffe,%r12
    693f:	48 89 df             	mov    %rbx,%rdi
    6942:	be 3d 00 00 00       	mov    $0x3d,%esi
    6947:	4c 89 e2             	mov    %r12,%rdx
    694a:	e8 11 b9 ff ff       	call   2260 <memchr@plt>
    694f:	48 89 c1             	mov    %rax,%rcx
    6952:	48 29 d9             	sub    %rbx,%rcx
    6955:	48 85 c0             	test   %rax,%rax
    6958:	49 0f 44 cc          	cmove  %r12,%rcx
    695c:	75 38                	jne    6996 <fwp_cli_parse+0x146>
    695e:	48 83 f9 04          	cmp    $0x4,%rcx
    6962:	48 8b 0c 24          	mov    (%rsp),%rcx
    6966:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    696b:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    6970:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    6975:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    697a:	75 13                	jne    698f <fwp_cli_parse+0x13f>
    697c:	81 3b 68 65 6c 70    	cmpl   $0x706c6568,(%rbx)
    6982:	bb 00 00 00 00       	mov    $0x0,%ebx
    6987:	0f 85 53 ff ff ff    	jne    68e0 <fwp_cli_parse+0x90>
    698d:	eb 26                	jmp    69b5 <fwp_cli_parse+0x165>
    698f:	31 db                	xor    %ebx,%ebx
    6991:	e9 4a ff ff ff       	jmp    68e0 <fwp_cli_parse+0x90>
    6996:	48 8b 0c 24          	mov    (%rsp),%rcx
    699a:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    699f:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    69a4:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    69a9:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    69ae:	31 db                	xor    %ebx,%ebx
    69b0:	e9 2b ff ff ff       	jmp    68e0 <fwp_cli_parse+0x90>
    69b5:	40 0f b6 c5          	movzbl %bpl,%eax
    69b9:	83 e0 01             	and    $0x1,%eax
    69bc:	48 83 c4 28          	add    $0x28,%rsp
    69c0:	5b                   	pop    %rbx
    69c1:	41 5c                	pop    %r12
    69c3:	41 5d                	pop    %r13
    69c5:	41 5e                	pop    %r14
    69c7:	41 5f                	pop    %r15
    69c9:	5d                   	pop    %rbp
    69ca:	c3                   	ret
    69cb:	31 c0                	xor    %eax,%eax
    69cd:	c3                   	ret
    69ce:	66 90                	xchg   %ax,%ax

00000000000069d0 <fwp_usage_error>:
    69d0:	48 8b 05 09 d6 00 00 	mov    0xd609(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    69d7:	48 8b 38             	mov    (%rax),%rdi
    69da:	48 8d 35 e5 88 00 00 	lea    0x88e5(%rip),%rsi        # f2c6 <exec_in_fp0+0xc76>
    69e1:	48 8d 15 f1 89 00 00 	lea    0x89f1(%rip),%rdx        # f3d9 <exec_in_fp0+0xd89>
    69e8:	31 c0                	xor    %eax,%eax
    69ea:	e9 01 b9 ff ff       	jmp    22f0 <fprintf@plt>
    69ef:	90                   	nop

00000000000069f0 <fwp_parse_text>:
    69f0:	48 83 ec 18          	sub    $0x18,%rsp
    69f4:	48 89 d1             	mov    %rdx,%rcx
    69f7:	48 89 3c 24          	mov    %rdi,(%rsp)
    69fb:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    6a00:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    6a07:	00 00 
    6a09:	48 8d 35 20 f3 00 00 	lea    0xf320(%rip),%rsi        # 15d30 <d0>
    6a10:	48 89 e7             	mov    %rsp,%rdi
    6a13:	ba 01 00 00 00       	mov    $0x1,%edx
    6a18:	e8 a3 16 00 00       	call   80c0 <tp_value>
    6a1d:	85 c0                	test   %eax,%eax
    6a1f:	74 1c                	je     6a3d <fwp_parse_text+0x4d>
    6a21:	48 89 e7             	mov    %rsp,%rdi
    6a24:	e8 c7 1f 00 00       	call   89f0 <tp_ws>
    6a29:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    6a2e:	31 c0                	xor    %eax,%eax
    6a30:	48 3b 4c 24 08       	cmp    0x8(%rsp),%rcx
    6a35:	0f 94 c0             	sete   %al
    6a38:	48 83 c4 18          	add    $0x18,%rsp
    6a3c:	c3                   	ret
    6a3d:	31 c0                	xor    %eax,%eax
    6a3f:	48 83 c4 18          	add    $0x18,%rsp
    6a43:	c3                   	ret
    6a44:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    6a4b:	00 00 00 00 00 

0000000000006a50 <fwp_parse_arg>:
    6a50:	53                   	push   %rbx
    6a51:	48 83 ec 10          	sub    $0x10,%rsp
    6a55:	89 fb                	mov    %edi,%ebx
    6a57:	48 8b 06             	mov    (%rsi),%rax
    6a5a:	48 8d 7e 08          	lea    0x8(%rsi),%rdi
    6a5e:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    6a63:	48 89 c6             	mov    %rax,%rsi
    6a66:	e8 85 12 00 00       	call   7cf0 <fwp_cli_value>
    6a6b:	89 c1                	mov    %eax,%ecx
    6a6d:	b8 01 00 00 00       	mov    $0x1,%eax
    6a72:	85 c9                	test   %ecx,%ecx
    6a74:	74 06                	je     6a7c <fwp_parse_arg+0x2c>
    6a76:	48 83 c4 10          	add    $0x10,%rsp
    6a7a:	5b                   	pop    %rbx
    6a7b:	c3                   	ret
    6a7c:	48 8b 05 5d d5 00 00 	mov    0xd55d(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    6a83:	48 8b 38             	mov    (%rax),%rdi
    6a86:	ff c3                	inc    %ebx
    6a88:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
    6a8d:	49 83 c0 08          	add    $0x8,%r8
    6a91:	48 8d 35 1d 88 00 00 	lea    0x881d(%rip),%rsi        # f2b5 <exec_in_fp0+0xc65>
    6a98:	48 8d 15 e1 7b 00 00 	lea    0x7be1(%rip),%rdx        # e680 <exec_in_fp0+0x30>
    6a9f:	89 d9                	mov    %ebx,%ecx
    6aa1:	31 c0                	xor    %eax,%eax
    6aa3:	e8 48 b8 ff ff       	call   22f0 <fprintf@plt>
    6aa8:	31 c0                	xor    %eax,%eax
    6aaa:	eb ca                	jmp    6a76 <fwp_parse_arg+0x26>
    6aac:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000006ab0 <fwp_bind_positional>:
    6ab0:	50                   	push   %rax
    6ab1:	31 c0                	xor    %eax,%eax
    6ab3:	85 f6                	test   %esi,%esi
    6ab5:	0f 9e c0             	setle  %al
    6ab8:	89 01                	mov    %eax,(%rcx)
    6aba:	83 fe 01             	cmp    $0x1,%esi
    6abd:	76 0c                	jbe    6acb <fwp_bind_positional+0x1b>
    6abf:	e8 0c ff ff ff       	call   69d0 <fwp_usage_error>
    6ac4:	b8 02 00 00 00       	mov    $0x2,%eax
    6ac9:	59                   	pop    %rcx
    6aca:	c3                   	ret
    6acb:	31 c0                	xor    %eax,%eax
    6acd:	83 fe 01             	cmp    $0x1,%esi
    6ad0:	75 f7                	jne    6ac9 <fwp_bind_positional+0x19>
    6ad2:	48 8b 37             	mov    (%rdi),%rsi
    6ad5:	31 ff                	xor    %edi,%edi
    6ad7:	e8 74 ff ff ff       	call   6a50 <fwp_parse_arg>
    6adc:	89 c1                	mov    %eax,%ecx
    6ade:	31 c0                	xor    %eax,%eax
    6ae0:	85 c9                	test   %ecx,%ecx
    6ae2:	0f 94 c0             	sete   %al
    6ae5:	01 c0                	add    %eax,%eax
    6ae7:	59                   	pop    %rcx
    6ae8:	c3                   	ret
    6ae9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000006af0 <fwp_pipe_out_start>:
    6af0:	41 56                	push   %r14
    6af2:	53                   	push   %rbx
    6af3:	48 81 ec 08 01 00 00 	sub    $0x108,%rsp
    6afa:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    6aff:	bf 01 00 00 00       	mov    $0x1,%edi
    6b04:	e8 d7 b9 ff ff       	call   24e0 <fstat@plt>
    6b09:	85 c0                	test   %eax,%eax
    6b0b:	0f 85 82 00 00 00    	jne    6b93 <fwp_pipe_out_start+0xa3>
    6b11:	b8 00 f0 00 00       	mov    $0xf000,%eax
    6b16:	23 44 24 20          	and    0x20(%rsp),%eax
    6b1a:	3d 00 10 00 00       	cmp    $0x1000,%eax
    6b1f:	75 72                	jne    6b93 <fwp_pipe_out_start+0xa3>
    6b21:	bf 01 00 00 00       	mov    $0x1,%edi
    6b26:	be 07 04 00 00       	mov    $0x407,%esi
    6b2b:	ba 00 00 10 00       	mov    $0x100000,%edx
    6b30:	31 c0                	xor    %eax,%eax
    6b32:	e8 e9 b5 ff ff       	call   2120 <fcntl@plt>
    6b37:	e8 34 36 00 00       	call   a170 <fwp_transport_off>
    6b3c:	85 c0                	test   %eax,%eax
    6b3e:	75 53                	jne    6b93 <fwp_pipe_out_start+0xa3>
    6b40:	bf 01 00 00 00       	mov    $0x1,%edi
    6b45:	be 01 08 08 00       	mov    $0x80801,%esi
    6b4a:	31 d2                	xor    %edx,%edx
    6b4c:	e8 bf b9 ff ff       	call   2510 <socket@plt>
    6b51:	85 c0                	test   %eax,%eax
    6b53:	78 3e                	js     6b93 <fwp_pipe_out_start+0xa3>
    6b55:	89 c3                	mov    %eax,%ebx
    6b57:	4c 8d b4 24 9a 00 00 	lea    0x9a(%rsp),%r14
    6b5e:	00 
    6b5f:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    6b64:	4c 89 f7             	mov    %r14,%rdi
    6b67:	e8 34 36 00 00       	call   a1a0 <fwp_pipe_addr>
    6b6c:	89 df                	mov    %ebx,%edi
    6b6e:	4c 89 f6             	mov    %r14,%rsi
    6b71:	89 c2                	mov    %eax,%edx
    6b73:	e8 58 b8 ff ff       	call   23d0 <bind@plt>
    6b78:	85 c0                	test   %eax,%eax
    6b7a:	75 10                	jne    6b8c <fwp_pipe_out_start+0x9c>
    6b7c:	89 df                	mov    %ebx,%edi
    6b7e:	be 01 00 00 00       	mov    $0x1,%esi
    6b83:	e8 d8 b7 ff ff       	call   2360 <listen@plt>
    6b88:	85 c0                	test   %eax,%eax
    6b8a:	74 12                	je     6b9e <fwp_pipe_out_start+0xae>
    6b8c:	89 df                	mov    %ebx,%edi
    6b8e:	e8 9d b6 ff ff       	call   2230 <close@plt>
    6b93:	48 81 c4 08 01 00 00 	add    $0x108,%rsp
    6b9a:	5b                   	pop    %rbx
    6b9b:	41 5e                	pop    %r14
    6b9d:	c3                   	ret
    6b9e:	89 1d 18 f1 00 00    	mov    %ebx,0xf118(%rip)        # 15cbc <fwp_po_listen>
    6ba4:	e8 47 36 00 00       	call   a1f0 <fwp_now_ns>
    6ba9:	48 b9 00 f2 05 2a 01 	movabs $0x12a05f200,%rcx
    6bb0:	00 00 00 
    6bb3:	48 01 c1             	add    %rax,%rcx
    6bb6:	48 89 0d 7b f2 01 00 	mov    %rcx,0x1f27b(%rip)        # 25e38 <fwp_po_give_up>
    6bbd:	eb d4                	jmp    6b93 <fwp_pipe_out_start+0xa3>
    6bbf:	90                   	nop

0000000000006bc0 <fwp_pipe_write>:
    6bc0:	41 57                	push   %r15
    6bc2:	41 56                	push   %r14
    6bc4:	53                   	push   %rbx
    6bc5:	48 89 f3             	mov    %rsi,%rbx
    6bc8:	8b 05 72 f2 01 00    	mov    0x1f272(%rip),%eax        # 25e40 <fwp_po_kind>
    6bce:	83 f8 01             	cmp    $0x1,%eax
    6bd1:	74 12                	je     6be5 <fwp_pipe_write+0x25>
    6bd3:	83 f8 02             	cmp    $0x2,%eax
    6bd6:	75 46                	jne    6c1e <fwp_pipe_write+0x5e>
    6bd8:	48 89 de             	mov    %rbx,%rsi
    6bdb:	5b                   	pop    %rbx
    6bdc:	41 5e                	pop    %r14
    6bde:	41 5f                	pop    %r15
    6be0:	e9 3b 36 00 00       	jmp    a220 <fwp_ring_put>
    6be5:	49 89 fe             	mov    %rdi,%r14
    6be8:	48 8b 05 59 f2 01 00 	mov    0x1f259(%rip),%rax        # 25e48 <fwp_po_len>
    6bef:	48 01 d8             	add    %rbx,%rax
    6bf2:	48 3d 01 00 01 00    	cmp    $0x10001,%rax
    6bf8:	72 05                	jb     6bff <fwp_pipe_write+0x3f>
    6bfa:	e8 81 37 00 00       	call   a380 <fwp_po_flush_sock>
    6bff:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    6c06:	72 32                	jb     6c3a <fwp_pipe_write+0x7a>
    6c08:	8b 3d b2 f0 00 00    	mov    0xf0b2(%rip),%edi        # 15cc0 <fwp_po_sock>
    6c0e:	4c 89 f6             	mov    %r14,%rsi
    6c11:	48 89 da             	mov    %rbx,%rdx
    6c14:	5b                   	pop    %rbx
    6c15:	41 5e                	pop    %r14
    6c17:	41 5f                	pop    %r15
    6c19:	e9 92 37 00 00       	jmp    a3b0 <fwp_po_write_raw>
    6c1e:	48 8b 05 93 d3 00 00 	mov    0xd393(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    6c25:	48 8b 08             	mov    (%rax),%rcx
    6c28:	be 01 00 00 00       	mov    $0x1,%esi
    6c2d:	48 89 da             	mov    %rbx,%rdx
    6c30:	5b                   	pop    %rbx
    6c31:	41 5e                	pop    %r14
    6c33:	41 5f                	pop    %r15
    6c35:	e9 66 b8 ff ff       	jmp    24a0 <fwrite@plt>
    6c3a:	4c 8b 3d 07 f2 01 00 	mov    0x1f207(%rip),%r15        # 25e48 <fwp_po_len>
    6c41:	48 8d 3d 08 f2 01 00 	lea    0x1f208(%rip),%rdi        # 25e50 <fwp_po_buf>
    6c48:	4c 01 ff             	add    %r15,%rdi
    6c4b:	4c 89 f6             	mov    %r14,%rsi
    6c4e:	48 89 da             	mov    %rbx,%rdx
    6c51:	e8 da b6 ff ff       	call   2330 <memcpy@plt>
    6c56:	49 01 df             	add    %rbx,%r15
    6c59:	4c 89 3d e8 f1 01 00 	mov    %r15,0x1f1e8(%rip)        # 25e48 <fwp_po_len>
    6c60:	5b                   	pop    %rbx
    6c61:	41 5e                	pop    %r14
    6c63:	41 5f                	pop    %r15
    6c65:	c3                   	ret
    6c66:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    6c6d:	00 00 00 

0000000000006c70 <fwp_pipe_flush>:
    6c70:	8b 05 ca f1 01 00    	mov    0x1f1ca(%rip),%eax        # 25e40 <fwp_po_kind>
    6c76:	85 c0                	test   %eax,%eax
    6c78:	74 0a                	je     6c84 <fwp_pipe_flush+0x14>
    6c7a:	83 f8 01             	cmp    $0x1,%eax
    6c7d:	75 1b                	jne    6c9a <fwp_pipe_flush+0x2a>
    6c7f:	e9 fc 36 00 00       	jmp    a380 <fwp_po_flush_sock>
    6c84:	50                   	push   %rax
    6c85:	48 8b 05 2c d3 00 00 	mov    0xd32c(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    6c8c:	48 8b 38             	mov    (%rax),%rdi
    6c8f:	e8 bc b6 ff ff       	call   2350 <fflush@plt>
    6c94:	58                   	pop    %rax
    6c95:	e9 f6 39 00 00       	jmp    a690 <fwp_pipe_poll>
    6c9a:	c3                   	ret
    6c9b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006ca0 <fwp_pipe_out_ready>:
    6ca0:	48 83 ec 18          	sub    $0x18,%rsp
    6ca4:	48 8d 3d 59 86 00 00 	lea    0x8659(%rip),%rdi        # f304 <exec_in_fp0+0xcb4>
    6cab:	e8 80 b3 ff ff       	call   2030 <getenv@plt>
    6cb0:	48 85 c0             	test   %rax,%rax
    6cb3:	74 79                	je     6d2e <fwp_pipe_out_ready+0x8e>
    6cb5:	83 3d 00 f0 00 00 00 	cmpl   $0x0,0xf000(%rip)        # 15cbc <fwp_po_listen>
    6cbc:	78 70                	js     6d2e <fwp_pipe_out_ready+0x8e>
    6cbe:	80 38 00             	cmpb   $0x0,(%rax)
    6cc1:	74 6b                	je     6d2e <fwp_pipe_out_ready+0x8e>
    6cc3:	48 89 c7             	mov    %rax,%rdi
    6cc6:	31 f6                	xor    %esi,%esi
    6cc8:	ba 0a 00 00 00       	mov    $0xa,%edx
    6ccd:	e8 4e b6 ff ff       	call   2320 <strtol@plt>
    6cd2:	8b 0d e4 ef 00 00    	mov    0xefe4(%rip),%ecx        # 15cbc <fwp_po_listen>
    6cd8:	89 0c 24             	mov    %ecx,(%rsp)
    6cdb:	48 b9 01 00 00 00 01 	movabs $0x100000001,%rcx
    6ce2:	00 00 00 
    6ce5:	48 89 4c 24 04       	mov    %rcx,0x4(%rsp)
    6cea:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%rsp)
    6cf1:	00 
    6cf2:	48 85 c0             	test   %rax,%rax
    6cf5:	7e 37                	jle    6d2e <fwp_pipe_out_ready+0x8e>
    6cf7:	48 3d ff ff ff 7f    	cmp    $0x7fffffff,%rax
    6cfd:	ba ff ff ff 7f       	mov    $0x7fffffff,%edx
    6d02:	48 0f 4c d0          	cmovl  %rax,%rdx
    6d06:	48 89 e7             	mov    %rsp,%rdi
    6d09:	be 02 00 00 00       	mov    $0x2,%esi
    6d0e:	e8 ad b6 ff ff       	call   23c0 <poll@plt>
    6d13:	85 c0                	test   %eax,%eax
    6d15:	7e 17                	jle    6d2e <fwp_pipe_out_ready+0x8e>
    6d17:	f6 44 24 06 01       	testb  $0x1,0x6(%rsp)
    6d1c:	74 10                	je     6d2e <fwp_pipe_out_ready+0x8e>
    6d1e:	48 c7 05 37 f1 02 00 	movq   $0x0,0x2f137(%rip)        # 35e60 <fwp_po_next_check>
    6d25:	00 00 00 00 
    6d29:	e8 62 39 00 00       	call   a690 <fwp_pipe_poll>
    6d2e:	48 83 c4 18          	add    $0x18,%rsp
    6d32:	c3                   	ret
    6d33:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6d3a:	84 00 00 00 00 00 

0000000000006d40 <fwp_exec_call>:
    6d40:	41 56                	push   %r14
    6d42:	53                   	push   %rbx
    6d43:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
    6d4a:	48 89 f3             	mov    %rsi,%rbx
    6d4d:	49 89 fe             	mov    %rdi,%r14
    6d50:	48 8b 05 11 f1 02 00 	mov    0x2f111(%rip),%rax        # 35e68 <fwp_handlers>
    6d57:	48 89 84 24 d0 00 00 	mov    %rax,0xd0(%rsp)
    6d5e:	00 
    6d5f:	48 c7 84 24 e8 00 00 	movq   $0x0,0xe8(%rsp)
    6d66:	00 00 00 00 00 
    6d6b:	48 8b 05 66 f0 00 00 	mov    0xf066(%rip),%rax        # 15dd8 <fwp_cleanups>
    6d72:	48 89 84 24 f0 00 00 	mov    %rax,0xf0(%rsp)
    6d79:	00 
    6d7a:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    6d7f:	48 89 3d e2 f0 02 00 	mov    %rdi,0x2f0e2(%rip)        # 35e68 <fwp_handlers>
    6d86:	e8 25 b5 ff ff       	call   22b0 <_setjmp@plt>
    6d8b:	85 c0                	test   %eax,%eax
    6d8d:	74 32                	je     6dc1 <fwp_exec_call+0x81>
    6d8f:	48 8b 84 24 d0 00 00 	mov    0xd0(%rsp),%rax
    6d96:	00 
    6d97:	48 89 05 ca f0 02 00 	mov    %rax,0x2f0ca(%rip)        # 35e68 <fwp_handlers>
    6d9e:	e8 bd c2 ff ff       	call   3060 <fwp_flush>
    6da3:	48 8b bc 24 d8 00 00 	mov    0xd8(%rsp),%rdi
    6daa:	00 
    6dab:	48 8b b4 24 e0 00 00 	mov    0xe0(%rsp),%rsi
    6db2:	00 
    6db3:	e8 28 41 00 00       	call   aee0 <fwp_exec_error>
    6db8:	b9 01 00 00 00       	mov    $0x1,%ecx
    6dbd:	31 c0                	xor    %eax,%eax
    6dbf:	eb 21                	jmp    6de2 <fwp_exec_call+0xa2>
    6dc1:	e8 fa 40 00 00       	call   aec0 <fwp_pap>
    6dc6:	48 89 c7             	mov    %rax,%rdi
    6dc9:	4c 89 f6             	mov    %r14,%rsi
    6dcc:	e8 2f 3c 00 00       	call   aa00 <fwp_apply>
    6dd1:	48 8b 8c 24 d0 00 00 	mov    0xd0(%rsp),%rcx
    6dd8:	00 
    6dd9:	48 89 0d 88 f0 02 00 	mov    %rcx,0x2f088(%rip)        # 35e68 <fwp_handlers>
    6de0:	31 c9                	xor    %ecx,%ecx
    6de2:	89 0b                	mov    %ecx,(%rbx)
    6de4:	48 81 c4 f8 00 00 00 	add    $0xf8,%rsp
    6deb:	5b                   	pop    %rbx
    6dec:	41 5e                	pop    %r14
    6dee:	c3                   	ret
    6def:	90                   	nop

0000000000006df0 <fwp_emit_result>:
    6df0:	e9 5b 55 00 00       	jmp    c350 <fwp_emit>
    6df5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    6dfc:	00 00 00 00 

0000000000006e00 <fwp_read_exact>:
    6e00:	41 57                	push   %r15
    6e02:	41 56                	push   %r14
    6e04:	53                   	push   %rbx
    6e05:	48 89 f3             	mov    %rsi,%rbx
    6e08:	49 89 fe             	mov    %rdi,%r14
    6e0b:	45 31 ff             	xor    %r15d,%r15d
    6e0e:	48 85 f6             	test   %rsi,%rsi
    6e11:	0f 84 b9 00 00 00    	je     6ed0 <fwp_read_exact+0xd0>
    6e17:	8b 05 0b f0 01 00    	mov    0x1f00b(%rip),%eax        # 25e28 <fwp_in_npend>
    6e1d:	8b 0d 09 f0 01 00    	mov    0x1f009(%rip),%ecx        # 25e2c <fwp_in_ppos>
    6e23:	39 c1                	cmp    %eax,%ecx
    6e25:	0f 8d a5 00 00 00    	jge    6ed0 <fwp_read_exact+0xd0>
    6e2b:	48 98                	cltq
    6e2d:	48 63 f1             	movslq %ecx,%rsi
    6e30:	48 89 f2             	mov    %rsi,%rdx
    6e33:	48 f7 d2             	not    %rdx
    6e36:	48 01 c2             	add    %rax,%rdx
    6e39:	48 8d 4b ff          	lea    -0x1(%rbx),%rcx
    6e3d:	48 39 ca             	cmp    %rcx,%rdx
    6e40:	48 0f 43 d1          	cmovae %rcx,%rdx
    6e44:	48 ff c2             	inc    %rdx
    6e47:	48 83 fa 20          	cmp    $0x20,%rdx
    6e4b:	72 16                	jb     6e63 <fwp_read_exact+0x63>
    6e4d:	48 8d 3d d0 ef 01 00 	lea    0x1efd0(%rip),%rdi        # 25e24 <fwp_in_pend>
    6e54:	4d 89 f0             	mov    %r14,%r8
    6e57:	49 29 f0             	sub    %rsi,%r8
    6e5a:	49 29 f8             	sub    %rdi,%r8
    6e5d:	49 83 f8 20          	cmp    $0x20,%r8
    6e61:	73 27                	jae    6e8a <fwp_read_exact+0x8a>
    6e63:	45 31 ff             	xor    %r15d,%r15d
    6e66:	48 89 f1             	mov    %rsi,%rcx
    6e69:	48 8d 15 b4 ef 01 00 	lea    0x1efb4(%rip),%rdx        # 25e24 <fwp_in_pend>
    6e70:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6e74:	48 ff c1             	inc    %rcx
    6e77:	43 88 34 3e          	mov    %sil,(%r14,%r15,1)
    6e7b:	49 ff c7             	inc    %r15
    6e7e:	49 39 df             	cmp    %rbx,%r15
    6e81:	73 3f                	jae    6ec2 <fwp_read_exact+0xc2>
    6e83:	48 39 c1             	cmp    %rax,%rcx
    6e86:	7c e8                	jl     6e70 <fwp_read_exact+0x70>
    6e88:	eb 38                	jmp    6ec2 <fwp_read_exact+0xc2>
    6e8a:	49 89 d7             	mov    %rdx,%r15
    6e8d:	49 83 e7 e0          	and    $0xffffffffffffffe0,%r15
    6e91:	49 8d 0c 37          	lea    (%r15,%rsi,1),%rcx
    6e95:	48 01 fe             	add    %rdi,%rsi
    6e98:	48 83 c6 10          	add    $0x10,%rsi
    6e9c:	31 ff                	xor    %edi,%edi
    6e9e:	66 90                	xchg   %ax,%ax
    6ea0:	0f 10 44 3e f0       	movups -0x10(%rsi,%rdi,1),%xmm0
    6ea5:	0f 10 0c 3e          	movups (%rsi,%rdi,1),%xmm1
    6ea9:	41 0f 11 04 3e       	movups %xmm0,(%r14,%rdi,1)
    6eae:	41 0f 11 4c 3e 10    	movups %xmm1,0x10(%r14,%rdi,1)
    6eb4:	48 83 c7 20          	add    $0x20,%rdi
    6eb8:	49 39 ff             	cmp    %rdi,%r15
    6ebb:	75 e3                	jne    6ea0 <fwp_read_exact+0xa0>
    6ebd:	4c 39 fa             	cmp    %r15,%rdx
    6ec0:	75 a7                	jne    6e69 <fwp_read_exact+0x69>
    6ec2:	89 0d 64 ef 01 00    	mov    %ecx,0x1ef64(%rip)        # 25e2c <fwp_in_ppos>
    6ec8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6ecf:	00 
    6ed0:	48 89 de             	mov    %rbx,%rsi
    6ed3:	4c 29 fe             	sub    %r15,%rsi
    6ed6:	76 15                	jbe    6eed <fwp_read_exact+0xed>
    6ed8:	4b 8d 3c 3e          	lea    (%r14,%r15,1),%rdi
    6edc:	e8 4f 58 00 00       	call   c730 <fwp_pipe_read>
    6ee1:	49 01 c7             	add    %rax,%r15
    6ee4:	48 85 c0             	test   %rax,%rax
    6ee7:	75 e7                	jne    6ed0 <fwp_read_exact+0xd0>
    6ee9:	31 c0                	xor    %eax,%eax
    6eeb:	eb 05                	jmp    6ef2 <fwp_read_exact+0xf2>
    6eed:	b8 01 00 00 00       	mov    $0x1,%eax
    6ef2:	5b                   	pop    %rbx
    6ef3:	41 5e                	pop    %r14
    6ef5:	41 5f                	pop    %r15
    6ef7:	c3                   	ret
    6ef8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6eff:	00 

0000000000006f00 <fwp_stdin_leb>:
    6f00:	41 57                	push   %r15
    6f02:	41 56                	push   %r14
    6f04:	53                   	push   %rbx
    6f05:	48 83 ec 10          	sub    $0x10,%rsp
    6f09:	48 89 fb             	mov    %rdi,%rbx
    6f0c:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    6f13:	49 c7 c6 f9 ff ff ff 	mov    $0xfffffffffffffff9,%r14
    6f1a:	4c 8d 7c 24 0f       	lea    0xf(%rsp),%r15
    6f1f:	90                   	nop
    6f20:	be 01 00 00 00       	mov    $0x1,%esi
    6f25:	4c 89 ff             	mov    %r15,%rdi
    6f28:	e8 d3 fe ff ff       	call   6e00 <fwp_read_exact>
    6f2d:	85 c0                	test   %eax,%eax
    6f2f:	74 35                	je     6f66 <fwp_stdin_leb+0x66>
    6f31:	0f b6 44 24 0f       	movzbl 0xf(%rsp),%eax
    6f36:	49 83 fe 38          	cmp    $0x38,%r14
    6f3a:	75 07                	jne    6f43 <fwp_stdin_leb+0x43>
    6f3c:	89 c1                	mov    %eax,%ecx
    6f3e:	80 e1 7e             	and    $0x7e,%cl
    6f41:	75 1c                	jne    6f5f <fwp_stdin_leb+0x5f>
    6f43:	49 83 c6 07          	add    $0x7,%r14
    6f47:	89 c2                	mov    %eax,%edx
    6f49:	83 e2 7f             	and    $0x7f,%edx
    6f4c:	44 89 f1             	mov    %r14d,%ecx
    6f4f:	48 d3 e2             	shl    %cl,%rdx
    6f52:	48 09 13             	or     %rdx,(%rbx)
    6f55:	84 c0                	test   %al,%al
    6f57:	79 11                	jns    6f6a <fwp_stdin_leb+0x6a>
    6f59:	49 83 fe 38          	cmp    $0x38,%r14
    6f5d:	76 c1                	jbe    6f20 <fwp_stdin_leb+0x20>
    6f5f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    6f64:	eb 09                	jmp    6f6f <fwp_stdin_leb+0x6f>
    6f66:	31 c0                	xor    %eax,%eax
    6f68:	eb 05                	jmp    6f6f <fwp_stdin_leb+0x6f>
    6f6a:	b8 01 00 00 00       	mov    $0x1,%eax
    6f6f:	48 83 c4 10          	add    $0x10,%rsp
    6f73:	5b                   	pop    %rbx
    6f74:	41 5e                	pop    %r14
    6f76:	41 5f                	pop    %r15
    6f78:	c3                   	ret
    6f79:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000006f80 <fwp_stdin_name_len>:
    6f80:	53                   	push   %rbx
    6f81:	48 89 fb             	mov    %rdi,%rbx
    6f84:	e8 77 ff ff ff       	call   6f00 <fwp_stdin_leb>
    6f89:	83 f8 01             	cmp    $0x1,%eax
    6f8c:	75 0e                	jne    6f9c <fwp_stdin_name_len+0x1c>
    6f8e:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    6f93:	48 81 3b 00 00 10 00 	cmpq   $0x100000,(%rbx)
    6f9a:	77 02                	ja     6f9e <fwp_stdin_name_len+0x1e>
    6f9c:	89 c1                	mov    %eax,%ecx
    6f9e:	89 c8                	mov    %ecx,%eax
    6fa0:	5b                   	pop    %rbx
    6fa1:	c3                   	ret
    6fa2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6fa9:	1f 84 00 00 00 00 00 

0000000000006fb0 <fwp_pipe_in_offer>:
    6fb0:	55                   	push   %rbp
    6fb1:	41 57                	push   %r15
    6fb3:	41 56                	push   %r14
    6fb5:	53                   	push   %rbx
    6fb6:	48 81 ec 08 01 00 00 	sub    $0x108,%rsp
    6fbd:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    6fc2:	31 ff                	xor    %edi,%edi
    6fc4:	e8 17 b5 ff ff       	call   24e0 <fstat@plt>
    6fc9:	85 c0                	test   %eax,%eax
    6fcb:	0f 85 a5 00 00 00    	jne    7076 <fwp_pipe_in_offer+0xc6>
    6fd1:	b8 00 f0 00 00       	mov    $0xf000,%eax
    6fd6:	23 44 24 20          	and    0x20(%rsp),%eax
    6fda:	3d 00 10 00 00       	cmp    $0x1000,%eax
    6fdf:	0f 85 91 00 00 00    	jne    7076 <fwp_pipe_in_offer+0xc6>
    6fe5:	bf 01 00 00 00       	mov    $0x1,%edi
    6fea:	be 01 00 08 00       	mov    $0x80001,%esi
    6fef:	31 d2                	xor    %edx,%edx
    6ff1:	e8 1a b5 ff ff       	call   2510 <socket@plt>
    6ff6:	85 c0                	test   %eax,%eax
    6ff8:	78 7c                	js     7076 <fwp_pipe_in_offer+0xc6>
    6ffa:	89 c3                	mov    %eax,%ebx
    6ffc:	48 8d bc 24 9a 00 00 	lea    0x9a(%rsp),%rdi
    7003:	00 
    7004:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    7009:	e8 92 31 00 00       	call   a1a0 <fwp_pipe_addr>
    700e:	41 89 c6             	mov    %eax,%r14d
    7011:	48 8d 3d b2 82 00 00 	lea    0x82b2(%rip),%rdi        # f2ca <exec_in_fp0+0xc7a>
    7018:	e8 13 b0 ff ff       	call   2030 <getenv@plt>
    701d:	49 89 c7             	mov    %rax,%r15
    7020:	e8 4b 31 00 00       	call   a170 <fwp_transport_off>
    7025:	89 c5                	mov    %eax,%ebp
    7027:	c7 04 24 46 57 50 54 	movl   $0x54505746,(%rsp)
    702e:	85 c0                	test   %eax,%eax
    7030:	74 04                	je     7036 <fwp_pipe_in_offer+0x86>
    7032:	31 c0                	xor    %eax,%eax
    7034:	eb 1f                	jmp    7055 <fwp_pipe_in_offer+0xa5>
    7036:	4d 85 ff             	test   %r15,%r15
    7039:	74 18                	je     7053 <fwp_pipe_in_offer+0xa3>
    703b:	48 8d 35 5b 83 00 00 	lea    0x835b(%rip),%rsi        # f39d <exec_in_fp0+0xd4d>
    7042:	4c 89 ff             	mov    %r15,%rdi
    7045:	e8 86 b2 ff ff       	call   22d0 <strcmp@plt>
    704a:	83 f8 01             	cmp    $0x1,%eax
    704d:	b0 02                	mov    $0x2,%al
    704f:	1c 00                	sbb    $0x0,%al
    7051:	eb 02                	jmp    7055 <fwp_pipe_in_offer+0xa5>
    7053:	b0 02                	mov    $0x2,%al
    7055:	88 44 24 04          	mov    %al,0x4(%rsp)
    7059:	48 8d b4 24 9a 00 00 	lea    0x9a(%rsp),%rsi
    7060:	00 
    7061:	89 df                	mov    %ebx,%edi
    7063:	44 89 f2             	mov    %r14d,%edx
    7066:	e8 25 b4 ff ff       	call   2490 <connect@plt>
    706b:	85 c0                	test   %eax,%eax
    706d:	74 15                	je     7084 <fwp_pipe_in_offer+0xd4>
    706f:	89 df                	mov    %ebx,%edi
    7071:	e8 ba b1 ff ff       	call   2230 <close@plt>
    7076:	48 81 c4 08 01 00 00 	add    $0x108,%rsp
    707d:	5b                   	pop    %rbx
    707e:	41 5e                	pop    %r14
    7080:	41 5f                	pop    %r15
    7082:	5d                   	pop    %rbp
    7083:	c3                   	ret
    7084:	48 89 e6             	mov    %rsp,%rsi
    7087:	ba 05 00 00 00       	mov    $0x5,%edx
    708c:	89 df                	mov    %ebx,%edi
    708e:	b9 00 40 00 00       	mov    $0x4000,%ecx
    7093:	e8 08 b1 ff ff       	call   21a0 <send@plt>
    7098:	85 ed                	test   %ebp,%ebp
    709a:	75 d3                	jne    706f <fwp_pipe_in_offer+0xbf>
    709c:	48 83 f8 05          	cmp    $0x5,%rax
    70a0:	75 cd                	jne    706f <fwp_pipe_in_offer+0xbf>
    70a2:	89 1d 20 ec 00 00    	mov    %ebx,0xec20(%rip)        # 15cc8 <fwp_pi_sock>
    70a8:	eb cc                	jmp    7076 <fwp_pipe_in_offer+0xc6>
    70aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000070b0 <fwp_pipe_in_switch>:
    70b0:	55                   	push   %rbp
    70b1:	41 57                	push   %r15
    70b3:	41 56                	push   %r14
    70b5:	53                   	push   %rbx
    70b6:	48 81 ec 08 01 00 00 	sub    $0x108,%rsp
    70bd:	31 db                	xor    %ebx,%ebx
    70bf:	48 83 fe 01          	cmp    $0x1,%rsi
    70c3:	0f 85 f6 01 00 00    	jne    72bf <fwp_pipe_in_switch+0x20f>
    70c9:	48 89 f8             	mov    %rdi,%rax
    70cc:	8b 3d f6 eb 00 00    	mov    0xebf6(%rip),%edi        # 15cc8 <fwp_pi_sock>
    70d2:	85 ff                	test   %edi,%edi
    70d4:	0f 88 e5 01 00 00    	js     72bf <fwp_pipe_in_switch+0x20f>
    70da:	83 3d 93 ed 02 00 00 	cmpl   $0x0,0x2ed93(%rip)        # 35e74 <fwp_pi_kind>
    70e1:	0f 85 d8 01 00 00    	jne    72bf <fwp_pipe_in_switch+0x20f>
    70e7:	0f b6 00             	movzbl (%rax),%eax
    70ea:	83 f8 02             	cmp    $0x2,%eax
    70ed:	74 29                	je     7118 <fwp_pipe_in_switch+0x68>
    70ef:	83 f8 01             	cmp    $0x1,%eax
    70f2:	0f 85 c7 01 00 00    	jne    72bf <fwp_pipe_in_switch+0x20f>
    70f8:	c7 05 72 ed 02 00 01 	movl   $0x1,0x2ed72(%rip)        # 35e74 <fwp_pi_kind>
    70ff:	00 00 00 
    7102:	48 8d 3d ab 7f 00 00 	lea    0x7fab(%rip),%rdi        # f0b4 <exec_in_fp0+0xa64>
    7109:	e8 42 58 00 00       	call   c950 <fwp_pipe_report>
    710e:	bb 01 00 00 00       	mov    $0x1,%ebx
    7113:	e9 a7 01 00 00       	jmp    72bf <fwp_pipe_in_switch+0x20f>
    7118:	48 8d 44 24 0f       	lea    0xf(%rsp),%rax
    711d:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    7122:	48 c7 44 24 58 01 00 	movq   $0x1,0x58(%rsp)
    7129:	00 00 
    712b:	0f 57 c0             	xorps  %xmm0,%xmm0
    712e:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    7133:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    7138:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    713d:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    7144:	00 00 
    7146:	48 8d 44 24 50       	lea    0x50(%rsp),%rax
    714b:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    7150:	48 c7 44 24 28 01 00 	movq   $0x1,0x28(%rsp)
    7157:	00 00 
    7159:	48 8d 44 24 60       	lea    0x60(%rsp),%rax
    715e:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    7163:	48 c7 44 24 38 18 00 	movq   $0x18,0x38(%rsp)
    716a:	00 00 
    716c:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    7171:	ba 00 00 00 40       	mov    $0x40000000,%edx
    7176:	e8 25 b2 ff ff       	call   23a0 <recvmsg@plt>
    717b:	31 db                	xor    %ebx,%ebx
    717d:	48 83 f8 01          	cmp    $0x1,%rax
    7181:	0f 85 38 01 00 00    	jne    72bf <fwp_pipe_in_switch+0x20f>
    7187:	48 83 7c 24 38 10    	cmpq   $0x10,0x38(%rsp)
    718d:	0f 82 2c 01 00 00    	jb     72bf <fwp_pipe_in_switch+0x20f>
    7193:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    7198:	48 85 c0             	test   %rax,%rax
    719b:	0f 84 1e 01 00 00    	je     72bf <fwp_pipe_in_switch+0x20f>
    71a1:	83 78 0c 01          	cmpl   $0x1,0xc(%rax)
    71a5:	0f 85 14 01 00 00    	jne    72bf <fwp_pipe_in_switch+0x20f>
    71ab:	8b 68 10             	mov    0x10(%rax),%ebp
    71ae:	48 8d 74 24 78       	lea    0x78(%rsp),%rsi
    71b3:	89 ef                	mov    %ebp,%edi
    71b5:	e8 26 b3 ff ff       	call   24e0 <fstat@plt>
    71ba:	85 c0                	test   %eax,%eax
    71bc:	0f 85 f4 00 00 00    	jne    72b6 <fwp_pipe_in_switch+0x206>
    71c2:	4c 8b b4 24 a8 00 00 	mov    0xa8(%rsp),%r14
    71c9:	00 
    71ca:	49 81 fe 00 10 00 00 	cmp    $0x1000,%r14
    71d1:	0f 86 df 00 00 00    	jbe    72b6 <fwp_pipe_in_switch+0x206>
    71d7:	31 db                	xor    %ebx,%ebx
    71d9:	31 ff                	xor    %edi,%edi
    71db:	4c 89 f6             	mov    %r14,%rsi
    71de:	ba 03 00 00 00       	mov    $0x3,%edx
    71e3:	b9 01 00 00 00       	mov    $0x1,%ecx
    71e8:	41 89 e8             	mov    %ebp,%r8d
    71eb:	45 31 c9             	xor    %r9d,%r9d
    71ee:	e8 9d af ff ff       	call   2190 <mmap@plt>
    71f3:	49 89 c7             	mov    %rax,%r15
    71f6:	89 ef                	mov    %ebp,%edi
    71f8:	e8 33 b0 ff ff       	call   2230 <close@plt>
    71fd:	49 83 ff ff          	cmp    $0xffffffffffffffff,%r15
    7201:	0f 84 b8 00 00 00    	je     72bf <fwp_pipe_in_switch+0x20f>
    7207:	41 81 3f 46 57 50 53 	cmpl   $0x53505746,(%r15)
    720e:	0f 85 ab 00 00 00    	jne    72bf <fwp_pipe_in_switch+0x20f>
    7214:	41 83 7f 04 01       	cmpl   $0x1,0x4(%r15)
    7219:	0f 85 a0 00 00 00    	jne    72bf <fwp_pipe_in_switch+0x20f>
    721f:	49 8b 47 08          	mov    0x8(%r15),%rax
    7223:	48 85 c0             	test   %rax,%rax
    7226:	0f 84 93 00 00 00    	je     72bf <fwp_pipe_in_switch+0x20f>
    722c:	48 89 c1             	mov    %rax,%rcx
    722f:	48 d1 e9             	shr    $1,%rcx
    7232:	48 ba 55 55 55 55 55 	movabs $0x5555555555555555,%rdx
    7239:	55 55 55 
    723c:	48 21 ca             	and    %rcx,%rdx
    723f:	48 89 c1             	mov    %rax,%rcx
    7242:	48 29 d1             	sub    %rdx,%rcx
    7245:	48 ba 33 33 33 33 33 	movabs $0x3333333333333333,%rdx
    724c:	33 33 33 
    724f:	48 89 ce             	mov    %rcx,%rsi
    7252:	48 21 d6             	and    %rdx,%rsi
    7255:	48 c1 e9 02          	shr    $0x2,%rcx
    7259:	48 21 d1             	and    %rdx,%rcx
    725c:	48 01 f1             	add    %rsi,%rcx
    725f:	48 89 ca             	mov    %rcx,%rdx
    7262:	48 c1 ea 04          	shr    $0x4,%rdx
    7266:	48 01 ca             	add    %rcx,%rdx
    7269:	48 b9 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%rcx
    7270:	0f 0f 0f 
    7273:	48 21 d1             	and    %rdx,%rcx
    7276:	48 ba 01 01 01 01 01 	movabs $0x101010101010101,%rdx
    727d:	01 01 01 
    7280:	48 0f af d1          	imul   %rcx,%rdx
    7284:	48 c1 ea 38          	shr    $0x38,%rdx
    7288:	83 fa 01             	cmp    $0x1,%edx
    728b:	77 32                	ja     72bf <fwp_pipe_in_switch+0x20f>
    728d:	49 81 c6 00 f0 ff ff 	add    $0xfffffffffffff000,%r14
    7294:	4c 39 f0             	cmp    %r14,%rax
    7297:	77 26                	ja     72bf <fwp_pipe_in_switch+0x20f>
    7299:	4c 89 3d d8 eb 02 00 	mov    %r15,0x2ebd8(%rip)        # 35e78 <fwp_pi_ring>
    72a0:	c7 05 ca eb 02 00 02 	movl   $0x2,0x2ebca(%rip)        # 35e74 <fwp_pi_kind>
    72a7:	00 00 00 
    72aa:	48 8d 3d f0 80 00 00 	lea    0x80f0(%rip),%rdi        # f3a1 <exec_in_fp0+0xd51>
    72b1:	e9 53 fe ff ff       	jmp    7109 <fwp_pipe_in_switch+0x59>
    72b6:	89 ef                	mov    %ebp,%edi
    72b8:	e8 73 af ff ff       	call   2230 <close@plt>
    72bd:	31 db                	xor    %ebx,%ebx
    72bf:	89 d8                	mov    %ebx,%eax
    72c1:	48 81 c4 08 01 00 00 	add    $0x108,%rsp
    72c8:	5b                   	pop    %rbx
    72c9:	41 5e                	pop    %r14
    72cb:	41 5f                	pop    %r15
    72cd:	5d                   	pop    %rbp
    72ce:	c3                   	ret
    72cf:	90                   	nop

00000000000072d0 <fwp_decode>:
    72d0:	55                   	push   %rbp
    72d1:	41 57                	push   %r15
    72d3:	41 56                	push   %r14
    72d5:	41 55                	push   %r13
    72d7:	41 54                	push   %r12
    72d9:	53                   	push   %rbx
    72da:	48 83 ec 38          	sub    $0x38,%rsp
    72de:	8b 06                	mov    (%rsi),%eax
    72e0:	45 31 f6             	xor    %r14d,%r14d
    72e3:	48 83 f8 15          	cmp    $0x15,%rax
    72e7:	77 47                	ja     7330 <fwp_decode+0x60>
    72e9:	48 89 d3             	mov    %rdx,%rbx
    72ec:	49 89 f4             	mov    %rsi,%r12
    72ef:	49 89 ff             	mov    %rdi,%r15
    72f2:	48 8d 0d 87 6e 00 00 	lea    0x6e87(%rip),%rcx        # e180 <_IO_stdin_used+0x180>
    72f9:	48 63 14 81          	movslq (%rcx,%rax,4),%rdx
    72fd:	48 01 ca             	add    %rcx,%rdx
    7300:	ff e2                	jmp    *%rdx
    7302:	31 c9                	xor    %ecx,%ecx
    7304:	83 f8 0a             	cmp    $0xa,%eax
    7307:	0f 95 c1             	setne  %cl
    730a:	8d 34 8d 04 00 00 00 	lea    0x4(,%rcx,4),%esi
    7311:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7316:	4c 89 ff             	mov    %r15,%rdi
    7319:	e8 82 56 00 00       	call   c9a0 <rd_le>
    731e:	85 c0                	test   %eax,%eax
    7320:	74 0e                	je     7330 <fwp_decode+0x60>
    7322:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    7327:	48 89 03             	mov    %rax,(%rbx)
    732a:	41 be 01 00 00 00    	mov    $0x1,%r14d
    7330:	44 89 f0             	mov    %r14d,%eax
    7333:	48 83 c4 38          	add    $0x38,%rsp
    7337:	5b                   	pop    %rbx
    7338:	41 5c                	pop    %r12
    733a:	41 5d                	pop    %r13
    733c:	41 5e                	pop    %r14
    733e:	41 5f                	pop    %r15
    7340:	5d                   	pop    %rbp
    7341:	c3                   	ret
    7342:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    7347:	4c 89 ff             	mov    %r15,%rdi
    734a:	e8 11 57 00 00       	call   ca60 <rd_leb>
    734f:	45 31 f6             	xor    %r14d,%r14d
    7352:	85 c0                	test   %eax,%eax
    7354:	74 da                	je     7330 <fwp_decode+0x60>
    7356:	4c 8b 6c 24 08       	mov    0x8(%rsp),%r13
    735b:	4d 3b 6f 08          	cmp    0x8(%r15),%r13
    735f:	77 cf                	ja     7330 <fwp_decode+0x60>
    7361:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    7366:	4c 89 ff             	mov    %r15,%rdi
    7369:	4c 89 ee             	mov    %r13,%rsi
    736c:	e8 6f 57 00 00       	call   cae0 <rd_take>
    7371:	85 c0                	test   %eax,%eax
    7373:	74 bb                	je     7330 <fwp_decode+0x60>
    7375:	41 83 3c 24 0c       	cmpl   $0xc,(%r12)
    737a:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    737f:	75 0f                	jne    7390 <fwp_decode+0xc0>
    7381:	4c 89 ff             	mov    %r15,%rdi
    7384:	4c 89 ee             	mov    %r13,%rsi
    7387:	e8 14 05 00 00       	call   78a0 <fwp_valid_utf8>
    738c:	85 c0                	test   %eax,%eax
    738e:	74 a0                	je     7330 <fwp_decode+0x60>
    7390:	4c 89 ff             	mov    %r15,%rdi
    7393:	4c 89 ee             	mov    %r13,%rsi
    7396:	e8 65 06 00 00       	call   7a00 <fwp_str_new>
    739b:	eb 8a                	jmp    7327 <fwp_decode+0x57>
    739d:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    73a2:	4c 89 ff             	mov    %r15,%rdi
    73a5:	be 01 00 00 00       	mov    $0x1,%esi
    73aa:	e8 f1 55 00 00       	call   c9a0 <rd_le>
    73af:	85 c0                	test   %eax,%eax
    73b1:	0f 84 79 ff ff ff    	je     7330 <fwp_decode+0x60>
    73b7:	48 0f be 44 24 08    	movsbq 0x8(%rsp),%rax
    73bd:	e9 65 ff ff ff       	jmp    7327 <fwp_decode+0x57>
    73c2:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    73c7:	4c 89 ff             	mov    %r15,%rdi
    73ca:	be 08 00 00 00       	mov    $0x8,%esi
    73cf:	e8 cc 55 00 00       	call   c9a0 <rd_le>
    73d4:	45 31 f6             	xor    %r14d,%r14d
    73d7:	85 c0                	test   %eax,%eax
    73d9:	0f 84 51 ff ff ff    	je     7330 <fwp_decode+0x60>
    73df:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    73e4:	4c 89 ff             	mov    %r15,%rdi
    73e7:	be 08 00 00 00       	mov    $0x8,%esi
    73ec:	e8 af 55 00 00       	call   c9a0 <rd_le>
    73f1:	85 c0                	test   %eax,%eax
    73f3:	0f 84 37 ff ff ff    	je     7330 <fwp_decode+0x60>
    73f9:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    73fe:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    7403:	41 83 3c 24 04       	cmpl   $0x4,(%r12)
    7408:	0f 85 d1 02 00 00    	jne    76df <fwp_decode+0x40f>
    740e:	e8 9d 24 00 00       	call   98b0 <fwp_box_i128>
    7413:	e9 0f ff ff ff       	jmp    7327 <fwp_decode+0x57>
    7418:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    741d:	4c 89 ff             	mov    %r15,%rdi
    7420:	e8 3b 56 00 00       	call   ca60 <rd_leb>
    7425:	85 c0                	test   %eax,%eax
    7427:	0f 84 03 ff ff ff    	je     7330 <fwp_decode+0x60>
    742d:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    7432:	49 3b 6f 08          	cmp    0x8(%r15),%rbp
    7436:	0f 87 f4 fe ff ff    	ja     7330 <fwp_decode+0x60>
    743c:	4c 8d 35 ed e9 01 00 	lea    0x1e9ed(%rip),%r14        # 25e30 <fwp_empty_map>
    7443:	48 85 ed             	test   %rbp,%rbp
    7446:	0f 84 9d 02 00 00    	je     76e9 <fwp_decode+0x419>
    744c:	4c 8d 6c 24 18       	lea    0x18(%rsp),%r13
    7451:	eb 20                	jmp    7473 <fwp_decode+0x1a3>
    7453:	31 f6                	xor    %esi,%esi
    7455:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    745a:	49 8b 4c 24 38       	mov    0x38(%r12),%rcx
    745f:	4c 89 f2             	mov    %r14,%rdx
    7462:	e8 89 1c 00 00       	call   90f0 <fwp_p_map_insert>
    7467:	49 89 c6             	mov    %rax,%r14
    746a:	48 ff cd             	dec    %rbp
    746d:	0f 84 76 02 00 00    	je     76e9 <fwp_decode+0x419>
    7473:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
    747a:	00 00 
    747c:	49 8b 74 24 38       	mov    0x38(%r12),%rsi
    7481:	4c 89 ff             	mov    %r15,%rdi
    7484:	4c 89 ea             	mov    %r13,%rdx
    7487:	e8 44 fe ff ff       	call   72d0 <fwp_decode>
    748c:	85 c0                	test   %eax,%eax
    748e:	0f 84 69 02 00 00    	je     76fd <fwp_decode+0x42d>
    7494:	41 83 3c 24 12       	cmpl   $0x12,(%r12)
    7499:	75 b8                	jne    7453 <fwp_decode+0x183>
    749b:	49 8b 74 24 40       	mov    0x40(%r12),%rsi
    74a0:	4c 89 ff             	mov    %r15,%rdi
    74a3:	48 8d 54 24 30       	lea    0x30(%rsp),%rdx
    74a8:	e8 23 fe ff ff       	call   72d0 <fwp_decode>
    74ad:	85 c0                	test   %eax,%eax
    74af:	0f 84 48 02 00 00    	je     76fd <fwp_decode+0x42d>
    74b5:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    74ba:	eb 99                	jmp    7455 <fwp_decode+0x185>
    74bc:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    74c1:	4c 89 ff             	mov    %r15,%rdi
    74c4:	e8 97 55 00 00       	call   ca60 <rd_leb>
    74c9:	85 c0                	test   %eax,%eax
    74cb:	0f 84 5f fe ff ff    	je     7330 <fwp_decode+0x60>
    74d1:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
    74d6:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    74db:	49 3b 5f 08          	cmp    0x8(%r15),%rbx
    74df:	0f 87 4b fe ff ff    	ja     7330 <fwp_decode+0x60>
    74e5:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    74ec:	00 
    74ed:	e8 3e e2 ff ff       	call   5730 <fwp_alloc>
    74f2:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    74f7:	48 85 db             	test   %rbx,%rbx
    74fa:	74 35                	je     7531 <fwp_decode+0x261>
    74fc:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
    7501:	49 89 dd             	mov    %rbx,%r13
    7504:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    750b:	00 00 00 00 00 
    7510:	49 8b 74 24 38       	mov    0x38(%r12),%rsi
    7515:	4c 89 ff             	mov    %r15,%rdi
    7518:	48 89 ea             	mov    %rbp,%rdx
    751b:	e8 b0 fd ff ff       	call   72d0 <fwp_decode>
    7520:	85 c0                	test   %eax,%eax
    7522:	0f 84 08 fe ff ff    	je     7330 <fwp_decode+0x60>
    7528:	48 83 c5 08          	add    $0x8,%rbp
    752c:	49 ff cd             	dec    %r13
    752f:	75 df                	jne    7510 <fwp_decode+0x240>
    7531:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    7536:	48 89 de             	mov    %rbx,%rsi
    7539:	e8 a2 02 00 00       	call   77e0 <fwp_list_from>
    753e:	41 83 3c 24 11       	cmpl   $0x11,(%r12)
    7543:	0f 85 b4 00 00 00    	jne    75fd <fwp_decode+0x32d>
    7549:	48 89 c7             	mov    %rax,%rdi
    754c:	e8 4f 1a 00 00       	call   8fa0 <fwp_p_array_from_list>
    7551:	e9 a7 00 00 00       	jmp    75fd <fwp_decode+0x32d>
    7556:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    755b:	4c 89 ff             	mov    %r15,%rdi
    755e:	e8 fd 54 00 00       	call   ca60 <rd_leb>
    7563:	85 c0                	test   %eax,%eax
    7565:	0f 84 c5 fd ff ff    	je     7330 <fwp_decode+0x60>
    756b:	4c 8b 6c 24 08       	mov    0x8(%rsp),%r13
    7570:	49 63 44 24 10       	movslq 0x10(%r12),%rax
    7575:	49 39 c5             	cmp    %rax,%r13
    7578:	0f 83 b2 fd ff ff    	jae    7330 <fwp_decode+0x60>
    757e:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
    7583:	49 8b 44 24 28       	mov    0x28(%r12),%rax
    7588:	4a 63 1c a8          	movslq (%rax,%r13,4),%rbx
    758c:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    7593:	00 
    7594:	e8 97 e1 ff ff       	call   5730 <fwp_alloc>
    7599:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    759e:	89 d8                	mov    %ebx,%eax
    75a0:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    75a5:	48 85 db             	test   %rbx,%rbx
    75a8:	7e 41                	jle    75eb <fwp_decode+0x31b>
    75aa:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    75af:	48 8d 2c c5 00 00 00 	lea    0x0(,%rax,8),%rbp
    75b6:	00 
    75b7:	45 31 f6             	xor    %r14d,%r14d
    75ba:	31 db                	xor    %ebx,%ebx
    75bc:	49 8b 44 24 30       	mov    0x30(%r12),%rax
    75c1:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    75c5:	48 8b 34 18          	mov    (%rax,%rbx,1),%rsi
    75c9:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    75ce:	48 8d 14 18          	lea    (%rax,%rbx,1),%rdx
    75d2:	4c 89 ff             	mov    %r15,%rdi
    75d5:	e8 f6 fc ff ff       	call   72d0 <fwp_decode>
    75da:	85 c0                	test   %eax,%eax
    75dc:	0f 84 4e fd ff ff    	je     7330 <fwp_decode+0x60>
    75e2:	48 83 c3 08          	add    $0x8,%rbx
    75e6:	48 39 dd             	cmp    %rbx,%rbp
    75e9:	75 d1                	jne    75bc <fwp_decode+0x2ec>
    75eb:	44 89 ef             	mov    %r13d,%edi
    75ee:	48 8b 74 24 28       	mov    0x28(%rsp),%rsi
    75f3:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
    75f8:	e8 33 bb ff ff       	call   3130 <fwp_data>
    75fd:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    7602:	48 89 01             	mov    %rax,(%rcx)
    7605:	e9 20 fd ff ff       	jmp    732a <fwp_decode+0x5a>
    760a:	be 01 00 00 00       	mov    $0x1,%esi
    760f:	e9 fd fc ff ff       	jmp    7311 <fwp_decode+0x41>
    7614:	be 02 00 00 00       	mov    $0x2,%esi
    7619:	e9 f3 fc ff ff       	jmp    7311 <fwp_decode+0x41>
    761e:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7623:	4c 89 ff             	mov    %r15,%rdi
    7626:	be 02 00 00 00       	mov    $0x2,%esi
    762b:	e8 70 53 00 00       	call   c9a0 <rd_le>
    7630:	85 c0                	test   %eax,%eax
    7632:	0f 84 f8 fc ff ff    	je     7330 <fwp_decode+0x60>
    7638:	48 0f bf 44 24 08    	movswq 0x8(%rsp),%rax
    763e:	e9 e4 fc ff ff       	jmp    7327 <fwp_decode+0x57>
    7643:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7648:	4c 89 ff             	mov    %r15,%rdi
    764b:	be 04 00 00 00       	mov    $0x4,%esi
    7650:	e8 4b 53 00 00       	call   c9a0 <rd_le>
    7655:	85 c0                	test   %eax,%eax
    7657:	0f 84 d3 fc ff ff    	je     7330 <fwp_decode+0x60>
    765d:	48 63 44 24 08       	movslq 0x8(%rsp),%rax
    7662:	e9 c0 fc ff ff       	jmp    7327 <fwp_decode+0x57>
    7667:	be 04 00 00 00       	mov    $0x4,%esi
    766c:	e9 a0 fc ff ff       	jmp    7311 <fwp_decode+0x41>
    7671:	49 63 7c 24 10       	movslq 0x10(%r12),%rdi
    7676:	48 85 ff             	test   %rdi,%rdi
    7679:	74 76                	je     76f1 <fwp_decode+0x421>
    767b:	48 c1 e7 03          	shl    $0x3,%rdi
    767f:	e8 ac e0 ff ff       	call   5730 <fwp_alloc>
    7684:	41 8b 7c 24 10       	mov    0x10(%r12),%edi
    7689:	85 ff                	test   %edi,%edi
    768b:	7e 45                	jle    76d2 <fwp_decode+0x402>
    768d:	45 31 f6             	xor    %r14d,%r14d
    7690:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    7695:	48 89 c5             	mov    %rax,%rbp
    7698:	45 31 ed             	xor    %r13d,%r13d
    769b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    76a0:	49 8b 44 24 20       	mov    0x20(%r12),%rax
    76a5:	4a 8b 34 e8          	mov    (%rax,%r13,8),%rsi
    76a9:	4c 89 ff             	mov    %r15,%rdi
    76ac:	48 89 ea             	mov    %rbp,%rdx
    76af:	e8 1c fc ff ff       	call   72d0 <fwp_decode>
    76b4:	85 c0                	test   %eax,%eax
    76b6:	0f 84 74 fc ff ff    	je     7330 <fwp_decode+0x60>
    76bc:	49 ff c5             	inc    %r13
    76bf:	49 63 7c 24 10       	movslq 0x10(%r12),%rdi
    76c4:	48 83 c5 08          	add    $0x8,%rbp
    76c8:	49 39 fd             	cmp    %rdi,%r13
    76cb:	7c d3                	jl     76a0 <fwp_decode+0x3d0>
    76cd:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    76d2:	48 89 c6             	mov    %rax,%rsi
    76d5:	e8 36 ba ff ff       	call   3110 <fwp_record>
    76da:	e9 48 fc ff ff       	jmp    7327 <fwp_decode+0x57>
    76df:	e8 7c 20 00 00       	call   9760 <fwp_box_u128>
    76e4:	e9 3e fc ff ff       	jmp    7327 <fwp_decode+0x57>
    76e9:	4c 89 33             	mov    %r14,(%rbx)
    76ec:	e9 39 fc ff ff       	jmp    732a <fwp_decode+0x5a>
    76f1:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    76f8:	e9 2d fc ff ff       	jmp    732a <fwp_decode+0x5a>
    76fd:	45 31 f6             	xor    %r14d,%r14d
    7700:	e9 2b fc ff ff       	jmp    7330 <fwp_decode+0x60>
    7705:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    770c:	00 00 00 00 

0000000000007710 <fwp_read_text_line>:
    7710:	53                   	push   %rbx
    7711:	48 89 fb             	mov    %rdi,%rbx
    7714:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
    771b:	00 
    771c:	e8 ef 53 00 00       	call   cb10 <fwp_getc>
    7721:	83 f8 ff             	cmp    $0xffffffff,%eax
    7724:	74 59                	je     777f <fwp_read_text_line+0x6f>
    7726:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    772d:	00 00 00 
    7730:	83 f8 0a             	cmp    $0xa,%eax
    7733:	74 1a                	je     774f <fwp_read_text_line+0x3f>
    7735:	0f be f0             	movsbl %al,%esi
    7738:	48 89 df             	mov    %rbx,%rdi
    773b:	e8 00 03 00 00       	call   7a40 <buf_putc>
    7740:	e8 cb 53 00 00       	call   cb10 <fwp_getc>
    7745:	83 f8 ff             	cmp    $0xffffffff,%eax
    7748:	75 e6                	jne    7730 <fwp_read_text_line+0x20>
    774a:	48 8b 03             	mov    (%rbx),%rax
    774d:	eb 1c                	jmp    776b <fwp_read_text_line+0x5b>
    774f:	48 8b 03             	mov    (%rbx),%rax
    7752:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    7756:	48 85 c9             	test   %rcx,%rcx
    7759:	74 10                	je     776b <fwp_read_text_line+0x5b>
    775b:	80 7c 08 ff 0d       	cmpb   $0xd,-0x1(%rax,%rcx,1)
    7760:	75 12                	jne    7774 <fwp_read_text_line+0x64>
    7762:	48 ff c9             	dec    %rcx
    7765:	48 89 4b 08          	mov    %rcx,0x8(%rbx)
    7769:	eb 05                	jmp    7770 <fwp_read_text_line+0x60>
    776b:	48 85 c0             	test   %rax,%rax
    776e:	74 08                	je     7778 <fwp_read_text_line+0x68>
    7770:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    7774:	c6 04 08 00          	movb   $0x0,(%rax,%rcx,1)
    7778:	b8 01 00 00 00       	mov    $0x1,%eax
    777d:	5b                   	pop    %rbx
    777e:	c3                   	ret
    777f:	31 c0                	xor    %eax,%eax
    7781:	5b                   	pop    %rbx
    7782:	c3                   	ret
    7783:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    778a:	84 00 00 00 00 00 

0000000000007790 <fwp_mem_realloc>:
    7790:	41 57                	push   %r15
    7792:	41 56                	push   %r14
    7794:	53                   	push   %rbx
    7795:	49 89 d6             	mov    %rdx,%r14
    7798:	49 89 f7             	mov    %rsi,%r15
    779b:	48 89 fb             	mov    %rdi,%rbx
    779e:	48 89 d7             	mov    %rdx,%rdi
    77a1:	e8 8a df ff ff       	call   5730 <fwp_alloc>
    77a6:	48 85 db             	test   %rbx,%rbx
    77a9:	74 23                	je     77ce <fwp_mem_realloc+0x3e>
    77ab:	4d 39 f7             	cmp    %r14,%r15
    77ae:	4d 0f 42 f7          	cmovb  %r15,%r14
    77b2:	48 89 c7             	mov    %rax,%rdi
    77b5:	48 89 de             	mov    %rbx,%rsi
    77b8:	4c 89 f2             	mov    %r14,%rdx
    77bb:	49 89 c6             	mov    %rax,%r14
    77be:	e8 6d ab ff ff       	call   2330 <memcpy@plt>
    77c3:	48 89 df             	mov    %rbx,%rdi
    77c6:	e8 55 e0 ff ff       	call   5820 <fwp_mem_free>
    77cb:	4c 89 f0             	mov    %r14,%rax
    77ce:	5b                   	pop    %rbx
    77cf:	41 5e                	pop    %r14
    77d1:	41 5f                	pop    %r15
    77d3:	c3                   	ret
    77d4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    77db:	00 00 00 00 00 

00000000000077e0 <fwp_list_from>:
    77e0:	41 56                	push   %r14
    77e2:	53                   	push   %rbx
    77e3:	50                   	push   %rax
    77e4:	48 89 fb             	mov    %rdi,%rbx
    77e7:	48 85 f6             	test   %rsi,%rsi
    77ea:	74 28                	je     7814 <fwp_list_from+0x34>
    77ec:	49 89 f6             	mov    %rsi,%r14
    77ef:	31 c0                	xor    %eax,%eax
    77f1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    77f8:	0f 1f 84 00 00 00 00 
    77ff:	00 
    7800:	4a 8b 7c f3 f8       	mov    -0x8(%rbx,%r14,8),%rdi
    7805:	48 89 c6             	mov    %rax,%rsi
    7808:	e8 63 06 00 00       	call   7e70 <fwp_cons>
    780d:	49 ff ce             	dec    %r14
    7810:	75 ee                	jne    7800 <fwp_list_from+0x20>
    7812:	eb 02                	jmp    7816 <fwp_list_from+0x36>
    7814:	31 c0                	xor    %eax,%eax
    7816:	48 83 c4 08          	add    $0x8,%rsp
    781a:	5b                   	pop    %rbx
    781b:	41 5e                	pop    %r14
    781d:	c3                   	ret
    781e:	66 90                	xchg   %ax,%ax

0000000000007820 <fwp_pipe_out_end>:
    7820:	50                   	push   %rax
    7821:	8b 05 19 e6 01 00    	mov    0x1e619(%rip),%eax        # 25e40 <fwp_po_kind>
    7827:	83 f8 02             	cmp    $0x2,%eax
    782a:	74 1c                	je     7848 <fwp_pipe_out_end+0x28>
    782c:	83 f8 01             	cmp    $0x1,%eax
    782f:	75 3d                	jne    786e <fwp_pipe_out_end+0x4e>
    7831:	e8 4a 2b 00 00       	call   a380 <fwp_po_flush_sock>
    7836:	8b 3d 84 e4 00 00    	mov    0xe484(%rip),%edi        # 15cc0 <fwp_po_sock>
    783c:	be 01 00 00 00       	mov    $0x1,%esi
    7841:	e8 1a a9 ff ff       	call   2160 <shutdown@plt>
    7846:	eb 35                	jmp    787d <fwp_pipe_out_end+0x5d>
    7848:	48 8b 35 01 e6 02 00 	mov    0x2e601(%rip),%rsi        # 35e50 <fwp_po_ring>
    784f:	c7 86 40 01 00 00 01 	movl   $0x1,0x140(%rsi)
    7856:	00 00 00 
    7859:	48 8d be c0 00 00 00 	lea    0xc0(%rsi),%rdi
    7860:	48 81 c6 c4 00 00 00 	add    $0xc4,%rsi
    7867:	e8 24 2d 00 00       	call   a590 <fwp_ring_wake>
    786c:	eb 0f                	jmp    787d <fwp_pipe_out_end+0x5d>
    786e:	48 8b 05 43 c7 00 00 	mov    0xc743(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    7875:	48 8b 38             	mov    (%rax),%rdi
    7878:	e8 d3 aa ff ff       	call   2350 <fflush@plt>
    787d:	8b 3d 39 e4 00 00    	mov    0xe439(%rip),%edi        # 15cbc <fwp_po_listen>
    7883:	85 ff                	test   %edi,%edi
    7885:	78 0f                	js     7896 <fwp_pipe_out_end+0x76>
    7887:	e8 a4 a9 ff ff       	call   2230 <close@plt>
    788c:	c7 05 26 e4 00 00 ff 	movl   $0xffffffff,0xe426(%rip)        # 15cbc <fwp_po_listen>
    7893:	ff ff ff 
    7896:	58                   	pop    %rax
    7897:	c3                   	ret
    7898:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    789f:	00 

00000000000078a0 <fwp_valid_utf8>:
    78a0:	48 85 f6             	test   %rsi,%rsi
    78a3:	0f 84 48 01 00 00    	je     79f1 <fwp_valid_utf8+0x151>
    78a9:	53                   	push   %rbx
    78aa:	31 c9                	xor    %ecx,%ecx
    78ac:	eb 0e                	jmp    78bc <fwp_valid_utf8+0x1c>
    78ae:	66 90                	xchg   %ax,%ax
    78b0:	48 ff c1             	inc    %rcx
    78b3:	48 39 f1             	cmp    %rsi,%rcx
    78b6:	0f 83 2e 01 00 00    	jae    79ea <fwp_valid_utf8+0x14a>
    78bc:	44 0f b6 14 0f       	movzbl (%rdi,%rcx,1),%r10d
    78c1:	45 84 d2             	test   %r10b,%r10b
    78c4:	79 ea                	jns    78b0 <fwp_valid_utf8+0x10>
    78c6:	41 8d 42 3e          	lea    0x3e(%r10),%eax
    78ca:	3c 1e                	cmp    $0x1e,%al
    78cc:	73 12                	jae    78e0 <fwp_valid_utf8+0x40>
    78ce:	ba 80 00 00 00       	mov    $0x80,%edx
    78d3:	b8 01 00 00 00       	mov    $0x1,%eax
    78d8:	41 b8 1f 00 00 00    	mov    $0x1f,%r8d
    78de:	eb 37                	jmp    7917 <fwp_valid_utf8+0x77>
    78e0:	44 89 d0             	mov    %r10d,%eax
    78e3:	24 f0                	and    $0xf0,%al
    78e5:	3c e0                	cmp    $0xe0,%al
    78e7:	75 12                	jne    78fb <fwp_valid_utf8+0x5b>
    78e9:	ba 00 08 00 00       	mov    $0x800,%edx
    78ee:	b8 02 00 00 00       	mov    $0x2,%eax
    78f3:	41 b8 0f 00 00 00    	mov    $0xf,%r8d
    78f9:	eb 1c                	jmp    7917 <fwp_valid_utf8+0x77>
    78fb:	41 8d 42 10          	lea    0x10(%r10),%eax
    78ff:	3c 04                	cmp    $0x4,%al
    7901:	0f 87 f0 00 00 00    	ja     79f7 <fwp_valid_utf8+0x157>
    7907:	ba 00 00 01 00       	mov    $0x10000,%edx
    790c:	b8 03 00 00 00       	mov    $0x3,%eax
    7911:	41 b8 07 00 00 00    	mov    $0x7,%r8d
    7917:	41 89 c1             	mov    %eax,%r9d
    791a:	4e 8d 1c 09          	lea    (%rcx,%r9,1),%r11
    791e:	31 c0                	xor    %eax,%eax
    7920:	49 39 f3             	cmp    %rsi,%r11
    7923:	0f 83 c6 00 00 00    	jae    79ef <fwp_valid_utf8+0x14f>
    7929:	44 0f b6 5c 0f 01    	movzbl 0x1(%rdi,%rcx,1),%r11d
    792f:	44 89 db             	mov    %r11d,%ebx
    7932:	83 e3 c0             	and    $0xffffffc0,%ebx
    7935:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
    793b:	0f 85 ae 00 00 00    	jne    79ef <fwp_valid_utf8+0x14f>
    7941:	45 21 d0             	and    %r10d,%r8d
    7944:	45 8d 51 01          	lea    0x1(%r9),%r10d
    7948:	44 89 c3             	mov    %r8d,%ebx
    794b:	c1 e3 06             	shl    $0x6,%ebx
    794e:	41 83 e3 3f          	and    $0x3f,%r11d
    7952:	41 09 db             	or     %ebx,%r11d
    7955:	41 83 fa 02          	cmp    $0x2,%r10d
    7959:	75 0d                	jne    7968 <fwp_valid_utf8+0xc8>
    795b:	45 89 da             	mov    %r11d,%r10d
    795e:	41 39 d2             	cmp    %edx,%r10d
    7961:	73 62                	jae    79c5 <fwp_valid_utf8+0x125>
    7963:	e9 87 00 00 00       	jmp    79ef <fwp_valid_utf8+0x14f>
    7968:	44 0f b6 44 0f 02    	movzbl 0x2(%rdi,%rcx,1),%r8d
    796e:	44 89 c3             	mov    %r8d,%ebx
    7971:	83 e3 c0             	and    $0xffffffc0,%ebx
    7974:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
    797a:	75 73                	jne    79ef <fwp_valid_utf8+0x14f>
    797c:	44 89 db             	mov    %r11d,%ebx
    797f:	c1 e3 06             	shl    $0x6,%ebx
    7982:	41 83 e0 3f          	and    $0x3f,%r8d
    7986:	41 09 d8             	or     %ebx,%r8d
    7989:	41 83 fa 03          	cmp    $0x3,%r10d
    798d:	75 0d                	jne    799c <fwp_valid_utf8+0xfc>
    798f:	45 89 c2             	mov    %r8d,%r10d
    7992:	45 89 d8             	mov    %r11d,%r8d
    7995:	41 39 d2             	cmp    %edx,%r10d
    7998:	73 2b                	jae    79c5 <fwp_valid_utf8+0x125>
    799a:	eb 53                	jmp    79ef <fwp_valid_utf8+0x14f>
    799c:	44 0f b6 54 0f 03    	movzbl 0x3(%rdi,%rcx,1),%r10d
    79a2:	45 89 d3             	mov    %r10d,%r11d
    79a5:	41 83 e3 c0          	and    $0xffffffc0,%r11d
    79a9:	41 81 fb 80 00 00 00 	cmp    $0x80,%r11d
    79b0:	75 3d                	jne    79ef <fwp_valid_utf8+0x14f>
    79b2:	45 89 c3             	mov    %r8d,%r11d
    79b5:	41 c1 e3 06          	shl    $0x6,%r11d
    79b9:	41 83 e2 3f          	and    $0x3f,%r10d
    79bd:	45 09 da             	or     %r11d,%r10d
    79c0:	41 39 d2             	cmp    %edx,%r10d
    79c3:	72 2a                	jb     79ef <fwp_valid_utf8+0x14f>
    79c5:	41 81 fa ff ff 10 00 	cmp    $0x10ffff,%r10d
    79cc:	77 21                	ja     79ef <fwp_valid_utf8+0x14f>
    79ce:	41 83 e0 e0          	and    $0xffffffe0,%r8d
    79d2:	41 81 f8 60 03 00 00 	cmp    $0x360,%r8d
    79d9:	74 14                	je     79ef <fwp_valid_utf8+0x14f>
    79db:	4c 01 c9             	add    %r9,%rcx
    79de:	48 ff c1             	inc    %rcx
    79e1:	48 39 f1             	cmp    %rsi,%rcx
    79e4:	0f 82 d2 fe ff ff    	jb     78bc <fwp_valid_utf8+0x1c>
    79ea:	b8 01 00 00 00       	mov    $0x1,%eax
    79ef:	5b                   	pop    %rbx
    79f0:	c3                   	ret
    79f1:	b8 01 00 00 00       	mov    $0x1,%eax
    79f6:	c3                   	ret
    79f7:	31 c0                	xor    %eax,%eax
    79f9:	5b                   	pop    %rbx
    79fa:	c3                   	ret
    79fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000007a00 <fwp_str_new>:
    7a00:	41 57                	push   %r15
    7a02:	41 56                	push   %r14
    7a04:	53                   	push   %rbx
    7a05:	48 89 f3             	mov    %rsi,%rbx
    7a08:	49 89 fe             	mov    %rdi,%r14
    7a0b:	48 8d 7e 09          	lea    0x9(%rsi),%rdi
    7a0f:	e8 2c ee ff ff       	call   6840 <fwp_alloc_leaf>
    7a14:	49 89 c7             	mov    %rax,%r15
    7a17:	48 89 18             	mov    %rbx,(%rax)
    7a1a:	48 8d 78 08          	lea    0x8(%rax),%rdi
    7a1e:	4c 89 f6             	mov    %r14,%rsi
    7a21:	48 89 da             	mov    %rbx,%rdx
    7a24:	e8 07 a9 ff ff       	call   2330 <memcpy@plt>
    7a29:	41 c6 44 1f 08 00    	movb   $0x0,0x8(%r15,%rbx,1)
    7a2f:	4c 89 f8             	mov    %r15,%rax
    7a32:	5b                   	pop    %rbx
    7a33:	41 5e                	pop    %r14
    7a35:	41 5f                	pop    %r15
    7a37:	c3                   	ret
    7a38:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    7a3f:	00 

0000000000007a40 <buf_putc>:
    7a40:	50                   	push   %rax
    7a41:	40 88 74 24 07       	mov    %sil,0x7(%rsp)
    7a46:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
    7a4b:	ba 01 00 00 00       	mov    $0x1,%edx
    7a50:	e8 3b 00 00 00       	call   7a90 <buf_put>
    7a55:	58                   	pop    %rax
    7a56:	c3                   	ret
    7a57:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    7a5e:	00 00 

0000000000007a60 <buf_puts>:
    7a60:	41 56                	push   %r14
    7a62:	53                   	push   %rbx
    7a63:	50                   	push   %rax
    7a64:	48 89 f3             	mov    %rsi,%rbx
    7a67:	49 89 fe             	mov    %rdi,%r14
    7a6a:	48 89 f7             	mov    %rsi,%rdi
    7a6d:	e8 fe a6 ff ff       	call   2170 <strlen@plt>
    7a72:	4c 89 f7             	mov    %r14,%rdi
    7a75:	48 89 de             	mov    %rbx,%rsi
    7a78:	48 89 c2             	mov    %rax,%rdx
    7a7b:	48 83 c4 08          	add    $0x8,%rsp
    7a7f:	5b                   	pop    %rbx
    7a80:	41 5e                	pop    %r14
    7a82:	eb 0c                	jmp    7a90 <buf_put>
    7a84:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    7a8b:	00 00 00 00 00 

0000000000007a90 <buf_put>:
    7a90:	41 57                	push   %r15
    7a92:	41 56                	push   %r14
    7a94:	53                   	push   %rbx
    7a95:	48 89 d3             	mov    %rdx,%rbx
    7a98:	49 89 f6             	mov    %rsi,%r14
    7a9b:	49 89 ff             	mov    %rdi,%r15
    7a9e:	48 89 d6             	mov    %rdx,%rsi
    7aa1:	e8 6a 00 00 00       	call   7b10 <buf_grow>
    7aa6:	49 8b 3f             	mov    (%r15),%rdi
    7aa9:	49 03 7f 08          	add    0x8(%r15),%rdi
    7aad:	4c 89 f6             	mov    %r14,%rsi
    7ab0:	48 89 da             	mov    %rbx,%rdx
    7ab3:	e8 78 a8 ff ff       	call   2330 <memcpy@plt>
    7ab8:	49 03 5f 08          	add    0x8(%r15),%rbx
    7abc:	49 89 5f 08          	mov    %rbx,0x8(%r15)
    7ac0:	49 8b 07             	mov    (%r15),%rax
    7ac3:	c6 04 18 00          	movb   $0x0,(%rax,%rbx,1)
    7ac7:	5b                   	pop    %rbx
    7ac8:	41 5e                	pop    %r14
    7aca:	41 5f                	pop    %r15
    7acc:	c3                   	ret
    7acd:	0f 1f 00             	nopl   (%rax)

0000000000007ad0 <buf_to_str>:
    7ad0:	41 56                	push   %r14
    7ad2:	53                   	push   %rbx
    7ad3:	50                   	push   %rax
    7ad4:	48 89 fb             	mov    %rdi,%rbx
    7ad7:	48 8b 07             	mov    (%rdi),%rax
    7ada:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    7ade:	48 85 c0             	test   %rax,%rax
    7ae1:	48 8d 3d b8 72 00 00 	lea    0x72b8(%rip),%rdi        # eda0 <exec_in_fp0+0x750>
    7ae8:	48 0f 45 f8          	cmovne %rax,%rdi
    7aec:	e8 0f ff ff ff       	call   7a00 <fwp_str_new>
    7af1:	49 89 c6             	mov    %rax,%r14
    7af4:	48 8b 3b             	mov    (%rbx),%rdi
    7af7:	e8 54 a5 ff ff       	call   2050 <free@plt>
    7afc:	4c 89 f0             	mov    %r14,%rax
    7aff:	48 83 c4 08          	add    $0x8,%rsp
    7b03:	5b                   	pop    %rbx
    7b04:	41 5e                	pop    %r14
    7b06:	c3                   	ret
    7b07:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    7b0e:	00 00 

0000000000007b10 <buf_grow>:
    7b10:	41 56                	push   %r14
    7b12:	53                   	push   %rbx
    7b13:	50                   	push   %rax
    7b14:	48 8b 47 08          	mov    0x8(%rdi),%rax
    7b18:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    7b1c:	74 73                	je     7b91 <buf_grow+0x81>
    7b1e:	48 c7 c1 fe ff ff ff 	mov    $0xfffffffffffffffe,%rcx
    7b25:	48 29 c1             	sub    %rax,%rcx
    7b28:	48 39 f1             	cmp    %rsi,%rcx
    7b2b:	72 64                	jb     7b91 <buf_grow+0x81>
    7b2d:	48 89 fb             	mov    %rdi,%rbx
    7b30:	48 01 f0             	add    %rsi,%rax
    7b33:	48 ff c0             	inc    %rax
    7b36:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    7b3a:	48 39 c8             	cmp    %rcx,%rax
    7b3d:	76 4a                	jbe    7b89 <buf_grow+0x79>
    7b3f:	48 85 c9             	test   %rcx,%rcx
    7b42:	41 be 40 00 00 00    	mov    $0x40,%r14d
    7b48:	4c 0f 45 f1          	cmovne %rcx,%r14
    7b4c:	49 39 c6             	cmp    %rax,%r14
    7b4f:	73 21                	jae    7b72 <buf_grow+0x62>
    7b51:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7b58:	0f 1f 84 00 00 00 00 
    7b5f:	00 
    7b60:	4d 85 f6             	test   %r14,%r14
    7b63:	78 0a                	js     7b6f <buf_grow+0x5f>
    7b65:	4d 01 f6             	add    %r14,%r14
    7b68:	49 39 c6             	cmp    %rax,%r14
    7b6b:	72 f3                	jb     7b60 <buf_grow+0x50>
    7b6d:	eb 03                	jmp    7b72 <buf_grow+0x62>
    7b6f:	49 89 c6             	mov    %rax,%r14
    7b72:	48 8b 3b             	mov    (%rbx),%rdi
    7b75:	4c 89 f6             	mov    %r14,%rsi
    7b78:	e8 03 a8 ff ff       	call   2380 <realloc@plt>
    7b7d:	48 85 c0             	test   %rax,%rax
    7b80:	74 0f                	je     7b91 <buf_grow+0x81>
    7b82:	48 89 03             	mov    %rax,(%rbx)
    7b85:	4c 89 73 10          	mov    %r14,0x10(%rbx)
    7b89:	48 83 c4 08          	add    $0x8,%rsp
    7b8d:	5b                   	pop    %rbx
    7b8e:	41 5e                	pop    %r14
    7b90:	c3                   	ret
    7b91:	48 8b 05 48 c4 00 00 	mov    0xc448(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    7b98:	48 8b 08             	mov    (%rax),%rcx
    7b9b:	48 8d 3d d1 6b 00 00 	lea    0x6bd1(%rip),%rdi        # e773 <exec_in_fp0+0x123>
    7ba2:	be 13 00 00 00       	mov    $0x13,%esi
    7ba7:	ba 01 00 00 00       	mov    $0x1,%edx
    7bac:	e8 ef a8 ff ff       	call   24a0 <fwrite@plt>
    7bb1:	bf 66 00 00 00       	mov    $0x66,%edi
    7bb6:	e8 c5 a8 ff ff       	call   2480 <exit@plt>
    7bbb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000007bc0 <fwp_is_number_arg>:
    7bc0:	31 c0                	xor    %eax,%eax
    7bc2:	80 3f 2d             	cmpb   $0x2d,(%rdi)
    7bc5:	75 19                	jne    7be0 <fwp_is_number_arg+0x20>
    7bc7:	0f b6 4f 01          	movzbl 0x1(%rdi),%ecx
    7bcb:	8d 51 d0             	lea    -0x30(%rcx),%edx
    7bce:	b8 01 00 00 00       	mov    $0x1,%eax
    7bd3:	80 fa 0a             	cmp    $0xa,%dl
    7bd6:	72 08                	jb     7be0 <fwp_is_number_arg+0x20>
    7bd8:	31 c0                	xor    %eax,%eax
    7bda:	80 f9 2e             	cmp    $0x2e,%cl
    7bdd:	0f 94 c0             	sete   %al
    7be0:	c3                   	ret
    7be1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7be8:	0f 1f 84 00 00 00 00 
    7bef:	00 

0000000000007bf0 <fwp_strf>:
    7bf0:	55                   	push   %rbp
    7bf1:	41 57                	push   %r15
    7bf3:	41 56                	push   %r14
    7bf5:	41 55                	push   %r13
    7bf7:	41 54                	push   %r12
    7bf9:	53                   	push   %rbx
    7bfa:	48 81 ec d8 00 00 00 	sub    $0xd8,%rsp
    7c01:	48 89 fb             	mov    %rdi,%rbx
    7c04:	48 89 74 24 28       	mov    %rsi,0x28(%rsp)
    7c09:	48 89 54 24 30       	mov    %rdx,0x30(%rsp)
    7c0e:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
    7c13:	4c 89 44 24 40       	mov    %r8,0x40(%rsp)
    7c18:	4c 89 4c 24 48       	mov    %r9,0x48(%rsp)
    7c1d:	84 c0                	test   %al,%al
    7c1f:	74 37                	je     7c58 <fwp_strf+0x68>
    7c21:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
    7c26:	0f 29 4c 24 60       	movaps %xmm1,0x60(%rsp)
    7c2b:	0f 29 54 24 70       	movaps %xmm2,0x70(%rsp)
    7c30:	0f 29 9c 24 80 00 00 	movaps %xmm3,0x80(%rsp)
    7c37:	00 
    7c38:	0f 29 a4 24 90 00 00 	movaps %xmm4,0x90(%rsp)
    7c3f:	00 
    7c40:	0f 29 ac 24 a0 00 00 	movaps %xmm5,0xa0(%rsp)
    7c47:	00 
    7c48:	0f 29 b4 24 b0 00 00 	movaps %xmm6,0xb0(%rsp)
    7c4f:	00 
    7c50:	0f 29 bc 24 c0 00 00 	movaps %xmm7,0xc0(%rsp)
    7c57:	00 
    7c58:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    7c5d:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    7c62:	48 8d 84 24 10 01 00 	lea    0x110(%rsp),%rax
    7c69:	00 
    7c6a:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    7c6f:	48 bd 08 00 00 00 30 	movabs $0x3000000008,%rbp
    7c76:	00 00 00 
    7c79:	48 89 2c 24          	mov    %rbp,(%rsp)
    7c7d:	49 89 e6             	mov    %rsp,%r14
    7c80:	31 ff                	xor    %edi,%edi
    7c82:	31 f6                	xor    %esi,%esi
    7c84:	48 89 da             	mov    %rbx,%rdx
    7c87:	4c 89 f1             	mov    %r14,%rcx
    7c8a:	e8 81 a4 ff ff       	call   2110 <vsnprintf@plt>
    7c8f:	4c 63 f8             	movslq %eax,%r15
    7c92:	4d 8d 67 01          	lea    0x1(%r15),%r12
    7c96:	4c 89 e7             	mov    %r12,%rdi
    7c99:	e8 a2 eb ff ff       	call   6840 <fwp_alloc_leaf>
    7c9e:	49 89 c5             	mov    %rax,%r13
    7ca1:	48 89 2c 24          	mov    %rbp,(%rsp)
    7ca5:	48 8d 84 24 10 01 00 	lea    0x110(%rsp),%rax
    7cac:	00 
    7cad:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    7cb2:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    7cb7:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    7cbc:	4c 89 ef             	mov    %r13,%rdi
    7cbf:	4c 89 e6             	mov    %r12,%rsi
    7cc2:	48 89 da             	mov    %rbx,%rdx
    7cc5:	4c 89 f1             	mov    %r14,%rcx
    7cc8:	e8 43 a4 ff ff       	call   2110 <vsnprintf@plt>
    7ccd:	4c 89 ef             	mov    %r13,%rdi
    7cd0:	4c 89 fe             	mov    %r15,%rsi
    7cd3:	e8 28 fd ff ff       	call   7a00 <fwp_str_new>
    7cd8:	48 81 c4 d8 00 00 00 	add    $0xd8,%rsp
    7cdf:	5b                   	pop    %rbx
    7ce0:	41 5c                	pop    %r12
    7ce2:	41 5d                	pop    %r13
    7ce4:	41 5e                	pop    %r14
    7ce6:	41 5f                	pop    %r15
    7ce8:	5d                   	pop    %rbp
    7ce9:	c3                   	ret
    7cea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000007cf0 <fwp_cli_value>:
    7cf0:	55                   	push   %rbp
    7cf1:	41 57                	push   %r15
    7cf3:	41 56                	push   %r14
    7cf5:	41 55                	push   %r13
    7cf7:	41 54                	push   %r12
    7cf9:	53                   	push   %rbx
    7cfa:	48 83 ec 58          	sub    $0x58,%rsp
    7cfe:	49 89 cf             	mov    %rcx,%r15
    7d01:	48 89 d3             	mov    %rdx,%rbx
    7d04:	49 89 f6             	mov    %rsi,%r14
    7d07:	49 89 fc             	mov    %rdi,%r12
    7d0a:	e8 91 01 00 00       	call   7ea0 <fwp_is_enum>
    7d0f:	85 c0                	test   %eax,%eax
    7d11:	0f 84 ef 00 00 00    	je     7e06 <fwp_cli_value+0x116>
    7d17:	48 89 5c 24 38       	mov    %rbx,0x38(%rsp)
    7d1c:	0f 57 c0             	xorps  %xmm0,%xmm0
    7d1f:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    7d24:	48 c7 44 24 50 00 00 	movq   $0x0,0x50(%rsp)
    7d2b:	00 00 
    7d2d:	0f 29 04 24          	movaps %xmm0,(%rsp)
    7d31:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    7d38:	00 00 
    7d3a:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
    7d3f:	4c 89 e6             	mov    %r12,%rsi
    7d42:	4c 89 74 24 30       	mov    %r14,0x30(%rsp)
    7d47:	4c 89 f2             	mov    %r14,%rdx
    7d4a:	e8 d1 01 00 00       	call   7f20 <fwp_loose>
    7d4f:	4c 8b 6c 24 40       	mov    0x40(%rsp),%r13
    7d54:	31 db                	xor    %ebx,%ebx
    7d56:	83 3d e3 df 00 00 00 	cmpl   $0x0,0xdfe3(%rip)        # 15d40 <d0+0x10>
    7d5d:	41 be ff ff ff ff    	mov    $0xffffffff,%r14d
    7d63:	7e 7a                	jle    7ddf <fwp_cli_value+0xef>
    7d65:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
    7d6a:	48 85 ed             	test   %rbp,%rbp
    7d6d:	74 70                	je     7ddf <fwp_cli_value+0xef>
    7d6f:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
    7d74:	4c 89 7c 24 28       	mov    %r15,0x28(%rsp)
    7d79:	45 31 ff             	xor    %r15d,%r15d
    7d7c:	48 89 e3             	mov    %rsp,%rbx
    7d7f:	90                   	nop
    7d80:	48 8b 05 c1 df 00 00 	mov    0xdfc1(%rip),%rax        # 15d48 <d0+0x18>
    7d87:	4e 8b 24 f8          	mov    (%rax,%r15,8),%r12
    7d8b:	4c 89 e7             	mov    %r12,%rdi
    7d8e:	e8 dd a3 ff ff       	call   2170 <strlen@plt>
    7d93:	48 89 df             	mov    %rbx,%rdi
    7d96:	4c 89 e6             	mov    %r12,%rsi
    7d99:	48 89 c2             	mov    %rax,%rdx
    7d9c:	e8 7f 01 00 00       	call   7f20 <fwp_loose>
    7da1:	48 39 6c 24 08       	cmp    %rbp,0x8(%rsp)
    7da6:	75 15                	jne    7dbd <fwp_cli_value+0xcd>
    7da8:	48 8b 3c 24          	mov    (%rsp),%rdi
    7dac:	4c 89 ee             	mov    %r13,%rsi
    7daf:	48 89 ea             	mov    %rbp,%rdx
    7db2:	e8 b9 a5 ff ff       	call   2370 <bcmp@plt>
    7db7:	85 c0                	test   %eax,%eax
    7db9:	45 0f 44 f7          	cmove  %r15d,%r14d
    7dbd:	49 ff c7             	inc    %r15
    7dc0:	48 63 05 79 df 00 00 	movslq 0xdf79(%rip),%rax        # 15d40 <d0+0x10>
    7dc7:	49 39 c7             	cmp    %rax,%r15
    7dca:	7d 05                	jge    7dd1 <fwp_cli_value+0xe1>
    7dcc:	45 85 f6             	test   %r14d,%r14d
    7dcf:	78 af                	js     7d80 <fwp_cli_value+0x90>
    7dd1:	48 8b 1c 24          	mov    (%rsp),%rbx
    7dd5:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
    7dda:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
    7ddf:	4c 89 ef             	mov    %r13,%rdi
    7de2:	e8 69 a2 ff ff       	call   2050 <free@plt>
    7de7:	48 89 df             	mov    %rbx,%rdi
    7dea:	e8 61 a2 ff ff       	call   2050 <free@plt>
    7def:	45 85 f6             	test   %r14d,%r14d
    7df2:	78 3e                	js     7e32 <fwp_cli_value+0x142>
    7df4:	44 89 f0             	mov    %r14d,%eax
    7df7:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
    7dfc:	48 89 01             	mov    %rax,(%rcx)
    7dff:	bb 01 00 00 00       	mov    $0x1,%ebx
    7e04:	eb 50                	jmp    7e56 <fwp_cli_value+0x166>
    7e06:	4c 89 e7             	mov    %r12,%rdi
    7e09:	4c 89 f6             	mov    %r14,%rsi
    7e0c:	48 89 da             	mov    %rbx,%rdx
    7e0f:	e8 dc eb ff ff       	call   69f0 <fwp_parse_text>
    7e14:	bb 01 00 00 00       	mov    $0x1,%ebx
    7e19:	85 c0                	test   %eax,%eax
    7e1b:	75 39                	jne    7e56 <fwp_cli_value+0x166>
    7e1d:	48 8d 3d 2b 74 00 00 	lea    0x742b(%rip),%rdi        # f24f <exec_in_fp0+0xbff>
    7e24:	48 8d 0d 74 76 00 00 	lea    0x7674(%rip),%rcx        # f49f <exec_in_fp0+0xe4f>
    7e2b:	31 db                	xor    %ebx,%ebx
    7e2d:	44 89 f6             	mov    %r14d,%esi
    7e30:	eb 17                	jmp    7e49 <fwp_cli_value+0x159>
    7e32:	e8 69 01 00 00       	call   7fa0 <fwp_choices>
    7e37:	48 8d 48 08          	lea    0x8(%rax),%rcx
    7e3b:	48 8d 3d f5 73 00 00 	lea    0x73f5(%rip),%rdi        # f237 <exec_in_fp0+0xbe7>
    7e42:	31 db                	xor    %ebx,%ebx
    7e44:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    7e49:	4c 89 e2             	mov    %r12,%rdx
    7e4c:	31 c0                	xor    %eax,%eax
    7e4e:	e8 9d fd ff ff       	call   7bf0 <fwp_strf>
    7e53:	49 89 07             	mov    %rax,(%r15)
    7e56:	89 d8                	mov    %ebx,%eax
    7e58:	48 83 c4 58          	add    $0x58,%rsp
    7e5c:	5b                   	pop    %rbx
    7e5d:	41 5c                	pop    %r12
    7e5f:	41 5d                	pop    %r13
    7e61:	41 5e                	pop    %r14
    7e63:	41 5f                	pop    %r15
    7e65:	5d                   	pop    %rbp
    7e66:	c3                   	ret
    7e67:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    7e6e:	00 00 

0000000000007e70 <fwp_cons>:
    7e70:	48 83 ec 18          	sub    $0x18,%rsp
    7e74:	48 89 3c 24          	mov    %rdi,(%rsp)
    7e78:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    7e7d:	48 89 e2             	mov    %rsp,%rdx
    7e80:	bf 01 00 00 00       	mov    $0x1,%edi
    7e85:	be 02 00 00 00       	mov    $0x2,%esi
    7e8a:	e8 a1 b2 ff ff       	call   3130 <fwp_data>
    7e8f:	48 83 c4 18          	add    $0x18,%rsp
    7e93:	c3                   	ret
    7e94:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    7e9b:	00 00 00 00 00 

0000000000007ea0 <fwp_is_enum>:
    7ea0:	31 c0                	xor    %eax,%eax
    7ea2:	83 3d 87 de 00 00 0e 	cmpl   $0xe,0xde87(%rip)        # 15d30 <d0>
    7ea9:	75 67                	jne    7f12 <fwp_is_enum+0x72>
    7eab:	53                   	push   %rbx
    7eac:	8b 1d 8e de 00 00    	mov    0xde8e(%rip),%ebx        # 15d40 <d0+0x10>
    7eb2:	85 db                	test   %ebx,%ebx
    7eb4:	74 5b                	je     7f11 <fwp_is_enum+0x71>
    7eb6:	48 8b 3d 7b de 00 00 	mov    0xde7b(%rip),%rdi        # 15d38 <d0+0x8>
    7ebd:	48 85 ff             	test   %rdi,%rdi
    7ec0:	74 14                	je     7ed6 <fwp_is_enum+0x36>
    7ec2:	48 8d 35 a0 73 00 00 	lea    0x73a0(%rip),%rsi        # f269 <exec_in_fp0+0xc19>
    7ec9:	e8 02 a4 ff ff       	call   22d0 <strcmp@plt>
    7ece:	89 c1                	mov    %eax,%ecx
    7ed0:	31 c0                	xor    %eax,%eax
    7ed2:	85 c9                	test   %ecx,%ecx
    7ed4:	74 3b                	je     7f11 <fwp_is_enum+0x71>
    7ed6:	85 db                	test   %ebx,%ebx
    7ed8:	7e 32                	jle    7f0c <fwp_is_enum+0x6c>
    7eda:	48 8b 0d 77 de 00 00 	mov    0xde77(%rip),%rcx        # 15d58 <d0+0x28>
    7ee1:	83 39 00             	cmpl   $0x0,(%rcx)
    7ee4:	75 2b                	jne    7f11 <fwp_is_enum+0x71>
    7ee6:	b8 01 00 00 00       	mov    $0x1,%eax
    7eeb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7ef0:	48 89 c2             	mov    %rax,%rdx
    7ef3:	48 39 c3             	cmp    %rax,%rbx
    7ef6:	74 0a                	je     7f02 <fwp_is_enum+0x62>
    7ef8:	48 8d 42 01          	lea    0x1(%rdx),%rax
    7efc:	83 3c 91 00          	cmpl   $0x0,(%rcx,%rdx,4)
    7f00:	74 ee                	je     7ef0 <fwp_is_enum+0x50>
    7f02:	31 c0                	xor    %eax,%eax
    7f04:	48 39 da             	cmp    %rbx,%rdx
    7f07:	0f 93 c0             	setae  %al
    7f0a:	eb 05                	jmp    7f11 <fwp_is_enum+0x71>
    7f0c:	b8 01 00 00 00       	mov    $0x1,%eax
    7f11:	5b                   	pop    %rbx
    7f12:	c3                   	ret
    7f13:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7f1a:	84 00 00 00 00 00 

0000000000007f20 <fwp_loose>:
    7f20:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
    7f27:	00 
    7f28:	48 85 d2             	test   %rdx,%rdx
    7f2b:	74 63                	je     7f90 <fwp_loose+0x70>
    7f2d:	41 57                	push   %r15
    7f2f:	41 56                	push   %r14
    7f31:	41 54                	push   %r12
    7f33:	53                   	push   %rbx
    7f34:	50                   	push   %rax
    7f35:	48 89 d3             	mov    %rdx,%rbx
    7f38:	49 89 f6             	mov    %rsi,%r14
    7f3b:	49 89 ff             	mov    %rdi,%r15
    7f3e:	45 31 e4             	xor    %r12d,%r12d
    7f41:	eb 15                	jmp    7f58 <fwp_loose+0x38>
    7f43:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7f4a:	84 00 00 00 00 00 
    7f50:	49 ff c4             	inc    %r12
    7f53:	4c 39 e3             	cmp    %r12,%rbx
    7f56:	74 2d                	je     7f85 <fwp_loose+0x65>
    7f58:	43 0f b6 04 26       	movzbl (%r14,%r12,1),%eax
    7f5d:	83 f8 2d             	cmp    $0x2d,%eax
    7f60:	74 ee                	je     7f50 <fwp_loose+0x30>
    7f62:	83 f8 5f             	cmp    $0x5f,%eax
    7f65:	74 e9                	je     7f50 <fwp_loose+0x30>
    7f67:	8d 48 bf             	lea    -0x41(%rax),%ecx
    7f6a:	0f b6 d0             	movzbl %al,%edx
    7f6d:	0c 20                	or     $0x20,%al
    7f6f:	80 f9 1a             	cmp    $0x1a,%cl
    7f72:	0f b6 c0             	movzbl %al,%eax
    7f75:	0f 43 c2             	cmovae %edx,%eax
    7f78:	0f be f0             	movsbl %al,%esi
    7f7b:	4c 89 ff             	mov    %r15,%rdi
    7f7e:	e8 bd fa ff ff       	call   7a40 <buf_putc>
    7f83:	eb cb                	jmp    7f50 <fwp_loose+0x30>
    7f85:	48 83 c4 08          	add    $0x8,%rsp
    7f89:	5b                   	pop    %rbx
    7f8a:	41 5c                	pop    %r12
    7f8c:	41 5e                	pop    %r14
    7f8e:	41 5f                	pop    %r15
    7f90:	c3                   	ret
    7f91:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7f98:	0f 1f 84 00 00 00 00 
    7f9f:	00 

0000000000007fa0 <fwp_choices>:
    7fa0:	41 57                	push   %r15
    7fa2:	41 56                	push   %r14
    7fa4:	53                   	push   %rbx
    7fa5:	48 83 ec 20          	sub    $0x20,%rsp
    7fa9:	0f 57 c0             	xorps  %xmm0,%xmm0
    7fac:	0f 29 04 24          	movaps %xmm0,(%rsp)
    7fb0:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    7fb7:	00 00 
    7fb9:	83 3d 80 dd 00 00 00 	cmpl   $0x0,0xdd80(%rip)        # 15d40 <d0+0x10>
    7fc0:	7e 5b                	jle    801d <fwp_choices+0x7d>
    7fc2:	48 8b 05 7f dd 00 00 	mov    0xdd7f(%rip),%rax        # 15d48 <d0+0x18>
    7fc9:	48 8b 30             	mov    (%rax),%rsi
    7fcc:	48 89 e7             	mov    %rsp,%rdi
    7fcf:	e8 5c 00 00 00       	call   8030 <fwp_kebab>
    7fd4:	83 3d 65 dd 00 00 02 	cmpl   $0x2,0xdd65(%rip)        # 15d40 <d0+0x10>
    7fdb:	7c 40                	jl     801d <fwp_choices+0x7d>
    7fdd:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    7fe3:	48 8d 1d 84 72 00 00 	lea    0x7284(%rip),%rbx        # f26e <exec_in_fp0+0xc1e>
    7fea:	49 89 e6             	mov    %rsp,%r14
    7fed:	0f 1f 00             	nopl   (%rax)
    7ff0:	4c 89 f7             	mov    %r14,%rdi
    7ff3:	48 89 de             	mov    %rbx,%rsi
    7ff6:	e8 65 fa ff ff       	call   7a60 <buf_puts>
    7ffb:	48 8b 05 46 dd 00 00 	mov    0xdd46(%rip),%rax        # 15d48 <d0+0x18>
    8002:	4a 8b 34 f8          	mov    (%rax,%r15,8),%rsi
    8006:	4c 89 f7             	mov    %r14,%rdi
    8009:	e8 22 00 00 00       	call   8030 <fwp_kebab>
    800e:	49 ff c7             	inc    %r15
    8011:	48 63 05 28 dd 00 00 	movslq 0xdd28(%rip),%rax        # 15d40 <d0+0x10>
    8018:	49 39 c7             	cmp    %rax,%r15
    801b:	7c d3                	jl     7ff0 <fwp_choices+0x50>
    801d:	48 89 e7             	mov    %rsp,%rdi
    8020:	e8 ab fa ff ff       	call   7ad0 <buf_to_str>
    8025:	48 83 c4 20          	add    $0x20,%rsp
    8029:	5b                   	pop    %rbx
    802a:	41 5e                	pop    %r14
    802c:	41 5f                	pop    %r15
    802e:	c3                   	ret
    802f:	90                   	nop

0000000000008030 <fwp_kebab>:
    8030:	41 57                	push   %r15
    8032:	41 56                	push   %r14
    8034:	53                   	push   %rbx
    8035:	44 0f b6 3e          	movzbl (%rsi),%r15d
    8039:	45 84 ff             	test   %r15b,%r15b
    803c:	74 71                	je     80af <fwp_kebab+0x7f>
    803e:	48 89 f3             	mov    %rsi,%rbx
    8041:	49 89 fe             	mov    %rdi,%r14
    8044:	48 ff c3             	inc    %rbx
    8047:	31 c0                	xor    %eax,%eax
    8049:	eb 36                	jmp    8081 <fwp_kebab+0x51>
    804b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8050:	41 0f be f7          	movsbl %r15b,%esi
    8054:	4c 89 f7             	mov    %r14,%rdi
    8057:	e8 e4 f9 ff ff       	call   7a40 <buf_putc>
    805c:	41 8d 47 9f          	lea    -0x61(%r15),%eax
    8060:	3c 1a                	cmp    $0x1a,%al
    8062:	0f 92 c0             	setb   %al
    8065:	41 80 c7 d0          	add    $0xd0,%r15b
    8069:	41 80 ff 0a          	cmp    $0xa,%r15b
    806d:	0f 92 c1             	setb   %cl
    8070:	08 c1                	or     %al,%cl
    8072:	0f b6 c1             	movzbl %cl,%eax
    8075:	44 0f b6 3b          	movzbl (%rbx),%r15d
    8079:	48 ff c3             	inc    %rbx
    807c:	45 84 ff             	test   %r15b,%r15b
    807f:	74 2e                	je     80af <fwp_kebab+0x7f>
    8081:	41 8d 4f bf          	lea    -0x41(%r15),%ecx
    8085:	80 f9 19             	cmp    $0x19,%cl
    8088:	77 c6                	ja     8050 <fwp_kebab+0x20>
    808a:	85 c0                	test   %eax,%eax
    808c:	74 0d                	je     809b <fwp_kebab+0x6b>
    808e:	4c 89 f7             	mov    %r14,%rdi
    8091:	be 2d 00 00 00       	mov    $0x2d,%esi
    8096:	e8 a5 f9 ff ff       	call   7a40 <buf_putc>
    809b:	41 80 cf 20          	or     $0x20,%r15b
    809f:	41 0f be f7          	movsbl %r15b,%esi
    80a3:	4c 89 f7             	mov    %r14,%rdi
    80a6:	e8 95 f9 ff ff       	call   7a40 <buf_putc>
    80ab:	31 c0                	xor    %eax,%eax
    80ad:	eb c6                	jmp    8075 <fwp_kebab+0x45>
    80af:	5b                   	pop    %rbx
    80b0:	41 5e                	pop    %r14
    80b2:	41 5f                	pop    %r15
    80b4:	c3                   	ret
    80b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    80bc:	00 00 00 00 

00000000000080c0 <tp_value>:
    80c0:	55                   	push   %rbp
    80c1:	41 57                	push   %r15
    80c3:	41 56                	push   %r14
    80c5:	41 55                	push   %r13
    80c7:	41 54                	push   %r12
    80c9:	53                   	push   %rbx
    80ca:	48 81 ec a8 01 00 00 	sub    $0x1a8,%rsp
    80d1:	48 89 cd             	mov    %rcx,%rbp
    80d4:	49 89 f6             	mov    %rsi,%r14
    80d7:	49 89 ff             	mov    %rdi,%r15
    80da:	85 d2                	test   %edx,%edx
    80dc:	74 4c                	je     812a <tp_value+0x6a>
    80de:	41 83 3e 0c          	cmpl   $0xc,(%r14)
    80e2:	75 46                	jne    812a <tp_value+0x6a>
    80e4:	4d 8b 77 08          	mov    0x8(%r15),%r14
    80e8:	49 8b 47 10          	mov    0x10(%r15),%rax
    80ec:	4d 8b 27             	mov    (%r15),%r12
    80ef:	49 01 c4             	add    %rax,%r12
    80f2:	49 29 c6             	sub    %rax,%r14
    80f5:	4c 89 e7             	mov    %r12,%rdi
    80f8:	4c 89 f6             	mov    %r14,%rsi
    80fb:	e8 a0 f7 ff ff       	call   78a0 <fwp_valid_utf8>
    8100:	85 c0                	test   %eax,%eax
    8102:	0f 84 e9 07 00 00    	je     88f1 <tp_value+0x831>
    8108:	4c 89 e7             	mov    %r12,%rdi
    810b:	4c 89 f6             	mov    %r14,%rsi
    810e:	e8 ed f8 ff ff       	call   7a00 <fwp_str_new>
    8113:	48 89 45 00          	mov    %rax,0x0(%rbp)
    8117:	49 8b 47 08          	mov    0x8(%r15),%rax
    811b:	49 89 47 10          	mov    %rax,0x10(%r15)
    811f:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    8125:	e9 ca 07 00 00       	jmp    88f4 <tp_value+0x834>
    812a:	41 89 d5             	mov    %edx,%r13d
    812d:	4c 89 ff             	mov    %r15,%rdi
    8130:	e8 bb 08 00 00       	call   89f0 <tp_ws>
    8135:	41 8b 06             	mov    (%r14),%eax
    8138:	45 31 e4             	xor    %r12d,%r12d
    813b:	48 83 f8 15          	cmp    $0x15,%rax
    813f:	0f 87 af 07 00 00    	ja     88f4 <tp_value+0x834>
    8145:	48 8d 0d 8c 60 00 00 	lea    0x608c(%rip),%rcx        # e1d8 <_IO_stdin_used+0x1d8>
    814c:	48 63 14 81          	movslq (%rcx,%rax,4),%rdx
    8150:	48 01 ca             	add    %rcx,%rdx
    8153:	ff e2                	jmp    *%rdx
    8155:	4c 89 ff             	mov    %r15,%rdi
    8158:	4c 89 f6             	mov    %r14,%rsi
    815b:	48 89 ea             	mov    %rbp,%rdx
    815e:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    8165:	5b                   	pop    %rbx
    8166:	41 5c                	pop    %r12
    8168:	41 5d                	pop    %r13
    816a:	41 5e                	pop    %r14
    816c:	41 5f                	pop    %r15
    816e:	5d                   	pop    %rbp
    816f:	e9 cc 08 00 00       	jmp    8a40 <tp_int>
    8174:	41 0f 10 46 38       	movups 0x38(%r14),%xmm0
    8179:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    817e:	31 c9                	xor    %ecx,%ecx
    8180:	83 f8 13             	cmp    $0x13,%eax
    8183:	0f 94 c1             	sete   %cl
    8186:	0f 57 c0             	xorps  %xmm0,%xmm0
    8189:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    818e:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    8195:	00 00 
    8197:	89 4c 24 48          	mov    %ecx,0x48(%rsp)
    819b:	48 8d 05 e1 70 00 00 	lea    0x70e1(%rip),%rax        # f283 <exec_in_fp0+0xc33>
    81a2:	48 8d 35 de 70 00 00 	lea    0x70de(%rip),%rsi        # f287 <exec_in_fp0+0xc37>
    81a9:	48 0f 44 f0          	cmove  %rax,%rsi
    81ad:	4c 89 ff             	mov    %r15,%rdi
    81b0:	e8 fb 0b 00 00       	call   8db0 <tp_eat>
    81b5:	45 31 e4             	xor    %r12d,%r12d
    81b8:	85 c0                	test   %eax,%eax
    81ba:	0f 84 34 07 00 00    	je     88f4 <tp_value+0x834>
    81c0:	48 8d 35 96 71 00 00 	lea    0x7196(%rip),%rsi        # f35d <exec_in_fp0+0xd0d>
    81c7:	48 8d 15 c3 71 00 00 	lea    0x71c3(%rip),%rdx        # f391 <exec_in_fp0+0xd41>
    81ce:	48 8d 0d 7b 0e 00 00 	lea    0xe7b(%rip),%rcx        # 9050 <tp_kv_item>
    81d5:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
    81da:	4c 89 ff             	mov    %r15,%rdi
    81dd:	e8 2e 0c 00 00       	call   8e10 <tp_list_of>
    81e2:	85 c0                	test   %eax,%eax
    81e4:	0f 84 a1 03 00 00    	je     858b <tp_value+0x4cb>
    81ea:	48 83 7c 24 38 00    	cmpq   $0x0,0x38(%rsp)
    81f0:	0f 84 2b 05 00 00    	je     8721 <tp_value+0x661>
    81f6:	48 8d 05 33 dc 01 00 	lea    0x1dc33(%rip),%rax        # 25e30 <fwp_empty_map>
    81fd:	31 db                	xor    %ebx,%ebx
    81ff:	90                   	nop
    8200:	48 8b 4c 24 30       	mov    0x30(%rsp),%rcx
    8205:	48 8b 3c d9          	mov    (%rcx,%rbx,8),%rdi
    8209:	48 8b 74 d9 08       	mov    0x8(%rcx,%rbx,8),%rsi
    820e:	49 8b 4e 38          	mov    0x38(%r14),%rcx
    8212:	48 89 c2             	mov    %rax,%rdx
    8215:	e8 d6 0e 00 00       	call   90f0 <fwp_p_map_insert>
    821a:	48 83 c3 02          	add    $0x2,%rbx
    821e:	48 3b 5c 24 38       	cmp    0x38(%rsp),%rbx
    8223:	72 db                	jb     8200 <tp_value+0x140>
    8225:	e9 fe 04 00 00       	jmp    8728 <tp_value+0x668>
    822a:	0f 57 c0             	xorps  %xmm0,%xmm0
    822d:	0f 11 44 24 38       	movups %xmm0,0x38(%rsp)
    8232:	0f 11 44 24 28       	movups %xmm0,0x28(%rsp)
    8237:	48 c7 44 24 48 00 00 	movq   $0x0,0x48(%rsp)
    823e:	00 00 
    8240:	49 8b 4e 38          	mov    0x38(%r14),%rcx
    8244:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
    8249:	83 f8 11             	cmp    $0x11,%eax
    824c:	75 17                	jne    8265 <tp_value+0x1a5>
    824e:	48 8d 35 28 70 00 00 	lea    0x7028(%rip),%rsi        # f27d <exec_in_fp0+0xc2d>
    8255:	4c 89 ff             	mov    %r15,%rdi
    8258:	e8 53 0b 00 00       	call   8db0 <tp_eat>
    825d:	85 c0                	test   %eax,%eax
    825f:	0f 84 8c 06 00 00    	je     88f1 <tp_value+0x831>
    8265:	48 8d 35 dd 70 00 00 	lea    0x70dd(%rip),%rsi        # f349 <exec_in_fp0+0xcf9>
    826c:	48 8d 15 59 64 00 00 	lea    0x6459(%rip),%rdx        # e6cc <exec_in_fp0+0x7c>
    8273:	48 8d 0d e6 0c 00 00 	lea    0xce6(%rip),%rcx        # 8f60 <tp_elem_item>
    827a:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
    827f:	4c 89 ff             	mov    %r15,%rdi
    8282:	e8 89 0b 00 00       	call   8e10 <tp_list_of>
    8287:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    828c:	85 c0                	test   %eax,%eax
    828e:	0f 84 06 03 00 00    	je     859a <tp_value+0x4da>
    8294:	48 8b 74 24 38       	mov    0x38(%rsp),%rsi
    8299:	e8 42 f5 ff ff       	call   77e0 <fwp_list_from>
    829e:	49 89 c7             	mov    %rax,%r15
    82a1:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    82a6:	e8 75 d5 ff ff       	call   5820 <fwp_mem_free>
    82ab:	41 83 3e 11          	cmpl   $0x11,(%r14)
    82af:	75 0b                	jne    82bc <tp_value+0x1fc>
    82b1:	4c 89 ff             	mov    %r15,%rdi
    82b4:	e8 e7 0c 00 00       	call   8fa0 <fwp_p_array_from_list>
    82b9:	49 89 c7             	mov    %rax,%r15
    82bc:	4c 89 7d 00          	mov    %r15,0x0(%rbp)
    82c0:	e9 5a fe ff ff       	jmp    811f <tp_value+0x5f>
    82c5:	4c 89 ff             	mov    %r15,%rdi
    82c8:	4c 89 f6             	mov    %r14,%rsi
    82cb:	48 89 ea             	mov    %rbp,%rdx
    82ce:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    82d5:	5b                   	pop    %rbx
    82d6:	41 5c                	pop    %r12
    82d8:	41 5d                	pop    %r13
    82da:	41 5e                	pop    %r14
    82dc:	41 5f                	pop    %r15
    82de:	5d                   	pop    %rbp
    82df:	e9 bc 07 00 00       	jmp    8aa0 <tp_float>
    82e4:	45 85 ed             	test   %r13d,%r13d
    82e7:	0f 85 f7 fd ff ff    	jne    80e4 <tp_value+0x24>
    82ed:	4c 89 ff             	mov    %r15,%rdi
    82f0:	48 89 ee             	mov    %rbp,%rsi
    82f3:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    82fa:	5b                   	pop    %rbx
    82fb:	41 5c                	pop    %r12
    82fd:	41 5d                	pop    %r13
    82ff:	41 5e                	pop    %r14
    8301:	41 5f                	pop    %r15
    8303:	5d                   	pop    %rbp
    8304:	e9 57 08 00 00       	jmp    8b60 <tp_quoted>
    8309:	0f 57 c0             	xorps  %xmm0,%xmm0
    830c:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    8311:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    8316:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    831b:	48 8d 35 4f 6f 00 00 	lea    0x6f4f(%rip),%rsi        # f271 <exec_in_fp0+0xc21>
    8322:	4c 89 ff             	mov    %r15,%rdi
    8325:	e8 86 0a 00 00       	call   8db0 <tp_eat>
    832a:	45 31 e4             	xor    %r12d,%r12d
    832d:	85 c0                	test   %eax,%eax
    832f:	0f 84 6f 02 00 00    	je     85a4 <tp_value+0x4e4>
    8335:	48 8d 35 0d 70 00 00 	lea    0x700d(%rip),%rsi        # f349 <exec_in_fp0+0xcf9>
    833c:	48 8d 15 89 63 00 00 	lea    0x6389(%rip),%rdx        # e6cc <exec_in_fp0+0x7c>
    8343:	48 8d 0d 46 0b 00 00 	lea    0xb46(%rip),%rcx        # 8e90 <tp_byte_item>
    834a:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
    834f:	4c 89 ff             	mov    %r15,%rdi
    8352:	e8 b9 0a 00 00       	call   8e10 <tp_list_of>
    8357:	85 c0                	test   %eax,%eax
    8359:	0f 84 2c 02 00 00    	je     858b <tp_value+0x4cb>
    835f:	0f 57 c0             	xorps  %xmm0,%xmm0
    8362:	0f 29 84 24 20 01 00 	movaps %xmm0,0x120(%rsp)
    8369:	00 
    836a:	48 c7 84 24 30 01 00 	movq   $0x0,0x130(%rsp)
    8371:	00 00 00 00 00 
    8376:	48 83 7c 24 38 00    	cmpq   $0x0,0x38(%rsp)
    837c:	74 2d                	je     83ab <tp_value+0x2eb>
    837e:	31 db                	xor    %ebx,%ebx
    8380:	4c 8d b4 24 20 01 00 	lea    0x120(%rsp),%r14
    8387:	00 
    8388:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    838f:	00 
    8390:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    8395:	0f be 34 d8          	movsbl (%rax,%rbx,8),%esi
    8399:	4c 89 f7             	mov    %r14,%rdi
    839c:	e8 9f f6 ff ff       	call   7a40 <buf_putc>
    83a1:	48 ff c3             	inc    %rbx
    83a4:	48 3b 5c 24 38       	cmp    0x38(%rsp),%rbx
    83a9:	72 e5                	jb     8390 <tp_value+0x2d0>
    83ab:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    83b0:	e8 6b d4 ff ff       	call   5820 <fwp_mem_free>
    83b5:	48 8d bc 24 20 01 00 	lea    0x120(%rsp),%rdi
    83bc:	00 
    83bd:	e8 0e f7 ff ff       	call   7ad0 <buf_to_str>
    83c2:	48 89 45 00          	mov    %rax,0x0(%rbp)
    83c6:	e9 54 fd ff ff       	jmp    811f <tp_value+0x5f>
    83cb:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    83d0:	ba 00 01 00 00       	mov    $0x100,%edx
    83d5:	4c 89 ff             	mov    %r15,%rdi
    83d8:	e8 f3 0a 00 00       	call   8ed0 <tp_token>
    83dd:	45 31 e4             	xor    %r12d,%r12d
    83e0:	48 83 f8 02          	cmp    $0x2,%rax
    83e4:	0f 82 0a 05 00 00    	jb     88f4 <tp_value+0x834>
    83ea:	80 7c 24 20 30       	cmpb   $0x30,0x20(%rsp)
    83ef:	0f 85 ff 04 00 00    	jne    88f4 <tp_value+0x834>
    83f5:	80 7c 24 21 74       	cmpb   $0x74,0x21(%rsp)
    83fa:	0f 85 f4 04 00 00    	jne    88f4 <tp_value+0x834>
    8400:	48 8d 48 fe          	lea    -0x2(%rax),%rcx
    8404:	49 63 56 48          	movslq 0x48(%r14),%rdx
    8408:	48 39 d1             	cmp    %rdx,%rcx
    840b:	0f 87 e3 04 00 00    	ja     88f4 <tp_value+0x834>
    8411:	48 83 f8 03          	cmp    $0x3,%rax
    8415:	0f 82 21 05 00 00    	jb     893c <tp_value+0x87c>
    841b:	ba 02 00 00 00       	mov    $0x2,%edx
    8420:	31 c9                	xor    %ecx,%ecx
    8422:	e9 3d 01 00 00       	jmp    8564 <tp_value+0x4a4>
    8427:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    842c:	ba 10 00 00 00       	mov    $0x10,%edx
    8431:	4c 89 ff             	mov    %r15,%rdi
    8434:	e8 97 0a 00 00       	call   8ed0 <tp_token>
    8439:	8b 44 24 20          	mov    0x20(%rsp),%eax
    843d:	89 c1                	mov    %eax,%ecx
    843f:	81 f1 2b 31 00 00    	xor    $0x312b,%ecx
    8445:	0f b6 54 24 22       	movzbl 0x22(%rsp),%edx
    844a:	66 09 ca             	or     %cx,%dx
    844d:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    8453:	74 2d                	je     8482 <tp_value+0x3c2>
    8455:	66 83 f8 31          	cmp    $0x31,%ax
    8459:	74 27                	je     8482 <tp_value+0x3c2>
    845b:	45 31 e4             	xor    %r12d,%r12d
    845e:	66 83 f8 30          	cmp    $0x30,%ax
    8462:	74 1e                	je     8482 <tp_value+0x3c2>
    8464:	b8 2d 31 00 00       	mov    $0x312d,%eax
    8469:	33 44 24 20          	xor    0x20(%rsp),%eax
    846d:	0f b6 4c 24 22       	movzbl 0x22(%rsp),%ecx
    8472:	66 09 c1             	or     %ax,%cx
    8475:	0f 85 79 04 00 00    	jne    88f4 <tp_value+0x834>
    847b:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    8482:	4c 89 65 00          	mov    %r12,0x0(%rbp)
    8486:	e9 94 fc ff ff       	jmp    811f <tp_value+0x5f>
    848b:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    848f:	48 85 ff             	test   %rdi,%rdi
    8492:	0f 84 18 01 00 00    	je     85b0 <tp_value+0x4f0>
    8498:	48 8d 35 ec 6d 00 00 	lea    0x6dec(%rip),%rsi        # f28b <exec_in_fp0+0xc3b>
    849f:	e8 2c 9e ff ff       	call   22d0 <strcmp@plt>
    84a4:	85 c0                	test   %eax,%eax
    84a6:	0f 84 23 03 00 00    	je     87cf <tp_value+0x70f>
    84ac:	4c 89 ff             	mov    %r15,%rdi
    84af:	e8 3c 05 00 00       	call   89f0 <tp_ws>
    84b4:	4d 8b 6e 08          	mov    0x8(%r14),%r13
    84b8:	4c 89 ef             	mov    %r13,%rdi
    84bb:	e8 b0 9c ff ff       	call   2170 <strlen@plt>
    84c0:	49 89 c4             	mov    %rax,%r12
    84c3:	49 8b 47 08          	mov    0x8(%r15),%rax
    84c7:	49 8b 5f 10          	mov    0x10(%r15),%rbx
    84cb:	48 29 d8             	sub    %rbx,%rax
    84ce:	4c 39 e0             	cmp    %r12,%rax
    84d1:	0f 82 c4 01 00 00    	jb     869b <tp_value+0x5db>
    84d7:	49 8b 3f             	mov    (%r15),%rdi
    84da:	48 01 df             	add    %rbx,%rdi
    84dd:	4c 89 ee             	mov    %r13,%rsi
    84e0:	4c 89 e2             	mov    %r12,%rdx
    84e3:	e8 88 9e ff ff       	call   2370 <bcmp@plt>
    84e8:	85 c0                	test   %eax,%eax
    84ea:	0f 85 ab 01 00 00    	jne    869b <tp_value+0x5db>
    84f0:	4c 01 e3             	add    %r12,%rbx
    84f3:	49 89 5f 10          	mov    %rbx,0x10(%r15)
    84f7:	e9 9f 01 00 00       	jmp    869b <tp_value+0x5db>
    84fc:	48 89 2c 24          	mov    %rbp,(%rsp)
    8500:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8505:	4c 89 ff             	mov    %r15,%rdi
    8508:	e8 d3 0e 00 00       	call   93e0 <tp_ident>
    850d:	41 8b 5e 10          	mov    0x10(%r14),%ebx
    8511:	85 db                	test   %ebx,%ebx
    8513:	4c 89 74 24 08       	mov    %r14,0x8(%rsp)
    8518:	0f 8e 9c 01 00 00    	jle    86ba <tp_value+0x5fa>
    851e:	4d 8b 66 18          	mov    0x18(%r14),%r12
    8522:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    8527:	45 31 f6             	xor    %r14d,%r14d
    852a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8530:	4b 8b 3c f4          	mov    (%r12,%r14,8),%rdi
    8534:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8539:	e8 92 9d ff ff       	call   22d0 <strcmp@plt>
    853e:	85 c0                	test   %eax,%eax
    8540:	41 0f 44 ee          	cmove  %r14d,%ebp
    8544:	49 ff c6             	inc    %r14
    8547:	4c 39 f3             	cmp    %r14,%rbx
    854a:	75 e4                	jne    8530 <tp_value+0x470>
    854c:	e9 6e 01 00 00       	jmp    86bf <tp_value+0x5ff>
    8551:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    8555:	48 ff c9             	dec    %rcx
    8558:	48 ff c2             	inc    %rdx
    855b:	48 39 d0             	cmp    %rdx,%rax
    855e:	0f 84 da 03 00 00    	je     893e <tp_value+0x87e>
    8564:	0f b6 74 14 20       	movzbl 0x20(%rsp,%rdx,1),%esi
    8569:	83 fe 30             	cmp    $0x30,%esi
    856c:	74 17                	je     8585 <tp_value+0x4c5>
    856e:	83 fe 2d             	cmp    $0x2d,%esi
    8571:	74 de                	je     8551 <tp_value+0x491>
    8573:	83 fe 2b             	cmp    $0x2b,%esi
    8576:	0f 85 75 03 00 00    	jne    88f1 <tp_value+0x831>
    857c:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    8580:	48 ff c1             	inc    %rcx
    8583:	eb d3                	jmp    8558 <tp_value+0x498>
    8585:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    8589:	eb cd                	jmp    8558 <tp_value+0x498>
    858b:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    8590:	e8 8b d2 ff ff       	call   5820 <fwp_mem_free>
    8595:	e9 5a 03 00 00       	jmp    88f4 <tp_value+0x834>
    859a:	e8 81 d2 ff ff       	call   5820 <fwp_mem_free>
    859f:	e9 4d 03 00 00       	jmp    88f1 <tp_value+0x831>
    85a4:	31 ff                	xor    %edi,%edi
    85a6:	e8 75 d2 ff ff       	call   5820 <fwp_mem_free>
    85ab:	e9 44 03 00 00       	jmp    88f4 <tp_value+0x834>
    85b0:	49 63 7e 10          	movslq 0x10(%r14),%rdi
    85b4:	48 85 ff             	test   %rdi,%rdi
    85b7:	0f 84 4c 03 00 00    	je     8909 <tp_value+0x849>
    85bd:	41 83 7e 48 00       	cmpl   $0x0,0x48(%r14)
    85c2:	0f 84 d3 00 00 00    	je     869b <tp_value+0x5db>
    85c8:	48 c1 e7 03          	shl    $0x3,%rdi
    85cc:	e8 5f d1 ff ff       	call   5730 <fwp_alloc>
    85d1:	48 89 c3             	mov    %rax,%rbx
    85d4:	48 8d 35 c0 6c 00 00 	lea    0x6cc0(%rip),%rsi        # f29b <exec_in_fp0+0xc4b>
    85db:	4c 89 ff             	mov    %r15,%rdi
    85de:	e8 cd 07 00 00       	call   8db0 <tp_eat>
    85e3:	85 c0                	test   %eax,%eax
    85e5:	0f 84 09 03 00 00    	je     88f4 <tp_value+0x834>
    85eb:	48 89 2c 24          	mov    %rbp,(%rsp)
    85ef:	41 83 7e 10 00       	cmpl   $0x0,0x10(%r14)
    85f4:	7e 77                	jle    866d <tp_value+0x5ad>
    85f6:	49 8b 46 20          	mov    0x20(%r14),%rax
    85fa:	48 8b 30             	mov    (%rax),%rsi
    85fd:	4c 89 ff             	mov    %r15,%rdi
    8600:	31 d2                	xor    %edx,%edx
    8602:	48 89 d9             	mov    %rbx,%rcx
    8605:	e8 b6 fa ff ff       	call   80c0 <tp_value>
    860a:	85 c0                	test   %eax,%eax
    860c:	0f 84 df 02 00 00    	je     88f1 <tp_value+0x831>
    8612:	41 83 7e 10 02       	cmpl   $0x2,0x10(%r14)
    8617:	7c 54                	jl     866d <tp_value+0x5ad>
    8619:	48 89 dd             	mov    %rbx,%rbp
    861c:	48 83 c5 08          	add    $0x8,%rbp
    8620:	41 bd 01 00 00 00    	mov    $0x1,%r13d
    8626:	4c 89 ff             	mov    %r15,%rdi
    8629:	48 8d 35 6d 6c 00 00 	lea    0x6c6d(%rip),%rsi        # f29d <exec_in_fp0+0xc4d>
    8630:	e8 7b 07 00 00       	call   8db0 <tp_eat>
    8635:	85 c0                	test   %eax,%eax
    8637:	0f 84 b4 02 00 00    	je     88f1 <tp_value+0x831>
    863d:	49 8b 46 20          	mov    0x20(%r14),%rax
    8641:	4a 8b 34 e8          	mov    (%rax,%r13,8),%rsi
    8645:	45 31 e4             	xor    %r12d,%r12d
    8648:	4c 89 ff             	mov    %r15,%rdi
    864b:	31 d2                	xor    %edx,%edx
    864d:	48 89 e9             	mov    %rbp,%rcx
    8650:	e8 6b fa ff ff       	call   80c0 <tp_value>
    8655:	85 c0                	test   %eax,%eax
    8657:	0f 84 97 02 00 00    	je     88f4 <tp_value+0x834>
    865d:	49 ff c5             	inc    %r13
    8660:	49 63 46 10          	movslq 0x10(%r14),%rax
    8664:	48 83 c5 08          	add    $0x8,%rbp
    8668:	49 39 c5             	cmp    %rax,%r13
    866b:	7c b9                	jl     8626 <tp_value+0x566>
    866d:	48 8d 35 ec 6c 00 00 	lea    0x6cec(%rip),%rsi        # f360 <exec_in_fp0+0xd10>
    8674:	4c 89 ff             	mov    %r15,%rdi
    8677:	e8 34 07 00 00       	call   8db0 <tp_eat>
    867c:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    8682:	85 c0                	test   %eax,%eax
    8684:	0f 84 6a 02 00 00    	je     88f4 <tp_value+0x834>
    868a:	41 8b 7e 10          	mov    0x10(%r14),%edi
    868e:	48 89 de             	mov    %rbx,%rsi
    8691:	e8 7a aa ff ff       	call   3110 <fwp_record>
    8696:	e9 28 01 00 00       	jmp    87c3 <tp_value+0x703>
    869b:	4c 89 ff             	mov    %r15,%rdi
    869e:	4c 89 f6             	mov    %r14,%rsi
    86a1:	48 89 ea             	mov    %rbp,%rdx
    86a4:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    86ab:	5b                   	pop    %rbx
    86ac:	41 5c                	pop    %r12
    86ae:	41 5d                	pop    %r13
    86b0:	41 5e                	pop    %r14
    86b2:	41 5f                	pop    %r15
    86b4:	5d                   	pop    %rbp
    86b5:	e9 56 0b 00 00       	jmp    9210 <tp_record_body>
    86ba:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    86bf:	45 85 ed             	test   %r13d,%r13d
    86c2:	74 7a                	je     873e <tp_value+0x67e>
    86c4:	85 ed                	test   %ebp,%ebp
    86c6:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    86cb:	79 76                	jns    8743 <tp_value+0x683>
    86cd:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    86d1:	45 31 e4             	xor    %r12d,%r12d
    86d4:	48 85 ff             	test   %rdi,%rdi
    86d7:	0f 84 17 02 00 00    	je     88f4 <tp_value+0x834>
    86dd:	48 8d 35 85 6b 00 00 	lea    0x6b85(%rip),%rsi        # f269 <exec_in_fp0+0xc19>
    86e4:	e8 e7 9b ff ff       	call   22d0 <strcmp@plt>
    86e9:	85 c0                	test   %eax,%eax
    86eb:	0f 85 03 02 00 00    	jne    88f4 <tp_value+0x834>
    86f1:	8b 44 24 20          	mov    0x20(%rsp),%eax
    86f5:	89 c1                	mov    %eax,%ecx
    86f7:	81 f1 74 72 75 65    	xor    $0x65757274,%ecx
    86fd:	0f b6 54 24 24       	movzbl 0x24(%rsp),%edx
    8702:	09 ca                	or     %ecx,%edx
    8704:	b9 01 00 00 00       	mov    $0x1,%ecx
    8709:	0f 44 e9             	cmove  %ecx,%ebp
    870c:	35 66 61 6c 73       	xor    $0x736c6166,%eax
    8711:	0f b7 4c 24 24       	movzwl 0x24(%rsp),%ecx
    8716:	83 f1 65             	xor    $0x65,%ecx
    8719:	09 c1                	or     %eax,%ecx
    871b:	75 26                	jne    8743 <tp_value+0x683>
    871d:	31 ed                	xor    %ebp,%ebp
    871f:	eb 2a                	jmp    874b <tp_value+0x68b>
    8721:	48 8d 05 08 d7 01 00 	lea    0x1d708(%rip),%rax        # 25e30 <fwp_empty_map>
    8728:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    872d:	48 89 c3             	mov    %rax,%rbx
    8730:	e8 eb d0 ff ff       	call   5820 <fwp_mem_free>
    8735:	48 89 5d 00          	mov    %rbx,0x0(%rbp)
    8739:	e9 e1 f9 ff ff       	jmp    811f <tp_value+0x5f>
    873e:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    8743:	85 ed                	test   %ebp,%ebp
    8745:	0f 88 a6 01 00 00    	js     88f1 <tp_value+0x831>
    874b:	48 8b 43 28          	mov    0x28(%rbx),%rax
    874f:	41 89 ed             	mov    %ebp,%r13d
    8752:	4a 63 1c a8          	movslq (%rax,%r13,4),%rbx
    8756:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    875d:	00 
    875e:	e8 cd cf ff ff       	call   5730 <fwp_alloc>
    8763:	48 89 c5             	mov    %rax,%rbp
    8766:	89 d8                	mov    %ebx,%eax
    8768:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    876d:	48 85 db             	test   %rbx,%rbx
    8770:	7e 41                	jle    87b3 <tp_value+0x6f3>
    8772:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    8777:	48 8d 1c c5 00 00 00 	lea    0x0(,%rax,8),%rbx
    877e:	00 
    877f:	45 31 e4             	xor    %r12d,%r12d
    8782:	45 31 f6             	xor    %r14d,%r14d
    8785:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    878a:	48 8b 40 30          	mov    0x30(%rax),%rax
    878e:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    8792:	4a 8b 34 30          	mov    (%rax,%r14,1),%rsi
    8796:	49 8d 14 2e          	lea    (%r14,%rbp,1),%rdx
    879a:	4c 89 ff             	mov    %r15,%rdi
    879d:	e8 fe 0c 00 00       	call   94a0 <tp_atom>
    87a2:	85 c0                	test   %eax,%eax
    87a4:	0f 84 4a 01 00 00    	je     88f4 <tp_value+0x834>
    87aa:	49 83 c6 08          	add    $0x8,%r14
    87ae:	4c 39 f3             	cmp    %r14,%rbx
    87b1:	75 d2                	jne    8785 <tp_value+0x6c5>
    87b3:	44 89 ef             	mov    %r13d,%edi
    87b6:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    87bb:	48 89 ea             	mov    %rbp,%rdx
    87be:	e8 6d a9 ff ff       	call   3130 <fwp_data>
    87c3:	48 8b 0c 24          	mov    (%rsp),%rcx
    87c7:	48 89 01             	mov    %rax,(%rcx)
    87ca:	e9 50 f9 ff ff       	jmp    811f <tp_value+0x5f>
    87cf:	48 89 2c 24          	mov    %rbp,(%rsp)
    87d3:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    87d8:	ba 80 00 00 00       	mov    $0x80,%edx
    87dd:	4c 89 ff             	mov    %r15,%rdi
    87e0:	48 89 f3             	mov    %rsi,%rbx
    87e3:	e8 e8 06 00 00       	call   8ed0 <tp_token>
    87e8:	49 89 c7             	mov    %rax,%r15
    87eb:	4c 8d 24 04          	lea    (%rsp,%rax,1),%r12
    87ef:	49 83 c4 20          	add    $0x20,%r12
    87f3:	41 be 08 00 00 00    	mov    $0x8,%r14d
    87f9:	eb 0e                	jmp    8809 <tp_value+0x749>
    87fb:	49 83 c6 10          	add    $0x10,%r14
    87ff:	49 83 fe 68          	cmp    $0x68,%r14
    8803:	0f 84 e8 00 00 00    	je     88f1 <tp_value+0x831>
    8809:	48 8d 05 60 b4 00 00 	lea    0xb460(%rip),%rax        # 13c70 <tp_value.units>
    8810:	49 8b 6c 06 f8       	mov    -0x8(%r14,%rax,1),%rbp
    8815:	48 89 ef             	mov    %rbp,%rdi
    8818:	e8 53 99 ff ff       	call   2170 <strlen@plt>
    881d:	4d 89 fd             	mov    %r15,%r13
    8820:	49 29 c5             	sub    %rax,%r13
    8823:	76 d6                	jbe    87fb <tp_value+0x73b>
    8825:	4c 89 e7             	mov    %r12,%rdi
    8828:	48 29 c7             	sub    %rax,%rdi
    882b:	48 89 ee             	mov    %rbp,%rsi
    882e:	e8 9d 9a ff ff       	call   22d0 <strcmp@plt>
    8833:	85 c0                	test   %eax,%eax
    8835:	75 c4                	jne    87fb <tp_value+0x73b>
    8837:	48 8d ac 24 20 01 00 	lea    0x120(%rsp),%rbp
    883e:	00 
    883f:	48 89 ef             	mov    %rbp,%rdi
    8842:	48 89 de             	mov    %rbx,%rsi
    8845:	4c 89 ea             	mov    %r13,%rdx
    8848:	e8 e3 9a ff ff       	call   2330 <memcpy@plt>
    884d:	42 c6 84 2c 20 01 00 	movb   $0x0,0x120(%rsp,%r13,1)
    8854:	00 00 
    8856:	48 89 ef             	mov    %rbp,%rdi
    8859:	4c 89 ee             	mov    %r13,%rsi
    885c:	e8 6f 09 00 00       	call   91d0 <fwp_valid_int>
    8861:	85 c0                	test   %eax,%eax
    8863:	74 96                	je     87fb <tp_value+0x73b>
    8865:	0f b6 b4 24 20 01 00 	movzbl 0x120(%rsp),%esi
    886c:	00 
    886d:	8d 4e d5             	lea    -0x2b(%rsi),%ecx
    8870:	31 c0                	xor    %eax,%eax
    8872:	f6 c1 fd             	test   $0xfd,%cl
    8875:	0f 94 c0             	sete   %al
    8878:	44 0f b6 94 04 20 01 	movzbl 0x120(%rsp,%rax,1),%r10d
    887f:	00 00 
    8881:	45 31 e4             	xor    %r12d,%r12d
    8884:	45 84 d2             	test   %r10b,%r10b
    8887:	0f 84 ba 00 00 00    	je     8947 <tp_value+0x887>
    888d:	48 8d 8c 24 20 01 00 	lea    0x120(%rsp),%rcx
    8894:	00 
    8895:	48 01 c1             	add    %rax,%rcx
    8898:	48 ff c1             	inc    %rcx
    889b:	31 c0                	xor    %eax,%eax
    889d:	bf 0a 00 00 00       	mov    $0xa,%edi
    88a2:	49 b9 00 00 00 00 00 	movabs $0x8000000000000000,%r9
    88a9:	00 00 80 
    88ac:	45 31 c0             	xor    %r8d,%r8d
    88af:	48 8b 1c 24          	mov    (%rsp),%rbx
    88b3:	48 f7 e7             	mul    %rdi
    88b6:	4f 8d 04 80          	lea    (%r8,%r8,4),%r8
    88ba:	4a 8d 14 42          	lea    (%rdx,%r8,2),%rdx
    88be:	45 0f be c2          	movsbl %r10b,%r8d
    88c2:	41 83 c0 d0          	add    $0xffffffd0,%r8d
    88c6:	4d 63 d0             	movslq %r8d,%r10
    88c9:	4d 89 d0             	mov    %r10,%r8
    88cc:	49 c1 f8 3f          	sar    $0x3f,%r8
    88d0:	4c 01 d0             	add    %r10,%rax
    88d3:	49 11 d0             	adc    %rdx,%r8
    88d6:	49 39 c1             	cmp    %rax,%r9
    88d9:	ba 00 00 00 00       	mov    $0x0,%edx
    88de:	4c 19 c2             	sbb    %r8,%rdx
    88e1:	7c 0e                	jl     88f1 <tp_value+0x831>
    88e3:	44 0f b6 11          	movzbl (%rcx),%r10d
    88e7:	48 ff c1             	inc    %rcx
    88ea:	45 84 d2             	test   %r10b,%r10b
    88ed:	75 c4                	jne    88b3 <tp_value+0x7f3>
    88ef:	eb 5f                	jmp    8950 <tp_value+0x890>
    88f1:	45 31 e4             	xor    %r12d,%r12d
    88f4:	44 89 e0             	mov    %r12d,%eax
    88f7:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    88fe:	5b                   	pop    %rbx
    88ff:	41 5c                	pop    %r12
    8901:	41 5d                	pop    %r13
    8903:	41 5e                	pop    %r14
    8905:	41 5f                	pop    %r15
    8907:	5d                   	pop    %rbp
    8908:	c3                   	ret
    8909:	48 8d 35 8b 69 00 00 	lea    0x698b(%rip),%rsi        # f29b <exec_in_fp0+0xc4b>
    8910:	4c 89 ff             	mov    %r15,%rdi
    8913:	e8 98 04 00 00       	call   8db0 <tp_eat>
    8918:	85 c0                	test   %eax,%eax
    891a:	74 d8                	je     88f4 <tp_value+0x834>
    891c:	48 8d 35 3d 6a 00 00 	lea    0x6a3d(%rip),%rsi        # f360 <exec_in_fp0+0xd10>
    8923:	4c 89 ff             	mov    %r15,%rdi
    8926:	e8 85 04 00 00       	call   8db0 <tp_eat>
    892b:	85 c0                	test   %eax,%eax
    892d:	74 c5                	je     88f4 <tp_value+0x834>
    892f:	48 c7 45 00 00 00 00 	movq   $0x0,0x0(%rbp)
    8936:	00 
    8937:	e9 e3 f7 ff ff       	jmp    811f <tp_value+0x5f>
    893c:	31 c9                	xor    %ecx,%ecx
    893e:	48 89 4d 00          	mov    %rcx,0x0(%rbp)
    8942:	e9 d8 f7 ff ff       	jmp    811f <tp_value+0x5f>
    8947:	31 c0                	xor    %eax,%eax
    8949:	45 31 c0             	xor    %r8d,%r8d
    894c:	48 8b 1c 24          	mov    (%rsp),%rbx
    8950:	48 89 c1             	mov    %rax,%rcx
    8953:	48 f7 d9             	neg    %rcx
    8956:	bf 00 00 00 00       	mov    $0x0,%edi
    895b:	4c 19 c7             	sbb    %r8,%rdi
    895e:	40 80 fe 2d          	cmp    $0x2d,%sil
    8962:	49 0f 45 f8          	cmovne %r8,%rdi
    8966:	48 0f 45 c8          	cmovne %rax,%rcx
    896a:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    8971:	ff ff 7f 
    8974:	48 39 c8             	cmp    %rcx,%rax
    8977:	b8 00 00 00 00       	mov    $0x0,%eax
    897c:	48 19 f8             	sbb    %rdi,%rax
    897f:	0f 8c 6f ff ff ff    	jl     88f4 <tp_value+0x834>
    8985:	48 8d 05 e4 b2 00 00 	lea    0xb2e4(%rip),%rax        # 13c70 <tp_value.units>
    898c:	49 8b 34 06          	mov    (%r14,%rax,1),%rsi
    8990:	48 89 c8             	mov    %rcx,%rax
    8993:	48 f7 e6             	mul    %rsi
    8996:	48 0f af fe          	imul   %rsi,%rdi
    899a:	48 c1 fe 3f          	sar    $0x3f,%rsi
    899e:	48 0f af f1          	imul   %rcx,%rsi
    89a2:	48 01 d6             	add    %rdx,%rsi
    89a5:	48 01 f7             	add    %rsi,%rdi
    89a8:	48 b9 00 00 00 00 00 	movabs $0x8000000000000000,%rcx
    89af:	00 00 80 
    89b2:	48 01 c1             	add    %rax,%rcx
    89b5:	48 83 d7 ff          	adc    $0xffffffffffffffff,%rdi
    89b9:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
    89bd:	0f 85 31 ff ff ff    	jne    88f4 <tp_value+0x834>
    89c3:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    89c8:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    89ce:	48 8d 74 24 18       	lea    0x18(%rsp),%rsi
    89d3:	bf 01 00 00 00       	mov    $0x1,%edi
    89d8:	e8 33 a7 ff ff       	call   3110 <fwp_record>
    89dd:	48 89 03             	mov    %rax,(%rbx)
    89e0:	e9 0f ff ff ff       	jmp    88f4 <tp_value+0x834>
    89e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    89ec:	00 00 00 00 

00000000000089f0 <tp_ws>:
    89f0:	48 8b 47 08          	mov    0x8(%rdi),%rax
    89f4:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    89f8:	48 39 c1             	cmp    %rax,%rcx
    89fb:	73 39                	jae    8a36 <tp_ws+0x46>
    89fd:	48 8b 17             	mov    (%rdi),%rdx
    8a00:	48 f7 d8             	neg    %rax
    8a03:	48 ff c1             	inc    %rcx
    8a06:	48 be 00 26 00 00 01 	movabs $0x100002600,%rsi
    8a0d:	00 00 00 
    8a10:	44 0f b6 44 0a ff    	movzbl -0x1(%rdx,%rcx,1),%r8d
    8a16:	49 83 f8 20          	cmp    $0x20,%r8
    8a1a:	77 1a                	ja     8a36 <tp_ws+0x46>
    8a1c:	4c 0f a3 c6          	bt     %r8,%rsi
    8a20:	73 14                	jae    8a36 <tp_ws+0x46>
    8a22:	48 89 4f 10          	mov    %rcx,0x10(%rdi)
    8a26:	4c 8d 04 08          	lea    (%rax,%rcx,1),%r8
    8a2a:	49 ff c0             	inc    %r8
    8a2d:	48 ff c1             	inc    %rcx
    8a30:	49 83 f8 01          	cmp    $0x1,%r8
    8a34:	75 da                	jne    8a10 <tp_ws+0x20>
    8a36:	c3                   	ret
    8a37:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    8a3e:	00 00 

0000000000008a40 <tp_int>:
    8a40:	55                   	push   %rbp
    8a41:	41 56                	push   %r14
    8a43:	53                   	push   %rbx
    8a44:	48 81 ec 80 00 00 00 	sub    $0x80,%rsp
    8a4b:	48 89 d3             	mov    %rdx,%rbx
    8a4e:	49 89 f6             	mov    %rsi,%r14
    8a51:	48 89 e6             	mov    %rsp,%rsi
    8a54:	ba 80 00 00 00       	mov    $0x80,%edx
    8a59:	e8 72 04 00 00       	call   8ed0 <tp_token>
    8a5e:	31 ed                	xor    %ebp,%ebp
    8a60:	48 83 f8 7f          	cmp    $0x7f,%rax
    8a64:	77 28                	ja     8a8e <tp_int+0x4e>
    8a66:	48 89 e7             	mov    %rsp,%rdi
    8a69:	e8 d2 0a 00 00       	call   9540 <fwp_cstr>
    8a6e:	41 8b 36             	mov    (%r14),%esi
    8a71:	41 8b 56 48          	mov    0x48(%r14),%edx
    8a75:	48 89 c7             	mov    %rax,%rdi
    8a78:	e8 e3 0a 00 00       	call   9560 <fwp_p_parse_int>
    8a7d:	48 85 c0             	test   %rax,%rax
    8a80:	74 0c                	je     8a8e <tp_int+0x4e>
    8a82:	48 8b 40 08          	mov    0x8(%rax),%rax
    8a86:	48 89 03             	mov    %rax,(%rbx)
    8a89:	bd 01 00 00 00       	mov    $0x1,%ebp
    8a8e:	89 e8                	mov    %ebp,%eax
    8a90:	48 81 c4 80 00 00 00 	add    $0x80,%rsp
    8a97:	5b                   	pop    %rbx
    8a98:	41 5e                	pop    %r14
    8a9a:	5d                   	pop    %rbp
    8a9b:	c3                   	ret
    8a9c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000008aa0 <tp_float>:
    8aa0:	41 56                	push   %r14
    8aa2:	53                   	push   %rbx
    8aa3:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    8aaa:	48 89 d3             	mov    %rdx,%rbx
    8aad:	49 89 f6             	mov    %rsi,%r14
    8ab0:	48 89 e6             	mov    %rsp,%rsi
    8ab3:	ba 80 00 00 00       	mov    $0x80,%edx
    8ab8:	e8 13 04 00 00       	call   8ed0 <tp_token>
    8abd:	31 c9                	xor    %ecx,%ecx
    8abf:	48 83 f8 7f          	cmp    $0x7f,%rax
    8ac3:	0f 87 84 00 00 00    	ja     8b4d <tp_float+0xad>
    8ac9:	8b 0c 24             	mov    (%rsp),%ecx
    8acc:	81 f9 69 6e 66 00    	cmp    $0x666e69,%ecx
    8ad2:	75 0a                	jne    8ade <tp_float+0x3e>
    8ad4:	f2 0f 10 05 84 56 00 	movsd  0x5684(%rip),%xmm0        # e160 <_IO_stdin_used+0x160>
    8adb:	00 
    8adc:	eb 5f                	jmp    8b3d <tp_float+0x9d>
    8ade:	ba 2d 69 6e 66       	mov    $0x666e692d,%edx
    8ae3:	33 14 24             	xor    (%rsp),%edx
    8ae6:	0f b6 74 24 04       	movzbl 0x4(%rsp),%esi
    8aeb:	09 d6                	or     %edx,%esi
    8aed:	74 12                	je     8b01 <tp_float+0x61>
    8aef:	81 f9 4e 61 4e 00    	cmp    $0x4e614e,%ecx
    8af5:	75 14                	jne    8b0b <tp_float+0x6b>
    8af7:	f2 0f 10 05 71 56 00 	movsd  0x5671(%rip),%xmm0        # e170 <_IO_stdin_used+0x170>
    8afe:	00 
    8aff:	eb 3c                	jmp    8b3d <tp_float+0x9d>
    8b01:	f2 0f 10 05 5f 56 00 	movsd  0x565f(%rip),%xmm0        # e168 <_IO_stdin_used+0x168>
    8b08:	00 
    8b09:	eb 32                	jmp    8b3d <tp_float+0x9d>
    8b0b:	48 89 e7             	mov    %rsp,%rdi
    8b0e:	48 89 c6             	mov    %rax,%rsi
    8b11:	e8 7a 0e 00 00       	call   9990 <fwp_valid_float>
    8b16:	31 c9                	xor    %ecx,%ecx
    8b18:	85 c0                	test   %eax,%eax
    8b1a:	74 31                	je     8b4d <tp_float+0xad>
    8b1c:	41 83 3e 0a          	cmpl   $0xa,(%r14)
    8b20:	75 11                	jne    8b33 <tp_float+0x93>
    8b22:	48 89 e7             	mov    %rsp,%rdi
    8b25:	31 f6                	xor    %esi,%esi
    8b27:	e8 d4 96 ff ff       	call   2200 <strtof@plt>
    8b2c:	e8 4f 0f 00 00       	call   9a80 <fwp_from_f32>
    8b31:	eb 12                	jmp    8b45 <tp_float+0xa5>
    8b33:	48 89 e7             	mov    %rsp,%rdi
    8b36:	31 f6                	xor    %esi,%esi
    8b38:	e8 c3 95 ff ff       	call   2100 <strtod@plt>
    8b3d:	41 8b 3e             	mov    (%r14),%edi
    8b40:	e8 4b 0f 00 00       	call   9a90 <fwp_float_of>
    8b45:	48 89 03             	mov    %rax,(%rbx)
    8b48:	b9 01 00 00 00       	mov    $0x1,%ecx
    8b4d:	89 c8                	mov    %ecx,%eax
    8b4f:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
    8b56:	5b                   	pop    %rbx
    8b57:	41 5e                	pop    %r14
    8b59:	c3                   	ret
    8b5a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000008b60 <tp_quoted>:
    8b60:	55                   	push   %rbp
    8b61:	41 57                	push   %r15
    8b63:	41 56                	push   %r14
    8b65:	41 55                	push   %r13
    8b67:	41 54                	push   %r12
    8b69:	53                   	push   %rbx
    8b6a:	48 83 ec 18          	sub    $0x18,%rsp
    8b6e:	49 89 f6             	mov    %rsi,%r14
    8b71:	49 89 ff             	mov    %rdi,%r15
    8b74:	e8 77 fe ff ff       	call   89f0 <tp_ws>
    8b79:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    8b7d:	49 8b 6f 10          	mov    0x10(%r15),%rbp
    8b81:	31 db                	xor    %ebx,%ebx
    8b83:	4c 39 ed             	cmp    %r13,%rbp
    8b86:	0f 83 0d 02 00 00    	jae    8d99 <tp_quoted+0x239>
    8b8c:	49 8b 07             	mov    (%r15),%rax
    8b8f:	80 3c 28 22          	cmpb   $0x22,(%rax,%rbp,1)
    8b93:	0f 85 00 02 00 00    	jne    8d99 <tp_quoted+0x239>
    8b99:	48 ff c5             	inc    %rbp
    8b9c:	49 89 6f 10          	mov    %rbp,0x10(%r15)
    8ba0:	0f 57 c0             	xorps  %xmm0,%xmm0
    8ba3:	0f 29 04 24          	movaps %xmm0,(%rsp)
    8ba7:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    8bae:	00 00 
    8bb0:	31 db                	xor    %ebx,%ebx
    8bb2:	4c 39 ed             	cmp    %r13,%rbp
    8bb5:	0f 83 8d 01 00 00    	jae    8d48 <tp_quoted+0x1e8>
    8bbb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8bc0:	4d 8b 27             	mov    (%r15),%r12
    8bc3:	48 8d 4d 01          	lea    0x1(%rbp),%rcx
    8bc7:	49 89 4f 10          	mov    %rcx,0x10(%r15)
    8bcb:	41 0f b6 04 2c       	movzbl (%r12,%rbp,1),%eax
    8bd0:	83 f8 5c             	cmp    $0x5c,%eax
    8bd3:	74 2b                	je     8c00 <tp_quoted+0xa0>
    8bd5:	83 f8 22             	cmp    $0x22,%eax
    8bd8:	0f 84 8b 01 00 00    	je     8d69 <tp_quoted+0x209>
    8bde:	0f be f0             	movsbl %al,%esi
    8be1:	48 89 e7             	mov    %rsp,%rdi
    8be4:	e8 57 ee ff ff       	call   7a40 <buf_putc>
    8be9:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    8bed:	49 8b 6f 10          	mov    0x10(%r15),%rbp
    8bf1:	4c 39 ed             	cmp    %r13,%rbp
    8bf4:	72 ca                	jb     8bc0 <tp_quoted+0x60>
    8bf6:	e9 63 01 00 00       	jmp    8d5e <tp_quoted+0x1fe>
    8bfb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8c00:	4c 39 e9             	cmp    %r13,%rcx
    8c03:	0f 83 48 01 00 00    	jae    8d51 <tp_quoted+0x1f1>
    8c09:	48 8d 45 02          	lea    0x2(%rbp),%rax
    8c0d:	49 89 47 10          	mov    %rax,0x10(%r15)
    8c11:	41 0f b6 4c 2c 01    	movzbl 0x1(%r12,%rbp,1),%ecx
    8c17:	8d 51 a4             	lea    -0x5c(%rcx),%edx
    8c1a:	83 fa 19             	cmp    $0x19,%edx
    8c1d:	77 1a                	ja     8c39 <tp_quoted+0xd9>
    8c1f:	48 8d 35 0a 56 00 00 	lea    0x560a(%rip),%rsi        # e230 <_IO_stdin_used+0x230>
    8c26:	48 63 0c 96          	movslq (%rsi,%rdx,4),%rcx
    8c2a:	48 01 f1             	add    %rsi,%rcx
    8c2d:	ff e1                	jmp    *%rcx
    8c2f:	48 89 e7             	mov    %rsp,%rdi
    8c32:	be 5c 00 00 00       	mov    $0x5c,%esi
    8c37:	eb ab                	jmp    8be4 <tp_quoted+0x84>
    8c39:	83 f9 22             	cmp    $0x22,%ecx
    8c3c:	0f 84 bf 00 00 00    	je     8d01 <tp_quoted+0x1a1>
    8c42:	83 f9 30             	cmp    $0x30,%ecx
    8c45:	0f 85 06 01 00 00    	jne    8d51 <tp_quoted+0x1f1>
    8c4b:	48 89 e7             	mov    %rsp,%rdi
    8c4e:	31 f6                	xor    %esi,%esi
    8c50:	eb 92                	jmp    8be4 <tp_quoted+0x84>
    8c52:	48 89 e7             	mov    %rsp,%rdi
    8c55:	be 09 00 00 00       	mov    $0x9,%esi
    8c5a:	eb 88                	jmp    8be4 <tp_quoted+0x84>
    8c5c:	48 89 e7             	mov    %rsp,%rdi
    8c5f:	be 0d 00 00 00       	mov    $0xd,%esi
    8c64:	e9 7b ff ff ff       	jmp    8be4 <tp_quoted+0x84>
    8c69:	48 89 e7             	mov    %rsp,%rdi
    8c6c:	be 0a 00 00 00       	mov    $0xa,%esi
    8c71:	e9 6e ff ff ff       	jmp    8be4 <tp_quoted+0x84>
    8c76:	4c 39 e8             	cmp    %r13,%rax
    8c79:	0f 83 d2 00 00 00    	jae    8d51 <tp_quoted+0x1f1>
    8c7f:	41 80 3c 04 7b       	cmpb   $0x7b,(%r12,%rax,1)
    8c84:	0f 85 c7 00 00 00    	jne    8d51 <tp_quoted+0x1f1>
    8c8a:	48 8d 45 03          	lea    0x3(%rbp),%rax
    8c8e:	49 89 47 10          	mov    %rax,0x10(%r15)
    8c92:	4c 39 e8             	cmp    %r13,%rax
    8c95:	0f 83 b6 00 00 00    	jae    8d51 <tp_quoted+0x1f1>
    8c9b:	e8 60 98 ff ff       	call   2500 <__ctype_b_loc@plt>
    8ca0:	48 8b 08             	mov    (%rax),%rcx
    8ca3:	48 8d 55 04          	lea    0x4(%rbp),%rdx
    8ca7:	49 8d 3c 2c          	lea    (%r12,%rbp,1),%rdi
    8cab:	48 83 c7 03          	add    $0x3,%rdi
    8caf:	49 29 ed             	sub    %rbp,%r13
    8cb2:	49 83 c5 fd          	add    $0xfffffffffffffffd,%r13
    8cb6:	31 c0                	xor    %eax,%eax
    8cb8:	31 f6                	xor    %esi,%esi
    8cba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8cc0:	44 0f b6 04 07       	movzbl (%rdi,%rax,1),%r8d
    8cc5:	42 f6 44 41 01 10    	testb  $0x10,0x1(%rcx,%r8,2)
    8ccb:	74 41                	je     8d0e <tp_quoted+0x1ae>
    8ccd:	4c 8d 04 02          	lea    (%rdx,%rax,1),%r8
    8cd1:	4d 89 47 10          	mov    %r8,0x10(%r15)
    8cd5:	44 0f be 04 07       	movsbl (%rdi,%rax,1),%r8d
    8cda:	c1 e6 04             	shl    $0x4,%esi
    8cdd:	45 8d 48 d0          	lea    -0x30(%r8),%r9d
    8ce1:	45 89 c2             	mov    %r8d,%r10d
    8ce4:	41 83 ca 20          	or     $0x20,%r10d
    8ce8:	41 83 c2 a9          	add    $0xffffffa9,%r10d
    8cec:	41 83 f8 3a          	cmp    $0x3a,%r8d
    8cf0:	45 0f 4c d1          	cmovl  %r9d,%r10d
    8cf4:	44 01 d6             	add    %r10d,%esi
    8cf7:	48 ff c0             	inc    %rax
    8cfa:	49 39 c5             	cmp    %rax,%r13
    8cfd:	75 c1                	jne    8cc0 <tp_quoted+0x160>
    8cff:	eb 50                	jmp    8d51 <tp_quoted+0x1f1>
    8d01:	48 89 e7             	mov    %rsp,%rdi
    8d04:	be 22 00 00 00       	mov    $0x22,%esi
    8d09:	e9 d6 fe ff ff       	jmp    8be4 <tp_quoted+0x84>
    8d0e:	85 c0                	test   %eax,%eax
    8d10:	74 3f                	je     8d51 <tp_quoted+0x1f1>
    8d12:	41 80 f8 7d          	cmp    $0x7d,%r8b
    8d16:	75 39                	jne    8d51 <tp_quoted+0x1f1>
    8d18:	81 fe ff ff 10 00    	cmp    $0x10ffff,%esi
    8d1e:	77 31                	ja     8d51 <tp_quoted+0x1f1>
    8d20:	89 f1                	mov    %esi,%ecx
    8d22:	81 e1 00 f8 ff ff    	and    $0xfffff800,%ecx
    8d28:	81 f9 00 d8 00 00    	cmp    $0xd800,%ecx
    8d2e:	74 21                	je     8d51 <tp_quoted+0x1f1>
    8d30:	48 01 e8             	add    %rbp,%rax
    8d33:	48 83 c0 04          	add    $0x4,%rax
    8d37:	49 89 47 10          	mov    %rax,0x10(%r15)
    8d3b:	48 89 e7             	mov    %rsp,%rdi
    8d3e:	e8 5d 0d 00 00       	call   9aa0 <fwp_utf8_put>
    8d43:	e9 a1 fe ff ff       	jmp    8be9 <tp_quoted+0x89>
    8d48:	31 ff                	xor    %edi,%edi
    8d4a:	e8 01 93 ff ff       	call   2050 <free@plt>
    8d4f:	eb 48                	jmp    8d99 <tp_quoted+0x239>
    8d51:	48 8b 3c 24          	mov    (%rsp),%rdi
    8d55:	e8 f6 92 ff ff       	call   2050 <free@plt>
    8d5a:	31 db                	xor    %ebx,%ebx
    8d5c:	eb 3b                	jmp    8d99 <tp_quoted+0x239>
    8d5e:	48 8b 3c 24          	mov    (%rsp),%rdi
    8d62:	e8 e9 92 ff ff       	call   2050 <free@plt>
    8d67:	eb 30                	jmp    8d99 <tp_quoted+0x239>
    8d69:	48 8b 1c 24          	mov    (%rsp),%rbx
    8d6d:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    8d72:	48 85 db             	test   %rbx,%rbx
    8d75:	48 8d 3d 24 60 00 00 	lea    0x6024(%rip),%rdi        # eda0 <exec_in_fp0+0x750>
    8d7c:	48 0f 45 fb          	cmovne %rbx,%rdi
    8d80:	e8 1b eb ff ff       	call   78a0 <fwp_valid_utf8>
    8d85:	85 c0                	test   %eax,%eax
    8d87:	74 21                	je     8daa <tp_quoted+0x24a>
    8d89:	48 89 e7             	mov    %rsp,%rdi
    8d8c:	e8 3f ed ff ff       	call   7ad0 <buf_to_str>
    8d91:	49 89 06             	mov    %rax,(%r14)
    8d94:	bb 01 00 00 00       	mov    $0x1,%ebx
    8d99:	89 d8                	mov    %ebx,%eax
    8d9b:	48 83 c4 18          	add    $0x18,%rsp
    8d9f:	5b                   	pop    %rbx
    8da0:	41 5c                	pop    %r12
    8da2:	41 5d                	pop    %r13
    8da4:	41 5e                	pop    %r14
    8da6:	41 5f                	pop    %r15
    8da8:	5d                   	pop    %rbp
    8da9:	c3                   	ret
    8daa:	48 89 df             	mov    %rbx,%rdi
    8dad:	eb a6                	jmp    8d55 <tp_quoted+0x1f5>
    8daf:	90                   	nop

0000000000008db0 <tp_eat>:
    8db0:	55                   	push   %rbp
    8db1:	41 57                	push   %r15
    8db3:	41 56                	push   %r14
    8db5:	53                   	push   %rbx
    8db6:	50                   	push   %rax
    8db7:	49 89 f6             	mov    %rsi,%r14
    8dba:	48 89 fb             	mov    %rdi,%rbx
    8dbd:	e8 2e fc ff ff       	call   89f0 <tp_ws>
    8dc2:	4c 89 f7             	mov    %r14,%rdi
    8dc5:	e8 a6 93 ff ff       	call   2170 <strlen@plt>
    8dca:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    8dce:	4c 8b 7b 10          	mov    0x10(%rbx),%r15
    8dd2:	4c 29 f9             	sub    %r15,%rcx
    8dd5:	31 ed                	xor    %ebp,%ebp
    8dd7:	48 39 c1             	cmp    %rax,%rcx
    8dda:	72 24                	jb     8e00 <tp_eat+0x50>
    8ddc:	48 8b 3b             	mov    (%rbx),%rdi
    8ddf:	4c 01 ff             	add    %r15,%rdi
    8de2:	4c 89 f6             	mov    %r14,%rsi
    8de5:	49 89 c6             	mov    %rax,%r14
    8de8:	48 89 c2             	mov    %rax,%rdx
    8deb:	e8 80 95 ff ff       	call   2370 <bcmp@plt>
    8df0:	85 c0                	test   %eax,%eax
    8df2:	75 0c                	jne    8e00 <tp_eat+0x50>
    8df4:	4d 01 f7             	add    %r14,%r15
    8df7:	4c 89 7b 10          	mov    %r15,0x10(%rbx)
    8dfb:	bd 01 00 00 00       	mov    $0x1,%ebp
    8e00:	89 e8                	mov    %ebp,%eax
    8e02:	48 83 c4 08          	add    $0x8,%rsp
    8e06:	5b                   	pop    %rbx
    8e07:	41 5e                	pop    %r14
    8e09:	41 5f                	pop    %r15
    8e0b:	5d                   	pop    %rbp
    8e0c:	c3                   	ret
    8e0d:	0f 1f 00             	nopl   (%rax)

0000000000008e10 <tp_list_of>:
    8e10:	55                   	push   %rbp
    8e11:	41 57                	push   %r15
    8e13:	41 56                	push   %r14
    8e15:	41 55                	push   %r13
    8e17:	41 54                	push   %r12
    8e19:	53                   	push   %rbx
    8e1a:	50                   	push   %rax
    8e1b:	4d 89 c6             	mov    %r8,%r14
    8e1e:	49 89 cf             	mov    %rcx,%r15
    8e21:	49 89 d4             	mov    %rdx,%r12
    8e24:	49 89 fd             	mov    %rdi,%r13
    8e27:	e8 84 ff ff ff       	call   8db0 <tp_eat>
    8e2c:	31 db                	xor    %ebx,%ebx
    8e2e:	85 c0                	test   %eax,%eax
    8e30:	74 14                	je     8e46 <tp_list_of+0x36>
    8e32:	4c 89 ef             	mov    %r13,%rdi
    8e35:	4c 89 e6             	mov    %r12,%rsi
    8e38:	e8 73 ff ff ff       	call   8db0 <tp_eat>
    8e3d:	85 c0                	test   %eax,%eax
    8e3f:	74 16                	je     8e57 <tp_list_of+0x47>
    8e41:	bb 01 00 00 00       	mov    $0x1,%ebx
    8e46:	89 d8                	mov    %ebx,%eax
    8e48:	48 83 c4 08          	add    $0x8,%rsp
    8e4c:	5b                   	pop    %rbx
    8e4d:	41 5c                	pop    %r12
    8e4f:	41 5d                	pop    %r13
    8e51:	41 5e                	pop    %r14
    8e53:	41 5f                	pop    %r15
    8e55:	5d                   	pop    %rbp
    8e56:	c3                   	ret
    8e57:	48 8d 2d 3f 64 00 00 	lea    0x643f(%rip),%rbp        # f29d <exec_in_fp0+0xc4d>
    8e5e:	66 90                	xchg   %ax,%ax
    8e60:	4c 89 ef             	mov    %r13,%rdi
    8e63:	4c 89 f6             	mov    %r14,%rsi
    8e66:	41 ff d7             	call   *%r15
    8e69:	85 c0                	test   %eax,%eax
    8e6b:	74 d9                	je     8e46 <tp_list_of+0x36>
    8e6d:	4c 89 ef             	mov    %r13,%rdi
    8e70:	4c 89 e6             	mov    %r12,%rsi
    8e73:	e8 38 ff ff ff       	call   8db0 <tp_eat>
    8e78:	85 c0                	test   %eax,%eax
    8e7a:	75 c5                	jne    8e41 <tp_list_of+0x31>
    8e7c:	4c 89 ef             	mov    %r13,%rdi
    8e7f:	48 89 ee             	mov    %rbp,%rsi
    8e82:	e8 29 ff ff ff       	call   8db0 <tp_eat>
    8e87:	85 c0                	test   %eax,%eax
    8e89:	75 d5                	jne    8e60 <tp_list_of+0x50>
    8e8b:	eb b9                	jmp    8e46 <tp_list_of+0x36>
    8e8d:	0f 1f 00             	nopl   (%rax)

0000000000008e90 <tp_byte_item>:
    8e90:	53                   	push   %rbx
    8e91:	48 83 ec 10          	sub    $0x10,%rsp
    8e95:	48 89 f3             	mov    %rsi,%rbx
    8e98:	48 8d 35 31 ae 00 00 	lea    0xae31(%rip),%rsi        # 13cd0 <tp_byte_item.u8d>
    8e9f:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    8ea4:	e8 97 fb ff ff       	call   8a40 <tp_int>
    8ea9:	85 c0                	test   %eax,%eax
    8eab:	74 14                	je     8ec1 <tp_byte_item+0x31>
    8ead:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    8eb2:	48 89 df             	mov    %rbx,%rdi
    8eb5:	e8 96 0c 00 00       	call   9b50 <tp_push>
    8eba:	b8 01 00 00 00       	mov    $0x1,%eax
    8ebf:	eb 02                	jmp    8ec3 <tp_byte_item+0x33>
    8ec1:	31 c0                	xor    %eax,%eax
    8ec3:	48 83 c4 10          	add    $0x10,%rsp
    8ec7:	5b                   	pop    %rbx
    8ec8:	c3                   	ret
    8ec9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000008ed0 <tp_token>:
    8ed0:	55                   	push   %rbp
    8ed1:	41 57                	push   %r15
    8ed3:	41 56                	push   %r14
    8ed5:	41 55                	push   %r13
    8ed7:	41 54                	push   %r12
    8ed9:	53                   	push   %rbx
    8eda:	50                   	push   %rax
    8edb:	49 89 d7             	mov    %rdx,%r15
    8ede:	48 89 34 24          	mov    %rsi,(%rsp)
    8ee2:	48 89 fb             	mov    %rdi,%rbx
    8ee5:	e8 06 fb ff ff       	call   89f0 <tp_ws>
    8eea:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    8eee:	4c 8b 23             	mov    (%rbx),%r12
    8ef1:	4c 8b 6b 08          	mov    0x8(%rbx),%r13
    8ef5:	4c 89 f5             	mov    %r14,%rbp
    8ef8:	4d 39 ee             	cmp    %r13,%r14
    8efb:	73 20                	jae    8f1d <tp_token+0x4d>
    8efd:	4c 89 f5             	mov    %r14,%rbp
    8f00:	41 0f be 3c 2c       	movsbl (%r12,%rbp,1),%edi
    8f05:	e8 a6 0c 00 00       	call   9bb0 <tp_is_delim>
    8f0a:	85 c0                	test   %eax,%eax
    8f0c:	75 0f                	jne    8f1d <tp_token+0x4d>
    8f0e:	48 ff c5             	inc    %rbp
    8f11:	48 89 6b 10          	mov    %rbp,0x10(%rbx)
    8f15:	49 39 ed             	cmp    %rbp,%r13
    8f18:	75 e6                	jne    8f00 <tp_token+0x30>
    8f1a:	4c 89 ed             	mov    %r13,%rbp
    8f1d:	4c 29 f5             	sub    %r14,%rbp
    8f20:	4d 8d 6f ff          	lea    -0x1(%r15),%r13
    8f24:	4c 39 fd             	cmp    %r15,%rbp
    8f27:	4c 0f 42 ed          	cmovb  %rbp,%r13
    8f2b:	4d 01 f4             	add    %r14,%r12
    8f2e:	4c 8b 3c 24          	mov    (%rsp),%r15
    8f32:	4c 89 ff             	mov    %r15,%rdi
    8f35:	4c 89 e6             	mov    %r12,%rsi
    8f38:	4c 89 ea             	mov    %r13,%rdx
    8f3b:	e8 f0 93 ff ff       	call   2330 <memcpy@plt>
    8f40:	43 c6 04 2f 00       	movb   $0x0,(%r15,%r13,1)
    8f45:	48 8b 43 10          	mov    0x10(%rbx),%rax
    8f49:	4c 29 f0             	sub    %r14,%rax
    8f4c:	48 83 c4 08          	add    $0x8,%rsp
    8f50:	5b                   	pop    %rbx
    8f51:	41 5c                	pop    %r12
    8f53:	41 5d                	pop    %r13
    8f55:	41 5e                	pop    %r14
    8f57:	41 5f                	pop    %r15
    8f59:	5d                   	pop    %rbp
    8f5a:	c3                   	ret
    8f5b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000008f60 <tp_elem_item>:
    8f60:	55                   	push   %rbp
    8f61:	53                   	push   %rbx
    8f62:	50                   	push   %rax
    8f63:	48 89 f3             	mov    %rsi,%rbx
    8f66:	48 8b 36             	mov    (%rsi),%rsi
    8f69:	31 ed                	xor    %ebp,%ebp
    8f6b:	48 89 e1             	mov    %rsp,%rcx
    8f6e:	31 d2                	xor    %edx,%edx
    8f70:	e8 4b f1 ff ff       	call   80c0 <tp_value>
    8f75:	85 c0                	test   %eax,%eax
    8f77:	74 11                	je     8f8a <tp_elem_item+0x2a>
    8f79:	48 8b 34 24          	mov    (%rsp),%rsi
    8f7d:	48 89 df             	mov    %rbx,%rdi
    8f80:	e8 cb 0b 00 00       	call   9b50 <tp_push>
    8f85:	bd 01 00 00 00       	mov    $0x1,%ebp
    8f8a:	89 e8                	mov    %ebp,%eax
    8f8c:	48 83 c4 08          	add    $0x8,%rsp
    8f90:	5b                   	pop    %rbx
    8f91:	5d                   	pop    %rbp
    8f92:	c3                   	ret
    8f93:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8f9a:	84 00 00 00 00 00 

0000000000008fa0 <fwp_p_array_from_list>:
    8fa0:	41 56                	push   %r14
    8fa2:	53                   	push   %rbx
    8fa3:	50                   	push   %rax
    8fa4:	48 89 fb             	mov    %rdi,%rbx
    8fa7:	e8 44 0c 00 00       	call   9bf0 <fwp_list_len>
    8fac:	49 89 c6             	mov    %rax,%r14
    8faf:	48 89 c7             	mov    %rax,%rdi
    8fb2:	e8 39 c7 ff ff       	call   56f0 <fwp_arr_new>
    8fb7:	4d 85 f6             	test   %r14,%r14
    8fba:	0f 84 84 00 00 00    	je     9044 <fwp_p_array_from_list+0xa4>
    8fc0:	44 89 f1             	mov    %r14d,%ecx
    8fc3:	83 e1 03             	and    $0x3,%ecx
    8fc6:	49 83 fe 04          	cmp    $0x4,%r14
    8fca:	73 04                	jae    8fd0 <fwp_p_array_from_list+0x30>
    8fcc:	31 d2                	xor    %edx,%edx
    8fce:	eb 4d                	jmp    901d <fwp_p_array_from_list+0x7d>
    8fd0:	49 83 e6 fc          	and    $0xfffffffffffffffc,%r14
    8fd4:	31 d2                	xor    %edx,%edx
    8fd6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    8fdd:	00 00 00 
    8fe0:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    8fe4:	48 89 74 d0 08       	mov    %rsi,0x8(%rax,%rdx,8)
    8fe9:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    8fed:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
    8ff1:	48 89 7c d0 10       	mov    %rdi,0x10(%rax,%rdx,8)
    8ff6:	48 8b 76 10          	mov    0x10(%rsi),%rsi
    8ffa:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
    8ffe:	48 89 7c d0 18       	mov    %rdi,0x18(%rax,%rdx,8)
    9003:	48 8b 76 10          	mov    0x10(%rsi),%rsi
    9007:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
    900b:	48 89 7c d0 20       	mov    %rdi,0x20(%rax,%rdx,8)
    9010:	48 8b 5e 10          	mov    0x10(%rsi),%rbx
    9014:	48 83 c2 04          	add    $0x4,%rdx
    9018:	49 39 d6             	cmp    %rdx,%r14
    901b:	75 c3                	jne    8fe0 <fwp_p_array_from_list+0x40>
    901d:	48 85 c9             	test   %rcx,%rcx
    9020:	74 22                	je     9044 <fwp_p_array_from_list+0xa4>
    9022:	48 8d 14 d0          	lea    (%rax,%rdx,8),%rdx
    9026:	48 83 c2 08          	add    $0x8,%rdx
    902a:	31 f6                	xor    %esi,%esi
    902c:	0f 1f 40 00          	nopl   0x0(%rax)
    9030:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    9034:	48 89 3c f2          	mov    %rdi,(%rdx,%rsi,8)
    9038:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    903c:	48 ff c6             	inc    %rsi
    903f:	48 39 f1             	cmp    %rsi,%rcx
    9042:	75 ec                	jne    9030 <fwp_p_array_from_list+0x90>
    9044:	48 83 c4 08          	add    $0x8,%rsp
    9048:	5b                   	pop    %rbx
    9049:	41 5e                	pop    %r14
    904b:	c3                   	ret
    904c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000009050 <tp_kv_item>:
    9050:	41 57                	push   %r15
    9052:	41 56                	push   %r14
    9054:	53                   	push   %rbx
    9055:	48 83 ec 10          	sub    $0x10,%rsp
    9059:	48 89 f3             	mov    %rsi,%rbx
    905c:	49 89 ff             	mov    %rdi,%r15
    905f:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
    9066:	00 
    9067:	48 8b 36             	mov    (%rsi),%rsi
    906a:	45 31 f6             	xor    %r14d,%r14d
    906d:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    9072:	31 d2                	xor    %edx,%edx
    9074:	e8 47 f0 ff ff       	call   80c0 <tp_value>
    9079:	85 c0                	test   %eax,%eax
    907b:	74 27                	je     90a4 <tp_kv_item+0x54>
    907d:	45 31 f6             	xor    %r14d,%r14d
    9080:	83 7b 28 00          	cmpl   $0x0,0x28(%rbx)
    9084:	74 2b                	je     90b1 <tp_kv_item+0x61>
    9086:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    908b:	48 89 df             	mov    %rbx,%rdi
    908e:	e8 bd 0a 00 00       	call   9b50 <tp_push>
    9093:	48 89 df             	mov    %rbx,%rdi
    9096:	4c 89 f6             	mov    %r14,%rsi
    9099:	e8 b2 0a 00 00       	call   9b50 <tp_push>
    909e:	41 be 01 00 00 00    	mov    $0x1,%r14d
    90a4:	44 89 f0             	mov    %r14d,%eax
    90a7:	48 83 c4 10          	add    $0x10,%rsp
    90ab:	5b                   	pop    %rbx
    90ac:	41 5e                	pop    %r14
    90ae:	41 5f                	pop    %r15
    90b0:	c3                   	ret
    90b1:	48 8d 35 f9 61 00 00 	lea    0x61f9(%rip),%rsi        # f2b1 <exec_in_fp0+0xc61>
    90b8:	4c 89 ff             	mov    %r15,%rdi
    90bb:	e8 f0 fc ff ff       	call   8db0 <tp_eat>
    90c0:	85 c0                	test   %eax,%eax
    90c2:	74 e0                	je     90a4 <tp_kv_item+0x54>
    90c4:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    90c8:	45 31 f6             	xor    %r14d,%r14d
    90cb:	48 89 e1             	mov    %rsp,%rcx
    90ce:	4c 89 ff             	mov    %r15,%rdi
    90d1:	31 d2                	xor    %edx,%edx
    90d3:	e8 e8 ef ff ff       	call   80c0 <tp_value>
    90d8:	85 c0                	test   %eax,%eax
    90da:	74 c8                	je     90a4 <tp_kv_item+0x54>
    90dc:	4c 8b 34 24          	mov    (%rsp),%r14
    90e0:	eb a4                	jmp    9086 <tp_kv_item+0x36>
    90e2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    90e9:	1f 84 00 00 00 00 00 

00000000000090f0 <fwp_p_map_insert>:
    90f0:	55                   	push   %rbp
    90f1:	41 57                	push   %r15
    90f3:	41 56                	push   %r14
    90f5:	41 55                	push   %r13
    90f7:	41 54                	push   %r12
    90f9:	53                   	push   %rbx
    90fa:	48 83 ec 18          	sub    $0x18,%rsp
    90fe:	49 89 d6             	mov    %rdx,%r14
    9101:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    9106:	48 89 fe             	mov    %rdi,%rsi
    9109:	48 8d 44 24 04       	lea    0x4(%rsp),%rax
    910e:	48 89 d7             	mov    %rdx,%rdi
    9111:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
    9116:	48 89 ca             	mov    %rcx,%rdx
    9119:	48 89 c1             	mov    %rax,%rcx
    911c:	e8 ef 0a 00 00       	call   9c10 <fwp_map_find>
    9121:	48 89 c5             	mov    %rax,%rbp
    9124:	4d 8b 3e             	mov    (%r14),%r15
    9127:	44 8b 64 24 04       	mov    0x4(%rsp),%r12d
    912c:	31 ff                	xor    %edi,%edi
    912e:	45 85 e4             	test   %r12d,%r12d
    9131:	40 0f 94 c7          	sete   %dil
    9135:	4c 01 ff             	add    %r15,%rdi
    9138:	e8 23 0c 00 00       	call   9d60 <fwp_map_alloc>
    913d:	49 89 c5             	mov    %rax,%r13
    9140:	48 8d 58 08          	lea    0x8(%rax),%rbx
    9144:	49 83 c6 08          	add    $0x8,%r14
    9148:	45 85 e4             	test   %r12d,%r12d
    914b:	74 22                	je     916f <fwp_p_map_insert+0x7f>
    914d:	49 c1 e7 04          	shl    $0x4,%r15
    9151:	48 89 df             	mov    %rbx,%rdi
    9154:	4c 89 f6             	mov    %r14,%rsi
    9157:	4c 89 fa             	mov    %r15,%rdx
    915a:	e8 d1 91 ff ff       	call   2330 <memcpy@plt>
    915f:	48 c1 e5 04          	shl    $0x4,%rbp
    9163:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    9168:	49 89 44 2d 10       	mov    %rax,0x10(%r13,%rbp,1)
    916d:	eb 46                	jmp    91b5 <fwp_p_map_insert+0xc5>
    916f:	49 89 ec             	mov    %rbp,%r12
    9172:	49 c1 e4 04          	shl    $0x4,%r12
    9176:	48 89 df             	mov    %rbx,%rdi
    9179:	4c 89 f6             	mov    %r14,%rsi
    917c:	4c 89 e2             	mov    %r12,%rdx
    917f:	e8 ac 91 ff ff       	call   2330 <memcpy@plt>
    9184:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    9189:	4b 89 44 25 08       	mov    %rax,0x8(%r13,%r12,1)
    918e:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    9193:	4b 89 44 25 10       	mov    %rax,0x10(%r13,%r12,1)
    9198:	4a 8d 3c 23          	lea    (%rbx,%r12,1),%rdi
    919c:	48 83 c7 10          	add    $0x10,%rdi
    91a0:	4d 01 f4             	add    %r14,%r12
    91a3:	49 29 ef             	sub    %rbp,%r15
    91a6:	49 c1 e7 04          	shl    $0x4,%r15
    91aa:	4c 89 e6             	mov    %r12,%rsi
    91ad:	4c 89 fa             	mov    %r15,%rdx
    91b0:	e8 7b 91 ff ff       	call   2330 <memcpy@plt>
    91b5:	4c 89 e8             	mov    %r13,%rax
    91b8:	48 83 c4 18          	add    $0x18,%rsp
    91bc:	5b                   	pop    %rbx
    91bd:	41 5c                	pop    %r12
    91bf:	41 5d                	pop    %r13
    91c1:	41 5e                	pop    %r14
    91c3:	41 5f                	pop    %r15
    91c5:	5d                   	pop    %rbp
    91c6:	c3                   	ret
    91c7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    91ce:	00 00 

00000000000091d0 <fwp_valid_int>:
    91d0:	31 c0                	xor    %eax,%eax
    91d2:	48 85 f6             	test   %rsi,%rsi
    91d5:	74 32                	je     9209 <fwp_valid_int+0x39>
    91d7:	0f b6 17             	movzbl (%rdi),%edx
    91da:	80 c2 d5             	add    $0xd5,%dl
    91dd:	31 c9                	xor    %ecx,%ecx
    91df:	f6 c2 fd             	test   $0xfd,%dl
    91e2:	0f 94 c1             	sete   %cl
    91e5:	48 39 f1             	cmp    %rsi,%rcx
    91e8:	74 1f                	je     9209 <fwp_valid_int+0x39>
    91ea:	73 18                	jae    9204 <fwp_valid_int+0x34>
    91ec:	0f 1f 40 00          	nopl   0x0(%rax)
    91f0:	0f b6 14 0f          	movzbl (%rdi,%rcx,1),%edx
    91f4:	80 c2 c6             	add    $0xc6,%dl
    91f7:	80 fa f5             	cmp    $0xf5,%dl
    91fa:	76 0d                	jbe    9209 <fwp_valid_int+0x39>
    91fc:	48 ff c1             	inc    %rcx
    91ff:	48 39 ce             	cmp    %rcx,%rsi
    9202:	75 ec                	jne    91f0 <fwp_valid_int+0x20>
    9204:	b8 01 00 00 00       	mov    $0x1,%eax
    9209:	c3                   	ret
    920a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000009210 <tp_record_body>:
    9210:	55                   	push   %rbp
    9211:	41 57                	push   %r15
    9213:	41 56                	push   %r14
    9215:	41 55                	push   %r13
    9217:	41 54                	push   %r12
    9219:	53                   	push   %rbx
    921a:	48 81 ec 28 01 00 00 	sub    $0x128,%rsp
    9221:	48 89 d3             	mov    %rdx,%rbx
    9224:	49 89 f5             	mov    %rsi,%r13
    9227:	48 89 fd             	mov    %rdi,%rbp
    922a:	48 63 46 10          	movslq 0x10(%rsi),%rax
    922e:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    9235:	00 
    9236:	e8 f5 c4 ff ff       	call   5730 <fwp_alloc>
    923b:	49 89 c7             	mov    %rax,%r15
    923e:	49 63 7d 10          	movslq 0x10(%r13),%rdi
    9242:	48 ff c7             	inc    %rdi
    9245:	e8 f6 d5 ff ff       	call   6840 <fwp_alloc_leaf>
    924a:	49 89 c4             	mov    %rax,%r12
    924d:	49 63 55 10          	movslq 0x10(%r13),%rdx
    9251:	48 ff c2             	inc    %rdx
    9254:	45 31 f6             	xor    %r14d,%r14d
    9257:	48 89 c7             	mov    %rax,%rdi
    925a:	31 f6                	xor    %esi,%esi
    925c:	e8 af 8f ff ff       	call   2210 <memset@plt>
    9261:	48 8d 35 f5 60 00 00 	lea    0x60f5(%rip),%rsi        # f35d <exec_in_fp0+0xd0d>
    9268:	48 89 ef             	mov    %rbp,%rdi
    926b:	e8 40 fb ff ff       	call   8db0 <tp_eat>
    9270:	85 c0                	test   %eax,%eax
    9272:	0f 84 3b 01 00 00    	je     93b3 <tp_record_body+0x1a3>
    9278:	48 8d 35 12 61 00 00 	lea    0x6112(%rip),%rsi        # f391 <exec_in_fp0+0xd41>
    927f:	48 89 ef             	mov    %rbp,%rdi
    9282:	e8 29 fb ff ff       	call   8db0 <tp_eat>
    9287:	85 c0                	test   %eax,%eax
    9289:	74 3e                	je     92c9 <tp_record_body+0xb9>
    928b:	41 8b 7d 10          	mov    0x10(%r13),%edi
    928f:	85 ff                	test   %edi,%edi
    9291:	7e 20                	jle    92b3 <tp_record_body+0xa3>
    9293:	45 31 f6             	xor    %r14d,%r14d
    9296:	31 c0                	xor    %eax,%eax
    9298:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    929f:	00 
    92a0:	41 80 3c 04 00       	cmpb   $0x0,(%r12,%rax,1)
    92a5:	0f 84 08 01 00 00    	je     93b3 <tp_record_body+0x1a3>
    92ab:	48 ff c0             	inc    %rax
    92ae:	48 39 c7             	cmp    %rax,%rdi
    92b1:	75 ed                	jne    92a0 <tp_record_body+0x90>
    92b3:	4c 89 fe             	mov    %r15,%rsi
    92b6:	e8 55 9e ff ff       	call   3110 <fwp_record>
    92bb:	48 89 03             	mov    %rax,(%rbx)
    92be:	41 be 01 00 00 00    	mov    $0x1,%r14d
    92c4:	e9 ea 00 00 00       	jmp    93b3 <tp_record_body+0x1a3>
    92c9:	48 89 1c 24          	mov    %rbx,(%rsp)
    92cd:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    92d2:	48 89 ef             	mov    %rbp,%rdi
    92d5:	e8 06 01 00 00       	call   93e0 <tp_ident>
    92da:	41 8b 45 10          	mov    0x10(%r13),%eax
    92de:	85 c0                	test   %eax,%eax
    92e0:	0f 8e ca 00 00 00    	jle    93b0 <tp_record_body+0x1a0>
    92e6:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    92eb:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    92f0:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
    92f5:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    92fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9300:	4d 8b 65 18          	mov    0x18(%r13),%r12
    9304:	41 89 c7             	mov    %eax,%r15d
    9307:	41 be ff ff ff ff    	mov    $0xffffffff,%r14d
    930d:	31 ed                	xor    %ebp,%ebp
    930f:	90                   	nop
    9310:	49 8b 3c ec          	mov    (%r12,%rbp,8),%rdi
    9314:	48 89 de             	mov    %rbx,%rsi
    9317:	e8 b4 8f ff ff       	call   22d0 <strcmp@plt>
    931c:	85 c0                	test   %eax,%eax
    931e:	44 0f 44 f5          	cmove  %ebp,%r14d
    9322:	48 ff c5             	inc    %rbp
    9325:	49 39 ef             	cmp    %rbp,%r15
    9328:	75 e6                	jne    9310 <tp_record_body+0x100>
    932a:	45 85 f6             	test   %r14d,%r14d
    932d:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    9332:	4c 8b 64 24 10       	mov    0x10(%rsp),%r12
    9337:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    933c:	78 72                	js     93b0 <tp_record_body+0x1a0>
    933e:	48 89 ef             	mov    %rbp,%rdi
    9341:	48 8d 35 6b 5f 00 00 	lea    0x5f6b(%rip),%rsi        # f2b3 <exec_in_fp0+0xc63>
    9348:	e8 63 fa ff ff       	call   8db0 <tp_eat>
    934d:	85 c0                	test   %eax,%eax
    934f:	74 5f                	je     93b0 <tp_record_body+0x1a0>
    9351:	49 8b 45 20          	mov    0x20(%r13),%rax
    9355:	45 89 f6             	mov    %r14d,%r14d
    9358:	4a 8b 34 f0          	mov    (%rax,%r14,8),%rsi
    935c:	4b 8d 0c f7          	lea    (%r15,%r14,8),%rcx
    9360:	48 89 ef             	mov    %rbp,%rdi
    9363:	31 d2                	xor    %edx,%edx
    9365:	e8 56 ed ff ff       	call   80c0 <tp_value>
    936a:	85 c0                	test   %eax,%eax
    936c:	74 42                	je     93b0 <tp_record_body+0x1a0>
    936e:	43 c6 04 34 01       	movb   $0x1,(%r12,%r14,1)
    9373:	48 89 ef             	mov    %rbp,%rdi
    9376:	48 8d 35 14 60 00 00 	lea    0x6014(%rip),%rsi        # f391 <exec_in_fp0+0xd41>
    937d:	e8 2e fa ff ff       	call   8db0 <tp_eat>
    9382:	85 c0                	test   %eax,%eax
    9384:	75 42                	jne    93c8 <tp_record_body+0x1b8>
    9386:	48 89 ef             	mov    %rbp,%rdi
    9389:	48 8d 35 0d 5f 00 00 	lea    0x5f0d(%rip),%rsi        # f29d <exec_in_fp0+0xc4d>
    9390:	e8 1b fa ff ff       	call   8db0 <tp_eat>
    9395:	85 c0                	test   %eax,%eax
    9397:	74 17                	je     93b0 <tp_record_body+0x1a0>
    9399:	48 89 ef             	mov    %rbp,%rdi
    939c:	48 89 de             	mov    %rbx,%rsi
    939f:	e8 3c 00 00 00       	call   93e0 <tp_ident>
    93a4:	41 8b 45 10          	mov    0x10(%r13),%eax
    93a8:	85 c0                	test   %eax,%eax
    93aa:	0f 8f 50 ff ff ff    	jg     9300 <tp_record_body+0xf0>
    93b0:	45 31 f6             	xor    %r14d,%r14d
    93b3:	44 89 f0             	mov    %r14d,%eax
    93b6:	48 81 c4 28 01 00 00 	add    $0x128,%rsp
    93bd:	5b                   	pop    %rbx
    93be:	41 5c                	pop    %r12
    93c0:	41 5d                	pop    %r13
    93c2:	41 5e                	pop    %r14
    93c4:	41 5f                	pop    %r15
    93c6:	5d                   	pop    %rbp
    93c7:	c3                   	ret
    93c8:	48 8b 1c 24          	mov    (%rsp),%rbx
    93cc:	e9 ba fe ff ff       	jmp    928b <tp_record_body+0x7b>
    93d1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    93d8:	0f 1f 84 00 00 00 00 
    93df:	00 

00000000000093e0 <tp_ident>:
    93e0:	41 56                	push   %r14
    93e2:	53                   	push   %rbx
    93e3:	50                   	push   %rax
    93e4:	48 89 f3             	mov    %rsi,%rbx
    93e7:	49 89 fe             	mov    %rdi,%r14
    93ea:	e8 01 f6 ff ff       	call   89f0 <tp_ws>
    93ef:	49 8b 46 10          	mov    0x10(%r14),%rax
    93f3:	49 8b 36             	mov    (%r14),%rsi
    93f6:	49 8b 56 08          	mov    0x8(%r14),%rdx
    93fa:	48 89 c1             	mov    %rax,%rcx
    93fd:	48 39 d0             	cmp    %rdx,%rax
    9400:	73 63                	jae    9465 <tp_ident+0x85>
    9402:	48 bf 03 00 00 00 00 	movabs $0x4000000000003,%rdi
    9409:	00 04 00 
    940c:	48 89 c1             	mov    %rax,%rcx
    940f:	eb 1b                	jmp    942c <tp_ident+0x4c>
    9411:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9418:	0f 1f 84 00 00 00 00 
    941f:	00 
    9420:	48 ff c1             	inc    %rcx
    9423:	49 89 4e 10          	mov    %rcx,0x10(%r14)
    9427:	48 39 ca             	cmp    %rcx,%rdx
    942a:	74 36                	je     9462 <tp_ident+0x82>
    942c:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
    9431:	45 8d 48 d0          	lea    -0x30(%r8),%r9d
    9435:	41 80 f9 0a          	cmp    $0xa,%r9b
    9439:	72 e5                	jb     9420 <tp_ident+0x40>
    943b:	45 89 c1             	mov    %r8d,%r9d
    943e:	41 80 e1 df          	and    $0xdf,%r9b
    9442:	41 80 c1 bf          	add    $0xbf,%r9b
    9446:	41 80 f9 1a          	cmp    $0x1a,%r9b
    944a:	72 d4                	jb     9420 <tp_ident+0x40>
    944c:	45 0f b6 c0          	movzbl %r8b,%r8d
    9450:	41 83 c0 d3          	add    $0xffffffd3,%r8d
    9454:	41 83 f8 32          	cmp    $0x32,%r8d
    9458:	77 0b                	ja     9465 <tp_ident+0x85>
    945a:	4c 0f a3 c7          	bt     %r8,%rdi
    945e:	72 c0                	jb     9420 <tp_ident+0x40>
    9460:	eb 03                	jmp    9465 <tp_ident+0x85>
    9462:	48 89 d1             	mov    %rdx,%rcx
    9465:	48 29 c1             	sub    %rax,%rcx
    9468:	48 81 f9 ff 00 00 00 	cmp    $0xff,%rcx
    946f:	41 be ff 00 00 00    	mov    $0xff,%r14d
    9475:	4c 0f 42 f1          	cmovb  %rcx,%r14
    9479:	48 01 c6             	add    %rax,%rsi
    947c:	48 89 df             	mov    %rbx,%rdi
    947f:	4c 89 f2             	mov    %r14,%rdx
    9482:	e8 a9 8e ff ff       	call   2330 <memcpy@plt>
    9487:	42 c6 04 33 00       	movb   $0x0,(%rbx,%r14,1)
    948c:	48 83 c4 08          	add    $0x8,%rsp
    9490:	5b                   	pop    %rbx
    9491:	41 5e                	pop    %r14
    9493:	c3                   	ret
    9494:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    949b:	00 00 00 00 00 

00000000000094a0 <tp_atom>:
    94a0:	41 57                	push   %r15
    94a2:	41 56                	push   %r14
    94a4:	53                   	push   %rbx
    94a5:	49 89 d6             	mov    %rdx,%r14
    94a8:	49 89 f7             	mov    %rsi,%r15
    94ab:	48 89 fb             	mov    %rdi,%rbx
    94ae:	e8 3d f5 ff ff       	call   89f0 <tp_ws>
    94b3:	41 83 3f 10          	cmpl   $0x10,(%r15)
    94b7:	75 07                	jne    94c0 <tp_atom+0x20>
    94b9:	49 83 7f 08 00       	cmpq   $0x0,0x8(%r15)
    94be:	74 5e                	je     951e <tp_atom+0x7e>
    94c0:	31 c0                	xor    %eax,%eax
    94c2:	48 8b 4b 10          	mov    0x10(%rbx),%rcx
    94c6:	48 3b 4b 08          	cmp    0x8(%rbx),%rcx
    94ca:	73 0e                	jae    94da <tp_atom+0x3a>
    94cc:	48 8b 13             	mov    (%rbx),%rdx
    94cf:	80 3c 0a 28          	cmpb   $0x28,(%rdx,%rcx,1)
    94d3:	0f 95 c2             	setne  %dl
    94d6:	08 c2                	or     %al,%dl
    94d8:	74 15                	je     94ef <tp_atom+0x4f>
    94da:	48 89 df             	mov    %rbx,%rdi
    94dd:	4c 89 fe             	mov    %r15,%rsi
    94e0:	31 d2                	xor    %edx,%edx
    94e2:	4c 89 f1             	mov    %r14,%rcx
    94e5:	5b                   	pop    %rbx
    94e6:	41 5e                	pop    %r14
    94e8:	41 5f                	pop    %r15
    94ea:	e9 d1 eb ff ff       	jmp    80c0 <tp_value>
    94ef:	48 ff c1             	inc    %rcx
    94f2:	48 89 4b 10          	mov    %rcx,0x10(%rbx)
    94f6:	48 89 df             	mov    %rbx,%rdi
    94f9:	4c 89 fe             	mov    %r15,%rsi
    94fc:	31 d2                	xor    %edx,%edx
    94fe:	4c 89 f1             	mov    %r14,%rcx
    9501:	e8 ba eb ff ff       	call   80c0 <tp_value>
    9506:	85 c0                	test   %eax,%eax
    9508:	74 25                	je     952f <tp_atom+0x8f>
    950a:	48 8d 35 4f 5e 00 00 	lea    0x5e4f(%rip),%rsi        # f360 <exec_in_fp0+0xd10>
    9511:	48 89 df             	mov    %rbx,%rdi
    9514:	5b                   	pop    %rbx
    9515:	41 5e                	pop    %r14
    9517:	41 5f                	pop    %r15
    9519:	e9 92 f8 ff ff       	jmp    8db0 <tp_eat>
    951e:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    9523:	74 12                	je     9537 <tp_atom+0x97>
    9525:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
    952a:	0f 95 c0             	setne  %al
    952d:	eb 93                	jmp    94c2 <tp_atom+0x22>
    952f:	31 c0                	xor    %eax,%eax
    9531:	5b                   	pop    %rbx
    9532:	41 5e                	pop    %r14
    9534:	41 5f                	pop    %r15
    9536:	c3                   	ret
    9537:	b0 01                	mov    $0x1,%al
    9539:	eb 87                	jmp    94c2 <tp_atom+0x22>
    953b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000009540 <fwp_cstr>:
    9540:	53                   	push   %rbx
    9541:	48 89 fb             	mov    %rdi,%rbx
    9544:	e8 27 8c ff ff       	call   2170 <strlen@plt>
    9549:	48 89 df             	mov    %rbx,%rdi
    954c:	48 89 c6             	mov    %rax,%rsi
    954f:	5b                   	pop    %rbx
    9550:	e9 ab e4 ff ff       	jmp    7a00 <fwp_str_new>
    9555:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    955c:	00 00 00 00 

0000000000009560 <fwp_p_parse_int>:
    9560:	55                   	push   %rbp
    9561:	41 57                	push   %r15
    9563:	41 56                	push   %r14
    9565:	41 55                	push   %r13
    9567:	41 54                	push   %r12
    9569:	53                   	push   %rbx
    956a:	48 83 ec 18          	sub    $0x18,%rsp
    956e:	89 d3                	mov    %edx,%ebx
    9570:	89 f5                	mov    %esi,%ebp
    9572:	49 89 fe             	mov    %rdi,%r14
    9575:	4c 8b 3f             	mov    (%rdi),%r15
    9578:	49 83 c6 08          	add    $0x8,%r14
    957c:	4c 89 f7             	mov    %r14,%rdi
    957f:	4c 89 fe             	mov    %r15,%rsi
    9582:	e8 49 fc ff ff       	call   91d0 <fwp_valid_int>
    9587:	85 c0                	test   %eax,%eax
    9589:	0f 84 1a 01 00 00    	je     96a9 <fwp_p_parse_int+0x149>
    958f:	41 0f b6 06          	movzbl (%r14),%eax
    9593:	31 ff                	xor    %edi,%edi
    9595:	3c 2d                	cmp    $0x2d,%al
    9597:	0f 94 c1             	sete   %cl
    959a:	3c 2b                	cmp    $0x2b,%al
    959c:	0f 94 c0             	sete   %al
    959f:	08 c8                	or     %cl,%al
    95a1:	44 0f b6 e0          	movzbl %al,%r12d
    95a5:	4d 39 e7             	cmp    %r12,%r15
    95a8:	0f 86 d0 00 00 00    	jbe    967e <fwp_p_parse_int+0x11e>
    95ae:	88 4c 24 07          	mov    %cl,0x7(%rsp)
    95b2:	89 6c 24 08          	mov    %ebp,0x8(%rsp)
    95b6:	89 5c 24 0c          	mov    %ebx,0xc(%rsp)
    95ba:	bf 0a 00 00 00       	mov    $0xa,%edi
    95bf:	48 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rbx
    95c6:	cc cc cc 
    95c9:	48 bd cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbp
    95d0:	cc cc cc 
    95d3:	31 f6                	xor    %esi,%esi
    95d5:	45 31 db             	xor    %r11d,%r11d
    95d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    95df:	00 
    95e0:	4d 89 dd             	mov    %r11,%r13
    95e3:	49 89 f0             	mov    %rsi,%r8
    95e6:	48 89 f0             	mov    %rsi,%rax
    95e9:	48 f7 e7             	mul    %rdi
    95ec:	4b 8d 0c 9b          	lea    (%r11,%r11,4),%rcx
    95f0:	48 8d 0c 4a          	lea    (%rdx,%rcx,2),%rcx
    95f4:	43 0f be 14 26       	movsbl (%r14,%r12,1),%edx
    95f9:	83 c2 d0             	add    $0xffffffd0,%edx
    95fc:	48 63 d2             	movslq %edx,%rdx
    95ff:	49 89 d3             	mov    %rdx,%r11
    9602:	49 c1 fb 3f          	sar    $0x3f,%r11
    9606:	48 89 c6             	mov    %rax,%rsi
    9609:	48 01 d6             	add    %rdx,%rsi
    960c:	49 11 cb             	adc    %rcx,%r11
    960f:	4d 89 d9             	mov    %r11,%r9
    9612:	49 0f a4 f1 3f       	shld   $0x3f,%rsi,%r9
    9617:	4c 89 d9             	mov    %r11,%rcx
    961a:	48 d1 e9             	shr    $1,%rcx
    961d:	4d 89 ca             	mov    %r9,%r10
    9620:	49 01 ca             	add    %rcx,%r10
    9623:	49 83 d2 00          	adc    $0x0,%r10
    9627:	4c 89 d0             	mov    %r10,%rax
    962a:	48 f7 e3             	mul    %rbx
    962d:	48 c1 ea 02          	shr    $0x2,%rdx
    9631:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9635:	49 29 c2             	sub    %rax,%r10
    9638:	4d 29 d1             	sub    %r10,%r9
    963b:	48 83 d9 00          	sbb    $0x0,%rcx
    963f:	4d 89 ca             	mov    %r9,%r10
    9642:	4c 0f af d5          	imul   %rbp,%r10
    9646:	4c 89 c8             	mov    %r9,%rax
    9649:	48 f7 e3             	mul    %rbx
    964c:	4c 01 d2             	add    %r10,%rdx
    964f:	48 0f af cb          	imul   %rbx,%rcx
    9653:	48 01 d1             	add    %rdx,%rcx
    9656:	4c 31 e9             	xor    %r13,%rcx
    9659:	4c 31 c0             	xor    %r8,%rax
    965c:	48 09 c8             	or     %rcx,%rax
    965f:	75 48                	jne    96a9 <fwp_p_parse_int+0x149>
    9661:	49 ff c4             	inc    %r12
    9664:	4d 39 e7             	cmp    %r12,%r15
    9667:	0f 85 73 ff ff ff    	jne    95e0 <fwp_p_parse_int+0x80>
    966d:	8b 5c 24 0c          	mov    0xc(%rsp),%ebx
    9671:	8b 6c 24 08          	mov    0x8(%rsp),%ebp
    9675:	31 ff                	xor    %edi,%edi
    9677:	0f b6 4c 24 07       	movzbl 0x7(%rsp),%ecx
    967c:	eb 05                	jmp    9683 <fwp_p_parse_int+0x123>
    967e:	31 f6                	xor    %esi,%esi
    9680:	45 31 db             	xor    %r11d,%r11d
    9683:	40 88 cf             	mov    %cl,%dil
    9686:	4c 8d 4c 24 10       	lea    0x10(%rsp),%r9
    968b:	4c 89 da             	mov    %r11,%rdx
    968e:	89 e9                	mov    %ebp,%ecx
    9690:	41 89 d8             	mov    %ebx,%r8d
    9693:	e8 28 00 00 00       	call   96c0 <fwp_int_in_range>
    9698:	48 85 c0             	test   %rax,%rax
    969b:	74 0c                	je     96a9 <fwp_p_parse_int+0x149>
    969d:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    96a2:	e8 99 00 00 00       	call   9740 <fwp_some>
    96a7:	eb 02                	jmp    96ab <fwp_p_parse_int+0x14b>
    96a9:	31 c0                	xor    %eax,%eax
    96ab:	48 83 c4 18          	add    $0x18,%rsp
    96af:	5b                   	pop    %rbx
    96b0:	41 5c                	pop    %r12
    96b2:	41 5d                	pop    %r13
    96b4:	41 5e                	pop    %r14
    96b6:	41 5f                	pop    %r15
    96b8:	5d                   	pop    %rbp
    96b9:	c3                   	ret
    96ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000096c0 <fwp_int_in_range>:
    96c0:	53                   	push   %rbx
    96c1:	83 f9 09             	cmp    $0x9,%ecx
    96c4:	75 24                	jne    96ea <fwp_int_in_range+0x2a>
    96c6:	85 ff                	test   %edi,%edi
    96c8:	74 08                	je     96d2 <fwp_int_in_range+0x12>
    96ca:	48 89 f0             	mov    %rsi,%rax
    96cd:	48 09 d0             	or     %rdx,%rax
    96d0:	75 3c                	jne    970e <fwp_int_in_range+0x4e>
    96d2:	48 89 f7             	mov    %rsi,%rdi
    96d5:	48 89 d6             	mov    %rdx,%rsi
    96d8:	4c 89 cb             	mov    %r9,%rbx
    96db:	e8 80 00 00 00       	call   9760 <fwp_box_u128>
    96e0:	48 89 03             	mov    %rax,(%rbx)
    96e3:	b8 01 00 00 00       	mov    $0x1,%eax
    96e8:	5b                   	pop    %rbx
    96e9:	c3                   	ret
    96ea:	48 89 f0             	mov    %rsi,%rax
    96ed:	48 f7 d8             	neg    %rax
    96f0:	48 b8 00 00 00 00 00 	movabs $0x8000000000000000,%rax
    96f7:	00 00 80 
    96fa:	49 89 c2             	mov    %rax,%r10
    96fd:	49 19 d2             	sbb    %rdx,%r10
    9700:	72 0c                	jb     970e <fwp_int_in_range+0x4e>
    9702:	85 ff                	test   %edi,%edi
    9704:	75 0c                	jne    9712 <fwp_int_in_range+0x52>
    9706:	48 31 d0             	xor    %rdx,%rax
    9709:	48 09 f0             	or     %rsi,%rax
    970c:	75 04                	jne    9712 <fwp_int_in_range+0x52>
    970e:	31 c0                	xor    %eax,%eax
    9710:	5b                   	pop    %rbx
    9711:	c3                   	ret
    9712:	31 c0                	xor    %eax,%eax
    9714:	49 89 f2             	mov    %rsi,%r10
    9717:	49 f7 da             	neg    %r10
    971a:	48 19 d0             	sbb    %rdx,%rax
    971d:	85 ff                	test   %edi,%edi
    971f:	4c 0f 44 d6          	cmove  %rsi,%r10
    9723:	48 0f 44 c2          	cmove  %rdx,%rax
    9727:	4c 89 d7             	mov    %r10,%rdi
    972a:	48 89 c6             	mov    %rax,%rsi
    972d:	89 ca                	mov    %ecx,%edx
    972f:	44 89 c1             	mov    %r8d,%ecx
    9732:	4d 89 c8             	mov    %r9,%r8
    9735:	e8 56 00 00 00       	call   9790 <fwp_int_fits>
    973a:	89 c0                	mov    %eax,%eax
    973c:	5b                   	pop    %rbx
    973d:	c3                   	ret
    973e:	66 90                	xchg   %ax,%ax

0000000000009740 <fwp_some>:
    9740:	50                   	push   %rax
    9741:	48 89 3c 24          	mov    %rdi,(%rsp)
    9745:	48 89 e2             	mov    %rsp,%rdx
    9748:	bf 01 00 00 00       	mov    $0x1,%edi
    974d:	be 01 00 00 00       	mov    $0x1,%esi
    9752:	e8 d9 99 ff ff       	call   3130 <fwp_data>
    9757:	59                   	pop    %rcx
    9758:	c3                   	ret
    9759:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000009760 <fwp_box_u128>:
    9760:	41 56                	push   %r14
    9762:	53                   	push   %rbx
    9763:	50                   	push   %rax
    9764:	48 89 f3             	mov    %rsi,%rbx
    9767:	49 89 fe             	mov    %rdi,%r14
    976a:	bf 10 00 00 00       	mov    $0x10,%edi
    976f:	e8 cc d0 ff ff       	call   6840 <fwp_alloc_leaf>
    9774:	48 89 58 08          	mov    %rbx,0x8(%rax)
    9778:	4c 89 30             	mov    %r14,(%rax)
    977b:	48 83 c4 08          	add    $0x8,%rsp
    977f:	5b                   	pop    %rbx
    9780:	41 5e                	pop    %r14
    9782:	c3                   	ret
    9783:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    978a:	84 00 00 00 00 00 

0000000000009790 <fwp_int_fits>:
    9790:	41 57                	push   %r15
    9792:	41 56                	push   %r14
    9794:	53                   	push   %rbx
    9795:	31 c0                	xor    %eax,%eax
    9797:	83 fa 14             	cmp    $0x14,%edx
    979a:	0f 87 02 01 00 00    	ja     98a2 <fwp_int_fits+0x112>
    97a0:	89 d2                	mov    %edx,%edx
    97a2:	4c 8d 0d ef 4a 00 00 	lea    0x4aef(%rip),%r9        # e298 <_IO_stdin_used+0x298>
    97a9:	49 63 14 91          	movslq (%r9,%rdx,4),%rdx
    97ad:	4c 01 ca             	add    %r9,%rdx
    97b0:	ff e2                	jmp    *%rdx
    97b2:	48 89 f9             	mov    %rdi,%rcx
    97b5:	48 83 c1 80          	add    $0xffffffffffffff80,%rcx
    97b9:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    97bd:	48 81 f9 00 ff ff ff 	cmp    $0xffffffffffffff00,%rcx
    97c4:	eb 3b                	jmp    9801 <fwp_int_fits+0x71>
    97c6:	48 89 f9             	mov    %rdi,%rcx
    97c9:	48 81 c1 00 00 00 80 	add    $0xffffffff80000000,%rcx
    97d0:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    97d4:	48 ba 00 00 00 00 ff 	movabs $0xffffffff00000000,%rdx
    97db:	ff ff ff 
    97de:	48 39 d1             	cmp    %rdx,%rcx
    97e1:	eb 1e                	jmp    9801 <fwp_int_fits+0x71>
    97e3:	31 c0                	xor    %eax,%eax
    97e5:	b9 ff 00 00 00       	mov    $0xff,%ecx
    97ea:	eb 2b                	jmp    9817 <fwp_int_fits+0x87>
    97ec:	48 89 f9             	mov    %rdi,%rcx
    97ef:	48 81 c1 00 80 ff ff 	add    $0xffffffffffff8000,%rcx
    97f6:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    97fa:	48 81 f9 00 00 ff ff 	cmp    $0xffffffffffff0000,%rcx
    9801:	48 83 de ff          	sbb    $0xffffffffffffffff,%rsi
    9805:	0f 83 8f 00 00 00    	jae    989a <fwp_int_fits+0x10a>
    980b:	e9 92 00 00 00       	jmp    98a2 <fwp_int_fits+0x112>
    9810:	31 c0                	xor    %eax,%eax
    9812:	b9 ff ff 00 00       	mov    $0xffff,%ecx
    9817:	48 39 f9             	cmp    %rdi,%rcx
    981a:	b9 00 00 00 00       	mov    $0x0,%ecx
    981f:	48 19 f1             	sbb    %rsi,%rcx
    9822:	73 76                	jae    989a <fwp_int_fits+0x10a>
    9824:	eb 7c                	jmp    98a2 <fwp_int_fits+0x112>
    9826:	48 89 f9             	mov    %rdi,%rcx
    9829:	48 c1 e9 20          	shr    $0x20,%rcx
    982d:	48 09 f1             	or     %rsi,%rcx
    9830:	74 68                	je     989a <fwp_int_fits+0x10a>
    9832:	eb 6e                	jmp    98a2 <fwp_int_fits+0x112>
    9834:	48 b9 00 00 00 00 00 	movabs $0x8000000000000000,%rcx
    983b:	00 00 80 
    983e:	48 01 f9             	add    %rdi,%rcx
    9841:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    9845:	48 83 fe ff          	cmp    $0xffffffffffffffff,%rsi
    9849:	74 4f                	je     989a <fwp_int_fits+0x10a>
    984b:	eb 55                	jmp    98a2 <fwp_int_fits+0x112>
    984d:	4c 89 c3             	mov    %r8,%rbx
    9850:	e8 5b 00 00 00       	call   98b0 <fwp_box_i128>
    9855:	49 89 d8             	mov    %rbx,%r8
    9858:	48 89 c7             	mov    %rax,%rdi
    985b:	eb 3d                	jmp    989a <fwp_int_fits+0x10a>
    985d:	4c 89 c3             	mov    %r8,%rbx
    9860:	49 89 fe             	mov    %rdi,%r14
    9863:	89 cf                	mov    %ecx,%edi
    9865:	49 89 f7             	mov    %rsi,%r15
    9868:	e8 73 00 00 00       	call   98e0 <fwp_tint_max>
    986d:	48 89 c1             	mov    %rax,%rcx
    9870:	31 c0                	xor    %eax,%eax
    9872:	49 89 c8             	mov    %rcx,%r8
    9875:	49 f7 d8             	neg    %r8
    9878:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    987e:	49 19 d1             	sbb    %rdx,%r9
    9881:	4c 39 f1             	cmp    %r14,%rcx
    9884:	4c 19 fa             	sbb    %r15,%rdx
    9887:	7c 19                	jl     98a2 <fwp_int_fits+0x112>
    9889:	4c 89 fe             	mov    %r15,%rsi
    988c:	4c 89 f7             	mov    %r14,%rdi
    988f:	4d 39 c6             	cmp    %r8,%r14
    9892:	4c 19 ce             	sbb    %r9,%rsi
    9895:	49 89 d8             	mov    %rbx,%r8
    9898:	7c 08                	jl     98a2 <fwp_int_fits+0x112>
    989a:	49 89 38             	mov    %rdi,(%r8)
    989d:	b8 01 00 00 00       	mov    $0x1,%eax
    98a2:	5b                   	pop    %rbx
    98a3:	41 5e                	pop    %r14
    98a5:	41 5f                	pop    %r15
    98a7:	c3                   	ret
    98a8:	48 85 f6             	test   %rsi,%rsi
    98ab:	74 ed                	je     989a <fwp_int_fits+0x10a>
    98ad:	eb f3                	jmp    98a2 <fwp_int_fits+0x112>
    98af:	90                   	nop

00000000000098b0 <fwp_box_i128>:
    98b0:	41 56                	push   %r14
    98b2:	53                   	push   %rbx
    98b3:	50                   	push   %rax
    98b4:	48 89 f3             	mov    %rsi,%rbx
    98b7:	49 89 fe             	mov    %rdi,%r14
    98ba:	bf 10 00 00 00       	mov    $0x10,%edi
    98bf:	e8 7c cf ff ff       	call   6840 <fwp_alloc_leaf>
    98c4:	48 89 58 08          	mov    %rbx,0x8(%rax)
    98c8:	4c 89 30             	mov    %r14,(%rax)
    98cb:	48 83 c4 08          	add    $0x8,%rsp
    98cf:	5b                   	pop    %rbx
    98d0:	41 5e                	pop    %r14
    98d2:	c3                   	ret
    98d3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    98da:	84 00 00 00 00 00 

00000000000098e0 <fwp_tint_max>:
    98e0:	85 ff                	test   %edi,%edi
    98e2:	7e 27                	jle    990b <fwp_tint_max+0x2b>
    98e4:	8d 47 ff             	lea    -0x1(%rdi),%eax
    98e7:	83 f8 4f             	cmp    $0x4f,%eax
    98ea:	41 b8 4f 00 00 00    	mov    $0x4f,%r8d
    98f0:	44 0f 42 c0          	cmovb  %eax,%r8d
    98f4:	41 ff c0             	inc    %r8d
    98f7:	44 89 c6             	mov    %r8d,%esi
    98fa:	83 e6 07             	and    $0x7,%esi
    98fd:	83 ff 08             	cmp    $0x8,%edi
    9900:	73 11                	jae    9913 <fwp_tint_max+0x33>
    9902:	b8 01 00 00 00       	mov    $0x1,%eax
    9907:	31 c9                	xor    %ecx,%ecx
    9909:	eb 38                	jmp    9943 <fwp_tint_max+0x63>
    990b:	31 c0                	xor    %eax,%eax
    990d:	31 c9                	xor    %ecx,%ecx
    990f:	48 89 ca             	mov    %rcx,%rdx
    9912:	c3                   	ret
    9913:	41 81 e0 f8 00 00 00 	and    $0xf8,%r8d
    991a:	b8 01 00 00 00       	mov    $0x1,%eax
    991f:	31 c9                	xor    %ecx,%ecx
    9921:	bf a1 19 00 00       	mov    $0x19a1,%edi
    9926:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    992d:	00 00 00 
    9930:	48 f7 e7             	mul    %rdi
    9933:	48 69 c9 a1 19 00 00 	imul   $0x19a1,%rcx,%rcx
    993a:	48 01 d1             	add    %rdx,%rcx
    993d:	41 83 c0 f8          	add    $0xfffffff8,%r8d
    9941:	75 ed                	jne    9930 <fwp_tint_max+0x50>
    9943:	85 f6                	test   %esi,%esi
    9945:	74 17                	je     995e <fwp_tint_max+0x7e>
    9947:	bf 03 00 00 00       	mov    $0x3,%edi
    994c:	0f 1f 40 00          	nopl   0x0(%rax)
    9950:	48 f7 e7             	mul    %rdi
    9953:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    9957:	48 01 d1             	add    %rdx,%rcx
    995a:	ff ce                	dec    %esi
    995c:	75 f2                	jne    9950 <fwp_tint_max+0x70>
    995e:	48 83 c0 ff          	add    $0xffffffffffffffff,%rax
    9962:	48 83 d1 ff          	adc    $0xffffffffffffffff,%rcx
    9966:	48 89 ca             	mov    %rcx,%rdx
    9969:	48 c1 ea 3f          	shr    $0x3f,%rdx
    996d:	48 01 c2             	add    %rax,%rdx
    9970:	48 89 d0             	mov    %rdx,%rax
    9973:	48 83 d1 00          	adc    $0x0,%rcx
    9977:	48 0f ac c8 01       	shrd   $0x1,%rcx,%rax
    997c:	48 d1 f9             	sar    $1,%rcx
    997f:	48 89 ca             	mov    %rcx,%rdx
    9982:	c3                   	ret
    9983:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    998a:	84 00 00 00 00 00 

0000000000009990 <fwp_valid_float>:
    9990:	48 85 f6             	test   %rsi,%rsi
    9993:	74 0e                	je     99a3 <fwp_valid_float+0x13>
    9995:	0f b6 07             	movzbl (%rdi),%eax
    9998:	04 d5                	add    $0xd5,%al
    999a:	31 d2                	xor    %edx,%edx
    999c:	a8 fd                	test   $0xfd,%al
    999e:	0f 94 c2             	sete   %dl
    99a1:	eb 02                	jmp    99a5 <fwp_valid_float+0x15>
    99a3:	31 d2                	xor    %edx,%edx
    99a5:	41 b1 01             	mov    $0x1,%r9b
    99a8:	49 89 d0             	mov    %rdx,%r8
    99ab:	48 39 f2             	cmp    %rsi,%rdx
    99ae:	73 1d                	jae    99cd <fwp_valid_float+0x3d>
    99b0:	42 0f b6 04 07       	movzbl (%rdi,%r8,1),%eax
    99b5:	8d 48 d0             	lea    -0x30(%rax),%ecx
    99b8:	80 f9 09             	cmp    $0x9,%cl
    99bb:	77 15                	ja     99d2 <fwp_valid_float+0x42>
    99bd:	49 ff c0             	inc    %r8
    99c0:	4c 39 c6             	cmp    %r8,%rsi
    99c3:	75 eb                	jne    99b0 <fwp_valid_float+0x20>
    99c5:	49 89 f0             	mov    %rsi,%r8
    99c8:	48 89 f1             	mov    %rsi,%rcx
    99cb:	eb 38                	jmp    9a05 <fwp_valid_float+0x75>
    99cd:	48 89 d1             	mov    %rdx,%rcx
    99d0:	eb 33                	jmp    9a05 <fwp_valid_float+0x75>
    99d2:	3c 2e                	cmp    $0x2e,%al
    99d4:	75 2c                	jne    9a02 <fwp_valid_float+0x72>
    99d6:	49 8d 48 01          	lea    0x1(%r8),%rcx
    99da:	48 39 f1             	cmp    %rsi,%rcx
    99dd:	73 16                	jae    99f5 <fwp_valid_float+0x65>
    99df:	90                   	nop
    99e0:	0f b6 04 0f          	movzbl (%rdi,%rcx,1),%eax
    99e4:	04 d0                	add    $0xd0,%al
    99e6:	3c 09                	cmp    $0x9,%al
    99e8:	77 0b                	ja     99f5 <fwp_valid_float+0x65>
    99ea:	48 ff c1             	inc    %rcx
    99ed:	48 39 f1             	cmp    %rsi,%rcx
    99f0:	72 ee                	jb     99e0 <fwp_valid_float+0x50>
    99f2:	48 89 f1             	mov    %rsi,%rcx
    99f5:	48 8d 41 ff          	lea    -0x1(%rcx),%rax
    99f9:	4c 39 c0             	cmp    %r8,%rax
    99fc:	41 0f 94 c1          	sete   %r9b
    9a00:	eb 03                	jmp    9a05 <fwp_valid_float+0x75>
    9a02:	4c 89 c1             	mov    %r8,%rcx
    9a05:	31 c0                	xor    %eax,%eax
    9a07:	49 39 d0             	cmp    %rdx,%r8
    9a0a:	75 06                	jne    9a12 <fwp_valid_float+0x82>
    9a0c:	45 84 c9             	test   %r9b,%r9b
    9a0f:	74 01                	je     9a12 <fwp_valid_float+0x82>
    9a11:	c3                   	ret
    9a12:	48 39 f1             	cmp    %rsi,%rcx
    9a15:	73 58                	jae    9a6f <fwp_valid_float+0xdf>
    9a17:	0f b6 14 0f          	movzbl (%rdi,%rcx,1),%edx
    9a1b:	83 ca 20             	or     $0x20,%edx
    9a1e:	83 fa 65             	cmp    $0x65,%edx
    9a21:	75 4c                	jne    9a6f <fwp_valid_float+0xdf>
    9a23:	48 8d 51 01          	lea    0x1(%rcx),%rdx
    9a27:	48 39 f2             	cmp    %rsi,%rdx
    9a2a:	73 18                	jae    9a44 <fwp_valid_float+0xb4>
    9a2c:	44 0f b6 04 17       	movzbl (%rdi,%rdx,1),%r8d
    9a31:	41 83 f8 2d          	cmp    $0x2d,%r8d
    9a35:	74 06                	je     9a3d <fwp_valid_float+0xad>
    9a37:	41 83 f8 2b          	cmp    $0x2b,%r8d
    9a3b:	75 07                	jne    9a44 <fwp_valid_float+0xb4>
    9a3d:	48 83 c1 02          	add    $0x2,%rcx
    9a41:	48 89 ca             	mov    %rcx,%rdx
    9a44:	48 39 f2             	cmp    %rsi,%rdx
    9a47:	73 c8                	jae    9a11 <fwp_valid_float+0x81>
    9a49:	48 89 d1             	mov    %rdx,%rcx
    9a4c:	0f 1f 40 00          	nopl   0x0(%rax)
    9a50:	44 0f b6 04 0f       	movzbl (%rdi,%rcx,1),%r8d
    9a55:	41 80 c0 d0          	add    $0xd0,%r8b
    9a59:	41 80 f8 09          	cmp    $0x9,%r8b
    9a5d:	77 0b                	ja     9a6a <fwp_valid_float+0xda>
    9a5f:	48 ff c1             	inc    %rcx
    9a62:	48 39 ce             	cmp    %rcx,%rsi
    9a65:	75 e9                	jne    9a50 <fwp_valid_float+0xc0>
    9a67:	48 89 f1             	mov    %rsi,%rcx
    9a6a:	48 39 d1             	cmp    %rdx,%rcx
    9a6d:	74 a2                	je     9a11 <fwp_valid_float+0x81>
    9a6f:	31 c0                	xor    %eax,%eax
    9a71:	48 39 f1             	cmp    %rsi,%rcx
    9a74:	0f 94 c0             	sete   %al
    9a77:	c3                   	ret
    9a78:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    9a7f:	00 

0000000000009a80 <fwp_from_f32>:
    9a80:	66 0f 7e c0          	movd   %xmm0,%eax
    9a84:	c3                   	ret
    9a85:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    9a8c:	00 00 00 00 

0000000000009a90 <fwp_float_of>:
    9a90:	83 ff 0a             	cmp    $0xa,%edi
    9a93:	0f 85 87 96 ff ff    	jne    3120 <fwp_from_f64>
    9a99:	f2 0f 5a c0          	cvtsd2ss %xmm0,%xmm0
    9a9d:	eb e1                	jmp    9a80 <fwp_from_f32>
    9a9f:	90                   	nop

0000000000009aa0 <fwp_utf8_put>:
    9aa0:	50                   	push   %rax
    9aa1:	83 fe 7f             	cmp    $0x7f,%esi
    9aa4:	77 0f                	ja     9ab5 <fwp_utf8_put+0x15>
    9aa6:	40 88 74 24 04       	mov    %sil,0x4(%rsp)
    9aab:	ba 01 00 00 00       	mov    $0x1,%edx
    9ab0:	e9 8e 00 00 00       	jmp    9b43 <fwp_utf8_put+0xa3>
    9ab5:	89 f0                	mov    %esi,%eax
    9ab7:	81 fe ff 07 00 00    	cmp    $0x7ff,%esi
    9abd:	77 1d                	ja     9adc <fwp_utf8_put+0x3c>
    9abf:	c1 e8 06             	shr    $0x6,%eax
    9ac2:	0c c0                	or     $0xc0,%al
    9ac4:	88 44 24 04          	mov    %al,0x4(%rsp)
    9ac8:	40 80 e6 3f          	and    $0x3f,%sil
    9acc:	40 80 ce 80          	or     $0x80,%sil
    9ad0:	40 88 74 24 05       	mov    %sil,0x5(%rsp)
    9ad5:	ba 02 00 00 00       	mov    $0x2,%edx
    9ada:	eb 67                	jmp    9b43 <fwp_utf8_put+0xa3>
    9adc:	81 fe ff ff 00 00    	cmp    $0xffff,%esi
    9ae2:	77 2a                	ja     9b0e <fwp_utf8_put+0x6e>
    9ae4:	c1 e8 0c             	shr    $0xc,%eax
    9ae7:	0c e0                	or     $0xe0,%al
    9ae9:	88 44 24 04          	mov    %al,0x4(%rsp)
    9aed:	89 f0                	mov    %esi,%eax
    9aef:	c1 e8 06             	shr    $0x6,%eax
    9af2:	24 3f                	and    $0x3f,%al
    9af4:	0c 80                	or     $0x80,%al
    9af6:	88 44 24 05          	mov    %al,0x5(%rsp)
    9afa:	40 80 e6 3f          	and    $0x3f,%sil
    9afe:	40 80 ce 80          	or     $0x80,%sil
    9b02:	40 88 74 24 06       	mov    %sil,0x6(%rsp)
    9b07:	ba 03 00 00 00       	mov    $0x3,%edx
    9b0c:	eb 35                	jmp    9b43 <fwp_utf8_put+0xa3>
    9b0e:	c1 e8 12             	shr    $0x12,%eax
    9b11:	0c f0                	or     $0xf0,%al
    9b13:	88 44 24 04          	mov    %al,0x4(%rsp)
    9b17:	89 f0                	mov    %esi,%eax
    9b19:	c1 e8 0c             	shr    $0xc,%eax
    9b1c:	24 3f                	and    $0x3f,%al
    9b1e:	0c 80                	or     $0x80,%al
    9b20:	88 44 24 05          	mov    %al,0x5(%rsp)
    9b24:	89 f0                	mov    %esi,%eax
    9b26:	c1 e8 06             	shr    $0x6,%eax
    9b29:	24 3f                	and    $0x3f,%al
    9b2b:	0c 80                	or     $0x80,%al
    9b2d:	88 44 24 06          	mov    %al,0x6(%rsp)
    9b31:	40 80 e6 3f          	and    $0x3f,%sil
    9b35:	40 80 ce 80          	or     $0x80,%sil
    9b39:	40 88 74 24 07       	mov    %sil,0x7(%rsp)
    9b3e:	ba 04 00 00 00       	mov    $0x4,%edx
    9b43:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
    9b48:	e8 43 df ff ff       	call   7a90 <buf_put>
    9b4d:	58                   	pop    %rax
    9b4e:	c3                   	ret
    9b4f:	90                   	nop

0000000000009b50 <tp_push>:
    9b50:	41 56                	push   %r14
    9b52:	53                   	push   %rbx
    9b53:	50                   	push   %rax
    9b54:	48 89 f3             	mov    %rsi,%rbx
    9b57:	49 89 fe             	mov    %rdi,%r14
    9b5a:	48 8b 77 18          	mov    0x18(%rdi),%rsi
    9b5e:	48 3b 77 20          	cmp    0x20(%rdi),%rsi
    9b62:	75 2f                	jne    9b93 <tp_push+0x43>
    9b64:	48 8d 04 36          	lea    (%rsi,%rsi,1),%rax
    9b68:	48 85 f6             	test   %rsi,%rsi
    9b6b:	ba 08 00 00 00       	mov    $0x8,%edx
    9b70:	48 0f 45 d0          	cmovne %rax,%rdx
    9b74:	49 89 56 20          	mov    %rdx,0x20(%r14)
    9b78:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    9b7c:	48 c1 e6 03          	shl    $0x3,%rsi
    9b80:	48 c1 e2 03          	shl    $0x3,%rdx
    9b84:	e8 07 dc ff ff       	call   7790 <fwp_mem_realloc>
    9b89:	49 89 46 10          	mov    %rax,0x10(%r14)
    9b8d:	49 8b 76 18          	mov    0x18(%r14),%rsi
    9b91:	eb 04                	jmp    9b97 <tp_push+0x47>
    9b93:	49 8b 46 10          	mov    0x10(%r14),%rax
    9b97:	48 8d 4e 01          	lea    0x1(%rsi),%rcx
    9b9b:	49 89 4e 18          	mov    %rcx,0x18(%r14)
    9b9f:	48 89 1c f0          	mov    %rbx,(%rax,%rsi,8)
    9ba3:	48 83 c4 08          	add    $0x8,%rsp
    9ba7:	5b                   	pop    %rbx
    9ba8:	41 5e                	pop    %r14
    9baa:	c3                   	ret
    9bab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000009bb0 <tp_is_delim>:
    9bb0:	b8 01 00 00 00       	mov    $0x1,%eax
    9bb5:	83 ff 2c             	cmp    $0x2c,%edi
    9bb8:	77 13                	ja     9bcd <tp_is_delim+0x1d>
    9bba:	89 f9                	mov    %edi,%ecx
    9bbc:	48 ba 00 26 00 00 01 	movabs $0x130100002600,%rdx
    9bc3:	13 00 00 
    9bc6:	48 0f a3 ca          	bt     %rcx,%rdx
    9bca:	73 01                	jae    9bcd <tp_is_delim+0x1d>
    9bcc:	c3                   	ret
    9bcd:	83 ff 5d             	cmp    $0x5d,%edi
    9bd0:	74 fa                	je     9bcc <tp_is_delim+0x1c>
    9bd2:	83 ff 7d             	cmp    $0x7d,%edi
    9bd5:	74 f5                	je     9bcc <tp_is_delim+0x1c>
    9bd7:	31 c0                	xor    %eax,%eax
    9bd9:	40 80 ff 3a          	cmp    $0x3a,%dil
    9bdd:	0f 94 c0             	sete   %al
    9be0:	c3                   	ret
    9be1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9be8:	0f 1f 84 00 00 00 00 
    9bef:	00 

0000000000009bf0 <fwp_list_len>:
    9bf0:	31 c0                	xor    %eax,%eax
    9bf2:	48 85 ff             	test   %rdi,%rdi
    9bf5:	74 15                	je     9c0c <fwp_list_len+0x1c>
    9bf7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    9bfe:	00 00 
    9c00:	48 ff c0             	inc    %rax
    9c03:	48 8b 7f 10          	mov    0x10(%rdi),%rdi
    9c07:	48 85 ff             	test   %rdi,%rdi
    9c0a:	75 f4                	jne    9c00 <fwp_list_len+0x10>
    9c0c:	c3                   	ret
    9c0d:	0f 1f 00             	nopl   (%rax)

0000000000009c10 <fwp_map_find>:
    9c10:	55                   	push   %rbp
    9c11:	41 57                	push   %r15
    9c13:	41 56                	push   %r14
    9c15:	41 55                	push   %r13
    9c17:	41 54                	push   %r12
    9c19:	53                   	push   %rbx
    9c1a:	50                   	push   %rax
    9c1b:	49 89 f6             	mov    %rsi,%r14
    9c1e:	49 89 ff             	mov    %rdi,%r15
    9c21:	48 8b 2f             	mov    (%rdi),%rbp
    9c24:	8b 02                	mov    (%rdx),%eax
    9c26:	83 f8 04             	cmp    $0x4,%eax
    9c29:	72 53                	jb     9c7e <fwp_map_find+0x6e>
    9c2b:	83 c0 fb             	add    $0xfffffffb,%eax
    9c2e:	83 f8 04             	cmp    $0x4,%eax
    9c31:	0f 83 a3 00 00 00    	jae    9cda <fwp_map_find+0xca>
    9c37:	48 85 ed             	test   %rbp,%rbp
    9c3a:	0f 84 f7 00 00 00    	je     9d37 <fwp_map_find+0x127>
    9c40:	31 f6                	xor    %esi,%esi
    9c42:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    9c49:	ff ff 1f 
    9c4c:	eb 0a                	jmp    9c58 <fwp_map_find+0x48>
    9c4e:	66 90                	xchg   %ax,%ax
    9c50:	4c 89 e5             	mov    %r12,%rbp
    9c53:	48 39 ee             	cmp    %rbp,%rsi
    9c56:	73 74                	jae    9ccc <fwp_map_find+0xbc>
    9c58:	48 8d 14 2e          	lea    (%rsi,%rbp,1),%rdx
    9c5c:	49 89 d4             	mov    %rdx,%r12
    9c5f:	49 d1 ec             	shr    $1,%r12
    9c62:	48 21 c2             	and    %rax,%rdx
    9c65:	49 8b 54 d7 08       	mov    0x8(%r15,%rdx,8),%rdx
    9c6a:	4c 39 f2             	cmp    %r14,%rdx
    9c6d:	74 64                	je     9cd3 <fwp_map_find+0xc3>
    9c6f:	73 df                	jae    9c50 <fwp_map_find+0x40>
    9c71:	49 ff c4             	inc    %r12
    9c74:	4c 89 e6             	mov    %r12,%rsi
    9c77:	48 39 ee             	cmp    %rbp,%rsi
    9c7a:	72 dc                	jb     9c58 <fwp_map_find+0x48>
    9c7c:	eb 4e                	jmp    9ccc <fwp_map_find+0xbc>
    9c7e:	48 85 ed             	test   %rbp,%rbp
    9c81:	0f 84 b0 00 00 00    	je     9d37 <fwp_map_find+0x127>
    9c87:	31 f6                	xor    %esi,%esi
    9c89:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    9c90:	ff ff 1f 
    9c93:	eb 13                	jmp    9ca8 <fwp_map_find+0x98>
    9c95:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    9c9c:	00 00 00 00 
    9ca0:	4c 89 e5             	mov    %r12,%rbp
    9ca3:	48 39 ee             	cmp    %rbp,%rsi
    9ca6:	73 24                	jae    9ccc <fwp_map_find+0xbc>
    9ca8:	48 8d 14 2e          	lea    (%rsi,%rbp,1),%rdx
    9cac:	49 89 d4             	mov    %rdx,%r12
    9caf:	49 d1 ec             	shr    $1,%r12
    9cb2:	48 21 c2             	and    %rax,%rdx
    9cb5:	49 8b 54 d7 08       	mov    0x8(%r15,%rdx,8),%rdx
    9cba:	4c 39 f2             	cmp    %r14,%rdx
    9cbd:	74 14                	je     9cd3 <fwp_map_find+0xc3>
    9cbf:	7d df                	jge    9ca0 <fwp_map_find+0x90>
    9cc1:	49 ff c4             	inc    %r12
    9cc4:	4c 89 e6             	mov    %r12,%rsi
    9cc7:	48 39 ee             	cmp    %rbp,%rsi
    9cca:	72 dc                	jb     9ca8 <fwp_map_find+0x98>
    9ccc:	31 c0                	xor    %eax,%eax
    9cce:	49 89 f4             	mov    %rsi,%r12
    9cd1:	eb 69                	jmp    9d3c <fwp_map_find+0x12c>
    9cd3:	b8 01 00 00 00       	mov    $0x1,%eax
    9cd8:	eb 62                	jmp    9d3c <fwp_map_find+0x12c>
    9cda:	48 85 ed             	test   %rbp,%rbp
    9cdd:	74 58                	je     9d37 <fwp_map_find+0x127>
    9cdf:	49 89 d5             	mov    %rdx,%r13
    9ce2:	48 89 0c 24          	mov    %rcx,(%rsp)
    9ce6:	31 db                	xor    %ebx,%ebx
    9ce8:	eb 0e                	jmp    9cf8 <fwp_map_find+0xe8>
    9cea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9cf0:	4c 89 e5             	mov    %r12,%rbp
    9cf3:	48 39 eb             	cmp    %rbp,%rbx
    9cf6:	73 38                	jae    9d30 <fwp_map_find+0x120>
    9cf8:	48 8d 04 2b          	lea    (%rbx,%rbp,1),%rax
    9cfc:	49 89 c4             	mov    %rax,%r12
    9cff:	49 d1 ec             	shr    $1,%r12
    9d02:	48 b9 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rcx
    9d09:	ff ff 1f 
    9d0c:	48 21 c8             	and    %rcx,%rax
    9d0f:	49 8b 7c c7 08       	mov    0x8(%r15,%rax,8),%rdi
    9d14:	4c 89 f6             	mov    %r14,%rsi
    9d17:	4c 89 ea             	mov    %r13,%rdx
    9d1a:	e8 61 00 00 00       	call   9d80 <fwp_cmp>
    9d1f:	85 c0                	test   %eax,%eax
    9d21:	74 2d                	je     9d50 <fwp_map_find+0x140>
    9d23:	79 cb                	jns    9cf0 <fwp_map_find+0xe0>
    9d25:	49 ff c4             	inc    %r12
    9d28:	4c 89 e3             	mov    %r12,%rbx
    9d2b:	48 39 eb             	cmp    %rbp,%rbx
    9d2e:	72 c8                	jb     9cf8 <fwp_map_find+0xe8>
    9d30:	31 c0                	xor    %eax,%eax
    9d32:	49 89 dc             	mov    %rbx,%r12
    9d35:	eb 1e                	jmp    9d55 <fwp_map_find+0x145>
    9d37:	31 c0                	xor    %eax,%eax
    9d39:	45 31 e4             	xor    %r12d,%r12d
    9d3c:	89 01                	mov    %eax,(%rcx)
    9d3e:	4c 89 e0             	mov    %r12,%rax
    9d41:	48 83 c4 08          	add    $0x8,%rsp
    9d45:	5b                   	pop    %rbx
    9d46:	41 5c                	pop    %r12
    9d48:	41 5d                	pop    %r13
    9d4a:	41 5e                	pop    %r14
    9d4c:	41 5f                	pop    %r15
    9d4e:	5d                   	pop    %rbp
    9d4f:	c3                   	ret
    9d50:	b8 01 00 00 00       	mov    $0x1,%eax
    9d55:	48 8b 0c 24          	mov    (%rsp),%rcx
    9d59:	eb e1                	jmp    9d3c <fwp_map_find+0x12c>
    9d5b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000009d60 <fwp_map_alloc>:
    9d60:	53                   	push   %rbx
    9d61:	48 89 fb             	mov    %rdi,%rbx
    9d64:	48 c1 e7 04          	shl    $0x4,%rdi
    9d68:	48 83 cf 08          	or     $0x8,%rdi
    9d6c:	e8 bf b9 ff ff       	call   5730 <fwp_alloc>
    9d71:	48 89 18             	mov    %rbx,(%rax)
    9d74:	5b                   	pop    %rbx
    9d75:	c3                   	ret
    9d76:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    9d7d:	00 00 00 

0000000000009d80 <fwp_cmp>:
    9d80:	55                   	push   %rbp
    9d81:	41 57                	push   %r15
    9d83:	41 56                	push   %r14
    9d85:	41 55                	push   %r13
    9d87:	41 54                	push   %r12
    9d89:	53                   	push   %rbx
    9d8a:	48 83 ec 18          	sub    $0x18,%rsp
    9d8e:	48 89 f3             	mov    %rsi,%rbx
    9d91:	49 89 fe             	mov    %rdi,%r14
    9d94:	44 8b 2a             	mov    (%rdx),%r13d
    9d97:	49 83 fd 15          	cmp    $0x15,%r13
    9d9b:	77 25                	ja     9dc2 <fwp_cmp+0x42>
    9d9d:	49 89 d7             	mov    %rdx,%r15
    9da0:	48 8d 05 45 45 00 00 	lea    0x4545(%rip),%rax        # e2ec <_IO_stdin_used+0x2ec>
    9da7:	4a 63 0c a8          	movslq (%rax,%r13,4),%rcx
    9dab:	48 01 c1             	add    %rax,%rcx
    9dae:	ff e1                	jmp    *%rcx
    9db0:	31 c9                	xor    %ecx,%ecx
    9db2:	49 39 de             	cmp    %rbx,%r14
    9db5:	0f 9f c1             	setg   %cl
    9db8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9dbd:	0f 4d c1             	cmovge %ecx,%eax
    9dc0:	eb 10                	jmp    9dd2 <fwp_cmp+0x52>
    9dc2:	31 c9                	xor    %ecx,%ecx
    9dc4:	49 39 de             	cmp    %rbx,%r14
    9dc7:	0f 97 c1             	seta   %cl
    9dca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9dcf:	0f 43 c1             	cmovae %ecx,%eax
    9dd2:	48 83 c4 18          	add    $0x18,%rsp
    9dd6:	5b                   	pop    %rbx
    9dd7:	41 5c                	pop    %r12
    9dd9:	41 5d                	pop    %r13
    9ddb:	41 5e                	pop    %r14
    9ddd:	41 5f                	pop    %r15
    9ddf:	5d                   	pop    %rbp
    9de0:	c3                   	ret
    9de1:	4d 8b 3e             	mov    (%r14),%r15
    9de4:	4c 8b 23             	mov    (%rbx),%r12
    9de7:	49 83 c6 08          	add    $0x8,%r14
    9deb:	48 83 c3 08          	add    $0x8,%rbx
    9def:	4d 39 e7             	cmp    %r12,%r15
    9df2:	4c 89 e2             	mov    %r12,%rdx
    9df5:	49 0f 42 d7          	cmovb  %r15,%rdx
    9df9:	4c 89 f7             	mov    %r14,%rdi
    9dfc:	48 89 de             	mov    %rbx,%rsi
    9dff:	e8 6c 84 ff ff       	call   2270 <memcmp@plt>
    9e04:	85 c0                	test   %eax,%eax
    9e06:	0f 84 ce 02 00 00    	je     a0da <fwp_cmp+0x35a>
    9e0c:	c1 f8 1f             	sar    $0x1f,%eax
    9e0f:	83 c8 01             	or     $0x1,%eax
    9e12:	eb be                	jmp    9dd2 <fwp_cmp+0x52>
    9e14:	49 8b 06             	mov    (%r14),%rax
    9e17:	48 8b 2b             	mov    (%rbx),%rbp
    9e1a:	48 39 e8             	cmp    %rbp,%rax
    9e1d:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    9e22:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    9e27:	48 0f 42 e8          	cmovb  %rax,%rbp
    9e2b:	48 85 ed             	test   %rbp,%rbp
    9e2e:	74 54                	je     9e84 <fwp_cmp+0x104>
    9e30:	49 8b 47 38          	mov    0x38(%r15),%rax
    9e34:	48 89 04 24          	mov    %rax,(%rsp)
    9e38:	41 bc 10 00 00 00    	mov    $0x10,%r12d
    9e3e:	eb 09                	jmp    9e49 <fwp_cmp+0xc9>
    9e40:	49 83 c4 10          	add    $0x10,%r12
    9e44:	48 ff cd             	dec    %rbp
    9e47:	74 3b                	je     9e84 <fwp_cmp+0x104>
    9e49:	4b 8b 7c 26 f8       	mov    -0x8(%r14,%r12,1),%rdi
    9e4e:	4a 8b 74 23 f8       	mov    -0x8(%rbx,%r12,1),%rsi
    9e53:	48 8b 14 24          	mov    (%rsp),%rdx
    9e57:	e8 24 ff ff ff       	call   9d80 <fwp_cmp>
    9e5c:	85 c0                	test   %eax,%eax
    9e5e:	0f 85 6e ff ff ff    	jne    9dd2 <fwp_cmp+0x52>
    9e64:	41 83 fd 12          	cmp    $0x12,%r13d
    9e68:	75 d6                	jne    9e40 <fwp_cmp+0xc0>
    9e6a:	4b 8b 3c 26          	mov    (%r14,%r12,1),%rdi
    9e6e:	4a 8b 34 23          	mov    (%rbx,%r12,1),%rsi
    9e72:	49 8b 57 40          	mov    0x40(%r15),%rdx
    9e76:	e8 05 ff ff ff       	call   9d80 <fwp_cmp>
    9e7b:	85 c0                	test   %eax,%eax
    9e7d:	74 c1                	je     9e40 <fwp_cmp+0xc0>
    9e7f:	e9 4e ff ff ff       	jmp    9dd2 <fwp_cmp+0x52>
    9e84:	31 c9                	xor    %ecx,%ecx
    9e86:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    9e8b:	48 39 44 24 10       	cmp    %rax,0x10(%rsp)
    9e90:	e9 32 ff ff ff       	jmp    9dc7 <fwp_cmp+0x47>
    9e95:	4c 89 f7             	mov    %r14,%rdi
    9e98:	e8 73 02 00 00       	call   a110 <fwp_u128>
    9e9d:	49 89 c7             	mov    %rax,%r15
    9ea0:	49 89 d6             	mov    %rdx,%r14
    9ea3:	48 89 df             	mov    %rbx,%rdi
    9ea6:	e8 65 02 00 00       	call   a110 <fwp_u128>
    9eab:	48 89 c1             	mov    %rax,%rcx
    9eae:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9eb3:	49 39 cf             	cmp    %rcx,%r15
    9eb6:	4c 89 f6             	mov    %r14,%rsi
    9eb9:	48 19 d6             	sbb    %rdx,%rsi
    9ebc:	0f 82 10 ff ff ff    	jb     9dd2 <fwp_cmp+0x52>
    9ec2:	4c 39 f9             	cmp    %r15,%rcx
    9ec5:	4c 19 f2             	sbb    %r14,%rdx
    9ec8:	0f 92 c0             	setb   %al
    9ecb:	0f b6 c0             	movzbl %al,%eax
    9ece:	e9 ff fe ff ff       	jmp    9dd2 <fwp_cmp+0x52>
    9ed3:	4c 89 f7             	mov    %r14,%rdi
    9ed6:	e8 55 02 00 00       	call   a130 <fwp_f32>
    9edb:	e8 40 02 00 00       	call   a120 <fwp_total_key32>
    9ee0:	89 c5                	mov    %eax,%ebp
    9ee2:	48 89 df             	mov    %rbx,%rdi
    9ee5:	e8 46 02 00 00       	call   a130 <fwp_f32>
    9eea:	e8 31 02 00 00       	call   a120 <fwp_total_key32>
    9eef:	89 c1                	mov    %eax,%ecx
    9ef1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9ef6:	39 cd                	cmp    %ecx,%ebp
    9ef8:	0f 8c d4 fe ff ff    	jl     9dd2 <fwp_cmp+0x52>
    9efe:	eb 2e                	jmp    9f2e <fwp_cmp+0x1ae>
    9f00:	4c 89 f7             	mov    %r14,%rdi
    9f03:	e8 b8 91 ff ff       	call   30c0 <fwp_f64>
    9f08:	e8 33 02 00 00       	call   a140 <fwp_total_key64>
    9f0d:	49 89 c6             	mov    %rax,%r14
    9f10:	48 89 df             	mov    %rbx,%rdi
    9f13:	e8 a8 91 ff ff       	call   30c0 <fwp_f64>
    9f18:	e8 23 02 00 00       	call   a140 <fwp_total_key64>
    9f1d:	48 89 c1             	mov    %rax,%rcx
    9f20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9f25:	49 39 ce             	cmp    %rcx,%r14
    9f28:	0f 8c a4 fe ff ff    	jl     9dd2 <fwp_cmp+0x52>
    9f2e:	0f 9f c0             	setg   %al
    9f31:	0f b6 c0             	movzbl %al,%eax
    9f34:	e9 99 fe ff ff       	jmp    9dd2 <fwp_cmp+0x52>
    9f39:	4c 89 f7             	mov    %r14,%rdi
    9f3c:	e8 bf 01 00 00       	call   a100 <fwp_i128>
    9f41:	49 89 c7             	mov    %rax,%r15
    9f44:	49 89 d6             	mov    %rdx,%r14
    9f47:	48 89 df             	mov    %rbx,%rdi
    9f4a:	e8 b1 01 00 00       	call   a100 <fwp_i128>
    9f4f:	48 89 c1             	mov    %rax,%rcx
    9f52:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9f57:	49 39 cf             	cmp    %rcx,%r15
    9f5a:	4c 89 f6             	mov    %r14,%rsi
    9f5d:	48 19 d6             	sbb    %rdx,%rsi
    9f60:	0f 8c 6c fe ff ff    	jl     9dd2 <fwp_cmp+0x52>
    9f66:	4c 39 f9             	cmp    %r15,%rcx
    9f69:	4c 19 f2             	sbb    %r14,%rdx
    9f6c:	0f 9c c0             	setl   %al
    9f6f:	0f b6 c0             	movzbl %al,%eax
    9f72:	e9 5b fe ff ff       	jmp    9dd2 <fwp_cmp+0x52>
    9f77:	4d 85 f6             	test   %r14,%r14
    9f7a:	0f 94 c0             	sete   %al
    9f7d:	74 3e                	je     9fbd <fwp_cmp+0x23d>
    9f7f:	48 85 db             	test   %rbx,%rbx
    9f82:	74 39                	je     9fbd <fwp_cmp+0x23d>
    9f84:	4d 8b 7f 38          	mov    0x38(%r15),%r15
    9f88:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    9f8f:	00 
    9f90:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    9f94:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    9f98:	4c 89 fa             	mov    %r15,%rdx
    9f9b:	e8 e0 fd ff ff       	call   9d80 <fwp_cmp>
    9fa0:	85 c0                	test   %eax,%eax
    9fa2:	0f 85 2a fe ff ff    	jne    9dd2 <fwp_cmp+0x52>
    9fa8:	4d 8b 76 10          	mov    0x10(%r14),%r14
    9fac:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    9fb0:	4d 85 f6             	test   %r14,%r14
    9fb3:	0f 94 c0             	sete   %al
    9fb6:	74 05                	je     9fbd <fwp_cmp+0x23d>
    9fb8:	48 85 db             	test   %rbx,%rbx
    9fbb:	75 d3                	jne    9f90 <fwp_cmp+0x210>
    9fbd:	48 85 db             	test   %rbx,%rbx
    9fc0:	0f 95 c1             	setne  %cl
    9fc3:	08 c1                	or     %al,%cl
    9fc5:	80 f1 01             	xor    $0x1,%cl
    9fc8:	0f b6 c9             	movzbl %cl,%ecx
    9fcb:	84 c0                	test   %al,%al
    9fcd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9fd2:	0f 44 c1             	cmove  %ecx,%eax
    9fd5:	48 85 db             	test   %rbx,%rbx
    9fd8:	0f 44 c1             	cmove  %ecx,%eax
    9fdb:	e9 f2 fd ff ff       	jmp    9dd2 <fwp_cmp+0x52>
    9fe0:	45 8b 67 10          	mov    0x10(%r15),%r12d
    9fe4:	45 85 e4             	test   %r12d,%r12d
    9fe7:	0f 8e f7 00 00 00    	jle    a0e4 <fwp_cmp+0x364>
    9fed:	4d 8b 7f 20          	mov    0x20(%r15),%r15
    9ff1:	45 31 ed             	xor    %r13d,%r13d
    9ff4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    9ffb:	00 00 00 00 00 
    a000:	4b 8b 7c ee 08       	mov    0x8(%r14,%r13,8),%rdi
    a005:	4a 8b 74 eb 08       	mov    0x8(%rbx,%r13,8),%rsi
    a00a:	4b 8b 14 ef          	mov    (%r15,%r13,8),%rdx
    a00e:	e8 6d fd ff ff       	call   9d80 <fwp_cmp>
    a013:	85 c0                	test   %eax,%eax
    a015:	0f 85 b7 fd ff ff    	jne    9dd2 <fwp_cmp+0x52>
    a01b:	49 ff c5             	inc    %r13
    a01e:	31 c0                	xor    %eax,%eax
    a020:	4d 39 ec             	cmp    %r13,%r12
    a023:	75 db                	jne    a000 <fwp_cmp+0x280>
    a025:	e9 a8 fd ff ff       	jmp    9dd2 <fwp_cmp+0x52>
    a02a:	49 8b 06             	mov    (%r14),%rax
    a02d:	4c 8b 2b             	mov    (%rbx),%r13
    a030:	4c 39 e8             	cmp    %r13,%rax
    a033:	4c 89 ed             	mov    %r13,%rbp
    a036:	48 89 04 24          	mov    %rax,(%rsp)
    a03a:	48 0f 42 e8          	cmovb  %rax,%rbp
    a03e:	48 85 ed             	test   %rbp,%rbp
    a041:	74 2f                	je     a072 <fwp_cmp+0x2f2>
    a043:	4d 8b 7f 38          	mov    0x38(%r15),%r15
    a047:	45 31 e4             	xor    %r12d,%r12d
    a04a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    a050:	4b 8b 7c e6 08       	mov    0x8(%r14,%r12,8),%rdi
    a055:	4a 8b 74 e3 08       	mov    0x8(%rbx,%r12,8),%rsi
    a05a:	4c 89 fa             	mov    %r15,%rdx
    a05d:	e8 1e fd ff ff       	call   9d80 <fwp_cmp>
    a062:	85 c0                	test   %eax,%eax
    a064:	0f 85 68 fd ff ff    	jne    9dd2 <fwp_cmp+0x52>
    a06a:	49 ff c4             	inc    %r12
    a06d:	4c 39 e5             	cmp    %r12,%rbp
    a070:	75 de                	jne    a050 <fwp_cmp+0x2d0>
    a072:	31 c9                	xor    %ecx,%ecx
    a074:	4c 39 2c 24          	cmp    %r13,(%rsp)
    a078:	e9 4a fd ff ff       	jmp    9dc7 <fwp_cmp+0x47>
    a07d:	4c 89 f7             	mov    %r14,%rdi
    a080:	e8 db 00 00 00       	call   a160 <fwp_tag>
    a085:	89 c5                	mov    %eax,%ebp
    a087:	48 89 df             	mov    %rbx,%rdi
    a08a:	e8 d1 00 00 00       	call   a160 <fwp_tag>
    a08f:	39 c5                	cmp    %eax,%ebp
    a091:	75 58                	jne    a0eb <fwp_cmp+0x36b>
    a093:	49 8b 4f 28          	mov    0x28(%r15),%rcx
    a097:	89 e8                	mov    %ebp,%eax
    a099:	44 8b 24 81          	mov    (%rcx,%rax,4),%r12d
    a09d:	45 85 e4             	test   %r12d,%r12d
    a0a0:	7e 42                	jle    a0e4 <fwp_cmp+0x364>
    a0a2:	49 8b 4f 30          	mov    0x30(%r15),%rcx
    a0a6:	4c 8b 3c c1          	mov    (%rcx,%rax,8),%r15
    a0aa:	45 31 ed             	xor    %r13d,%r13d
    a0ad:	0f 1f 00             	nopl   (%rax)
    a0b0:	4b 8b 7c ee 08       	mov    0x8(%r14,%r13,8),%rdi
    a0b5:	4a 8b 74 eb 08       	mov    0x8(%rbx,%r13,8),%rsi
    a0ba:	4b 8b 14 ef          	mov    (%r15,%r13,8),%rdx
    a0be:	e8 bd fc ff ff       	call   9d80 <fwp_cmp>
    a0c3:	85 c0                	test   %eax,%eax
    a0c5:	0f 85 07 fd ff ff    	jne    9dd2 <fwp_cmp+0x52>
    a0cb:	49 ff c5             	inc    %r13
    a0ce:	31 c0                	xor    %eax,%eax
    a0d0:	4d 39 ec             	cmp    %r13,%r12
    a0d3:	75 db                	jne    a0b0 <fwp_cmp+0x330>
    a0d5:	e9 f8 fc ff ff       	jmp    9dd2 <fwp_cmp+0x52>
    a0da:	31 c9                	xor    %ecx,%ecx
    a0dc:	4d 39 e7             	cmp    %r12,%r15
    a0df:	e9 e3 fc ff ff       	jmp    9dc7 <fwp_cmp+0x47>
    a0e4:	31 c0                	xor    %eax,%eax
    a0e6:	e9 e7 fc ff ff       	jmp    9dd2 <fwp_cmp+0x52>
    a0eb:	0f 97 c0             	seta   %al
    a0ee:	0f b6 c8             	movzbl %al,%ecx
    a0f1:	e9 d4 fc ff ff       	jmp    9dca <fwp_cmp+0x4a>
    a0f6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    a0fd:	00 00 00 

000000000000a100 <fwp_i128>:
    a100:	48 8b 07             	mov    (%rdi),%rax
    a103:	48 8b 57 08          	mov    0x8(%rdi),%rdx
    a107:	c3                   	ret
    a108:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a10f:	00 

000000000000a110 <fwp_u128>:
    a110:	48 8b 07             	mov    (%rdi),%rax
    a113:	48 8b 57 08          	mov    0x8(%rdi),%rdx
    a117:	c3                   	ret
    a118:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a11f:	00 

000000000000a120 <fwp_total_key32>:
    a120:	66 0f 7e c1          	movd   %xmm0,%ecx
    a124:	89 c8                	mov    %ecx,%eax
    a126:	c1 f8 1f             	sar    $0x1f,%eax
    a129:	d1 e8                	shr    $1,%eax
    a12b:	31 c8                	xor    %ecx,%eax
    a12d:	c3                   	ret
    a12e:	66 90                	xchg   %ax,%ax

000000000000a130 <fwp_f32>:
    a130:	66 0f 6e c7          	movd   %edi,%xmm0
    a134:	c3                   	ret
    a135:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a13c:	00 00 00 00 

000000000000a140 <fwp_total_key64>:
    a140:	66 48 0f 7e c1       	movq   %xmm0,%rcx
    a145:	48 89 c8             	mov    %rcx,%rax
    a148:	48 c1 f8 3f          	sar    $0x3f,%rax
    a14c:	48 d1 e8             	shr    $1,%rax
    a14f:	48 31 c8             	xor    %rcx,%rax
    a152:	c3                   	ret
    a153:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a15a:	84 00 00 00 00 00 

000000000000a160 <fwp_tag>:
    a160:	48 89 f8             	mov    %rdi,%rax
    a163:	48 81 ff ff 0f 00 00 	cmp    $0xfff,%rdi
    a16a:	76 02                	jbe    a16e <fwp_tag+0xe>
    a16c:	8b 00                	mov    (%rax),%eax
    a16e:	c3                   	ret
    a16f:	90                   	nop

000000000000a170 <fwp_transport_off>:
    a170:	50                   	push   %rax
    a171:	48 8d 3d 52 51 00 00 	lea    0x5152(%rip),%rdi        # f2ca <exec_in_fp0+0xc7a>
    a178:	e8 b3 7e ff ff       	call   2030 <getenv@plt>
    a17d:	48 85 c0             	test   %rax,%rax
    a180:	74 1a                	je     a19c <fwp_transport_off+0x2c>
    a182:	48 8d 35 4f 51 00 00 	lea    0x514f(%rip),%rsi        # f2d8 <exec_in_fp0+0xc88>
    a189:	48 89 c7             	mov    %rax,%rdi
    a18c:	e8 3f 81 ff ff       	call   22d0 <strcmp@plt>
    a191:	89 c1                	mov    %eax,%ecx
    a193:	31 c0                	xor    %eax,%eax
    a195:	85 c9                	test   %ecx,%ecx
    a197:	0f 94 c0             	sete   %al
    a19a:	59                   	pop    %rcx
    a19b:	c3                   	ret
    a19c:	31 c0                	xor    %eax,%eax
    a19e:	59                   	pop    %rcx
    a19f:	c3                   	ret

000000000000a1a0 <fwp_pipe_addr>:
    a1a0:	50                   	push   %rax
    a1a1:	0f 57 c0             	xorps  %xmm0,%xmm0
    a1a4:	0f 11 47 5e          	movups %xmm0,0x5e(%rdi)
    a1a8:	0f 11 47 52          	movups %xmm0,0x52(%rdi)
    a1ac:	0f 11 47 42          	movups %xmm0,0x42(%rdi)
    a1b0:	0f 11 47 32          	movups %xmm0,0x32(%rdi)
    a1b4:	0f 11 47 22          	movups %xmm0,0x22(%rdi)
    a1b8:	0f 11 47 12          	movups %xmm0,0x12(%rdi)
    a1bc:	0f 11 47 02          	movups %xmm0,0x2(%rdi)
    a1c0:	66 c7 07 01 00       	movw   $0x1,(%rdi)
    a1c5:	48 83 c7 03          	add    $0x3,%rdi
    a1c9:	48 8b 0e             	mov    (%rsi),%rcx
    a1cc:	4c 8b 46 08          	mov    0x8(%rsi),%r8
    a1d0:	48 8d 15 07 51 00 00 	lea    0x5107(%rip),%rdx        # f2de <exec_in_fp0+0xc8e>
    a1d7:	be 6b 00 00 00       	mov    $0x6b,%esi
    a1dc:	31 c0                	xor    %eax,%eax
    a1de:	e8 ed 7f ff ff       	call   21d0 <snprintf@plt>
    a1e3:	83 c0 03             	add    $0x3,%eax
    a1e6:	59                   	pop    %rcx
    a1e7:	c3                   	ret
    a1e8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a1ef:	00 

000000000000a1f0 <fwp_now_ns>:
    a1f0:	48 83 ec 18          	sub    $0x18,%rsp
    a1f4:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    a1f9:	bf 01 00 00 00       	mov    $0x1,%edi
    a1fe:	e8 2d 7f ff ff       	call   2130 <clock_gettime@plt>
    a203:	48 69 44 24 08 00 ca 	imul   $0x3b9aca00,0x8(%rsp),%rax
    a20a:	9a 3b 
    a20c:	48 03 44 24 10       	add    0x10(%rsp),%rax
    a211:	48 83 c4 18          	add    $0x18,%rsp
    a215:	c3                   	ret
    a216:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    a21d:	00 00 00 

000000000000a220 <fwp_ring_put>:
    a220:	55                   	push   %rbp
    a221:	41 57                	push   %r15
    a223:	41 56                	push   %r14
    a225:	41 55                	push   %r13
    a227:	41 54                	push   %r12
    a229:	53                   	push   %rbx
    a22a:	48 83 ec 38          	sub    $0x38,%rsp
    a22e:	48 89 3c 24          	mov    %rdi,(%rsp)
    a232:	48 85 f6             	test   %rsi,%rsi
    a235:	0f 84 27 01 00 00    	je     a362 <fwp_ring_put+0x142>
    a23b:	f6 05 16 bc 02 00 01 	testb  $0x1,0x2bc16(%rip)        # 35e58 <fwp_po_gone>
    a242:	0f 85 1a 01 00 00    	jne    a362 <fwp_ring_put+0x142>
    a248:	48 89 f3             	mov    %rsi,%rbx
    a24b:	4c 8b 3d fe bb 02 00 	mov    0x2bbfe(%rip),%r15        # 35e50 <fwp_po_ring>
    a252:	49 8d 87 00 10 00 00 	lea    0x1000(%r15),%rax
    a259:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    a25e:	49 8d 87 c0 00 00 00 	lea    0xc0(%r15),%rax
    a265:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    a26a:	49 8d 87 c4 00 00 00 	lea    0xc4(%r15),%rax
    a271:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    a276:	49 8d 87 00 01 00 00 	lea    0x100(%r15),%rax
    a27d:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    a282:	49 8d 87 04 01 00 00 	lea    0x104(%r15),%rax
    a289:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    a28e:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    a293:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a29a:	84 00 00 00 00 00 
    a2a0:	4d 8b 67 40          	mov    0x40(%r15),%r12
    a2a4:	49 8b af 80 00 00 00 	mov    0x80(%r15),%rbp
    a2ab:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    a2af:	4c 29 e5             	sub    %r12,%rbp
    a2b2:	4c 01 ed             	add    %r13,%rbp
    a2b5:	74 69                	je     a320 <fwp_ring_put+0x100>
    a2b7:	48 39 eb             	cmp    %rbp,%rbx
    a2ba:	48 0f 42 eb          	cmovb  %rbx,%rbp
    a2be:	49 8d 7d ff          	lea    -0x1(%r13),%rdi
    a2c2:	4c 21 e7             	and    %r12,%rdi
    a2c5:	49 29 fd             	sub    %rdi,%r13
    a2c8:	4c 39 ed             	cmp    %r13,%rbp
    a2cb:	4c 0f 42 ed          	cmovb  %rbp,%r13
    a2cf:	4c 01 f7             	add    %r14,%rdi
    a2d2:	48 89 5c 24 30       	mov    %rbx,0x30(%rsp)
    a2d7:	48 8b 1c 24          	mov    (%rsp),%rbx
    a2db:	48 89 de             	mov    %rbx,%rsi
    a2de:	4c 89 ea             	mov    %r13,%rdx
    a2e1:	e8 4a 80 ff ff       	call   2330 <memcpy@plt>
    a2e6:	4a 8d 34 2b          	lea    (%rbx,%r13,1),%rsi
    a2ea:	48 89 ea             	mov    %rbp,%rdx
    a2ed:	4c 29 ea             	sub    %r13,%rdx
    a2f0:	4c 89 f7             	mov    %r14,%rdi
    a2f3:	e8 38 80 ff ff       	call   2330 <memcpy@plt>
    a2f8:	49 01 ec             	add    %rbp,%r12
    a2fb:	4d 89 67 40          	mov    %r12,0x40(%r15)
    a2ff:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    a304:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    a309:	e8 82 02 00 00       	call   a590 <fwp_ring_wake>
    a30e:	48 01 eb             	add    %rbp,%rbx
    a311:	48 89 1c 24          	mov    %rbx,(%rsp)
    a315:	48 8b 5c 24 30       	mov    0x30(%rsp),%rbx
    a31a:	48 29 eb             	sub    %rbp,%rbx
    a31d:	eb 31                	jmp    a350 <fwp_ring_put+0x130>
    a31f:	90                   	nop
    a320:	44 8b 05 99 b9 00 00 	mov    0xb999(%rip),%r8d        # 15cc0 <fwp_po_sock>
    a327:	4c 89 ff             	mov    %r15,%rdi
    a32a:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    a32f:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    a334:	48 8d 0d 35 02 00 00 	lea    0x235(%rip),%rcx        # a570 <fwp_ring_has_space>
    a33b:	e8 f0 00 00 00       	call   a430 <fwp_ring_wait>
    a340:	85 c0                	test   %eax,%eax
    a342:	75 0c                	jne    a350 <fwp_ring_put+0x130>
    a344:	c6 05 0d bb 02 00 01 	movb   $0x1,0x2bb0d(%rip)        # 35e58 <fwp_po_gone>
    a34b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    a350:	48 85 db             	test   %rbx,%rbx
    a353:	74 0d                	je     a362 <fwp_ring_put+0x142>
    a355:	f6 05 fc ba 02 00 01 	testb  $0x1,0x2bafc(%rip)        # 35e58 <fwp_po_gone>
    a35c:	0f 84 3e ff ff ff    	je     a2a0 <fwp_ring_put+0x80>
    a362:	48 83 c4 38          	add    $0x38,%rsp
    a366:	5b                   	pop    %rbx
    a367:	41 5c                	pop    %r12
    a369:	41 5d                	pop    %r13
    a36b:	41 5e                	pop    %r14
    a36d:	41 5f                	pop    %r15
    a36f:	5d                   	pop    %rbp
    a370:	c3                   	ret
    a371:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a378:	0f 1f 84 00 00 00 00 
    a37f:	00 

000000000000a380 <fwp_po_flush_sock>:
    a380:	48 8b 15 c1 ba 01 00 	mov    0x1bac1(%rip),%rdx        # 25e48 <fwp_po_len>
    a387:	48 85 d2             	test   %rdx,%rdx
    a38a:	74 17                	je     a3a3 <fwp_po_flush_sock+0x23>
    a38c:	50                   	push   %rax
    a38d:	8b 3d 2d b9 00 00    	mov    0xb92d(%rip),%edi        # 15cc0 <fwp_po_sock>
    a393:	48 8d 35 b6 ba 01 00 	lea    0x1bab6(%rip),%rsi        # 25e50 <fwp_po_buf>
    a39a:	e8 11 00 00 00       	call   a3b0 <fwp_po_write_raw>
    a39f:	48 83 c4 08          	add    $0x8,%rsp
    a3a3:	48 c7 05 9a ba 01 00 	movq   $0x0,0x1ba9a(%rip)        # 25e48 <fwp_po_len>
    a3aa:	00 00 00 00 
    a3ae:	c3                   	ret
    a3af:	90                   	nop

000000000000a3b0 <fwp_po_write_raw>:
    a3b0:	48 85 d2             	test   %rdx,%rdx
    a3b3:	74 70                	je     a425 <fwp_po_write_raw+0x75>
    a3b5:	f6 05 9c ba 02 00 01 	testb  $0x1,0x2ba9c(%rip)        # 35e58 <fwp_po_gone>
    a3bc:	75 67                	jne    a425 <fwp_po_write_raw+0x75>
    a3be:	55                   	push   %rbp
    a3bf:	41 56                	push   %r14
    a3c1:	53                   	push   %rbx
    a3c2:	48 89 d3             	mov    %rdx,%rbx
    a3c5:	49 89 f6             	mov    %rsi,%r14
    a3c8:	89 fd                	mov    %edi,%ebp
    a3ca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    a3d0:	89 ef                	mov    %ebp,%edi
    a3d2:	4c 89 f6             	mov    %r14,%rsi
    a3d5:	48 89 da             	mov    %rbx,%rdx
    a3d8:	b9 00 40 00 00       	mov    $0x4000,%ecx
    a3dd:	e8 be 7d ff ff       	call   21a0 <send@plt>
    a3e2:	48 85 c0             	test   %rax,%rax
    a3e5:	78 19                	js     a400 <fwp_po_write_raw+0x50>
    a3e7:	74 31                	je     a41a <fwp_po_write_raw+0x6a>
    a3e9:	49 01 c6             	add    %rax,%r14
    a3ec:	48 29 c3             	sub    %rax,%rbx
    a3ef:	eb 19                	jmp    a40a <fwp_po_write_raw+0x5a>
    a3f1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a3f8:	0f 1f 84 00 00 00 00 
    a3ff:	00 
    a400:	e8 7b 7c ff ff       	call   2080 <__errno_location@plt>
    a405:	83 38 04             	cmpl   $0x4,(%rax)
    a408:	75 10                	jne    a41a <fwp_po_write_raw+0x6a>
    a40a:	48 85 db             	test   %rbx,%rbx
    a40d:	74 12                	je     a421 <fwp_po_write_raw+0x71>
    a40f:	f6 05 42 ba 02 00 01 	testb  $0x1,0x2ba42(%rip)        # 35e58 <fwp_po_gone>
    a416:	74 b8                	je     a3d0 <fwp_po_write_raw+0x20>
    a418:	eb 07                	jmp    a421 <fwp_po_write_raw+0x71>
    a41a:	c6 05 37 ba 02 00 01 	movb   $0x1,0x2ba37(%rip)        # 35e58 <fwp_po_gone>
    a421:	5b                   	pop    %rbx
    a422:	41 5e                	pop    %r14
    a424:	5d                   	pop    %rbp
    a425:	c3                   	ret
    a426:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    a42d:	00 00 00 

000000000000a430 <fwp_ring_wait>:
    a430:	55                   	push   %rbp
    a431:	41 57                	push   %r15
    a433:	41 56                	push   %r14
    a435:	41 55                	push   %r13
    a437:	41 54                	push   %r12
    a439:	53                   	push   %rbx
    a43a:	50                   	push   %rax
    a43b:	44 89 44 24 04       	mov    %r8d,0x4(%rsp)
    a440:	49 89 cf             	mov    %rcx,%r15
    a443:	49 89 d6             	mov    %rdx,%r14
    a446:	49 89 f4             	mov    %rsi,%r12
    a449:	49 89 fd             	mov    %rdi,%r13
    a44c:	8b 0d 72 b8 00 00    	mov    0xb872(%rip),%ecx        # 15cc4 <fwp_ring_spin>
    a452:	85 c9                	test   %ecx,%ecx
    a454:	78 06                	js     a45c <fwp_ring_wait+0x2c>
    a456:	85 c9                	test   %ecx,%ecx
    a458:	75 1f                	jne    a479 <fwp_ring_wait+0x49>
    a45a:	eb 6f                	jmp    a4cb <fwp_ring_wait+0x9b>
    a45c:	bf 54 00 00 00       	mov    $0x54,%edi
    a461:	e8 ca 7f ff ff       	call   2430 <sysconf@plt>
    a466:	31 c9                	xor    %ecx,%ecx
    a468:	48 83 f8 02          	cmp    $0x2,%rax
    a46c:	0f 9d c1             	setge  %cl
    a46f:	89 0d 4f b8 00 00    	mov    %ecx,0xb84f(%rip)        # 15cc4 <fwp_ring_spin>
    a475:	85 c9                	test   %ecx,%ecx
    a477:	74 52                	je     a4cb <fwp_ring_wait+0x9b>
    a479:	4c 89 ef             	mov    %r13,%rdi
    a47c:	41 ff d7             	call   *%r15
    a47f:	89 c1                	mov    %eax,%ecx
    a481:	b8 01 00 00 00       	mov    $0x1,%eax
    a486:	85 c9                	test   %ecx,%ecx
    a488:	75 6a                	jne    a4f4 <fwp_ring_wait+0xc4>
    a48a:	bd 01 00 00 00       	mov    $0x1,%ebp
    a48f:	31 db                	xor    %ebx,%ebx
    a491:	eb 19                	jmp    a4ac <fwp_ring_wait+0x7c>
    a493:	48 05 50 c3 00 00    	add    $0xc350,%rax
    a499:	48 89 c3             	mov    %rax,%rbx
    a49c:	0f 1f 40 00          	nopl   0x0(%rax)
    a4a0:	ff c5                	inc    %ebp
    a4a2:	4c 89 ef             	mov    %r13,%rdi
    a4a5:	41 ff d7             	call   *%r15
    a4a8:	85 c0                	test   %eax,%eax
    a4aa:	75 43                	jne    a4ef <fwp_ring_wait+0xbf>
    a4ac:	e8 ff 00 00 00       	call   a5b0 <fwp_cpu_relax>
    a4b1:	40 f6 c5 3f          	test   $0x3f,%bpl
    a4b5:	75 e9                	jne    a4a0 <fwp_ring_wait+0x70>
    a4b7:	e8 94 7d ff ff       	call   2250 <sched_yield@plt>
    a4bc:	e8 2f fd ff ff       	call   a1f0 <fwp_now_ns>
    a4c1:	48 85 db             	test   %rbx,%rbx
    a4c4:	74 cd                	je     a493 <fwp_ring_wait+0x63>
    a4c6:	48 39 d8             	cmp    %rbx,%rax
    a4c9:	7e d5                	jle    a4a0 <fwp_ring_wait+0x70>
    a4cb:	41 8b 2c 24          	mov    (%r12),%ebp
    a4cf:	b8 01 00 00 00       	mov    $0x1,%eax
    a4d4:	41 87 06             	xchg   %eax,(%r14)
    a4d7:	0f ae f0             	mfence
    a4da:	4c 89 ef             	mov    %r13,%rdi
    a4dd:	41 ff d7             	call   *%r15
    a4e0:	85 c0                	test   %eax,%eax
    a4e2:	8b 5c 24 04          	mov    0x4(%rsp),%ebx
    a4e6:	74 41                	je     a529 <fwp_ring_wait+0xf9>
    a4e8:	41 c7 06 00 00 00 00 	movl   $0x0,(%r14)
    a4ef:	b8 01 00 00 00       	mov    $0x1,%eax
    a4f4:	48 83 c4 08          	add    $0x8,%rsp
    a4f8:	5b                   	pop    %rbx
    a4f9:	41 5c                	pop    %r12
    a4fb:	41 5d                	pop    %r13
    a4fd:	41 5e                	pop    %r14
    a4ff:	41 5f                	pop    %r15
    a501:	5d                   	pop    %rbp
    a502:	c3                   	ret
    a503:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a50a:	84 00 00 00 00 00 
    a510:	41 8b 2c 24          	mov    (%r12),%ebp
    a514:	b8 01 00 00 00       	mov    $0x1,%eax
    a519:	41 87 06             	xchg   %eax,(%r14)
    a51c:	0f ae f0             	mfence
    a51f:	4c 89 ef             	mov    %r13,%rdi
    a522:	41 ff d7             	call   *%r15
    a525:	85 c0                	test   %eax,%eax
    a527:	75 bf                	jne    a4e8 <fwp_ring_wait+0xb8>
    a529:	4c 89 e7             	mov    %r12,%rdi
    a52c:	31 f6                	xor    %esi,%esi
    a52e:	89 ea                	mov    %ebp,%edx
    a530:	b9 64 00 00 00       	mov    $0x64,%ecx
    a535:	e8 86 00 00 00       	call   a5c0 <fwp_futex>
    a53a:	48 89 c5             	mov    %rax,%rbp
    a53d:	41 c7 06 00 00 00 00 	movl   $0x0,(%r14)
    a544:	4c 89 ef             	mov    %r13,%rdi
    a547:	41 ff d7             	call   *%r15
    a54a:	85 c0                	test   %eax,%eax
    a54c:	75 a1                	jne    a4ef <fwp_ring_wait+0xbf>
    a54e:	48 85 ed             	test   %rbp,%rbp
    a551:	74 bd                	je     a510 <fwp_ring_wait+0xe0>
    a553:	e8 28 7b ff ff       	call   2080 <__errno_location@plt>
    a558:	83 38 6e             	cmpl   $0x6e,(%rax)
    a55b:	75 b3                	jne    a510 <fwp_ring_wait+0xe0>
    a55d:	89 df                	mov    %ebx,%edi
    a55f:	e8 cc 00 00 00       	call   a630 <fwp_sock_gone>
    a564:	85 c0                	test   %eax,%eax
    a566:	74 a8                	je     a510 <fwp_ring_wait+0xe0>
    a568:	31 c0                	xor    %eax,%eax
    a56a:	eb 88                	jmp    a4f4 <fwp_ring_wait+0xc4>
    a56c:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000a570 <fwp_ring_has_space>:
    a570:	48 8b 8f 80 00 00 00 	mov    0x80(%rdi),%rcx
    a577:	48 2b 4f 40          	sub    0x40(%rdi),%rcx
    a57b:	31 c0                	xor    %eax,%eax
    a57d:	48 03 4f 08          	add    0x8(%rdi),%rcx
    a581:	0f 95 c0             	setne  %al
    a584:	c3                   	ret
    a585:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a58c:	00 00 00 00 

000000000000a590 <fwp_ring_wake>:
    a590:	0f ae f0             	mfence
    a593:	8b 06                	mov    (%rsi),%eax
    a595:	85 c0                	test   %eax,%eax
    a597:	74 14                	je     a5ad <fwp_ring_wake+0x1d>
    a599:	f0 ff 07             	lock incl (%rdi)
    a59c:	be 01 00 00 00       	mov    $0x1,%esi
    a5a1:	ba ff ff ff 7f       	mov    $0x7fffffff,%edx
    a5a6:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    a5ab:	eb 13                	jmp    a5c0 <fwp_futex>
    a5ad:	c3                   	ret
    a5ae:	66 90                	xchg   %ax,%ax

000000000000a5b0 <fwp_cpu_relax>:
    a5b0:	f3 90                	pause
    a5b2:	c3                   	ret
    a5b3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a5ba:	84 00 00 00 00 00 

000000000000a5c0 <fwp_futex>:
    a5c0:	48 83 ec 18          	sub    $0x18,%rsp
    a5c4:	89 c8                	mov    %ecx,%eax
    a5c6:	89 d1                	mov    %edx,%ecx
    a5c8:	89 f2                	mov    %esi,%edx
    a5ca:	48 89 fe             	mov    %rdi,%rsi
    a5cd:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
    a5d4:	00 00 
    a5d6:	48 98                	cltq
    a5d8:	48 69 f8 d3 4d 62 10 	imul   $0x10624dd3,%rax,%rdi
    a5df:	49 89 f8             	mov    %rdi,%r8
    a5e2:	49 c1 e8 3f          	shr    $0x3f,%r8
    a5e6:	48 c1 ff 26          	sar    $0x26,%rdi
    a5ea:	44 01 c7             	add    %r8d,%edi
    a5ed:	69 ff e8 03 00 00    	imul   $0x3e8,%edi,%edi
    a5f3:	41 89 c0             	mov    %eax,%r8d
    a5f6:	41 29 f8             	sub    %edi,%r8d
    a5f9:	41 69 f8 40 42 0f 00 	imul   $0xf4240,%r8d,%edi
    a600:	48 63 ff             	movslq %edi,%rdi
    a603:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    a608:	31 ff                	xor    %edi,%edi
    a60a:	85 c0                	test   %eax,%eax
    a60c:	4c 8d 44 24 08       	lea    0x8(%rsp),%r8
    a611:	4c 0f 48 c7          	cmovs  %rdi,%r8
    a615:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    a61c:	bf ca 00 00 00       	mov    $0xca,%edi
    a621:	45 31 c9             	xor    %r9d,%r9d
    a624:	31 c0                	xor    %eax,%eax
    a626:	e8 d5 7c ff ff       	call   2300 <syscall@plt>
    a62b:	48 83 c4 18          	add    $0x18,%rsp
    a62f:	c3                   	ret

000000000000a630 <fwp_sock_gone>:
    a630:	55                   	push   %rbp
    a631:	53                   	push   %rbx
    a632:	48 83 ec 18          	sub    $0x18,%rsp
    a636:	89 fb                	mov    %edi,%ebx
    a638:	89 7c 24 10          	mov    %edi,0x10(%rsp)
    a63c:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%rsp)
    a643:	00 
    a644:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    a649:	31 ed                	xor    %ebp,%ebp
    a64b:	be 01 00 00 00       	mov    $0x1,%esi
    a650:	31 d2                	xor    %edx,%edx
    a652:	e8 69 7d ff ff       	call   23c0 <poll@plt>
    a657:	85 c0                	test   %eax,%eax
    a659:	7e 2b                	jle    a686 <fwp_sock_gone+0x56>
    a65b:	bd 01 00 00 00       	mov    $0x1,%ebp
    a660:	f6 44 24 16 18       	testb  $0x18,0x16(%rsp)
    a665:	75 1f                	jne    a686 <fwp_sock_gone+0x56>
    a667:	48 8d 74 24 0f       	lea    0xf(%rsp),%rsi
    a66c:	ba 01 00 00 00       	mov    $0x1,%edx
    a671:	89 df                	mov    %ebx,%edi
    a673:	b9 42 00 00 00       	mov    $0x42,%ecx
    a678:	e8 e3 79 ff ff       	call   2060 <recv@plt>
    a67d:	31 ed                	xor    %ebp,%ebp
    a67f:	48 85 c0             	test   %rax,%rax
    a682:	40 0f 94 c5          	sete   %bpl
    a686:	89 e8                	mov    %ebp,%eax
    a688:	48 83 c4 18          	add    $0x18,%rsp
    a68c:	5b                   	pop    %rbx
    a68d:	5d                   	pop    %rbp
    a68e:	c3                   	ret
    a68f:	90                   	nop

000000000000a690 <fwp_pipe_poll>:
    a690:	83 3d 25 b6 00 00 00 	cmpl   $0x0,0xb625(%rip)        # 15cbc <fwp_po_listen>
    a697:	0f 88 9b 01 00 00    	js     a838 <fwp_pipe_poll+0x1a8>
    a69d:	55                   	push   %rbp
    a69e:	41 57                	push   %r15
    a6a0:	41 56                	push   %r14
    a6a2:	53                   	push   %rbx
    a6a3:	48 83 ec 28          	sub    $0x28,%rsp
    a6a7:	e8 44 fb ff ff       	call   a1f0 <fwp_now_ns>
    a6ac:	48 3b 05 ad b7 02 00 	cmp    0x2b7ad(%rip),%rax        # 35e60 <fwp_po_next_check>
    a6b3:	0f 8c 75 01 00 00    	jl     a82e <fwp_pipe_poll+0x19e>
    a6b9:	49 89 c6             	mov    %rax,%r14
    a6bc:	48 05 40 42 0f 00    	add    $0xf4240,%rax
    a6c2:	48 89 05 97 b7 02 00 	mov    %rax,0x2b797(%rip)        # 35e60 <fwp_po_next_check>
    a6c9:	8b 3d ed b5 00 00    	mov    0xb5ed(%rip),%edi        # 15cbc <fwp_po_listen>
    a6cf:	31 f6                	xor    %esi,%esi
    a6d1:	31 d2                	xor    %edx,%edx
    a6d3:	e8 68 7d ff ff       	call   2440 <accept@plt>
    a6d8:	85 c0                	test   %eax,%eax
    a6da:	0f 88 10 01 00 00    	js     a7f0 <fwp_pipe_poll+0x160>
    a6e0:	89 c3                	mov    %eax,%ebx
    a6e2:	8b 3d d4 b5 00 00    	mov    0xb5d4(%rip),%edi        # 15cbc <fwp_po_listen>
    a6e8:	e8 43 7b ff ff       	call   2230 <close@plt>
    a6ed:	c7 05 c5 b5 00 00 ff 	movl   $0xffffffff,0xb5c5(%rip)        # 15cbc <fwp_po_listen>
    a6f4:	ff ff ff 
    a6f7:	89 df                	mov    %ebx,%edi
    a6f9:	be 02 00 00 00       	mov    $0x2,%esi
    a6fe:	ba 01 00 00 00       	mov    $0x1,%edx
    a703:	31 c0                	xor    %eax,%eax
    a705:	e8 16 7a ff ff       	call   2120 <fcntl@plt>
    a70a:	89 df                	mov    %ebx,%edi
    a70c:	be 03 00 00 00       	mov    $0x3,%esi
    a711:	31 c0                	xor    %eax,%eax
    a713:	e8 08 7a ff ff       	call   2120 <fcntl@plt>
    a718:	25 ff f7 ff ff       	and    $0xfffff7ff,%eax
    a71d:	89 df                	mov    %ebx,%edi
    a71f:	be 04 00 00 00       	mov    $0x4,%esi
    a724:	89 c2                	mov    %eax,%edx
    a726:	31 c0                	xor    %eax,%eax
    a728:	e8 f3 79 ff ff       	call   2120 <fcntl@plt>
    a72d:	c7 44 24 18 0c 00 00 	movl   $0xc,0x18(%rsp)
    a734:	00 
    a735:	89 5c 24 10          	mov    %ebx,0x10(%rsp)
    a739:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%rsp)
    a740:	00 
    a741:	48 8d 4c 24 1c       	lea    0x1c(%rsp),%rcx
    a746:	4c 8d 44 24 18       	lea    0x18(%rsp),%r8
    a74b:	89 df                	mov    %ebx,%edi
    a74d:	be 01 00 00 00       	mov    $0x1,%esi
    a752:	ba 11 00 00 00       	mov    $0x11,%edx
    a757:	e8 44 7b ff ff       	call   22a0 <getsockopt@plt>
    a75c:	85 c0                	test   %eax,%eax
    a75e:	0f 85 c3 00 00 00    	jne    a827 <fwp_pipe_poll+0x197>
    a764:	8b 6c 24 20          	mov    0x20(%rsp),%ebp
    a768:	e8 13 7a ff ff       	call   2180 <getuid@plt>
    a76d:	39 c5                	cmp    %eax,%ebp
    a76f:	0f 85 b2 00 00 00    	jne    a827 <fwp_pipe_poll+0x197>
    a775:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    a77a:	be 01 00 00 00       	mov    $0x1,%esi
    a77f:	ba e8 03 00 00       	mov    $0x3e8,%edx
    a784:	e8 37 7c ff ff       	call   23c0 <poll@plt>
    a789:	85 c0                	test   %eax,%eax
    a78b:	0f 8e 96 00 00 00    	jle    a827 <fwp_pipe_poll+0x197>
    a791:	48 8d 74 24 03       	lea    0x3(%rsp),%rsi
    a796:	ba 05 00 00 00       	mov    $0x5,%edx
    a79b:	89 df                	mov    %ebx,%edi
    a79d:	31 c9                	xor    %ecx,%ecx
    a79f:	e8 bc 78 ff ff       	call   2060 <recv@plt>
    a7a4:	48 85 c0             	test   %rax,%rax
    a7a7:	7e 7e                	jle    a827 <fwp_pipe_poll+0x197>
    a7a9:	49 89 c6             	mov    %rax,%r14
    a7ac:	4c 8d 7c 24 10       	lea    0x10(%rsp),%r15
    a7b1:	49 83 fe 04          	cmp    $0x4,%r14
    a7b5:	77 59                	ja     a810 <fwp_pipe_poll+0x180>
    a7b7:	be 01 00 00 00       	mov    $0x1,%esi
    a7bc:	4c 89 ff             	mov    %r15,%rdi
    a7bf:	ba e8 03 00 00       	mov    $0x3e8,%edx
    a7c4:	e8 f7 7b ff ff       	call   23c0 <poll@plt>
    a7c9:	85 c0                	test   %eax,%eax
    a7cb:	7e 5a                	jle    a827 <fwp_pipe_poll+0x197>
    a7cd:	4a 8d 34 34          	lea    (%rsp,%r14,1),%rsi
    a7d1:	48 83 c6 03          	add    $0x3,%rsi
    a7d5:	ba 05 00 00 00       	mov    $0x5,%edx
    a7da:	4c 29 f2             	sub    %r14,%rdx
    a7dd:	89 df                	mov    %ebx,%edi
    a7df:	31 c9                	xor    %ecx,%ecx
    a7e1:	e8 7a 78 ff ff       	call   2060 <recv@plt>
    a7e6:	49 01 c6             	add    %rax,%r14
    a7e9:	48 85 c0             	test   %rax,%rax
    a7ec:	7f c3                	jg     a7b1 <fwp_pipe_poll+0x121>
    a7ee:	eb 37                	jmp    a827 <fwp_pipe_poll+0x197>
    a7f0:	4c 3b 35 41 b6 01 00 	cmp    0x1b641(%rip),%r14        # 25e38 <fwp_po_give_up>
    a7f7:	7e 35                	jle    a82e <fwp_pipe_poll+0x19e>
    a7f9:	8b 3d bd b4 00 00    	mov    0xb4bd(%rip),%edi        # 15cbc <fwp_po_listen>
    a7ff:	e8 2c 7a ff ff       	call   2230 <close@plt>
    a804:	c7 05 ae b4 00 00 ff 	movl   $0xffffffff,0xb4ae(%rip)        # 15cbc <fwp_po_listen>
    a80b:	ff ff ff 
    a80e:	eb 1e                	jmp    a82e <fwp_pipe_poll+0x19e>
    a810:	81 7c 24 03 46 57 50 	cmpl   $0x54505746,0x3(%rsp)
    a817:	54 
    a818:	75 0d                	jne    a827 <fwp_pipe_poll+0x197>
    a81a:	0f b6 44 24 07       	movzbl 0x7(%rsp),%eax
    a81f:	8d 48 fd             	lea    -0x3(%rax),%ecx
    a822:	80 f9 fd             	cmp    $0xfd,%cl
    a825:	77 12                	ja     a839 <fwp_pipe_poll+0x1a9>
    a827:	89 df                	mov    %ebx,%edi
    a829:	e8 02 7a ff ff       	call   2230 <close@plt>
    a82e:	48 83 c4 28          	add    $0x28,%rsp
    a832:	5b                   	pop    %rbx
    a833:	41 5e                	pop    %r14
    a835:	41 5f                	pop    %r15
    a837:	5d                   	pop    %rbp
    a838:	c3                   	ret
    a839:	89 1d 81 b4 00 00    	mov    %ebx,0xb481(%rip)        # 15cc0 <fwp_po_sock>
    a83f:	bb 01 00 00 00       	mov    $0x1,%ebx
    a844:	3c 02                	cmp    $0x2,%al
    a846:	75 10                	jne    a858 <fwp_pipe_poll+0x1c8>
    a848:	e8 53 00 00 00       	call   a8a0 <fwp_po_make_ring>
    a84d:	83 f8 01             	cmp    $0x1,%eax
    a850:	bb 02 00 00 00       	mov    $0x2,%ebx
    a855:	83 db 00             	sbb    $0x0,%ebx
    a858:	c7 44 24 08 02 01 00 	movl   $0x102,0x8(%rsp)
    a85f:	00 
    a860:	c6 44 24 0c 00       	movb   $0x0,0xc(%rsp)
    a865:	88 5c 24 0d          	mov    %bl,0xd(%rsp)
    a869:	4c 8b 35 48 97 00 00 	mov    0x9748(%rip),%r14        # 13fb8 <stdout@GLIBC_2.2.5>
    a870:	49 8b 0e             	mov    (%r14),%rcx
    a873:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    a878:	be 01 00 00 00       	mov    $0x1,%esi
    a87d:	ba 06 00 00 00       	mov    $0x6,%edx
    a882:	e8 19 7c ff ff       	call   24a0 <fwrite@plt>
    a887:	49 8b 3e             	mov    (%r14),%rdi
    a88a:	e8 c1 7a ff ff       	call   2350 <fflush@plt>
    a88f:	89 1d ab b5 01 00    	mov    %ebx,0x1b5ab(%rip)        # 25e40 <fwp_po_kind>
    a895:	eb 97                	jmp    a82e <fwp_pipe_poll+0x19e>
    a897:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    a89e:	00 00 

000000000000a8a0 <fwp_po_make_ring>:
    a8a0:	55                   	push   %rbp
    a8a1:	41 57                	push   %r15
    a8a3:	41 56                	push   %r14
    a8a5:	53                   	push   %rbx
    a8a6:	48 83 ec 68          	sub    $0x68,%rsp
    a8aa:	48 8d 35 45 4a 00 00 	lea    0x4a45(%rip),%rsi        # f2f6 <exec_in_fp0+0xca6>
    a8b1:	31 ed                	xor    %ebp,%ebp
    a8b3:	bf 3f 01 00 00       	mov    $0x13f,%edi
    a8b8:	ba 01 00 00 00       	mov    $0x1,%edx
    a8bd:	31 c0                	xor    %eax,%eax
    a8bf:	e8 3c 7a ff ff       	call   2300 <syscall@plt>
    a8c4:	48 89 c3             	mov    %rax,%rbx
    a8c7:	85 db                	test   %ebx,%ebx
    a8c9:	78 17                	js     a8e2 <fwp_po_make_ring+0x42>
    a8cb:	be 00 10 10 00       	mov    $0x101000,%esi
    a8d0:	89 df                	mov    %ebx,%edi
    a8d2:	e8 09 79 ff ff       	call   21e0 <ftruncate@plt>
    a8d7:	85 c0                	test   %eax,%eax
    a8d9:	74 14                	je     a8ef <fwp_po_make_ring+0x4f>
    a8db:	89 df                	mov    %ebx,%edi
    a8dd:	e8 4e 79 ff ff       	call   2230 <close@plt>
    a8e2:	89 e8                	mov    %ebp,%eax
    a8e4:	48 83 c4 68          	add    $0x68,%rsp
    a8e8:	5b                   	pop    %rbx
    a8e9:	41 5e                	pop    %r14
    a8eb:	41 5f                	pop    %r15
    a8ed:	5d                   	pop    %rbp
    a8ee:	c3                   	ret
    a8ef:	be 00 10 10 00       	mov    $0x101000,%esi
    a8f4:	31 ff                	xor    %edi,%edi
    a8f6:	ba 03 00 00 00       	mov    $0x3,%edx
    a8fb:	b9 01 00 00 00       	mov    $0x1,%ecx
    a900:	41 89 d8             	mov    %ebx,%r8d
    a903:	45 31 c9             	xor    %r9d,%r9d
    a906:	e8 85 78 ff ff       	call   2190 <mmap@plt>
    a90b:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    a90f:	74 ca                	je     a8db <fwp_po_make_ring+0x3b>
    a911:	49 89 c6             	mov    %rax,%r14
    a914:	48 b8 46 57 50 53 01 	movabs $0x153505746,%rax
    a91b:	00 00 00 
    a91e:	49 89 06             	mov    %rax,(%r14)
    a921:	49 c7 46 08 00 00 10 	movq   $0x100000,0x8(%r14)
    a928:	00 
    a929:	c6 44 24 07 53       	movb   $0x53,0x7(%rsp)
    a92e:	48 8d 44 24 07       	lea    0x7(%rsp),%rax
    a933:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    a938:	48 c7 44 24 28 01 00 	movq   $0x1,0x28(%rsp)
    a93f:	00 00 
    a941:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
    a948:	00 00 
    a94a:	0f 57 c0             	xorps  %xmm0,%xmm0
    a94d:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    a952:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
    a957:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    a95c:	48 c7 44 24 60 00 00 	movq   $0x0,0x60(%rsp)
    a963:	00 00 
    a965:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    a96a:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    a96f:	48 c7 44 24 48 01 00 	movq   $0x1,0x48(%rsp)
    a976:	00 00 
    a978:	48 8d 44 24 08       	lea    0x8(%rsp),%rax
    a97d:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    a982:	48 c7 44 24 58 18 00 	movq   $0x18,0x58(%rsp)
    a989:	00 00 
    a98b:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
    a992:	00 00 00 
    a995:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    a99a:	48 c7 44 24 08 14 00 	movq   $0x14,0x8(%rsp)
    a9a1:	00 00 
    a9a3:	89 5c 24 18          	mov    %ebx,0x18(%rsp)
    a9a7:	8b 3d 13 b3 00 00    	mov    0xb313(%rip),%edi        # 15cc0 <fwp_po_sock>
    a9ad:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
    a9b2:	ba 00 40 00 00       	mov    $0x4000,%edx
    a9b7:	e8 04 77 ff ff       	call   20c0 <sendmsg@plt>
    a9bc:	49 89 c7             	mov    %rax,%r15
    a9bf:	89 df                	mov    %ebx,%edi
    a9c1:	e8 6a 78 ff ff       	call   2230 <close@plt>
    a9c6:	49 83 ff 01          	cmp    $0x1,%r15
    a9ca:	75 11                	jne    a9dd <fwp_po_make_ring+0x13d>
    a9cc:	4c 89 35 7d b4 02 00 	mov    %r14,0x2b47d(%rip)        # 35e50 <fwp_po_ring>
    a9d3:	bd 01 00 00 00       	mov    $0x1,%ebp
    a9d8:	e9 05 ff ff ff       	jmp    a8e2 <fwp_po_make_ring+0x42>
    a9dd:	be 00 10 10 00       	mov    $0x101000,%esi
    a9e2:	4c 89 f7             	mov    %r14,%rdi
    a9e5:	e8 a6 79 ff ff       	call   2390 <munmap@plt>
    a9ea:	31 ed                	xor    %ebp,%ebp
    a9ec:	e9 f1 fe ff ff       	jmp    a8e2 <fwp_po_make_ring+0x42>
    a9f1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a9f8:	0f 1f 84 00 00 00 00 
    a9ff:	00 

000000000000aa00 <fwp_apply>:
    aa00:	55                   	push   %rbp
    aa01:	48 89 e5             	mov    %rsp,%rbp
    aa04:	41 57                	push   %r15
    aa06:	41 56                	push   %r14
    aa08:	41 55                	push   %r13
    aa0a:	41 54                	push   %r12
    aa0c:	53                   	push   %rbx
    aa0d:	48 83 ec 18          	sub    $0x18,%rsp
    aa11:	48 89 f3             	mov    %rsi,%rbx
    aa14:	49 89 ff             	mov    %rdi,%r15
    aa17:	be 01 00 00 00       	mov    $0x1,%esi
    aa1c:	eb 1e                	jmp    aa3c <fwp_apply+0x3c>
    aa1e:	66 90                	xchg   %ax,%ax
    aa20:	4a 8d 1c f3          	lea    (%rbx,%r14,8),%rbx
    aa24:	31 c9                	xor    %ecx,%ecx
    aa26:	49 89 c7             	mov    %rax,%r15
    aa29:	4c 8b 75 c8          	mov    -0x38(%rbp),%r14
    aa2d:	48 8b 65 c0          	mov    -0x40(%rbp),%rsp
    aa31:	89 d6                	mov    %edx,%esi
    aa33:	83 f9 01             	cmp    $0x1,%ecx
    aa36:	0f 84 ff 03 00 00    	je     ae3b <fwp_apply+0x43b>
    aa3c:	48 8b 05 5d b3 00 00 	mov    0xb35d(%rip),%rax        # 15da0 <fwp_fns>
    aa43:	41 8b 0f             	mov    (%r15),%ecx
    aa46:	45 8b 67 04          	mov    0x4(%r15),%r12d
    aa4a:	48 c1 e1 05          	shl    $0x5,%rcx
    aa4e:	44 8b 2c 08          	mov    (%rax,%rcx,1),%r13d
    aa52:	4d 85 e4             	test   %r12,%r12
    aa55:	75 39                	jne    aa90 <fwp_apply+0x90>
    aa57:	41 8d 55 ff          	lea    -0x1(%r13),%edx
    aa5b:	39 f2                	cmp    %esi,%edx
    aa5d:	73 31                	jae    aa90 <fwp_apply+0x90>
    aa5f:	49 89 f7             	mov    %rsi,%r15
    aa62:	48 89 df             	mov    %rbx,%rdi
    aa65:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    aa69:	4c 89 fe             	mov    %r15,%rsi
    aa6c:	49 89 c7             	mov    %rax,%r15
    aa6f:	44 39 ee             	cmp    %r13d,%esi
    aa72:	0f 84 c0 03 00 00    	je     ae38 <fwp_apply+0x438>
    aa78:	4a 8d 1c eb          	lea    (%rbx,%r13,8),%rbx
    aa7c:	44 29 ee             	sub    %r13d,%esi
    aa7f:	b9 03 00 00 00       	mov    $0x3,%ecx
    aa84:	83 f9 01             	cmp    $0x1,%ecx
    aa87:	75 b3                	jne    aa3c <fwp_apply+0x3c>
    aa89:	e9 ad 03 00 00       	jmp    ae3b <fwp_apply+0x43b>
    aa8e:	66 90                	xchg   %ax,%ax
    aa90:	4c 89 75 c8          	mov    %r14,-0x38(%rbp)
    aa94:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    aa98:	45 8d 34 34          	lea    (%r12,%rsi,1),%r14d
    aa9c:	45 39 ee             	cmp    %r13d,%r14d
    aa9f:	0f 82 1a 02 00 00    	jb     acbf <fwp_apply+0x2bf>
    aaa5:	48 89 65 c0          	mov    %rsp,-0x40(%rbp)
    aaa9:	45 89 eb             	mov    %r13d,%r11d
    aaac:	41 83 fd 02          	cmp    $0x2,%r13d
    aab0:	ba 01 00 00 00       	mov    $0x1,%edx
    aab5:	41 0f 43 d5          	cmovae %r13d,%edx
    aab9:	48 8d 14 d5 0f 00 00 	lea    0xf(,%rdx,8),%rdx
    aac0:	00 
    aac1:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
    aac5:	48 89 e7             	mov    %rsp,%rdi
    aac8:	48 29 d7             	sub    %rdx,%rdi
    aacb:	48 89 fc             	mov    %rdi,%rsp
    aace:	4d 85 e4             	test   %r12,%r12
    aad1:	0f 84 c9 00 00 00    	je     aba0 <fwp_apply+0x1a0>
    aad7:	41 83 fc 04          	cmp    $0x4,%r12d
    aadb:	72 10                	jb     aaed <fwp_apply+0xed>
    aadd:	48 89 fa             	mov    %rdi,%rdx
    aae0:	4c 29 fa             	sub    %r15,%rdx
    aae3:	48 83 c2 f8          	add    $0xfffffffffffffff8,%rdx
    aae7:	48 83 fa 20          	cmp    $0x20,%rdx
    aaeb:	73 65                	jae    ab52 <fwp_apply+0x152>
    aaed:	31 d2                	xor    %edx,%edx
    aaef:	4d 89 e0             	mov    %r12,%r8
    aaf2:	48 89 d6             	mov    %rdx,%rsi
    aaf5:	49 83 e0 03          	and    $0x3,%r8
    aaf9:	74 16                	je     ab11 <fwp_apply+0x111>
    aafb:	48 89 d6             	mov    %rdx,%rsi
    aafe:	66 90                	xchg   %ax,%ax
    ab00:	4d 8b 4c f7 08       	mov    0x8(%r15,%rsi,8),%r9
    ab05:	4c 89 0c f7          	mov    %r9,(%rdi,%rsi,8)
    ab09:	48 ff c6             	inc    %rsi
    ab0c:	49 ff c8             	dec    %r8
    ab0f:	75 ef                	jne    ab00 <fwp_apply+0x100>
    ab11:	4c 29 e2             	sub    %r12,%rdx
    ab14:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    ab18:	0f 87 82 00 00 00    	ja     aba0 <fwp_apply+0x1a0>
    ab1e:	66 90                	xchg   %ax,%ax
    ab20:	49 8b 54 f7 08       	mov    0x8(%r15,%rsi,8),%rdx
    ab25:	48 89 14 f7          	mov    %rdx,(%rdi,%rsi,8)
    ab29:	49 8b 54 f7 10       	mov    0x10(%r15,%rsi,8),%rdx
    ab2e:	48 89 54 f7 08       	mov    %rdx,0x8(%rdi,%rsi,8)
    ab33:	49 8b 54 f7 18       	mov    0x18(%r15,%rsi,8),%rdx
    ab38:	48 89 54 f7 10       	mov    %rdx,0x10(%rdi,%rsi,8)
    ab3d:	49 8b 54 f7 20       	mov    0x20(%r15,%rsi,8),%rdx
    ab42:	48 89 54 f7 18       	mov    %rdx,0x18(%rdi,%rsi,8)
    ab47:	48 83 c6 04          	add    $0x4,%rsi
    ab4b:	49 39 f4             	cmp    %rsi,%r12
    ab4e:	75 d0                	jne    ab20 <fwp_apply+0x120>
    ab50:	eb 4e                	jmp    aba0 <fwp_apply+0x1a0>
    ab52:	44 89 e2             	mov    %r12d,%edx
    ab55:	83 e2 fc             	and    $0xfffffffc,%edx
    ab58:	4a 8d 34 e5 00 00 00 	lea    0x0(,%r12,8),%rsi
    ab5f:	00 
    ab60:	48 83 e6 e0          	and    $0xffffffffffffffe0,%rsi
    ab64:	45 31 c0             	xor    %r8d,%r8d
    ab67:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    ab6e:	00 00 
    ab70:	43 0f 10 44 07 08    	movups 0x8(%r15,%r8,1),%xmm0
    ab76:	43 0f 10 4c 07 18    	movups 0x18(%r15,%r8,1),%xmm1
    ab7c:	42 0f 29 04 07       	movaps %xmm0,(%rdi,%r8,1)
    ab81:	42 0f 29 4c 07 10    	movaps %xmm1,0x10(%rdi,%r8,1)
    ab87:	49 83 c0 20          	add    $0x20,%r8
    ab8b:	4c 39 c6             	cmp    %r8,%rsi
    ab8e:	75 e0                	jne    ab70 <fwp_apply+0x170>
    ab90:	4c 39 e2             	cmp    %r12,%rdx
    ab93:	0f 85 56 ff ff ff    	jne    aaef <fwp_apply+0xef>
    ab99:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    aba0:	45 29 e3             	sub    %r12d,%r11d
    aba3:	45 89 de             	mov    %r11d,%r14d
    aba6:	45 39 e5             	cmp    %r12d,%r13d
    aba9:	0f 84 85 00 00 00    	je     ac34 <fwp_apply+0x234>
    abaf:	41 83 fb 0e          	cmp    $0xe,%r11d
    abb3:	0f 83 a0 00 00 00    	jae    ac59 <fwp_apply+0x259>
    abb9:	31 d2                	xor    %edx,%edx
    abbb:	4d 89 f0             	mov    %r14,%r8
    abbe:	48 89 d6             	mov    %rdx,%rsi
    abc1:	49 83 e0 03          	and    $0x3,%r8
    abc5:	74 1d                	je     abe4 <fwp_apply+0x1e4>
    abc7:	48 89 d6             	mov    %rdx,%rsi
    abca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    abd0:	4c 8b 0c f3          	mov    (%rbx,%rsi,8),%r9
    abd4:	45 8d 14 34          	lea    (%r12,%rsi,1),%r10d
    abd8:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    abdc:	48 ff c6             	inc    %rsi
    abdf:	49 ff c8             	dec    %r8
    abe2:	75 ec                	jne    abd0 <fwp_apply+0x1d0>
    abe4:	4c 29 f2             	sub    %r14,%rdx
    abe7:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    abeb:	77 47                	ja     ac34 <fwp_apply+0x234>
    abed:	0f 1f 00             	nopl   (%rax)
    abf0:	48 8b 14 f3          	mov    (%rbx,%rsi,8),%rdx
    abf4:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    abf8:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    abfc:	48 8b 54 f3 08       	mov    0x8(%rbx,%rsi,8),%rdx
    ac01:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    ac05:	41 ff c0             	inc    %r8d
    ac08:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    ac0c:	48 8b 54 f3 10       	mov    0x10(%rbx,%rsi,8),%rdx
    ac11:	45 8d 44 34 02       	lea    0x2(%r12,%rsi,1),%r8d
    ac16:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    ac1a:	48 8b 54 f3 18       	mov    0x18(%rbx,%rsi,8),%rdx
    ac1f:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    ac23:	41 83 c0 03          	add    $0x3,%r8d
    ac27:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    ac2b:	48 83 c6 04          	add    $0x4,%rsi
    ac2f:	49 39 f6             	cmp    %rsi,%r14
    ac32:	75 bc                	jne    abf0 <fwp_apply+0x1f0>
    ac34:	45 89 dc             	mov    %r11d,%r12d
    ac37:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    ac3b:	b9 01 00 00 00       	mov    $0x1,%ecx
    ac40:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    ac44:	89 f2                	mov    %esi,%edx
    ac46:	44 29 e2             	sub    %r12d,%edx
    ac49:	0f 85 d1 fd ff ff    	jne    aa20 <fwp_apply+0x20>
    ac4f:	89 f2                	mov    %esi,%edx
    ac51:	49 89 c6             	mov    %rax,%r14
    ac54:	e9 d4 fd ff ff       	jmp    aa2d <fwp_apply+0x2d>
    ac59:	49 8d 56 ff          	lea    -0x1(%r14),%rdx
    ac5d:	89 d6                	mov    %edx,%esi
    ac5f:	44 01 e6             	add    %r12d,%esi
    ac62:	0f 82 51 ff ff ff    	jb     abb9 <fwp_apply+0x1b9>
    ac68:	48 c1 ea 20          	shr    $0x20,%rdx
    ac6c:	ba 00 00 00 00       	mov    $0x0,%edx
    ac71:	0f 85 44 ff ff ff    	jne    abbb <fwp_apply+0x1bb>
    ac77:	4a 8d 14 e7          	lea    (%rdi,%r12,8),%rdx
    ac7b:	48 29 da             	sub    %rbx,%rdx
    ac7e:	48 83 fa 20          	cmp    $0x20,%rdx
    ac82:	0f 82 31 ff ff ff    	jb     abb9 <fwp_apply+0x1b9>
    ac88:	44 89 f2             	mov    %r14d,%edx
    ac8b:	83 e2 fc             	and    $0xfffffffc,%edx
    ac8e:	31 f6                	xor    %esi,%esi
    ac90:	0f 10 04 f3          	movups (%rbx,%rsi,8),%xmm0
    ac94:	0f 10 4c f3 10       	movups 0x10(%rbx,%rsi,8),%xmm1
    ac99:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    ac9d:	42 0f 11 04 c7       	movups %xmm0,(%rdi,%r8,8)
    aca2:	42 0f 11 4c c7 10    	movups %xmm1,0x10(%rdi,%r8,8)
    aca8:	48 83 c6 04          	add    $0x4,%rsi
    acac:	48 39 f2             	cmp    %rsi,%rdx
    acaf:	75 df                	jne    ac90 <fwp_apply+0x290>
    acb1:	4c 39 f2             	cmp    %r14,%rdx
    acb4:	0f 85 01 ff ff ff    	jne    abbb <fwp_apply+0x1bb>
    acba:	e9 75 ff ff ff       	jmp    ac34 <fwp_apply+0x234>
    acbf:	44 89 f0             	mov    %r14d,%eax
    acc2:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    acc9:	00 
    acca:	e8 61 aa ff ff       	call   5730 <fwp_alloc>
    accf:	41 8b 0f             	mov    (%r15),%ecx
    acd2:	89 08                	mov    %ecx,(%rax)
    acd4:	44 89 70 04          	mov    %r14d,0x4(%rax)
    acd8:	49 89 c6             	mov    %rax,%r14
    acdb:	4d 85 e4             	test   %r12,%r12
    acde:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    ace2:	0f 84 b9 00 00 00    	je     ada1 <fwp_apply+0x3a1>
    ace8:	31 c0                	xor    %eax,%eax
    acea:	41 83 fc 06          	cmp    $0x6,%r12d
    acee:	72 46                	jb     ad36 <fwp_apply+0x336>
    acf0:	4c 89 f1             	mov    %r14,%rcx
    acf3:	4c 29 f9             	sub    %r15,%rcx
    acf6:	48 83 f9 20          	cmp    $0x20,%rcx
    acfa:	72 3a                	jb     ad36 <fwp_apply+0x336>
    acfc:	44 89 e0             	mov    %r12d,%eax
    acff:	83 e0 fc             	and    $0xfffffffc,%eax
    ad02:	4a 8d 0c e5 00 00 00 	lea    0x0(,%r12,8),%rcx
    ad09:	00 
    ad0a:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    ad0e:	31 d2                	xor    %edx,%edx
    ad10:	41 0f 10 44 17 08    	movups 0x8(%r15,%rdx,1),%xmm0
    ad16:	41 0f 10 4c 17 18    	movups 0x18(%r15,%rdx,1),%xmm1
    ad1c:	41 0f 11 44 16 08    	movups %xmm0,0x8(%r14,%rdx,1)
    ad22:	41 0f 11 4c 16 18    	movups %xmm1,0x18(%r14,%rdx,1)
    ad28:	48 83 c2 20          	add    $0x20,%rdx
    ad2c:	48 39 d1             	cmp    %rdx,%rcx
    ad2f:	75 df                	jne    ad10 <fwp_apply+0x310>
    ad31:	4c 39 e0             	cmp    %r12,%rax
    ad34:	74 6b                	je     ada1 <fwp_apply+0x3a1>
    ad36:	4c 89 e2             	mov    %r12,%rdx
    ad39:	48 89 c1             	mov    %rax,%rcx
    ad3c:	48 83 e2 03          	and    $0x3,%rdx
    ad40:	74 20                	je     ad62 <fwp_apply+0x362>
    ad42:	48 89 c1             	mov    %rax,%rcx
    ad45:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    ad4c:	00 00 00 00 
    ad50:	49 8b 74 cf 08       	mov    0x8(%r15,%rcx,8),%rsi
    ad55:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    ad5a:	48 ff c1             	inc    %rcx
    ad5d:	48 ff ca             	dec    %rdx
    ad60:	75 ee                	jne    ad50 <fwp_apply+0x350>
    ad62:	4c 29 e0             	sub    %r12,%rax
    ad65:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    ad69:	77 36                	ja     ada1 <fwp_apply+0x3a1>
    ad6b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    ad70:	49 8b 44 cf 08       	mov    0x8(%r15,%rcx,8),%rax
    ad75:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    ad7a:	49 8b 44 cf 10       	mov    0x10(%r15,%rcx,8),%rax
    ad7f:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    ad84:	49 8b 44 cf 18       	mov    0x18(%r15,%rcx,8),%rax
    ad89:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    ad8e:	49 8b 44 cf 20       	mov    0x20(%r15,%rcx,8),%rax
    ad93:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    ad98:	48 83 c1 04          	add    $0x4,%rcx
    ad9c:	49 39 cc             	cmp    %rcx,%r12
    ad9f:	75 cf                	jne    ad70 <fwp_apply+0x370>
    ada1:	85 ff                	test   %edi,%edi
    ada3:	0f 84 92 00 00 00    	je     ae3b <fwp_apply+0x43b>
    ada9:	89 f8                	mov    %edi,%eax
    adab:	83 ff 14             	cmp    $0x14,%edi
    adae:	0f 83 99 00 00 00    	jae    ae4d <fwp_apply+0x44d>
    adb4:	31 c9                	xor    %ecx,%ecx
    adb6:	48 89 c6             	mov    %rax,%rsi
    adb9:	48 89 ca             	mov    %rcx,%rdx
    adbc:	48 83 e6 03          	and    $0x3,%rsi
    adc0:	74 23                	je     ade5 <fwp_apply+0x3e5>
    adc2:	48 89 ca             	mov    %rcx,%rdx
    adc5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    adcc:	00 00 00 00 
    add0:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    add4:	45 8d 04 14          	lea    (%r12,%rdx,1),%r8d
    add8:	4b 89 7c c6 08       	mov    %rdi,0x8(%r14,%r8,8)
    addd:	48 ff c2             	inc    %rdx
    ade0:	48 ff ce             	dec    %rsi
    ade3:	75 eb                	jne    add0 <fwp_apply+0x3d0>
    ade5:	48 29 c1             	sub    %rax,%rcx
    ade8:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    adec:	77 4d                	ja     ae3b <fwp_apply+0x43b>
    adee:	66 90                	xchg   %ax,%ax
    adf0:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    adf4:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    adf8:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    adfd:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    ae02:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    ae06:	ff c6                	inc    %esi
    ae08:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    ae0d:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    ae12:	41 8d 74 14 02       	lea    0x2(%r12,%rdx,1),%esi
    ae17:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    ae1c:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    ae21:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    ae25:	83 c6 03             	add    $0x3,%esi
    ae28:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    ae2d:	48 83 c2 04          	add    $0x4,%rdx
    ae31:	48 39 d0             	cmp    %rdx,%rax
    ae34:	75 ba                	jne    adf0 <fwp_apply+0x3f0>
    ae36:	eb 03                	jmp    ae3b <fwp_apply+0x43b>
    ae38:	4d 89 fe             	mov    %r15,%r14
    ae3b:	4c 89 f0             	mov    %r14,%rax
    ae3e:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    ae42:	5b                   	pop    %rbx
    ae43:	41 5c                	pop    %r12
    ae45:	41 5d                	pop    %r13
    ae47:	41 5e                	pop    %r14
    ae49:	41 5f                	pop    %r15
    ae4b:	5d                   	pop    %rbp
    ae4c:	c3                   	ret
    ae4d:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    ae51:	31 c9                	xor    %ecx,%ecx
    ae53:	89 d6                	mov    %edx,%esi
    ae55:	44 01 e6             	add    %r12d,%esi
    ae58:	0f 82 58 ff ff ff    	jb     adb6 <fwp_apply+0x3b6>
    ae5e:	48 c1 ea 20          	shr    $0x20,%rdx
    ae62:	0f 85 4e ff ff ff    	jne    adb6 <fwp_apply+0x3b6>
    ae68:	4b 8d 0c e6          	lea    (%r14,%r12,8),%rcx
    ae6c:	48 29 d9             	sub    %rbx,%rcx
    ae6f:	48 83 c1 08          	add    $0x8,%rcx
    ae73:	48 83 f9 20          	cmp    $0x20,%rcx
    ae77:	0f 82 37 ff ff ff    	jb     adb4 <fwp_apply+0x3b4>
    ae7d:	89 c1                	mov    %eax,%ecx
    ae7f:	83 e1 fc             	and    $0xfffffffc,%ecx
    ae82:	31 d2                	xor    %edx,%edx
    ae84:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    ae8b:	00 00 00 00 00 
    ae90:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    ae94:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    ae99:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    ae9d:	41 0f 11 44 f6 08    	movups %xmm0,0x8(%r14,%rsi,8)
    aea3:	41 0f 11 4c f6 18    	movups %xmm1,0x18(%r14,%rsi,8)
    aea9:	48 83 c2 04          	add    $0x4,%rdx
    aead:	48 39 d1             	cmp    %rdx,%rcx
    aeb0:	75 de                	jne    ae90 <fwp_apply+0x490>
    aeb2:	48 39 c1             	cmp    %rax,%rcx
    aeb5:	0f 85 fb fe ff ff    	jne    adb6 <fwp_apply+0x3b6>
    aebb:	e9 7b ff ff ff       	jmp    ae3b <fwp_apply+0x43b>

000000000000aec0 <fwp_pap>:
    aec0:	50                   	push   %rax
    aec1:	bf 08 00 00 00       	mov    $0x8,%edi
    aec6:	e8 65 a8 ff ff       	call   5730 <fwp_alloc>
    aecb:	48 c7 00 01 00 00 00 	movq   $0x1,(%rax)
    aed2:	59                   	pop    %rcx
    aed3:	c3                   	ret
    aed4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    aedb:	00 00 00 00 00 

000000000000aee0 <fwp_exec_error>:
    aee0:	41 57                	push   %r15
    aee2:	41 56                	push   %r14
    aee4:	53                   	push   %rbx
    aee5:	48 89 f3             	mov    %rsi,%rbx
    aee8:	49 89 fe             	mov    %rdi,%r14
    aeeb:	e8 80 bd ff ff       	call   6c70 <fwp_pipe_flush>
    aef0:	4c 8b 3d e9 90 00 00 	mov    0x90e9(%rip),%r15        # 13fe0 <stderr@GLIBC_2.2.5>
    aef7:	49 8b 3f             	mov    (%r15),%rdi
    aefa:	48 8d 35 16 44 00 00 	lea    0x4416(%rip),%rsi        # f317 <exec_in_fp0+0xcc7>
    af01:	48 8d 15 78 37 00 00 	lea    0x3778(%rip),%rdx        # e680 <exec_in_fp0+0x30>
    af08:	31 c0                	xor    %eax,%eax
    af0a:	e8 e1 73 ff ff       	call   22f0 <fprintf@plt>
    af0f:	83 3b 10             	cmpl   $0x10,(%rbx)
    af12:	75 1f                	jne    af33 <fwp_exec_error+0x53>
    af14:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    af18:	48 85 ff             	test   %rdi,%rdi
    af1b:	74 16                	je     af33 <fwp_exec_error+0x53>
    af1d:	48 8d 35 f8 43 00 00 	lea    0x43f8(%rip),%rsi        # f31c <exec_in_fp0+0xccc>
    af24:	e8 a7 73 ff ff       	call   22d0 <strcmp@plt>
    af29:	85 c0                	test   %eax,%eax
    af2b:	75 06                	jne    af33 <fwp_exec_error+0x53>
    af2d:	83 7b 10 02          	cmpl   $0x2,0x10(%rbx)
    af31:	74 20                	je     af53 <fwp_exec_error+0x73>
    af33:	49 8b 17             	mov    (%r15),%rdx
    af36:	4c 89 f7             	mov    %r14,%rdi
    af39:	48 89 de             	mov    %rbx,%rsi
    af3c:	e8 2f 00 00 00       	call   af70 <fwp_display_top>
    af41:	49 8b 37             	mov    (%r15),%rsi
    af44:	bf 0a 00 00 00       	mov    $0xa,%edi
    af49:	5b                   	pop    %rbx
    af4a:	41 5e                	pop    %r14
    af4c:	41 5f                	pop    %r15
    af4e:	e9 ed 72 ff ff       	jmp    2240 <fputc@plt>
    af53:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    af57:	48 8b 17             	mov    (%rdi),%rdx
    af5a:	48 83 c7 08          	add    $0x8,%rdi
    af5e:	49 8b 0f             	mov    (%r15),%rcx
    af61:	be 01 00 00 00       	mov    $0x1,%esi
    af66:	e8 35 75 ff ff       	call   24a0 <fwrite@plt>
    af6b:	eb d4                	jmp    af41 <fwp_exec_error+0x61>
    af6d:	0f 1f 00             	nopl   (%rax)

000000000000af70 <fwp_display_top>:
    af70:	53                   	push   %rbx
    af71:	48 83 ec 20          	sub    $0x20,%rsp
    af75:	48 89 d3             	mov    %rdx,%rbx
    af78:	48 89 f2             	mov    %rsi,%rdx
    af7b:	48 89 fe             	mov    %rdi,%rsi
    af7e:	0f 57 c0             	xorps  %xmm0,%xmm0
    af81:	0f 29 04 24          	movaps %xmm0,(%rsp)
    af85:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    af8c:	00 00 
    af8e:	48 89 e7             	mov    %rsp,%rdi
    af91:	b9 01 00 00 00       	mov    $0x1,%ecx
    af96:	e8 35 00 00 00       	call   afd0 <fwp_write>
    af9b:	48 8b 3c 24          	mov    (%rsp),%rdi
    af9f:	48 85 ff             	test   %rdi,%rdi
    afa2:	74 18                	je     afbc <fwp_display_top+0x4c>
    afa4:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    afa9:	be 01 00 00 00       	mov    $0x1,%esi
    afae:	48 89 d9             	mov    %rbx,%rcx
    afb1:	e8 ea 74 ff ff       	call   24a0 <fwrite@plt>
    afb6:	48 8b 3c 24          	mov    (%rsp),%rdi
    afba:	eb 02                	jmp    afbe <fwp_display_top+0x4e>
    afbc:	31 ff                	xor    %edi,%edi
    afbe:	e8 8d 70 ff ff       	call   2050 <free@plt>
    afc3:	48 83 c4 20          	add    $0x20,%rsp
    afc7:	5b                   	pop    %rbx
    afc8:	c3                   	ret
    afc9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000afd0 <fwp_write>:
    afd0:	55                   	push   %rbp
    afd1:	41 57                	push   %r15
    afd3:	41 56                	push   %r14
    afd5:	41 55                	push   %r13
    afd7:	41 54                	push   %r12
    afd9:	53                   	push   %rbx
    afda:	48 81 ec 28 02 00 00 	sub    $0x228,%rsp
    afe1:	8b 02                	mov    (%rdx),%eax
    afe3:	48 83 f8 19          	cmp    $0x19,%rax
    afe7:	0f 87 3f 05 00 00    	ja     b52c <fwp_write+0x55c>
    afed:	49 89 f5             	mov    %rsi,%r13
    aff0:	48 89 fb             	mov    %rdi,%rbx
    aff3:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
    aff8:	48 8d 15 45 33 00 00 	lea    0x3345(%rip),%rdx        # e344 <_IO_stdin_used+0x344>
    afff:	48 63 34 82          	movslq (%rdx,%rax,4),%rsi
    b003:	48 01 d6             	add    %rdx,%rsi
    b006:	ff e6                	jmp    *%rsi
    b008:	48 8d 15 15 43 00 00 	lea    0x4315(%rip),%rdx        # f324 <exec_in_fp0+0xcd4>
    b00f:	eb 07                	jmp    b018 <fwp_write+0x48>
    b011:	48 8d 15 d4 42 00 00 	lea    0x42d4(%rip),%rdx        # f2ec <exec_in_fp0+0xc9c>
    b018:	4c 8d 7c 24 20       	lea    0x20(%rsp),%r15
    b01d:	be 00 02 00 00       	mov    $0x200,%esi
    b022:	4c 89 ff             	mov    %r15,%rdi
    b025:	4c 89 e9             	mov    %r13,%rcx
    b028:	31 c0                	xor    %eax,%eax
    b02a:	e8 a1 71 ff ff       	call   21d0 <snprintf@plt>
    b02f:	48 89 df             	mov    %rbx,%rdi
    b032:	4c 89 fe             	mov    %r15,%rsi
    b035:	e9 ed 04 00 00       	jmp    b527 <fwp_write+0x557>
    b03a:	83 f8 13             	cmp    $0x13,%eax
    b03d:	48 8d 05 11 43 00 00 	lea    0x4311(%rip),%rax        # f355 <exec_in_fp0+0xd05>
    b044:	48 8d 35 0f 43 00 00 	lea    0x430f(%rip),%rsi        # f35a <exec_in_fp0+0xd0a>
    b04b:	48 0f 44 f0          	cmove  %rax,%rsi
    b04f:	48 89 df             	mov    %rbx,%rdi
    b052:	e8 09 ca ff ff       	call   7a60 <buf_puts>
    b057:	49 83 7d 00 00       	cmpq   $0x0,0x0(%r13)
    b05c:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    b061:	0f 84 cb 00 00 00    	je     b132 <fwp_write+0x162>
    b067:	4d 89 ec             	mov    %r13,%r12
    b06a:	48 8b 50 38          	mov    0x38(%rax),%rdx
    b06e:	48 89 df             	mov    %rbx,%rdi
    b071:	4c 89 eb             	mov    %r13,%rbx
    b074:	49 8b 74 24 08       	mov    0x8(%r12),%rsi
    b079:	49 89 c6             	mov    %rax,%r14
    b07c:	49 89 ff             	mov    %rdi,%r15
    b07f:	31 c9                	xor    %ecx,%ecx
    b081:	e8 4a ff ff ff       	call   afd0 <fwp_write>
    b086:	41 83 3e 12          	cmpl   $0x12,(%r14)
    b08a:	75 29                	jne    b0b5 <fwp_write+0xe5>
    b08c:	48 8d 35 86 42 00 00 	lea    0x4286(%rip),%rsi        # f319 <exec_in_fp0+0xcc9>
    b093:	4d 89 fe             	mov    %r15,%r14
    b096:	4c 89 ff             	mov    %r15,%rdi
    b099:	e8 c2 c9 ff ff       	call   7a60 <buf_puts>
    b09e:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    b0a2:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    b0a7:	48 8b 50 40          	mov    0x40(%rax),%rdx
    b0ab:	4c 89 ff             	mov    %r15,%rdi
    b0ae:	31 c9                	xor    %ecx,%ecx
    b0b0:	e8 1b ff ff ff       	call   afd0 <fwp_write>
    b0b5:	48 83 3b 02          	cmpq   $0x2,(%rbx)
    b0b9:	4c 89 fb             	mov    %r15,%rbx
    b0bc:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    b0c1:	72 6f                	jb     b132 <fwp_write+0x162>
    b0c3:	4d 8d 74 24 20       	lea    0x20(%r12),%r14
    b0c8:	bd 01 00 00 00       	mov    $0x1,%ebp
    b0cd:	4c 8d 2d 9a 41 00 00 	lea    0x419a(%rip),%r13        # f26e <exec_in_fp0+0xc1e>
    b0d4:	eb 17                	jmp    b0ed <fwp_write+0x11d>
    b0d6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    b0dd:	00 00 00 
    b0e0:	48 ff c5             	inc    %rbp
    b0e3:	49 83 c6 10          	add    $0x10,%r14
    b0e7:	49 3b 2c 24          	cmp    (%r12),%rbp
    b0eb:	73 45                	jae    b132 <fwp_write+0x162>
    b0ed:	48 89 df             	mov    %rbx,%rdi
    b0f0:	4c 89 ee             	mov    %r13,%rsi
    b0f3:	e8 68 c9 ff ff       	call   7a60 <buf_puts>
    b0f8:	49 8b 76 f8          	mov    -0x8(%r14),%rsi
    b0fc:	49 8b 57 38          	mov    0x38(%r15),%rdx
    b100:	48 89 df             	mov    %rbx,%rdi
    b103:	31 c9                	xor    %ecx,%ecx
    b105:	e8 c6 fe ff ff       	call   afd0 <fwp_write>
    b10a:	41 83 3f 12          	cmpl   $0x12,(%r15)
    b10e:	75 d0                	jne    b0e0 <fwp_write+0x110>
    b110:	48 89 df             	mov    %rbx,%rdi
    b113:	48 8d 35 ff 41 00 00 	lea    0x41ff(%rip),%rsi        # f319 <exec_in_fp0+0xcc9>
    b11a:	e8 41 c9 ff ff       	call   7a60 <buf_puts>
    b11f:	49 8b 36             	mov    (%r14),%rsi
    b122:	49 8b 57 40          	mov    0x40(%r15),%rdx
    b126:	48 89 df             	mov    %rbx,%rdi
    b129:	31 c9                	xor    %ecx,%ecx
    b12b:	e8 a0 fe ff ff       	call   afd0 <fwp_write>
    b130:	eb ae                	jmp    b0e0 <fwp_write+0x110>
    b132:	48 89 df             	mov    %rbx,%rdi
    b135:	be 7d 00 00 00       	mov    $0x7d,%esi
    b13a:	e9 48 05 00 00       	jmp    b687 <fwp_write+0x6b7>
    b13f:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    b144:	4d 8b 67 08          	mov    0x8(%r15),%r12
    b148:	4d 85 e4             	test   %r12,%r12
    b14b:	0f 84 38 04 00 00    	je     b589 <fwp_write+0x5b9>
    b151:	48 8d 35 33 41 00 00 	lea    0x4133(%rip),%rsi        # f28b <exec_in_fp0+0xc3b>
    b158:	4c 89 e7             	mov    %r12,%rdi
    b15b:	e8 70 71 ff ff       	call   22d0 <strcmp@plt>
    b160:	85 c0                	test   %eax,%eax
    b162:	0f 84 44 05 00 00    	je     b6ac <fwp_write+0x6dc>
    b168:	4d 8d 77 10          	lea    0x10(%r15),%r14
    b16c:	48 89 df             	mov    %rbx,%rdi
    b16f:	4c 89 e6             	mov    %r12,%rsi
    b172:	e8 e9 c8 ff ff       	call   7a60 <buf_puts>
    b177:	48 89 df             	mov    %rbx,%rdi
    b17a:	be 20 00 00 00       	mov    $0x20,%esi
    b17f:	e8 bc c8 ff ff       	call   7a40 <buf_putc>
    b184:	31 ed                	xor    %ebp,%ebp
    b186:	e9 1f 04 00 00       	jmp    b5aa <fwp_write+0x5da>
    b18b:	4c 89 ef             	mov    %r13,%rdi
    b18e:	e8 cd ef ff ff       	call   a160 <fwp_tag>
    b193:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    b198:	49 8b 4f 18          	mov    0x18(%r15),%rcx
    b19c:	41 89 c6             	mov    %eax,%r14d
    b19f:	4a 8b 34 f1          	mov    (%rcx,%r14,8),%rsi
    b1a3:	48 89 df             	mov    %rbx,%rdi
    b1a6:	e8 b5 c8 ff ff       	call   7a60 <buf_puts>
    b1ab:	49 8b 47 28          	mov    0x28(%r15),%rax
    b1af:	42 83 3c b0 00       	cmpl   $0x0,(%rax,%r14,4)
    b1b4:	0f 8e 72 03 00 00    	jle    b52c <fwp_write+0x55c>
    b1ba:	4c 89 f1             	mov    %r14,%rcx
    b1bd:	45 31 f6             	xor    %r14d,%r14d
    b1c0:	4c 89 6c 24 18       	mov    %r13,0x18(%rsp)
    b1c5:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
    b1ca:	eb 3d                	jmp    b209 <fwp_write+0x239>
    b1cc:	0f 1f 40 00          	nopl   0x0(%rax)
    b1d0:	48 89 dd             	mov    %rbx,%rbp
    b1d3:	48 89 df             	mov    %rbx,%rdi
    b1d6:	4c 89 e6             	mov    %r12,%rsi
    b1d9:	4c 89 ea             	mov    %r13,%rdx
    b1dc:	31 c9                	xor    %ecx,%ecx
    b1de:	e8 ed fd ff ff       	call   afd0 <fwp_write>
    b1e3:	49 ff c6             	inc    %r14
    b1e6:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    b1eb:	49 8b 47 28          	mov    0x28(%r15),%rax
    b1ef:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    b1f4:	48 63 04 88          	movslq (%rax,%rcx,4),%rax
    b1f8:	49 39 c6             	cmp    %rax,%r14
    b1fb:	4c 8b 6c 24 18       	mov    0x18(%rsp),%r13
    b200:	48 89 eb             	mov    %rbp,%rbx
    b203:	0f 8d 23 03 00 00    	jge    b52c <fwp_write+0x55c>
    b209:	4f 8b 64 f5 08       	mov    0x8(%r13,%r14,8),%r12
    b20e:	49 8b 47 30          	mov    0x30(%r15),%rax
    b212:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    b216:	4e 8b 2c f0          	mov    (%rax,%r14,8),%r13
    b21a:	48 89 df             	mov    %rbx,%rdi
    b21d:	be 20 00 00 00       	mov    $0x20,%esi
    b222:	e8 19 c8 ff ff       	call   7a40 <buf_putc>
    b227:	4c 89 e7             	mov    %r12,%rdi
    b22a:	4c 89 ee             	mov    %r13,%rsi
    b22d:	e8 8e 0e 00 00       	call   c0c0 <fwp_needs_parens>
    b232:	85 c0                	test   %eax,%eax
    b234:	74 9a                	je     b1d0 <fwp_write+0x200>
    b236:	48 89 df             	mov    %rbx,%rdi
    b239:	be 28 00 00 00       	mov    $0x28,%esi
    b23e:	e8 fd c7 ff ff       	call   7a40 <buf_putc>
    b243:	48 89 df             	mov    %rbx,%rdi
    b246:	4c 89 e6             	mov    %r12,%rsi
    b249:	4c 89 ea             	mov    %r13,%rdx
    b24c:	31 c9                	xor    %ecx,%ecx
    b24e:	e8 7d fd ff ff       	call   afd0 <fwp_write>
    b253:	48 89 dd             	mov    %rbx,%rbp
    b256:	48 89 df             	mov    %rbx,%rdi
    b259:	be 29 00 00 00       	mov    $0x29,%esi
    b25e:	e8 dd c7 ff ff       	call   7a40 <buf_putc>
    b263:	e9 7b ff ff ff       	jmp    b1e3 <fwp_write+0x213>
    b268:	4c 89 ef             	mov    %r13,%rdi
    b26b:	e8 50 7e ff ff       	call   30c0 <fwp_f64>
    b270:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    b275:	4c 89 f7             	mov    %r14,%rdi
    b278:	e8 93 08 00 00       	call   bb10 <fwp_fmt_f64>
    b27d:	e9 9f 02 00 00       	jmp    b521 <fwp_write+0x551>
    b282:	48 89 df             	mov    %rbx,%rdi
    b285:	be 3c 00 00 00       	mov    $0x3c,%esi
    b28a:	e8 b1 c7 ff ff       	call   7a40 <buf_putc>
    b28f:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    b294:	48 8b 70 08          	mov    0x8(%rax),%rsi
    b298:	48 89 df             	mov    %rbx,%rdi
    b29b:	e9 d7 02 00 00       	jmp    b577 <fwp_write+0x5a7>
    b2a0:	48 8d 35 8d 40 00 00 	lea    0x408d(%rip),%rsi        # f334 <exec_in_fp0+0xce4>
    b2a7:	e9 99 02 00 00       	jmp    b545 <fwp_write+0x575>
    b2ac:	49 8d 75 08          	lea    0x8(%r13),%rsi
    b2b0:	49 8b 55 00          	mov    0x0(%r13),%rdx
    b2b4:	48 89 df             	mov    %rbx,%rdi
    b2b7:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b2be:	85 c9                	test   %ecx,%ecx
    b2c0:	0f 84 d7 03 00 00    	je     b69d <fwp_write+0x6cd>
    b2c6:	5b                   	pop    %rbx
    b2c7:	41 5c                	pop    %r12
    b2c9:	41 5d                	pop    %r13
    b2cb:	41 5e                	pop    %r14
    b2cd:	41 5f                	pop    %r15
    b2cf:	5d                   	pop    %rbp
    b2d0:	e9 bb c7 ff ff       	jmp    7a90 <buf_put>
    b2d5:	4c 89 ef             	mov    %r13,%rdi
    b2d8:	e8 33 ee ff ff       	call   a110 <fwp_u128>
    b2dd:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    b2e2:	4c 89 f7             	mov    %r14,%rdi
    b2e5:	48 89 c6             	mov    %rax,%rsi
    b2e8:	e8 13 04 00 00       	call   b700 <fwp_fmt_u128>
    b2ed:	e9 2f 02 00 00       	jmp    b521 <fwp_write+0x551>
    b2f2:	4c 89 ef             	mov    %r13,%rdi
    b2f5:	e8 06 ee ff ff       	call   a100 <fwp_i128>
    b2fa:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    b2ff:	4c 89 f7             	mov    %r14,%rdi
    b302:	48 89 c6             	mov    %rax,%rsi
    b305:	e8 d6 03 00 00       	call   b6e0 <fwp_fmt_i128>
    b30a:	e9 12 02 00 00       	jmp    b521 <fwp_write+0x551>
    b30f:	48 89 df             	mov    %rbx,%rdi
    b312:	be 5b 00 00 00       	mov    $0x5b,%esi
    b317:	e8 24 c7 ff ff       	call   7a40 <buf_putc>
    b31c:	4d 85 ed             	test   %r13,%r13
    b31f:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    b324:	0f 84 d5 01 00 00    	je     b4ff <fwp_write+0x52f>
    b32a:	49 8b 57 38          	mov    0x38(%r15),%rdx
    b32e:	49 8b 75 08          	mov    0x8(%r13),%rsi
    b332:	48 89 df             	mov    %rbx,%rdi
    b335:	31 c9                	xor    %ecx,%ecx
    b337:	e8 94 fc ff ff       	call   afd0 <fwp_write>
    b33c:	4d 8b 65 10          	mov    0x10(%r13),%r12
    b340:	4d 85 e4             	test   %r12,%r12
    b343:	0f 84 b6 01 00 00    	je     b4ff <fwp_write+0x52f>
    b349:	4c 8d 35 1e 3f 00 00 	lea    0x3f1e(%rip),%r14        # f26e <exec_in_fp0+0xc1e>
    b350:	48 89 df             	mov    %rbx,%rdi
    b353:	4c 89 f6             	mov    %r14,%rsi
    b356:	e8 05 c7 ff ff       	call   7a60 <buf_puts>
    b35b:	49 8b 74 24 08       	mov    0x8(%r12),%rsi
    b360:	49 8b 57 38          	mov    0x38(%r15),%rdx
    b364:	48 89 df             	mov    %rbx,%rdi
    b367:	31 c9                	xor    %ecx,%ecx
    b369:	e8 62 fc ff ff       	call   afd0 <fwp_write>
    b36e:	4d 8b 64 24 10       	mov    0x10(%r12),%r12
    b373:	4d 85 e4             	test   %r12,%r12
    b376:	75 d8                	jne    b350 <fwp_write+0x380>
    b378:	e9 82 01 00 00       	jmp    b4ff <fwp_write+0x52f>
    b37d:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    b382:	8b 50 48             	mov    0x48(%rax),%edx
    b385:	48 89 df             	mov    %rbx,%rdi
    b388:	4c 89 ee             	mov    %r13,%rsi
    b38b:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b392:	5b                   	pop    %rbx
    b393:	41 5c                	pop    %r12
    b395:	41 5d                	pop    %r13
    b397:	41 5e                	pop    %r14
    b399:	41 5f                	pop    %r15
    b39b:	5d                   	pop    %rbp
    b39c:	e9 2f 08 00 00       	jmp    bbd0 <fwp_trits>
    b3a1:	49 83 fd ff          	cmp    $0xffffffffffffffff,%r13
    b3a5:	48 8d 05 ce 3e 00 00 	lea    0x3ece(%rip),%rax        # f27a <exec_in_fp0+0xc2a>
    b3ac:	48 8d 0d c8 3f 00 00 	lea    0x3fc8(%rip),%rcx        # f37b <exec_in_fp0+0xd2b>
    b3b3:	48 0f 44 c8          	cmove  %rax,%rcx
    b3b7:	49 83 fd 01          	cmp    $0x1,%r13
    b3bb:	48 8d 35 b5 3e 00 00 	lea    0x3eb5(%rip),%rsi        # f277 <exec_in_fp0+0xc27>
    b3c2:	48 0f 45 f1          	cmovne %rcx,%rsi
    b3c6:	e9 7a 01 00 00       	jmp    b545 <fwp_write+0x575>
    b3cb:	48 8d 35 7c 3f 00 00 	lea    0x3f7c(%rip),%rsi        # f34e <exec_in_fp0+0xcfe>
    b3d2:	48 89 df             	mov    %rbx,%rdi
    b3d5:	e8 86 c6 ff ff       	call   7a60 <buf_puts>
    b3da:	49 83 7d 00 00       	cmpq   $0x0,0x0(%r13)
    b3df:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    b3e4:	0f 84 15 01 00 00    	je     b4ff <fwp_write+0x52f>
    b3ea:	49 8b 57 38          	mov    0x38(%r15),%rdx
    b3ee:	49 8b 75 08          	mov    0x8(%r13),%rsi
    b3f2:	48 89 df             	mov    %rbx,%rdi
    b3f5:	31 c9                	xor    %ecx,%ecx
    b3f7:	e8 d4 fb ff ff       	call   afd0 <fwp_write>
    b3fc:	49 83 7d 00 02       	cmpq   $0x2,0x0(%r13)
    b401:	0f 82 f8 00 00 00    	jb     b4ff <fwp_write+0x52f>
    b407:	41 be 01 00 00 00    	mov    $0x1,%r14d
    b40d:	4c 8d 25 5a 3e 00 00 	lea    0x3e5a(%rip),%r12        # f26e <exec_in_fp0+0xc1e>
    b414:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b41b:	00 00 00 00 00 
    b420:	48 89 df             	mov    %rbx,%rdi
    b423:	4c 89 e6             	mov    %r12,%rsi
    b426:	e8 35 c6 ff ff       	call   7a60 <buf_puts>
    b42b:	4b 8b 74 f5 08       	mov    0x8(%r13,%r14,8),%rsi
    b430:	49 8b 57 38          	mov    0x38(%r15),%rdx
    b434:	48 89 df             	mov    %rbx,%rdi
    b437:	31 c9                	xor    %ecx,%ecx
    b439:	e8 92 fb ff ff       	call   afd0 <fwp_write>
    b43e:	49 ff c6             	inc    %r14
    b441:	4d 3b 75 00          	cmp    0x0(%r13),%r14
    b445:	72 d9                	jb     b420 <fwp_write+0x450>
    b447:	e9 b3 00 00 00       	jmp    b4ff <fwp_write+0x52f>
    b44c:	48 8d 35 f1 3e 00 00 	lea    0x3ef1(%rip),%rsi        # f344 <exec_in_fp0+0xcf4>
    b453:	48 89 df             	mov    %rbx,%rdi
    b456:	e8 05 c6 ff ff       	call   7a60 <buf_puts>
    b45b:	49 83 7d 00 00       	cmpq   $0x0,0x0(%r13)
    b460:	0f 84 99 00 00 00    	je     b4ff <fwp_write+0x52f>
    b466:	4c 89 ed             	mov    %r13,%rbp
    b469:	41 0f b6 4d 08       	movzbl 0x8(%r13),%ecx
    b46e:	48 8d 15 d6 3e 00 00 	lea    0x3ed6(%rip),%rdx        # f34b <exec_in_fp0+0xcfb>
    b475:	4c 8d 7c 24 20       	lea    0x20(%rsp),%r15
    b47a:	be 00 02 00 00       	mov    $0x200,%esi
    b47f:	4c 89 ff             	mov    %r15,%rdi
    b482:	31 c0                	xor    %eax,%eax
    b484:	e8 47 6d ff ff       	call   21d0 <snprintf@plt>
    b489:	48 89 df             	mov    %rbx,%rdi
    b48c:	4c 89 fe             	mov    %r15,%rsi
    b48f:	e8 cc c5 ff ff       	call   7a60 <buf_puts>
    b494:	49 83 7d 00 02       	cmpq   $0x2,0x0(%r13)
    b499:	72 64                	jb     b4ff <fwp_write+0x52f>
    b49b:	41 be 09 00 00 00    	mov    $0x9,%r14d
    b4a1:	4c 8d 3d c6 3d 00 00 	lea    0x3dc6(%rip),%r15        # f26e <exec_in_fp0+0xc1e>
    b4a8:	4c 8d 25 9c 3e 00 00 	lea    0x3e9c(%rip),%r12        # f34b <exec_in_fp0+0xcfb>
    b4af:	4c 8d 6c 24 20       	lea    0x20(%rsp),%r13
    b4b4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b4bb:	00 00 00 00 00 
    b4c0:	48 89 df             	mov    %rbx,%rdi
    b4c3:	4c 89 fe             	mov    %r15,%rsi
    b4c6:	e8 95 c5 ff ff       	call   7a60 <buf_puts>
    b4cb:	42 0f b6 4c 35 00    	movzbl 0x0(%rbp,%r14,1),%ecx
    b4d1:	be 00 02 00 00       	mov    $0x200,%esi
    b4d6:	4c 89 ef             	mov    %r13,%rdi
    b4d9:	4c 89 e2             	mov    %r12,%rdx
    b4dc:	31 c0                	xor    %eax,%eax
    b4de:	e8 ed 6c ff ff       	call   21d0 <snprintf@plt>
    b4e3:	48 89 df             	mov    %rbx,%rdi
    b4e6:	4c 89 ee             	mov    %r13,%rsi
    b4e9:	e8 72 c5 ff ff       	call   7a60 <buf_puts>
    b4ee:	49 8d 46 01          	lea    0x1(%r14),%rax
    b4f2:	49 83 c6 f9          	add    $0xfffffffffffffff9,%r14
    b4f6:	4c 3b 75 00          	cmp    0x0(%rbp),%r14
    b4fa:	49 89 c6             	mov    %rax,%r14
    b4fd:	72 c1                	jb     b4c0 <fwp_write+0x4f0>
    b4ff:	48 89 df             	mov    %rbx,%rdi
    b502:	be 5d 00 00 00       	mov    $0x5d,%esi
    b507:	e9 7b 01 00 00       	jmp    b687 <fwp_write+0x6b7>
    b50c:	4c 89 ef             	mov    %r13,%rdi
    b50f:	e8 1c ec ff ff       	call   a130 <fwp_f32>
    b514:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    b519:	4c 89 f7             	mov    %r14,%rdi
    b51c:	e8 ef 03 00 00       	call   b910 <fwp_fmt_f32>
    b521:	48 89 df             	mov    %rbx,%rdi
    b524:	4c 89 f6             	mov    %r14,%rsi
    b527:	e8 34 c5 ff ff       	call   7a60 <buf_puts>
    b52c:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b533:	5b                   	pop    %rbx
    b534:	41 5c                	pop    %r12
    b536:	41 5d                	pop    %r13
    b538:	41 5e                	pop    %r14
    b53a:	41 5f                	pop    %r15
    b53c:	5d                   	pop    %rbp
    b53d:	c3                   	ret
    b53e:	48 8d 35 e4 3d 00 00 	lea    0x3de4(%rip),%rsi        # f329 <exec_in_fp0+0xcd9>
    b545:	48 89 df             	mov    %rbx,%rdi
    b548:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b54f:	5b                   	pop    %rbx
    b550:	41 5c                	pop    %r12
    b552:	41 5d                	pop    %r13
    b554:	41 5e                	pop    %r14
    b556:	41 5f                	pop    %r15
    b558:	5d                   	pop    %rbp
    b559:	e9 02 c5 ff ff       	jmp    7a60 <buf_puts>
    b55e:	48 8d 35 d8 3d 00 00 	lea    0x3dd8(%rip),%rsi        # f33d <exec_in_fp0+0xced>
    b565:	48 89 df             	mov    %rbx,%rdi
    b568:	e8 f3 c4 ff ff       	call   7a60 <buf_puts>
    b56d:	49 83 c5 10          	add    $0x10,%r13
    b571:	48 89 df             	mov    %rbx,%rdi
    b574:	4c 89 ee             	mov    %r13,%rsi
    b577:	e8 e4 c4 ff ff       	call   7a60 <buf_puts>
    b57c:	48 89 df             	mov    %rbx,%rdi
    b57f:	be 3e 00 00 00       	mov    $0x3e,%esi
    b584:	e9 fe 00 00 00       	jmp    b687 <fwp_write+0x6b7>
    b589:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    b58e:	0f 84 35 01 00 00    	je     b6c9 <fwp_write+0x6f9>
    b594:	4d 8d 77 10          	lea    0x10(%r15),%r14
    b598:	4d 85 e4             	test   %r12,%r12
    b59b:	0f 94 c0             	sete   %al
    b59e:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
    b5a3:	40 0f 95 c5          	setne  %bpl
    b5a7:	40 20 c5             	and    %al,%bpl
    b5aa:	40 84 ed             	test   %bpl,%bpl
    b5ad:	b8 28 00 00 00       	mov    $0x28,%eax
    b5b2:	be 7b 00 00 00       	mov    $0x7b,%esi
    b5b7:	0f 45 f0             	cmovne %eax,%esi
    b5ba:	48 89 df             	mov    %rbx,%rdi
    b5bd:	e8 7e c4 ff ff       	call   7a40 <buf_putc>
    b5c2:	41 83 3e 00          	cmpl   $0x0,(%r14)
    b5c6:	0f 8e a8 00 00 00    	jle    b674 <fwp_write+0x6a4>
    b5cc:	40 84 ed             	test   %bpl,%bpl
    b5cf:	75 1e                	jne    b5ef <fwp_write+0x61f>
    b5d1:	49 8b 47 18          	mov    0x18(%r15),%rax
    b5d5:	48 8b 30             	mov    (%rax),%rsi
    b5d8:	48 89 df             	mov    %rbx,%rdi
    b5db:	e8 80 c4 ff ff       	call   7a60 <buf_puts>
    b5e0:	48 8d 35 7b 3d 00 00 	lea    0x3d7b(%rip),%rsi        # f362 <exec_in_fp0+0xd12>
    b5e7:	48 89 df             	mov    %rbx,%rdi
    b5ea:	e8 71 c4 ff ff       	call   7a60 <buf_puts>
    b5ef:	49 8b 75 08          	mov    0x8(%r13),%rsi
    b5f3:	49 8b 47 20          	mov    0x20(%r15),%rax
    b5f7:	48 8b 10             	mov    (%rax),%rdx
    b5fa:	48 89 df             	mov    %rbx,%rdi
    b5fd:	31 c9                	xor    %ecx,%ecx
    b5ff:	e8 cc f9 ff ff       	call   afd0 <fwp_write>
    b604:	41 83 7f 10 02       	cmpl   $0x2,0x10(%r15)
    b609:	7c 69                	jl     b674 <fwp_write+0x6a4>
    b60b:	41 be 01 00 00 00    	mov    $0x1,%r14d
    b611:	4c 8d 25 56 3c 00 00 	lea    0x3c56(%rip),%r12        # f26e <exec_in_fp0+0xc1e>
    b618:	eb 29                	jmp    b643 <fwp_write+0x673>
    b61a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    b620:	4b 8b 74 f5 08       	mov    0x8(%r13,%r14,8),%rsi
    b625:	49 8b 47 20          	mov    0x20(%r15),%rax
    b629:	4a 8b 14 f0          	mov    (%rax,%r14,8),%rdx
    b62d:	48 89 df             	mov    %rbx,%rdi
    b630:	31 c9                	xor    %ecx,%ecx
    b632:	e8 99 f9 ff ff       	call   afd0 <fwp_write>
    b637:	49 ff c6             	inc    %r14
    b63a:	49 63 47 10          	movslq 0x10(%r15),%rax
    b63e:	49 39 c6             	cmp    %rax,%r14
    b641:	7d 31                	jge    b674 <fwp_write+0x6a4>
    b643:	48 89 df             	mov    %rbx,%rdi
    b646:	4c 89 e6             	mov    %r12,%rsi
    b649:	e8 12 c4 ff ff       	call   7a60 <buf_puts>
    b64e:	40 84 ed             	test   %bpl,%bpl
    b651:	75 cd                	jne    b620 <fwp_write+0x650>
    b653:	49 8b 47 18          	mov    0x18(%r15),%rax
    b657:	4a 8b 34 f0          	mov    (%rax,%r14,8),%rsi
    b65b:	48 89 df             	mov    %rbx,%rdi
    b65e:	e8 fd c3 ff ff       	call   7a60 <buf_puts>
    b663:	48 89 df             	mov    %rbx,%rdi
    b666:	48 8d 35 f5 3c 00 00 	lea    0x3cf5(%rip),%rsi        # f362 <exec_in_fp0+0xd12>
    b66d:	e8 ee c3 ff ff       	call   7a60 <buf_puts>
    b672:	eb ac                	jmp    b620 <fwp_write+0x650>
    b674:	40 84 ed             	test   %bpl,%bpl
    b677:	b8 29 00 00 00       	mov    $0x29,%eax
    b67c:	be 7d 00 00 00       	mov    $0x7d,%esi
    b681:	0f 45 f0             	cmovne %eax,%esi
    b684:	48 89 df             	mov    %rbx,%rdi
    b687:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b68e:	5b                   	pop    %rbx
    b68f:	41 5c                	pop    %r12
    b691:	41 5d                	pop    %r13
    b693:	41 5e                	pop    %r14
    b695:	41 5f                	pop    %r15
    b697:	5d                   	pop    %rbp
    b698:	e9 a3 c3 ff ff       	jmp    7a40 <buf_putc>
    b69d:	5b                   	pop    %rbx
    b69e:	41 5c                	pop    %r12
    b6a0:	41 5d                	pop    %r13
    b6a2:	41 5e                	pop    %r14
    b6a4:	41 5f                	pop    %r15
    b6a6:	5d                   	pop    %rbp
    b6a7:	e9 14 06 00 00       	jmp    bcc0 <fwp_escape>
    b6ac:	49 8b 75 08          	mov    0x8(%r13),%rsi
    b6b0:	48 89 f2             	mov    %rsi,%rdx
    b6b3:	48 c1 fa 3f          	sar    $0x3f,%rdx
    b6b7:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    b6bc:	4c 89 f7             	mov    %r14,%rdi
    b6bf:	e8 0c 07 00 00       	call   bdd0 <fwp_fmt_duration>
    b6c4:	e9 58 fe ff ff       	jmp    b521 <fwp_write+0x551>
    b6c9:	48 8d 35 8f 3c 00 00 	lea    0x3c8f(%rip),%rsi        # f35f <exec_in_fp0+0xd0f>
    b6d0:	e9 70 fe ff ff       	jmp    b545 <fwp_write+0x575>
    b6d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b6dc:	00 00 00 00 

000000000000b6e0 <fwp_fmt_i128>:
    b6e0:	48 85 d2             	test   %rdx,%rdx
    b6e3:	79 1b                	jns    b700 <fwp_fmt_u128>
    b6e5:	c6 07 2d             	movb   $0x2d,(%rdi)
    b6e8:	48 ff c7             	inc    %rdi
    b6eb:	31 c0                	xor    %eax,%eax
    b6ed:	48 f7 de             	neg    %rsi
    b6f0:	48 19 d0             	sbb    %rdx,%rax
    b6f3:	48 89 c2             	mov    %rax,%rdx
    b6f6:	eb 08                	jmp    b700 <fwp_fmt_u128>
    b6f8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    b6ff:	00 

000000000000b700 <fwp_fmt_u128>:
    b700:	41 56                	push   %r14
    b702:	53                   	push   %rbx
    b703:	48 89 f0             	mov    %rsi,%rax
    b706:	48 09 d0             	or     %rdx,%rax
    b709:	0f 84 9d 00 00 00    	je     b7ac <fwp_fmt_u128+0xac>
    b70f:	48 89 d1             	mov    %rdx,%rcx
    b712:	45 31 d2             	xor    %r10d,%r10d
    b715:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    b71c:	cc cc cc 
    b71f:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
    b726:	cc cc cc 
    b729:	49 89 d6             	mov    %rdx,%r14
    b72c:	0f 1f 40 00          	nopl   0x0(%rax)
    b730:	49 89 c8             	mov    %rcx,%r8
    b733:	49 0f a4 f0 3f       	shld   $0x3f,%rsi,%r8
    b738:	49 d1 ee             	shr    $1,%r14
    b73b:	4d 89 c1             	mov    %r8,%r9
    b73e:	4d 01 f1             	add    %r14,%r9
    b741:	49 83 d1 00          	adc    $0x0,%r9
    b745:	4c 89 c8             	mov    %r9,%rax
    b748:	49 f7 e3             	mul    %r11
    b74b:	48 c1 ea 02          	shr    $0x2,%rdx
    b74f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    b753:	49 29 c1             	sub    %rax,%r9
    b756:	4d 29 c8             	sub    %r9,%r8
    b759:	49 83 de 00          	sbb    $0x0,%r14
    b75d:	4d 89 c1             	mov    %r8,%r9
    b760:	4c 0f af cb          	imul   %rbx,%r9
    b764:	4c 89 c0             	mov    %r8,%rax
    b767:	49 f7 e3             	mul    %r11
    b76a:	4c 01 ca             	add    %r9,%rdx
    b76d:	4d 0f af f3          	imul   %r11,%r14
    b771:	49 01 d6             	add    %rdx,%r14
    b774:	48 89 c2             	mov    %rax,%rdx
    b777:	48 01 c2             	add    %rax,%rdx
    b77a:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
    b77e:	41 89 f0             	mov    %esi,%r8d
    b781:	41 29 d0             	sub    %edx,%r8d
    b784:	41 80 c8 30          	or     $0x30,%r8b
    b788:	46 88 44 14 b8       	mov    %r8b,-0x48(%rsp,%r10,1)
    b78d:	49 ff c2             	inc    %r10
    b790:	48 83 fe 0a          	cmp    $0xa,%rsi
    b794:	48 83 d9 00          	sbb    $0x0,%rcx
    b798:	48 89 c6             	mov    %rax,%rsi
    b79b:	4c 89 f1             	mov    %r14,%rcx
    b79e:	73 90                	jae    b730 <fwp_fmt_u128+0x30>
    b7a0:	45 85 d2             	test   %r10d,%r10d
    b7a3:	7f 12                	jg     b7b7 <fwp_fmt_u128+0xb7>
    b7a5:	31 c0                	xor    %eax,%eax
    b7a7:	e9 56 01 00 00       	jmp    b902 <fwp_fmt_u128+0x202>
    b7ac:	c6 44 24 b8 30       	movb   $0x30,-0x48(%rsp)
    b7b1:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    b7b7:	44 89 d0             	mov    %r10d,%eax
    b7ba:	41 83 fa 08          	cmp    $0x8,%r10d
    b7be:	73 0a                	jae    b7ca <fwp_fmt_u128+0xca>
    b7c0:	31 c9                	xor    %ecx,%ecx
    b7c2:	48 89 c2             	mov    %rax,%rdx
    b7c5:	e9 10 01 00 00       	jmp    b8da <fwp_fmt_u128+0x1da>
    b7ca:	83 f8 20             	cmp    $0x20,%eax
    b7cd:	73 07                	jae    b7d6 <fwp_fmt_u128+0xd6>
    b7cf:	31 c9                	xor    %ecx,%ecx
    b7d1:	e9 a4 00 00 00       	jmp    b87a <fwp_fmt_u128+0x17a>
    b7d6:	89 c1                	mov    %eax,%ecx
    b7d8:	81 e1 e0 ff ff 7f    	and    $0x7fffffe0,%ecx
    b7de:	48 8d 54 24 b8       	lea    -0x48(%rsp),%rdx
    b7e3:	48 01 c2             	add    %rax,%rdx
    b7e6:	48 83 c2 f0          	add    $0xfffffffffffffff0,%rdx
    b7ea:	31 f6                	xor    %esi,%esi
    b7ec:	66 0f ef c0          	pxor   %xmm0,%xmm0
    b7f0:	f3 0f 6f 4a f0       	movdqu -0x10(%rdx),%xmm1
    b7f5:	f3 0f 6f 12          	movdqu (%rdx),%xmm2
    b7f9:	66 0f 6f da          	movdqa %xmm2,%xmm3
    b7fd:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    b801:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    b806:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    b80b:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    b810:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    b814:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    b819:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    b81e:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    b823:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    b827:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    b82b:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    b82f:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    b834:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    b839:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    b83e:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    b842:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    b847:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    b84c:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    b851:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    b855:	f3 0f 7f 14 37       	movdqu %xmm2,(%rdi,%rsi,1)
    b85a:	f3 0f 7f 4c 37 10    	movdqu %xmm1,0x10(%rdi,%rsi,1)
    b860:	48 83 c6 20          	add    $0x20,%rsi
    b864:	48 83 c2 e0          	add    $0xffffffffffffffe0,%rdx
    b868:	48 39 f1             	cmp    %rsi,%rcx
    b86b:	75 83                	jne    b7f0 <fwp_fmt_u128+0xf0>
    b86d:	48 39 c1             	cmp    %rax,%rcx
    b870:	0f 84 8c 00 00 00    	je     b902 <fwp_fmt_u128+0x202>
    b876:	a8 18                	test   $0x18,%al
    b878:	74 5b                	je     b8d5 <fwp_fmt_u128+0x1d5>
    b87a:	48 89 ce             	mov    %rcx,%rsi
    b87d:	89 c1                	mov    %eax,%ecx
    b87f:	81 e1 f8 ff ff 7f    	and    $0x7ffffff8,%ecx
    b885:	89 c2                	mov    %eax,%edx
    b887:	83 e2 07             	and    $0x7,%edx
    b88a:	49 89 c0             	mov    %rax,%r8
    b88d:	49 29 f0             	sub    %rsi,%r8
    b890:	49 01 e0             	add    %rsp,%r8
    b893:	49 83 c0 b0          	add    $0xffffffffffffffb0,%r8
    b897:	66 0f ef c0          	pxor   %xmm0,%xmm0
    b89b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    b8a0:	f3 41 0f 7e 08       	movq   (%r8),%xmm1
    b8a5:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    b8a9:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    b8ae:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    b8b3:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    b8b8:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    b8bc:	66 0f d6 0c 37       	movq   %xmm1,(%rdi,%rsi,1)
    b8c1:	48 83 c6 08          	add    $0x8,%rsi
    b8c5:	49 83 c0 f8          	add    $0xfffffffffffffff8,%r8
    b8c9:	48 39 f1             	cmp    %rsi,%rcx
    b8cc:	75 d2                	jne    b8a0 <fwp_fmt_u128+0x1a0>
    b8ce:	48 39 c1             	cmp    %rax,%rcx
    b8d1:	75 07                	jne    b8da <fwp_fmt_u128+0x1da>
    b8d3:	eb 2d                	jmp    b902 <fwp_fmt_u128+0x202>
    b8d5:	89 c2                	mov    %eax,%edx
    b8d7:	83 e2 1f             	and    $0x1f,%edx
    b8da:	48 8d 74 24 b8       	lea    -0x48(%rsp),%rsi
    b8df:	48 01 f2             	add    %rsi,%rdx
    b8e2:	48 ff ca             	dec    %rdx
    b8e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b8ec:	00 00 00 00 
    b8f0:	0f b6 32             	movzbl (%rdx),%esi
    b8f3:	40 88 34 0f          	mov    %sil,(%rdi,%rcx,1)
    b8f7:	48 ff c1             	inc    %rcx
    b8fa:	48 ff ca             	dec    %rdx
    b8fd:	48 39 c8             	cmp    %rcx,%rax
    b900:	75 ee                	jne    b8f0 <fwp_fmt_u128+0x1f0>
    b902:	c6 04 07 00          	movb   $0x0,(%rdi,%rax,1)
    b906:	5b                   	pop    %rbx
    b907:	41 5e                	pop    %r14
    b909:	c3                   	ret
    b90a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000b910 <fwp_fmt_f32>:
    b910:	53                   	push   %rbx
    b911:	48 83 ec 20          	sub    $0x20,%rsp
    b915:	48 89 fb             	mov    %rdi,%rbx
    b918:	0f 2e c0             	ucomiss %xmm0,%xmm0
    b91b:	0f 8a d8 01 00 00    	jp     baf9 <fwp_fmt_f32+0x1e9>
    b921:	0f 28 c8             	movaps %xmm0,%xmm1
    b924:	0f 28 05 d5 27 00 00 	movaps 0x27d5(%rip),%xmm0        # e100 <_IO_stdin_used+0x100>
    b92b:	0f 54 c1             	andps  %xmm1,%xmm0
    b92e:	0f 2e 05 cf 26 00 00 	ucomiss 0x26cf(%rip),%xmm0        # e004 <_IO_stdin_used+0x4>
    b935:	72 25                	jb     b95c <fwp_fmt_f32+0x4c>
    b937:	0f 57 c0             	xorps  %xmm0,%xmm0
    b93a:	0f 2e c8             	ucomiss %xmm0,%xmm1
    b93d:	48 8d 05 62 39 00 00 	lea    0x3962(%rip),%rax        # f2a6 <exec_in_fp0+0xc56>
    b944:	48 8d 35 5a 39 00 00 	lea    0x395a(%rip),%rsi        # f2a5 <exec_in_fp0+0xc55>
    b94b:	48 0f 47 f0          	cmova  %rax,%rsi
    b94f:	48 89 df             	mov    %rbx,%rdi
    b952:	48 83 c4 20          	add    $0x20,%rsp
    b956:	5b                   	pop    %rbx
    b957:	e9 54 67 ff ff       	jmp    20b0 <strcpy@plt>
    b95c:	0f 57 c0             	xorps  %xmm0,%xmm0
    b95f:	f3 0f 5a c1          	cvtss2sd %xmm1,%xmm0
    b963:	48 89 df             	mov    %rbx,%rdi
    b966:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    b96c:	be 01 00 00 00       	mov    $0x1,%esi
    b971:	0f 29 4c 24 10       	movaps %xmm1,0x10(%rsp)
    b976:	e8 95 07 00 00       	call   c110 <fwp_format_g>
    b97b:	48 89 df             	mov    %rbx,%rdi
    b97e:	31 f6                	xor    %esi,%esi
    b980:	e8 7b 68 ff ff       	call   2200 <strtof@plt>
    b985:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b98a:	75 06                	jne    b992 <fwp_fmt_f32+0x82>
    b98c:	0f 8b 5a 01 00 00    	jnp    baec <fwp_fmt_f32+0x1dc>
    b992:	48 89 df             	mov    %rbx,%rdi
    b995:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b99b:	be 02 00 00 00       	mov    $0x2,%esi
    b9a0:	e8 6b 07 00 00       	call   c110 <fwp_format_g>
    b9a5:	48 89 df             	mov    %rbx,%rdi
    b9a8:	31 f6                	xor    %esi,%esi
    b9aa:	e8 51 68 ff ff       	call   2200 <strtof@plt>
    b9af:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b9b4:	75 06                	jne    b9bc <fwp_fmt_f32+0xac>
    b9b6:	0f 8b 30 01 00 00    	jnp    baec <fwp_fmt_f32+0x1dc>
    b9bc:	48 89 df             	mov    %rbx,%rdi
    b9bf:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b9c5:	be 03 00 00 00       	mov    $0x3,%esi
    b9ca:	e8 41 07 00 00       	call   c110 <fwp_format_g>
    b9cf:	48 89 df             	mov    %rbx,%rdi
    b9d2:	31 f6                	xor    %esi,%esi
    b9d4:	e8 27 68 ff ff       	call   2200 <strtof@plt>
    b9d9:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b9de:	75 06                	jne    b9e6 <fwp_fmt_f32+0xd6>
    b9e0:	0f 8b 06 01 00 00    	jnp    baec <fwp_fmt_f32+0x1dc>
    b9e6:	48 89 df             	mov    %rbx,%rdi
    b9e9:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b9ef:	be 04 00 00 00       	mov    $0x4,%esi
    b9f4:	e8 17 07 00 00       	call   c110 <fwp_format_g>
    b9f9:	48 89 df             	mov    %rbx,%rdi
    b9fc:	31 f6                	xor    %esi,%esi
    b9fe:	e8 fd 67 ff ff       	call   2200 <strtof@plt>
    ba03:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    ba08:	75 06                	jne    ba10 <fwp_fmt_f32+0x100>
    ba0a:	0f 8b dc 00 00 00    	jnp    baec <fwp_fmt_f32+0x1dc>
    ba10:	48 89 df             	mov    %rbx,%rdi
    ba13:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    ba19:	be 05 00 00 00       	mov    $0x5,%esi
    ba1e:	e8 ed 06 00 00       	call   c110 <fwp_format_g>
    ba23:	48 89 df             	mov    %rbx,%rdi
    ba26:	31 f6                	xor    %esi,%esi
    ba28:	e8 d3 67 ff ff       	call   2200 <strtof@plt>
    ba2d:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    ba32:	75 06                	jne    ba3a <fwp_fmt_f32+0x12a>
    ba34:	0f 8b b2 00 00 00    	jnp    baec <fwp_fmt_f32+0x1dc>
    ba3a:	48 89 df             	mov    %rbx,%rdi
    ba3d:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    ba43:	be 06 00 00 00       	mov    $0x6,%esi
    ba48:	e8 c3 06 00 00       	call   c110 <fwp_format_g>
    ba4d:	48 89 df             	mov    %rbx,%rdi
    ba50:	31 f6                	xor    %esi,%esi
    ba52:	e8 a9 67 ff ff       	call   2200 <strtof@plt>
    ba57:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    ba5c:	75 06                	jne    ba64 <fwp_fmt_f32+0x154>
    ba5e:	0f 8b 88 00 00 00    	jnp    baec <fwp_fmt_f32+0x1dc>
    ba64:	48 89 df             	mov    %rbx,%rdi
    ba67:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    ba6d:	be 07 00 00 00       	mov    $0x7,%esi
    ba72:	e8 99 06 00 00       	call   c110 <fwp_format_g>
    ba77:	48 89 df             	mov    %rbx,%rdi
    ba7a:	31 f6                	xor    %esi,%esi
    ba7c:	e8 7f 67 ff ff       	call   2200 <strtof@plt>
    ba81:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    ba86:	75 02                	jne    ba8a <fwp_fmt_f32+0x17a>
    ba88:	7b 62                	jnp    baec <fwp_fmt_f32+0x1dc>
    ba8a:	48 89 df             	mov    %rbx,%rdi
    ba8d:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    ba93:	be 08 00 00 00       	mov    $0x8,%esi
    ba98:	e8 73 06 00 00       	call   c110 <fwp_format_g>
    ba9d:	48 89 df             	mov    %rbx,%rdi
    baa0:	31 f6                	xor    %esi,%esi
    baa2:	e8 59 67 ff ff       	call   2200 <strtof@plt>
    baa7:	0f 28 4c 24 10       	movaps 0x10(%rsp),%xmm1
    baac:	0f 2e c1             	ucomiss %xmm1,%xmm0
    baaf:	75 02                	jne    bab3 <fwp_fmt_f32+0x1a3>
    bab1:	7b 39                	jnp    baec <fwp_fmt_f32+0x1dc>
    bab3:	48 89 df             	mov    %rbx,%rdi
    bab6:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    babc:	be 09 00 00 00       	mov    $0x9,%esi
    bac1:	e8 4a 06 00 00       	call   c110 <fwp_format_g>
    bac6:	48 89 df             	mov    %rbx,%rdi
    bac9:	31 f6                	xor    %esi,%esi
    bacb:	e8 30 67 ff ff       	call   2200 <strtof@plt>
    bad0:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    bad5:	75 02                	jne    bad9 <fwp_fmt_f32+0x1c9>
    bad7:	7b 13                	jnp    baec <fwp_fmt_f32+0x1dc>
    bad9:	48 89 df             	mov    %rbx,%rdi
    badc:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    bae2:	be 09 00 00 00       	mov    $0x9,%esi
    bae7:	e8 24 06 00 00       	call   c110 <fwp_format_g>
    baec:	48 89 df             	mov    %rbx,%rdi
    baef:	48 83 c4 20          	add    $0x20,%rsp
    baf3:	5b                   	pop    %rbx
    baf4:	e9 97 07 00 00       	jmp    c290 <fwp_finish_float>
    baf9:	c7 03 4e 61 4e 00    	movl   $0x4e614e,(%rbx)
    baff:	48 83 c4 20          	add    $0x20,%rsp
    bb03:	5b                   	pop    %rbx
    bb04:	c3                   	ret
    bb05:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    bb0c:	00 00 00 00 

000000000000bb10 <fwp_fmt_f64>:
    bb10:	55                   	push   %rbp
    bb11:	53                   	push   %rbx
    bb12:	48 83 ec 18          	sub    $0x18,%rsp
    bb16:	48 89 fb             	mov    %rdi,%rbx
    bb19:	66 0f 2e c0          	ucomisd %xmm0,%xmm0
    bb1d:	0f 8a 98 00 00 00    	jp     bbbb <fwp_fmt_f64+0xab>
    bb23:	66 0f 28 c8          	movapd %xmm0,%xmm1
    bb27:	66 0f 28 05 e1 25 00 	movapd 0x25e1(%rip),%xmm0        # e110 <_IO_stdin_used+0x110>
    bb2e:	00 
    bb2f:	66 0f 54 c1          	andpd  %xmm1,%xmm0
    bb33:	66 0f 2e 05 25 26 00 	ucomisd 0x2625(%rip),%xmm0        # e160 <_IO_stdin_used+0x160>
    bb3a:	00 
    bb3b:	72 28                	jb     bb65 <fwp_fmt_f64+0x55>
    bb3d:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    bb41:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
    bb45:	48 8d 05 5a 37 00 00 	lea    0x375a(%rip),%rax        # f2a6 <exec_in_fp0+0xc56>
    bb4c:	48 8d 35 52 37 00 00 	lea    0x3752(%rip),%rsi        # f2a5 <exec_in_fp0+0xc55>
    bb53:	48 0f 47 f0          	cmova  %rax,%rsi
    bb57:	48 89 df             	mov    %rbx,%rdi
    bb5a:	48 83 c4 18          	add    $0x18,%rsp
    bb5e:	5b                   	pop    %rbx
    bb5f:	5d                   	pop    %rbp
    bb60:	e9 4b 65 ff ff       	jmp    20b0 <strcpy@plt>
    bb65:	bd 01 00 00 00       	mov    $0x1,%ebp
    bb6a:	66 0f 29 0c 24       	movapd %xmm1,(%rsp)
    bb6f:	90                   	nop
    bb70:	48 89 df             	mov    %rbx,%rdi
    bb73:	66 0f 28 c1          	movapd %xmm1,%xmm0
    bb77:	89 ee                	mov    %ebp,%esi
    bb79:	e8 92 05 00 00       	call   c110 <fwp_format_g>
    bb7e:	48 89 df             	mov    %rbx,%rdi
    bb81:	31 f6                	xor    %esi,%esi
    bb83:	e8 78 65 ff ff       	call   2100 <strtod@plt>
    bb88:	66 0f 28 0c 24       	movapd (%rsp),%xmm1
    bb8d:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
    bb91:	75 02                	jne    bb95 <fwp_fmt_f64+0x85>
    bb93:	7b 18                	jnp    bbad <fwp_fmt_f64+0x9d>
    bb95:	ff c5                	inc    %ebp
    bb97:	83 fd 12             	cmp    $0x12,%ebp
    bb9a:	75 d4                	jne    bb70 <fwp_fmt_f64+0x60>
    bb9c:	48 89 df             	mov    %rbx,%rdi
    bb9f:	66 0f 28 c1          	movapd %xmm1,%xmm0
    bba3:	be 11 00 00 00       	mov    $0x11,%esi
    bba8:	e8 63 05 00 00       	call   c110 <fwp_format_g>
    bbad:	48 89 df             	mov    %rbx,%rdi
    bbb0:	48 83 c4 18          	add    $0x18,%rsp
    bbb4:	5b                   	pop    %rbx
    bbb5:	5d                   	pop    %rbp
    bbb6:	e9 d5 06 00 00       	jmp    c290 <fwp_finish_float>
    bbbb:	c7 03 4e 61 4e 00    	movl   $0x4e614e,(%rbx)
    bbc1:	48 83 c4 18          	add    $0x18,%rsp
    bbc5:	5b                   	pop    %rbx
    bbc6:	5d                   	pop    %rbp
    bbc7:	c3                   	ret
    bbc8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    bbcf:	00 

000000000000bbd0 <fwp_trits>:
    bbd0:	55                   	push   %rbp
    bbd1:	41 57                	push   %r15
    bbd3:	41 56                	push   %r14
    bbd5:	53                   	push   %rbx
    bbd6:	50                   	push   %rax
    bbd7:	89 d5                	mov    %edx,%ebp
    bbd9:	49 89 f6             	mov    %rsi,%r14
    bbdc:	48 89 fb             	mov    %rdi,%rbx
    bbdf:	4c 63 fa             	movslq %edx,%r15
    bbe2:	49 8d 7f 03          	lea    0x3(%r15),%rdi
    bbe6:	e8 55 ac ff ff       	call   6840 <fwp_alloc_leaf>
    bbeb:	48 89 c6             	mov    %rax,%rsi
    bbee:	66 c7 00 30 74       	movw   $0x7430,(%rax)
    bbf3:	45 85 ff             	test   %r15d,%r15d
    bbf6:	0f 8e 9f 00 00 00    	jle    bc9b <fwp_trits+0xcb>
    bbfc:	89 e9                	mov    %ebp,%ecx
    bbfe:	48 8d 3c 31          	lea    (%rcx,%rsi,1),%rdi
    bc02:	48 ff c7             	inc    %rdi
    bc05:	48 f7 d9             	neg    %rcx
    bc08:	45 31 c0             	xor    %r8d,%r8d
    bc0b:	49 b9 56 55 55 55 55 	movabs $0x5555555555555556,%r9
    bc12:	55 55 55 
    bc15:	eb 35                	jmp    bc4c <fwp_trits+0x7c>
    bc17:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    bc1e:	00 00 
    bc20:	41 b3 30             	mov    $0x30,%r11b
    bc23:	46 88 1c 07          	mov    %r11b,(%rdi,%r8,1)
    bc27:	48 85 d2             	test   %rdx,%rdx
    bc2a:	0f 95 c2             	setne  %dl
    bc2d:	4d 85 f6             	test   %r14,%r14
    bc30:	41 0f 98 c3          	sets   %r11b
    bc34:	41 20 d3             	and    %dl,%r11b
    bc37:	41 0f b6 d3          	movzbl %r11b,%edx
    bc3b:	48 29 d0             	sub    %rdx,%rax
    bc3e:	4c 01 d0             	add    %r10,%rax
    bc41:	49 ff c8             	dec    %r8
    bc44:	49 89 c6             	mov    %rax,%r14
    bc47:	4c 39 c1             	cmp    %r8,%rcx
    bc4a:	74 4f                	je     bc9b <fwp_trits+0xcb>
    bc4c:	4c 89 f0             	mov    %r14,%rax
    bc4f:	49 f7 e9             	imul   %r9
    bc52:	48 89 d0             	mov    %rdx,%rax
    bc55:	48 c1 e8 3f          	shr    $0x3f,%rax
    bc59:	48 01 d0             	add    %rdx,%rax
    bc5c:	4c 8d 14 40          	lea    (%rax,%rax,2),%r10
    bc60:	4c 89 f2             	mov    %r14,%rdx
    bc63:	4c 29 d2             	sub    %r10,%rdx
    bc66:	49 f7 da             	neg    %r10
    bc69:	4d 01 f2             	add    %r14,%r10
    bc6c:	49 83 c2 03          	add    $0x3,%r10
    bc70:	48 83 fa fd          	cmp    $0xfffffffffffffffd,%rdx
    bc74:	4c 0f 42 d2          	cmovb  %rdx,%r10
    bc78:	4d 85 d2             	test   %r10,%r10
    bc7b:	74 a3                	je     bc20 <fwp_trits+0x50>
    bc7d:	49 83 fa 01          	cmp    $0x1,%r10
    bc81:	75 0d                	jne    bc90 <fwp_trits+0xc0>
    bc83:	41 b3 2b             	mov    $0x2b,%r11b
    bc86:	45 31 d2             	xor    %r10d,%r10d
    bc89:	eb 98                	jmp    bc23 <fwp_trits+0x53>
    bc8b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    bc90:	41 b3 2d             	mov    $0x2d,%r11b
    bc93:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    bc99:	eb 88                	jmp    bc23 <fwp_trits+0x53>
    bc9b:	42 c6 44 3e 02 00    	movb   $0x0,0x2(%rsi,%r15,1)
    bca1:	48 89 df             	mov    %rbx,%rdi
    bca4:	48 83 c4 08          	add    $0x8,%rsp
    bca8:	5b                   	pop    %rbx
    bca9:	41 5e                	pop    %r14
    bcab:	41 5f                	pop    %r15
    bcad:	5d                   	pop    %rbp
    bcae:	e9 ad bd ff ff       	jmp    7a60 <buf_puts>
    bcb3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    bcba:	84 00 00 00 00 00 

000000000000bcc0 <fwp_escape>:
    bcc0:	55                   	push   %rbp
    bcc1:	41 57                	push   %r15
    bcc3:	41 56                	push   %r14
    bcc5:	41 55                	push   %r13
    bcc7:	41 54                	push   %r12
    bcc9:	53                   	push   %rbx
    bcca:	48 83 ec 18          	sub    $0x18,%rsp
    bcce:	48 89 d3             	mov    %rdx,%rbx
    bcd1:	49 89 f7             	mov    %rsi,%r15
    bcd4:	49 89 fe             	mov    %rdi,%r14
    bcd7:	be 22 00 00 00       	mov    $0x22,%esi
    bcdc:	e8 5f bd ff ff       	call   7a40 <buf_putc>
    bce1:	48 85 db             	test   %rbx,%rbx
    bce4:	0f 84 c7 00 00 00    	je     bdb1 <fwp_escape+0xf1>
    bcea:	48 89 e5             	mov    %rsp,%rbp
    bced:	4c 8d 2d b8 26 00 00 	lea    0x26b8(%rip),%r13        # e3ac <_IO_stdin_used+0x3ac>
    bcf4:	45 31 e4             	xor    %r12d,%r12d
    bcf7:	eb 28                	jmp    bd21 <fwp_escape+0x61>
    bcf9:	4c 89 f7             	mov    %r14,%rdi
    bcfc:	48 8d 35 86 36 00 00 	lea    0x3686(%rip),%rsi        # f389 <exec_in_fp0+0xd39>
    bd03:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    bd0a:	84 00 00 00 00 00 
    bd10:	e8 4b bd ff ff       	call   7a60 <buf_puts>
    bd15:	49 ff c4             	inc    %r12
    bd18:	4c 39 e3             	cmp    %r12,%rbx
    bd1b:	0f 84 90 00 00 00    	je     bdb1 <fwp_escape+0xf1>
    bd21:	43 0f b6 0c 27       	movzbl (%r15,%r12,1),%ecx
    bd26:	8d 41 f7             	lea    -0x9(%rcx),%eax
    bd29:	83 f8 19             	cmp    $0x19,%eax
    bd2c:	77 22                	ja     bd50 <fwp_escape+0x90>
    bd2e:	49 63 44 85 00       	movslq 0x0(%r13,%rax,4),%rax
    bd33:	4c 01 e8             	add    %r13,%rax
    bd36:	ff e0                	jmp    *%rax
    bd38:	4c 89 f7             	mov    %r14,%rdi
    bd3b:	48 8d 35 44 36 00 00 	lea    0x3644(%rip),%rsi        # f386 <exec_in_fp0+0xd36>
    bd42:	eb cc                	jmp    bd10 <fwp_escape+0x50>
    bd44:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    bd4b:	00 00 00 00 00 
    bd50:	83 f9 5c             	cmp    $0x5c,%ecx
    bd53:	75 0c                	jne    bd61 <fwp_escape+0xa1>
    bd55:	4c 89 f7             	mov    %r14,%rdi
    bd58:	48 8d 35 21 36 00 00 	lea    0x3621(%rip),%rsi        # f380 <exec_in_fp0+0xd30>
    bd5f:	eb af                	jmp    bd10 <fwp_escape+0x50>
    bd61:	80 f9 20             	cmp    $0x20,%cl
    bd64:	72 2a                	jb     bd90 <fwp_escape+0xd0>
    bd66:	80 f9 7f             	cmp    $0x7f,%cl
    bd69:	74 25                	je     bd90 <fwp_escape+0xd0>
    bd6b:	0f be f1             	movsbl %cl,%esi
    bd6e:	4c 89 f7             	mov    %r14,%rdi
    bd71:	e8 ca bc ff ff       	call   7a40 <buf_putc>
    bd76:	eb 9d                	jmp    bd15 <fwp_escape+0x55>
    bd78:	4c 89 f7             	mov    %r14,%rdi
    bd7b:	48 8d 35 fb 35 00 00 	lea    0x35fb(%rip),%rsi        # f37d <exec_in_fp0+0xd2d>
    bd82:	eb 8c                	jmp    bd10 <fwp_escape+0x50>
    bd84:	4c 89 f7             	mov    %r14,%rdi
    bd87:	48 8d 35 f5 35 00 00 	lea    0x35f5(%rip),%rsi        # f383 <exec_in_fp0+0xd33>
    bd8e:	eb 80                	jmp    bd10 <fwp_escape+0x50>
    bd90:	be 10 00 00 00       	mov    $0x10,%esi
    bd95:	48 89 ef             	mov    %rbp,%rdi
    bd98:	48 8d 15 ed 35 00 00 	lea    0x35ed(%rip),%rdx        # f38c <exec_in_fp0+0xd3c>
    bd9f:	31 c0                	xor    %eax,%eax
    bda1:	e8 2a 64 ff ff       	call   21d0 <snprintf@plt>
    bda6:	4c 89 f7             	mov    %r14,%rdi
    bda9:	48 89 ee             	mov    %rbp,%rsi
    bdac:	e9 5f ff ff ff       	jmp    bd10 <fwp_escape+0x50>
    bdb1:	4c 89 f7             	mov    %r14,%rdi
    bdb4:	be 22 00 00 00       	mov    $0x22,%esi
    bdb9:	48 83 c4 18          	add    $0x18,%rsp
    bdbd:	5b                   	pop    %rbx
    bdbe:	41 5c                	pop    %r12
    bdc0:	41 5d                	pop    %r13
    bdc2:	41 5e                	pop    %r14
    bdc4:	41 5f                	pop    %r15
    bdc6:	5d                   	pop    %rbp
    bdc7:	e9 74 bc ff ff       	jmp    7a40 <buf_putc>
    bdcc:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000bdd0 <fwp_fmt_duration>:
    bdd0:	41 57                	push   %r15
    bdd2:	41 56                	push   %r14
    bdd4:	41 54                	push   %r12
    bdd6:	53                   	push   %rbx
    bdd7:	48 83 ec 48          	sub    $0x48,%rsp
    bddb:	49 89 d0             	mov    %rdx,%r8
    bdde:	48 89 fb             	mov    %rdi,%rbx
    bde1:	48 89 f0             	mov    %rsi,%rax
    bde4:	48 09 d0             	or     %rdx,%rax
    bde7:	0f 84 1b 02 00 00    	je     c008 <fwp_fmt_duration+0x238>
    bded:	48 b9 1d 3f c2 25 d6 	movabs $0xd2fe1d625c23f1d,%rcx
    bdf4:	e1 2f 0d 
    bdf7:	48 bf 0d b1 f3 e4 99 	movabs $0x1c52799e4f3b10d,%rdi
    bdfe:	27 c5 01 
    be01:	48 89 f0             	mov    %rsi,%rax
    be04:	48 f7 e7             	mul    %rdi
    be07:	48 0f af ce          	imul   %rsi,%rcx
    be0b:	48 01 ca             	add    %rcx,%rdx
    be0e:	49 0f af f8          	imul   %r8,%rdi
    be12:	48 01 d7             	add    %rdx,%rdi
    be15:	48 b9 00 a0 34 52 a3 	movabs $0x6baf6aa35234a000,%rcx
    be1c:	6a af 6b 
    be1f:	48 01 c1             	add    %rax,%rcx
    be22:	48 b8 37 f9 ff e2 04 	movabs $0x4e2fff937,%rax
    be29:	00 00 00 
    be2c:	48 11 f8             	adc    %rdi,%rax
    be2f:	48 89 c2             	mov    %rax,%rdx
    be32:	48 0f ac ca 0d       	shrd   $0xd,%rcx,%rdx
    be37:	48 0f a4 c8 33       	shld   $0x33,%rcx,%rax
    be3c:	48 b9 4b 23 35 aa f6 	movabs $0x9376baf6aa35234b,%rcx
    be43:	ba 76 93 
    be46:	48 39 c8             	cmp    %rcx,%rax
    be49:	48 81 da ff 2f 4e 00 	sbb    $0x4e2fff,%rdx
    be50:	0f 82 d9 01 00 00    	jb     c02f <fwp_fmt_duration+0x25f>
    be56:	48 b9 b3 b2 61 36 8c 	movabs $0xc5ce3b8c3661b2b3,%rcx
    be5d:	3b ce c5 
    be60:	48 bf c3 5f 47 6a 04 	movabs $0x1a8d52046a475fc3,%rdi
    be67:	52 8d 1a 
    be6a:	48 89 f0             	mov    %rsi,%rax
    be6d:	48 f7 e7             	mul    %rdi
    be70:	48 0f af ce          	imul   %rsi,%rcx
    be74:	48 01 ca             	add    %rcx,%rdx
    be77:	49 0f af f8          	imul   %r8,%rdi
    be7b:	48 01 d7             	add    %rdx,%rdi
    be7e:	48 b9 00 a8 16 d1 91 	movabs $0x4f473f91d116a800,%rcx
    be85:	3f 47 4f 
    be88:	48 01 c1             	add    %rax,%rcx
    be8b:	48 b8 3f 9a ff 4c 49 	movabs $0x494cff9a3f,%rax
    be92:	00 00 00 
    be95:	48 11 f8             	adc    %rdi,%rax
    be98:	48 89 c2             	mov    %rax,%rdx
    be9b:	48 0f ac ca 0b       	shrd   $0xb,%rcx,%rdx
    bea0:	48 0f a4 c8 35       	shld   $0x35,%rcx,%rax
    bea5:	48 b9 ab 45 74 e4 cf 	movabs $0x8fd3d1cfe47445ab,%rcx
    beac:	d1 d3 8f 
    beaf:	48 39 c8             	cmp    %rcx,%rax
    beb2:	48 81 da e6 3f 53 12 	sbb    $0x12533fe6,%rdx
    beb9:	0f 82 7f 01 00 00    	jb     c03e <fwp_fmt_duration+0x26e>
    bebf:	48 b9 7e 78 b9 2f 37 	movabs $0x97157d372fb9787e,%rcx
    bec6:	7d 15 97 
    bec9:	48 0f af ce          	imul   %rsi,%rcx
    becd:	48 bf 6d 9c 2e 3a 42 	movabs $0x8e47ce423a2e9c6d,%rdi
    bed4:	ce 47 8e 
    bed7:	48 89 f0             	mov    %rsi,%rax
    beda:	48 f7 e7             	mul    %rdi
    bedd:	48 01 ca             	add    %rcx,%rdx
    bee0:	49 0f af f8          	imul   %r8,%rdi
    bee4:	48 01 d7             	add    %rdx,%rdi
    bee7:	48 b9 00 46 54 40 8b 	movabs $0xa52cb98b40544600,%rcx
    beee:	b9 2c a5 
    bef1:	48 01 c1             	add    %rax,%rcx
    bef4:	48 b8 b5 09 fa 82 4b 	movabs $0x44b82fa09b5,%rax
    befb:	04 00 00 
    befe:	48 11 f8             	adc    %rdi,%rax
    bf01:	48 89 c2             	mov    %rax,%rdx
    bf04:	48 0f ac ca 09       	shrd   $0x9,%rcx,%rdx
    bf09:	48 0f a4 c8 37       	shld   $0x37,%rcx,%rax
    bf0e:	48 b9 47 54 40 8b b9 	movabs $0xb5a52cb98b405447,%rcx
    bf15:	2c a5 b5 
    bf18:	48 39 c8             	cmp    %rcx,%rax
    bf1b:	48 b8 09 fa 82 4b 04 	movabs $0x44b82fa09,%rax
    bf22:	00 00 00 
    bf25:	48 19 c2             	sbb    %rax,%rdx
    bf28:	0f 82 22 01 00 00    	jb     c050 <fwp_fmt_duration+0x280>
    bf2e:	48 b9 cb d5 8f 4d f2 	movabs $0xc57e23f24d8fd5cb,%rcx
    bf35:	23 7e c5 
    bf38:	48 0f af ce          	imul   %rsi,%rcx
    bf3c:	48 bf 39 61 c2 68 56 	movabs $0x790fb65668c26139,%rdi
    bf43:	b6 0f 79 
    bf46:	48 89 f0             	mov    %rsi,%rax
    bf49:	48 f7 e7             	mul    %rdi
    bf4c:	48 01 ca             	add    %rcx,%rdx
    bf4f:	49 0f af f8          	imul   %r8,%rdi
    bf53:	48 01 d7             	add    %rdx,%rdi
    bf56:	48 b9 00 0b 27 69 fe 	movabs $0xa6d698fe69270b00,%rcx
    bf5d:	98 d6 a6 
    bf60:	48 01 c1             	add    %rax,%rcx
    bf63:	48 b8 b1 bd 16 f4 de 	movabs $0x218def416bdb1,%rax
    bf6a:	18 02 00 
    bf6d:	48 11 f8             	adc    %rdi,%rax
    bf70:	48 89 c2             	mov    %rax,%rdx
    bf73:	48 0f ac ca 06       	shrd   $0x6,%rcx,%rdx
    bf78:	48 0f a4 c8 3a       	shld   $0x3a,%rcx,%rax
    bf7d:	48 b9 59 38 49 f3 c7 	movabs $0x8d36b4c7f3493859,%rcx
    bf84:	b4 36 8d 
    bf87:	48 39 c8             	cmp    %rcx,%rax
    bf8a:	48 b8 ed b5 a0 f7 c6 	movabs $0x10c6f7a0b5ed,%rax
    bf91:	10 00 00 
    bf94:	48 19 c2             	sbb    %rax,%rdx
    bf97:	0f 82 c0 00 00 00    	jb     c05d <fwp_fmt_duration+0x28d>
    bf9d:	48 b9 5a 64 3b df 4f 	movabs $0x6e978d4fdf3b645a,%rcx
    bfa4:	8d 97 6e 
    bfa7:	48 0f af ce          	imul   %rsi,%rcx
    bfab:	48 bf d5 78 e9 26 31 	movabs $0x1cac083126e978d5,%rdi
    bfb2:	08 ac 1c 
    bfb5:	48 89 f0             	mov    %rsi,%rax
    bfb8:	48 f7 e7             	mul    %rdi
    bfbb:	48 01 ca             	add    %rcx,%rdx
    bfbe:	49 0f af f8          	imul   %r8,%rdi
    bfc2:	48 01 d7             	add    %rdx,%rdi
    bfc5:	48 b9 48 62 10 58 39 	movabs $0x76c8b43958106248,%rcx
    bfcc:	b4 c8 76 
    bfcf:	48 01 c1             	add    %rax,%rcx
    bfd2:	48 b8 be 9f 1a 2f dd 	movabs $0x10624dd2f1a9fbe,%rax
    bfd9:	24 06 01 
    bfdc:	48 11 f8             	adc    %rdi,%rax
    bfdf:	48 89 c2             	mov    %rax,%rdx
    bfe2:	48 0f ac ca 03       	shrd   $0x3,%rcx,%rdx
    bfe7:	48 0f a4 c8 3d       	shld   $0x3d,%rcx,%rax
    bfec:	48 b9 93 18 04 56 0e 	movabs $0x9db22d0e56041893,%rcx
    bff3:	2d b2 9d 
    bff6:	48 39 c8             	cmp    %rcx,%rax
    bff9:	48 b8 ef a7 c6 4b 37 	movabs $0x4189374bc6a7ef,%rax
    c000:	89 41 00 
    c003:	48 19 c2             	sbb    %rax,%rdx
    c006:	72 62                	jb     c06a <fwp_fmt_duration+0x29a>
    c008:	49 89 e6             	mov    %rsp,%r14
    c00b:	4c 89 f7             	mov    %r14,%rdi
    c00e:	4c 89 c2             	mov    %r8,%rdx
    c011:	e8 ca f6 ff ff       	call   b6e0 <fwp_fmt_i128>
    c016:	48 8d 35 7b 33 00 00 	lea    0x337b(%rip),%rsi        # f398 <exec_in_fp0+0xd48>
    c01d:	48 89 df             	mov    %rbx,%rdi
    c020:	4c 89 f2             	mov    %r14,%rdx
    c023:	31 c0                	xor    %eax,%eax
    c025:	e8 46 64 ff ff       	call   2470 <sprintf@plt>
    c02a:	e9 84 00 00 00       	jmp    c0b3 <fwp_fmt_duration+0x2e3>
    c02f:	48 ba 00 a0 b8 30 46 	movabs $0x34630b8a000,%rdx
    c036:	03 00 00 
    c039:	45 31 ff             	xor    %r15d,%r15d
    c03c:	eb 37                	jmp    c075 <fwp_fmt_duration+0x2a5>
    c03e:	48 ba 00 58 47 f8 0d 	movabs $0xdf8475800,%rdx
    c045:	00 00 00 
    c048:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    c04e:	eb 25                	jmp    c075 <fwp_fmt_duration+0x2a5>
    c050:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
    c055:	41 bf 02 00 00 00    	mov    $0x2,%r15d
    c05b:	eb 18                	jmp    c075 <fwp_fmt_duration+0x2a5>
    c05d:	ba 40 42 0f 00       	mov    $0xf4240,%edx
    c062:	41 bf 03 00 00 00    	mov    $0x3,%r15d
    c068:	eb 0b                	jmp    c075 <fwp_fmt_duration+0x2a5>
    c06a:	ba e8 03 00 00       	mov    $0x3e8,%edx
    c06f:	41 bf 04 00 00 00    	mov    $0x4,%r15d
    c075:	31 c9                	xor    %ecx,%ecx
    c077:	41 c1 e7 04          	shl    $0x4,%r15d
    c07b:	4c 8d 25 ae 7c 00 00 	lea    0x7cae(%rip),%r12        # 13d30 <fwp_fmt_duration.units>
    c082:	48 89 f7             	mov    %rsi,%rdi
    c085:	4c 89 c6             	mov    %r8,%rsi
    c088:	e8 13 0f 00 00       	call   cfa0 <__divti3>
    c08d:	49 89 e6             	mov    %rsp,%r14
    c090:	4c 89 f7             	mov    %r14,%rdi
    c093:	48 89 c6             	mov    %rax,%rsi
    c096:	e8 45 f6 ff ff       	call   b6e0 <fwp_fmt_i128>
    c09b:	4b 8b 0c 27          	mov    (%r15,%r12,1),%rcx
    c09f:	48 8d 35 ed 32 00 00 	lea    0x32ed(%rip),%rsi        # f393 <exec_in_fp0+0xd43>
    c0a6:	48 89 df             	mov    %rbx,%rdi
    c0a9:	4c 89 f2             	mov    %r14,%rdx
    c0ac:	31 c0                	xor    %eax,%eax
    c0ae:	e8 bd 63 ff ff       	call   2470 <sprintf@plt>
    c0b3:	48 83 c4 48          	add    $0x48,%rsp
    c0b7:	5b                   	pop    %rbx
    c0b8:	41 5c                	pop    %r12
    c0ba:	41 5e                	pop    %r14
    c0bc:	41 5f                	pop    %r15
    c0be:	c3                   	ret
    c0bf:	90                   	nop

000000000000c0c0 <fwp_needs_parens>:
    c0c0:	8b 06                	mov    (%rsi),%eax
    c0c2:	83 f8 10             	cmp    $0x10,%eax
    c0c5:	74 16                	je     c0dd <fwp_needs_parens+0x1d>
    c0c7:	83 f8 0e             	cmp    $0xe,%eax
    c0ca:	0f 85 30 02 00 00    	jne    c300 <fwp_is_negative>
    c0d0:	31 c0                	xor    %eax,%eax
    c0d2:	48 81 ff 00 10 00 00 	cmp    $0x1000,%rdi
    c0d9:	0f 93 c0             	setae  %al
    c0dc:	c3                   	ret
    c0dd:	48 8b 46 08          	mov    0x8(%rsi),%rax
    c0e1:	48 85 c0             	test   %rax,%rax
    c0e4:	0f 84 16 02 00 00    	je     c300 <fwp_is_negative>
    c0ea:	50                   	push   %rax
    c0eb:	48 8d 35 99 31 00 00 	lea    0x3199(%rip),%rsi        # f28b <exec_in_fp0+0xc3b>
    c0f2:	48 89 c7             	mov    %rax,%rdi
    c0f5:	e8 d6 61 ff ff       	call   22d0 <strcmp@plt>
    c0fa:	89 c1                	mov    %eax,%ecx
    c0fc:	31 c0                	xor    %eax,%eax
    c0fe:	85 c9                	test   %ecx,%ecx
    c100:	0f 95 c0             	setne  %al
    c103:	48 83 c4 08          	add    $0x8,%rsp
    c107:	c3                   	ret
    c108:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c10f:	00 

000000000000c110 <fwp_format_g>:
    c110:	55                   	push   %rbp
    c111:	41 57                	push   %r15
    c113:	41 56                	push   %r14
    c115:	41 55                	push   %r13
    c117:	41 54                	push   %r12
    c119:	53                   	push   %rbx
    c11a:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    c121:	89 f5                	mov    %esi,%ebp
    c123:	48 89 fb             	mov    %rdi,%rbx
    c126:	ff cd                	dec    %ebp
    c128:	48 8d 15 37 32 00 00 	lea    0x3237(%rip),%rdx        # f366 <exec_in_fp0+0xd16>
    c12f:	4c 8d 64 24 50       	lea    0x50(%rsp),%r12
    c134:	be 40 00 00 00       	mov    $0x40,%esi
    c139:	4c 89 e7             	mov    %r12,%rdi
    c13c:	89 e9                	mov    %ebp,%ecx
    c13e:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    c144:	b0 01                	mov    $0x1,%al
    c146:	e8 85 60 ff ff       	call   21d0 <snprintf@plt>
    c14b:	4c 89 e7             	mov    %r12,%rdi
    c14e:	be 65 00 00 00       	mov    $0x65,%esi
    c153:	e8 58 60 ff ff       	call   21b0 <strchr@plt>
    c158:	49 89 c7             	mov    %rax,%r15
    c15b:	48 8d 78 01          	lea    0x1(%rax),%rdi
    c15f:	e8 fc 62 ff ff       	call   2460 <atoi@plt>
    c164:	41 89 c6             	mov    %eax,%r14d
    c167:	41 8d 46 ef          	lea    -0x11(%r14),%eax
    c16b:	83 f8 e9             	cmp    $0xffffffe9,%eax
    c16e:	77 58                	ja     c1c8 <fwp_format_g+0xb8>
    c170:	4d 29 e7             	sub    %r12,%r15
    c173:	4c 8d 6c 24 10       	lea    0x10(%rsp),%r13
    c178:	4c 89 ef             	mov    %r13,%rdi
    c17b:	4c 89 e6             	mov    %r12,%rsi
    c17e:	4c 89 fa             	mov    %r15,%rdx
    c181:	e8 aa 61 ff ff       	call   2330 <memcpy@plt>
    c186:	42 c6 44 3c 10 00    	movb   $0x0,0x10(%rsp,%r15,1)
    c18c:	4c 89 ef             	mov    %r13,%rdi
    c18f:	be 2e 00 00 00       	mov    $0x2e,%esi
    c194:	e8 17 60 ff ff       	call   21b0 <strchr@plt>
    c199:	48 85 c0             	test   %rax,%rax
    c19c:	0f 84 91 00 00 00    	je     c233 <fwp_format_g+0x123>
    c1a2:	4d 85 ff             	test   %r15,%r15
    c1a5:	0f 84 88 00 00 00    	je     c233 <fwp_format_g+0x123>
    c1ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    c1b0:	42 0f b6 44 3c 0f    	movzbl 0xf(%rsp,%r15,1),%eax
    c1b6:	83 f8 30             	cmp    $0x30,%eax
    c1b9:	75 6d                	jne    c228 <fwp_format_g+0x118>
    c1bb:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    c1c1:	49 ff cf             	dec    %r15
    c1c4:	75 ea                	jne    c1b0 <fwp_format_g+0xa0>
    c1c6:	eb 6b                	jmp    c233 <fwp_format_g+0x123>
    c1c8:	44 29 f5             	sub    %r14d,%ebp
    c1cb:	31 c9                	xor    %ecx,%ecx
    c1cd:	85 ed                	test   %ebp,%ebp
    c1cf:	0f 4f cd             	cmovg  %ebp,%ecx
    c1d2:	48 8d 15 9c 31 00 00 	lea    0x319c(%rip),%rdx        # f375 <exec_in_fp0+0xd25>
    c1d9:	be 90 01 00 00       	mov    $0x190,%esi
    c1de:	48 89 df             	mov    %rbx,%rdi
    c1e1:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    c1e7:	b0 01                	mov    $0x1,%al
    c1e9:	e8 e2 5f ff ff       	call   21d0 <snprintf@plt>
    c1ee:	48 89 df             	mov    %rbx,%rdi
    c1f1:	e8 7a 5f ff ff       	call   2170 <strlen@plt>
    c1f6:	49 89 c6             	mov    %rax,%r14
    c1f9:	48 89 df             	mov    %rbx,%rdi
    c1fc:	be 2e 00 00 00       	mov    $0x2e,%esi
    c201:	e8 aa 5f ff ff       	call   21b0 <strchr@plt>
    c206:	48 85 c0             	test   %rax,%rax
    c209:	74 5b                	je     c266 <fwp_format_g+0x156>
    c20b:	4d 85 f6             	test   %r14,%r14
    c20e:	74 56                	je     c266 <fwp_format_g+0x156>
    c210:	42 0f b6 44 33 ff    	movzbl -0x1(%rbx,%r14,1),%eax
    c216:	83 f8 30             	cmp    $0x30,%eax
    c219:	75 5d                	jne    c278 <fwp_format_g+0x168>
    c21b:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    c221:	49 ff ce             	dec    %r14
    c224:	75 ea                	jne    c210 <fwp_format_g+0x100>
    c226:	eb 3e                	jmp    c266 <fwp_format_g+0x156>
    c228:	83 f8 2e             	cmp    $0x2e,%eax
    c22b:	75 06                	jne    c233 <fwp_format_g+0x123>
    c22d:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    c233:	44 89 f0             	mov    %r14d,%eax
    c236:	c1 e8 1f             	shr    $0x1f,%eax
    c239:	44 8d 04 45 2b 00 00 	lea    0x2b(,%rax,2),%r8d
    c240:	00 
    c241:	45 89 f1             	mov    %r14d,%r9d
    c244:	41 f7 d9             	neg    %r9d
    c247:	45 0f 48 ce          	cmovs  %r14d,%r9d
    c24b:	48 8d 15 19 31 00 00 	lea    0x3119(%rip),%rdx        # f36b <exec_in_fp0+0xd1b>
    c252:	48 8d 4c 24 10       	lea    0x10(%rsp),%rcx
    c257:	be 90 01 00 00       	mov    $0x190,%esi
    c25c:	48 89 df             	mov    %rbx,%rdi
    c25f:	31 c0                	xor    %eax,%eax
    c261:	e8 6a 5f ff ff       	call   21d0 <snprintf@plt>
    c266:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    c26d:	5b                   	pop    %rbx
    c26e:	41 5c                	pop    %r12
    c270:	41 5d                	pop    %r13
    c272:	41 5e                	pop    %r14
    c274:	41 5f                	pop    %r15
    c276:	5d                   	pop    %rbp
    c277:	c3                   	ret
    c278:	83 f8 2e             	cmp    $0x2e,%eax
    c27b:	75 e9                	jne    c266 <fwp_format_g+0x156>
    c27d:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    c283:	eb e1                	jmp    c266 <fwp_format_g+0x156>
    c285:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    c28c:	00 00 00 00 

000000000000c290 <fwp_finish_float>:
    c290:	53                   	push   %rbx
    c291:	48 89 fb             	mov    %rdi,%rbx
    c294:	be 2e 00 00 00       	mov    $0x2e,%esi
    c299:	e8 12 5f ff ff       	call   21b0 <strchr@plt>
    c29e:	48 85 c0             	test   %rax,%rax
    c2a1:	74 02                	je     c2a5 <fwp_finish_float+0x15>
    c2a3:	5b                   	pop    %rbx
    c2a4:	c3                   	ret
    c2a5:	48 89 df             	mov    %rbx,%rdi
    c2a8:	be 65 00 00 00       	mov    $0x65,%esi
    c2ad:	e8 fe 5e ff ff       	call   21b0 <strchr@plt>
    c2b2:	48 85 c0             	test   %rax,%rax
    c2b5:	75 ec                	jne    c2a3 <fwp_finish_float+0x13>
    c2b7:	48 8d 35 e8 2f 00 00 	lea    0x2fe8(%rip),%rsi        # f2a6 <exec_in_fp0+0xc56>
    c2be:	48 89 df             	mov    %rbx,%rdi
    c2c1:	e8 2a 62 ff ff       	call   24f0 <strstr@plt>
    c2c6:	48 85 c0             	test   %rax,%rax
    c2c9:	75 d8                	jne    c2a3 <fwp_finish_float+0x13>
    c2cb:	48 8d 35 d8 2f 00 00 	lea    0x2fd8(%rip),%rsi        # f2aa <exec_in_fp0+0xc5a>
    c2d2:	48 89 df             	mov    %rbx,%rdi
    c2d5:	e8 16 62 ff ff       	call   24f0 <strstr@plt>
    c2da:	48 85 c0             	test   %rax,%rax
    c2dd:	75 c4                	jne    c2a3 <fwp_finish_float+0x13>
    c2df:	48 89 df             	mov    %rbx,%rdi
    c2e2:	e8 89 5e ff ff       	call   2170 <strlen@plt>
    c2e7:	66 c7 04 03 2e 30    	movw   $0x302e,(%rbx,%rax,1)
    c2ed:	c6 44 03 02 00       	movb   $0x0,0x2(%rbx,%rax,1)
    c2f2:	5b                   	pop    %rbx
    c2f3:	c3                   	ret
    c2f4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    c2fb:	00 00 00 00 00 

000000000000c300 <fwp_is_negative>:
    c300:	50                   	push   %rax
    c301:	8b 0e                	mov    (%rsi),%ecx
    c303:	31 c0                	xor    %eax,%eax
    c305:	48 83 f9 0b          	cmp    $0xb,%rcx
    c309:	77 16                	ja     c321 <fwp_is_negative+0x21>
    c30b:	48 8d 15 02 21 00 00 	lea    0x2102(%rip),%rdx        # e414 <_IO_stdin_used+0x414>
    c312:	48 63 0c 8a          	movslq (%rdx,%rcx,4),%rcx
    c316:	48 01 d1             	add    %rdx,%rcx
    c319:	ff e1                	jmp    *%rcx
    c31b:	48 c1 ef 3f          	shr    $0x3f,%rdi
    c31f:	89 f8                	mov    %edi,%eax
    c321:	59                   	pop    %rcx
    c322:	c3                   	ret
    c323:	e8 08 de ff ff       	call   a130 <fwp_f32>
    c328:	0f 50 c0             	movmskps %xmm0,%eax
    c32b:	eb 09                	jmp    c336 <fwp_is_negative+0x36>
    c32d:	e8 8e 6d ff ff       	call   30c0 <fwp_f64>
    c332:	66 0f 50 c0          	movmskpd %xmm0,%eax
    c336:	83 e0 01             	and    $0x1,%eax
    c339:	59                   	pop    %rcx
    c33a:	c3                   	ret
    c33b:	e8 c0 dd ff ff       	call   a100 <fwp_i128>
    c340:	48 89 d0             	mov    %rdx,%rax
    c343:	48 c1 e8 3f          	shr    $0x3f,%rax
    c347:	59                   	pop    %rcx
    c348:	c3                   	ret
    c349:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000c350 <fwp_emit>:
    c350:	53                   	push   %rbx
    c351:	48 83 ec 30          	sub    $0x30,%rsp
    c355:	48 89 f8             	mov    %rdi,%rax
    c358:	83 3d c1 9a 01 00 00 	cmpl   $0x0,0x19ac1(%rip)        # 25e20 <fwp_exec_binary_out>
    c35f:	74 66                	je     c3c7 <fwp_emit+0x77>
    c361:	0f 57 c0             	xorps  %xmm0,%xmm0
    c364:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    c369:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    c370:	00 00 
    c372:	48 8d 15 57 99 00 00 	lea    0x9957(%rip),%rdx        # 15cd0 <d1>
    c379:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    c37e:	48 89 c6             	mov    %rax,%rsi
    c381:	e8 9a 00 00 00       	call   c420 <fwp_encode>
    c386:	c6 44 24 0b 01       	movb   $0x1,0xb(%rsp)
    c38b:	8b 44 24 18          	mov    0x18(%rsp),%eax
    c38f:	89 44 24 0c          	mov    %eax,0xc(%rsp)
    c393:	48 8d 7c 24 0b       	lea    0xb(%rsp),%rdi
    c398:	be 05 00 00 00       	mov    $0x5,%esi
    c39d:	e8 1e a8 ff ff       	call   6bc0 <fwp_pipe_write>
    c3a2:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    c3a7:	48 85 f6             	test   %rsi,%rsi
    c3aa:	74 0a                	je     c3b6 <fwp_emit+0x66>
    c3ac:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    c3b1:	e8 0a a8 ff ff       	call   6bc0 <fwp_pipe_write>
    c3b6:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    c3bb:	e8 90 5c ff ff       	call   2050 <free@plt>
    c3c0:	e8 9b 02 00 00       	call   c660 <fwp_pipe_frame_done>
    c3c5:	eb 1c                	jmp    c3e3 <fwp_emit+0x93>
    c3c7:	83 3d 02 99 00 00 10 	cmpl   $0x10,0x9902(%rip)        # 15cd0 <d1>
    c3ce:	75 19                	jne    c3e9 <fwp_emit+0x99>
    c3d0:	83 3d 09 99 00 00 00 	cmpl   $0x0,0x9909(%rip)        # 15ce0 <d1+0x10>
    c3d7:	75 10                	jne    c3e9 <fwp_emit+0x99>
    c3d9:	48 83 3d f7 98 00 00 	cmpq   $0x0,0x98f7(%rip)        # 15cd8 <d1+0x8>
    c3e0:	00 
    c3e1:	75 06                	jne    c3e9 <fwp_emit+0x99>
    c3e3:	48 83 c4 30          	add    $0x30,%rsp
    c3e7:	5b                   	pop    %rbx
    c3e8:	c3                   	ret
    c3e9:	48 8b 1d c8 7b 00 00 	mov    0x7bc8(%rip),%rbx        # 13fb8 <stdout@GLIBC_2.2.5>
    c3f0:	48 8b 13             	mov    (%rbx),%rdx
    c3f3:	48 8d 35 d6 98 00 00 	lea    0x98d6(%rip),%rsi        # 15cd0 <d1>
    c3fa:	48 89 c7             	mov    %rax,%rdi
    c3fd:	e8 6e eb ff ff       	call   af70 <fwp_display_top>
    c402:	48 8b 33             	mov    (%rbx),%rsi
    c405:	bf 0a 00 00 00       	mov    $0xa,%edi
    c40a:	48 83 c4 30          	add    $0x30,%rsp
    c40e:	5b                   	pop    %rbx
    c40f:	e9 2c 5e ff ff       	jmp    2240 <fputc@plt>
    c414:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    c41b:	00 00 00 00 00 

000000000000c420 <fwp_encode>:
    c420:	41 57                	push   %r15
    c422:	41 56                	push   %r14
    c424:	41 55                	push   %r13
    c426:	41 54                	push   %r12
    c428:	53                   	push   %rbx
    c429:	8b 02                	mov    (%rdx),%eax
    c42b:	48 83 f8 15          	cmp    $0x15,%rax
    c42f:	0f 87 14 02 00 00    	ja     c649 <fwp_encode+0x229>
    c435:	49 89 d7             	mov    %rdx,%r15
    c438:	49 89 f6             	mov    %rsi,%r14
    c43b:	48 89 fb             	mov    %rdi,%rbx
    c43e:	48 8d 0d ff 1f 00 00 	lea    0x1fff(%rip),%rcx        # e444 <_IO_stdin_used+0x444>
    c445:	48 63 04 81          	movslq (%rcx,%rax,4),%rax
    c449:	48 01 c8             	add    %rcx,%rax
    c44c:	ff e0                	jmp    *%rax
    c44e:	48 89 df             	mov    %rbx,%rdi
    c451:	4c 89 f6             	mov    %r14,%rsi
    c454:	ba 01 00 00 00       	mov    $0x1,%edx
    c459:	e9 77 01 00 00       	jmp    c5d5 <fwp_encode+0x1b5>
    c45e:	48 89 df             	mov    %rbx,%rdi
    c461:	4c 89 f6             	mov    %r14,%rsi
    c464:	ba 04 00 00 00       	mov    $0x4,%edx
    c469:	e9 67 01 00 00       	jmp    c5d5 <fwp_encode+0x1b5>
    c46e:	49 8b 36             	mov    (%r14),%rsi
    c471:	48 89 df             	mov    %rbx,%rdi
    c474:	e8 57 02 00 00       	call   c6d0 <fwp_leb128>
    c479:	49 8b 16             	mov    (%r14),%rdx
    c47c:	49 83 c6 08          	add    $0x8,%r14
    c480:	48 89 df             	mov    %rbx,%rdi
    c483:	4c 89 f6             	mov    %r14,%rsi
    c486:	5b                   	pop    %rbx
    c487:	41 5c                	pop    %r12
    c489:	41 5d                	pop    %r13
    c48b:	41 5e                	pop    %r14
    c48d:	41 5f                	pop    %r15
    c48f:	e9 fc b5 ff ff       	jmp    7a90 <buf_put>
    c494:	48 89 df             	mov    %rbx,%rdi
    c497:	4c 89 f6             	mov    %r14,%rsi
    c49a:	ba 02 00 00 00       	mov    $0x2,%edx
    c49f:	e9 31 01 00 00       	jmp    c5d5 <fwp_encode+0x1b5>
    c4a4:	49 8b 36             	mov    (%r14),%rsi
    c4a7:	48 89 df             	mov    %rbx,%rdi
    c4aa:	e8 21 02 00 00       	call   c6d0 <fwp_leb128>
    c4af:	49 83 3e 00          	cmpq   $0x0,(%r14)
    c4b3:	0f 84 90 01 00 00    	je     c649 <fwp_encode+0x229>
    c4b9:	4d 8d 66 10          	lea    0x10(%r14),%r12
    c4bd:	45 31 ed             	xor    %r13d,%r13d
    c4c0:	eb 1e                	jmp    c4e0 <fwp_encode+0xc0>
    c4c2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c4c9:	1f 84 00 00 00 00 00 
    c4d0:	49 ff c5             	inc    %r13
    c4d3:	49 83 c4 10          	add    $0x10,%r12
    c4d7:	4d 3b 2e             	cmp    (%r14),%r13
    c4da:	0f 83 69 01 00 00    	jae    c649 <fwp_encode+0x229>
    c4e0:	49 8b 74 24 f8       	mov    -0x8(%r12),%rsi
    c4e5:	49 8b 57 38          	mov    0x38(%r15),%rdx
    c4e9:	48 89 df             	mov    %rbx,%rdi
    c4ec:	e8 2f ff ff ff       	call   c420 <fwp_encode>
    c4f1:	41 83 3f 12          	cmpl   $0x12,(%r15)
    c4f5:	75 d9                	jne    c4d0 <fwp_encode+0xb0>
    c4f7:	49 8b 34 24          	mov    (%r12),%rsi
    c4fb:	49 8b 57 40          	mov    0x40(%r15),%rdx
    c4ff:	48 89 df             	mov    %rbx,%rdi
    c502:	e8 19 ff ff ff       	call   c420 <fwp_encode>
    c507:	eb c7                	jmp    c4d0 <fwp_encode+0xb0>
    c509:	4c 89 f7             	mov    %r14,%rdi
    c50c:	e8 4f dc ff ff       	call   a160 <fwp_tag>
    c511:	41 89 c4             	mov    %eax,%r12d
    c514:	48 89 df             	mov    %rbx,%rdi
    c517:	4c 89 e6             	mov    %r12,%rsi
    c51a:	e8 b1 01 00 00       	call   c6d0 <fwp_leb128>
    c51f:	49 8b 47 28          	mov    0x28(%r15),%rax
    c523:	42 83 3c a0 00       	cmpl   $0x0,(%rax,%r12,4)
    c528:	0f 8e 1b 01 00 00    	jle    c649 <fwp_encode+0x229>
    c52e:	45 31 ed             	xor    %r13d,%r13d
    c531:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c538:	0f 1f 84 00 00 00 00 
    c53f:	00 
    c540:	4b 8b 74 ee 08       	mov    0x8(%r14,%r13,8),%rsi
    c545:	49 8b 47 30          	mov    0x30(%r15),%rax
    c549:	4a 8b 04 e0          	mov    (%rax,%r12,8),%rax
    c54d:	4a 8b 14 e8          	mov    (%rax,%r13,8),%rdx
    c551:	48 89 df             	mov    %rbx,%rdi
    c554:	e8 c7 fe ff ff       	call   c420 <fwp_encode>
    c559:	49 ff c5             	inc    %r13
    c55c:	49 8b 47 28          	mov    0x28(%r15),%rax
    c560:	4a 63 04 a0          	movslq (%rax,%r12,4),%rax
    c564:	49 39 c5             	cmp    %rax,%r13
    c567:	7c d7                	jl     c540 <fwp_encode+0x120>
    c569:	e9 db 00 00 00       	jmp    c649 <fwp_encode+0x229>
    c56e:	4c 89 f7             	mov    %r14,%rdi
    c571:	e8 8a db ff ff       	call   a100 <fwp_i128>
    c576:	eb 3f                	jmp    c5b7 <fwp_encode+0x197>
    c578:	4c 89 f7             	mov    %r14,%rdi
    c57b:	e8 70 d6 ff ff       	call   9bf0 <fwp_list_len>
    c580:	48 89 df             	mov    %rbx,%rdi
    c583:	48 89 c6             	mov    %rax,%rsi
    c586:	e8 45 01 00 00       	call   c6d0 <fwp_leb128>
    c58b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    c590:	4d 85 f6             	test   %r14,%r14
    c593:	0f 84 b0 00 00 00    	je     c649 <fwp_encode+0x229>
    c599:	49 8b 76 08          	mov    0x8(%r14),%rsi
    c59d:	49 8b 57 38          	mov    0x38(%r15),%rdx
    c5a1:	48 89 df             	mov    %rbx,%rdi
    c5a4:	e8 77 fe ff ff       	call   c420 <fwp_encode>
    c5a9:	4d 8b 76 10          	mov    0x10(%r14),%r14
    c5ad:	eb e1                	jmp    c590 <fwp_encode+0x170>
    c5af:	4c 89 f7             	mov    %r14,%rdi
    c5b2:	e8 59 db ff ff       	call   a110 <fwp_u128>
    c5b7:	49 89 d6             	mov    %rdx,%r14
    c5ba:	48 89 df             	mov    %rbx,%rdi
    c5bd:	48 89 c6             	mov    %rax,%rsi
    c5c0:	ba 08 00 00 00       	mov    $0x8,%edx
    c5c5:	e8 b6 00 00 00       	call   c680 <fwp_le>
    c5ca:	48 89 df             	mov    %rbx,%rdi
    c5cd:	4c 89 f6             	mov    %r14,%rsi
    c5d0:	ba 08 00 00 00       	mov    $0x8,%edx
    c5d5:	5b                   	pop    %rbx
    c5d6:	41 5c                	pop    %r12
    c5d8:	41 5d                	pop    %r13
    c5da:	41 5e                	pop    %r14
    c5dc:	41 5f                	pop    %r15
    c5de:	e9 9d 00 00 00       	jmp    c680 <fwp_le>
    c5e3:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    c5e8:	7e 5f                	jle    c649 <fwp_encode+0x229>
    c5ea:	45 31 e4             	xor    %r12d,%r12d
    c5ed:	0f 1f 00             	nopl   (%rax)
    c5f0:	4b 8b 74 e6 08       	mov    0x8(%r14,%r12,8),%rsi
    c5f5:	49 8b 47 20          	mov    0x20(%r15),%rax
    c5f9:	4a 8b 14 e0          	mov    (%rax,%r12,8),%rdx
    c5fd:	48 89 df             	mov    %rbx,%rdi
    c600:	e8 1b fe ff ff       	call   c420 <fwp_encode>
    c605:	49 ff c4             	inc    %r12
    c608:	49 63 47 10          	movslq 0x10(%r15),%rax
    c60c:	49 39 c4             	cmp    %rax,%r12
    c60f:	7c df                	jl     c5f0 <fwp_encode+0x1d0>
    c611:	eb 36                	jmp    c649 <fwp_encode+0x229>
    c613:	49 8b 36             	mov    (%r14),%rsi
    c616:	48 89 df             	mov    %rbx,%rdi
    c619:	e8 b2 00 00 00       	call   c6d0 <fwp_leb128>
    c61e:	49 83 3e 00          	cmpq   $0x0,(%r14)
    c622:	74 25                	je     c649 <fwp_encode+0x229>
    c624:	45 31 e4             	xor    %r12d,%r12d
    c627:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    c62e:	00 00 
    c630:	4b 8b 74 e6 08       	mov    0x8(%r14,%r12,8),%rsi
    c635:	49 8b 57 38          	mov    0x38(%r15),%rdx
    c639:	48 89 df             	mov    %rbx,%rdi
    c63c:	e8 df fd ff ff       	call   c420 <fwp_encode>
    c641:	49 ff c4             	inc    %r12
    c644:	4d 3b 26             	cmp    (%r14),%r12
    c647:	72 e7                	jb     c630 <fwp_encode+0x210>
    c649:	5b                   	pop    %rbx
    c64a:	41 5c                	pop    %r12
    c64c:	41 5d                	pop    %r13
    c64e:	41 5e                	pop    %r14
    c650:	41 5f                	pop    %r15
    c652:	c3                   	ret
    c653:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c65a:	84 00 00 00 00 00 

000000000000c660 <fwp_pipe_frame_done>:
    c660:	83 3d 55 96 00 00 00 	cmpl   $0x0,0x9655(%rip)        # 15cbc <fwp_po_listen>
    c667:	78 16                	js     c67f <fwp_pipe_frame_done+0x1f>
    c669:	8b 05 01 98 02 00    	mov    0x29801(%rip),%eax        # 35e70 <fwp_po_frames>
    c66f:	ff c0                	inc    %eax
    c671:	89 05 f9 97 02 00    	mov    %eax,0x297f9(%rip)        # 35e70 <fwp_po_frames>
    c677:	a8 3f                	test   $0x3f,%al
    c679:	0f 84 11 e0 ff ff    	je     a690 <fwp_pipe_poll>
    c67f:	c3                   	ret

000000000000c680 <fwp_le>:
    c680:	85 d2                	test   %edx,%edx
    c682:	7e 44                	jle    c6c8 <fwp_le+0x48>
    c684:	41 57                	push   %r15
    c686:	41 56                	push   %r14
    c688:	41 54                	push   %r12
    c68a:	53                   	push   %rbx
    c68b:	50                   	push   %rax
    c68c:	48 89 f3             	mov    %rsi,%rbx
    c68f:	49 89 fe             	mov    %rdi,%r14
    c692:	41 89 d4             	mov    %edx,%r12d
    c695:	49 c1 e4 03          	shl    $0x3,%r12
    c699:	45 31 ff             	xor    %r15d,%r15d
    c69c:	0f 1f 40 00          	nopl   0x0(%rax)
    c6a0:	48 89 d8             	mov    %rbx,%rax
    c6a3:	44 89 f9             	mov    %r15d,%ecx
    c6a6:	48 d3 e8             	shr    %cl,%rax
    c6a9:	0f be f0             	movsbl %al,%esi
    c6ac:	4c 89 f7             	mov    %r14,%rdi
    c6af:	e8 8c b3 ff ff       	call   7a40 <buf_putc>
    c6b4:	49 83 c7 08          	add    $0x8,%r15
    c6b8:	4d 39 fc             	cmp    %r15,%r12
    c6bb:	75 e3                	jne    c6a0 <fwp_le+0x20>
    c6bd:	48 83 c4 08          	add    $0x8,%rsp
    c6c1:	5b                   	pop    %rbx
    c6c2:	41 5c                	pop    %r12
    c6c4:	41 5e                	pop    %r14
    c6c6:	41 5f                	pop    %r15
    c6c8:	c3                   	ret
    c6c9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000c6d0 <fwp_leb128>:
    c6d0:	41 57                	push   %r15
    c6d2:	41 56                	push   %r14
    c6d4:	53                   	push   %rbx
    c6d5:	49 89 f6             	mov    %rsi,%r14
    c6d8:	48 89 fb             	mov    %rdi,%rbx
    c6db:	48 81 fe 80 00 00 00 	cmp    $0x80,%rsi
    c6e2:	73 05                	jae    c6e9 <fwp_leb128+0x19>
    c6e4:	4d 89 f7             	mov    %r14,%r15
    c6e7:	eb 27                	jmp    c710 <fwp_leb128+0x40>
    c6e9:	4d 89 f7             	mov    %r14,%r15
    c6ec:	0f 1f 40 00          	nopl   0x0(%rax)
    c6f0:	49 c1 ef 07          	shr    $0x7,%r15
    c6f4:	44 89 f0             	mov    %r14d,%eax
    c6f7:	0c 80                	or     $0x80,%al
    c6f9:	0f be f0             	movsbl %al,%esi
    c6fc:	48 89 df             	mov    %rbx,%rdi
    c6ff:	e8 3c b3 ff ff       	call   7a40 <buf_putc>
    c704:	49 81 fe ff 3f 00 00 	cmp    $0x3fff,%r14
    c70b:	4d 89 fe             	mov    %r15,%r14
    c70e:	77 e0                	ja     c6f0 <fwp_leb128+0x20>
    c710:	41 0f be f7          	movsbl %r15b,%esi
    c714:	48 89 df             	mov    %rbx,%rdi
    c717:	5b                   	pop    %rbx
    c718:	41 5e                	pop    %r14
    c71a:	41 5f                	pop    %r15
    c71c:	e9 1f b3 ff ff       	jmp    7a40 <buf_putc>
    c721:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c728:	0f 1f 84 00 00 00 00 
    c72f:	00 

000000000000c730 <fwp_pipe_read>:
    c730:	55                   	push   %rbp
    c731:	41 57                	push   %r15
    c733:	41 56                	push   %r14
    c735:	41 55                	push   %r13
    c737:	41 54                	push   %r12
    c739:	53                   	push   %rbx
    c73a:	50                   	push   %rax
    c73b:	48 89 f3             	mov    %rsi,%rbx
    c73e:	8b 05 30 97 02 00    	mov    0x29730(%rip),%eax        # 35e74 <fwp_pi_kind>
    c744:	83 f8 01             	cmp    $0x1,%eax
    c747:	0f 84 89 00 00 00    	je     c7d6 <fwp_pipe_read+0xa6>
    c74d:	83 f8 02             	cmp    $0x2,%eax
    c750:	0f 85 d7 00 00 00    	jne    c82d <fwp_pipe_read+0xfd>
    c756:	48 89 3c 24          	mov    %rdi,(%rsp)
    c75a:	4c 8b 25 17 97 02 00 	mov    0x29717(%rip),%r12        # 35e78 <fwp_pi_ring>
    c761:	4d 8d ac 24 c0 00 00 	lea    0xc0(%r12),%r13
    c768:	00 
    c769:	49 8d ac 24 c4 00 00 	lea    0xc4(%r12),%rbp
    c770:	00 
    c771:	4c 8d 35 b8 01 00 00 	lea    0x1b8(%rip),%r14        # c930 <fwp_ring_has_data>
    c778:	45 31 ff             	xor    %r15d,%r15d
    c77b:	eb 23                	jmp    c7a0 <fwp_pipe_read+0x70>
    c77d:	0f 1f 00             	nopl   (%rax)
    c780:	44 8b 05 41 95 00 00 	mov    0x9541(%rip),%r8d        # 15cc8 <fwp_pi_sock>
    c787:	4c 89 e7             	mov    %r12,%rdi
    c78a:	4c 89 ee             	mov    %r13,%rsi
    c78d:	48 89 ea             	mov    %rbp,%rdx
    c790:	4c 89 f1             	mov    %r14,%rcx
    c793:	e8 98 dc ff ff       	call   a430 <fwp_ring_wait>
    c798:	85 c0                	test   %eax,%eax
    c79a:	0f 84 6c 01 00 00    	je     c90c <fwp_pipe_read+0x1dc>
    c7a0:	49 8b 4c 24 40       	mov    0x40(%r12),%rcx
    c7a5:	49 8b 84 24 80 00 00 	mov    0x80(%r12),%rax
    c7ac:	00 
    c7ad:	48 29 c1             	sub    %rax,%rcx
    c7b0:	0f 85 9c 00 00 00    	jne    c852 <fwp_pipe_read+0x122>
    c7b6:	41 8b 84 24 40 01 00 	mov    0x140(%r12),%eax
    c7bd:	00 
    c7be:	85 c0                	test   %eax,%eax
    c7c0:	74 be                	je     c780 <fwp_pipe_read+0x50>
    c7c2:	49 8b 44 24 40       	mov    0x40(%r12),%rax
    c7c7:	49 3b 84 24 80 00 00 	cmp    0x80(%r12),%rax
    c7ce:	00 
    c7cf:	75 af                	jne    c780 <fwp_pipe_read+0x50>
    c7d1:	e9 36 01 00 00       	jmp    c90c <fwp_pipe_read+0x1dc>
    c7d6:	4c 8b 35 a3 96 02 00 	mov    0x296a3(%rip),%r14        # 35e80 <fwp_pi_pos>
    c7dd:	4c 8b 3d a4 96 02 00 	mov    0x296a4(%rip),%r15        # 35e88 <fwp_pi_len>
    c7e4:	4d 39 fe             	cmp    %r15,%r14
    c7e7:	0f 85 f9 00 00 00    	jne    c8e6 <fwp_pipe_read+0x1b6>
    c7ed:	49 89 fc             	mov    %rdi,%r12
    c7f0:	4c 8d 35 99 96 02 00 	lea    0x29699(%rip),%r14        # 35e90 <fwp_pi_buf>
    c7f7:	45 31 ff             	xor    %r15d,%r15d
    c7fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    c800:	8b 3d c2 94 00 00    	mov    0x94c2(%rip),%edi        # 15cc8 <fwp_pi_sock>
    c806:	ba 00 00 01 00       	mov    $0x10000,%edx
    c80b:	4c 89 f6             	mov    %r14,%rsi
    c80e:	31 c9                	xor    %ecx,%ecx
    c810:	e8 4b 58 ff ff       	call   2060 <recv@plt>
    c815:	48 85 c0             	test   %rax,%rax
    c818:	0f 89 b6 00 00 00    	jns    c8d4 <fwp_pipe_read+0x1a4>
    c81e:	e8 5d 58 ff ff       	call   2080 <__errno_location@plt>
    c823:	83 38 04             	cmpl   $0x4,(%rax)
    c826:	74 d8                	je     c800 <fwp_pipe_read+0xd0>
    c828:	e9 df 00 00 00       	jmp    c90c <fwp_pipe_read+0x1dc>
    c82d:	48 8b 05 8c 77 00 00 	mov    0x778c(%rip),%rax        # 13fc0 <stdin@GLIBC_2.2.5>
    c834:	48 8b 08             	mov    (%rax),%rcx
    c837:	be 01 00 00 00       	mov    $0x1,%esi
    c83c:	48 89 da             	mov    %rbx,%rdx
    c83f:	48 83 c4 08          	add    $0x8,%rsp
    c843:	5b                   	pop    %rbx
    c844:	41 5c                	pop    %r12
    c846:	41 5d                	pop    %r13
    c848:	41 5e                	pop    %r14
    c84a:	41 5f                	pop    %r15
    c84c:	5d                   	pop    %rbp
    c84d:	e9 9e 58 ff ff       	jmp    20f0 <fread@plt>
    c852:	48 39 d9             	cmp    %rbx,%rcx
    c855:	48 0f 42 d9          	cmovb  %rcx,%rbx
    c859:	4d 8b 74 24 08       	mov    0x8(%r12),%r14
    c85e:	49 8d 4e ff          	lea    -0x1(%r14),%rcx
    c862:	48 21 c1             	and    %rax,%rcx
    c865:	49 29 ce             	sub    %rcx,%r14
    c868:	4c 39 f3             	cmp    %r14,%rbx
    c86b:	4c 0f 42 f3          	cmovb  %rbx,%r14
    c86f:	4d 8d bc 24 00 10 00 	lea    0x1000(%r12),%r15
    c876:	00 
    c877:	49 8d 34 0c          	lea    (%r12,%rcx,1),%rsi
    c87b:	48 81 c6 00 10 00 00 	add    $0x1000,%rsi
    c882:	4c 8b 2c 24          	mov    (%rsp),%r13
    c886:	4c 89 ef             	mov    %r13,%rdi
    c889:	4c 89 f2             	mov    %r14,%rdx
    c88c:	e8 9f 5a ff ff       	call   2330 <memcpy@plt>
    c891:	4d 01 f5             	add    %r14,%r13
    c894:	48 89 da             	mov    %rbx,%rdx
    c897:	4c 29 f2             	sub    %r14,%rdx
    c89a:	4c 89 ef             	mov    %r13,%rdi
    c89d:	4c 89 fe             	mov    %r15,%rsi
    c8a0:	e8 8b 5a ff ff       	call   2330 <memcpy@plt>
    c8a5:	49 8b 84 24 80 00 00 	mov    0x80(%r12),%rax
    c8ac:	00 
    c8ad:	48 01 d8             	add    %rbx,%rax
    c8b0:	49 89 84 24 80 00 00 	mov    %rax,0x80(%r12)
    c8b7:	00 
    c8b8:	49 8d bc 24 00 01 00 	lea    0x100(%r12),%rdi
    c8bf:	00 
    c8c0:	49 81 c4 04 01 00 00 	add    $0x104,%r12
    c8c7:	4c 89 e6             	mov    %r12,%rsi
    c8ca:	e8 c1 dc ff ff       	call   a590 <fwp_ring_wake>
    c8cf:	49 89 df             	mov    %rbx,%r15
    c8d2:	eb 38                	jmp    c90c <fwp_pipe_read+0x1dc>
    c8d4:	74 48                	je     c91e <fwp_pipe_read+0x1ee>
    c8d6:	4c 89 e7             	mov    %r12,%rdi
    c8d9:	48 89 05 a8 95 02 00 	mov    %rax,0x295a8(%rip)        # 35e88 <fwp_pi_len>
    c8e0:	45 31 f6             	xor    %r14d,%r14d
    c8e3:	49 89 c7             	mov    %rax,%r15
    c8e6:	4d 29 f7             	sub    %r14,%r15
    c8e9:	49 39 df             	cmp    %rbx,%r15
    c8ec:	4c 0f 43 fb          	cmovae %rbx,%r15
    c8f0:	48 8d 35 99 95 02 00 	lea    0x29599(%rip),%rsi        # 35e90 <fwp_pi_buf>
    c8f7:	4c 01 f6             	add    %r14,%rsi
    c8fa:	4c 89 fa             	mov    %r15,%rdx
    c8fd:	e8 2e 5a ff ff       	call   2330 <memcpy@plt>
    c902:	4d 01 fe             	add    %r15,%r14
    c905:	4c 89 35 74 95 02 00 	mov    %r14,0x29574(%rip)        # 35e80 <fwp_pi_pos>
    c90c:	4c 89 f8             	mov    %r15,%rax
    c90f:	48 83 c4 08          	add    $0x8,%rsp
    c913:	5b                   	pop    %rbx
    c914:	41 5c                	pop    %r12
    c916:	41 5d                	pop    %r13
    c918:	41 5e                	pop    %r14
    c91a:	41 5f                	pop    %r15
    c91c:	5d                   	pop    %rbp
    c91d:	c3                   	ret
    c91e:	45 31 ff             	xor    %r15d,%r15d
    c921:	eb e9                	jmp    c90c <fwp_pipe_read+0x1dc>
    c923:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c92a:	84 00 00 00 00 00 

000000000000c930 <fwp_ring_has_data>:
    c930:	48 8b 4f 40          	mov    0x40(%rdi),%rcx
    c934:	b8 01 00 00 00       	mov    $0x1,%eax
    c939:	48 3b 8f 80 00 00 00 	cmp    0x80(%rdi),%rcx
    c940:	75 0d                	jne    c94f <fwp_ring_has_data+0x1f>
    c942:	8b 8f 40 01 00 00    	mov    0x140(%rdi),%ecx
    c948:	31 c0                	xor    %eax,%eax
    c94a:	85 c9                	test   %ecx,%ecx
    c94c:	0f 95 c0             	setne  %al
    c94f:	c3                   	ret

000000000000c950 <fwp_pipe_report>:
    c950:	53                   	push   %rbx
    c951:	48 89 fb             	mov    %rdi,%rbx
    c954:	48 8d 3d 4d 2a 00 00 	lea    0x2a4d(%rip),%rdi        # f3a8 <exec_in_fp0+0xd58>
    c95b:	e8 d0 56 ff ff       	call   2030 <getenv@plt>
    c960:	48 85 c0             	test   %rax,%rax
    c963:	74 18                	je     c97d <fwp_pipe_report+0x2d>
    c965:	80 38 00             	cmpb   $0x0,(%rax)
    c968:	74 13                	je     c97d <fwp_pipe_report+0x2d>
    c96a:	48 8d 35 0a 2a 00 00 	lea    0x2a0a(%rip),%rsi        # f37b <exec_in_fp0+0xd2b>
    c971:	48 89 c7             	mov    %rax,%rdi
    c974:	e8 57 59 ff ff       	call   22d0 <strcmp@plt>
    c979:	85 c0                	test   %eax,%eax
    c97b:	75 02                	jne    c97f <fwp_pipe_report+0x2f>
    c97d:	5b                   	pop    %rbx
    c97e:	c3                   	ret
    c97f:	48 8b 05 5a 76 00 00 	mov    0x765a(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    c986:	48 8b 38             	mov    (%rax),%rdi
    c989:	48 8d 35 2d 2a 00 00 	lea    0x2a2d(%rip),%rsi        # f3bd <exec_in_fp0+0xd6d>
    c990:	48 89 da             	mov    %rbx,%rdx
    c993:	31 c0                	xor    %eax,%eax
    c995:	5b                   	pop    %rbx
    c996:	e9 55 59 ff ff       	jmp    22f0 <fprintf@plt>
    c99b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000c9a0 <rd_le>:
    c9a0:	55                   	push   %rbp
    c9a1:	41 56                	push   %r14
    c9a3:	53                   	push   %rbx
    c9a4:	48 83 ec 10          	sub    $0x10,%rsp
    c9a8:	48 89 d3             	mov    %rdx,%rbx
    c9ab:	89 f5                	mov    %esi,%ebp
    c9ad:	41 89 f6             	mov    %esi,%r14d
    c9b0:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    c9b5:	4c 89 f6             	mov    %r14,%rsi
    c9b8:	e8 23 01 00 00       	call   cae0 <rd_take>
    c9bd:	85 c0                	test   %eax,%eax
    c9bf:	74 20                	je     c9e1 <rd_le+0x41>
    c9c1:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    c9c8:	b8 01 00 00 00       	mov    $0x1,%eax
    c9cd:	85 ed                	test   %ebp,%ebp
    c9cf:	7e 7d                	jle    ca4e <rd_le+0xae>
    c9d1:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    c9d6:	83 fd 01             	cmp    $0x1,%ebp
    c9d9:	75 0a                	jne    c9e5 <rd_le+0x45>
    c9db:	31 d2                	xor    %edx,%edx
    c9dd:	31 ff                	xor    %edi,%edi
    c9df:	eb 55                	jmp    ca36 <rd_le+0x96>
    c9e1:	31 c0                	xor    %eax,%eax
    c9e3:	eb 69                	jmp    ca4e <rd_le+0xae>
    c9e5:	45 89 f0             	mov    %r14d,%r8d
    c9e8:	41 81 e0 fe ff ff 7f 	and    $0x7ffffffe,%r8d
    c9ef:	41 b9 08 00 00 00    	mov    $0x8,%r9d
    c9f5:	31 d2                	xor    %edx,%edx
    c9f7:	31 ff                	xor    %edi,%edi
    c9f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    ca00:	44 0f b6 14 16       	movzbl (%rsi,%rdx,1),%r10d
    ca05:	41 8d 49 f8          	lea    -0x8(%r9),%ecx
    ca09:	80 e1 f0             	and    $0xf0,%cl
    ca0c:	49 d3 e2             	shl    %cl,%r10
    ca0f:	49 09 fa             	or     %rdi,%r10
    ca12:	4c 89 13             	mov    %r10,(%rbx)
    ca15:	0f b6 7c 16 01       	movzbl 0x1(%rsi,%rdx,1),%edi
    ca1a:	44 89 c9             	mov    %r9d,%ecx
    ca1d:	80 e1 f8             	and    $0xf8,%cl
    ca20:	48 d3 e7             	shl    %cl,%rdi
    ca23:	4c 09 d7             	or     %r10,%rdi
    ca26:	48 89 3b             	mov    %rdi,(%rbx)
    ca29:	48 83 c2 02          	add    $0x2,%rdx
    ca2d:	49 83 c1 10          	add    $0x10,%r9
    ca31:	49 39 d0             	cmp    %rdx,%r8
    ca34:	75 ca                	jne    ca00 <rd_le+0x60>
    ca36:	41 f6 c6 01          	test   $0x1,%r14b
    ca3a:	74 12                	je     ca4e <rd_le+0xae>
    ca3c:	0f b6 34 16          	movzbl (%rsi,%rdx,1),%esi
    ca40:	c1 e2 03             	shl    $0x3,%edx
    ca43:	89 d1                	mov    %edx,%ecx
    ca45:	48 d3 e6             	shl    %cl,%rsi
    ca48:	48 09 fe             	or     %rdi,%rsi
    ca4b:	48 89 33             	mov    %rsi,(%rbx)
    ca4e:	48 83 c4 10          	add    $0x10,%rsp
    ca52:	5b                   	pop    %rbx
    ca53:	41 5e                	pop    %r14
    ca55:	5d                   	pop    %rbp
    ca56:	c3                   	ret
    ca57:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    ca5e:	00 00 

000000000000ca60 <rd_leb>:
    ca60:	41 57                	push   %r15
    ca62:	41 56                	push   %r14
    ca64:	41 54                	push   %r12
    ca66:	53                   	push   %rbx
    ca67:	50                   	push   %rax
    ca68:	48 89 f3             	mov    %rsi,%rbx
    ca6b:	49 89 fe             	mov    %rdi,%r14
    ca6e:	48 c7 06 00 00 00 00 	movq   $0x0,(%rsi)
    ca75:	49 c7 c7 f9 ff ff ff 	mov    $0xfffffffffffffff9,%r15
    ca7c:	49 89 e4             	mov    %rsp,%r12
    ca7f:	90                   	nop
    ca80:	be 01 00 00 00       	mov    $0x1,%esi
    ca85:	4c 89 f7             	mov    %r14,%rdi
    ca88:	4c 89 e2             	mov    %r12,%rdx
    ca8b:	e8 50 00 00 00       	call   cae0 <rd_take>
    ca90:	85 c0                	test   %eax,%eax
    ca92:	74 2f                	je     cac3 <rd_leb+0x63>
    ca94:	48 8b 04 24          	mov    (%rsp),%rax
    ca98:	0f b6 10             	movzbl (%rax),%edx
    ca9b:	49 83 ff 38          	cmp    $0x38,%r15
    ca9f:	75 07                	jne    caa8 <rd_leb+0x48>
    caa1:	89 d1                	mov    %edx,%ecx
    caa3:	80 e1 7e             	and    $0x7e,%cl
    caa6:	75 1b                	jne    cac3 <rd_leb+0x63>
    caa8:	49 83 c7 07          	add    $0x7,%r15
    caac:	83 e2 7f             	and    $0x7f,%edx
    caaf:	44 89 f9             	mov    %r15d,%ecx
    cab2:	48 d3 e2             	shl    %cl,%rdx
    cab5:	48 09 13             	or     %rdx,(%rbx)
    cab8:	80 38 00             	cmpb   $0x0,(%rax)
    cabb:	79 0a                	jns    cac7 <rd_leb+0x67>
    cabd:	49 83 ff 38          	cmp    $0x38,%r15
    cac1:	76 bd                	jbe    ca80 <rd_leb+0x20>
    cac3:	31 c0                	xor    %eax,%eax
    cac5:	eb 05                	jmp    cacc <rd_leb+0x6c>
    cac7:	b8 01 00 00 00       	mov    $0x1,%eax
    cacc:	48 83 c4 08          	add    $0x8,%rsp
    cad0:	5b                   	pop    %rbx
    cad1:	41 5c                	pop    %r12
    cad3:	41 5e                	pop    %r14
    cad5:	41 5f                	pop    %r15
    cad7:	c3                   	ret
    cad8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    cadf:	00 

000000000000cae0 <rd_take>:
    cae0:	4c 8b 47 08          	mov    0x8(%rdi),%r8
    cae4:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    cae8:	49 29 c8             	sub    %rcx,%r8
    caeb:	31 c0                	xor    %eax,%eax
    caed:	49 39 f0             	cmp    %rsi,%r8
    caf0:	72 15                	jb     cb07 <rd_take+0x27>
    caf2:	48 8b 07             	mov    (%rdi),%rax
    caf5:	48 01 c8             	add    %rcx,%rax
    caf8:	48 89 02             	mov    %rax,(%rdx)
    cafb:	48 01 ce             	add    %rcx,%rsi
    cafe:	48 89 77 10          	mov    %rsi,0x10(%rdi)
    cb02:	b8 01 00 00 00       	mov    $0x1,%eax
    cb07:	c3                   	ret
    cb08:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    cb0f:	00 

000000000000cb10 <fwp_getc>:
    cb10:	48 63 05 15 93 01 00 	movslq 0x19315(%rip),%rax        # 25e2c <fwp_in_ppos>
    cb17:	3b 05 0b 93 01 00    	cmp    0x1930b(%rip),%eax        # 25e28 <fwp_in_npend>
    cb1d:	7d 15                	jge    cb34 <fwp_getc+0x24>
    cb1f:	8d 48 01             	lea    0x1(%rax),%ecx
    cb22:	89 0d 04 93 01 00    	mov    %ecx,0x19304(%rip)        # 25e2c <fwp_in_ppos>
    cb28:	48 8d 0d f5 92 01 00 	lea    0x192f5(%rip),%rcx        # 25e24 <fwp_in_pend>
    cb2f:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax
    cb33:	c3                   	ret
    cb34:	48 8b 05 85 74 00 00 	mov    0x7485(%rip),%rax        # 13fc0 <stdin@GLIBC_2.2.5>
    cb3b:	48 8b 38             	mov    (%rax),%rdi
    cb3e:	e9 dd 56 ff ff       	jmp    2220 <fgetc@plt>
    cb43:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    cb4a:	84 00 00 00 00 00 

000000000000cb50 <fwp_gc_find_data>:
    cb50:	0f b7 77 18          	movzwl 0x18(%rdi),%esi
    cb54:	48 85 f6             	test   %rsi,%rsi
    cb57:	0f 84 be 00 00 00    	je     cc1b <fwp_gc_find_data+0xcb>
    cb5d:	53                   	push   %rbx
    cb5e:	48 8b 07             	mov    (%rdi),%rax
    cb61:	4c 8b 47 10          	mov    0x10(%rdi),%r8
    cb65:	48 6b ce 38          	imul   $0x38,%rsi,%rcx
    cb69:	45 31 c9             	xor    %r9d,%r9d
    cb6c:	48 8d 15 25 77 00 00 	lea    0x7725(%rip),%rdx        # 14298 <fwp_gc>
    cb73:	41 bb 01 00 00 00    	mov    $0x1,%r11d
    cb79:	45 31 d2             	xor    %r10d,%r10d
    cb7c:	eb 0b                	jmp    cb89 <fwp_gc_find_data+0x39>
    cb7e:	66 90                	xchg   %ax,%ax
    cb80:	49 83 c1 38          	add    $0x38,%r9
    cb84:	4c 39 c9             	cmp    %r9,%rcx
    cb87:	74 22                	je     cbab <fwp_gc_find_data+0x5b>
    cb89:	43 83 3c 08 01       	cmpl   $0x1,(%r8,%r9,1)
    cb8e:	75 f0                	jne    cb80 <fwp_gc_find_data+0x30>
    cb90:	4b 8b 5c 08 10       	mov    0x10(%r8,%r9,1),%rbx
    cb95:	48 01 c3             	add    %rax,%rbx
    cb98:	48 39 d3             	cmp    %rdx,%rbx
    cb9b:	77 e3                	ja     cb80 <fwp_gc_find_data+0x30>
    cb9d:	4b 03 5c 08 28       	add    0x28(%r8,%r9,1),%rbx
    cba2:	48 39 d3             	cmp    %rdx,%rbx
    cba5:	45 0f 47 d3          	cmova  %r11d,%r10d
    cba9:	eb d5                	jmp    cb80 <fwp_gc_find_data+0x30>
    cbab:	31 c0                	xor    %eax,%eax
    cbad:	45 85 d2             	test   %r10d,%r10d
    cbb0:	0f 95 c0             	setne  %al
    cbb3:	74 6e                	je     cc23 <fwp_gc_find_data+0xd3>
    cbb5:	66 85 f6             	test   %si,%si
    cbb8:	74 69                	je     cc23 <fwp_gc_find_data+0xd3>
    cbba:	8b 05 68 88 00 00    	mov    0x8868(%rip),%eax        # 15428 <fwp_gc+0x1190>
    cbc0:	48 8b 77 10          	mov    0x10(%rdi),%rsi
    cbc4:	45 31 c0             	xor    %r8d,%r8d
    cbc7:	eb 10                	jmp    cbd9 <fwp_gc_find_data+0x89>
    cbc9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    cbd0:	49 83 c0 38          	add    $0x38,%r8
    cbd4:	4c 39 c1             	cmp    %r8,%rcx
    cbd7:	74 45                	je     cc1e <fwp_gc_find_data+0xce>
    cbd9:	42 83 3c 06 01       	cmpl   $0x1,(%rsi,%r8,1)
    cbde:	75 f0                	jne    cbd0 <fwp_gc_find_data+0x80>
    cbe0:	42 f6 44 06 04 02    	testb  $0x2,0x4(%rsi,%r8,1)
    cbe6:	74 e8                	je     cbd0 <fwp_gc_find_data+0x80>
    cbe8:	83 f8 10             	cmp    $0x10,%eax
    cbeb:	74 31                	je     cc1e <fwp_gc_find_data+0xce>
    cbed:	4e 8b 4c 06 10       	mov    0x10(%rsi,%r8,1),%r9
    cbf2:	4c 03 0f             	add    (%rdi),%r9
    cbf5:	4c 63 d0             	movslq %eax,%r10
    cbf8:	49 c1 e2 04          	shl    $0x4,%r10
    cbfc:	4d 89 8c 12 90 10 00 	mov    %r9,0x1090(%r10,%rdx,1)
    cc03:	00 
    cc04:	4e 8b 4c 06 28       	mov    0x28(%rsi,%r8,1),%r9
    cc09:	4d 89 8c 12 98 10 00 	mov    %r9,0x1098(%r10,%rdx,1)
    cc10:	00 
    cc11:	ff c0                	inc    %eax
    cc13:	89 05 0f 88 00 00    	mov    %eax,0x880f(%rip)        # 15428 <fwp_gc+0x1190>
    cc19:	eb b5                	jmp    cbd0 <fwp_gc_find_data+0x80>
    cc1b:	31 c0                	xor    %eax,%eax
    cc1d:	c3                   	ret
    cc1e:	b8 01 00 00 00       	mov    $0x1,%eax
    cc23:	5b                   	pop    %rbx
    cc24:	c3                   	ret
    cc25:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    cc2c:	00 00 00 00 

000000000000cc30 <fwp_gc_report>:
    cc30:	41 57                	push   %r15
    cc32:	41 56                	push   %r14
    cc34:	53                   	push   %rbx
    cc35:	48 83 ec 50          	sub    $0x50,%rsp
    cc39:	48 8b 05 68 88 00 00 	mov    0x8868(%rip),%rax        # 154a8 <fwp_gc+0x1210>
    cc40:	48 8b 0d 51 76 00 00 	mov    0x7651(%rip),%rcx        # 14298 <fwp_gc>
    cc47:	48 29 c8             	sub    %rcx,%rax
    cc4a:	f2 48 0f 2a c8       	cvtsi2sd %rax,%xmm1
    cc4f:	f2 0f 58 0d 29 88 00 	addsd  0x8829(%rip),%xmm1        # 15480 <fwp_gc+0x11e8>
    cc56:	00 
    cc57:	f2 0f 11 0d 21 88 00 	movsd  %xmm1,0x8821(%rip)        # 15480 <fwp_gc+0x11e8>
    cc5e:	00 
    cc5f:	48 89 0d 42 88 00 00 	mov    %rcx,0x8842(%rip)        # 154a8 <fwp_gc+0x1210>
    cc66:	48 8b 05 73 73 00 00 	mov    0x7373(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    cc6d:	4c 8b 38             	mov    (%rax),%r15
    cc70:	48 8b 1d f9 87 00 00 	mov    0x87f9(%rip),%rbx        # 15470 <fwp_gc+0x11d8>
    cc77:	4c 8b 35 32 86 00 00 	mov    0x8632(%rip),%r14        # 152b0 <fwp_gc+0x1018>
    cc7e:	f2 0f 10 15 1a 88 00 	movsd  0x881a(%rip),%xmm2        # 154a0 <fwp_gc+0x1208>
    cc85:	00 
    cc86:	f2 0f 58 ca          	addsd  %xmm2,%xmm1
    cc8a:	f2 0f 10 05 e6 14 00 	movsd  0x14e6(%rip),%xmm0        # e178 <_IO_stdin_used+0x178>
    cc91:	00 
    cc92:	f2 0f 59 c8          	mulsd  %xmm0,%xmm1
    cc96:	f2 0f 11 4c 24 18    	movsd  %xmm1,0x18(%rsp)
    cc9c:	f2 0f 59 d0          	mulsd  %xmm0,%xmm2
    cca0:	f2 0f 11 54 24 10    	movsd  %xmm2,0x10(%rsp)
    cca6:	f2 0f 10 0d 32 86 00 	movsd  0x8632(%rip),%xmm1        # 152e0 <fwp_gc+0x1048>
    ccad:	00 
    ccae:	66 0f 28 15 6a 14 00 	movapd 0x146a(%rip),%xmm2        # e120 <_IO_stdin_used+0x120>
    ccb5:	00 
    ccb6:	0f 14 ca             	unpcklps %xmm2,%xmm1
    ccb9:	66 0f 28 1d 6f 14 00 	movapd 0x146f(%rip),%xmm3        # e130 <_IO_stdin_used+0x130>
    ccc0:	00 
    ccc1:	66 0f 5c cb          	subpd  %xmm3,%xmm1
    ccc5:	66 0f 28 e1          	movapd %xmm1,%xmm4
    ccc9:	66 0f 15 e1          	unpckhpd %xmm1,%xmm4
    cccd:	f2 0f 58 e1          	addsd  %xmm1,%xmm4
    ccd1:	f2 0f 59 e0          	mulsd  %xmm0,%xmm4
    ccd5:	66 0f 29 64 24 40    	movapd %xmm4,0x40(%rsp)
    ccdb:	f2 0f 10 0d 7d 87 00 	movsd  0x877d(%rip),%xmm1        # 15460 <fwp_gc+0x11c8>
    cce2:	00 
    cce3:	0f 14 ca             	unpcklps %xmm2,%xmm1
    cce6:	66 0f 5c cb          	subpd  %xmm3,%xmm1
    ccea:	66 0f 28 e1          	movapd %xmm1,%xmm4
    ccee:	66 0f 15 e1          	unpckhpd %xmm1,%xmm4
    ccf2:	f2 0f 58 e1          	addsd  %xmm1,%xmm4
    ccf6:	f2 0f 59 e0          	mulsd  %xmm0,%xmm4
    ccfa:	66 0f 29 64 24 30    	movapd %xmm4,0x30(%rsp)
    cd00:	f2 0f 10 0d 60 87 00 	movsd  0x8760(%rip),%xmm1        # 15468 <fwp_gc+0x11d0>
    cd07:	00 
    cd08:	0f 14 ca             	unpcklps %xmm2,%xmm1
    cd0b:	66 0f 5c cb          	subpd  %xmm3,%xmm1
    cd0f:	66 0f 28 d1          	movapd %xmm1,%xmm2
    cd13:	66 0f 15 d1          	unpckhpd %xmm1,%xmm2
    cd17:	f2 0f 58 d1          	addsd  %xmm1,%xmm2
    cd1b:	f2 0f 59 d0          	mulsd  %xmm0,%xmm2
    cd1f:	66 0f 29 54 24 20    	movapd %xmm2,0x20(%rsp)
    cd25:	f2 0f 10 05 5b 87 00 	movsd  0x875b(%rip),%xmm0        # 15488 <fwp_gc+0x11f0>
    cd2c:	00 
    cd2d:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    cd33:	f2 0f 10 05 55 87 00 	movsd  0x8755(%rip),%xmm0        # 15490 <fwp_gc+0x11f8>
    cd3a:	00 
    cd3b:	f2 0f 11 04 24       	movsd  %xmm0,(%rsp)
    cd40:	e8 6b 00 00 00       	call   cdb0 <fwp_gc_status_kb>
    cd45:	83 3d 40 85 00 00 00 	cmpl   $0x0,0x8540(%rip)        # 1528c <fwp_gc+0xff4>
    cd4c:	48 8d 0d 05 28 00 00 	lea    0x2805(%rip),%rcx        # f558 <exec_in_fp0+0xf08>
    cd53:	4c 8d 0d 46 20 00 00 	lea    0x2046(%rip),%r9        # eda0 <exec_in_fp0+0x750>
    cd5a:	4c 0f 44 c9          	cmove  %rcx,%r9
    cd5e:	48 8d 35 3e 27 00 00 	lea    0x273e(%rip),%rsi        # f4a3 <exec_in_fp0+0xe53>
    cd65:	4c 89 ff             	mov    %r15,%rdi
    cd68:	48 89 da             	mov    %rbx,%rdx
    cd6b:	4c 89 f1             	mov    %r14,%rcx
    cd6e:	f2 0f 10 44 24 18    	movsd  0x18(%rsp),%xmm0
    cd74:	f2 0f 10 4c 24 10    	movsd  0x10(%rsp),%xmm1
    cd7a:	0f 28 54 24 40       	movaps 0x40(%rsp),%xmm2
    cd7f:	0f 28 5c 24 30       	movaps 0x30(%rsp),%xmm3
    cd84:	0f 28 64 24 20       	movaps 0x20(%rsp),%xmm4
    cd89:	f2 0f 10 6c 24 08    	movsd  0x8(%rsp),%xmm5
    cd8f:	f2 0f 10 34 24       	movsd  (%rsp),%xmm6
    cd94:	49 89 c0             	mov    %rax,%r8
    cd97:	b0 07                	mov    $0x7,%al
    cd99:	48 83 c4 50          	add    $0x50,%rsp
    cd9d:	5b                   	pop    %rbx
    cd9e:	41 5e                	pop    %r14
    cda0:	41 5f                	pop    %r15
    cda2:	e9 49 55 ff ff       	jmp    22f0 <fprintf@plt>
    cda7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    cdae:	00 00 

000000000000cdb0 <fwp_gc_status_kb>:
    cdb0:	55                   	push   %rbp
    cdb1:	41 57                	push   %r15
    cdb3:	41 56                	push   %r14
    cdb5:	41 54                	push   %r12
    cdb7:	53                   	push   %rbx
    cdb8:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
    cdbf:	48 8d 3d a4 27 00 00 	lea    0x27a4(%rip),%rdi        # f56a <exec_in_fp0+0xf1a>
    cdc6:	48 8d 35 bd 25 00 00 	lea    0x25bd(%rip),%rsi        # f38a <exec_in_fp0+0xd3a>
    cdcd:	e8 4e 56 ff ff       	call   2420 <fopen@plt>
    cdd2:	48 85 c0             	test   %rax,%rax
    cdd5:	74 7d                	je     ce54 <fwp_gc_status_kb+0xa4>
    cdd7:	48 89 c3             	mov    %rax,%rbx
    cdda:	48 89 e7             	mov    %rsp,%rdi
    cddd:	be 00 01 00 00       	mov    $0x100,%esi
    cde2:	48 89 c2             	mov    %rax,%rdx
    cde5:	e8 a6 54 ff ff       	call   2290 <fgets@plt>
    cdea:	49 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%r14
    cdf1:	48 85 c0             	test   %rax,%rax
    cdf4:	74 54                	je     ce4a <fwp_gc_status_kb+0x9a>
    cdf6:	4c 8d 7c 24 06       	lea    0x6(%rsp),%r15
    cdfb:	bd 56 6d 48 57       	mov    $0x57486d56,%ebp
    ce00:	49 89 e4             	mov    %rsp,%r12
    ce03:	eb 20                	jmp    ce25 <fwp_gc_status_kb+0x75>
    ce05:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    ce0c:	00 00 00 00 
    ce10:	4c 89 e7             	mov    %r12,%rdi
    ce13:	be 00 01 00 00       	mov    $0x100,%esi
    ce18:	48 89 da             	mov    %rbx,%rdx
    ce1b:	e8 70 54 ff ff       	call   2290 <fgets@plt>
    ce20:	48 85 c0             	test   %rax,%rax
    ce23:	74 25                	je     ce4a <fwp_gc_status_kb+0x9a>
    ce25:	8b 04 24             	mov    (%rsp),%eax
    ce28:	31 e8                	xor    %ebp,%eax
    ce2a:	0f b6 4c 24 04       	movzbl 0x4(%rsp),%ecx
    ce2f:	83 f1 4d             	xor    $0x4d,%ecx
    ce32:	09 c1                	or     %eax,%ecx
    ce34:	75 da                	jne    ce10 <fwp_gc_status_kb+0x60>
    ce36:	80 7c 24 05 3a       	cmpb   $0x3a,0x5(%rsp)
    ce3b:	75 d3                	jne    ce10 <fwp_gc_status_kb+0x60>
    ce3d:	4c 89 ff             	mov    %r15,%rdi
    ce40:	e8 bb 55 ff ff       	call   2400 <atol@plt>
    ce45:	49 89 c6             	mov    %rax,%r14
    ce48:	eb c6                	jmp    ce10 <fwp_gc_status_kb+0x60>
    ce4a:	48 89 df             	mov    %rbx,%rdi
    ce4d:	e8 fe 52 ff ff       	call   2150 <fclose@plt>
    ce52:	eb 07                	jmp    ce5b <fwp_gc_status_kb+0xab>
    ce54:	49 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%r14
    ce5b:	4c 89 f0             	mov    %r14,%rax
    ce5e:	48 81 c4 00 01 00 00 	add    $0x100,%rsp
    ce65:	5b                   	pop    %rbx
    ce66:	41 5c                	pop    %r12
    ce68:	41 5e                	pop    %r14
    ce6a:	41 5f                	pop    %r15
    ce6c:	5d                   	pop    %rbp
    ce6d:	c3                   	ret
    ce6e:	66 90                	xchg   %ax,%ax

000000000000ce70 <w1>:
    ce70:	50                   	push   %rax
    ce71:	e8 0a cc ff ff       	call   9a80 <fwp_from_f32>
    ce76:	48 89 c7             	mov    %rax,%rdi
    ce79:	e8 b2 d2 ff ff       	call   a130 <fwp_f32>
    ce7e:	0f 28 d0             	movaps %xmm0,%xmm2
    ce81:	0f c6 d0 00          	shufps $0x0,%xmm0,%xmm2
    ce85:	0f 28 c8             	movaps %xmm0,%xmm1
    ce88:	0f 28 c2             	movaps %xmm2,%xmm0
    ce8b:	58                   	pop    %rax
    ce8c:	c3                   	ret
    ce8d:	0f 1f 00             	nopl   (%rax)

000000000000ce90 <fwp_rc_drop_slot>:
    ce90:	0f b6 07             	movzbl (%rdi),%eax
    ce93:	3c ff                	cmp    $0xff,%al
    ce95:	74 09                	je     cea0 <fwp_rc_wide_drop>
    ce97:	3c 02                	cmp    $0x2,%al
    ce99:	72 04                	jb     ce9f <fwp_rc_drop_slot+0xf>
    ce9b:	fe c8                	dec    %al
    ce9d:	88 07                	mov    %al,(%rdi)
    ce9f:	c3                   	ret

000000000000cea0 <fwp_rc_wide_drop>:
    cea0:	53                   	push   %rbx
    cea1:	48 89 fb             	mov    %rdi,%rbx
    cea4:	e8 27 61 ff ff       	call   2fd0 <fwp_rc_wide_link>
    cea9:	48 8b 00             	mov    (%rax),%rax
    ceac:	48 85 c0             	test   %rax,%rax
    ceaf:	74 21                	je     ced2 <fwp_rc_wide_drop+0x32>
    ceb1:	48 8b 48 08          	mov    0x8(%rax),%rcx
    ceb5:	48 ff c9             	dec    %rcx
    ceb8:	48 89 48 08          	mov    %rcx,0x8(%rax)
    cebc:	48 81 f9 fe 00 00 00 	cmp    $0xfe,%rcx
    cec3:	75 0b                	jne    ced0 <fwp_rc_wide_drop+0x30>
    cec5:	48 89 df             	mov    %rbx,%rdi
    cec8:	e8 c3 60 ff ff       	call   2f90 <fwp_rc_forget_slot>
    cecd:	c6 03 fe             	movb   $0xfe,(%rbx)
    ced0:	5b                   	pop    %rbx
    ced1:	c3                   	ret
    ced2:	48 8d 3d 2b 18 00 00 	lea    0x182b(%rip),%rdi        # e704 <exec_in_fp0+0xb4>
    ced9:	e8 52 61 ff ff       	call   3030 <fwp_trap>
    cede:	66 90                	xchg   %ax,%ax

000000000000cee0 <fwp_rc_poison>:
    cee0:	53                   	push   %rbx
    cee1:	48 89 f9             	mov    %rdi,%rcx
    cee4:	48 2b 0d dd 83 00 00 	sub    0x83dd(%rip),%rcx        # 152c8 <fwp_gc+0x1030>
    ceeb:	48 8b 05 1e 84 00 00 	mov    0x841e(%rip),%rax        # 15310 <fwp_gc+0x1078>
    cef2:	48 c1 e9 10          	shr    $0x10,%rcx
    cef6:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    cefd:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    cf02:	75 0d                	jne    cf11 <fwp_rc_poison+0x31>
    cf04:	80 3c 08 02          	cmpb   $0x2,(%rax,%rcx,1)
    cf08:	75 1e                	jne    cf28 <fwp_rc_poison+0x48>
    cf0a:	48 8b 54 08 18       	mov    0x18(%rax,%rcx,1),%rdx
    cf0f:	eb 1b                	jmp    cf2c <fwp_rc_poison+0x4c>
    cf11:	c7 07 ad de 00 00    	movl   $0xdead,(%rdi)
    cf17:	8b 47 04             	mov    0x4(%rdi),%eax
    cf1a:	48 85 c0             	test   %rax,%rax
    cf1d:	74 7e                	je     cf9d <fwp_rc_poison+0xbd>
    cf1f:	83 f8 04             	cmp    $0x4,%eax
    cf22:	73 22                	jae    cf46 <fwp_rc_poison+0x66>
    cf24:	31 c9                	xor    %ecx,%ecx
    cf26:	eb 50                	jmp    cf78 <fwp_rc_poison+0x98>
    cf28:	8b 54 08 08          	mov    0x8(%rax,%rcx,1),%edx
    cf2c:	48 89 fb             	mov    %rdi,%rbx
    cf2f:	be dd 00 00 00       	mov    $0xdd,%esi
    cf34:	e8 d7 52 ff ff       	call   2210 <memset@plt>
    cf39:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    cf40:	c6 43 08 00          	movb   $0x0,0x8(%rbx)
    cf44:	5b                   	pop    %rbx
    cf45:	c3                   	ret
    cf46:	89 c1                	mov    %eax,%ecx
    cf48:	83 e1 fc             	and    $0xfffffffc,%ecx
    cf4b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    cf52:	00 
    cf53:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    cf57:	31 f6                	xor    %esi,%esi
    cf59:	0f 28 05 e0 11 00 00 	movaps 0x11e0(%rip),%xmm0        # e140 <_IO_stdin_used+0x140>
    cf60:	0f 11 44 37 08       	movups %xmm0,0x8(%rdi,%rsi,1)
    cf65:	0f 11 44 37 18       	movups %xmm0,0x18(%rdi,%rsi,1)
    cf6a:	48 83 c6 20          	add    $0x20,%rsi
    cf6e:	48 39 f2             	cmp    %rsi,%rdx
    cf71:	75 ed                	jne    cf60 <fwp_rc_poison+0x80>
    cf73:	48 39 c1             	cmp    %rax,%rcx
    cf76:	74 25                	je     cf9d <fwp_rc_poison+0xbd>
    cf78:	48 ba ef be ad de ef 	movabs $0xdeadbeefdeadbeef,%rdx
    cf7f:	be ad de 
    cf82:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    cf89:	1f 84 00 00 00 00 00 
    cf90:	48 89 54 cf 08       	mov    %rdx,0x8(%rdi,%rcx,8)
    cf95:	48 ff c1             	inc    %rcx
    cf98:	48 39 c8             	cmp    %rcx,%rax
    cf9b:	75 f3                	jne    cf90 <fwp_rc_poison+0xb0>
    cf9d:	5b                   	pop    %rbx
    cf9e:	c3                   	ret
    cf9f:	90                   	nop

000000000000cfa0 <__divti3>:
    cfa0:	f3 0f 1e fa          	endbr64
    cfa4:	55                   	push   %rbp
    cfa5:	49 89 f8             	mov    %rdi,%r8
    cfa8:	49 89 d2             	mov    %rdx,%r10
    cfab:	49 89 cb             	mov    %rcx,%r11
    cfae:	31 ff                	xor    %edi,%edi
    cfb0:	48 89 e5             	mov    %rsp,%rbp
    cfb3:	41 56                	push   %r14
    cfb5:	53                   	push   %rbx
    cfb6:	48 85 f6             	test   %rsi,%rsi
    cfb9:	79 13                	jns    cfce <__divti3+0x2e>
    cfbb:	45 31 c9             	xor    %r9d,%r9d
    cfbe:	49 f7 d8             	neg    %r8
    cfc1:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
    cfc8:	49 19 f1             	sbb    %rsi,%r9
    cfcb:	4c 89 ce             	mov    %r9,%rsi
    cfce:	4c 89 da             	mov    %r11,%rdx
    cfd1:	4d 85 db             	test   %r11,%r11
    cfd4:	0f 88 f6 00 00 00    	js     d0d0 <__divti3+0x130>
    cfda:	4d 89 d6             	mov    %r10,%r14
    cfdd:	75 31                	jne    d010 <__divti3+0x70>
    cfdf:	4c 39 f6             	cmp    %r14,%rsi
    cfe2:	0f 83 b8 00 00 00    	jae    d0a0 <__divti3+0x100>
    cfe8:	48 89 f2             	mov    %rsi,%rdx
    cfeb:	31 f6                	xor    %esi,%esi
    cfed:	4c 89 c0             	mov    %r8,%rax
    cff0:	49 f7 f6             	div    %r14
    cff3:	48 89 f2             	mov    %rsi,%rdx
    cff6:	48 85 ff             	test   %rdi,%rdi
    cff9:	74 0a                	je     d005 <__divti3+0x65>
    cffb:	48 f7 d8             	neg    %rax
    cffe:	48 83 d2 00          	adc    $0x0,%rdx
    d002:	48 f7 da             	neg    %rdx
    d005:	5b                   	pop    %rbx
    d006:	41 5e                	pop    %r14
    d008:	5d                   	pop    %rbp
    d009:	c3                   	ret
    d00a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    d010:	4c 39 de             	cmp    %r11,%rsi
    d013:	0f 82 d5 00 00 00    	jb     d0ee <__divti3+0x14e>
    d019:	4d 0f bd d3          	bsr    %r11,%r10
    d01d:	41 83 f2 3f          	xor    $0x3f,%r10d
    d021:	44 89 d1             	mov    %r10d,%ecx
    d024:	b8 40 00 00 00       	mov    $0x40,%eax
    d029:	4c 89 f3             	mov    %r14,%rbx
    d02c:	4d 89 f1             	mov    %r14,%r9
    d02f:	48 d3 e2             	shl    %cl,%rdx
    d032:	49 63 ca             	movslq %r10d,%rcx
    d035:	49 89 f3             	mov    %rsi,%r11
    d038:	48 29 c8             	sub    %rcx,%rax
    d03b:	89 c1                	mov    %eax,%ecx
    d03d:	48 d3 eb             	shr    %cl,%rbx
    d040:	44 89 d1             	mov    %r10d,%ecx
    d043:	49 d3 e1             	shl    %cl,%r9
    d046:	89 c1                	mov    %eax,%ecx
    d048:	48 09 d3             	or     %rdx,%rbx
    d04b:	4c 89 c2             	mov    %r8,%rdx
    d04e:	49 d3 eb             	shr    %cl,%r11
    d051:	44 89 d1             	mov    %r10d,%ecx
    d054:	48 d3 e6             	shl    %cl,%rsi
    d057:	89 c1                	mov    %eax,%ecx
    d059:	48 d3 ea             	shr    %cl,%rdx
    d05c:	48 89 d0             	mov    %rdx,%rax
    d05f:	4c 89 da             	mov    %r11,%rdx
    d062:	48 09 f0             	or     %rsi,%rax
    d065:	48 f7 f3             	div    %rbx
    d068:	49 89 d3             	mov    %rdx,%r11
    d06b:	48 89 c6             	mov    %rax,%rsi
    d06e:	49 f7 e1             	mul    %r9
    d071:	49 39 d3             	cmp    %rdx,%r11
    d074:	0f 82 be 00 00 00    	jb     d138 <__divti3+0x198>
    d07a:	44 89 d1             	mov    %r10d,%ecx
    d07d:	49 d3 e0             	shl    %cl,%r8
    d080:	49 39 c0             	cmp    %rax,%r8
    d083:	73 09                	jae    d08e <__divti3+0xee>
    d085:	49 39 d3             	cmp    %rdx,%r11
    d088:	0f 84 aa 00 00 00    	je     d138 <__divti3+0x198>
    d08e:	48 89 f0             	mov    %rsi,%rax
    d091:	31 f6                	xor    %esi,%esi
    d093:	e9 5b ff ff ff       	jmp    cff3 <__divti3+0x53>
    d098:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    d09f:	00 
    d0a0:	4d 85 f6             	test   %r14,%r14
    d0a3:	75 0d                	jne    d0b2 <__divti3+0x112>
    d0a5:	b8 01 00 00 00       	mov    $0x1,%eax
    d0aa:	31 d2                	xor    %edx,%edx
    d0ac:	49 f7 f6             	div    %r14
    d0af:	49 89 c6             	mov    %rax,%r14
    d0b2:	48 89 f0             	mov    %rsi,%rax
    d0b5:	31 d2                	xor    %edx,%edx
    d0b7:	49 f7 f6             	div    %r14
    d0ba:	48 89 c6             	mov    %rax,%rsi
    d0bd:	4c 89 c0             	mov    %r8,%rax
    d0c0:	49 f7 f6             	div    %r14
    d0c3:	e9 2b ff ff ff       	jmp    cff3 <__divti3+0x53>
    d0c8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    d0cf:	00 
    d0d0:	49 f7 da             	neg    %r10
    d0d3:	48 f7 d7             	not    %rdi
    d0d6:	49 83 d3 00          	adc    $0x0,%r11
    d0da:	4d 89 d6             	mov    %r10,%r14
    d0dd:	49 f7 db             	neg    %r11
    d0e0:	4c 89 da             	mov    %r11,%rdx
    d0e3:	0f 84 f6 fe ff ff    	je     cfdf <__divti3+0x3f>
    d0e9:	4c 39 de             	cmp    %r11,%rsi
    d0ec:	73 12                	jae    d100 <__divti3+0x160>
    d0ee:	31 f6                	xor    %esi,%esi
    d0f0:	31 c0                	xor    %eax,%eax
    d0f2:	e9 fc fe ff ff       	jmp    cff3 <__divti3+0x53>
    d0f7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    d0fe:	00 00 
    d100:	49 0f bd c3          	bsr    %r11,%rax
    d104:	48 83 f0 3f          	xor    $0x3f,%rax
    d108:	41 89 c2             	mov    %eax,%r10d
    d10b:	85 c0                	test   %eax,%eax
    d10d:	0f 85 0e ff ff ff    	jne    d021 <__divti3+0x81>
    d113:	49 39 f3             	cmp    %rsi,%r11
    d116:	72 0d                	jb     d125 <__divti3+0x185>
    d118:	31 f6                	xor    %esi,%esi
    d11a:	31 c0                	xor    %eax,%eax
    d11c:	4d 39 f0             	cmp    %r14,%r8
    d11f:	0f 82 ce fe ff ff    	jb     cff3 <__divti3+0x53>
    d125:	31 f6                	xor    %esi,%esi
    d127:	b8 01 00 00 00       	mov    $0x1,%eax
    d12c:	e9 c2 fe ff ff       	jmp    cff3 <__divti3+0x53>
    d131:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    d138:	48 8d 46 ff          	lea    -0x1(%rsi),%rax
    d13c:	31 f6                	xor    %esi,%esi
    d13e:	e9 b0 fe ff ff       	jmp    cff3 <__divti3+0x53>
    d143:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    d14a:	00 00 00 
    d14d:	0f 1f 00             	nopl   (%rax)

000000000000d150 <atexit>:
    d150:	f3 0f 1e fa          	endbr64
    d154:	48 8b 15 2d 71 00 00 	mov    0x712d(%rip),%rdx        # 14288 <__dso_handle>
    d15b:	31 f6                	xor    %esi,%esi
    d15d:	e9 ee 52 ff ff       	jmp    2450 <__cxa_atexit@plt>

Disassembly of section .fini:

000000000000d164 <_fini>:
    d164:	f3 0f 1e fa          	endbr64
    d168:	48 83 ec 08          	sub    $0x8,%rsp
    d16c:	48 83 c4 08          	add    $0x8,%rsp
    d170:	c3                   	ret
