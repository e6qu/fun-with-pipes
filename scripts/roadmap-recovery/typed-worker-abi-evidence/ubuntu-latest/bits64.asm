
/home/runner/work/_temp/numeric-layout-baseline/bits64-diagnostic:     file format elf64-x86-64


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
    27a3:	e8 a8 34 00 00       	call   5c50 <fwp_stack_guard_init>
    27a8:	48 8b 05 b1 14 01 00 	mov    0x114b1(%rip),%rax        # 13c60 <exec_scripts+0x10>
    27af:	48 89 05 3a 36 01 00 	mov    %rax,0x1363a(%rip)        # 15df0 <fwp_cli_scripts+0x10>
    27b6:	0f 28 05 93 14 01 00 	movaps 0x11493(%rip),%xmm0        # 13c50 <exec_scripts>
    27bd:	0f 29 05 1c 36 01 00 	movaps %xmm0,0x1361c(%rip)        # 15de0 <fwp_cli_scripts>
    27c4:	48 8d 05 d5 bc 00 00 	lea    0xbcd5(%rip),%rax        # e4a0 <exec_man>
    27cb:	48 89 05 26 36 01 00 	mov    %rax,0x13626(%rip)        # 15df8 <fwp_cli_man>
    27d2:	c6 05 27 36 01 00 01 	movb   $0x1,0x13627(%rip)        # 15e00 <fwp_cli_single>
    27d9:	8b 3d d1 35 01 00    	mov    0x135d1(%rip),%edi        # 15db0 <fwp_argc>
    27df:	48 8b 35 d2 35 01 00 	mov    0x135d2(%rip),%rsi        # 15db8 <fwp_argv>
    27e6:	e8 45 35 00 00       	call   5d30 <fwp_exec>
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
    282f:	e8 fc 01 00 00       	call   2a30 <f0>
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
    2860:	0f 84 fe 00 00 00    	je     2964 <main+0x154>
    2866:	49 be 00 00 00 00 00 	movabs $0x8000000000000000,%r14
    286d:	00 00 80 
    2870:	48 89 df             	mov    %rbx,%rdi
    2873:	e8 58 02 00 00       	call   2ad0 <fwp_rc_free_obj>
    2878:	4c 89 f7             	mov    %r14,%rdi
    287b:	e8 b0 01 00 00       	call   2a30 <f0>
    2880:	4c 39 70 08          	cmp    %r14,0x8(%rax)
    2884:	0f 85 e4 00 00 00    	jne    296e <main+0x15e>
    288a:	48 89 c3             	mov    %rax,%rbx
    288d:	4c 39 70 10          	cmp    %r14,0x10(%rax)
    2891:	b8 82 00 00 00       	mov    $0x82,%eax
    2896:	75 b9                	jne    2851 <main+0x41>
    2898:	4c 39 73 18          	cmp    %r14,0x18(%rbx)
    289c:	75 b3                	jne    2851 <main+0x41>
    289e:	48 89 df             	mov    %rbx,%rdi
    28a1:	e8 fa 01 00 00       	call   2aa0 <fwp_rc_release_last>
    28a6:	85 c0                	test   %eax,%eax
    28a8:	0f 84 b6 00 00 00    	je     2964 <main+0x154>
    28ae:	49 be 34 12 00 00 00 	movabs $0x7ff8000000001234,%r14
    28b5:	00 f8 7f 
    28b8:	48 89 df             	mov    %rbx,%rdi
    28bb:	e8 10 02 00 00       	call   2ad0 <fwp_rc_free_obj>
    28c0:	4c 89 f7             	mov    %r14,%rdi
    28c3:	e8 68 01 00 00       	call   2a30 <f0>
    28c8:	4c 39 70 08          	cmp    %r14,0x8(%rax)
    28cc:	0f 85 9c 00 00 00    	jne    296e <main+0x15e>
    28d2:	48 89 c3             	mov    %rax,%rbx
    28d5:	4c 39 70 10          	cmp    %r14,0x10(%rax)
    28d9:	b8 82 00 00 00       	mov    $0x82,%eax
    28de:	0f 85 6d ff ff ff    	jne    2851 <main+0x41>
    28e4:	4c 39 73 18          	cmp    %r14,0x18(%rbx)
    28e8:	0f 85 63 ff ff ff    	jne    2851 <main+0x41>
    28ee:	48 89 df             	mov    %rbx,%rdi
    28f1:	e8 aa 01 00 00       	call   2aa0 <fwp_rc_release_last>
    28f6:	85 c0                	test   %eax,%eax
    28f8:	74 6a                	je     2964 <main+0x154>
    28fa:	49 be 34 12 00 00 00 	movabs $0x7ff0000000001234,%r14
    2901:	00 f0 7f 
    2904:	48 89 df             	mov    %rbx,%rdi
    2907:	e8 c4 01 00 00       	call   2ad0 <fwp_rc_free_obj>
    290c:	4c 89 f7             	mov    %r14,%rdi
    290f:	e8 1c 01 00 00       	call   2a30 <f0>
    2914:	4c 39 70 08          	cmp    %r14,0x8(%rax)
    2918:	75 54                	jne    296e <main+0x15e>
    291a:	4c 39 70 10          	cmp    %r14,0x10(%rax)
    291e:	75 4e                	jne    296e <main+0x15e>
    2920:	48 89 c3             	mov    %rax,%rbx
    2923:	4c 39 70 18          	cmp    %r14,0x18(%rax)
    2927:	b8 82 00 00 00       	mov    $0x82,%eax
    292c:	0f 85 1f ff ff ff    	jne    2851 <main+0x41>
    2932:	48 89 df             	mov    %rbx,%rdi
    2935:	e8 66 01 00 00       	call   2aa0 <fwp_rc_release_last>
    293a:	89 c1                	mov    %eax,%ecx
    293c:	b8 83 00 00 00       	mov    $0x83,%eax
    2941:	85 c9                	test   %ecx,%ecx
    2943:	0f 84 08 ff ff ff    	je     2851 <main+0x41>
    2949:	48 89 df             	mov    %rbx,%rdi
    294c:	e8 7f 01 00 00       	call   2ad0 <fwp_rc_free_obj>
    2951:	48 8d 3d 08 bd 00 00 	lea    0xbd08(%rip),%rdi        # e660 <exec_in_fp0+0x10>
    2958:	e8 73 f7 ff ff       	call   20d0 <puts@plt>
    295d:	31 c0                	xor    %eax,%eax
    295f:	e9 ed fe ff ff       	jmp    2851 <main+0x41>
    2964:	b8 83 00 00 00       	mov    $0x83,%eax
    2969:	e9 e3 fe ff ff       	jmp    2851 <main+0x41>
    296e:	b8 82 00 00 00       	mov    $0x82,%eax
    2973:	e9 d9 fe ff ff       	jmp    2851 <main+0x41>
    2978:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    297f:	00 

0000000000002980 <fwp_gc_start>:
    2980:	53                   	push   %rbx
    2981:	48 89 fb             	mov    %rdi,%rbx
    2984:	83 3d f9 28 01 00 00 	cmpl   $0x0,0x128f9(%rip)        # 15284 <fwp_gc+0xfec>
    298b:	75 05                	jne    2992 <fwp_gc_start+0x12>
    298d:	e8 ee 0a 00 00       	call   3480 <fwp_gc_init>
    2992:	48 89 1d 87 29 01 00 	mov    %rbx,0x12987(%rip)        # 15320 <fwp_gc+0x1088>
    2999:	48 8d 3d 90 a1 00 00 	lea    0xa190(%rip),%rdi        # cb30 <fwp_gc_find_data>
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
    29cf:	48 8d 3d 3a a2 00 00 	lea    0xa23a(%rip),%rdi        # cc10 <fwp_gc_report>
    29d6:	e8 65 a7 00 00       	call   d140 <atexit>
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

0000000000002a30 <f0>:
    2a30:	53                   	push   %rbx
    2a31:	48 83 ec 30          	sub    $0x30,%rsp
    2a35:	e8 76 31 00 00       	call   5bb0 <fwp_f64>
    2a3a:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    2a3f:	e8 0c a4 00 00       	call   ce50 <w0>
    2a44:	f2 0f 10 44 24 18    	movsd  0x18(%rsp),%xmm0
    2a4a:	e8 71 31 00 00       	call   5bc0 <fwp_from_f64>
    2a4f:	48 89 04 24          	mov    %rax,(%rsp)
    2a53:	f2 0f 10 44 24 20    	movsd  0x20(%rsp),%xmm0
    2a59:	e8 62 31 00 00       	call   5bc0 <fwp_from_f64>
    2a5e:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    2a63:	f2 0f 10 44 24 28    	movsd  0x28(%rsp),%xmm0
    2a69:	e8 52 31 00 00       	call   5bc0 <fwp_from_f64>
    2a6e:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    2a73:	48 89 e6             	mov    %rsp,%rsi
    2a76:	bf 03 00 00 00       	mov    $0x3,%edi
    2a7b:	e8 80 06 00 00       	call   3100 <fwp_record>
    2a80:	48 89 c3             	mov    %rax,%rbx
    2a83:	48 89 c7             	mov    %rax,%rdi
    2a86:	e8 35 06 00 00       	call   30c0 <fwp_rc_fresh>
    2a8b:	48 89 d8             	mov    %rbx,%rax
    2a8e:	48 83 c4 30          	add    $0x30,%rsp
    2a92:	5b                   	pop    %rbx
    2a93:	c3                   	ret
    2a94:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    2a9b:	00 00 00 00 00 

0000000000002aa0 <fwp_rc_release_last>:
    2aa0:	50                   	push   %rax
    2aa1:	e8 da 03 00 00       	call   2e80 <fwp_rc_slot>
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
    2ac3:	e8 b8 a3 00 00       	call   ce80 <fwp_rc_drop_slot>
    2ac8:	31 c0                	xor    %eax,%eax
    2aca:	59                   	pop    %rcx
    2acb:	c3                   	ret
    2acc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000002ad0 <fwp_rc_free_obj>:
    2ad0:	41 56                	push   %r14
    2ad2:	53                   	push   %rbx
    2ad3:	50                   	push   %rax
    2ad4:	48 89 fb             	mov    %rdi,%rbx
    2ad7:	e8 14 2d 00 00       	call   57f0 <fwp_rc_last>
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
    2afc:	e9 cf a3 00 00       	jmp    ced0 <fwp_rc_poison>
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
    2b43:	e8 c8 2c 00 00       	call   5810 <fwp_mem_free>
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
    2b74:	e8 b7 fe ff ff       	call   2a30 <f0>
    2b79:	48 89 c7             	mov    %rax,%rdi
    2b7c:	58                   	pop    %rax
    2b7d:	e9 ce 01 00 00       	jmp    2d50 <fwp_rc_shared>
    2b82:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2b89:	1f 84 00 00 00 00 00 

0000000000002b90 <e1>:
    2b90:	50                   	push   %rax
    2b91:	48 8b 3f             	mov    (%rdi),%rdi
    2b94:	e8 87 04 00 00       	call   3020 <f1>
    2b99:	48 89 c7             	mov    %rax,%rdi
    2b9c:	58                   	pop    %rax
    2b9d:	e9 ae 01 00 00       	jmp    2d50 <fwp_rc_shared>
    2ba2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2ba9:	1f 84 00 00 00 00 00 

0000000000002bb0 <e2>:
    2bb0:	50                   	push   %rax
    2bb1:	48 8b 3f             	mov    (%rdi),%rdi
    2bb4:	e8 07 24 00 00       	call   4fc0 <f2>
    2bb9:	48 89 c7             	mov    %rax,%rdi
    2bbc:	58                   	pop    %rax
    2bbd:	e9 8e 01 00 00       	jmp    2d50 <fwp_rc_shared>
    2bc2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2bc9:	1f 84 00 00 00 00 00 

0000000000002bd0 <e3>:
    2bd0:	50                   	push   %rax
    2bd1:	48 8b 3f             	mov    (%rdi),%rdi
    2bd4:	e8 f7 2e 00 00       	call   5ad0 <f3>
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
    2c1b:	e8 b0 2f 00 00       	call   5bd0 <f6>
    2c20:	48 89 c7             	mov    %rax,%rdi
    2c23:	58                   	pop    %rax
    2c24:	e9 27 01 00 00       	jmp    2d50 <fwp_rc_shared>
    2c29:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002c30 <e10>:
    2c30:	50                   	push   %rax
    2c31:	48 8b 3f             	mov    (%rdi),%rdi
    2c34:	e8 c7 2f 00 00       	call   5c00 <f10>
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
    2c5b:	e8 00 28 00 00       	call   5460 <f12>
    2c60:	48 89 c7             	mov    %rax,%rdi
    2c63:	58                   	pop    %rax
    2c64:	e9 e7 00 00 00       	jmp    2d50 <fwp_rc_shared>
    2c69:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002c70 <e14>:
    2c70:	50                   	push   %rax
    2c71:	48 8b 07             	mov    (%rdi),%rax
    2c74:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2c78:	48 89 c7             	mov    %rax,%rdi
    2c7b:	e8 00 28 00 00       	call   5480 <f14>
    2c80:	48 89 c7             	mov    %rax,%rdi
    2c83:	58                   	pop    %rax
    2c84:	e9 c7 00 00 00       	jmp    2d50 <fwp_rc_shared>
    2c89:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002c90 <e16>:
    2c90:	50                   	push   %rax
    2c91:	48 8b 07             	mov    (%rdi),%rax
    2c94:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2c98:	48 89 c7             	mov    %rax,%rdi
    2c9b:	e8 10 28 00 00       	call   54b0 <f16>
    2ca0:	48 89 c7             	mov    %rax,%rdi
    2ca3:	58                   	pop    %rax
    2ca4:	e9 a7 00 00 00       	jmp    2d50 <fwp_rc_shared>
    2ca9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002cb0 <e18>:
    2cb0:	50                   	push   %rax
    2cb1:	48 8b 07             	mov    (%rdi),%rax
    2cb4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2cb8:	48 89 c7             	mov    %rax,%rdi
    2cbb:	e8 20 28 00 00       	call   54e0 <f18>
    2cc0:	48 89 c7             	mov    %rax,%rdi
    2cc3:	58                   	pop    %rax
    2cc4:	e9 87 00 00 00       	jmp    2d50 <fwp_rc_shared>
    2cc9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002cd0 <e20>:
    2cd0:	50                   	push   %rax
    2cd1:	48 8b 07             	mov    (%rdi),%rax
    2cd4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2cd8:	48 89 c7             	mov    %rax,%rdi
    2cdb:	e8 40 28 00 00       	call   5520 <f20>
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
    2cfb:	e8 70 28 00 00       	call   5570 <f22>
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
    2d1b:	e8 a0 28 00 00       	call   55c0 <f24>
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
    2d3b:	e8 e0 28 00 00       	call   5620 <f26>
    2d40:	48 89 c7             	mov    %rax,%rdi
    2d43:	58                   	pop    %rax
    2d44:	eb 0a                	jmp    2d50 <fwp_rc_shared>
    2d46:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2d4d:	00 00 00 

0000000000002d50 <fwp_rc_shared>:
    2d50:	53                   	push   %rbx
    2d51:	48 89 fb             	mov    %rdi,%rbx
    2d54:	e8 07 00 00 00       	call   2d60 <fwp_rc_share>
    2d59:	48 89 d8             	mov    %rbx,%rax
    2d5c:	5b                   	pop    %rbx
    2d5d:	c3                   	ret
    2d5e:	66 90                	xchg   %ax,%ax

0000000000002d60 <fwp_rc_share>:
    2d60:	41 57                	push   %r15
    2d62:	41 56                	push   %r14
    2d64:	41 55                	push   %r13
    2d66:	41 54                	push   %r12
    2d68:	53                   	push   %rbx
    2d69:	48 81 ec 00 02 00 00 	sub    $0x200,%rsp
    2d70:	48 89 fb             	mov    %rdi,%rbx
    2d73:	e8 08 01 00 00       	call   2e80 <fwp_rc_slot>
    2d78:	48 85 c0             	test   %rax,%rax
    2d7b:	0f 84 ec 00 00 00    	je     2e6d <fwp_rc_share+0x10d>
    2d81:	80 38 00             	cmpb   $0x0,(%rax)
    2d84:	0f 84 e3 00 00 00    	je     2e6d <fwp_rc_share+0x10d>
    2d8a:	48 89 c7             	mov    %rax,%rdi
    2d8d:	e8 5e 01 00 00       	call   2ef0 <fwp_rc_clear_slot>
    2d92:	48 89 1c 24          	mov    %rbx,(%rsp)
    2d96:	41 be 01 00 00 00    	mov    $0x1,%r14d
    2d9c:	eb 0b                	jmp    2da9 <fwp_rc_share+0x49>
    2d9e:	66 90                	xchg   %ax,%ax
    2da0:	4d 85 f6             	test   %r14,%r14
    2da3:	0f 84 c4 00 00 00    	je     2e6d <fwp_rc_share+0x10d>
    2da9:	4e 8b 7c f4 f8       	mov    -0x8(%rsp,%r14,8),%r15
    2dae:	49 ff ce             	dec    %r14
    2db1:	4c 89 ff             	mov    %r15,%rdi
    2db4:	48 2b 3d 0d 25 01 00 	sub    0x1250d(%rip),%rdi        # 152c8 <fwp_gc+0x1030>
    2dbb:	48 c1 ef 10          	shr    $0x10,%rdi
    2dbf:	48 8b 05 4a 25 01 00 	mov    0x1254a(%rip),%rax        # 15310 <fwp_gc+0x1078>
    2dc6:	48 69 cf 28 12 00 00 	imul   $0x1228,%rdi,%rcx
    2dcd:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    2dd2:	74 cc                	je     2da0 <fwp_rc_share+0x40>
    2dd4:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    2dd8:	80 fa 02             	cmp    $0x2,%dl
    2ddb:	75 13                	jne    2df0 <fwp_rc_share+0x90>
    2ddd:	4c 8b 64 08 18       	mov    0x18(%rax,%rcx,1),%r12
    2de2:	eb 33                	jmp    2e17 <fwp_rc_share+0xb7>
    2de4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    2deb:	00 00 00 00 00 
    2df0:	44 8b 64 08 08       	mov    0x8(%rax,%rcx,1),%r12d
    2df5:	80 fa 01             	cmp    $0x1,%dl
    2df8:	75 1d                	jne    2e17 <fwp_rc_share+0xb7>
    2dfa:	41 0f b7 d7          	movzwl %r15w,%edx
    2dfe:	44 8b 7c 08 20       	mov    0x20(%rax,%rcx,1),%r15d
    2e03:	4c 0f af fa          	imul   %rdx,%r15
    2e07:	49 c1 ef 20          	shr    $0x20,%r15
    2e0b:	e8 00 01 00 00       	call   2f10 <fwp_gc_chunk_addr>
    2e10:	4d 0f af fc          	imul   %r12,%r15
    2e14:	49 01 c7             	add    %rax,%r15
    2e17:	49 83 fc 08          	cmp    $0x8,%r12
    2e1b:	72 83                	jb     2da0 <fwp_rc_share+0x40>
    2e1d:	49 c1 ec 03          	shr    $0x3,%r12
    2e21:	45 31 ed             	xor    %r13d,%r13d
    2e24:	eb 16                	jmp    2e3c <fwp_rc_share+0xdc>
    2e26:	48 89 df             	mov    %rbx,%rdi
    2e29:	e8 32 ff ff ff       	call   2d60 <fwp_rc_share>
    2e2e:	66 90                	xchg   %ax,%ax
    2e30:	49 ff c5             	inc    %r13
    2e33:	4d 39 ec             	cmp    %r13,%r12
    2e36:	0f 84 64 ff ff ff    	je     2da0 <fwp_rc_share+0x40>
    2e3c:	4b 8b 1c ef          	mov    (%r15,%r13,8),%rbx
    2e40:	48 89 df             	mov    %rbx,%rdi
    2e43:	e8 38 00 00 00       	call   2e80 <fwp_rc_slot>
    2e48:	48 85 c0             	test   %rax,%rax
    2e4b:	74 e3                	je     2e30 <fwp_rc_share+0xd0>
    2e4d:	80 38 00             	cmpb   $0x0,(%rax)
    2e50:	74 de                	je     2e30 <fwp_rc_share+0xd0>
    2e52:	49 83 fe 3f          	cmp    $0x3f,%r14
    2e56:	77 ce                	ja     2e26 <fwp_rc_share+0xc6>
    2e58:	48 89 c7             	mov    %rax,%rdi
    2e5b:	e8 90 00 00 00       	call   2ef0 <fwp_rc_clear_slot>
    2e60:	4b 8b 04 ef          	mov    (%r15,%r13,8),%rax
    2e64:	4a 89 04 f4          	mov    %rax,(%rsp,%r14,8)
    2e68:	49 ff c6             	inc    %r14
    2e6b:	eb c3                	jmp    2e30 <fwp_rc_share+0xd0>
    2e6d:	48 81 c4 00 02 00 00 	add    $0x200,%rsp
    2e74:	5b                   	pop    %rbx
    2e75:	41 5c                	pop    %r12
    2e77:	41 5d                	pop    %r13
    2e79:	41 5e                	pop    %r14
    2e7b:	41 5f                	pop    %r15
    2e7d:	c3                   	ret
    2e7e:	66 90                	xchg   %ax,%ax

0000000000002e80 <fwp_rc_slot>:
    2e80:	48 2b 3d 41 24 01 00 	sub    0x12441(%rip),%rdi        # 152c8 <fwp_gc+0x1030>
    2e87:	48 8b 05 62 24 01 00 	mov    0x12462(%rip),%rax        # 152f0 <fwp_gc+0x1058>
    2e8e:	48 c1 e0 10          	shl    $0x10,%rax
    2e92:	48 39 c7             	cmp    %rax,%rdi
    2e95:	73 51                	jae    2ee8 <fwp_rc_slot+0x68>
    2e97:	48 8b 05 72 24 01 00 	mov    0x12472(%rip),%rax        # 15310 <fwp_gc+0x1078>
    2e9e:	48 89 f9             	mov    %rdi,%rcx
    2ea1:	48 c1 e9 10          	shr    $0x10,%rcx
    2ea5:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    2eac:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    2eb0:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    2eb7:	75 0f                	jne    2ec8 <fwp_rc_slot+0x48>
    2eb9:	80 fa 02             	cmp    $0x2,%dl
    2ebc:	75 0a                	jne    2ec8 <fwp_rc_slot+0x48>
    2ebe:	48 01 c8             	add    %rcx,%rax
    2ec1:	48 05 28 02 00 00    	add    $0x228,%rax
    2ec7:	c3                   	ret
    2ec8:	80 fa 01             	cmp    $0x1,%dl
    2ecb:	75 1b                	jne    2ee8 <fwp_rc_slot+0x68>
    2ecd:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    2ed1:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    2ed5:	48 0f af f8          	imul   %rax,%rdi
    2ed9:	48 c1 ef 20          	shr    $0x20,%rdi
    2edd:	48 8d 04 17          	lea    (%rdi,%rdx,1),%rax
    2ee1:	48 05 28 02 00 00    	add    $0x228,%rax
    2ee7:	c3                   	ret
    2ee8:	31 c0                	xor    %eax,%eax
    2eea:	c3                   	ret
    2eeb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000002ef0 <fwp_rc_clear_slot>:
    2ef0:	80 3f ff             	cmpb   $0xff,(%rdi)
    2ef3:	74 04                	je     2ef9 <fwp_rc_clear_slot+0x9>
    2ef5:	c6 07 00             	movb   $0x0,(%rdi)
    2ef8:	c3                   	ret
    2ef9:	53                   	push   %rbx
    2efa:	48 89 fb             	mov    %rdi,%rbx
    2efd:	e8 1e 00 00 00       	call   2f20 <fwp_rc_forget_slot>
    2f02:	48 89 df             	mov    %rbx,%rdi
    2f05:	5b                   	pop    %rbx
    2f06:	c6 07 00             	movb   $0x0,(%rdi)
    2f09:	c3                   	ret
    2f0a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000002f10 <fwp_gc_chunk_addr>:
    2f10:	48 89 f8             	mov    %rdi,%rax
    2f13:	48 c1 e0 10          	shl    $0x10,%rax
    2f17:	48 03 05 aa 23 01 00 	add    0x123aa(%rip),%rax        # 152c8 <fwp_gc+0x1030>
    2f1e:	c3                   	ret
    2f1f:	90                   	nop

0000000000002f20 <fwp_rc_forget_slot>:
    2f20:	50                   	push   %rax
    2f21:	80 3f ff             	cmpb   $0xff,(%rdi)
    2f24:	74 02                	je     2f28 <fwp_rc_forget_slot+0x8>
    2f26:	58                   	pop    %rax
    2f27:	c3                   	ret
    2f28:	e8 33 00 00 00       	call   2f60 <fwp_rc_wide_link>
    2f2d:	48 8b 38             	mov    (%rax),%rdi
    2f30:	48 85 ff             	test   %rdi,%rdi
    2f33:	74 15                	je     2f4a <fwp_rc_forget_slot+0x2a>
    2f35:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    2f39:	48 89 08             	mov    %rcx,(%rax)
    2f3c:	e8 0f f1 ff ff       	call   2050 <free@plt>
    2f41:	48 ff 0d 68 2d 01 00 	decq   0x12d68(%rip)        # 15cb0 <fwp_gc+0x1a18>
    2f48:	58                   	pop    %rax
    2f49:	c3                   	ret
    2f4a:	48 8d 3d b3 b7 00 00 	lea    0xb7b3(%rip),%rdi        # e704 <exec_in_fp0+0xb4>
    2f51:	e8 6a 00 00 00       	call   2fc0 <fwp_trap>
    2f56:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2f5d:	00 00 00 

0000000000002f60 <fwp_rc_wide_link>:
    2f60:	48 89 f8             	mov    %rdi,%rax
    2f63:	48 c1 e8 11          	shr    $0x11,%rax
    2f67:	31 f8                	xor    %edi,%eax
    2f69:	89 c1                	mov    %eax,%ecx
    2f6b:	c1 e9 09             	shr    $0x9,%ecx
    2f6e:	31 c1                	xor    %eax,%ecx
    2f70:	0f b6 c9             	movzbl %cl,%ecx
    2f73:	48 8d 15 1e 13 01 00 	lea    0x1131e(%rip),%rdx        # 14298 <fwp_gc>
    2f7a:	48 8d 04 ca          	lea    (%rdx,%rcx,8),%rax
    2f7e:	48 05 18 12 00 00    	add    $0x1218,%rax
    2f84:	48 8b 8c ca 18 12 00 	mov    0x1218(%rdx,%rcx,8),%rcx
    2f8b:	00 
    2f8c:	48 85 c9             	test   %rcx,%rcx
    2f8f:	74 24                	je     2fb5 <fwp_rc_wide_link+0x55>
    2f91:	48 39 39             	cmp    %rdi,(%rcx)
    2f94:	74 1f                	je     2fb5 <fwp_rc_wide_link+0x55>
    2f96:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2f9d:	00 00 00 
    2fa0:	48 89 c8             	mov    %rcx,%rax
    2fa3:	48 8b 49 10          	mov    0x10(%rcx),%rcx
    2fa7:	48 85 c9             	test   %rcx,%rcx
    2faa:	74 05                	je     2fb1 <fwp_rc_wide_link+0x51>
    2fac:	48 39 39             	cmp    %rdi,(%rcx)
    2faf:	75 ef                	jne    2fa0 <fwp_rc_wide_link+0x40>
    2fb1:	48 83 c0 10          	add    $0x10,%rax
    2fb5:	c3                   	ret
    2fb6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2fbd:	00 00 00 

0000000000002fc0 <fwp_trap>:
    2fc0:	53                   	push   %rbx
    2fc1:	48 89 fb             	mov    %rdi,%rbx
    2fc4:	e8 27 00 00 00       	call   2ff0 <fwp_flush>
    2fc9:	48 8b 05 10 10 01 00 	mov    0x11010(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    2fd0:	48 8b 38             	mov    (%rax),%rdi
    2fd3:	48 8d 35 51 b7 00 00 	lea    0xb751(%rip),%rsi        # e72b <exec_in_fp0+0xdb>
    2fda:	48 89 da             	mov    %rbx,%rdx
    2fdd:	31 c0                	xor    %eax,%eax
    2fdf:	e8 0c f3 ff ff       	call   22f0 <fprintf@plt>
    2fe4:	bf 65 00 00 00       	mov    $0x65,%edi
    2fe9:	e8 92 f4 ff ff       	call   2480 <exit@plt>
    2fee:	66 90                	xchg   %ax,%ax

0000000000002ff0 <fwp_flush>:
    2ff0:	50                   	push   %rax
    2ff1:	48 8b 3d b0 2d 01 00 	mov    0x12db0(%rip),%rdi        # 15da8 <fwp_prog_out>
    2ff8:	48 85 ff             	test   %rdi,%rdi
    2ffb:	74 05                	je     3002 <fwp_flush+0x12>
    2ffd:	e8 4e f3 ff ff       	call   2350 <fflush@plt>
    3002:	48 8b 05 af 0f 01 00 	mov    0x10faf(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    3009:	48 8b 38             	mov    (%rax),%rdi
    300c:	58                   	pop    %rax
    300d:	e9 3e f3 ff ff       	jmp    2350 <fflush@plt>
    3012:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3019:	1f 84 00 00 00 00 00 

0000000000003020 <f1>:
    3020:	53                   	push   %rbx
    3021:	48 83 ec 30          	sub    $0x30,%rsp
    3025:	e8 86 00 00 00       	call   30b0 <fwp_f32>
    302a:	e8 61 00 00 00       	call   3090 <w1>
    302f:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    3034:	f3 0f 11 4c 24 04    	movss  %xmm1,0x4(%rsp)
    303a:	e8 d1 00 00 00       	call   3110 <fwp_from_f32>
    303f:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    3044:	0f 28 44 24 20       	movaps 0x20(%rsp),%xmm0
    3049:	0f c6 c0 55          	shufps $0x55,%xmm0,%xmm0
    304d:	e8 be 00 00 00       	call   3110 <fwp_from_f32>
    3052:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    3057:	f3 0f 10 44 24 04    	movss  0x4(%rsp),%xmm0
    305d:	e8 ae 00 00 00       	call   3110 <fwp_from_f32>
    3062:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    3067:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    306c:	bf 03 00 00 00       	mov    $0x3,%edi
    3071:	e8 8a 00 00 00       	call   3100 <fwp_record>
    3076:	48 89 c3             	mov    %rax,%rbx
    3079:	48 89 c7             	mov    %rax,%rdi
    307c:	e8 3f 00 00 00       	call   30c0 <fwp_rc_fresh>
    3081:	48 89 d8             	mov    %rbx,%rax
    3084:	48 83 c4 30          	add    $0x30,%rsp
    3088:	5b                   	pop    %rbx
    3089:	c3                   	ret
    308a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000003090 <w1>:
    3090:	50                   	push   %rax
    3091:	e8 7a 00 00 00       	call   3110 <fwp_from_f32>
    3096:	48 89 c7             	mov    %rax,%rdi
    3099:	e8 12 00 00 00       	call   30b0 <fwp_f32>
    309e:	0f 28 d0             	movaps %xmm0,%xmm2
    30a1:	0f c6 d0 00          	shufps $0x0,%xmm0,%xmm2
    30a5:	0f 28 c8             	movaps %xmm0,%xmm1
    30a8:	0f 28 c2             	movaps %xmm2,%xmm0
    30ab:	58                   	pop    %rax
    30ac:	c3                   	ret
    30ad:	0f 1f 00             	nopl   (%rax)

00000000000030b0 <fwp_f32>:
    30b0:	66 0f 6e c7          	movd   %edi,%xmm0
    30b4:	c3                   	ret
    30b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    30bc:	00 00 00 00 

00000000000030c0 <fwp_rc_fresh>:
    30c0:	41 56                	push   %r14
    30c2:	53                   	push   %rbx
    30c3:	50                   	push   %rax
    30c4:	48 89 fb             	mov    %rdi,%rbx
    30c7:	e8 b4 fd ff ff       	call   2e80 <fwp_rc_slot>
    30cc:	48 85 c0             	test   %rax,%rax
    30cf:	74 08                	je     30d9 <fwp_rc_fresh+0x19>
    30d1:	80 38 ff             	cmpb   $0xff,(%rax)
    30d4:	74 0e                	je     30e4 <fwp_rc_fresh+0x24>
    30d6:	c6 00 01             	movb   $0x1,(%rax)
    30d9:	48 89 d8             	mov    %rbx,%rax
    30dc:	48 83 c4 08          	add    $0x8,%rsp
    30e0:	5b                   	pop    %rbx
    30e1:	41 5e                	pop    %r14
    30e3:	c3                   	ret
    30e4:	48 89 c7             	mov    %rax,%rdi
    30e7:	49 89 c6             	mov    %rax,%r14
    30ea:	e8 31 fe ff ff       	call   2f20 <fwp_rc_forget_slot>
    30ef:	4c 89 f0             	mov    %r14,%rax
    30f2:	eb e2                	jmp    30d6 <fwp_rc_fresh+0x16>
    30f4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    30fb:	00 00 00 00 00 

0000000000003100 <fwp_record>:
    3100:	85 ff                	test   %edi,%edi
    3102:	74 09                	je     310d <fwp_record+0xd>
    3104:	48 89 f2             	mov    %rsi,%rdx
    3107:	89 fe                	mov    %edi,%esi
    3109:	31 ff                	xor    %edi,%edi
    310b:	eb 13                	jmp    3120 <fwp_data>
    310d:	31 c0                	xor    %eax,%eax
    310f:	c3                   	ret

0000000000003110 <fwp_from_f32>:
    3110:	66 0f 7e c0          	movd   %xmm0,%eax
    3114:	c3                   	ret
    3115:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    311c:	00 00 00 00 

0000000000003120 <fwp_data>:
    3120:	55                   	push   %rbp
    3121:	41 57                	push   %r15
    3123:	41 56                	push   %r14
    3125:	53                   	push   %rbx
    3126:	50                   	push   %rax
    3127:	89 fd                	mov    %edi,%ebp
    3129:	85 f6                	test   %esi,%esi
    312b:	0f 84 a1 00 00 00    	je     31d2 <fwp_data+0xb2>
    3131:	48 89 d3             	mov    %rdx,%rbx
    3134:	41 89 f6             	mov    %esi,%r14d
    3137:	4a 8d 3c f5 08 00 00 	lea    0x8(,%r14,8),%rdi
    313e:	00 
    313f:	41 89 f7             	mov    %esi,%r15d
    3142:	e8 d9 00 00 00       	call   3220 <fwp_alloc_init>
    3147:	89 28                	mov    %ebp,(%rax)
    3149:	44 89 78 04          	mov    %r15d,0x4(%rax)
    314d:	41 83 ff 08          	cmp    $0x8,%r15d
    3151:	72 10                	jb     3163 <fwp_data+0x43>
    3153:	48 89 c1             	mov    %rax,%rcx
    3156:	48 29 d9             	sub    %rbx,%rcx
    3159:	48 83 c1 08          	add    $0x8,%rcx
    315d:	48 83 f9 20          	cmp    $0x20,%rcx
    3161:	73 73                	jae    31d6 <fwp_data+0xb6>
    3163:	31 c9                	xor    %ecx,%ecx
    3165:	4c 89 f6             	mov    %r14,%rsi
    3168:	48 89 ca             	mov    %rcx,%rdx
    316b:	48 83 e6 03          	and    $0x3,%rsi
    316f:	74 20                	je     3191 <fwp_data+0x71>
    3171:	48 89 ca             	mov    %rcx,%rdx
    3174:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    317b:	00 00 00 00 00 
    3180:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    3184:	48 89 7c d0 08       	mov    %rdi,0x8(%rax,%rdx,8)
    3189:	48 ff c2             	inc    %rdx
    318c:	48 ff ce             	dec    %rsi
    318f:	75 ef                	jne    3180 <fwp_data+0x60>
    3191:	4c 29 f1             	sub    %r14,%rcx
    3194:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    3198:	77 7b                	ja     3215 <fwp_data+0xf5>
    319a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    31a0:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    31a4:	48 89 4c d0 08       	mov    %rcx,0x8(%rax,%rdx,8)
    31a9:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    31ae:	48 89 4c d0 10       	mov    %rcx,0x10(%rax,%rdx,8)
    31b3:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    31b8:	48 89 4c d0 18       	mov    %rcx,0x18(%rax,%rdx,8)
    31bd:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    31c2:	48 89 4c d0 20       	mov    %rcx,0x20(%rax,%rdx,8)
    31c7:	48 83 c2 04          	add    $0x4,%rdx
    31cb:	49 39 d6             	cmp    %rdx,%r14
    31ce:	75 d0                	jne    31a0 <fwp_data+0x80>
    31d0:	eb 43                	jmp    3215 <fwp_data+0xf5>
    31d2:	89 e8                	mov    %ebp,%eax
    31d4:	eb 3f                	jmp    3215 <fwp_data+0xf5>
    31d6:	44 89 f1             	mov    %r14d,%ecx
    31d9:	83 e1 fc             	and    $0xfffffffc,%ecx
    31dc:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
    31e3:	00 
    31e4:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    31e8:	31 f6                	xor    %esi,%esi
    31ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    31f0:	0f 10 04 33          	movups (%rbx,%rsi,1),%xmm0
    31f4:	0f 10 4c 33 10       	movups 0x10(%rbx,%rsi,1),%xmm1
    31f9:	0f 11 44 30 08       	movups %xmm0,0x8(%rax,%rsi,1)
    31fe:	0f 11 4c 30 18       	movups %xmm1,0x18(%rax,%rsi,1)
    3203:	48 83 c6 20          	add    $0x20,%rsi
    3207:	48 39 f2             	cmp    %rsi,%rdx
    320a:	75 e4                	jne    31f0 <fwp_data+0xd0>
    320c:	4c 39 f1             	cmp    %r14,%rcx
    320f:	0f 85 50 ff ff ff    	jne    3165 <fwp_data+0x45>
    3215:	48 83 c4 08          	add    $0x8,%rsp
    3219:	5b                   	pop    %rbx
    321a:	41 5e                	pop    %r14
    321c:	41 5f                	pop    %r15
    321e:	5d                   	pop    %rbp
    321f:	c3                   	ret

0000000000003220 <fwp_alloc_init>:
    3220:	53                   	push   %rbx
    3221:	48 89 fa             	mov    %rdi,%rdx
    3224:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    322b:	0f 87 a7 00 00 00    	ja     32d8 <fwp_alloc_init+0xb8>
    3231:	48 8d 42 0f          	lea    0xf(%rdx),%rax
    3235:	48 c1 e8 04          	shr    $0x4,%rax
    3239:	48 8d 35 58 10 01 00 	lea    0x11058(%rip),%rsi        # 14298 <fwp_gc>
    3240:	0f b6 bc 30 e8 0b 00 	movzbl 0xbe8(%rax,%rsi,1),%edi
    3247:	00 
    3248:	8b 84 be 48 0b 00 00 	mov    0xb48(%rsi,%rdi,4),%eax
    324f:	48 8b 0d 42 10 01 00 	mov    0x11042(%rip),%rcx        # 14298 <fwp_gc>
    3256:	49 89 c8             	mov    %rcx,%r8
    3259:	49 29 c0             	sub    %rax,%r8
    325c:	4c 89 05 35 10 01 00 	mov    %r8,0x11035(%rip)        # 14298 <fwp_gc>
    3263:	78 6c                	js     32d1 <fwp_alloc_init+0xb1>
    3265:	48 8d 3c 7f          	lea    (%rdi,%rdi,2),%rdi
    3269:	4c 8d 04 fe          	lea    (%rsi,%rdi,8),%r8
    326d:	49 83 c0 08          	add    $0x8,%r8
    3271:	49 8b 18             	mov    (%r8),%rbx
    3274:	48 85 db             	test   %rbx,%rbx
    3277:	74 32                	je     32ab <fwp_alloc_init+0x8b>
    3279:	48 8b 0b             	mov    (%rbx),%rcx
    327c:	48 f7 d1             	not    %rcx
    327f:	49 89 08             	mov    %rcx,(%r8)
    3282:	81 e2 f8 7f 00 00    	and    $0x7ff8,%edx
    3288:	48 39 c2             	cmp    %rax,%rdx
    328b:	73 19                	jae    32a6 <fwp_alloc_init+0x86>
    328d:	48 8d 3c 13          	lea    (%rbx,%rdx,1),%rdi
    3291:	48 f7 d2             	not    %rdx
    3294:	48 01 c2             	add    %rax,%rdx
    3297:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    329b:	48 83 c2 08          	add    $0x8,%rdx
    329f:	31 f6                	xor    %esi,%esi
    32a1:	e8 6a ef ff ff       	call   2210 <memset@plt>
    32a6:	48 89 d8             	mov    %rbx,%rax
    32a9:	5b                   	pop    %rbx
    32aa:	c3                   	ret
    32ab:	48 8b 5c fe 10       	mov    0x10(%rsi,%rdi,8),%rbx
    32b0:	4c 8b 44 fe 18       	mov    0x18(%rsi,%rdi,8),%r8
    32b5:	49 29 d8             	sub    %rbx,%r8
    32b8:	49 39 c0             	cmp    %rax,%r8
    32bb:	72 14                	jb     32d1 <fwp_alloc_init+0xb1>
    32bd:	48 8d 34 fe          	lea    (%rsi,%rdi,8),%rsi
    32c1:	48 83 c6 10          	add    $0x10,%rsi
    32c5:	48 8d 3c 03          	lea    (%rbx,%rax,1),%rdi
    32c9:	48 89 3e             	mov    %rdi,(%rsi)
    32cc:	48 85 db             	test   %rbx,%rbx
    32cf:	75 b1                	jne    3282 <fwp_alloc_init+0x62>
    32d1:	48 89 0d c0 0f 01 00 	mov    %rcx,0x10fc0(%rip)        # 14298 <fwp_gc>
    32d8:	48 89 d7             	mov    %rdx,%rdi
    32db:	31 f6                	xor    %esi,%esi
    32dd:	5b                   	pop    %rbx
    32de:	eb 00                	jmp    32e0 <fwp_gc_alloc>

00000000000032e0 <fwp_gc_alloc>:
    32e0:	53                   	push   %rbx
    32e1:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    32e8:	77 6c                	ja     3356 <fwp_gc_alloc+0x76>
    32ea:	48 8d 4f 0f          	lea    0xf(%rdi),%rcx
    32ee:	48 c1 e9 04          	shr    $0x4,%rcx
    32f2:	48 8d 05 9f 0f 01 00 	lea    0x10f9f(%rip),%rax        # 14298 <fwp_gc>
    32f9:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    3300:	00 
    3301:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    3308:	48 29 15 89 0f 01 00 	sub    %rdx,0x10f89(%rip)        # 14298 <fwp_gc>
    330f:	78 45                	js     3356 <fwp_gc_alloc+0x76>
    3311:	41 89 f0             	mov    %esi,%r8d
    3314:	4d 69 c0 c0 03 00 00 	imul   $0x3c0,%r8,%r8
    331b:	4c 01 c0             	add    %r8,%rax
    331e:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    3322:	4c 8d 04 c8          	lea    (%rax,%rcx,8),%r8
    3326:	49 83 c0 08          	add    $0x8,%r8
    332a:	49 8b 18             	mov    (%r8),%rbx
    332d:	48 85 db             	test   %rbx,%rbx
    3330:	74 12                	je     3344 <fwp_gc_alloc+0x64>
    3332:	48 8b 03             	mov    (%rbx),%rax
    3335:	48 f7 d0             	not    %rax
    3338:	49 89 00             	mov    %rax,(%r8)
    333b:	83 fe 01             	cmp    $0x1,%esi
    333e:	48 0f 44 d7          	cmove  %rdi,%rdx
    3342:	eb 2e                	jmp    3372 <fwp_gc_alloc+0x92>
    3344:	48 8b 5c c8 10       	mov    0x10(%rax,%rcx,8),%rbx
    3349:	4c 8b 44 c8 18       	mov    0x18(%rax,%rcx,8),%r8
    334e:	49 29 d8             	sub    %rbx,%r8
    3351:	49 39 d0             	cmp    %rdx,%r8
    3354:	73 03                	jae    3359 <fwp_gc_alloc+0x79>
    3356:	5b                   	pop    %rbx
    3357:	eb 37                	jmp    3390 <fwp_gc_alloc_slow>
    3359:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    335d:	48 83 c0 10          	add    $0x10,%rax
    3361:	48 8d 0c 13          	lea    (%rbx,%rdx,1),%rcx
    3365:	48 89 08             	mov    %rcx,(%rax)
    3368:	83 fe 01             	cmp    $0x1,%esi
    336b:	48 0f 45 fa          	cmovne %rdx,%rdi
    336f:	48 89 fa             	mov    %rdi,%rdx
    3372:	48 89 df             	mov    %rbx,%rdi
    3375:	31 f6                	xor    %esi,%esi
    3377:	e8 94 ee ff ff       	call   2210 <memset@plt>
    337c:	48 89 d8             	mov    %rbx,%rax
    337f:	5b                   	pop    %rbx
    3380:	c3                   	ret
    3381:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3388:	0f 1f 84 00 00 00 00 
    338f:	00 

0000000000003390 <fwp_gc_alloc_slow>:
    3390:	55                   	push   %rbp
    3391:	41 57                	push   %r15
    3393:	41 56                	push   %r14
    3395:	41 54                	push   %r12
    3397:	53                   	push   %rbx
    3398:	89 f5                	mov    %esi,%ebp
    339a:	48 89 fb             	mov    %rdi,%rbx
    339d:	83 3d e0 1e 01 00 00 	cmpl   $0x0,0x11ee0(%rip)        # 15284 <fwp_gc+0xfec>
    33a4:	74 1b                	je     33c1 <fwp_gc_alloc_slow+0x31>
    33a6:	48 81 fb 01 40 00 00 	cmp    $0x4001,%rbx
    33ad:	72 20                	jb     33cf <fwp_gc_alloc_slow+0x3f>
    33af:	48 89 df             	mov    %rbx,%rdi
    33b2:	89 ee                	mov    %ebp,%esi
    33b4:	5b                   	pop    %rbx
    33b5:	41 5c                	pop    %r12
    33b7:	41 5e                	pop    %r14
    33b9:	41 5f                	pop    %r15
    33bb:	5d                   	pop    %rbp
    33bc:	e9 9f 03 00 00       	jmp    3760 <fwp_gc_alloc_big>
    33c1:	e8 ba 00 00 00       	call   3480 <fwp_gc_init>
    33c6:	48 81 fb 01 40 00 00 	cmp    $0x4001,%rbx
    33cd:	73 e0                	jae    33af <fwp_gc_alloc_slow+0x1f>
    33cf:	48 8d 43 0f          	lea    0xf(%rbx),%rax
    33d3:	48 c1 e8 04          	shr    $0x4,%rax
    33d7:	4c 8d 25 ba 0e 01 00 	lea    0x10eba(%rip),%r12        # 14298 <fwp_gc>
    33de:	46 0f b6 bc 20 e8 0b 	movzbl 0xbe8(%rax,%r12,1),%r15d
    33e5:	00 00 
    33e7:	47 8b b4 bc 48 0b 00 	mov    0xb48(%r12,%r15,4),%r14d
    33ee:	00 
    33ef:	48 83 3d a1 0e 01 00 	cmpq   $0x0,0x10ea1(%rip)        # 14298 <fwp_gc>
    33f6:	00 
    33f7:	79 05                	jns    33fe <fwp_gc_alloc_slow+0x6e>
    33f9:	e8 b2 04 00 00       	call   38b0 <fwp_gc_spent>
    33fe:	89 e8                	mov    %ebp,%eax
    3400:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    3407:	49 01 c4             	add    %rax,%r12
    340a:	4b 8d 0c 7f          	lea    (%r15,%r15,2),%rcx
    340e:	49 8d 04 cc          	lea    (%r12,%rcx,8),%rax
    3412:	48 83 c0 08          	add    $0x8,%rax
    3416:	49 8b 7c cc 08       	mov    0x8(%r12,%rcx,8),%rdi
    341b:	48 85 ff             	test   %rdi,%rdi
    341e:	74 08                	je     3428 <fwp_gc_alloc_slow+0x98>
    3420:	48 8b 0f             	mov    (%rdi),%rcx
    3423:	48 f7 d1             	not    %rcx
    3426:	eb 30                	jmp    3458 <fwp_gc_alloc_slow+0xc8>
    3428:	49 8b 7c cc 10       	mov    0x10(%r12,%rcx,8),%rdi
    342d:	49 8b 54 cc 18       	mov    0x18(%r12,%rcx,8),%rdx
    3432:	48 29 fa             	sub    %rdi,%rdx
    3435:	4c 39 f2             	cmp    %r14,%rdx
    3438:	73 12                	jae    344c <fwp_gc_alloc_slow+0xbc>
    343a:	48 89 c7             	mov    %rax,%rdi
    343d:	44 89 fe             	mov    %r15d,%esi
    3440:	89 ea                	mov    %ebp,%edx
    3442:	e8 39 05 00 00       	call   3980 <fwp_gc_refill>
    3447:	48 89 c7             	mov    %rax,%rdi
    344a:	eb 0f                	jmp    345b <fwp_gc_alloc_slow+0xcb>
    344c:	49 8d 04 cc          	lea    (%r12,%rcx,8),%rax
    3450:	48 83 c0 10          	add    $0x10,%rax
    3454:	4a 8d 0c 37          	lea    (%rdi,%r14,1),%rcx
    3458:	48 89 08             	mov    %rcx,(%rax)
    345b:	83 fd 01             	cmp    $0x1,%ebp
    345e:	4c 0f 44 f3          	cmove  %rbx,%r14
    3462:	31 f6                	xor    %esi,%esi
    3464:	4c 89 f2             	mov    %r14,%rdx
    3467:	5b                   	pop    %rbx
    3468:	41 5c                	pop    %r12
    346a:	41 5e                	pop    %r14
    346c:	41 5f                	pop    %r15
    346e:	5d                   	pop    %rbp
    346f:	e9 9c ed ff ff       	jmp    2210 <memset@plt>
    3474:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    347b:	00 00 00 00 00 

0000000000003480 <fwp_gc_init>:
    3480:	53                   	push   %rbx
    3481:	48 83 ec 10          	sub    $0x10,%rsp
    3485:	c7 05 f5 1d 01 00 01 	movl   $0x1,0x11df5(%rip)        # 15284 <fwp_gc+0xfec>
    348c:	00 00 00 
    348f:	0f 28 05 7a ab 00 00 	movaps 0xab7a(%rip),%xmm0        # e010 <_IO_stdin_used+0x10>
    3496:	0f 11 05 43 19 01 00 	movups %xmm0,0x11943(%rip)        # 14de0 <fwp_gc+0xb48>
    349d:	0f 28 05 7c ab 00 00 	movaps 0xab7c(%rip),%xmm0        # e020 <_IO_stdin_used+0x20>
    34a4:	0f 11 05 45 19 01 00 	movups %xmm0,0x11945(%rip)        # 14df0 <fwp_gc+0xb58>
    34ab:	0f 28 05 7e ab 00 00 	movaps 0xab7e(%rip),%xmm0        # e030 <_IO_stdin_used+0x30>
    34b2:	0f 11 05 47 19 01 00 	movups %xmm0,0x11947(%rip)        # 14e00 <fwp_gc+0xb68>
    34b9:	0f 28 05 80 ab 00 00 	movaps 0xab80(%rip),%xmm0        # e040 <_IO_stdin_used+0x40>
    34c0:	0f 11 05 49 19 01 00 	movups %xmm0,0x11949(%rip)        # 14e10 <fwp_gc+0xb78>
    34c7:	0f 28 05 82 ab 00 00 	movaps 0xab82(%rip),%xmm0        # e050 <_IO_stdin_used+0x50>
    34ce:	0f 11 05 4b 19 01 00 	movups %xmm0,0x1194b(%rip)        # 14e20 <fwp_gc+0xb88>
    34d5:	0f 28 05 84 ab 00 00 	movaps 0xab84(%rip),%xmm0        # e060 <_IO_stdin_used+0x60>
    34dc:	0f 11 05 4d 19 01 00 	movups %xmm0,0x1194d(%rip)        # 14e30 <fwp_gc+0xb98>
    34e3:	0f 28 05 86 ab 00 00 	movaps 0xab86(%rip),%xmm0        # e070 <_IO_stdin_used+0x70>
    34ea:	0f 11 05 4f 19 01 00 	movups %xmm0,0x1194f(%rip)        # 14e40 <fwp_gc+0xba8>
    34f1:	0f 28 05 88 ab 00 00 	movaps 0xab88(%rip),%xmm0        # e080 <_IO_stdin_used+0x80>
    34f8:	0f 11 05 51 19 01 00 	movups %xmm0,0x11951(%rip)        # 14e50 <fwp_gc+0xbb8>
    34ff:	0f 28 05 8a ab 00 00 	movaps 0xab8a(%rip),%xmm0        # e090 <_IO_stdin_used+0x90>
    3506:	0f 11 05 53 19 01 00 	movups %xmm0,0x11953(%rip)        # 14e60 <fwp_gc+0xbc8>
    350d:	0f 28 05 8c ab 00 00 	movaps 0xab8c(%rip),%xmm0        # e0a0 <_IO_stdin_used+0xa0>
    3514:	0f 11 05 55 19 01 00 	movups %xmm0,0x11955(%rip)        # 14e70 <fwp_gc+0xbd8>
    351b:	31 c9                	xor    %ecx,%ecx
    351d:	48 8d 05 74 0d 01 00 	lea    0x10d74(%rip),%rax        # 14298 <fwp_gc>
    3524:	31 d2                	xor    %edx,%edx
    3526:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    352d:	00 00 00 
    3530:	89 d6                	mov    %edx,%esi
    3532:	c1 e6 04             	shl    $0x4,%esi
    3535:	48 ff c9             	dec    %rcx
    3538:	48 89 cf             	mov    %rcx,%rdi
    353b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    3540:	48 89 f9             	mov    %rdi,%rcx
    3543:	48 ff c7             	inc    %rdi
    3546:	3b b4 88 4c 0b 00 00 	cmp    0xb4c(%rax,%rcx,4),%esi
    354d:	77 f1                	ja     3540 <fwp_gc_init+0xc0>
    354f:	40 88 bc 02 e8 0b 00 	mov    %dil,0xbe8(%rdx,%rax,1)
    3556:	00 
    3557:	48 89 d6             	mov    %rdx,%rsi
    355a:	48 83 ce 01          	or     $0x1,%rsi
    355e:	48 81 fe 01 04 00 00 	cmp    $0x401,%rsi
    3565:	74 26                	je     358d <fwp_gc_init+0x10d>
    3567:	89 f7                	mov    %esi,%edi
    3569:	c1 e7 04             	shl    $0x4,%edi
    356c:	0f 1f 40 00          	nopl   0x0(%rax)
    3570:	49 89 c8             	mov    %rcx,%r8
    3573:	48 ff c1             	inc    %rcx
    3576:	42 3b bc 80 4c 0b 00 	cmp    0xb4c(%rax,%r8,4),%edi
    357d:	00 
    357e:	77 f0                	ja     3570 <fwp_gc_init+0xf0>
    3580:	88 8c 06 e8 0b 00 00 	mov    %cl,0xbe8(%rsi,%rax,1)
    3587:	48 83 c2 02          	add    $0x2,%rdx
    358b:	eb a3                	jmp    3530 <fwp_gc_init+0xb0>
    358d:	48 b8 00 00 00 00 10 	movabs $0x1000000000,%rax
    3594:	00 00 00 
    3597:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    359c:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    35a1:	e8 ba 04 00 00       	call   3a60 <fwp_gc_reserve>
    35a6:	48 85 c0             	test   %rax,%rax
    35a9:	0f 84 ab 01 00 00    	je     375a <fwp_gc_init+0x2da>
    35af:	48 89 05 1a 1d 01 00 	mov    %rax,0x11d1a(%rip)        # 152d0 <fwp_gc+0x1038>
    35b6:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    35bb:	48 8d 91 00 00 01 00 	lea    0x10000(%rcx),%rdx
    35c2:	48 89 15 0f 1d 01 00 	mov    %rdx,0x11d0f(%rip)        # 152d8 <fwp_gc+0x1040>
    35c9:	48 05 ff ff 00 00    	add    $0xffff,%rax
    35cf:	48 25 00 00 ff ff    	and    $0xffffffffffff0000,%rax
    35d5:	48 89 05 ec 1c 01 00 	mov    %rax,0x11cec(%rip)        # 152c8 <fwp_gc+0x1030>
    35dc:	48 c1 e9 10          	shr    $0x10,%rcx
    35e0:	48 89 0d 01 1d 01 00 	mov    %rcx,0x11d01(%rip)        # 152e8 <fwp_gc+0x1050>
    35e7:	48 69 f1 28 12 00 00 	imul   $0x1228,%rcx,%rsi
    35ee:	48 89 35 23 1d 01 00 	mov    %rsi,0x11d23(%rip)        # 15318 <fwp_gc+0x1080>
    35f5:	31 ff                	xor    %edi,%edi
    35f7:	31 d2                	xor    %edx,%edx
    35f9:	b9 22 40 00 00       	mov    $0x4022,%ecx
    35fe:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    3604:	45 31 c9             	xor    %r9d,%r9d
    3607:	e8 84 eb ff ff       	call   2190 <mmap@plt>
    360c:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    3610:	0f 84 44 01 00 00    	je     375a <fwp_gc_init+0x2da>
    3616:	48 89 05 f3 1c 01 00 	mov    %rax,0x11cf3(%rip)        # 15310 <fwp_gc+0x1078>
    361d:	48 8d 3d 16 b1 00 00 	lea    0xb116(%rip),%rdi        # e73a <exec_in_fp0+0xea>
    3624:	e8 07 ea ff ff       	call   2030 <getenv@plt>
    3629:	48 85 c0             	test   %rax,%rax
    362c:	74 2e                	je     365c <fwp_gc_init+0x1dc>
    362e:	48 89 c3             	mov    %rax,%rbx
    3631:	48 8d 35 09 b1 00 00 	lea    0xb109(%rip),%rsi        # e741 <exec_in_fp0+0xf1>
    3638:	48 89 c7             	mov    %rax,%rdi
    363b:	e8 90 ec ff ff       	call   22d0 <strcmp@plt>
    3640:	85 c0                	test   %eax,%eax
    3642:	74 1f                	je     3663 <fwp_gc_init+0x1e3>
    3644:	48 8d 35 30 bd 00 00 	lea    0xbd30(%rip),%rsi        # f37b <exec_in_fp0+0xd2b>
    364b:	48 89 df             	mov    %rbx,%rdi
    364e:	e8 7d ec ff ff       	call   22d0 <strcmp@plt>
    3653:	31 c9                	xor    %ecx,%ecx
    3655:	85 c0                	test   %eax,%eax
    3657:	0f 95 c1             	setne  %cl
    365a:	eb 09                	jmp    3665 <fwp_gc_init+0x1e5>
    365c:	b9 01 00 00 00       	mov    $0x1,%ecx
    3661:	eb 02                	jmp    3665 <fwp_gc_init+0x1e5>
    3663:	31 c9                	xor    %ecx,%ecx
    3665:	89 0d 1d 1c 01 00    	mov    %ecx,0x11c1d(%rip)        # 15288 <fwp_gc+0xff0>
    366b:	48 8d 3d d3 b0 00 00 	lea    0xb0d3(%rip),%rdi        # e745 <exec_in_fp0+0xf5>
    3672:	e8 b9 e9 ff ff       	call   2030 <getenv@plt>
    3677:	31 c9                	xor    %ecx,%ecx
    3679:	48 85 c0             	test   %rax,%rax
    367c:	74 1b                	je     3699 <fwp_gc_init+0x219>
    367e:	80 38 00             	cmpb   $0x0,(%rax)
    3681:	74 16                	je     3699 <fwp_gc_init+0x219>
    3683:	48 8d 35 f1 bc 00 00 	lea    0xbcf1(%rip),%rsi        # f37b <exec_in_fp0+0xd2b>
    368a:	48 89 c7             	mov    %rax,%rdi
    368d:	e8 3e ec ff ff       	call   22d0 <strcmp@plt>
    3692:	31 c9                	xor    %ecx,%ecx
    3694:	85 c0                	test   %eax,%eax
    3696:	0f 95 c1             	setne  %cl
    3699:	89 0d f5 1b 01 00    	mov    %ecx,0x11bf5(%rip)        # 15294 <fwp_gc+0xffc>
    369f:	48 8d 3d 94 b0 00 00 	lea    0xb094(%rip),%rdi        # e73a <exec_in_fp0+0xea>
    36a6:	e8 85 e9 ff ff       	call   2030 <getenv@plt>
    36ab:	48 85 c0             	test   %rax,%rax
    36ae:	74 18                	je     36c8 <fwp_gc_init+0x248>
    36b0:	48 8d 35 9b b0 00 00 	lea    0xb09b(%rip),%rsi        # e752 <exec_in_fp0+0x102>
    36b7:	48 89 c7             	mov    %rax,%rdi
    36ba:	e8 11 ec ff ff       	call   22d0 <strcmp@plt>
    36bf:	31 c9                	xor    %ecx,%ecx
    36c1:	85 c0                	test   %eax,%eax
    36c3:	0f 95 c1             	setne  %cl
    36c6:	eb 05                	jmp    36cd <fwp_gc_init+0x24d>
    36c8:	b9 01 00 00 00       	mov    $0x1,%ecx
    36cd:	89 0d c5 1b 01 00    	mov    %ecx,0x11bc5(%rip)        # 15298 <fwp_gc+0x1000>
    36d3:	c7 05 c3 1b 01 00 01 	movl   $0x1,0x11bc3(%rip)        # 152a0 <fwp_gc+0x1008>
    36da:	00 00 00 
    36dd:	48 8d 3d 73 b0 00 00 	lea    0xb073(%rip),%rdi        # e757 <exec_in_fp0+0x107>
    36e4:	e8 47 e9 ff ff       	call   2030 <getenv@plt>
    36e9:	31 c9                	xor    %ecx,%ecx
    36eb:	48 85 c0             	test   %rax,%rax
    36ee:	74 1b                	je     370b <fwp_gc_init+0x28b>
    36f0:	80 38 00             	cmpb   $0x0,(%rax)
    36f3:	74 16                	je     370b <fwp_gc_init+0x28b>
    36f5:	48 8d 35 7f bc 00 00 	lea    0xbc7f(%rip),%rsi        # f37b <exec_in_fp0+0xd2b>
    36fc:	48 89 c7             	mov    %rax,%rdi
    36ff:	e8 cc eb ff ff       	call   22d0 <strcmp@plt>
    3704:	31 c9                	xor    %ecx,%ecx
    3706:	85 c0                	test   %eax,%eax
    3708:	0f 95 c1             	setne  %cl
    370b:	89 0d 8b 1b 01 00    	mov    %ecx,0x11b8b(%rip)        # 1529c <fwp_gc+0x1004>
    3711:	48 8d 3d 4d b0 00 00 	lea    0xb04d(%rip),%rdi        # e765 <exec_in_fp0+0x115>
    3718:	e8 13 e9 ff ff       	call   2030 <getenv@plt>
    371d:	48 85 c0             	test   %rax,%rax
    3720:	74 0a                	je     372c <fwp_gc_init+0x2ac>
    3722:	48 89 c7             	mov    %rax,%rdi
    3725:	e8 d6 ec ff ff       	call   2400 <atol@plt>
    372a:	eb 02                	jmp    372e <fwp_gc_init+0x2ae>
    372c:	31 c0                	xor    %eax,%eax
    372e:	31 c9                	xor    %ecx,%ecx
    3730:	48 85 c0             	test   %rax,%rax
    3733:	48 0f 4f c8          	cmovg  %rax,%rcx
    3737:	48 89 0d 7a 1b 01 00 	mov    %rcx,0x11b7a(%rip)        # 152b8 <fwp_gc+0x1020>
    373e:	48 c7 05 5f 1d 01 00 	movq   $0x800000,0x11d5f(%rip)        # 154a8 <fwp_gc+0x1210>
    3745:	00 00 80 00 
    3749:	48 c7 05 44 0b 01 00 	movq   $0x800000,0x10b44(%rip)        # 14298 <fwp_gc>
    3750:	00 00 80 00 
    3754:	48 83 c4 10          	add    $0x10,%rsp
    3758:	5b                   	pop    %rbx
    3759:	c3                   	ret
    375a:	e8 71 03 00 00       	call   3ad0 <fwp_gc_oom>
    375f:	90                   	nop

0000000000003760 <fwp_gc_alloc_big>:
    3760:	55                   	push   %rbp
    3761:	41 57                	push   %r15
    3763:	41 56                	push   %r14
    3765:	41 54                	push   %r12
    3767:	53                   	push   %rbx
    3768:	48 b8 01 00 00 00 00 	movabs $0x4000000000000001,%rax
    376f:	00 00 40 
    3772:	48 39 c7             	cmp    %rax,%rdi
    3775:	0f 83 28 01 00 00    	jae    38a3 <fwp_gc_alloc_big+0x143>
    377b:	89 f5                	mov    %esi,%ebp
    377d:	48 89 fb             	mov    %rdi,%rbx
    3780:	48 29 3d 11 0b 01 00 	sub    %rdi,0x10b11(%rip)        # 14298 <fwp_gc>
    3787:	79 05                	jns    378e <fwp_gc_alloc_big+0x2e>
    3789:	e8 22 01 00 00       	call   38b0 <fwp_gc_spent>
    378e:	4c 8d bb ff ff 00 00 	lea    0xffff(%rbx),%r15
    3795:	49 c1 ef 10          	shr    $0x10,%r15
    3799:	4c 89 ff             	mov    %r15,%rdi
    379c:	e8 5f 03 00 00       	call   3b00 <fwp_gc_chunks>
    37a1:	49 89 c6             	mov    %rax,%r14
    37a4:	48 8b 05 65 1b 01 00 	mov    0x11b65(%rip),%rax        # 15310 <fwp_gc+0x1078>
    37ab:	4d 69 e6 28 12 00 00 	imul   $0x1228,%r14,%r12
    37b2:	42 c6 04 20 02       	movb   $0x2,(%rax,%r12,1)
    37b7:	42 88 6c 20 01       	mov    %bpl,0x1(%rax,%r12,1)
    37bc:	66 42 c7 44 20 03 00 	movw   $0x100,0x3(%rax,%r12,1)
    37c3:	01 
    37c4:	46 89 7c 20 10       	mov    %r15d,0x10(%rax,%r12,1)
    37c9:	4a 89 5c 20 18       	mov    %rbx,0x18(%rax,%r12,1)
    37ce:	4a 8d 3c 20          	lea    (%rax,%r12,1),%rdi
    37d2:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    37d9:	e8 12 f7 ff ff       	call   2ef0 <fwp_rc_clear_slot>
    37de:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    37e5:	0f 82 9b 00 00 00    	jb     3886 <fwp_gc_alloc_big+0x126>
    37eb:	49 83 ff 03          	cmp    $0x3,%r15
    37ef:	b9 02 00 00 00       	mov    $0x2,%ecx
    37f4:	49 0f 43 cf          	cmovae %r15,%rcx
    37f8:	48 8b 05 11 1b 01 00 	mov    0x11b11(%rip),%rax        # 15310 <fwp_gc+0x1078>
    37ff:	48 ff c9             	dec    %rcx
    3802:	ba 01 00 00 00       	mov    $0x1,%edx
    3807:	48 81 fb 01 00 02 00 	cmp    $0x20001,%rbx
    380e:	72 59                	jb     3869 <fwp_gc_alloc_big+0x109>
    3810:	49 8d 34 04          	lea    (%r12,%rax,1),%rsi
    3814:	48 81 c6 60 24 00 00 	add    $0x2460,%rsi
    381b:	48 89 cf             	mov    %rcx,%rdi
    381e:	48 83 e7 fe          	and    $0xfffffffffffffffe,%rdi
    3822:	48 f7 df             	neg    %rdi
    3825:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    382c:	00 00 00 00 
    3830:	c6 86 c8 ed ff ff 03 	movb   $0x3,-0x1238(%rsi)
    3837:	c6 86 cc ed ff ff 01 	movb   $0x1,-0x1234(%rsi)
    383e:	44 89 b6 d8 ed ff ff 	mov    %r14d,-0x1228(%rsi)
    3845:	c6 46 f0 03          	movb   $0x3,-0x10(%rsi)
    3849:	c6 46 f4 01          	movb   $0x1,-0xc(%rsi)
    384d:	44 89 36             	mov    %r14d,(%rsi)
    3850:	48 81 c6 50 24 00 00 	add    $0x2450,%rsi
    3857:	4c 8d 04 17          	lea    (%rdi,%rdx,1),%r8
    385b:	49 83 c0 02          	add    $0x2,%r8
    385f:	48 83 c2 02          	add    $0x2,%rdx
    3863:	49 83 f8 01          	cmp    $0x1,%r8
    3867:	75 c7                	jne    3830 <fwp_gc_alloc_big+0xd0>
    3869:	f6 c1 01             	test   $0x1,%cl
    386c:	74 18                	je     3886 <fwp_gc_alloc_big+0x126>
    386e:	4c 01 e0             	add    %r12,%rax
    3871:	48 69 ca 28 12 00 00 	imul   $0x1228,%rdx,%rcx
    3878:	c6 04 08 03          	movb   $0x3,(%rax,%rcx,1)
    387c:	c6 44 08 04 01       	movb   $0x1,0x4(%rax,%rcx,1)
    3881:	44 89 74 08 10       	mov    %r14d,0x10(%rax,%rcx,1)
    3886:	4c 89 f7             	mov    %r14,%rdi
    3889:	e8 82 f6 ff ff       	call   2f10 <fwp_gc_chunk_addr>
    388e:	48 89 c7             	mov    %rax,%rdi
    3891:	31 f6                	xor    %esi,%esi
    3893:	48 89 da             	mov    %rbx,%rdx
    3896:	5b                   	pop    %rbx
    3897:	41 5c                	pop    %r12
    3899:	41 5e                	pop    %r14
    389b:	41 5f                	pop    %r15
    389d:	5d                   	pop    %rbp
    389e:	e9 6d e9 ff ff       	jmp    2210 <memset@plt>
    38a3:	e8 28 02 00 00       	call   3ad0 <fwp_gc_oom>
    38a8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    38af:	00 

00000000000038b0 <fwp_gc_spent>:
    38b0:	50                   	push   %rax
    38b1:	83 3d cc 19 01 00 00 	cmpl   $0x0,0x119cc(%rip)        # 15284 <fwp_gc+0xfec>
    38b8:	75 05                	jne    38bf <fwp_gc_spent+0xf>
    38ba:	e8 c1 fb ff ff       	call   3480 <fwp_gc_init>
    38bf:	8b 05 c7 19 01 00    	mov    0x119c7(%rip),%eax        # 1528c <fwp_gc+0xff4>
    38c5:	85 c0                	test   %eax,%eax
    38c7:	74 6d                	je     3936 <fwp_gc_spent+0x86>
    38c9:	48 8b 0d e8 19 01 00 	mov    0x119e8(%rip),%rcx        # 152b8 <fwp_gc+0x1020>
    38d0:	48 85 c9             	test   %rcx,%rcx
    38d3:	74 61                	je     3936 <fwp_gc_spent+0x86>
    38d5:	48 8b 05 e4 19 01 00 	mov    0x119e4(%rip),%rax        # 152c0 <fwp_gc+0x1028>
    38dc:	48 ff c0             	inc    %rax
    38df:	48 89 05 da 19 01 00 	mov    %rax,0x119da(%rip)        # 152c0 <fwp_gc+0x1028>
    38e6:	48 39 c8             	cmp    %rcx,%rax
    38e9:	7c 10                	jl     38fb <fwp_gc_spent+0x4b>
    38eb:	48 c7 05 ca 19 01 00 	movq   $0x0,0x119ca(%rip)        # 152c0 <fwp_gc+0x1028>
    38f2:	00 00 00 00 
    38f6:	e8 85 03 00 00       	call   3c80 <fwp_gc_collect>
    38fb:	48 8b 05 a6 1b 01 00 	mov    0x11ba6(%rip),%rax        # 154a8 <fwp_gc+0x1210>
    3902:	48 2b 05 8f 09 01 00 	sub    0x1098f(%rip),%rax        # 14298 <fwp_gc>
    3909:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    390e:	f2 0f 58 05 6a 1b 01 	addsd  0x11b6a(%rip),%xmm0        # 15480 <fwp_gc+0x11e8>
    3915:	00 
    3916:	f2 0f 11 05 62 1b 01 	movsd  %xmm0,0x11b62(%rip)        # 15480 <fwp_gc+0x11e8>
    391d:	00 
    391e:	48 c7 05 7f 1b 01 00 	movq   $0x0,0x11b7f(%rip)        # 154a8 <fwp_gc+0x1210>
    3925:	00 00 00 00 
    3929:	48 c7 05 64 09 01 00 	movq   $0x0,0x10964(%rip)        # 14298 <fwp_gc>
    3930:	00 00 00 00 
    3934:	58                   	pop    %rax
    3935:	c3                   	ret
    3936:	85 c0                	test   %eax,%eax
    3938:	74 06                	je     3940 <fwp_gc_spent+0x90>
    393a:	58                   	pop    %rax
    393b:	e9 40 03 00 00       	jmp    3c80 <fwp_gc_collect>
    3940:	48 8b 05 61 1b 01 00 	mov    0x11b61(%rip),%rax        # 154a8 <fwp_gc+0x1210>
    3947:	48 2b 05 4a 09 01 00 	sub    0x1094a(%rip),%rax        # 14298 <fwp_gc>
    394e:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    3953:	f2 0f 58 05 25 1b 01 	addsd  0x11b25(%rip),%xmm0        # 15480 <fwp_gc+0x11e8>
    395a:	00 
    395b:	f2 0f 11 05 1d 1b 01 	movsd  %xmm0,0x11b1d(%rip)        # 15480 <fwp_gc+0x11e8>
    3962:	00 
    3963:	48 c7 05 3a 1b 01 00 	movq   $0x800000,0x11b3a(%rip)        # 154a8 <fwp_gc+0x1210>
    396a:	00 00 80 00 
    396e:	48 c7 05 1f 09 01 00 	movq   $0x800000,0x1091f(%rip)        # 14298 <fwp_gc>
    3975:	00 00 80 00 
    3979:	58                   	pop    %rax
    397a:	c3                   	ret
    397b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000003980 <fwp_gc_refill>:
    3980:	55                   	push   %rbp
    3981:	41 57                	push   %r15
    3983:	41 56                	push   %r14
    3985:	53                   	push   %rbx
    3986:	50                   	push   %rax
    3987:	89 d5                	mov    %edx,%ebp
    3989:	41 89 f7             	mov    %esi,%r15d
    398c:	48 89 fb             	mov    %rdi,%rbx
    398f:	bf 01 00 00 00       	mov    $0x1,%edi
    3994:	e8 67 01 00 00       	call   3b00 <fwp_gc_chunks>
    3999:	49 89 c6             	mov    %rax,%r14
    399c:	48 8b 0d 6d 19 01 00 	mov    0x1196d(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    39a3:	48 8d 05 ee 08 01 00 	lea    0x108ee(%rip),%rax        # 14298 <fwp_gc>
    39aa:	49 69 f6 28 12 00 00 	imul   $0x1228,%r14,%rsi
    39b1:	48 8d 3c 31          	lea    (%rcx,%rsi,1),%rdi
    39b5:	c6 04 31 01          	movb   $0x1,(%rcx,%rsi,1)
    39b9:	40 88 6c 31 01       	mov    %bpl,0x1(%rcx,%rsi,1)
    39be:	44 88 7c 31 02       	mov    %r15b,0x2(%rcx,%rsi,1)
    39c3:	c6 44 31 04 01       	movb   $0x1,0x4(%rcx,%rsi,1)
    39c8:	44 89 fa             	mov    %r15d,%edx
    39cb:	44 8b 84 90 48 0b 00 	mov    0xb48(%rax,%rdx,4),%r8d
    39d2:	00 
    39d3:	44 89 44 31 08       	mov    %r8d,0x8(%rcx,%rsi,1)
    39d8:	b8 00 00 01 00       	mov    $0x10000,%eax
    39dd:	31 d2                	xor    %edx,%edx
    39df:	41 f7 f0             	div    %r8d
    39e2:	89 44 31 0c          	mov    %eax,0xc(%rcx,%rsi,1)
    39e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    39eb:	4c 01 c0             	add    %r8,%rax
    39ee:	48 0f ba e0 20       	bt     $0x20,%rax
    39f3:	73 07                	jae    39fc <fwp_gc_refill+0x7c>
    39f5:	31 d2                	xor    %edx,%edx
    39f7:	49 f7 f0             	div    %r8
    39fa:	eb 05                	jmp    3a01 <fwp_gc_refill+0x81>
    39fc:	31 d2                	xor    %edx,%edx
    39fe:	41 f7 f0             	div    %r8d
    3a01:	4c 8d 3c 31          	lea    (%rcx,%rsi,1),%r15
    3a05:	49 83 c7 08          	add    $0x8,%r15
    3a09:	89 44 31 20          	mov    %eax,0x20(%rcx,%rsi,1)
    3a0d:	e8 4e 15 00 00       	call   4f60 <fwp_rc_clear_chunk>
    3a12:	4c 89 f7             	mov    %r14,%rdi
    3a15:	e8 f6 f4 ff ff       	call   2f10 <fwp_gc_chunk_addr>
    3a1a:	83 3d 7b 18 01 00 00 	cmpl   $0x0,0x1187b(%rip)        # 1529c <fwp_gc+0x1004>
    3a21:	74 15                	je     3a38 <fwp_gc_refill+0xb8>
    3a23:	ba 00 00 01 00       	mov    $0x10000,%edx
    3a28:	48 89 c7             	mov    %rax,%rdi
    3a2b:	31 f6                	xor    %esi,%esi
    3a2d:	49 89 c6             	mov    %rax,%r14
    3a30:	e8 db e7 ff ff       	call   2210 <memset@plt>
    3a35:	4c 89 f0             	mov    %r14,%rax
    3a38:	41 8b 0f             	mov    (%r15),%ecx
    3a3b:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    3a3f:	48 89 53 08          	mov    %rdx,0x8(%rbx)
    3a43:	41 8b 57 04          	mov    0x4(%r15),%edx
    3a47:	48 0f af d1          	imul   %rcx,%rdx
    3a4b:	48 01 c2             	add    %rax,%rdx
    3a4e:	48 89 53 10          	mov    %rdx,0x10(%rbx)
    3a52:	48 83 c4 08          	add    $0x8,%rsp
    3a56:	5b                   	pop    %rbx
    3a57:	41 5e                	pop    %r14
    3a59:	41 5f                	pop    %r15
    3a5b:	5d                   	pop    %rbp
    3a5c:	c3                   	ret
    3a5d:	0f 1f 00             	nopl   (%rax)

0000000000003a60 <fwp_gc_reserve>:
    3a60:	41 56                	push   %r14
    3a62:	53                   	push   %rbx
    3a63:	50                   	push   %rax
    3a64:	4c 8b 37             	mov    (%rdi),%r14
    3a67:	49 81 fe 00 00 00 10 	cmp    $0x10000000,%r14
    3a6e:	72 47                	jb     3ab7 <fwp_gc_reserve+0x57>
    3a70:	48 89 fb             	mov    %rdi,%rbx
    3a73:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3a7a:	84 00 00 00 00 00 
    3a80:	49 8d b6 00 00 01 00 	lea    0x10000(%r14),%rsi
    3a87:	31 ff                	xor    %edi,%edi
    3a89:	31 d2                	xor    %edx,%edx
    3a8b:	b9 22 40 00 00       	mov    $0x4022,%ecx
    3a90:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    3a96:	45 31 c9             	xor    %r9d,%r9d
    3a99:	e8 f2 e6 ff ff       	call   2190 <mmap@plt>
    3a9e:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    3aa2:	75 17                	jne    3abb <fwp_gc_reserve+0x5b>
    3aa4:	4c 89 f0             	mov    %r14,%rax
    3aa7:	48 c1 e8 02          	shr    $0x2,%rax
    3aab:	49 81 fe ff ff ff 3f 	cmp    $0x3fffffff,%r14
    3ab2:	49 89 c6             	mov    %rax,%r14
    3ab5:	77 c9                	ja     3a80 <fwp_gc_reserve+0x20>
    3ab7:	31 c0                	xor    %eax,%eax
    3ab9:	eb 03                	jmp    3abe <fwp_gc_reserve+0x5e>
    3abb:	4c 89 33             	mov    %r14,(%rbx)
    3abe:	48 83 c4 08          	add    $0x8,%rsp
    3ac2:	5b                   	pop    %rbx
    3ac3:	41 5e                	pop    %r14
    3ac5:	c3                   	ret
    3ac6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    3acd:	00 00 00 

0000000000003ad0 <fwp_gc_oom>:
    3ad0:	50                   	push   %rax
    3ad1:	48 8b 05 08 05 01 00 	mov    0x10508(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    3ad8:	48 8b 08             	mov    (%rax),%rcx
    3adb:	48 8d 3d 91 ac 00 00 	lea    0xac91(%rip),%rdi        # e773 <exec_in_fp0+0x123>
    3ae2:	be 13 00 00 00       	mov    $0x13,%esi
    3ae7:	ba 01 00 00 00       	mov    $0x1,%edx
    3aec:	e8 af e9 ff ff       	call   24a0 <fwrite@plt>
    3af1:	bf 66 00 00 00       	mov    $0x66,%edi
    3af6:	e8 85 e9 ff ff       	call   2480 <exit@plt>
    3afb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000003b00 <fwp_gc_chunks>:
    3b00:	41 56                	push   %r14
    3b02:	53                   	push   %rbx
    3b03:	50                   	push   %rax
    3b04:	48 89 fb             	mov    %rdi,%rbx
    3b07:	31 d2                	xor    %edx,%edx
    3b09:	48 83 ff 01          	cmp    $0x1,%rdi
    3b0d:	0f 95 c2             	setne  %dl
    3b10:	48 8d 0d 81 07 01 00 	lea    0x10781(%rip),%rcx        # 14298 <fwp_gc>
    3b17:	48 8b 84 d1 68 10 00 	mov    0x1068(%rcx,%rdx,8),%rax
    3b1e:	00 
    3b1f:	4c 8b 35 ca 17 01 00 	mov    0x117ca(%rip),%r14        # 152f0 <fwp_gc+0x1058>
    3b26:	48 89 c7             	mov    %rax,%rdi
    3b29:	4c 29 f7             	sub    %r14,%rdi
    3b2c:	73 61                	jae    3b8f <fwp_gc_chunks+0x8f>
    3b2e:	48 8d 34 d5 68 10 00 	lea    0x1068(,%rdx,8),%rsi
    3b35:	00 
    3b36:	4c 69 c0 28 12 00 00 	imul   $0x1228,%rax,%r8
    3b3d:	4c 03 05 cc 17 01 00 	add    0x117cc(%rip),%r8        # 15310 <fwp_gc+0x1078>
    3b44:	31 d2                	xor    %edx,%edx
    3b46:	45 31 c9             	xor    %r9d,%r9d
    3b49:	eb 17                	jmp    3b62 <fwp_gc_chunks+0x62>
    3b4b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    3b50:	45 31 c9             	xor    %r9d,%r9d
    3b53:	48 ff ca             	dec    %rdx
    3b56:	49 81 c0 28 12 00 00 	add    $0x1228,%r8
    3b5d:	48 39 d7             	cmp    %rdx,%rdi
    3b60:	74 30                	je     3b92 <fwp_gc_chunks+0x92>
    3b62:	41 80 38 00          	cmpb   $0x0,(%r8)
    3b66:	75 e8                	jne    3b50 <fwp_gc_chunks+0x50>
    3b68:	49 ff c1             	inc    %r9
    3b6b:	49 39 d9             	cmp    %rbx,%r9
    3b6e:	75 e3                	jne    3b53 <fwp_gc_chunks+0x53>
    3b70:	48 ff c0             	inc    %rax
    3b73:	48 89 c7             	mov    %rax,%rdi
    3b76:	48 29 d7             	sub    %rdx,%rdi
    3b79:	48 89 3c 0e          	mov    %rdi,(%rsi,%rcx,1)
    3b7d:	48 29 1d f4 18 01 00 	sub    %rbx,0x118f4(%rip)        # 15478 <fwp_gc+0x11e0>
    3b84:	48 29 d8             	sub    %rbx,%rax
    3b87:	48 29 d0             	sub    %rdx,%rax
    3b8a:	49 89 c6             	mov    %rax,%r14
    3b8d:	eb 33                	jmp    3bc2 <fwp_gc_chunks+0xc2>
    3b8f:	45 31 c9             	xor    %r9d,%r9d
    3b92:	4d 29 ce             	sub    %r9,%r14
    3b95:	4c 29 0d dc 18 01 00 	sub    %r9,0x118dc(%rip)        # 15478 <fwp_gc+0x11e0>
    3b9c:	4c 01 f3             	add    %r14,%rbx
    3b9f:	48 89 df             	mov    %rbx,%rdi
    3ba2:	e8 29 00 00 00       	call   3bd0 <fwp_gc_commit>
    3ba7:	48 89 1d 42 17 01 00 	mov    %rbx,0x11742(%rip)        # 152f0 <fwp_gc+0x1058>
    3bae:	48 c1 e3 10          	shl    $0x10,%rbx
    3bb2:	48 3b 1d 27 17 01 00 	cmp    0x11727(%rip),%rbx        # 152e0 <fwp_gc+0x1048>
    3bb9:	76 07                	jbe    3bc2 <fwp_gc_chunks+0xc2>
    3bbb:	48 89 1d 1e 17 01 00 	mov    %rbx,0x1171e(%rip)        # 152e0 <fwp_gc+0x1048>
    3bc2:	4c 89 f0             	mov    %r14,%rax
    3bc5:	48 83 c4 08          	add    $0x8,%rsp
    3bc9:	5b                   	pop    %rbx
    3bca:	41 5e                	pop    %r14
    3bcc:	c3                   	ret
    3bcd:	0f 1f 00             	nopl   (%rax)

0000000000003bd0 <fwp_gc_commit>:
    3bd0:	53                   	push   %rbx
    3bd1:	48 89 fb             	mov    %rdi,%rbx
    3bd4:	48 8b 3d 1d 17 01 00 	mov    0x1171d(%rip),%rdi        # 152f8 <fwp_gc+0x1060>
    3bdb:	48 39 df             	cmp    %rbx,%rdi
    3bde:	0f 83 8f 00 00 00    	jae    3c73 <fwp_gc_commit+0xa3>
    3be4:	48 8b 05 fd 16 01 00 	mov    0x116fd(%rip),%rax        # 152e8 <fwp_gc+0x1050>
    3beb:	48 39 d8             	cmp    %rbx,%rax
    3bee:	0f 82 81 00 00 00    	jb     3c75 <fwp_gc_commit+0xa5>
    3bf4:	48 83 c3 40          	add    $0x40,%rbx
    3bf8:	48 39 c3             	cmp    %rax,%rbx
    3bfb:	48 0f 43 d8          	cmovae %rax,%rbx
    3bff:	48 89 de             	mov    %rbx,%rsi
    3c02:	48 29 fe             	sub    %rdi,%rsi
    3c05:	48 c1 e7 10          	shl    $0x10,%rdi
    3c09:	48 03 3d b8 16 01 00 	add    0x116b8(%rip),%rdi        # 152c8 <fwp_gc+0x1030>
    3c10:	48 c1 e6 10          	shl    $0x10,%rsi
    3c14:	ba 03 00 00 00       	mov    $0x3,%edx
    3c19:	e8 f2 e7 ff ff       	call   2410 <mprotect@plt>
    3c1e:	85 c0                	test   %eax,%eax
    3c20:	75 53                	jne    3c75 <fwp_gc_commit+0xa5>
    3c22:	bf 1e 00 00 00       	mov    $0x1e,%edi
    3c27:	e8 04 e8 ff ff       	call   2430 <sysconf@plt>
    3c2c:	48 8b 0d dd 16 01 00 	mov    0x116dd(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    3c33:	48 69 3d ba 16 01 00 	imul   $0x1228,0x116ba(%rip),%rdi        # 152f8 <fwp_gc+0x1060>
    3c3a:	28 12 00 00 
    3c3e:	48 01 cf             	add    %rcx,%rdi
    3c41:	48 69 d3 28 12 00 00 	imul   $0x1228,%rbx,%rdx
    3c48:	48 01 ca             	add    %rcx,%rdx
    3c4b:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    3c4f:	48 ff ce             	dec    %rsi
    3c52:	48 f7 d8             	neg    %rax
    3c55:	48 21 c7             	and    %rax,%rdi
    3c58:	48 21 c6             	and    %rax,%rsi
    3c5b:	48 29 fe             	sub    %rdi,%rsi
    3c5e:	ba 03 00 00 00       	mov    $0x3,%edx
    3c63:	e8 a8 e7 ff ff       	call   2410 <mprotect@plt>
    3c68:	85 c0                	test   %eax,%eax
    3c6a:	75 09                	jne    3c75 <fwp_gc_commit+0xa5>
    3c6c:	48 89 1d 85 16 01 00 	mov    %rbx,0x11685(%rip)        # 152f8 <fwp_gc+0x1060>
    3c73:	5b                   	pop    %rbx
    3c74:	c3                   	ret
    3c75:	e8 56 fe ff ff       	call   3ad0 <fwp_gc_oom>
    3c7a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000003c80 <fwp_gc_collect>:
    3c80:	83 3d 09 16 01 00 00 	cmpl   $0x0,0x11609(%rip)        # 15290 <fwp_gc+0xff8>
    3c87:	74 01                	je     3c8a <fwp_gc_collect+0xa>
    3c89:	c3                   	ret
    3c8a:	55                   	push   %rbp
    3c8b:	48 89 e5             	mov    %rsp,%rbp
    3c8e:	41 57                	push   %r15
    3c90:	41 56                	push   %r14
    3c92:	41 55                	push   %r13
    3c94:	41 54                	push   %r12
    3c96:	53                   	push   %rbx
    3c97:	48 81 ec e8 00 00 00 	sub    $0xe8,%rsp
    3c9e:	c7 05 e8 15 01 00 01 	movl   $0x1,0x115e8(%rip)        # 15290 <fwp_gc+0xff8>
    3ca5:	00 00 00 
    3ca8:	48 8d 75 b8          	lea    -0x48(%rbp),%rsi
    3cac:	bf 01 00 00 00       	mov    $0x1,%edi
    3cb1:	e8 7a e4 ff ff       	call   2130 <clock_gettime@plt>
    3cb6:	48 8b 05 eb 17 01 00 	mov    0x117eb(%rip),%rax        # 154a8 <fwp_gc+0x1210>
    3cbd:	48 2b 05 d4 05 01 00 	sub    0x105d4(%rip),%rax        # 14298 <fwp_gc>
    3cc4:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    3cc9:	f2 0f 58 05 af 17 01 	addsd  0x117af(%rip),%xmm0        # 15480 <fwp_gc+0x11e8>
    3cd0:	00 
    3cd1:	f2 0f 11 05 a7 17 01 	movsd  %xmm0,0x117a7(%rip)        # 15480 <fwp_gc+0x11e8>
    3cd8:	00 
    3cd9:	83 3d b8 15 01 00 00 	cmpl   $0x0,0x115b8(%rip)        # 15298 <fwp_gc+0x1000>
    3ce0:	0f 94 c0             	sete   %al
    3ce3:	83 3d b6 15 01 00 00 	cmpl   $0x0,0x115b6(%rip)        # 152a0 <fwp_gc+0x1008>
    3cea:	0f 95 c3             	setne  %bl
    3ced:	08 c3                	or     %al,%bl
    3cef:	80 fb 01             	cmp    $0x1,%bl
    3cf2:	75 3e                	jne    3d32 <fwp_gc_collect+0xb2>
    3cf4:	e8 b7 01 00 00       	call   3eb0 <fwp_gc_clear_marks>
    3cf9:	48 8d bd f0 fe ff ff 	lea    -0x110(%rbp),%rdi
    3d00:	e8 ab e5 ff ff       	call   22b0 <_setjmp@plt>
    3d05:	48 c7 05 88 17 01 00 	movq   $0x0,0x11788(%rip)        # 15498 <fwp_gc+0x1200>
    3d0c:	00 00 00 00 
    3d10:	e8 1b 02 00 00       	call   3f30 <fwp_gc_mark_all>
    3d15:	e8 36 07 00 00       	call   4450 <fwp_gc_finalize>
    3d1a:	e8 c1 07 00 00       	call   44e0 <fwp_gc_sweep>
    3d1f:	48 8b 05 4a 17 01 00 	mov    0x1174a(%rip),%rax        # 15470 <fwp_gc+0x11d8>
    3d26:	48 ff c0             	inc    %rax
    3d29:	48 89 05 40 17 01 00 	mov    %rax,0x11740(%rip)        # 15470 <fwp_gc+0x11d8>
    3d30:	eb 51                	jmp    3d83 <fwp_gc_collect+0x103>
    3d32:	48 8d bd f0 fe ff ff 	lea    -0x110(%rbp),%rdi
    3d39:	e8 72 e5 ff ff       	call   22b0 <_setjmp@plt>
    3d3e:	48 c7 05 4f 17 01 00 	movq   $0x0,0x1174f(%rip)        # 15498 <fwp_gc+0x1200>
    3d45:	00 00 00 00 
    3d49:	e8 e2 01 00 00       	call   3f30 <fwp_gc_mark_all>
    3d4e:	e8 fd 01 00 00       	call   3f50 <fwp_gc_scan_old_filled>
    3d53:	83 3d 42 15 01 00 00 	cmpl   $0x0,0x11542(%rip)        # 1529c <fwp_gc+0x1004>
    3d5a:	74 05                	je     3d61 <fwp_gc_collect+0xe1>
    3d5c:	e8 2f 03 00 00       	call   4090 <fwp_gc_verify_minor>
    3d61:	e8 ea 06 00 00       	call   4450 <fwp_gc_finalize>
    3d66:	e8 75 07 00 00       	call   44e0 <fwp_gc_sweep>
    3d6b:	48 8b 05 fe 16 01 00 	mov    0x116fe(%rip),%rax        # 15470 <fwp_gc+0x11d8>
    3d72:	48 ff c0             	inc    %rax
    3d75:	48 89 05 f4 16 01 00 	mov    %rax,0x116f4(%rip)        # 15470 <fwp_gc+0x11d8>
    3d7c:	48 ff 05 2d 15 01 00 	incq   0x1152d(%rip)        # 152b0 <fwp_gc+0x1018>
    3d83:	48 89 c1             	mov    %rax,%rcx
    3d86:	48 8b 05 d3 16 01 00 	mov    0x116d3(%rip),%rax        # 15460 <fwp_gc+0x11c8>
    3d8d:	48 3b 05 d4 16 01 00 	cmp    0x116d4(%rip),%rax        # 15468 <fwp_gc+0x11d0>
    3d94:	76 07                	jbe    3d9d <fwp_gc_collect+0x11d>
    3d96:	48 89 05 cb 16 01 00 	mov    %rax,0x116cb(%rip)        # 15468 <fwp_gc+0x11d0>
    3d9d:	84 db                	test   %bl,%bl
    3d9f:	74 0b                	je     3dac <fwp_gc_collect+0x12c>
    3da1:	48 89 05 00 15 01 00 	mov    %rax,0x11500(%rip)        # 152a8 <fwp_gc+0x1010>
    3da8:	31 d2                	xor    %edx,%edx
    3daa:	eb 2d                	jmp    3dd9 <fwp_gc_collect+0x159>
    3dac:	48 8b 15 f5 14 01 00 	mov    0x114f5(%rip),%rdx        # 152a8 <fwp_gc+0x1010>
    3db3:	48 89 d6             	mov    %rdx,%rsi
    3db6:	48 d1 ee             	shr    $1,%rsi
    3db9:	48 01 d6             	add    %rdx,%rsi
    3dbc:	48 81 fe 01 00 00 01 	cmp    $0x1000001,%rsi
    3dc3:	ba 00 00 00 01       	mov    $0x1000000,%edx
    3dc8:	48 0f 43 d6          	cmovae %rsi,%rdx
    3dcc:	31 f6                	xor    %esi,%esi
    3dce:	48 39 d0             	cmp    %rdx,%rax
    3dd1:	0f 97 c2             	seta   %dl
    3dd4:	40 88 d6             	mov    %dl,%sil
    3dd7:	89 f2                	mov    %esi,%edx
    3dd9:	f6 c1 07             	test   $0x7,%cl
    3ddc:	b9 01 00 00 00       	mov    $0x1,%ecx
    3de1:	0f 45 ca             	cmovne %edx,%ecx
    3de4:	48 83 3d cc 14 01 00 	cmpq   $0x0,0x114cc(%rip)        # 152b8 <fwp_gc+0x1020>
    3deb:	00 
    3dec:	0f 44 ca             	cmove  %edx,%ecx
    3def:	89 0d ab 14 01 00    	mov    %ecx,0x114ab(%rip)        # 152a0 <fwp_gc+0x1008>
    3df5:	83 3d 9c 14 01 00 00 	cmpl   $0x0,0x1149c(%rip)        # 15298 <fwp_gc+0x1000>
    3dfc:	0f 94 c1             	sete   %cl
    3dff:	48 d3 e0             	shl    %cl,%rax
    3e02:	f2 48 0f 2c 0d 8d 16 	cvttsd2si 0x1168d(%rip),%rcx        # 15498 <fwp_gc+0x1200>
    3e09:	01 00 
    3e0b:	48 01 c1             	add    %rax,%rcx
    3e0e:	48 81 f9 01 00 80 00 	cmp    $0x800001,%rcx
    3e15:	b8 00 00 80 00       	mov    $0x800000,%eax
    3e1a:	48 0f 4d c1          	cmovge %rcx,%rax
    3e1e:	48 89 05 83 16 01 00 	mov    %rax,0x11683(%rip)        # 154a8 <fwp_gc+0x1210>
    3e25:	48 89 05 6c 04 01 00 	mov    %rax,0x1046c(%rip)        # 14298 <fwp_gc>
    3e2c:	48 8d 75 c8          	lea    -0x38(%rbp),%rsi
    3e30:	bf 01 00 00 00       	mov    $0x1,%edi
    3e35:	e8 f6 e2 ff ff       	call   2130 <clock_gettime@plt>
    3e3a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    3e3e:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
    3e42:	48 2b 45 b8          	sub    -0x48(%rbp),%rax
    3e46:	f2 48 0f 2a c8       	cvtsi2sd %rax,%xmm1
    3e4b:	f2 0f 59 0d fd a2 00 	mulsd  0xa2fd(%rip),%xmm1        # e150 <_IO_stdin_used+0x150>
    3e52:	00 
    3e53:	48 2b 4d c0          	sub    -0x40(%rbp),%rcx
    3e57:	0f 57 c0             	xorps  %xmm0,%xmm0
    3e5a:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    3e5f:	f2 0f 5e 05 f1 a2 00 	divsd  0xa2f1(%rip),%xmm0        # e158 <_IO_stdin_used+0x158>
    3e66:	00 
    3e67:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
    3e6b:	f2 0f 10 0d 15 16 01 	movsd  0x11615(%rip),%xmm1        # 15488 <fwp_gc+0x11f0>
    3e72:	00 
    3e73:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
    3e77:	f2 0f 11 0d 09 16 01 	movsd  %xmm1,0x11609(%rip)        # 15488 <fwp_gc+0x11f0>
    3e7e:	00 
    3e7f:	66 0f 2e 05 09 16 01 	ucomisd 0x11609(%rip),%xmm0        # 15490 <fwp_gc+0x11f8>
    3e86:	00 
    3e87:	48 8d a4 24 e8 00 00 	lea    0xe8(%rsp),%rsp
    3e8e:	00 
    3e8f:	5b                   	pop    %rbx
    3e90:	41 5c                	pop    %r12
    3e92:	41 5d                	pop    %r13
    3e94:	41 5e                	pop    %r14
    3e96:	41 5f                	pop    %r15
    3e98:	5d                   	pop    %rbp
    3e99:	76 08                	jbe    3ea3 <fwp_gc_collect+0x223>
    3e9b:	f2 0f 11 05 ed 15 01 	movsd  %xmm0,0x115ed(%rip)        # 15490 <fwp_gc+0x11f8>
    3ea2:	00 
    3ea3:	c7 05 e3 13 01 00 00 	movl   $0x0,0x113e3(%rip)        # 15290 <fwp_gc+0xff8>
    3eaa:	00 00 00 
    3ead:	c3                   	ret
    3eae:	66 90                	xchg   %ax,%ax

0000000000003eb0 <fwp_gc_clear_marks>:
    3eb0:	48 8b 05 39 14 01 00 	mov    0x11439(%rip),%rax        # 152f0 <fwp_gc+0x1058>
    3eb7:	48 85 c0             	test   %rax,%rax
    3eba:	74 69                	je     3f25 <fwp_gc_clear_marks+0x75>
    3ebc:	41 56                	push   %r14
    3ebe:	53                   	push   %rbx
    3ebf:	50                   	push   %rax
    3ec0:	48 8b 0d 49 14 01 00 	mov    0x11449(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    3ec7:	31 db                	xor    %ebx,%ebx
    3ec9:	45 31 f6             	xor    %r14d,%r14d
    3ecc:	eb 16                	jmp    3ee4 <fwp_gc_clear_marks+0x34>
    3ece:	66 90                	xchg   %ax,%ax
    3ed0:	c6 44 19 03 00       	movb   $0x0,0x3(%rcx,%rbx,1)
    3ed5:	49 ff c6             	inc    %r14
    3ed8:	48 81 c3 28 12 00 00 	add    $0x1228,%rbx
    3edf:	49 39 c6             	cmp    %rax,%r14
    3ee2:	73 3a                	jae    3f1e <fwp_gc_clear_marks+0x6e>
    3ee4:	0f b6 14 19          	movzbl (%rcx,%rbx,1),%edx
    3ee8:	83 fa 02             	cmp    $0x2,%edx
    3eeb:	74 e3                	je     3ed0 <fwp_gc_clear_marks+0x20>
    3eed:	83 fa 01             	cmp    $0x1,%edx
    3ef0:	75 e3                	jne    3ed5 <fwp_gc_clear_marks+0x25>
    3ef2:	48 8d 3c 19          	lea    (%rcx,%rbx,1),%rdi
    3ef6:	48 83 c7 28          	add    $0x28,%rdi
    3efa:	8b 54 19 0c          	mov    0xc(%rcx,%rbx,1),%edx
    3efe:	83 c2 3f             	add    $0x3f,%edx
    3f01:	c1 ea 03             	shr    $0x3,%edx
    3f04:	83 e2 f8             	and    $0xfffffff8,%edx
    3f07:	31 f6                	xor    %esi,%esi
    3f09:	e8 02 e3 ff ff       	call   2210 <memset@plt>
    3f0e:	48 8b 0d fb 13 01 00 	mov    0x113fb(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    3f15:	48 8b 05 d4 13 01 00 	mov    0x113d4(%rip),%rax        # 152f0 <fwp_gc+0x1058>
    3f1c:	eb b7                	jmp    3ed5 <fwp_gc_clear_marks+0x25>
    3f1e:	48 83 c4 08          	add    $0x8,%rsp
    3f22:	5b                   	pop    %rbx
    3f23:	41 5e                	pop    %r14
    3f25:	c3                   	ret
    3f26:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    3f2d:	00 00 00 

0000000000003f30 <fwp_gc_mark_all>:
    3f30:	50                   	push   %rax
    3f31:	e8 4a 0c 00 00       	call   4b80 <fwp_gc_sp>
    3f36:	48 89 c7             	mov    %rax,%rdi
    3f39:	e8 32 0c 00 00       	call   4b70 <fwp_gc_scan_stacks>
    3f3e:	e8 4d 0c 00 00       	call   4b90 <fwp_gc_drain>
    3f43:	e8 98 0c 00 00       	call   4be0 <fwp_gc_scan_data>
    3f48:	58                   	pop    %rax
    3f49:	e9 42 0c 00 00       	jmp    4b90 <fwp_gc_drain>
    3f4e:	66 90                	xchg   %ax,%ax

0000000000003f50 <fwp_gc_scan_old_filled>:
    3f50:	48 83 3d 98 13 01 00 	cmpq   $0x0,0x11398(%rip)        # 152f0 <fwp_gc+0x1058>
    3f57:	00 
    3f58:	0f 84 32 0c 00 00    	je     4b90 <fwp_gc_drain>
    3f5e:	55                   	push   %rbp
    3f5f:	41 57                	push   %r15
    3f61:	41 56                	push   %r14
    3f63:	41 55                	push   %r13
    3f65:	41 54                	push   %r12
    3f67:	53                   	push   %rbx
    3f68:	48 83 ec 18          	sub    $0x18,%rsp
    3f6c:	31 c0                	xor    %eax,%eax
    3f6e:	eb 14                	jmp    3f84 <fwp_gc_scan_old_filled+0x34>
    3f70:	48 8b 04 24          	mov    (%rsp),%rax
    3f74:	48 ff c0             	inc    %rax
    3f77:	48 3b 05 72 13 01 00 	cmp    0x11372(%rip),%rax        # 152f0 <fwp_gc+0x1058>
    3f7e:	0f 83 f6 00 00 00    	jae    407a <fwp_gc_scan_old_filled+0x12a>
    3f84:	48 8b 0d 85 13 01 00 	mov    0x11385(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    3f8b:	48 89 04 24          	mov    %rax,(%rsp)
    3f8f:	48 69 e8 28 12 00 00 	imul   $0x1228,%rax,%rbp
    3f96:	80 7c 29 01 02       	cmpb   $0x2,0x1(%rcx,%rbp,1)
    3f9b:	75 d3                	jne    3f70 <fwp_gc_scan_old_filled+0x20>
    3f9d:	48 89 cb             	mov    %rcx,%rbx
    3fa0:	0f b6 04 29          	movzbl (%rcx,%rbp,1),%eax
    3fa4:	83 f8 02             	cmp    $0x2,%eax
    3fa7:	0f 84 a7 00 00 00    	je     4054 <fwp_gc_scan_old_filled+0x104>
    3fad:	83 f8 01             	cmp    $0x1,%eax
    3fb0:	75 be                	jne    3f70 <fwp_gc_scan_old_filled+0x20>
    3fb2:	48 8b 3c 24          	mov    (%rsp),%rdi
    3fb6:	e8 55 ef ff ff       	call   2f10 <fwp_gc_chunk_addr>
    3fbb:	49 89 c6             	mov    %rax,%r14
    3fbe:	8b 44 2b 0c          	mov    0xc(%rbx,%rbp,1),%eax
    3fc2:	83 c0 3f             	add    $0x3f,%eax
    3fc5:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    3fca:	83 f8 40             	cmp    $0x40,%eax
    3fcd:	72 a1                	jb     3f70 <fwp_gc_scan_old_filled+0x20>
    3fcf:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    3fd4:	c1 e8 06             	shr    $0x6,%eax
    3fd7:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    3fdc:	4c 8d 2c 2b          	lea    (%rbx,%rbp,1),%r13
    3fe0:	49 83 c5 08          	add    $0x8,%r13
    3fe4:	48 01 eb             	add    %rbp,%rbx
    3fe7:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
    3fec:	45 31 ff             	xor    %r15d,%r15d
    3fef:	eb 1d                	jmp    400e <fwp_gc_scan_old_filled+0xbe>
    3ff1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3ff8:	0f 1f 84 00 00 00 00 
    3fff:	00 
    4000:	49 ff c7             	inc    %r15
    4003:	4c 3b 7c 24 08       	cmp    0x8(%rsp),%r15
    4008:	0f 84 62 ff ff ff    	je     3f70 <fwp_gc_scan_old_filled+0x20>
    400e:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    4013:	4e 8b 64 f8 28       	mov    0x28(%rax,%r15,8),%r12
    4018:	4d 85 e4             	test   %r12,%r12
    401b:	74 e3                	je     4000 <fwp_gc_scan_old_filled+0xb0>
    401d:	4c 89 fd             	mov    %r15,%rbp
    4020:	48 c1 e5 06          	shl    $0x6,%rbp
    4024:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    402b:	00 00 00 00 00 
    4030:	f3 49 0f bc fc       	tzcnt  %r12,%rdi
    4035:	48 09 ef             	or     %rbp,%rdi
    4038:	49 8d 5c 24 ff       	lea    -0x1(%r12),%rbx
    403d:	41 8b 75 00          	mov    0x0(%r13),%esi
    4041:	48 0f af fe          	imul   %rsi,%rdi
    4045:	4c 01 f7             	add    %r14,%rdi
    4048:	e8 03 0e 00 00       	call   4e50 <fwp_gc_push>
    404d:	49 21 dc             	and    %rbx,%r12
    4050:	75 de                	jne    4030 <fwp_gc_scan_old_filled+0xe0>
    4052:	eb ac                	jmp    4000 <fwp_gc_scan_old_filled+0xb0>
    4054:	80 7c 2b 03 00       	cmpb   $0x0,0x3(%rbx,%rbp,1)
    4059:	0f 84 11 ff ff ff    	je     3f70 <fwp_gc_scan_old_filled+0x20>
    405f:	48 8b 3c 24          	mov    (%rsp),%rdi
    4063:	e8 a8 ee ff ff       	call   2f10 <fwp_gc_chunk_addr>
    4068:	48 8b 74 2b 18       	mov    0x18(%rbx,%rbp,1),%rsi
    406d:	48 89 c7             	mov    %rax,%rdi
    4070:	e8 db 0d 00 00       	call   4e50 <fwp_gc_push>
    4075:	e9 f6 fe ff ff       	jmp    3f70 <fwp_gc_scan_old_filled+0x20>
    407a:	48 83 c4 18          	add    $0x18,%rsp
    407e:	5b                   	pop    %rbx
    407f:	41 5c                	pop    %r12
    4081:	41 5d                	pop    %r13
    4083:	41 5e                	pop    %r14
    4085:	41 5f                	pop    %r15
    4087:	5d                   	pop    %rbp
    4088:	e9 03 0b 00 00       	jmp    4b90 <fwp_gc_drain>
    408d:	0f 1f 00             	nopl   (%rax)

0000000000004090 <fwp_gc_verify_minor>:
    4090:	55                   	push   %rbp
    4091:	41 57                	push   %r15
    4093:	41 56                	push   %r14
    4095:	41 55                	push   %r13
    4097:	41 54                	push   %r12
    4099:	53                   	push   %rbx
    409a:	48 83 ec 58          	sub    $0x58,%rsp
    409e:	4c 8b 2d 4b 12 01 00 	mov    0x1124b(%rip),%r13        # 152f0 <fwp_gc+0x1058>
    40a5:	4c 89 ef             	mov    %r13,%rdi
    40a8:	48 c1 e7 09          	shl    $0x9,%rdi
    40ac:	e8 8f e2 ff ff       	call   2340 <malloc@plt>
    40b1:	48 89 c3             	mov    %rax,%rbx
    40b4:	49 83 fd 01          	cmp    $0x1,%r13
    40b8:	4c 89 ef             	mov    %r13,%rdi
    40bb:	48 83 d7 00          	adc    $0x0,%rdi
    40bf:	48 89 7c 24 30       	mov    %rdi,0x30(%rsp)
    40c4:	e8 77 e2 ff ff       	call   2340 <malloc@plt>
    40c9:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
    40ce:	48 85 db             	test   %rbx,%rbx
    40d1:	0f 84 74 03 00 00    	je     444b <fwp_gc_verify_minor+0x3bb>
    40d7:	49 89 c7             	mov    %rax,%r15
    40da:	48 85 c0             	test   %rax,%rax
    40dd:	0f 84 68 03 00 00    	je     444b <fwp_gc_verify_minor+0x3bb>
    40e3:	4d 85 ed             	test   %r13,%r13
    40e6:	74 1c                	je     4104 <fwp_gc_verify_minor+0x74>
    40e8:	48 8b 0d 21 12 01 00 	mov    0x11221(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    40ef:	49 83 fd 01          	cmp    $0x1,%r13
    40f3:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
    40f8:	75 19                	jne    4113 <fwp_gc_verify_minor+0x83>
    40fa:	4d 89 ec             	mov    %r13,%r12
    40fd:	31 ed                	xor    %ebp,%ebp
    40ff:	e9 81 00 00 00       	jmp    4185 <fwp_gc_verify_minor+0xf5>
    4104:	e8 a7 fd ff ff       	call   3eb0 <fwp_gc_clear_marks>
    4109:	e8 22 fe ff ff       	call   3f30 <fwp_gc_mark_all>
    410e:	e9 13 03 00 00       	jmp    4426 <fwp_gc_verify_minor+0x396>
    4113:	4d 89 ec             	mov    %r13,%r12
    4116:	49 83 e5 fe          	and    $0xfffffffffffffffe,%r13
    411a:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    411f:	48 8d 98 00 02 00 00 	lea    0x200(%rax),%rbx
    4126:	4c 8d b1 50 12 00 00 	lea    0x1250(%rcx),%r14
    412d:	31 ed                	xor    %ebp,%ebp
    412f:	90                   	nop
    4130:	48 8d bb 00 fe ff ff 	lea    -0x200(%rbx),%rdi
    4137:	49 8d b6 d8 ed ff ff 	lea    -0x1228(%r14),%rsi
    413e:	ba 00 02 00 00       	mov    $0x200,%edx
    4143:	e8 e8 e1 ff ff       	call   2330 <memcpy@plt>
    4148:	41 0f b6 86 b3 ed ff 	movzbl -0x124d(%r14),%eax
    414f:	ff 
    4150:	41 88 04 2f          	mov    %al,(%r15,%rbp,1)
    4154:	ba 00 02 00 00       	mov    $0x200,%edx
    4159:	48 89 df             	mov    %rbx,%rdi
    415c:	4c 89 f6             	mov    %r14,%rsi
    415f:	e8 cc e1 ff ff       	call   2330 <memcpy@plt>
    4164:	41 0f b6 46 db       	movzbl -0x25(%r14),%eax
    4169:	41 88 44 2f 01       	mov    %al,0x1(%r15,%rbp,1)
    416e:	48 83 c5 02          	add    $0x2,%rbp
    4172:	48 81 c3 00 04 00 00 	add    $0x400,%rbx
    4179:	49 81 c6 50 24 00 00 	add    $0x2450,%r14
    4180:	49 39 ed             	cmp    %rbp,%r13
    4183:	75 ab                	jne    4130 <fwp_gc_verify_minor+0xa0>
    4185:	4d 89 e5             	mov    %r12,%r13
    4188:	41 f6 c5 01          	test   $0x1,%r13b
    418c:	74 34                	je     41c2 <fwp_gc_verify_minor+0x132>
    418e:	48 89 ef             	mov    %rbp,%rdi
    4191:	48 c1 e7 09          	shl    $0x9,%rdi
    4195:	48 03 7c 24 20       	add    0x20(%rsp),%rdi
    419a:	48 69 dd 28 12 00 00 	imul   $0x1228,%rbp,%rbx
    41a1:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    41a6:	49 8d 34 1e          	lea    (%r14,%rbx,1),%rsi
    41aa:	48 83 c6 28          	add    $0x28,%rsi
    41ae:	ba 00 02 00 00       	mov    $0x200,%edx
    41b3:	e8 78 e1 ff ff       	call   2330 <memcpy@plt>
    41b8:	41 0f b6 44 1e 03    	movzbl 0x3(%r14,%rbx,1),%eax
    41be:	41 88 04 2f          	mov    %al,(%r15,%rbp,1)
    41c2:	e8 e9 fc ff ff       	call   3eb0 <fwp_gc_clear_marks>
    41c7:	e8 64 fd ff ff       	call   3f30 <fwp_gc_mark_all>
    41cc:	4d 85 ed             	test   %r13,%r13
    41cf:	0f 84 51 02 00 00    	je     4426 <fwp_gc_verify_minor+0x396>
    41d5:	48 8b 1d 34 11 01 00 	mov    0x11134(%rip),%rbx        # 15310 <fwp_gc+0x1078>
    41dc:	48 8d 43 28          	lea    0x28(%rbx),%rax
    41e0:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    41e5:	31 ff                	xor    %edi,%edi
    41e7:	eb 30                	jmp    4219 <fwp_gc_verify_minor+0x189>
    41e9:	4d 85 c9             	test   %r9,%r9
    41ec:	0f 85 b8 00 00 00    	jne    42aa <fwp_gc_verify_minor+0x21a>
    41f2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    41f9:	1f 84 00 00 00 00 00 
    4200:	48 ff c7             	inc    %rdi
    4203:	48 81 c1 00 02 00 00 	add    $0x200,%rcx
    420a:	48 05 28 12 00 00    	add    $0x1228,%rax
    4210:	4c 39 ef             	cmp    %r13,%rdi
    4213:	0f 84 0d 02 00 00    	je     4426 <fwp_gc_verify_minor+0x396>
    4219:	4c 69 f7 28 12 00 00 	imul   $0x1228,%rdi,%r14
    4220:	42 0f b6 2c 33       	movzbl (%rbx,%r14,1),%ebp
    4225:	83 fd 02             	cmp    $0x2,%ebp
    4228:	74 66                	je     4290 <fwp_gc_verify_minor+0x200>
    422a:	83 fd 01             	cmp    $0x1,%ebp
    422d:	75 d1                	jne    4200 <fwp_gc_verify_minor+0x170>
    422f:	42 8b 54 33 0c       	mov    0xc(%rbx,%r14,1),%edx
    4234:	83 c2 3f             	add    $0x3f,%edx
    4237:	83 fa 40             	cmp    $0x40,%edx
    423a:	72 c4                	jb     4200 <fwp_gc_verify_minor+0x170>
    423c:	c1 ea 06             	shr    $0x6,%edx
    423f:	31 f6                	xor    %esi,%esi
    4241:	45 31 e4             	xor    %r12d,%r12d
    4244:	45 31 c0             	xor    %r8d,%r8d
    4247:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    424e:	00 00 
    4250:	4e 8b 0c c1          	mov    (%rcx,%r8,8),%r9
    4254:	49 f7 d1             	not    %r9
    4257:	4e 23 0c c0          	and    (%rax,%r8,8),%r9
    425b:	4d 89 e2             	mov    %r12,%r10
    425e:	f3 4d 0f bc e1       	tzcnt  %r9,%r12
    4263:	49 01 f4             	add    %rsi,%r12
    4266:	4d 85 c9             	test   %r9,%r9
    4269:	4d 0f 44 e2          	cmove  %r10,%r12
    426d:	49 ff c0             	inc    %r8
    4270:	49 39 d0             	cmp    %rdx,%r8
    4273:	0f 83 70 ff ff ff    	jae    41e9 <fwp_gc_verify_minor+0x159>
    4279:	48 83 c6 40          	add    $0x40,%rsi
    427d:	4d 85 c9             	test   %r9,%r9
    4280:	74 ce                	je     4250 <fwp_gc_verify_minor+0x1c0>
    4282:	e9 62 ff ff ff       	jmp    41e9 <fwp_gc_verify_minor+0x159>
    4287:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    428e:	00 00 
    4290:	42 80 7c 33 03 00    	cmpb   $0x0,0x3(%rbx,%r14,1)
    4296:	0f 84 64 ff ff ff    	je     4200 <fwp_gc_verify_minor+0x170>
    429c:	41 80 3c 3f 00       	cmpb   $0x0,(%r15,%rdi,1)
    42a1:	0f 85 59 ff ff ff    	jne    4200 <fwp_gc_verify_minor+0x170>
    42a7:	45 31 e4             	xor    %r12d,%r12d
    42aa:	e8 61 ec ff ff       	call   2f10 <fwp_gc_chunk_addr>
    42af:	46 8b 7c 33 08       	mov    0x8(%rbx,%r14,1),%r15d
    42b4:	4d 0f af e7          	imul   %r15,%r12
    42b8:	49 01 c4             	add    %rax,%r12
    42bb:	40 80 fd 01          	cmp    $0x1,%bpl
    42bf:	74 05                	je     42c6 <fwp_gc_verify_minor+0x236>
    42c1:	4e 8b 7c 33 18       	mov    0x18(%rbx,%r14,1),%r15
    42c6:	48 8b 05 13 fd 00 00 	mov    0xfd13(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    42cd:	48 8b 38             	mov    (%rax),%rdi
    42d0:	42 0f b6 4c 33 01    	movzbl 0x1(%rbx,%r14,1),%ecx
    42d6:	48 8d 35 aa a4 00 00 	lea    0xa4aa(%rip),%rsi        # e787 <exec_in_fp0+0x137>
    42dd:	4c 89 e2             	mov    %r12,%rdx
    42e0:	4d 89 f8             	mov    %r15,%r8
    42e3:	31 c0                	xor    %eax,%eax
    42e5:	e8 06 e0 ff ff       	call   22f0 <fprintf@plt>
    42ea:	4d 01 e7             	add    %r12,%r15
    42ed:	45 31 ed             	xor    %r13d,%r13d
    42f0:	4c 89 7c 24 40       	mov    %r15,0x40(%rsp)
    42f5:	eb 17                	jmp    430e <fwp_gc_verify_minor+0x27e>
    42f7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    42fe:	00 00 
    4300:	49 ff c5             	inc    %r13
    4303:	4c 3b 6c 24 30       	cmp    0x30(%rsp),%r13
    4308:	0f 84 38 01 00 00    	je     4446 <fwp_gc_verify_minor+0x3b6>
    430e:	48 8b 05 fb 0f 01 00 	mov    0x10ffb(%rip),%rax        # 15310 <fwp_gc+0x1078>
    4315:	49 69 cd 28 12 00 00 	imul   $0x1228,%r13,%rcx
    431c:	80 3c 08 01          	cmpb   $0x1,(%rax,%rcx,1)
    4320:	75 de                	jne    4300 <fwp_gc_verify_minor+0x270>
    4322:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    4327:	74 d7                	je     4300 <fwp_gc_verify_minor+0x270>
    4329:	8b 5c 08 0c          	mov    0xc(%rax,%rcx,1),%ebx
    432d:	85 db                	test   %ebx,%ebx
    432f:	74 cf                	je     4300 <fwp_gc_verify_minor+0x270>
    4331:	48 01 c8             	add    %rcx,%rax
    4334:	48 ff c0             	inc    %rax
    4337:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    433c:	4c 89 e8             	mov    %r13,%rax
    433f:	48 c1 e0 09          	shl    $0x9,%rax
    4343:	48 03 44 24 20       	add    0x20(%rsp),%rax
    4348:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    434d:	31 ed                	xor    %ebp,%ebp
    434f:	4c 89 6c 24 38       	mov    %r13,0x38(%rsp)
    4354:	eb 21                	jmp    4377 <fwp_gc_verify_minor+0x2e7>
    4356:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    435d:	00 00 00 
    4360:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    4365:	8b 58 0b             	mov    0xb(%rax),%ebx
    4368:	4c 8b 6c 24 38       	mov    0x38(%rsp),%r13
    436d:	48 ff c5             	inc    %rbp
    4370:	89 d8                	mov    %ebx,%eax
    4372:	48 39 c5             	cmp    %rax,%rbp
    4375:	73 89                	jae    4300 <fwp_gc_verify_minor+0x270>
    4377:	48 89 e8             	mov    %rbp,%rax
    437a:	48 c1 e8 06          	shr    $0x6,%rax
    437e:	48 8b 4c 24 50       	mov    0x50(%rsp),%rcx
    4383:	48 8b 04 c1          	mov    (%rcx,%rax,8),%rax
    4387:	48 0f a3 e8          	bt     %rbp,%rax
    438b:	73 e0                	jae    436d <fwp_gc_verify_minor+0x2dd>
    438d:	4c 89 ef             	mov    %r13,%rdi
    4390:	e8 7b eb ff ff       	call   2f10 <fwp_gc_chunk_addr>
    4395:	48 89 c2             	mov    %rax,%rdx
    4398:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    439d:	44 8b 70 07          	mov    0x7(%rax),%r14d
    43a1:	49 83 fe 08          	cmp    $0x8,%r14
    43a5:	72 c6                	jb     436d <fwp_gc_verify_minor+0x2dd>
    43a7:	45 89 f0             	mov    %r14d,%r8d
    43aa:	4c 0f af f5          	imul   %rbp,%r14
    43ae:	48 89 d3             	mov    %rdx,%rbx
    43b1:	4c 01 f3             	add    %r14,%rbx
    43b4:	45 31 ed             	xor    %r13d,%r13d
    43b7:	48 89 54 24 48       	mov    %rdx,0x48(%rsp)
    43bc:	eb 10                	jmp    43ce <fwp_gc_verify_minor+0x33e>
    43be:	66 90                	xchg   %ax,%ax
    43c0:	49 ff c5             	inc    %r13
    43c3:	44 89 c0             	mov    %r8d,%eax
    43c6:	c1 e8 03             	shr    $0x3,%eax
    43c9:	49 39 c5             	cmp    %rax,%r13
    43cc:	73 92                	jae    4360 <fwp_gc_verify_minor+0x2d0>
    43ce:	4a 8b 04 eb          	mov    (%rbx,%r13,8),%rax
    43d2:	4c 39 e0             	cmp    %r12,%rax
    43d5:	72 e9                	jb     43c0 <fwp_gc_verify_minor+0x330>
    43d7:	4c 39 f8             	cmp    %r15,%rax
    43da:	73 e4                	jae    43c0 <fwp_gc_verify_minor+0x330>
    43dc:	48 8b 05 fd fb 00 00 	mov    0xfbfd(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    43e3:	48 8b 38             	mov    (%rax),%rdi
    43e6:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
    43eb:	41 0f b6 0f          	movzbl (%r15),%ecx
    43ef:	42 0f 10 04 32       	movups (%rdx,%r14,1),%xmm0
    43f4:	4a 8b 44 32 10       	mov    0x10(%rdx,%r14,1),%rax
    43f9:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    43fe:	0f 11 04 24          	movups %xmm0,(%rsp)
    4402:	48 8d 35 d8 a3 00 00 	lea    0xa3d8(%rip),%rsi        # e7e1 <exec_in_fp0+0x191>
    4409:	48 89 da             	mov    %rbx,%rdx
    440c:	4d 89 e9             	mov    %r13,%r9
    440f:	31 c0                	xor    %eax,%eax
    4411:	e8 da de ff ff       	call   22f0 <fprintf@plt>
    4416:	48 8b 54 24 48       	mov    0x48(%rsp),%rdx
    441b:	45 8b 47 07          	mov    0x7(%r15),%r8d
    441f:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
    4424:	eb 9a                	jmp    43c0 <fwp_gc_verify_minor+0x330>
    4426:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    442b:	e8 20 dc ff ff       	call   2050 <free@plt>
    4430:	4c 89 ff             	mov    %r15,%rdi
    4433:	48 83 c4 58          	add    $0x58,%rsp
    4437:	5b                   	pop    %rbx
    4438:	41 5c                	pop    %r12
    443a:	41 5d                	pop    %r13
    443c:	41 5e                	pop    %r14
    443e:	41 5f                	pop    %r15
    4440:	5d                   	pop    %rbp
    4441:	e9 0a dc ff ff       	jmp    2050 <free@plt>
    4446:	e8 25 dc ff ff       	call   2070 <abort@plt>
    444b:	e8 80 f6 ff ff       	call   3ad0 <fwp_gc_oom>

0000000000004450 <fwp_gc_finalize>:
    4450:	41 57                	push   %r15
    4452:	41 56                	push   %r14
    4454:	41 55                	push   %r13
    4456:	41 54                	push   %r12
    4458:	53                   	push   %rbx
    4459:	4c 8b 3d f0 0f 01 00 	mov    0x10ff0(%rip),%r15        # 15450 <fwp_gc+0x11b8>
    4460:	4d 85 ff             	test   %r15,%r15
    4463:	74 71                	je     44d6 <fwp_gc_finalize+0x86>
    4465:	4c 8b 25 dc 0f 01 00 	mov    0x10fdc(%rip),%r12        # 15448 <fwp_gc+0x11b0>
    446c:	45 31 f6             	xor    %r14d,%r14d
    446f:	eb 46                	jmp    44b7 <fwp_gc_finalize+0x67>
    4471:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4478:	0f 1f 84 00 00 00 00 
    447f:	00 
    4480:	4d 01 e5             	add    %r12,%r13
    4483:	49 8b 45 08          	mov    0x8(%r13),%rax
    4487:	49 ff cf             	dec    %r15
    448a:	4c 89 3d bf 0f 01 00 	mov    %r15,0x10fbf(%rip)        # 15450 <fwp_gc+0x11b8>
    4491:	49 c1 e7 04          	shl    $0x4,%r15
    4495:	43 0f 10 04 3c       	movups (%r12,%r15,1),%xmm0
    449a:	41 0f 11 45 00       	movups %xmm0,0x0(%r13)
    449f:	48 89 df             	mov    %rbx,%rdi
    44a2:	ff d0                	call   *%rax
    44a4:	4c 8b 25 9d 0f 01 00 	mov    0x10f9d(%rip),%r12        # 15448 <fwp_gc+0x11b0>
    44ab:	4c 8b 3d 9e 0f 01 00 	mov    0x10f9e(%rip),%r15        # 15450 <fwp_gc+0x11b8>
    44b2:	4d 39 fe             	cmp    %r15,%r14
    44b5:	73 1f                	jae    44d6 <fwp_gc_finalize+0x86>
    44b7:	4d 89 f5             	mov    %r14,%r13
    44ba:	49 c1 e5 04          	shl    $0x4,%r13
    44be:	4b 8b 1c 2c          	mov    (%r12,%r13,1),%rbx
    44c2:	48 89 df             	mov    %rbx,%rdi
    44c5:	e8 06 0a 00 00       	call   4ed0 <fwp_gc_marked>
    44ca:	85 c0                	test   %eax,%eax
    44cc:	74 b2                	je     4480 <fwp_gc_finalize+0x30>
    44ce:	49 ff c6             	inc    %r14
    44d1:	4d 39 fe             	cmp    %r15,%r14
    44d4:	72 e1                	jb     44b7 <fwp_gc_finalize+0x67>
    44d6:	5b                   	pop    %rbx
    44d7:	41 5c                	pop    %r12
    44d9:	41 5d                	pop    %r13
    44db:	41 5e                	pop    %r14
    44dd:	41 5f                	pop    %r15
    44df:	c3                   	ret

00000000000044e0 <fwp_gc_sweep>:
    44e0:	55                   	push   %rbp
    44e1:	41 57                	push   %r15
    44e3:	41 56                	push   %r14
    44e5:	41 55                	push   %r13
    44e7:	41 54                	push   %r12
    44e9:	53                   	push   %rbx
    44ea:	48 83 ec 28          	sub    $0x28,%rsp
    44ee:	48 8d 3d ab fd 00 00 	lea    0xfdab(%rip),%rdi        # 142a0 <fwp_gc+0x8>
    44f5:	45 31 ff             	xor    %r15d,%r15d
    44f8:	ba 40 0b 00 00       	mov    $0xb40,%edx
    44fd:	31 f6                	xor    %esi,%esi
    44ff:	e8 0c dd ff ff       	call   2210 <memset@plt>
    4504:	48 83 3d e4 0d 01 00 	cmpq   $0x0,0x10de4(%rip)        # 152f0 <fwp_gc+0x1058>
    450b:	00 
    450c:	0f 84 06 05 00 00    	je     4a18 <fwp_gc_sweep+0x538>
    4512:	31 c0                	xor    %eax,%eax
    4514:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    4519:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    4520:	55 55 55 
    4523:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    452a:	33 33 33 
    452d:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    4534:	0f 0f 0f 
    4537:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    453e:	01 01 01 
    4541:	66 0f 6f 2d 67 9b 00 	movdqa 0x9b67(%rip),%xmm5        # e0b0 <_IO_stdin_used+0xb0>
    4548:	00 
    4549:	66 0f 6f 35 6f 9b 00 	movdqa 0x9b6f(%rip),%xmm6        # e0c0 <_IO_stdin_used+0xc0>
    4550:	00 
    4551:	66 0f 6f 3d 77 9b 00 	movdqa 0x9b77(%rip),%xmm7        # e0d0 <_IO_stdin_used+0xd0>
    4558:	00 
    4559:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    455e:	45 31 ff             	xor    %r15d,%r15d
    4561:	31 db                	xor    %ebx,%ebx
    4563:	eb 63                	jmp    45c8 <fwp_gc_sweep+0xe8>
    4565:	4c 8b 64 24 10       	mov    0x10(%rsp),%r12
    456a:	4c 89 e7             	mov    %r12,%rdi
    456d:	e8 ee 09 00 00       	call   4f60 <fwp_rc_clear_chunk>
    4572:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    4577:	66 0f 6f 3d 51 9b 00 	movdqa 0x9b51(%rip),%xmm7        # e0d0 <_IO_stdin_used+0xd0>
    457e:	00 
    457f:	66 0f 6f 35 39 9b 00 	movdqa 0x9b39(%rip),%xmm6        # e0c0 <_IO_stdin_used+0xc0>
    4586:	00 
    4587:	66 0f 6f 2d 21 9b 00 	movdqa 0x9b21(%rip),%xmm5        # e0b0 <_IO_stdin_used+0xb0>
    458e:	00 
    458f:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    4596:	01 01 01 
    4599:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    45a0:	0f 0f 0f 
    45a3:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    45aa:	33 33 33 
    45ad:	41 c6 04 24 00       	movb   $0x0,(%r12)
    45b2:	49 ff c7             	inc    %r15
    45b5:	48 ff c3             	inc    %rbx
    45b8:	48 8b 05 31 0d 01 00 	mov    0x10d31(%rip),%rax        # 152f0 <fwp_gc+0x1058>
    45bf:	48 39 c3             	cmp    %rax,%rbx
    45c2:	0f 83 59 04 00 00    	jae    4a21 <fwp_gc_sweep+0x541>
    45c8:	4c 8b 2d 41 0d 01 00 	mov    0x10d41(%rip),%r13        # 15310 <fwp_gc+0x1078>
    45cf:	4c 69 e3 28 12 00 00 	imul   $0x1228,%rbx,%r12
    45d6:	43 0f b6 44 25 00    	movzbl 0x0(%r13,%r12,1),%eax
    45dc:	85 c0                	test   %eax,%eax
    45de:	74 d2                	je     45b2 <fwp_gc_sweep+0xd2>
    45e0:	83 f8 01             	cmp    $0x1,%eax
    45e3:	74 2b                	je     4610 <fwp_gc_sweep+0x130>
    45e5:	83 f8 02             	cmp    $0x2,%eax
    45e8:	75 cb                	jne    45b5 <fwp_gc_sweep+0xd5>
    45ea:	47 8b 74 25 10       	mov    0x10(%r13,%r12,1),%r14d
    45ef:	43 80 7c 25 03 00    	cmpb   $0x0,0x3(%r13,%r12,1)
    45f5:	74 4c                	je     4643 <fwp_gc_sweep+0x163>
    45f7:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    45fc:	4b 03 44 25 18       	add    0x18(%r13,%r12,1),%rax
    4601:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    4606:	e9 f8 03 00 00       	jmp    4a03 <fwp_gc_sweep+0x523>
    460b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    4610:	4b 8d 04 2c          	lea    (%r12,%r13,1),%rax
    4614:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    4619:	43 8b 6c 25 0c       	mov    0xc(%r13,%r12,1),%ebp
    461e:	48 85 ed             	test   %rbp,%rbp
    4621:	0f 84 3e ff ff ff    	je     4565 <fwp_gc_sweep+0x85>
    4627:	48 8d 55 3f          	lea    0x3f(%rbp),%rdx
    462b:	48 89 d0             	mov    %rdx,%rax
    462e:	48 c1 e8 06          	shr    $0x6,%rax
    4632:	81 fd c1 00 00 00    	cmp    $0xc1,%ebp
    4638:	73 75                	jae    46af <fwp_gc_sweep+0x1cf>
    463a:	31 d2                	xor    %edx,%edx
    463c:	31 c9                	xor    %ecx,%ecx
    463e:	e9 3c 01 00 00       	jmp    477f <fwp_gc_sweep+0x29f>
    4643:	4b 8d 3c 2c          	lea    (%r12,%r13,1),%rdi
    4647:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    464e:	e8 9d e8 ff ff       	call   2ef0 <fwp_rc_clear_slot>
    4653:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    4658:	66 0f 6f 3d 70 9a 00 	movdqa 0x9a70(%rip),%xmm7        # e0d0 <_IO_stdin_used+0xd0>
    465f:	00 
    4660:	66 0f 6f 35 58 9a 00 	movdqa 0x9a58(%rip),%xmm6        # e0c0 <_IO_stdin_used+0xc0>
    4667:	00 
    4668:	66 0f 6f 2d 40 9a 00 	movdqa 0x9a40(%rip),%xmm5        # e0b0 <_IO_stdin_used+0xb0>
    466f:	00 
    4670:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    4677:	01 01 01 
    467a:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    4681:	0f 0f 0f 
    4684:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    468b:	33 33 33 
    468e:	4d 85 f6             	test   %r14,%r14
    4691:	0f 84 69 03 00 00    	je     4a00 <fwp_gc_sweep+0x520>
    4697:	48 8b 05 72 0c 01 00 	mov    0x10c72(%rip),%rax        # 15310 <fwp_gc+0x1078>
    469e:	41 83 fe 04          	cmp    $0x4,%r14d
    46a2:	0f 83 e6 02 00 00    	jae    498e <fwp_gc_sweep+0x4ae>
    46a8:	31 c9                	xor    %ecx,%ecx
    46aa:	e9 19 03 00 00       	jmp    49c8 <fwp_gc_sweep+0x4e8>
    46af:	89 c1                	mov    %eax,%ecx
    46b1:	83 e1 fc             	and    $0xfffffffc,%ecx
    46b4:	4b 8d 34 2c          	lea    (%r12,%r13,1),%rsi
    46b8:	48 83 c6 38          	add    $0x38,%rsi
    46bc:	48 c1 ea 03          	shr    $0x3,%rdx
    46c0:	83 e2 e0             	and    $0xffffffe0,%edx
    46c3:	66 0f ef c0          	pxor   %xmm0,%xmm0
    46c7:	31 ff                	xor    %edi,%edi
    46c9:	66 0f ef c9          	pxor   %xmm1,%xmm1
    46cd:	0f 1f 00             	nopl   (%rax)
    46d0:	f3 0f 6f 5c 3e f0    	movdqu -0x10(%rsi,%rdi,1),%xmm3
    46d6:	f3 0f 6f 14 3e       	movdqu (%rsi,%rdi,1),%xmm2
    46db:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    46df:	66 0f 71 d4 01       	psrlw  $0x1,%xmm4
    46e4:	66 0f db e5          	pand   %xmm5,%xmm4
    46e8:	66 0f f8 dc          	psubb  %xmm4,%xmm3
    46ec:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    46f0:	66 0f db e6          	pand   %xmm6,%xmm4
    46f4:	66 0f 71 d3 02       	psrlw  $0x2,%xmm3
    46f9:	66 0f db de          	pand   %xmm6,%xmm3
    46fd:	66 0f fc dc          	paddb  %xmm4,%xmm3
    4701:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    4705:	66 0f 71 d4 04       	psrlw  $0x4,%xmm4
    470a:	66 0f fc e3          	paddb  %xmm3,%xmm4
    470e:	66 0f db e7          	pand   %xmm7,%xmm4
    4712:	66 41 0f f6 e0       	psadbw %xmm8,%xmm4
    4717:	66 0f d4 c4          	paddq  %xmm4,%xmm0
    471b:	66 0f 6f da          	movdqa %xmm2,%xmm3
    471f:	66 0f 71 d3 01       	psrlw  $0x1,%xmm3
    4724:	66 0f db dd          	pand   %xmm5,%xmm3
    4728:	66 0f f8 d3          	psubb  %xmm3,%xmm2
    472c:	66 0f 6f da          	movdqa %xmm2,%xmm3
    4730:	66 0f db de          	pand   %xmm6,%xmm3
    4734:	66 0f 71 d2 02       	psrlw  $0x2,%xmm2
    4739:	66 0f db d6          	pand   %xmm6,%xmm2
    473d:	66 0f fc d3          	paddb  %xmm3,%xmm2
    4741:	66 0f 6f da          	movdqa %xmm2,%xmm3
    4745:	66 0f 71 d3 04       	psrlw  $0x4,%xmm3
    474a:	66 0f fc da          	paddb  %xmm2,%xmm3
    474e:	66 0f db df          	pand   %xmm7,%xmm3
    4752:	66 41 0f f6 d8       	psadbw %xmm8,%xmm3
    4757:	66 0f d4 cb          	paddq  %xmm3,%xmm1
    475b:	48 83 c7 20          	add    $0x20,%rdi
    475f:	48 39 fa             	cmp    %rdi,%rdx
    4762:	0f 85 68 ff ff ff    	jne    46d0 <fwp_gc_sweep+0x1f0>
    4768:	66 0f d4 c8          	paddq  %xmm0,%xmm1
    476c:	66 0f 70 c1 ee       	pshufd $0xee,%xmm1,%xmm0
    4771:	66 0f d4 c1          	paddq  %xmm1,%xmm0
    4775:	66 48 0f 7e c2       	movq   %xmm0,%rdx
    477a:	48 39 c8             	cmp    %rcx,%rax
    477d:	74 51                	je     47d0 <fwp_gc_sweep+0x2f0>
    477f:	4b 8d 34 2c          	lea    (%r12,%r13,1),%rsi
    4783:	48 83 c6 28          	add    $0x28,%rsi
    4787:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    478e:	00 00 
    4790:	48 8b 3c ce          	mov    (%rsi,%rcx,8),%rdi
    4794:	49 89 f8             	mov    %rdi,%r8
    4797:	49 d1 e8             	shr    $1,%r8
    479a:	4d 21 f0             	and    %r14,%r8
    479d:	4c 29 c7             	sub    %r8,%rdi
    47a0:	49 89 f8             	mov    %rdi,%r8
    47a3:	4d 21 c8             	and    %r9,%r8
    47a6:	48 c1 ef 02          	shr    $0x2,%rdi
    47aa:	4c 21 cf             	and    %r9,%rdi
    47ad:	4c 01 c7             	add    %r8,%rdi
    47b0:	49 89 f8             	mov    %rdi,%r8
    47b3:	49 c1 e8 04          	shr    $0x4,%r8
    47b7:	49 01 f8             	add    %rdi,%r8
    47ba:	4d 21 d0             	and    %r10,%r8
    47bd:	4d 0f af c3          	imul   %r11,%r8
    47c1:	49 c1 e8 38          	shr    $0x38,%r8
    47c5:	4c 01 c2             	add    %r8,%rdx
    47c8:	48 ff c1             	inc    %rcx
    47cb:	48 39 c8             	cmp    %rcx,%rax
    47ce:	75 c0                	jne    4790 <fwp_gc_sweep+0x2b0>
    47d0:	48 85 d2             	test   %rdx,%rdx
    47d3:	0f 84 8c fd ff ff    	je     4565 <fwp_gc_sweep+0x85>
    47d9:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    47de:	43 8b 44 25 08       	mov    0x8(%r13,%r12,1),%eax
    47e3:	48 0f af d0          	imul   %rax,%rdx
    47e7:	48 01 54 24 08       	add    %rdx,0x8(%rsp)
    47ec:	47 0f b6 74 25 01    	movzbl 0x1(%r13,%r12,1),%r14d
    47f2:	47 0f b6 7c 25 02    	movzbl 0x2(%r13,%r12,1),%r15d
    47f8:	48 89 df             	mov    %rbx,%rdi
    47fb:	e8 10 e7 ff ff       	call   2f10 <fwp_gc_chunk_addr>
    4800:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    4805:	48 85 ed             	test   %rbp,%rbp
    4808:	0f 84 31 01 00 00    	je     493f <fwp_gc_sweep+0x45f>
    480e:	49 69 c6 c0 03 00 00 	imul   $0x3c0,%r14,%rax
    4815:	48 8d 0d 7c fa 00 00 	lea    0xfa7c(%rip),%rcx        # 14298 <fwp_gc>
    481c:	48 01 c8             	add    %rcx,%rax
    481f:	4f 8d 34 2c          	lea    (%r12,%r13,1),%r14
    4823:	49 83 c6 08          	add    $0x8,%r14
    4827:	4b 8d 0c 7f          	lea    (%r15,%r15,2),%rcx
    482b:	4c 8d 3c c8          	lea    (%rax,%rcx,8),%r15
    482f:	49 83 c7 08          	add    $0x8,%r15
    4833:	49 01 ec             	add    %rbp,%r12
    4836:	4d 01 ec             	add    %r13,%r12
    4839:	49 81 c4 27 02 00 00 	add    $0x227,%r12
    4840:	48 ff cd             	dec    %rbp
    4843:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    484a:	33 33 33 
    484d:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    4854:	0f 0f 0f 
    4857:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    485e:	01 01 01 
    4861:	66 0f 6f 2d 47 98 00 	movdqa 0x9847(%rip),%xmm5        # e0b0 <_IO_stdin_used+0xb0>
    4868:	00 
    4869:	66 0f 6f 35 4f 98 00 	movdqa 0x984f(%rip),%xmm6        # e0c0 <_IO_stdin_used+0xc0>
    4870:	00 
    4871:	66 0f 6f 3d 57 98 00 	movdqa 0x9857(%rip),%xmm7        # e0d0 <_IO_stdin_used+0xd0>
    4878:	00 
    4879:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    487e:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    4883:	eb 69                	jmp    48ee <fwp_gc_sweep+0x40e>
    4885:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    488c:	00 00 00 00 
    4890:	4c 89 e7             	mov    %r12,%rdi
    4893:	e8 58 e6 ff ff       	call   2ef0 <fwp_rc_clear_slot>
    4898:	49 8b 07             	mov    (%r15),%rax
    489b:	48 f7 d0             	not    %rax
    489e:	49 89 45 00          	mov    %rax,0x0(%r13)
    48a2:	4d 89 2f             	mov    %r13,(%r15)
    48a5:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    48ac:	33 33 33 
    48af:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    48b6:	0f 0f 0f 
    48b9:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    48c0:	01 01 01 
    48c3:	66 0f 6f 2d e5 97 00 	movdqa 0x97e5(%rip),%xmm5        # e0b0 <_IO_stdin_used+0xb0>
    48ca:	00 
    48cb:	66 0f 6f 35 ed 97 00 	movdqa 0x97ed(%rip),%xmm6        # e0c0 <_IO_stdin_used+0xc0>
    48d2:	00 
    48d3:	66 0f 6f 3d f5 97 00 	movdqa 0x97f5(%rip),%xmm7        # e0d0 <_IO_stdin_used+0xd0>
    48da:	00 
    48db:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    48e0:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    48e5:	49 ff cc             	dec    %r12
    48e8:	48 83 c5 ff          	add    $0xffffffffffffffff,%rbp
    48ec:	73 3d                	jae    492b <fwp_gc_sweep+0x44b>
    48ee:	48 89 e8             	mov    %rbp,%rax
    48f1:	48 c1 e8 06          	shr    $0x6,%rax
    48f5:	48 8b 44 c1 28       	mov    0x28(%rcx,%rax,8),%rax
    48fa:	48 0f a3 e8          	bt     %rbp,%rax
    48fe:	72 e5                	jb     48e5 <fwp_gc_sweep+0x405>
    4900:	41 8b 16             	mov    (%r14),%edx
    4903:	49 89 ed             	mov    %rbp,%r13
    4906:	4c 0f af ea          	imul   %rdx,%r13
    490a:	4c 03 6c 24 20       	add    0x20(%rsp),%r13
    490f:	83 3d 86 09 01 00 00 	cmpl   $0x0,0x10986(%rip)        # 1529c <fwp_gc+0x1004>
    4916:	0f 84 74 ff ff ff    	je     4890 <fwp_gc_sweep+0x3b0>
    491c:	4c 89 ef             	mov    %r13,%rdi
    491f:	31 f6                	xor    %esi,%esi
    4921:	e8 ea d8 ff ff       	call   2210 <memset@plt>
    4926:	e9 65 ff ff ff       	jmp    4890 <fwp_gc_sweep+0x3b0>
    492b:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    4930:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    4937:	55 55 55 
    493a:	e9 76 fc ff ff       	jmp    45b5 <fwp_gc_sweep+0xd5>
    493f:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    4944:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    494b:	55 55 55 
    494e:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    4955:	33 33 33 
    4958:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    495f:	0f 0f 0f 
    4962:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    4969:	01 01 01 
    496c:	66 0f 6f 2d 3c 97 00 	movdqa 0x973c(%rip),%xmm5        # e0b0 <_IO_stdin_used+0xb0>
    4973:	00 
    4974:	66 0f 6f 35 44 97 00 	movdqa 0x9744(%rip),%xmm6        # e0c0 <_IO_stdin_used+0xc0>
    497b:	00 
    497c:	66 0f 6f 3d 4c 97 00 	movdqa 0x974c(%rip),%xmm7        # e0d0 <_IO_stdin_used+0xd0>
    4983:	00 
    4984:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    4989:	e9 27 fc ff ff       	jmp    45b5 <fwp_gc_sweep+0xd5>
    498e:	4a 8d 14 20          	lea    (%rax,%r12,1),%rdx
    4992:	44 89 f6             	mov    %r14d,%esi
    4995:	83 e6 fc             	and    $0xfffffffc,%esi
    4998:	31 c9                	xor    %ecx,%ecx
    499a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    49a0:	c6 02 00             	movb   $0x0,(%rdx)
    49a3:	c6 82 28 12 00 00 00 	movb   $0x0,0x1228(%rdx)
    49aa:	c6 82 50 24 00 00 00 	movb   $0x0,0x2450(%rdx)
    49b1:	c6 82 78 36 00 00 00 	movb   $0x0,0x3678(%rdx)
    49b8:	48 83 c1 04          	add    $0x4,%rcx
    49bc:	48 81 c2 a0 48 00 00 	add    $0x48a0,%rdx
    49c3:	48 39 ce             	cmp    %rcx,%rsi
    49c6:	75 d8                	jne    49a0 <fwp_gc_sweep+0x4c0>
    49c8:	44 89 f2             	mov    %r14d,%edx
    49cb:	83 e2 03             	and    $0x3,%edx
    49ce:	74 30                	je     4a00 <fwp_gc_sweep+0x520>
    49d0:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    49d7:	4c 01 e1             	add    %r12,%rcx
    49da:	48 01 c8             	add    %rcx,%rax
    49dd:	48 69 ca 28 12 00 00 	imul   $0x1228,%rdx,%rcx
    49e4:	31 d2                	xor    %edx,%edx
    49e6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    49ed:	00 00 00 
    49f0:	c6 04 10 00          	movb   $0x0,(%rax,%rdx,1)
    49f4:	48 81 c2 28 12 00 00 	add    $0x1228,%rdx
    49fb:	48 39 d1             	cmp    %rdx,%rcx
    49fe:	75 f0                	jne    49f0 <fwp_gc_sweep+0x510>
    4a00:	4d 01 f7             	add    %r14,%r15
    4a03:	4c 01 f3             	add    %r14,%rbx
    4a06:	48 ff cb             	dec    %rbx
    4a09:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    4a10:	55 55 55 
    4a13:	e9 9d fb ff ff       	jmp    45b5 <fwp_gc_sweep+0xd5>
    4a18:	31 c0                	xor    %eax,%eax
    4a1a:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    4a1f:	31 c0                	xor    %eax,%eax
    4a21:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    4a26:	48 89 15 33 0a 01 00 	mov    %rdx,0x10a33(%rip)        # 15460 <fwp_gc+0x11c8>
    4a2d:	4c 89 3d 44 0a 01 00 	mov    %r15,0x10a44(%rip)        # 15478 <fwp_gc+0x11e0>
    4a34:	48 81 fa 01 00 00 01 	cmp    $0x1000001,%rdx
    4a3b:	b9 00 00 00 01       	mov    $0x1000000,%ecx
    4a40:	48 0f 43 ca          	cmovae %rdx,%rcx
    4a44:	48 c1 e9 10          	shr    $0x10,%rcx
    4a48:	66 0f ef c0          	pxor   %xmm0,%xmm0
    4a4c:	f3 0f 7f 05 ac 08 01 	movdqu %xmm0,0x108ac(%rip)        # 15300 <fwp_gc+0x1068>
    4a53:	00 
    4a54:	49 29 cf             	sub    %rcx,%r15
    4a57:	0f 86 01 01 00 00    	jbe    4b5e <fwp_gc_sweep+0x67e>
    4a5d:	48 85 c0             	test   %rax,%rax
    4a60:	0f 84 f8 00 00 00    	je     4b5e <fwp_gc_sweep+0x67e>
    4a66:	4d 85 ff             	test   %r15,%r15
    4a69:	0f 84 ef 00 00 00    	je     4b5e <fwp_gc_sweep+0x67e>
    4a6f:	48 8b 0d 9a 08 01 00 	mov    0x1089a(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    4a76:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    4a7d:	00 00 00 
    4a80:	48 8d 58 ff          	lea    -0x1(%rax),%rbx
    4a84:	48 69 d3 28 12 00 00 	imul   $0x1228,%rbx,%rdx
    4a8b:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
    4a8f:	0f 85 b8 00 00 00    	jne    4b4d <fwp_gc_sweep+0x66d>
    4a95:	4c 89 ff             	mov    %r15,%rdi
    4a98:	49 ff cf             	dec    %r15
    4a9b:	80 7c 11 04 00       	cmpb   $0x0,0x4(%rcx,%rdx,1)
    4aa0:	0f 84 a7 00 00 00    	je     4b4d <fwp_gc_sweep+0x66d>
    4aa6:	48 01 ca             	add    %rcx,%rdx
    4aa9:	48 83 c2 04          	add    $0x4,%rdx
    4aad:	c6 02 00             	movb   $0x0,(%rdx)
    4ab0:	41 be 01 00 00 00    	mov    $0x1,%r14d
    4ab6:	48 85 db             	test   %rbx,%rbx
    4ab9:	74 6f                	je     4b2a <fwp_gc_sweep+0x64a>
    4abb:	4d 85 ff             	test   %r15,%r15
    4abe:	74 6a                	je     4b2a <fwp_gc_sweep+0x64a>
    4ac0:	ba 02 00 00 00       	mov    $0x2,%edx
    4ac5:	48 29 c2             	sub    %rax,%rdx
    4ac8:	48 69 c0 28 12 00 00 	imul   $0x1228,%rax,%rax
    4acf:	48 01 c1             	add    %rax,%rcx
    4ad2:	48 81 c1 b4 db ff ff 	add    $0xffffffffffffdbb4,%rcx
    4ad9:	be 02 00 00 00       	mov    $0x2,%esi
    4ade:	48 29 fe             	sub    %rdi,%rsi
    4ae1:	b8 01 00 00 00       	mov    $0x1,%eax
    4ae6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    4aed:	00 00 00 
    4af0:	80 79 fc 00          	cmpb   $0x0,-0x4(%rcx)
    4af4:	75 31                	jne    4b27 <fwp_gc_sweep+0x647>
    4af6:	80 39 00             	cmpb   $0x0,(%rcx)
    4af9:	74 2c                	je     4b27 <fwp_gc_sweep+0x647>
    4afb:	48 ff cb             	dec    %rbx
    4afe:	48 8d 3c 02          	lea    (%rdx,%rax,1),%rdi
    4b02:	49 ff cf             	dec    %r15
    4b05:	c6 01 00             	movb   $0x0,(%rcx)
    4b08:	4c 8d 70 01          	lea    0x1(%rax),%r14
    4b0c:	48 83 ff 01          	cmp    $0x1,%rdi
    4b10:	74 18                	je     4b2a <fwp_gc_sweep+0x64a>
    4b12:	48 01 f0             	add    %rsi,%rax
    4b15:	48 81 c1 d8 ed ff ff 	add    $0xffffffffffffedd8,%rcx
    4b1c:	48 83 f8 01          	cmp    $0x1,%rax
    4b20:	4c 89 f0             	mov    %r14,%rax
    4b23:	75 cb                	jne    4af0 <fwp_gc_sweep+0x610>
    4b25:	eb 03                	jmp    4b2a <fwp_gc_sweep+0x64a>
    4b27:	49 89 c6             	mov    %rax,%r14
    4b2a:	48 89 df             	mov    %rbx,%rdi
    4b2d:	e8 de e3 ff ff       	call   2f10 <fwp_gc_chunk_addr>
    4b32:	49 c1 e6 10          	shl    $0x10,%r14
    4b36:	48 89 c7             	mov    %rax,%rdi
    4b39:	4c 89 f6             	mov    %r14,%rsi
    4b3c:	ba 04 00 00 00       	mov    $0x4,%edx
    4b41:	e8 aa d8 ff ff       	call   23f0 <madvise@plt>
    4b46:	48 8b 0d c3 07 01 00 	mov    0x107c3(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    4b4d:	48 89 d8             	mov    %rbx,%rax
    4b50:	48 85 db             	test   %rbx,%rbx
    4b53:	74 09                	je     4b5e <fwp_gc_sweep+0x67e>
    4b55:	4d 85 ff             	test   %r15,%r15
    4b58:	0f 85 22 ff ff ff    	jne    4a80 <fwp_gc_sweep+0x5a0>
    4b5e:	48 83 c4 28          	add    $0x28,%rsp
    4b62:	5b                   	pop    %rbx
    4b63:	41 5c                	pop    %r12
    4b65:	41 5d                	pop    %r13
    4b67:	41 5e                	pop    %r14
    4b69:	41 5f                	pop    %r15
    4b6b:	5d                   	pop    %rbp
    4b6c:	c3                   	ret
    4b6d:	0f 1f 00             	nopl   (%rax)

0000000000004b70 <fwp_gc_scan_stacks>:
    4b70:	48 8b 35 a9 07 01 00 	mov    0x107a9(%rip),%rsi        # 15320 <fwp_gc+0x1088>
    4b77:	e9 04 01 00 00       	jmp    4c80 <fwp_gc_scan_root>
    4b7c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000004b80 <fwp_gc_sp>:
    4b80:	55                   	push   %rbp
    4b81:	48 89 e5             	mov    %rsp,%rbp
    4b84:	48 89 e8             	mov    %rbp,%rax
    4b87:	5d                   	pop    %rbp
    4b88:	c3                   	ret
    4b89:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000004b90 <fwp_gc_drain>:
    4b90:	48 8b 05 a1 08 01 00 	mov    0x108a1(%rip),%rax        # 15438 <fwp_gc+0x11a0>
    4b97:	48 85 c0             	test   %rax,%rax
    4b9a:	74 3c                	je     4bd8 <fwp_gc_drain+0x48>
    4b9c:	50                   	push   %rax
    4b9d:	0f 1f 00             	nopl   (%rax)
    4ba0:	48 8b 0d 89 08 01 00 	mov    0x10889(%rip),%rcx        # 15430 <fwp_gc+0x1198>
    4ba7:	48 ff c8             	dec    %rax
    4baa:	48 89 05 87 08 01 00 	mov    %rax,0x10887(%rip)        # 15438 <fwp_gc+0x11a0>
    4bb1:	48 c1 e0 04          	shl    $0x4,%rax
    4bb5:	48 8b 3c 01          	mov    (%rcx,%rax,1),%rdi
    4bb9:	48 8b 74 01 08       	mov    0x8(%rcx,%rax,1),%rsi
    4bbe:	48 01 fe             	add    %rdi,%rsi
    4bc1:	31 d2                	xor    %edx,%edx
    4bc3:	e8 e8 00 00 00       	call   4cb0 <fwp_gc_scan>
    4bc8:	48 8b 05 69 08 01 00 	mov    0x10869(%rip),%rax        # 15438 <fwp_gc+0x11a0>
    4bcf:	48 85 c0             	test   %rax,%rax
    4bd2:	75 cc                	jne    4ba0 <fwp_gc_drain+0x10>
    4bd4:	48 83 c4 08          	add    $0x8,%rsp
    4bd8:	c3                   	ret
    4bd9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000004be0 <fwp_gc_scan_data>:
    4be0:	83 3d 41 08 01 00 00 	cmpl   $0x0,0x10841(%rip)        # 15428 <fwp_gc+0x1190>
    4be7:	0f 8e 87 00 00 00    	jle    4c74 <fwp_gc_scan_data+0x94>
    4bed:	41 57                	push   %r15
    4bef:	41 56                	push   %r14
    4bf1:	41 55                	push   %r13
    4bf3:	41 54                	push   %r12
    4bf5:	53                   	push   %rbx
    4bf6:	4c 8d 25 33 07 01 00 	lea    0x10733(%rip),%r12        # 15330 <fwp_gc+0x1098>
    4bfd:	45 31 ed             	xor    %r13d,%r13d
    4c00:	48 8d 1d 91 f6 00 00 	lea    0xf691(%rip),%rbx        # 14298 <fwp_gc>
    4c07:	4c 8d 35 aa 10 01 00 	lea    0x110aa(%rip),%r14        # 15cb8 <fwp_reuse_verify>
    4c0e:	eb 1d                	jmp    4c2d <fwp_gc_scan_data+0x4d>
    4c10:	4c 89 fe             	mov    %r15,%rsi
    4c13:	31 d2                	xor    %edx,%edx
    4c15:	e8 96 00 00 00       	call   4cb0 <fwp_gc_scan>
    4c1a:	49 ff c5             	inc    %r13
    4c1d:	48 63 05 04 08 01 00 	movslq 0x10804(%rip),%rax        # 15428 <fwp_gc+0x1190>
    4c24:	49 83 c4 10          	add    $0x10,%r12
    4c28:	49 39 c5             	cmp    %rax,%r13
    4c2b:	7d 3e                	jge    4c6b <fwp_gc_scan_data+0x8b>
    4c2d:	49 8b 7c 24 f8       	mov    -0x8(%r12),%rdi
    4c32:	49 8b 04 24          	mov    (%r12),%rax
    4c36:	4c 8d 3c 07          	lea    (%rdi,%rax,1),%r15
    4c3a:	0f 57 c0             	xorps  %xmm0,%xmm0
    4c3d:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    4c42:	f2 0f 58 05 4e 08 01 	addsd  0x1084e(%rip),%xmm0        # 15498 <fwp_gc+0x1200>
    4c49:	00 
    4c4a:	f2 0f 11 05 46 08 01 	movsd  %xmm0,0x10846(%rip)        # 15498 <fwp_gc+0x1200>
    4c51:	00 
    4c52:	48 39 df             	cmp    %rbx,%rdi
    4c55:	77 b9                	ja     4c10 <fwp_gc_scan_data+0x30>
    4c57:	4d 39 f7             	cmp    %r14,%r15
    4c5a:	72 b4                	jb     4c10 <fwp_gc_scan_data+0x30>
    4c5c:	48 89 de             	mov    %rbx,%rsi
    4c5f:	31 d2                	xor    %edx,%edx
    4c61:	e8 4a 00 00 00       	call   4cb0 <fwp_gc_scan>
    4c66:	4c 89 f7             	mov    %r14,%rdi
    4c69:	eb a5                	jmp    4c10 <fwp_gc_scan_data+0x30>
    4c6b:	5b                   	pop    %rbx
    4c6c:	41 5c                	pop    %r12
    4c6e:	41 5d                	pop    %r13
    4c70:	41 5e                	pop    %r14
    4c72:	41 5f                	pop    %r15
    4c74:	c3                   	ret
    4c75:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    4c7c:	00 00 00 00 

0000000000004c80 <fwp_gc_scan_root>:
    4c80:	48 85 ff             	test   %rdi,%rdi
    4c83:	74 24                	je     4ca9 <fwp_gc_scan_root+0x29>
    4c85:	48 89 f0             	mov    %rsi,%rax
    4c88:	48 29 f8             	sub    %rdi,%rax
    4c8b:	76 1c                	jbe    4ca9 <fwp_gc_scan_root+0x29>
    4c8d:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    4c92:	f2 0f 58 05 fe 07 01 	addsd  0x107fe(%rip),%xmm0        # 15498 <fwp_gc+0x1200>
    4c99:	00 
    4c9a:	f2 0f 11 05 f6 07 01 	movsd  %xmm0,0x107f6(%rip)        # 15498 <fwp_gc+0x1200>
    4ca1:	00 
    4ca2:	ba 01 00 00 00       	mov    $0x1,%edx
    4ca7:	eb 07                	jmp    4cb0 <fwp_gc_scan>
    4ca9:	c3                   	ret
    4caa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000004cb0 <fwp_gc_scan>:
    4cb0:	55                   	push   %rbp
    4cb1:	41 57                	push   %r15
    4cb3:	41 56                	push   %r14
    4cb5:	41 55                	push   %r13
    4cb7:	41 54                	push   %r12
    4cb9:	53                   	push   %rbx
    4cba:	50                   	push   %rax
    4cbb:	49 89 ff             	mov    %rdi,%r15
    4cbe:	49 83 c7 07          	add    $0x7,%r15
    4cc2:	49 83 e7 f8          	and    $0xfffffffffffffff8,%r15
    4cc6:	49 8d 47 08          	lea    0x8(%r15),%rax
    4cca:	48 39 f0             	cmp    %rsi,%rax
    4ccd:	76 0f                	jbe    4cde <fwp_gc_scan+0x2e>
    4ccf:	48 83 c4 08          	add    $0x8,%rsp
    4cd3:	5b                   	pop    %rbx
    4cd4:	41 5c                	pop    %r12
    4cd6:	41 5d                	pop    %r13
    4cd8:	41 5e                	pop    %r14
    4cda:	41 5f                	pop    %r15
    4cdc:	5d                   	pop    %rbp
    4cdd:	c3                   	ret
    4cde:	89 d3                	mov    %edx,%ebx
    4ce0:	49 89 f6             	mov    %rsi,%r14
    4ce3:	4c 8b 2d de 05 01 00 	mov    0x105de(%rip),%r13        # 152c8 <fwp_gc+0x1030>
    4cea:	48 8b 2d ff 05 01 00 	mov    0x105ff(%rip),%rbp        # 152f0 <fwp_gc+0x1058>
    4cf1:	48 c1 e5 10          	shl    $0x10,%rbp
    4cf5:	eb 30                	jmp    4d27 <fwp_gc_scan+0x77>
    4cf7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    4cfe:	00 00 
    4d00:	4c 89 e7             	mov    %r12,%rdi
    4d03:	e8 38 00 00 00       	call   4d40 <fwp_gc_mark>
    4d08:	85 db                	test   %ebx,%ebx
    4d0a:	74 0b                	je     4d17 <fwp_gc_scan+0x67>
    4d0c:	49 ff cc             	dec    %r12
    4d0f:	4c 89 e7             	mov    %r12,%rdi
    4d12:	e8 29 00 00 00       	call   4d40 <fwp_gc_mark>
    4d17:	49 8d 47 08          	lea    0x8(%r15),%rax
    4d1b:	49 83 c7 10          	add    $0x10,%r15
    4d1f:	4d 39 f7             	cmp    %r14,%r15
    4d22:	49 89 c7             	mov    %rax,%r15
    4d25:	77 a8                	ja     4ccf <fwp_gc_scan+0x1f>
    4d27:	4d 8b 27             	mov    (%r15),%r12
    4d2a:	4c 89 e0             	mov    %r12,%rax
    4d2d:	4c 29 e8             	sub    %r13,%rax
    4d30:	48 39 e8             	cmp    %rbp,%rax
    4d33:	72 cb                	jb     4d00 <fwp_gc_scan+0x50>
    4d35:	85 db                	test   %ebx,%ebx
    4d37:	74 de                	je     4d17 <fwp_gc_scan+0x67>
    4d39:	48 39 e8             	cmp    %rbp,%rax
    4d3c:	74 ce                	je     4d0c <fwp_gc_scan+0x5c>
    4d3e:	eb d7                	jmp    4d17 <fwp_gc_scan+0x67>

0000000000004d40 <fwp_gc_mark>:
    4d40:	41 56                	push   %r14
    4d42:	53                   	push   %rbx
    4d43:	50                   	push   %rax
    4d44:	49 89 fe             	mov    %rdi,%r14
    4d47:	48 89 e6             	mov    %rsp,%rsi
    4d4a:	e8 d1 00 00 00       	call   4e20 <fwp_gc_chunk_of>
    4d4f:	48 85 c0             	test   %rax,%rax
    4d52:	0f 84 98 00 00 00    	je     4df0 <fwp_gc_mark+0xb0>
    4d58:	0f b6 08             	movzbl (%rax),%ecx
    4d5b:	83 f9 03             	cmp    $0x3,%ecx
    4d5e:	74 6b                	je     4dcb <fwp_gc_mark+0x8b>
    4d60:	83 f9 02             	cmp    $0x2,%ecx
    4d63:	74 7b                	je     4de0 <fwp_gc_mark+0xa0>
    4d65:	83 f9 01             	cmp    $0x1,%ecx
    4d68:	0f 85 82 00 00 00    	jne    4df0 <fwp_gc_mark+0xb0>
    4d6e:	8b 58 08             	mov    0x8(%rax),%ebx
    4d71:	41 0f b7 ce          	movzwl %r14w,%ecx
    4d75:	48 89 c6             	mov    %rax,%rsi
    4d78:	89 c8                	mov    %ecx,%eax
    4d7a:	31 d2                	xor    %edx,%edx
    4d7c:	f7 f3                	div    %ebx
    4d7e:	41 89 c6             	mov    %eax,%r14d
    4d81:	3b 46 0c             	cmp    0xc(%rsi),%eax
    4d84:	73 6a                	jae    4df0 <fwp_gc_mark+0xb0>
    4d86:	48 89 f0             	mov    %rsi,%rax
    4d89:	ba 01 00 00 00       	mov    $0x1,%edx
    4d8e:	44 89 f1             	mov    %r14d,%ecx
    4d91:	48 d3 e2             	shl    %cl,%rdx
    4d94:	44 89 f1             	mov    %r14d,%ecx
    4d97:	c1 e9 06             	shr    $0x6,%ecx
    4d9a:	48 8b 74 ce 28       	mov    0x28(%rsi,%rcx,8),%rsi
    4d9f:	4c 0f a3 f6          	bt     %r14,%rsi
    4da3:	72 4b                	jb     4df0 <fwp_gc_mark+0xb0>
    4da5:	48 09 d6             	or     %rdx,%rsi
    4da8:	48 89 74 c8 28       	mov    %rsi,0x28(%rax,%rcx,8)
    4dad:	80 78 01 01          	cmpb   $0x1,0x1(%rax)
    4db1:	74 3d                	je     4df0 <fwp_gc_mark+0xb0>
    4db3:	48 8b 3c 24          	mov    (%rsp),%rdi
    4db7:	e8 54 e1 ff ff       	call   2f10 <fwp_gc_chunk_addr>
    4dbc:	4c 0f af f3          	imul   %rbx,%r14
    4dc0:	49 01 c6             	add    %rax,%r14
    4dc3:	4c 89 f7             	mov    %r14,%rdi
    4dc6:	48 89 de             	mov    %rbx,%rsi
    4dc9:	eb 40                	jmp    4e0b <fwp_gc_mark+0xcb>
    4dcb:	8b 40 10             	mov    0x10(%rax),%eax
    4dce:	48 89 04 24          	mov    %rax,(%rsp)
    4dd2:	48 69 c0 28 12 00 00 	imul   $0x1228,%rax,%rax
    4dd9:	48 03 05 30 05 01 00 	add    0x10530(%rip),%rax        # 15310 <fwp_gc+0x1078>
    4de0:	80 78 03 00          	cmpb   $0x0,0x3(%rax)
    4de4:	75 0a                	jne    4df0 <fwp_gc_mark+0xb0>
    4de6:	c6 40 03 01          	movb   $0x1,0x3(%rax)
    4dea:	80 78 01 01          	cmpb   $0x1,0x1(%rax)
    4dee:	75 08                	jne    4df8 <fwp_gc_mark+0xb8>
    4df0:	48 83 c4 08          	add    $0x8,%rsp
    4df4:	5b                   	pop    %rbx
    4df5:	41 5e                	pop    %r14
    4df7:	c3                   	ret
    4df8:	48 8b 3c 24          	mov    (%rsp),%rdi
    4dfc:	48 89 c3             	mov    %rax,%rbx
    4dff:	e8 0c e1 ff ff       	call   2f10 <fwp_gc_chunk_addr>
    4e04:	48 8b 73 18          	mov    0x18(%rbx),%rsi
    4e08:	48 89 c7             	mov    %rax,%rdi
    4e0b:	48 83 c4 08          	add    $0x8,%rsp
    4e0f:	5b                   	pop    %rbx
    4e10:	41 5e                	pop    %r14
    4e12:	eb 3c                	jmp    4e50 <fwp_gc_push>
    4e14:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    4e1b:	00 00 00 00 00 

0000000000004e20 <fwp_gc_chunk_of>:
    4e20:	48 2b 3d a1 04 01 00 	sub    0x104a1(%rip),%rdi        # 152c8 <fwp_gc+0x1030>
    4e27:	48 8b 05 c2 04 01 00 	mov    0x104c2(%rip),%rax        # 152f0 <fwp_gc+0x1058>
    4e2e:	48 c1 e0 10          	shl    $0x10,%rax
    4e32:	48 39 c7             	cmp    %rax,%rdi
    4e35:	73 16                	jae    4e4d <fwp_gc_chunk_of+0x2d>
    4e37:	48 c1 ef 10          	shr    $0x10,%rdi
    4e3b:	48 89 3e             	mov    %rdi,(%rsi)
    4e3e:	48 69 c7 28 12 00 00 	imul   $0x1228,%rdi,%rax
    4e45:	48 03 05 c4 04 01 00 	add    0x104c4(%rip),%rax        # 15310 <fwp_gc+0x1078>
    4e4c:	c3                   	ret
    4e4d:	31 c0                	xor    %eax,%eax
    4e4f:	c3                   	ret

0000000000004e50 <fwp_gc_push>:
    4e50:	41 56                	push   %r14
    4e52:	53                   	push   %rbx
    4e53:	50                   	push   %rax
    4e54:	48 89 f3             	mov    %rsi,%rbx
    4e57:	49 89 fe             	mov    %rdi,%r14
    4e5a:	48 8b 0d d7 05 01 00 	mov    0x105d7(%rip),%rcx        # 15438 <fwp_gc+0x11a0>
    4e61:	48 8b 05 c8 05 01 00 	mov    0x105c8(%rip),%rax        # 15430 <fwp_gc+0x1198>
    4e68:	48 3b 0d d1 05 01 00 	cmp    0x105d1(%rip),%rcx        # 15440 <fwp_gc+0x11a8>
    4e6f:	75 36                	jne    4ea7 <fwp_gc_push+0x57>
    4e71:	48 8d 14 09          	lea    (%rcx,%rcx,1),%rdx
    4e75:	48 85 c9             	test   %rcx,%rcx
    4e78:	be 00 10 00 00       	mov    $0x1000,%esi
    4e7d:	48 0f 45 f2          	cmovne %rdx,%rsi
    4e81:	48 89 35 b8 05 01 00 	mov    %rsi,0x105b8(%rip)        # 15440 <fwp_gc+0x11a8>
    4e88:	48 c1 e6 04          	shl    $0x4,%rsi
    4e8c:	48 89 c7             	mov    %rax,%rdi
    4e8f:	e8 ec d4 ff ff       	call   2380 <realloc@plt>
    4e94:	48 89 05 95 05 01 00 	mov    %rax,0x10595(%rip)        # 15430 <fwp_gc+0x1198>
    4e9b:	48 85 c0             	test   %rax,%rax
    4e9e:	74 29                	je     4ec9 <fwp_gc_push+0x79>
    4ea0:	48 8b 0d 91 05 01 00 	mov    0x10591(%rip),%rcx        # 15438 <fwp_gc+0x11a0>
    4ea7:	48 89 ca             	mov    %rcx,%rdx
    4eaa:	48 c1 e2 04          	shl    $0x4,%rdx
    4eae:	4c 89 34 10          	mov    %r14,(%rax,%rdx,1)
    4eb2:	48 89 5c 10 08       	mov    %rbx,0x8(%rax,%rdx,1)
    4eb7:	48 ff c1             	inc    %rcx
    4eba:	48 89 0d 77 05 01 00 	mov    %rcx,0x10577(%rip)        # 15438 <fwp_gc+0x11a0>
    4ec1:	48 83 c4 08          	add    $0x8,%rsp
    4ec5:	5b                   	pop    %rbx
    4ec6:	41 5e                	pop    %r14
    4ec8:	c3                   	ret
    4ec9:	e8 02 ec ff ff       	call   3ad0 <fwp_gc_oom>
    4ece:	66 90                	xchg   %ax,%ax

0000000000004ed0 <fwp_gc_marked>:
    4ed0:	53                   	push   %rbx
    4ed1:	48 83 ec 10          	sub    $0x10,%rsp
    4ed5:	48 89 fb             	mov    %rdi,%rbx
    4ed8:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    4edd:	e8 3e ff ff ff       	call   4e20 <fwp_gc_chunk_of>
    4ee2:	48 85 c0             	test   %rax,%rax
    4ee5:	74 36                	je     4f1d <fwp_gc_marked+0x4d>
    4ee7:	0f b6 08             	movzbl (%rax),%ecx
    4eea:	80 f9 03             	cmp    $0x3,%cl
    4eed:	75 19                	jne    4f08 <fwp_gc_marked+0x38>
    4eef:	48 8b 0d 1a 04 01 00 	mov    0x1041a(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    4ef6:	8b 40 10             	mov    0x10(%rax),%eax
    4ef9:	48 69 d0 28 12 00 00 	imul   $0x1228,%rax,%rdx
    4f00:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    4f04:	0f b6 0c 11          	movzbl (%rcx,%rdx,1),%ecx
    4f08:	80 f9 01             	cmp    $0x1,%cl
    4f0b:	74 17                	je     4f24 <fwp_gc_marked+0x54>
    4f0d:	0f b6 d1             	movzbl %cl,%edx
    4f10:	31 c9                	xor    %ecx,%ecx
    4f12:	83 fa 02             	cmp    $0x2,%edx
    4f15:	75 33                	jne    4f4a <fwp_gc_marked+0x7a>
    4f17:	0f b6 48 03          	movzbl 0x3(%rax),%ecx
    4f1b:	eb 2d                	jmp    4f4a <fwp_gc_marked+0x7a>
    4f1d:	b9 01 00 00 00       	mov    $0x1,%ecx
    4f22:	eb 26                	jmp    4f4a <fwp_gc_marked+0x7a>
    4f24:	0f b7 cb             	movzwl %bx,%ecx
    4f27:	48 89 c6             	mov    %rax,%rsi
    4f2a:	89 c8                	mov    %ecx,%eax
    4f2c:	31 d2                	xor    %edx,%edx
    4f2e:	f7 76 08             	divl   0x8(%rsi)
    4f31:	89 c1                	mov    %eax,%ecx
    4f33:	c1 e9 03             	shr    $0x3,%ecx
    4f36:	81 e1 f8 1f 00 00    	and    $0x1ff8,%ecx
    4f3c:	48 8b 54 0e 28       	mov    0x28(%rsi,%rcx,1),%rdx
    4f41:	31 c9                	xor    %ecx,%ecx
    4f43:	48 0f a3 c2          	bt     %rax,%rdx
    4f47:	0f 92 c1             	setb   %cl
    4f4a:	89 c8                	mov    %ecx,%eax
    4f4c:	48 83 c4 10          	add    $0x10,%rsp
    4f50:	5b                   	pop    %rbx
    4f51:	c3                   	ret
    4f52:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4f59:	1f 84 00 00 00 00 00 

0000000000004f60 <fwp_rc_clear_chunk>:
    4f60:	41 57                	push   %r15
    4f62:	41 56                	push   %r14
    4f64:	53                   	push   %rbx
    4f65:	48 89 fb             	mov    %rdi,%rbx
    4f68:	48 83 3d 40 0d 01 00 	cmpq   $0x0,0x10d40(%rip)        # 15cb0 <fwp_gc+0x1a18>
    4f6f:	00 
    4f70:	74 2c                	je     4f9e <fwp_rc_clear_chunk+0x3e>
    4f72:	4c 8d b3 28 02 00 00 	lea    0x228(%rbx),%r14
    4f79:	45 31 ff             	xor    %r15d,%r15d
    4f7c:	eb 0e                	jmp    4f8c <fwp_rc_clear_chunk+0x2c>
    4f7e:	66 90                	xchg   %ax,%ax
    4f80:	49 ff c7             	inc    %r15
    4f83:	49 81 ff 00 10 00 00 	cmp    $0x1000,%r15
    4f8a:	74 12                	je     4f9e <fwp_rc_clear_chunk+0x3e>
    4f8c:	43 80 3c 3e ff       	cmpb   $0xff,(%r14,%r15,1)
    4f91:	75 ed                	jne    4f80 <fwp_rc_clear_chunk+0x20>
    4f93:	4b 8d 3c 3e          	lea    (%r14,%r15,1),%rdi
    4f97:	e8 84 df ff ff       	call   2f20 <fwp_rc_forget_slot>
    4f9c:	eb e2                	jmp    4f80 <fwp_rc_clear_chunk+0x20>
    4f9e:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    4fa5:	ba 00 10 00 00       	mov    $0x1000,%edx
    4faa:	48 89 df             	mov    %rbx,%rdi
    4fad:	31 f6                	xor    %esi,%esi
    4faf:	5b                   	pop    %rbx
    4fb0:	41 5e                	pop    %r14
    4fb2:	41 5f                	pop    %r15
    4fb4:	e9 57 d2 ff ff       	jmp    2210 <memset@plt>
    4fb9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

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
    50ac:	e8 4f e0 ff ff       	call   3100 <fwp_record>
    50b1:	49 89 c6             	mov    %rax,%r14
    50b4:	48 89 c7             	mov    %rax,%rdi
    50b7:	e8 04 e0 ff ff       	call   30c0 <fwp_rc_fresh>
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
    56c9:	e9 f2 d9 ff ff       	jmp    30c0 <fwp_rc_fresh>
    56ce:	48 8d 3d 64 91 00 00 	lea    0x9164(%rip),%rdi        # e839 <exec_in_fp0+0x1e9>
    56d5:	e8 e6 d8 ff ff       	call   2fc0 <fwp_trap>
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
    5705:	48 8d 3d 2d 91 00 00 	lea    0x912d(%rip),%rdi        # e839 <exec_in_fp0+0x1e9>
    570c:	e8 af d8 ff ff       	call   2fc0 <fwp_trap>
    5711:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5718:	0f 1f 84 00 00 00 00 
    571f:	00 

0000000000005720 <fwp_alloc>:
    5720:	be 02 00 00 00       	mov    $0x2,%esi
    5725:	e9 b6 db ff ff       	jmp    32e0 <fwp_gc_alloc>
    572a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000005730 <fwp_drop0>:
    5730:	53                   	push   %rbx
    5731:	48 89 fb             	mov    %rdi,%rbx
    5734:	e8 67 d3 ff ff       	call   2aa0 <fwp_rc_release_last>
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
    5760:	8b 0d 52 05 01 00    	mov    0x10552(%rip),%ecx        # 15cb8 <fwp_reuse_verify>
    5766:	85 c9                	test   %ecx,%ecx
    5768:	78 0d                	js     5777 <fwp_rc_free_arr+0x27>
    576a:	85 c9                	test   %ecx,%ecx
    576c:	74 41                	je     57af <fwp_rc_free_arr+0x5f>
    576e:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    5775:	eb 66                	jmp    57dd <fwp_rc_free_arr+0x8d>
    5777:	48 8d 3d cb 90 00 00 	lea    0x90cb(%rip),%rdi        # e849 <exec_in_fp0+0x1f9>
    577e:	e8 ad c8 ff ff       	call   2030 <getenv@plt>
    5783:	31 c9                	xor    %ecx,%ecx
    5785:	48 85 c0             	test   %rax,%rax
    5788:	74 1b                	je     57a5 <fwp_rc_free_arr+0x55>
    578a:	80 38 00             	cmpb   $0x0,(%rax)
    578d:	74 16                	je     57a5 <fwp_rc_free_arr+0x55>
    578f:	48 8d 35 e5 9b 00 00 	lea    0x9be5(%rip),%rsi        # f37b <exec_in_fp0+0xd2b>
    5796:	48 89 c7             	mov    %rax,%rdi
    5799:	e8 32 cb ff ff       	call   22d0 <strcmp@plt>
    579e:	31 c9                	xor    %ecx,%ecx
    57a0:	85 c0                	test   %eax,%eax
    57a2:	0f 95 c1             	setne  %cl
    57a5:	89 0d 0d 05 01 00    	mov    %ecx,0x1050d(%rip)        # 15cb8 <fwp_reuse_verify>
    57ab:	85 c9                	test   %ecx,%ecx
    57ad:	75 bf                	jne    576e <fwp_rc_free_arr+0x1e>
    57af:	4c 8b 35 e2 ea 00 00 	mov    0xeae2(%rip),%r14        # 14298 <fwp_gc>
    57b6:	48 89 df             	mov    %rbx,%rdi
    57b9:	e8 52 00 00 00       	call   5810 <fwp_mem_free>
    57be:	48 8b 05 d3 ea 00 00 	mov    0xead3(%rip),%rax        # 14298 <fwp_gc>
    57c5:	4c 29 f0             	sub    %r14,%rax
    57c8:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    57cd:	f2 0f 58 05 cb fc 00 	addsd  0xfccb(%rip),%xmm0        # 154a0 <fwp_gc+0x1208>
    57d4:	00 
    57d5:	f2 0f 11 05 c3 fc 00 	movsd  %xmm0,0xfcc3(%rip)        # 154a0 <fwp_gc+0x1208>
    57dc:	00 
    57dd:	48 83 c4 08          	add    $0x8,%rsp
    57e1:	5b                   	pop    %rbx
    57e2:	41 5e                	pop    %r14
    57e4:	c3                   	ret
    57e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    57ec:	00 00 00 00 

00000000000057f0 <fwp_rc_last>:
    57f0:	50                   	push   %rax
    57f1:	e8 8a d6 ff ff       	call   2e80 <fwp_rc_slot>
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
    582a:	e8 f1 f5 ff ff       	call   4e20 <fwp_gc_chunk_of>
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
    5861:	48 8d 35 30 ea 00 00 	lea    0xea30(%rip),%rsi        # 14298 <fwp_gc>
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
    58a5:	e8 46 d6 ff ff       	call   2ef0 <fwp_rc_clear_slot>
    58aa:	83 3d eb f9 00 00 00 	cmpl   $0x0,0xf9eb(%rip)        # 1529c <fwp_gc+0x1004>
    58b1:	74 0e                	je     58c1 <fwp_mem_free+0xb1>
    58b3:	41 8b 56 08          	mov    0x8(%r14),%edx
    58b7:	4c 89 ff             	mov    %r15,%rdi
    58ba:	31 f6                	xor    %esi,%esi
    58bc:	e8 4f c9 ff ff       	call   2210 <memset@plt>
    58c1:	48 8b 03             	mov    (%rbx),%rax
    58c4:	48 f7 d0             	not    %rax
    58c7:	49 89 07             	mov    %rax,(%r15)
    58ca:	4c 89 3b             	mov    %r15,(%rbx)
    58cd:	41 8b 46 08          	mov    0x8(%r14),%eax
    58d1:	48 01 05 c0 e9 00 00 	add    %rax,0xe9c0(%rip)        # 14298 <fwp_gc>
    58d8:	e9 fa 00 00 00       	jmp    59d7 <fwp_mem_free+0x1c7>
    58dd:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    58e2:	48 89 df             	mov    %rbx,%rdi
    58e5:	e8 26 d6 ff ff       	call   2f10 <fwp_gc_chunk_addr>
    58ea:	4c 39 f8             	cmp    %r15,%rax
    58ed:	0f 85 e4 00 00 00    	jne    59d7 <fwp_mem_free+0x1c7>
    58f3:	49 8b 46 18          	mov    0x18(%r14),%rax
    58f7:	48 01 05 9a e9 00 00 	add    %rax,0xe99a(%rip)        # 14298 <fwp_gc>
    58fe:	41 c6 46 03 00       	movb   $0x0,0x3(%r14)
    5903:	4c 89 f7             	mov    %r14,%rdi
    5906:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    590d:	e8 de d5 ff ff       	call   2ef0 <fwp_rc_clear_slot>
    5912:	41 8b 46 10          	mov    0x10(%r14),%eax
    5916:	48 85 c0             	test   %rax,%rax
    5919:	0f 84 91 00 00 00    	je     59b0 <fwp_mem_free+0x1a0>
    591f:	48 8b 0d ea f9 00 00 	mov    0xf9ea(%rip),%rcx        # 15310 <fwp_gc+0x1078>
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
    59b0:	48 01 05 c1 fa 00 00 	add    %rax,0xfac1(%rip)        # 15478 <fwp_gc+0x11e0>
    59b7:	48 3b 1d 4a f9 00 00 	cmp    0xf94a(%rip),%rbx        # 15308 <fwp_gc+0x1070>
    59be:	73 07                	jae    59c7 <fwp_mem_free+0x1b7>
    59c0:	48 89 1d 41 f9 00 00 	mov    %rbx,0xf941(%rip)        # 15308 <fwp_gc+0x1070>
    59c7:	48 3b 1d 32 f9 00 00 	cmp    0xf932(%rip),%rbx        # 15300 <fwp_gc+0x1068>
    59ce:	73 07                	jae    59d7 <fwp_mem_free+0x1c7>
    59d0:	48 89 1d 29 f9 00 00 	mov    %rbx,0xf929(%rip)        # 15300 <fwp_gc+0x1068>
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
    59f4:	e8 a7 d0 ff ff       	call   2aa0 <fwp_rc_release_last>
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
    5a14:	e8 87 d0 ff ff       	call   2aa0 <fwp_rc_release_last>
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
    5a34:	e8 67 d0 ff ff       	call   2aa0 <fwp_rc_release_last>
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
    5a54:	e8 47 d0 ff ff       	call   2aa0 <fwp_rc_release_last>
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
    5a74:	e8 27 d0 ff ff       	call   2aa0 <fwp_rc_release_last>
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
    5a94:	e8 07 d0 ff ff       	call   2aa0 <fwp_rc_release_last>
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
    5ab4:	e8 e7 cf ff ff       	call   2aa0 <fwp_rc_release_last>
    5ab9:	85 c0                	test   %eax,%eax
    5abb:	74 09                	je     5ac6 <fwp_drop7+0x16>
    5abd:	48 89 df             	mov    %rbx,%rdi
    5ac0:	5b                   	pop    %rbx
    5ac1:	e9 8a fc ff ff       	jmp    5750 <fwp_rc_free_arr>
    5ac6:	5b                   	pop    %rbx
    5ac7:	c3                   	ret
    5ac8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    5acf:	00 

0000000000005ad0 <f3>:
    5ad0:	53                   	push   %rbx
    5ad1:	48 83 ec 30          	sub    $0x30,%rsp
    5ad5:	e8 d6 00 00 00       	call   5bb0 <fwp_f64>
    5ada:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    5adf:	e8 5c 00 00 00       	call   5b40 <w3>
    5ae4:	f2 0f 10 44 24 18    	movsd  0x18(%rsp),%xmm0
    5aea:	e8 d1 00 00 00       	call   5bc0 <fwp_from_f64>
    5aef:	48 89 04 24          	mov    %rax,(%rsp)
    5af3:	f2 0f 10 44 24 20    	movsd  0x20(%rsp),%xmm0
    5af9:	e8 c2 00 00 00       	call   5bc0 <fwp_from_f64>
    5afe:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    5b03:	f2 0f 10 44 24 28    	movsd  0x28(%rsp),%xmm0
    5b09:	e8 b2 00 00 00       	call   5bc0 <fwp_from_f64>
    5b0e:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    5b13:	48 89 e6             	mov    %rsp,%rsi
    5b16:	bf 03 00 00 00       	mov    $0x3,%edi
    5b1b:	e8 e0 d5 ff ff       	call   3100 <fwp_record>
    5b20:	48 89 c3             	mov    %rax,%rbx
    5b23:	48 89 c7             	mov    %rax,%rdi
    5b26:	e8 95 d5 ff ff       	call   30c0 <fwp_rc_fresh>
    5b2b:	48 89 d8             	mov    %rbx,%rax
    5b2e:	48 83 c4 30          	add    $0x30,%rsp
    5b32:	5b                   	pop    %rbx
    5b33:	c3                   	ret
    5b34:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    5b3b:	00 00 00 00 00 

0000000000005b40 <w3>:
    5b40:	41 57                	push   %r15
    5b42:	41 56                	push   %r14
    5b44:	41 54                	push   %r12
    5b46:	53                   	push   %rbx
    5b47:	50                   	push   %rax
    5b48:	48 89 fb             	mov    %rdi,%rbx
    5b4b:	e8 70 00 00 00       	call   5bc0 <fwp_from_f64>
    5b50:	49 89 c6             	mov    %rax,%r14
    5b53:	48 bf 00 00 00 00 00 	movabs $0x3fd0000000000000,%rdi
    5b5a:	00 d0 3f 
    5b5d:	48 89 c6             	mov    %rax,%rsi
    5b60:	e8 6b 00 00 00       	call   5bd0 <f6>
    5b65:	49 89 c7             	mov    %rax,%r15
    5b68:	4c 89 f7             	mov    %r14,%rdi
    5b6b:	e8 90 00 00 00       	call   5c00 <f10>
    5b70:	49 89 c4             	mov    %rax,%r12
    5b73:	4c 89 f7             	mov    %r14,%rdi
    5b76:	e8 35 00 00 00       	call   5bb0 <fwp_f64>
    5b7b:	f2 0f 11 03          	movsd  %xmm0,(%rbx)
    5b7f:	4c 89 ff             	mov    %r15,%rdi
    5b82:	e8 29 00 00 00       	call   5bb0 <fwp_f64>
    5b87:	f2 0f 11 43 08       	movsd  %xmm0,0x8(%rbx)
    5b8c:	4c 89 e7             	mov    %r12,%rdi
    5b8f:	e8 1c 00 00 00       	call   5bb0 <fwp_f64>
    5b94:	f2 0f 11 43 10       	movsd  %xmm0,0x10(%rbx)
    5b99:	48 89 d8             	mov    %rbx,%rax
    5b9c:	48 83 c4 08          	add    $0x8,%rsp
    5ba0:	5b                   	pop    %rbx
    5ba1:	41 5c                	pop    %r12
    5ba3:	41 5e                	pop    %r14
    5ba5:	41 5f                	pop    %r15
    5ba7:	c3                   	ret
    5ba8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    5baf:	00 

0000000000005bb0 <fwp_f64>:
    5bb0:	66 48 0f 6e c7       	movq   %rdi,%xmm0
    5bb5:	c3                   	ret
    5bb6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    5bbd:	00 00 00 

0000000000005bc0 <fwp_from_f64>:
    5bc0:	66 48 0f 7e c0       	movq   %xmm0,%rax
    5bc5:	c3                   	ret
    5bc6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    5bcd:	00 00 00 

0000000000005bd0 <f6>:
    5bd0:	53                   	push   %rbx
    5bd1:	48 83 ec 10          	sub    $0x10,%rsp
    5bd5:	48 89 fb             	mov    %rdi,%rbx
    5bd8:	48 89 f7             	mov    %rsi,%rdi
    5bdb:	e8 d0 ff ff ff       	call   5bb0 <fwp_f64>
    5be0:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    5be6:	48 89 df             	mov    %rbx,%rdi
    5be9:	e8 c2 ff ff ff       	call   5bb0 <fwp_f64>
    5bee:	f2 0f 58 44 24 08    	addsd  0x8(%rsp),%xmm0
    5bf4:	48 83 c4 10          	add    $0x10,%rsp
    5bf8:	5b                   	pop    %rbx
    5bf9:	eb c5                	jmp    5bc0 <fwp_from_f64>
    5bfb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000005c00 <f10>:
    5c00:	50                   	push   %rax
    5c01:	e8 aa ff ff ff       	call   5bb0 <fwp_f64>
    5c06:	0f 57 05 d3 84 00 00 	xorps  0x84d3(%rip),%xmm0        # e0e0 <_IO_stdin_used+0xe0>
    5c0d:	58                   	pop    %rax
    5c0e:	eb b0                	jmp    5bc0 <fwp_from_f64>

0000000000005c10 <f4>:
    5c10:	50                   	push   %rax
    5c11:	e8 9a ff ff ff       	call   5bb0 <fwp_f64>
    5c16:	e8 05 00 00 00       	call   5c20 <w4>
    5c1b:	58                   	pop    %rax
    5c1c:	eb a2                	jmp    5bc0 <fwp_from_f64>
    5c1e:	66 90                	xchg   %ax,%ax

0000000000005c20 <w4>:
    5c20:	50                   	push   %rax
    5c21:	e8 9a ff ff ff       	call   5bc0 <fwp_from_f64>
    5c26:	48 bf 00 00 00 00 00 	movabs $0x3fc0000000000000,%rdi
    5c2d:	00 c0 3f 
    5c30:	48 89 c6             	mov    %rax,%rsi
    5c33:	e8 98 ff ff ff       	call   5bd0 <f6>
    5c38:	48 89 c7             	mov    %rax,%rdi
    5c3b:	58                   	pop    %rax
    5c3c:	e9 6f ff ff ff       	jmp    5bb0 <fwp_f64>
    5c41:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5c48:	0f 1f 84 00 00 00 00 
    5c4f:	00 

0000000000005c50 <fwp_stack_guard_init>:
    5c50:	53                   	push   %rbx
    5c51:	48 81 ec c0 00 00 00 	sub    $0xc0,%rsp
    5c58:	48 8d 44 24 0f       	lea    0xf(%rsp),%rax
    5c5d:	48 89 05 a4 01 01 00 	mov    %rax,0x101a4(%rip)        # 15e08 <fwp_main_stack_top>
    5c64:	48 89 3d a5 01 01 00 	mov    %rdi,0x101a5(%rip)        # 15e10 <fwp_main_stack_size>
    5c6b:	48 8d 05 ae 01 01 00 	lea    0x101ae(%rip),%rax        # 15e20 <fwp_stack_guard_init.alt>
    5c72:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    5c77:	48 c7 44 24 20 00 00 	movq   $0x10000,0x20(%rsp)
    5c7e:	01 00 
    5c80:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%rsp)
    5c87:	00 
    5c88:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    5c8d:	31 f6                	xor    %esi,%esi
    5c8f:	e8 3c c8 ff ff       	call   24d0 <sigaltstack@plt>
    5c94:	85 c0                	test   %eax,%eax
    5c96:	0f 85 80 00 00 00    	jne    5d1c <fwp_stack_guard_init+0xcc>
    5c9c:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    5ca1:	0f 57 c0             	xorps  %xmm0,%xmm0
    5ca4:	0f 11 84 24 b0 00 00 	movups %xmm0,0xb0(%rsp)
    5cab:	00 
    5cac:	0f 11 84 24 a0 00 00 	movups %xmm0,0xa0(%rsp)
    5cb3:	00 
    5cb4:	0f 11 84 24 90 00 00 	movups %xmm0,0x90(%rsp)
    5cbb:	00 
    5cbc:	0f 11 84 24 80 00 00 	movups %xmm0,0x80(%rsp)
    5cc3:	00 
    5cc4:	0f 11 44 24 70       	movups %xmm0,0x70(%rsp)
    5cc9:	0f 11 44 24 60       	movups %xmm0,0x60(%rsp)
    5cce:	0f 11 44 24 50       	movups %xmm0,0x50(%rsp)
    5cd3:	0f 11 44 24 40       	movups %xmm0,0x40(%rsp)
    5cd8:	0f 11 44 24 30       	movups %xmm0,0x30(%rsp)
    5cdd:	48 8d 05 7c 07 00 00 	lea    0x77c(%rip),%rax        # 6460 <fwp_segv>
    5ce4:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    5ce9:	c7 84 24 b0 00 00 00 	movl   $0x8000004,0xb0(%rsp)
    5cf0:	04 00 00 08 
    5cf4:	e8 17 c6 ff ff       	call   2310 <sigemptyset@plt>
    5cf9:	48 8d 5c 24 28       	lea    0x28(%rsp),%rbx
    5cfe:	bf 0b 00 00 00       	mov    $0xb,%edi
    5d03:	48 89 de             	mov    %rbx,%rsi
    5d06:	31 d2                	xor    %edx,%edx
    5d08:	e8 d3 c3 ff ff       	call   20e0 <sigaction@plt>
    5d0d:	bf 07 00 00 00       	mov    $0x7,%edi
    5d12:	48 89 de             	mov    %rbx,%rsi
    5d15:	31 d2                	xor    %edx,%edx
    5d17:	e8 c4 c3 ff ff       	call   20e0 <sigaction@plt>
    5d1c:	48 81 c4 c0 00 00 00 	add    $0xc0,%rsp
    5d23:	5b                   	pop    %rbx
    5d24:	c3                   	ret
    5d25:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    5d2c:	00 00 00 00 

0000000000005d30 <fwp_exec>:
    5d30:	55                   	push   %rbp
    5d31:	41 57                	push   %r15
    5d33:	41 56                	push   %r14
    5d35:	41 55                	push   %r13
    5d37:	41 54                	push   %r12
    5d39:	53                   	push   %rbx
    5d3a:	48 81 ec 58 01 00 00 	sub    $0x158,%rsp
    5d41:	49 89 f7             	mov    %rsi,%r15
    5d44:	41 89 fd             	mov    %edi,%r13d
    5d47:	41 8d 5d ff          	lea    -0x1(%r13),%ebx
    5d4b:	80 3d ae 00 01 00 01 	cmpb   $0x1,0x100ae(%rip)        # 15e00 <fwp_cli_single>
    5d52:	75 16                	jne    5d6a <fwp_exec+0x3a>
    5d54:	49 8d 77 08          	lea    0x8(%r15),%rsi
    5d58:	89 df                	mov    %ebx,%edi
    5d5a:	e8 91 07 00 00       	call   64f0 <fwp_generated>
    5d5f:	41 89 c6             	mov    %eax,%r14d
    5d62:	85 c0                	test   %eax,%eax
    5d64:	0f 89 1a 01 00 00    	jns    5e84 <fwp_exec+0x154>
    5d6a:	89 5c 24 18          	mov    %ebx,0x18(%rsp)
    5d6e:	49 63 fd             	movslq %r13d,%rdi
    5d71:	48 c1 e7 03          	shl    $0x3,%rdi
    5d75:	48 89 7c 24 48       	mov    %rdi,0x48(%rsp)
    5d7a:	e8 a1 f9 ff ff       	call   5720 <fwp_alloc>
    5d7f:	49 89 c4             	mov    %rax,%r12
    5d82:	41 83 fd 02          	cmp    $0x2,%r13d
    5d86:	7c 30                	jl     5db8 <fwp_exec+0x88>
    5d88:	8b 6c 24 18          	mov    0x18(%rsp),%ebp
    5d8c:	31 db                	xor    %ebx,%ebx
    5d8e:	66 90                	xchg   %ax,%ax
    5d90:	4c 8d 73 01          	lea    0x1(%rbx),%r14
    5d94:	4d 8b 6c df 08       	mov    0x8(%r15,%rbx,8),%r13
    5d99:	4c 89 ef             	mov    %r13,%rdi
    5d9c:	e8 cf c3 ff ff       	call   2170 <strlen@plt>
    5da1:	4c 89 ef             	mov    %r13,%rdi
    5da4:	48 89 c6             	mov    %rax,%rsi
    5da7:	e8 a4 08 00 00       	call   6650 <fwp_str_lossy>
    5dac:	49 89 04 dc          	mov    %rax,(%r12,%rbx,8)
    5db0:	4c 89 f3             	mov    %r14,%rbx
    5db3:	4c 39 f5             	cmp    %r14,%rbp
    5db6:	75 d8                	jne    5d90 <fwp_exec+0x60>
    5db8:	bf 08 00 00 00       	mov    $0x8,%edi
    5dbd:	e8 5e f9 ff ff       	call   5720 <fwp_alloc>
    5dc2:	bf 01 00 00 00       	mov    $0x1,%edi
    5dc7:	e8 64 0a 00 00       	call   6830 <fwp_alloc_leaf>
    5dcc:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
    5dd1:	e8 4a f9 ff ff       	call   5720 <fwp_alloc>
    5dd6:	49 89 c6             	mov    %rax,%r14
    5dd9:	48 8d 4c 24 2c       	lea    0x2c(%rsp),%rcx
    5dde:	8b 7c 24 18          	mov    0x18(%rsp),%edi
    5de2:	4c 89 e6             	mov    %r12,%rsi
    5de5:	48 89 c2             	mov    %rax,%rdx
    5de8:	e8 53 0a 00 00       	call   6840 <fwp_cli_parse>
    5ded:	83 f8 02             	cmp    $0x2,%eax
    5df0:	74 32                	je     5e24 <fwp_exec+0xf4>
    5df2:	83 f8 01             	cmp    $0x1,%eax
    5df5:	75 5d                	jne    5e54 <fwp_exec+0x124>
    5df7:	48 8b 1d ba e1 00 00 	mov    0xe1ba(%rip),%rbx        # 13fb8 <stdout@GLIBC_2.2.5>
    5dfe:	48 8b 0b             	mov    (%rbx),%rcx
    5e01:	48 8d 3d 24 96 00 00 	lea    0x9624(%rip),%rdi        # f42c <exec_in_fp0+0xddc>
    5e08:	be 72 00 00 00       	mov    $0x72,%esi
    5e0d:	ba 01 00 00 00       	mov    $0x1,%edx
    5e12:	e8 89 c6 ff ff       	call   24a0 <fwrite@plt>
    5e17:	48 8b 3b             	mov    (%rbx),%rdi
    5e1a:	e8 31 c5 ff ff       	call   2350 <fflush@plt>
    5e1f:	45 31 f6             	xor    %r14d,%r14d
    5e22:	eb 60                	jmp    5e84 <fwp_exec+0x154>
    5e24:	48 8d 3d 6f 92 00 00 	lea    0x926f(%rip),%rdi        # f09a <exec_in_fp0+0xa4a>
    5e2b:	48 8d 15 47 88 00 00 	lea    0x8847(%rip),%rdx        # e679 <exec_in_fp0+0x29>
    5e32:	45 31 f6             	xor    %r14d,%r14d
    5e35:	be 06 00 00 00       	mov    $0x6,%esi
    5e3a:	31 c9                	xor    %ecx,%ecx
    5e3c:	31 c0                	xor    %eax,%eax
    5e3e:	e8 7d c3 ff ff       	call   21c0 <printf@plt>
    5e43:	48 8b 05 6e e1 00 00 	mov    0xe16e(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    5e4a:	48 8b 38             	mov    (%rax),%rdi
    5e4d:	e8 fe c4 ff ff       	call   2350 <fflush@plt>
    5e52:	eb 30                	jmp    5e84 <fwp_exec+0x154>
    5e54:	bf 10 00 00 00       	mov    $0x10,%edi
    5e59:	e8 c2 f8 ff ff       	call   5720 <fwp_alloc>
    5e5e:	49 89 c7             	mov    %rax,%r15
    5e61:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%rsp)
    5e68:	00 
    5e69:	8b 74 24 2c          	mov    0x2c(%rsp),%esi
    5e6d:	48 8d 4c 24 14       	lea    0x14(%rsp),%rcx
    5e72:	4c 89 f7             	mov    %r14,%rdi
    5e75:	48 89 c2             	mov    %rax,%rdx
    5e78:	e8 23 0c 00 00       	call   6aa0 <fwp_bind_positional>
    5e7d:	41 89 c6             	mov    %eax,%r14d
    5e80:	85 c0                	test   %eax,%eax
    5e82:	74 15                	je     5e99 <fwp_exec+0x169>
    5e84:	44 89 f0             	mov    %r14d,%eax
    5e87:	48 81 c4 58 01 00 00 	add    $0x158,%rsp
    5e8e:	5b                   	pop    %rbx
    5e8f:	41 5c                	pop    %r12
    5e91:	41 5d                	pop    %r13
    5e93:	41 5e                	pop    %r14
    5e95:	41 5f                	pop    %r15
    5e97:	5d                   	pop    %rbp
    5e98:	c3                   	ret
    5e99:	48 8d 3d 03 92 00 00 	lea    0x9203(%rip),%rdi        # f0a3 <exec_in_fp0+0xa53>
    5ea0:	e8 8b c1 ff ff       	call   2030 <getenv@plt>
    5ea5:	48 85 c0             	test   %rax,%rax
    5ea8:	74 27                	je     5ed1 <fwp_exec+0x1a1>
    5eaa:	48 8d 35 fa 91 00 00 	lea    0x91fa(%rip),%rsi        # f0ab <exec_in_fp0+0xa5b>
    5eb1:	48 89 c7             	mov    %rax,%rdi
    5eb4:	e8 17 c4 ff ff       	call   22d0 <strcmp@plt>
    5eb9:	31 c9                	xor    %ecx,%ecx
    5ebb:	85 c0                	test   %eax,%eax
    5ebd:	0f 94 c1             	sete   %cl
    5ec0:	89 0d 5a ff 01 00    	mov    %ecx,0x1ff5a(%rip)        # 25e20 <fwp_exec_binary_out>
    5ec6:	75 26                	jne    5eee <fwp_exec+0x1be>
    5ec8:	48 8b 05 11 e1 00 00 	mov    0xe111(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    5ecf:	eb 24                	jmp    5ef5 <fwp_exec+0x1c5>
    5ed1:	c7 05 45 ff 01 00 00 	movl   $0x0,0x1ff45(%rip)        # 25e20 <fwp_exec_binary_out>
    5ed8:	00 00 00 
    5edb:	48 8b 05 d6 e0 00 00 	mov    0xe0d6(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    5ee2:	48 8b 00             	mov    (%rax),%rax
    5ee5:	48 89 05 bc fe 00 00 	mov    %rax,0xfebc(%rip)        # 15da8 <fwp_prog_out>
    5eec:	eb 33                	jmp    5f21 <fwp_exec+0x1f1>
    5eee:	48 8b 05 c3 e0 00 00 	mov    0xe0c3(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    5ef5:	48 8b 00             	mov    (%rax),%rax
    5ef8:	48 89 05 a9 fe 00 00 	mov    %rax,0xfea9(%rip)        # 15da8 <fwp_prog_out>
    5eff:	75 20                	jne    5f21 <fwp_exec+0x1f1>
    5f01:	e8 da 0b 00 00       	call   6ae0 <fwp_pipe_out_start>
    5f06:	48 8d 3d 03 87 00 00 	lea    0x8703(%rip),%rdi        # e610 <exec_out_header0>
    5f0d:	be 3c 00 00 00       	mov    $0x3c,%esi
    5f12:	e8 99 0c 00 00       	call   6bb0 <fwp_pipe_write>
    5f17:	e8 44 0d 00 00       	call   6c60 <fwp_pipe_flush>
    5f1c:	e8 6f 0d 00 00       	call   6c90 <fwp_pipe_out_ready>
    5f21:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%rsp)
    5f28:	00 
    5f29:	83 7c 24 14 00       	cmpl   $0x0,0x14(%rsp)
    5f2e:	0f 84 57 01 00 00    	je     608b <fwp_exec+0x35b>
    5f34:	48 8b 1d 85 e0 00 00 	mov    0xe085(%rip),%rbx        # 13fc0 <stdin@GLIBC_2.2.5>
    5f3b:	48 8b 3b             	mov    (%rbx),%rdi
    5f3e:	b9 00 00 10 00       	mov    $0x100000,%ecx
    5f43:	31 f6                	xor    %esi,%esi
    5f45:	31 d2                	xor    %edx,%edx
    5f47:	e8 64 c4 ff ff       	call   23b0 <setvbuf@plt>
    5f4c:	48 8b 0b             	mov    (%rbx),%rcx
    5f4f:	48 8d 3d ce fe 01 00 	lea    0x1fece(%rip),%rdi        # 25e24 <fwp_in_pend>
    5f56:	be 01 00 00 00       	mov    $0x1,%esi
    5f5b:	ba 04 00 00 00       	mov    $0x4,%edx
    5f60:	e8 8b c1 ff ff       	call   20f0 <fread@plt>
    5f65:	89 05 bd fe 01 00    	mov    %eax,0x1febd(%rip)        # 25e28 <fwp_in_npend>
    5f6b:	c7 05 b7 fe 01 00 00 	movl   $0x0,0x1feb7(%rip)        # 25e2c <fwp_in_ppos>
    5f72:	00 00 00 
    5f75:	41 b4 01             	mov    $0x1,%r12b
    5f78:	83 f8 04             	cmp    $0x4,%eax
    5f7b:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    5f80:	0f 85 d3 01 00 00    	jne    6159 <fwp_exec+0x429>
    5f86:	81 3d 94 fe 01 00 46 	cmpl   $0x31505746,0x1fe94(%rip)        # 25e24 <fwp_in_pend>
    5f8d:	57 50 31 
    5f90:	0f 85 c3 01 00 00    	jne    6159 <fwp_exec+0x429>
    5f96:	c7 05 8c fe 01 00 04 	movl   $0x4,0x1fe8c(%rip)        # 25e2c <fwp_in_ppos>
    5f9d:	00 00 00 
    5fa0:	48 8d 7c 24 03       	lea    0x3(%rsp),%rdi
    5fa5:	be 01 00 00 00       	mov    $0x1,%esi
    5faa:	e8 41 0e 00 00       	call   6df0 <fwp_read_exact>
    5faf:	85 c0                	test   %eax,%eax
    5fb1:	0f 84 c3 03 00 00    	je     637a <fwp_exec+0x64a>
    5fb7:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
    5fbc:	e8 2f 0f 00 00       	call   6ef0 <fwp_stdin_leb>
    5fc1:	83 f8 01             	cmp    $0x1,%eax
    5fc4:	0f 85 99 03 00 00    	jne    6363 <fwp_exec+0x633>
    5fca:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    5fcf:	48 83 f8 40          	cmp    $0x40,%rax
    5fd3:	41 bd 40 00 00 00    	mov    $0x40,%r13d
    5fd9:	4c 0f 42 e8          	cmovb  %rax,%r13
    5fdd:	48 85 c0             	test   %rax,%rax
    5fe0:	0f 84 e2 00 00 00    	je     60c8 <fwp_exec+0x398>
    5fe6:	45 31 f6             	xor    %r14d,%r14d
    5fe9:	4c 8d 7c 24 50       	lea    0x50(%rsp),%r15
    5fee:	31 ed                	xor    %ebp,%ebp
    5ff0:	eb 4a                	jmp    603c <fwp_exec+0x30c>
    5ff2:	be 06 00 00 00       	mov    $0x6,%esi
    5ff7:	4c 89 ff             	mov    %r15,%rdi
    5ffa:	e8 f1 0d 00 00       	call   6df0 <fwp_read_exact>
    5fff:	85 c0                	test   %eax,%eax
    6001:	0f 84 73 03 00 00    	je     637a <fwp_exec+0x64a>
    6007:	8b 44 24 50          	mov    0x50(%rsp),%eax
    600b:	b9 55 44 53 5f       	mov    $0x5f534455,%ecx
    6010:	31 c8                	xor    %ecx,%eax
    6012:	0f b7 4c 24 54       	movzwl 0x54(%rsp),%ecx
    6017:	81 f1 56 31 00 00    	xor    $0x3156,%ecx
    601d:	09 c1                	or     %eax,%ecx
    601f:	b8 01 00 00 00       	mov    $0x1,%eax
    6024:	0f 44 e8             	cmove  %eax,%ebp
    6027:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
    602e:	00 00 
    6030:	49 ff c6             	inc    %r14
    6033:	4d 39 ee             	cmp    %r13,%r14
    6036:	0f 84 8e 00 00 00    	je     60ca <fwp_exec+0x39a>
    603c:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    6041:	e8 2a 0f 00 00       	call   6f70 <fwp_stdin_name_len>
    6046:	83 f8 01             	cmp    $0x1,%eax
    6049:	0f 85 14 03 00 00    	jne    6363 <fwp_exec+0x633>
    604f:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    6054:	48 85 db             	test   %rbx,%rbx
    6057:	74 ce                	je     6027 <fwp_exec+0x2f7>
    6059:	48 83 fb 06          	cmp    $0x6,%rbx
    605d:	74 93                	je     5ff2 <fwp_exec+0x2c2>
    605f:	90                   	nop
    6060:	48 81 fb 00 01 00 00 	cmp    $0x100,%rbx
    6067:	41 bc 00 01 00 00    	mov    $0x100,%r12d
    606d:	4c 0f 42 e3          	cmovb  %rbx,%r12
    6071:	4c 89 ff             	mov    %r15,%rdi
    6074:	4c 89 e6             	mov    %r12,%rsi
    6077:	e8 74 0d 00 00       	call   6df0 <fwp_read_exact>
    607c:	85 c0                	test   %eax,%eax
    607e:	0f 84 f6 02 00 00    	je     637a <fwp_exec+0x64a>
    6084:	4c 29 e3             	sub    %r12,%rbx
    6087:	75 d7                	jne    6060 <fwp_exec+0x330>
    6089:	eb 9c                	jmp    6027 <fwp_exec+0x2f7>
    608b:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
    6090:	4c 89 ff             	mov    %r15,%rdi
    6093:	e8 98 0c 00 00       	call   6d30 <fwp_exec_call>
    6098:	48 89 c3             	mov    %rax,%rbx
    609b:	48 8b 3d 06 fd 00 00 	mov    0xfd06(%rip),%rdi        # 15da8 <fwp_prog_out>
    60a2:	e8 a9 c2 ff ff       	call   2350 <fflush@plt>
    60a7:	41 be 01 00 00 00    	mov    $0x1,%r14d
    60ad:	83 7c 24 04 00       	cmpl   $0x0,0x4(%rsp)
    60b2:	0f 85 83 02 00 00    	jne    633b <fwp_exec+0x60b>
    60b8:	48 89 df             	mov    %rbx,%rdi
    60bb:	e8 20 0d 00 00       	call   6de0 <fwp_emit_result>
    60c0:	45 31 f6             	xor    %r14d,%r14d
    60c3:	e9 73 02 00 00       	jmp    633b <fwp_exec+0x60b>
    60c8:	31 ed                	xor    %ebp,%ebp
    60ca:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    60cf:	be 10 00 00 00       	mov    $0x10,%esi
    60d4:	e8 17 0d 00 00       	call   6df0 <fwp_read_exact>
    60d9:	85 c0                	test   %eax,%eax
    60db:	0f 84 99 02 00 00    	je     637a <fwp_exec+0x64a>
    60e1:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    60e6:	e8 85 0e 00 00       	call   6f70 <fwp_stdin_name_len>
    60eb:	83 f8 01             	cmp    $0x1,%eax
    60ee:	0f 85 6f 02 00 00    	jne    6363 <fwp_exec+0x633>
    60f4:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    60f9:	49 8d 7f 01          	lea    0x1(%r15),%rdi
    60fd:	e8 2e 07 00 00       	call   6830 <fwp_alloc_leaf>
    6102:	49 89 c6             	mov    %rax,%r14
    6105:	4d 85 ff             	test   %r15,%r15
    6108:	74 13                	je     611d <fwp_exec+0x3ed>
    610a:	4c 89 f7             	mov    %r14,%rdi
    610d:	4c 89 fe             	mov    %r15,%rsi
    6110:	e8 db 0c 00 00       	call   6df0 <fwp_read_exact>
    6115:	85 c0                	test   %eax,%eax
    6117:	0f 84 5d 02 00 00    	je     637a <fwp_exec+0x64a>
    611d:	43 c6 04 3e 00       	movb   $0x0,(%r14,%r15,1)
    6122:	0f b6 4c 24 03       	movzbl 0x3(%rsp),%ecx
    6127:	83 f9 01             	cmp    $0x1,%ecx
    612a:	0f 85 ab 02 00 00    	jne    63db <fwp_exec+0x6ab>
    6130:	66 0f 6f 44 24 30    	movdqa 0x30(%rsp),%xmm0
    6136:	66 0f 74 05 b2 7f 00 	pcmpeqb 0x7fb2(%rip),%xmm0        # e0f0 <_IO_stdin_used+0xf0>
    613d:	00 
    613e:	66 0f d7 c0          	pmovmskb %xmm0,%eax
    6142:	3d ff ff 00 00       	cmp    $0xffff,%eax
    6147:	0f 85 af 02 00 00    	jne    63fc <fwp_exec+0x6cc>
    614d:	85 ed                	test   %ebp,%ebp
    614f:	74 05                	je     6156 <fwp_exec+0x426>
    6151:	e8 4a 0e 00 00       	call   6fa0 <fwp_pipe_in_offer>
    6156:	45 31 e4             	xor    %r12d,%r12d
    6159:	66 0f ef c0          	pxor   %xmm0,%xmm0
    615d:	66 0f 7f 44 24 50    	movdqa %xmm0,0x50(%rsp)
    6163:	48 c7 44 24 60 00 00 	movq   $0x0,0x60(%rsp)
    616a:	00 00 
    616c:	45 31 ff             	xor    %r15d,%r15d
    616f:	45 31 f6             	xor    %r14d,%r14d
    6172:	eb 35                	jmp    61a9 <fwp_exec+0x479>
    6174:	48 89 ef             	mov    %rbp,%rdi
    6177:	4c 89 ee             	mov    %r13,%rsi
    617a:	e8 21 0f 00 00       	call   70a0 <fwp_pipe_in_switch>
    617f:	bb 10 00 00 00       	mov    $0x10,%ebx
    6184:	48 8d 35 9c 8f 00 00 	lea    0x8f9c(%rip),%rsi        # f127 <exec_in_fp0+0xad7>
    618b:	85 c0                	test   %eax,%eax
    618d:	0f 84 6b 01 00 00    	je     62fe <fwp_exec+0x5ce>
    6193:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    619a:	84 00 00 00 00 00 
    61a0:	83 fb 0f             	cmp    $0xf,%ebx
    61a3:	0f 84 83 01 00 00    	je     632c <fwp_exec+0x5fc>
    61a9:	45 84 e4             	test   %r12b,%r12b
    61ac:	0f 84 9e 00 00 00    	je     6250 <fwp_exec+0x520>
    61b2:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    61b7:	e8 44 15 00 00       	call   7700 <fwp_read_text_line>
    61bc:	4c 8b 7c 24 50       	mov    0x50(%rsp),%r15
    61c1:	85 c0                	test   %eax,%eax
    61c3:	0f 84 63 01 00 00    	je     632c <fwp_exec+0x5fc>
    61c9:	4d 85 ff             	test   %r15,%r15
    61cc:	4c 89 ff             	mov    %r15,%rdi
    61cf:	48 8d 05 ca 8b 00 00 	lea    0x8bca(%rip),%rax        # eda0 <exec_in_fp0+0x750>
    61d6:	48 0f 44 f8          	cmove  %rax,%rdi
    61da:	48 8b 74 24 58       	mov    0x58(%rsp),%rsi
    61df:	e8 6c 04 00 00       	call   6650 <fwp_str_lossy>
    61e4:	48 89 c5             	mov    %rax,%rbp
    61e7:	4c 8d 68 08          	lea    0x8(%rax),%r13
    61eb:	48 8b 30             	mov    (%rax),%rsi
    61ee:	4c 89 ef             	mov    %r13,%rdi
    61f1:	48 8d 54 24 20       	lea    0x20(%rsp),%rdx
    61f6:	e8 e5 07 00 00       	call   69e0 <fwp_parse_text>
    61fb:	85 c0                	test   %eax,%eax
    61fd:	0f 84 a1 01 00 00    	je     63a4 <fwp_exec+0x674>
    6203:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    6208:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    620d:	48 89 07             	mov    %rax,(%rdi)
    6210:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
    6215:	e8 16 0b 00 00       	call   6d30 <fwp_exec_call>
    621a:	49 89 c5             	mov    %rax,%r13
    621d:	48 8b 3d 84 fb 00 00 	mov    0xfb84(%rip),%rdi        # 15da8 <fwp_prog_out>
    6224:	e8 27 c1 ff ff       	call   2350 <fflush@plt>
    6229:	83 7c 24 04 00       	cmpl   $0x0,0x4(%rsp)
    622e:	0f 85 f2 00 00 00    	jne    6326 <fwp_exec+0x5f6>
    6234:	4c 89 ef             	mov    %r13,%rdi
    6237:	e8 a4 0b 00 00       	call   6de0 <fwp_emit_result>
    623c:	e8 1f 0a 00 00       	call   6c60 <fwp_pipe_flush>
    6241:	31 db                	xor    %ebx,%ebx
    6243:	e9 58 ff ff ff       	jmp    61a0 <fwp_exec+0x470>
    6248:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    624f:	00 
    6250:	be 01 00 00 00       	mov    $0x1,%esi
    6255:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    625a:	e8 91 0b 00 00       	call   6df0 <fwp_read_exact>
    625f:	bb 0f 00 00 00       	mov    $0xf,%ebx
    6264:	85 c0                	test   %eax,%eax
    6266:	0f 84 34 ff ff ff    	je     61a0 <fwp_exec+0x470>
    626c:	be 04 00 00 00       	mov    $0x4,%esi
    6271:	48 8d 7c 24 09       	lea    0x9(%rsp),%rdi
    6276:	e8 75 0b 00 00       	call   6df0 <fwp_read_exact>
    627b:	48 8d 35 90 8e 00 00 	lea    0x8e90(%rip),%rsi        # f112 <exec_in_fp0+0xac2>
    6282:	85 c0                	test   %eax,%eax
    6284:	74 78                	je     62fe <fwp_exec+0x5ce>
    6286:	44 8b 6c 24 09       	mov    0x9(%rsp),%r13d
    628b:	49 8d 7d 01          	lea    0x1(%r13),%rdi
    628f:	e8 9c 05 00 00       	call   6830 <fwp_alloc_leaf>
    6294:	48 89 c5             	mov    %rax,%rbp
    6297:	4d 85 ed             	test   %r13,%r13
    629a:	74 16                	je     62b2 <fwp_exec+0x582>
    629c:	48 89 ef             	mov    %rbp,%rdi
    629f:	4c 89 ee             	mov    %r13,%rsi
    62a2:	e8 49 0b 00 00       	call   6df0 <fwp_read_exact>
    62a7:	48 8d 35 64 8e 00 00 	lea    0x8e64(%rip),%rsi        # f112 <exec_in_fp0+0xac2>
    62ae:	85 c0                	test   %eax,%eax
    62b0:	74 4c                	je     62fe <fwp_exec+0x5ce>
    62b2:	0f b6 44 24 08       	movzbl 0x8(%rsp),%eax
    62b7:	85 c0                	test   %eax,%eax
    62b9:	0f 84 e1 fe ff ff    	je     61a0 <fwp_exec+0x470>
    62bf:	83 f8 02             	cmp    $0x2,%eax
    62c2:	0f 84 ac fe ff ff    	je     6174 <fwp_exec+0x444>
    62c8:	48 89 6c 24 30       	mov    %rbp,0x30(%rsp)
    62cd:	4c 89 6c 24 38       	mov    %r13,0x38(%rsp)
    62d2:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    62d9:	00 00 
    62db:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    62e0:	48 8d 35 49 fa 00 00 	lea    0xfa49(%rip),%rsi        # 15d30 <d0>
    62e7:	48 8d 54 24 20       	lea    0x20(%rsp),%rdx
    62ec:	e8 cf 0f 00 00       	call   72c0 <fwp_decode>
    62f1:	85 c0                	test   %eax,%eax
    62f3:	0f 85 0a ff ff ff    	jne    6203 <fwp_exec+0x4d3>
    62f9:	e9 2c 01 00 00       	jmp    642a <fwp_exec+0x6fa>
    62fe:	48 8b 05 db dc 00 00 	mov    0xdcdb(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    6305:	48 8b 38             	mov    (%rax),%rdi
    6308:	48 8d 15 6a 83 00 00 	lea    0x836a(%rip),%rdx        # e679 <exec_in_fp0+0x29>
    630f:	31 c0                	xor    %eax,%eax
    6311:	e8 da bf ff ff       	call   22f0 <fprintf@plt>
    6316:	41 be 03 00 00 00    	mov    $0x3,%r14d
    631c:	bb 0f 00 00 00       	mov    $0xf,%ebx
    6321:	e9 7a fe ff ff       	jmp    61a0 <fwp_exec+0x470>
    6326:	41 be 01 00 00 00    	mov    $0x1,%r14d
    632c:	31 ff                	xor    %edi,%edi
    632e:	e8 dd f4 ff ff       	call   5810 <fwp_mem_free>
    6333:	4c 89 ff             	mov    %r15,%rdi
    6336:	e8 15 bd ff ff       	call   2050 <free@plt>
    633b:	83 3d de fa 01 00 00 	cmpl   $0x0,0x1fade(%rip)        # 25e20 <fwp_exec_binary_out>
    6342:	0f 84 fb fa ff ff    	je     5e43 <fwp_exec+0x113>
    6348:	48 8d 3d bc 82 00 00 	lea    0x82bc(%rip),%rdi        # e60b <fwp_exec.end>
    634f:	be 05 00 00 00       	mov    $0x5,%esi
    6354:	e8 57 08 00 00       	call   6bb0 <fwp_pipe_write>
    6359:	e8 b2 14 00 00       	call   7810 <fwp_pipe_out_end>
    635e:	e9 e0 fa ff ff       	jmp    5e43 <fwp_exec+0x113>
    6363:	85 c0                	test   %eax,%eax
    6365:	79 13                	jns    637a <fwp_exec+0x64a>
    6367:	48 8b 05 72 dc 00 00 	mov    0xdc72(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    636e:	48 8b 38             	mov    (%rax),%rdi
    6371:	48 8d 35 ff 8d 00 00 	lea    0x8dff(%rip),%rsi        # f177 <exec_in_fp0+0xb27>
    6378:	eb 11                	jmp    638b <fwp_exec+0x65b>
    637a:	48 8b 05 5f dc 00 00 	mov    0xdc5f(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    6381:	48 8b 38             	mov    (%rax),%rdi
    6384:	48 8d 35 fc 8d 00 00 	lea    0x8dfc(%rip),%rsi        # f187 <exec_in_fp0+0xb37>
    638b:	48 8d 15 e7 82 00 00 	lea    0x82e7(%rip),%rdx        # e679 <exec_in_fp0+0x29>
    6392:	31 c0                	xor    %eax,%eax
    6394:	e8 57 bf ff ff       	call   22f0 <fprintf@plt>
    6399:	41 be 03 00 00 00    	mov    $0x3,%r14d
    639f:	e9 e0 fa ff ff       	jmp    5e84 <fwp_exec+0x154>
    63a4:	48 8b 05 35 dc 00 00 	mov    0xdc35(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    63ab:	48 8b 38             	mov    (%rax),%rdi
    63ae:	8b 4d 00             	mov    0x0(%rbp),%ecx
    63b1:	48 8d 35 9a 8d 00 00 	lea    0x8d9a(%rip),%rsi        # f152 <exec_in_fp0+0xb02>
    63b8:	48 8d 15 ba 82 00 00 	lea    0x82ba(%rip),%rdx        # e679 <exec_in_fp0+0x29>
    63bf:	4c 8d 0d d9 90 00 00 	lea    0x90d9(%rip),%r9        # f49f <exec_in_fp0+0xe4f>
    63c6:	4d 89 e8             	mov    %r13,%r8
    63c9:	31 c0                	xor    %eax,%eax
    63cb:	e8 20 bf ff ff       	call   22f0 <fprintf@plt>
    63d0:	41 be 03 00 00 00    	mov    $0x3,%r14d
    63d6:	e9 51 ff ff ff       	jmp    632c <fwp_exec+0x5fc>
    63db:	48 8b 05 fe db 00 00 	mov    0xdbfe(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    63e2:	48 8b 38             	mov    (%rax),%rdi
    63e5:	48 8d 35 cf 8c 00 00 	lea    0x8ccf(%rip),%rsi        # f0bb <exec_in_fp0+0xa6b>
    63ec:	48 8d 15 86 82 00 00 	lea    0x8286(%rip),%rdx        # e679 <exec_in_fp0+0x29>
    63f3:	31 c0                	xor    %eax,%eax
    63f5:	e8 f6 be ff ff       	call   22f0 <fprintf@plt>
    63fa:	eb 9d                	jmp    6399 <fwp_exec+0x669>
    63fc:	48 8b 05 dd db 00 00 	mov    0xdbdd(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    6403:	48 8b 38             	mov    (%rax),%rdi
    6406:	48 8d 35 d3 8c 00 00 	lea    0x8cd3(%rip),%rsi        # f0e0 <exec_in_fp0+0xa90>
    640d:	48 8d 15 65 82 00 00 	lea    0x8265(%rip),%rdx        # e679 <exec_in_fp0+0x29>
    6414:	48 8d 0d 84 90 00 00 	lea    0x9084(%rip),%rcx        # f49f <exec_in_fp0+0xe4f>
    641b:	4d 89 f0             	mov    %r14,%r8
    641e:	31 c0                	xor    %eax,%eax
    6420:	e8 cb be ff ff       	call   22f0 <fprintf@plt>
    6425:	e9 6f ff ff ff       	jmp    6399 <fwp_exec+0x669>
    642a:	48 8b 05 af db 00 00 	mov    0xdbaf(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    6431:	48 8b 38             	mov    (%rax),%rdi
    6434:	48 8d 35 02 8d 00 00 	lea    0x8d02(%rip),%rsi        # f13d <exec_in_fp0+0xaed>
    643b:	48 8d 15 37 82 00 00 	lea    0x8237(%rip),%rdx        # e679 <exec_in_fp0+0x29>
    6442:	31 c0                	xor    %eax,%eax
    6444:	e8 a7 be ff ff       	call   22f0 <fprintf@plt>
    6449:	41 be 03 00 00 00    	mov    $0x3,%r14d
    644f:	e9 d8 fe ff ff       	jmp    632c <fwp_exec+0x5fc>
    6454:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    645b:	00 00 00 00 00 

0000000000006460 <fwp_segv>:
    6460:	53                   	push   %rbx
    6461:	48 8b 15 a0 f9 00 00 	mov    0xf9a0(%rip),%rdx        # 15e08 <fwp_main_stack_top>
    6468:	48 85 d2             	test   %rdx,%rdx
    646b:	74 29                	je     6496 <fwp_segv+0x36>
    646d:	48 8b 46 10          	mov    0x10(%rsi),%rax
    6471:	48 2b 15 98 f9 00 00 	sub    0xf998(%rip),%rdx        # 15e10 <fwp_main_stack_size>
    6478:	48 8d b2 00 00 f0 ff 	lea    -0x100000(%rdx),%rsi
    647f:	48 81 c2 00 00 10 00 	add    $0x100000,%rdx
    6486:	89 fb                	mov    %edi,%ebx
    6488:	48 89 c7             	mov    %rax,%rdi
    648b:	e8 40 00 00 00       	call   64d0 <fwp_near>
    6490:	89 df                	mov    %ebx,%edi
    6492:	85 c0                	test   %eax,%eax
    6494:	75 08                	jne    649e <fwp_segv+0x3e>
    6496:	31 f6                	xor    %esi,%esi
    6498:	5b                   	pop    %rbx
    6499:	e9 42 be ff ff       	jmp    22e0 <signal@plt>
    649e:	e8 4d cb ff ff       	call   2ff0 <fwp_flush>
    64a3:	48 8d 35 46 81 00 00 	lea    0x8146(%rip),%rsi        # e5f0 <fwp_segv.msg>
    64aa:	ba 1a 00 00 00       	mov    $0x1a,%edx
    64af:	bf 02 00 00 00       	mov    $0x2,%edi
    64b4:	e8 87 bc ff ff       	call   2140 <write@plt>
    64b9:	bf 65 00 00 00       	mov    $0x65,%edi
    64be:	e8 dd bb ff ff       	call   20a0 <_exit@plt>
    64c3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    64ca:	84 00 00 00 00 00 

00000000000064d0 <fwp_near>:
    64d0:	48 39 f7             	cmp    %rsi,%rdi
    64d3:	0f 93 c0             	setae  %al
    64d6:	48 39 d7             	cmp    %rdx,%rdi
    64d9:	0f 92 c1             	setb   %cl
    64dc:	20 c1                	and    %al,%cl
    64de:	0f b6 c1             	movzbl %cl,%eax
    64e1:	c3                   	ret
    64e2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    64e9:	1f 84 00 00 00 00 00 

00000000000064f0 <fwp_generated>:
    64f0:	55                   	push   %rbp
    64f1:	41 57                	push   %r15
    64f3:	41 56                	push   %r14
    64f5:	53                   	push   %rbx
    64f6:	50                   	push   %rax
    64f7:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    64fc:	85 ff                	test   %edi,%edi
    64fe:	0f 8e 14 01 00 00    	jle    6618 <fwp_generated+0x128>
    6504:	89 fd                	mov    %edi,%ebp
    6506:	49 89 f7             	mov    %rsi,%r15
    6509:	4c 8b 36             	mov    (%rsi),%r14
    650c:	48 8d 35 8a 8c 00 00 	lea    0x8c8a(%rip),%rsi        # f19d <exec_in_fp0+0xb4d>
    6513:	4c 89 f7             	mov    %r14,%rdi
    6516:	e8 b5 bd ff ff       	call   22d0 <strcmp@plt>
    651b:	85 c0                	test   %eax,%eax
    651d:	74 34                	je     6553 <fwp_generated+0x63>
    651f:	48 8d 35 7d 8c 00 00 	lea    0x8c7d(%rip),%rsi        # f1a3 <exec_in_fp0+0xb53>
    6526:	ba 0d 00 00 00       	mov    $0xd,%edx
    652b:	4c 89 f7             	mov    %r14,%rdi
    652e:	e8 5d bb ff ff       	call   2090 <strncmp@plt>
    6533:	85 c0                	test   %eax,%eax
    6535:	0f 85 dd 00 00 00    	jne    6618 <fwp_generated+0x128>
    653b:	41 0f b6 46 0d       	movzbl 0xd(%r14),%eax
    6540:	85 c0                	test   %eax,%eax
    6542:	74 2c                	je     6570 <fwp_generated+0x80>
    6544:	83 f8 3d             	cmp    $0x3d,%eax
    6547:	0f 85 cb 00 00 00    	jne    6618 <fwp_generated+0x128>
    654d:	49 83 c6 0e          	add    $0xe,%r14
    6551:	eb 2a                	jmp    657d <fwp_generated+0x8d>
    6553:	48 8b 3d 9e f8 00 00 	mov    0xf89e(%rip),%rdi        # 15df8 <fwp_cli_man>
    655a:	48 8b 05 57 da 00 00 	mov    0xda57(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    6561:	48 8b 30             	mov    (%rax),%rsi
    6564:	e8 87 bc ff ff       	call   21f0 <fputs@plt>
    6569:	31 db                	xor    %ebx,%ebx
    656b:	e9 a8 00 00 00       	jmp    6618 <fwp_generated+0x128>
    6570:	83 fd 01             	cmp    $0x1,%ebp
    6573:	0f 84 ac 00 00 00    	je     6625 <fwp_generated+0x135>
    6579:	4d 8b 77 08          	mov    0x8(%r15),%r14
    657d:	48 8d 35 6b 8c 00 00 	lea    0x8c6b(%rip),%rsi        # f1ef <exec_in_fp0+0xb9f>
    6584:	4c 89 f7             	mov    %r14,%rdi
    6587:	e8 44 bd ff ff       	call   22d0 <strcmp@plt>
    658c:	31 db                	xor    %ebx,%ebx
    658e:	85 c0                	test   %eax,%eax
    6590:	74 63                	je     65f5 <fwp_generated+0x105>
    6592:	48 8d 35 5b 8c 00 00 	lea    0x8c5b(%rip),%rsi        # f1f4 <exec_in_fp0+0xba4>
    6599:	4c 89 f7             	mov    %r14,%rdi
    659c:	e8 2f bd ff ff       	call   22d0 <strcmp@plt>
    65a1:	85 c0                	test   %eax,%eax
    65a3:	74 54                	je     65f9 <fwp_generated+0x109>
    65a5:	48 8d 35 4c 8c 00 00 	lea    0x8c4c(%rip),%rsi        # f1f8 <exec_in_fp0+0xba8>
    65ac:	4c 89 f7             	mov    %r14,%rdi
    65af:	e8 1c bd ff ff       	call   22d0 <strcmp@plt>
    65b4:	b9 02 00 00 00       	mov    $0x2,%ecx
    65b9:	85 c0                	test   %eax,%eax
    65bb:	74 41                	je     65fe <fwp_generated+0x10e>
    65bd:	4c 89 f7             	mov    %r14,%rdi
    65c0:	e8 ab bb ff ff       	call   2170 <strlen@plt>
    65c5:	4c 89 f7             	mov    %r14,%rdi
    65c8:	48 89 c6             	mov    %rax,%rsi
    65cb:	e8 80 00 00 00       	call   6650 <fwp_str_lossy>
    65d0:	48 8b 0d 09 da 00 00 	mov    0xda09(%rip),%rcx        # 13fe0 <stderr@GLIBC_2.2.5>
    65d7:	48 8b 39             	mov    (%rcx),%rdi
    65da:	48 8d 48 08          	lea    0x8(%rax),%rcx
    65de:	48 8d 35 18 8c 00 00 	lea    0x8c18(%rip),%rsi        # f1fd <exec_in_fp0+0xbad>
    65e5:	48 8d 15 8d 80 00 00 	lea    0x808d(%rip),%rdx        # e679 <exec_in_fp0+0x29>
    65ec:	31 c0                	xor    %eax,%eax
    65ee:	e8 fd bc ff ff       	call   22f0 <fprintf@plt>
    65f3:	eb 4f                	jmp    6644 <fwp_generated+0x154>
    65f5:	31 c9                	xor    %ecx,%ecx
    65f7:	eb 05                	jmp    65fe <fwp_generated+0x10e>
    65f9:	b9 01 00 00 00       	mov    $0x1,%ecx
    65fe:	48 8d 05 db f7 00 00 	lea    0xf7db(%rip),%rax        # 15de0 <fwp_cli_scripts>
    6605:	48 8b 3c c8          	mov    (%rax,%rcx,8),%rdi
    6609:	48 8b 05 a8 d9 00 00 	mov    0xd9a8(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    6610:	48 8b 30             	mov    (%rax),%rsi
    6613:	e8 d8 bb ff ff       	call   21f0 <fputs@plt>
    6618:	89 d8                	mov    %ebx,%eax
    661a:	48 83 c4 08          	add    $0x8,%rsp
    661e:	5b                   	pop    %rbx
    661f:	41 5e                	pop    %r14
    6621:	41 5f                	pop    %r15
    6623:	5d                   	pop    %rbp
    6624:	c3                   	ret
    6625:	48 8b 05 b4 d9 00 00 	mov    0xd9b4(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    662c:	48 8b 38             	mov    (%rax),%rdi
    662f:	48 8d 35 7b 8b 00 00 	lea    0x8b7b(%rip),%rsi        # f1b1 <exec_in_fp0+0xb61>
    6636:	48 8d 15 3c 80 00 00 	lea    0x803c(%rip),%rdx        # e679 <exec_in_fp0+0x29>
    663d:	31 c0                	xor    %eax,%eax
    663f:	e8 ac bc ff ff       	call   22f0 <fprintf@plt>
    6644:	bb 02 00 00 00       	mov    $0x2,%ebx
    6649:	eb cd                	jmp    6618 <fwp_generated+0x128>
    664b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006650 <fwp_str_lossy>:
    6650:	55                   	push   %rbp
    6651:	41 57                	push   %r15
    6653:	41 56                	push   %r14
    6655:	41 55                	push   %r13
    6657:	41 54                	push   %r12
    6659:	53                   	push   %rbx
    665a:	48 83 ec 18          	sub    $0x18,%rsp
    665e:	48 89 f3             	mov    %rsi,%rbx
    6661:	49 89 fe             	mov    %rdi,%r14
    6664:	e8 27 12 00 00       	call   7890 <fwp_valid_utf8>
    6669:	85 c0                	test   %eax,%eax
    666b:	74 19                	je     6686 <fwp_str_lossy+0x36>
    666d:	4c 89 f7             	mov    %r14,%rdi
    6670:	48 89 de             	mov    %rbx,%rsi
    6673:	48 83 c4 18          	add    $0x18,%rsp
    6677:	5b                   	pop    %rbx
    6678:	41 5c                	pop    %r12
    667a:	41 5d                	pop    %r13
    667c:	41 5e                	pop    %r14
    667e:	41 5f                	pop    %r15
    6680:	5d                   	pop    %rbp
    6681:	e9 6a 13 00 00       	jmp    79f0 <fwp_str_new>
    6686:	0f 57 c0             	xorps  %xmm0,%xmm0
    6689:	0f 29 04 24          	movaps %xmm0,(%rsp)
    668d:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    6694:	00 00 
    6696:	48 85 db             	test   %rbx,%rbx
    6699:	0f 84 72 01 00 00    	je     6811 <fwp_str_lossy+0x1c1>
    669f:	45 31 ed             	xor    %r13d,%r13d
    66a2:	49 89 e7             	mov    %rsp,%r15
    66a5:	4c 8d 25 7d 8b 00 00 	lea    0x8b7d(%rip),%r12        # f229 <exec_in_fp0+0xbd9>
    66ac:	eb 19                	jmp    66c7 <fwp_str_lossy+0x77>
    66ae:	66 90                	xchg   %ax,%ax
    66b0:	4c 89 ff             	mov    %r15,%rdi
    66b3:	4c 89 e6             	mov    %r12,%rsi
    66b6:	e8 95 13 00 00       	call   7a50 <buf_puts>
    66bb:	49 89 ed             	mov    %rbp,%r13
    66be:	48 39 dd             	cmp    %rbx,%rbp
    66c1:	0f 83 4a 01 00 00    	jae    6811 <fwp_str_lossy+0x1c1>
    66c7:	43 0f b6 04 2e       	movzbl (%r14,%r13,1),%eax
    66cc:	84 c0                	test   %al,%al
    66ce:	78 20                	js     66f0 <fwp_str_lossy+0xa0>
    66d0:	0f be f0             	movsbl %al,%esi
    66d3:	4c 89 ff             	mov    %r15,%rdi
    66d6:	e8 55 13 00 00       	call   7a30 <buf_putc>
    66db:	49 ff c5             	inc    %r13
    66de:	4c 89 ed             	mov    %r13,%rbp
    66e1:	eb d8                	jmp    66bb <fwp_str_lossy+0x6b>
    66e3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    66ea:	84 00 00 00 00 00 
    66f0:	8d 48 20             	lea    0x20(%rax),%ecx
    66f3:	80 f9 e1             	cmp    $0xe1,%cl
    66f6:	77 34                	ja     672c <fwp_str_lossy+0xdc>
    66f8:	89 c2                	mov    %eax,%edx
    66fa:	80 e2 f0             	and    $0xf0,%dl
    66fd:	80 fa e0             	cmp    $0xe0,%dl
    6700:	0f 85 cb 00 00 00    	jne    67d1 <fwp_str_lossy+0x181>
    6706:	3c e0                	cmp    $0xe0,%al
    6708:	40 0f 94 c6          	sete   %sil
    670c:	40 c0 e6 05          	shl    $0x5,%sil
    6710:	40 80 ce 80          	or     $0x80,%sil
    6714:	31 ff                	xor    %edi,%edi
    6716:	3c ed                	cmp    $0xed,%al
    6718:	40 0f 95 c7          	setne  %dil
    671c:	c1 e7 05             	shl    $0x5,%edi
    671f:	81 cf 9f 00 00 00    	or     $0x9f,%edi
    6725:	b8 02 00 00 00       	mov    $0x2,%eax
    672a:	eb 0d                	jmp    6739 <fwp_str_lossy+0xe9>
    672c:	bf bf 00 00 00       	mov    $0xbf,%edi
    6731:	40 b6 80             	mov    $0x80,%sil
    6734:	b8 01 00 00 00       	mov    $0x1,%eax
    6739:	31 d2                	xor    %edx,%edx
    673b:	49 8d 6d 01          	lea    0x1(%r13),%rbp
    673f:	48 39 dd             	cmp    %rbx,%rbp
    6742:	0f 83 68 ff ff ff    	jae    66b0 <fwp_str_lossy+0x60>
    6748:	45 0f b6 04 2e       	movzbl (%r14,%rbp,1),%r8d
    674d:	41 38 f0             	cmp    %sil,%r8b
    6750:	0f 82 5a ff ff ff    	jb     66b0 <fwp_str_lossy+0x60>
    6756:	44 39 c7             	cmp    %r8d,%edi
    6759:	0f 82 51 ff ff ff    	jb     66b0 <fwp_str_lossy+0x60>
    675f:	49 8d 6d 02          	lea    0x2(%r13),%rbp
    6763:	be 01 00 00 00       	mov    $0x1,%esi
    6768:	80 f9 e1             	cmp    $0xe1,%cl
    676b:	77 45                	ja     67b2 <fwp_str_lossy+0x162>
    676d:	48 39 dd             	cmp    %rbx,%rbp
    6770:	73 40                	jae    67b2 <fwp_str_lossy+0x162>
    6772:	41 0f b6 0c 2e       	movzbl (%r14,%rbp,1),%ecx
    6777:	80 e1 c0             	and    $0xc0,%cl
    677a:	80 f9 80             	cmp    $0x80,%cl
    677d:	75 33                	jne    67b2 <fwp_str_lossy+0x162>
    677f:	49 8d 6d 03          	lea    0x3(%r13),%rbp
    6783:	48 39 dd             	cmp    %rbx,%rbp
    6786:	0f 93 c1             	setae  %cl
    6789:	80 f2 01             	xor    $0x1,%dl
    678c:	be 02 00 00 00       	mov    $0x2,%esi
    6791:	08 ca                	or     %cl,%dl
    6793:	75 1d                	jne    67b2 <fwp_str_lossy+0x162>
    6795:	43 0f b6 4c 2e 03    	movzbl 0x3(%r14,%r13,1),%ecx
    679b:	80 e1 c0             	and    $0xc0,%cl
    679e:	31 f6                	xor    %esi,%esi
    67a0:	80 f9 80             	cmp    $0x80,%cl
    67a3:	0f 94 c1             	sete   %cl
    67a6:	75 04                	jne    67ac <fwp_str_lossy+0x15c>
    67a8:	49 8d 6d 04          	lea    0x4(%r13),%rbp
    67ac:	40 88 ce             	mov    %cl,%sil
    67af:	83 ce 02             	or     $0x2,%esi
    67b2:	39 c6                	cmp    %eax,%esi
    67b4:	0f 85 f6 fe ff ff    	jne    66b0 <fwp_str_lossy+0x60>
    67ba:	4b 8d 34 2e          	lea    (%r14,%r13,1),%rsi
    67be:	48 89 ea             	mov    %rbp,%rdx
    67c1:	4c 29 ea             	sub    %r13,%rdx
    67c4:	4c 89 ff             	mov    %r15,%rdi
    67c7:	e8 b4 12 00 00       	call   7a80 <buf_put>
    67cc:	e9 ea fe ff ff       	jmp    66bb <fwp_str_lossy+0x6b>
    67d1:	8d 50 10             	lea    0x10(%rax),%edx
    67d4:	80 fa 04             	cmp    $0x4,%dl
    67d7:	77 28                	ja     6801 <fwp_str_lossy+0x1b1>
    67d9:	3c f0                	cmp    $0xf0,%al
    67db:	40 0f 94 c6          	sete   %sil
    67df:	bf 8f 00 00 00       	mov    $0x8f,%edi
    67e4:	3c f4                	cmp    $0xf4,%al
    67e6:	74 05                	je     67ed <fwp_str_lossy+0x19d>
    67e8:	bf bf 00 00 00       	mov    $0xbf,%edi
    67ed:	40 c0 e6 04          	shl    $0x4,%sil
    67f1:	40 80 ce 80          	or     $0x80,%sil
    67f5:	b8 03 00 00 00       	mov    $0x3,%eax
    67fa:	b2 01                	mov    $0x1,%dl
    67fc:	e9 3a ff ff ff       	jmp    673b <fwp_str_lossy+0xeb>
    6801:	4c 89 ff             	mov    %r15,%rdi
    6804:	4c 89 e6             	mov    %r12,%rsi
    6807:	e8 44 12 00 00       	call   7a50 <buf_puts>
    680c:	e9 ca fe ff ff       	jmp    66db <fwp_str_lossy+0x8b>
    6811:	48 89 e7             	mov    %rsp,%rdi
    6814:	e8 a7 12 00 00       	call   7ac0 <buf_to_str>
    6819:	48 83 c4 18          	add    $0x18,%rsp
    681d:	5b                   	pop    %rbx
    681e:	41 5c                	pop    %r12
    6820:	41 5d                	pop    %r13
    6822:	41 5e                	pop    %r14
    6824:	41 5f                	pop    %r15
    6826:	5d                   	pop    %rbp
    6827:	c3                   	ret
    6828:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    682f:	00 

0000000000006830 <fwp_alloc_leaf>:
    6830:	be 01 00 00 00       	mov    $0x1,%esi
    6835:	e9 a6 ca ff ff       	jmp    32e0 <fwp_gc_alloc>
    683a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000006840 <fwp_cli_parse>:
    6840:	c7 01 00 00 00 00    	movl   $0x0,(%rcx)
    6846:	85 ff                	test   %edi,%edi
    6848:	0f 8e 6d 01 00 00    	jle    69bb <fwp_cli_parse+0x17b>
    684e:	55                   	push   %rbp
    684f:	41 57                	push   %r15
    6851:	41 56                	push   %r14
    6853:	41 55                	push   %r13
    6855:	41 54                	push   %r12
    6857:	53                   	push   %rbx
    6858:	48 83 ec 28          	sub    $0x28,%rsp
    685c:	41 89 f8             	mov    %edi,%r8d
    685f:	4d 89 c1             	mov    %r8,%r9
    6862:	49 f7 d9             	neg    %r9
    6865:	40 b5 01             	mov    $0x1,%bpl
    6868:	45 31 ff             	xor    %r15d,%r15d
    686b:	41 be 01 00 00 00    	mov    $0x1,%r14d
    6871:	31 db                	xor    %ebx,%ebx
    6873:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
    6878:	48 89 74 24 18       	mov    %rsi,0x18(%rsp)
    687d:	4c 89 44 24 10       	mov    %r8,0x10(%rsp)
    6882:	4c 89 4c 24 08       	mov    %r9,0x8(%rsp)
    6887:	48 89 0c 24          	mov    %rcx,(%rsp)
    688b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    6890:	4e 8b 6c f6 f8       	mov    -0x8(%rsi,%r14,8),%r13
    6895:	85 db                	test   %ebx,%ebx
    6897:	75 37                	jne    68d0 <fwp_cli_parse+0x90>
    6899:	4d 8b 65 00          	mov    0x0(%r13),%r12
    689d:	49 83 fc 02          	cmp    $0x2,%r12
    68a1:	72 2d                	jb     68d0 <fwp_cli_parse+0x90>
    68a3:	49 8d 7d 08          	lea    0x8(%r13),%rdi
    68a7:	80 3f 2d             	cmpb   $0x2d,(%rdi)
    68aa:	75 24                	jne    68d0 <fwp_cli_parse+0x90>
    68ac:	e8 ff 12 00 00       	call   7bb0 <fwp_is_number_arg>
    68b1:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    68b6:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    68bb:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    68c0:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    68c5:	48 8b 0c 24          	mov    (%rsp),%rcx
    68c9:	85 c0                	test   %eax,%eax
    68cb:	74 2f                	je     68fc <fwp_cli_parse+0xbc>
    68cd:	0f 1f 00             	nopl   (%rax)
    68d0:	49 63 c7             	movslq %r15d,%rax
    68d3:	41 8d 7f 01          	lea    0x1(%r15),%edi
    68d7:	89 39                	mov    %edi,(%rcx)
    68d9:	4c 89 2c c2          	mov    %r13,(%rdx,%rax,8)
    68dd:	41 89 ff             	mov    %edi,%r15d
    68e0:	4d 39 c6             	cmp    %r8,%r14
    68e3:	40 0f 92 c5          	setb   %bpl
    68e7:	4b 8d 04 31          	lea    (%r9,%r14,1),%rax
    68eb:	48 ff c0             	inc    %rax
    68ee:	49 ff c6             	inc    %r14
    68f1:	48 83 f8 01          	cmp    $0x1,%rax
    68f5:	75 99                	jne    6890 <fwp_cli_parse+0x50>
    68f7:	e9 a9 00 00 00       	jmp    69a5 <fwp_cli_parse+0x165>
    68fc:	41 0f b6 45 09       	movzbl 0x9(%r13),%eax
    6901:	49 83 fc 02          	cmp    $0x2,%r12
    6905:	75 1a                	jne    6921 <fwp_cli_parse+0xe1>
    6907:	bb 01 00 00 00       	mov    $0x1,%ebx
    690c:	3c 2d                	cmp    $0x2d,%al
    690e:	74 d0                	je     68e0 <fwp_cli_parse+0xa0>
    6910:	31 db                	xor    %ebx,%ebx
    6912:	49 83 fc 02          	cmp    $0x2,%r12
    6916:	75 b8                	jne    68d0 <fwp_cli_parse+0x90>
    6918:	3c 68                	cmp    $0x68,%al
    691a:	75 b4                	jne    68d0 <fwp_cli_parse+0x90>
    691c:	e9 84 00 00 00       	jmp    69a5 <fwp_cli_parse+0x165>
    6921:	31 db                	xor    %ebx,%ebx
    6923:	3c 2d                	cmp    $0x2d,%al
    6925:	75 a9                	jne    68d0 <fwp_cli_parse+0x90>
    6927:	49 8d 5d 0a          	lea    0xa(%r13),%rbx
    692b:	49 83 c4 fe          	add    $0xfffffffffffffffe,%r12
    692f:	48 89 df             	mov    %rbx,%rdi
    6932:	be 3d 00 00 00       	mov    $0x3d,%esi
    6937:	4c 89 e2             	mov    %r12,%rdx
    693a:	e8 21 b9 ff ff       	call   2260 <memchr@plt>
    693f:	48 89 c1             	mov    %rax,%rcx
    6942:	48 29 d9             	sub    %rbx,%rcx
    6945:	48 85 c0             	test   %rax,%rax
    6948:	49 0f 44 cc          	cmove  %r12,%rcx
    694c:	75 38                	jne    6986 <fwp_cli_parse+0x146>
    694e:	48 83 f9 04          	cmp    $0x4,%rcx
    6952:	48 8b 0c 24          	mov    (%rsp),%rcx
    6956:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    695b:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    6960:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    6965:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    696a:	75 13                	jne    697f <fwp_cli_parse+0x13f>
    696c:	81 3b 68 65 6c 70    	cmpl   $0x706c6568,(%rbx)
    6972:	bb 00 00 00 00       	mov    $0x0,%ebx
    6977:	0f 85 53 ff ff ff    	jne    68d0 <fwp_cli_parse+0x90>
    697d:	eb 26                	jmp    69a5 <fwp_cli_parse+0x165>
    697f:	31 db                	xor    %ebx,%ebx
    6981:	e9 4a ff ff ff       	jmp    68d0 <fwp_cli_parse+0x90>
    6986:	48 8b 0c 24          	mov    (%rsp),%rcx
    698a:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    698f:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    6994:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    6999:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    699e:	31 db                	xor    %ebx,%ebx
    69a0:	e9 2b ff ff ff       	jmp    68d0 <fwp_cli_parse+0x90>
    69a5:	40 0f b6 c5          	movzbl %bpl,%eax
    69a9:	83 e0 01             	and    $0x1,%eax
    69ac:	48 83 c4 28          	add    $0x28,%rsp
    69b0:	5b                   	pop    %rbx
    69b1:	41 5c                	pop    %r12
    69b3:	41 5d                	pop    %r13
    69b5:	41 5e                	pop    %r14
    69b7:	41 5f                	pop    %r15
    69b9:	5d                   	pop    %rbp
    69ba:	c3                   	ret
    69bb:	31 c0                	xor    %eax,%eax
    69bd:	c3                   	ret
    69be:	66 90                	xchg   %ax,%ax

00000000000069c0 <fwp_usage_error>:
    69c0:	48 8b 05 19 d6 00 00 	mov    0xd619(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    69c7:	48 8b 38             	mov    (%rax),%rdi
    69ca:	48 8d 35 f5 88 00 00 	lea    0x88f5(%rip),%rsi        # f2c6 <exec_in_fp0+0xc76>
    69d1:	48 8d 15 01 8a 00 00 	lea    0x8a01(%rip),%rdx        # f3d9 <exec_in_fp0+0xd89>
    69d8:	31 c0                	xor    %eax,%eax
    69da:	e9 11 b9 ff ff       	jmp    22f0 <fprintf@plt>
    69df:	90                   	nop

00000000000069e0 <fwp_parse_text>:
    69e0:	48 83 ec 18          	sub    $0x18,%rsp
    69e4:	48 89 d1             	mov    %rdx,%rcx
    69e7:	48 89 3c 24          	mov    %rdi,(%rsp)
    69eb:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    69f0:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    69f7:	00 00 
    69f9:	48 8d 35 30 f3 00 00 	lea    0xf330(%rip),%rsi        # 15d30 <d0>
    6a00:	48 89 e7             	mov    %rsp,%rdi
    6a03:	ba 01 00 00 00       	mov    $0x1,%edx
    6a08:	e8 a3 16 00 00       	call   80b0 <tp_value>
    6a0d:	85 c0                	test   %eax,%eax
    6a0f:	74 1c                	je     6a2d <fwp_parse_text+0x4d>
    6a11:	48 89 e7             	mov    %rsp,%rdi
    6a14:	e8 c7 1f 00 00       	call   89e0 <tp_ws>
    6a19:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    6a1e:	31 c0                	xor    %eax,%eax
    6a20:	48 3b 4c 24 08       	cmp    0x8(%rsp),%rcx
    6a25:	0f 94 c0             	sete   %al
    6a28:	48 83 c4 18          	add    $0x18,%rsp
    6a2c:	c3                   	ret
    6a2d:	31 c0                	xor    %eax,%eax
    6a2f:	48 83 c4 18          	add    $0x18,%rsp
    6a33:	c3                   	ret
    6a34:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    6a3b:	00 00 00 00 00 

0000000000006a40 <fwp_parse_arg>:
    6a40:	53                   	push   %rbx
    6a41:	48 83 ec 10          	sub    $0x10,%rsp
    6a45:	89 fb                	mov    %edi,%ebx
    6a47:	48 8b 06             	mov    (%rsi),%rax
    6a4a:	48 8d 7e 08          	lea    0x8(%rsi),%rdi
    6a4e:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    6a53:	48 89 c6             	mov    %rax,%rsi
    6a56:	e8 85 12 00 00       	call   7ce0 <fwp_cli_value>
    6a5b:	89 c1                	mov    %eax,%ecx
    6a5d:	b8 01 00 00 00       	mov    $0x1,%eax
    6a62:	85 c9                	test   %ecx,%ecx
    6a64:	74 06                	je     6a6c <fwp_parse_arg+0x2c>
    6a66:	48 83 c4 10          	add    $0x10,%rsp
    6a6a:	5b                   	pop    %rbx
    6a6b:	c3                   	ret
    6a6c:	48 8b 05 6d d5 00 00 	mov    0xd56d(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    6a73:	48 8b 38             	mov    (%rax),%rdi
    6a76:	ff c3                	inc    %ebx
    6a78:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
    6a7d:	49 83 c0 08          	add    $0x8,%r8
    6a81:	48 8d 35 2d 88 00 00 	lea    0x882d(%rip),%rsi        # f2b5 <exec_in_fp0+0xc65>
    6a88:	48 8d 15 ea 7b 00 00 	lea    0x7bea(%rip),%rdx        # e679 <exec_in_fp0+0x29>
    6a8f:	89 d9                	mov    %ebx,%ecx
    6a91:	31 c0                	xor    %eax,%eax
    6a93:	e8 58 b8 ff ff       	call   22f0 <fprintf@plt>
    6a98:	31 c0                	xor    %eax,%eax
    6a9a:	eb ca                	jmp    6a66 <fwp_parse_arg+0x26>
    6a9c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000006aa0 <fwp_bind_positional>:
    6aa0:	50                   	push   %rax
    6aa1:	31 c0                	xor    %eax,%eax
    6aa3:	85 f6                	test   %esi,%esi
    6aa5:	0f 9e c0             	setle  %al
    6aa8:	89 01                	mov    %eax,(%rcx)
    6aaa:	83 fe 01             	cmp    $0x1,%esi
    6aad:	76 0c                	jbe    6abb <fwp_bind_positional+0x1b>
    6aaf:	e8 0c ff ff ff       	call   69c0 <fwp_usage_error>
    6ab4:	b8 02 00 00 00       	mov    $0x2,%eax
    6ab9:	59                   	pop    %rcx
    6aba:	c3                   	ret
    6abb:	31 c0                	xor    %eax,%eax
    6abd:	83 fe 01             	cmp    $0x1,%esi
    6ac0:	75 f7                	jne    6ab9 <fwp_bind_positional+0x19>
    6ac2:	48 8b 37             	mov    (%rdi),%rsi
    6ac5:	31 ff                	xor    %edi,%edi
    6ac7:	e8 74 ff ff ff       	call   6a40 <fwp_parse_arg>
    6acc:	89 c1                	mov    %eax,%ecx
    6ace:	31 c0                	xor    %eax,%eax
    6ad0:	85 c9                	test   %ecx,%ecx
    6ad2:	0f 94 c0             	sete   %al
    6ad5:	01 c0                	add    %eax,%eax
    6ad7:	59                   	pop    %rcx
    6ad8:	c3                   	ret
    6ad9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000006ae0 <fwp_pipe_out_start>:
    6ae0:	41 56                	push   %r14
    6ae2:	53                   	push   %rbx
    6ae3:	48 81 ec 08 01 00 00 	sub    $0x108,%rsp
    6aea:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    6aef:	bf 01 00 00 00       	mov    $0x1,%edi
    6af4:	e8 e7 b9 ff ff       	call   24e0 <fstat@plt>
    6af9:	85 c0                	test   %eax,%eax
    6afb:	0f 85 82 00 00 00    	jne    6b83 <fwp_pipe_out_start+0xa3>
    6b01:	b8 00 f0 00 00       	mov    $0xf000,%eax
    6b06:	23 44 24 20          	and    0x20(%rsp),%eax
    6b0a:	3d 00 10 00 00       	cmp    $0x1000,%eax
    6b0f:	75 72                	jne    6b83 <fwp_pipe_out_start+0xa3>
    6b11:	bf 01 00 00 00       	mov    $0x1,%edi
    6b16:	be 07 04 00 00       	mov    $0x407,%esi
    6b1b:	ba 00 00 10 00       	mov    $0x100000,%edx
    6b20:	31 c0                	xor    %eax,%eax
    6b22:	e8 f9 b5 ff ff       	call   2120 <fcntl@plt>
    6b27:	e8 24 36 00 00       	call   a150 <fwp_transport_off>
    6b2c:	85 c0                	test   %eax,%eax
    6b2e:	75 53                	jne    6b83 <fwp_pipe_out_start+0xa3>
    6b30:	bf 01 00 00 00       	mov    $0x1,%edi
    6b35:	be 01 08 08 00       	mov    $0x80801,%esi
    6b3a:	31 d2                	xor    %edx,%edx
    6b3c:	e8 cf b9 ff ff       	call   2510 <socket@plt>
    6b41:	85 c0                	test   %eax,%eax
    6b43:	78 3e                	js     6b83 <fwp_pipe_out_start+0xa3>
    6b45:	89 c3                	mov    %eax,%ebx
    6b47:	4c 8d b4 24 9a 00 00 	lea    0x9a(%rsp),%r14
    6b4e:	00 
    6b4f:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    6b54:	4c 89 f7             	mov    %r14,%rdi
    6b57:	e8 24 36 00 00       	call   a180 <fwp_pipe_addr>
    6b5c:	89 df                	mov    %ebx,%edi
    6b5e:	4c 89 f6             	mov    %r14,%rsi
    6b61:	89 c2                	mov    %eax,%edx
    6b63:	e8 68 b8 ff ff       	call   23d0 <bind@plt>
    6b68:	85 c0                	test   %eax,%eax
    6b6a:	75 10                	jne    6b7c <fwp_pipe_out_start+0x9c>
    6b6c:	89 df                	mov    %ebx,%edi
    6b6e:	be 01 00 00 00       	mov    $0x1,%esi
    6b73:	e8 e8 b7 ff ff       	call   2360 <listen@plt>
    6b78:	85 c0                	test   %eax,%eax
    6b7a:	74 12                	je     6b8e <fwp_pipe_out_start+0xae>
    6b7c:	89 df                	mov    %ebx,%edi
    6b7e:	e8 ad b6 ff ff       	call   2230 <close@plt>
    6b83:	48 81 c4 08 01 00 00 	add    $0x108,%rsp
    6b8a:	5b                   	pop    %rbx
    6b8b:	41 5e                	pop    %r14
    6b8d:	c3                   	ret
    6b8e:	89 1d 28 f1 00 00    	mov    %ebx,0xf128(%rip)        # 15cbc <fwp_po_listen>
    6b94:	e8 37 36 00 00       	call   a1d0 <fwp_now_ns>
    6b99:	48 b9 00 f2 05 2a 01 	movabs $0x12a05f200,%rcx
    6ba0:	00 00 00 
    6ba3:	48 01 c1             	add    %rax,%rcx
    6ba6:	48 89 0d 8b f2 01 00 	mov    %rcx,0x1f28b(%rip)        # 25e38 <fwp_po_give_up>
    6bad:	eb d4                	jmp    6b83 <fwp_pipe_out_start+0xa3>
    6baf:	90                   	nop

0000000000006bb0 <fwp_pipe_write>:
    6bb0:	41 57                	push   %r15
    6bb2:	41 56                	push   %r14
    6bb4:	53                   	push   %rbx
    6bb5:	48 89 f3             	mov    %rsi,%rbx
    6bb8:	8b 05 82 f2 01 00    	mov    0x1f282(%rip),%eax        # 25e40 <fwp_po_kind>
    6bbe:	83 f8 01             	cmp    $0x1,%eax
    6bc1:	74 12                	je     6bd5 <fwp_pipe_write+0x25>
    6bc3:	83 f8 02             	cmp    $0x2,%eax
    6bc6:	75 46                	jne    6c0e <fwp_pipe_write+0x5e>
    6bc8:	48 89 de             	mov    %rbx,%rsi
    6bcb:	5b                   	pop    %rbx
    6bcc:	41 5e                	pop    %r14
    6bce:	41 5f                	pop    %r15
    6bd0:	e9 2b 36 00 00       	jmp    a200 <fwp_ring_put>
    6bd5:	49 89 fe             	mov    %rdi,%r14
    6bd8:	48 8b 05 69 f2 01 00 	mov    0x1f269(%rip),%rax        # 25e48 <fwp_po_len>
    6bdf:	48 01 d8             	add    %rbx,%rax
    6be2:	48 3d 01 00 01 00    	cmp    $0x10001,%rax
    6be8:	72 05                	jb     6bef <fwp_pipe_write+0x3f>
    6bea:	e8 71 37 00 00       	call   a360 <fwp_po_flush_sock>
    6bef:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    6bf6:	72 32                	jb     6c2a <fwp_pipe_write+0x7a>
    6bf8:	8b 3d c2 f0 00 00    	mov    0xf0c2(%rip),%edi        # 15cc0 <fwp_po_sock>
    6bfe:	4c 89 f6             	mov    %r14,%rsi
    6c01:	48 89 da             	mov    %rbx,%rdx
    6c04:	5b                   	pop    %rbx
    6c05:	41 5e                	pop    %r14
    6c07:	41 5f                	pop    %r15
    6c09:	e9 82 37 00 00       	jmp    a390 <fwp_po_write_raw>
    6c0e:	48 8b 05 a3 d3 00 00 	mov    0xd3a3(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    6c15:	48 8b 08             	mov    (%rax),%rcx
    6c18:	be 01 00 00 00       	mov    $0x1,%esi
    6c1d:	48 89 da             	mov    %rbx,%rdx
    6c20:	5b                   	pop    %rbx
    6c21:	41 5e                	pop    %r14
    6c23:	41 5f                	pop    %r15
    6c25:	e9 76 b8 ff ff       	jmp    24a0 <fwrite@plt>
    6c2a:	4c 8b 3d 17 f2 01 00 	mov    0x1f217(%rip),%r15        # 25e48 <fwp_po_len>
    6c31:	48 8d 3d 18 f2 01 00 	lea    0x1f218(%rip),%rdi        # 25e50 <fwp_po_buf>
    6c38:	4c 01 ff             	add    %r15,%rdi
    6c3b:	4c 89 f6             	mov    %r14,%rsi
    6c3e:	48 89 da             	mov    %rbx,%rdx
    6c41:	e8 ea b6 ff ff       	call   2330 <memcpy@plt>
    6c46:	49 01 df             	add    %rbx,%r15
    6c49:	4c 89 3d f8 f1 01 00 	mov    %r15,0x1f1f8(%rip)        # 25e48 <fwp_po_len>
    6c50:	5b                   	pop    %rbx
    6c51:	41 5e                	pop    %r14
    6c53:	41 5f                	pop    %r15
    6c55:	c3                   	ret
    6c56:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    6c5d:	00 00 00 

0000000000006c60 <fwp_pipe_flush>:
    6c60:	8b 05 da f1 01 00    	mov    0x1f1da(%rip),%eax        # 25e40 <fwp_po_kind>
    6c66:	85 c0                	test   %eax,%eax
    6c68:	74 0a                	je     6c74 <fwp_pipe_flush+0x14>
    6c6a:	83 f8 01             	cmp    $0x1,%eax
    6c6d:	75 1b                	jne    6c8a <fwp_pipe_flush+0x2a>
    6c6f:	e9 ec 36 00 00       	jmp    a360 <fwp_po_flush_sock>
    6c74:	50                   	push   %rax
    6c75:	48 8b 05 3c d3 00 00 	mov    0xd33c(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    6c7c:	48 8b 38             	mov    (%rax),%rdi
    6c7f:	e8 cc b6 ff ff       	call   2350 <fflush@plt>
    6c84:	58                   	pop    %rax
    6c85:	e9 e6 39 00 00       	jmp    a670 <fwp_pipe_poll>
    6c8a:	c3                   	ret
    6c8b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006c90 <fwp_pipe_out_ready>:
    6c90:	48 83 ec 18          	sub    $0x18,%rsp
    6c94:	48 8d 3d 69 86 00 00 	lea    0x8669(%rip),%rdi        # f304 <exec_in_fp0+0xcb4>
    6c9b:	e8 90 b3 ff ff       	call   2030 <getenv@plt>
    6ca0:	48 85 c0             	test   %rax,%rax
    6ca3:	74 79                	je     6d1e <fwp_pipe_out_ready+0x8e>
    6ca5:	83 3d 10 f0 00 00 00 	cmpl   $0x0,0xf010(%rip)        # 15cbc <fwp_po_listen>
    6cac:	78 70                	js     6d1e <fwp_pipe_out_ready+0x8e>
    6cae:	80 38 00             	cmpb   $0x0,(%rax)
    6cb1:	74 6b                	je     6d1e <fwp_pipe_out_ready+0x8e>
    6cb3:	48 89 c7             	mov    %rax,%rdi
    6cb6:	31 f6                	xor    %esi,%esi
    6cb8:	ba 0a 00 00 00       	mov    $0xa,%edx
    6cbd:	e8 5e b6 ff ff       	call   2320 <strtol@plt>
    6cc2:	8b 0d f4 ef 00 00    	mov    0xeff4(%rip),%ecx        # 15cbc <fwp_po_listen>
    6cc8:	89 0c 24             	mov    %ecx,(%rsp)
    6ccb:	48 b9 01 00 00 00 01 	movabs $0x100000001,%rcx
    6cd2:	00 00 00 
    6cd5:	48 89 4c 24 04       	mov    %rcx,0x4(%rsp)
    6cda:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%rsp)
    6ce1:	00 
    6ce2:	48 85 c0             	test   %rax,%rax
    6ce5:	7e 37                	jle    6d1e <fwp_pipe_out_ready+0x8e>
    6ce7:	48 3d ff ff ff 7f    	cmp    $0x7fffffff,%rax
    6ced:	ba ff ff ff 7f       	mov    $0x7fffffff,%edx
    6cf2:	48 0f 4c d0          	cmovl  %rax,%rdx
    6cf6:	48 89 e7             	mov    %rsp,%rdi
    6cf9:	be 02 00 00 00       	mov    $0x2,%esi
    6cfe:	e8 bd b6 ff ff       	call   23c0 <poll@plt>
    6d03:	85 c0                	test   %eax,%eax
    6d05:	7e 17                	jle    6d1e <fwp_pipe_out_ready+0x8e>
    6d07:	f6 44 24 06 01       	testb  $0x1,0x6(%rsp)
    6d0c:	74 10                	je     6d1e <fwp_pipe_out_ready+0x8e>
    6d0e:	48 c7 05 47 f1 02 00 	movq   $0x0,0x2f147(%rip)        # 35e60 <fwp_po_next_check>
    6d15:	00 00 00 00 
    6d19:	e8 52 39 00 00       	call   a670 <fwp_pipe_poll>
    6d1e:	48 83 c4 18          	add    $0x18,%rsp
    6d22:	c3                   	ret
    6d23:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6d2a:	84 00 00 00 00 00 

0000000000006d30 <fwp_exec_call>:
    6d30:	41 56                	push   %r14
    6d32:	53                   	push   %rbx
    6d33:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
    6d3a:	48 89 f3             	mov    %rsi,%rbx
    6d3d:	49 89 fe             	mov    %rdi,%r14
    6d40:	48 8b 05 21 f1 02 00 	mov    0x2f121(%rip),%rax        # 35e68 <fwp_handlers>
    6d47:	48 89 84 24 d0 00 00 	mov    %rax,0xd0(%rsp)
    6d4e:	00 
    6d4f:	48 c7 84 24 e8 00 00 	movq   $0x0,0xe8(%rsp)
    6d56:	00 00 00 00 00 
    6d5b:	48 8b 05 76 f0 00 00 	mov    0xf076(%rip),%rax        # 15dd8 <fwp_cleanups>
    6d62:	48 89 84 24 f0 00 00 	mov    %rax,0xf0(%rsp)
    6d69:	00 
    6d6a:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    6d6f:	48 89 3d f2 f0 02 00 	mov    %rdi,0x2f0f2(%rip)        # 35e68 <fwp_handlers>
    6d76:	e8 35 b5 ff ff       	call   22b0 <_setjmp@plt>
    6d7b:	85 c0                	test   %eax,%eax
    6d7d:	74 32                	je     6db1 <fwp_exec_call+0x81>
    6d7f:	48 8b 84 24 d0 00 00 	mov    0xd0(%rsp),%rax
    6d86:	00 
    6d87:	48 89 05 da f0 02 00 	mov    %rax,0x2f0da(%rip)        # 35e68 <fwp_handlers>
    6d8e:	e8 5d c2 ff ff       	call   2ff0 <fwp_flush>
    6d93:	48 8b bc 24 d8 00 00 	mov    0xd8(%rsp),%rdi
    6d9a:	00 
    6d9b:	48 8b b4 24 e0 00 00 	mov    0xe0(%rsp),%rsi
    6da2:	00 
    6da3:	e8 18 41 00 00       	call   aec0 <fwp_exec_error>
    6da8:	b9 01 00 00 00       	mov    $0x1,%ecx
    6dad:	31 c0                	xor    %eax,%eax
    6daf:	eb 21                	jmp    6dd2 <fwp_exec_call+0xa2>
    6db1:	e8 ea 40 00 00       	call   aea0 <fwp_pap>
    6db6:	48 89 c7             	mov    %rax,%rdi
    6db9:	4c 89 f6             	mov    %r14,%rsi
    6dbc:	e8 1f 3c 00 00       	call   a9e0 <fwp_apply>
    6dc1:	48 8b 8c 24 d0 00 00 	mov    0xd0(%rsp),%rcx
    6dc8:	00 
    6dc9:	48 89 0d 98 f0 02 00 	mov    %rcx,0x2f098(%rip)        # 35e68 <fwp_handlers>
    6dd0:	31 c9                	xor    %ecx,%ecx
    6dd2:	89 0b                	mov    %ecx,(%rbx)
    6dd4:	48 81 c4 f8 00 00 00 	add    $0xf8,%rsp
    6ddb:	5b                   	pop    %rbx
    6ddc:	41 5e                	pop    %r14
    6dde:	c3                   	ret
    6ddf:	90                   	nop

0000000000006de0 <fwp_emit_result>:
    6de0:	e9 4b 55 00 00       	jmp    c330 <fwp_emit>
    6de5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    6dec:	00 00 00 00 

0000000000006df0 <fwp_read_exact>:
    6df0:	41 57                	push   %r15
    6df2:	41 56                	push   %r14
    6df4:	53                   	push   %rbx
    6df5:	48 89 f3             	mov    %rsi,%rbx
    6df8:	49 89 fe             	mov    %rdi,%r14
    6dfb:	45 31 ff             	xor    %r15d,%r15d
    6dfe:	48 85 f6             	test   %rsi,%rsi
    6e01:	0f 84 b9 00 00 00    	je     6ec0 <fwp_read_exact+0xd0>
    6e07:	8b 05 1b f0 01 00    	mov    0x1f01b(%rip),%eax        # 25e28 <fwp_in_npend>
    6e0d:	8b 0d 19 f0 01 00    	mov    0x1f019(%rip),%ecx        # 25e2c <fwp_in_ppos>
    6e13:	39 c1                	cmp    %eax,%ecx
    6e15:	0f 8d a5 00 00 00    	jge    6ec0 <fwp_read_exact+0xd0>
    6e1b:	48 98                	cltq
    6e1d:	48 63 f1             	movslq %ecx,%rsi
    6e20:	48 89 f2             	mov    %rsi,%rdx
    6e23:	48 f7 d2             	not    %rdx
    6e26:	48 01 c2             	add    %rax,%rdx
    6e29:	48 8d 4b ff          	lea    -0x1(%rbx),%rcx
    6e2d:	48 39 ca             	cmp    %rcx,%rdx
    6e30:	48 0f 43 d1          	cmovae %rcx,%rdx
    6e34:	48 ff c2             	inc    %rdx
    6e37:	48 83 fa 20          	cmp    $0x20,%rdx
    6e3b:	72 16                	jb     6e53 <fwp_read_exact+0x63>
    6e3d:	48 8d 3d e0 ef 01 00 	lea    0x1efe0(%rip),%rdi        # 25e24 <fwp_in_pend>
    6e44:	4d 89 f0             	mov    %r14,%r8
    6e47:	49 29 f0             	sub    %rsi,%r8
    6e4a:	49 29 f8             	sub    %rdi,%r8
    6e4d:	49 83 f8 20          	cmp    $0x20,%r8
    6e51:	73 27                	jae    6e7a <fwp_read_exact+0x8a>
    6e53:	45 31 ff             	xor    %r15d,%r15d
    6e56:	48 89 f1             	mov    %rsi,%rcx
    6e59:	48 8d 15 c4 ef 01 00 	lea    0x1efc4(%rip),%rdx        # 25e24 <fwp_in_pend>
    6e60:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6e64:	48 ff c1             	inc    %rcx
    6e67:	43 88 34 3e          	mov    %sil,(%r14,%r15,1)
    6e6b:	49 ff c7             	inc    %r15
    6e6e:	49 39 df             	cmp    %rbx,%r15
    6e71:	73 3f                	jae    6eb2 <fwp_read_exact+0xc2>
    6e73:	48 39 c1             	cmp    %rax,%rcx
    6e76:	7c e8                	jl     6e60 <fwp_read_exact+0x70>
    6e78:	eb 38                	jmp    6eb2 <fwp_read_exact+0xc2>
    6e7a:	49 89 d7             	mov    %rdx,%r15
    6e7d:	49 83 e7 e0          	and    $0xffffffffffffffe0,%r15
    6e81:	49 8d 0c 37          	lea    (%r15,%rsi,1),%rcx
    6e85:	48 01 fe             	add    %rdi,%rsi
    6e88:	48 83 c6 10          	add    $0x10,%rsi
    6e8c:	31 ff                	xor    %edi,%edi
    6e8e:	66 90                	xchg   %ax,%ax
    6e90:	0f 10 44 3e f0       	movups -0x10(%rsi,%rdi,1),%xmm0
    6e95:	0f 10 0c 3e          	movups (%rsi,%rdi,1),%xmm1
    6e99:	41 0f 11 04 3e       	movups %xmm0,(%r14,%rdi,1)
    6e9e:	41 0f 11 4c 3e 10    	movups %xmm1,0x10(%r14,%rdi,1)
    6ea4:	48 83 c7 20          	add    $0x20,%rdi
    6ea8:	49 39 ff             	cmp    %rdi,%r15
    6eab:	75 e3                	jne    6e90 <fwp_read_exact+0xa0>
    6ead:	4c 39 fa             	cmp    %r15,%rdx
    6eb0:	75 a7                	jne    6e59 <fwp_read_exact+0x69>
    6eb2:	89 0d 74 ef 01 00    	mov    %ecx,0x1ef74(%rip)        # 25e2c <fwp_in_ppos>
    6eb8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6ebf:	00 
    6ec0:	48 89 de             	mov    %rbx,%rsi
    6ec3:	4c 29 fe             	sub    %r15,%rsi
    6ec6:	76 15                	jbe    6edd <fwp_read_exact+0xed>
    6ec8:	4b 8d 3c 3e          	lea    (%r14,%r15,1),%rdi
    6ecc:	e8 3f 58 00 00       	call   c710 <fwp_pipe_read>
    6ed1:	49 01 c7             	add    %rax,%r15
    6ed4:	48 85 c0             	test   %rax,%rax
    6ed7:	75 e7                	jne    6ec0 <fwp_read_exact+0xd0>
    6ed9:	31 c0                	xor    %eax,%eax
    6edb:	eb 05                	jmp    6ee2 <fwp_read_exact+0xf2>
    6edd:	b8 01 00 00 00       	mov    $0x1,%eax
    6ee2:	5b                   	pop    %rbx
    6ee3:	41 5e                	pop    %r14
    6ee5:	41 5f                	pop    %r15
    6ee7:	c3                   	ret
    6ee8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6eef:	00 

0000000000006ef0 <fwp_stdin_leb>:
    6ef0:	41 57                	push   %r15
    6ef2:	41 56                	push   %r14
    6ef4:	53                   	push   %rbx
    6ef5:	48 83 ec 10          	sub    $0x10,%rsp
    6ef9:	48 89 fb             	mov    %rdi,%rbx
    6efc:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    6f03:	49 c7 c6 f9 ff ff ff 	mov    $0xfffffffffffffff9,%r14
    6f0a:	4c 8d 7c 24 0f       	lea    0xf(%rsp),%r15
    6f0f:	90                   	nop
    6f10:	be 01 00 00 00       	mov    $0x1,%esi
    6f15:	4c 89 ff             	mov    %r15,%rdi
    6f18:	e8 d3 fe ff ff       	call   6df0 <fwp_read_exact>
    6f1d:	85 c0                	test   %eax,%eax
    6f1f:	74 35                	je     6f56 <fwp_stdin_leb+0x66>
    6f21:	0f b6 44 24 0f       	movzbl 0xf(%rsp),%eax
    6f26:	49 83 fe 38          	cmp    $0x38,%r14
    6f2a:	75 07                	jne    6f33 <fwp_stdin_leb+0x43>
    6f2c:	89 c1                	mov    %eax,%ecx
    6f2e:	80 e1 7e             	and    $0x7e,%cl
    6f31:	75 1c                	jne    6f4f <fwp_stdin_leb+0x5f>
    6f33:	49 83 c6 07          	add    $0x7,%r14
    6f37:	89 c2                	mov    %eax,%edx
    6f39:	83 e2 7f             	and    $0x7f,%edx
    6f3c:	44 89 f1             	mov    %r14d,%ecx
    6f3f:	48 d3 e2             	shl    %cl,%rdx
    6f42:	48 09 13             	or     %rdx,(%rbx)
    6f45:	84 c0                	test   %al,%al
    6f47:	79 11                	jns    6f5a <fwp_stdin_leb+0x6a>
    6f49:	49 83 fe 38          	cmp    $0x38,%r14
    6f4d:	76 c1                	jbe    6f10 <fwp_stdin_leb+0x20>
    6f4f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    6f54:	eb 09                	jmp    6f5f <fwp_stdin_leb+0x6f>
    6f56:	31 c0                	xor    %eax,%eax
    6f58:	eb 05                	jmp    6f5f <fwp_stdin_leb+0x6f>
    6f5a:	b8 01 00 00 00       	mov    $0x1,%eax
    6f5f:	48 83 c4 10          	add    $0x10,%rsp
    6f63:	5b                   	pop    %rbx
    6f64:	41 5e                	pop    %r14
    6f66:	41 5f                	pop    %r15
    6f68:	c3                   	ret
    6f69:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000006f70 <fwp_stdin_name_len>:
    6f70:	53                   	push   %rbx
    6f71:	48 89 fb             	mov    %rdi,%rbx
    6f74:	e8 77 ff ff ff       	call   6ef0 <fwp_stdin_leb>
    6f79:	83 f8 01             	cmp    $0x1,%eax
    6f7c:	75 0e                	jne    6f8c <fwp_stdin_name_len+0x1c>
    6f7e:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    6f83:	48 81 3b 00 00 10 00 	cmpq   $0x100000,(%rbx)
    6f8a:	77 02                	ja     6f8e <fwp_stdin_name_len+0x1e>
    6f8c:	89 c1                	mov    %eax,%ecx
    6f8e:	89 c8                	mov    %ecx,%eax
    6f90:	5b                   	pop    %rbx
    6f91:	c3                   	ret
    6f92:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6f99:	1f 84 00 00 00 00 00 

0000000000006fa0 <fwp_pipe_in_offer>:
    6fa0:	55                   	push   %rbp
    6fa1:	41 57                	push   %r15
    6fa3:	41 56                	push   %r14
    6fa5:	53                   	push   %rbx
    6fa6:	48 81 ec 08 01 00 00 	sub    $0x108,%rsp
    6fad:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    6fb2:	31 ff                	xor    %edi,%edi
    6fb4:	e8 27 b5 ff ff       	call   24e0 <fstat@plt>
    6fb9:	85 c0                	test   %eax,%eax
    6fbb:	0f 85 a5 00 00 00    	jne    7066 <fwp_pipe_in_offer+0xc6>
    6fc1:	b8 00 f0 00 00       	mov    $0xf000,%eax
    6fc6:	23 44 24 20          	and    0x20(%rsp),%eax
    6fca:	3d 00 10 00 00       	cmp    $0x1000,%eax
    6fcf:	0f 85 91 00 00 00    	jne    7066 <fwp_pipe_in_offer+0xc6>
    6fd5:	bf 01 00 00 00       	mov    $0x1,%edi
    6fda:	be 01 00 08 00       	mov    $0x80001,%esi
    6fdf:	31 d2                	xor    %edx,%edx
    6fe1:	e8 2a b5 ff ff       	call   2510 <socket@plt>
    6fe6:	85 c0                	test   %eax,%eax
    6fe8:	78 7c                	js     7066 <fwp_pipe_in_offer+0xc6>
    6fea:	89 c3                	mov    %eax,%ebx
    6fec:	48 8d bc 24 9a 00 00 	lea    0x9a(%rsp),%rdi
    6ff3:	00 
    6ff4:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    6ff9:	e8 82 31 00 00       	call   a180 <fwp_pipe_addr>
    6ffe:	41 89 c6             	mov    %eax,%r14d
    7001:	48 8d 3d c2 82 00 00 	lea    0x82c2(%rip),%rdi        # f2ca <exec_in_fp0+0xc7a>
    7008:	e8 23 b0 ff ff       	call   2030 <getenv@plt>
    700d:	49 89 c7             	mov    %rax,%r15
    7010:	e8 3b 31 00 00       	call   a150 <fwp_transport_off>
    7015:	89 c5                	mov    %eax,%ebp
    7017:	c7 04 24 46 57 50 54 	movl   $0x54505746,(%rsp)
    701e:	85 c0                	test   %eax,%eax
    7020:	74 04                	je     7026 <fwp_pipe_in_offer+0x86>
    7022:	31 c0                	xor    %eax,%eax
    7024:	eb 1f                	jmp    7045 <fwp_pipe_in_offer+0xa5>
    7026:	4d 85 ff             	test   %r15,%r15
    7029:	74 18                	je     7043 <fwp_pipe_in_offer+0xa3>
    702b:	48 8d 35 6b 83 00 00 	lea    0x836b(%rip),%rsi        # f39d <exec_in_fp0+0xd4d>
    7032:	4c 89 ff             	mov    %r15,%rdi
    7035:	e8 96 b2 ff ff       	call   22d0 <strcmp@plt>
    703a:	83 f8 01             	cmp    $0x1,%eax
    703d:	b0 02                	mov    $0x2,%al
    703f:	1c 00                	sbb    $0x0,%al
    7041:	eb 02                	jmp    7045 <fwp_pipe_in_offer+0xa5>
    7043:	b0 02                	mov    $0x2,%al
    7045:	88 44 24 04          	mov    %al,0x4(%rsp)
    7049:	48 8d b4 24 9a 00 00 	lea    0x9a(%rsp),%rsi
    7050:	00 
    7051:	89 df                	mov    %ebx,%edi
    7053:	44 89 f2             	mov    %r14d,%edx
    7056:	e8 35 b4 ff ff       	call   2490 <connect@plt>
    705b:	85 c0                	test   %eax,%eax
    705d:	74 15                	je     7074 <fwp_pipe_in_offer+0xd4>
    705f:	89 df                	mov    %ebx,%edi
    7061:	e8 ca b1 ff ff       	call   2230 <close@plt>
    7066:	48 81 c4 08 01 00 00 	add    $0x108,%rsp
    706d:	5b                   	pop    %rbx
    706e:	41 5e                	pop    %r14
    7070:	41 5f                	pop    %r15
    7072:	5d                   	pop    %rbp
    7073:	c3                   	ret
    7074:	48 89 e6             	mov    %rsp,%rsi
    7077:	ba 05 00 00 00       	mov    $0x5,%edx
    707c:	89 df                	mov    %ebx,%edi
    707e:	b9 00 40 00 00       	mov    $0x4000,%ecx
    7083:	e8 18 b1 ff ff       	call   21a0 <send@plt>
    7088:	85 ed                	test   %ebp,%ebp
    708a:	75 d3                	jne    705f <fwp_pipe_in_offer+0xbf>
    708c:	48 83 f8 05          	cmp    $0x5,%rax
    7090:	75 cd                	jne    705f <fwp_pipe_in_offer+0xbf>
    7092:	89 1d 30 ec 00 00    	mov    %ebx,0xec30(%rip)        # 15cc8 <fwp_pi_sock>
    7098:	eb cc                	jmp    7066 <fwp_pipe_in_offer+0xc6>
    709a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000070a0 <fwp_pipe_in_switch>:
    70a0:	55                   	push   %rbp
    70a1:	41 57                	push   %r15
    70a3:	41 56                	push   %r14
    70a5:	53                   	push   %rbx
    70a6:	48 81 ec 08 01 00 00 	sub    $0x108,%rsp
    70ad:	31 db                	xor    %ebx,%ebx
    70af:	48 83 fe 01          	cmp    $0x1,%rsi
    70b3:	0f 85 f6 01 00 00    	jne    72af <fwp_pipe_in_switch+0x20f>
    70b9:	48 89 f8             	mov    %rdi,%rax
    70bc:	8b 3d 06 ec 00 00    	mov    0xec06(%rip),%edi        # 15cc8 <fwp_pi_sock>
    70c2:	85 ff                	test   %edi,%edi
    70c4:	0f 88 e5 01 00 00    	js     72af <fwp_pipe_in_switch+0x20f>
    70ca:	83 3d a3 ed 02 00 00 	cmpl   $0x0,0x2eda3(%rip)        # 35e74 <fwp_pi_kind>
    70d1:	0f 85 d8 01 00 00    	jne    72af <fwp_pipe_in_switch+0x20f>
    70d7:	0f b6 00             	movzbl (%rax),%eax
    70da:	83 f8 02             	cmp    $0x2,%eax
    70dd:	74 29                	je     7108 <fwp_pipe_in_switch+0x68>
    70df:	83 f8 01             	cmp    $0x1,%eax
    70e2:	0f 85 c7 01 00 00    	jne    72af <fwp_pipe_in_switch+0x20f>
    70e8:	c7 05 82 ed 02 00 01 	movl   $0x1,0x2ed82(%rip)        # 35e74 <fwp_pi_kind>
    70ef:	00 00 00 
    70f2:	48 8d 3d bb 7f 00 00 	lea    0x7fbb(%rip),%rdi        # f0b4 <exec_in_fp0+0xa64>
    70f9:	e8 32 58 00 00       	call   c930 <fwp_pipe_report>
    70fe:	bb 01 00 00 00       	mov    $0x1,%ebx
    7103:	e9 a7 01 00 00       	jmp    72af <fwp_pipe_in_switch+0x20f>
    7108:	48 8d 44 24 0f       	lea    0xf(%rsp),%rax
    710d:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    7112:	48 c7 44 24 58 01 00 	movq   $0x1,0x58(%rsp)
    7119:	00 00 
    711b:	0f 57 c0             	xorps  %xmm0,%xmm0
    711e:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    7123:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    7128:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    712d:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    7134:	00 00 
    7136:	48 8d 44 24 50       	lea    0x50(%rsp),%rax
    713b:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    7140:	48 c7 44 24 28 01 00 	movq   $0x1,0x28(%rsp)
    7147:	00 00 
    7149:	48 8d 44 24 60       	lea    0x60(%rsp),%rax
    714e:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    7153:	48 c7 44 24 38 18 00 	movq   $0x18,0x38(%rsp)
    715a:	00 00 
    715c:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    7161:	ba 00 00 00 40       	mov    $0x40000000,%edx
    7166:	e8 35 b2 ff ff       	call   23a0 <recvmsg@plt>
    716b:	31 db                	xor    %ebx,%ebx
    716d:	48 83 f8 01          	cmp    $0x1,%rax
    7171:	0f 85 38 01 00 00    	jne    72af <fwp_pipe_in_switch+0x20f>
    7177:	48 83 7c 24 38 10    	cmpq   $0x10,0x38(%rsp)
    717d:	0f 82 2c 01 00 00    	jb     72af <fwp_pipe_in_switch+0x20f>
    7183:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    7188:	48 85 c0             	test   %rax,%rax
    718b:	0f 84 1e 01 00 00    	je     72af <fwp_pipe_in_switch+0x20f>
    7191:	83 78 0c 01          	cmpl   $0x1,0xc(%rax)
    7195:	0f 85 14 01 00 00    	jne    72af <fwp_pipe_in_switch+0x20f>
    719b:	8b 68 10             	mov    0x10(%rax),%ebp
    719e:	48 8d 74 24 78       	lea    0x78(%rsp),%rsi
    71a3:	89 ef                	mov    %ebp,%edi
    71a5:	e8 36 b3 ff ff       	call   24e0 <fstat@plt>
    71aa:	85 c0                	test   %eax,%eax
    71ac:	0f 85 f4 00 00 00    	jne    72a6 <fwp_pipe_in_switch+0x206>
    71b2:	4c 8b b4 24 a8 00 00 	mov    0xa8(%rsp),%r14
    71b9:	00 
    71ba:	49 81 fe 00 10 00 00 	cmp    $0x1000,%r14
    71c1:	0f 86 df 00 00 00    	jbe    72a6 <fwp_pipe_in_switch+0x206>
    71c7:	31 db                	xor    %ebx,%ebx
    71c9:	31 ff                	xor    %edi,%edi
    71cb:	4c 89 f6             	mov    %r14,%rsi
    71ce:	ba 03 00 00 00       	mov    $0x3,%edx
    71d3:	b9 01 00 00 00       	mov    $0x1,%ecx
    71d8:	41 89 e8             	mov    %ebp,%r8d
    71db:	45 31 c9             	xor    %r9d,%r9d
    71de:	e8 ad af ff ff       	call   2190 <mmap@plt>
    71e3:	49 89 c7             	mov    %rax,%r15
    71e6:	89 ef                	mov    %ebp,%edi
    71e8:	e8 43 b0 ff ff       	call   2230 <close@plt>
    71ed:	49 83 ff ff          	cmp    $0xffffffffffffffff,%r15
    71f1:	0f 84 b8 00 00 00    	je     72af <fwp_pipe_in_switch+0x20f>
    71f7:	41 81 3f 46 57 50 53 	cmpl   $0x53505746,(%r15)
    71fe:	0f 85 ab 00 00 00    	jne    72af <fwp_pipe_in_switch+0x20f>
    7204:	41 83 7f 04 01       	cmpl   $0x1,0x4(%r15)
    7209:	0f 85 a0 00 00 00    	jne    72af <fwp_pipe_in_switch+0x20f>
    720f:	49 8b 47 08          	mov    0x8(%r15),%rax
    7213:	48 85 c0             	test   %rax,%rax
    7216:	0f 84 93 00 00 00    	je     72af <fwp_pipe_in_switch+0x20f>
    721c:	48 89 c1             	mov    %rax,%rcx
    721f:	48 d1 e9             	shr    $1,%rcx
    7222:	48 ba 55 55 55 55 55 	movabs $0x5555555555555555,%rdx
    7229:	55 55 55 
    722c:	48 21 ca             	and    %rcx,%rdx
    722f:	48 89 c1             	mov    %rax,%rcx
    7232:	48 29 d1             	sub    %rdx,%rcx
    7235:	48 ba 33 33 33 33 33 	movabs $0x3333333333333333,%rdx
    723c:	33 33 33 
    723f:	48 89 ce             	mov    %rcx,%rsi
    7242:	48 21 d6             	and    %rdx,%rsi
    7245:	48 c1 e9 02          	shr    $0x2,%rcx
    7249:	48 21 d1             	and    %rdx,%rcx
    724c:	48 01 f1             	add    %rsi,%rcx
    724f:	48 89 ca             	mov    %rcx,%rdx
    7252:	48 c1 ea 04          	shr    $0x4,%rdx
    7256:	48 01 ca             	add    %rcx,%rdx
    7259:	48 b9 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%rcx
    7260:	0f 0f 0f 
    7263:	48 21 d1             	and    %rdx,%rcx
    7266:	48 ba 01 01 01 01 01 	movabs $0x101010101010101,%rdx
    726d:	01 01 01 
    7270:	48 0f af d1          	imul   %rcx,%rdx
    7274:	48 c1 ea 38          	shr    $0x38,%rdx
    7278:	83 fa 01             	cmp    $0x1,%edx
    727b:	77 32                	ja     72af <fwp_pipe_in_switch+0x20f>
    727d:	49 81 c6 00 f0 ff ff 	add    $0xfffffffffffff000,%r14
    7284:	4c 39 f0             	cmp    %r14,%rax
    7287:	77 26                	ja     72af <fwp_pipe_in_switch+0x20f>
    7289:	4c 89 3d e8 eb 02 00 	mov    %r15,0x2ebe8(%rip)        # 35e78 <fwp_pi_ring>
    7290:	c7 05 da eb 02 00 02 	movl   $0x2,0x2ebda(%rip)        # 35e74 <fwp_pi_kind>
    7297:	00 00 00 
    729a:	48 8d 3d 00 81 00 00 	lea    0x8100(%rip),%rdi        # f3a1 <exec_in_fp0+0xd51>
    72a1:	e9 53 fe ff ff       	jmp    70f9 <fwp_pipe_in_switch+0x59>
    72a6:	89 ef                	mov    %ebp,%edi
    72a8:	e8 83 af ff ff       	call   2230 <close@plt>
    72ad:	31 db                	xor    %ebx,%ebx
    72af:	89 d8                	mov    %ebx,%eax
    72b1:	48 81 c4 08 01 00 00 	add    $0x108,%rsp
    72b8:	5b                   	pop    %rbx
    72b9:	41 5e                	pop    %r14
    72bb:	41 5f                	pop    %r15
    72bd:	5d                   	pop    %rbp
    72be:	c3                   	ret
    72bf:	90                   	nop

00000000000072c0 <fwp_decode>:
    72c0:	55                   	push   %rbp
    72c1:	41 57                	push   %r15
    72c3:	41 56                	push   %r14
    72c5:	41 55                	push   %r13
    72c7:	41 54                	push   %r12
    72c9:	53                   	push   %rbx
    72ca:	48 83 ec 38          	sub    $0x38,%rsp
    72ce:	8b 06                	mov    (%rsi),%eax
    72d0:	45 31 f6             	xor    %r14d,%r14d
    72d3:	48 83 f8 15          	cmp    $0x15,%rax
    72d7:	77 47                	ja     7320 <fwp_decode+0x60>
    72d9:	48 89 d3             	mov    %rdx,%rbx
    72dc:	49 89 f4             	mov    %rsi,%r12
    72df:	49 89 ff             	mov    %rdi,%r15
    72e2:	48 8d 0d 97 6e 00 00 	lea    0x6e97(%rip),%rcx        # e180 <_IO_stdin_used+0x180>
    72e9:	48 63 14 81          	movslq (%rcx,%rax,4),%rdx
    72ed:	48 01 ca             	add    %rcx,%rdx
    72f0:	ff e2                	jmp    *%rdx
    72f2:	31 c9                	xor    %ecx,%ecx
    72f4:	83 f8 0a             	cmp    $0xa,%eax
    72f7:	0f 95 c1             	setne  %cl
    72fa:	8d 34 8d 04 00 00 00 	lea    0x4(,%rcx,4),%esi
    7301:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7306:	4c 89 ff             	mov    %r15,%rdi
    7309:	e8 72 56 00 00       	call   c980 <rd_le>
    730e:	85 c0                	test   %eax,%eax
    7310:	74 0e                	je     7320 <fwp_decode+0x60>
    7312:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    7317:	48 89 03             	mov    %rax,(%rbx)
    731a:	41 be 01 00 00 00    	mov    $0x1,%r14d
    7320:	44 89 f0             	mov    %r14d,%eax
    7323:	48 83 c4 38          	add    $0x38,%rsp
    7327:	5b                   	pop    %rbx
    7328:	41 5c                	pop    %r12
    732a:	41 5d                	pop    %r13
    732c:	41 5e                	pop    %r14
    732e:	41 5f                	pop    %r15
    7330:	5d                   	pop    %rbp
    7331:	c3                   	ret
    7332:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    7337:	4c 89 ff             	mov    %r15,%rdi
    733a:	e8 01 57 00 00       	call   ca40 <rd_leb>
    733f:	45 31 f6             	xor    %r14d,%r14d
    7342:	85 c0                	test   %eax,%eax
    7344:	74 da                	je     7320 <fwp_decode+0x60>
    7346:	4c 8b 6c 24 08       	mov    0x8(%rsp),%r13
    734b:	4d 3b 6f 08          	cmp    0x8(%r15),%r13
    734f:	77 cf                	ja     7320 <fwp_decode+0x60>
    7351:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    7356:	4c 89 ff             	mov    %r15,%rdi
    7359:	4c 89 ee             	mov    %r13,%rsi
    735c:	e8 5f 57 00 00       	call   cac0 <rd_take>
    7361:	85 c0                	test   %eax,%eax
    7363:	74 bb                	je     7320 <fwp_decode+0x60>
    7365:	41 83 3c 24 0c       	cmpl   $0xc,(%r12)
    736a:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    736f:	75 0f                	jne    7380 <fwp_decode+0xc0>
    7371:	4c 89 ff             	mov    %r15,%rdi
    7374:	4c 89 ee             	mov    %r13,%rsi
    7377:	e8 14 05 00 00       	call   7890 <fwp_valid_utf8>
    737c:	85 c0                	test   %eax,%eax
    737e:	74 a0                	je     7320 <fwp_decode+0x60>
    7380:	4c 89 ff             	mov    %r15,%rdi
    7383:	4c 89 ee             	mov    %r13,%rsi
    7386:	e8 65 06 00 00       	call   79f0 <fwp_str_new>
    738b:	eb 8a                	jmp    7317 <fwp_decode+0x57>
    738d:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7392:	4c 89 ff             	mov    %r15,%rdi
    7395:	be 01 00 00 00       	mov    $0x1,%esi
    739a:	e8 e1 55 00 00       	call   c980 <rd_le>
    739f:	85 c0                	test   %eax,%eax
    73a1:	0f 84 79 ff ff ff    	je     7320 <fwp_decode+0x60>
    73a7:	48 0f be 44 24 08    	movsbq 0x8(%rsp),%rax
    73ad:	e9 65 ff ff ff       	jmp    7317 <fwp_decode+0x57>
    73b2:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    73b7:	4c 89 ff             	mov    %r15,%rdi
    73ba:	be 08 00 00 00       	mov    $0x8,%esi
    73bf:	e8 bc 55 00 00       	call   c980 <rd_le>
    73c4:	45 31 f6             	xor    %r14d,%r14d
    73c7:	85 c0                	test   %eax,%eax
    73c9:	0f 84 51 ff ff ff    	je     7320 <fwp_decode+0x60>
    73cf:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    73d4:	4c 89 ff             	mov    %r15,%rdi
    73d7:	be 08 00 00 00       	mov    $0x8,%esi
    73dc:	e8 9f 55 00 00       	call   c980 <rd_le>
    73e1:	85 c0                	test   %eax,%eax
    73e3:	0f 84 37 ff ff ff    	je     7320 <fwp_decode+0x60>
    73e9:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    73ee:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    73f3:	41 83 3c 24 04       	cmpl   $0x4,(%r12)
    73f8:	0f 85 d1 02 00 00    	jne    76cf <fwp_decode+0x40f>
    73fe:	e8 9d 24 00 00       	call   98a0 <fwp_box_i128>
    7403:	e9 0f ff ff ff       	jmp    7317 <fwp_decode+0x57>
    7408:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    740d:	4c 89 ff             	mov    %r15,%rdi
    7410:	e8 2b 56 00 00       	call   ca40 <rd_leb>
    7415:	85 c0                	test   %eax,%eax
    7417:	0f 84 03 ff ff ff    	je     7320 <fwp_decode+0x60>
    741d:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    7422:	49 3b 6f 08          	cmp    0x8(%r15),%rbp
    7426:	0f 87 f4 fe ff ff    	ja     7320 <fwp_decode+0x60>
    742c:	4c 8d 35 fd e9 01 00 	lea    0x1e9fd(%rip),%r14        # 25e30 <fwp_empty_map>
    7433:	48 85 ed             	test   %rbp,%rbp
    7436:	0f 84 9d 02 00 00    	je     76d9 <fwp_decode+0x419>
    743c:	4c 8d 6c 24 18       	lea    0x18(%rsp),%r13
    7441:	eb 20                	jmp    7463 <fwp_decode+0x1a3>
    7443:	31 f6                	xor    %esi,%esi
    7445:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    744a:	49 8b 4c 24 38       	mov    0x38(%r12),%rcx
    744f:	4c 89 f2             	mov    %r14,%rdx
    7452:	e8 89 1c 00 00       	call   90e0 <fwp_p_map_insert>
    7457:	49 89 c6             	mov    %rax,%r14
    745a:	48 ff cd             	dec    %rbp
    745d:	0f 84 76 02 00 00    	je     76d9 <fwp_decode+0x419>
    7463:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
    746a:	00 00 
    746c:	49 8b 74 24 38       	mov    0x38(%r12),%rsi
    7471:	4c 89 ff             	mov    %r15,%rdi
    7474:	4c 89 ea             	mov    %r13,%rdx
    7477:	e8 44 fe ff ff       	call   72c0 <fwp_decode>
    747c:	85 c0                	test   %eax,%eax
    747e:	0f 84 69 02 00 00    	je     76ed <fwp_decode+0x42d>
    7484:	41 83 3c 24 12       	cmpl   $0x12,(%r12)
    7489:	75 b8                	jne    7443 <fwp_decode+0x183>
    748b:	49 8b 74 24 40       	mov    0x40(%r12),%rsi
    7490:	4c 89 ff             	mov    %r15,%rdi
    7493:	48 8d 54 24 30       	lea    0x30(%rsp),%rdx
    7498:	e8 23 fe ff ff       	call   72c0 <fwp_decode>
    749d:	85 c0                	test   %eax,%eax
    749f:	0f 84 48 02 00 00    	je     76ed <fwp_decode+0x42d>
    74a5:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    74aa:	eb 99                	jmp    7445 <fwp_decode+0x185>
    74ac:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    74b1:	4c 89 ff             	mov    %r15,%rdi
    74b4:	e8 87 55 00 00       	call   ca40 <rd_leb>
    74b9:	85 c0                	test   %eax,%eax
    74bb:	0f 84 5f fe ff ff    	je     7320 <fwp_decode+0x60>
    74c1:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
    74c6:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    74cb:	49 3b 5f 08          	cmp    0x8(%r15),%rbx
    74cf:	0f 87 4b fe ff ff    	ja     7320 <fwp_decode+0x60>
    74d5:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    74dc:	00 
    74dd:	e8 3e e2 ff ff       	call   5720 <fwp_alloc>
    74e2:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    74e7:	48 85 db             	test   %rbx,%rbx
    74ea:	74 35                	je     7521 <fwp_decode+0x261>
    74ec:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
    74f1:	49 89 dd             	mov    %rbx,%r13
    74f4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    74fb:	00 00 00 00 00 
    7500:	49 8b 74 24 38       	mov    0x38(%r12),%rsi
    7505:	4c 89 ff             	mov    %r15,%rdi
    7508:	48 89 ea             	mov    %rbp,%rdx
    750b:	e8 b0 fd ff ff       	call   72c0 <fwp_decode>
    7510:	85 c0                	test   %eax,%eax
    7512:	0f 84 08 fe ff ff    	je     7320 <fwp_decode+0x60>
    7518:	48 83 c5 08          	add    $0x8,%rbp
    751c:	49 ff cd             	dec    %r13
    751f:	75 df                	jne    7500 <fwp_decode+0x240>
    7521:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    7526:	48 89 de             	mov    %rbx,%rsi
    7529:	e8 a2 02 00 00       	call   77d0 <fwp_list_from>
    752e:	41 83 3c 24 11       	cmpl   $0x11,(%r12)
    7533:	0f 85 b4 00 00 00    	jne    75ed <fwp_decode+0x32d>
    7539:	48 89 c7             	mov    %rax,%rdi
    753c:	e8 4f 1a 00 00       	call   8f90 <fwp_p_array_from_list>
    7541:	e9 a7 00 00 00       	jmp    75ed <fwp_decode+0x32d>
    7546:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    754b:	4c 89 ff             	mov    %r15,%rdi
    754e:	e8 ed 54 00 00       	call   ca40 <rd_leb>
    7553:	85 c0                	test   %eax,%eax
    7555:	0f 84 c5 fd ff ff    	je     7320 <fwp_decode+0x60>
    755b:	4c 8b 6c 24 08       	mov    0x8(%rsp),%r13
    7560:	49 63 44 24 10       	movslq 0x10(%r12),%rax
    7565:	49 39 c5             	cmp    %rax,%r13
    7568:	0f 83 b2 fd ff ff    	jae    7320 <fwp_decode+0x60>
    756e:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
    7573:	49 8b 44 24 28       	mov    0x28(%r12),%rax
    7578:	4a 63 1c a8          	movslq (%rax,%r13,4),%rbx
    757c:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    7583:	00 
    7584:	e8 97 e1 ff ff       	call   5720 <fwp_alloc>
    7589:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    758e:	89 d8                	mov    %ebx,%eax
    7590:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    7595:	48 85 db             	test   %rbx,%rbx
    7598:	7e 41                	jle    75db <fwp_decode+0x31b>
    759a:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    759f:	48 8d 2c c5 00 00 00 	lea    0x0(,%rax,8),%rbp
    75a6:	00 
    75a7:	45 31 f6             	xor    %r14d,%r14d
    75aa:	31 db                	xor    %ebx,%ebx
    75ac:	49 8b 44 24 30       	mov    0x30(%r12),%rax
    75b1:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    75b5:	48 8b 34 18          	mov    (%rax,%rbx,1),%rsi
    75b9:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    75be:	48 8d 14 18          	lea    (%rax,%rbx,1),%rdx
    75c2:	4c 89 ff             	mov    %r15,%rdi
    75c5:	e8 f6 fc ff ff       	call   72c0 <fwp_decode>
    75ca:	85 c0                	test   %eax,%eax
    75cc:	0f 84 4e fd ff ff    	je     7320 <fwp_decode+0x60>
    75d2:	48 83 c3 08          	add    $0x8,%rbx
    75d6:	48 39 dd             	cmp    %rbx,%rbp
    75d9:	75 d1                	jne    75ac <fwp_decode+0x2ec>
    75db:	44 89 ef             	mov    %r13d,%edi
    75de:	48 8b 74 24 28       	mov    0x28(%rsp),%rsi
    75e3:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
    75e8:	e8 33 bb ff ff       	call   3120 <fwp_data>
    75ed:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    75f2:	48 89 01             	mov    %rax,(%rcx)
    75f5:	e9 20 fd ff ff       	jmp    731a <fwp_decode+0x5a>
    75fa:	be 01 00 00 00       	mov    $0x1,%esi
    75ff:	e9 fd fc ff ff       	jmp    7301 <fwp_decode+0x41>
    7604:	be 02 00 00 00       	mov    $0x2,%esi
    7609:	e9 f3 fc ff ff       	jmp    7301 <fwp_decode+0x41>
    760e:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7613:	4c 89 ff             	mov    %r15,%rdi
    7616:	be 02 00 00 00       	mov    $0x2,%esi
    761b:	e8 60 53 00 00       	call   c980 <rd_le>
    7620:	85 c0                	test   %eax,%eax
    7622:	0f 84 f8 fc ff ff    	je     7320 <fwp_decode+0x60>
    7628:	48 0f bf 44 24 08    	movswq 0x8(%rsp),%rax
    762e:	e9 e4 fc ff ff       	jmp    7317 <fwp_decode+0x57>
    7633:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7638:	4c 89 ff             	mov    %r15,%rdi
    763b:	be 04 00 00 00       	mov    $0x4,%esi
    7640:	e8 3b 53 00 00       	call   c980 <rd_le>
    7645:	85 c0                	test   %eax,%eax
    7647:	0f 84 d3 fc ff ff    	je     7320 <fwp_decode+0x60>
    764d:	48 63 44 24 08       	movslq 0x8(%rsp),%rax
    7652:	e9 c0 fc ff ff       	jmp    7317 <fwp_decode+0x57>
    7657:	be 04 00 00 00       	mov    $0x4,%esi
    765c:	e9 a0 fc ff ff       	jmp    7301 <fwp_decode+0x41>
    7661:	49 63 7c 24 10       	movslq 0x10(%r12),%rdi
    7666:	48 85 ff             	test   %rdi,%rdi
    7669:	74 76                	je     76e1 <fwp_decode+0x421>
    766b:	48 c1 e7 03          	shl    $0x3,%rdi
    766f:	e8 ac e0 ff ff       	call   5720 <fwp_alloc>
    7674:	41 8b 7c 24 10       	mov    0x10(%r12),%edi
    7679:	85 ff                	test   %edi,%edi
    767b:	7e 45                	jle    76c2 <fwp_decode+0x402>
    767d:	45 31 f6             	xor    %r14d,%r14d
    7680:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    7685:	48 89 c5             	mov    %rax,%rbp
    7688:	45 31 ed             	xor    %r13d,%r13d
    768b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7690:	49 8b 44 24 20       	mov    0x20(%r12),%rax
    7695:	4a 8b 34 e8          	mov    (%rax,%r13,8),%rsi
    7699:	4c 89 ff             	mov    %r15,%rdi
    769c:	48 89 ea             	mov    %rbp,%rdx
    769f:	e8 1c fc ff ff       	call   72c0 <fwp_decode>
    76a4:	85 c0                	test   %eax,%eax
    76a6:	0f 84 74 fc ff ff    	je     7320 <fwp_decode+0x60>
    76ac:	49 ff c5             	inc    %r13
    76af:	49 63 7c 24 10       	movslq 0x10(%r12),%rdi
    76b4:	48 83 c5 08          	add    $0x8,%rbp
    76b8:	49 39 fd             	cmp    %rdi,%r13
    76bb:	7c d3                	jl     7690 <fwp_decode+0x3d0>
    76bd:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    76c2:	48 89 c6             	mov    %rax,%rsi
    76c5:	e8 36 ba ff ff       	call   3100 <fwp_record>
    76ca:	e9 48 fc ff ff       	jmp    7317 <fwp_decode+0x57>
    76cf:	e8 7c 20 00 00       	call   9750 <fwp_box_u128>
    76d4:	e9 3e fc ff ff       	jmp    7317 <fwp_decode+0x57>
    76d9:	4c 89 33             	mov    %r14,(%rbx)
    76dc:	e9 39 fc ff ff       	jmp    731a <fwp_decode+0x5a>
    76e1:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    76e8:	e9 2d fc ff ff       	jmp    731a <fwp_decode+0x5a>
    76ed:	45 31 f6             	xor    %r14d,%r14d
    76f0:	e9 2b fc ff ff       	jmp    7320 <fwp_decode+0x60>
    76f5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    76fc:	00 00 00 00 

0000000000007700 <fwp_read_text_line>:
    7700:	53                   	push   %rbx
    7701:	48 89 fb             	mov    %rdi,%rbx
    7704:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
    770b:	00 
    770c:	e8 df 53 00 00       	call   caf0 <fwp_getc>
    7711:	83 f8 ff             	cmp    $0xffffffff,%eax
    7714:	74 59                	je     776f <fwp_read_text_line+0x6f>
    7716:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    771d:	00 00 00 
    7720:	83 f8 0a             	cmp    $0xa,%eax
    7723:	74 1a                	je     773f <fwp_read_text_line+0x3f>
    7725:	0f be f0             	movsbl %al,%esi
    7728:	48 89 df             	mov    %rbx,%rdi
    772b:	e8 00 03 00 00       	call   7a30 <buf_putc>
    7730:	e8 bb 53 00 00       	call   caf0 <fwp_getc>
    7735:	83 f8 ff             	cmp    $0xffffffff,%eax
    7738:	75 e6                	jne    7720 <fwp_read_text_line+0x20>
    773a:	48 8b 03             	mov    (%rbx),%rax
    773d:	eb 1c                	jmp    775b <fwp_read_text_line+0x5b>
    773f:	48 8b 03             	mov    (%rbx),%rax
    7742:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    7746:	48 85 c9             	test   %rcx,%rcx
    7749:	74 10                	je     775b <fwp_read_text_line+0x5b>
    774b:	80 7c 08 ff 0d       	cmpb   $0xd,-0x1(%rax,%rcx,1)
    7750:	75 12                	jne    7764 <fwp_read_text_line+0x64>
    7752:	48 ff c9             	dec    %rcx
    7755:	48 89 4b 08          	mov    %rcx,0x8(%rbx)
    7759:	eb 05                	jmp    7760 <fwp_read_text_line+0x60>
    775b:	48 85 c0             	test   %rax,%rax
    775e:	74 08                	je     7768 <fwp_read_text_line+0x68>
    7760:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    7764:	c6 04 08 00          	movb   $0x0,(%rax,%rcx,1)
    7768:	b8 01 00 00 00       	mov    $0x1,%eax
    776d:	5b                   	pop    %rbx
    776e:	c3                   	ret
    776f:	31 c0                	xor    %eax,%eax
    7771:	5b                   	pop    %rbx
    7772:	c3                   	ret
    7773:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    777a:	84 00 00 00 00 00 

0000000000007780 <fwp_mem_realloc>:
    7780:	41 57                	push   %r15
    7782:	41 56                	push   %r14
    7784:	53                   	push   %rbx
    7785:	49 89 d6             	mov    %rdx,%r14
    7788:	49 89 f7             	mov    %rsi,%r15
    778b:	48 89 fb             	mov    %rdi,%rbx
    778e:	48 89 d7             	mov    %rdx,%rdi
    7791:	e8 8a df ff ff       	call   5720 <fwp_alloc>
    7796:	48 85 db             	test   %rbx,%rbx
    7799:	74 23                	je     77be <fwp_mem_realloc+0x3e>
    779b:	4d 39 f7             	cmp    %r14,%r15
    779e:	4d 0f 42 f7          	cmovb  %r15,%r14
    77a2:	48 89 c7             	mov    %rax,%rdi
    77a5:	48 89 de             	mov    %rbx,%rsi
    77a8:	4c 89 f2             	mov    %r14,%rdx
    77ab:	49 89 c6             	mov    %rax,%r14
    77ae:	e8 7d ab ff ff       	call   2330 <memcpy@plt>
    77b3:	48 89 df             	mov    %rbx,%rdi
    77b6:	e8 55 e0 ff ff       	call   5810 <fwp_mem_free>
    77bb:	4c 89 f0             	mov    %r14,%rax
    77be:	5b                   	pop    %rbx
    77bf:	41 5e                	pop    %r14
    77c1:	41 5f                	pop    %r15
    77c3:	c3                   	ret
    77c4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    77cb:	00 00 00 00 00 

00000000000077d0 <fwp_list_from>:
    77d0:	41 56                	push   %r14
    77d2:	53                   	push   %rbx
    77d3:	50                   	push   %rax
    77d4:	48 89 fb             	mov    %rdi,%rbx
    77d7:	48 85 f6             	test   %rsi,%rsi
    77da:	74 28                	je     7804 <fwp_list_from+0x34>
    77dc:	49 89 f6             	mov    %rsi,%r14
    77df:	31 c0                	xor    %eax,%eax
    77e1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    77e8:	0f 1f 84 00 00 00 00 
    77ef:	00 
    77f0:	4a 8b 7c f3 f8       	mov    -0x8(%rbx,%r14,8),%rdi
    77f5:	48 89 c6             	mov    %rax,%rsi
    77f8:	e8 63 06 00 00       	call   7e60 <fwp_cons>
    77fd:	49 ff ce             	dec    %r14
    7800:	75 ee                	jne    77f0 <fwp_list_from+0x20>
    7802:	eb 02                	jmp    7806 <fwp_list_from+0x36>
    7804:	31 c0                	xor    %eax,%eax
    7806:	48 83 c4 08          	add    $0x8,%rsp
    780a:	5b                   	pop    %rbx
    780b:	41 5e                	pop    %r14
    780d:	c3                   	ret
    780e:	66 90                	xchg   %ax,%ax

0000000000007810 <fwp_pipe_out_end>:
    7810:	50                   	push   %rax
    7811:	8b 05 29 e6 01 00    	mov    0x1e629(%rip),%eax        # 25e40 <fwp_po_kind>
    7817:	83 f8 02             	cmp    $0x2,%eax
    781a:	74 1c                	je     7838 <fwp_pipe_out_end+0x28>
    781c:	83 f8 01             	cmp    $0x1,%eax
    781f:	75 3d                	jne    785e <fwp_pipe_out_end+0x4e>
    7821:	e8 3a 2b 00 00       	call   a360 <fwp_po_flush_sock>
    7826:	8b 3d 94 e4 00 00    	mov    0xe494(%rip),%edi        # 15cc0 <fwp_po_sock>
    782c:	be 01 00 00 00       	mov    $0x1,%esi
    7831:	e8 2a a9 ff ff       	call   2160 <shutdown@plt>
    7836:	eb 35                	jmp    786d <fwp_pipe_out_end+0x5d>
    7838:	48 8b 35 11 e6 02 00 	mov    0x2e611(%rip),%rsi        # 35e50 <fwp_po_ring>
    783f:	c7 86 40 01 00 00 01 	movl   $0x1,0x140(%rsi)
    7846:	00 00 00 
    7849:	48 8d be c0 00 00 00 	lea    0xc0(%rsi),%rdi
    7850:	48 81 c6 c4 00 00 00 	add    $0xc4,%rsi
    7857:	e8 14 2d 00 00       	call   a570 <fwp_ring_wake>
    785c:	eb 0f                	jmp    786d <fwp_pipe_out_end+0x5d>
    785e:	48 8b 05 53 c7 00 00 	mov    0xc753(%rip),%rax        # 13fb8 <stdout@GLIBC_2.2.5>
    7865:	48 8b 38             	mov    (%rax),%rdi
    7868:	e8 e3 aa ff ff       	call   2350 <fflush@plt>
    786d:	8b 3d 49 e4 00 00    	mov    0xe449(%rip),%edi        # 15cbc <fwp_po_listen>
    7873:	85 ff                	test   %edi,%edi
    7875:	78 0f                	js     7886 <fwp_pipe_out_end+0x76>
    7877:	e8 b4 a9 ff ff       	call   2230 <close@plt>
    787c:	c7 05 36 e4 00 00 ff 	movl   $0xffffffff,0xe436(%rip)        # 15cbc <fwp_po_listen>
    7883:	ff ff ff 
    7886:	58                   	pop    %rax
    7887:	c3                   	ret
    7888:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    788f:	00 

0000000000007890 <fwp_valid_utf8>:
    7890:	48 85 f6             	test   %rsi,%rsi
    7893:	0f 84 48 01 00 00    	je     79e1 <fwp_valid_utf8+0x151>
    7899:	53                   	push   %rbx
    789a:	31 c9                	xor    %ecx,%ecx
    789c:	eb 0e                	jmp    78ac <fwp_valid_utf8+0x1c>
    789e:	66 90                	xchg   %ax,%ax
    78a0:	48 ff c1             	inc    %rcx
    78a3:	48 39 f1             	cmp    %rsi,%rcx
    78a6:	0f 83 2e 01 00 00    	jae    79da <fwp_valid_utf8+0x14a>
    78ac:	44 0f b6 14 0f       	movzbl (%rdi,%rcx,1),%r10d
    78b1:	45 84 d2             	test   %r10b,%r10b
    78b4:	79 ea                	jns    78a0 <fwp_valid_utf8+0x10>
    78b6:	41 8d 42 3e          	lea    0x3e(%r10),%eax
    78ba:	3c 1e                	cmp    $0x1e,%al
    78bc:	73 12                	jae    78d0 <fwp_valid_utf8+0x40>
    78be:	ba 80 00 00 00       	mov    $0x80,%edx
    78c3:	b8 01 00 00 00       	mov    $0x1,%eax
    78c8:	41 b8 1f 00 00 00    	mov    $0x1f,%r8d
    78ce:	eb 37                	jmp    7907 <fwp_valid_utf8+0x77>
    78d0:	44 89 d0             	mov    %r10d,%eax
    78d3:	24 f0                	and    $0xf0,%al
    78d5:	3c e0                	cmp    $0xe0,%al
    78d7:	75 12                	jne    78eb <fwp_valid_utf8+0x5b>
    78d9:	ba 00 08 00 00       	mov    $0x800,%edx
    78de:	b8 02 00 00 00       	mov    $0x2,%eax
    78e3:	41 b8 0f 00 00 00    	mov    $0xf,%r8d
    78e9:	eb 1c                	jmp    7907 <fwp_valid_utf8+0x77>
    78eb:	41 8d 42 10          	lea    0x10(%r10),%eax
    78ef:	3c 04                	cmp    $0x4,%al
    78f1:	0f 87 f0 00 00 00    	ja     79e7 <fwp_valid_utf8+0x157>
    78f7:	ba 00 00 01 00       	mov    $0x10000,%edx
    78fc:	b8 03 00 00 00       	mov    $0x3,%eax
    7901:	41 b8 07 00 00 00    	mov    $0x7,%r8d
    7907:	41 89 c1             	mov    %eax,%r9d
    790a:	4e 8d 1c 09          	lea    (%rcx,%r9,1),%r11
    790e:	31 c0                	xor    %eax,%eax
    7910:	49 39 f3             	cmp    %rsi,%r11
    7913:	0f 83 c6 00 00 00    	jae    79df <fwp_valid_utf8+0x14f>
    7919:	44 0f b6 5c 0f 01    	movzbl 0x1(%rdi,%rcx,1),%r11d
    791f:	44 89 db             	mov    %r11d,%ebx
    7922:	83 e3 c0             	and    $0xffffffc0,%ebx
    7925:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
    792b:	0f 85 ae 00 00 00    	jne    79df <fwp_valid_utf8+0x14f>
    7931:	45 21 d0             	and    %r10d,%r8d
    7934:	45 8d 51 01          	lea    0x1(%r9),%r10d
    7938:	44 89 c3             	mov    %r8d,%ebx
    793b:	c1 e3 06             	shl    $0x6,%ebx
    793e:	41 83 e3 3f          	and    $0x3f,%r11d
    7942:	41 09 db             	or     %ebx,%r11d
    7945:	41 83 fa 02          	cmp    $0x2,%r10d
    7949:	75 0d                	jne    7958 <fwp_valid_utf8+0xc8>
    794b:	45 89 da             	mov    %r11d,%r10d
    794e:	41 39 d2             	cmp    %edx,%r10d
    7951:	73 62                	jae    79b5 <fwp_valid_utf8+0x125>
    7953:	e9 87 00 00 00       	jmp    79df <fwp_valid_utf8+0x14f>
    7958:	44 0f b6 44 0f 02    	movzbl 0x2(%rdi,%rcx,1),%r8d
    795e:	44 89 c3             	mov    %r8d,%ebx
    7961:	83 e3 c0             	and    $0xffffffc0,%ebx
    7964:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
    796a:	75 73                	jne    79df <fwp_valid_utf8+0x14f>
    796c:	44 89 db             	mov    %r11d,%ebx
    796f:	c1 e3 06             	shl    $0x6,%ebx
    7972:	41 83 e0 3f          	and    $0x3f,%r8d
    7976:	41 09 d8             	or     %ebx,%r8d
    7979:	41 83 fa 03          	cmp    $0x3,%r10d
    797d:	75 0d                	jne    798c <fwp_valid_utf8+0xfc>
    797f:	45 89 c2             	mov    %r8d,%r10d
    7982:	45 89 d8             	mov    %r11d,%r8d
    7985:	41 39 d2             	cmp    %edx,%r10d
    7988:	73 2b                	jae    79b5 <fwp_valid_utf8+0x125>
    798a:	eb 53                	jmp    79df <fwp_valid_utf8+0x14f>
    798c:	44 0f b6 54 0f 03    	movzbl 0x3(%rdi,%rcx,1),%r10d
    7992:	45 89 d3             	mov    %r10d,%r11d
    7995:	41 83 e3 c0          	and    $0xffffffc0,%r11d
    7999:	41 81 fb 80 00 00 00 	cmp    $0x80,%r11d
    79a0:	75 3d                	jne    79df <fwp_valid_utf8+0x14f>
    79a2:	45 89 c3             	mov    %r8d,%r11d
    79a5:	41 c1 e3 06          	shl    $0x6,%r11d
    79a9:	41 83 e2 3f          	and    $0x3f,%r10d
    79ad:	45 09 da             	or     %r11d,%r10d
    79b0:	41 39 d2             	cmp    %edx,%r10d
    79b3:	72 2a                	jb     79df <fwp_valid_utf8+0x14f>
    79b5:	41 81 fa ff ff 10 00 	cmp    $0x10ffff,%r10d
    79bc:	77 21                	ja     79df <fwp_valid_utf8+0x14f>
    79be:	41 83 e0 e0          	and    $0xffffffe0,%r8d
    79c2:	41 81 f8 60 03 00 00 	cmp    $0x360,%r8d
    79c9:	74 14                	je     79df <fwp_valid_utf8+0x14f>
    79cb:	4c 01 c9             	add    %r9,%rcx
    79ce:	48 ff c1             	inc    %rcx
    79d1:	48 39 f1             	cmp    %rsi,%rcx
    79d4:	0f 82 d2 fe ff ff    	jb     78ac <fwp_valid_utf8+0x1c>
    79da:	b8 01 00 00 00       	mov    $0x1,%eax
    79df:	5b                   	pop    %rbx
    79e0:	c3                   	ret
    79e1:	b8 01 00 00 00       	mov    $0x1,%eax
    79e6:	c3                   	ret
    79e7:	31 c0                	xor    %eax,%eax
    79e9:	5b                   	pop    %rbx
    79ea:	c3                   	ret
    79eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000079f0 <fwp_str_new>:
    79f0:	41 57                	push   %r15
    79f2:	41 56                	push   %r14
    79f4:	53                   	push   %rbx
    79f5:	48 89 f3             	mov    %rsi,%rbx
    79f8:	49 89 fe             	mov    %rdi,%r14
    79fb:	48 8d 7e 09          	lea    0x9(%rsi),%rdi
    79ff:	e8 2c ee ff ff       	call   6830 <fwp_alloc_leaf>
    7a04:	49 89 c7             	mov    %rax,%r15
    7a07:	48 89 18             	mov    %rbx,(%rax)
    7a0a:	48 8d 78 08          	lea    0x8(%rax),%rdi
    7a0e:	4c 89 f6             	mov    %r14,%rsi
    7a11:	48 89 da             	mov    %rbx,%rdx
    7a14:	e8 17 a9 ff ff       	call   2330 <memcpy@plt>
    7a19:	41 c6 44 1f 08 00    	movb   $0x0,0x8(%r15,%rbx,1)
    7a1f:	4c 89 f8             	mov    %r15,%rax
    7a22:	5b                   	pop    %rbx
    7a23:	41 5e                	pop    %r14
    7a25:	41 5f                	pop    %r15
    7a27:	c3                   	ret
    7a28:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    7a2f:	00 

0000000000007a30 <buf_putc>:
    7a30:	50                   	push   %rax
    7a31:	40 88 74 24 07       	mov    %sil,0x7(%rsp)
    7a36:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
    7a3b:	ba 01 00 00 00       	mov    $0x1,%edx
    7a40:	e8 3b 00 00 00       	call   7a80 <buf_put>
    7a45:	58                   	pop    %rax
    7a46:	c3                   	ret
    7a47:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    7a4e:	00 00 

0000000000007a50 <buf_puts>:
    7a50:	41 56                	push   %r14
    7a52:	53                   	push   %rbx
    7a53:	50                   	push   %rax
    7a54:	48 89 f3             	mov    %rsi,%rbx
    7a57:	49 89 fe             	mov    %rdi,%r14
    7a5a:	48 89 f7             	mov    %rsi,%rdi
    7a5d:	e8 0e a7 ff ff       	call   2170 <strlen@plt>
    7a62:	4c 89 f7             	mov    %r14,%rdi
    7a65:	48 89 de             	mov    %rbx,%rsi
    7a68:	48 89 c2             	mov    %rax,%rdx
    7a6b:	48 83 c4 08          	add    $0x8,%rsp
    7a6f:	5b                   	pop    %rbx
    7a70:	41 5e                	pop    %r14
    7a72:	eb 0c                	jmp    7a80 <buf_put>
    7a74:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    7a7b:	00 00 00 00 00 

0000000000007a80 <buf_put>:
    7a80:	41 57                	push   %r15
    7a82:	41 56                	push   %r14
    7a84:	53                   	push   %rbx
    7a85:	48 89 d3             	mov    %rdx,%rbx
    7a88:	49 89 f6             	mov    %rsi,%r14
    7a8b:	49 89 ff             	mov    %rdi,%r15
    7a8e:	48 89 d6             	mov    %rdx,%rsi
    7a91:	e8 6a 00 00 00       	call   7b00 <buf_grow>
    7a96:	49 8b 3f             	mov    (%r15),%rdi
    7a99:	49 03 7f 08          	add    0x8(%r15),%rdi
    7a9d:	4c 89 f6             	mov    %r14,%rsi
    7aa0:	48 89 da             	mov    %rbx,%rdx
    7aa3:	e8 88 a8 ff ff       	call   2330 <memcpy@plt>
    7aa8:	49 03 5f 08          	add    0x8(%r15),%rbx
    7aac:	49 89 5f 08          	mov    %rbx,0x8(%r15)
    7ab0:	49 8b 07             	mov    (%r15),%rax
    7ab3:	c6 04 18 00          	movb   $0x0,(%rax,%rbx,1)
    7ab7:	5b                   	pop    %rbx
    7ab8:	41 5e                	pop    %r14
    7aba:	41 5f                	pop    %r15
    7abc:	c3                   	ret
    7abd:	0f 1f 00             	nopl   (%rax)

0000000000007ac0 <buf_to_str>:
    7ac0:	41 56                	push   %r14
    7ac2:	53                   	push   %rbx
    7ac3:	50                   	push   %rax
    7ac4:	48 89 fb             	mov    %rdi,%rbx
    7ac7:	48 8b 07             	mov    (%rdi),%rax
    7aca:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    7ace:	48 85 c0             	test   %rax,%rax
    7ad1:	48 8d 3d c8 72 00 00 	lea    0x72c8(%rip),%rdi        # eda0 <exec_in_fp0+0x750>
    7ad8:	48 0f 45 f8          	cmovne %rax,%rdi
    7adc:	e8 0f ff ff ff       	call   79f0 <fwp_str_new>
    7ae1:	49 89 c6             	mov    %rax,%r14
    7ae4:	48 8b 3b             	mov    (%rbx),%rdi
    7ae7:	e8 64 a5 ff ff       	call   2050 <free@plt>
    7aec:	4c 89 f0             	mov    %r14,%rax
    7aef:	48 83 c4 08          	add    $0x8,%rsp
    7af3:	5b                   	pop    %rbx
    7af4:	41 5e                	pop    %r14
    7af6:	c3                   	ret
    7af7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    7afe:	00 00 

0000000000007b00 <buf_grow>:
    7b00:	41 56                	push   %r14
    7b02:	53                   	push   %rbx
    7b03:	50                   	push   %rax
    7b04:	48 8b 47 08          	mov    0x8(%rdi),%rax
    7b08:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    7b0c:	74 73                	je     7b81 <buf_grow+0x81>
    7b0e:	48 c7 c1 fe ff ff ff 	mov    $0xfffffffffffffffe,%rcx
    7b15:	48 29 c1             	sub    %rax,%rcx
    7b18:	48 39 f1             	cmp    %rsi,%rcx
    7b1b:	72 64                	jb     7b81 <buf_grow+0x81>
    7b1d:	48 89 fb             	mov    %rdi,%rbx
    7b20:	48 01 f0             	add    %rsi,%rax
    7b23:	48 ff c0             	inc    %rax
    7b26:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    7b2a:	48 39 c8             	cmp    %rcx,%rax
    7b2d:	76 4a                	jbe    7b79 <buf_grow+0x79>
    7b2f:	48 85 c9             	test   %rcx,%rcx
    7b32:	41 be 40 00 00 00    	mov    $0x40,%r14d
    7b38:	4c 0f 45 f1          	cmovne %rcx,%r14
    7b3c:	49 39 c6             	cmp    %rax,%r14
    7b3f:	73 21                	jae    7b62 <buf_grow+0x62>
    7b41:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7b48:	0f 1f 84 00 00 00 00 
    7b4f:	00 
    7b50:	4d 85 f6             	test   %r14,%r14
    7b53:	78 0a                	js     7b5f <buf_grow+0x5f>
    7b55:	4d 01 f6             	add    %r14,%r14
    7b58:	49 39 c6             	cmp    %rax,%r14
    7b5b:	72 f3                	jb     7b50 <buf_grow+0x50>
    7b5d:	eb 03                	jmp    7b62 <buf_grow+0x62>
    7b5f:	49 89 c6             	mov    %rax,%r14
    7b62:	48 8b 3b             	mov    (%rbx),%rdi
    7b65:	4c 89 f6             	mov    %r14,%rsi
    7b68:	e8 13 a8 ff ff       	call   2380 <realloc@plt>
    7b6d:	48 85 c0             	test   %rax,%rax
    7b70:	74 0f                	je     7b81 <buf_grow+0x81>
    7b72:	48 89 03             	mov    %rax,(%rbx)
    7b75:	4c 89 73 10          	mov    %r14,0x10(%rbx)
    7b79:	48 83 c4 08          	add    $0x8,%rsp
    7b7d:	5b                   	pop    %rbx
    7b7e:	41 5e                	pop    %r14
    7b80:	c3                   	ret
    7b81:	48 8b 05 58 c4 00 00 	mov    0xc458(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    7b88:	48 8b 08             	mov    (%rax),%rcx
    7b8b:	48 8d 3d e1 6b 00 00 	lea    0x6be1(%rip),%rdi        # e773 <exec_in_fp0+0x123>
    7b92:	be 13 00 00 00       	mov    $0x13,%esi
    7b97:	ba 01 00 00 00       	mov    $0x1,%edx
    7b9c:	e8 ff a8 ff ff       	call   24a0 <fwrite@plt>
    7ba1:	bf 66 00 00 00       	mov    $0x66,%edi
    7ba6:	e8 d5 a8 ff ff       	call   2480 <exit@plt>
    7bab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000007bb0 <fwp_is_number_arg>:
    7bb0:	31 c0                	xor    %eax,%eax
    7bb2:	80 3f 2d             	cmpb   $0x2d,(%rdi)
    7bb5:	75 19                	jne    7bd0 <fwp_is_number_arg+0x20>
    7bb7:	0f b6 4f 01          	movzbl 0x1(%rdi),%ecx
    7bbb:	8d 51 d0             	lea    -0x30(%rcx),%edx
    7bbe:	b8 01 00 00 00       	mov    $0x1,%eax
    7bc3:	80 fa 0a             	cmp    $0xa,%dl
    7bc6:	72 08                	jb     7bd0 <fwp_is_number_arg+0x20>
    7bc8:	31 c0                	xor    %eax,%eax
    7bca:	80 f9 2e             	cmp    $0x2e,%cl
    7bcd:	0f 94 c0             	sete   %al
    7bd0:	c3                   	ret
    7bd1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7bd8:	0f 1f 84 00 00 00 00 
    7bdf:	00 

0000000000007be0 <fwp_strf>:
    7be0:	55                   	push   %rbp
    7be1:	41 57                	push   %r15
    7be3:	41 56                	push   %r14
    7be5:	41 55                	push   %r13
    7be7:	41 54                	push   %r12
    7be9:	53                   	push   %rbx
    7bea:	48 81 ec d8 00 00 00 	sub    $0xd8,%rsp
    7bf1:	48 89 fb             	mov    %rdi,%rbx
    7bf4:	48 89 74 24 28       	mov    %rsi,0x28(%rsp)
    7bf9:	48 89 54 24 30       	mov    %rdx,0x30(%rsp)
    7bfe:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
    7c03:	4c 89 44 24 40       	mov    %r8,0x40(%rsp)
    7c08:	4c 89 4c 24 48       	mov    %r9,0x48(%rsp)
    7c0d:	84 c0                	test   %al,%al
    7c0f:	74 37                	je     7c48 <fwp_strf+0x68>
    7c11:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
    7c16:	0f 29 4c 24 60       	movaps %xmm1,0x60(%rsp)
    7c1b:	0f 29 54 24 70       	movaps %xmm2,0x70(%rsp)
    7c20:	0f 29 9c 24 80 00 00 	movaps %xmm3,0x80(%rsp)
    7c27:	00 
    7c28:	0f 29 a4 24 90 00 00 	movaps %xmm4,0x90(%rsp)
    7c2f:	00 
    7c30:	0f 29 ac 24 a0 00 00 	movaps %xmm5,0xa0(%rsp)
    7c37:	00 
    7c38:	0f 29 b4 24 b0 00 00 	movaps %xmm6,0xb0(%rsp)
    7c3f:	00 
    7c40:	0f 29 bc 24 c0 00 00 	movaps %xmm7,0xc0(%rsp)
    7c47:	00 
    7c48:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    7c4d:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    7c52:	48 8d 84 24 10 01 00 	lea    0x110(%rsp),%rax
    7c59:	00 
    7c5a:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    7c5f:	48 bd 08 00 00 00 30 	movabs $0x3000000008,%rbp
    7c66:	00 00 00 
    7c69:	48 89 2c 24          	mov    %rbp,(%rsp)
    7c6d:	49 89 e6             	mov    %rsp,%r14
    7c70:	31 ff                	xor    %edi,%edi
    7c72:	31 f6                	xor    %esi,%esi
    7c74:	48 89 da             	mov    %rbx,%rdx
    7c77:	4c 89 f1             	mov    %r14,%rcx
    7c7a:	e8 91 a4 ff ff       	call   2110 <vsnprintf@plt>
    7c7f:	4c 63 f8             	movslq %eax,%r15
    7c82:	4d 8d 67 01          	lea    0x1(%r15),%r12
    7c86:	4c 89 e7             	mov    %r12,%rdi
    7c89:	e8 a2 eb ff ff       	call   6830 <fwp_alloc_leaf>
    7c8e:	49 89 c5             	mov    %rax,%r13
    7c91:	48 89 2c 24          	mov    %rbp,(%rsp)
    7c95:	48 8d 84 24 10 01 00 	lea    0x110(%rsp),%rax
    7c9c:	00 
    7c9d:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    7ca2:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    7ca7:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    7cac:	4c 89 ef             	mov    %r13,%rdi
    7caf:	4c 89 e6             	mov    %r12,%rsi
    7cb2:	48 89 da             	mov    %rbx,%rdx
    7cb5:	4c 89 f1             	mov    %r14,%rcx
    7cb8:	e8 53 a4 ff ff       	call   2110 <vsnprintf@plt>
    7cbd:	4c 89 ef             	mov    %r13,%rdi
    7cc0:	4c 89 fe             	mov    %r15,%rsi
    7cc3:	e8 28 fd ff ff       	call   79f0 <fwp_str_new>
    7cc8:	48 81 c4 d8 00 00 00 	add    $0xd8,%rsp
    7ccf:	5b                   	pop    %rbx
    7cd0:	41 5c                	pop    %r12
    7cd2:	41 5d                	pop    %r13
    7cd4:	41 5e                	pop    %r14
    7cd6:	41 5f                	pop    %r15
    7cd8:	5d                   	pop    %rbp
    7cd9:	c3                   	ret
    7cda:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000007ce0 <fwp_cli_value>:
    7ce0:	55                   	push   %rbp
    7ce1:	41 57                	push   %r15
    7ce3:	41 56                	push   %r14
    7ce5:	41 55                	push   %r13
    7ce7:	41 54                	push   %r12
    7ce9:	53                   	push   %rbx
    7cea:	48 83 ec 58          	sub    $0x58,%rsp
    7cee:	49 89 cf             	mov    %rcx,%r15
    7cf1:	48 89 d3             	mov    %rdx,%rbx
    7cf4:	49 89 f6             	mov    %rsi,%r14
    7cf7:	49 89 fc             	mov    %rdi,%r12
    7cfa:	e8 91 01 00 00       	call   7e90 <fwp_is_enum>
    7cff:	85 c0                	test   %eax,%eax
    7d01:	0f 84 ef 00 00 00    	je     7df6 <fwp_cli_value+0x116>
    7d07:	48 89 5c 24 38       	mov    %rbx,0x38(%rsp)
    7d0c:	0f 57 c0             	xorps  %xmm0,%xmm0
    7d0f:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    7d14:	48 c7 44 24 50 00 00 	movq   $0x0,0x50(%rsp)
    7d1b:	00 00 
    7d1d:	0f 29 04 24          	movaps %xmm0,(%rsp)
    7d21:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    7d28:	00 00 
    7d2a:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
    7d2f:	4c 89 e6             	mov    %r12,%rsi
    7d32:	4c 89 74 24 30       	mov    %r14,0x30(%rsp)
    7d37:	4c 89 f2             	mov    %r14,%rdx
    7d3a:	e8 d1 01 00 00       	call   7f10 <fwp_loose>
    7d3f:	4c 8b 6c 24 40       	mov    0x40(%rsp),%r13
    7d44:	31 db                	xor    %ebx,%ebx
    7d46:	83 3d f3 df 00 00 00 	cmpl   $0x0,0xdff3(%rip)        # 15d40 <d0+0x10>
    7d4d:	41 be ff ff ff ff    	mov    $0xffffffff,%r14d
    7d53:	7e 7a                	jle    7dcf <fwp_cli_value+0xef>
    7d55:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
    7d5a:	48 85 ed             	test   %rbp,%rbp
    7d5d:	74 70                	je     7dcf <fwp_cli_value+0xef>
    7d5f:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
    7d64:	4c 89 7c 24 28       	mov    %r15,0x28(%rsp)
    7d69:	45 31 ff             	xor    %r15d,%r15d
    7d6c:	48 89 e3             	mov    %rsp,%rbx
    7d6f:	90                   	nop
    7d70:	48 8b 05 d1 df 00 00 	mov    0xdfd1(%rip),%rax        # 15d48 <d0+0x18>
    7d77:	4e 8b 24 f8          	mov    (%rax,%r15,8),%r12
    7d7b:	4c 89 e7             	mov    %r12,%rdi
    7d7e:	e8 ed a3 ff ff       	call   2170 <strlen@plt>
    7d83:	48 89 df             	mov    %rbx,%rdi
    7d86:	4c 89 e6             	mov    %r12,%rsi
    7d89:	48 89 c2             	mov    %rax,%rdx
    7d8c:	e8 7f 01 00 00       	call   7f10 <fwp_loose>
    7d91:	48 39 6c 24 08       	cmp    %rbp,0x8(%rsp)
    7d96:	75 15                	jne    7dad <fwp_cli_value+0xcd>
    7d98:	48 8b 3c 24          	mov    (%rsp),%rdi
    7d9c:	4c 89 ee             	mov    %r13,%rsi
    7d9f:	48 89 ea             	mov    %rbp,%rdx
    7da2:	e8 c9 a5 ff ff       	call   2370 <bcmp@plt>
    7da7:	85 c0                	test   %eax,%eax
    7da9:	45 0f 44 f7          	cmove  %r15d,%r14d
    7dad:	49 ff c7             	inc    %r15
    7db0:	48 63 05 89 df 00 00 	movslq 0xdf89(%rip),%rax        # 15d40 <d0+0x10>
    7db7:	49 39 c7             	cmp    %rax,%r15
    7dba:	7d 05                	jge    7dc1 <fwp_cli_value+0xe1>
    7dbc:	45 85 f6             	test   %r14d,%r14d
    7dbf:	78 af                	js     7d70 <fwp_cli_value+0x90>
    7dc1:	48 8b 1c 24          	mov    (%rsp),%rbx
    7dc5:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
    7dca:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
    7dcf:	4c 89 ef             	mov    %r13,%rdi
    7dd2:	e8 79 a2 ff ff       	call   2050 <free@plt>
    7dd7:	48 89 df             	mov    %rbx,%rdi
    7dda:	e8 71 a2 ff ff       	call   2050 <free@plt>
    7ddf:	45 85 f6             	test   %r14d,%r14d
    7de2:	78 3e                	js     7e22 <fwp_cli_value+0x142>
    7de4:	44 89 f0             	mov    %r14d,%eax
    7de7:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
    7dec:	48 89 01             	mov    %rax,(%rcx)
    7def:	bb 01 00 00 00       	mov    $0x1,%ebx
    7df4:	eb 50                	jmp    7e46 <fwp_cli_value+0x166>
    7df6:	4c 89 e7             	mov    %r12,%rdi
    7df9:	4c 89 f6             	mov    %r14,%rsi
    7dfc:	48 89 da             	mov    %rbx,%rdx
    7dff:	e8 dc eb ff ff       	call   69e0 <fwp_parse_text>
    7e04:	bb 01 00 00 00       	mov    $0x1,%ebx
    7e09:	85 c0                	test   %eax,%eax
    7e0b:	75 39                	jne    7e46 <fwp_cli_value+0x166>
    7e0d:	48 8d 3d 3b 74 00 00 	lea    0x743b(%rip),%rdi        # f24f <exec_in_fp0+0xbff>
    7e14:	48 8d 0d 84 76 00 00 	lea    0x7684(%rip),%rcx        # f49f <exec_in_fp0+0xe4f>
    7e1b:	31 db                	xor    %ebx,%ebx
    7e1d:	44 89 f6             	mov    %r14d,%esi
    7e20:	eb 17                	jmp    7e39 <fwp_cli_value+0x159>
    7e22:	e8 69 01 00 00       	call   7f90 <fwp_choices>
    7e27:	48 8d 48 08          	lea    0x8(%rax),%rcx
    7e2b:	48 8d 3d 05 74 00 00 	lea    0x7405(%rip),%rdi        # f237 <exec_in_fp0+0xbe7>
    7e32:	31 db                	xor    %ebx,%ebx
    7e34:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    7e39:	4c 89 e2             	mov    %r12,%rdx
    7e3c:	31 c0                	xor    %eax,%eax
    7e3e:	e8 9d fd ff ff       	call   7be0 <fwp_strf>
    7e43:	49 89 07             	mov    %rax,(%r15)
    7e46:	89 d8                	mov    %ebx,%eax
    7e48:	48 83 c4 58          	add    $0x58,%rsp
    7e4c:	5b                   	pop    %rbx
    7e4d:	41 5c                	pop    %r12
    7e4f:	41 5d                	pop    %r13
    7e51:	41 5e                	pop    %r14
    7e53:	41 5f                	pop    %r15
    7e55:	5d                   	pop    %rbp
    7e56:	c3                   	ret
    7e57:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    7e5e:	00 00 

0000000000007e60 <fwp_cons>:
    7e60:	48 83 ec 18          	sub    $0x18,%rsp
    7e64:	48 89 3c 24          	mov    %rdi,(%rsp)
    7e68:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    7e6d:	48 89 e2             	mov    %rsp,%rdx
    7e70:	bf 01 00 00 00       	mov    $0x1,%edi
    7e75:	be 02 00 00 00       	mov    $0x2,%esi
    7e7a:	e8 a1 b2 ff ff       	call   3120 <fwp_data>
    7e7f:	48 83 c4 18          	add    $0x18,%rsp
    7e83:	c3                   	ret
    7e84:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    7e8b:	00 00 00 00 00 

0000000000007e90 <fwp_is_enum>:
    7e90:	31 c0                	xor    %eax,%eax
    7e92:	83 3d 97 de 00 00 0e 	cmpl   $0xe,0xde97(%rip)        # 15d30 <d0>
    7e99:	75 67                	jne    7f02 <fwp_is_enum+0x72>
    7e9b:	53                   	push   %rbx
    7e9c:	8b 1d 9e de 00 00    	mov    0xde9e(%rip),%ebx        # 15d40 <d0+0x10>
    7ea2:	85 db                	test   %ebx,%ebx
    7ea4:	74 5b                	je     7f01 <fwp_is_enum+0x71>
    7ea6:	48 8b 3d 8b de 00 00 	mov    0xde8b(%rip),%rdi        # 15d38 <d0+0x8>
    7ead:	48 85 ff             	test   %rdi,%rdi
    7eb0:	74 14                	je     7ec6 <fwp_is_enum+0x36>
    7eb2:	48 8d 35 b0 73 00 00 	lea    0x73b0(%rip),%rsi        # f269 <exec_in_fp0+0xc19>
    7eb9:	e8 12 a4 ff ff       	call   22d0 <strcmp@plt>
    7ebe:	89 c1                	mov    %eax,%ecx
    7ec0:	31 c0                	xor    %eax,%eax
    7ec2:	85 c9                	test   %ecx,%ecx
    7ec4:	74 3b                	je     7f01 <fwp_is_enum+0x71>
    7ec6:	85 db                	test   %ebx,%ebx
    7ec8:	7e 32                	jle    7efc <fwp_is_enum+0x6c>
    7eca:	48 8b 0d 87 de 00 00 	mov    0xde87(%rip),%rcx        # 15d58 <d0+0x28>
    7ed1:	83 39 00             	cmpl   $0x0,(%rcx)
    7ed4:	75 2b                	jne    7f01 <fwp_is_enum+0x71>
    7ed6:	b8 01 00 00 00       	mov    $0x1,%eax
    7edb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7ee0:	48 89 c2             	mov    %rax,%rdx
    7ee3:	48 39 c3             	cmp    %rax,%rbx
    7ee6:	74 0a                	je     7ef2 <fwp_is_enum+0x62>
    7ee8:	48 8d 42 01          	lea    0x1(%rdx),%rax
    7eec:	83 3c 91 00          	cmpl   $0x0,(%rcx,%rdx,4)
    7ef0:	74 ee                	je     7ee0 <fwp_is_enum+0x50>
    7ef2:	31 c0                	xor    %eax,%eax
    7ef4:	48 39 da             	cmp    %rbx,%rdx
    7ef7:	0f 93 c0             	setae  %al
    7efa:	eb 05                	jmp    7f01 <fwp_is_enum+0x71>
    7efc:	b8 01 00 00 00       	mov    $0x1,%eax
    7f01:	5b                   	pop    %rbx
    7f02:	c3                   	ret
    7f03:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7f0a:	84 00 00 00 00 00 

0000000000007f10 <fwp_loose>:
    7f10:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
    7f17:	00 
    7f18:	48 85 d2             	test   %rdx,%rdx
    7f1b:	74 63                	je     7f80 <fwp_loose+0x70>
    7f1d:	41 57                	push   %r15
    7f1f:	41 56                	push   %r14
    7f21:	41 54                	push   %r12
    7f23:	53                   	push   %rbx
    7f24:	50                   	push   %rax
    7f25:	48 89 d3             	mov    %rdx,%rbx
    7f28:	49 89 f6             	mov    %rsi,%r14
    7f2b:	49 89 ff             	mov    %rdi,%r15
    7f2e:	45 31 e4             	xor    %r12d,%r12d
    7f31:	eb 15                	jmp    7f48 <fwp_loose+0x38>
    7f33:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7f3a:	84 00 00 00 00 00 
    7f40:	49 ff c4             	inc    %r12
    7f43:	4c 39 e3             	cmp    %r12,%rbx
    7f46:	74 2d                	je     7f75 <fwp_loose+0x65>
    7f48:	43 0f b6 04 26       	movzbl (%r14,%r12,1),%eax
    7f4d:	83 f8 2d             	cmp    $0x2d,%eax
    7f50:	74 ee                	je     7f40 <fwp_loose+0x30>
    7f52:	83 f8 5f             	cmp    $0x5f,%eax
    7f55:	74 e9                	je     7f40 <fwp_loose+0x30>
    7f57:	8d 48 bf             	lea    -0x41(%rax),%ecx
    7f5a:	0f b6 d0             	movzbl %al,%edx
    7f5d:	0c 20                	or     $0x20,%al
    7f5f:	80 f9 1a             	cmp    $0x1a,%cl
    7f62:	0f b6 c0             	movzbl %al,%eax
    7f65:	0f 43 c2             	cmovae %edx,%eax
    7f68:	0f be f0             	movsbl %al,%esi
    7f6b:	4c 89 ff             	mov    %r15,%rdi
    7f6e:	e8 bd fa ff ff       	call   7a30 <buf_putc>
    7f73:	eb cb                	jmp    7f40 <fwp_loose+0x30>
    7f75:	48 83 c4 08          	add    $0x8,%rsp
    7f79:	5b                   	pop    %rbx
    7f7a:	41 5c                	pop    %r12
    7f7c:	41 5e                	pop    %r14
    7f7e:	41 5f                	pop    %r15
    7f80:	c3                   	ret
    7f81:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7f88:	0f 1f 84 00 00 00 00 
    7f8f:	00 

0000000000007f90 <fwp_choices>:
    7f90:	41 57                	push   %r15
    7f92:	41 56                	push   %r14
    7f94:	53                   	push   %rbx
    7f95:	48 83 ec 20          	sub    $0x20,%rsp
    7f99:	0f 57 c0             	xorps  %xmm0,%xmm0
    7f9c:	0f 29 04 24          	movaps %xmm0,(%rsp)
    7fa0:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    7fa7:	00 00 
    7fa9:	83 3d 90 dd 00 00 00 	cmpl   $0x0,0xdd90(%rip)        # 15d40 <d0+0x10>
    7fb0:	7e 5b                	jle    800d <fwp_choices+0x7d>
    7fb2:	48 8b 05 8f dd 00 00 	mov    0xdd8f(%rip),%rax        # 15d48 <d0+0x18>
    7fb9:	48 8b 30             	mov    (%rax),%rsi
    7fbc:	48 89 e7             	mov    %rsp,%rdi
    7fbf:	e8 5c 00 00 00       	call   8020 <fwp_kebab>
    7fc4:	83 3d 75 dd 00 00 02 	cmpl   $0x2,0xdd75(%rip)        # 15d40 <d0+0x10>
    7fcb:	7c 40                	jl     800d <fwp_choices+0x7d>
    7fcd:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    7fd3:	48 8d 1d 94 72 00 00 	lea    0x7294(%rip),%rbx        # f26e <exec_in_fp0+0xc1e>
    7fda:	49 89 e6             	mov    %rsp,%r14
    7fdd:	0f 1f 00             	nopl   (%rax)
    7fe0:	4c 89 f7             	mov    %r14,%rdi
    7fe3:	48 89 de             	mov    %rbx,%rsi
    7fe6:	e8 65 fa ff ff       	call   7a50 <buf_puts>
    7feb:	48 8b 05 56 dd 00 00 	mov    0xdd56(%rip),%rax        # 15d48 <d0+0x18>
    7ff2:	4a 8b 34 f8          	mov    (%rax,%r15,8),%rsi
    7ff6:	4c 89 f7             	mov    %r14,%rdi
    7ff9:	e8 22 00 00 00       	call   8020 <fwp_kebab>
    7ffe:	49 ff c7             	inc    %r15
    8001:	48 63 05 38 dd 00 00 	movslq 0xdd38(%rip),%rax        # 15d40 <d0+0x10>
    8008:	49 39 c7             	cmp    %rax,%r15
    800b:	7c d3                	jl     7fe0 <fwp_choices+0x50>
    800d:	48 89 e7             	mov    %rsp,%rdi
    8010:	e8 ab fa ff ff       	call   7ac0 <buf_to_str>
    8015:	48 83 c4 20          	add    $0x20,%rsp
    8019:	5b                   	pop    %rbx
    801a:	41 5e                	pop    %r14
    801c:	41 5f                	pop    %r15
    801e:	c3                   	ret
    801f:	90                   	nop

0000000000008020 <fwp_kebab>:
    8020:	41 57                	push   %r15
    8022:	41 56                	push   %r14
    8024:	53                   	push   %rbx
    8025:	44 0f b6 3e          	movzbl (%rsi),%r15d
    8029:	45 84 ff             	test   %r15b,%r15b
    802c:	74 71                	je     809f <fwp_kebab+0x7f>
    802e:	48 89 f3             	mov    %rsi,%rbx
    8031:	49 89 fe             	mov    %rdi,%r14
    8034:	48 ff c3             	inc    %rbx
    8037:	31 c0                	xor    %eax,%eax
    8039:	eb 36                	jmp    8071 <fwp_kebab+0x51>
    803b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8040:	41 0f be f7          	movsbl %r15b,%esi
    8044:	4c 89 f7             	mov    %r14,%rdi
    8047:	e8 e4 f9 ff ff       	call   7a30 <buf_putc>
    804c:	41 8d 47 9f          	lea    -0x61(%r15),%eax
    8050:	3c 1a                	cmp    $0x1a,%al
    8052:	0f 92 c0             	setb   %al
    8055:	41 80 c7 d0          	add    $0xd0,%r15b
    8059:	41 80 ff 0a          	cmp    $0xa,%r15b
    805d:	0f 92 c1             	setb   %cl
    8060:	08 c1                	or     %al,%cl
    8062:	0f b6 c1             	movzbl %cl,%eax
    8065:	44 0f b6 3b          	movzbl (%rbx),%r15d
    8069:	48 ff c3             	inc    %rbx
    806c:	45 84 ff             	test   %r15b,%r15b
    806f:	74 2e                	je     809f <fwp_kebab+0x7f>
    8071:	41 8d 4f bf          	lea    -0x41(%r15),%ecx
    8075:	80 f9 19             	cmp    $0x19,%cl
    8078:	77 c6                	ja     8040 <fwp_kebab+0x20>
    807a:	85 c0                	test   %eax,%eax
    807c:	74 0d                	je     808b <fwp_kebab+0x6b>
    807e:	4c 89 f7             	mov    %r14,%rdi
    8081:	be 2d 00 00 00       	mov    $0x2d,%esi
    8086:	e8 a5 f9 ff ff       	call   7a30 <buf_putc>
    808b:	41 80 cf 20          	or     $0x20,%r15b
    808f:	41 0f be f7          	movsbl %r15b,%esi
    8093:	4c 89 f7             	mov    %r14,%rdi
    8096:	e8 95 f9 ff ff       	call   7a30 <buf_putc>
    809b:	31 c0                	xor    %eax,%eax
    809d:	eb c6                	jmp    8065 <fwp_kebab+0x45>
    809f:	5b                   	pop    %rbx
    80a0:	41 5e                	pop    %r14
    80a2:	41 5f                	pop    %r15
    80a4:	c3                   	ret
    80a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    80ac:	00 00 00 00 

00000000000080b0 <tp_value>:
    80b0:	55                   	push   %rbp
    80b1:	41 57                	push   %r15
    80b3:	41 56                	push   %r14
    80b5:	41 55                	push   %r13
    80b7:	41 54                	push   %r12
    80b9:	53                   	push   %rbx
    80ba:	48 81 ec a8 01 00 00 	sub    $0x1a8,%rsp
    80c1:	48 89 cd             	mov    %rcx,%rbp
    80c4:	49 89 f6             	mov    %rsi,%r14
    80c7:	49 89 ff             	mov    %rdi,%r15
    80ca:	85 d2                	test   %edx,%edx
    80cc:	74 4c                	je     811a <tp_value+0x6a>
    80ce:	41 83 3e 0c          	cmpl   $0xc,(%r14)
    80d2:	75 46                	jne    811a <tp_value+0x6a>
    80d4:	4d 8b 77 08          	mov    0x8(%r15),%r14
    80d8:	49 8b 47 10          	mov    0x10(%r15),%rax
    80dc:	4d 8b 27             	mov    (%r15),%r12
    80df:	49 01 c4             	add    %rax,%r12
    80e2:	49 29 c6             	sub    %rax,%r14
    80e5:	4c 89 e7             	mov    %r12,%rdi
    80e8:	4c 89 f6             	mov    %r14,%rsi
    80eb:	e8 a0 f7 ff ff       	call   7890 <fwp_valid_utf8>
    80f0:	85 c0                	test   %eax,%eax
    80f2:	0f 84 e9 07 00 00    	je     88e1 <tp_value+0x831>
    80f8:	4c 89 e7             	mov    %r12,%rdi
    80fb:	4c 89 f6             	mov    %r14,%rsi
    80fe:	e8 ed f8 ff ff       	call   79f0 <fwp_str_new>
    8103:	48 89 45 00          	mov    %rax,0x0(%rbp)
    8107:	49 8b 47 08          	mov    0x8(%r15),%rax
    810b:	49 89 47 10          	mov    %rax,0x10(%r15)
    810f:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    8115:	e9 ca 07 00 00       	jmp    88e4 <tp_value+0x834>
    811a:	41 89 d5             	mov    %edx,%r13d
    811d:	4c 89 ff             	mov    %r15,%rdi
    8120:	e8 bb 08 00 00       	call   89e0 <tp_ws>
    8125:	41 8b 06             	mov    (%r14),%eax
    8128:	45 31 e4             	xor    %r12d,%r12d
    812b:	48 83 f8 15          	cmp    $0x15,%rax
    812f:	0f 87 af 07 00 00    	ja     88e4 <tp_value+0x834>
    8135:	48 8d 0d 9c 60 00 00 	lea    0x609c(%rip),%rcx        # e1d8 <_IO_stdin_used+0x1d8>
    813c:	48 63 14 81          	movslq (%rcx,%rax,4),%rdx
    8140:	48 01 ca             	add    %rcx,%rdx
    8143:	ff e2                	jmp    *%rdx
    8145:	4c 89 ff             	mov    %r15,%rdi
    8148:	4c 89 f6             	mov    %r14,%rsi
    814b:	48 89 ea             	mov    %rbp,%rdx
    814e:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    8155:	5b                   	pop    %rbx
    8156:	41 5c                	pop    %r12
    8158:	41 5d                	pop    %r13
    815a:	41 5e                	pop    %r14
    815c:	41 5f                	pop    %r15
    815e:	5d                   	pop    %rbp
    815f:	e9 cc 08 00 00       	jmp    8a30 <tp_int>
    8164:	41 0f 10 46 38       	movups 0x38(%r14),%xmm0
    8169:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    816e:	31 c9                	xor    %ecx,%ecx
    8170:	83 f8 13             	cmp    $0x13,%eax
    8173:	0f 94 c1             	sete   %cl
    8176:	0f 57 c0             	xorps  %xmm0,%xmm0
    8179:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    817e:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    8185:	00 00 
    8187:	89 4c 24 48          	mov    %ecx,0x48(%rsp)
    818b:	48 8d 05 f1 70 00 00 	lea    0x70f1(%rip),%rax        # f283 <exec_in_fp0+0xc33>
    8192:	48 8d 35 ee 70 00 00 	lea    0x70ee(%rip),%rsi        # f287 <exec_in_fp0+0xc37>
    8199:	48 0f 44 f0          	cmove  %rax,%rsi
    819d:	4c 89 ff             	mov    %r15,%rdi
    81a0:	e8 fb 0b 00 00       	call   8da0 <tp_eat>
    81a5:	45 31 e4             	xor    %r12d,%r12d
    81a8:	85 c0                	test   %eax,%eax
    81aa:	0f 84 34 07 00 00    	je     88e4 <tp_value+0x834>
    81b0:	48 8d 35 a6 71 00 00 	lea    0x71a6(%rip),%rsi        # f35d <exec_in_fp0+0xd0d>
    81b7:	48 8d 15 d3 71 00 00 	lea    0x71d3(%rip),%rdx        # f391 <exec_in_fp0+0xd41>
    81be:	48 8d 0d 7b 0e 00 00 	lea    0xe7b(%rip),%rcx        # 9040 <tp_kv_item>
    81c5:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
    81ca:	4c 89 ff             	mov    %r15,%rdi
    81cd:	e8 2e 0c 00 00       	call   8e00 <tp_list_of>
    81d2:	85 c0                	test   %eax,%eax
    81d4:	0f 84 a1 03 00 00    	je     857b <tp_value+0x4cb>
    81da:	48 83 7c 24 38 00    	cmpq   $0x0,0x38(%rsp)
    81e0:	0f 84 2b 05 00 00    	je     8711 <tp_value+0x661>
    81e6:	48 8d 05 43 dc 01 00 	lea    0x1dc43(%rip),%rax        # 25e30 <fwp_empty_map>
    81ed:	31 db                	xor    %ebx,%ebx
    81ef:	90                   	nop
    81f0:	48 8b 4c 24 30       	mov    0x30(%rsp),%rcx
    81f5:	48 8b 3c d9          	mov    (%rcx,%rbx,8),%rdi
    81f9:	48 8b 74 d9 08       	mov    0x8(%rcx,%rbx,8),%rsi
    81fe:	49 8b 4e 38          	mov    0x38(%r14),%rcx
    8202:	48 89 c2             	mov    %rax,%rdx
    8205:	e8 d6 0e 00 00       	call   90e0 <fwp_p_map_insert>
    820a:	48 83 c3 02          	add    $0x2,%rbx
    820e:	48 3b 5c 24 38       	cmp    0x38(%rsp),%rbx
    8213:	72 db                	jb     81f0 <tp_value+0x140>
    8215:	e9 fe 04 00 00       	jmp    8718 <tp_value+0x668>
    821a:	0f 57 c0             	xorps  %xmm0,%xmm0
    821d:	0f 11 44 24 38       	movups %xmm0,0x38(%rsp)
    8222:	0f 11 44 24 28       	movups %xmm0,0x28(%rsp)
    8227:	48 c7 44 24 48 00 00 	movq   $0x0,0x48(%rsp)
    822e:	00 00 
    8230:	49 8b 4e 38          	mov    0x38(%r14),%rcx
    8234:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
    8239:	83 f8 11             	cmp    $0x11,%eax
    823c:	75 17                	jne    8255 <tp_value+0x1a5>
    823e:	48 8d 35 38 70 00 00 	lea    0x7038(%rip),%rsi        # f27d <exec_in_fp0+0xc2d>
    8245:	4c 89 ff             	mov    %r15,%rdi
    8248:	e8 53 0b 00 00       	call   8da0 <tp_eat>
    824d:	85 c0                	test   %eax,%eax
    824f:	0f 84 8c 06 00 00    	je     88e1 <tp_value+0x831>
    8255:	48 8d 35 ed 70 00 00 	lea    0x70ed(%rip),%rsi        # f349 <exec_in_fp0+0xcf9>
    825c:	48 8d 15 69 64 00 00 	lea    0x6469(%rip),%rdx        # e6cc <exec_in_fp0+0x7c>
    8263:	48 8d 0d e6 0c 00 00 	lea    0xce6(%rip),%rcx        # 8f50 <tp_elem_item>
    826a:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
    826f:	4c 89 ff             	mov    %r15,%rdi
    8272:	e8 89 0b 00 00       	call   8e00 <tp_list_of>
    8277:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    827c:	85 c0                	test   %eax,%eax
    827e:	0f 84 06 03 00 00    	je     858a <tp_value+0x4da>
    8284:	48 8b 74 24 38       	mov    0x38(%rsp),%rsi
    8289:	e8 42 f5 ff ff       	call   77d0 <fwp_list_from>
    828e:	49 89 c7             	mov    %rax,%r15
    8291:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    8296:	e8 75 d5 ff ff       	call   5810 <fwp_mem_free>
    829b:	41 83 3e 11          	cmpl   $0x11,(%r14)
    829f:	75 0b                	jne    82ac <tp_value+0x1fc>
    82a1:	4c 89 ff             	mov    %r15,%rdi
    82a4:	e8 e7 0c 00 00       	call   8f90 <fwp_p_array_from_list>
    82a9:	49 89 c7             	mov    %rax,%r15
    82ac:	4c 89 7d 00          	mov    %r15,0x0(%rbp)
    82b0:	e9 5a fe ff ff       	jmp    810f <tp_value+0x5f>
    82b5:	4c 89 ff             	mov    %r15,%rdi
    82b8:	4c 89 f6             	mov    %r14,%rsi
    82bb:	48 89 ea             	mov    %rbp,%rdx
    82be:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    82c5:	5b                   	pop    %rbx
    82c6:	41 5c                	pop    %r12
    82c8:	41 5d                	pop    %r13
    82ca:	41 5e                	pop    %r14
    82cc:	41 5f                	pop    %r15
    82ce:	5d                   	pop    %rbp
    82cf:	e9 bc 07 00 00       	jmp    8a90 <tp_float>
    82d4:	45 85 ed             	test   %r13d,%r13d
    82d7:	0f 85 f7 fd ff ff    	jne    80d4 <tp_value+0x24>
    82dd:	4c 89 ff             	mov    %r15,%rdi
    82e0:	48 89 ee             	mov    %rbp,%rsi
    82e3:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    82ea:	5b                   	pop    %rbx
    82eb:	41 5c                	pop    %r12
    82ed:	41 5d                	pop    %r13
    82ef:	41 5e                	pop    %r14
    82f1:	41 5f                	pop    %r15
    82f3:	5d                   	pop    %rbp
    82f4:	e9 57 08 00 00       	jmp    8b50 <tp_quoted>
    82f9:	0f 57 c0             	xorps  %xmm0,%xmm0
    82fc:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    8301:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    8306:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    830b:	48 8d 35 5f 6f 00 00 	lea    0x6f5f(%rip),%rsi        # f271 <exec_in_fp0+0xc21>
    8312:	4c 89 ff             	mov    %r15,%rdi
    8315:	e8 86 0a 00 00       	call   8da0 <tp_eat>
    831a:	45 31 e4             	xor    %r12d,%r12d
    831d:	85 c0                	test   %eax,%eax
    831f:	0f 84 6f 02 00 00    	je     8594 <tp_value+0x4e4>
    8325:	48 8d 35 1d 70 00 00 	lea    0x701d(%rip),%rsi        # f349 <exec_in_fp0+0xcf9>
    832c:	48 8d 15 99 63 00 00 	lea    0x6399(%rip),%rdx        # e6cc <exec_in_fp0+0x7c>
    8333:	48 8d 0d 46 0b 00 00 	lea    0xb46(%rip),%rcx        # 8e80 <tp_byte_item>
    833a:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
    833f:	4c 89 ff             	mov    %r15,%rdi
    8342:	e8 b9 0a 00 00       	call   8e00 <tp_list_of>
    8347:	85 c0                	test   %eax,%eax
    8349:	0f 84 2c 02 00 00    	je     857b <tp_value+0x4cb>
    834f:	0f 57 c0             	xorps  %xmm0,%xmm0
    8352:	0f 29 84 24 20 01 00 	movaps %xmm0,0x120(%rsp)
    8359:	00 
    835a:	48 c7 84 24 30 01 00 	movq   $0x0,0x130(%rsp)
    8361:	00 00 00 00 00 
    8366:	48 83 7c 24 38 00    	cmpq   $0x0,0x38(%rsp)
    836c:	74 2d                	je     839b <tp_value+0x2eb>
    836e:	31 db                	xor    %ebx,%ebx
    8370:	4c 8d b4 24 20 01 00 	lea    0x120(%rsp),%r14
    8377:	00 
    8378:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    837f:	00 
    8380:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    8385:	0f be 34 d8          	movsbl (%rax,%rbx,8),%esi
    8389:	4c 89 f7             	mov    %r14,%rdi
    838c:	e8 9f f6 ff ff       	call   7a30 <buf_putc>
    8391:	48 ff c3             	inc    %rbx
    8394:	48 3b 5c 24 38       	cmp    0x38(%rsp),%rbx
    8399:	72 e5                	jb     8380 <tp_value+0x2d0>
    839b:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    83a0:	e8 6b d4 ff ff       	call   5810 <fwp_mem_free>
    83a5:	48 8d bc 24 20 01 00 	lea    0x120(%rsp),%rdi
    83ac:	00 
    83ad:	e8 0e f7 ff ff       	call   7ac0 <buf_to_str>
    83b2:	48 89 45 00          	mov    %rax,0x0(%rbp)
    83b6:	e9 54 fd ff ff       	jmp    810f <tp_value+0x5f>
    83bb:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    83c0:	ba 00 01 00 00       	mov    $0x100,%edx
    83c5:	4c 89 ff             	mov    %r15,%rdi
    83c8:	e8 f3 0a 00 00       	call   8ec0 <tp_token>
    83cd:	45 31 e4             	xor    %r12d,%r12d
    83d0:	48 83 f8 02          	cmp    $0x2,%rax
    83d4:	0f 82 0a 05 00 00    	jb     88e4 <tp_value+0x834>
    83da:	80 7c 24 20 30       	cmpb   $0x30,0x20(%rsp)
    83df:	0f 85 ff 04 00 00    	jne    88e4 <tp_value+0x834>
    83e5:	80 7c 24 21 74       	cmpb   $0x74,0x21(%rsp)
    83ea:	0f 85 f4 04 00 00    	jne    88e4 <tp_value+0x834>
    83f0:	48 8d 48 fe          	lea    -0x2(%rax),%rcx
    83f4:	49 63 56 48          	movslq 0x48(%r14),%rdx
    83f8:	48 39 d1             	cmp    %rdx,%rcx
    83fb:	0f 87 e3 04 00 00    	ja     88e4 <tp_value+0x834>
    8401:	48 83 f8 03          	cmp    $0x3,%rax
    8405:	0f 82 21 05 00 00    	jb     892c <tp_value+0x87c>
    840b:	ba 02 00 00 00       	mov    $0x2,%edx
    8410:	31 c9                	xor    %ecx,%ecx
    8412:	e9 3d 01 00 00       	jmp    8554 <tp_value+0x4a4>
    8417:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    841c:	ba 10 00 00 00       	mov    $0x10,%edx
    8421:	4c 89 ff             	mov    %r15,%rdi
    8424:	e8 97 0a 00 00       	call   8ec0 <tp_token>
    8429:	8b 44 24 20          	mov    0x20(%rsp),%eax
    842d:	89 c1                	mov    %eax,%ecx
    842f:	81 f1 2b 31 00 00    	xor    $0x312b,%ecx
    8435:	0f b6 54 24 22       	movzbl 0x22(%rsp),%edx
    843a:	66 09 ca             	or     %cx,%dx
    843d:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    8443:	74 2d                	je     8472 <tp_value+0x3c2>
    8445:	66 83 f8 31          	cmp    $0x31,%ax
    8449:	74 27                	je     8472 <tp_value+0x3c2>
    844b:	45 31 e4             	xor    %r12d,%r12d
    844e:	66 83 f8 30          	cmp    $0x30,%ax
    8452:	74 1e                	je     8472 <tp_value+0x3c2>
    8454:	b8 2d 31 00 00       	mov    $0x312d,%eax
    8459:	33 44 24 20          	xor    0x20(%rsp),%eax
    845d:	0f b6 4c 24 22       	movzbl 0x22(%rsp),%ecx
    8462:	66 09 c1             	or     %ax,%cx
    8465:	0f 85 79 04 00 00    	jne    88e4 <tp_value+0x834>
    846b:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    8472:	4c 89 65 00          	mov    %r12,0x0(%rbp)
    8476:	e9 94 fc ff ff       	jmp    810f <tp_value+0x5f>
    847b:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    847f:	48 85 ff             	test   %rdi,%rdi
    8482:	0f 84 18 01 00 00    	je     85a0 <tp_value+0x4f0>
    8488:	48 8d 35 fc 6d 00 00 	lea    0x6dfc(%rip),%rsi        # f28b <exec_in_fp0+0xc3b>
    848f:	e8 3c 9e ff ff       	call   22d0 <strcmp@plt>
    8494:	85 c0                	test   %eax,%eax
    8496:	0f 84 23 03 00 00    	je     87bf <tp_value+0x70f>
    849c:	4c 89 ff             	mov    %r15,%rdi
    849f:	e8 3c 05 00 00       	call   89e0 <tp_ws>
    84a4:	4d 8b 6e 08          	mov    0x8(%r14),%r13
    84a8:	4c 89 ef             	mov    %r13,%rdi
    84ab:	e8 c0 9c ff ff       	call   2170 <strlen@plt>
    84b0:	49 89 c4             	mov    %rax,%r12
    84b3:	49 8b 47 08          	mov    0x8(%r15),%rax
    84b7:	49 8b 5f 10          	mov    0x10(%r15),%rbx
    84bb:	48 29 d8             	sub    %rbx,%rax
    84be:	4c 39 e0             	cmp    %r12,%rax
    84c1:	0f 82 c4 01 00 00    	jb     868b <tp_value+0x5db>
    84c7:	49 8b 3f             	mov    (%r15),%rdi
    84ca:	48 01 df             	add    %rbx,%rdi
    84cd:	4c 89 ee             	mov    %r13,%rsi
    84d0:	4c 89 e2             	mov    %r12,%rdx
    84d3:	e8 98 9e ff ff       	call   2370 <bcmp@plt>
    84d8:	85 c0                	test   %eax,%eax
    84da:	0f 85 ab 01 00 00    	jne    868b <tp_value+0x5db>
    84e0:	4c 01 e3             	add    %r12,%rbx
    84e3:	49 89 5f 10          	mov    %rbx,0x10(%r15)
    84e7:	e9 9f 01 00 00       	jmp    868b <tp_value+0x5db>
    84ec:	48 89 2c 24          	mov    %rbp,(%rsp)
    84f0:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    84f5:	4c 89 ff             	mov    %r15,%rdi
    84f8:	e8 d3 0e 00 00       	call   93d0 <tp_ident>
    84fd:	41 8b 5e 10          	mov    0x10(%r14),%ebx
    8501:	85 db                	test   %ebx,%ebx
    8503:	4c 89 74 24 08       	mov    %r14,0x8(%rsp)
    8508:	0f 8e 9c 01 00 00    	jle    86aa <tp_value+0x5fa>
    850e:	4d 8b 66 18          	mov    0x18(%r14),%r12
    8512:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    8517:	45 31 f6             	xor    %r14d,%r14d
    851a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8520:	4b 8b 3c f4          	mov    (%r12,%r14,8),%rdi
    8524:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8529:	e8 a2 9d ff ff       	call   22d0 <strcmp@plt>
    852e:	85 c0                	test   %eax,%eax
    8530:	41 0f 44 ee          	cmove  %r14d,%ebp
    8534:	49 ff c6             	inc    %r14
    8537:	4c 39 f3             	cmp    %r14,%rbx
    853a:	75 e4                	jne    8520 <tp_value+0x470>
    853c:	e9 6e 01 00 00       	jmp    86af <tp_value+0x5ff>
    8541:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    8545:	48 ff c9             	dec    %rcx
    8548:	48 ff c2             	inc    %rdx
    854b:	48 39 d0             	cmp    %rdx,%rax
    854e:	0f 84 da 03 00 00    	je     892e <tp_value+0x87e>
    8554:	0f b6 74 14 20       	movzbl 0x20(%rsp,%rdx,1),%esi
    8559:	83 fe 30             	cmp    $0x30,%esi
    855c:	74 17                	je     8575 <tp_value+0x4c5>
    855e:	83 fe 2d             	cmp    $0x2d,%esi
    8561:	74 de                	je     8541 <tp_value+0x491>
    8563:	83 fe 2b             	cmp    $0x2b,%esi
    8566:	0f 85 75 03 00 00    	jne    88e1 <tp_value+0x831>
    856c:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    8570:	48 ff c1             	inc    %rcx
    8573:	eb d3                	jmp    8548 <tp_value+0x498>
    8575:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    8579:	eb cd                	jmp    8548 <tp_value+0x498>
    857b:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    8580:	e8 8b d2 ff ff       	call   5810 <fwp_mem_free>
    8585:	e9 5a 03 00 00       	jmp    88e4 <tp_value+0x834>
    858a:	e8 81 d2 ff ff       	call   5810 <fwp_mem_free>
    858f:	e9 4d 03 00 00       	jmp    88e1 <tp_value+0x831>
    8594:	31 ff                	xor    %edi,%edi
    8596:	e8 75 d2 ff ff       	call   5810 <fwp_mem_free>
    859b:	e9 44 03 00 00       	jmp    88e4 <tp_value+0x834>
    85a0:	49 63 7e 10          	movslq 0x10(%r14),%rdi
    85a4:	48 85 ff             	test   %rdi,%rdi
    85a7:	0f 84 4c 03 00 00    	je     88f9 <tp_value+0x849>
    85ad:	41 83 7e 48 00       	cmpl   $0x0,0x48(%r14)
    85b2:	0f 84 d3 00 00 00    	je     868b <tp_value+0x5db>
    85b8:	48 c1 e7 03          	shl    $0x3,%rdi
    85bc:	e8 5f d1 ff ff       	call   5720 <fwp_alloc>
    85c1:	48 89 c3             	mov    %rax,%rbx
    85c4:	48 8d 35 d0 6c 00 00 	lea    0x6cd0(%rip),%rsi        # f29b <exec_in_fp0+0xc4b>
    85cb:	4c 89 ff             	mov    %r15,%rdi
    85ce:	e8 cd 07 00 00       	call   8da0 <tp_eat>
    85d3:	85 c0                	test   %eax,%eax
    85d5:	0f 84 09 03 00 00    	je     88e4 <tp_value+0x834>
    85db:	48 89 2c 24          	mov    %rbp,(%rsp)
    85df:	41 83 7e 10 00       	cmpl   $0x0,0x10(%r14)
    85e4:	7e 77                	jle    865d <tp_value+0x5ad>
    85e6:	49 8b 46 20          	mov    0x20(%r14),%rax
    85ea:	48 8b 30             	mov    (%rax),%rsi
    85ed:	4c 89 ff             	mov    %r15,%rdi
    85f0:	31 d2                	xor    %edx,%edx
    85f2:	48 89 d9             	mov    %rbx,%rcx
    85f5:	e8 b6 fa ff ff       	call   80b0 <tp_value>
    85fa:	85 c0                	test   %eax,%eax
    85fc:	0f 84 df 02 00 00    	je     88e1 <tp_value+0x831>
    8602:	41 83 7e 10 02       	cmpl   $0x2,0x10(%r14)
    8607:	7c 54                	jl     865d <tp_value+0x5ad>
    8609:	48 89 dd             	mov    %rbx,%rbp
    860c:	48 83 c5 08          	add    $0x8,%rbp
    8610:	41 bd 01 00 00 00    	mov    $0x1,%r13d
    8616:	4c 89 ff             	mov    %r15,%rdi
    8619:	48 8d 35 7d 6c 00 00 	lea    0x6c7d(%rip),%rsi        # f29d <exec_in_fp0+0xc4d>
    8620:	e8 7b 07 00 00       	call   8da0 <tp_eat>
    8625:	85 c0                	test   %eax,%eax
    8627:	0f 84 b4 02 00 00    	je     88e1 <tp_value+0x831>
    862d:	49 8b 46 20          	mov    0x20(%r14),%rax
    8631:	4a 8b 34 e8          	mov    (%rax,%r13,8),%rsi
    8635:	45 31 e4             	xor    %r12d,%r12d
    8638:	4c 89 ff             	mov    %r15,%rdi
    863b:	31 d2                	xor    %edx,%edx
    863d:	48 89 e9             	mov    %rbp,%rcx
    8640:	e8 6b fa ff ff       	call   80b0 <tp_value>
    8645:	85 c0                	test   %eax,%eax
    8647:	0f 84 97 02 00 00    	je     88e4 <tp_value+0x834>
    864d:	49 ff c5             	inc    %r13
    8650:	49 63 46 10          	movslq 0x10(%r14),%rax
    8654:	48 83 c5 08          	add    $0x8,%rbp
    8658:	49 39 c5             	cmp    %rax,%r13
    865b:	7c b9                	jl     8616 <tp_value+0x566>
    865d:	48 8d 35 fc 6c 00 00 	lea    0x6cfc(%rip),%rsi        # f360 <exec_in_fp0+0xd10>
    8664:	4c 89 ff             	mov    %r15,%rdi
    8667:	e8 34 07 00 00       	call   8da0 <tp_eat>
    866c:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    8672:	85 c0                	test   %eax,%eax
    8674:	0f 84 6a 02 00 00    	je     88e4 <tp_value+0x834>
    867a:	41 8b 7e 10          	mov    0x10(%r14),%edi
    867e:	48 89 de             	mov    %rbx,%rsi
    8681:	e8 7a aa ff ff       	call   3100 <fwp_record>
    8686:	e9 28 01 00 00       	jmp    87b3 <tp_value+0x703>
    868b:	4c 89 ff             	mov    %r15,%rdi
    868e:	4c 89 f6             	mov    %r14,%rsi
    8691:	48 89 ea             	mov    %rbp,%rdx
    8694:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    869b:	5b                   	pop    %rbx
    869c:	41 5c                	pop    %r12
    869e:	41 5d                	pop    %r13
    86a0:	41 5e                	pop    %r14
    86a2:	41 5f                	pop    %r15
    86a4:	5d                   	pop    %rbp
    86a5:	e9 56 0b 00 00       	jmp    9200 <tp_record_body>
    86aa:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    86af:	45 85 ed             	test   %r13d,%r13d
    86b2:	74 7a                	je     872e <tp_value+0x67e>
    86b4:	85 ed                	test   %ebp,%ebp
    86b6:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    86bb:	79 76                	jns    8733 <tp_value+0x683>
    86bd:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    86c1:	45 31 e4             	xor    %r12d,%r12d
    86c4:	48 85 ff             	test   %rdi,%rdi
    86c7:	0f 84 17 02 00 00    	je     88e4 <tp_value+0x834>
    86cd:	48 8d 35 95 6b 00 00 	lea    0x6b95(%rip),%rsi        # f269 <exec_in_fp0+0xc19>
    86d4:	e8 f7 9b ff ff       	call   22d0 <strcmp@plt>
    86d9:	85 c0                	test   %eax,%eax
    86db:	0f 85 03 02 00 00    	jne    88e4 <tp_value+0x834>
    86e1:	8b 44 24 20          	mov    0x20(%rsp),%eax
    86e5:	89 c1                	mov    %eax,%ecx
    86e7:	81 f1 74 72 75 65    	xor    $0x65757274,%ecx
    86ed:	0f b6 54 24 24       	movzbl 0x24(%rsp),%edx
    86f2:	09 ca                	or     %ecx,%edx
    86f4:	b9 01 00 00 00       	mov    $0x1,%ecx
    86f9:	0f 44 e9             	cmove  %ecx,%ebp
    86fc:	35 66 61 6c 73       	xor    $0x736c6166,%eax
    8701:	0f b7 4c 24 24       	movzwl 0x24(%rsp),%ecx
    8706:	83 f1 65             	xor    $0x65,%ecx
    8709:	09 c1                	or     %eax,%ecx
    870b:	75 26                	jne    8733 <tp_value+0x683>
    870d:	31 ed                	xor    %ebp,%ebp
    870f:	eb 2a                	jmp    873b <tp_value+0x68b>
    8711:	48 8d 05 18 d7 01 00 	lea    0x1d718(%rip),%rax        # 25e30 <fwp_empty_map>
    8718:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    871d:	48 89 c3             	mov    %rax,%rbx
    8720:	e8 eb d0 ff ff       	call   5810 <fwp_mem_free>
    8725:	48 89 5d 00          	mov    %rbx,0x0(%rbp)
    8729:	e9 e1 f9 ff ff       	jmp    810f <tp_value+0x5f>
    872e:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    8733:	85 ed                	test   %ebp,%ebp
    8735:	0f 88 a6 01 00 00    	js     88e1 <tp_value+0x831>
    873b:	48 8b 43 28          	mov    0x28(%rbx),%rax
    873f:	41 89 ed             	mov    %ebp,%r13d
    8742:	4a 63 1c a8          	movslq (%rax,%r13,4),%rbx
    8746:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    874d:	00 
    874e:	e8 cd cf ff ff       	call   5720 <fwp_alloc>
    8753:	48 89 c5             	mov    %rax,%rbp
    8756:	89 d8                	mov    %ebx,%eax
    8758:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    875d:	48 85 db             	test   %rbx,%rbx
    8760:	7e 41                	jle    87a3 <tp_value+0x6f3>
    8762:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    8767:	48 8d 1c c5 00 00 00 	lea    0x0(,%rax,8),%rbx
    876e:	00 
    876f:	45 31 e4             	xor    %r12d,%r12d
    8772:	45 31 f6             	xor    %r14d,%r14d
    8775:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    877a:	48 8b 40 30          	mov    0x30(%rax),%rax
    877e:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    8782:	4a 8b 34 30          	mov    (%rax,%r14,1),%rsi
    8786:	49 8d 14 2e          	lea    (%r14,%rbp,1),%rdx
    878a:	4c 89 ff             	mov    %r15,%rdi
    878d:	e8 fe 0c 00 00       	call   9490 <tp_atom>
    8792:	85 c0                	test   %eax,%eax
    8794:	0f 84 4a 01 00 00    	je     88e4 <tp_value+0x834>
    879a:	49 83 c6 08          	add    $0x8,%r14
    879e:	4c 39 f3             	cmp    %r14,%rbx
    87a1:	75 d2                	jne    8775 <tp_value+0x6c5>
    87a3:	44 89 ef             	mov    %r13d,%edi
    87a6:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    87ab:	48 89 ea             	mov    %rbp,%rdx
    87ae:	e8 6d a9 ff ff       	call   3120 <fwp_data>
    87b3:	48 8b 0c 24          	mov    (%rsp),%rcx
    87b7:	48 89 01             	mov    %rax,(%rcx)
    87ba:	e9 50 f9 ff ff       	jmp    810f <tp_value+0x5f>
    87bf:	48 89 2c 24          	mov    %rbp,(%rsp)
    87c3:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    87c8:	ba 80 00 00 00       	mov    $0x80,%edx
    87cd:	4c 89 ff             	mov    %r15,%rdi
    87d0:	48 89 f3             	mov    %rsi,%rbx
    87d3:	e8 e8 06 00 00       	call   8ec0 <tp_token>
    87d8:	49 89 c7             	mov    %rax,%r15
    87db:	4c 8d 24 04          	lea    (%rsp,%rax,1),%r12
    87df:	49 83 c4 20          	add    $0x20,%r12
    87e3:	41 be 08 00 00 00    	mov    $0x8,%r14d
    87e9:	eb 0e                	jmp    87f9 <tp_value+0x749>
    87eb:	49 83 c6 10          	add    $0x10,%r14
    87ef:	49 83 fe 68          	cmp    $0x68,%r14
    87f3:	0f 84 e8 00 00 00    	je     88e1 <tp_value+0x831>
    87f9:	48 8d 05 70 b4 00 00 	lea    0xb470(%rip),%rax        # 13c70 <tp_value.units>
    8800:	49 8b 6c 06 f8       	mov    -0x8(%r14,%rax,1),%rbp
    8805:	48 89 ef             	mov    %rbp,%rdi
    8808:	e8 63 99 ff ff       	call   2170 <strlen@plt>
    880d:	4d 89 fd             	mov    %r15,%r13
    8810:	49 29 c5             	sub    %rax,%r13
    8813:	76 d6                	jbe    87eb <tp_value+0x73b>
    8815:	4c 89 e7             	mov    %r12,%rdi
    8818:	48 29 c7             	sub    %rax,%rdi
    881b:	48 89 ee             	mov    %rbp,%rsi
    881e:	e8 ad 9a ff ff       	call   22d0 <strcmp@plt>
    8823:	85 c0                	test   %eax,%eax
    8825:	75 c4                	jne    87eb <tp_value+0x73b>
    8827:	48 8d ac 24 20 01 00 	lea    0x120(%rsp),%rbp
    882e:	00 
    882f:	48 89 ef             	mov    %rbp,%rdi
    8832:	48 89 de             	mov    %rbx,%rsi
    8835:	4c 89 ea             	mov    %r13,%rdx
    8838:	e8 f3 9a ff ff       	call   2330 <memcpy@plt>
    883d:	42 c6 84 2c 20 01 00 	movb   $0x0,0x120(%rsp,%r13,1)
    8844:	00 00 
    8846:	48 89 ef             	mov    %rbp,%rdi
    8849:	4c 89 ee             	mov    %r13,%rsi
    884c:	e8 6f 09 00 00       	call   91c0 <fwp_valid_int>
    8851:	85 c0                	test   %eax,%eax
    8853:	74 96                	je     87eb <tp_value+0x73b>
    8855:	0f b6 b4 24 20 01 00 	movzbl 0x120(%rsp),%esi
    885c:	00 
    885d:	8d 4e d5             	lea    -0x2b(%rsi),%ecx
    8860:	31 c0                	xor    %eax,%eax
    8862:	f6 c1 fd             	test   $0xfd,%cl
    8865:	0f 94 c0             	sete   %al
    8868:	44 0f b6 94 04 20 01 	movzbl 0x120(%rsp,%rax,1),%r10d
    886f:	00 00 
    8871:	45 31 e4             	xor    %r12d,%r12d
    8874:	45 84 d2             	test   %r10b,%r10b
    8877:	0f 84 ba 00 00 00    	je     8937 <tp_value+0x887>
    887d:	48 8d 8c 24 20 01 00 	lea    0x120(%rsp),%rcx
    8884:	00 
    8885:	48 01 c1             	add    %rax,%rcx
    8888:	48 ff c1             	inc    %rcx
    888b:	31 c0                	xor    %eax,%eax
    888d:	bf 0a 00 00 00       	mov    $0xa,%edi
    8892:	49 b9 00 00 00 00 00 	movabs $0x8000000000000000,%r9
    8899:	00 00 80 
    889c:	45 31 c0             	xor    %r8d,%r8d
    889f:	48 8b 1c 24          	mov    (%rsp),%rbx
    88a3:	48 f7 e7             	mul    %rdi
    88a6:	4f 8d 04 80          	lea    (%r8,%r8,4),%r8
    88aa:	4a 8d 14 42          	lea    (%rdx,%r8,2),%rdx
    88ae:	45 0f be c2          	movsbl %r10b,%r8d
    88b2:	41 83 c0 d0          	add    $0xffffffd0,%r8d
    88b6:	4d 63 d0             	movslq %r8d,%r10
    88b9:	4d 89 d0             	mov    %r10,%r8
    88bc:	49 c1 f8 3f          	sar    $0x3f,%r8
    88c0:	4c 01 d0             	add    %r10,%rax
    88c3:	49 11 d0             	adc    %rdx,%r8
    88c6:	49 39 c1             	cmp    %rax,%r9
    88c9:	ba 00 00 00 00       	mov    $0x0,%edx
    88ce:	4c 19 c2             	sbb    %r8,%rdx
    88d1:	7c 0e                	jl     88e1 <tp_value+0x831>
    88d3:	44 0f b6 11          	movzbl (%rcx),%r10d
    88d7:	48 ff c1             	inc    %rcx
    88da:	45 84 d2             	test   %r10b,%r10b
    88dd:	75 c4                	jne    88a3 <tp_value+0x7f3>
    88df:	eb 5f                	jmp    8940 <tp_value+0x890>
    88e1:	45 31 e4             	xor    %r12d,%r12d
    88e4:	44 89 e0             	mov    %r12d,%eax
    88e7:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    88ee:	5b                   	pop    %rbx
    88ef:	41 5c                	pop    %r12
    88f1:	41 5d                	pop    %r13
    88f3:	41 5e                	pop    %r14
    88f5:	41 5f                	pop    %r15
    88f7:	5d                   	pop    %rbp
    88f8:	c3                   	ret
    88f9:	48 8d 35 9b 69 00 00 	lea    0x699b(%rip),%rsi        # f29b <exec_in_fp0+0xc4b>
    8900:	4c 89 ff             	mov    %r15,%rdi
    8903:	e8 98 04 00 00       	call   8da0 <tp_eat>
    8908:	85 c0                	test   %eax,%eax
    890a:	74 d8                	je     88e4 <tp_value+0x834>
    890c:	48 8d 35 4d 6a 00 00 	lea    0x6a4d(%rip),%rsi        # f360 <exec_in_fp0+0xd10>
    8913:	4c 89 ff             	mov    %r15,%rdi
    8916:	e8 85 04 00 00       	call   8da0 <tp_eat>
    891b:	85 c0                	test   %eax,%eax
    891d:	74 c5                	je     88e4 <tp_value+0x834>
    891f:	48 c7 45 00 00 00 00 	movq   $0x0,0x0(%rbp)
    8926:	00 
    8927:	e9 e3 f7 ff ff       	jmp    810f <tp_value+0x5f>
    892c:	31 c9                	xor    %ecx,%ecx
    892e:	48 89 4d 00          	mov    %rcx,0x0(%rbp)
    8932:	e9 d8 f7 ff ff       	jmp    810f <tp_value+0x5f>
    8937:	31 c0                	xor    %eax,%eax
    8939:	45 31 c0             	xor    %r8d,%r8d
    893c:	48 8b 1c 24          	mov    (%rsp),%rbx
    8940:	48 89 c1             	mov    %rax,%rcx
    8943:	48 f7 d9             	neg    %rcx
    8946:	bf 00 00 00 00       	mov    $0x0,%edi
    894b:	4c 19 c7             	sbb    %r8,%rdi
    894e:	40 80 fe 2d          	cmp    $0x2d,%sil
    8952:	49 0f 45 f8          	cmovne %r8,%rdi
    8956:	48 0f 45 c8          	cmovne %rax,%rcx
    895a:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    8961:	ff ff 7f 
    8964:	48 39 c8             	cmp    %rcx,%rax
    8967:	b8 00 00 00 00       	mov    $0x0,%eax
    896c:	48 19 f8             	sbb    %rdi,%rax
    896f:	0f 8c 6f ff ff ff    	jl     88e4 <tp_value+0x834>
    8975:	48 8d 05 f4 b2 00 00 	lea    0xb2f4(%rip),%rax        # 13c70 <tp_value.units>
    897c:	49 8b 34 06          	mov    (%r14,%rax,1),%rsi
    8980:	48 89 c8             	mov    %rcx,%rax
    8983:	48 f7 e6             	mul    %rsi
    8986:	48 0f af fe          	imul   %rsi,%rdi
    898a:	48 c1 fe 3f          	sar    $0x3f,%rsi
    898e:	48 0f af f1          	imul   %rcx,%rsi
    8992:	48 01 d6             	add    %rdx,%rsi
    8995:	48 01 f7             	add    %rsi,%rdi
    8998:	48 b9 00 00 00 00 00 	movabs $0x8000000000000000,%rcx
    899f:	00 00 80 
    89a2:	48 01 c1             	add    %rax,%rcx
    89a5:	48 83 d7 ff          	adc    $0xffffffffffffffff,%rdi
    89a9:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
    89ad:	0f 85 31 ff ff ff    	jne    88e4 <tp_value+0x834>
    89b3:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    89b8:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    89be:	48 8d 74 24 18       	lea    0x18(%rsp),%rsi
    89c3:	bf 01 00 00 00       	mov    $0x1,%edi
    89c8:	e8 33 a7 ff ff       	call   3100 <fwp_record>
    89cd:	48 89 03             	mov    %rax,(%rbx)
    89d0:	e9 0f ff ff ff       	jmp    88e4 <tp_value+0x834>
    89d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    89dc:	00 00 00 00 

00000000000089e0 <tp_ws>:
    89e0:	48 8b 47 08          	mov    0x8(%rdi),%rax
    89e4:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    89e8:	48 39 c1             	cmp    %rax,%rcx
    89eb:	73 39                	jae    8a26 <tp_ws+0x46>
    89ed:	48 8b 17             	mov    (%rdi),%rdx
    89f0:	48 f7 d8             	neg    %rax
    89f3:	48 ff c1             	inc    %rcx
    89f6:	48 be 00 26 00 00 01 	movabs $0x100002600,%rsi
    89fd:	00 00 00 
    8a00:	44 0f b6 44 0a ff    	movzbl -0x1(%rdx,%rcx,1),%r8d
    8a06:	49 83 f8 20          	cmp    $0x20,%r8
    8a0a:	77 1a                	ja     8a26 <tp_ws+0x46>
    8a0c:	4c 0f a3 c6          	bt     %r8,%rsi
    8a10:	73 14                	jae    8a26 <tp_ws+0x46>
    8a12:	48 89 4f 10          	mov    %rcx,0x10(%rdi)
    8a16:	4c 8d 04 08          	lea    (%rax,%rcx,1),%r8
    8a1a:	49 ff c0             	inc    %r8
    8a1d:	48 ff c1             	inc    %rcx
    8a20:	49 83 f8 01          	cmp    $0x1,%r8
    8a24:	75 da                	jne    8a00 <tp_ws+0x20>
    8a26:	c3                   	ret
    8a27:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    8a2e:	00 00 

0000000000008a30 <tp_int>:
    8a30:	55                   	push   %rbp
    8a31:	41 56                	push   %r14
    8a33:	53                   	push   %rbx
    8a34:	48 81 ec 80 00 00 00 	sub    $0x80,%rsp
    8a3b:	48 89 d3             	mov    %rdx,%rbx
    8a3e:	49 89 f6             	mov    %rsi,%r14
    8a41:	48 89 e6             	mov    %rsp,%rsi
    8a44:	ba 80 00 00 00       	mov    $0x80,%edx
    8a49:	e8 72 04 00 00       	call   8ec0 <tp_token>
    8a4e:	31 ed                	xor    %ebp,%ebp
    8a50:	48 83 f8 7f          	cmp    $0x7f,%rax
    8a54:	77 28                	ja     8a7e <tp_int+0x4e>
    8a56:	48 89 e7             	mov    %rsp,%rdi
    8a59:	e8 d2 0a 00 00       	call   9530 <fwp_cstr>
    8a5e:	41 8b 36             	mov    (%r14),%esi
    8a61:	41 8b 56 48          	mov    0x48(%r14),%edx
    8a65:	48 89 c7             	mov    %rax,%rdi
    8a68:	e8 e3 0a 00 00       	call   9550 <fwp_p_parse_int>
    8a6d:	48 85 c0             	test   %rax,%rax
    8a70:	74 0c                	je     8a7e <tp_int+0x4e>
    8a72:	48 8b 40 08          	mov    0x8(%rax),%rax
    8a76:	48 89 03             	mov    %rax,(%rbx)
    8a79:	bd 01 00 00 00       	mov    $0x1,%ebp
    8a7e:	89 e8                	mov    %ebp,%eax
    8a80:	48 81 c4 80 00 00 00 	add    $0x80,%rsp
    8a87:	5b                   	pop    %rbx
    8a88:	41 5e                	pop    %r14
    8a8a:	5d                   	pop    %rbp
    8a8b:	c3                   	ret
    8a8c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000008a90 <tp_float>:
    8a90:	41 56                	push   %r14
    8a92:	53                   	push   %rbx
    8a93:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    8a9a:	48 89 d3             	mov    %rdx,%rbx
    8a9d:	49 89 f6             	mov    %rsi,%r14
    8aa0:	48 89 e6             	mov    %rsp,%rsi
    8aa3:	ba 80 00 00 00       	mov    $0x80,%edx
    8aa8:	e8 13 04 00 00       	call   8ec0 <tp_token>
    8aad:	31 c9                	xor    %ecx,%ecx
    8aaf:	48 83 f8 7f          	cmp    $0x7f,%rax
    8ab3:	0f 87 84 00 00 00    	ja     8b3d <tp_float+0xad>
    8ab9:	8b 0c 24             	mov    (%rsp),%ecx
    8abc:	81 f9 69 6e 66 00    	cmp    $0x666e69,%ecx
    8ac2:	75 0a                	jne    8ace <tp_float+0x3e>
    8ac4:	f2 0f 10 05 94 56 00 	movsd  0x5694(%rip),%xmm0        # e160 <_IO_stdin_used+0x160>
    8acb:	00 
    8acc:	eb 5f                	jmp    8b2d <tp_float+0x9d>
    8ace:	ba 2d 69 6e 66       	mov    $0x666e692d,%edx
    8ad3:	33 14 24             	xor    (%rsp),%edx
    8ad6:	0f b6 74 24 04       	movzbl 0x4(%rsp),%esi
    8adb:	09 d6                	or     %edx,%esi
    8add:	74 12                	je     8af1 <tp_float+0x61>
    8adf:	81 f9 4e 61 4e 00    	cmp    $0x4e614e,%ecx
    8ae5:	75 14                	jne    8afb <tp_float+0x6b>
    8ae7:	f2 0f 10 05 81 56 00 	movsd  0x5681(%rip),%xmm0        # e170 <_IO_stdin_used+0x170>
    8aee:	00 
    8aef:	eb 3c                	jmp    8b2d <tp_float+0x9d>
    8af1:	f2 0f 10 05 6f 56 00 	movsd  0x566f(%rip),%xmm0        # e168 <_IO_stdin_used+0x168>
    8af8:	00 
    8af9:	eb 32                	jmp    8b2d <tp_float+0x9d>
    8afb:	48 89 e7             	mov    %rsp,%rdi
    8afe:	48 89 c6             	mov    %rax,%rsi
    8b01:	e8 7a 0e 00 00       	call   9980 <fwp_valid_float>
    8b06:	31 c9                	xor    %ecx,%ecx
    8b08:	85 c0                	test   %eax,%eax
    8b0a:	74 31                	je     8b3d <tp_float+0xad>
    8b0c:	41 83 3e 0a          	cmpl   $0xa,(%r14)
    8b10:	75 11                	jne    8b23 <tp_float+0x93>
    8b12:	48 89 e7             	mov    %rsp,%rdi
    8b15:	31 f6                	xor    %esi,%esi
    8b17:	e8 e4 96 ff ff       	call   2200 <strtof@plt>
    8b1c:	e8 ef a5 ff ff       	call   3110 <fwp_from_f32>
    8b21:	eb 12                	jmp    8b35 <tp_float+0xa5>
    8b23:	48 89 e7             	mov    %rsp,%rdi
    8b26:	31 f6                	xor    %esi,%esi
    8b28:	e8 d3 95 ff ff       	call   2100 <strtod@plt>
    8b2d:	41 8b 3e             	mov    (%r14),%edi
    8b30:	e8 3b 0f 00 00       	call   9a70 <fwp_float_of>
    8b35:	48 89 03             	mov    %rax,(%rbx)
    8b38:	b9 01 00 00 00       	mov    $0x1,%ecx
    8b3d:	89 c8                	mov    %ecx,%eax
    8b3f:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
    8b46:	5b                   	pop    %rbx
    8b47:	41 5e                	pop    %r14
    8b49:	c3                   	ret
    8b4a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000008b50 <tp_quoted>:
    8b50:	55                   	push   %rbp
    8b51:	41 57                	push   %r15
    8b53:	41 56                	push   %r14
    8b55:	41 55                	push   %r13
    8b57:	41 54                	push   %r12
    8b59:	53                   	push   %rbx
    8b5a:	48 83 ec 18          	sub    $0x18,%rsp
    8b5e:	49 89 f6             	mov    %rsi,%r14
    8b61:	49 89 ff             	mov    %rdi,%r15
    8b64:	e8 77 fe ff ff       	call   89e0 <tp_ws>
    8b69:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    8b6d:	49 8b 6f 10          	mov    0x10(%r15),%rbp
    8b71:	31 db                	xor    %ebx,%ebx
    8b73:	4c 39 ed             	cmp    %r13,%rbp
    8b76:	0f 83 0d 02 00 00    	jae    8d89 <tp_quoted+0x239>
    8b7c:	49 8b 07             	mov    (%r15),%rax
    8b7f:	80 3c 28 22          	cmpb   $0x22,(%rax,%rbp,1)
    8b83:	0f 85 00 02 00 00    	jne    8d89 <tp_quoted+0x239>
    8b89:	48 ff c5             	inc    %rbp
    8b8c:	49 89 6f 10          	mov    %rbp,0x10(%r15)
    8b90:	0f 57 c0             	xorps  %xmm0,%xmm0
    8b93:	0f 29 04 24          	movaps %xmm0,(%rsp)
    8b97:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    8b9e:	00 00 
    8ba0:	31 db                	xor    %ebx,%ebx
    8ba2:	4c 39 ed             	cmp    %r13,%rbp
    8ba5:	0f 83 8d 01 00 00    	jae    8d38 <tp_quoted+0x1e8>
    8bab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8bb0:	4d 8b 27             	mov    (%r15),%r12
    8bb3:	48 8d 4d 01          	lea    0x1(%rbp),%rcx
    8bb7:	49 89 4f 10          	mov    %rcx,0x10(%r15)
    8bbb:	41 0f b6 04 2c       	movzbl (%r12,%rbp,1),%eax
    8bc0:	83 f8 5c             	cmp    $0x5c,%eax
    8bc3:	74 2b                	je     8bf0 <tp_quoted+0xa0>
    8bc5:	83 f8 22             	cmp    $0x22,%eax
    8bc8:	0f 84 8b 01 00 00    	je     8d59 <tp_quoted+0x209>
    8bce:	0f be f0             	movsbl %al,%esi
    8bd1:	48 89 e7             	mov    %rsp,%rdi
    8bd4:	e8 57 ee ff ff       	call   7a30 <buf_putc>
    8bd9:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    8bdd:	49 8b 6f 10          	mov    0x10(%r15),%rbp
    8be1:	4c 39 ed             	cmp    %r13,%rbp
    8be4:	72 ca                	jb     8bb0 <tp_quoted+0x60>
    8be6:	e9 63 01 00 00       	jmp    8d4e <tp_quoted+0x1fe>
    8beb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8bf0:	4c 39 e9             	cmp    %r13,%rcx
    8bf3:	0f 83 48 01 00 00    	jae    8d41 <tp_quoted+0x1f1>
    8bf9:	48 8d 45 02          	lea    0x2(%rbp),%rax
    8bfd:	49 89 47 10          	mov    %rax,0x10(%r15)
    8c01:	41 0f b6 4c 2c 01    	movzbl 0x1(%r12,%rbp,1),%ecx
    8c07:	8d 51 a4             	lea    -0x5c(%rcx),%edx
    8c0a:	83 fa 19             	cmp    $0x19,%edx
    8c0d:	77 1a                	ja     8c29 <tp_quoted+0xd9>
    8c0f:	48 8d 35 1a 56 00 00 	lea    0x561a(%rip),%rsi        # e230 <_IO_stdin_used+0x230>
    8c16:	48 63 0c 96          	movslq (%rsi,%rdx,4),%rcx
    8c1a:	48 01 f1             	add    %rsi,%rcx
    8c1d:	ff e1                	jmp    *%rcx
    8c1f:	48 89 e7             	mov    %rsp,%rdi
    8c22:	be 5c 00 00 00       	mov    $0x5c,%esi
    8c27:	eb ab                	jmp    8bd4 <tp_quoted+0x84>
    8c29:	83 f9 22             	cmp    $0x22,%ecx
    8c2c:	0f 84 bf 00 00 00    	je     8cf1 <tp_quoted+0x1a1>
    8c32:	83 f9 30             	cmp    $0x30,%ecx
    8c35:	0f 85 06 01 00 00    	jne    8d41 <tp_quoted+0x1f1>
    8c3b:	48 89 e7             	mov    %rsp,%rdi
    8c3e:	31 f6                	xor    %esi,%esi
    8c40:	eb 92                	jmp    8bd4 <tp_quoted+0x84>
    8c42:	48 89 e7             	mov    %rsp,%rdi
    8c45:	be 09 00 00 00       	mov    $0x9,%esi
    8c4a:	eb 88                	jmp    8bd4 <tp_quoted+0x84>
    8c4c:	48 89 e7             	mov    %rsp,%rdi
    8c4f:	be 0d 00 00 00       	mov    $0xd,%esi
    8c54:	e9 7b ff ff ff       	jmp    8bd4 <tp_quoted+0x84>
    8c59:	48 89 e7             	mov    %rsp,%rdi
    8c5c:	be 0a 00 00 00       	mov    $0xa,%esi
    8c61:	e9 6e ff ff ff       	jmp    8bd4 <tp_quoted+0x84>
    8c66:	4c 39 e8             	cmp    %r13,%rax
    8c69:	0f 83 d2 00 00 00    	jae    8d41 <tp_quoted+0x1f1>
    8c6f:	41 80 3c 04 7b       	cmpb   $0x7b,(%r12,%rax,1)
    8c74:	0f 85 c7 00 00 00    	jne    8d41 <tp_quoted+0x1f1>
    8c7a:	48 8d 45 03          	lea    0x3(%rbp),%rax
    8c7e:	49 89 47 10          	mov    %rax,0x10(%r15)
    8c82:	4c 39 e8             	cmp    %r13,%rax
    8c85:	0f 83 b6 00 00 00    	jae    8d41 <tp_quoted+0x1f1>
    8c8b:	e8 70 98 ff ff       	call   2500 <__ctype_b_loc@plt>
    8c90:	48 8b 08             	mov    (%rax),%rcx
    8c93:	48 8d 55 04          	lea    0x4(%rbp),%rdx
    8c97:	49 8d 3c 2c          	lea    (%r12,%rbp,1),%rdi
    8c9b:	48 83 c7 03          	add    $0x3,%rdi
    8c9f:	49 29 ed             	sub    %rbp,%r13
    8ca2:	49 83 c5 fd          	add    $0xfffffffffffffffd,%r13
    8ca6:	31 c0                	xor    %eax,%eax
    8ca8:	31 f6                	xor    %esi,%esi
    8caa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8cb0:	44 0f b6 04 07       	movzbl (%rdi,%rax,1),%r8d
    8cb5:	42 f6 44 41 01 10    	testb  $0x10,0x1(%rcx,%r8,2)
    8cbb:	74 41                	je     8cfe <tp_quoted+0x1ae>
    8cbd:	4c 8d 04 02          	lea    (%rdx,%rax,1),%r8
    8cc1:	4d 89 47 10          	mov    %r8,0x10(%r15)
    8cc5:	44 0f be 04 07       	movsbl (%rdi,%rax,1),%r8d
    8cca:	c1 e6 04             	shl    $0x4,%esi
    8ccd:	45 8d 48 d0          	lea    -0x30(%r8),%r9d
    8cd1:	45 89 c2             	mov    %r8d,%r10d
    8cd4:	41 83 ca 20          	or     $0x20,%r10d
    8cd8:	41 83 c2 a9          	add    $0xffffffa9,%r10d
    8cdc:	41 83 f8 3a          	cmp    $0x3a,%r8d
    8ce0:	45 0f 4c d1          	cmovl  %r9d,%r10d
    8ce4:	44 01 d6             	add    %r10d,%esi
    8ce7:	48 ff c0             	inc    %rax
    8cea:	49 39 c5             	cmp    %rax,%r13
    8ced:	75 c1                	jne    8cb0 <tp_quoted+0x160>
    8cef:	eb 50                	jmp    8d41 <tp_quoted+0x1f1>
    8cf1:	48 89 e7             	mov    %rsp,%rdi
    8cf4:	be 22 00 00 00       	mov    $0x22,%esi
    8cf9:	e9 d6 fe ff ff       	jmp    8bd4 <tp_quoted+0x84>
    8cfe:	85 c0                	test   %eax,%eax
    8d00:	74 3f                	je     8d41 <tp_quoted+0x1f1>
    8d02:	41 80 f8 7d          	cmp    $0x7d,%r8b
    8d06:	75 39                	jne    8d41 <tp_quoted+0x1f1>
    8d08:	81 fe ff ff 10 00    	cmp    $0x10ffff,%esi
    8d0e:	77 31                	ja     8d41 <tp_quoted+0x1f1>
    8d10:	89 f1                	mov    %esi,%ecx
    8d12:	81 e1 00 f8 ff ff    	and    $0xfffff800,%ecx
    8d18:	81 f9 00 d8 00 00    	cmp    $0xd800,%ecx
    8d1e:	74 21                	je     8d41 <tp_quoted+0x1f1>
    8d20:	48 01 e8             	add    %rbp,%rax
    8d23:	48 83 c0 04          	add    $0x4,%rax
    8d27:	49 89 47 10          	mov    %rax,0x10(%r15)
    8d2b:	48 89 e7             	mov    %rsp,%rdi
    8d2e:	e8 5d 0d 00 00       	call   9a90 <fwp_utf8_put>
    8d33:	e9 a1 fe ff ff       	jmp    8bd9 <tp_quoted+0x89>
    8d38:	31 ff                	xor    %edi,%edi
    8d3a:	e8 11 93 ff ff       	call   2050 <free@plt>
    8d3f:	eb 48                	jmp    8d89 <tp_quoted+0x239>
    8d41:	48 8b 3c 24          	mov    (%rsp),%rdi
    8d45:	e8 06 93 ff ff       	call   2050 <free@plt>
    8d4a:	31 db                	xor    %ebx,%ebx
    8d4c:	eb 3b                	jmp    8d89 <tp_quoted+0x239>
    8d4e:	48 8b 3c 24          	mov    (%rsp),%rdi
    8d52:	e8 f9 92 ff ff       	call   2050 <free@plt>
    8d57:	eb 30                	jmp    8d89 <tp_quoted+0x239>
    8d59:	48 8b 1c 24          	mov    (%rsp),%rbx
    8d5d:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    8d62:	48 85 db             	test   %rbx,%rbx
    8d65:	48 8d 3d 34 60 00 00 	lea    0x6034(%rip),%rdi        # eda0 <exec_in_fp0+0x750>
    8d6c:	48 0f 45 fb          	cmovne %rbx,%rdi
    8d70:	e8 1b eb ff ff       	call   7890 <fwp_valid_utf8>
    8d75:	85 c0                	test   %eax,%eax
    8d77:	74 21                	je     8d9a <tp_quoted+0x24a>
    8d79:	48 89 e7             	mov    %rsp,%rdi
    8d7c:	e8 3f ed ff ff       	call   7ac0 <buf_to_str>
    8d81:	49 89 06             	mov    %rax,(%r14)
    8d84:	bb 01 00 00 00       	mov    $0x1,%ebx
    8d89:	89 d8                	mov    %ebx,%eax
    8d8b:	48 83 c4 18          	add    $0x18,%rsp
    8d8f:	5b                   	pop    %rbx
    8d90:	41 5c                	pop    %r12
    8d92:	41 5d                	pop    %r13
    8d94:	41 5e                	pop    %r14
    8d96:	41 5f                	pop    %r15
    8d98:	5d                   	pop    %rbp
    8d99:	c3                   	ret
    8d9a:	48 89 df             	mov    %rbx,%rdi
    8d9d:	eb a6                	jmp    8d45 <tp_quoted+0x1f5>
    8d9f:	90                   	nop

0000000000008da0 <tp_eat>:
    8da0:	55                   	push   %rbp
    8da1:	41 57                	push   %r15
    8da3:	41 56                	push   %r14
    8da5:	53                   	push   %rbx
    8da6:	50                   	push   %rax
    8da7:	49 89 f6             	mov    %rsi,%r14
    8daa:	48 89 fb             	mov    %rdi,%rbx
    8dad:	e8 2e fc ff ff       	call   89e0 <tp_ws>
    8db2:	4c 89 f7             	mov    %r14,%rdi
    8db5:	e8 b6 93 ff ff       	call   2170 <strlen@plt>
    8dba:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    8dbe:	4c 8b 7b 10          	mov    0x10(%rbx),%r15
    8dc2:	4c 29 f9             	sub    %r15,%rcx
    8dc5:	31 ed                	xor    %ebp,%ebp
    8dc7:	48 39 c1             	cmp    %rax,%rcx
    8dca:	72 24                	jb     8df0 <tp_eat+0x50>
    8dcc:	48 8b 3b             	mov    (%rbx),%rdi
    8dcf:	4c 01 ff             	add    %r15,%rdi
    8dd2:	4c 89 f6             	mov    %r14,%rsi
    8dd5:	49 89 c6             	mov    %rax,%r14
    8dd8:	48 89 c2             	mov    %rax,%rdx
    8ddb:	e8 90 95 ff ff       	call   2370 <bcmp@plt>
    8de0:	85 c0                	test   %eax,%eax
    8de2:	75 0c                	jne    8df0 <tp_eat+0x50>
    8de4:	4d 01 f7             	add    %r14,%r15
    8de7:	4c 89 7b 10          	mov    %r15,0x10(%rbx)
    8deb:	bd 01 00 00 00       	mov    $0x1,%ebp
    8df0:	89 e8                	mov    %ebp,%eax
    8df2:	48 83 c4 08          	add    $0x8,%rsp
    8df6:	5b                   	pop    %rbx
    8df7:	41 5e                	pop    %r14
    8df9:	41 5f                	pop    %r15
    8dfb:	5d                   	pop    %rbp
    8dfc:	c3                   	ret
    8dfd:	0f 1f 00             	nopl   (%rax)

0000000000008e00 <tp_list_of>:
    8e00:	55                   	push   %rbp
    8e01:	41 57                	push   %r15
    8e03:	41 56                	push   %r14
    8e05:	41 55                	push   %r13
    8e07:	41 54                	push   %r12
    8e09:	53                   	push   %rbx
    8e0a:	50                   	push   %rax
    8e0b:	4d 89 c6             	mov    %r8,%r14
    8e0e:	49 89 cf             	mov    %rcx,%r15
    8e11:	49 89 d4             	mov    %rdx,%r12
    8e14:	49 89 fd             	mov    %rdi,%r13
    8e17:	e8 84 ff ff ff       	call   8da0 <tp_eat>
    8e1c:	31 db                	xor    %ebx,%ebx
    8e1e:	85 c0                	test   %eax,%eax
    8e20:	74 14                	je     8e36 <tp_list_of+0x36>
    8e22:	4c 89 ef             	mov    %r13,%rdi
    8e25:	4c 89 e6             	mov    %r12,%rsi
    8e28:	e8 73 ff ff ff       	call   8da0 <tp_eat>
    8e2d:	85 c0                	test   %eax,%eax
    8e2f:	74 16                	je     8e47 <tp_list_of+0x47>
    8e31:	bb 01 00 00 00       	mov    $0x1,%ebx
    8e36:	89 d8                	mov    %ebx,%eax
    8e38:	48 83 c4 08          	add    $0x8,%rsp
    8e3c:	5b                   	pop    %rbx
    8e3d:	41 5c                	pop    %r12
    8e3f:	41 5d                	pop    %r13
    8e41:	41 5e                	pop    %r14
    8e43:	41 5f                	pop    %r15
    8e45:	5d                   	pop    %rbp
    8e46:	c3                   	ret
    8e47:	48 8d 2d 4f 64 00 00 	lea    0x644f(%rip),%rbp        # f29d <exec_in_fp0+0xc4d>
    8e4e:	66 90                	xchg   %ax,%ax
    8e50:	4c 89 ef             	mov    %r13,%rdi
    8e53:	4c 89 f6             	mov    %r14,%rsi
    8e56:	41 ff d7             	call   *%r15
    8e59:	85 c0                	test   %eax,%eax
    8e5b:	74 d9                	je     8e36 <tp_list_of+0x36>
    8e5d:	4c 89 ef             	mov    %r13,%rdi
    8e60:	4c 89 e6             	mov    %r12,%rsi
    8e63:	e8 38 ff ff ff       	call   8da0 <tp_eat>
    8e68:	85 c0                	test   %eax,%eax
    8e6a:	75 c5                	jne    8e31 <tp_list_of+0x31>
    8e6c:	4c 89 ef             	mov    %r13,%rdi
    8e6f:	48 89 ee             	mov    %rbp,%rsi
    8e72:	e8 29 ff ff ff       	call   8da0 <tp_eat>
    8e77:	85 c0                	test   %eax,%eax
    8e79:	75 d5                	jne    8e50 <tp_list_of+0x50>
    8e7b:	eb b9                	jmp    8e36 <tp_list_of+0x36>
    8e7d:	0f 1f 00             	nopl   (%rax)

0000000000008e80 <tp_byte_item>:
    8e80:	53                   	push   %rbx
    8e81:	48 83 ec 10          	sub    $0x10,%rsp
    8e85:	48 89 f3             	mov    %rsi,%rbx
    8e88:	48 8d 35 41 ae 00 00 	lea    0xae41(%rip),%rsi        # 13cd0 <tp_byte_item.u8d>
    8e8f:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    8e94:	e8 97 fb ff ff       	call   8a30 <tp_int>
    8e99:	85 c0                	test   %eax,%eax
    8e9b:	74 14                	je     8eb1 <tp_byte_item+0x31>
    8e9d:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    8ea2:	48 89 df             	mov    %rbx,%rdi
    8ea5:	e8 96 0c 00 00       	call   9b40 <tp_push>
    8eaa:	b8 01 00 00 00       	mov    $0x1,%eax
    8eaf:	eb 02                	jmp    8eb3 <tp_byte_item+0x33>
    8eb1:	31 c0                	xor    %eax,%eax
    8eb3:	48 83 c4 10          	add    $0x10,%rsp
    8eb7:	5b                   	pop    %rbx
    8eb8:	c3                   	ret
    8eb9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000008ec0 <tp_token>:
    8ec0:	55                   	push   %rbp
    8ec1:	41 57                	push   %r15
    8ec3:	41 56                	push   %r14
    8ec5:	41 55                	push   %r13
    8ec7:	41 54                	push   %r12
    8ec9:	53                   	push   %rbx
    8eca:	50                   	push   %rax
    8ecb:	49 89 d7             	mov    %rdx,%r15
    8ece:	48 89 34 24          	mov    %rsi,(%rsp)
    8ed2:	48 89 fb             	mov    %rdi,%rbx
    8ed5:	e8 06 fb ff ff       	call   89e0 <tp_ws>
    8eda:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    8ede:	4c 8b 23             	mov    (%rbx),%r12
    8ee1:	4c 8b 6b 08          	mov    0x8(%rbx),%r13
    8ee5:	4c 89 f5             	mov    %r14,%rbp
    8ee8:	4d 39 ee             	cmp    %r13,%r14
    8eeb:	73 20                	jae    8f0d <tp_token+0x4d>
    8eed:	4c 89 f5             	mov    %r14,%rbp
    8ef0:	41 0f be 3c 2c       	movsbl (%r12,%rbp,1),%edi
    8ef5:	e8 a6 0c 00 00       	call   9ba0 <tp_is_delim>
    8efa:	85 c0                	test   %eax,%eax
    8efc:	75 0f                	jne    8f0d <tp_token+0x4d>
    8efe:	48 ff c5             	inc    %rbp
    8f01:	48 89 6b 10          	mov    %rbp,0x10(%rbx)
    8f05:	49 39 ed             	cmp    %rbp,%r13
    8f08:	75 e6                	jne    8ef0 <tp_token+0x30>
    8f0a:	4c 89 ed             	mov    %r13,%rbp
    8f0d:	4c 29 f5             	sub    %r14,%rbp
    8f10:	4d 8d 6f ff          	lea    -0x1(%r15),%r13
    8f14:	4c 39 fd             	cmp    %r15,%rbp
    8f17:	4c 0f 42 ed          	cmovb  %rbp,%r13
    8f1b:	4d 01 f4             	add    %r14,%r12
    8f1e:	4c 8b 3c 24          	mov    (%rsp),%r15
    8f22:	4c 89 ff             	mov    %r15,%rdi
    8f25:	4c 89 e6             	mov    %r12,%rsi
    8f28:	4c 89 ea             	mov    %r13,%rdx
    8f2b:	e8 00 94 ff ff       	call   2330 <memcpy@plt>
    8f30:	43 c6 04 2f 00       	movb   $0x0,(%r15,%r13,1)
    8f35:	48 8b 43 10          	mov    0x10(%rbx),%rax
    8f39:	4c 29 f0             	sub    %r14,%rax
    8f3c:	48 83 c4 08          	add    $0x8,%rsp
    8f40:	5b                   	pop    %rbx
    8f41:	41 5c                	pop    %r12
    8f43:	41 5d                	pop    %r13
    8f45:	41 5e                	pop    %r14
    8f47:	41 5f                	pop    %r15
    8f49:	5d                   	pop    %rbp
    8f4a:	c3                   	ret
    8f4b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000008f50 <tp_elem_item>:
    8f50:	55                   	push   %rbp
    8f51:	53                   	push   %rbx
    8f52:	50                   	push   %rax
    8f53:	48 89 f3             	mov    %rsi,%rbx
    8f56:	48 8b 36             	mov    (%rsi),%rsi
    8f59:	31 ed                	xor    %ebp,%ebp
    8f5b:	48 89 e1             	mov    %rsp,%rcx
    8f5e:	31 d2                	xor    %edx,%edx
    8f60:	e8 4b f1 ff ff       	call   80b0 <tp_value>
    8f65:	85 c0                	test   %eax,%eax
    8f67:	74 11                	je     8f7a <tp_elem_item+0x2a>
    8f69:	48 8b 34 24          	mov    (%rsp),%rsi
    8f6d:	48 89 df             	mov    %rbx,%rdi
    8f70:	e8 cb 0b 00 00       	call   9b40 <tp_push>
    8f75:	bd 01 00 00 00       	mov    $0x1,%ebp
    8f7a:	89 e8                	mov    %ebp,%eax
    8f7c:	48 83 c4 08          	add    $0x8,%rsp
    8f80:	5b                   	pop    %rbx
    8f81:	5d                   	pop    %rbp
    8f82:	c3                   	ret
    8f83:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8f8a:	84 00 00 00 00 00 

0000000000008f90 <fwp_p_array_from_list>:
    8f90:	41 56                	push   %r14
    8f92:	53                   	push   %rbx
    8f93:	50                   	push   %rax
    8f94:	48 89 fb             	mov    %rdi,%rbx
    8f97:	e8 44 0c 00 00       	call   9be0 <fwp_list_len>
    8f9c:	49 89 c6             	mov    %rax,%r14
    8f9f:	48 89 c7             	mov    %rax,%rdi
    8fa2:	e8 39 c7 ff ff       	call   56e0 <fwp_arr_new>
    8fa7:	4d 85 f6             	test   %r14,%r14
    8faa:	0f 84 84 00 00 00    	je     9034 <fwp_p_array_from_list+0xa4>
    8fb0:	44 89 f1             	mov    %r14d,%ecx
    8fb3:	83 e1 03             	and    $0x3,%ecx
    8fb6:	49 83 fe 04          	cmp    $0x4,%r14
    8fba:	73 04                	jae    8fc0 <fwp_p_array_from_list+0x30>
    8fbc:	31 d2                	xor    %edx,%edx
    8fbe:	eb 4d                	jmp    900d <fwp_p_array_from_list+0x7d>
    8fc0:	49 83 e6 fc          	and    $0xfffffffffffffffc,%r14
    8fc4:	31 d2                	xor    %edx,%edx
    8fc6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    8fcd:	00 00 00 
    8fd0:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    8fd4:	48 89 74 d0 08       	mov    %rsi,0x8(%rax,%rdx,8)
    8fd9:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    8fdd:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
    8fe1:	48 89 7c d0 10       	mov    %rdi,0x10(%rax,%rdx,8)
    8fe6:	48 8b 76 10          	mov    0x10(%rsi),%rsi
    8fea:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
    8fee:	48 89 7c d0 18       	mov    %rdi,0x18(%rax,%rdx,8)
    8ff3:	48 8b 76 10          	mov    0x10(%rsi),%rsi
    8ff7:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
    8ffb:	48 89 7c d0 20       	mov    %rdi,0x20(%rax,%rdx,8)
    9000:	48 8b 5e 10          	mov    0x10(%rsi),%rbx
    9004:	48 83 c2 04          	add    $0x4,%rdx
    9008:	49 39 d6             	cmp    %rdx,%r14
    900b:	75 c3                	jne    8fd0 <fwp_p_array_from_list+0x40>
    900d:	48 85 c9             	test   %rcx,%rcx
    9010:	74 22                	je     9034 <fwp_p_array_from_list+0xa4>
    9012:	48 8d 14 d0          	lea    (%rax,%rdx,8),%rdx
    9016:	48 83 c2 08          	add    $0x8,%rdx
    901a:	31 f6                	xor    %esi,%esi
    901c:	0f 1f 40 00          	nopl   0x0(%rax)
    9020:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    9024:	48 89 3c f2          	mov    %rdi,(%rdx,%rsi,8)
    9028:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    902c:	48 ff c6             	inc    %rsi
    902f:	48 39 f1             	cmp    %rsi,%rcx
    9032:	75 ec                	jne    9020 <fwp_p_array_from_list+0x90>
    9034:	48 83 c4 08          	add    $0x8,%rsp
    9038:	5b                   	pop    %rbx
    9039:	41 5e                	pop    %r14
    903b:	c3                   	ret
    903c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000009040 <tp_kv_item>:
    9040:	41 57                	push   %r15
    9042:	41 56                	push   %r14
    9044:	53                   	push   %rbx
    9045:	48 83 ec 10          	sub    $0x10,%rsp
    9049:	48 89 f3             	mov    %rsi,%rbx
    904c:	49 89 ff             	mov    %rdi,%r15
    904f:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
    9056:	00 
    9057:	48 8b 36             	mov    (%rsi),%rsi
    905a:	45 31 f6             	xor    %r14d,%r14d
    905d:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    9062:	31 d2                	xor    %edx,%edx
    9064:	e8 47 f0 ff ff       	call   80b0 <tp_value>
    9069:	85 c0                	test   %eax,%eax
    906b:	74 27                	je     9094 <tp_kv_item+0x54>
    906d:	45 31 f6             	xor    %r14d,%r14d
    9070:	83 7b 28 00          	cmpl   $0x0,0x28(%rbx)
    9074:	74 2b                	je     90a1 <tp_kv_item+0x61>
    9076:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    907b:	48 89 df             	mov    %rbx,%rdi
    907e:	e8 bd 0a 00 00       	call   9b40 <tp_push>
    9083:	48 89 df             	mov    %rbx,%rdi
    9086:	4c 89 f6             	mov    %r14,%rsi
    9089:	e8 b2 0a 00 00       	call   9b40 <tp_push>
    908e:	41 be 01 00 00 00    	mov    $0x1,%r14d
    9094:	44 89 f0             	mov    %r14d,%eax
    9097:	48 83 c4 10          	add    $0x10,%rsp
    909b:	5b                   	pop    %rbx
    909c:	41 5e                	pop    %r14
    909e:	41 5f                	pop    %r15
    90a0:	c3                   	ret
    90a1:	48 8d 35 09 62 00 00 	lea    0x6209(%rip),%rsi        # f2b1 <exec_in_fp0+0xc61>
    90a8:	4c 89 ff             	mov    %r15,%rdi
    90ab:	e8 f0 fc ff ff       	call   8da0 <tp_eat>
    90b0:	85 c0                	test   %eax,%eax
    90b2:	74 e0                	je     9094 <tp_kv_item+0x54>
    90b4:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    90b8:	45 31 f6             	xor    %r14d,%r14d
    90bb:	48 89 e1             	mov    %rsp,%rcx
    90be:	4c 89 ff             	mov    %r15,%rdi
    90c1:	31 d2                	xor    %edx,%edx
    90c3:	e8 e8 ef ff ff       	call   80b0 <tp_value>
    90c8:	85 c0                	test   %eax,%eax
    90ca:	74 c8                	je     9094 <tp_kv_item+0x54>
    90cc:	4c 8b 34 24          	mov    (%rsp),%r14
    90d0:	eb a4                	jmp    9076 <tp_kv_item+0x36>
    90d2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    90d9:	1f 84 00 00 00 00 00 

00000000000090e0 <fwp_p_map_insert>:
    90e0:	55                   	push   %rbp
    90e1:	41 57                	push   %r15
    90e3:	41 56                	push   %r14
    90e5:	41 55                	push   %r13
    90e7:	41 54                	push   %r12
    90e9:	53                   	push   %rbx
    90ea:	48 83 ec 18          	sub    $0x18,%rsp
    90ee:	49 89 d6             	mov    %rdx,%r14
    90f1:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    90f6:	48 89 fe             	mov    %rdi,%rsi
    90f9:	48 8d 44 24 04       	lea    0x4(%rsp),%rax
    90fe:	48 89 d7             	mov    %rdx,%rdi
    9101:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
    9106:	48 89 ca             	mov    %rcx,%rdx
    9109:	48 89 c1             	mov    %rax,%rcx
    910c:	e8 ef 0a 00 00       	call   9c00 <fwp_map_find>
    9111:	48 89 c5             	mov    %rax,%rbp
    9114:	4d 8b 3e             	mov    (%r14),%r15
    9117:	44 8b 64 24 04       	mov    0x4(%rsp),%r12d
    911c:	31 ff                	xor    %edi,%edi
    911e:	45 85 e4             	test   %r12d,%r12d
    9121:	40 0f 94 c7          	sete   %dil
    9125:	4c 01 ff             	add    %r15,%rdi
    9128:	e8 23 0c 00 00       	call   9d50 <fwp_map_alloc>
    912d:	49 89 c5             	mov    %rax,%r13
    9130:	48 8d 58 08          	lea    0x8(%rax),%rbx
    9134:	49 83 c6 08          	add    $0x8,%r14
    9138:	45 85 e4             	test   %r12d,%r12d
    913b:	74 22                	je     915f <fwp_p_map_insert+0x7f>
    913d:	49 c1 e7 04          	shl    $0x4,%r15
    9141:	48 89 df             	mov    %rbx,%rdi
    9144:	4c 89 f6             	mov    %r14,%rsi
    9147:	4c 89 fa             	mov    %r15,%rdx
    914a:	e8 e1 91 ff ff       	call   2330 <memcpy@plt>
    914f:	48 c1 e5 04          	shl    $0x4,%rbp
    9153:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    9158:	49 89 44 2d 10       	mov    %rax,0x10(%r13,%rbp,1)
    915d:	eb 46                	jmp    91a5 <fwp_p_map_insert+0xc5>
    915f:	49 89 ec             	mov    %rbp,%r12
    9162:	49 c1 e4 04          	shl    $0x4,%r12
    9166:	48 89 df             	mov    %rbx,%rdi
    9169:	4c 89 f6             	mov    %r14,%rsi
    916c:	4c 89 e2             	mov    %r12,%rdx
    916f:	e8 bc 91 ff ff       	call   2330 <memcpy@plt>
    9174:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    9179:	4b 89 44 25 08       	mov    %rax,0x8(%r13,%r12,1)
    917e:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    9183:	4b 89 44 25 10       	mov    %rax,0x10(%r13,%r12,1)
    9188:	4a 8d 3c 23          	lea    (%rbx,%r12,1),%rdi
    918c:	48 83 c7 10          	add    $0x10,%rdi
    9190:	4d 01 f4             	add    %r14,%r12
    9193:	49 29 ef             	sub    %rbp,%r15
    9196:	49 c1 e7 04          	shl    $0x4,%r15
    919a:	4c 89 e6             	mov    %r12,%rsi
    919d:	4c 89 fa             	mov    %r15,%rdx
    91a0:	e8 8b 91 ff ff       	call   2330 <memcpy@plt>
    91a5:	4c 89 e8             	mov    %r13,%rax
    91a8:	48 83 c4 18          	add    $0x18,%rsp
    91ac:	5b                   	pop    %rbx
    91ad:	41 5c                	pop    %r12
    91af:	41 5d                	pop    %r13
    91b1:	41 5e                	pop    %r14
    91b3:	41 5f                	pop    %r15
    91b5:	5d                   	pop    %rbp
    91b6:	c3                   	ret
    91b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    91be:	00 00 

00000000000091c0 <fwp_valid_int>:
    91c0:	31 c0                	xor    %eax,%eax
    91c2:	48 85 f6             	test   %rsi,%rsi
    91c5:	74 32                	je     91f9 <fwp_valid_int+0x39>
    91c7:	0f b6 17             	movzbl (%rdi),%edx
    91ca:	80 c2 d5             	add    $0xd5,%dl
    91cd:	31 c9                	xor    %ecx,%ecx
    91cf:	f6 c2 fd             	test   $0xfd,%dl
    91d2:	0f 94 c1             	sete   %cl
    91d5:	48 39 f1             	cmp    %rsi,%rcx
    91d8:	74 1f                	je     91f9 <fwp_valid_int+0x39>
    91da:	73 18                	jae    91f4 <fwp_valid_int+0x34>
    91dc:	0f 1f 40 00          	nopl   0x0(%rax)
    91e0:	0f b6 14 0f          	movzbl (%rdi,%rcx,1),%edx
    91e4:	80 c2 c6             	add    $0xc6,%dl
    91e7:	80 fa f5             	cmp    $0xf5,%dl
    91ea:	76 0d                	jbe    91f9 <fwp_valid_int+0x39>
    91ec:	48 ff c1             	inc    %rcx
    91ef:	48 39 ce             	cmp    %rcx,%rsi
    91f2:	75 ec                	jne    91e0 <fwp_valid_int+0x20>
    91f4:	b8 01 00 00 00       	mov    $0x1,%eax
    91f9:	c3                   	ret
    91fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000009200 <tp_record_body>:
    9200:	55                   	push   %rbp
    9201:	41 57                	push   %r15
    9203:	41 56                	push   %r14
    9205:	41 55                	push   %r13
    9207:	41 54                	push   %r12
    9209:	53                   	push   %rbx
    920a:	48 81 ec 28 01 00 00 	sub    $0x128,%rsp
    9211:	48 89 d3             	mov    %rdx,%rbx
    9214:	49 89 f5             	mov    %rsi,%r13
    9217:	48 89 fd             	mov    %rdi,%rbp
    921a:	48 63 46 10          	movslq 0x10(%rsi),%rax
    921e:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    9225:	00 
    9226:	e8 f5 c4 ff ff       	call   5720 <fwp_alloc>
    922b:	49 89 c7             	mov    %rax,%r15
    922e:	49 63 7d 10          	movslq 0x10(%r13),%rdi
    9232:	48 ff c7             	inc    %rdi
    9235:	e8 f6 d5 ff ff       	call   6830 <fwp_alloc_leaf>
    923a:	49 89 c4             	mov    %rax,%r12
    923d:	49 63 55 10          	movslq 0x10(%r13),%rdx
    9241:	48 ff c2             	inc    %rdx
    9244:	45 31 f6             	xor    %r14d,%r14d
    9247:	48 89 c7             	mov    %rax,%rdi
    924a:	31 f6                	xor    %esi,%esi
    924c:	e8 bf 8f ff ff       	call   2210 <memset@plt>
    9251:	48 8d 35 05 61 00 00 	lea    0x6105(%rip),%rsi        # f35d <exec_in_fp0+0xd0d>
    9258:	48 89 ef             	mov    %rbp,%rdi
    925b:	e8 40 fb ff ff       	call   8da0 <tp_eat>
    9260:	85 c0                	test   %eax,%eax
    9262:	0f 84 3b 01 00 00    	je     93a3 <tp_record_body+0x1a3>
    9268:	48 8d 35 22 61 00 00 	lea    0x6122(%rip),%rsi        # f391 <exec_in_fp0+0xd41>
    926f:	48 89 ef             	mov    %rbp,%rdi
    9272:	e8 29 fb ff ff       	call   8da0 <tp_eat>
    9277:	85 c0                	test   %eax,%eax
    9279:	74 3e                	je     92b9 <tp_record_body+0xb9>
    927b:	41 8b 7d 10          	mov    0x10(%r13),%edi
    927f:	85 ff                	test   %edi,%edi
    9281:	7e 20                	jle    92a3 <tp_record_body+0xa3>
    9283:	45 31 f6             	xor    %r14d,%r14d
    9286:	31 c0                	xor    %eax,%eax
    9288:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    928f:	00 
    9290:	41 80 3c 04 00       	cmpb   $0x0,(%r12,%rax,1)
    9295:	0f 84 08 01 00 00    	je     93a3 <tp_record_body+0x1a3>
    929b:	48 ff c0             	inc    %rax
    929e:	48 39 c7             	cmp    %rax,%rdi
    92a1:	75 ed                	jne    9290 <tp_record_body+0x90>
    92a3:	4c 89 fe             	mov    %r15,%rsi
    92a6:	e8 55 9e ff ff       	call   3100 <fwp_record>
    92ab:	48 89 03             	mov    %rax,(%rbx)
    92ae:	41 be 01 00 00 00    	mov    $0x1,%r14d
    92b4:	e9 ea 00 00 00       	jmp    93a3 <tp_record_body+0x1a3>
    92b9:	48 89 1c 24          	mov    %rbx,(%rsp)
    92bd:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    92c2:	48 89 ef             	mov    %rbp,%rdi
    92c5:	e8 06 01 00 00       	call   93d0 <tp_ident>
    92ca:	41 8b 45 10          	mov    0x10(%r13),%eax
    92ce:	85 c0                	test   %eax,%eax
    92d0:	0f 8e ca 00 00 00    	jle    93a0 <tp_record_body+0x1a0>
    92d6:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    92db:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    92e0:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
    92e5:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    92ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    92f0:	4d 8b 65 18          	mov    0x18(%r13),%r12
    92f4:	41 89 c7             	mov    %eax,%r15d
    92f7:	41 be ff ff ff ff    	mov    $0xffffffff,%r14d
    92fd:	31 ed                	xor    %ebp,%ebp
    92ff:	90                   	nop
    9300:	49 8b 3c ec          	mov    (%r12,%rbp,8),%rdi
    9304:	48 89 de             	mov    %rbx,%rsi
    9307:	e8 c4 8f ff ff       	call   22d0 <strcmp@plt>
    930c:	85 c0                	test   %eax,%eax
    930e:	44 0f 44 f5          	cmove  %ebp,%r14d
    9312:	48 ff c5             	inc    %rbp
    9315:	49 39 ef             	cmp    %rbp,%r15
    9318:	75 e6                	jne    9300 <tp_record_body+0x100>
    931a:	45 85 f6             	test   %r14d,%r14d
    931d:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    9322:	4c 8b 64 24 10       	mov    0x10(%rsp),%r12
    9327:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    932c:	78 72                	js     93a0 <tp_record_body+0x1a0>
    932e:	48 89 ef             	mov    %rbp,%rdi
    9331:	48 8d 35 7b 5f 00 00 	lea    0x5f7b(%rip),%rsi        # f2b3 <exec_in_fp0+0xc63>
    9338:	e8 63 fa ff ff       	call   8da0 <tp_eat>
    933d:	85 c0                	test   %eax,%eax
    933f:	74 5f                	je     93a0 <tp_record_body+0x1a0>
    9341:	49 8b 45 20          	mov    0x20(%r13),%rax
    9345:	45 89 f6             	mov    %r14d,%r14d
    9348:	4a 8b 34 f0          	mov    (%rax,%r14,8),%rsi
    934c:	4b 8d 0c f7          	lea    (%r15,%r14,8),%rcx
    9350:	48 89 ef             	mov    %rbp,%rdi
    9353:	31 d2                	xor    %edx,%edx
    9355:	e8 56 ed ff ff       	call   80b0 <tp_value>
    935a:	85 c0                	test   %eax,%eax
    935c:	74 42                	je     93a0 <tp_record_body+0x1a0>
    935e:	43 c6 04 34 01       	movb   $0x1,(%r12,%r14,1)
    9363:	48 89 ef             	mov    %rbp,%rdi
    9366:	48 8d 35 24 60 00 00 	lea    0x6024(%rip),%rsi        # f391 <exec_in_fp0+0xd41>
    936d:	e8 2e fa ff ff       	call   8da0 <tp_eat>
    9372:	85 c0                	test   %eax,%eax
    9374:	75 42                	jne    93b8 <tp_record_body+0x1b8>
    9376:	48 89 ef             	mov    %rbp,%rdi
    9379:	48 8d 35 1d 5f 00 00 	lea    0x5f1d(%rip),%rsi        # f29d <exec_in_fp0+0xc4d>
    9380:	e8 1b fa ff ff       	call   8da0 <tp_eat>
    9385:	85 c0                	test   %eax,%eax
    9387:	74 17                	je     93a0 <tp_record_body+0x1a0>
    9389:	48 89 ef             	mov    %rbp,%rdi
    938c:	48 89 de             	mov    %rbx,%rsi
    938f:	e8 3c 00 00 00       	call   93d0 <tp_ident>
    9394:	41 8b 45 10          	mov    0x10(%r13),%eax
    9398:	85 c0                	test   %eax,%eax
    939a:	0f 8f 50 ff ff ff    	jg     92f0 <tp_record_body+0xf0>
    93a0:	45 31 f6             	xor    %r14d,%r14d
    93a3:	44 89 f0             	mov    %r14d,%eax
    93a6:	48 81 c4 28 01 00 00 	add    $0x128,%rsp
    93ad:	5b                   	pop    %rbx
    93ae:	41 5c                	pop    %r12
    93b0:	41 5d                	pop    %r13
    93b2:	41 5e                	pop    %r14
    93b4:	41 5f                	pop    %r15
    93b6:	5d                   	pop    %rbp
    93b7:	c3                   	ret
    93b8:	48 8b 1c 24          	mov    (%rsp),%rbx
    93bc:	e9 ba fe ff ff       	jmp    927b <tp_record_body+0x7b>
    93c1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    93c8:	0f 1f 84 00 00 00 00 
    93cf:	00 

00000000000093d0 <tp_ident>:
    93d0:	41 56                	push   %r14
    93d2:	53                   	push   %rbx
    93d3:	50                   	push   %rax
    93d4:	48 89 f3             	mov    %rsi,%rbx
    93d7:	49 89 fe             	mov    %rdi,%r14
    93da:	e8 01 f6 ff ff       	call   89e0 <tp_ws>
    93df:	49 8b 46 10          	mov    0x10(%r14),%rax
    93e3:	49 8b 36             	mov    (%r14),%rsi
    93e6:	49 8b 56 08          	mov    0x8(%r14),%rdx
    93ea:	48 89 c1             	mov    %rax,%rcx
    93ed:	48 39 d0             	cmp    %rdx,%rax
    93f0:	73 63                	jae    9455 <tp_ident+0x85>
    93f2:	48 bf 03 00 00 00 00 	movabs $0x4000000000003,%rdi
    93f9:	00 04 00 
    93fc:	48 89 c1             	mov    %rax,%rcx
    93ff:	eb 1b                	jmp    941c <tp_ident+0x4c>
    9401:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9408:	0f 1f 84 00 00 00 00 
    940f:	00 
    9410:	48 ff c1             	inc    %rcx
    9413:	49 89 4e 10          	mov    %rcx,0x10(%r14)
    9417:	48 39 ca             	cmp    %rcx,%rdx
    941a:	74 36                	je     9452 <tp_ident+0x82>
    941c:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
    9421:	45 8d 48 d0          	lea    -0x30(%r8),%r9d
    9425:	41 80 f9 0a          	cmp    $0xa,%r9b
    9429:	72 e5                	jb     9410 <tp_ident+0x40>
    942b:	45 89 c1             	mov    %r8d,%r9d
    942e:	41 80 e1 df          	and    $0xdf,%r9b
    9432:	41 80 c1 bf          	add    $0xbf,%r9b
    9436:	41 80 f9 1a          	cmp    $0x1a,%r9b
    943a:	72 d4                	jb     9410 <tp_ident+0x40>
    943c:	45 0f b6 c0          	movzbl %r8b,%r8d
    9440:	41 83 c0 d3          	add    $0xffffffd3,%r8d
    9444:	41 83 f8 32          	cmp    $0x32,%r8d
    9448:	77 0b                	ja     9455 <tp_ident+0x85>
    944a:	4c 0f a3 c7          	bt     %r8,%rdi
    944e:	72 c0                	jb     9410 <tp_ident+0x40>
    9450:	eb 03                	jmp    9455 <tp_ident+0x85>
    9452:	48 89 d1             	mov    %rdx,%rcx
    9455:	48 29 c1             	sub    %rax,%rcx
    9458:	48 81 f9 ff 00 00 00 	cmp    $0xff,%rcx
    945f:	41 be ff 00 00 00    	mov    $0xff,%r14d
    9465:	4c 0f 42 f1          	cmovb  %rcx,%r14
    9469:	48 01 c6             	add    %rax,%rsi
    946c:	48 89 df             	mov    %rbx,%rdi
    946f:	4c 89 f2             	mov    %r14,%rdx
    9472:	e8 b9 8e ff ff       	call   2330 <memcpy@plt>
    9477:	42 c6 04 33 00       	movb   $0x0,(%rbx,%r14,1)
    947c:	48 83 c4 08          	add    $0x8,%rsp
    9480:	5b                   	pop    %rbx
    9481:	41 5e                	pop    %r14
    9483:	c3                   	ret
    9484:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    948b:	00 00 00 00 00 

0000000000009490 <tp_atom>:
    9490:	41 57                	push   %r15
    9492:	41 56                	push   %r14
    9494:	53                   	push   %rbx
    9495:	49 89 d6             	mov    %rdx,%r14
    9498:	49 89 f7             	mov    %rsi,%r15
    949b:	48 89 fb             	mov    %rdi,%rbx
    949e:	e8 3d f5 ff ff       	call   89e0 <tp_ws>
    94a3:	41 83 3f 10          	cmpl   $0x10,(%r15)
    94a7:	75 07                	jne    94b0 <tp_atom+0x20>
    94a9:	49 83 7f 08 00       	cmpq   $0x0,0x8(%r15)
    94ae:	74 5e                	je     950e <tp_atom+0x7e>
    94b0:	31 c0                	xor    %eax,%eax
    94b2:	48 8b 4b 10          	mov    0x10(%rbx),%rcx
    94b6:	48 3b 4b 08          	cmp    0x8(%rbx),%rcx
    94ba:	73 0e                	jae    94ca <tp_atom+0x3a>
    94bc:	48 8b 13             	mov    (%rbx),%rdx
    94bf:	80 3c 0a 28          	cmpb   $0x28,(%rdx,%rcx,1)
    94c3:	0f 95 c2             	setne  %dl
    94c6:	08 c2                	or     %al,%dl
    94c8:	74 15                	je     94df <tp_atom+0x4f>
    94ca:	48 89 df             	mov    %rbx,%rdi
    94cd:	4c 89 fe             	mov    %r15,%rsi
    94d0:	31 d2                	xor    %edx,%edx
    94d2:	4c 89 f1             	mov    %r14,%rcx
    94d5:	5b                   	pop    %rbx
    94d6:	41 5e                	pop    %r14
    94d8:	41 5f                	pop    %r15
    94da:	e9 d1 eb ff ff       	jmp    80b0 <tp_value>
    94df:	48 ff c1             	inc    %rcx
    94e2:	48 89 4b 10          	mov    %rcx,0x10(%rbx)
    94e6:	48 89 df             	mov    %rbx,%rdi
    94e9:	4c 89 fe             	mov    %r15,%rsi
    94ec:	31 d2                	xor    %edx,%edx
    94ee:	4c 89 f1             	mov    %r14,%rcx
    94f1:	e8 ba eb ff ff       	call   80b0 <tp_value>
    94f6:	85 c0                	test   %eax,%eax
    94f8:	74 25                	je     951f <tp_atom+0x8f>
    94fa:	48 8d 35 5f 5e 00 00 	lea    0x5e5f(%rip),%rsi        # f360 <exec_in_fp0+0xd10>
    9501:	48 89 df             	mov    %rbx,%rdi
    9504:	5b                   	pop    %rbx
    9505:	41 5e                	pop    %r14
    9507:	41 5f                	pop    %r15
    9509:	e9 92 f8 ff ff       	jmp    8da0 <tp_eat>
    950e:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    9513:	74 12                	je     9527 <tp_atom+0x97>
    9515:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
    951a:	0f 95 c0             	setne  %al
    951d:	eb 93                	jmp    94b2 <tp_atom+0x22>
    951f:	31 c0                	xor    %eax,%eax
    9521:	5b                   	pop    %rbx
    9522:	41 5e                	pop    %r14
    9524:	41 5f                	pop    %r15
    9526:	c3                   	ret
    9527:	b0 01                	mov    $0x1,%al
    9529:	eb 87                	jmp    94b2 <tp_atom+0x22>
    952b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000009530 <fwp_cstr>:
    9530:	53                   	push   %rbx
    9531:	48 89 fb             	mov    %rdi,%rbx
    9534:	e8 37 8c ff ff       	call   2170 <strlen@plt>
    9539:	48 89 df             	mov    %rbx,%rdi
    953c:	48 89 c6             	mov    %rax,%rsi
    953f:	5b                   	pop    %rbx
    9540:	e9 ab e4 ff ff       	jmp    79f0 <fwp_str_new>
    9545:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    954c:	00 00 00 00 

0000000000009550 <fwp_p_parse_int>:
    9550:	55                   	push   %rbp
    9551:	41 57                	push   %r15
    9553:	41 56                	push   %r14
    9555:	41 55                	push   %r13
    9557:	41 54                	push   %r12
    9559:	53                   	push   %rbx
    955a:	48 83 ec 18          	sub    $0x18,%rsp
    955e:	89 d3                	mov    %edx,%ebx
    9560:	89 f5                	mov    %esi,%ebp
    9562:	49 89 fe             	mov    %rdi,%r14
    9565:	4c 8b 3f             	mov    (%rdi),%r15
    9568:	49 83 c6 08          	add    $0x8,%r14
    956c:	4c 89 f7             	mov    %r14,%rdi
    956f:	4c 89 fe             	mov    %r15,%rsi
    9572:	e8 49 fc ff ff       	call   91c0 <fwp_valid_int>
    9577:	85 c0                	test   %eax,%eax
    9579:	0f 84 1a 01 00 00    	je     9699 <fwp_p_parse_int+0x149>
    957f:	41 0f b6 06          	movzbl (%r14),%eax
    9583:	31 ff                	xor    %edi,%edi
    9585:	3c 2d                	cmp    $0x2d,%al
    9587:	0f 94 c1             	sete   %cl
    958a:	3c 2b                	cmp    $0x2b,%al
    958c:	0f 94 c0             	sete   %al
    958f:	08 c8                	or     %cl,%al
    9591:	44 0f b6 e0          	movzbl %al,%r12d
    9595:	4d 39 e7             	cmp    %r12,%r15
    9598:	0f 86 d0 00 00 00    	jbe    966e <fwp_p_parse_int+0x11e>
    959e:	88 4c 24 07          	mov    %cl,0x7(%rsp)
    95a2:	89 6c 24 08          	mov    %ebp,0x8(%rsp)
    95a6:	89 5c 24 0c          	mov    %ebx,0xc(%rsp)
    95aa:	bf 0a 00 00 00       	mov    $0xa,%edi
    95af:	48 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rbx
    95b6:	cc cc cc 
    95b9:	48 bd cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbp
    95c0:	cc cc cc 
    95c3:	31 f6                	xor    %esi,%esi
    95c5:	45 31 db             	xor    %r11d,%r11d
    95c8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    95cf:	00 
    95d0:	4d 89 dd             	mov    %r11,%r13
    95d3:	49 89 f0             	mov    %rsi,%r8
    95d6:	48 89 f0             	mov    %rsi,%rax
    95d9:	48 f7 e7             	mul    %rdi
    95dc:	4b 8d 0c 9b          	lea    (%r11,%r11,4),%rcx
    95e0:	48 8d 0c 4a          	lea    (%rdx,%rcx,2),%rcx
    95e4:	43 0f be 14 26       	movsbl (%r14,%r12,1),%edx
    95e9:	83 c2 d0             	add    $0xffffffd0,%edx
    95ec:	48 63 d2             	movslq %edx,%rdx
    95ef:	49 89 d3             	mov    %rdx,%r11
    95f2:	49 c1 fb 3f          	sar    $0x3f,%r11
    95f6:	48 89 c6             	mov    %rax,%rsi
    95f9:	48 01 d6             	add    %rdx,%rsi
    95fc:	49 11 cb             	adc    %rcx,%r11
    95ff:	4d 89 d9             	mov    %r11,%r9
    9602:	49 0f a4 f1 3f       	shld   $0x3f,%rsi,%r9
    9607:	4c 89 d9             	mov    %r11,%rcx
    960a:	48 d1 e9             	shr    $1,%rcx
    960d:	4d 89 ca             	mov    %r9,%r10
    9610:	49 01 ca             	add    %rcx,%r10
    9613:	49 83 d2 00          	adc    $0x0,%r10
    9617:	4c 89 d0             	mov    %r10,%rax
    961a:	48 f7 e3             	mul    %rbx
    961d:	48 c1 ea 02          	shr    $0x2,%rdx
    9621:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9625:	49 29 c2             	sub    %rax,%r10
    9628:	4d 29 d1             	sub    %r10,%r9
    962b:	48 83 d9 00          	sbb    $0x0,%rcx
    962f:	4d 89 ca             	mov    %r9,%r10
    9632:	4c 0f af d5          	imul   %rbp,%r10
    9636:	4c 89 c8             	mov    %r9,%rax
    9639:	48 f7 e3             	mul    %rbx
    963c:	4c 01 d2             	add    %r10,%rdx
    963f:	48 0f af cb          	imul   %rbx,%rcx
    9643:	48 01 d1             	add    %rdx,%rcx
    9646:	4c 31 e9             	xor    %r13,%rcx
    9649:	4c 31 c0             	xor    %r8,%rax
    964c:	48 09 c8             	or     %rcx,%rax
    964f:	75 48                	jne    9699 <fwp_p_parse_int+0x149>
    9651:	49 ff c4             	inc    %r12
    9654:	4d 39 e7             	cmp    %r12,%r15
    9657:	0f 85 73 ff ff ff    	jne    95d0 <fwp_p_parse_int+0x80>
    965d:	8b 5c 24 0c          	mov    0xc(%rsp),%ebx
    9661:	8b 6c 24 08          	mov    0x8(%rsp),%ebp
    9665:	31 ff                	xor    %edi,%edi
    9667:	0f b6 4c 24 07       	movzbl 0x7(%rsp),%ecx
    966c:	eb 05                	jmp    9673 <fwp_p_parse_int+0x123>
    966e:	31 f6                	xor    %esi,%esi
    9670:	45 31 db             	xor    %r11d,%r11d
    9673:	40 88 cf             	mov    %cl,%dil
    9676:	4c 8d 4c 24 10       	lea    0x10(%rsp),%r9
    967b:	4c 89 da             	mov    %r11,%rdx
    967e:	89 e9                	mov    %ebp,%ecx
    9680:	41 89 d8             	mov    %ebx,%r8d
    9683:	e8 28 00 00 00       	call   96b0 <fwp_int_in_range>
    9688:	48 85 c0             	test   %rax,%rax
    968b:	74 0c                	je     9699 <fwp_p_parse_int+0x149>
    968d:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    9692:	e8 99 00 00 00       	call   9730 <fwp_some>
    9697:	eb 02                	jmp    969b <fwp_p_parse_int+0x14b>
    9699:	31 c0                	xor    %eax,%eax
    969b:	48 83 c4 18          	add    $0x18,%rsp
    969f:	5b                   	pop    %rbx
    96a0:	41 5c                	pop    %r12
    96a2:	41 5d                	pop    %r13
    96a4:	41 5e                	pop    %r14
    96a6:	41 5f                	pop    %r15
    96a8:	5d                   	pop    %rbp
    96a9:	c3                   	ret
    96aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000096b0 <fwp_int_in_range>:
    96b0:	53                   	push   %rbx
    96b1:	83 f9 09             	cmp    $0x9,%ecx
    96b4:	75 24                	jne    96da <fwp_int_in_range+0x2a>
    96b6:	85 ff                	test   %edi,%edi
    96b8:	74 08                	je     96c2 <fwp_int_in_range+0x12>
    96ba:	48 89 f0             	mov    %rsi,%rax
    96bd:	48 09 d0             	or     %rdx,%rax
    96c0:	75 3c                	jne    96fe <fwp_int_in_range+0x4e>
    96c2:	48 89 f7             	mov    %rsi,%rdi
    96c5:	48 89 d6             	mov    %rdx,%rsi
    96c8:	4c 89 cb             	mov    %r9,%rbx
    96cb:	e8 80 00 00 00       	call   9750 <fwp_box_u128>
    96d0:	48 89 03             	mov    %rax,(%rbx)
    96d3:	b8 01 00 00 00       	mov    $0x1,%eax
    96d8:	5b                   	pop    %rbx
    96d9:	c3                   	ret
    96da:	48 89 f0             	mov    %rsi,%rax
    96dd:	48 f7 d8             	neg    %rax
    96e0:	48 b8 00 00 00 00 00 	movabs $0x8000000000000000,%rax
    96e7:	00 00 80 
    96ea:	49 89 c2             	mov    %rax,%r10
    96ed:	49 19 d2             	sbb    %rdx,%r10
    96f0:	72 0c                	jb     96fe <fwp_int_in_range+0x4e>
    96f2:	85 ff                	test   %edi,%edi
    96f4:	75 0c                	jne    9702 <fwp_int_in_range+0x52>
    96f6:	48 31 d0             	xor    %rdx,%rax
    96f9:	48 09 f0             	or     %rsi,%rax
    96fc:	75 04                	jne    9702 <fwp_int_in_range+0x52>
    96fe:	31 c0                	xor    %eax,%eax
    9700:	5b                   	pop    %rbx
    9701:	c3                   	ret
    9702:	31 c0                	xor    %eax,%eax
    9704:	49 89 f2             	mov    %rsi,%r10
    9707:	49 f7 da             	neg    %r10
    970a:	48 19 d0             	sbb    %rdx,%rax
    970d:	85 ff                	test   %edi,%edi
    970f:	4c 0f 44 d6          	cmove  %rsi,%r10
    9713:	48 0f 44 c2          	cmove  %rdx,%rax
    9717:	4c 89 d7             	mov    %r10,%rdi
    971a:	48 89 c6             	mov    %rax,%rsi
    971d:	89 ca                	mov    %ecx,%edx
    971f:	44 89 c1             	mov    %r8d,%ecx
    9722:	4d 89 c8             	mov    %r9,%r8
    9725:	e8 56 00 00 00       	call   9780 <fwp_int_fits>
    972a:	89 c0                	mov    %eax,%eax
    972c:	5b                   	pop    %rbx
    972d:	c3                   	ret
    972e:	66 90                	xchg   %ax,%ax

0000000000009730 <fwp_some>:
    9730:	50                   	push   %rax
    9731:	48 89 3c 24          	mov    %rdi,(%rsp)
    9735:	48 89 e2             	mov    %rsp,%rdx
    9738:	bf 01 00 00 00       	mov    $0x1,%edi
    973d:	be 01 00 00 00       	mov    $0x1,%esi
    9742:	e8 d9 99 ff ff       	call   3120 <fwp_data>
    9747:	59                   	pop    %rcx
    9748:	c3                   	ret
    9749:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000009750 <fwp_box_u128>:
    9750:	41 56                	push   %r14
    9752:	53                   	push   %rbx
    9753:	50                   	push   %rax
    9754:	48 89 f3             	mov    %rsi,%rbx
    9757:	49 89 fe             	mov    %rdi,%r14
    975a:	bf 10 00 00 00       	mov    $0x10,%edi
    975f:	e8 cc d0 ff ff       	call   6830 <fwp_alloc_leaf>
    9764:	48 89 58 08          	mov    %rbx,0x8(%rax)
    9768:	4c 89 30             	mov    %r14,(%rax)
    976b:	48 83 c4 08          	add    $0x8,%rsp
    976f:	5b                   	pop    %rbx
    9770:	41 5e                	pop    %r14
    9772:	c3                   	ret
    9773:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    977a:	84 00 00 00 00 00 

0000000000009780 <fwp_int_fits>:
    9780:	41 57                	push   %r15
    9782:	41 56                	push   %r14
    9784:	53                   	push   %rbx
    9785:	31 c0                	xor    %eax,%eax
    9787:	83 fa 14             	cmp    $0x14,%edx
    978a:	0f 87 02 01 00 00    	ja     9892 <fwp_int_fits+0x112>
    9790:	89 d2                	mov    %edx,%edx
    9792:	4c 8d 0d ff 4a 00 00 	lea    0x4aff(%rip),%r9        # e298 <_IO_stdin_used+0x298>
    9799:	49 63 14 91          	movslq (%r9,%rdx,4),%rdx
    979d:	4c 01 ca             	add    %r9,%rdx
    97a0:	ff e2                	jmp    *%rdx
    97a2:	48 89 f9             	mov    %rdi,%rcx
    97a5:	48 83 c1 80          	add    $0xffffffffffffff80,%rcx
    97a9:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    97ad:	48 81 f9 00 ff ff ff 	cmp    $0xffffffffffffff00,%rcx
    97b4:	eb 3b                	jmp    97f1 <fwp_int_fits+0x71>
    97b6:	48 89 f9             	mov    %rdi,%rcx
    97b9:	48 81 c1 00 00 00 80 	add    $0xffffffff80000000,%rcx
    97c0:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    97c4:	48 ba 00 00 00 00 ff 	movabs $0xffffffff00000000,%rdx
    97cb:	ff ff ff 
    97ce:	48 39 d1             	cmp    %rdx,%rcx
    97d1:	eb 1e                	jmp    97f1 <fwp_int_fits+0x71>
    97d3:	31 c0                	xor    %eax,%eax
    97d5:	b9 ff 00 00 00       	mov    $0xff,%ecx
    97da:	eb 2b                	jmp    9807 <fwp_int_fits+0x87>
    97dc:	48 89 f9             	mov    %rdi,%rcx
    97df:	48 81 c1 00 80 ff ff 	add    $0xffffffffffff8000,%rcx
    97e6:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    97ea:	48 81 f9 00 00 ff ff 	cmp    $0xffffffffffff0000,%rcx
    97f1:	48 83 de ff          	sbb    $0xffffffffffffffff,%rsi
    97f5:	0f 83 8f 00 00 00    	jae    988a <fwp_int_fits+0x10a>
    97fb:	e9 92 00 00 00       	jmp    9892 <fwp_int_fits+0x112>
    9800:	31 c0                	xor    %eax,%eax
    9802:	b9 ff ff 00 00       	mov    $0xffff,%ecx
    9807:	48 39 f9             	cmp    %rdi,%rcx
    980a:	b9 00 00 00 00       	mov    $0x0,%ecx
    980f:	48 19 f1             	sbb    %rsi,%rcx
    9812:	73 76                	jae    988a <fwp_int_fits+0x10a>
    9814:	eb 7c                	jmp    9892 <fwp_int_fits+0x112>
    9816:	48 89 f9             	mov    %rdi,%rcx
    9819:	48 c1 e9 20          	shr    $0x20,%rcx
    981d:	48 09 f1             	or     %rsi,%rcx
    9820:	74 68                	je     988a <fwp_int_fits+0x10a>
    9822:	eb 6e                	jmp    9892 <fwp_int_fits+0x112>
    9824:	48 b9 00 00 00 00 00 	movabs $0x8000000000000000,%rcx
    982b:	00 00 80 
    982e:	48 01 f9             	add    %rdi,%rcx
    9831:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    9835:	48 83 fe ff          	cmp    $0xffffffffffffffff,%rsi
    9839:	74 4f                	je     988a <fwp_int_fits+0x10a>
    983b:	eb 55                	jmp    9892 <fwp_int_fits+0x112>
    983d:	4c 89 c3             	mov    %r8,%rbx
    9840:	e8 5b 00 00 00       	call   98a0 <fwp_box_i128>
    9845:	49 89 d8             	mov    %rbx,%r8
    9848:	48 89 c7             	mov    %rax,%rdi
    984b:	eb 3d                	jmp    988a <fwp_int_fits+0x10a>
    984d:	4c 89 c3             	mov    %r8,%rbx
    9850:	49 89 fe             	mov    %rdi,%r14
    9853:	89 cf                	mov    %ecx,%edi
    9855:	49 89 f7             	mov    %rsi,%r15
    9858:	e8 73 00 00 00       	call   98d0 <fwp_tint_max>
    985d:	48 89 c1             	mov    %rax,%rcx
    9860:	31 c0                	xor    %eax,%eax
    9862:	49 89 c8             	mov    %rcx,%r8
    9865:	49 f7 d8             	neg    %r8
    9868:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    986e:	49 19 d1             	sbb    %rdx,%r9
    9871:	4c 39 f1             	cmp    %r14,%rcx
    9874:	4c 19 fa             	sbb    %r15,%rdx
    9877:	7c 19                	jl     9892 <fwp_int_fits+0x112>
    9879:	4c 89 fe             	mov    %r15,%rsi
    987c:	4c 89 f7             	mov    %r14,%rdi
    987f:	4d 39 c6             	cmp    %r8,%r14
    9882:	4c 19 ce             	sbb    %r9,%rsi
    9885:	49 89 d8             	mov    %rbx,%r8
    9888:	7c 08                	jl     9892 <fwp_int_fits+0x112>
    988a:	49 89 38             	mov    %rdi,(%r8)
    988d:	b8 01 00 00 00       	mov    $0x1,%eax
    9892:	5b                   	pop    %rbx
    9893:	41 5e                	pop    %r14
    9895:	41 5f                	pop    %r15
    9897:	c3                   	ret
    9898:	48 85 f6             	test   %rsi,%rsi
    989b:	74 ed                	je     988a <fwp_int_fits+0x10a>
    989d:	eb f3                	jmp    9892 <fwp_int_fits+0x112>
    989f:	90                   	nop

00000000000098a0 <fwp_box_i128>:
    98a0:	41 56                	push   %r14
    98a2:	53                   	push   %rbx
    98a3:	50                   	push   %rax
    98a4:	48 89 f3             	mov    %rsi,%rbx
    98a7:	49 89 fe             	mov    %rdi,%r14
    98aa:	bf 10 00 00 00       	mov    $0x10,%edi
    98af:	e8 7c cf ff ff       	call   6830 <fwp_alloc_leaf>
    98b4:	48 89 58 08          	mov    %rbx,0x8(%rax)
    98b8:	4c 89 30             	mov    %r14,(%rax)
    98bb:	48 83 c4 08          	add    $0x8,%rsp
    98bf:	5b                   	pop    %rbx
    98c0:	41 5e                	pop    %r14
    98c2:	c3                   	ret
    98c3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    98ca:	84 00 00 00 00 00 

00000000000098d0 <fwp_tint_max>:
    98d0:	85 ff                	test   %edi,%edi
    98d2:	7e 27                	jle    98fb <fwp_tint_max+0x2b>
    98d4:	8d 47 ff             	lea    -0x1(%rdi),%eax
    98d7:	83 f8 4f             	cmp    $0x4f,%eax
    98da:	41 b8 4f 00 00 00    	mov    $0x4f,%r8d
    98e0:	44 0f 42 c0          	cmovb  %eax,%r8d
    98e4:	41 ff c0             	inc    %r8d
    98e7:	44 89 c6             	mov    %r8d,%esi
    98ea:	83 e6 07             	and    $0x7,%esi
    98ed:	83 ff 08             	cmp    $0x8,%edi
    98f0:	73 11                	jae    9903 <fwp_tint_max+0x33>
    98f2:	b8 01 00 00 00       	mov    $0x1,%eax
    98f7:	31 c9                	xor    %ecx,%ecx
    98f9:	eb 38                	jmp    9933 <fwp_tint_max+0x63>
    98fb:	31 c0                	xor    %eax,%eax
    98fd:	31 c9                	xor    %ecx,%ecx
    98ff:	48 89 ca             	mov    %rcx,%rdx
    9902:	c3                   	ret
    9903:	41 81 e0 f8 00 00 00 	and    $0xf8,%r8d
    990a:	b8 01 00 00 00       	mov    $0x1,%eax
    990f:	31 c9                	xor    %ecx,%ecx
    9911:	bf a1 19 00 00       	mov    $0x19a1,%edi
    9916:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    991d:	00 00 00 
    9920:	48 f7 e7             	mul    %rdi
    9923:	48 69 c9 a1 19 00 00 	imul   $0x19a1,%rcx,%rcx
    992a:	48 01 d1             	add    %rdx,%rcx
    992d:	41 83 c0 f8          	add    $0xfffffff8,%r8d
    9931:	75 ed                	jne    9920 <fwp_tint_max+0x50>
    9933:	85 f6                	test   %esi,%esi
    9935:	74 17                	je     994e <fwp_tint_max+0x7e>
    9937:	bf 03 00 00 00       	mov    $0x3,%edi
    993c:	0f 1f 40 00          	nopl   0x0(%rax)
    9940:	48 f7 e7             	mul    %rdi
    9943:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    9947:	48 01 d1             	add    %rdx,%rcx
    994a:	ff ce                	dec    %esi
    994c:	75 f2                	jne    9940 <fwp_tint_max+0x70>
    994e:	48 83 c0 ff          	add    $0xffffffffffffffff,%rax
    9952:	48 83 d1 ff          	adc    $0xffffffffffffffff,%rcx
    9956:	48 89 ca             	mov    %rcx,%rdx
    9959:	48 c1 ea 3f          	shr    $0x3f,%rdx
    995d:	48 01 c2             	add    %rax,%rdx
    9960:	48 89 d0             	mov    %rdx,%rax
    9963:	48 83 d1 00          	adc    $0x0,%rcx
    9967:	48 0f ac c8 01       	shrd   $0x1,%rcx,%rax
    996c:	48 d1 f9             	sar    $1,%rcx
    996f:	48 89 ca             	mov    %rcx,%rdx
    9972:	c3                   	ret
    9973:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    997a:	84 00 00 00 00 00 

0000000000009980 <fwp_valid_float>:
    9980:	48 85 f6             	test   %rsi,%rsi
    9983:	74 0e                	je     9993 <fwp_valid_float+0x13>
    9985:	0f b6 07             	movzbl (%rdi),%eax
    9988:	04 d5                	add    $0xd5,%al
    998a:	31 d2                	xor    %edx,%edx
    998c:	a8 fd                	test   $0xfd,%al
    998e:	0f 94 c2             	sete   %dl
    9991:	eb 02                	jmp    9995 <fwp_valid_float+0x15>
    9993:	31 d2                	xor    %edx,%edx
    9995:	41 b1 01             	mov    $0x1,%r9b
    9998:	49 89 d0             	mov    %rdx,%r8
    999b:	48 39 f2             	cmp    %rsi,%rdx
    999e:	73 1d                	jae    99bd <fwp_valid_float+0x3d>
    99a0:	42 0f b6 04 07       	movzbl (%rdi,%r8,1),%eax
    99a5:	8d 48 d0             	lea    -0x30(%rax),%ecx
    99a8:	80 f9 09             	cmp    $0x9,%cl
    99ab:	77 15                	ja     99c2 <fwp_valid_float+0x42>
    99ad:	49 ff c0             	inc    %r8
    99b0:	4c 39 c6             	cmp    %r8,%rsi
    99b3:	75 eb                	jne    99a0 <fwp_valid_float+0x20>
    99b5:	49 89 f0             	mov    %rsi,%r8
    99b8:	48 89 f1             	mov    %rsi,%rcx
    99bb:	eb 38                	jmp    99f5 <fwp_valid_float+0x75>
    99bd:	48 89 d1             	mov    %rdx,%rcx
    99c0:	eb 33                	jmp    99f5 <fwp_valid_float+0x75>
    99c2:	3c 2e                	cmp    $0x2e,%al
    99c4:	75 2c                	jne    99f2 <fwp_valid_float+0x72>
    99c6:	49 8d 48 01          	lea    0x1(%r8),%rcx
    99ca:	48 39 f1             	cmp    %rsi,%rcx
    99cd:	73 16                	jae    99e5 <fwp_valid_float+0x65>
    99cf:	90                   	nop
    99d0:	0f b6 04 0f          	movzbl (%rdi,%rcx,1),%eax
    99d4:	04 d0                	add    $0xd0,%al
    99d6:	3c 09                	cmp    $0x9,%al
    99d8:	77 0b                	ja     99e5 <fwp_valid_float+0x65>
    99da:	48 ff c1             	inc    %rcx
    99dd:	48 39 f1             	cmp    %rsi,%rcx
    99e0:	72 ee                	jb     99d0 <fwp_valid_float+0x50>
    99e2:	48 89 f1             	mov    %rsi,%rcx
    99e5:	48 8d 41 ff          	lea    -0x1(%rcx),%rax
    99e9:	4c 39 c0             	cmp    %r8,%rax
    99ec:	41 0f 94 c1          	sete   %r9b
    99f0:	eb 03                	jmp    99f5 <fwp_valid_float+0x75>
    99f2:	4c 89 c1             	mov    %r8,%rcx
    99f5:	31 c0                	xor    %eax,%eax
    99f7:	49 39 d0             	cmp    %rdx,%r8
    99fa:	75 06                	jne    9a02 <fwp_valid_float+0x82>
    99fc:	45 84 c9             	test   %r9b,%r9b
    99ff:	74 01                	je     9a02 <fwp_valid_float+0x82>
    9a01:	c3                   	ret
    9a02:	48 39 f1             	cmp    %rsi,%rcx
    9a05:	73 58                	jae    9a5f <fwp_valid_float+0xdf>
    9a07:	0f b6 14 0f          	movzbl (%rdi,%rcx,1),%edx
    9a0b:	83 ca 20             	or     $0x20,%edx
    9a0e:	83 fa 65             	cmp    $0x65,%edx
    9a11:	75 4c                	jne    9a5f <fwp_valid_float+0xdf>
    9a13:	48 8d 51 01          	lea    0x1(%rcx),%rdx
    9a17:	48 39 f2             	cmp    %rsi,%rdx
    9a1a:	73 18                	jae    9a34 <fwp_valid_float+0xb4>
    9a1c:	44 0f b6 04 17       	movzbl (%rdi,%rdx,1),%r8d
    9a21:	41 83 f8 2d          	cmp    $0x2d,%r8d
    9a25:	74 06                	je     9a2d <fwp_valid_float+0xad>
    9a27:	41 83 f8 2b          	cmp    $0x2b,%r8d
    9a2b:	75 07                	jne    9a34 <fwp_valid_float+0xb4>
    9a2d:	48 83 c1 02          	add    $0x2,%rcx
    9a31:	48 89 ca             	mov    %rcx,%rdx
    9a34:	48 39 f2             	cmp    %rsi,%rdx
    9a37:	73 c8                	jae    9a01 <fwp_valid_float+0x81>
    9a39:	48 89 d1             	mov    %rdx,%rcx
    9a3c:	0f 1f 40 00          	nopl   0x0(%rax)
    9a40:	44 0f b6 04 0f       	movzbl (%rdi,%rcx,1),%r8d
    9a45:	41 80 c0 d0          	add    $0xd0,%r8b
    9a49:	41 80 f8 09          	cmp    $0x9,%r8b
    9a4d:	77 0b                	ja     9a5a <fwp_valid_float+0xda>
    9a4f:	48 ff c1             	inc    %rcx
    9a52:	48 39 ce             	cmp    %rcx,%rsi
    9a55:	75 e9                	jne    9a40 <fwp_valid_float+0xc0>
    9a57:	48 89 f1             	mov    %rsi,%rcx
    9a5a:	48 39 d1             	cmp    %rdx,%rcx
    9a5d:	74 a2                	je     9a01 <fwp_valid_float+0x81>
    9a5f:	31 c0                	xor    %eax,%eax
    9a61:	48 39 f1             	cmp    %rsi,%rcx
    9a64:	0f 94 c0             	sete   %al
    9a67:	c3                   	ret
    9a68:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    9a6f:	00 

0000000000009a70 <fwp_float_of>:
    9a70:	83 ff 0a             	cmp    $0xa,%edi
    9a73:	0f 85 47 c1 ff ff    	jne    5bc0 <fwp_from_f64>
    9a79:	f2 0f 5a c0          	cvtsd2ss %xmm0,%xmm0
    9a7d:	e9 8e 96 ff ff       	jmp    3110 <fwp_from_f32>
    9a82:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9a89:	1f 84 00 00 00 00 00 

0000000000009a90 <fwp_utf8_put>:
    9a90:	50                   	push   %rax
    9a91:	83 fe 7f             	cmp    $0x7f,%esi
    9a94:	77 0f                	ja     9aa5 <fwp_utf8_put+0x15>
    9a96:	40 88 74 24 04       	mov    %sil,0x4(%rsp)
    9a9b:	ba 01 00 00 00       	mov    $0x1,%edx
    9aa0:	e9 8e 00 00 00       	jmp    9b33 <fwp_utf8_put+0xa3>
    9aa5:	89 f0                	mov    %esi,%eax
    9aa7:	81 fe ff 07 00 00    	cmp    $0x7ff,%esi
    9aad:	77 1d                	ja     9acc <fwp_utf8_put+0x3c>
    9aaf:	c1 e8 06             	shr    $0x6,%eax
    9ab2:	0c c0                	or     $0xc0,%al
    9ab4:	88 44 24 04          	mov    %al,0x4(%rsp)
    9ab8:	40 80 e6 3f          	and    $0x3f,%sil
    9abc:	40 80 ce 80          	or     $0x80,%sil
    9ac0:	40 88 74 24 05       	mov    %sil,0x5(%rsp)
    9ac5:	ba 02 00 00 00       	mov    $0x2,%edx
    9aca:	eb 67                	jmp    9b33 <fwp_utf8_put+0xa3>
    9acc:	81 fe ff ff 00 00    	cmp    $0xffff,%esi
    9ad2:	77 2a                	ja     9afe <fwp_utf8_put+0x6e>
    9ad4:	c1 e8 0c             	shr    $0xc,%eax
    9ad7:	0c e0                	or     $0xe0,%al
    9ad9:	88 44 24 04          	mov    %al,0x4(%rsp)
    9add:	89 f0                	mov    %esi,%eax
    9adf:	c1 e8 06             	shr    $0x6,%eax
    9ae2:	24 3f                	and    $0x3f,%al
    9ae4:	0c 80                	or     $0x80,%al
    9ae6:	88 44 24 05          	mov    %al,0x5(%rsp)
    9aea:	40 80 e6 3f          	and    $0x3f,%sil
    9aee:	40 80 ce 80          	or     $0x80,%sil
    9af2:	40 88 74 24 06       	mov    %sil,0x6(%rsp)
    9af7:	ba 03 00 00 00       	mov    $0x3,%edx
    9afc:	eb 35                	jmp    9b33 <fwp_utf8_put+0xa3>
    9afe:	c1 e8 12             	shr    $0x12,%eax
    9b01:	0c f0                	or     $0xf0,%al
    9b03:	88 44 24 04          	mov    %al,0x4(%rsp)
    9b07:	89 f0                	mov    %esi,%eax
    9b09:	c1 e8 0c             	shr    $0xc,%eax
    9b0c:	24 3f                	and    $0x3f,%al
    9b0e:	0c 80                	or     $0x80,%al
    9b10:	88 44 24 05          	mov    %al,0x5(%rsp)
    9b14:	89 f0                	mov    %esi,%eax
    9b16:	c1 e8 06             	shr    $0x6,%eax
    9b19:	24 3f                	and    $0x3f,%al
    9b1b:	0c 80                	or     $0x80,%al
    9b1d:	88 44 24 06          	mov    %al,0x6(%rsp)
    9b21:	40 80 e6 3f          	and    $0x3f,%sil
    9b25:	40 80 ce 80          	or     $0x80,%sil
    9b29:	40 88 74 24 07       	mov    %sil,0x7(%rsp)
    9b2e:	ba 04 00 00 00       	mov    $0x4,%edx
    9b33:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
    9b38:	e8 43 df ff ff       	call   7a80 <buf_put>
    9b3d:	58                   	pop    %rax
    9b3e:	c3                   	ret
    9b3f:	90                   	nop

0000000000009b40 <tp_push>:
    9b40:	41 56                	push   %r14
    9b42:	53                   	push   %rbx
    9b43:	50                   	push   %rax
    9b44:	48 89 f3             	mov    %rsi,%rbx
    9b47:	49 89 fe             	mov    %rdi,%r14
    9b4a:	48 8b 77 18          	mov    0x18(%rdi),%rsi
    9b4e:	48 3b 77 20          	cmp    0x20(%rdi),%rsi
    9b52:	75 2f                	jne    9b83 <tp_push+0x43>
    9b54:	48 8d 04 36          	lea    (%rsi,%rsi,1),%rax
    9b58:	48 85 f6             	test   %rsi,%rsi
    9b5b:	ba 08 00 00 00       	mov    $0x8,%edx
    9b60:	48 0f 45 d0          	cmovne %rax,%rdx
    9b64:	49 89 56 20          	mov    %rdx,0x20(%r14)
    9b68:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    9b6c:	48 c1 e6 03          	shl    $0x3,%rsi
    9b70:	48 c1 e2 03          	shl    $0x3,%rdx
    9b74:	e8 07 dc ff ff       	call   7780 <fwp_mem_realloc>
    9b79:	49 89 46 10          	mov    %rax,0x10(%r14)
    9b7d:	49 8b 76 18          	mov    0x18(%r14),%rsi
    9b81:	eb 04                	jmp    9b87 <tp_push+0x47>
    9b83:	49 8b 46 10          	mov    0x10(%r14),%rax
    9b87:	48 8d 4e 01          	lea    0x1(%rsi),%rcx
    9b8b:	49 89 4e 18          	mov    %rcx,0x18(%r14)
    9b8f:	48 89 1c f0          	mov    %rbx,(%rax,%rsi,8)
    9b93:	48 83 c4 08          	add    $0x8,%rsp
    9b97:	5b                   	pop    %rbx
    9b98:	41 5e                	pop    %r14
    9b9a:	c3                   	ret
    9b9b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000009ba0 <tp_is_delim>:
    9ba0:	b8 01 00 00 00       	mov    $0x1,%eax
    9ba5:	83 ff 2c             	cmp    $0x2c,%edi
    9ba8:	77 13                	ja     9bbd <tp_is_delim+0x1d>
    9baa:	89 f9                	mov    %edi,%ecx
    9bac:	48 ba 00 26 00 00 01 	movabs $0x130100002600,%rdx
    9bb3:	13 00 00 
    9bb6:	48 0f a3 ca          	bt     %rcx,%rdx
    9bba:	73 01                	jae    9bbd <tp_is_delim+0x1d>
    9bbc:	c3                   	ret
    9bbd:	83 ff 5d             	cmp    $0x5d,%edi
    9bc0:	74 fa                	je     9bbc <tp_is_delim+0x1c>
    9bc2:	83 ff 7d             	cmp    $0x7d,%edi
    9bc5:	74 f5                	je     9bbc <tp_is_delim+0x1c>
    9bc7:	31 c0                	xor    %eax,%eax
    9bc9:	40 80 ff 3a          	cmp    $0x3a,%dil
    9bcd:	0f 94 c0             	sete   %al
    9bd0:	c3                   	ret
    9bd1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9bd8:	0f 1f 84 00 00 00 00 
    9bdf:	00 

0000000000009be0 <fwp_list_len>:
    9be0:	31 c0                	xor    %eax,%eax
    9be2:	48 85 ff             	test   %rdi,%rdi
    9be5:	74 15                	je     9bfc <fwp_list_len+0x1c>
    9be7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    9bee:	00 00 
    9bf0:	48 ff c0             	inc    %rax
    9bf3:	48 8b 7f 10          	mov    0x10(%rdi),%rdi
    9bf7:	48 85 ff             	test   %rdi,%rdi
    9bfa:	75 f4                	jne    9bf0 <fwp_list_len+0x10>
    9bfc:	c3                   	ret
    9bfd:	0f 1f 00             	nopl   (%rax)

0000000000009c00 <fwp_map_find>:
    9c00:	55                   	push   %rbp
    9c01:	41 57                	push   %r15
    9c03:	41 56                	push   %r14
    9c05:	41 55                	push   %r13
    9c07:	41 54                	push   %r12
    9c09:	53                   	push   %rbx
    9c0a:	50                   	push   %rax
    9c0b:	49 89 f6             	mov    %rsi,%r14
    9c0e:	49 89 ff             	mov    %rdi,%r15
    9c11:	48 8b 2f             	mov    (%rdi),%rbp
    9c14:	8b 02                	mov    (%rdx),%eax
    9c16:	83 f8 04             	cmp    $0x4,%eax
    9c19:	72 53                	jb     9c6e <fwp_map_find+0x6e>
    9c1b:	83 c0 fb             	add    $0xfffffffb,%eax
    9c1e:	83 f8 04             	cmp    $0x4,%eax
    9c21:	0f 83 a3 00 00 00    	jae    9cca <fwp_map_find+0xca>
    9c27:	48 85 ed             	test   %rbp,%rbp
    9c2a:	0f 84 f7 00 00 00    	je     9d27 <fwp_map_find+0x127>
    9c30:	31 f6                	xor    %esi,%esi
    9c32:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    9c39:	ff ff 1f 
    9c3c:	eb 0a                	jmp    9c48 <fwp_map_find+0x48>
    9c3e:	66 90                	xchg   %ax,%ax
    9c40:	4c 89 e5             	mov    %r12,%rbp
    9c43:	48 39 ee             	cmp    %rbp,%rsi
    9c46:	73 74                	jae    9cbc <fwp_map_find+0xbc>
    9c48:	48 8d 14 2e          	lea    (%rsi,%rbp,1),%rdx
    9c4c:	49 89 d4             	mov    %rdx,%r12
    9c4f:	49 d1 ec             	shr    $1,%r12
    9c52:	48 21 c2             	and    %rax,%rdx
    9c55:	49 8b 54 d7 08       	mov    0x8(%r15,%rdx,8),%rdx
    9c5a:	4c 39 f2             	cmp    %r14,%rdx
    9c5d:	74 64                	je     9cc3 <fwp_map_find+0xc3>
    9c5f:	73 df                	jae    9c40 <fwp_map_find+0x40>
    9c61:	49 ff c4             	inc    %r12
    9c64:	4c 89 e6             	mov    %r12,%rsi
    9c67:	48 39 ee             	cmp    %rbp,%rsi
    9c6a:	72 dc                	jb     9c48 <fwp_map_find+0x48>
    9c6c:	eb 4e                	jmp    9cbc <fwp_map_find+0xbc>
    9c6e:	48 85 ed             	test   %rbp,%rbp
    9c71:	0f 84 b0 00 00 00    	je     9d27 <fwp_map_find+0x127>
    9c77:	31 f6                	xor    %esi,%esi
    9c79:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    9c80:	ff ff 1f 
    9c83:	eb 13                	jmp    9c98 <fwp_map_find+0x98>
    9c85:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    9c8c:	00 00 00 00 
    9c90:	4c 89 e5             	mov    %r12,%rbp
    9c93:	48 39 ee             	cmp    %rbp,%rsi
    9c96:	73 24                	jae    9cbc <fwp_map_find+0xbc>
    9c98:	48 8d 14 2e          	lea    (%rsi,%rbp,1),%rdx
    9c9c:	49 89 d4             	mov    %rdx,%r12
    9c9f:	49 d1 ec             	shr    $1,%r12
    9ca2:	48 21 c2             	and    %rax,%rdx
    9ca5:	49 8b 54 d7 08       	mov    0x8(%r15,%rdx,8),%rdx
    9caa:	4c 39 f2             	cmp    %r14,%rdx
    9cad:	74 14                	je     9cc3 <fwp_map_find+0xc3>
    9caf:	7d df                	jge    9c90 <fwp_map_find+0x90>
    9cb1:	49 ff c4             	inc    %r12
    9cb4:	4c 89 e6             	mov    %r12,%rsi
    9cb7:	48 39 ee             	cmp    %rbp,%rsi
    9cba:	72 dc                	jb     9c98 <fwp_map_find+0x98>
    9cbc:	31 c0                	xor    %eax,%eax
    9cbe:	49 89 f4             	mov    %rsi,%r12
    9cc1:	eb 69                	jmp    9d2c <fwp_map_find+0x12c>
    9cc3:	b8 01 00 00 00       	mov    $0x1,%eax
    9cc8:	eb 62                	jmp    9d2c <fwp_map_find+0x12c>
    9cca:	48 85 ed             	test   %rbp,%rbp
    9ccd:	74 58                	je     9d27 <fwp_map_find+0x127>
    9ccf:	49 89 d5             	mov    %rdx,%r13
    9cd2:	48 89 0c 24          	mov    %rcx,(%rsp)
    9cd6:	31 db                	xor    %ebx,%ebx
    9cd8:	eb 0e                	jmp    9ce8 <fwp_map_find+0xe8>
    9cda:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9ce0:	4c 89 e5             	mov    %r12,%rbp
    9ce3:	48 39 eb             	cmp    %rbp,%rbx
    9ce6:	73 38                	jae    9d20 <fwp_map_find+0x120>
    9ce8:	48 8d 04 2b          	lea    (%rbx,%rbp,1),%rax
    9cec:	49 89 c4             	mov    %rax,%r12
    9cef:	49 d1 ec             	shr    $1,%r12
    9cf2:	48 b9 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rcx
    9cf9:	ff ff 1f 
    9cfc:	48 21 c8             	and    %rcx,%rax
    9cff:	49 8b 7c c7 08       	mov    0x8(%r15,%rax,8),%rdi
    9d04:	4c 89 f6             	mov    %r14,%rsi
    9d07:	4c 89 ea             	mov    %r13,%rdx
    9d0a:	e8 61 00 00 00       	call   9d70 <fwp_cmp>
    9d0f:	85 c0                	test   %eax,%eax
    9d11:	74 2d                	je     9d40 <fwp_map_find+0x140>
    9d13:	79 cb                	jns    9ce0 <fwp_map_find+0xe0>
    9d15:	49 ff c4             	inc    %r12
    9d18:	4c 89 e3             	mov    %r12,%rbx
    9d1b:	48 39 eb             	cmp    %rbp,%rbx
    9d1e:	72 c8                	jb     9ce8 <fwp_map_find+0xe8>
    9d20:	31 c0                	xor    %eax,%eax
    9d22:	49 89 dc             	mov    %rbx,%r12
    9d25:	eb 1e                	jmp    9d45 <fwp_map_find+0x145>
    9d27:	31 c0                	xor    %eax,%eax
    9d29:	45 31 e4             	xor    %r12d,%r12d
    9d2c:	89 01                	mov    %eax,(%rcx)
    9d2e:	4c 89 e0             	mov    %r12,%rax
    9d31:	48 83 c4 08          	add    $0x8,%rsp
    9d35:	5b                   	pop    %rbx
    9d36:	41 5c                	pop    %r12
    9d38:	41 5d                	pop    %r13
    9d3a:	41 5e                	pop    %r14
    9d3c:	41 5f                	pop    %r15
    9d3e:	5d                   	pop    %rbp
    9d3f:	c3                   	ret
    9d40:	b8 01 00 00 00       	mov    $0x1,%eax
    9d45:	48 8b 0c 24          	mov    (%rsp),%rcx
    9d49:	eb e1                	jmp    9d2c <fwp_map_find+0x12c>
    9d4b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000009d50 <fwp_map_alloc>:
    9d50:	53                   	push   %rbx
    9d51:	48 89 fb             	mov    %rdi,%rbx
    9d54:	48 c1 e7 04          	shl    $0x4,%rdi
    9d58:	48 83 cf 08          	or     $0x8,%rdi
    9d5c:	e8 bf b9 ff ff       	call   5720 <fwp_alloc>
    9d61:	48 89 18             	mov    %rbx,(%rax)
    9d64:	5b                   	pop    %rbx
    9d65:	c3                   	ret
    9d66:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    9d6d:	00 00 00 

0000000000009d70 <fwp_cmp>:
    9d70:	55                   	push   %rbp
    9d71:	41 57                	push   %r15
    9d73:	41 56                	push   %r14
    9d75:	41 55                	push   %r13
    9d77:	41 54                	push   %r12
    9d79:	53                   	push   %rbx
    9d7a:	48 83 ec 18          	sub    $0x18,%rsp
    9d7e:	48 89 f3             	mov    %rsi,%rbx
    9d81:	49 89 fe             	mov    %rdi,%r14
    9d84:	44 8b 2a             	mov    (%rdx),%r13d
    9d87:	49 83 fd 15          	cmp    $0x15,%r13
    9d8b:	77 25                	ja     9db2 <fwp_cmp+0x42>
    9d8d:	49 89 d7             	mov    %rdx,%r15
    9d90:	48 8d 05 55 45 00 00 	lea    0x4555(%rip),%rax        # e2ec <_IO_stdin_used+0x2ec>
    9d97:	4a 63 0c a8          	movslq (%rax,%r13,4),%rcx
    9d9b:	48 01 c1             	add    %rax,%rcx
    9d9e:	ff e1                	jmp    *%rcx
    9da0:	31 c9                	xor    %ecx,%ecx
    9da2:	49 39 de             	cmp    %rbx,%r14
    9da5:	0f 9f c1             	setg   %cl
    9da8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9dad:	0f 4d c1             	cmovge %ecx,%eax
    9db0:	eb 10                	jmp    9dc2 <fwp_cmp+0x52>
    9db2:	31 c9                	xor    %ecx,%ecx
    9db4:	49 39 de             	cmp    %rbx,%r14
    9db7:	0f 97 c1             	seta   %cl
    9dba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9dbf:	0f 43 c1             	cmovae %ecx,%eax
    9dc2:	48 83 c4 18          	add    $0x18,%rsp
    9dc6:	5b                   	pop    %rbx
    9dc7:	41 5c                	pop    %r12
    9dc9:	41 5d                	pop    %r13
    9dcb:	41 5e                	pop    %r14
    9dcd:	41 5f                	pop    %r15
    9dcf:	5d                   	pop    %rbp
    9dd0:	c3                   	ret
    9dd1:	4d 8b 3e             	mov    (%r14),%r15
    9dd4:	4c 8b 23             	mov    (%rbx),%r12
    9dd7:	49 83 c6 08          	add    $0x8,%r14
    9ddb:	48 83 c3 08          	add    $0x8,%rbx
    9ddf:	4d 39 e7             	cmp    %r12,%r15
    9de2:	4c 89 e2             	mov    %r12,%rdx
    9de5:	49 0f 42 d7          	cmovb  %r15,%rdx
    9de9:	4c 89 f7             	mov    %r14,%rdi
    9dec:	48 89 de             	mov    %rbx,%rsi
    9def:	e8 7c 84 ff ff       	call   2270 <memcmp@plt>
    9df4:	85 c0                	test   %eax,%eax
    9df6:	0f 84 ce 02 00 00    	je     a0ca <fwp_cmp+0x35a>
    9dfc:	c1 f8 1f             	sar    $0x1f,%eax
    9dff:	83 c8 01             	or     $0x1,%eax
    9e02:	eb be                	jmp    9dc2 <fwp_cmp+0x52>
    9e04:	49 8b 06             	mov    (%r14),%rax
    9e07:	48 8b 2b             	mov    (%rbx),%rbp
    9e0a:	48 39 e8             	cmp    %rbp,%rax
    9e0d:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    9e12:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    9e17:	48 0f 42 e8          	cmovb  %rax,%rbp
    9e1b:	48 85 ed             	test   %rbp,%rbp
    9e1e:	74 54                	je     9e74 <fwp_cmp+0x104>
    9e20:	49 8b 47 38          	mov    0x38(%r15),%rax
    9e24:	48 89 04 24          	mov    %rax,(%rsp)
    9e28:	41 bc 10 00 00 00    	mov    $0x10,%r12d
    9e2e:	eb 09                	jmp    9e39 <fwp_cmp+0xc9>
    9e30:	49 83 c4 10          	add    $0x10,%r12
    9e34:	48 ff cd             	dec    %rbp
    9e37:	74 3b                	je     9e74 <fwp_cmp+0x104>
    9e39:	4b 8b 7c 26 f8       	mov    -0x8(%r14,%r12,1),%rdi
    9e3e:	4a 8b 74 23 f8       	mov    -0x8(%rbx,%r12,1),%rsi
    9e43:	48 8b 14 24          	mov    (%rsp),%rdx
    9e47:	e8 24 ff ff ff       	call   9d70 <fwp_cmp>
    9e4c:	85 c0                	test   %eax,%eax
    9e4e:	0f 85 6e ff ff ff    	jne    9dc2 <fwp_cmp+0x52>
    9e54:	41 83 fd 12          	cmp    $0x12,%r13d
    9e58:	75 d6                	jne    9e30 <fwp_cmp+0xc0>
    9e5a:	4b 8b 3c 26          	mov    (%r14,%r12,1),%rdi
    9e5e:	4a 8b 34 23          	mov    (%rbx,%r12,1),%rsi
    9e62:	49 8b 57 40          	mov    0x40(%r15),%rdx
    9e66:	e8 05 ff ff ff       	call   9d70 <fwp_cmp>
    9e6b:	85 c0                	test   %eax,%eax
    9e6d:	74 c1                	je     9e30 <fwp_cmp+0xc0>
    9e6f:	e9 4e ff ff ff       	jmp    9dc2 <fwp_cmp+0x52>
    9e74:	31 c9                	xor    %ecx,%ecx
    9e76:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    9e7b:	48 39 44 24 10       	cmp    %rax,0x10(%rsp)
    9e80:	e9 32 ff ff ff       	jmp    9db7 <fwp_cmp+0x47>
    9e85:	4c 89 f7             	mov    %r14,%rdi
    9e88:	e8 73 02 00 00       	call   a100 <fwp_u128>
    9e8d:	49 89 c7             	mov    %rax,%r15
    9e90:	49 89 d6             	mov    %rdx,%r14
    9e93:	48 89 df             	mov    %rbx,%rdi
    9e96:	e8 65 02 00 00       	call   a100 <fwp_u128>
    9e9b:	48 89 c1             	mov    %rax,%rcx
    9e9e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9ea3:	49 39 cf             	cmp    %rcx,%r15
    9ea6:	4c 89 f6             	mov    %r14,%rsi
    9ea9:	48 19 d6             	sbb    %rdx,%rsi
    9eac:	0f 82 10 ff ff ff    	jb     9dc2 <fwp_cmp+0x52>
    9eb2:	4c 39 f9             	cmp    %r15,%rcx
    9eb5:	4c 19 f2             	sbb    %r14,%rdx
    9eb8:	0f 92 c0             	setb   %al
    9ebb:	0f b6 c0             	movzbl %al,%eax
    9ebe:	e9 ff fe ff ff       	jmp    9dc2 <fwp_cmp+0x52>
    9ec3:	4c 89 f7             	mov    %r14,%rdi
    9ec6:	e8 e5 91 ff ff       	call   30b0 <fwp_f32>
    9ecb:	e8 40 02 00 00       	call   a110 <fwp_total_key32>
    9ed0:	89 c5                	mov    %eax,%ebp
    9ed2:	48 89 df             	mov    %rbx,%rdi
    9ed5:	e8 d6 91 ff ff       	call   30b0 <fwp_f32>
    9eda:	e8 31 02 00 00       	call   a110 <fwp_total_key32>
    9edf:	89 c1                	mov    %eax,%ecx
    9ee1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9ee6:	39 cd                	cmp    %ecx,%ebp
    9ee8:	0f 8c d4 fe ff ff    	jl     9dc2 <fwp_cmp+0x52>
    9eee:	eb 2e                	jmp    9f1e <fwp_cmp+0x1ae>
    9ef0:	4c 89 f7             	mov    %r14,%rdi
    9ef3:	e8 b8 bc ff ff       	call   5bb0 <fwp_f64>
    9ef8:	e8 23 02 00 00       	call   a120 <fwp_total_key64>
    9efd:	49 89 c6             	mov    %rax,%r14
    9f00:	48 89 df             	mov    %rbx,%rdi
    9f03:	e8 a8 bc ff ff       	call   5bb0 <fwp_f64>
    9f08:	e8 13 02 00 00       	call   a120 <fwp_total_key64>
    9f0d:	48 89 c1             	mov    %rax,%rcx
    9f10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9f15:	49 39 ce             	cmp    %rcx,%r14
    9f18:	0f 8c a4 fe ff ff    	jl     9dc2 <fwp_cmp+0x52>
    9f1e:	0f 9f c0             	setg   %al
    9f21:	0f b6 c0             	movzbl %al,%eax
    9f24:	e9 99 fe ff ff       	jmp    9dc2 <fwp_cmp+0x52>
    9f29:	4c 89 f7             	mov    %r14,%rdi
    9f2c:	e8 bf 01 00 00       	call   a0f0 <fwp_i128>
    9f31:	49 89 c7             	mov    %rax,%r15
    9f34:	49 89 d6             	mov    %rdx,%r14
    9f37:	48 89 df             	mov    %rbx,%rdi
    9f3a:	e8 b1 01 00 00       	call   a0f0 <fwp_i128>
    9f3f:	48 89 c1             	mov    %rax,%rcx
    9f42:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9f47:	49 39 cf             	cmp    %rcx,%r15
    9f4a:	4c 89 f6             	mov    %r14,%rsi
    9f4d:	48 19 d6             	sbb    %rdx,%rsi
    9f50:	0f 8c 6c fe ff ff    	jl     9dc2 <fwp_cmp+0x52>
    9f56:	4c 39 f9             	cmp    %r15,%rcx
    9f59:	4c 19 f2             	sbb    %r14,%rdx
    9f5c:	0f 9c c0             	setl   %al
    9f5f:	0f b6 c0             	movzbl %al,%eax
    9f62:	e9 5b fe ff ff       	jmp    9dc2 <fwp_cmp+0x52>
    9f67:	4d 85 f6             	test   %r14,%r14
    9f6a:	0f 94 c0             	sete   %al
    9f6d:	74 3e                	je     9fad <fwp_cmp+0x23d>
    9f6f:	48 85 db             	test   %rbx,%rbx
    9f72:	74 39                	je     9fad <fwp_cmp+0x23d>
    9f74:	4d 8b 7f 38          	mov    0x38(%r15),%r15
    9f78:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    9f7f:	00 
    9f80:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    9f84:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    9f88:	4c 89 fa             	mov    %r15,%rdx
    9f8b:	e8 e0 fd ff ff       	call   9d70 <fwp_cmp>
    9f90:	85 c0                	test   %eax,%eax
    9f92:	0f 85 2a fe ff ff    	jne    9dc2 <fwp_cmp+0x52>
    9f98:	4d 8b 76 10          	mov    0x10(%r14),%r14
    9f9c:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    9fa0:	4d 85 f6             	test   %r14,%r14
    9fa3:	0f 94 c0             	sete   %al
    9fa6:	74 05                	je     9fad <fwp_cmp+0x23d>
    9fa8:	48 85 db             	test   %rbx,%rbx
    9fab:	75 d3                	jne    9f80 <fwp_cmp+0x210>
    9fad:	48 85 db             	test   %rbx,%rbx
    9fb0:	0f 95 c1             	setne  %cl
    9fb3:	08 c1                	or     %al,%cl
    9fb5:	80 f1 01             	xor    $0x1,%cl
    9fb8:	0f b6 c9             	movzbl %cl,%ecx
    9fbb:	84 c0                	test   %al,%al
    9fbd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9fc2:	0f 44 c1             	cmove  %ecx,%eax
    9fc5:	48 85 db             	test   %rbx,%rbx
    9fc8:	0f 44 c1             	cmove  %ecx,%eax
    9fcb:	e9 f2 fd ff ff       	jmp    9dc2 <fwp_cmp+0x52>
    9fd0:	45 8b 67 10          	mov    0x10(%r15),%r12d
    9fd4:	45 85 e4             	test   %r12d,%r12d
    9fd7:	0f 8e f7 00 00 00    	jle    a0d4 <fwp_cmp+0x364>
    9fdd:	4d 8b 7f 20          	mov    0x20(%r15),%r15
    9fe1:	45 31 ed             	xor    %r13d,%r13d
    9fe4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    9feb:	00 00 00 00 00 
    9ff0:	4b 8b 7c ee 08       	mov    0x8(%r14,%r13,8),%rdi
    9ff5:	4a 8b 74 eb 08       	mov    0x8(%rbx,%r13,8),%rsi
    9ffa:	4b 8b 14 ef          	mov    (%r15,%r13,8),%rdx
    9ffe:	e8 6d fd ff ff       	call   9d70 <fwp_cmp>
    a003:	85 c0                	test   %eax,%eax
    a005:	0f 85 b7 fd ff ff    	jne    9dc2 <fwp_cmp+0x52>
    a00b:	49 ff c5             	inc    %r13
    a00e:	31 c0                	xor    %eax,%eax
    a010:	4d 39 ec             	cmp    %r13,%r12
    a013:	75 db                	jne    9ff0 <fwp_cmp+0x280>
    a015:	e9 a8 fd ff ff       	jmp    9dc2 <fwp_cmp+0x52>
    a01a:	49 8b 06             	mov    (%r14),%rax
    a01d:	4c 8b 2b             	mov    (%rbx),%r13
    a020:	4c 39 e8             	cmp    %r13,%rax
    a023:	4c 89 ed             	mov    %r13,%rbp
    a026:	48 89 04 24          	mov    %rax,(%rsp)
    a02a:	48 0f 42 e8          	cmovb  %rax,%rbp
    a02e:	48 85 ed             	test   %rbp,%rbp
    a031:	74 2f                	je     a062 <fwp_cmp+0x2f2>
    a033:	4d 8b 7f 38          	mov    0x38(%r15),%r15
    a037:	45 31 e4             	xor    %r12d,%r12d
    a03a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    a040:	4b 8b 7c e6 08       	mov    0x8(%r14,%r12,8),%rdi
    a045:	4a 8b 74 e3 08       	mov    0x8(%rbx,%r12,8),%rsi
    a04a:	4c 89 fa             	mov    %r15,%rdx
    a04d:	e8 1e fd ff ff       	call   9d70 <fwp_cmp>
    a052:	85 c0                	test   %eax,%eax
    a054:	0f 85 68 fd ff ff    	jne    9dc2 <fwp_cmp+0x52>
    a05a:	49 ff c4             	inc    %r12
    a05d:	4c 39 e5             	cmp    %r12,%rbp
    a060:	75 de                	jne    a040 <fwp_cmp+0x2d0>
    a062:	31 c9                	xor    %ecx,%ecx
    a064:	4c 39 2c 24          	cmp    %r13,(%rsp)
    a068:	e9 4a fd ff ff       	jmp    9db7 <fwp_cmp+0x47>
    a06d:	4c 89 f7             	mov    %r14,%rdi
    a070:	e8 cb 00 00 00       	call   a140 <fwp_tag>
    a075:	89 c5                	mov    %eax,%ebp
    a077:	48 89 df             	mov    %rbx,%rdi
    a07a:	e8 c1 00 00 00       	call   a140 <fwp_tag>
    a07f:	39 c5                	cmp    %eax,%ebp
    a081:	75 58                	jne    a0db <fwp_cmp+0x36b>
    a083:	49 8b 4f 28          	mov    0x28(%r15),%rcx
    a087:	89 e8                	mov    %ebp,%eax
    a089:	44 8b 24 81          	mov    (%rcx,%rax,4),%r12d
    a08d:	45 85 e4             	test   %r12d,%r12d
    a090:	7e 42                	jle    a0d4 <fwp_cmp+0x364>
    a092:	49 8b 4f 30          	mov    0x30(%r15),%rcx
    a096:	4c 8b 3c c1          	mov    (%rcx,%rax,8),%r15
    a09a:	45 31 ed             	xor    %r13d,%r13d
    a09d:	0f 1f 00             	nopl   (%rax)
    a0a0:	4b 8b 7c ee 08       	mov    0x8(%r14,%r13,8),%rdi
    a0a5:	4a 8b 74 eb 08       	mov    0x8(%rbx,%r13,8),%rsi
    a0aa:	4b 8b 14 ef          	mov    (%r15,%r13,8),%rdx
    a0ae:	e8 bd fc ff ff       	call   9d70 <fwp_cmp>
    a0b3:	85 c0                	test   %eax,%eax
    a0b5:	0f 85 07 fd ff ff    	jne    9dc2 <fwp_cmp+0x52>
    a0bb:	49 ff c5             	inc    %r13
    a0be:	31 c0                	xor    %eax,%eax
    a0c0:	4d 39 ec             	cmp    %r13,%r12
    a0c3:	75 db                	jne    a0a0 <fwp_cmp+0x330>
    a0c5:	e9 f8 fc ff ff       	jmp    9dc2 <fwp_cmp+0x52>
    a0ca:	31 c9                	xor    %ecx,%ecx
    a0cc:	4d 39 e7             	cmp    %r12,%r15
    a0cf:	e9 e3 fc ff ff       	jmp    9db7 <fwp_cmp+0x47>
    a0d4:	31 c0                	xor    %eax,%eax
    a0d6:	e9 e7 fc ff ff       	jmp    9dc2 <fwp_cmp+0x52>
    a0db:	0f 97 c0             	seta   %al
    a0de:	0f b6 c8             	movzbl %al,%ecx
    a0e1:	e9 d4 fc ff ff       	jmp    9dba <fwp_cmp+0x4a>
    a0e6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    a0ed:	00 00 00 

000000000000a0f0 <fwp_i128>:
    a0f0:	48 8b 07             	mov    (%rdi),%rax
    a0f3:	48 8b 57 08          	mov    0x8(%rdi),%rdx
    a0f7:	c3                   	ret
    a0f8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a0ff:	00 

000000000000a100 <fwp_u128>:
    a100:	48 8b 07             	mov    (%rdi),%rax
    a103:	48 8b 57 08          	mov    0x8(%rdi),%rdx
    a107:	c3                   	ret
    a108:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a10f:	00 

000000000000a110 <fwp_total_key32>:
    a110:	66 0f 7e c1          	movd   %xmm0,%ecx
    a114:	89 c8                	mov    %ecx,%eax
    a116:	c1 f8 1f             	sar    $0x1f,%eax
    a119:	d1 e8                	shr    $1,%eax
    a11b:	31 c8                	xor    %ecx,%eax
    a11d:	c3                   	ret
    a11e:	66 90                	xchg   %ax,%ax

000000000000a120 <fwp_total_key64>:
    a120:	66 48 0f 7e c1       	movq   %xmm0,%rcx
    a125:	48 89 c8             	mov    %rcx,%rax
    a128:	48 c1 f8 3f          	sar    $0x3f,%rax
    a12c:	48 d1 e8             	shr    $1,%rax
    a12f:	48 31 c8             	xor    %rcx,%rax
    a132:	c3                   	ret
    a133:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a13a:	84 00 00 00 00 00 

000000000000a140 <fwp_tag>:
    a140:	48 89 f8             	mov    %rdi,%rax
    a143:	48 81 ff ff 0f 00 00 	cmp    $0xfff,%rdi
    a14a:	76 02                	jbe    a14e <fwp_tag+0xe>
    a14c:	8b 00                	mov    (%rax),%eax
    a14e:	c3                   	ret
    a14f:	90                   	nop

000000000000a150 <fwp_transport_off>:
    a150:	50                   	push   %rax
    a151:	48 8d 3d 72 51 00 00 	lea    0x5172(%rip),%rdi        # f2ca <exec_in_fp0+0xc7a>
    a158:	e8 d3 7e ff ff       	call   2030 <getenv@plt>
    a15d:	48 85 c0             	test   %rax,%rax
    a160:	74 1a                	je     a17c <fwp_transport_off+0x2c>
    a162:	48 8d 35 6f 51 00 00 	lea    0x516f(%rip),%rsi        # f2d8 <exec_in_fp0+0xc88>
    a169:	48 89 c7             	mov    %rax,%rdi
    a16c:	e8 5f 81 ff ff       	call   22d0 <strcmp@plt>
    a171:	89 c1                	mov    %eax,%ecx
    a173:	31 c0                	xor    %eax,%eax
    a175:	85 c9                	test   %ecx,%ecx
    a177:	0f 94 c0             	sete   %al
    a17a:	59                   	pop    %rcx
    a17b:	c3                   	ret
    a17c:	31 c0                	xor    %eax,%eax
    a17e:	59                   	pop    %rcx
    a17f:	c3                   	ret

000000000000a180 <fwp_pipe_addr>:
    a180:	50                   	push   %rax
    a181:	0f 57 c0             	xorps  %xmm0,%xmm0
    a184:	0f 11 47 5e          	movups %xmm0,0x5e(%rdi)
    a188:	0f 11 47 52          	movups %xmm0,0x52(%rdi)
    a18c:	0f 11 47 42          	movups %xmm0,0x42(%rdi)
    a190:	0f 11 47 32          	movups %xmm0,0x32(%rdi)
    a194:	0f 11 47 22          	movups %xmm0,0x22(%rdi)
    a198:	0f 11 47 12          	movups %xmm0,0x12(%rdi)
    a19c:	0f 11 47 02          	movups %xmm0,0x2(%rdi)
    a1a0:	66 c7 07 01 00       	movw   $0x1,(%rdi)
    a1a5:	48 83 c7 03          	add    $0x3,%rdi
    a1a9:	48 8b 0e             	mov    (%rsi),%rcx
    a1ac:	4c 8b 46 08          	mov    0x8(%rsi),%r8
    a1b0:	48 8d 15 27 51 00 00 	lea    0x5127(%rip),%rdx        # f2de <exec_in_fp0+0xc8e>
    a1b7:	be 6b 00 00 00       	mov    $0x6b,%esi
    a1bc:	31 c0                	xor    %eax,%eax
    a1be:	e8 0d 80 ff ff       	call   21d0 <snprintf@plt>
    a1c3:	83 c0 03             	add    $0x3,%eax
    a1c6:	59                   	pop    %rcx
    a1c7:	c3                   	ret
    a1c8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a1cf:	00 

000000000000a1d0 <fwp_now_ns>:
    a1d0:	48 83 ec 18          	sub    $0x18,%rsp
    a1d4:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    a1d9:	bf 01 00 00 00       	mov    $0x1,%edi
    a1de:	e8 4d 7f ff ff       	call   2130 <clock_gettime@plt>
    a1e3:	48 69 44 24 08 00 ca 	imul   $0x3b9aca00,0x8(%rsp),%rax
    a1ea:	9a 3b 
    a1ec:	48 03 44 24 10       	add    0x10(%rsp),%rax
    a1f1:	48 83 c4 18          	add    $0x18,%rsp
    a1f5:	c3                   	ret
    a1f6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    a1fd:	00 00 00 

000000000000a200 <fwp_ring_put>:
    a200:	55                   	push   %rbp
    a201:	41 57                	push   %r15
    a203:	41 56                	push   %r14
    a205:	41 55                	push   %r13
    a207:	41 54                	push   %r12
    a209:	53                   	push   %rbx
    a20a:	48 83 ec 38          	sub    $0x38,%rsp
    a20e:	48 89 3c 24          	mov    %rdi,(%rsp)
    a212:	48 85 f6             	test   %rsi,%rsi
    a215:	0f 84 27 01 00 00    	je     a342 <fwp_ring_put+0x142>
    a21b:	f6 05 36 bc 02 00 01 	testb  $0x1,0x2bc36(%rip)        # 35e58 <fwp_po_gone>
    a222:	0f 85 1a 01 00 00    	jne    a342 <fwp_ring_put+0x142>
    a228:	48 89 f3             	mov    %rsi,%rbx
    a22b:	4c 8b 3d 1e bc 02 00 	mov    0x2bc1e(%rip),%r15        # 35e50 <fwp_po_ring>
    a232:	49 8d 87 00 10 00 00 	lea    0x1000(%r15),%rax
    a239:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    a23e:	49 8d 87 c0 00 00 00 	lea    0xc0(%r15),%rax
    a245:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    a24a:	49 8d 87 c4 00 00 00 	lea    0xc4(%r15),%rax
    a251:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    a256:	49 8d 87 00 01 00 00 	lea    0x100(%r15),%rax
    a25d:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    a262:	49 8d 87 04 01 00 00 	lea    0x104(%r15),%rax
    a269:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    a26e:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    a273:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a27a:	84 00 00 00 00 00 
    a280:	4d 8b 67 40          	mov    0x40(%r15),%r12
    a284:	49 8b af 80 00 00 00 	mov    0x80(%r15),%rbp
    a28b:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    a28f:	4c 29 e5             	sub    %r12,%rbp
    a292:	4c 01 ed             	add    %r13,%rbp
    a295:	74 69                	je     a300 <fwp_ring_put+0x100>
    a297:	48 39 eb             	cmp    %rbp,%rbx
    a29a:	48 0f 42 eb          	cmovb  %rbx,%rbp
    a29e:	49 8d 7d ff          	lea    -0x1(%r13),%rdi
    a2a2:	4c 21 e7             	and    %r12,%rdi
    a2a5:	49 29 fd             	sub    %rdi,%r13
    a2a8:	4c 39 ed             	cmp    %r13,%rbp
    a2ab:	4c 0f 42 ed          	cmovb  %rbp,%r13
    a2af:	4c 01 f7             	add    %r14,%rdi
    a2b2:	48 89 5c 24 30       	mov    %rbx,0x30(%rsp)
    a2b7:	48 8b 1c 24          	mov    (%rsp),%rbx
    a2bb:	48 89 de             	mov    %rbx,%rsi
    a2be:	4c 89 ea             	mov    %r13,%rdx
    a2c1:	e8 6a 80 ff ff       	call   2330 <memcpy@plt>
    a2c6:	4a 8d 34 2b          	lea    (%rbx,%r13,1),%rsi
    a2ca:	48 89 ea             	mov    %rbp,%rdx
    a2cd:	4c 29 ea             	sub    %r13,%rdx
    a2d0:	4c 89 f7             	mov    %r14,%rdi
    a2d3:	e8 58 80 ff ff       	call   2330 <memcpy@plt>
    a2d8:	49 01 ec             	add    %rbp,%r12
    a2db:	4d 89 67 40          	mov    %r12,0x40(%r15)
    a2df:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    a2e4:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    a2e9:	e8 82 02 00 00       	call   a570 <fwp_ring_wake>
    a2ee:	48 01 eb             	add    %rbp,%rbx
    a2f1:	48 89 1c 24          	mov    %rbx,(%rsp)
    a2f5:	48 8b 5c 24 30       	mov    0x30(%rsp),%rbx
    a2fa:	48 29 eb             	sub    %rbp,%rbx
    a2fd:	eb 31                	jmp    a330 <fwp_ring_put+0x130>
    a2ff:	90                   	nop
    a300:	44 8b 05 b9 b9 00 00 	mov    0xb9b9(%rip),%r8d        # 15cc0 <fwp_po_sock>
    a307:	4c 89 ff             	mov    %r15,%rdi
    a30a:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    a30f:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    a314:	48 8d 0d 35 02 00 00 	lea    0x235(%rip),%rcx        # a550 <fwp_ring_has_space>
    a31b:	e8 f0 00 00 00       	call   a410 <fwp_ring_wait>
    a320:	85 c0                	test   %eax,%eax
    a322:	75 0c                	jne    a330 <fwp_ring_put+0x130>
    a324:	c6 05 2d bb 02 00 01 	movb   $0x1,0x2bb2d(%rip)        # 35e58 <fwp_po_gone>
    a32b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    a330:	48 85 db             	test   %rbx,%rbx
    a333:	74 0d                	je     a342 <fwp_ring_put+0x142>
    a335:	f6 05 1c bb 02 00 01 	testb  $0x1,0x2bb1c(%rip)        # 35e58 <fwp_po_gone>
    a33c:	0f 84 3e ff ff ff    	je     a280 <fwp_ring_put+0x80>
    a342:	48 83 c4 38          	add    $0x38,%rsp
    a346:	5b                   	pop    %rbx
    a347:	41 5c                	pop    %r12
    a349:	41 5d                	pop    %r13
    a34b:	41 5e                	pop    %r14
    a34d:	41 5f                	pop    %r15
    a34f:	5d                   	pop    %rbp
    a350:	c3                   	ret
    a351:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a358:	0f 1f 84 00 00 00 00 
    a35f:	00 

000000000000a360 <fwp_po_flush_sock>:
    a360:	48 8b 15 e1 ba 01 00 	mov    0x1bae1(%rip),%rdx        # 25e48 <fwp_po_len>
    a367:	48 85 d2             	test   %rdx,%rdx
    a36a:	74 17                	je     a383 <fwp_po_flush_sock+0x23>
    a36c:	50                   	push   %rax
    a36d:	8b 3d 4d b9 00 00    	mov    0xb94d(%rip),%edi        # 15cc0 <fwp_po_sock>
    a373:	48 8d 35 d6 ba 01 00 	lea    0x1bad6(%rip),%rsi        # 25e50 <fwp_po_buf>
    a37a:	e8 11 00 00 00       	call   a390 <fwp_po_write_raw>
    a37f:	48 83 c4 08          	add    $0x8,%rsp
    a383:	48 c7 05 ba ba 01 00 	movq   $0x0,0x1baba(%rip)        # 25e48 <fwp_po_len>
    a38a:	00 00 00 00 
    a38e:	c3                   	ret
    a38f:	90                   	nop

000000000000a390 <fwp_po_write_raw>:
    a390:	48 85 d2             	test   %rdx,%rdx
    a393:	74 70                	je     a405 <fwp_po_write_raw+0x75>
    a395:	f6 05 bc ba 02 00 01 	testb  $0x1,0x2babc(%rip)        # 35e58 <fwp_po_gone>
    a39c:	75 67                	jne    a405 <fwp_po_write_raw+0x75>
    a39e:	55                   	push   %rbp
    a39f:	41 56                	push   %r14
    a3a1:	53                   	push   %rbx
    a3a2:	48 89 d3             	mov    %rdx,%rbx
    a3a5:	49 89 f6             	mov    %rsi,%r14
    a3a8:	89 fd                	mov    %edi,%ebp
    a3aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    a3b0:	89 ef                	mov    %ebp,%edi
    a3b2:	4c 89 f6             	mov    %r14,%rsi
    a3b5:	48 89 da             	mov    %rbx,%rdx
    a3b8:	b9 00 40 00 00       	mov    $0x4000,%ecx
    a3bd:	e8 de 7d ff ff       	call   21a0 <send@plt>
    a3c2:	48 85 c0             	test   %rax,%rax
    a3c5:	78 19                	js     a3e0 <fwp_po_write_raw+0x50>
    a3c7:	74 31                	je     a3fa <fwp_po_write_raw+0x6a>
    a3c9:	49 01 c6             	add    %rax,%r14
    a3cc:	48 29 c3             	sub    %rax,%rbx
    a3cf:	eb 19                	jmp    a3ea <fwp_po_write_raw+0x5a>
    a3d1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a3d8:	0f 1f 84 00 00 00 00 
    a3df:	00 
    a3e0:	e8 9b 7c ff ff       	call   2080 <__errno_location@plt>
    a3e5:	83 38 04             	cmpl   $0x4,(%rax)
    a3e8:	75 10                	jne    a3fa <fwp_po_write_raw+0x6a>
    a3ea:	48 85 db             	test   %rbx,%rbx
    a3ed:	74 12                	je     a401 <fwp_po_write_raw+0x71>
    a3ef:	f6 05 62 ba 02 00 01 	testb  $0x1,0x2ba62(%rip)        # 35e58 <fwp_po_gone>
    a3f6:	74 b8                	je     a3b0 <fwp_po_write_raw+0x20>
    a3f8:	eb 07                	jmp    a401 <fwp_po_write_raw+0x71>
    a3fa:	c6 05 57 ba 02 00 01 	movb   $0x1,0x2ba57(%rip)        # 35e58 <fwp_po_gone>
    a401:	5b                   	pop    %rbx
    a402:	41 5e                	pop    %r14
    a404:	5d                   	pop    %rbp
    a405:	c3                   	ret
    a406:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    a40d:	00 00 00 

000000000000a410 <fwp_ring_wait>:
    a410:	55                   	push   %rbp
    a411:	41 57                	push   %r15
    a413:	41 56                	push   %r14
    a415:	41 55                	push   %r13
    a417:	41 54                	push   %r12
    a419:	53                   	push   %rbx
    a41a:	50                   	push   %rax
    a41b:	44 89 44 24 04       	mov    %r8d,0x4(%rsp)
    a420:	49 89 cf             	mov    %rcx,%r15
    a423:	49 89 d6             	mov    %rdx,%r14
    a426:	49 89 f4             	mov    %rsi,%r12
    a429:	49 89 fd             	mov    %rdi,%r13
    a42c:	8b 0d 92 b8 00 00    	mov    0xb892(%rip),%ecx        # 15cc4 <fwp_ring_spin>
    a432:	85 c9                	test   %ecx,%ecx
    a434:	78 06                	js     a43c <fwp_ring_wait+0x2c>
    a436:	85 c9                	test   %ecx,%ecx
    a438:	75 1f                	jne    a459 <fwp_ring_wait+0x49>
    a43a:	eb 6f                	jmp    a4ab <fwp_ring_wait+0x9b>
    a43c:	bf 54 00 00 00       	mov    $0x54,%edi
    a441:	e8 ea 7f ff ff       	call   2430 <sysconf@plt>
    a446:	31 c9                	xor    %ecx,%ecx
    a448:	48 83 f8 02          	cmp    $0x2,%rax
    a44c:	0f 9d c1             	setge  %cl
    a44f:	89 0d 6f b8 00 00    	mov    %ecx,0xb86f(%rip)        # 15cc4 <fwp_ring_spin>
    a455:	85 c9                	test   %ecx,%ecx
    a457:	74 52                	je     a4ab <fwp_ring_wait+0x9b>
    a459:	4c 89 ef             	mov    %r13,%rdi
    a45c:	41 ff d7             	call   *%r15
    a45f:	89 c1                	mov    %eax,%ecx
    a461:	b8 01 00 00 00       	mov    $0x1,%eax
    a466:	85 c9                	test   %ecx,%ecx
    a468:	75 6a                	jne    a4d4 <fwp_ring_wait+0xc4>
    a46a:	bd 01 00 00 00       	mov    $0x1,%ebp
    a46f:	31 db                	xor    %ebx,%ebx
    a471:	eb 19                	jmp    a48c <fwp_ring_wait+0x7c>
    a473:	48 05 50 c3 00 00    	add    $0xc350,%rax
    a479:	48 89 c3             	mov    %rax,%rbx
    a47c:	0f 1f 40 00          	nopl   0x0(%rax)
    a480:	ff c5                	inc    %ebp
    a482:	4c 89 ef             	mov    %r13,%rdi
    a485:	41 ff d7             	call   *%r15
    a488:	85 c0                	test   %eax,%eax
    a48a:	75 43                	jne    a4cf <fwp_ring_wait+0xbf>
    a48c:	e8 ff 00 00 00       	call   a590 <fwp_cpu_relax>
    a491:	40 f6 c5 3f          	test   $0x3f,%bpl
    a495:	75 e9                	jne    a480 <fwp_ring_wait+0x70>
    a497:	e8 b4 7d ff ff       	call   2250 <sched_yield@plt>
    a49c:	e8 2f fd ff ff       	call   a1d0 <fwp_now_ns>
    a4a1:	48 85 db             	test   %rbx,%rbx
    a4a4:	74 cd                	je     a473 <fwp_ring_wait+0x63>
    a4a6:	48 39 d8             	cmp    %rbx,%rax
    a4a9:	7e d5                	jle    a480 <fwp_ring_wait+0x70>
    a4ab:	41 8b 2c 24          	mov    (%r12),%ebp
    a4af:	b8 01 00 00 00       	mov    $0x1,%eax
    a4b4:	41 87 06             	xchg   %eax,(%r14)
    a4b7:	0f ae f0             	mfence
    a4ba:	4c 89 ef             	mov    %r13,%rdi
    a4bd:	41 ff d7             	call   *%r15
    a4c0:	85 c0                	test   %eax,%eax
    a4c2:	8b 5c 24 04          	mov    0x4(%rsp),%ebx
    a4c6:	74 41                	je     a509 <fwp_ring_wait+0xf9>
    a4c8:	41 c7 06 00 00 00 00 	movl   $0x0,(%r14)
    a4cf:	b8 01 00 00 00       	mov    $0x1,%eax
    a4d4:	48 83 c4 08          	add    $0x8,%rsp
    a4d8:	5b                   	pop    %rbx
    a4d9:	41 5c                	pop    %r12
    a4db:	41 5d                	pop    %r13
    a4dd:	41 5e                	pop    %r14
    a4df:	41 5f                	pop    %r15
    a4e1:	5d                   	pop    %rbp
    a4e2:	c3                   	ret
    a4e3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a4ea:	84 00 00 00 00 00 
    a4f0:	41 8b 2c 24          	mov    (%r12),%ebp
    a4f4:	b8 01 00 00 00       	mov    $0x1,%eax
    a4f9:	41 87 06             	xchg   %eax,(%r14)
    a4fc:	0f ae f0             	mfence
    a4ff:	4c 89 ef             	mov    %r13,%rdi
    a502:	41 ff d7             	call   *%r15
    a505:	85 c0                	test   %eax,%eax
    a507:	75 bf                	jne    a4c8 <fwp_ring_wait+0xb8>
    a509:	4c 89 e7             	mov    %r12,%rdi
    a50c:	31 f6                	xor    %esi,%esi
    a50e:	89 ea                	mov    %ebp,%edx
    a510:	b9 64 00 00 00       	mov    $0x64,%ecx
    a515:	e8 86 00 00 00       	call   a5a0 <fwp_futex>
    a51a:	48 89 c5             	mov    %rax,%rbp
    a51d:	41 c7 06 00 00 00 00 	movl   $0x0,(%r14)
    a524:	4c 89 ef             	mov    %r13,%rdi
    a527:	41 ff d7             	call   *%r15
    a52a:	85 c0                	test   %eax,%eax
    a52c:	75 a1                	jne    a4cf <fwp_ring_wait+0xbf>
    a52e:	48 85 ed             	test   %rbp,%rbp
    a531:	74 bd                	je     a4f0 <fwp_ring_wait+0xe0>
    a533:	e8 48 7b ff ff       	call   2080 <__errno_location@plt>
    a538:	83 38 6e             	cmpl   $0x6e,(%rax)
    a53b:	75 b3                	jne    a4f0 <fwp_ring_wait+0xe0>
    a53d:	89 df                	mov    %ebx,%edi
    a53f:	e8 cc 00 00 00       	call   a610 <fwp_sock_gone>
    a544:	85 c0                	test   %eax,%eax
    a546:	74 a8                	je     a4f0 <fwp_ring_wait+0xe0>
    a548:	31 c0                	xor    %eax,%eax
    a54a:	eb 88                	jmp    a4d4 <fwp_ring_wait+0xc4>
    a54c:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000a550 <fwp_ring_has_space>:
    a550:	48 8b 8f 80 00 00 00 	mov    0x80(%rdi),%rcx
    a557:	48 2b 4f 40          	sub    0x40(%rdi),%rcx
    a55b:	31 c0                	xor    %eax,%eax
    a55d:	48 03 4f 08          	add    0x8(%rdi),%rcx
    a561:	0f 95 c0             	setne  %al
    a564:	c3                   	ret
    a565:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a56c:	00 00 00 00 

000000000000a570 <fwp_ring_wake>:
    a570:	0f ae f0             	mfence
    a573:	8b 06                	mov    (%rsi),%eax
    a575:	85 c0                	test   %eax,%eax
    a577:	74 14                	je     a58d <fwp_ring_wake+0x1d>
    a579:	f0 ff 07             	lock incl (%rdi)
    a57c:	be 01 00 00 00       	mov    $0x1,%esi
    a581:	ba ff ff ff 7f       	mov    $0x7fffffff,%edx
    a586:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    a58b:	eb 13                	jmp    a5a0 <fwp_futex>
    a58d:	c3                   	ret
    a58e:	66 90                	xchg   %ax,%ax

000000000000a590 <fwp_cpu_relax>:
    a590:	f3 90                	pause
    a592:	c3                   	ret
    a593:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a59a:	84 00 00 00 00 00 

000000000000a5a0 <fwp_futex>:
    a5a0:	48 83 ec 18          	sub    $0x18,%rsp
    a5a4:	89 c8                	mov    %ecx,%eax
    a5a6:	89 d1                	mov    %edx,%ecx
    a5a8:	89 f2                	mov    %esi,%edx
    a5aa:	48 89 fe             	mov    %rdi,%rsi
    a5ad:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
    a5b4:	00 00 
    a5b6:	48 98                	cltq
    a5b8:	48 69 f8 d3 4d 62 10 	imul   $0x10624dd3,%rax,%rdi
    a5bf:	49 89 f8             	mov    %rdi,%r8
    a5c2:	49 c1 e8 3f          	shr    $0x3f,%r8
    a5c6:	48 c1 ff 26          	sar    $0x26,%rdi
    a5ca:	44 01 c7             	add    %r8d,%edi
    a5cd:	69 ff e8 03 00 00    	imul   $0x3e8,%edi,%edi
    a5d3:	41 89 c0             	mov    %eax,%r8d
    a5d6:	41 29 f8             	sub    %edi,%r8d
    a5d9:	41 69 f8 40 42 0f 00 	imul   $0xf4240,%r8d,%edi
    a5e0:	48 63 ff             	movslq %edi,%rdi
    a5e3:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    a5e8:	31 ff                	xor    %edi,%edi
    a5ea:	85 c0                	test   %eax,%eax
    a5ec:	4c 8d 44 24 08       	lea    0x8(%rsp),%r8
    a5f1:	4c 0f 48 c7          	cmovs  %rdi,%r8
    a5f5:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    a5fc:	bf ca 00 00 00       	mov    $0xca,%edi
    a601:	45 31 c9             	xor    %r9d,%r9d
    a604:	31 c0                	xor    %eax,%eax
    a606:	e8 f5 7c ff ff       	call   2300 <syscall@plt>
    a60b:	48 83 c4 18          	add    $0x18,%rsp
    a60f:	c3                   	ret

000000000000a610 <fwp_sock_gone>:
    a610:	55                   	push   %rbp
    a611:	53                   	push   %rbx
    a612:	48 83 ec 18          	sub    $0x18,%rsp
    a616:	89 fb                	mov    %edi,%ebx
    a618:	89 7c 24 10          	mov    %edi,0x10(%rsp)
    a61c:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%rsp)
    a623:	00 
    a624:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    a629:	31 ed                	xor    %ebp,%ebp
    a62b:	be 01 00 00 00       	mov    $0x1,%esi
    a630:	31 d2                	xor    %edx,%edx
    a632:	e8 89 7d ff ff       	call   23c0 <poll@plt>
    a637:	85 c0                	test   %eax,%eax
    a639:	7e 2b                	jle    a666 <fwp_sock_gone+0x56>
    a63b:	bd 01 00 00 00       	mov    $0x1,%ebp
    a640:	f6 44 24 16 18       	testb  $0x18,0x16(%rsp)
    a645:	75 1f                	jne    a666 <fwp_sock_gone+0x56>
    a647:	48 8d 74 24 0f       	lea    0xf(%rsp),%rsi
    a64c:	ba 01 00 00 00       	mov    $0x1,%edx
    a651:	89 df                	mov    %ebx,%edi
    a653:	b9 42 00 00 00       	mov    $0x42,%ecx
    a658:	e8 03 7a ff ff       	call   2060 <recv@plt>
    a65d:	31 ed                	xor    %ebp,%ebp
    a65f:	48 85 c0             	test   %rax,%rax
    a662:	40 0f 94 c5          	sete   %bpl
    a666:	89 e8                	mov    %ebp,%eax
    a668:	48 83 c4 18          	add    $0x18,%rsp
    a66c:	5b                   	pop    %rbx
    a66d:	5d                   	pop    %rbp
    a66e:	c3                   	ret
    a66f:	90                   	nop

000000000000a670 <fwp_pipe_poll>:
    a670:	83 3d 45 b6 00 00 00 	cmpl   $0x0,0xb645(%rip)        # 15cbc <fwp_po_listen>
    a677:	0f 88 9b 01 00 00    	js     a818 <fwp_pipe_poll+0x1a8>
    a67d:	55                   	push   %rbp
    a67e:	41 57                	push   %r15
    a680:	41 56                	push   %r14
    a682:	53                   	push   %rbx
    a683:	48 83 ec 28          	sub    $0x28,%rsp
    a687:	e8 44 fb ff ff       	call   a1d0 <fwp_now_ns>
    a68c:	48 3b 05 cd b7 02 00 	cmp    0x2b7cd(%rip),%rax        # 35e60 <fwp_po_next_check>
    a693:	0f 8c 75 01 00 00    	jl     a80e <fwp_pipe_poll+0x19e>
    a699:	49 89 c6             	mov    %rax,%r14
    a69c:	48 05 40 42 0f 00    	add    $0xf4240,%rax
    a6a2:	48 89 05 b7 b7 02 00 	mov    %rax,0x2b7b7(%rip)        # 35e60 <fwp_po_next_check>
    a6a9:	8b 3d 0d b6 00 00    	mov    0xb60d(%rip),%edi        # 15cbc <fwp_po_listen>
    a6af:	31 f6                	xor    %esi,%esi
    a6b1:	31 d2                	xor    %edx,%edx
    a6b3:	e8 88 7d ff ff       	call   2440 <accept@plt>
    a6b8:	85 c0                	test   %eax,%eax
    a6ba:	0f 88 10 01 00 00    	js     a7d0 <fwp_pipe_poll+0x160>
    a6c0:	89 c3                	mov    %eax,%ebx
    a6c2:	8b 3d f4 b5 00 00    	mov    0xb5f4(%rip),%edi        # 15cbc <fwp_po_listen>
    a6c8:	e8 63 7b ff ff       	call   2230 <close@plt>
    a6cd:	c7 05 e5 b5 00 00 ff 	movl   $0xffffffff,0xb5e5(%rip)        # 15cbc <fwp_po_listen>
    a6d4:	ff ff ff 
    a6d7:	89 df                	mov    %ebx,%edi
    a6d9:	be 02 00 00 00       	mov    $0x2,%esi
    a6de:	ba 01 00 00 00       	mov    $0x1,%edx
    a6e3:	31 c0                	xor    %eax,%eax
    a6e5:	e8 36 7a ff ff       	call   2120 <fcntl@plt>
    a6ea:	89 df                	mov    %ebx,%edi
    a6ec:	be 03 00 00 00       	mov    $0x3,%esi
    a6f1:	31 c0                	xor    %eax,%eax
    a6f3:	e8 28 7a ff ff       	call   2120 <fcntl@plt>
    a6f8:	25 ff f7 ff ff       	and    $0xfffff7ff,%eax
    a6fd:	89 df                	mov    %ebx,%edi
    a6ff:	be 04 00 00 00       	mov    $0x4,%esi
    a704:	89 c2                	mov    %eax,%edx
    a706:	31 c0                	xor    %eax,%eax
    a708:	e8 13 7a ff ff       	call   2120 <fcntl@plt>
    a70d:	c7 44 24 18 0c 00 00 	movl   $0xc,0x18(%rsp)
    a714:	00 
    a715:	89 5c 24 10          	mov    %ebx,0x10(%rsp)
    a719:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%rsp)
    a720:	00 
    a721:	48 8d 4c 24 1c       	lea    0x1c(%rsp),%rcx
    a726:	4c 8d 44 24 18       	lea    0x18(%rsp),%r8
    a72b:	89 df                	mov    %ebx,%edi
    a72d:	be 01 00 00 00       	mov    $0x1,%esi
    a732:	ba 11 00 00 00       	mov    $0x11,%edx
    a737:	e8 64 7b ff ff       	call   22a0 <getsockopt@plt>
    a73c:	85 c0                	test   %eax,%eax
    a73e:	0f 85 c3 00 00 00    	jne    a807 <fwp_pipe_poll+0x197>
    a744:	8b 6c 24 20          	mov    0x20(%rsp),%ebp
    a748:	e8 33 7a ff ff       	call   2180 <getuid@plt>
    a74d:	39 c5                	cmp    %eax,%ebp
    a74f:	0f 85 b2 00 00 00    	jne    a807 <fwp_pipe_poll+0x197>
    a755:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    a75a:	be 01 00 00 00       	mov    $0x1,%esi
    a75f:	ba e8 03 00 00       	mov    $0x3e8,%edx
    a764:	e8 57 7c ff ff       	call   23c0 <poll@plt>
    a769:	85 c0                	test   %eax,%eax
    a76b:	0f 8e 96 00 00 00    	jle    a807 <fwp_pipe_poll+0x197>
    a771:	48 8d 74 24 03       	lea    0x3(%rsp),%rsi
    a776:	ba 05 00 00 00       	mov    $0x5,%edx
    a77b:	89 df                	mov    %ebx,%edi
    a77d:	31 c9                	xor    %ecx,%ecx
    a77f:	e8 dc 78 ff ff       	call   2060 <recv@plt>
    a784:	48 85 c0             	test   %rax,%rax
    a787:	7e 7e                	jle    a807 <fwp_pipe_poll+0x197>
    a789:	49 89 c6             	mov    %rax,%r14
    a78c:	4c 8d 7c 24 10       	lea    0x10(%rsp),%r15
    a791:	49 83 fe 04          	cmp    $0x4,%r14
    a795:	77 59                	ja     a7f0 <fwp_pipe_poll+0x180>
    a797:	be 01 00 00 00       	mov    $0x1,%esi
    a79c:	4c 89 ff             	mov    %r15,%rdi
    a79f:	ba e8 03 00 00       	mov    $0x3e8,%edx
    a7a4:	e8 17 7c ff ff       	call   23c0 <poll@plt>
    a7a9:	85 c0                	test   %eax,%eax
    a7ab:	7e 5a                	jle    a807 <fwp_pipe_poll+0x197>
    a7ad:	4a 8d 34 34          	lea    (%rsp,%r14,1),%rsi
    a7b1:	48 83 c6 03          	add    $0x3,%rsi
    a7b5:	ba 05 00 00 00       	mov    $0x5,%edx
    a7ba:	4c 29 f2             	sub    %r14,%rdx
    a7bd:	89 df                	mov    %ebx,%edi
    a7bf:	31 c9                	xor    %ecx,%ecx
    a7c1:	e8 9a 78 ff ff       	call   2060 <recv@plt>
    a7c6:	49 01 c6             	add    %rax,%r14
    a7c9:	48 85 c0             	test   %rax,%rax
    a7cc:	7f c3                	jg     a791 <fwp_pipe_poll+0x121>
    a7ce:	eb 37                	jmp    a807 <fwp_pipe_poll+0x197>
    a7d0:	4c 3b 35 61 b6 01 00 	cmp    0x1b661(%rip),%r14        # 25e38 <fwp_po_give_up>
    a7d7:	7e 35                	jle    a80e <fwp_pipe_poll+0x19e>
    a7d9:	8b 3d dd b4 00 00    	mov    0xb4dd(%rip),%edi        # 15cbc <fwp_po_listen>
    a7df:	e8 4c 7a ff ff       	call   2230 <close@plt>
    a7e4:	c7 05 ce b4 00 00 ff 	movl   $0xffffffff,0xb4ce(%rip)        # 15cbc <fwp_po_listen>
    a7eb:	ff ff ff 
    a7ee:	eb 1e                	jmp    a80e <fwp_pipe_poll+0x19e>
    a7f0:	81 7c 24 03 46 57 50 	cmpl   $0x54505746,0x3(%rsp)
    a7f7:	54 
    a7f8:	75 0d                	jne    a807 <fwp_pipe_poll+0x197>
    a7fa:	0f b6 44 24 07       	movzbl 0x7(%rsp),%eax
    a7ff:	8d 48 fd             	lea    -0x3(%rax),%ecx
    a802:	80 f9 fd             	cmp    $0xfd,%cl
    a805:	77 12                	ja     a819 <fwp_pipe_poll+0x1a9>
    a807:	89 df                	mov    %ebx,%edi
    a809:	e8 22 7a ff ff       	call   2230 <close@plt>
    a80e:	48 83 c4 28          	add    $0x28,%rsp
    a812:	5b                   	pop    %rbx
    a813:	41 5e                	pop    %r14
    a815:	41 5f                	pop    %r15
    a817:	5d                   	pop    %rbp
    a818:	c3                   	ret
    a819:	89 1d a1 b4 00 00    	mov    %ebx,0xb4a1(%rip)        # 15cc0 <fwp_po_sock>
    a81f:	bb 01 00 00 00       	mov    $0x1,%ebx
    a824:	3c 02                	cmp    $0x2,%al
    a826:	75 10                	jne    a838 <fwp_pipe_poll+0x1c8>
    a828:	e8 53 00 00 00       	call   a880 <fwp_po_make_ring>
    a82d:	83 f8 01             	cmp    $0x1,%eax
    a830:	bb 02 00 00 00       	mov    $0x2,%ebx
    a835:	83 db 00             	sbb    $0x0,%ebx
    a838:	c7 44 24 08 02 01 00 	movl   $0x102,0x8(%rsp)
    a83f:	00 
    a840:	c6 44 24 0c 00       	movb   $0x0,0xc(%rsp)
    a845:	88 5c 24 0d          	mov    %bl,0xd(%rsp)
    a849:	4c 8b 35 68 97 00 00 	mov    0x9768(%rip),%r14        # 13fb8 <stdout@GLIBC_2.2.5>
    a850:	49 8b 0e             	mov    (%r14),%rcx
    a853:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    a858:	be 01 00 00 00       	mov    $0x1,%esi
    a85d:	ba 06 00 00 00       	mov    $0x6,%edx
    a862:	e8 39 7c ff ff       	call   24a0 <fwrite@plt>
    a867:	49 8b 3e             	mov    (%r14),%rdi
    a86a:	e8 e1 7a ff ff       	call   2350 <fflush@plt>
    a86f:	89 1d cb b5 01 00    	mov    %ebx,0x1b5cb(%rip)        # 25e40 <fwp_po_kind>
    a875:	eb 97                	jmp    a80e <fwp_pipe_poll+0x19e>
    a877:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    a87e:	00 00 

000000000000a880 <fwp_po_make_ring>:
    a880:	55                   	push   %rbp
    a881:	41 57                	push   %r15
    a883:	41 56                	push   %r14
    a885:	53                   	push   %rbx
    a886:	48 83 ec 68          	sub    $0x68,%rsp
    a88a:	48 8d 35 65 4a 00 00 	lea    0x4a65(%rip),%rsi        # f2f6 <exec_in_fp0+0xca6>
    a891:	31 ed                	xor    %ebp,%ebp
    a893:	bf 3f 01 00 00       	mov    $0x13f,%edi
    a898:	ba 01 00 00 00       	mov    $0x1,%edx
    a89d:	31 c0                	xor    %eax,%eax
    a89f:	e8 5c 7a ff ff       	call   2300 <syscall@plt>
    a8a4:	48 89 c3             	mov    %rax,%rbx
    a8a7:	85 db                	test   %ebx,%ebx
    a8a9:	78 17                	js     a8c2 <fwp_po_make_ring+0x42>
    a8ab:	be 00 10 10 00       	mov    $0x101000,%esi
    a8b0:	89 df                	mov    %ebx,%edi
    a8b2:	e8 29 79 ff ff       	call   21e0 <ftruncate@plt>
    a8b7:	85 c0                	test   %eax,%eax
    a8b9:	74 14                	je     a8cf <fwp_po_make_ring+0x4f>
    a8bb:	89 df                	mov    %ebx,%edi
    a8bd:	e8 6e 79 ff ff       	call   2230 <close@plt>
    a8c2:	89 e8                	mov    %ebp,%eax
    a8c4:	48 83 c4 68          	add    $0x68,%rsp
    a8c8:	5b                   	pop    %rbx
    a8c9:	41 5e                	pop    %r14
    a8cb:	41 5f                	pop    %r15
    a8cd:	5d                   	pop    %rbp
    a8ce:	c3                   	ret
    a8cf:	be 00 10 10 00       	mov    $0x101000,%esi
    a8d4:	31 ff                	xor    %edi,%edi
    a8d6:	ba 03 00 00 00       	mov    $0x3,%edx
    a8db:	b9 01 00 00 00       	mov    $0x1,%ecx
    a8e0:	41 89 d8             	mov    %ebx,%r8d
    a8e3:	45 31 c9             	xor    %r9d,%r9d
    a8e6:	e8 a5 78 ff ff       	call   2190 <mmap@plt>
    a8eb:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    a8ef:	74 ca                	je     a8bb <fwp_po_make_ring+0x3b>
    a8f1:	49 89 c6             	mov    %rax,%r14
    a8f4:	48 b8 46 57 50 53 01 	movabs $0x153505746,%rax
    a8fb:	00 00 00 
    a8fe:	49 89 06             	mov    %rax,(%r14)
    a901:	49 c7 46 08 00 00 10 	movq   $0x100000,0x8(%r14)
    a908:	00 
    a909:	c6 44 24 07 53       	movb   $0x53,0x7(%rsp)
    a90e:	48 8d 44 24 07       	lea    0x7(%rsp),%rax
    a913:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    a918:	48 c7 44 24 28 01 00 	movq   $0x1,0x28(%rsp)
    a91f:	00 00 
    a921:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
    a928:	00 00 
    a92a:	0f 57 c0             	xorps  %xmm0,%xmm0
    a92d:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    a932:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
    a937:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    a93c:	48 c7 44 24 60 00 00 	movq   $0x0,0x60(%rsp)
    a943:	00 00 
    a945:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    a94a:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    a94f:	48 c7 44 24 48 01 00 	movq   $0x1,0x48(%rsp)
    a956:	00 00 
    a958:	48 8d 44 24 08       	lea    0x8(%rsp),%rax
    a95d:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    a962:	48 c7 44 24 58 18 00 	movq   $0x18,0x58(%rsp)
    a969:	00 00 
    a96b:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
    a972:	00 00 00 
    a975:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    a97a:	48 c7 44 24 08 14 00 	movq   $0x14,0x8(%rsp)
    a981:	00 00 
    a983:	89 5c 24 18          	mov    %ebx,0x18(%rsp)
    a987:	8b 3d 33 b3 00 00    	mov    0xb333(%rip),%edi        # 15cc0 <fwp_po_sock>
    a98d:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
    a992:	ba 00 40 00 00       	mov    $0x4000,%edx
    a997:	e8 24 77 ff ff       	call   20c0 <sendmsg@plt>
    a99c:	49 89 c7             	mov    %rax,%r15
    a99f:	89 df                	mov    %ebx,%edi
    a9a1:	e8 8a 78 ff ff       	call   2230 <close@plt>
    a9a6:	49 83 ff 01          	cmp    $0x1,%r15
    a9aa:	75 11                	jne    a9bd <fwp_po_make_ring+0x13d>
    a9ac:	4c 89 35 9d b4 02 00 	mov    %r14,0x2b49d(%rip)        # 35e50 <fwp_po_ring>
    a9b3:	bd 01 00 00 00       	mov    $0x1,%ebp
    a9b8:	e9 05 ff ff ff       	jmp    a8c2 <fwp_po_make_ring+0x42>
    a9bd:	be 00 10 10 00       	mov    $0x101000,%esi
    a9c2:	4c 89 f7             	mov    %r14,%rdi
    a9c5:	e8 c6 79 ff ff       	call   2390 <munmap@plt>
    a9ca:	31 ed                	xor    %ebp,%ebp
    a9cc:	e9 f1 fe ff ff       	jmp    a8c2 <fwp_po_make_ring+0x42>
    a9d1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a9d8:	0f 1f 84 00 00 00 00 
    a9df:	00 

000000000000a9e0 <fwp_apply>:
    a9e0:	55                   	push   %rbp
    a9e1:	48 89 e5             	mov    %rsp,%rbp
    a9e4:	41 57                	push   %r15
    a9e6:	41 56                	push   %r14
    a9e8:	41 55                	push   %r13
    a9ea:	41 54                	push   %r12
    a9ec:	53                   	push   %rbx
    a9ed:	48 83 ec 18          	sub    $0x18,%rsp
    a9f1:	48 89 f3             	mov    %rsi,%rbx
    a9f4:	49 89 ff             	mov    %rdi,%r15
    a9f7:	be 01 00 00 00       	mov    $0x1,%esi
    a9fc:	eb 1e                	jmp    aa1c <fwp_apply+0x3c>
    a9fe:	66 90                	xchg   %ax,%ax
    aa00:	4a 8d 1c f3          	lea    (%rbx,%r14,8),%rbx
    aa04:	31 c9                	xor    %ecx,%ecx
    aa06:	49 89 c7             	mov    %rax,%r15
    aa09:	4c 8b 75 c8          	mov    -0x38(%rbp),%r14
    aa0d:	48 8b 65 c0          	mov    -0x40(%rbp),%rsp
    aa11:	89 d6                	mov    %edx,%esi
    aa13:	83 f9 01             	cmp    $0x1,%ecx
    aa16:	0f 84 ff 03 00 00    	je     ae1b <fwp_apply+0x43b>
    aa1c:	48 8b 05 7d b3 00 00 	mov    0xb37d(%rip),%rax        # 15da0 <fwp_fns>
    aa23:	41 8b 0f             	mov    (%r15),%ecx
    aa26:	45 8b 67 04          	mov    0x4(%r15),%r12d
    aa2a:	48 c1 e1 05          	shl    $0x5,%rcx
    aa2e:	44 8b 2c 08          	mov    (%rax,%rcx,1),%r13d
    aa32:	4d 85 e4             	test   %r12,%r12
    aa35:	75 39                	jne    aa70 <fwp_apply+0x90>
    aa37:	41 8d 55 ff          	lea    -0x1(%r13),%edx
    aa3b:	39 f2                	cmp    %esi,%edx
    aa3d:	73 31                	jae    aa70 <fwp_apply+0x90>
    aa3f:	49 89 f7             	mov    %rsi,%r15
    aa42:	48 89 df             	mov    %rbx,%rdi
    aa45:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    aa49:	4c 89 fe             	mov    %r15,%rsi
    aa4c:	49 89 c7             	mov    %rax,%r15
    aa4f:	44 39 ee             	cmp    %r13d,%esi
    aa52:	0f 84 c0 03 00 00    	je     ae18 <fwp_apply+0x438>
    aa58:	4a 8d 1c eb          	lea    (%rbx,%r13,8),%rbx
    aa5c:	44 29 ee             	sub    %r13d,%esi
    aa5f:	b9 03 00 00 00       	mov    $0x3,%ecx
    aa64:	83 f9 01             	cmp    $0x1,%ecx
    aa67:	75 b3                	jne    aa1c <fwp_apply+0x3c>
    aa69:	e9 ad 03 00 00       	jmp    ae1b <fwp_apply+0x43b>
    aa6e:	66 90                	xchg   %ax,%ax
    aa70:	4c 89 75 c8          	mov    %r14,-0x38(%rbp)
    aa74:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    aa78:	45 8d 34 34          	lea    (%r12,%rsi,1),%r14d
    aa7c:	45 39 ee             	cmp    %r13d,%r14d
    aa7f:	0f 82 1a 02 00 00    	jb     ac9f <fwp_apply+0x2bf>
    aa85:	48 89 65 c0          	mov    %rsp,-0x40(%rbp)
    aa89:	45 89 eb             	mov    %r13d,%r11d
    aa8c:	41 83 fd 02          	cmp    $0x2,%r13d
    aa90:	ba 01 00 00 00       	mov    $0x1,%edx
    aa95:	41 0f 43 d5          	cmovae %r13d,%edx
    aa99:	48 8d 14 d5 0f 00 00 	lea    0xf(,%rdx,8),%rdx
    aaa0:	00 
    aaa1:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
    aaa5:	48 89 e7             	mov    %rsp,%rdi
    aaa8:	48 29 d7             	sub    %rdx,%rdi
    aaab:	48 89 fc             	mov    %rdi,%rsp
    aaae:	4d 85 e4             	test   %r12,%r12
    aab1:	0f 84 c9 00 00 00    	je     ab80 <fwp_apply+0x1a0>
    aab7:	41 83 fc 04          	cmp    $0x4,%r12d
    aabb:	72 10                	jb     aacd <fwp_apply+0xed>
    aabd:	48 89 fa             	mov    %rdi,%rdx
    aac0:	4c 29 fa             	sub    %r15,%rdx
    aac3:	48 83 c2 f8          	add    $0xfffffffffffffff8,%rdx
    aac7:	48 83 fa 20          	cmp    $0x20,%rdx
    aacb:	73 65                	jae    ab32 <fwp_apply+0x152>
    aacd:	31 d2                	xor    %edx,%edx
    aacf:	4d 89 e0             	mov    %r12,%r8
    aad2:	48 89 d6             	mov    %rdx,%rsi
    aad5:	49 83 e0 03          	and    $0x3,%r8
    aad9:	74 16                	je     aaf1 <fwp_apply+0x111>
    aadb:	48 89 d6             	mov    %rdx,%rsi
    aade:	66 90                	xchg   %ax,%ax
    aae0:	4d 8b 4c f7 08       	mov    0x8(%r15,%rsi,8),%r9
    aae5:	4c 89 0c f7          	mov    %r9,(%rdi,%rsi,8)
    aae9:	48 ff c6             	inc    %rsi
    aaec:	49 ff c8             	dec    %r8
    aaef:	75 ef                	jne    aae0 <fwp_apply+0x100>
    aaf1:	4c 29 e2             	sub    %r12,%rdx
    aaf4:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    aaf8:	0f 87 82 00 00 00    	ja     ab80 <fwp_apply+0x1a0>
    aafe:	66 90                	xchg   %ax,%ax
    ab00:	49 8b 54 f7 08       	mov    0x8(%r15,%rsi,8),%rdx
    ab05:	48 89 14 f7          	mov    %rdx,(%rdi,%rsi,8)
    ab09:	49 8b 54 f7 10       	mov    0x10(%r15,%rsi,8),%rdx
    ab0e:	48 89 54 f7 08       	mov    %rdx,0x8(%rdi,%rsi,8)
    ab13:	49 8b 54 f7 18       	mov    0x18(%r15,%rsi,8),%rdx
    ab18:	48 89 54 f7 10       	mov    %rdx,0x10(%rdi,%rsi,8)
    ab1d:	49 8b 54 f7 20       	mov    0x20(%r15,%rsi,8),%rdx
    ab22:	48 89 54 f7 18       	mov    %rdx,0x18(%rdi,%rsi,8)
    ab27:	48 83 c6 04          	add    $0x4,%rsi
    ab2b:	49 39 f4             	cmp    %rsi,%r12
    ab2e:	75 d0                	jne    ab00 <fwp_apply+0x120>
    ab30:	eb 4e                	jmp    ab80 <fwp_apply+0x1a0>
    ab32:	44 89 e2             	mov    %r12d,%edx
    ab35:	83 e2 fc             	and    $0xfffffffc,%edx
    ab38:	4a 8d 34 e5 00 00 00 	lea    0x0(,%r12,8),%rsi
    ab3f:	00 
    ab40:	48 83 e6 e0          	and    $0xffffffffffffffe0,%rsi
    ab44:	45 31 c0             	xor    %r8d,%r8d
    ab47:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    ab4e:	00 00 
    ab50:	43 0f 10 44 07 08    	movups 0x8(%r15,%r8,1),%xmm0
    ab56:	43 0f 10 4c 07 18    	movups 0x18(%r15,%r8,1),%xmm1
    ab5c:	42 0f 29 04 07       	movaps %xmm0,(%rdi,%r8,1)
    ab61:	42 0f 29 4c 07 10    	movaps %xmm1,0x10(%rdi,%r8,1)
    ab67:	49 83 c0 20          	add    $0x20,%r8
    ab6b:	4c 39 c6             	cmp    %r8,%rsi
    ab6e:	75 e0                	jne    ab50 <fwp_apply+0x170>
    ab70:	4c 39 e2             	cmp    %r12,%rdx
    ab73:	0f 85 56 ff ff ff    	jne    aacf <fwp_apply+0xef>
    ab79:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    ab80:	45 29 e3             	sub    %r12d,%r11d
    ab83:	45 89 de             	mov    %r11d,%r14d
    ab86:	45 39 e5             	cmp    %r12d,%r13d
    ab89:	0f 84 85 00 00 00    	je     ac14 <fwp_apply+0x234>
    ab8f:	41 83 fb 0e          	cmp    $0xe,%r11d
    ab93:	0f 83 a0 00 00 00    	jae    ac39 <fwp_apply+0x259>
    ab99:	31 d2                	xor    %edx,%edx
    ab9b:	4d 89 f0             	mov    %r14,%r8
    ab9e:	48 89 d6             	mov    %rdx,%rsi
    aba1:	49 83 e0 03          	and    $0x3,%r8
    aba5:	74 1d                	je     abc4 <fwp_apply+0x1e4>
    aba7:	48 89 d6             	mov    %rdx,%rsi
    abaa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    abb0:	4c 8b 0c f3          	mov    (%rbx,%rsi,8),%r9
    abb4:	45 8d 14 34          	lea    (%r12,%rsi,1),%r10d
    abb8:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    abbc:	48 ff c6             	inc    %rsi
    abbf:	49 ff c8             	dec    %r8
    abc2:	75 ec                	jne    abb0 <fwp_apply+0x1d0>
    abc4:	4c 29 f2             	sub    %r14,%rdx
    abc7:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    abcb:	77 47                	ja     ac14 <fwp_apply+0x234>
    abcd:	0f 1f 00             	nopl   (%rax)
    abd0:	48 8b 14 f3          	mov    (%rbx,%rsi,8),%rdx
    abd4:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    abd8:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    abdc:	48 8b 54 f3 08       	mov    0x8(%rbx,%rsi,8),%rdx
    abe1:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    abe5:	41 ff c0             	inc    %r8d
    abe8:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    abec:	48 8b 54 f3 10       	mov    0x10(%rbx,%rsi,8),%rdx
    abf1:	45 8d 44 34 02       	lea    0x2(%r12,%rsi,1),%r8d
    abf6:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    abfa:	48 8b 54 f3 18       	mov    0x18(%rbx,%rsi,8),%rdx
    abff:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    ac03:	41 83 c0 03          	add    $0x3,%r8d
    ac07:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    ac0b:	48 83 c6 04          	add    $0x4,%rsi
    ac0f:	49 39 f6             	cmp    %rsi,%r14
    ac12:	75 bc                	jne    abd0 <fwp_apply+0x1f0>
    ac14:	45 89 dc             	mov    %r11d,%r12d
    ac17:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    ac1b:	b9 01 00 00 00       	mov    $0x1,%ecx
    ac20:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    ac24:	89 f2                	mov    %esi,%edx
    ac26:	44 29 e2             	sub    %r12d,%edx
    ac29:	0f 85 d1 fd ff ff    	jne    aa00 <fwp_apply+0x20>
    ac2f:	89 f2                	mov    %esi,%edx
    ac31:	49 89 c6             	mov    %rax,%r14
    ac34:	e9 d4 fd ff ff       	jmp    aa0d <fwp_apply+0x2d>
    ac39:	49 8d 56 ff          	lea    -0x1(%r14),%rdx
    ac3d:	89 d6                	mov    %edx,%esi
    ac3f:	44 01 e6             	add    %r12d,%esi
    ac42:	0f 82 51 ff ff ff    	jb     ab99 <fwp_apply+0x1b9>
    ac48:	48 c1 ea 20          	shr    $0x20,%rdx
    ac4c:	ba 00 00 00 00       	mov    $0x0,%edx
    ac51:	0f 85 44 ff ff ff    	jne    ab9b <fwp_apply+0x1bb>
    ac57:	4a 8d 14 e7          	lea    (%rdi,%r12,8),%rdx
    ac5b:	48 29 da             	sub    %rbx,%rdx
    ac5e:	48 83 fa 20          	cmp    $0x20,%rdx
    ac62:	0f 82 31 ff ff ff    	jb     ab99 <fwp_apply+0x1b9>
    ac68:	44 89 f2             	mov    %r14d,%edx
    ac6b:	83 e2 fc             	and    $0xfffffffc,%edx
    ac6e:	31 f6                	xor    %esi,%esi
    ac70:	0f 10 04 f3          	movups (%rbx,%rsi,8),%xmm0
    ac74:	0f 10 4c f3 10       	movups 0x10(%rbx,%rsi,8),%xmm1
    ac79:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    ac7d:	42 0f 11 04 c7       	movups %xmm0,(%rdi,%r8,8)
    ac82:	42 0f 11 4c c7 10    	movups %xmm1,0x10(%rdi,%r8,8)
    ac88:	48 83 c6 04          	add    $0x4,%rsi
    ac8c:	48 39 f2             	cmp    %rsi,%rdx
    ac8f:	75 df                	jne    ac70 <fwp_apply+0x290>
    ac91:	4c 39 f2             	cmp    %r14,%rdx
    ac94:	0f 85 01 ff ff ff    	jne    ab9b <fwp_apply+0x1bb>
    ac9a:	e9 75 ff ff ff       	jmp    ac14 <fwp_apply+0x234>
    ac9f:	44 89 f0             	mov    %r14d,%eax
    aca2:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    aca9:	00 
    acaa:	e8 71 aa ff ff       	call   5720 <fwp_alloc>
    acaf:	41 8b 0f             	mov    (%r15),%ecx
    acb2:	89 08                	mov    %ecx,(%rax)
    acb4:	44 89 70 04          	mov    %r14d,0x4(%rax)
    acb8:	49 89 c6             	mov    %rax,%r14
    acbb:	4d 85 e4             	test   %r12,%r12
    acbe:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    acc2:	0f 84 b9 00 00 00    	je     ad81 <fwp_apply+0x3a1>
    acc8:	31 c0                	xor    %eax,%eax
    acca:	41 83 fc 06          	cmp    $0x6,%r12d
    acce:	72 46                	jb     ad16 <fwp_apply+0x336>
    acd0:	4c 89 f1             	mov    %r14,%rcx
    acd3:	4c 29 f9             	sub    %r15,%rcx
    acd6:	48 83 f9 20          	cmp    $0x20,%rcx
    acda:	72 3a                	jb     ad16 <fwp_apply+0x336>
    acdc:	44 89 e0             	mov    %r12d,%eax
    acdf:	83 e0 fc             	and    $0xfffffffc,%eax
    ace2:	4a 8d 0c e5 00 00 00 	lea    0x0(,%r12,8),%rcx
    ace9:	00 
    acea:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    acee:	31 d2                	xor    %edx,%edx
    acf0:	41 0f 10 44 17 08    	movups 0x8(%r15,%rdx,1),%xmm0
    acf6:	41 0f 10 4c 17 18    	movups 0x18(%r15,%rdx,1),%xmm1
    acfc:	41 0f 11 44 16 08    	movups %xmm0,0x8(%r14,%rdx,1)
    ad02:	41 0f 11 4c 16 18    	movups %xmm1,0x18(%r14,%rdx,1)
    ad08:	48 83 c2 20          	add    $0x20,%rdx
    ad0c:	48 39 d1             	cmp    %rdx,%rcx
    ad0f:	75 df                	jne    acf0 <fwp_apply+0x310>
    ad11:	4c 39 e0             	cmp    %r12,%rax
    ad14:	74 6b                	je     ad81 <fwp_apply+0x3a1>
    ad16:	4c 89 e2             	mov    %r12,%rdx
    ad19:	48 89 c1             	mov    %rax,%rcx
    ad1c:	48 83 e2 03          	and    $0x3,%rdx
    ad20:	74 20                	je     ad42 <fwp_apply+0x362>
    ad22:	48 89 c1             	mov    %rax,%rcx
    ad25:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    ad2c:	00 00 00 00 
    ad30:	49 8b 74 cf 08       	mov    0x8(%r15,%rcx,8),%rsi
    ad35:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    ad3a:	48 ff c1             	inc    %rcx
    ad3d:	48 ff ca             	dec    %rdx
    ad40:	75 ee                	jne    ad30 <fwp_apply+0x350>
    ad42:	4c 29 e0             	sub    %r12,%rax
    ad45:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    ad49:	77 36                	ja     ad81 <fwp_apply+0x3a1>
    ad4b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    ad50:	49 8b 44 cf 08       	mov    0x8(%r15,%rcx,8),%rax
    ad55:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    ad5a:	49 8b 44 cf 10       	mov    0x10(%r15,%rcx,8),%rax
    ad5f:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    ad64:	49 8b 44 cf 18       	mov    0x18(%r15,%rcx,8),%rax
    ad69:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    ad6e:	49 8b 44 cf 20       	mov    0x20(%r15,%rcx,8),%rax
    ad73:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    ad78:	48 83 c1 04          	add    $0x4,%rcx
    ad7c:	49 39 cc             	cmp    %rcx,%r12
    ad7f:	75 cf                	jne    ad50 <fwp_apply+0x370>
    ad81:	85 ff                	test   %edi,%edi
    ad83:	0f 84 92 00 00 00    	je     ae1b <fwp_apply+0x43b>
    ad89:	89 f8                	mov    %edi,%eax
    ad8b:	83 ff 14             	cmp    $0x14,%edi
    ad8e:	0f 83 99 00 00 00    	jae    ae2d <fwp_apply+0x44d>
    ad94:	31 c9                	xor    %ecx,%ecx
    ad96:	48 89 c6             	mov    %rax,%rsi
    ad99:	48 89 ca             	mov    %rcx,%rdx
    ad9c:	48 83 e6 03          	and    $0x3,%rsi
    ada0:	74 23                	je     adc5 <fwp_apply+0x3e5>
    ada2:	48 89 ca             	mov    %rcx,%rdx
    ada5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    adac:	00 00 00 00 
    adb0:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    adb4:	45 8d 04 14          	lea    (%r12,%rdx,1),%r8d
    adb8:	4b 89 7c c6 08       	mov    %rdi,0x8(%r14,%r8,8)
    adbd:	48 ff c2             	inc    %rdx
    adc0:	48 ff ce             	dec    %rsi
    adc3:	75 eb                	jne    adb0 <fwp_apply+0x3d0>
    adc5:	48 29 c1             	sub    %rax,%rcx
    adc8:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    adcc:	77 4d                	ja     ae1b <fwp_apply+0x43b>
    adce:	66 90                	xchg   %ax,%ax
    add0:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    add4:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    add8:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    addd:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    ade2:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    ade6:	ff c6                	inc    %esi
    ade8:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    aded:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    adf2:	41 8d 74 14 02       	lea    0x2(%r12,%rdx,1),%esi
    adf7:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    adfc:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    ae01:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    ae05:	83 c6 03             	add    $0x3,%esi
    ae08:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    ae0d:	48 83 c2 04          	add    $0x4,%rdx
    ae11:	48 39 d0             	cmp    %rdx,%rax
    ae14:	75 ba                	jne    add0 <fwp_apply+0x3f0>
    ae16:	eb 03                	jmp    ae1b <fwp_apply+0x43b>
    ae18:	4d 89 fe             	mov    %r15,%r14
    ae1b:	4c 89 f0             	mov    %r14,%rax
    ae1e:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    ae22:	5b                   	pop    %rbx
    ae23:	41 5c                	pop    %r12
    ae25:	41 5d                	pop    %r13
    ae27:	41 5e                	pop    %r14
    ae29:	41 5f                	pop    %r15
    ae2b:	5d                   	pop    %rbp
    ae2c:	c3                   	ret
    ae2d:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    ae31:	31 c9                	xor    %ecx,%ecx
    ae33:	89 d6                	mov    %edx,%esi
    ae35:	44 01 e6             	add    %r12d,%esi
    ae38:	0f 82 58 ff ff ff    	jb     ad96 <fwp_apply+0x3b6>
    ae3e:	48 c1 ea 20          	shr    $0x20,%rdx
    ae42:	0f 85 4e ff ff ff    	jne    ad96 <fwp_apply+0x3b6>
    ae48:	4b 8d 0c e6          	lea    (%r14,%r12,8),%rcx
    ae4c:	48 29 d9             	sub    %rbx,%rcx
    ae4f:	48 83 c1 08          	add    $0x8,%rcx
    ae53:	48 83 f9 20          	cmp    $0x20,%rcx
    ae57:	0f 82 37 ff ff ff    	jb     ad94 <fwp_apply+0x3b4>
    ae5d:	89 c1                	mov    %eax,%ecx
    ae5f:	83 e1 fc             	and    $0xfffffffc,%ecx
    ae62:	31 d2                	xor    %edx,%edx
    ae64:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    ae6b:	00 00 00 00 00 
    ae70:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    ae74:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    ae79:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    ae7d:	41 0f 11 44 f6 08    	movups %xmm0,0x8(%r14,%rsi,8)
    ae83:	41 0f 11 4c f6 18    	movups %xmm1,0x18(%r14,%rsi,8)
    ae89:	48 83 c2 04          	add    $0x4,%rdx
    ae8d:	48 39 d1             	cmp    %rdx,%rcx
    ae90:	75 de                	jne    ae70 <fwp_apply+0x490>
    ae92:	48 39 c1             	cmp    %rax,%rcx
    ae95:	0f 85 fb fe ff ff    	jne    ad96 <fwp_apply+0x3b6>
    ae9b:	e9 7b ff ff ff       	jmp    ae1b <fwp_apply+0x43b>

000000000000aea0 <fwp_pap>:
    aea0:	50                   	push   %rax
    aea1:	bf 08 00 00 00       	mov    $0x8,%edi
    aea6:	e8 75 a8 ff ff       	call   5720 <fwp_alloc>
    aeab:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    aeb2:	59                   	pop    %rcx
    aeb3:	c3                   	ret
    aeb4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    aebb:	00 00 00 00 00 

000000000000aec0 <fwp_exec_error>:
    aec0:	41 57                	push   %r15
    aec2:	41 56                	push   %r14
    aec4:	53                   	push   %rbx
    aec5:	48 89 f3             	mov    %rsi,%rbx
    aec8:	49 89 fe             	mov    %rdi,%r14
    aecb:	e8 90 bd ff ff       	call   6c60 <fwp_pipe_flush>
    aed0:	4c 8b 3d 09 91 00 00 	mov    0x9109(%rip),%r15        # 13fe0 <stderr@GLIBC_2.2.5>
    aed7:	49 8b 3f             	mov    (%r15),%rdi
    aeda:	48 8d 35 36 44 00 00 	lea    0x4436(%rip),%rsi        # f317 <exec_in_fp0+0xcc7>
    aee1:	48 8d 15 91 37 00 00 	lea    0x3791(%rip),%rdx        # e679 <exec_in_fp0+0x29>
    aee8:	31 c0                	xor    %eax,%eax
    aeea:	e8 01 74 ff ff       	call   22f0 <fprintf@plt>
    aeef:	83 3b 10             	cmpl   $0x10,(%rbx)
    aef2:	75 1f                	jne    af13 <fwp_exec_error+0x53>
    aef4:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    aef8:	48 85 ff             	test   %rdi,%rdi
    aefb:	74 16                	je     af13 <fwp_exec_error+0x53>
    aefd:	48 8d 35 18 44 00 00 	lea    0x4418(%rip),%rsi        # f31c <exec_in_fp0+0xccc>
    af04:	e8 c7 73 ff ff       	call   22d0 <strcmp@plt>
    af09:	85 c0                	test   %eax,%eax
    af0b:	75 06                	jne    af13 <fwp_exec_error+0x53>
    af0d:	83 7b 10 02          	cmpl   $0x2,0x10(%rbx)
    af11:	74 20                	je     af33 <fwp_exec_error+0x73>
    af13:	49 8b 17             	mov    (%r15),%rdx
    af16:	4c 89 f7             	mov    %r14,%rdi
    af19:	48 89 de             	mov    %rbx,%rsi
    af1c:	e8 2f 00 00 00       	call   af50 <fwp_display_top>
    af21:	49 8b 37             	mov    (%r15),%rsi
    af24:	bf 0a 00 00 00       	mov    $0xa,%edi
    af29:	5b                   	pop    %rbx
    af2a:	41 5e                	pop    %r14
    af2c:	41 5f                	pop    %r15
    af2e:	e9 0d 73 ff ff       	jmp    2240 <fputc@plt>
    af33:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    af37:	48 8b 17             	mov    (%rdi),%rdx
    af3a:	48 83 c7 08          	add    $0x8,%rdi
    af3e:	49 8b 0f             	mov    (%r15),%rcx
    af41:	be 01 00 00 00       	mov    $0x1,%esi
    af46:	e8 55 75 ff ff       	call   24a0 <fwrite@plt>
    af4b:	eb d4                	jmp    af21 <fwp_exec_error+0x61>
    af4d:	0f 1f 00             	nopl   (%rax)

000000000000af50 <fwp_display_top>:
    af50:	53                   	push   %rbx
    af51:	48 83 ec 20          	sub    $0x20,%rsp
    af55:	48 89 d3             	mov    %rdx,%rbx
    af58:	48 89 f2             	mov    %rsi,%rdx
    af5b:	48 89 fe             	mov    %rdi,%rsi
    af5e:	0f 57 c0             	xorps  %xmm0,%xmm0
    af61:	0f 29 04 24          	movaps %xmm0,(%rsp)
    af65:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    af6c:	00 00 
    af6e:	48 89 e7             	mov    %rsp,%rdi
    af71:	b9 01 00 00 00       	mov    $0x1,%ecx
    af76:	e8 35 00 00 00       	call   afb0 <fwp_write>
    af7b:	48 8b 3c 24          	mov    (%rsp),%rdi
    af7f:	48 85 ff             	test   %rdi,%rdi
    af82:	74 18                	je     af9c <fwp_display_top+0x4c>
    af84:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    af89:	be 01 00 00 00       	mov    $0x1,%esi
    af8e:	48 89 d9             	mov    %rbx,%rcx
    af91:	e8 0a 75 ff ff       	call   24a0 <fwrite@plt>
    af96:	48 8b 3c 24          	mov    (%rsp),%rdi
    af9a:	eb 02                	jmp    af9e <fwp_display_top+0x4e>
    af9c:	31 ff                	xor    %edi,%edi
    af9e:	e8 ad 70 ff ff       	call   2050 <free@plt>
    afa3:	48 83 c4 20          	add    $0x20,%rsp
    afa7:	5b                   	pop    %rbx
    afa8:	c3                   	ret
    afa9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000afb0 <fwp_write>:
    afb0:	55                   	push   %rbp
    afb1:	41 57                	push   %r15
    afb3:	41 56                	push   %r14
    afb5:	41 55                	push   %r13
    afb7:	41 54                	push   %r12
    afb9:	53                   	push   %rbx
    afba:	48 81 ec 28 02 00 00 	sub    $0x228,%rsp
    afc1:	8b 02                	mov    (%rdx),%eax
    afc3:	48 83 f8 19          	cmp    $0x19,%rax
    afc7:	0f 87 3f 05 00 00    	ja     b50c <fwp_write+0x55c>
    afcd:	49 89 f5             	mov    %rsi,%r13
    afd0:	48 89 fb             	mov    %rdi,%rbx
    afd3:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
    afd8:	48 8d 15 65 33 00 00 	lea    0x3365(%rip),%rdx        # e344 <_IO_stdin_used+0x344>
    afdf:	48 63 34 82          	movslq (%rdx,%rax,4),%rsi
    afe3:	48 01 d6             	add    %rdx,%rsi
    afe6:	ff e6                	jmp    *%rsi
    afe8:	48 8d 15 35 43 00 00 	lea    0x4335(%rip),%rdx        # f324 <exec_in_fp0+0xcd4>
    afef:	eb 07                	jmp    aff8 <fwp_write+0x48>
    aff1:	48 8d 15 f4 42 00 00 	lea    0x42f4(%rip),%rdx        # f2ec <exec_in_fp0+0xc9c>
    aff8:	4c 8d 7c 24 20       	lea    0x20(%rsp),%r15
    affd:	be 00 02 00 00       	mov    $0x200,%esi
    b002:	4c 89 ff             	mov    %r15,%rdi
    b005:	4c 89 e9             	mov    %r13,%rcx
    b008:	31 c0                	xor    %eax,%eax
    b00a:	e8 c1 71 ff ff       	call   21d0 <snprintf@plt>
    b00f:	48 89 df             	mov    %rbx,%rdi
    b012:	4c 89 fe             	mov    %r15,%rsi
    b015:	e9 ed 04 00 00       	jmp    b507 <fwp_write+0x557>
    b01a:	83 f8 13             	cmp    $0x13,%eax
    b01d:	48 8d 05 31 43 00 00 	lea    0x4331(%rip),%rax        # f355 <exec_in_fp0+0xd05>
    b024:	48 8d 35 2f 43 00 00 	lea    0x432f(%rip),%rsi        # f35a <exec_in_fp0+0xd0a>
    b02b:	48 0f 44 f0          	cmove  %rax,%rsi
    b02f:	48 89 df             	mov    %rbx,%rdi
    b032:	e8 19 ca ff ff       	call   7a50 <buf_puts>
    b037:	49 83 7d 00 00       	cmpq   $0x0,0x0(%r13)
    b03c:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    b041:	0f 84 cb 00 00 00    	je     b112 <fwp_write+0x162>
    b047:	4d 89 ec             	mov    %r13,%r12
    b04a:	48 8b 50 38          	mov    0x38(%rax),%rdx
    b04e:	48 89 df             	mov    %rbx,%rdi
    b051:	4c 89 eb             	mov    %r13,%rbx
    b054:	49 8b 74 24 08       	mov    0x8(%r12),%rsi
    b059:	49 89 c6             	mov    %rax,%r14
    b05c:	49 89 ff             	mov    %rdi,%r15
    b05f:	31 c9                	xor    %ecx,%ecx
    b061:	e8 4a ff ff ff       	call   afb0 <fwp_write>
    b066:	41 83 3e 12          	cmpl   $0x12,(%r14)
    b06a:	75 29                	jne    b095 <fwp_write+0xe5>
    b06c:	48 8d 35 a6 42 00 00 	lea    0x42a6(%rip),%rsi        # f319 <exec_in_fp0+0xcc9>
    b073:	4d 89 fe             	mov    %r15,%r14
    b076:	4c 89 ff             	mov    %r15,%rdi
    b079:	e8 d2 c9 ff ff       	call   7a50 <buf_puts>
    b07e:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    b082:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    b087:	48 8b 50 40          	mov    0x40(%rax),%rdx
    b08b:	4c 89 ff             	mov    %r15,%rdi
    b08e:	31 c9                	xor    %ecx,%ecx
    b090:	e8 1b ff ff ff       	call   afb0 <fwp_write>
    b095:	48 83 3b 02          	cmpq   $0x2,(%rbx)
    b099:	4c 89 fb             	mov    %r15,%rbx
    b09c:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    b0a1:	72 6f                	jb     b112 <fwp_write+0x162>
    b0a3:	4d 8d 74 24 20       	lea    0x20(%r12),%r14
    b0a8:	bd 01 00 00 00       	mov    $0x1,%ebp
    b0ad:	4c 8d 2d ba 41 00 00 	lea    0x41ba(%rip),%r13        # f26e <exec_in_fp0+0xc1e>
    b0b4:	eb 17                	jmp    b0cd <fwp_write+0x11d>
    b0b6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    b0bd:	00 00 00 
    b0c0:	48 ff c5             	inc    %rbp
    b0c3:	49 83 c6 10          	add    $0x10,%r14
    b0c7:	49 3b 2c 24          	cmp    (%r12),%rbp
    b0cb:	73 45                	jae    b112 <fwp_write+0x162>
    b0cd:	48 89 df             	mov    %rbx,%rdi
    b0d0:	4c 89 ee             	mov    %r13,%rsi
    b0d3:	e8 78 c9 ff ff       	call   7a50 <buf_puts>
    b0d8:	49 8b 76 f8          	mov    -0x8(%r14),%rsi
    b0dc:	49 8b 57 38          	mov    0x38(%r15),%rdx
    b0e0:	48 89 df             	mov    %rbx,%rdi
    b0e3:	31 c9                	xor    %ecx,%ecx
    b0e5:	e8 c6 fe ff ff       	call   afb0 <fwp_write>
    b0ea:	41 83 3f 12          	cmpl   $0x12,(%r15)
    b0ee:	75 d0                	jne    b0c0 <fwp_write+0x110>
    b0f0:	48 89 df             	mov    %rbx,%rdi
    b0f3:	48 8d 35 1f 42 00 00 	lea    0x421f(%rip),%rsi        # f319 <exec_in_fp0+0xcc9>
    b0fa:	e8 51 c9 ff ff       	call   7a50 <buf_puts>
    b0ff:	49 8b 36             	mov    (%r14),%rsi
    b102:	49 8b 57 40          	mov    0x40(%r15),%rdx
    b106:	48 89 df             	mov    %rbx,%rdi
    b109:	31 c9                	xor    %ecx,%ecx
    b10b:	e8 a0 fe ff ff       	call   afb0 <fwp_write>
    b110:	eb ae                	jmp    b0c0 <fwp_write+0x110>
    b112:	48 89 df             	mov    %rbx,%rdi
    b115:	be 7d 00 00 00       	mov    $0x7d,%esi
    b11a:	e9 48 05 00 00       	jmp    b667 <fwp_write+0x6b7>
    b11f:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    b124:	4d 8b 67 08          	mov    0x8(%r15),%r12
    b128:	4d 85 e4             	test   %r12,%r12
    b12b:	0f 84 38 04 00 00    	je     b569 <fwp_write+0x5b9>
    b131:	48 8d 35 53 41 00 00 	lea    0x4153(%rip),%rsi        # f28b <exec_in_fp0+0xc3b>
    b138:	4c 89 e7             	mov    %r12,%rdi
    b13b:	e8 90 71 ff ff       	call   22d0 <strcmp@plt>
    b140:	85 c0                	test   %eax,%eax
    b142:	0f 84 44 05 00 00    	je     b68c <fwp_write+0x6dc>
    b148:	4d 8d 77 10          	lea    0x10(%r15),%r14
    b14c:	48 89 df             	mov    %rbx,%rdi
    b14f:	4c 89 e6             	mov    %r12,%rsi
    b152:	e8 f9 c8 ff ff       	call   7a50 <buf_puts>
    b157:	48 89 df             	mov    %rbx,%rdi
    b15a:	be 20 00 00 00       	mov    $0x20,%esi
    b15f:	e8 cc c8 ff ff       	call   7a30 <buf_putc>
    b164:	31 ed                	xor    %ebp,%ebp
    b166:	e9 1f 04 00 00       	jmp    b58a <fwp_write+0x5da>
    b16b:	4c 89 ef             	mov    %r13,%rdi
    b16e:	e8 cd ef ff ff       	call   a140 <fwp_tag>
    b173:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    b178:	49 8b 4f 18          	mov    0x18(%r15),%rcx
    b17c:	41 89 c6             	mov    %eax,%r14d
    b17f:	4a 8b 34 f1          	mov    (%rcx,%r14,8),%rsi
    b183:	48 89 df             	mov    %rbx,%rdi
    b186:	e8 c5 c8 ff ff       	call   7a50 <buf_puts>
    b18b:	49 8b 47 28          	mov    0x28(%r15),%rax
    b18f:	42 83 3c b0 00       	cmpl   $0x0,(%rax,%r14,4)
    b194:	0f 8e 72 03 00 00    	jle    b50c <fwp_write+0x55c>
    b19a:	4c 89 f1             	mov    %r14,%rcx
    b19d:	45 31 f6             	xor    %r14d,%r14d
    b1a0:	4c 89 6c 24 18       	mov    %r13,0x18(%rsp)
    b1a5:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
    b1aa:	eb 3d                	jmp    b1e9 <fwp_write+0x239>
    b1ac:	0f 1f 40 00          	nopl   0x0(%rax)
    b1b0:	48 89 dd             	mov    %rbx,%rbp
    b1b3:	48 89 df             	mov    %rbx,%rdi
    b1b6:	4c 89 e6             	mov    %r12,%rsi
    b1b9:	4c 89 ea             	mov    %r13,%rdx
    b1bc:	31 c9                	xor    %ecx,%ecx
    b1be:	e8 ed fd ff ff       	call   afb0 <fwp_write>
    b1c3:	49 ff c6             	inc    %r14
    b1c6:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    b1cb:	49 8b 47 28          	mov    0x28(%r15),%rax
    b1cf:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    b1d4:	48 63 04 88          	movslq (%rax,%rcx,4),%rax
    b1d8:	49 39 c6             	cmp    %rax,%r14
    b1db:	4c 8b 6c 24 18       	mov    0x18(%rsp),%r13
    b1e0:	48 89 eb             	mov    %rbp,%rbx
    b1e3:	0f 8d 23 03 00 00    	jge    b50c <fwp_write+0x55c>
    b1e9:	4f 8b 64 f5 08       	mov    0x8(%r13,%r14,8),%r12
    b1ee:	49 8b 47 30          	mov    0x30(%r15),%rax
    b1f2:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    b1f6:	4e 8b 2c f0          	mov    (%rax,%r14,8),%r13
    b1fa:	48 89 df             	mov    %rbx,%rdi
    b1fd:	be 20 00 00 00       	mov    $0x20,%esi
    b202:	e8 29 c8 ff ff       	call   7a30 <buf_putc>
    b207:	4c 89 e7             	mov    %r12,%rdi
    b20a:	4c 89 ee             	mov    %r13,%rsi
    b20d:	e8 8e 0e 00 00       	call   c0a0 <fwp_needs_parens>
    b212:	85 c0                	test   %eax,%eax
    b214:	74 9a                	je     b1b0 <fwp_write+0x200>
    b216:	48 89 df             	mov    %rbx,%rdi
    b219:	be 28 00 00 00       	mov    $0x28,%esi
    b21e:	e8 0d c8 ff ff       	call   7a30 <buf_putc>
    b223:	48 89 df             	mov    %rbx,%rdi
    b226:	4c 89 e6             	mov    %r12,%rsi
    b229:	4c 89 ea             	mov    %r13,%rdx
    b22c:	31 c9                	xor    %ecx,%ecx
    b22e:	e8 7d fd ff ff       	call   afb0 <fwp_write>
    b233:	48 89 dd             	mov    %rbx,%rbp
    b236:	48 89 df             	mov    %rbx,%rdi
    b239:	be 29 00 00 00       	mov    $0x29,%esi
    b23e:	e8 ed c7 ff ff       	call   7a30 <buf_putc>
    b243:	e9 7b ff ff ff       	jmp    b1c3 <fwp_write+0x213>
    b248:	4c 89 ef             	mov    %r13,%rdi
    b24b:	e8 60 a9 ff ff       	call   5bb0 <fwp_f64>
    b250:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    b255:	4c 89 f7             	mov    %r14,%rdi
    b258:	e8 93 08 00 00       	call   baf0 <fwp_fmt_f64>
    b25d:	e9 9f 02 00 00       	jmp    b501 <fwp_write+0x551>
    b262:	48 89 df             	mov    %rbx,%rdi
    b265:	be 3c 00 00 00       	mov    $0x3c,%esi
    b26a:	e8 c1 c7 ff ff       	call   7a30 <buf_putc>
    b26f:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    b274:	48 8b 70 08          	mov    0x8(%rax),%rsi
    b278:	48 89 df             	mov    %rbx,%rdi
    b27b:	e9 d7 02 00 00       	jmp    b557 <fwp_write+0x5a7>
    b280:	48 8d 35 ad 40 00 00 	lea    0x40ad(%rip),%rsi        # f334 <exec_in_fp0+0xce4>
    b287:	e9 99 02 00 00       	jmp    b525 <fwp_write+0x575>
    b28c:	49 8d 75 08          	lea    0x8(%r13),%rsi
    b290:	49 8b 55 00          	mov    0x0(%r13),%rdx
    b294:	48 89 df             	mov    %rbx,%rdi
    b297:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b29e:	85 c9                	test   %ecx,%ecx
    b2a0:	0f 84 d7 03 00 00    	je     b67d <fwp_write+0x6cd>
    b2a6:	5b                   	pop    %rbx
    b2a7:	41 5c                	pop    %r12
    b2a9:	41 5d                	pop    %r13
    b2ab:	41 5e                	pop    %r14
    b2ad:	41 5f                	pop    %r15
    b2af:	5d                   	pop    %rbp
    b2b0:	e9 cb c7 ff ff       	jmp    7a80 <buf_put>
    b2b5:	4c 89 ef             	mov    %r13,%rdi
    b2b8:	e8 43 ee ff ff       	call   a100 <fwp_u128>
    b2bd:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    b2c2:	4c 89 f7             	mov    %r14,%rdi
    b2c5:	48 89 c6             	mov    %rax,%rsi
    b2c8:	e8 13 04 00 00       	call   b6e0 <fwp_fmt_u128>
    b2cd:	e9 2f 02 00 00       	jmp    b501 <fwp_write+0x551>
    b2d2:	4c 89 ef             	mov    %r13,%rdi
    b2d5:	e8 16 ee ff ff       	call   a0f0 <fwp_i128>
    b2da:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    b2df:	4c 89 f7             	mov    %r14,%rdi
    b2e2:	48 89 c6             	mov    %rax,%rsi
    b2e5:	e8 d6 03 00 00       	call   b6c0 <fwp_fmt_i128>
    b2ea:	e9 12 02 00 00       	jmp    b501 <fwp_write+0x551>
    b2ef:	48 89 df             	mov    %rbx,%rdi
    b2f2:	be 5b 00 00 00       	mov    $0x5b,%esi
    b2f7:	e8 34 c7 ff ff       	call   7a30 <buf_putc>
    b2fc:	4d 85 ed             	test   %r13,%r13
    b2ff:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    b304:	0f 84 d5 01 00 00    	je     b4df <fwp_write+0x52f>
    b30a:	49 8b 57 38          	mov    0x38(%r15),%rdx
    b30e:	49 8b 75 08          	mov    0x8(%r13),%rsi
    b312:	48 89 df             	mov    %rbx,%rdi
    b315:	31 c9                	xor    %ecx,%ecx
    b317:	e8 94 fc ff ff       	call   afb0 <fwp_write>
    b31c:	4d 8b 65 10          	mov    0x10(%r13),%r12
    b320:	4d 85 e4             	test   %r12,%r12
    b323:	0f 84 b6 01 00 00    	je     b4df <fwp_write+0x52f>
    b329:	4c 8d 35 3e 3f 00 00 	lea    0x3f3e(%rip),%r14        # f26e <exec_in_fp0+0xc1e>
    b330:	48 89 df             	mov    %rbx,%rdi
    b333:	4c 89 f6             	mov    %r14,%rsi
    b336:	e8 15 c7 ff ff       	call   7a50 <buf_puts>
    b33b:	49 8b 74 24 08       	mov    0x8(%r12),%rsi
    b340:	49 8b 57 38          	mov    0x38(%r15),%rdx
    b344:	48 89 df             	mov    %rbx,%rdi
    b347:	31 c9                	xor    %ecx,%ecx
    b349:	e8 62 fc ff ff       	call   afb0 <fwp_write>
    b34e:	4d 8b 64 24 10       	mov    0x10(%r12),%r12
    b353:	4d 85 e4             	test   %r12,%r12
    b356:	75 d8                	jne    b330 <fwp_write+0x380>
    b358:	e9 82 01 00 00       	jmp    b4df <fwp_write+0x52f>
    b35d:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    b362:	8b 50 48             	mov    0x48(%rax),%edx
    b365:	48 89 df             	mov    %rbx,%rdi
    b368:	4c 89 ee             	mov    %r13,%rsi
    b36b:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b372:	5b                   	pop    %rbx
    b373:	41 5c                	pop    %r12
    b375:	41 5d                	pop    %r13
    b377:	41 5e                	pop    %r14
    b379:	41 5f                	pop    %r15
    b37b:	5d                   	pop    %rbp
    b37c:	e9 2f 08 00 00       	jmp    bbb0 <fwp_trits>
    b381:	49 83 fd ff          	cmp    $0xffffffffffffffff,%r13
    b385:	48 8d 05 ee 3e 00 00 	lea    0x3eee(%rip),%rax        # f27a <exec_in_fp0+0xc2a>
    b38c:	48 8d 0d e8 3f 00 00 	lea    0x3fe8(%rip),%rcx        # f37b <exec_in_fp0+0xd2b>
    b393:	48 0f 44 c8          	cmove  %rax,%rcx
    b397:	49 83 fd 01          	cmp    $0x1,%r13
    b39b:	48 8d 35 d5 3e 00 00 	lea    0x3ed5(%rip),%rsi        # f277 <exec_in_fp0+0xc27>
    b3a2:	48 0f 45 f1          	cmovne %rcx,%rsi
    b3a6:	e9 7a 01 00 00       	jmp    b525 <fwp_write+0x575>
    b3ab:	48 8d 35 9c 3f 00 00 	lea    0x3f9c(%rip),%rsi        # f34e <exec_in_fp0+0xcfe>
    b3b2:	48 89 df             	mov    %rbx,%rdi
    b3b5:	e8 96 c6 ff ff       	call   7a50 <buf_puts>
    b3ba:	49 83 7d 00 00       	cmpq   $0x0,0x0(%r13)
    b3bf:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    b3c4:	0f 84 15 01 00 00    	je     b4df <fwp_write+0x52f>
    b3ca:	49 8b 57 38          	mov    0x38(%r15),%rdx
    b3ce:	49 8b 75 08          	mov    0x8(%r13),%rsi
    b3d2:	48 89 df             	mov    %rbx,%rdi
    b3d5:	31 c9                	xor    %ecx,%ecx
    b3d7:	e8 d4 fb ff ff       	call   afb0 <fwp_write>
    b3dc:	49 83 7d 00 02       	cmpq   $0x2,0x0(%r13)
    b3e1:	0f 82 f8 00 00 00    	jb     b4df <fwp_write+0x52f>
    b3e7:	41 be 01 00 00 00    	mov    $0x1,%r14d
    b3ed:	4c 8d 25 7a 3e 00 00 	lea    0x3e7a(%rip),%r12        # f26e <exec_in_fp0+0xc1e>
    b3f4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b3fb:	00 00 00 00 00 
    b400:	48 89 df             	mov    %rbx,%rdi
    b403:	4c 89 e6             	mov    %r12,%rsi
    b406:	e8 45 c6 ff ff       	call   7a50 <buf_puts>
    b40b:	4b 8b 74 f5 08       	mov    0x8(%r13,%r14,8),%rsi
    b410:	49 8b 57 38          	mov    0x38(%r15),%rdx
    b414:	48 89 df             	mov    %rbx,%rdi
    b417:	31 c9                	xor    %ecx,%ecx
    b419:	e8 92 fb ff ff       	call   afb0 <fwp_write>
    b41e:	49 ff c6             	inc    %r14
    b421:	4d 3b 75 00          	cmp    0x0(%r13),%r14
    b425:	72 d9                	jb     b400 <fwp_write+0x450>
    b427:	e9 b3 00 00 00       	jmp    b4df <fwp_write+0x52f>
    b42c:	48 8d 35 11 3f 00 00 	lea    0x3f11(%rip),%rsi        # f344 <exec_in_fp0+0xcf4>
    b433:	48 89 df             	mov    %rbx,%rdi
    b436:	e8 15 c6 ff ff       	call   7a50 <buf_puts>
    b43b:	49 83 7d 00 00       	cmpq   $0x0,0x0(%r13)
    b440:	0f 84 99 00 00 00    	je     b4df <fwp_write+0x52f>
    b446:	4c 89 ed             	mov    %r13,%rbp
    b449:	41 0f b6 4d 08       	movzbl 0x8(%r13),%ecx
    b44e:	48 8d 15 f6 3e 00 00 	lea    0x3ef6(%rip),%rdx        # f34b <exec_in_fp0+0xcfb>
    b455:	4c 8d 7c 24 20       	lea    0x20(%rsp),%r15
    b45a:	be 00 02 00 00       	mov    $0x200,%esi
    b45f:	4c 89 ff             	mov    %r15,%rdi
    b462:	31 c0                	xor    %eax,%eax
    b464:	e8 67 6d ff ff       	call   21d0 <snprintf@plt>
    b469:	48 89 df             	mov    %rbx,%rdi
    b46c:	4c 89 fe             	mov    %r15,%rsi
    b46f:	e8 dc c5 ff ff       	call   7a50 <buf_puts>
    b474:	49 83 7d 00 02       	cmpq   $0x2,0x0(%r13)
    b479:	72 64                	jb     b4df <fwp_write+0x52f>
    b47b:	41 be 09 00 00 00    	mov    $0x9,%r14d
    b481:	4c 8d 3d e6 3d 00 00 	lea    0x3de6(%rip),%r15        # f26e <exec_in_fp0+0xc1e>
    b488:	4c 8d 25 bc 3e 00 00 	lea    0x3ebc(%rip),%r12        # f34b <exec_in_fp0+0xcfb>
    b48f:	4c 8d 6c 24 20       	lea    0x20(%rsp),%r13
    b494:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b49b:	00 00 00 00 00 
    b4a0:	48 89 df             	mov    %rbx,%rdi
    b4a3:	4c 89 fe             	mov    %r15,%rsi
    b4a6:	e8 a5 c5 ff ff       	call   7a50 <buf_puts>
    b4ab:	42 0f b6 4c 35 00    	movzbl 0x0(%rbp,%r14,1),%ecx
    b4b1:	be 00 02 00 00       	mov    $0x200,%esi
    b4b6:	4c 89 ef             	mov    %r13,%rdi
    b4b9:	4c 89 e2             	mov    %r12,%rdx
    b4bc:	31 c0                	xor    %eax,%eax
    b4be:	e8 0d 6d ff ff       	call   21d0 <snprintf@plt>
    b4c3:	48 89 df             	mov    %rbx,%rdi
    b4c6:	4c 89 ee             	mov    %r13,%rsi
    b4c9:	e8 82 c5 ff ff       	call   7a50 <buf_puts>
    b4ce:	49 8d 46 01          	lea    0x1(%r14),%rax
    b4d2:	49 83 c6 f9          	add    $0xfffffffffffffff9,%r14
    b4d6:	4c 3b 75 00          	cmp    0x0(%rbp),%r14
    b4da:	49 89 c6             	mov    %rax,%r14
    b4dd:	72 c1                	jb     b4a0 <fwp_write+0x4f0>
    b4df:	48 89 df             	mov    %rbx,%rdi
    b4e2:	be 5d 00 00 00       	mov    $0x5d,%esi
    b4e7:	e9 7b 01 00 00       	jmp    b667 <fwp_write+0x6b7>
    b4ec:	4c 89 ef             	mov    %r13,%rdi
    b4ef:	e8 bc 7b ff ff       	call   30b0 <fwp_f32>
    b4f4:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    b4f9:	4c 89 f7             	mov    %r14,%rdi
    b4fc:	e8 ef 03 00 00       	call   b8f0 <fwp_fmt_f32>
    b501:	48 89 df             	mov    %rbx,%rdi
    b504:	4c 89 f6             	mov    %r14,%rsi
    b507:	e8 44 c5 ff ff       	call   7a50 <buf_puts>
    b50c:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b513:	5b                   	pop    %rbx
    b514:	41 5c                	pop    %r12
    b516:	41 5d                	pop    %r13
    b518:	41 5e                	pop    %r14
    b51a:	41 5f                	pop    %r15
    b51c:	5d                   	pop    %rbp
    b51d:	c3                   	ret
    b51e:	48 8d 35 04 3e 00 00 	lea    0x3e04(%rip),%rsi        # f329 <exec_in_fp0+0xcd9>
    b525:	48 89 df             	mov    %rbx,%rdi
    b528:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b52f:	5b                   	pop    %rbx
    b530:	41 5c                	pop    %r12
    b532:	41 5d                	pop    %r13
    b534:	41 5e                	pop    %r14
    b536:	41 5f                	pop    %r15
    b538:	5d                   	pop    %rbp
    b539:	e9 12 c5 ff ff       	jmp    7a50 <buf_puts>
    b53e:	48 8d 35 f8 3d 00 00 	lea    0x3df8(%rip),%rsi        # f33d <exec_in_fp0+0xced>
    b545:	48 89 df             	mov    %rbx,%rdi
    b548:	e8 03 c5 ff ff       	call   7a50 <buf_puts>
    b54d:	49 83 c5 10          	add    $0x10,%r13
    b551:	48 89 df             	mov    %rbx,%rdi
    b554:	4c 89 ee             	mov    %r13,%rsi
    b557:	e8 f4 c4 ff ff       	call   7a50 <buf_puts>
    b55c:	48 89 df             	mov    %rbx,%rdi
    b55f:	be 3e 00 00 00       	mov    $0x3e,%esi
    b564:	e9 fe 00 00 00       	jmp    b667 <fwp_write+0x6b7>
    b569:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    b56e:	0f 84 35 01 00 00    	je     b6a9 <fwp_write+0x6f9>
    b574:	4d 8d 77 10          	lea    0x10(%r15),%r14
    b578:	4d 85 e4             	test   %r12,%r12
    b57b:	0f 94 c0             	sete   %al
    b57e:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
    b583:	40 0f 95 c5          	setne  %bpl
    b587:	40 20 c5             	and    %al,%bpl
    b58a:	40 84 ed             	test   %bpl,%bpl
    b58d:	b8 28 00 00 00       	mov    $0x28,%eax
    b592:	be 7b 00 00 00       	mov    $0x7b,%esi
    b597:	0f 45 f0             	cmovne %eax,%esi
    b59a:	48 89 df             	mov    %rbx,%rdi
    b59d:	e8 8e c4 ff ff       	call   7a30 <buf_putc>
    b5a2:	41 83 3e 00          	cmpl   $0x0,(%r14)
    b5a6:	0f 8e a8 00 00 00    	jle    b654 <fwp_write+0x6a4>
    b5ac:	40 84 ed             	test   %bpl,%bpl
    b5af:	75 1e                	jne    b5cf <fwp_write+0x61f>
    b5b1:	49 8b 47 18          	mov    0x18(%r15),%rax
    b5b5:	48 8b 30             	mov    (%rax),%rsi
    b5b8:	48 89 df             	mov    %rbx,%rdi
    b5bb:	e8 90 c4 ff ff       	call   7a50 <buf_puts>
    b5c0:	48 8d 35 9b 3d 00 00 	lea    0x3d9b(%rip),%rsi        # f362 <exec_in_fp0+0xd12>
    b5c7:	48 89 df             	mov    %rbx,%rdi
    b5ca:	e8 81 c4 ff ff       	call   7a50 <buf_puts>
    b5cf:	49 8b 75 08          	mov    0x8(%r13),%rsi
    b5d3:	49 8b 47 20          	mov    0x20(%r15),%rax
    b5d7:	48 8b 10             	mov    (%rax),%rdx
    b5da:	48 89 df             	mov    %rbx,%rdi
    b5dd:	31 c9                	xor    %ecx,%ecx
    b5df:	e8 cc f9 ff ff       	call   afb0 <fwp_write>
    b5e4:	41 83 7f 10 02       	cmpl   $0x2,0x10(%r15)
    b5e9:	7c 69                	jl     b654 <fwp_write+0x6a4>
    b5eb:	41 be 01 00 00 00    	mov    $0x1,%r14d
    b5f1:	4c 8d 25 76 3c 00 00 	lea    0x3c76(%rip),%r12        # f26e <exec_in_fp0+0xc1e>
    b5f8:	eb 29                	jmp    b623 <fwp_write+0x673>
    b5fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    b600:	4b 8b 74 f5 08       	mov    0x8(%r13,%r14,8),%rsi
    b605:	49 8b 47 20          	mov    0x20(%r15),%rax
    b609:	4a 8b 14 f0          	mov    (%rax,%r14,8),%rdx
    b60d:	48 89 df             	mov    %rbx,%rdi
    b610:	31 c9                	xor    %ecx,%ecx
    b612:	e8 99 f9 ff ff       	call   afb0 <fwp_write>
    b617:	49 ff c6             	inc    %r14
    b61a:	49 63 47 10          	movslq 0x10(%r15),%rax
    b61e:	49 39 c6             	cmp    %rax,%r14
    b621:	7d 31                	jge    b654 <fwp_write+0x6a4>
    b623:	48 89 df             	mov    %rbx,%rdi
    b626:	4c 89 e6             	mov    %r12,%rsi
    b629:	e8 22 c4 ff ff       	call   7a50 <buf_puts>
    b62e:	40 84 ed             	test   %bpl,%bpl
    b631:	75 cd                	jne    b600 <fwp_write+0x650>
    b633:	49 8b 47 18          	mov    0x18(%r15),%rax
    b637:	4a 8b 34 f0          	mov    (%rax,%r14,8),%rsi
    b63b:	48 89 df             	mov    %rbx,%rdi
    b63e:	e8 0d c4 ff ff       	call   7a50 <buf_puts>
    b643:	48 89 df             	mov    %rbx,%rdi
    b646:	48 8d 35 15 3d 00 00 	lea    0x3d15(%rip),%rsi        # f362 <exec_in_fp0+0xd12>
    b64d:	e8 fe c3 ff ff       	call   7a50 <buf_puts>
    b652:	eb ac                	jmp    b600 <fwp_write+0x650>
    b654:	40 84 ed             	test   %bpl,%bpl
    b657:	b8 29 00 00 00       	mov    $0x29,%eax
    b65c:	be 7d 00 00 00       	mov    $0x7d,%esi
    b661:	0f 45 f0             	cmovne %eax,%esi
    b664:	48 89 df             	mov    %rbx,%rdi
    b667:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b66e:	5b                   	pop    %rbx
    b66f:	41 5c                	pop    %r12
    b671:	41 5d                	pop    %r13
    b673:	41 5e                	pop    %r14
    b675:	41 5f                	pop    %r15
    b677:	5d                   	pop    %rbp
    b678:	e9 b3 c3 ff ff       	jmp    7a30 <buf_putc>
    b67d:	5b                   	pop    %rbx
    b67e:	41 5c                	pop    %r12
    b680:	41 5d                	pop    %r13
    b682:	41 5e                	pop    %r14
    b684:	41 5f                	pop    %r15
    b686:	5d                   	pop    %rbp
    b687:	e9 14 06 00 00       	jmp    bca0 <fwp_escape>
    b68c:	49 8b 75 08          	mov    0x8(%r13),%rsi
    b690:	48 89 f2             	mov    %rsi,%rdx
    b693:	48 c1 fa 3f          	sar    $0x3f,%rdx
    b697:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    b69c:	4c 89 f7             	mov    %r14,%rdi
    b69f:	e8 0c 07 00 00       	call   bdb0 <fwp_fmt_duration>
    b6a4:	e9 58 fe ff ff       	jmp    b501 <fwp_write+0x551>
    b6a9:	48 8d 35 af 3c 00 00 	lea    0x3caf(%rip),%rsi        # f35f <exec_in_fp0+0xd0f>
    b6b0:	e9 70 fe ff ff       	jmp    b525 <fwp_write+0x575>
    b6b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b6bc:	00 00 00 00 

000000000000b6c0 <fwp_fmt_i128>:
    b6c0:	48 85 d2             	test   %rdx,%rdx
    b6c3:	79 1b                	jns    b6e0 <fwp_fmt_u128>
    b6c5:	c6 07 2d             	movb   $0x2d,(%rdi)
    b6c8:	48 ff c7             	inc    %rdi
    b6cb:	31 c0                	xor    %eax,%eax
    b6cd:	48 f7 de             	neg    %rsi
    b6d0:	48 19 d0             	sbb    %rdx,%rax
    b6d3:	48 89 c2             	mov    %rax,%rdx
    b6d6:	eb 08                	jmp    b6e0 <fwp_fmt_u128>
    b6d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    b6df:	00 

000000000000b6e0 <fwp_fmt_u128>:
    b6e0:	41 56                	push   %r14
    b6e2:	53                   	push   %rbx
    b6e3:	48 89 f0             	mov    %rsi,%rax
    b6e6:	48 09 d0             	or     %rdx,%rax
    b6e9:	0f 84 9d 00 00 00    	je     b78c <fwp_fmt_u128+0xac>
    b6ef:	48 89 d1             	mov    %rdx,%rcx
    b6f2:	45 31 d2             	xor    %r10d,%r10d
    b6f5:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    b6fc:	cc cc cc 
    b6ff:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
    b706:	cc cc cc 
    b709:	49 89 d6             	mov    %rdx,%r14
    b70c:	0f 1f 40 00          	nopl   0x0(%rax)
    b710:	49 89 c8             	mov    %rcx,%r8
    b713:	49 0f a4 f0 3f       	shld   $0x3f,%rsi,%r8
    b718:	49 d1 ee             	shr    $1,%r14
    b71b:	4d 89 c1             	mov    %r8,%r9
    b71e:	4d 01 f1             	add    %r14,%r9
    b721:	49 83 d1 00          	adc    $0x0,%r9
    b725:	4c 89 c8             	mov    %r9,%rax
    b728:	49 f7 e3             	mul    %r11
    b72b:	48 c1 ea 02          	shr    $0x2,%rdx
    b72f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    b733:	49 29 c1             	sub    %rax,%r9
    b736:	4d 29 c8             	sub    %r9,%r8
    b739:	49 83 de 00          	sbb    $0x0,%r14
    b73d:	4d 89 c1             	mov    %r8,%r9
    b740:	4c 0f af cb          	imul   %rbx,%r9
    b744:	4c 89 c0             	mov    %r8,%rax
    b747:	49 f7 e3             	mul    %r11
    b74a:	4c 01 ca             	add    %r9,%rdx
    b74d:	4d 0f af f3          	imul   %r11,%r14
    b751:	49 01 d6             	add    %rdx,%r14
    b754:	48 89 c2             	mov    %rax,%rdx
    b757:	48 01 c2             	add    %rax,%rdx
    b75a:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
    b75e:	41 89 f0             	mov    %esi,%r8d
    b761:	41 29 d0             	sub    %edx,%r8d
    b764:	41 80 c8 30          	or     $0x30,%r8b
    b768:	46 88 44 14 b8       	mov    %r8b,-0x48(%rsp,%r10,1)
    b76d:	49 ff c2             	inc    %r10
    b770:	48 83 fe 0a          	cmp    $0xa,%rsi
    b774:	48 83 d9 00          	sbb    $0x0,%rcx
    b778:	48 89 c6             	mov    %rax,%rsi
    b77b:	4c 89 f1             	mov    %r14,%rcx
    b77e:	73 90                	jae    b710 <fwp_fmt_u128+0x30>
    b780:	45 85 d2             	test   %r10d,%r10d
    b783:	7f 12                	jg     b797 <fwp_fmt_u128+0xb7>
    b785:	31 c0                	xor    %eax,%eax
    b787:	e9 56 01 00 00       	jmp    b8e2 <fwp_fmt_u128+0x202>
    b78c:	c6 44 24 b8 30       	movb   $0x30,-0x48(%rsp)
    b791:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    b797:	44 89 d0             	mov    %r10d,%eax
    b79a:	41 83 fa 08          	cmp    $0x8,%r10d
    b79e:	73 0a                	jae    b7aa <fwp_fmt_u128+0xca>
    b7a0:	31 c9                	xor    %ecx,%ecx
    b7a2:	48 89 c2             	mov    %rax,%rdx
    b7a5:	e9 10 01 00 00       	jmp    b8ba <fwp_fmt_u128+0x1da>
    b7aa:	83 f8 20             	cmp    $0x20,%eax
    b7ad:	73 07                	jae    b7b6 <fwp_fmt_u128+0xd6>
    b7af:	31 c9                	xor    %ecx,%ecx
    b7b1:	e9 a4 00 00 00       	jmp    b85a <fwp_fmt_u128+0x17a>
    b7b6:	89 c1                	mov    %eax,%ecx
    b7b8:	81 e1 e0 ff ff 7f    	and    $0x7fffffe0,%ecx
    b7be:	48 8d 54 24 b8       	lea    -0x48(%rsp),%rdx
    b7c3:	48 01 c2             	add    %rax,%rdx
    b7c6:	48 83 c2 f0          	add    $0xfffffffffffffff0,%rdx
    b7ca:	31 f6                	xor    %esi,%esi
    b7cc:	66 0f ef c0          	pxor   %xmm0,%xmm0
    b7d0:	f3 0f 6f 4a f0       	movdqu -0x10(%rdx),%xmm1
    b7d5:	f3 0f 6f 12          	movdqu (%rdx),%xmm2
    b7d9:	66 0f 6f da          	movdqa %xmm2,%xmm3
    b7dd:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    b7e1:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    b7e6:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    b7eb:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    b7f0:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    b7f4:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    b7f9:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    b7fe:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    b803:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    b807:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    b80b:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    b80f:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    b814:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    b819:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    b81e:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    b822:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    b827:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    b82c:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    b831:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    b835:	f3 0f 7f 14 37       	movdqu %xmm2,(%rdi,%rsi,1)
    b83a:	f3 0f 7f 4c 37 10    	movdqu %xmm1,0x10(%rdi,%rsi,1)
    b840:	48 83 c6 20          	add    $0x20,%rsi
    b844:	48 83 c2 e0          	add    $0xffffffffffffffe0,%rdx
    b848:	48 39 f1             	cmp    %rsi,%rcx
    b84b:	75 83                	jne    b7d0 <fwp_fmt_u128+0xf0>
    b84d:	48 39 c1             	cmp    %rax,%rcx
    b850:	0f 84 8c 00 00 00    	je     b8e2 <fwp_fmt_u128+0x202>
    b856:	a8 18                	test   $0x18,%al
    b858:	74 5b                	je     b8b5 <fwp_fmt_u128+0x1d5>
    b85a:	48 89 ce             	mov    %rcx,%rsi
    b85d:	89 c1                	mov    %eax,%ecx
    b85f:	81 e1 f8 ff ff 7f    	and    $0x7ffffff8,%ecx
    b865:	89 c2                	mov    %eax,%edx
    b867:	83 e2 07             	and    $0x7,%edx
    b86a:	49 89 c0             	mov    %rax,%r8
    b86d:	49 29 f0             	sub    %rsi,%r8
    b870:	49 01 e0             	add    %rsp,%r8
    b873:	49 83 c0 b0          	add    $0xffffffffffffffb0,%r8
    b877:	66 0f ef c0          	pxor   %xmm0,%xmm0
    b87b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    b880:	f3 41 0f 7e 08       	movq   (%r8),%xmm1
    b885:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    b889:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    b88e:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    b893:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    b898:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    b89c:	66 0f d6 0c 37       	movq   %xmm1,(%rdi,%rsi,1)
    b8a1:	48 83 c6 08          	add    $0x8,%rsi
    b8a5:	49 83 c0 f8          	add    $0xfffffffffffffff8,%r8
    b8a9:	48 39 f1             	cmp    %rsi,%rcx
    b8ac:	75 d2                	jne    b880 <fwp_fmt_u128+0x1a0>
    b8ae:	48 39 c1             	cmp    %rax,%rcx
    b8b1:	75 07                	jne    b8ba <fwp_fmt_u128+0x1da>
    b8b3:	eb 2d                	jmp    b8e2 <fwp_fmt_u128+0x202>
    b8b5:	89 c2                	mov    %eax,%edx
    b8b7:	83 e2 1f             	and    $0x1f,%edx
    b8ba:	48 8d 74 24 b8       	lea    -0x48(%rsp),%rsi
    b8bf:	48 01 f2             	add    %rsi,%rdx
    b8c2:	48 ff ca             	dec    %rdx
    b8c5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b8cc:	00 00 00 00 
    b8d0:	0f b6 32             	movzbl (%rdx),%esi
    b8d3:	40 88 34 0f          	mov    %sil,(%rdi,%rcx,1)
    b8d7:	48 ff c1             	inc    %rcx
    b8da:	48 ff ca             	dec    %rdx
    b8dd:	48 39 c8             	cmp    %rcx,%rax
    b8e0:	75 ee                	jne    b8d0 <fwp_fmt_u128+0x1f0>
    b8e2:	c6 04 07 00          	movb   $0x0,(%rdi,%rax,1)
    b8e6:	5b                   	pop    %rbx
    b8e7:	41 5e                	pop    %r14
    b8e9:	c3                   	ret
    b8ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000b8f0 <fwp_fmt_f32>:
    b8f0:	53                   	push   %rbx
    b8f1:	48 83 ec 20          	sub    $0x20,%rsp
    b8f5:	48 89 fb             	mov    %rdi,%rbx
    b8f8:	0f 2e c0             	ucomiss %xmm0,%xmm0
    b8fb:	0f 8a d8 01 00 00    	jp     bad9 <fwp_fmt_f32+0x1e9>
    b901:	0f 28 c8             	movaps %xmm0,%xmm1
    b904:	0f 28 05 f5 27 00 00 	movaps 0x27f5(%rip),%xmm0        # e100 <_IO_stdin_used+0x100>
    b90b:	0f 54 c1             	andps  %xmm1,%xmm0
    b90e:	0f 2e 05 ef 26 00 00 	ucomiss 0x26ef(%rip),%xmm0        # e004 <_IO_stdin_used+0x4>
    b915:	72 25                	jb     b93c <fwp_fmt_f32+0x4c>
    b917:	0f 57 c0             	xorps  %xmm0,%xmm0
    b91a:	0f 2e c8             	ucomiss %xmm0,%xmm1
    b91d:	48 8d 05 82 39 00 00 	lea    0x3982(%rip),%rax        # f2a6 <exec_in_fp0+0xc56>
    b924:	48 8d 35 7a 39 00 00 	lea    0x397a(%rip),%rsi        # f2a5 <exec_in_fp0+0xc55>
    b92b:	48 0f 47 f0          	cmova  %rax,%rsi
    b92f:	48 89 df             	mov    %rbx,%rdi
    b932:	48 83 c4 20          	add    $0x20,%rsp
    b936:	5b                   	pop    %rbx
    b937:	e9 74 67 ff ff       	jmp    20b0 <strcpy@plt>
    b93c:	0f 57 c0             	xorps  %xmm0,%xmm0
    b93f:	f3 0f 5a c1          	cvtss2sd %xmm1,%xmm0
    b943:	48 89 df             	mov    %rbx,%rdi
    b946:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    b94c:	be 01 00 00 00       	mov    $0x1,%esi
    b951:	0f 29 4c 24 10       	movaps %xmm1,0x10(%rsp)
    b956:	e8 95 07 00 00       	call   c0f0 <fwp_format_g>
    b95b:	48 89 df             	mov    %rbx,%rdi
    b95e:	31 f6                	xor    %esi,%esi
    b960:	e8 9b 68 ff ff       	call   2200 <strtof@plt>
    b965:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b96a:	75 06                	jne    b972 <fwp_fmt_f32+0x82>
    b96c:	0f 8b 5a 01 00 00    	jnp    bacc <fwp_fmt_f32+0x1dc>
    b972:	48 89 df             	mov    %rbx,%rdi
    b975:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b97b:	be 02 00 00 00       	mov    $0x2,%esi
    b980:	e8 6b 07 00 00       	call   c0f0 <fwp_format_g>
    b985:	48 89 df             	mov    %rbx,%rdi
    b988:	31 f6                	xor    %esi,%esi
    b98a:	e8 71 68 ff ff       	call   2200 <strtof@plt>
    b98f:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b994:	75 06                	jne    b99c <fwp_fmt_f32+0xac>
    b996:	0f 8b 30 01 00 00    	jnp    bacc <fwp_fmt_f32+0x1dc>
    b99c:	48 89 df             	mov    %rbx,%rdi
    b99f:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b9a5:	be 03 00 00 00       	mov    $0x3,%esi
    b9aa:	e8 41 07 00 00       	call   c0f0 <fwp_format_g>
    b9af:	48 89 df             	mov    %rbx,%rdi
    b9b2:	31 f6                	xor    %esi,%esi
    b9b4:	e8 47 68 ff ff       	call   2200 <strtof@plt>
    b9b9:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b9be:	75 06                	jne    b9c6 <fwp_fmt_f32+0xd6>
    b9c0:	0f 8b 06 01 00 00    	jnp    bacc <fwp_fmt_f32+0x1dc>
    b9c6:	48 89 df             	mov    %rbx,%rdi
    b9c9:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b9cf:	be 04 00 00 00       	mov    $0x4,%esi
    b9d4:	e8 17 07 00 00       	call   c0f0 <fwp_format_g>
    b9d9:	48 89 df             	mov    %rbx,%rdi
    b9dc:	31 f6                	xor    %esi,%esi
    b9de:	e8 1d 68 ff ff       	call   2200 <strtof@plt>
    b9e3:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b9e8:	75 06                	jne    b9f0 <fwp_fmt_f32+0x100>
    b9ea:	0f 8b dc 00 00 00    	jnp    bacc <fwp_fmt_f32+0x1dc>
    b9f0:	48 89 df             	mov    %rbx,%rdi
    b9f3:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b9f9:	be 05 00 00 00       	mov    $0x5,%esi
    b9fe:	e8 ed 06 00 00       	call   c0f0 <fwp_format_g>
    ba03:	48 89 df             	mov    %rbx,%rdi
    ba06:	31 f6                	xor    %esi,%esi
    ba08:	e8 f3 67 ff ff       	call   2200 <strtof@plt>
    ba0d:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    ba12:	75 06                	jne    ba1a <fwp_fmt_f32+0x12a>
    ba14:	0f 8b b2 00 00 00    	jnp    bacc <fwp_fmt_f32+0x1dc>
    ba1a:	48 89 df             	mov    %rbx,%rdi
    ba1d:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    ba23:	be 06 00 00 00       	mov    $0x6,%esi
    ba28:	e8 c3 06 00 00       	call   c0f0 <fwp_format_g>
    ba2d:	48 89 df             	mov    %rbx,%rdi
    ba30:	31 f6                	xor    %esi,%esi
    ba32:	e8 c9 67 ff ff       	call   2200 <strtof@plt>
    ba37:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    ba3c:	75 06                	jne    ba44 <fwp_fmt_f32+0x154>
    ba3e:	0f 8b 88 00 00 00    	jnp    bacc <fwp_fmt_f32+0x1dc>
    ba44:	48 89 df             	mov    %rbx,%rdi
    ba47:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    ba4d:	be 07 00 00 00       	mov    $0x7,%esi
    ba52:	e8 99 06 00 00       	call   c0f0 <fwp_format_g>
    ba57:	48 89 df             	mov    %rbx,%rdi
    ba5a:	31 f6                	xor    %esi,%esi
    ba5c:	e8 9f 67 ff ff       	call   2200 <strtof@plt>
    ba61:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    ba66:	75 02                	jne    ba6a <fwp_fmt_f32+0x17a>
    ba68:	7b 62                	jnp    bacc <fwp_fmt_f32+0x1dc>
    ba6a:	48 89 df             	mov    %rbx,%rdi
    ba6d:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    ba73:	be 08 00 00 00       	mov    $0x8,%esi
    ba78:	e8 73 06 00 00       	call   c0f0 <fwp_format_g>
    ba7d:	48 89 df             	mov    %rbx,%rdi
    ba80:	31 f6                	xor    %esi,%esi
    ba82:	e8 79 67 ff ff       	call   2200 <strtof@plt>
    ba87:	0f 28 4c 24 10       	movaps 0x10(%rsp),%xmm1
    ba8c:	0f 2e c1             	ucomiss %xmm1,%xmm0
    ba8f:	75 02                	jne    ba93 <fwp_fmt_f32+0x1a3>
    ba91:	7b 39                	jnp    bacc <fwp_fmt_f32+0x1dc>
    ba93:	48 89 df             	mov    %rbx,%rdi
    ba96:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    ba9c:	be 09 00 00 00       	mov    $0x9,%esi
    baa1:	e8 4a 06 00 00       	call   c0f0 <fwp_format_g>
    baa6:	48 89 df             	mov    %rbx,%rdi
    baa9:	31 f6                	xor    %esi,%esi
    baab:	e8 50 67 ff ff       	call   2200 <strtof@plt>
    bab0:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    bab5:	75 02                	jne    bab9 <fwp_fmt_f32+0x1c9>
    bab7:	7b 13                	jnp    bacc <fwp_fmt_f32+0x1dc>
    bab9:	48 89 df             	mov    %rbx,%rdi
    babc:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    bac2:	be 09 00 00 00       	mov    $0x9,%esi
    bac7:	e8 24 06 00 00       	call   c0f0 <fwp_format_g>
    bacc:	48 89 df             	mov    %rbx,%rdi
    bacf:	48 83 c4 20          	add    $0x20,%rsp
    bad3:	5b                   	pop    %rbx
    bad4:	e9 97 07 00 00       	jmp    c270 <fwp_finish_float>
    bad9:	c7 03 4e 61 4e 00    	movl   $0x4e614e,(%rbx)
    badf:	48 83 c4 20          	add    $0x20,%rsp
    bae3:	5b                   	pop    %rbx
    bae4:	c3                   	ret
    bae5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    baec:	00 00 00 00 

000000000000baf0 <fwp_fmt_f64>:
    baf0:	55                   	push   %rbp
    baf1:	53                   	push   %rbx
    baf2:	48 83 ec 18          	sub    $0x18,%rsp
    baf6:	48 89 fb             	mov    %rdi,%rbx
    baf9:	66 0f 2e c0          	ucomisd %xmm0,%xmm0
    bafd:	0f 8a 98 00 00 00    	jp     bb9b <fwp_fmt_f64+0xab>
    bb03:	66 0f 28 c8          	movapd %xmm0,%xmm1
    bb07:	66 0f 28 05 01 26 00 	movapd 0x2601(%rip),%xmm0        # e110 <_IO_stdin_used+0x110>
    bb0e:	00 
    bb0f:	66 0f 54 c1          	andpd  %xmm1,%xmm0
    bb13:	66 0f 2e 05 45 26 00 	ucomisd 0x2645(%rip),%xmm0        # e160 <_IO_stdin_used+0x160>
    bb1a:	00 
    bb1b:	72 28                	jb     bb45 <fwp_fmt_f64+0x55>
    bb1d:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    bb21:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
    bb25:	48 8d 05 7a 37 00 00 	lea    0x377a(%rip),%rax        # f2a6 <exec_in_fp0+0xc56>
    bb2c:	48 8d 35 72 37 00 00 	lea    0x3772(%rip),%rsi        # f2a5 <exec_in_fp0+0xc55>
    bb33:	48 0f 47 f0          	cmova  %rax,%rsi
    bb37:	48 89 df             	mov    %rbx,%rdi
    bb3a:	48 83 c4 18          	add    $0x18,%rsp
    bb3e:	5b                   	pop    %rbx
    bb3f:	5d                   	pop    %rbp
    bb40:	e9 6b 65 ff ff       	jmp    20b0 <strcpy@plt>
    bb45:	bd 01 00 00 00       	mov    $0x1,%ebp
    bb4a:	66 0f 29 0c 24       	movapd %xmm1,(%rsp)
    bb4f:	90                   	nop
    bb50:	48 89 df             	mov    %rbx,%rdi
    bb53:	66 0f 28 c1          	movapd %xmm1,%xmm0
    bb57:	89 ee                	mov    %ebp,%esi
    bb59:	e8 92 05 00 00       	call   c0f0 <fwp_format_g>
    bb5e:	48 89 df             	mov    %rbx,%rdi
    bb61:	31 f6                	xor    %esi,%esi
    bb63:	e8 98 65 ff ff       	call   2100 <strtod@plt>
    bb68:	66 0f 28 0c 24       	movapd (%rsp),%xmm1
    bb6d:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
    bb71:	75 02                	jne    bb75 <fwp_fmt_f64+0x85>
    bb73:	7b 18                	jnp    bb8d <fwp_fmt_f64+0x9d>
    bb75:	ff c5                	inc    %ebp
    bb77:	83 fd 12             	cmp    $0x12,%ebp
    bb7a:	75 d4                	jne    bb50 <fwp_fmt_f64+0x60>
    bb7c:	48 89 df             	mov    %rbx,%rdi
    bb7f:	66 0f 28 c1          	movapd %xmm1,%xmm0
    bb83:	be 11 00 00 00       	mov    $0x11,%esi
    bb88:	e8 63 05 00 00       	call   c0f0 <fwp_format_g>
    bb8d:	48 89 df             	mov    %rbx,%rdi
    bb90:	48 83 c4 18          	add    $0x18,%rsp
    bb94:	5b                   	pop    %rbx
    bb95:	5d                   	pop    %rbp
    bb96:	e9 d5 06 00 00       	jmp    c270 <fwp_finish_float>
    bb9b:	c7 03 4e 61 4e 00    	movl   $0x4e614e,(%rbx)
    bba1:	48 83 c4 18          	add    $0x18,%rsp
    bba5:	5b                   	pop    %rbx
    bba6:	5d                   	pop    %rbp
    bba7:	c3                   	ret
    bba8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    bbaf:	00 

000000000000bbb0 <fwp_trits>:
    bbb0:	55                   	push   %rbp
    bbb1:	41 57                	push   %r15
    bbb3:	41 56                	push   %r14
    bbb5:	53                   	push   %rbx
    bbb6:	50                   	push   %rax
    bbb7:	89 d5                	mov    %edx,%ebp
    bbb9:	49 89 f6             	mov    %rsi,%r14
    bbbc:	48 89 fb             	mov    %rdi,%rbx
    bbbf:	4c 63 fa             	movslq %edx,%r15
    bbc2:	49 8d 7f 03          	lea    0x3(%r15),%rdi
    bbc6:	e8 65 ac ff ff       	call   6830 <fwp_alloc_leaf>
    bbcb:	48 89 c6             	mov    %rax,%rsi
    bbce:	66 c7 00 30 74       	movw   $0x7430,(%rax)
    bbd3:	45 85 ff             	test   %r15d,%r15d
    bbd6:	0f 8e 9f 00 00 00    	jle    bc7b <fwp_trits+0xcb>
    bbdc:	89 e9                	mov    %ebp,%ecx
    bbde:	48 8d 3c 31          	lea    (%rcx,%rsi,1),%rdi
    bbe2:	48 ff c7             	inc    %rdi
    bbe5:	48 f7 d9             	neg    %rcx
    bbe8:	45 31 c0             	xor    %r8d,%r8d
    bbeb:	49 b9 56 55 55 55 55 	movabs $0x5555555555555556,%r9
    bbf2:	55 55 55 
    bbf5:	eb 35                	jmp    bc2c <fwp_trits+0x7c>
    bbf7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    bbfe:	00 00 
    bc00:	41 b3 30             	mov    $0x30,%r11b
    bc03:	46 88 1c 07          	mov    %r11b,(%rdi,%r8,1)
    bc07:	48 85 d2             	test   %rdx,%rdx
    bc0a:	0f 95 c2             	setne  %dl
    bc0d:	4d 85 f6             	test   %r14,%r14
    bc10:	41 0f 98 c3          	sets   %r11b
    bc14:	41 20 d3             	and    %dl,%r11b
    bc17:	41 0f b6 d3          	movzbl %r11b,%edx
    bc1b:	48 29 d0             	sub    %rdx,%rax
    bc1e:	4c 01 d0             	add    %r10,%rax
    bc21:	49 ff c8             	dec    %r8
    bc24:	49 89 c6             	mov    %rax,%r14
    bc27:	4c 39 c1             	cmp    %r8,%rcx
    bc2a:	74 4f                	je     bc7b <fwp_trits+0xcb>
    bc2c:	4c 89 f0             	mov    %r14,%rax
    bc2f:	49 f7 e9             	imul   %r9
    bc32:	48 89 d0             	mov    %rdx,%rax
    bc35:	48 c1 e8 3f          	shr    $0x3f,%rax
    bc39:	48 01 d0             	add    %rdx,%rax
    bc3c:	4c 8d 14 40          	lea    (%rax,%rax,2),%r10
    bc40:	4c 89 f2             	mov    %r14,%rdx
    bc43:	4c 29 d2             	sub    %r10,%rdx
    bc46:	49 f7 da             	neg    %r10
    bc49:	4d 01 f2             	add    %r14,%r10
    bc4c:	49 83 c2 03          	add    $0x3,%r10
    bc50:	48 83 fa fd          	cmp    $0xfffffffffffffffd,%rdx
    bc54:	4c 0f 42 d2          	cmovb  %rdx,%r10
    bc58:	4d 85 d2             	test   %r10,%r10
    bc5b:	74 a3                	je     bc00 <fwp_trits+0x50>
    bc5d:	49 83 fa 01          	cmp    $0x1,%r10
    bc61:	75 0d                	jne    bc70 <fwp_trits+0xc0>
    bc63:	41 b3 2b             	mov    $0x2b,%r11b
    bc66:	45 31 d2             	xor    %r10d,%r10d
    bc69:	eb 98                	jmp    bc03 <fwp_trits+0x53>
    bc6b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    bc70:	41 b3 2d             	mov    $0x2d,%r11b
    bc73:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    bc79:	eb 88                	jmp    bc03 <fwp_trits+0x53>
    bc7b:	42 c6 44 3e 02 00    	movb   $0x0,0x2(%rsi,%r15,1)
    bc81:	48 89 df             	mov    %rbx,%rdi
    bc84:	48 83 c4 08          	add    $0x8,%rsp
    bc88:	5b                   	pop    %rbx
    bc89:	41 5e                	pop    %r14
    bc8b:	41 5f                	pop    %r15
    bc8d:	5d                   	pop    %rbp
    bc8e:	e9 bd bd ff ff       	jmp    7a50 <buf_puts>
    bc93:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    bc9a:	84 00 00 00 00 00 

000000000000bca0 <fwp_escape>:
    bca0:	55                   	push   %rbp
    bca1:	41 57                	push   %r15
    bca3:	41 56                	push   %r14
    bca5:	41 55                	push   %r13
    bca7:	41 54                	push   %r12
    bca9:	53                   	push   %rbx
    bcaa:	48 83 ec 18          	sub    $0x18,%rsp
    bcae:	48 89 d3             	mov    %rdx,%rbx
    bcb1:	49 89 f7             	mov    %rsi,%r15
    bcb4:	49 89 fe             	mov    %rdi,%r14
    bcb7:	be 22 00 00 00       	mov    $0x22,%esi
    bcbc:	e8 6f bd ff ff       	call   7a30 <buf_putc>
    bcc1:	48 85 db             	test   %rbx,%rbx
    bcc4:	0f 84 c7 00 00 00    	je     bd91 <fwp_escape+0xf1>
    bcca:	48 89 e5             	mov    %rsp,%rbp
    bccd:	4c 8d 2d d8 26 00 00 	lea    0x26d8(%rip),%r13        # e3ac <_IO_stdin_used+0x3ac>
    bcd4:	45 31 e4             	xor    %r12d,%r12d
    bcd7:	eb 28                	jmp    bd01 <fwp_escape+0x61>
    bcd9:	4c 89 f7             	mov    %r14,%rdi
    bcdc:	48 8d 35 a6 36 00 00 	lea    0x36a6(%rip),%rsi        # f389 <exec_in_fp0+0xd39>
    bce3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    bcea:	84 00 00 00 00 00 
    bcf0:	e8 5b bd ff ff       	call   7a50 <buf_puts>
    bcf5:	49 ff c4             	inc    %r12
    bcf8:	4c 39 e3             	cmp    %r12,%rbx
    bcfb:	0f 84 90 00 00 00    	je     bd91 <fwp_escape+0xf1>
    bd01:	43 0f b6 0c 27       	movzbl (%r15,%r12,1),%ecx
    bd06:	8d 41 f7             	lea    -0x9(%rcx),%eax
    bd09:	83 f8 19             	cmp    $0x19,%eax
    bd0c:	77 22                	ja     bd30 <fwp_escape+0x90>
    bd0e:	49 63 44 85 00       	movslq 0x0(%r13,%rax,4),%rax
    bd13:	4c 01 e8             	add    %r13,%rax
    bd16:	ff e0                	jmp    *%rax
    bd18:	4c 89 f7             	mov    %r14,%rdi
    bd1b:	48 8d 35 64 36 00 00 	lea    0x3664(%rip),%rsi        # f386 <exec_in_fp0+0xd36>
    bd22:	eb cc                	jmp    bcf0 <fwp_escape+0x50>
    bd24:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    bd2b:	00 00 00 00 00 
    bd30:	83 f9 5c             	cmp    $0x5c,%ecx
    bd33:	75 0c                	jne    bd41 <fwp_escape+0xa1>
    bd35:	4c 89 f7             	mov    %r14,%rdi
    bd38:	48 8d 35 41 36 00 00 	lea    0x3641(%rip),%rsi        # f380 <exec_in_fp0+0xd30>
    bd3f:	eb af                	jmp    bcf0 <fwp_escape+0x50>
    bd41:	80 f9 20             	cmp    $0x20,%cl
    bd44:	72 2a                	jb     bd70 <fwp_escape+0xd0>
    bd46:	80 f9 7f             	cmp    $0x7f,%cl
    bd49:	74 25                	je     bd70 <fwp_escape+0xd0>
    bd4b:	0f be f1             	movsbl %cl,%esi
    bd4e:	4c 89 f7             	mov    %r14,%rdi
    bd51:	e8 da bc ff ff       	call   7a30 <buf_putc>
    bd56:	eb 9d                	jmp    bcf5 <fwp_escape+0x55>
    bd58:	4c 89 f7             	mov    %r14,%rdi
    bd5b:	48 8d 35 1b 36 00 00 	lea    0x361b(%rip),%rsi        # f37d <exec_in_fp0+0xd2d>
    bd62:	eb 8c                	jmp    bcf0 <fwp_escape+0x50>
    bd64:	4c 89 f7             	mov    %r14,%rdi
    bd67:	48 8d 35 15 36 00 00 	lea    0x3615(%rip),%rsi        # f383 <exec_in_fp0+0xd33>
    bd6e:	eb 80                	jmp    bcf0 <fwp_escape+0x50>
    bd70:	be 10 00 00 00       	mov    $0x10,%esi
    bd75:	48 89 ef             	mov    %rbp,%rdi
    bd78:	48 8d 15 0d 36 00 00 	lea    0x360d(%rip),%rdx        # f38c <exec_in_fp0+0xd3c>
    bd7f:	31 c0                	xor    %eax,%eax
    bd81:	e8 4a 64 ff ff       	call   21d0 <snprintf@plt>
    bd86:	4c 89 f7             	mov    %r14,%rdi
    bd89:	48 89 ee             	mov    %rbp,%rsi
    bd8c:	e9 5f ff ff ff       	jmp    bcf0 <fwp_escape+0x50>
    bd91:	4c 89 f7             	mov    %r14,%rdi
    bd94:	be 22 00 00 00       	mov    $0x22,%esi
    bd99:	48 83 c4 18          	add    $0x18,%rsp
    bd9d:	5b                   	pop    %rbx
    bd9e:	41 5c                	pop    %r12
    bda0:	41 5d                	pop    %r13
    bda2:	41 5e                	pop    %r14
    bda4:	41 5f                	pop    %r15
    bda6:	5d                   	pop    %rbp
    bda7:	e9 84 bc ff ff       	jmp    7a30 <buf_putc>
    bdac:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000bdb0 <fwp_fmt_duration>:
    bdb0:	41 57                	push   %r15
    bdb2:	41 56                	push   %r14
    bdb4:	41 54                	push   %r12
    bdb6:	53                   	push   %rbx
    bdb7:	48 83 ec 48          	sub    $0x48,%rsp
    bdbb:	49 89 d0             	mov    %rdx,%r8
    bdbe:	48 89 fb             	mov    %rdi,%rbx
    bdc1:	48 89 f0             	mov    %rsi,%rax
    bdc4:	48 09 d0             	or     %rdx,%rax
    bdc7:	0f 84 1b 02 00 00    	je     bfe8 <fwp_fmt_duration+0x238>
    bdcd:	48 b9 1d 3f c2 25 d6 	movabs $0xd2fe1d625c23f1d,%rcx
    bdd4:	e1 2f 0d 
    bdd7:	48 bf 0d b1 f3 e4 99 	movabs $0x1c52799e4f3b10d,%rdi
    bdde:	27 c5 01 
    bde1:	48 89 f0             	mov    %rsi,%rax
    bde4:	48 f7 e7             	mul    %rdi
    bde7:	48 0f af ce          	imul   %rsi,%rcx
    bdeb:	48 01 ca             	add    %rcx,%rdx
    bdee:	49 0f af f8          	imul   %r8,%rdi
    bdf2:	48 01 d7             	add    %rdx,%rdi
    bdf5:	48 b9 00 a0 34 52 a3 	movabs $0x6baf6aa35234a000,%rcx
    bdfc:	6a af 6b 
    bdff:	48 01 c1             	add    %rax,%rcx
    be02:	48 b8 37 f9 ff e2 04 	movabs $0x4e2fff937,%rax
    be09:	00 00 00 
    be0c:	48 11 f8             	adc    %rdi,%rax
    be0f:	48 89 c2             	mov    %rax,%rdx
    be12:	48 0f ac ca 0d       	shrd   $0xd,%rcx,%rdx
    be17:	48 0f a4 c8 33       	shld   $0x33,%rcx,%rax
    be1c:	48 b9 4b 23 35 aa f6 	movabs $0x9376baf6aa35234b,%rcx
    be23:	ba 76 93 
    be26:	48 39 c8             	cmp    %rcx,%rax
    be29:	48 81 da ff 2f 4e 00 	sbb    $0x4e2fff,%rdx
    be30:	0f 82 d9 01 00 00    	jb     c00f <fwp_fmt_duration+0x25f>
    be36:	48 b9 b3 b2 61 36 8c 	movabs $0xc5ce3b8c3661b2b3,%rcx
    be3d:	3b ce c5 
    be40:	48 bf c3 5f 47 6a 04 	movabs $0x1a8d52046a475fc3,%rdi
    be47:	52 8d 1a 
    be4a:	48 89 f0             	mov    %rsi,%rax
    be4d:	48 f7 e7             	mul    %rdi
    be50:	48 0f af ce          	imul   %rsi,%rcx
    be54:	48 01 ca             	add    %rcx,%rdx
    be57:	49 0f af f8          	imul   %r8,%rdi
    be5b:	48 01 d7             	add    %rdx,%rdi
    be5e:	48 b9 00 a8 16 d1 91 	movabs $0x4f473f91d116a800,%rcx
    be65:	3f 47 4f 
    be68:	48 01 c1             	add    %rax,%rcx
    be6b:	48 b8 3f 9a ff 4c 49 	movabs $0x494cff9a3f,%rax
    be72:	00 00 00 
    be75:	48 11 f8             	adc    %rdi,%rax
    be78:	48 89 c2             	mov    %rax,%rdx
    be7b:	48 0f ac ca 0b       	shrd   $0xb,%rcx,%rdx
    be80:	48 0f a4 c8 35       	shld   $0x35,%rcx,%rax
    be85:	48 b9 ab 45 74 e4 cf 	movabs $0x8fd3d1cfe47445ab,%rcx
    be8c:	d1 d3 8f 
    be8f:	48 39 c8             	cmp    %rcx,%rax
    be92:	48 81 da e6 3f 53 12 	sbb    $0x12533fe6,%rdx
    be99:	0f 82 7f 01 00 00    	jb     c01e <fwp_fmt_duration+0x26e>
    be9f:	48 b9 7e 78 b9 2f 37 	movabs $0x97157d372fb9787e,%rcx
    bea6:	7d 15 97 
    bea9:	48 0f af ce          	imul   %rsi,%rcx
    bead:	48 bf 6d 9c 2e 3a 42 	movabs $0x8e47ce423a2e9c6d,%rdi
    beb4:	ce 47 8e 
    beb7:	48 89 f0             	mov    %rsi,%rax
    beba:	48 f7 e7             	mul    %rdi
    bebd:	48 01 ca             	add    %rcx,%rdx
    bec0:	49 0f af f8          	imul   %r8,%rdi
    bec4:	48 01 d7             	add    %rdx,%rdi
    bec7:	48 b9 00 46 54 40 8b 	movabs $0xa52cb98b40544600,%rcx
    bece:	b9 2c a5 
    bed1:	48 01 c1             	add    %rax,%rcx
    bed4:	48 b8 b5 09 fa 82 4b 	movabs $0x44b82fa09b5,%rax
    bedb:	04 00 00 
    bede:	48 11 f8             	adc    %rdi,%rax
    bee1:	48 89 c2             	mov    %rax,%rdx
    bee4:	48 0f ac ca 09       	shrd   $0x9,%rcx,%rdx
    bee9:	48 0f a4 c8 37       	shld   $0x37,%rcx,%rax
    beee:	48 b9 47 54 40 8b b9 	movabs $0xb5a52cb98b405447,%rcx
    bef5:	2c a5 b5 
    bef8:	48 39 c8             	cmp    %rcx,%rax
    befb:	48 b8 09 fa 82 4b 04 	movabs $0x44b82fa09,%rax
    bf02:	00 00 00 
    bf05:	48 19 c2             	sbb    %rax,%rdx
    bf08:	0f 82 22 01 00 00    	jb     c030 <fwp_fmt_duration+0x280>
    bf0e:	48 b9 cb d5 8f 4d f2 	movabs $0xc57e23f24d8fd5cb,%rcx
    bf15:	23 7e c5 
    bf18:	48 0f af ce          	imul   %rsi,%rcx
    bf1c:	48 bf 39 61 c2 68 56 	movabs $0x790fb65668c26139,%rdi
    bf23:	b6 0f 79 
    bf26:	48 89 f0             	mov    %rsi,%rax
    bf29:	48 f7 e7             	mul    %rdi
    bf2c:	48 01 ca             	add    %rcx,%rdx
    bf2f:	49 0f af f8          	imul   %r8,%rdi
    bf33:	48 01 d7             	add    %rdx,%rdi
    bf36:	48 b9 00 0b 27 69 fe 	movabs $0xa6d698fe69270b00,%rcx
    bf3d:	98 d6 a6 
    bf40:	48 01 c1             	add    %rax,%rcx
    bf43:	48 b8 b1 bd 16 f4 de 	movabs $0x218def416bdb1,%rax
    bf4a:	18 02 00 
    bf4d:	48 11 f8             	adc    %rdi,%rax
    bf50:	48 89 c2             	mov    %rax,%rdx
    bf53:	48 0f ac ca 06       	shrd   $0x6,%rcx,%rdx
    bf58:	48 0f a4 c8 3a       	shld   $0x3a,%rcx,%rax
    bf5d:	48 b9 59 38 49 f3 c7 	movabs $0x8d36b4c7f3493859,%rcx
    bf64:	b4 36 8d 
    bf67:	48 39 c8             	cmp    %rcx,%rax
    bf6a:	48 b8 ed b5 a0 f7 c6 	movabs $0x10c6f7a0b5ed,%rax
    bf71:	10 00 00 
    bf74:	48 19 c2             	sbb    %rax,%rdx
    bf77:	0f 82 c0 00 00 00    	jb     c03d <fwp_fmt_duration+0x28d>
    bf7d:	48 b9 5a 64 3b df 4f 	movabs $0x6e978d4fdf3b645a,%rcx
    bf84:	8d 97 6e 
    bf87:	48 0f af ce          	imul   %rsi,%rcx
    bf8b:	48 bf d5 78 e9 26 31 	movabs $0x1cac083126e978d5,%rdi
    bf92:	08 ac 1c 
    bf95:	48 89 f0             	mov    %rsi,%rax
    bf98:	48 f7 e7             	mul    %rdi
    bf9b:	48 01 ca             	add    %rcx,%rdx
    bf9e:	49 0f af f8          	imul   %r8,%rdi
    bfa2:	48 01 d7             	add    %rdx,%rdi
    bfa5:	48 b9 48 62 10 58 39 	movabs $0x76c8b43958106248,%rcx
    bfac:	b4 c8 76 
    bfaf:	48 01 c1             	add    %rax,%rcx
    bfb2:	48 b8 be 9f 1a 2f dd 	movabs $0x10624dd2f1a9fbe,%rax
    bfb9:	24 06 01 
    bfbc:	48 11 f8             	adc    %rdi,%rax
    bfbf:	48 89 c2             	mov    %rax,%rdx
    bfc2:	48 0f ac ca 03       	shrd   $0x3,%rcx,%rdx
    bfc7:	48 0f a4 c8 3d       	shld   $0x3d,%rcx,%rax
    bfcc:	48 b9 93 18 04 56 0e 	movabs $0x9db22d0e56041893,%rcx
    bfd3:	2d b2 9d 
    bfd6:	48 39 c8             	cmp    %rcx,%rax
    bfd9:	48 b8 ef a7 c6 4b 37 	movabs $0x4189374bc6a7ef,%rax
    bfe0:	89 41 00 
    bfe3:	48 19 c2             	sbb    %rax,%rdx
    bfe6:	72 62                	jb     c04a <fwp_fmt_duration+0x29a>
    bfe8:	49 89 e6             	mov    %rsp,%r14
    bfeb:	4c 89 f7             	mov    %r14,%rdi
    bfee:	4c 89 c2             	mov    %r8,%rdx
    bff1:	e8 ca f6 ff ff       	call   b6c0 <fwp_fmt_i128>
    bff6:	48 8d 35 9b 33 00 00 	lea    0x339b(%rip),%rsi        # f398 <exec_in_fp0+0xd48>
    bffd:	48 89 df             	mov    %rbx,%rdi
    c000:	4c 89 f2             	mov    %r14,%rdx
    c003:	31 c0                	xor    %eax,%eax
    c005:	e8 66 64 ff ff       	call   2470 <sprintf@plt>
    c00a:	e9 84 00 00 00       	jmp    c093 <fwp_fmt_duration+0x2e3>
    c00f:	48 ba 00 a0 b8 30 46 	movabs $0x34630b8a000,%rdx
    c016:	03 00 00 
    c019:	45 31 ff             	xor    %r15d,%r15d
    c01c:	eb 37                	jmp    c055 <fwp_fmt_duration+0x2a5>
    c01e:	48 ba 00 58 47 f8 0d 	movabs $0xdf8475800,%rdx
    c025:	00 00 00 
    c028:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    c02e:	eb 25                	jmp    c055 <fwp_fmt_duration+0x2a5>
    c030:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
    c035:	41 bf 02 00 00 00    	mov    $0x2,%r15d
    c03b:	eb 18                	jmp    c055 <fwp_fmt_duration+0x2a5>
    c03d:	ba 40 42 0f 00       	mov    $0xf4240,%edx
    c042:	41 bf 03 00 00 00    	mov    $0x3,%r15d
    c048:	eb 0b                	jmp    c055 <fwp_fmt_duration+0x2a5>
    c04a:	ba e8 03 00 00       	mov    $0x3e8,%edx
    c04f:	41 bf 04 00 00 00    	mov    $0x4,%r15d
    c055:	31 c9                	xor    %ecx,%ecx
    c057:	41 c1 e7 04          	shl    $0x4,%r15d
    c05b:	4c 8d 25 ce 7c 00 00 	lea    0x7cce(%rip),%r12        # 13d30 <fwp_fmt_duration.units>
    c062:	48 89 f7             	mov    %rsi,%rdi
    c065:	4c 89 c6             	mov    %r8,%rsi
    c068:	e8 23 0f 00 00       	call   cf90 <__divti3>
    c06d:	49 89 e6             	mov    %rsp,%r14
    c070:	4c 89 f7             	mov    %r14,%rdi
    c073:	48 89 c6             	mov    %rax,%rsi
    c076:	e8 45 f6 ff ff       	call   b6c0 <fwp_fmt_i128>
    c07b:	4b 8b 0c 27          	mov    (%r15,%r12,1),%rcx
    c07f:	48 8d 35 0d 33 00 00 	lea    0x330d(%rip),%rsi        # f393 <exec_in_fp0+0xd43>
    c086:	48 89 df             	mov    %rbx,%rdi
    c089:	4c 89 f2             	mov    %r14,%rdx
    c08c:	31 c0                	xor    %eax,%eax
    c08e:	e8 dd 63 ff ff       	call   2470 <sprintf@plt>
    c093:	48 83 c4 48          	add    $0x48,%rsp
    c097:	5b                   	pop    %rbx
    c098:	41 5c                	pop    %r12
    c09a:	41 5e                	pop    %r14
    c09c:	41 5f                	pop    %r15
    c09e:	c3                   	ret
    c09f:	90                   	nop

000000000000c0a0 <fwp_needs_parens>:
    c0a0:	8b 06                	mov    (%rsi),%eax
    c0a2:	83 f8 10             	cmp    $0x10,%eax
    c0a5:	74 16                	je     c0bd <fwp_needs_parens+0x1d>
    c0a7:	83 f8 0e             	cmp    $0xe,%eax
    c0aa:	0f 85 30 02 00 00    	jne    c2e0 <fwp_is_negative>
    c0b0:	31 c0                	xor    %eax,%eax
    c0b2:	48 81 ff 00 10 00 00 	cmp    $0x1000,%rdi
    c0b9:	0f 93 c0             	setae  %al
    c0bc:	c3                   	ret
    c0bd:	48 8b 46 08          	mov    0x8(%rsi),%rax
    c0c1:	48 85 c0             	test   %rax,%rax
    c0c4:	0f 84 16 02 00 00    	je     c2e0 <fwp_is_negative>
    c0ca:	50                   	push   %rax
    c0cb:	48 8d 35 b9 31 00 00 	lea    0x31b9(%rip),%rsi        # f28b <exec_in_fp0+0xc3b>
    c0d2:	48 89 c7             	mov    %rax,%rdi
    c0d5:	e8 f6 61 ff ff       	call   22d0 <strcmp@plt>
    c0da:	89 c1                	mov    %eax,%ecx
    c0dc:	31 c0                	xor    %eax,%eax
    c0de:	85 c9                	test   %ecx,%ecx
    c0e0:	0f 95 c0             	setne  %al
    c0e3:	48 83 c4 08          	add    $0x8,%rsp
    c0e7:	c3                   	ret
    c0e8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c0ef:	00 

000000000000c0f0 <fwp_format_g>:
    c0f0:	55                   	push   %rbp
    c0f1:	41 57                	push   %r15
    c0f3:	41 56                	push   %r14
    c0f5:	41 55                	push   %r13
    c0f7:	41 54                	push   %r12
    c0f9:	53                   	push   %rbx
    c0fa:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    c101:	89 f5                	mov    %esi,%ebp
    c103:	48 89 fb             	mov    %rdi,%rbx
    c106:	ff cd                	dec    %ebp
    c108:	48 8d 15 57 32 00 00 	lea    0x3257(%rip),%rdx        # f366 <exec_in_fp0+0xd16>
    c10f:	4c 8d 64 24 50       	lea    0x50(%rsp),%r12
    c114:	be 40 00 00 00       	mov    $0x40,%esi
    c119:	4c 89 e7             	mov    %r12,%rdi
    c11c:	89 e9                	mov    %ebp,%ecx
    c11e:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    c124:	b0 01                	mov    $0x1,%al
    c126:	e8 a5 60 ff ff       	call   21d0 <snprintf@plt>
    c12b:	4c 89 e7             	mov    %r12,%rdi
    c12e:	be 65 00 00 00       	mov    $0x65,%esi
    c133:	e8 78 60 ff ff       	call   21b0 <strchr@plt>
    c138:	49 89 c7             	mov    %rax,%r15
    c13b:	48 8d 78 01          	lea    0x1(%rax),%rdi
    c13f:	e8 1c 63 ff ff       	call   2460 <atoi@plt>
    c144:	41 89 c6             	mov    %eax,%r14d
    c147:	41 8d 46 ef          	lea    -0x11(%r14),%eax
    c14b:	83 f8 e9             	cmp    $0xffffffe9,%eax
    c14e:	77 58                	ja     c1a8 <fwp_format_g+0xb8>
    c150:	4d 29 e7             	sub    %r12,%r15
    c153:	4c 8d 6c 24 10       	lea    0x10(%rsp),%r13
    c158:	4c 89 ef             	mov    %r13,%rdi
    c15b:	4c 89 e6             	mov    %r12,%rsi
    c15e:	4c 89 fa             	mov    %r15,%rdx
    c161:	e8 ca 61 ff ff       	call   2330 <memcpy@plt>
    c166:	42 c6 44 3c 10 00    	movb   $0x0,0x10(%rsp,%r15,1)
    c16c:	4c 89 ef             	mov    %r13,%rdi
    c16f:	be 2e 00 00 00       	mov    $0x2e,%esi
    c174:	e8 37 60 ff ff       	call   21b0 <strchr@plt>
    c179:	48 85 c0             	test   %rax,%rax
    c17c:	0f 84 91 00 00 00    	je     c213 <fwp_format_g+0x123>
    c182:	4d 85 ff             	test   %r15,%r15
    c185:	0f 84 88 00 00 00    	je     c213 <fwp_format_g+0x123>
    c18b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    c190:	42 0f b6 44 3c 0f    	movzbl 0xf(%rsp,%r15,1),%eax
    c196:	83 f8 30             	cmp    $0x30,%eax
    c199:	75 6d                	jne    c208 <fwp_format_g+0x118>
    c19b:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    c1a1:	49 ff cf             	dec    %r15
    c1a4:	75 ea                	jne    c190 <fwp_format_g+0xa0>
    c1a6:	eb 6b                	jmp    c213 <fwp_format_g+0x123>
    c1a8:	44 29 f5             	sub    %r14d,%ebp
    c1ab:	31 c9                	xor    %ecx,%ecx
    c1ad:	85 ed                	test   %ebp,%ebp
    c1af:	0f 4f cd             	cmovg  %ebp,%ecx
    c1b2:	48 8d 15 bc 31 00 00 	lea    0x31bc(%rip),%rdx        # f375 <exec_in_fp0+0xd25>
    c1b9:	be 90 01 00 00       	mov    $0x190,%esi
    c1be:	48 89 df             	mov    %rbx,%rdi
    c1c1:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    c1c7:	b0 01                	mov    $0x1,%al
    c1c9:	e8 02 60 ff ff       	call   21d0 <snprintf@plt>
    c1ce:	48 89 df             	mov    %rbx,%rdi
    c1d1:	e8 9a 5f ff ff       	call   2170 <strlen@plt>
    c1d6:	49 89 c6             	mov    %rax,%r14
    c1d9:	48 89 df             	mov    %rbx,%rdi
    c1dc:	be 2e 00 00 00       	mov    $0x2e,%esi
    c1e1:	e8 ca 5f ff ff       	call   21b0 <strchr@plt>
    c1e6:	48 85 c0             	test   %rax,%rax
    c1e9:	74 5b                	je     c246 <fwp_format_g+0x156>
    c1eb:	4d 85 f6             	test   %r14,%r14
    c1ee:	74 56                	je     c246 <fwp_format_g+0x156>
    c1f0:	42 0f b6 44 33 ff    	movzbl -0x1(%rbx,%r14,1),%eax
    c1f6:	83 f8 30             	cmp    $0x30,%eax
    c1f9:	75 5d                	jne    c258 <fwp_format_g+0x168>
    c1fb:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    c201:	49 ff ce             	dec    %r14
    c204:	75 ea                	jne    c1f0 <fwp_format_g+0x100>
    c206:	eb 3e                	jmp    c246 <fwp_format_g+0x156>
    c208:	83 f8 2e             	cmp    $0x2e,%eax
    c20b:	75 06                	jne    c213 <fwp_format_g+0x123>
    c20d:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    c213:	44 89 f0             	mov    %r14d,%eax
    c216:	c1 e8 1f             	shr    $0x1f,%eax
    c219:	44 8d 04 45 2b 00 00 	lea    0x2b(,%rax,2),%r8d
    c220:	00 
    c221:	45 89 f1             	mov    %r14d,%r9d
    c224:	41 f7 d9             	neg    %r9d
    c227:	45 0f 48 ce          	cmovs  %r14d,%r9d
    c22b:	48 8d 15 39 31 00 00 	lea    0x3139(%rip),%rdx        # f36b <exec_in_fp0+0xd1b>
    c232:	48 8d 4c 24 10       	lea    0x10(%rsp),%rcx
    c237:	be 90 01 00 00       	mov    $0x190,%esi
    c23c:	48 89 df             	mov    %rbx,%rdi
    c23f:	31 c0                	xor    %eax,%eax
    c241:	e8 8a 5f ff ff       	call   21d0 <snprintf@plt>
    c246:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    c24d:	5b                   	pop    %rbx
    c24e:	41 5c                	pop    %r12
    c250:	41 5d                	pop    %r13
    c252:	41 5e                	pop    %r14
    c254:	41 5f                	pop    %r15
    c256:	5d                   	pop    %rbp
    c257:	c3                   	ret
    c258:	83 f8 2e             	cmp    $0x2e,%eax
    c25b:	75 e9                	jne    c246 <fwp_format_g+0x156>
    c25d:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    c263:	eb e1                	jmp    c246 <fwp_format_g+0x156>
    c265:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    c26c:	00 00 00 00 

000000000000c270 <fwp_finish_float>:
    c270:	53                   	push   %rbx
    c271:	48 89 fb             	mov    %rdi,%rbx
    c274:	be 2e 00 00 00       	mov    $0x2e,%esi
    c279:	e8 32 5f ff ff       	call   21b0 <strchr@plt>
    c27e:	48 85 c0             	test   %rax,%rax
    c281:	74 02                	je     c285 <fwp_finish_float+0x15>
    c283:	5b                   	pop    %rbx
    c284:	c3                   	ret
    c285:	48 89 df             	mov    %rbx,%rdi
    c288:	be 65 00 00 00       	mov    $0x65,%esi
    c28d:	e8 1e 5f ff ff       	call   21b0 <strchr@plt>
    c292:	48 85 c0             	test   %rax,%rax
    c295:	75 ec                	jne    c283 <fwp_finish_float+0x13>
    c297:	48 8d 35 08 30 00 00 	lea    0x3008(%rip),%rsi        # f2a6 <exec_in_fp0+0xc56>
    c29e:	48 89 df             	mov    %rbx,%rdi
    c2a1:	e8 4a 62 ff ff       	call   24f0 <strstr@plt>
    c2a6:	48 85 c0             	test   %rax,%rax
    c2a9:	75 d8                	jne    c283 <fwp_finish_float+0x13>
    c2ab:	48 8d 35 f8 2f 00 00 	lea    0x2ff8(%rip),%rsi        # f2aa <exec_in_fp0+0xc5a>
    c2b2:	48 89 df             	mov    %rbx,%rdi
    c2b5:	e8 36 62 ff ff       	call   24f0 <strstr@plt>
    c2ba:	48 85 c0             	test   %rax,%rax
    c2bd:	75 c4                	jne    c283 <fwp_finish_float+0x13>
    c2bf:	48 89 df             	mov    %rbx,%rdi
    c2c2:	e8 a9 5e ff ff       	call   2170 <strlen@plt>
    c2c7:	66 c7 04 03 2e 30    	movw   $0x302e,(%rbx,%rax,1)
    c2cd:	c6 44 03 02 00       	movb   $0x0,0x2(%rbx,%rax,1)
    c2d2:	5b                   	pop    %rbx
    c2d3:	c3                   	ret
    c2d4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    c2db:	00 00 00 00 00 

000000000000c2e0 <fwp_is_negative>:
    c2e0:	50                   	push   %rax
    c2e1:	8b 0e                	mov    (%rsi),%ecx
    c2e3:	31 c0                	xor    %eax,%eax
    c2e5:	48 83 f9 0b          	cmp    $0xb,%rcx
    c2e9:	77 16                	ja     c301 <fwp_is_negative+0x21>
    c2eb:	48 8d 15 22 21 00 00 	lea    0x2122(%rip),%rdx        # e414 <_IO_stdin_used+0x414>
    c2f2:	48 63 0c 8a          	movslq (%rdx,%rcx,4),%rcx
    c2f6:	48 01 d1             	add    %rdx,%rcx
    c2f9:	ff e1                	jmp    *%rcx
    c2fb:	48 c1 ef 3f          	shr    $0x3f,%rdi
    c2ff:	89 f8                	mov    %edi,%eax
    c301:	59                   	pop    %rcx
    c302:	c3                   	ret
    c303:	e8 a8 6d ff ff       	call   30b0 <fwp_f32>
    c308:	0f 50 c0             	movmskps %xmm0,%eax
    c30b:	eb 09                	jmp    c316 <fwp_is_negative+0x36>
    c30d:	e8 9e 98 ff ff       	call   5bb0 <fwp_f64>
    c312:	66 0f 50 c0          	movmskpd %xmm0,%eax
    c316:	83 e0 01             	and    $0x1,%eax
    c319:	59                   	pop    %rcx
    c31a:	c3                   	ret
    c31b:	e8 d0 dd ff ff       	call   a0f0 <fwp_i128>
    c320:	48 89 d0             	mov    %rdx,%rax
    c323:	48 c1 e8 3f          	shr    $0x3f,%rax
    c327:	59                   	pop    %rcx
    c328:	c3                   	ret
    c329:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000c330 <fwp_emit>:
    c330:	53                   	push   %rbx
    c331:	48 83 ec 30          	sub    $0x30,%rsp
    c335:	48 89 f8             	mov    %rdi,%rax
    c338:	83 3d e1 9a 01 00 00 	cmpl   $0x0,0x19ae1(%rip)        # 25e20 <fwp_exec_binary_out>
    c33f:	74 66                	je     c3a7 <fwp_emit+0x77>
    c341:	0f 57 c0             	xorps  %xmm0,%xmm0
    c344:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    c349:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    c350:	00 00 
    c352:	48 8d 15 77 99 00 00 	lea    0x9977(%rip),%rdx        # 15cd0 <d1>
    c359:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    c35e:	48 89 c6             	mov    %rax,%rsi
    c361:	e8 9a 00 00 00       	call   c400 <fwp_encode>
    c366:	c6 44 24 0b 01       	movb   $0x1,0xb(%rsp)
    c36b:	8b 44 24 18          	mov    0x18(%rsp),%eax
    c36f:	89 44 24 0c          	mov    %eax,0xc(%rsp)
    c373:	48 8d 7c 24 0b       	lea    0xb(%rsp),%rdi
    c378:	be 05 00 00 00       	mov    $0x5,%esi
    c37d:	e8 2e a8 ff ff       	call   6bb0 <fwp_pipe_write>
    c382:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    c387:	48 85 f6             	test   %rsi,%rsi
    c38a:	74 0a                	je     c396 <fwp_emit+0x66>
    c38c:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    c391:	e8 1a a8 ff ff       	call   6bb0 <fwp_pipe_write>
    c396:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    c39b:	e8 b0 5c ff ff       	call   2050 <free@plt>
    c3a0:	e8 9b 02 00 00       	call   c640 <fwp_pipe_frame_done>
    c3a5:	eb 1c                	jmp    c3c3 <fwp_emit+0x93>
    c3a7:	83 3d 22 99 00 00 10 	cmpl   $0x10,0x9922(%rip)        # 15cd0 <d1>
    c3ae:	75 19                	jne    c3c9 <fwp_emit+0x99>
    c3b0:	83 3d 29 99 00 00 00 	cmpl   $0x0,0x9929(%rip)        # 15ce0 <d1+0x10>
    c3b7:	75 10                	jne    c3c9 <fwp_emit+0x99>
    c3b9:	48 83 3d 17 99 00 00 	cmpq   $0x0,0x9917(%rip)        # 15cd8 <d1+0x8>
    c3c0:	00 
    c3c1:	75 06                	jne    c3c9 <fwp_emit+0x99>
    c3c3:	48 83 c4 30          	add    $0x30,%rsp
    c3c7:	5b                   	pop    %rbx
    c3c8:	c3                   	ret
    c3c9:	48 8b 1d e8 7b 00 00 	mov    0x7be8(%rip),%rbx        # 13fb8 <stdout@GLIBC_2.2.5>
    c3d0:	48 8b 13             	mov    (%rbx),%rdx
    c3d3:	48 8d 35 f6 98 00 00 	lea    0x98f6(%rip),%rsi        # 15cd0 <d1>
    c3da:	48 89 c7             	mov    %rax,%rdi
    c3dd:	e8 6e eb ff ff       	call   af50 <fwp_display_top>
    c3e2:	48 8b 33             	mov    (%rbx),%rsi
    c3e5:	bf 0a 00 00 00       	mov    $0xa,%edi
    c3ea:	48 83 c4 30          	add    $0x30,%rsp
    c3ee:	5b                   	pop    %rbx
    c3ef:	e9 4c 5e ff ff       	jmp    2240 <fputc@plt>
    c3f4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    c3fb:	00 00 00 00 00 

000000000000c400 <fwp_encode>:
    c400:	41 57                	push   %r15
    c402:	41 56                	push   %r14
    c404:	41 55                	push   %r13
    c406:	41 54                	push   %r12
    c408:	53                   	push   %rbx
    c409:	8b 02                	mov    (%rdx),%eax
    c40b:	48 83 f8 15          	cmp    $0x15,%rax
    c40f:	0f 87 14 02 00 00    	ja     c629 <fwp_encode+0x229>
    c415:	49 89 d7             	mov    %rdx,%r15
    c418:	49 89 f6             	mov    %rsi,%r14
    c41b:	48 89 fb             	mov    %rdi,%rbx
    c41e:	48 8d 0d 1f 20 00 00 	lea    0x201f(%rip),%rcx        # e444 <_IO_stdin_used+0x444>
    c425:	48 63 04 81          	movslq (%rcx,%rax,4),%rax
    c429:	48 01 c8             	add    %rcx,%rax
    c42c:	ff e0                	jmp    *%rax
    c42e:	48 89 df             	mov    %rbx,%rdi
    c431:	4c 89 f6             	mov    %r14,%rsi
    c434:	ba 01 00 00 00       	mov    $0x1,%edx
    c439:	e9 77 01 00 00       	jmp    c5b5 <fwp_encode+0x1b5>
    c43e:	48 89 df             	mov    %rbx,%rdi
    c441:	4c 89 f6             	mov    %r14,%rsi
    c444:	ba 04 00 00 00       	mov    $0x4,%edx
    c449:	e9 67 01 00 00       	jmp    c5b5 <fwp_encode+0x1b5>
    c44e:	49 8b 36             	mov    (%r14),%rsi
    c451:	48 89 df             	mov    %rbx,%rdi
    c454:	e8 57 02 00 00       	call   c6b0 <fwp_leb128>
    c459:	49 8b 16             	mov    (%r14),%rdx
    c45c:	49 83 c6 08          	add    $0x8,%r14
    c460:	48 89 df             	mov    %rbx,%rdi
    c463:	4c 89 f6             	mov    %r14,%rsi
    c466:	5b                   	pop    %rbx
    c467:	41 5c                	pop    %r12
    c469:	41 5d                	pop    %r13
    c46b:	41 5e                	pop    %r14
    c46d:	41 5f                	pop    %r15
    c46f:	e9 0c b6 ff ff       	jmp    7a80 <buf_put>
    c474:	48 89 df             	mov    %rbx,%rdi
    c477:	4c 89 f6             	mov    %r14,%rsi
    c47a:	ba 02 00 00 00       	mov    $0x2,%edx
    c47f:	e9 31 01 00 00       	jmp    c5b5 <fwp_encode+0x1b5>
    c484:	49 8b 36             	mov    (%r14),%rsi
    c487:	48 89 df             	mov    %rbx,%rdi
    c48a:	e8 21 02 00 00       	call   c6b0 <fwp_leb128>
    c48f:	49 83 3e 00          	cmpq   $0x0,(%r14)
    c493:	0f 84 90 01 00 00    	je     c629 <fwp_encode+0x229>
    c499:	4d 8d 66 10          	lea    0x10(%r14),%r12
    c49d:	45 31 ed             	xor    %r13d,%r13d
    c4a0:	eb 1e                	jmp    c4c0 <fwp_encode+0xc0>
    c4a2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c4a9:	1f 84 00 00 00 00 00 
    c4b0:	49 ff c5             	inc    %r13
    c4b3:	49 83 c4 10          	add    $0x10,%r12
    c4b7:	4d 3b 2e             	cmp    (%r14),%r13
    c4ba:	0f 83 69 01 00 00    	jae    c629 <fwp_encode+0x229>
    c4c0:	49 8b 74 24 f8       	mov    -0x8(%r12),%rsi
    c4c5:	49 8b 57 38          	mov    0x38(%r15),%rdx
    c4c9:	48 89 df             	mov    %rbx,%rdi
    c4cc:	e8 2f ff ff ff       	call   c400 <fwp_encode>
    c4d1:	41 83 3f 12          	cmpl   $0x12,(%r15)
    c4d5:	75 d9                	jne    c4b0 <fwp_encode+0xb0>
    c4d7:	49 8b 34 24          	mov    (%r12),%rsi
    c4db:	49 8b 57 40          	mov    0x40(%r15),%rdx
    c4df:	48 89 df             	mov    %rbx,%rdi
    c4e2:	e8 19 ff ff ff       	call   c400 <fwp_encode>
    c4e7:	eb c7                	jmp    c4b0 <fwp_encode+0xb0>
    c4e9:	4c 89 f7             	mov    %r14,%rdi
    c4ec:	e8 4f dc ff ff       	call   a140 <fwp_tag>
    c4f1:	41 89 c4             	mov    %eax,%r12d
    c4f4:	48 89 df             	mov    %rbx,%rdi
    c4f7:	4c 89 e6             	mov    %r12,%rsi
    c4fa:	e8 b1 01 00 00       	call   c6b0 <fwp_leb128>
    c4ff:	49 8b 47 28          	mov    0x28(%r15),%rax
    c503:	42 83 3c a0 00       	cmpl   $0x0,(%rax,%r12,4)
    c508:	0f 8e 1b 01 00 00    	jle    c629 <fwp_encode+0x229>
    c50e:	45 31 ed             	xor    %r13d,%r13d
    c511:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c518:	0f 1f 84 00 00 00 00 
    c51f:	00 
    c520:	4b 8b 74 ee 08       	mov    0x8(%r14,%r13,8),%rsi
    c525:	49 8b 47 30          	mov    0x30(%r15),%rax
    c529:	4a 8b 04 e0          	mov    (%rax,%r12,8),%rax
    c52d:	4a 8b 14 e8          	mov    (%rax,%r13,8),%rdx
    c531:	48 89 df             	mov    %rbx,%rdi
    c534:	e8 c7 fe ff ff       	call   c400 <fwp_encode>
    c539:	49 ff c5             	inc    %r13
    c53c:	49 8b 47 28          	mov    0x28(%r15),%rax
    c540:	4a 63 04 a0          	movslq (%rax,%r12,4),%rax
    c544:	49 39 c5             	cmp    %rax,%r13
    c547:	7c d7                	jl     c520 <fwp_encode+0x120>
    c549:	e9 db 00 00 00       	jmp    c629 <fwp_encode+0x229>
    c54e:	4c 89 f7             	mov    %r14,%rdi
    c551:	e8 9a db ff ff       	call   a0f0 <fwp_i128>
    c556:	eb 3f                	jmp    c597 <fwp_encode+0x197>
    c558:	4c 89 f7             	mov    %r14,%rdi
    c55b:	e8 80 d6 ff ff       	call   9be0 <fwp_list_len>
    c560:	48 89 df             	mov    %rbx,%rdi
    c563:	48 89 c6             	mov    %rax,%rsi
    c566:	e8 45 01 00 00       	call   c6b0 <fwp_leb128>
    c56b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    c570:	4d 85 f6             	test   %r14,%r14
    c573:	0f 84 b0 00 00 00    	je     c629 <fwp_encode+0x229>
    c579:	49 8b 76 08          	mov    0x8(%r14),%rsi
    c57d:	49 8b 57 38          	mov    0x38(%r15),%rdx
    c581:	48 89 df             	mov    %rbx,%rdi
    c584:	e8 77 fe ff ff       	call   c400 <fwp_encode>
    c589:	4d 8b 76 10          	mov    0x10(%r14),%r14
    c58d:	eb e1                	jmp    c570 <fwp_encode+0x170>
    c58f:	4c 89 f7             	mov    %r14,%rdi
    c592:	e8 69 db ff ff       	call   a100 <fwp_u128>
    c597:	49 89 d6             	mov    %rdx,%r14
    c59a:	48 89 df             	mov    %rbx,%rdi
    c59d:	48 89 c6             	mov    %rax,%rsi
    c5a0:	ba 08 00 00 00       	mov    $0x8,%edx
    c5a5:	e8 b6 00 00 00       	call   c660 <fwp_le>
    c5aa:	48 89 df             	mov    %rbx,%rdi
    c5ad:	4c 89 f6             	mov    %r14,%rsi
    c5b0:	ba 08 00 00 00       	mov    $0x8,%edx
    c5b5:	5b                   	pop    %rbx
    c5b6:	41 5c                	pop    %r12
    c5b8:	41 5d                	pop    %r13
    c5ba:	41 5e                	pop    %r14
    c5bc:	41 5f                	pop    %r15
    c5be:	e9 9d 00 00 00       	jmp    c660 <fwp_le>
    c5c3:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    c5c8:	7e 5f                	jle    c629 <fwp_encode+0x229>
    c5ca:	45 31 e4             	xor    %r12d,%r12d
    c5cd:	0f 1f 00             	nopl   (%rax)
    c5d0:	4b 8b 74 e6 08       	mov    0x8(%r14,%r12,8),%rsi
    c5d5:	49 8b 47 20          	mov    0x20(%r15),%rax
    c5d9:	4a 8b 14 e0          	mov    (%rax,%r12,8),%rdx
    c5dd:	48 89 df             	mov    %rbx,%rdi
    c5e0:	e8 1b fe ff ff       	call   c400 <fwp_encode>
    c5e5:	49 ff c4             	inc    %r12
    c5e8:	49 63 47 10          	movslq 0x10(%r15),%rax
    c5ec:	49 39 c4             	cmp    %rax,%r12
    c5ef:	7c df                	jl     c5d0 <fwp_encode+0x1d0>
    c5f1:	eb 36                	jmp    c629 <fwp_encode+0x229>
    c5f3:	49 8b 36             	mov    (%r14),%rsi
    c5f6:	48 89 df             	mov    %rbx,%rdi
    c5f9:	e8 b2 00 00 00       	call   c6b0 <fwp_leb128>
    c5fe:	49 83 3e 00          	cmpq   $0x0,(%r14)
    c602:	74 25                	je     c629 <fwp_encode+0x229>
    c604:	45 31 e4             	xor    %r12d,%r12d
    c607:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    c60e:	00 00 
    c610:	4b 8b 74 e6 08       	mov    0x8(%r14,%r12,8),%rsi
    c615:	49 8b 57 38          	mov    0x38(%r15),%rdx
    c619:	48 89 df             	mov    %rbx,%rdi
    c61c:	e8 df fd ff ff       	call   c400 <fwp_encode>
    c621:	49 ff c4             	inc    %r12
    c624:	4d 3b 26             	cmp    (%r14),%r12
    c627:	72 e7                	jb     c610 <fwp_encode+0x210>
    c629:	5b                   	pop    %rbx
    c62a:	41 5c                	pop    %r12
    c62c:	41 5d                	pop    %r13
    c62e:	41 5e                	pop    %r14
    c630:	41 5f                	pop    %r15
    c632:	c3                   	ret
    c633:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c63a:	84 00 00 00 00 00 

000000000000c640 <fwp_pipe_frame_done>:
    c640:	83 3d 75 96 00 00 00 	cmpl   $0x0,0x9675(%rip)        # 15cbc <fwp_po_listen>
    c647:	78 16                	js     c65f <fwp_pipe_frame_done+0x1f>
    c649:	8b 05 21 98 02 00    	mov    0x29821(%rip),%eax        # 35e70 <fwp_po_frames>
    c64f:	ff c0                	inc    %eax
    c651:	89 05 19 98 02 00    	mov    %eax,0x29819(%rip)        # 35e70 <fwp_po_frames>
    c657:	a8 3f                	test   $0x3f,%al
    c659:	0f 84 11 e0 ff ff    	je     a670 <fwp_pipe_poll>
    c65f:	c3                   	ret

000000000000c660 <fwp_le>:
    c660:	85 d2                	test   %edx,%edx
    c662:	7e 44                	jle    c6a8 <fwp_le+0x48>
    c664:	41 57                	push   %r15
    c666:	41 56                	push   %r14
    c668:	41 54                	push   %r12
    c66a:	53                   	push   %rbx
    c66b:	50                   	push   %rax
    c66c:	48 89 f3             	mov    %rsi,%rbx
    c66f:	49 89 fe             	mov    %rdi,%r14
    c672:	41 89 d4             	mov    %edx,%r12d
    c675:	49 c1 e4 03          	shl    $0x3,%r12
    c679:	45 31 ff             	xor    %r15d,%r15d
    c67c:	0f 1f 40 00          	nopl   0x0(%rax)
    c680:	48 89 d8             	mov    %rbx,%rax
    c683:	44 89 f9             	mov    %r15d,%ecx
    c686:	48 d3 e8             	shr    %cl,%rax
    c689:	0f be f0             	movsbl %al,%esi
    c68c:	4c 89 f7             	mov    %r14,%rdi
    c68f:	e8 9c b3 ff ff       	call   7a30 <buf_putc>
    c694:	49 83 c7 08          	add    $0x8,%r15
    c698:	4d 39 fc             	cmp    %r15,%r12
    c69b:	75 e3                	jne    c680 <fwp_le+0x20>
    c69d:	48 83 c4 08          	add    $0x8,%rsp
    c6a1:	5b                   	pop    %rbx
    c6a2:	41 5c                	pop    %r12
    c6a4:	41 5e                	pop    %r14
    c6a6:	41 5f                	pop    %r15
    c6a8:	c3                   	ret
    c6a9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000c6b0 <fwp_leb128>:
    c6b0:	41 57                	push   %r15
    c6b2:	41 56                	push   %r14
    c6b4:	53                   	push   %rbx
    c6b5:	49 89 f6             	mov    %rsi,%r14
    c6b8:	48 89 fb             	mov    %rdi,%rbx
    c6bb:	48 81 fe 80 00 00 00 	cmp    $0x80,%rsi
    c6c2:	73 05                	jae    c6c9 <fwp_leb128+0x19>
    c6c4:	4d 89 f7             	mov    %r14,%r15
    c6c7:	eb 27                	jmp    c6f0 <fwp_leb128+0x40>
    c6c9:	4d 89 f7             	mov    %r14,%r15
    c6cc:	0f 1f 40 00          	nopl   0x0(%rax)
    c6d0:	49 c1 ef 07          	shr    $0x7,%r15
    c6d4:	44 89 f0             	mov    %r14d,%eax
    c6d7:	0c 80                	or     $0x80,%al
    c6d9:	0f be f0             	movsbl %al,%esi
    c6dc:	48 89 df             	mov    %rbx,%rdi
    c6df:	e8 4c b3 ff ff       	call   7a30 <buf_putc>
    c6e4:	49 81 fe ff 3f 00 00 	cmp    $0x3fff,%r14
    c6eb:	4d 89 fe             	mov    %r15,%r14
    c6ee:	77 e0                	ja     c6d0 <fwp_leb128+0x20>
    c6f0:	41 0f be f7          	movsbl %r15b,%esi
    c6f4:	48 89 df             	mov    %rbx,%rdi
    c6f7:	5b                   	pop    %rbx
    c6f8:	41 5e                	pop    %r14
    c6fa:	41 5f                	pop    %r15
    c6fc:	e9 2f b3 ff ff       	jmp    7a30 <buf_putc>
    c701:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c708:	0f 1f 84 00 00 00 00 
    c70f:	00 

000000000000c710 <fwp_pipe_read>:
    c710:	55                   	push   %rbp
    c711:	41 57                	push   %r15
    c713:	41 56                	push   %r14
    c715:	41 55                	push   %r13
    c717:	41 54                	push   %r12
    c719:	53                   	push   %rbx
    c71a:	50                   	push   %rax
    c71b:	48 89 f3             	mov    %rsi,%rbx
    c71e:	8b 05 50 97 02 00    	mov    0x29750(%rip),%eax        # 35e74 <fwp_pi_kind>
    c724:	83 f8 01             	cmp    $0x1,%eax
    c727:	0f 84 89 00 00 00    	je     c7b6 <fwp_pipe_read+0xa6>
    c72d:	83 f8 02             	cmp    $0x2,%eax
    c730:	0f 85 d7 00 00 00    	jne    c80d <fwp_pipe_read+0xfd>
    c736:	48 89 3c 24          	mov    %rdi,(%rsp)
    c73a:	4c 8b 25 37 97 02 00 	mov    0x29737(%rip),%r12        # 35e78 <fwp_pi_ring>
    c741:	4d 8d ac 24 c0 00 00 	lea    0xc0(%r12),%r13
    c748:	00 
    c749:	49 8d ac 24 c4 00 00 	lea    0xc4(%r12),%rbp
    c750:	00 
    c751:	4c 8d 35 b8 01 00 00 	lea    0x1b8(%rip),%r14        # c910 <fwp_ring_has_data>
    c758:	45 31 ff             	xor    %r15d,%r15d
    c75b:	eb 23                	jmp    c780 <fwp_pipe_read+0x70>
    c75d:	0f 1f 00             	nopl   (%rax)
    c760:	44 8b 05 61 95 00 00 	mov    0x9561(%rip),%r8d        # 15cc8 <fwp_pi_sock>
    c767:	4c 89 e7             	mov    %r12,%rdi
    c76a:	4c 89 ee             	mov    %r13,%rsi
    c76d:	48 89 ea             	mov    %rbp,%rdx
    c770:	4c 89 f1             	mov    %r14,%rcx
    c773:	e8 98 dc ff ff       	call   a410 <fwp_ring_wait>
    c778:	85 c0                	test   %eax,%eax
    c77a:	0f 84 6c 01 00 00    	je     c8ec <fwp_pipe_read+0x1dc>
    c780:	49 8b 4c 24 40       	mov    0x40(%r12),%rcx
    c785:	49 8b 84 24 80 00 00 	mov    0x80(%r12),%rax
    c78c:	00 
    c78d:	48 29 c1             	sub    %rax,%rcx
    c790:	0f 85 9c 00 00 00    	jne    c832 <fwp_pipe_read+0x122>
    c796:	41 8b 84 24 40 01 00 	mov    0x140(%r12),%eax
    c79d:	00 
    c79e:	85 c0                	test   %eax,%eax
    c7a0:	74 be                	je     c760 <fwp_pipe_read+0x50>
    c7a2:	49 8b 44 24 40       	mov    0x40(%r12),%rax
    c7a7:	49 3b 84 24 80 00 00 	cmp    0x80(%r12),%rax
    c7ae:	00 
    c7af:	75 af                	jne    c760 <fwp_pipe_read+0x50>
    c7b1:	e9 36 01 00 00       	jmp    c8ec <fwp_pipe_read+0x1dc>
    c7b6:	4c 8b 35 c3 96 02 00 	mov    0x296c3(%rip),%r14        # 35e80 <fwp_pi_pos>
    c7bd:	4c 8b 3d c4 96 02 00 	mov    0x296c4(%rip),%r15        # 35e88 <fwp_pi_len>
    c7c4:	4d 39 fe             	cmp    %r15,%r14
    c7c7:	0f 85 f9 00 00 00    	jne    c8c6 <fwp_pipe_read+0x1b6>
    c7cd:	49 89 fc             	mov    %rdi,%r12
    c7d0:	4c 8d 35 b9 96 02 00 	lea    0x296b9(%rip),%r14        # 35e90 <fwp_pi_buf>
    c7d7:	45 31 ff             	xor    %r15d,%r15d
    c7da:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    c7e0:	8b 3d e2 94 00 00    	mov    0x94e2(%rip),%edi        # 15cc8 <fwp_pi_sock>
    c7e6:	ba 00 00 01 00       	mov    $0x10000,%edx
    c7eb:	4c 89 f6             	mov    %r14,%rsi
    c7ee:	31 c9                	xor    %ecx,%ecx
    c7f0:	e8 6b 58 ff ff       	call   2060 <recv@plt>
    c7f5:	48 85 c0             	test   %rax,%rax
    c7f8:	0f 89 b6 00 00 00    	jns    c8b4 <fwp_pipe_read+0x1a4>
    c7fe:	e8 7d 58 ff ff       	call   2080 <__errno_location@plt>
    c803:	83 38 04             	cmpl   $0x4,(%rax)
    c806:	74 d8                	je     c7e0 <fwp_pipe_read+0xd0>
    c808:	e9 df 00 00 00       	jmp    c8ec <fwp_pipe_read+0x1dc>
    c80d:	48 8b 05 ac 77 00 00 	mov    0x77ac(%rip),%rax        # 13fc0 <stdin@GLIBC_2.2.5>
    c814:	48 8b 08             	mov    (%rax),%rcx
    c817:	be 01 00 00 00       	mov    $0x1,%esi
    c81c:	48 89 da             	mov    %rbx,%rdx
    c81f:	48 83 c4 08          	add    $0x8,%rsp
    c823:	5b                   	pop    %rbx
    c824:	41 5c                	pop    %r12
    c826:	41 5d                	pop    %r13
    c828:	41 5e                	pop    %r14
    c82a:	41 5f                	pop    %r15
    c82c:	5d                   	pop    %rbp
    c82d:	e9 be 58 ff ff       	jmp    20f0 <fread@plt>
    c832:	48 39 d9             	cmp    %rbx,%rcx
    c835:	48 0f 42 d9          	cmovb  %rcx,%rbx
    c839:	4d 8b 74 24 08       	mov    0x8(%r12),%r14
    c83e:	49 8d 4e ff          	lea    -0x1(%r14),%rcx
    c842:	48 21 c1             	and    %rax,%rcx
    c845:	49 29 ce             	sub    %rcx,%r14
    c848:	4c 39 f3             	cmp    %r14,%rbx
    c84b:	4c 0f 42 f3          	cmovb  %rbx,%r14
    c84f:	4d 8d bc 24 00 10 00 	lea    0x1000(%r12),%r15
    c856:	00 
    c857:	49 8d 34 0c          	lea    (%r12,%rcx,1),%rsi
    c85b:	48 81 c6 00 10 00 00 	add    $0x1000,%rsi
    c862:	4c 8b 2c 24          	mov    (%rsp),%r13
    c866:	4c 89 ef             	mov    %r13,%rdi
    c869:	4c 89 f2             	mov    %r14,%rdx
    c86c:	e8 bf 5a ff ff       	call   2330 <memcpy@plt>
    c871:	4d 01 f5             	add    %r14,%r13
    c874:	48 89 da             	mov    %rbx,%rdx
    c877:	4c 29 f2             	sub    %r14,%rdx
    c87a:	4c 89 ef             	mov    %r13,%rdi
    c87d:	4c 89 fe             	mov    %r15,%rsi
    c880:	e8 ab 5a ff ff       	call   2330 <memcpy@plt>
    c885:	49 8b 84 24 80 00 00 	mov    0x80(%r12),%rax
    c88c:	00 
    c88d:	48 01 d8             	add    %rbx,%rax
    c890:	49 89 84 24 80 00 00 	mov    %rax,0x80(%r12)
    c897:	00 
    c898:	49 8d bc 24 00 01 00 	lea    0x100(%r12),%rdi
    c89f:	00 
    c8a0:	49 81 c4 04 01 00 00 	add    $0x104,%r12
    c8a7:	4c 89 e6             	mov    %r12,%rsi
    c8aa:	e8 c1 dc ff ff       	call   a570 <fwp_ring_wake>
    c8af:	49 89 df             	mov    %rbx,%r15
    c8b2:	eb 38                	jmp    c8ec <fwp_pipe_read+0x1dc>
    c8b4:	74 48                	je     c8fe <fwp_pipe_read+0x1ee>
    c8b6:	4c 89 e7             	mov    %r12,%rdi
    c8b9:	48 89 05 c8 95 02 00 	mov    %rax,0x295c8(%rip)        # 35e88 <fwp_pi_len>
    c8c0:	45 31 f6             	xor    %r14d,%r14d
    c8c3:	49 89 c7             	mov    %rax,%r15
    c8c6:	4d 29 f7             	sub    %r14,%r15
    c8c9:	49 39 df             	cmp    %rbx,%r15
    c8cc:	4c 0f 43 fb          	cmovae %rbx,%r15
    c8d0:	48 8d 35 b9 95 02 00 	lea    0x295b9(%rip),%rsi        # 35e90 <fwp_pi_buf>
    c8d7:	4c 01 f6             	add    %r14,%rsi
    c8da:	4c 89 fa             	mov    %r15,%rdx
    c8dd:	e8 4e 5a ff ff       	call   2330 <memcpy@plt>
    c8e2:	4d 01 fe             	add    %r15,%r14
    c8e5:	4c 89 35 94 95 02 00 	mov    %r14,0x29594(%rip)        # 35e80 <fwp_pi_pos>
    c8ec:	4c 89 f8             	mov    %r15,%rax
    c8ef:	48 83 c4 08          	add    $0x8,%rsp
    c8f3:	5b                   	pop    %rbx
    c8f4:	41 5c                	pop    %r12
    c8f6:	41 5d                	pop    %r13
    c8f8:	41 5e                	pop    %r14
    c8fa:	41 5f                	pop    %r15
    c8fc:	5d                   	pop    %rbp
    c8fd:	c3                   	ret
    c8fe:	45 31 ff             	xor    %r15d,%r15d
    c901:	eb e9                	jmp    c8ec <fwp_pipe_read+0x1dc>
    c903:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c90a:	84 00 00 00 00 00 

000000000000c910 <fwp_ring_has_data>:
    c910:	48 8b 4f 40          	mov    0x40(%rdi),%rcx
    c914:	b8 01 00 00 00       	mov    $0x1,%eax
    c919:	48 3b 8f 80 00 00 00 	cmp    0x80(%rdi),%rcx
    c920:	75 0d                	jne    c92f <fwp_ring_has_data+0x1f>
    c922:	8b 8f 40 01 00 00    	mov    0x140(%rdi),%ecx
    c928:	31 c0                	xor    %eax,%eax
    c92a:	85 c9                	test   %ecx,%ecx
    c92c:	0f 95 c0             	setne  %al
    c92f:	c3                   	ret

000000000000c930 <fwp_pipe_report>:
    c930:	53                   	push   %rbx
    c931:	48 89 fb             	mov    %rdi,%rbx
    c934:	48 8d 3d 6d 2a 00 00 	lea    0x2a6d(%rip),%rdi        # f3a8 <exec_in_fp0+0xd58>
    c93b:	e8 f0 56 ff ff       	call   2030 <getenv@plt>
    c940:	48 85 c0             	test   %rax,%rax
    c943:	74 18                	je     c95d <fwp_pipe_report+0x2d>
    c945:	80 38 00             	cmpb   $0x0,(%rax)
    c948:	74 13                	je     c95d <fwp_pipe_report+0x2d>
    c94a:	48 8d 35 2a 2a 00 00 	lea    0x2a2a(%rip),%rsi        # f37b <exec_in_fp0+0xd2b>
    c951:	48 89 c7             	mov    %rax,%rdi
    c954:	e8 77 59 ff ff       	call   22d0 <strcmp@plt>
    c959:	85 c0                	test   %eax,%eax
    c95b:	75 02                	jne    c95f <fwp_pipe_report+0x2f>
    c95d:	5b                   	pop    %rbx
    c95e:	c3                   	ret
    c95f:	48 8b 05 7a 76 00 00 	mov    0x767a(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    c966:	48 8b 38             	mov    (%rax),%rdi
    c969:	48 8d 35 4d 2a 00 00 	lea    0x2a4d(%rip),%rsi        # f3bd <exec_in_fp0+0xd6d>
    c970:	48 89 da             	mov    %rbx,%rdx
    c973:	31 c0                	xor    %eax,%eax
    c975:	5b                   	pop    %rbx
    c976:	e9 75 59 ff ff       	jmp    22f0 <fprintf@plt>
    c97b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000c980 <rd_le>:
    c980:	55                   	push   %rbp
    c981:	41 56                	push   %r14
    c983:	53                   	push   %rbx
    c984:	48 83 ec 10          	sub    $0x10,%rsp
    c988:	48 89 d3             	mov    %rdx,%rbx
    c98b:	89 f5                	mov    %esi,%ebp
    c98d:	41 89 f6             	mov    %esi,%r14d
    c990:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    c995:	4c 89 f6             	mov    %r14,%rsi
    c998:	e8 23 01 00 00       	call   cac0 <rd_take>
    c99d:	85 c0                	test   %eax,%eax
    c99f:	74 20                	je     c9c1 <rd_le+0x41>
    c9a1:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    c9a8:	b8 01 00 00 00       	mov    $0x1,%eax
    c9ad:	85 ed                	test   %ebp,%ebp
    c9af:	7e 7d                	jle    ca2e <rd_le+0xae>
    c9b1:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    c9b6:	83 fd 01             	cmp    $0x1,%ebp
    c9b9:	75 0a                	jne    c9c5 <rd_le+0x45>
    c9bb:	31 d2                	xor    %edx,%edx
    c9bd:	31 ff                	xor    %edi,%edi
    c9bf:	eb 55                	jmp    ca16 <rd_le+0x96>
    c9c1:	31 c0                	xor    %eax,%eax
    c9c3:	eb 69                	jmp    ca2e <rd_le+0xae>
    c9c5:	45 89 f0             	mov    %r14d,%r8d
    c9c8:	41 81 e0 fe ff ff 7f 	and    $0x7ffffffe,%r8d
    c9cf:	41 b9 08 00 00 00    	mov    $0x8,%r9d
    c9d5:	31 d2                	xor    %edx,%edx
    c9d7:	31 ff                	xor    %edi,%edi
    c9d9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    c9e0:	44 0f b6 14 16       	movzbl (%rsi,%rdx,1),%r10d
    c9e5:	41 8d 49 f8          	lea    -0x8(%r9),%ecx
    c9e9:	80 e1 f0             	and    $0xf0,%cl
    c9ec:	49 d3 e2             	shl    %cl,%r10
    c9ef:	49 09 fa             	or     %rdi,%r10
    c9f2:	4c 89 13             	mov    %r10,(%rbx)
    c9f5:	0f b6 7c 16 01       	movzbl 0x1(%rsi,%rdx,1),%edi
    c9fa:	44 89 c9             	mov    %r9d,%ecx
    c9fd:	80 e1 f8             	and    $0xf8,%cl
    ca00:	48 d3 e7             	shl    %cl,%rdi
    ca03:	4c 09 d7             	or     %r10,%rdi
    ca06:	48 89 3b             	mov    %rdi,(%rbx)
    ca09:	48 83 c2 02          	add    $0x2,%rdx
    ca0d:	49 83 c1 10          	add    $0x10,%r9
    ca11:	49 39 d0             	cmp    %rdx,%r8
    ca14:	75 ca                	jne    c9e0 <rd_le+0x60>
    ca16:	41 f6 c6 01          	test   $0x1,%r14b
    ca1a:	74 12                	je     ca2e <rd_le+0xae>
    ca1c:	0f b6 34 16          	movzbl (%rsi,%rdx,1),%esi
    ca20:	c1 e2 03             	shl    $0x3,%edx
    ca23:	89 d1                	mov    %edx,%ecx
    ca25:	48 d3 e6             	shl    %cl,%rsi
    ca28:	48 09 fe             	or     %rdi,%rsi
    ca2b:	48 89 33             	mov    %rsi,(%rbx)
    ca2e:	48 83 c4 10          	add    $0x10,%rsp
    ca32:	5b                   	pop    %rbx
    ca33:	41 5e                	pop    %r14
    ca35:	5d                   	pop    %rbp
    ca36:	c3                   	ret
    ca37:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    ca3e:	00 00 

000000000000ca40 <rd_leb>:
    ca40:	41 57                	push   %r15
    ca42:	41 56                	push   %r14
    ca44:	41 54                	push   %r12
    ca46:	53                   	push   %rbx
    ca47:	50                   	push   %rax
    ca48:	48 89 f3             	mov    %rsi,%rbx
    ca4b:	49 89 fe             	mov    %rdi,%r14
    ca4e:	48 c7 06 00 00 00 00 	movq   $0x0,(%rsi)
    ca55:	49 c7 c7 f9 ff ff ff 	mov    $0xfffffffffffffff9,%r15
    ca5c:	49 89 e4             	mov    %rsp,%r12
    ca5f:	90                   	nop
    ca60:	be 01 00 00 00       	mov    $0x1,%esi
    ca65:	4c 89 f7             	mov    %r14,%rdi
    ca68:	4c 89 e2             	mov    %r12,%rdx
    ca6b:	e8 50 00 00 00       	call   cac0 <rd_take>
    ca70:	85 c0                	test   %eax,%eax
    ca72:	74 2f                	je     caa3 <rd_leb+0x63>
    ca74:	48 8b 04 24          	mov    (%rsp),%rax
    ca78:	0f b6 10             	movzbl (%rax),%edx
    ca7b:	49 83 ff 38          	cmp    $0x38,%r15
    ca7f:	75 07                	jne    ca88 <rd_leb+0x48>
    ca81:	89 d1                	mov    %edx,%ecx
    ca83:	80 e1 7e             	and    $0x7e,%cl
    ca86:	75 1b                	jne    caa3 <rd_leb+0x63>
    ca88:	49 83 c7 07          	add    $0x7,%r15
    ca8c:	83 e2 7f             	and    $0x7f,%edx
    ca8f:	44 89 f9             	mov    %r15d,%ecx
    ca92:	48 d3 e2             	shl    %cl,%rdx
    ca95:	48 09 13             	or     %rdx,(%rbx)
    ca98:	80 38 00             	cmpb   $0x0,(%rax)
    ca9b:	79 0a                	jns    caa7 <rd_leb+0x67>
    ca9d:	49 83 ff 38          	cmp    $0x38,%r15
    caa1:	76 bd                	jbe    ca60 <rd_leb+0x20>
    caa3:	31 c0                	xor    %eax,%eax
    caa5:	eb 05                	jmp    caac <rd_leb+0x6c>
    caa7:	b8 01 00 00 00       	mov    $0x1,%eax
    caac:	48 83 c4 08          	add    $0x8,%rsp
    cab0:	5b                   	pop    %rbx
    cab1:	41 5c                	pop    %r12
    cab3:	41 5e                	pop    %r14
    cab5:	41 5f                	pop    %r15
    cab7:	c3                   	ret
    cab8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    cabf:	00 

000000000000cac0 <rd_take>:
    cac0:	4c 8b 47 08          	mov    0x8(%rdi),%r8
    cac4:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    cac8:	49 29 c8             	sub    %rcx,%r8
    cacb:	31 c0                	xor    %eax,%eax
    cacd:	49 39 f0             	cmp    %rsi,%r8
    cad0:	72 15                	jb     cae7 <rd_take+0x27>
    cad2:	48 8b 07             	mov    (%rdi),%rax
    cad5:	48 01 c8             	add    %rcx,%rax
    cad8:	48 89 02             	mov    %rax,(%rdx)
    cadb:	48 01 ce             	add    %rcx,%rsi
    cade:	48 89 77 10          	mov    %rsi,0x10(%rdi)
    cae2:	b8 01 00 00 00       	mov    $0x1,%eax
    cae7:	c3                   	ret
    cae8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    caef:	00 

000000000000caf0 <fwp_getc>:
    caf0:	48 63 05 35 93 01 00 	movslq 0x19335(%rip),%rax        # 25e2c <fwp_in_ppos>
    caf7:	3b 05 2b 93 01 00    	cmp    0x1932b(%rip),%eax        # 25e28 <fwp_in_npend>
    cafd:	7d 15                	jge    cb14 <fwp_getc+0x24>
    caff:	8d 48 01             	lea    0x1(%rax),%ecx
    cb02:	89 0d 24 93 01 00    	mov    %ecx,0x19324(%rip)        # 25e2c <fwp_in_ppos>
    cb08:	48 8d 0d 15 93 01 00 	lea    0x19315(%rip),%rcx        # 25e24 <fwp_in_pend>
    cb0f:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax
    cb13:	c3                   	ret
    cb14:	48 8b 05 a5 74 00 00 	mov    0x74a5(%rip),%rax        # 13fc0 <stdin@GLIBC_2.2.5>
    cb1b:	48 8b 38             	mov    (%rax),%rdi
    cb1e:	e9 fd 56 ff ff       	jmp    2220 <fgetc@plt>
    cb23:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    cb2a:	84 00 00 00 00 00 

000000000000cb30 <fwp_gc_find_data>:
    cb30:	0f b7 77 18          	movzwl 0x18(%rdi),%esi
    cb34:	48 85 f6             	test   %rsi,%rsi
    cb37:	0f 84 be 00 00 00    	je     cbfb <fwp_gc_find_data+0xcb>
    cb3d:	53                   	push   %rbx
    cb3e:	48 8b 07             	mov    (%rdi),%rax
    cb41:	4c 8b 47 10          	mov    0x10(%rdi),%r8
    cb45:	48 6b ce 38          	imul   $0x38,%rsi,%rcx
    cb49:	45 31 c9             	xor    %r9d,%r9d
    cb4c:	48 8d 15 45 77 00 00 	lea    0x7745(%rip),%rdx        # 14298 <fwp_gc>
    cb53:	41 bb 01 00 00 00    	mov    $0x1,%r11d
    cb59:	45 31 d2             	xor    %r10d,%r10d
    cb5c:	eb 0b                	jmp    cb69 <fwp_gc_find_data+0x39>
    cb5e:	66 90                	xchg   %ax,%ax
    cb60:	49 83 c1 38          	add    $0x38,%r9
    cb64:	4c 39 c9             	cmp    %r9,%rcx
    cb67:	74 22                	je     cb8b <fwp_gc_find_data+0x5b>
    cb69:	43 83 3c 08 01       	cmpl   $0x1,(%r8,%r9,1)
    cb6e:	75 f0                	jne    cb60 <fwp_gc_find_data+0x30>
    cb70:	4b 8b 5c 08 10       	mov    0x10(%r8,%r9,1),%rbx
    cb75:	48 01 c3             	add    %rax,%rbx
    cb78:	48 39 d3             	cmp    %rdx,%rbx
    cb7b:	77 e3                	ja     cb60 <fwp_gc_find_data+0x30>
    cb7d:	4b 03 5c 08 28       	add    0x28(%r8,%r9,1),%rbx
    cb82:	48 39 d3             	cmp    %rdx,%rbx
    cb85:	45 0f 47 d3          	cmova  %r11d,%r10d
    cb89:	eb d5                	jmp    cb60 <fwp_gc_find_data+0x30>
    cb8b:	31 c0                	xor    %eax,%eax
    cb8d:	45 85 d2             	test   %r10d,%r10d
    cb90:	0f 95 c0             	setne  %al
    cb93:	74 6e                	je     cc03 <fwp_gc_find_data+0xd3>
    cb95:	66 85 f6             	test   %si,%si
    cb98:	74 69                	je     cc03 <fwp_gc_find_data+0xd3>
    cb9a:	8b 05 88 88 00 00    	mov    0x8888(%rip),%eax        # 15428 <fwp_gc+0x1190>
    cba0:	48 8b 77 10          	mov    0x10(%rdi),%rsi
    cba4:	45 31 c0             	xor    %r8d,%r8d
    cba7:	eb 10                	jmp    cbb9 <fwp_gc_find_data+0x89>
    cba9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    cbb0:	49 83 c0 38          	add    $0x38,%r8
    cbb4:	4c 39 c1             	cmp    %r8,%rcx
    cbb7:	74 45                	je     cbfe <fwp_gc_find_data+0xce>
    cbb9:	42 83 3c 06 01       	cmpl   $0x1,(%rsi,%r8,1)
    cbbe:	75 f0                	jne    cbb0 <fwp_gc_find_data+0x80>
    cbc0:	42 f6 44 06 04 02    	testb  $0x2,0x4(%rsi,%r8,1)
    cbc6:	74 e8                	je     cbb0 <fwp_gc_find_data+0x80>
    cbc8:	83 f8 10             	cmp    $0x10,%eax
    cbcb:	74 31                	je     cbfe <fwp_gc_find_data+0xce>
    cbcd:	4e 8b 4c 06 10       	mov    0x10(%rsi,%r8,1),%r9
    cbd2:	4c 03 0f             	add    (%rdi),%r9
    cbd5:	4c 63 d0             	movslq %eax,%r10
    cbd8:	49 c1 e2 04          	shl    $0x4,%r10
    cbdc:	4d 89 8c 12 90 10 00 	mov    %r9,0x1090(%r10,%rdx,1)
    cbe3:	00 
    cbe4:	4e 8b 4c 06 28       	mov    0x28(%rsi,%r8,1),%r9
    cbe9:	4d 89 8c 12 98 10 00 	mov    %r9,0x1098(%r10,%rdx,1)
    cbf0:	00 
    cbf1:	ff c0                	inc    %eax
    cbf3:	89 05 2f 88 00 00    	mov    %eax,0x882f(%rip)        # 15428 <fwp_gc+0x1190>
    cbf9:	eb b5                	jmp    cbb0 <fwp_gc_find_data+0x80>
    cbfb:	31 c0                	xor    %eax,%eax
    cbfd:	c3                   	ret
    cbfe:	b8 01 00 00 00       	mov    $0x1,%eax
    cc03:	5b                   	pop    %rbx
    cc04:	c3                   	ret
    cc05:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    cc0c:	00 00 00 00 

000000000000cc10 <fwp_gc_report>:
    cc10:	41 57                	push   %r15
    cc12:	41 56                	push   %r14
    cc14:	53                   	push   %rbx
    cc15:	48 83 ec 50          	sub    $0x50,%rsp
    cc19:	48 8b 05 88 88 00 00 	mov    0x8888(%rip),%rax        # 154a8 <fwp_gc+0x1210>
    cc20:	48 8b 0d 71 76 00 00 	mov    0x7671(%rip),%rcx        # 14298 <fwp_gc>
    cc27:	48 29 c8             	sub    %rcx,%rax
    cc2a:	f2 48 0f 2a c8       	cvtsi2sd %rax,%xmm1
    cc2f:	f2 0f 58 0d 49 88 00 	addsd  0x8849(%rip),%xmm1        # 15480 <fwp_gc+0x11e8>
    cc36:	00 
    cc37:	f2 0f 11 0d 41 88 00 	movsd  %xmm1,0x8841(%rip)        # 15480 <fwp_gc+0x11e8>
    cc3e:	00 
    cc3f:	48 89 0d 62 88 00 00 	mov    %rcx,0x8862(%rip)        # 154a8 <fwp_gc+0x1210>
    cc46:	48 8b 05 93 73 00 00 	mov    0x7393(%rip),%rax        # 13fe0 <stderr@GLIBC_2.2.5>
    cc4d:	4c 8b 38             	mov    (%rax),%r15
    cc50:	48 8b 1d 19 88 00 00 	mov    0x8819(%rip),%rbx        # 15470 <fwp_gc+0x11d8>
    cc57:	4c 8b 35 52 86 00 00 	mov    0x8652(%rip),%r14        # 152b0 <fwp_gc+0x1018>
    cc5e:	f2 0f 10 15 3a 88 00 	movsd  0x883a(%rip),%xmm2        # 154a0 <fwp_gc+0x1208>
    cc65:	00 
    cc66:	f2 0f 58 ca          	addsd  %xmm2,%xmm1
    cc6a:	f2 0f 10 05 06 15 00 	movsd  0x1506(%rip),%xmm0        # e178 <_IO_stdin_used+0x178>
    cc71:	00 
    cc72:	f2 0f 59 c8          	mulsd  %xmm0,%xmm1
    cc76:	f2 0f 11 4c 24 18    	movsd  %xmm1,0x18(%rsp)
    cc7c:	f2 0f 59 d0          	mulsd  %xmm0,%xmm2
    cc80:	f2 0f 11 54 24 10    	movsd  %xmm2,0x10(%rsp)
    cc86:	f2 0f 10 0d 52 86 00 	movsd  0x8652(%rip),%xmm1        # 152e0 <fwp_gc+0x1048>
    cc8d:	00 
    cc8e:	66 0f 28 15 8a 14 00 	movapd 0x148a(%rip),%xmm2        # e120 <_IO_stdin_used+0x120>
    cc95:	00 
    cc96:	0f 14 ca             	unpcklps %xmm2,%xmm1
    cc99:	66 0f 28 1d 8f 14 00 	movapd 0x148f(%rip),%xmm3        # e130 <_IO_stdin_used+0x130>
    cca0:	00 
    cca1:	66 0f 5c cb          	subpd  %xmm3,%xmm1
    cca5:	66 0f 28 e1          	movapd %xmm1,%xmm4
    cca9:	66 0f 15 e1          	unpckhpd %xmm1,%xmm4
    ccad:	f2 0f 58 e1          	addsd  %xmm1,%xmm4
    ccb1:	f2 0f 59 e0          	mulsd  %xmm0,%xmm4
    ccb5:	66 0f 29 64 24 40    	movapd %xmm4,0x40(%rsp)
    ccbb:	f2 0f 10 0d 9d 87 00 	movsd  0x879d(%rip),%xmm1        # 15460 <fwp_gc+0x11c8>
    ccc2:	00 
    ccc3:	0f 14 ca             	unpcklps %xmm2,%xmm1
    ccc6:	66 0f 5c cb          	subpd  %xmm3,%xmm1
    ccca:	66 0f 28 e1          	movapd %xmm1,%xmm4
    ccce:	66 0f 15 e1          	unpckhpd %xmm1,%xmm4
    ccd2:	f2 0f 58 e1          	addsd  %xmm1,%xmm4
    ccd6:	f2 0f 59 e0          	mulsd  %xmm0,%xmm4
    ccda:	66 0f 29 64 24 30    	movapd %xmm4,0x30(%rsp)
    cce0:	f2 0f 10 0d 80 87 00 	movsd  0x8780(%rip),%xmm1        # 15468 <fwp_gc+0x11d0>
    cce7:	00 
    cce8:	0f 14 ca             	unpcklps %xmm2,%xmm1
    cceb:	66 0f 5c cb          	subpd  %xmm3,%xmm1
    ccef:	66 0f 28 d1          	movapd %xmm1,%xmm2
    ccf3:	66 0f 15 d1          	unpckhpd %xmm1,%xmm2
    ccf7:	f2 0f 58 d1          	addsd  %xmm1,%xmm2
    ccfb:	f2 0f 59 d0          	mulsd  %xmm0,%xmm2
    ccff:	66 0f 29 54 24 20    	movapd %xmm2,0x20(%rsp)
    cd05:	f2 0f 10 05 7b 87 00 	movsd  0x877b(%rip),%xmm0        # 15488 <fwp_gc+0x11f0>
    cd0c:	00 
    cd0d:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    cd13:	f2 0f 10 05 75 87 00 	movsd  0x8775(%rip),%xmm0        # 15490 <fwp_gc+0x11f8>
    cd1a:	00 
    cd1b:	f2 0f 11 04 24       	movsd  %xmm0,(%rsp)
    cd20:	e8 6b 00 00 00       	call   cd90 <fwp_gc_status_kb>
    cd25:	83 3d 60 85 00 00 00 	cmpl   $0x0,0x8560(%rip)        # 1528c <fwp_gc+0xff4>
    cd2c:	48 8d 0d 25 28 00 00 	lea    0x2825(%rip),%rcx        # f558 <exec_in_fp0+0xf08>
    cd33:	4c 8d 0d 66 20 00 00 	lea    0x2066(%rip),%r9        # eda0 <exec_in_fp0+0x750>
    cd3a:	4c 0f 44 c9          	cmove  %rcx,%r9
    cd3e:	48 8d 35 5e 27 00 00 	lea    0x275e(%rip),%rsi        # f4a3 <exec_in_fp0+0xe53>
    cd45:	4c 89 ff             	mov    %r15,%rdi
    cd48:	48 89 da             	mov    %rbx,%rdx
    cd4b:	4c 89 f1             	mov    %r14,%rcx
    cd4e:	f2 0f 10 44 24 18    	movsd  0x18(%rsp),%xmm0
    cd54:	f2 0f 10 4c 24 10    	movsd  0x10(%rsp),%xmm1
    cd5a:	0f 28 54 24 40       	movaps 0x40(%rsp),%xmm2
    cd5f:	0f 28 5c 24 30       	movaps 0x30(%rsp),%xmm3
    cd64:	0f 28 64 24 20       	movaps 0x20(%rsp),%xmm4
    cd69:	f2 0f 10 6c 24 08    	movsd  0x8(%rsp),%xmm5
    cd6f:	f2 0f 10 34 24       	movsd  (%rsp),%xmm6
    cd74:	49 89 c0             	mov    %rax,%r8
    cd77:	b0 07                	mov    $0x7,%al
    cd79:	48 83 c4 50          	add    $0x50,%rsp
    cd7d:	5b                   	pop    %rbx
    cd7e:	41 5e                	pop    %r14
    cd80:	41 5f                	pop    %r15
    cd82:	e9 69 55 ff ff       	jmp    22f0 <fprintf@plt>
    cd87:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    cd8e:	00 00 

000000000000cd90 <fwp_gc_status_kb>:
    cd90:	55                   	push   %rbp
    cd91:	41 57                	push   %r15
    cd93:	41 56                	push   %r14
    cd95:	41 54                	push   %r12
    cd97:	53                   	push   %rbx
    cd98:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
    cd9f:	48 8d 3d c4 27 00 00 	lea    0x27c4(%rip),%rdi        # f56a <exec_in_fp0+0xf1a>
    cda6:	48 8d 35 dd 25 00 00 	lea    0x25dd(%rip),%rsi        # f38a <exec_in_fp0+0xd3a>
    cdad:	e8 6e 56 ff ff       	call   2420 <fopen@plt>
    cdb2:	48 85 c0             	test   %rax,%rax
    cdb5:	74 7d                	je     ce34 <fwp_gc_status_kb+0xa4>
    cdb7:	48 89 c3             	mov    %rax,%rbx
    cdba:	48 89 e7             	mov    %rsp,%rdi
    cdbd:	be 00 01 00 00       	mov    $0x100,%esi
    cdc2:	48 89 c2             	mov    %rax,%rdx
    cdc5:	e8 c6 54 ff ff       	call   2290 <fgets@plt>
    cdca:	49 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%r14
    cdd1:	48 85 c0             	test   %rax,%rax
    cdd4:	74 54                	je     ce2a <fwp_gc_status_kb+0x9a>
    cdd6:	4c 8d 7c 24 06       	lea    0x6(%rsp),%r15
    cddb:	bd 56 6d 48 57       	mov    $0x57486d56,%ebp
    cde0:	49 89 e4             	mov    %rsp,%r12
    cde3:	eb 20                	jmp    ce05 <fwp_gc_status_kb+0x75>
    cde5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    cdec:	00 00 00 00 
    cdf0:	4c 89 e7             	mov    %r12,%rdi
    cdf3:	be 00 01 00 00       	mov    $0x100,%esi
    cdf8:	48 89 da             	mov    %rbx,%rdx
    cdfb:	e8 90 54 ff ff       	call   2290 <fgets@plt>
    ce00:	48 85 c0             	test   %rax,%rax
    ce03:	74 25                	je     ce2a <fwp_gc_status_kb+0x9a>
    ce05:	8b 04 24             	mov    (%rsp),%eax
    ce08:	31 e8                	xor    %ebp,%eax
    ce0a:	0f b6 4c 24 04       	movzbl 0x4(%rsp),%ecx
    ce0f:	83 f1 4d             	xor    $0x4d,%ecx
    ce12:	09 c1                	or     %eax,%ecx
    ce14:	75 da                	jne    cdf0 <fwp_gc_status_kb+0x60>
    ce16:	80 7c 24 05 3a       	cmpb   $0x3a,0x5(%rsp)
    ce1b:	75 d3                	jne    cdf0 <fwp_gc_status_kb+0x60>
    ce1d:	4c 89 ff             	mov    %r15,%rdi
    ce20:	e8 db 55 ff ff       	call   2400 <atol@plt>
    ce25:	49 89 c6             	mov    %rax,%r14
    ce28:	eb c6                	jmp    cdf0 <fwp_gc_status_kb+0x60>
    ce2a:	48 89 df             	mov    %rbx,%rdi
    ce2d:	e8 1e 53 ff ff       	call   2150 <fclose@plt>
    ce32:	eb 07                	jmp    ce3b <fwp_gc_status_kb+0xab>
    ce34:	49 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%r14
    ce3b:	4c 89 f0             	mov    %r14,%rax
    ce3e:	48 81 c4 00 01 00 00 	add    $0x100,%rsp
    ce45:	5b                   	pop    %rbx
    ce46:	41 5c                	pop    %r12
    ce48:	41 5e                	pop    %r14
    ce4a:	41 5f                	pop    %r15
    ce4c:	5d                   	pop    %rbp
    ce4d:	c3                   	ret
    ce4e:	66 90                	xchg   %ax,%ax

000000000000ce50 <w0>:
    ce50:	53                   	push   %rbx
    ce51:	48 89 fb             	mov    %rdi,%rbx
    ce54:	e8 67 8d ff ff       	call   5bc0 <fwp_from_f64>
    ce59:	48 89 c7             	mov    %rax,%rdi
    ce5c:	e8 4f 8d ff ff       	call   5bb0 <fwp_f64>
    ce61:	f2 0f 11 03          	movsd  %xmm0,(%rbx)
    ce65:	f2 0f 11 43 08       	movsd  %xmm0,0x8(%rbx)
    ce6a:	f2 0f 11 43 10       	movsd  %xmm0,0x10(%rbx)
    ce6f:	48 89 d8             	mov    %rbx,%rax
    ce72:	5b                   	pop    %rbx
    ce73:	c3                   	ret
    ce74:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    ce7b:	00 00 00 00 00 

000000000000ce80 <fwp_rc_drop_slot>:
    ce80:	0f b6 07             	movzbl (%rdi),%eax
    ce83:	3c ff                	cmp    $0xff,%al
    ce85:	74 09                	je     ce90 <fwp_rc_wide_drop>
    ce87:	3c 02                	cmp    $0x2,%al
    ce89:	72 04                	jb     ce8f <fwp_rc_drop_slot+0xf>
    ce8b:	fe c8                	dec    %al
    ce8d:	88 07                	mov    %al,(%rdi)
    ce8f:	c3                   	ret

000000000000ce90 <fwp_rc_wide_drop>:
    ce90:	53                   	push   %rbx
    ce91:	48 89 fb             	mov    %rdi,%rbx
    ce94:	e8 c7 60 ff ff       	call   2f60 <fwp_rc_wide_link>
    ce99:	48 8b 00             	mov    (%rax),%rax
    ce9c:	48 85 c0             	test   %rax,%rax
    ce9f:	74 21                	je     cec2 <fwp_rc_wide_drop+0x32>
    cea1:	48 8b 48 08          	mov    0x8(%rax),%rcx
    cea5:	48 ff c9             	dec    %rcx
    cea8:	48 89 48 08          	mov    %rcx,0x8(%rax)
    ceac:	48 81 f9 fe 00 00 00 	cmp    $0xfe,%rcx
    ceb3:	75 0b                	jne    cec0 <fwp_rc_wide_drop+0x30>
    ceb5:	48 89 df             	mov    %rbx,%rdi
    ceb8:	e8 63 60 ff ff       	call   2f20 <fwp_rc_forget_slot>
    cebd:	c6 03 fe             	movb   $0xfe,(%rbx)
    cec0:	5b                   	pop    %rbx
    cec1:	c3                   	ret
    cec2:	48 8d 3d 3b 18 00 00 	lea    0x183b(%rip),%rdi        # e704 <exec_in_fp0+0xb4>
    cec9:	e8 f2 60 ff ff       	call   2fc0 <fwp_trap>
    cece:	66 90                	xchg   %ax,%ax

000000000000ced0 <fwp_rc_poison>:
    ced0:	53                   	push   %rbx
    ced1:	48 89 f9             	mov    %rdi,%rcx
    ced4:	48 2b 0d ed 83 00 00 	sub    0x83ed(%rip),%rcx        # 152c8 <fwp_gc+0x1030>
    cedb:	48 8b 05 2e 84 00 00 	mov    0x842e(%rip),%rax        # 15310 <fwp_gc+0x1078>
    cee2:	48 c1 e9 10          	shr    $0x10,%rcx
    cee6:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    ceed:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    cef2:	75 0d                	jne    cf01 <fwp_rc_poison+0x31>
    cef4:	80 3c 08 02          	cmpb   $0x2,(%rax,%rcx,1)
    cef8:	75 1e                	jne    cf18 <fwp_rc_poison+0x48>
    cefa:	48 8b 54 08 18       	mov    0x18(%rax,%rcx,1),%rdx
    ceff:	eb 1b                	jmp    cf1c <fwp_rc_poison+0x4c>
    cf01:	c7 07 ad de 00 00    	movl   $0xdead,(%rdi)
    cf07:	8b 47 04             	mov    0x4(%rdi),%eax
    cf0a:	48 85 c0             	test   %rax,%rax
    cf0d:	74 7e                	je     cf8d <fwp_rc_poison+0xbd>
    cf0f:	83 f8 04             	cmp    $0x4,%eax
    cf12:	73 22                	jae    cf36 <fwp_rc_poison+0x66>
    cf14:	31 c9                	xor    %ecx,%ecx
    cf16:	eb 50                	jmp    cf68 <fwp_rc_poison+0x98>
    cf18:	8b 54 08 08          	mov    0x8(%rax,%rcx,1),%edx
    cf1c:	48 89 fb             	mov    %rdi,%rbx
    cf1f:	be dd 00 00 00       	mov    $0xdd,%esi
    cf24:	e8 e7 52 ff ff       	call   2210 <memset@plt>
    cf29:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    cf30:	c6 43 08 00          	movb   $0x0,0x8(%rbx)
    cf34:	5b                   	pop    %rbx
    cf35:	c3                   	ret
    cf36:	89 c1                	mov    %eax,%ecx
    cf38:	83 e1 fc             	and    $0xfffffffc,%ecx
    cf3b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    cf42:	00 
    cf43:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    cf47:	31 f6                	xor    %esi,%esi
    cf49:	0f 28 05 f0 11 00 00 	movaps 0x11f0(%rip),%xmm0        # e140 <_IO_stdin_used+0x140>
    cf50:	0f 11 44 37 08       	movups %xmm0,0x8(%rdi,%rsi,1)
    cf55:	0f 11 44 37 18       	movups %xmm0,0x18(%rdi,%rsi,1)
    cf5a:	48 83 c6 20          	add    $0x20,%rsi
    cf5e:	48 39 f2             	cmp    %rsi,%rdx
    cf61:	75 ed                	jne    cf50 <fwp_rc_poison+0x80>
    cf63:	48 39 c1             	cmp    %rax,%rcx
    cf66:	74 25                	je     cf8d <fwp_rc_poison+0xbd>
    cf68:	48 ba ef be ad de ef 	movabs $0xdeadbeefdeadbeef,%rdx
    cf6f:	be ad de 
    cf72:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    cf79:	1f 84 00 00 00 00 00 
    cf80:	48 89 54 cf 08       	mov    %rdx,0x8(%rdi,%rcx,8)
    cf85:	48 ff c1             	inc    %rcx
    cf88:	48 39 c8             	cmp    %rcx,%rax
    cf8b:	75 f3                	jne    cf80 <fwp_rc_poison+0xb0>
    cf8d:	5b                   	pop    %rbx
    cf8e:	c3                   	ret
    cf8f:	90                   	nop

000000000000cf90 <__divti3>:
    cf90:	f3 0f 1e fa          	endbr64
    cf94:	55                   	push   %rbp
    cf95:	49 89 f8             	mov    %rdi,%r8
    cf98:	49 89 d2             	mov    %rdx,%r10
    cf9b:	49 89 cb             	mov    %rcx,%r11
    cf9e:	31 ff                	xor    %edi,%edi
    cfa0:	48 89 e5             	mov    %rsp,%rbp
    cfa3:	41 56                	push   %r14
    cfa5:	53                   	push   %rbx
    cfa6:	48 85 f6             	test   %rsi,%rsi
    cfa9:	79 13                	jns    cfbe <__divti3+0x2e>
    cfab:	45 31 c9             	xor    %r9d,%r9d
    cfae:	49 f7 d8             	neg    %r8
    cfb1:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
    cfb8:	49 19 f1             	sbb    %rsi,%r9
    cfbb:	4c 89 ce             	mov    %r9,%rsi
    cfbe:	4c 89 da             	mov    %r11,%rdx
    cfc1:	4d 85 db             	test   %r11,%r11
    cfc4:	0f 88 f6 00 00 00    	js     d0c0 <__divti3+0x130>
    cfca:	4d 89 d6             	mov    %r10,%r14
    cfcd:	75 31                	jne    d000 <__divti3+0x70>
    cfcf:	4c 39 f6             	cmp    %r14,%rsi
    cfd2:	0f 83 b8 00 00 00    	jae    d090 <__divti3+0x100>
    cfd8:	48 89 f2             	mov    %rsi,%rdx
    cfdb:	31 f6                	xor    %esi,%esi
    cfdd:	4c 89 c0             	mov    %r8,%rax
    cfe0:	49 f7 f6             	div    %r14
    cfe3:	48 89 f2             	mov    %rsi,%rdx
    cfe6:	48 85 ff             	test   %rdi,%rdi
    cfe9:	74 0a                	je     cff5 <__divti3+0x65>
    cfeb:	48 f7 d8             	neg    %rax
    cfee:	48 83 d2 00          	adc    $0x0,%rdx
    cff2:	48 f7 da             	neg    %rdx
    cff5:	5b                   	pop    %rbx
    cff6:	41 5e                	pop    %r14
    cff8:	5d                   	pop    %rbp
    cff9:	c3                   	ret
    cffa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    d000:	4c 39 de             	cmp    %r11,%rsi
    d003:	0f 82 d5 00 00 00    	jb     d0de <__divti3+0x14e>
    d009:	4d 0f bd d3          	bsr    %r11,%r10
    d00d:	41 83 f2 3f          	xor    $0x3f,%r10d
    d011:	44 89 d1             	mov    %r10d,%ecx
    d014:	b8 40 00 00 00       	mov    $0x40,%eax
    d019:	4c 89 f3             	mov    %r14,%rbx
    d01c:	4d 89 f1             	mov    %r14,%r9
    d01f:	48 d3 e2             	shl    %cl,%rdx
    d022:	49 63 ca             	movslq %r10d,%rcx
    d025:	49 89 f3             	mov    %rsi,%r11
    d028:	48 29 c8             	sub    %rcx,%rax
    d02b:	89 c1                	mov    %eax,%ecx
    d02d:	48 d3 eb             	shr    %cl,%rbx
    d030:	44 89 d1             	mov    %r10d,%ecx
    d033:	49 d3 e1             	shl    %cl,%r9
    d036:	89 c1                	mov    %eax,%ecx
    d038:	48 09 d3             	or     %rdx,%rbx
    d03b:	4c 89 c2             	mov    %r8,%rdx
    d03e:	49 d3 eb             	shr    %cl,%r11
    d041:	44 89 d1             	mov    %r10d,%ecx
    d044:	48 d3 e6             	shl    %cl,%rsi
    d047:	89 c1                	mov    %eax,%ecx
    d049:	48 d3 ea             	shr    %cl,%rdx
    d04c:	48 89 d0             	mov    %rdx,%rax
    d04f:	4c 89 da             	mov    %r11,%rdx
    d052:	48 09 f0             	or     %rsi,%rax
    d055:	48 f7 f3             	div    %rbx
    d058:	49 89 d3             	mov    %rdx,%r11
    d05b:	48 89 c6             	mov    %rax,%rsi
    d05e:	49 f7 e1             	mul    %r9
    d061:	49 39 d3             	cmp    %rdx,%r11
    d064:	0f 82 be 00 00 00    	jb     d128 <__divti3+0x198>
    d06a:	44 89 d1             	mov    %r10d,%ecx
    d06d:	49 d3 e0             	shl    %cl,%r8
    d070:	49 39 c0             	cmp    %rax,%r8
    d073:	73 09                	jae    d07e <__divti3+0xee>
    d075:	49 39 d3             	cmp    %rdx,%r11
    d078:	0f 84 aa 00 00 00    	je     d128 <__divti3+0x198>
    d07e:	48 89 f0             	mov    %rsi,%rax
    d081:	31 f6                	xor    %esi,%esi
    d083:	e9 5b ff ff ff       	jmp    cfe3 <__divti3+0x53>
    d088:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    d08f:	00 
    d090:	4d 85 f6             	test   %r14,%r14
    d093:	75 0d                	jne    d0a2 <__divti3+0x112>
    d095:	b8 01 00 00 00       	mov    $0x1,%eax
    d09a:	31 d2                	xor    %edx,%edx
    d09c:	49 f7 f6             	div    %r14
    d09f:	49 89 c6             	mov    %rax,%r14
    d0a2:	48 89 f0             	mov    %rsi,%rax
    d0a5:	31 d2                	xor    %edx,%edx
    d0a7:	49 f7 f6             	div    %r14
    d0aa:	48 89 c6             	mov    %rax,%rsi
    d0ad:	4c 89 c0             	mov    %r8,%rax
    d0b0:	49 f7 f6             	div    %r14
    d0b3:	e9 2b ff ff ff       	jmp    cfe3 <__divti3+0x53>
    d0b8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    d0bf:	00 
    d0c0:	49 f7 da             	neg    %r10
    d0c3:	48 f7 d7             	not    %rdi
    d0c6:	49 83 d3 00          	adc    $0x0,%r11
    d0ca:	4d 89 d6             	mov    %r10,%r14
    d0cd:	49 f7 db             	neg    %r11
    d0d0:	4c 89 da             	mov    %r11,%rdx
    d0d3:	0f 84 f6 fe ff ff    	je     cfcf <__divti3+0x3f>
    d0d9:	4c 39 de             	cmp    %r11,%rsi
    d0dc:	73 12                	jae    d0f0 <__divti3+0x160>
    d0de:	31 f6                	xor    %esi,%esi
    d0e0:	31 c0                	xor    %eax,%eax
    d0e2:	e9 fc fe ff ff       	jmp    cfe3 <__divti3+0x53>
    d0e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    d0ee:	00 00 
    d0f0:	49 0f bd c3          	bsr    %r11,%rax
    d0f4:	48 83 f0 3f          	xor    $0x3f,%rax
    d0f8:	41 89 c2             	mov    %eax,%r10d
    d0fb:	85 c0                	test   %eax,%eax
    d0fd:	0f 85 0e ff ff ff    	jne    d011 <__divti3+0x81>
    d103:	49 39 f3             	cmp    %rsi,%r11
    d106:	72 0d                	jb     d115 <__divti3+0x185>
    d108:	31 f6                	xor    %esi,%esi
    d10a:	31 c0                	xor    %eax,%eax
    d10c:	4d 39 f0             	cmp    %r14,%r8
    d10f:	0f 82 ce fe ff ff    	jb     cfe3 <__divti3+0x53>
    d115:	31 f6                	xor    %esi,%esi
    d117:	b8 01 00 00 00       	mov    $0x1,%eax
    d11c:	e9 c2 fe ff ff       	jmp    cfe3 <__divti3+0x53>
    d121:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    d128:	48 8d 46 ff          	lea    -0x1(%rsi),%rax
    d12c:	31 f6                	xor    %esi,%esi
    d12e:	e9 b0 fe ff ff       	jmp    cfe3 <__divti3+0x53>
    d133:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    d13a:	00 00 00 
    d13d:	0f 1f 00             	nopl   (%rax)

000000000000d140 <atexit>:
    d140:	f3 0f 1e fa          	endbr64
    d144:	48 8b 15 3d 71 00 00 	mov    0x713d(%rip),%rdx        # 14288 <__dso_handle>
    d14b:	31 f6                	xor    %esi,%esi
    d14d:	e9 fe 52 ff ff       	jmp    2450 <__cxa_atexit@plt>

Disassembly of section .fini:

000000000000d154 <_fini>:
    d154:	f3 0f 1e fa          	endbr64
    d158:	48 83 ec 08          	sub    $0x8,%rsp
    d15c:	48 83 c4 08          	add    $0x8,%rsp
    d160:	c3                   	ret
