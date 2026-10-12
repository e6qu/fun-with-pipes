
/home/runner/work/_temp/numeric-layout-baseline/abi-diagnostic:     file format elf64-x86-64


Disassembly of section .init:

0000000000003000 <_init>:
    3000:	f3 0f 1e fa          	endbr64
    3004:	48 83 ec 08          	sub    $0x8,%rsp
    3008:	48 8b 05 b1 0f 01 00 	mov    0x10fb1(%rip),%rax        # 13fc0 <__gmon_start__@Base>
    300f:	48 85 c0             	test   %rax,%rax
    3012:	74 02                	je     3016 <_init+0x16>
    3014:	ff d0                	call   *%rax
    3016:	48 83 c4 08          	add    $0x8,%rsp
    301a:	c3                   	ret

Disassembly of section .plt:

0000000000003020 <getenv@plt-0x10>:
    3020:	ff 35 ca 0f 01 00    	push   0x10fca(%rip)        # 13ff0 <_GLOBAL_OFFSET_TABLE_+0x8>
    3026:	ff 25 cc 0f 01 00    	jmp    *0x10fcc(%rip)        # 13ff8 <_GLOBAL_OFFSET_TABLE_+0x10>
    302c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000003030 <getenv@plt>:
    3030:	ff 25 ca 0f 01 00    	jmp    *0x10fca(%rip)        # 14000 <getenv@GLIBC_2.2.5>
    3036:	68 00 00 00 00       	push   $0x0
    303b:	e9 e0 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003040 <dl_iterate_phdr@plt>:
    3040:	ff 25 c2 0f 01 00    	jmp    *0x10fc2(%rip)        # 14008 <dl_iterate_phdr@GLIBC_2.2.5>
    3046:	68 01 00 00 00       	push   $0x1
    304b:	e9 d0 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003050 <free@plt>:
    3050:	ff 25 ba 0f 01 00    	jmp    *0x10fba(%rip)        # 14010 <free@GLIBC_2.2.5>
    3056:	68 02 00 00 00       	push   $0x2
    305b:	e9 c0 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003060 <recv@plt>:
    3060:	ff 25 b2 0f 01 00    	jmp    *0x10fb2(%rip)        # 14018 <recv@GLIBC_2.2.5>
    3066:	68 03 00 00 00       	push   $0x3
    306b:	e9 b0 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003070 <abort@plt>:
    3070:	ff 25 aa 0f 01 00    	jmp    *0x10faa(%rip)        # 14020 <abort@GLIBC_2.2.5>
    3076:	68 04 00 00 00       	push   $0x4
    307b:	e9 a0 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003080 <__errno_location@plt>:
    3080:	ff 25 a2 0f 01 00    	jmp    *0x10fa2(%rip)        # 14028 <__errno_location@GLIBC_2.2.5>
    3086:	68 05 00 00 00       	push   $0x5
    308b:	e9 90 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003090 <strncmp@plt>:
    3090:	ff 25 9a 0f 01 00    	jmp    *0x10f9a(%rip)        # 14030 <strncmp@GLIBC_2.2.5>
    3096:	68 06 00 00 00       	push   $0x6
    309b:	e9 80 ff ff ff       	jmp    3020 <_init+0x20>

00000000000030a0 <_exit@plt>:
    30a0:	ff 25 92 0f 01 00    	jmp    *0x10f92(%rip)        # 14038 <_exit@GLIBC_2.2.5>
    30a6:	68 07 00 00 00       	push   $0x7
    30ab:	e9 70 ff ff ff       	jmp    3020 <_init+0x20>

00000000000030b0 <strcpy@plt>:
    30b0:	ff 25 8a 0f 01 00    	jmp    *0x10f8a(%rip)        # 14040 <strcpy@GLIBC_2.2.5>
    30b6:	68 08 00 00 00       	push   $0x8
    30bb:	e9 60 ff ff ff       	jmp    3020 <_init+0x20>

00000000000030c0 <sendmsg@plt>:
    30c0:	ff 25 82 0f 01 00    	jmp    *0x10f82(%rip)        # 14048 <sendmsg@GLIBC_2.2.5>
    30c6:	68 09 00 00 00       	push   $0x9
    30cb:	e9 50 ff ff ff       	jmp    3020 <_init+0x20>

00000000000030d0 <puts@plt>:
    30d0:	ff 25 7a 0f 01 00    	jmp    *0x10f7a(%rip)        # 14050 <puts@GLIBC_2.2.5>
    30d6:	68 0a 00 00 00       	push   $0xa
    30db:	e9 40 ff ff ff       	jmp    3020 <_init+0x20>

00000000000030e0 <sigaction@plt>:
    30e0:	ff 25 72 0f 01 00    	jmp    *0x10f72(%rip)        # 14058 <sigaction@GLIBC_2.2.5>
    30e6:	68 0b 00 00 00       	push   $0xb
    30eb:	e9 30 ff ff ff       	jmp    3020 <_init+0x20>

00000000000030f0 <fread@plt>:
    30f0:	ff 25 6a 0f 01 00    	jmp    *0x10f6a(%rip)        # 14060 <fread@GLIBC_2.2.5>
    30f6:	68 0c 00 00 00       	push   $0xc
    30fb:	e9 20 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003100 <strtod@plt>:
    3100:	ff 25 62 0f 01 00    	jmp    *0x10f62(%rip)        # 14068 <strtod@GLIBC_2.2.5>
    3106:	68 0d 00 00 00       	push   $0xd
    310b:	e9 10 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003110 <vsnprintf@plt>:
    3110:	ff 25 5a 0f 01 00    	jmp    *0x10f5a(%rip)        # 14070 <vsnprintf@GLIBC_2.2.5>
    3116:	68 0e 00 00 00       	push   $0xe
    311b:	e9 00 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003120 <fcntl@plt>:
    3120:	ff 25 52 0f 01 00    	jmp    *0x10f52(%rip)        # 14078 <fcntl@GLIBC_2.2.5>
    3126:	68 0f 00 00 00       	push   $0xf
    312b:	e9 f0 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003130 <clock_gettime@plt>:
    3130:	ff 25 4a 0f 01 00    	jmp    *0x10f4a(%rip)        # 14080 <clock_gettime@GLIBC_2.17>
    3136:	68 10 00 00 00       	push   $0x10
    313b:	e9 e0 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003140 <write@plt>:
    3140:	ff 25 42 0f 01 00    	jmp    *0x10f42(%rip)        # 14088 <write@GLIBC_2.2.5>
    3146:	68 11 00 00 00       	push   $0x11
    314b:	e9 d0 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003150 <fclose@plt>:
    3150:	ff 25 3a 0f 01 00    	jmp    *0x10f3a(%rip)        # 14090 <fclose@GLIBC_2.2.5>
    3156:	68 12 00 00 00       	push   $0x12
    315b:	e9 c0 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003160 <shutdown@plt>:
    3160:	ff 25 32 0f 01 00    	jmp    *0x10f32(%rip)        # 14098 <shutdown@GLIBC_2.2.5>
    3166:	68 13 00 00 00       	push   $0x13
    316b:	e9 b0 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003170 <strlen@plt>:
    3170:	ff 25 2a 0f 01 00    	jmp    *0x10f2a(%rip)        # 140a0 <strlen@GLIBC_2.2.5>
    3176:	68 14 00 00 00       	push   $0x14
    317b:	e9 a0 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003180 <getuid@plt>:
    3180:	ff 25 22 0f 01 00    	jmp    *0x10f22(%rip)        # 140a8 <getuid@GLIBC_2.2.5>
    3186:	68 15 00 00 00       	push   $0x15
    318b:	e9 90 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003190 <mmap@plt>:
    3190:	ff 25 1a 0f 01 00    	jmp    *0x10f1a(%rip)        # 140b0 <mmap@GLIBC_2.2.5>
    3196:	68 16 00 00 00       	push   $0x16
    319b:	e9 80 fe ff ff       	jmp    3020 <_init+0x20>

00000000000031a0 <send@plt>:
    31a0:	ff 25 12 0f 01 00    	jmp    *0x10f12(%rip)        # 140b8 <send@GLIBC_2.2.5>
    31a6:	68 17 00 00 00       	push   $0x17
    31ab:	e9 70 fe ff ff       	jmp    3020 <_init+0x20>

00000000000031b0 <strchr@plt>:
    31b0:	ff 25 0a 0f 01 00    	jmp    *0x10f0a(%rip)        # 140c0 <strchr@GLIBC_2.2.5>
    31b6:	68 18 00 00 00       	push   $0x18
    31bb:	e9 60 fe ff ff       	jmp    3020 <_init+0x20>

00000000000031c0 <printf@plt>:
    31c0:	ff 25 02 0f 01 00    	jmp    *0x10f02(%rip)        # 140c8 <printf@GLIBC_2.2.5>
    31c6:	68 19 00 00 00       	push   $0x19
    31cb:	e9 50 fe ff ff       	jmp    3020 <_init+0x20>

00000000000031d0 <snprintf@plt>:
    31d0:	ff 25 fa 0e 01 00    	jmp    *0x10efa(%rip)        # 140d0 <snprintf@GLIBC_2.2.5>
    31d6:	68 1a 00 00 00       	push   $0x1a
    31db:	e9 40 fe ff ff       	jmp    3020 <_init+0x20>

00000000000031e0 <ftruncate@plt>:
    31e0:	ff 25 f2 0e 01 00    	jmp    *0x10ef2(%rip)        # 140d8 <ftruncate@GLIBC_2.2.5>
    31e6:	68 1b 00 00 00       	push   $0x1b
    31eb:	e9 30 fe ff ff       	jmp    3020 <_init+0x20>

00000000000031f0 <fputs@plt>:
    31f0:	ff 25 ea 0e 01 00    	jmp    *0x10eea(%rip)        # 140e0 <fputs@GLIBC_2.2.5>
    31f6:	68 1c 00 00 00       	push   $0x1c
    31fb:	e9 20 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003200 <strtof@plt>:
    3200:	ff 25 e2 0e 01 00    	jmp    *0x10ee2(%rip)        # 140e8 <strtof@GLIBC_2.2.5>
    3206:	68 1d 00 00 00       	push   $0x1d
    320b:	e9 10 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003210 <memset@plt>:
    3210:	ff 25 da 0e 01 00    	jmp    *0x10eda(%rip)        # 140f0 <memset@GLIBC_2.2.5>
    3216:	68 1e 00 00 00       	push   $0x1e
    321b:	e9 00 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003220 <fgetc@plt>:
    3220:	ff 25 d2 0e 01 00    	jmp    *0x10ed2(%rip)        # 140f8 <fgetc@GLIBC_2.2.5>
    3226:	68 1f 00 00 00       	push   $0x1f
    322b:	e9 f0 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003230 <close@plt>:
    3230:	ff 25 ca 0e 01 00    	jmp    *0x10eca(%rip)        # 14100 <close@GLIBC_2.2.5>
    3236:	68 20 00 00 00       	push   $0x20
    323b:	e9 e0 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003240 <fputc@plt>:
    3240:	ff 25 c2 0e 01 00    	jmp    *0x10ec2(%rip)        # 14108 <fputc@GLIBC_2.2.5>
    3246:	68 21 00 00 00       	push   $0x21
    324b:	e9 d0 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003250 <sched_yield@plt>:
    3250:	ff 25 ba 0e 01 00    	jmp    *0x10eba(%rip)        # 14110 <sched_yield@GLIBC_2.2.5>
    3256:	68 22 00 00 00       	push   $0x22
    325b:	e9 c0 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003260 <memchr@plt>:
    3260:	ff 25 b2 0e 01 00    	jmp    *0x10eb2(%rip)        # 14118 <memchr@GLIBC_2.2.5>
    3266:	68 23 00 00 00       	push   $0x23
    326b:	e9 b0 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003270 <memcmp@plt>:
    3270:	ff 25 aa 0e 01 00    	jmp    *0x10eaa(%rip)        # 14120 <memcmp@GLIBC_2.2.5>
    3276:	68 24 00 00 00       	push   $0x24
    327b:	e9 a0 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003280 <pthread_attr_init@plt>:
    3280:	ff 25 a2 0e 01 00    	jmp    *0x10ea2(%rip)        # 14128 <pthread_attr_init@GLIBC_2.2.5>
    3286:	68 25 00 00 00       	push   $0x25
    328b:	e9 90 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003290 <fgets@plt>:
    3290:	ff 25 9a 0e 01 00    	jmp    *0x10e9a(%rip)        # 14130 <fgets@GLIBC_2.2.5>
    3296:	68 26 00 00 00       	push   $0x26
    329b:	e9 80 fd ff ff       	jmp    3020 <_init+0x20>

00000000000032a0 <getsockopt@plt>:
    32a0:	ff 25 92 0e 01 00    	jmp    *0x10e92(%rip)        # 14138 <getsockopt@GLIBC_2.2.5>
    32a6:	68 27 00 00 00       	push   $0x27
    32ab:	e9 70 fd ff ff       	jmp    3020 <_init+0x20>

00000000000032b0 <_setjmp@plt>:
    32b0:	ff 25 8a 0e 01 00    	jmp    *0x10e8a(%rip)        # 14140 <_setjmp@GLIBC_2.2.5>
    32b6:	68 28 00 00 00       	push   $0x28
    32bb:	e9 60 fd ff ff       	jmp    3020 <_init+0x20>

00000000000032c0 <strtoull@plt>:
    32c0:	ff 25 82 0e 01 00    	jmp    *0x10e82(%rip)        # 14148 <strtoull@GLIBC_2.2.5>
    32c6:	68 29 00 00 00       	push   $0x29
    32cb:	e9 50 fd ff ff       	jmp    3020 <_init+0x20>

00000000000032d0 <strcmp@plt>:
    32d0:	ff 25 7a 0e 01 00    	jmp    *0x10e7a(%rip)        # 14150 <strcmp@GLIBC_2.2.5>
    32d6:	68 2a 00 00 00       	push   $0x2a
    32db:	e9 40 fd ff ff       	jmp    3020 <_init+0x20>

00000000000032e0 <signal@plt>:
    32e0:	ff 25 72 0e 01 00    	jmp    *0x10e72(%rip)        # 14158 <signal@GLIBC_2.2.5>
    32e6:	68 2b 00 00 00       	push   $0x2b
    32eb:	e9 30 fd ff ff       	jmp    3020 <_init+0x20>

00000000000032f0 <fprintf@plt>:
    32f0:	ff 25 6a 0e 01 00    	jmp    *0x10e6a(%rip)        # 14160 <fprintf@GLIBC_2.2.5>
    32f6:	68 2c 00 00 00       	push   $0x2c
    32fb:	e9 20 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003300 <syscall@plt>:
    3300:	ff 25 62 0e 01 00    	jmp    *0x10e62(%rip)        # 14168 <syscall@GLIBC_2.2.5>
    3306:	68 2d 00 00 00       	push   $0x2d
    330b:	e9 10 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003310 <sigemptyset@plt>:
    3310:	ff 25 5a 0e 01 00    	jmp    *0x10e5a(%rip)        # 14170 <sigemptyset@GLIBC_2.2.5>
    3316:	68 2e 00 00 00       	push   $0x2e
    331b:	e9 00 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003320 <strtol@plt>:
    3320:	ff 25 52 0e 01 00    	jmp    *0x10e52(%rip)        # 14178 <strtol@GLIBC_2.2.5>
    3326:	68 2f 00 00 00       	push   $0x2f
    332b:	e9 f0 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003330 <memcpy@plt>:
    3330:	ff 25 4a 0e 01 00    	jmp    *0x10e4a(%rip)        # 14180 <memcpy@GLIBC_2.14>
    3336:	68 30 00 00 00       	push   $0x30
    333b:	e9 e0 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003340 <malloc@plt>:
    3340:	ff 25 42 0e 01 00    	jmp    *0x10e42(%rip)        # 14188 <malloc@GLIBC_2.2.5>
    3346:	68 31 00 00 00       	push   $0x31
    334b:	e9 d0 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003350 <fflush@plt>:
    3350:	ff 25 3a 0e 01 00    	jmp    *0x10e3a(%rip)        # 14190 <fflush@GLIBC_2.2.5>
    3356:	68 32 00 00 00       	push   $0x32
    335b:	e9 c0 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003360 <listen@plt>:
    3360:	ff 25 32 0e 01 00    	jmp    *0x10e32(%rip)        # 14198 <listen@GLIBC_2.2.5>
    3366:	68 33 00 00 00       	push   $0x33
    336b:	e9 b0 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003370 <bcmp@plt>:
    3370:	ff 25 2a 0e 01 00    	jmp    *0x10e2a(%rip)        # 141a0 <bcmp@GLIBC_2.2.5>
    3376:	68 34 00 00 00       	push   $0x34
    337b:	e9 a0 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003380 <realloc@plt>:
    3380:	ff 25 22 0e 01 00    	jmp    *0x10e22(%rip)        # 141a8 <realloc@GLIBC_2.2.5>
    3386:	68 35 00 00 00       	push   $0x35
    338b:	e9 90 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003390 <munmap@plt>:
    3390:	ff 25 1a 0e 01 00    	jmp    *0x10e1a(%rip)        # 141b0 <munmap@GLIBC_2.2.5>
    3396:	68 36 00 00 00       	push   $0x36
    339b:	e9 80 fc ff ff       	jmp    3020 <_init+0x20>

00000000000033a0 <recvmsg@plt>:
    33a0:	ff 25 12 0e 01 00    	jmp    *0x10e12(%rip)        # 141b8 <recvmsg@GLIBC_2.2.5>
    33a6:	68 37 00 00 00       	push   $0x37
    33ab:	e9 70 fc ff ff       	jmp    3020 <_init+0x20>

00000000000033b0 <setvbuf@plt>:
    33b0:	ff 25 0a 0e 01 00    	jmp    *0x10e0a(%rip)        # 141c0 <setvbuf@GLIBC_2.2.5>
    33b6:	68 38 00 00 00       	push   $0x38
    33bb:	e9 60 fc ff ff       	jmp    3020 <_init+0x20>

00000000000033c0 <poll@plt>:
    33c0:	ff 25 02 0e 01 00    	jmp    *0x10e02(%rip)        # 141c8 <poll@GLIBC_2.2.5>
    33c6:	68 39 00 00 00       	push   $0x39
    33cb:	e9 50 fc ff ff       	jmp    3020 <_init+0x20>

00000000000033d0 <bind@plt>:
    33d0:	ff 25 fa 0d 01 00    	jmp    *0x10dfa(%rip)        # 141d0 <bind@GLIBC_2.2.5>
    33d6:	68 3a 00 00 00       	push   $0x3a
    33db:	e9 40 fc ff ff       	jmp    3020 <_init+0x20>

00000000000033e0 <pthread_create@plt>:
    33e0:	ff 25 f2 0d 01 00    	jmp    *0x10df2(%rip)        # 141d8 <pthread_create@GLIBC_2.34>
    33e6:	68 3b 00 00 00       	push   $0x3b
    33eb:	e9 30 fc ff ff       	jmp    3020 <_init+0x20>

00000000000033f0 <madvise@plt>:
    33f0:	ff 25 ea 0d 01 00    	jmp    *0x10dea(%rip)        # 141e0 <madvise@GLIBC_2.2.5>
    33f6:	68 3c 00 00 00       	push   $0x3c
    33fb:	e9 20 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003400 <atol@plt>:
    3400:	ff 25 e2 0d 01 00    	jmp    *0x10de2(%rip)        # 141e8 <atol@GLIBC_2.2.5>
    3406:	68 3d 00 00 00       	push   $0x3d
    340b:	e9 10 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003410 <mprotect@plt>:
    3410:	ff 25 da 0d 01 00    	jmp    *0x10dda(%rip)        # 141f0 <mprotect@GLIBC_2.2.5>
    3416:	68 3e 00 00 00       	push   $0x3e
    341b:	e9 00 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003420 <fopen@plt>:
    3420:	ff 25 d2 0d 01 00    	jmp    *0x10dd2(%rip)        # 141f8 <fopen@GLIBC_2.2.5>
    3426:	68 3f 00 00 00       	push   $0x3f
    342b:	e9 f0 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003430 <sysconf@plt>:
    3430:	ff 25 ca 0d 01 00    	jmp    *0x10dca(%rip)        # 14200 <sysconf@GLIBC_2.2.5>
    3436:	68 40 00 00 00       	push   $0x40
    343b:	e9 e0 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003440 <accept@plt>:
    3440:	ff 25 c2 0d 01 00    	jmp    *0x10dc2(%rip)        # 14208 <accept@GLIBC_2.2.5>
    3446:	68 41 00 00 00       	push   $0x41
    344b:	e9 d0 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003450 <__cxa_atexit@plt>:
    3450:	ff 25 ba 0d 01 00    	jmp    *0x10dba(%rip)        # 14210 <__cxa_atexit@GLIBC_2.2.5>
    3456:	68 42 00 00 00       	push   $0x42
    345b:	e9 c0 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003460 <atoi@plt>:
    3460:	ff 25 b2 0d 01 00    	jmp    *0x10db2(%rip)        # 14218 <atoi@GLIBC_2.2.5>
    3466:	68 43 00 00 00       	push   $0x43
    346b:	e9 b0 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003470 <sprintf@plt>:
    3470:	ff 25 aa 0d 01 00    	jmp    *0x10daa(%rip)        # 14220 <sprintf@GLIBC_2.2.5>
    3476:	68 44 00 00 00       	push   $0x44
    347b:	e9 a0 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003480 <exit@plt>:
    3480:	ff 25 a2 0d 01 00    	jmp    *0x10da2(%rip)        # 14228 <exit@GLIBC_2.2.5>
    3486:	68 45 00 00 00       	push   $0x45
    348b:	e9 90 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003490 <connect@plt>:
    3490:	ff 25 9a 0d 01 00    	jmp    *0x10d9a(%rip)        # 14230 <connect@GLIBC_2.2.5>
    3496:	68 46 00 00 00       	push   $0x46
    349b:	e9 80 fb ff ff       	jmp    3020 <_init+0x20>

00000000000034a0 <fwrite@plt>:
    34a0:	ff 25 92 0d 01 00    	jmp    *0x10d92(%rip)        # 14238 <fwrite@GLIBC_2.2.5>
    34a6:	68 47 00 00 00       	push   $0x47
    34ab:	e9 70 fb ff ff       	jmp    3020 <_init+0x20>

00000000000034b0 <getrlimit@plt>:
    34b0:	ff 25 8a 0d 01 00    	jmp    *0x10d8a(%rip)        # 14240 <getrlimit@GLIBC_2.2.5>
    34b6:	68 48 00 00 00       	push   $0x48
    34bb:	e9 60 fb ff ff       	jmp    3020 <_init+0x20>

00000000000034c0 <pthread_join@plt>:
    34c0:	ff 25 82 0d 01 00    	jmp    *0x10d82(%rip)        # 14248 <pthread_join@GLIBC_2.34>
    34c6:	68 49 00 00 00       	push   $0x49
    34cb:	e9 50 fb ff ff       	jmp    3020 <_init+0x20>

00000000000034d0 <sigaltstack@plt>:
    34d0:	ff 25 7a 0d 01 00    	jmp    *0x10d7a(%rip)        # 14250 <sigaltstack@GLIBC_2.2.5>
    34d6:	68 4a 00 00 00       	push   $0x4a
    34db:	e9 40 fb ff ff       	jmp    3020 <_init+0x20>

00000000000034e0 <fstat@plt>:
    34e0:	ff 25 72 0d 01 00    	jmp    *0x10d72(%rip)        # 14258 <fstat@GLIBC_2.33>
    34e6:	68 4b 00 00 00       	push   $0x4b
    34eb:	e9 30 fb ff ff       	jmp    3020 <_init+0x20>

00000000000034f0 <strstr@plt>:
    34f0:	ff 25 6a 0d 01 00    	jmp    *0x10d6a(%rip)        # 14260 <strstr@GLIBC_2.2.5>
    34f6:	68 4c 00 00 00       	push   $0x4c
    34fb:	e9 20 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003500 <__ctype_b_loc@plt>:
    3500:	ff 25 62 0d 01 00    	jmp    *0x10d62(%rip)        # 14268 <__ctype_b_loc@GLIBC_2.3>
    3506:	68 4d 00 00 00       	push   $0x4d
    350b:	e9 10 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003510 <socket@plt>:
    3510:	ff 25 5a 0d 01 00    	jmp    *0x10d5a(%rip)        # 14270 <socket@GLIBC_2.2.5>
    3516:	68 4e 00 00 00       	push   $0x4e
    351b:	e9 00 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003520 <pthread_attr_setstacksize@plt>:
    3520:	ff 25 52 0d 01 00    	jmp    *0x10d52(%rip)        # 14278 <pthread_attr_setstacksize@GLIBC_2.34>
    3526:	68 4f 00 00 00       	push   $0x4f
    352b:	e9 f0 fa ff ff       	jmp    3020 <_init+0x20>

Disassembly of section .plt.got:

0000000000003530 <__cxa_finalize@plt>:
    3530:	ff 25 9a 0a 01 00    	jmp    *0x10a9a(%rip)        # 13fd0 <__cxa_finalize@GLIBC_2.2.5>
    3536:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

0000000000003540 <_start>:
    3540:	f3 0f 1e fa          	endbr64
    3544:	31 ed                	xor    %ebp,%ebp
    3546:	49 89 d1             	mov    %rdx,%r9
    3549:	5e                   	pop    %rsi
    354a:	48 89 e2             	mov    %rsp,%rdx
    354d:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
    3551:	50                   	push   %rax
    3552:	54                   	push   %rsp
    3553:	45 31 c0             	xor    %r8d,%r8d
    3556:	31 c9                	xor    %ecx,%ecx
    3558:	48 8d 3d b1 02 00 00 	lea    0x2b1(%rip),%rdi        # 3810 <main>
    355f:	ff 15 3b 0a 01 00    	call   *0x10a3b(%rip)        # 13fa0 <__libc_start_main@GLIBC_2.34>
    3565:	f4                   	hlt
    3566:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    356d:	00 00 00 

0000000000003570 <deregister_tm_clones>:
    3570:	48 8d 3d 19 2e 01 00 	lea    0x12e19(%rip),%rdi        # 16390 <__TMC_END__>
    3577:	48 8d 05 12 2e 01 00 	lea    0x12e12(%rip),%rax        # 16390 <__TMC_END__>
    357e:	48 39 f8             	cmp    %rdi,%rax
    3581:	74 15                	je     3598 <deregister_tm_clones+0x28>
    3583:	48 8b 05 1e 0a 01 00 	mov    0x10a1e(%rip),%rax        # 13fa8 <_ITM_deregisterTMCloneTable@Base>
    358a:	48 85 c0             	test   %rax,%rax
    358d:	74 09                	je     3598 <deregister_tm_clones+0x28>
    358f:	ff e0                	jmp    *%rax
    3591:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    3598:	c3                   	ret
    3599:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000035a0 <register_tm_clones>:
    35a0:	48 8d 3d e9 2d 01 00 	lea    0x12de9(%rip),%rdi        # 16390 <__TMC_END__>
    35a7:	48 8d 35 e2 2d 01 00 	lea    0x12de2(%rip),%rsi        # 16390 <__TMC_END__>
    35ae:	48 29 fe             	sub    %rdi,%rsi
    35b1:	48 89 f0             	mov    %rsi,%rax
    35b4:	48 c1 ee 3f          	shr    $0x3f,%rsi
    35b8:	48 c1 f8 03          	sar    $0x3,%rax
    35bc:	48 01 c6             	add    %rax,%rsi
    35bf:	48 d1 fe             	sar    $1,%rsi
    35c2:	74 14                	je     35d8 <register_tm_clones+0x38>
    35c4:	48 8b 05 fd 09 01 00 	mov    0x109fd(%rip),%rax        # 13fc8 <_ITM_registerTMCloneTable@Base>
    35cb:	48 85 c0             	test   %rax,%rax
    35ce:	74 08                	je     35d8 <register_tm_clones+0x38>
    35d0:	ff e0                	jmp    *%rax
    35d2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    35d8:	c3                   	ret
    35d9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000035e0 <__do_global_dtors_aux>:
    35e0:	f3 0f 1e fa          	endbr64
    35e4:	80 3d a5 2d 01 00 00 	cmpb   $0x0,0x12da5(%rip)        # 16390 <__TMC_END__>
    35eb:	75 2b                	jne    3618 <__do_global_dtors_aux+0x38>
    35ed:	55                   	push   %rbp
    35ee:	48 83 3d da 09 01 00 	cmpq   $0x0,0x109da(%rip)        # 13fd0 <__cxa_finalize@GLIBC_2.2.5>
    35f5:	00 
    35f6:	48 89 e5             	mov    %rsp,%rbp
    35f9:	74 0c                	je     3607 <__do_global_dtors_aux+0x27>
    35fb:	48 8b 3d 86 0c 01 00 	mov    0x10c86(%rip),%rdi        # 14288 <__dso_handle>
    3602:	e8 29 ff ff ff       	call   3530 <__cxa_finalize@plt>
    3607:	e8 64 ff ff ff       	call   3570 <deregister_tm_clones>
    360c:	c6 05 7d 2d 01 00 01 	movb   $0x1,0x12d7d(%rip)        # 16390 <__TMC_END__>
    3613:	5d                   	pop    %rbp
    3614:	c3                   	ret
    3615:	0f 1f 00             	nopl   (%rax)
    3618:	c3                   	ret
    3619:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000003620 <frame_dummy>:
    3620:	f3 0f 1e fa          	endbr64
    3624:	e9 77 ff ff ff       	jmp    35a0 <register_tm_clones>
    3629:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000003630 <original_main>:
    3630:	41 56                	push   %r14
    3632:	53                   	push   %rbx
    3633:	48 83 ec 58          	sub    $0x58,%rsp
    3637:	48 8d 05 82 02 01 00 	lea    0x10282(%rip),%rax        # 138c0 <fwp_fn_table>
    363e:	48 89 05 5b 2d 01 00 	mov    %rax,0x12d5b(%rip)        # 163a0 <fwp_fns>
    3645:	4c 8b 35 64 09 01 00 	mov    0x10964(%rip),%r14        # 13fb0 <stdout@GLIBC_2.2.5>
    364c:	49 8b 06             	mov    (%r14),%rax
    364f:	48 89 05 52 2d 01 00 	mov    %rax,0x12d52(%rip)        # 163a8 <fwp_prog_out>
    3656:	89 3d 54 2d 01 00    	mov    %edi,0x12d54(%rip)        # 163b0 <fwp_argc>
    365c:	48 89 35 55 2d 01 00 	mov    %rsi,0x12d55(%rip)        # 163b8 <fwp_argv>
    3663:	48 8d 35 56 2d 01 00 	lea    0x12d56(%rip),%rsi        # 163c0 <fwp_start_time>
    366a:	bf 01 00 00 00       	mov    $0x1,%edi
    366f:	e8 bc fa ff ff       	call   3130 <clock_gettime@plt>
    3674:	e8 b7 00 00 00       	call   3730 <fwp_seed_rng>
    3679:	49 8b 3e             	mov    (%r14),%rdi
    367c:	b9 00 00 01 00       	mov    $0x10000,%ecx
    3681:	31 f6                	xor    %esi,%esi
    3683:	31 d2                	xor    %edx,%edx
    3685:	e8 26 fd ff ff       	call   33b0 <setvbuf@plt>
    368a:	be 01 00 00 00       	mov    $0x1,%esi
    368f:	bf 0d 00 00 00       	mov    $0xd,%edi
    3694:	e8 47 fc ff ff       	call   32e0 <signal@plt>
    3699:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    369e:	48 89 df             	mov    %rbx,%rdi
    36a1:	e8 da fb ff ff       	call   3280 <pthread_attr_init@plt>
    36a6:	48 8b 35 e3 0b 01 00 	mov    0x10be3(%rip),%rsi        # 14290 <fwp_main_stack>
    36ad:	48 89 df             	mov    %rbx,%rdi
    36b0:	e8 6b fe ff ff       	call   3520 <pthread_attr_setstacksize@plt>
    36b5:	48 8d 15 d4 00 00 00 	lea    0xd4(%rip),%rdx        # 3790 <fwp_main_thread>
    36bc:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    36c1:	48 89 de             	mov    %rbx,%rsi
    36c4:	31 c9                	xor    %ecx,%ecx
    36c6:	e8 15 fd ff ff       	call   33e0 <pthread_create@plt>
    36cb:	85 c0                	test   %eax,%eax
    36cd:	74 35                	je     3704 <original_main+0xd4>
    36cf:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    36d4:	bf 03 00 00 00       	mov    $0x3,%edi
    36d9:	e8 d2 fd ff ff       	call   34b0 <getrlimit@plt>
    36de:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    36e3:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
    36e7:	ba 00 00 80 00       	mov    $0x800000,%edx
    36ec:	48 0f 44 ca          	cmove  %rdx,%rcx
    36f0:	85 c0                	test   %eax,%eax
    36f2:	48 0f 45 ca          	cmovne %rdx,%rcx
    36f6:	48 89 0d 93 0b 01 00 	mov    %rcx,0x10b93(%rip)        # 14290 <fwp_main_stack>
    36fd:	e8 8e 00 00 00       	call   3790 <fwp_main_thread>
    3702:	eb 0c                	jmp    3710 <original_main+0xe0>
    3704:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    3709:	31 f6                	xor    %esi,%esi
    370b:	e8 b0 fd ff ff       	call   34c0 <pthread_join@plt>
    3710:	49 8b 3e             	mov    (%r14),%rdi
    3713:	e8 38 fc ff ff       	call   3350 <fflush@plt>
    3718:	8b 05 b2 2c 01 00    	mov    0x12cb2(%rip),%eax        # 163d0 <fwp_exit_code>
    371e:	48 83 c4 58          	add    $0x58,%rsp
    3722:	5b                   	pop    %rbx
    3723:	41 5e                	pop    %r14
    3725:	c3                   	ret
    3726:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    372d:	00 00 00 

0000000000003730 <fwp_seed_rng>:
    3730:	53                   	push   %rbx
    3731:	48 83 ec 20          	sub    $0x20,%rsp
    3735:	48 8d 3d 6d b2 00 00 	lea    0xb26d(%rip),%rdi        # e9a9 <exec_in_fp0+0x2a9>
    373c:	e8 ef f8 ff ff       	call   3030 <getenv@plt>
    3741:	48 85 c0             	test   %rax,%rax
    3744:	74 24                	je     376a <fwp_seed_rng+0x3a>
    3746:	48 89 c3             	mov    %rax,%rbx
    3749:	80 38 00             	cmpb   $0x0,(%rax)
    374c:	74 1c                	je     376a <fwp_seed_rng+0x3a>
    374e:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    3753:	48 89 df             	mov    %rbx,%rdi
    3756:	ba 0a 00 00 00       	mov    $0xa,%edx
    375b:	e8 60 fb ff ff       	call   32c0 <strtoull@plt>
    3760:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    3765:	80 38 00             	cmpb   $0x0,(%rax)
    3768:	74 12                	je     377c <fwp_seed_rng+0x4c>
    376a:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    376f:	31 ff                	xor    %edi,%edi
    3771:	e8 ba f9 ff ff       	call   3130 <clock_gettime@plt>
    3776:	48 83 c4 20          	add    $0x20,%rsp
    377a:	5b                   	pop    %rbx
    377b:	c3                   	ret
    377c:	0f b6 03             	movzbl (%rbx),%eax
    377f:	83 f8 2d             	cmp    $0x2d,%eax
    3782:	74 e6                	je     376a <fwp_seed_rng+0x3a>
    3784:	83 f8 2b             	cmp    $0x2b,%eax
    3787:	74 e1                	je     376a <fwp_seed_rng+0x3a>
    3789:	eb eb                	jmp    3776 <fwp_seed_rng+0x46>
    378b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000003790 <fwp_main_thread>:
    3790:	55                   	push   %rbp
    3791:	48 89 e5             	mov    %rsp,%rbp
    3794:	48 89 ef             	mov    %rbp,%rdi
    3797:	e8 e4 02 00 00       	call   3a80 <fwp_gc_start>
    379c:	48 8b 3d ed 0a 01 00 	mov    0x10aed(%rip),%rdi        # 14290 <fwp_main_stack>
    37a3:	e8 68 2b 00 00       	call   6310 <fwp_stack_guard_init>
    37a8:	48 8b 05 61 04 01 00 	mov    0x10461(%rip),%rax        # 13c10 <exec_scripts+0x10>
    37af:	48 89 05 3a 2c 01 00 	mov    %rax,0x12c3a(%rip)        # 163f0 <fwp_cli_scripts+0x10>
    37b6:	0f 28 05 43 04 01 00 	movaps 0x10443(%rip),%xmm0        # 13c00 <exec_scripts>
    37bd:	0f 29 05 1c 2c 01 00 	movaps %xmm0,0x12c1c(%rip)        # 163e0 <fwp_cli_scripts>
    37c4:	48 8d 05 35 ad 00 00 	lea    0xad35(%rip),%rax        # e500 <exec_man>
    37cb:	48 89 05 26 2c 01 00 	mov    %rax,0x12c26(%rip)        # 163f8 <fwp_cli_man>
    37d2:	c6 05 27 2c 01 00 01 	movb   $0x1,0x12c27(%rip)        # 16400 <fwp_cli_single>
    37d9:	8b 3d d1 2b 01 00    	mov    0x12bd1(%rip),%edi        # 163b0 <fwp_argc>
    37df:	48 8b 35 d2 2b 01 00 	mov    0x12bd2(%rip),%rsi        # 163b8 <fwp_argv>
    37e6:	e8 05 2c 00 00       	call   63f0 <fwp_exec>
    37eb:	89 05 df 2b 01 00    	mov    %eax,0x12bdf(%rip)        # 163d0 <fwp_exit_code>
    37f1:	48 8b 05 b8 07 01 00 	mov    0x107b8(%rip),%rax        # 13fb0 <stdout@GLIBC_2.2.5>
    37f8:	48 8b 38             	mov    (%rax),%rdi
    37fb:	e8 50 fb ff ff       	call   3350 <fflush@plt>
    3800:	31 c0                	xor    %eax,%eax
    3802:	5d                   	pop    %rbp
    3803:	c3                   	ret
    3804:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    380b:	00 00 00 00 00 

0000000000003810 <main>:
    3810:	55                   	push   %rbp
    3811:	48 89 e5             	mov    %rsp,%rbp
    3814:	41 57                	push   %r15
    3816:	41 56                	push   %r14
    3818:	41 55                	push   %r13
    381a:	41 54                	push   %r12
    381c:	53                   	push   %rbx
    381d:	50                   	push   %rax
    381e:	48 89 ef             	mov    %rbp,%rdi
    3821:	e8 5a 02 00 00       	call   3a80 <fwp_gc_start>
    3826:	48 8d 05 93 00 01 00 	lea    0x10093(%rip),%rax        # 138c0 <fwp_fn_table>
    382d:	48 89 05 6c 2b 01 00 	mov    %rax,0x12b6c(%rip)        # 163a0 <fwp_fns>
    3834:	bf 01 01 00 00       	mov    $0x101,%edi
    3839:	e8 f2 02 00 00       	call   3b30 <f0>
    383e:	48 89 c3             	mov    %rax,%rbx
    3841:	b8 78 00 00 00       	mov    $0x78,%eax
    3846:	83 7b 04 08          	cmpl   $0x8,0x4(%rbx)
    384a:	0f 85 12 02 00 00    	jne    3a62 <main+0x252>
    3850:	48 8d 3d d7 ae 00 00 	lea    0xaed7(%rip),%rdi        # e72e <exec_in_fp0+0x2e>
    3857:	be 08 00 00 00       	mov    $0x8,%esi
    385c:	ba 08 00 00 00       	mov    $0x8,%edx
    3861:	b9 08 00 00 00       	mov    $0x8,%ecx
    3866:	41 b8 08 00 00 00    	mov    $0x8,%r8d
    386c:	31 c0                	xor    %eax,%eax
    386e:	e8 4d f9 ff ff       	call   31c0 <printf@plt>
    3873:	4c 8d 1d 46 ac 00 00 	lea    0xac46(%rip),%r11        # e4c0 <_IO_stdin_used+0x4c0>
    387a:	4c 8d 05 60 b6 00 00 	lea    0xb660(%rip),%r8        # eee1 <exec_in_fp0+0x7e1>
    3881:	4c 8d 25 5a af 00 00 	lea    0xaf5a(%rip),%r12        # e7e2 <exec_in_fp0+0xe2>
    3888:	4c 8d 3d 0d ac 00 00 	lea    0xac0d(%rip),%r15        # e49c <_IO_stdin_used+0x49c>
    388f:	48 8d 3d ee ae 00 00 	lea    0xaeee(%rip),%rdi        # e784 <exec_in_fp0+0x84>
    3896:	45 31 ed             	xor    %r13d,%r13d
    3899:	4a 8b 54 eb 08       	mov    0x8(%rbx,%r13,8),%rdx
    389e:	b8 7a 00 00 00       	mov    $0x7a,%eax
    38a3:	48 81 3a 01 01 00 00 	cmpq   $0x101,(%rdx)
    38aa:	0f 85 b2 01 00 00    	jne    3a62 <main+0x252>
    38b0:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
    38b4:	f6 c1 07             	test   $0x7,%cl
    38b7:	0f 85 a5 01 00 00    	jne    3a62 <main+0x252>
    38bd:	4b 8b 34 eb          	mov    (%r11,%r13,8),%rsi
    38c1:	45 31 f6             	xor    %r14d,%r14d
    38c4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    38cb:	00 00 00 00 00 
    38d0:	b8 7b 00 00 00       	mov    $0x7b,%eax
    38d5:	4a 39 74 f2 08       	cmp    %rsi,0x8(%rdx,%r14,8)
    38da:	0f 85 82 01 00 00    	jne    3a62 <main+0x252>
    38e0:	49 81 fe 00 01 00 00 	cmp    $0x100,%r14
    38e7:	74 27                	je     3910 <main+0x100>
    38e9:	4a 39 74 f2 10       	cmp    %rsi,0x10(%rdx,%r14,8)
    38ee:	0f 85 6e 01 00 00    	jne    3a62 <main+0x252>
    38f4:	4a 39 74 f2 18       	cmp    %rsi,0x18(%rdx,%r14,8)
    38f9:	0f 85 63 01 00 00    	jne    3a62 <main+0x252>
    38ff:	4a 39 74 f2 20       	cmp    %rsi,0x20(%rdx,%r14,8)
    3904:	0f 85 58 01 00 00    	jne    3a62 <main+0x252>
    390a:	49 83 c6 04          	add    $0x4,%r14
    390e:	eb c0                	jmp    38d0 <main+0xc0>
    3910:	4d 85 ed             	test   %r13,%r13
    3913:	4c 89 e6             	mov    %r12,%rsi
    3916:	49 0f 44 f0          	cmove  %r8,%rsi
    391a:	4b 63 14 af          	movslq (%r15,%r13,4),%rdx
    391e:	4c 01 fa             	add    %r15,%rdx
    3921:	48 8b 09             	mov    (%rcx),%rcx
    3924:	41 b8 10 08 00 00    	mov    $0x810,%r8d
    392a:	31 c0                	xor    %eax,%eax
    392c:	4d 89 de             	mov    %r11,%r14
    392f:	e8 8c f8 ff ff       	call   31c0 <printf@plt>
    3934:	4d 89 f3             	mov    %r14,%r11
    3937:	48 8d 3d 46 ae 00 00 	lea    0xae46(%rip),%rdi        # e784 <exec_in_fp0+0x84>
    393e:	4c 8d 05 9c b5 00 00 	lea    0xb59c(%rip),%r8        # eee1 <exec_in_fp0+0x7e1>
    3945:	49 ff c5             	inc    %r13
    3948:	49 83 fd 08          	cmp    $0x8,%r13
    394c:	0f 85 47 ff ff ff    	jne    3899 <main+0x89>
    3952:	48 8d 3d 8b ae 00 00 	lea    0xae8b(%rip),%rdi        # e7e4 <exec_in_fp0+0xe4>
    3959:	e8 72 f7 ff ff       	call   30d0 <puts@plt>
    395e:	48 89 df             	mov    %rbx,%rdi
    3961:	e8 5a 02 00 00       	call   3bc0 <fwp_rc_release_last>
    3966:	85 c0                	test   %eax,%eax
    3968:	0f 84 e8 00 00 00    	je     3a56 <main+0x246>
    396e:	4c 8b 73 08          	mov    0x8(%rbx),%r14
    3972:	4c 89 f7             	mov    %r14,%rdi
    3975:	e8 46 02 00 00       	call   3bc0 <fwp_rc_release_last>
    397a:	89 c1                	mov    %eax,%ecx
    397c:	b8 7d 00 00 00       	mov    $0x7d,%eax
    3981:	85 c9                	test   %ecx,%ecx
    3983:	0f 84 d9 00 00 00    	je     3a62 <main+0x252>
    3989:	4c 89 f7             	mov    %r14,%rdi
    398c:	e8 5f 02 00 00       	call   3bf0 <fwp_rc_free_arr>
    3991:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    3995:	4c 89 f7             	mov    %r14,%rdi
    3998:	e8 23 02 00 00       	call   3bc0 <fwp_rc_release_last>
    399d:	85 c0                	test   %eax,%eax
    399f:	0f 84 b8 00 00 00    	je     3a5d <main+0x24d>
    39a5:	4c 89 f7             	mov    %r14,%rdi
    39a8:	e8 43 02 00 00       	call   3bf0 <fwp_rc_free_arr>
    39ad:	4c 8b 73 18          	mov    0x18(%rbx),%r14
    39b1:	4c 89 f7             	mov    %r14,%rdi
    39b4:	e8 07 02 00 00       	call   3bc0 <fwp_rc_release_last>
    39b9:	85 c0                	test   %eax,%eax
    39bb:	0f 84 9c 00 00 00    	je     3a5d <main+0x24d>
    39c1:	4c 89 f7             	mov    %r14,%rdi
    39c4:	e8 27 02 00 00       	call   3bf0 <fwp_rc_free_arr>
    39c9:	4c 8b 73 20          	mov    0x20(%rbx),%r14
    39cd:	4c 89 f7             	mov    %r14,%rdi
    39d0:	e8 eb 01 00 00       	call   3bc0 <fwp_rc_release_last>
    39d5:	85 c0                	test   %eax,%eax
    39d7:	0f 84 80 00 00 00    	je     3a5d <main+0x24d>
    39dd:	4c 89 f7             	mov    %r14,%rdi
    39e0:	e8 0b 02 00 00       	call   3bf0 <fwp_rc_free_arr>
    39e5:	4c 8b 73 28          	mov    0x28(%rbx),%r14
    39e9:	4c 89 f7             	mov    %r14,%rdi
    39ec:	e8 cf 01 00 00       	call   3bc0 <fwp_rc_release_last>
    39f1:	85 c0                	test   %eax,%eax
    39f3:	74 68                	je     3a5d <main+0x24d>
    39f5:	4c 89 f7             	mov    %r14,%rdi
    39f8:	e8 f3 01 00 00       	call   3bf0 <fwp_rc_free_arr>
    39fd:	4c 8b 73 30          	mov    0x30(%rbx),%r14
    3a01:	4c 89 f7             	mov    %r14,%rdi
    3a04:	e8 b7 01 00 00       	call   3bc0 <fwp_rc_release_last>
    3a09:	85 c0                	test   %eax,%eax
    3a0b:	74 50                	je     3a5d <main+0x24d>
    3a0d:	4c 89 f7             	mov    %r14,%rdi
    3a10:	e8 db 01 00 00       	call   3bf0 <fwp_rc_free_arr>
    3a15:	4c 8b 73 38          	mov    0x38(%rbx),%r14
    3a19:	4c 89 f7             	mov    %r14,%rdi
    3a1c:	e8 9f 01 00 00       	call   3bc0 <fwp_rc_release_last>
    3a21:	85 c0                	test   %eax,%eax
    3a23:	74 38                	je     3a5d <main+0x24d>
    3a25:	4c 89 f7             	mov    %r14,%rdi
    3a28:	e8 c3 01 00 00       	call   3bf0 <fwp_rc_free_arr>
    3a2d:	4c 8b 73 40          	mov    0x40(%rbx),%r14
    3a31:	4c 89 f7             	mov    %r14,%rdi
    3a34:	e8 87 01 00 00       	call   3bc0 <fwp_rc_release_last>
    3a39:	85 c0                	test   %eax,%eax
    3a3b:	b8 7d 00 00 00       	mov    $0x7d,%eax
    3a40:	74 20                	je     3a62 <main+0x252>
    3a42:	4c 89 f7             	mov    %r14,%rdi
    3a45:	e8 a6 01 00 00       	call   3bf0 <fwp_rc_free_arr>
    3a4a:	48 89 df             	mov    %rbx,%rdi
    3a4d:	e8 3e 02 00 00       	call   3c90 <fwp_rc_free_obj>
    3a52:	31 c0                	xor    %eax,%eax
    3a54:	eb 0c                	jmp    3a62 <main+0x252>
    3a56:	b8 7c 00 00 00       	mov    $0x7c,%eax
    3a5b:	eb 05                	jmp    3a62 <main+0x252>
    3a5d:	b8 7d 00 00 00       	mov    $0x7d,%eax
    3a62:	48 83 c4 08          	add    $0x8,%rsp
    3a66:	5b                   	pop    %rbx
    3a67:	41 5c                	pop    %r12
    3a69:	41 5d                	pop    %r13
    3a6b:	41 5e                	pop    %r14
    3a6d:	41 5f                	pop    %r15
    3a6f:	5d                   	pop    %rbp
    3a70:	c3                   	ret
    3a71:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3a78:	0f 1f 84 00 00 00 00 
    3a7f:	00 

0000000000003a80 <fwp_gc_start>:
    3a80:	53                   	push   %rbx
    3a81:	48 89 fb             	mov    %rdi,%rbx
    3a84:	83 3d f9 17 01 00 00 	cmpl   $0x0,0x117f9(%rip)        # 15284 <fwp_gc+0xfec>
    3a8b:	75 05                	jne    3a92 <fwp_gc_start+0x12>
    3a8d:	e8 9e 0b 00 00       	call   4630 <fwp_gc_init>
    3a92:	48 89 1d 87 18 01 00 	mov    %rbx,0x11887(%rip)        # 15320 <fwp_gc+0x1088>
    3a99:	48 8d 3d 40 99 00 00 	lea    0x9940(%rip),%rdi        # d3e0 <fwp_gc_find_data>
    3aa0:	31 f6                	xor    %esi,%esi
    3aa2:	e8 99 f5 ff ff       	call   3040 <dl_iterate_phdr@plt>
    3aa7:	83 3d da 17 01 00 00 	cmpl   $0x0,0x117da(%rip)        # 15288 <fwp_gc+0xff0>
    3aae:	0f 95 c1             	setne  %cl
    3ab1:	83 3d 70 19 01 00 00 	cmpl   $0x0,0x11970(%rip)        # 15428 <fwp_gc+0x1190>
    3ab8:	0f 9f c0             	setg   %al
    3abb:	20 c8                	and    %cl,%al
    3abd:	0f b6 c8             	movzbl %al,%ecx
    3ac0:	89 0d c6 17 01 00    	mov    %ecx,0x117c6(%rip)        # 1528c <fwp_gc+0xff4>
    3ac6:	83 3d c7 17 01 00 00 	cmpl   $0x0,0x117c7(%rip)        # 15294 <fwp_gc+0xffc>
    3acd:	74 16                	je     3ae5 <fwp_gc_start+0x65>
    3acf:	48 8d 3d ea 99 00 00 	lea    0x99ea(%rip),%rdi        # d4c0 <fwp_gc_report>
    3ad6:	e8 d5 a4 00 00       	call   dfb0 <atexit>
    3adb:	83 3d aa 17 01 00 00 	cmpl   $0x0,0x117aa(%rip)        # 1528c <fwp_gc+0xff4>
    3ae2:	0f 95 c0             	setne  %al
    3ae5:	84 c0                	test   %al,%al
    3ae7:	74 43                	je     3b2c <fwp_gc_start+0xac>
    3ae9:	48 83 3d c7 17 01 00 	cmpq   $0x0,0x117c7(%rip)        # 152b8 <fwp_gc+0x1020>
    3af0:	00 
    3af1:	74 39                	je     3b2c <fwp_gc_start+0xac>
    3af3:	48 8b 05 ae 19 01 00 	mov    0x119ae(%rip),%rax        # 154a8 <fwp_gc+0x1210>
    3afa:	48 2b 05 97 07 01 00 	sub    0x10797(%rip),%rax        # 14298 <fwp_gc>
    3b01:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    3b06:	f2 0f 58 05 72 19 01 	addsd  0x11972(%rip),%xmm0        # 15480 <fwp_gc+0x11e8>
    3b0d:	00 
    3b0e:	f2 0f 11 05 6a 19 01 	movsd  %xmm0,0x1196a(%rip)        # 15480 <fwp_gc+0x11e8>
    3b15:	00 
    3b16:	48 c7 05 87 19 01 00 	movq   $0x0,0x11987(%rip)        # 154a8 <fwp_gc+0x1210>
    3b1d:	00 00 00 00 
    3b21:	48 c7 05 6c 07 01 00 	movq   $0x0,0x1076c(%rip)        # 14298 <fwp_gc>
    3b28:	00 00 00 00 
    3b2c:	5b                   	pop    %rbx
    3b2d:	c3                   	ret
    3b2e:	66 90                	xchg   %ax,%ax

0000000000003b30 <f0>:
    3b30:	41 56                	push   %r14
    3b32:	53                   	push   %rbx
    3b33:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    3b3a:	48 89 fe             	mov    %rdi,%rsi
    3b3d:	48 8d 5c 24 40       	lea    0x40(%rsp),%rbx
    3b42:	48 89 df             	mov    %rbx,%rdi
    3b45:	e8 b6 9b 00 00       	call   d700 <w0>
    3b4a:	0f 28 44 24 40       	movaps 0x40(%rsp),%xmm0
    3b4f:	0f 28 4c 24 50       	movaps 0x50(%rsp),%xmm1
    3b54:	0f 28 54 24 60       	movaps 0x60(%rsp),%xmm2
    3b59:	0f 28 5c 24 70       	movaps 0x70(%rsp),%xmm3
    3b5e:	0f 29 04 24          	movaps %xmm0,(%rsp)
    3b62:	0f 29 4c 24 10       	movaps %xmm1,0x10(%rsp)
    3b67:	0f 29 54 24 20       	movaps %xmm2,0x20(%rsp)
    3b6c:	0f 29 5c 24 30       	movaps %xmm3,0x30(%rsp)
    3b71:	48 8d 35 98 9e 00 00 	lea    0x9e98(%rip),%rsi        # da10 <fwp_owner_release7>
    3b78:	4c 8d b4 24 80 00 00 	lea    0x80(%rsp),%r14
    3b7f:	00 
    3b80:	48 89 e2             	mov    %rsp,%rdx
    3b83:	4c 89 f7             	mov    %r14,%rdi
    3b86:	e8 65 9e 00 00       	call   d9f0 <fwp_cleanup_push>
    3b8b:	bf 08 00 00 00       	mov    $0x8,%edi
    3b90:	48 89 de             	mov    %rbx,%rsi
    3b93:	e8 c8 06 00 00       	call   4260 <fwp_record>
    3b98:	48 89 c3             	mov    %rax,%rbx
    3b9b:	48 89 c7             	mov    %rax,%rdi
    3b9e:	e8 7d 06 00 00       	call   4220 <fwp_rc_fresh>
    3ba3:	4c 89 f7             	mov    %r14,%rdi
    3ba6:	e8 b5 9e 00 00       	call   da60 <fwp_cleanup_pop>
    3bab:	48 89 d8             	mov    %rbx,%rax
    3bae:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    3bb5:	5b                   	pop    %rbx
    3bb6:	41 5e                	pop    %r14
    3bb8:	c3                   	ret
    3bb9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000003bc0 <fwp_rc_release_last>:
    3bc0:	50                   	push   %rax
    3bc1:	e8 3a 04 00 00       	call   4000 <fwp_rc_slot>
    3bc6:	48 89 c7             	mov    %rax,%rdi
    3bc9:	31 c0                	xor    %eax,%eax
    3bcb:	48 85 ff             	test   %rdi,%rdi
    3bce:	74 1a                	je     3bea <fwp_rc_release_last+0x2a>
    3bd0:	0f b6 07             	movzbl (%rdi),%eax
    3bd3:	85 c0                	test   %eax,%eax
    3bd5:	74 13                	je     3bea <fwp_rc_release_last+0x2a>
    3bd7:	83 f8 01             	cmp    $0x1,%eax
    3bda:	75 07                	jne    3be3 <fwp_rc_release_last+0x23>
    3bdc:	b8 01 00 00 00       	mov    $0x1,%eax
    3be1:	59                   	pop    %rcx
    3be2:	c3                   	ret
    3be3:	e8 e8 a0 00 00       	call   dcd0 <fwp_rc_drop_slot>
    3be8:	31 c0                	xor    %eax,%eax
    3bea:	59                   	pop    %rcx
    3beb:	c3                   	ret
    3bec:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000003bf0 <fwp_rc_free_arr>:
    3bf0:	41 56                	push   %r14
    3bf2:	53                   	push   %rbx
    3bf3:	50                   	push   %rax
    3bf4:	48 89 fb             	mov    %rdi,%rbx
    3bf7:	e8 24 a1 00 00       	call   dd20 <fwp_rc_last>
    3bfc:	85 c0                	test   %eax,%eax
    3bfe:	74 7d                	je     3c7d <fwp_rc_free_arr+0x8d>
    3c00:	8b 0d 82 27 01 00    	mov    0x12782(%rip),%ecx        # 16388 <fwp_reuse_verify>
    3c06:	85 c9                	test   %ecx,%ecx
    3c08:	78 0d                	js     3c17 <fwp_rc_free_arr+0x27>
    3c0a:	85 c9                	test   %ecx,%ecx
    3c0c:	74 41                	je     3c4f <fwp_rc_free_arr+0x5f>
    3c0e:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    3c15:	eb 66                	jmp    3c7d <fwp_rc_free_arr+0x8d>
    3c17:	48 8d 3d 82 ba 00 00 	lea    0xba82(%rip),%rdi        # f6a0 <exec_in_fp0+0xfa0>
    3c1e:	e8 0d f4 ff ff       	call   3030 <getenv@plt>
    3c23:	31 c9                	xor    %ecx,%ecx
    3c25:	48 85 c0             	test   %rax,%rax
    3c28:	74 1b                	je     3c45 <fwp_rc_free_arr+0x55>
    3c2a:	80 38 00             	cmpb   $0x0,(%rax)
    3c2d:	74 16                	je     3c45 <fwp_rc_free_arr+0x55>
    3c2f:	48 8d 35 67 b8 00 00 	lea    0xb867(%rip),%rsi        # f49d <exec_in_fp0+0xd9d>
    3c36:	48 89 c7             	mov    %rax,%rdi
    3c39:	e8 92 f6 ff ff       	call   32d0 <strcmp@plt>
    3c3e:	31 c9                	xor    %ecx,%ecx
    3c40:	85 c0                	test   %eax,%eax
    3c42:	0f 95 c1             	setne  %cl
    3c45:	89 0d 3d 27 01 00    	mov    %ecx,0x1273d(%rip)        # 16388 <fwp_reuse_verify>
    3c4b:	85 c9                	test   %ecx,%ecx
    3c4d:	75 bf                	jne    3c0e <fwp_rc_free_arr+0x1e>
    3c4f:	4c 8b 35 42 06 01 00 	mov    0x10642(%rip),%r14        # 14298 <fwp_gc>
    3c56:	48 89 df             	mov    %rbx,%rdi
    3c59:	e8 72 42 00 00       	call   7ed0 <fwp_mem_free>
    3c5e:	48 8b 05 33 06 01 00 	mov    0x10633(%rip),%rax        # 14298 <fwp_gc>
    3c65:	4c 29 f0             	sub    %r14,%rax
    3c68:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    3c6d:	f2 0f 58 05 2b 18 01 	addsd  0x1182b(%rip),%xmm0        # 154a0 <fwp_gc+0x1208>
    3c74:	00 
    3c75:	f2 0f 11 05 23 18 01 	movsd  %xmm0,0x11823(%rip)        # 154a0 <fwp_gc+0x1208>
    3c7c:	00 
    3c7d:	48 83 c4 08          	add    $0x8,%rsp
    3c81:	5b                   	pop    %rbx
    3c82:	41 5e                	pop    %r14
    3c84:	c3                   	ret
    3c85:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    3c8c:	00 00 00 00 

0000000000003c90 <fwp_rc_free_obj>:
    3c90:	41 56                	push   %r14
    3c92:	53                   	push   %rbx
    3c93:	50                   	push   %rax
    3c94:	48 89 fb             	mov    %rdi,%rbx
    3c97:	e8 84 a0 00 00       	call   dd20 <fwp_rc_last>
    3c9c:	85 c0                	test   %eax,%eax
    3c9e:	0f 84 83 00 00 00    	je     3d27 <fwp_rc_free_obj+0x97>
    3ca4:	8b 0d de 26 01 00    	mov    0x126de(%rip),%ecx        # 16388 <fwp_reuse_verify>
    3caa:	85 c9                	test   %ecx,%ecx
    3cac:	78 13                	js     3cc1 <fwp_rc_free_obj+0x31>
    3cae:	85 c9                	test   %ecx,%ecx
    3cb0:	74 47                	je     3cf9 <fwp_rc_free_obj+0x69>
    3cb2:	48 89 df             	mov    %rbx,%rdi
    3cb5:	48 83 c4 08          	add    $0x8,%rsp
    3cb9:	5b                   	pop    %rbx
    3cba:	41 5e                	pop    %r14
    3cbc:	e9 7f a0 00 00       	jmp    dd40 <fwp_rc_poison>
    3cc1:	48 8d 3d d8 b9 00 00 	lea    0xb9d8(%rip),%rdi        # f6a0 <exec_in_fp0+0xfa0>
    3cc8:	e8 63 f3 ff ff       	call   3030 <getenv@plt>
    3ccd:	31 c9                	xor    %ecx,%ecx
    3ccf:	48 85 c0             	test   %rax,%rax
    3cd2:	74 1b                	je     3cef <fwp_rc_free_obj+0x5f>
    3cd4:	80 38 00             	cmpb   $0x0,(%rax)
    3cd7:	74 16                	je     3cef <fwp_rc_free_obj+0x5f>
    3cd9:	48 8d 35 bd b7 00 00 	lea    0xb7bd(%rip),%rsi        # f49d <exec_in_fp0+0xd9d>
    3ce0:	48 89 c7             	mov    %rax,%rdi
    3ce3:	e8 e8 f5 ff ff       	call   32d0 <strcmp@plt>
    3ce8:	31 c9                	xor    %ecx,%ecx
    3cea:	85 c0                	test   %eax,%eax
    3cec:	0f 95 c1             	setne  %cl
    3cef:	89 0d 93 26 01 00    	mov    %ecx,0x12693(%rip)        # 16388 <fwp_reuse_verify>
    3cf5:	85 c9                	test   %ecx,%ecx
    3cf7:	75 b9                	jne    3cb2 <fwp_rc_free_obj+0x22>
    3cf9:	4c 8b 35 98 05 01 00 	mov    0x10598(%rip),%r14        # 14298 <fwp_gc>
    3d00:	48 89 df             	mov    %rbx,%rdi
    3d03:	e8 c8 41 00 00       	call   7ed0 <fwp_mem_free>
    3d08:	48 8b 05 89 05 01 00 	mov    0x10589(%rip),%rax        # 14298 <fwp_gc>
    3d0f:	4c 29 f0             	sub    %r14,%rax
    3d12:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    3d17:	f2 0f 58 05 81 17 01 	addsd  0x11781(%rip),%xmm0        # 154a0 <fwp_gc+0x1208>
    3d1e:	00 
    3d1f:	f2 0f 11 05 79 17 01 	movsd  %xmm0,0x11779(%rip)        # 154a0 <fwp_gc+0x1208>
    3d26:	00 
    3d27:	48 83 c4 08          	add    $0x8,%rsp
    3d2b:	5b                   	pop    %rbx
    3d2c:	41 5e                	pop    %r14
    3d2e:	c3                   	ret
    3d2f:	90                   	nop

0000000000003d30 <e0>:
    3d30:	50                   	push   %rax
    3d31:	48 8b 3f             	mov    (%rdi),%rdi
    3d34:	e8 f7 fd ff ff       	call   3b30 <f0>
    3d39:	48 89 c7             	mov    %rax,%rdi
    3d3c:	58                   	pop    %rax
    3d3d:	e9 8e 01 00 00       	jmp    3ed0 <fwp_rc_shared>
    3d42:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3d49:	1f 84 00 00 00 00 00 

0000000000003d50 <e1>:
    3d50:	50                   	push   %rax
    3d51:	48 8b 3f             	mov    (%rdi),%rdi
    3d54:	e8 47 04 00 00       	call   41a0 <f1>
    3d59:	48 89 c7             	mov    %rax,%rdi
    3d5c:	58                   	pop    %rax
    3d5d:	e9 6e 01 00 00       	jmp    3ed0 <fwp_rc_shared>
    3d62:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3d69:	1f 84 00 00 00 00 00 

0000000000003d70 <e2>:
    3d70:	50                   	push   %rax
    3d71:	48 8b 3f             	mov    (%rdi),%rdi
    3d74:	e8 f7 23 00 00       	call   6170 <f2>
    3d79:	48 89 c7             	mov    %rax,%rdi
    3d7c:	58                   	pop    %rax
    3d7d:	e9 4e 01 00 00       	jmp    3ed0 <fwp_rc_shared>
    3d82:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3d89:	1f 84 00 00 00 00 00 

0000000000003d90 <e4>:
    3d90:	50                   	push   %rax
    3d91:	48 8b 07             	mov    (%rdi),%rax
    3d94:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    3d98:	48 89 c7             	mov    %rax,%rdi
    3d9b:	e8 d0 04 00 00       	call   4270 <f4>
    3da0:	48 89 c7             	mov    %rax,%rdi
    3da3:	58                   	pop    %rax
    3da4:	e9 27 01 00 00       	jmp    3ed0 <fwp_rc_shared>
    3da9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000003db0 <e8>:
    3db0:	50                   	push   %rax
    3db1:	48 8b 3f             	mov    (%rdi),%rdi
    3db4:	e8 e7 04 00 00       	call   42a0 <f8>
    3db9:	48 89 c7             	mov    %rax,%rdi
    3dbc:	58                   	pop    %rax
    3dbd:	e9 0e 01 00 00       	jmp    3ed0 <fwp_rc_shared>
    3dc2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3dc9:	1f 84 00 00 00 00 00 

0000000000003dd0 <e10>:
    3dd0:	50                   	push   %rax
    3dd1:	48 8b 07             	mov    (%rdi),%rax
    3dd4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    3dd8:	48 89 c7             	mov    %rax,%rdi
    3ddb:	e8 b0 23 00 00       	call   6190 <f10>
    3de0:	48 89 c7             	mov    %rax,%rdi
    3de3:	58                   	pop    %rax
    3de4:	e9 e7 00 00 00       	jmp    3ed0 <fwp_rc_shared>
    3de9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000003df0 <e12>:
    3df0:	50                   	push   %rax
    3df1:	48 8b 07             	mov    (%rdi),%rax
    3df4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    3df8:	48 89 c7             	mov    %rax,%rdi
    3dfb:	e8 a0 24 00 00       	call   62a0 <f12>
    3e00:	48 89 c7             	mov    %rax,%rdi
    3e03:	58                   	pop    %rax
    3e04:	e9 c7 00 00 00       	jmp    3ed0 <fwp_rc_shared>
    3e09:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000003e10 <e14>:
    3e10:	50                   	push   %rax
    3e11:	48 8b 07             	mov    (%rdi),%rax
    3e14:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    3e18:	48 89 c7             	mov    %rax,%rdi
    3e1b:	e8 90 24 00 00       	call   62b0 <f14>
    3e20:	48 89 c7             	mov    %rax,%rdi
    3e23:	58                   	pop    %rax
    3e24:	e9 a7 00 00 00       	jmp    3ed0 <fwp_rc_shared>
    3e29:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000003e30 <e16>:
    3e30:	50                   	push   %rax
    3e31:	48 8b 07             	mov    (%rdi),%rax
    3e34:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    3e38:	48 89 c7             	mov    %rax,%rdi
    3e3b:	e8 80 24 00 00       	call   62c0 <f16>
    3e40:	48 89 c7             	mov    %rax,%rdi
    3e43:	58                   	pop    %rax
    3e44:	e9 87 00 00 00       	jmp    3ed0 <fwp_rc_shared>
    3e49:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000003e50 <e18>:
    3e50:	50                   	push   %rax
    3e51:	48 8b 07             	mov    (%rdi),%rax
    3e54:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    3e58:	48 89 c7             	mov    %rax,%rdi
    3e5b:	e8 70 24 00 00       	call   62d0 <f18>
    3e60:	48 89 c7             	mov    %rax,%rdi
    3e63:	58                   	pop    %rax
    3e64:	eb 6a                	jmp    3ed0 <fwp_rc_shared>
    3e66:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    3e6d:	00 00 00 

0000000000003e70 <e20>:
    3e70:	50                   	push   %rax
    3e71:	48 8b 07             	mov    (%rdi),%rax
    3e74:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    3e78:	48 89 c7             	mov    %rax,%rdi
    3e7b:	e8 60 24 00 00       	call   62e0 <f20>
    3e80:	48 89 c7             	mov    %rax,%rdi
    3e83:	58                   	pop    %rax
    3e84:	eb 4a                	jmp    3ed0 <fwp_rc_shared>
    3e86:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    3e8d:	00 00 00 

0000000000003e90 <e22>:
    3e90:	50                   	push   %rax
    3e91:	48 8b 07             	mov    (%rdi),%rax
    3e94:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    3e98:	48 89 c7             	mov    %rax,%rdi
    3e9b:	e8 50 24 00 00       	call   62f0 <f22>
    3ea0:	48 89 c7             	mov    %rax,%rdi
    3ea3:	58                   	pop    %rax
    3ea4:	eb 2a                	jmp    3ed0 <fwp_rc_shared>
    3ea6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    3ead:	00 00 00 

0000000000003eb0 <e24>:
    3eb0:	50                   	push   %rax
    3eb1:	48 8b 07             	mov    (%rdi),%rax
    3eb4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    3eb8:	48 89 c7             	mov    %rax,%rdi
    3ebb:	e8 40 24 00 00       	call   6300 <f24>
    3ec0:	48 89 c7             	mov    %rax,%rdi
    3ec3:	58                   	pop    %rax
    3ec4:	eb 0a                	jmp    3ed0 <fwp_rc_shared>
    3ec6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    3ecd:	00 00 00 

0000000000003ed0 <fwp_rc_shared>:
    3ed0:	53                   	push   %rbx
    3ed1:	48 89 fb             	mov    %rdi,%rbx
    3ed4:	e8 07 00 00 00       	call   3ee0 <fwp_rc_share>
    3ed9:	48 89 d8             	mov    %rbx,%rax
    3edc:	5b                   	pop    %rbx
    3edd:	c3                   	ret
    3ede:	66 90                	xchg   %ax,%ax

0000000000003ee0 <fwp_rc_share>:
    3ee0:	41 57                	push   %r15
    3ee2:	41 56                	push   %r14
    3ee4:	41 55                	push   %r13
    3ee6:	41 54                	push   %r12
    3ee8:	53                   	push   %rbx
    3ee9:	48 81 ec 00 02 00 00 	sub    $0x200,%rsp
    3ef0:	48 89 fb             	mov    %rdi,%rbx
    3ef3:	e8 08 01 00 00       	call   4000 <fwp_rc_slot>
    3ef8:	48 85 c0             	test   %rax,%rax
    3efb:	0f 84 ec 00 00 00    	je     3fed <fwp_rc_share+0x10d>
    3f01:	80 38 00             	cmpb   $0x0,(%rax)
    3f04:	0f 84 e3 00 00 00    	je     3fed <fwp_rc_share+0x10d>
    3f0a:	48 89 c7             	mov    %rax,%rdi
    3f0d:	e8 5e 01 00 00       	call   4070 <fwp_rc_clear_slot>
    3f12:	48 89 1c 24          	mov    %rbx,(%rsp)
    3f16:	41 be 01 00 00 00    	mov    $0x1,%r14d
    3f1c:	eb 0b                	jmp    3f29 <fwp_rc_share+0x49>
    3f1e:	66 90                	xchg   %ax,%ax
    3f20:	4d 85 f6             	test   %r14,%r14
    3f23:	0f 84 c4 00 00 00    	je     3fed <fwp_rc_share+0x10d>
    3f29:	4e 8b 7c f4 f8       	mov    -0x8(%rsp,%r14,8),%r15
    3f2e:	49 ff ce             	dec    %r14
    3f31:	4c 89 ff             	mov    %r15,%rdi
    3f34:	48 2b 3d 8d 13 01 00 	sub    0x1138d(%rip),%rdi        # 152c8 <fwp_gc+0x1030>
    3f3b:	48 c1 ef 10          	shr    $0x10,%rdi
    3f3f:	48 8b 05 ca 13 01 00 	mov    0x113ca(%rip),%rax        # 15310 <fwp_gc+0x1078>
    3f46:	48 69 cf 28 12 00 00 	imul   $0x1228,%rdi,%rcx
    3f4d:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    3f52:	74 cc                	je     3f20 <fwp_rc_share+0x40>
    3f54:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    3f58:	80 fa 02             	cmp    $0x2,%dl
    3f5b:	75 13                	jne    3f70 <fwp_rc_share+0x90>
    3f5d:	4c 8b 64 08 18       	mov    0x18(%rax,%rcx,1),%r12
    3f62:	eb 33                	jmp    3f97 <fwp_rc_share+0xb7>
    3f64:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    3f6b:	00 00 00 00 00 
    3f70:	44 8b 64 08 08       	mov    0x8(%rax,%rcx,1),%r12d
    3f75:	80 fa 01             	cmp    $0x1,%dl
    3f78:	75 1d                	jne    3f97 <fwp_rc_share+0xb7>
    3f7a:	41 0f b7 d7          	movzwl %r15w,%edx
    3f7e:	44 8b 7c 08 20       	mov    0x20(%rax,%rcx,1),%r15d
    3f83:	4c 0f af fa          	imul   %rdx,%r15
    3f87:	49 c1 ef 20          	shr    $0x20,%r15
    3f8b:	e8 00 01 00 00       	call   4090 <fwp_gc_chunk_addr>
    3f90:	4d 0f af fc          	imul   %r12,%r15
    3f94:	49 01 c7             	add    %rax,%r15
    3f97:	49 83 fc 08          	cmp    $0x8,%r12
    3f9b:	72 83                	jb     3f20 <fwp_rc_share+0x40>
    3f9d:	49 c1 ec 03          	shr    $0x3,%r12
    3fa1:	45 31 ed             	xor    %r13d,%r13d
    3fa4:	eb 16                	jmp    3fbc <fwp_rc_share+0xdc>
    3fa6:	48 89 df             	mov    %rbx,%rdi
    3fa9:	e8 32 ff ff ff       	call   3ee0 <fwp_rc_share>
    3fae:	66 90                	xchg   %ax,%ax
    3fb0:	49 ff c5             	inc    %r13
    3fb3:	4d 39 ec             	cmp    %r13,%r12
    3fb6:	0f 84 64 ff ff ff    	je     3f20 <fwp_rc_share+0x40>
    3fbc:	4b 8b 1c ef          	mov    (%r15,%r13,8),%rbx
    3fc0:	48 89 df             	mov    %rbx,%rdi
    3fc3:	e8 38 00 00 00       	call   4000 <fwp_rc_slot>
    3fc8:	48 85 c0             	test   %rax,%rax
    3fcb:	74 e3                	je     3fb0 <fwp_rc_share+0xd0>
    3fcd:	80 38 00             	cmpb   $0x0,(%rax)
    3fd0:	74 de                	je     3fb0 <fwp_rc_share+0xd0>
    3fd2:	49 83 fe 3f          	cmp    $0x3f,%r14
    3fd6:	77 ce                	ja     3fa6 <fwp_rc_share+0xc6>
    3fd8:	48 89 c7             	mov    %rax,%rdi
    3fdb:	e8 90 00 00 00       	call   4070 <fwp_rc_clear_slot>
    3fe0:	4b 8b 04 ef          	mov    (%r15,%r13,8),%rax
    3fe4:	4a 89 04 f4          	mov    %rax,(%rsp,%r14,8)
    3fe8:	49 ff c6             	inc    %r14
    3feb:	eb c3                	jmp    3fb0 <fwp_rc_share+0xd0>
    3fed:	48 81 c4 00 02 00 00 	add    $0x200,%rsp
    3ff4:	5b                   	pop    %rbx
    3ff5:	41 5c                	pop    %r12
    3ff7:	41 5d                	pop    %r13
    3ff9:	41 5e                	pop    %r14
    3ffb:	41 5f                	pop    %r15
    3ffd:	c3                   	ret
    3ffe:	66 90                	xchg   %ax,%ax

0000000000004000 <fwp_rc_slot>:
    4000:	48 2b 3d c1 12 01 00 	sub    0x112c1(%rip),%rdi        # 152c8 <fwp_gc+0x1030>
    4007:	48 8b 05 e2 12 01 00 	mov    0x112e2(%rip),%rax        # 152f0 <fwp_gc+0x1058>
    400e:	48 c1 e0 10          	shl    $0x10,%rax
    4012:	48 39 c7             	cmp    %rax,%rdi
    4015:	73 51                	jae    4068 <fwp_rc_slot+0x68>
    4017:	48 8b 05 f2 12 01 00 	mov    0x112f2(%rip),%rax        # 15310 <fwp_gc+0x1078>
    401e:	48 89 f9             	mov    %rdi,%rcx
    4021:	48 c1 e9 10          	shr    $0x10,%rcx
    4025:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    402c:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    4030:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    4037:	75 0f                	jne    4048 <fwp_rc_slot+0x48>
    4039:	80 fa 02             	cmp    $0x2,%dl
    403c:	75 0a                	jne    4048 <fwp_rc_slot+0x48>
    403e:	48 01 c8             	add    %rcx,%rax
    4041:	48 05 28 02 00 00    	add    $0x228,%rax
    4047:	c3                   	ret
    4048:	80 fa 01             	cmp    $0x1,%dl
    404b:	75 1b                	jne    4068 <fwp_rc_slot+0x68>
    404d:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    4051:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    4055:	48 0f af f8          	imul   %rax,%rdi
    4059:	48 c1 ef 20          	shr    $0x20,%rdi
    405d:	48 8d 04 17          	lea    (%rdi,%rdx,1),%rax
    4061:	48 05 28 02 00 00    	add    $0x228,%rax
    4067:	c3                   	ret
    4068:	31 c0                	xor    %eax,%eax
    406a:	c3                   	ret
    406b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000004070 <fwp_rc_clear_slot>:
    4070:	80 3f ff             	cmpb   $0xff,(%rdi)
    4073:	74 04                	je     4079 <fwp_rc_clear_slot+0x9>
    4075:	c6 07 00             	movb   $0x0,(%rdi)
    4078:	c3                   	ret
    4079:	53                   	push   %rbx
    407a:	48 89 fb             	mov    %rdi,%rbx
    407d:	e8 1e 00 00 00       	call   40a0 <fwp_rc_forget_slot>
    4082:	48 89 df             	mov    %rbx,%rdi
    4085:	5b                   	pop    %rbx
    4086:	c6 07 00             	movb   $0x0,(%rdi)
    4089:	c3                   	ret
    408a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000004090 <fwp_gc_chunk_addr>:
    4090:	48 89 f8             	mov    %rdi,%rax
    4093:	48 c1 e0 10          	shl    $0x10,%rax
    4097:	48 03 05 2a 12 01 00 	add    0x1122a(%rip),%rax        # 152c8 <fwp_gc+0x1030>
    409e:	c3                   	ret
    409f:	90                   	nop

00000000000040a0 <fwp_rc_forget_slot>:
    40a0:	50                   	push   %rax
    40a1:	80 3f ff             	cmpb   $0xff,(%rdi)
    40a4:	74 02                	je     40a8 <fwp_rc_forget_slot+0x8>
    40a6:	58                   	pop    %rax
    40a7:	c3                   	ret
    40a8:	e8 33 00 00 00       	call   40e0 <fwp_rc_wide_link>
    40ad:	48 8b 38             	mov    (%rax),%rdi
    40b0:	48 85 ff             	test   %rdi,%rdi
    40b3:	74 15                	je     40ca <fwp_rc_forget_slot+0x2a>
    40b5:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    40b9:	48 89 08             	mov    %rcx,(%rax)
    40bc:	e8 8f ef ff ff       	call   3050 <free@plt>
    40c1:	48 ff 0d e8 1b 01 00 	decq   0x11be8(%rip)        # 15cb0 <fwp_gc+0x1a18>
    40c8:	58                   	pop    %rax
    40c9:	c3                   	ret
    40ca:	48 8d 3d 93 a7 00 00 	lea    0xa793(%rip),%rdi        # e864 <exec_in_fp0+0x164>
    40d1:	e8 6a 00 00 00       	call   4140 <fwp_trap>
    40d6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    40dd:	00 00 00 

00000000000040e0 <fwp_rc_wide_link>:
    40e0:	48 89 f8             	mov    %rdi,%rax
    40e3:	48 c1 e8 11          	shr    $0x11,%rax
    40e7:	31 f8                	xor    %edi,%eax
    40e9:	89 c1                	mov    %eax,%ecx
    40eb:	c1 e9 09             	shr    $0x9,%ecx
    40ee:	31 c1                	xor    %eax,%ecx
    40f0:	0f b6 c9             	movzbl %cl,%ecx
    40f3:	48 8d 15 9e 01 01 00 	lea    0x1019e(%rip),%rdx        # 14298 <fwp_gc>
    40fa:	48 8d 04 ca          	lea    (%rdx,%rcx,8),%rax
    40fe:	48 05 18 12 00 00    	add    $0x1218,%rax
    4104:	48 8b 8c ca 18 12 00 	mov    0x1218(%rdx,%rcx,8),%rcx
    410b:	00 
    410c:	48 85 c9             	test   %rcx,%rcx
    410f:	74 24                	je     4135 <fwp_rc_wide_link+0x55>
    4111:	48 39 39             	cmp    %rdi,(%rcx)
    4114:	74 1f                	je     4135 <fwp_rc_wide_link+0x55>
    4116:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    411d:	00 00 00 
    4120:	48 89 c8             	mov    %rcx,%rax
    4123:	48 8b 49 10          	mov    0x10(%rcx),%rcx
    4127:	48 85 c9             	test   %rcx,%rcx
    412a:	74 05                	je     4131 <fwp_rc_wide_link+0x51>
    412c:	48 39 39             	cmp    %rdi,(%rcx)
    412f:	75 ef                	jne    4120 <fwp_rc_wide_link+0x40>
    4131:	48 83 c0 10          	add    $0x10,%rax
    4135:	c3                   	ret
    4136:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    413d:	00 00 00 

0000000000004140 <fwp_trap>:
    4140:	53                   	push   %rbx
    4141:	48 89 fb             	mov    %rdi,%rbx
    4144:	e8 27 00 00 00       	call   4170 <fwp_flush>
    4149:	48 8b 05 88 fe 00 00 	mov    0xfe88(%rip),%rax        # 13fd8 <stderr@GLIBC_2.2.5>
    4150:	48 8b 38             	mov    (%rax),%rdi
    4153:	48 8d 35 31 a7 00 00 	lea    0xa731(%rip),%rsi        # e88b <exec_in_fp0+0x18b>
    415a:	48 89 da             	mov    %rbx,%rdx
    415d:	31 c0                	xor    %eax,%eax
    415f:	e8 8c f1 ff ff       	call   32f0 <fprintf@plt>
    4164:	bf 65 00 00 00       	mov    $0x65,%edi
    4169:	e8 12 f3 ff ff       	call   3480 <exit@plt>
    416e:	66 90                	xchg   %ax,%ax

0000000000004170 <fwp_flush>:
    4170:	50                   	push   %rax
    4171:	48 8b 3d 30 22 01 00 	mov    0x12230(%rip),%rdi        # 163a8 <fwp_prog_out>
    4178:	48 85 ff             	test   %rdi,%rdi
    417b:	74 05                	je     4182 <fwp_flush+0x12>
    417d:	e8 ce f1 ff ff       	call   3350 <fflush@plt>
    4182:	48 8b 05 27 fe 00 00 	mov    0xfe27(%rip),%rax        # 13fb0 <stdout@GLIBC_2.2.5>
    4189:	48 8b 38             	mov    (%rax),%rdi
    418c:	58                   	pop    %rax
    418d:	e9 be f1 ff ff       	jmp    3350 <fflush@plt>
    4192:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4199:	1f 84 00 00 00 00 00 

00000000000041a0 <f1>:
    41a0:	53                   	push   %rbx
    41a1:	48 83 ec 20          	sub    $0x20,%rsp
    41a5:	48 89 fe             	mov    %rdi,%rsi
    41a8:	48 8d 5c 24 08       	lea    0x8(%rsp),%rbx
    41ad:	48 89 df             	mov    %rbx,%rdi
    41b0:	e8 2b 00 00 00       	call   41e0 <w1>
    41b5:	bf 03 00 00 00       	mov    $0x3,%edi
    41ba:	48 89 de             	mov    %rbx,%rsi
    41bd:	e8 9e 00 00 00       	call   4260 <fwp_record>
    41c2:	48 89 c3             	mov    %rax,%rbx
    41c5:	48 89 c7             	mov    %rax,%rdi
    41c8:	e8 53 00 00 00       	call   4220 <fwp_rc_fresh>
    41cd:	48 89 d8             	mov    %rbx,%rax
    41d0:	48 83 c4 20          	add    $0x20,%rsp
    41d4:	5b                   	pop    %rbx
    41d5:	c3                   	ret
    41d6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    41dd:	00 00 00 

00000000000041e0 <w1>:
    41e0:	41 57                	push   %r15
    41e2:	41 56                	push   %r14
    41e4:	53                   	push   %rbx
    41e5:	48 89 f3             	mov    %rsi,%rbx
    41e8:	49 89 fe             	mov    %rdi,%r14
    41eb:	48 bf 00 00 00 00 00 	movabs $0x3fd0000000000000,%rdi
    41f2:	00 d0 3f 
    41f5:	e8 76 00 00 00       	call   4270 <f4>
    41fa:	49 89 c7             	mov    %rax,%r15
    41fd:	48 89 df             	mov    %rbx,%rdi
    4200:	e8 9b 00 00 00       	call   42a0 <f8>
    4205:	49 89 1e             	mov    %rbx,(%r14)
    4208:	4d 89 7e 08          	mov    %r15,0x8(%r14)
    420c:	49 89 46 10          	mov    %rax,0x10(%r14)
    4210:	4c 89 f0             	mov    %r14,%rax
    4213:	5b                   	pop    %rbx
    4214:	41 5e                	pop    %r14
    4216:	41 5f                	pop    %r15
    4218:	c3                   	ret
    4219:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000004220 <fwp_rc_fresh>:
    4220:	41 56                	push   %r14
    4222:	53                   	push   %rbx
    4223:	50                   	push   %rax
    4224:	48 89 fb             	mov    %rdi,%rbx
    4227:	e8 d4 fd ff ff       	call   4000 <fwp_rc_slot>
    422c:	48 85 c0             	test   %rax,%rax
    422f:	74 08                	je     4239 <fwp_rc_fresh+0x19>
    4231:	80 38 ff             	cmpb   $0xff,(%rax)
    4234:	74 0e                	je     4244 <fwp_rc_fresh+0x24>
    4236:	c6 00 01             	movb   $0x1,(%rax)
    4239:	48 89 d8             	mov    %rbx,%rax
    423c:	48 83 c4 08          	add    $0x8,%rsp
    4240:	5b                   	pop    %rbx
    4241:	41 5e                	pop    %r14
    4243:	c3                   	ret
    4244:	48 89 c7             	mov    %rax,%rdi
    4247:	49 89 c6             	mov    %rax,%r14
    424a:	e8 51 fe ff ff       	call   40a0 <fwp_rc_forget_slot>
    424f:	4c 89 f0             	mov    %r14,%rax
    4252:	eb e2                	jmp    4236 <fwp_rc_fresh+0x16>
    4254:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    425b:	00 00 00 00 00 

0000000000004260 <fwp_record>:
    4260:	85 ff                	test   %edi,%edi
    4262:	74 09                	je     426d <fwp_record+0xd>
    4264:	48 89 f2             	mov    %rsi,%rdx
    4267:	89 fe                	mov    %edi,%esi
    4269:	31 ff                	xor    %edi,%edi
    426b:	eb 63                	jmp    42d0 <fwp_data>
    426d:	31 c0                	xor    %eax,%eax
    426f:	c3                   	ret

0000000000004270 <f4>:
    4270:	53                   	push   %rbx
    4271:	48 83 ec 10          	sub    $0x10,%rsp
    4275:	48 89 fb             	mov    %rdi,%rbx
    4278:	48 89 f7             	mov    %rsi,%rdi
    427b:	e8 40 00 00 00       	call   42c0 <fwp_f64>
    4280:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    4286:	48 89 df             	mov    %rbx,%rdi
    4289:	e8 32 00 00 00       	call   42c0 <fwp_f64>
    428e:	f2 0f 58 44 24 08    	addsd  0x8(%rsp),%xmm0
    4294:	48 83 c4 10          	add    $0x10,%rsp
    4298:	5b                   	pop    %rbx
    4299:	eb 15                	jmp    42b0 <fwp_from_f64>
    429b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000042a0 <f8>:
    42a0:	50                   	push   %rax
    42a1:	e8 1a 00 00 00       	call   42c0 <fwp_f64>
    42a6:	0f 57 05 63 9d 00 00 	xorps  0x9d63(%rip),%xmm0        # e010 <_IO_stdin_used+0x10>
    42ad:	58                   	pop    %rax
    42ae:	eb 00                	jmp    42b0 <fwp_from_f64>

00000000000042b0 <fwp_from_f64>:
    42b0:	66 48 0f 7e c0       	movq   %xmm0,%rax
    42b5:	c3                   	ret
    42b6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    42bd:	00 00 00 

00000000000042c0 <fwp_f64>:
    42c0:	66 48 0f 6e c7       	movq   %rdi,%xmm0
    42c5:	c3                   	ret
    42c6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    42cd:	00 00 00 

00000000000042d0 <fwp_data>:
    42d0:	55                   	push   %rbp
    42d1:	41 57                	push   %r15
    42d3:	41 56                	push   %r14
    42d5:	53                   	push   %rbx
    42d6:	50                   	push   %rax
    42d7:	89 fd                	mov    %edi,%ebp
    42d9:	85 f6                	test   %esi,%esi
    42db:	0f 84 a1 00 00 00    	je     4382 <fwp_data+0xb2>
    42e1:	48 89 d3             	mov    %rdx,%rbx
    42e4:	41 89 f6             	mov    %esi,%r14d
    42e7:	4a 8d 3c f5 08 00 00 	lea    0x8(,%r14,8),%rdi
    42ee:	00 
    42ef:	41 89 f7             	mov    %esi,%r15d
    42f2:	e8 d9 00 00 00       	call   43d0 <fwp_alloc_init>
    42f7:	89 28                	mov    %ebp,(%rax)
    42f9:	44 89 78 04          	mov    %r15d,0x4(%rax)
    42fd:	41 83 ff 08          	cmp    $0x8,%r15d
    4301:	72 10                	jb     4313 <fwp_data+0x43>
    4303:	48 89 c1             	mov    %rax,%rcx
    4306:	48 29 d9             	sub    %rbx,%rcx
    4309:	48 83 c1 08          	add    $0x8,%rcx
    430d:	48 83 f9 20          	cmp    $0x20,%rcx
    4311:	73 73                	jae    4386 <fwp_data+0xb6>
    4313:	31 c9                	xor    %ecx,%ecx
    4315:	4c 89 f6             	mov    %r14,%rsi
    4318:	48 89 ca             	mov    %rcx,%rdx
    431b:	48 83 e6 03          	and    $0x3,%rsi
    431f:	74 20                	je     4341 <fwp_data+0x71>
    4321:	48 89 ca             	mov    %rcx,%rdx
    4324:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    432b:	00 00 00 00 00 
    4330:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    4334:	48 89 7c d0 08       	mov    %rdi,0x8(%rax,%rdx,8)
    4339:	48 ff c2             	inc    %rdx
    433c:	48 ff ce             	dec    %rsi
    433f:	75 ef                	jne    4330 <fwp_data+0x60>
    4341:	4c 29 f1             	sub    %r14,%rcx
    4344:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    4348:	77 7b                	ja     43c5 <fwp_data+0xf5>
    434a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    4350:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    4354:	48 89 4c d0 08       	mov    %rcx,0x8(%rax,%rdx,8)
    4359:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    435e:	48 89 4c d0 10       	mov    %rcx,0x10(%rax,%rdx,8)
    4363:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    4368:	48 89 4c d0 18       	mov    %rcx,0x18(%rax,%rdx,8)
    436d:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    4372:	48 89 4c d0 20       	mov    %rcx,0x20(%rax,%rdx,8)
    4377:	48 83 c2 04          	add    $0x4,%rdx
    437b:	49 39 d6             	cmp    %rdx,%r14
    437e:	75 d0                	jne    4350 <fwp_data+0x80>
    4380:	eb 43                	jmp    43c5 <fwp_data+0xf5>
    4382:	89 e8                	mov    %ebp,%eax
    4384:	eb 3f                	jmp    43c5 <fwp_data+0xf5>
    4386:	44 89 f1             	mov    %r14d,%ecx
    4389:	83 e1 fc             	and    $0xfffffffc,%ecx
    438c:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
    4393:	00 
    4394:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    4398:	31 f6                	xor    %esi,%esi
    439a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    43a0:	0f 10 04 33          	movups (%rbx,%rsi,1),%xmm0
    43a4:	0f 10 4c 33 10       	movups 0x10(%rbx,%rsi,1),%xmm1
    43a9:	0f 11 44 30 08       	movups %xmm0,0x8(%rax,%rsi,1)
    43ae:	0f 11 4c 30 18       	movups %xmm1,0x18(%rax,%rsi,1)
    43b3:	48 83 c6 20          	add    $0x20,%rsi
    43b7:	48 39 f2             	cmp    %rsi,%rdx
    43ba:	75 e4                	jne    43a0 <fwp_data+0xd0>
    43bc:	4c 39 f1             	cmp    %r14,%rcx
    43bf:	0f 85 50 ff ff ff    	jne    4315 <fwp_data+0x45>
    43c5:	48 83 c4 08          	add    $0x8,%rsp
    43c9:	5b                   	pop    %rbx
    43ca:	41 5e                	pop    %r14
    43cc:	41 5f                	pop    %r15
    43ce:	5d                   	pop    %rbp
    43cf:	c3                   	ret

00000000000043d0 <fwp_alloc_init>:
    43d0:	53                   	push   %rbx
    43d1:	48 89 fa             	mov    %rdi,%rdx
    43d4:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    43db:	0f 87 a7 00 00 00    	ja     4488 <fwp_alloc_init+0xb8>
    43e1:	48 8d 42 0f          	lea    0xf(%rdx),%rax
    43e5:	48 c1 e8 04          	shr    $0x4,%rax
    43e9:	48 8d 35 a8 fe 00 00 	lea    0xfea8(%rip),%rsi        # 14298 <fwp_gc>
    43f0:	0f b6 bc 30 e8 0b 00 	movzbl 0xbe8(%rax,%rsi,1),%edi
    43f7:	00 
    43f8:	8b 84 be 48 0b 00 00 	mov    0xb48(%rsi,%rdi,4),%eax
    43ff:	48 8b 0d 92 fe 00 00 	mov    0xfe92(%rip),%rcx        # 14298 <fwp_gc>
    4406:	49 89 c8             	mov    %rcx,%r8
    4409:	49 29 c0             	sub    %rax,%r8
    440c:	4c 89 05 85 fe 00 00 	mov    %r8,0xfe85(%rip)        # 14298 <fwp_gc>
    4413:	78 6c                	js     4481 <fwp_alloc_init+0xb1>
    4415:	48 8d 3c 7f          	lea    (%rdi,%rdi,2),%rdi
    4419:	4c 8d 04 fe          	lea    (%rsi,%rdi,8),%r8
    441d:	49 83 c0 08          	add    $0x8,%r8
    4421:	49 8b 18             	mov    (%r8),%rbx
    4424:	48 85 db             	test   %rbx,%rbx
    4427:	74 32                	je     445b <fwp_alloc_init+0x8b>
    4429:	48 8b 0b             	mov    (%rbx),%rcx
    442c:	48 f7 d1             	not    %rcx
    442f:	49 89 08             	mov    %rcx,(%r8)
    4432:	81 e2 f8 7f 00 00    	and    $0x7ff8,%edx
    4438:	48 39 c2             	cmp    %rax,%rdx
    443b:	73 19                	jae    4456 <fwp_alloc_init+0x86>
    443d:	48 8d 3c 13          	lea    (%rbx,%rdx,1),%rdi
    4441:	48 f7 d2             	not    %rdx
    4444:	48 01 c2             	add    %rax,%rdx
    4447:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    444b:	48 83 c2 08          	add    $0x8,%rdx
    444f:	31 f6                	xor    %esi,%esi
    4451:	e8 ba ed ff ff       	call   3210 <memset@plt>
    4456:	48 89 d8             	mov    %rbx,%rax
    4459:	5b                   	pop    %rbx
    445a:	c3                   	ret
    445b:	48 8b 5c fe 10       	mov    0x10(%rsi,%rdi,8),%rbx
    4460:	4c 8b 44 fe 18       	mov    0x18(%rsi,%rdi,8),%r8
    4465:	49 29 d8             	sub    %rbx,%r8
    4468:	49 39 c0             	cmp    %rax,%r8
    446b:	72 14                	jb     4481 <fwp_alloc_init+0xb1>
    446d:	48 8d 34 fe          	lea    (%rsi,%rdi,8),%rsi
    4471:	48 83 c6 10          	add    $0x10,%rsi
    4475:	48 8d 3c 03          	lea    (%rbx,%rax,1),%rdi
    4479:	48 89 3e             	mov    %rdi,(%rsi)
    447c:	48 85 db             	test   %rbx,%rbx
    447f:	75 b1                	jne    4432 <fwp_alloc_init+0x62>
    4481:	48 89 0d 10 fe 00 00 	mov    %rcx,0xfe10(%rip)        # 14298 <fwp_gc>
    4488:	48 89 d7             	mov    %rdx,%rdi
    448b:	31 f6                	xor    %esi,%esi
    448d:	5b                   	pop    %rbx
    448e:	eb 00                	jmp    4490 <fwp_gc_alloc>

0000000000004490 <fwp_gc_alloc>:
    4490:	53                   	push   %rbx
    4491:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    4498:	77 6c                	ja     4506 <fwp_gc_alloc+0x76>
    449a:	48 8d 4f 0f          	lea    0xf(%rdi),%rcx
    449e:	48 c1 e9 04          	shr    $0x4,%rcx
    44a2:	48 8d 05 ef fd 00 00 	lea    0xfdef(%rip),%rax        # 14298 <fwp_gc>
    44a9:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    44b0:	00 
    44b1:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    44b8:	48 29 15 d9 fd 00 00 	sub    %rdx,0xfdd9(%rip)        # 14298 <fwp_gc>
    44bf:	78 45                	js     4506 <fwp_gc_alloc+0x76>
    44c1:	41 89 f0             	mov    %esi,%r8d
    44c4:	4d 69 c0 c0 03 00 00 	imul   $0x3c0,%r8,%r8
    44cb:	4c 01 c0             	add    %r8,%rax
    44ce:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    44d2:	4c 8d 04 c8          	lea    (%rax,%rcx,8),%r8
    44d6:	49 83 c0 08          	add    $0x8,%r8
    44da:	49 8b 18             	mov    (%r8),%rbx
    44dd:	48 85 db             	test   %rbx,%rbx
    44e0:	74 12                	je     44f4 <fwp_gc_alloc+0x64>
    44e2:	48 8b 03             	mov    (%rbx),%rax
    44e5:	48 f7 d0             	not    %rax
    44e8:	49 89 00             	mov    %rax,(%r8)
    44eb:	83 fe 01             	cmp    $0x1,%esi
    44ee:	48 0f 44 d7          	cmove  %rdi,%rdx
    44f2:	eb 2e                	jmp    4522 <fwp_gc_alloc+0x92>
    44f4:	48 8b 5c c8 10       	mov    0x10(%rax,%rcx,8),%rbx
    44f9:	4c 8b 44 c8 18       	mov    0x18(%rax,%rcx,8),%r8
    44fe:	49 29 d8             	sub    %rbx,%r8
    4501:	49 39 d0             	cmp    %rdx,%r8
    4504:	73 03                	jae    4509 <fwp_gc_alloc+0x79>
    4506:	5b                   	pop    %rbx
    4507:	eb 37                	jmp    4540 <fwp_gc_alloc_slow>
    4509:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    450d:	48 83 c0 10          	add    $0x10,%rax
    4511:	48 8d 0c 13          	lea    (%rbx,%rdx,1),%rcx
    4515:	48 89 08             	mov    %rcx,(%rax)
    4518:	83 fe 01             	cmp    $0x1,%esi
    451b:	48 0f 45 fa          	cmovne %rdx,%rdi
    451f:	48 89 fa             	mov    %rdi,%rdx
    4522:	48 89 df             	mov    %rbx,%rdi
    4525:	31 f6                	xor    %esi,%esi
    4527:	e8 e4 ec ff ff       	call   3210 <memset@plt>
    452c:	48 89 d8             	mov    %rbx,%rax
    452f:	5b                   	pop    %rbx
    4530:	c3                   	ret
    4531:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4538:	0f 1f 84 00 00 00 00 
    453f:	00 

0000000000004540 <fwp_gc_alloc_slow>:
    4540:	55                   	push   %rbp
    4541:	41 57                	push   %r15
    4543:	41 56                	push   %r14
    4545:	41 54                	push   %r12
    4547:	53                   	push   %rbx
    4548:	89 f5                	mov    %esi,%ebp
    454a:	48 89 fb             	mov    %rdi,%rbx
    454d:	83 3d 30 0d 01 00 00 	cmpl   $0x0,0x10d30(%rip)        # 15284 <fwp_gc+0xfec>
    4554:	74 1b                	je     4571 <fwp_gc_alloc_slow+0x31>
    4556:	48 81 fb 01 40 00 00 	cmp    $0x4001,%rbx
    455d:	72 20                	jb     457f <fwp_gc_alloc_slow+0x3f>
    455f:	48 89 df             	mov    %rbx,%rdi
    4562:	89 ee                	mov    %ebp,%esi
    4564:	5b                   	pop    %rbx
    4565:	41 5c                	pop    %r12
    4567:	41 5e                	pop    %r14
    4569:	41 5f                	pop    %r15
    456b:	5d                   	pop    %rbp
    456c:	e9 9f 03 00 00       	jmp    4910 <fwp_gc_alloc_big>
    4571:	e8 ba 00 00 00       	call   4630 <fwp_gc_init>
    4576:	48 81 fb 01 40 00 00 	cmp    $0x4001,%rbx
    457d:	73 e0                	jae    455f <fwp_gc_alloc_slow+0x1f>
    457f:	48 8d 43 0f          	lea    0xf(%rbx),%rax
    4583:	48 c1 e8 04          	shr    $0x4,%rax
    4587:	4c 8d 25 0a fd 00 00 	lea    0xfd0a(%rip),%r12        # 14298 <fwp_gc>
    458e:	46 0f b6 bc 20 e8 0b 	movzbl 0xbe8(%rax,%r12,1),%r15d
    4595:	00 00 
    4597:	47 8b b4 bc 48 0b 00 	mov    0xb48(%r12,%r15,4),%r14d
    459e:	00 
    459f:	48 83 3d f1 fc 00 00 	cmpq   $0x0,0xfcf1(%rip)        # 14298 <fwp_gc>
    45a6:	00 
    45a7:	79 05                	jns    45ae <fwp_gc_alloc_slow+0x6e>
    45a9:	e8 b2 04 00 00       	call   4a60 <fwp_gc_spent>
    45ae:	89 e8                	mov    %ebp,%eax
    45b0:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    45b7:	49 01 c4             	add    %rax,%r12
    45ba:	4b 8d 0c 7f          	lea    (%r15,%r15,2),%rcx
    45be:	49 8d 04 cc          	lea    (%r12,%rcx,8),%rax
    45c2:	48 83 c0 08          	add    $0x8,%rax
    45c6:	49 8b 7c cc 08       	mov    0x8(%r12,%rcx,8),%rdi
    45cb:	48 85 ff             	test   %rdi,%rdi
    45ce:	74 08                	je     45d8 <fwp_gc_alloc_slow+0x98>
    45d0:	48 8b 0f             	mov    (%rdi),%rcx
    45d3:	48 f7 d1             	not    %rcx
    45d6:	eb 30                	jmp    4608 <fwp_gc_alloc_slow+0xc8>
    45d8:	49 8b 7c cc 10       	mov    0x10(%r12,%rcx,8),%rdi
    45dd:	49 8b 54 cc 18       	mov    0x18(%r12,%rcx,8),%rdx
    45e2:	48 29 fa             	sub    %rdi,%rdx
    45e5:	4c 39 f2             	cmp    %r14,%rdx
    45e8:	73 12                	jae    45fc <fwp_gc_alloc_slow+0xbc>
    45ea:	48 89 c7             	mov    %rax,%rdi
    45ed:	44 89 fe             	mov    %r15d,%esi
    45f0:	89 ea                	mov    %ebp,%edx
    45f2:	e8 39 05 00 00       	call   4b30 <fwp_gc_refill>
    45f7:	48 89 c7             	mov    %rax,%rdi
    45fa:	eb 0f                	jmp    460b <fwp_gc_alloc_slow+0xcb>
    45fc:	49 8d 04 cc          	lea    (%r12,%rcx,8),%rax
    4600:	48 83 c0 10          	add    $0x10,%rax
    4604:	4a 8d 0c 37          	lea    (%rdi,%r14,1),%rcx
    4608:	48 89 08             	mov    %rcx,(%rax)
    460b:	83 fd 01             	cmp    $0x1,%ebp
    460e:	4c 0f 44 f3          	cmove  %rbx,%r14
    4612:	31 f6                	xor    %esi,%esi
    4614:	4c 89 f2             	mov    %r14,%rdx
    4617:	5b                   	pop    %rbx
    4618:	41 5c                	pop    %r12
    461a:	41 5e                	pop    %r14
    461c:	41 5f                	pop    %r15
    461e:	5d                   	pop    %rbp
    461f:	e9 ec eb ff ff       	jmp    3210 <memset@plt>
    4624:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    462b:	00 00 00 00 00 

0000000000004630 <fwp_gc_init>:
    4630:	53                   	push   %rbx
    4631:	48 83 ec 10          	sub    $0x10,%rsp
    4635:	c7 05 45 0c 01 00 01 	movl   $0x1,0x10c45(%rip)        # 15284 <fwp_gc+0xfec>
    463c:	00 00 00 
    463f:	0f 28 05 da 99 00 00 	movaps 0x99da(%rip),%xmm0        # e020 <_IO_stdin_used+0x20>
    4646:	0f 11 05 93 07 01 00 	movups %xmm0,0x10793(%rip)        # 14de0 <fwp_gc+0xb48>
    464d:	0f 28 05 dc 99 00 00 	movaps 0x99dc(%rip),%xmm0        # e030 <_IO_stdin_used+0x30>
    4654:	0f 11 05 95 07 01 00 	movups %xmm0,0x10795(%rip)        # 14df0 <fwp_gc+0xb58>
    465b:	0f 28 05 de 99 00 00 	movaps 0x99de(%rip),%xmm0        # e040 <_IO_stdin_used+0x40>
    4662:	0f 11 05 97 07 01 00 	movups %xmm0,0x10797(%rip)        # 14e00 <fwp_gc+0xb68>
    4669:	0f 28 05 e0 99 00 00 	movaps 0x99e0(%rip),%xmm0        # e050 <_IO_stdin_used+0x50>
    4670:	0f 11 05 99 07 01 00 	movups %xmm0,0x10799(%rip)        # 14e10 <fwp_gc+0xb78>
    4677:	0f 28 05 e2 99 00 00 	movaps 0x99e2(%rip),%xmm0        # e060 <_IO_stdin_used+0x60>
    467e:	0f 11 05 9b 07 01 00 	movups %xmm0,0x1079b(%rip)        # 14e20 <fwp_gc+0xb88>
    4685:	0f 28 05 e4 99 00 00 	movaps 0x99e4(%rip),%xmm0        # e070 <_IO_stdin_used+0x70>
    468c:	0f 11 05 9d 07 01 00 	movups %xmm0,0x1079d(%rip)        # 14e30 <fwp_gc+0xb98>
    4693:	0f 28 05 e6 99 00 00 	movaps 0x99e6(%rip),%xmm0        # e080 <_IO_stdin_used+0x80>
    469a:	0f 11 05 9f 07 01 00 	movups %xmm0,0x1079f(%rip)        # 14e40 <fwp_gc+0xba8>
    46a1:	0f 28 05 e8 99 00 00 	movaps 0x99e8(%rip),%xmm0        # e090 <_IO_stdin_used+0x90>
    46a8:	0f 11 05 a1 07 01 00 	movups %xmm0,0x107a1(%rip)        # 14e50 <fwp_gc+0xbb8>
    46af:	0f 28 05 ea 99 00 00 	movaps 0x99ea(%rip),%xmm0        # e0a0 <_IO_stdin_used+0xa0>
    46b6:	0f 11 05 a3 07 01 00 	movups %xmm0,0x107a3(%rip)        # 14e60 <fwp_gc+0xbc8>
    46bd:	0f 28 05 ec 99 00 00 	movaps 0x99ec(%rip),%xmm0        # e0b0 <_IO_stdin_used+0xb0>
    46c4:	0f 11 05 a5 07 01 00 	movups %xmm0,0x107a5(%rip)        # 14e70 <fwp_gc+0xbd8>
    46cb:	31 c9                	xor    %ecx,%ecx
    46cd:	48 8d 05 c4 fb 00 00 	lea    0xfbc4(%rip),%rax        # 14298 <fwp_gc>
    46d4:	31 d2                	xor    %edx,%edx
    46d6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    46dd:	00 00 00 
    46e0:	89 d6                	mov    %edx,%esi
    46e2:	c1 e6 04             	shl    $0x4,%esi
    46e5:	48 ff c9             	dec    %rcx
    46e8:	48 89 cf             	mov    %rcx,%rdi
    46eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    46f0:	48 89 f9             	mov    %rdi,%rcx
    46f3:	48 ff c7             	inc    %rdi
    46f6:	3b b4 88 4c 0b 00 00 	cmp    0xb4c(%rax,%rcx,4),%esi
    46fd:	77 f1                	ja     46f0 <fwp_gc_init+0xc0>
    46ff:	40 88 bc 02 e8 0b 00 	mov    %dil,0xbe8(%rdx,%rax,1)
    4706:	00 
    4707:	48 89 d6             	mov    %rdx,%rsi
    470a:	48 83 ce 01          	or     $0x1,%rsi
    470e:	48 81 fe 01 04 00 00 	cmp    $0x401,%rsi
    4715:	74 26                	je     473d <fwp_gc_init+0x10d>
    4717:	89 f7                	mov    %esi,%edi
    4719:	c1 e7 04             	shl    $0x4,%edi
    471c:	0f 1f 40 00          	nopl   0x0(%rax)
    4720:	49 89 c8             	mov    %rcx,%r8
    4723:	48 ff c1             	inc    %rcx
    4726:	42 3b bc 80 4c 0b 00 	cmp    0xb4c(%rax,%r8,4),%edi
    472d:	00 
    472e:	77 f0                	ja     4720 <fwp_gc_init+0xf0>
    4730:	88 8c 06 e8 0b 00 00 	mov    %cl,0xbe8(%rsi,%rax,1)
    4737:	48 83 c2 02          	add    $0x2,%rdx
    473b:	eb a3                	jmp    46e0 <fwp_gc_init+0xb0>
    473d:	48 b8 00 00 00 00 10 	movabs $0x1000000000,%rax
    4744:	00 00 00 
    4747:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    474c:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    4751:	e8 ba 04 00 00       	call   4c10 <fwp_gc_reserve>
    4756:	48 85 c0             	test   %rax,%rax
    4759:	0f 84 ab 01 00 00    	je     490a <fwp_gc_init+0x2da>
    475f:	48 89 05 6a 0b 01 00 	mov    %rax,0x10b6a(%rip)        # 152d0 <fwp_gc+0x1038>
    4766:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    476b:	48 8d 91 00 00 01 00 	lea    0x10000(%rcx),%rdx
    4772:	48 89 15 5f 0b 01 00 	mov    %rdx,0x10b5f(%rip)        # 152d8 <fwp_gc+0x1040>
    4779:	48 05 ff ff 00 00    	add    $0xffff,%rax
    477f:	48 25 00 00 ff ff    	and    $0xffffffffffff0000,%rax
    4785:	48 89 05 3c 0b 01 00 	mov    %rax,0x10b3c(%rip)        # 152c8 <fwp_gc+0x1030>
    478c:	48 c1 e9 10          	shr    $0x10,%rcx
    4790:	48 89 0d 51 0b 01 00 	mov    %rcx,0x10b51(%rip)        # 152e8 <fwp_gc+0x1050>
    4797:	48 69 f1 28 12 00 00 	imul   $0x1228,%rcx,%rsi
    479e:	48 89 35 73 0b 01 00 	mov    %rsi,0x10b73(%rip)        # 15318 <fwp_gc+0x1080>
    47a5:	31 ff                	xor    %edi,%edi
    47a7:	31 d2                	xor    %edx,%edx
    47a9:	b9 22 40 00 00       	mov    $0x4022,%ecx
    47ae:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    47b4:	45 31 c9             	xor    %r9d,%r9d
    47b7:	e8 d4 e9 ff ff       	call   3190 <mmap@plt>
    47bc:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    47c0:	0f 84 44 01 00 00    	je     490a <fwp_gc_init+0x2da>
    47c6:	48 89 05 43 0b 01 00 	mov    %rax,0x10b43(%rip)        # 15310 <fwp_gc+0x1078>
    47cd:	48 8d 3d c6 a0 00 00 	lea    0xa0c6(%rip),%rdi        # e89a <exec_in_fp0+0x19a>
    47d4:	e8 57 e8 ff ff       	call   3030 <getenv@plt>
    47d9:	48 85 c0             	test   %rax,%rax
    47dc:	74 2e                	je     480c <fwp_gc_init+0x1dc>
    47de:	48 89 c3             	mov    %rax,%rbx
    47e1:	48 8d 35 b9 a0 00 00 	lea    0xa0b9(%rip),%rsi        # e8a1 <exec_in_fp0+0x1a1>
    47e8:	48 89 c7             	mov    %rax,%rdi
    47eb:	e8 e0 ea ff ff       	call   32d0 <strcmp@plt>
    47f0:	85 c0                	test   %eax,%eax
    47f2:	74 1f                	je     4813 <fwp_gc_init+0x1e3>
    47f4:	48 8d 35 a2 ac 00 00 	lea    0xaca2(%rip),%rsi        # f49d <exec_in_fp0+0xd9d>
    47fb:	48 89 df             	mov    %rbx,%rdi
    47fe:	e8 cd ea ff ff       	call   32d0 <strcmp@plt>
    4803:	31 c9                	xor    %ecx,%ecx
    4805:	85 c0                	test   %eax,%eax
    4807:	0f 95 c1             	setne  %cl
    480a:	eb 09                	jmp    4815 <fwp_gc_init+0x1e5>
    480c:	b9 01 00 00 00       	mov    $0x1,%ecx
    4811:	eb 02                	jmp    4815 <fwp_gc_init+0x1e5>
    4813:	31 c9                	xor    %ecx,%ecx
    4815:	89 0d 6d 0a 01 00    	mov    %ecx,0x10a6d(%rip)        # 15288 <fwp_gc+0xff0>
    481b:	48 8d 3d 83 a0 00 00 	lea    0xa083(%rip),%rdi        # e8a5 <exec_in_fp0+0x1a5>
    4822:	e8 09 e8 ff ff       	call   3030 <getenv@plt>
    4827:	31 c9                	xor    %ecx,%ecx
    4829:	48 85 c0             	test   %rax,%rax
    482c:	74 1b                	je     4849 <fwp_gc_init+0x219>
    482e:	80 38 00             	cmpb   $0x0,(%rax)
    4831:	74 16                	je     4849 <fwp_gc_init+0x219>
    4833:	48 8d 35 63 ac 00 00 	lea    0xac63(%rip),%rsi        # f49d <exec_in_fp0+0xd9d>
    483a:	48 89 c7             	mov    %rax,%rdi
    483d:	e8 8e ea ff ff       	call   32d0 <strcmp@plt>
    4842:	31 c9                	xor    %ecx,%ecx
    4844:	85 c0                	test   %eax,%eax
    4846:	0f 95 c1             	setne  %cl
    4849:	89 0d 45 0a 01 00    	mov    %ecx,0x10a45(%rip)        # 15294 <fwp_gc+0xffc>
    484f:	48 8d 3d 44 a0 00 00 	lea    0xa044(%rip),%rdi        # e89a <exec_in_fp0+0x19a>
    4856:	e8 d5 e7 ff ff       	call   3030 <getenv@plt>
    485b:	48 85 c0             	test   %rax,%rax
    485e:	74 18                	je     4878 <fwp_gc_init+0x248>
    4860:	48 8d 35 4b a0 00 00 	lea    0xa04b(%rip),%rsi        # e8b2 <exec_in_fp0+0x1b2>
    4867:	48 89 c7             	mov    %rax,%rdi
    486a:	e8 61 ea ff ff       	call   32d0 <strcmp@plt>
    486f:	31 c9                	xor    %ecx,%ecx
    4871:	85 c0                	test   %eax,%eax
    4873:	0f 95 c1             	setne  %cl
    4876:	eb 05                	jmp    487d <fwp_gc_init+0x24d>
    4878:	b9 01 00 00 00       	mov    $0x1,%ecx
    487d:	89 0d 15 0a 01 00    	mov    %ecx,0x10a15(%rip)        # 15298 <fwp_gc+0x1000>
    4883:	c7 05 13 0a 01 00 01 	movl   $0x1,0x10a13(%rip)        # 152a0 <fwp_gc+0x1008>
    488a:	00 00 00 
    488d:	48 8d 3d 23 a0 00 00 	lea    0xa023(%rip),%rdi        # e8b7 <exec_in_fp0+0x1b7>
    4894:	e8 97 e7 ff ff       	call   3030 <getenv@plt>
    4899:	31 c9                	xor    %ecx,%ecx
    489b:	48 85 c0             	test   %rax,%rax
    489e:	74 1b                	je     48bb <fwp_gc_init+0x28b>
    48a0:	80 38 00             	cmpb   $0x0,(%rax)
    48a3:	74 16                	je     48bb <fwp_gc_init+0x28b>
    48a5:	48 8d 35 f1 ab 00 00 	lea    0xabf1(%rip),%rsi        # f49d <exec_in_fp0+0xd9d>
    48ac:	48 89 c7             	mov    %rax,%rdi
    48af:	e8 1c ea ff ff       	call   32d0 <strcmp@plt>
    48b4:	31 c9                	xor    %ecx,%ecx
    48b6:	85 c0                	test   %eax,%eax
    48b8:	0f 95 c1             	setne  %cl
    48bb:	89 0d db 09 01 00    	mov    %ecx,0x109db(%rip)        # 1529c <fwp_gc+0x1004>
    48c1:	48 8d 3d fd 9f 00 00 	lea    0x9ffd(%rip),%rdi        # e8c5 <exec_in_fp0+0x1c5>
    48c8:	e8 63 e7 ff ff       	call   3030 <getenv@plt>
    48cd:	48 85 c0             	test   %rax,%rax
    48d0:	74 0a                	je     48dc <fwp_gc_init+0x2ac>
    48d2:	48 89 c7             	mov    %rax,%rdi
    48d5:	e8 26 eb ff ff       	call   3400 <atol@plt>
    48da:	eb 02                	jmp    48de <fwp_gc_init+0x2ae>
    48dc:	31 c0                	xor    %eax,%eax
    48de:	31 c9                	xor    %ecx,%ecx
    48e0:	48 85 c0             	test   %rax,%rax
    48e3:	48 0f 4f c8          	cmovg  %rax,%rcx
    48e7:	48 89 0d ca 09 01 00 	mov    %rcx,0x109ca(%rip)        # 152b8 <fwp_gc+0x1020>
    48ee:	48 c7 05 af 0b 01 00 	movq   $0x800000,0x10baf(%rip)        # 154a8 <fwp_gc+0x1210>
    48f5:	00 00 80 00 
    48f9:	48 c7 05 94 f9 00 00 	movq   $0x800000,0xf994(%rip)        # 14298 <fwp_gc>
    4900:	00 00 80 00 
    4904:	48 83 c4 10          	add    $0x10,%rsp
    4908:	5b                   	pop    %rbx
    4909:	c3                   	ret
    490a:	e8 71 03 00 00       	call   4c80 <fwp_gc_oom>
    490f:	90                   	nop

0000000000004910 <fwp_gc_alloc_big>:
    4910:	55                   	push   %rbp
    4911:	41 57                	push   %r15
    4913:	41 56                	push   %r14
    4915:	41 54                	push   %r12
    4917:	53                   	push   %rbx
    4918:	48 b8 01 00 00 00 00 	movabs $0x4000000000000001,%rax
    491f:	00 00 40 
    4922:	48 39 c7             	cmp    %rax,%rdi
    4925:	0f 83 28 01 00 00    	jae    4a53 <fwp_gc_alloc_big+0x143>
    492b:	89 f5                	mov    %esi,%ebp
    492d:	48 89 fb             	mov    %rdi,%rbx
    4930:	48 29 3d 61 f9 00 00 	sub    %rdi,0xf961(%rip)        # 14298 <fwp_gc>
    4937:	79 05                	jns    493e <fwp_gc_alloc_big+0x2e>
    4939:	e8 22 01 00 00       	call   4a60 <fwp_gc_spent>
    493e:	4c 8d bb ff ff 00 00 	lea    0xffff(%rbx),%r15
    4945:	49 c1 ef 10          	shr    $0x10,%r15
    4949:	4c 89 ff             	mov    %r15,%rdi
    494c:	e8 5f 03 00 00       	call   4cb0 <fwp_gc_chunks>
    4951:	49 89 c6             	mov    %rax,%r14
    4954:	48 8b 05 b5 09 01 00 	mov    0x109b5(%rip),%rax        # 15310 <fwp_gc+0x1078>
    495b:	4d 69 e6 28 12 00 00 	imul   $0x1228,%r14,%r12
    4962:	42 c6 04 20 02       	movb   $0x2,(%rax,%r12,1)
    4967:	42 88 6c 20 01       	mov    %bpl,0x1(%rax,%r12,1)
    496c:	66 42 c7 44 20 03 00 	movw   $0x100,0x3(%rax,%r12,1)
    4973:	01 
    4974:	46 89 7c 20 10       	mov    %r15d,0x10(%rax,%r12,1)
    4979:	4a 89 5c 20 18       	mov    %rbx,0x18(%rax,%r12,1)
    497e:	4a 8d 3c 20          	lea    (%rax,%r12,1),%rdi
    4982:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    4989:	e8 e2 f6 ff ff       	call   4070 <fwp_rc_clear_slot>
    498e:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    4995:	0f 82 9b 00 00 00    	jb     4a36 <fwp_gc_alloc_big+0x126>
    499b:	49 83 ff 03          	cmp    $0x3,%r15
    499f:	b9 02 00 00 00       	mov    $0x2,%ecx
    49a4:	49 0f 43 cf          	cmovae %r15,%rcx
    49a8:	48 8b 05 61 09 01 00 	mov    0x10961(%rip),%rax        # 15310 <fwp_gc+0x1078>
    49af:	48 ff c9             	dec    %rcx
    49b2:	ba 01 00 00 00       	mov    $0x1,%edx
    49b7:	48 81 fb 01 00 02 00 	cmp    $0x20001,%rbx
    49be:	72 59                	jb     4a19 <fwp_gc_alloc_big+0x109>
    49c0:	49 8d 34 04          	lea    (%r12,%rax,1),%rsi
    49c4:	48 81 c6 60 24 00 00 	add    $0x2460,%rsi
    49cb:	48 89 cf             	mov    %rcx,%rdi
    49ce:	48 83 e7 fe          	and    $0xfffffffffffffffe,%rdi
    49d2:	48 f7 df             	neg    %rdi
    49d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    49dc:	00 00 00 00 
    49e0:	c6 86 c8 ed ff ff 03 	movb   $0x3,-0x1238(%rsi)
    49e7:	c6 86 cc ed ff ff 01 	movb   $0x1,-0x1234(%rsi)
    49ee:	44 89 b6 d8 ed ff ff 	mov    %r14d,-0x1228(%rsi)
    49f5:	c6 46 f0 03          	movb   $0x3,-0x10(%rsi)
    49f9:	c6 46 f4 01          	movb   $0x1,-0xc(%rsi)
    49fd:	44 89 36             	mov    %r14d,(%rsi)
    4a00:	48 81 c6 50 24 00 00 	add    $0x2450,%rsi
    4a07:	4c 8d 04 17          	lea    (%rdi,%rdx,1),%r8
    4a0b:	49 83 c0 02          	add    $0x2,%r8
    4a0f:	48 83 c2 02          	add    $0x2,%rdx
    4a13:	49 83 f8 01          	cmp    $0x1,%r8
    4a17:	75 c7                	jne    49e0 <fwp_gc_alloc_big+0xd0>
    4a19:	f6 c1 01             	test   $0x1,%cl
    4a1c:	74 18                	je     4a36 <fwp_gc_alloc_big+0x126>
    4a1e:	4c 01 e0             	add    %r12,%rax
    4a21:	48 69 ca 28 12 00 00 	imul   $0x1228,%rdx,%rcx
    4a28:	c6 04 08 03          	movb   $0x3,(%rax,%rcx,1)
    4a2c:	c6 44 08 04 01       	movb   $0x1,0x4(%rax,%rcx,1)
    4a31:	44 89 74 08 10       	mov    %r14d,0x10(%rax,%rcx,1)
    4a36:	4c 89 f7             	mov    %r14,%rdi
    4a39:	e8 52 f6 ff ff       	call   4090 <fwp_gc_chunk_addr>
    4a3e:	48 89 c7             	mov    %rax,%rdi
    4a41:	31 f6                	xor    %esi,%esi
    4a43:	48 89 da             	mov    %rbx,%rdx
    4a46:	5b                   	pop    %rbx
    4a47:	41 5c                	pop    %r12
    4a49:	41 5e                	pop    %r14
    4a4b:	41 5f                	pop    %r15
    4a4d:	5d                   	pop    %rbp
    4a4e:	e9 bd e7 ff ff       	jmp    3210 <memset@plt>
    4a53:	e8 28 02 00 00       	call   4c80 <fwp_gc_oom>
    4a58:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    4a5f:	00 

0000000000004a60 <fwp_gc_spent>:
    4a60:	50                   	push   %rax
    4a61:	83 3d 1c 08 01 00 00 	cmpl   $0x0,0x1081c(%rip)        # 15284 <fwp_gc+0xfec>
    4a68:	75 05                	jne    4a6f <fwp_gc_spent+0xf>
    4a6a:	e8 c1 fb ff ff       	call   4630 <fwp_gc_init>
    4a6f:	8b 05 17 08 01 00    	mov    0x10817(%rip),%eax        # 1528c <fwp_gc+0xff4>
    4a75:	85 c0                	test   %eax,%eax
    4a77:	74 6d                	je     4ae6 <fwp_gc_spent+0x86>
    4a79:	48 8b 0d 38 08 01 00 	mov    0x10838(%rip),%rcx        # 152b8 <fwp_gc+0x1020>
    4a80:	48 85 c9             	test   %rcx,%rcx
    4a83:	74 61                	je     4ae6 <fwp_gc_spent+0x86>
    4a85:	48 8b 05 34 08 01 00 	mov    0x10834(%rip),%rax        # 152c0 <fwp_gc+0x1028>
    4a8c:	48 ff c0             	inc    %rax
    4a8f:	48 89 05 2a 08 01 00 	mov    %rax,0x1082a(%rip)        # 152c0 <fwp_gc+0x1028>
    4a96:	48 39 c8             	cmp    %rcx,%rax
    4a99:	7c 10                	jl     4aab <fwp_gc_spent+0x4b>
    4a9b:	48 c7 05 1a 08 01 00 	movq   $0x0,0x1081a(%rip)        # 152c0 <fwp_gc+0x1028>
    4aa2:	00 00 00 00 
    4aa6:	e8 85 03 00 00       	call   4e30 <fwp_gc_collect>
    4aab:	48 8b 05 f6 09 01 00 	mov    0x109f6(%rip),%rax        # 154a8 <fwp_gc+0x1210>
    4ab2:	48 2b 05 df f7 00 00 	sub    0xf7df(%rip),%rax        # 14298 <fwp_gc>
    4ab9:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    4abe:	f2 0f 58 05 ba 09 01 	addsd  0x109ba(%rip),%xmm0        # 15480 <fwp_gc+0x11e8>
    4ac5:	00 
    4ac6:	f2 0f 11 05 b2 09 01 	movsd  %xmm0,0x109b2(%rip)        # 15480 <fwp_gc+0x11e8>
    4acd:	00 
    4ace:	48 c7 05 cf 09 01 00 	movq   $0x0,0x109cf(%rip)        # 154a8 <fwp_gc+0x1210>
    4ad5:	00 00 00 00 
    4ad9:	48 c7 05 b4 f7 00 00 	movq   $0x0,0xf7b4(%rip)        # 14298 <fwp_gc>
    4ae0:	00 00 00 00 
    4ae4:	58                   	pop    %rax
    4ae5:	c3                   	ret
    4ae6:	85 c0                	test   %eax,%eax
    4ae8:	74 06                	je     4af0 <fwp_gc_spent+0x90>
    4aea:	58                   	pop    %rax
    4aeb:	e9 40 03 00 00       	jmp    4e30 <fwp_gc_collect>
    4af0:	48 8b 05 b1 09 01 00 	mov    0x109b1(%rip),%rax        # 154a8 <fwp_gc+0x1210>
    4af7:	48 2b 05 9a f7 00 00 	sub    0xf79a(%rip),%rax        # 14298 <fwp_gc>
    4afe:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    4b03:	f2 0f 58 05 75 09 01 	addsd  0x10975(%rip),%xmm0        # 15480 <fwp_gc+0x11e8>
    4b0a:	00 
    4b0b:	f2 0f 11 05 6d 09 01 	movsd  %xmm0,0x1096d(%rip)        # 15480 <fwp_gc+0x11e8>
    4b12:	00 
    4b13:	48 c7 05 8a 09 01 00 	movq   $0x800000,0x1098a(%rip)        # 154a8 <fwp_gc+0x1210>
    4b1a:	00 00 80 00 
    4b1e:	48 c7 05 6f f7 00 00 	movq   $0x800000,0xf76f(%rip)        # 14298 <fwp_gc>
    4b25:	00 00 80 00 
    4b29:	58                   	pop    %rax
    4b2a:	c3                   	ret
    4b2b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000004b30 <fwp_gc_refill>:
    4b30:	55                   	push   %rbp
    4b31:	41 57                	push   %r15
    4b33:	41 56                	push   %r14
    4b35:	53                   	push   %rbx
    4b36:	50                   	push   %rax
    4b37:	89 d5                	mov    %edx,%ebp
    4b39:	41 89 f7             	mov    %esi,%r15d
    4b3c:	48 89 fb             	mov    %rdi,%rbx
    4b3f:	bf 01 00 00 00       	mov    $0x1,%edi
    4b44:	e8 67 01 00 00       	call   4cb0 <fwp_gc_chunks>
    4b49:	49 89 c6             	mov    %rax,%r14
    4b4c:	48 8b 0d bd 07 01 00 	mov    0x107bd(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    4b53:	48 8d 05 3e f7 00 00 	lea    0xf73e(%rip),%rax        # 14298 <fwp_gc>
    4b5a:	49 69 f6 28 12 00 00 	imul   $0x1228,%r14,%rsi
    4b61:	48 8d 3c 31          	lea    (%rcx,%rsi,1),%rdi
    4b65:	c6 04 31 01          	movb   $0x1,(%rcx,%rsi,1)
    4b69:	40 88 6c 31 01       	mov    %bpl,0x1(%rcx,%rsi,1)
    4b6e:	44 88 7c 31 02       	mov    %r15b,0x2(%rcx,%rsi,1)
    4b73:	c6 44 31 04 01       	movb   $0x1,0x4(%rcx,%rsi,1)
    4b78:	44 89 fa             	mov    %r15d,%edx
    4b7b:	44 8b 84 90 48 0b 00 	mov    0xb48(%rax,%rdx,4),%r8d
    4b82:	00 
    4b83:	44 89 44 31 08       	mov    %r8d,0x8(%rcx,%rsi,1)
    4b88:	b8 00 00 01 00       	mov    $0x10000,%eax
    4b8d:	31 d2                	xor    %edx,%edx
    4b8f:	41 f7 f0             	div    %r8d
    4b92:	89 44 31 0c          	mov    %eax,0xc(%rcx,%rsi,1)
    4b96:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    4b9b:	4c 01 c0             	add    %r8,%rax
    4b9e:	48 0f ba e0 20       	bt     $0x20,%rax
    4ba3:	73 07                	jae    4bac <fwp_gc_refill+0x7c>
    4ba5:	31 d2                	xor    %edx,%edx
    4ba7:	49 f7 f0             	div    %r8
    4baa:	eb 05                	jmp    4bb1 <fwp_gc_refill+0x81>
    4bac:	31 d2                	xor    %edx,%edx
    4bae:	41 f7 f0             	div    %r8d
    4bb1:	4c 8d 3c 31          	lea    (%rcx,%rsi,1),%r15
    4bb5:	49 83 c7 08          	add    $0x8,%r15
    4bb9:	89 44 31 20          	mov    %eax,0x20(%rcx,%rsi,1)
    4bbd:	e8 4e 15 00 00       	call   6110 <fwp_rc_clear_chunk>
    4bc2:	4c 89 f7             	mov    %r14,%rdi
    4bc5:	e8 c6 f4 ff ff       	call   4090 <fwp_gc_chunk_addr>
    4bca:	83 3d cb 06 01 00 00 	cmpl   $0x0,0x106cb(%rip)        # 1529c <fwp_gc+0x1004>
    4bd1:	74 15                	je     4be8 <fwp_gc_refill+0xb8>
    4bd3:	ba 00 00 01 00       	mov    $0x10000,%edx
    4bd8:	48 89 c7             	mov    %rax,%rdi
    4bdb:	31 f6                	xor    %esi,%esi
    4bdd:	49 89 c6             	mov    %rax,%r14
    4be0:	e8 2b e6 ff ff       	call   3210 <memset@plt>
    4be5:	4c 89 f0             	mov    %r14,%rax
    4be8:	41 8b 0f             	mov    (%r15),%ecx
    4beb:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    4bef:	48 89 53 08          	mov    %rdx,0x8(%rbx)
    4bf3:	41 8b 57 04          	mov    0x4(%r15),%edx
    4bf7:	48 0f af d1          	imul   %rcx,%rdx
    4bfb:	48 01 c2             	add    %rax,%rdx
    4bfe:	48 89 53 10          	mov    %rdx,0x10(%rbx)
    4c02:	48 83 c4 08          	add    $0x8,%rsp
    4c06:	5b                   	pop    %rbx
    4c07:	41 5e                	pop    %r14
    4c09:	41 5f                	pop    %r15
    4c0b:	5d                   	pop    %rbp
    4c0c:	c3                   	ret
    4c0d:	0f 1f 00             	nopl   (%rax)

0000000000004c10 <fwp_gc_reserve>:
    4c10:	41 56                	push   %r14
    4c12:	53                   	push   %rbx
    4c13:	50                   	push   %rax
    4c14:	4c 8b 37             	mov    (%rdi),%r14
    4c17:	49 81 fe 00 00 00 10 	cmp    $0x10000000,%r14
    4c1e:	72 47                	jb     4c67 <fwp_gc_reserve+0x57>
    4c20:	48 89 fb             	mov    %rdi,%rbx
    4c23:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4c2a:	84 00 00 00 00 00 
    4c30:	49 8d b6 00 00 01 00 	lea    0x10000(%r14),%rsi
    4c37:	31 ff                	xor    %edi,%edi
    4c39:	31 d2                	xor    %edx,%edx
    4c3b:	b9 22 40 00 00       	mov    $0x4022,%ecx
    4c40:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    4c46:	45 31 c9             	xor    %r9d,%r9d
    4c49:	e8 42 e5 ff ff       	call   3190 <mmap@plt>
    4c4e:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    4c52:	75 17                	jne    4c6b <fwp_gc_reserve+0x5b>
    4c54:	4c 89 f0             	mov    %r14,%rax
    4c57:	48 c1 e8 02          	shr    $0x2,%rax
    4c5b:	49 81 fe ff ff ff 3f 	cmp    $0x3fffffff,%r14
    4c62:	49 89 c6             	mov    %rax,%r14
    4c65:	77 c9                	ja     4c30 <fwp_gc_reserve+0x20>
    4c67:	31 c0                	xor    %eax,%eax
    4c69:	eb 03                	jmp    4c6e <fwp_gc_reserve+0x5e>
    4c6b:	4c 89 33             	mov    %r14,(%rbx)
    4c6e:	48 83 c4 08          	add    $0x8,%rsp
    4c72:	5b                   	pop    %rbx
    4c73:	41 5e                	pop    %r14
    4c75:	c3                   	ret
    4c76:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    4c7d:	00 00 00 

0000000000004c80 <fwp_gc_oom>:
    4c80:	50                   	push   %rax
    4c81:	48 8b 05 50 f3 00 00 	mov    0xf350(%rip),%rax        # 13fd8 <stderr@GLIBC_2.2.5>
    4c88:	48 8b 08             	mov    (%rax),%rcx
    4c8b:	48 8d 3d 41 9c 00 00 	lea    0x9c41(%rip),%rdi        # e8d3 <exec_in_fp0+0x1d3>
    4c92:	be 13 00 00 00       	mov    $0x13,%esi
    4c97:	ba 01 00 00 00       	mov    $0x1,%edx
    4c9c:	e8 ff e7 ff ff       	call   34a0 <fwrite@plt>
    4ca1:	bf 66 00 00 00       	mov    $0x66,%edi
    4ca6:	e8 d5 e7 ff ff       	call   3480 <exit@plt>
    4cab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000004cb0 <fwp_gc_chunks>:
    4cb0:	41 56                	push   %r14
    4cb2:	53                   	push   %rbx
    4cb3:	50                   	push   %rax
    4cb4:	48 89 fb             	mov    %rdi,%rbx
    4cb7:	31 d2                	xor    %edx,%edx
    4cb9:	48 83 ff 01          	cmp    $0x1,%rdi
    4cbd:	0f 95 c2             	setne  %dl
    4cc0:	48 8d 0d d1 f5 00 00 	lea    0xf5d1(%rip),%rcx        # 14298 <fwp_gc>
    4cc7:	48 8b 84 d1 68 10 00 	mov    0x1068(%rcx,%rdx,8),%rax
    4cce:	00 
    4ccf:	4c 8b 35 1a 06 01 00 	mov    0x1061a(%rip),%r14        # 152f0 <fwp_gc+0x1058>
    4cd6:	48 89 c7             	mov    %rax,%rdi
    4cd9:	4c 29 f7             	sub    %r14,%rdi
    4cdc:	73 61                	jae    4d3f <fwp_gc_chunks+0x8f>
    4cde:	48 8d 34 d5 68 10 00 	lea    0x1068(,%rdx,8),%rsi
    4ce5:	00 
    4ce6:	4c 69 c0 28 12 00 00 	imul   $0x1228,%rax,%r8
    4ced:	4c 03 05 1c 06 01 00 	add    0x1061c(%rip),%r8        # 15310 <fwp_gc+0x1078>
    4cf4:	31 d2                	xor    %edx,%edx
    4cf6:	45 31 c9             	xor    %r9d,%r9d
    4cf9:	eb 17                	jmp    4d12 <fwp_gc_chunks+0x62>
    4cfb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    4d00:	45 31 c9             	xor    %r9d,%r9d
    4d03:	48 ff ca             	dec    %rdx
    4d06:	49 81 c0 28 12 00 00 	add    $0x1228,%r8
    4d0d:	48 39 d7             	cmp    %rdx,%rdi
    4d10:	74 30                	je     4d42 <fwp_gc_chunks+0x92>
    4d12:	41 80 38 00          	cmpb   $0x0,(%r8)
    4d16:	75 e8                	jne    4d00 <fwp_gc_chunks+0x50>
    4d18:	49 ff c1             	inc    %r9
    4d1b:	49 39 d9             	cmp    %rbx,%r9
    4d1e:	75 e3                	jne    4d03 <fwp_gc_chunks+0x53>
    4d20:	48 ff c0             	inc    %rax
    4d23:	48 89 c7             	mov    %rax,%rdi
    4d26:	48 29 d7             	sub    %rdx,%rdi
    4d29:	48 89 3c 0e          	mov    %rdi,(%rsi,%rcx,1)
    4d2d:	48 29 1d 44 07 01 00 	sub    %rbx,0x10744(%rip)        # 15478 <fwp_gc+0x11e0>
    4d34:	48 29 d8             	sub    %rbx,%rax
    4d37:	48 29 d0             	sub    %rdx,%rax
    4d3a:	49 89 c6             	mov    %rax,%r14
    4d3d:	eb 33                	jmp    4d72 <fwp_gc_chunks+0xc2>
    4d3f:	45 31 c9             	xor    %r9d,%r9d
    4d42:	4d 29 ce             	sub    %r9,%r14
    4d45:	4c 29 0d 2c 07 01 00 	sub    %r9,0x1072c(%rip)        # 15478 <fwp_gc+0x11e0>
    4d4c:	4c 01 f3             	add    %r14,%rbx
    4d4f:	48 89 df             	mov    %rbx,%rdi
    4d52:	e8 29 00 00 00       	call   4d80 <fwp_gc_commit>
    4d57:	48 89 1d 92 05 01 00 	mov    %rbx,0x10592(%rip)        # 152f0 <fwp_gc+0x1058>
    4d5e:	48 c1 e3 10          	shl    $0x10,%rbx
    4d62:	48 3b 1d 77 05 01 00 	cmp    0x10577(%rip),%rbx        # 152e0 <fwp_gc+0x1048>
    4d69:	76 07                	jbe    4d72 <fwp_gc_chunks+0xc2>
    4d6b:	48 89 1d 6e 05 01 00 	mov    %rbx,0x1056e(%rip)        # 152e0 <fwp_gc+0x1048>
    4d72:	4c 89 f0             	mov    %r14,%rax
    4d75:	48 83 c4 08          	add    $0x8,%rsp
    4d79:	5b                   	pop    %rbx
    4d7a:	41 5e                	pop    %r14
    4d7c:	c3                   	ret
    4d7d:	0f 1f 00             	nopl   (%rax)

0000000000004d80 <fwp_gc_commit>:
    4d80:	53                   	push   %rbx
    4d81:	48 89 fb             	mov    %rdi,%rbx
    4d84:	48 8b 3d 6d 05 01 00 	mov    0x1056d(%rip),%rdi        # 152f8 <fwp_gc+0x1060>
    4d8b:	48 39 df             	cmp    %rbx,%rdi
    4d8e:	0f 83 8f 00 00 00    	jae    4e23 <fwp_gc_commit+0xa3>
    4d94:	48 8b 05 4d 05 01 00 	mov    0x1054d(%rip),%rax        # 152e8 <fwp_gc+0x1050>
    4d9b:	48 39 d8             	cmp    %rbx,%rax
    4d9e:	0f 82 81 00 00 00    	jb     4e25 <fwp_gc_commit+0xa5>
    4da4:	48 83 c3 40          	add    $0x40,%rbx
    4da8:	48 39 c3             	cmp    %rax,%rbx
    4dab:	48 0f 43 d8          	cmovae %rax,%rbx
    4daf:	48 89 de             	mov    %rbx,%rsi
    4db2:	48 29 fe             	sub    %rdi,%rsi
    4db5:	48 c1 e7 10          	shl    $0x10,%rdi
    4db9:	48 03 3d 08 05 01 00 	add    0x10508(%rip),%rdi        # 152c8 <fwp_gc+0x1030>
    4dc0:	48 c1 e6 10          	shl    $0x10,%rsi
    4dc4:	ba 03 00 00 00       	mov    $0x3,%edx
    4dc9:	e8 42 e6 ff ff       	call   3410 <mprotect@plt>
    4dce:	85 c0                	test   %eax,%eax
    4dd0:	75 53                	jne    4e25 <fwp_gc_commit+0xa5>
    4dd2:	bf 1e 00 00 00       	mov    $0x1e,%edi
    4dd7:	e8 54 e6 ff ff       	call   3430 <sysconf@plt>
    4ddc:	48 8b 0d 2d 05 01 00 	mov    0x1052d(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    4de3:	48 69 3d 0a 05 01 00 	imul   $0x1228,0x1050a(%rip),%rdi        # 152f8 <fwp_gc+0x1060>
    4dea:	28 12 00 00 
    4dee:	48 01 cf             	add    %rcx,%rdi
    4df1:	48 69 d3 28 12 00 00 	imul   $0x1228,%rbx,%rdx
    4df8:	48 01 ca             	add    %rcx,%rdx
    4dfb:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    4dff:	48 ff ce             	dec    %rsi
    4e02:	48 f7 d8             	neg    %rax
    4e05:	48 21 c7             	and    %rax,%rdi
    4e08:	48 21 c6             	and    %rax,%rsi
    4e0b:	48 29 fe             	sub    %rdi,%rsi
    4e0e:	ba 03 00 00 00       	mov    $0x3,%edx
    4e13:	e8 f8 e5 ff ff       	call   3410 <mprotect@plt>
    4e18:	85 c0                	test   %eax,%eax
    4e1a:	75 09                	jne    4e25 <fwp_gc_commit+0xa5>
    4e1c:	48 89 1d d5 04 01 00 	mov    %rbx,0x104d5(%rip)        # 152f8 <fwp_gc+0x1060>
    4e23:	5b                   	pop    %rbx
    4e24:	c3                   	ret
    4e25:	e8 56 fe ff ff       	call   4c80 <fwp_gc_oom>
    4e2a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000004e30 <fwp_gc_collect>:
    4e30:	83 3d 59 04 01 00 00 	cmpl   $0x0,0x10459(%rip)        # 15290 <fwp_gc+0xff8>
    4e37:	74 01                	je     4e3a <fwp_gc_collect+0xa>
    4e39:	c3                   	ret
    4e3a:	55                   	push   %rbp
    4e3b:	48 89 e5             	mov    %rsp,%rbp
    4e3e:	41 57                	push   %r15
    4e40:	41 56                	push   %r14
    4e42:	41 55                	push   %r13
    4e44:	41 54                	push   %r12
    4e46:	53                   	push   %rbx
    4e47:	48 81 ec e8 00 00 00 	sub    $0xe8,%rsp
    4e4e:	c7 05 38 04 01 00 01 	movl   $0x1,0x10438(%rip)        # 15290 <fwp_gc+0xff8>
    4e55:	00 00 00 
    4e58:	48 8d 75 b8          	lea    -0x48(%rbp),%rsi
    4e5c:	bf 01 00 00 00       	mov    $0x1,%edi
    4e61:	e8 ca e2 ff ff       	call   3130 <clock_gettime@plt>
    4e66:	48 8b 05 3b 06 01 00 	mov    0x1063b(%rip),%rax        # 154a8 <fwp_gc+0x1210>
    4e6d:	48 2b 05 24 f4 00 00 	sub    0xf424(%rip),%rax        # 14298 <fwp_gc>
    4e74:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    4e79:	f2 0f 58 05 ff 05 01 	addsd  0x105ff(%rip),%xmm0        # 15480 <fwp_gc+0x11e8>
    4e80:	00 
    4e81:	f2 0f 11 05 f7 05 01 	movsd  %xmm0,0x105f7(%rip)        # 15480 <fwp_gc+0x11e8>
    4e88:	00 
    4e89:	83 3d 08 04 01 00 00 	cmpl   $0x0,0x10408(%rip)        # 15298 <fwp_gc+0x1000>
    4e90:	0f 94 c0             	sete   %al
    4e93:	83 3d 06 04 01 00 00 	cmpl   $0x0,0x10406(%rip)        # 152a0 <fwp_gc+0x1008>
    4e9a:	0f 95 c3             	setne  %bl
    4e9d:	08 c3                	or     %al,%bl
    4e9f:	80 fb 01             	cmp    $0x1,%bl
    4ea2:	75 3e                	jne    4ee2 <fwp_gc_collect+0xb2>
    4ea4:	e8 b7 01 00 00       	call   5060 <fwp_gc_clear_marks>
    4ea9:	48 8d bd f0 fe ff ff 	lea    -0x110(%rbp),%rdi
    4eb0:	e8 fb e3 ff ff       	call   32b0 <_setjmp@plt>
    4eb5:	48 c7 05 d8 05 01 00 	movq   $0x0,0x105d8(%rip)        # 15498 <fwp_gc+0x1200>
    4ebc:	00 00 00 00 
    4ec0:	e8 1b 02 00 00       	call   50e0 <fwp_gc_mark_all>
    4ec5:	e8 36 07 00 00       	call   5600 <fwp_gc_finalize>
    4eca:	e8 c1 07 00 00       	call   5690 <fwp_gc_sweep>
    4ecf:	48 8b 05 9a 05 01 00 	mov    0x1059a(%rip),%rax        # 15470 <fwp_gc+0x11d8>
    4ed6:	48 ff c0             	inc    %rax
    4ed9:	48 89 05 90 05 01 00 	mov    %rax,0x10590(%rip)        # 15470 <fwp_gc+0x11d8>
    4ee0:	eb 51                	jmp    4f33 <fwp_gc_collect+0x103>
    4ee2:	48 8d bd f0 fe ff ff 	lea    -0x110(%rbp),%rdi
    4ee9:	e8 c2 e3 ff ff       	call   32b0 <_setjmp@plt>
    4eee:	48 c7 05 9f 05 01 00 	movq   $0x0,0x1059f(%rip)        # 15498 <fwp_gc+0x1200>
    4ef5:	00 00 00 00 
    4ef9:	e8 e2 01 00 00       	call   50e0 <fwp_gc_mark_all>
    4efe:	e8 fd 01 00 00       	call   5100 <fwp_gc_scan_old_filled>
    4f03:	83 3d 92 03 01 00 00 	cmpl   $0x0,0x10392(%rip)        # 1529c <fwp_gc+0x1004>
    4f0a:	74 05                	je     4f11 <fwp_gc_collect+0xe1>
    4f0c:	e8 2f 03 00 00       	call   5240 <fwp_gc_verify_minor>
    4f11:	e8 ea 06 00 00       	call   5600 <fwp_gc_finalize>
    4f16:	e8 75 07 00 00       	call   5690 <fwp_gc_sweep>
    4f1b:	48 8b 05 4e 05 01 00 	mov    0x1054e(%rip),%rax        # 15470 <fwp_gc+0x11d8>
    4f22:	48 ff c0             	inc    %rax
    4f25:	48 89 05 44 05 01 00 	mov    %rax,0x10544(%rip)        # 15470 <fwp_gc+0x11d8>
    4f2c:	48 ff 05 7d 03 01 00 	incq   0x1037d(%rip)        # 152b0 <fwp_gc+0x1018>
    4f33:	48 89 c1             	mov    %rax,%rcx
    4f36:	48 8b 05 23 05 01 00 	mov    0x10523(%rip),%rax        # 15460 <fwp_gc+0x11c8>
    4f3d:	48 3b 05 24 05 01 00 	cmp    0x10524(%rip),%rax        # 15468 <fwp_gc+0x11d0>
    4f44:	76 07                	jbe    4f4d <fwp_gc_collect+0x11d>
    4f46:	48 89 05 1b 05 01 00 	mov    %rax,0x1051b(%rip)        # 15468 <fwp_gc+0x11d0>
    4f4d:	84 db                	test   %bl,%bl
    4f4f:	74 0b                	je     4f5c <fwp_gc_collect+0x12c>
    4f51:	48 89 05 50 03 01 00 	mov    %rax,0x10350(%rip)        # 152a8 <fwp_gc+0x1010>
    4f58:	31 d2                	xor    %edx,%edx
    4f5a:	eb 2d                	jmp    4f89 <fwp_gc_collect+0x159>
    4f5c:	48 8b 15 45 03 01 00 	mov    0x10345(%rip),%rdx        # 152a8 <fwp_gc+0x1010>
    4f63:	48 89 d6             	mov    %rdx,%rsi
    4f66:	48 d1 ee             	shr    $1,%rsi
    4f69:	48 01 d6             	add    %rdx,%rsi
    4f6c:	48 81 fe 01 00 00 01 	cmp    $0x1000001,%rsi
    4f73:	ba 00 00 00 01       	mov    $0x1000000,%edx
    4f78:	48 0f 43 d6          	cmovae %rsi,%rdx
    4f7c:	31 f6                	xor    %esi,%esi
    4f7e:	48 39 d0             	cmp    %rdx,%rax
    4f81:	0f 97 c2             	seta   %dl
    4f84:	40 88 d6             	mov    %dl,%sil
    4f87:	89 f2                	mov    %esi,%edx
    4f89:	f6 c1 07             	test   $0x7,%cl
    4f8c:	b9 01 00 00 00       	mov    $0x1,%ecx
    4f91:	0f 45 ca             	cmovne %edx,%ecx
    4f94:	48 83 3d 1c 03 01 00 	cmpq   $0x0,0x1031c(%rip)        # 152b8 <fwp_gc+0x1020>
    4f9b:	00 
    4f9c:	0f 44 ca             	cmove  %edx,%ecx
    4f9f:	89 0d fb 02 01 00    	mov    %ecx,0x102fb(%rip)        # 152a0 <fwp_gc+0x1008>
    4fa5:	83 3d ec 02 01 00 00 	cmpl   $0x0,0x102ec(%rip)        # 15298 <fwp_gc+0x1000>
    4fac:	0f 94 c1             	sete   %cl
    4faf:	48 d3 e0             	shl    %cl,%rax
    4fb2:	f2 48 0f 2c 0d dd 04 	cvttsd2si 0x104dd(%rip),%rcx        # 15498 <fwp_gc+0x1200>
    4fb9:	01 00 
    4fbb:	48 01 c1             	add    %rax,%rcx
    4fbe:	48 81 f9 01 00 80 00 	cmp    $0x800001,%rcx
    4fc5:	b8 00 00 80 00       	mov    $0x800000,%eax
    4fca:	48 0f 4d c1          	cmovge %rcx,%rax
    4fce:	48 89 05 d3 04 01 00 	mov    %rax,0x104d3(%rip)        # 154a8 <fwp_gc+0x1210>
    4fd5:	48 89 05 bc f2 00 00 	mov    %rax,0xf2bc(%rip)        # 14298 <fwp_gc>
    4fdc:	48 8d 75 c8          	lea    -0x38(%rbp),%rsi
    4fe0:	bf 01 00 00 00       	mov    $0x1,%edi
    4fe5:	e8 46 e1 ff ff       	call   3130 <clock_gettime@plt>
    4fea:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    4fee:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
    4ff2:	48 2b 45 b8          	sub    -0x48(%rbp),%rax
    4ff6:	f2 48 0f 2a c8       	cvtsi2sd %rax,%xmm1
    4ffb:	f2 0f 59 0d 4d 91 00 	mulsd  0x914d(%rip),%xmm1        # e150 <_IO_stdin_used+0x150>
    5002:	00 
    5003:	48 2b 4d c0          	sub    -0x40(%rbp),%rcx
    5007:	0f 57 c0             	xorps  %xmm0,%xmm0
    500a:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    500f:	f2 0f 5e 05 41 91 00 	divsd  0x9141(%rip),%xmm0        # e158 <_IO_stdin_used+0x158>
    5016:	00 
    5017:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
    501b:	f2 0f 10 0d 65 04 01 	movsd  0x10465(%rip),%xmm1        # 15488 <fwp_gc+0x11f0>
    5022:	00 
    5023:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
    5027:	f2 0f 11 0d 59 04 01 	movsd  %xmm1,0x10459(%rip)        # 15488 <fwp_gc+0x11f0>
    502e:	00 
    502f:	66 0f 2e 05 59 04 01 	ucomisd 0x10459(%rip),%xmm0        # 15490 <fwp_gc+0x11f8>
    5036:	00 
    5037:	48 8d a4 24 e8 00 00 	lea    0xe8(%rsp),%rsp
    503e:	00 
    503f:	5b                   	pop    %rbx
    5040:	41 5c                	pop    %r12
    5042:	41 5d                	pop    %r13
    5044:	41 5e                	pop    %r14
    5046:	41 5f                	pop    %r15
    5048:	5d                   	pop    %rbp
    5049:	76 08                	jbe    5053 <fwp_gc_collect+0x223>
    504b:	f2 0f 11 05 3d 04 01 	movsd  %xmm0,0x1043d(%rip)        # 15490 <fwp_gc+0x11f8>
    5052:	00 
    5053:	c7 05 33 02 01 00 00 	movl   $0x0,0x10233(%rip)        # 15290 <fwp_gc+0xff8>
    505a:	00 00 00 
    505d:	c3                   	ret
    505e:	66 90                	xchg   %ax,%ax

0000000000005060 <fwp_gc_clear_marks>:
    5060:	48 8b 05 89 02 01 00 	mov    0x10289(%rip),%rax        # 152f0 <fwp_gc+0x1058>
    5067:	48 85 c0             	test   %rax,%rax
    506a:	74 69                	je     50d5 <fwp_gc_clear_marks+0x75>
    506c:	41 56                	push   %r14
    506e:	53                   	push   %rbx
    506f:	50                   	push   %rax
    5070:	48 8b 0d 99 02 01 00 	mov    0x10299(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    5077:	31 db                	xor    %ebx,%ebx
    5079:	45 31 f6             	xor    %r14d,%r14d
    507c:	eb 16                	jmp    5094 <fwp_gc_clear_marks+0x34>
    507e:	66 90                	xchg   %ax,%ax
    5080:	c6 44 19 03 00       	movb   $0x0,0x3(%rcx,%rbx,1)
    5085:	49 ff c6             	inc    %r14
    5088:	48 81 c3 28 12 00 00 	add    $0x1228,%rbx
    508f:	49 39 c6             	cmp    %rax,%r14
    5092:	73 3a                	jae    50ce <fwp_gc_clear_marks+0x6e>
    5094:	0f b6 14 19          	movzbl (%rcx,%rbx,1),%edx
    5098:	83 fa 02             	cmp    $0x2,%edx
    509b:	74 e3                	je     5080 <fwp_gc_clear_marks+0x20>
    509d:	83 fa 01             	cmp    $0x1,%edx
    50a0:	75 e3                	jne    5085 <fwp_gc_clear_marks+0x25>
    50a2:	48 8d 3c 19          	lea    (%rcx,%rbx,1),%rdi
    50a6:	48 83 c7 28          	add    $0x28,%rdi
    50aa:	8b 54 19 0c          	mov    0xc(%rcx,%rbx,1),%edx
    50ae:	83 c2 3f             	add    $0x3f,%edx
    50b1:	c1 ea 03             	shr    $0x3,%edx
    50b4:	83 e2 f8             	and    $0xfffffff8,%edx
    50b7:	31 f6                	xor    %esi,%esi
    50b9:	e8 52 e1 ff ff       	call   3210 <memset@plt>
    50be:	48 8b 0d 4b 02 01 00 	mov    0x1024b(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    50c5:	48 8b 05 24 02 01 00 	mov    0x10224(%rip),%rax        # 152f0 <fwp_gc+0x1058>
    50cc:	eb b7                	jmp    5085 <fwp_gc_clear_marks+0x25>
    50ce:	48 83 c4 08          	add    $0x8,%rsp
    50d2:	5b                   	pop    %rbx
    50d3:	41 5e                	pop    %r14
    50d5:	c3                   	ret
    50d6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    50dd:	00 00 00 

00000000000050e0 <fwp_gc_mark_all>:
    50e0:	50                   	push   %rax
    50e1:	e8 4a 0c 00 00       	call   5d30 <fwp_gc_sp>
    50e6:	48 89 c7             	mov    %rax,%rdi
    50e9:	e8 32 0c 00 00       	call   5d20 <fwp_gc_scan_stacks>
    50ee:	e8 4d 0c 00 00       	call   5d40 <fwp_gc_drain>
    50f3:	e8 98 0c 00 00       	call   5d90 <fwp_gc_scan_data>
    50f8:	58                   	pop    %rax
    50f9:	e9 42 0c 00 00       	jmp    5d40 <fwp_gc_drain>
    50fe:	66 90                	xchg   %ax,%ax

0000000000005100 <fwp_gc_scan_old_filled>:
    5100:	48 83 3d e8 01 01 00 	cmpq   $0x0,0x101e8(%rip)        # 152f0 <fwp_gc+0x1058>
    5107:	00 
    5108:	0f 84 32 0c 00 00    	je     5d40 <fwp_gc_drain>
    510e:	55                   	push   %rbp
    510f:	41 57                	push   %r15
    5111:	41 56                	push   %r14
    5113:	41 55                	push   %r13
    5115:	41 54                	push   %r12
    5117:	53                   	push   %rbx
    5118:	48 83 ec 18          	sub    $0x18,%rsp
    511c:	31 c0                	xor    %eax,%eax
    511e:	eb 14                	jmp    5134 <fwp_gc_scan_old_filled+0x34>
    5120:	48 8b 04 24          	mov    (%rsp),%rax
    5124:	48 ff c0             	inc    %rax
    5127:	48 3b 05 c2 01 01 00 	cmp    0x101c2(%rip),%rax        # 152f0 <fwp_gc+0x1058>
    512e:	0f 83 f6 00 00 00    	jae    522a <fwp_gc_scan_old_filled+0x12a>
    5134:	48 8b 0d d5 01 01 00 	mov    0x101d5(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    513b:	48 89 04 24          	mov    %rax,(%rsp)
    513f:	48 69 e8 28 12 00 00 	imul   $0x1228,%rax,%rbp
    5146:	80 7c 29 01 02       	cmpb   $0x2,0x1(%rcx,%rbp,1)
    514b:	75 d3                	jne    5120 <fwp_gc_scan_old_filled+0x20>
    514d:	48 89 cb             	mov    %rcx,%rbx
    5150:	0f b6 04 29          	movzbl (%rcx,%rbp,1),%eax
    5154:	83 f8 02             	cmp    $0x2,%eax
    5157:	0f 84 a7 00 00 00    	je     5204 <fwp_gc_scan_old_filled+0x104>
    515d:	83 f8 01             	cmp    $0x1,%eax
    5160:	75 be                	jne    5120 <fwp_gc_scan_old_filled+0x20>
    5162:	48 8b 3c 24          	mov    (%rsp),%rdi
    5166:	e8 25 ef ff ff       	call   4090 <fwp_gc_chunk_addr>
    516b:	49 89 c6             	mov    %rax,%r14
    516e:	8b 44 2b 0c          	mov    0xc(%rbx,%rbp,1),%eax
    5172:	83 c0 3f             	add    $0x3f,%eax
    5175:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    517a:	83 f8 40             	cmp    $0x40,%eax
    517d:	72 a1                	jb     5120 <fwp_gc_scan_old_filled+0x20>
    517f:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    5184:	c1 e8 06             	shr    $0x6,%eax
    5187:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    518c:	4c 8d 2c 2b          	lea    (%rbx,%rbp,1),%r13
    5190:	49 83 c5 08          	add    $0x8,%r13
    5194:	48 01 eb             	add    %rbp,%rbx
    5197:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
    519c:	45 31 ff             	xor    %r15d,%r15d
    519f:	eb 1d                	jmp    51be <fwp_gc_scan_old_filled+0xbe>
    51a1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    51a8:	0f 1f 84 00 00 00 00 
    51af:	00 
    51b0:	49 ff c7             	inc    %r15
    51b3:	4c 3b 7c 24 08       	cmp    0x8(%rsp),%r15
    51b8:	0f 84 62 ff ff ff    	je     5120 <fwp_gc_scan_old_filled+0x20>
    51be:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    51c3:	4e 8b 64 f8 28       	mov    0x28(%rax,%r15,8),%r12
    51c8:	4d 85 e4             	test   %r12,%r12
    51cb:	74 e3                	je     51b0 <fwp_gc_scan_old_filled+0xb0>
    51cd:	4c 89 fd             	mov    %r15,%rbp
    51d0:	48 c1 e5 06          	shl    $0x6,%rbp
    51d4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    51db:	00 00 00 00 00 
    51e0:	f3 49 0f bc fc       	tzcnt  %r12,%rdi
    51e5:	48 09 ef             	or     %rbp,%rdi
    51e8:	49 8d 5c 24 ff       	lea    -0x1(%r12),%rbx
    51ed:	41 8b 75 00          	mov    0x0(%r13),%esi
    51f1:	48 0f af fe          	imul   %rsi,%rdi
    51f5:	4c 01 f7             	add    %r14,%rdi
    51f8:	e8 03 0e 00 00       	call   6000 <fwp_gc_push>
    51fd:	49 21 dc             	and    %rbx,%r12
    5200:	75 de                	jne    51e0 <fwp_gc_scan_old_filled+0xe0>
    5202:	eb ac                	jmp    51b0 <fwp_gc_scan_old_filled+0xb0>
    5204:	80 7c 2b 03 00       	cmpb   $0x0,0x3(%rbx,%rbp,1)
    5209:	0f 84 11 ff ff ff    	je     5120 <fwp_gc_scan_old_filled+0x20>
    520f:	48 8b 3c 24          	mov    (%rsp),%rdi
    5213:	e8 78 ee ff ff       	call   4090 <fwp_gc_chunk_addr>
    5218:	48 8b 74 2b 18       	mov    0x18(%rbx,%rbp,1),%rsi
    521d:	48 89 c7             	mov    %rax,%rdi
    5220:	e8 db 0d 00 00       	call   6000 <fwp_gc_push>
    5225:	e9 f6 fe ff ff       	jmp    5120 <fwp_gc_scan_old_filled+0x20>
    522a:	48 83 c4 18          	add    $0x18,%rsp
    522e:	5b                   	pop    %rbx
    522f:	41 5c                	pop    %r12
    5231:	41 5d                	pop    %r13
    5233:	41 5e                	pop    %r14
    5235:	41 5f                	pop    %r15
    5237:	5d                   	pop    %rbp
    5238:	e9 03 0b 00 00       	jmp    5d40 <fwp_gc_drain>
    523d:	0f 1f 00             	nopl   (%rax)

0000000000005240 <fwp_gc_verify_minor>:
    5240:	55                   	push   %rbp
    5241:	41 57                	push   %r15
    5243:	41 56                	push   %r14
    5245:	41 55                	push   %r13
    5247:	41 54                	push   %r12
    5249:	53                   	push   %rbx
    524a:	48 83 ec 58          	sub    $0x58,%rsp
    524e:	4c 8b 2d 9b 00 01 00 	mov    0x1009b(%rip),%r13        # 152f0 <fwp_gc+0x1058>
    5255:	4c 89 ef             	mov    %r13,%rdi
    5258:	48 c1 e7 09          	shl    $0x9,%rdi
    525c:	e8 df e0 ff ff       	call   3340 <malloc@plt>
    5261:	48 89 c3             	mov    %rax,%rbx
    5264:	49 83 fd 01          	cmp    $0x1,%r13
    5268:	4c 89 ef             	mov    %r13,%rdi
    526b:	48 83 d7 00          	adc    $0x0,%rdi
    526f:	48 89 7c 24 30       	mov    %rdi,0x30(%rsp)
    5274:	e8 c7 e0 ff ff       	call   3340 <malloc@plt>
    5279:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
    527e:	48 85 db             	test   %rbx,%rbx
    5281:	0f 84 74 03 00 00    	je     55fb <fwp_gc_verify_minor+0x3bb>
    5287:	49 89 c7             	mov    %rax,%r15
    528a:	48 85 c0             	test   %rax,%rax
    528d:	0f 84 68 03 00 00    	je     55fb <fwp_gc_verify_minor+0x3bb>
    5293:	4d 85 ed             	test   %r13,%r13
    5296:	74 1c                	je     52b4 <fwp_gc_verify_minor+0x74>
    5298:	48 8b 0d 71 00 01 00 	mov    0x10071(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    529f:	49 83 fd 01          	cmp    $0x1,%r13
    52a3:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
    52a8:	75 19                	jne    52c3 <fwp_gc_verify_minor+0x83>
    52aa:	4d 89 ec             	mov    %r13,%r12
    52ad:	31 ed                	xor    %ebp,%ebp
    52af:	e9 81 00 00 00       	jmp    5335 <fwp_gc_verify_minor+0xf5>
    52b4:	e8 a7 fd ff ff       	call   5060 <fwp_gc_clear_marks>
    52b9:	e8 22 fe ff ff       	call   50e0 <fwp_gc_mark_all>
    52be:	e9 13 03 00 00       	jmp    55d6 <fwp_gc_verify_minor+0x396>
    52c3:	4d 89 ec             	mov    %r13,%r12
    52c6:	49 83 e5 fe          	and    $0xfffffffffffffffe,%r13
    52ca:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    52cf:	48 8d 98 00 02 00 00 	lea    0x200(%rax),%rbx
    52d6:	4c 8d b1 50 12 00 00 	lea    0x1250(%rcx),%r14
    52dd:	31 ed                	xor    %ebp,%ebp
    52df:	90                   	nop
    52e0:	48 8d bb 00 fe ff ff 	lea    -0x200(%rbx),%rdi
    52e7:	49 8d b6 d8 ed ff ff 	lea    -0x1228(%r14),%rsi
    52ee:	ba 00 02 00 00       	mov    $0x200,%edx
    52f3:	e8 38 e0 ff ff       	call   3330 <memcpy@plt>
    52f8:	41 0f b6 86 b3 ed ff 	movzbl -0x124d(%r14),%eax
    52ff:	ff 
    5300:	41 88 04 2f          	mov    %al,(%r15,%rbp,1)
    5304:	ba 00 02 00 00       	mov    $0x200,%edx
    5309:	48 89 df             	mov    %rbx,%rdi
    530c:	4c 89 f6             	mov    %r14,%rsi
    530f:	e8 1c e0 ff ff       	call   3330 <memcpy@plt>
    5314:	41 0f b6 46 db       	movzbl -0x25(%r14),%eax
    5319:	41 88 44 2f 01       	mov    %al,0x1(%r15,%rbp,1)
    531e:	48 83 c5 02          	add    $0x2,%rbp
    5322:	48 81 c3 00 04 00 00 	add    $0x400,%rbx
    5329:	49 81 c6 50 24 00 00 	add    $0x2450,%r14
    5330:	49 39 ed             	cmp    %rbp,%r13
    5333:	75 ab                	jne    52e0 <fwp_gc_verify_minor+0xa0>
    5335:	4d 89 e5             	mov    %r12,%r13
    5338:	41 f6 c5 01          	test   $0x1,%r13b
    533c:	74 34                	je     5372 <fwp_gc_verify_minor+0x132>
    533e:	48 89 ef             	mov    %rbp,%rdi
    5341:	48 c1 e7 09          	shl    $0x9,%rdi
    5345:	48 03 7c 24 20       	add    0x20(%rsp),%rdi
    534a:	48 69 dd 28 12 00 00 	imul   $0x1228,%rbp,%rbx
    5351:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    5356:	49 8d 34 1e          	lea    (%r14,%rbx,1),%rsi
    535a:	48 83 c6 28          	add    $0x28,%rsi
    535e:	ba 00 02 00 00       	mov    $0x200,%edx
    5363:	e8 c8 df ff ff       	call   3330 <memcpy@plt>
    5368:	41 0f b6 44 1e 03    	movzbl 0x3(%r14,%rbx,1),%eax
    536e:	41 88 04 2f          	mov    %al,(%r15,%rbp,1)
    5372:	e8 e9 fc ff ff       	call   5060 <fwp_gc_clear_marks>
    5377:	e8 64 fd ff ff       	call   50e0 <fwp_gc_mark_all>
    537c:	4d 85 ed             	test   %r13,%r13
    537f:	0f 84 51 02 00 00    	je     55d6 <fwp_gc_verify_minor+0x396>
    5385:	48 8b 1d 84 ff 00 00 	mov    0xff84(%rip),%rbx        # 15310 <fwp_gc+0x1078>
    538c:	48 8d 43 28          	lea    0x28(%rbx),%rax
    5390:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    5395:	31 ff                	xor    %edi,%edi
    5397:	eb 30                	jmp    53c9 <fwp_gc_verify_minor+0x189>
    5399:	4d 85 c9             	test   %r9,%r9
    539c:	0f 85 b8 00 00 00    	jne    545a <fwp_gc_verify_minor+0x21a>
    53a2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    53a9:	1f 84 00 00 00 00 00 
    53b0:	48 ff c7             	inc    %rdi
    53b3:	48 81 c1 00 02 00 00 	add    $0x200,%rcx
    53ba:	48 05 28 12 00 00    	add    $0x1228,%rax
    53c0:	4c 39 ef             	cmp    %r13,%rdi
    53c3:	0f 84 0d 02 00 00    	je     55d6 <fwp_gc_verify_minor+0x396>
    53c9:	4c 69 f7 28 12 00 00 	imul   $0x1228,%rdi,%r14
    53d0:	42 0f b6 2c 33       	movzbl (%rbx,%r14,1),%ebp
    53d5:	83 fd 02             	cmp    $0x2,%ebp
    53d8:	74 66                	je     5440 <fwp_gc_verify_minor+0x200>
    53da:	83 fd 01             	cmp    $0x1,%ebp
    53dd:	75 d1                	jne    53b0 <fwp_gc_verify_minor+0x170>
    53df:	42 8b 54 33 0c       	mov    0xc(%rbx,%r14,1),%edx
    53e4:	83 c2 3f             	add    $0x3f,%edx
    53e7:	83 fa 40             	cmp    $0x40,%edx
    53ea:	72 c4                	jb     53b0 <fwp_gc_verify_minor+0x170>
    53ec:	c1 ea 06             	shr    $0x6,%edx
    53ef:	31 f6                	xor    %esi,%esi
    53f1:	45 31 e4             	xor    %r12d,%r12d
    53f4:	45 31 c0             	xor    %r8d,%r8d
    53f7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    53fe:	00 00 
    5400:	4e 8b 0c c1          	mov    (%rcx,%r8,8),%r9
    5404:	49 f7 d1             	not    %r9
    5407:	4e 23 0c c0          	and    (%rax,%r8,8),%r9
    540b:	4d 89 e2             	mov    %r12,%r10
    540e:	f3 4d 0f bc e1       	tzcnt  %r9,%r12
    5413:	49 01 f4             	add    %rsi,%r12
    5416:	4d 85 c9             	test   %r9,%r9
    5419:	4d 0f 44 e2          	cmove  %r10,%r12
    541d:	49 ff c0             	inc    %r8
    5420:	49 39 d0             	cmp    %rdx,%r8
    5423:	0f 83 70 ff ff ff    	jae    5399 <fwp_gc_verify_minor+0x159>
    5429:	48 83 c6 40          	add    $0x40,%rsi
    542d:	4d 85 c9             	test   %r9,%r9
    5430:	74 ce                	je     5400 <fwp_gc_verify_minor+0x1c0>
    5432:	e9 62 ff ff ff       	jmp    5399 <fwp_gc_verify_minor+0x159>
    5437:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    543e:	00 00 
    5440:	42 80 7c 33 03 00    	cmpb   $0x0,0x3(%rbx,%r14,1)
    5446:	0f 84 64 ff ff ff    	je     53b0 <fwp_gc_verify_minor+0x170>
    544c:	41 80 3c 3f 00       	cmpb   $0x0,(%r15,%rdi,1)
    5451:	0f 85 59 ff ff ff    	jne    53b0 <fwp_gc_verify_minor+0x170>
    5457:	45 31 e4             	xor    %r12d,%r12d
    545a:	e8 31 ec ff ff       	call   4090 <fwp_gc_chunk_addr>
    545f:	46 8b 7c 33 08       	mov    0x8(%rbx,%r14,1),%r15d
    5464:	4d 0f af e7          	imul   %r15,%r12
    5468:	49 01 c4             	add    %rax,%r12
    546b:	40 80 fd 01          	cmp    $0x1,%bpl
    546f:	74 05                	je     5476 <fwp_gc_verify_minor+0x236>
    5471:	4e 8b 7c 33 18       	mov    0x18(%rbx,%r14,1),%r15
    5476:	48 8b 05 5b eb 00 00 	mov    0xeb5b(%rip),%rax        # 13fd8 <stderr@GLIBC_2.2.5>
    547d:	48 8b 38             	mov    (%rax),%rdi
    5480:	42 0f b6 4c 33 01    	movzbl 0x1(%rbx,%r14,1),%ecx
    5486:	48 8d 35 5a 94 00 00 	lea    0x945a(%rip),%rsi        # e8e7 <exec_in_fp0+0x1e7>
    548d:	4c 89 e2             	mov    %r12,%rdx
    5490:	4d 89 f8             	mov    %r15,%r8
    5493:	31 c0                	xor    %eax,%eax
    5495:	e8 56 de ff ff       	call   32f0 <fprintf@plt>
    549a:	4d 01 e7             	add    %r12,%r15
    549d:	45 31 ed             	xor    %r13d,%r13d
    54a0:	4c 89 7c 24 40       	mov    %r15,0x40(%rsp)
    54a5:	eb 17                	jmp    54be <fwp_gc_verify_minor+0x27e>
    54a7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    54ae:	00 00 
    54b0:	49 ff c5             	inc    %r13
    54b3:	4c 3b 6c 24 30       	cmp    0x30(%rsp),%r13
    54b8:	0f 84 38 01 00 00    	je     55f6 <fwp_gc_verify_minor+0x3b6>
    54be:	48 8b 05 4b fe 00 00 	mov    0xfe4b(%rip),%rax        # 15310 <fwp_gc+0x1078>
    54c5:	49 69 cd 28 12 00 00 	imul   $0x1228,%r13,%rcx
    54cc:	80 3c 08 01          	cmpb   $0x1,(%rax,%rcx,1)
    54d0:	75 de                	jne    54b0 <fwp_gc_verify_minor+0x270>
    54d2:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    54d7:	74 d7                	je     54b0 <fwp_gc_verify_minor+0x270>
    54d9:	8b 5c 08 0c          	mov    0xc(%rax,%rcx,1),%ebx
    54dd:	85 db                	test   %ebx,%ebx
    54df:	74 cf                	je     54b0 <fwp_gc_verify_minor+0x270>
    54e1:	48 01 c8             	add    %rcx,%rax
    54e4:	48 ff c0             	inc    %rax
    54e7:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    54ec:	4c 89 e8             	mov    %r13,%rax
    54ef:	48 c1 e0 09          	shl    $0x9,%rax
    54f3:	48 03 44 24 20       	add    0x20(%rsp),%rax
    54f8:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    54fd:	31 ed                	xor    %ebp,%ebp
    54ff:	4c 89 6c 24 38       	mov    %r13,0x38(%rsp)
    5504:	eb 21                	jmp    5527 <fwp_gc_verify_minor+0x2e7>
    5506:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    550d:	00 00 00 
    5510:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    5515:	8b 58 0b             	mov    0xb(%rax),%ebx
    5518:	4c 8b 6c 24 38       	mov    0x38(%rsp),%r13
    551d:	48 ff c5             	inc    %rbp
    5520:	89 d8                	mov    %ebx,%eax
    5522:	48 39 c5             	cmp    %rax,%rbp
    5525:	73 89                	jae    54b0 <fwp_gc_verify_minor+0x270>
    5527:	48 89 e8             	mov    %rbp,%rax
    552a:	48 c1 e8 06          	shr    $0x6,%rax
    552e:	48 8b 4c 24 50       	mov    0x50(%rsp),%rcx
    5533:	48 8b 04 c1          	mov    (%rcx,%rax,8),%rax
    5537:	48 0f a3 e8          	bt     %rbp,%rax
    553b:	73 e0                	jae    551d <fwp_gc_verify_minor+0x2dd>
    553d:	4c 89 ef             	mov    %r13,%rdi
    5540:	e8 4b eb ff ff       	call   4090 <fwp_gc_chunk_addr>
    5545:	48 89 c2             	mov    %rax,%rdx
    5548:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    554d:	44 8b 70 07          	mov    0x7(%rax),%r14d
    5551:	49 83 fe 08          	cmp    $0x8,%r14
    5555:	72 c6                	jb     551d <fwp_gc_verify_minor+0x2dd>
    5557:	45 89 f0             	mov    %r14d,%r8d
    555a:	4c 0f af f5          	imul   %rbp,%r14
    555e:	48 89 d3             	mov    %rdx,%rbx
    5561:	4c 01 f3             	add    %r14,%rbx
    5564:	45 31 ed             	xor    %r13d,%r13d
    5567:	48 89 54 24 48       	mov    %rdx,0x48(%rsp)
    556c:	eb 10                	jmp    557e <fwp_gc_verify_minor+0x33e>
    556e:	66 90                	xchg   %ax,%ax
    5570:	49 ff c5             	inc    %r13
    5573:	44 89 c0             	mov    %r8d,%eax
    5576:	c1 e8 03             	shr    $0x3,%eax
    5579:	49 39 c5             	cmp    %rax,%r13
    557c:	73 92                	jae    5510 <fwp_gc_verify_minor+0x2d0>
    557e:	4a 8b 04 eb          	mov    (%rbx,%r13,8),%rax
    5582:	4c 39 e0             	cmp    %r12,%rax
    5585:	72 e9                	jb     5570 <fwp_gc_verify_minor+0x330>
    5587:	4c 39 f8             	cmp    %r15,%rax
    558a:	73 e4                	jae    5570 <fwp_gc_verify_minor+0x330>
    558c:	48 8b 05 45 ea 00 00 	mov    0xea45(%rip),%rax        # 13fd8 <stderr@GLIBC_2.2.5>
    5593:	48 8b 38             	mov    (%rax),%rdi
    5596:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
    559b:	41 0f b6 0f          	movzbl (%r15),%ecx
    559f:	42 0f 10 04 32       	movups (%rdx,%r14,1),%xmm0
    55a4:	4a 8b 44 32 10       	mov    0x10(%rdx,%r14,1),%rax
    55a9:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    55ae:	0f 11 04 24          	movups %xmm0,(%rsp)
    55b2:	48 8d 35 88 93 00 00 	lea    0x9388(%rip),%rsi        # e941 <exec_in_fp0+0x241>
    55b9:	48 89 da             	mov    %rbx,%rdx
    55bc:	4d 89 e9             	mov    %r13,%r9
    55bf:	31 c0                	xor    %eax,%eax
    55c1:	e8 2a dd ff ff       	call   32f0 <fprintf@plt>
    55c6:	48 8b 54 24 48       	mov    0x48(%rsp),%rdx
    55cb:	45 8b 47 07          	mov    0x7(%r15),%r8d
    55cf:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
    55d4:	eb 9a                	jmp    5570 <fwp_gc_verify_minor+0x330>
    55d6:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    55db:	e8 70 da ff ff       	call   3050 <free@plt>
    55e0:	4c 89 ff             	mov    %r15,%rdi
    55e3:	48 83 c4 58          	add    $0x58,%rsp
    55e7:	5b                   	pop    %rbx
    55e8:	41 5c                	pop    %r12
    55ea:	41 5d                	pop    %r13
    55ec:	41 5e                	pop    %r14
    55ee:	41 5f                	pop    %r15
    55f0:	5d                   	pop    %rbp
    55f1:	e9 5a da ff ff       	jmp    3050 <free@plt>
    55f6:	e8 75 da ff ff       	call   3070 <abort@plt>
    55fb:	e8 80 f6 ff ff       	call   4c80 <fwp_gc_oom>

0000000000005600 <fwp_gc_finalize>:
    5600:	41 57                	push   %r15
    5602:	41 56                	push   %r14
    5604:	41 55                	push   %r13
    5606:	41 54                	push   %r12
    5608:	53                   	push   %rbx
    5609:	4c 8b 3d 40 fe 00 00 	mov    0xfe40(%rip),%r15        # 15450 <fwp_gc+0x11b8>
    5610:	4d 85 ff             	test   %r15,%r15
    5613:	74 71                	je     5686 <fwp_gc_finalize+0x86>
    5615:	4c 8b 25 2c fe 00 00 	mov    0xfe2c(%rip),%r12        # 15448 <fwp_gc+0x11b0>
    561c:	45 31 f6             	xor    %r14d,%r14d
    561f:	eb 46                	jmp    5667 <fwp_gc_finalize+0x67>
    5621:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5628:	0f 1f 84 00 00 00 00 
    562f:	00 
    5630:	4d 01 e5             	add    %r12,%r13
    5633:	49 8b 45 08          	mov    0x8(%r13),%rax
    5637:	49 ff cf             	dec    %r15
    563a:	4c 89 3d 0f fe 00 00 	mov    %r15,0xfe0f(%rip)        # 15450 <fwp_gc+0x11b8>
    5641:	49 c1 e7 04          	shl    $0x4,%r15
    5645:	43 0f 10 04 3c       	movups (%r12,%r15,1),%xmm0
    564a:	41 0f 11 45 00       	movups %xmm0,0x0(%r13)
    564f:	48 89 df             	mov    %rbx,%rdi
    5652:	ff d0                	call   *%rax
    5654:	4c 8b 25 ed fd 00 00 	mov    0xfded(%rip),%r12        # 15448 <fwp_gc+0x11b0>
    565b:	4c 8b 3d ee fd 00 00 	mov    0xfdee(%rip),%r15        # 15450 <fwp_gc+0x11b8>
    5662:	4d 39 fe             	cmp    %r15,%r14
    5665:	73 1f                	jae    5686 <fwp_gc_finalize+0x86>
    5667:	4d 89 f5             	mov    %r14,%r13
    566a:	49 c1 e5 04          	shl    $0x4,%r13
    566e:	4b 8b 1c 2c          	mov    (%r12,%r13,1),%rbx
    5672:	48 89 df             	mov    %rbx,%rdi
    5675:	e8 06 0a 00 00       	call   6080 <fwp_gc_marked>
    567a:	85 c0                	test   %eax,%eax
    567c:	74 b2                	je     5630 <fwp_gc_finalize+0x30>
    567e:	49 ff c6             	inc    %r14
    5681:	4d 39 fe             	cmp    %r15,%r14
    5684:	72 e1                	jb     5667 <fwp_gc_finalize+0x67>
    5686:	5b                   	pop    %rbx
    5687:	41 5c                	pop    %r12
    5689:	41 5d                	pop    %r13
    568b:	41 5e                	pop    %r14
    568d:	41 5f                	pop    %r15
    568f:	c3                   	ret

0000000000005690 <fwp_gc_sweep>:
    5690:	55                   	push   %rbp
    5691:	41 57                	push   %r15
    5693:	41 56                	push   %r14
    5695:	41 55                	push   %r13
    5697:	41 54                	push   %r12
    5699:	53                   	push   %rbx
    569a:	48 83 ec 28          	sub    $0x28,%rsp
    569e:	48 8d 3d fb eb 00 00 	lea    0xebfb(%rip),%rdi        # 142a0 <fwp_gc+0x8>
    56a5:	45 31 ff             	xor    %r15d,%r15d
    56a8:	ba 40 0b 00 00       	mov    $0xb40,%edx
    56ad:	31 f6                	xor    %esi,%esi
    56af:	e8 5c db ff ff       	call   3210 <memset@plt>
    56b4:	48 83 3d 34 fc 00 00 	cmpq   $0x0,0xfc34(%rip)        # 152f0 <fwp_gc+0x1058>
    56bb:	00 
    56bc:	0f 84 06 05 00 00    	je     5bc8 <fwp_gc_sweep+0x538>
    56c2:	31 c0                	xor    %eax,%eax
    56c4:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    56c9:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    56d0:	55 55 55 
    56d3:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    56da:	33 33 33 
    56dd:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    56e4:	0f 0f 0f 
    56e7:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    56ee:	01 01 01 
    56f1:	66 0f 6f 2d c7 89 00 	movdqa 0x89c7(%rip),%xmm5        # e0c0 <_IO_stdin_used+0xc0>
    56f8:	00 
    56f9:	66 0f 6f 35 cf 89 00 	movdqa 0x89cf(%rip),%xmm6        # e0d0 <_IO_stdin_used+0xd0>
    5700:	00 
    5701:	66 0f 6f 3d d7 89 00 	movdqa 0x89d7(%rip),%xmm7        # e0e0 <_IO_stdin_used+0xe0>
    5708:	00 
    5709:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    570e:	45 31 ff             	xor    %r15d,%r15d
    5711:	31 db                	xor    %ebx,%ebx
    5713:	eb 63                	jmp    5778 <fwp_gc_sweep+0xe8>
    5715:	4c 8b 64 24 10       	mov    0x10(%rsp),%r12
    571a:	4c 89 e7             	mov    %r12,%rdi
    571d:	e8 ee 09 00 00       	call   6110 <fwp_rc_clear_chunk>
    5722:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    5727:	66 0f 6f 3d b1 89 00 	movdqa 0x89b1(%rip),%xmm7        # e0e0 <_IO_stdin_used+0xe0>
    572e:	00 
    572f:	66 0f 6f 35 99 89 00 	movdqa 0x8999(%rip),%xmm6        # e0d0 <_IO_stdin_used+0xd0>
    5736:	00 
    5737:	66 0f 6f 2d 81 89 00 	movdqa 0x8981(%rip),%xmm5        # e0c0 <_IO_stdin_used+0xc0>
    573e:	00 
    573f:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    5746:	01 01 01 
    5749:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    5750:	0f 0f 0f 
    5753:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    575a:	33 33 33 
    575d:	41 c6 04 24 00       	movb   $0x0,(%r12)
    5762:	49 ff c7             	inc    %r15
    5765:	48 ff c3             	inc    %rbx
    5768:	48 8b 05 81 fb 00 00 	mov    0xfb81(%rip),%rax        # 152f0 <fwp_gc+0x1058>
    576f:	48 39 c3             	cmp    %rax,%rbx
    5772:	0f 83 59 04 00 00    	jae    5bd1 <fwp_gc_sweep+0x541>
    5778:	4c 8b 2d 91 fb 00 00 	mov    0xfb91(%rip),%r13        # 15310 <fwp_gc+0x1078>
    577f:	4c 69 e3 28 12 00 00 	imul   $0x1228,%rbx,%r12
    5786:	43 0f b6 44 25 00    	movzbl 0x0(%r13,%r12,1),%eax
    578c:	85 c0                	test   %eax,%eax
    578e:	74 d2                	je     5762 <fwp_gc_sweep+0xd2>
    5790:	83 f8 01             	cmp    $0x1,%eax
    5793:	74 2b                	je     57c0 <fwp_gc_sweep+0x130>
    5795:	83 f8 02             	cmp    $0x2,%eax
    5798:	75 cb                	jne    5765 <fwp_gc_sweep+0xd5>
    579a:	47 8b 74 25 10       	mov    0x10(%r13,%r12,1),%r14d
    579f:	43 80 7c 25 03 00    	cmpb   $0x0,0x3(%r13,%r12,1)
    57a5:	74 4c                	je     57f3 <fwp_gc_sweep+0x163>
    57a7:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    57ac:	4b 03 44 25 18       	add    0x18(%r13,%r12,1),%rax
    57b1:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    57b6:	e9 f8 03 00 00       	jmp    5bb3 <fwp_gc_sweep+0x523>
    57bb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    57c0:	4b 8d 04 2c          	lea    (%r12,%r13,1),%rax
    57c4:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    57c9:	43 8b 6c 25 0c       	mov    0xc(%r13,%r12,1),%ebp
    57ce:	48 85 ed             	test   %rbp,%rbp
    57d1:	0f 84 3e ff ff ff    	je     5715 <fwp_gc_sweep+0x85>
    57d7:	48 8d 55 3f          	lea    0x3f(%rbp),%rdx
    57db:	48 89 d0             	mov    %rdx,%rax
    57de:	48 c1 e8 06          	shr    $0x6,%rax
    57e2:	81 fd c1 00 00 00    	cmp    $0xc1,%ebp
    57e8:	73 75                	jae    585f <fwp_gc_sweep+0x1cf>
    57ea:	31 d2                	xor    %edx,%edx
    57ec:	31 c9                	xor    %ecx,%ecx
    57ee:	e9 3c 01 00 00       	jmp    592f <fwp_gc_sweep+0x29f>
    57f3:	4b 8d 3c 2c          	lea    (%r12,%r13,1),%rdi
    57f7:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    57fe:	e8 6d e8 ff ff       	call   4070 <fwp_rc_clear_slot>
    5803:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    5808:	66 0f 6f 3d d0 88 00 	movdqa 0x88d0(%rip),%xmm7        # e0e0 <_IO_stdin_used+0xe0>
    580f:	00 
    5810:	66 0f 6f 35 b8 88 00 	movdqa 0x88b8(%rip),%xmm6        # e0d0 <_IO_stdin_used+0xd0>
    5817:	00 
    5818:	66 0f 6f 2d a0 88 00 	movdqa 0x88a0(%rip),%xmm5        # e0c0 <_IO_stdin_used+0xc0>
    581f:	00 
    5820:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    5827:	01 01 01 
    582a:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    5831:	0f 0f 0f 
    5834:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    583b:	33 33 33 
    583e:	4d 85 f6             	test   %r14,%r14
    5841:	0f 84 69 03 00 00    	je     5bb0 <fwp_gc_sweep+0x520>
    5847:	48 8b 05 c2 fa 00 00 	mov    0xfac2(%rip),%rax        # 15310 <fwp_gc+0x1078>
    584e:	41 83 fe 04          	cmp    $0x4,%r14d
    5852:	0f 83 e6 02 00 00    	jae    5b3e <fwp_gc_sweep+0x4ae>
    5858:	31 c9                	xor    %ecx,%ecx
    585a:	e9 19 03 00 00       	jmp    5b78 <fwp_gc_sweep+0x4e8>
    585f:	89 c1                	mov    %eax,%ecx
    5861:	83 e1 fc             	and    $0xfffffffc,%ecx
    5864:	4b 8d 34 2c          	lea    (%r12,%r13,1),%rsi
    5868:	48 83 c6 38          	add    $0x38,%rsi
    586c:	48 c1 ea 03          	shr    $0x3,%rdx
    5870:	83 e2 e0             	and    $0xffffffe0,%edx
    5873:	66 0f ef c0          	pxor   %xmm0,%xmm0
    5877:	31 ff                	xor    %edi,%edi
    5879:	66 0f ef c9          	pxor   %xmm1,%xmm1
    587d:	0f 1f 00             	nopl   (%rax)
    5880:	f3 0f 6f 5c 3e f0    	movdqu -0x10(%rsi,%rdi,1),%xmm3
    5886:	f3 0f 6f 14 3e       	movdqu (%rsi,%rdi,1),%xmm2
    588b:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    588f:	66 0f 71 d4 01       	psrlw  $0x1,%xmm4
    5894:	66 0f db e5          	pand   %xmm5,%xmm4
    5898:	66 0f f8 dc          	psubb  %xmm4,%xmm3
    589c:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    58a0:	66 0f db e6          	pand   %xmm6,%xmm4
    58a4:	66 0f 71 d3 02       	psrlw  $0x2,%xmm3
    58a9:	66 0f db de          	pand   %xmm6,%xmm3
    58ad:	66 0f fc dc          	paddb  %xmm4,%xmm3
    58b1:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    58b5:	66 0f 71 d4 04       	psrlw  $0x4,%xmm4
    58ba:	66 0f fc e3          	paddb  %xmm3,%xmm4
    58be:	66 0f db e7          	pand   %xmm7,%xmm4
    58c2:	66 41 0f f6 e0       	psadbw %xmm8,%xmm4
    58c7:	66 0f d4 c4          	paddq  %xmm4,%xmm0
    58cb:	66 0f 6f da          	movdqa %xmm2,%xmm3
    58cf:	66 0f 71 d3 01       	psrlw  $0x1,%xmm3
    58d4:	66 0f db dd          	pand   %xmm5,%xmm3
    58d8:	66 0f f8 d3          	psubb  %xmm3,%xmm2
    58dc:	66 0f 6f da          	movdqa %xmm2,%xmm3
    58e0:	66 0f db de          	pand   %xmm6,%xmm3
    58e4:	66 0f 71 d2 02       	psrlw  $0x2,%xmm2
    58e9:	66 0f db d6          	pand   %xmm6,%xmm2
    58ed:	66 0f fc d3          	paddb  %xmm3,%xmm2
    58f1:	66 0f 6f da          	movdqa %xmm2,%xmm3
    58f5:	66 0f 71 d3 04       	psrlw  $0x4,%xmm3
    58fa:	66 0f fc da          	paddb  %xmm2,%xmm3
    58fe:	66 0f db df          	pand   %xmm7,%xmm3
    5902:	66 41 0f f6 d8       	psadbw %xmm8,%xmm3
    5907:	66 0f d4 cb          	paddq  %xmm3,%xmm1
    590b:	48 83 c7 20          	add    $0x20,%rdi
    590f:	48 39 fa             	cmp    %rdi,%rdx
    5912:	0f 85 68 ff ff ff    	jne    5880 <fwp_gc_sweep+0x1f0>
    5918:	66 0f d4 c8          	paddq  %xmm0,%xmm1
    591c:	66 0f 70 c1 ee       	pshufd $0xee,%xmm1,%xmm0
    5921:	66 0f d4 c1          	paddq  %xmm1,%xmm0
    5925:	66 48 0f 7e c2       	movq   %xmm0,%rdx
    592a:	48 39 c8             	cmp    %rcx,%rax
    592d:	74 51                	je     5980 <fwp_gc_sweep+0x2f0>
    592f:	4b 8d 34 2c          	lea    (%r12,%r13,1),%rsi
    5933:	48 83 c6 28          	add    $0x28,%rsi
    5937:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    593e:	00 00 
    5940:	48 8b 3c ce          	mov    (%rsi,%rcx,8),%rdi
    5944:	49 89 f8             	mov    %rdi,%r8
    5947:	49 d1 e8             	shr    $1,%r8
    594a:	4d 21 f0             	and    %r14,%r8
    594d:	4c 29 c7             	sub    %r8,%rdi
    5950:	49 89 f8             	mov    %rdi,%r8
    5953:	4d 21 c8             	and    %r9,%r8
    5956:	48 c1 ef 02          	shr    $0x2,%rdi
    595a:	4c 21 cf             	and    %r9,%rdi
    595d:	4c 01 c7             	add    %r8,%rdi
    5960:	49 89 f8             	mov    %rdi,%r8
    5963:	49 c1 e8 04          	shr    $0x4,%r8
    5967:	49 01 f8             	add    %rdi,%r8
    596a:	4d 21 d0             	and    %r10,%r8
    596d:	4d 0f af c3          	imul   %r11,%r8
    5971:	49 c1 e8 38          	shr    $0x38,%r8
    5975:	4c 01 c2             	add    %r8,%rdx
    5978:	48 ff c1             	inc    %rcx
    597b:	48 39 c8             	cmp    %rcx,%rax
    597e:	75 c0                	jne    5940 <fwp_gc_sweep+0x2b0>
    5980:	48 85 d2             	test   %rdx,%rdx
    5983:	0f 84 8c fd ff ff    	je     5715 <fwp_gc_sweep+0x85>
    5989:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    598e:	43 8b 44 25 08       	mov    0x8(%r13,%r12,1),%eax
    5993:	48 0f af d0          	imul   %rax,%rdx
    5997:	48 01 54 24 08       	add    %rdx,0x8(%rsp)
    599c:	47 0f b6 74 25 01    	movzbl 0x1(%r13,%r12,1),%r14d
    59a2:	47 0f b6 7c 25 02    	movzbl 0x2(%r13,%r12,1),%r15d
    59a8:	48 89 df             	mov    %rbx,%rdi
    59ab:	e8 e0 e6 ff ff       	call   4090 <fwp_gc_chunk_addr>
    59b0:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    59b5:	48 85 ed             	test   %rbp,%rbp
    59b8:	0f 84 31 01 00 00    	je     5aef <fwp_gc_sweep+0x45f>
    59be:	49 69 c6 c0 03 00 00 	imul   $0x3c0,%r14,%rax
    59c5:	48 8d 0d cc e8 00 00 	lea    0xe8cc(%rip),%rcx        # 14298 <fwp_gc>
    59cc:	48 01 c8             	add    %rcx,%rax
    59cf:	4f 8d 34 2c          	lea    (%r12,%r13,1),%r14
    59d3:	49 83 c6 08          	add    $0x8,%r14
    59d7:	4b 8d 0c 7f          	lea    (%r15,%r15,2),%rcx
    59db:	4c 8d 3c c8          	lea    (%rax,%rcx,8),%r15
    59df:	49 83 c7 08          	add    $0x8,%r15
    59e3:	49 01 ec             	add    %rbp,%r12
    59e6:	4d 01 ec             	add    %r13,%r12
    59e9:	49 81 c4 27 02 00 00 	add    $0x227,%r12
    59f0:	48 ff cd             	dec    %rbp
    59f3:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    59fa:	33 33 33 
    59fd:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    5a04:	0f 0f 0f 
    5a07:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    5a0e:	01 01 01 
    5a11:	66 0f 6f 2d a7 86 00 	movdqa 0x86a7(%rip),%xmm5        # e0c0 <_IO_stdin_used+0xc0>
    5a18:	00 
    5a19:	66 0f 6f 35 af 86 00 	movdqa 0x86af(%rip),%xmm6        # e0d0 <_IO_stdin_used+0xd0>
    5a20:	00 
    5a21:	66 0f 6f 3d b7 86 00 	movdqa 0x86b7(%rip),%xmm7        # e0e0 <_IO_stdin_used+0xe0>
    5a28:	00 
    5a29:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    5a2e:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    5a33:	eb 69                	jmp    5a9e <fwp_gc_sweep+0x40e>
    5a35:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    5a3c:	00 00 00 00 
    5a40:	4c 89 e7             	mov    %r12,%rdi
    5a43:	e8 28 e6 ff ff       	call   4070 <fwp_rc_clear_slot>
    5a48:	49 8b 07             	mov    (%r15),%rax
    5a4b:	48 f7 d0             	not    %rax
    5a4e:	49 89 45 00          	mov    %rax,0x0(%r13)
    5a52:	4d 89 2f             	mov    %r13,(%r15)
    5a55:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    5a5c:	33 33 33 
    5a5f:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    5a66:	0f 0f 0f 
    5a69:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    5a70:	01 01 01 
    5a73:	66 0f 6f 2d 45 86 00 	movdqa 0x8645(%rip),%xmm5        # e0c0 <_IO_stdin_used+0xc0>
    5a7a:	00 
    5a7b:	66 0f 6f 35 4d 86 00 	movdqa 0x864d(%rip),%xmm6        # e0d0 <_IO_stdin_used+0xd0>
    5a82:	00 
    5a83:	66 0f 6f 3d 55 86 00 	movdqa 0x8655(%rip),%xmm7        # e0e0 <_IO_stdin_used+0xe0>
    5a8a:	00 
    5a8b:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    5a90:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    5a95:	49 ff cc             	dec    %r12
    5a98:	48 83 c5 ff          	add    $0xffffffffffffffff,%rbp
    5a9c:	73 3d                	jae    5adb <fwp_gc_sweep+0x44b>
    5a9e:	48 89 e8             	mov    %rbp,%rax
    5aa1:	48 c1 e8 06          	shr    $0x6,%rax
    5aa5:	48 8b 44 c1 28       	mov    0x28(%rcx,%rax,8),%rax
    5aaa:	48 0f a3 e8          	bt     %rbp,%rax
    5aae:	72 e5                	jb     5a95 <fwp_gc_sweep+0x405>
    5ab0:	41 8b 16             	mov    (%r14),%edx
    5ab3:	49 89 ed             	mov    %rbp,%r13
    5ab6:	4c 0f af ea          	imul   %rdx,%r13
    5aba:	4c 03 6c 24 20       	add    0x20(%rsp),%r13
    5abf:	83 3d d6 f7 00 00 00 	cmpl   $0x0,0xf7d6(%rip)        # 1529c <fwp_gc+0x1004>
    5ac6:	0f 84 74 ff ff ff    	je     5a40 <fwp_gc_sweep+0x3b0>
    5acc:	4c 89 ef             	mov    %r13,%rdi
    5acf:	31 f6                	xor    %esi,%esi
    5ad1:	e8 3a d7 ff ff       	call   3210 <memset@plt>
    5ad6:	e9 65 ff ff ff       	jmp    5a40 <fwp_gc_sweep+0x3b0>
    5adb:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    5ae0:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    5ae7:	55 55 55 
    5aea:	e9 76 fc ff ff       	jmp    5765 <fwp_gc_sweep+0xd5>
    5aef:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    5af4:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    5afb:	55 55 55 
    5afe:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    5b05:	33 33 33 
    5b08:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    5b0f:	0f 0f 0f 
    5b12:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    5b19:	01 01 01 
    5b1c:	66 0f 6f 2d 9c 85 00 	movdqa 0x859c(%rip),%xmm5        # e0c0 <_IO_stdin_used+0xc0>
    5b23:	00 
    5b24:	66 0f 6f 35 a4 85 00 	movdqa 0x85a4(%rip),%xmm6        # e0d0 <_IO_stdin_used+0xd0>
    5b2b:	00 
    5b2c:	66 0f 6f 3d ac 85 00 	movdqa 0x85ac(%rip),%xmm7        # e0e0 <_IO_stdin_used+0xe0>
    5b33:	00 
    5b34:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    5b39:	e9 27 fc ff ff       	jmp    5765 <fwp_gc_sweep+0xd5>
    5b3e:	4a 8d 14 20          	lea    (%rax,%r12,1),%rdx
    5b42:	44 89 f6             	mov    %r14d,%esi
    5b45:	83 e6 fc             	and    $0xfffffffc,%esi
    5b48:	31 c9                	xor    %ecx,%ecx
    5b4a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    5b50:	c6 02 00             	movb   $0x0,(%rdx)
    5b53:	c6 82 28 12 00 00 00 	movb   $0x0,0x1228(%rdx)
    5b5a:	c6 82 50 24 00 00 00 	movb   $0x0,0x2450(%rdx)
    5b61:	c6 82 78 36 00 00 00 	movb   $0x0,0x3678(%rdx)
    5b68:	48 83 c1 04          	add    $0x4,%rcx
    5b6c:	48 81 c2 a0 48 00 00 	add    $0x48a0,%rdx
    5b73:	48 39 ce             	cmp    %rcx,%rsi
    5b76:	75 d8                	jne    5b50 <fwp_gc_sweep+0x4c0>
    5b78:	44 89 f2             	mov    %r14d,%edx
    5b7b:	83 e2 03             	and    $0x3,%edx
    5b7e:	74 30                	je     5bb0 <fwp_gc_sweep+0x520>
    5b80:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    5b87:	4c 01 e1             	add    %r12,%rcx
    5b8a:	48 01 c8             	add    %rcx,%rax
    5b8d:	48 69 ca 28 12 00 00 	imul   $0x1228,%rdx,%rcx
    5b94:	31 d2                	xor    %edx,%edx
    5b96:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    5b9d:	00 00 00 
    5ba0:	c6 04 10 00          	movb   $0x0,(%rax,%rdx,1)
    5ba4:	48 81 c2 28 12 00 00 	add    $0x1228,%rdx
    5bab:	48 39 d1             	cmp    %rdx,%rcx
    5bae:	75 f0                	jne    5ba0 <fwp_gc_sweep+0x510>
    5bb0:	4d 01 f7             	add    %r14,%r15
    5bb3:	4c 01 f3             	add    %r14,%rbx
    5bb6:	48 ff cb             	dec    %rbx
    5bb9:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    5bc0:	55 55 55 
    5bc3:	e9 9d fb ff ff       	jmp    5765 <fwp_gc_sweep+0xd5>
    5bc8:	31 c0                	xor    %eax,%eax
    5bca:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    5bcf:	31 c0                	xor    %eax,%eax
    5bd1:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    5bd6:	48 89 15 83 f8 00 00 	mov    %rdx,0xf883(%rip)        # 15460 <fwp_gc+0x11c8>
    5bdd:	4c 89 3d 94 f8 00 00 	mov    %r15,0xf894(%rip)        # 15478 <fwp_gc+0x11e0>
    5be4:	48 81 fa 01 00 00 01 	cmp    $0x1000001,%rdx
    5beb:	b9 00 00 00 01       	mov    $0x1000000,%ecx
    5bf0:	48 0f 43 ca          	cmovae %rdx,%rcx
    5bf4:	48 c1 e9 10          	shr    $0x10,%rcx
    5bf8:	66 0f ef c0          	pxor   %xmm0,%xmm0
    5bfc:	f3 0f 7f 05 fc f6 00 	movdqu %xmm0,0xf6fc(%rip)        # 15300 <fwp_gc+0x1068>
    5c03:	00 
    5c04:	49 29 cf             	sub    %rcx,%r15
    5c07:	0f 86 01 01 00 00    	jbe    5d0e <fwp_gc_sweep+0x67e>
    5c0d:	48 85 c0             	test   %rax,%rax
    5c10:	0f 84 f8 00 00 00    	je     5d0e <fwp_gc_sweep+0x67e>
    5c16:	4d 85 ff             	test   %r15,%r15
    5c19:	0f 84 ef 00 00 00    	je     5d0e <fwp_gc_sweep+0x67e>
    5c1f:	48 8b 0d ea f6 00 00 	mov    0xf6ea(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    5c26:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    5c2d:	00 00 00 
    5c30:	48 8d 58 ff          	lea    -0x1(%rax),%rbx
    5c34:	48 69 d3 28 12 00 00 	imul   $0x1228,%rbx,%rdx
    5c3b:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
    5c3f:	0f 85 b8 00 00 00    	jne    5cfd <fwp_gc_sweep+0x66d>
    5c45:	4c 89 ff             	mov    %r15,%rdi
    5c48:	49 ff cf             	dec    %r15
    5c4b:	80 7c 11 04 00       	cmpb   $0x0,0x4(%rcx,%rdx,1)
    5c50:	0f 84 a7 00 00 00    	je     5cfd <fwp_gc_sweep+0x66d>
    5c56:	48 01 ca             	add    %rcx,%rdx
    5c59:	48 83 c2 04          	add    $0x4,%rdx
    5c5d:	c6 02 00             	movb   $0x0,(%rdx)
    5c60:	41 be 01 00 00 00    	mov    $0x1,%r14d
    5c66:	48 85 db             	test   %rbx,%rbx
    5c69:	74 6f                	je     5cda <fwp_gc_sweep+0x64a>
    5c6b:	4d 85 ff             	test   %r15,%r15
    5c6e:	74 6a                	je     5cda <fwp_gc_sweep+0x64a>
    5c70:	ba 02 00 00 00       	mov    $0x2,%edx
    5c75:	48 29 c2             	sub    %rax,%rdx
    5c78:	48 69 c0 28 12 00 00 	imul   $0x1228,%rax,%rax
    5c7f:	48 01 c1             	add    %rax,%rcx
    5c82:	48 81 c1 b4 db ff ff 	add    $0xffffffffffffdbb4,%rcx
    5c89:	be 02 00 00 00       	mov    $0x2,%esi
    5c8e:	48 29 fe             	sub    %rdi,%rsi
    5c91:	b8 01 00 00 00       	mov    $0x1,%eax
    5c96:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    5c9d:	00 00 00 
    5ca0:	80 79 fc 00          	cmpb   $0x0,-0x4(%rcx)
    5ca4:	75 31                	jne    5cd7 <fwp_gc_sweep+0x647>
    5ca6:	80 39 00             	cmpb   $0x0,(%rcx)
    5ca9:	74 2c                	je     5cd7 <fwp_gc_sweep+0x647>
    5cab:	48 ff cb             	dec    %rbx
    5cae:	48 8d 3c 02          	lea    (%rdx,%rax,1),%rdi
    5cb2:	49 ff cf             	dec    %r15
    5cb5:	c6 01 00             	movb   $0x0,(%rcx)
    5cb8:	4c 8d 70 01          	lea    0x1(%rax),%r14
    5cbc:	48 83 ff 01          	cmp    $0x1,%rdi
    5cc0:	74 18                	je     5cda <fwp_gc_sweep+0x64a>
    5cc2:	48 01 f0             	add    %rsi,%rax
    5cc5:	48 81 c1 d8 ed ff ff 	add    $0xffffffffffffedd8,%rcx
    5ccc:	48 83 f8 01          	cmp    $0x1,%rax
    5cd0:	4c 89 f0             	mov    %r14,%rax
    5cd3:	75 cb                	jne    5ca0 <fwp_gc_sweep+0x610>
    5cd5:	eb 03                	jmp    5cda <fwp_gc_sweep+0x64a>
    5cd7:	49 89 c6             	mov    %rax,%r14
    5cda:	48 89 df             	mov    %rbx,%rdi
    5cdd:	e8 ae e3 ff ff       	call   4090 <fwp_gc_chunk_addr>
    5ce2:	49 c1 e6 10          	shl    $0x10,%r14
    5ce6:	48 89 c7             	mov    %rax,%rdi
    5ce9:	4c 89 f6             	mov    %r14,%rsi
    5cec:	ba 04 00 00 00       	mov    $0x4,%edx
    5cf1:	e8 fa d6 ff ff       	call   33f0 <madvise@plt>
    5cf6:	48 8b 0d 13 f6 00 00 	mov    0xf613(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    5cfd:	48 89 d8             	mov    %rbx,%rax
    5d00:	48 85 db             	test   %rbx,%rbx
    5d03:	74 09                	je     5d0e <fwp_gc_sweep+0x67e>
    5d05:	4d 85 ff             	test   %r15,%r15
    5d08:	0f 85 22 ff ff ff    	jne    5c30 <fwp_gc_sweep+0x5a0>
    5d0e:	48 83 c4 28          	add    $0x28,%rsp
    5d12:	5b                   	pop    %rbx
    5d13:	41 5c                	pop    %r12
    5d15:	41 5d                	pop    %r13
    5d17:	41 5e                	pop    %r14
    5d19:	41 5f                	pop    %r15
    5d1b:	5d                   	pop    %rbp
    5d1c:	c3                   	ret
    5d1d:	0f 1f 00             	nopl   (%rax)

0000000000005d20 <fwp_gc_scan_stacks>:
    5d20:	48 8b 35 f9 f5 00 00 	mov    0xf5f9(%rip),%rsi        # 15320 <fwp_gc+0x1088>
    5d27:	e9 04 01 00 00       	jmp    5e30 <fwp_gc_scan_root>
    5d2c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000005d30 <fwp_gc_sp>:
    5d30:	55                   	push   %rbp
    5d31:	48 89 e5             	mov    %rsp,%rbp
    5d34:	48 89 e8             	mov    %rbp,%rax
    5d37:	5d                   	pop    %rbp
    5d38:	c3                   	ret
    5d39:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000005d40 <fwp_gc_drain>:
    5d40:	48 8b 05 f1 f6 00 00 	mov    0xf6f1(%rip),%rax        # 15438 <fwp_gc+0x11a0>
    5d47:	48 85 c0             	test   %rax,%rax
    5d4a:	74 3c                	je     5d88 <fwp_gc_drain+0x48>
    5d4c:	50                   	push   %rax
    5d4d:	0f 1f 00             	nopl   (%rax)
    5d50:	48 8b 0d d9 f6 00 00 	mov    0xf6d9(%rip),%rcx        # 15430 <fwp_gc+0x1198>
    5d57:	48 ff c8             	dec    %rax
    5d5a:	48 89 05 d7 f6 00 00 	mov    %rax,0xf6d7(%rip)        # 15438 <fwp_gc+0x11a0>
    5d61:	48 c1 e0 04          	shl    $0x4,%rax
    5d65:	48 8b 3c 01          	mov    (%rcx,%rax,1),%rdi
    5d69:	48 8b 74 01 08       	mov    0x8(%rcx,%rax,1),%rsi
    5d6e:	48 01 fe             	add    %rdi,%rsi
    5d71:	31 d2                	xor    %edx,%edx
    5d73:	e8 e8 00 00 00       	call   5e60 <fwp_gc_scan>
    5d78:	48 8b 05 b9 f6 00 00 	mov    0xf6b9(%rip),%rax        # 15438 <fwp_gc+0x11a0>
    5d7f:	48 85 c0             	test   %rax,%rax
    5d82:	75 cc                	jne    5d50 <fwp_gc_drain+0x10>
    5d84:	48 83 c4 08          	add    $0x8,%rsp
    5d88:	c3                   	ret
    5d89:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000005d90 <fwp_gc_scan_data>:
    5d90:	83 3d 91 f6 00 00 00 	cmpl   $0x0,0xf691(%rip)        # 15428 <fwp_gc+0x1190>
    5d97:	0f 8e 87 00 00 00    	jle    5e24 <fwp_gc_scan_data+0x94>
    5d9d:	41 57                	push   %r15
    5d9f:	41 56                	push   %r14
    5da1:	41 55                	push   %r13
    5da3:	41 54                	push   %r12
    5da5:	53                   	push   %rbx
    5da6:	4c 8d 25 83 f5 00 00 	lea    0xf583(%rip),%r12        # 15330 <fwp_gc+0x1098>
    5dad:	45 31 ed             	xor    %r13d,%r13d
    5db0:	48 8d 1d e1 e4 00 00 	lea    0xe4e1(%rip),%rbx        # 14298 <fwp_gc>
    5db7:	4c 8d 35 fa fe 00 00 	lea    0xfefa(%rip),%r14        # 15cb8 <fwp_po_listen>
    5dbe:	eb 1d                	jmp    5ddd <fwp_gc_scan_data+0x4d>
    5dc0:	4c 89 fe             	mov    %r15,%rsi
    5dc3:	31 d2                	xor    %edx,%edx
    5dc5:	e8 96 00 00 00       	call   5e60 <fwp_gc_scan>
    5dca:	49 ff c5             	inc    %r13
    5dcd:	48 63 05 54 f6 00 00 	movslq 0xf654(%rip),%rax        # 15428 <fwp_gc+0x1190>
    5dd4:	49 83 c4 10          	add    $0x10,%r12
    5dd8:	49 39 c5             	cmp    %rax,%r13
    5ddb:	7d 3e                	jge    5e1b <fwp_gc_scan_data+0x8b>
    5ddd:	49 8b 7c 24 f8       	mov    -0x8(%r12),%rdi
    5de2:	49 8b 04 24          	mov    (%r12),%rax
    5de6:	4c 8d 3c 07          	lea    (%rdi,%rax,1),%r15
    5dea:	0f 57 c0             	xorps  %xmm0,%xmm0
    5ded:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    5df2:	f2 0f 58 05 9e f6 00 	addsd  0xf69e(%rip),%xmm0        # 15498 <fwp_gc+0x1200>
    5df9:	00 
    5dfa:	f2 0f 11 05 96 f6 00 	movsd  %xmm0,0xf696(%rip)        # 15498 <fwp_gc+0x1200>
    5e01:	00 
    5e02:	48 39 df             	cmp    %rbx,%rdi
    5e05:	77 b9                	ja     5dc0 <fwp_gc_scan_data+0x30>
    5e07:	4d 39 f7             	cmp    %r14,%r15
    5e0a:	72 b4                	jb     5dc0 <fwp_gc_scan_data+0x30>
    5e0c:	48 89 de             	mov    %rbx,%rsi
    5e0f:	31 d2                	xor    %edx,%edx
    5e11:	e8 4a 00 00 00       	call   5e60 <fwp_gc_scan>
    5e16:	4c 89 f7             	mov    %r14,%rdi
    5e19:	eb a5                	jmp    5dc0 <fwp_gc_scan_data+0x30>
    5e1b:	5b                   	pop    %rbx
    5e1c:	41 5c                	pop    %r12
    5e1e:	41 5d                	pop    %r13
    5e20:	41 5e                	pop    %r14
    5e22:	41 5f                	pop    %r15
    5e24:	c3                   	ret
    5e25:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    5e2c:	00 00 00 00 

0000000000005e30 <fwp_gc_scan_root>:
    5e30:	48 85 ff             	test   %rdi,%rdi
    5e33:	74 24                	je     5e59 <fwp_gc_scan_root+0x29>
    5e35:	48 89 f0             	mov    %rsi,%rax
    5e38:	48 29 f8             	sub    %rdi,%rax
    5e3b:	76 1c                	jbe    5e59 <fwp_gc_scan_root+0x29>
    5e3d:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    5e42:	f2 0f 58 05 4e f6 00 	addsd  0xf64e(%rip),%xmm0        # 15498 <fwp_gc+0x1200>
    5e49:	00 
    5e4a:	f2 0f 11 05 46 f6 00 	movsd  %xmm0,0xf646(%rip)        # 15498 <fwp_gc+0x1200>
    5e51:	00 
    5e52:	ba 01 00 00 00       	mov    $0x1,%edx
    5e57:	eb 07                	jmp    5e60 <fwp_gc_scan>
    5e59:	c3                   	ret
    5e5a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000005e60 <fwp_gc_scan>:
    5e60:	55                   	push   %rbp
    5e61:	41 57                	push   %r15
    5e63:	41 56                	push   %r14
    5e65:	41 55                	push   %r13
    5e67:	41 54                	push   %r12
    5e69:	53                   	push   %rbx
    5e6a:	50                   	push   %rax
    5e6b:	49 89 ff             	mov    %rdi,%r15
    5e6e:	49 83 c7 07          	add    $0x7,%r15
    5e72:	49 83 e7 f8          	and    $0xfffffffffffffff8,%r15
    5e76:	49 8d 47 08          	lea    0x8(%r15),%rax
    5e7a:	48 39 f0             	cmp    %rsi,%rax
    5e7d:	76 0f                	jbe    5e8e <fwp_gc_scan+0x2e>
    5e7f:	48 83 c4 08          	add    $0x8,%rsp
    5e83:	5b                   	pop    %rbx
    5e84:	41 5c                	pop    %r12
    5e86:	41 5d                	pop    %r13
    5e88:	41 5e                	pop    %r14
    5e8a:	41 5f                	pop    %r15
    5e8c:	5d                   	pop    %rbp
    5e8d:	c3                   	ret
    5e8e:	89 d3                	mov    %edx,%ebx
    5e90:	49 89 f6             	mov    %rsi,%r14
    5e93:	4c 8b 2d 2e f4 00 00 	mov    0xf42e(%rip),%r13        # 152c8 <fwp_gc+0x1030>
    5e9a:	48 8b 2d 4f f4 00 00 	mov    0xf44f(%rip),%rbp        # 152f0 <fwp_gc+0x1058>
    5ea1:	48 c1 e5 10          	shl    $0x10,%rbp
    5ea5:	eb 30                	jmp    5ed7 <fwp_gc_scan+0x77>
    5ea7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    5eae:	00 00 
    5eb0:	4c 89 e7             	mov    %r12,%rdi
    5eb3:	e8 38 00 00 00       	call   5ef0 <fwp_gc_mark>
    5eb8:	85 db                	test   %ebx,%ebx
    5eba:	74 0b                	je     5ec7 <fwp_gc_scan+0x67>
    5ebc:	49 ff cc             	dec    %r12
    5ebf:	4c 89 e7             	mov    %r12,%rdi
    5ec2:	e8 29 00 00 00       	call   5ef0 <fwp_gc_mark>
    5ec7:	49 8d 47 08          	lea    0x8(%r15),%rax
    5ecb:	49 83 c7 10          	add    $0x10,%r15
    5ecf:	4d 39 f7             	cmp    %r14,%r15
    5ed2:	49 89 c7             	mov    %rax,%r15
    5ed5:	77 a8                	ja     5e7f <fwp_gc_scan+0x1f>
    5ed7:	4d 8b 27             	mov    (%r15),%r12
    5eda:	4c 89 e0             	mov    %r12,%rax
    5edd:	4c 29 e8             	sub    %r13,%rax
    5ee0:	48 39 e8             	cmp    %rbp,%rax
    5ee3:	72 cb                	jb     5eb0 <fwp_gc_scan+0x50>
    5ee5:	85 db                	test   %ebx,%ebx
    5ee7:	74 de                	je     5ec7 <fwp_gc_scan+0x67>
    5ee9:	48 39 e8             	cmp    %rbp,%rax
    5eec:	74 ce                	je     5ebc <fwp_gc_scan+0x5c>
    5eee:	eb d7                	jmp    5ec7 <fwp_gc_scan+0x67>

0000000000005ef0 <fwp_gc_mark>:
    5ef0:	41 56                	push   %r14
    5ef2:	53                   	push   %rbx
    5ef3:	50                   	push   %rax
    5ef4:	49 89 fe             	mov    %rdi,%r14
    5ef7:	48 89 e6             	mov    %rsp,%rsi
    5efa:	e8 d1 00 00 00       	call   5fd0 <fwp_gc_chunk_of>
    5eff:	48 85 c0             	test   %rax,%rax
    5f02:	0f 84 98 00 00 00    	je     5fa0 <fwp_gc_mark+0xb0>
    5f08:	0f b6 08             	movzbl (%rax),%ecx
    5f0b:	83 f9 03             	cmp    $0x3,%ecx
    5f0e:	74 6b                	je     5f7b <fwp_gc_mark+0x8b>
    5f10:	83 f9 02             	cmp    $0x2,%ecx
    5f13:	74 7b                	je     5f90 <fwp_gc_mark+0xa0>
    5f15:	83 f9 01             	cmp    $0x1,%ecx
    5f18:	0f 85 82 00 00 00    	jne    5fa0 <fwp_gc_mark+0xb0>
    5f1e:	8b 58 08             	mov    0x8(%rax),%ebx
    5f21:	41 0f b7 ce          	movzwl %r14w,%ecx
    5f25:	48 89 c6             	mov    %rax,%rsi
    5f28:	89 c8                	mov    %ecx,%eax
    5f2a:	31 d2                	xor    %edx,%edx
    5f2c:	f7 f3                	div    %ebx
    5f2e:	41 89 c6             	mov    %eax,%r14d
    5f31:	3b 46 0c             	cmp    0xc(%rsi),%eax
    5f34:	73 6a                	jae    5fa0 <fwp_gc_mark+0xb0>
    5f36:	48 89 f0             	mov    %rsi,%rax
    5f39:	ba 01 00 00 00       	mov    $0x1,%edx
    5f3e:	44 89 f1             	mov    %r14d,%ecx
    5f41:	48 d3 e2             	shl    %cl,%rdx
    5f44:	44 89 f1             	mov    %r14d,%ecx
    5f47:	c1 e9 06             	shr    $0x6,%ecx
    5f4a:	48 8b 74 ce 28       	mov    0x28(%rsi,%rcx,8),%rsi
    5f4f:	4c 0f a3 f6          	bt     %r14,%rsi
    5f53:	72 4b                	jb     5fa0 <fwp_gc_mark+0xb0>
    5f55:	48 09 d6             	or     %rdx,%rsi
    5f58:	48 89 74 c8 28       	mov    %rsi,0x28(%rax,%rcx,8)
    5f5d:	80 78 01 01          	cmpb   $0x1,0x1(%rax)
    5f61:	74 3d                	je     5fa0 <fwp_gc_mark+0xb0>
    5f63:	48 8b 3c 24          	mov    (%rsp),%rdi
    5f67:	e8 24 e1 ff ff       	call   4090 <fwp_gc_chunk_addr>
    5f6c:	4c 0f af f3          	imul   %rbx,%r14
    5f70:	49 01 c6             	add    %rax,%r14
    5f73:	4c 89 f7             	mov    %r14,%rdi
    5f76:	48 89 de             	mov    %rbx,%rsi
    5f79:	eb 40                	jmp    5fbb <fwp_gc_mark+0xcb>
    5f7b:	8b 40 10             	mov    0x10(%rax),%eax
    5f7e:	48 89 04 24          	mov    %rax,(%rsp)
    5f82:	48 69 c0 28 12 00 00 	imul   $0x1228,%rax,%rax
    5f89:	48 03 05 80 f3 00 00 	add    0xf380(%rip),%rax        # 15310 <fwp_gc+0x1078>
    5f90:	80 78 03 00          	cmpb   $0x0,0x3(%rax)
    5f94:	75 0a                	jne    5fa0 <fwp_gc_mark+0xb0>
    5f96:	c6 40 03 01          	movb   $0x1,0x3(%rax)
    5f9a:	80 78 01 01          	cmpb   $0x1,0x1(%rax)
    5f9e:	75 08                	jne    5fa8 <fwp_gc_mark+0xb8>
    5fa0:	48 83 c4 08          	add    $0x8,%rsp
    5fa4:	5b                   	pop    %rbx
    5fa5:	41 5e                	pop    %r14
    5fa7:	c3                   	ret
    5fa8:	48 8b 3c 24          	mov    (%rsp),%rdi
    5fac:	48 89 c3             	mov    %rax,%rbx
    5faf:	e8 dc e0 ff ff       	call   4090 <fwp_gc_chunk_addr>
    5fb4:	48 8b 73 18          	mov    0x18(%rbx),%rsi
    5fb8:	48 89 c7             	mov    %rax,%rdi
    5fbb:	48 83 c4 08          	add    $0x8,%rsp
    5fbf:	5b                   	pop    %rbx
    5fc0:	41 5e                	pop    %r14
    5fc2:	eb 3c                	jmp    6000 <fwp_gc_push>
    5fc4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    5fcb:	00 00 00 00 00 

0000000000005fd0 <fwp_gc_chunk_of>:
    5fd0:	48 2b 3d f1 f2 00 00 	sub    0xf2f1(%rip),%rdi        # 152c8 <fwp_gc+0x1030>
    5fd7:	48 8b 05 12 f3 00 00 	mov    0xf312(%rip),%rax        # 152f0 <fwp_gc+0x1058>
    5fde:	48 c1 e0 10          	shl    $0x10,%rax
    5fe2:	48 39 c7             	cmp    %rax,%rdi
    5fe5:	73 16                	jae    5ffd <fwp_gc_chunk_of+0x2d>
    5fe7:	48 c1 ef 10          	shr    $0x10,%rdi
    5feb:	48 89 3e             	mov    %rdi,(%rsi)
    5fee:	48 69 c7 28 12 00 00 	imul   $0x1228,%rdi,%rax
    5ff5:	48 03 05 14 f3 00 00 	add    0xf314(%rip),%rax        # 15310 <fwp_gc+0x1078>
    5ffc:	c3                   	ret
    5ffd:	31 c0                	xor    %eax,%eax
    5fff:	c3                   	ret

0000000000006000 <fwp_gc_push>:
    6000:	41 56                	push   %r14
    6002:	53                   	push   %rbx
    6003:	50                   	push   %rax
    6004:	48 89 f3             	mov    %rsi,%rbx
    6007:	49 89 fe             	mov    %rdi,%r14
    600a:	48 8b 0d 27 f4 00 00 	mov    0xf427(%rip),%rcx        # 15438 <fwp_gc+0x11a0>
    6011:	48 8b 05 18 f4 00 00 	mov    0xf418(%rip),%rax        # 15430 <fwp_gc+0x1198>
    6018:	48 3b 0d 21 f4 00 00 	cmp    0xf421(%rip),%rcx        # 15440 <fwp_gc+0x11a8>
    601f:	75 36                	jne    6057 <fwp_gc_push+0x57>
    6021:	48 8d 14 09          	lea    (%rcx,%rcx,1),%rdx
    6025:	48 85 c9             	test   %rcx,%rcx
    6028:	be 00 10 00 00       	mov    $0x1000,%esi
    602d:	48 0f 45 f2          	cmovne %rdx,%rsi
    6031:	48 89 35 08 f4 00 00 	mov    %rsi,0xf408(%rip)        # 15440 <fwp_gc+0x11a8>
    6038:	48 c1 e6 04          	shl    $0x4,%rsi
    603c:	48 89 c7             	mov    %rax,%rdi
    603f:	e8 3c d3 ff ff       	call   3380 <realloc@plt>
    6044:	48 89 05 e5 f3 00 00 	mov    %rax,0xf3e5(%rip)        # 15430 <fwp_gc+0x1198>
    604b:	48 85 c0             	test   %rax,%rax
    604e:	74 29                	je     6079 <fwp_gc_push+0x79>
    6050:	48 8b 0d e1 f3 00 00 	mov    0xf3e1(%rip),%rcx        # 15438 <fwp_gc+0x11a0>
    6057:	48 89 ca             	mov    %rcx,%rdx
    605a:	48 c1 e2 04          	shl    $0x4,%rdx
    605e:	4c 89 34 10          	mov    %r14,(%rax,%rdx,1)
    6062:	48 89 5c 10 08       	mov    %rbx,0x8(%rax,%rdx,1)
    6067:	48 ff c1             	inc    %rcx
    606a:	48 89 0d c7 f3 00 00 	mov    %rcx,0xf3c7(%rip)        # 15438 <fwp_gc+0x11a0>
    6071:	48 83 c4 08          	add    $0x8,%rsp
    6075:	5b                   	pop    %rbx
    6076:	41 5e                	pop    %r14
    6078:	c3                   	ret
    6079:	e8 02 ec ff ff       	call   4c80 <fwp_gc_oom>
    607e:	66 90                	xchg   %ax,%ax

0000000000006080 <fwp_gc_marked>:
    6080:	53                   	push   %rbx
    6081:	48 83 ec 10          	sub    $0x10,%rsp
    6085:	48 89 fb             	mov    %rdi,%rbx
    6088:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    608d:	e8 3e ff ff ff       	call   5fd0 <fwp_gc_chunk_of>
    6092:	48 85 c0             	test   %rax,%rax
    6095:	74 36                	je     60cd <fwp_gc_marked+0x4d>
    6097:	0f b6 08             	movzbl (%rax),%ecx
    609a:	80 f9 03             	cmp    $0x3,%cl
    609d:	75 19                	jne    60b8 <fwp_gc_marked+0x38>
    609f:	48 8b 0d 6a f2 00 00 	mov    0xf26a(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    60a6:	8b 40 10             	mov    0x10(%rax),%eax
    60a9:	48 69 d0 28 12 00 00 	imul   $0x1228,%rax,%rdx
    60b0:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    60b4:	0f b6 0c 11          	movzbl (%rcx,%rdx,1),%ecx
    60b8:	80 f9 01             	cmp    $0x1,%cl
    60bb:	74 17                	je     60d4 <fwp_gc_marked+0x54>
    60bd:	0f b6 d1             	movzbl %cl,%edx
    60c0:	31 c9                	xor    %ecx,%ecx
    60c2:	83 fa 02             	cmp    $0x2,%edx
    60c5:	75 33                	jne    60fa <fwp_gc_marked+0x7a>
    60c7:	0f b6 48 03          	movzbl 0x3(%rax),%ecx
    60cb:	eb 2d                	jmp    60fa <fwp_gc_marked+0x7a>
    60cd:	b9 01 00 00 00       	mov    $0x1,%ecx
    60d2:	eb 26                	jmp    60fa <fwp_gc_marked+0x7a>
    60d4:	0f b7 cb             	movzwl %bx,%ecx
    60d7:	48 89 c6             	mov    %rax,%rsi
    60da:	89 c8                	mov    %ecx,%eax
    60dc:	31 d2                	xor    %edx,%edx
    60de:	f7 76 08             	divl   0x8(%rsi)
    60e1:	89 c1                	mov    %eax,%ecx
    60e3:	c1 e9 03             	shr    $0x3,%ecx
    60e6:	81 e1 f8 1f 00 00    	and    $0x1ff8,%ecx
    60ec:	48 8b 54 0e 28       	mov    0x28(%rsi,%rcx,1),%rdx
    60f1:	31 c9                	xor    %ecx,%ecx
    60f3:	48 0f a3 c2          	bt     %rax,%rdx
    60f7:	0f 92 c1             	setb   %cl
    60fa:	89 c8                	mov    %ecx,%eax
    60fc:	48 83 c4 10          	add    $0x10,%rsp
    6100:	5b                   	pop    %rbx
    6101:	c3                   	ret
    6102:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6109:	1f 84 00 00 00 00 00 

0000000000006110 <fwp_rc_clear_chunk>:
    6110:	41 57                	push   %r15
    6112:	41 56                	push   %r14
    6114:	53                   	push   %rbx
    6115:	48 89 fb             	mov    %rdi,%rbx
    6118:	48 83 3d 90 fb 00 00 	cmpq   $0x0,0xfb90(%rip)        # 15cb0 <fwp_gc+0x1a18>
    611f:	00 
    6120:	74 2c                	je     614e <fwp_rc_clear_chunk+0x3e>
    6122:	4c 8d b3 28 02 00 00 	lea    0x228(%rbx),%r14
    6129:	45 31 ff             	xor    %r15d,%r15d
    612c:	eb 0e                	jmp    613c <fwp_rc_clear_chunk+0x2c>
    612e:	66 90                	xchg   %ax,%ax
    6130:	49 ff c7             	inc    %r15
    6133:	49 81 ff 00 10 00 00 	cmp    $0x1000,%r15
    613a:	74 12                	je     614e <fwp_rc_clear_chunk+0x3e>
    613c:	43 80 3c 3e ff       	cmpb   $0xff,(%r14,%r15,1)
    6141:	75 ed                	jne    6130 <fwp_rc_clear_chunk+0x20>
    6143:	4b 8d 3c 3e          	lea    (%r14,%r15,1),%rdi
    6147:	e8 54 df ff ff       	call   40a0 <fwp_rc_forget_slot>
    614c:	eb e2                	jmp    6130 <fwp_rc_clear_chunk+0x20>
    614e:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    6155:	ba 00 10 00 00       	mov    $0x1000,%edx
    615a:	48 89 df             	mov    %rbx,%rdi
    615d:	31 f6                	xor    %esi,%esi
    615f:	5b                   	pop    %rbx
    6160:	41 5e                	pop    %r14
    6162:	41 5f                	pop    %r15
    6164:	e9 a7 d0 ff ff       	jmp    3210 <memset@plt>
    6169:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000006170 <f2>:
    6170:	48 89 fe             	mov    %rdi,%rsi
    6173:	48 bf 00 00 00 00 00 	movabs $0x3fc0000000000000,%rdi
    617a:	00 c0 3f 
    617d:	e9 ee e0 ff ff       	jmp    4270 <f4>
    6182:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6189:	1f 84 00 00 00 00 00 

0000000000006190 <f10>:
    6190:	eb 0e                	jmp    61a0 <fwp_p_array_make_typed>
    6192:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6199:	1f 84 00 00 00 00 00 

00000000000061a0 <fwp_p_array_make_typed>:
    61a0:	41 56                	push   %r14
    61a2:	53                   	push   %rbx
    61a3:	50                   	push   %rax
    61a4:	48 89 f3             	mov    %rsi,%rbx
    61a7:	e8 64 00 00 00       	call   6210 <fwp_count_arg>
    61ac:	49 89 c6             	mov    %rax,%r14
    61af:	48 89 c7             	mov    %rax,%rdi
    61b2:	e8 69 00 00 00       	call   6220 <fwp_array_typed_new>
    61b7:	4d 85 f6             	test   %r14,%r14
    61ba:	74 48                	je     6204 <fwp_p_array_make_typed+0x64>
    61bc:	49 83 fe 04          	cmp    $0x4,%r14
    61c0:	73 04                	jae    61c6 <fwp_p_array_make_typed+0x26>
    61c2:	31 c9                	xor    %ecx,%ecx
    61c4:	eb 31                	jmp    61f7 <fwp_p_array_make_typed+0x57>
    61c6:	4c 89 f1             	mov    %r14,%rcx
    61c9:	48 83 e1 fc          	and    $0xfffffffffffffffc,%rcx
    61cd:	66 48 0f 6e c3       	movq   %rbx,%xmm0
    61d2:	66 0f 70 c0 44       	pshufd $0x44,%xmm0,%xmm0
    61d7:	31 d2                	xor    %edx,%edx
    61d9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    61e0:	f3 0f 7f 44 d0 08    	movdqu %xmm0,0x8(%rax,%rdx,8)
    61e6:	f3 0f 7f 44 d0 18    	movdqu %xmm0,0x18(%rax,%rdx,8)
    61ec:	48 83 c2 04          	add    $0x4,%rdx
    61f0:	48 39 d1             	cmp    %rdx,%rcx
    61f3:	75 eb                	jne    61e0 <fwp_p_array_make_typed+0x40>
    61f5:	eb 08                	jmp    61ff <fwp_p_array_make_typed+0x5f>
    61f7:	48 89 5c c8 08       	mov    %rbx,0x8(%rax,%rcx,8)
    61fc:	48 ff c1             	inc    %rcx
    61ff:	49 39 ce             	cmp    %rcx,%r14
    6202:	75 f3                	jne    61f7 <fwp_p_array_make_typed+0x57>
    6204:	48 83 c4 08          	add    $0x8,%rsp
    6208:	5b                   	pop    %rbx
    6209:	41 5e                	pop    %r14
    620b:	c3                   	ret
    620c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000006210 <fwp_count_arg>:
    6210:	31 c0                	xor    %eax,%eax
    6212:	48 85 ff             	test   %rdi,%rdi
    6215:	48 0f 4f c7          	cmovg  %rdi,%rax
    6219:	c3                   	ret
    621a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000006220 <fwp_array_typed_new>:
    6220:	50                   	push   %rax
    6221:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    6228:	ff ff 1f 
    622b:	48 39 c7             	cmp    %rax,%rdi
    622e:	73 0e                	jae    623e <fwp_array_typed_new+0x1e>
    6230:	e8 1b 00 00 00       	call   6250 <fwp_arr_new>
    6235:	48 89 c7             	mov    %rax,%rdi
    6238:	58                   	pop    %rax
    6239:	e9 e2 df ff ff       	jmp    4220 <fwp_rc_fresh>
    623e:	48 8d 3d 54 87 00 00 	lea    0x8754(%rip),%rdi        # e999 <exec_in_fp0+0x299>
    6245:	e8 f6 de ff ff       	call   4140 <fwp_trap>
    624a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000006250 <fwp_arr_new>:
    6250:	53                   	push   %rbx
    6251:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    6258:	ff ff 1f 
    625b:	48 39 c7             	cmp    %rax,%rdi
    625e:	73 15                	jae    6275 <fwp_arr_new+0x25>
    6260:	48 89 fb             	mov    %rdi,%rbx
    6263:	48 8d 3c fd 08 00 00 	lea    0x8(,%rdi,8),%rdi
    626a:	00 
    626b:	e8 20 00 00 00       	call   6290 <fwp_alloc>
    6270:	48 89 18             	mov    %rbx,(%rax)
    6273:	5b                   	pop    %rbx
    6274:	c3                   	ret
    6275:	48 8d 3d 1d 87 00 00 	lea    0x871d(%rip),%rdi        # e999 <exec_in_fp0+0x299>
    627c:	e8 bf de ff ff       	call   4140 <fwp_trap>
    6281:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6288:	0f 1f 84 00 00 00 00 
    628f:	00 

0000000000006290 <fwp_alloc>:
    6290:	be 02 00 00 00       	mov    $0x2,%esi
    6295:	e9 f6 e1 ff ff       	jmp    4490 <fwp_gc_alloc>
    629a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000062a0 <f12>:
    62a0:	e9 fb fe ff ff       	jmp    61a0 <fwp_p_array_make_typed>
    62a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    62ac:	00 00 00 00 

00000000000062b0 <f14>:
    62b0:	e9 eb fe ff ff       	jmp    61a0 <fwp_p_array_make_typed>
    62b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    62bc:	00 00 00 00 

00000000000062c0 <f16>:
    62c0:	e9 db fe ff ff       	jmp    61a0 <fwp_p_array_make_typed>
    62c5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    62cc:	00 00 00 00 

00000000000062d0 <f18>:
    62d0:	e9 cb fe ff ff       	jmp    61a0 <fwp_p_array_make_typed>
    62d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    62dc:	00 00 00 00 

00000000000062e0 <f20>:
    62e0:	e9 bb fe ff ff       	jmp    61a0 <fwp_p_array_make_typed>
    62e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    62ec:	00 00 00 00 

00000000000062f0 <f22>:
    62f0:	e9 ab fe ff ff       	jmp    61a0 <fwp_p_array_make_typed>
    62f5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    62fc:	00 00 00 00 

0000000000006300 <f24>:
    6300:	e9 9b fe ff ff       	jmp    61a0 <fwp_p_array_make_typed>
    6305:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    630c:	00 00 00 00 

0000000000006310 <fwp_stack_guard_init>:
    6310:	53                   	push   %rbx
    6311:	48 81 ec c0 00 00 00 	sub    $0xc0,%rsp
    6318:	48 8d 44 24 0f       	lea    0xf(%rsp),%rax
    631d:	48 89 05 e4 00 01 00 	mov    %rax,0x100e4(%rip)        # 16408 <fwp_main_stack_top>
    6324:	48 89 3d e5 00 01 00 	mov    %rdi,0x100e5(%rip)        # 16410 <fwp_main_stack_size>
    632b:	48 8d 05 ee 00 01 00 	lea    0x100ee(%rip),%rax        # 16420 <fwp_stack_guard_init.alt>
    6332:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    6337:	48 c7 44 24 20 00 00 	movq   $0x10000,0x20(%rsp)
    633e:	01 00 
    6340:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%rsp)
    6347:	00 
    6348:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    634d:	31 f6                	xor    %esi,%esi
    634f:	e8 7c d1 ff ff       	call   34d0 <sigaltstack@plt>
    6354:	85 c0                	test   %eax,%eax
    6356:	0f 85 80 00 00 00    	jne    63dc <fwp_stack_guard_init+0xcc>
    635c:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    6361:	0f 57 c0             	xorps  %xmm0,%xmm0
    6364:	0f 11 84 24 b0 00 00 	movups %xmm0,0xb0(%rsp)
    636b:	00 
    636c:	0f 11 84 24 a0 00 00 	movups %xmm0,0xa0(%rsp)
    6373:	00 
    6374:	0f 11 84 24 90 00 00 	movups %xmm0,0x90(%rsp)
    637b:	00 
    637c:	0f 11 84 24 80 00 00 	movups %xmm0,0x80(%rsp)
    6383:	00 
    6384:	0f 11 44 24 70       	movups %xmm0,0x70(%rsp)
    6389:	0f 11 44 24 60       	movups %xmm0,0x60(%rsp)
    638e:	0f 11 44 24 50       	movups %xmm0,0x50(%rsp)
    6393:	0f 11 44 24 40       	movups %xmm0,0x40(%rsp)
    6398:	0f 11 44 24 30       	movups %xmm0,0x30(%rsp)
    639d:	48 8d 05 7c 07 00 00 	lea    0x77c(%rip),%rax        # 6b20 <fwp_segv>
    63a4:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    63a9:	c7 84 24 b0 00 00 00 	movl   $0x8000004,0xb0(%rsp)
    63b0:	04 00 00 08 
    63b4:	e8 57 cf ff ff       	call   3310 <sigemptyset@plt>
    63b9:	48 8d 5c 24 28       	lea    0x28(%rsp),%rbx
    63be:	bf 0b 00 00 00       	mov    $0xb,%edi
    63c3:	48 89 de             	mov    %rbx,%rsi
    63c6:	31 d2                	xor    %edx,%edx
    63c8:	e8 13 cd ff ff       	call   30e0 <sigaction@plt>
    63cd:	bf 07 00 00 00       	mov    $0x7,%edi
    63d2:	48 89 de             	mov    %rbx,%rsi
    63d5:	31 d2                	xor    %edx,%edx
    63d7:	e8 04 cd ff ff       	call   30e0 <sigaction@plt>
    63dc:	48 81 c4 c0 00 00 00 	add    $0xc0,%rsp
    63e3:	5b                   	pop    %rbx
    63e4:	c3                   	ret
    63e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    63ec:	00 00 00 00 

00000000000063f0 <fwp_exec>:
    63f0:	55                   	push   %rbp
    63f1:	41 57                	push   %r15
    63f3:	41 56                	push   %r14
    63f5:	41 55                	push   %r13
    63f7:	41 54                	push   %r12
    63f9:	53                   	push   %rbx
    63fa:	48 81 ec 58 01 00 00 	sub    $0x158,%rsp
    6401:	49 89 f7             	mov    %rsi,%r15
    6404:	41 89 fd             	mov    %edi,%r13d
    6407:	41 8d 5d ff          	lea    -0x1(%r13),%ebx
    640b:	80 3d ee ff 00 00 01 	cmpb   $0x1,0xffee(%rip)        # 16400 <fwp_cli_single>
    6412:	75 16                	jne    642a <fwp_exec+0x3a>
    6414:	49 8d 77 08          	lea    0x8(%r15),%rsi
    6418:	89 df                	mov    %ebx,%edi
    641a:	e8 91 07 00 00       	call   6bb0 <fwp_generated>
    641f:	41 89 c6             	mov    %eax,%r14d
    6422:	85 c0                	test   %eax,%eax
    6424:	0f 89 1a 01 00 00    	jns    6544 <fwp_exec+0x154>
    642a:	89 5c 24 18          	mov    %ebx,0x18(%rsp)
    642e:	49 63 fd             	movslq %r13d,%rdi
    6431:	48 c1 e7 03          	shl    $0x3,%rdi
    6435:	48 89 7c 24 48       	mov    %rdi,0x48(%rsp)
    643a:	e8 51 fe ff ff       	call   6290 <fwp_alloc>
    643f:	49 89 c4             	mov    %rax,%r12
    6442:	41 83 fd 02          	cmp    $0x2,%r13d
    6446:	7c 30                	jl     6478 <fwp_exec+0x88>
    6448:	8b 6c 24 18          	mov    0x18(%rsp),%ebp
    644c:	31 db                	xor    %ebx,%ebx
    644e:	66 90                	xchg   %ax,%ax
    6450:	4c 8d 73 01          	lea    0x1(%rbx),%r14
    6454:	4d 8b 6c df 08       	mov    0x8(%r15,%rbx,8),%r13
    6459:	4c 89 ef             	mov    %r13,%rdi
    645c:	e8 0f cd ff ff       	call   3170 <strlen@plt>
    6461:	4c 89 ef             	mov    %r13,%rdi
    6464:	48 89 c6             	mov    %rax,%rsi
    6467:	e8 a4 08 00 00       	call   6d10 <fwp_str_lossy>
    646c:	49 89 04 dc          	mov    %rax,(%r12,%rbx,8)
    6470:	4c 89 f3             	mov    %r14,%rbx
    6473:	4c 39 f5             	cmp    %r14,%rbp
    6476:	75 d8                	jne    6450 <fwp_exec+0x60>
    6478:	bf 08 00 00 00       	mov    $0x8,%edi
    647d:	e8 0e fe ff ff       	call   6290 <fwp_alloc>
    6482:	bf 01 00 00 00       	mov    $0x1,%edi
    6487:	e8 64 0a 00 00       	call   6ef0 <fwp_alloc_leaf>
    648c:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
    6491:	e8 fa fd ff ff       	call   6290 <fwp_alloc>
    6496:	49 89 c6             	mov    %rax,%r14
    6499:	48 8d 4c 24 2c       	lea    0x2c(%rsp),%rcx
    649e:	8b 7c 24 18          	mov    0x18(%rsp),%edi
    64a2:	4c 89 e6             	mov    %r12,%rsi
    64a5:	48 89 c2             	mov    %rax,%rdx
    64a8:	e8 53 0a 00 00       	call   6f00 <fwp_cli_parse>
    64ad:	83 f8 02             	cmp    $0x2,%eax
    64b0:	74 32                	je     64e4 <fwp_exec+0xf4>
    64b2:	83 f8 01             	cmp    $0x1,%eax
    64b5:	75 5d                	jne    6514 <fwp_exec+0x124>
    64b7:	48 8b 1d f2 da 00 00 	mov    0xdaf2(%rip),%rbx        # 13fb0 <stdout@GLIBC_2.2.5>
    64be:	48 8b 0b             	mov    (%rbx),%rcx
    64c1:	48 8d 3d 84 90 00 00 	lea    0x9084(%rip),%rdi        # f54c <exec_in_fp0+0xe4c>
    64c8:	be 70 00 00 00       	mov    $0x70,%esi
    64cd:	ba 01 00 00 00       	mov    $0x1,%edx
    64d2:	e8 c9 cf ff ff       	call   34a0 <fwrite@plt>
    64d7:	48 8b 3b             	mov    (%rbx),%rdi
    64da:	e8 71 ce ff ff       	call   3350 <fflush@plt>
    64df:	45 31 f6             	xor    %r14d,%r14d
    64e2:	eb 60                	jmp    6544 <fwp_exec+0x154>
    64e4:	48 8d 3d d6 8c 00 00 	lea    0x8cd6(%rip),%rdi        # f1c1 <exec_in_fp0+0xac1>
    64eb:	48 8d 15 f5 82 00 00 	lea    0x82f5(%rip),%rdx        # e7e7 <exec_in_fp0+0xe7>
    64f2:	45 31 f6             	xor    %r14d,%r14d
    64f5:	be 04 00 00 00       	mov    $0x4,%esi
    64fa:	31 c9                	xor    %ecx,%ecx
    64fc:	31 c0                	xor    %eax,%eax
    64fe:	e8 bd cc ff ff       	call   31c0 <printf@plt>
    6503:	48 8b 05 a6 da 00 00 	mov    0xdaa6(%rip),%rax        # 13fb0 <stdout@GLIBC_2.2.5>
    650a:	48 8b 38             	mov    (%rax),%rdi
    650d:	e8 3e ce ff ff       	call   3350 <fflush@plt>
    6512:	eb 30                	jmp    6544 <fwp_exec+0x154>
    6514:	bf 10 00 00 00       	mov    $0x10,%edi
    6519:	e8 72 fd ff ff       	call   6290 <fwp_alloc>
    651e:	49 89 c7             	mov    %rax,%r15
    6521:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%rsp)
    6528:	00 
    6529:	8b 74 24 2c          	mov    0x2c(%rsp),%esi
    652d:	48 8d 4c 24 14       	lea    0x14(%rsp),%rcx
    6532:	4c 89 f7             	mov    %r14,%rdi
    6535:	48 89 c2             	mov    %rax,%rdx
    6538:	e8 23 0c 00 00       	call   7160 <fwp_bind_positional>
    653d:	41 89 c6             	mov    %eax,%r14d
    6540:	85 c0                	test   %eax,%eax
    6542:	74 15                	je     6559 <fwp_exec+0x169>
    6544:	44 89 f0             	mov    %r14d,%eax
    6547:	48 81 c4 58 01 00 00 	add    $0x158,%rsp
    654e:	5b                   	pop    %rbx
    654f:	41 5c                	pop    %r12
    6551:	41 5d                	pop    %r13
    6553:	41 5e                	pop    %r14
    6555:	41 5f                	pop    %r15
    6557:	5d                   	pop    %rbp
    6558:	c3                   	ret
    6559:	48 8d 3d 6a 8c 00 00 	lea    0x8c6a(%rip),%rdi        # f1ca <exec_in_fp0+0xaca>
    6560:	e8 cb ca ff ff       	call   3030 <getenv@plt>
    6565:	48 85 c0             	test   %rax,%rax
    6568:	74 27                	je     6591 <fwp_exec+0x1a1>
    656a:	48 8d 35 61 8c 00 00 	lea    0x8c61(%rip),%rsi        # f1d2 <exec_in_fp0+0xad2>
    6571:	48 89 c7             	mov    %rax,%rdi
    6574:	e8 57 cd ff ff       	call   32d0 <strcmp@plt>
    6579:	31 c9                	xor    %ecx,%ecx
    657b:	85 c0                	test   %eax,%eax
    657d:	0f 94 c1             	sete   %cl
    6580:	89 0d 9a fe 01 00    	mov    %ecx,0x1fe9a(%rip)        # 26420 <fwp_exec_binary_out>
    6586:	75 26                	jne    65ae <fwp_exec+0x1be>
    6588:	48 8b 05 49 da 00 00 	mov    0xda49(%rip),%rax        # 13fd8 <stderr@GLIBC_2.2.5>
    658f:	eb 24                	jmp    65b5 <fwp_exec+0x1c5>
    6591:	c7 05 85 fe 01 00 00 	movl   $0x0,0x1fe85(%rip)        # 26420 <fwp_exec_binary_out>
    6598:	00 00 00 
    659b:	48 8b 05 0e da 00 00 	mov    0xda0e(%rip),%rax        # 13fb0 <stdout@GLIBC_2.2.5>
    65a2:	48 8b 00             	mov    (%rax),%rax
    65a5:	48 89 05 fc fd 00 00 	mov    %rax,0xfdfc(%rip)        # 163a8 <fwp_prog_out>
    65ac:	eb 33                	jmp    65e1 <fwp_exec+0x1f1>
    65ae:	48 8b 05 fb d9 00 00 	mov    0xd9fb(%rip),%rax        # 13fb0 <stdout@GLIBC_2.2.5>
    65b5:	48 8b 00             	mov    (%rax),%rax
    65b8:	48 89 05 e9 fd 00 00 	mov    %rax,0xfde9(%rip)        # 163a8 <fwp_prog_out>
    65bf:	75 20                	jne    65e1 <fwp_exec+0x1f1>
    65c1:	e8 da 0b 00 00       	call   71a0 <fwp_pipe_out_start>
    65c6:	48 8d 3d a3 80 00 00 	lea    0x80a3(%rip),%rdi        # e670 <exec_out_header0>
    65cd:	be 8b 00 00 00       	mov    $0x8b,%esi
    65d2:	e8 99 0c 00 00       	call   7270 <fwp_pipe_write>
    65d7:	e8 44 0d 00 00       	call   7320 <fwp_pipe_flush>
    65dc:	e8 6f 0d 00 00       	call   7350 <fwp_pipe_out_ready>
    65e1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%rsp)
    65e8:	00 
    65e9:	83 7c 24 14 00       	cmpl   $0x0,0x14(%rsp)
    65ee:	0f 84 57 01 00 00    	je     674b <fwp_exec+0x35b>
    65f4:	48 8b 1d bd d9 00 00 	mov    0xd9bd(%rip),%rbx        # 13fb8 <stdin@GLIBC_2.2.5>
    65fb:	48 8b 3b             	mov    (%rbx),%rdi
    65fe:	b9 00 00 10 00       	mov    $0x100000,%ecx
    6603:	31 f6                	xor    %esi,%esi
    6605:	31 d2                	xor    %edx,%edx
    6607:	e8 a4 cd ff ff       	call   33b0 <setvbuf@plt>
    660c:	48 8b 0b             	mov    (%rbx),%rcx
    660f:	48 8d 3d 0e fe 01 00 	lea    0x1fe0e(%rip),%rdi        # 26424 <fwp_in_pend>
    6616:	be 01 00 00 00       	mov    $0x1,%esi
    661b:	ba 04 00 00 00       	mov    $0x4,%edx
    6620:	e8 cb ca ff ff       	call   30f0 <fread@plt>
    6625:	89 05 fd fd 01 00    	mov    %eax,0x1fdfd(%rip)        # 26428 <fwp_in_npend>
    662b:	c7 05 f7 fd 01 00 00 	movl   $0x0,0x1fdf7(%rip)        # 2642c <fwp_in_ppos>
    6632:	00 00 00 
    6635:	41 b4 01             	mov    $0x1,%r12b
    6638:	83 f8 04             	cmp    $0x4,%eax
    663b:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    6640:	0f 85 d3 01 00 00    	jne    6819 <fwp_exec+0x429>
    6646:	81 3d d4 fd 01 00 46 	cmpl   $0x31505746,0x1fdd4(%rip)        # 26424 <fwp_in_pend>
    664d:	57 50 31 
    6650:	0f 85 c3 01 00 00    	jne    6819 <fwp_exec+0x429>
    6656:	c7 05 cc fd 01 00 04 	movl   $0x4,0x1fdcc(%rip)        # 2642c <fwp_in_ppos>
    665d:	00 00 00 
    6660:	48 8d 7c 24 03       	lea    0x3(%rsp),%rdi
    6665:	be 01 00 00 00       	mov    $0x1,%esi
    666a:	e8 41 0e 00 00       	call   74b0 <fwp_read_exact>
    666f:	85 c0                	test   %eax,%eax
    6671:	0f 84 c3 03 00 00    	je     6a3a <fwp_exec+0x64a>
    6677:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
    667c:	e8 2f 0f 00 00       	call   75b0 <fwp_stdin_leb>
    6681:	83 f8 01             	cmp    $0x1,%eax
    6684:	0f 85 99 03 00 00    	jne    6a23 <fwp_exec+0x633>
    668a:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    668f:	48 83 f8 40          	cmp    $0x40,%rax
    6693:	41 bd 40 00 00 00    	mov    $0x40,%r13d
    6699:	4c 0f 42 e8          	cmovb  %rax,%r13
    669d:	48 85 c0             	test   %rax,%rax
    66a0:	0f 84 e2 00 00 00    	je     6788 <fwp_exec+0x398>
    66a6:	45 31 f6             	xor    %r14d,%r14d
    66a9:	4c 8d 7c 24 50       	lea    0x50(%rsp),%r15
    66ae:	31 ed                	xor    %ebp,%ebp
    66b0:	eb 4a                	jmp    66fc <fwp_exec+0x30c>
    66b2:	be 06 00 00 00       	mov    $0x6,%esi
    66b7:	4c 89 ff             	mov    %r15,%rdi
    66ba:	e8 f1 0d 00 00       	call   74b0 <fwp_read_exact>
    66bf:	85 c0                	test   %eax,%eax
    66c1:	0f 84 73 03 00 00    	je     6a3a <fwp_exec+0x64a>
    66c7:	8b 44 24 50          	mov    0x50(%rsp),%eax
    66cb:	b9 55 44 53 5f       	mov    $0x5f534455,%ecx
    66d0:	31 c8                	xor    %ecx,%eax
    66d2:	0f b7 4c 24 54       	movzwl 0x54(%rsp),%ecx
    66d7:	81 f1 56 31 00 00    	xor    $0x3156,%ecx
    66dd:	09 c1                	or     %eax,%ecx
    66df:	b8 01 00 00 00       	mov    $0x1,%eax
    66e4:	0f 44 e8             	cmove  %eax,%ebp
    66e7:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
    66ee:	00 00 
    66f0:	49 ff c6             	inc    %r14
    66f3:	4d 39 ee             	cmp    %r13,%r14
    66f6:	0f 84 8e 00 00 00    	je     678a <fwp_exec+0x39a>
    66fc:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    6701:	e8 2a 0f 00 00       	call   7630 <fwp_stdin_name_len>
    6706:	83 f8 01             	cmp    $0x1,%eax
    6709:	0f 85 14 03 00 00    	jne    6a23 <fwp_exec+0x633>
    670f:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    6714:	48 85 db             	test   %rbx,%rbx
    6717:	74 ce                	je     66e7 <fwp_exec+0x2f7>
    6719:	48 83 fb 06          	cmp    $0x6,%rbx
    671d:	74 93                	je     66b2 <fwp_exec+0x2c2>
    671f:	90                   	nop
    6720:	48 81 fb 00 01 00 00 	cmp    $0x100,%rbx
    6727:	41 bc 00 01 00 00    	mov    $0x100,%r12d
    672d:	4c 0f 42 e3          	cmovb  %rbx,%r12
    6731:	4c 89 ff             	mov    %r15,%rdi
    6734:	4c 89 e6             	mov    %r12,%rsi
    6737:	e8 74 0d 00 00       	call   74b0 <fwp_read_exact>
    673c:	85 c0                	test   %eax,%eax
    673e:	0f 84 f6 02 00 00    	je     6a3a <fwp_exec+0x64a>
    6744:	4c 29 e3             	sub    %r12,%rbx
    6747:	75 d7                	jne    6720 <fwp_exec+0x330>
    6749:	eb 9c                	jmp    66e7 <fwp_exec+0x2f7>
    674b:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
    6750:	4c 89 ff             	mov    %r15,%rdi
    6753:	e8 98 0c 00 00       	call   73f0 <fwp_exec_call>
    6758:	48 89 c3             	mov    %rax,%rbx
    675b:	48 8b 3d 46 fc 00 00 	mov    0xfc46(%rip),%rdi        # 163a8 <fwp_prog_out>
    6762:	e8 e9 cb ff ff       	call   3350 <fflush@plt>
    6767:	41 be 01 00 00 00    	mov    $0x1,%r14d
    676d:	83 7c 24 04 00       	cmpl   $0x0,0x4(%rsp)
    6772:	0f 85 83 02 00 00    	jne    69fb <fwp_exec+0x60b>
    6778:	48 89 df             	mov    %rbx,%rdi
    677b:	e8 20 0d 00 00       	call   74a0 <fwp_emit_result>
    6780:	45 31 f6             	xor    %r14d,%r14d
    6783:	e9 73 02 00 00       	jmp    69fb <fwp_exec+0x60b>
    6788:	31 ed                	xor    %ebp,%ebp
    678a:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    678f:	be 10 00 00 00       	mov    $0x10,%esi
    6794:	e8 17 0d 00 00       	call   74b0 <fwp_read_exact>
    6799:	85 c0                	test   %eax,%eax
    679b:	0f 84 99 02 00 00    	je     6a3a <fwp_exec+0x64a>
    67a1:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    67a6:	e8 85 0e 00 00       	call   7630 <fwp_stdin_name_len>
    67ab:	83 f8 01             	cmp    $0x1,%eax
    67ae:	0f 85 6f 02 00 00    	jne    6a23 <fwp_exec+0x633>
    67b4:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    67b9:	49 8d 7f 01          	lea    0x1(%r15),%rdi
    67bd:	e8 2e 07 00 00       	call   6ef0 <fwp_alloc_leaf>
    67c2:	49 89 c6             	mov    %rax,%r14
    67c5:	4d 85 ff             	test   %r15,%r15
    67c8:	74 13                	je     67dd <fwp_exec+0x3ed>
    67ca:	4c 89 f7             	mov    %r14,%rdi
    67cd:	4c 89 fe             	mov    %r15,%rsi
    67d0:	e8 db 0c 00 00       	call   74b0 <fwp_read_exact>
    67d5:	85 c0                	test   %eax,%eax
    67d7:	0f 84 5d 02 00 00    	je     6a3a <fwp_exec+0x64a>
    67dd:	43 c6 04 3e 00       	movb   $0x0,(%r14,%r15,1)
    67e2:	0f b6 4c 24 03       	movzbl 0x3(%rsp),%ecx
    67e7:	83 f9 01             	cmp    $0x1,%ecx
    67ea:	0f 85 ab 02 00 00    	jne    6a9b <fwp_exec+0x6ab>
    67f0:	66 0f 6f 44 24 30    	movdqa 0x30(%rsp),%xmm0
    67f6:	66 0f 74 05 f2 78 00 	pcmpeqb 0x78f2(%rip),%xmm0        # e0f0 <_IO_stdin_used+0xf0>
    67fd:	00 
    67fe:	66 0f d7 c0          	pmovmskb %xmm0,%eax
    6802:	3d ff ff 00 00       	cmp    $0xffff,%eax
    6807:	0f 85 af 02 00 00    	jne    6abc <fwp_exec+0x6cc>
    680d:	85 ed                	test   %ebp,%ebp
    680f:	74 05                	je     6816 <fwp_exec+0x426>
    6811:	e8 4a 0e 00 00       	call   7660 <fwp_pipe_in_offer>
    6816:	45 31 e4             	xor    %r12d,%r12d
    6819:	66 0f ef c0          	pxor   %xmm0,%xmm0
    681d:	66 0f 7f 44 24 50    	movdqa %xmm0,0x50(%rsp)
    6823:	48 c7 44 24 60 00 00 	movq   $0x0,0x60(%rsp)
    682a:	00 00 
    682c:	45 31 ff             	xor    %r15d,%r15d
    682f:	45 31 f6             	xor    %r14d,%r14d
    6832:	eb 35                	jmp    6869 <fwp_exec+0x479>
    6834:	48 89 ef             	mov    %rbp,%rdi
    6837:	4c 89 ee             	mov    %r13,%rsi
    683a:	e8 21 0f 00 00       	call   7760 <fwp_pipe_in_switch>
    683f:	bb 10 00 00 00       	mov    $0x10,%ebx
    6844:	48 8d 35 03 8a 00 00 	lea    0x8a03(%rip),%rsi        # f24e <exec_in_fp0+0xb4e>
    684b:	85 c0                	test   %eax,%eax
    684d:	0f 84 6b 01 00 00    	je     69be <fwp_exec+0x5ce>
    6853:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    685a:	84 00 00 00 00 00 
    6860:	83 fb 0f             	cmp    $0xf,%ebx
    6863:	0f 84 83 01 00 00    	je     69ec <fwp_exec+0x5fc>
    6869:	45 84 e4             	test   %r12b,%r12b
    686c:	0f 84 9e 00 00 00    	je     6910 <fwp_exec+0x520>
    6872:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    6877:	e8 44 15 00 00       	call   7dc0 <fwp_read_text_line>
    687c:	4c 8b 7c 24 50       	mov    0x50(%rsp),%r15
    6881:	85 c0                	test   %eax,%eax
    6883:	0f 84 63 01 00 00    	je     69ec <fwp_exec+0x5fc>
    6889:	4d 85 ff             	test   %r15,%r15
    688c:	4c 89 ff             	mov    %r15,%rdi
    688f:	48 8d 05 4b 86 00 00 	lea    0x864b(%rip),%rax        # eee1 <exec_in_fp0+0x7e1>
    6896:	48 0f 44 f8          	cmove  %rax,%rdi
    689a:	48 8b 74 24 58       	mov    0x58(%rsp),%rsi
    689f:	e8 6c 04 00 00       	call   6d10 <fwp_str_lossy>
    68a4:	48 89 c5             	mov    %rax,%rbp
    68a7:	4c 8d 68 08          	lea    0x8(%rax),%r13
    68ab:	48 8b 30             	mov    (%rax),%rsi
    68ae:	4c 89 ef             	mov    %r13,%rdi
    68b1:	48 8d 54 24 20       	lea    0x20(%rsp),%rdx
    68b6:	e8 e5 07 00 00       	call   70a0 <fwp_parse_text>
    68bb:	85 c0                	test   %eax,%eax
    68bd:	0f 84 a1 01 00 00    	je     6a64 <fwp_exec+0x674>
    68c3:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    68c8:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    68cd:	48 89 07             	mov    %rax,(%rdi)
    68d0:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
    68d5:	e8 16 0b 00 00       	call   73f0 <fwp_exec_call>
    68da:	49 89 c5             	mov    %rax,%r13
    68dd:	48 8b 3d c4 fa 00 00 	mov    0xfac4(%rip),%rdi        # 163a8 <fwp_prog_out>
    68e4:	e8 67 ca ff ff       	call   3350 <fflush@plt>
    68e9:	83 7c 24 04 00       	cmpl   $0x0,0x4(%rsp)
    68ee:	0f 85 f2 00 00 00    	jne    69e6 <fwp_exec+0x5f6>
    68f4:	4c 89 ef             	mov    %r13,%rdi
    68f7:	e8 a4 0b 00 00       	call   74a0 <fwp_emit_result>
    68fc:	e8 1f 0a 00 00       	call   7320 <fwp_pipe_flush>
    6901:	31 db                	xor    %ebx,%ebx
    6903:	e9 58 ff ff ff       	jmp    6860 <fwp_exec+0x470>
    6908:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    690f:	00 
    6910:	be 01 00 00 00       	mov    $0x1,%esi
    6915:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    691a:	e8 91 0b 00 00       	call   74b0 <fwp_read_exact>
    691f:	bb 0f 00 00 00       	mov    $0xf,%ebx
    6924:	85 c0                	test   %eax,%eax
    6926:	0f 84 34 ff ff ff    	je     6860 <fwp_exec+0x470>
    692c:	be 04 00 00 00       	mov    $0x4,%esi
    6931:	48 8d 7c 24 09       	lea    0x9(%rsp),%rdi
    6936:	e8 75 0b 00 00       	call   74b0 <fwp_read_exact>
    693b:	48 8d 35 f7 88 00 00 	lea    0x88f7(%rip),%rsi        # f239 <exec_in_fp0+0xb39>
    6942:	85 c0                	test   %eax,%eax
    6944:	74 78                	je     69be <fwp_exec+0x5ce>
    6946:	44 8b 6c 24 09       	mov    0x9(%rsp),%r13d
    694b:	49 8d 7d 01          	lea    0x1(%r13),%rdi
    694f:	e8 9c 05 00 00       	call   6ef0 <fwp_alloc_leaf>
    6954:	48 89 c5             	mov    %rax,%rbp
    6957:	4d 85 ed             	test   %r13,%r13
    695a:	74 16                	je     6972 <fwp_exec+0x582>
    695c:	48 89 ef             	mov    %rbp,%rdi
    695f:	4c 89 ee             	mov    %r13,%rsi
    6962:	e8 49 0b 00 00       	call   74b0 <fwp_read_exact>
    6967:	48 8d 35 cb 88 00 00 	lea    0x88cb(%rip),%rsi        # f239 <exec_in_fp0+0xb39>
    696e:	85 c0                	test   %eax,%eax
    6970:	74 4c                	je     69be <fwp_exec+0x5ce>
    6972:	0f b6 44 24 08       	movzbl 0x8(%rsp),%eax
    6977:	85 c0                	test   %eax,%eax
    6979:	0f 84 e1 fe ff ff    	je     6860 <fwp_exec+0x470>
    697f:	83 f8 02             	cmp    $0x2,%eax
    6982:	0f 84 ac fe ff ff    	je     6834 <fwp_exec+0x444>
    6988:	48 89 6c 24 30       	mov    %rbp,0x30(%rsp)
    698d:	4c 89 6c 24 38       	mov    %r13,0x38(%rsp)
    6992:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    6999:	00 00 
    699b:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    69a0:	48 8d 35 81 f3 00 00 	lea    0xf381(%rip),%rsi        # 15d28 <d0>
    69a7:	48 8d 54 24 20       	lea    0x20(%rsp),%rdx
    69ac:	e8 cf 0f 00 00       	call   7980 <fwp_decode>
    69b1:	85 c0                	test   %eax,%eax
    69b3:	0f 85 0a ff ff ff    	jne    68c3 <fwp_exec+0x4d3>
    69b9:	e9 2c 01 00 00       	jmp    6aea <fwp_exec+0x6fa>
    69be:	48 8b 05 13 d6 00 00 	mov    0xd613(%rip),%rax        # 13fd8 <stderr@GLIBC_2.2.5>
    69c5:	48 8b 38             	mov    (%rax),%rdi
    69c8:	48 8d 15 18 7e 00 00 	lea    0x7e18(%rip),%rdx        # e7e7 <exec_in_fp0+0xe7>
    69cf:	31 c0                	xor    %eax,%eax
    69d1:	e8 1a c9 ff ff       	call   32f0 <fprintf@plt>
    69d6:	41 be 03 00 00 00    	mov    $0x3,%r14d
    69dc:	bb 0f 00 00 00       	mov    $0xf,%ebx
    69e1:	e9 7a fe ff ff       	jmp    6860 <fwp_exec+0x470>
    69e6:	41 be 01 00 00 00    	mov    $0x1,%r14d
    69ec:	31 ff                	xor    %edi,%edi
    69ee:	e8 dd 14 00 00       	call   7ed0 <fwp_mem_free>
    69f3:	4c 89 ff             	mov    %r15,%rdi
    69f6:	e8 55 c6 ff ff       	call   3050 <free@plt>
    69fb:	83 3d 1e fa 01 00 00 	cmpl   $0x0,0x1fa1e(%rip)        # 26420 <fwp_exec_binary_out>
    6a02:	0f 84 fb fa ff ff    	je     6503 <fwp_exec+0x113>
    6a08:	48 8d 3d 5c 7c 00 00 	lea    0x7c5c(%rip),%rdi        # e66b <fwp_exec.end>
    6a0f:	be 05 00 00 00       	mov    $0x5,%esi
    6a14:	e8 57 08 00 00       	call   7270 <fwp_pipe_write>
    6a19:	e8 92 16 00 00       	call   80b0 <fwp_pipe_out_end>
    6a1e:	e9 e0 fa ff ff       	jmp    6503 <fwp_exec+0x113>
    6a23:	85 c0                	test   %eax,%eax
    6a25:	79 13                	jns    6a3a <fwp_exec+0x64a>
    6a27:	48 8b 05 aa d5 00 00 	mov    0xd5aa(%rip),%rax        # 13fd8 <stderr@GLIBC_2.2.5>
    6a2e:	48 8b 38             	mov    (%rax),%rdi
    6a31:	48 8d 35 66 88 00 00 	lea    0x8866(%rip),%rsi        # f29e <exec_in_fp0+0xb9e>
    6a38:	eb 11                	jmp    6a4b <fwp_exec+0x65b>
    6a3a:	48 8b 05 97 d5 00 00 	mov    0xd597(%rip),%rax        # 13fd8 <stderr@GLIBC_2.2.5>
    6a41:	48 8b 38             	mov    (%rax),%rdi
    6a44:	48 8d 35 63 88 00 00 	lea    0x8863(%rip),%rsi        # f2ae <exec_in_fp0+0xbae>
    6a4b:	48 8d 15 95 7d 00 00 	lea    0x7d95(%rip),%rdx        # e7e7 <exec_in_fp0+0xe7>
    6a52:	31 c0                	xor    %eax,%eax
    6a54:	e8 97 c8 ff ff       	call   32f0 <fprintf@plt>
    6a59:	41 be 03 00 00 00    	mov    $0x3,%r14d
    6a5f:	e9 e0 fa ff ff       	jmp    6544 <fwp_exec+0x154>
    6a64:	48 8b 05 6d d5 00 00 	mov    0xd56d(%rip),%rax        # 13fd8 <stderr@GLIBC_2.2.5>
    6a6b:	48 8b 38             	mov    (%rax),%rdi
    6a6e:	8b 4d 00             	mov    0x0(%rbp),%ecx
    6a71:	48 8d 35 01 88 00 00 	lea    0x8801(%rip),%rsi        # f279 <exec_in_fp0+0xb79>
    6a78:	48 8d 15 68 7d 00 00 	lea    0x7d68(%rip),%rdx        # e7e7 <exec_in_fp0+0xe7>
    6a7f:	4c 8d 0d 37 8b 00 00 	lea    0x8b37(%rip),%r9        # f5bd <exec_in_fp0+0xebd>
    6a86:	4d 89 e8             	mov    %r13,%r8
    6a89:	31 c0                	xor    %eax,%eax
    6a8b:	e8 60 c8 ff ff       	call   32f0 <fprintf@plt>
    6a90:	41 be 03 00 00 00    	mov    $0x3,%r14d
    6a96:	e9 51 ff ff ff       	jmp    69ec <fwp_exec+0x5fc>
    6a9b:	48 8b 05 36 d5 00 00 	mov    0xd536(%rip),%rax        # 13fd8 <stderr@GLIBC_2.2.5>
    6aa2:	48 8b 38             	mov    (%rax),%rdi
    6aa5:	48 8d 35 36 87 00 00 	lea    0x8736(%rip),%rsi        # f1e2 <exec_in_fp0+0xae2>
    6aac:	48 8d 15 34 7d 00 00 	lea    0x7d34(%rip),%rdx        # e7e7 <exec_in_fp0+0xe7>
    6ab3:	31 c0                	xor    %eax,%eax
    6ab5:	e8 36 c8 ff ff       	call   32f0 <fprintf@plt>
    6aba:	eb 9d                	jmp    6a59 <fwp_exec+0x669>
    6abc:	48 8b 05 15 d5 00 00 	mov    0xd515(%rip),%rax        # 13fd8 <stderr@GLIBC_2.2.5>
    6ac3:	48 8b 38             	mov    (%rax),%rdi
    6ac6:	48 8d 35 3a 87 00 00 	lea    0x873a(%rip),%rsi        # f207 <exec_in_fp0+0xb07>
    6acd:	48 8d 15 13 7d 00 00 	lea    0x7d13(%rip),%rdx        # e7e7 <exec_in_fp0+0xe7>
    6ad4:	48 8d 0d e2 8a 00 00 	lea    0x8ae2(%rip),%rcx        # f5bd <exec_in_fp0+0xebd>
    6adb:	4d 89 f0             	mov    %r14,%r8
    6ade:	31 c0                	xor    %eax,%eax
    6ae0:	e8 0b c8 ff ff       	call   32f0 <fprintf@plt>
    6ae5:	e9 6f ff ff ff       	jmp    6a59 <fwp_exec+0x669>
    6aea:	48 8b 05 e7 d4 00 00 	mov    0xd4e7(%rip),%rax        # 13fd8 <stderr@GLIBC_2.2.5>
    6af1:	48 8b 38             	mov    (%rax),%rdi
    6af4:	48 8d 35 69 87 00 00 	lea    0x8769(%rip),%rsi        # f264 <exec_in_fp0+0xb64>
    6afb:	48 8d 15 e5 7c 00 00 	lea    0x7ce5(%rip),%rdx        # e7e7 <exec_in_fp0+0xe7>
    6b02:	31 c0                	xor    %eax,%eax
    6b04:	e8 e7 c7 ff ff       	call   32f0 <fprintf@plt>
    6b09:	41 be 03 00 00 00    	mov    $0x3,%r14d
    6b0f:	e9 d8 fe ff ff       	jmp    69ec <fwp_exec+0x5fc>
    6b14:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    6b1b:	00 00 00 00 00 

0000000000006b20 <fwp_segv>:
    6b20:	53                   	push   %rbx
    6b21:	48 8b 15 e0 f8 00 00 	mov    0xf8e0(%rip),%rdx        # 16408 <fwp_main_stack_top>
    6b28:	48 85 d2             	test   %rdx,%rdx
    6b2b:	74 29                	je     6b56 <fwp_segv+0x36>
    6b2d:	48 8b 46 10          	mov    0x10(%rsi),%rax
    6b31:	48 2b 15 d8 f8 00 00 	sub    0xf8d8(%rip),%rdx        # 16410 <fwp_main_stack_size>
    6b38:	48 8d b2 00 00 f0 ff 	lea    -0x100000(%rdx),%rsi
    6b3f:	48 81 c2 00 00 10 00 	add    $0x100000,%rdx
    6b46:	89 fb                	mov    %edi,%ebx
    6b48:	48 89 c7             	mov    %rax,%rdi
    6b4b:	e8 40 00 00 00       	call   6b90 <fwp_near>
    6b50:	89 df                	mov    %ebx,%edi
    6b52:	85 c0                	test   %eax,%eax
    6b54:	75 08                	jne    6b5e <fwp_segv+0x3e>
    6b56:	31 f6                	xor    %esi,%esi
    6b58:	5b                   	pop    %rbx
    6b59:	e9 82 c7 ff ff       	jmp    32e0 <signal@plt>
    6b5e:	e8 0d d6 ff ff       	call   4170 <fwp_flush>
    6b63:	48 8d 35 e6 7a 00 00 	lea    0x7ae6(%rip),%rsi        # e650 <fwp_segv.msg>
    6b6a:	ba 1a 00 00 00       	mov    $0x1a,%edx
    6b6f:	bf 02 00 00 00       	mov    $0x2,%edi
    6b74:	e8 c7 c5 ff ff       	call   3140 <write@plt>
    6b79:	bf 65 00 00 00       	mov    $0x65,%edi
    6b7e:	e8 1d c5 ff ff       	call   30a0 <_exit@plt>
    6b83:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6b8a:	84 00 00 00 00 00 

0000000000006b90 <fwp_near>:
    6b90:	48 39 f7             	cmp    %rsi,%rdi
    6b93:	0f 93 c0             	setae  %al
    6b96:	48 39 d7             	cmp    %rdx,%rdi
    6b99:	0f 92 c1             	setb   %cl
    6b9c:	20 c1                	and    %al,%cl
    6b9e:	0f b6 c1             	movzbl %cl,%eax
    6ba1:	c3                   	ret
    6ba2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6ba9:	1f 84 00 00 00 00 00 

0000000000006bb0 <fwp_generated>:
    6bb0:	55                   	push   %rbp
    6bb1:	41 57                	push   %r15
    6bb3:	41 56                	push   %r14
    6bb5:	53                   	push   %rbx
    6bb6:	50                   	push   %rax
    6bb7:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    6bbc:	85 ff                	test   %edi,%edi
    6bbe:	0f 8e 14 01 00 00    	jle    6cd8 <fwp_generated+0x128>
    6bc4:	89 fd                	mov    %edi,%ebp
    6bc6:	49 89 f7             	mov    %rsi,%r15
    6bc9:	4c 8b 36             	mov    (%rsi),%r14
    6bcc:	48 8d 35 f1 86 00 00 	lea    0x86f1(%rip),%rsi        # f2c4 <exec_in_fp0+0xbc4>
    6bd3:	4c 89 f7             	mov    %r14,%rdi
    6bd6:	e8 f5 c6 ff ff       	call   32d0 <strcmp@plt>
    6bdb:	85 c0                	test   %eax,%eax
    6bdd:	74 34                	je     6c13 <fwp_generated+0x63>
    6bdf:	48 8d 35 e4 86 00 00 	lea    0x86e4(%rip),%rsi        # f2ca <exec_in_fp0+0xbca>
    6be6:	ba 0d 00 00 00       	mov    $0xd,%edx
    6beb:	4c 89 f7             	mov    %r14,%rdi
    6bee:	e8 9d c4 ff ff       	call   3090 <strncmp@plt>
    6bf3:	85 c0                	test   %eax,%eax
    6bf5:	0f 85 dd 00 00 00    	jne    6cd8 <fwp_generated+0x128>
    6bfb:	41 0f b6 46 0d       	movzbl 0xd(%r14),%eax
    6c00:	85 c0                	test   %eax,%eax
    6c02:	74 2c                	je     6c30 <fwp_generated+0x80>
    6c04:	83 f8 3d             	cmp    $0x3d,%eax
    6c07:	0f 85 cb 00 00 00    	jne    6cd8 <fwp_generated+0x128>
    6c0d:	49 83 c6 0e          	add    $0xe,%r14
    6c11:	eb 2a                	jmp    6c3d <fwp_generated+0x8d>
    6c13:	48 8b 3d de f7 00 00 	mov    0xf7de(%rip),%rdi        # 163f8 <fwp_cli_man>
    6c1a:	48 8b 05 8f d3 00 00 	mov    0xd38f(%rip),%rax        # 13fb0 <stdout@GLIBC_2.2.5>
    6c21:	48 8b 30             	mov    (%rax),%rsi
    6c24:	e8 c7 c5 ff ff       	call   31f0 <fputs@plt>
    6c29:	31 db                	xor    %ebx,%ebx
    6c2b:	e9 a8 00 00 00       	jmp    6cd8 <fwp_generated+0x128>
    6c30:	83 fd 01             	cmp    $0x1,%ebp
    6c33:	0f 84 ac 00 00 00    	je     6ce5 <fwp_generated+0x135>
    6c39:	4d 8b 77 08          	mov    0x8(%r15),%r14
    6c3d:	48 8d 35 d2 86 00 00 	lea    0x86d2(%rip),%rsi        # f316 <exec_in_fp0+0xc16>
    6c44:	4c 89 f7             	mov    %r14,%rdi
    6c47:	e8 84 c6 ff ff       	call   32d0 <strcmp@plt>
    6c4c:	31 db                	xor    %ebx,%ebx
    6c4e:	85 c0                	test   %eax,%eax
    6c50:	74 63                	je     6cb5 <fwp_generated+0x105>
    6c52:	48 8d 35 c2 86 00 00 	lea    0x86c2(%rip),%rsi        # f31b <exec_in_fp0+0xc1b>
    6c59:	4c 89 f7             	mov    %r14,%rdi
    6c5c:	e8 6f c6 ff ff       	call   32d0 <strcmp@plt>
    6c61:	85 c0                	test   %eax,%eax
    6c63:	74 54                	je     6cb9 <fwp_generated+0x109>
    6c65:	48 8d 35 b3 86 00 00 	lea    0x86b3(%rip),%rsi        # f31f <exec_in_fp0+0xc1f>
    6c6c:	4c 89 f7             	mov    %r14,%rdi
    6c6f:	e8 5c c6 ff ff       	call   32d0 <strcmp@plt>
    6c74:	b9 02 00 00 00       	mov    $0x2,%ecx
    6c79:	85 c0                	test   %eax,%eax
    6c7b:	74 41                	je     6cbe <fwp_generated+0x10e>
    6c7d:	4c 89 f7             	mov    %r14,%rdi
    6c80:	e8 eb c4 ff ff       	call   3170 <strlen@plt>
    6c85:	4c 89 f7             	mov    %r14,%rdi
    6c88:	48 89 c6             	mov    %rax,%rsi
    6c8b:	e8 80 00 00 00       	call   6d10 <fwp_str_lossy>
    6c90:	48 8b 0d 41 d3 00 00 	mov    0xd341(%rip),%rcx        # 13fd8 <stderr@GLIBC_2.2.5>
    6c97:	48 8b 39             	mov    (%rcx),%rdi
    6c9a:	48 8d 48 08          	lea    0x8(%rax),%rcx
    6c9e:	48 8d 35 7f 86 00 00 	lea    0x867f(%rip),%rsi        # f324 <exec_in_fp0+0xc24>
    6ca5:	48 8d 15 3b 7b 00 00 	lea    0x7b3b(%rip),%rdx        # e7e7 <exec_in_fp0+0xe7>
    6cac:	31 c0                	xor    %eax,%eax
    6cae:	e8 3d c6 ff ff       	call   32f0 <fprintf@plt>
    6cb3:	eb 4f                	jmp    6d04 <fwp_generated+0x154>
    6cb5:	31 c9                	xor    %ecx,%ecx
    6cb7:	eb 05                	jmp    6cbe <fwp_generated+0x10e>
    6cb9:	b9 01 00 00 00       	mov    $0x1,%ecx
    6cbe:	48 8d 05 1b f7 00 00 	lea    0xf71b(%rip),%rax        # 163e0 <fwp_cli_scripts>
    6cc5:	48 8b 3c c8          	mov    (%rax,%rcx,8),%rdi
    6cc9:	48 8b 05 e0 d2 00 00 	mov    0xd2e0(%rip),%rax        # 13fb0 <stdout@GLIBC_2.2.5>
    6cd0:	48 8b 30             	mov    (%rax),%rsi
    6cd3:	e8 18 c5 ff ff       	call   31f0 <fputs@plt>
    6cd8:	89 d8                	mov    %ebx,%eax
    6cda:	48 83 c4 08          	add    $0x8,%rsp
    6cde:	5b                   	pop    %rbx
    6cdf:	41 5e                	pop    %r14
    6ce1:	41 5f                	pop    %r15
    6ce3:	5d                   	pop    %rbp
    6ce4:	c3                   	ret
    6ce5:	48 8b 05 ec d2 00 00 	mov    0xd2ec(%rip),%rax        # 13fd8 <stderr@GLIBC_2.2.5>
    6cec:	48 8b 38             	mov    (%rax),%rdi
    6cef:	48 8d 35 e2 85 00 00 	lea    0x85e2(%rip),%rsi        # f2d8 <exec_in_fp0+0xbd8>
    6cf6:	48 8d 15 ea 7a 00 00 	lea    0x7aea(%rip),%rdx        # e7e7 <exec_in_fp0+0xe7>
    6cfd:	31 c0                	xor    %eax,%eax
    6cff:	e8 ec c5 ff ff       	call   32f0 <fprintf@plt>
    6d04:	bb 02 00 00 00       	mov    $0x2,%ebx
    6d09:	eb cd                	jmp    6cd8 <fwp_generated+0x128>
    6d0b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006d10 <fwp_str_lossy>:
    6d10:	55                   	push   %rbp
    6d11:	41 57                	push   %r15
    6d13:	41 56                	push   %r14
    6d15:	41 55                	push   %r13
    6d17:	41 54                	push   %r12
    6d19:	53                   	push   %rbx
    6d1a:	48 83 ec 18          	sub    $0x18,%rsp
    6d1e:	48 89 f3             	mov    %rsi,%rbx
    6d21:	49 89 fe             	mov    %rdi,%r14
    6d24:	e8 07 14 00 00       	call   8130 <fwp_valid_utf8>
    6d29:	85 c0                	test   %eax,%eax
    6d2b:	74 19                	je     6d46 <fwp_str_lossy+0x36>
    6d2d:	4c 89 f7             	mov    %r14,%rdi
    6d30:	48 89 de             	mov    %rbx,%rsi
    6d33:	48 83 c4 18          	add    $0x18,%rsp
    6d37:	5b                   	pop    %rbx
    6d38:	41 5c                	pop    %r12
    6d3a:	41 5d                	pop    %r13
    6d3c:	41 5e                	pop    %r14
    6d3e:	41 5f                	pop    %r15
    6d40:	5d                   	pop    %rbp
    6d41:	e9 4a 15 00 00       	jmp    8290 <fwp_str_new>
    6d46:	0f 57 c0             	xorps  %xmm0,%xmm0
    6d49:	0f 29 04 24          	movaps %xmm0,(%rsp)
    6d4d:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    6d54:	00 00 
    6d56:	48 85 db             	test   %rbx,%rbx
    6d59:	0f 84 72 01 00 00    	je     6ed1 <fwp_str_lossy+0x1c1>
    6d5f:	45 31 ed             	xor    %r13d,%r13d
    6d62:	49 89 e7             	mov    %rsp,%r15
    6d65:	4c 8d 25 e4 85 00 00 	lea    0x85e4(%rip),%r12        # f350 <exec_in_fp0+0xc50>
    6d6c:	eb 19                	jmp    6d87 <fwp_str_lossy+0x77>
    6d6e:	66 90                	xchg   %ax,%ax
    6d70:	4c 89 ff             	mov    %r15,%rdi
    6d73:	4c 89 e6             	mov    %r12,%rsi
    6d76:	e8 75 15 00 00       	call   82f0 <buf_puts>
    6d7b:	49 89 ed             	mov    %rbp,%r13
    6d7e:	48 39 dd             	cmp    %rbx,%rbp
    6d81:	0f 83 4a 01 00 00    	jae    6ed1 <fwp_str_lossy+0x1c1>
    6d87:	43 0f b6 04 2e       	movzbl (%r14,%r13,1),%eax
    6d8c:	84 c0                	test   %al,%al
    6d8e:	78 20                	js     6db0 <fwp_str_lossy+0xa0>
    6d90:	0f be f0             	movsbl %al,%esi
    6d93:	4c 89 ff             	mov    %r15,%rdi
    6d96:	e8 35 15 00 00       	call   82d0 <buf_putc>
    6d9b:	49 ff c5             	inc    %r13
    6d9e:	4c 89 ed             	mov    %r13,%rbp
    6da1:	eb d8                	jmp    6d7b <fwp_str_lossy+0x6b>
    6da3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6daa:	84 00 00 00 00 00 
    6db0:	8d 48 20             	lea    0x20(%rax),%ecx
    6db3:	80 f9 e1             	cmp    $0xe1,%cl
    6db6:	77 34                	ja     6dec <fwp_str_lossy+0xdc>
    6db8:	89 c2                	mov    %eax,%edx
    6dba:	80 e2 f0             	and    $0xf0,%dl
    6dbd:	80 fa e0             	cmp    $0xe0,%dl
    6dc0:	0f 85 cb 00 00 00    	jne    6e91 <fwp_str_lossy+0x181>
    6dc6:	3c e0                	cmp    $0xe0,%al
    6dc8:	40 0f 94 c6          	sete   %sil
    6dcc:	40 c0 e6 05          	shl    $0x5,%sil
    6dd0:	40 80 ce 80          	or     $0x80,%sil
    6dd4:	31 ff                	xor    %edi,%edi
    6dd6:	3c ed                	cmp    $0xed,%al
    6dd8:	40 0f 95 c7          	setne  %dil
    6ddc:	c1 e7 05             	shl    $0x5,%edi
    6ddf:	81 cf 9f 00 00 00    	or     $0x9f,%edi
    6de5:	b8 02 00 00 00       	mov    $0x2,%eax
    6dea:	eb 0d                	jmp    6df9 <fwp_str_lossy+0xe9>
    6dec:	bf bf 00 00 00       	mov    $0xbf,%edi
    6df1:	40 b6 80             	mov    $0x80,%sil
    6df4:	b8 01 00 00 00       	mov    $0x1,%eax
    6df9:	31 d2                	xor    %edx,%edx
    6dfb:	49 8d 6d 01          	lea    0x1(%r13),%rbp
    6dff:	48 39 dd             	cmp    %rbx,%rbp
    6e02:	0f 83 68 ff ff ff    	jae    6d70 <fwp_str_lossy+0x60>
    6e08:	45 0f b6 04 2e       	movzbl (%r14,%rbp,1),%r8d
    6e0d:	41 38 f0             	cmp    %sil,%r8b
    6e10:	0f 82 5a ff ff ff    	jb     6d70 <fwp_str_lossy+0x60>
    6e16:	44 39 c7             	cmp    %r8d,%edi
    6e19:	0f 82 51 ff ff ff    	jb     6d70 <fwp_str_lossy+0x60>
    6e1f:	49 8d 6d 02          	lea    0x2(%r13),%rbp
    6e23:	be 01 00 00 00       	mov    $0x1,%esi
    6e28:	80 f9 e1             	cmp    $0xe1,%cl
    6e2b:	77 45                	ja     6e72 <fwp_str_lossy+0x162>
    6e2d:	48 39 dd             	cmp    %rbx,%rbp
    6e30:	73 40                	jae    6e72 <fwp_str_lossy+0x162>
    6e32:	41 0f b6 0c 2e       	movzbl (%r14,%rbp,1),%ecx
    6e37:	80 e1 c0             	and    $0xc0,%cl
    6e3a:	80 f9 80             	cmp    $0x80,%cl
    6e3d:	75 33                	jne    6e72 <fwp_str_lossy+0x162>
    6e3f:	49 8d 6d 03          	lea    0x3(%r13),%rbp
    6e43:	48 39 dd             	cmp    %rbx,%rbp
    6e46:	0f 93 c1             	setae  %cl
    6e49:	80 f2 01             	xor    $0x1,%dl
    6e4c:	be 02 00 00 00       	mov    $0x2,%esi
    6e51:	08 ca                	or     %cl,%dl
    6e53:	75 1d                	jne    6e72 <fwp_str_lossy+0x162>
    6e55:	43 0f b6 4c 2e 03    	movzbl 0x3(%r14,%r13,1),%ecx
    6e5b:	80 e1 c0             	and    $0xc0,%cl
    6e5e:	31 f6                	xor    %esi,%esi
    6e60:	80 f9 80             	cmp    $0x80,%cl
    6e63:	0f 94 c1             	sete   %cl
    6e66:	75 04                	jne    6e6c <fwp_str_lossy+0x15c>
    6e68:	49 8d 6d 04          	lea    0x4(%r13),%rbp
    6e6c:	40 88 ce             	mov    %cl,%sil
    6e6f:	83 ce 02             	or     $0x2,%esi
    6e72:	39 c6                	cmp    %eax,%esi
    6e74:	0f 85 f6 fe ff ff    	jne    6d70 <fwp_str_lossy+0x60>
    6e7a:	4b 8d 34 2e          	lea    (%r14,%r13,1),%rsi
    6e7e:	48 89 ea             	mov    %rbp,%rdx
    6e81:	4c 29 ea             	sub    %r13,%rdx
    6e84:	4c 89 ff             	mov    %r15,%rdi
    6e87:	e8 94 14 00 00       	call   8320 <buf_put>
    6e8c:	e9 ea fe ff ff       	jmp    6d7b <fwp_str_lossy+0x6b>
    6e91:	8d 50 10             	lea    0x10(%rax),%edx
    6e94:	80 fa 04             	cmp    $0x4,%dl
    6e97:	77 28                	ja     6ec1 <fwp_str_lossy+0x1b1>
    6e99:	3c f0                	cmp    $0xf0,%al
    6e9b:	40 0f 94 c6          	sete   %sil
    6e9f:	bf 8f 00 00 00       	mov    $0x8f,%edi
    6ea4:	3c f4                	cmp    $0xf4,%al
    6ea6:	74 05                	je     6ead <fwp_str_lossy+0x19d>
    6ea8:	bf bf 00 00 00       	mov    $0xbf,%edi
    6ead:	40 c0 e6 04          	shl    $0x4,%sil
    6eb1:	40 80 ce 80          	or     $0x80,%sil
    6eb5:	b8 03 00 00 00       	mov    $0x3,%eax
    6eba:	b2 01                	mov    $0x1,%dl
    6ebc:	e9 3a ff ff ff       	jmp    6dfb <fwp_str_lossy+0xeb>
    6ec1:	4c 89 ff             	mov    %r15,%rdi
    6ec4:	4c 89 e6             	mov    %r12,%rsi
    6ec7:	e8 24 14 00 00       	call   82f0 <buf_puts>
    6ecc:	e9 ca fe ff ff       	jmp    6d9b <fwp_str_lossy+0x8b>
    6ed1:	48 89 e7             	mov    %rsp,%rdi
    6ed4:	e8 87 14 00 00       	call   8360 <buf_to_str>
    6ed9:	48 83 c4 18          	add    $0x18,%rsp
    6edd:	5b                   	pop    %rbx
    6ede:	41 5c                	pop    %r12
    6ee0:	41 5d                	pop    %r13
    6ee2:	41 5e                	pop    %r14
    6ee4:	41 5f                	pop    %r15
    6ee6:	5d                   	pop    %rbp
    6ee7:	c3                   	ret
    6ee8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6eef:	00 

0000000000006ef0 <fwp_alloc_leaf>:
    6ef0:	be 01 00 00 00       	mov    $0x1,%esi
    6ef5:	e9 96 d5 ff ff       	jmp    4490 <fwp_gc_alloc>
    6efa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000006f00 <fwp_cli_parse>:
    6f00:	c7 01 00 00 00 00    	movl   $0x0,(%rcx)
    6f06:	85 ff                	test   %edi,%edi
    6f08:	0f 8e 6d 01 00 00    	jle    707b <fwp_cli_parse+0x17b>
    6f0e:	55                   	push   %rbp
    6f0f:	41 57                	push   %r15
    6f11:	41 56                	push   %r14
    6f13:	41 55                	push   %r13
    6f15:	41 54                	push   %r12
    6f17:	53                   	push   %rbx
    6f18:	48 83 ec 28          	sub    $0x28,%rsp
    6f1c:	41 89 f8             	mov    %edi,%r8d
    6f1f:	4d 89 c1             	mov    %r8,%r9
    6f22:	49 f7 d9             	neg    %r9
    6f25:	40 b5 01             	mov    $0x1,%bpl
    6f28:	45 31 ff             	xor    %r15d,%r15d
    6f2b:	41 be 01 00 00 00    	mov    $0x1,%r14d
    6f31:	31 db                	xor    %ebx,%ebx
    6f33:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
    6f38:	48 89 74 24 18       	mov    %rsi,0x18(%rsp)
    6f3d:	4c 89 44 24 10       	mov    %r8,0x10(%rsp)
    6f42:	4c 89 4c 24 08       	mov    %r9,0x8(%rsp)
    6f47:	48 89 0c 24          	mov    %rcx,(%rsp)
    6f4b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    6f50:	4e 8b 6c f6 f8       	mov    -0x8(%rsi,%r14,8),%r13
    6f55:	85 db                	test   %ebx,%ebx
    6f57:	75 37                	jne    6f90 <fwp_cli_parse+0x90>
    6f59:	4d 8b 65 00          	mov    0x0(%r13),%r12
    6f5d:	49 83 fc 02          	cmp    $0x2,%r12
    6f61:	72 2d                	jb     6f90 <fwp_cli_parse+0x90>
    6f63:	49 8d 7d 08          	lea    0x8(%r13),%rdi
    6f67:	80 3f 2d             	cmpb   $0x2d,(%rdi)
    6f6a:	75 24                	jne    6f90 <fwp_cli_parse+0x90>
    6f6c:	e8 df 14 00 00       	call   8450 <fwp_is_number_arg>
    6f71:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    6f76:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    6f7b:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    6f80:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    6f85:	48 8b 0c 24          	mov    (%rsp),%rcx
    6f89:	85 c0                	test   %eax,%eax
    6f8b:	74 2f                	je     6fbc <fwp_cli_parse+0xbc>
    6f8d:	0f 1f 00             	nopl   (%rax)
    6f90:	49 63 c7             	movslq %r15d,%rax
    6f93:	41 8d 7f 01          	lea    0x1(%r15),%edi
    6f97:	89 39                	mov    %edi,(%rcx)
    6f99:	4c 89 2c c2          	mov    %r13,(%rdx,%rax,8)
    6f9d:	41 89 ff             	mov    %edi,%r15d
    6fa0:	4d 39 c6             	cmp    %r8,%r14
    6fa3:	40 0f 92 c5          	setb   %bpl
    6fa7:	4b 8d 04 31          	lea    (%r9,%r14,1),%rax
    6fab:	48 ff c0             	inc    %rax
    6fae:	49 ff c6             	inc    %r14
    6fb1:	48 83 f8 01          	cmp    $0x1,%rax
    6fb5:	75 99                	jne    6f50 <fwp_cli_parse+0x50>
    6fb7:	e9 a9 00 00 00       	jmp    7065 <fwp_cli_parse+0x165>
    6fbc:	41 0f b6 45 09       	movzbl 0x9(%r13),%eax
    6fc1:	49 83 fc 02          	cmp    $0x2,%r12
    6fc5:	75 1a                	jne    6fe1 <fwp_cli_parse+0xe1>
    6fc7:	bb 01 00 00 00       	mov    $0x1,%ebx
    6fcc:	3c 2d                	cmp    $0x2d,%al
    6fce:	74 d0                	je     6fa0 <fwp_cli_parse+0xa0>
    6fd0:	31 db                	xor    %ebx,%ebx
    6fd2:	49 83 fc 02          	cmp    $0x2,%r12
    6fd6:	75 b8                	jne    6f90 <fwp_cli_parse+0x90>
    6fd8:	3c 68                	cmp    $0x68,%al
    6fda:	75 b4                	jne    6f90 <fwp_cli_parse+0x90>
    6fdc:	e9 84 00 00 00       	jmp    7065 <fwp_cli_parse+0x165>
    6fe1:	31 db                	xor    %ebx,%ebx
    6fe3:	3c 2d                	cmp    $0x2d,%al
    6fe5:	75 a9                	jne    6f90 <fwp_cli_parse+0x90>
    6fe7:	49 8d 5d 0a          	lea    0xa(%r13),%rbx
    6feb:	49 83 c4 fe          	add    $0xfffffffffffffffe,%r12
    6fef:	48 89 df             	mov    %rbx,%rdi
    6ff2:	be 3d 00 00 00       	mov    $0x3d,%esi
    6ff7:	4c 89 e2             	mov    %r12,%rdx
    6ffa:	e8 61 c2 ff ff       	call   3260 <memchr@plt>
    6fff:	48 89 c1             	mov    %rax,%rcx
    7002:	48 29 d9             	sub    %rbx,%rcx
    7005:	48 85 c0             	test   %rax,%rax
    7008:	49 0f 44 cc          	cmove  %r12,%rcx
    700c:	75 38                	jne    7046 <fwp_cli_parse+0x146>
    700e:	48 83 f9 04          	cmp    $0x4,%rcx
    7012:	48 8b 0c 24          	mov    (%rsp),%rcx
    7016:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    701b:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    7020:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    7025:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    702a:	75 13                	jne    703f <fwp_cli_parse+0x13f>
    702c:	81 3b 68 65 6c 70    	cmpl   $0x706c6568,(%rbx)
    7032:	bb 00 00 00 00       	mov    $0x0,%ebx
    7037:	0f 85 53 ff ff ff    	jne    6f90 <fwp_cli_parse+0x90>
    703d:	eb 26                	jmp    7065 <fwp_cli_parse+0x165>
    703f:	31 db                	xor    %ebx,%ebx
    7041:	e9 4a ff ff ff       	jmp    6f90 <fwp_cli_parse+0x90>
    7046:	48 8b 0c 24          	mov    (%rsp),%rcx
    704a:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    704f:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    7054:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    7059:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    705e:	31 db                	xor    %ebx,%ebx
    7060:	e9 2b ff ff ff       	jmp    6f90 <fwp_cli_parse+0x90>
    7065:	40 0f b6 c5          	movzbl %bpl,%eax
    7069:	83 e0 01             	and    $0x1,%eax
    706c:	48 83 c4 28          	add    $0x28,%rsp
    7070:	5b                   	pop    %rbx
    7071:	41 5c                	pop    %r12
    7073:	41 5d                	pop    %r13
    7075:	41 5e                	pop    %r14
    7077:	41 5f                	pop    %r15
    7079:	5d                   	pop    %rbp
    707a:	c3                   	ret
    707b:	31 c0                	xor    %eax,%eax
    707d:	c3                   	ret
    707e:	66 90                	xchg   %ax,%ax

0000000000007080 <fwp_usage_error>:
    7080:	48 8b 05 51 cf 00 00 	mov    0xcf51(%rip),%rax        # 13fd8 <stderr@GLIBC_2.2.5>
    7087:	48 8b 38             	mov    (%rax),%rdi
    708a:	48 8d 35 57 83 00 00 	lea    0x8357(%rip),%rsi        # f3e8 <exec_in_fp0+0xce8>
    7091:	48 8d 15 63 84 00 00 	lea    0x8463(%rip),%rdx        # f4fb <exec_in_fp0+0xdfb>
    7098:	31 c0                	xor    %eax,%eax
    709a:	e9 51 c2 ff ff       	jmp    32f0 <fprintf@plt>
    709f:	90                   	nop

00000000000070a0 <fwp_parse_text>:
    70a0:	48 83 ec 18          	sub    $0x18,%rsp
    70a4:	48 89 d1             	mov    %rdx,%rcx
    70a7:	48 89 3c 24          	mov    %rdi,(%rsp)
    70ab:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    70b0:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    70b7:	00 00 
    70b9:	48 8d 35 68 ec 00 00 	lea    0xec68(%rip),%rsi        # 15d28 <d0>
    70c0:	48 89 e7             	mov    %rsp,%rdi
    70c3:	ba 01 00 00 00       	mov    $0x1,%edx
    70c8:	e8 83 18 00 00       	call   8950 <tp_value>
    70cd:	85 c0                	test   %eax,%eax
    70cf:	74 1c                	je     70ed <fwp_parse_text+0x4d>
    70d1:	48 89 e7             	mov    %rsp,%rdi
    70d4:	e8 a7 21 00 00       	call   9280 <tp_ws>
    70d9:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    70de:	31 c0                	xor    %eax,%eax
    70e0:	48 3b 4c 24 08       	cmp    0x8(%rsp),%rcx
    70e5:	0f 94 c0             	sete   %al
    70e8:	48 83 c4 18          	add    $0x18,%rsp
    70ec:	c3                   	ret
    70ed:	31 c0                	xor    %eax,%eax
    70ef:	48 83 c4 18          	add    $0x18,%rsp
    70f3:	c3                   	ret
    70f4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    70fb:	00 00 00 00 00 

0000000000007100 <fwp_parse_arg>:
    7100:	53                   	push   %rbx
    7101:	48 83 ec 10          	sub    $0x10,%rsp
    7105:	89 fb                	mov    %edi,%ebx
    7107:	48 8b 06             	mov    (%rsi),%rax
    710a:	48 8d 7e 08          	lea    0x8(%rsi),%rdi
    710e:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    7113:	48 89 c6             	mov    %rax,%rsi
    7116:	e8 65 14 00 00       	call   8580 <fwp_cli_value>
    711b:	89 c1                	mov    %eax,%ecx
    711d:	b8 01 00 00 00       	mov    $0x1,%eax
    7122:	85 c9                	test   %ecx,%ecx
    7124:	74 06                	je     712c <fwp_parse_arg+0x2c>
    7126:	48 83 c4 10          	add    $0x10,%rsp
    712a:	5b                   	pop    %rbx
    712b:	c3                   	ret
    712c:	48 8b 05 a5 ce 00 00 	mov    0xcea5(%rip),%rax        # 13fd8 <stderr@GLIBC_2.2.5>
    7133:	48 8b 38             	mov    (%rax),%rdi
    7136:	ff c3                	inc    %ebx
    7138:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
    713d:	49 83 c0 08          	add    $0x8,%r8
    7141:	48 8d 35 8f 82 00 00 	lea    0x828f(%rip),%rsi        # f3d7 <exec_in_fp0+0xcd7>
    7148:	48 8d 15 98 76 00 00 	lea    0x7698(%rip),%rdx        # e7e7 <exec_in_fp0+0xe7>
    714f:	89 d9                	mov    %ebx,%ecx
    7151:	31 c0                	xor    %eax,%eax
    7153:	e8 98 c1 ff ff       	call   32f0 <fprintf@plt>
    7158:	31 c0                	xor    %eax,%eax
    715a:	eb ca                	jmp    7126 <fwp_parse_arg+0x26>
    715c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000007160 <fwp_bind_positional>:
    7160:	50                   	push   %rax
    7161:	31 c0                	xor    %eax,%eax
    7163:	85 f6                	test   %esi,%esi
    7165:	0f 9e c0             	setle  %al
    7168:	89 01                	mov    %eax,(%rcx)
    716a:	83 fe 01             	cmp    $0x1,%esi
    716d:	76 0c                	jbe    717b <fwp_bind_positional+0x1b>
    716f:	e8 0c ff ff ff       	call   7080 <fwp_usage_error>
    7174:	b8 02 00 00 00       	mov    $0x2,%eax
    7179:	59                   	pop    %rcx
    717a:	c3                   	ret
    717b:	31 c0                	xor    %eax,%eax
    717d:	83 fe 01             	cmp    $0x1,%esi
    7180:	75 f7                	jne    7179 <fwp_bind_positional+0x19>
    7182:	48 8b 37             	mov    (%rdi),%rsi
    7185:	31 ff                	xor    %edi,%edi
    7187:	e8 74 ff ff ff       	call   7100 <fwp_parse_arg>
    718c:	89 c1                	mov    %eax,%ecx
    718e:	31 c0                	xor    %eax,%eax
    7190:	85 c9                	test   %ecx,%ecx
    7192:	0f 94 c0             	sete   %al
    7195:	01 c0                	add    %eax,%eax
    7197:	59                   	pop    %rcx
    7198:	c3                   	ret
    7199:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000071a0 <fwp_pipe_out_start>:
    71a0:	41 56                	push   %r14
    71a2:	53                   	push   %rbx
    71a3:	48 81 ec 08 01 00 00 	sub    $0x108,%rsp
    71aa:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    71af:	bf 01 00 00 00       	mov    $0x1,%edi
    71b4:	e8 27 c3 ff ff       	call   34e0 <fstat@plt>
    71b9:	85 c0                	test   %eax,%eax
    71bb:	0f 85 82 00 00 00    	jne    7243 <fwp_pipe_out_start+0xa3>
    71c1:	b8 00 f0 00 00       	mov    $0xf000,%eax
    71c6:	23 44 24 20          	and    0x20(%rsp),%eax
    71ca:	3d 00 10 00 00       	cmp    $0x1000,%eax
    71cf:	75 72                	jne    7243 <fwp_pipe_out_start+0xa3>
    71d1:	bf 01 00 00 00       	mov    $0x1,%edi
    71d6:	be 07 04 00 00       	mov    $0x407,%esi
    71db:	ba 00 00 10 00       	mov    $0x100000,%edx
    71e0:	31 c0                	xor    %eax,%eax
    71e2:	e8 39 bf ff ff       	call   3120 <fcntl@plt>
    71e7:	e8 14 38 00 00       	call   aa00 <fwp_transport_off>
    71ec:	85 c0                	test   %eax,%eax
    71ee:	75 53                	jne    7243 <fwp_pipe_out_start+0xa3>
    71f0:	bf 01 00 00 00       	mov    $0x1,%edi
    71f5:	be 01 08 08 00       	mov    $0x80801,%esi
    71fa:	31 d2                	xor    %edx,%edx
    71fc:	e8 0f c3 ff ff       	call   3510 <socket@plt>
    7201:	85 c0                	test   %eax,%eax
    7203:	78 3e                	js     7243 <fwp_pipe_out_start+0xa3>
    7205:	89 c3                	mov    %eax,%ebx
    7207:	4c 8d b4 24 9a 00 00 	lea    0x9a(%rsp),%r14
    720e:	00 
    720f:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    7214:	4c 89 f7             	mov    %r14,%rdi
    7217:	e8 14 38 00 00       	call   aa30 <fwp_pipe_addr>
    721c:	89 df                	mov    %ebx,%edi
    721e:	4c 89 f6             	mov    %r14,%rsi
    7221:	89 c2                	mov    %eax,%edx
    7223:	e8 a8 c1 ff ff       	call   33d0 <bind@plt>
    7228:	85 c0                	test   %eax,%eax
    722a:	75 10                	jne    723c <fwp_pipe_out_start+0x9c>
    722c:	89 df                	mov    %ebx,%edi
    722e:	be 01 00 00 00       	mov    $0x1,%esi
    7233:	e8 28 c1 ff ff       	call   3360 <listen@plt>
    7238:	85 c0                	test   %eax,%eax
    723a:	74 12                	je     724e <fwp_pipe_out_start+0xae>
    723c:	89 df                	mov    %ebx,%edi
    723e:	e8 ed bf ff ff       	call   3230 <close@plt>
    7243:	48 81 c4 08 01 00 00 	add    $0x108,%rsp
    724a:	5b                   	pop    %rbx
    724b:	41 5e                	pop    %r14
    724d:	c3                   	ret
    724e:	89 1d 64 ea 00 00    	mov    %ebx,0xea64(%rip)        # 15cb8 <fwp_po_listen>
    7254:	e8 27 38 00 00       	call   aa80 <fwp_now_ns>
    7259:	48 b9 00 f2 05 2a 01 	movabs $0x12a05f200,%rcx
    7260:	00 00 00 
    7263:	48 01 c1             	add    %rax,%rcx
    7266:	48 89 0d cb f1 01 00 	mov    %rcx,0x1f1cb(%rip)        # 26438 <fwp_po_give_up>
    726d:	eb d4                	jmp    7243 <fwp_pipe_out_start+0xa3>
    726f:	90                   	nop

0000000000007270 <fwp_pipe_write>:
    7270:	41 57                	push   %r15
    7272:	41 56                	push   %r14
    7274:	53                   	push   %rbx
    7275:	48 89 f3             	mov    %rsi,%rbx
    7278:	8b 05 c2 f1 01 00    	mov    0x1f1c2(%rip),%eax        # 26440 <fwp_po_kind>
    727e:	83 f8 01             	cmp    $0x1,%eax
    7281:	74 12                	je     7295 <fwp_pipe_write+0x25>
    7283:	83 f8 02             	cmp    $0x2,%eax
    7286:	75 46                	jne    72ce <fwp_pipe_write+0x5e>
    7288:	48 89 de             	mov    %rbx,%rsi
    728b:	5b                   	pop    %rbx
    728c:	41 5e                	pop    %r14
    728e:	41 5f                	pop    %r15
    7290:	e9 1b 38 00 00       	jmp    aab0 <fwp_ring_put>
    7295:	49 89 fe             	mov    %rdi,%r14
    7298:	48 8b 05 a9 f1 01 00 	mov    0x1f1a9(%rip),%rax        # 26448 <fwp_po_len>
    729f:	48 01 d8             	add    %rbx,%rax
    72a2:	48 3d 01 00 01 00    	cmp    $0x10001,%rax
    72a8:	72 05                	jb     72af <fwp_pipe_write+0x3f>
    72aa:	e8 61 39 00 00       	call   ac10 <fwp_po_flush_sock>
    72af:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    72b6:	72 32                	jb     72ea <fwp_pipe_write+0x7a>
    72b8:	8b 3d fe e9 00 00    	mov    0xe9fe(%rip),%edi        # 15cbc <fwp_po_sock>
    72be:	4c 89 f6             	mov    %r14,%rsi
    72c1:	48 89 da             	mov    %rbx,%rdx
    72c4:	5b                   	pop    %rbx
    72c5:	41 5e                	pop    %r14
    72c7:	41 5f                	pop    %r15
    72c9:	e9 72 39 00 00       	jmp    ac40 <fwp_po_write_raw>
    72ce:	48 8b 05 db cc 00 00 	mov    0xccdb(%rip),%rax        # 13fb0 <stdout@GLIBC_2.2.5>
    72d5:	48 8b 08             	mov    (%rax),%rcx
    72d8:	be 01 00 00 00       	mov    $0x1,%esi
    72dd:	48 89 da             	mov    %rbx,%rdx
    72e0:	5b                   	pop    %rbx
    72e1:	41 5e                	pop    %r14
    72e3:	41 5f                	pop    %r15
    72e5:	e9 b6 c1 ff ff       	jmp    34a0 <fwrite@plt>
    72ea:	4c 8b 3d 57 f1 01 00 	mov    0x1f157(%rip),%r15        # 26448 <fwp_po_len>
    72f1:	48 8d 3d 58 f1 01 00 	lea    0x1f158(%rip),%rdi        # 26450 <fwp_po_buf>
    72f8:	4c 01 ff             	add    %r15,%rdi
    72fb:	4c 89 f6             	mov    %r14,%rsi
    72fe:	48 89 da             	mov    %rbx,%rdx
    7301:	e8 2a c0 ff ff       	call   3330 <memcpy@plt>
    7306:	49 01 df             	add    %rbx,%r15
    7309:	4c 89 3d 38 f1 01 00 	mov    %r15,0x1f138(%rip)        # 26448 <fwp_po_len>
    7310:	5b                   	pop    %rbx
    7311:	41 5e                	pop    %r14
    7313:	41 5f                	pop    %r15
    7315:	c3                   	ret
    7316:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    731d:	00 00 00 

0000000000007320 <fwp_pipe_flush>:
    7320:	8b 05 1a f1 01 00    	mov    0x1f11a(%rip),%eax        # 26440 <fwp_po_kind>
    7326:	85 c0                	test   %eax,%eax
    7328:	74 0a                	je     7334 <fwp_pipe_flush+0x14>
    732a:	83 f8 01             	cmp    $0x1,%eax
    732d:	75 1b                	jne    734a <fwp_pipe_flush+0x2a>
    732f:	e9 dc 38 00 00       	jmp    ac10 <fwp_po_flush_sock>
    7334:	50                   	push   %rax
    7335:	48 8b 05 74 cc 00 00 	mov    0xcc74(%rip),%rax        # 13fb0 <stdout@GLIBC_2.2.5>
    733c:	48 8b 38             	mov    (%rax),%rdi
    733f:	e8 0c c0 ff ff       	call   3350 <fflush@plt>
    7344:	58                   	pop    %rax
    7345:	e9 d6 3b 00 00       	jmp    af20 <fwp_pipe_poll>
    734a:	c3                   	ret
    734b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000007350 <fwp_pipe_out_ready>:
    7350:	48 83 ec 18          	sub    $0x18,%rsp
    7354:	48 8d 3d cb 80 00 00 	lea    0x80cb(%rip),%rdi        # f426 <exec_in_fp0+0xd26>
    735b:	e8 d0 bc ff ff       	call   3030 <getenv@plt>
    7360:	48 85 c0             	test   %rax,%rax
    7363:	74 79                	je     73de <fwp_pipe_out_ready+0x8e>
    7365:	83 3d 4c e9 00 00 00 	cmpl   $0x0,0xe94c(%rip)        # 15cb8 <fwp_po_listen>
    736c:	78 70                	js     73de <fwp_pipe_out_ready+0x8e>
    736e:	80 38 00             	cmpb   $0x0,(%rax)
    7371:	74 6b                	je     73de <fwp_pipe_out_ready+0x8e>
    7373:	48 89 c7             	mov    %rax,%rdi
    7376:	31 f6                	xor    %esi,%esi
    7378:	ba 0a 00 00 00       	mov    $0xa,%edx
    737d:	e8 9e bf ff ff       	call   3320 <strtol@plt>
    7382:	8b 0d 30 e9 00 00    	mov    0xe930(%rip),%ecx        # 15cb8 <fwp_po_listen>
    7388:	89 0c 24             	mov    %ecx,(%rsp)
    738b:	48 b9 01 00 00 00 01 	movabs $0x100000001,%rcx
    7392:	00 00 00 
    7395:	48 89 4c 24 04       	mov    %rcx,0x4(%rsp)
    739a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%rsp)
    73a1:	00 
    73a2:	48 85 c0             	test   %rax,%rax
    73a5:	7e 37                	jle    73de <fwp_pipe_out_ready+0x8e>
    73a7:	48 3d ff ff ff 7f    	cmp    $0x7fffffff,%rax
    73ad:	ba ff ff ff 7f       	mov    $0x7fffffff,%edx
    73b2:	48 0f 4c d0          	cmovl  %rax,%rdx
    73b6:	48 89 e7             	mov    %rsp,%rdi
    73b9:	be 02 00 00 00       	mov    $0x2,%esi
    73be:	e8 fd bf ff ff       	call   33c0 <poll@plt>
    73c3:	85 c0                	test   %eax,%eax
    73c5:	7e 17                	jle    73de <fwp_pipe_out_ready+0x8e>
    73c7:	f6 44 24 06 01       	testb  $0x1,0x6(%rsp)
    73cc:	74 10                	je     73de <fwp_pipe_out_ready+0x8e>
    73ce:	48 c7 05 87 f0 02 00 	movq   $0x0,0x2f087(%rip)        # 36460 <fwp_po_next_check>
    73d5:	00 00 00 00 
    73d9:	e8 42 3b 00 00       	call   af20 <fwp_pipe_poll>
    73de:	48 83 c4 18          	add    $0x18,%rsp
    73e2:	c3                   	ret
    73e3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    73ea:	84 00 00 00 00 00 

00000000000073f0 <fwp_exec_call>:
    73f0:	41 56                	push   %r14
    73f2:	53                   	push   %rbx
    73f3:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
    73fa:	48 89 f3             	mov    %rsi,%rbx
    73fd:	49 89 fe             	mov    %rdi,%r14
    7400:	48 8b 05 61 f0 02 00 	mov    0x2f061(%rip),%rax        # 36468 <fwp_handlers>
    7407:	48 89 84 24 d0 00 00 	mov    %rax,0xd0(%rsp)
    740e:	00 
    740f:	48 c7 84 24 e8 00 00 	movq   $0x0,0xe8(%rsp)
    7416:	00 00 00 00 00 
    741b:	48 8b 05 b6 ef 00 00 	mov    0xefb6(%rip),%rax        # 163d8 <fwp_cleanups>
    7422:	48 89 84 24 f0 00 00 	mov    %rax,0xf0(%rsp)
    7429:	00 
    742a:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    742f:	48 89 3d 32 f0 02 00 	mov    %rdi,0x2f032(%rip)        # 36468 <fwp_handlers>
    7436:	e8 75 be ff ff       	call   32b0 <_setjmp@plt>
    743b:	85 c0                	test   %eax,%eax
    743d:	74 32                	je     7471 <fwp_exec_call+0x81>
    743f:	48 8b 84 24 d0 00 00 	mov    0xd0(%rsp),%rax
    7446:	00 
    7447:	48 89 05 1a f0 02 00 	mov    %rax,0x2f01a(%rip)        # 36468 <fwp_handlers>
    744e:	e8 1d cd ff ff       	call   4170 <fwp_flush>
    7453:	48 8b bc 24 d8 00 00 	mov    0xd8(%rsp),%rdi
    745a:	00 
    745b:	48 8b b4 24 e0 00 00 	mov    0xe0(%rsp),%rsi
    7462:	00 
    7463:	e8 08 43 00 00       	call   b770 <fwp_exec_error>
    7468:	b9 01 00 00 00       	mov    $0x1,%ecx
    746d:	31 c0                	xor    %eax,%eax
    746f:	eb 21                	jmp    7492 <fwp_exec_call+0xa2>
    7471:	e8 da 42 00 00       	call   b750 <fwp_pap>
    7476:	48 89 c7             	mov    %rax,%rdi
    7479:	4c 89 f6             	mov    %r14,%rsi
    747c:	e8 0f 3e 00 00       	call   b290 <fwp_apply>
    7481:	48 8b 8c 24 d0 00 00 	mov    0xd0(%rsp),%rcx
    7488:	00 
    7489:	48 89 0d d8 ef 02 00 	mov    %rcx,0x2efd8(%rip)        # 36468 <fwp_handlers>
    7490:	31 c9                	xor    %ecx,%ecx
    7492:	89 0b                	mov    %ecx,(%rbx)
    7494:	48 81 c4 f8 00 00 00 	add    $0xf8,%rsp
    749b:	5b                   	pop    %rbx
    749c:	41 5e                	pop    %r14
    749e:	c3                   	ret
    749f:	90                   	nop

00000000000074a0 <fwp_emit_result>:
    74a0:	e9 3b 57 00 00       	jmp    cbe0 <fwp_emit>
    74a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    74ac:	00 00 00 00 

00000000000074b0 <fwp_read_exact>:
    74b0:	41 57                	push   %r15
    74b2:	41 56                	push   %r14
    74b4:	53                   	push   %rbx
    74b5:	48 89 f3             	mov    %rsi,%rbx
    74b8:	49 89 fe             	mov    %rdi,%r14
    74bb:	45 31 ff             	xor    %r15d,%r15d
    74be:	48 85 f6             	test   %rsi,%rsi
    74c1:	0f 84 b9 00 00 00    	je     7580 <fwp_read_exact+0xd0>
    74c7:	8b 05 5b ef 01 00    	mov    0x1ef5b(%rip),%eax        # 26428 <fwp_in_npend>
    74cd:	8b 0d 59 ef 01 00    	mov    0x1ef59(%rip),%ecx        # 2642c <fwp_in_ppos>
    74d3:	39 c1                	cmp    %eax,%ecx
    74d5:	0f 8d a5 00 00 00    	jge    7580 <fwp_read_exact+0xd0>
    74db:	48 98                	cltq
    74dd:	48 63 f1             	movslq %ecx,%rsi
    74e0:	48 89 f2             	mov    %rsi,%rdx
    74e3:	48 f7 d2             	not    %rdx
    74e6:	48 01 c2             	add    %rax,%rdx
    74e9:	48 8d 4b ff          	lea    -0x1(%rbx),%rcx
    74ed:	48 39 ca             	cmp    %rcx,%rdx
    74f0:	48 0f 43 d1          	cmovae %rcx,%rdx
    74f4:	48 ff c2             	inc    %rdx
    74f7:	48 83 fa 20          	cmp    $0x20,%rdx
    74fb:	72 16                	jb     7513 <fwp_read_exact+0x63>
    74fd:	48 8d 3d 20 ef 01 00 	lea    0x1ef20(%rip),%rdi        # 26424 <fwp_in_pend>
    7504:	4d 89 f0             	mov    %r14,%r8
    7507:	49 29 f0             	sub    %rsi,%r8
    750a:	49 29 f8             	sub    %rdi,%r8
    750d:	49 83 f8 20          	cmp    $0x20,%r8
    7511:	73 27                	jae    753a <fwp_read_exact+0x8a>
    7513:	45 31 ff             	xor    %r15d,%r15d
    7516:	48 89 f1             	mov    %rsi,%rcx
    7519:	48 8d 15 04 ef 01 00 	lea    0x1ef04(%rip),%rdx        # 26424 <fwp_in_pend>
    7520:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    7524:	48 ff c1             	inc    %rcx
    7527:	43 88 34 3e          	mov    %sil,(%r14,%r15,1)
    752b:	49 ff c7             	inc    %r15
    752e:	49 39 df             	cmp    %rbx,%r15
    7531:	73 3f                	jae    7572 <fwp_read_exact+0xc2>
    7533:	48 39 c1             	cmp    %rax,%rcx
    7536:	7c e8                	jl     7520 <fwp_read_exact+0x70>
    7538:	eb 38                	jmp    7572 <fwp_read_exact+0xc2>
    753a:	49 89 d7             	mov    %rdx,%r15
    753d:	49 83 e7 e0          	and    $0xffffffffffffffe0,%r15
    7541:	49 8d 0c 37          	lea    (%r15,%rsi,1),%rcx
    7545:	48 01 fe             	add    %rdi,%rsi
    7548:	48 83 c6 10          	add    $0x10,%rsi
    754c:	31 ff                	xor    %edi,%edi
    754e:	66 90                	xchg   %ax,%ax
    7550:	0f 10 44 3e f0       	movups -0x10(%rsi,%rdi,1),%xmm0
    7555:	0f 10 0c 3e          	movups (%rsi,%rdi,1),%xmm1
    7559:	41 0f 11 04 3e       	movups %xmm0,(%r14,%rdi,1)
    755e:	41 0f 11 4c 3e 10    	movups %xmm1,0x10(%r14,%rdi,1)
    7564:	48 83 c7 20          	add    $0x20,%rdi
    7568:	49 39 ff             	cmp    %rdi,%r15
    756b:	75 e3                	jne    7550 <fwp_read_exact+0xa0>
    756d:	4c 39 fa             	cmp    %r15,%rdx
    7570:	75 a7                	jne    7519 <fwp_read_exact+0x69>
    7572:	89 0d b4 ee 01 00    	mov    %ecx,0x1eeb4(%rip)        # 2642c <fwp_in_ppos>
    7578:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    757f:	00 
    7580:	48 89 de             	mov    %rbx,%rsi
    7583:	4c 29 fe             	sub    %r15,%rsi
    7586:	76 15                	jbe    759d <fwp_read_exact+0xed>
    7588:	4b 8d 3c 3e          	lea    (%r14,%r15,1),%rdi
    758c:	e8 2f 5a 00 00       	call   cfc0 <fwp_pipe_read>
    7591:	49 01 c7             	add    %rax,%r15
    7594:	48 85 c0             	test   %rax,%rax
    7597:	75 e7                	jne    7580 <fwp_read_exact+0xd0>
    7599:	31 c0                	xor    %eax,%eax
    759b:	eb 05                	jmp    75a2 <fwp_read_exact+0xf2>
    759d:	b8 01 00 00 00       	mov    $0x1,%eax
    75a2:	5b                   	pop    %rbx
    75a3:	41 5e                	pop    %r14
    75a5:	41 5f                	pop    %r15
    75a7:	c3                   	ret
    75a8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    75af:	00 

00000000000075b0 <fwp_stdin_leb>:
    75b0:	41 57                	push   %r15
    75b2:	41 56                	push   %r14
    75b4:	53                   	push   %rbx
    75b5:	48 83 ec 10          	sub    $0x10,%rsp
    75b9:	48 89 fb             	mov    %rdi,%rbx
    75bc:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    75c3:	49 c7 c6 f9 ff ff ff 	mov    $0xfffffffffffffff9,%r14
    75ca:	4c 8d 7c 24 0f       	lea    0xf(%rsp),%r15
    75cf:	90                   	nop
    75d0:	be 01 00 00 00       	mov    $0x1,%esi
    75d5:	4c 89 ff             	mov    %r15,%rdi
    75d8:	e8 d3 fe ff ff       	call   74b0 <fwp_read_exact>
    75dd:	85 c0                	test   %eax,%eax
    75df:	74 35                	je     7616 <fwp_stdin_leb+0x66>
    75e1:	0f b6 44 24 0f       	movzbl 0xf(%rsp),%eax
    75e6:	49 83 fe 38          	cmp    $0x38,%r14
    75ea:	75 07                	jne    75f3 <fwp_stdin_leb+0x43>
    75ec:	89 c1                	mov    %eax,%ecx
    75ee:	80 e1 7e             	and    $0x7e,%cl
    75f1:	75 1c                	jne    760f <fwp_stdin_leb+0x5f>
    75f3:	49 83 c6 07          	add    $0x7,%r14
    75f7:	89 c2                	mov    %eax,%edx
    75f9:	83 e2 7f             	and    $0x7f,%edx
    75fc:	44 89 f1             	mov    %r14d,%ecx
    75ff:	48 d3 e2             	shl    %cl,%rdx
    7602:	48 09 13             	or     %rdx,(%rbx)
    7605:	84 c0                	test   %al,%al
    7607:	79 11                	jns    761a <fwp_stdin_leb+0x6a>
    7609:	49 83 fe 38          	cmp    $0x38,%r14
    760d:	76 c1                	jbe    75d0 <fwp_stdin_leb+0x20>
    760f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    7614:	eb 09                	jmp    761f <fwp_stdin_leb+0x6f>
    7616:	31 c0                	xor    %eax,%eax
    7618:	eb 05                	jmp    761f <fwp_stdin_leb+0x6f>
    761a:	b8 01 00 00 00       	mov    $0x1,%eax
    761f:	48 83 c4 10          	add    $0x10,%rsp
    7623:	5b                   	pop    %rbx
    7624:	41 5e                	pop    %r14
    7626:	41 5f                	pop    %r15
    7628:	c3                   	ret
    7629:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000007630 <fwp_stdin_name_len>:
    7630:	53                   	push   %rbx
    7631:	48 89 fb             	mov    %rdi,%rbx
    7634:	e8 77 ff ff ff       	call   75b0 <fwp_stdin_leb>
    7639:	83 f8 01             	cmp    $0x1,%eax
    763c:	75 0e                	jne    764c <fwp_stdin_name_len+0x1c>
    763e:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    7643:	48 81 3b 00 00 10 00 	cmpq   $0x100000,(%rbx)
    764a:	77 02                	ja     764e <fwp_stdin_name_len+0x1e>
    764c:	89 c1                	mov    %eax,%ecx
    764e:	89 c8                	mov    %ecx,%eax
    7650:	5b                   	pop    %rbx
    7651:	c3                   	ret
    7652:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7659:	1f 84 00 00 00 00 00 

0000000000007660 <fwp_pipe_in_offer>:
    7660:	55                   	push   %rbp
    7661:	41 57                	push   %r15
    7663:	41 56                	push   %r14
    7665:	53                   	push   %rbx
    7666:	48 81 ec 08 01 00 00 	sub    $0x108,%rsp
    766d:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    7672:	31 ff                	xor    %edi,%edi
    7674:	e8 67 be ff ff       	call   34e0 <fstat@plt>
    7679:	85 c0                	test   %eax,%eax
    767b:	0f 85 a5 00 00 00    	jne    7726 <fwp_pipe_in_offer+0xc6>
    7681:	b8 00 f0 00 00       	mov    $0xf000,%eax
    7686:	23 44 24 20          	and    0x20(%rsp),%eax
    768a:	3d 00 10 00 00       	cmp    $0x1000,%eax
    768f:	0f 85 91 00 00 00    	jne    7726 <fwp_pipe_in_offer+0xc6>
    7695:	bf 01 00 00 00       	mov    $0x1,%edi
    769a:	be 01 00 08 00       	mov    $0x80001,%esi
    769f:	31 d2                	xor    %edx,%edx
    76a1:	e8 6a be ff ff       	call   3510 <socket@plt>
    76a6:	85 c0                	test   %eax,%eax
    76a8:	78 7c                	js     7726 <fwp_pipe_in_offer+0xc6>
    76aa:	89 c3                	mov    %eax,%ebx
    76ac:	48 8d bc 24 9a 00 00 	lea    0x9a(%rsp),%rdi
    76b3:	00 
    76b4:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    76b9:	e8 72 33 00 00       	call   aa30 <fwp_pipe_addr>
    76be:	41 89 c6             	mov    %eax,%r14d
    76c1:	48 8d 3d 24 7d 00 00 	lea    0x7d24(%rip),%rdi        # f3ec <exec_in_fp0+0xcec>
    76c8:	e8 63 b9 ff ff       	call   3030 <getenv@plt>
    76cd:	49 89 c7             	mov    %rax,%r15
    76d0:	e8 2b 33 00 00       	call   aa00 <fwp_transport_off>
    76d5:	89 c5                	mov    %eax,%ebp
    76d7:	c7 04 24 46 57 50 54 	movl   $0x54505746,(%rsp)
    76de:	85 c0                	test   %eax,%eax
    76e0:	74 04                	je     76e6 <fwp_pipe_in_offer+0x86>
    76e2:	31 c0                	xor    %eax,%eax
    76e4:	eb 1f                	jmp    7705 <fwp_pipe_in_offer+0xa5>
    76e6:	4d 85 ff             	test   %r15,%r15
    76e9:	74 18                	je     7703 <fwp_pipe_in_offer+0xa3>
    76eb:	48 8d 35 cd 7d 00 00 	lea    0x7dcd(%rip),%rsi        # f4bf <exec_in_fp0+0xdbf>
    76f2:	4c 89 ff             	mov    %r15,%rdi
    76f5:	e8 d6 bb ff ff       	call   32d0 <strcmp@plt>
    76fa:	83 f8 01             	cmp    $0x1,%eax
    76fd:	b0 02                	mov    $0x2,%al
    76ff:	1c 00                	sbb    $0x0,%al
    7701:	eb 02                	jmp    7705 <fwp_pipe_in_offer+0xa5>
    7703:	b0 02                	mov    $0x2,%al
    7705:	88 44 24 04          	mov    %al,0x4(%rsp)
    7709:	48 8d b4 24 9a 00 00 	lea    0x9a(%rsp),%rsi
    7710:	00 
    7711:	89 df                	mov    %ebx,%edi
    7713:	44 89 f2             	mov    %r14d,%edx
    7716:	e8 75 bd ff ff       	call   3490 <connect@plt>
    771b:	85 c0                	test   %eax,%eax
    771d:	74 15                	je     7734 <fwp_pipe_in_offer+0xd4>
    771f:	89 df                	mov    %ebx,%edi
    7721:	e8 0a bb ff ff       	call   3230 <close@plt>
    7726:	48 81 c4 08 01 00 00 	add    $0x108,%rsp
    772d:	5b                   	pop    %rbx
    772e:	41 5e                	pop    %r14
    7730:	41 5f                	pop    %r15
    7732:	5d                   	pop    %rbp
    7733:	c3                   	ret
    7734:	48 89 e6             	mov    %rsp,%rsi
    7737:	ba 05 00 00 00       	mov    $0x5,%edx
    773c:	89 df                	mov    %ebx,%edi
    773e:	b9 00 40 00 00       	mov    $0x4000,%ecx
    7743:	e8 58 ba ff ff       	call   31a0 <send@plt>
    7748:	85 ed                	test   %ebp,%ebp
    774a:	75 d3                	jne    771f <fwp_pipe_in_offer+0xbf>
    774c:	48 83 f8 05          	cmp    $0x5,%rax
    7750:	75 cd                	jne    771f <fwp_pipe_in_offer+0xbf>
    7752:	89 1d 6c e5 00 00    	mov    %ebx,0xe56c(%rip)        # 15cc4 <fwp_pi_sock>
    7758:	eb cc                	jmp    7726 <fwp_pipe_in_offer+0xc6>
    775a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000007760 <fwp_pipe_in_switch>:
    7760:	55                   	push   %rbp
    7761:	41 57                	push   %r15
    7763:	41 56                	push   %r14
    7765:	53                   	push   %rbx
    7766:	48 81 ec 08 01 00 00 	sub    $0x108,%rsp
    776d:	31 db                	xor    %ebx,%ebx
    776f:	48 83 fe 01          	cmp    $0x1,%rsi
    7773:	0f 85 f6 01 00 00    	jne    796f <fwp_pipe_in_switch+0x20f>
    7779:	48 89 f8             	mov    %rdi,%rax
    777c:	8b 3d 42 e5 00 00    	mov    0xe542(%rip),%edi        # 15cc4 <fwp_pi_sock>
    7782:	85 ff                	test   %edi,%edi
    7784:	0f 88 e5 01 00 00    	js     796f <fwp_pipe_in_switch+0x20f>
    778a:	83 3d e3 ec 02 00 00 	cmpl   $0x0,0x2ece3(%rip)        # 36474 <fwp_pi_kind>
    7791:	0f 85 d8 01 00 00    	jne    796f <fwp_pipe_in_switch+0x20f>
    7797:	0f b6 00             	movzbl (%rax),%eax
    779a:	83 f8 02             	cmp    $0x2,%eax
    779d:	74 29                	je     77c8 <fwp_pipe_in_switch+0x68>
    779f:	83 f8 01             	cmp    $0x1,%eax
    77a2:	0f 85 c7 01 00 00    	jne    796f <fwp_pipe_in_switch+0x20f>
    77a8:	c7 05 c2 ec 02 00 01 	movl   $0x1,0x2ecc2(%rip)        # 36474 <fwp_pi_kind>
    77af:	00 00 00 
    77b2:	48 8d 3d 22 7a 00 00 	lea    0x7a22(%rip),%rdi        # f1db <exec_in_fp0+0xadb>
    77b9:	e8 22 5a 00 00       	call   d1e0 <fwp_pipe_report>
    77be:	bb 01 00 00 00       	mov    $0x1,%ebx
    77c3:	e9 a7 01 00 00       	jmp    796f <fwp_pipe_in_switch+0x20f>
    77c8:	48 8d 44 24 0f       	lea    0xf(%rsp),%rax
    77cd:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    77d2:	48 c7 44 24 58 01 00 	movq   $0x1,0x58(%rsp)
    77d9:	00 00 
    77db:	0f 57 c0             	xorps  %xmm0,%xmm0
    77de:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    77e3:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    77e8:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    77ed:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    77f4:	00 00 
    77f6:	48 8d 44 24 50       	lea    0x50(%rsp),%rax
    77fb:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    7800:	48 c7 44 24 28 01 00 	movq   $0x1,0x28(%rsp)
    7807:	00 00 
    7809:	48 8d 44 24 60       	lea    0x60(%rsp),%rax
    780e:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    7813:	48 c7 44 24 38 18 00 	movq   $0x18,0x38(%rsp)
    781a:	00 00 
    781c:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    7821:	ba 00 00 00 40       	mov    $0x40000000,%edx
    7826:	e8 75 bb ff ff       	call   33a0 <recvmsg@plt>
    782b:	31 db                	xor    %ebx,%ebx
    782d:	48 83 f8 01          	cmp    $0x1,%rax
    7831:	0f 85 38 01 00 00    	jne    796f <fwp_pipe_in_switch+0x20f>
    7837:	48 83 7c 24 38 10    	cmpq   $0x10,0x38(%rsp)
    783d:	0f 82 2c 01 00 00    	jb     796f <fwp_pipe_in_switch+0x20f>
    7843:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    7848:	48 85 c0             	test   %rax,%rax
    784b:	0f 84 1e 01 00 00    	je     796f <fwp_pipe_in_switch+0x20f>
    7851:	83 78 0c 01          	cmpl   $0x1,0xc(%rax)
    7855:	0f 85 14 01 00 00    	jne    796f <fwp_pipe_in_switch+0x20f>
    785b:	8b 68 10             	mov    0x10(%rax),%ebp
    785e:	48 8d 74 24 78       	lea    0x78(%rsp),%rsi
    7863:	89 ef                	mov    %ebp,%edi
    7865:	e8 76 bc ff ff       	call   34e0 <fstat@plt>
    786a:	85 c0                	test   %eax,%eax
    786c:	0f 85 f4 00 00 00    	jne    7966 <fwp_pipe_in_switch+0x206>
    7872:	4c 8b b4 24 a8 00 00 	mov    0xa8(%rsp),%r14
    7879:	00 
    787a:	49 81 fe 00 10 00 00 	cmp    $0x1000,%r14
    7881:	0f 86 df 00 00 00    	jbe    7966 <fwp_pipe_in_switch+0x206>
    7887:	31 db                	xor    %ebx,%ebx
    7889:	31 ff                	xor    %edi,%edi
    788b:	4c 89 f6             	mov    %r14,%rsi
    788e:	ba 03 00 00 00       	mov    $0x3,%edx
    7893:	b9 01 00 00 00       	mov    $0x1,%ecx
    7898:	41 89 e8             	mov    %ebp,%r8d
    789b:	45 31 c9             	xor    %r9d,%r9d
    789e:	e8 ed b8 ff ff       	call   3190 <mmap@plt>
    78a3:	49 89 c7             	mov    %rax,%r15
    78a6:	89 ef                	mov    %ebp,%edi
    78a8:	e8 83 b9 ff ff       	call   3230 <close@plt>
    78ad:	49 83 ff ff          	cmp    $0xffffffffffffffff,%r15
    78b1:	0f 84 b8 00 00 00    	je     796f <fwp_pipe_in_switch+0x20f>
    78b7:	41 81 3f 46 57 50 53 	cmpl   $0x53505746,(%r15)
    78be:	0f 85 ab 00 00 00    	jne    796f <fwp_pipe_in_switch+0x20f>
    78c4:	41 83 7f 04 01       	cmpl   $0x1,0x4(%r15)
    78c9:	0f 85 a0 00 00 00    	jne    796f <fwp_pipe_in_switch+0x20f>
    78cf:	49 8b 47 08          	mov    0x8(%r15),%rax
    78d3:	48 85 c0             	test   %rax,%rax
    78d6:	0f 84 93 00 00 00    	je     796f <fwp_pipe_in_switch+0x20f>
    78dc:	48 89 c1             	mov    %rax,%rcx
    78df:	48 d1 e9             	shr    $1,%rcx
    78e2:	48 ba 55 55 55 55 55 	movabs $0x5555555555555555,%rdx
    78e9:	55 55 55 
    78ec:	48 21 ca             	and    %rcx,%rdx
    78ef:	48 89 c1             	mov    %rax,%rcx
    78f2:	48 29 d1             	sub    %rdx,%rcx
    78f5:	48 ba 33 33 33 33 33 	movabs $0x3333333333333333,%rdx
    78fc:	33 33 33 
    78ff:	48 89 ce             	mov    %rcx,%rsi
    7902:	48 21 d6             	and    %rdx,%rsi
    7905:	48 c1 e9 02          	shr    $0x2,%rcx
    7909:	48 21 d1             	and    %rdx,%rcx
    790c:	48 01 f1             	add    %rsi,%rcx
    790f:	48 89 ca             	mov    %rcx,%rdx
    7912:	48 c1 ea 04          	shr    $0x4,%rdx
    7916:	48 01 ca             	add    %rcx,%rdx
    7919:	48 b9 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%rcx
    7920:	0f 0f 0f 
    7923:	48 21 d1             	and    %rdx,%rcx
    7926:	48 ba 01 01 01 01 01 	movabs $0x101010101010101,%rdx
    792d:	01 01 01 
    7930:	48 0f af d1          	imul   %rcx,%rdx
    7934:	48 c1 ea 38          	shr    $0x38,%rdx
    7938:	83 fa 01             	cmp    $0x1,%edx
    793b:	77 32                	ja     796f <fwp_pipe_in_switch+0x20f>
    793d:	49 81 c6 00 f0 ff ff 	add    $0xfffffffffffff000,%r14
    7944:	4c 39 f0             	cmp    %r14,%rax
    7947:	77 26                	ja     796f <fwp_pipe_in_switch+0x20f>
    7949:	4c 89 3d 28 eb 02 00 	mov    %r15,0x2eb28(%rip)        # 36478 <fwp_pi_ring>
    7950:	c7 05 1a eb 02 00 02 	movl   $0x2,0x2eb1a(%rip)        # 36474 <fwp_pi_kind>
    7957:	00 00 00 
    795a:	48 8d 3d 62 7b 00 00 	lea    0x7b62(%rip),%rdi        # f4c3 <exec_in_fp0+0xdc3>
    7961:	e9 53 fe ff ff       	jmp    77b9 <fwp_pipe_in_switch+0x59>
    7966:	89 ef                	mov    %ebp,%edi
    7968:	e8 c3 b8 ff ff       	call   3230 <close@plt>
    796d:	31 db                	xor    %ebx,%ebx
    796f:	89 d8                	mov    %ebx,%eax
    7971:	48 81 c4 08 01 00 00 	add    $0x108,%rsp
    7978:	5b                   	pop    %rbx
    7979:	41 5e                	pop    %r14
    797b:	41 5f                	pop    %r15
    797d:	5d                   	pop    %rbp
    797e:	c3                   	ret
    797f:	90                   	nop

0000000000007980 <fwp_decode>:
    7980:	55                   	push   %rbp
    7981:	41 57                	push   %r15
    7983:	41 56                	push   %r14
    7985:	41 55                	push   %r13
    7987:	41 54                	push   %r12
    7989:	53                   	push   %rbx
    798a:	48 83 ec 38          	sub    $0x38,%rsp
    798e:	8b 06                	mov    (%rsi),%eax
    7990:	45 31 f6             	xor    %r14d,%r14d
    7993:	48 83 f8 15          	cmp    $0x15,%rax
    7997:	77 47                	ja     79e0 <fwp_decode+0x60>
    7999:	48 89 d3             	mov    %rdx,%rbx
    799c:	49 89 f4             	mov    %rsi,%r12
    799f:	49 89 ff             	mov    %rdi,%r15
    79a2:	48 8d 0d d7 67 00 00 	lea    0x67d7(%rip),%rcx        # e180 <_IO_stdin_used+0x180>
    79a9:	48 63 14 81          	movslq (%rcx,%rax,4),%rdx
    79ad:	48 01 ca             	add    %rcx,%rdx
    79b0:	ff e2                	jmp    *%rdx
    79b2:	31 c9                	xor    %ecx,%ecx
    79b4:	83 f8 0a             	cmp    $0xa,%eax
    79b7:	0f 95 c1             	setne  %cl
    79ba:	8d 34 8d 04 00 00 00 	lea    0x4(,%rcx,4),%esi
    79c1:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    79c6:	4c 89 ff             	mov    %r15,%rdi
    79c9:	e8 62 58 00 00       	call   d230 <rd_le>
    79ce:	85 c0                	test   %eax,%eax
    79d0:	74 0e                	je     79e0 <fwp_decode+0x60>
    79d2:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    79d7:	48 89 03             	mov    %rax,(%rbx)
    79da:	41 be 01 00 00 00    	mov    $0x1,%r14d
    79e0:	44 89 f0             	mov    %r14d,%eax
    79e3:	48 83 c4 38          	add    $0x38,%rsp
    79e7:	5b                   	pop    %rbx
    79e8:	41 5c                	pop    %r12
    79ea:	41 5d                	pop    %r13
    79ec:	41 5e                	pop    %r14
    79ee:	41 5f                	pop    %r15
    79f0:	5d                   	pop    %rbp
    79f1:	c3                   	ret
    79f2:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    79f7:	4c 89 ff             	mov    %r15,%rdi
    79fa:	e8 f1 58 00 00       	call   d2f0 <rd_leb>
    79ff:	45 31 f6             	xor    %r14d,%r14d
    7a02:	85 c0                	test   %eax,%eax
    7a04:	74 da                	je     79e0 <fwp_decode+0x60>
    7a06:	4c 8b 6c 24 08       	mov    0x8(%rsp),%r13
    7a0b:	4d 3b 6f 08          	cmp    0x8(%r15),%r13
    7a0f:	77 cf                	ja     79e0 <fwp_decode+0x60>
    7a11:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    7a16:	4c 89 ff             	mov    %r15,%rdi
    7a19:	4c 89 ee             	mov    %r13,%rsi
    7a1c:	e8 4f 59 00 00       	call   d370 <rd_take>
    7a21:	85 c0                	test   %eax,%eax
    7a23:	74 bb                	je     79e0 <fwp_decode+0x60>
    7a25:	41 83 3c 24 0c       	cmpl   $0xc,(%r12)
    7a2a:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    7a2f:	75 0f                	jne    7a40 <fwp_decode+0xc0>
    7a31:	4c 89 ff             	mov    %r15,%rdi
    7a34:	4c 89 ee             	mov    %r13,%rsi
    7a37:	e8 f4 06 00 00       	call   8130 <fwp_valid_utf8>
    7a3c:	85 c0                	test   %eax,%eax
    7a3e:	74 a0                	je     79e0 <fwp_decode+0x60>
    7a40:	4c 89 ff             	mov    %r15,%rdi
    7a43:	4c 89 ee             	mov    %r13,%rsi
    7a46:	e8 45 08 00 00       	call   8290 <fwp_str_new>
    7a4b:	eb 8a                	jmp    79d7 <fwp_decode+0x57>
    7a4d:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7a52:	4c 89 ff             	mov    %r15,%rdi
    7a55:	be 01 00 00 00       	mov    $0x1,%esi
    7a5a:	e8 d1 57 00 00       	call   d230 <rd_le>
    7a5f:	85 c0                	test   %eax,%eax
    7a61:	0f 84 79 ff ff ff    	je     79e0 <fwp_decode+0x60>
    7a67:	48 0f be 44 24 08    	movsbq 0x8(%rsp),%rax
    7a6d:	e9 65 ff ff ff       	jmp    79d7 <fwp_decode+0x57>
    7a72:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7a77:	4c 89 ff             	mov    %r15,%rdi
    7a7a:	be 08 00 00 00       	mov    $0x8,%esi
    7a7f:	e8 ac 57 00 00       	call   d230 <rd_le>
    7a84:	45 31 f6             	xor    %r14d,%r14d
    7a87:	85 c0                	test   %eax,%eax
    7a89:	0f 84 51 ff ff ff    	je     79e0 <fwp_decode+0x60>
    7a8f:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    7a94:	4c 89 ff             	mov    %r15,%rdi
    7a97:	be 08 00 00 00       	mov    $0x8,%esi
    7a9c:	e8 8f 57 00 00       	call   d230 <rd_le>
    7aa1:	85 c0                	test   %eax,%eax
    7aa3:	0f 84 37 ff ff ff    	je     79e0 <fwp_decode+0x60>
    7aa9:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    7aae:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    7ab3:	41 83 3c 24 04       	cmpl   $0x4,(%r12)
    7ab8:	0f 85 d1 02 00 00    	jne    7d8f <fwp_decode+0x40f>
    7abe:	e8 7d 26 00 00       	call   a140 <fwp_box_i128>
    7ac3:	e9 0f ff ff ff       	jmp    79d7 <fwp_decode+0x57>
    7ac8:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    7acd:	4c 89 ff             	mov    %r15,%rdi
    7ad0:	e8 1b 58 00 00       	call   d2f0 <rd_leb>
    7ad5:	85 c0                	test   %eax,%eax
    7ad7:	0f 84 03 ff ff ff    	je     79e0 <fwp_decode+0x60>
    7add:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    7ae2:	49 3b 6f 08          	cmp    0x8(%r15),%rbp
    7ae6:	0f 87 f4 fe ff ff    	ja     79e0 <fwp_decode+0x60>
    7aec:	4c 8d 35 3d e9 01 00 	lea    0x1e93d(%rip),%r14        # 26430 <fwp_empty_map>
    7af3:	48 85 ed             	test   %rbp,%rbp
    7af6:	0f 84 9d 02 00 00    	je     7d99 <fwp_decode+0x419>
    7afc:	4c 8d 6c 24 18       	lea    0x18(%rsp),%r13
    7b01:	eb 20                	jmp    7b23 <fwp_decode+0x1a3>
    7b03:	31 f6                	xor    %esi,%esi
    7b05:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    7b0a:	49 8b 4c 24 38       	mov    0x38(%r12),%rcx
    7b0f:	4c 89 f2             	mov    %r14,%rdx
    7b12:	e8 69 1e 00 00       	call   9980 <fwp_p_map_insert>
    7b17:	49 89 c6             	mov    %rax,%r14
    7b1a:	48 ff cd             	dec    %rbp
    7b1d:	0f 84 76 02 00 00    	je     7d99 <fwp_decode+0x419>
    7b23:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
    7b2a:	00 00 
    7b2c:	49 8b 74 24 38       	mov    0x38(%r12),%rsi
    7b31:	4c 89 ff             	mov    %r15,%rdi
    7b34:	4c 89 ea             	mov    %r13,%rdx
    7b37:	e8 44 fe ff ff       	call   7980 <fwp_decode>
    7b3c:	85 c0                	test   %eax,%eax
    7b3e:	0f 84 69 02 00 00    	je     7dad <fwp_decode+0x42d>
    7b44:	41 83 3c 24 12       	cmpl   $0x12,(%r12)
    7b49:	75 b8                	jne    7b03 <fwp_decode+0x183>
    7b4b:	49 8b 74 24 40       	mov    0x40(%r12),%rsi
    7b50:	4c 89 ff             	mov    %r15,%rdi
    7b53:	48 8d 54 24 30       	lea    0x30(%rsp),%rdx
    7b58:	e8 23 fe ff ff       	call   7980 <fwp_decode>
    7b5d:	85 c0                	test   %eax,%eax
    7b5f:	0f 84 48 02 00 00    	je     7dad <fwp_decode+0x42d>
    7b65:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    7b6a:	eb 99                	jmp    7b05 <fwp_decode+0x185>
    7b6c:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    7b71:	4c 89 ff             	mov    %r15,%rdi
    7b74:	e8 77 57 00 00       	call   d2f0 <rd_leb>
    7b79:	85 c0                	test   %eax,%eax
    7b7b:	0f 84 5f fe ff ff    	je     79e0 <fwp_decode+0x60>
    7b81:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
    7b86:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    7b8b:	49 3b 5f 08          	cmp    0x8(%r15),%rbx
    7b8f:	0f 87 4b fe ff ff    	ja     79e0 <fwp_decode+0x60>
    7b95:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    7b9c:	00 
    7b9d:	e8 ee e6 ff ff       	call   6290 <fwp_alloc>
    7ba2:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    7ba7:	48 85 db             	test   %rbx,%rbx
    7baa:	74 35                	je     7be1 <fwp_decode+0x261>
    7bac:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
    7bb1:	49 89 dd             	mov    %rbx,%r13
    7bb4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    7bbb:	00 00 00 00 00 
    7bc0:	49 8b 74 24 38       	mov    0x38(%r12),%rsi
    7bc5:	4c 89 ff             	mov    %r15,%rdi
    7bc8:	48 89 ea             	mov    %rbp,%rdx
    7bcb:	e8 b0 fd ff ff       	call   7980 <fwp_decode>
    7bd0:	85 c0                	test   %eax,%eax
    7bd2:	0f 84 08 fe ff ff    	je     79e0 <fwp_decode+0x60>
    7bd8:	48 83 c5 08          	add    $0x8,%rbp
    7bdc:	49 ff cd             	dec    %r13
    7bdf:	75 df                	jne    7bc0 <fwp_decode+0x240>
    7be1:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    7be6:	48 89 de             	mov    %rbx,%rsi
    7be9:	e8 a2 02 00 00       	call   7e90 <fwp_list_from>
    7bee:	41 83 3c 24 11       	cmpl   $0x11,(%r12)
    7bf3:	0f 85 b4 00 00 00    	jne    7cad <fwp_decode+0x32d>
    7bf9:	48 89 c7             	mov    %rax,%rdi
    7bfc:	e8 2f 1c 00 00       	call   9830 <fwp_p_array_from_list>
    7c01:	e9 a7 00 00 00       	jmp    7cad <fwp_decode+0x32d>
    7c06:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    7c0b:	4c 89 ff             	mov    %r15,%rdi
    7c0e:	e8 dd 56 00 00       	call   d2f0 <rd_leb>
    7c13:	85 c0                	test   %eax,%eax
    7c15:	0f 84 c5 fd ff ff    	je     79e0 <fwp_decode+0x60>
    7c1b:	4c 8b 6c 24 08       	mov    0x8(%rsp),%r13
    7c20:	49 63 44 24 10       	movslq 0x10(%r12),%rax
    7c25:	49 39 c5             	cmp    %rax,%r13
    7c28:	0f 83 b2 fd ff ff    	jae    79e0 <fwp_decode+0x60>
    7c2e:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
    7c33:	49 8b 44 24 28       	mov    0x28(%r12),%rax
    7c38:	4a 63 1c a8          	movslq (%rax,%r13,4),%rbx
    7c3c:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    7c43:	00 
    7c44:	e8 47 e6 ff ff       	call   6290 <fwp_alloc>
    7c49:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    7c4e:	89 d8                	mov    %ebx,%eax
    7c50:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    7c55:	48 85 db             	test   %rbx,%rbx
    7c58:	7e 41                	jle    7c9b <fwp_decode+0x31b>
    7c5a:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    7c5f:	48 8d 2c c5 00 00 00 	lea    0x0(,%rax,8),%rbp
    7c66:	00 
    7c67:	45 31 f6             	xor    %r14d,%r14d
    7c6a:	31 db                	xor    %ebx,%ebx
    7c6c:	49 8b 44 24 30       	mov    0x30(%r12),%rax
    7c71:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    7c75:	48 8b 34 18          	mov    (%rax,%rbx,1),%rsi
    7c79:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    7c7e:	48 8d 14 18          	lea    (%rax,%rbx,1),%rdx
    7c82:	4c 89 ff             	mov    %r15,%rdi
    7c85:	e8 f6 fc ff ff       	call   7980 <fwp_decode>
    7c8a:	85 c0                	test   %eax,%eax
    7c8c:	0f 84 4e fd ff ff    	je     79e0 <fwp_decode+0x60>
    7c92:	48 83 c3 08          	add    $0x8,%rbx
    7c96:	48 39 dd             	cmp    %rbx,%rbp
    7c99:	75 d1                	jne    7c6c <fwp_decode+0x2ec>
    7c9b:	44 89 ef             	mov    %r13d,%edi
    7c9e:	48 8b 74 24 28       	mov    0x28(%rsp),%rsi
    7ca3:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
    7ca8:	e8 23 c6 ff ff       	call   42d0 <fwp_data>
    7cad:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    7cb2:	48 89 01             	mov    %rax,(%rcx)
    7cb5:	e9 20 fd ff ff       	jmp    79da <fwp_decode+0x5a>
    7cba:	be 01 00 00 00       	mov    $0x1,%esi
    7cbf:	e9 fd fc ff ff       	jmp    79c1 <fwp_decode+0x41>
    7cc4:	be 02 00 00 00       	mov    $0x2,%esi
    7cc9:	e9 f3 fc ff ff       	jmp    79c1 <fwp_decode+0x41>
    7cce:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7cd3:	4c 89 ff             	mov    %r15,%rdi
    7cd6:	be 02 00 00 00       	mov    $0x2,%esi
    7cdb:	e8 50 55 00 00       	call   d230 <rd_le>
    7ce0:	85 c0                	test   %eax,%eax
    7ce2:	0f 84 f8 fc ff ff    	je     79e0 <fwp_decode+0x60>
    7ce8:	48 0f bf 44 24 08    	movswq 0x8(%rsp),%rax
    7cee:	e9 e4 fc ff ff       	jmp    79d7 <fwp_decode+0x57>
    7cf3:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7cf8:	4c 89 ff             	mov    %r15,%rdi
    7cfb:	be 04 00 00 00       	mov    $0x4,%esi
    7d00:	e8 2b 55 00 00       	call   d230 <rd_le>
    7d05:	85 c0                	test   %eax,%eax
    7d07:	0f 84 d3 fc ff ff    	je     79e0 <fwp_decode+0x60>
    7d0d:	48 63 44 24 08       	movslq 0x8(%rsp),%rax
    7d12:	e9 c0 fc ff ff       	jmp    79d7 <fwp_decode+0x57>
    7d17:	be 04 00 00 00       	mov    $0x4,%esi
    7d1c:	e9 a0 fc ff ff       	jmp    79c1 <fwp_decode+0x41>
    7d21:	49 63 7c 24 10       	movslq 0x10(%r12),%rdi
    7d26:	48 85 ff             	test   %rdi,%rdi
    7d29:	74 76                	je     7da1 <fwp_decode+0x421>
    7d2b:	48 c1 e7 03          	shl    $0x3,%rdi
    7d2f:	e8 5c e5 ff ff       	call   6290 <fwp_alloc>
    7d34:	41 8b 7c 24 10       	mov    0x10(%r12),%edi
    7d39:	85 ff                	test   %edi,%edi
    7d3b:	7e 45                	jle    7d82 <fwp_decode+0x402>
    7d3d:	45 31 f6             	xor    %r14d,%r14d
    7d40:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    7d45:	48 89 c5             	mov    %rax,%rbp
    7d48:	45 31 ed             	xor    %r13d,%r13d
    7d4b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7d50:	49 8b 44 24 20       	mov    0x20(%r12),%rax
    7d55:	4a 8b 34 e8          	mov    (%rax,%r13,8),%rsi
    7d59:	4c 89 ff             	mov    %r15,%rdi
    7d5c:	48 89 ea             	mov    %rbp,%rdx
    7d5f:	e8 1c fc ff ff       	call   7980 <fwp_decode>
    7d64:	85 c0                	test   %eax,%eax
    7d66:	0f 84 74 fc ff ff    	je     79e0 <fwp_decode+0x60>
    7d6c:	49 ff c5             	inc    %r13
    7d6f:	49 63 7c 24 10       	movslq 0x10(%r12),%rdi
    7d74:	48 83 c5 08          	add    $0x8,%rbp
    7d78:	49 39 fd             	cmp    %rdi,%r13
    7d7b:	7c d3                	jl     7d50 <fwp_decode+0x3d0>
    7d7d:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    7d82:	48 89 c6             	mov    %rax,%rsi
    7d85:	e8 d6 c4 ff ff       	call   4260 <fwp_record>
    7d8a:	e9 48 fc ff ff       	jmp    79d7 <fwp_decode+0x57>
    7d8f:	e8 5c 22 00 00       	call   9ff0 <fwp_box_u128>
    7d94:	e9 3e fc ff ff       	jmp    79d7 <fwp_decode+0x57>
    7d99:	4c 89 33             	mov    %r14,(%rbx)
    7d9c:	e9 39 fc ff ff       	jmp    79da <fwp_decode+0x5a>
    7da1:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    7da8:	e9 2d fc ff ff       	jmp    79da <fwp_decode+0x5a>
    7dad:	45 31 f6             	xor    %r14d,%r14d
    7db0:	e9 2b fc ff ff       	jmp    79e0 <fwp_decode+0x60>
    7db5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    7dbc:	00 00 00 00 

0000000000007dc0 <fwp_read_text_line>:
    7dc0:	53                   	push   %rbx
    7dc1:	48 89 fb             	mov    %rdi,%rbx
    7dc4:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
    7dcb:	00 
    7dcc:	e8 cf 55 00 00       	call   d3a0 <fwp_getc>
    7dd1:	83 f8 ff             	cmp    $0xffffffff,%eax
    7dd4:	74 59                	je     7e2f <fwp_read_text_line+0x6f>
    7dd6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    7ddd:	00 00 00 
    7de0:	83 f8 0a             	cmp    $0xa,%eax
    7de3:	74 1a                	je     7dff <fwp_read_text_line+0x3f>
    7de5:	0f be f0             	movsbl %al,%esi
    7de8:	48 89 df             	mov    %rbx,%rdi
    7deb:	e8 e0 04 00 00       	call   82d0 <buf_putc>
    7df0:	e8 ab 55 00 00       	call   d3a0 <fwp_getc>
    7df5:	83 f8 ff             	cmp    $0xffffffff,%eax
    7df8:	75 e6                	jne    7de0 <fwp_read_text_line+0x20>
    7dfa:	48 8b 03             	mov    (%rbx),%rax
    7dfd:	eb 1c                	jmp    7e1b <fwp_read_text_line+0x5b>
    7dff:	48 8b 03             	mov    (%rbx),%rax
    7e02:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    7e06:	48 85 c9             	test   %rcx,%rcx
    7e09:	74 10                	je     7e1b <fwp_read_text_line+0x5b>
    7e0b:	80 7c 08 ff 0d       	cmpb   $0xd,-0x1(%rax,%rcx,1)
    7e10:	75 12                	jne    7e24 <fwp_read_text_line+0x64>
    7e12:	48 ff c9             	dec    %rcx
    7e15:	48 89 4b 08          	mov    %rcx,0x8(%rbx)
    7e19:	eb 05                	jmp    7e20 <fwp_read_text_line+0x60>
    7e1b:	48 85 c0             	test   %rax,%rax
    7e1e:	74 08                	je     7e28 <fwp_read_text_line+0x68>
    7e20:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    7e24:	c6 04 08 00          	movb   $0x0,(%rax,%rcx,1)
    7e28:	b8 01 00 00 00       	mov    $0x1,%eax
    7e2d:	5b                   	pop    %rbx
    7e2e:	c3                   	ret
    7e2f:	31 c0                	xor    %eax,%eax
    7e31:	5b                   	pop    %rbx
    7e32:	c3                   	ret
    7e33:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7e3a:	84 00 00 00 00 00 

0000000000007e40 <fwp_mem_realloc>:
    7e40:	41 57                	push   %r15
    7e42:	41 56                	push   %r14
    7e44:	53                   	push   %rbx
    7e45:	49 89 d6             	mov    %rdx,%r14
    7e48:	49 89 f7             	mov    %rsi,%r15
    7e4b:	48 89 fb             	mov    %rdi,%rbx
    7e4e:	48 89 d7             	mov    %rdx,%rdi
    7e51:	e8 3a e4 ff ff       	call   6290 <fwp_alloc>
    7e56:	48 85 db             	test   %rbx,%rbx
    7e59:	74 23                	je     7e7e <fwp_mem_realloc+0x3e>
    7e5b:	4d 39 f7             	cmp    %r14,%r15
    7e5e:	4d 0f 42 f7          	cmovb  %r15,%r14
    7e62:	48 89 c7             	mov    %rax,%rdi
    7e65:	48 89 de             	mov    %rbx,%rsi
    7e68:	4c 89 f2             	mov    %r14,%rdx
    7e6b:	49 89 c6             	mov    %rax,%r14
    7e6e:	e8 bd b4 ff ff       	call   3330 <memcpy@plt>
    7e73:	48 89 df             	mov    %rbx,%rdi
    7e76:	e8 55 00 00 00       	call   7ed0 <fwp_mem_free>
    7e7b:	4c 89 f0             	mov    %r14,%rax
    7e7e:	5b                   	pop    %rbx
    7e7f:	41 5e                	pop    %r14
    7e81:	41 5f                	pop    %r15
    7e83:	c3                   	ret
    7e84:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    7e8b:	00 00 00 00 00 

0000000000007e90 <fwp_list_from>:
    7e90:	41 56                	push   %r14
    7e92:	53                   	push   %rbx
    7e93:	50                   	push   %rax
    7e94:	48 89 fb             	mov    %rdi,%rbx
    7e97:	48 85 f6             	test   %rsi,%rsi
    7e9a:	74 28                	je     7ec4 <fwp_list_from+0x34>
    7e9c:	49 89 f6             	mov    %rsi,%r14
    7e9f:	31 c0                	xor    %eax,%eax
    7ea1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7ea8:	0f 1f 84 00 00 00 00 
    7eaf:	00 
    7eb0:	4a 8b 7c f3 f8       	mov    -0x8(%rbx,%r14,8),%rdi
    7eb5:	48 89 c6             	mov    %rax,%rsi
    7eb8:	e8 43 08 00 00       	call   8700 <fwp_cons>
    7ebd:	49 ff ce             	dec    %r14
    7ec0:	75 ee                	jne    7eb0 <fwp_list_from+0x20>
    7ec2:	eb 02                	jmp    7ec6 <fwp_list_from+0x36>
    7ec4:	31 c0                	xor    %eax,%eax
    7ec6:	48 83 c4 08          	add    $0x8,%rsp
    7eca:	5b                   	pop    %rbx
    7ecb:	41 5e                	pop    %r14
    7ecd:	c3                   	ret
    7ece:	66 90                	xchg   %ax,%ax

0000000000007ed0 <fwp_mem_free>:
    7ed0:	48 85 ff             	test   %rdi,%rdi
    7ed3:	0f 84 c7 01 00 00    	je     80a0 <fwp_mem_free+0x1d0>
    7ed9:	41 57                	push   %r15
    7edb:	41 56                	push   %r14
    7edd:	53                   	push   %rbx
    7ede:	48 83 ec 10          	sub    $0x10,%rsp
    7ee2:	49 89 ff             	mov    %rdi,%r15
    7ee5:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    7eea:	e8 e1 e0 ff ff       	call   5fd0 <fwp_gc_chunk_of>
    7eef:	48 85 c0             	test   %rax,%rax
    7ef2:	0f 84 9f 01 00 00    	je     8097 <fwp_mem_free+0x1c7>
    7ef8:	49 89 c6             	mov    %rax,%r14
    7efb:	0f b6 00             	movzbl (%rax),%eax
    7efe:	83 f8 02             	cmp    $0x2,%eax
    7f01:	0f 84 96 00 00 00    	je     7f9d <fwp_mem_free+0xcd>
    7f07:	83 f8 01             	cmp    $0x1,%eax
    7f0a:	0f 85 87 01 00 00    	jne    8097 <fwp_mem_free+0x1c7>
    7f10:	41 0f b6 46 01       	movzbl 0x1(%r14),%eax
    7f15:	41 0f b6 4e 02       	movzbl 0x2(%r14),%ecx
    7f1a:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    7f21:	48 8d 35 70 c3 00 00 	lea    0xc370(%rip),%rsi        # 14298 <fwp_gc>
    7f28:	48 01 c6             	add    %rax,%rsi
    7f2b:	48 8d 3c 49          	lea    (%rcx,%rcx,2),%rdi
    7f2f:	41 0f b7 c7          	movzwl %r15w,%eax
    7f33:	31 d2                	xor    %edx,%edx
    7f35:	41 f7 76 08          	divl   0x8(%r14)
    7f39:	48 c7 c2 fe ff ff ff 	mov    $0xfffffffffffffffe,%rdx
    7f40:	89 c1                	mov    %eax,%ecx
    7f42:	48 d3 c2             	rol    %cl,%rdx
    7f45:	48 8d 1c fe          	lea    (%rsi,%rdi,8),%rbx
    7f49:	48 83 c3 08          	add    $0x8,%rbx
    7f4d:	49 8d 3c 06          	lea    (%r14,%rax,1),%rdi
    7f51:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    7f58:	c1 e8 03             	shr    $0x3,%eax
    7f5b:	25 f8 1f 00 00       	and    $0x1ff8,%eax
    7f60:	49 21 54 06 28       	and    %rdx,0x28(%r14,%rax,1)
    7f65:	e8 06 c1 ff ff       	call   4070 <fwp_rc_clear_slot>
    7f6a:	83 3d 2b d3 00 00 00 	cmpl   $0x0,0xd32b(%rip)        # 1529c <fwp_gc+0x1004>
    7f71:	74 0e                	je     7f81 <fwp_mem_free+0xb1>
    7f73:	41 8b 56 08          	mov    0x8(%r14),%edx
    7f77:	4c 89 ff             	mov    %r15,%rdi
    7f7a:	31 f6                	xor    %esi,%esi
    7f7c:	e8 8f b2 ff ff       	call   3210 <memset@plt>
    7f81:	48 8b 03             	mov    (%rbx),%rax
    7f84:	48 f7 d0             	not    %rax
    7f87:	49 89 07             	mov    %rax,(%r15)
    7f8a:	4c 89 3b             	mov    %r15,(%rbx)
    7f8d:	41 8b 46 08          	mov    0x8(%r14),%eax
    7f91:	48 01 05 00 c3 00 00 	add    %rax,0xc300(%rip)        # 14298 <fwp_gc>
    7f98:	e9 fa 00 00 00       	jmp    8097 <fwp_mem_free+0x1c7>
    7f9d:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    7fa2:	48 89 df             	mov    %rbx,%rdi
    7fa5:	e8 e6 c0 ff ff       	call   4090 <fwp_gc_chunk_addr>
    7faa:	4c 39 f8             	cmp    %r15,%rax
    7fad:	0f 85 e4 00 00 00    	jne    8097 <fwp_mem_free+0x1c7>
    7fb3:	49 8b 46 18          	mov    0x18(%r14),%rax
    7fb7:	48 01 05 da c2 00 00 	add    %rax,0xc2da(%rip)        # 14298 <fwp_gc>
    7fbe:	41 c6 46 03 00       	movb   $0x0,0x3(%r14)
    7fc3:	4c 89 f7             	mov    %r14,%rdi
    7fc6:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    7fcd:	e8 9e c0 ff ff       	call   4070 <fwp_rc_clear_slot>
    7fd2:	41 8b 46 10          	mov    0x10(%r14),%eax
    7fd6:	48 85 c0             	test   %rax,%rax
    7fd9:	0f 84 91 00 00 00    	je     8070 <fwp_mem_free+0x1a0>
    7fdf:	48 8b 0d 2a d3 00 00 	mov    0xd32a(%rip),%rcx        # 15310 <fwp_gc+0x1078>
    7fe6:	48 69 f3 28 12 00 00 	imul   $0x1228,%rbx,%rsi
    7fed:	89 c2                	mov    %eax,%edx
    7fef:	83 e2 03             	and    $0x3,%edx
    7ff2:	83 f8 04             	cmp    $0x4,%eax
    7ff5:	73 04                	jae    7ffb <fwp_mem_free+0x12b>
    7ff7:	31 ff                	xor    %edi,%edi
    7ff9:	eb 41                	jmp    803c <fwp_mem_free+0x16c>
    7ffb:	4c 8d 04 31          	lea    (%rcx,%rsi,1),%r8
    7fff:	41 89 c1             	mov    %eax,%r9d
    8002:	41 83 e1 fc          	and    $0xfffffffc,%r9d
    8006:	31 ff                	xor    %edi,%edi
    8008:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    800f:	00 
    8010:	41 c6 00 00          	movb   $0x0,(%r8)
    8014:	41 c6 80 28 12 00 00 	movb   $0x0,0x1228(%r8)
    801b:	00 
    801c:	41 c6 80 50 24 00 00 	movb   $0x0,0x2450(%r8)
    8023:	00 
    8024:	41 c6 80 78 36 00 00 	movb   $0x0,0x3678(%r8)
    802b:	00 
    802c:	48 83 c7 04          	add    $0x4,%rdi
    8030:	49 81 c0 a0 48 00 00 	add    $0x48a0,%r8
    8037:	49 39 f9             	cmp    %rdi,%r9
    803a:	75 d4                	jne    8010 <fwp_mem_free+0x140>
    803c:	48 85 d2             	test   %rdx,%rdx
    803f:	74 2f                	je     8070 <fwp_mem_free+0x1a0>
    8041:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    8048:	48 01 f7             	add    %rsi,%rdi
    804b:	48 01 f9             	add    %rdi,%rcx
    804e:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    8055:	31 f6                	xor    %esi,%esi
    8057:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    805e:	00 00 
    8060:	c6 04 31 00          	movb   $0x0,(%rcx,%rsi,1)
    8064:	48 81 c6 28 12 00 00 	add    $0x1228,%rsi
    806b:	48 39 f2             	cmp    %rsi,%rdx
    806e:	75 f0                	jne    8060 <fwp_mem_free+0x190>
    8070:	48 01 05 01 d4 00 00 	add    %rax,0xd401(%rip)        # 15478 <fwp_gc+0x11e0>
    8077:	48 3b 1d 8a d2 00 00 	cmp    0xd28a(%rip),%rbx        # 15308 <fwp_gc+0x1070>
    807e:	73 07                	jae    8087 <fwp_mem_free+0x1b7>
    8080:	48 89 1d 81 d2 00 00 	mov    %rbx,0xd281(%rip)        # 15308 <fwp_gc+0x1070>
    8087:	48 3b 1d 72 d2 00 00 	cmp    0xd272(%rip),%rbx        # 15300 <fwp_gc+0x1068>
    808e:	73 07                	jae    8097 <fwp_mem_free+0x1c7>
    8090:	48 89 1d 69 d2 00 00 	mov    %rbx,0xd269(%rip)        # 15300 <fwp_gc+0x1068>
    8097:	48 83 c4 10          	add    $0x10,%rsp
    809b:	5b                   	pop    %rbx
    809c:	41 5e                	pop    %r14
    809e:	41 5f                	pop    %r15
    80a0:	c3                   	ret
    80a1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    80a8:	0f 1f 84 00 00 00 00 
    80af:	00 

00000000000080b0 <fwp_pipe_out_end>:
    80b0:	50                   	push   %rax
    80b1:	8b 05 89 e3 01 00    	mov    0x1e389(%rip),%eax        # 26440 <fwp_po_kind>
    80b7:	83 f8 02             	cmp    $0x2,%eax
    80ba:	74 1c                	je     80d8 <fwp_pipe_out_end+0x28>
    80bc:	83 f8 01             	cmp    $0x1,%eax
    80bf:	75 3d                	jne    80fe <fwp_pipe_out_end+0x4e>
    80c1:	e8 4a 2b 00 00       	call   ac10 <fwp_po_flush_sock>
    80c6:	8b 3d f0 db 00 00    	mov    0xdbf0(%rip),%edi        # 15cbc <fwp_po_sock>
    80cc:	be 01 00 00 00       	mov    $0x1,%esi
    80d1:	e8 8a b0 ff ff       	call   3160 <shutdown@plt>
    80d6:	eb 35                	jmp    810d <fwp_pipe_out_end+0x5d>
    80d8:	48 8b 35 71 e3 02 00 	mov    0x2e371(%rip),%rsi        # 36450 <fwp_po_ring>
    80df:	c7 86 40 01 00 00 01 	movl   $0x1,0x140(%rsi)
    80e6:	00 00 00 
    80e9:	48 8d be c0 00 00 00 	lea    0xc0(%rsi),%rdi
    80f0:	48 81 c6 c4 00 00 00 	add    $0xc4,%rsi
    80f7:	e8 24 2d 00 00       	call   ae20 <fwp_ring_wake>
    80fc:	eb 0f                	jmp    810d <fwp_pipe_out_end+0x5d>
    80fe:	48 8b 05 ab be 00 00 	mov    0xbeab(%rip),%rax        # 13fb0 <stdout@GLIBC_2.2.5>
    8105:	48 8b 38             	mov    (%rax),%rdi
    8108:	e8 43 b2 ff ff       	call   3350 <fflush@plt>
    810d:	8b 3d a5 db 00 00    	mov    0xdba5(%rip),%edi        # 15cb8 <fwp_po_listen>
    8113:	85 ff                	test   %edi,%edi
    8115:	78 0f                	js     8126 <fwp_pipe_out_end+0x76>
    8117:	e8 14 b1 ff ff       	call   3230 <close@plt>
    811c:	c7 05 92 db 00 00 ff 	movl   $0xffffffff,0xdb92(%rip)        # 15cb8 <fwp_po_listen>
    8123:	ff ff ff 
    8126:	58                   	pop    %rax
    8127:	c3                   	ret
    8128:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    812f:	00 

0000000000008130 <fwp_valid_utf8>:
    8130:	48 85 f6             	test   %rsi,%rsi
    8133:	0f 84 48 01 00 00    	je     8281 <fwp_valid_utf8+0x151>
    8139:	53                   	push   %rbx
    813a:	31 c9                	xor    %ecx,%ecx
    813c:	eb 0e                	jmp    814c <fwp_valid_utf8+0x1c>
    813e:	66 90                	xchg   %ax,%ax
    8140:	48 ff c1             	inc    %rcx
    8143:	48 39 f1             	cmp    %rsi,%rcx
    8146:	0f 83 2e 01 00 00    	jae    827a <fwp_valid_utf8+0x14a>
    814c:	44 0f b6 14 0f       	movzbl (%rdi,%rcx,1),%r10d
    8151:	45 84 d2             	test   %r10b,%r10b
    8154:	79 ea                	jns    8140 <fwp_valid_utf8+0x10>
    8156:	41 8d 42 3e          	lea    0x3e(%r10),%eax
    815a:	3c 1e                	cmp    $0x1e,%al
    815c:	73 12                	jae    8170 <fwp_valid_utf8+0x40>
    815e:	ba 80 00 00 00       	mov    $0x80,%edx
    8163:	b8 01 00 00 00       	mov    $0x1,%eax
    8168:	41 b8 1f 00 00 00    	mov    $0x1f,%r8d
    816e:	eb 37                	jmp    81a7 <fwp_valid_utf8+0x77>
    8170:	44 89 d0             	mov    %r10d,%eax
    8173:	24 f0                	and    $0xf0,%al
    8175:	3c e0                	cmp    $0xe0,%al
    8177:	75 12                	jne    818b <fwp_valid_utf8+0x5b>
    8179:	ba 00 08 00 00       	mov    $0x800,%edx
    817e:	b8 02 00 00 00       	mov    $0x2,%eax
    8183:	41 b8 0f 00 00 00    	mov    $0xf,%r8d
    8189:	eb 1c                	jmp    81a7 <fwp_valid_utf8+0x77>
    818b:	41 8d 42 10          	lea    0x10(%r10),%eax
    818f:	3c 04                	cmp    $0x4,%al
    8191:	0f 87 f0 00 00 00    	ja     8287 <fwp_valid_utf8+0x157>
    8197:	ba 00 00 01 00       	mov    $0x10000,%edx
    819c:	b8 03 00 00 00       	mov    $0x3,%eax
    81a1:	41 b8 07 00 00 00    	mov    $0x7,%r8d
    81a7:	41 89 c1             	mov    %eax,%r9d
    81aa:	4e 8d 1c 09          	lea    (%rcx,%r9,1),%r11
    81ae:	31 c0                	xor    %eax,%eax
    81b0:	49 39 f3             	cmp    %rsi,%r11
    81b3:	0f 83 c6 00 00 00    	jae    827f <fwp_valid_utf8+0x14f>
    81b9:	44 0f b6 5c 0f 01    	movzbl 0x1(%rdi,%rcx,1),%r11d
    81bf:	44 89 db             	mov    %r11d,%ebx
    81c2:	83 e3 c0             	and    $0xffffffc0,%ebx
    81c5:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
    81cb:	0f 85 ae 00 00 00    	jne    827f <fwp_valid_utf8+0x14f>
    81d1:	45 21 d0             	and    %r10d,%r8d
    81d4:	45 8d 51 01          	lea    0x1(%r9),%r10d
    81d8:	44 89 c3             	mov    %r8d,%ebx
    81db:	c1 e3 06             	shl    $0x6,%ebx
    81de:	41 83 e3 3f          	and    $0x3f,%r11d
    81e2:	41 09 db             	or     %ebx,%r11d
    81e5:	41 83 fa 02          	cmp    $0x2,%r10d
    81e9:	75 0d                	jne    81f8 <fwp_valid_utf8+0xc8>
    81eb:	45 89 da             	mov    %r11d,%r10d
    81ee:	41 39 d2             	cmp    %edx,%r10d
    81f1:	73 62                	jae    8255 <fwp_valid_utf8+0x125>
    81f3:	e9 87 00 00 00       	jmp    827f <fwp_valid_utf8+0x14f>
    81f8:	44 0f b6 44 0f 02    	movzbl 0x2(%rdi,%rcx,1),%r8d
    81fe:	44 89 c3             	mov    %r8d,%ebx
    8201:	83 e3 c0             	and    $0xffffffc0,%ebx
    8204:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
    820a:	75 73                	jne    827f <fwp_valid_utf8+0x14f>
    820c:	44 89 db             	mov    %r11d,%ebx
    820f:	c1 e3 06             	shl    $0x6,%ebx
    8212:	41 83 e0 3f          	and    $0x3f,%r8d
    8216:	41 09 d8             	or     %ebx,%r8d
    8219:	41 83 fa 03          	cmp    $0x3,%r10d
    821d:	75 0d                	jne    822c <fwp_valid_utf8+0xfc>
    821f:	45 89 c2             	mov    %r8d,%r10d
    8222:	45 89 d8             	mov    %r11d,%r8d
    8225:	41 39 d2             	cmp    %edx,%r10d
    8228:	73 2b                	jae    8255 <fwp_valid_utf8+0x125>
    822a:	eb 53                	jmp    827f <fwp_valid_utf8+0x14f>
    822c:	44 0f b6 54 0f 03    	movzbl 0x3(%rdi,%rcx,1),%r10d
    8232:	45 89 d3             	mov    %r10d,%r11d
    8235:	41 83 e3 c0          	and    $0xffffffc0,%r11d
    8239:	41 81 fb 80 00 00 00 	cmp    $0x80,%r11d
    8240:	75 3d                	jne    827f <fwp_valid_utf8+0x14f>
    8242:	45 89 c3             	mov    %r8d,%r11d
    8245:	41 c1 e3 06          	shl    $0x6,%r11d
    8249:	41 83 e2 3f          	and    $0x3f,%r10d
    824d:	45 09 da             	or     %r11d,%r10d
    8250:	41 39 d2             	cmp    %edx,%r10d
    8253:	72 2a                	jb     827f <fwp_valid_utf8+0x14f>
    8255:	41 81 fa ff ff 10 00 	cmp    $0x10ffff,%r10d
    825c:	77 21                	ja     827f <fwp_valid_utf8+0x14f>
    825e:	41 83 e0 e0          	and    $0xffffffe0,%r8d
    8262:	41 81 f8 60 03 00 00 	cmp    $0x360,%r8d
    8269:	74 14                	je     827f <fwp_valid_utf8+0x14f>
    826b:	4c 01 c9             	add    %r9,%rcx
    826e:	48 ff c1             	inc    %rcx
    8271:	48 39 f1             	cmp    %rsi,%rcx
    8274:	0f 82 d2 fe ff ff    	jb     814c <fwp_valid_utf8+0x1c>
    827a:	b8 01 00 00 00       	mov    $0x1,%eax
    827f:	5b                   	pop    %rbx
    8280:	c3                   	ret
    8281:	b8 01 00 00 00       	mov    $0x1,%eax
    8286:	c3                   	ret
    8287:	31 c0                	xor    %eax,%eax
    8289:	5b                   	pop    %rbx
    828a:	c3                   	ret
    828b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000008290 <fwp_str_new>:
    8290:	41 57                	push   %r15
    8292:	41 56                	push   %r14
    8294:	53                   	push   %rbx
    8295:	48 89 f3             	mov    %rsi,%rbx
    8298:	49 89 fe             	mov    %rdi,%r14
    829b:	48 8d 7e 09          	lea    0x9(%rsi),%rdi
    829f:	e8 4c ec ff ff       	call   6ef0 <fwp_alloc_leaf>
    82a4:	49 89 c7             	mov    %rax,%r15
    82a7:	48 89 18             	mov    %rbx,(%rax)
    82aa:	48 8d 78 08          	lea    0x8(%rax),%rdi
    82ae:	4c 89 f6             	mov    %r14,%rsi
    82b1:	48 89 da             	mov    %rbx,%rdx
    82b4:	e8 77 b0 ff ff       	call   3330 <memcpy@plt>
    82b9:	41 c6 44 1f 08 00    	movb   $0x0,0x8(%r15,%rbx,1)
    82bf:	4c 89 f8             	mov    %r15,%rax
    82c2:	5b                   	pop    %rbx
    82c3:	41 5e                	pop    %r14
    82c5:	41 5f                	pop    %r15
    82c7:	c3                   	ret
    82c8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    82cf:	00 

00000000000082d0 <buf_putc>:
    82d0:	50                   	push   %rax
    82d1:	40 88 74 24 07       	mov    %sil,0x7(%rsp)
    82d6:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
    82db:	ba 01 00 00 00       	mov    $0x1,%edx
    82e0:	e8 3b 00 00 00       	call   8320 <buf_put>
    82e5:	58                   	pop    %rax
    82e6:	c3                   	ret
    82e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    82ee:	00 00 

00000000000082f0 <buf_puts>:
    82f0:	41 56                	push   %r14
    82f2:	53                   	push   %rbx
    82f3:	50                   	push   %rax
    82f4:	48 89 f3             	mov    %rsi,%rbx
    82f7:	49 89 fe             	mov    %rdi,%r14
    82fa:	48 89 f7             	mov    %rsi,%rdi
    82fd:	e8 6e ae ff ff       	call   3170 <strlen@plt>
    8302:	4c 89 f7             	mov    %r14,%rdi
    8305:	48 89 de             	mov    %rbx,%rsi
    8308:	48 89 c2             	mov    %rax,%rdx
    830b:	48 83 c4 08          	add    $0x8,%rsp
    830f:	5b                   	pop    %rbx
    8310:	41 5e                	pop    %r14
    8312:	eb 0c                	jmp    8320 <buf_put>
    8314:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    831b:	00 00 00 00 00 

0000000000008320 <buf_put>:
    8320:	41 57                	push   %r15
    8322:	41 56                	push   %r14
    8324:	53                   	push   %rbx
    8325:	48 89 d3             	mov    %rdx,%rbx
    8328:	49 89 f6             	mov    %rsi,%r14
    832b:	49 89 ff             	mov    %rdi,%r15
    832e:	48 89 d6             	mov    %rdx,%rsi
    8331:	e8 6a 00 00 00       	call   83a0 <buf_grow>
    8336:	49 8b 3f             	mov    (%r15),%rdi
    8339:	49 03 7f 08          	add    0x8(%r15),%rdi
    833d:	4c 89 f6             	mov    %r14,%rsi
    8340:	48 89 da             	mov    %rbx,%rdx
    8343:	e8 e8 af ff ff       	call   3330 <memcpy@plt>
    8348:	49 03 5f 08          	add    0x8(%r15),%rbx
    834c:	49 89 5f 08          	mov    %rbx,0x8(%r15)
    8350:	49 8b 07             	mov    (%r15),%rax
    8353:	c6 04 18 00          	movb   $0x0,(%rax,%rbx,1)
    8357:	5b                   	pop    %rbx
    8358:	41 5e                	pop    %r14
    835a:	41 5f                	pop    %r15
    835c:	c3                   	ret
    835d:	0f 1f 00             	nopl   (%rax)

0000000000008360 <buf_to_str>:
    8360:	41 56                	push   %r14
    8362:	53                   	push   %rbx
    8363:	50                   	push   %rax
    8364:	48 89 fb             	mov    %rdi,%rbx
    8367:	48 8b 07             	mov    (%rdi),%rax
    836a:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    836e:	48 85 c0             	test   %rax,%rax
    8371:	48 8d 3d 69 6b 00 00 	lea    0x6b69(%rip),%rdi        # eee1 <exec_in_fp0+0x7e1>
    8378:	48 0f 45 f8          	cmovne %rax,%rdi
    837c:	e8 0f ff ff ff       	call   8290 <fwp_str_new>
    8381:	49 89 c6             	mov    %rax,%r14
    8384:	48 8b 3b             	mov    (%rbx),%rdi
    8387:	e8 c4 ac ff ff       	call   3050 <free@plt>
    838c:	4c 89 f0             	mov    %r14,%rax
    838f:	48 83 c4 08          	add    $0x8,%rsp
    8393:	5b                   	pop    %rbx
    8394:	41 5e                	pop    %r14
    8396:	c3                   	ret
    8397:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    839e:	00 00 

00000000000083a0 <buf_grow>:
    83a0:	41 56                	push   %r14
    83a2:	53                   	push   %rbx
    83a3:	50                   	push   %rax
    83a4:	48 8b 47 08          	mov    0x8(%rdi),%rax
    83a8:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    83ac:	74 73                	je     8421 <buf_grow+0x81>
    83ae:	48 c7 c1 fe ff ff ff 	mov    $0xfffffffffffffffe,%rcx
    83b5:	48 29 c1             	sub    %rax,%rcx
    83b8:	48 39 f1             	cmp    %rsi,%rcx
    83bb:	72 64                	jb     8421 <buf_grow+0x81>
    83bd:	48 89 fb             	mov    %rdi,%rbx
    83c0:	48 01 f0             	add    %rsi,%rax
    83c3:	48 ff c0             	inc    %rax
    83c6:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    83ca:	48 39 c8             	cmp    %rcx,%rax
    83cd:	76 4a                	jbe    8419 <buf_grow+0x79>
    83cf:	48 85 c9             	test   %rcx,%rcx
    83d2:	41 be 40 00 00 00    	mov    $0x40,%r14d
    83d8:	4c 0f 45 f1          	cmovne %rcx,%r14
    83dc:	49 39 c6             	cmp    %rax,%r14
    83df:	73 21                	jae    8402 <buf_grow+0x62>
    83e1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    83e8:	0f 1f 84 00 00 00 00 
    83ef:	00 
    83f0:	4d 85 f6             	test   %r14,%r14
    83f3:	78 0a                	js     83ff <buf_grow+0x5f>
    83f5:	4d 01 f6             	add    %r14,%r14
    83f8:	49 39 c6             	cmp    %rax,%r14
    83fb:	72 f3                	jb     83f0 <buf_grow+0x50>
    83fd:	eb 03                	jmp    8402 <buf_grow+0x62>
    83ff:	49 89 c6             	mov    %rax,%r14
    8402:	48 8b 3b             	mov    (%rbx),%rdi
    8405:	4c 89 f6             	mov    %r14,%rsi
    8408:	e8 73 af ff ff       	call   3380 <realloc@plt>
    840d:	48 85 c0             	test   %rax,%rax
    8410:	74 0f                	je     8421 <buf_grow+0x81>
    8412:	48 89 03             	mov    %rax,(%rbx)
    8415:	4c 89 73 10          	mov    %r14,0x10(%rbx)
    8419:	48 83 c4 08          	add    $0x8,%rsp
    841d:	5b                   	pop    %rbx
    841e:	41 5e                	pop    %r14
    8420:	c3                   	ret
    8421:	48 8b 05 b0 bb 00 00 	mov    0xbbb0(%rip),%rax        # 13fd8 <stderr@GLIBC_2.2.5>
    8428:	48 8b 08             	mov    (%rax),%rcx
    842b:	48 8d 3d a1 64 00 00 	lea    0x64a1(%rip),%rdi        # e8d3 <exec_in_fp0+0x1d3>
    8432:	be 13 00 00 00       	mov    $0x13,%esi
    8437:	ba 01 00 00 00       	mov    $0x1,%edx
    843c:	e8 5f b0 ff ff       	call   34a0 <fwrite@plt>
    8441:	bf 66 00 00 00       	mov    $0x66,%edi
    8446:	e8 35 b0 ff ff       	call   3480 <exit@plt>
    844b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000008450 <fwp_is_number_arg>:
    8450:	31 c0                	xor    %eax,%eax
    8452:	80 3f 2d             	cmpb   $0x2d,(%rdi)
    8455:	75 19                	jne    8470 <fwp_is_number_arg+0x20>
    8457:	0f b6 4f 01          	movzbl 0x1(%rdi),%ecx
    845b:	8d 51 d0             	lea    -0x30(%rcx),%edx
    845e:	b8 01 00 00 00       	mov    $0x1,%eax
    8463:	80 fa 0a             	cmp    $0xa,%dl
    8466:	72 08                	jb     8470 <fwp_is_number_arg+0x20>
    8468:	31 c0                	xor    %eax,%eax
    846a:	80 f9 2e             	cmp    $0x2e,%cl
    846d:	0f 94 c0             	sete   %al
    8470:	c3                   	ret
    8471:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8478:	0f 1f 84 00 00 00 00 
    847f:	00 

0000000000008480 <fwp_strf>:
    8480:	55                   	push   %rbp
    8481:	41 57                	push   %r15
    8483:	41 56                	push   %r14
    8485:	41 55                	push   %r13
    8487:	41 54                	push   %r12
    8489:	53                   	push   %rbx
    848a:	48 81 ec d8 00 00 00 	sub    $0xd8,%rsp
    8491:	48 89 fb             	mov    %rdi,%rbx
    8494:	48 89 74 24 28       	mov    %rsi,0x28(%rsp)
    8499:	48 89 54 24 30       	mov    %rdx,0x30(%rsp)
    849e:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
    84a3:	4c 89 44 24 40       	mov    %r8,0x40(%rsp)
    84a8:	4c 89 4c 24 48       	mov    %r9,0x48(%rsp)
    84ad:	84 c0                	test   %al,%al
    84af:	74 37                	je     84e8 <fwp_strf+0x68>
    84b1:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
    84b6:	0f 29 4c 24 60       	movaps %xmm1,0x60(%rsp)
    84bb:	0f 29 54 24 70       	movaps %xmm2,0x70(%rsp)
    84c0:	0f 29 9c 24 80 00 00 	movaps %xmm3,0x80(%rsp)
    84c7:	00 
    84c8:	0f 29 a4 24 90 00 00 	movaps %xmm4,0x90(%rsp)
    84cf:	00 
    84d0:	0f 29 ac 24 a0 00 00 	movaps %xmm5,0xa0(%rsp)
    84d7:	00 
    84d8:	0f 29 b4 24 b0 00 00 	movaps %xmm6,0xb0(%rsp)
    84df:	00 
    84e0:	0f 29 bc 24 c0 00 00 	movaps %xmm7,0xc0(%rsp)
    84e7:	00 
    84e8:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    84ed:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    84f2:	48 8d 84 24 10 01 00 	lea    0x110(%rsp),%rax
    84f9:	00 
    84fa:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    84ff:	48 bd 08 00 00 00 30 	movabs $0x3000000008,%rbp
    8506:	00 00 00 
    8509:	48 89 2c 24          	mov    %rbp,(%rsp)
    850d:	49 89 e6             	mov    %rsp,%r14
    8510:	31 ff                	xor    %edi,%edi
    8512:	31 f6                	xor    %esi,%esi
    8514:	48 89 da             	mov    %rbx,%rdx
    8517:	4c 89 f1             	mov    %r14,%rcx
    851a:	e8 f1 ab ff ff       	call   3110 <vsnprintf@plt>
    851f:	4c 63 f8             	movslq %eax,%r15
    8522:	4d 8d 67 01          	lea    0x1(%r15),%r12
    8526:	4c 89 e7             	mov    %r12,%rdi
    8529:	e8 c2 e9 ff ff       	call   6ef0 <fwp_alloc_leaf>
    852e:	49 89 c5             	mov    %rax,%r13
    8531:	48 89 2c 24          	mov    %rbp,(%rsp)
    8535:	48 8d 84 24 10 01 00 	lea    0x110(%rsp),%rax
    853c:	00 
    853d:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    8542:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    8547:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    854c:	4c 89 ef             	mov    %r13,%rdi
    854f:	4c 89 e6             	mov    %r12,%rsi
    8552:	48 89 da             	mov    %rbx,%rdx
    8555:	4c 89 f1             	mov    %r14,%rcx
    8558:	e8 b3 ab ff ff       	call   3110 <vsnprintf@plt>
    855d:	4c 89 ef             	mov    %r13,%rdi
    8560:	4c 89 fe             	mov    %r15,%rsi
    8563:	e8 28 fd ff ff       	call   8290 <fwp_str_new>
    8568:	48 81 c4 d8 00 00 00 	add    $0xd8,%rsp
    856f:	5b                   	pop    %rbx
    8570:	41 5c                	pop    %r12
    8572:	41 5d                	pop    %r13
    8574:	41 5e                	pop    %r14
    8576:	41 5f                	pop    %r15
    8578:	5d                   	pop    %rbp
    8579:	c3                   	ret
    857a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000008580 <fwp_cli_value>:
    8580:	55                   	push   %rbp
    8581:	41 57                	push   %r15
    8583:	41 56                	push   %r14
    8585:	41 55                	push   %r13
    8587:	41 54                	push   %r12
    8589:	53                   	push   %rbx
    858a:	48 83 ec 58          	sub    $0x58,%rsp
    858e:	49 89 cf             	mov    %rcx,%r15
    8591:	48 89 d3             	mov    %rdx,%rbx
    8594:	49 89 f6             	mov    %rsi,%r14
    8597:	49 89 fc             	mov    %rdi,%r12
    859a:	e8 91 01 00 00       	call   8730 <fwp_is_enum>
    859f:	85 c0                	test   %eax,%eax
    85a1:	0f 84 ef 00 00 00    	je     8696 <fwp_cli_value+0x116>
    85a7:	48 89 5c 24 38       	mov    %rbx,0x38(%rsp)
    85ac:	0f 57 c0             	xorps  %xmm0,%xmm0
    85af:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    85b4:	48 c7 44 24 50 00 00 	movq   $0x0,0x50(%rsp)
    85bb:	00 00 
    85bd:	0f 29 04 24          	movaps %xmm0,(%rsp)
    85c1:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    85c8:	00 00 
    85ca:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
    85cf:	4c 89 e6             	mov    %r12,%rsi
    85d2:	4c 89 74 24 30       	mov    %r14,0x30(%rsp)
    85d7:	4c 89 f2             	mov    %r14,%rdx
    85da:	e8 d1 01 00 00       	call   87b0 <fwp_loose>
    85df:	4c 8b 6c 24 40       	mov    0x40(%rsp),%r13
    85e4:	31 db                	xor    %ebx,%ebx
    85e6:	83 3d 4b d7 00 00 00 	cmpl   $0x0,0xd74b(%rip)        # 15d38 <d0+0x10>
    85ed:	41 be ff ff ff ff    	mov    $0xffffffff,%r14d
    85f3:	7e 7a                	jle    866f <fwp_cli_value+0xef>
    85f5:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
    85fa:	48 85 ed             	test   %rbp,%rbp
    85fd:	74 70                	je     866f <fwp_cli_value+0xef>
    85ff:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
    8604:	4c 89 7c 24 28       	mov    %r15,0x28(%rsp)
    8609:	45 31 ff             	xor    %r15d,%r15d
    860c:	48 89 e3             	mov    %rsp,%rbx
    860f:	90                   	nop
    8610:	48 8b 05 29 d7 00 00 	mov    0xd729(%rip),%rax        # 15d40 <d0+0x18>
    8617:	4e 8b 24 f8          	mov    (%rax,%r15,8),%r12
    861b:	4c 89 e7             	mov    %r12,%rdi
    861e:	e8 4d ab ff ff       	call   3170 <strlen@plt>
    8623:	48 89 df             	mov    %rbx,%rdi
    8626:	4c 89 e6             	mov    %r12,%rsi
    8629:	48 89 c2             	mov    %rax,%rdx
    862c:	e8 7f 01 00 00       	call   87b0 <fwp_loose>
    8631:	48 39 6c 24 08       	cmp    %rbp,0x8(%rsp)
    8636:	75 15                	jne    864d <fwp_cli_value+0xcd>
    8638:	48 8b 3c 24          	mov    (%rsp),%rdi
    863c:	4c 89 ee             	mov    %r13,%rsi
    863f:	48 89 ea             	mov    %rbp,%rdx
    8642:	e8 29 ad ff ff       	call   3370 <bcmp@plt>
    8647:	85 c0                	test   %eax,%eax
    8649:	45 0f 44 f7          	cmove  %r15d,%r14d
    864d:	49 ff c7             	inc    %r15
    8650:	48 63 05 e1 d6 00 00 	movslq 0xd6e1(%rip),%rax        # 15d38 <d0+0x10>
    8657:	49 39 c7             	cmp    %rax,%r15
    865a:	7d 05                	jge    8661 <fwp_cli_value+0xe1>
    865c:	45 85 f6             	test   %r14d,%r14d
    865f:	78 af                	js     8610 <fwp_cli_value+0x90>
    8661:	48 8b 1c 24          	mov    (%rsp),%rbx
    8665:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
    866a:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
    866f:	4c 89 ef             	mov    %r13,%rdi
    8672:	e8 d9 a9 ff ff       	call   3050 <free@plt>
    8677:	48 89 df             	mov    %rbx,%rdi
    867a:	e8 d1 a9 ff ff       	call   3050 <free@plt>
    867f:	45 85 f6             	test   %r14d,%r14d
    8682:	78 3e                	js     86c2 <fwp_cli_value+0x142>
    8684:	44 89 f0             	mov    %r14d,%eax
    8687:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
    868c:	48 89 01             	mov    %rax,(%rcx)
    868f:	bb 01 00 00 00       	mov    $0x1,%ebx
    8694:	eb 50                	jmp    86e6 <fwp_cli_value+0x166>
    8696:	4c 89 e7             	mov    %r12,%rdi
    8699:	4c 89 f6             	mov    %r14,%rsi
    869c:	48 89 da             	mov    %rbx,%rdx
    869f:	e8 fc e9 ff ff       	call   70a0 <fwp_parse_text>
    86a4:	bb 01 00 00 00       	mov    $0x1,%ebx
    86a9:	85 c0                	test   %eax,%eax
    86ab:	75 39                	jne    86e6 <fwp_cli_value+0x166>
    86ad:	48 8d 3d c2 6c 00 00 	lea    0x6cc2(%rip),%rdi        # f376 <exec_in_fp0+0xc76>
    86b4:	48 8d 0d 02 6f 00 00 	lea    0x6f02(%rip),%rcx        # f5bd <exec_in_fp0+0xebd>
    86bb:	31 db                	xor    %ebx,%ebx
    86bd:	44 89 f6             	mov    %r14d,%esi
    86c0:	eb 17                	jmp    86d9 <fwp_cli_value+0x159>
    86c2:	e8 69 01 00 00       	call   8830 <fwp_choices>
    86c7:	48 8d 48 08          	lea    0x8(%rax),%rcx
    86cb:	48 8d 3d 8c 6c 00 00 	lea    0x6c8c(%rip),%rdi        # f35e <exec_in_fp0+0xc5e>
    86d2:	31 db                	xor    %ebx,%ebx
    86d4:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    86d9:	4c 89 e2             	mov    %r12,%rdx
    86dc:	31 c0                	xor    %eax,%eax
    86de:	e8 9d fd ff ff       	call   8480 <fwp_strf>
    86e3:	49 89 07             	mov    %rax,(%r15)
    86e6:	89 d8                	mov    %ebx,%eax
    86e8:	48 83 c4 58          	add    $0x58,%rsp
    86ec:	5b                   	pop    %rbx
    86ed:	41 5c                	pop    %r12
    86ef:	41 5d                	pop    %r13
    86f1:	41 5e                	pop    %r14
    86f3:	41 5f                	pop    %r15
    86f5:	5d                   	pop    %rbp
    86f6:	c3                   	ret
    86f7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    86fe:	00 00 

0000000000008700 <fwp_cons>:
    8700:	48 83 ec 18          	sub    $0x18,%rsp
    8704:	48 89 3c 24          	mov    %rdi,(%rsp)
    8708:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    870d:	48 89 e2             	mov    %rsp,%rdx
    8710:	bf 01 00 00 00       	mov    $0x1,%edi
    8715:	be 02 00 00 00       	mov    $0x2,%esi
    871a:	e8 b1 bb ff ff       	call   42d0 <fwp_data>
    871f:	48 83 c4 18          	add    $0x18,%rsp
    8723:	c3                   	ret
    8724:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    872b:	00 00 00 00 00 

0000000000008730 <fwp_is_enum>:
    8730:	31 c0                	xor    %eax,%eax
    8732:	83 3d ef d5 00 00 0e 	cmpl   $0xe,0xd5ef(%rip)        # 15d28 <d0>
    8739:	75 67                	jne    87a2 <fwp_is_enum+0x72>
    873b:	53                   	push   %rbx
    873c:	8b 1d f6 d5 00 00    	mov    0xd5f6(%rip),%ebx        # 15d38 <d0+0x10>
    8742:	85 db                	test   %ebx,%ebx
    8744:	74 5b                	je     87a1 <fwp_is_enum+0x71>
    8746:	48 8b 3d e3 d5 00 00 	mov    0xd5e3(%rip),%rdi        # 15d30 <d0+0x8>
    874d:	48 85 ff             	test   %rdi,%rdi
    8750:	74 14                	je     8766 <fwp_is_enum+0x36>
    8752:	48 8d 35 37 6c 00 00 	lea    0x6c37(%rip),%rsi        # f390 <exec_in_fp0+0xc90>
    8759:	e8 72 ab ff ff       	call   32d0 <strcmp@plt>
    875e:	89 c1                	mov    %eax,%ecx
    8760:	31 c0                	xor    %eax,%eax
    8762:	85 c9                	test   %ecx,%ecx
    8764:	74 3b                	je     87a1 <fwp_is_enum+0x71>
    8766:	85 db                	test   %ebx,%ebx
    8768:	7e 32                	jle    879c <fwp_is_enum+0x6c>
    876a:	48 8b 0d df d5 00 00 	mov    0xd5df(%rip),%rcx        # 15d50 <d0+0x28>
    8771:	83 39 00             	cmpl   $0x0,(%rcx)
    8774:	75 2b                	jne    87a1 <fwp_is_enum+0x71>
    8776:	b8 01 00 00 00       	mov    $0x1,%eax
    877b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8780:	48 89 c2             	mov    %rax,%rdx
    8783:	48 39 c3             	cmp    %rax,%rbx
    8786:	74 0a                	je     8792 <fwp_is_enum+0x62>
    8788:	48 8d 42 01          	lea    0x1(%rdx),%rax
    878c:	83 3c 91 00          	cmpl   $0x0,(%rcx,%rdx,4)
    8790:	74 ee                	je     8780 <fwp_is_enum+0x50>
    8792:	31 c0                	xor    %eax,%eax
    8794:	48 39 da             	cmp    %rbx,%rdx
    8797:	0f 93 c0             	setae  %al
    879a:	eb 05                	jmp    87a1 <fwp_is_enum+0x71>
    879c:	b8 01 00 00 00       	mov    $0x1,%eax
    87a1:	5b                   	pop    %rbx
    87a2:	c3                   	ret
    87a3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    87aa:	84 00 00 00 00 00 

00000000000087b0 <fwp_loose>:
    87b0:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
    87b7:	00 
    87b8:	48 85 d2             	test   %rdx,%rdx
    87bb:	74 63                	je     8820 <fwp_loose+0x70>
    87bd:	41 57                	push   %r15
    87bf:	41 56                	push   %r14
    87c1:	41 54                	push   %r12
    87c3:	53                   	push   %rbx
    87c4:	50                   	push   %rax
    87c5:	48 89 d3             	mov    %rdx,%rbx
    87c8:	49 89 f6             	mov    %rsi,%r14
    87cb:	49 89 ff             	mov    %rdi,%r15
    87ce:	45 31 e4             	xor    %r12d,%r12d
    87d1:	eb 15                	jmp    87e8 <fwp_loose+0x38>
    87d3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    87da:	84 00 00 00 00 00 
    87e0:	49 ff c4             	inc    %r12
    87e3:	4c 39 e3             	cmp    %r12,%rbx
    87e6:	74 2d                	je     8815 <fwp_loose+0x65>
    87e8:	43 0f b6 04 26       	movzbl (%r14,%r12,1),%eax
    87ed:	83 f8 2d             	cmp    $0x2d,%eax
    87f0:	74 ee                	je     87e0 <fwp_loose+0x30>
    87f2:	83 f8 5f             	cmp    $0x5f,%eax
    87f5:	74 e9                	je     87e0 <fwp_loose+0x30>
    87f7:	8d 48 bf             	lea    -0x41(%rax),%ecx
    87fa:	0f b6 d0             	movzbl %al,%edx
    87fd:	0c 20                	or     $0x20,%al
    87ff:	80 f9 1a             	cmp    $0x1a,%cl
    8802:	0f b6 c0             	movzbl %al,%eax
    8805:	0f 43 c2             	cmovae %edx,%eax
    8808:	0f be f0             	movsbl %al,%esi
    880b:	4c 89 ff             	mov    %r15,%rdi
    880e:	e8 bd fa ff ff       	call   82d0 <buf_putc>
    8813:	eb cb                	jmp    87e0 <fwp_loose+0x30>
    8815:	48 83 c4 08          	add    $0x8,%rsp
    8819:	5b                   	pop    %rbx
    881a:	41 5c                	pop    %r12
    881c:	41 5e                	pop    %r14
    881e:	41 5f                	pop    %r15
    8820:	c3                   	ret
    8821:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8828:	0f 1f 84 00 00 00 00 
    882f:	00 

0000000000008830 <fwp_choices>:
    8830:	41 57                	push   %r15
    8832:	41 56                	push   %r14
    8834:	53                   	push   %rbx
    8835:	48 83 ec 20          	sub    $0x20,%rsp
    8839:	0f 57 c0             	xorps  %xmm0,%xmm0
    883c:	0f 29 04 24          	movaps %xmm0,(%rsp)
    8840:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    8847:	00 00 
    8849:	83 3d e8 d4 00 00 00 	cmpl   $0x0,0xd4e8(%rip)        # 15d38 <d0+0x10>
    8850:	7e 5b                	jle    88ad <fwp_choices+0x7d>
    8852:	48 8b 05 e7 d4 00 00 	mov    0xd4e7(%rip),%rax        # 15d40 <d0+0x18>
    8859:	48 8b 30             	mov    (%rax),%rsi
    885c:	48 89 e7             	mov    %rsp,%rdi
    885f:	e8 5c 00 00 00       	call   88c0 <fwp_kebab>
    8864:	83 3d cd d4 00 00 02 	cmpl   $0x2,0xd4cd(%rip)        # 15d38 <d0+0x10>
    886b:	7c 40                	jl     88ad <fwp_choices+0x7d>
    886d:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    8873:	48 8d 1d 1b 6b 00 00 	lea    0x6b1b(%rip),%rbx        # f395 <exec_in_fp0+0xc95>
    887a:	49 89 e6             	mov    %rsp,%r14
    887d:	0f 1f 00             	nopl   (%rax)
    8880:	4c 89 f7             	mov    %r14,%rdi
    8883:	48 89 de             	mov    %rbx,%rsi
    8886:	e8 65 fa ff ff       	call   82f0 <buf_puts>
    888b:	48 8b 05 ae d4 00 00 	mov    0xd4ae(%rip),%rax        # 15d40 <d0+0x18>
    8892:	4a 8b 34 f8          	mov    (%rax,%r15,8),%rsi
    8896:	4c 89 f7             	mov    %r14,%rdi
    8899:	e8 22 00 00 00       	call   88c0 <fwp_kebab>
    889e:	49 ff c7             	inc    %r15
    88a1:	48 63 05 90 d4 00 00 	movslq 0xd490(%rip),%rax        # 15d38 <d0+0x10>
    88a8:	49 39 c7             	cmp    %rax,%r15
    88ab:	7c d3                	jl     8880 <fwp_choices+0x50>
    88ad:	48 89 e7             	mov    %rsp,%rdi
    88b0:	e8 ab fa ff ff       	call   8360 <buf_to_str>
    88b5:	48 83 c4 20          	add    $0x20,%rsp
    88b9:	5b                   	pop    %rbx
    88ba:	41 5e                	pop    %r14
    88bc:	41 5f                	pop    %r15
    88be:	c3                   	ret
    88bf:	90                   	nop

00000000000088c0 <fwp_kebab>:
    88c0:	41 57                	push   %r15
    88c2:	41 56                	push   %r14
    88c4:	53                   	push   %rbx
    88c5:	44 0f b6 3e          	movzbl (%rsi),%r15d
    88c9:	45 84 ff             	test   %r15b,%r15b
    88cc:	74 71                	je     893f <fwp_kebab+0x7f>
    88ce:	48 89 f3             	mov    %rsi,%rbx
    88d1:	49 89 fe             	mov    %rdi,%r14
    88d4:	48 ff c3             	inc    %rbx
    88d7:	31 c0                	xor    %eax,%eax
    88d9:	eb 36                	jmp    8911 <fwp_kebab+0x51>
    88db:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    88e0:	41 0f be f7          	movsbl %r15b,%esi
    88e4:	4c 89 f7             	mov    %r14,%rdi
    88e7:	e8 e4 f9 ff ff       	call   82d0 <buf_putc>
    88ec:	41 8d 47 9f          	lea    -0x61(%r15),%eax
    88f0:	3c 1a                	cmp    $0x1a,%al
    88f2:	0f 92 c0             	setb   %al
    88f5:	41 80 c7 d0          	add    $0xd0,%r15b
    88f9:	41 80 ff 0a          	cmp    $0xa,%r15b
    88fd:	0f 92 c1             	setb   %cl
    8900:	08 c1                	or     %al,%cl
    8902:	0f b6 c1             	movzbl %cl,%eax
    8905:	44 0f b6 3b          	movzbl (%rbx),%r15d
    8909:	48 ff c3             	inc    %rbx
    890c:	45 84 ff             	test   %r15b,%r15b
    890f:	74 2e                	je     893f <fwp_kebab+0x7f>
    8911:	41 8d 4f bf          	lea    -0x41(%r15),%ecx
    8915:	80 f9 19             	cmp    $0x19,%cl
    8918:	77 c6                	ja     88e0 <fwp_kebab+0x20>
    891a:	85 c0                	test   %eax,%eax
    891c:	74 0d                	je     892b <fwp_kebab+0x6b>
    891e:	4c 89 f7             	mov    %r14,%rdi
    8921:	be 2d 00 00 00       	mov    $0x2d,%esi
    8926:	e8 a5 f9 ff ff       	call   82d0 <buf_putc>
    892b:	41 80 cf 20          	or     $0x20,%r15b
    892f:	41 0f be f7          	movsbl %r15b,%esi
    8933:	4c 89 f7             	mov    %r14,%rdi
    8936:	e8 95 f9 ff ff       	call   82d0 <buf_putc>
    893b:	31 c0                	xor    %eax,%eax
    893d:	eb c6                	jmp    8905 <fwp_kebab+0x45>
    893f:	5b                   	pop    %rbx
    8940:	41 5e                	pop    %r14
    8942:	41 5f                	pop    %r15
    8944:	c3                   	ret
    8945:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    894c:	00 00 00 00 

0000000000008950 <tp_value>:
    8950:	55                   	push   %rbp
    8951:	41 57                	push   %r15
    8953:	41 56                	push   %r14
    8955:	41 55                	push   %r13
    8957:	41 54                	push   %r12
    8959:	53                   	push   %rbx
    895a:	48 81 ec a8 01 00 00 	sub    $0x1a8,%rsp
    8961:	48 89 cd             	mov    %rcx,%rbp
    8964:	49 89 f6             	mov    %rsi,%r14
    8967:	49 89 ff             	mov    %rdi,%r15
    896a:	85 d2                	test   %edx,%edx
    896c:	74 4c                	je     89ba <tp_value+0x6a>
    896e:	41 83 3e 0c          	cmpl   $0xc,(%r14)
    8972:	75 46                	jne    89ba <tp_value+0x6a>
    8974:	4d 8b 77 08          	mov    0x8(%r15),%r14
    8978:	49 8b 47 10          	mov    0x10(%r15),%rax
    897c:	4d 8b 27             	mov    (%r15),%r12
    897f:	49 01 c4             	add    %rax,%r12
    8982:	49 29 c6             	sub    %rax,%r14
    8985:	4c 89 e7             	mov    %r12,%rdi
    8988:	4c 89 f6             	mov    %r14,%rsi
    898b:	e8 a0 f7 ff ff       	call   8130 <fwp_valid_utf8>
    8990:	85 c0                	test   %eax,%eax
    8992:	0f 84 e9 07 00 00    	je     9181 <tp_value+0x831>
    8998:	4c 89 e7             	mov    %r12,%rdi
    899b:	4c 89 f6             	mov    %r14,%rsi
    899e:	e8 ed f8 ff ff       	call   8290 <fwp_str_new>
    89a3:	48 89 45 00          	mov    %rax,0x0(%rbp)
    89a7:	49 8b 47 08          	mov    0x8(%r15),%rax
    89ab:	49 89 47 10          	mov    %rax,0x10(%r15)
    89af:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    89b5:	e9 ca 07 00 00       	jmp    9184 <tp_value+0x834>
    89ba:	41 89 d5             	mov    %edx,%r13d
    89bd:	4c 89 ff             	mov    %r15,%rdi
    89c0:	e8 bb 08 00 00       	call   9280 <tp_ws>
    89c5:	41 8b 06             	mov    (%r14),%eax
    89c8:	45 31 e4             	xor    %r12d,%r12d
    89cb:	48 83 f8 15          	cmp    $0x15,%rax
    89cf:	0f 87 af 07 00 00    	ja     9184 <tp_value+0x834>
    89d5:	48 8d 0d fc 57 00 00 	lea    0x57fc(%rip),%rcx        # e1d8 <_IO_stdin_used+0x1d8>
    89dc:	48 63 14 81          	movslq (%rcx,%rax,4),%rdx
    89e0:	48 01 ca             	add    %rcx,%rdx
    89e3:	ff e2                	jmp    *%rdx
    89e5:	4c 89 ff             	mov    %r15,%rdi
    89e8:	4c 89 f6             	mov    %r14,%rsi
    89eb:	48 89 ea             	mov    %rbp,%rdx
    89ee:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    89f5:	5b                   	pop    %rbx
    89f6:	41 5c                	pop    %r12
    89f8:	41 5d                	pop    %r13
    89fa:	41 5e                	pop    %r14
    89fc:	41 5f                	pop    %r15
    89fe:	5d                   	pop    %rbp
    89ff:	e9 cc 08 00 00       	jmp    92d0 <tp_int>
    8a04:	41 0f 10 46 38       	movups 0x38(%r14),%xmm0
    8a09:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    8a0e:	31 c9                	xor    %ecx,%ecx
    8a10:	83 f8 13             	cmp    $0x13,%eax
    8a13:	0f 94 c1             	sete   %cl
    8a16:	0f 57 c0             	xorps  %xmm0,%xmm0
    8a19:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    8a1e:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    8a25:	00 00 
    8a27:	89 4c 24 48          	mov    %ecx,0x48(%rsp)
    8a2b:	48 8d 05 78 69 00 00 	lea    0x6978(%rip),%rax        # f3aa <exec_in_fp0+0xcaa>
    8a32:	48 8d 35 75 69 00 00 	lea    0x6975(%rip),%rsi        # f3ae <exec_in_fp0+0xcae>
    8a39:	48 0f 44 f0          	cmove  %rax,%rsi
    8a3d:	4c 89 ff             	mov    %r15,%rdi
    8a40:	e8 fb 0b 00 00       	call   9640 <tp_eat>
    8a45:	45 31 e4             	xor    %r12d,%r12d
    8a48:	85 c0                	test   %eax,%eax
    8a4a:	0f 84 34 07 00 00    	je     9184 <tp_value+0x834>
    8a50:	48 8d 35 28 6a 00 00 	lea    0x6a28(%rip),%rsi        # f47f <exec_in_fp0+0xd7f>
    8a57:	48 8d 15 87 5d 00 00 	lea    0x5d87(%rip),%rdx        # e7e5 <exec_in_fp0+0xe5>
    8a5e:	48 8d 0d 7b 0e 00 00 	lea    0xe7b(%rip),%rcx        # 98e0 <tp_kv_item>
    8a65:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
    8a6a:	4c 89 ff             	mov    %r15,%rdi
    8a6d:	e8 2e 0c 00 00       	call   96a0 <tp_list_of>
    8a72:	85 c0                	test   %eax,%eax
    8a74:	0f 84 a1 03 00 00    	je     8e1b <tp_value+0x4cb>
    8a7a:	48 83 7c 24 38 00    	cmpq   $0x0,0x38(%rsp)
    8a80:	0f 84 2b 05 00 00    	je     8fb1 <tp_value+0x661>
    8a86:	48 8d 05 a3 d9 01 00 	lea    0x1d9a3(%rip),%rax        # 26430 <fwp_empty_map>
    8a8d:	31 db                	xor    %ebx,%ebx
    8a8f:	90                   	nop
    8a90:	48 8b 4c 24 30       	mov    0x30(%rsp),%rcx
    8a95:	48 8b 3c d9          	mov    (%rcx,%rbx,8),%rdi
    8a99:	48 8b 74 d9 08       	mov    0x8(%rcx,%rbx,8),%rsi
    8a9e:	49 8b 4e 38          	mov    0x38(%r14),%rcx
    8aa2:	48 89 c2             	mov    %rax,%rdx
    8aa5:	e8 d6 0e 00 00       	call   9980 <fwp_p_map_insert>
    8aaa:	48 83 c3 02          	add    $0x2,%rbx
    8aae:	48 3b 5c 24 38       	cmp    0x38(%rsp),%rbx
    8ab3:	72 db                	jb     8a90 <tp_value+0x140>
    8ab5:	e9 fe 04 00 00       	jmp    8fb8 <tp_value+0x668>
    8aba:	0f 57 c0             	xorps  %xmm0,%xmm0
    8abd:	0f 11 44 24 38       	movups %xmm0,0x38(%rsp)
    8ac2:	0f 11 44 24 28       	movups %xmm0,0x28(%rsp)
    8ac7:	48 c7 44 24 48 00 00 	movq   $0x0,0x48(%rsp)
    8ace:	00 00 
    8ad0:	49 8b 4e 38          	mov    0x38(%r14),%rcx
    8ad4:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
    8ad9:	83 f8 11             	cmp    $0x11,%eax
    8adc:	75 17                	jne    8af5 <tp_value+0x1a5>
    8ade:	48 8d 35 bf 68 00 00 	lea    0x68bf(%rip),%rsi        # f3a4 <exec_in_fp0+0xca4>
    8ae5:	4c 89 ff             	mov    %r15,%rdi
    8ae8:	e8 53 0b 00 00       	call   9640 <tp_eat>
    8aed:	85 c0                	test   %eax,%eax
    8aef:	0f 84 8c 06 00 00    	je     9181 <tp_value+0x831>
    8af5:	48 8d 35 86 5c 00 00 	lea    0x5c86(%rip),%rsi        # e782 <exec_in_fp0+0x82>
    8afc:	48 8d 15 29 5d 00 00 	lea    0x5d29(%rip),%rdx        # e82c <exec_in_fp0+0x12c>
    8b03:	48 8d 0d e6 0c 00 00 	lea    0xce6(%rip),%rcx        # 97f0 <tp_elem_item>
    8b0a:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
    8b0f:	4c 89 ff             	mov    %r15,%rdi
    8b12:	e8 89 0b 00 00       	call   96a0 <tp_list_of>
    8b17:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    8b1c:	85 c0                	test   %eax,%eax
    8b1e:	0f 84 06 03 00 00    	je     8e2a <tp_value+0x4da>
    8b24:	48 8b 74 24 38       	mov    0x38(%rsp),%rsi
    8b29:	e8 62 f3 ff ff       	call   7e90 <fwp_list_from>
    8b2e:	49 89 c7             	mov    %rax,%r15
    8b31:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    8b36:	e8 95 f3 ff ff       	call   7ed0 <fwp_mem_free>
    8b3b:	41 83 3e 11          	cmpl   $0x11,(%r14)
    8b3f:	75 0b                	jne    8b4c <tp_value+0x1fc>
    8b41:	4c 89 ff             	mov    %r15,%rdi
    8b44:	e8 e7 0c 00 00       	call   9830 <fwp_p_array_from_list>
    8b49:	49 89 c7             	mov    %rax,%r15
    8b4c:	4c 89 7d 00          	mov    %r15,0x0(%rbp)
    8b50:	e9 5a fe ff ff       	jmp    89af <tp_value+0x5f>
    8b55:	4c 89 ff             	mov    %r15,%rdi
    8b58:	4c 89 f6             	mov    %r14,%rsi
    8b5b:	48 89 ea             	mov    %rbp,%rdx
    8b5e:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    8b65:	5b                   	pop    %rbx
    8b66:	41 5c                	pop    %r12
    8b68:	41 5d                	pop    %r13
    8b6a:	41 5e                	pop    %r14
    8b6c:	41 5f                	pop    %r15
    8b6e:	5d                   	pop    %rbp
    8b6f:	e9 bc 07 00 00       	jmp    9330 <tp_float>
    8b74:	45 85 ed             	test   %r13d,%r13d
    8b77:	0f 85 f7 fd ff ff    	jne    8974 <tp_value+0x24>
    8b7d:	4c 89 ff             	mov    %r15,%rdi
    8b80:	48 89 ee             	mov    %rbp,%rsi
    8b83:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    8b8a:	5b                   	pop    %rbx
    8b8b:	41 5c                	pop    %r12
    8b8d:	41 5d                	pop    %r13
    8b8f:	41 5e                	pop    %r14
    8b91:	41 5f                	pop    %r15
    8b93:	5d                   	pop    %rbp
    8b94:	e9 57 08 00 00       	jmp    93f0 <tp_quoted>
    8b99:	0f 57 c0             	xorps  %xmm0,%xmm0
    8b9c:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    8ba1:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    8ba6:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    8bab:	48 8d 35 e6 67 00 00 	lea    0x67e6(%rip),%rsi        # f398 <exec_in_fp0+0xc98>
    8bb2:	4c 89 ff             	mov    %r15,%rdi
    8bb5:	e8 86 0a 00 00       	call   9640 <tp_eat>
    8bba:	45 31 e4             	xor    %r12d,%r12d
    8bbd:	85 c0                	test   %eax,%eax
    8bbf:	0f 84 6f 02 00 00    	je     8e34 <tp_value+0x4e4>
    8bc5:	48 8d 35 b6 5b 00 00 	lea    0x5bb6(%rip),%rsi        # e782 <exec_in_fp0+0x82>
    8bcc:	48 8d 15 59 5c 00 00 	lea    0x5c59(%rip),%rdx        # e82c <exec_in_fp0+0x12c>
    8bd3:	48 8d 0d 46 0b 00 00 	lea    0xb46(%rip),%rcx        # 9720 <tp_byte_item>
    8bda:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
    8bdf:	4c 89 ff             	mov    %r15,%rdi
    8be2:	e8 b9 0a 00 00       	call   96a0 <tp_list_of>
    8be7:	85 c0                	test   %eax,%eax
    8be9:	0f 84 2c 02 00 00    	je     8e1b <tp_value+0x4cb>
    8bef:	0f 57 c0             	xorps  %xmm0,%xmm0
    8bf2:	0f 29 84 24 20 01 00 	movaps %xmm0,0x120(%rsp)
    8bf9:	00 
    8bfa:	48 c7 84 24 30 01 00 	movq   $0x0,0x130(%rsp)
    8c01:	00 00 00 00 00 
    8c06:	48 83 7c 24 38 00    	cmpq   $0x0,0x38(%rsp)
    8c0c:	74 2d                	je     8c3b <tp_value+0x2eb>
    8c0e:	31 db                	xor    %ebx,%ebx
    8c10:	4c 8d b4 24 20 01 00 	lea    0x120(%rsp),%r14
    8c17:	00 
    8c18:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    8c1f:	00 
    8c20:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    8c25:	0f be 34 d8          	movsbl (%rax,%rbx,8),%esi
    8c29:	4c 89 f7             	mov    %r14,%rdi
    8c2c:	e8 9f f6 ff ff       	call   82d0 <buf_putc>
    8c31:	48 ff c3             	inc    %rbx
    8c34:	48 3b 5c 24 38       	cmp    0x38(%rsp),%rbx
    8c39:	72 e5                	jb     8c20 <tp_value+0x2d0>
    8c3b:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    8c40:	e8 8b f2 ff ff       	call   7ed0 <fwp_mem_free>
    8c45:	48 8d bc 24 20 01 00 	lea    0x120(%rsp),%rdi
    8c4c:	00 
    8c4d:	e8 0e f7 ff ff       	call   8360 <buf_to_str>
    8c52:	48 89 45 00          	mov    %rax,0x0(%rbp)
    8c56:	e9 54 fd ff ff       	jmp    89af <tp_value+0x5f>
    8c5b:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8c60:	ba 00 01 00 00       	mov    $0x100,%edx
    8c65:	4c 89 ff             	mov    %r15,%rdi
    8c68:	e8 f3 0a 00 00       	call   9760 <tp_token>
    8c6d:	45 31 e4             	xor    %r12d,%r12d
    8c70:	48 83 f8 02          	cmp    $0x2,%rax
    8c74:	0f 82 0a 05 00 00    	jb     9184 <tp_value+0x834>
    8c7a:	80 7c 24 20 30       	cmpb   $0x30,0x20(%rsp)
    8c7f:	0f 85 ff 04 00 00    	jne    9184 <tp_value+0x834>
    8c85:	80 7c 24 21 74       	cmpb   $0x74,0x21(%rsp)
    8c8a:	0f 85 f4 04 00 00    	jne    9184 <tp_value+0x834>
    8c90:	48 8d 48 fe          	lea    -0x2(%rax),%rcx
    8c94:	49 63 56 48          	movslq 0x48(%r14),%rdx
    8c98:	48 39 d1             	cmp    %rdx,%rcx
    8c9b:	0f 87 e3 04 00 00    	ja     9184 <tp_value+0x834>
    8ca1:	48 83 f8 03          	cmp    $0x3,%rax
    8ca5:	0f 82 21 05 00 00    	jb     91cc <tp_value+0x87c>
    8cab:	ba 02 00 00 00       	mov    $0x2,%edx
    8cb0:	31 c9                	xor    %ecx,%ecx
    8cb2:	e9 3d 01 00 00       	jmp    8df4 <tp_value+0x4a4>
    8cb7:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8cbc:	ba 10 00 00 00       	mov    $0x10,%edx
    8cc1:	4c 89 ff             	mov    %r15,%rdi
    8cc4:	e8 97 0a 00 00       	call   9760 <tp_token>
    8cc9:	8b 44 24 20          	mov    0x20(%rsp),%eax
    8ccd:	89 c1                	mov    %eax,%ecx
    8ccf:	81 f1 2b 31 00 00    	xor    $0x312b,%ecx
    8cd5:	0f b6 54 24 22       	movzbl 0x22(%rsp),%edx
    8cda:	66 09 ca             	or     %cx,%dx
    8cdd:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    8ce3:	74 2d                	je     8d12 <tp_value+0x3c2>
    8ce5:	66 83 f8 31          	cmp    $0x31,%ax
    8ce9:	74 27                	je     8d12 <tp_value+0x3c2>
    8ceb:	45 31 e4             	xor    %r12d,%r12d
    8cee:	66 83 f8 30          	cmp    $0x30,%ax
    8cf2:	74 1e                	je     8d12 <tp_value+0x3c2>
    8cf4:	b8 2d 31 00 00       	mov    $0x312d,%eax
    8cf9:	33 44 24 20          	xor    0x20(%rsp),%eax
    8cfd:	0f b6 4c 24 22       	movzbl 0x22(%rsp),%ecx
    8d02:	66 09 c1             	or     %ax,%cx
    8d05:	0f 85 79 04 00 00    	jne    9184 <tp_value+0x834>
    8d0b:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    8d12:	4c 89 65 00          	mov    %r12,0x0(%rbp)
    8d16:	e9 94 fc ff ff       	jmp    89af <tp_value+0x5f>
    8d1b:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    8d1f:	48 85 ff             	test   %rdi,%rdi
    8d22:	0f 84 18 01 00 00    	je     8e40 <tp_value+0x4f0>
    8d28:	48 8d 35 83 66 00 00 	lea    0x6683(%rip),%rsi        # f3b2 <exec_in_fp0+0xcb2>
    8d2f:	e8 9c a5 ff ff       	call   32d0 <strcmp@plt>
    8d34:	85 c0                	test   %eax,%eax
    8d36:	0f 84 23 03 00 00    	je     905f <tp_value+0x70f>
    8d3c:	4c 89 ff             	mov    %r15,%rdi
    8d3f:	e8 3c 05 00 00       	call   9280 <tp_ws>
    8d44:	4d 8b 6e 08          	mov    0x8(%r14),%r13
    8d48:	4c 89 ef             	mov    %r13,%rdi
    8d4b:	e8 20 a4 ff ff       	call   3170 <strlen@plt>
    8d50:	49 89 c4             	mov    %rax,%r12
    8d53:	49 8b 47 08          	mov    0x8(%r15),%rax
    8d57:	49 8b 5f 10          	mov    0x10(%r15),%rbx
    8d5b:	48 29 d8             	sub    %rbx,%rax
    8d5e:	4c 39 e0             	cmp    %r12,%rax
    8d61:	0f 82 c4 01 00 00    	jb     8f2b <tp_value+0x5db>
    8d67:	49 8b 3f             	mov    (%r15),%rdi
    8d6a:	48 01 df             	add    %rbx,%rdi
    8d6d:	4c 89 ee             	mov    %r13,%rsi
    8d70:	4c 89 e2             	mov    %r12,%rdx
    8d73:	e8 f8 a5 ff ff       	call   3370 <bcmp@plt>
    8d78:	85 c0                	test   %eax,%eax
    8d7a:	0f 85 ab 01 00 00    	jne    8f2b <tp_value+0x5db>
    8d80:	4c 01 e3             	add    %r12,%rbx
    8d83:	49 89 5f 10          	mov    %rbx,0x10(%r15)
    8d87:	e9 9f 01 00 00       	jmp    8f2b <tp_value+0x5db>
    8d8c:	48 89 2c 24          	mov    %rbp,(%rsp)
    8d90:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8d95:	4c 89 ff             	mov    %r15,%rdi
    8d98:	e8 d3 0e 00 00       	call   9c70 <tp_ident>
    8d9d:	41 8b 5e 10          	mov    0x10(%r14),%ebx
    8da1:	85 db                	test   %ebx,%ebx
    8da3:	4c 89 74 24 08       	mov    %r14,0x8(%rsp)
    8da8:	0f 8e 9c 01 00 00    	jle    8f4a <tp_value+0x5fa>
    8dae:	4d 8b 66 18          	mov    0x18(%r14),%r12
    8db2:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    8db7:	45 31 f6             	xor    %r14d,%r14d
    8dba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8dc0:	4b 8b 3c f4          	mov    (%r12,%r14,8),%rdi
    8dc4:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8dc9:	e8 02 a5 ff ff       	call   32d0 <strcmp@plt>
    8dce:	85 c0                	test   %eax,%eax
    8dd0:	41 0f 44 ee          	cmove  %r14d,%ebp
    8dd4:	49 ff c6             	inc    %r14
    8dd7:	4c 39 f3             	cmp    %r14,%rbx
    8dda:	75 e4                	jne    8dc0 <tp_value+0x470>
    8ddc:	e9 6e 01 00 00       	jmp    8f4f <tp_value+0x5ff>
    8de1:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    8de5:	48 ff c9             	dec    %rcx
    8de8:	48 ff c2             	inc    %rdx
    8deb:	48 39 d0             	cmp    %rdx,%rax
    8dee:	0f 84 da 03 00 00    	je     91ce <tp_value+0x87e>
    8df4:	0f b6 74 14 20       	movzbl 0x20(%rsp,%rdx,1),%esi
    8df9:	83 fe 30             	cmp    $0x30,%esi
    8dfc:	74 17                	je     8e15 <tp_value+0x4c5>
    8dfe:	83 fe 2d             	cmp    $0x2d,%esi
    8e01:	74 de                	je     8de1 <tp_value+0x491>
    8e03:	83 fe 2b             	cmp    $0x2b,%esi
    8e06:	0f 85 75 03 00 00    	jne    9181 <tp_value+0x831>
    8e0c:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    8e10:	48 ff c1             	inc    %rcx
    8e13:	eb d3                	jmp    8de8 <tp_value+0x498>
    8e15:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    8e19:	eb cd                	jmp    8de8 <tp_value+0x498>
    8e1b:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    8e20:	e8 ab f0 ff ff       	call   7ed0 <fwp_mem_free>
    8e25:	e9 5a 03 00 00       	jmp    9184 <tp_value+0x834>
    8e2a:	e8 a1 f0 ff ff       	call   7ed0 <fwp_mem_free>
    8e2f:	e9 4d 03 00 00       	jmp    9181 <tp_value+0x831>
    8e34:	31 ff                	xor    %edi,%edi
    8e36:	e8 95 f0 ff ff       	call   7ed0 <fwp_mem_free>
    8e3b:	e9 44 03 00 00       	jmp    9184 <tp_value+0x834>
    8e40:	49 63 7e 10          	movslq 0x10(%r14),%rdi
    8e44:	48 85 ff             	test   %rdi,%rdi
    8e47:	0f 84 4c 03 00 00    	je     9199 <tp_value+0x849>
    8e4d:	41 83 7e 48 00       	cmpl   $0x0,0x48(%r14)
    8e52:	0f 84 d3 00 00 00    	je     8f2b <tp_value+0x5db>
    8e58:	48 c1 e7 03          	shl    $0x3,%rdi
    8e5c:	e8 2f d4 ff ff       	call   6290 <fwp_alloc>
    8e61:	48 89 c3             	mov    %rax,%rbx
    8e64:	48 8d 35 57 65 00 00 	lea    0x6557(%rip),%rsi        # f3c2 <exec_in_fp0+0xcc2>
    8e6b:	4c 89 ff             	mov    %r15,%rdi
    8e6e:	e8 cd 07 00 00       	call   9640 <tp_eat>
    8e73:	85 c0                	test   %eax,%eax
    8e75:	0f 84 09 03 00 00    	je     9184 <tp_value+0x834>
    8e7b:	48 89 2c 24          	mov    %rbp,(%rsp)
    8e7f:	41 83 7e 10 00       	cmpl   $0x0,0x10(%r14)
    8e84:	7e 77                	jle    8efd <tp_value+0x5ad>
    8e86:	49 8b 46 20          	mov    0x20(%r14),%rax
    8e8a:	48 8b 30             	mov    (%rax),%rsi
    8e8d:	4c 89 ff             	mov    %r15,%rdi
    8e90:	31 d2                	xor    %edx,%edx
    8e92:	48 89 d9             	mov    %rbx,%rcx
    8e95:	e8 b6 fa ff ff       	call   8950 <tp_value>
    8e9a:	85 c0                	test   %eax,%eax
    8e9c:	0f 84 df 02 00 00    	je     9181 <tp_value+0x831>
    8ea2:	41 83 7e 10 02       	cmpl   $0x2,0x10(%r14)
    8ea7:	7c 54                	jl     8efd <tp_value+0x5ad>
    8ea9:	48 89 dd             	mov    %rbx,%rbp
    8eac:	48 83 c5 08          	add    $0x8,%rbp
    8eb0:	41 bd 01 00 00 00    	mov    $0x1,%r13d
    8eb6:	4c 89 ff             	mov    %r15,%rdi
    8eb9:	48 8d 35 22 59 00 00 	lea    0x5922(%rip),%rsi        # e7e2 <exec_in_fp0+0xe2>
    8ec0:	e8 7b 07 00 00       	call   9640 <tp_eat>
    8ec5:	85 c0                	test   %eax,%eax
    8ec7:	0f 84 b4 02 00 00    	je     9181 <tp_value+0x831>
    8ecd:	49 8b 46 20          	mov    0x20(%r14),%rax
    8ed1:	4a 8b 34 e8          	mov    (%rax,%r13,8),%rsi
    8ed5:	45 31 e4             	xor    %r12d,%r12d
    8ed8:	4c 89 ff             	mov    %r15,%rdi
    8edb:	31 d2                	xor    %edx,%edx
    8edd:	48 89 e9             	mov    %rbp,%rcx
    8ee0:	e8 6b fa ff ff       	call   8950 <tp_value>
    8ee5:	85 c0                	test   %eax,%eax
    8ee7:	0f 84 97 02 00 00    	je     9184 <tp_value+0x834>
    8eed:	49 ff c5             	inc    %r13
    8ef0:	49 63 46 10          	movslq 0x10(%r14),%rax
    8ef4:	48 83 c5 08          	add    $0x8,%rbp
    8ef8:	49 39 c5             	cmp    %rax,%r13
    8efb:	7c b9                	jl     8eb6 <tp_value+0x566>
    8efd:	48 8d 35 7e 65 00 00 	lea    0x657e(%rip),%rsi        # f482 <exec_in_fp0+0xd82>
    8f04:	4c 89 ff             	mov    %r15,%rdi
    8f07:	e8 34 07 00 00       	call   9640 <tp_eat>
    8f0c:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    8f12:	85 c0                	test   %eax,%eax
    8f14:	0f 84 6a 02 00 00    	je     9184 <tp_value+0x834>
    8f1a:	41 8b 7e 10          	mov    0x10(%r14),%edi
    8f1e:	48 89 de             	mov    %rbx,%rsi
    8f21:	e8 3a b3 ff ff       	call   4260 <fwp_record>
    8f26:	e9 28 01 00 00       	jmp    9053 <tp_value+0x703>
    8f2b:	4c 89 ff             	mov    %r15,%rdi
    8f2e:	4c 89 f6             	mov    %r14,%rsi
    8f31:	48 89 ea             	mov    %rbp,%rdx
    8f34:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    8f3b:	5b                   	pop    %rbx
    8f3c:	41 5c                	pop    %r12
    8f3e:	41 5d                	pop    %r13
    8f40:	41 5e                	pop    %r14
    8f42:	41 5f                	pop    %r15
    8f44:	5d                   	pop    %rbp
    8f45:	e9 56 0b 00 00       	jmp    9aa0 <tp_record_body>
    8f4a:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    8f4f:	45 85 ed             	test   %r13d,%r13d
    8f52:	74 7a                	je     8fce <tp_value+0x67e>
    8f54:	85 ed                	test   %ebp,%ebp
    8f56:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    8f5b:	79 76                	jns    8fd3 <tp_value+0x683>
    8f5d:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    8f61:	45 31 e4             	xor    %r12d,%r12d
    8f64:	48 85 ff             	test   %rdi,%rdi
    8f67:	0f 84 17 02 00 00    	je     9184 <tp_value+0x834>
    8f6d:	48 8d 35 1c 64 00 00 	lea    0x641c(%rip),%rsi        # f390 <exec_in_fp0+0xc90>
    8f74:	e8 57 a3 ff ff       	call   32d0 <strcmp@plt>
    8f79:	85 c0                	test   %eax,%eax
    8f7b:	0f 85 03 02 00 00    	jne    9184 <tp_value+0x834>
    8f81:	8b 44 24 20          	mov    0x20(%rsp),%eax
    8f85:	89 c1                	mov    %eax,%ecx
    8f87:	81 f1 74 72 75 65    	xor    $0x65757274,%ecx
    8f8d:	0f b6 54 24 24       	movzbl 0x24(%rsp),%edx
    8f92:	09 ca                	or     %ecx,%edx
    8f94:	b9 01 00 00 00       	mov    $0x1,%ecx
    8f99:	0f 44 e9             	cmove  %ecx,%ebp
    8f9c:	35 66 61 6c 73       	xor    $0x736c6166,%eax
    8fa1:	0f b7 4c 24 24       	movzwl 0x24(%rsp),%ecx
    8fa6:	83 f1 65             	xor    $0x65,%ecx
    8fa9:	09 c1                	or     %eax,%ecx
    8fab:	75 26                	jne    8fd3 <tp_value+0x683>
    8fad:	31 ed                	xor    %ebp,%ebp
    8faf:	eb 2a                	jmp    8fdb <tp_value+0x68b>
    8fb1:	48 8d 05 78 d4 01 00 	lea    0x1d478(%rip),%rax        # 26430 <fwp_empty_map>
    8fb8:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    8fbd:	48 89 c3             	mov    %rax,%rbx
    8fc0:	e8 0b ef ff ff       	call   7ed0 <fwp_mem_free>
    8fc5:	48 89 5d 00          	mov    %rbx,0x0(%rbp)
    8fc9:	e9 e1 f9 ff ff       	jmp    89af <tp_value+0x5f>
    8fce:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    8fd3:	85 ed                	test   %ebp,%ebp
    8fd5:	0f 88 a6 01 00 00    	js     9181 <tp_value+0x831>
    8fdb:	48 8b 43 28          	mov    0x28(%rbx),%rax
    8fdf:	41 89 ed             	mov    %ebp,%r13d
    8fe2:	4a 63 1c a8          	movslq (%rax,%r13,4),%rbx
    8fe6:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    8fed:	00 
    8fee:	e8 9d d2 ff ff       	call   6290 <fwp_alloc>
    8ff3:	48 89 c5             	mov    %rax,%rbp
    8ff6:	89 d8                	mov    %ebx,%eax
    8ff8:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    8ffd:	48 85 db             	test   %rbx,%rbx
    9000:	7e 41                	jle    9043 <tp_value+0x6f3>
    9002:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    9007:	48 8d 1c c5 00 00 00 	lea    0x0(,%rax,8),%rbx
    900e:	00 
    900f:	45 31 e4             	xor    %r12d,%r12d
    9012:	45 31 f6             	xor    %r14d,%r14d
    9015:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    901a:	48 8b 40 30          	mov    0x30(%rax),%rax
    901e:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    9022:	4a 8b 34 30          	mov    (%rax,%r14,1),%rsi
    9026:	49 8d 14 2e          	lea    (%r14,%rbp,1),%rdx
    902a:	4c 89 ff             	mov    %r15,%rdi
    902d:	e8 fe 0c 00 00       	call   9d30 <tp_atom>
    9032:	85 c0                	test   %eax,%eax
    9034:	0f 84 4a 01 00 00    	je     9184 <tp_value+0x834>
    903a:	49 83 c6 08          	add    $0x8,%r14
    903e:	4c 39 f3             	cmp    %r14,%rbx
    9041:	75 d2                	jne    9015 <tp_value+0x6c5>
    9043:	44 89 ef             	mov    %r13d,%edi
    9046:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    904b:	48 89 ea             	mov    %rbp,%rdx
    904e:	e8 7d b2 ff ff       	call   42d0 <fwp_data>
    9053:	48 8b 0c 24          	mov    (%rsp),%rcx
    9057:	48 89 01             	mov    %rax,(%rcx)
    905a:	e9 50 f9 ff ff       	jmp    89af <tp_value+0x5f>
    905f:	48 89 2c 24          	mov    %rbp,(%rsp)
    9063:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    9068:	ba 80 00 00 00       	mov    $0x80,%edx
    906d:	4c 89 ff             	mov    %r15,%rdi
    9070:	48 89 f3             	mov    %rsi,%rbx
    9073:	e8 e8 06 00 00       	call   9760 <tp_token>
    9078:	49 89 c7             	mov    %rax,%r15
    907b:	4c 8d 24 04          	lea    (%rsp,%rax,1),%r12
    907f:	49 83 c4 20          	add    $0x20,%r12
    9083:	41 be 08 00 00 00    	mov    $0x8,%r14d
    9089:	eb 0e                	jmp    9099 <tp_value+0x749>
    908b:	49 83 c6 10          	add    $0x10,%r14
    908f:	49 83 fe 68          	cmp    $0x68,%r14
    9093:	0f 84 e8 00 00 00    	je     9181 <tp_value+0x831>
    9099:	48 8d 05 80 ab 00 00 	lea    0xab80(%rip),%rax        # 13c20 <tp_value.units>
    90a0:	49 8b 6c 06 f8       	mov    -0x8(%r14,%rax,1),%rbp
    90a5:	48 89 ef             	mov    %rbp,%rdi
    90a8:	e8 c3 a0 ff ff       	call   3170 <strlen@plt>
    90ad:	4d 89 fd             	mov    %r15,%r13
    90b0:	49 29 c5             	sub    %rax,%r13
    90b3:	76 d6                	jbe    908b <tp_value+0x73b>
    90b5:	4c 89 e7             	mov    %r12,%rdi
    90b8:	48 29 c7             	sub    %rax,%rdi
    90bb:	48 89 ee             	mov    %rbp,%rsi
    90be:	e8 0d a2 ff ff       	call   32d0 <strcmp@plt>
    90c3:	85 c0                	test   %eax,%eax
    90c5:	75 c4                	jne    908b <tp_value+0x73b>
    90c7:	48 8d ac 24 20 01 00 	lea    0x120(%rsp),%rbp
    90ce:	00 
    90cf:	48 89 ef             	mov    %rbp,%rdi
    90d2:	48 89 de             	mov    %rbx,%rsi
    90d5:	4c 89 ea             	mov    %r13,%rdx
    90d8:	e8 53 a2 ff ff       	call   3330 <memcpy@plt>
    90dd:	42 c6 84 2c 20 01 00 	movb   $0x0,0x120(%rsp,%r13,1)
    90e4:	00 00 
    90e6:	48 89 ef             	mov    %rbp,%rdi
    90e9:	4c 89 ee             	mov    %r13,%rsi
    90ec:	e8 6f 09 00 00       	call   9a60 <fwp_valid_int>
    90f1:	85 c0                	test   %eax,%eax
    90f3:	74 96                	je     908b <tp_value+0x73b>
    90f5:	0f b6 b4 24 20 01 00 	movzbl 0x120(%rsp),%esi
    90fc:	00 
    90fd:	8d 4e d5             	lea    -0x2b(%rsi),%ecx
    9100:	31 c0                	xor    %eax,%eax
    9102:	f6 c1 fd             	test   $0xfd,%cl
    9105:	0f 94 c0             	sete   %al
    9108:	44 0f b6 94 04 20 01 	movzbl 0x120(%rsp,%rax,1),%r10d
    910f:	00 00 
    9111:	45 31 e4             	xor    %r12d,%r12d
    9114:	45 84 d2             	test   %r10b,%r10b
    9117:	0f 84 ba 00 00 00    	je     91d7 <tp_value+0x887>
    911d:	48 8d 8c 24 20 01 00 	lea    0x120(%rsp),%rcx
    9124:	00 
    9125:	48 01 c1             	add    %rax,%rcx
    9128:	48 ff c1             	inc    %rcx
    912b:	31 c0                	xor    %eax,%eax
    912d:	bf 0a 00 00 00       	mov    $0xa,%edi
    9132:	49 b9 00 00 00 00 00 	movabs $0x8000000000000000,%r9
    9139:	00 00 80 
    913c:	45 31 c0             	xor    %r8d,%r8d
    913f:	48 8b 1c 24          	mov    (%rsp),%rbx
    9143:	48 f7 e7             	mul    %rdi
    9146:	4f 8d 04 80          	lea    (%r8,%r8,4),%r8
    914a:	4a 8d 14 42          	lea    (%rdx,%r8,2),%rdx
    914e:	45 0f be c2          	movsbl %r10b,%r8d
    9152:	41 83 c0 d0          	add    $0xffffffd0,%r8d
    9156:	4d 63 d0             	movslq %r8d,%r10
    9159:	4d 89 d0             	mov    %r10,%r8
    915c:	49 c1 f8 3f          	sar    $0x3f,%r8
    9160:	4c 01 d0             	add    %r10,%rax
    9163:	49 11 d0             	adc    %rdx,%r8
    9166:	49 39 c1             	cmp    %rax,%r9
    9169:	ba 00 00 00 00       	mov    $0x0,%edx
    916e:	4c 19 c2             	sbb    %r8,%rdx
    9171:	7c 0e                	jl     9181 <tp_value+0x831>
    9173:	44 0f b6 11          	movzbl (%rcx),%r10d
    9177:	48 ff c1             	inc    %rcx
    917a:	45 84 d2             	test   %r10b,%r10b
    917d:	75 c4                	jne    9143 <tp_value+0x7f3>
    917f:	eb 5f                	jmp    91e0 <tp_value+0x890>
    9181:	45 31 e4             	xor    %r12d,%r12d
    9184:	44 89 e0             	mov    %r12d,%eax
    9187:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    918e:	5b                   	pop    %rbx
    918f:	41 5c                	pop    %r12
    9191:	41 5d                	pop    %r13
    9193:	41 5e                	pop    %r14
    9195:	41 5f                	pop    %r15
    9197:	5d                   	pop    %rbp
    9198:	c3                   	ret
    9199:	48 8d 35 22 62 00 00 	lea    0x6222(%rip),%rsi        # f3c2 <exec_in_fp0+0xcc2>
    91a0:	4c 89 ff             	mov    %r15,%rdi
    91a3:	e8 98 04 00 00       	call   9640 <tp_eat>
    91a8:	85 c0                	test   %eax,%eax
    91aa:	74 d8                	je     9184 <tp_value+0x834>
    91ac:	48 8d 35 cf 62 00 00 	lea    0x62cf(%rip),%rsi        # f482 <exec_in_fp0+0xd82>
    91b3:	4c 89 ff             	mov    %r15,%rdi
    91b6:	e8 85 04 00 00       	call   9640 <tp_eat>
    91bb:	85 c0                	test   %eax,%eax
    91bd:	74 c5                	je     9184 <tp_value+0x834>
    91bf:	48 c7 45 00 00 00 00 	movq   $0x0,0x0(%rbp)
    91c6:	00 
    91c7:	e9 e3 f7 ff ff       	jmp    89af <tp_value+0x5f>
    91cc:	31 c9                	xor    %ecx,%ecx
    91ce:	48 89 4d 00          	mov    %rcx,0x0(%rbp)
    91d2:	e9 d8 f7 ff ff       	jmp    89af <tp_value+0x5f>
    91d7:	31 c0                	xor    %eax,%eax
    91d9:	45 31 c0             	xor    %r8d,%r8d
    91dc:	48 8b 1c 24          	mov    (%rsp),%rbx
    91e0:	48 89 c1             	mov    %rax,%rcx
    91e3:	48 f7 d9             	neg    %rcx
    91e6:	bf 00 00 00 00       	mov    $0x0,%edi
    91eb:	4c 19 c7             	sbb    %r8,%rdi
    91ee:	40 80 fe 2d          	cmp    $0x2d,%sil
    91f2:	49 0f 45 f8          	cmovne %r8,%rdi
    91f6:	48 0f 45 c8          	cmovne %rax,%rcx
    91fa:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    9201:	ff ff 7f 
    9204:	48 39 c8             	cmp    %rcx,%rax
    9207:	b8 00 00 00 00       	mov    $0x0,%eax
    920c:	48 19 f8             	sbb    %rdi,%rax
    920f:	0f 8c 6f ff ff ff    	jl     9184 <tp_value+0x834>
    9215:	48 8d 05 04 aa 00 00 	lea    0xaa04(%rip),%rax        # 13c20 <tp_value.units>
    921c:	49 8b 34 06          	mov    (%r14,%rax,1),%rsi
    9220:	48 89 c8             	mov    %rcx,%rax
    9223:	48 f7 e6             	mul    %rsi
    9226:	48 0f af fe          	imul   %rsi,%rdi
    922a:	48 c1 fe 3f          	sar    $0x3f,%rsi
    922e:	48 0f af f1          	imul   %rcx,%rsi
    9232:	48 01 d6             	add    %rdx,%rsi
    9235:	48 01 f7             	add    %rsi,%rdi
    9238:	48 b9 00 00 00 00 00 	movabs $0x8000000000000000,%rcx
    923f:	00 00 80 
    9242:	48 01 c1             	add    %rax,%rcx
    9245:	48 83 d7 ff          	adc    $0xffffffffffffffff,%rdi
    9249:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
    924d:	0f 85 31 ff ff ff    	jne    9184 <tp_value+0x834>
    9253:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    9258:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    925e:	48 8d 74 24 18       	lea    0x18(%rsp),%rsi
    9263:	bf 01 00 00 00       	mov    $0x1,%edi
    9268:	e8 f3 af ff ff       	call   4260 <fwp_record>
    926d:	48 89 03             	mov    %rax,(%rbx)
    9270:	e9 0f ff ff ff       	jmp    9184 <tp_value+0x834>
    9275:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    927c:	00 00 00 00 

0000000000009280 <tp_ws>:
    9280:	48 8b 47 08          	mov    0x8(%rdi),%rax
    9284:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    9288:	48 39 c1             	cmp    %rax,%rcx
    928b:	73 39                	jae    92c6 <tp_ws+0x46>
    928d:	48 8b 17             	mov    (%rdi),%rdx
    9290:	48 f7 d8             	neg    %rax
    9293:	48 ff c1             	inc    %rcx
    9296:	48 be 00 26 00 00 01 	movabs $0x100002600,%rsi
    929d:	00 00 00 
    92a0:	44 0f b6 44 0a ff    	movzbl -0x1(%rdx,%rcx,1),%r8d
    92a6:	49 83 f8 20          	cmp    $0x20,%r8
    92aa:	77 1a                	ja     92c6 <tp_ws+0x46>
    92ac:	4c 0f a3 c6          	bt     %r8,%rsi
    92b0:	73 14                	jae    92c6 <tp_ws+0x46>
    92b2:	48 89 4f 10          	mov    %rcx,0x10(%rdi)
    92b6:	4c 8d 04 08          	lea    (%rax,%rcx,1),%r8
    92ba:	49 ff c0             	inc    %r8
    92bd:	48 ff c1             	inc    %rcx
    92c0:	49 83 f8 01          	cmp    $0x1,%r8
    92c4:	75 da                	jne    92a0 <tp_ws+0x20>
    92c6:	c3                   	ret
    92c7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    92ce:	00 00 

00000000000092d0 <tp_int>:
    92d0:	55                   	push   %rbp
    92d1:	41 56                	push   %r14
    92d3:	53                   	push   %rbx
    92d4:	48 81 ec 80 00 00 00 	sub    $0x80,%rsp
    92db:	48 89 d3             	mov    %rdx,%rbx
    92de:	49 89 f6             	mov    %rsi,%r14
    92e1:	48 89 e6             	mov    %rsp,%rsi
    92e4:	ba 80 00 00 00       	mov    $0x80,%edx
    92e9:	e8 72 04 00 00       	call   9760 <tp_token>
    92ee:	31 ed                	xor    %ebp,%ebp
    92f0:	48 83 f8 7f          	cmp    $0x7f,%rax
    92f4:	77 28                	ja     931e <tp_int+0x4e>
    92f6:	48 89 e7             	mov    %rsp,%rdi
    92f9:	e8 d2 0a 00 00       	call   9dd0 <fwp_cstr>
    92fe:	41 8b 36             	mov    (%r14),%esi
    9301:	41 8b 56 48          	mov    0x48(%r14),%edx
    9305:	48 89 c7             	mov    %rax,%rdi
    9308:	e8 e3 0a 00 00       	call   9df0 <fwp_p_parse_int>
    930d:	48 85 c0             	test   %rax,%rax
    9310:	74 0c                	je     931e <tp_int+0x4e>
    9312:	48 8b 40 08          	mov    0x8(%rax),%rax
    9316:	48 89 03             	mov    %rax,(%rbx)
    9319:	bd 01 00 00 00       	mov    $0x1,%ebp
    931e:	89 e8                	mov    %ebp,%eax
    9320:	48 81 c4 80 00 00 00 	add    $0x80,%rsp
    9327:	5b                   	pop    %rbx
    9328:	41 5e                	pop    %r14
    932a:	5d                   	pop    %rbp
    932b:	c3                   	ret
    932c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000009330 <tp_float>:
    9330:	41 56                	push   %r14
    9332:	53                   	push   %rbx
    9333:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    933a:	48 89 d3             	mov    %rdx,%rbx
    933d:	49 89 f6             	mov    %rsi,%r14
    9340:	48 89 e6             	mov    %rsp,%rsi
    9343:	ba 80 00 00 00       	mov    $0x80,%edx
    9348:	e8 13 04 00 00       	call   9760 <tp_token>
    934d:	31 c9                	xor    %ecx,%ecx
    934f:	48 83 f8 7f          	cmp    $0x7f,%rax
    9353:	0f 87 84 00 00 00    	ja     93dd <tp_float+0xad>
    9359:	8b 0c 24             	mov    (%rsp),%ecx
    935c:	81 f9 69 6e 66 00    	cmp    $0x666e69,%ecx
    9362:	75 0a                	jne    936e <tp_float+0x3e>
    9364:	f2 0f 10 05 f4 4d 00 	movsd  0x4df4(%rip),%xmm0        # e160 <_IO_stdin_used+0x160>
    936b:	00 
    936c:	eb 5f                	jmp    93cd <tp_float+0x9d>
    936e:	ba 2d 69 6e 66       	mov    $0x666e692d,%edx
    9373:	33 14 24             	xor    (%rsp),%edx
    9376:	0f b6 74 24 04       	movzbl 0x4(%rsp),%esi
    937b:	09 d6                	or     %edx,%esi
    937d:	74 12                	je     9391 <tp_float+0x61>
    937f:	81 f9 4e 61 4e 00    	cmp    $0x4e614e,%ecx
    9385:	75 14                	jne    939b <tp_float+0x6b>
    9387:	f2 0f 10 05 e1 4d 00 	movsd  0x4de1(%rip),%xmm0        # e170 <_IO_stdin_used+0x170>
    938e:	00 
    938f:	eb 3c                	jmp    93cd <tp_float+0x9d>
    9391:	f2 0f 10 05 cf 4d 00 	movsd  0x4dcf(%rip),%xmm0        # e168 <_IO_stdin_used+0x168>
    9398:	00 
    9399:	eb 32                	jmp    93cd <tp_float+0x9d>
    939b:	48 89 e7             	mov    %rsp,%rdi
    939e:	48 89 c6             	mov    %rax,%rsi
    93a1:	e8 7a 0e 00 00       	call   a220 <fwp_valid_float>
    93a6:	31 c9                	xor    %ecx,%ecx
    93a8:	85 c0                	test   %eax,%eax
    93aa:	74 31                	je     93dd <tp_float+0xad>
    93ac:	41 83 3e 0a          	cmpl   $0xa,(%r14)
    93b0:	75 11                	jne    93c3 <tp_float+0x93>
    93b2:	48 89 e7             	mov    %rsp,%rdi
    93b5:	31 f6                	xor    %esi,%esi
    93b7:	e8 44 9e ff ff       	call   3200 <strtof@plt>
    93bc:	e8 4f 0f 00 00       	call   a310 <fwp_from_f32>
    93c1:	eb 12                	jmp    93d5 <tp_float+0xa5>
    93c3:	48 89 e7             	mov    %rsp,%rdi
    93c6:	31 f6                	xor    %esi,%esi
    93c8:	e8 33 9d ff ff       	call   3100 <strtod@plt>
    93cd:	41 8b 3e             	mov    (%r14),%edi
    93d0:	e8 4b 0f 00 00       	call   a320 <fwp_float_of>
    93d5:	48 89 03             	mov    %rax,(%rbx)
    93d8:	b9 01 00 00 00       	mov    $0x1,%ecx
    93dd:	89 c8                	mov    %ecx,%eax
    93df:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
    93e6:	5b                   	pop    %rbx
    93e7:	41 5e                	pop    %r14
    93e9:	c3                   	ret
    93ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000093f0 <tp_quoted>:
    93f0:	55                   	push   %rbp
    93f1:	41 57                	push   %r15
    93f3:	41 56                	push   %r14
    93f5:	41 55                	push   %r13
    93f7:	41 54                	push   %r12
    93f9:	53                   	push   %rbx
    93fa:	48 83 ec 18          	sub    $0x18,%rsp
    93fe:	49 89 f6             	mov    %rsi,%r14
    9401:	49 89 ff             	mov    %rdi,%r15
    9404:	e8 77 fe ff ff       	call   9280 <tp_ws>
    9409:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    940d:	49 8b 6f 10          	mov    0x10(%r15),%rbp
    9411:	31 db                	xor    %ebx,%ebx
    9413:	4c 39 ed             	cmp    %r13,%rbp
    9416:	0f 83 0d 02 00 00    	jae    9629 <tp_quoted+0x239>
    941c:	49 8b 07             	mov    (%r15),%rax
    941f:	80 3c 28 22          	cmpb   $0x22,(%rax,%rbp,1)
    9423:	0f 85 00 02 00 00    	jne    9629 <tp_quoted+0x239>
    9429:	48 ff c5             	inc    %rbp
    942c:	49 89 6f 10          	mov    %rbp,0x10(%r15)
    9430:	0f 57 c0             	xorps  %xmm0,%xmm0
    9433:	0f 29 04 24          	movaps %xmm0,(%rsp)
    9437:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    943e:	00 00 
    9440:	31 db                	xor    %ebx,%ebx
    9442:	4c 39 ed             	cmp    %r13,%rbp
    9445:	0f 83 8d 01 00 00    	jae    95d8 <tp_quoted+0x1e8>
    944b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    9450:	4d 8b 27             	mov    (%r15),%r12
    9453:	48 8d 4d 01          	lea    0x1(%rbp),%rcx
    9457:	49 89 4f 10          	mov    %rcx,0x10(%r15)
    945b:	41 0f b6 04 2c       	movzbl (%r12,%rbp,1),%eax
    9460:	83 f8 5c             	cmp    $0x5c,%eax
    9463:	74 2b                	je     9490 <tp_quoted+0xa0>
    9465:	83 f8 22             	cmp    $0x22,%eax
    9468:	0f 84 8b 01 00 00    	je     95f9 <tp_quoted+0x209>
    946e:	0f be f0             	movsbl %al,%esi
    9471:	48 89 e7             	mov    %rsp,%rdi
    9474:	e8 57 ee ff ff       	call   82d0 <buf_putc>
    9479:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    947d:	49 8b 6f 10          	mov    0x10(%r15),%rbp
    9481:	4c 39 ed             	cmp    %r13,%rbp
    9484:	72 ca                	jb     9450 <tp_quoted+0x60>
    9486:	e9 63 01 00 00       	jmp    95ee <tp_quoted+0x1fe>
    948b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    9490:	4c 39 e9             	cmp    %r13,%rcx
    9493:	0f 83 48 01 00 00    	jae    95e1 <tp_quoted+0x1f1>
    9499:	48 8d 45 02          	lea    0x2(%rbp),%rax
    949d:	49 89 47 10          	mov    %rax,0x10(%r15)
    94a1:	41 0f b6 4c 2c 01    	movzbl 0x1(%r12,%rbp,1),%ecx
    94a7:	8d 51 a4             	lea    -0x5c(%rcx),%edx
    94aa:	83 fa 19             	cmp    $0x19,%edx
    94ad:	77 1a                	ja     94c9 <tp_quoted+0xd9>
    94af:	48 8d 35 7a 4d 00 00 	lea    0x4d7a(%rip),%rsi        # e230 <_IO_stdin_used+0x230>
    94b6:	48 63 0c 96          	movslq (%rsi,%rdx,4),%rcx
    94ba:	48 01 f1             	add    %rsi,%rcx
    94bd:	ff e1                	jmp    *%rcx
    94bf:	48 89 e7             	mov    %rsp,%rdi
    94c2:	be 5c 00 00 00       	mov    $0x5c,%esi
    94c7:	eb ab                	jmp    9474 <tp_quoted+0x84>
    94c9:	83 f9 22             	cmp    $0x22,%ecx
    94cc:	0f 84 bf 00 00 00    	je     9591 <tp_quoted+0x1a1>
    94d2:	83 f9 30             	cmp    $0x30,%ecx
    94d5:	0f 85 06 01 00 00    	jne    95e1 <tp_quoted+0x1f1>
    94db:	48 89 e7             	mov    %rsp,%rdi
    94de:	31 f6                	xor    %esi,%esi
    94e0:	eb 92                	jmp    9474 <tp_quoted+0x84>
    94e2:	48 89 e7             	mov    %rsp,%rdi
    94e5:	be 09 00 00 00       	mov    $0x9,%esi
    94ea:	eb 88                	jmp    9474 <tp_quoted+0x84>
    94ec:	48 89 e7             	mov    %rsp,%rdi
    94ef:	be 0d 00 00 00       	mov    $0xd,%esi
    94f4:	e9 7b ff ff ff       	jmp    9474 <tp_quoted+0x84>
    94f9:	48 89 e7             	mov    %rsp,%rdi
    94fc:	be 0a 00 00 00       	mov    $0xa,%esi
    9501:	e9 6e ff ff ff       	jmp    9474 <tp_quoted+0x84>
    9506:	4c 39 e8             	cmp    %r13,%rax
    9509:	0f 83 d2 00 00 00    	jae    95e1 <tp_quoted+0x1f1>
    950f:	41 80 3c 04 7b       	cmpb   $0x7b,(%r12,%rax,1)
    9514:	0f 85 c7 00 00 00    	jne    95e1 <tp_quoted+0x1f1>
    951a:	48 8d 45 03          	lea    0x3(%rbp),%rax
    951e:	49 89 47 10          	mov    %rax,0x10(%r15)
    9522:	4c 39 e8             	cmp    %r13,%rax
    9525:	0f 83 b6 00 00 00    	jae    95e1 <tp_quoted+0x1f1>
    952b:	e8 d0 9f ff ff       	call   3500 <__ctype_b_loc@plt>
    9530:	48 8b 08             	mov    (%rax),%rcx
    9533:	48 8d 55 04          	lea    0x4(%rbp),%rdx
    9537:	49 8d 3c 2c          	lea    (%r12,%rbp,1),%rdi
    953b:	48 83 c7 03          	add    $0x3,%rdi
    953f:	49 29 ed             	sub    %rbp,%r13
    9542:	49 83 c5 fd          	add    $0xfffffffffffffffd,%r13
    9546:	31 c0                	xor    %eax,%eax
    9548:	31 f6                	xor    %esi,%esi
    954a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9550:	44 0f b6 04 07       	movzbl (%rdi,%rax,1),%r8d
    9555:	42 f6 44 41 01 10    	testb  $0x10,0x1(%rcx,%r8,2)
    955b:	74 41                	je     959e <tp_quoted+0x1ae>
    955d:	4c 8d 04 02          	lea    (%rdx,%rax,1),%r8
    9561:	4d 89 47 10          	mov    %r8,0x10(%r15)
    9565:	44 0f be 04 07       	movsbl (%rdi,%rax,1),%r8d
    956a:	c1 e6 04             	shl    $0x4,%esi
    956d:	45 8d 48 d0          	lea    -0x30(%r8),%r9d
    9571:	45 89 c2             	mov    %r8d,%r10d
    9574:	41 83 ca 20          	or     $0x20,%r10d
    9578:	41 83 c2 a9          	add    $0xffffffa9,%r10d
    957c:	41 83 f8 3a          	cmp    $0x3a,%r8d
    9580:	45 0f 4c d1          	cmovl  %r9d,%r10d
    9584:	44 01 d6             	add    %r10d,%esi
    9587:	48 ff c0             	inc    %rax
    958a:	49 39 c5             	cmp    %rax,%r13
    958d:	75 c1                	jne    9550 <tp_quoted+0x160>
    958f:	eb 50                	jmp    95e1 <tp_quoted+0x1f1>
    9591:	48 89 e7             	mov    %rsp,%rdi
    9594:	be 22 00 00 00       	mov    $0x22,%esi
    9599:	e9 d6 fe ff ff       	jmp    9474 <tp_quoted+0x84>
    959e:	85 c0                	test   %eax,%eax
    95a0:	74 3f                	je     95e1 <tp_quoted+0x1f1>
    95a2:	41 80 f8 7d          	cmp    $0x7d,%r8b
    95a6:	75 39                	jne    95e1 <tp_quoted+0x1f1>
    95a8:	81 fe ff ff 10 00    	cmp    $0x10ffff,%esi
    95ae:	77 31                	ja     95e1 <tp_quoted+0x1f1>
    95b0:	89 f1                	mov    %esi,%ecx
    95b2:	81 e1 00 f8 ff ff    	and    $0xfffff800,%ecx
    95b8:	81 f9 00 d8 00 00    	cmp    $0xd800,%ecx
    95be:	74 21                	je     95e1 <tp_quoted+0x1f1>
    95c0:	48 01 e8             	add    %rbp,%rax
    95c3:	48 83 c0 04          	add    $0x4,%rax
    95c7:	49 89 47 10          	mov    %rax,0x10(%r15)
    95cb:	48 89 e7             	mov    %rsp,%rdi
    95ce:	e8 5d 0d 00 00       	call   a330 <fwp_utf8_put>
    95d3:	e9 a1 fe ff ff       	jmp    9479 <tp_quoted+0x89>
    95d8:	31 ff                	xor    %edi,%edi
    95da:	e8 71 9a ff ff       	call   3050 <free@plt>
    95df:	eb 48                	jmp    9629 <tp_quoted+0x239>
    95e1:	48 8b 3c 24          	mov    (%rsp),%rdi
    95e5:	e8 66 9a ff ff       	call   3050 <free@plt>
    95ea:	31 db                	xor    %ebx,%ebx
    95ec:	eb 3b                	jmp    9629 <tp_quoted+0x239>
    95ee:	48 8b 3c 24          	mov    (%rsp),%rdi
    95f2:	e8 59 9a ff ff       	call   3050 <free@plt>
    95f7:	eb 30                	jmp    9629 <tp_quoted+0x239>
    95f9:	48 8b 1c 24          	mov    (%rsp),%rbx
    95fd:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    9602:	48 85 db             	test   %rbx,%rbx
    9605:	48 8d 3d d5 58 00 00 	lea    0x58d5(%rip),%rdi        # eee1 <exec_in_fp0+0x7e1>
    960c:	48 0f 45 fb          	cmovne %rbx,%rdi
    9610:	e8 1b eb ff ff       	call   8130 <fwp_valid_utf8>
    9615:	85 c0                	test   %eax,%eax
    9617:	74 21                	je     963a <tp_quoted+0x24a>
    9619:	48 89 e7             	mov    %rsp,%rdi
    961c:	e8 3f ed ff ff       	call   8360 <buf_to_str>
    9621:	49 89 06             	mov    %rax,(%r14)
    9624:	bb 01 00 00 00       	mov    $0x1,%ebx
    9629:	89 d8                	mov    %ebx,%eax
    962b:	48 83 c4 18          	add    $0x18,%rsp
    962f:	5b                   	pop    %rbx
    9630:	41 5c                	pop    %r12
    9632:	41 5d                	pop    %r13
    9634:	41 5e                	pop    %r14
    9636:	41 5f                	pop    %r15
    9638:	5d                   	pop    %rbp
    9639:	c3                   	ret
    963a:	48 89 df             	mov    %rbx,%rdi
    963d:	eb a6                	jmp    95e5 <tp_quoted+0x1f5>
    963f:	90                   	nop

0000000000009640 <tp_eat>:
    9640:	55                   	push   %rbp
    9641:	41 57                	push   %r15
    9643:	41 56                	push   %r14
    9645:	53                   	push   %rbx
    9646:	50                   	push   %rax
    9647:	49 89 f6             	mov    %rsi,%r14
    964a:	48 89 fb             	mov    %rdi,%rbx
    964d:	e8 2e fc ff ff       	call   9280 <tp_ws>
    9652:	4c 89 f7             	mov    %r14,%rdi
    9655:	e8 16 9b ff ff       	call   3170 <strlen@plt>
    965a:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    965e:	4c 8b 7b 10          	mov    0x10(%rbx),%r15
    9662:	4c 29 f9             	sub    %r15,%rcx
    9665:	31 ed                	xor    %ebp,%ebp
    9667:	48 39 c1             	cmp    %rax,%rcx
    966a:	72 24                	jb     9690 <tp_eat+0x50>
    966c:	48 8b 3b             	mov    (%rbx),%rdi
    966f:	4c 01 ff             	add    %r15,%rdi
    9672:	4c 89 f6             	mov    %r14,%rsi
    9675:	49 89 c6             	mov    %rax,%r14
    9678:	48 89 c2             	mov    %rax,%rdx
    967b:	e8 f0 9c ff ff       	call   3370 <bcmp@plt>
    9680:	85 c0                	test   %eax,%eax
    9682:	75 0c                	jne    9690 <tp_eat+0x50>
    9684:	4d 01 f7             	add    %r14,%r15
    9687:	4c 89 7b 10          	mov    %r15,0x10(%rbx)
    968b:	bd 01 00 00 00       	mov    $0x1,%ebp
    9690:	89 e8                	mov    %ebp,%eax
    9692:	48 83 c4 08          	add    $0x8,%rsp
    9696:	5b                   	pop    %rbx
    9697:	41 5e                	pop    %r14
    9699:	41 5f                	pop    %r15
    969b:	5d                   	pop    %rbp
    969c:	c3                   	ret
    969d:	0f 1f 00             	nopl   (%rax)

00000000000096a0 <tp_list_of>:
    96a0:	55                   	push   %rbp
    96a1:	41 57                	push   %r15
    96a3:	41 56                	push   %r14
    96a5:	41 55                	push   %r13
    96a7:	41 54                	push   %r12
    96a9:	53                   	push   %rbx
    96aa:	50                   	push   %rax
    96ab:	4d 89 c6             	mov    %r8,%r14
    96ae:	49 89 cf             	mov    %rcx,%r15
    96b1:	49 89 d4             	mov    %rdx,%r12
    96b4:	49 89 fd             	mov    %rdi,%r13
    96b7:	e8 84 ff ff ff       	call   9640 <tp_eat>
    96bc:	31 db                	xor    %ebx,%ebx
    96be:	85 c0                	test   %eax,%eax
    96c0:	74 14                	je     96d6 <tp_list_of+0x36>
    96c2:	4c 89 ef             	mov    %r13,%rdi
    96c5:	4c 89 e6             	mov    %r12,%rsi
    96c8:	e8 73 ff ff ff       	call   9640 <tp_eat>
    96cd:	85 c0                	test   %eax,%eax
    96cf:	74 16                	je     96e7 <tp_list_of+0x47>
    96d1:	bb 01 00 00 00       	mov    $0x1,%ebx
    96d6:	89 d8                	mov    %ebx,%eax
    96d8:	48 83 c4 08          	add    $0x8,%rsp
    96dc:	5b                   	pop    %rbx
    96dd:	41 5c                	pop    %r12
    96df:	41 5d                	pop    %r13
    96e1:	41 5e                	pop    %r14
    96e3:	41 5f                	pop    %r15
    96e5:	5d                   	pop    %rbp
    96e6:	c3                   	ret
    96e7:	48 8d 2d f4 50 00 00 	lea    0x50f4(%rip),%rbp        # e7e2 <exec_in_fp0+0xe2>
    96ee:	66 90                	xchg   %ax,%ax
    96f0:	4c 89 ef             	mov    %r13,%rdi
    96f3:	4c 89 f6             	mov    %r14,%rsi
    96f6:	41 ff d7             	call   *%r15
    96f9:	85 c0                	test   %eax,%eax
    96fb:	74 d9                	je     96d6 <tp_list_of+0x36>
    96fd:	4c 89 ef             	mov    %r13,%rdi
    9700:	4c 89 e6             	mov    %r12,%rsi
    9703:	e8 38 ff ff ff       	call   9640 <tp_eat>
    9708:	85 c0                	test   %eax,%eax
    970a:	75 c5                	jne    96d1 <tp_list_of+0x31>
    970c:	4c 89 ef             	mov    %r13,%rdi
    970f:	48 89 ee             	mov    %rbp,%rsi
    9712:	e8 29 ff ff ff       	call   9640 <tp_eat>
    9717:	85 c0                	test   %eax,%eax
    9719:	75 d5                	jne    96f0 <tp_list_of+0x50>
    971b:	eb b9                	jmp    96d6 <tp_list_of+0x36>
    971d:	0f 1f 00             	nopl   (%rax)

0000000000009720 <tp_byte_item>:
    9720:	53                   	push   %rbx
    9721:	48 83 ec 10          	sub    $0x10,%rsp
    9725:	48 89 f3             	mov    %rsi,%rbx
    9728:	48 8d 35 51 a5 00 00 	lea    0xa551(%rip),%rsi        # 13c80 <tp_byte_item.u8d>
    972f:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    9734:	e8 97 fb ff ff       	call   92d0 <tp_int>
    9739:	85 c0                	test   %eax,%eax
    973b:	74 14                	je     9751 <tp_byte_item+0x31>
    973d:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    9742:	48 89 df             	mov    %rbx,%rdi
    9745:	e8 96 0c 00 00       	call   a3e0 <tp_push>
    974a:	b8 01 00 00 00       	mov    $0x1,%eax
    974f:	eb 02                	jmp    9753 <tp_byte_item+0x33>
    9751:	31 c0                	xor    %eax,%eax
    9753:	48 83 c4 10          	add    $0x10,%rsp
    9757:	5b                   	pop    %rbx
    9758:	c3                   	ret
    9759:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000009760 <tp_token>:
    9760:	55                   	push   %rbp
    9761:	41 57                	push   %r15
    9763:	41 56                	push   %r14
    9765:	41 55                	push   %r13
    9767:	41 54                	push   %r12
    9769:	53                   	push   %rbx
    976a:	50                   	push   %rax
    976b:	49 89 d7             	mov    %rdx,%r15
    976e:	48 89 34 24          	mov    %rsi,(%rsp)
    9772:	48 89 fb             	mov    %rdi,%rbx
    9775:	e8 06 fb ff ff       	call   9280 <tp_ws>
    977a:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    977e:	4c 8b 23             	mov    (%rbx),%r12
    9781:	4c 8b 6b 08          	mov    0x8(%rbx),%r13
    9785:	4c 89 f5             	mov    %r14,%rbp
    9788:	4d 39 ee             	cmp    %r13,%r14
    978b:	73 20                	jae    97ad <tp_token+0x4d>
    978d:	4c 89 f5             	mov    %r14,%rbp
    9790:	41 0f be 3c 2c       	movsbl (%r12,%rbp,1),%edi
    9795:	e8 a6 0c 00 00       	call   a440 <tp_is_delim>
    979a:	85 c0                	test   %eax,%eax
    979c:	75 0f                	jne    97ad <tp_token+0x4d>
    979e:	48 ff c5             	inc    %rbp
    97a1:	48 89 6b 10          	mov    %rbp,0x10(%rbx)
    97a5:	49 39 ed             	cmp    %rbp,%r13
    97a8:	75 e6                	jne    9790 <tp_token+0x30>
    97aa:	4c 89 ed             	mov    %r13,%rbp
    97ad:	4c 29 f5             	sub    %r14,%rbp
    97b0:	4d 8d 6f ff          	lea    -0x1(%r15),%r13
    97b4:	4c 39 fd             	cmp    %r15,%rbp
    97b7:	4c 0f 42 ed          	cmovb  %rbp,%r13
    97bb:	4d 01 f4             	add    %r14,%r12
    97be:	4c 8b 3c 24          	mov    (%rsp),%r15
    97c2:	4c 89 ff             	mov    %r15,%rdi
    97c5:	4c 89 e6             	mov    %r12,%rsi
    97c8:	4c 89 ea             	mov    %r13,%rdx
    97cb:	e8 60 9b ff ff       	call   3330 <memcpy@plt>
    97d0:	43 c6 04 2f 00       	movb   $0x0,(%r15,%r13,1)
    97d5:	48 8b 43 10          	mov    0x10(%rbx),%rax
    97d9:	4c 29 f0             	sub    %r14,%rax
    97dc:	48 83 c4 08          	add    $0x8,%rsp
    97e0:	5b                   	pop    %rbx
    97e1:	41 5c                	pop    %r12
    97e3:	41 5d                	pop    %r13
    97e5:	41 5e                	pop    %r14
    97e7:	41 5f                	pop    %r15
    97e9:	5d                   	pop    %rbp
    97ea:	c3                   	ret
    97eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000097f0 <tp_elem_item>:
    97f0:	55                   	push   %rbp
    97f1:	53                   	push   %rbx
    97f2:	50                   	push   %rax
    97f3:	48 89 f3             	mov    %rsi,%rbx
    97f6:	48 8b 36             	mov    (%rsi),%rsi
    97f9:	31 ed                	xor    %ebp,%ebp
    97fb:	48 89 e1             	mov    %rsp,%rcx
    97fe:	31 d2                	xor    %edx,%edx
    9800:	e8 4b f1 ff ff       	call   8950 <tp_value>
    9805:	85 c0                	test   %eax,%eax
    9807:	74 11                	je     981a <tp_elem_item+0x2a>
    9809:	48 8b 34 24          	mov    (%rsp),%rsi
    980d:	48 89 df             	mov    %rbx,%rdi
    9810:	e8 cb 0b 00 00       	call   a3e0 <tp_push>
    9815:	bd 01 00 00 00       	mov    $0x1,%ebp
    981a:	89 e8                	mov    %ebp,%eax
    981c:	48 83 c4 08          	add    $0x8,%rsp
    9820:	5b                   	pop    %rbx
    9821:	5d                   	pop    %rbp
    9822:	c3                   	ret
    9823:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    982a:	84 00 00 00 00 00 

0000000000009830 <fwp_p_array_from_list>:
    9830:	41 56                	push   %r14
    9832:	53                   	push   %rbx
    9833:	50                   	push   %rax
    9834:	48 89 fb             	mov    %rdi,%rbx
    9837:	e8 44 0c 00 00       	call   a480 <fwp_list_len>
    983c:	49 89 c6             	mov    %rax,%r14
    983f:	48 89 c7             	mov    %rax,%rdi
    9842:	e8 09 ca ff ff       	call   6250 <fwp_arr_new>
    9847:	4d 85 f6             	test   %r14,%r14
    984a:	0f 84 84 00 00 00    	je     98d4 <fwp_p_array_from_list+0xa4>
    9850:	44 89 f1             	mov    %r14d,%ecx
    9853:	83 e1 03             	and    $0x3,%ecx
    9856:	49 83 fe 04          	cmp    $0x4,%r14
    985a:	73 04                	jae    9860 <fwp_p_array_from_list+0x30>
    985c:	31 d2                	xor    %edx,%edx
    985e:	eb 4d                	jmp    98ad <fwp_p_array_from_list+0x7d>
    9860:	49 83 e6 fc          	and    $0xfffffffffffffffc,%r14
    9864:	31 d2                	xor    %edx,%edx
    9866:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    986d:	00 00 00 
    9870:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    9874:	48 89 74 d0 08       	mov    %rsi,0x8(%rax,%rdx,8)
    9879:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    987d:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
    9881:	48 89 7c d0 10       	mov    %rdi,0x10(%rax,%rdx,8)
    9886:	48 8b 76 10          	mov    0x10(%rsi),%rsi
    988a:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
    988e:	48 89 7c d0 18       	mov    %rdi,0x18(%rax,%rdx,8)
    9893:	48 8b 76 10          	mov    0x10(%rsi),%rsi
    9897:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
    989b:	48 89 7c d0 20       	mov    %rdi,0x20(%rax,%rdx,8)
    98a0:	48 8b 5e 10          	mov    0x10(%rsi),%rbx
    98a4:	48 83 c2 04          	add    $0x4,%rdx
    98a8:	49 39 d6             	cmp    %rdx,%r14
    98ab:	75 c3                	jne    9870 <fwp_p_array_from_list+0x40>
    98ad:	48 85 c9             	test   %rcx,%rcx
    98b0:	74 22                	je     98d4 <fwp_p_array_from_list+0xa4>
    98b2:	48 8d 14 d0          	lea    (%rax,%rdx,8),%rdx
    98b6:	48 83 c2 08          	add    $0x8,%rdx
    98ba:	31 f6                	xor    %esi,%esi
    98bc:	0f 1f 40 00          	nopl   0x0(%rax)
    98c0:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    98c4:	48 89 3c f2          	mov    %rdi,(%rdx,%rsi,8)
    98c8:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    98cc:	48 ff c6             	inc    %rsi
    98cf:	48 39 f1             	cmp    %rsi,%rcx
    98d2:	75 ec                	jne    98c0 <fwp_p_array_from_list+0x90>
    98d4:	48 83 c4 08          	add    $0x8,%rsp
    98d8:	5b                   	pop    %rbx
    98d9:	41 5e                	pop    %r14
    98db:	c3                   	ret
    98dc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000098e0 <tp_kv_item>:
    98e0:	41 57                	push   %r15
    98e2:	41 56                	push   %r14
    98e4:	53                   	push   %rbx
    98e5:	48 83 ec 10          	sub    $0x10,%rsp
    98e9:	48 89 f3             	mov    %rsi,%rbx
    98ec:	49 89 ff             	mov    %rdi,%r15
    98ef:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
    98f6:	00 
    98f7:	48 8b 36             	mov    (%rsi),%rsi
    98fa:	45 31 f6             	xor    %r14d,%r14d
    98fd:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    9902:	31 d2                	xor    %edx,%edx
    9904:	e8 47 f0 ff ff       	call   8950 <tp_value>
    9909:	85 c0                	test   %eax,%eax
    990b:	74 27                	je     9934 <tp_kv_item+0x54>
    990d:	45 31 f6             	xor    %r14d,%r14d
    9910:	83 7b 28 00          	cmpl   $0x0,0x28(%rbx)
    9914:	74 2b                	je     9941 <tp_kv_item+0x61>
    9916:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    991b:	48 89 df             	mov    %rbx,%rdi
    991e:	e8 bd 0a 00 00       	call   a3e0 <tp_push>
    9923:	48 89 df             	mov    %rbx,%rdi
    9926:	4c 89 f6             	mov    %r14,%rsi
    9929:	e8 b2 0a 00 00       	call   a3e0 <tp_push>
    992e:	41 be 01 00 00 00    	mov    $0x1,%r14d
    9934:	44 89 f0             	mov    %r14d,%eax
    9937:	48 83 c4 10          	add    $0x10,%rsp
    993b:	5b                   	pop    %rbx
    993c:	41 5e                	pop    %r14
    993e:	41 5f                	pop    %r15
    9940:	c3                   	ret
    9941:	48 8d 35 8b 5a 00 00 	lea    0x5a8b(%rip),%rsi        # f3d3 <exec_in_fp0+0xcd3>
    9948:	4c 89 ff             	mov    %r15,%rdi
    994b:	e8 f0 fc ff ff       	call   9640 <tp_eat>
    9950:	85 c0                	test   %eax,%eax
    9952:	74 e0                	je     9934 <tp_kv_item+0x54>
    9954:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    9958:	45 31 f6             	xor    %r14d,%r14d
    995b:	48 89 e1             	mov    %rsp,%rcx
    995e:	4c 89 ff             	mov    %r15,%rdi
    9961:	31 d2                	xor    %edx,%edx
    9963:	e8 e8 ef ff ff       	call   8950 <tp_value>
    9968:	85 c0                	test   %eax,%eax
    996a:	74 c8                	je     9934 <tp_kv_item+0x54>
    996c:	4c 8b 34 24          	mov    (%rsp),%r14
    9970:	eb a4                	jmp    9916 <tp_kv_item+0x36>
    9972:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9979:	1f 84 00 00 00 00 00 

0000000000009980 <fwp_p_map_insert>:
    9980:	55                   	push   %rbp
    9981:	41 57                	push   %r15
    9983:	41 56                	push   %r14
    9985:	41 55                	push   %r13
    9987:	41 54                	push   %r12
    9989:	53                   	push   %rbx
    998a:	48 83 ec 18          	sub    $0x18,%rsp
    998e:	49 89 d6             	mov    %rdx,%r14
    9991:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    9996:	48 89 fe             	mov    %rdi,%rsi
    9999:	48 8d 44 24 04       	lea    0x4(%rsp),%rax
    999e:	48 89 d7             	mov    %rdx,%rdi
    99a1:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
    99a6:	48 89 ca             	mov    %rcx,%rdx
    99a9:	48 89 c1             	mov    %rax,%rcx
    99ac:	e8 ef 0a 00 00       	call   a4a0 <fwp_map_find>
    99b1:	48 89 c5             	mov    %rax,%rbp
    99b4:	4d 8b 3e             	mov    (%r14),%r15
    99b7:	44 8b 64 24 04       	mov    0x4(%rsp),%r12d
    99bc:	31 ff                	xor    %edi,%edi
    99be:	45 85 e4             	test   %r12d,%r12d
    99c1:	40 0f 94 c7          	sete   %dil
    99c5:	4c 01 ff             	add    %r15,%rdi
    99c8:	e8 23 0c 00 00       	call   a5f0 <fwp_map_alloc>
    99cd:	49 89 c5             	mov    %rax,%r13
    99d0:	48 8d 58 08          	lea    0x8(%rax),%rbx
    99d4:	49 83 c6 08          	add    $0x8,%r14
    99d8:	45 85 e4             	test   %r12d,%r12d
    99db:	74 22                	je     99ff <fwp_p_map_insert+0x7f>
    99dd:	49 c1 e7 04          	shl    $0x4,%r15
    99e1:	48 89 df             	mov    %rbx,%rdi
    99e4:	4c 89 f6             	mov    %r14,%rsi
    99e7:	4c 89 fa             	mov    %r15,%rdx
    99ea:	e8 41 99 ff ff       	call   3330 <memcpy@plt>
    99ef:	48 c1 e5 04          	shl    $0x4,%rbp
    99f3:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    99f8:	49 89 44 2d 10       	mov    %rax,0x10(%r13,%rbp,1)
    99fd:	eb 46                	jmp    9a45 <fwp_p_map_insert+0xc5>
    99ff:	49 89 ec             	mov    %rbp,%r12
    9a02:	49 c1 e4 04          	shl    $0x4,%r12
    9a06:	48 89 df             	mov    %rbx,%rdi
    9a09:	4c 89 f6             	mov    %r14,%rsi
    9a0c:	4c 89 e2             	mov    %r12,%rdx
    9a0f:	e8 1c 99 ff ff       	call   3330 <memcpy@plt>
    9a14:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    9a19:	4b 89 44 25 08       	mov    %rax,0x8(%r13,%r12,1)
    9a1e:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    9a23:	4b 89 44 25 10       	mov    %rax,0x10(%r13,%r12,1)
    9a28:	4a 8d 3c 23          	lea    (%rbx,%r12,1),%rdi
    9a2c:	48 83 c7 10          	add    $0x10,%rdi
    9a30:	4d 01 f4             	add    %r14,%r12
    9a33:	49 29 ef             	sub    %rbp,%r15
    9a36:	49 c1 e7 04          	shl    $0x4,%r15
    9a3a:	4c 89 e6             	mov    %r12,%rsi
    9a3d:	4c 89 fa             	mov    %r15,%rdx
    9a40:	e8 eb 98 ff ff       	call   3330 <memcpy@plt>
    9a45:	4c 89 e8             	mov    %r13,%rax
    9a48:	48 83 c4 18          	add    $0x18,%rsp
    9a4c:	5b                   	pop    %rbx
    9a4d:	41 5c                	pop    %r12
    9a4f:	41 5d                	pop    %r13
    9a51:	41 5e                	pop    %r14
    9a53:	41 5f                	pop    %r15
    9a55:	5d                   	pop    %rbp
    9a56:	c3                   	ret
    9a57:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    9a5e:	00 00 

0000000000009a60 <fwp_valid_int>:
    9a60:	31 c0                	xor    %eax,%eax
    9a62:	48 85 f6             	test   %rsi,%rsi
    9a65:	74 32                	je     9a99 <fwp_valid_int+0x39>
    9a67:	0f b6 17             	movzbl (%rdi),%edx
    9a6a:	80 c2 d5             	add    $0xd5,%dl
    9a6d:	31 c9                	xor    %ecx,%ecx
    9a6f:	f6 c2 fd             	test   $0xfd,%dl
    9a72:	0f 94 c1             	sete   %cl
    9a75:	48 39 f1             	cmp    %rsi,%rcx
    9a78:	74 1f                	je     9a99 <fwp_valid_int+0x39>
    9a7a:	73 18                	jae    9a94 <fwp_valid_int+0x34>
    9a7c:	0f 1f 40 00          	nopl   0x0(%rax)
    9a80:	0f b6 14 0f          	movzbl (%rdi,%rcx,1),%edx
    9a84:	80 c2 c6             	add    $0xc6,%dl
    9a87:	80 fa f5             	cmp    $0xf5,%dl
    9a8a:	76 0d                	jbe    9a99 <fwp_valid_int+0x39>
    9a8c:	48 ff c1             	inc    %rcx
    9a8f:	48 39 ce             	cmp    %rcx,%rsi
    9a92:	75 ec                	jne    9a80 <fwp_valid_int+0x20>
    9a94:	b8 01 00 00 00       	mov    $0x1,%eax
    9a99:	c3                   	ret
    9a9a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000009aa0 <tp_record_body>:
    9aa0:	55                   	push   %rbp
    9aa1:	41 57                	push   %r15
    9aa3:	41 56                	push   %r14
    9aa5:	41 55                	push   %r13
    9aa7:	41 54                	push   %r12
    9aa9:	53                   	push   %rbx
    9aaa:	48 81 ec 28 01 00 00 	sub    $0x128,%rsp
    9ab1:	48 89 d3             	mov    %rdx,%rbx
    9ab4:	49 89 f5             	mov    %rsi,%r13
    9ab7:	48 89 fd             	mov    %rdi,%rbp
    9aba:	48 63 46 10          	movslq 0x10(%rsi),%rax
    9abe:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    9ac5:	00 
    9ac6:	e8 c5 c7 ff ff       	call   6290 <fwp_alloc>
    9acb:	49 89 c7             	mov    %rax,%r15
    9ace:	49 63 7d 10          	movslq 0x10(%r13),%rdi
    9ad2:	48 ff c7             	inc    %rdi
    9ad5:	e8 16 d4 ff ff       	call   6ef0 <fwp_alloc_leaf>
    9ada:	49 89 c4             	mov    %rax,%r12
    9add:	49 63 55 10          	movslq 0x10(%r13),%rdx
    9ae1:	48 ff c2             	inc    %rdx
    9ae4:	45 31 f6             	xor    %r14d,%r14d
    9ae7:	48 89 c7             	mov    %rax,%rdi
    9aea:	31 f6                	xor    %esi,%esi
    9aec:	e8 1f 97 ff ff       	call   3210 <memset@plt>
    9af1:	48 8d 35 87 59 00 00 	lea    0x5987(%rip),%rsi        # f47f <exec_in_fp0+0xd7f>
    9af8:	48 89 ef             	mov    %rbp,%rdi
    9afb:	e8 40 fb ff ff       	call   9640 <tp_eat>
    9b00:	85 c0                	test   %eax,%eax
    9b02:	0f 84 3b 01 00 00    	je     9c43 <tp_record_body+0x1a3>
    9b08:	48 8d 35 d6 4c 00 00 	lea    0x4cd6(%rip),%rsi        # e7e5 <exec_in_fp0+0xe5>
    9b0f:	48 89 ef             	mov    %rbp,%rdi
    9b12:	e8 29 fb ff ff       	call   9640 <tp_eat>
    9b17:	85 c0                	test   %eax,%eax
    9b19:	74 3e                	je     9b59 <tp_record_body+0xb9>
    9b1b:	41 8b 7d 10          	mov    0x10(%r13),%edi
    9b1f:	85 ff                	test   %edi,%edi
    9b21:	7e 20                	jle    9b43 <tp_record_body+0xa3>
    9b23:	45 31 f6             	xor    %r14d,%r14d
    9b26:	31 c0                	xor    %eax,%eax
    9b28:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    9b2f:	00 
    9b30:	41 80 3c 04 00       	cmpb   $0x0,(%r12,%rax,1)
    9b35:	0f 84 08 01 00 00    	je     9c43 <tp_record_body+0x1a3>
    9b3b:	48 ff c0             	inc    %rax
    9b3e:	48 39 c7             	cmp    %rax,%rdi
    9b41:	75 ed                	jne    9b30 <tp_record_body+0x90>
    9b43:	4c 89 fe             	mov    %r15,%rsi
    9b46:	e8 15 a7 ff ff       	call   4260 <fwp_record>
    9b4b:	48 89 03             	mov    %rax,(%rbx)
    9b4e:	41 be 01 00 00 00    	mov    $0x1,%r14d
    9b54:	e9 ea 00 00 00       	jmp    9c43 <tp_record_body+0x1a3>
    9b59:	48 89 1c 24          	mov    %rbx,(%rsp)
    9b5d:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    9b62:	48 89 ef             	mov    %rbp,%rdi
    9b65:	e8 06 01 00 00       	call   9c70 <tp_ident>
    9b6a:	41 8b 45 10          	mov    0x10(%r13),%eax
    9b6e:	85 c0                	test   %eax,%eax
    9b70:	0f 8e ca 00 00 00    	jle    9c40 <tp_record_body+0x1a0>
    9b76:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    9b7b:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    9b80:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
    9b85:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    9b8a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9b90:	4d 8b 65 18          	mov    0x18(%r13),%r12
    9b94:	41 89 c7             	mov    %eax,%r15d
    9b97:	41 be ff ff ff ff    	mov    $0xffffffff,%r14d
    9b9d:	31 ed                	xor    %ebp,%ebp
    9b9f:	90                   	nop
    9ba0:	49 8b 3c ec          	mov    (%r12,%rbp,8),%rdi
    9ba4:	48 89 de             	mov    %rbx,%rsi
    9ba7:	e8 24 97 ff ff       	call   32d0 <strcmp@plt>
    9bac:	85 c0                	test   %eax,%eax
    9bae:	44 0f 44 f5          	cmove  %ebp,%r14d
    9bb2:	48 ff c5             	inc    %rbp
    9bb5:	49 39 ef             	cmp    %rbp,%r15
    9bb8:	75 e6                	jne    9ba0 <tp_record_body+0x100>
    9bba:	45 85 f6             	test   %r14d,%r14d
    9bbd:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    9bc2:	4c 8b 64 24 10       	mov    0x10(%rsp),%r12
    9bc7:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    9bcc:	78 72                	js     9c40 <tp_record_body+0x1a0>
    9bce:	48 89 ef             	mov    %rbp,%rdi
    9bd1:	48 8d 35 fd 57 00 00 	lea    0x57fd(%rip),%rsi        # f3d5 <exec_in_fp0+0xcd5>
    9bd8:	e8 63 fa ff ff       	call   9640 <tp_eat>
    9bdd:	85 c0                	test   %eax,%eax
    9bdf:	74 5f                	je     9c40 <tp_record_body+0x1a0>
    9be1:	49 8b 45 20          	mov    0x20(%r13),%rax
    9be5:	45 89 f6             	mov    %r14d,%r14d
    9be8:	4a 8b 34 f0          	mov    (%rax,%r14,8),%rsi
    9bec:	4b 8d 0c f7          	lea    (%r15,%r14,8),%rcx
    9bf0:	48 89 ef             	mov    %rbp,%rdi
    9bf3:	31 d2                	xor    %edx,%edx
    9bf5:	e8 56 ed ff ff       	call   8950 <tp_value>
    9bfa:	85 c0                	test   %eax,%eax
    9bfc:	74 42                	je     9c40 <tp_record_body+0x1a0>
    9bfe:	43 c6 04 34 01       	movb   $0x1,(%r12,%r14,1)
    9c03:	48 89 ef             	mov    %rbp,%rdi
    9c06:	48 8d 35 d8 4b 00 00 	lea    0x4bd8(%rip),%rsi        # e7e5 <exec_in_fp0+0xe5>
    9c0d:	e8 2e fa ff ff       	call   9640 <tp_eat>
    9c12:	85 c0                	test   %eax,%eax
    9c14:	75 42                	jne    9c58 <tp_record_body+0x1b8>
    9c16:	48 89 ef             	mov    %rbp,%rdi
    9c19:	48 8d 35 c2 4b 00 00 	lea    0x4bc2(%rip),%rsi        # e7e2 <exec_in_fp0+0xe2>
    9c20:	e8 1b fa ff ff       	call   9640 <tp_eat>
    9c25:	85 c0                	test   %eax,%eax
    9c27:	74 17                	je     9c40 <tp_record_body+0x1a0>
    9c29:	48 89 ef             	mov    %rbp,%rdi
    9c2c:	48 89 de             	mov    %rbx,%rsi
    9c2f:	e8 3c 00 00 00       	call   9c70 <tp_ident>
    9c34:	41 8b 45 10          	mov    0x10(%r13),%eax
    9c38:	85 c0                	test   %eax,%eax
    9c3a:	0f 8f 50 ff ff ff    	jg     9b90 <tp_record_body+0xf0>
    9c40:	45 31 f6             	xor    %r14d,%r14d
    9c43:	44 89 f0             	mov    %r14d,%eax
    9c46:	48 81 c4 28 01 00 00 	add    $0x128,%rsp
    9c4d:	5b                   	pop    %rbx
    9c4e:	41 5c                	pop    %r12
    9c50:	41 5d                	pop    %r13
    9c52:	41 5e                	pop    %r14
    9c54:	41 5f                	pop    %r15
    9c56:	5d                   	pop    %rbp
    9c57:	c3                   	ret
    9c58:	48 8b 1c 24          	mov    (%rsp),%rbx
    9c5c:	e9 ba fe ff ff       	jmp    9b1b <tp_record_body+0x7b>
    9c61:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9c68:	0f 1f 84 00 00 00 00 
    9c6f:	00 

0000000000009c70 <tp_ident>:
    9c70:	41 56                	push   %r14
    9c72:	53                   	push   %rbx
    9c73:	50                   	push   %rax
    9c74:	48 89 f3             	mov    %rsi,%rbx
    9c77:	49 89 fe             	mov    %rdi,%r14
    9c7a:	e8 01 f6 ff ff       	call   9280 <tp_ws>
    9c7f:	49 8b 46 10          	mov    0x10(%r14),%rax
    9c83:	49 8b 36             	mov    (%r14),%rsi
    9c86:	49 8b 56 08          	mov    0x8(%r14),%rdx
    9c8a:	48 89 c1             	mov    %rax,%rcx
    9c8d:	48 39 d0             	cmp    %rdx,%rax
    9c90:	73 63                	jae    9cf5 <tp_ident+0x85>
    9c92:	48 bf 03 00 00 00 00 	movabs $0x4000000000003,%rdi
    9c99:	00 04 00 
    9c9c:	48 89 c1             	mov    %rax,%rcx
    9c9f:	eb 1b                	jmp    9cbc <tp_ident+0x4c>
    9ca1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9ca8:	0f 1f 84 00 00 00 00 
    9caf:	00 
    9cb0:	48 ff c1             	inc    %rcx
    9cb3:	49 89 4e 10          	mov    %rcx,0x10(%r14)
    9cb7:	48 39 ca             	cmp    %rcx,%rdx
    9cba:	74 36                	je     9cf2 <tp_ident+0x82>
    9cbc:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
    9cc1:	45 8d 48 d0          	lea    -0x30(%r8),%r9d
    9cc5:	41 80 f9 0a          	cmp    $0xa,%r9b
    9cc9:	72 e5                	jb     9cb0 <tp_ident+0x40>
    9ccb:	45 89 c1             	mov    %r8d,%r9d
    9cce:	41 80 e1 df          	and    $0xdf,%r9b
    9cd2:	41 80 c1 bf          	add    $0xbf,%r9b
    9cd6:	41 80 f9 1a          	cmp    $0x1a,%r9b
    9cda:	72 d4                	jb     9cb0 <tp_ident+0x40>
    9cdc:	45 0f b6 c0          	movzbl %r8b,%r8d
    9ce0:	41 83 c0 d3          	add    $0xffffffd3,%r8d
    9ce4:	41 83 f8 32          	cmp    $0x32,%r8d
    9ce8:	77 0b                	ja     9cf5 <tp_ident+0x85>
    9cea:	4c 0f a3 c7          	bt     %r8,%rdi
    9cee:	72 c0                	jb     9cb0 <tp_ident+0x40>
    9cf0:	eb 03                	jmp    9cf5 <tp_ident+0x85>
    9cf2:	48 89 d1             	mov    %rdx,%rcx
    9cf5:	48 29 c1             	sub    %rax,%rcx
    9cf8:	48 81 f9 ff 00 00 00 	cmp    $0xff,%rcx
    9cff:	41 be ff 00 00 00    	mov    $0xff,%r14d
    9d05:	4c 0f 42 f1          	cmovb  %rcx,%r14
    9d09:	48 01 c6             	add    %rax,%rsi
    9d0c:	48 89 df             	mov    %rbx,%rdi
    9d0f:	4c 89 f2             	mov    %r14,%rdx
    9d12:	e8 19 96 ff ff       	call   3330 <memcpy@plt>
    9d17:	42 c6 04 33 00       	movb   $0x0,(%rbx,%r14,1)
    9d1c:	48 83 c4 08          	add    $0x8,%rsp
    9d20:	5b                   	pop    %rbx
    9d21:	41 5e                	pop    %r14
    9d23:	c3                   	ret
    9d24:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    9d2b:	00 00 00 00 00 

0000000000009d30 <tp_atom>:
    9d30:	41 57                	push   %r15
    9d32:	41 56                	push   %r14
    9d34:	53                   	push   %rbx
    9d35:	49 89 d6             	mov    %rdx,%r14
    9d38:	49 89 f7             	mov    %rsi,%r15
    9d3b:	48 89 fb             	mov    %rdi,%rbx
    9d3e:	e8 3d f5 ff ff       	call   9280 <tp_ws>
    9d43:	41 83 3f 10          	cmpl   $0x10,(%r15)
    9d47:	75 07                	jne    9d50 <tp_atom+0x20>
    9d49:	49 83 7f 08 00       	cmpq   $0x0,0x8(%r15)
    9d4e:	74 5e                	je     9dae <tp_atom+0x7e>
    9d50:	31 c0                	xor    %eax,%eax
    9d52:	48 8b 4b 10          	mov    0x10(%rbx),%rcx
    9d56:	48 3b 4b 08          	cmp    0x8(%rbx),%rcx
    9d5a:	73 0e                	jae    9d6a <tp_atom+0x3a>
    9d5c:	48 8b 13             	mov    (%rbx),%rdx
    9d5f:	80 3c 0a 28          	cmpb   $0x28,(%rdx,%rcx,1)
    9d63:	0f 95 c2             	setne  %dl
    9d66:	08 c2                	or     %al,%dl
    9d68:	74 15                	je     9d7f <tp_atom+0x4f>
    9d6a:	48 89 df             	mov    %rbx,%rdi
    9d6d:	4c 89 fe             	mov    %r15,%rsi
    9d70:	31 d2                	xor    %edx,%edx
    9d72:	4c 89 f1             	mov    %r14,%rcx
    9d75:	5b                   	pop    %rbx
    9d76:	41 5e                	pop    %r14
    9d78:	41 5f                	pop    %r15
    9d7a:	e9 d1 eb ff ff       	jmp    8950 <tp_value>
    9d7f:	48 ff c1             	inc    %rcx
    9d82:	48 89 4b 10          	mov    %rcx,0x10(%rbx)
    9d86:	48 89 df             	mov    %rbx,%rdi
    9d89:	4c 89 fe             	mov    %r15,%rsi
    9d8c:	31 d2                	xor    %edx,%edx
    9d8e:	4c 89 f1             	mov    %r14,%rcx
    9d91:	e8 ba eb ff ff       	call   8950 <tp_value>
    9d96:	85 c0                	test   %eax,%eax
    9d98:	74 25                	je     9dbf <tp_atom+0x8f>
    9d9a:	48 8d 35 e1 56 00 00 	lea    0x56e1(%rip),%rsi        # f482 <exec_in_fp0+0xd82>
    9da1:	48 89 df             	mov    %rbx,%rdi
    9da4:	5b                   	pop    %rbx
    9da5:	41 5e                	pop    %r14
    9da7:	41 5f                	pop    %r15
    9da9:	e9 92 f8 ff ff       	jmp    9640 <tp_eat>
    9dae:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    9db3:	74 12                	je     9dc7 <tp_atom+0x97>
    9db5:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
    9dba:	0f 95 c0             	setne  %al
    9dbd:	eb 93                	jmp    9d52 <tp_atom+0x22>
    9dbf:	31 c0                	xor    %eax,%eax
    9dc1:	5b                   	pop    %rbx
    9dc2:	41 5e                	pop    %r14
    9dc4:	41 5f                	pop    %r15
    9dc6:	c3                   	ret
    9dc7:	b0 01                	mov    $0x1,%al
    9dc9:	eb 87                	jmp    9d52 <tp_atom+0x22>
    9dcb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000009dd0 <fwp_cstr>:
    9dd0:	53                   	push   %rbx
    9dd1:	48 89 fb             	mov    %rdi,%rbx
    9dd4:	e8 97 93 ff ff       	call   3170 <strlen@plt>
    9dd9:	48 89 df             	mov    %rbx,%rdi
    9ddc:	48 89 c6             	mov    %rax,%rsi
    9ddf:	5b                   	pop    %rbx
    9de0:	e9 ab e4 ff ff       	jmp    8290 <fwp_str_new>
    9de5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    9dec:	00 00 00 00 

0000000000009df0 <fwp_p_parse_int>:
    9df0:	55                   	push   %rbp
    9df1:	41 57                	push   %r15
    9df3:	41 56                	push   %r14
    9df5:	41 55                	push   %r13
    9df7:	41 54                	push   %r12
    9df9:	53                   	push   %rbx
    9dfa:	48 83 ec 18          	sub    $0x18,%rsp
    9dfe:	89 d3                	mov    %edx,%ebx
    9e00:	89 f5                	mov    %esi,%ebp
    9e02:	49 89 fe             	mov    %rdi,%r14
    9e05:	4c 8b 3f             	mov    (%rdi),%r15
    9e08:	49 83 c6 08          	add    $0x8,%r14
    9e0c:	4c 89 f7             	mov    %r14,%rdi
    9e0f:	4c 89 fe             	mov    %r15,%rsi
    9e12:	e8 49 fc ff ff       	call   9a60 <fwp_valid_int>
    9e17:	85 c0                	test   %eax,%eax
    9e19:	0f 84 1a 01 00 00    	je     9f39 <fwp_p_parse_int+0x149>
    9e1f:	41 0f b6 06          	movzbl (%r14),%eax
    9e23:	31 ff                	xor    %edi,%edi
    9e25:	3c 2d                	cmp    $0x2d,%al
    9e27:	0f 94 c1             	sete   %cl
    9e2a:	3c 2b                	cmp    $0x2b,%al
    9e2c:	0f 94 c0             	sete   %al
    9e2f:	08 c8                	or     %cl,%al
    9e31:	44 0f b6 e0          	movzbl %al,%r12d
    9e35:	4d 39 e7             	cmp    %r12,%r15
    9e38:	0f 86 d0 00 00 00    	jbe    9f0e <fwp_p_parse_int+0x11e>
    9e3e:	88 4c 24 07          	mov    %cl,0x7(%rsp)
    9e42:	89 6c 24 08          	mov    %ebp,0x8(%rsp)
    9e46:	89 5c 24 0c          	mov    %ebx,0xc(%rsp)
    9e4a:	bf 0a 00 00 00       	mov    $0xa,%edi
    9e4f:	48 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rbx
    9e56:	cc cc cc 
    9e59:	48 bd cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbp
    9e60:	cc cc cc 
    9e63:	31 f6                	xor    %esi,%esi
    9e65:	45 31 db             	xor    %r11d,%r11d
    9e68:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    9e6f:	00 
    9e70:	4d 89 dd             	mov    %r11,%r13
    9e73:	49 89 f0             	mov    %rsi,%r8
    9e76:	48 89 f0             	mov    %rsi,%rax
    9e79:	48 f7 e7             	mul    %rdi
    9e7c:	4b 8d 0c 9b          	lea    (%r11,%r11,4),%rcx
    9e80:	48 8d 0c 4a          	lea    (%rdx,%rcx,2),%rcx
    9e84:	43 0f be 14 26       	movsbl (%r14,%r12,1),%edx
    9e89:	83 c2 d0             	add    $0xffffffd0,%edx
    9e8c:	48 63 d2             	movslq %edx,%rdx
    9e8f:	49 89 d3             	mov    %rdx,%r11
    9e92:	49 c1 fb 3f          	sar    $0x3f,%r11
    9e96:	48 89 c6             	mov    %rax,%rsi
    9e99:	48 01 d6             	add    %rdx,%rsi
    9e9c:	49 11 cb             	adc    %rcx,%r11
    9e9f:	4d 89 d9             	mov    %r11,%r9
    9ea2:	49 0f a4 f1 3f       	shld   $0x3f,%rsi,%r9
    9ea7:	4c 89 d9             	mov    %r11,%rcx
    9eaa:	48 d1 e9             	shr    $1,%rcx
    9ead:	4d 89 ca             	mov    %r9,%r10
    9eb0:	49 01 ca             	add    %rcx,%r10
    9eb3:	49 83 d2 00          	adc    $0x0,%r10
    9eb7:	4c 89 d0             	mov    %r10,%rax
    9eba:	48 f7 e3             	mul    %rbx
    9ebd:	48 c1 ea 02          	shr    $0x2,%rdx
    9ec1:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9ec5:	49 29 c2             	sub    %rax,%r10
    9ec8:	4d 29 d1             	sub    %r10,%r9
    9ecb:	48 83 d9 00          	sbb    $0x0,%rcx
    9ecf:	4d 89 ca             	mov    %r9,%r10
    9ed2:	4c 0f af d5          	imul   %rbp,%r10
    9ed6:	4c 89 c8             	mov    %r9,%rax
    9ed9:	48 f7 e3             	mul    %rbx
    9edc:	4c 01 d2             	add    %r10,%rdx
    9edf:	48 0f af cb          	imul   %rbx,%rcx
    9ee3:	48 01 d1             	add    %rdx,%rcx
    9ee6:	4c 31 e9             	xor    %r13,%rcx
    9ee9:	4c 31 c0             	xor    %r8,%rax
    9eec:	48 09 c8             	or     %rcx,%rax
    9eef:	75 48                	jne    9f39 <fwp_p_parse_int+0x149>
    9ef1:	49 ff c4             	inc    %r12
    9ef4:	4d 39 e7             	cmp    %r12,%r15
    9ef7:	0f 85 73 ff ff ff    	jne    9e70 <fwp_p_parse_int+0x80>
    9efd:	8b 5c 24 0c          	mov    0xc(%rsp),%ebx
    9f01:	8b 6c 24 08          	mov    0x8(%rsp),%ebp
    9f05:	31 ff                	xor    %edi,%edi
    9f07:	0f b6 4c 24 07       	movzbl 0x7(%rsp),%ecx
    9f0c:	eb 05                	jmp    9f13 <fwp_p_parse_int+0x123>
    9f0e:	31 f6                	xor    %esi,%esi
    9f10:	45 31 db             	xor    %r11d,%r11d
    9f13:	40 88 cf             	mov    %cl,%dil
    9f16:	4c 8d 4c 24 10       	lea    0x10(%rsp),%r9
    9f1b:	4c 89 da             	mov    %r11,%rdx
    9f1e:	89 e9                	mov    %ebp,%ecx
    9f20:	41 89 d8             	mov    %ebx,%r8d
    9f23:	e8 28 00 00 00       	call   9f50 <fwp_int_in_range>
    9f28:	48 85 c0             	test   %rax,%rax
    9f2b:	74 0c                	je     9f39 <fwp_p_parse_int+0x149>
    9f2d:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    9f32:	e8 99 00 00 00       	call   9fd0 <fwp_some>
    9f37:	eb 02                	jmp    9f3b <fwp_p_parse_int+0x14b>
    9f39:	31 c0                	xor    %eax,%eax
    9f3b:	48 83 c4 18          	add    $0x18,%rsp
    9f3f:	5b                   	pop    %rbx
    9f40:	41 5c                	pop    %r12
    9f42:	41 5d                	pop    %r13
    9f44:	41 5e                	pop    %r14
    9f46:	41 5f                	pop    %r15
    9f48:	5d                   	pop    %rbp
    9f49:	c3                   	ret
    9f4a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000009f50 <fwp_int_in_range>:
    9f50:	53                   	push   %rbx
    9f51:	83 f9 09             	cmp    $0x9,%ecx
    9f54:	75 24                	jne    9f7a <fwp_int_in_range+0x2a>
    9f56:	85 ff                	test   %edi,%edi
    9f58:	74 08                	je     9f62 <fwp_int_in_range+0x12>
    9f5a:	48 89 f0             	mov    %rsi,%rax
    9f5d:	48 09 d0             	or     %rdx,%rax
    9f60:	75 3c                	jne    9f9e <fwp_int_in_range+0x4e>
    9f62:	48 89 f7             	mov    %rsi,%rdi
    9f65:	48 89 d6             	mov    %rdx,%rsi
    9f68:	4c 89 cb             	mov    %r9,%rbx
    9f6b:	e8 80 00 00 00       	call   9ff0 <fwp_box_u128>
    9f70:	48 89 03             	mov    %rax,(%rbx)
    9f73:	b8 01 00 00 00       	mov    $0x1,%eax
    9f78:	5b                   	pop    %rbx
    9f79:	c3                   	ret
    9f7a:	48 89 f0             	mov    %rsi,%rax
    9f7d:	48 f7 d8             	neg    %rax
    9f80:	48 b8 00 00 00 00 00 	movabs $0x8000000000000000,%rax
    9f87:	00 00 80 
    9f8a:	49 89 c2             	mov    %rax,%r10
    9f8d:	49 19 d2             	sbb    %rdx,%r10
    9f90:	72 0c                	jb     9f9e <fwp_int_in_range+0x4e>
    9f92:	85 ff                	test   %edi,%edi
    9f94:	75 0c                	jne    9fa2 <fwp_int_in_range+0x52>
    9f96:	48 31 d0             	xor    %rdx,%rax
    9f99:	48 09 f0             	or     %rsi,%rax
    9f9c:	75 04                	jne    9fa2 <fwp_int_in_range+0x52>
    9f9e:	31 c0                	xor    %eax,%eax
    9fa0:	5b                   	pop    %rbx
    9fa1:	c3                   	ret
    9fa2:	31 c0                	xor    %eax,%eax
    9fa4:	49 89 f2             	mov    %rsi,%r10
    9fa7:	49 f7 da             	neg    %r10
    9faa:	48 19 d0             	sbb    %rdx,%rax
    9fad:	85 ff                	test   %edi,%edi
    9faf:	4c 0f 44 d6          	cmove  %rsi,%r10
    9fb3:	48 0f 44 c2          	cmove  %rdx,%rax
    9fb7:	4c 89 d7             	mov    %r10,%rdi
    9fba:	48 89 c6             	mov    %rax,%rsi
    9fbd:	89 ca                	mov    %ecx,%edx
    9fbf:	44 89 c1             	mov    %r8d,%ecx
    9fc2:	4d 89 c8             	mov    %r9,%r8
    9fc5:	e8 56 00 00 00       	call   a020 <fwp_int_fits>
    9fca:	89 c0                	mov    %eax,%eax
    9fcc:	5b                   	pop    %rbx
    9fcd:	c3                   	ret
    9fce:	66 90                	xchg   %ax,%ax

0000000000009fd0 <fwp_some>:
    9fd0:	50                   	push   %rax
    9fd1:	48 89 3c 24          	mov    %rdi,(%rsp)
    9fd5:	48 89 e2             	mov    %rsp,%rdx
    9fd8:	bf 01 00 00 00       	mov    $0x1,%edi
    9fdd:	be 01 00 00 00       	mov    $0x1,%esi
    9fe2:	e8 e9 a2 ff ff       	call   42d0 <fwp_data>
    9fe7:	59                   	pop    %rcx
    9fe8:	c3                   	ret
    9fe9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000009ff0 <fwp_box_u128>:
    9ff0:	41 56                	push   %r14
    9ff2:	53                   	push   %rbx
    9ff3:	50                   	push   %rax
    9ff4:	48 89 f3             	mov    %rsi,%rbx
    9ff7:	49 89 fe             	mov    %rdi,%r14
    9ffa:	bf 10 00 00 00       	mov    $0x10,%edi
    9fff:	e8 ec ce ff ff       	call   6ef0 <fwp_alloc_leaf>
    a004:	48 89 58 08          	mov    %rbx,0x8(%rax)
    a008:	4c 89 30             	mov    %r14,(%rax)
    a00b:	48 83 c4 08          	add    $0x8,%rsp
    a00f:	5b                   	pop    %rbx
    a010:	41 5e                	pop    %r14
    a012:	c3                   	ret
    a013:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a01a:	84 00 00 00 00 00 

000000000000a020 <fwp_int_fits>:
    a020:	41 57                	push   %r15
    a022:	41 56                	push   %r14
    a024:	53                   	push   %rbx
    a025:	31 c0                	xor    %eax,%eax
    a027:	83 fa 14             	cmp    $0x14,%edx
    a02a:	0f 87 02 01 00 00    	ja     a132 <fwp_int_fits+0x112>
    a030:	89 d2                	mov    %edx,%edx
    a032:	4c 8d 0d 5f 42 00 00 	lea    0x425f(%rip),%r9        # e298 <_IO_stdin_used+0x298>
    a039:	49 63 14 91          	movslq (%r9,%rdx,4),%rdx
    a03d:	4c 01 ca             	add    %r9,%rdx
    a040:	ff e2                	jmp    *%rdx
    a042:	48 89 f9             	mov    %rdi,%rcx
    a045:	48 83 c1 80          	add    $0xffffffffffffff80,%rcx
    a049:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    a04d:	48 81 f9 00 ff ff ff 	cmp    $0xffffffffffffff00,%rcx
    a054:	eb 3b                	jmp    a091 <fwp_int_fits+0x71>
    a056:	48 89 f9             	mov    %rdi,%rcx
    a059:	48 81 c1 00 00 00 80 	add    $0xffffffff80000000,%rcx
    a060:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    a064:	48 ba 00 00 00 00 ff 	movabs $0xffffffff00000000,%rdx
    a06b:	ff ff ff 
    a06e:	48 39 d1             	cmp    %rdx,%rcx
    a071:	eb 1e                	jmp    a091 <fwp_int_fits+0x71>
    a073:	31 c0                	xor    %eax,%eax
    a075:	b9 ff 00 00 00       	mov    $0xff,%ecx
    a07a:	eb 2b                	jmp    a0a7 <fwp_int_fits+0x87>
    a07c:	48 89 f9             	mov    %rdi,%rcx
    a07f:	48 81 c1 00 80 ff ff 	add    $0xffffffffffff8000,%rcx
    a086:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    a08a:	48 81 f9 00 00 ff ff 	cmp    $0xffffffffffff0000,%rcx
    a091:	48 83 de ff          	sbb    $0xffffffffffffffff,%rsi
    a095:	0f 83 8f 00 00 00    	jae    a12a <fwp_int_fits+0x10a>
    a09b:	e9 92 00 00 00       	jmp    a132 <fwp_int_fits+0x112>
    a0a0:	31 c0                	xor    %eax,%eax
    a0a2:	b9 ff ff 00 00       	mov    $0xffff,%ecx
    a0a7:	48 39 f9             	cmp    %rdi,%rcx
    a0aa:	b9 00 00 00 00       	mov    $0x0,%ecx
    a0af:	48 19 f1             	sbb    %rsi,%rcx
    a0b2:	73 76                	jae    a12a <fwp_int_fits+0x10a>
    a0b4:	eb 7c                	jmp    a132 <fwp_int_fits+0x112>
    a0b6:	48 89 f9             	mov    %rdi,%rcx
    a0b9:	48 c1 e9 20          	shr    $0x20,%rcx
    a0bd:	48 09 f1             	or     %rsi,%rcx
    a0c0:	74 68                	je     a12a <fwp_int_fits+0x10a>
    a0c2:	eb 6e                	jmp    a132 <fwp_int_fits+0x112>
    a0c4:	48 b9 00 00 00 00 00 	movabs $0x8000000000000000,%rcx
    a0cb:	00 00 80 
    a0ce:	48 01 f9             	add    %rdi,%rcx
    a0d1:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    a0d5:	48 83 fe ff          	cmp    $0xffffffffffffffff,%rsi
    a0d9:	74 4f                	je     a12a <fwp_int_fits+0x10a>
    a0db:	eb 55                	jmp    a132 <fwp_int_fits+0x112>
    a0dd:	4c 89 c3             	mov    %r8,%rbx
    a0e0:	e8 5b 00 00 00       	call   a140 <fwp_box_i128>
    a0e5:	49 89 d8             	mov    %rbx,%r8
    a0e8:	48 89 c7             	mov    %rax,%rdi
    a0eb:	eb 3d                	jmp    a12a <fwp_int_fits+0x10a>
    a0ed:	4c 89 c3             	mov    %r8,%rbx
    a0f0:	49 89 fe             	mov    %rdi,%r14
    a0f3:	89 cf                	mov    %ecx,%edi
    a0f5:	49 89 f7             	mov    %rsi,%r15
    a0f8:	e8 73 00 00 00       	call   a170 <fwp_tint_max>
    a0fd:	48 89 c1             	mov    %rax,%rcx
    a100:	31 c0                	xor    %eax,%eax
    a102:	49 89 c8             	mov    %rcx,%r8
    a105:	49 f7 d8             	neg    %r8
    a108:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    a10e:	49 19 d1             	sbb    %rdx,%r9
    a111:	4c 39 f1             	cmp    %r14,%rcx
    a114:	4c 19 fa             	sbb    %r15,%rdx
    a117:	7c 19                	jl     a132 <fwp_int_fits+0x112>
    a119:	4c 89 fe             	mov    %r15,%rsi
    a11c:	4c 89 f7             	mov    %r14,%rdi
    a11f:	4d 39 c6             	cmp    %r8,%r14
    a122:	4c 19 ce             	sbb    %r9,%rsi
    a125:	49 89 d8             	mov    %rbx,%r8
    a128:	7c 08                	jl     a132 <fwp_int_fits+0x112>
    a12a:	49 89 38             	mov    %rdi,(%r8)
    a12d:	b8 01 00 00 00       	mov    $0x1,%eax
    a132:	5b                   	pop    %rbx
    a133:	41 5e                	pop    %r14
    a135:	41 5f                	pop    %r15
    a137:	c3                   	ret
    a138:	48 85 f6             	test   %rsi,%rsi
    a13b:	74 ed                	je     a12a <fwp_int_fits+0x10a>
    a13d:	eb f3                	jmp    a132 <fwp_int_fits+0x112>
    a13f:	90                   	nop

000000000000a140 <fwp_box_i128>:
    a140:	41 56                	push   %r14
    a142:	53                   	push   %rbx
    a143:	50                   	push   %rax
    a144:	48 89 f3             	mov    %rsi,%rbx
    a147:	49 89 fe             	mov    %rdi,%r14
    a14a:	bf 10 00 00 00       	mov    $0x10,%edi
    a14f:	e8 9c cd ff ff       	call   6ef0 <fwp_alloc_leaf>
    a154:	48 89 58 08          	mov    %rbx,0x8(%rax)
    a158:	4c 89 30             	mov    %r14,(%rax)
    a15b:	48 83 c4 08          	add    $0x8,%rsp
    a15f:	5b                   	pop    %rbx
    a160:	41 5e                	pop    %r14
    a162:	c3                   	ret
    a163:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a16a:	84 00 00 00 00 00 

000000000000a170 <fwp_tint_max>:
    a170:	85 ff                	test   %edi,%edi
    a172:	7e 27                	jle    a19b <fwp_tint_max+0x2b>
    a174:	8d 47 ff             	lea    -0x1(%rdi),%eax
    a177:	83 f8 4f             	cmp    $0x4f,%eax
    a17a:	41 b8 4f 00 00 00    	mov    $0x4f,%r8d
    a180:	44 0f 42 c0          	cmovb  %eax,%r8d
    a184:	41 ff c0             	inc    %r8d
    a187:	44 89 c6             	mov    %r8d,%esi
    a18a:	83 e6 07             	and    $0x7,%esi
    a18d:	83 ff 08             	cmp    $0x8,%edi
    a190:	73 11                	jae    a1a3 <fwp_tint_max+0x33>
    a192:	b8 01 00 00 00       	mov    $0x1,%eax
    a197:	31 c9                	xor    %ecx,%ecx
    a199:	eb 38                	jmp    a1d3 <fwp_tint_max+0x63>
    a19b:	31 c0                	xor    %eax,%eax
    a19d:	31 c9                	xor    %ecx,%ecx
    a19f:	48 89 ca             	mov    %rcx,%rdx
    a1a2:	c3                   	ret
    a1a3:	41 81 e0 f8 00 00 00 	and    $0xf8,%r8d
    a1aa:	b8 01 00 00 00       	mov    $0x1,%eax
    a1af:	31 c9                	xor    %ecx,%ecx
    a1b1:	bf a1 19 00 00       	mov    $0x19a1,%edi
    a1b6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    a1bd:	00 00 00 
    a1c0:	48 f7 e7             	mul    %rdi
    a1c3:	48 69 c9 a1 19 00 00 	imul   $0x19a1,%rcx,%rcx
    a1ca:	48 01 d1             	add    %rdx,%rcx
    a1cd:	41 83 c0 f8          	add    $0xfffffff8,%r8d
    a1d1:	75 ed                	jne    a1c0 <fwp_tint_max+0x50>
    a1d3:	85 f6                	test   %esi,%esi
    a1d5:	74 17                	je     a1ee <fwp_tint_max+0x7e>
    a1d7:	bf 03 00 00 00       	mov    $0x3,%edi
    a1dc:	0f 1f 40 00          	nopl   0x0(%rax)
    a1e0:	48 f7 e7             	mul    %rdi
    a1e3:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    a1e7:	48 01 d1             	add    %rdx,%rcx
    a1ea:	ff ce                	dec    %esi
    a1ec:	75 f2                	jne    a1e0 <fwp_tint_max+0x70>
    a1ee:	48 83 c0 ff          	add    $0xffffffffffffffff,%rax
    a1f2:	48 83 d1 ff          	adc    $0xffffffffffffffff,%rcx
    a1f6:	48 89 ca             	mov    %rcx,%rdx
    a1f9:	48 c1 ea 3f          	shr    $0x3f,%rdx
    a1fd:	48 01 c2             	add    %rax,%rdx
    a200:	48 89 d0             	mov    %rdx,%rax
    a203:	48 83 d1 00          	adc    $0x0,%rcx
    a207:	48 0f ac c8 01       	shrd   $0x1,%rcx,%rax
    a20c:	48 d1 f9             	sar    $1,%rcx
    a20f:	48 89 ca             	mov    %rcx,%rdx
    a212:	c3                   	ret
    a213:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a21a:	84 00 00 00 00 00 

000000000000a220 <fwp_valid_float>:
    a220:	48 85 f6             	test   %rsi,%rsi
    a223:	74 0e                	je     a233 <fwp_valid_float+0x13>
    a225:	0f b6 07             	movzbl (%rdi),%eax
    a228:	04 d5                	add    $0xd5,%al
    a22a:	31 d2                	xor    %edx,%edx
    a22c:	a8 fd                	test   $0xfd,%al
    a22e:	0f 94 c2             	sete   %dl
    a231:	eb 02                	jmp    a235 <fwp_valid_float+0x15>
    a233:	31 d2                	xor    %edx,%edx
    a235:	41 b1 01             	mov    $0x1,%r9b
    a238:	49 89 d0             	mov    %rdx,%r8
    a23b:	48 39 f2             	cmp    %rsi,%rdx
    a23e:	73 1d                	jae    a25d <fwp_valid_float+0x3d>
    a240:	42 0f b6 04 07       	movzbl (%rdi,%r8,1),%eax
    a245:	8d 48 d0             	lea    -0x30(%rax),%ecx
    a248:	80 f9 09             	cmp    $0x9,%cl
    a24b:	77 15                	ja     a262 <fwp_valid_float+0x42>
    a24d:	49 ff c0             	inc    %r8
    a250:	4c 39 c6             	cmp    %r8,%rsi
    a253:	75 eb                	jne    a240 <fwp_valid_float+0x20>
    a255:	49 89 f0             	mov    %rsi,%r8
    a258:	48 89 f1             	mov    %rsi,%rcx
    a25b:	eb 38                	jmp    a295 <fwp_valid_float+0x75>
    a25d:	48 89 d1             	mov    %rdx,%rcx
    a260:	eb 33                	jmp    a295 <fwp_valid_float+0x75>
    a262:	3c 2e                	cmp    $0x2e,%al
    a264:	75 2c                	jne    a292 <fwp_valid_float+0x72>
    a266:	49 8d 48 01          	lea    0x1(%r8),%rcx
    a26a:	48 39 f1             	cmp    %rsi,%rcx
    a26d:	73 16                	jae    a285 <fwp_valid_float+0x65>
    a26f:	90                   	nop
    a270:	0f b6 04 0f          	movzbl (%rdi,%rcx,1),%eax
    a274:	04 d0                	add    $0xd0,%al
    a276:	3c 09                	cmp    $0x9,%al
    a278:	77 0b                	ja     a285 <fwp_valid_float+0x65>
    a27a:	48 ff c1             	inc    %rcx
    a27d:	48 39 f1             	cmp    %rsi,%rcx
    a280:	72 ee                	jb     a270 <fwp_valid_float+0x50>
    a282:	48 89 f1             	mov    %rsi,%rcx
    a285:	48 8d 41 ff          	lea    -0x1(%rcx),%rax
    a289:	4c 39 c0             	cmp    %r8,%rax
    a28c:	41 0f 94 c1          	sete   %r9b
    a290:	eb 03                	jmp    a295 <fwp_valid_float+0x75>
    a292:	4c 89 c1             	mov    %r8,%rcx
    a295:	31 c0                	xor    %eax,%eax
    a297:	49 39 d0             	cmp    %rdx,%r8
    a29a:	75 06                	jne    a2a2 <fwp_valid_float+0x82>
    a29c:	45 84 c9             	test   %r9b,%r9b
    a29f:	74 01                	je     a2a2 <fwp_valid_float+0x82>
    a2a1:	c3                   	ret
    a2a2:	48 39 f1             	cmp    %rsi,%rcx
    a2a5:	73 58                	jae    a2ff <fwp_valid_float+0xdf>
    a2a7:	0f b6 14 0f          	movzbl (%rdi,%rcx,1),%edx
    a2ab:	83 ca 20             	or     $0x20,%edx
    a2ae:	83 fa 65             	cmp    $0x65,%edx
    a2b1:	75 4c                	jne    a2ff <fwp_valid_float+0xdf>
    a2b3:	48 8d 51 01          	lea    0x1(%rcx),%rdx
    a2b7:	48 39 f2             	cmp    %rsi,%rdx
    a2ba:	73 18                	jae    a2d4 <fwp_valid_float+0xb4>
    a2bc:	44 0f b6 04 17       	movzbl (%rdi,%rdx,1),%r8d
    a2c1:	41 83 f8 2d          	cmp    $0x2d,%r8d
    a2c5:	74 06                	je     a2cd <fwp_valid_float+0xad>
    a2c7:	41 83 f8 2b          	cmp    $0x2b,%r8d
    a2cb:	75 07                	jne    a2d4 <fwp_valid_float+0xb4>
    a2cd:	48 83 c1 02          	add    $0x2,%rcx
    a2d1:	48 89 ca             	mov    %rcx,%rdx
    a2d4:	48 39 f2             	cmp    %rsi,%rdx
    a2d7:	73 c8                	jae    a2a1 <fwp_valid_float+0x81>
    a2d9:	48 89 d1             	mov    %rdx,%rcx
    a2dc:	0f 1f 40 00          	nopl   0x0(%rax)
    a2e0:	44 0f b6 04 0f       	movzbl (%rdi,%rcx,1),%r8d
    a2e5:	41 80 c0 d0          	add    $0xd0,%r8b
    a2e9:	41 80 f8 09          	cmp    $0x9,%r8b
    a2ed:	77 0b                	ja     a2fa <fwp_valid_float+0xda>
    a2ef:	48 ff c1             	inc    %rcx
    a2f2:	48 39 ce             	cmp    %rcx,%rsi
    a2f5:	75 e9                	jne    a2e0 <fwp_valid_float+0xc0>
    a2f7:	48 89 f1             	mov    %rsi,%rcx
    a2fa:	48 39 d1             	cmp    %rdx,%rcx
    a2fd:	74 a2                	je     a2a1 <fwp_valid_float+0x81>
    a2ff:	31 c0                	xor    %eax,%eax
    a301:	48 39 f1             	cmp    %rsi,%rcx
    a304:	0f 94 c0             	sete   %al
    a307:	c3                   	ret
    a308:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a30f:	00 

000000000000a310 <fwp_from_f32>:
    a310:	66 0f 7e c0          	movd   %xmm0,%eax
    a314:	c3                   	ret
    a315:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a31c:	00 00 00 00 

000000000000a320 <fwp_float_of>:
    a320:	83 ff 0a             	cmp    $0xa,%edi
    a323:	0f 85 87 9f ff ff    	jne    42b0 <fwp_from_f64>
    a329:	f2 0f 5a c0          	cvtsd2ss %xmm0,%xmm0
    a32d:	eb e1                	jmp    a310 <fwp_from_f32>
    a32f:	90                   	nop

000000000000a330 <fwp_utf8_put>:
    a330:	50                   	push   %rax
    a331:	83 fe 7f             	cmp    $0x7f,%esi
    a334:	77 0f                	ja     a345 <fwp_utf8_put+0x15>
    a336:	40 88 74 24 04       	mov    %sil,0x4(%rsp)
    a33b:	ba 01 00 00 00       	mov    $0x1,%edx
    a340:	e9 8e 00 00 00       	jmp    a3d3 <fwp_utf8_put+0xa3>
    a345:	89 f0                	mov    %esi,%eax
    a347:	81 fe ff 07 00 00    	cmp    $0x7ff,%esi
    a34d:	77 1d                	ja     a36c <fwp_utf8_put+0x3c>
    a34f:	c1 e8 06             	shr    $0x6,%eax
    a352:	0c c0                	or     $0xc0,%al
    a354:	88 44 24 04          	mov    %al,0x4(%rsp)
    a358:	40 80 e6 3f          	and    $0x3f,%sil
    a35c:	40 80 ce 80          	or     $0x80,%sil
    a360:	40 88 74 24 05       	mov    %sil,0x5(%rsp)
    a365:	ba 02 00 00 00       	mov    $0x2,%edx
    a36a:	eb 67                	jmp    a3d3 <fwp_utf8_put+0xa3>
    a36c:	81 fe ff ff 00 00    	cmp    $0xffff,%esi
    a372:	77 2a                	ja     a39e <fwp_utf8_put+0x6e>
    a374:	c1 e8 0c             	shr    $0xc,%eax
    a377:	0c e0                	or     $0xe0,%al
    a379:	88 44 24 04          	mov    %al,0x4(%rsp)
    a37d:	89 f0                	mov    %esi,%eax
    a37f:	c1 e8 06             	shr    $0x6,%eax
    a382:	24 3f                	and    $0x3f,%al
    a384:	0c 80                	or     $0x80,%al
    a386:	88 44 24 05          	mov    %al,0x5(%rsp)
    a38a:	40 80 e6 3f          	and    $0x3f,%sil
    a38e:	40 80 ce 80          	or     $0x80,%sil
    a392:	40 88 74 24 06       	mov    %sil,0x6(%rsp)
    a397:	ba 03 00 00 00       	mov    $0x3,%edx
    a39c:	eb 35                	jmp    a3d3 <fwp_utf8_put+0xa3>
    a39e:	c1 e8 12             	shr    $0x12,%eax
    a3a1:	0c f0                	or     $0xf0,%al
    a3a3:	88 44 24 04          	mov    %al,0x4(%rsp)
    a3a7:	89 f0                	mov    %esi,%eax
    a3a9:	c1 e8 0c             	shr    $0xc,%eax
    a3ac:	24 3f                	and    $0x3f,%al
    a3ae:	0c 80                	or     $0x80,%al
    a3b0:	88 44 24 05          	mov    %al,0x5(%rsp)
    a3b4:	89 f0                	mov    %esi,%eax
    a3b6:	c1 e8 06             	shr    $0x6,%eax
    a3b9:	24 3f                	and    $0x3f,%al
    a3bb:	0c 80                	or     $0x80,%al
    a3bd:	88 44 24 06          	mov    %al,0x6(%rsp)
    a3c1:	40 80 e6 3f          	and    $0x3f,%sil
    a3c5:	40 80 ce 80          	or     $0x80,%sil
    a3c9:	40 88 74 24 07       	mov    %sil,0x7(%rsp)
    a3ce:	ba 04 00 00 00       	mov    $0x4,%edx
    a3d3:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
    a3d8:	e8 43 df ff ff       	call   8320 <buf_put>
    a3dd:	58                   	pop    %rax
    a3de:	c3                   	ret
    a3df:	90                   	nop

000000000000a3e0 <tp_push>:
    a3e0:	41 56                	push   %r14
    a3e2:	53                   	push   %rbx
    a3e3:	50                   	push   %rax
    a3e4:	48 89 f3             	mov    %rsi,%rbx
    a3e7:	49 89 fe             	mov    %rdi,%r14
    a3ea:	48 8b 77 18          	mov    0x18(%rdi),%rsi
    a3ee:	48 3b 77 20          	cmp    0x20(%rdi),%rsi
    a3f2:	75 2f                	jne    a423 <tp_push+0x43>
    a3f4:	48 8d 04 36          	lea    (%rsi,%rsi,1),%rax
    a3f8:	48 85 f6             	test   %rsi,%rsi
    a3fb:	ba 08 00 00 00       	mov    $0x8,%edx
    a400:	48 0f 45 d0          	cmovne %rax,%rdx
    a404:	49 89 56 20          	mov    %rdx,0x20(%r14)
    a408:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    a40c:	48 c1 e6 03          	shl    $0x3,%rsi
    a410:	48 c1 e2 03          	shl    $0x3,%rdx
    a414:	e8 27 da ff ff       	call   7e40 <fwp_mem_realloc>
    a419:	49 89 46 10          	mov    %rax,0x10(%r14)
    a41d:	49 8b 76 18          	mov    0x18(%r14),%rsi
    a421:	eb 04                	jmp    a427 <tp_push+0x47>
    a423:	49 8b 46 10          	mov    0x10(%r14),%rax
    a427:	48 8d 4e 01          	lea    0x1(%rsi),%rcx
    a42b:	49 89 4e 18          	mov    %rcx,0x18(%r14)
    a42f:	48 89 1c f0          	mov    %rbx,(%rax,%rsi,8)
    a433:	48 83 c4 08          	add    $0x8,%rsp
    a437:	5b                   	pop    %rbx
    a438:	41 5e                	pop    %r14
    a43a:	c3                   	ret
    a43b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000a440 <tp_is_delim>:
    a440:	b8 01 00 00 00       	mov    $0x1,%eax
    a445:	83 ff 2c             	cmp    $0x2c,%edi
    a448:	77 13                	ja     a45d <tp_is_delim+0x1d>
    a44a:	89 f9                	mov    %edi,%ecx
    a44c:	48 ba 00 26 00 00 01 	movabs $0x130100002600,%rdx
    a453:	13 00 00 
    a456:	48 0f a3 ca          	bt     %rcx,%rdx
    a45a:	73 01                	jae    a45d <tp_is_delim+0x1d>
    a45c:	c3                   	ret
    a45d:	83 ff 5d             	cmp    $0x5d,%edi
    a460:	74 fa                	je     a45c <tp_is_delim+0x1c>
    a462:	83 ff 7d             	cmp    $0x7d,%edi
    a465:	74 f5                	je     a45c <tp_is_delim+0x1c>
    a467:	31 c0                	xor    %eax,%eax
    a469:	40 80 ff 3a          	cmp    $0x3a,%dil
    a46d:	0f 94 c0             	sete   %al
    a470:	c3                   	ret
    a471:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a478:	0f 1f 84 00 00 00 00 
    a47f:	00 

000000000000a480 <fwp_list_len>:
    a480:	31 c0                	xor    %eax,%eax
    a482:	48 85 ff             	test   %rdi,%rdi
    a485:	74 15                	je     a49c <fwp_list_len+0x1c>
    a487:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    a48e:	00 00 
    a490:	48 ff c0             	inc    %rax
    a493:	48 8b 7f 10          	mov    0x10(%rdi),%rdi
    a497:	48 85 ff             	test   %rdi,%rdi
    a49a:	75 f4                	jne    a490 <fwp_list_len+0x10>
    a49c:	c3                   	ret
    a49d:	0f 1f 00             	nopl   (%rax)

000000000000a4a0 <fwp_map_find>:
    a4a0:	55                   	push   %rbp
    a4a1:	41 57                	push   %r15
    a4a3:	41 56                	push   %r14
    a4a5:	41 55                	push   %r13
    a4a7:	41 54                	push   %r12
    a4a9:	53                   	push   %rbx
    a4aa:	50                   	push   %rax
    a4ab:	49 89 f6             	mov    %rsi,%r14
    a4ae:	49 89 ff             	mov    %rdi,%r15
    a4b1:	48 8b 2f             	mov    (%rdi),%rbp
    a4b4:	8b 02                	mov    (%rdx),%eax
    a4b6:	83 f8 04             	cmp    $0x4,%eax
    a4b9:	72 53                	jb     a50e <fwp_map_find+0x6e>
    a4bb:	83 c0 fb             	add    $0xfffffffb,%eax
    a4be:	83 f8 04             	cmp    $0x4,%eax
    a4c1:	0f 83 a3 00 00 00    	jae    a56a <fwp_map_find+0xca>
    a4c7:	48 85 ed             	test   %rbp,%rbp
    a4ca:	0f 84 f7 00 00 00    	je     a5c7 <fwp_map_find+0x127>
    a4d0:	31 f6                	xor    %esi,%esi
    a4d2:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    a4d9:	ff ff 1f 
    a4dc:	eb 0a                	jmp    a4e8 <fwp_map_find+0x48>
    a4de:	66 90                	xchg   %ax,%ax
    a4e0:	4c 89 e5             	mov    %r12,%rbp
    a4e3:	48 39 ee             	cmp    %rbp,%rsi
    a4e6:	73 74                	jae    a55c <fwp_map_find+0xbc>
    a4e8:	48 8d 14 2e          	lea    (%rsi,%rbp,1),%rdx
    a4ec:	49 89 d4             	mov    %rdx,%r12
    a4ef:	49 d1 ec             	shr    $1,%r12
    a4f2:	48 21 c2             	and    %rax,%rdx
    a4f5:	49 8b 54 d7 08       	mov    0x8(%r15,%rdx,8),%rdx
    a4fa:	4c 39 f2             	cmp    %r14,%rdx
    a4fd:	74 64                	je     a563 <fwp_map_find+0xc3>
    a4ff:	73 df                	jae    a4e0 <fwp_map_find+0x40>
    a501:	49 ff c4             	inc    %r12
    a504:	4c 89 e6             	mov    %r12,%rsi
    a507:	48 39 ee             	cmp    %rbp,%rsi
    a50a:	72 dc                	jb     a4e8 <fwp_map_find+0x48>
    a50c:	eb 4e                	jmp    a55c <fwp_map_find+0xbc>
    a50e:	48 85 ed             	test   %rbp,%rbp
    a511:	0f 84 b0 00 00 00    	je     a5c7 <fwp_map_find+0x127>
    a517:	31 f6                	xor    %esi,%esi
    a519:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    a520:	ff ff 1f 
    a523:	eb 13                	jmp    a538 <fwp_map_find+0x98>
    a525:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a52c:	00 00 00 00 
    a530:	4c 89 e5             	mov    %r12,%rbp
    a533:	48 39 ee             	cmp    %rbp,%rsi
    a536:	73 24                	jae    a55c <fwp_map_find+0xbc>
    a538:	48 8d 14 2e          	lea    (%rsi,%rbp,1),%rdx
    a53c:	49 89 d4             	mov    %rdx,%r12
    a53f:	49 d1 ec             	shr    $1,%r12
    a542:	48 21 c2             	and    %rax,%rdx
    a545:	49 8b 54 d7 08       	mov    0x8(%r15,%rdx,8),%rdx
    a54a:	4c 39 f2             	cmp    %r14,%rdx
    a54d:	74 14                	je     a563 <fwp_map_find+0xc3>
    a54f:	7d df                	jge    a530 <fwp_map_find+0x90>
    a551:	49 ff c4             	inc    %r12
    a554:	4c 89 e6             	mov    %r12,%rsi
    a557:	48 39 ee             	cmp    %rbp,%rsi
    a55a:	72 dc                	jb     a538 <fwp_map_find+0x98>
    a55c:	31 c0                	xor    %eax,%eax
    a55e:	49 89 f4             	mov    %rsi,%r12
    a561:	eb 69                	jmp    a5cc <fwp_map_find+0x12c>
    a563:	b8 01 00 00 00       	mov    $0x1,%eax
    a568:	eb 62                	jmp    a5cc <fwp_map_find+0x12c>
    a56a:	48 85 ed             	test   %rbp,%rbp
    a56d:	74 58                	je     a5c7 <fwp_map_find+0x127>
    a56f:	49 89 d5             	mov    %rdx,%r13
    a572:	48 89 0c 24          	mov    %rcx,(%rsp)
    a576:	31 db                	xor    %ebx,%ebx
    a578:	eb 0e                	jmp    a588 <fwp_map_find+0xe8>
    a57a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    a580:	4c 89 e5             	mov    %r12,%rbp
    a583:	48 39 eb             	cmp    %rbp,%rbx
    a586:	73 38                	jae    a5c0 <fwp_map_find+0x120>
    a588:	48 8d 04 2b          	lea    (%rbx,%rbp,1),%rax
    a58c:	49 89 c4             	mov    %rax,%r12
    a58f:	49 d1 ec             	shr    $1,%r12
    a592:	48 b9 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rcx
    a599:	ff ff 1f 
    a59c:	48 21 c8             	and    %rcx,%rax
    a59f:	49 8b 7c c7 08       	mov    0x8(%r15,%rax,8),%rdi
    a5a4:	4c 89 f6             	mov    %r14,%rsi
    a5a7:	4c 89 ea             	mov    %r13,%rdx
    a5aa:	e8 61 00 00 00       	call   a610 <fwp_cmp>
    a5af:	85 c0                	test   %eax,%eax
    a5b1:	74 2d                	je     a5e0 <fwp_map_find+0x140>
    a5b3:	79 cb                	jns    a580 <fwp_map_find+0xe0>
    a5b5:	49 ff c4             	inc    %r12
    a5b8:	4c 89 e3             	mov    %r12,%rbx
    a5bb:	48 39 eb             	cmp    %rbp,%rbx
    a5be:	72 c8                	jb     a588 <fwp_map_find+0xe8>
    a5c0:	31 c0                	xor    %eax,%eax
    a5c2:	49 89 dc             	mov    %rbx,%r12
    a5c5:	eb 1e                	jmp    a5e5 <fwp_map_find+0x145>
    a5c7:	31 c0                	xor    %eax,%eax
    a5c9:	45 31 e4             	xor    %r12d,%r12d
    a5cc:	89 01                	mov    %eax,(%rcx)
    a5ce:	4c 89 e0             	mov    %r12,%rax
    a5d1:	48 83 c4 08          	add    $0x8,%rsp
    a5d5:	5b                   	pop    %rbx
    a5d6:	41 5c                	pop    %r12
    a5d8:	41 5d                	pop    %r13
    a5da:	41 5e                	pop    %r14
    a5dc:	41 5f                	pop    %r15
    a5de:	5d                   	pop    %rbp
    a5df:	c3                   	ret
    a5e0:	b8 01 00 00 00       	mov    $0x1,%eax
    a5e5:	48 8b 0c 24          	mov    (%rsp),%rcx
    a5e9:	eb e1                	jmp    a5cc <fwp_map_find+0x12c>
    a5eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000a5f0 <fwp_map_alloc>:
    a5f0:	53                   	push   %rbx
    a5f1:	48 89 fb             	mov    %rdi,%rbx
    a5f4:	48 c1 e7 04          	shl    $0x4,%rdi
    a5f8:	48 83 cf 08          	or     $0x8,%rdi
    a5fc:	e8 8f bc ff ff       	call   6290 <fwp_alloc>
    a601:	48 89 18             	mov    %rbx,(%rax)
    a604:	5b                   	pop    %rbx
    a605:	c3                   	ret
    a606:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    a60d:	00 00 00 

000000000000a610 <fwp_cmp>:
    a610:	55                   	push   %rbp
    a611:	41 57                	push   %r15
    a613:	41 56                	push   %r14
    a615:	41 55                	push   %r13
    a617:	41 54                	push   %r12
    a619:	53                   	push   %rbx
    a61a:	48 83 ec 18          	sub    $0x18,%rsp
    a61e:	48 89 f3             	mov    %rsi,%rbx
    a621:	49 89 fe             	mov    %rdi,%r14
    a624:	44 8b 2a             	mov    (%rdx),%r13d
    a627:	49 83 fd 15          	cmp    $0x15,%r13
    a62b:	77 25                	ja     a652 <fwp_cmp+0x42>
    a62d:	49 89 d7             	mov    %rdx,%r15
    a630:	48 8d 05 b5 3c 00 00 	lea    0x3cb5(%rip),%rax        # e2ec <_IO_stdin_used+0x2ec>
    a637:	4a 63 0c a8          	movslq (%rax,%r13,4),%rcx
    a63b:	48 01 c1             	add    %rax,%rcx
    a63e:	ff e1                	jmp    *%rcx
    a640:	31 c9                	xor    %ecx,%ecx
    a642:	49 39 de             	cmp    %rbx,%r14
    a645:	0f 9f c1             	setg   %cl
    a648:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    a64d:	0f 4d c1             	cmovge %ecx,%eax
    a650:	eb 10                	jmp    a662 <fwp_cmp+0x52>
    a652:	31 c9                	xor    %ecx,%ecx
    a654:	49 39 de             	cmp    %rbx,%r14
    a657:	0f 97 c1             	seta   %cl
    a65a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    a65f:	0f 43 c1             	cmovae %ecx,%eax
    a662:	48 83 c4 18          	add    $0x18,%rsp
    a666:	5b                   	pop    %rbx
    a667:	41 5c                	pop    %r12
    a669:	41 5d                	pop    %r13
    a66b:	41 5e                	pop    %r14
    a66d:	41 5f                	pop    %r15
    a66f:	5d                   	pop    %rbp
    a670:	c3                   	ret
    a671:	4d 8b 3e             	mov    (%r14),%r15
    a674:	4c 8b 23             	mov    (%rbx),%r12
    a677:	49 83 c6 08          	add    $0x8,%r14
    a67b:	48 83 c3 08          	add    $0x8,%rbx
    a67f:	4d 39 e7             	cmp    %r12,%r15
    a682:	4c 89 e2             	mov    %r12,%rdx
    a685:	49 0f 42 d7          	cmovb  %r15,%rdx
    a689:	4c 89 f7             	mov    %r14,%rdi
    a68c:	48 89 de             	mov    %rbx,%rsi
    a68f:	e8 dc 8b ff ff       	call   3270 <memcmp@plt>
    a694:	85 c0                	test   %eax,%eax
    a696:	0f 84 ce 02 00 00    	je     a96a <fwp_cmp+0x35a>
    a69c:	c1 f8 1f             	sar    $0x1f,%eax
    a69f:	83 c8 01             	or     $0x1,%eax
    a6a2:	eb be                	jmp    a662 <fwp_cmp+0x52>
    a6a4:	49 8b 06             	mov    (%r14),%rax
    a6a7:	48 8b 2b             	mov    (%rbx),%rbp
    a6aa:	48 39 e8             	cmp    %rbp,%rax
    a6ad:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    a6b2:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    a6b7:	48 0f 42 e8          	cmovb  %rax,%rbp
    a6bb:	48 85 ed             	test   %rbp,%rbp
    a6be:	74 54                	je     a714 <fwp_cmp+0x104>
    a6c0:	49 8b 47 38          	mov    0x38(%r15),%rax
    a6c4:	48 89 04 24          	mov    %rax,(%rsp)
    a6c8:	41 bc 10 00 00 00    	mov    $0x10,%r12d
    a6ce:	eb 09                	jmp    a6d9 <fwp_cmp+0xc9>
    a6d0:	49 83 c4 10          	add    $0x10,%r12
    a6d4:	48 ff cd             	dec    %rbp
    a6d7:	74 3b                	je     a714 <fwp_cmp+0x104>
    a6d9:	4b 8b 7c 26 f8       	mov    -0x8(%r14,%r12,1),%rdi
    a6de:	4a 8b 74 23 f8       	mov    -0x8(%rbx,%r12,1),%rsi
    a6e3:	48 8b 14 24          	mov    (%rsp),%rdx
    a6e7:	e8 24 ff ff ff       	call   a610 <fwp_cmp>
    a6ec:	85 c0                	test   %eax,%eax
    a6ee:	0f 85 6e ff ff ff    	jne    a662 <fwp_cmp+0x52>
    a6f4:	41 83 fd 12          	cmp    $0x12,%r13d
    a6f8:	75 d6                	jne    a6d0 <fwp_cmp+0xc0>
    a6fa:	4b 8b 3c 26          	mov    (%r14,%r12,1),%rdi
    a6fe:	4a 8b 34 23          	mov    (%rbx,%r12,1),%rsi
    a702:	49 8b 57 40          	mov    0x40(%r15),%rdx
    a706:	e8 05 ff ff ff       	call   a610 <fwp_cmp>
    a70b:	85 c0                	test   %eax,%eax
    a70d:	74 c1                	je     a6d0 <fwp_cmp+0xc0>
    a70f:	e9 4e ff ff ff       	jmp    a662 <fwp_cmp+0x52>
    a714:	31 c9                	xor    %ecx,%ecx
    a716:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    a71b:	48 39 44 24 10       	cmp    %rax,0x10(%rsp)
    a720:	e9 32 ff ff ff       	jmp    a657 <fwp_cmp+0x47>
    a725:	4c 89 f7             	mov    %r14,%rdi
    a728:	e8 73 02 00 00       	call   a9a0 <fwp_u128>
    a72d:	49 89 c7             	mov    %rax,%r15
    a730:	49 89 d6             	mov    %rdx,%r14
    a733:	48 89 df             	mov    %rbx,%rdi
    a736:	e8 65 02 00 00       	call   a9a0 <fwp_u128>
    a73b:	48 89 c1             	mov    %rax,%rcx
    a73e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    a743:	49 39 cf             	cmp    %rcx,%r15
    a746:	4c 89 f6             	mov    %r14,%rsi
    a749:	48 19 d6             	sbb    %rdx,%rsi
    a74c:	0f 82 10 ff ff ff    	jb     a662 <fwp_cmp+0x52>
    a752:	4c 39 f9             	cmp    %r15,%rcx
    a755:	4c 19 f2             	sbb    %r14,%rdx
    a758:	0f 92 c0             	setb   %al
    a75b:	0f b6 c0             	movzbl %al,%eax
    a75e:	e9 ff fe ff ff       	jmp    a662 <fwp_cmp+0x52>
    a763:	4c 89 f7             	mov    %r14,%rdi
    a766:	e8 55 02 00 00       	call   a9c0 <fwp_f32>
    a76b:	e8 40 02 00 00       	call   a9b0 <fwp_total_key32>
    a770:	89 c5                	mov    %eax,%ebp
    a772:	48 89 df             	mov    %rbx,%rdi
    a775:	e8 46 02 00 00       	call   a9c0 <fwp_f32>
    a77a:	e8 31 02 00 00       	call   a9b0 <fwp_total_key32>
    a77f:	89 c1                	mov    %eax,%ecx
    a781:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    a786:	39 cd                	cmp    %ecx,%ebp
    a788:	0f 8c d4 fe ff ff    	jl     a662 <fwp_cmp+0x52>
    a78e:	eb 2e                	jmp    a7be <fwp_cmp+0x1ae>
    a790:	4c 89 f7             	mov    %r14,%rdi
    a793:	e8 28 9b ff ff       	call   42c0 <fwp_f64>
    a798:	e8 33 02 00 00       	call   a9d0 <fwp_total_key64>
    a79d:	49 89 c6             	mov    %rax,%r14
    a7a0:	48 89 df             	mov    %rbx,%rdi
    a7a3:	e8 18 9b ff ff       	call   42c0 <fwp_f64>
    a7a8:	e8 23 02 00 00       	call   a9d0 <fwp_total_key64>
    a7ad:	48 89 c1             	mov    %rax,%rcx
    a7b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    a7b5:	49 39 ce             	cmp    %rcx,%r14
    a7b8:	0f 8c a4 fe ff ff    	jl     a662 <fwp_cmp+0x52>
    a7be:	0f 9f c0             	setg   %al
    a7c1:	0f b6 c0             	movzbl %al,%eax
    a7c4:	e9 99 fe ff ff       	jmp    a662 <fwp_cmp+0x52>
    a7c9:	4c 89 f7             	mov    %r14,%rdi
    a7cc:	e8 bf 01 00 00       	call   a990 <fwp_i128>
    a7d1:	49 89 c7             	mov    %rax,%r15
    a7d4:	49 89 d6             	mov    %rdx,%r14
    a7d7:	48 89 df             	mov    %rbx,%rdi
    a7da:	e8 b1 01 00 00       	call   a990 <fwp_i128>
    a7df:	48 89 c1             	mov    %rax,%rcx
    a7e2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    a7e7:	49 39 cf             	cmp    %rcx,%r15
    a7ea:	4c 89 f6             	mov    %r14,%rsi
    a7ed:	48 19 d6             	sbb    %rdx,%rsi
    a7f0:	0f 8c 6c fe ff ff    	jl     a662 <fwp_cmp+0x52>
    a7f6:	4c 39 f9             	cmp    %r15,%rcx
    a7f9:	4c 19 f2             	sbb    %r14,%rdx
    a7fc:	0f 9c c0             	setl   %al
    a7ff:	0f b6 c0             	movzbl %al,%eax
    a802:	e9 5b fe ff ff       	jmp    a662 <fwp_cmp+0x52>
    a807:	4d 85 f6             	test   %r14,%r14
    a80a:	0f 94 c0             	sete   %al
    a80d:	74 3e                	je     a84d <fwp_cmp+0x23d>
    a80f:	48 85 db             	test   %rbx,%rbx
    a812:	74 39                	je     a84d <fwp_cmp+0x23d>
    a814:	4d 8b 7f 38          	mov    0x38(%r15),%r15
    a818:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a81f:	00 
    a820:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    a824:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    a828:	4c 89 fa             	mov    %r15,%rdx
    a82b:	e8 e0 fd ff ff       	call   a610 <fwp_cmp>
    a830:	85 c0                	test   %eax,%eax
    a832:	0f 85 2a fe ff ff    	jne    a662 <fwp_cmp+0x52>
    a838:	4d 8b 76 10          	mov    0x10(%r14),%r14
    a83c:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    a840:	4d 85 f6             	test   %r14,%r14
    a843:	0f 94 c0             	sete   %al
    a846:	74 05                	je     a84d <fwp_cmp+0x23d>
    a848:	48 85 db             	test   %rbx,%rbx
    a84b:	75 d3                	jne    a820 <fwp_cmp+0x210>
    a84d:	48 85 db             	test   %rbx,%rbx
    a850:	0f 95 c1             	setne  %cl
    a853:	08 c1                	or     %al,%cl
    a855:	80 f1 01             	xor    $0x1,%cl
    a858:	0f b6 c9             	movzbl %cl,%ecx
    a85b:	84 c0                	test   %al,%al
    a85d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    a862:	0f 44 c1             	cmove  %ecx,%eax
    a865:	48 85 db             	test   %rbx,%rbx
    a868:	0f 44 c1             	cmove  %ecx,%eax
    a86b:	e9 f2 fd ff ff       	jmp    a662 <fwp_cmp+0x52>
    a870:	45 8b 67 10          	mov    0x10(%r15),%r12d
    a874:	45 85 e4             	test   %r12d,%r12d
    a877:	0f 8e f7 00 00 00    	jle    a974 <fwp_cmp+0x364>
    a87d:	4d 8b 7f 20          	mov    0x20(%r15),%r15
    a881:	45 31 ed             	xor    %r13d,%r13d
    a884:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    a88b:	00 00 00 00 00 
    a890:	4b 8b 7c ee 08       	mov    0x8(%r14,%r13,8),%rdi
    a895:	4a 8b 74 eb 08       	mov    0x8(%rbx,%r13,8),%rsi
    a89a:	4b 8b 14 ef          	mov    (%r15,%r13,8),%rdx
    a89e:	e8 6d fd ff ff       	call   a610 <fwp_cmp>
    a8a3:	85 c0                	test   %eax,%eax
    a8a5:	0f 85 b7 fd ff ff    	jne    a662 <fwp_cmp+0x52>
    a8ab:	49 ff c5             	inc    %r13
    a8ae:	31 c0                	xor    %eax,%eax
    a8b0:	4d 39 ec             	cmp    %r13,%r12
    a8b3:	75 db                	jne    a890 <fwp_cmp+0x280>
    a8b5:	e9 a8 fd ff ff       	jmp    a662 <fwp_cmp+0x52>
    a8ba:	49 8b 06             	mov    (%r14),%rax
    a8bd:	4c 8b 2b             	mov    (%rbx),%r13
    a8c0:	4c 39 e8             	cmp    %r13,%rax
    a8c3:	4c 89 ed             	mov    %r13,%rbp
    a8c6:	48 89 04 24          	mov    %rax,(%rsp)
    a8ca:	48 0f 42 e8          	cmovb  %rax,%rbp
    a8ce:	48 85 ed             	test   %rbp,%rbp
    a8d1:	74 2f                	je     a902 <fwp_cmp+0x2f2>
    a8d3:	4d 8b 7f 38          	mov    0x38(%r15),%r15
    a8d7:	45 31 e4             	xor    %r12d,%r12d
    a8da:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    a8e0:	4b 8b 7c e6 08       	mov    0x8(%r14,%r12,8),%rdi
    a8e5:	4a 8b 74 e3 08       	mov    0x8(%rbx,%r12,8),%rsi
    a8ea:	4c 89 fa             	mov    %r15,%rdx
    a8ed:	e8 1e fd ff ff       	call   a610 <fwp_cmp>
    a8f2:	85 c0                	test   %eax,%eax
    a8f4:	0f 85 68 fd ff ff    	jne    a662 <fwp_cmp+0x52>
    a8fa:	49 ff c4             	inc    %r12
    a8fd:	4c 39 e5             	cmp    %r12,%rbp
    a900:	75 de                	jne    a8e0 <fwp_cmp+0x2d0>
    a902:	31 c9                	xor    %ecx,%ecx
    a904:	4c 39 2c 24          	cmp    %r13,(%rsp)
    a908:	e9 4a fd ff ff       	jmp    a657 <fwp_cmp+0x47>
    a90d:	4c 89 f7             	mov    %r14,%rdi
    a910:	e8 db 00 00 00       	call   a9f0 <fwp_tag>
    a915:	89 c5                	mov    %eax,%ebp
    a917:	48 89 df             	mov    %rbx,%rdi
    a91a:	e8 d1 00 00 00       	call   a9f0 <fwp_tag>
    a91f:	39 c5                	cmp    %eax,%ebp
    a921:	75 58                	jne    a97b <fwp_cmp+0x36b>
    a923:	49 8b 4f 28          	mov    0x28(%r15),%rcx
    a927:	89 e8                	mov    %ebp,%eax
    a929:	44 8b 24 81          	mov    (%rcx,%rax,4),%r12d
    a92d:	45 85 e4             	test   %r12d,%r12d
    a930:	7e 42                	jle    a974 <fwp_cmp+0x364>
    a932:	49 8b 4f 30          	mov    0x30(%r15),%rcx
    a936:	4c 8b 3c c1          	mov    (%rcx,%rax,8),%r15
    a93a:	45 31 ed             	xor    %r13d,%r13d
    a93d:	0f 1f 00             	nopl   (%rax)
    a940:	4b 8b 7c ee 08       	mov    0x8(%r14,%r13,8),%rdi
    a945:	4a 8b 74 eb 08       	mov    0x8(%rbx,%r13,8),%rsi
    a94a:	4b 8b 14 ef          	mov    (%r15,%r13,8),%rdx
    a94e:	e8 bd fc ff ff       	call   a610 <fwp_cmp>
    a953:	85 c0                	test   %eax,%eax
    a955:	0f 85 07 fd ff ff    	jne    a662 <fwp_cmp+0x52>
    a95b:	49 ff c5             	inc    %r13
    a95e:	31 c0                	xor    %eax,%eax
    a960:	4d 39 ec             	cmp    %r13,%r12
    a963:	75 db                	jne    a940 <fwp_cmp+0x330>
    a965:	e9 f8 fc ff ff       	jmp    a662 <fwp_cmp+0x52>
    a96a:	31 c9                	xor    %ecx,%ecx
    a96c:	4d 39 e7             	cmp    %r12,%r15
    a96f:	e9 e3 fc ff ff       	jmp    a657 <fwp_cmp+0x47>
    a974:	31 c0                	xor    %eax,%eax
    a976:	e9 e7 fc ff ff       	jmp    a662 <fwp_cmp+0x52>
    a97b:	0f 97 c0             	seta   %al
    a97e:	0f b6 c8             	movzbl %al,%ecx
    a981:	e9 d4 fc ff ff       	jmp    a65a <fwp_cmp+0x4a>
    a986:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    a98d:	00 00 00 

000000000000a990 <fwp_i128>:
    a990:	48 8b 07             	mov    (%rdi),%rax
    a993:	48 8b 57 08          	mov    0x8(%rdi),%rdx
    a997:	c3                   	ret
    a998:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a99f:	00 

000000000000a9a0 <fwp_u128>:
    a9a0:	48 8b 07             	mov    (%rdi),%rax
    a9a3:	48 8b 57 08          	mov    0x8(%rdi),%rdx
    a9a7:	c3                   	ret
    a9a8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a9af:	00 

000000000000a9b0 <fwp_total_key32>:
    a9b0:	66 0f 7e c1          	movd   %xmm0,%ecx
    a9b4:	89 c8                	mov    %ecx,%eax
    a9b6:	c1 f8 1f             	sar    $0x1f,%eax
    a9b9:	d1 e8                	shr    $1,%eax
    a9bb:	31 c8                	xor    %ecx,%eax
    a9bd:	c3                   	ret
    a9be:	66 90                	xchg   %ax,%ax

000000000000a9c0 <fwp_f32>:
    a9c0:	66 0f 6e c7          	movd   %edi,%xmm0
    a9c4:	c3                   	ret
    a9c5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a9cc:	00 00 00 00 

000000000000a9d0 <fwp_total_key64>:
    a9d0:	66 48 0f 7e c1       	movq   %xmm0,%rcx
    a9d5:	48 89 c8             	mov    %rcx,%rax
    a9d8:	48 c1 f8 3f          	sar    $0x3f,%rax
    a9dc:	48 d1 e8             	shr    $1,%rax
    a9df:	48 31 c8             	xor    %rcx,%rax
    a9e2:	c3                   	ret
    a9e3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a9ea:	84 00 00 00 00 00 

000000000000a9f0 <fwp_tag>:
    a9f0:	48 89 f8             	mov    %rdi,%rax
    a9f3:	48 81 ff ff 0f 00 00 	cmp    $0xfff,%rdi
    a9fa:	76 02                	jbe    a9fe <fwp_tag+0xe>
    a9fc:	8b 00                	mov    (%rax),%eax
    a9fe:	c3                   	ret
    a9ff:	90                   	nop

000000000000aa00 <fwp_transport_off>:
    aa00:	50                   	push   %rax
    aa01:	48 8d 3d e4 49 00 00 	lea    0x49e4(%rip),%rdi        # f3ec <exec_in_fp0+0xcec>
    aa08:	e8 23 86 ff ff       	call   3030 <getenv@plt>
    aa0d:	48 85 c0             	test   %rax,%rax
    aa10:	74 1a                	je     aa2c <fwp_transport_off+0x2c>
    aa12:	48 8d 35 e1 49 00 00 	lea    0x49e1(%rip),%rsi        # f3fa <exec_in_fp0+0xcfa>
    aa19:	48 89 c7             	mov    %rax,%rdi
    aa1c:	e8 af 88 ff ff       	call   32d0 <strcmp@plt>
    aa21:	89 c1                	mov    %eax,%ecx
    aa23:	31 c0                	xor    %eax,%eax
    aa25:	85 c9                	test   %ecx,%ecx
    aa27:	0f 94 c0             	sete   %al
    aa2a:	59                   	pop    %rcx
    aa2b:	c3                   	ret
    aa2c:	31 c0                	xor    %eax,%eax
    aa2e:	59                   	pop    %rcx
    aa2f:	c3                   	ret

000000000000aa30 <fwp_pipe_addr>:
    aa30:	50                   	push   %rax
    aa31:	0f 57 c0             	xorps  %xmm0,%xmm0
    aa34:	0f 11 47 5e          	movups %xmm0,0x5e(%rdi)
    aa38:	0f 11 47 52          	movups %xmm0,0x52(%rdi)
    aa3c:	0f 11 47 42          	movups %xmm0,0x42(%rdi)
    aa40:	0f 11 47 32          	movups %xmm0,0x32(%rdi)
    aa44:	0f 11 47 22          	movups %xmm0,0x22(%rdi)
    aa48:	0f 11 47 12          	movups %xmm0,0x12(%rdi)
    aa4c:	0f 11 47 02          	movups %xmm0,0x2(%rdi)
    aa50:	66 c7 07 01 00       	movw   $0x1,(%rdi)
    aa55:	48 83 c7 03          	add    $0x3,%rdi
    aa59:	48 8b 0e             	mov    (%rsi),%rcx
    aa5c:	4c 8b 46 08          	mov    0x8(%rsi),%r8
    aa60:	48 8d 15 99 49 00 00 	lea    0x4999(%rip),%rdx        # f400 <exec_in_fp0+0xd00>
    aa67:	be 6b 00 00 00       	mov    $0x6b,%esi
    aa6c:	31 c0                	xor    %eax,%eax
    aa6e:	e8 5d 87 ff ff       	call   31d0 <snprintf@plt>
    aa73:	83 c0 03             	add    $0x3,%eax
    aa76:	59                   	pop    %rcx
    aa77:	c3                   	ret
    aa78:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    aa7f:	00 

000000000000aa80 <fwp_now_ns>:
    aa80:	48 83 ec 18          	sub    $0x18,%rsp
    aa84:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    aa89:	bf 01 00 00 00       	mov    $0x1,%edi
    aa8e:	e8 9d 86 ff ff       	call   3130 <clock_gettime@plt>
    aa93:	48 69 44 24 08 00 ca 	imul   $0x3b9aca00,0x8(%rsp),%rax
    aa9a:	9a 3b 
    aa9c:	48 03 44 24 10       	add    0x10(%rsp),%rax
    aaa1:	48 83 c4 18          	add    $0x18,%rsp
    aaa5:	c3                   	ret
    aaa6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    aaad:	00 00 00 

000000000000aab0 <fwp_ring_put>:
    aab0:	55                   	push   %rbp
    aab1:	41 57                	push   %r15
    aab3:	41 56                	push   %r14
    aab5:	41 55                	push   %r13
    aab7:	41 54                	push   %r12
    aab9:	53                   	push   %rbx
    aaba:	48 83 ec 38          	sub    $0x38,%rsp
    aabe:	48 89 3c 24          	mov    %rdi,(%rsp)
    aac2:	48 85 f6             	test   %rsi,%rsi
    aac5:	0f 84 27 01 00 00    	je     abf2 <fwp_ring_put+0x142>
    aacb:	f6 05 86 b9 02 00 01 	testb  $0x1,0x2b986(%rip)        # 36458 <fwp_po_gone>
    aad2:	0f 85 1a 01 00 00    	jne    abf2 <fwp_ring_put+0x142>
    aad8:	48 89 f3             	mov    %rsi,%rbx
    aadb:	4c 8b 3d 6e b9 02 00 	mov    0x2b96e(%rip),%r15        # 36450 <fwp_po_ring>
    aae2:	49 8d 87 00 10 00 00 	lea    0x1000(%r15),%rax
    aae9:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    aaee:	49 8d 87 c0 00 00 00 	lea    0xc0(%r15),%rax
    aaf5:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    aafa:	49 8d 87 c4 00 00 00 	lea    0xc4(%r15),%rax
    ab01:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    ab06:	49 8d 87 00 01 00 00 	lea    0x100(%r15),%rax
    ab0d:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    ab12:	49 8d 87 04 01 00 00 	lea    0x104(%r15),%rax
    ab19:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    ab1e:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    ab23:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ab2a:	84 00 00 00 00 00 
    ab30:	4d 8b 67 40          	mov    0x40(%r15),%r12
    ab34:	49 8b af 80 00 00 00 	mov    0x80(%r15),%rbp
    ab3b:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    ab3f:	4c 29 e5             	sub    %r12,%rbp
    ab42:	4c 01 ed             	add    %r13,%rbp
    ab45:	74 69                	je     abb0 <fwp_ring_put+0x100>
    ab47:	48 39 eb             	cmp    %rbp,%rbx
    ab4a:	48 0f 42 eb          	cmovb  %rbx,%rbp
    ab4e:	49 8d 7d ff          	lea    -0x1(%r13),%rdi
    ab52:	4c 21 e7             	and    %r12,%rdi
    ab55:	49 29 fd             	sub    %rdi,%r13
    ab58:	4c 39 ed             	cmp    %r13,%rbp
    ab5b:	4c 0f 42 ed          	cmovb  %rbp,%r13
    ab5f:	4c 01 f7             	add    %r14,%rdi
    ab62:	48 89 5c 24 30       	mov    %rbx,0x30(%rsp)
    ab67:	48 8b 1c 24          	mov    (%rsp),%rbx
    ab6b:	48 89 de             	mov    %rbx,%rsi
    ab6e:	4c 89 ea             	mov    %r13,%rdx
    ab71:	e8 ba 87 ff ff       	call   3330 <memcpy@plt>
    ab76:	4a 8d 34 2b          	lea    (%rbx,%r13,1),%rsi
    ab7a:	48 89 ea             	mov    %rbp,%rdx
    ab7d:	4c 29 ea             	sub    %r13,%rdx
    ab80:	4c 89 f7             	mov    %r14,%rdi
    ab83:	e8 a8 87 ff ff       	call   3330 <memcpy@plt>
    ab88:	49 01 ec             	add    %rbp,%r12
    ab8b:	4d 89 67 40          	mov    %r12,0x40(%r15)
    ab8f:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    ab94:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    ab99:	e8 82 02 00 00       	call   ae20 <fwp_ring_wake>
    ab9e:	48 01 eb             	add    %rbp,%rbx
    aba1:	48 89 1c 24          	mov    %rbx,(%rsp)
    aba5:	48 8b 5c 24 30       	mov    0x30(%rsp),%rbx
    abaa:	48 29 eb             	sub    %rbp,%rbx
    abad:	eb 31                	jmp    abe0 <fwp_ring_put+0x130>
    abaf:	90                   	nop
    abb0:	44 8b 05 05 b1 00 00 	mov    0xb105(%rip),%r8d        # 15cbc <fwp_po_sock>
    abb7:	4c 89 ff             	mov    %r15,%rdi
    abba:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    abbf:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    abc4:	48 8d 0d 35 02 00 00 	lea    0x235(%rip),%rcx        # ae00 <fwp_ring_has_space>
    abcb:	e8 f0 00 00 00       	call   acc0 <fwp_ring_wait>
    abd0:	85 c0                	test   %eax,%eax
    abd2:	75 0c                	jne    abe0 <fwp_ring_put+0x130>
    abd4:	c6 05 7d b8 02 00 01 	movb   $0x1,0x2b87d(%rip)        # 36458 <fwp_po_gone>
    abdb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    abe0:	48 85 db             	test   %rbx,%rbx
    abe3:	74 0d                	je     abf2 <fwp_ring_put+0x142>
    abe5:	f6 05 6c b8 02 00 01 	testb  $0x1,0x2b86c(%rip)        # 36458 <fwp_po_gone>
    abec:	0f 84 3e ff ff ff    	je     ab30 <fwp_ring_put+0x80>
    abf2:	48 83 c4 38          	add    $0x38,%rsp
    abf6:	5b                   	pop    %rbx
    abf7:	41 5c                	pop    %r12
    abf9:	41 5d                	pop    %r13
    abfb:	41 5e                	pop    %r14
    abfd:	41 5f                	pop    %r15
    abff:	5d                   	pop    %rbp
    ac00:	c3                   	ret
    ac01:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ac08:	0f 1f 84 00 00 00 00 
    ac0f:	00 

000000000000ac10 <fwp_po_flush_sock>:
    ac10:	48 8b 15 31 b8 01 00 	mov    0x1b831(%rip),%rdx        # 26448 <fwp_po_len>
    ac17:	48 85 d2             	test   %rdx,%rdx
    ac1a:	74 17                	je     ac33 <fwp_po_flush_sock+0x23>
    ac1c:	50                   	push   %rax
    ac1d:	8b 3d 99 b0 00 00    	mov    0xb099(%rip),%edi        # 15cbc <fwp_po_sock>
    ac23:	48 8d 35 26 b8 01 00 	lea    0x1b826(%rip),%rsi        # 26450 <fwp_po_buf>
    ac2a:	e8 11 00 00 00       	call   ac40 <fwp_po_write_raw>
    ac2f:	48 83 c4 08          	add    $0x8,%rsp
    ac33:	48 c7 05 0a b8 01 00 	movq   $0x0,0x1b80a(%rip)        # 26448 <fwp_po_len>
    ac3a:	00 00 00 00 
    ac3e:	c3                   	ret
    ac3f:	90                   	nop

000000000000ac40 <fwp_po_write_raw>:
    ac40:	48 85 d2             	test   %rdx,%rdx
    ac43:	74 70                	je     acb5 <fwp_po_write_raw+0x75>
    ac45:	f6 05 0c b8 02 00 01 	testb  $0x1,0x2b80c(%rip)        # 36458 <fwp_po_gone>
    ac4c:	75 67                	jne    acb5 <fwp_po_write_raw+0x75>
    ac4e:	55                   	push   %rbp
    ac4f:	41 56                	push   %r14
    ac51:	53                   	push   %rbx
    ac52:	48 89 d3             	mov    %rdx,%rbx
    ac55:	49 89 f6             	mov    %rsi,%r14
    ac58:	89 fd                	mov    %edi,%ebp
    ac5a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    ac60:	89 ef                	mov    %ebp,%edi
    ac62:	4c 89 f6             	mov    %r14,%rsi
    ac65:	48 89 da             	mov    %rbx,%rdx
    ac68:	b9 00 40 00 00       	mov    $0x4000,%ecx
    ac6d:	e8 2e 85 ff ff       	call   31a0 <send@plt>
    ac72:	48 85 c0             	test   %rax,%rax
    ac75:	78 19                	js     ac90 <fwp_po_write_raw+0x50>
    ac77:	74 31                	je     acaa <fwp_po_write_raw+0x6a>
    ac79:	49 01 c6             	add    %rax,%r14
    ac7c:	48 29 c3             	sub    %rax,%rbx
    ac7f:	eb 19                	jmp    ac9a <fwp_po_write_raw+0x5a>
    ac81:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ac88:	0f 1f 84 00 00 00 00 
    ac8f:	00 
    ac90:	e8 eb 83 ff ff       	call   3080 <__errno_location@plt>
    ac95:	83 38 04             	cmpl   $0x4,(%rax)
    ac98:	75 10                	jne    acaa <fwp_po_write_raw+0x6a>
    ac9a:	48 85 db             	test   %rbx,%rbx
    ac9d:	74 12                	je     acb1 <fwp_po_write_raw+0x71>
    ac9f:	f6 05 b2 b7 02 00 01 	testb  $0x1,0x2b7b2(%rip)        # 36458 <fwp_po_gone>
    aca6:	74 b8                	je     ac60 <fwp_po_write_raw+0x20>
    aca8:	eb 07                	jmp    acb1 <fwp_po_write_raw+0x71>
    acaa:	c6 05 a7 b7 02 00 01 	movb   $0x1,0x2b7a7(%rip)        # 36458 <fwp_po_gone>
    acb1:	5b                   	pop    %rbx
    acb2:	41 5e                	pop    %r14
    acb4:	5d                   	pop    %rbp
    acb5:	c3                   	ret
    acb6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    acbd:	00 00 00 

000000000000acc0 <fwp_ring_wait>:
    acc0:	55                   	push   %rbp
    acc1:	41 57                	push   %r15
    acc3:	41 56                	push   %r14
    acc5:	41 55                	push   %r13
    acc7:	41 54                	push   %r12
    acc9:	53                   	push   %rbx
    acca:	50                   	push   %rax
    accb:	44 89 44 24 04       	mov    %r8d,0x4(%rsp)
    acd0:	49 89 cf             	mov    %rcx,%r15
    acd3:	49 89 d6             	mov    %rdx,%r14
    acd6:	49 89 f4             	mov    %rsi,%r12
    acd9:	49 89 fd             	mov    %rdi,%r13
    acdc:	8b 0d de af 00 00    	mov    0xafde(%rip),%ecx        # 15cc0 <fwp_ring_spin>
    ace2:	85 c9                	test   %ecx,%ecx
    ace4:	78 06                	js     acec <fwp_ring_wait+0x2c>
    ace6:	85 c9                	test   %ecx,%ecx
    ace8:	75 1f                	jne    ad09 <fwp_ring_wait+0x49>
    acea:	eb 6f                	jmp    ad5b <fwp_ring_wait+0x9b>
    acec:	bf 54 00 00 00       	mov    $0x54,%edi
    acf1:	e8 3a 87 ff ff       	call   3430 <sysconf@plt>
    acf6:	31 c9                	xor    %ecx,%ecx
    acf8:	48 83 f8 02          	cmp    $0x2,%rax
    acfc:	0f 9d c1             	setge  %cl
    acff:	89 0d bb af 00 00    	mov    %ecx,0xafbb(%rip)        # 15cc0 <fwp_ring_spin>
    ad05:	85 c9                	test   %ecx,%ecx
    ad07:	74 52                	je     ad5b <fwp_ring_wait+0x9b>
    ad09:	4c 89 ef             	mov    %r13,%rdi
    ad0c:	41 ff d7             	call   *%r15
    ad0f:	89 c1                	mov    %eax,%ecx
    ad11:	b8 01 00 00 00       	mov    $0x1,%eax
    ad16:	85 c9                	test   %ecx,%ecx
    ad18:	75 6a                	jne    ad84 <fwp_ring_wait+0xc4>
    ad1a:	bd 01 00 00 00       	mov    $0x1,%ebp
    ad1f:	31 db                	xor    %ebx,%ebx
    ad21:	eb 19                	jmp    ad3c <fwp_ring_wait+0x7c>
    ad23:	48 05 50 c3 00 00    	add    $0xc350,%rax
    ad29:	48 89 c3             	mov    %rax,%rbx
    ad2c:	0f 1f 40 00          	nopl   0x0(%rax)
    ad30:	ff c5                	inc    %ebp
    ad32:	4c 89 ef             	mov    %r13,%rdi
    ad35:	41 ff d7             	call   *%r15
    ad38:	85 c0                	test   %eax,%eax
    ad3a:	75 43                	jne    ad7f <fwp_ring_wait+0xbf>
    ad3c:	e8 ff 00 00 00       	call   ae40 <fwp_cpu_relax>
    ad41:	40 f6 c5 3f          	test   $0x3f,%bpl
    ad45:	75 e9                	jne    ad30 <fwp_ring_wait+0x70>
    ad47:	e8 04 85 ff ff       	call   3250 <sched_yield@plt>
    ad4c:	e8 2f fd ff ff       	call   aa80 <fwp_now_ns>
    ad51:	48 85 db             	test   %rbx,%rbx
    ad54:	74 cd                	je     ad23 <fwp_ring_wait+0x63>
    ad56:	48 39 d8             	cmp    %rbx,%rax
    ad59:	7e d5                	jle    ad30 <fwp_ring_wait+0x70>
    ad5b:	41 8b 2c 24          	mov    (%r12),%ebp
    ad5f:	b8 01 00 00 00       	mov    $0x1,%eax
    ad64:	41 87 06             	xchg   %eax,(%r14)
    ad67:	0f ae f0             	mfence
    ad6a:	4c 89 ef             	mov    %r13,%rdi
    ad6d:	41 ff d7             	call   *%r15
    ad70:	85 c0                	test   %eax,%eax
    ad72:	8b 5c 24 04          	mov    0x4(%rsp),%ebx
    ad76:	74 41                	je     adb9 <fwp_ring_wait+0xf9>
    ad78:	41 c7 06 00 00 00 00 	movl   $0x0,(%r14)
    ad7f:	b8 01 00 00 00       	mov    $0x1,%eax
    ad84:	48 83 c4 08          	add    $0x8,%rsp
    ad88:	5b                   	pop    %rbx
    ad89:	41 5c                	pop    %r12
    ad8b:	41 5d                	pop    %r13
    ad8d:	41 5e                	pop    %r14
    ad8f:	41 5f                	pop    %r15
    ad91:	5d                   	pop    %rbp
    ad92:	c3                   	ret
    ad93:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ad9a:	84 00 00 00 00 00 
    ada0:	41 8b 2c 24          	mov    (%r12),%ebp
    ada4:	b8 01 00 00 00       	mov    $0x1,%eax
    ada9:	41 87 06             	xchg   %eax,(%r14)
    adac:	0f ae f0             	mfence
    adaf:	4c 89 ef             	mov    %r13,%rdi
    adb2:	41 ff d7             	call   *%r15
    adb5:	85 c0                	test   %eax,%eax
    adb7:	75 bf                	jne    ad78 <fwp_ring_wait+0xb8>
    adb9:	4c 89 e7             	mov    %r12,%rdi
    adbc:	31 f6                	xor    %esi,%esi
    adbe:	89 ea                	mov    %ebp,%edx
    adc0:	b9 64 00 00 00       	mov    $0x64,%ecx
    adc5:	e8 86 00 00 00       	call   ae50 <fwp_futex>
    adca:	48 89 c5             	mov    %rax,%rbp
    adcd:	41 c7 06 00 00 00 00 	movl   $0x0,(%r14)
    add4:	4c 89 ef             	mov    %r13,%rdi
    add7:	41 ff d7             	call   *%r15
    adda:	85 c0                	test   %eax,%eax
    addc:	75 a1                	jne    ad7f <fwp_ring_wait+0xbf>
    adde:	48 85 ed             	test   %rbp,%rbp
    ade1:	74 bd                	je     ada0 <fwp_ring_wait+0xe0>
    ade3:	e8 98 82 ff ff       	call   3080 <__errno_location@plt>
    ade8:	83 38 6e             	cmpl   $0x6e,(%rax)
    adeb:	75 b3                	jne    ada0 <fwp_ring_wait+0xe0>
    aded:	89 df                	mov    %ebx,%edi
    adef:	e8 cc 00 00 00       	call   aec0 <fwp_sock_gone>
    adf4:	85 c0                	test   %eax,%eax
    adf6:	74 a8                	je     ada0 <fwp_ring_wait+0xe0>
    adf8:	31 c0                	xor    %eax,%eax
    adfa:	eb 88                	jmp    ad84 <fwp_ring_wait+0xc4>
    adfc:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000ae00 <fwp_ring_has_space>:
    ae00:	48 8b 8f 80 00 00 00 	mov    0x80(%rdi),%rcx
    ae07:	48 2b 4f 40          	sub    0x40(%rdi),%rcx
    ae0b:	31 c0                	xor    %eax,%eax
    ae0d:	48 03 4f 08          	add    0x8(%rdi),%rcx
    ae11:	0f 95 c0             	setne  %al
    ae14:	c3                   	ret
    ae15:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    ae1c:	00 00 00 00 

000000000000ae20 <fwp_ring_wake>:
    ae20:	0f ae f0             	mfence
    ae23:	8b 06                	mov    (%rsi),%eax
    ae25:	85 c0                	test   %eax,%eax
    ae27:	74 14                	je     ae3d <fwp_ring_wake+0x1d>
    ae29:	f0 ff 07             	lock incl (%rdi)
    ae2c:	be 01 00 00 00       	mov    $0x1,%esi
    ae31:	ba ff ff ff 7f       	mov    $0x7fffffff,%edx
    ae36:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    ae3b:	eb 13                	jmp    ae50 <fwp_futex>
    ae3d:	c3                   	ret
    ae3e:	66 90                	xchg   %ax,%ax

000000000000ae40 <fwp_cpu_relax>:
    ae40:	f3 90                	pause
    ae42:	c3                   	ret
    ae43:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ae4a:	84 00 00 00 00 00 

000000000000ae50 <fwp_futex>:
    ae50:	48 83 ec 18          	sub    $0x18,%rsp
    ae54:	89 c8                	mov    %ecx,%eax
    ae56:	89 d1                	mov    %edx,%ecx
    ae58:	89 f2                	mov    %esi,%edx
    ae5a:	48 89 fe             	mov    %rdi,%rsi
    ae5d:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
    ae64:	00 00 
    ae66:	48 98                	cltq
    ae68:	48 69 f8 d3 4d 62 10 	imul   $0x10624dd3,%rax,%rdi
    ae6f:	49 89 f8             	mov    %rdi,%r8
    ae72:	49 c1 e8 3f          	shr    $0x3f,%r8
    ae76:	48 c1 ff 26          	sar    $0x26,%rdi
    ae7a:	44 01 c7             	add    %r8d,%edi
    ae7d:	69 ff e8 03 00 00    	imul   $0x3e8,%edi,%edi
    ae83:	41 89 c0             	mov    %eax,%r8d
    ae86:	41 29 f8             	sub    %edi,%r8d
    ae89:	41 69 f8 40 42 0f 00 	imul   $0xf4240,%r8d,%edi
    ae90:	48 63 ff             	movslq %edi,%rdi
    ae93:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    ae98:	31 ff                	xor    %edi,%edi
    ae9a:	85 c0                	test   %eax,%eax
    ae9c:	4c 8d 44 24 08       	lea    0x8(%rsp),%r8
    aea1:	4c 0f 48 c7          	cmovs  %rdi,%r8
    aea5:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    aeac:	bf ca 00 00 00       	mov    $0xca,%edi
    aeb1:	45 31 c9             	xor    %r9d,%r9d
    aeb4:	31 c0                	xor    %eax,%eax
    aeb6:	e8 45 84 ff ff       	call   3300 <syscall@plt>
    aebb:	48 83 c4 18          	add    $0x18,%rsp
    aebf:	c3                   	ret

000000000000aec0 <fwp_sock_gone>:
    aec0:	55                   	push   %rbp
    aec1:	53                   	push   %rbx
    aec2:	48 83 ec 18          	sub    $0x18,%rsp
    aec6:	89 fb                	mov    %edi,%ebx
    aec8:	89 7c 24 10          	mov    %edi,0x10(%rsp)
    aecc:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%rsp)
    aed3:	00 
    aed4:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    aed9:	31 ed                	xor    %ebp,%ebp
    aedb:	be 01 00 00 00       	mov    $0x1,%esi
    aee0:	31 d2                	xor    %edx,%edx
    aee2:	e8 d9 84 ff ff       	call   33c0 <poll@plt>
    aee7:	85 c0                	test   %eax,%eax
    aee9:	7e 2b                	jle    af16 <fwp_sock_gone+0x56>
    aeeb:	bd 01 00 00 00       	mov    $0x1,%ebp
    aef0:	f6 44 24 16 18       	testb  $0x18,0x16(%rsp)
    aef5:	75 1f                	jne    af16 <fwp_sock_gone+0x56>
    aef7:	48 8d 74 24 0f       	lea    0xf(%rsp),%rsi
    aefc:	ba 01 00 00 00       	mov    $0x1,%edx
    af01:	89 df                	mov    %ebx,%edi
    af03:	b9 42 00 00 00       	mov    $0x42,%ecx
    af08:	e8 53 81 ff ff       	call   3060 <recv@plt>
    af0d:	31 ed                	xor    %ebp,%ebp
    af0f:	48 85 c0             	test   %rax,%rax
    af12:	40 0f 94 c5          	sete   %bpl
    af16:	89 e8                	mov    %ebp,%eax
    af18:	48 83 c4 18          	add    $0x18,%rsp
    af1c:	5b                   	pop    %rbx
    af1d:	5d                   	pop    %rbp
    af1e:	c3                   	ret
    af1f:	90                   	nop

000000000000af20 <fwp_pipe_poll>:
    af20:	83 3d 91 ad 00 00 00 	cmpl   $0x0,0xad91(%rip)        # 15cb8 <fwp_po_listen>
    af27:	0f 88 9b 01 00 00    	js     b0c8 <fwp_pipe_poll+0x1a8>
    af2d:	55                   	push   %rbp
    af2e:	41 57                	push   %r15
    af30:	41 56                	push   %r14
    af32:	53                   	push   %rbx
    af33:	48 83 ec 28          	sub    $0x28,%rsp
    af37:	e8 44 fb ff ff       	call   aa80 <fwp_now_ns>
    af3c:	48 3b 05 1d b5 02 00 	cmp    0x2b51d(%rip),%rax        # 36460 <fwp_po_next_check>
    af43:	0f 8c 75 01 00 00    	jl     b0be <fwp_pipe_poll+0x19e>
    af49:	49 89 c6             	mov    %rax,%r14
    af4c:	48 05 40 42 0f 00    	add    $0xf4240,%rax
    af52:	48 89 05 07 b5 02 00 	mov    %rax,0x2b507(%rip)        # 36460 <fwp_po_next_check>
    af59:	8b 3d 59 ad 00 00    	mov    0xad59(%rip),%edi        # 15cb8 <fwp_po_listen>
    af5f:	31 f6                	xor    %esi,%esi
    af61:	31 d2                	xor    %edx,%edx
    af63:	e8 d8 84 ff ff       	call   3440 <accept@plt>
    af68:	85 c0                	test   %eax,%eax
    af6a:	0f 88 10 01 00 00    	js     b080 <fwp_pipe_poll+0x160>
    af70:	89 c3                	mov    %eax,%ebx
    af72:	8b 3d 40 ad 00 00    	mov    0xad40(%rip),%edi        # 15cb8 <fwp_po_listen>
    af78:	e8 b3 82 ff ff       	call   3230 <close@plt>
    af7d:	c7 05 31 ad 00 00 ff 	movl   $0xffffffff,0xad31(%rip)        # 15cb8 <fwp_po_listen>
    af84:	ff ff ff 
    af87:	89 df                	mov    %ebx,%edi
    af89:	be 02 00 00 00       	mov    $0x2,%esi
    af8e:	ba 01 00 00 00       	mov    $0x1,%edx
    af93:	31 c0                	xor    %eax,%eax
    af95:	e8 86 81 ff ff       	call   3120 <fcntl@plt>
    af9a:	89 df                	mov    %ebx,%edi
    af9c:	be 03 00 00 00       	mov    $0x3,%esi
    afa1:	31 c0                	xor    %eax,%eax
    afa3:	e8 78 81 ff ff       	call   3120 <fcntl@plt>
    afa8:	25 ff f7 ff ff       	and    $0xfffff7ff,%eax
    afad:	89 df                	mov    %ebx,%edi
    afaf:	be 04 00 00 00       	mov    $0x4,%esi
    afb4:	89 c2                	mov    %eax,%edx
    afb6:	31 c0                	xor    %eax,%eax
    afb8:	e8 63 81 ff ff       	call   3120 <fcntl@plt>
    afbd:	c7 44 24 18 0c 00 00 	movl   $0xc,0x18(%rsp)
    afc4:	00 
    afc5:	89 5c 24 10          	mov    %ebx,0x10(%rsp)
    afc9:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%rsp)
    afd0:	00 
    afd1:	48 8d 4c 24 1c       	lea    0x1c(%rsp),%rcx
    afd6:	4c 8d 44 24 18       	lea    0x18(%rsp),%r8
    afdb:	89 df                	mov    %ebx,%edi
    afdd:	be 01 00 00 00       	mov    $0x1,%esi
    afe2:	ba 11 00 00 00       	mov    $0x11,%edx
    afe7:	e8 b4 82 ff ff       	call   32a0 <getsockopt@plt>
    afec:	85 c0                	test   %eax,%eax
    afee:	0f 85 c3 00 00 00    	jne    b0b7 <fwp_pipe_poll+0x197>
    aff4:	8b 6c 24 20          	mov    0x20(%rsp),%ebp
    aff8:	e8 83 81 ff ff       	call   3180 <getuid@plt>
    affd:	39 c5                	cmp    %eax,%ebp
    afff:	0f 85 b2 00 00 00    	jne    b0b7 <fwp_pipe_poll+0x197>
    b005:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    b00a:	be 01 00 00 00       	mov    $0x1,%esi
    b00f:	ba e8 03 00 00       	mov    $0x3e8,%edx
    b014:	e8 a7 83 ff ff       	call   33c0 <poll@plt>
    b019:	85 c0                	test   %eax,%eax
    b01b:	0f 8e 96 00 00 00    	jle    b0b7 <fwp_pipe_poll+0x197>
    b021:	48 8d 74 24 03       	lea    0x3(%rsp),%rsi
    b026:	ba 05 00 00 00       	mov    $0x5,%edx
    b02b:	89 df                	mov    %ebx,%edi
    b02d:	31 c9                	xor    %ecx,%ecx
    b02f:	e8 2c 80 ff ff       	call   3060 <recv@plt>
    b034:	48 85 c0             	test   %rax,%rax
    b037:	7e 7e                	jle    b0b7 <fwp_pipe_poll+0x197>
    b039:	49 89 c6             	mov    %rax,%r14
    b03c:	4c 8d 7c 24 10       	lea    0x10(%rsp),%r15
    b041:	49 83 fe 04          	cmp    $0x4,%r14
    b045:	77 59                	ja     b0a0 <fwp_pipe_poll+0x180>
    b047:	be 01 00 00 00       	mov    $0x1,%esi
    b04c:	4c 89 ff             	mov    %r15,%rdi
    b04f:	ba e8 03 00 00       	mov    $0x3e8,%edx
    b054:	e8 67 83 ff ff       	call   33c0 <poll@plt>
    b059:	85 c0                	test   %eax,%eax
    b05b:	7e 5a                	jle    b0b7 <fwp_pipe_poll+0x197>
    b05d:	4a 8d 34 34          	lea    (%rsp,%r14,1),%rsi
    b061:	48 83 c6 03          	add    $0x3,%rsi
    b065:	ba 05 00 00 00       	mov    $0x5,%edx
    b06a:	4c 29 f2             	sub    %r14,%rdx
    b06d:	89 df                	mov    %ebx,%edi
    b06f:	31 c9                	xor    %ecx,%ecx
    b071:	e8 ea 7f ff ff       	call   3060 <recv@plt>
    b076:	49 01 c6             	add    %rax,%r14
    b079:	48 85 c0             	test   %rax,%rax
    b07c:	7f c3                	jg     b041 <fwp_pipe_poll+0x121>
    b07e:	eb 37                	jmp    b0b7 <fwp_pipe_poll+0x197>
    b080:	4c 3b 35 b1 b3 01 00 	cmp    0x1b3b1(%rip),%r14        # 26438 <fwp_po_give_up>
    b087:	7e 35                	jle    b0be <fwp_pipe_poll+0x19e>
    b089:	8b 3d 29 ac 00 00    	mov    0xac29(%rip),%edi        # 15cb8 <fwp_po_listen>
    b08f:	e8 9c 81 ff ff       	call   3230 <close@plt>
    b094:	c7 05 1a ac 00 00 ff 	movl   $0xffffffff,0xac1a(%rip)        # 15cb8 <fwp_po_listen>
    b09b:	ff ff ff 
    b09e:	eb 1e                	jmp    b0be <fwp_pipe_poll+0x19e>
    b0a0:	81 7c 24 03 46 57 50 	cmpl   $0x54505746,0x3(%rsp)
    b0a7:	54 
    b0a8:	75 0d                	jne    b0b7 <fwp_pipe_poll+0x197>
    b0aa:	0f b6 44 24 07       	movzbl 0x7(%rsp),%eax
    b0af:	8d 48 fd             	lea    -0x3(%rax),%ecx
    b0b2:	80 f9 fd             	cmp    $0xfd,%cl
    b0b5:	77 12                	ja     b0c9 <fwp_pipe_poll+0x1a9>
    b0b7:	89 df                	mov    %ebx,%edi
    b0b9:	e8 72 81 ff ff       	call   3230 <close@plt>
    b0be:	48 83 c4 28          	add    $0x28,%rsp
    b0c2:	5b                   	pop    %rbx
    b0c3:	41 5e                	pop    %r14
    b0c5:	41 5f                	pop    %r15
    b0c7:	5d                   	pop    %rbp
    b0c8:	c3                   	ret
    b0c9:	89 1d ed ab 00 00    	mov    %ebx,0xabed(%rip)        # 15cbc <fwp_po_sock>
    b0cf:	bb 01 00 00 00       	mov    $0x1,%ebx
    b0d4:	3c 02                	cmp    $0x2,%al
    b0d6:	75 10                	jne    b0e8 <fwp_pipe_poll+0x1c8>
    b0d8:	e8 53 00 00 00       	call   b130 <fwp_po_make_ring>
    b0dd:	83 f8 01             	cmp    $0x1,%eax
    b0e0:	bb 02 00 00 00       	mov    $0x2,%ebx
    b0e5:	83 db 00             	sbb    $0x0,%ebx
    b0e8:	c7 44 24 08 02 01 00 	movl   $0x102,0x8(%rsp)
    b0ef:	00 
    b0f0:	c6 44 24 0c 00       	movb   $0x0,0xc(%rsp)
    b0f5:	88 5c 24 0d          	mov    %bl,0xd(%rsp)
    b0f9:	4c 8b 35 b0 8e 00 00 	mov    0x8eb0(%rip),%r14        # 13fb0 <stdout@GLIBC_2.2.5>
    b100:	49 8b 0e             	mov    (%r14),%rcx
    b103:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    b108:	be 01 00 00 00       	mov    $0x1,%esi
    b10d:	ba 06 00 00 00       	mov    $0x6,%edx
    b112:	e8 89 83 ff ff       	call   34a0 <fwrite@plt>
    b117:	49 8b 3e             	mov    (%r14),%rdi
    b11a:	e8 31 82 ff ff       	call   3350 <fflush@plt>
    b11f:	89 1d 1b b3 01 00    	mov    %ebx,0x1b31b(%rip)        # 26440 <fwp_po_kind>
    b125:	eb 97                	jmp    b0be <fwp_pipe_poll+0x19e>
    b127:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    b12e:	00 00 

000000000000b130 <fwp_po_make_ring>:
    b130:	55                   	push   %rbp
    b131:	41 57                	push   %r15
    b133:	41 56                	push   %r14
    b135:	53                   	push   %rbx
    b136:	48 83 ec 68          	sub    $0x68,%rsp
    b13a:	48 8d 35 d7 42 00 00 	lea    0x42d7(%rip),%rsi        # f418 <exec_in_fp0+0xd18>
    b141:	31 ed                	xor    %ebp,%ebp
    b143:	bf 3f 01 00 00       	mov    $0x13f,%edi
    b148:	ba 01 00 00 00       	mov    $0x1,%edx
    b14d:	31 c0                	xor    %eax,%eax
    b14f:	e8 ac 81 ff ff       	call   3300 <syscall@plt>
    b154:	48 89 c3             	mov    %rax,%rbx
    b157:	85 db                	test   %ebx,%ebx
    b159:	78 17                	js     b172 <fwp_po_make_ring+0x42>
    b15b:	be 00 10 10 00       	mov    $0x101000,%esi
    b160:	89 df                	mov    %ebx,%edi
    b162:	e8 79 80 ff ff       	call   31e0 <ftruncate@plt>
    b167:	85 c0                	test   %eax,%eax
    b169:	74 14                	je     b17f <fwp_po_make_ring+0x4f>
    b16b:	89 df                	mov    %ebx,%edi
    b16d:	e8 be 80 ff ff       	call   3230 <close@plt>
    b172:	89 e8                	mov    %ebp,%eax
    b174:	48 83 c4 68          	add    $0x68,%rsp
    b178:	5b                   	pop    %rbx
    b179:	41 5e                	pop    %r14
    b17b:	41 5f                	pop    %r15
    b17d:	5d                   	pop    %rbp
    b17e:	c3                   	ret
    b17f:	be 00 10 10 00       	mov    $0x101000,%esi
    b184:	31 ff                	xor    %edi,%edi
    b186:	ba 03 00 00 00       	mov    $0x3,%edx
    b18b:	b9 01 00 00 00       	mov    $0x1,%ecx
    b190:	41 89 d8             	mov    %ebx,%r8d
    b193:	45 31 c9             	xor    %r9d,%r9d
    b196:	e8 f5 7f ff ff       	call   3190 <mmap@plt>
    b19b:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    b19f:	74 ca                	je     b16b <fwp_po_make_ring+0x3b>
    b1a1:	49 89 c6             	mov    %rax,%r14
    b1a4:	48 b8 46 57 50 53 01 	movabs $0x153505746,%rax
    b1ab:	00 00 00 
    b1ae:	49 89 06             	mov    %rax,(%r14)
    b1b1:	49 c7 46 08 00 00 10 	movq   $0x100000,0x8(%r14)
    b1b8:	00 
    b1b9:	c6 44 24 07 53       	movb   $0x53,0x7(%rsp)
    b1be:	48 8d 44 24 07       	lea    0x7(%rsp),%rax
    b1c3:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    b1c8:	48 c7 44 24 28 01 00 	movq   $0x1,0x28(%rsp)
    b1cf:	00 00 
    b1d1:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
    b1d8:	00 00 
    b1da:	0f 57 c0             	xorps  %xmm0,%xmm0
    b1dd:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    b1e2:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
    b1e7:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    b1ec:	48 c7 44 24 60 00 00 	movq   $0x0,0x60(%rsp)
    b1f3:	00 00 
    b1f5:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    b1fa:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    b1ff:	48 c7 44 24 48 01 00 	movq   $0x1,0x48(%rsp)
    b206:	00 00 
    b208:	48 8d 44 24 08       	lea    0x8(%rsp),%rax
    b20d:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    b212:	48 c7 44 24 58 18 00 	movq   $0x18,0x58(%rsp)
    b219:	00 00 
    b21b:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
    b222:	00 00 00 
    b225:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    b22a:	48 c7 44 24 08 14 00 	movq   $0x14,0x8(%rsp)
    b231:	00 00 
    b233:	89 5c 24 18          	mov    %ebx,0x18(%rsp)
    b237:	8b 3d 7f aa 00 00    	mov    0xaa7f(%rip),%edi        # 15cbc <fwp_po_sock>
    b23d:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
    b242:	ba 00 40 00 00       	mov    $0x4000,%edx
    b247:	e8 74 7e ff ff       	call   30c0 <sendmsg@plt>
    b24c:	49 89 c7             	mov    %rax,%r15
    b24f:	89 df                	mov    %ebx,%edi
    b251:	e8 da 7f ff ff       	call   3230 <close@plt>
    b256:	49 83 ff 01          	cmp    $0x1,%r15
    b25a:	75 11                	jne    b26d <fwp_po_make_ring+0x13d>
    b25c:	4c 89 35 ed b1 02 00 	mov    %r14,0x2b1ed(%rip)        # 36450 <fwp_po_ring>
    b263:	bd 01 00 00 00       	mov    $0x1,%ebp
    b268:	e9 05 ff ff ff       	jmp    b172 <fwp_po_make_ring+0x42>
    b26d:	be 00 10 10 00       	mov    $0x101000,%esi
    b272:	4c 89 f7             	mov    %r14,%rdi
    b275:	e8 16 81 ff ff       	call   3390 <munmap@plt>
    b27a:	31 ed                	xor    %ebp,%ebp
    b27c:	e9 f1 fe ff ff       	jmp    b172 <fwp_po_make_ring+0x42>
    b281:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b288:	0f 1f 84 00 00 00 00 
    b28f:	00 

000000000000b290 <fwp_apply>:
    b290:	55                   	push   %rbp
    b291:	48 89 e5             	mov    %rsp,%rbp
    b294:	41 57                	push   %r15
    b296:	41 56                	push   %r14
    b298:	41 55                	push   %r13
    b29a:	41 54                	push   %r12
    b29c:	53                   	push   %rbx
    b29d:	48 83 ec 18          	sub    $0x18,%rsp
    b2a1:	48 89 f3             	mov    %rsi,%rbx
    b2a4:	49 89 ff             	mov    %rdi,%r15
    b2a7:	be 01 00 00 00       	mov    $0x1,%esi
    b2ac:	eb 1e                	jmp    b2cc <fwp_apply+0x3c>
    b2ae:	66 90                	xchg   %ax,%ax
    b2b0:	4a 8d 1c f3          	lea    (%rbx,%r14,8),%rbx
    b2b4:	31 c9                	xor    %ecx,%ecx
    b2b6:	49 89 c7             	mov    %rax,%r15
    b2b9:	4c 8b 75 c8          	mov    -0x38(%rbp),%r14
    b2bd:	48 8b 65 c0          	mov    -0x40(%rbp),%rsp
    b2c1:	89 d6                	mov    %edx,%esi
    b2c3:	83 f9 01             	cmp    $0x1,%ecx
    b2c6:	0f 84 ff 03 00 00    	je     b6cb <fwp_apply+0x43b>
    b2cc:	48 8b 05 cd b0 00 00 	mov    0xb0cd(%rip),%rax        # 163a0 <fwp_fns>
    b2d3:	41 8b 0f             	mov    (%r15),%ecx
    b2d6:	45 8b 67 04          	mov    0x4(%r15),%r12d
    b2da:	48 c1 e1 05          	shl    $0x5,%rcx
    b2de:	44 8b 2c 08          	mov    (%rax,%rcx,1),%r13d
    b2e2:	4d 85 e4             	test   %r12,%r12
    b2e5:	75 39                	jne    b320 <fwp_apply+0x90>
    b2e7:	41 8d 55 ff          	lea    -0x1(%r13),%edx
    b2eb:	39 f2                	cmp    %esi,%edx
    b2ed:	73 31                	jae    b320 <fwp_apply+0x90>
    b2ef:	49 89 f7             	mov    %rsi,%r15
    b2f2:	48 89 df             	mov    %rbx,%rdi
    b2f5:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    b2f9:	4c 89 fe             	mov    %r15,%rsi
    b2fc:	49 89 c7             	mov    %rax,%r15
    b2ff:	44 39 ee             	cmp    %r13d,%esi
    b302:	0f 84 c0 03 00 00    	je     b6c8 <fwp_apply+0x438>
    b308:	4a 8d 1c eb          	lea    (%rbx,%r13,8),%rbx
    b30c:	44 29 ee             	sub    %r13d,%esi
    b30f:	b9 03 00 00 00       	mov    $0x3,%ecx
    b314:	83 f9 01             	cmp    $0x1,%ecx
    b317:	75 b3                	jne    b2cc <fwp_apply+0x3c>
    b319:	e9 ad 03 00 00       	jmp    b6cb <fwp_apply+0x43b>
    b31e:	66 90                	xchg   %ax,%ax
    b320:	4c 89 75 c8          	mov    %r14,-0x38(%rbp)
    b324:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    b328:	45 8d 34 34          	lea    (%r12,%rsi,1),%r14d
    b32c:	45 39 ee             	cmp    %r13d,%r14d
    b32f:	0f 82 1a 02 00 00    	jb     b54f <fwp_apply+0x2bf>
    b335:	48 89 65 c0          	mov    %rsp,-0x40(%rbp)
    b339:	45 89 eb             	mov    %r13d,%r11d
    b33c:	41 83 fd 02          	cmp    $0x2,%r13d
    b340:	ba 01 00 00 00       	mov    $0x1,%edx
    b345:	41 0f 43 d5          	cmovae %r13d,%edx
    b349:	48 8d 14 d5 0f 00 00 	lea    0xf(,%rdx,8),%rdx
    b350:	00 
    b351:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
    b355:	48 89 e7             	mov    %rsp,%rdi
    b358:	48 29 d7             	sub    %rdx,%rdi
    b35b:	48 89 fc             	mov    %rdi,%rsp
    b35e:	4d 85 e4             	test   %r12,%r12
    b361:	0f 84 c9 00 00 00    	je     b430 <fwp_apply+0x1a0>
    b367:	41 83 fc 04          	cmp    $0x4,%r12d
    b36b:	72 10                	jb     b37d <fwp_apply+0xed>
    b36d:	48 89 fa             	mov    %rdi,%rdx
    b370:	4c 29 fa             	sub    %r15,%rdx
    b373:	48 83 c2 f8          	add    $0xfffffffffffffff8,%rdx
    b377:	48 83 fa 20          	cmp    $0x20,%rdx
    b37b:	73 65                	jae    b3e2 <fwp_apply+0x152>
    b37d:	31 d2                	xor    %edx,%edx
    b37f:	4d 89 e0             	mov    %r12,%r8
    b382:	48 89 d6             	mov    %rdx,%rsi
    b385:	49 83 e0 03          	and    $0x3,%r8
    b389:	74 16                	je     b3a1 <fwp_apply+0x111>
    b38b:	48 89 d6             	mov    %rdx,%rsi
    b38e:	66 90                	xchg   %ax,%ax
    b390:	4d 8b 4c f7 08       	mov    0x8(%r15,%rsi,8),%r9
    b395:	4c 89 0c f7          	mov    %r9,(%rdi,%rsi,8)
    b399:	48 ff c6             	inc    %rsi
    b39c:	49 ff c8             	dec    %r8
    b39f:	75 ef                	jne    b390 <fwp_apply+0x100>
    b3a1:	4c 29 e2             	sub    %r12,%rdx
    b3a4:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    b3a8:	0f 87 82 00 00 00    	ja     b430 <fwp_apply+0x1a0>
    b3ae:	66 90                	xchg   %ax,%ax
    b3b0:	49 8b 54 f7 08       	mov    0x8(%r15,%rsi,8),%rdx
    b3b5:	48 89 14 f7          	mov    %rdx,(%rdi,%rsi,8)
    b3b9:	49 8b 54 f7 10       	mov    0x10(%r15,%rsi,8),%rdx
    b3be:	48 89 54 f7 08       	mov    %rdx,0x8(%rdi,%rsi,8)
    b3c3:	49 8b 54 f7 18       	mov    0x18(%r15,%rsi,8),%rdx
    b3c8:	48 89 54 f7 10       	mov    %rdx,0x10(%rdi,%rsi,8)
    b3cd:	49 8b 54 f7 20       	mov    0x20(%r15,%rsi,8),%rdx
    b3d2:	48 89 54 f7 18       	mov    %rdx,0x18(%rdi,%rsi,8)
    b3d7:	48 83 c6 04          	add    $0x4,%rsi
    b3db:	49 39 f4             	cmp    %rsi,%r12
    b3de:	75 d0                	jne    b3b0 <fwp_apply+0x120>
    b3e0:	eb 4e                	jmp    b430 <fwp_apply+0x1a0>
    b3e2:	44 89 e2             	mov    %r12d,%edx
    b3e5:	83 e2 fc             	and    $0xfffffffc,%edx
    b3e8:	4a 8d 34 e5 00 00 00 	lea    0x0(,%r12,8),%rsi
    b3ef:	00 
    b3f0:	48 83 e6 e0          	and    $0xffffffffffffffe0,%rsi
    b3f4:	45 31 c0             	xor    %r8d,%r8d
    b3f7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    b3fe:	00 00 
    b400:	43 0f 10 44 07 08    	movups 0x8(%r15,%r8,1),%xmm0
    b406:	43 0f 10 4c 07 18    	movups 0x18(%r15,%r8,1),%xmm1
    b40c:	42 0f 29 04 07       	movaps %xmm0,(%rdi,%r8,1)
    b411:	42 0f 29 4c 07 10    	movaps %xmm1,0x10(%rdi,%r8,1)
    b417:	49 83 c0 20          	add    $0x20,%r8
    b41b:	4c 39 c6             	cmp    %r8,%rsi
    b41e:	75 e0                	jne    b400 <fwp_apply+0x170>
    b420:	4c 39 e2             	cmp    %r12,%rdx
    b423:	0f 85 56 ff ff ff    	jne    b37f <fwp_apply+0xef>
    b429:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    b430:	45 29 e3             	sub    %r12d,%r11d
    b433:	45 89 de             	mov    %r11d,%r14d
    b436:	45 39 e5             	cmp    %r12d,%r13d
    b439:	0f 84 85 00 00 00    	je     b4c4 <fwp_apply+0x234>
    b43f:	41 83 fb 0e          	cmp    $0xe,%r11d
    b443:	0f 83 a0 00 00 00    	jae    b4e9 <fwp_apply+0x259>
    b449:	31 d2                	xor    %edx,%edx
    b44b:	4d 89 f0             	mov    %r14,%r8
    b44e:	48 89 d6             	mov    %rdx,%rsi
    b451:	49 83 e0 03          	and    $0x3,%r8
    b455:	74 1d                	je     b474 <fwp_apply+0x1e4>
    b457:	48 89 d6             	mov    %rdx,%rsi
    b45a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    b460:	4c 8b 0c f3          	mov    (%rbx,%rsi,8),%r9
    b464:	45 8d 14 34          	lea    (%r12,%rsi,1),%r10d
    b468:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    b46c:	48 ff c6             	inc    %rsi
    b46f:	49 ff c8             	dec    %r8
    b472:	75 ec                	jne    b460 <fwp_apply+0x1d0>
    b474:	4c 29 f2             	sub    %r14,%rdx
    b477:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    b47b:	77 47                	ja     b4c4 <fwp_apply+0x234>
    b47d:	0f 1f 00             	nopl   (%rax)
    b480:	48 8b 14 f3          	mov    (%rbx,%rsi,8),%rdx
    b484:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    b488:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b48c:	48 8b 54 f3 08       	mov    0x8(%rbx,%rsi,8),%rdx
    b491:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    b495:	41 ff c0             	inc    %r8d
    b498:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b49c:	48 8b 54 f3 10       	mov    0x10(%rbx,%rsi,8),%rdx
    b4a1:	45 8d 44 34 02       	lea    0x2(%r12,%rsi,1),%r8d
    b4a6:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b4aa:	48 8b 54 f3 18       	mov    0x18(%rbx,%rsi,8),%rdx
    b4af:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    b4b3:	41 83 c0 03          	add    $0x3,%r8d
    b4b7:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b4bb:	48 83 c6 04          	add    $0x4,%rsi
    b4bf:	49 39 f6             	cmp    %rsi,%r14
    b4c2:	75 bc                	jne    b480 <fwp_apply+0x1f0>
    b4c4:	45 89 dc             	mov    %r11d,%r12d
    b4c7:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    b4cb:	b9 01 00 00 00       	mov    $0x1,%ecx
    b4d0:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    b4d4:	89 f2                	mov    %esi,%edx
    b4d6:	44 29 e2             	sub    %r12d,%edx
    b4d9:	0f 85 d1 fd ff ff    	jne    b2b0 <fwp_apply+0x20>
    b4df:	89 f2                	mov    %esi,%edx
    b4e1:	49 89 c6             	mov    %rax,%r14
    b4e4:	e9 d4 fd ff ff       	jmp    b2bd <fwp_apply+0x2d>
    b4e9:	49 8d 56 ff          	lea    -0x1(%r14),%rdx
    b4ed:	89 d6                	mov    %edx,%esi
    b4ef:	44 01 e6             	add    %r12d,%esi
    b4f2:	0f 82 51 ff ff ff    	jb     b449 <fwp_apply+0x1b9>
    b4f8:	48 c1 ea 20          	shr    $0x20,%rdx
    b4fc:	ba 00 00 00 00       	mov    $0x0,%edx
    b501:	0f 85 44 ff ff ff    	jne    b44b <fwp_apply+0x1bb>
    b507:	4a 8d 14 e7          	lea    (%rdi,%r12,8),%rdx
    b50b:	48 29 da             	sub    %rbx,%rdx
    b50e:	48 83 fa 20          	cmp    $0x20,%rdx
    b512:	0f 82 31 ff ff ff    	jb     b449 <fwp_apply+0x1b9>
    b518:	44 89 f2             	mov    %r14d,%edx
    b51b:	83 e2 fc             	and    $0xfffffffc,%edx
    b51e:	31 f6                	xor    %esi,%esi
    b520:	0f 10 04 f3          	movups (%rbx,%rsi,8),%xmm0
    b524:	0f 10 4c f3 10       	movups 0x10(%rbx,%rsi,8),%xmm1
    b529:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    b52d:	42 0f 11 04 c7       	movups %xmm0,(%rdi,%r8,8)
    b532:	42 0f 11 4c c7 10    	movups %xmm1,0x10(%rdi,%r8,8)
    b538:	48 83 c6 04          	add    $0x4,%rsi
    b53c:	48 39 f2             	cmp    %rsi,%rdx
    b53f:	75 df                	jne    b520 <fwp_apply+0x290>
    b541:	4c 39 f2             	cmp    %r14,%rdx
    b544:	0f 85 01 ff ff ff    	jne    b44b <fwp_apply+0x1bb>
    b54a:	e9 75 ff ff ff       	jmp    b4c4 <fwp_apply+0x234>
    b54f:	44 89 f0             	mov    %r14d,%eax
    b552:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    b559:	00 
    b55a:	e8 31 ad ff ff       	call   6290 <fwp_alloc>
    b55f:	41 8b 0f             	mov    (%r15),%ecx
    b562:	89 08                	mov    %ecx,(%rax)
    b564:	44 89 70 04          	mov    %r14d,0x4(%rax)
    b568:	49 89 c6             	mov    %rax,%r14
    b56b:	4d 85 e4             	test   %r12,%r12
    b56e:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    b572:	0f 84 b9 00 00 00    	je     b631 <fwp_apply+0x3a1>
    b578:	31 c0                	xor    %eax,%eax
    b57a:	41 83 fc 06          	cmp    $0x6,%r12d
    b57e:	72 46                	jb     b5c6 <fwp_apply+0x336>
    b580:	4c 89 f1             	mov    %r14,%rcx
    b583:	4c 29 f9             	sub    %r15,%rcx
    b586:	48 83 f9 20          	cmp    $0x20,%rcx
    b58a:	72 3a                	jb     b5c6 <fwp_apply+0x336>
    b58c:	44 89 e0             	mov    %r12d,%eax
    b58f:	83 e0 fc             	and    $0xfffffffc,%eax
    b592:	4a 8d 0c e5 00 00 00 	lea    0x0(,%r12,8),%rcx
    b599:	00 
    b59a:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    b59e:	31 d2                	xor    %edx,%edx
    b5a0:	41 0f 10 44 17 08    	movups 0x8(%r15,%rdx,1),%xmm0
    b5a6:	41 0f 10 4c 17 18    	movups 0x18(%r15,%rdx,1),%xmm1
    b5ac:	41 0f 11 44 16 08    	movups %xmm0,0x8(%r14,%rdx,1)
    b5b2:	41 0f 11 4c 16 18    	movups %xmm1,0x18(%r14,%rdx,1)
    b5b8:	48 83 c2 20          	add    $0x20,%rdx
    b5bc:	48 39 d1             	cmp    %rdx,%rcx
    b5bf:	75 df                	jne    b5a0 <fwp_apply+0x310>
    b5c1:	4c 39 e0             	cmp    %r12,%rax
    b5c4:	74 6b                	je     b631 <fwp_apply+0x3a1>
    b5c6:	4c 89 e2             	mov    %r12,%rdx
    b5c9:	48 89 c1             	mov    %rax,%rcx
    b5cc:	48 83 e2 03          	and    $0x3,%rdx
    b5d0:	74 20                	je     b5f2 <fwp_apply+0x362>
    b5d2:	48 89 c1             	mov    %rax,%rcx
    b5d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b5dc:	00 00 00 00 
    b5e0:	49 8b 74 cf 08       	mov    0x8(%r15,%rcx,8),%rsi
    b5e5:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    b5ea:	48 ff c1             	inc    %rcx
    b5ed:	48 ff ca             	dec    %rdx
    b5f0:	75 ee                	jne    b5e0 <fwp_apply+0x350>
    b5f2:	4c 29 e0             	sub    %r12,%rax
    b5f5:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    b5f9:	77 36                	ja     b631 <fwp_apply+0x3a1>
    b5fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    b600:	49 8b 44 cf 08       	mov    0x8(%r15,%rcx,8),%rax
    b605:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    b60a:	49 8b 44 cf 10       	mov    0x10(%r15,%rcx,8),%rax
    b60f:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    b614:	49 8b 44 cf 18       	mov    0x18(%r15,%rcx,8),%rax
    b619:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    b61e:	49 8b 44 cf 20       	mov    0x20(%r15,%rcx,8),%rax
    b623:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    b628:	48 83 c1 04          	add    $0x4,%rcx
    b62c:	49 39 cc             	cmp    %rcx,%r12
    b62f:	75 cf                	jne    b600 <fwp_apply+0x370>
    b631:	85 ff                	test   %edi,%edi
    b633:	0f 84 92 00 00 00    	je     b6cb <fwp_apply+0x43b>
    b639:	89 f8                	mov    %edi,%eax
    b63b:	83 ff 14             	cmp    $0x14,%edi
    b63e:	0f 83 99 00 00 00    	jae    b6dd <fwp_apply+0x44d>
    b644:	31 c9                	xor    %ecx,%ecx
    b646:	48 89 c6             	mov    %rax,%rsi
    b649:	48 89 ca             	mov    %rcx,%rdx
    b64c:	48 83 e6 03          	and    $0x3,%rsi
    b650:	74 23                	je     b675 <fwp_apply+0x3e5>
    b652:	48 89 ca             	mov    %rcx,%rdx
    b655:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b65c:	00 00 00 00 
    b660:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    b664:	45 8d 04 14          	lea    (%r12,%rdx,1),%r8d
    b668:	4b 89 7c c6 08       	mov    %rdi,0x8(%r14,%r8,8)
    b66d:	48 ff c2             	inc    %rdx
    b670:	48 ff ce             	dec    %rsi
    b673:	75 eb                	jne    b660 <fwp_apply+0x3d0>
    b675:	48 29 c1             	sub    %rax,%rcx
    b678:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    b67c:	77 4d                	ja     b6cb <fwp_apply+0x43b>
    b67e:	66 90                	xchg   %ax,%ax
    b680:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    b684:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    b688:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    b68d:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    b692:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    b696:	ff c6                	inc    %esi
    b698:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    b69d:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    b6a2:	41 8d 74 14 02       	lea    0x2(%r12,%rdx,1),%esi
    b6a7:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    b6ac:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    b6b1:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    b6b5:	83 c6 03             	add    $0x3,%esi
    b6b8:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    b6bd:	48 83 c2 04          	add    $0x4,%rdx
    b6c1:	48 39 d0             	cmp    %rdx,%rax
    b6c4:	75 ba                	jne    b680 <fwp_apply+0x3f0>
    b6c6:	eb 03                	jmp    b6cb <fwp_apply+0x43b>
    b6c8:	4d 89 fe             	mov    %r15,%r14
    b6cb:	4c 89 f0             	mov    %r14,%rax
    b6ce:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    b6d2:	5b                   	pop    %rbx
    b6d3:	41 5c                	pop    %r12
    b6d5:	41 5d                	pop    %r13
    b6d7:	41 5e                	pop    %r14
    b6d9:	41 5f                	pop    %r15
    b6db:	5d                   	pop    %rbp
    b6dc:	c3                   	ret
    b6dd:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    b6e1:	31 c9                	xor    %ecx,%ecx
    b6e3:	89 d6                	mov    %edx,%esi
    b6e5:	44 01 e6             	add    %r12d,%esi
    b6e8:	0f 82 58 ff ff ff    	jb     b646 <fwp_apply+0x3b6>
    b6ee:	48 c1 ea 20          	shr    $0x20,%rdx
    b6f2:	0f 85 4e ff ff ff    	jne    b646 <fwp_apply+0x3b6>
    b6f8:	4b 8d 0c e6          	lea    (%r14,%r12,8),%rcx
    b6fc:	48 29 d9             	sub    %rbx,%rcx
    b6ff:	48 83 c1 08          	add    $0x8,%rcx
    b703:	48 83 f9 20          	cmp    $0x20,%rcx
    b707:	0f 82 37 ff ff ff    	jb     b644 <fwp_apply+0x3b4>
    b70d:	89 c1                	mov    %eax,%ecx
    b70f:	83 e1 fc             	and    $0xfffffffc,%ecx
    b712:	31 d2                	xor    %edx,%edx
    b714:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b71b:	00 00 00 00 00 
    b720:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    b724:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    b729:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    b72d:	41 0f 11 44 f6 08    	movups %xmm0,0x8(%r14,%rsi,8)
    b733:	41 0f 11 4c f6 18    	movups %xmm1,0x18(%r14,%rsi,8)
    b739:	48 83 c2 04          	add    $0x4,%rdx
    b73d:	48 39 d1             	cmp    %rdx,%rcx
    b740:	75 de                	jne    b720 <fwp_apply+0x490>
    b742:	48 39 c1             	cmp    %rax,%rcx
    b745:	0f 85 fb fe ff ff    	jne    b646 <fwp_apply+0x3b6>
    b74b:	e9 7b ff ff ff       	jmp    b6cb <fwp_apply+0x43b>

000000000000b750 <fwp_pap>:
    b750:	50                   	push   %rax
    b751:	bf 08 00 00 00       	mov    $0x8,%edi
    b756:	e8 35 ab ff ff       	call   6290 <fwp_alloc>
    b75b:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    b762:	59                   	pop    %rcx
    b763:	c3                   	ret
    b764:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b76b:	00 00 00 00 00 

000000000000b770 <fwp_exec_error>:
    b770:	41 57                	push   %r15
    b772:	41 56                	push   %r14
    b774:	53                   	push   %rbx
    b775:	48 89 f3             	mov    %rsi,%rbx
    b778:	49 89 fe             	mov    %rdi,%r14
    b77b:	e8 a0 bb ff ff       	call   7320 <fwp_pipe_flush>
    b780:	4c 8b 3d 51 88 00 00 	mov    0x8851(%rip),%r15        # 13fd8 <stderr@GLIBC_2.2.5>
    b787:	49 8b 3f             	mov    (%r15),%rdi
    b78a:	48 8d 35 a8 3c 00 00 	lea    0x3ca8(%rip),%rsi        # f439 <exec_in_fp0+0xd39>
    b791:	48 8d 15 4f 30 00 00 	lea    0x304f(%rip),%rdx        # e7e7 <exec_in_fp0+0xe7>
    b798:	31 c0                	xor    %eax,%eax
    b79a:	e8 51 7b ff ff       	call   32f0 <fprintf@plt>
    b79f:	83 3b 10             	cmpl   $0x10,(%rbx)
    b7a2:	75 1f                	jne    b7c3 <fwp_exec_error+0x53>
    b7a4:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    b7a8:	48 85 ff             	test   %rdi,%rdi
    b7ab:	74 16                	je     b7c3 <fwp_exec_error+0x53>
    b7ad:	48 8d 35 8a 3c 00 00 	lea    0x3c8a(%rip),%rsi        # f43e <exec_in_fp0+0xd3e>
    b7b4:	e8 17 7b ff ff       	call   32d0 <strcmp@plt>
    b7b9:	85 c0                	test   %eax,%eax
    b7bb:	75 06                	jne    b7c3 <fwp_exec_error+0x53>
    b7bd:	83 7b 10 02          	cmpl   $0x2,0x10(%rbx)
    b7c1:	74 20                	je     b7e3 <fwp_exec_error+0x73>
    b7c3:	49 8b 17             	mov    (%r15),%rdx
    b7c6:	4c 89 f7             	mov    %r14,%rdi
    b7c9:	48 89 de             	mov    %rbx,%rsi
    b7cc:	e8 2f 00 00 00       	call   b800 <fwp_display_top>
    b7d1:	49 8b 37             	mov    (%r15),%rsi
    b7d4:	bf 0a 00 00 00       	mov    $0xa,%edi
    b7d9:	5b                   	pop    %rbx
    b7da:	41 5e                	pop    %r14
    b7dc:	41 5f                	pop    %r15
    b7de:	e9 5d 7a ff ff       	jmp    3240 <fputc@plt>
    b7e3:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    b7e7:	48 8b 17             	mov    (%rdi),%rdx
    b7ea:	48 83 c7 08          	add    $0x8,%rdi
    b7ee:	49 8b 0f             	mov    (%r15),%rcx
    b7f1:	be 01 00 00 00       	mov    $0x1,%esi
    b7f6:	e8 a5 7c ff ff       	call   34a0 <fwrite@plt>
    b7fb:	eb d4                	jmp    b7d1 <fwp_exec_error+0x61>
    b7fd:	0f 1f 00             	nopl   (%rax)

000000000000b800 <fwp_display_top>:
    b800:	53                   	push   %rbx
    b801:	48 83 ec 20          	sub    $0x20,%rsp
    b805:	48 89 d3             	mov    %rdx,%rbx
    b808:	48 89 f2             	mov    %rsi,%rdx
    b80b:	48 89 fe             	mov    %rdi,%rsi
    b80e:	0f 57 c0             	xorps  %xmm0,%xmm0
    b811:	0f 29 04 24          	movaps %xmm0,(%rsp)
    b815:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    b81c:	00 00 
    b81e:	48 89 e7             	mov    %rsp,%rdi
    b821:	b9 01 00 00 00       	mov    $0x1,%ecx
    b826:	e8 35 00 00 00       	call   b860 <fwp_write>
    b82b:	48 8b 3c 24          	mov    (%rsp),%rdi
    b82f:	48 85 ff             	test   %rdi,%rdi
    b832:	74 18                	je     b84c <fwp_display_top+0x4c>
    b834:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    b839:	be 01 00 00 00       	mov    $0x1,%esi
    b83e:	48 89 d9             	mov    %rbx,%rcx
    b841:	e8 5a 7c ff ff       	call   34a0 <fwrite@plt>
    b846:	48 8b 3c 24          	mov    (%rsp),%rdi
    b84a:	eb 02                	jmp    b84e <fwp_display_top+0x4e>
    b84c:	31 ff                	xor    %edi,%edi
    b84e:	e8 fd 77 ff ff       	call   3050 <free@plt>
    b853:	48 83 c4 20          	add    $0x20,%rsp
    b857:	5b                   	pop    %rbx
    b858:	c3                   	ret
    b859:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000b860 <fwp_write>:
    b860:	55                   	push   %rbp
    b861:	41 57                	push   %r15
    b863:	41 56                	push   %r14
    b865:	41 55                	push   %r13
    b867:	41 54                	push   %r12
    b869:	53                   	push   %rbx
    b86a:	48 81 ec 28 02 00 00 	sub    $0x228,%rsp
    b871:	8b 02                	mov    (%rdx),%eax
    b873:	48 83 f8 19          	cmp    $0x19,%rax
    b877:	0f 87 3f 05 00 00    	ja     bdbc <fwp_write+0x55c>
    b87d:	49 89 f5             	mov    %rsi,%r13
    b880:	48 89 fb             	mov    %rdi,%rbx
    b883:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
    b888:	48 8d 15 b5 2a 00 00 	lea    0x2ab5(%rip),%rdx        # e344 <_IO_stdin_used+0x344>
    b88f:	48 63 34 82          	movslq (%rdx,%rax,4),%rsi
    b893:	48 01 d6             	add    %rdx,%rsi
    b896:	ff e6                	jmp    *%rsi
    b898:	48 8d 15 a7 3b 00 00 	lea    0x3ba7(%rip),%rdx        # f446 <exec_in_fp0+0xd46>
    b89f:	eb 07                	jmp    b8a8 <fwp_write+0x48>
    b8a1:	48 8d 15 66 3b 00 00 	lea    0x3b66(%rip),%rdx        # f40e <exec_in_fp0+0xd0e>
    b8a8:	4c 8d 7c 24 20       	lea    0x20(%rsp),%r15
    b8ad:	be 00 02 00 00       	mov    $0x200,%esi
    b8b2:	4c 89 ff             	mov    %r15,%rdi
    b8b5:	4c 89 e9             	mov    %r13,%rcx
    b8b8:	31 c0                	xor    %eax,%eax
    b8ba:	e8 11 79 ff ff       	call   31d0 <snprintf@plt>
    b8bf:	48 89 df             	mov    %rbx,%rdi
    b8c2:	4c 89 fe             	mov    %r15,%rsi
    b8c5:	e9 ed 04 00 00       	jmp    bdb7 <fwp_write+0x557>
    b8ca:	83 f8 13             	cmp    $0x13,%eax
    b8cd:	48 8d 05 a3 3b 00 00 	lea    0x3ba3(%rip),%rax        # f477 <exec_in_fp0+0xd77>
    b8d4:	48 8d 35 a1 3b 00 00 	lea    0x3ba1(%rip),%rsi        # f47c <exec_in_fp0+0xd7c>
    b8db:	48 0f 44 f0          	cmove  %rax,%rsi
    b8df:	48 89 df             	mov    %rbx,%rdi
    b8e2:	e8 09 ca ff ff       	call   82f0 <buf_puts>
    b8e7:	49 83 7d 00 00       	cmpq   $0x0,0x0(%r13)
    b8ec:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    b8f1:	0f 84 cb 00 00 00    	je     b9c2 <fwp_write+0x162>
    b8f7:	4d 89 ec             	mov    %r13,%r12
    b8fa:	48 8b 50 38          	mov    0x38(%rax),%rdx
    b8fe:	48 89 df             	mov    %rbx,%rdi
    b901:	4c 89 eb             	mov    %r13,%rbx
    b904:	49 8b 74 24 08       	mov    0x8(%r12),%rsi
    b909:	49 89 c6             	mov    %rax,%r14
    b90c:	49 89 ff             	mov    %rdi,%r15
    b90f:	31 c9                	xor    %ecx,%ecx
    b911:	e8 4a ff ff ff       	call   b860 <fwp_write>
    b916:	41 83 3e 12          	cmpl   $0x12,(%r14)
    b91a:	75 29                	jne    b945 <fwp_write+0xe5>
    b91c:	48 8d 35 18 3b 00 00 	lea    0x3b18(%rip),%rsi        # f43b <exec_in_fp0+0xd3b>
    b923:	4d 89 fe             	mov    %r15,%r14
    b926:	4c 89 ff             	mov    %r15,%rdi
    b929:	e8 c2 c9 ff ff       	call   82f0 <buf_puts>
    b92e:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    b932:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    b937:	48 8b 50 40          	mov    0x40(%rax),%rdx
    b93b:	4c 89 ff             	mov    %r15,%rdi
    b93e:	31 c9                	xor    %ecx,%ecx
    b940:	e8 1b ff ff ff       	call   b860 <fwp_write>
    b945:	48 83 3b 02          	cmpq   $0x2,(%rbx)
    b949:	4c 89 fb             	mov    %r15,%rbx
    b94c:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    b951:	72 6f                	jb     b9c2 <fwp_write+0x162>
    b953:	4d 8d 74 24 20       	lea    0x20(%r12),%r14
    b958:	bd 01 00 00 00       	mov    $0x1,%ebp
    b95d:	4c 8d 2d 31 3a 00 00 	lea    0x3a31(%rip),%r13        # f395 <exec_in_fp0+0xc95>
    b964:	eb 17                	jmp    b97d <fwp_write+0x11d>
    b966:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    b96d:	00 00 00 
    b970:	48 ff c5             	inc    %rbp
    b973:	49 83 c6 10          	add    $0x10,%r14
    b977:	49 3b 2c 24          	cmp    (%r12),%rbp
    b97b:	73 45                	jae    b9c2 <fwp_write+0x162>
    b97d:	48 89 df             	mov    %rbx,%rdi
    b980:	4c 89 ee             	mov    %r13,%rsi
    b983:	e8 68 c9 ff ff       	call   82f0 <buf_puts>
    b988:	49 8b 76 f8          	mov    -0x8(%r14),%rsi
    b98c:	49 8b 57 38          	mov    0x38(%r15),%rdx
    b990:	48 89 df             	mov    %rbx,%rdi
    b993:	31 c9                	xor    %ecx,%ecx
    b995:	e8 c6 fe ff ff       	call   b860 <fwp_write>
    b99a:	41 83 3f 12          	cmpl   $0x12,(%r15)
    b99e:	75 d0                	jne    b970 <fwp_write+0x110>
    b9a0:	48 89 df             	mov    %rbx,%rdi
    b9a3:	48 8d 35 91 3a 00 00 	lea    0x3a91(%rip),%rsi        # f43b <exec_in_fp0+0xd3b>
    b9aa:	e8 41 c9 ff ff       	call   82f0 <buf_puts>
    b9af:	49 8b 36             	mov    (%r14),%rsi
    b9b2:	49 8b 57 40          	mov    0x40(%r15),%rdx
    b9b6:	48 89 df             	mov    %rbx,%rdi
    b9b9:	31 c9                	xor    %ecx,%ecx
    b9bb:	e8 a0 fe ff ff       	call   b860 <fwp_write>
    b9c0:	eb ae                	jmp    b970 <fwp_write+0x110>
    b9c2:	48 89 df             	mov    %rbx,%rdi
    b9c5:	be 7d 00 00 00       	mov    $0x7d,%esi
    b9ca:	e9 48 05 00 00       	jmp    bf17 <fwp_write+0x6b7>
    b9cf:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    b9d4:	4d 8b 67 08          	mov    0x8(%r15),%r12
    b9d8:	4d 85 e4             	test   %r12,%r12
    b9db:	0f 84 38 04 00 00    	je     be19 <fwp_write+0x5b9>
    b9e1:	48 8d 35 ca 39 00 00 	lea    0x39ca(%rip),%rsi        # f3b2 <exec_in_fp0+0xcb2>
    b9e8:	4c 89 e7             	mov    %r12,%rdi
    b9eb:	e8 e0 78 ff ff       	call   32d0 <strcmp@plt>
    b9f0:	85 c0                	test   %eax,%eax
    b9f2:	0f 84 44 05 00 00    	je     bf3c <fwp_write+0x6dc>
    b9f8:	4d 8d 77 10          	lea    0x10(%r15),%r14
    b9fc:	48 89 df             	mov    %rbx,%rdi
    b9ff:	4c 89 e6             	mov    %r12,%rsi
    ba02:	e8 e9 c8 ff ff       	call   82f0 <buf_puts>
    ba07:	48 89 df             	mov    %rbx,%rdi
    ba0a:	be 20 00 00 00       	mov    $0x20,%esi
    ba0f:	e8 bc c8 ff ff       	call   82d0 <buf_putc>
    ba14:	31 ed                	xor    %ebp,%ebp
    ba16:	e9 1f 04 00 00       	jmp    be3a <fwp_write+0x5da>
    ba1b:	4c 89 ef             	mov    %r13,%rdi
    ba1e:	e8 cd ef ff ff       	call   a9f0 <fwp_tag>
    ba23:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    ba28:	49 8b 4f 18          	mov    0x18(%r15),%rcx
    ba2c:	41 89 c6             	mov    %eax,%r14d
    ba2f:	4a 8b 34 f1          	mov    (%rcx,%r14,8),%rsi
    ba33:	48 89 df             	mov    %rbx,%rdi
    ba36:	e8 b5 c8 ff ff       	call   82f0 <buf_puts>
    ba3b:	49 8b 47 28          	mov    0x28(%r15),%rax
    ba3f:	42 83 3c b0 00       	cmpl   $0x0,(%rax,%r14,4)
    ba44:	0f 8e 72 03 00 00    	jle    bdbc <fwp_write+0x55c>
    ba4a:	4c 89 f1             	mov    %r14,%rcx
    ba4d:	45 31 f6             	xor    %r14d,%r14d
    ba50:	4c 89 6c 24 18       	mov    %r13,0x18(%rsp)
    ba55:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
    ba5a:	eb 3d                	jmp    ba99 <fwp_write+0x239>
    ba5c:	0f 1f 40 00          	nopl   0x0(%rax)
    ba60:	48 89 dd             	mov    %rbx,%rbp
    ba63:	48 89 df             	mov    %rbx,%rdi
    ba66:	4c 89 e6             	mov    %r12,%rsi
    ba69:	4c 89 ea             	mov    %r13,%rdx
    ba6c:	31 c9                	xor    %ecx,%ecx
    ba6e:	e8 ed fd ff ff       	call   b860 <fwp_write>
    ba73:	49 ff c6             	inc    %r14
    ba76:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    ba7b:	49 8b 47 28          	mov    0x28(%r15),%rax
    ba7f:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    ba84:	48 63 04 88          	movslq (%rax,%rcx,4),%rax
    ba88:	49 39 c6             	cmp    %rax,%r14
    ba8b:	4c 8b 6c 24 18       	mov    0x18(%rsp),%r13
    ba90:	48 89 eb             	mov    %rbp,%rbx
    ba93:	0f 8d 23 03 00 00    	jge    bdbc <fwp_write+0x55c>
    ba99:	4f 8b 64 f5 08       	mov    0x8(%r13,%r14,8),%r12
    ba9e:	49 8b 47 30          	mov    0x30(%r15),%rax
    baa2:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    baa6:	4e 8b 2c f0          	mov    (%rax,%r14,8),%r13
    baaa:	48 89 df             	mov    %rbx,%rdi
    baad:	be 20 00 00 00       	mov    $0x20,%esi
    bab2:	e8 19 c8 ff ff       	call   82d0 <buf_putc>
    bab7:	4c 89 e7             	mov    %r12,%rdi
    baba:	4c 89 ee             	mov    %r13,%rsi
    babd:	e8 8e 0e 00 00       	call   c950 <fwp_needs_parens>
    bac2:	85 c0                	test   %eax,%eax
    bac4:	74 9a                	je     ba60 <fwp_write+0x200>
    bac6:	48 89 df             	mov    %rbx,%rdi
    bac9:	be 28 00 00 00       	mov    $0x28,%esi
    bace:	e8 fd c7 ff ff       	call   82d0 <buf_putc>
    bad3:	48 89 df             	mov    %rbx,%rdi
    bad6:	4c 89 e6             	mov    %r12,%rsi
    bad9:	4c 89 ea             	mov    %r13,%rdx
    badc:	31 c9                	xor    %ecx,%ecx
    bade:	e8 7d fd ff ff       	call   b860 <fwp_write>
    bae3:	48 89 dd             	mov    %rbx,%rbp
    bae6:	48 89 df             	mov    %rbx,%rdi
    bae9:	be 29 00 00 00       	mov    $0x29,%esi
    baee:	e8 dd c7 ff ff       	call   82d0 <buf_putc>
    baf3:	e9 7b ff ff ff       	jmp    ba73 <fwp_write+0x213>
    baf8:	4c 89 ef             	mov    %r13,%rdi
    bafb:	e8 c0 87 ff ff       	call   42c0 <fwp_f64>
    bb00:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    bb05:	4c 89 f7             	mov    %r14,%rdi
    bb08:	e8 93 08 00 00       	call   c3a0 <fwp_fmt_f64>
    bb0d:	e9 9f 02 00 00       	jmp    bdb1 <fwp_write+0x551>
    bb12:	48 89 df             	mov    %rbx,%rdi
    bb15:	be 3c 00 00 00       	mov    $0x3c,%esi
    bb1a:	e8 b1 c7 ff ff       	call   82d0 <buf_putc>
    bb1f:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    bb24:	48 8b 70 08          	mov    0x8(%rax),%rsi
    bb28:	48 89 df             	mov    %rbx,%rdi
    bb2b:	e9 d7 02 00 00       	jmp    be07 <fwp_write+0x5a7>
    bb30:	48 8d 35 1f 39 00 00 	lea    0x391f(%rip),%rsi        # f456 <exec_in_fp0+0xd56>
    bb37:	e9 99 02 00 00       	jmp    bdd5 <fwp_write+0x575>
    bb3c:	49 8d 75 08          	lea    0x8(%r13),%rsi
    bb40:	49 8b 55 00          	mov    0x0(%r13),%rdx
    bb44:	48 89 df             	mov    %rbx,%rdi
    bb47:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    bb4e:	85 c9                	test   %ecx,%ecx
    bb50:	0f 84 d7 03 00 00    	je     bf2d <fwp_write+0x6cd>
    bb56:	5b                   	pop    %rbx
    bb57:	41 5c                	pop    %r12
    bb59:	41 5d                	pop    %r13
    bb5b:	41 5e                	pop    %r14
    bb5d:	41 5f                	pop    %r15
    bb5f:	5d                   	pop    %rbp
    bb60:	e9 bb c7 ff ff       	jmp    8320 <buf_put>
    bb65:	4c 89 ef             	mov    %r13,%rdi
    bb68:	e8 33 ee ff ff       	call   a9a0 <fwp_u128>
    bb6d:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    bb72:	4c 89 f7             	mov    %r14,%rdi
    bb75:	48 89 c6             	mov    %rax,%rsi
    bb78:	e8 13 04 00 00       	call   bf90 <fwp_fmt_u128>
    bb7d:	e9 2f 02 00 00       	jmp    bdb1 <fwp_write+0x551>
    bb82:	4c 89 ef             	mov    %r13,%rdi
    bb85:	e8 06 ee ff ff       	call   a990 <fwp_i128>
    bb8a:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    bb8f:	4c 89 f7             	mov    %r14,%rdi
    bb92:	48 89 c6             	mov    %rax,%rsi
    bb95:	e8 d6 03 00 00       	call   bf70 <fwp_fmt_i128>
    bb9a:	e9 12 02 00 00       	jmp    bdb1 <fwp_write+0x551>
    bb9f:	48 89 df             	mov    %rbx,%rdi
    bba2:	be 5b 00 00 00       	mov    $0x5b,%esi
    bba7:	e8 24 c7 ff ff       	call   82d0 <buf_putc>
    bbac:	4d 85 ed             	test   %r13,%r13
    bbaf:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    bbb4:	0f 84 d5 01 00 00    	je     bd8f <fwp_write+0x52f>
    bbba:	49 8b 57 38          	mov    0x38(%r15),%rdx
    bbbe:	49 8b 75 08          	mov    0x8(%r13),%rsi
    bbc2:	48 89 df             	mov    %rbx,%rdi
    bbc5:	31 c9                	xor    %ecx,%ecx
    bbc7:	e8 94 fc ff ff       	call   b860 <fwp_write>
    bbcc:	4d 8b 65 10          	mov    0x10(%r13),%r12
    bbd0:	4d 85 e4             	test   %r12,%r12
    bbd3:	0f 84 b6 01 00 00    	je     bd8f <fwp_write+0x52f>
    bbd9:	4c 8d 35 b5 37 00 00 	lea    0x37b5(%rip),%r14        # f395 <exec_in_fp0+0xc95>
    bbe0:	48 89 df             	mov    %rbx,%rdi
    bbe3:	4c 89 f6             	mov    %r14,%rsi
    bbe6:	e8 05 c7 ff ff       	call   82f0 <buf_puts>
    bbeb:	49 8b 74 24 08       	mov    0x8(%r12),%rsi
    bbf0:	49 8b 57 38          	mov    0x38(%r15),%rdx
    bbf4:	48 89 df             	mov    %rbx,%rdi
    bbf7:	31 c9                	xor    %ecx,%ecx
    bbf9:	e8 62 fc ff ff       	call   b860 <fwp_write>
    bbfe:	4d 8b 64 24 10       	mov    0x10(%r12),%r12
    bc03:	4d 85 e4             	test   %r12,%r12
    bc06:	75 d8                	jne    bbe0 <fwp_write+0x380>
    bc08:	e9 82 01 00 00       	jmp    bd8f <fwp_write+0x52f>
    bc0d:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    bc12:	8b 50 48             	mov    0x48(%rax),%edx
    bc15:	48 89 df             	mov    %rbx,%rdi
    bc18:	4c 89 ee             	mov    %r13,%rsi
    bc1b:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    bc22:	5b                   	pop    %rbx
    bc23:	41 5c                	pop    %r12
    bc25:	41 5d                	pop    %r13
    bc27:	41 5e                	pop    %r14
    bc29:	41 5f                	pop    %r15
    bc2b:	5d                   	pop    %rbp
    bc2c:	e9 2f 08 00 00       	jmp    c460 <fwp_trits>
    bc31:	49 83 fd ff          	cmp    $0xffffffffffffffff,%r13
    bc35:	48 8d 05 65 37 00 00 	lea    0x3765(%rip),%rax        # f3a1 <exec_in_fp0+0xca1>
    bc3c:	48 8d 0d 5a 38 00 00 	lea    0x385a(%rip),%rcx        # f49d <exec_in_fp0+0xd9d>
    bc43:	48 0f 44 c8          	cmove  %rax,%rcx
    bc47:	49 83 fd 01          	cmp    $0x1,%r13
    bc4b:	48 8d 35 4c 37 00 00 	lea    0x374c(%rip),%rsi        # f39e <exec_in_fp0+0xc9e>
    bc52:	48 0f 45 f1          	cmovne %rcx,%rsi
    bc56:	e9 7a 01 00 00       	jmp    bdd5 <fwp_write+0x575>
    bc5b:	48 8d 35 0e 38 00 00 	lea    0x380e(%rip),%rsi        # f470 <exec_in_fp0+0xd70>
    bc62:	48 89 df             	mov    %rbx,%rdi
    bc65:	e8 86 c6 ff ff       	call   82f0 <buf_puts>
    bc6a:	49 83 7d 00 00       	cmpq   $0x0,0x0(%r13)
    bc6f:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    bc74:	0f 84 15 01 00 00    	je     bd8f <fwp_write+0x52f>
    bc7a:	49 8b 57 38          	mov    0x38(%r15),%rdx
    bc7e:	49 8b 75 08          	mov    0x8(%r13),%rsi
    bc82:	48 89 df             	mov    %rbx,%rdi
    bc85:	31 c9                	xor    %ecx,%ecx
    bc87:	e8 d4 fb ff ff       	call   b860 <fwp_write>
    bc8c:	49 83 7d 00 02       	cmpq   $0x2,0x0(%r13)
    bc91:	0f 82 f8 00 00 00    	jb     bd8f <fwp_write+0x52f>
    bc97:	41 be 01 00 00 00    	mov    $0x1,%r14d
    bc9d:	4c 8d 25 f1 36 00 00 	lea    0x36f1(%rip),%r12        # f395 <exec_in_fp0+0xc95>
    bca4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    bcab:	00 00 00 00 00 
    bcb0:	48 89 df             	mov    %rbx,%rdi
    bcb3:	4c 89 e6             	mov    %r12,%rsi
    bcb6:	e8 35 c6 ff ff       	call   82f0 <buf_puts>
    bcbb:	4b 8b 74 f5 08       	mov    0x8(%r13,%r14,8),%rsi
    bcc0:	49 8b 57 38          	mov    0x38(%r15),%rdx
    bcc4:	48 89 df             	mov    %rbx,%rdi
    bcc7:	31 c9                	xor    %ecx,%ecx
    bcc9:	e8 92 fb ff ff       	call   b860 <fwp_write>
    bcce:	49 ff c6             	inc    %r14
    bcd1:	4d 3b 75 00          	cmp    0x0(%r13),%r14
    bcd5:	72 d9                	jb     bcb0 <fwp_write+0x450>
    bcd7:	e9 b3 00 00 00       	jmp    bd8f <fwp_write+0x52f>
    bcdc:	48 8d 35 83 37 00 00 	lea    0x3783(%rip),%rsi        # f466 <exec_in_fp0+0xd66>
    bce3:	48 89 df             	mov    %rbx,%rdi
    bce6:	e8 05 c6 ff ff       	call   82f0 <buf_puts>
    bceb:	49 83 7d 00 00       	cmpq   $0x0,0x0(%r13)
    bcf0:	0f 84 99 00 00 00    	je     bd8f <fwp_write+0x52f>
    bcf6:	4c 89 ed             	mov    %r13,%rbp
    bcf9:	41 0f b6 4d 08       	movzbl 0x8(%r13),%ecx
    bcfe:	48 8d 15 68 37 00 00 	lea    0x3768(%rip),%rdx        # f46d <exec_in_fp0+0xd6d>
    bd05:	4c 8d 7c 24 20       	lea    0x20(%rsp),%r15
    bd0a:	be 00 02 00 00       	mov    $0x200,%esi
    bd0f:	4c 89 ff             	mov    %r15,%rdi
    bd12:	31 c0                	xor    %eax,%eax
    bd14:	e8 b7 74 ff ff       	call   31d0 <snprintf@plt>
    bd19:	48 89 df             	mov    %rbx,%rdi
    bd1c:	4c 89 fe             	mov    %r15,%rsi
    bd1f:	e8 cc c5 ff ff       	call   82f0 <buf_puts>
    bd24:	49 83 7d 00 02       	cmpq   $0x2,0x0(%r13)
    bd29:	72 64                	jb     bd8f <fwp_write+0x52f>
    bd2b:	41 be 09 00 00 00    	mov    $0x9,%r14d
    bd31:	4c 8d 3d 5d 36 00 00 	lea    0x365d(%rip),%r15        # f395 <exec_in_fp0+0xc95>
    bd38:	4c 8d 25 2e 37 00 00 	lea    0x372e(%rip),%r12        # f46d <exec_in_fp0+0xd6d>
    bd3f:	4c 8d 6c 24 20       	lea    0x20(%rsp),%r13
    bd44:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    bd4b:	00 00 00 00 00 
    bd50:	48 89 df             	mov    %rbx,%rdi
    bd53:	4c 89 fe             	mov    %r15,%rsi
    bd56:	e8 95 c5 ff ff       	call   82f0 <buf_puts>
    bd5b:	42 0f b6 4c 35 00    	movzbl 0x0(%rbp,%r14,1),%ecx
    bd61:	be 00 02 00 00       	mov    $0x200,%esi
    bd66:	4c 89 ef             	mov    %r13,%rdi
    bd69:	4c 89 e2             	mov    %r12,%rdx
    bd6c:	31 c0                	xor    %eax,%eax
    bd6e:	e8 5d 74 ff ff       	call   31d0 <snprintf@plt>
    bd73:	48 89 df             	mov    %rbx,%rdi
    bd76:	4c 89 ee             	mov    %r13,%rsi
    bd79:	e8 72 c5 ff ff       	call   82f0 <buf_puts>
    bd7e:	49 8d 46 01          	lea    0x1(%r14),%rax
    bd82:	49 83 c6 f9          	add    $0xfffffffffffffff9,%r14
    bd86:	4c 3b 75 00          	cmp    0x0(%rbp),%r14
    bd8a:	49 89 c6             	mov    %rax,%r14
    bd8d:	72 c1                	jb     bd50 <fwp_write+0x4f0>
    bd8f:	48 89 df             	mov    %rbx,%rdi
    bd92:	be 5d 00 00 00       	mov    $0x5d,%esi
    bd97:	e9 7b 01 00 00       	jmp    bf17 <fwp_write+0x6b7>
    bd9c:	4c 89 ef             	mov    %r13,%rdi
    bd9f:	e8 1c ec ff ff       	call   a9c0 <fwp_f32>
    bda4:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    bda9:	4c 89 f7             	mov    %r14,%rdi
    bdac:	e8 ef 03 00 00       	call   c1a0 <fwp_fmt_f32>
    bdb1:	48 89 df             	mov    %rbx,%rdi
    bdb4:	4c 89 f6             	mov    %r14,%rsi
    bdb7:	e8 34 c5 ff ff       	call   82f0 <buf_puts>
    bdbc:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    bdc3:	5b                   	pop    %rbx
    bdc4:	41 5c                	pop    %r12
    bdc6:	41 5d                	pop    %r13
    bdc8:	41 5e                	pop    %r14
    bdca:	41 5f                	pop    %r15
    bdcc:	5d                   	pop    %rbp
    bdcd:	c3                   	ret
    bdce:	48 8d 35 76 36 00 00 	lea    0x3676(%rip),%rsi        # f44b <exec_in_fp0+0xd4b>
    bdd5:	48 89 df             	mov    %rbx,%rdi
    bdd8:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    bddf:	5b                   	pop    %rbx
    bde0:	41 5c                	pop    %r12
    bde2:	41 5d                	pop    %r13
    bde4:	41 5e                	pop    %r14
    bde6:	41 5f                	pop    %r15
    bde8:	5d                   	pop    %rbp
    bde9:	e9 02 c5 ff ff       	jmp    82f0 <buf_puts>
    bdee:	48 8d 35 6a 36 00 00 	lea    0x366a(%rip),%rsi        # f45f <exec_in_fp0+0xd5f>
    bdf5:	48 89 df             	mov    %rbx,%rdi
    bdf8:	e8 f3 c4 ff ff       	call   82f0 <buf_puts>
    bdfd:	49 83 c5 10          	add    $0x10,%r13
    be01:	48 89 df             	mov    %rbx,%rdi
    be04:	4c 89 ee             	mov    %r13,%rsi
    be07:	e8 e4 c4 ff ff       	call   82f0 <buf_puts>
    be0c:	48 89 df             	mov    %rbx,%rdi
    be0f:	be 3e 00 00 00       	mov    $0x3e,%esi
    be14:	e9 fe 00 00 00       	jmp    bf17 <fwp_write+0x6b7>
    be19:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    be1e:	0f 84 35 01 00 00    	je     bf59 <fwp_write+0x6f9>
    be24:	4d 8d 77 10          	lea    0x10(%r15),%r14
    be28:	4d 85 e4             	test   %r12,%r12
    be2b:	0f 94 c0             	sete   %al
    be2e:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
    be33:	40 0f 95 c5          	setne  %bpl
    be37:	40 20 c5             	and    %al,%bpl
    be3a:	40 84 ed             	test   %bpl,%bpl
    be3d:	b8 28 00 00 00       	mov    $0x28,%eax
    be42:	be 7b 00 00 00       	mov    $0x7b,%esi
    be47:	0f 45 f0             	cmovne %eax,%esi
    be4a:	48 89 df             	mov    %rbx,%rdi
    be4d:	e8 7e c4 ff ff       	call   82d0 <buf_putc>
    be52:	41 83 3e 00          	cmpl   $0x0,(%r14)
    be56:	0f 8e a8 00 00 00    	jle    bf04 <fwp_write+0x6a4>
    be5c:	40 84 ed             	test   %bpl,%bpl
    be5f:	75 1e                	jne    be7f <fwp_write+0x61f>
    be61:	49 8b 47 18          	mov    0x18(%r15),%rax
    be65:	48 8b 30             	mov    (%rax),%rsi
    be68:	48 89 df             	mov    %rbx,%rdi
    be6b:	e8 80 c4 ff ff       	call   82f0 <buf_puts>
    be70:	48 8d 35 0d 36 00 00 	lea    0x360d(%rip),%rsi        # f484 <exec_in_fp0+0xd84>
    be77:	48 89 df             	mov    %rbx,%rdi
    be7a:	e8 71 c4 ff ff       	call   82f0 <buf_puts>
    be7f:	49 8b 75 08          	mov    0x8(%r13),%rsi
    be83:	49 8b 47 20          	mov    0x20(%r15),%rax
    be87:	48 8b 10             	mov    (%rax),%rdx
    be8a:	48 89 df             	mov    %rbx,%rdi
    be8d:	31 c9                	xor    %ecx,%ecx
    be8f:	e8 cc f9 ff ff       	call   b860 <fwp_write>
    be94:	41 83 7f 10 02       	cmpl   $0x2,0x10(%r15)
    be99:	7c 69                	jl     bf04 <fwp_write+0x6a4>
    be9b:	41 be 01 00 00 00    	mov    $0x1,%r14d
    bea1:	4c 8d 25 ed 34 00 00 	lea    0x34ed(%rip),%r12        # f395 <exec_in_fp0+0xc95>
    bea8:	eb 29                	jmp    bed3 <fwp_write+0x673>
    beaa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    beb0:	4b 8b 74 f5 08       	mov    0x8(%r13,%r14,8),%rsi
    beb5:	49 8b 47 20          	mov    0x20(%r15),%rax
    beb9:	4a 8b 14 f0          	mov    (%rax,%r14,8),%rdx
    bebd:	48 89 df             	mov    %rbx,%rdi
    bec0:	31 c9                	xor    %ecx,%ecx
    bec2:	e8 99 f9 ff ff       	call   b860 <fwp_write>
    bec7:	49 ff c6             	inc    %r14
    beca:	49 63 47 10          	movslq 0x10(%r15),%rax
    bece:	49 39 c6             	cmp    %rax,%r14
    bed1:	7d 31                	jge    bf04 <fwp_write+0x6a4>
    bed3:	48 89 df             	mov    %rbx,%rdi
    bed6:	4c 89 e6             	mov    %r12,%rsi
    bed9:	e8 12 c4 ff ff       	call   82f0 <buf_puts>
    bede:	40 84 ed             	test   %bpl,%bpl
    bee1:	75 cd                	jne    beb0 <fwp_write+0x650>
    bee3:	49 8b 47 18          	mov    0x18(%r15),%rax
    bee7:	4a 8b 34 f0          	mov    (%rax,%r14,8),%rsi
    beeb:	48 89 df             	mov    %rbx,%rdi
    beee:	e8 fd c3 ff ff       	call   82f0 <buf_puts>
    bef3:	48 89 df             	mov    %rbx,%rdi
    bef6:	48 8d 35 87 35 00 00 	lea    0x3587(%rip),%rsi        # f484 <exec_in_fp0+0xd84>
    befd:	e8 ee c3 ff ff       	call   82f0 <buf_puts>
    bf02:	eb ac                	jmp    beb0 <fwp_write+0x650>
    bf04:	40 84 ed             	test   %bpl,%bpl
    bf07:	b8 29 00 00 00       	mov    $0x29,%eax
    bf0c:	be 7d 00 00 00       	mov    $0x7d,%esi
    bf11:	0f 45 f0             	cmovne %eax,%esi
    bf14:	48 89 df             	mov    %rbx,%rdi
    bf17:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    bf1e:	5b                   	pop    %rbx
    bf1f:	41 5c                	pop    %r12
    bf21:	41 5d                	pop    %r13
    bf23:	41 5e                	pop    %r14
    bf25:	41 5f                	pop    %r15
    bf27:	5d                   	pop    %rbp
    bf28:	e9 a3 c3 ff ff       	jmp    82d0 <buf_putc>
    bf2d:	5b                   	pop    %rbx
    bf2e:	41 5c                	pop    %r12
    bf30:	41 5d                	pop    %r13
    bf32:	41 5e                	pop    %r14
    bf34:	41 5f                	pop    %r15
    bf36:	5d                   	pop    %rbp
    bf37:	e9 14 06 00 00       	jmp    c550 <fwp_escape>
    bf3c:	49 8b 75 08          	mov    0x8(%r13),%rsi
    bf40:	48 89 f2             	mov    %rsi,%rdx
    bf43:	48 c1 fa 3f          	sar    $0x3f,%rdx
    bf47:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    bf4c:	4c 89 f7             	mov    %r14,%rdi
    bf4f:	e8 0c 07 00 00       	call   c660 <fwp_fmt_duration>
    bf54:	e9 58 fe ff ff       	jmp    bdb1 <fwp_write+0x551>
    bf59:	48 8d 35 21 35 00 00 	lea    0x3521(%rip),%rsi        # f481 <exec_in_fp0+0xd81>
    bf60:	e9 70 fe ff ff       	jmp    bdd5 <fwp_write+0x575>
    bf65:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    bf6c:	00 00 00 00 

000000000000bf70 <fwp_fmt_i128>:
    bf70:	48 85 d2             	test   %rdx,%rdx
    bf73:	79 1b                	jns    bf90 <fwp_fmt_u128>
    bf75:	c6 07 2d             	movb   $0x2d,(%rdi)
    bf78:	48 ff c7             	inc    %rdi
    bf7b:	31 c0                	xor    %eax,%eax
    bf7d:	48 f7 de             	neg    %rsi
    bf80:	48 19 d0             	sbb    %rdx,%rax
    bf83:	48 89 c2             	mov    %rax,%rdx
    bf86:	eb 08                	jmp    bf90 <fwp_fmt_u128>
    bf88:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    bf8f:	00 

000000000000bf90 <fwp_fmt_u128>:
    bf90:	41 56                	push   %r14
    bf92:	53                   	push   %rbx
    bf93:	48 89 f0             	mov    %rsi,%rax
    bf96:	48 09 d0             	or     %rdx,%rax
    bf99:	0f 84 9d 00 00 00    	je     c03c <fwp_fmt_u128+0xac>
    bf9f:	48 89 d1             	mov    %rdx,%rcx
    bfa2:	45 31 d2             	xor    %r10d,%r10d
    bfa5:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    bfac:	cc cc cc 
    bfaf:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
    bfb6:	cc cc cc 
    bfb9:	49 89 d6             	mov    %rdx,%r14
    bfbc:	0f 1f 40 00          	nopl   0x0(%rax)
    bfc0:	49 89 c8             	mov    %rcx,%r8
    bfc3:	49 0f a4 f0 3f       	shld   $0x3f,%rsi,%r8
    bfc8:	49 d1 ee             	shr    $1,%r14
    bfcb:	4d 89 c1             	mov    %r8,%r9
    bfce:	4d 01 f1             	add    %r14,%r9
    bfd1:	49 83 d1 00          	adc    $0x0,%r9
    bfd5:	4c 89 c8             	mov    %r9,%rax
    bfd8:	49 f7 e3             	mul    %r11
    bfdb:	48 c1 ea 02          	shr    $0x2,%rdx
    bfdf:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    bfe3:	49 29 c1             	sub    %rax,%r9
    bfe6:	4d 29 c8             	sub    %r9,%r8
    bfe9:	49 83 de 00          	sbb    $0x0,%r14
    bfed:	4d 89 c1             	mov    %r8,%r9
    bff0:	4c 0f af cb          	imul   %rbx,%r9
    bff4:	4c 89 c0             	mov    %r8,%rax
    bff7:	49 f7 e3             	mul    %r11
    bffa:	4c 01 ca             	add    %r9,%rdx
    bffd:	4d 0f af f3          	imul   %r11,%r14
    c001:	49 01 d6             	add    %rdx,%r14
    c004:	48 89 c2             	mov    %rax,%rdx
    c007:	48 01 c2             	add    %rax,%rdx
    c00a:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
    c00e:	41 89 f0             	mov    %esi,%r8d
    c011:	41 29 d0             	sub    %edx,%r8d
    c014:	41 80 c8 30          	or     $0x30,%r8b
    c018:	46 88 44 14 b8       	mov    %r8b,-0x48(%rsp,%r10,1)
    c01d:	49 ff c2             	inc    %r10
    c020:	48 83 fe 0a          	cmp    $0xa,%rsi
    c024:	48 83 d9 00          	sbb    $0x0,%rcx
    c028:	48 89 c6             	mov    %rax,%rsi
    c02b:	4c 89 f1             	mov    %r14,%rcx
    c02e:	73 90                	jae    bfc0 <fwp_fmt_u128+0x30>
    c030:	45 85 d2             	test   %r10d,%r10d
    c033:	7f 12                	jg     c047 <fwp_fmt_u128+0xb7>
    c035:	31 c0                	xor    %eax,%eax
    c037:	e9 56 01 00 00       	jmp    c192 <fwp_fmt_u128+0x202>
    c03c:	c6 44 24 b8 30       	movb   $0x30,-0x48(%rsp)
    c041:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    c047:	44 89 d0             	mov    %r10d,%eax
    c04a:	41 83 fa 08          	cmp    $0x8,%r10d
    c04e:	73 0a                	jae    c05a <fwp_fmt_u128+0xca>
    c050:	31 c9                	xor    %ecx,%ecx
    c052:	48 89 c2             	mov    %rax,%rdx
    c055:	e9 10 01 00 00       	jmp    c16a <fwp_fmt_u128+0x1da>
    c05a:	83 f8 20             	cmp    $0x20,%eax
    c05d:	73 07                	jae    c066 <fwp_fmt_u128+0xd6>
    c05f:	31 c9                	xor    %ecx,%ecx
    c061:	e9 a4 00 00 00       	jmp    c10a <fwp_fmt_u128+0x17a>
    c066:	89 c1                	mov    %eax,%ecx
    c068:	81 e1 e0 ff ff 7f    	and    $0x7fffffe0,%ecx
    c06e:	48 8d 54 24 b8       	lea    -0x48(%rsp),%rdx
    c073:	48 01 c2             	add    %rax,%rdx
    c076:	48 83 c2 f0          	add    $0xfffffffffffffff0,%rdx
    c07a:	31 f6                	xor    %esi,%esi
    c07c:	66 0f ef c0          	pxor   %xmm0,%xmm0
    c080:	f3 0f 6f 4a f0       	movdqu -0x10(%rdx),%xmm1
    c085:	f3 0f 6f 12          	movdqu (%rdx),%xmm2
    c089:	66 0f 6f da          	movdqa %xmm2,%xmm3
    c08d:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    c091:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    c096:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    c09b:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    c0a0:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    c0a4:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    c0a9:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    c0ae:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    c0b3:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    c0b7:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    c0bb:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    c0bf:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    c0c4:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    c0c9:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    c0ce:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    c0d2:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    c0d7:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    c0dc:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    c0e1:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    c0e5:	f3 0f 7f 14 37       	movdqu %xmm2,(%rdi,%rsi,1)
    c0ea:	f3 0f 7f 4c 37 10    	movdqu %xmm1,0x10(%rdi,%rsi,1)
    c0f0:	48 83 c6 20          	add    $0x20,%rsi
    c0f4:	48 83 c2 e0          	add    $0xffffffffffffffe0,%rdx
    c0f8:	48 39 f1             	cmp    %rsi,%rcx
    c0fb:	75 83                	jne    c080 <fwp_fmt_u128+0xf0>
    c0fd:	48 39 c1             	cmp    %rax,%rcx
    c100:	0f 84 8c 00 00 00    	je     c192 <fwp_fmt_u128+0x202>
    c106:	a8 18                	test   $0x18,%al
    c108:	74 5b                	je     c165 <fwp_fmt_u128+0x1d5>
    c10a:	48 89 ce             	mov    %rcx,%rsi
    c10d:	89 c1                	mov    %eax,%ecx
    c10f:	81 e1 f8 ff ff 7f    	and    $0x7ffffff8,%ecx
    c115:	89 c2                	mov    %eax,%edx
    c117:	83 e2 07             	and    $0x7,%edx
    c11a:	49 89 c0             	mov    %rax,%r8
    c11d:	49 29 f0             	sub    %rsi,%r8
    c120:	49 01 e0             	add    %rsp,%r8
    c123:	49 83 c0 b0          	add    $0xffffffffffffffb0,%r8
    c127:	66 0f ef c0          	pxor   %xmm0,%xmm0
    c12b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    c130:	f3 41 0f 7e 08       	movq   (%r8),%xmm1
    c135:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    c139:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    c13e:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    c143:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    c148:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    c14c:	66 0f d6 0c 37       	movq   %xmm1,(%rdi,%rsi,1)
    c151:	48 83 c6 08          	add    $0x8,%rsi
    c155:	49 83 c0 f8          	add    $0xfffffffffffffff8,%r8
    c159:	48 39 f1             	cmp    %rsi,%rcx
    c15c:	75 d2                	jne    c130 <fwp_fmt_u128+0x1a0>
    c15e:	48 39 c1             	cmp    %rax,%rcx
    c161:	75 07                	jne    c16a <fwp_fmt_u128+0x1da>
    c163:	eb 2d                	jmp    c192 <fwp_fmt_u128+0x202>
    c165:	89 c2                	mov    %eax,%edx
    c167:	83 e2 1f             	and    $0x1f,%edx
    c16a:	48 8d 74 24 b8       	lea    -0x48(%rsp),%rsi
    c16f:	48 01 f2             	add    %rsi,%rdx
    c172:	48 ff ca             	dec    %rdx
    c175:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    c17c:	00 00 00 00 
    c180:	0f b6 32             	movzbl (%rdx),%esi
    c183:	40 88 34 0f          	mov    %sil,(%rdi,%rcx,1)
    c187:	48 ff c1             	inc    %rcx
    c18a:	48 ff ca             	dec    %rdx
    c18d:	48 39 c8             	cmp    %rcx,%rax
    c190:	75 ee                	jne    c180 <fwp_fmt_u128+0x1f0>
    c192:	c6 04 07 00          	movb   $0x0,(%rdi,%rax,1)
    c196:	5b                   	pop    %rbx
    c197:	41 5e                	pop    %r14
    c199:	c3                   	ret
    c19a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000c1a0 <fwp_fmt_f32>:
    c1a0:	53                   	push   %rbx
    c1a1:	48 83 ec 20          	sub    $0x20,%rsp
    c1a5:	48 89 fb             	mov    %rdi,%rbx
    c1a8:	0f 2e c0             	ucomiss %xmm0,%xmm0
    c1ab:	0f 8a d8 01 00 00    	jp     c389 <fwp_fmt_f32+0x1e9>
    c1b1:	0f 28 c8             	movaps %xmm0,%xmm1
    c1b4:	0f 28 05 45 1f 00 00 	movaps 0x1f45(%rip),%xmm0        # e100 <_IO_stdin_used+0x100>
    c1bb:	0f 54 c1             	andps  %xmm1,%xmm0
    c1be:	0f 2e 05 3f 1e 00 00 	ucomiss 0x1e3f(%rip),%xmm0        # e004 <_IO_stdin_used+0x4>
    c1c5:	72 25                	jb     c1ec <fwp_fmt_f32+0x4c>
    c1c7:	0f 57 c0             	xorps  %xmm0,%xmm0
    c1ca:	0f 2e c8             	ucomiss %xmm0,%xmm1
    c1cd:	48 8d 05 f7 31 00 00 	lea    0x31f7(%rip),%rax        # f3cb <exec_in_fp0+0xccb>
    c1d4:	48 8d 35 ef 31 00 00 	lea    0x31ef(%rip),%rsi        # f3ca <exec_in_fp0+0xcca>
    c1db:	48 0f 47 f0          	cmova  %rax,%rsi
    c1df:	48 89 df             	mov    %rbx,%rdi
    c1e2:	48 83 c4 20          	add    $0x20,%rsp
    c1e6:	5b                   	pop    %rbx
    c1e7:	e9 c4 6e ff ff       	jmp    30b0 <strcpy@plt>
    c1ec:	0f 57 c0             	xorps  %xmm0,%xmm0
    c1ef:	f3 0f 5a c1          	cvtss2sd %xmm1,%xmm0
    c1f3:	48 89 df             	mov    %rbx,%rdi
    c1f6:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    c1fc:	be 01 00 00 00       	mov    $0x1,%esi
    c201:	0f 29 4c 24 10       	movaps %xmm1,0x10(%rsp)
    c206:	e8 95 07 00 00       	call   c9a0 <fwp_format_g>
    c20b:	48 89 df             	mov    %rbx,%rdi
    c20e:	31 f6                	xor    %esi,%esi
    c210:	e8 eb 6f ff ff       	call   3200 <strtof@plt>
    c215:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    c21a:	75 06                	jne    c222 <fwp_fmt_f32+0x82>
    c21c:	0f 8b 5a 01 00 00    	jnp    c37c <fwp_fmt_f32+0x1dc>
    c222:	48 89 df             	mov    %rbx,%rdi
    c225:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    c22b:	be 02 00 00 00       	mov    $0x2,%esi
    c230:	e8 6b 07 00 00       	call   c9a0 <fwp_format_g>
    c235:	48 89 df             	mov    %rbx,%rdi
    c238:	31 f6                	xor    %esi,%esi
    c23a:	e8 c1 6f ff ff       	call   3200 <strtof@plt>
    c23f:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    c244:	75 06                	jne    c24c <fwp_fmt_f32+0xac>
    c246:	0f 8b 30 01 00 00    	jnp    c37c <fwp_fmt_f32+0x1dc>
    c24c:	48 89 df             	mov    %rbx,%rdi
    c24f:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    c255:	be 03 00 00 00       	mov    $0x3,%esi
    c25a:	e8 41 07 00 00       	call   c9a0 <fwp_format_g>
    c25f:	48 89 df             	mov    %rbx,%rdi
    c262:	31 f6                	xor    %esi,%esi
    c264:	e8 97 6f ff ff       	call   3200 <strtof@plt>
    c269:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    c26e:	75 06                	jne    c276 <fwp_fmt_f32+0xd6>
    c270:	0f 8b 06 01 00 00    	jnp    c37c <fwp_fmt_f32+0x1dc>
    c276:	48 89 df             	mov    %rbx,%rdi
    c279:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    c27f:	be 04 00 00 00       	mov    $0x4,%esi
    c284:	e8 17 07 00 00       	call   c9a0 <fwp_format_g>
    c289:	48 89 df             	mov    %rbx,%rdi
    c28c:	31 f6                	xor    %esi,%esi
    c28e:	e8 6d 6f ff ff       	call   3200 <strtof@plt>
    c293:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    c298:	75 06                	jne    c2a0 <fwp_fmt_f32+0x100>
    c29a:	0f 8b dc 00 00 00    	jnp    c37c <fwp_fmt_f32+0x1dc>
    c2a0:	48 89 df             	mov    %rbx,%rdi
    c2a3:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    c2a9:	be 05 00 00 00       	mov    $0x5,%esi
    c2ae:	e8 ed 06 00 00       	call   c9a0 <fwp_format_g>
    c2b3:	48 89 df             	mov    %rbx,%rdi
    c2b6:	31 f6                	xor    %esi,%esi
    c2b8:	e8 43 6f ff ff       	call   3200 <strtof@plt>
    c2bd:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    c2c2:	75 06                	jne    c2ca <fwp_fmt_f32+0x12a>
    c2c4:	0f 8b b2 00 00 00    	jnp    c37c <fwp_fmt_f32+0x1dc>
    c2ca:	48 89 df             	mov    %rbx,%rdi
    c2cd:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    c2d3:	be 06 00 00 00       	mov    $0x6,%esi
    c2d8:	e8 c3 06 00 00       	call   c9a0 <fwp_format_g>
    c2dd:	48 89 df             	mov    %rbx,%rdi
    c2e0:	31 f6                	xor    %esi,%esi
    c2e2:	e8 19 6f ff ff       	call   3200 <strtof@plt>
    c2e7:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    c2ec:	75 06                	jne    c2f4 <fwp_fmt_f32+0x154>
    c2ee:	0f 8b 88 00 00 00    	jnp    c37c <fwp_fmt_f32+0x1dc>
    c2f4:	48 89 df             	mov    %rbx,%rdi
    c2f7:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    c2fd:	be 07 00 00 00       	mov    $0x7,%esi
    c302:	e8 99 06 00 00       	call   c9a0 <fwp_format_g>
    c307:	48 89 df             	mov    %rbx,%rdi
    c30a:	31 f6                	xor    %esi,%esi
    c30c:	e8 ef 6e ff ff       	call   3200 <strtof@plt>
    c311:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    c316:	75 02                	jne    c31a <fwp_fmt_f32+0x17a>
    c318:	7b 62                	jnp    c37c <fwp_fmt_f32+0x1dc>
    c31a:	48 89 df             	mov    %rbx,%rdi
    c31d:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    c323:	be 08 00 00 00       	mov    $0x8,%esi
    c328:	e8 73 06 00 00       	call   c9a0 <fwp_format_g>
    c32d:	48 89 df             	mov    %rbx,%rdi
    c330:	31 f6                	xor    %esi,%esi
    c332:	e8 c9 6e ff ff       	call   3200 <strtof@plt>
    c337:	0f 28 4c 24 10       	movaps 0x10(%rsp),%xmm1
    c33c:	0f 2e c1             	ucomiss %xmm1,%xmm0
    c33f:	75 02                	jne    c343 <fwp_fmt_f32+0x1a3>
    c341:	7b 39                	jnp    c37c <fwp_fmt_f32+0x1dc>
    c343:	48 89 df             	mov    %rbx,%rdi
    c346:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    c34c:	be 09 00 00 00       	mov    $0x9,%esi
    c351:	e8 4a 06 00 00       	call   c9a0 <fwp_format_g>
    c356:	48 89 df             	mov    %rbx,%rdi
    c359:	31 f6                	xor    %esi,%esi
    c35b:	e8 a0 6e ff ff       	call   3200 <strtof@plt>
    c360:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    c365:	75 02                	jne    c369 <fwp_fmt_f32+0x1c9>
    c367:	7b 13                	jnp    c37c <fwp_fmt_f32+0x1dc>
    c369:	48 89 df             	mov    %rbx,%rdi
    c36c:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    c372:	be 09 00 00 00       	mov    $0x9,%esi
    c377:	e8 24 06 00 00       	call   c9a0 <fwp_format_g>
    c37c:	48 89 df             	mov    %rbx,%rdi
    c37f:	48 83 c4 20          	add    $0x20,%rsp
    c383:	5b                   	pop    %rbx
    c384:	e9 97 07 00 00       	jmp    cb20 <fwp_finish_float>
    c389:	c7 03 4e 61 4e 00    	movl   $0x4e614e,(%rbx)
    c38f:	48 83 c4 20          	add    $0x20,%rsp
    c393:	5b                   	pop    %rbx
    c394:	c3                   	ret
    c395:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    c39c:	00 00 00 00 

000000000000c3a0 <fwp_fmt_f64>:
    c3a0:	55                   	push   %rbp
    c3a1:	53                   	push   %rbx
    c3a2:	48 83 ec 18          	sub    $0x18,%rsp
    c3a6:	48 89 fb             	mov    %rdi,%rbx
    c3a9:	66 0f 2e c0          	ucomisd %xmm0,%xmm0
    c3ad:	0f 8a 98 00 00 00    	jp     c44b <fwp_fmt_f64+0xab>
    c3b3:	66 0f 28 c8          	movapd %xmm0,%xmm1
    c3b7:	66 0f 28 05 51 1d 00 	movapd 0x1d51(%rip),%xmm0        # e110 <_IO_stdin_used+0x110>
    c3be:	00 
    c3bf:	66 0f 54 c1          	andpd  %xmm1,%xmm0
    c3c3:	66 0f 2e 05 95 1d 00 	ucomisd 0x1d95(%rip),%xmm0        # e160 <_IO_stdin_used+0x160>
    c3ca:	00 
    c3cb:	72 28                	jb     c3f5 <fwp_fmt_f64+0x55>
    c3cd:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    c3d1:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
    c3d5:	48 8d 05 ef 2f 00 00 	lea    0x2fef(%rip),%rax        # f3cb <exec_in_fp0+0xccb>
    c3dc:	48 8d 35 e7 2f 00 00 	lea    0x2fe7(%rip),%rsi        # f3ca <exec_in_fp0+0xcca>
    c3e3:	48 0f 47 f0          	cmova  %rax,%rsi
    c3e7:	48 89 df             	mov    %rbx,%rdi
    c3ea:	48 83 c4 18          	add    $0x18,%rsp
    c3ee:	5b                   	pop    %rbx
    c3ef:	5d                   	pop    %rbp
    c3f0:	e9 bb 6c ff ff       	jmp    30b0 <strcpy@plt>
    c3f5:	bd 01 00 00 00       	mov    $0x1,%ebp
    c3fa:	66 0f 29 0c 24       	movapd %xmm1,(%rsp)
    c3ff:	90                   	nop
    c400:	48 89 df             	mov    %rbx,%rdi
    c403:	66 0f 28 c1          	movapd %xmm1,%xmm0
    c407:	89 ee                	mov    %ebp,%esi
    c409:	e8 92 05 00 00       	call   c9a0 <fwp_format_g>
    c40e:	48 89 df             	mov    %rbx,%rdi
    c411:	31 f6                	xor    %esi,%esi
    c413:	e8 e8 6c ff ff       	call   3100 <strtod@plt>
    c418:	66 0f 28 0c 24       	movapd (%rsp),%xmm1
    c41d:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
    c421:	75 02                	jne    c425 <fwp_fmt_f64+0x85>
    c423:	7b 18                	jnp    c43d <fwp_fmt_f64+0x9d>
    c425:	ff c5                	inc    %ebp
    c427:	83 fd 12             	cmp    $0x12,%ebp
    c42a:	75 d4                	jne    c400 <fwp_fmt_f64+0x60>
    c42c:	48 89 df             	mov    %rbx,%rdi
    c42f:	66 0f 28 c1          	movapd %xmm1,%xmm0
    c433:	be 11 00 00 00       	mov    $0x11,%esi
    c438:	e8 63 05 00 00       	call   c9a0 <fwp_format_g>
    c43d:	48 89 df             	mov    %rbx,%rdi
    c440:	48 83 c4 18          	add    $0x18,%rsp
    c444:	5b                   	pop    %rbx
    c445:	5d                   	pop    %rbp
    c446:	e9 d5 06 00 00       	jmp    cb20 <fwp_finish_float>
    c44b:	c7 03 4e 61 4e 00    	movl   $0x4e614e,(%rbx)
    c451:	48 83 c4 18          	add    $0x18,%rsp
    c455:	5b                   	pop    %rbx
    c456:	5d                   	pop    %rbp
    c457:	c3                   	ret
    c458:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c45f:	00 

000000000000c460 <fwp_trits>:
    c460:	55                   	push   %rbp
    c461:	41 57                	push   %r15
    c463:	41 56                	push   %r14
    c465:	53                   	push   %rbx
    c466:	50                   	push   %rax
    c467:	89 d5                	mov    %edx,%ebp
    c469:	49 89 f6             	mov    %rsi,%r14
    c46c:	48 89 fb             	mov    %rdi,%rbx
    c46f:	4c 63 fa             	movslq %edx,%r15
    c472:	49 8d 7f 03          	lea    0x3(%r15),%rdi
    c476:	e8 75 aa ff ff       	call   6ef0 <fwp_alloc_leaf>
    c47b:	48 89 c6             	mov    %rax,%rsi
    c47e:	66 c7 00 30 74       	movw   $0x7430,(%rax)
    c483:	45 85 ff             	test   %r15d,%r15d
    c486:	0f 8e 9f 00 00 00    	jle    c52b <fwp_trits+0xcb>
    c48c:	89 e9                	mov    %ebp,%ecx
    c48e:	48 8d 3c 31          	lea    (%rcx,%rsi,1),%rdi
    c492:	48 ff c7             	inc    %rdi
    c495:	48 f7 d9             	neg    %rcx
    c498:	45 31 c0             	xor    %r8d,%r8d
    c49b:	49 b9 56 55 55 55 55 	movabs $0x5555555555555556,%r9
    c4a2:	55 55 55 
    c4a5:	eb 35                	jmp    c4dc <fwp_trits+0x7c>
    c4a7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    c4ae:	00 00 
    c4b0:	41 b3 30             	mov    $0x30,%r11b
    c4b3:	46 88 1c 07          	mov    %r11b,(%rdi,%r8,1)
    c4b7:	48 85 d2             	test   %rdx,%rdx
    c4ba:	0f 95 c2             	setne  %dl
    c4bd:	4d 85 f6             	test   %r14,%r14
    c4c0:	41 0f 98 c3          	sets   %r11b
    c4c4:	41 20 d3             	and    %dl,%r11b
    c4c7:	41 0f b6 d3          	movzbl %r11b,%edx
    c4cb:	48 29 d0             	sub    %rdx,%rax
    c4ce:	4c 01 d0             	add    %r10,%rax
    c4d1:	49 ff c8             	dec    %r8
    c4d4:	49 89 c6             	mov    %rax,%r14
    c4d7:	4c 39 c1             	cmp    %r8,%rcx
    c4da:	74 4f                	je     c52b <fwp_trits+0xcb>
    c4dc:	4c 89 f0             	mov    %r14,%rax
    c4df:	49 f7 e9             	imul   %r9
    c4e2:	48 89 d0             	mov    %rdx,%rax
    c4e5:	48 c1 e8 3f          	shr    $0x3f,%rax
    c4e9:	48 01 d0             	add    %rdx,%rax
    c4ec:	4c 8d 14 40          	lea    (%rax,%rax,2),%r10
    c4f0:	4c 89 f2             	mov    %r14,%rdx
    c4f3:	4c 29 d2             	sub    %r10,%rdx
    c4f6:	49 f7 da             	neg    %r10
    c4f9:	4d 01 f2             	add    %r14,%r10
    c4fc:	49 83 c2 03          	add    $0x3,%r10
    c500:	48 83 fa fd          	cmp    $0xfffffffffffffffd,%rdx
    c504:	4c 0f 42 d2          	cmovb  %rdx,%r10
    c508:	4d 85 d2             	test   %r10,%r10
    c50b:	74 a3                	je     c4b0 <fwp_trits+0x50>
    c50d:	49 83 fa 01          	cmp    $0x1,%r10
    c511:	75 0d                	jne    c520 <fwp_trits+0xc0>
    c513:	41 b3 2b             	mov    $0x2b,%r11b
    c516:	45 31 d2             	xor    %r10d,%r10d
    c519:	eb 98                	jmp    c4b3 <fwp_trits+0x53>
    c51b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    c520:	41 b3 2d             	mov    $0x2d,%r11b
    c523:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    c529:	eb 88                	jmp    c4b3 <fwp_trits+0x53>
    c52b:	42 c6 44 3e 02 00    	movb   $0x0,0x2(%rsi,%r15,1)
    c531:	48 89 df             	mov    %rbx,%rdi
    c534:	48 83 c4 08          	add    $0x8,%rsp
    c538:	5b                   	pop    %rbx
    c539:	41 5e                	pop    %r14
    c53b:	41 5f                	pop    %r15
    c53d:	5d                   	pop    %rbp
    c53e:	e9 ad bd ff ff       	jmp    82f0 <buf_puts>
    c543:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c54a:	84 00 00 00 00 00 

000000000000c550 <fwp_escape>:
    c550:	55                   	push   %rbp
    c551:	41 57                	push   %r15
    c553:	41 56                	push   %r14
    c555:	41 55                	push   %r13
    c557:	41 54                	push   %r12
    c559:	53                   	push   %rbx
    c55a:	48 83 ec 18          	sub    $0x18,%rsp
    c55e:	48 89 d3             	mov    %rdx,%rbx
    c561:	49 89 f7             	mov    %rsi,%r15
    c564:	49 89 fe             	mov    %rdi,%r14
    c567:	be 22 00 00 00       	mov    $0x22,%esi
    c56c:	e8 5f bd ff ff       	call   82d0 <buf_putc>
    c571:	48 85 db             	test   %rbx,%rbx
    c574:	0f 84 c7 00 00 00    	je     c641 <fwp_escape+0xf1>
    c57a:	48 89 e5             	mov    %rsp,%rbp
    c57d:	4c 8d 2d 28 1e 00 00 	lea    0x1e28(%rip),%r13        # e3ac <_IO_stdin_used+0x3ac>
    c584:	45 31 e4             	xor    %r12d,%r12d
    c587:	eb 28                	jmp    c5b1 <fwp_escape+0x61>
    c589:	4c 89 f7             	mov    %r14,%rdi
    c58c:	48 8d 35 18 2f 00 00 	lea    0x2f18(%rip),%rsi        # f4ab <exec_in_fp0+0xdab>
    c593:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c59a:	84 00 00 00 00 00 
    c5a0:	e8 4b bd ff ff       	call   82f0 <buf_puts>
    c5a5:	49 ff c4             	inc    %r12
    c5a8:	4c 39 e3             	cmp    %r12,%rbx
    c5ab:	0f 84 90 00 00 00    	je     c641 <fwp_escape+0xf1>
    c5b1:	43 0f b6 0c 27       	movzbl (%r15,%r12,1),%ecx
    c5b6:	8d 41 f7             	lea    -0x9(%rcx),%eax
    c5b9:	83 f8 19             	cmp    $0x19,%eax
    c5bc:	77 22                	ja     c5e0 <fwp_escape+0x90>
    c5be:	49 63 44 85 00       	movslq 0x0(%r13,%rax,4),%rax
    c5c3:	4c 01 e8             	add    %r13,%rax
    c5c6:	ff e0                	jmp    *%rax
    c5c8:	4c 89 f7             	mov    %r14,%rdi
    c5cb:	48 8d 35 d6 2e 00 00 	lea    0x2ed6(%rip),%rsi        # f4a8 <exec_in_fp0+0xda8>
    c5d2:	eb cc                	jmp    c5a0 <fwp_escape+0x50>
    c5d4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    c5db:	00 00 00 00 00 
    c5e0:	83 f9 5c             	cmp    $0x5c,%ecx
    c5e3:	75 0c                	jne    c5f1 <fwp_escape+0xa1>
    c5e5:	4c 89 f7             	mov    %r14,%rdi
    c5e8:	48 8d 35 b3 2e 00 00 	lea    0x2eb3(%rip),%rsi        # f4a2 <exec_in_fp0+0xda2>
    c5ef:	eb af                	jmp    c5a0 <fwp_escape+0x50>
    c5f1:	80 f9 20             	cmp    $0x20,%cl
    c5f4:	72 2a                	jb     c620 <fwp_escape+0xd0>
    c5f6:	80 f9 7f             	cmp    $0x7f,%cl
    c5f9:	74 25                	je     c620 <fwp_escape+0xd0>
    c5fb:	0f be f1             	movsbl %cl,%esi
    c5fe:	4c 89 f7             	mov    %r14,%rdi
    c601:	e8 ca bc ff ff       	call   82d0 <buf_putc>
    c606:	eb 9d                	jmp    c5a5 <fwp_escape+0x55>
    c608:	4c 89 f7             	mov    %r14,%rdi
    c60b:	48 8d 35 8d 2e 00 00 	lea    0x2e8d(%rip),%rsi        # f49f <exec_in_fp0+0xd9f>
    c612:	eb 8c                	jmp    c5a0 <fwp_escape+0x50>
    c614:	4c 89 f7             	mov    %r14,%rdi
    c617:	48 8d 35 87 2e 00 00 	lea    0x2e87(%rip),%rsi        # f4a5 <exec_in_fp0+0xda5>
    c61e:	eb 80                	jmp    c5a0 <fwp_escape+0x50>
    c620:	be 10 00 00 00       	mov    $0x10,%esi
    c625:	48 89 ef             	mov    %rbp,%rdi
    c628:	48 8d 15 7f 2e 00 00 	lea    0x2e7f(%rip),%rdx        # f4ae <exec_in_fp0+0xdae>
    c62f:	31 c0                	xor    %eax,%eax
    c631:	e8 9a 6b ff ff       	call   31d0 <snprintf@plt>
    c636:	4c 89 f7             	mov    %r14,%rdi
    c639:	48 89 ee             	mov    %rbp,%rsi
    c63c:	e9 5f ff ff ff       	jmp    c5a0 <fwp_escape+0x50>
    c641:	4c 89 f7             	mov    %r14,%rdi
    c644:	be 22 00 00 00       	mov    $0x22,%esi
    c649:	48 83 c4 18          	add    $0x18,%rsp
    c64d:	5b                   	pop    %rbx
    c64e:	41 5c                	pop    %r12
    c650:	41 5d                	pop    %r13
    c652:	41 5e                	pop    %r14
    c654:	41 5f                	pop    %r15
    c656:	5d                   	pop    %rbp
    c657:	e9 74 bc ff ff       	jmp    82d0 <buf_putc>
    c65c:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000c660 <fwp_fmt_duration>:
    c660:	41 57                	push   %r15
    c662:	41 56                	push   %r14
    c664:	41 54                	push   %r12
    c666:	53                   	push   %rbx
    c667:	48 83 ec 48          	sub    $0x48,%rsp
    c66b:	49 89 d0             	mov    %rdx,%r8
    c66e:	48 89 fb             	mov    %rdi,%rbx
    c671:	48 89 f0             	mov    %rsi,%rax
    c674:	48 09 d0             	or     %rdx,%rax
    c677:	0f 84 1b 02 00 00    	je     c898 <fwp_fmt_duration+0x238>
    c67d:	48 b9 1d 3f c2 25 d6 	movabs $0xd2fe1d625c23f1d,%rcx
    c684:	e1 2f 0d 
    c687:	48 bf 0d b1 f3 e4 99 	movabs $0x1c52799e4f3b10d,%rdi
    c68e:	27 c5 01 
    c691:	48 89 f0             	mov    %rsi,%rax
    c694:	48 f7 e7             	mul    %rdi
    c697:	48 0f af ce          	imul   %rsi,%rcx
    c69b:	48 01 ca             	add    %rcx,%rdx
    c69e:	49 0f af f8          	imul   %r8,%rdi
    c6a2:	48 01 d7             	add    %rdx,%rdi
    c6a5:	48 b9 00 a0 34 52 a3 	movabs $0x6baf6aa35234a000,%rcx
    c6ac:	6a af 6b 
    c6af:	48 01 c1             	add    %rax,%rcx
    c6b2:	48 b8 37 f9 ff e2 04 	movabs $0x4e2fff937,%rax
    c6b9:	00 00 00 
    c6bc:	48 11 f8             	adc    %rdi,%rax
    c6bf:	48 89 c2             	mov    %rax,%rdx
    c6c2:	48 0f ac ca 0d       	shrd   $0xd,%rcx,%rdx
    c6c7:	48 0f a4 c8 33       	shld   $0x33,%rcx,%rax
    c6cc:	48 b9 4b 23 35 aa f6 	movabs $0x9376baf6aa35234b,%rcx
    c6d3:	ba 76 93 
    c6d6:	48 39 c8             	cmp    %rcx,%rax
    c6d9:	48 81 da ff 2f 4e 00 	sbb    $0x4e2fff,%rdx
    c6e0:	0f 82 d9 01 00 00    	jb     c8bf <fwp_fmt_duration+0x25f>
    c6e6:	48 b9 b3 b2 61 36 8c 	movabs $0xc5ce3b8c3661b2b3,%rcx
    c6ed:	3b ce c5 
    c6f0:	48 bf c3 5f 47 6a 04 	movabs $0x1a8d52046a475fc3,%rdi
    c6f7:	52 8d 1a 
    c6fa:	48 89 f0             	mov    %rsi,%rax
    c6fd:	48 f7 e7             	mul    %rdi
    c700:	48 0f af ce          	imul   %rsi,%rcx
    c704:	48 01 ca             	add    %rcx,%rdx
    c707:	49 0f af f8          	imul   %r8,%rdi
    c70b:	48 01 d7             	add    %rdx,%rdi
    c70e:	48 b9 00 a8 16 d1 91 	movabs $0x4f473f91d116a800,%rcx
    c715:	3f 47 4f 
    c718:	48 01 c1             	add    %rax,%rcx
    c71b:	48 b8 3f 9a ff 4c 49 	movabs $0x494cff9a3f,%rax
    c722:	00 00 00 
    c725:	48 11 f8             	adc    %rdi,%rax
    c728:	48 89 c2             	mov    %rax,%rdx
    c72b:	48 0f ac ca 0b       	shrd   $0xb,%rcx,%rdx
    c730:	48 0f a4 c8 35       	shld   $0x35,%rcx,%rax
    c735:	48 b9 ab 45 74 e4 cf 	movabs $0x8fd3d1cfe47445ab,%rcx
    c73c:	d1 d3 8f 
    c73f:	48 39 c8             	cmp    %rcx,%rax
    c742:	48 81 da e6 3f 53 12 	sbb    $0x12533fe6,%rdx
    c749:	0f 82 7f 01 00 00    	jb     c8ce <fwp_fmt_duration+0x26e>
    c74f:	48 b9 7e 78 b9 2f 37 	movabs $0x97157d372fb9787e,%rcx
    c756:	7d 15 97 
    c759:	48 0f af ce          	imul   %rsi,%rcx
    c75d:	48 bf 6d 9c 2e 3a 42 	movabs $0x8e47ce423a2e9c6d,%rdi
    c764:	ce 47 8e 
    c767:	48 89 f0             	mov    %rsi,%rax
    c76a:	48 f7 e7             	mul    %rdi
    c76d:	48 01 ca             	add    %rcx,%rdx
    c770:	49 0f af f8          	imul   %r8,%rdi
    c774:	48 01 d7             	add    %rdx,%rdi
    c777:	48 b9 00 46 54 40 8b 	movabs $0xa52cb98b40544600,%rcx
    c77e:	b9 2c a5 
    c781:	48 01 c1             	add    %rax,%rcx
    c784:	48 b8 b5 09 fa 82 4b 	movabs $0x44b82fa09b5,%rax
    c78b:	04 00 00 
    c78e:	48 11 f8             	adc    %rdi,%rax
    c791:	48 89 c2             	mov    %rax,%rdx
    c794:	48 0f ac ca 09       	shrd   $0x9,%rcx,%rdx
    c799:	48 0f a4 c8 37       	shld   $0x37,%rcx,%rax
    c79e:	48 b9 47 54 40 8b b9 	movabs $0xb5a52cb98b405447,%rcx
    c7a5:	2c a5 b5 
    c7a8:	48 39 c8             	cmp    %rcx,%rax
    c7ab:	48 b8 09 fa 82 4b 04 	movabs $0x44b82fa09,%rax
    c7b2:	00 00 00 
    c7b5:	48 19 c2             	sbb    %rax,%rdx
    c7b8:	0f 82 22 01 00 00    	jb     c8e0 <fwp_fmt_duration+0x280>
    c7be:	48 b9 cb d5 8f 4d f2 	movabs $0xc57e23f24d8fd5cb,%rcx
    c7c5:	23 7e c5 
    c7c8:	48 0f af ce          	imul   %rsi,%rcx
    c7cc:	48 bf 39 61 c2 68 56 	movabs $0x790fb65668c26139,%rdi
    c7d3:	b6 0f 79 
    c7d6:	48 89 f0             	mov    %rsi,%rax
    c7d9:	48 f7 e7             	mul    %rdi
    c7dc:	48 01 ca             	add    %rcx,%rdx
    c7df:	49 0f af f8          	imul   %r8,%rdi
    c7e3:	48 01 d7             	add    %rdx,%rdi
    c7e6:	48 b9 00 0b 27 69 fe 	movabs $0xa6d698fe69270b00,%rcx
    c7ed:	98 d6 a6 
    c7f0:	48 01 c1             	add    %rax,%rcx
    c7f3:	48 b8 b1 bd 16 f4 de 	movabs $0x218def416bdb1,%rax
    c7fa:	18 02 00 
    c7fd:	48 11 f8             	adc    %rdi,%rax
    c800:	48 89 c2             	mov    %rax,%rdx
    c803:	48 0f ac ca 06       	shrd   $0x6,%rcx,%rdx
    c808:	48 0f a4 c8 3a       	shld   $0x3a,%rcx,%rax
    c80d:	48 b9 59 38 49 f3 c7 	movabs $0x8d36b4c7f3493859,%rcx
    c814:	b4 36 8d 
    c817:	48 39 c8             	cmp    %rcx,%rax
    c81a:	48 b8 ed b5 a0 f7 c6 	movabs $0x10c6f7a0b5ed,%rax
    c821:	10 00 00 
    c824:	48 19 c2             	sbb    %rax,%rdx
    c827:	0f 82 c0 00 00 00    	jb     c8ed <fwp_fmt_duration+0x28d>
    c82d:	48 b9 5a 64 3b df 4f 	movabs $0x6e978d4fdf3b645a,%rcx
    c834:	8d 97 6e 
    c837:	48 0f af ce          	imul   %rsi,%rcx
    c83b:	48 bf d5 78 e9 26 31 	movabs $0x1cac083126e978d5,%rdi
    c842:	08 ac 1c 
    c845:	48 89 f0             	mov    %rsi,%rax
    c848:	48 f7 e7             	mul    %rdi
    c84b:	48 01 ca             	add    %rcx,%rdx
    c84e:	49 0f af f8          	imul   %r8,%rdi
    c852:	48 01 d7             	add    %rdx,%rdi
    c855:	48 b9 48 62 10 58 39 	movabs $0x76c8b43958106248,%rcx
    c85c:	b4 c8 76 
    c85f:	48 01 c1             	add    %rax,%rcx
    c862:	48 b8 be 9f 1a 2f dd 	movabs $0x10624dd2f1a9fbe,%rax
    c869:	24 06 01 
    c86c:	48 11 f8             	adc    %rdi,%rax
    c86f:	48 89 c2             	mov    %rax,%rdx
    c872:	48 0f ac ca 03       	shrd   $0x3,%rcx,%rdx
    c877:	48 0f a4 c8 3d       	shld   $0x3d,%rcx,%rax
    c87c:	48 b9 93 18 04 56 0e 	movabs $0x9db22d0e56041893,%rcx
    c883:	2d b2 9d 
    c886:	48 39 c8             	cmp    %rcx,%rax
    c889:	48 b8 ef a7 c6 4b 37 	movabs $0x4189374bc6a7ef,%rax
    c890:	89 41 00 
    c893:	48 19 c2             	sbb    %rax,%rdx
    c896:	72 62                	jb     c8fa <fwp_fmt_duration+0x29a>
    c898:	49 89 e6             	mov    %rsp,%r14
    c89b:	4c 89 f7             	mov    %r14,%rdi
    c89e:	4c 89 c2             	mov    %r8,%rdx
    c8a1:	e8 ca f6 ff ff       	call   bf70 <fwp_fmt_i128>
    c8a6:	48 8d 35 0d 2c 00 00 	lea    0x2c0d(%rip),%rsi        # f4ba <exec_in_fp0+0xdba>
    c8ad:	48 89 df             	mov    %rbx,%rdi
    c8b0:	4c 89 f2             	mov    %r14,%rdx
    c8b3:	31 c0                	xor    %eax,%eax
    c8b5:	e8 b6 6b ff ff       	call   3470 <sprintf@plt>
    c8ba:	e9 84 00 00 00       	jmp    c943 <fwp_fmt_duration+0x2e3>
    c8bf:	48 ba 00 a0 b8 30 46 	movabs $0x34630b8a000,%rdx
    c8c6:	03 00 00 
    c8c9:	45 31 ff             	xor    %r15d,%r15d
    c8cc:	eb 37                	jmp    c905 <fwp_fmt_duration+0x2a5>
    c8ce:	48 ba 00 58 47 f8 0d 	movabs $0xdf8475800,%rdx
    c8d5:	00 00 00 
    c8d8:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    c8de:	eb 25                	jmp    c905 <fwp_fmt_duration+0x2a5>
    c8e0:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
    c8e5:	41 bf 02 00 00 00    	mov    $0x2,%r15d
    c8eb:	eb 18                	jmp    c905 <fwp_fmt_duration+0x2a5>
    c8ed:	ba 40 42 0f 00       	mov    $0xf4240,%edx
    c8f2:	41 bf 03 00 00 00    	mov    $0x3,%r15d
    c8f8:	eb 0b                	jmp    c905 <fwp_fmt_duration+0x2a5>
    c8fa:	ba e8 03 00 00       	mov    $0x3e8,%edx
    c8ff:	41 bf 04 00 00 00    	mov    $0x4,%r15d
    c905:	31 c9                	xor    %ecx,%ecx
    c907:	41 c1 e7 04          	shl    $0x4,%r15d
    c90b:	4c 8d 25 ce 73 00 00 	lea    0x73ce(%rip),%r12        # 13ce0 <fwp_fmt_duration.units>
    c912:	48 89 f7             	mov    %rsi,%rdi
    c915:	4c 89 c6             	mov    %r8,%rsi
    c918:	e8 e3 14 00 00       	call   de00 <__divti3>
    c91d:	49 89 e6             	mov    %rsp,%r14
    c920:	4c 89 f7             	mov    %r14,%rdi
    c923:	48 89 c6             	mov    %rax,%rsi
    c926:	e8 45 f6 ff ff       	call   bf70 <fwp_fmt_i128>
    c92b:	4b 8b 0c 27          	mov    (%r15,%r12,1),%rcx
    c92f:	48 8d 35 7f 2b 00 00 	lea    0x2b7f(%rip),%rsi        # f4b5 <exec_in_fp0+0xdb5>
    c936:	48 89 df             	mov    %rbx,%rdi
    c939:	4c 89 f2             	mov    %r14,%rdx
    c93c:	31 c0                	xor    %eax,%eax
    c93e:	e8 2d 6b ff ff       	call   3470 <sprintf@plt>
    c943:	48 83 c4 48          	add    $0x48,%rsp
    c947:	5b                   	pop    %rbx
    c948:	41 5c                	pop    %r12
    c94a:	41 5e                	pop    %r14
    c94c:	41 5f                	pop    %r15
    c94e:	c3                   	ret
    c94f:	90                   	nop

000000000000c950 <fwp_needs_parens>:
    c950:	8b 06                	mov    (%rsi),%eax
    c952:	83 f8 10             	cmp    $0x10,%eax
    c955:	74 16                	je     c96d <fwp_needs_parens+0x1d>
    c957:	83 f8 0e             	cmp    $0xe,%eax
    c95a:	0f 85 30 02 00 00    	jne    cb90 <fwp_is_negative>
    c960:	31 c0                	xor    %eax,%eax
    c962:	48 81 ff 00 10 00 00 	cmp    $0x1000,%rdi
    c969:	0f 93 c0             	setae  %al
    c96c:	c3                   	ret
    c96d:	48 8b 46 08          	mov    0x8(%rsi),%rax
    c971:	48 85 c0             	test   %rax,%rax
    c974:	0f 84 16 02 00 00    	je     cb90 <fwp_is_negative>
    c97a:	50                   	push   %rax
    c97b:	48 8d 35 30 2a 00 00 	lea    0x2a30(%rip),%rsi        # f3b2 <exec_in_fp0+0xcb2>
    c982:	48 89 c7             	mov    %rax,%rdi
    c985:	e8 46 69 ff ff       	call   32d0 <strcmp@plt>
    c98a:	89 c1                	mov    %eax,%ecx
    c98c:	31 c0                	xor    %eax,%eax
    c98e:	85 c9                	test   %ecx,%ecx
    c990:	0f 95 c0             	setne  %al
    c993:	48 83 c4 08          	add    $0x8,%rsp
    c997:	c3                   	ret
    c998:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c99f:	00 

000000000000c9a0 <fwp_format_g>:
    c9a0:	55                   	push   %rbp
    c9a1:	41 57                	push   %r15
    c9a3:	41 56                	push   %r14
    c9a5:	41 55                	push   %r13
    c9a7:	41 54                	push   %r12
    c9a9:	53                   	push   %rbx
    c9aa:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    c9b1:	89 f5                	mov    %esi,%ebp
    c9b3:	48 89 fb             	mov    %rdi,%rbx
    c9b6:	ff cd                	dec    %ebp
    c9b8:	48 8d 15 c9 2a 00 00 	lea    0x2ac9(%rip),%rdx        # f488 <exec_in_fp0+0xd88>
    c9bf:	4c 8d 64 24 50       	lea    0x50(%rsp),%r12
    c9c4:	be 40 00 00 00       	mov    $0x40,%esi
    c9c9:	4c 89 e7             	mov    %r12,%rdi
    c9cc:	89 e9                	mov    %ebp,%ecx
    c9ce:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    c9d4:	b0 01                	mov    $0x1,%al
    c9d6:	e8 f5 67 ff ff       	call   31d0 <snprintf@plt>
    c9db:	4c 89 e7             	mov    %r12,%rdi
    c9de:	be 65 00 00 00       	mov    $0x65,%esi
    c9e3:	e8 c8 67 ff ff       	call   31b0 <strchr@plt>
    c9e8:	49 89 c7             	mov    %rax,%r15
    c9eb:	48 8d 78 01          	lea    0x1(%rax),%rdi
    c9ef:	e8 6c 6a ff ff       	call   3460 <atoi@plt>
    c9f4:	41 89 c6             	mov    %eax,%r14d
    c9f7:	41 8d 46 ef          	lea    -0x11(%r14),%eax
    c9fb:	83 f8 e9             	cmp    $0xffffffe9,%eax
    c9fe:	77 58                	ja     ca58 <fwp_format_g+0xb8>
    ca00:	4d 29 e7             	sub    %r12,%r15
    ca03:	4c 8d 6c 24 10       	lea    0x10(%rsp),%r13
    ca08:	4c 89 ef             	mov    %r13,%rdi
    ca0b:	4c 89 e6             	mov    %r12,%rsi
    ca0e:	4c 89 fa             	mov    %r15,%rdx
    ca11:	e8 1a 69 ff ff       	call   3330 <memcpy@plt>
    ca16:	42 c6 44 3c 10 00    	movb   $0x0,0x10(%rsp,%r15,1)
    ca1c:	4c 89 ef             	mov    %r13,%rdi
    ca1f:	be 2e 00 00 00       	mov    $0x2e,%esi
    ca24:	e8 87 67 ff ff       	call   31b0 <strchr@plt>
    ca29:	48 85 c0             	test   %rax,%rax
    ca2c:	0f 84 91 00 00 00    	je     cac3 <fwp_format_g+0x123>
    ca32:	4d 85 ff             	test   %r15,%r15
    ca35:	0f 84 88 00 00 00    	je     cac3 <fwp_format_g+0x123>
    ca3b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    ca40:	42 0f b6 44 3c 0f    	movzbl 0xf(%rsp,%r15,1),%eax
    ca46:	83 f8 30             	cmp    $0x30,%eax
    ca49:	75 6d                	jne    cab8 <fwp_format_g+0x118>
    ca4b:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    ca51:	49 ff cf             	dec    %r15
    ca54:	75 ea                	jne    ca40 <fwp_format_g+0xa0>
    ca56:	eb 6b                	jmp    cac3 <fwp_format_g+0x123>
    ca58:	44 29 f5             	sub    %r14d,%ebp
    ca5b:	31 c9                	xor    %ecx,%ecx
    ca5d:	85 ed                	test   %ebp,%ebp
    ca5f:	0f 4f cd             	cmovg  %ebp,%ecx
    ca62:	48 8d 15 2e 2a 00 00 	lea    0x2a2e(%rip),%rdx        # f497 <exec_in_fp0+0xd97>
    ca69:	be 90 01 00 00       	mov    $0x190,%esi
    ca6e:	48 89 df             	mov    %rbx,%rdi
    ca71:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    ca77:	b0 01                	mov    $0x1,%al
    ca79:	e8 52 67 ff ff       	call   31d0 <snprintf@plt>
    ca7e:	48 89 df             	mov    %rbx,%rdi
    ca81:	e8 ea 66 ff ff       	call   3170 <strlen@plt>
    ca86:	49 89 c6             	mov    %rax,%r14
    ca89:	48 89 df             	mov    %rbx,%rdi
    ca8c:	be 2e 00 00 00       	mov    $0x2e,%esi
    ca91:	e8 1a 67 ff ff       	call   31b0 <strchr@plt>
    ca96:	48 85 c0             	test   %rax,%rax
    ca99:	74 5b                	je     caf6 <fwp_format_g+0x156>
    ca9b:	4d 85 f6             	test   %r14,%r14
    ca9e:	74 56                	je     caf6 <fwp_format_g+0x156>
    caa0:	42 0f b6 44 33 ff    	movzbl -0x1(%rbx,%r14,1),%eax
    caa6:	83 f8 30             	cmp    $0x30,%eax
    caa9:	75 5d                	jne    cb08 <fwp_format_g+0x168>
    caab:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    cab1:	49 ff ce             	dec    %r14
    cab4:	75 ea                	jne    caa0 <fwp_format_g+0x100>
    cab6:	eb 3e                	jmp    caf6 <fwp_format_g+0x156>
    cab8:	83 f8 2e             	cmp    $0x2e,%eax
    cabb:	75 06                	jne    cac3 <fwp_format_g+0x123>
    cabd:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    cac3:	44 89 f0             	mov    %r14d,%eax
    cac6:	c1 e8 1f             	shr    $0x1f,%eax
    cac9:	44 8d 04 45 2b 00 00 	lea    0x2b(,%rax,2),%r8d
    cad0:	00 
    cad1:	45 89 f1             	mov    %r14d,%r9d
    cad4:	41 f7 d9             	neg    %r9d
    cad7:	45 0f 48 ce          	cmovs  %r14d,%r9d
    cadb:	48 8d 15 ab 29 00 00 	lea    0x29ab(%rip),%rdx        # f48d <exec_in_fp0+0xd8d>
    cae2:	48 8d 4c 24 10       	lea    0x10(%rsp),%rcx
    cae7:	be 90 01 00 00       	mov    $0x190,%esi
    caec:	48 89 df             	mov    %rbx,%rdi
    caef:	31 c0                	xor    %eax,%eax
    caf1:	e8 da 66 ff ff       	call   31d0 <snprintf@plt>
    caf6:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    cafd:	5b                   	pop    %rbx
    cafe:	41 5c                	pop    %r12
    cb00:	41 5d                	pop    %r13
    cb02:	41 5e                	pop    %r14
    cb04:	41 5f                	pop    %r15
    cb06:	5d                   	pop    %rbp
    cb07:	c3                   	ret
    cb08:	83 f8 2e             	cmp    $0x2e,%eax
    cb0b:	75 e9                	jne    caf6 <fwp_format_g+0x156>
    cb0d:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    cb13:	eb e1                	jmp    caf6 <fwp_format_g+0x156>
    cb15:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    cb1c:	00 00 00 00 

000000000000cb20 <fwp_finish_float>:
    cb20:	53                   	push   %rbx
    cb21:	48 89 fb             	mov    %rdi,%rbx
    cb24:	be 2e 00 00 00       	mov    $0x2e,%esi
    cb29:	e8 82 66 ff ff       	call   31b0 <strchr@plt>
    cb2e:	48 85 c0             	test   %rax,%rax
    cb31:	74 02                	je     cb35 <fwp_finish_float+0x15>
    cb33:	5b                   	pop    %rbx
    cb34:	c3                   	ret
    cb35:	48 89 df             	mov    %rbx,%rdi
    cb38:	be 65 00 00 00       	mov    $0x65,%esi
    cb3d:	e8 6e 66 ff ff       	call   31b0 <strchr@plt>
    cb42:	48 85 c0             	test   %rax,%rax
    cb45:	75 ec                	jne    cb33 <fwp_finish_float+0x13>
    cb47:	48 8d 35 7d 28 00 00 	lea    0x287d(%rip),%rsi        # f3cb <exec_in_fp0+0xccb>
    cb4e:	48 89 df             	mov    %rbx,%rdi
    cb51:	e8 9a 69 ff ff       	call   34f0 <strstr@plt>
    cb56:	48 85 c0             	test   %rax,%rax
    cb59:	75 d8                	jne    cb33 <fwp_finish_float+0x13>
    cb5b:	48 8d 35 6d 28 00 00 	lea    0x286d(%rip),%rsi        # f3cf <exec_in_fp0+0xccf>
    cb62:	48 89 df             	mov    %rbx,%rdi
    cb65:	e8 86 69 ff ff       	call   34f0 <strstr@plt>
    cb6a:	48 85 c0             	test   %rax,%rax
    cb6d:	75 c4                	jne    cb33 <fwp_finish_float+0x13>
    cb6f:	48 89 df             	mov    %rbx,%rdi
    cb72:	e8 f9 65 ff ff       	call   3170 <strlen@plt>
    cb77:	66 c7 04 03 2e 30    	movw   $0x302e,(%rbx,%rax,1)
    cb7d:	c6 44 03 02 00       	movb   $0x0,0x2(%rbx,%rax,1)
    cb82:	5b                   	pop    %rbx
    cb83:	c3                   	ret
    cb84:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    cb8b:	00 00 00 00 00 

000000000000cb90 <fwp_is_negative>:
    cb90:	50                   	push   %rax
    cb91:	8b 0e                	mov    (%rsi),%ecx
    cb93:	31 c0                	xor    %eax,%eax
    cb95:	48 83 f9 0b          	cmp    $0xb,%rcx
    cb99:	77 16                	ja     cbb1 <fwp_is_negative+0x21>
    cb9b:	48 8d 15 72 18 00 00 	lea    0x1872(%rip),%rdx        # e414 <_IO_stdin_used+0x414>
    cba2:	48 63 0c 8a          	movslq (%rdx,%rcx,4),%rcx
    cba6:	48 01 d1             	add    %rdx,%rcx
    cba9:	ff e1                	jmp    *%rcx
    cbab:	48 c1 ef 3f          	shr    $0x3f,%rdi
    cbaf:	89 f8                	mov    %edi,%eax
    cbb1:	59                   	pop    %rcx
    cbb2:	c3                   	ret
    cbb3:	e8 08 de ff ff       	call   a9c0 <fwp_f32>
    cbb8:	0f 50 c0             	movmskps %xmm0,%eax
    cbbb:	eb 09                	jmp    cbc6 <fwp_is_negative+0x36>
    cbbd:	e8 fe 76 ff ff       	call   42c0 <fwp_f64>
    cbc2:	66 0f 50 c0          	movmskpd %xmm0,%eax
    cbc6:	83 e0 01             	and    $0x1,%eax
    cbc9:	59                   	pop    %rcx
    cbca:	c3                   	ret
    cbcb:	e8 c0 dd ff ff       	call   a990 <fwp_i128>
    cbd0:	48 89 d0             	mov    %rdx,%rax
    cbd3:	48 c1 e8 3f          	shr    $0x3f,%rax
    cbd7:	59                   	pop    %rcx
    cbd8:	c3                   	ret
    cbd9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000cbe0 <fwp_emit>:
    cbe0:	53                   	push   %rbx
    cbe1:	48 83 ec 30          	sub    $0x30,%rsp
    cbe5:	48 89 f8             	mov    %rdi,%rax
    cbe8:	83 3d 31 98 01 00 00 	cmpl   $0x0,0x19831(%rip)        # 26420 <fwp_exec_binary_out>
    cbef:	74 66                	je     cc57 <fwp_emit+0x77>
    cbf1:	0f 57 c0             	xorps  %xmm0,%xmm0
    cbf4:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    cbf9:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    cc00:	00 00 
    cc02:	48 8d 15 bf 90 00 00 	lea    0x90bf(%rip),%rdx        # 15cc8 <d1>
    cc09:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    cc0e:	48 89 c6             	mov    %rax,%rsi
    cc11:	e8 9a 00 00 00       	call   ccb0 <fwp_encode>
    cc16:	c6 44 24 0b 01       	movb   $0x1,0xb(%rsp)
    cc1b:	8b 44 24 18          	mov    0x18(%rsp),%eax
    cc1f:	89 44 24 0c          	mov    %eax,0xc(%rsp)
    cc23:	48 8d 7c 24 0b       	lea    0xb(%rsp),%rdi
    cc28:	be 05 00 00 00       	mov    $0x5,%esi
    cc2d:	e8 3e a6 ff ff       	call   7270 <fwp_pipe_write>
    cc32:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    cc37:	48 85 f6             	test   %rsi,%rsi
    cc3a:	74 0a                	je     cc46 <fwp_emit+0x66>
    cc3c:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    cc41:	e8 2a a6 ff ff       	call   7270 <fwp_pipe_write>
    cc46:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    cc4b:	e8 00 64 ff ff       	call   3050 <free@plt>
    cc50:	e8 9b 02 00 00       	call   cef0 <fwp_pipe_frame_done>
    cc55:	eb 1c                	jmp    cc73 <fwp_emit+0x93>
    cc57:	83 3d 6a 90 00 00 10 	cmpl   $0x10,0x906a(%rip)        # 15cc8 <d1>
    cc5e:	75 19                	jne    cc79 <fwp_emit+0x99>
    cc60:	83 3d 71 90 00 00 00 	cmpl   $0x0,0x9071(%rip)        # 15cd8 <d1+0x10>
    cc67:	75 10                	jne    cc79 <fwp_emit+0x99>
    cc69:	48 83 3d 5f 90 00 00 	cmpq   $0x0,0x905f(%rip)        # 15cd0 <d1+0x8>
    cc70:	00 
    cc71:	75 06                	jne    cc79 <fwp_emit+0x99>
    cc73:	48 83 c4 30          	add    $0x30,%rsp
    cc77:	5b                   	pop    %rbx
    cc78:	c3                   	ret
    cc79:	48 8b 1d 30 73 00 00 	mov    0x7330(%rip),%rbx        # 13fb0 <stdout@GLIBC_2.2.5>
    cc80:	48 8b 13             	mov    (%rbx),%rdx
    cc83:	48 8d 35 3e 90 00 00 	lea    0x903e(%rip),%rsi        # 15cc8 <d1>
    cc8a:	48 89 c7             	mov    %rax,%rdi
    cc8d:	e8 6e eb ff ff       	call   b800 <fwp_display_top>
    cc92:	48 8b 33             	mov    (%rbx),%rsi
    cc95:	bf 0a 00 00 00       	mov    $0xa,%edi
    cc9a:	48 83 c4 30          	add    $0x30,%rsp
    cc9e:	5b                   	pop    %rbx
    cc9f:	e9 9c 65 ff ff       	jmp    3240 <fputc@plt>
    cca4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    ccab:	00 00 00 00 00 

000000000000ccb0 <fwp_encode>:
    ccb0:	41 57                	push   %r15
    ccb2:	41 56                	push   %r14
    ccb4:	41 55                	push   %r13
    ccb6:	41 54                	push   %r12
    ccb8:	53                   	push   %rbx
    ccb9:	8b 02                	mov    (%rdx),%eax
    ccbb:	48 83 f8 15          	cmp    $0x15,%rax
    ccbf:	0f 87 14 02 00 00    	ja     ced9 <fwp_encode+0x229>
    ccc5:	49 89 d7             	mov    %rdx,%r15
    ccc8:	49 89 f6             	mov    %rsi,%r14
    cccb:	48 89 fb             	mov    %rdi,%rbx
    ccce:	48 8d 0d 6f 17 00 00 	lea    0x176f(%rip),%rcx        # e444 <_IO_stdin_used+0x444>
    ccd5:	48 63 04 81          	movslq (%rcx,%rax,4),%rax
    ccd9:	48 01 c8             	add    %rcx,%rax
    ccdc:	ff e0                	jmp    *%rax
    ccde:	48 89 df             	mov    %rbx,%rdi
    cce1:	4c 89 f6             	mov    %r14,%rsi
    cce4:	ba 01 00 00 00       	mov    $0x1,%edx
    cce9:	e9 77 01 00 00       	jmp    ce65 <fwp_encode+0x1b5>
    ccee:	48 89 df             	mov    %rbx,%rdi
    ccf1:	4c 89 f6             	mov    %r14,%rsi
    ccf4:	ba 04 00 00 00       	mov    $0x4,%edx
    ccf9:	e9 67 01 00 00       	jmp    ce65 <fwp_encode+0x1b5>
    ccfe:	49 8b 36             	mov    (%r14),%rsi
    cd01:	48 89 df             	mov    %rbx,%rdi
    cd04:	e8 57 02 00 00       	call   cf60 <fwp_leb128>
    cd09:	49 8b 16             	mov    (%r14),%rdx
    cd0c:	49 83 c6 08          	add    $0x8,%r14
    cd10:	48 89 df             	mov    %rbx,%rdi
    cd13:	4c 89 f6             	mov    %r14,%rsi
    cd16:	5b                   	pop    %rbx
    cd17:	41 5c                	pop    %r12
    cd19:	41 5d                	pop    %r13
    cd1b:	41 5e                	pop    %r14
    cd1d:	41 5f                	pop    %r15
    cd1f:	e9 fc b5 ff ff       	jmp    8320 <buf_put>
    cd24:	48 89 df             	mov    %rbx,%rdi
    cd27:	4c 89 f6             	mov    %r14,%rsi
    cd2a:	ba 02 00 00 00       	mov    $0x2,%edx
    cd2f:	e9 31 01 00 00       	jmp    ce65 <fwp_encode+0x1b5>
    cd34:	49 8b 36             	mov    (%r14),%rsi
    cd37:	48 89 df             	mov    %rbx,%rdi
    cd3a:	e8 21 02 00 00       	call   cf60 <fwp_leb128>
    cd3f:	49 83 3e 00          	cmpq   $0x0,(%r14)
    cd43:	0f 84 90 01 00 00    	je     ced9 <fwp_encode+0x229>
    cd49:	4d 8d 66 10          	lea    0x10(%r14),%r12
    cd4d:	45 31 ed             	xor    %r13d,%r13d
    cd50:	eb 1e                	jmp    cd70 <fwp_encode+0xc0>
    cd52:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    cd59:	1f 84 00 00 00 00 00 
    cd60:	49 ff c5             	inc    %r13
    cd63:	49 83 c4 10          	add    $0x10,%r12
    cd67:	4d 3b 2e             	cmp    (%r14),%r13
    cd6a:	0f 83 69 01 00 00    	jae    ced9 <fwp_encode+0x229>
    cd70:	49 8b 74 24 f8       	mov    -0x8(%r12),%rsi
    cd75:	49 8b 57 38          	mov    0x38(%r15),%rdx
    cd79:	48 89 df             	mov    %rbx,%rdi
    cd7c:	e8 2f ff ff ff       	call   ccb0 <fwp_encode>
    cd81:	41 83 3f 12          	cmpl   $0x12,(%r15)
    cd85:	75 d9                	jne    cd60 <fwp_encode+0xb0>
    cd87:	49 8b 34 24          	mov    (%r12),%rsi
    cd8b:	49 8b 57 40          	mov    0x40(%r15),%rdx
    cd8f:	48 89 df             	mov    %rbx,%rdi
    cd92:	e8 19 ff ff ff       	call   ccb0 <fwp_encode>
    cd97:	eb c7                	jmp    cd60 <fwp_encode+0xb0>
    cd99:	4c 89 f7             	mov    %r14,%rdi
    cd9c:	e8 4f dc ff ff       	call   a9f0 <fwp_tag>
    cda1:	41 89 c4             	mov    %eax,%r12d
    cda4:	48 89 df             	mov    %rbx,%rdi
    cda7:	4c 89 e6             	mov    %r12,%rsi
    cdaa:	e8 b1 01 00 00       	call   cf60 <fwp_leb128>
    cdaf:	49 8b 47 28          	mov    0x28(%r15),%rax
    cdb3:	42 83 3c a0 00       	cmpl   $0x0,(%rax,%r12,4)
    cdb8:	0f 8e 1b 01 00 00    	jle    ced9 <fwp_encode+0x229>
    cdbe:	45 31 ed             	xor    %r13d,%r13d
    cdc1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    cdc8:	0f 1f 84 00 00 00 00 
    cdcf:	00 
    cdd0:	4b 8b 74 ee 08       	mov    0x8(%r14,%r13,8),%rsi
    cdd5:	49 8b 47 30          	mov    0x30(%r15),%rax
    cdd9:	4a 8b 04 e0          	mov    (%rax,%r12,8),%rax
    cddd:	4a 8b 14 e8          	mov    (%rax,%r13,8),%rdx
    cde1:	48 89 df             	mov    %rbx,%rdi
    cde4:	e8 c7 fe ff ff       	call   ccb0 <fwp_encode>
    cde9:	49 ff c5             	inc    %r13
    cdec:	49 8b 47 28          	mov    0x28(%r15),%rax
    cdf0:	4a 63 04 a0          	movslq (%rax,%r12,4),%rax
    cdf4:	49 39 c5             	cmp    %rax,%r13
    cdf7:	7c d7                	jl     cdd0 <fwp_encode+0x120>
    cdf9:	e9 db 00 00 00       	jmp    ced9 <fwp_encode+0x229>
    cdfe:	4c 89 f7             	mov    %r14,%rdi
    ce01:	e8 8a db ff ff       	call   a990 <fwp_i128>
    ce06:	eb 3f                	jmp    ce47 <fwp_encode+0x197>
    ce08:	4c 89 f7             	mov    %r14,%rdi
    ce0b:	e8 70 d6 ff ff       	call   a480 <fwp_list_len>
    ce10:	48 89 df             	mov    %rbx,%rdi
    ce13:	48 89 c6             	mov    %rax,%rsi
    ce16:	e8 45 01 00 00       	call   cf60 <fwp_leb128>
    ce1b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    ce20:	4d 85 f6             	test   %r14,%r14
    ce23:	0f 84 b0 00 00 00    	je     ced9 <fwp_encode+0x229>
    ce29:	49 8b 76 08          	mov    0x8(%r14),%rsi
    ce2d:	49 8b 57 38          	mov    0x38(%r15),%rdx
    ce31:	48 89 df             	mov    %rbx,%rdi
    ce34:	e8 77 fe ff ff       	call   ccb0 <fwp_encode>
    ce39:	4d 8b 76 10          	mov    0x10(%r14),%r14
    ce3d:	eb e1                	jmp    ce20 <fwp_encode+0x170>
    ce3f:	4c 89 f7             	mov    %r14,%rdi
    ce42:	e8 59 db ff ff       	call   a9a0 <fwp_u128>
    ce47:	49 89 d6             	mov    %rdx,%r14
    ce4a:	48 89 df             	mov    %rbx,%rdi
    ce4d:	48 89 c6             	mov    %rax,%rsi
    ce50:	ba 08 00 00 00       	mov    $0x8,%edx
    ce55:	e8 b6 00 00 00       	call   cf10 <fwp_le>
    ce5a:	48 89 df             	mov    %rbx,%rdi
    ce5d:	4c 89 f6             	mov    %r14,%rsi
    ce60:	ba 08 00 00 00       	mov    $0x8,%edx
    ce65:	5b                   	pop    %rbx
    ce66:	41 5c                	pop    %r12
    ce68:	41 5d                	pop    %r13
    ce6a:	41 5e                	pop    %r14
    ce6c:	41 5f                	pop    %r15
    ce6e:	e9 9d 00 00 00       	jmp    cf10 <fwp_le>
    ce73:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    ce78:	7e 5f                	jle    ced9 <fwp_encode+0x229>
    ce7a:	45 31 e4             	xor    %r12d,%r12d
    ce7d:	0f 1f 00             	nopl   (%rax)
    ce80:	4b 8b 74 e6 08       	mov    0x8(%r14,%r12,8),%rsi
    ce85:	49 8b 47 20          	mov    0x20(%r15),%rax
    ce89:	4a 8b 14 e0          	mov    (%rax,%r12,8),%rdx
    ce8d:	48 89 df             	mov    %rbx,%rdi
    ce90:	e8 1b fe ff ff       	call   ccb0 <fwp_encode>
    ce95:	49 ff c4             	inc    %r12
    ce98:	49 63 47 10          	movslq 0x10(%r15),%rax
    ce9c:	49 39 c4             	cmp    %rax,%r12
    ce9f:	7c df                	jl     ce80 <fwp_encode+0x1d0>
    cea1:	eb 36                	jmp    ced9 <fwp_encode+0x229>
    cea3:	49 8b 36             	mov    (%r14),%rsi
    cea6:	48 89 df             	mov    %rbx,%rdi
    cea9:	e8 b2 00 00 00       	call   cf60 <fwp_leb128>
    ceae:	49 83 3e 00          	cmpq   $0x0,(%r14)
    ceb2:	74 25                	je     ced9 <fwp_encode+0x229>
    ceb4:	45 31 e4             	xor    %r12d,%r12d
    ceb7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    cebe:	00 00 
    cec0:	4b 8b 74 e6 08       	mov    0x8(%r14,%r12,8),%rsi
    cec5:	49 8b 57 38          	mov    0x38(%r15),%rdx
    cec9:	48 89 df             	mov    %rbx,%rdi
    cecc:	e8 df fd ff ff       	call   ccb0 <fwp_encode>
    ced1:	49 ff c4             	inc    %r12
    ced4:	4d 3b 26             	cmp    (%r14),%r12
    ced7:	72 e7                	jb     cec0 <fwp_encode+0x210>
    ced9:	5b                   	pop    %rbx
    ceda:	41 5c                	pop    %r12
    cedc:	41 5d                	pop    %r13
    cede:	41 5e                	pop    %r14
    cee0:	41 5f                	pop    %r15
    cee2:	c3                   	ret
    cee3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ceea:	84 00 00 00 00 00 

000000000000cef0 <fwp_pipe_frame_done>:
    cef0:	83 3d c1 8d 00 00 00 	cmpl   $0x0,0x8dc1(%rip)        # 15cb8 <fwp_po_listen>
    cef7:	78 16                	js     cf0f <fwp_pipe_frame_done+0x1f>
    cef9:	8b 05 71 95 02 00    	mov    0x29571(%rip),%eax        # 36470 <fwp_po_frames>
    ceff:	ff c0                	inc    %eax
    cf01:	89 05 69 95 02 00    	mov    %eax,0x29569(%rip)        # 36470 <fwp_po_frames>
    cf07:	a8 3f                	test   $0x3f,%al
    cf09:	0f 84 11 e0 ff ff    	je     af20 <fwp_pipe_poll>
    cf0f:	c3                   	ret

000000000000cf10 <fwp_le>:
    cf10:	85 d2                	test   %edx,%edx
    cf12:	7e 44                	jle    cf58 <fwp_le+0x48>
    cf14:	41 57                	push   %r15
    cf16:	41 56                	push   %r14
    cf18:	41 54                	push   %r12
    cf1a:	53                   	push   %rbx
    cf1b:	50                   	push   %rax
    cf1c:	48 89 f3             	mov    %rsi,%rbx
    cf1f:	49 89 fe             	mov    %rdi,%r14
    cf22:	41 89 d4             	mov    %edx,%r12d
    cf25:	49 c1 e4 03          	shl    $0x3,%r12
    cf29:	45 31 ff             	xor    %r15d,%r15d
    cf2c:	0f 1f 40 00          	nopl   0x0(%rax)
    cf30:	48 89 d8             	mov    %rbx,%rax
    cf33:	44 89 f9             	mov    %r15d,%ecx
    cf36:	48 d3 e8             	shr    %cl,%rax
    cf39:	0f be f0             	movsbl %al,%esi
    cf3c:	4c 89 f7             	mov    %r14,%rdi
    cf3f:	e8 8c b3 ff ff       	call   82d0 <buf_putc>
    cf44:	49 83 c7 08          	add    $0x8,%r15
    cf48:	4d 39 fc             	cmp    %r15,%r12
    cf4b:	75 e3                	jne    cf30 <fwp_le+0x20>
    cf4d:	48 83 c4 08          	add    $0x8,%rsp
    cf51:	5b                   	pop    %rbx
    cf52:	41 5c                	pop    %r12
    cf54:	41 5e                	pop    %r14
    cf56:	41 5f                	pop    %r15
    cf58:	c3                   	ret
    cf59:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000cf60 <fwp_leb128>:
    cf60:	41 57                	push   %r15
    cf62:	41 56                	push   %r14
    cf64:	53                   	push   %rbx
    cf65:	49 89 f6             	mov    %rsi,%r14
    cf68:	48 89 fb             	mov    %rdi,%rbx
    cf6b:	48 81 fe 80 00 00 00 	cmp    $0x80,%rsi
    cf72:	73 05                	jae    cf79 <fwp_leb128+0x19>
    cf74:	4d 89 f7             	mov    %r14,%r15
    cf77:	eb 27                	jmp    cfa0 <fwp_leb128+0x40>
    cf79:	4d 89 f7             	mov    %r14,%r15
    cf7c:	0f 1f 40 00          	nopl   0x0(%rax)
    cf80:	49 c1 ef 07          	shr    $0x7,%r15
    cf84:	44 89 f0             	mov    %r14d,%eax
    cf87:	0c 80                	or     $0x80,%al
    cf89:	0f be f0             	movsbl %al,%esi
    cf8c:	48 89 df             	mov    %rbx,%rdi
    cf8f:	e8 3c b3 ff ff       	call   82d0 <buf_putc>
    cf94:	49 81 fe ff 3f 00 00 	cmp    $0x3fff,%r14
    cf9b:	4d 89 fe             	mov    %r15,%r14
    cf9e:	77 e0                	ja     cf80 <fwp_leb128+0x20>
    cfa0:	41 0f be f7          	movsbl %r15b,%esi
    cfa4:	48 89 df             	mov    %rbx,%rdi
    cfa7:	5b                   	pop    %rbx
    cfa8:	41 5e                	pop    %r14
    cfaa:	41 5f                	pop    %r15
    cfac:	e9 1f b3 ff ff       	jmp    82d0 <buf_putc>
    cfb1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    cfb8:	0f 1f 84 00 00 00 00 
    cfbf:	00 

000000000000cfc0 <fwp_pipe_read>:
    cfc0:	55                   	push   %rbp
    cfc1:	41 57                	push   %r15
    cfc3:	41 56                	push   %r14
    cfc5:	41 55                	push   %r13
    cfc7:	41 54                	push   %r12
    cfc9:	53                   	push   %rbx
    cfca:	50                   	push   %rax
    cfcb:	48 89 f3             	mov    %rsi,%rbx
    cfce:	8b 05 a0 94 02 00    	mov    0x294a0(%rip),%eax        # 36474 <fwp_pi_kind>
    cfd4:	83 f8 01             	cmp    $0x1,%eax
    cfd7:	0f 84 89 00 00 00    	je     d066 <fwp_pipe_read+0xa6>
    cfdd:	83 f8 02             	cmp    $0x2,%eax
    cfe0:	0f 85 d7 00 00 00    	jne    d0bd <fwp_pipe_read+0xfd>
    cfe6:	48 89 3c 24          	mov    %rdi,(%rsp)
    cfea:	4c 8b 25 87 94 02 00 	mov    0x29487(%rip),%r12        # 36478 <fwp_pi_ring>
    cff1:	4d 8d ac 24 c0 00 00 	lea    0xc0(%r12),%r13
    cff8:	00 
    cff9:	49 8d ac 24 c4 00 00 	lea    0xc4(%r12),%rbp
    d000:	00 
    d001:	4c 8d 35 b8 01 00 00 	lea    0x1b8(%rip),%r14        # d1c0 <fwp_ring_has_data>
    d008:	45 31 ff             	xor    %r15d,%r15d
    d00b:	eb 23                	jmp    d030 <fwp_pipe_read+0x70>
    d00d:	0f 1f 00             	nopl   (%rax)
    d010:	44 8b 05 ad 8c 00 00 	mov    0x8cad(%rip),%r8d        # 15cc4 <fwp_pi_sock>
    d017:	4c 89 e7             	mov    %r12,%rdi
    d01a:	4c 89 ee             	mov    %r13,%rsi
    d01d:	48 89 ea             	mov    %rbp,%rdx
    d020:	4c 89 f1             	mov    %r14,%rcx
    d023:	e8 98 dc ff ff       	call   acc0 <fwp_ring_wait>
    d028:	85 c0                	test   %eax,%eax
    d02a:	0f 84 6c 01 00 00    	je     d19c <fwp_pipe_read+0x1dc>
    d030:	49 8b 4c 24 40       	mov    0x40(%r12),%rcx
    d035:	49 8b 84 24 80 00 00 	mov    0x80(%r12),%rax
    d03c:	00 
    d03d:	48 29 c1             	sub    %rax,%rcx
    d040:	0f 85 9c 00 00 00    	jne    d0e2 <fwp_pipe_read+0x122>
    d046:	41 8b 84 24 40 01 00 	mov    0x140(%r12),%eax
    d04d:	00 
    d04e:	85 c0                	test   %eax,%eax
    d050:	74 be                	je     d010 <fwp_pipe_read+0x50>
    d052:	49 8b 44 24 40       	mov    0x40(%r12),%rax
    d057:	49 3b 84 24 80 00 00 	cmp    0x80(%r12),%rax
    d05e:	00 
    d05f:	75 af                	jne    d010 <fwp_pipe_read+0x50>
    d061:	e9 36 01 00 00       	jmp    d19c <fwp_pipe_read+0x1dc>
    d066:	4c 8b 35 13 94 02 00 	mov    0x29413(%rip),%r14        # 36480 <fwp_pi_pos>
    d06d:	4c 8b 3d 14 94 02 00 	mov    0x29414(%rip),%r15        # 36488 <fwp_pi_len>
    d074:	4d 39 fe             	cmp    %r15,%r14
    d077:	0f 85 f9 00 00 00    	jne    d176 <fwp_pipe_read+0x1b6>
    d07d:	49 89 fc             	mov    %rdi,%r12
    d080:	4c 8d 35 09 94 02 00 	lea    0x29409(%rip),%r14        # 36490 <fwp_pi_buf>
    d087:	45 31 ff             	xor    %r15d,%r15d
    d08a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    d090:	8b 3d 2e 8c 00 00    	mov    0x8c2e(%rip),%edi        # 15cc4 <fwp_pi_sock>
    d096:	ba 00 00 01 00       	mov    $0x10000,%edx
    d09b:	4c 89 f6             	mov    %r14,%rsi
    d09e:	31 c9                	xor    %ecx,%ecx
    d0a0:	e8 bb 5f ff ff       	call   3060 <recv@plt>
    d0a5:	48 85 c0             	test   %rax,%rax
    d0a8:	0f 89 b6 00 00 00    	jns    d164 <fwp_pipe_read+0x1a4>
    d0ae:	e8 cd 5f ff ff       	call   3080 <__errno_location@plt>
    d0b3:	83 38 04             	cmpl   $0x4,(%rax)
    d0b6:	74 d8                	je     d090 <fwp_pipe_read+0xd0>
    d0b8:	e9 df 00 00 00       	jmp    d19c <fwp_pipe_read+0x1dc>
    d0bd:	48 8b 05 f4 6e 00 00 	mov    0x6ef4(%rip),%rax        # 13fb8 <stdin@GLIBC_2.2.5>
    d0c4:	48 8b 08             	mov    (%rax),%rcx
    d0c7:	be 01 00 00 00       	mov    $0x1,%esi
    d0cc:	48 89 da             	mov    %rbx,%rdx
    d0cf:	48 83 c4 08          	add    $0x8,%rsp
    d0d3:	5b                   	pop    %rbx
    d0d4:	41 5c                	pop    %r12
    d0d6:	41 5d                	pop    %r13
    d0d8:	41 5e                	pop    %r14
    d0da:	41 5f                	pop    %r15
    d0dc:	5d                   	pop    %rbp
    d0dd:	e9 0e 60 ff ff       	jmp    30f0 <fread@plt>
    d0e2:	48 39 d9             	cmp    %rbx,%rcx
    d0e5:	48 0f 42 d9          	cmovb  %rcx,%rbx
    d0e9:	4d 8b 74 24 08       	mov    0x8(%r12),%r14
    d0ee:	49 8d 4e ff          	lea    -0x1(%r14),%rcx
    d0f2:	48 21 c1             	and    %rax,%rcx
    d0f5:	49 29 ce             	sub    %rcx,%r14
    d0f8:	4c 39 f3             	cmp    %r14,%rbx
    d0fb:	4c 0f 42 f3          	cmovb  %rbx,%r14
    d0ff:	4d 8d bc 24 00 10 00 	lea    0x1000(%r12),%r15
    d106:	00 
    d107:	49 8d 34 0c          	lea    (%r12,%rcx,1),%rsi
    d10b:	48 81 c6 00 10 00 00 	add    $0x1000,%rsi
    d112:	4c 8b 2c 24          	mov    (%rsp),%r13
    d116:	4c 89 ef             	mov    %r13,%rdi
    d119:	4c 89 f2             	mov    %r14,%rdx
    d11c:	e8 0f 62 ff ff       	call   3330 <memcpy@plt>
    d121:	4d 01 f5             	add    %r14,%r13
    d124:	48 89 da             	mov    %rbx,%rdx
    d127:	4c 29 f2             	sub    %r14,%rdx
    d12a:	4c 89 ef             	mov    %r13,%rdi
    d12d:	4c 89 fe             	mov    %r15,%rsi
    d130:	e8 fb 61 ff ff       	call   3330 <memcpy@plt>
    d135:	49 8b 84 24 80 00 00 	mov    0x80(%r12),%rax
    d13c:	00 
    d13d:	48 01 d8             	add    %rbx,%rax
    d140:	49 89 84 24 80 00 00 	mov    %rax,0x80(%r12)
    d147:	00 
    d148:	49 8d bc 24 00 01 00 	lea    0x100(%r12),%rdi
    d14f:	00 
    d150:	49 81 c4 04 01 00 00 	add    $0x104,%r12
    d157:	4c 89 e6             	mov    %r12,%rsi
    d15a:	e8 c1 dc ff ff       	call   ae20 <fwp_ring_wake>
    d15f:	49 89 df             	mov    %rbx,%r15
    d162:	eb 38                	jmp    d19c <fwp_pipe_read+0x1dc>
    d164:	74 48                	je     d1ae <fwp_pipe_read+0x1ee>
    d166:	4c 89 e7             	mov    %r12,%rdi
    d169:	48 89 05 18 93 02 00 	mov    %rax,0x29318(%rip)        # 36488 <fwp_pi_len>
    d170:	45 31 f6             	xor    %r14d,%r14d
    d173:	49 89 c7             	mov    %rax,%r15
    d176:	4d 29 f7             	sub    %r14,%r15
    d179:	49 39 df             	cmp    %rbx,%r15
    d17c:	4c 0f 43 fb          	cmovae %rbx,%r15
    d180:	48 8d 35 09 93 02 00 	lea    0x29309(%rip),%rsi        # 36490 <fwp_pi_buf>
    d187:	4c 01 f6             	add    %r14,%rsi
    d18a:	4c 89 fa             	mov    %r15,%rdx
    d18d:	e8 9e 61 ff ff       	call   3330 <memcpy@plt>
    d192:	4d 01 fe             	add    %r15,%r14
    d195:	4c 89 35 e4 92 02 00 	mov    %r14,0x292e4(%rip)        # 36480 <fwp_pi_pos>
    d19c:	4c 89 f8             	mov    %r15,%rax
    d19f:	48 83 c4 08          	add    $0x8,%rsp
    d1a3:	5b                   	pop    %rbx
    d1a4:	41 5c                	pop    %r12
    d1a6:	41 5d                	pop    %r13
    d1a8:	41 5e                	pop    %r14
    d1aa:	41 5f                	pop    %r15
    d1ac:	5d                   	pop    %rbp
    d1ad:	c3                   	ret
    d1ae:	45 31 ff             	xor    %r15d,%r15d
    d1b1:	eb e9                	jmp    d19c <fwp_pipe_read+0x1dc>
    d1b3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d1ba:	84 00 00 00 00 00 

000000000000d1c0 <fwp_ring_has_data>:
    d1c0:	48 8b 4f 40          	mov    0x40(%rdi),%rcx
    d1c4:	b8 01 00 00 00       	mov    $0x1,%eax
    d1c9:	48 3b 8f 80 00 00 00 	cmp    0x80(%rdi),%rcx
    d1d0:	75 0d                	jne    d1df <fwp_ring_has_data+0x1f>
    d1d2:	8b 8f 40 01 00 00    	mov    0x140(%rdi),%ecx
    d1d8:	31 c0                	xor    %eax,%eax
    d1da:	85 c9                	test   %ecx,%ecx
    d1dc:	0f 95 c0             	setne  %al
    d1df:	c3                   	ret

000000000000d1e0 <fwp_pipe_report>:
    d1e0:	53                   	push   %rbx
    d1e1:	48 89 fb             	mov    %rdi,%rbx
    d1e4:	48 8d 3d df 22 00 00 	lea    0x22df(%rip),%rdi        # f4ca <exec_in_fp0+0xdca>
    d1eb:	e8 40 5e ff ff       	call   3030 <getenv@plt>
    d1f0:	48 85 c0             	test   %rax,%rax
    d1f3:	74 18                	je     d20d <fwp_pipe_report+0x2d>
    d1f5:	80 38 00             	cmpb   $0x0,(%rax)
    d1f8:	74 13                	je     d20d <fwp_pipe_report+0x2d>
    d1fa:	48 8d 35 9c 22 00 00 	lea    0x229c(%rip),%rsi        # f49d <exec_in_fp0+0xd9d>
    d201:	48 89 c7             	mov    %rax,%rdi
    d204:	e8 c7 60 ff ff       	call   32d0 <strcmp@plt>
    d209:	85 c0                	test   %eax,%eax
    d20b:	75 02                	jne    d20f <fwp_pipe_report+0x2f>
    d20d:	5b                   	pop    %rbx
    d20e:	c3                   	ret
    d20f:	48 8b 05 c2 6d 00 00 	mov    0x6dc2(%rip),%rax        # 13fd8 <stderr@GLIBC_2.2.5>
    d216:	48 8b 38             	mov    (%rax),%rdi
    d219:	48 8d 35 bf 22 00 00 	lea    0x22bf(%rip),%rsi        # f4df <exec_in_fp0+0xddf>
    d220:	48 89 da             	mov    %rbx,%rdx
    d223:	31 c0                	xor    %eax,%eax
    d225:	5b                   	pop    %rbx
    d226:	e9 c5 60 ff ff       	jmp    32f0 <fprintf@plt>
    d22b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000d230 <rd_le>:
    d230:	55                   	push   %rbp
    d231:	41 56                	push   %r14
    d233:	53                   	push   %rbx
    d234:	48 83 ec 10          	sub    $0x10,%rsp
    d238:	48 89 d3             	mov    %rdx,%rbx
    d23b:	89 f5                	mov    %esi,%ebp
    d23d:	41 89 f6             	mov    %esi,%r14d
    d240:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    d245:	4c 89 f6             	mov    %r14,%rsi
    d248:	e8 23 01 00 00       	call   d370 <rd_take>
    d24d:	85 c0                	test   %eax,%eax
    d24f:	74 20                	je     d271 <rd_le+0x41>
    d251:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    d258:	b8 01 00 00 00       	mov    $0x1,%eax
    d25d:	85 ed                	test   %ebp,%ebp
    d25f:	7e 7d                	jle    d2de <rd_le+0xae>
    d261:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    d266:	83 fd 01             	cmp    $0x1,%ebp
    d269:	75 0a                	jne    d275 <rd_le+0x45>
    d26b:	31 d2                	xor    %edx,%edx
    d26d:	31 ff                	xor    %edi,%edi
    d26f:	eb 55                	jmp    d2c6 <rd_le+0x96>
    d271:	31 c0                	xor    %eax,%eax
    d273:	eb 69                	jmp    d2de <rd_le+0xae>
    d275:	45 89 f0             	mov    %r14d,%r8d
    d278:	41 81 e0 fe ff ff 7f 	and    $0x7ffffffe,%r8d
    d27f:	41 b9 08 00 00 00    	mov    $0x8,%r9d
    d285:	31 d2                	xor    %edx,%edx
    d287:	31 ff                	xor    %edi,%edi
    d289:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    d290:	44 0f b6 14 16       	movzbl (%rsi,%rdx,1),%r10d
    d295:	41 8d 49 f8          	lea    -0x8(%r9),%ecx
    d299:	80 e1 f0             	and    $0xf0,%cl
    d29c:	49 d3 e2             	shl    %cl,%r10
    d29f:	49 09 fa             	or     %rdi,%r10
    d2a2:	4c 89 13             	mov    %r10,(%rbx)
    d2a5:	0f b6 7c 16 01       	movzbl 0x1(%rsi,%rdx,1),%edi
    d2aa:	44 89 c9             	mov    %r9d,%ecx
    d2ad:	80 e1 f8             	and    $0xf8,%cl
    d2b0:	48 d3 e7             	shl    %cl,%rdi
    d2b3:	4c 09 d7             	or     %r10,%rdi
    d2b6:	48 89 3b             	mov    %rdi,(%rbx)
    d2b9:	48 83 c2 02          	add    $0x2,%rdx
    d2bd:	49 83 c1 10          	add    $0x10,%r9
    d2c1:	49 39 d0             	cmp    %rdx,%r8
    d2c4:	75 ca                	jne    d290 <rd_le+0x60>
    d2c6:	41 f6 c6 01          	test   $0x1,%r14b
    d2ca:	74 12                	je     d2de <rd_le+0xae>
    d2cc:	0f b6 34 16          	movzbl (%rsi,%rdx,1),%esi
    d2d0:	c1 e2 03             	shl    $0x3,%edx
    d2d3:	89 d1                	mov    %edx,%ecx
    d2d5:	48 d3 e6             	shl    %cl,%rsi
    d2d8:	48 09 fe             	or     %rdi,%rsi
    d2db:	48 89 33             	mov    %rsi,(%rbx)
    d2de:	48 83 c4 10          	add    $0x10,%rsp
    d2e2:	5b                   	pop    %rbx
    d2e3:	41 5e                	pop    %r14
    d2e5:	5d                   	pop    %rbp
    d2e6:	c3                   	ret
    d2e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    d2ee:	00 00 

000000000000d2f0 <rd_leb>:
    d2f0:	41 57                	push   %r15
    d2f2:	41 56                	push   %r14
    d2f4:	41 54                	push   %r12
    d2f6:	53                   	push   %rbx
    d2f7:	50                   	push   %rax
    d2f8:	48 89 f3             	mov    %rsi,%rbx
    d2fb:	49 89 fe             	mov    %rdi,%r14
    d2fe:	48 c7 06 00 00 00 00 	movq   $0x0,(%rsi)
    d305:	49 c7 c7 f9 ff ff ff 	mov    $0xfffffffffffffff9,%r15
    d30c:	49 89 e4             	mov    %rsp,%r12
    d30f:	90                   	nop
    d310:	be 01 00 00 00       	mov    $0x1,%esi
    d315:	4c 89 f7             	mov    %r14,%rdi
    d318:	4c 89 e2             	mov    %r12,%rdx
    d31b:	e8 50 00 00 00       	call   d370 <rd_take>
    d320:	85 c0                	test   %eax,%eax
    d322:	74 2f                	je     d353 <rd_leb+0x63>
    d324:	48 8b 04 24          	mov    (%rsp),%rax
    d328:	0f b6 10             	movzbl (%rax),%edx
    d32b:	49 83 ff 38          	cmp    $0x38,%r15
    d32f:	75 07                	jne    d338 <rd_leb+0x48>
    d331:	89 d1                	mov    %edx,%ecx
    d333:	80 e1 7e             	and    $0x7e,%cl
    d336:	75 1b                	jne    d353 <rd_leb+0x63>
    d338:	49 83 c7 07          	add    $0x7,%r15
    d33c:	83 e2 7f             	and    $0x7f,%edx
    d33f:	44 89 f9             	mov    %r15d,%ecx
    d342:	48 d3 e2             	shl    %cl,%rdx
    d345:	48 09 13             	or     %rdx,(%rbx)
    d348:	80 38 00             	cmpb   $0x0,(%rax)
    d34b:	79 0a                	jns    d357 <rd_leb+0x67>
    d34d:	49 83 ff 38          	cmp    $0x38,%r15
    d351:	76 bd                	jbe    d310 <rd_leb+0x20>
    d353:	31 c0                	xor    %eax,%eax
    d355:	eb 05                	jmp    d35c <rd_leb+0x6c>
    d357:	b8 01 00 00 00       	mov    $0x1,%eax
    d35c:	48 83 c4 08          	add    $0x8,%rsp
    d360:	5b                   	pop    %rbx
    d361:	41 5c                	pop    %r12
    d363:	41 5e                	pop    %r14
    d365:	41 5f                	pop    %r15
    d367:	c3                   	ret
    d368:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    d36f:	00 

000000000000d370 <rd_take>:
    d370:	4c 8b 47 08          	mov    0x8(%rdi),%r8
    d374:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    d378:	49 29 c8             	sub    %rcx,%r8
    d37b:	31 c0                	xor    %eax,%eax
    d37d:	49 39 f0             	cmp    %rsi,%r8
    d380:	72 15                	jb     d397 <rd_take+0x27>
    d382:	48 8b 07             	mov    (%rdi),%rax
    d385:	48 01 c8             	add    %rcx,%rax
    d388:	48 89 02             	mov    %rax,(%rdx)
    d38b:	48 01 ce             	add    %rcx,%rsi
    d38e:	48 89 77 10          	mov    %rsi,0x10(%rdi)
    d392:	b8 01 00 00 00       	mov    $0x1,%eax
    d397:	c3                   	ret
    d398:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    d39f:	00 

000000000000d3a0 <fwp_getc>:
    d3a0:	48 63 05 85 90 01 00 	movslq 0x19085(%rip),%rax        # 2642c <fwp_in_ppos>
    d3a7:	3b 05 7b 90 01 00    	cmp    0x1907b(%rip),%eax        # 26428 <fwp_in_npend>
    d3ad:	7d 15                	jge    d3c4 <fwp_getc+0x24>
    d3af:	8d 48 01             	lea    0x1(%rax),%ecx
    d3b2:	89 0d 74 90 01 00    	mov    %ecx,0x19074(%rip)        # 2642c <fwp_in_ppos>
    d3b8:	48 8d 0d 65 90 01 00 	lea    0x19065(%rip),%rcx        # 26424 <fwp_in_pend>
    d3bf:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax
    d3c3:	c3                   	ret
    d3c4:	48 8b 05 ed 6b 00 00 	mov    0x6bed(%rip),%rax        # 13fb8 <stdin@GLIBC_2.2.5>
    d3cb:	48 8b 38             	mov    (%rax),%rdi
    d3ce:	e9 4d 5e ff ff       	jmp    3220 <fgetc@plt>
    d3d3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d3da:	84 00 00 00 00 00 

000000000000d3e0 <fwp_gc_find_data>:
    d3e0:	0f b7 77 18          	movzwl 0x18(%rdi),%esi
    d3e4:	48 85 f6             	test   %rsi,%rsi
    d3e7:	0f 84 be 00 00 00    	je     d4ab <fwp_gc_find_data+0xcb>
    d3ed:	53                   	push   %rbx
    d3ee:	48 8b 07             	mov    (%rdi),%rax
    d3f1:	4c 8b 47 10          	mov    0x10(%rdi),%r8
    d3f5:	48 6b ce 38          	imul   $0x38,%rsi,%rcx
    d3f9:	45 31 c9             	xor    %r9d,%r9d
    d3fc:	48 8d 15 95 6e 00 00 	lea    0x6e95(%rip),%rdx        # 14298 <fwp_gc>
    d403:	41 bb 01 00 00 00    	mov    $0x1,%r11d
    d409:	45 31 d2             	xor    %r10d,%r10d
    d40c:	eb 0b                	jmp    d419 <fwp_gc_find_data+0x39>
    d40e:	66 90                	xchg   %ax,%ax
    d410:	49 83 c1 38          	add    $0x38,%r9
    d414:	4c 39 c9             	cmp    %r9,%rcx
    d417:	74 22                	je     d43b <fwp_gc_find_data+0x5b>
    d419:	43 83 3c 08 01       	cmpl   $0x1,(%r8,%r9,1)
    d41e:	75 f0                	jne    d410 <fwp_gc_find_data+0x30>
    d420:	4b 8b 5c 08 10       	mov    0x10(%r8,%r9,1),%rbx
    d425:	48 01 c3             	add    %rax,%rbx
    d428:	48 39 d3             	cmp    %rdx,%rbx
    d42b:	77 e3                	ja     d410 <fwp_gc_find_data+0x30>
    d42d:	4b 03 5c 08 28       	add    0x28(%r8,%r9,1),%rbx
    d432:	48 39 d3             	cmp    %rdx,%rbx
    d435:	45 0f 47 d3          	cmova  %r11d,%r10d
    d439:	eb d5                	jmp    d410 <fwp_gc_find_data+0x30>
    d43b:	31 c0                	xor    %eax,%eax
    d43d:	45 85 d2             	test   %r10d,%r10d
    d440:	0f 95 c0             	setne  %al
    d443:	74 6e                	je     d4b3 <fwp_gc_find_data+0xd3>
    d445:	66 85 f6             	test   %si,%si
    d448:	74 69                	je     d4b3 <fwp_gc_find_data+0xd3>
    d44a:	8b 05 d8 7f 00 00    	mov    0x7fd8(%rip),%eax        # 15428 <fwp_gc+0x1190>
    d450:	48 8b 77 10          	mov    0x10(%rdi),%rsi
    d454:	45 31 c0             	xor    %r8d,%r8d
    d457:	eb 10                	jmp    d469 <fwp_gc_find_data+0x89>
    d459:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    d460:	49 83 c0 38          	add    $0x38,%r8
    d464:	4c 39 c1             	cmp    %r8,%rcx
    d467:	74 45                	je     d4ae <fwp_gc_find_data+0xce>
    d469:	42 83 3c 06 01       	cmpl   $0x1,(%rsi,%r8,1)
    d46e:	75 f0                	jne    d460 <fwp_gc_find_data+0x80>
    d470:	42 f6 44 06 04 02    	testb  $0x2,0x4(%rsi,%r8,1)
    d476:	74 e8                	je     d460 <fwp_gc_find_data+0x80>
    d478:	83 f8 10             	cmp    $0x10,%eax
    d47b:	74 31                	je     d4ae <fwp_gc_find_data+0xce>
    d47d:	4e 8b 4c 06 10       	mov    0x10(%rsi,%r8,1),%r9
    d482:	4c 03 0f             	add    (%rdi),%r9
    d485:	4c 63 d0             	movslq %eax,%r10
    d488:	49 c1 e2 04          	shl    $0x4,%r10
    d48c:	4d 89 8c 12 90 10 00 	mov    %r9,0x1090(%r10,%rdx,1)
    d493:	00 
    d494:	4e 8b 4c 06 28       	mov    0x28(%rsi,%r8,1),%r9
    d499:	4d 89 8c 12 98 10 00 	mov    %r9,0x1098(%r10,%rdx,1)
    d4a0:	00 
    d4a1:	ff c0                	inc    %eax
    d4a3:	89 05 7f 7f 00 00    	mov    %eax,0x7f7f(%rip)        # 15428 <fwp_gc+0x1190>
    d4a9:	eb b5                	jmp    d460 <fwp_gc_find_data+0x80>
    d4ab:	31 c0                	xor    %eax,%eax
    d4ad:	c3                   	ret
    d4ae:	b8 01 00 00 00       	mov    $0x1,%eax
    d4b3:	5b                   	pop    %rbx
    d4b4:	c3                   	ret
    d4b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    d4bc:	00 00 00 00 

000000000000d4c0 <fwp_gc_report>:
    d4c0:	41 57                	push   %r15
    d4c2:	41 56                	push   %r14
    d4c4:	53                   	push   %rbx
    d4c5:	48 83 ec 50          	sub    $0x50,%rsp
    d4c9:	48 8b 05 d8 7f 00 00 	mov    0x7fd8(%rip),%rax        # 154a8 <fwp_gc+0x1210>
    d4d0:	48 8b 0d c1 6d 00 00 	mov    0x6dc1(%rip),%rcx        # 14298 <fwp_gc>
    d4d7:	48 29 c8             	sub    %rcx,%rax
    d4da:	f2 48 0f 2a c8       	cvtsi2sd %rax,%xmm1
    d4df:	f2 0f 58 0d 99 7f 00 	addsd  0x7f99(%rip),%xmm1        # 15480 <fwp_gc+0x11e8>
    d4e6:	00 
    d4e7:	f2 0f 11 0d 91 7f 00 	movsd  %xmm1,0x7f91(%rip)        # 15480 <fwp_gc+0x11e8>
    d4ee:	00 
    d4ef:	48 89 0d b2 7f 00 00 	mov    %rcx,0x7fb2(%rip)        # 154a8 <fwp_gc+0x1210>
    d4f6:	48 8b 05 db 6a 00 00 	mov    0x6adb(%rip),%rax        # 13fd8 <stderr@GLIBC_2.2.5>
    d4fd:	4c 8b 38             	mov    (%rax),%r15
    d500:	48 8b 1d 69 7f 00 00 	mov    0x7f69(%rip),%rbx        # 15470 <fwp_gc+0x11d8>
    d507:	4c 8b 35 a2 7d 00 00 	mov    0x7da2(%rip),%r14        # 152b0 <fwp_gc+0x1018>
    d50e:	f2 0f 10 15 8a 7f 00 	movsd  0x7f8a(%rip),%xmm2        # 154a0 <fwp_gc+0x1208>
    d515:	00 
    d516:	f2 0f 58 ca          	addsd  %xmm2,%xmm1
    d51a:	f2 0f 10 05 56 0c 00 	movsd  0xc56(%rip),%xmm0        # e178 <_IO_stdin_used+0x178>
    d521:	00 
    d522:	f2 0f 59 c8          	mulsd  %xmm0,%xmm1
    d526:	f2 0f 11 4c 24 18    	movsd  %xmm1,0x18(%rsp)
    d52c:	f2 0f 59 d0          	mulsd  %xmm0,%xmm2
    d530:	f2 0f 11 54 24 10    	movsd  %xmm2,0x10(%rsp)
    d536:	f2 0f 10 0d a2 7d 00 	movsd  0x7da2(%rip),%xmm1        # 152e0 <fwp_gc+0x1048>
    d53d:	00 
    d53e:	66 0f 28 15 da 0b 00 	movapd 0xbda(%rip),%xmm2        # e120 <_IO_stdin_used+0x120>
    d545:	00 
    d546:	0f 14 ca             	unpcklps %xmm2,%xmm1
    d549:	66 0f 28 1d df 0b 00 	movapd 0xbdf(%rip),%xmm3        # e130 <_IO_stdin_used+0x130>
    d550:	00 
    d551:	66 0f 5c cb          	subpd  %xmm3,%xmm1
    d555:	66 0f 28 e1          	movapd %xmm1,%xmm4
    d559:	66 0f 15 e1          	unpckhpd %xmm1,%xmm4
    d55d:	f2 0f 58 e1          	addsd  %xmm1,%xmm4
    d561:	f2 0f 59 e0          	mulsd  %xmm0,%xmm4
    d565:	66 0f 29 64 24 40    	movapd %xmm4,0x40(%rsp)
    d56b:	f2 0f 10 0d ed 7e 00 	movsd  0x7eed(%rip),%xmm1        # 15460 <fwp_gc+0x11c8>
    d572:	00 
    d573:	0f 14 ca             	unpcklps %xmm2,%xmm1
    d576:	66 0f 5c cb          	subpd  %xmm3,%xmm1
    d57a:	66 0f 28 e1          	movapd %xmm1,%xmm4
    d57e:	66 0f 15 e1          	unpckhpd %xmm1,%xmm4
    d582:	f2 0f 58 e1          	addsd  %xmm1,%xmm4
    d586:	f2 0f 59 e0          	mulsd  %xmm0,%xmm4
    d58a:	66 0f 29 64 24 30    	movapd %xmm4,0x30(%rsp)
    d590:	f2 0f 10 0d d0 7e 00 	movsd  0x7ed0(%rip),%xmm1        # 15468 <fwp_gc+0x11d0>
    d597:	00 
    d598:	0f 14 ca             	unpcklps %xmm2,%xmm1
    d59b:	66 0f 5c cb          	subpd  %xmm3,%xmm1
    d59f:	66 0f 28 d1          	movapd %xmm1,%xmm2
    d5a3:	66 0f 15 d1          	unpckhpd %xmm1,%xmm2
    d5a7:	f2 0f 58 d1          	addsd  %xmm1,%xmm2
    d5ab:	f2 0f 59 d0          	mulsd  %xmm0,%xmm2
    d5af:	66 0f 29 54 24 20    	movapd %xmm2,0x20(%rsp)
    d5b5:	f2 0f 10 05 cb 7e 00 	movsd  0x7ecb(%rip),%xmm0        # 15488 <fwp_gc+0x11f0>
    d5bc:	00 
    d5bd:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    d5c3:	f2 0f 10 05 c5 7e 00 	movsd  0x7ec5(%rip),%xmm0        # 15490 <fwp_gc+0x11f8>
    d5ca:	00 
    d5cb:	f2 0f 11 04 24       	movsd  %xmm0,(%rsp)
    d5d0:	e8 6b 00 00 00       	call   d640 <fwp_gc_status_kb>
    d5d5:	83 3d b0 7c 00 00 00 	cmpl   $0x0,0x7cb0(%rip)        # 1528c <fwp_gc+0xff4>
    d5dc:	48 8d 0d 99 20 00 00 	lea    0x2099(%rip),%rcx        # f67c <exec_in_fp0+0xf7c>
    d5e3:	4c 8d 0d f7 18 00 00 	lea    0x18f7(%rip),%r9        # eee1 <exec_in_fp0+0x7e1>
    d5ea:	4c 0f 44 c9          	cmove  %rcx,%r9
    d5ee:	48 8d 35 d2 1f 00 00 	lea    0x1fd2(%rip),%rsi        # f5c7 <exec_in_fp0+0xec7>
    d5f5:	4c 89 ff             	mov    %r15,%rdi
    d5f8:	48 89 da             	mov    %rbx,%rdx
    d5fb:	4c 89 f1             	mov    %r14,%rcx
    d5fe:	f2 0f 10 44 24 18    	movsd  0x18(%rsp),%xmm0
    d604:	f2 0f 10 4c 24 10    	movsd  0x10(%rsp),%xmm1
    d60a:	0f 28 54 24 40       	movaps 0x40(%rsp),%xmm2
    d60f:	0f 28 5c 24 30       	movaps 0x30(%rsp),%xmm3
    d614:	0f 28 64 24 20       	movaps 0x20(%rsp),%xmm4
    d619:	f2 0f 10 6c 24 08    	movsd  0x8(%rsp),%xmm5
    d61f:	f2 0f 10 34 24       	movsd  (%rsp),%xmm6
    d624:	49 89 c0             	mov    %rax,%r8
    d627:	b0 07                	mov    $0x7,%al
    d629:	48 83 c4 50          	add    $0x50,%rsp
    d62d:	5b                   	pop    %rbx
    d62e:	41 5e                	pop    %r14
    d630:	41 5f                	pop    %r15
    d632:	e9 b9 5c ff ff       	jmp    32f0 <fprintf@plt>
    d637:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    d63e:	00 00 

000000000000d640 <fwp_gc_status_kb>:
    d640:	55                   	push   %rbp
    d641:	41 57                	push   %r15
    d643:	41 56                	push   %r14
    d645:	41 54                	push   %r12
    d647:	53                   	push   %rbx
    d648:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
    d64f:	48 8d 3d 38 20 00 00 	lea    0x2038(%rip),%rdi        # f68e <exec_in_fp0+0xf8e>
    d656:	48 8d 35 4f 1e 00 00 	lea    0x1e4f(%rip),%rsi        # f4ac <exec_in_fp0+0xdac>
    d65d:	e8 be 5d ff ff       	call   3420 <fopen@plt>
    d662:	48 85 c0             	test   %rax,%rax
    d665:	74 7d                	je     d6e4 <fwp_gc_status_kb+0xa4>
    d667:	48 89 c3             	mov    %rax,%rbx
    d66a:	48 89 e7             	mov    %rsp,%rdi
    d66d:	be 00 01 00 00       	mov    $0x100,%esi
    d672:	48 89 c2             	mov    %rax,%rdx
    d675:	e8 16 5c ff ff       	call   3290 <fgets@plt>
    d67a:	49 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%r14
    d681:	48 85 c0             	test   %rax,%rax
    d684:	74 54                	je     d6da <fwp_gc_status_kb+0x9a>
    d686:	4c 8d 7c 24 06       	lea    0x6(%rsp),%r15
    d68b:	bd 56 6d 48 57       	mov    $0x57486d56,%ebp
    d690:	49 89 e4             	mov    %rsp,%r12
    d693:	eb 20                	jmp    d6b5 <fwp_gc_status_kb+0x75>
    d695:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    d69c:	00 00 00 00 
    d6a0:	4c 89 e7             	mov    %r12,%rdi
    d6a3:	be 00 01 00 00       	mov    $0x100,%esi
    d6a8:	48 89 da             	mov    %rbx,%rdx
    d6ab:	e8 e0 5b ff ff       	call   3290 <fgets@plt>
    d6b0:	48 85 c0             	test   %rax,%rax
    d6b3:	74 25                	je     d6da <fwp_gc_status_kb+0x9a>
    d6b5:	8b 04 24             	mov    (%rsp),%eax
    d6b8:	31 e8                	xor    %ebp,%eax
    d6ba:	0f b6 4c 24 04       	movzbl 0x4(%rsp),%ecx
    d6bf:	83 f1 4d             	xor    $0x4d,%ecx
    d6c2:	09 c1                	or     %eax,%ecx
    d6c4:	75 da                	jne    d6a0 <fwp_gc_status_kb+0x60>
    d6c6:	80 7c 24 05 3a       	cmpb   $0x3a,0x5(%rsp)
    d6cb:	75 d3                	jne    d6a0 <fwp_gc_status_kb+0x60>
    d6cd:	4c 89 ff             	mov    %r15,%rdi
    d6d0:	e8 2b 5d ff ff       	call   3400 <atol@plt>
    d6d5:	49 89 c6             	mov    %rax,%r14
    d6d8:	eb c6                	jmp    d6a0 <fwp_gc_status_kb+0x60>
    d6da:	48 89 df             	mov    %rbx,%rdi
    d6dd:	e8 6e 5a ff ff       	call   3150 <fclose@plt>
    d6e2:	eb 07                	jmp    d6eb <fwp_gc_status_kb+0xab>
    d6e4:	49 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%r14
    d6eb:	4c 89 f0             	mov    %r14,%rax
    d6ee:	48 81 c4 00 01 00 00 	add    $0x100,%rsp
    d6f5:	5b                   	pop    %rbx
    d6f6:	41 5c                	pop    %r12
    d6f8:	41 5e                	pop    %r14
    d6fa:	41 5f                	pop    %r15
    d6fc:	5d                   	pop    %rbp
    d6fd:	c3                   	ret
    d6fe:	66 90                	xchg   %ax,%ax

000000000000d700 <w0>:
    d700:	55                   	push   %rbp
    d701:	41 57                	push   %r15
    d703:	41 56                	push   %r14
    d705:	41 55                	push   %r13
    d707:	41 54                	push   %r12
    d709:	53                   	push   %rbx
    d70a:	48 81 ec b8 01 00 00 	sub    $0x1b8,%rsp
    d711:	49 89 f6             	mov    %rsi,%r14
    d714:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
    d719:	48 89 f7             	mov    %rsi,%rdi
    d71c:	48 c7 c6 80 ff ff ff 	mov    $0xffffffffffffff80,%rsi
    d723:	e8 68 8a ff ff       	call   6190 <f10>
    d728:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    d72d:	49 89 c7             	mov    %rax,%r15
    d730:	48 8d 35 49 03 00 00 	lea    0x349(%rip),%rsi        # da80 <fwp_owner_release0>
    d737:	4c 8d ac 24 a0 01 00 	lea    0x1a0(%rsp),%r13
    d73e:	00 
    d73f:	48 8d 54 24 30       	lea    0x30(%rsp),%rdx
    d744:	4c 89 ef             	mov    %r13,%rdi
    d747:	e8 a4 02 00 00       	call   d9f0 <fwp_cleanup_push>
    d74c:	be ff 00 00 00       	mov    $0xff,%esi
    d751:	4c 89 f7             	mov    %r14,%rdi
    d754:	e8 47 8b ff ff       	call   62a0 <f12>
    d759:	49 89 c4             	mov    %rax,%r12
    d75c:	4c 89 ef             	mov    %r13,%rdi
    d75f:	e8 fc 02 00 00       	call   da60 <fwp_cleanup_pop>
    d764:	4c 89 7c 24 38       	mov    %r15,0x38(%rsp)
    d769:	4c 89 64 24 40       	mov    %r12,0x40(%rsp)
    d76e:	48 8d 35 1b 03 00 00 	lea    0x31b(%rip),%rsi        # da90 <fwp_owner_release1>
    d775:	4c 8d ac 24 88 01 00 	lea    0x188(%rsp),%r13
    d77c:	00 
    d77d:	48 8d 54 24 38       	lea    0x38(%rsp),%rdx
    d782:	4c 89 ef             	mov    %r13,%rdi
    d785:	e8 66 02 00 00       	call   d9f0 <fwp_cleanup_push>
    d78a:	4c 89 f7             	mov    %r14,%rdi
    d78d:	48 c7 c6 00 80 ff ff 	mov    $0xffffffffffff8000,%rsi
    d794:	e8 17 8b ff ff       	call   62b0 <f14>
    d799:	48 89 c5             	mov    %rax,%rbp
    d79c:	4c 89 ef             	mov    %r13,%rdi
    d79f:	e8 bc 02 00 00       	call   da60 <fwp_cleanup_pop>
    d7a4:	4c 89 7c 24 48       	mov    %r15,0x48(%rsp)
    d7a9:	4c 89 64 24 50       	mov    %r12,0x50(%rsp)
    d7ae:	48 89 6c 24 58       	mov    %rbp,0x58(%rsp)
    d7b3:	48 8d 35 f6 02 00 00 	lea    0x2f6(%rip),%rsi        # dab0 <fwp_owner_release2>
    d7ba:	48 8d 9c 24 70 01 00 	lea    0x170(%rsp),%rbx
    d7c1:	00 
    d7c2:	48 8d 54 24 48       	lea    0x48(%rsp),%rdx
    d7c7:	48 89 df             	mov    %rbx,%rdi
    d7ca:	e8 21 02 00 00       	call   d9f0 <fwp_cleanup_push>
    d7cf:	be ff ff 00 00       	mov    $0xffff,%esi
    d7d4:	4c 89 f7             	mov    %r14,%rdi
    d7d7:	e8 e4 8a ff ff       	call   62c0 <f16>
    d7dc:	49 89 c5             	mov    %rax,%r13
    d7df:	48 89 df             	mov    %rbx,%rdi
    d7e2:	e8 79 02 00 00       	call   da60 <fwp_cleanup_pop>
    d7e7:	4c 89 7c 24 60       	mov    %r15,0x60(%rsp)
    d7ec:	4c 89 3c 24          	mov    %r15,(%rsp)
    d7f0:	4c 89 64 24 68       	mov    %r12,0x68(%rsp)
    d7f5:	4c 89 e3             	mov    %r12,%rbx
    d7f8:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
    d7fd:	48 89 6c 24 70       	mov    %rbp,0x70(%rsp)
    d802:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
    d807:	4c 89 6c 24 78       	mov    %r13,0x78(%rsp)
    d80c:	48 8d 35 bd 02 00 00 	lea    0x2bd(%rip),%rsi        # dad0 <fwp_owner_release3>
    d813:	48 8d bc 24 40 01 00 	lea    0x140(%rsp),%rdi
    d81a:	00 
    d81b:	48 8d 54 24 60       	lea    0x60(%rsp),%rdx
    d820:	e8 cb 01 00 00       	call   d9f0 <fwp_cleanup_push>
    d825:	4c 89 f7             	mov    %r14,%rdi
    d828:	48 c7 c6 00 00 00 80 	mov    $0xffffffff80000000,%rsi
    d82f:	e8 9c 8a ff ff       	call   62d0 <f18>
    d834:	49 89 c4             	mov    %rax,%r12
    d837:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    d83c:	48 8d bc 24 40 01 00 	lea    0x140(%rsp),%rdi
    d843:	00 
    d844:	e8 17 02 00 00       	call   da60 <fwp_cleanup_pop>
    d849:	4c 89 bc 24 80 00 00 	mov    %r15,0x80(%rsp)
    d850:	00 
    d851:	48 89 9c 24 88 00 00 	mov    %rbx,0x88(%rsp)
    d858:	00 
    d859:	48 89 ac 24 90 00 00 	mov    %rbp,0x90(%rsp)
    d860:	00 
    d861:	4c 89 ac 24 98 00 00 	mov    %r13,0x98(%rsp)
    d868:	00 
    d869:	4c 89 a4 24 a0 00 00 	mov    %r12,0xa0(%rsp)
    d870:	00 
    d871:	48 8d 35 88 02 00 00 	lea    0x288(%rip),%rsi        # db00 <fwp_owner_release4>
    d878:	4c 8d a4 24 58 01 00 	lea    0x158(%rsp),%r12
    d87f:	00 
    d880:	48 8d 94 24 80 00 00 	lea    0x80(%rsp),%rdx
    d887:	00 
    d888:	4c 89 e7             	mov    %r12,%rdi
    d88b:	e8 60 01 00 00       	call   d9f0 <fwp_cleanup_push>
    d890:	b8 00 00 00 80       	mov    $0x80000000,%eax
    d895:	48 8d b0 ff ff ff 7f 	lea    0x7fffffff(%rax),%rsi
    d89c:	4c 89 f7             	mov    %r14,%rdi
    d89f:	4c 89 f3             	mov    %r14,%rbx
    d8a2:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    d8a7:	e8 34 8a ff ff       	call   62e0 <f20>
    d8ac:	49 89 c7             	mov    %rax,%r15
    d8af:	4c 89 e7             	mov    %r12,%rdi
    d8b2:	e8 a9 01 00 00       	call   da60 <fwp_cleanup_pop>
    d8b7:	48 8b 04 24          	mov    (%rsp),%rax
    d8bb:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
    d8c2:	00 
    d8c3:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
    d8c8:	48 89 ac 24 b0 00 00 	mov    %rbp,0xb0(%rsp)
    d8cf:	00 
    d8d0:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    d8d5:	4c 89 a4 24 b8 00 00 	mov    %r12,0xb8(%rsp)
    d8dc:	00 
    d8dd:	4c 89 ac 24 c0 00 00 	mov    %r13,0xc0(%rsp)
    d8e4:	00 
    d8e5:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
    d8ea:	4c 89 b4 24 c8 00 00 	mov    %r14,0xc8(%rsp)
    d8f1:	00 
    d8f2:	4c 89 bc 24 d0 00 00 	mov    %r15,0xd0(%rsp)
    d8f9:	00 
    d8fa:	48 8d 35 3f 02 00 00 	lea    0x23f(%rip),%rsi        # db40 <fwp_owner_release5>
    d901:	48 8d bc 24 28 01 00 	lea    0x128(%rsp),%rdi
    d908:	00 
    d909:	48 8d 94 24 a8 00 00 	lea    0xa8(%rsp),%rdx
    d910:	00 
    d911:	e8 da 00 00 00       	call   d9f0 <fwp_cleanup_push>
    d916:	be 00 00 00 80       	mov    $0x80000000,%esi
    d91b:	48 89 df             	mov    %rbx,%rdi
    d91e:	e8 cd 89 ff ff       	call   62f0 <f22>
    d923:	48 89 c3             	mov    %rax,%rbx
    d926:	48 8d bc 24 28 01 00 	lea    0x128(%rsp),%rdi
    d92d:	00 
    d92e:	e8 2d 01 00 00       	call   da60 <fwp_cleanup_pop>
    d933:	48 8b 04 24          	mov    (%rsp),%rax
    d937:	48 89 84 24 d8 00 00 	mov    %rax,0xd8(%rsp)
    d93e:	00 
    d93f:	48 89 ac 24 e0 00 00 	mov    %rbp,0xe0(%rsp)
    d946:	00 
    d947:	4c 89 a4 24 e8 00 00 	mov    %r12,0xe8(%rsp)
    d94e:	00 
    d94f:	4c 89 ac 24 f0 00 00 	mov    %r13,0xf0(%rsp)
    d956:	00 
    d957:	4c 89 b4 24 f8 00 00 	mov    %r14,0xf8(%rsp)
    d95e:	00 
    d95f:	4c 89 bc 24 00 01 00 	mov    %r15,0x100(%rsp)
    d966:	00 
    d967:	48 89 9c 24 08 01 00 	mov    %rbx,0x108(%rsp)
    d96e:	00 
    d96f:	48 8d 35 0a 02 00 00 	lea    0x20a(%rip),%rsi        # db80 <fwp_owner_release6>
    d976:	48 8d bc 24 10 01 00 	lea    0x110(%rsp),%rdi
    d97d:	00 
    d97e:	48 8d 94 24 d8 00 00 	lea    0xd8(%rsp),%rdx
    d985:	00 
    d986:	e8 65 00 00 00       	call   d9f0 <fwp_cleanup_push>
    d98b:	48 be 00 00 00 00 00 	movabs $0x8000000000000000,%rsi
    d992:	00 00 80 
    d995:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    d99a:	e8 61 89 ff ff       	call   6300 <f24>
    d99f:	49 89 c6             	mov    %rax,%r14
    d9a2:	48 8d bc 24 10 01 00 	lea    0x110(%rsp),%rdi
    d9a9:	00 
    d9aa:	e8 b1 00 00 00       	call   da60 <fwp_cleanup_pop>
    d9af:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    d9b4:	48 8b 0c 24          	mov    (%rsp),%rcx
    d9b8:	48 89 08             	mov    %rcx,(%rax)
    d9bb:	48 89 68 08          	mov    %rbp,0x8(%rax)
    d9bf:	4c 89 60 10          	mov    %r12,0x10(%rax)
    d9c3:	4c 89 68 18          	mov    %r13,0x18(%rax)
    d9c7:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    d9cc:	48 89 48 20          	mov    %rcx,0x20(%rax)
    d9d0:	4c 89 78 28          	mov    %r15,0x28(%rax)
    d9d4:	48 89 58 30          	mov    %rbx,0x30(%rax)
    d9d8:	4c 89 70 38          	mov    %r14,0x38(%rax)
    d9dc:	48 81 c4 b8 01 00 00 	add    $0x1b8,%rsp
    d9e3:	5b                   	pop    %rbx
    d9e4:	41 5c                	pop    %r12
    d9e6:	41 5d                	pop    %r13
    d9e8:	41 5e                	pop    %r14
    d9ea:	41 5f                	pop    %r15
    d9ec:	5d                   	pop    %rbp
    d9ed:	c3                   	ret
    d9ee:	66 90                	xchg   %ax,%ax

000000000000d9f0 <fwp_cleanup_push>:
    d9f0:	48 8b 05 e1 89 00 00 	mov    0x89e1(%rip),%rax        # 163d8 <fwp_cleanups>
    d9f7:	48 89 07             	mov    %rax,(%rdi)
    d9fa:	48 89 77 08          	mov    %rsi,0x8(%rdi)
    d9fe:	48 89 57 10          	mov    %rdx,0x10(%rdi)
    da02:	48 89 3d cf 89 00 00 	mov    %rdi,0x89cf(%rip)        # 163d8 <fwp_cleanups>
    da09:	c3                   	ret
    da0a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000da10 <fwp_owner_release7>:
    da10:	53                   	push   %rbx
    da11:	48 89 fb             	mov    %rdi,%rbx
    da14:	48 8b 3f             	mov    (%rdi),%rdi
    da17:	e8 b4 01 00 00       	call   dbd0 <fwp_drop0>
    da1c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    da20:	e8 cb 01 00 00       	call   dbf0 <fwp_drop1>
    da25:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    da29:	e8 e2 01 00 00       	call   dc10 <fwp_drop2>
    da2e:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    da32:	e8 f9 01 00 00       	call   dc30 <fwp_drop3>
    da37:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    da3b:	e8 10 02 00 00       	call   dc50 <fwp_drop4>
    da40:	48 8b 7b 28          	mov    0x28(%rbx),%rdi
    da44:	e8 27 02 00 00       	call   dc70 <fwp_drop5>
    da49:	48 8b 7b 30          	mov    0x30(%rbx),%rdi
    da4d:	e8 3e 02 00 00       	call   dc90 <fwp_drop6>
    da52:	48 8b 7b 38          	mov    0x38(%rbx),%rdi
    da56:	5b                   	pop    %rbx
    da57:	e9 54 02 00 00       	jmp    dcb0 <fwp_drop7>
    da5c:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000da60 <fwp_cleanup_pop>:
    da60:	48 39 3d 71 89 00 00 	cmp    %rdi,0x8971(%rip)        # 163d8 <fwp_cleanups>
    da67:	75 0b                	jne    da74 <fwp_cleanup_pop+0x14>
    da69:	48 8b 07             	mov    (%rdi),%rax
    da6c:	48 89 05 65 89 00 00 	mov    %rax,0x8965(%rip)        # 163d8 <fwp_cleanups>
    da73:	c3                   	ret
    da74:	50                   	push   %rax
    da75:	e8 f6 55 ff ff       	call   3070 <abort@plt>
    da7a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000da80 <fwp_owner_release0>:
    da80:	48 8b 3f             	mov    (%rdi),%rdi
    da83:	e9 48 01 00 00       	jmp    dbd0 <fwp_drop0>
    da88:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    da8f:	00 

000000000000da90 <fwp_owner_release1>:
    da90:	53                   	push   %rbx
    da91:	48 89 fb             	mov    %rdi,%rbx
    da94:	48 8b 3f             	mov    (%rdi),%rdi
    da97:	e8 34 01 00 00       	call   dbd0 <fwp_drop0>
    da9c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    daa0:	5b                   	pop    %rbx
    daa1:	e9 4a 01 00 00       	jmp    dbf0 <fwp_drop1>
    daa6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    daad:	00 00 00 

000000000000dab0 <fwp_owner_release2>:
    dab0:	53                   	push   %rbx
    dab1:	48 89 fb             	mov    %rdi,%rbx
    dab4:	48 8b 3f             	mov    (%rdi),%rdi
    dab7:	e8 14 01 00 00       	call   dbd0 <fwp_drop0>
    dabc:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    dac0:	e8 2b 01 00 00       	call   dbf0 <fwp_drop1>
    dac5:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    dac9:	5b                   	pop    %rbx
    daca:	e9 41 01 00 00       	jmp    dc10 <fwp_drop2>
    dacf:	90                   	nop

000000000000dad0 <fwp_owner_release3>:
    dad0:	53                   	push   %rbx
    dad1:	48 89 fb             	mov    %rdi,%rbx
    dad4:	48 8b 3f             	mov    (%rdi),%rdi
    dad7:	e8 f4 00 00 00       	call   dbd0 <fwp_drop0>
    dadc:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    dae0:	e8 0b 01 00 00       	call   dbf0 <fwp_drop1>
    dae5:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    dae9:	e8 22 01 00 00       	call   dc10 <fwp_drop2>
    daee:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    daf2:	5b                   	pop    %rbx
    daf3:	e9 38 01 00 00       	jmp    dc30 <fwp_drop3>
    daf8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    daff:	00 

000000000000db00 <fwp_owner_release4>:
    db00:	53                   	push   %rbx
    db01:	48 89 fb             	mov    %rdi,%rbx
    db04:	48 8b 3f             	mov    (%rdi),%rdi
    db07:	e8 c4 00 00 00       	call   dbd0 <fwp_drop0>
    db0c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    db10:	e8 db 00 00 00       	call   dbf0 <fwp_drop1>
    db15:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    db19:	e8 f2 00 00 00       	call   dc10 <fwp_drop2>
    db1e:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    db22:	e8 09 01 00 00       	call   dc30 <fwp_drop3>
    db27:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    db2b:	5b                   	pop    %rbx
    db2c:	e9 1f 01 00 00       	jmp    dc50 <fwp_drop4>
    db31:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    db38:	0f 1f 84 00 00 00 00 
    db3f:	00 

000000000000db40 <fwp_owner_release5>:
    db40:	53                   	push   %rbx
    db41:	48 89 fb             	mov    %rdi,%rbx
    db44:	48 8b 3f             	mov    (%rdi),%rdi
    db47:	e8 84 00 00 00       	call   dbd0 <fwp_drop0>
    db4c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    db50:	e8 9b 00 00 00       	call   dbf0 <fwp_drop1>
    db55:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    db59:	e8 b2 00 00 00       	call   dc10 <fwp_drop2>
    db5e:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    db62:	e8 c9 00 00 00       	call   dc30 <fwp_drop3>
    db67:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    db6b:	e8 e0 00 00 00       	call   dc50 <fwp_drop4>
    db70:	48 8b 7b 28          	mov    0x28(%rbx),%rdi
    db74:	5b                   	pop    %rbx
    db75:	e9 f6 00 00 00       	jmp    dc70 <fwp_drop5>
    db7a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000db80 <fwp_owner_release6>:
    db80:	53                   	push   %rbx
    db81:	48 89 fb             	mov    %rdi,%rbx
    db84:	48 8b 3f             	mov    (%rdi),%rdi
    db87:	e8 44 00 00 00       	call   dbd0 <fwp_drop0>
    db8c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    db90:	e8 5b 00 00 00       	call   dbf0 <fwp_drop1>
    db95:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    db99:	e8 72 00 00 00       	call   dc10 <fwp_drop2>
    db9e:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    dba2:	e8 89 00 00 00       	call   dc30 <fwp_drop3>
    dba7:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    dbab:	e8 a0 00 00 00       	call   dc50 <fwp_drop4>
    dbb0:	48 8b 7b 28          	mov    0x28(%rbx),%rdi
    dbb4:	e8 b7 00 00 00       	call   dc70 <fwp_drop5>
    dbb9:	48 8b 7b 30          	mov    0x30(%rbx),%rdi
    dbbd:	5b                   	pop    %rbx
    dbbe:	e9 cd 00 00 00       	jmp    dc90 <fwp_drop6>
    dbc3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    dbca:	84 00 00 00 00 00 

000000000000dbd0 <fwp_drop0>:
    dbd0:	53                   	push   %rbx
    dbd1:	48 89 fb             	mov    %rdi,%rbx
    dbd4:	e8 e7 5f ff ff       	call   3bc0 <fwp_rc_release_last>
    dbd9:	85 c0                	test   %eax,%eax
    dbdb:	74 09                	je     dbe6 <fwp_drop0+0x16>
    dbdd:	48 89 df             	mov    %rbx,%rdi
    dbe0:	5b                   	pop    %rbx
    dbe1:	e9 0a 60 ff ff       	jmp    3bf0 <fwp_rc_free_arr>
    dbe6:	5b                   	pop    %rbx
    dbe7:	c3                   	ret
    dbe8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    dbef:	00 

000000000000dbf0 <fwp_drop1>:
    dbf0:	53                   	push   %rbx
    dbf1:	48 89 fb             	mov    %rdi,%rbx
    dbf4:	e8 c7 5f ff ff       	call   3bc0 <fwp_rc_release_last>
    dbf9:	85 c0                	test   %eax,%eax
    dbfb:	74 09                	je     dc06 <fwp_drop1+0x16>
    dbfd:	48 89 df             	mov    %rbx,%rdi
    dc00:	5b                   	pop    %rbx
    dc01:	e9 ea 5f ff ff       	jmp    3bf0 <fwp_rc_free_arr>
    dc06:	5b                   	pop    %rbx
    dc07:	c3                   	ret
    dc08:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    dc0f:	00 

000000000000dc10 <fwp_drop2>:
    dc10:	53                   	push   %rbx
    dc11:	48 89 fb             	mov    %rdi,%rbx
    dc14:	e8 a7 5f ff ff       	call   3bc0 <fwp_rc_release_last>
    dc19:	85 c0                	test   %eax,%eax
    dc1b:	74 09                	je     dc26 <fwp_drop2+0x16>
    dc1d:	48 89 df             	mov    %rbx,%rdi
    dc20:	5b                   	pop    %rbx
    dc21:	e9 ca 5f ff ff       	jmp    3bf0 <fwp_rc_free_arr>
    dc26:	5b                   	pop    %rbx
    dc27:	c3                   	ret
    dc28:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    dc2f:	00 

000000000000dc30 <fwp_drop3>:
    dc30:	53                   	push   %rbx
    dc31:	48 89 fb             	mov    %rdi,%rbx
    dc34:	e8 87 5f ff ff       	call   3bc0 <fwp_rc_release_last>
    dc39:	85 c0                	test   %eax,%eax
    dc3b:	74 09                	je     dc46 <fwp_drop3+0x16>
    dc3d:	48 89 df             	mov    %rbx,%rdi
    dc40:	5b                   	pop    %rbx
    dc41:	e9 aa 5f ff ff       	jmp    3bf0 <fwp_rc_free_arr>
    dc46:	5b                   	pop    %rbx
    dc47:	c3                   	ret
    dc48:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    dc4f:	00 

000000000000dc50 <fwp_drop4>:
    dc50:	53                   	push   %rbx
    dc51:	48 89 fb             	mov    %rdi,%rbx
    dc54:	e8 67 5f ff ff       	call   3bc0 <fwp_rc_release_last>
    dc59:	85 c0                	test   %eax,%eax
    dc5b:	74 09                	je     dc66 <fwp_drop4+0x16>
    dc5d:	48 89 df             	mov    %rbx,%rdi
    dc60:	5b                   	pop    %rbx
    dc61:	e9 8a 5f ff ff       	jmp    3bf0 <fwp_rc_free_arr>
    dc66:	5b                   	pop    %rbx
    dc67:	c3                   	ret
    dc68:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    dc6f:	00 

000000000000dc70 <fwp_drop5>:
    dc70:	53                   	push   %rbx
    dc71:	48 89 fb             	mov    %rdi,%rbx
    dc74:	e8 47 5f ff ff       	call   3bc0 <fwp_rc_release_last>
    dc79:	85 c0                	test   %eax,%eax
    dc7b:	74 09                	je     dc86 <fwp_drop5+0x16>
    dc7d:	48 89 df             	mov    %rbx,%rdi
    dc80:	5b                   	pop    %rbx
    dc81:	e9 6a 5f ff ff       	jmp    3bf0 <fwp_rc_free_arr>
    dc86:	5b                   	pop    %rbx
    dc87:	c3                   	ret
    dc88:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    dc8f:	00 

000000000000dc90 <fwp_drop6>:
    dc90:	53                   	push   %rbx
    dc91:	48 89 fb             	mov    %rdi,%rbx
    dc94:	e8 27 5f ff ff       	call   3bc0 <fwp_rc_release_last>
    dc99:	85 c0                	test   %eax,%eax
    dc9b:	74 09                	je     dca6 <fwp_drop6+0x16>
    dc9d:	48 89 df             	mov    %rbx,%rdi
    dca0:	5b                   	pop    %rbx
    dca1:	e9 4a 5f ff ff       	jmp    3bf0 <fwp_rc_free_arr>
    dca6:	5b                   	pop    %rbx
    dca7:	c3                   	ret
    dca8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    dcaf:	00 

000000000000dcb0 <fwp_drop7>:
    dcb0:	53                   	push   %rbx
    dcb1:	48 89 fb             	mov    %rdi,%rbx
    dcb4:	e8 07 5f ff ff       	call   3bc0 <fwp_rc_release_last>
    dcb9:	85 c0                	test   %eax,%eax
    dcbb:	74 09                	je     dcc6 <fwp_drop7+0x16>
    dcbd:	48 89 df             	mov    %rbx,%rdi
    dcc0:	5b                   	pop    %rbx
    dcc1:	e9 2a 5f ff ff       	jmp    3bf0 <fwp_rc_free_arr>
    dcc6:	5b                   	pop    %rbx
    dcc7:	c3                   	ret
    dcc8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    dccf:	00 

000000000000dcd0 <fwp_rc_drop_slot>:
    dcd0:	0f b6 07             	movzbl (%rdi),%eax
    dcd3:	3c ff                	cmp    $0xff,%al
    dcd5:	74 09                	je     dce0 <fwp_rc_wide_drop>
    dcd7:	3c 02                	cmp    $0x2,%al
    dcd9:	72 04                	jb     dcdf <fwp_rc_drop_slot+0xf>
    dcdb:	fe c8                	dec    %al
    dcdd:	88 07                	mov    %al,(%rdi)
    dcdf:	c3                   	ret

000000000000dce0 <fwp_rc_wide_drop>:
    dce0:	53                   	push   %rbx
    dce1:	48 89 fb             	mov    %rdi,%rbx
    dce4:	e8 f7 63 ff ff       	call   40e0 <fwp_rc_wide_link>
    dce9:	48 8b 00             	mov    (%rax),%rax
    dcec:	48 85 c0             	test   %rax,%rax
    dcef:	74 21                	je     dd12 <fwp_rc_wide_drop+0x32>
    dcf1:	48 8b 48 08          	mov    0x8(%rax),%rcx
    dcf5:	48 ff c9             	dec    %rcx
    dcf8:	48 89 48 08          	mov    %rcx,0x8(%rax)
    dcfc:	48 81 f9 fe 00 00 00 	cmp    $0xfe,%rcx
    dd03:	75 0b                	jne    dd10 <fwp_rc_wide_drop+0x30>
    dd05:	48 89 df             	mov    %rbx,%rdi
    dd08:	e8 93 63 ff ff       	call   40a0 <fwp_rc_forget_slot>
    dd0d:	c6 03 fe             	movb   $0xfe,(%rbx)
    dd10:	5b                   	pop    %rbx
    dd11:	c3                   	ret
    dd12:	48 8d 3d 4b 0b 00 00 	lea    0xb4b(%rip),%rdi        # e864 <exec_in_fp0+0x164>
    dd19:	e8 22 64 ff ff       	call   4140 <fwp_trap>
    dd1e:	66 90                	xchg   %ax,%ax

000000000000dd20 <fwp_rc_last>:
    dd20:	50                   	push   %rax
    dd21:	e8 da 62 ff ff       	call   4000 <fwp_rc_slot>
    dd26:	48 85 c0             	test   %rax,%rax
    dd29:	74 0d                	je     dd38 <fwp_rc_last+0x18>
    dd2b:	48 89 c1             	mov    %rax,%rcx
    dd2e:	31 c0                	xor    %eax,%eax
    dd30:	80 39 01             	cmpb   $0x1,(%rcx)
    dd33:	0f 94 c0             	sete   %al
    dd36:	59                   	pop    %rcx
    dd37:	c3                   	ret
    dd38:	31 c0                	xor    %eax,%eax
    dd3a:	59                   	pop    %rcx
    dd3b:	c3                   	ret
    dd3c:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000dd40 <fwp_rc_poison>:
    dd40:	53                   	push   %rbx
    dd41:	48 89 f9             	mov    %rdi,%rcx
    dd44:	48 2b 0d 7d 75 00 00 	sub    0x757d(%rip),%rcx        # 152c8 <fwp_gc+0x1030>
    dd4b:	48 8b 05 be 75 00 00 	mov    0x75be(%rip),%rax        # 15310 <fwp_gc+0x1078>
    dd52:	48 c1 e9 10          	shr    $0x10,%rcx
    dd56:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    dd5d:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    dd62:	75 0d                	jne    dd71 <fwp_rc_poison+0x31>
    dd64:	80 3c 08 02          	cmpb   $0x2,(%rax,%rcx,1)
    dd68:	75 1e                	jne    dd88 <fwp_rc_poison+0x48>
    dd6a:	48 8b 54 08 18       	mov    0x18(%rax,%rcx,1),%rdx
    dd6f:	eb 1b                	jmp    dd8c <fwp_rc_poison+0x4c>
    dd71:	c7 07 ad de 00 00    	movl   $0xdead,(%rdi)
    dd77:	8b 47 04             	mov    0x4(%rdi),%eax
    dd7a:	48 85 c0             	test   %rax,%rax
    dd7d:	74 7e                	je     ddfd <fwp_rc_poison+0xbd>
    dd7f:	83 f8 04             	cmp    $0x4,%eax
    dd82:	73 22                	jae    dda6 <fwp_rc_poison+0x66>
    dd84:	31 c9                	xor    %ecx,%ecx
    dd86:	eb 50                	jmp    ddd8 <fwp_rc_poison+0x98>
    dd88:	8b 54 08 08          	mov    0x8(%rax,%rcx,1),%edx
    dd8c:	48 89 fb             	mov    %rdi,%rbx
    dd8f:	be dd 00 00 00       	mov    $0xdd,%esi
    dd94:	e8 77 54 ff ff       	call   3210 <memset@plt>
    dd99:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    dda0:	c6 43 08 00          	movb   $0x0,0x8(%rbx)
    dda4:	5b                   	pop    %rbx
    dda5:	c3                   	ret
    dda6:	89 c1                	mov    %eax,%ecx
    dda8:	83 e1 fc             	and    $0xfffffffc,%ecx
    ddab:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    ddb2:	00 
    ddb3:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    ddb7:	31 f6                	xor    %esi,%esi
    ddb9:	0f 28 05 80 03 00 00 	movaps 0x380(%rip),%xmm0        # e140 <_IO_stdin_used+0x140>
    ddc0:	0f 11 44 37 08       	movups %xmm0,0x8(%rdi,%rsi,1)
    ddc5:	0f 11 44 37 18       	movups %xmm0,0x18(%rdi,%rsi,1)
    ddca:	48 83 c6 20          	add    $0x20,%rsi
    ddce:	48 39 f2             	cmp    %rsi,%rdx
    ddd1:	75 ed                	jne    ddc0 <fwp_rc_poison+0x80>
    ddd3:	48 39 c1             	cmp    %rax,%rcx
    ddd6:	74 25                	je     ddfd <fwp_rc_poison+0xbd>
    ddd8:	48 ba ef be ad de ef 	movabs $0xdeadbeefdeadbeef,%rdx
    dddf:	be ad de 
    dde2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    dde9:	1f 84 00 00 00 00 00 
    ddf0:	48 89 54 cf 08       	mov    %rdx,0x8(%rdi,%rcx,8)
    ddf5:	48 ff c1             	inc    %rcx
    ddf8:	48 39 c8             	cmp    %rcx,%rax
    ddfb:	75 f3                	jne    ddf0 <fwp_rc_poison+0xb0>
    ddfd:	5b                   	pop    %rbx
    ddfe:	c3                   	ret
    ddff:	90                   	nop

000000000000de00 <__divti3>:
    de00:	f3 0f 1e fa          	endbr64
    de04:	55                   	push   %rbp
    de05:	49 89 f8             	mov    %rdi,%r8
    de08:	49 89 d2             	mov    %rdx,%r10
    de0b:	49 89 cb             	mov    %rcx,%r11
    de0e:	31 ff                	xor    %edi,%edi
    de10:	48 89 e5             	mov    %rsp,%rbp
    de13:	41 56                	push   %r14
    de15:	53                   	push   %rbx
    de16:	48 85 f6             	test   %rsi,%rsi
    de19:	79 13                	jns    de2e <__divti3+0x2e>
    de1b:	45 31 c9             	xor    %r9d,%r9d
    de1e:	49 f7 d8             	neg    %r8
    de21:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
    de28:	49 19 f1             	sbb    %rsi,%r9
    de2b:	4c 89 ce             	mov    %r9,%rsi
    de2e:	4c 89 da             	mov    %r11,%rdx
    de31:	4d 85 db             	test   %r11,%r11
    de34:	0f 88 f6 00 00 00    	js     df30 <__divti3+0x130>
    de3a:	4d 89 d6             	mov    %r10,%r14
    de3d:	75 31                	jne    de70 <__divti3+0x70>
    de3f:	4c 39 f6             	cmp    %r14,%rsi
    de42:	0f 83 b8 00 00 00    	jae    df00 <__divti3+0x100>
    de48:	48 89 f2             	mov    %rsi,%rdx
    de4b:	31 f6                	xor    %esi,%esi
    de4d:	4c 89 c0             	mov    %r8,%rax
    de50:	49 f7 f6             	div    %r14
    de53:	48 89 f2             	mov    %rsi,%rdx
    de56:	48 85 ff             	test   %rdi,%rdi
    de59:	74 0a                	je     de65 <__divti3+0x65>
    de5b:	48 f7 d8             	neg    %rax
    de5e:	48 83 d2 00          	adc    $0x0,%rdx
    de62:	48 f7 da             	neg    %rdx
    de65:	5b                   	pop    %rbx
    de66:	41 5e                	pop    %r14
    de68:	5d                   	pop    %rbp
    de69:	c3                   	ret
    de6a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    de70:	4c 39 de             	cmp    %r11,%rsi
    de73:	0f 82 d5 00 00 00    	jb     df4e <__divti3+0x14e>
    de79:	4d 0f bd d3          	bsr    %r11,%r10
    de7d:	41 83 f2 3f          	xor    $0x3f,%r10d
    de81:	44 89 d1             	mov    %r10d,%ecx
    de84:	b8 40 00 00 00       	mov    $0x40,%eax
    de89:	4c 89 f3             	mov    %r14,%rbx
    de8c:	4d 89 f1             	mov    %r14,%r9
    de8f:	48 d3 e2             	shl    %cl,%rdx
    de92:	49 63 ca             	movslq %r10d,%rcx
    de95:	49 89 f3             	mov    %rsi,%r11
    de98:	48 29 c8             	sub    %rcx,%rax
    de9b:	89 c1                	mov    %eax,%ecx
    de9d:	48 d3 eb             	shr    %cl,%rbx
    dea0:	44 89 d1             	mov    %r10d,%ecx
    dea3:	49 d3 e1             	shl    %cl,%r9
    dea6:	89 c1                	mov    %eax,%ecx
    dea8:	48 09 d3             	or     %rdx,%rbx
    deab:	4c 89 c2             	mov    %r8,%rdx
    deae:	49 d3 eb             	shr    %cl,%r11
    deb1:	44 89 d1             	mov    %r10d,%ecx
    deb4:	48 d3 e6             	shl    %cl,%rsi
    deb7:	89 c1                	mov    %eax,%ecx
    deb9:	48 d3 ea             	shr    %cl,%rdx
    debc:	48 89 d0             	mov    %rdx,%rax
    debf:	4c 89 da             	mov    %r11,%rdx
    dec2:	48 09 f0             	or     %rsi,%rax
    dec5:	48 f7 f3             	div    %rbx
    dec8:	49 89 d3             	mov    %rdx,%r11
    decb:	48 89 c6             	mov    %rax,%rsi
    dece:	49 f7 e1             	mul    %r9
    ded1:	49 39 d3             	cmp    %rdx,%r11
    ded4:	0f 82 be 00 00 00    	jb     df98 <__divti3+0x198>
    deda:	44 89 d1             	mov    %r10d,%ecx
    dedd:	49 d3 e0             	shl    %cl,%r8
    dee0:	49 39 c0             	cmp    %rax,%r8
    dee3:	73 09                	jae    deee <__divti3+0xee>
    dee5:	49 39 d3             	cmp    %rdx,%r11
    dee8:	0f 84 aa 00 00 00    	je     df98 <__divti3+0x198>
    deee:	48 89 f0             	mov    %rsi,%rax
    def1:	31 f6                	xor    %esi,%esi
    def3:	e9 5b ff ff ff       	jmp    de53 <__divti3+0x53>
    def8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    deff:	00 
    df00:	4d 85 f6             	test   %r14,%r14
    df03:	75 0d                	jne    df12 <__divti3+0x112>
    df05:	b8 01 00 00 00       	mov    $0x1,%eax
    df0a:	31 d2                	xor    %edx,%edx
    df0c:	49 f7 f6             	div    %r14
    df0f:	49 89 c6             	mov    %rax,%r14
    df12:	48 89 f0             	mov    %rsi,%rax
    df15:	31 d2                	xor    %edx,%edx
    df17:	49 f7 f6             	div    %r14
    df1a:	48 89 c6             	mov    %rax,%rsi
    df1d:	4c 89 c0             	mov    %r8,%rax
    df20:	49 f7 f6             	div    %r14
    df23:	e9 2b ff ff ff       	jmp    de53 <__divti3+0x53>
    df28:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    df2f:	00 
    df30:	49 f7 da             	neg    %r10
    df33:	48 f7 d7             	not    %rdi
    df36:	49 83 d3 00          	adc    $0x0,%r11
    df3a:	4d 89 d6             	mov    %r10,%r14
    df3d:	49 f7 db             	neg    %r11
    df40:	4c 89 da             	mov    %r11,%rdx
    df43:	0f 84 f6 fe ff ff    	je     de3f <__divti3+0x3f>
    df49:	4c 39 de             	cmp    %r11,%rsi
    df4c:	73 12                	jae    df60 <__divti3+0x160>
    df4e:	31 f6                	xor    %esi,%esi
    df50:	31 c0                	xor    %eax,%eax
    df52:	e9 fc fe ff ff       	jmp    de53 <__divti3+0x53>
    df57:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    df5e:	00 00 
    df60:	49 0f bd c3          	bsr    %r11,%rax
    df64:	48 83 f0 3f          	xor    $0x3f,%rax
    df68:	41 89 c2             	mov    %eax,%r10d
    df6b:	85 c0                	test   %eax,%eax
    df6d:	0f 85 0e ff ff ff    	jne    de81 <__divti3+0x81>
    df73:	49 39 f3             	cmp    %rsi,%r11
    df76:	72 0d                	jb     df85 <__divti3+0x185>
    df78:	31 f6                	xor    %esi,%esi
    df7a:	31 c0                	xor    %eax,%eax
    df7c:	4d 39 f0             	cmp    %r14,%r8
    df7f:	0f 82 ce fe ff ff    	jb     de53 <__divti3+0x53>
    df85:	31 f6                	xor    %esi,%esi
    df87:	b8 01 00 00 00       	mov    $0x1,%eax
    df8c:	e9 c2 fe ff ff       	jmp    de53 <__divti3+0x53>
    df91:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    df98:	48 8d 46 ff          	lea    -0x1(%rsi),%rax
    df9c:	31 f6                	xor    %esi,%esi
    df9e:	e9 b0 fe ff ff       	jmp    de53 <__divti3+0x53>
    dfa3:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    dfaa:	00 00 00 
    dfad:	0f 1f 00             	nopl   (%rax)

000000000000dfb0 <atexit>:
    dfb0:	f3 0f 1e fa          	endbr64
    dfb4:	48 8b 15 cd 62 00 00 	mov    0x62cd(%rip),%rdx        # 14288 <__dso_handle>
    dfbb:	31 f6                	xor    %esi,%esi
    dfbd:	e9 8e 54 ff ff       	jmp    3450 <__cxa_atexit@plt>

Disassembly of section .fini:

000000000000dfc4 <_fini>:
    dfc4:	f3 0f 1e fa          	endbr64
    dfc8:	48 83 ec 08          	sub    $0x8,%rsp
    dfcc:	48 83 c4 08          	add    $0x8,%rsp
    dfd0:	c3                   	ret
