
/home/runner/work/_temp/numeric-layout-baseline/abi-diagnostic:     file format elf64-x86-64


Disassembly of section .init:

0000000000003000 <_init>:
    3000:	f3 0f 1e fa          	endbr64
    3004:	48 83 ec 08          	sub    $0x8,%rsp
    3008:	48 8b 05 b1 1f 01 00 	mov    0x11fb1(%rip),%rax        # 14fc0 <__gmon_start__@Base>
    300f:	48 85 c0             	test   %rax,%rax
    3012:	74 02                	je     3016 <_init+0x16>
    3014:	ff d0                	call   *%rax
    3016:	48 83 c4 08          	add    $0x8,%rsp
    301a:	c3                   	ret

Disassembly of section .plt:

0000000000003020 <getenv@plt-0x10>:
    3020:	ff 35 ca 1f 01 00    	push   0x11fca(%rip)        # 14ff0 <_GLOBAL_OFFSET_TABLE_+0x8>
    3026:	ff 25 cc 1f 01 00    	jmp    *0x11fcc(%rip)        # 14ff8 <_GLOBAL_OFFSET_TABLE_+0x10>
    302c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000003030 <getenv@plt>:
    3030:	ff 25 ca 1f 01 00    	jmp    *0x11fca(%rip)        # 15000 <getenv@GLIBC_2.2.5>
    3036:	68 00 00 00 00       	push   $0x0
    303b:	e9 e0 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003040 <dl_iterate_phdr@plt>:
    3040:	ff 25 c2 1f 01 00    	jmp    *0x11fc2(%rip)        # 15008 <dl_iterate_phdr@GLIBC_2.2.5>
    3046:	68 01 00 00 00       	push   $0x1
    304b:	e9 d0 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003050 <free@plt>:
    3050:	ff 25 ba 1f 01 00    	jmp    *0x11fba(%rip)        # 15010 <free@GLIBC_2.2.5>
    3056:	68 02 00 00 00       	push   $0x2
    305b:	e9 c0 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003060 <recv@plt>:
    3060:	ff 25 b2 1f 01 00    	jmp    *0x11fb2(%rip)        # 15018 <recv@GLIBC_2.2.5>
    3066:	68 03 00 00 00       	push   $0x3
    306b:	e9 b0 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003070 <abort@plt>:
    3070:	ff 25 aa 1f 01 00    	jmp    *0x11faa(%rip)        # 15020 <abort@GLIBC_2.2.5>
    3076:	68 04 00 00 00       	push   $0x4
    307b:	e9 a0 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003080 <__errno_location@plt>:
    3080:	ff 25 a2 1f 01 00    	jmp    *0x11fa2(%rip)        # 15028 <__errno_location@GLIBC_2.2.5>
    3086:	68 05 00 00 00       	push   $0x5
    308b:	e9 90 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003090 <strncmp@plt>:
    3090:	ff 25 9a 1f 01 00    	jmp    *0x11f9a(%rip)        # 15030 <strncmp@GLIBC_2.2.5>
    3096:	68 06 00 00 00       	push   $0x6
    309b:	e9 80 ff ff ff       	jmp    3020 <_init+0x20>

00000000000030a0 <_exit@plt>:
    30a0:	ff 25 92 1f 01 00    	jmp    *0x11f92(%rip)        # 15038 <_exit@GLIBC_2.2.5>
    30a6:	68 07 00 00 00       	push   $0x7
    30ab:	e9 70 ff ff ff       	jmp    3020 <_init+0x20>

00000000000030b0 <strcpy@plt>:
    30b0:	ff 25 8a 1f 01 00    	jmp    *0x11f8a(%rip)        # 15040 <strcpy@GLIBC_2.2.5>
    30b6:	68 08 00 00 00       	push   $0x8
    30bb:	e9 60 ff ff ff       	jmp    3020 <_init+0x20>

00000000000030c0 <sendmsg@plt>:
    30c0:	ff 25 82 1f 01 00    	jmp    *0x11f82(%rip)        # 15048 <sendmsg@GLIBC_2.2.5>
    30c6:	68 09 00 00 00       	push   $0x9
    30cb:	e9 50 ff ff ff       	jmp    3020 <_init+0x20>

00000000000030d0 <puts@plt>:
    30d0:	ff 25 7a 1f 01 00    	jmp    *0x11f7a(%rip)        # 15050 <puts@GLIBC_2.2.5>
    30d6:	68 0a 00 00 00       	push   $0xa
    30db:	e9 40 ff ff ff       	jmp    3020 <_init+0x20>

00000000000030e0 <sigaction@plt>:
    30e0:	ff 25 72 1f 01 00    	jmp    *0x11f72(%rip)        # 15058 <sigaction@GLIBC_2.2.5>
    30e6:	68 0b 00 00 00       	push   $0xb
    30eb:	e9 30 ff ff ff       	jmp    3020 <_init+0x20>

00000000000030f0 <fread@plt>:
    30f0:	ff 25 6a 1f 01 00    	jmp    *0x11f6a(%rip)        # 15060 <fread@GLIBC_2.2.5>
    30f6:	68 0c 00 00 00       	push   $0xc
    30fb:	e9 20 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003100 <strtod@plt>:
    3100:	ff 25 62 1f 01 00    	jmp    *0x11f62(%rip)        # 15068 <strtod@GLIBC_2.2.5>
    3106:	68 0d 00 00 00       	push   $0xd
    310b:	e9 10 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003110 <vsnprintf@plt>:
    3110:	ff 25 5a 1f 01 00    	jmp    *0x11f5a(%rip)        # 15070 <vsnprintf@GLIBC_2.2.5>
    3116:	68 0e 00 00 00       	push   $0xe
    311b:	e9 00 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003120 <fcntl@plt>:
    3120:	ff 25 52 1f 01 00    	jmp    *0x11f52(%rip)        # 15078 <fcntl@GLIBC_2.2.5>
    3126:	68 0f 00 00 00       	push   $0xf
    312b:	e9 f0 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003130 <clock_gettime@plt>:
    3130:	ff 25 4a 1f 01 00    	jmp    *0x11f4a(%rip)        # 15080 <clock_gettime@GLIBC_2.17>
    3136:	68 10 00 00 00       	push   $0x10
    313b:	e9 e0 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003140 <write@plt>:
    3140:	ff 25 42 1f 01 00    	jmp    *0x11f42(%rip)        # 15088 <write@GLIBC_2.2.5>
    3146:	68 11 00 00 00       	push   $0x11
    314b:	e9 d0 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003150 <fclose@plt>:
    3150:	ff 25 3a 1f 01 00    	jmp    *0x11f3a(%rip)        # 15090 <fclose@GLIBC_2.2.5>
    3156:	68 12 00 00 00       	push   $0x12
    315b:	e9 c0 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003160 <shutdown@plt>:
    3160:	ff 25 32 1f 01 00    	jmp    *0x11f32(%rip)        # 15098 <shutdown@GLIBC_2.2.5>
    3166:	68 13 00 00 00       	push   $0x13
    316b:	e9 b0 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003170 <strlen@plt>:
    3170:	ff 25 2a 1f 01 00    	jmp    *0x11f2a(%rip)        # 150a0 <strlen@GLIBC_2.2.5>
    3176:	68 14 00 00 00       	push   $0x14
    317b:	e9 a0 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003180 <getuid@plt>:
    3180:	ff 25 22 1f 01 00    	jmp    *0x11f22(%rip)        # 150a8 <getuid@GLIBC_2.2.5>
    3186:	68 15 00 00 00       	push   $0x15
    318b:	e9 90 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003190 <mmap@plt>:
    3190:	ff 25 1a 1f 01 00    	jmp    *0x11f1a(%rip)        # 150b0 <mmap@GLIBC_2.2.5>
    3196:	68 16 00 00 00       	push   $0x16
    319b:	e9 80 fe ff ff       	jmp    3020 <_init+0x20>

00000000000031a0 <send@plt>:
    31a0:	ff 25 12 1f 01 00    	jmp    *0x11f12(%rip)        # 150b8 <send@GLIBC_2.2.5>
    31a6:	68 17 00 00 00       	push   $0x17
    31ab:	e9 70 fe ff ff       	jmp    3020 <_init+0x20>

00000000000031b0 <strchr@plt>:
    31b0:	ff 25 0a 1f 01 00    	jmp    *0x11f0a(%rip)        # 150c0 <strchr@GLIBC_2.2.5>
    31b6:	68 18 00 00 00       	push   $0x18
    31bb:	e9 60 fe ff ff       	jmp    3020 <_init+0x20>

00000000000031c0 <printf@plt>:
    31c0:	ff 25 02 1f 01 00    	jmp    *0x11f02(%rip)        # 150c8 <printf@GLIBC_2.2.5>
    31c6:	68 19 00 00 00       	push   $0x19
    31cb:	e9 50 fe ff ff       	jmp    3020 <_init+0x20>

00000000000031d0 <snprintf@plt>:
    31d0:	ff 25 fa 1e 01 00    	jmp    *0x11efa(%rip)        # 150d0 <snprintf@GLIBC_2.2.5>
    31d6:	68 1a 00 00 00       	push   $0x1a
    31db:	e9 40 fe ff ff       	jmp    3020 <_init+0x20>

00000000000031e0 <ftruncate@plt>:
    31e0:	ff 25 f2 1e 01 00    	jmp    *0x11ef2(%rip)        # 150d8 <ftruncate@GLIBC_2.2.5>
    31e6:	68 1b 00 00 00       	push   $0x1b
    31eb:	e9 30 fe ff ff       	jmp    3020 <_init+0x20>

00000000000031f0 <fputs@plt>:
    31f0:	ff 25 ea 1e 01 00    	jmp    *0x11eea(%rip)        # 150e0 <fputs@GLIBC_2.2.5>
    31f6:	68 1c 00 00 00       	push   $0x1c
    31fb:	e9 20 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003200 <strtof@plt>:
    3200:	ff 25 e2 1e 01 00    	jmp    *0x11ee2(%rip)        # 150e8 <strtof@GLIBC_2.2.5>
    3206:	68 1d 00 00 00       	push   $0x1d
    320b:	e9 10 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003210 <memset@plt>:
    3210:	ff 25 da 1e 01 00    	jmp    *0x11eda(%rip)        # 150f0 <memset@GLIBC_2.2.5>
    3216:	68 1e 00 00 00       	push   $0x1e
    321b:	e9 00 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003220 <fgetc@plt>:
    3220:	ff 25 d2 1e 01 00    	jmp    *0x11ed2(%rip)        # 150f8 <fgetc@GLIBC_2.2.5>
    3226:	68 1f 00 00 00       	push   $0x1f
    322b:	e9 f0 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003230 <close@plt>:
    3230:	ff 25 ca 1e 01 00    	jmp    *0x11eca(%rip)        # 15100 <close@GLIBC_2.2.5>
    3236:	68 20 00 00 00       	push   $0x20
    323b:	e9 e0 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003240 <fputc@plt>:
    3240:	ff 25 c2 1e 01 00    	jmp    *0x11ec2(%rip)        # 15108 <fputc@GLIBC_2.2.5>
    3246:	68 21 00 00 00       	push   $0x21
    324b:	e9 d0 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003250 <sched_yield@plt>:
    3250:	ff 25 ba 1e 01 00    	jmp    *0x11eba(%rip)        # 15110 <sched_yield@GLIBC_2.2.5>
    3256:	68 22 00 00 00       	push   $0x22
    325b:	e9 c0 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003260 <memchr@plt>:
    3260:	ff 25 b2 1e 01 00    	jmp    *0x11eb2(%rip)        # 15118 <memchr@GLIBC_2.2.5>
    3266:	68 23 00 00 00       	push   $0x23
    326b:	e9 b0 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003270 <memcmp@plt>:
    3270:	ff 25 aa 1e 01 00    	jmp    *0x11eaa(%rip)        # 15120 <memcmp@GLIBC_2.2.5>
    3276:	68 24 00 00 00       	push   $0x24
    327b:	e9 a0 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003280 <pthread_attr_init@plt>:
    3280:	ff 25 a2 1e 01 00    	jmp    *0x11ea2(%rip)        # 15128 <pthread_attr_init@GLIBC_2.2.5>
    3286:	68 25 00 00 00       	push   $0x25
    328b:	e9 90 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003290 <fgets@plt>:
    3290:	ff 25 9a 1e 01 00    	jmp    *0x11e9a(%rip)        # 15130 <fgets@GLIBC_2.2.5>
    3296:	68 26 00 00 00       	push   $0x26
    329b:	e9 80 fd ff ff       	jmp    3020 <_init+0x20>

00000000000032a0 <getsockopt@plt>:
    32a0:	ff 25 92 1e 01 00    	jmp    *0x11e92(%rip)        # 15138 <getsockopt@GLIBC_2.2.5>
    32a6:	68 27 00 00 00       	push   $0x27
    32ab:	e9 70 fd ff ff       	jmp    3020 <_init+0x20>

00000000000032b0 <_setjmp@plt>:
    32b0:	ff 25 8a 1e 01 00    	jmp    *0x11e8a(%rip)        # 15140 <_setjmp@GLIBC_2.2.5>
    32b6:	68 28 00 00 00       	push   $0x28
    32bb:	e9 60 fd ff ff       	jmp    3020 <_init+0x20>

00000000000032c0 <strtoull@plt>:
    32c0:	ff 25 82 1e 01 00    	jmp    *0x11e82(%rip)        # 15148 <strtoull@GLIBC_2.2.5>
    32c6:	68 29 00 00 00       	push   $0x29
    32cb:	e9 50 fd ff ff       	jmp    3020 <_init+0x20>

00000000000032d0 <strcmp@plt>:
    32d0:	ff 25 7a 1e 01 00    	jmp    *0x11e7a(%rip)        # 15150 <strcmp@GLIBC_2.2.5>
    32d6:	68 2a 00 00 00       	push   $0x2a
    32db:	e9 40 fd ff ff       	jmp    3020 <_init+0x20>

00000000000032e0 <signal@plt>:
    32e0:	ff 25 72 1e 01 00    	jmp    *0x11e72(%rip)        # 15158 <signal@GLIBC_2.2.5>
    32e6:	68 2b 00 00 00       	push   $0x2b
    32eb:	e9 30 fd ff ff       	jmp    3020 <_init+0x20>

00000000000032f0 <fprintf@plt>:
    32f0:	ff 25 6a 1e 01 00    	jmp    *0x11e6a(%rip)        # 15160 <fprintf@GLIBC_2.2.5>
    32f6:	68 2c 00 00 00       	push   $0x2c
    32fb:	e9 20 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003300 <syscall@plt>:
    3300:	ff 25 62 1e 01 00    	jmp    *0x11e62(%rip)        # 15168 <syscall@GLIBC_2.2.5>
    3306:	68 2d 00 00 00       	push   $0x2d
    330b:	e9 10 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003310 <sigemptyset@plt>:
    3310:	ff 25 5a 1e 01 00    	jmp    *0x11e5a(%rip)        # 15170 <sigemptyset@GLIBC_2.2.5>
    3316:	68 2e 00 00 00       	push   $0x2e
    331b:	e9 00 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003320 <strtol@plt>:
    3320:	ff 25 52 1e 01 00    	jmp    *0x11e52(%rip)        # 15178 <strtol@GLIBC_2.2.5>
    3326:	68 2f 00 00 00       	push   $0x2f
    332b:	e9 f0 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003330 <memcpy@plt>:
    3330:	ff 25 4a 1e 01 00    	jmp    *0x11e4a(%rip)        # 15180 <memcpy@GLIBC_2.14>
    3336:	68 30 00 00 00       	push   $0x30
    333b:	e9 e0 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003340 <malloc@plt>:
    3340:	ff 25 42 1e 01 00    	jmp    *0x11e42(%rip)        # 15188 <malloc@GLIBC_2.2.5>
    3346:	68 31 00 00 00       	push   $0x31
    334b:	e9 d0 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003350 <fflush@plt>:
    3350:	ff 25 3a 1e 01 00    	jmp    *0x11e3a(%rip)        # 15190 <fflush@GLIBC_2.2.5>
    3356:	68 32 00 00 00       	push   $0x32
    335b:	e9 c0 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003360 <listen@plt>:
    3360:	ff 25 32 1e 01 00    	jmp    *0x11e32(%rip)        # 15198 <listen@GLIBC_2.2.5>
    3366:	68 33 00 00 00       	push   $0x33
    336b:	e9 b0 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003370 <bcmp@plt>:
    3370:	ff 25 2a 1e 01 00    	jmp    *0x11e2a(%rip)        # 151a0 <bcmp@GLIBC_2.2.5>
    3376:	68 34 00 00 00       	push   $0x34
    337b:	e9 a0 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003380 <realloc@plt>:
    3380:	ff 25 22 1e 01 00    	jmp    *0x11e22(%rip)        # 151a8 <realloc@GLIBC_2.2.5>
    3386:	68 35 00 00 00       	push   $0x35
    338b:	e9 90 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003390 <munmap@plt>:
    3390:	ff 25 1a 1e 01 00    	jmp    *0x11e1a(%rip)        # 151b0 <munmap@GLIBC_2.2.5>
    3396:	68 36 00 00 00       	push   $0x36
    339b:	e9 80 fc ff ff       	jmp    3020 <_init+0x20>

00000000000033a0 <recvmsg@plt>:
    33a0:	ff 25 12 1e 01 00    	jmp    *0x11e12(%rip)        # 151b8 <recvmsg@GLIBC_2.2.5>
    33a6:	68 37 00 00 00       	push   $0x37
    33ab:	e9 70 fc ff ff       	jmp    3020 <_init+0x20>

00000000000033b0 <setvbuf@plt>:
    33b0:	ff 25 0a 1e 01 00    	jmp    *0x11e0a(%rip)        # 151c0 <setvbuf@GLIBC_2.2.5>
    33b6:	68 38 00 00 00       	push   $0x38
    33bb:	e9 60 fc ff ff       	jmp    3020 <_init+0x20>

00000000000033c0 <poll@plt>:
    33c0:	ff 25 02 1e 01 00    	jmp    *0x11e02(%rip)        # 151c8 <poll@GLIBC_2.2.5>
    33c6:	68 39 00 00 00       	push   $0x39
    33cb:	e9 50 fc ff ff       	jmp    3020 <_init+0x20>

00000000000033d0 <bind@plt>:
    33d0:	ff 25 fa 1d 01 00    	jmp    *0x11dfa(%rip)        # 151d0 <bind@GLIBC_2.2.5>
    33d6:	68 3a 00 00 00       	push   $0x3a
    33db:	e9 40 fc ff ff       	jmp    3020 <_init+0x20>

00000000000033e0 <pthread_create@plt>:
    33e0:	ff 25 f2 1d 01 00    	jmp    *0x11df2(%rip)        # 151d8 <pthread_create@GLIBC_2.34>
    33e6:	68 3b 00 00 00       	push   $0x3b
    33eb:	e9 30 fc ff ff       	jmp    3020 <_init+0x20>

00000000000033f0 <madvise@plt>:
    33f0:	ff 25 ea 1d 01 00    	jmp    *0x11dea(%rip)        # 151e0 <madvise@GLIBC_2.2.5>
    33f6:	68 3c 00 00 00       	push   $0x3c
    33fb:	e9 20 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003400 <atol@plt>:
    3400:	ff 25 e2 1d 01 00    	jmp    *0x11de2(%rip)        # 151e8 <atol@GLIBC_2.2.5>
    3406:	68 3d 00 00 00       	push   $0x3d
    340b:	e9 10 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003410 <mprotect@plt>:
    3410:	ff 25 da 1d 01 00    	jmp    *0x11dda(%rip)        # 151f0 <mprotect@GLIBC_2.2.5>
    3416:	68 3e 00 00 00       	push   $0x3e
    341b:	e9 00 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003420 <fopen@plt>:
    3420:	ff 25 d2 1d 01 00    	jmp    *0x11dd2(%rip)        # 151f8 <fopen@GLIBC_2.2.5>
    3426:	68 3f 00 00 00       	push   $0x3f
    342b:	e9 f0 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003430 <sysconf@plt>:
    3430:	ff 25 ca 1d 01 00    	jmp    *0x11dca(%rip)        # 15200 <sysconf@GLIBC_2.2.5>
    3436:	68 40 00 00 00       	push   $0x40
    343b:	e9 e0 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003440 <accept@plt>:
    3440:	ff 25 c2 1d 01 00    	jmp    *0x11dc2(%rip)        # 15208 <accept@GLIBC_2.2.5>
    3446:	68 41 00 00 00       	push   $0x41
    344b:	e9 d0 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003450 <__cxa_atexit@plt>:
    3450:	ff 25 ba 1d 01 00    	jmp    *0x11dba(%rip)        # 15210 <__cxa_atexit@GLIBC_2.2.5>
    3456:	68 42 00 00 00       	push   $0x42
    345b:	e9 c0 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003460 <atoi@plt>:
    3460:	ff 25 b2 1d 01 00    	jmp    *0x11db2(%rip)        # 15218 <atoi@GLIBC_2.2.5>
    3466:	68 43 00 00 00       	push   $0x43
    346b:	e9 b0 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003470 <sprintf@plt>:
    3470:	ff 25 aa 1d 01 00    	jmp    *0x11daa(%rip)        # 15220 <sprintf@GLIBC_2.2.5>
    3476:	68 44 00 00 00       	push   $0x44
    347b:	e9 a0 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003480 <exit@plt>:
    3480:	ff 25 a2 1d 01 00    	jmp    *0x11da2(%rip)        # 15228 <exit@GLIBC_2.2.5>
    3486:	68 45 00 00 00       	push   $0x45
    348b:	e9 90 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003490 <connect@plt>:
    3490:	ff 25 9a 1d 01 00    	jmp    *0x11d9a(%rip)        # 15230 <connect@GLIBC_2.2.5>
    3496:	68 46 00 00 00       	push   $0x46
    349b:	e9 80 fb ff ff       	jmp    3020 <_init+0x20>

00000000000034a0 <fwrite@plt>:
    34a0:	ff 25 92 1d 01 00    	jmp    *0x11d92(%rip)        # 15238 <fwrite@GLIBC_2.2.5>
    34a6:	68 47 00 00 00       	push   $0x47
    34ab:	e9 70 fb ff ff       	jmp    3020 <_init+0x20>

00000000000034b0 <getrlimit@plt>:
    34b0:	ff 25 8a 1d 01 00    	jmp    *0x11d8a(%rip)        # 15240 <getrlimit@GLIBC_2.2.5>
    34b6:	68 48 00 00 00       	push   $0x48
    34bb:	e9 60 fb ff ff       	jmp    3020 <_init+0x20>

00000000000034c0 <pthread_join@plt>:
    34c0:	ff 25 82 1d 01 00    	jmp    *0x11d82(%rip)        # 15248 <pthread_join@GLIBC_2.34>
    34c6:	68 49 00 00 00       	push   $0x49
    34cb:	e9 50 fb ff ff       	jmp    3020 <_init+0x20>

00000000000034d0 <sigaltstack@plt>:
    34d0:	ff 25 7a 1d 01 00    	jmp    *0x11d7a(%rip)        # 15250 <sigaltstack@GLIBC_2.2.5>
    34d6:	68 4a 00 00 00       	push   $0x4a
    34db:	e9 40 fb ff ff       	jmp    3020 <_init+0x20>

00000000000034e0 <fstat@plt>:
    34e0:	ff 25 72 1d 01 00    	jmp    *0x11d72(%rip)        # 15258 <fstat@GLIBC_2.33>
    34e6:	68 4b 00 00 00       	push   $0x4b
    34eb:	e9 30 fb ff ff       	jmp    3020 <_init+0x20>

00000000000034f0 <strstr@plt>:
    34f0:	ff 25 6a 1d 01 00    	jmp    *0x11d6a(%rip)        # 15260 <strstr@GLIBC_2.2.5>
    34f6:	68 4c 00 00 00       	push   $0x4c
    34fb:	e9 20 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003500 <__ctype_b_loc@plt>:
    3500:	ff 25 62 1d 01 00    	jmp    *0x11d62(%rip)        # 15268 <__ctype_b_loc@GLIBC_2.3>
    3506:	68 4d 00 00 00       	push   $0x4d
    350b:	e9 10 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003510 <socket@plt>:
    3510:	ff 25 5a 1d 01 00    	jmp    *0x11d5a(%rip)        # 15270 <socket@GLIBC_2.2.5>
    3516:	68 4e 00 00 00       	push   $0x4e
    351b:	e9 00 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003520 <pthread_attr_setstacksize@plt>:
    3520:	ff 25 52 1d 01 00    	jmp    *0x11d52(%rip)        # 15278 <pthread_attr_setstacksize@GLIBC_2.34>
    3526:	68 4f 00 00 00       	push   $0x4f
    352b:	e9 f0 fa ff ff       	jmp    3020 <_init+0x20>

Disassembly of section .plt.got:

0000000000003530 <__cxa_finalize@plt>:
    3530:	ff 25 9a 1a 01 00    	jmp    *0x11a9a(%rip)        # 14fd0 <__cxa_finalize@GLIBC_2.2.5>
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
    355f:	ff 15 3b 1a 01 00    	call   *0x11a3b(%rip)        # 14fa0 <__libc_start_main@GLIBC_2.34>
    3565:	f4                   	hlt
    3566:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    356d:	00 00 00 

0000000000003570 <deregister_tm_clones>:
    3570:	48 8d 3d 19 3e 01 00 	lea    0x13e19(%rip),%rdi        # 17390 <__TMC_END__>
    3577:	48 8d 05 12 3e 01 00 	lea    0x13e12(%rip),%rax        # 17390 <__TMC_END__>
    357e:	48 39 f8             	cmp    %rdi,%rax
    3581:	74 15                	je     3598 <deregister_tm_clones+0x28>
    3583:	48 8b 05 1e 1a 01 00 	mov    0x11a1e(%rip),%rax        # 14fa8 <_ITM_deregisterTMCloneTable@Base>
    358a:	48 85 c0             	test   %rax,%rax
    358d:	74 09                	je     3598 <deregister_tm_clones+0x28>
    358f:	ff e0                	jmp    *%rax
    3591:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    3598:	c3                   	ret
    3599:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000035a0 <register_tm_clones>:
    35a0:	48 8d 3d e9 3d 01 00 	lea    0x13de9(%rip),%rdi        # 17390 <__TMC_END__>
    35a7:	48 8d 35 e2 3d 01 00 	lea    0x13de2(%rip),%rsi        # 17390 <__TMC_END__>
    35ae:	48 29 fe             	sub    %rdi,%rsi
    35b1:	48 89 f0             	mov    %rsi,%rax
    35b4:	48 c1 ee 3f          	shr    $0x3f,%rsi
    35b8:	48 c1 f8 03          	sar    $0x3,%rax
    35bc:	48 01 c6             	add    %rax,%rsi
    35bf:	48 d1 fe             	sar    $1,%rsi
    35c2:	74 14                	je     35d8 <register_tm_clones+0x38>
    35c4:	48 8b 05 fd 19 01 00 	mov    0x119fd(%rip),%rax        # 14fc8 <_ITM_registerTMCloneTable@Base>
    35cb:	48 85 c0             	test   %rax,%rax
    35ce:	74 08                	je     35d8 <register_tm_clones+0x38>
    35d0:	ff e0                	jmp    *%rax
    35d2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    35d8:	c3                   	ret
    35d9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000035e0 <__do_global_dtors_aux>:
    35e0:	f3 0f 1e fa          	endbr64
    35e4:	80 3d a5 3d 01 00 00 	cmpb   $0x0,0x13da5(%rip)        # 17390 <__TMC_END__>
    35eb:	75 2b                	jne    3618 <__do_global_dtors_aux+0x38>
    35ed:	55                   	push   %rbp
    35ee:	48 83 3d da 19 01 00 	cmpq   $0x0,0x119da(%rip)        # 14fd0 <__cxa_finalize@GLIBC_2.2.5>
    35f5:	00 
    35f6:	48 89 e5             	mov    %rsp,%rbp
    35f9:	74 0c                	je     3607 <__do_global_dtors_aux+0x27>
    35fb:	48 8b 3d 86 1c 01 00 	mov    0x11c86(%rip),%rdi        # 15288 <__dso_handle>
    3602:	e8 29 ff ff ff       	call   3530 <__cxa_finalize@plt>
    3607:	e8 64 ff ff ff       	call   3570 <deregister_tm_clones>
    360c:	c6 05 7d 3d 01 00 01 	movb   $0x1,0x13d7d(%rip)        # 17390 <__TMC_END__>
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
    3637:	48 8d 05 02 12 01 00 	lea    0x11202(%rip),%rax        # 14840 <fwp_fn_table>
    363e:	48 89 05 5b 3d 01 00 	mov    %rax,0x13d5b(%rip)        # 173a0 <fwp_fns>
    3645:	4c 8b 35 64 19 01 00 	mov    0x11964(%rip),%r14        # 14fb0 <stdout@GLIBC_2.2.5>
    364c:	49 8b 06             	mov    (%r14),%rax
    364f:	48 89 05 52 3d 01 00 	mov    %rax,0x13d52(%rip)        # 173a8 <fwp_prog_out>
    3656:	89 3d 54 3d 01 00    	mov    %edi,0x13d54(%rip)        # 173b0 <fwp_argc>
    365c:	48 89 35 55 3d 01 00 	mov    %rsi,0x13d55(%rip)        # 173b8 <fwp_argv>
    3663:	48 8d 35 56 3d 01 00 	lea    0x13d56(%rip),%rsi        # 173c0 <fwp_start_time>
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
    36a6:	48 8b 35 e3 1b 01 00 	mov    0x11be3(%rip),%rsi        # 15290 <fwp_main_stack>
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
    36f6:	48 89 0d 93 1b 01 00 	mov    %rcx,0x11b93(%rip)        # 15290 <fwp_main_stack>
    36fd:	e8 8e 00 00 00       	call   3790 <fwp_main_thread>
    3702:	eb 0c                	jmp    3710 <original_main+0xe0>
    3704:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    3709:	31 f6                	xor    %esi,%esi
    370b:	e8 b0 fd ff ff       	call   34c0 <pthread_join@plt>
    3710:	49 8b 3e             	mov    (%r14),%rdi
    3713:	e8 38 fc ff ff       	call   3350 <fflush@plt>
    3718:	8b 05 b2 3c 01 00    	mov    0x13cb2(%rip),%eax        # 173d0 <fwp_exit_code>
    371e:	48 83 c4 58          	add    $0x58,%rsp
    3722:	5b                   	pop    %rbx
    3723:	41 5e                	pop    %r14
    3725:	c3                   	ret
    3726:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    372d:	00 00 00 

0000000000003730 <fwp_seed_rng>:
    3730:	53                   	push   %rbx
    3731:	48 83 ec 20          	sub    $0x20,%rsp
    3735:	48 8d 3d 7b c2 00 00 	lea    0xc27b(%rip),%rdi        # f9b7 <exec_in_fp0+0x2b7>
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
    379c:	48 8b 3d ed 1a 01 00 	mov    0x11aed(%rip),%rdi        # 15290 <fwp_main_stack>
    37a3:	e8 28 2e 00 00       	call   65d0 <fwp_stack_guard_init>
    37a8:	48 8b 05 61 14 01 00 	mov    0x11461(%rip),%rax        # 14c10 <exec_scripts+0x10>
    37af:	48 89 05 3a 3c 01 00 	mov    %rax,0x13c3a(%rip)        # 173f0 <fwp_cli_scripts+0x10>
    37b6:	0f 28 05 43 14 01 00 	movaps 0x11443(%rip),%xmm0        # 14c00 <exec_scripts>
    37bd:	0f 29 05 1c 3c 01 00 	movaps %xmm0,0x13c1c(%rip)        # 173e0 <fwp_cli_scripts>
    37c4:	48 8d 05 35 bd 00 00 	lea    0xbd35(%rip),%rax        # f500 <exec_man>
    37cb:	48 89 05 26 3c 01 00 	mov    %rax,0x13c26(%rip)        # 173f8 <fwp_cli_man>
    37d2:	c6 05 27 3c 01 00 01 	movb   $0x1,0x13c27(%rip)        # 17400 <fwp_cli_single>
    37d9:	8b 3d d1 3b 01 00    	mov    0x13bd1(%rip),%edi        # 173b0 <fwp_argc>
    37df:	48 8b 35 d2 3b 01 00 	mov    0x13bd2(%rip),%rsi        # 173b8 <fwp_argv>
    37e6:	e8 c5 2e 00 00       	call   66b0 <fwp_exec>
    37eb:	89 05 df 3b 01 00    	mov    %eax,0x13bdf(%rip)        # 173d0 <fwp_exit_code>
    37f1:	48 8b 05 b8 17 01 00 	mov    0x117b8(%rip),%rax        # 14fb0 <stdout@GLIBC_2.2.5>
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
    3826:	48 8d 05 13 10 01 00 	lea    0x11013(%rip),%rax        # 14840 <fwp_fn_table>
    382d:	48 89 05 6c 3b 01 00 	mov    %rax,0x13b6c(%rip)        # 173a0 <fwp_fns>
    3834:	bf 01 01 00 00       	mov    $0x101,%edi
    3839:	e8 f2 02 00 00       	call   3b30 <f2>
    383e:	48 89 c3             	mov    %rax,%rbx
    3841:	b8 78 00 00 00       	mov    $0x78,%eax
    3846:	83 7b 04 08          	cmpl   $0x8,0x4(%rbx)
    384a:	0f 85 12 02 00 00    	jne    3a62 <main+0x252>
    3850:	48 8d 3d d7 be 00 00 	lea    0xbed7(%rip),%rdi        # f72e <exec_in_fp0+0x2e>
    3857:	be 08 00 00 00       	mov    $0x8,%esi
    385c:	ba 08 00 00 00       	mov    $0x8,%edx
    3861:	b9 08 00 00 00       	mov    $0x8,%ecx
    3866:	41 b8 08 00 00 00    	mov    $0x8,%r8d
    386c:	31 c0                	xor    %eax,%eax
    386e:	e8 4d f9 ff ff       	call   31c0 <printf@plt>
    3873:	4c 8d 1d 46 bc 00 00 	lea    0xbc46(%rip),%r11        # f4c0 <_IO_stdin_used+0x4c0>
    387a:	4c 8d 05 6e c6 00 00 	lea    0xc66e(%rip),%r8        # feef <exec_in_fp0+0x7ef>
    3881:	4c 8d 25 5a bf 00 00 	lea    0xbf5a(%rip),%r12        # f7e2 <exec_in_fp0+0xe2>
    3888:	4c 8d 3d 0d bc 00 00 	lea    0xbc0d(%rip),%r15        # f49c <_IO_stdin_used+0x49c>
    388f:	48 8d 3d ee be 00 00 	lea    0xbeee(%rip),%rdi        # f784 <exec_in_fp0+0x84>
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
    3937:	48 8d 3d 46 be 00 00 	lea    0xbe46(%rip),%rdi        # f784 <exec_in_fp0+0x84>
    393e:	4c 8d 05 aa c5 00 00 	lea    0xc5aa(%rip),%r8        # feef <exec_in_fp0+0x7ef>
    3945:	49 ff c5             	inc    %r13
    3948:	49 83 fd 08          	cmp    $0x8,%r13
    394c:	0f 85 47 ff ff ff    	jne    3899 <main+0x89>
    3952:	48 8d 3d 8b be 00 00 	lea    0xbe8b(%rip),%rdi        # f7e4 <exec_in_fp0+0xe4>
    3959:	e8 72 f7 ff ff       	call   30d0 <puts@plt>
    395e:	48 89 df             	mov    %rbx,%rdi
    3961:	e8 ea 02 00 00       	call   3c50 <fwp_rc_release_last>
    3966:	85 c0                	test   %eax,%eax
    3968:	0f 84 e8 00 00 00    	je     3a56 <main+0x246>
    396e:	4c 8b 73 08          	mov    0x8(%rbx),%r14
    3972:	4c 89 f7             	mov    %r14,%rdi
    3975:	e8 d6 02 00 00       	call   3c50 <fwp_rc_release_last>
    397a:	89 c1                	mov    %eax,%ecx
    397c:	b8 7d 00 00 00       	mov    $0x7d,%eax
    3981:	85 c9                	test   %ecx,%ecx
    3983:	0f 84 d9 00 00 00    	je     3a62 <main+0x252>
    3989:	4c 89 f7             	mov    %r14,%rdi
    398c:	e8 ef 02 00 00       	call   3c80 <fwp_rc_free_arr>
    3991:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    3995:	4c 89 f7             	mov    %r14,%rdi
    3998:	e8 b3 02 00 00       	call   3c50 <fwp_rc_release_last>
    399d:	85 c0                	test   %eax,%eax
    399f:	0f 84 b8 00 00 00    	je     3a5d <main+0x24d>
    39a5:	4c 89 f7             	mov    %r14,%rdi
    39a8:	e8 d3 02 00 00       	call   3c80 <fwp_rc_free_arr>
    39ad:	4c 8b 73 18          	mov    0x18(%rbx),%r14
    39b1:	4c 89 f7             	mov    %r14,%rdi
    39b4:	e8 97 02 00 00       	call   3c50 <fwp_rc_release_last>
    39b9:	85 c0                	test   %eax,%eax
    39bb:	0f 84 9c 00 00 00    	je     3a5d <main+0x24d>
    39c1:	4c 89 f7             	mov    %r14,%rdi
    39c4:	e8 b7 02 00 00       	call   3c80 <fwp_rc_free_arr>
    39c9:	4c 8b 73 20          	mov    0x20(%rbx),%r14
    39cd:	4c 89 f7             	mov    %r14,%rdi
    39d0:	e8 7b 02 00 00       	call   3c50 <fwp_rc_release_last>
    39d5:	85 c0                	test   %eax,%eax
    39d7:	0f 84 80 00 00 00    	je     3a5d <main+0x24d>
    39dd:	4c 89 f7             	mov    %r14,%rdi
    39e0:	e8 9b 02 00 00       	call   3c80 <fwp_rc_free_arr>
    39e5:	4c 8b 73 28          	mov    0x28(%rbx),%r14
    39e9:	4c 89 f7             	mov    %r14,%rdi
    39ec:	e8 5f 02 00 00       	call   3c50 <fwp_rc_release_last>
    39f1:	85 c0                	test   %eax,%eax
    39f3:	74 68                	je     3a5d <main+0x24d>
    39f5:	4c 89 f7             	mov    %r14,%rdi
    39f8:	e8 83 02 00 00       	call   3c80 <fwp_rc_free_arr>
    39fd:	4c 8b 73 30          	mov    0x30(%rbx),%r14
    3a01:	4c 89 f7             	mov    %r14,%rdi
    3a04:	e8 47 02 00 00       	call   3c50 <fwp_rc_release_last>
    3a09:	85 c0                	test   %eax,%eax
    3a0b:	74 50                	je     3a5d <main+0x24d>
    3a0d:	4c 89 f7             	mov    %r14,%rdi
    3a10:	e8 6b 02 00 00       	call   3c80 <fwp_rc_free_arr>
    3a15:	4c 8b 73 38          	mov    0x38(%rbx),%r14
    3a19:	4c 89 f7             	mov    %r14,%rdi
    3a1c:	e8 2f 02 00 00       	call   3c50 <fwp_rc_release_last>
    3a21:	85 c0                	test   %eax,%eax
    3a23:	74 38                	je     3a5d <main+0x24d>
    3a25:	4c 89 f7             	mov    %r14,%rdi
    3a28:	e8 53 02 00 00       	call   3c80 <fwp_rc_free_arr>
    3a2d:	4c 8b 73 40          	mov    0x40(%rbx),%r14
    3a31:	4c 89 f7             	mov    %r14,%rdi
    3a34:	e8 17 02 00 00       	call   3c50 <fwp_rc_release_last>
    3a39:	85 c0                	test   %eax,%eax
    3a3b:	b8 7d 00 00 00       	mov    $0x7d,%eax
    3a40:	74 20                	je     3a62 <main+0x252>
    3a42:	4c 89 f7             	mov    %r14,%rdi
    3a45:	e8 36 02 00 00       	call   3c80 <fwp_rc_free_arr>
    3a4a:	48 89 df             	mov    %rbx,%rdi
    3a4d:	e8 ce 02 00 00       	call   3d20 <fwp_rc_free_obj>
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
    3a84:	83 3d f9 27 01 00 00 	cmpl   $0x0,0x127f9(%rip)        # 16284 <fwp_gc+0xfec>
    3a8b:	75 05                	jne    3a92 <fwp_gc_start+0x12>
    3a8d:	e8 4e 0c 00 00       	call   46e0 <fwp_gc_init>
    3a92:	48 89 1d 87 28 01 00 	mov    %rbx,0x12887(%rip)        # 16320 <fwp_gc+0x1088>
    3a99:	48 8d 3d f0 9b 00 00 	lea    0x9bf0(%rip),%rdi        # d690 <fwp_gc_find_data>
    3aa0:	31 f6                	xor    %esi,%esi
    3aa2:	e8 99 f5 ff ff       	call   3040 <dl_iterate_phdr@plt>
    3aa7:	83 3d da 27 01 00 00 	cmpl   $0x0,0x127da(%rip)        # 16288 <fwp_gc+0xff0>
    3aae:	0f 95 c1             	setne  %cl
    3ab1:	83 3d 70 29 01 00 00 	cmpl   $0x0,0x12970(%rip)        # 16428 <fwp_gc+0x1190>
    3ab8:	0f 9f c0             	setg   %al
    3abb:	20 c8                	and    %cl,%al
    3abd:	0f b6 c8             	movzbl %al,%ecx
    3ac0:	89 0d c6 27 01 00    	mov    %ecx,0x127c6(%rip)        # 1628c <fwp_gc+0xff4>
    3ac6:	83 3d c7 27 01 00 00 	cmpl   $0x0,0x127c7(%rip)        # 16294 <fwp_gc+0xffc>
    3acd:	74 16                	je     3ae5 <fwp_gc_start+0x65>
    3acf:	48 8d 3d 9a 9c 00 00 	lea    0x9c9a(%rip),%rdi        # d770 <fwp_gc_report>
    3ad6:	e8 85 a7 00 00       	call   e260 <atexit>
    3adb:	83 3d aa 27 01 00 00 	cmpl   $0x0,0x127aa(%rip)        # 1628c <fwp_gc+0xff4>
    3ae2:	0f 95 c0             	setne  %al
    3ae5:	84 c0                	test   %al,%al
    3ae7:	74 43                	je     3b2c <fwp_gc_start+0xac>
    3ae9:	48 83 3d c7 27 01 00 	cmpq   $0x0,0x127c7(%rip)        # 162b8 <fwp_gc+0x1020>
    3af0:	00 
    3af1:	74 39                	je     3b2c <fwp_gc_start+0xac>
    3af3:	48 8b 05 ae 29 01 00 	mov    0x129ae(%rip),%rax        # 164a8 <fwp_gc+0x1210>
    3afa:	48 2b 05 97 17 01 00 	sub    0x11797(%rip),%rax        # 15298 <fwp_gc>
    3b01:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    3b06:	f2 0f 58 05 72 29 01 	addsd  0x12972(%rip),%xmm0        # 16480 <fwp_gc+0x11e8>
    3b0d:	00 
    3b0e:	f2 0f 11 05 6a 29 01 	movsd  %xmm0,0x1296a(%rip)        # 16480 <fwp_gc+0x11e8>
    3b15:	00 
    3b16:	48 c7 05 87 29 01 00 	movq   $0x0,0x12987(%rip)        # 164a8 <fwp_gc+0x1210>
    3b1d:	00 00 00 00 
    3b21:	48 c7 05 6c 17 01 00 	movq   $0x0,0x1176c(%rip)        # 15298 <fwp_gc>
    3b28:	00 00 00 00 
    3b2c:	5b                   	pop    %rbx
    3b2d:	c3                   	ret
    3b2e:	66 90                	xchg   %ax,%ax

0000000000003b30 <f2>:
    3b30:	55                   	push   %rbp
    3b31:	41 57                	push   %r15
    3b33:	41 56                	push   %r14
    3b35:	41 55                	push   %r13
    3b37:	41 54                	push   %r12
    3b39:	53                   	push   %rbx
    3b3a:	48 81 ec e8 00 00 00 	sub    $0xe8,%rsp
    3b41:	48 89 fe             	mov    %rdi,%rsi
    3b44:	48 8d bc 24 90 00 00 	lea    0x90(%rsp),%rdi
    3b4b:	00 
    3b4c:	e8 5f 9e 00 00       	call   d9b0 <w2>
    3b51:	48 8b 84 24 90 00 00 	mov    0x90(%rsp),%rax
    3b58:	00 
    3b59:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    3b5e:	48 8b 8c 24 98 00 00 	mov    0x98(%rsp),%rcx
    3b65:	00 
    3b66:	48 89 0c 24          	mov    %rcx,(%rsp)
    3b6a:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    3b6f:	48 89 4c 24 58       	mov    %rcx,0x58(%rsp)
    3b74:	4c 8b a4 24 a0 00 00 	mov    0xa0(%rsp),%r12
    3b7b:	00 
    3b7c:	4c 89 64 24 60       	mov    %r12,0x60(%rsp)
    3b81:	4c 8b ac 24 a8 00 00 	mov    0xa8(%rsp),%r13
    3b88:	00 
    3b89:	4c 89 6c 24 68       	mov    %r13,0x68(%rsp)
    3b8e:	48 8b ac 24 b0 00 00 	mov    0xb0(%rsp),%rbp
    3b95:	00 
    3b96:	48 89 6c 24 70       	mov    %rbp,0x70(%rsp)
    3b9b:	48 8b 9c 24 b8 00 00 	mov    0xb8(%rsp),%rbx
    3ba2:	00 
    3ba3:	48 89 5c 24 78       	mov    %rbx,0x78(%rsp)
    3ba8:	4c 8b b4 24 c0 00 00 	mov    0xc0(%rsp),%r14
    3baf:	00 
    3bb0:	4c 89 b4 24 80 00 00 	mov    %r14,0x80(%rsp)
    3bb7:	00 
    3bb8:	4c 8b bc 24 c8 00 00 	mov    0xc8(%rsp),%r15
    3bbf:	00 
    3bc0:	4c 89 bc 24 88 00 00 	mov    %r15,0x88(%rsp)
    3bc7:	00 
    3bc8:	48 8d 35 f1 a0 00 00 	lea    0xa0f1(%rip),%rsi        # dcc0 <fwp_owner_release7>
    3bcf:	48 8d bc 24 d0 00 00 	lea    0xd0(%rsp),%rdi
    3bd6:	00 
    3bd7:	48 8d 54 24 50       	lea    0x50(%rsp),%rdx
    3bdc:	e8 bf a0 00 00       	call   dca0 <fwp_cleanup_push>
    3be1:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    3be6:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    3beb:	48 8b 04 24          	mov    (%rsp),%rax
    3bef:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    3bf4:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
    3bf9:	4c 89 6c 24 28       	mov    %r13,0x28(%rsp)
    3bfe:	48 89 6c 24 30       	mov    %rbp,0x30(%rsp)
    3c03:	48 89 5c 24 38       	mov    %rbx,0x38(%rsp)
    3c08:	4c 89 74 24 40       	mov    %r14,0x40(%rsp)
    3c0d:	4c 89 7c 24 48       	mov    %r15,0x48(%rsp)
    3c12:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    3c17:	bf 08 00 00 00       	mov    $0x8,%edi
    3c1c:	e8 3f 07 00 00       	call   4360 <fwp_record>
    3c21:	49 89 c6             	mov    %rax,%r14
    3c24:	48 89 c7             	mov    %rax,%rdi
    3c27:	e8 f4 06 00 00       	call   4320 <fwp_rc_fresh>
    3c2c:	48 8d bc 24 d0 00 00 	lea    0xd0(%rsp),%rdi
    3c33:	00 
    3c34:	e8 d7 a0 00 00       	call   dd10 <fwp_cleanup_pop>
    3c39:	4c 89 f0             	mov    %r14,%rax
    3c3c:	48 81 c4 e8 00 00 00 	add    $0xe8,%rsp
    3c43:	5b                   	pop    %rbx
    3c44:	41 5c                	pop    %r12
    3c46:	41 5d                	pop    %r13
    3c48:	41 5e                	pop    %r14
    3c4a:	41 5f                	pop    %r15
    3c4c:	5d                   	pop    %rbp
    3c4d:	c3                   	ret
    3c4e:	66 90                	xchg   %ax,%ax

0000000000003c50 <fwp_rc_release_last>:
    3c50:	50                   	push   %rax
    3c51:	e8 ea 04 00 00       	call   4140 <fwp_rc_slot>
    3c56:	48 89 c7             	mov    %rax,%rdi
    3c59:	31 c0                	xor    %eax,%eax
    3c5b:	48 85 ff             	test   %rdi,%rdi
    3c5e:	74 1a                	je     3c7a <fwp_rc_release_last+0x2a>
    3c60:	0f b6 07             	movzbl (%rdi),%eax
    3c63:	85 c0                	test   %eax,%eax
    3c65:	74 13                	je     3c7a <fwp_rc_release_last+0x2a>
    3c67:	83 f8 01             	cmp    $0x1,%eax
    3c6a:	75 07                	jne    3c73 <fwp_rc_release_last+0x23>
    3c6c:	b8 01 00 00 00       	mov    $0x1,%eax
    3c71:	59                   	pop    %rcx
    3c72:	c3                   	ret
    3c73:	e8 08 a3 00 00       	call   df80 <fwp_rc_drop_slot>
    3c78:	31 c0                	xor    %eax,%eax
    3c7a:	59                   	pop    %rcx
    3c7b:	c3                   	ret
    3c7c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000003c80 <fwp_rc_free_arr>:
    3c80:	41 56                	push   %r14
    3c82:	53                   	push   %rbx
    3c83:	50                   	push   %rax
    3c84:	48 89 fb             	mov    %rdi,%rbx
    3c87:	e8 44 a3 00 00       	call   dfd0 <fwp_rc_last>
    3c8c:	85 c0                	test   %eax,%eax
    3c8e:	74 7d                	je     3d0d <fwp_rc_free_arr+0x8d>
    3c90:	8b 0d f2 36 01 00    	mov    0x136f2(%rip),%ecx        # 17388 <fwp_reuse_verify>
    3c96:	85 c9                	test   %ecx,%ecx
    3c98:	78 0d                	js     3ca7 <fwp_rc_free_arr+0x27>
    3c9a:	85 c9                	test   %ecx,%ecx
    3c9c:	74 41                	je     3cdf <fwp_rc_free_arr+0x5f>
    3c9e:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    3ca5:	eb 66                	jmp    3d0d <fwp_rc_free_arr+0x8d>
    3ca7:	48 8d 3d 00 ca 00 00 	lea    0xca00(%rip),%rdi        # 106ae <exec_in_fp0+0xfae>
    3cae:	e8 7d f3 ff ff       	call   3030 <getenv@plt>
    3cb3:	31 c9                	xor    %ecx,%ecx
    3cb5:	48 85 c0             	test   %rax,%rax
    3cb8:	74 1b                	je     3cd5 <fwp_rc_free_arr+0x55>
    3cba:	80 38 00             	cmpb   $0x0,(%rax)
    3cbd:	74 16                	je     3cd5 <fwp_rc_free_arr+0x55>
    3cbf:	48 8d 35 e5 c7 00 00 	lea    0xc7e5(%rip),%rsi        # 104ab <exec_in_fp0+0xdab>
    3cc6:	48 89 c7             	mov    %rax,%rdi
    3cc9:	e8 02 f6 ff ff       	call   32d0 <strcmp@plt>
    3cce:	31 c9                	xor    %ecx,%ecx
    3cd0:	85 c0                	test   %eax,%eax
    3cd2:	0f 95 c1             	setne  %cl
    3cd5:	89 0d ad 36 01 00    	mov    %ecx,0x136ad(%rip)        # 17388 <fwp_reuse_verify>
    3cdb:	85 c9                	test   %ecx,%ecx
    3cdd:	75 bf                	jne    3c9e <fwp_rc_free_arr+0x1e>
    3cdf:	4c 8b 35 b2 15 01 00 	mov    0x115b2(%rip),%r14        # 15298 <fwp_gc>
    3ce6:	48 89 df             	mov    %rbx,%rdi
    3ce9:	e8 a2 44 00 00       	call   8190 <fwp_mem_free>
    3cee:	48 8b 05 a3 15 01 00 	mov    0x115a3(%rip),%rax        # 15298 <fwp_gc>
    3cf5:	4c 29 f0             	sub    %r14,%rax
    3cf8:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    3cfd:	f2 0f 58 05 9b 27 01 	addsd  0x1279b(%rip),%xmm0        # 164a0 <fwp_gc+0x1208>
    3d04:	00 
    3d05:	f2 0f 11 05 93 27 01 	movsd  %xmm0,0x12793(%rip)        # 164a0 <fwp_gc+0x1208>
    3d0c:	00 
    3d0d:	48 83 c4 08          	add    $0x8,%rsp
    3d11:	5b                   	pop    %rbx
    3d12:	41 5e                	pop    %r14
    3d14:	c3                   	ret
    3d15:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    3d1c:	00 00 00 00 

0000000000003d20 <fwp_rc_free_obj>:
    3d20:	41 56                	push   %r14
    3d22:	53                   	push   %rbx
    3d23:	50                   	push   %rax
    3d24:	48 89 fb             	mov    %rdi,%rbx
    3d27:	e8 a4 a2 00 00       	call   dfd0 <fwp_rc_last>
    3d2c:	85 c0                	test   %eax,%eax
    3d2e:	0f 84 83 00 00 00    	je     3db7 <fwp_rc_free_obj+0x97>
    3d34:	8b 0d 4e 36 01 00    	mov    0x1364e(%rip),%ecx        # 17388 <fwp_reuse_verify>
    3d3a:	85 c9                	test   %ecx,%ecx
    3d3c:	78 13                	js     3d51 <fwp_rc_free_obj+0x31>
    3d3e:	85 c9                	test   %ecx,%ecx
    3d40:	74 47                	je     3d89 <fwp_rc_free_obj+0x69>
    3d42:	48 89 df             	mov    %rbx,%rdi
    3d45:	48 83 c4 08          	add    $0x8,%rsp
    3d49:	5b                   	pop    %rbx
    3d4a:	41 5e                	pop    %r14
    3d4c:	e9 9f a2 00 00       	jmp    dff0 <fwp_rc_poison>
    3d51:	48 8d 3d 56 c9 00 00 	lea    0xc956(%rip),%rdi        # 106ae <exec_in_fp0+0xfae>
    3d58:	e8 d3 f2 ff ff       	call   3030 <getenv@plt>
    3d5d:	31 c9                	xor    %ecx,%ecx
    3d5f:	48 85 c0             	test   %rax,%rax
    3d62:	74 1b                	je     3d7f <fwp_rc_free_obj+0x5f>
    3d64:	80 38 00             	cmpb   $0x0,(%rax)
    3d67:	74 16                	je     3d7f <fwp_rc_free_obj+0x5f>
    3d69:	48 8d 35 3b c7 00 00 	lea    0xc73b(%rip),%rsi        # 104ab <exec_in_fp0+0xdab>
    3d70:	48 89 c7             	mov    %rax,%rdi
    3d73:	e8 58 f5 ff ff       	call   32d0 <strcmp@plt>
    3d78:	31 c9                	xor    %ecx,%ecx
    3d7a:	85 c0                	test   %eax,%eax
    3d7c:	0f 95 c1             	setne  %cl
    3d7f:	89 0d 03 36 01 00    	mov    %ecx,0x13603(%rip)        # 17388 <fwp_reuse_verify>
    3d85:	85 c9                	test   %ecx,%ecx
    3d87:	75 b9                	jne    3d42 <fwp_rc_free_obj+0x22>
    3d89:	4c 8b 35 08 15 01 00 	mov    0x11508(%rip),%r14        # 15298 <fwp_gc>
    3d90:	48 89 df             	mov    %rbx,%rdi
    3d93:	e8 f8 43 00 00       	call   8190 <fwp_mem_free>
    3d98:	48 8b 05 f9 14 01 00 	mov    0x114f9(%rip),%rax        # 15298 <fwp_gc>
    3d9f:	4c 29 f0             	sub    %r14,%rax
    3da2:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    3da7:	f2 0f 58 05 f1 26 01 	addsd  0x126f1(%rip),%xmm0        # 164a0 <fwp_gc+0x1208>
    3dae:	00 
    3daf:	f2 0f 11 05 e9 26 01 	movsd  %xmm0,0x126e9(%rip)        # 164a0 <fwp_gc+0x1208>
    3db6:	00 
    3db7:	48 83 c4 08          	add    $0x8,%rsp
    3dbb:	5b                   	pop    %rbx
    3dbc:	41 5e                	pop    %r14
    3dbe:	c3                   	ret
    3dbf:	90                   	nop

0000000000003dc0 <e0>:
    3dc0:	50                   	push   %rax
    3dc1:	48 8b 3f             	mov    (%rdi),%rdi
    3dc4:	e8 e7 01 00 00       	call   3fb0 <f0>
    3dc9:	48 89 c7             	mov    %rax,%rdi
    3dcc:	58                   	pop    %rax
    3dcd:	e9 ce 01 00 00       	jmp    3fa0 <fwp_rc_shared>
    3dd2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3dd9:	1f 84 00 00 00 00 00 

0000000000003de0 <e1>:
    3de0:	50                   	push   %rax
    3de1:	48 8b 3f             	mov    (%rdi),%rdi
    3de4:	e8 37 24 00 00       	call   6220 <f1>
    3de9:	48 89 c7             	mov    %rax,%rdi
    3dec:	58                   	pop    %rax
    3ded:	e9 ae 01 00 00       	jmp    3fa0 <fwp_rc_shared>
    3df2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3df9:	1f 84 00 00 00 00 00 

0000000000003e00 <e2>:
    3e00:	50                   	push   %rax
    3e01:	48 8b 3f             	mov    (%rdi),%rdi
    3e04:	e8 27 fd ff ff       	call   3b30 <f2>
    3e09:	48 89 c7             	mov    %rax,%rdi
    3e0c:	58                   	pop    %rax
    3e0d:	e9 8e 01 00 00       	jmp    3fa0 <fwp_rc_shared>
    3e12:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3e19:	1f 84 00 00 00 00 00 

0000000000003e20 <e3>:
    3e20:	50                   	push   %rax
    3e21:	48 8b 3f             	mov    (%rdi),%rdi
    3e24:	e8 a7 24 00 00       	call   62d0 <f3>
    3e29:	48 89 c7             	mov    %rax,%rdi
    3e2c:	58                   	pop    %rax
    3e2d:	e9 6e 01 00 00       	jmp    3fa0 <fwp_rc_shared>
    3e32:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3e39:	1f 84 00 00 00 00 00 

0000000000003e40 <e4>:
    3e40:	50                   	push   %rax
    3e41:	48 8b 3f             	mov    (%rdi),%rdi
    3e44:	e8 b7 25 00 00       	call   6400 <f4>
    3e49:	48 89 c7             	mov    %rax,%rdi
    3e4c:	58                   	pop    %rax
    3e4d:	e9 4e 01 00 00       	jmp    3fa0 <fwp_rc_shared>
    3e52:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3e59:	1f 84 00 00 00 00 00 

0000000000003e60 <e6>:
    3e60:	50                   	push   %rax
    3e61:	48 8b 07             	mov    (%rdi),%rax
    3e64:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    3e68:	48 89 c7             	mov    %rax,%rdi
    3e6b:	e8 40 25 00 00       	call   63b0 <f6>
    3e70:	48 89 c7             	mov    %rax,%rdi
    3e73:	58                   	pop    %rax
    3e74:	e9 27 01 00 00       	jmp    3fa0 <fwp_rc_shared>
    3e79:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000003e80 <e10>:
    3e80:	50                   	push   %rax
    3e81:	48 8b 3f             	mov    (%rdi),%rdi
    3e84:	e8 57 25 00 00       	call   63e0 <f10>
    3e89:	48 89 c7             	mov    %rax,%rdi
    3e8c:	58                   	pop    %rax
    3e8d:	e9 0e 01 00 00       	jmp    3fa0 <fwp_rc_shared>
    3e92:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3e99:	1f 84 00 00 00 00 00 

0000000000003ea0 <e12>:
    3ea0:	50                   	push   %rax
    3ea1:	48 8b 07             	mov    (%rdi),%rax
    3ea4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    3ea8:	48 89 c7             	mov    %rax,%rdi
    3eab:	e8 a0 25 00 00       	call   6450 <f12>
    3eb0:	48 89 c7             	mov    %rax,%rdi
    3eb3:	58                   	pop    %rax
    3eb4:	e9 e7 00 00 00       	jmp    3fa0 <fwp_rc_shared>
    3eb9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000003ec0 <e14>:
    3ec0:	50                   	push   %rax
    3ec1:	48 8b 07             	mov    (%rdi),%rax
    3ec4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    3ec8:	48 89 c7             	mov    %rax,%rdi
    3ecb:	e8 90 26 00 00       	call   6560 <f14>
    3ed0:	48 89 c7             	mov    %rax,%rdi
    3ed3:	58                   	pop    %rax
    3ed4:	e9 c7 00 00 00       	jmp    3fa0 <fwp_rc_shared>
    3ed9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000003ee0 <e16>:
    3ee0:	50                   	push   %rax
    3ee1:	48 8b 07             	mov    (%rdi),%rax
    3ee4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    3ee8:	48 89 c7             	mov    %rax,%rdi
    3eeb:	e8 80 26 00 00       	call   6570 <f16>
    3ef0:	48 89 c7             	mov    %rax,%rdi
    3ef3:	58                   	pop    %rax
    3ef4:	e9 a7 00 00 00       	jmp    3fa0 <fwp_rc_shared>
    3ef9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000003f00 <e18>:
    3f00:	50                   	push   %rax
    3f01:	48 8b 07             	mov    (%rdi),%rax
    3f04:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    3f08:	48 89 c7             	mov    %rax,%rdi
    3f0b:	e8 70 26 00 00       	call   6580 <f18>
    3f10:	48 89 c7             	mov    %rax,%rdi
    3f13:	58                   	pop    %rax
    3f14:	e9 87 00 00 00       	jmp    3fa0 <fwp_rc_shared>
    3f19:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000003f20 <e20>:
    3f20:	50                   	push   %rax
    3f21:	48 8b 07             	mov    (%rdi),%rax
    3f24:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    3f28:	48 89 c7             	mov    %rax,%rdi
    3f2b:	e8 60 26 00 00       	call   6590 <f20>
    3f30:	48 89 c7             	mov    %rax,%rdi
    3f33:	58                   	pop    %rax
    3f34:	eb 6a                	jmp    3fa0 <fwp_rc_shared>
    3f36:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    3f3d:	00 00 00 

0000000000003f40 <e22>:
    3f40:	50                   	push   %rax
    3f41:	48 8b 07             	mov    (%rdi),%rax
    3f44:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    3f48:	48 89 c7             	mov    %rax,%rdi
    3f4b:	e8 50 26 00 00       	call   65a0 <f22>
    3f50:	48 89 c7             	mov    %rax,%rdi
    3f53:	58                   	pop    %rax
    3f54:	eb 4a                	jmp    3fa0 <fwp_rc_shared>
    3f56:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    3f5d:	00 00 00 

0000000000003f60 <e24>:
    3f60:	50                   	push   %rax
    3f61:	48 8b 07             	mov    (%rdi),%rax
    3f64:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    3f68:	48 89 c7             	mov    %rax,%rdi
    3f6b:	e8 40 26 00 00       	call   65b0 <f24>
    3f70:	48 89 c7             	mov    %rax,%rdi
    3f73:	58                   	pop    %rax
    3f74:	eb 2a                	jmp    3fa0 <fwp_rc_shared>
    3f76:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    3f7d:	00 00 00 

0000000000003f80 <e26>:
    3f80:	50                   	push   %rax
    3f81:	48 8b 07             	mov    (%rdi),%rax
    3f84:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    3f88:	48 89 c7             	mov    %rax,%rdi
    3f8b:	e8 30 26 00 00       	call   65c0 <f26>
    3f90:	48 89 c7             	mov    %rax,%rdi
    3f93:	58                   	pop    %rax
    3f94:	eb 0a                	jmp    3fa0 <fwp_rc_shared>
    3f96:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    3f9d:	00 00 00 

0000000000003fa0 <fwp_rc_shared>:
    3fa0:	53                   	push   %rbx
    3fa1:	48 89 fb             	mov    %rdi,%rbx
    3fa4:	e8 77 00 00 00       	call   4020 <fwp_rc_share>
    3fa9:	48 89 d8             	mov    %rbx,%rax
    3fac:	5b                   	pop    %rbx
    3fad:	c3                   	ret
    3fae:	66 90                	xchg   %ax,%ax

0000000000003fb0 <f0>:
    3fb0:	53                   	push   %rbx
    3fb1:	48 83 ec 30          	sub    $0x30,%rsp
    3fb5:	e8 56 03 00 00       	call   4310 <fwp_f64>
    3fba:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    3fbf:	e8 1c 03 00 00       	call   42e0 <w0>
    3fc4:	f2 0f 10 44 24 18    	movsd  0x18(%rsp),%xmm0
    3fca:	e8 a1 03 00 00       	call   4370 <fwp_from_f64>
    3fcf:	48 89 04 24          	mov    %rax,(%rsp)
    3fd3:	f2 0f 10 44 24 20    	movsd  0x20(%rsp),%xmm0
    3fd9:	e8 92 03 00 00       	call   4370 <fwp_from_f64>
    3fde:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    3fe3:	f2 0f 10 44 24 28    	movsd  0x28(%rsp),%xmm0
    3fe9:	e8 82 03 00 00       	call   4370 <fwp_from_f64>
    3fee:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    3ff3:	48 89 e6             	mov    %rsp,%rsi
    3ff6:	bf 03 00 00 00       	mov    $0x3,%edi
    3ffb:	e8 60 03 00 00       	call   4360 <fwp_record>
    4000:	48 89 c3             	mov    %rax,%rbx
    4003:	48 89 c7             	mov    %rax,%rdi
    4006:	e8 15 03 00 00       	call   4320 <fwp_rc_fresh>
    400b:	48 89 d8             	mov    %rbx,%rax
    400e:	48 83 c4 30          	add    $0x30,%rsp
    4012:	5b                   	pop    %rbx
    4013:	c3                   	ret
    4014:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    401b:	00 00 00 00 00 

0000000000004020 <fwp_rc_share>:
    4020:	41 57                	push   %r15
    4022:	41 56                	push   %r14
    4024:	41 55                	push   %r13
    4026:	41 54                	push   %r12
    4028:	53                   	push   %rbx
    4029:	48 81 ec 00 02 00 00 	sub    $0x200,%rsp
    4030:	48 89 fb             	mov    %rdi,%rbx
    4033:	e8 08 01 00 00       	call   4140 <fwp_rc_slot>
    4038:	48 85 c0             	test   %rax,%rax
    403b:	0f 84 ec 00 00 00    	je     412d <fwp_rc_share+0x10d>
    4041:	80 38 00             	cmpb   $0x0,(%rax)
    4044:	0f 84 e3 00 00 00    	je     412d <fwp_rc_share+0x10d>
    404a:	48 89 c7             	mov    %rax,%rdi
    404d:	e8 5e 01 00 00       	call   41b0 <fwp_rc_clear_slot>
    4052:	48 89 1c 24          	mov    %rbx,(%rsp)
    4056:	41 be 01 00 00 00    	mov    $0x1,%r14d
    405c:	eb 0b                	jmp    4069 <fwp_rc_share+0x49>
    405e:	66 90                	xchg   %ax,%ax
    4060:	4d 85 f6             	test   %r14,%r14
    4063:	0f 84 c4 00 00 00    	je     412d <fwp_rc_share+0x10d>
    4069:	4e 8b 7c f4 f8       	mov    -0x8(%rsp,%r14,8),%r15
    406e:	49 ff ce             	dec    %r14
    4071:	4c 89 ff             	mov    %r15,%rdi
    4074:	48 2b 3d 4d 22 01 00 	sub    0x1224d(%rip),%rdi        # 162c8 <fwp_gc+0x1030>
    407b:	48 c1 ef 10          	shr    $0x10,%rdi
    407f:	48 8b 05 8a 22 01 00 	mov    0x1228a(%rip),%rax        # 16310 <fwp_gc+0x1078>
    4086:	48 69 cf 28 12 00 00 	imul   $0x1228,%rdi,%rcx
    408d:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    4092:	74 cc                	je     4060 <fwp_rc_share+0x40>
    4094:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    4098:	80 fa 02             	cmp    $0x2,%dl
    409b:	75 13                	jne    40b0 <fwp_rc_share+0x90>
    409d:	4c 8b 64 08 18       	mov    0x18(%rax,%rcx,1),%r12
    40a2:	eb 33                	jmp    40d7 <fwp_rc_share+0xb7>
    40a4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    40ab:	00 00 00 00 00 
    40b0:	44 8b 64 08 08       	mov    0x8(%rax,%rcx,1),%r12d
    40b5:	80 fa 01             	cmp    $0x1,%dl
    40b8:	75 1d                	jne    40d7 <fwp_rc_share+0xb7>
    40ba:	41 0f b7 d7          	movzwl %r15w,%edx
    40be:	44 8b 7c 08 20       	mov    0x20(%rax,%rcx,1),%r15d
    40c3:	4c 0f af fa          	imul   %rdx,%r15
    40c7:	49 c1 ef 20          	shr    $0x20,%r15
    40cb:	e8 00 01 00 00       	call   41d0 <fwp_gc_chunk_addr>
    40d0:	4d 0f af fc          	imul   %r12,%r15
    40d4:	49 01 c7             	add    %rax,%r15
    40d7:	49 83 fc 08          	cmp    $0x8,%r12
    40db:	72 83                	jb     4060 <fwp_rc_share+0x40>
    40dd:	49 c1 ec 03          	shr    $0x3,%r12
    40e1:	45 31 ed             	xor    %r13d,%r13d
    40e4:	eb 16                	jmp    40fc <fwp_rc_share+0xdc>
    40e6:	48 89 df             	mov    %rbx,%rdi
    40e9:	e8 32 ff ff ff       	call   4020 <fwp_rc_share>
    40ee:	66 90                	xchg   %ax,%ax
    40f0:	49 ff c5             	inc    %r13
    40f3:	4d 39 ec             	cmp    %r13,%r12
    40f6:	0f 84 64 ff ff ff    	je     4060 <fwp_rc_share+0x40>
    40fc:	4b 8b 1c ef          	mov    (%r15,%r13,8),%rbx
    4100:	48 89 df             	mov    %rbx,%rdi
    4103:	e8 38 00 00 00       	call   4140 <fwp_rc_slot>
    4108:	48 85 c0             	test   %rax,%rax
    410b:	74 e3                	je     40f0 <fwp_rc_share+0xd0>
    410d:	80 38 00             	cmpb   $0x0,(%rax)
    4110:	74 de                	je     40f0 <fwp_rc_share+0xd0>
    4112:	49 83 fe 3f          	cmp    $0x3f,%r14
    4116:	77 ce                	ja     40e6 <fwp_rc_share+0xc6>
    4118:	48 89 c7             	mov    %rax,%rdi
    411b:	e8 90 00 00 00       	call   41b0 <fwp_rc_clear_slot>
    4120:	4b 8b 04 ef          	mov    (%r15,%r13,8),%rax
    4124:	4a 89 04 f4          	mov    %rax,(%rsp,%r14,8)
    4128:	49 ff c6             	inc    %r14
    412b:	eb c3                	jmp    40f0 <fwp_rc_share+0xd0>
    412d:	48 81 c4 00 02 00 00 	add    $0x200,%rsp
    4134:	5b                   	pop    %rbx
    4135:	41 5c                	pop    %r12
    4137:	41 5d                	pop    %r13
    4139:	41 5e                	pop    %r14
    413b:	41 5f                	pop    %r15
    413d:	c3                   	ret
    413e:	66 90                	xchg   %ax,%ax

0000000000004140 <fwp_rc_slot>:
    4140:	48 2b 3d 81 21 01 00 	sub    0x12181(%rip),%rdi        # 162c8 <fwp_gc+0x1030>
    4147:	48 8b 05 a2 21 01 00 	mov    0x121a2(%rip),%rax        # 162f0 <fwp_gc+0x1058>
    414e:	48 c1 e0 10          	shl    $0x10,%rax
    4152:	48 39 c7             	cmp    %rax,%rdi
    4155:	73 51                	jae    41a8 <fwp_rc_slot+0x68>
    4157:	48 8b 05 b2 21 01 00 	mov    0x121b2(%rip),%rax        # 16310 <fwp_gc+0x1078>
    415e:	48 89 f9             	mov    %rdi,%rcx
    4161:	48 c1 e9 10          	shr    $0x10,%rcx
    4165:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    416c:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    4170:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    4177:	75 0f                	jne    4188 <fwp_rc_slot+0x48>
    4179:	80 fa 02             	cmp    $0x2,%dl
    417c:	75 0a                	jne    4188 <fwp_rc_slot+0x48>
    417e:	48 01 c8             	add    %rcx,%rax
    4181:	48 05 28 02 00 00    	add    $0x228,%rax
    4187:	c3                   	ret
    4188:	80 fa 01             	cmp    $0x1,%dl
    418b:	75 1b                	jne    41a8 <fwp_rc_slot+0x68>
    418d:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    4191:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    4195:	48 0f af f8          	imul   %rax,%rdi
    4199:	48 c1 ef 20          	shr    $0x20,%rdi
    419d:	48 8d 04 17          	lea    (%rdi,%rdx,1),%rax
    41a1:	48 05 28 02 00 00    	add    $0x228,%rax
    41a7:	c3                   	ret
    41a8:	31 c0                	xor    %eax,%eax
    41aa:	c3                   	ret
    41ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000041b0 <fwp_rc_clear_slot>:
    41b0:	80 3f ff             	cmpb   $0xff,(%rdi)
    41b3:	74 04                	je     41b9 <fwp_rc_clear_slot+0x9>
    41b5:	c6 07 00             	movb   $0x0,(%rdi)
    41b8:	c3                   	ret
    41b9:	53                   	push   %rbx
    41ba:	48 89 fb             	mov    %rdi,%rbx
    41bd:	e8 1e 00 00 00       	call   41e0 <fwp_rc_forget_slot>
    41c2:	48 89 df             	mov    %rbx,%rdi
    41c5:	5b                   	pop    %rbx
    41c6:	c6 07 00             	movb   $0x0,(%rdi)
    41c9:	c3                   	ret
    41ca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000041d0 <fwp_gc_chunk_addr>:
    41d0:	48 89 f8             	mov    %rdi,%rax
    41d3:	48 c1 e0 10          	shl    $0x10,%rax
    41d7:	48 03 05 ea 20 01 00 	add    0x120ea(%rip),%rax        # 162c8 <fwp_gc+0x1030>
    41de:	c3                   	ret
    41df:	90                   	nop

00000000000041e0 <fwp_rc_forget_slot>:
    41e0:	50                   	push   %rax
    41e1:	80 3f ff             	cmpb   $0xff,(%rdi)
    41e4:	74 02                	je     41e8 <fwp_rc_forget_slot+0x8>
    41e6:	58                   	pop    %rax
    41e7:	c3                   	ret
    41e8:	e8 33 00 00 00       	call   4220 <fwp_rc_wide_link>
    41ed:	48 8b 38             	mov    (%rax),%rdi
    41f0:	48 85 ff             	test   %rdi,%rdi
    41f3:	74 15                	je     420a <fwp_rc_forget_slot+0x2a>
    41f5:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    41f9:	48 89 08             	mov    %rcx,(%rax)
    41fc:	e8 4f ee ff ff       	call   3050 <free@plt>
    4201:	48 ff 0d a8 2a 01 00 	decq   0x12aa8(%rip)        # 16cb0 <fwp_gc+0x1a18>
    4208:	58                   	pop    %rax
    4209:	c3                   	ret
    420a:	48 8d 3d 61 b6 00 00 	lea    0xb661(%rip),%rdi        # f872 <exec_in_fp0+0x172>
    4211:	e8 6a 00 00 00       	call   4280 <fwp_trap>
    4216:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    421d:	00 00 00 

0000000000004220 <fwp_rc_wide_link>:
    4220:	48 89 f8             	mov    %rdi,%rax
    4223:	48 c1 e8 11          	shr    $0x11,%rax
    4227:	31 f8                	xor    %edi,%eax
    4229:	89 c1                	mov    %eax,%ecx
    422b:	c1 e9 09             	shr    $0x9,%ecx
    422e:	31 c1                	xor    %eax,%ecx
    4230:	0f b6 c9             	movzbl %cl,%ecx
    4233:	48 8d 15 5e 10 01 00 	lea    0x1105e(%rip),%rdx        # 15298 <fwp_gc>
    423a:	48 8d 04 ca          	lea    (%rdx,%rcx,8),%rax
    423e:	48 05 18 12 00 00    	add    $0x1218,%rax
    4244:	48 8b 8c ca 18 12 00 	mov    0x1218(%rdx,%rcx,8),%rcx
    424b:	00 
    424c:	48 85 c9             	test   %rcx,%rcx
    424f:	74 24                	je     4275 <fwp_rc_wide_link+0x55>
    4251:	48 39 39             	cmp    %rdi,(%rcx)
    4254:	74 1f                	je     4275 <fwp_rc_wide_link+0x55>
    4256:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    425d:	00 00 00 
    4260:	48 89 c8             	mov    %rcx,%rax
    4263:	48 8b 49 10          	mov    0x10(%rcx),%rcx
    4267:	48 85 c9             	test   %rcx,%rcx
    426a:	74 05                	je     4271 <fwp_rc_wide_link+0x51>
    426c:	48 39 39             	cmp    %rdi,(%rcx)
    426f:	75 ef                	jne    4260 <fwp_rc_wide_link+0x40>
    4271:	48 83 c0 10          	add    $0x10,%rax
    4275:	c3                   	ret
    4276:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    427d:	00 00 00 

0000000000004280 <fwp_trap>:
    4280:	53                   	push   %rbx
    4281:	48 89 fb             	mov    %rdi,%rbx
    4284:	e8 27 00 00 00       	call   42b0 <fwp_flush>
    4289:	48 8b 05 48 0d 01 00 	mov    0x10d48(%rip),%rax        # 14fd8 <stderr@GLIBC_2.2.5>
    4290:	48 8b 38             	mov    (%rax),%rdi
    4293:	48 8d 35 ff b5 00 00 	lea    0xb5ff(%rip),%rsi        # f899 <exec_in_fp0+0x199>
    429a:	48 89 da             	mov    %rbx,%rdx
    429d:	31 c0                	xor    %eax,%eax
    429f:	e8 4c f0 ff ff       	call   32f0 <fprintf@plt>
    42a4:	bf 65 00 00 00       	mov    $0x65,%edi
    42a9:	e8 d2 f1 ff ff       	call   3480 <exit@plt>
    42ae:	66 90                	xchg   %ax,%ax

00000000000042b0 <fwp_flush>:
    42b0:	50                   	push   %rax
    42b1:	48 8b 3d f0 30 01 00 	mov    0x130f0(%rip),%rdi        # 173a8 <fwp_prog_out>
    42b8:	48 85 ff             	test   %rdi,%rdi
    42bb:	74 05                	je     42c2 <fwp_flush+0x12>
    42bd:	e8 8e f0 ff ff       	call   3350 <fflush@plt>
    42c2:	48 8b 05 e7 0c 01 00 	mov    0x10ce7(%rip),%rax        # 14fb0 <stdout@GLIBC_2.2.5>
    42c9:	48 8b 38             	mov    (%rax),%rdi
    42cc:	58                   	pop    %rax
    42cd:	e9 7e f0 ff ff       	jmp    3350 <fflush@plt>
    42d2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    42d9:	1f 84 00 00 00 00 00 

00000000000042e0 <w0>:
    42e0:	53                   	push   %rbx
    42e1:	48 89 fb             	mov    %rdi,%rbx
    42e4:	e8 87 00 00 00       	call   4370 <fwp_from_f64>
    42e9:	48 89 c7             	mov    %rax,%rdi
    42ec:	e8 1f 00 00 00       	call   4310 <fwp_f64>
    42f1:	f2 0f 11 03          	movsd  %xmm0,(%rbx)
    42f5:	f2 0f 11 43 08       	movsd  %xmm0,0x8(%rbx)
    42fa:	f2 0f 11 43 10       	movsd  %xmm0,0x10(%rbx)
    42ff:	48 89 d8             	mov    %rbx,%rax
    4302:	5b                   	pop    %rbx
    4303:	c3                   	ret
    4304:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    430b:	00 00 00 00 00 

0000000000004310 <fwp_f64>:
    4310:	66 48 0f 6e c7       	movq   %rdi,%xmm0
    4315:	c3                   	ret
    4316:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    431d:	00 00 00 

0000000000004320 <fwp_rc_fresh>:
    4320:	41 56                	push   %r14
    4322:	53                   	push   %rbx
    4323:	50                   	push   %rax
    4324:	48 89 fb             	mov    %rdi,%rbx
    4327:	e8 14 fe ff ff       	call   4140 <fwp_rc_slot>
    432c:	48 85 c0             	test   %rax,%rax
    432f:	74 08                	je     4339 <fwp_rc_fresh+0x19>
    4331:	80 38 ff             	cmpb   $0xff,(%rax)
    4334:	74 0e                	je     4344 <fwp_rc_fresh+0x24>
    4336:	c6 00 01             	movb   $0x1,(%rax)
    4339:	48 89 d8             	mov    %rbx,%rax
    433c:	48 83 c4 08          	add    $0x8,%rsp
    4340:	5b                   	pop    %rbx
    4341:	41 5e                	pop    %r14
    4343:	c3                   	ret
    4344:	48 89 c7             	mov    %rax,%rdi
    4347:	49 89 c6             	mov    %rax,%r14
    434a:	e8 91 fe ff ff       	call   41e0 <fwp_rc_forget_slot>
    434f:	4c 89 f0             	mov    %r14,%rax
    4352:	eb e2                	jmp    4336 <fwp_rc_fresh+0x16>
    4354:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    435b:	00 00 00 00 00 

0000000000004360 <fwp_record>:
    4360:	85 ff                	test   %edi,%edi
    4362:	74 09                	je     436d <fwp_record+0xd>
    4364:	48 89 f2             	mov    %rsi,%rdx
    4367:	89 fe                	mov    %edi,%esi
    4369:	31 ff                	xor    %edi,%edi
    436b:	eb 13                	jmp    4380 <fwp_data>
    436d:	31 c0                	xor    %eax,%eax
    436f:	c3                   	ret

0000000000004370 <fwp_from_f64>:
    4370:	66 48 0f 7e c0       	movq   %xmm0,%rax
    4375:	c3                   	ret
    4376:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    437d:	00 00 00 

0000000000004380 <fwp_data>:
    4380:	55                   	push   %rbp
    4381:	41 57                	push   %r15
    4383:	41 56                	push   %r14
    4385:	53                   	push   %rbx
    4386:	50                   	push   %rax
    4387:	89 fd                	mov    %edi,%ebp
    4389:	85 f6                	test   %esi,%esi
    438b:	0f 84 a1 00 00 00    	je     4432 <fwp_data+0xb2>
    4391:	48 89 d3             	mov    %rdx,%rbx
    4394:	41 89 f6             	mov    %esi,%r14d
    4397:	4a 8d 3c f5 08 00 00 	lea    0x8(,%r14,8),%rdi
    439e:	00 
    439f:	41 89 f7             	mov    %esi,%r15d
    43a2:	e8 d9 00 00 00       	call   4480 <fwp_alloc_init>
    43a7:	89 28                	mov    %ebp,(%rax)
    43a9:	44 89 78 04          	mov    %r15d,0x4(%rax)
    43ad:	41 83 ff 08          	cmp    $0x8,%r15d
    43b1:	72 10                	jb     43c3 <fwp_data+0x43>
    43b3:	48 89 c1             	mov    %rax,%rcx
    43b6:	48 29 d9             	sub    %rbx,%rcx
    43b9:	48 83 c1 08          	add    $0x8,%rcx
    43bd:	48 83 f9 20          	cmp    $0x20,%rcx
    43c1:	73 73                	jae    4436 <fwp_data+0xb6>
    43c3:	31 c9                	xor    %ecx,%ecx
    43c5:	4c 89 f6             	mov    %r14,%rsi
    43c8:	48 89 ca             	mov    %rcx,%rdx
    43cb:	48 83 e6 03          	and    $0x3,%rsi
    43cf:	74 20                	je     43f1 <fwp_data+0x71>
    43d1:	48 89 ca             	mov    %rcx,%rdx
    43d4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    43db:	00 00 00 00 00 
    43e0:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    43e4:	48 89 7c d0 08       	mov    %rdi,0x8(%rax,%rdx,8)
    43e9:	48 ff c2             	inc    %rdx
    43ec:	48 ff ce             	dec    %rsi
    43ef:	75 ef                	jne    43e0 <fwp_data+0x60>
    43f1:	4c 29 f1             	sub    %r14,%rcx
    43f4:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    43f8:	77 7b                	ja     4475 <fwp_data+0xf5>
    43fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    4400:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    4404:	48 89 4c d0 08       	mov    %rcx,0x8(%rax,%rdx,8)
    4409:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    440e:	48 89 4c d0 10       	mov    %rcx,0x10(%rax,%rdx,8)
    4413:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    4418:	48 89 4c d0 18       	mov    %rcx,0x18(%rax,%rdx,8)
    441d:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    4422:	48 89 4c d0 20       	mov    %rcx,0x20(%rax,%rdx,8)
    4427:	48 83 c2 04          	add    $0x4,%rdx
    442b:	49 39 d6             	cmp    %rdx,%r14
    442e:	75 d0                	jne    4400 <fwp_data+0x80>
    4430:	eb 43                	jmp    4475 <fwp_data+0xf5>
    4432:	89 e8                	mov    %ebp,%eax
    4434:	eb 3f                	jmp    4475 <fwp_data+0xf5>
    4436:	44 89 f1             	mov    %r14d,%ecx
    4439:	83 e1 fc             	and    $0xfffffffc,%ecx
    443c:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
    4443:	00 
    4444:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    4448:	31 f6                	xor    %esi,%esi
    444a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    4450:	0f 10 04 33          	movups (%rbx,%rsi,1),%xmm0
    4454:	0f 10 4c 33 10       	movups 0x10(%rbx,%rsi,1),%xmm1
    4459:	0f 11 44 30 08       	movups %xmm0,0x8(%rax,%rsi,1)
    445e:	0f 11 4c 30 18       	movups %xmm1,0x18(%rax,%rsi,1)
    4463:	48 83 c6 20          	add    $0x20,%rsi
    4467:	48 39 f2             	cmp    %rsi,%rdx
    446a:	75 e4                	jne    4450 <fwp_data+0xd0>
    446c:	4c 39 f1             	cmp    %r14,%rcx
    446f:	0f 85 50 ff ff ff    	jne    43c5 <fwp_data+0x45>
    4475:	48 83 c4 08          	add    $0x8,%rsp
    4479:	5b                   	pop    %rbx
    447a:	41 5e                	pop    %r14
    447c:	41 5f                	pop    %r15
    447e:	5d                   	pop    %rbp
    447f:	c3                   	ret

0000000000004480 <fwp_alloc_init>:
    4480:	53                   	push   %rbx
    4481:	48 89 fa             	mov    %rdi,%rdx
    4484:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    448b:	0f 87 a7 00 00 00    	ja     4538 <fwp_alloc_init+0xb8>
    4491:	48 8d 42 0f          	lea    0xf(%rdx),%rax
    4495:	48 c1 e8 04          	shr    $0x4,%rax
    4499:	48 8d 35 f8 0d 01 00 	lea    0x10df8(%rip),%rsi        # 15298 <fwp_gc>
    44a0:	0f b6 bc 30 e8 0b 00 	movzbl 0xbe8(%rax,%rsi,1),%edi
    44a7:	00 
    44a8:	8b 84 be 48 0b 00 00 	mov    0xb48(%rsi,%rdi,4),%eax
    44af:	48 8b 0d e2 0d 01 00 	mov    0x10de2(%rip),%rcx        # 15298 <fwp_gc>
    44b6:	49 89 c8             	mov    %rcx,%r8
    44b9:	49 29 c0             	sub    %rax,%r8
    44bc:	4c 89 05 d5 0d 01 00 	mov    %r8,0x10dd5(%rip)        # 15298 <fwp_gc>
    44c3:	78 6c                	js     4531 <fwp_alloc_init+0xb1>
    44c5:	48 8d 3c 7f          	lea    (%rdi,%rdi,2),%rdi
    44c9:	4c 8d 04 fe          	lea    (%rsi,%rdi,8),%r8
    44cd:	49 83 c0 08          	add    $0x8,%r8
    44d1:	49 8b 18             	mov    (%r8),%rbx
    44d4:	48 85 db             	test   %rbx,%rbx
    44d7:	74 32                	je     450b <fwp_alloc_init+0x8b>
    44d9:	48 8b 0b             	mov    (%rbx),%rcx
    44dc:	48 f7 d1             	not    %rcx
    44df:	49 89 08             	mov    %rcx,(%r8)
    44e2:	81 e2 f8 7f 00 00    	and    $0x7ff8,%edx
    44e8:	48 39 c2             	cmp    %rax,%rdx
    44eb:	73 19                	jae    4506 <fwp_alloc_init+0x86>
    44ed:	48 8d 3c 13          	lea    (%rbx,%rdx,1),%rdi
    44f1:	48 f7 d2             	not    %rdx
    44f4:	48 01 c2             	add    %rax,%rdx
    44f7:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    44fb:	48 83 c2 08          	add    $0x8,%rdx
    44ff:	31 f6                	xor    %esi,%esi
    4501:	e8 0a ed ff ff       	call   3210 <memset@plt>
    4506:	48 89 d8             	mov    %rbx,%rax
    4509:	5b                   	pop    %rbx
    450a:	c3                   	ret
    450b:	48 8b 5c fe 10       	mov    0x10(%rsi,%rdi,8),%rbx
    4510:	4c 8b 44 fe 18       	mov    0x18(%rsi,%rdi,8),%r8
    4515:	49 29 d8             	sub    %rbx,%r8
    4518:	49 39 c0             	cmp    %rax,%r8
    451b:	72 14                	jb     4531 <fwp_alloc_init+0xb1>
    451d:	48 8d 34 fe          	lea    (%rsi,%rdi,8),%rsi
    4521:	48 83 c6 10          	add    $0x10,%rsi
    4525:	48 8d 3c 03          	lea    (%rbx,%rax,1),%rdi
    4529:	48 89 3e             	mov    %rdi,(%rsi)
    452c:	48 85 db             	test   %rbx,%rbx
    452f:	75 b1                	jne    44e2 <fwp_alloc_init+0x62>
    4531:	48 89 0d 60 0d 01 00 	mov    %rcx,0x10d60(%rip)        # 15298 <fwp_gc>
    4538:	48 89 d7             	mov    %rdx,%rdi
    453b:	31 f6                	xor    %esi,%esi
    453d:	5b                   	pop    %rbx
    453e:	eb 00                	jmp    4540 <fwp_gc_alloc>

0000000000004540 <fwp_gc_alloc>:
    4540:	53                   	push   %rbx
    4541:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    4548:	77 6c                	ja     45b6 <fwp_gc_alloc+0x76>
    454a:	48 8d 4f 0f          	lea    0xf(%rdi),%rcx
    454e:	48 c1 e9 04          	shr    $0x4,%rcx
    4552:	48 8d 05 3f 0d 01 00 	lea    0x10d3f(%rip),%rax        # 15298 <fwp_gc>
    4559:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    4560:	00 
    4561:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    4568:	48 29 15 29 0d 01 00 	sub    %rdx,0x10d29(%rip)        # 15298 <fwp_gc>
    456f:	78 45                	js     45b6 <fwp_gc_alloc+0x76>
    4571:	41 89 f0             	mov    %esi,%r8d
    4574:	4d 69 c0 c0 03 00 00 	imul   $0x3c0,%r8,%r8
    457b:	4c 01 c0             	add    %r8,%rax
    457e:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    4582:	4c 8d 04 c8          	lea    (%rax,%rcx,8),%r8
    4586:	49 83 c0 08          	add    $0x8,%r8
    458a:	49 8b 18             	mov    (%r8),%rbx
    458d:	48 85 db             	test   %rbx,%rbx
    4590:	74 12                	je     45a4 <fwp_gc_alloc+0x64>
    4592:	48 8b 03             	mov    (%rbx),%rax
    4595:	48 f7 d0             	not    %rax
    4598:	49 89 00             	mov    %rax,(%r8)
    459b:	83 fe 01             	cmp    $0x1,%esi
    459e:	48 0f 44 d7          	cmove  %rdi,%rdx
    45a2:	eb 2e                	jmp    45d2 <fwp_gc_alloc+0x92>
    45a4:	48 8b 5c c8 10       	mov    0x10(%rax,%rcx,8),%rbx
    45a9:	4c 8b 44 c8 18       	mov    0x18(%rax,%rcx,8),%r8
    45ae:	49 29 d8             	sub    %rbx,%r8
    45b1:	49 39 d0             	cmp    %rdx,%r8
    45b4:	73 03                	jae    45b9 <fwp_gc_alloc+0x79>
    45b6:	5b                   	pop    %rbx
    45b7:	eb 37                	jmp    45f0 <fwp_gc_alloc_slow>
    45b9:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    45bd:	48 83 c0 10          	add    $0x10,%rax
    45c1:	48 8d 0c 13          	lea    (%rbx,%rdx,1),%rcx
    45c5:	48 89 08             	mov    %rcx,(%rax)
    45c8:	83 fe 01             	cmp    $0x1,%esi
    45cb:	48 0f 45 fa          	cmovne %rdx,%rdi
    45cf:	48 89 fa             	mov    %rdi,%rdx
    45d2:	48 89 df             	mov    %rbx,%rdi
    45d5:	31 f6                	xor    %esi,%esi
    45d7:	e8 34 ec ff ff       	call   3210 <memset@plt>
    45dc:	48 89 d8             	mov    %rbx,%rax
    45df:	5b                   	pop    %rbx
    45e0:	c3                   	ret
    45e1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    45e8:	0f 1f 84 00 00 00 00 
    45ef:	00 

00000000000045f0 <fwp_gc_alloc_slow>:
    45f0:	55                   	push   %rbp
    45f1:	41 57                	push   %r15
    45f3:	41 56                	push   %r14
    45f5:	41 54                	push   %r12
    45f7:	53                   	push   %rbx
    45f8:	89 f5                	mov    %esi,%ebp
    45fa:	48 89 fb             	mov    %rdi,%rbx
    45fd:	83 3d 80 1c 01 00 00 	cmpl   $0x0,0x11c80(%rip)        # 16284 <fwp_gc+0xfec>
    4604:	74 1b                	je     4621 <fwp_gc_alloc_slow+0x31>
    4606:	48 81 fb 01 40 00 00 	cmp    $0x4001,%rbx
    460d:	72 20                	jb     462f <fwp_gc_alloc_slow+0x3f>
    460f:	48 89 df             	mov    %rbx,%rdi
    4612:	89 ee                	mov    %ebp,%esi
    4614:	5b                   	pop    %rbx
    4615:	41 5c                	pop    %r12
    4617:	41 5e                	pop    %r14
    4619:	41 5f                	pop    %r15
    461b:	5d                   	pop    %rbp
    461c:	e9 9f 03 00 00       	jmp    49c0 <fwp_gc_alloc_big>
    4621:	e8 ba 00 00 00       	call   46e0 <fwp_gc_init>
    4626:	48 81 fb 01 40 00 00 	cmp    $0x4001,%rbx
    462d:	73 e0                	jae    460f <fwp_gc_alloc_slow+0x1f>
    462f:	48 8d 43 0f          	lea    0xf(%rbx),%rax
    4633:	48 c1 e8 04          	shr    $0x4,%rax
    4637:	4c 8d 25 5a 0c 01 00 	lea    0x10c5a(%rip),%r12        # 15298 <fwp_gc>
    463e:	46 0f b6 bc 20 e8 0b 	movzbl 0xbe8(%rax,%r12,1),%r15d
    4645:	00 00 
    4647:	47 8b b4 bc 48 0b 00 	mov    0xb48(%r12,%r15,4),%r14d
    464e:	00 
    464f:	48 83 3d 41 0c 01 00 	cmpq   $0x0,0x10c41(%rip)        # 15298 <fwp_gc>
    4656:	00 
    4657:	79 05                	jns    465e <fwp_gc_alloc_slow+0x6e>
    4659:	e8 b2 04 00 00       	call   4b10 <fwp_gc_spent>
    465e:	89 e8                	mov    %ebp,%eax
    4660:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    4667:	49 01 c4             	add    %rax,%r12
    466a:	4b 8d 0c 7f          	lea    (%r15,%r15,2),%rcx
    466e:	49 8d 04 cc          	lea    (%r12,%rcx,8),%rax
    4672:	48 83 c0 08          	add    $0x8,%rax
    4676:	49 8b 7c cc 08       	mov    0x8(%r12,%rcx,8),%rdi
    467b:	48 85 ff             	test   %rdi,%rdi
    467e:	74 08                	je     4688 <fwp_gc_alloc_slow+0x98>
    4680:	48 8b 0f             	mov    (%rdi),%rcx
    4683:	48 f7 d1             	not    %rcx
    4686:	eb 30                	jmp    46b8 <fwp_gc_alloc_slow+0xc8>
    4688:	49 8b 7c cc 10       	mov    0x10(%r12,%rcx,8),%rdi
    468d:	49 8b 54 cc 18       	mov    0x18(%r12,%rcx,8),%rdx
    4692:	48 29 fa             	sub    %rdi,%rdx
    4695:	4c 39 f2             	cmp    %r14,%rdx
    4698:	73 12                	jae    46ac <fwp_gc_alloc_slow+0xbc>
    469a:	48 89 c7             	mov    %rax,%rdi
    469d:	44 89 fe             	mov    %r15d,%esi
    46a0:	89 ea                	mov    %ebp,%edx
    46a2:	e8 39 05 00 00       	call   4be0 <fwp_gc_refill>
    46a7:	48 89 c7             	mov    %rax,%rdi
    46aa:	eb 0f                	jmp    46bb <fwp_gc_alloc_slow+0xcb>
    46ac:	49 8d 04 cc          	lea    (%r12,%rcx,8),%rax
    46b0:	48 83 c0 10          	add    $0x10,%rax
    46b4:	4a 8d 0c 37          	lea    (%rdi,%r14,1),%rcx
    46b8:	48 89 08             	mov    %rcx,(%rax)
    46bb:	83 fd 01             	cmp    $0x1,%ebp
    46be:	4c 0f 44 f3          	cmove  %rbx,%r14
    46c2:	31 f6                	xor    %esi,%esi
    46c4:	4c 89 f2             	mov    %r14,%rdx
    46c7:	5b                   	pop    %rbx
    46c8:	41 5c                	pop    %r12
    46ca:	41 5e                	pop    %r14
    46cc:	41 5f                	pop    %r15
    46ce:	5d                   	pop    %rbp
    46cf:	e9 3c eb ff ff       	jmp    3210 <memset@plt>
    46d4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    46db:	00 00 00 00 00 

00000000000046e0 <fwp_gc_init>:
    46e0:	53                   	push   %rbx
    46e1:	48 83 ec 10          	sub    $0x10,%rsp
    46e5:	c7 05 95 1b 01 00 01 	movl   $0x1,0x11b95(%rip)        # 16284 <fwp_gc+0xfec>
    46ec:	00 00 00 
    46ef:	0f 28 05 1a a9 00 00 	movaps 0xa91a(%rip),%xmm0        # f010 <_IO_stdin_used+0x10>
    46f6:	0f 11 05 e3 16 01 00 	movups %xmm0,0x116e3(%rip)        # 15de0 <fwp_gc+0xb48>
    46fd:	0f 28 05 1c a9 00 00 	movaps 0xa91c(%rip),%xmm0        # f020 <_IO_stdin_used+0x20>
    4704:	0f 11 05 e5 16 01 00 	movups %xmm0,0x116e5(%rip)        # 15df0 <fwp_gc+0xb58>
    470b:	0f 28 05 1e a9 00 00 	movaps 0xa91e(%rip),%xmm0        # f030 <_IO_stdin_used+0x30>
    4712:	0f 11 05 e7 16 01 00 	movups %xmm0,0x116e7(%rip)        # 15e00 <fwp_gc+0xb68>
    4719:	0f 28 05 20 a9 00 00 	movaps 0xa920(%rip),%xmm0        # f040 <_IO_stdin_used+0x40>
    4720:	0f 11 05 e9 16 01 00 	movups %xmm0,0x116e9(%rip)        # 15e10 <fwp_gc+0xb78>
    4727:	0f 28 05 22 a9 00 00 	movaps 0xa922(%rip),%xmm0        # f050 <_IO_stdin_used+0x50>
    472e:	0f 11 05 eb 16 01 00 	movups %xmm0,0x116eb(%rip)        # 15e20 <fwp_gc+0xb88>
    4735:	0f 28 05 24 a9 00 00 	movaps 0xa924(%rip),%xmm0        # f060 <_IO_stdin_used+0x60>
    473c:	0f 11 05 ed 16 01 00 	movups %xmm0,0x116ed(%rip)        # 15e30 <fwp_gc+0xb98>
    4743:	0f 28 05 26 a9 00 00 	movaps 0xa926(%rip),%xmm0        # f070 <_IO_stdin_used+0x70>
    474a:	0f 11 05 ef 16 01 00 	movups %xmm0,0x116ef(%rip)        # 15e40 <fwp_gc+0xba8>
    4751:	0f 28 05 28 a9 00 00 	movaps 0xa928(%rip),%xmm0        # f080 <_IO_stdin_used+0x80>
    4758:	0f 11 05 f1 16 01 00 	movups %xmm0,0x116f1(%rip)        # 15e50 <fwp_gc+0xbb8>
    475f:	0f 28 05 2a a9 00 00 	movaps 0xa92a(%rip),%xmm0        # f090 <_IO_stdin_used+0x90>
    4766:	0f 11 05 f3 16 01 00 	movups %xmm0,0x116f3(%rip)        # 15e60 <fwp_gc+0xbc8>
    476d:	0f 28 05 2c a9 00 00 	movaps 0xa92c(%rip),%xmm0        # f0a0 <_IO_stdin_used+0xa0>
    4774:	0f 11 05 f5 16 01 00 	movups %xmm0,0x116f5(%rip)        # 15e70 <fwp_gc+0xbd8>
    477b:	31 c9                	xor    %ecx,%ecx
    477d:	48 8d 05 14 0b 01 00 	lea    0x10b14(%rip),%rax        # 15298 <fwp_gc>
    4784:	31 d2                	xor    %edx,%edx
    4786:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    478d:	00 00 00 
    4790:	89 d6                	mov    %edx,%esi
    4792:	c1 e6 04             	shl    $0x4,%esi
    4795:	48 ff c9             	dec    %rcx
    4798:	48 89 cf             	mov    %rcx,%rdi
    479b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    47a0:	48 89 f9             	mov    %rdi,%rcx
    47a3:	48 ff c7             	inc    %rdi
    47a6:	3b b4 88 4c 0b 00 00 	cmp    0xb4c(%rax,%rcx,4),%esi
    47ad:	77 f1                	ja     47a0 <fwp_gc_init+0xc0>
    47af:	40 88 bc 02 e8 0b 00 	mov    %dil,0xbe8(%rdx,%rax,1)
    47b6:	00 
    47b7:	48 89 d6             	mov    %rdx,%rsi
    47ba:	48 83 ce 01          	or     $0x1,%rsi
    47be:	48 81 fe 01 04 00 00 	cmp    $0x401,%rsi
    47c5:	74 26                	je     47ed <fwp_gc_init+0x10d>
    47c7:	89 f7                	mov    %esi,%edi
    47c9:	c1 e7 04             	shl    $0x4,%edi
    47cc:	0f 1f 40 00          	nopl   0x0(%rax)
    47d0:	49 89 c8             	mov    %rcx,%r8
    47d3:	48 ff c1             	inc    %rcx
    47d6:	42 3b bc 80 4c 0b 00 	cmp    0xb4c(%rax,%r8,4),%edi
    47dd:	00 
    47de:	77 f0                	ja     47d0 <fwp_gc_init+0xf0>
    47e0:	88 8c 06 e8 0b 00 00 	mov    %cl,0xbe8(%rsi,%rax,1)
    47e7:	48 83 c2 02          	add    $0x2,%rdx
    47eb:	eb a3                	jmp    4790 <fwp_gc_init+0xb0>
    47ed:	48 b8 00 00 00 00 10 	movabs $0x1000000000,%rax
    47f4:	00 00 00 
    47f7:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    47fc:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    4801:	e8 ba 04 00 00       	call   4cc0 <fwp_gc_reserve>
    4806:	48 85 c0             	test   %rax,%rax
    4809:	0f 84 ab 01 00 00    	je     49ba <fwp_gc_init+0x2da>
    480f:	48 89 05 ba 1a 01 00 	mov    %rax,0x11aba(%rip)        # 162d0 <fwp_gc+0x1038>
    4816:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    481b:	48 8d 91 00 00 01 00 	lea    0x10000(%rcx),%rdx
    4822:	48 89 15 af 1a 01 00 	mov    %rdx,0x11aaf(%rip)        # 162d8 <fwp_gc+0x1040>
    4829:	48 05 ff ff 00 00    	add    $0xffff,%rax
    482f:	48 25 00 00 ff ff    	and    $0xffffffffffff0000,%rax
    4835:	48 89 05 8c 1a 01 00 	mov    %rax,0x11a8c(%rip)        # 162c8 <fwp_gc+0x1030>
    483c:	48 c1 e9 10          	shr    $0x10,%rcx
    4840:	48 89 0d a1 1a 01 00 	mov    %rcx,0x11aa1(%rip)        # 162e8 <fwp_gc+0x1050>
    4847:	48 69 f1 28 12 00 00 	imul   $0x1228,%rcx,%rsi
    484e:	48 89 35 c3 1a 01 00 	mov    %rsi,0x11ac3(%rip)        # 16318 <fwp_gc+0x1080>
    4855:	31 ff                	xor    %edi,%edi
    4857:	31 d2                	xor    %edx,%edx
    4859:	b9 22 40 00 00       	mov    $0x4022,%ecx
    485e:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    4864:	45 31 c9             	xor    %r9d,%r9d
    4867:	e8 24 e9 ff ff       	call   3190 <mmap@plt>
    486c:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    4870:	0f 84 44 01 00 00    	je     49ba <fwp_gc_init+0x2da>
    4876:	48 89 05 93 1a 01 00 	mov    %rax,0x11a93(%rip)        # 16310 <fwp_gc+0x1078>
    487d:	48 8d 3d 24 b0 00 00 	lea    0xb024(%rip),%rdi        # f8a8 <exec_in_fp0+0x1a8>
    4884:	e8 a7 e7 ff ff       	call   3030 <getenv@plt>
    4889:	48 85 c0             	test   %rax,%rax
    488c:	74 2e                	je     48bc <fwp_gc_init+0x1dc>
    488e:	48 89 c3             	mov    %rax,%rbx
    4891:	48 8d 35 17 b0 00 00 	lea    0xb017(%rip),%rsi        # f8af <exec_in_fp0+0x1af>
    4898:	48 89 c7             	mov    %rax,%rdi
    489b:	e8 30 ea ff ff       	call   32d0 <strcmp@plt>
    48a0:	85 c0                	test   %eax,%eax
    48a2:	74 1f                	je     48c3 <fwp_gc_init+0x1e3>
    48a4:	48 8d 35 00 bc 00 00 	lea    0xbc00(%rip),%rsi        # 104ab <exec_in_fp0+0xdab>
    48ab:	48 89 df             	mov    %rbx,%rdi
    48ae:	e8 1d ea ff ff       	call   32d0 <strcmp@plt>
    48b3:	31 c9                	xor    %ecx,%ecx
    48b5:	85 c0                	test   %eax,%eax
    48b7:	0f 95 c1             	setne  %cl
    48ba:	eb 09                	jmp    48c5 <fwp_gc_init+0x1e5>
    48bc:	b9 01 00 00 00       	mov    $0x1,%ecx
    48c1:	eb 02                	jmp    48c5 <fwp_gc_init+0x1e5>
    48c3:	31 c9                	xor    %ecx,%ecx
    48c5:	89 0d bd 19 01 00    	mov    %ecx,0x119bd(%rip)        # 16288 <fwp_gc+0xff0>
    48cb:	48 8d 3d e1 af 00 00 	lea    0xafe1(%rip),%rdi        # f8b3 <exec_in_fp0+0x1b3>
    48d2:	e8 59 e7 ff ff       	call   3030 <getenv@plt>
    48d7:	31 c9                	xor    %ecx,%ecx
    48d9:	48 85 c0             	test   %rax,%rax
    48dc:	74 1b                	je     48f9 <fwp_gc_init+0x219>
    48de:	80 38 00             	cmpb   $0x0,(%rax)
    48e1:	74 16                	je     48f9 <fwp_gc_init+0x219>
    48e3:	48 8d 35 c1 bb 00 00 	lea    0xbbc1(%rip),%rsi        # 104ab <exec_in_fp0+0xdab>
    48ea:	48 89 c7             	mov    %rax,%rdi
    48ed:	e8 de e9 ff ff       	call   32d0 <strcmp@plt>
    48f2:	31 c9                	xor    %ecx,%ecx
    48f4:	85 c0                	test   %eax,%eax
    48f6:	0f 95 c1             	setne  %cl
    48f9:	89 0d 95 19 01 00    	mov    %ecx,0x11995(%rip)        # 16294 <fwp_gc+0xffc>
    48ff:	48 8d 3d a2 af 00 00 	lea    0xafa2(%rip),%rdi        # f8a8 <exec_in_fp0+0x1a8>
    4906:	e8 25 e7 ff ff       	call   3030 <getenv@plt>
    490b:	48 85 c0             	test   %rax,%rax
    490e:	74 18                	je     4928 <fwp_gc_init+0x248>
    4910:	48 8d 35 a9 af 00 00 	lea    0xafa9(%rip),%rsi        # f8c0 <exec_in_fp0+0x1c0>
    4917:	48 89 c7             	mov    %rax,%rdi
    491a:	e8 b1 e9 ff ff       	call   32d0 <strcmp@plt>
    491f:	31 c9                	xor    %ecx,%ecx
    4921:	85 c0                	test   %eax,%eax
    4923:	0f 95 c1             	setne  %cl
    4926:	eb 05                	jmp    492d <fwp_gc_init+0x24d>
    4928:	b9 01 00 00 00       	mov    $0x1,%ecx
    492d:	89 0d 65 19 01 00    	mov    %ecx,0x11965(%rip)        # 16298 <fwp_gc+0x1000>
    4933:	c7 05 63 19 01 00 01 	movl   $0x1,0x11963(%rip)        # 162a0 <fwp_gc+0x1008>
    493a:	00 00 00 
    493d:	48 8d 3d 81 af 00 00 	lea    0xaf81(%rip),%rdi        # f8c5 <exec_in_fp0+0x1c5>
    4944:	e8 e7 e6 ff ff       	call   3030 <getenv@plt>
    4949:	31 c9                	xor    %ecx,%ecx
    494b:	48 85 c0             	test   %rax,%rax
    494e:	74 1b                	je     496b <fwp_gc_init+0x28b>
    4950:	80 38 00             	cmpb   $0x0,(%rax)
    4953:	74 16                	je     496b <fwp_gc_init+0x28b>
    4955:	48 8d 35 4f bb 00 00 	lea    0xbb4f(%rip),%rsi        # 104ab <exec_in_fp0+0xdab>
    495c:	48 89 c7             	mov    %rax,%rdi
    495f:	e8 6c e9 ff ff       	call   32d0 <strcmp@plt>
    4964:	31 c9                	xor    %ecx,%ecx
    4966:	85 c0                	test   %eax,%eax
    4968:	0f 95 c1             	setne  %cl
    496b:	89 0d 2b 19 01 00    	mov    %ecx,0x1192b(%rip)        # 1629c <fwp_gc+0x1004>
    4971:	48 8d 3d 5b af 00 00 	lea    0xaf5b(%rip),%rdi        # f8d3 <exec_in_fp0+0x1d3>
    4978:	e8 b3 e6 ff ff       	call   3030 <getenv@plt>
    497d:	48 85 c0             	test   %rax,%rax
    4980:	74 0a                	je     498c <fwp_gc_init+0x2ac>
    4982:	48 89 c7             	mov    %rax,%rdi
    4985:	e8 76 ea ff ff       	call   3400 <atol@plt>
    498a:	eb 02                	jmp    498e <fwp_gc_init+0x2ae>
    498c:	31 c0                	xor    %eax,%eax
    498e:	31 c9                	xor    %ecx,%ecx
    4990:	48 85 c0             	test   %rax,%rax
    4993:	48 0f 4f c8          	cmovg  %rax,%rcx
    4997:	48 89 0d 1a 19 01 00 	mov    %rcx,0x1191a(%rip)        # 162b8 <fwp_gc+0x1020>
    499e:	48 c7 05 ff 1a 01 00 	movq   $0x800000,0x11aff(%rip)        # 164a8 <fwp_gc+0x1210>
    49a5:	00 00 80 00 
    49a9:	48 c7 05 e4 08 01 00 	movq   $0x800000,0x108e4(%rip)        # 15298 <fwp_gc>
    49b0:	00 00 80 00 
    49b4:	48 83 c4 10          	add    $0x10,%rsp
    49b8:	5b                   	pop    %rbx
    49b9:	c3                   	ret
    49ba:	e8 71 03 00 00       	call   4d30 <fwp_gc_oom>
    49bf:	90                   	nop

00000000000049c0 <fwp_gc_alloc_big>:
    49c0:	55                   	push   %rbp
    49c1:	41 57                	push   %r15
    49c3:	41 56                	push   %r14
    49c5:	41 54                	push   %r12
    49c7:	53                   	push   %rbx
    49c8:	48 b8 01 00 00 00 00 	movabs $0x4000000000000001,%rax
    49cf:	00 00 40 
    49d2:	48 39 c7             	cmp    %rax,%rdi
    49d5:	0f 83 28 01 00 00    	jae    4b03 <fwp_gc_alloc_big+0x143>
    49db:	89 f5                	mov    %esi,%ebp
    49dd:	48 89 fb             	mov    %rdi,%rbx
    49e0:	48 29 3d b1 08 01 00 	sub    %rdi,0x108b1(%rip)        # 15298 <fwp_gc>
    49e7:	79 05                	jns    49ee <fwp_gc_alloc_big+0x2e>
    49e9:	e8 22 01 00 00       	call   4b10 <fwp_gc_spent>
    49ee:	4c 8d bb ff ff 00 00 	lea    0xffff(%rbx),%r15
    49f5:	49 c1 ef 10          	shr    $0x10,%r15
    49f9:	4c 89 ff             	mov    %r15,%rdi
    49fc:	e8 5f 03 00 00       	call   4d60 <fwp_gc_chunks>
    4a01:	49 89 c6             	mov    %rax,%r14
    4a04:	48 8b 05 05 19 01 00 	mov    0x11905(%rip),%rax        # 16310 <fwp_gc+0x1078>
    4a0b:	4d 69 e6 28 12 00 00 	imul   $0x1228,%r14,%r12
    4a12:	42 c6 04 20 02       	movb   $0x2,(%rax,%r12,1)
    4a17:	42 88 6c 20 01       	mov    %bpl,0x1(%rax,%r12,1)
    4a1c:	66 42 c7 44 20 03 00 	movw   $0x100,0x3(%rax,%r12,1)
    4a23:	01 
    4a24:	46 89 7c 20 10       	mov    %r15d,0x10(%rax,%r12,1)
    4a29:	4a 89 5c 20 18       	mov    %rbx,0x18(%rax,%r12,1)
    4a2e:	4a 8d 3c 20          	lea    (%rax,%r12,1),%rdi
    4a32:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    4a39:	e8 72 f7 ff ff       	call   41b0 <fwp_rc_clear_slot>
    4a3e:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    4a45:	0f 82 9b 00 00 00    	jb     4ae6 <fwp_gc_alloc_big+0x126>
    4a4b:	49 83 ff 03          	cmp    $0x3,%r15
    4a4f:	b9 02 00 00 00       	mov    $0x2,%ecx
    4a54:	49 0f 43 cf          	cmovae %r15,%rcx
    4a58:	48 8b 05 b1 18 01 00 	mov    0x118b1(%rip),%rax        # 16310 <fwp_gc+0x1078>
    4a5f:	48 ff c9             	dec    %rcx
    4a62:	ba 01 00 00 00       	mov    $0x1,%edx
    4a67:	48 81 fb 01 00 02 00 	cmp    $0x20001,%rbx
    4a6e:	72 59                	jb     4ac9 <fwp_gc_alloc_big+0x109>
    4a70:	49 8d 34 04          	lea    (%r12,%rax,1),%rsi
    4a74:	48 81 c6 60 24 00 00 	add    $0x2460,%rsi
    4a7b:	48 89 cf             	mov    %rcx,%rdi
    4a7e:	48 83 e7 fe          	and    $0xfffffffffffffffe,%rdi
    4a82:	48 f7 df             	neg    %rdi
    4a85:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    4a8c:	00 00 00 00 
    4a90:	c6 86 c8 ed ff ff 03 	movb   $0x3,-0x1238(%rsi)
    4a97:	c6 86 cc ed ff ff 01 	movb   $0x1,-0x1234(%rsi)
    4a9e:	44 89 b6 d8 ed ff ff 	mov    %r14d,-0x1228(%rsi)
    4aa5:	c6 46 f0 03          	movb   $0x3,-0x10(%rsi)
    4aa9:	c6 46 f4 01          	movb   $0x1,-0xc(%rsi)
    4aad:	44 89 36             	mov    %r14d,(%rsi)
    4ab0:	48 81 c6 50 24 00 00 	add    $0x2450,%rsi
    4ab7:	4c 8d 04 17          	lea    (%rdi,%rdx,1),%r8
    4abb:	49 83 c0 02          	add    $0x2,%r8
    4abf:	48 83 c2 02          	add    $0x2,%rdx
    4ac3:	49 83 f8 01          	cmp    $0x1,%r8
    4ac7:	75 c7                	jne    4a90 <fwp_gc_alloc_big+0xd0>
    4ac9:	f6 c1 01             	test   $0x1,%cl
    4acc:	74 18                	je     4ae6 <fwp_gc_alloc_big+0x126>
    4ace:	4c 01 e0             	add    %r12,%rax
    4ad1:	48 69 ca 28 12 00 00 	imul   $0x1228,%rdx,%rcx
    4ad8:	c6 04 08 03          	movb   $0x3,(%rax,%rcx,1)
    4adc:	c6 44 08 04 01       	movb   $0x1,0x4(%rax,%rcx,1)
    4ae1:	44 89 74 08 10       	mov    %r14d,0x10(%rax,%rcx,1)
    4ae6:	4c 89 f7             	mov    %r14,%rdi
    4ae9:	e8 e2 f6 ff ff       	call   41d0 <fwp_gc_chunk_addr>
    4aee:	48 89 c7             	mov    %rax,%rdi
    4af1:	31 f6                	xor    %esi,%esi
    4af3:	48 89 da             	mov    %rbx,%rdx
    4af6:	5b                   	pop    %rbx
    4af7:	41 5c                	pop    %r12
    4af9:	41 5e                	pop    %r14
    4afb:	41 5f                	pop    %r15
    4afd:	5d                   	pop    %rbp
    4afe:	e9 0d e7 ff ff       	jmp    3210 <memset@plt>
    4b03:	e8 28 02 00 00       	call   4d30 <fwp_gc_oom>
    4b08:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    4b0f:	00 

0000000000004b10 <fwp_gc_spent>:
    4b10:	50                   	push   %rax
    4b11:	83 3d 6c 17 01 00 00 	cmpl   $0x0,0x1176c(%rip)        # 16284 <fwp_gc+0xfec>
    4b18:	75 05                	jne    4b1f <fwp_gc_spent+0xf>
    4b1a:	e8 c1 fb ff ff       	call   46e0 <fwp_gc_init>
    4b1f:	8b 05 67 17 01 00    	mov    0x11767(%rip),%eax        # 1628c <fwp_gc+0xff4>
    4b25:	85 c0                	test   %eax,%eax
    4b27:	74 6d                	je     4b96 <fwp_gc_spent+0x86>
    4b29:	48 8b 0d 88 17 01 00 	mov    0x11788(%rip),%rcx        # 162b8 <fwp_gc+0x1020>
    4b30:	48 85 c9             	test   %rcx,%rcx
    4b33:	74 61                	je     4b96 <fwp_gc_spent+0x86>
    4b35:	48 8b 05 84 17 01 00 	mov    0x11784(%rip),%rax        # 162c0 <fwp_gc+0x1028>
    4b3c:	48 ff c0             	inc    %rax
    4b3f:	48 89 05 7a 17 01 00 	mov    %rax,0x1177a(%rip)        # 162c0 <fwp_gc+0x1028>
    4b46:	48 39 c8             	cmp    %rcx,%rax
    4b49:	7c 10                	jl     4b5b <fwp_gc_spent+0x4b>
    4b4b:	48 c7 05 6a 17 01 00 	movq   $0x0,0x1176a(%rip)        # 162c0 <fwp_gc+0x1028>
    4b52:	00 00 00 00 
    4b56:	e8 85 03 00 00       	call   4ee0 <fwp_gc_collect>
    4b5b:	48 8b 05 46 19 01 00 	mov    0x11946(%rip),%rax        # 164a8 <fwp_gc+0x1210>
    4b62:	48 2b 05 2f 07 01 00 	sub    0x1072f(%rip),%rax        # 15298 <fwp_gc>
    4b69:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    4b6e:	f2 0f 58 05 0a 19 01 	addsd  0x1190a(%rip),%xmm0        # 16480 <fwp_gc+0x11e8>
    4b75:	00 
    4b76:	f2 0f 11 05 02 19 01 	movsd  %xmm0,0x11902(%rip)        # 16480 <fwp_gc+0x11e8>
    4b7d:	00 
    4b7e:	48 c7 05 1f 19 01 00 	movq   $0x0,0x1191f(%rip)        # 164a8 <fwp_gc+0x1210>
    4b85:	00 00 00 00 
    4b89:	48 c7 05 04 07 01 00 	movq   $0x0,0x10704(%rip)        # 15298 <fwp_gc>
    4b90:	00 00 00 00 
    4b94:	58                   	pop    %rax
    4b95:	c3                   	ret
    4b96:	85 c0                	test   %eax,%eax
    4b98:	74 06                	je     4ba0 <fwp_gc_spent+0x90>
    4b9a:	58                   	pop    %rax
    4b9b:	e9 40 03 00 00       	jmp    4ee0 <fwp_gc_collect>
    4ba0:	48 8b 05 01 19 01 00 	mov    0x11901(%rip),%rax        # 164a8 <fwp_gc+0x1210>
    4ba7:	48 2b 05 ea 06 01 00 	sub    0x106ea(%rip),%rax        # 15298 <fwp_gc>
    4bae:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    4bb3:	f2 0f 58 05 c5 18 01 	addsd  0x118c5(%rip),%xmm0        # 16480 <fwp_gc+0x11e8>
    4bba:	00 
    4bbb:	f2 0f 11 05 bd 18 01 	movsd  %xmm0,0x118bd(%rip)        # 16480 <fwp_gc+0x11e8>
    4bc2:	00 
    4bc3:	48 c7 05 da 18 01 00 	movq   $0x800000,0x118da(%rip)        # 164a8 <fwp_gc+0x1210>
    4bca:	00 00 80 00 
    4bce:	48 c7 05 bf 06 01 00 	movq   $0x800000,0x106bf(%rip)        # 15298 <fwp_gc>
    4bd5:	00 00 80 00 
    4bd9:	58                   	pop    %rax
    4bda:	c3                   	ret
    4bdb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000004be0 <fwp_gc_refill>:
    4be0:	55                   	push   %rbp
    4be1:	41 57                	push   %r15
    4be3:	41 56                	push   %r14
    4be5:	53                   	push   %rbx
    4be6:	50                   	push   %rax
    4be7:	89 d5                	mov    %edx,%ebp
    4be9:	41 89 f7             	mov    %esi,%r15d
    4bec:	48 89 fb             	mov    %rdi,%rbx
    4bef:	bf 01 00 00 00       	mov    $0x1,%edi
    4bf4:	e8 67 01 00 00       	call   4d60 <fwp_gc_chunks>
    4bf9:	49 89 c6             	mov    %rax,%r14
    4bfc:	48 8b 0d 0d 17 01 00 	mov    0x1170d(%rip),%rcx        # 16310 <fwp_gc+0x1078>
    4c03:	48 8d 05 8e 06 01 00 	lea    0x1068e(%rip),%rax        # 15298 <fwp_gc>
    4c0a:	49 69 f6 28 12 00 00 	imul   $0x1228,%r14,%rsi
    4c11:	48 8d 3c 31          	lea    (%rcx,%rsi,1),%rdi
    4c15:	c6 04 31 01          	movb   $0x1,(%rcx,%rsi,1)
    4c19:	40 88 6c 31 01       	mov    %bpl,0x1(%rcx,%rsi,1)
    4c1e:	44 88 7c 31 02       	mov    %r15b,0x2(%rcx,%rsi,1)
    4c23:	c6 44 31 04 01       	movb   $0x1,0x4(%rcx,%rsi,1)
    4c28:	44 89 fa             	mov    %r15d,%edx
    4c2b:	44 8b 84 90 48 0b 00 	mov    0xb48(%rax,%rdx,4),%r8d
    4c32:	00 
    4c33:	44 89 44 31 08       	mov    %r8d,0x8(%rcx,%rsi,1)
    4c38:	b8 00 00 01 00       	mov    $0x10000,%eax
    4c3d:	31 d2                	xor    %edx,%edx
    4c3f:	41 f7 f0             	div    %r8d
    4c42:	89 44 31 0c          	mov    %eax,0xc(%rcx,%rsi,1)
    4c46:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    4c4b:	4c 01 c0             	add    %r8,%rax
    4c4e:	48 0f ba e0 20       	bt     $0x20,%rax
    4c53:	73 07                	jae    4c5c <fwp_gc_refill+0x7c>
    4c55:	31 d2                	xor    %edx,%edx
    4c57:	49 f7 f0             	div    %r8
    4c5a:	eb 05                	jmp    4c61 <fwp_gc_refill+0x81>
    4c5c:	31 d2                	xor    %edx,%edx
    4c5e:	41 f7 f0             	div    %r8d
    4c61:	4c 8d 3c 31          	lea    (%rcx,%rsi,1),%r15
    4c65:	49 83 c7 08          	add    $0x8,%r15
    4c69:	89 44 31 20          	mov    %eax,0x20(%rcx,%rsi,1)
    4c6d:	e8 4e 15 00 00       	call   61c0 <fwp_rc_clear_chunk>
    4c72:	4c 89 f7             	mov    %r14,%rdi
    4c75:	e8 56 f5 ff ff       	call   41d0 <fwp_gc_chunk_addr>
    4c7a:	83 3d 1b 16 01 00 00 	cmpl   $0x0,0x1161b(%rip)        # 1629c <fwp_gc+0x1004>
    4c81:	74 15                	je     4c98 <fwp_gc_refill+0xb8>
    4c83:	ba 00 00 01 00       	mov    $0x10000,%edx
    4c88:	48 89 c7             	mov    %rax,%rdi
    4c8b:	31 f6                	xor    %esi,%esi
    4c8d:	49 89 c6             	mov    %rax,%r14
    4c90:	e8 7b e5 ff ff       	call   3210 <memset@plt>
    4c95:	4c 89 f0             	mov    %r14,%rax
    4c98:	41 8b 0f             	mov    (%r15),%ecx
    4c9b:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    4c9f:	48 89 53 08          	mov    %rdx,0x8(%rbx)
    4ca3:	41 8b 57 04          	mov    0x4(%r15),%edx
    4ca7:	48 0f af d1          	imul   %rcx,%rdx
    4cab:	48 01 c2             	add    %rax,%rdx
    4cae:	48 89 53 10          	mov    %rdx,0x10(%rbx)
    4cb2:	48 83 c4 08          	add    $0x8,%rsp
    4cb6:	5b                   	pop    %rbx
    4cb7:	41 5e                	pop    %r14
    4cb9:	41 5f                	pop    %r15
    4cbb:	5d                   	pop    %rbp
    4cbc:	c3                   	ret
    4cbd:	0f 1f 00             	nopl   (%rax)

0000000000004cc0 <fwp_gc_reserve>:
    4cc0:	41 56                	push   %r14
    4cc2:	53                   	push   %rbx
    4cc3:	50                   	push   %rax
    4cc4:	4c 8b 37             	mov    (%rdi),%r14
    4cc7:	49 81 fe 00 00 00 10 	cmp    $0x10000000,%r14
    4cce:	72 47                	jb     4d17 <fwp_gc_reserve+0x57>
    4cd0:	48 89 fb             	mov    %rdi,%rbx
    4cd3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4cda:	84 00 00 00 00 00 
    4ce0:	49 8d b6 00 00 01 00 	lea    0x10000(%r14),%rsi
    4ce7:	31 ff                	xor    %edi,%edi
    4ce9:	31 d2                	xor    %edx,%edx
    4ceb:	b9 22 40 00 00       	mov    $0x4022,%ecx
    4cf0:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    4cf6:	45 31 c9             	xor    %r9d,%r9d
    4cf9:	e8 92 e4 ff ff       	call   3190 <mmap@plt>
    4cfe:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    4d02:	75 17                	jne    4d1b <fwp_gc_reserve+0x5b>
    4d04:	4c 89 f0             	mov    %r14,%rax
    4d07:	48 c1 e8 02          	shr    $0x2,%rax
    4d0b:	49 81 fe ff ff ff 3f 	cmp    $0x3fffffff,%r14
    4d12:	49 89 c6             	mov    %rax,%r14
    4d15:	77 c9                	ja     4ce0 <fwp_gc_reserve+0x20>
    4d17:	31 c0                	xor    %eax,%eax
    4d19:	eb 03                	jmp    4d1e <fwp_gc_reserve+0x5e>
    4d1b:	4c 89 33             	mov    %r14,(%rbx)
    4d1e:	48 83 c4 08          	add    $0x8,%rsp
    4d22:	5b                   	pop    %rbx
    4d23:	41 5e                	pop    %r14
    4d25:	c3                   	ret
    4d26:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    4d2d:	00 00 00 

0000000000004d30 <fwp_gc_oom>:
    4d30:	50                   	push   %rax
    4d31:	48 8b 05 a0 02 01 00 	mov    0x102a0(%rip),%rax        # 14fd8 <stderr@GLIBC_2.2.5>
    4d38:	48 8b 08             	mov    (%rax),%rcx
    4d3b:	48 8d 3d 9f ab 00 00 	lea    0xab9f(%rip),%rdi        # f8e1 <exec_in_fp0+0x1e1>
    4d42:	be 13 00 00 00       	mov    $0x13,%esi
    4d47:	ba 01 00 00 00       	mov    $0x1,%edx
    4d4c:	e8 4f e7 ff ff       	call   34a0 <fwrite@plt>
    4d51:	bf 66 00 00 00       	mov    $0x66,%edi
    4d56:	e8 25 e7 ff ff       	call   3480 <exit@plt>
    4d5b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000004d60 <fwp_gc_chunks>:
    4d60:	41 56                	push   %r14
    4d62:	53                   	push   %rbx
    4d63:	50                   	push   %rax
    4d64:	48 89 fb             	mov    %rdi,%rbx
    4d67:	31 d2                	xor    %edx,%edx
    4d69:	48 83 ff 01          	cmp    $0x1,%rdi
    4d6d:	0f 95 c2             	setne  %dl
    4d70:	48 8d 0d 21 05 01 00 	lea    0x10521(%rip),%rcx        # 15298 <fwp_gc>
    4d77:	48 8b 84 d1 68 10 00 	mov    0x1068(%rcx,%rdx,8),%rax
    4d7e:	00 
    4d7f:	4c 8b 35 6a 15 01 00 	mov    0x1156a(%rip),%r14        # 162f0 <fwp_gc+0x1058>
    4d86:	48 89 c7             	mov    %rax,%rdi
    4d89:	4c 29 f7             	sub    %r14,%rdi
    4d8c:	73 61                	jae    4def <fwp_gc_chunks+0x8f>
    4d8e:	48 8d 34 d5 68 10 00 	lea    0x1068(,%rdx,8),%rsi
    4d95:	00 
    4d96:	4c 69 c0 28 12 00 00 	imul   $0x1228,%rax,%r8
    4d9d:	4c 03 05 6c 15 01 00 	add    0x1156c(%rip),%r8        # 16310 <fwp_gc+0x1078>
    4da4:	31 d2                	xor    %edx,%edx
    4da6:	45 31 c9             	xor    %r9d,%r9d
    4da9:	eb 17                	jmp    4dc2 <fwp_gc_chunks+0x62>
    4dab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    4db0:	45 31 c9             	xor    %r9d,%r9d
    4db3:	48 ff ca             	dec    %rdx
    4db6:	49 81 c0 28 12 00 00 	add    $0x1228,%r8
    4dbd:	48 39 d7             	cmp    %rdx,%rdi
    4dc0:	74 30                	je     4df2 <fwp_gc_chunks+0x92>
    4dc2:	41 80 38 00          	cmpb   $0x0,(%r8)
    4dc6:	75 e8                	jne    4db0 <fwp_gc_chunks+0x50>
    4dc8:	49 ff c1             	inc    %r9
    4dcb:	49 39 d9             	cmp    %rbx,%r9
    4dce:	75 e3                	jne    4db3 <fwp_gc_chunks+0x53>
    4dd0:	48 ff c0             	inc    %rax
    4dd3:	48 89 c7             	mov    %rax,%rdi
    4dd6:	48 29 d7             	sub    %rdx,%rdi
    4dd9:	48 89 3c 0e          	mov    %rdi,(%rsi,%rcx,1)
    4ddd:	48 29 1d 94 16 01 00 	sub    %rbx,0x11694(%rip)        # 16478 <fwp_gc+0x11e0>
    4de4:	48 29 d8             	sub    %rbx,%rax
    4de7:	48 29 d0             	sub    %rdx,%rax
    4dea:	49 89 c6             	mov    %rax,%r14
    4ded:	eb 33                	jmp    4e22 <fwp_gc_chunks+0xc2>
    4def:	45 31 c9             	xor    %r9d,%r9d
    4df2:	4d 29 ce             	sub    %r9,%r14
    4df5:	4c 29 0d 7c 16 01 00 	sub    %r9,0x1167c(%rip)        # 16478 <fwp_gc+0x11e0>
    4dfc:	4c 01 f3             	add    %r14,%rbx
    4dff:	48 89 df             	mov    %rbx,%rdi
    4e02:	e8 29 00 00 00       	call   4e30 <fwp_gc_commit>
    4e07:	48 89 1d e2 14 01 00 	mov    %rbx,0x114e2(%rip)        # 162f0 <fwp_gc+0x1058>
    4e0e:	48 c1 e3 10          	shl    $0x10,%rbx
    4e12:	48 3b 1d c7 14 01 00 	cmp    0x114c7(%rip),%rbx        # 162e0 <fwp_gc+0x1048>
    4e19:	76 07                	jbe    4e22 <fwp_gc_chunks+0xc2>
    4e1b:	48 89 1d be 14 01 00 	mov    %rbx,0x114be(%rip)        # 162e0 <fwp_gc+0x1048>
    4e22:	4c 89 f0             	mov    %r14,%rax
    4e25:	48 83 c4 08          	add    $0x8,%rsp
    4e29:	5b                   	pop    %rbx
    4e2a:	41 5e                	pop    %r14
    4e2c:	c3                   	ret
    4e2d:	0f 1f 00             	nopl   (%rax)

0000000000004e30 <fwp_gc_commit>:
    4e30:	53                   	push   %rbx
    4e31:	48 89 fb             	mov    %rdi,%rbx
    4e34:	48 8b 3d bd 14 01 00 	mov    0x114bd(%rip),%rdi        # 162f8 <fwp_gc+0x1060>
    4e3b:	48 39 df             	cmp    %rbx,%rdi
    4e3e:	0f 83 8f 00 00 00    	jae    4ed3 <fwp_gc_commit+0xa3>
    4e44:	48 8b 05 9d 14 01 00 	mov    0x1149d(%rip),%rax        # 162e8 <fwp_gc+0x1050>
    4e4b:	48 39 d8             	cmp    %rbx,%rax
    4e4e:	0f 82 81 00 00 00    	jb     4ed5 <fwp_gc_commit+0xa5>
    4e54:	48 83 c3 40          	add    $0x40,%rbx
    4e58:	48 39 c3             	cmp    %rax,%rbx
    4e5b:	48 0f 43 d8          	cmovae %rax,%rbx
    4e5f:	48 89 de             	mov    %rbx,%rsi
    4e62:	48 29 fe             	sub    %rdi,%rsi
    4e65:	48 c1 e7 10          	shl    $0x10,%rdi
    4e69:	48 03 3d 58 14 01 00 	add    0x11458(%rip),%rdi        # 162c8 <fwp_gc+0x1030>
    4e70:	48 c1 e6 10          	shl    $0x10,%rsi
    4e74:	ba 03 00 00 00       	mov    $0x3,%edx
    4e79:	e8 92 e5 ff ff       	call   3410 <mprotect@plt>
    4e7e:	85 c0                	test   %eax,%eax
    4e80:	75 53                	jne    4ed5 <fwp_gc_commit+0xa5>
    4e82:	bf 1e 00 00 00       	mov    $0x1e,%edi
    4e87:	e8 a4 e5 ff ff       	call   3430 <sysconf@plt>
    4e8c:	48 8b 0d 7d 14 01 00 	mov    0x1147d(%rip),%rcx        # 16310 <fwp_gc+0x1078>
    4e93:	48 69 3d 5a 14 01 00 	imul   $0x1228,0x1145a(%rip),%rdi        # 162f8 <fwp_gc+0x1060>
    4e9a:	28 12 00 00 
    4e9e:	48 01 cf             	add    %rcx,%rdi
    4ea1:	48 69 d3 28 12 00 00 	imul   $0x1228,%rbx,%rdx
    4ea8:	48 01 ca             	add    %rcx,%rdx
    4eab:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    4eaf:	48 ff ce             	dec    %rsi
    4eb2:	48 f7 d8             	neg    %rax
    4eb5:	48 21 c7             	and    %rax,%rdi
    4eb8:	48 21 c6             	and    %rax,%rsi
    4ebb:	48 29 fe             	sub    %rdi,%rsi
    4ebe:	ba 03 00 00 00       	mov    $0x3,%edx
    4ec3:	e8 48 e5 ff ff       	call   3410 <mprotect@plt>
    4ec8:	85 c0                	test   %eax,%eax
    4eca:	75 09                	jne    4ed5 <fwp_gc_commit+0xa5>
    4ecc:	48 89 1d 25 14 01 00 	mov    %rbx,0x11425(%rip)        # 162f8 <fwp_gc+0x1060>
    4ed3:	5b                   	pop    %rbx
    4ed4:	c3                   	ret
    4ed5:	e8 56 fe ff ff       	call   4d30 <fwp_gc_oom>
    4eda:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000004ee0 <fwp_gc_collect>:
    4ee0:	83 3d a9 13 01 00 00 	cmpl   $0x0,0x113a9(%rip)        # 16290 <fwp_gc+0xff8>
    4ee7:	74 01                	je     4eea <fwp_gc_collect+0xa>
    4ee9:	c3                   	ret
    4eea:	55                   	push   %rbp
    4eeb:	48 89 e5             	mov    %rsp,%rbp
    4eee:	41 57                	push   %r15
    4ef0:	41 56                	push   %r14
    4ef2:	41 55                	push   %r13
    4ef4:	41 54                	push   %r12
    4ef6:	53                   	push   %rbx
    4ef7:	48 81 ec e8 00 00 00 	sub    $0xe8,%rsp
    4efe:	c7 05 88 13 01 00 01 	movl   $0x1,0x11388(%rip)        # 16290 <fwp_gc+0xff8>
    4f05:	00 00 00 
    4f08:	48 8d 75 b8          	lea    -0x48(%rbp),%rsi
    4f0c:	bf 01 00 00 00       	mov    $0x1,%edi
    4f11:	e8 1a e2 ff ff       	call   3130 <clock_gettime@plt>
    4f16:	48 8b 05 8b 15 01 00 	mov    0x1158b(%rip),%rax        # 164a8 <fwp_gc+0x1210>
    4f1d:	48 2b 05 74 03 01 00 	sub    0x10374(%rip),%rax        # 15298 <fwp_gc>
    4f24:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    4f29:	f2 0f 58 05 4f 15 01 	addsd  0x1154f(%rip),%xmm0        # 16480 <fwp_gc+0x11e8>
    4f30:	00 
    4f31:	f2 0f 11 05 47 15 01 	movsd  %xmm0,0x11547(%rip)        # 16480 <fwp_gc+0x11e8>
    4f38:	00 
    4f39:	83 3d 58 13 01 00 00 	cmpl   $0x0,0x11358(%rip)        # 16298 <fwp_gc+0x1000>
    4f40:	0f 94 c0             	sete   %al
    4f43:	83 3d 56 13 01 00 00 	cmpl   $0x0,0x11356(%rip)        # 162a0 <fwp_gc+0x1008>
    4f4a:	0f 95 c3             	setne  %bl
    4f4d:	08 c3                	or     %al,%bl
    4f4f:	80 fb 01             	cmp    $0x1,%bl
    4f52:	75 3e                	jne    4f92 <fwp_gc_collect+0xb2>
    4f54:	e8 b7 01 00 00       	call   5110 <fwp_gc_clear_marks>
    4f59:	48 8d bd f0 fe ff ff 	lea    -0x110(%rbp),%rdi
    4f60:	e8 4b e3 ff ff       	call   32b0 <_setjmp@plt>
    4f65:	48 c7 05 28 15 01 00 	movq   $0x0,0x11528(%rip)        # 16498 <fwp_gc+0x1200>
    4f6c:	00 00 00 00 
    4f70:	e8 1b 02 00 00       	call   5190 <fwp_gc_mark_all>
    4f75:	e8 36 07 00 00       	call   56b0 <fwp_gc_finalize>
    4f7a:	e8 c1 07 00 00       	call   5740 <fwp_gc_sweep>
    4f7f:	48 8b 05 ea 14 01 00 	mov    0x114ea(%rip),%rax        # 16470 <fwp_gc+0x11d8>
    4f86:	48 ff c0             	inc    %rax
    4f89:	48 89 05 e0 14 01 00 	mov    %rax,0x114e0(%rip)        # 16470 <fwp_gc+0x11d8>
    4f90:	eb 51                	jmp    4fe3 <fwp_gc_collect+0x103>
    4f92:	48 8d bd f0 fe ff ff 	lea    -0x110(%rbp),%rdi
    4f99:	e8 12 e3 ff ff       	call   32b0 <_setjmp@plt>
    4f9e:	48 c7 05 ef 14 01 00 	movq   $0x0,0x114ef(%rip)        # 16498 <fwp_gc+0x1200>
    4fa5:	00 00 00 00 
    4fa9:	e8 e2 01 00 00       	call   5190 <fwp_gc_mark_all>
    4fae:	e8 fd 01 00 00       	call   51b0 <fwp_gc_scan_old_filled>
    4fb3:	83 3d e2 12 01 00 00 	cmpl   $0x0,0x112e2(%rip)        # 1629c <fwp_gc+0x1004>
    4fba:	74 05                	je     4fc1 <fwp_gc_collect+0xe1>
    4fbc:	e8 2f 03 00 00       	call   52f0 <fwp_gc_verify_minor>
    4fc1:	e8 ea 06 00 00       	call   56b0 <fwp_gc_finalize>
    4fc6:	e8 75 07 00 00       	call   5740 <fwp_gc_sweep>
    4fcb:	48 8b 05 9e 14 01 00 	mov    0x1149e(%rip),%rax        # 16470 <fwp_gc+0x11d8>
    4fd2:	48 ff c0             	inc    %rax
    4fd5:	48 89 05 94 14 01 00 	mov    %rax,0x11494(%rip)        # 16470 <fwp_gc+0x11d8>
    4fdc:	48 ff 05 cd 12 01 00 	incq   0x112cd(%rip)        # 162b0 <fwp_gc+0x1018>
    4fe3:	48 89 c1             	mov    %rax,%rcx
    4fe6:	48 8b 05 73 14 01 00 	mov    0x11473(%rip),%rax        # 16460 <fwp_gc+0x11c8>
    4fed:	48 3b 05 74 14 01 00 	cmp    0x11474(%rip),%rax        # 16468 <fwp_gc+0x11d0>
    4ff4:	76 07                	jbe    4ffd <fwp_gc_collect+0x11d>
    4ff6:	48 89 05 6b 14 01 00 	mov    %rax,0x1146b(%rip)        # 16468 <fwp_gc+0x11d0>
    4ffd:	84 db                	test   %bl,%bl
    4fff:	74 0b                	je     500c <fwp_gc_collect+0x12c>
    5001:	48 89 05 a0 12 01 00 	mov    %rax,0x112a0(%rip)        # 162a8 <fwp_gc+0x1010>
    5008:	31 d2                	xor    %edx,%edx
    500a:	eb 2d                	jmp    5039 <fwp_gc_collect+0x159>
    500c:	48 8b 15 95 12 01 00 	mov    0x11295(%rip),%rdx        # 162a8 <fwp_gc+0x1010>
    5013:	48 89 d6             	mov    %rdx,%rsi
    5016:	48 d1 ee             	shr    $1,%rsi
    5019:	48 01 d6             	add    %rdx,%rsi
    501c:	48 81 fe 01 00 00 01 	cmp    $0x1000001,%rsi
    5023:	ba 00 00 00 01       	mov    $0x1000000,%edx
    5028:	48 0f 43 d6          	cmovae %rsi,%rdx
    502c:	31 f6                	xor    %esi,%esi
    502e:	48 39 d0             	cmp    %rdx,%rax
    5031:	0f 97 c2             	seta   %dl
    5034:	40 88 d6             	mov    %dl,%sil
    5037:	89 f2                	mov    %esi,%edx
    5039:	f6 c1 07             	test   $0x7,%cl
    503c:	b9 01 00 00 00       	mov    $0x1,%ecx
    5041:	0f 45 ca             	cmovne %edx,%ecx
    5044:	48 83 3d 6c 12 01 00 	cmpq   $0x0,0x1126c(%rip)        # 162b8 <fwp_gc+0x1020>
    504b:	00 
    504c:	0f 44 ca             	cmove  %edx,%ecx
    504f:	89 0d 4b 12 01 00    	mov    %ecx,0x1124b(%rip)        # 162a0 <fwp_gc+0x1008>
    5055:	83 3d 3c 12 01 00 00 	cmpl   $0x0,0x1123c(%rip)        # 16298 <fwp_gc+0x1000>
    505c:	0f 94 c1             	sete   %cl
    505f:	48 d3 e0             	shl    %cl,%rax
    5062:	f2 48 0f 2c 0d 2d 14 	cvttsd2si 0x1142d(%rip),%rcx        # 16498 <fwp_gc+0x1200>
    5069:	01 00 
    506b:	48 01 c1             	add    %rax,%rcx
    506e:	48 81 f9 01 00 80 00 	cmp    $0x800001,%rcx
    5075:	b8 00 00 80 00       	mov    $0x800000,%eax
    507a:	48 0f 4d c1          	cmovge %rcx,%rax
    507e:	48 89 05 23 14 01 00 	mov    %rax,0x11423(%rip)        # 164a8 <fwp_gc+0x1210>
    5085:	48 89 05 0c 02 01 00 	mov    %rax,0x1020c(%rip)        # 15298 <fwp_gc>
    508c:	48 8d 75 c8          	lea    -0x38(%rbp),%rsi
    5090:	bf 01 00 00 00       	mov    $0x1,%edi
    5095:	e8 96 e0 ff ff       	call   3130 <clock_gettime@plt>
    509a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    509e:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
    50a2:	48 2b 45 b8          	sub    -0x48(%rbp),%rax
    50a6:	f2 48 0f 2a c8       	cvtsi2sd %rax,%xmm1
    50ab:	f2 0f 59 0d 9d a0 00 	mulsd  0xa09d(%rip),%xmm1        # f150 <_IO_stdin_used+0x150>
    50b2:	00 
    50b3:	48 2b 4d c0          	sub    -0x40(%rbp),%rcx
    50b7:	0f 57 c0             	xorps  %xmm0,%xmm0
    50ba:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    50bf:	f2 0f 5e 05 91 a0 00 	divsd  0xa091(%rip),%xmm0        # f158 <_IO_stdin_used+0x158>
    50c6:	00 
    50c7:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
    50cb:	f2 0f 10 0d b5 13 01 	movsd  0x113b5(%rip),%xmm1        # 16488 <fwp_gc+0x11f0>
    50d2:	00 
    50d3:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
    50d7:	f2 0f 11 0d a9 13 01 	movsd  %xmm1,0x113a9(%rip)        # 16488 <fwp_gc+0x11f0>
    50de:	00 
    50df:	66 0f 2e 05 a9 13 01 	ucomisd 0x113a9(%rip),%xmm0        # 16490 <fwp_gc+0x11f8>
    50e6:	00 
    50e7:	48 8d a4 24 e8 00 00 	lea    0xe8(%rsp),%rsp
    50ee:	00 
    50ef:	5b                   	pop    %rbx
    50f0:	41 5c                	pop    %r12
    50f2:	41 5d                	pop    %r13
    50f4:	41 5e                	pop    %r14
    50f6:	41 5f                	pop    %r15
    50f8:	5d                   	pop    %rbp
    50f9:	76 08                	jbe    5103 <fwp_gc_collect+0x223>
    50fb:	f2 0f 11 05 8d 13 01 	movsd  %xmm0,0x1138d(%rip)        # 16490 <fwp_gc+0x11f8>
    5102:	00 
    5103:	c7 05 83 11 01 00 00 	movl   $0x0,0x11183(%rip)        # 16290 <fwp_gc+0xff8>
    510a:	00 00 00 
    510d:	c3                   	ret
    510e:	66 90                	xchg   %ax,%ax

0000000000005110 <fwp_gc_clear_marks>:
    5110:	48 8b 05 d9 11 01 00 	mov    0x111d9(%rip),%rax        # 162f0 <fwp_gc+0x1058>
    5117:	48 85 c0             	test   %rax,%rax
    511a:	74 69                	je     5185 <fwp_gc_clear_marks+0x75>
    511c:	41 56                	push   %r14
    511e:	53                   	push   %rbx
    511f:	50                   	push   %rax
    5120:	48 8b 0d e9 11 01 00 	mov    0x111e9(%rip),%rcx        # 16310 <fwp_gc+0x1078>
    5127:	31 db                	xor    %ebx,%ebx
    5129:	45 31 f6             	xor    %r14d,%r14d
    512c:	eb 16                	jmp    5144 <fwp_gc_clear_marks+0x34>
    512e:	66 90                	xchg   %ax,%ax
    5130:	c6 44 19 03 00       	movb   $0x0,0x3(%rcx,%rbx,1)
    5135:	49 ff c6             	inc    %r14
    5138:	48 81 c3 28 12 00 00 	add    $0x1228,%rbx
    513f:	49 39 c6             	cmp    %rax,%r14
    5142:	73 3a                	jae    517e <fwp_gc_clear_marks+0x6e>
    5144:	0f b6 14 19          	movzbl (%rcx,%rbx,1),%edx
    5148:	83 fa 02             	cmp    $0x2,%edx
    514b:	74 e3                	je     5130 <fwp_gc_clear_marks+0x20>
    514d:	83 fa 01             	cmp    $0x1,%edx
    5150:	75 e3                	jne    5135 <fwp_gc_clear_marks+0x25>
    5152:	48 8d 3c 19          	lea    (%rcx,%rbx,1),%rdi
    5156:	48 83 c7 28          	add    $0x28,%rdi
    515a:	8b 54 19 0c          	mov    0xc(%rcx,%rbx,1),%edx
    515e:	83 c2 3f             	add    $0x3f,%edx
    5161:	c1 ea 03             	shr    $0x3,%edx
    5164:	83 e2 f8             	and    $0xfffffff8,%edx
    5167:	31 f6                	xor    %esi,%esi
    5169:	e8 a2 e0 ff ff       	call   3210 <memset@plt>
    516e:	48 8b 0d 9b 11 01 00 	mov    0x1119b(%rip),%rcx        # 16310 <fwp_gc+0x1078>
    5175:	48 8b 05 74 11 01 00 	mov    0x11174(%rip),%rax        # 162f0 <fwp_gc+0x1058>
    517c:	eb b7                	jmp    5135 <fwp_gc_clear_marks+0x25>
    517e:	48 83 c4 08          	add    $0x8,%rsp
    5182:	5b                   	pop    %rbx
    5183:	41 5e                	pop    %r14
    5185:	c3                   	ret
    5186:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    518d:	00 00 00 

0000000000005190 <fwp_gc_mark_all>:
    5190:	50                   	push   %rax
    5191:	e8 4a 0c 00 00       	call   5de0 <fwp_gc_sp>
    5196:	48 89 c7             	mov    %rax,%rdi
    5199:	e8 32 0c 00 00       	call   5dd0 <fwp_gc_scan_stacks>
    519e:	e8 4d 0c 00 00       	call   5df0 <fwp_gc_drain>
    51a3:	e8 98 0c 00 00       	call   5e40 <fwp_gc_scan_data>
    51a8:	58                   	pop    %rax
    51a9:	e9 42 0c 00 00       	jmp    5df0 <fwp_gc_drain>
    51ae:	66 90                	xchg   %ax,%ax

00000000000051b0 <fwp_gc_scan_old_filled>:
    51b0:	48 83 3d 38 11 01 00 	cmpq   $0x0,0x11138(%rip)        # 162f0 <fwp_gc+0x1058>
    51b7:	00 
    51b8:	0f 84 32 0c 00 00    	je     5df0 <fwp_gc_drain>
    51be:	55                   	push   %rbp
    51bf:	41 57                	push   %r15
    51c1:	41 56                	push   %r14
    51c3:	41 55                	push   %r13
    51c5:	41 54                	push   %r12
    51c7:	53                   	push   %rbx
    51c8:	48 83 ec 18          	sub    $0x18,%rsp
    51cc:	31 c0                	xor    %eax,%eax
    51ce:	eb 14                	jmp    51e4 <fwp_gc_scan_old_filled+0x34>
    51d0:	48 8b 04 24          	mov    (%rsp),%rax
    51d4:	48 ff c0             	inc    %rax
    51d7:	48 3b 05 12 11 01 00 	cmp    0x11112(%rip),%rax        # 162f0 <fwp_gc+0x1058>
    51de:	0f 83 f6 00 00 00    	jae    52da <fwp_gc_scan_old_filled+0x12a>
    51e4:	48 8b 0d 25 11 01 00 	mov    0x11125(%rip),%rcx        # 16310 <fwp_gc+0x1078>
    51eb:	48 89 04 24          	mov    %rax,(%rsp)
    51ef:	48 69 e8 28 12 00 00 	imul   $0x1228,%rax,%rbp
    51f6:	80 7c 29 01 02       	cmpb   $0x2,0x1(%rcx,%rbp,1)
    51fb:	75 d3                	jne    51d0 <fwp_gc_scan_old_filled+0x20>
    51fd:	48 89 cb             	mov    %rcx,%rbx
    5200:	0f b6 04 29          	movzbl (%rcx,%rbp,1),%eax
    5204:	83 f8 02             	cmp    $0x2,%eax
    5207:	0f 84 a7 00 00 00    	je     52b4 <fwp_gc_scan_old_filled+0x104>
    520d:	83 f8 01             	cmp    $0x1,%eax
    5210:	75 be                	jne    51d0 <fwp_gc_scan_old_filled+0x20>
    5212:	48 8b 3c 24          	mov    (%rsp),%rdi
    5216:	e8 b5 ef ff ff       	call   41d0 <fwp_gc_chunk_addr>
    521b:	49 89 c6             	mov    %rax,%r14
    521e:	8b 44 2b 0c          	mov    0xc(%rbx,%rbp,1),%eax
    5222:	83 c0 3f             	add    $0x3f,%eax
    5225:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    522a:	83 f8 40             	cmp    $0x40,%eax
    522d:	72 a1                	jb     51d0 <fwp_gc_scan_old_filled+0x20>
    522f:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    5234:	c1 e8 06             	shr    $0x6,%eax
    5237:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    523c:	4c 8d 2c 2b          	lea    (%rbx,%rbp,1),%r13
    5240:	49 83 c5 08          	add    $0x8,%r13
    5244:	48 01 eb             	add    %rbp,%rbx
    5247:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
    524c:	45 31 ff             	xor    %r15d,%r15d
    524f:	eb 1d                	jmp    526e <fwp_gc_scan_old_filled+0xbe>
    5251:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5258:	0f 1f 84 00 00 00 00 
    525f:	00 
    5260:	49 ff c7             	inc    %r15
    5263:	4c 3b 7c 24 08       	cmp    0x8(%rsp),%r15
    5268:	0f 84 62 ff ff ff    	je     51d0 <fwp_gc_scan_old_filled+0x20>
    526e:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    5273:	4e 8b 64 f8 28       	mov    0x28(%rax,%r15,8),%r12
    5278:	4d 85 e4             	test   %r12,%r12
    527b:	74 e3                	je     5260 <fwp_gc_scan_old_filled+0xb0>
    527d:	4c 89 fd             	mov    %r15,%rbp
    5280:	48 c1 e5 06          	shl    $0x6,%rbp
    5284:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    528b:	00 00 00 00 00 
    5290:	f3 49 0f bc fc       	tzcnt  %r12,%rdi
    5295:	48 09 ef             	or     %rbp,%rdi
    5298:	49 8d 5c 24 ff       	lea    -0x1(%r12),%rbx
    529d:	41 8b 75 00          	mov    0x0(%r13),%esi
    52a1:	48 0f af fe          	imul   %rsi,%rdi
    52a5:	4c 01 f7             	add    %r14,%rdi
    52a8:	e8 03 0e 00 00       	call   60b0 <fwp_gc_push>
    52ad:	49 21 dc             	and    %rbx,%r12
    52b0:	75 de                	jne    5290 <fwp_gc_scan_old_filled+0xe0>
    52b2:	eb ac                	jmp    5260 <fwp_gc_scan_old_filled+0xb0>
    52b4:	80 7c 2b 03 00       	cmpb   $0x0,0x3(%rbx,%rbp,1)
    52b9:	0f 84 11 ff ff ff    	je     51d0 <fwp_gc_scan_old_filled+0x20>
    52bf:	48 8b 3c 24          	mov    (%rsp),%rdi
    52c3:	e8 08 ef ff ff       	call   41d0 <fwp_gc_chunk_addr>
    52c8:	48 8b 74 2b 18       	mov    0x18(%rbx,%rbp,1),%rsi
    52cd:	48 89 c7             	mov    %rax,%rdi
    52d0:	e8 db 0d 00 00       	call   60b0 <fwp_gc_push>
    52d5:	e9 f6 fe ff ff       	jmp    51d0 <fwp_gc_scan_old_filled+0x20>
    52da:	48 83 c4 18          	add    $0x18,%rsp
    52de:	5b                   	pop    %rbx
    52df:	41 5c                	pop    %r12
    52e1:	41 5d                	pop    %r13
    52e3:	41 5e                	pop    %r14
    52e5:	41 5f                	pop    %r15
    52e7:	5d                   	pop    %rbp
    52e8:	e9 03 0b 00 00       	jmp    5df0 <fwp_gc_drain>
    52ed:	0f 1f 00             	nopl   (%rax)

00000000000052f0 <fwp_gc_verify_minor>:
    52f0:	55                   	push   %rbp
    52f1:	41 57                	push   %r15
    52f3:	41 56                	push   %r14
    52f5:	41 55                	push   %r13
    52f7:	41 54                	push   %r12
    52f9:	53                   	push   %rbx
    52fa:	48 83 ec 58          	sub    $0x58,%rsp
    52fe:	4c 8b 2d eb 0f 01 00 	mov    0x10feb(%rip),%r13        # 162f0 <fwp_gc+0x1058>
    5305:	4c 89 ef             	mov    %r13,%rdi
    5308:	48 c1 e7 09          	shl    $0x9,%rdi
    530c:	e8 2f e0 ff ff       	call   3340 <malloc@plt>
    5311:	48 89 c3             	mov    %rax,%rbx
    5314:	49 83 fd 01          	cmp    $0x1,%r13
    5318:	4c 89 ef             	mov    %r13,%rdi
    531b:	48 83 d7 00          	adc    $0x0,%rdi
    531f:	48 89 7c 24 30       	mov    %rdi,0x30(%rsp)
    5324:	e8 17 e0 ff ff       	call   3340 <malloc@plt>
    5329:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
    532e:	48 85 db             	test   %rbx,%rbx
    5331:	0f 84 74 03 00 00    	je     56ab <fwp_gc_verify_minor+0x3bb>
    5337:	49 89 c7             	mov    %rax,%r15
    533a:	48 85 c0             	test   %rax,%rax
    533d:	0f 84 68 03 00 00    	je     56ab <fwp_gc_verify_minor+0x3bb>
    5343:	4d 85 ed             	test   %r13,%r13
    5346:	74 1c                	je     5364 <fwp_gc_verify_minor+0x74>
    5348:	48 8b 0d c1 0f 01 00 	mov    0x10fc1(%rip),%rcx        # 16310 <fwp_gc+0x1078>
    534f:	49 83 fd 01          	cmp    $0x1,%r13
    5353:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
    5358:	75 19                	jne    5373 <fwp_gc_verify_minor+0x83>
    535a:	4d 89 ec             	mov    %r13,%r12
    535d:	31 ed                	xor    %ebp,%ebp
    535f:	e9 81 00 00 00       	jmp    53e5 <fwp_gc_verify_minor+0xf5>
    5364:	e8 a7 fd ff ff       	call   5110 <fwp_gc_clear_marks>
    5369:	e8 22 fe ff ff       	call   5190 <fwp_gc_mark_all>
    536e:	e9 13 03 00 00       	jmp    5686 <fwp_gc_verify_minor+0x396>
    5373:	4d 89 ec             	mov    %r13,%r12
    5376:	49 83 e5 fe          	and    $0xfffffffffffffffe,%r13
    537a:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    537f:	48 8d 98 00 02 00 00 	lea    0x200(%rax),%rbx
    5386:	4c 8d b1 50 12 00 00 	lea    0x1250(%rcx),%r14
    538d:	31 ed                	xor    %ebp,%ebp
    538f:	90                   	nop
    5390:	48 8d bb 00 fe ff ff 	lea    -0x200(%rbx),%rdi
    5397:	49 8d b6 d8 ed ff ff 	lea    -0x1228(%r14),%rsi
    539e:	ba 00 02 00 00       	mov    $0x200,%edx
    53a3:	e8 88 df ff ff       	call   3330 <memcpy@plt>
    53a8:	41 0f b6 86 b3 ed ff 	movzbl -0x124d(%r14),%eax
    53af:	ff 
    53b0:	41 88 04 2f          	mov    %al,(%r15,%rbp,1)
    53b4:	ba 00 02 00 00       	mov    $0x200,%edx
    53b9:	48 89 df             	mov    %rbx,%rdi
    53bc:	4c 89 f6             	mov    %r14,%rsi
    53bf:	e8 6c df ff ff       	call   3330 <memcpy@plt>
    53c4:	41 0f b6 46 db       	movzbl -0x25(%r14),%eax
    53c9:	41 88 44 2f 01       	mov    %al,0x1(%r15,%rbp,1)
    53ce:	48 83 c5 02          	add    $0x2,%rbp
    53d2:	48 81 c3 00 04 00 00 	add    $0x400,%rbx
    53d9:	49 81 c6 50 24 00 00 	add    $0x2450,%r14
    53e0:	49 39 ed             	cmp    %rbp,%r13
    53e3:	75 ab                	jne    5390 <fwp_gc_verify_minor+0xa0>
    53e5:	4d 89 e5             	mov    %r12,%r13
    53e8:	41 f6 c5 01          	test   $0x1,%r13b
    53ec:	74 34                	je     5422 <fwp_gc_verify_minor+0x132>
    53ee:	48 89 ef             	mov    %rbp,%rdi
    53f1:	48 c1 e7 09          	shl    $0x9,%rdi
    53f5:	48 03 7c 24 20       	add    0x20(%rsp),%rdi
    53fa:	48 69 dd 28 12 00 00 	imul   $0x1228,%rbp,%rbx
    5401:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    5406:	49 8d 34 1e          	lea    (%r14,%rbx,1),%rsi
    540a:	48 83 c6 28          	add    $0x28,%rsi
    540e:	ba 00 02 00 00       	mov    $0x200,%edx
    5413:	e8 18 df ff ff       	call   3330 <memcpy@plt>
    5418:	41 0f b6 44 1e 03    	movzbl 0x3(%r14,%rbx,1),%eax
    541e:	41 88 04 2f          	mov    %al,(%r15,%rbp,1)
    5422:	e8 e9 fc ff ff       	call   5110 <fwp_gc_clear_marks>
    5427:	e8 64 fd ff ff       	call   5190 <fwp_gc_mark_all>
    542c:	4d 85 ed             	test   %r13,%r13
    542f:	0f 84 51 02 00 00    	je     5686 <fwp_gc_verify_minor+0x396>
    5435:	48 8b 1d d4 0e 01 00 	mov    0x10ed4(%rip),%rbx        # 16310 <fwp_gc+0x1078>
    543c:	48 8d 43 28          	lea    0x28(%rbx),%rax
    5440:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    5445:	31 ff                	xor    %edi,%edi
    5447:	eb 30                	jmp    5479 <fwp_gc_verify_minor+0x189>
    5449:	4d 85 c9             	test   %r9,%r9
    544c:	0f 85 b8 00 00 00    	jne    550a <fwp_gc_verify_minor+0x21a>
    5452:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5459:	1f 84 00 00 00 00 00 
    5460:	48 ff c7             	inc    %rdi
    5463:	48 81 c1 00 02 00 00 	add    $0x200,%rcx
    546a:	48 05 28 12 00 00    	add    $0x1228,%rax
    5470:	4c 39 ef             	cmp    %r13,%rdi
    5473:	0f 84 0d 02 00 00    	je     5686 <fwp_gc_verify_minor+0x396>
    5479:	4c 69 f7 28 12 00 00 	imul   $0x1228,%rdi,%r14
    5480:	42 0f b6 2c 33       	movzbl (%rbx,%r14,1),%ebp
    5485:	83 fd 02             	cmp    $0x2,%ebp
    5488:	74 66                	je     54f0 <fwp_gc_verify_minor+0x200>
    548a:	83 fd 01             	cmp    $0x1,%ebp
    548d:	75 d1                	jne    5460 <fwp_gc_verify_minor+0x170>
    548f:	42 8b 54 33 0c       	mov    0xc(%rbx,%r14,1),%edx
    5494:	83 c2 3f             	add    $0x3f,%edx
    5497:	83 fa 40             	cmp    $0x40,%edx
    549a:	72 c4                	jb     5460 <fwp_gc_verify_minor+0x170>
    549c:	c1 ea 06             	shr    $0x6,%edx
    549f:	31 f6                	xor    %esi,%esi
    54a1:	45 31 e4             	xor    %r12d,%r12d
    54a4:	45 31 c0             	xor    %r8d,%r8d
    54a7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    54ae:	00 00 
    54b0:	4e 8b 0c c1          	mov    (%rcx,%r8,8),%r9
    54b4:	49 f7 d1             	not    %r9
    54b7:	4e 23 0c c0          	and    (%rax,%r8,8),%r9
    54bb:	4d 89 e2             	mov    %r12,%r10
    54be:	f3 4d 0f bc e1       	tzcnt  %r9,%r12
    54c3:	49 01 f4             	add    %rsi,%r12
    54c6:	4d 85 c9             	test   %r9,%r9
    54c9:	4d 0f 44 e2          	cmove  %r10,%r12
    54cd:	49 ff c0             	inc    %r8
    54d0:	49 39 d0             	cmp    %rdx,%r8
    54d3:	0f 83 70 ff ff ff    	jae    5449 <fwp_gc_verify_minor+0x159>
    54d9:	48 83 c6 40          	add    $0x40,%rsi
    54dd:	4d 85 c9             	test   %r9,%r9
    54e0:	74 ce                	je     54b0 <fwp_gc_verify_minor+0x1c0>
    54e2:	e9 62 ff ff ff       	jmp    5449 <fwp_gc_verify_minor+0x159>
    54e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    54ee:	00 00 
    54f0:	42 80 7c 33 03 00    	cmpb   $0x0,0x3(%rbx,%r14,1)
    54f6:	0f 84 64 ff ff ff    	je     5460 <fwp_gc_verify_minor+0x170>
    54fc:	41 80 3c 3f 00       	cmpb   $0x0,(%r15,%rdi,1)
    5501:	0f 85 59 ff ff ff    	jne    5460 <fwp_gc_verify_minor+0x170>
    5507:	45 31 e4             	xor    %r12d,%r12d
    550a:	e8 c1 ec ff ff       	call   41d0 <fwp_gc_chunk_addr>
    550f:	46 8b 7c 33 08       	mov    0x8(%rbx,%r14,1),%r15d
    5514:	4d 0f af e7          	imul   %r15,%r12
    5518:	49 01 c4             	add    %rax,%r12
    551b:	40 80 fd 01          	cmp    $0x1,%bpl
    551f:	74 05                	je     5526 <fwp_gc_verify_minor+0x236>
    5521:	4e 8b 7c 33 18       	mov    0x18(%rbx,%r14,1),%r15
    5526:	48 8b 05 ab fa 00 00 	mov    0xfaab(%rip),%rax        # 14fd8 <stderr@GLIBC_2.2.5>
    552d:	48 8b 38             	mov    (%rax),%rdi
    5530:	42 0f b6 4c 33 01    	movzbl 0x1(%rbx,%r14,1),%ecx
    5536:	48 8d 35 b8 a3 00 00 	lea    0xa3b8(%rip),%rsi        # f8f5 <exec_in_fp0+0x1f5>
    553d:	4c 89 e2             	mov    %r12,%rdx
    5540:	4d 89 f8             	mov    %r15,%r8
    5543:	31 c0                	xor    %eax,%eax
    5545:	e8 a6 dd ff ff       	call   32f0 <fprintf@plt>
    554a:	4d 01 e7             	add    %r12,%r15
    554d:	45 31 ed             	xor    %r13d,%r13d
    5550:	4c 89 7c 24 40       	mov    %r15,0x40(%rsp)
    5555:	eb 17                	jmp    556e <fwp_gc_verify_minor+0x27e>
    5557:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    555e:	00 00 
    5560:	49 ff c5             	inc    %r13
    5563:	4c 3b 6c 24 30       	cmp    0x30(%rsp),%r13
    5568:	0f 84 38 01 00 00    	je     56a6 <fwp_gc_verify_minor+0x3b6>
    556e:	48 8b 05 9b 0d 01 00 	mov    0x10d9b(%rip),%rax        # 16310 <fwp_gc+0x1078>
    5575:	49 69 cd 28 12 00 00 	imul   $0x1228,%r13,%rcx
    557c:	80 3c 08 01          	cmpb   $0x1,(%rax,%rcx,1)
    5580:	75 de                	jne    5560 <fwp_gc_verify_minor+0x270>
    5582:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    5587:	74 d7                	je     5560 <fwp_gc_verify_minor+0x270>
    5589:	8b 5c 08 0c          	mov    0xc(%rax,%rcx,1),%ebx
    558d:	85 db                	test   %ebx,%ebx
    558f:	74 cf                	je     5560 <fwp_gc_verify_minor+0x270>
    5591:	48 01 c8             	add    %rcx,%rax
    5594:	48 ff c0             	inc    %rax
    5597:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    559c:	4c 89 e8             	mov    %r13,%rax
    559f:	48 c1 e0 09          	shl    $0x9,%rax
    55a3:	48 03 44 24 20       	add    0x20(%rsp),%rax
    55a8:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    55ad:	31 ed                	xor    %ebp,%ebp
    55af:	4c 89 6c 24 38       	mov    %r13,0x38(%rsp)
    55b4:	eb 21                	jmp    55d7 <fwp_gc_verify_minor+0x2e7>
    55b6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    55bd:	00 00 00 
    55c0:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    55c5:	8b 58 0b             	mov    0xb(%rax),%ebx
    55c8:	4c 8b 6c 24 38       	mov    0x38(%rsp),%r13
    55cd:	48 ff c5             	inc    %rbp
    55d0:	89 d8                	mov    %ebx,%eax
    55d2:	48 39 c5             	cmp    %rax,%rbp
    55d5:	73 89                	jae    5560 <fwp_gc_verify_minor+0x270>
    55d7:	48 89 e8             	mov    %rbp,%rax
    55da:	48 c1 e8 06          	shr    $0x6,%rax
    55de:	48 8b 4c 24 50       	mov    0x50(%rsp),%rcx
    55e3:	48 8b 04 c1          	mov    (%rcx,%rax,8),%rax
    55e7:	48 0f a3 e8          	bt     %rbp,%rax
    55eb:	73 e0                	jae    55cd <fwp_gc_verify_minor+0x2dd>
    55ed:	4c 89 ef             	mov    %r13,%rdi
    55f0:	e8 db eb ff ff       	call   41d0 <fwp_gc_chunk_addr>
    55f5:	48 89 c2             	mov    %rax,%rdx
    55f8:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    55fd:	44 8b 70 07          	mov    0x7(%rax),%r14d
    5601:	49 83 fe 08          	cmp    $0x8,%r14
    5605:	72 c6                	jb     55cd <fwp_gc_verify_minor+0x2dd>
    5607:	45 89 f0             	mov    %r14d,%r8d
    560a:	4c 0f af f5          	imul   %rbp,%r14
    560e:	48 89 d3             	mov    %rdx,%rbx
    5611:	4c 01 f3             	add    %r14,%rbx
    5614:	45 31 ed             	xor    %r13d,%r13d
    5617:	48 89 54 24 48       	mov    %rdx,0x48(%rsp)
    561c:	eb 10                	jmp    562e <fwp_gc_verify_minor+0x33e>
    561e:	66 90                	xchg   %ax,%ax
    5620:	49 ff c5             	inc    %r13
    5623:	44 89 c0             	mov    %r8d,%eax
    5626:	c1 e8 03             	shr    $0x3,%eax
    5629:	49 39 c5             	cmp    %rax,%r13
    562c:	73 92                	jae    55c0 <fwp_gc_verify_minor+0x2d0>
    562e:	4a 8b 04 eb          	mov    (%rbx,%r13,8),%rax
    5632:	4c 39 e0             	cmp    %r12,%rax
    5635:	72 e9                	jb     5620 <fwp_gc_verify_minor+0x330>
    5637:	4c 39 f8             	cmp    %r15,%rax
    563a:	73 e4                	jae    5620 <fwp_gc_verify_minor+0x330>
    563c:	48 8b 05 95 f9 00 00 	mov    0xf995(%rip),%rax        # 14fd8 <stderr@GLIBC_2.2.5>
    5643:	48 8b 38             	mov    (%rax),%rdi
    5646:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
    564b:	41 0f b6 0f          	movzbl (%r15),%ecx
    564f:	42 0f 10 04 32       	movups (%rdx,%r14,1),%xmm0
    5654:	4a 8b 44 32 10       	mov    0x10(%rdx,%r14,1),%rax
    5659:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    565e:	0f 11 04 24          	movups %xmm0,(%rsp)
    5662:	48 8d 35 e6 a2 00 00 	lea    0xa2e6(%rip),%rsi        # f94f <exec_in_fp0+0x24f>
    5669:	48 89 da             	mov    %rbx,%rdx
    566c:	4d 89 e9             	mov    %r13,%r9
    566f:	31 c0                	xor    %eax,%eax
    5671:	e8 7a dc ff ff       	call   32f0 <fprintf@plt>
    5676:	48 8b 54 24 48       	mov    0x48(%rsp),%rdx
    567b:	45 8b 47 07          	mov    0x7(%r15),%r8d
    567f:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
    5684:	eb 9a                	jmp    5620 <fwp_gc_verify_minor+0x330>
    5686:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    568b:	e8 c0 d9 ff ff       	call   3050 <free@plt>
    5690:	4c 89 ff             	mov    %r15,%rdi
    5693:	48 83 c4 58          	add    $0x58,%rsp
    5697:	5b                   	pop    %rbx
    5698:	41 5c                	pop    %r12
    569a:	41 5d                	pop    %r13
    569c:	41 5e                	pop    %r14
    569e:	41 5f                	pop    %r15
    56a0:	5d                   	pop    %rbp
    56a1:	e9 aa d9 ff ff       	jmp    3050 <free@plt>
    56a6:	e8 c5 d9 ff ff       	call   3070 <abort@plt>
    56ab:	e8 80 f6 ff ff       	call   4d30 <fwp_gc_oom>

00000000000056b0 <fwp_gc_finalize>:
    56b0:	41 57                	push   %r15
    56b2:	41 56                	push   %r14
    56b4:	41 55                	push   %r13
    56b6:	41 54                	push   %r12
    56b8:	53                   	push   %rbx
    56b9:	4c 8b 3d 90 0d 01 00 	mov    0x10d90(%rip),%r15        # 16450 <fwp_gc+0x11b8>
    56c0:	4d 85 ff             	test   %r15,%r15
    56c3:	74 71                	je     5736 <fwp_gc_finalize+0x86>
    56c5:	4c 8b 25 7c 0d 01 00 	mov    0x10d7c(%rip),%r12        # 16448 <fwp_gc+0x11b0>
    56cc:	45 31 f6             	xor    %r14d,%r14d
    56cf:	eb 46                	jmp    5717 <fwp_gc_finalize+0x67>
    56d1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    56d8:	0f 1f 84 00 00 00 00 
    56df:	00 
    56e0:	4d 01 e5             	add    %r12,%r13
    56e3:	49 8b 45 08          	mov    0x8(%r13),%rax
    56e7:	49 ff cf             	dec    %r15
    56ea:	4c 89 3d 5f 0d 01 00 	mov    %r15,0x10d5f(%rip)        # 16450 <fwp_gc+0x11b8>
    56f1:	49 c1 e7 04          	shl    $0x4,%r15
    56f5:	43 0f 10 04 3c       	movups (%r12,%r15,1),%xmm0
    56fa:	41 0f 11 45 00       	movups %xmm0,0x0(%r13)
    56ff:	48 89 df             	mov    %rbx,%rdi
    5702:	ff d0                	call   *%rax
    5704:	4c 8b 25 3d 0d 01 00 	mov    0x10d3d(%rip),%r12        # 16448 <fwp_gc+0x11b0>
    570b:	4c 8b 3d 3e 0d 01 00 	mov    0x10d3e(%rip),%r15        # 16450 <fwp_gc+0x11b8>
    5712:	4d 39 fe             	cmp    %r15,%r14
    5715:	73 1f                	jae    5736 <fwp_gc_finalize+0x86>
    5717:	4d 89 f5             	mov    %r14,%r13
    571a:	49 c1 e5 04          	shl    $0x4,%r13
    571e:	4b 8b 1c 2c          	mov    (%r12,%r13,1),%rbx
    5722:	48 89 df             	mov    %rbx,%rdi
    5725:	e8 06 0a 00 00       	call   6130 <fwp_gc_marked>
    572a:	85 c0                	test   %eax,%eax
    572c:	74 b2                	je     56e0 <fwp_gc_finalize+0x30>
    572e:	49 ff c6             	inc    %r14
    5731:	4d 39 fe             	cmp    %r15,%r14
    5734:	72 e1                	jb     5717 <fwp_gc_finalize+0x67>
    5736:	5b                   	pop    %rbx
    5737:	41 5c                	pop    %r12
    5739:	41 5d                	pop    %r13
    573b:	41 5e                	pop    %r14
    573d:	41 5f                	pop    %r15
    573f:	c3                   	ret

0000000000005740 <fwp_gc_sweep>:
    5740:	55                   	push   %rbp
    5741:	41 57                	push   %r15
    5743:	41 56                	push   %r14
    5745:	41 55                	push   %r13
    5747:	41 54                	push   %r12
    5749:	53                   	push   %rbx
    574a:	48 83 ec 28          	sub    $0x28,%rsp
    574e:	48 8d 3d 4b fb 00 00 	lea    0xfb4b(%rip),%rdi        # 152a0 <fwp_gc+0x8>
    5755:	45 31 ff             	xor    %r15d,%r15d
    5758:	ba 40 0b 00 00       	mov    $0xb40,%edx
    575d:	31 f6                	xor    %esi,%esi
    575f:	e8 ac da ff ff       	call   3210 <memset@plt>
    5764:	48 83 3d 84 0b 01 00 	cmpq   $0x0,0x10b84(%rip)        # 162f0 <fwp_gc+0x1058>
    576b:	00 
    576c:	0f 84 06 05 00 00    	je     5c78 <fwp_gc_sweep+0x538>
    5772:	31 c0                	xor    %eax,%eax
    5774:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    5779:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    5780:	55 55 55 
    5783:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    578a:	33 33 33 
    578d:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    5794:	0f 0f 0f 
    5797:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    579e:	01 01 01 
    57a1:	66 0f 6f 2d 07 99 00 	movdqa 0x9907(%rip),%xmm5        # f0b0 <_IO_stdin_used+0xb0>
    57a8:	00 
    57a9:	66 0f 6f 35 0f 99 00 	movdqa 0x990f(%rip),%xmm6        # f0c0 <_IO_stdin_used+0xc0>
    57b0:	00 
    57b1:	66 0f 6f 3d 17 99 00 	movdqa 0x9917(%rip),%xmm7        # f0d0 <_IO_stdin_used+0xd0>
    57b8:	00 
    57b9:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    57be:	45 31 ff             	xor    %r15d,%r15d
    57c1:	31 db                	xor    %ebx,%ebx
    57c3:	eb 63                	jmp    5828 <fwp_gc_sweep+0xe8>
    57c5:	4c 8b 64 24 10       	mov    0x10(%rsp),%r12
    57ca:	4c 89 e7             	mov    %r12,%rdi
    57cd:	e8 ee 09 00 00       	call   61c0 <fwp_rc_clear_chunk>
    57d2:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    57d7:	66 0f 6f 3d f1 98 00 	movdqa 0x98f1(%rip),%xmm7        # f0d0 <_IO_stdin_used+0xd0>
    57de:	00 
    57df:	66 0f 6f 35 d9 98 00 	movdqa 0x98d9(%rip),%xmm6        # f0c0 <_IO_stdin_used+0xc0>
    57e6:	00 
    57e7:	66 0f 6f 2d c1 98 00 	movdqa 0x98c1(%rip),%xmm5        # f0b0 <_IO_stdin_used+0xb0>
    57ee:	00 
    57ef:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    57f6:	01 01 01 
    57f9:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    5800:	0f 0f 0f 
    5803:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    580a:	33 33 33 
    580d:	41 c6 04 24 00       	movb   $0x0,(%r12)
    5812:	49 ff c7             	inc    %r15
    5815:	48 ff c3             	inc    %rbx
    5818:	48 8b 05 d1 0a 01 00 	mov    0x10ad1(%rip),%rax        # 162f0 <fwp_gc+0x1058>
    581f:	48 39 c3             	cmp    %rax,%rbx
    5822:	0f 83 59 04 00 00    	jae    5c81 <fwp_gc_sweep+0x541>
    5828:	4c 8b 2d e1 0a 01 00 	mov    0x10ae1(%rip),%r13        # 16310 <fwp_gc+0x1078>
    582f:	4c 69 e3 28 12 00 00 	imul   $0x1228,%rbx,%r12
    5836:	43 0f b6 44 25 00    	movzbl 0x0(%r13,%r12,1),%eax
    583c:	85 c0                	test   %eax,%eax
    583e:	74 d2                	je     5812 <fwp_gc_sweep+0xd2>
    5840:	83 f8 01             	cmp    $0x1,%eax
    5843:	74 2b                	je     5870 <fwp_gc_sweep+0x130>
    5845:	83 f8 02             	cmp    $0x2,%eax
    5848:	75 cb                	jne    5815 <fwp_gc_sweep+0xd5>
    584a:	47 8b 74 25 10       	mov    0x10(%r13,%r12,1),%r14d
    584f:	43 80 7c 25 03 00    	cmpb   $0x0,0x3(%r13,%r12,1)
    5855:	74 4c                	je     58a3 <fwp_gc_sweep+0x163>
    5857:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    585c:	4b 03 44 25 18       	add    0x18(%r13,%r12,1),%rax
    5861:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    5866:	e9 f8 03 00 00       	jmp    5c63 <fwp_gc_sweep+0x523>
    586b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    5870:	4b 8d 04 2c          	lea    (%r12,%r13,1),%rax
    5874:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    5879:	43 8b 6c 25 0c       	mov    0xc(%r13,%r12,1),%ebp
    587e:	48 85 ed             	test   %rbp,%rbp
    5881:	0f 84 3e ff ff ff    	je     57c5 <fwp_gc_sweep+0x85>
    5887:	48 8d 55 3f          	lea    0x3f(%rbp),%rdx
    588b:	48 89 d0             	mov    %rdx,%rax
    588e:	48 c1 e8 06          	shr    $0x6,%rax
    5892:	81 fd c1 00 00 00    	cmp    $0xc1,%ebp
    5898:	73 75                	jae    590f <fwp_gc_sweep+0x1cf>
    589a:	31 d2                	xor    %edx,%edx
    589c:	31 c9                	xor    %ecx,%ecx
    589e:	e9 3c 01 00 00       	jmp    59df <fwp_gc_sweep+0x29f>
    58a3:	4b 8d 3c 2c          	lea    (%r12,%r13,1),%rdi
    58a7:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    58ae:	e8 fd e8 ff ff       	call   41b0 <fwp_rc_clear_slot>
    58b3:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    58b8:	66 0f 6f 3d 10 98 00 	movdqa 0x9810(%rip),%xmm7        # f0d0 <_IO_stdin_used+0xd0>
    58bf:	00 
    58c0:	66 0f 6f 35 f8 97 00 	movdqa 0x97f8(%rip),%xmm6        # f0c0 <_IO_stdin_used+0xc0>
    58c7:	00 
    58c8:	66 0f 6f 2d e0 97 00 	movdqa 0x97e0(%rip),%xmm5        # f0b0 <_IO_stdin_used+0xb0>
    58cf:	00 
    58d0:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    58d7:	01 01 01 
    58da:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    58e1:	0f 0f 0f 
    58e4:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    58eb:	33 33 33 
    58ee:	4d 85 f6             	test   %r14,%r14
    58f1:	0f 84 69 03 00 00    	je     5c60 <fwp_gc_sweep+0x520>
    58f7:	48 8b 05 12 0a 01 00 	mov    0x10a12(%rip),%rax        # 16310 <fwp_gc+0x1078>
    58fe:	41 83 fe 04          	cmp    $0x4,%r14d
    5902:	0f 83 e6 02 00 00    	jae    5bee <fwp_gc_sweep+0x4ae>
    5908:	31 c9                	xor    %ecx,%ecx
    590a:	e9 19 03 00 00       	jmp    5c28 <fwp_gc_sweep+0x4e8>
    590f:	89 c1                	mov    %eax,%ecx
    5911:	83 e1 fc             	and    $0xfffffffc,%ecx
    5914:	4b 8d 34 2c          	lea    (%r12,%r13,1),%rsi
    5918:	48 83 c6 38          	add    $0x38,%rsi
    591c:	48 c1 ea 03          	shr    $0x3,%rdx
    5920:	83 e2 e0             	and    $0xffffffe0,%edx
    5923:	66 0f ef c0          	pxor   %xmm0,%xmm0
    5927:	31 ff                	xor    %edi,%edi
    5929:	66 0f ef c9          	pxor   %xmm1,%xmm1
    592d:	0f 1f 00             	nopl   (%rax)
    5930:	f3 0f 6f 5c 3e f0    	movdqu -0x10(%rsi,%rdi,1),%xmm3
    5936:	f3 0f 6f 14 3e       	movdqu (%rsi,%rdi,1),%xmm2
    593b:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    593f:	66 0f 71 d4 01       	psrlw  $0x1,%xmm4
    5944:	66 0f db e5          	pand   %xmm5,%xmm4
    5948:	66 0f f8 dc          	psubb  %xmm4,%xmm3
    594c:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    5950:	66 0f db e6          	pand   %xmm6,%xmm4
    5954:	66 0f 71 d3 02       	psrlw  $0x2,%xmm3
    5959:	66 0f db de          	pand   %xmm6,%xmm3
    595d:	66 0f fc dc          	paddb  %xmm4,%xmm3
    5961:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    5965:	66 0f 71 d4 04       	psrlw  $0x4,%xmm4
    596a:	66 0f fc e3          	paddb  %xmm3,%xmm4
    596e:	66 0f db e7          	pand   %xmm7,%xmm4
    5972:	66 41 0f f6 e0       	psadbw %xmm8,%xmm4
    5977:	66 0f d4 c4          	paddq  %xmm4,%xmm0
    597b:	66 0f 6f da          	movdqa %xmm2,%xmm3
    597f:	66 0f 71 d3 01       	psrlw  $0x1,%xmm3
    5984:	66 0f db dd          	pand   %xmm5,%xmm3
    5988:	66 0f f8 d3          	psubb  %xmm3,%xmm2
    598c:	66 0f 6f da          	movdqa %xmm2,%xmm3
    5990:	66 0f db de          	pand   %xmm6,%xmm3
    5994:	66 0f 71 d2 02       	psrlw  $0x2,%xmm2
    5999:	66 0f db d6          	pand   %xmm6,%xmm2
    599d:	66 0f fc d3          	paddb  %xmm3,%xmm2
    59a1:	66 0f 6f da          	movdqa %xmm2,%xmm3
    59a5:	66 0f 71 d3 04       	psrlw  $0x4,%xmm3
    59aa:	66 0f fc da          	paddb  %xmm2,%xmm3
    59ae:	66 0f db df          	pand   %xmm7,%xmm3
    59b2:	66 41 0f f6 d8       	psadbw %xmm8,%xmm3
    59b7:	66 0f d4 cb          	paddq  %xmm3,%xmm1
    59bb:	48 83 c7 20          	add    $0x20,%rdi
    59bf:	48 39 fa             	cmp    %rdi,%rdx
    59c2:	0f 85 68 ff ff ff    	jne    5930 <fwp_gc_sweep+0x1f0>
    59c8:	66 0f d4 c8          	paddq  %xmm0,%xmm1
    59cc:	66 0f 70 c1 ee       	pshufd $0xee,%xmm1,%xmm0
    59d1:	66 0f d4 c1          	paddq  %xmm1,%xmm0
    59d5:	66 48 0f 7e c2       	movq   %xmm0,%rdx
    59da:	48 39 c8             	cmp    %rcx,%rax
    59dd:	74 51                	je     5a30 <fwp_gc_sweep+0x2f0>
    59df:	4b 8d 34 2c          	lea    (%r12,%r13,1),%rsi
    59e3:	48 83 c6 28          	add    $0x28,%rsi
    59e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    59ee:	00 00 
    59f0:	48 8b 3c ce          	mov    (%rsi,%rcx,8),%rdi
    59f4:	49 89 f8             	mov    %rdi,%r8
    59f7:	49 d1 e8             	shr    $1,%r8
    59fa:	4d 21 f0             	and    %r14,%r8
    59fd:	4c 29 c7             	sub    %r8,%rdi
    5a00:	49 89 f8             	mov    %rdi,%r8
    5a03:	4d 21 c8             	and    %r9,%r8
    5a06:	48 c1 ef 02          	shr    $0x2,%rdi
    5a0a:	4c 21 cf             	and    %r9,%rdi
    5a0d:	4c 01 c7             	add    %r8,%rdi
    5a10:	49 89 f8             	mov    %rdi,%r8
    5a13:	49 c1 e8 04          	shr    $0x4,%r8
    5a17:	49 01 f8             	add    %rdi,%r8
    5a1a:	4d 21 d0             	and    %r10,%r8
    5a1d:	4d 0f af c3          	imul   %r11,%r8
    5a21:	49 c1 e8 38          	shr    $0x38,%r8
    5a25:	4c 01 c2             	add    %r8,%rdx
    5a28:	48 ff c1             	inc    %rcx
    5a2b:	48 39 c8             	cmp    %rcx,%rax
    5a2e:	75 c0                	jne    59f0 <fwp_gc_sweep+0x2b0>
    5a30:	48 85 d2             	test   %rdx,%rdx
    5a33:	0f 84 8c fd ff ff    	je     57c5 <fwp_gc_sweep+0x85>
    5a39:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    5a3e:	43 8b 44 25 08       	mov    0x8(%r13,%r12,1),%eax
    5a43:	48 0f af d0          	imul   %rax,%rdx
    5a47:	48 01 54 24 08       	add    %rdx,0x8(%rsp)
    5a4c:	47 0f b6 74 25 01    	movzbl 0x1(%r13,%r12,1),%r14d
    5a52:	47 0f b6 7c 25 02    	movzbl 0x2(%r13,%r12,1),%r15d
    5a58:	48 89 df             	mov    %rbx,%rdi
    5a5b:	e8 70 e7 ff ff       	call   41d0 <fwp_gc_chunk_addr>
    5a60:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    5a65:	48 85 ed             	test   %rbp,%rbp
    5a68:	0f 84 31 01 00 00    	je     5b9f <fwp_gc_sweep+0x45f>
    5a6e:	49 69 c6 c0 03 00 00 	imul   $0x3c0,%r14,%rax
    5a75:	48 8d 0d 1c f8 00 00 	lea    0xf81c(%rip),%rcx        # 15298 <fwp_gc>
    5a7c:	48 01 c8             	add    %rcx,%rax
    5a7f:	4f 8d 34 2c          	lea    (%r12,%r13,1),%r14
    5a83:	49 83 c6 08          	add    $0x8,%r14
    5a87:	4b 8d 0c 7f          	lea    (%r15,%r15,2),%rcx
    5a8b:	4c 8d 3c c8          	lea    (%rax,%rcx,8),%r15
    5a8f:	49 83 c7 08          	add    $0x8,%r15
    5a93:	49 01 ec             	add    %rbp,%r12
    5a96:	4d 01 ec             	add    %r13,%r12
    5a99:	49 81 c4 27 02 00 00 	add    $0x227,%r12
    5aa0:	48 ff cd             	dec    %rbp
    5aa3:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    5aaa:	33 33 33 
    5aad:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    5ab4:	0f 0f 0f 
    5ab7:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    5abe:	01 01 01 
    5ac1:	66 0f 6f 2d e7 95 00 	movdqa 0x95e7(%rip),%xmm5        # f0b0 <_IO_stdin_used+0xb0>
    5ac8:	00 
    5ac9:	66 0f 6f 35 ef 95 00 	movdqa 0x95ef(%rip),%xmm6        # f0c0 <_IO_stdin_used+0xc0>
    5ad0:	00 
    5ad1:	66 0f 6f 3d f7 95 00 	movdqa 0x95f7(%rip),%xmm7        # f0d0 <_IO_stdin_used+0xd0>
    5ad8:	00 
    5ad9:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    5ade:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    5ae3:	eb 69                	jmp    5b4e <fwp_gc_sweep+0x40e>
    5ae5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    5aec:	00 00 00 00 
    5af0:	4c 89 e7             	mov    %r12,%rdi
    5af3:	e8 b8 e6 ff ff       	call   41b0 <fwp_rc_clear_slot>
    5af8:	49 8b 07             	mov    (%r15),%rax
    5afb:	48 f7 d0             	not    %rax
    5afe:	49 89 45 00          	mov    %rax,0x0(%r13)
    5b02:	4d 89 2f             	mov    %r13,(%r15)
    5b05:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    5b0c:	33 33 33 
    5b0f:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    5b16:	0f 0f 0f 
    5b19:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    5b20:	01 01 01 
    5b23:	66 0f 6f 2d 85 95 00 	movdqa 0x9585(%rip),%xmm5        # f0b0 <_IO_stdin_used+0xb0>
    5b2a:	00 
    5b2b:	66 0f 6f 35 8d 95 00 	movdqa 0x958d(%rip),%xmm6        # f0c0 <_IO_stdin_used+0xc0>
    5b32:	00 
    5b33:	66 0f 6f 3d 95 95 00 	movdqa 0x9595(%rip),%xmm7        # f0d0 <_IO_stdin_used+0xd0>
    5b3a:	00 
    5b3b:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    5b40:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    5b45:	49 ff cc             	dec    %r12
    5b48:	48 83 c5 ff          	add    $0xffffffffffffffff,%rbp
    5b4c:	73 3d                	jae    5b8b <fwp_gc_sweep+0x44b>
    5b4e:	48 89 e8             	mov    %rbp,%rax
    5b51:	48 c1 e8 06          	shr    $0x6,%rax
    5b55:	48 8b 44 c1 28       	mov    0x28(%rcx,%rax,8),%rax
    5b5a:	48 0f a3 e8          	bt     %rbp,%rax
    5b5e:	72 e5                	jb     5b45 <fwp_gc_sweep+0x405>
    5b60:	41 8b 16             	mov    (%r14),%edx
    5b63:	49 89 ed             	mov    %rbp,%r13
    5b66:	4c 0f af ea          	imul   %rdx,%r13
    5b6a:	4c 03 6c 24 20       	add    0x20(%rsp),%r13
    5b6f:	83 3d 26 07 01 00 00 	cmpl   $0x0,0x10726(%rip)        # 1629c <fwp_gc+0x1004>
    5b76:	0f 84 74 ff ff ff    	je     5af0 <fwp_gc_sweep+0x3b0>
    5b7c:	4c 89 ef             	mov    %r13,%rdi
    5b7f:	31 f6                	xor    %esi,%esi
    5b81:	e8 8a d6 ff ff       	call   3210 <memset@plt>
    5b86:	e9 65 ff ff ff       	jmp    5af0 <fwp_gc_sweep+0x3b0>
    5b8b:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    5b90:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    5b97:	55 55 55 
    5b9a:	e9 76 fc ff ff       	jmp    5815 <fwp_gc_sweep+0xd5>
    5b9f:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    5ba4:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    5bab:	55 55 55 
    5bae:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    5bb5:	33 33 33 
    5bb8:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    5bbf:	0f 0f 0f 
    5bc2:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    5bc9:	01 01 01 
    5bcc:	66 0f 6f 2d dc 94 00 	movdqa 0x94dc(%rip),%xmm5        # f0b0 <_IO_stdin_used+0xb0>
    5bd3:	00 
    5bd4:	66 0f 6f 35 e4 94 00 	movdqa 0x94e4(%rip),%xmm6        # f0c0 <_IO_stdin_used+0xc0>
    5bdb:	00 
    5bdc:	66 0f 6f 3d ec 94 00 	movdqa 0x94ec(%rip),%xmm7        # f0d0 <_IO_stdin_used+0xd0>
    5be3:	00 
    5be4:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    5be9:	e9 27 fc ff ff       	jmp    5815 <fwp_gc_sweep+0xd5>
    5bee:	4a 8d 14 20          	lea    (%rax,%r12,1),%rdx
    5bf2:	44 89 f6             	mov    %r14d,%esi
    5bf5:	83 e6 fc             	and    $0xfffffffc,%esi
    5bf8:	31 c9                	xor    %ecx,%ecx
    5bfa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    5c00:	c6 02 00             	movb   $0x0,(%rdx)
    5c03:	c6 82 28 12 00 00 00 	movb   $0x0,0x1228(%rdx)
    5c0a:	c6 82 50 24 00 00 00 	movb   $0x0,0x2450(%rdx)
    5c11:	c6 82 78 36 00 00 00 	movb   $0x0,0x3678(%rdx)
    5c18:	48 83 c1 04          	add    $0x4,%rcx
    5c1c:	48 81 c2 a0 48 00 00 	add    $0x48a0,%rdx
    5c23:	48 39 ce             	cmp    %rcx,%rsi
    5c26:	75 d8                	jne    5c00 <fwp_gc_sweep+0x4c0>
    5c28:	44 89 f2             	mov    %r14d,%edx
    5c2b:	83 e2 03             	and    $0x3,%edx
    5c2e:	74 30                	je     5c60 <fwp_gc_sweep+0x520>
    5c30:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    5c37:	4c 01 e1             	add    %r12,%rcx
    5c3a:	48 01 c8             	add    %rcx,%rax
    5c3d:	48 69 ca 28 12 00 00 	imul   $0x1228,%rdx,%rcx
    5c44:	31 d2                	xor    %edx,%edx
    5c46:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    5c4d:	00 00 00 
    5c50:	c6 04 10 00          	movb   $0x0,(%rax,%rdx,1)
    5c54:	48 81 c2 28 12 00 00 	add    $0x1228,%rdx
    5c5b:	48 39 d1             	cmp    %rdx,%rcx
    5c5e:	75 f0                	jne    5c50 <fwp_gc_sweep+0x510>
    5c60:	4d 01 f7             	add    %r14,%r15
    5c63:	4c 01 f3             	add    %r14,%rbx
    5c66:	48 ff cb             	dec    %rbx
    5c69:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    5c70:	55 55 55 
    5c73:	e9 9d fb ff ff       	jmp    5815 <fwp_gc_sweep+0xd5>
    5c78:	31 c0                	xor    %eax,%eax
    5c7a:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    5c7f:	31 c0                	xor    %eax,%eax
    5c81:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    5c86:	48 89 15 d3 07 01 00 	mov    %rdx,0x107d3(%rip)        # 16460 <fwp_gc+0x11c8>
    5c8d:	4c 89 3d e4 07 01 00 	mov    %r15,0x107e4(%rip)        # 16478 <fwp_gc+0x11e0>
    5c94:	48 81 fa 01 00 00 01 	cmp    $0x1000001,%rdx
    5c9b:	b9 00 00 00 01       	mov    $0x1000000,%ecx
    5ca0:	48 0f 43 ca          	cmovae %rdx,%rcx
    5ca4:	48 c1 e9 10          	shr    $0x10,%rcx
    5ca8:	66 0f ef c0          	pxor   %xmm0,%xmm0
    5cac:	f3 0f 7f 05 4c 06 01 	movdqu %xmm0,0x1064c(%rip)        # 16300 <fwp_gc+0x1068>
    5cb3:	00 
    5cb4:	49 29 cf             	sub    %rcx,%r15
    5cb7:	0f 86 01 01 00 00    	jbe    5dbe <fwp_gc_sweep+0x67e>
    5cbd:	48 85 c0             	test   %rax,%rax
    5cc0:	0f 84 f8 00 00 00    	je     5dbe <fwp_gc_sweep+0x67e>
    5cc6:	4d 85 ff             	test   %r15,%r15
    5cc9:	0f 84 ef 00 00 00    	je     5dbe <fwp_gc_sweep+0x67e>
    5ccf:	48 8b 0d 3a 06 01 00 	mov    0x1063a(%rip),%rcx        # 16310 <fwp_gc+0x1078>
    5cd6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    5cdd:	00 00 00 
    5ce0:	48 8d 58 ff          	lea    -0x1(%rax),%rbx
    5ce4:	48 69 d3 28 12 00 00 	imul   $0x1228,%rbx,%rdx
    5ceb:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
    5cef:	0f 85 b8 00 00 00    	jne    5dad <fwp_gc_sweep+0x66d>
    5cf5:	4c 89 ff             	mov    %r15,%rdi
    5cf8:	49 ff cf             	dec    %r15
    5cfb:	80 7c 11 04 00       	cmpb   $0x0,0x4(%rcx,%rdx,1)
    5d00:	0f 84 a7 00 00 00    	je     5dad <fwp_gc_sweep+0x66d>
    5d06:	48 01 ca             	add    %rcx,%rdx
    5d09:	48 83 c2 04          	add    $0x4,%rdx
    5d0d:	c6 02 00             	movb   $0x0,(%rdx)
    5d10:	41 be 01 00 00 00    	mov    $0x1,%r14d
    5d16:	48 85 db             	test   %rbx,%rbx
    5d19:	74 6f                	je     5d8a <fwp_gc_sweep+0x64a>
    5d1b:	4d 85 ff             	test   %r15,%r15
    5d1e:	74 6a                	je     5d8a <fwp_gc_sweep+0x64a>
    5d20:	ba 02 00 00 00       	mov    $0x2,%edx
    5d25:	48 29 c2             	sub    %rax,%rdx
    5d28:	48 69 c0 28 12 00 00 	imul   $0x1228,%rax,%rax
    5d2f:	48 01 c1             	add    %rax,%rcx
    5d32:	48 81 c1 b4 db ff ff 	add    $0xffffffffffffdbb4,%rcx
    5d39:	be 02 00 00 00       	mov    $0x2,%esi
    5d3e:	48 29 fe             	sub    %rdi,%rsi
    5d41:	b8 01 00 00 00       	mov    $0x1,%eax
    5d46:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    5d4d:	00 00 00 
    5d50:	80 79 fc 00          	cmpb   $0x0,-0x4(%rcx)
    5d54:	75 31                	jne    5d87 <fwp_gc_sweep+0x647>
    5d56:	80 39 00             	cmpb   $0x0,(%rcx)
    5d59:	74 2c                	je     5d87 <fwp_gc_sweep+0x647>
    5d5b:	48 ff cb             	dec    %rbx
    5d5e:	48 8d 3c 02          	lea    (%rdx,%rax,1),%rdi
    5d62:	49 ff cf             	dec    %r15
    5d65:	c6 01 00             	movb   $0x0,(%rcx)
    5d68:	4c 8d 70 01          	lea    0x1(%rax),%r14
    5d6c:	48 83 ff 01          	cmp    $0x1,%rdi
    5d70:	74 18                	je     5d8a <fwp_gc_sweep+0x64a>
    5d72:	48 01 f0             	add    %rsi,%rax
    5d75:	48 81 c1 d8 ed ff ff 	add    $0xffffffffffffedd8,%rcx
    5d7c:	48 83 f8 01          	cmp    $0x1,%rax
    5d80:	4c 89 f0             	mov    %r14,%rax
    5d83:	75 cb                	jne    5d50 <fwp_gc_sweep+0x610>
    5d85:	eb 03                	jmp    5d8a <fwp_gc_sweep+0x64a>
    5d87:	49 89 c6             	mov    %rax,%r14
    5d8a:	48 89 df             	mov    %rbx,%rdi
    5d8d:	e8 3e e4 ff ff       	call   41d0 <fwp_gc_chunk_addr>
    5d92:	49 c1 e6 10          	shl    $0x10,%r14
    5d96:	48 89 c7             	mov    %rax,%rdi
    5d99:	4c 89 f6             	mov    %r14,%rsi
    5d9c:	ba 04 00 00 00       	mov    $0x4,%edx
    5da1:	e8 4a d6 ff ff       	call   33f0 <madvise@plt>
    5da6:	48 8b 0d 63 05 01 00 	mov    0x10563(%rip),%rcx        # 16310 <fwp_gc+0x1078>
    5dad:	48 89 d8             	mov    %rbx,%rax
    5db0:	48 85 db             	test   %rbx,%rbx
    5db3:	74 09                	je     5dbe <fwp_gc_sweep+0x67e>
    5db5:	4d 85 ff             	test   %r15,%r15
    5db8:	0f 85 22 ff ff ff    	jne    5ce0 <fwp_gc_sweep+0x5a0>
    5dbe:	48 83 c4 28          	add    $0x28,%rsp
    5dc2:	5b                   	pop    %rbx
    5dc3:	41 5c                	pop    %r12
    5dc5:	41 5d                	pop    %r13
    5dc7:	41 5e                	pop    %r14
    5dc9:	41 5f                	pop    %r15
    5dcb:	5d                   	pop    %rbp
    5dcc:	c3                   	ret
    5dcd:	0f 1f 00             	nopl   (%rax)

0000000000005dd0 <fwp_gc_scan_stacks>:
    5dd0:	48 8b 35 49 05 01 00 	mov    0x10549(%rip),%rsi        # 16320 <fwp_gc+0x1088>
    5dd7:	e9 04 01 00 00       	jmp    5ee0 <fwp_gc_scan_root>
    5ddc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000005de0 <fwp_gc_sp>:
    5de0:	55                   	push   %rbp
    5de1:	48 89 e5             	mov    %rsp,%rbp
    5de4:	48 89 e8             	mov    %rbp,%rax
    5de7:	5d                   	pop    %rbp
    5de8:	c3                   	ret
    5de9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000005df0 <fwp_gc_drain>:
    5df0:	48 8b 05 41 06 01 00 	mov    0x10641(%rip),%rax        # 16438 <fwp_gc+0x11a0>
    5df7:	48 85 c0             	test   %rax,%rax
    5dfa:	74 3c                	je     5e38 <fwp_gc_drain+0x48>
    5dfc:	50                   	push   %rax
    5dfd:	0f 1f 00             	nopl   (%rax)
    5e00:	48 8b 0d 29 06 01 00 	mov    0x10629(%rip),%rcx        # 16430 <fwp_gc+0x1198>
    5e07:	48 ff c8             	dec    %rax
    5e0a:	48 89 05 27 06 01 00 	mov    %rax,0x10627(%rip)        # 16438 <fwp_gc+0x11a0>
    5e11:	48 c1 e0 04          	shl    $0x4,%rax
    5e15:	48 8b 3c 01          	mov    (%rcx,%rax,1),%rdi
    5e19:	48 8b 74 01 08       	mov    0x8(%rcx,%rax,1),%rsi
    5e1e:	48 01 fe             	add    %rdi,%rsi
    5e21:	31 d2                	xor    %edx,%edx
    5e23:	e8 e8 00 00 00       	call   5f10 <fwp_gc_scan>
    5e28:	48 8b 05 09 06 01 00 	mov    0x10609(%rip),%rax        # 16438 <fwp_gc+0x11a0>
    5e2f:	48 85 c0             	test   %rax,%rax
    5e32:	75 cc                	jne    5e00 <fwp_gc_drain+0x10>
    5e34:	48 83 c4 08          	add    $0x8,%rsp
    5e38:	c3                   	ret
    5e39:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000005e40 <fwp_gc_scan_data>:
    5e40:	83 3d e1 05 01 00 00 	cmpl   $0x0,0x105e1(%rip)        # 16428 <fwp_gc+0x1190>
    5e47:	0f 8e 87 00 00 00    	jle    5ed4 <fwp_gc_scan_data+0x94>
    5e4d:	41 57                	push   %r15
    5e4f:	41 56                	push   %r14
    5e51:	41 55                	push   %r13
    5e53:	41 54                	push   %r12
    5e55:	53                   	push   %rbx
    5e56:	4c 8d 25 d3 04 01 00 	lea    0x104d3(%rip),%r12        # 16330 <fwp_gc+0x1098>
    5e5d:	45 31 ed             	xor    %r13d,%r13d
    5e60:	48 8d 1d 31 f4 00 00 	lea    0xf431(%rip),%rbx        # 15298 <fwp_gc>
    5e67:	4c 8d 35 4a 0e 01 00 	lea    0x10e4a(%rip),%r14        # 16cb8 <fwp_po_listen>
    5e6e:	eb 1d                	jmp    5e8d <fwp_gc_scan_data+0x4d>
    5e70:	4c 89 fe             	mov    %r15,%rsi
    5e73:	31 d2                	xor    %edx,%edx
    5e75:	e8 96 00 00 00       	call   5f10 <fwp_gc_scan>
    5e7a:	49 ff c5             	inc    %r13
    5e7d:	48 63 05 a4 05 01 00 	movslq 0x105a4(%rip),%rax        # 16428 <fwp_gc+0x1190>
    5e84:	49 83 c4 10          	add    $0x10,%r12
    5e88:	49 39 c5             	cmp    %rax,%r13
    5e8b:	7d 3e                	jge    5ecb <fwp_gc_scan_data+0x8b>
    5e8d:	49 8b 7c 24 f8       	mov    -0x8(%r12),%rdi
    5e92:	49 8b 04 24          	mov    (%r12),%rax
    5e96:	4c 8d 3c 07          	lea    (%rdi,%rax,1),%r15
    5e9a:	0f 57 c0             	xorps  %xmm0,%xmm0
    5e9d:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    5ea2:	f2 0f 58 05 ee 05 01 	addsd  0x105ee(%rip),%xmm0        # 16498 <fwp_gc+0x1200>
    5ea9:	00 
    5eaa:	f2 0f 11 05 e6 05 01 	movsd  %xmm0,0x105e6(%rip)        # 16498 <fwp_gc+0x1200>
    5eb1:	00 
    5eb2:	48 39 df             	cmp    %rbx,%rdi
    5eb5:	77 b9                	ja     5e70 <fwp_gc_scan_data+0x30>
    5eb7:	4d 39 f7             	cmp    %r14,%r15
    5eba:	72 b4                	jb     5e70 <fwp_gc_scan_data+0x30>
    5ebc:	48 89 de             	mov    %rbx,%rsi
    5ebf:	31 d2                	xor    %edx,%edx
    5ec1:	e8 4a 00 00 00       	call   5f10 <fwp_gc_scan>
    5ec6:	4c 89 f7             	mov    %r14,%rdi
    5ec9:	eb a5                	jmp    5e70 <fwp_gc_scan_data+0x30>
    5ecb:	5b                   	pop    %rbx
    5ecc:	41 5c                	pop    %r12
    5ece:	41 5d                	pop    %r13
    5ed0:	41 5e                	pop    %r14
    5ed2:	41 5f                	pop    %r15
    5ed4:	c3                   	ret
    5ed5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    5edc:	00 00 00 00 

0000000000005ee0 <fwp_gc_scan_root>:
    5ee0:	48 85 ff             	test   %rdi,%rdi
    5ee3:	74 24                	je     5f09 <fwp_gc_scan_root+0x29>
    5ee5:	48 89 f0             	mov    %rsi,%rax
    5ee8:	48 29 f8             	sub    %rdi,%rax
    5eeb:	76 1c                	jbe    5f09 <fwp_gc_scan_root+0x29>
    5eed:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    5ef2:	f2 0f 58 05 9e 05 01 	addsd  0x1059e(%rip),%xmm0        # 16498 <fwp_gc+0x1200>
    5ef9:	00 
    5efa:	f2 0f 11 05 96 05 01 	movsd  %xmm0,0x10596(%rip)        # 16498 <fwp_gc+0x1200>
    5f01:	00 
    5f02:	ba 01 00 00 00       	mov    $0x1,%edx
    5f07:	eb 07                	jmp    5f10 <fwp_gc_scan>
    5f09:	c3                   	ret
    5f0a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000005f10 <fwp_gc_scan>:
    5f10:	55                   	push   %rbp
    5f11:	41 57                	push   %r15
    5f13:	41 56                	push   %r14
    5f15:	41 55                	push   %r13
    5f17:	41 54                	push   %r12
    5f19:	53                   	push   %rbx
    5f1a:	50                   	push   %rax
    5f1b:	49 89 ff             	mov    %rdi,%r15
    5f1e:	49 83 c7 07          	add    $0x7,%r15
    5f22:	49 83 e7 f8          	and    $0xfffffffffffffff8,%r15
    5f26:	49 8d 47 08          	lea    0x8(%r15),%rax
    5f2a:	48 39 f0             	cmp    %rsi,%rax
    5f2d:	76 0f                	jbe    5f3e <fwp_gc_scan+0x2e>
    5f2f:	48 83 c4 08          	add    $0x8,%rsp
    5f33:	5b                   	pop    %rbx
    5f34:	41 5c                	pop    %r12
    5f36:	41 5d                	pop    %r13
    5f38:	41 5e                	pop    %r14
    5f3a:	41 5f                	pop    %r15
    5f3c:	5d                   	pop    %rbp
    5f3d:	c3                   	ret
    5f3e:	89 d3                	mov    %edx,%ebx
    5f40:	49 89 f6             	mov    %rsi,%r14
    5f43:	4c 8b 2d 7e 03 01 00 	mov    0x1037e(%rip),%r13        # 162c8 <fwp_gc+0x1030>
    5f4a:	48 8b 2d 9f 03 01 00 	mov    0x1039f(%rip),%rbp        # 162f0 <fwp_gc+0x1058>
    5f51:	48 c1 e5 10          	shl    $0x10,%rbp
    5f55:	eb 30                	jmp    5f87 <fwp_gc_scan+0x77>
    5f57:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    5f5e:	00 00 
    5f60:	4c 89 e7             	mov    %r12,%rdi
    5f63:	e8 38 00 00 00       	call   5fa0 <fwp_gc_mark>
    5f68:	85 db                	test   %ebx,%ebx
    5f6a:	74 0b                	je     5f77 <fwp_gc_scan+0x67>
    5f6c:	49 ff cc             	dec    %r12
    5f6f:	4c 89 e7             	mov    %r12,%rdi
    5f72:	e8 29 00 00 00       	call   5fa0 <fwp_gc_mark>
    5f77:	49 8d 47 08          	lea    0x8(%r15),%rax
    5f7b:	49 83 c7 10          	add    $0x10,%r15
    5f7f:	4d 39 f7             	cmp    %r14,%r15
    5f82:	49 89 c7             	mov    %rax,%r15
    5f85:	77 a8                	ja     5f2f <fwp_gc_scan+0x1f>
    5f87:	4d 8b 27             	mov    (%r15),%r12
    5f8a:	4c 89 e0             	mov    %r12,%rax
    5f8d:	4c 29 e8             	sub    %r13,%rax
    5f90:	48 39 e8             	cmp    %rbp,%rax
    5f93:	72 cb                	jb     5f60 <fwp_gc_scan+0x50>
    5f95:	85 db                	test   %ebx,%ebx
    5f97:	74 de                	je     5f77 <fwp_gc_scan+0x67>
    5f99:	48 39 e8             	cmp    %rbp,%rax
    5f9c:	74 ce                	je     5f6c <fwp_gc_scan+0x5c>
    5f9e:	eb d7                	jmp    5f77 <fwp_gc_scan+0x67>

0000000000005fa0 <fwp_gc_mark>:
    5fa0:	41 56                	push   %r14
    5fa2:	53                   	push   %rbx
    5fa3:	50                   	push   %rax
    5fa4:	49 89 fe             	mov    %rdi,%r14
    5fa7:	48 89 e6             	mov    %rsp,%rsi
    5faa:	e8 d1 00 00 00       	call   6080 <fwp_gc_chunk_of>
    5faf:	48 85 c0             	test   %rax,%rax
    5fb2:	0f 84 98 00 00 00    	je     6050 <fwp_gc_mark+0xb0>
    5fb8:	0f b6 08             	movzbl (%rax),%ecx
    5fbb:	83 f9 03             	cmp    $0x3,%ecx
    5fbe:	74 6b                	je     602b <fwp_gc_mark+0x8b>
    5fc0:	83 f9 02             	cmp    $0x2,%ecx
    5fc3:	74 7b                	je     6040 <fwp_gc_mark+0xa0>
    5fc5:	83 f9 01             	cmp    $0x1,%ecx
    5fc8:	0f 85 82 00 00 00    	jne    6050 <fwp_gc_mark+0xb0>
    5fce:	8b 58 08             	mov    0x8(%rax),%ebx
    5fd1:	41 0f b7 ce          	movzwl %r14w,%ecx
    5fd5:	48 89 c6             	mov    %rax,%rsi
    5fd8:	89 c8                	mov    %ecx,%eax
    5fda:	31 d2                	xor    %edx,%edx
    5fdc:	f7 f3                	div    %ebx
    5fde:	41 89 c6             	mov    %eax,%r14d
    5fe1:	3b 46 0c             	cmp    0xc(%rsi),%eax
    5fe4:	73 6a                	jae    6050 <fwp_gc_mark+0xb0>
    5fe6:	48 89 f0             	mov    %rsi,%rax
    5fe9:	ba 01 00 00 00       	mov    $0x1,%edx
    5fee:	44 89 f1             	mov    %r14d,%ecx
    5ff1:	48 d3 e2             	shl    %cl,%rdx
    5ff4:	44 89 f1             	mov    %r14d,%ecx
    5ff7:	c1 e9 06             	shr    $0x6,%ecx
    5ffa:	48 8b 74 ce 28       	mov    0x28(%rsi,%rcx,8),%rsi
    5fff:	4c 0f a3 f6          	bt     %r14,%rsi
    6003:	72 4b                	jb     6050 <fwp_gc_mark+0xb0>
    6005:	48 09 d6             	or     %rdx,%rsi
    6008:	48 89 74 c8 28       	mov    %rsi,0x28(%rax,%rcx,8)
    600d:	80 78 01 01          	cmpb   $0x1,0x1(%rax)
    6011:	74 3d                	je     6050 <fwp_gc_mark+0xb0>
    6013:	48 8b 3c 24          	mov    (%rsp),%rdi
    6017:	e8 b4 e1 ff ff       	call   41d0 <fwp_gc_chunk_addr>
    601c:	4c 0f af f3          	imul   %rbx,%r14
    6020:	49 01 c6             	add    %rax,%r14
    6023:	4c 89 f7             	mov    %r14,%rdi
    6026:	48 89 de             	mov    %rbx,%rsi
    6029:	eb 40                	jmp    606b <fwp_gc_mark+0xcb>
    602b:	8b 40 10             	mov    0x10(%rax),%eax
    602e:	48 89 04 24          	mov    %rax,(%rsp)
    6032:	48 69 c0 28 12 00 00 	imul   $0x1228,%rax,%rax
    6039:	48 03 05 d0 02 01 00 	add    0x102d0(%rip),%rax        # 16310 <fwp_gc+0x1078>
    6040:	80 78 03 00          	cmpb   $0x0,0x3(%rax)
    6044:	75 0a                	jne    6050 <fwp_gc_mark+0xb0>
    6046:	c6 40 03 01          	movb   $0x1,0x3(%rax)
    604a:	80 78 01 01          	cmpb   $0x1,0x1(%rax)
    604e:	75 08                	jne    6058 <fwp_gc_mark+0xb8>
    6050:	48 83 c4 08          	add    $0x8,%rsp
    6054:	5b                   	pop    %rbx
    6055:	41 5e                	pop    %r14
    6057:	c3                   	ret
    6058:	48 8b 3c 24          	mov    (%rsp),%rdi
    605c:	48 89 c3             	mov    %rax,%rbx
    605f:	e8 6c e1 ff ff       	call   41d0 <fwp_gc_chunk_addr>
    6064:	48 8b 73 18          	mov    0x18(%rbx),%rsi
    6068:	48 89 c7             	mov    %rax,%rdi
    606b:	48 83 c4 08          	add    $0x8,%rsp
    606f:	5b                   	pop    %rbx
    6070:	41 5e                	pop    %r14
    6072:	eb 3c                	jmp    60b0 <fwp_gc_push>
    6074:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    607b:	00 00 00 00 00 

0000000000006080 <fwp_gc_chunk_of>:
    6080:	48 2b 3d 41 02 01 00 	sub    0x10241(%rip),%rdi        # 162c8 <fwp_gc+0x1030>
    6087:	48 8b 05 62 02 01 00 	mov    0x10262(%rip),%rax        # 162f0 <fwp_gc+0x1058>
    608e:	48 c1 e0 10          	shl    $0x10,%rax
    6092:	48 39 c7             	cmp    %rax,%rdi
    6095:	73 16                	jae    60ad <fwp_gc_chunk_of+0x2d>
    6097:	48 c1 ef 10          	shr    $0x10,%rdi
    609b:	48 89 3e             	mov    %rdi,(%rsi)
    609e:	48 69 c7 28 12 00 00 	imul   $0x1228,%rdi,%rax
    60a5:	48 03 05 64 02 01 00 	add    0x10264(%rip),%rax        # 16310 <fwp_gc+0x1078>
    60ac:	c3                   	ret
    60ad:	31 c0                	xor    %eax,%eax
    60af:	c3                   	ret

00000000000060b0 <fwp_gc_push>:
    60b0:	41 56                	push   %r14
    60b2:	53                   	push   %rbx
    60b3:	50                   	push   %rax
    60b4:	48 89 f3             	mov    %rsi,%rbx
    60b7:	49 89 fe             	mov    %rdi,%r14
    60ba:	48 8b 0d 77 03 01 00 	mov    0x10377(%rip),%rcx        # 16438 <fwp_gc+0x11a0>
    60c1:	48 8b 05 68 03 01 00 	mov    0x10368(%rip),%rax        # 16430 <fwp_gc+0x1198>
    60c8:	48 3b 0d 71 03 01 00 	cmp    0x10371(%rip),%rcx        # 16440 <fwp_gc+0x11a8>
    60cf:	75 36                	jne    6107 <fwp_gc_push+0x57>
    60d1:	48 8d 14 09          	lea    (%rcx,%rcx,1),%rdx
    60d5:	48 85 c9             	test   %rcx,%rcx
    60d8:	be 00 10 00 00       	mov    $0x1000,%esi
    60dd:	48 0f 45 f2          	cmovne %rdx,%rsi
    60e1:	48 89 35 58 03 01 00 	mov    %rsi,0x10358(%rip)        # 16440 <fwp_gc+0x11a8>
    60e8:	48 c1 e6 04          	shl    $0x4,%rsi
    60ec:	48 89 c7             	mov    %rax,%rdi
    60ef:	e8 8c d2 ff ff       	call   3380 <realloc@plt>
    60f4:	48 89 05 35 03 01 00 	mov    %rax,0x10335(%rip)        # 16430 <fwp_gc+0x1198>
    60fb:	48 85 c0             	test   %rax,%rax
    60fe:	74 29                	je     6129 <fwp_gc_push+0x79>
    6100:	48 8b 0d 31 03 01 00 	mov    0x10331(%rip),%rcx        # 16438 <fwp_gc+0x11a0>
    6107:	48 89 ca             	mov    %rcx,%rdx
    610a:	48 c1 e2 04          	shl    $0x4,%rdx
    610e:	4c 89 34 10          	mov    %r14,(%rax,%rdx,1)
    6112:	48 89 5c 10 08       	mov    %rbx,0x8(%rax,%rdx,1)
    6117:	48 ff c1             	inc    %rcx
    611a:	48 89 0d 17 03 01 00 	mov    %rcx,0x10317(%rip)        # 16438 <fwp_gc+0x11a0>
    6121:	48 83 c4 08          	add    $0x8,%rsp
    6125:	5b                   	pop    %rbx
    6126:	41 5e                	pop    %r14
    6128:	c3                   	ret
    6129:	e8 02 ec ff ff       	call   4d30 <fwp_gc_oom>
    612e:	66 90                	xchg   %ax,%ax

0000000000006130 <fwp_gc_marked>:
    6130:	53                   	push   %rbx
    6131:	48 83 ec 10          	sub    $0x10,%rsp
    6135:	48 89 fb             	mov    %rdi,%rbx
    6138:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    613d:	e8 3e ff ff ff       	call   6080 <fwp_gc_chunk_of>
    6142:	48 85 c0             	test   %rax,%rax
    6145:	74 36                	je     617d <fwp_gc_marked+0x4d>
    6147:	0f b6 08             	movzbl (%rax),%ecx
    614a:	80 f9 03             	cmp    $0x3,%cl
    614d:	75 19                	jne    6168 <fwp_gc_marked+0x38>
    614f:	48 8b 0d ba 01 01 00 	mov    0x101ba(%rip),%rcx        # 16310 <fwp_gc+0x1078>
    6156:	8b 40 10             	mov    0x10(%rax),%eax
    6159:	48 69 d0 28 12 00 00 	imul   $0x1228,%rax,%rdx
    6160:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    6164:	0f b6 0c 11          	movzbl (%rcx,%rdx,1),%ecx
    6168:	80 f9 01             	cmp    $0x1,%cl
    616b:	74 17                	je     6184 <fwp_gc_marked+0x54>
    616d:	0f b6 d1             	movzbl %cl,%edx
    6170:	31 c9                	xor    %ecx,%ecx
    6172:	83 fa 02             	cmp    $0x2,%edx
    6175:	75 33                	jne    61aa <fwp_gc_marked+0x7a>
    6177:	0f b6 48 03          	movzbl 0x3(%rax),%ecx
    617b:	eb 2d                	jmp    61aa <fwp_gc_marked+0x7a>
    617d:	b9 01 00 00 00       	mov    $0x1,%ecx
    6182:	eb 26                	jmp    61aa <fwp_gc_marked+0x7a>
    6184:	0f b7 cb             	movzwl %bx,%ecx
    6187:	48 89 c6             	mov    %rax,%rsi
    618a:	89 c8                	mov    %ecx,%eax
    618c:	31 d2                	xor    %edx,%edx
    618e:	f7 76 08             	divl   0x8(%rsi)
    6191:	89 c1                	mov    %eax,%ecx
    6193:	c1 e9 03             	shr    $0x3,%ecx
    6196:	81 e1 f8 1f 00 00    	and    $0x1ff8,%ecx
    619c:	48 8b 54 0e 28       	mov    0x28(%rsi,%rcx,1),%rdx
    61a1:	31 c9                	xor    %ecx,%ecx
    61a3:	48 0f a3 c2          	bt     %rax,%rdx
    61a7:	0f 92 c1             	setb   %cl
    61aa:	89 c8                	mov    %ecx,%eax
    61ac:	48 83 c4 10          	add    $0x10,%rsp
    61b0:	5b                   	pop    %rbx
    61b1:	c3                   	ret
    61b2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    61b9:	1f 84 00 00 00 00 00 

00000000000061c0 <fwp_rc_clear_chunk>:
    61c0:	41 57                	push   %r15
    61c2:	41 56                	push   %r14
    61c4:	53                   	push   %rbx
    61c5:	48 89 fb             	mov    %rdi,%rbx
    61c8:	48 83 3d e0 0a 01 00 	cmpq   $0x0,0x10ae0(%rip)        # 16cb0 <fwp_gc+0x1a18>
    61cf:	00 
    61d0:	74 2c                	je     61fe <fwp_rc_clear_chunk+0x3e>
    61d2:	4c 8d b3 28 02 00 00 	lea    0x228(%rbx),%r14
    61d9:	45 31 ff             	xor    %r15d,%r15d
    61dc:	eb 0e                	jmp    61ec <fwp_rc_clear_chunk+0x2c>
    61de:	66 90                	xchg   %ax,%ax
    61e0:	49 ff c7             	inc    %r15
    61e3:	49 81 ff 00 10 00 00 	cmp    $0x1000,%r15
    61ea:	74 12                	je     61fe <fwp_rc_clear_chunk+0x3e>
    61ec:	43 80 3c 3e ff       	cmpb   $0xff,(%r14,%r15,1)
    61f1:	75 ed                	jne    61e0 <fwp_rc_clear_chunk+0x20>
    61f3:	4b 8d 3c 3e          	lea    (%r14,%r15,1),%rdi
    61f7:	e8 e4 df ff ff       	call   41e0 <fwp_rc_forget_slot>
    61fc:	eb e2                	jmp    61e0 <fwp_rc_clear_chunk+0x20>
    61fe:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    6205:	ba 00 10 00 00       	mov    $0x1000,%edx
    620a:	48 89 df             	mov    %rbx,%rdi
    620d:	31 f6                	xor    %esi,%esi
    620f:	5b                   	pop    %rbx
    6210:	41 5e                	pop    %r14
    6212:	41 5f                	pop    %r15
    6214:	e9 f7 cf ff ff       	jmp    3210 <memset@plt>
    6219:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000006220 <f1>:
    6220:	53                   	push   %rbx
    6221:	48 83 ec 30          	sub    $0x30,%rsp
    6225:	e8 86 00 00 00       	call   62b0 <fwp_f32>
    622a:	e8 61 00 00 00       	call   6290 <w1>
    622f:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    6234:	f3 0f 11 4c 24 04    	movss  %xmm1,0x4(%rsp)
    623a:	e8 81 00 00 00       	call   62c0 <fwp_from_f32>
    623f:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    6244:	0f 28 44 24 20       	movaps 0x20(%rsp),%xmm0
    6249:	0f c6 c0 55          	shufps $0x55,%xmm0,%xmm0
    624d:	e8 6e 00 00 00       	call   62c0 <fwp_from_f32>
    6252:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    6257:	f3 0f 10 44 24 04    	movss  0x4(%rsp),%xmm0
    625d:	e8 5e 00 00 00       	call   62c0 <fwp_from_f32>
    6262:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    6267:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    626c:	bf 03 00 00 00       	mov    $0x3,%edi
    6271:	e8 ea e0 ff ff       	call   4360 <fwp_record>
    6276:	48 89 c3             	mov    %rax,%rbx
    6279:	48 89 c7             	mov    %rax,%rdi
    627c:	e8 9f e0 ff ff       	call   4320 <fwp_rc_fresh>
    6281:	48 89 d8             	mov    %rbx,%rax
    6284:	48 83 c4 30          	add    $0x30,%rsp
    6288:	5b                   	pop    %rbx
    6289:	c3                   	ret
    628a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000006290 <w1>:
    6290:	50                   	push   %rax
    6291:	e8 2a 00 00 00       	call   62c0 <fwp_from_f32>
    6296:	48 89 c7             	mov    %rax,%rdi
    6299:	e8 12 00 00 00       	call   62b0 <fwp_f32>
    629e:	0f 28 d0             	movaps %xmm0,%xmm2
    62a1:	0f c6 d0 00          	shufps $0x0,%xmm0,%xmm2
    62a5:	0f 28 c8             	movaps %xmm0,%xmm1
    62a8:	0f 28 c2             	movaps %xmm2,%xmm0
    62ab:	58                   	pop    %rax
    62ac:	c3                   	ret
    62ad:	0f 1f 00             	nopl   (%rax)

00000000000062b0 <fwp_f32>:
    62b0:	66 0f 6e c7          	movd   %edi,%xmm0
    62b4:	c3                   	ret
    62b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    62bc:	00 00 00 00 

00000000000062c0 <fwp_from_f32>:
    62c0:	66 0f 7e c0          	movd   %xmm0,%eax
    62c4:	c3                   	ret
    62c5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    62cc:	00 00 00 00 

00000000000062d0 <f3>:
    62d0:	53                   	push   %rbx
    62d1:	48 83 ec 30          	sub    $0x30,%rsp
    62d5:	e8 36 e0 ff ff       	call   4310 <fwp_f64>
    62da:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    62df:	e8 5c 00 00 00       	call   6340 <w3>
    62e4:	f2 0f 10 44 24 18    	movsd  0x18(%rsp),%xmm0
    62ea:	e8 81 e0 ff ff       	call   4370 <fwp_from_f64>
    62ef:	48 89 04 24          	mov    %rax,(%rsp)
    62f3:	f2 0f 10 44 24 20    	movsd  0x20(%rsp),%xmm0
    62f9:	e8 72 e0 ff ff       	call   4370 <fwp_from_f64>
    62fe:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    6303:	f2 0f 10 44 24 28    	movsd  0x28(%rsp),%xmm0
    6309:	e8 62 e0 ff ff       	call   4370 <fwp_from_f64>
    630e:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    6313:	48 89 e6             	mov    %rsp,%rsi
    6316:	bf 03 00 00 00       	mov    $0x3,%edi
    631b:	e8 40 e0 ff ff       	call   4360 <fwp_record>
    6320:	48 89 c3             	mov    %rax,%rbx
    6323:	48 89 c7             	mov    %rax,%rdi
    6326:	e8 f5 df ff ff       	call   4320 <fwp_rc_fresh>
    632b:	48 89 d8             	mov    %rbx,%rax
    632e:	48 83 c4 30          	add    $0x30,%rsp
    6332:	5b                   	pop    %rbx
    6333:	c3                   	ret
    6334:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    633b:	00 00 00 00 00 

0000000000006340 <w3>:
    6340:	41 57                	push   %r15
    6342:	41 56                	push   %r14
    6344:	41 54                	push   %r12
    6346:	53                   	push   %rbx
    6347:	50                   	push   %rax
    6348:	48 89 fb             	mov    %rdi,%rbx
    634b:	e8 20 e0 ff ff       	call   4370 <fwp_from_f64>
    6350:	49 89 c6             	mov    %rax,%r14
    6353:	48 bf 00 00 00 00 00 	movabs $0x3fd0000000000000,%rdi
    635a:	00 d0 3f 
    635d:	48 89 c6             	mov    %rax,%rsi
    6360:	e8 4b 00 00 00       	call   63b0 <f6>
    6365:	49 89 c7             	mov    %rax,%r15
    6368:	4c 89 f7             	mov    %r14,%rdi
    636b:	e8 70 00 00 00       	call   63e0 <f10>
    6370:	49 89 c4             	mov    %rax,%r12
    6373:	4c 89 f7             	mov    %r14,%rdi
    6376:	e8 95 df ff ff       	call   4310 <fwp_f64>
    637b:	f2 0f 11 03          	movsd  %xmm0,(%rbx)
    637f:	4c 89 ff             	mov    %r15,%rdi
    6382:	e8 89 df ff ff       	call   4310 <fwp_f64>
    6387:	f2 0f 11 43 08       	movsd  %xmm0,0x8(%rbx)
    638c:	4c 89 e7             	mov    %r12,%rdi
    638f:	e8 7c df ff ff       	call   4310 <fwp_f64>
    6394:	f2 0f 11 43 10       	movsd  %xmm0,0x10(%rbx)
    6399:	48 89 d8             	mov    %rbx,%rax
    639c:	48 83 c4 08          	add    $0x8,%rsp
    63a0:	5b                   	pop    %rbx
    63a1:	41 5c                	pop    %r12
    63a3:	41 5e                	pop    %r14
    63a5:	41 5f                	pop    %r15
    63a7:	c3                   	ret
    63a8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    63af:	00 

00000000000063b0 <f6>:
    63b0:	53                   	push   %rbx
    63b1:	48 83 ec 10          	sub    $0x10,%rsp
    63b5:	48 89 fb             	mov    %rdi,%rbx
    63b8:	48 89 f7             	mov    %rsi,%rdi
    63bb:	e8 50 df ff ff       	call   4310 <fwp_f64>
    63c0:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    63c6:	48 89 df             	mov    %rbx,%rdi
    63c9:	e8 42 df ff ff       	call   4310 <fwp_f64>
    63ce:	f2 0f 58 44 24 08    	addsd  0x8(%rsp),%xmm0
    63d4:	48 83 c4 10          	add    $0x10,%rsp
    63d8:	5b                   	pop    %rbx
    63d9:	e9 92 df ff ff       	jmp    4370 <fwp_from_f64>
    63de:	66 90                	xchg   %ax,%ax

00000000000063e0 <f10>:
    63e0:	50                   	push   %rax
    63e1:	e8 2a df ff ff       	call   4310 <fwp_f64>
    63e6:	0f 57 05 f3 8c 00 00 	xorps  0x8cf3(%rip),%xmm0        # f0e0 <_IO_stdin_used+0xe0>
    63ed:	58                   	pop    %rax
    63ee:	e9 7d df ff ff       	jmp    4370 <fwp_from_f64>
    63f3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    63fa:	84 00 00 00 00 00 

0000000000006400 <f4>:
    6400:	50                   	push   %rax
    6401:	e8 0a df ff ff       	call   4310 <fwp_f64>
    6406:	e8 15 00 00 00       	call   6420 <w4>
    640b:	58                   	pop    %rax
    640c:	e9 5f df ff ff       	jmp    4370 <fwp_from_f64>
    6411:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6418:	0f 1f 84 00 00 00 00 
    641f:	00 

0000000000006420 <w4>:
    6420:	50                   	push   %rax
    6421:	e8 4a df ff ff       	call   4370 <fwp_from_f64>
    6426:	48 bf 00 00 00 00 00 	movabs $0x3fc0000000000000,%rdi
    642d:	00 c0 3f 
    6430:	48 89 c6             	mov    %rax,%rsi
    6433:	e8 78 ff ff ff       	call   63b0 <f6>
    6438:	48 89 c7             	mov    %rax,%rdi
    643b:	58                   	pop    %rax
    643c:	e9 cf de ff ff       	jmp    4310 <fwp_f64>
    6441:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6448:	0f 1f 84 00 00 00 00 
    644f:	00 

0000000000006450 <f12>:
    6450:	eb 0e                	jmp    6460 <fwp_p_array_make_typed>
    6452:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6459:	1f 84 00 00 00 00 00 

0000000000006460 <fwp_p_array_make_typed>:
    6460:	41 56                	push   %r14
    6462:	53                   	push   %rbx
    6463:	50                   	push   %rax
    6464:	48 89 f3             	mov    %rsi,%rbx
    6467:	e8 64 00 00 00       	call   64d0 <fwp_count_arg>
    646c:	49 89 c6             	mov    %rax,%r14
    646f:	48 89 c7             	mov    %rax,%rdi
    6472:	e8 69 00 00 00       	call   64e0 <fwp_array_typed_new>
    6477:	4d 85 f6             	test   %r14,%r14
    647a:	74 48                	je     64c4 <fwp_p_array_make_typed+0x64>
    647c:	49 83 fe 04          	cmp    $0x4,%r14
    6480:	73 04                	jae    6486 <fwp_p_array_make_typed+0x26>
    6482:	31 c9                	xor    %ecx,%ecx
    6484:	eb 31                	jmp    64b7 <fwp_p_array_make_typed+0x57>
    6486:	4c 89 f1             	mov    %r14,%rcx
    6489:	48 83 e1 fc          	and    $0xfffffffffffffffc,%rcx
    648d:	66 48 0f 6e c3       	movq   %rbx,%xmm0
    6492:	66 0f 70 c0 44       	pshufd $0x44,%xmm0,%xmm0
    6497:	31 d2                	xor    %edx,%edx
    6499:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    64a0:	f3 0f 7f 44 d0 08    	movdqu %xmm0,0x8(%rax,%rdx,8)
    64a6:	f3 0f 7f 44 d0 18    	movdqu %xmm0,0x18(%rax,%rdx,8)
    64ac:	48 83 c2 04          	add    $0x4,%rdx
    64b0:	48 39 d1             	cmp    %rdx,%rcx
    64b3:	75 eb                	jne    64a0 <fwp_p_array_make_typed+0x40>
    64b5:	eb 08                	jmp    64bf <fwp_p_array_make_typed+0x5f>
    64b7:	48 89 5c c8 08       	mov    %rbx,0x8(%rax,%rcx,8)
    64bc:	48 ff c1             	inc    %rcx
    64bf:	49 39 ce             	cmp    %rcx,%r14
    64c2:	75 f3                	jne    64b7 <fwp_p_array_make_typed+0x57>
    64c4:	48 83 c4 08          	add    $0x8,%rsp
    64c8:	5b                   	pop    %rbx
    64c9:	41 5e                	pop    %r14
    64cb:	c3                   	ret
    64cc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000064d0 <fwp_count_arg>:
    64d0:	31 c0                	xor    %eax,%eax
    64d2:	48 85 ff             	test   %rdi,%rdi
    64d5:	48 0f 4f c7          	cmovg  %rdi,%rax
    64d9:	c3                   	ret
    64da:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000064e0 <fwp_array_typed_new>:
    64e0:	50                   	push   %rax
    64e1:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    64e8:	ff ff 1f 
    64eb:	48 39 c7             	cmp    %rax,%rdi
    64ee:	73 0e                	jae    64fe <fwp_array_typed_new+0x1e>
    64f0:	e8 1b 00 00 00       	call   6510 <fwp_arr_new>
    64f5:	48 89 c7             	mov    %rax,%rdi
    64f8:	58                   	pop    %rax
    64f9:	e9 22 de ff ff       	jmp    4320 <fwp_rc_fresh>
    64fe:	48 8d 3d a2 94 00 00 	lea    0x94a2(%rip),%rdi        # f9a7 <exec_in_fp0+0x2a7>
    6505:	e8 76 dd ff ff       	call   4280 <fwp_trap>
    650a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000006510 <fwp_arr_new>:
    6510:	53                   	push   %rbx
    6511:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    6518:	ff ff 1f 
    651b:	48 39 c7             	cmp    %rax,%rdi
    651e:	73 15                	jae    6535 <fwp_arr_new+0x25>
    6520:	48 89 fb             	mov    %rdi,%rbx
    6523:	48 8d 3c fd 08 00 00 	lea    0x8(,%rdi,8),%rdi
    652a:	00 
    652b:	e8 20 00 00 00       	call   6550 <fwp_alloc>
    6530:	48 89 18             	mov    %rbx,(%rax)
    6533:	5b                   	pop    %rbx
    6534:	c3                   	ret
    6535:	48 8d 3d 6b 94 00 00 	lea    0x946b(%rip),%rdi        # f9a7 <exec_in_fp0+0x2a7>
    653c:	e8 3f dd ff ff       	call   4280 <fwp_trap>
    6541:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6548:	0f 1f 84 00 00 00 00 
    654f:	00 

0000000000006550 <fwp_alloc>:
    6550:	be 02 00 00 00       	mov    $0x2,%esi
    6555:	e9 e6 df ff ff       	jmp    4540 <fwp_gc_alloc>
    655a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000006560 <f14>:
    6560:	e9 fb fe ff ff       	jmp    6460 <fwp_p_array_make_typed>
    6565:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    656c:	00 00 00 00 

0000000000006570 <f16>:
    6570:	e9 eb fe ff ff       	jmp    6460 <fwp_p_array_make_typed>
    6575:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    657c:	00 00 00 00 

0000000000006580 <f18>:
    6580:	e9 db fe ff ff       	jmp    6460 <fwp_p_array_make_typed>
    6585:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    658c:	00 00 00 00 

0000000000006590 <f20>:
    6590:	e9 cb fe ff ff       	jmp    6460 <fwp_p_array_make_typed>
    6595:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    659c:	00 00 00 00 

00000000000065a0 <f22>:
    65a0:	e9 bb fe ff ff       	jmp    6460 <fwp_p_array_make_typed>
    65a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    65ac:	00 00 00 00 

00000000000065b0 <f24>:
    65b0:	e9 ab fe ff ff       	jmp    6460 <fwp_p_array_make_typed>
    65b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    65bc:	00 00 00 00 

00000000000065c0 <f26>:
    65c0:	e9 9b fe ff ff       	jmp    6460 <fwp_p_array_make_typed>
    65c5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    65cc:	00 00 00 00 

00000000000065d0 <fwp_stack_guard_init>:
    65d0:	53                   	push   %rbx
    65d1:	48 81 ec c0 00 00 00 	sub    $0xc0,%rsp
    65d8:	48 8d 44 24 0f       	lea    0xf(%rsp),%rax
    65dd:	48 89 05 24 0e 01 00 	mov    %rax,0x10e24(%rip)        # 17408 <fwp_main_stack_top>
    65e4:	48 89 3d 25 0e 01 00 	mov    %rdi,0x10e25(%rip)        # 17410 <fwp_main_stack_size>
    65eb:	48 8d 05 2e 0e 01 00 	lea    0x10e2e(%rip),%rax        # 17420 <fwp_stack_guard_init.alt>
    65f2:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    65f7:	48 c7 44 24 20 00 00 	movq   $0x10000,0x20(%rsp)
    65fe:	01 00 
    6600:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%rsp)
    6607:	00 
    6608:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    660d:	31 f6                	xor    %esi,%esi
    660f:	e8 bc ce ff ff       	call   34d0 <sigaltstack@plt>
    6614:	85 c0                	test   %eax,%eax
    6616:	0f 85 80 00 00 00    	jne    669c <fwp_stack_guard_init+0xcc>
    661c:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    6621:	0f 57 c0             	xorps  %xmm0,%xmm0
    6624:	0f 11 84 24 b0 00 00 	movups %xmm0,0xb0(%rsp)
    662b:	00 
    662c:	0f 11 84 24 a0 00 00 	movups %xmm0,0xa0(%rsp)
    6633:	00 
    6634:	0f 11 84 24 90 00 00 	movups %xmm0,0x90(%rsp)
    663b:	00 
    663c:	0f 11 84 24 80 00 00 	movups %xmm0,0x80(%rsp)
    6643:	00 
    6644:	0f 11 44 24 70       	movups %xmm0,0x70(%rsp)
    6649:	0f 11 44 24 60       	movups %xmm0,0x60(%rsp)
    664e:	0f 11 44 24 50       	movups %xmm0,0x50(%rsp)
    6653:	0f 11 44 24 40       	movups %xmm0,0x40(%rsp)
    6658:	0f 11 44 24 30       	movups %xmm0,0x30(%rsp)
    665d:	48 8d 05 7c 07 00 00 	lea    0x77c(%rip),%rax        # 6de0 <fwp_segv>
    6664:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    6669:	c7 84 24 b0 00 00 00 	movl   $0x8000004,0xb0(%rsp)
    6670:	04 00 00 08 
    6674:	e8 97 cc ff ff       	call   3310 <sigemptyset@plt>
    6679:	48 8d 5c 24 28       	lea    0x28(%rsp),%rbx
    667e:	bf 0b 00 00 00       	mov    $0xb,%edi
    6683:	48 89 de             	mov    %rbx,%rsi
    6686:	31 d2                	xor    %edx,%edx
    6688:	e8 53 ca ff ff       	call   30e0 <sigaction@plt>
    668d:	bf 07 00 00 00       	mov    $0x7,%edi
    6692:	48 89 de             	mov    %rbx,%rsi
    6695:	31 d2                	xor    %edx,%edx
    6697:	e8 44 ca ff ff       	call   30e0 <sigaction@plt>
    669c:	48 81 c4 c0 00 00 00 	add    $0xc0,%rsp
    66a3:	5b                   	pop    %rbx
    66a4:	c3                   	ret
    66a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    66ac:	00 00 00 00 

00000000000066b0 <fwp_exec>:
    66b0:	55                   	push   %rbp
    66b1:	41 57                	push   %r15
    66b3:	41 56                	push   %r14
    66b5:	41 55                	push   %r13
    66b7:	41 54                	push   %r12
    66b9:	53                   	push   %rbx
    66ba:	48 81 ec 58 01 00 00 	sub    $0x158,%rsp
    66c1:	49 89 f7             	mov    %rsi,%r15
    66c4:	41 89 fd             	mov    %edi,%r13d
    66c7:	41 8d 5d ff          	lea    -0x1(%r13),%ebx
    66cb:	80 3d 2e 0d 01 00 01 	cmpb   $0x1,0x10d2e(%rip)        # 17400 <fwp_cli_single>
    66d2:	75 16                	jne    66ea <fwp_exec+0x3a>
    66d4:	49 8d 77 08          	lea    0x8(%r15),%rsi
    66d8:	89 df                	mov    %ebx,%edi
    66da:	e8 91 07 00 00       	call   6e70 <fwp_generated>
    66df:	41 89 c6             	mov    %eax,%r14d
    66e2:	85 c0                	test   %eax,%eax
    66e4:	0f 89 1a 01 00 00    	jns    6804 <fwp_exec+0x154>
    66ea:	89 5c 24 18          	mov    %ebx,0x18(%rsp)
    66ee:	49 63 fd             	movslq %r13d,%rdi
    66f1:	48 c1 e7 03          	shl    $0x3,%rdi
    66f5:	48 89 7c 24 48       	mov    %rdi,0x48(%rsp)
    66fa:	e8 51 fe ff ff       	call   6550 <fwp_alloc>
    66ff:	49 89 c4             	mov    %rax,%r12
    6702:	41 83 fd 02          	cmp    $0x2,%r13d
    6706:	7c 30                	jl     6738 <fwp_exec+0x88>
    6708:	8b 6c 24 18          	mov    0x18(%rsp),%ebp
    670c:	31 db                	xor    %ebx,%ebx
    670e:	66 90                	xchg   %ax,%ax
    6710:	4c 8d 73 01          	lea    0x1(%rbx),%r14
    6714:	4d 8b 6c df 08       	mov    0x8(%r15,%rbx,8),%r13
    6719:	4c 89 ef             	mov    %r13,%rdi
    671c:	e8 4f ca ff ff       	call   3170 <strlen@plt>
    6721:	4c 89 ef             	mov    %r13,%rdi
    6724:	48 89 c6             	mov    %rax,%rsi
    6727:	e8 a4 08 00 00       	call   6fd0 <fwp_str_lossy>
    672c:	49 89 04 dc          	mov    %rax,(%r12,%rbx,8)
    6730:	4c 89 f3             	mov    %r14,%rbx
    6733:	4c 39 f5             	cmp    %r14,%rbp
    6736:	75 d8                	jne    6710 <fwp_exec+0x60>
    6738:	bf 08 00 00 00       	mov    $0x8,%edi
    673d:	e8 0e fe ff ff       	call   6550 <fwp_alloc>
    6742:	bf 01 00 00 00       	mov    $0x1,%edi
    6747:	e8 64 0a 00 00       	call   71b0 <fwp_alloc_leaf>
    674c:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
    6751:	e8 fa fd ff ff       	call   6550 <fwp_alloc>
    6756:	49 89 c6             	mov    %rax,%r14
    6759:	48 8d 4c 24 2c       	lea    0x2c(%rsp),%rcx
    675e:	8b 7c 24 18          	mov    0x18(%rsp),%edi
    6762:	4c 89 e6             	mov    %r12,%rsi
    6765:	48 89 c2             	mov    %rax,%rdx
    6768:	e8 53 0a 00 00       	call   71c0 <fwp_cli_parse>
    676d:	83 f8 02             	cmp    $0x2,%eax
    6770:	74 32                	je     67a4 <fwp_exec+0xf4>
    6772:	83 f8 01             	cmp    $0x1,%eax
    6775:	75 5d                	jne    67d4 <fwp_exec+0x124>
    6777:	48 8b 1d 32 e8 00 00 	mov    0xe832(%rip),%rbx        # 14fb0 <stdout@GLIBC_2.2.5>
    677e:	48 8b 0b             	mov    (%rbx),%rcx
    6781:	48 8d 3d d2 9d 00 00 	lea    0x9dd2(%rip),%rdi        # 1055a <exec_in_fp0+0xe5a>
    6788:	be 70 00 00 00       	mov    $0x70,%esi
    678d:	ba 01 00 00 00       	mov    $0x1,%edx
    6792:	e8 09 cd ff ff       	call   34a0 <fwrite@plt>
    6797:	48 8b 3b             	mov    (%rbx),%rdi
    679a:	e8 b1 cb ff ff       	call   3350 <fflush@plt>
    679f:	45 31 f6             	xor    %r14d,%r14d
    67a2:	eb 60                	jmp    6804 <fwp_exec+0x154>
    67a4:	48 8d 3d 24 9a 00 00 	lea    0x9a24(%rip),%rdi        # 101cf <exec_in_fp0+0xacf>
    67ab:	48 8d 15 43 90 00 00 	lea    0x9043(%rip),%rdx        # f7f5 <exec_in_fp0+0xf5>
    67b2:	45 31 f6             	xor    %r14d,%r14d
    67b5:	be 04 00 00 00       	mov    $0x4,%esi
    67ba:	31 c9                	xor    %ecx,%ecx
    67bc:	31 c0                	xor    %eax,%eax
    67be:	e8 fd c9 ff ff       	call   31c0 <printf@plt>
    67c3:	48 8b 05 e6 e7 00 00 	mov    0xe7e6(%rip),%rax        # 14fb0 <stdout@GLIBC_2.2.5>
    67ca:	48 8b 38             	mov    (%rax),%rdi
    67cd:	e8 7e cb ff ff       	call   3350 <fflush@plt>
    67d2:	eb 30                	jmp    6804 <fwp_exec+0x154>
    67d4:	bf 10 00 00 00       	mov    $0x10,%edi
    67d9:	e8 72 fd ff ff       	call   6550 <fwp_alloc>
    67de:	49 89 c7             	mov    %rax,%r15
    67e1:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%rsp)
    67e8:	00 
    67e9:	8b 74 24 2c          	mov    0x2c(%rsp),%esi
    67ed:	48 8d 4c 24 14       	lea    0x14(%rsp),%rcx
    67f2:	4c 89 f7             	mov    %r14,%rdi
    67f5:	48 89 c2             	mov    %rax,%rdx
    67f8:	e8 23 0c 00 00       	call   7420 <fwp_bind_positional>
    67fd:	41 89 c6             	mov    %eax,%r14d
    6800:	85 c0                	test   %eax,%eax
    6802:	74 15                	je     6819 <fwp_exec+0x169>
    6804:	44 89 f0             	mov    %r14d,%eax
    6807:	48 81 c4 58 01 00 00 	add    $0x158,%rsp
    680e:	5b                   	pop    %rbx
    680f:	41 5c                	pop    %r12
    6811:	41 5d                	pop    %r13
    6813:	41 5e                	pop    %r14
    6815:	41 5f                	pop    %r15
    6817:	5d                   	pop    %rbp
    6818:	c3                   	ret
    6819:	48 8d 3d b8 99 00 00 	lea    0x99b8(%rip),%rdi        # 101d8 <exec_in_fp0+0xad8>
    6820:	e8 0b c8 ff ff       	call   3030 <getenv@plt>
    6825:	48 85 c0             	test   %rax,%rax
    6828:	74 27                	je     6851 <fwp_exec+0x1a1>
    682a:	48 8d 35 af 99 00 00 	lea    0x99af(%rip),%rsi        # 101e0 <exec_in_fp0+0xae0>
    6831:	48 89 c7             	mov    %rax,%rdi
    6834:	e8 97 ca ff ff       	call   32d0 <strcmp@plt>
    6839:	31 c9                	xor    %ecx,%ecx
    683b:	85 c0                	test   %eax,%eax
    683d:	0f 94 c1             	sete   %cl
    6840:	89 0d da 0b 02 00    	mov    %ecx,0x20bda(%rip)        # 27420 <fwp_exec_binary_out>
    6846:	75 26                	jne    686e <fwp_exec+0x1be>
    6848:	48 8b 05 89 e7 00 00 	mov    0xe789(%rip),%rax        # 14fd8 <stderr@GLIBC_2.2.5>
    684f:	eb 24                	jmp    6875 <fwp_exec+0x1c5>
    6851:	c7 05 c5 0b 02 00 00 	movl   $0x0,0x20bc5(%rip)        # 27420 <fwp_exec_binary_out>
    6858:	00 00 00 
    685b:	48 8b 05 4e e7 00 00 	mov    0xe74e(%rip),%rax        # 14fb0 <stdout@GLIBC_2.2.5>
    6862:	48 8b 00             	mov    (%rax),%rax
    6865:	48 89 05 3c 0b 01 00 	mov    %rax,0x10b3c(%rip)        # 173a8 <fwp_prog_out>
    686c:	eb 33                	jmp    68a1 <fwp_exec+0x1f1>
    686e:	48 8b 05 3b e7 00 00 	mov    0xe73b(%rip),%rax        # 14fb0 <stdout@GLIBC_2.2.5>
    6875:	48 8b 00             	mov    (%rax),%rax
    6878:	48 89 05 29 0b 01 00 	mov    %rax,0x10b29(%rip)        # 173a8 <fwp_prog_out>
    687f:	75 20                	jne    68a1 <fwp_exec+0x1f1>
    6881:	e8 da 0b 00 00       	call   7460 <fwp_pipe_out_start>
    6886:	48 8d 3d e3 8d 00 00 	lea    0x8de3(%rip),%rdi        # f670 <exec_out_header0>
    688d:	be 8b 00 00 00       	mov    $0x8b,%esi
    6892:	e8 99 0c 00 00       	call   7530 <fwp_pipe_write>
    6897:	e8 44 0d 00 00       	call   75e0 <fwp_pipe_flush>
    689c:	e8 6f 0d 00 00       	call   7610 <fwp_pipe_out_ready>
    68a1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%rsp)
    68a8:	00 
    68a9:	83 7c 24 14 00       	cmpl   $0x0,0x14(%rsp)
    68ae:	0f 84 57 01 00 00    	je     6a0b <fwp_exec+0x35b>
    68b4:	48 8b 1d fd e6 00 00 	mov    0xe6fd(%rip),%rbx        # 14fb8 <stdin@GLIBC_2.2.5>
    68bb:	48 8b 3b             	mov    (%rbx),%rdi
    68be:	b9 00 00 10 00       	mov    $0x100000,%ecx
    68c3:	31 f6                	xor    %esi,%esi
    68c5:	31 d2                	xor    %edx,%edx
    68c7:	e8 e4 ca ff ff       	call   33b0 <setvbuf@plt>
    68cc:	48 8b 0b             	mov    (%rbx),%rcx
    68cf:	48 8d 3d 4e 0b 02 00 	lea    0x20b4e(%rip),%rdi        # 27424 <fwp_in_pend>
    68d6:	be 01 00 00 00       	mov    $0x1,%esi
    68db:	ba 04 00 00 00       	mov    $0x4,%edx
    68e0:	e8 0b c8 ff ff       	call   30f0 <fread@plt>
    68e5:	89 05 3d 0b 02 00    	mov    %eax,0x20b3d(%rip)        # 27428 <fwp_in_npend>
    68eb:	c7 05 37 0b 02 00 00 	movl   $0x0,0x20b37(%rip)        # 2742c <fwp_in_ppos>
    68f2:	00 00 00 
    68f5:	41 b4 01             	mov    $0x1,%r12b
    68f8:	83 f8 04             	cmp    $0x4,%eax
    68fb:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    6900:	0f 85 d3 01 00 00    	jne    6ad9 <fwp_exec+0x429>
    6906:	81 3d 14 0b 02 00 46 	cmpl   $0x31505746,0x20b14(%rip)        # 27424 <fwp_in_pend>
    690d:	57 50 31 
    6910:	0f 85 c3 01 00 00    	jne    6ad9 <fwp_exec+0x429>
    6916:	c7 05 0c 0b 02 00 04 	movl   $0x4,0x20b0c(%rip)        # 2742c <fwp_in_ppos>
    691d:	00 00 00 
    6920:	48 8d 7c 24 03       	lea    0x3(%rsp),%rdi
    6925:	be 01 00 00 00       	mov    $0x1,%esi
    692a:	e8 41 0e 00 00       	call   7770 <fwp_read_exact>
    692f:	85 c0                	test   %eax,%eax
    6931:	0f 84 c3 03 00 00    	je     6cfa <fwp_exec+0x64a>
    6937:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
    693c:	e8 2f 0f 00 00       	call   7870 <fwp_stdin_leb>
    6941:	83 f8 01             	cmp    $0x1,%eax
    6944:	0f 85 99 03 00 00    	jne    6ce3 <fwp_exec+0x633>
    694a:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    694f:	48 83 f8 40          	cmp    $0x40,%rax
    6953:	41 bd 40 00 00 00    	mov    $0x40,%r13d
    6959:	4c 0f 42 e8          	cmovb  %rax,%r13
    695d:	48 85 c0             	test   %rax,%rax
    6960:	0f 84 e2 00 00 00    	je     6a48 <fwp_exec+0x398>
    6966:	45 31 f6             	xor    %r14d,%r14d
    6969:	4c 8d 7c 24 50       	lea    0x50(%rsp),%r15
    696e:	31 ed                	xor    %ebp,%ebp
    6970:	eb 4a                	jmp    69bc <fwp_exec+0x30c>
    6972:	be 06 00 00 00       	mov    $0x6,%esi
    6977:	4c 89 ff             	mov    %r15,%rdi
    697a:	e8 f1 0d 00 00       	call   7770 <fwp_read_exact>
    697f:	85 c0                	test   %eax,%eax
    6981:	0f 84 73 03 00 00    	je     6cfa <fwp_exec+0x64a>
    6987:	8b 44 24 50          	mov    0x50(%rsp),%eax
    698b:	b9 55 44 53 5f       	mov    $0x5f534455,%ecx
    6990:	31 c8                	xor    %ecx,%eax
    6992:	0f b7 4c 24 54       	movzwl 0x54(%rsp),%ecx
    6997:	81 f1 56 31 00 00    	xor    $0x3156,%ecx
    699d:	09 c1                	or     %eax,%ecx
    699f:	b8 01 00 00 00       	mov    $0x1,%eax
    69a4:	0f 44 e8             	cmove  %eax,%ebp
    69a7:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
    69ae:	00 00 
    69b0:	49 ff c6             	inc    %r14
    69b3:	4d 39 ee             	cmp    %r13,%r14
    69b6:	0f 84 8e 00 00 00    	je     6a4a <fwp_exec+0x39a>
    69bc:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    69c1:	e8 2a 0f 00 00       	call   78f0 <fwp_stdin_name_len>
    69c6:	83 f8 01             	cmp    $0x1,%eax
    69c9:	0f 85 14 03 00 00    	jne    6ce3 <fwp_exec+0x633>
    69cf:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    69d4:	48 85 db             	test   %rbx,%rbx
    69d7:	74 ce                	je     69a7 <fwp_exec+0x2f7>
    69d9:	48 83 fb 06          	cmp    $0x6,%rbx
    69dd:	74 93                	je     6972 <fwp_exec+0x2c2>
    69df:	90                   	nop
    69e0:	48 81 fb 00 01 00 00 	cmp    $0x100,%rbx
    69e7:	41 bc 00 01 00 00    	mov    $0x100,%r12d
    69ed:	4c 0f 42 e3          	cmovb  %rbx,%r12
    69f1:	4c 89 ff             	mov    %r15,%rdi
    69f4:	4c 89 e6             	mov    %r12,%rsi
    69f7:	e8 74 0d 00 00       	call   7770 <fwp_read_exact>
    69fc:	85 c0                	test   %eax,%eax
    69fe:	0f 84 f6 02 00 00    	je     6cfa <fwp_exec+0x64a>
    6a04:	4c 29 e3             	sub    %r12,%rbx
    6a07:	75 d7                	jne    69e0 <fwp_exec+0x330>
    6a09:	eb 9c                	jmp    69a7 <fwp_exec+0x2f7>
    6a0b:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
    6a10:	4c 89 ff             	mov    %r15,%rdi
    6a13:	e8 98 0c 00 00       	call   76b0 <fwp_exec_call>
    6a18:	48 89 c3             	mov    %rax,%rbx
    6a1b:	48 8b 3d 86 09 01 00 	mov    0x10986(%rip),%rdi        # 173a8 <fwp_prog_out>
    6a22:	e8 29 c9 ff ff       	call   3350 <fflush@plt>
    6a27:	41 be 01 00 00 00    	mov    $0x1,%r14d
    6a2d:	83 7c 24 04 00       	cmpl   $0x0,0x4(%rsp)
    6a32:	0f 85 83 02 00 00    	jne    6cbb <fwp_exec+0x60b>
    6a38:	48 89 df             	mov    %rbx,%rdi
    6a3b:	e8 20 0d 00 00       	call   7760 <fwp_emit_result>
    6a40:	45 31 f6             	xor    %r14d,%r14d
    6a43:	e9 73 02 00 00       	jmp    6cbb <fwp_exec+0x60b>
    6a48:	31 ed                	xor    %ebp,%ebp
    6a4a:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    6a4f:	be 10 00 00 00       	mov    $0x10,%esi
    6a54:	e8 17 0d 00 00       	call   7770 <fwp_read_exact>
    6a59:	85 c0                	test   %eax,%eax
    6a5b:	0f 84 99 02 00 00    	je     6cfa <fwp_exec+0x64a>
    6a61:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    6a66:	e8 85 0e 00 00       	call   78f0 <fwp_stdin_name_len>
    6a6b:	83 f8 01             	cmp    $0x1,%eax
    6a6e:	0f 85 6f 02 00 00    	jne    6ce3 <fwp_exec+0x633>
    6a74:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    6a79:	49 8d 7f 01          	lea    0x1(%r15),%rdi
    6a7d:	e8 2e 07 00 00       	call   71b0 <fwp_alloc_leaf>
    6a82:	49 89 c6             	mov    %rax,%r14
    6a85:	4d 85 ff             	test   %r15,%r15
    6a88:	74 13                	je     6a9d <fwp_exec+0x3ed>
    6a8a:	4c 89 f7             	mov    %r14,%rdi
    6a8d:	4c 89 fe             	mov    %r15,%rsi
    6a90:	e8 db 0c 00 00       	call   7770 <fwp_read_exact>
    6a95:	85 c0                	test   %eax,%eax
    6a97:	0f 84 5d 02 00 00    	je     6cfa <fwp_exec+0x64a>
    6a9d:	43 c6 04 3e 00       	movb   $0x0,(%r14,%r15,1)
    6aa2:	0f b6 4c 24 03       	movzbl 0x3(%rsp),%ecx
    6aa7:	83 f9 01             	cmp    $0x1,%ecx
    6aaa:	0f 85 ab 02 00 00    	jne    6d5b <fwp_exec+0x6ab>
    6ab0:	66 0f 6f 44 24 30    	movdqa 0x30(%rsp),%xmm0
    6ab6:	66 0f 74 05 32 86 00 	pcmpeqb 0x8632(%rip),%xmm0        # f0f0 <_IO_stdin_used+0xf0>
    6abd:	00 
    6abe:	66 0f d7 c0          	pmovmskb %xmm0,%eax
    6ac2:	3d ff ff 00 00       	cmp    $0xffff,%eax
    6ac7:	0f 85 af 02 00 00    	jne    6d7c <fwp_exec+0x6cc>
    6acd:	85 ed                	test   %ebp,%ebp
    6acf:	74 05                	je     6ad6 <fwp_exec+0x426>
    6ad1:	e8 4a 0e 00 00       	call   7920 <fwp_pipe_in_offer>
    6ad6:	45 31 e4             	xor    %r12d,%r12d
    6ad9:	66 0f ef c0          	pxor   %xmm0,%xmm0
    6add:	66 0f 7f 44 24 50    	movdqa %xmm0,0x50(%rsp)
    6ae3:	48 c7 44 24 60 00 00 	movq   $0x0,0x60(%rsp)
    6aea:	00 00 
    6aec:	45 31 ff             	xor    %r15d,%r15d
    6aef:	45 31 f6             	xor    %r14d,%r14d
    6af2:	eb 35                	jmp    6b29 <fwp_exec+0x479>
    6af4:	48 89 ef             	mov    %rbp,%rdi
    6af7:	4c 89 ee             	mov    %r13,%rsi
    6afa:	e8 21 0f 00 00       	call   7a20 <fwp_pipe_in_switch>
    6aff:	bb 10 00 00 00       	mov    $0x10,%ebx
    6b04:	48 8d 35 51 97 00 00 	lea    0x9751(%rip),%rsi        # 1025c <exec_in_fp0+0xb5c>
    6b0b:	85 c0                	test   %eax,%eax
    6b0d:	0f 84 6b 01 00 00    	je     6c7e <fwp_exec+0x5ce>
    6b13:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6b1a:	84 00 00 00 00 00 
    6b20:	83 fb 0f             	cmp    $0xf,%ebx
    6b23:	0f 84 83 01 00 00    	je     6cac <fwp_exec+0x5fc>
    6b29:	45 84 e4             	test   %r12b,%r12b
    6b2c:	0f 84 9e 00 00 00    	je     6bd0 <fwp_exec+0x520>
    6b32:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    6b37:	e8 44 15 00 00       	call   8080 <fwp_read_text_line>
    6b3c:	4c 8b 7c 24 50       	mov    0x50(%rsp),%r15
    6b41:	85 c0                	test   %eax,%eax
    6b43:	0f 84 63 01 00 00    	je     6cac <fwp_exec+0x5fc>
    6b49:	4d 85 ff             	test   %r15,%r15
    6b4c:	4c 89 ff             	mov    %r15,%rdi
    6b4f:	48 8d 05 99 93 00 00 	lea    0x9399(%rip),%rax        # feef <exec_in_fp0+0x7ef>
    6b56:	48 0f 44 f8          	cmove  %rax,%rdi
    6b5a:	48 8b 74 24 58       	mov    0x58(%rsp),%rsi
    6b5f:	e8 6c 04 00 00       	call   6fd0 <fwp_str_lossy>
    6b64:	48 89 c5             	mov    %rax,%rbp
    6b67:	4c 8d 68 08          	lea    0x8(%rax),%r13
    6b6b:	48 8b 30             	mov    (%rax),%rsi
    6b6e:	4c 89 ef             	mov    %r13,%rdi
    6b71:	48 8d 54 24 20       	lea    0x20(%rsp),%rdx
    6b76:	e8 e5 07 00 00       	call   7360 <fwp_parse_text>
    6b7b:	85 c0                	test   %eax,%eax
    6b7d:	0f 84 a1 01 00 00    	je     6d24 <fwp_exec+0x674>
    6b83:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    6b88:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    6b8d:	48 89 07             	mov    %rax,(%rdi)
    6b90:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
    6b95:	e8 16 0b 00 00       	call   76b0 <fwp_exec_call>
    6b9a:	49 89 c5             	mov    %rax,%r13
    6b9d:	48 8b 3d 04 08 01 00 	mov    0x10804(%rip),%rdi        # 173a8 <fwp_prog_out>
    6ba4:	e8 a7 c7 ff ff       	call   3350 <fflush@plt>
    6ba9:	83 7c 24 04 00       	cmpl   $0x0,0x4(%rsp)
    6bae:	0f 85 f2 00 00 00    	jne    6ca6 <fwp_exec+0x5f6>
    6bb4:	4c 89 ef             	mov    %r13,%rdi
    6bb7:	e8 a4 0b 00 00       	call   7760 <fwp_emit_result>
    6bbc:	e8 1f 0a 00 00       	call   75e0 <fwp_pipe_flush>
    6bc1:	31 db                	xor    %ebx,%ebx
    6bc3:	e9 58 ff ff ff       	jmp    6b20 <fwp_exec+0x470>
    6bc8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6bcf:	00 
    6bd0:	be 01 00 00 00       	mov    $0x1,%esi
    6bd5:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    6bda:	e8 91 0b 00 00       	call   7770 <fwp_read_exact>
    6bdf:	bb 0f 00 00 00       	mov    $0xf,%ebx
    6be4:	85 c0                	test   %eax,%eax
    6be6:	0f 84 34 ff ff ff    	je     6b20 <fwp_exec+0x470>
    6bec:	be 04 00 00 00       	mov    $0x4,%esi
    6bf1:	48 8d 7c 24 09       	lea    0x9(%rsp),%rdi
    6bf6:	e8 75 0b 00 00       	call   7770 <fwp_read_exact>
    6bfb:	48 8d 35 45 96 00 00 	lea    0x9645(%rip),%rsi        # 10247 <exec_in_fp0+0xb47>
    6c02:	85 c0                	test   %eax,%eax
    6c04:	74 78                	je     6c7e <fwp_exec+0x5ce>
    6c06:	44 8b 6c 24 09       	mov    0x9(%rsp),%r13d
    6c0b:	49 8d 7d 01          	lea    0x1(%r13),%rdi
    6c0f:	e8 9c 05 00 00       	call   71b0 <fwp_alloc_leaf>
    6c14:	48 89 c5             	mov    %rax,%rbp
    6c17:	4d 85 ed             	test   %r13,%r13
    6c1a:	74 16                	je     6c32 <fwp_exec+0x582>
    6c1c:	48 89 ef             	mov    %rbp,%rdi
    6c1f:	4c 89 ee             	mov    %r13,%rsi
    6c22:	e8 49 0b 00 00       	call   7770 <fwp_read_exact>
    6c27:	48 8d 35 19 96 00 00 	lea    0x9619(%rip),%rsi        # 10247 <exec_in_fp0+0xb47>
    6c2e:	85 c0                	test   %eax,%eax
    6c30:	74 4c                	je     6c7e <fwp_exec+0x5ce>
    6c32:	0f b6 44 24 08       	movzbl 0x8(%rsp),%eax
    6c37:	85 c0                	test   %eax,%eax
    6c39:	0f 84 e1 fe ff ff    	je     6b20 <fwp_exec+0x470>
    6c3f:	83 f8 02             	cmp    $0x2,%eax
    6c42:	0f 84 ac fe ff ff    	je     6af4 <fwp_exec+0x444>
    6c48:	48 89 6c 24 30       	mov    %rbp,0x30(%rsp)
    6c4d:	4c 89 6c 24 38       	mov    %r13,0x38(%rsp)
    6c52:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    6c59:	00 00 
    6c5b:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    6c60:	48 8d 35 c1 00 01 00 	lea    0x100c1(%rip),%rsi        # 16d28 <d0>
    6c67:	48 8d 54 24 20       	lea    0x20(%rsp),%rdx
    6c6c:	e8 cf 0f 00 00       	call   7c40 <fwp_decode>
    6c71:	85 c0                	test   %eax,%eax
    6c73:	0f 85 0a ff ff ff    	jne    6b83 <fwp_exec+0x4d3>
    6c79:	e9 2c 01 00 00       	jmp    6daa <fwp_exec+0x6fa>
    6c7e:	48 8b 05 53 e3 00 00 	mov    0xe353(%rip),%rax        # 14fd8 <stderr@GLIBC_2.2.5>
    6c85:	48 8b 38             	mov    (%rax),%rdi
    6c88:	48 8d 15 66 8b 00 00 	lea    0x8b66(%rip),%rdx        # f7f5 <exec_in_fp0+0xf5>
    6c8f:	31 c0                	xor    %eax,%eax
    6c91:	e8 5a c6 ff ff       	call   32f0 <fprintf@plt>
    6c96:	41 be 03 00 00 00    	mov    $0x3,%r14d
    6c9c:	bb 0f 00 00 00       	mov    $0xf,%ebx
    6ca1:	e9 7a fe ff ff       	jmp    6b20 <fwp_exec+0x470>
    6ca6:	41 be 01 00 00 00    	mov    $0x1,%r14d
    6cac:	31 ff                	xor    %edi,%edi
    6cae:	e8 dd 14 00 00       	call   8190 <fwp_mem_free>
    6cb3:	4c 89 ff             	mov    %r15,%rdi
    6cb6:	e8 95 c3 ff ff       	call   3050 <free@plt>
    6cbb:	83 3d 5e 07 02 00 00 	cmpl   $0x0,0x2075e(%rip)        # 27420 <fwp_exec_binary_out>
    6cc2:	0f 84 fb fa ff ff    	je     67c3 <fwp_exec+0x113>
    6cc8:	48 8d 3d 9c 89 00 00 	lea    0x899c(%rip),%rdi        # f66b <fwp_exec.end>
    6ccf:	be 05 00 00 00       	mov    $0x5,%esi
    6cd4:	e8 57 08 00 00       	call   7530 <fwp_pipe_write>
    6cd9:	e8 92 16 00 00       	call   8370 <fwp_pipe_out_end>
    6cde:	e9 e0 fa ff ff       	jmp    67c3 <fwp_exec+0x113>
    6ce3:	85 c0                	test   %eax,%eax
    6ce5:	79 13                	jns    6cfa <fwp_exec+0x64a>
    6ce7:	48 8b 05 ea e2 00 00 	mov    0xe2ea(%rip),%rax        # 14fd8 <stderr@GLIBC_2.2.5>
    6cee:	48 8b 38             	mov    (%rax),%rdi
    6cf1:	48 8d 35 b4 95 00 00 	lea    0x95b4(%rip),%rsi        # 102ac <exec_in_fp0+0xbac>
    6cf8:	eb 11                	jmp    6d0b <fwp_exec+0x65b>
    6cfa:	48 8b 05 d7 e2 00 00 	mov    0xe2d7(%rip),%rax        # 14fd8 <stderr@GLIBC_2.2.5>
    6d01:	48 8b 38             	mov    (%rax),%rdi
    6d04:	48 8d 35 b1 95 00 00 	lea    0x95b1(%rip),%rsi        # 102bc <exec_in_fp0+0xbbc>
    6d0b:	48 8d 15 e3 8a 00 00 	lea    0x8ae3(%rip),%rdx        # f7f5 <exec_in_fp0+0xf5>
    6d12:	31 c0                	xor    %eax,%eax
    6d14:	e8 d7 c5 ff ff       	call   32f0 <fprintf@plt>
    6d19:	41 be 03 00 00 00    	mov    $0x3,%r14d
    6d1f:	e9 e0 fa ff ff       	jmp    6804 <fwp_exec+0x154>
    6d24:	48 8b 05 ad e2 00 00 	mov    0xe2ad(%rip),%rax        # 14fd8 <stderr@GLIBC_2.2.5>
    6d2b:	48 8b 38             	mov    (%rax),%rdi
    6d2e:	8b 4d 00             	mov    0x0(%rbp),%ecx
    6d31:	48 8d 35 4f 95 00 00 	lea    0x954f(%rip),%rsi        # 10287 <exec_in_fp0+0xb87>
    6d38:	48 8d 15 b6 8a 00 00 	lea    0x8ab6(%rip),%rdx        # f7f5 <exec_in_fp0+0xf5>
    6d3f:	4c 8d 0d 85 98 00 00 	lea    0x9885(%rip),%r9        # 105cb <exec_in_fp0+0xecb>
    6d46:	4d 89 e8             	mov    %r13,%r8
    6d49:	31 c0                	xor    %eax,%eax
    6d4b:	e8 a0 c5 ff ff       	call   32f0 <fprintf@plt>
    6d50:	41 be 03 00 00 00    	mov    $0x3,%r14d
    6d56:	e9 51 ff ff ff       	jmp    6cac <fwp_exec+0x5fc>
    6d5b:	48 8b 05 76 e2 00 00 	mov    0xe276(%rip),%rax        # 14fd8 <stderr@GLIBC_2.2.5>
    6d62:	48 8b 38             	mov    (%rax),%rdi
    6d65:	48 8d 35 84 94 00 00 	lea    0x9484(%rip),%rsi        # 101f0 <exec_in_fp0+0xaf0>
    6d6c:	48 8d 15 82 8a 00 00 	lea    0x8a82(%rip),%rdx        # f7f5 <exec_in_fp0+0xf5>
    6d73:	31 c0                	xor    %eax,%eax
    6d75:	e8 76 c5 ff ff       	call   32f0 <fprintf@plt>
    6d7a:	eb 9d                	jmp    6d19 <fwp_exec+0x669>
    6d7c:	48 8b 05 55 e2 00 00 	mov    0xe255(%rip),%rax        # 14fd8 <stderr@GLIBC_2.2.5>
    6d83:	48 8b 38             	mov    (%rax),%rdi
    6d86:	48 8d 35 88 94 00 00 	lea    0x9488(%rip),%rsi        # 10215 <exec_in_fp0+0xb15>
    6d8d:	48 8d 15 61 8a 00 00 	lea    0x8a61(%rip),%rdx        # f7f5 <exec_in_fp0+0xf5>
    6d94:	48 8d 0d 30 98 00 00 	lea    0x9830(%rip),%rcx        # 105cb <exec_in_fp0+0xecb>
    6d9b:	4d 89 f0             	mov    %r14,%r8
    6d9e:	31 c0                	xor    %eax,%eax
    6da0:	e8 4b c5 ff ff       	call   32f0 <fprintf@plt>
    6da5:	e9 6f ff ff ff       	jmp    6d19 <fwp_exec+0x669>
    6daa:	48 8b 05 27 e2 00 00 	mov    0xe227(%rip),%rax        # 14fd8 <stderr@GLIBC_2.2.5>
    6db1:	48 8b 38             	mov    (%rax),%rdi
    6db4:	48 8d 35 b7 94 00 00 	lea    0x94b7(%rip),%rsi        # 10272 <exec_in_fp0+0xb72>
    6dbb:	48 8d 15 33 8a 00 00 	lea    0x8a33(%rip),%rdx        # f7f5 <exec_in_fp0+0xf5>
    6dc2:	31 c0                	xor    %eax,%eax
    6dc4:	e8 27 c5 ff ff       	call   32f0 <fprintf@plt>
    6dc9:	41 be 03 00 00 00    	mov    $0x3,%r14d
    6dcf:	e9 d8 fe ff ff       	jmp    6cac <fwp_exec+0x5fc>
    6dd4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    6ddb:	00 00 00 00 00 

0000000000006de0 <fwp_segv>:
    6de0:	53                   	push   %rbx
    6de1:	48 8b 15 20 06 01 00 	mov    0x10620(%rip),%rdx        # 17408 <fwp_main_stack_top>
    6de8:	48 85 d2             	test   %rdx,%rdx
    6deb:	74 29                	je     6e16 <fwp_segv+0x36>
    6ded:	48 8b 46 10          	mov    0x10(%rsi),%rax
    6df1:	48 2b 15 18 06 01 00 	sub    0x10618(%rip),%rdx        # 17410 <fwp_main_stack_size>
    6df8:	48 8d b2 00 00 f0 ff 	lea    -0x100000(%rdx),%rsi
    6dff:	48 81 c2 00 00 10 00 	add    $0x100000,%rdx
    6e06:	89 fb                	mov    %edi,%ebx
    6e08:	48 89 c7             	mov    %rax,%rdi
    6e0b:	e8 40 00 00 00       	call   6e50 <fwp_near>
    6e10:	89 df                	mov    %ebx,%edi
    6e12:	85 c0                	test   %eax,%eax
    6e14:	75 08                	jne    6e1e <fwp_segv+0x3e>
    6e16:	31 f6                	xor    %esi,%esi
    6e18:	5b                   	pop    %rbx
    6e19:	e9 c2 c4 ff ff       	jmp    32e0 <signal@plt>
    6e1e:	e8 8d d4 ff ff       	call   42b0 <fwp_flush>
    6e23:	48 8d 35 26 88 00 00 	lea    0x8826(%rip),%rsi        # f650 <fwp_segv.msg>
    6e2a:	ba 1a 00 00 00       	mov    $0x1a,%edx
    6e2f:	bf 02 00 00 00       	mov    $0x2,%edi
    6e34:	e8 07 c3 ff ff       	call   3140 <write@plt>
    6e39:	bf 65 00 00 00       	mov    $0x65,%edi
    6e3e:	e8 5d c2 ff ff       	call   30a0 <_exit@plt>
    6e43:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6e4a:	84 00 00 00 00 00 

0000000000006e50 <fwp_near>:
    6e50:	48 39 f7             	cmp    %rsi,%rdi
    6e53:	0f 93 c0             	setae  %al
    6e56:	48 39 d7             	cmp    %rdx,%rdi
    6e59:	0f 92 c1             	setb   %cl
    6e5c:	20 c1                	and    %al,%cl
    6e5e:	0f b6 c1             	movzbl %cl,%eax
    6e61:	c3                   	ret
    6e62:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6e69:	1f 84 00 00 00 00 00 

0000000000006e70 <fwp_generated>:
    6e70:	55                   	push   %rbp
    6e71:	41 57                	push   %r15
    6e73:	41 56                	push   %r14
    6e75:	53                   	push   %rbx
    6e76:	50                   	push   %rax
    6e77:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    6e7c:	85 ff                	test   %edi,%edi
    6e7e:	0f 8e 14 01 00 00    	jle    6f98 <fwp_generated+0x128>
    6e84:	89 fd                	mov    %edi,%ebp
    6e86:	49 89 f7             	mov    %rsi,%r15
    6e89:	4c 8b 36             	mov    (%rsi),%r14
    6e8c:	48 8d 35 3f 94 00 00 	lea    0x943f(%rip),%rsi        # 102d2 <exec_in_fp0+0xbd2>
    6e93:	4c 89 f7             	mov    %r14,%rdi
    6e96:	e8 35 c4 ff ff       	call   32d0 <strcmp@plt>
    6e9b:	85 c0                	test   %eax,%eax
    6e9d:	74 34                	je     6ed3 <fwp_generated+0x63>
    6e9f:	48 8d 35 32 94 00 00 	lea    0x9432(%rip),%rsi        # 102d8 <exec_in_fp0+0xbd8>
    6ea6:	ba 0d 00 00 00       	mov    $0xd,%edx
    6eab:	4c 89 f7             	mov    %r14,%rdi
    6eae:	e8 dd c1 ff ff       	call   3090 <strncmp@plt>
    6eb3:	85 c0                	test   %eax,%eax
    6eb5:	0f 85 dd 00 00 00    	jne    6f98 <fwp_generated+0x128>
    6ebb:	41 0f b6 46 0d       	movzbl 0xd(%r14),%eax
    6ec0:	85 c0                	test   %eax,%eax
    6ec2:	74 2c                	je     6ef0 <fwp_generated+0x80>
    6ec4:	83 f8 3d             	cmp    $0x3d,%eax
    6ec7:	0f 85 cb 00 00 00    	jne    6f98 <fwp_generated+0x128>
    6ecd:	49 83 c6 0e          	add    $0xe,%r14
    6ed1:	eb 2a                	jmp    6efd <fwp_generated+0x8d>
    6ed3:	48 8b 3d 1e 05 01 00 	mov    0x1051e(%rip),%rdi        # 173f8 <fwp_cli_man>
    6eda:	48 8b 05 cf e0 00 00 	mov    0xe0cf(%rip),%rax        # 14fb0 <stdout@GLIBC_2.2.5>
    6ee1:	48 8b 30             	mov    (%rax),%rsi
    6ee4:	e8 07 c3 ff ff       	call   31f0 <fputs@plt>
    6ee9:	31 db                	xor    %ebx,%ebx
    6eeb:	e9 a8 00 00 00       	jmp    6f98 <fwp_generated+0x128>
    6ef0:	83 fd 01             	cmp    $0x1,%ebp
    6ef3:	0f 84 ac 00 00 00    	je     6fa5 <fwp_generated+0x135>
    6ef9:	4d 8b 77 08          	mov    0x8(%r15),%r14
    6efd:	48 8d 35 20 94 00 00 	lea    0x9420(%rip),%rsi        # 10324 <exec_in_fp0+0xc24>
    6f04:	4c 89 f7             	mov    %r14,%rdi
    6f07:	e8 c4 c3 ff ff       	call   32d0 <strcmp@plt>
    6f0c:	31 db                	xor    %ebx,%ebx
    6f0e:	85 c0                	test   %eax,%eax
    6f10:	74 63                	je     6f75 <fwp_generated+0x105>
    6f12:	48 8d 35 10 94 00 00 	lea    0x9410(%rip),%rsi        # 10329 <exec_in_fp0+0xc29>
    6f19:	4c 89 f7             	mov    %r14,%rdi
    6f1c:	e8 af c3 ff ff       	call   32d0 <strcmp@plt>
    6f21:	85 c0                	test   %eax,%eax
    6f23:	74 54                	je     6f79 <fwp_generated+0x109>
    6f25:	48 8d 35 01 94 00 00 	lea    0x9401(%rip),%rsi        # 1032d <exec_in_fp0+0xc2d>
    6f2c:	4c 89 f7             	mov    %r14,%rdi
    6f2f:	e8 9c c3 ff ff       	call   32d0 <strcmp@plt>
    6f34:	b9 02 00 00 00       	mov    $0x2,%ecx
    6f39:	85 c0                	test   %eax,%eax
    6f3b:	74 41                	je     6f7e <fwp_generated+0x10e>
    6f3d:	4c 89 f7             	mov    %r14,%rdi
    6f40:	e8 2b c2 ff ff       	call   3170 <strlen@plt>
    6f45:	4c 89 f7             	mov    %r14,%rdi
    6f48:	48 89 c6             	mov    %rax,%rsi
    6f4b:	e8 80 00 00 00       	call   6fd0 <fwp_str_lossy>
    6f50:	48 8b 0d 81 e0 00 00 	mov    0xe081(%rip),%rcx        # 14fd8 <stderr@GLIBC_2.2.5>
    6f57:	48 8b 39             	mov    (%rcx),%rdi
    6f5a:	48 8d 48 08          	lea    0x8(%rax),%rcx
    6f5e:	48 8d 35 cd 93 00 00 	lea    0x93cd(%rip),%rsi        # 10332 <exec_in_fp0+0xc32>
    6f65:	48 8d 15 89 88 00 00 	lea    0x8889(%rip),%rdx        # f7f5 <exec_in_fp0+0xf5>
    6f6c:	31 c0                	xor    %eax,%eax
    6f6e:	e8 7d c3 ff ff       	call   32f0 <fprintf@plt>
    6f73:	eb 4f                	jmp    6fc4 <fwp_generated+0x154>
    6f75:	31 c9                	xor    %ecx,%ecx
    6f77:	eb 05                	jmp    6f7e <fwp_generated+0x10e>
    6f79:	b9 01 00 00 00       	mov    $0x1,%ecx
    6f7e:	48 8d 05 5b 04 01 00 	lea    0x1045b(%rip),%rax        # 173e0 <fwp_cli_scripts>
    6f85:	48 8b 3c c8          	mov    (%rax,%rcx,8),%rdi
    6f89:	48 8b 05 20 e0 00 00 	mov    0xe020(%rip),%rax        # 14fb0 <stdout@GLIBC_2.2.5>
    6f90:	48 8b 30             	mov    (%rax),%rsi
    6f93:	e8 58 c2 ff ff       	call   31f0 <fputs@plt>
    6f98:	89 d8                	mov    %ebx,%eax
    6f9a:	48 83 c4 08          	add    $0x8,%rsp
    6f9e:	5b                   	pop    %rbx
    6f9f:	41 5e                	pop    %r14
    6fa1:	41 5f                	pop    %r15
    6fa3:	5d                   	pop    %rbp
    6fa4:	c3                   	ret
    6fa5:	48 8b 05 2c e0 00 00 	mov    0xe02c(%rip),%rax        # 14fd8 <stderr@GLIBC_2.2.5>
    6fac:	48 8b 38             	mov    (%rax),%rdi
    6faf:	48 8d 35 30 93 00 00 	lea    0x9330(%rip),%rsi        # 102e6 <exec_in_fp0+0xbe6>
    6fb6:	48 8d 15 38 88 00 00 	lea    0x8838(%rip),%rdx        # f7f5 <exec_in_fp0+0xf5>
    6fbd:	31 c0                	xor    %eax,%eax
    6fbf:	e8 2c c3 ff ff       	call   32f0 <fprintf@plt>
    6fc4:	bb 02 00 00 00       	mov    $0x2,%ebx
    6fc9:	eb cd                	jmp    6f98 <fwp_generated+0x128>
    6fcb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006fd0 <fwp_str_lossy>:
    6fd0:	55                   	push   %rbp
    6fd1:	41 57                	push   %r15
    6fd3:	41 56                	push   %r14
    6fd5:	41 55                	push   %r13
    6fd7:	41 54                	push   %r12
    6fd9:	53                   	push   %rbx
    6fda:	48 83 ec 18          	sub    $0x18,%rsp
    6fde:	48 89 f3             	mov    %rsi,%rbx
    6fe1:	49 89 fe             	mov    %rdi,%r14
    6fe4:	e8 07 14 00 00       	call   83f0 <fwp_valid_utf8>
    6fe9:	85 c0                	test   %eax,%eax
    6feb:	74 19                	je     7006 <fwp_str_lossy+0x36>
    6fed:	4c 89 f7             	mov    %r14,%rdi
    6ff0:	48 89 de             	mov    %rbx,%rsi
    6ff3:	48 83 c4 18          	add    $0x18,%rsp
    6ff7:	5b                   	pop    %rbx
    6ff8:	41 5c                	pop    %r12
    6ffa:	41 5d                	pop    %r13
    6ffc:	41 5e                	pop    %r14
    6ffe:	41 5f                	pop    %r15
    7000:	5d                   	pop    %rbp
    7001:	e9 4a 15 00 00       	jmp    8550 <fwp_str_new>
    7006:	0f 57 c0             	xorps  %xmm0,%xmm0
    7009:	0f 29 04 24          	movaps %xmm0,(%rsp)
    700d:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    7014:	00 00 
    7016:	48 85 db             	test   %rbx,%rbx
    7019:	0f 84 72 01 00 00    	je     7191 <fwp_str_lossy+0x1c1>
    701f:	45 31 ed             	xor    %r13d,%r13d
    7022:	49 89 e7             	mov    %rsp,%r15
    7025:	4c 8d 25 32 93 00 00 	lea    0x9332(%rip),%r12        # 1035e <exec_in_fp0+0xc5e>
    702c:	eb 19                	jmp    7047 <fwp_str_lossy+0x77>
    702e:	66 90                	xchg   %ax,%ax
    7030:	4c 89 ff             	mov    %r15,%rdi
    7033:	4c 89 e6             	mov    %r12,%rsi
    7036:	e8 75 15 00 00       	call   85b0 <buf_puts>
    703b:	49 89 ed             	mov    %rbp,%r13
    703e:	48 39 dd             	cmp    %rbx,%rbp
    7041:	0f 83 4a 01 00 00    	jae    7191 <fwp_str_lossy+0x1c1>
    7047:	43 0f b6 04 2e       	movzbl (%r14,%r13,1),%eax
    704c:	84 c0                	test   %al,%al
    704e:	78 20                	js     7070 <fwp_str_lossy+0xa0>
    7050:	0f be f0             	movsbl %al,%esi
    7053:	4c 89 ff             	mov    %r15,%rdi
    7056:	e8 35 15 00 00       	call   8590 <buf_putc>
    705b:	49 ff c5             	inc    %r13
    705e:	4c 89 ed             	mov    %r13,%rbp
    7061:	eb d8                	jmp    703b <fwp_str_lossy+0x6b>
    7063:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    706a:	84 00 00 00 00 00 
    7070:	8d 48 20             	lea    0x20(%rax),%ecx
    7073:	80 f9 e1             	cmp    $0xe1,%cl
    7076:	77 34                	ja     70ac <fwp_str_lossy+0xdc>
    7078:	89 c2                	mov    %eax,%edx
    707a:	80 e2 f0             	and    $0xf0,%dl
    707d:	80 fa e0             	cmp    $0xe0,%dl
    7080:	0f 85 cb 00 00 00    	jne    7151 <fwp_str_lossy+0x181>
    7086:	3c e0                	cmp    $0xe0,%al
    7088:	40 0f 94 c6          	sete   %sil
    708c:	40 c0 e6 05          	shl    $0x5,%sil
    7090:	40 80 ce 80          	or     $0x80,%sil
    7094:	31 ff                	xor    %edi,%edi
    7096:	3c ed                	cmp    $0xed,%al
    7098:	40 0f 95 c7          	setne  %dil
    709c:	c1 e7 05             	shl    $0x5,%edi
    709f:	81 cf 9f 00 00 00    	or     $0x9f,%edi
    70a5:	b8 02 00 00 00       	mov    $0x2,%eax
    70aa:	eb 0d                	jmp    70b9 <fwp_str_lossy+0xe9>
    70ac:	bf bf 00 00 00       	mov    $0xbf,%edi
    70b1:	40 b6 80             	mov    $0x80,%sil
    70b4:	b8 01 00 00 00       	mov    $0x1,%eax
    70b9:	31 d2                	xor    %edx,%edx
    70bb:	49 8d 6d 01          	lea    0x1(%r13),%rbp
    70bf:	48 39 dd             	cmp    %rbx,%rbp
    70c2:	0f 83 68 ff ff ff    	jae    7030 <fwp_str_lossy+0x60>
    70c8:	45 0f b6 04 2e       	movzbl (%r14,%rbp,1),%r8d
    70cd:	41 38 f0             	cmp    %sil,%r8b
    70d0:	0f 82 5a ff ff ff    	jb     7030 <fwp_str_lossy+0x60>
    70d6:	44 39 c7             	cmp    %r8d,%edi
    70d9:	0f 82 51 ff ff ff    	jb     7030 <fwp_str_lossy+0x60>
    70df:	49 8d 6d 02          	lea    0x2(%r13),%rbp
    70e3:	be 01 00 00 00       	mov    $0x1,%esi
    70e8:	80 f9 e1             	cmp    $0xe1,%cl
    70eb:	77 45                	ja     7132 <fwp_str_lossy+0x162>
    70ed:	48 39 dd             	cmp    %rbx,%rbp
    70f0:	73 40                	jae    7132 <fwp_str_lossy+0x162>
    70f2:	41 0f b6 0c 2e       	movzbl (%r14,%rbp,1),%ecx
    70f7:	80 e1 c0             	and    $0xc0,%cl
    70fa:	80 f9 80             	cmp    $0x80,%cl
    70fd:	75 33                	jne    7132 <fwp_str_lossy+0x162>
    70ff:	49 8d 6d 03          	lea    0x3(%r13),%rbp
    7103:	48 39 dd             	cmp    %rbx,%rbp
    7106:	0f 93 c1             	setae  %cl
    7109:	80 f2 01             	xor    $0x1,%dl
    710c:	be 02 00 00 00       	mov    $0x2,%esi
    7111:	08 ca                	or     %cl,%dl
    7113:	75 1d                	jne    7132 <fwp_str_lossy+0x162>
    7115:	43 0f b6 4c 2e 03    	movzbl 0x3(%r14,%r13,1),%ecx
    711b:	80 e1 c0             	and    $0xc0,%cl
    711e:	31 f6                	xor    %esi,%esi
    7120:	80 f9 80             	cmp    $0x80,%cl
    7123:	0f 94 c1             	sete   %cl
    7126:	75 04                	jne    712c <fwp_str_lossy+0x15c>
    7128:	49 8d 6d 04          	lea    0x4(%r13),%rbp
    712c:	40 88 ce             	mov    %cl,%sil
    712f:	83 ce 02             	or     $0x2,%esi
    7132:	39 c6                	cmp    %eax,%esi
    7134:	0f 85 f6 fe ff ff    	jne    7030 <fwp_str_lossy+0x60>
    713a:	4b 8d 34 2e          	lea    (%r14,%r13,1),%rsi
    713e:	48 89 ea             	mov    %rbp,%rdx
    7141:	4c 29 ea             	sub    %r13,%rdx
    7144:	4c 89 ff             	mov    %r15,%rdi
    7147:	e8 94 14 00 00       	call   85e0 <buf_put>
    714c:	e9 ea fe ff ff       	jmp    703b <fwp_str_lossy+0x6b>
    7151:	8d 50 10             	lea    0x10(%rax),%edx
    7154:	80 fa 04             	cmp    $0x4,%dl
    7157:	77 28                	ja     7181 <fwp_str_lossy+0x1b1>
    7159:	3c f0                	cmp    $0xf0,%al
    715b:	40 0f 94 c6          	sete   %sil
    715f:	bf 8f 00 00 00       	mov    $0x8f,%edi
    7164:	3c f4                	cmp    $0xf4,%al
    7166:	74 05                	je     716d <fwp_str_lossy+0x19d>
    7168:	bf bf 00 00 00       	mov    $0xbf,%edi
    716d:	40 c0 e6 04          	shl    $0x4,%sil
    7171:	40 80 ce 80          	or     $0x80,%sil
    7175:	b8 03 00 00 00       	mov    $0x3,%eax
    717a:	b2 01                	mov    $0x1,%dl
    717c:	e9 3a ff ff ff       	jmp    70bb <fwp_str_lossy+0xeb>
    7181:	4c 89 ff             	mov    %r15,%rdi
    7184:	4c 89 e6             	mov    %r12,%rsi
    7187:	e8 24 14 00 00       	call   85b0 <buf_puts>
    718c:	e9 ca fe ff ff       	jmp    705b <fwp_str_lossy+0x8b>
    7191:	48 89 e7             	mov    %rsp,%rdi
    7194:	e8 87 14 00 00       	call   8620 <buf_to_str>
    7199:	48 83 c4 18          	add    $0x18,%rsp
    719d:	5b                   	pop    %rbx
    719e:	41 5c                	pop    %r12
    71a0:	41 5d                	pop    %r13
    71a2:	41 5e                	pop    %r14
    71a4:	41 5f                	pop    %r15
    71a6:	5d                   	pop    %rbp
    71a7:	c3                   	ret
    71a8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    71af:	00 

00000000000071b0 <fwp_alloc_leaf>:
    71b0:	be 01 00 00 00       	mov    $0x1,%esi
    71b5:	e9 86 d3 ff ff       	jmp    4540 <fwp_gc_alloc>
    71ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000071c0 <fwp_cli_parse>:
    71c0:	c7 01 00 00 00 00    	movl   $0x0,(%rcx)
    71c6:	85 ff                	test   %edi,%edi
    71c8:	0f 8e 6d 01 00 00    	jle    733b <fwp_cli_parse+0x17b>
    71ce:	55                   	push   %rbp
    71cf:	41 57                	push   %r15
    71d1:	41 56                	push   %r14
    71d3:	41 55                	push   %r13
    71d5:	41 54                	push   %r12
    71d7:	53                   	push   %rbx
    71d8:	48 83 ec 28          	sub    $0x28,%rsp
    71dc:	41 89 f8             	mov    %edi,%r8d
    71df:	4d 89 c1             	mov    %r8,%r9
    71e2:	49 f7 d9             	neg    %r9
    71e5:	40 b5 01             	mov    $0x1,%bpl
    71e8:	45 31 ff             	xor    %r15d,%r15d
    71eb:	41 be 01 00 00 00    	mov    $0x1,%r14d
    71f1:	31 db                	xor    %ebx,%ebx
    71f3:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
    71f8:	48 89 74 24 18       	mov    %rsi,0x18(%rsp)
    71fd:	4c 89 44 24 10       	mov    %r8,0x10(%rsp)
    7202:	4c 89 4c 24 08       	mov    %r9,0x8(%rsp)
    7207:	48 89 0c 24          	mov    %rcx,(%rsp)
    720b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7210:	4e 8b 6c f6 f8       	mov    -0x8(%rsi,%r14,8),%r13
    7215:	85 db                	test   %ebx,%ebx
    7217:	75 37                	jne    7250 <fwp_cli_parse+0x90>
    7219:	4d 8b 65 00          	mov    0x0(%r13),%r12
    721d:	49 83 fc 02          	cmp    $0x2,%r12
    7221:	72 2d                	jb     7250 <fwp_cli_parse+0x90>
    7223:	49 8d 7d 08          	lea    0x8(%r13),%rdi
    7227:	80 3f 2d             	cmpb   $0x2d,(%rdi)
    722a:	75 24                	jne    7250 <fwp_cli_parse+0x90>
    722c:	e8 df 14 00 00       	call   8710 <fwp_is_number_arg>
    7231:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    7236:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    723b:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    7240:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    7245:	48 8b 0c 24          	mov    (%rsp),%rcx
    7249:	85 c0                	test   %eax,%eax
    724b:	74 2f                	je     727c <fwp_cli_parse+0xbc>
    724d:	0f 1f 00             	nopl   (%rax)
    7250:	49 63 c7             	movslq %r15d,%rax
    7253:	41 8d 7f 01          	lea    0x1(%r15),%edi
    7257:	89 39                	mov    %edi,(%rcx)
    7259:	4c 89 2c c2          	mov    %r13,(%rdx,%rax,8)
    725d:	41 89 ff             	mov    %edi,%r15d
    7260:	4d 39 c6             	cmp    %r8,%r14
    7263:	40 0f 92 c5          	setb   %bpl
    7267:	4b 8d 04 31          	lea    (%r9,%r14,1),%rax
    726b:	48 ff c0             	inc    %rax
    726e:	49 ff c6             	inc    %r14
    7271:	48 83 f8 01          	cmp    $0x1,%rax
    7275:	75 99                	jne    7210 <fwp_cli_parse+0x50>
    7277:	e9 a9 00 00 00       	jmp    7325 <fwp_cli_parse+0x165>
    727c:	41 0f b6 45 09       	movzbl 0x9(%r13),%eax
    7281:	49 83 fc 02          	cmp    $0x2,%r12
    7285:	75 1a                	jne    72a1 <fwp_cli_parse+0xe1>
    7287:	bb 01 00 00 00       	mov    $0x1,%ebx
    728c:	3c 2d                	cmp    $0x2d,%al
    728e:	74 d0                	je     7260 <fwp_cli_parse+0xa0>
    7290:	31 db                	xor    %ebx,%ebx
    7292:	49 83 fc 02          	cmp    $0x2,%r12
    7296:	75 b8                	jne    7250 <fwp_cli_parse+0x90>
    7298:	3c 68                	cmp    $0x68,%al
    729a:	75 b4                	jne    7250 <fwp_cli_parse+0x90>
    729c:	e9 84 00 00 00       	jmp    7325 <fwp_cli_parse+0x165>
    72a1:	31 db                	xor    %ebx,%ebx
    72a3:	3c 2d                	cmp    $0x2d,%al
    72a5:	75 a9                	jne    7250 <fwp_cli_parse+0x90>
    72a7:	49 8d 5d 0a          	lea    0xa(%r13),%rbx
    72ab:	49 83 c4 fe          	add    $0xfffffffffffffffe,%r12
    72af:	48 89 df             	mov    %rbx,%rdi
    72b2:	be 3d 00 00 00       	mov    $0x3d,%esi
    72b7:	4c 89 e2             	mov    %r12,%rdx
    72ba:	e8 a1 bf ff ff       	call   3260 <memchr@plt>
    72bf:	48 89 c1             	mov    %rax,%rcx
    72c2:	48 29 d9             	sub    %rbx,%rcx
    72c5:	48 85 c0             	test   %rax,%rax
    72c8:	49 0f 44 cc          	cmove  %r12,%rcx
    72cc:	75 38                	jne    7306 <fwp_cli_parse+0x146>
    72ce:	48 83 f9 04          	cmp    $0x4,%rcx
    72d2:	48 8b 0c 24          	mov    (%rsp),%rcx
    72d6:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    72db:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    72e0:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    72e5:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    72ea:	75 13                	jne    72ff <fwp_cli_parse+0x13f>
    72ec:	81 3b 68 65 6c 70    	cmpl   $0x706c6568,(%rbx)
    72f2:	bb 00 00 00 00       	mov    $0x0,%ebx
    72f7:	0f 85 53 ff ff ff    	jne    7250 <fwp_cli_parse+0x90>
    72fd:	eb 26                	jmp    7325 <fwp_cli_parse+0x165>
    72ff:	31 db                	xor    %ebx,%ebx
    7301:	e9 4a ff ff ff       	jmp    7250 <fwp_cli_parse+0x90>
    7306:	48 8b 0c 24          	mov    (%rsp),%rcx
    730a:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    730f:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    7314:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    7319:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    731e:	31 db                	xor    %ebx,%ebx
    7320:	e9 2b ff ff ff       	jmp    7250 <fwp_cli_parse+0x90>
    7325:	40 0f b6 c5          	movzbl %bpl,%eax
    7329:	83 e0 01             	and    $0x1,%eax
    732c:	48 83 c4 28          	add    $0x28,%rsp
    7330:	5b                   	pop    %rbx
    7331:	41 5c                	pop    %r12
    7333:	41 5d                	pop    %r13
    7335:	41 5e                	pop    %r14
    7337:	41 5f                	pop    %r15
    7339:	5d                   	pop    %rbp
    733a:	c3                   	ret
    733b:	31 c0                	xor    %eax,%eax
    733d:	c3                   	ret
    733e:	66 90                	xchg   %ax,%ax

0000000000007340 <fwp_usage_error>:
    7340:	48 8b 05 91 dc 00 00 	mov    0xdc91(%rip),%rax        # 14fd8 <stderr@GLIBC_2.2.5>
    7347:	48 8b 38             	mov    (%rax),%rdi
    734a:	48 8d 35 a5 90 00 00 	lea    0x90a5(%rip),%rsi        # 103f6 <exec_in_fp0+0xcf6>
    7351:	48 8d 15 b1 91 00 00 	lea    0x91b1(%rip),%rdx        # 10509 <exec_in_fp0+0xe09>
    7358:	31 c0                	xor    %eax,%eax
    735a:	e9 91 bf ff ff       	jmp    32f0 <fprintf@plt>
    735f:	90                   	nop

0000000000007360 <fwp_parse_text>:
    7360:	48 83 ec 18          	sub    $0x18,%rsp
    7364:	48 89 d1             	mov    %rdx,%rcx
    7367:	48 89 3c 24          	mov    %rdi,(%rsp)
    736b:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    7370:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    7377:	00 00 
    7379:	48 8d 35 a8 f9 00 00 	lea    0xf9a8(%rip),%rsi        # 16d28 <d0>
    7380:	48 89 e7             	mov    %rsp,%rdi
    7383:	ba 01 00 00 00       	mov    $0x1,%edx
    7388:	e8 83 18 00 00       	call   8c10 <tp_value>
    738d:	85 c0                	test   %eax,%eax
    738f:	74 1c                	je     73ad <fwp_parse_text+0x4d>
    7391:	48 89 e7             	mov    %rsp,%rdi
    7394:	e8 a7 21 00 00       	call   9540 <tp_ws>
    7399:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    739e:	31 c0                	xor    %eax,%eax
    73a0:	48 3b 4c 24 08       	cmp    0x8(%rsp),%rcx
    73a5:	0f 94 c0             	sete   %al
    73a8:	48 83 c4 18          	add    $0x18,%rsp
    73ac:	c3                   	ret
    73ad:	31 c0                	xor    %eax,%eax
    73af:	48 83 c4 18          	add    $0x18,%rsp
    73b3:	c3                   	ret
    73b4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    73bb:	00 00 00 00 00 

00000000000073c0 <fwp_parse_arg>:
    73c0:	53                   	push   %rbx
    73c1:	48 83 ec 10          	sub    $0x10,%rsp
    73c5:	89 fb                	mov    %edi,%ebx
    73c7:	48 8b 06             	mov    (%rsi),%rax
    73ca:	48 8d 7e 08          	lea    0x8(%rsi),%rdi
    73ce:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    73d3:	48 89 c6             	mov    %rax,%rsi
    73d6:	e8 65 14 00 00       	call   8840 <fwp_cli_value>
    73db:	89 c1                	mov    %eax,%ecx
    73dd:	b8 01 00 00 00       	mov    $0x1,%eax
    73e2:	85 c9                	test   %ecx,%ecx
    73e4:	74 06                	je     73ec <fwp_parse_arg+0x2c>
    73e6:	48 83 c4 10          	add    $0x10,%rsp
    73ea:	5b                   	pop    %rbx
    73eb:	c3                   	ret
    73ec:	48 8b 05 e5 db 00 00 	mov    0xdbe5(%rip),%rax        # 14fd8 <stderr@GLIBC_2.2.5>
    73f3:	48 8b 38             	mov    (%rax),%rdi
    73f6:	ff c3                	inc    %ebx
    73f8:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
    73fd:	49 83 c0 08          	add    $0x8,%r8
    7401:	48 8d 35 dd 8f 00 00 	lea    0x8fdd(%rip),%rsi        # 103e5 <exec_in_fp0+0xce5>
    7408:	48 8d 15 e6 83 00 00 	lea    0x83e6(%rip),%rdx        # f7f5 <exec_in_fp0+0xf5>
    740f:	89 d9                	mov    %ebx,%ecx
    7411:	31 c0                	xor    %eax,%eax
    7413:	e8 d8 be ff ff       	call   32f0 <fprintf@plt>
    7418:	31 c0                	xor    %eax,%eax
    741a:	eb ca                	jmp    73e6 <fwp_parse_arg+0x26>
    741c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000007420 <fwp_bind_positional>:
    7420:	50                   	push   %rax
    7421:	31 c0                	xor    %eax,%eax
    7423:	85 f6                	test   %esi,%esi
    7425:	0f 9e c0             	setle  %al
    7428:	89 01                	mov    %eax,(%rcx)
    742a:	83 fe 01             	cmp    $0x1,%esi
    742d:	76 0c                	jbe    743b <fwp_bind_positional+0x1b>
    742f:	e8 0c ff ff ff       	call   7340 <fwp_usage_error>
    7434:	b8 02 00 00 00       	mov    $0x2,%eax
    7439:	59                   	pop    %rcx
    743a:	c3                   	ret
    743b:	31 c0                	xor    %eax,%eax
    743d:	83 fe 01             	cmp    $0x1,%esi
    7440:	75 f7                	jne    7439 <fwp_bind_positional+0x19>
    7442:	48 8b 37             	mov    (%rdi),%rsi
    7445:	31 ff                	xor    %edi,%edi
    7447:	e8 74 ff ff ff       	call   73c0 <fwp_parse_arg>
    744c:	89 c1                	mov    %eax,%ecx
    744e:	31 c0                	xor    %eax,%eax
    7450:	85 c9                	test   %ecx,%ecx
    7452:	0f 94 c0             	sete   %al
    7455:	01 c0                	add    %eax,%eax
    7457:	59                   	pop    %rcx
    7458:	c3                   	ret
    7459:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000007460 <fwp_pipe_out_start>:
    7460:	41 56                	push   %r14
    7462:	53                   	push   %rbx
    7463:	48 81 ec 08 01 00 00 	sub    $0x108,%rsp
    746a:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    746f:	bf 01 00 00 00       	mov    $0x1,%edi
    7474:	e8 67 c0 ff ff       	call   34e0 <fstat@plt>
    7479:	85 c0                	test   %eax,%eax
    747b:	0f 85 82 00 00 00    	jne    7503 <fwp_pipe_out_start+0xa3>
    7481:	b8 00 f0 00 00       	mov    $0xf000,%eax
    7486:	23 44 24 20          	and    0x20(%rsp),%eax
    748a:	3d 00 10 00 00       	cmp    $0x1000,%eax
    748f:	75 72                	jne    7503 <fwp_pipe_out_start+0xa3>
    7491:	bf 01 00 00 00       	mov    $0x1,%edi
    7496:	be 07 04 00 00       	mov    $0x407,%esi
    749b:	ba 00 00 10 00       	mov    $0x100000,%edx
    74a0:	31 c0                	xor    %eax,%eax
    74a2:	e8 79 bc ff ff       	call   3120 <fcntl@plt>
    74a7:	e8 04 38 00 00       	call   acb0 <fwp_transport_off>
    74ac:	85 c0                	test   %eax,%eax
    74ae:	75 53                	jne    7503 <fwp_pipe_out_start+0xa3>
    74b0:	bf 01 00 00 00       	mov    $0x1,%edi
    74b5:	be 01 08 08 00       	mov    $0x80801,%esi
    74ba:	31 d2                	xor    %edx,%edx
    74bc:	e8 4f c0 ff ff       	call   3510 <socket@plt>
    74c1:	85 c0                	test   %eax,%eax
    74c3:	78 3e                	js     7503 <fwp_pipe_out_start+0xa3>
    74c5:	89 c3                	mov    %eax,%ebx
    74c7:	4c 8d b4 24 9a 00 00 	lea    0x9a(%rsp),%r14
    74ce:	00 
    74cf:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    74d4:	4c 89 f7             	mov    %r14,%rdi
    74d7:	e8 04 38 00 00       	call   ace0 <fwp_pipe_addr>
    74dc:	89 df                	mov    %ebx,%edi
    74de:	4c 89 f6             	mov    %r14,%rsi
    74e1:	89 c2                	mov    %eax,%edx
    74e3:	e8 e8 be ff ff       	call   33d0 <bind@plt>
    74e8:	85 c0                	test   %eax,%eax
    74ea:	75 10                	jne    74fc <fwp_pipe_out_start+0x9c>
    74ec:	89 df                	mov    %ebx,%edi
    74ee:	be 01 00 00 00       	mov    $0x1,%esi
    74f3:	e8 68 be ff ff       	call   3360 <listen@plt>
    74f8:	85 c0                	test   %eax,%eax
    74fa:	74 12                	je     750e <fwp_pipe_out_start+0xae>
    74fc:	89 df                	mov    %ebx,%edi
    74fe:	e8 2d bd ff ff       	call   3230 <close@plt>
    7503:	48 81 c4 08 01 00 00 	add    $0x108,%rsp
    750a:	5b                   	pop    %rbx
    750b:	41 5e                	pop    %r14
    750d:	c3                   	ret
    750e:	89 1d a4 f7 00 00    	mov    %ebx,0xf7a4(%rip)        # 16cb8 <fwp_po_listen>
    7514:	e8 17 38 00 00       	call   ad30 <fwp_now_ns>
    7519:	48 b9 00 f2 05 2a 01 	movabs $0x12a05f200,%rcx
    7520:	00 00 00 
    7523:	48 01 c1             	add    %rax,%rcx
    7526:	48 89 0d 0b ff 01 00 	mov    %rcx,0x1ff0b(%rip)        # 27438 <fwp_po_give_up>
    752d:	eb d4                	jmp    7503 <fwp_pipe_out_start+0xa3>
    752f:	90                   	nop

0000000000007530 <fwp_pipe_write>:
    7530:	41 57                	push   %r15
    7532:	41 56                	push   %r14
    7534:	53                   	push   %rbx
    7535:	48 89 f3             	mov    %rsi,%rbx
    7538:	8b 05 02 ff 01 00    	mov    0x1ff02(%rip),%eax        # 27440 <fwp_po_kind>
    753e:	83 f8 01             	cmp    $0x1,%eax
    7541:	74 12                	je     7555 <fwp_pipe_write+0x25>
    7543:	83 f8 02             	cmp    $0x2,%eax
    7546:	75 46                	jne    758e <fwp_pipe_write+0x5e>
    7548:	48 89 de             	mov    %rbx,%rsi
    754b:	5b                   	pop    %rbx
    754c:	41 5e                	pop    %r14
    754e:	41 5f                	pop    %r15
    7550:	e9 0b 38 00 00       	jmp    ad60 <fwp_ring_put>
    7555:	49 89 fe             	mov    %rdi,%r14
    7558:	48 8b 05 e9 fe 01 00 	mov    0x1fee9(%rip),%rax        # 27448 <fwp_po_len>
    755f:	48 01 d8             	add    %rbx,%rax
    7562:	48 3d 01 00 01 00    	cmp    $0x10001,%rax
    7568:	72 05                	jb     756f <fwp_pipe_write+0x3f>
    756a:	e8 51 39 00 00       	call   aec0 <fwp_po_flush_sock>
    756f:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    7576:	72 32                	jb     75aa <fwp_pipe_write+0x7a>
    7578:	8b 3d 3e f7 00 00    	mov    0xf73e(%rip),%edi        # 16cbc <fwp_po_sock>
    757e:	4c 89 f6             	mov    %r14,%rsi
    7581:	48 89 da             	mov    %rbx,%rdx
    7584:	5b                   	pop    %rbx
    7585:	41 5e                	pop    %r14
    7587:	41 5f                	pop    %r15
    7589:	e9 62 39 00 00       	jmp    aef0 <fwp_po_write_raw>
    758e:	48 8b 05 1b da 00 00 	mov    0xda1b(%rip),%rax        # 14fb0 <stdout@GLIBC_2.2.5>
    7595:	48 8b 08             	mov    (%rax),%rcx
    7598:	be 01 00 00 00       	mov    $0x1,%esi
    759d:	48 89 da             	mov    %rbx,%rdx
    75a0:	5b                   	pop    %rbx
    75a1:	41 5e                	pop    %r14
    75a3:	41 5f                	pop    %r15
    75a5:	e9 f6 be ff ff       	jmp    34a0 <fwrite@plt>
    75aa:	4c 8b 3d 97 fe 01 00 	mov    0x1fe97(%rip),%r15        # 27448 <fwp_po_len>
    75b1:	48 8d 3d 98 fe 01 00 	lea    0x1fe98(%rip),%rdi        # 27450 <fwp_po_buf>
    75b8:	4c 01 ff             	add    %r15,%rdi
    75bb:	4c 89 f6             	mov    %r14,%rsi
    75be:	48 89 da             	mov    %rbx,%rdx
    75c1:	e8 6a bd ff ff       	call   3330 <memcpy@plt>
    75c6:	49 01 df             	add    %rbx,%r15
    75c9:	4c 89 3d 78 fe 01 00 	mov    %r15,0x1fe78(%rip)        # 27448 <fwp_po_len>
    75d0:	5b                   	pop    %rbx
    75d1:	41 5e                	pop    %r14
    75d3:	41 5f                	pop    %r15
    75d5:	c3                   	ret
    75d6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    75dd:	00 00 00 

00000000000075e0 <fwp_pipe_flush>:
    75e0:	8b 05 5a fe 01 00    	mov    0x1fe5a(%rip),%eax        # 27440 <fwp_po_kind>
    75e6:	85 c0                	test   %eax,%eax
    75e8:	74 0a                	je     75f4 <fwp_pipe_flush+0x14>
    75ea:	83 f8 01             	cmp    $0x1,%eax
    75ed:	75 1b                	jne    760a <fwp_pipe_flush+0x2a>
    75ef:	e9 cc 38 00 00       	jmp    aec0 <fwp_po_flush_sock>
    75f4:	50                   	push   %rax
    75f5:	48 8b 05 b4 d9 00 00 	mov    0xd9b4(%rip),%rax        # 14fb0 <stdout@GLIBC_2.2.5>
    75fc:	48 8b 38             	mov    (%rax),%rdi
    75ff:	e8 4c bd ff ff       	call   3350 <fflush@plt>
    7604:	58                   	pop    %rax
    7605:	e9 c6 3b 00 00       	jmp    b1d0 <fwp_pipe_poll>
    760a:	c3                   	ret
    760b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000007610 <fwp_pipe_out_ready>:
    7610:	48 83 ec 18          	sub    $0x18,%rsp
    7614:	48 8d 3d 19 8e 00 00 	lea    0x8e19(%rip),%rdi        # 10434 <exec_in_fp0+0xd34>
    761b:	e8 10 ba ff ff       	call   3030 <getenv@plt>
    7620:	48 85 c0             	test   %rax,%rax
    7623:	74 79                	je     769e <fwp_pipe_out_ready+0x8e>
    7625:	83 3d 8c f6 00 00 00 	cmpl   $0x0,0xf68c(%rip)        # 16cb8 <fwp_po_listen>
    762c:	78 70                	js     769e <fwp_pipe_out_ready+0x8e>
    762e:	80 38 00             	cmpb   $0x0,(%rax)
    7631:	74 6b                	je     769e <fwp_pipe_out_ready+0x8e>
    7633:	48 89 c7             	mov    %rax,%rdi
    7636:	31 f6                	xor    %esi,%esi
    7638:	ba 0a 00 00 00       	mov    $0xa,%edx
    763d:	e8 de bc ff ff       	call   3320 <strtol@plt>
    7642:	8b 0d 70 f6 00 00    	mov    0xf670(%rip),%ecx        # 16cb8 <fwp_po_listen>
    7648:	89 0c 24             	mov    %ecx,(%rsp)
    764b:	48 b9 01 00 00 00 01 	movabs $0x100000001,%rcx
    7652:	00 00 00 
    7655:	48 89 4c 24 04       	mov    %rcx,0x4(%rsp)
    765a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%rsp)
    7661:	00 
    7662:	48 85 c0             	test   %rax,%rax
    7665:	7e 37                	jle    769e <fwp_pipe_out_ready+0x8e>
    7667:	48 3d ff ff ff 7f    	cmp    $0x7fffffff,%rax
    766d:	ba ff ff ff 7f       	mov    $0x7fffffff,%edx
    7672:	48 0f 4c d0          	cmovl  %rax,%rdx
    7676:	48 89 e7             	mov    %rsp,%rdi
    7679:	be 02 00 00 00       	mov    $0x2,%esi
    767e:	e8 3d bd ff ff       	call   33c0 <poll@plt>
    7683:	85 c0                	test   %eax,%eax
    7685:	7e 17                	jle    769e <fwp_pipe_out_ready+0x8e>
    7687:	f6 44 24 06 01       	testb  $0x1,0x6(%rsp)
    768c:	74 10                	je     769e <fwp_pipe_out_ready+0x8e>
    768e:	48 c7 05 c7 fd 02 00 	movq   $0x0,0x2fdc7(%rip)        # 37460 <fwp_po_next_check>
    7695:	00 00 00 00 
    7699:	e8 32 3b 00 00       	call   b1d0 <fwp_pipe_poll>
    769e:	48 83 c4 18          	add    $0x18,%rsp
    76a2:	c3                   	ret
    76a3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    76aa:	84 00 00 00 00 00 

00000000000076b0 <fwp_exec_call>:
    76b0:	41 56                	push   %r14
    76b2:	53                   	push   %rbx
    76b3:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
    76ba:	48 89 f3             	mov    %rsi,%rbx
    76bd:	49 89 fe             	mov    %rdi,%r14
    76c0:	48 8b 05 a1 fd 02 00 	mov    0x2fda1(%rip),%rax        # 37468 <fwp_handlers>
    76c7:	48 89 84 24 d0 00 00 	mov    %rax,0xd0(%rsp)
    76ce:	00 
    76cf:	48 c7 84 24 e8 00 00 	movq   $0x0,0xe8(%rsp)
    76d6:	00 00 00 00 00 
    76db:	48 8b 05 f6 fc 00 00 	mov    0xfcf6(%rip),%rax        # 173d8 <fwp_cleanups>
    76e2:	48 89 84 24 f0 00 00 	mov    %rax,0xf0(%rsp)
    76e9:	00 
    76ea:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    76ef:	48 89 3d 72 fd 02 00 	mov    %rdi,0x2fd72(%rip)        # 37468 <fwp_handlers>
    76f6:	e8 b5 bb ff ff       	call   32b0 <_setjmp@plt>
    76fb:	85 c0                	test   %eax,%eax
    76fd:	74 32                	je     7731 <fwp_exec_call+0x81>
    76ff:	48 8b 84 24 d0 00 00 	mov    0xd0(%rsp),%rax
    7706:	00 
    7707:	48 89 05 5a fd 02 00 	mov    %rax,0x2fd5a(%rip)        # 37468 <fwp_handlers>
    770e:	e8 9d cb ff ff       	call   42b0 <fwp_flush>
    7713:	48 8b bc 24 d8 00 00 	mov    0xd8(%rsp),%rdi
    771a:	00 
    771b:	48 8b b4 24 e0 00 00 	mov    0xe0(%rsp),%rsi
    7722:	00 
    7723:	e8 f8 42 00 00       	call   ba20 <fwp_exec_error>
    7728:	b9 01 00 00 00       	mov    $0x1,%ecx
    772d:	31 c0                	xor    %eax,%eax
    772f:	eb 21                	jmp    7752 <fwp_exec_call+0xa2>
    7731:	e8 ca 42 00 00       	call   ba00 <fwp_pap>
    7736:	48 89 c7             	mov    %rax,%rdi
    7739:	4c 89 f6             	mov    %r14,%rsi
    773c:	e8 ff 3d 00 00       	call   b540 <fwp_apply>
    7741:	48 8b 8c 24 d0 00 00 	mov    0xd0(%rsp),%rcx
    7748:	00 
    7749:	48 89 0d 18 fd 02 00 	mov    %rcx,0x2fd18(%rip)        # 37468 <fwp_handlers>
    7750:	31 c9                	xor    %ecx,%ecx
    7752:	89 0b                	mov    %ecx,(%rbx)
    7754:	48 81 c4 f8 00 00 00 	add    $0xf8,%rsp
    775b:	5b                   	pop    %rbx
    775c:	41 5e                	pop    %r14
    775e:	c3                   	ret
    775f:	90                   	nop

0000000000007760 <fwp_emit_result>:
    7760:	e9 2b 57 00 00       	jmp    ce90 <fwp_emit>
    7765:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    776c:	00 00 00 00 

0000000000007770 <fwp_read_exact>:
    7770:	41 57                	push   %r15
    7772:	41 56                	push   %r14
    7774:	53                   	push   %rbx
    7775:	48 89 f3             	mov    %rsi,%rbx
    7778:	49 89 fe             	mov    %rdi,%r14
    777b:	45 31 ff             	xor    %r15d,%r15d
    777e:	48 85 f6             	test   %rsi,%rsi
    7781:	0f 84 b9 00 00 00    	je     7840 <fwp_read_exact+0xd0>
    7787:	8b 05 9b fc 01 00    	mov    0x1fc9b(%rip),%eax        # 27428 <fwp_in_npend>
    778d:	8b 0d 99 fc 01 00    	mov    0x1fc99(%rip),%ecx        # 2742c <fwp_in_ppos>
    7793:	39 c1                	cmp    %eax,%ecx
    7795:	0f 8d a5 00 00 00    	jge    7840 <fwp_read_exact+0xd0>
    779b:	48 98                	cltq
    779d:	48 63 f1             	movslq %ecx,%rsi
    77a0:	48 89 f2             	mov    %rsi,%rdx
    77a3:	48 f7 d2             	not    %rdx
    77a6:	48 01 c2             	add    %rax,%rdx
    77a9:	48 8d 4b ff          	lea    -0x1(%rbx),%rcx
    77ad:	48 39 ca             	cmp    %rcx,%rdx
    77b0:	48 0f 43 d1          	cmovae %rcx,%rdx
    77b4:	48 ff c2             	inc    %rdx
    77b7:	48 83 fa 20          	cmp    $0x20,%rdx
    77bb:	72 16                	jb     77d3 <fwp_read_exact+0x63>
    77bd:	48 8d 3d 60 fc 01 00 	lea    0x1fc60(%rip),%rdi        # 27424 <fwp_in_pend>
    77c4:	4d 89 f0             	mov    %r14,%r8
    77c7:	49 29 f0             	sub    %rsi,%r8
    77ca:	49 29 f8             	sub    %rdi,%r8
    77cd:	49 83 f8 20          	cmp    $0x20,%r8
    77d1:	73 27                	jae    77fa <fwp_read_exact+0x8a>
    77d3:	45 31 ff             	xor    %r15d,%r15d
    77d6:	48 89 f1             	mov    %rsi,%rcx
    77d9:	48 8d 15 44 fc 01 00 	lea    0x1fc44(%rip),%rdx        # 27424 <fwp_in_pend>
    77e0:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    77e4:	48 ff c1             	inc    %rcx
    77e7:	43 88 34 3e          	mov    %sil,(%r14,%r15,1)
    77eb:	49 ff c7             	inc    %r15
    77ee:	49 39 df             	cmp    %rbx,%r15
    77f1:	73 3f                	jae    7832 <fwp_read_exact+0xc2>
    77f3:	48 39 c1             	cmp    %rax,%rcx
    77f6:	7c e8                	jl     77e0 <fwp_read_exact+0x70>
    77f8:	eb 38                	jmp    7832 <fwp_read_exact+0xc2>
    77fa:	49 89 d7             	mov    %rdx,%r15
    77fd:	49 83 e7 e0          	and    $0xffffffffffffffe0,%r15
    7801:	49 8d 0c 37          	lea    (%r15,%rsi,1),%rcx
    7805:	48 01 fe             	add    %rdi,%rsi
    7808:	48 83 c6 10          	add    $0x10,%rsi
    780c:	31 ff                	xor    %edi,%edi
    780e:	66 90                	xchg   %ax,%ax
    7810:	0f 10 44 3e f0       	movups -0x10(%rsi,%rdi,1),%xmm0
    7815:	0f 10 0c 3e          	movups (%rsi,%rdi,1),%xmm1
    7819:	41 0f 11 04 3e       	movups %xmm0,(%r14,%rdi,1)
    781e:	41 0f 11 4c 3e 10    	movups %xmm1,0x10(%r14,%rdi,1)
    7824:	48 83 c7 20          	add    $0x20,%rdi
    7828:	49 39 ff             	cmp    %rdi,%r15
    782b:	75 e3                	jne    7810 <fwp_read_exact+0xa0>
    782d:	4c 39 fa             	cmp    %r15,%rdx
    7830:	75 a7                	jne    77d9 <fwp_read_exact+0x69>
    7832:	89 0d f4 fb 01 00    	mov    %ecx,0x1fbf4(%rip)        # 2742c <fwp_in_ppos>
    7838:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    783f:	00 
    7840:	48 89 de             	mov    %rbx,%rsi
    7843:	4c 29 fe             	sub    %r15,%rsi
    7846:	76 15                	jbe    785d <fwp_read_exact+0xed>
    7848:	4b 8d 3c 3e          	lea    (%r14,%r15,1),%rdi
    784c:	e8 1f 5a 00 00       	call   d270 <fwp_pipe_read>
    7851:	49 01 c7             	add    %rax,%r15
    7854:	48 85 c0             	test   %rax,%rax
    7857:	75 e7                	jne    7840 <fwp_read_exact+0xd0>
    7859:	31 c0                	xor    %eax,%eax
    785b:	eb 05                	jmp    7862 <fwp_read_exact+0xf2>
    785d:	b8 01 00 00 00       	mov    $0x1,%eax
    7862:	5b                   	pop    %rbx
    7863:	41 5e                	pop    %r14
    7865:	41 5f                	pop    %r15
    7867:	c3                   	ret
    7868:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    786f:	00 

0000000000007870 <fwp_stdin_leb>:
    7870:	41 57                	push   %r15
    7872:	41 56                	push   %r14
    7874:	53                   	push   %rbx
    7875:	48 83 ec 10          	sub    $0x10,%rsp
    7879:	48 89 fb             	mov    %rdi,%rbx
    787c:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    7883:	49 c7 c6 f9 ff ff ff 	mov    $0xfffffffffffffff9,%r14
    788a:	4c 8d 7c 24 0f       	lea    0xf(%rsp),%r15
    788f:	90                   	nop
    7890:	be 01 00 00 00       	mov    $0x1,%esi
    7895:	4c 89 ff             	mov    %r15,%rdi
    7898:	e8 d3 fe ff ff       	call   7770 <fwp_read_exact>
    789d:	85 c0                	test   %eax,%eax
    789f:	74 35                	je     78d6 <fwp_stdin_leb+0x66>
    78a1:	0f b6 44 24 0f       	movzbl 0xf(%rsp),%eax
    78a6:	49 83 fe 38          	cmp    $0x38,%r14
    78aa:	75 07                	jne    78b3 <fwp_stdin_leb+0x43>
    78ac:	89 c1                	mov    %eax,%ecx
    78ae:	80 e1 7e             	and    $0x7e,%cl
    78b1:	75 1c                	jne    78cf <fwp_stdin_leb+0x5f>
    78b3:	49 83 c6 07          	add    $0x7,%r14
    78b7:	89 c2                	mov    %eax,%edx
    78b9:	83 e2 7f             	and    $0x7f,%edx
    78bc:	44 89 f1             	mov    %r14d,%ecx
    78bf:	48 d3 e2             	shl    %cl,%rdx
    78c2:	48 09 13             	or     %rdx,(%rbx)
    78c5:	84 c0                	test   %al,%al
    78c7:	79 11                	jns    78da <fwp_stdin_leb+0x6a>
    78c9:	49 83 fe 38          	cmp    $0x38,%r14
    78cd:	76 c1                	jbe    7890 <fwp_stdin_leb+0x20>
    78cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    78d4:	eb 09                	jmp    78df <fwp_stdin_leb+0x6f>
    78d6:	31 c0                	xor    %eax,%eax
    78d8:	eb 05                	jmp    78df <fwp_stdin_leb+0x6f>
    78da:	b8 01 00 00 00       	mov    $0x1,%eax
    78df:	48 83 c4 10          	add    $0x10,%rsp
    78e3:	5b                   	pop    %rbx
    78e4:	41 5e                	pop    %r14
    78e6:	41 5f                	pop    %r15
    78e8:	c3                   	ret
    78e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000078f0 <fwp_stdin_name_len>:
    78f0:	53                   	push   %rbx
    78f1:	48 89 fb             	mov    %rdi,%rbx
    78f4:	e8 77 ff ff ff       	call   7870 <fwp_stdin_leb>
    78f9:	83 f8 01             	cmp    $0x1,%eax
    78fc:	75 0e                	jne    790c <fwp_stdin_name_len+0x1c>
    78fe:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    7903:	48 81 3b 00 00 10 00 	cmpq   $0x100000,(%rbx)
    790a:	77 02                	ja     790e <fwp_stdin_name_len+0x1e>
    790c:	89 c1                	mov    %eax,%ecx
    790e:	89 c8                	mov    %ecx,%eax
    7910:	5b                   	pop    %rbx
    7911:	c3                   	ret
    7912:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7919:	1f 84 00 00 00 00 00 

0000000000007920 <fwp_pipe_in_offer>:
    7920:	55                   	push   %rbp
    7921:	41 57                	push   %r15
    7923:	41 56                	push   %r14
    7925:	53                   	push   %rbx
    7926:	48 81 ec 08 01 00 00 	sub    $0x108,%rsp
    792d:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    7932:	31 ff                	xor    %edi,%edi
    7934:	e8 a7 bb ff ff       	call   34e0 <fstat@plt>
    7939:	85 c0                	test   %eax,%eax
    793b:	0f 85 a5 00 00 00    	jne    79e6 <fwp_pipe_in_offer+0xc6>
    7941:	b8 00 f0 00 00       	mov    $0xf000,%eax
    7946:	23 44 24 20          	and    0x20(%rsp),%eax
    794a:	3d 00 10 00 00       	cmp    $0x1000,%eax
    794f:	0f 85 91 00 00 00    	jne    79e6 <fwp_pipe_in_offer+0xc6>
    7955:	bf 01 00 00 00       	mov    $0x1,%edi
    795a:	be 01 00 08 00       	mov    $0x80001,%esi
    795f:	31 d2                	xor    %edx,%edx
    7961:	e8 aa bb ff ff       	call   3510 <socket@plt>
    7966:	85 c0                	test   %eax,%eax
    7968:	78 7c                	js     79e6 <fwp_pipe_in_offer+0xc6>
    796a:	89 c3                	mov    %eax,%ebx
    796c:	48 8d bc 24 9a 00 00 	lea    0x9a(%rsp),%rdi
    7973:	00 
    7974:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    7979:	e8 62 33 00 00       	call   ace0 <fwp_pipe_addr>
    797e:	41 89 c6             	mov    %eax,%r14d
    7981:	48 8d 3d 72 8a 00 00 	lea    0x8a72(%rip),%rdi        # 103fa <exec_in_fp0+0xcfa>
    7988:	e8 a3 b6 ff ff       	call   3030 <getenv@plt>
    798d:	49 89 c7             	mov    %rax,%r15
    7990:	e8 1b 33 00 00       	call   acb0 <fwp_transport_off>
    7995:	89 c5                	mov    %eax,%ebp
    7997:	c7 04 24 46 57 50 54 	movl   $0x54505746,(%rsp)
    799e:	85 c0                	test   %eax,%eax
    79a0:	74 04                	je     79a6 <fwp_pipe_in_offer+0x86>
    79a2:	31 c0                	xor    %eax,%eax
    79a4:	eb 1f                	jmp    79c5 <fwp_pipe_in_offer+0xa5>
    79a6:	4d 85 ff             	test   %r15,%r15
    79a9:	74 18                	je     79c3 <fwp_pipe_in_offer+0xa3>
    79ab:	48 8d 35 1b 8b 00 00 	lea    0x8b1b(%rip),%rsi        # 104cd <exec_in_fp0+0xdcd>
    79b2:	4c 89 ff             	mov    %r15,%rdi
    79b5:	e8 16 b9 ff ff       	call   32d0 <strcmp@plt>
    79ba:	83 f8 01             	cmp    $0x1,%eax
    79bd:	b0 02                	mov    $0x2,%al
    79bf:	1c 00                	sbb    $0x0,%al
    79c1:	eb 02                	jmp    79c5 <fwp_pipe_in_offer+0xa5>
    79c3:	b0 02                	mov    $0x2,%al
    79c5:	88 44 24 04          	mov    %al,0x4(%rsp)
    79c9:	48 8d b4 24 9a 00 00 	lea    0x9a(%rsp),%rsi
    79d0:	00 
    79d1:	89 df                	mov    %ebx,%edi
    79d3:	44 89 f2             	mov    %r14d,%edx
    79d6:	e8 b5 ba ff ff       	call   3490 <connect@plt>
    79db:	85 c0                	test   %eax,%eax
    79dd:	74 15                	je     79f4 <fwp_pipe_in_offer+0xd4>
    79df:	89 df                	mov    %ebx,%edi
    79e1:	e8 4a b8 ff ff       	call   3230 <close@plt>
    79e6:	48 81 c4 08 01 00 00 	add    $0x108,%rsp
    79ed:	5b                   	pop    %rbx
    79ee:	41 5e                	pop    %r14
    79f0:	41 5f                	pop    %r15
    79f2:	5d                   	pop    %rbp
    79f3:	c3                   	ret
    79f4:	48 89 e6             	mov    %rsp,%rsi
    79f7:	ba 05 00 00 00       	mov    $0x5,%edx
    79fc:	89 df                	mov    %ebx,%edi
    79fe:	b9 00 40 00 00       	mov    $0x4000,%ecx
    7a03:	e8 98 b7 ff ff       	call   31a0 <send@plt>
    7a08:	85 ed                	test   %ebp,%ebp
    7a0a:	75 d3                	jne    79df <fwp_pipe_in_offer+0xbf>
    7a0c:	48 83 f8 05          	cmp    $0x5,%rax
    7a10:	75 cd                	jne    79df <fwp_pipe_in_offer+0xbf>
    7a12:	89 1d ac f2 00 00    	mov    %ebx,0xf2ac(%rip)        # 16cc4 <fwp_pi_sock>
    7a18:	eb cc                	jmp    79e6 <fwp_pipe_in_offer+0xc6>
    7a1a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000007a20 <fwp_pipe_in_switch>:
    7a20:	55                   	push   %rbp
    7a21:	41 57                	push   %r15
    7a23:	41 56                	push   %r14
    7a25:	53                   	push   %rbx
    7a26:	48 81 ec 08 01 00 00 	sub    $0x108,%rsp
    7a2d:	31 db                	xor    %ebx,%ebx
    7a2f:	48 83 fe 01          	cmp    $0x1,%rsi
    7a33:	0f 85 f6 01 00 00    	jne    7c2f <fwp_pipe_in_switch+0x20f>
    7a39:	48 89 f8             	mov    %rdi,%rax
    7a3c:	8b 3d 82 f2 00 00    	mov    0xf282(%rip),%edi        # 16cc4 <fwp_pi_sock>
    7a42:	85 ff                	test   %edi,%edi
    7a44:	0f 88 e5 01 00 00    	js     7c2f <fwp_pipe_in_switch+0x20f>
    7a4a:	83 3d 23 fa 02 00 00 	cmpl   $0x0,0x2fa23(%rip)        # 37474 <fwp_pi_kind>
    7a51:	0f 85 d8 01 00 00    	jne    7c2f <fwp_pipe_in_switch+0x20f>
    7a57:	0f b6 00             	movzbl (%rax),%eax
    7a5a:	83 f8 02             	cmp    $0x2,%eax
    7a5d:	74 29                	je     7a88 <fwp_pipe_in_switch+0x68>
    7a5f:	83 f8 01             	cmp    $0x1,%eax
    7a62:	0f 85 c7 01 00 00    	jne    7c2f <fwp_pipe_in_switch+0x20f>
    7a68:	c7 05 02 fa 02 00 01 	movl   $0x1,0x2fa02(%rip)        # 37474 <fwp_pi_kind>
    7a6f:	00 00 00 
    7a72:	48 8d 3d 70 87 00 00 	lea    0x8770(%rip),%rdi        # 101e9 <exec_in_fp0+0xae9>
    7a79:	e8 12 5a 00 00       	call   d490 <fwp_pipe_report>
    7a7e:	bb 01 00 00 00       	mov    $0x1,%ebx
    7a83:	e9 a7 01 00 00       	jmp    7c2f <fwp_pipe_in_switch+0x20f>
    7a88:	48 8d 44 24 0f       	lea    0xf(%rsp),%rax
    7a8d:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    7a92:	48 c7 44 24 58 01 00 	movq   $0x1,0x58(%rsp)
    7a99:	00 00 
    7a9b:	0f 57 c0             	xorps  %xmm0,%xmm0
    7a9e:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    7aa3:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    7aa8:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    7aad:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    7ab4:	00 00 
    7ab6:	48 8d 44 24 50       	lea    0x50(%rsp),%rax
    7abb:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    7ac0:	48 c7 44 24 28 01 00 	movq   $0x1,0x28(%rsp)
    7ac7:	00 00 
    7ac9:	48 8d 44 24 60       	lea    0x60(%rsp),%rax
    7ace:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    7ad3:	48 c7 44 24 38 18 00 	movq   $0x18,0x38(%rsp)
    7ada:	00 00 
    7adc:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    7ae1:	ba 00 00 00 40       	mov    $0x40000000,%edx
    7ae6:	e8 b5 b8 ff ff       	call   33a0 <recvmsg@plt>
    7aeb:	31 db                	xor    %ebx,%ebx
    7aed:	48 83 f8 01          	cmp    $0x1,%rax
    7af1:	0f 85 38 01 00 00    	jne    7c2f <fwp_pipe_in_switch+0x20f>
    7af7:	48 83 7c 24 38 10    	cmpq   $0x10,0x38(%rsp)
    7afd:	0f 82 2c 01 00 00    	jb     7c2f <fwp_pipe_in_switch+0x20f>
    7b03:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    7b08:	48 85 c0             	test   %rax,%rax
    7b0b:	0f 84 1e 01 00 00    	je     7c2f <fwp_pipe_in_switch+0x20f>
    7b11:	83 78 0c 01          	cmpl   $0x1,0xc(%rax)
    7b15:	0f 85 14 01 00 00    	jne    7c2f <fwp_pipe_in_switch+0x20f>
    7b1b:	8b 68 10             	mov    0x10(%rax),%ebp
    7b1e:	48 8d 74 24 78       	lea    0x78(%rsp),%rsi
    7b23:	89 ef                	mov    %ebp,%edi
    7b25:	e8 b6 b9 ff ff       	call   34e0 <fstat@plt>
    7b2a:	85 c0                	test   %eax,%eax
    7b2c:	0f 85 f4 00 00 00    	jne    7c26 <fwp_pipe_in_switch+0x206>
    7b32:	4c 8b b4 24 a8 00 00 	mov    0xa8(%rsp),%r14
    7b39:	00 
    7b3a:	49 81 fe 00 10 00 00 	cmp    $0x1000,%r14
    7b41:	0f 86 df 00 00 00    	jbe    7c26 <fwp_pipe_in_switch+0x206>
    7b47:	31 db                	xor    %ebx,%ebx
    7b49:	31 ff                	xor    %edi,%edi
    7b4b:	4c 89 f6             	mov    %r14,%rsi
    7b4e:	ba 03 00 00 00       	mov    $0x3,%edx
    7b53:	b9 01 00 00 00       	mov    $0x1,%ecx
    7b58:	41 89 e8             	mov    %ebp,%r8d
    7b5b:	45 31 c9             	xor    %r9d,%r9d
    7b5e:	e8 2d b6 ff ff       	call   3190 <mmap@plt>
    7b63:	49 89 c7             	mov    %rax,%r15
    7b66:	89 ef                	mov    %ebp,%edi
    7b68:	e8 c3 b6 ff ff       	call   3230 <close@plt>
    7b6d:	49 83 ff ff          	cmp    $0xffffffffffffffff,%r15
    7b71:	0f 84 b8 00 00 00    	je     7c2f <fwp_pipe_in_switch+0x20f>
    7b77:	41 81 3f 46 57 50 53 	cmpl   $0x53505746,(%r15)
    7b7e:	0f 85 ab 00 00 00    	jne    7c2f <fwp_pipe_in_switch+0x20f>
    7b84:	41 83 7f 04 01       	cmpl   $0x1,0x4(%r15)
    7b89:	0f 85 a0 00 00 00    	jne    7c2f <fwp_pipe_in_switch+0x20f>
    7b8f:	49 8b 47 08          	mov    0x8(%r15),%rax
    7b93:	48 85 c0             	test   %rax,%rax
    7b96:	0f 84 93 00 00 00    	je     7c2f <fwp_pipe_in_switch+0x20f>
    7b9c:	48 89 c1             	mov    %rax,%rcx
    7b9f:	48 d1 e9             	shr    $1,%rcx
    7ba2:	48 ba 55 55 55 55 55 	movabs $0x5555555555555555,%rdx
    7ba9:	55 55 55 
    7bac:	48 21 ca             	and    %rcx,%rdx
    7baf:	48 89 c1             	mov    %rax,%rcx
    7bb2:	48 29 d1             	sub    %rdx,%rcx
    7bb5:	48 ba 33 33 33 33 33 	movabs $0x3333333333333333,%rdx
    7bbc:	33 33 33 
    7bbf:	48 89 ce             	mov    %rcx,%rsi
    7bc2:	48 21 d6             	and    %rdx,%rsi
    7bc5:	48 c1 e9 02          	shr    $0x2,%rcx
    7bc9:	48 21 d1             	and    %rdx,%rcx
    7bcc:	48 01 f1             	add    %rsi,%rcx
    7bcf:	48 89 ca             	mov    %rcx,%rdx
    7bd2:	48 c1 ea 04          	shr    $0x4,%rdx
    7bd6:	48 01 ca             	add    %rcx,%rdx
    7bd9:	48 b9 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%rcx
    7be0:	0f 0f 0f 
    7be3:	48 21 d1             	and    %rdx,%rcx
    7be6:	48 ba 01 01 01 01 01 	movabs $0x101010101010101,%rdx
    7bed:	01 01 01 
    7bf0:	48 0f af d1          	imul   %rcx,%rdx
    7bf4:	48 c1 ea 38          	shr    $0x38,%rdx
    7bf8:	83 fa 01             	cmp    $0x1,%edx
    7bfb:	77 32                	ja     7c2f <fwp_pipe_in_switch+0x20f>
    7bfd:	49 81 c6 00 f0 ff ff 	add    $0xfffffffffffff000,%r14
    7c04:	4c 39 f0             	cmp    %r14,%rax
    7c07:	77 26                	ja     7c2f <fwp_pipe_in_switch+0x20f>
    7c09:	4c 89 3d 68 f8 02 00 	mov    %r15,0x2f868(%rip)        # 37478 <fwp_pi_ring>
    7c10:	c7 05 5a f8 02 00 02 	movl   $0x2,0x2f85a(%rip)        # 37474 <fwp_pi_kind>
    7c17:	00 00 00 
    7c1a:	48 8d 3d b0 88 00 00 	lea    0x88b0(%rip),%rdi        # 104d1 <exec_in_fp0+0xdd1>
    7c21:	e9 53 fe ff ff       	jmp    7a79 <fwp_pipe_in_switch+0x59>
    7c26:	89 ef                	mov    %ebp,%edi
    7c28:	e8 03 b6 ff ff       	call   3230 <close@plt>
    7c2d:	31 db                	xor    %ebx,%ebx
    7c2f:	89 d8                	mov    %ebx,%eax
    7c31:	48 81 c4 08 01 00 00 	add    $0x108,%rsp
    7c38:	5b                   	pop    %rbx
    7c39:	41 5e                	pop    %r14
    7c3b:	41 5f                	pop    %r15
    7c3d:	5d                   	pop    %rbp
    7c3e:	c3                   	ret
    7c3f:	90                   	nop

0000000000007c40 <fwp_decode>:
    7c40:	55                   	push   %rbp
    7c41:	41 57                	push   %r15
    7c43:	41 56                	push   %r14
    7c45:	41 55                	push   %r13
    7c47:	41 54                	push   %r12
    7c49:	53                   	push   %rbx
    7c4a:	48 83 ec 38          	sub    $0x38,%rsp
    7c4e:	8b 06                	mov    (%rsi),%eax
    7c50:	45 31 f6             	xor    %r14d,%r14d
    7c53:	48 83 f8 15          	cmp    $0x15,%rax
    7c57:	77 47                	ja     7ca0 <fwp_decode+0x60>
    7c59:	48 89 d3             	mov    %rdx,%rbx
    7c5c:	49 89 f4             	mov    %rsi,%r12
    7c5f:	49 89 ff             	mov    %rdi,%r15
    7c62:	48 8d 0d 17 75 00 00 	lea    0x7517(%rip),%rcx        # f180 <_IO_stdin_used+0x180>
    7c69:	48 63 14 81          	movslq (%rcx,%rax,4),%rdx
    7c6d:	48 01 ca             	add    %rcx,%rdx
    7c70:	ff e2                	jmp    *%rdx
    7c72:	31 c9                	xor    %ecx,%ecx
    7c74:	83 f8 0a             	cmp    $0xa,%eax
    7c77:	0f 95 c1             	setne  %cl
    7c7a:	8d 34 8d 04 00 00 00 	lea    0x4(,%rcx,4),%esi
    7c81:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7c86:	4c 89 ff             	mov    %r15,%rdi
    7c89:	e8 52 58 00 00       	call   d4e0 <rd_le>
    7c8e:	85 c0                	test   %eax,%eax
    7c90:	74 0e                	je     7ca0 <fwp_decode+0x60>
    7c92:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    7c97:	48 89 03             	mov    %rax,(%rbx)
    7c9a:	41 be 01 00 00 00    	mov    $0x1,%r14d
    7ca0:	44 89 f0             	mov    %r14d,%eax
    7ca3:	48 83 c4 38          	add    $0x38,%rsp
    7ca7:	5b                   	pop    %rbx
    7ca8:	41 5c                	pop    %r12
    7caa:	41 5d                	pop    %r13
    7cac:	41 5e                	pop    %r14
    7cae:	41 5f                	pop    %r15
    7cb0:	5d                   	pop    %rbp
    7cb1:	c3                   	ret
    7cb2:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    7cb7:	4c 89 ff             	mov    %r15,%rdi
    7cba:	e8 e1 58 00 00       	call   d5a0 <rd_leb>
    7cbf:	45 31 f6             	xor    %r14d,%r14d
    7cc2:	85 c0                	test   %eax,%eax
    7cc4:	74 da                	je     7ca0 <fwp_decode+0x60>
    7cc6:	4c 8b 6c 24 08       	mov    0x8(%rsp),%r13
    7ccb:	4d 3b 6f 08          	cmp    0x8(%r15),%r13
    7ccf:	77 cf                	ja     7ca0 <fwp_decode+0x60>
    7cd1:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    7cd6:	4c 89 ff             	mov    %r15,%rdi
    7cd9:	4c 89 ee             	mov    %r13,%rsi
    7cdc:	e8 3f 59 00 00       	call   d620 <rd_take>
    7ce1:	85 c0                	test   %eax,%eax
    7ce3:	74 bb                	je     7ca0 <fwp_decode+0x60>
    7ce5:	41 83 3c 24 0c       	cmpl   $0xc,(%r12)
    7cea:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    7cef:	75 0f                	jne    7d00 <fwp_decode+0xc0>
    7cf1:	4c 89 ff             	mov    %r15,%rdi
    7cf4:	4c 89 ee             	mov    %r13,%rsi
    7cf7:	e8 f4 06 00 00       	call   83f0 <fwp_valid_utf8>
    7cfc:	85 c0                	test   %eax,%eax
    7cfe:	74 a0                	je     7ca0 <fwp_decode+0x60>
    7d00:	4c 89 ff             	mov    %r15,%rdi
    7d03:	4c 89 ee             	mov    %r13,%rsi
    7d06:	e8 45 08 00 00       	call   8550 <fwp_str_new>
    7d0b:	eb 8a                	jmp    7c97 <fwp_decode+0x57>
    7d0d:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7d12:	4c 89 ff             	mov    %r15,%rdi
    7d15:	be 01 00 00 00       	mov    $0x1,%esi
    7d1a:	e8 c1 57 00 00       	call   d4e0 <rd_le>
    7d1f:	85 c0                	test   %eax,%eax
    7d21:	0f 84 79 ff ff ff    	je     7ca0 <fwp_decode+0x60>
    7d27:	48 0f be 44 24 08    	movsbq 0x8(%rsp),%rax
    7d2d:	e9 65 ff ff ff       	jmp    7c97 <fwp_decode+0x57>
    7d32:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7d37:	4c 89 ff             	mov    %r15,%rdi
    7d3a:	be 08 00 00 00       	mov    $0x8,%esi
    7d3f:	e8 9c 57 00 00       	call   d4e0 <rd_le>
    7d44:	45 31 f6             	xor    %r14d,%r14d
    7d47:	85 c0                	test   %eax,%eax
    7d49:	0f 84 51 ff ff ff    	je     7ca0 <fwp_decode+0x60>
    7d4f:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    7d54:	4c 89 ff             	mov    %r15,%rdi
    7d57:	be 08 00 00 00       	mov    $0x8,%esi
    7d5c:	e8 7f 57 00 00       	call   d4e0 <rd_le>
    7d61:	85 c0                	test   %eax,%eax
    7d63:	0f 84 37 ff ff ff    	je     7ca0 <fwp_decode+0x60>
    7d69:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    7d6e:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    7d73:	41 83 3c 24 04       	cmpl   $0x4,(%r12)
    7d78:	0f 85 d1 02 00 00    	jne    804f <fwp_decode+0x40f>
    7d7e:	e8 7d 26 00 00       	call   a400 <fwp_box_i128>
    7d83:	e9 0f ff ff ff       	jmp    7c97 <fwp_decode+0x57>
    7d88:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    7d8d:	4c 89 ff             	mov    %r15,%rdi
    7d90:	e8 0b 58 00 00       	call   d5a0 <rd_leb>
    7d95:	85 c0                	test   %eax,%eax
    7d97:	0f 84 03 ff ff ff    	je     7ca0 <fwp_decode+0x60>
    7d9d:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    7da2:	49 3b 6f 08          	cmp    0x8(%r15),%rbp
    7da6:	0f 87 f4 fe ff ff    	ja     7ca0 <fwp_decode+0x60>
    7dac:	4c 8d 35 7d f6 01 00 	lea    0x1f67d(%rip),%r14        # 27430 <fwp_empty_map>
    7db3:	48 85 ed             	test   %rbp,%rbp
    7db6:	0f 84 9d 02 00 00    	je     8059 <fwp_decode+0x419>
    7dbc:	4c 8d 6c 24 18       	lea    0x18(%rsp),%r13
    7dc1:	eb 20                	jmp    7de3 <fwp_decode+0x1a3>
    7dc3:	31 f6                	xor    %esi,%esi
    7dc5:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    7dca:	49 8b 4c 24 38       	mov    0x38(%r12),%rcx
    7dcf:	4c 89 f2             	mov    %r14,%rdx
    7dd2:	e8 69 1e 00 00       	call   9c40 <fwp_p_map_insert>
    7dd7:	49 89 c6             	mov    %rax,%r14
    7dda:	48 ff cd             	dec    %rbp
    7ddd:	0f 84 76 02 00 00    	je     8059 <fwp_decode+0x419>
    7de3:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
    7dea:	00 00 
    7dec:	49 8b 74 24 38       	mov    0x38(%r12),%rsi
    7df1:	4c 89 ff             	mov    %r15,%rdi
    7df4:	4c 89 ea             	mov    %r13,%rdx
    7df7:	e8 44 fe ff ff       	call   7c40 <fwp_decode>
    7dfc:	85 c0                	test   %eax,%eax
    7dfe:	0f 84 69 02 00 00    	je     806d <fwp_decode+0x42d>
    7e04:	41 83 3c 24 12       	cmpl   $0x12,(%r12)
    7e09:	75 b8                	jne    7dc3 <fwp_decode+0x183>
    7e0b:	49 8b 74 24 40       	mov    0x40(%r12),%rsi
    7e10:	4c 89 ff             	mov    %r15,%rdi
    7e13:	48 8d 54 24 30       	lea    0x30(%rsp),%rdx
    7e18:	e8 23 fe ff ff       	call   7c40 <fwp_decode>
    7e1d:	85 c0                	test   %eax,%eax
    7e1f:	0f 84 48 02 00 00    	je     806d <fwp_decode+0x42d>
    7e25:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    7e2a:	eb 99                	jmp    7dc5 <fwp_decode+0x185>
    7e2c:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    7e31:	4c 89 ff             	mov    %r15,%rdi
    7e34:	e8 67 57 00 00       	call   d5a0 <rd_leb>
    7e39:	85 c0                	test   %eax,%eax
    7e3b:	0f 84 5f fe ff ff    	je     7ca0 <fwp_decode+0x60>
    7e41:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
    7e46:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    7e4b:	49 3b 5f 08          	cmp    0x8(%r15),%rbx
    7e4f:	0f 87 4b fe ff ff    	ja     7ca0 <fwp_decode+0x60>
    7e55:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    7e5c:	00 
    7e5d:	e8 ee e6 ff ff       	call   6550 <fwp_alloc>
    7e62:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    7e67:	48 85 db             	test   %rbx,%rbx
    7e6a:	74 35                	je     7ea1 <fwp_decode+0x261>
    7e6c:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
    7e71:	49 89 dd             	mov    %rbx,%r13
    7e74:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    7e7b:	00 00 00 00 00 
    7e80:	49 8b 74 24 38       	mov    0x38(%r12),%rsi
    7e85:	4c 89 ff             	mov    %r15,%rdi
    7e88:	48 89 ea             	mov    %rbp,%rdx
    7e8b:	e8 b0 fd ff ff       	call   7c40 <fwp_decode>
    7e90:	85 c0                	test   %eax,%eax
    7e92:	0f 84 08 fe ff ff    	je     7ca0 <fwp_decode+0x60>
    7e98:	48 83 c5 08          	add    $0x8,%rbp
    7e9c:	49 ff cd             	dec    %r13
    7e9f:	75 df                	jne    7e80 <fwp_decode+0x240>
    7ea1:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    7ea6:	48 89 de             	mov    %rbx,%rsi
    7ea9:	e8 a2 02 00 00       	call   8150 <fwp_list_from>
    7eae:	41 83 3c 24 11       	cmpl   $0x11,(%r12)
    7eb3:	0f 85 b4 00 00 00    	jne    7f6d <fwp_decode+0x32d>
    7eb9:	48 89 c7             	mov    %rax,%rdi
    7ebc:	e8 2f 1c 00 00       	call   9af0 <fwp_p_array_from_list>
    7ec1:	e9 a7 00 00 00       	jmp    7f6d <fwp_decode+0x32d>
    7ec6:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    7ecb:	4c 89 ff             	mov    %r15,%rdi
    7ece:	e8 cd 56 00 00       	call   d5a0 <rd_leb>
    7ed3:	85 c0                	test   %eax,%eax
    7ed5:	0f 84 c5 fd ff ff    	je     7ca0 <fwp_decode+0x60>
    7edb:	4c 8b 6c 24 08       	mov    0x8(%rsp),%r13
    7ee0:	49 63 44 24 10       	movslq 0x10(%r12),%rax
    7ee5:	49 39 c5             	cmp    %rax,%r13
    7ee8:	0f 83 b2 fd ff ff    	jae    7ca0 <fwp_decode+0x60>
    7eee:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
    7ef3:	49 8b 44 24 28       	mov    0x28(%r12),%rax
    7ef8:	4a 63 1c a8          	movslq (%rax,%r13,4),%rbx
    7efc:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    7f03:	00 
    7f04:	e8 47 e6 ff ff       	call   6550 <fwp_alloc>
    7f09:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    7f0e:	89 d8                	mov    %ebx,%eax
    7f10:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    7f15:	48 85 db             	test   %rbx,%rbx
    7f18:	7e 41                	jle    7f5b <fwp_decode+0x31b>
    7f1a:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    7f1f:	48 8d 2c c5 00 00 00 	lea    0x0(,%rax,8),%rbp
    7f26:	00 
    7f27:	45 31 f6             	xor    %r14d,%r14d
    7f2a:	31 db                	xor    %ebx,%ebx
    7f2c:	49 8b 44 24 30       	mov    0x30(%r12),%rax
    7f31:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    7f35:	48 8b 34 18          	mov    (%rax,%rbx,1),%rsi
    7f39:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    7f3e:	48 8d 14 18          	lea    (%rax,%rbx,1),%rdx
    7f42:	4c 89 ff             	mov    %r15,%rdi
    7f45:	e8 f6 fc ff ff       	call   7c40 <fwp_decode>
    7f4a:	85 c0                	test   %eax,%eax
    7f4c:	0f 84 4e fd ff ff    	je     7ca0 <fwp_decode+0x60>
    7f52:	48 83 c3 08          	add    $0x8,%rbx
    7f56:	48 39 dd             	cmp    %rbx,%rbp
    7f59:	75 d1                	jne    7f2c <fwp_decode+0x2ec>
    7f5b:	44 89 ef             	mov    %r13d,%edi
    7f5e:	48 8b 74 24 28       	mov    0x28(%rsp),%rsi
    7f63:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
    7f68:	e8 13 c4 ff ff       	call   4380 <fwp_data>
    7f6d:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    7f72:	48 89 01             	mov    %rax,(%rcx)
    7f75:	e9 20 fd ff ff       	jmp    7c9a <fwp_decode+0x5a>
    7f7a:	be 01 00 00 00       	mov    $0x1,%esi
    7f7f:	e9 fd fc ff ff       	jmp    7c81 <fwp_decode+0x41>
    7f84:	be 02 00 00 00       	mov    $0x2,%esi
    7f89:	e9 f3 fc ff ff       	jmp    7c81 <fwp_decode+0x41>
    7f8e:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7f93:	4c 89 ff             	mov    %r15,%rdi
    7f96:	be 02 00 00 00       	mov    $0x2,%esi
    7f9b:	e8 40 55 00 00       	call   d4e0 <rd_le>
    7fa0:	85 c0                	test   %eax,%eax
    7fa2:	0f 84 f8 fc ff ff    	je     7ca0 <fwp_decode+0x60>
    7fa8:	48 0f bf 44 24 08    	movswq 0x8(%rsp),%rax
    7fae:	e9 e4 fc ff ff       	jmp    7c97 <fwp_decode+0x57>
    7fb3:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7fb8:	4c 89 ff             	mov    %r15,%rdi
    7fbb:	be 04 00 00 00       	mov    $0x4,%esi
    7fc0:	e8 1b 55 00 00       	call   d4e0 <rd_le>
    7fc5:	85 c0                	test   %eax,%eax
    7fc7:	0f 84 d3 fc ff ff    	je     7ca0 <fwp_decode+0x60>
    7fcd:	48 63 44 24 08       	movslq 0x8(%rsp),%rax
    7fd2:	e9 c0 fc ff ff       	jmp    7c97 <fwp_decode+0x57>
    7fd7:	be 04 00 00 00       	mov    $0x4,%esi
    7fdc:	e9 a0 fc ff ff       	jmp    7c81 <fwp_decode+0x41>
    7fe1:	49 63 7c 24 10       	movslq 0x10(%r12),%rdi
    7fe6:	48 85 ff             	test   %rdi,%rdi
    7fe9:	74 76                	je     8061 <fwp_decode+0x421>
    7feb:	48 c1 e7 03          	shl    $0x3,%rdi
    7fef:	e8 5c e5 ff ff       	call   6550 <fwp_alloc>
    7ff4:	41 8b 7c 24 10       	mov    0x10(%r12),%edi
    7ff9:	85 ff                	test   %edi,%edi
    7ffb:	7e 45                	jle    8042 <fwp_decode+0x402>
    7ffd:	45 31 f6             	xor    %r14d,%r14d
    8000:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    8005:	48 89 c5             	mov    %rax,%rbp
    8008:	45 31 ed             	xor    %r13d,%r13d
    800b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8010:	49 8b 44 24 20       	mov    0x20(%r12),%rax
    8015:	4a 8b 34 e8          	mov    (%rax,%r13,8),%rsi
    8019:	4c 89 ff             	mov    %r15,%rdi
    801c:	48 89 ea             	mov    %rbp,%rdx
    801f:	e8 1c fc ff ff       	call   7c40 <fwp_decode>
    8024:	85 c0                	test   %eax,%eax
    8026:	0f 84 74 fc ff ff    	je     7ca0 <fwp_decode+0x60>
    802c:	49 ff c5             	inc    %r13
    802f:	49 63 7c 24 10       	movslq 0x10(%r12),%rdi
    8034:	48 83 c5 08          	add    $0x8,%rbp
    8038:	49 39 fd             	cmp    %rdi,%r13
    803b:	7c d3                	jl     8010 <fwp_decode+0x3d0>
    803d:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    8042:	48 89 c6             	mov    %rax,%rsi
    8045:	e8 16 c3 ff ff       	call   4360 <fwp_record>
    804a:	e9 48 fc ff ff       	jmp    7c97 <fwp_decode+0x57>
    804f:	e8 5c 22 00 00       	call   a2b0 <fwp_box_u128>
    8054:	e9 3e fc ff ff       	jmp    7c97 <fwp_decode+0x57>
    8059:	4c 89 33             	mov    %r14,(%rbx)
    805c:	e9 39 fc ff ff       	jmp    7c9a <fwp_decode+0x5a>
    8061:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    8068:	e9 2d fc ff ff       	jmp    7c9a <fwp_decode+0x5a>
    806d:	45 31 f6             	xor    %r14d,%r14d
    8070:	e9 2b fc ff ff       	jmp    7ca0 <fwp_decode+0x60>
    8075:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    807c:	00 00 00 00 

0000000000008080 <fwp_read_text_line>:
    8080:	53                   	push   %rbx
    8081:	48 89 fb             	mov    %rdi,%rbx
    8084:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
    808b:	00 
    808c:	e8 bf 55 00 00       	call   d650 <fwp_getc>
    8091:	83 f8 ff             	cmp    $0xffffffff,%eax
    8094:	74 59                	je     80ef <fwp_read_text_line+0x6f>
    8096:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    809d:	00 00 00 
    80a0:	83 f8 0a             	cmp    $0xa,%eax
    80a3:	74 1a                	je     80bf <fwp_read_text_line+0x3f>
    80a5:	0f be f0             	movsbl %al,%esi
    80a8:	48 89 df             	mov    %rbx,%rdi
    80ab:	e8 e0 04 00 00       	call   8590 <buf_putc>
    80b0:	e8 9b 55 00 00       	call   d650 <fwp_getc>
    80b5:	83 f8 ff             	cmp    $0xffffffff,%eax
    80b8:	75 e6                	jne    80a0 <fwp_read_text_line+0x20>
    80ba:	48 8b 03             	mov    (%rbx),%rax
    80bd:	eb 1c                	jmp    80db <fwp_read_text_line+0x5b>
    80bf:	48 8b 03             	mov    (%rbx),%rax
    80c2:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    80c6:	48 85 c9             	test   %rcx,%rcx
    80c9:	74 10                	je     80db <fwp_read_text_line+0x5b>
    80cb:	80 7c 08 ff 0d       	cmpb   $0xd,-0x1(%rax,%rcx,1)
    80d0:	75 12                	jne    80e4 <fwp_read_text_line+0x64>
    80d2:	48 ff c9             	dec    %rcx
    80d5:	48 89 4b 08          	mov    %rcx,0x8(%rbx)
    80d9:	eb 05                	jmp    80e0 <fwp_read_text_line+0x60>
    80db:	48 85 c0             	test   %rax,%rax
    80de:	74 08                	je     80e8 <fwp_read_text_line+0x68>
    80e0:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    80e4:	c6 04 08 00          	movb   $0x0,(%rax,%rcx,1)
    80e8:	b8 01 00 00 00       	mov    $0x1,%eax
    80ed:	5b                   	pop    %rbx
    80ee:	c3                   	ret
    80ef:	31 c0                	xor    %eax,%eax
    80f1:	5b                   	pop    %rbx
    80f2:	c3                   	ret
    80f3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    80fa:	84 00 00 00 00 00 

0000000000008100 <fwp_mem_realloc>:
    8100:	41 57                	push   %r15
    8102:	41 56                	push   %r14
    8104:	53                   	push   %rbx
    8105:	49 89 d6             	mov    %rdx,%r14
    8108:	49 89 f7             	mov    %rsi,%r15
    810b:	48 89 fb             	mov    %rdi,%rbx
    810e:	48 89 d7             	mov    %rdx,%rdi
    8111:	e8 3a e4 ff ff       	call   6550 <fwp_alloc>
    8116:	48 85 db             	test   %rbx,%rbx
    8119:	74 23                	je     813e <fwp_mem_realloc+0x3e>
    811b:	4d 39 f7             	cmp    %r14,%r15
    811e:	4d 0f 42 f7          	cmovb  %r15,%r14
    8122:	48 89 c7             	mov    %rax,%rdi
    8125:	48 89 de             	mov    %rbx,%rsi
    8128:	4c 89 f2             	mov    %r14,%rdx
    812b:	49 89 c6             	mov    %rax,%r14
    812e:	e8 fd b1 ff ff       	call   3330 <memcpy@plt>
    8133:	48 89 df             	mov    %rbx,%rdi
    8136:	e8 55 00 00 00       	call   8190 <fwp_mem_free>
    813b:	4c 89 f0             	mov    %r14,%rax
    813e:	5b                   	pop    %rbx
    813f:	41 5e                	pop    %r14
    8141:	41 5f                	pop    %r15
    8143:	c3                   	ret
    8144:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    814b:	00 00 00 00 00 

0000000000008150 <fwp_list_from>:
    8150:	41 56                	push   %r14
    8152:	53                   	push   %rbx
    8153:	50                   	push   %rax
    8154:	48 89 fb             	mov    %rdi,%rbx
    8157:	48 85 f6             	test   %rsi,%rsi
    815a:	74 28                	je     8184 <fwp_list_from+0x34>
    815c:	49 89 f6             	mov    %rsi,%r14
    815f:	31 c0                	xor    %eax,%eax
    8161:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8168:	0f 1f 84 00 00 00 00 
    816f:	00 
    8170:	4a 8b 7c f3 f8       	mov    -0x8(%rbx,%r14,8),%rdi
    8175:	48 89 c6             	mov    %rax,%rsi
    8178:	e8 43 08 00 00       	call   89c0 <fwp_cons>
    817d:	49 ff ce             	dec    %r14
    8180:	75 ee                	jne    8170 <fwp_list_from+0x20>
    8182:	eb 02                	jmp    8186 <fwp_list_from+0x36>
    8184:	31 c0                	xor    %eax,%eax
    8186:	48 83 c4 08          	add    $0x8,%rsp
    818a:	5b                   	pop    %rbx
    818b:	41 5e                	pop    %r14
    818d:	c3                   	ret
    818e:	66 90                	xchg   %ax,%ax

0000000000008190 <fwp_mem_free>:
    8190:	48 85 ff             	test   %rdi,%rdi
    8193:	0f 84 c7 01 00 00    	je     8360 <fwp_mem_free+0x1d0>
    8199:	41 57                	push   %r15
    819b:	41 56                	push   %r14
    819d:	53                   	push   %rbx
    819e:	48 83 ec 10          	sub    $0x10,%rsp
    81a2:	49 89 ff             	mov    %rdi,%r15
    81a5:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    81aa:	e8 d1 de ff ff       	call   6080 <fwp_gc_chunk_of>
    81af:	48 85 c0             	test   %rax,%rax
    81b2:	0f 84 9f 01 00 00    	je     8357 <fwp_mem_free+0x1c7>
    81b8:	49 89 c6             	mov    %rax,%r14
    81bb:	0f b6 00             	movzbl (%rax),%eax
    81be:	83 f8 02             	cmp    $0x2,%eax
    81c1:	0f 84 96 00 00 00    	je     825d <fwp_mem_free+0xcd>
    81c7:	83 f8 01             	cmp    $0x1,%eax
    81ca:	0f 85 87 01 00 00    	jne    8357 <fwp_mem_free+0x1c7>
    81d0:	41 0f b6 46 01       	movzbl 0x1(%r14),%eax
    81d5:	41 0f b6 4e 02       	movzbl 0x2(%r14),%ecx
    81da:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    81e1:	48 8d 35 b0 d0 00 00 	lea    0xd0b0(%rip),%rsi        # 15298 <fwp_gc>
    81e8:	48 01 c6             	add    %rax,%rsi
    81eb:	48 8d 3c 49          	lea    (%rcx,%rcx,2),%rdi
    81ef:	41 0f b7 c7          	movzwl %r15w,%eax
    81f3:	31 d2                	xor    %edx,%edx
    81f5:	41 f7 76 08          	divl   0x8(%r14)
    81f9:	48 c7 c2 fe ff ff ff 	mov    $0xfffffffffffffffe,%rdx
    8200:	89 c1                	mov    %eax,%ecx
    8202:	48 d3 c2             	rol    %cl,%rdx
    8205:	48 8d 1c fe          	lea    (%rsi,%rdi,8),%rbx
    8209:	48 83 c3 08          	add    $0x8,%rbx
    820d:	49 8d 3c 06          	lea    (%r14,%rax,1),%rdi
    8211:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    8218:	c1 e8 03             	shr    $0x3,%eax
    821b:	25 f8 1f 00 00       	and    $0x1ff8,%eax
    8220:	49 21 54 06 28       	and    %rdx,0x28(%r14,%rax,1)
    8225:	e8 86 bf ff ff       	call   41b0 <fwp_rc_clear_slot>
    822a:	83 3d 6b e0 00 00 00 	cmpl   $0x0,0xe06b(%rip)        # 1629c <fwp_gc+0x1004>
    8231:	74 0e                	je     8241 <fwp_mem_free+0xb1>
    8233:	41 8b 56 08          	mov    0x8(%r14),%edx
    8237:	4c 89 ff             	mov    %r15,%rdi
    823a:	31 f6                	xor    %esi,%esi
    823c:	e8 cf af ff ff       	call   3210 <memset@plt>
    8241:	48 8b 03             	mov    (%rbx),%rax
    8244:	48 f7 d0             	not    %rax
    8247:	49 89 07             	mov    %rax,(%r15)
    824a:	4c 89 3b             	mov    %r15,(%rbx)
    824d:	41 8b 46 08          	mov    0x8(%r14),%eax
    8251:	48 01 05 40 d0 00 00 	add    %rax,0xd040(%rip)        # 15298 <fwp_gc>
    8258:	e9 fa 00 00 00       	jmp    8357 <fwp_mem_free+0x1c7>
    825d:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    8262:	48 89 df             	mov    %rbx,%rdi
    8265:	e8 66 bf ff ff       	call   41d0 <fwp_gc_chunk_addr>
    826a:	4c 39 f8             	cmp    %r15,%rax
    826d:	0f 85 e4 00 00 00    	jne    8357 <fwp_mem_free+0x1c7>
    8273:	49 8b 46 18          	mov    0x18(%r14),%rax
    8277:	48 01 05 1a d0 00 00 	add    %rax,0xd01a(%rip)        # 15298 <fwp_gc>
    827e:	41 c6 46 03 00       	movb   $0x0,0x3(%r14)
    8283:	4c 89 f7             	mov    %r14,%rdi
    8286:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    828d:	e8 1e bf ff ff       	call   41b0 <fwp_rc_clear_slot>
    8292:	41 8b 46 10          	mov    0x10(%r14),%eax
    8296:	48 85 c0             	test   %rax,%rax
    8299:	0f 84 91 00 00 00    	je     8330 <fwp_mem_free+0x1a0>
    829f:	48 8b 0d 6a e0 00 00 	mov    0xe06a(%rip),%rcx        # 16310 <fwp_gc+0x1078>
    82a6:	48 69 f3 28 12 00 00 	imul   $0x1228,%rbx,%rsi
    82ad:	89 c2                	mov    %eax,%edx
    82af:	83 e2 03             	and    $0x3,%edx
    82b2:	83 f8 04             	cmp    $0x4,%eax
    82b5:	73 04                	jae    82bb <fwp_mem_free+0x12b>
    82b7:	31 ff                	xor    %edi,%edi
    82b9:	eb 41                	jmp    82fc <fwp_mem_free+0x16c>
    82bb:	4c 8d 04 31          	lea    (%rcx,%rsi,1),%r8
    82bf:	41 89 c1             	mov    %eax,%r9d
    82c2:	41 83 e1 fc          	and    $0xfffffffc,%r9d
    82c6:	31 ff                	xor    %edi,%edi
    82c8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    82cf:	00 
    82d0:	41 c6 00 00          	movb   $0x0,(%r8)
    82d4:	41 c6 80 28 12 00 00 	movb   $0x0,0x1228(%r8)
    82db:	00 
    82dc:	41 c6 80 50 24 00 00 	movb   $0x0,0x2450(%r8)
    82e3:	00 
    82e4:	41 c6 80 78 36 00 00 	movb   $0x0,0x3678(%r8)
    82eb:	00 
    82ec:	48 83 c7 04          	add    $0x4,%rdi
    82f0:	49 81 c0 a0 48 00 00 	add    $0x48a0,%r8
    82f7:	49 39 f9             	cmp    %rdi,%r9
    82fa:	75 d4                	jne    82d0 <fwp_mem_free+0x140>
    82fc:	48 85 d2             	test   %rdx,%rdx
    82ff:	74 2f                	je     8330 <fwp_mem_free+0x1a0>
    8301:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    8308:	48 01 f7             	add    %rsi,%rdi
    830b:	48 01 f9             	add    %rdi,%rcx
    830e:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    8315:	31 f6                	xor    %esi,%esi
    8317:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    831e:	00 00 
    8320:	c6 04 31 00          	movb   $0x0,(%rcx,%rsi,1)
    8324:	48 81 c6 28 12 00 00 	add    $0x1228,%rsi
    832b:	48 39 f2             	cmp    %rsi,%rdx
    832e:	75 f0                	jne    8320 <fwp_mem_free+0x190>
    8330:	48 01 05 41 e1 00 00 	add    %rax,0xe141(%rip)        # 16478 <fwp_gc+0x11e0>
    8337:	48 3b 1d ca df 00 00 	cmp    0xdfca(%rip),%rbx        # 16308 <fwp_gc+0x1070>
    833e:	73 07                	jae    8347 <fwp_mem_free+0x1b7>
    8340:	48 89 1d c1 df 00 00 	mov    %rbx,0xdfc1(%rip)        # 16308 <fwp_gc+0x1070>
    8347:	48 3b 1d b2 df 00 00 	cmp    0xdfb2(%rip),%rbx        # 16300 <fwp_gc+0x1068>
    834e:	73 07                	jae    8357 <fwp_mem_free+0x1c7>
    8350:	48 89 1d a9 df 00 00 	mov    %rbx,0xdfa9(%rip)        # 16300 <fwp_gc+0x1068>
    8357:	48 83 c4 10          	add    $0x10,%rsp
    835b:	5b                   	pop    %rbx
    835c:	41 5e                	pop    %r14
    835e:	41 5f                	pop    %r15
    8360:	c3                   	ret
    8361:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8368:	0f 1f 84 00 00 00 00 
    836f:	00 

0000000000008370 <fwp_pipe_out_end>:
    8370:	50                   	push   %rax
    8371:	8b 05 c9 f0 01 00    	mov    0x1f0c9(%rip),%eax        # 27440 <fwp_po_kind>
    8377:	83 f8 02             	cmp    $0x2,%eax
    837a:	74 1c                	je     8398 <fwp_pipe_out_end+0x28>
    837c:	83 f8 01             	cmp    $0x1,%eax
    837f:	75 3d                	jne    83be <fwp_pipe_out_end+0x4e>
    8381:	e8 3a 2b 00 00       	call   aec0 <fwp_po_flush_sock>
    8386:	8b 3d 30 e9 00 00    	mov    0xe930(%rip),%edi        # 16cbc <fwp_po_sock>
    838c:	be 01 00 00 00       	mov    $0x1,%esi
    8391:	e8 ca ad ff ff       	call   3160 <shutdown@plt>
    8396:	eb 35                	jmp    83cd <fwp_pipe_out_end+0x5d>
    8398:	48 8b 35 b1 f0 02 00 	mov    0x2f0b1(%rip),%rsi        # 37450 <fwp_po_ring>
    839f:	c7 86 40 01 00 00 01 	movl   $0x1,0x140(%rsi)
    83a6:	00 00 00 
    83a9:	48 8d be c0 00 00 00 	lea    0xc0(%rsi),%rdi
    83b0:	48 81 c6 c4 00 00 00 	add    $0xc4,%rsi
    83b7:	e8 14 2d 00 00       	call   b0d0 <fwp_ring_wake>
    83bc:	eb 0f                	jmp    83cd <fwp_pipe_out_end+0x5d>
    83be:	48 8b 05 eb cb 00 00 	mov    0xcbeb(%rip),%rax        # 14fb0 <stdout@GLIBC_2.2.5>
    83c5:	48 8b 38             	mov    (%rax),%rdi
    83c8:	e8 83 af ff ff       	call   3350 <fflush@plt>
    83cd:	8b 3d e5 e8 00 00    	mov    0xe8e5(%rip),%edi        # 16cb8 <fwp_po_listen>
    83d3:	85 ff                	test   %edi,%edi
    83d5:	78 0f                	js     83e6 <fwp_pipe_out_end+0x76>
    83d7:	e8 54 ae ff ff       	call   3230 <close@plt>
    83dc:	c7 05 d2 e8 00 00 ff 	movl   $0xffffffff,0xe8d2(%rip)        # 16cb8 <fwp_po_listen>
    83e3:	ff ff ff 
    83e6:	58                   	pop    %rax
    83e7:	c3                   	ret
    83e8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    83ef:	00 

00000000000083f0 <fwp_valid_utf8>:
    83f0:	48 85 f6             	test   %rsi,%rsi
    83f3:	0f 84 48 01 00 00    	je     8541 <fwp_valid_utf8+0x151>
    83f9:	53                   	push   %rbx
    83fa:	31 c9                	xor    %ecx,%ecx
    83fc:	eb 0e                	jmp    840c <fwp_valid_utf8+0x1c>
    83fe:	66 90                	xchg   %ax,%ax
    8400:	48 ff c1             	inc    %rcx
    8403:	48 39 f1             	cmp    %rsi,%rcx
    8406:	0f 83 2e 01 00 00    	jae    853a <fwp_valid_utf8+0x14a>
    840c:	44 0f b6 14 0f       	movzbl (%rdi,%rcx,1),%r10d
    8411:	45 84 d2             	test   %r10b,%r10b
    8414:	79 ea                	jns    8400 <fwp_valid_utf8+0x10>
    8416:	41 8d 42 3e          	lea    0x3e(%r10),%eax
    841a:	3c 1e                	cmp    $0x1e,%al
    841c:	73 12                	jae    8430 <fwp_valid_utf8+0x40>
    841e:	ba 80 00 00 00       	mov    $0x80,%edx
    8423:	b8 01 00 00 00       	mov    $0x1,%eax
    8428:	41 b8 1f 00 00 00    	mov    $0x1f,%r8d
    842e:	eb 37                	jmp    8467 <fwp_valid_utf8+0x77>
    8430:	44 89 d0             	mov    %r10d,%eax
    8433:	24 f0                	and    $0xf0,%al
    8435:	3c e0                	cmp    $0xe0,%al
    8437:	75 12                	jne    844b <fwp_valid_utf8+0x5b>
    8439:	ba 00 08 00 00       	mov    $0x800,%edx
    843e:	b8 02 00 00 00       	mov    $0x2,%eax
    8443:	41 b8 0f 00 00 00    	mov    $0xf,%r8d
    8449:	eb 1c                	jmp    8467 <fwp_valid_utf8+0x77>
    844b:	41 8d 42 10          	lea    0x10(%r10),%eax
    844f:	3c 04                	cmp    $0x4,%al
    8451:	0f 87 f0 00 00 00    	ja     8547 <fwp_valid_utf8+0x157>
    8457:	ba 00 00 01 00       	mov    $0x10000,%edx
    845c:	b8 03 00 00 00       	mov    $0x3,%eax
    8461:	41 b8 07 00 00 00    	mov    $0x7,%r8d
    8467:	41 89 c1             	mov    %eax,%r9d
    846a:	4e 8d 1c 09          	lea    (%rcx,%r9,1),%r11
    846e:	31 c0                	xor    %eax,%eax
    8470:	49 39 f3             	cmp    %rsi,%r11
    8473:	0f 83 c6 00 00 00    	jae    853f <fwp_valid_utf8+0x14f>
    8479:	44 0f b6 5c 0f 01    	movzbl 0x1(%rdi,%rcx,1),%r11d
    847f:	44 89 db             	mov    %r11d,%ebx
    8482:	83 e3 c0             	and    $0xffffffc0,%ebx
    8485:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
    848b:	0f 85 ae 00 00 00    	jne    853f <fwp_valid_utf8+0x14f>
    8491:	45 21 d0             	and    %r10d,%r8d
    8494:	45 8d 51 01          	lea    0x1(%r9),%r10d
    8498:	44 89 c3             	mov    %r8d,%ebx
    849b:	c1 e3 06             	shl    $0x6,%ebx
    849e:	41 83 e3 3f          	and    $0x3f,%r11d
    84a2:	41 09 db             	or     %ebx,%r11d
    84a5:	41 83 fa 02          	cmp    $0x2,%r10d
    84a9:	75 0d                	jne    84b8 <fwp_valid_utf8+0xc8>
    84ab:	45 89 da             	mov    %r11d,%r10d
    84ae:	41 39 d2             	cmp    %edx,%r10d
    84b1:	73 62                	jae    8515 <fwp_valid_utf8+0x125>
    84b3:	e9 87 00 00 00       	jmp    853f <fwp_valid_utf8+0x14f>
    84b8:	44 0f b6 44 0f 02    	movzbl 0x2(%rdi,%rcx,1),%r8d
    84be:	44 89 c3             	mov    %r8d,%ebx
    84c1:	83 e3 c0             	and    $0xffffffc0,%ebx
    84c4:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
    84ca:	75 73                	jne    853f <fwp_valid_utf8+0x14f>
    84cc:	44 89 db             	mov    %r11d,%ebx
    84cf:	c1 e3 06             	shl    $0x6,%ebx
    84d2:	41 83 e0 3f          	and    $0x3f,%r8d
    84d6:	41 09 d8             	or     %ebx,%r8d
    84d9:	41 83 fa 03          	cmp    $0x3,%r10d
    84dd:	75 0d                	jne    84ec <fwp_valid_utf8+0xfc>
    84df:	45 89 c2             	mov    %r8d,%r10d
    84e2:	45 89 d8             	mov    %r11d,%r8d
    84e5:	41 39 d2             	cmp    %edx,%r10d
    84e8:	73 2b                	jae    8515 <fwp_valid_utf8+0x125>
    84ea:	eb 53                	jmp    853f <fwp_valid_utf8+0x14f>
    84ec:	44 0f b6 54 0f 03    	movzbl 0x3(%rdi,%rcx,1),%r10d
    84f2:	45 89 d3             	mov    %r10d,%r11d
    84f5:	41 83 e3 c0          	and    $0xffffffc0,%r11d
    84f9:	41 81 fb 80 00 00 00 	cmp    $0x80,%r11d
    8500:	75 3d                	jne    853f <fwp_valid_utf8+0x14f>
    8502:	45 89 c3             	mov    %r8d,%r11d
    8505:	41 c1 e3 06          	shl    $0x6,%r11d
    8509:	41 83 e2 3f          	and    $0x3f,%r10d
    850d:	45 09 da             	or     %r11d,%r10d
    8510:	41 39 d2             	cmp    %edx,%r10d
    8513:	72 2a                	jb     853f <fwp_valid_utf8+0x14f>
    8515:	41 81 fa ff ff 10 00 	cmp    $0x10ffff,%r10d
    851c:	77 21                	ja     853f <fwp_valid_utf8+0x14f>
    851e:	41 83 e0 e0          	and    $0xffffffe0,%r8d
    8522:	41 81 f8 60 03 00 00 	cmp    $0x360,%r8d
    8529:	74 14                	je     853f <fwp_valid_utf8+0x14f>
    852b:	4c 01 c9             	add    %r9,%rcx
    852e:	48 ff c1             	inc    %rcx
    8531:	48 39 f1             	cmp    %rsi,%rcx
    8534:	0f 82 d2 fe ff ff    	jb     840c <fwp_valid_utf8+0x1c>
    853a:	b8 01 00 00 00       	mov    $0x1,%eax
    853f:	5b                   	pop    %rbx
    8540:	c3                   	ret
    8541:	b8 01 00 00 00       	mov    $0x1,%eax
    8546:	c3                   	ret
    8547:	31 c0                	xor    %eax,%eax
    8549:	5b                   	pop    %rbx
    854a:	c3                   	ret
    854b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000008550 <fwp_str_new>:
    8550:	41 57                	push   %r15
    8552:	41 56                	push   %r14
    8554:	53                   	push   %rbx
    8555:	48 89 f3             	mov    %rsi,%rbx
    8558:	49 89 fe             	mov    %rdi,%r14
    855b:	48 8d 7e 09          	lea    0x9(%rsi),%rdi
    855f:	e8 4c ec ff ff       	call   71b0 <fwp_alloc_leaf>
    8564:	49 89 c7             	mov    %rax,%r15
    8567:	48 89 18             	mov    %rbx,(%rax)
    856a:	48 8d 78 08          	lea    0x8(%rax),%rdi
    856e:	4c 89 f6             	mov    %r14,%rsi
    8571:	48 89 da             	mov    %rbx,%rdx
    8574:	e8 b7 ad ff ff       	call   3330 <memcpy@plt>
    8579:	41 c6 44 1f 08 00    	movb   $0x0,0x8(%r15,%rbx,1)
    857f:	4c 89 f8             	mov    %r15,%rax
    8582:	5b                   	pop    %rbx
    8583:	41 5e                	pop    %r14
    8585:	41 5f                	pop    %r15
    8587:	c3                   	ret
    8588:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    858f:	00 

0000000000008590 <buf_putc>:
    8590:	50                   	push   %rax
    8591:	40 88 74 24 07       	mov    %sil,0x7(%rsp)
    8596:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
    859b:	ba 01 00 00 00       	mov    $0x1,%edx
    85a0:	e8 3b 00 00 00       	call   85e0 <buf_put>
    85a5:	58                   	pop    %rax
    85a6:	c3                   	ret
    85a7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    85ae:	00 00 

00000000000085b0 <buf_puts>:
    85b0:	41 56                	push   %r14
    85b2:	53                   	push   %rbx
    85b3:	50                   	push   %rax
    85b4:	48 89 f3             	mov    %rsi,%rbx
    85b7:	49 89 fe             	mov    %rdi,%r14
    85ba:	48 89 f7             	mov    %rsi,%rdi
    85bd:	e8 ae ab ff ff       	call   3170 <strlen@plt>
    85c2:	4c 89 f7             	mov    %r14,%rdi
    85c5:	48 89 de             	mov    %rbx,%rsi
    85c8:	48 89 c2             	mov    %rax,%rdx
    85cb:	48 83 c4 08          	add    $0x8,%rsp
    85cf:	5b                   	pop    %rbx
    85d0:	41 5e                	pop    %r14
    85d2:	eb 0c                	jmp    85e0 <buf_put>
    85d4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    85db:	00 00 00 00 00 

00000000000085e0 <buf_put>:
    85e0:	41 57                	push   %r15
    85e2:	41 56                	push   %r14
    85e4:	53                   	push   %rbx
    85e5:	48 89 d3             	mov    %rdx,%rbx
    85e8:	49 89 f6             	mov    %rsi,%r14
    85eb:	49 89 ff             	mov    %rdi,%r15
    85ee:	48 89 d6             	mov    %rdx,%rsi
    85f1:	e8 6a 00 00 00       	call   8660 <buf_grow>
    85f6:	49 8b 3f             	mov    (%r15),%rdi
    85f9:	49 03 7f 08          	add    0x8(%r15),%rdi
    85fd:	4c 89 f6             	mov    %r14,%rsi
    8600:	48 89 da             	mov    %rbx,%rdx
    8603:	e8 28 ad ff ff       	call   3330 <memcpy@plt>
    8608:	49 03 5f 08          	add    0x8(%r15),%rbx
    860c:	49 89 5f 08          	mov    %rbx,0x8(%r15)
    8610:	49 8b 07             	mov    (%r15),%rax
    8613:	c6 04 18 00          	movb   $0x0,(%rax,%rbx,1)
    8617:	5b                   	pop    %rbx
    8618:	41 5e                	pop    %r14
    861a:	41 5f                	pop    %r15
    861c:	c3                   	ret
    861d:	0f 1f 00             	nopl   (%rax)

0000000000008620 <buf_to_str>:
    8620:	41 56                	push   %r14
    8622:	53                   	push   %rbx
    8623:	50                   	push   %rax
    8624:	48 89 fb             	mov    %rdi,%rbx
    8627:	48 8b 07             	mov    (%rdi),%rax
    862a:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    862e:	48 85 c0             	test   %rax,%rax
    8631:	48 8d 3d b7 78 00 00 	lea    0x78b7(%rip),%rdi        # feef <exec_in_fp0+0x7ef>
    8638:	48 0f 45 f8          	cmovne %rax,%rdi
    863c:	e8 0f ff ff ff       	call   8550 <fwp_str_new>
    8641:	49 89 c6             	mov    %rax,%r14
    8644:	48 8b 3b             	mov    (%rbx),%rdi
    8647:	e8 04 aa ff ff       	call   3050 <free@plt>
    864c:	4c 89 f0             	mov    %r14,%rax
    864f:	48 83 c4 08          	add    $0x8,%rsp
    8653:	5b                   	pop    %rbx
    8654:	41 5e                	pop    %r14
    8656:	c3                   	ret
    8657:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    865e:	00 00 

0000000000008660 <buf_grow>:
    8660:	41 56                	push   %r14
    8662:	53                   	push   %rbx
    8663:	50                   	push   %rax
    8664:	48 8b 47 08          	mov    0x8(%rdi),%rax
    8668:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    866c:	74 73                	je     86e1 <buf_grow+0x81>
    866e:	48 c7 c1 fe ff ff ff 	mov    $0xfffffffffffffffe,%rcx
    8675:	48 29 c1             	sub    %rax,%rcx
    8678:	48 39 f1             	cmp    %rsi,%rcx
    867b:	72 64                	jb     86e1 <buf_grow+0x81>
    867d:	48 89 fb             	mov    %rdi,%rbx
    8680:	48 01 f0             	add    %rsi,%rax
    8683:	48 ff c0             	inc    %rax
    8686:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    868a:	48 39 c8             	cmp    %rcx,%rax
    868d:	76 4a                	jbe    86d9 <buf_grow+0x79>
    868f:	48 85 c9             	test   %rcx,%rcx
    8692:	41 be 40 00 00 00    	mov    $0x40,%r14d
    8698:	4c 0f 45 f1          	cmovne %rcx,%r14
    869c:	49 39 c6             	cmp    %rax,%r14
    869f:	73 21                	jae    86c2 <buf_grow+0x62>
    86a1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    86a8:	0f 1f 84 00 00 00 00 
    86af:	00 
    86b0:	4d 85 f6             	test   %r14,%r14
    86b3:	78 0a                	js     86bf <buf_grow+0x5f>
    86b5:	4d 01 f6             	add    %r14,%r14
    86b8:	49 39 c6             	cmp    %rax,%r14
    86bb:	72 f3                	jb     86b0 <buf_grow+0x50>
    86bd:	eb 03                	jmp    86c2 <buf_grow+0x62>
    86bf:	49 89 c6             	mov    %rax,%r14
    86c2:	48 8b 3b             	mov    (%rbx),%rdi
    86c5:	4c 89 f6             	mov    %r14,%rsi
    86c8:	e8 b3 ac ff ff       	call   3380 <realloc@plt>
    86cd:	48 85 c0             	test   %rax,%rax
    86d0:	74 0f                	je     86e1 <buf_grow+0x81>
    86d2:	48 89 03             	mov    %rax,(%rbx)
    86d5:	4c 89 73 10          	mov    %r14,0x10(%rbx)
    86d9:	48 83 c4 08          	add    $0x8,%rsp
    86dd:	5b                   	pop    %rbx
    86de:	41 5e                	pop    %r14
    86e0:	c3                   	ret
    86e1:	48 8b 05 f0 c8 00 00 	mov    0xc8f0(%rip),%rax        # 14fd8 <stderr@GLIBC_2.2.5>
    86e8:	48 8b 08             	mov    (%rax),%rcx
    86eb:	48 8d 3d ef 71 00 00 	lea    0x71ef(%rip),%rdi        # f8e1 <exec_in_fp0+0x1e1>
    86f2:	be 13 00 00 00       	mov    $0x13,%esi
    86f7:	ba 01 00 00 00       	mov    $0x1,%edx
    86fc:	e8 9f ad ff ff       	call   34a0 <fwrite@plt>
    8701:	bf 66 00 00 00       	mov    $0x66,%edi
    8706:	e8 75 ad ff ff       	call   3480 <exit@plt>
    870b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000008710 <fwp_is_number_arg>:
    8710:	31 c0                	xor    %eax,%eax
    8712:	80 3f 2d             	cmpb   $0x2d,(%rdi)
    8715:	75 19                	jne    8730 <fwp_is_number_arg+0x20>
    8717:	0f b6 4f 01          	movzbl 0x1(%rdi),%ecx
    871b:	8d 51 d0             	lea    -0x30(%rcx),%edx
    871e:	b8 01 00 00 00       	mov    $0x1,%eax
    8723:	80 fa 0a             	cmp    $0xa,%dl
    8726:	72 08                	jb     8730 <fwp_is_number_arg+0x20>
    8728:	31 c0                	xor    %eax,%eax
    872a:	80 f9 2e             	cmp    $0x2e,%cl
    872d:	0f 94 c0             	sete   %al
    8730:	c3                   	ret
    8731:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8738:	0f 1f 84 00 00 00 00 
    873f:	00 

0000000000008740 <fwp_strf>:
    8740:	55                   	push   %rbp
    8741:	41 57                	push   %r15
    8743:	41 56                	push   %r14
    8745:	41 55                	push   %r13
    8747:	41 54                	push   %r12
    8749:	53                   	push   %rbx
    874a:	48 81 ec d8 00 00 00 	sub    $0xd8,%rsp
    8751:	48 89 fb             	mov    %rdi,%rbx
    8754:	48 89 74 24 28       	mov    %rsi,0x28(%rsp)
    8759:	48 89 54 24 30       	mov    %rdx,0x30(%rsp)
    875e:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
    8763:	4c 89 44 24 40       	mov    %r8,0x40(%rsp)
    8768:	4c 89 4c 24 48       	mov    %r9,0x48(%rsp)
    876d:	84 c0                	test   %al,%al
    876f:	74 37                	je     87a8 <fwp_strf+0x68>
    8771:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
    8776:	0f 29 4c 24 60       	movaps %xmm1,0x60(%rsp)
    877b:	0f 29 54 24 70       	movaps %xmm2,0x70(%rsp)
    8780:	0f 29 9c 24 80 00 00 	movaps %xmm3,0x80(%rsp)
    8787:	00 
    8788:	0f 29 a4 24 90 00 00 	movaps %xmm4,0x90(%rsp)
    878f:	00 
    8790:	0f 29 ac 24 a0 00 00 	movaps %xmm5,0xa0(%rsp)
    8797:	00 
    8798:	0f 29 b4 24 b0 00 00 	movaps %xmm6,0xb0(%rsp)
    879f:	00 
    87a0:	0f 29 bc 24 c0 00 00 	movaps %xmm7,0xc0(%rsp)
    87a7:	00 
    87a8:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    87ad:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    87b2:	48 8d 84 24 10 01 00 	lea    0x110(%rsp),%rax
    87b9:	00 
    87ba:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    87bf:	48 bd 08 00 00 00 30 	movabs $0x3000000008,%rbp
    87c6:	00 00 00 
    87c9:	48 89 2c 24          	mov    %rbp,(%rsp)
    87cd:	49 89 e6             	mov    %rsp,%r14
    87d0:	31 ff                	xor    %edi,%edi
    87d2:	31 f6                	xor    %esi,%esi
    87d4:	48 89 da             	mov    %rbx,%rdx
    87d7:	4c 89 f1             	mov    %r14,%rcx
    87da:	e8 31 a9 ff ff       	call   3110 <vsnprintf@plt>
    87df:	4c 63 f8             	movslq %eax,%r15
    87e2:	4d 8d 67 01          	lea    0x1(%r15),%r12
    87e6:	4c 89 e7             	mov    %r12,%rdi
    87e9:	e8 c2 e9 ff ff       	call   71b0 <fwp_alloc_leaf>
    87ee:	49 89 c5             	mov    %rax,%r13
    87f1:	48 89 2c 24          	mov    %rbp,(%rsp)
    87f5:	48 8d 84 24 10 01 00 	lea    0x110(%rsp),%rax
    87fc:	00 
    87fd:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    8802:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    8807:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    880c:	4c 89 ef             	mov    %r13,%rdi
    880f:	4c 89 e6             	mov    %r12,%rsi
    8812:	48 89 da             	mov    %rbx,%rdx
    8815:	4c 89 f1             	mov    %r14,%rcx
    8818:	e8 f3 a8 ff ff       	call   3110 <vsnprintf@plt>
    881d:	4c 89 ef             	mov    %r13,%rdi
    8820:	4c 89 fe             	mov    %r15,%rsi
    8823:	e8 28 fd ff ff       	call   8550 <fwp_str_new>
    8828:	48 81 c4 d8 00 00 00 	add    $0xd8,%rsp
    882f:	5b                   	pop    %rbx
    8830:	41 5c                	pop    %r12
    8832:	41 5d                	pop    %r13
    8834:	41 5e                	pop    %r14
    8836:	41 5f                	pop    %r15
    8838:	5d                   	pop    %rbp
    8839:	c3                   	ret
    883a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000008840 <fwp_cli_value>:
    8840:	55                   	push   %rbp
    8841:	41 57                	push   %r15
    8843:	41 56                	push   %r14
    8845:	41 55                	push   %r13
    8847:	41 54                	push   %r12
    8849:	53                   	push   %rbx
    884a:	48 83 ec 58          	sub    $0x58,%rsp
    884e:	49 89 cf             	mov    %rcx,%r15
    8851:	48 89 d3             	mov    %rdx,%rbx
    8854:	49 89 f6             	mov    %rsi,%r14
    8857:	49 89 fc             	mov    %rdi,%r12
    885a:	e8 91 01 00 00       	call   89f0 <fwp_is_enum>
    885f:	85 c0                	test   %eax,%eax
    8861:	0f 84 ef 00 00 00    	je     8956 <fwp_cli_value+0x116>
    8867:	48 89 5c 24 38       	mov    %rbx,0x38(%rsp)
    886c:	0f 57 c0             	xorps  %xmm0,%xmm0
    886f:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    8874:	48 c7 44 24 50 00 00 	movq   $0x0,0x50(%rsp)
    887b:	00 00 
    887d:	0f 29 04 24          	movaps %xmm0,(%rsp)
    8881:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    8888:	00 00 
    888a:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
    888f:	4c 89 e6             	mov    %r12,%rsi
    8892:	4c 89 74 24 30       	mov    %r14,0x30(%rsp)
    8897:	4c 89 f2             	mov    %r14,%rdx
    889a:	e8 d1 01 00 00       	call   8a70 <fwp_loose>
    889f:	4c 8b 6c 24 40       	mov    0x40(%rsp),%r13
    88a4:	31 db                	xor    %ebx,%ebx
    88a6:	83 3d 8b e4 00 00 00 	cmpl   $0x0,0xe48b(%rip)        # 16d38 <d0+0x10>
    88ad:	41 be ff ff ff ff    	mov    $0xffffffff,%r14d
    88b3:	7e 7a                	jle    892f <fwp_cli_value+0xef>
    88b5:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
    88ba:	48 85 ed             	test   %rbp,%rbp
    88bd:	74 70                	je     892f <fwp_cli_value+0xef>
    88bf:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
    88c4:	4c 89 7c 24 28       	mov    %r15,0x28(%rsp)
    88c9:	45 31 ff             	xor    %r15d,%r15d
    88cc:	48 89 e3             	mov    %rsp,%rbx
    88cf:	90                   	nop
    88d0:	48 8b 05 69 e4 00 00 	mov    0xe469(%rip),%rax        # 16d40 <d0+0x18>
    88d7:	4e 8b 24 f8          	mov    (%rax,%r15,8),%r12
    88db:	4c 89 e7             	mov    %r12,%rdi
    88de:	e8 8d a8 ff ff       	call   3170 <strlen@plt>
    88e3:	48 89 df             	mov    %rbx,%rdi
    88e6:	4c 89 e6             	mov    %r12,%rsi
    88e9:	48 89 c2             	mov    %rax,%rdx
    88ec:	e8 7f 01 00 00       	call   8a70 <fwp_loose>
    88f1:	48 39 6c 24 08       	cmp    %rbp,0x8(%rsp)
    88f6:	75 15                	jne    890d <fwp_cli_value+0xcd>
    88f8:	48 8b 3c 24          	mov    (%rsp),%rdi
    88fc:	4c 89 ee             	mov    %r13,%rsi
    88ff:	48 89 ea             	mov    %rbp,%rdx
    8902:	e8 69 aa ff ff       	call   3370 <bcmp@plt>
    8907:	85 c0                	test   %eax,%eax
    8909:	45 0f 44 f7          	cmove  %r15d,%r14d
    890d:	49 ff c7             	inc    %r15
    8910:	48 63 05 21 e4 00 00 	movslq 0xe421(%rip),%rax        # 16d38 <d0+0x10>
    8917:	49 39 c7             	cmp    %rax,%r15
    891a:	7d 05                	jge    8921 <fwp_cli_value+0xe1>
    891c:	45 85 f6             	test   %r14d,%r14d
    891f:	78 af                	js     88d0 <fwp_cli_value+0x90>
    8921:	48 8b 1c 24          	mov    (%rsp),%rbx
    8925:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
    892a:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
    892f:	4c 89 ef             	mov    %r13,%rdi
    8932:	e8 19 a7 ff ff       	call   3050 <free@plt>
    8937:	48 89 df             	mov    %rbx,%rdi
    893a:	e8 11 a7 ff ff       	call   3050 <free@plt>
    893f:	45 85 f6             	test   %r14d,%r14d
    8942:	78 3e                	js     8982 <fwp_cli_value+0x142>
    8944:	44 89 f0             	mov    %r14d,%eax
    8947:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
    894c:	48 89 01             	mov    %rax,(%rcx)
    894f:	bb 01 00 00 00       	mov    $0x1,%ebx
    8954:	eb 50                	jmp    89a6 <fwp_cli_value+0x166>
    8956:	4c 89 e7             	mov    %r12,%rdi
    8959:	4c 89 f6             	mov    %r14,%rsi
    895c:	48 89 da             	mov    %rbx,%rdx
    895f:	e8 fc e9 ff ff       	call   7360 <fwp_parse_text>
    8964:	bb 01 00 00 00       	mov    $0x1,%ebx
    8969:	85 c0                	test   %eax,%eax
    896b:	75 39                	jne    89a6 <fwp_cli_value+0x166>
    896d:	48 8d 3d 10 7a 00 00 	lea    0x7a10(%rip),%rdi        # 10384 <exec_in_fp0+0xc84>
    8974:	48 8d 0d 50 7c 00 00 	lea    0x7c50(%rip),%rcx        # 105cb <exec_in_fp0+0xecb>
    897b:	31 db                	xor    %ebx,%ebx
    897d:	44 89 f6             	mov    %r14d,%esi
    8980:	eb 17                	jmp    8999 <fwp_cli_value+0x159>
    8982:	e8 69 01 00 00       	call   8af0 <fwp_choices>
    8987:	48 8d 48 08          	lea    0x8(%rax),%rcx
    898b:	48 8d 3d da 79 00 00 	lea    0x79da(%rip),%rdi        # 1036c <exec_in_fp0+0xc6c>
    8992:	31 db                	xor    %ebx,%ebx
    8994:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    8999:	4c 89 e2             	mov    %r12,%rdx
    899c:	31 c0                	xor    %eax,%eax
    899e:	e8 9d fd ff ff       	call   8740 <fwp_strf>
    89a3:	49 89 07             	mov    %rax,(%r15)
    89a6:	89 d8                	mov    %ebx,%eax
    89a8:	48 83 c4 58          	add    $0x58,%rsp
    89ac:	5b                   	pop    %rbx
    89ad:	41 5c                	pop    %r12
    89af:	41 5d                	pop    %r13
    89b1:	41 5e                	pop    %r14
    89b3:	41 5f                	pop    %r15
    89b5:	5d                   	pop    %rbp
    89b6:	c3                   	ret
    89b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    89be:	00 00 

00000000000089c0 <fwp_cons>:
    89c0:	48 83 ec 18          	sub    $0x18,%rsp
    89c4:	48 89 3c 24          	mov    %rdi,(%rsp)
    89c8:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    89cd:	48 89 e2             	mov    %rsp,%rdx
    89d0:	bf 01 00 00 00       	mov    $0x1,%edi
    89d5:	be 02 00 00 00       	mov    $0x2,%esi
    89da:	e8 a1 b9 ff ff       	call   4380 <fwp_data>
    89df:	48 83 c4 18          	add    $0x18,%rsp
    89e3:	c3                   	ret
    89e4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    89eb:	00 00 00 00 00 

00000000000089f0 <fwp_is_enum>:
    89f0:	31 c0                	xor    %eax,%eax
    89f2:	83 3d 2f e3 00 00 0e 	cmpl   $0xe,0xe32f(%rip)        # 16d28 <d0>
    89f9:	75 67                	jne    8a62 <fwp_is_enum+0x72>
    89fb:	53                   	push   %rbx
    89fc:	8b 1d 36 e3 00 00    	mov    0xe336(%rip),%ebx        # 16d38 <d0+0x10>
    8a02:	85 db                	test   %ebx,%ebx
    8a04:	74 5b                	je     8a61 <fwp_is_enum+0x71>
    8a06:	48 8b 3d 23 e3 00 00 	mov    0xe323(%rip),%rdi        # 16d30 <d0+0x8>
    8a0d:	48 85 ff             	test   %rdi,%rdi
    8a10:	74 14                	je     8a26 <fwp_is_enum+0x36>
    8a12:	48 8d 35 85 79 00 00 	lea    0x7985(%rip),%rsi        # 1039e <exec_in_fp0+0xc9e>
    8a19:	e8 b2 a8 ff ff       	call   32d0 <strcmp@plt>
    8a1e:	89 c1                	mov    %eax,%ecx
    8a20:	31 c0                	xor    %eax,%eax
    8a22:	85 c9                	test   %ecx,%ecx
    8a24:	74 3b                	je     8a61 <fwp_is_enum+0x71>
    8a26:	85 db                	test   %ebx,%ebx
    8a28:	7e 32                	jle    8a5c <fwp_is_enum+0x6c>
    8a2a:	48 8b 0d 1f e3 00 00 	mov    0xe31f(%rip),%rcx        # 16d50 <d0+0x28>
    8a31:	83 39 00             	cmpl   $0x0,(%rcx)
    8a34:	75 2b                	jne    8a61 <fwp_is_enum+0x71>
    8a36:	b8 01 00 00 00       	mov    $0x1,%eax
    8a3b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8a40:	48 89 c2             	mov    %rax,%rdx
    8a43:	48 39 c3             	cmp    %rax,%rbx
    8a46:	74 0a                	je     8a52 <fwp_is_enum+0x62>
    8a48:	48 8d 42 01          	lea    0x1(%rdx),%rax
    8a4c:	83 3c 91 00          	cmpl   $0x0,(%rcx,%rdx,4)
    8a50:	74 ee                	je     8a40 <fwp_is_enum+0x50>
    8a52:	31 c0                	xor    %eax,%eax
    8a54:	48 39 da             	cmp    %rbx,%rdx
    8a57:	0f 93 c0             	setae  %al
    8a5a:	eb 05                	jmp    8a61 <fwp_is_enum+0x71>
    8a5c:	b8 01 00 00 00       	mov    $0x1,%eax
    8a61:	5b                   	pop    %rbx
    8a62:	c3                   	ret
    8a63:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8a6a:	84 00 00 00 00 00 

0000000000008a70 <fwp_loose>:
    8a70:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
    8a77:	00 
    8a78:	48 85 d2             	test   %rdx,%rdx
    8a7b:	74 63                	je     8ae0 <fwp_loose+0x70>
    8a7d:	41 57                	push   %r15
    8a7f:	41 56                	push   %r14
    8a81:	41 54                	push   %r12
    8a83:	53                   	push   %rbx
    8a84:	50                   	push   %rax
    8a85:	48 89 d3             	mov    %rdx,%rbx
    8a88:	49 89 f6             	mov    %rsi,%r14
    8a8b:	49 89 ff             	mov    %rdi,%r15
    8a8e:	45 31 e4             	xor    %r12d,%r12d
    8a91:	eb 15                	jmp    8aa8 <fwp_loose+0x38>
    8a93:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8a9a:	84 00 00 00 00 00 
    8aa0:	49 ff c4             	inc    %r12
    8aa3:	4c 39 e3             	cmp    %r12,%rbx
    8aa6:	74 2d                	je     8ad5 <fwp_loose+0x65>
    8aa8:	43 0f b6 04 26       	movzbl (%r14,%r12,1),%eax
    8aad:	83 f8 2d             	cmp    $0x2d,%eax
    8ab0:	74 ee                	je     8aa0 <fwp_loose+0x30>
    8ab2:	83 f8 5f             	cmp    $0x5f,%eax
    8ab5:	74 e9                	je     8aa0 <fwp_loose+0x30>
    8ab7:	8d 48 bf             	lea    -0x41(%rax),%ecx
    8aba:	0f b6 d0             	movzbl %al,%edx
    8abd:	0c 20                	or     $0x20,%al
    8abf:	80 f9 1a             	cmp    $0x1a,%cl
    8ac2:	0f b6 c0             	movzbl %al,%eax
    8ac5:	0f 43 c2             	cmovae %edx,%eax
    8ac8:	0f be f0             	movsbl %al,%esi
    8acb:	4c 89 ff             	mov    %r15,%rdi
    8ace:	e8 bd fa ff ff       	call   8590 <buf_putc>
    8ad3:	eb cb                	jmp    8aa0 <fwp_loose+0x30>
    8ad5:	48 83 c4 08          	add    $0x8,%rsp
    8ad9:	5b                   	pop    %rbx
    8ada:	41 5c                	pop    %r12
    8adc:	41 5e                	pop    %r14
    8ade:	41 5f                	pop    %r15
    8ae0:	c3                   	ret
    8ae1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8ae8:	0f 1f 84 00 00 00 00 
    8aef:	00 

0000000000008af0 <fwp_choices>:
    8af0:	41 57                	push   %r15
    8af2:	41 56                	push   %r14
    8af4:	53                   	push   %rbx
    8af5:	48 83 ec 20          	sub    $0x20,%rsp
    8af9:	0f 57 c0             	xorps  %xmm0,%xmm0
    8afc:	0f 29 04 24          	movaps %xmm0,(%rsp)
    8b00:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    8b07:	00 00 
    8b09:	83 3d 28 e2 00 00 00 	cmpl   $0x0,0xe228(%rip)        # 16d38 <d0+0x10>
    8b10:	7e 5b                	jle    8b6d <fwp_choices+0x7d>
    8b12:	48 8b 05 27 e2 00 00 	mov    0xe227(%rip),%rax        # 16d40 <d0+0x18>
    8b19:	48 8b 30             	mov    (%rax),%rsi
    8b1c:	48 89 e7             	mov    %rsp,%rdi
    8b1f:	e8 5c 00 00 00       	call   8b80 <fwp_kebab>
    8b24:	83 3d 0d e2 00 00 02 	cmpl   $0x2,0xe20d(%rip)        # 16d38 <d0+0x10>
    8b2b:	7c 40                	jl     8b6d <fwp_choices+0x7d>
    8b2d:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    8b33:	48 8d 1d 69 78 00 00 	lea    0x7869(%rip),%rbx        # 103a3 <exec_in_fp0+0xca3>
    8b3a:	49 89 e6             	mov    %rsp,%r14
    8b3d:	0f 1f 00             	nopl   (%rax)
    8b40:	4c 89 f7             	mov    %r14,%rdi
    8b43:	48 89 de             	mov    %rbx,%rsi
    8b46:	e8 65 fa ff ff       	call   85b0 <buf_puts>
    8b4b:	48 8b 05 ee e1 00 00 	mov    0xe1ee(%rip),%rax        # 16d40 <d0+0x18>
    8b52:	4a 8b 34 f8          	mov    (%rax,%r15,8),%rsi
    8b56:	4c 89 f7             	mov    %r14,%rdi
    8b59:	e8 22 00 00 00       	call   8b80 <fwp_kebab>
    8b5e:	49 ff c7             	inc    %r15
    8b61:	48 63 05 d0 e1 00 00 	movslq 0xe1d0(%rip),%rax        # 16d38 <d0+0x10>
    8b68:	49 39 c7             	cmp    %rax,%r15
    8b6b:	7c d3                	jl     8b40 <fwp_choices+0x50>
    8b6d:	48 89 e7             	mov    %rsp,%rdi
    8b70:	e8 ab fa ff ff       	call   8620 <buf_to_str>
    8b75:	48 83 c4 20          	add    $0x20,%rsp
    8b79:	5b                   	pop    %rbx
    8b7a:	41 5e                	pop    %r14
    8b7c:	41 5f                	pop    %r15
    8b7e:	c3                   	ret
    8b7f:	90                   	nop

0000000000008b80 <fwp_kebab>:
    8b80:	41 57                	push   %r15
    8b82:	41 56                	push   %r14
    8b84:	53                   	push   %rbx
    8b85:	44 0f b6 3e          	movzbl (%rsi),%r15d
    8b89:	45 84 ff             	test   %r15b,%r15b
    8b8c:	74 71                	je     8bff <fwp_kebab+0x7f>
    8b8e:	48 89 f3             	mov    %rsi,%rbx
    8b91:	49 89 fe             	mov    %rdi,%r14
    8b94:	48 ff c3             	inc    %rbx
    8b97:	31 c0                	xor    %eax,%eax
    8b99:	eb 36                	jmp    8bd1 <fwp_kebab+0x51>
    8b9b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8ba0:	41 0f be f7          	movsbl %r15b,%esi
    8ba4:	4c 89 f7             	mov    %r14,%rdi
    8ba7:	e8 e4 f9 ff ff       	call   8590 <buf_putc>
    8bac:	41 8d 47 9f          	lea    -0x61(%r15),%eax
    8bb0:	3c 1a                	cmp    $0x1a,%al
    8bb2:	0f 92 c0             	setb   %al
    8bb5:	41 80 c7 d0          	add    $0xd0,%r15b
    8bb9:	41 80 ff 0a          	cmp    $0xa,%r15b
    8bbd:	0f 92 c1             	setb   %cl
    8bc0:	08 c1                	or     %al,%cl
    8bc2:	0f b6 c1             	movzbl %cl,%eax
    8bc5:	44 0f b6 3b          	movzbl (%rbx),%r15d
    8bc9:	48 ff c3             	inc    %rbx
    8bcc:	45 84 ff             	test   %r15b,%r15b
    8bcf:	74 2e                	je     8bff <fwp_kebab+0x7f>
    8bd1:	41 8d 4f bf          	lea    -0x41(%r15),%ecx
    8bd5:	80 f9 19             	cmp    $0x19,%cl
    8bd8:	77 c6                	ja     8ba0 <fwp_kebab+0x20>
    8bda:	85 c0                	test   %eax,%eax
    8bdc:	74 0d                	je     8beb <fwp_kebab+0x6b>
    8bde:	4c 89 f7             	mov    %r14,%rdi
    8be1:	be 2d 00 00 00       	mov    $0x2d,%esi
    8be6:	e8 a5 f9 ff ff       	call   8590 <buf_putc>
    8beb:	41 80 cf 20          	or     $0x20,%r15b
    8bef:	41 0f be f7          	movsbl %r15b,%esi
    8bf3:	4c 89 f7             	mov    %r14,%rdi
    8bf6:	e8 95 f9 ff ff       	call   8590 <buf_putc>
    8bfb:	31 c0                	xor    %eax,%eax
    8bfd:	eb c6                	jmp    8bc5 <fwp_kebab+0x45>
    8bff:	5b                   	pop    %rbx
    8c00:	41 5e                	pop    %r14
    8c02:	41 5f                	pop    %r15
    8c04:	c3                   	ret
    8c05:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    8c0c:	00 00 00 00 

0000000000008c10 <tp_value>:
    8c10:	55                   	push   %rbp
    8c11:	41 57                	push   %r15
    8c13:	41 56                	push   %r14
    8c15:	41 55                	push   %r13
    8c17:	41 54                	push   %r12
    8c19:	53                   	push   %rbx
    8c1a:	48 81 ec a8 01 00 00 	sub    $0x1a8,%rsp
    8c21:	48 89 cd             	mov    %rcx,%rbp
    8c24:	49 89 f6             	mov    %rsi,%r14
    8c27:	49 89 ff             	mov    %rdi,%r15
    8c2a:	85 d2                	test   %edx,%edx
    8c2c:	74 4c                	je     8c7a <tp_value+0x6a>
    8c2e:	41 83 3e 0c          	cmpl   $0xc,(%r14)
    8c32:	75 46                	jne    8c7a <tp_value+0x6a>
    8c34:	4d 8b 77 08          	mov    0x8(%r15),%r14
    8c38:	49 8b 47 10          	mov    0x10(%r15),%rax
    8c3c:	4d 8b 27             	mov    (%r15),%r12
    8c3f:	49 01 c4             	add    %rax,%r12
    8c42:	49 29 c6             	sub    %rax,%r14
    8c45:	4c 89 e7             	mov    %r12,%rdi
    8c48:	4c 89 f6             	mov    %r14,%rsi
    8c4b:	e8 a0 f7 ff ff       	call   83f0 <fwp_valid_utf8>
    8c50:	85 c0                	test   %eax,%eax
    8c52:	0f 84 e9 07 00 00    	je     9441 <tp_value+0x831>
    8c58:	4c 89 e7             	mov    %r12,%rdi
    8c5b:	4c 89 f6             	mov    %r14,%rsi
    8c5e:	e8 ed f8 ff ff       	call   8550 <fwp_str_new>
    8c63:	48 89 45 00          	mov    %rax,0x0(%rbp)
    8c67:	49 8b 47 08          	mov    0x8(%r15),%rax
    8c6b:	49 89 47 10          	mov    %rax,0x10(%r15)
    8c6f:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    8c75:	e9 ca 07 00 00       	jmp    9444 <tp_value+0x834>
    8c7a:	41 89 d5             	mov    %edx,%r13d
    8c7d:	4c 89 ff             	mov    %r15,%rdi
    8c80:	e8 bb 08 00 00       	call   9540 <tp_ws>
    8c85:	41 8b 06             	mov    (%r14),%eax
    8c88:	45 31 e4             	xor    %r12d,%r12d
    8c8b:	48 83 f8 15          	cmp    $0x15,%rax
    8c8f:	0f 87 af 07 00 00    	ja     9444 <tp_value+0x834>
    8c95:	48 8d 0d 3c 65 00 00 	lea    0x653c(%rip),%rcx        # f1d8 <_IO_stdin_used+0x1d8>
    8c9c:	48 63 14 81          	movslq (%rcx,%rax,4),%rdx
    8ca0:	48 01 ca             	add    %rcx,%rdx
    8ca3:	ff e2                	jmp    *%rdx
    8ca5:	4c 89 ff             	mov    %r15,%rdi
    8ca8:	4c 89 f6             	mov    %r14,%rsi
    8cab:	48 89 ea             	mov    %rbp,%rdx
    8cae:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    8cb5:	5b                   	pop    %rbx
    8cb6:	41 5c                	pop    %r12
    8cb8:	41 5d                	pop    %r13
    8cba:	41 5e                	pop    %r14
    8cbc:	41 5f                	pop    %r15
    8cbe:	5d                   	pop    %rbp
    8cbf:	e9 cc 08 00 00       	jmp    9590 <tp_int>
    8cc4:	41 0f 10 46 38       	movups 0x38(%r14),%xmm0
    8cc9:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    8cce:	31 c9                	xor    %ecx,%ecx
    8cd0:	83 f8 13             	cmp    $0x13,%eax
    8cd3:	0f 94 c1             	sete   %cl
    8cd6:	0f 57 c0             	xorps  %xmm0,%xmm0
    8cd9:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    8cde:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    8ce5:	00 00 
    8ce7:	89 4c 24 48          	mov    %ecx,0x48(%rsp)
    8ceb:	48 8d 05 c6 76 00 00 	lea    0x76c6(%rip),%rax        # 103b8 <exec_in_fp0+0xcb8>
    8cf2:	48 8d 35 c3 76 00 00 	lea    0x76c3(%rip),%rsi        # 103bc <exec_in_fp0+0xcbc>
    8cf9:	48 0f 44 f0          	cmove  %rax,%rsi
    8cfd:	4c 89 ff             	mov    %r15,%rdi
    8d00:	e8 fb 0b 00 00       	call   9900 <tp_eat>
    8d05:	45 31 e4             	xor    %r12d,%r12d
    8d08:	85 c0                	test   %eax,%eax
    8d0a:	0f 84 34 07 00 00    	je     9444 <tp_value+0x834>
    8d10:	48 8d 35 76 77 00 00 	lea    0x7776(%rip),%rsi        # 1048d <exec_in_fp0+0xd8d>
    8d17:	48 8d 15 c7 6a 00 00 	lea    0x6ac7(%rip),%rdx        # f7e5 <exec_in_fp0+0xe5>
    8d1e:	48 8d 0d 7b 0e 00 00 	lea    0xe7b(%rip),%rcx        # 9ba0 <tp_kv_item>
    8d25:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
    8d2a:	4c 89 ff             	mov    %r15,%rdi
    8d2d:	e8 2e 0c 00 00       	call   9960 <tp_list_of>
    8d32:	85 c0                	test   %eax,%eax
    8d34:	0f 84 a1 03 00 00    	je     90db <tp_value+0x4cb>
    8d3a:	48 83 7c 24 38 00    	cmpq   $0x0,0x38(%rsp)
    8d40:	0f 84 2b 05 00 00    	je     9271 <tp_value+0x661>
    8d46:	48 8d 05 e3 e6 01 00 	lea    0x1e6e3(%rip),%rax        # 27430 <fwp_empty_map>
    8d4d:	31 db                	xor    %ebx,%ebx
    8d4f:	90                   	nop
    8d50:	48 8b 4c 24 30       	mov    0x30(%rsp),%rcx
    8d55:	48 8b 3c d9          	mov    (%rcx,%rbx,8),%rdi
    8d59:	48 8b 74 d9 08       	mov    0x8(%rcx,%rbx,8),%rsi
    8d5e:	49 8b 4e 38          	mov    0x38(%r14),%rcx
    8d62:	48 89 c2             	mov    %rax,%rdx
    8d65:	e8 d6 0e 00 00       	call   9c40 <fwp_p_map_insert>
    8d6a:	48 83 c3 02          	add    $0x2,%rbx
    8d6e:	48 3b 5c 24 38       	cmp    0x38(%rsp),%rbx
    8d73:	72 db                	jb     8d50 <tp_value+0x140>
    8d75:	e9 fe 04 00 00       	jmp    9278 <tp_value+0x668>
    8d7a:	0f 57 c0             	xorps  %xmm0,%xmm0
    8d7d:	0f 11 44 24 38       	movups %xmm0,0x38(%rsp)
    8d82:	0f 11 44 24 28       	movups %xmm0,0x28(%rsp)
    8d87:	48 c7 44 24 48 00 00 	movq   $0x0,0x48(%rsp)
    8d8e:	00 00 
    8d90:	49 8b 4e 38          	mov    0x38(%r14),%rcx
    8d94:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
    8d99:	83 f8 11             	cmp    $0x11,%eax
    8d9c:	75 17                	jne    8db5 <tp_value+0x1a5>
    8d9e:	48 8d 35 0d 76 00 00 	lea    0x760d(%rip),%rsi        # 103b2 <exec_in_fp0+0xcb2>
    8da5:	4c 89 ff             	mov    %r15,%rdi
    8da8:	e8 53 0b 00 00       	call   9900 <tp_eat>
    8dad:	85 c0                	test   %eax,%eax
    8daf:	0f 84 8c 06 00 00    	je     9441 <tp_value+0x831>
    8db5:	48 8d 35 c6 69 00 00 	lea    0x69c6(%rip),%rsi        # f782 <exec_in_fp0+0x82>
    8dbc:	48 8d 15 77 6a 00 00 	lea    0x6a77(%rip),%rdx        # f83a <exec_in_fp0+0x13a>
    8dc3:	48 8d 0d e6 0c 00 00 	lea    0xce6(%rip),%rcx        # 9ab0 <tp_elem_item>
    8dca:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
    8dcf:	4c 89 ff             	mov    %r15,%rdi
    8dd2:	e8 89 0b 00 00       	call   9960 <tp_list_of>
    8dd7:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    8ddc:	85 c0                	test   %eax,%eax
    8dde:	0f 84 06 03 00 00    	je     90ea <tp_value+0x4da>
    8de4:	48 8b 74 24 38       	mov    0x38(%rsp),%rsi
    8de9:	e8 62 f3 ff ff       	call   8150 <fwp_list_from>
    8dee:	49 89 c7             	mov    %rax,%r15
    8df1:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    8df6:	e8 95 f3 ff ff       	call   8190 <fwp_mem_free>
    8dfb:	41 83 3e 11          	cmpl   $0x11,(%r14)
    8dff:	75 0b                	jne    8e0c <tp_value+0x1fc>
    8e01:	4c 89 ff             	mov    %r15,%rdi
    8e04:	e8 e7 0c 00 00       	call   9af0 <fwp_p_array_from_list>
    8e09:	49 89 c7             	mov    %rax,%r15
    8e0c:	4c 89 7d 00          	mov    %r15,0x0(%rbp)
    8e10:	e9 5a fe ff ff       	jmp    8c6f <tp_value+0x5f>
    8e15:	4c 89 ff             	mov    %r15,%rdi
    8e18:	4c 89 f6             	mov    %r14,%rsi
    8e1b:	48 89 ea             	mov    %rbp,%rdx
    8e1e:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    8e25:	5b                   	pop    %rbx
    8e26:	41 5c                	pop    %r12
    8e28:	41 5d                	pop    %r13
    8e2a:	41 5e                	pop    %r14
    8e2c:	41 5f                	pop    %r15
    8e2e:	5d                   	pop    %rbp
    8e2f:	e9 bc 07 00 00       	jmp    95f0 <tp_float>
    8e34:	45 85 ed             	test   %r13d,%r13d
    8e37:	0f 85 f7 fd ff ff    	jne    8c34 <tp_value+0x24>
    8e3d:	4c 89 ff             	mov    %r15,%rdi
    8e40:	48 89 ee             	mov    %rbp,%rsi
    8e43:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    8e4a:	5b                   	pop    %rbx
    8e4b:	41 5c                	pop    %r12
    8e4d:	41 5d                	pop    %r13
    8e4f:	41 5e                	pop    %r14
    8e51:	41 5f                	pop    %r15
    8e53:	5d                   	pop    %rbp
    8e54:	e9 57 08 00 00       	jmp    96b0 <tp_quoted>
    8e59:	0f 57 c0             	xorps  %xmm0,%xmm0
    8e5c:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    8e61:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    8e66:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    8e6b:	48 8d 35 34 75 00 00 	lea    0x7534(%rip),%rsi        # 103a6 <exec_in_fp0+0xca6>
    8e72:	4c 89 ff             	mov    %r15,%rdi
    8e75:	e8 86 0a 00 00       	call   9900 <tp_eat>
    8e7a:	45 31 e4             	xor    %r12d,%r12d
    8e7d:	85 c0                	test   %eax,%eax
    8e7f:	0f 84 6f 02 00 00    	je     90f4 <tp_value+0x4e4>
    8e85:	48 8d 35 f6 68 00 00 	lea    0x68f6(%rip),%rsi        # f782 <exec_in_fp0+0x82>
    8e8c:	48 8d 15 a7 69 00 00 	lea    0x69a7(%rip),%rdx        # f83a <exec_in_fp0+0x13a>
    8e93:	48 8d 0d 46 0b 00 00 	lea    0xb46(%rip),%rcx        # 99e0 <tp_byte_item>
    8e9a:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
    8e9f:	4c 89 ff             	mov    %r15,%rdi
    8ea2:	e8 b9 0a 00 00       	call   9960 <tp_list_of>
    8ea7:	85 c0                	test   %eax,%eax
    8ea9:	0f 84 2c 02 00 00    	je     90db <tp_value+0x4cb>
    8eaf:	0f 57 c0             	xorps  %xmm0,%xmm0
    8eb2:	0f 29 84 24 20 01 00 	movaps %xmm0,0x120(%rsp)
    8eb9:	00 
    8eba:	48 c7 84 24 30 01 00 	movq   $0x0,0x130(%rsp)
    8ec1:	00 00 00 00 00 
    8ec6:	48 83 7c 24 38 00    	cmpq   $0x0,0x38(%rsp)
    8ecc:	74 2d                	je     8efb <tp_value+0x2eb>
    8ece:	31 db                	xor    %ebx,%ebx
    8ed0:	4c 8d b4 24 20 01 00 	lea    0x120(%rsp),%r14
    8ed7:	00 
    8ed8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    8edf:	00 
    8ee0:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    8ee5:	0f be 34 d8          	movsbl (%rax,%rbx,8),%esi
    8ee9:	4c 89 f7             	mov    %r14,%rdi
    8eec:	e8 9f f6 ff ff       	call   8590 <buf_putc>
    8ef1:	48 ff c3             	inc    %rbx
    8ef4:	48 3b 5c 24 38       	cmp    0x38(%rsp),%rbx
    8ef9:	72 e5                	jb     8ee0 <tp_value+0x2d0>
    8efb:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    8f00:	e8 8b f2 ff ff       	call   8190 <fwp_mem_free>
    8f05:	48 8d bc 24 20 01 00 	lea    0x120(%rsp),%rdi
    8f0c:	00 
    8f0d:	e8 0e f7 ff ff       	call   8620 <buf_to_str>
    8f12:	48 89 45 00          	mov    %rax,0x0(%rbp)
    8f16:	e9 54 fd ff ff       	jmp    8c6f <tp_value+0x5f>
    8f1b:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8f20:	ba 00 01 00 00       	mov    $0x100,%edx
    8f25:	4c 89 ff             	mov    %r15,%rdi
    8f28:	e8 f3 0a 00 00       	call   9a20 <tp_token>
    8f2d:	45 31 e4             	xor    %r12d,%r12d
    8f30:	48 83 f8 02          	cmp    $0x2,%rax
    8f34:	0f 82 0a 05 00 00    	jb     9444 <tp_value+0x834>
    8f3a:	80 7c 24 20 30       	cmpb   $0x30,0x20(%rsp)
    8f3f:	0f 85 ff 04 00 00    	jne    9444 <tp_value+0x834>
    8f45:	80 7c 24 21 74       	cmpb   $0x74,0x21(%rsp)
    8f4a:	0f 85 f4 04 00 00    	jne    9444 <tp_value+0x834>
    8f50:	48 8d 48 fe          	lea    -0x2(%rax),%rcx
    8f54:	49 63 56 48          	movslq 0x48(%r14),%rdx
    8f58:	48 39 d1             	cmp    %rdx,%rcx
    8f5b:	0f 87 e3 04 00 00    	ja     9444 <tp_value+0x834>
    8f61:	48 83 f8 03          	cmp    $0x3,%rax
    8f65:	0f 82 21 05 00 00    	jb     948c <tp_value+0x87c>
    8f6b:	ba 02 00 00 00       	mov    $0x2,%edx
    8f70:	31 c9                	xor    %ecx,%ecx
    8f72:	e9 3d 01 00 00       	jmp    90b4 <tp_value+0x4a4>
    8f77:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8f7c:	ba 10 00 00 00       	mov    $0x10,%edx
    8f81:	4c 89 ff             	mov    %r15,%rdi
    8f84:	e8 97 0a 00 00       	call   9a20 <tp_token>
    8f89:	8b 44 24 20          	mov    0x20(%rsp),%eax
    8f8d:	89 c1                	mov    %eax,%ecx
    8f8f:	81 f1 2b 31 00 00    	xor    $0x312b,%ecx
    8f95:	0f b6 54 24 22       	movzbl 0x22(%rsp),%edx
    8f9a:	66 09 ca             	or     %cx,%dx
    8f9d:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    8fa3:	74 2d                	je     8fd2 <tp_value+0x3c2>
    8fa5:	66 83 f8 31          	cmp    $0x31,%ax
    8fa9:	74 27                	je     8fd2 <tp_value+0x3c2>
    8fab:	45 31 e4             	xor    %r12d,%r12d
    8fae:	66 83 f8 30          	cmp    $0x30,%ax
    8fb2:	74 1e                	je     8fd2 <tp_value+0x3c2>
    8fb4:	b8 2d 31 00 00       	mov    $0x312d,%eax
    8fb9:	33 44 24 20          	xor    0x20(%rsp),%eax
    8fbd:	0f b6 4c 24 22       	movzbl 0x22(%rsp),%ecx
    8fc2:	66 09 c1             	or     %ax,%cx
    8fc5:	0f 85 79 04 00 00    	jne    9444 <tp_value+0x834>
    8fcb:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    8fd2:	4c 89 65 00          	mov    %r12,0x0(%rbp)
    8fd6:	e9 94 fc ff ff       	jmp    8c6f <tp_value+0x5f>
    8fdb:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    8fdf:	48 85 ff             	test   %rdi,%rdi
    8fe2:	0f 84 18 01 00 00    	je     9100 <tp_value+0x4f0>
    8fe8:	48 8d 35 d1 73 00 00 	lea    0x73d1(%rip),%rsi        # 103c0 <exec_in_fp0+0xcc0>
    8fef:	e8 dc a2 ff ff       	call   32d0 <strcmp@plt>
    8ff4:	85 c0                	test   %eax,%eax
    8ff6:	0f 84 23 03 00 00    	je     931f <tp_value+0x70f>
    8ffc:	4c 89 ff             	mov    %r15,%rdi
    8fff:	e8 3c 05 00 00       	call   9540 <tp_ws>
    9004:	4d 8b 6e 08          	mov    0x8(%r14),%r13
    9008:	4c 89 ef             	mov    %r13,%rdi
    900b:	e8 60 a1 ff ff       	call   3170 <strlen@plt>
    9010:	49 89 c4             	mov    %rax,%r12
    9013:	49 8b 47 08          	mov    0x8(%r15),%rax
    9017:	49 8b 5f 10          	mov    0x10(%r15),%rbx
    901b:	48 29 d8             	sub    %rbx,%rax
    901e:	4c 39 e0             	cmp    %r12,%rax
    9021:	0f 82 c4 01 00 00    	jb     91eb <tp_value+0x5db>
    9027:	49 8b 3f             	mov    (%r15),%rdi
    902a:	48 01 df             	add    %rbx,%rdi
    902d:	4c 89 ee             	mov    %r13,%rsi
    9030:	4c 89 e2             	mov    %r12,%rdx
    9033:	e8 38 a3 ff ff       	call   3370 <bcmp@plt>
    9038:	85 c0                	test   %eax,%eax
    903a:	0f 85 ab 01 00 00    	jne    91eb <tp_value+0x5db>
    9040:	4c 01 e3             	add    %r12,%rbx
    9043:	49 89 5f 10          	mov    %rbx,0x10(%r15)
    9047:	e9 9f 01 00 00       	jmp    91eb <tp_value+0x5db>
    904c:	48 89 2c 24          	mov    %rbp,(%rsp)
    9050:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    9055:	4c 89 ff             	mov    %r15,%rdi
    9058:	e8 d3 0e 00 00       	call   9f30 <tp_ident>
    905d:	41 8b 5e 10          	mov    0x10(%r14),%ebx
    9061:	85 db                	test   %ebx,%ebx
    9063:	4c 89 74 24 08       	mov    %r14,0x8(%rsp)
    9068:	0f 8e 9c 01 00 00    	jle    920a <tp_value+0x5fa>
    906e:	4d 8b 66 18          	mov    0x18(%r14),%r12
    9072:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    9077:	45 31 f6             	xor    %r14d,%r14d
    907a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9080:	4b 8b 3c f4          	mov    (%r12,%r14,8),%rdi
    9084:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    9089:	e8 42 a2 ff ff       	call   32d0 <strcmp@plt>
    908e:	85 c0                	test   %eax,%eax
    9090:	41 0f 44 ee          	cmove  %r14d,%ebp
    9094:	49 ff c6             	inc    %r14
    9097:	4c 39 f3             	cmp    %r14,%rbx
    909a:	75 e4                	jne    9080 <tp_value+0x470>
    909c:	e9 6e 01 00 00       	jmp    920f <tp_value+0x5ff>
    90a1:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    90a5:	48 ff c9             	dec    %rcx
    90a8:	48 ff c2             	inc    %rdx
    90ab:	48 39 d0             	cmp    %rdx,%rax
    90ae:	0f 84 da 03 00 00    	je     948e <tp_value+0x87e>
    90b4:	0f b6 74 14 20       	movzbl 0x20(%rsp,%rdx,1),%esi
    90b9:	83 fe 30             	cmp    $0x30,%esi
    90bc:	74 17                	je     90d5 <tp_value+0x4c5>
    90be:	83 fe 2d             	cmp    $0x2d,%esi
    90c1:	74 de                	je     90a1 <tp_value+0x491>
    90c3:	83 fe 2b             	cmp    $0x2b,%esi
    90c6:	0f 85 75 03 00 00    	jne    9441 <tp_value+0x831>
    90cc:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    90d0:	48 ff c1             	inc    %rcx
    90d3:	eb d3                	jmp    90a8 <tp_value+0x498>
    90d5:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    90d9:	eb cd                	jmp    90a8 <tp_value+0x498>
    90db:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    90e0:	e8 ab f0 ff ff       	call   8190 <fwp_mem_free>
    90e5:	e9 5a 03 00 00       	jmp    9444 <tp_value+0x834>
    90ea:	e8 a1 f0 ff ff       	call   8190 <fwp_mem_free>
    90ef:	e9 4d 03 00 00       	jmp    9441 <tp_value+0x831>
    90f4:	31 ff                	xor    %edi,%edi
    90f6:	e8 95 f0 ff ff       	call   8190 <fwp_mem_free>
    90fb:	e9 44 03 00 00       	jmp    9444 <tp_value+0x834>
    9100:	49 63 7e 10          	movslq 0x10(%r14),%rdi
    9104:	48 85 ff             	test   %rdi,%rdi
    9107:	0f 84 4c 03 00 00    	je     9459 <tp_value+0x849>
    910d:	41 83 7e 48 00       	cmpl   $0x0,0x48(%r14)
    9112:	0f 84 d3 00 00 00    	je     91eb <tp_value+0x5db>
    9118:	48 c1 e7 03          	shl    $0x3,%rdi
    911c:	e8 2f d4 ff ff       	call   6550 <fwp_alloc>
    9121:	48 89 c3             	mov    %rax,%rbx
    9124:	48 8d 35 a5 72 00 00 	lea    0x72a5(%rip),%rsi        # 103d0 <exec_in_fp0+0xcd0>
    912b:	4c 89 ff             	mov    %r15,%rdi
    912e:	e8 cd 07 00 00       	call   9900 <tp_eat>
    9133:	85 c0                	test   %eax,%eax
    9135:	0f 84 09 03 00 00    	je     9444 <tp_value+0x834>
    913b:	48 89 2c 24          	mov    %rbp,(%rsp)
    913f:	41 83 7e 10 00       	cmpl   $0x0,0x10(%r14)
    9144:	7e 77                	jle    91bd <tp_value+0x5ad>
    9146:	49 8b 46 20          	mov    0x20(%r14),%rax
    914a:	48 8b 30             	mov    (%rax),%rsi
    914d:	4c 89 ff             	mov    %r15,%rdi
    9150:	31 d2                	xor    %edx,%edx
    9152:	48 89 d9             	mov    %rbx,%rcx
    9155:	e8 b6 fa ff ff       	call   8c10 <tp_value>
    915a:	85 c0                	test   %eax,%eax
    915c:	0f 84 df 02 00 00    	je     9441 <tp_value+0x831>
    9162:	41 83 7e 10 02       	cmpl   $0x2,0x10(%r14)
    9167:	7c 54                	jl     91bd <tp_value+0x5ad>
    9169:	48 89 dd             	mov    %rbx,%rbp
    916c:	48 83 c5 08          	add    $0x8,%rbp
    9170:	41 bd 01 00 00 00    	mov    $0x1,%r13d
    9176:	4c 89 ff             	mov    %r15,%rdi
    9179:	48 8d 35 62 66 00 00 	lea    0x6662(%rip),%rsi        # f7e2 <exec_in_fp0+0xe2>
    9180:	e8 7b 07 00 00       	call   9900 <tp_eat>
    9185:	85 c0                	test   %eax,%eax
    9187:	0f 84 b4 02 00 00    	je     9441 <tp_value+0x831>
    918d:	49 8b 46 20          	mov    0x20(%r14),%rax
    9191:	4a 8b 34 e8          	mov    (%rax,%r13,8),%rsi
    9195:	45 31 e4             	xor    %r12d,%r12d
    9198:	4c 89 ff             	mov    %r15,%rdi
    919b:	31 d2                	xor    %edx,%edx
    919d:	48 89 e9             	mov    %rbp,%rcx
    91a0:	e8 6b fa ff ff       	call   8c10 <tp_value>
    91a5:	85 c0                	test   %eax,%eax
    91a7:	0f 84 97 02 00 00    	je     9444 <tp_value+0x834>
    91ad:	49 ff c5             	inc    %r13
    91b0:	49 63 46 10          	movslq 0x10(%r14),%rax
    91b4:	48 83 c5 08          	add    $0x8,%rbp
    91b8:	49 39 c5             	cmp    %rax,%r13
    91bb:	7c b9                	jl     9176 <tp_value+0x566>
    91bd:	48 8d 35 cc 72 00 00 	lea    0x72cc(%rip),%rsi        # 10490 <exec_in_fp0+0xd90>
    91c4:	4c 89 ff             	mov    %r15,%rdi
    91c7:	e8 34 07 00 00       	call   9900 <tp_eat>
    91cc:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    91d2:	85 c0                	test   %eax,%eax
    91d4:	0f 84 6a 02 00 00    	je     9444 <tp_value+0x834>
    91da:	41 8b 7e 10          	mov    0x10(%r14),%edi
    91de:	48 89 de             	mov    %rbx,%rsi
    91e1:	e8 7a b1 ff ff       	call   4360 <fwp_record>
    91e6:	e9 28 01 00 00       	jmp    9313 <tp_value+0x703>
    91eb:	4c 89 ff             	mov    %r15,%rdi
    91ee:	4c 89 f6             	mov    %r14,%rsi
    91f1:	48 89 ea             	mov    %rbp,%rdx
    91f4:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    91fb:	5b                   	pop    %rbx
    91fc:	41 5c                	pop    %r12
    91fe:	41 5d                	pop    %r13
    9200:	41 5e                	pop    %r14
    9202:	41 5f                	pop    %r15
    9204:	5d                   	pop    %rbp
    9205:	e9 56 0b 00 00       	jmp    9d60 <tp_record_body>
    920a:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    920f:	45 85 ed             	test   %r13d,%r13d
    9212:	74 7a                	je     928e <tp_value+0x67e>
    9214:	85 ed                	test   %ebp,%ebp
    9216:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    921b:	79 76                	jns    9293 <tp_value+0x683>
    921d:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    9221:	45 31 e4             	xor    %r12d,%r12d
    9224:	48 85 ff             	test   %rdi,%rdi
    9227:	0f 84 17 02 00 00    	je     9444 <tp_value+0x834>
    922d:	48 8d 35 6a 71 00 00 	lea    0x716a(%rip),%rsi        # 1039e <exec_in_fp0+0xc9e>
    9234:	e8 97 a0 ff ff       	call   32d0 <strcmp@plt>
    9239:	85 c0                	test   %eax,%eax
    923b:	0f 85 03 02 00 00    	jne    9444 <tp_value+0x834>
    9241:	8b 44 24 20          	mov    0x20(%rsp),%eax
    9245:	89 c1                	mov    %eax,%ecx
    9247:	81 f1 74 72 75 65    	xor    $0x65757274,%ecx
    924d:	0f b6 54 24 24       	movzbl 0x24(%rsp),%edx
    9252:	09 ca                	or     %ecx,%edx
    9254:	b9 01 00 00 00       	mov    $0x1,%ecx
    9259:	0f 44 e9             	cmove  %ecx,%ebp
    925c:	35 66 61 6c 73       	xor    $0x736c6166,%eax
    9261:	0f b7 4c 24 24       	movzwl 0x24(%rsp),%ecx
    9266:	83 f1 65             	xor    $0x65,%ecx
    9269:	09 c1                	or     %eax,%ecx
    926b:	75 26                	jne    9293 <tp_value+0x683>
    926d:	31 ed                	xor    %ebp,%ebp
    926f:	eb 2a                	jmp    929b <tp_value+0x68b>
    9271:	48 8d 05 b8 e1 01 00 	lea    0x1e1b8(%rip),%rax        # 27430 <fwp_empty_map>
    9278:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    927d:	48 89 c3             	mov    %rax,%rbx
    9280:	e8 0b ef ff ff       	call   8190 <fwp_mem_free>
    9285:	48 89 5d 00          	mov    %rbx,0x0(%rbp)
    9289:	e9 e1 f9 ff ff       	jmp    8c6f <tp_value+0x5f>
    928e:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    9293:	85 ed                	test   %ebp,%ebp
    9295:	0f 88 a6 01 00 00    	js     9441 <tp_value+0x831>
    929b:	48 8b 43 28          	mov    0x28(%rbx),%rax
    929f:	41 89 ed             	mov    %ebp,%r13d
    92a2:	4a 63 1c a8          	movslq (%rax,%r13,4),%rbx
    92a6:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    92ad:	00 
    92ae:	e8 9d d2 ff ff       	call   6550 <fwp_alloc>
    92b3:	48 89 c5             	mov    %rax,%rbp
    92b6:	89 d8                	mov    %ebx,%eax
    92b8:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    92bd:	48 85 db             	test   %rbx,%rbx
    92c0:	7e 41                	jle    9303 <tp_value+0x6f3>
    92c2:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    92c7:	48 8d 1c c5 00 00 00 	lea    0x0(,%rax,8),%rbx
    92ce:	00 
    92cf:	45 31 e4             	xor    %r12d,%r12d
    92d2:	45 31 f6             	xor    %r14d,%r14d
    92d5:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    92da:	48 8b 40 30          	mov    0x30(%rax),%rax
    92de:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    92e2:	4a 8b 34 30          	mov    (%rax,%r14,1),%rsi
    92e6:	49 8d 14 2e          	lea    (%r14,%rbp,1),%rdx
    92ea:	4c 89 ff             	mov    %r15,%rdi
    92ed:	e8 fe 0c 00 00       	call   9ff0 <tp_atom>
    92f2:	85 c0                	test   %eax,%eax
    92f4:	0f 84 4a 01 00 00    	je     9444 <tp_value+0x834>
    92fa:	49 83 c6 08          	add    $0x8,%r14
    92fe:	4c 39 f3             	cmp    %r14,%rbx
    9301:	75 d2                	jne    92d5 <tp_value+0x6c5>
    9303:	44 89 ef             	mov    %r13d,%edi
    9306:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    930b:	48 89 ea             	mov    %rbp,%rdx
    930e:	e8 6d b0 ff ff       	call   4380 <fwp_data>
    9313:	48 8b 0c 24          	mov    (%rsp),%rcx
    9317:	48 89 01             	mov    %rax,(%rcx)
    931a:	e9 50 f9 ff ff       	jmp    8c6f <tp_value+0x5f>
    931f:	48 89 2c 24          	mov    %rbp,(%rsp)
    9323:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    9328:	ba 80 00 00 00       	mov    $0x80,%edx
    932d:	4c 89 ff             	mov    %r15,%rdi
    9330:	48 89 f3             	mov    %rsi,%rbx
    9333:	e8 e8 06 00 00       	call   9a20 <tp_token>
    9338:	49 89 c7             	mov    %rax,%r15
    933b:	4c 8d 24 04          	lea    (%rsp,%rax,1),%r12
    933f:	49 83 c4 20          	add    $0x20,%r12
    9343:	41 be 08 00 00 00    	mov    $0x8,%r14d
    9349:	eb 0e                	jmp    9359 <tp_value+0x749>
    934b:	49 83 c6 10          	add    $0x10,%r14
    934f:	49 83 fe 68          	cmp    $0x68,%r14
    9353:	0f 84 e8 00 00 00    	je     9441 <tp_value+0x831>
    9359:	48 8d 05 c0 b8 00 00 	lea    0xb8c0(%rip),%rax        # 14c20 <tp_value.units>
    9360:	49 8b 6c 06 f8       	mov    -0x8(%r14,%rax,1),%rbp
    9365:	48 89 ef             	mov    %rbp,%rdi
    9368:	e8 03 9e ff ff       	call   3170 <strlen@plt>
    936d:	4d 89 fd             	mov    %r15,%r13
    9370:	49 29 c5             	sub    %rax,%r13
    9373:	76 d6                	jbe    934b <tp_value+0x73b>
    9375:	4c 89 e7             	mov    %r12,%rdi
    9378:	48 29 c7             	sub    %rax,%rdi
    937b:	48 89 ee             	mov    %rbp,%rsi
    937e:	e8 4d 9f ff ff       	call   32d0 <strcmp@plt>
    9383:	85 c0                	test   %eax,%eax
    9385:	75 c4                	jne    934b <tp_value+0x73b>
    9387:	48 8d ac 24 20 01 00 	lea    0x120(%rsp),%rbp
    938e:	00 
    938f:	48 89 ef             	mov    %rbp,%rdi
    9392:	48 89 de             	mov    %rbx,%rsi
    9395:	4c 89 ea             	mov    %r13,%rdx
    9398:	e8 93 9f ff ff       	call   3330 <memcpy@plt>
    939d:	42 c6 84 2c 20 01 00 	movb   $0x0,0x120(%rsp,%r13,1)
    93a4:	00 00 
    93a6:	48 89 ef             	mov    %rbp,%rdi
    93a9:	4c 89 ee             	mov    %r13,%rsi
    93ac:	e8 6f 09 00 00       	call   9d20 <fwp_valid_int>
    93b1:	85 c0                	test   %eax,%eax
    93b3:	74 96                	je     934b <tp_value+0x73b>
    93b5:	0f b6 b4 24 20 01 00 	movzbl 0x120(%rsp),%esi
    93bc:	00 
    93bd:	8d 4e d5             	lea    -0x2b(%rsi),%ecx
    93c0:	31 c0                	xor    %eax,%eax
    93c2:	f6 c1 fd             	test   $0xfd,%cl
    93c5:	0f 94 c0             	sete   %al
    93c8:	44 0f b6 94 04 20 01 	movzbl 0x120(%rsp,%rax,1),%r10d
    93cf:	00 00 
    93d1:	45 31 e4             	xor    %r12d,%r12d
    93d4:	45 84 d2             	test   %r10b,%r10b
    93d7:	0f 84 ba 00 00 00    	je     9497 <tp_value+0x887>
    93dd:	48 8d 8c 24 20 01 00 	lea    0x120(%rsp),%rcx
    93e4:	00 
    93e5:	48 01 c1             	add    %rax,%rcx
    93e8:	48 ff c1             	inc    %rcx
    93eb:	31 c0                	xor    %eax,%eax
    93ed:	bf 0a 00 00 00       	mov    $0xa,%edi
    93f2:	49 b9 00 00 00 00 00 	movabs $0x8000000000000000,%r9
    93f9:	00 00 80 
    93fc:	45 31 c0             	xor    %r8d,%r8d
    93ff:	48 8b 1c 24          	mov    (%rsp),%rbx
    9403:	48 f7 e7             	mul    %rdi
    9406:	4f 8d 04 80          	lea    (%r8,%r8,4),%r8
    940a:	4a 8d 14 42          	lea    (%rdx,%r8,2),%rdx
    940e:	45 0f be c2          	movsbl %r10b,%r8d
    9412:	41 83 c0 d0          	add    $0xffffffd0,%r8d
    9416:	4d 63 d0             	movslq %r8d,%r10
    9419:	4d 89 d0             	mov    %r10,%r8
    941c:	49 c1 f8 3f          	sar    $0x3f,%r8
    9420:	4c 01 d0             	add    %r10,%rax
    9423:	49 11 d0             	adc    %rdx,%r8
    9426:	49 39 c1             	cmp    %rax,%r9
    9429:	ba 00 00 00 00       	mov    $0x0,%edx
    942e:	4c 19 c2             	sbb    %r8,%rdx
    9431:	7c 0e                	jl     9441 <tp_value+0x831>
    9433:	44 0f b6 11          	movzbl (%rcx),%r10d
    9437:	48 ff c1             	inc    %rcx
    943a:	45 84 d2             	test   %r10b,%r10b
    943d:	75 c4                	jne    9403 <tp_value+0x7f3>
    943f:	eb 5f                	jmp    94a0 <tp_value+0x890>
    9441:	45 31 e4             	xor    %r12d,%r12d
    9444:	44 89 e0             	mov    %r12d,%eax
    9447:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    944e:	5b                   	pop    %rbx
    944f:	41 5c                	pop    %r12
    9451:	41 5d                	pop    %r13
    9453:	41 5e                	pop    %r14
    9455:	41 5f                	pop    %r15
    9457:	5d                   	pop    %rbp
    9458:	c3                   	ret
    9459:	48 8d 35 70 6f 00 00 	lea    0x6f70(%rip),%rsi        # 103d0 <exec_in_fp0+0xcd0>
    9460:	4c 89 ff             	mov    %r15,%rdi
    9463:	e8 98 04 00 00       	call   9900 <tp_eat>
    9468:	85 c0                	test   %eax,%eax
    946a:	74 d8                	je     9444 <tp_value+0x834>
    946c:	48 8d 35 1d 70 00 00 	lea    0x701d(%rip),%rsi        # 10490 <exec_in_fp0+0xd90>
    9473:	4c 89 ff             	mov    %r15,%rdi
    9476:	e8 85 04 00 00       	call   9900 <tp_eat>
    947b:	85 c0                	test   %eax,%eax
    947d:	74 c5                	je     9444 <tp_value+0x834>
    947f:	48 c7 45 00 00 00 00 	movq   $0x0,0x0(%rbp)
    9486:	00 
    9487:	e9 e3 f7 ff ff       	jmp    8c6f <tp_value+0x5f>
    948c:	31 c9                	xor    %ecx,%ecx
    948e:	48 89 4d 00          	mov    %rcx,0x0(%rbp)
    9492:	e9 d8 f7 ff ff       	jmp    8c6f <tp_value+0x5f>
    9497:	31 c0                	xor    %eax,%eax
    9499:	45 31 c0             	xor    %r8d,%r8d
    949c:	48 8b 1c 24          	mov    (%rsp),%rbx
    94a0:	48 89 c1             	mov    %rax,%rcx
    94a3:	48 f7 d9             	neg    %rcx
    94a6:	bf 00 00 00 00       	mov    $0x0,%edi
    94ab:	4c 19 c7             	sbb    %r8,%rdi
    94ae:	40 80 fe 2d          	cmp    $0x2d,%sil
    94b2:	49 0f 45 f8          	cmovne %r8,%rdi
    94b6:	48 0f 45 c8          	cmovne %rax,%rcx
    94ba:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    94c1:	ff ff 7f 
    94c4:	48 39 c8             	cmp    %rcx,%rax
    94c7:	b8 00 00 00 00       	mov    $0x0,%eax
    94cc:	48 19 f8             	sbb    %rdi,%rax
    94cf:	0f 8c 6f ff ff ff    	jl     9444 <tp_value+0x834>
    94d5:	48 8d 05 44 b7 00 00 	lea    0xb744(%rip),%rax        # 14c20 <tp_value.units>
    94dc:	49 8b 34 06          	mov    (%r14,%rax,1),%rsi
    94e0:	48 89 c8             	mov    %rcx,%rax
    94e3:	48 f7 e6             	mul    %rsi
    94e6:	48 0f af fe          	imul   %rsi,%rdi
    94ea:	48 c1 fe 3f          	sar    $0x3f,%rsi
    94ee:	48 0f af f1          	imul   %rcx,%rsi
    94f2:	48 01 d6             	add    %rdx,%rsi
    94f5:	48 01 f7             	add    %rsi,%rdi
    94f8:	48 b9 00 00 00 00 00 	movabs $0x8000000000000000,%rcx
    94ff:	00 00 80 
    9502:	48 01 c1             	add    %rax,%rcx
    9505:	48 83 d7 ff          	adc    $0xffffffffffffffff,%rdi
    9509:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
    950d:	0f 85 31 ff ff ff    	jne    9444 <tp_value+0x834>
    9513:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    9518:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    951e:	48 8d 74 24 18       	lea    0x18(%rsp),%rsi
    9523:	bf 01 00 00 00       	mov    $0x1,%edi
    9528:	e8 33 ae ff ff       	call   4360 <fwp_record>
    952d:	48 89 03             	mov    %rax,(%rbx)
    9530:	e9 0f ff ff ff       	jmp    9444 <tp_value+0x834>
    9535:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    953c:	00 00 00 00 

0000000000009540 <tp_ws>:
    9540:	48 8b 47 08          	mov    0x8(%rdi),%rax
    9544:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    9548:	48 39 c1             	cmp    %rax,%rcx
    954b:	73 39                	jae    9586 <tp_ws+0x46>
    954d:	48 8b 17             	mov    (%rdi),%rdx
    9550:	48 f7 d8             	neg    %rax
    9553:	48 ff c1             	inc    %rcx
    9556:	48 be 00 26 00 00 01 	movabs $0x100002600,%rsi
    955d:	00 00 00 
    9560:	44 0f b6 44 0a ff    	movzbl -0x1(%rdx,%rcx,1),%r8d
    9566:	49 83 f8 20          	cmp    $0x20,%r8
    956a:	77 1a                	ja     9586 <tp_ws+0x46>
    956c:	4c 0f a3 c6          	bt     %r8,%rsi
    9570:	73 14                	jae    9586 <tp_ws+0x46>
    9572:	48 89 4f 10          	mov    %rcx,0x10(%rdi)
    9576:	4c 8d 04 08          	lea    (%rax,%rcx,1),%r8
    957a:	49 ff c0             	inc    %r8
    957d:	48 ff c1             	inc    %rcx
    9580:	49 83 f8 01          	cmp    $0x1,%r8
    9584:	75 da                	jne    9560 <tp_ws+0x20>
    9586:	c3                   	ret
    9587:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    958e:	00 00 

0000000000009590 <tp_int>:
    9590:	55                   	push   %rbp
    9591:	41 56                	push   %r14
    9593:	53                   	push   %rbx
    9594:	48 81 ec 80 00 00 00 	sub    $0x80,%rsp
    959b:	48 89 d3             	mov    %rdx,%rbx
    959e:	49 89 f6             	mov    %rsi,%r14
    95a1:	48 89 e6             	mov    %rsp,%rsi
    95a4:	ba 80 00 00 00       	mov    $0x80,%edx
    95a9:	e8 72 04 00 00       	call   9a20 <tp_token>
    95ae:	31 ed                	xor    %ebp,%ebp
    95b0:	48 83 f8 7f          	cmp    $0x7f,%rax
    95b4:	77 28                	ja     95de <tp_int+0x4e>
    95b6:	48 89 e7             	mov    %rsp,%rdi
    95b9:	e8 d2 0a 00 00       	call   a090 <fwp_cstr>
    95be:	41 8b 36             	mov    (%r14),%esi
    95c1:	41 8b 56 48          	mov    0x48(%r14),%edx
    95c5:	48 89 c7             	mov    %rax,%rdi
    95c8:	e8 e3 0a 00 00       	call   a0b0 <fwp_p_parse_int>
    95cd:	48 85 c0             	test   %rax,%rax
    95d0:	74 0c                	je     95de <tp_int+0x4e>
    95d2:	48 8b 40 08          	mov    0x8(%rax),%rax
    95d6:	48 89 03             	mov    %rax,(%rbx)
    95d9:	bd 01 00 00 00       	mov    $0x1,%ebp
    95de:	89 e8                	mov    %ebp,%eax
    95e0:	48 81 c4 80 00 00 00 	add    $0x80,%rsp
    95e7:	5b                   	pop    %rbx
    95e8:	41 5e                	pop    %r14
    95ea:	5d                   	pop    %rbp
    95eb:	c3                   	ret
    95ec:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000095f0 <tp_float>:
    95f0:	41 56                	push   %r14
    95f2:	53                   	push   %rbx
    95f3:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    95fa:	48 89 d3             	mov    %rdx,%rbx
    95fd:	49 89 f6             	mov    %rsi,%r14
    9600:	48 89 e6             	mov    %rsp,%rsi
    9603:	ba 80 00 00 00       	mov    $0x80,%edx
    9608:	e8 13 04 00 00       	call   9a20 <tp_token>
    960d:	31 c9                	xor    %ecx,%ecx
    960f:	48 83 f8 7f          	cmp    $0x7f,%rax
    9613:	0f 87 84 00 00 00    	ja     969d <tp_float+0xad>
    9619:	8b 0c 24             	mov    (%rsp),%ecx
    961c:	81 f9 69 6e 66 00    	cmp    $0x666e69,%ecx
    9622:	75 0a                	jne    962e <tp_float+0x3e>
    9624:	f2 0f 10 05 34 5b 00 	movsd  0x5b34(%rip),%xmm0        # f160 <_IO_stdin_used+0x160>
    962b:	00 
    962c:	eb 5f                	jmp    968d <tp_float+0x9d>
    962e:	ba 2d 69 6e 66       	mov    $0x666e692d,%edx
    9633:	33 14 24             	xor    (%rsp),%edx
    9636:	0f b6 74 24 04       	movzbl 0x4(%rsp),%esi
    963b:	09 d6                	or     %edx,%esi
    963d:	74 12                	je     9651 <tp_float+0x61>
    963f:	81 f9 4e 61 4e 00    	cmp    $0x4e614e,%ecx
    9645:	75 14                	jne    965b <tp_float+0x6b>
    9647:	f2 0f 10 05 21 5b 00 	movsd  0x5b21(%rip),%xmm0        # f170 <_IO_stdin_used+0x170>
    964e:	00 
    964f:	eb 3c                	jmp    968d <tp_float+0x9d>
    9651:	f2 0f 10 05 0f 5b 00 	movsd  0x5b0f(%rip),%xmm0        # f168 <_IO_stdin_used+0x168>
    9658:	00 
    9659:	eb 32                	jmp    968d <tp_float+0x9d>
    965b:	48 89 e7             	mov    %rsp,%rdi
    965e:	48 89 c6             	mov    %rax,%rsi
    9661:	e8 7a 0e 00 00       	call   a4e0 <fwp_valid_float>
    9666:	31 c9                	xor    %ecx,%ecx
    9668:	85 c0                	test   %eax,%eax
    966a:	74 31                	je     969d <tp_float+0xad>
    966c:	41 83 3e 0a          	cmpl   $0xa,(%r14)
    9670:	75 11                	jne    9683 <tp_float+0x93>
    9672:	48 89 e7             	mov    %rsp,%rdi
    9675:	31 f6                	xor    %esi,%esi
    9677:	e8 84 9b ff ff       	call   3200 <strtof@plt>
    967c:	e8 3f cc ff ff       	call   62c0 <fwp_from_f32>
    9681:	eb 12                	jmp    9695 <tp_float+0xa5>
    9683:	48 89 e7             	mov    %rsp,%rdi
    9686:	31 f6                	xor    %esi,%esi
    9688:	e8 73 9a ff ff       	call   3100 <strtod@plt>
    968d:	41 8b 3e             	mov    (%r14),%edi
    9690:	e8 3b 0f 00 00       	call   a5d0 <fwp_float_of>
    9695:	48 89 03             	mov    %rax,(%rbx)
    9698:	b9 01 00 00 00       	mov    $0x1,%ecx
    969d:	89 c8                	mov    %ecx,%eax
    969f:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
    96a6:	5b                   	pop    %rbx
    96a7:	41 5e                	pop    %r14
    96a9:	c3                   	ret
    96aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000096b0 <tp_quoted>:
    96b0:	55                   	push   %rbp
    96b1:	41 57                	push   %r15
    96b3:	41 56                	push   %r14
    96b5:	41 55                	push   %r13
    96b7:	41 54                	push   %r12
    96b9:	53                   	push   %rbx
    96ba:	48 83 ec 18          	sub    $0x18,%rsp
    96be:	49 89 f6             	mov    %rsi,%r14
    96c1:	49 89 ff             	mov    %rdi,%r15
    96c4:	e8 77 fe ff ff       	call   9540 <tp_ws>
    96c9:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    96cd:	49 8b 6f 10          	mov    0x10(%r15),%rbp
    96d1:	31 db                	xor    %ebx,%ebx
    96d3:	4c 39 ed             	cmp    %r13,%rbp
    96d6:	0f 83 0d 02 00 00    	jae    98e9 <tp_quoted+0x239>
    96dc:	49 8b 07             	mov    (%r15),%rax
    96df:	80 3c 28 22          	cmpb   $0x22,(%rax,%rbp,1)
    96e3:	0f 85 00 02 00 00    	jne    98e9 <tp_quoted+0x239>
    96e9:	48 ff c5             	inc    %rbp
    96ec:	49 89 6f 10          	mov    %rbp,0x10(%r15)
    96f0:	0f 57 c0             	xorps  %xmm0,%xmm0
    96f3:	0f 29 04 24          	movaps %xmm0,(%rsp)
    96f7:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    96fe:	00 00 
    9700:	31 db                	xor    %ebx,%ebx
    9702:	4c 39 ed             	cmp    %r13,%rbp
    9705:	0f 83 8d 01 00 00    	jae    9898 <tp_quoted+0x1e8>
    970b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    9710:	4d 8b 27             	mov    (%r15),%r12
    9713:	48 8d 4d 01          	lea    0x1(%rbp),%rcx
    9717:	49 89 4f 10          	mov    %rcx,0x10(%r15)
    971b:	41 0f b6 04 2c       	movzbl (%r12,%rbp,1),%eax
    9720:	83 f8 5c             	cmp    $0x5c,%eax
    9723:	74 2b                	je     9750 <tp_quoted+0xa0>
    9725:	83 f8 22             	cmp    $0x22,%eax
    9728:	0f 84 8b 01 00 00    	je     98b9 <tp_quoted+0x209>
    972e:	0f be f0             	movsbl %al,%esi
    9731:	48 89 e7             	mov    %rsp,%rdi
    9734:	e8 57 ee ff ff       	call   8590 <buf_putc>
    9739:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    973d:	49 8b 6f 10          	mov    0x10(%r15),%rbp
    9741:	4c 39 ed             	cmp    %r13,%rbp
    9744:	72 ca                	jb     9710 <tp_quoted+0x60>
    9746:	e9 63 01 00 00       	jmp    98ae <tp_quoted+0x1fe>
    974b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    9750:	4c 39 e9             	cmp    %r13,%rcx
    9753:	0f 83 48 01 00 00    	jae    98a1 <tp_quoted+0x1f1>
    9759:	48 8d 45 02          	lea    0x2(%rbp),%rax
    975d:	49 89 47 10          	mov    %rax,0x10(%r15)
    9761:	41 0f b6 4c 2c 01    	movzbl 0x1(%r12,%rbp,1),%ecx
    9767:	8d 51 a4             	lea    -0x5c(%rcx),%edx
    976a:	83 fa 19             	cmp    $0x19,%edx
    976d:	77 1a                	ja     9789 <tp_quoted+0xd9>
    976f:	48 8d 35 ba 5a 00 00 	lea    0x5aba(%rip),%rsi        # f230 <_IO_stdin_used+0x230>
    9776:	48 63 0c 96          	movslq (%rsi,%rdx,4),%rcx
    977a:	48 01 f1             	add    %rsi,%rcx
    977d:	ff e1                	jmp    *%rcx
    977f:	48 89 e7             	mov    %rsp,%rdi
    9782:	be 5c 00 00 00       	mov    $0x5c,%esi
    9787:	eb ab                	jmp    9734 <tp_quoted+0x84>
    9789:	83 f9 22             	cmp    $0x22,%ecx
    978c:	0f 84 bf 00 00 00    	je     9851 <tp_quoted+0x1a1>
    9792:	83 f9 30             	cmp    $0x30,%ecx
    9795:	0f 85 06 01 00 00    	jne    98a1 <tp_quoted+0x1f1>
    979b:	48 89 e7             	mov    %rsp,%rdi
    979e:	31 f6                	xor    %esi,%esi
    97a0:	eb 92                	jmp    9734 <tp_quoted+0x84>
    97a2:	48 89 e7             	mov    %rsp,%rdi
    97a5:	be 09 00 00 00       	mov    $0x9,%esi
    97aa:	eb 88                	jmp    9734 <tp_quoted+0x84>
    97ac:	48 89 e7             	mov    %rsp,%rdi
    97af:	be 0d 00 00 00       	mov    $0xd,%esi
    97b4:	e9 7b ff ff ff       	jmp    9734 <tp_quoted+0x84>
    97b9:	48 89 e7             	mov    %rsp,%rdi
    97bc:	be 0a 00 00 00       	mov    $0xa,%esi
    97c1:	e9 6e ff ff ff       	jmp    9734 <tp_quoted+0x84>
    97c6:	4c 39 e8             	cmp    %r13,%rax
    97c9:	0f 83 d2 00 00 00    	jae    98a1 <tp_quoted+0x1f1>
    97cf:	41 80 3c 04 7b       	cmpb   $0x7b,(%r12,%rax,1)
    97d4:	0f 85 c7 00 00 00    	jne    98a1 <tp_quoted+0x1f1>
    97da:	48 8d 45 03          	lea    0x3(%rbp),%rax
    97de:	49 89 47 10          	mov    %rax,0x10(%r15)
    97e2:	4c 39 e8             	cmp    %r13,%rax
    97e5:	0f 83 b6 00 00 00    	jae    98a1 <tp_quoted+0x1f1>
    97eb:	e8 10 9d ff ff       	call   3500 <__ctype_b_loc@plt>
    97f0:	48 8b 08             	mov    (%rax),%rcx
    97f3:	48 8d 55 04          	lea    0x4(%rbp),%rdx
    97f7:	49 8d 3c 2c          	lea    (%r12,%rbp,1),%rdi
    97fb:	48 83 c7 03          	add    $0x3,%rdi
    97ff:	49 29 ed             	sub    %rbp,%r13
    9802:	49 83 c5 fd          	add    $0xfffffffffffffffd,%r13
    9806:	31 c0                	xor    %eax,%eax
    9808:	31 f6                	xor    %esi,%esi
    980a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9810:	44 0f b6 04 07       	movzbl (%rdi,%rax,1),%r8d
    9815:	42 f6 44 41 01 10    	testb  $0x10,0x1(%rcx,%r8,2)
    981b:	74 41                	je     985e <tp_quoted+0x1ae>
    981d:	4c 8d 04 02          	lea    (%rdx,%rax,1),%r8
    9821:	4d 89 47 10          	mov    %r8,0x10(%r15)
    9825:	44 0f be 04 07       	movsbl (%rdi,%rax,1),%r8d
    982a:	c1 e6 04             	shl    $0x4,%esi
    982d:	45 8d 48 d0          	lea    -0x30(%r8),%r9d
    9831:	45 89 c2             	mov    %r8d,%r10d
    9834:	41 83 ca 20          	or     $0x20,%r10d
    9838:	41 83 c2 a9          	add    $0xffffffa9,%r10d
    983c:	41 83 f8 3a          	cmp    $0x3a,%r8d
    9840:	45 0f 4c d1          	cmovl  %r9d,%r10d
    9844:	44 01 d6             	add    %r10d,%esi
    9847:	48 ff c0             	inc    %rax
    984a:	49 39 c5             	cmp    %rax,%r13
    984d:	75 c1                	jne    9810 <tp_quoted+0x160>
    984f:	eb 50                	jmp    98a1 <tp_quoted+0x1f1>
    9851:	48 89 e7             	mov    %rsp,%rdi
    9854:	be 22 00 00 00       	mov    $0x22,%esi
    9859:	e9 d6 fe ff ff       	jmp    9734 <tp_quoted+0x84>
    985e:	85 c0                	test   %eax,%eax
    9860:	74 3f                	je     98a1 <tp_quoted+0x1f1>
    9862:	41 80 f8 7d          	cmp    $0x7d,%r8b
    9866:	75 39                	jne    98a1 <tp_quoted+0x1f1>
    9868:	81 fe ff ff 10 00    	cmp    $0x10ffff,%esi
    986e:	77 31                	ja     98a1 <tp_quoted+0x1f1>
    9870:	89 f1                	mov    %esi,%ecx
    9872:	81 e1 00 f8 ff ff    	and    $0xfffff800,%ecx
    9878:	81 f9 00 d8 00 00    	cmp    $0xd800,%ecx
    987e:	74 21                	je     98a1 <tp_quoted+0x1f1>
    9880:	48 01 e8             	add    %rbp,%rax
    9883:	48 83 c0 04          	add    $0x4,%rax
    9887:	49 89 47 10          	mov    %rax,0x10(%r15)
    988b:	48 89 e7             	mov    %rsp,%rdi
    988e:	e8 5d 0d 00 00       	call   a5f0 <fwp_utf8_put>
    9893:	e9 a1 fe ff ff       	jmp    9739 <tp_quoted+0x89>
    9898:	31 ff                	xor    %edi,%edi
    989a:	e8 b1 97 ff ff       	call   3050 <free@plt>
    989f:	eb 48                	jmp    98e9 <tp_quoted+0x239>
    98a1:	48 8b 3c 24          	mov    (%rsp),%rdi
    98a5:	e8 a6 97 ff ff       	call   3050 <free@plt>
    98aa:	31 db                	xor    %ebx,%ebx
    98ac:	eb 3b                	jmp    98e9 <tp_quoted+0x239>
    98ae:	48 8b 3c 24          	mov    (%rsp),%rdi
    98b2:	e8 99 97 ff ff       	call   3050 <free@plt>
    98b7:	eb 30                	jmp    98e9 <tp_quoted+0x239>
    98b9:	48 8b 1c 24          	mov    (%rsp),%rbx
    98bd:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    98c2:	48 85 db             	test   %rbx,%rbx
    98c5:	48 8d 3d 23 66 00 00 	lea    0x6623(%rip),%rdi        # feef <exec_in_fp0+0x7ef>
    98cc:	48 0f 45 fb          	cmovne %rbx,%rdi
    98d0:	e8 1b eb ff ff       	call   83f0 <fwp_valid_utf8>
    98d5:	85 c0                	test   %eax,%eax
    98d7:	74 21                	je     98fa <tp_quoted+0x24a>
    98d9:	48 89 e7             	mov    %rsp,%rdi
    98dc:	e8 3f ed ff ff       	call   8620 <buf_to_str>
    98e1:	49 89 06             	mov    %rax,(%r14)
    98e4:	bb 01 00 00 00       	mov    $0x1,%ebx
    98e9:	89 d8                	mov    %ebx,%eax
    98eb:	48 83 c4 18          	add    $0x18,%rsp
    98ef:	5b                   	pop    %rbx
    98f0:	41 5c                	pop    %r12
    98f2:	41 5d                	pop    %r13
    98f4:	41 5e                	pop    %r14
    98f6:	41 5f                	pop    %r15
    98f8:	5d                   	pop    %rbp
    98f9:	c3                   	ret
    98fa:	48 89 df             	mov    %rbx,%rdi
    98fd:	eb a6                	jmp    98a5 <tp_quoted+0x1f5>
    98ff:	90                   	nop

0000000000009900 <tp_eat>:
    9900:	55                   	push   %rbp
    9901:	41 57                	push   %r15
    9903:	41 56                	push   %r14
    9905:	53                   	push   %rbx
    9906:	50                   	push   %rax
    9907:	49 89 f6             	mov    %rsi,%r14
    990a:	48 89 fb             	mov    %rdi,%rbx
    990d:	e8 2e fc ff ff       	call   9540 <tp_ws>
    9912:	4c 89 f7             	mov    %r14,%rdi
    9915:	e8 56 98 ff ff       	call   3170 <strlen@plt>
    991a:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    991e:	4c 8b 7b 10          	mov    0x10(%rbx),%r15
    9922:	4c 29 f9             	sub    %r15,%rcx
    9925:	31 ed                	xor    %ebp,%ebp
    9927:	48 39 c1             	cmp    %rax,%rcx
    992a:	72 24                	jb     9950 <tp_eat+0x50>
    992c:	48 8b 3b             	mov    (%rbx),%rdi
    992f:	4c 01 ff             	add    %r15,%rdi
    9932:	4c 89 f6             	mov    %r14,%rsi
    9935:	49 89 c6             	mov    %rax,%r14
    9938:	48 89 c2             	mov    %rax,%rdx
    993b:	e8 30 9a ff ff       	call   3370 <bcmp@plt>
    9940:	85 c0                	test   %eax,%eax
    9942:	75 0c                	jne    9950 <tp_eat+0x50>
    9944:	4d 01 f7             	add    %r14,%r15
    9947:	4c 89 7b 10          	mov    %r15,0x10(%rbx)
    994b:	bd 01 00 00 00       	mov    $0x1,%ebp
    9950:	89 e8                	mov    %ebp,%eax
    9952:	48 83 c4 08          	add    $0x8,%rsp
    9956:	5b                   	pop    %rbx
    9957:	41 5e                	pop    %r14
    9959:	41 5f                	pop    %r15
    995b:	5d                   	pop    %rbp
    995c:	c3                   	ret
    995d:	0f 1f 00             	nopl   (%rax)

0000000000009960 <tp_list_of>:
    9960:	55                   	push   %rbp
    9961:	41 57                	push   %r15
    9963:	41 56                	push   %r14
    9965:	41 55                	push   %r13
    9967:	41 54                	push   %r12
    9969:	53                   	push   %rbx
    996a:	50                   	push   %rax
    996b:	4d 89 c6             	mov    %r8,%r14
    996e:	49 89 cf             	mov    %rcx,%r15
    9971:	49 89 d4             	mov    %rdx,%r12
    9974:	49 89 fd             	mov    %rdi,%r13
    9977:	e8 84 ff ff ff       	call   9900 <tp_eat>
    997c:	31 db                	xor    %ebx,%ebx
    997e:	85 c0                	test   %eax,%eax
    9980:	74 14                	je     9996 <tp_list_of+0x36>
    9982:	4c 89 ef             	mov    %r13,%rdi
    9985:	4c 89 e6             	mov    %r12,%rsi
    9988:	e8 73 ff ff ff       	call   9900 <tp_eat>
    998d:	85 c0                	test   %eax,%eax
    998f:	74 16                	je     99a7 <tp_list_of+0x47>
    9991:	bb 01 00 00 00       	mov    $0x1,%ebx
    9996:	89 d8                	mov    %ebx,%eax
    9998:	48 83 c4 08          	add    $0x8,%rsp
    999c:	5b                   	pop    %rbx
    999d:	41 5c                	pop    %r12
    999f:	41 5d                	pop    %r13
    99a1:	41 5e                	pop    %r14
    99a3:	41 5f                	pop    %r15
    99a5:	5d                   	pop    %rbp
    99a6:	c3                   	ret
    99a7:	48 8d 2d 34 5e 00 00 	lea    0x5e34(%rip),%rbp        # f7e2 <exec_in_fp0+0xe2>
    99ae:	66 90                	xchg   %ax,%ax
    99b0:	4c 89 ef             	mov    %r13,%rdi
    99b3:	4c 89 f6             	mov    %r14,%rsi
    99b6:	41 ff d7             	call   *%r15
    99b9:	85 c0                	test   %eax,%eax
    99bb:	74 d9                	je     9996 <tp_list_of+0x36>
    99bd:	4c 89 ef             	mov    %r13,%rdi
    99c0:	4c 89 e6             	mov    %r12,%rsi
    99c3:	e8 38 ff ff ff       	call   9900 <tp_eat>
    99c8:	85 c0                	test   %eax,%eax
    99ca:	75 c5                	jne    9991 <tp_list_of+0x31>
    99cc:	4c 89 ef             	mov    %r13,%rdi
    99cf:	48 89 ee             	mov    %rbp,%rsi
    99d2:	e8 29 ff ff ff       	call   9900 <tp_eat>
    99d7:	85 c0                	test   %eax,%eax
    99d9:	75 d5                	jne    99b0 <tp_list_of+0x50>
    99db:	eb b9                	jmp    9996 <tp_list_of+0x36>
    99dd:	0f 1f 00             	nopl   (%rax)

00000000000099e0 <tp_byte_item>:
    99e0:	53                   	push   %rbx
    99e1:	48 83 ec 10          	sub    $0x10,%rsp
    99e5:	48 89 f3             	mov    %rsi,%rbx
    99e8:	48 8d 35 91 b2 00 00 	lea    0xb291(%rip),%rsi        # 14c80 <tp_byte_item.u8d>
    99ef:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    99f4:	e8 97 fb ff ff       	call   9590 <tp_int>
    99f9:	85 c0                	test   %eax,%eax
    99fb:	74 14                	je     9a11 <tp_byte_item+0x31>
    99fd:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    9a02:	48 89 df             	mov    %rbx,%rdi
    9a05:	e8 96 0c 00 00       	call   a6a0 <tp_push>
    9a0a:	b8 01 00 00 00       	mov    $0x1,%eax
    9a0f:	eb 02                	jmp    9a13 <tp_byte_item+0x33>
    9a11:	31 c0                	xor    %eax,%eax
    9a13:	48 83 c4 10          	add    $0x10,%rsp
    9a17:	5b                   	pop    %rbx
    9a18:	c3                   	ret
    9a19:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000009a20 <tp_token>:
    9a20:	55                   	push   %rbp
    9a21:	41 57                	push   %r15
    9a23:	41 56                	push   %r14
    9a25:	41 55                	push   %r13
    9a27:	41 54                	push   %r12
    9a29:	53                   	push   %rbx
    9a2a:	50                   	push   %rax
    9a2b:	49 89 d7             	mov    %rdx,%r15
    9a2e:	48 89 34 24          	mov    %rsi,(%rsp)
    9a32:	48 89 fb             	mov    %rdi,%rbx
    9a35:	e8 06 fb ff ff       	call   9540 <tp_ws>
    9a3a:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    9a3e:	4c 8b 23             	mov    (%rbx),%r12
    9a41:	4c 8b 6b 08          	mov    0x8(%rbx),%r13
    9a45:	4c 89 f5             	mov    %r14,%rbp
    9a48:	4d 39 ee             	cmp    %r13,%r14
    9a4b:	73 20                	jae    9a6d <tp_token+0x4d>
    9a4d:	4c 89 f5             	mov    %r14,%rbp
    9a50:	41 0f be 3c 2c       	movsbl (%r12,%rbp,1),%edi
    9a55:	e8 a6 0c 00 00       	call   a700 <tp_is_delim>
    9a5a:	85 c0                	test   %eax,%eax
    9a5c:	75 0f                	jne    9a6d <tp_token+0x4d>
    9a5e:	48 ff c5             	inc    %rbp
    9a61:	48 89 6b 10          	mov    %rbp,0x10(%rbx)
    9a65:	49 39 ed             	cmp    %rbp,%r13
    9a68:	75 e6                	jne    9a50 <tp_token+0x30>
    9a6a:	4c 89 ed             	mov    %r13,%rbp
    9a6d:	4c 29 f5             	sub    %r14,%rbp
    9a70:	4d 8d 6f ff          	lea    -0x1(%r15),%r13
    9a74:	4c 39 fd             	cmp    %r15,%rbp
    9a77:	4c 0f 42 ed          	cmovb  %rbp,%r13
    9a7b:	4d 01 f4             	add    %r14,%r12
    9a7e:	4c 8b 3c 24          	mov    (%rsp),%r15
    9a82:	4c 89 ff             	mov    %r15,%rdi
    9a85:	4c 89 e6             	mov    %r12,%rsi
    9a88:	4c 89 ea             	mov    %r13,%rdx
    9a8b:	e8 a0 98 ff ff       	call   3330 <memcpy@plt>
    9a90:	43 c6 04 2f 00       	movb   $0x0,(%r15,%r13,1)
    9a95:	48 8b 43 10          	mov    0x10(%rbx),%rax
    9a99:	4c 29 f0             	sub    %r14,%rax
    9a9c:	48 83 c4 08          	add    $0x8,%rsp
    9aa0:	5b                   	pop    %rbx
    9aa1:	41 5c                	pop    %r12
    9aa3:	41 5d                	pop    %r13
    9aa5:	41 5e                	pop    %r14
    9aa7:	41 5f                	pop    %r15
    9aa9:	5d                   	pop    %rbp
    9aaa:	c3                   	ret
    9aab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000009ab0 <tp_elem_item>:
    9ab0:	55                   	push   %rbp
    9ab1:	53                   	push   %rbx
    9ab2:	50                   	push   %rax
    9ab3:	48 89 f3             	mov    %rsi,%rbx
    9ab6:	48 8b 36             	mov    (%rsi),%rsi
    9ab9:	31 ed                	xor    %ebp,%ebp
    9abb:	48 89 e1             	mov    %rsp,%rcx
    9abe:	31 d2                	xor    %edx,%edx
    9ac0:	e8 4b f1 ff ff       	call   8c10 <tp_value>
    9ac5:	85 c0                	test   %eax,%eax
    9ac7:	74 11                	je     9ada <tp_elem_item+0x2a>
    9ac9:	48 8b 34 24          	mov    (%rsp),%rsi
    9acd:	48 89 df             	mov    %rbx,%rdi
    9ad0:	e8 cb 0b 00 00       	call   a6a0 <tp_push>
    9ad5:	bd 01 00 00 00       	mov    $0x1,%ebp
    9ada:	89 e8                	mov    %ebp,%eax
    9adc:	48 83 c4 08          	add    $0x8,%rsp
    9ae0:	5b                   	pop    %rbx
    9ae1:	5d                   	pop    %rbp
    9ae2:	c3                   	ret
    9ae3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9aea:	84 00 00 00 00 00 

0000000000009af0 <fwp_p_array_from_list>:
    9af0:	41 56                	push   %r14
    9af2:	53                   	push   %rbx
    9af3:	50                   	push   %rax
    9af4:	48 89 fb             	mov    %rdi,%rbx
    9af7:	e8 44 0c 00 00       	call   a740 <fwp_list_len>
    9afc:	49 89 c6             	mov    %rax,%r14
    9aff:	48 89 c7             	mov    %rax,%rdi
    9b02:	e8 09 ca ff ff       	call   6510 <fwp_arr_new>
    9b07:	4d 85 f6             	test   %r14,%r14
    9b0a:	0f 84 84 00 00 00    	je     9b94 <fwp_p_array_from_list+0xa4>
    9b10:	44 89 f1             	mov    %r14d,%ecx
    9b13:	83 e1 03             	and    $0x3,%ecx
    9b16:	49 83 fe 04          	cmp    $0x4,%r14
    9b1a:	73 04                	jae    9b20 <fwp_p_array_from_list+0x30>
    9b1c:	31 d2                	xor    %edx,%edx
    9b1e:	eb 4d                	jmp    9b6d <fwp_p_array_from_list+0x7d>
    9b20:	49 83 e6 fc          	and    $0xfffffffffffffffc,%r14
    9b24:	31 d2                	xor    %edx,%edx
    9b26:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    9b2d:	00 00 00 
    9b30:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    9b34:	48 89 74 d0 08       	mov    %rsi,0x8(%rax,%rdx,8)
    9b39:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    9b3d:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
    9b41:	48 89 7c d0 10       	mov    %rdi,0x10(%rax,%rdx,8)
    9b46:	48 8b 76 10          	mov    0x10(%rsi),%rsi
    9b4a:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
    9b4e:	48 89 7c d0 18       	mov    %rdi,0x18(%rax,%rdx,8)
    9b53:	48 8b 76 10          	mov    0x10(%rsi),%rsi
    9b57:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
    9b5b:	48 89 7c d0 20       	mov    %rdi,0x20(%rax,%rdx,8)
    9b60:	48 8b 5e 10          	mov    0x10(%rsi),%rbx
    9b64:	48 83 c2 04          	add    $0x4,%rdx
    9b68:	49 39 d6             	cmp    %rdx,%r14
    9b6b:	75 c3                	jne    9b30 <fwp_p_array_from_list+0x40>
    9b6d:	48 85 c9             	test   %rcx,%rcx
    9b70:	74 22                	je     9b94 <fwp_p_array_from_list+0xa4>
    9b72:	48 8d 14 d0          	lea    (%rax,%rdx,8),%rdx
    9b76:	48 83 c2 08          	add    $0x8,%rdx
    9b7a:	31 f6                	xor    %esi,%esi
    9b7c:	0f 1f 40 00          	nopl   0x0(%rax)
    9b80:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    9b84:	48 89 3c f2          	mov    %rdi,(%rdx,%rsi,8)
    9b88:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    9b8c:	48 ff c6             	inc    %rsi
    9b8f:	48 39 f1             	cmp    %rsi,%rcx
    9b92:	75 ec                	jne    9b80 <fwp_p_array_from_list+0x90>
    9b94:	48 83 c4 08          	add    $0x8,%rsp
    9b98:	5b                   	pop    %rbx
    9b99:	41 5e                	pop    %r14
    9b9b:	c3                   	ret
    9b9c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000009ba0 <tp_kv_item>:
    9ba0:	41 57                	push   %r15
    9ba2:	41 56                	push   %r14
    9ba4:	53                   	push   %rbx
    9ba5:	48 83 ec 10          	sub    $0x10,%rsp
    9ba9:	48 89 f3             	mov    %rsi,%rbx
    9bac:	49 89 ff             	mov    %rdi,%r15
    9baf:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
    9bb6:	00 
    9bb7:	48 8b 36             	mov    (%rsi),%rsi
    9bba:	45 31 f6             	xor    %r14d,%r14d
    9bbd:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    9bc2:	31 d2                	xor    %edx,%edx
    9bc4:	e8 47 f0 ff ff       	call   8c10 <tp_value>
    9bc9:	85 c0                	test   %eax,%eax
    9bcb:	74 27                	je     9bf4 <tp_kv_item+0x54>
    9bcd:	45 31 f6             	xor    %r14d,%r14d
    9bd0:	83 7b 28 00          	cmpl   $0x0,0x28(%rbx)
    9bd4:	74 2b                	je     9c01 <tp_kv_item+0x61>
    9bd6:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    9bdb:	48 89 df             	mov    %rbx,%rdi
    9bde:	e8 bd 0a 00 00       	call   a6a0 <tp_push>
    9be3:	48 89 df             	mov    %rbx,%rdi
    9be6:	4c 89 f6             	mov    %r14,%rsi
    9be9:	e8 b2 0a 00 00       	call   a6a0 <tp_push>
    9bee:	41 be 01 00 00 00    	mov    $0x1,%r14d
    9bf4:	44 89 f0             	mov    %r14d,%eax
    9bf7:	48 83 c4 10          	add    $0x10,%rsp
    9bfb:	5b                   	pop    %rbx
    9bfc:	41 5e                	pop    %r14
    9bfe:	41 5f                	pop    %r15
    9c00:	c3                   	ret
    9c01:	48 8d 35 d9 67 00 00 	lea    0x67d9(%rip),%rsi        # 103e1 <exec_in_fp0+0xce1>
    9c08:	4c 89 ff             	mov    %r15,%rdi
    9c0b:	e8 f0 fc ff ff       	call   9900 <tp_eat>
    9c10:	85 c0                	test   %eax,%eax
    9c12:	74 e0                	je     9bf4 <tp_kv_item+0x54>
    9c14:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    9c18:	45 31 f6             	xor    %r14d,%r14d
    9c1b:	48 89 e1             	mov    %rsp,%rcx
    9c1e:	4c 89 ff             	mov    %r15,%rdi
    9c21:	31 d2                	xor    %edx,%edx
    9c23:	e8 e8 ef ff ff       	call   8c10 <tp_value>
    9c28:	85 c0                	test   %eax,%eax
    9c2a:	74 c8                	je     9bf4 <tp_kv_item+0x54>
    9c2c:	4c 8b 34 24          	mov    (%rsp),%r14
    9c30:	eb a4                	jmp    9bd6 <tp_kv_item+0x36>
    9c32:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9c39:	1f 84 00 00 00 00 00 

0000000000009c40 <fwp_p_map_insert>:
    9c40:	55                   	push   %rbp
    9c41:	41 57                	push   %r15
    9c43:	41 56                	push   %r14
    9c45:	41 55                	push   %r13
    9c47:	41 54                	push   %r12
    9c49:	53                   	push   %rbx
    9c4a:	48 83 ec 18          	sub    $0x18,%rsp
    9c4e:	49 89 d6             	mov    %rdx,%r14
    9c51:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    9c56:	48 89 fe             	mov    %rdi,%rsi
    9c59:	48 8d 44 24 04       	lea    0x4(%rsp),%rax
    9c5e:	48 89 d7             	mov    %rdx,%rdi
    9c61:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
    9c66:	48 89 ca             	mov    %rcx,%rdx
    9c69:	48 89 c1             	mov    %rax,%rcx
    9c6c:	e8 ef 0a 00 00       	call   a760 <fwp_map_find>
    9c71:	48 89 c5             	mov    %rax,%rbp
    9c74:	4d 8b 3e             	mov    (%r14),%r15
    9c77:	44 8b 64 24 04       	mov    0x4(%rsp),%r12d
    9c7c:	31 ff                	xor    %edi,%edi
    9c7e:	45 85 e4             	test   %r12d,%r12d
    9c81:	40 0f 94 c7          	sete   %dil
    9c85:	4c 01 ff             	add    %r15,%rdi
    9c88:	e8 23 0c 00 00       	call   a8b0 <fwp_map_alloc>
    9c8d:	49 89 c5             	mov    %rax,%r13
    9c90:	48 8d 58 08          	lea    0x8(%rax),%rbx
    9c94:	49 83 c6 08          	add    $0x8,%r14
    9c98:	45 85 e4             	test   %r12d,%r12d
    9c9b:	74 22                	je     9cbf <fwp_p_map_insert+0x7f>
    9c9d:	49 c1 e7 04          	shl    $0x4,%r15
    9ca1:	48 89 df             	mov    %rbx,%rdi
    9ca4:	4c 89 f6             	mov    %r14,%rsi
    9ca7:	4c 89 fa             	mov    %r15,%rdx
    9caa:	e8 81 96 ff ff       	call   3330 <memcpy@plt>
    9caf:	48 c1 e5 04          	shl    $0x4,%rbp
    9cb3:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    9cb8:	49 89 44 2d 10       	mov    %rax,0x10(%r13,%rbp,1)
    9cbd:	eb 46                	jmp    9d05 <fwp_p_map_insert+0xc5>
    9cbf:	49 89 ec             	mov    %rbp,%r12
    9cc2:	49 c1 e4 04          	shl    $0x4,%r12
    9cc6:	48 89 df             	mov    %rbx,%rdi
    9cc9:	4c 89 f6             	mov    %r14,%rsi
    9ccc:	4c 89 e2             	mov    %r12,%rdx
    9ccf:	e8 5c 96 ff ff       	call   3330 <memcpy@plt>
    9cd4:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    9cd9:	4b 89 44 25 08       	mov    %rax,0x8(%r13,%r12,1)
    9cde:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    9ce3:	4b 89 44 25 10       	mov    %rax,0x10(%r13,%r12,1)
    9ce8:	4a 8d 3c 23          	lea    (%rbx,%r12,1),%rdi
    9cec:	48 83 c7 10          	add    $0x10,%rdi
    9cf0:	4d 01 f4             	add    %r14,%r12
    9cf3:	49 29 ef             	sub    %rbp,%r15
    9cf6:	49 c1 e7 04          	shl    $0x4,%r15
    9cfa:	4c 89 e6             	mov    %r12,%rsi
    9cfd:	4c 89 fa             	mov    %r15,%rdx
    9d00:	e8 2b 96 ff ff       	call   3330 <memcpy@plt>
    9d05:	4c 89 e8             	mov    %r13,%rax
    9d08:	48 83 c4 18          	add    $0x18,%rsp
    9d0c:	5b                   	pop    %rbx
    9d0d:	41 5c                	pop    %r12
    9d0f:	41 5d                	pop    %r13
    9d11:	41 5e                	pop    %r14
    9d13:	41 5f                	pop    %r15
    9d15:	5d                   	pop    %rbp
    9d16:	c3                   	ret
    9d17:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    9d1e:	00 00 

0000000000009d20 <fwp_valid_int>:
    9d20:	31 c0                	xor    %eax,%eax
    9d22:	48 85 f6             	test   %rsi,%rsi
    9d25:	74 32                	je     9d59 <fwp_valid_int+0x39>
    9d27:	0f b6 17             	movzbl (%rdi),%edx
    9d2a:	80 c2 d5             	add    $0xd5,%dl
    9d2d:	31 c9                	xor    %ecx,%ecx
    9d2f:	f6 c2 fd             	test   $0xfd,%dl
    9d32:	0f 94 c1             	sete   %cl
    9d35:	48 39 f1             	cmp    %rsi,%rcx
    9d38:	74 1f                	je     9d59 <fwp_valid_int+0x39>
    9d3a:	73 18                	jae    9d54 <fwp_valid_int+0x34>
    9d3c:	0f 1f 40 00          	nopl   0x0(%rax)
    9d40:	0f b6 14 0f          	movzbl (%rdi,%rcx,1),%edx
    9d44:	80 c2 c6             	add    $0xc6,%dl
    9d47:	80 fa f5             	cmp    $0xf5,%dl
    9d4a:	76 0d                	jbe    9d59 <fwp_valid_int+0x39>
    9d4c:	48 ff c1             	inc    %rcx
    9d4f:	48 39 ce             	cmp    %rcx,%rsi
    9d52:	75 ec                	jne    9d40 <fwp_valid_int+0x20>
    9d54:	b8 01 00 00 00       	mov    $0x1,%eax
    9d59:	c3                   	ret
    9d5a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000009d60 <tp_record_body>:
    9d60:	55                   	push   %rbp
    9d61:	41 57                	push   %r15
    9d63:	41 56                	push   %r14
    9d65:	41 55                	push   %r13
    9d67:	41 54                	push   %r12
    9d69:	53                   	push   %rbx
    9d6a:	48 81 ec 28 01 00 00 	sub    $0x128,%rsp
    9d71:	48 89 d3             	mov    %rdx,%rbx
    9d74:	49 89 f5             	mov    %rsi,%r13
    9d77:	48 89 fd             	mov    %rdi,%rbp
    9d7a:	48 63 46 10          	movslq 0x10(%rsi),%rax
    9d7e:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    9d85:	00 
    9d86:	e8 c5 c7 ff ff       	call   6550 <fwp_alloc>
    9d8b:	49 89 c7             	mov    %rax,%r15
    9d8e:	49 63 7d 10          	movslq 0x10(%r13),%rdi
    9d92:	48 ff c7             	inc    %rdi
    9d95:	e8 16 d4 ff ff       	call   71b0 <fwp_alloc_leaf>
    9d9a:	49 89 c4             	mov    %rax,%r12
    9d9d:	49 63 55 10          	movslq 0x10(%r13),%rdx
    9da1:	48 ff c2             	inc    %rdx
    9da4:	45 31 f6             	xor    %r14d,%r14d
    9da7:	48 89 c7             	mov    %rax,%rdi
    9daa:	31 f6                	xor    %esi,%esi
    9dac:	e8 5f 94 ff ff       	call   3210 <memset@plt>
    9db1:	48 8d 35 d5 66 00 00 	lea    0x66d5(%rip),%rsi        # 1048d <exec_in_fp0+0xd8d>
    9db8:	48 89 ef             	mov    %rbp,%rdi
    9dbb:	e8 40 fb ff ff       	call   9900 <tp_eat>
    9dc0:	85 c0                	test   %eax,%eax
    9dc2:	0f 84 3b 01 00 00    	je     9f03 <tp_record_body+0x1a3>
    9dc8:	48 8d 35 16 5a 00 00 	lea    0x5a16(%rip),%rsi        # f7e5 <exec_in_fp0+0xe5>
    9dcf:	48 89 ef             	mov    %rbp,%rdi
    9dd2:	e8 29 fb ff ff       	call   9900 <tp_eat>
    9dd7:	85 c0                	test   %eax,%eax
    9dd9:	74 3e                	je     9e19 <tp_record_body+0xb9>
    9ddb:	41 8b 7d 10          	mov    0x10(%r13),%edi
    9ddf:	85 ff                	test   %edi,%edi
    9de1:	7e 20                	jle    9e03 <tp_record_body+0xa3>
    9de3:	45 31 f6             	xor    %r14d,%r14d
    9de6:	31 c0                	xor    %eax,%eax
    9de8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    9def:	00 
    9df0:	41 80 3c 04 00       	cmpb   $0x0,(%r12,%rax,1)
    9df5:	0f 84 08 01 00 00    	je     9f03 <tp_record_body+0x1a3>
    9dfb:	48 ff c0             	inc    %rax
    9dfe:	48 39 c7             	cmp    %rax,%rdi
    9e01:	75 ed                	jne    9df0 <tp_record_body+0x90>
    9e03:	4c 89 fe             	mov    %r15,%rsi
    9e06:	e8 55 a5 ff ff       	call   4360 <fwp_record>
    9e0b:	48 89 03             	mov    %rax,(%rbx)
    9e0e:	41 be 01 00 00 00    	mov    $0x1,%r14d
    9e14:	e9 ea 00 00 00       	jmp    9f03 <tp_record_body+0x1a3>
    9e19:	48 89 1c 24          	mov    %rbx,(%rsp)
    9e1d:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    9e22:	48 89 ef             	mov    %rbp,%rdi
    9e25:	e8 06 01 00 00       	call   9f30 <tp_ident>
    9e2a:	41 8b 45 10          	mov    0x10(%r13),%eax
    9e2e:	85 c0                	test   %eax,%eax
    9e30:	0f 8e ca 00 00 00    	jle    9f00 <tp_record_body+0x1a0>
    9e36:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    9e3b:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    9e40:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
    9e45:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    9e4a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9e50:	4d 8b 65 18          	mov    0x18(%r13),%r12
    9e54:	41 89 c7             	mov    %eax,%r15d
    9e57:	41 be ff ff ff ff    	mov    $0xffffffff,%r14d
    9e5d:	31 ed                	xor    %ebp,%ebp
    9e5f:	90                   	nop
    9e60:	49 8b 3c ec          	mov    (%r12,%rbp,8),%rdi
    9e64:	48 89 de             	mov    %rbx,%rsi
    9e67:	e8 64 94 ff ff       	call   32d0 <strcmp@plt>
    9e6c:	85 c0                	test   %eax,%eax
    9e6e:	44 0f 44 f5          	cmove  %ebp,%r14d
    9e72:	48 ff c5             	inc    %rbp
    9e75:	49 39 ef             	cmp    %rbp,%r15
    9e78:	75 e6                	jne    9e60 <tp_record_body+0x100>
    9e7a:	45 85 f6             	test   %r14d,%r14d
    9e7d:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    9e82:	4c 8b 64 24 10       	mov    0x10(%rsp),%r12
    9e87:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    9e8c:	78 72                	js     9f00 <tp_record_body+0x1a0>
    9e8e:	48 89 ef             	mov    %rbp,%rdi
    9e91:	48 8d 35 4b 65 00 00 	lea    0x654b(%rip),%rsi        # 103e3 <exec_in_fp0+0xce3>
    9e98:	e8 63 fa ff ff       	call   9900 <tp_eat>
    9e9d:	85 c0                	test   %eax,%eax
    9e9f:	74 5f                	je     9f00 <tp_record_body+0x1a0>
    9ea1:	49 8b 45 20          	mov    0x20(%r13),%rax
    9ea5:	45 89 f6             	mov    %r14d,%r14d
    9ea8:	4a 8b 34 f0          	mov    (%rax,%r14,8),%rsi
    9eac:	4b 8d 0c f7          	lea    (%r15,%r14,8),%rcx
    9eb0:	48 89 ef             	mov    %rbp,%rdi
    9eb3:	31 d2                	xor    %edx,%edx
    9eb5:	e8 56 ed ff ff       	call   8c10 <tp_value>
    9eba:	85 c0                	test   %eax,%eax
    9ebc:	74 42                	je     9f00 <tp_record_body+0x1a0>
    9ebe:	43 c6 04 34 01       	movb   $0x1,(%r12,%r14,1)
    9ec3:	48 89 ef             	mov    %rbp,%rdi
    9ec6:	48 8d 35 18 59 00 00 	lea    0x5918(%rip),%rsi        # f7e5 <exec_in_fp0+0xe5>
    9ecd:	e8 2e fa ff ff       	call   9900 <tp_eat>
    9ed2:	85 c0                	test   %eax,%eax
    9ed4:	75 42                	jne    9f18 <tp_record_body+0x1b8>
    9ed6:	48 89 ef             	mov    %rbp,%rdi
    9ed9:	48 8d 35 02 59 00 00 	lea    0x5902(%rip),%rsi        # f7e2 <exec_in_fp0+0xe2>
    9ee0:	e8 1b fa ff ff       	call   9900 <tp_eat>
    9ee5:	85 c0                	test   %eax,%eax
    9ee7:	74 17                	je     9f00 <tp_record_body+0x1a0>
    9ee9:	48 89 ef             	mov    %rbp,%rdi
    9eec:	48 89 de             	mov    %rbx,%rsi
    9eef:	e8 3c 00 00 00       	call   9f30 <tp_ident>
    9ef4:	41 8b 45 10          	mov    0x10(%r13),%eax
    9ef8:	85 c0                	test   %eax,%eax
    9efa:	0f 8f 50 ff ff ff    	jg     9e50 <tp_record_body+0xf0>
    9f00:	45 31 f6             	xor    %r14d,%r14d
    9f03:	44 89 f0             	mov    %r14d,%eax
    9f06:	48 81 c4 28 01 00 00 	add    $0x128,%rsp
    9f0d:	5b                   	pop    %rbx
    9f0e:	41 5c                	pop    %r12
    9f10:	41 5d                	pop    %r13
    9f12:	41 5e                	pop    %r14
    9f14:	41 5f                	pop    %r15
    9f16:	5d                   	pop    %rbp
    9f17:	c3                   	ret
    9f18:	48 8b 1c 24          	mov    (%rsp),%rbx
    9f1c:	e9 ba fe ff ff       	jmp    9ddb <tp_record_body+0x7b>
    9f21:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9f28:	0f 1f 84 00 00 00 00 
    9f2f:	00 

0000000000009f30 <tp_ident>:
    9f30:	41 56                	push   %r14
    9f32:	53                   	push   %rbx
    9f33:	50                   	push   %rax
    9f34:	48 89 f3             	mov    %rsi,%rbx
    9f37:	49 89 fe             	mov    %rdi,%r14
    9f3a:	e8 01 f6 ff ff       	call   9540 <tp_ws>
    9f3f:	49 8b 46 10          	mov    0x10(%r14),%rax
    9f43:	49 8b 36             	mov    (%r14),%rsi
    9f46:	49 8b 56 08          	mov    0x8(%r14),%rdx
    9f4a:	48 89 c1             	mov    %rax,%rcx
    9f4d:	48 39 d0             	cmp    %rdx,%rax
    9f50:	73 63                	jae    9fb5 <tp_ident+0x85>
    9f52:	48 bf 03 00 00 00 00 	movabs $0x4000000000003,%rdi
    9f59:	00 04 00 
    9f5c:	48 89 c1             	mov    %rax,%rcx
    9f5f:	eb 1b                	jmp    9f7c <tp_ident+0x4c>
    9f61:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9f68:	0f 1f 84 00 00 00 00 
    9f6f:	00 
    9f70:	48 ff c1             	inc    %rcx
    9f73:	49 89 4e 10          	mov    %rcx,0x10(%r14)
    9f77:	48 39 ca             	cmp    %rcx,%rdx
    9f7a:	74 36                	je     9fb2 <tp_ident+0x82>
    9f7c:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
    9f81:	45 8d 48 d0          	lea    -0x30(%r8),%r9d
    9f85:	41 80 f9 0a          	cmp    $0xa,%r9b
    9f89:	72 e5                	jb     9f70 <tp_ident+0x40>
    9f8b:	45 89 c1             	mov    %r8d,%r9d
    9f8e:	41 80 e1 df          	and    $0xdf,%r9b
    9f92:	41 80 c1 bf          	add    $0xbf,%r9b
    9f96:	41 80 f9 1a          	cmp    $0x1a,%r9b
    9f9a:	72 d4                	jb     9f70 <tp_ident+0x40>
    9f9c:	45 0f b6 c0          	movzbl %r8b,%r8d
    9fa0:	41 83 c0 d3          	add    $0xffffffd3,%r8d
    9fa4:	41 83 f8 32          	cmp    $0x32,%r8d
    9fa8:	77 0b                	ja     9fb5 <tp_ident+0x85>
    9faa:	4c 0f a3 c7          	bt     %r8,%rdi
    9fae:	72 c0                	jb     9f70 <tp_ident+0x40>
    9fb0:	eb 03                	jmp    9fb5 <tp_ident+0x85>
    9fb2:	48 89 d1             	mov    %rdx,%rcx
    9fb5:	48 29 c1             	sub    %rax,%rcx
    9fb8:	48 81 f9 ff 00 00 00 	cmp    $0xff,%rcx
    9fbf:	41 be ff 00 00 00    	mov    $0xff,%r14d
    9fc5:	4c 0f 42 f1          	cmovb  %rcx,%r14
    9fc9:	48 01 c6             	add    %rax,%rsi
    9fcc:	48 89 df             	mov    %rbx,%rdi
    9fcf:	4c 89 f2             	mov    %r14,%rdx
    9fd2:	e8 59 93 ff ff       	call   3330 <memcpy@plt>
    9fd7:	42 c6 04 33 00       	movb   $0x0,(%rbx,%r14,1)
    9fdc:	48 83 c4 08          	add    $0x8,%rsp
    9fe0:	5b                   	pop    %rbx
    9fe1:	41 5e                	pop    %r14
    9fe3:	c3                   	ret
    9fe4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    9feb:	00 00 00 00 00 

0000000000009ff0 <tp_atom>:
    9ff0:	41 57                	push   %r15
    9ff2:	41 56                	push   %r14
    9ff4:	53                   	push   %rbx
    9ff5:	49 89 d6             	mov    %rdx,%r14
    9ff8:	49 89 f7             	mov    %rsi,%r15
    9ffb:	48 89 fb             	mov    %rdi,%rbx
    9ffe:	e8 3d f5 ff ff       	call   9540 <tp_ws>
    a003:	41 83 3f 10          	cmpl   $0x10,(%r15)
    a007:	75 07                	jne    a010 <tp_atom+0x20>
    a009:	49 83 7f 08 00       	cmpq   $0x0,0x8(%r15)
    a00e:	74 5e                	je     a06e <tp_atom+0x7e>
    a010:	31 c0                	xor    %eax,%eax
    a012:	48 8b 4b 10          	mov    0x10(%rbx),%rcx
    a016:	48 3b 4b 08          	cmp    0x8(%rbx),%rcx
    a01a:	73 0e                	jae    a02a <tp_atom+0x3a>
    a01c:	48 8b 13             	mov    (%rbx),%rdx
    a01f:	80 3c 0a 28          	cmpb   $0x28,(%rdx,%rcx,1)
    a023:	0f 95 c2             	setne  %dl
    a026:	08 c2                	or     %al,%dl
    a028:	74 15                	je     a03f <tp_atom+0x4f>
    a02a:	48 89 df             	mov    %rbx,%rdi
    a02d:	4c 89 fe             	mov    %r15,%rsi
    a030:	31 d2                	xor    %edx,%edx
    a032:	4c 89 f1             	mov    %r14,%rcx
    a035:	5b                   	pop    %rbx
    a036:	41 5e                	pop    %r14
    a038:	41 5f                	pop    %r15
    a03a:	e9 d1 eb ff ff       	jmp    8c10 <tp_value>
    a03f:	48 ff c1             	inc    %rcx
    a042:	48 89 4b 10          	mov    %rcx,0x10(%rbx)
    a046:	48 89 df             	mov    %rbx,%rdi
    a049:	4c 89 fe             	mov    %r15,%rsi
    a04c:	31 d2                	xor    %edx,%edx
    a04e:	4c 89 f1             	mov    %r14,%rcx
    a051:	e8 ba eb ff ff       	call   8c10 <tp_value>
    a056:	85 c0                	test   %eax,%eax
    a058:	74 25                	je     a07f <tp_atom+0x8f>
    a05a:	48 8d 35 2f 64 00 00 	lea    0x642f(%rip),%rsi        # 10490 <exec_in_fp0+0xd90>
    a061:	48 89 df             	mov    %rbx,%rdi
    a064:	5b                   	pop    %rbx
    a065:	41 5e                	pop    %r14
    a067:	41 5f                	pop    %r15
    a069:	e9 92 f8 ff ff       	jmp    9900 <tp_eat>
    a06e:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    a073:	74 12                	je     a087 <tp_atom+0x97>
    a075:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
    a07a:	0f 95 c0             	setne  %al
    a07d:	eb 93                	jmp    a012 <tp_atom+0x22>
    a07f:	31 c0                	xor    %eax,%eax
    a081:	5b                   	pop    %rbx
    a082:	41 5e                	pop    %r14
    a084:	41 5f                	pop    %r15
    a086:	c3                   	ret
    a087:	b0 01                	mov    $0x1,%al
    a089:	eb 87                	jmp    a012 <tp_atom+0x22>
    a08b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000a090 <fwp_cstr>:
    a090:	53                   	push   %rbx
    a091:	48 89 fb             	mov    %rdi,%rbx
    a094:	e8 d7 90 ff ff       	call   3170 <strlen@plt>
    a099:	48 89 df             	mov    %rbx,%rdi
    a09c:	48 89 c6             	mov    %rax,%rsi
    a09f:	5b                   	pop    %rbx
    a0a0:	e9 ab e4 ff ff       	jmp    8550 <fwp_str_new>
    a0a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a0ac:	00 00 00 00 

000000000000a0b0 <fwp_p_parse_int>:
    a0b0:	55                   	push   %rbp
    a0b1:	41 57                	push   %r15
    a0b3:	41 56                	push   %r14
    a0b5:	41 55                	push   %r13
    a0b7:	41 54                	push   %r12
    a0b9:	53                   	push   %rbx
    a0ba:	48 83 ec 18          	sub    $0x18,%rsp
    a0be:	89 d3                	mov    %edx,%ebx
    a0c0:	89 f5                	mov    %esi,%ebp
    a0c2:	49 89 fe             	mov    %rdi,%r14
    a0c5:	4c 8b 3f             	mov    (%rdi),%r15
    a0c8:	49 83 c6 08          	add    $0x8,%r14
    a0cc:	4c 89 f7             	mov    %r14,%rdi
    a0cf:	4c 89 fe             	mov    %r15,%rsi
    a0d2:	e8 49 fc ff ff       	call   9d20 <fwp_valid_int>
    a0d7:	85 c0                	test   %eax,%eax
    a0d9:	0f 84 1a 01 00 00    	je     a1f9 <fwp_p_parse_int+0x149>
    a0df:	41 0f b6 06          	movzbl (%r14),%eax
    a0e3:	31 ff                	xor    %edi,%edi
    a0e5:	3c 2d                	cmp    $0x2d,%al
    a0e7:	0f 94 c1             	sete   %cl
    a0ea:	3c 2b                	cmp    $0x2b,%al
    a0ec:	0f 94 c0             	sete   %al
    a0ef:	08 c8                	or     %cl,%al
    a0f1:	44 0f b6 e0          	movzbl %al,%r12d
    a0f5:	4d 39 e7             	cmp    %r12,%r15
    a0f8:	0f 86 d0 00 00 00    	jbe    a1ce <fwp_p_parse_int+0x11e>
    a0fe:	88 4c 24 07          	mov    %cl,0x7(%rsp)
    a102:	89 6c 24 08          	mov    %ebp,0x8(%rsp)
    a106:	89 5c 24 0c          	mov    %ebx,0xc(%rsp)
    a10a:	bf 0a 00 00 00       	mov    $0xa,%edi
    a10f:	48 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rbx
    a116:	cc cc cc 
    a119:	48 bd cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbp
    a120:	cc cc cc 
    a123:	31 f6                	xor    %esi,%esi
    a125:	45 31 db             	xor    %r11d,%r11d
    a128:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a12f:	00 
    a130:	4d 89 dd             	mov    %r11,%r13
    a133:	49 89 f0             	mov    %rsi,%r8
    a136:	48 89 f0             	mov    %rsi,%rax
    a139:	48 f7 e7             	mul    %rdi
    a13c:	4b 8d 0c 9b          	lea    (%r11,%r11,4),%rcx
    a140:	48 8d 0c 4a          	lea    (%rdx,%rcx,2),%rcx
    a144:	43 0f be 14 26       	movsbl (%r14,%r12,1),%edx
    a149:	83 c2 d0             	add    $0xffffffd0,%edx
    a14c:	48 63 d2             	movslq %edx,%rdx
    a14f:	49 89 d3             	mov    %rdx,%r11
    a152:	49 c1 fb 3f          	sar    $0x3f,%r11
    a156:	48 89 c6             	mov    %rax,%rsi
    a159:	48 01 d6             	add    %rdx,%rsi
    a15c:	49 11 cb             	adc    %rcx,%r11
    a15f:	4d 89 d9             	mov    %r11,%r9
    a162:	49 0f a4 f1 3f       	shld   $0x3f,%rsi,%r9
    a167:	4c 89 d9             	mov    %r11,%rcx
    a16a:	48 d1 e9             	shr    $1,%rcx
    a16d:	4d 89 ca             	mov    %r9,%r10
    a170:	49 01 ca             	add    %rcx,%r10
    a173:	49 83 d2 00          	adc    $0x0,%r10
    a177:	4c 89 d0             	mov    %r10,%rax
    a17a:	48 f7 e3             	mul    %rbx
    a17d:	48 c1 ea 02          	shr    $0x2,%rdx
    a181:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    a185:	49 29 c2             	sub    %rax,%r10
    a188:	4d 29 d1             	sub    %r10,%r9
    a18b:	48 83 d9 00          	sbb    $0x0,%rcx
    a18f:	4d 89 ca             	mov    %r9,%r10
    a192:	4c 0f af d5          	imul   %rbp,%r10
    a196:	4c 89 c8             	mov    %r9,%rax
    a199:	48 f7 e3             	mul    %rbx
    a19c:	4c 01 d2             	add    %r10,%rdx
    a19f:	48 0f af cb          	imul   %rbx,%rcx
    a1a3:	48 01 d1             	add    %rdx,%rcx
    a1a6:	4c 31 e9             	xor    %r13,%rcx
    a1a9:	4c 31 c0             	xor    %r8,%rax
    a1ac:	48 09 c8             	or     %rcx,%rax
    a1af:	75 48                	jne    a1f9 <fwp_p_parse_int+0x149>
    a1b1:	49 ff c4             	inc    %r12
    a1b4:	4d 39 e7             	cmp    %r12,%r15
    a1b7:	0f 85 73 ff ff ff    	jne    a130 <fwp_p_parse_int+0x80>
    a1bd:	8b 5c 24 0c          	mov    0xc(%rsp),%ebx
    a1c1:	8b 6c 24 08          	mov    0x8(%rsp),%ebp
    a1c5:	31 ff                	xor    %edi,%edi
    a1c7:	0f b6 4c 24 07       	movzbl 0x7(%rsp),%ecx
    a1cc:	eb 05                	jmp    a1d3 <fwp_p_parse_int+0x123>
    a1ce:	31 f6                	xor    %esi,%esi
    a1d0:	45 31 db             	xor    %r11d,%r11d
    a1d3:	40 88 cf             	mov    %cl,%dil
    a1d6:	4c 8d 4c 24 10       	lea    0x10(%rsp),%r9
    a1db:	4c 89 da             	mov    %r11,%rdx
    a1de:	89 e9                	mov    %ebp,%ecx
    a1e0:	41 89 d8             	mov    %ebx,%r8d
    a1e3:	e8 28 00 00 00       	call   a210 <fwp_int_in_range>
    a1e8:	48 85 c0             	test   %rax,%rax
    a1eb:	74 0c                	je     a1f9 <fwp_p_parse_int+0x149>
    a1ed:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    a1f2:	e8 99 00 00 00       	call   a290 <fwp_some>
    a1f7:	eb 02                	jmp    a1fb <fwp_p_parse_int+0x14b>
    a1f9:	31 c0                	xor    %eax,%eax
    a1fb:	48 83 c4 18          	add    $0x18,%rsp
    a1ff:	5b                   	pop    %rbx
    a200:	41 5c                	pop    %r12
    a202:	41 5d                	pop    %r13
    a204:	41 5e                	pop    %r14
    a206:	41 5f                	pop    %r15
    a208:	5d                   	pop    %rbp
    a209:	c3                   	ret
    a20a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000a210 <fwp_int_in_range>:
    a210:	53                   	push   %rbx
    a211:	83 f9 09             	cmp    $0x9,%ecx
    a214:	75 24                	jne    a23a <fwp_int_in_range+0x2a>
    a216:	85 ff                	test   %edi,%edi
    a218:	74 08                	je     a222 <fwp_int_in_range+0x12>
    a21a:	48 89 f0             	mov    %rsi,%rax
    a21d:	48 09 d0             	or     %rdx,%rax
    a220:	75 3c                	jne    a25e <fwp_int_in_range+0x4e>
    a222:	48 89 f7             	mov    %rsi,%rdi
    a225:	48 89 d6             	mov    %rdx,%rsi
    a228:	4c 89 cb             	mov    %r9,%rbx
    a22b:	e8 80 00 00 00       	call   a2b0 <fwp_box_u128>
    a230:	48 89 03             	mov    %rax,(%rbx)
    a233:	b8 01 00 00 00       	mov    $0x1,%eax
    a238:	5b                   	pop    %rbx
    a239:	c3                   	ret
    a23a:	48 89 f0             	mov    %rsi,%rax
    a23d:	48 f7 d8             	neg    %rax
    a240:	48 b8 00 00 00 00 00 	movabs $0x8000000000000000,%rax
    a247:	00 00 80 
    a24a:	49 89 c2             	mov    %rax,%r10
    a24d:	49 19 d2             	sbb    %rdx,%r10
    a250:	72 0c                	jb     a25e <fwp_int_in_range+0x4e>
    a252:	85 ff                	test   %edi,%edi
    a254:	75 0c                	jne    a262 <fwp_int_in_range+0x52>
    a256:	48 31 d0             	xor    %rdx,%rax
    a259:	48 09 f0             	or     %rsi,%rax
    a25c:	75 04                	jne    a262 <fwp_int_in_range+0x52>
    a25e:	31 c0                	xor    %eax,%eax
    a260:	5b                   	pop    %rbx
    a261:	c3                   	ret
    a262:	31 c0                	xor    %eax,%eax
    a264:	49 89 f2             	mov    %rsi,%r10
    a267:	49 f7 da             	neg    %r10
    a26a:	48 19 d0             	sbb    %rdx,%rax
    a26d:	85 ff                	test   %edi,%edi
    a26f:	4c 0f 44 d6          	cmove  %rsi,%r10
    a273:	48 0f 44 c2          	cmove  %rdx,%rax
    a277:	4c 89 d7             	mov    %r10,%rdi
    a27a:	48 89 c6             	mov    %rax,%rsi
    a27d:	89 ca                	mov    %ecx,%edx
    a27f:	44 89 c1             	mov    %r8d,%ecx
    a282:	4d 89 c8             	mov    %r9,%r8
    a285:	e8 56 00 00 00       	call   a2e0 <fwp_int_fits>
    a28a:	89 c0                	mov    %eax,%eax
    a28c:	5b                   	pop    %rbx
    a28d:	c3                   	ret
    a28e:	66 90                	xchg   %ax,%ax

000000000000a290 <fwp_some>:
    a290:	50                   	push   %rax
    a291:	48 89 3c 24          	mov    %rdi,(%rsp)
    a295:	48 89 e2             	mov    %rsp,%rdx
    a298:	bf 01 00 00 00       	mov    $0x1,%edi
    a29d:	be 01 00 00 00       	mov    $0x1,%esi
    a2a2:	e8 d9 a0 ff ff       	call   4380 <fwp_data>
    a2a7:	59                   	pop    %rcx
    a2a8:	c3                   	ret
    a2a9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000a2b0 <fwp_box_u128>:
    a2b0:	41 56                	push   %r14
    a2b2:	53                   	push   %rbx
    a2b3:	50                   	push   %rax
    a2b4:	48 89 f3             	mov    %rsi,%rbx
    a2b7:	49 89 fe             	mov    %rdi,%r14
    a2ba:	bf 10 00 00 00       	mov    $0x10,%edi
    a2bf:	e8 ec ce ff ff       	call   71b0 <fwp_alloc_leaf>
    a2c4:	48 89 58 08          	mov    %rbx,0x8(%rax)
    a2c8:	4c 89 30             	mov    %r14,(%rax)
    a2cb:	48 83 c4 08          	add    $0x8,%rsp
    a2cf:	5b                   	pop    %rbx
    a2d0:	41 5e                	pop    %r14
    a2d2:	c3                   	ret
    a2d3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a2da:	84 00 00 00 00 00 

000000000000a2e0 <fwp_int_fits>:
    a2e0:	41 57                	push   %r15
    a2e2:	41 56                	push   %r14
    a2e4:	53                   	push   %rbx
    a2e5:	31 c0                	xor    %eax,%eax
    a2e7:	83 fa 14             	cmp    $0x14,%edx
    a2ea:	0f 87 02 01 00 00    	ja     a3f2 <fwp_int_fits+0x112>
    a2f0:	89 d2                	mov    %edx,%edx
    a2f2:	4c 8d 0d 9f 4f 00 00 	lea    0x4f9f(%rip),%r9        # f298 <_IO_stdin_used+0x298>
    a2f9:	49 63 14 91          	movslq (%r9,%rdx,4),%rdx
    a2fd:	4c 01 ca             	add    %r9,%rdx
    a300:	ff e2                	jmp    *%rdx
    a302:	48 89 f9             	mov    %rdi,%rcx
    a305:	48 83 c1 80          	add    $0xffffffffffffff80,%rcx
    a309:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    a30d:	48 81 f9 00 ff ff ff 	cmp    $0xffffffffffffff00,%rcx
    a314:	eb 3b                	jmp    a351 <fwp_int_fits+0x71>
    a316:	48 89 f9             	mov    %rdi,%rcx
    a319:	48 81 c1 00 00 00 80 	add    $0xffffffff80000000,%rcx
    a320:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    a324:	48 ba 00 00 00 00 ff 	movabs $0xffffffff00000000,%rdx
    a32b:	ff ff ff 
    a32e:	48 39 d1             	cmp    %rdx,%rcx
    a331:	eb 1e                	jmp    a351 <fwp_int_fits+0x71>
    a333:	31 c0                	xor    %eax,%eax
    a335:	b9 ff 00 00 00       	mov    $0xff,%ecx
    a33a:	eb 2b                	jmp    a367 <fwp_int_fits+0x87>
    a33c:	48 89 f9             	mov    %rdi,%rcx
    a33f:	48 81 c1 00 80 ff ff 	add    $0xffffffffffff8000,%rcx
    a346:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    a34a:	48 81 f9 00 00 ff ff 	cmp    $0xffffffffffff0000,%rcx
    a351:	48 83 de ff          	sbb    $0xffffffffffffffff,%rsi
    a355:	0f 83 8f 00 00 00    	jae    a3ea <fwp_int_fits+0x10a>
    a35b:	e9 92 00 00 00       	jmp    a3f2 <fwp_int_fits+0x112>
    a360:	31 c0                	xor    %eax,%eax
    a362:	b9 ff ff 00 00       	mov    $0xffff,%ecx
    a367:	48 39 f9             	cmp    %rdi,%rcx
    a36a:	b9 00 00 00 00       	mov    $0x0,%ecx
    a36f:	48 19 f1             	sbb    %rsi,%rcx
    a372:	73 76                	jae    a3ea <fwp_int_fits+0x10a>
    a374:	eb 7c                	jmp    a3f2 <fwp_int_fits+0x112>
    a376:	48 89 f9             	mov    %rdi,%rcx
    a379:	48 c1 e9 20          	shr    $0x20,%rcx
    a37d:	48 09 f1             	or     %rsi,%rcx
    a380:	74 68                	je     a3ea <fwp_int_fits+0x10a>
    a382:	eb 6e                	jmp    a3f2 <fwp_int_fits+0x112>
    a384:	48 b9 00 00 00 00 00 	movabs $0x8000000000000000,%rcx
    a38b:	00 00 80 
    a38e:	48 01 f9             	add    %rdi,%rcx
    a391:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    a395:	48 83 fe ff          	cmp    $0xffffffffffffffff,%rsi
    a399:	74 4f                	je     a3ea <fwp_int_fits+0x10a>
    a39b:	eb 55                	jmp    a3f2 <fwp_int_fits+0x112>
    a39d:	4c 89 c3             	mov    %r8,%rbx
    a3a0:	e8 5b 00 00 00       	call   a400 <fwp_box_i128>
    a3a5:	49 89 d8             	mov    %rbx,%r8
    a3a8:	48 89 c7             	mov    %rax,%rdi
    a3ab:	eb 3d                	jmp    a3ea <fwp_int_fits+0x10a>
    a3ad:	4c 89 c3             	mov    %r8,%rbx
    a3b0:	49 89 fe             	mov    %rdi,%r14
    a3b3:	89 cf                	mov    %ecx,%edi
    a3b5:	49 89 f7             	mov    %rsi,%r15
    a3b8:	e8 73 00 00 00       	call   a430 <fwp_tint_max>
    a3bd:	48 89 c1             	mov    %rax,%rcx
    a3c0:	31 c0                	xor    %eax,%eax
    a3c2:	49 89 c8             	mov    %rcx,%r8
    a3c5:	49 f7 d8             	neg    %r8
    a3c8:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    a3ce:	49 19 d1             	sbb    %rdx,%r9
    a3d1:	4c 39 f1             	cmp    %r14,%rcx
    a3d4:	4c 19 fa             	sbb    %r15,%rdx
    a3d7:	7c 19                	jl     a3f2 <fwp_int_fits+0x112>
    a3d9:	4c 89 fe             	mov    %r15,%rsi
    a3dc:	4c 89 f7             	mov    %r14,%rdi
    a3df:	4d 39 c6             	cmp    %r8,%r14
    a3e2:	4c 19 ce             	sbb    %r9,%rsi
    a3e5:	49 89 d8             	mov    %rbx,%r8
    a3e8:	7c 08                	jl     a3f2 <fwp_int_fits+0x112>
    a3ea:	49 89 38             	mov    %rdi,(%r8)
    a3ed:	b8 01 00 00 00       	mov    $0x1,%eax
    a3f2:	5b                   	pop    %rbx
    a3f3:	41 5e                	pop    %r14
    a3f5:	41 5f                	pop    %r15
    a3f7:	c3                   	ret
    a3f8:	48 85 f6             	test   %rsi,%rsi
    a3fb:	74 ed                	je     a3ea <fwp_int_fits+0x10a>
    a3fd:	eb f3                	jmp    a3f2 <fwp_int_fits+0x112>
    a3ff:	90                   	nop

000000000000a400 <fwp_box_i128>:
    a400:	41 56                	push   %r14
    a402:	53                   	push   %rbx
    a403:	50                   	push   %rax
    a404:	48 89 f3             	mov    %rsi,%rbx
    a407:	49 89 fe             	mov    %rdi,%r14
    a40a:	bf 10 00 00 00       	mov    $0x10,%edi
    a40f:	e8 9c cd ff ff       	call   71b0 <fwp_alloc_leaf>
    a414:	48 89 58 08          	mov    %rbx,0x8(%rax)
    a418:	4c 89 30             	mov    %r14,(%rax)
    a41b:	48 83 c4 08          	add    $0x8,%rsp
    a41f:	5b                   	pop    %rbx
    a420:	41 5e                	pop    %r14
    a422:	c3                   	ret
    a423:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a42a:	84 00 00 00 00 00 

000000000000a430 <fwp_tint_max>:
    a430:	85 ff                	test   %edi,%edi
    a432:	7e 27                	jle    a45b <fwp_tint_max+0x2b>
    a434:	8d 47 ff             	lea    -0x1(%rdi),%eax
    a437:	83 f8 4f             	cmp    $0x4f,%eax
    a43a:	41 b8 4f 00 00 00    	mov    $0x4f,%r8d
    a440:	44 0f 42 c0          	cmovb  %eax,%r8d
    a444:	41 ff c0             	inc    %r8d
    a447:	44 89 c6             	mov    %r8d,%esi
    a44a:	83 e6 07             	and    $0x7,%esi
    a44d:	83 ff 08             	cmp    $0x8,%edi
    a450:	73 11                	jae    a463 <fwp_tint_max+0x33>
    a452:	b8 01 00 00 00       	mov    $0x1,%eax
    a457:	31 c9                	xor    %ecx,%ecx
    a459:	eb 38                	jmp    a493 <fwp_tint_max+0x63>
    a45b:	31 c0                	xor    %eax,%eax
    a45d:	31 c9                	xor    %ecx,%ecx
    a45f:	48 89 ca             	mov    %rcx,%rdx
    a462:	c3                   	ret
    a463:	41 81 e0 f8 00 00 00 	and    $0xf8,%r8d
    a46a:	b8 01 00 00 00       	mov    $0x1,%eax
    a46f:	31 c9                	xor    %ecx,%ecx
    a471:	bf a1 19 00 00       	mov    $0x19a1,%edi
    a476:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    a47d:	00 00 00 
    a480:	48 f7 e7             	mul    %rdi
    a483:	48 69 c9 a1 19 00 00 	imul   $0x19a1,%rcx,%rcx
    a48a:	48 01 d1             	add    %rdx,%rcx
    a48d:	41 83 c0 f8          	add    $0xfffffff8,%r8d
    a491:	75 ed                	jne    a480 <fwp_tint_max+0x50>
    a493:	85 f6                	test   %esi,%esi
    a495:	74 17                	je     a4ae <fwp_tint_max+0x7e>
    a497:	bf 03 00 00 00       	mov    $0x3,%edi
    a49c:	0f 1f 40 00          	nopl   0x0(%rax)
    a4a0:	48 f7 e7             	mul    %rdi
    a4a3:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    a4a7:	48 01 d1             	add    %rdx,%rcx
    a4aa:	ff ce                	dec    %esi
    a4ac:	75 f2                	jne    a4a0 <fwp_tint_max+0x70>
    a4ae:	48 83 c0 ff          	add    $0xffffffffffffffff,%rax
    a4b2:	48 83 d1 ff          	adc    $0xffffffffffffffff,%rcx
    a4b6:	48 89 ca             	mov    %rcx,%rdx
    a4b9:	48 c1 ea 3f          	shr    $0x3f,%rdx
    a4bd:	48 01 c2             	add    %rax,%rdx
    a4c0:	48 89 d0             	mov    %rdx,%rax
    a4c3:	48 83 d1 00          	adc    $0x0,%rcx
    a4c7:	48 0f ac c8 01       	shrd   $0x1,%rcx,%rax
    a4cc:	48 d1 f9             	sar    $1,%rcx
    a4cf:	48 89 ca             	mov    %rcx,%rdx
    a4d2:	c3                   	ret
    a4d3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a4da:	84 00 00 00 00 00 

000000000000a4e0 <fwp_valid_float>:
    a4e0:	48 85 f6             	test   %rsi,%rsi
    a4e3:	74 0e                	je     a4f3 <fwp_valid_float+0x13>
    a4e5:	0f b6 07             	movzbl (%rdi),%eax
    a4e8:	04 d5                	add    $0xd5,%al
    a4ea:	31 d2                	xor    %edx,%edx
    a4ec:	a8 fd                	test   $0xfd,%al
    a4ee:	0f 94 c2             	sete   %dl
    a4f1:	eb 02                	jmp    a4f5 <fwp_valid_float+0x15>
    a4f3:	31 d2                	xor    %edx,%edx
    a4f5:	41 b1 01             	mov    $0x1,%r9b
    a4f8:	49 89 d0             	mov    %rdx,%r8
    a4fb:	48 39 f2             	cmp    %rsi,%rdx
    a4fe:	73 1d                	jae    a51d <fwp_valid_float+0x3d>
    a500:	42 0f b6 04 07       	movzbl (%rdi,%r8,1),%eax
    a505:	8d 48 d0             	lea    -0x30(%rax),%ecx
    a508:	80 f9 09             	cmp    $0x9,%cl
    a50b:	77 15                	ja     a522 <fwp_valid_float+0x42>
    a50d:	49 ff c0             	inc    %r8
    a510:	4c 39 c6             	cmp    %r8,%rsi
    a513:	75 eb                	jne    a500 <fwp_valid_float+0x20>
    a515:	49 89 f0             	mov    %rsi,%r8
    a518:	48 89 f1             	mov    %rsi,%rcx
    a51b:	eb 38                	jmp    a555 <fwp_valid_float+0x75>
    a51d:	48 89 d1             	mov    %rdx,%rcx
    a520:	eb 33                	jmp    a555 <fwp_valid_float+0x75>
    a522:	3c 2e                	cmp    $0x2e,%al
    a524:	75 2c                	jne    a552 <fwp_valid_float+0x72>
    a526:	49 8d 48 01          	lea    0x1(%r8),%rcx
    a52a:	48 39 f1             	cmp    %rsi,%rcx
    a52d:	73 16                	jae    a545 <fwp_valid_float+0x65>
    a52f:	90                   	nop
    a530:	0f b6 04 0f          	movzbl (%rdi,%rcx,1),%eax
    a534:	04 d0                	add    $0xd0,%al
    a536:	3c 09                	cmp    $0x9,%al
    a538:	77 0b                	ja     a545 <fwp_valid_float+0x65>
    a53a:	48 ff c1             	inc    %rcx
    a53d:	48 39 f1             	cmp    %rsi,%rcx
    a540:	72 ee                	jb     a530 <fwp_valid_float+0x50>
    a542:	48 89 f1             	mov    %rsi,%rcx
    a545:	48 8d 41 ff          	lea    -0x1(%rcx),%rax
    a549:	4c 39 c0             	cmp    %r8,%rax
    a54c:	41 0f 94 c1          	sete   %r9b
    a550:	eb 03                	jmp    a555 <fwp_valid_float+0x75>
    a552:	4c 89 c1             	mov    %r8,%rcx
    a555:	31 c0                	xor    %eax,%eax
    a557:	49 39 d0             	cmp    %rdx,%r8
    a55a:	75 06                	jne    a562 <fwp_valid_float+0x82>
    a55c:	45 84 c9             	test   %r9b,%r9b
    a55f:	74 01                	je     a562 <fwp_valid_float+0x82>
    a561:	c3                   	ret
    a562:	48 39 f1             	cmp    %rsi,%rcx
    a565:	73 58                	jae    a5bf <fwp_valid_float+0xdf>
    a567:	0f b6 14 0f          	movzbl (%rdi,%rcx,1),%edx
    a56b:	83 ca 20             	or     $0x20,%edx
    a56e:	83 fa 65             	cmp    $0x65,%edx
    a571:	75 4c                	jne    a5bf <fwp_valid_float+0xdf>
    a573:	48 8d 51 01          	lea    0x1(%rcx),%rdx
    a577:	48 39 f2             	cmp    %rsi,%rdx
    a57a:	73 18                	jae    a594 <fwp_valid_float+0xb4>
    a57c:	44 0f b6 04 17       	movzbl (%rdi,%rdx,1),%r8d
    a581:	41 83 f8 2d          	cmp    $0x2d,%r8d
    a585:	74 06                	je     a58d <fwp_valid_float+0xad>
    a587:	41 83 f8 2b          	cmp    $0x2b,%r8d
    a58b:	75 07                	jne    a594 <fwp_valid_float+0xb4>
    a58d:	48 83 c1 02          	add    $0x2,%rcx
    a591:	48 89 ca             	mov    %rcx,%rdx
    a594:	48 39 f2             	cmp    %rsi,%rdx
    a597:	73 c8                	jae    a561 <fwp_valid_float+0x81>
    a599:	48 89 d1             	mov    %rdx,%rcx
    a59c:	0f 1f 40 00          	nopl   0x0(%rax)
    a5a0:	44 0f b6 04 0f       	movzbl (%rdi,%rcx,1),%r8d
    a5a5:	41 80 c0 d0          	add    $0xd0,%r8b
    a5a9:	41 80 f8 09          	cmp    $0x9,%r8b
    a5ad:	77 0b                	ja     a5ba <fwp_valid_float+0xda>
    a5af:	48 ff c1             	inc    %rcx
    a5b2:	48 39 ce             	cmp    %rcx,%rsi
    a5b5:	75 e9                	jne    a5a0 <fwp_valid_float+0xc0>
    a5b7:	48 89 f1             	mov    %rsi,%rcx
    a5ba:	48 39 d1             	cmp    %rdx,%rcx
    a5bd:	74 a2                	je     a561 <fwp_valid_float+0x81>
    a5bf:	31 c0                	xor    %eax,%eax
    a5c1:	48 39 f1             	cmp    %rsi,%rcx
    a5c4:	0f 94 c0             	sete   %al
    a5c7:	c3                   	ret
    a5c8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a5cf:	00 

000000000000a5d0 <fwp_float_of>:
    a5d0:	83 ff 0a             	cmp    $0xa,%edi
    a5d3:	0f 85 97 9d ff ff    	jne    4370 <fwp_from_f64>
    a5d9:	f2 0f 5a c0          	cvtsd2ss %xmm0,%xmm0
    a5dd:	e9 de bc ff ff       	jmp    62c0 <fwp_from_f32>
    a5e2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a5e9:	1f 84 00 00 00 00 00 

000000000000a5f0 <fwp_utf8_put>:
    a5f0:	50                   	push   %rax
    a5f1:	83 fe 7f             	cmp    $0x7f,%esi
    a5f4:	77 0f                	ja     a605 <fwp_utf8_put+0x15>
    a5f6:	40 88 74 24 04       	mov    %sil,0x4(%rsp)
    a5fb:	ba 01 00 00 00       	mov    $0x1,%edx
    a600:	e9 8e 00 00 00       	jmp    a693 <fwp_utf8_put+0xa3>
    a605:	89 f0                	mov    %esi,%eax
    a607:	81 fe ff 07 00 00    	cmp    $0x7ff,%esi
    a60d:	77 1d                	ja     a62c <fwp_utf8_put+0x3c>
    a60f:	c1 e8 06             	shr    $0x6,%eax
    a612:	0c c0                	or     $0xc0,%al
    a614:	88 44 24 04          	mov    %al,0x4(%rsp)
    a618:	40 80 e6 3f          	and    $0x3f,%sil
    a61c:	40 80 ce 80          	or     $0x80,%sil
    a620:	40 88 74 24 05       	mov    %sil,0x5(%rsp)
    a625:	ba 02 00 00 00       	mov    $0x2,%edx
    a62a:	eb 67                	jmp    a693 <fwp_utf8_put+0xa3>
    a62c:	81 fe ff ff 00 00    	cmp    $0xffff,%esi
    a632:	77 2a                	ja     a65e <fwp_utf8_put+0x6e>
    a634:	c1 e8 0c             	shr    $0xc,%eax
    a637:	0c e0                	or     $0xe0,%al
    a639:	88 44 24 04          	mov    %al,0x4(%rsp)
    a63d:	89 f0                	mov    %esi,%eax
    a63f:	c1 e8 06             	shr    $0x6,%eax
    a642:	24 3f                	and    $0x3f,%al
    a644:	0c 80                	or     $0x80,%al
    a646:	88 44 24 05          	mov    %al,0x5(%rsp)
    a64a:	40 80 e6 3f          	and    $0x3f,%sil
    a64e:	40 80 ce 80          	or     $0x80,%sil
    a652:	40 88 74 24 06       	mov    %sil,0x6(%rsp)
    a657:	ba 03 00 00 00       	mov    $0x3,%edx
    a65c:	eb 35                	jmp    a693 <fwp_utf8_put+0xa3>
    a65e:	c1 e8 12             	shr    $0x12,%eax
    a661:	0c f0                	or     $0xf0,%al
    a663:	88 44 24 04          	mov    %al,0x4(%rsp)
    a667:	89 f0                	mov    %esi,%eax
    a669:	c1 e8 0c             	shr    $0xc,%eax
    a66c:	24 3f                	and    $0x3f,%al
    a66e:	0c 80                	or     $0x80,%al
    a670:	88 44 24 05          	mov    %al,0x5(%rsp)
    a674:	89 f0                	mov    %esi,%eax
    a676:	c1 e8 06             	shr    $0x6,%eax
    a679:	24 3f                	and    $0x3f,%al
    a67b:	0c 80                	or     $0x80,%al
    a67d:	88 44 24 06          	mov    %al,0x6(%rsp)
    a681:	40 80 e6 3f          	and    $0x3f,%sil
    a685:	40 80 ce 80          	or     $0x80,%sil
    a689:	40 88 74 24 07       	mov    %sil,0x7(%rsp)
    a68e:	ba 04 00 00 00       	mov    $0x4,%edx
    a693:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
    a698:	e8 43 df ff ff       	call   85e0 <buf_put>
    a69d:	58                   	pop    %rax
    a69e:	c3                   	ret
    a69f:	90                   	nop

000000000000a6a0 <tp_push>:
    a6a0:	41 56                	push   %r14
    a6a2:	53                   	push   %rbx
    a6a3:	50                   	push   %rax
    a6a4:	48 89 f3             	mov    %rsi,%rbx
    a6a7:	49 89 fe             	mov    %rdi,%r14
    a6aa:	48 8b 77 18          	mov    0x18(%rdi),%rsi
    a6ae:	48 3b 77 20          	cmp    0x20(%rdi),%rsi
    a6b2:	75 2f                	jne    a6e3 <tp_push+0x43>
    a6b4:	48 8d 04 36          	lea    (%rsi,%rsi,1),%rax
    a6b8:	48 85 f6             	test   %rsi,%rsi
    a6bb:	ba 08 00 00 00       	mov    $0x8,%edx
    a6c0:	48 0f 45 d0          	cmovne %rax,%rdx
    a6c4:	49 89 56 20          	mov    %rdx,0x20(%r14)
    a6c8:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    a6cc:	48 c1 e6 03          	shl    $0x3,%rsi
    a6d0:	48 c1 e2 03          	shl    $0x3,%rdx
    a6d4:	e8 27 da ff ff       	call   8100 <fwp_mem_realloc>
    a6d9:	49 89 46 10          	mov    %rax,0x10(%r14)
    a6dd:	49 8b 76 18          	mov    0x18(%r14),%rsi
    a6e1:	eb 04                	jmp    a6e7 <tp_push+0x47>
    a6e3:	49 8b 46 10          	mov    0x10(%r14),%rax
    a6e7:	48 8d 4e 01          	lea    0x1(%rsi),%rcx
    a6eb:	49 89 4e 18          	mov    %rcx,0x18(%r14)
    a6ef:	48 89 1c f0          	mov    %rbx,(%rax,%rsi,8)
    a6f3:	48 83 c4 08          	add    $0x8,%rsp
    a6f7:	5b                   	pop    %rbx
    a6f8:	41 5e                	pop    %r14
    a6fa:	c3                   	ret
    a6fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000a700 <tp_is_delim>:
    a700:	b8 01 00 00 00       	mov    $0x1,%eax
    a705:	83 ff 2c             	cmp    $0x2c,%edi
    a708:	77 13                	ja     a71d <tp_is_delim+0x1d>
    a70a:	89 f9                	mov    %edi,%ecx
    a70c:	48 ba 00 26 00 00 01 	movabs $0x130100002600,%rdx
    a713:	13 00 00 
    a716:	48 0f a3 ca          	bt     %rcx,%rdx
    a71a:	73 01                	jae    a71d <tp_is_delim+0x1d>
    a71c:	c3                   	ret
    a71d:	83 ff 5d             	cmp    $0x5d,%edi
    a720:	74 fa                	je     a71c <tp_is_delim+0x1c>
    a722:	83 ff 7d             	cmp    $0x7d,%edi
    a725:	74 f5                	je     a71c <tp_is_delim+0x1c>
    a727:	31 c0                	xor    %eax,%eax
    a729:	40 80 ff 3a          	cmp    $0x3a,%dil
    a72d:	0f 94 c0             	sete   %al
    a730:	c3                   	ret
    a731:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a738:	0f 1f 84 00 00 00 00 
    a73f:	00 

000000000000a740 <fwp_list_len>:
    a740:	31 c0                	xor    %eax,%eax
    a742:	48 85 ff             	test   %rdi,%rdi
    a745:	74 15                	je     a75c <fwp_list_len+0x1c>
    a747:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    a74e:	00 00 
    a750:	48 ff c0             	inc    %rax
    a753:	48 8b 7f 10          	mov    0x10(%rdi),%rdi
    a757:	48 85 ff             	test   %rdi,%rdi
    a75a:	75 f4                	jne    a750 <fwp_list_len+0x10>
    a75c:	c3                   	ret
    a75d:	0f 1f 00             	nopl   (%rax)

000000000000a760 <fwp_map_find>:
    a760:	55                   	push   %rbp
    a761:	41 57                	push   %r15
    a763:	41 56                	push   %r14
    a765:	41 55                	push   %r13
    a767:	41 54                	push   %r12
    a769:	53                   	push   %rbx
    a76a:	50                   	push   %rax
    a76b:	49 89 f6             	mov    %rsi,%r14
    a76e:	49 89 ff             	mov    %rdi,%r15
    a771:	48 8b 2f             	mov    (%rdi),%rbp
    a774:	8b 02                	mov    (%rdx),%eax
    a776:	83 f8 04             	cmp    $0x4,%eax
    a779:	72 53                	jb     a7ce <fwp_map_find+0x6e>
    a77b:	83 c0 fb             	add    $0xfffffffb,%eax
    a77e:	83 f8 04             	cmp    $0x4,%eax
    a781:	0f 83 a3 00 00 00    	jae    a82a <fwp_map_find+0xca>
    a787:	48 85 ed             	test   %rbp,%rbp
    a78a:	0f 84 f7 00 00 00    	je     a887 <fwp_map_find+0x127>
    a790:	31 f6                	xor    %esi,%esi
    a792:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    a799:	ff ff 1f 
    a79c:	eb 0a                	jmp    a7a8 <fwp_map_find+0x48>
    a79e:	66 90                	xchg   %ax,%ax
    a7a0:	4c 89 e5             	mov    %r12,%rbp
    a7a3:	48 39 ee             	cmp    %rbp,%rsi
    a7a6:	73 74                	jae    a81c <fwp_map_find+0xbc>
    a7a8:	48 8d 14 2e          	lea    (%rsi,%rbp,1),%rdx
    a7ac:	49 89 d4             	mov    %rdx,%r12
    a7af:	49 d1 ec             	shr    $1,%r12
    a7b2:	48 21 c2             	and    %rax,%rdx
    a7b5:	49 8b 54 d7 08       	mov    0x8(%r15,%rdx,8),%rdx
    a7ba:	4c 39 f2             	cmp    %r14,%rdx
    a7bd:	74 64                	je     a823 <fwp_map_find+0xc3>
    a7bf:	73 df                	jae    a7a0 <fwp_map_find+0x40>
    a7c1:	49 ff c4             	inc    %r12
    a7c4:	4c 89 e6             	mov    %r12,%rsi
    a7c7:	48 39 ee             	cmp    %rbp,%rsi
    a7ca:	72 dc                	jb     a7a8 <fwp_map_find+0x48>
    a7cc:	eb 4e                	jmp    a81c <fwp_map_find+0xbc>
    a7ce:	48 85 ed             	test   %rbp,%rbp
    a7d1:	0f 84 b0 00 00 00    	je     a887 <fwp_map_find+0x127>
    a7d7:	31 f6                	xor    %esi,%esi
    a7d9:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    a7e0:	ff ff 1f 
    a7e3:	eb 13                	jmp    a7f8 <fwp_map_find+0x98>
    a7e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a7ec:	00 00 00 00 
    a7f0:	4c 89 e5             	mov    %r12,%rbp
    a7f3:	48 39 ee             	cmp    %rbp,%rsi
    a7f6:	73 24                	jae    a81c <fwp_map_find+0xbc>
    a7f8:	48 8d 14 2e          	lea    (%rsi,%rbp,1),%rdx
    a7fc:	49 89 d4             	mov    %rdx,%r12
    a7ff:	49 d1 ec             	shr    $1,%r12
    a802:	48 21 c2             	and    %rax,%rdx
    a805:	49 8b 54 d7 08       	mov    0x8(%r15,%rdx,8),%rdx
    a80a:	4c 39 f2             	cmp    %r14,%rdx
    a80d:	74 14                	je     a823 <fwp_map_find+0xc3>
    a80f:	7d df                	jge    a7f0 <fwp_map_find+0x90>
    a811:	49 ff c4             	inc    %r12
    a814:	4c 89 e6             	mov    %r12,%rsi
    a817:	48 39 ee             	cmp    %rbp,%rsi
    a81a:	72 dc                	jb     a7f8 <fwp_map_find+0x98>
    a81c:	31 c0                	xor    %eax,%eax
    a81e:	49 89 f4             	mov    %rsi,%r12
    a821:	eb 69                	jmp    a88c <fwp_map_find+0x12c>
    a823:	b8 01 00 00 00       	mov    $0x1,%eax
    a828:	eb 62                	jmp    a88c <fwp_map_find+0x12c>
    a82a:	48 85 ed             	test   %rbp,%rbp
    a82d:	74 58                	je     a887 <fwp_map_find+0x127>
    a82f:	49 89 d5             	mov    %rdx,%r13
    a832:	48 89 0c 24          	mov    %rcx,(%rsp)
    a836:	31 db                	xor    %ebx,%ebx
    a838:	eb 0e                	jmp    a848 <fwp_map_find+0xe8>
    a83a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    a840:	4c 89 e5             	mov    %r12,%rbp
    a843:	48 39 eb             	cmp    %rbp,%rbx
    a846:	73 38                	jae    a880 <fwp_map_find+0x120>
    a848:	48 8d 04 2b          	lea    (%rbx,%rbp,1),%rax
    a84c:	49 89 c4             	mov    %rax,%r12
    a84f:	49 d1 ec             	shr    $1,%r12
    a852:	48 b9 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rcx
    a859:	ff ff 1f 
    a85c:	48 21 c8             	and    %rcx,%rax
    a85f:	49 8b 7c c7 08       	mov    0x8(%r15,%rax,8),%rdi
    a864:	4c 89 f6             	mov    %r14,%rsi
    a867:	4c 89 ea             	mov    %r13,%rdx
    a86a:	e8 61 00 00 00       	call   a8d0 <fwp_cmp>
    a86f:	85 c0                	test   %eax,%eax
    a871:	74 2d                	je     a8a0 <fwp_map_find+0x140>
    a873:	79 cb                	jns    a840 <fwp_map_find+0xe0>
    a875:	49 ff c4             	inc    %r12
    a878:	4c 89 e3             	mov    %r12,%rbx
    a87b:	48 39 eb             	cmp    %rbp,%rbx
    a87e:	72 c8                	jb     a848 <fwp_map_find+0xe8>
    a880:	31 c0                	xor    %eax,%eax
    a882:	49 89 dc             	mov    %rbx,%r12
    a885:	eb 1e                	jmp    a8a5 <fwp_map_find+0x145>
    a887:	31 c0                	xor    %eax,%eax
    a889:	45 31 e4             	xor    %r12d,%r12d
    a88c:	89 01                	mov    %eax,(%rcx)
    a88e:	4c 89 e0             	mov    %r12,%rax
    a891:	48 83 c4 08          	add    $0x8,%rsp
    a895:	5b                   	pop    %rbx
    a896:	41 5c                	pop    %r12
    a898:	41 5d                	pop    %r13
    a89a:	41 5e                	pop    %r14
    a89c:	41 5f                	pop    %r15
    a89e:	5d                   	pop    %rbp
    a89f:	c3                   	ret
    a8a0:	b8 01 00 00 00       	mov    $0x1,%eax
    a8a5:	48 8b 0c 24          	mov    (%rsp),%rcx
    a8a9:	eb e1                	jmp    a88c <fwp_map_find+0x12c>
    a8ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000a8b0 <fwp_map_alloc>:
    a8b0:	53                   	push   %rbx
    a8b1:	48 89 fb             	mov    %rdi,%rbx
    a8b4:	48 c1 e7 04          	shl    $0x4,%rdi
    a8b8:	48 83 cf 08          	or     $0x8,%rdi
    a8bc:	e8 8f bc ff ff       	call   6550 <fwp_alloc>
    a8c1:	48 89 18             	mov    %rbx,(%rax)
    a8c4:	5b                   	pop    %rbx
    a8c5:	c3                   	ret
    a8c6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    a8cd:	00 00 00 

000000000000a8d0 <fwp_cmp>:
    a8d0:	55                   	push   %rbp
    a8d1:	41 57                	push   %r15
    a8d3:	41 56                	push   %r14
    a8d5:	41 55                	push   %r13
    a8d7:	41 54                	push   %r12
    a8d9:	53                   	push   %rbx
    a8da:	48 83 ec 18          	sub    $0x18,%rsp
    a8de:	48 89 f3             	mov    %rsi,%rbx
    a8e1:	49 89 fe             	mov    %rdi,%r14
    a8e4:	44 8b 2a             	mov    (%rdx),%r13d
    a8e7:	49 83 fd 15          	cmp    $0x15,%r13
    a8eb:	77 25                	ja     a912 <fwp_cmp+0x42>
    a8ed:	49 89 d7             	mov    %rdx,%r15
    a8f0:	48 8d 05 f5 49 00 00 	lea    0x49f5(%rip),%rax        # f2ec <_IO_stdin_used+0x2ec>
    a8f7:	4a 63 0c a8          	movslq (%rax,%r13,4),%rcx
    a8fb:	48 01 c1             	add    %rax,%rcx
    a8fe:	ff e1                	jmp    *%rcx
    a900:	31 c9                	xor    %ecx,%ecx
    a902:	49 39 de             	cmp    %rbx,%r14
    a905:	0f 9f c1             	setg   %cl
    a908:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    a90d:	0f 4d c1             	cmovge %ecx,%eax
    a910:	eb 10                	jmp    a922 <fwp_cmp+0x52>
    a912:	31 c9                	xor    %ecx,%ecx
    a914:	49 39 de             	cmp    %rbx,%r14
    a917:	0f 97 c1             	seta   %cl
    a91a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    a91f:	0f 43 c1             	cmovae %ecx,%eax
    a922:	48 83 c4 18          	add    $0x18,%rsp
    a926:	5b                   	pop    %rbx
    a927:	41 5c                	pop    %r12
    a929:	41 5d                	pop    %r13
    a92b:	41 5e                	pop    %r14
    a92d:	41 5f                	pop    %r15
    a92f:	5d                   	pop    %rbp
    a930:	c3                   	ret
    a931:	4d 8b 3e             	mov    (%r14),%r15
    a934:	4c 8b 23             	mov    (%rbx),%r12
    a937:	49 83 c6 08          	add    $0x8,%r14
    a93b:	48 83 c3 08          	add    $0x8,%rbx
    a93f:	4d 39 e7             	cmp    %r12,%r15
    a942:	4c 89 e2             	mov    %r12,%rdx
    a945:	49 0f 42 d7          	cmovb  %r15,%rdx
    a949:	4c 89 f7             	mov    %r14,%rdi
    a94c:	48 89 de             	mov    %rbx,%rsi
    a94f:	e8 1c 89 ff ff       	call   3270 <memcmp@plt>
    a954:	85 c0                	test   %eax,%eax
    a956:	0f 84 ce 02 00 00    	je     ac2a <fwp_cmp+0x35a>
    a95c:	c1 f8 1f             	sar    $0x1f,%eax
    a95f:	83 c8 01             	or     $0x1,%eax
    a962:	eb be                	jmp    a922 <fwp_cmp+0x52>
    a964:	49 8b 06             	mov    (%r14),%rax
    a967:	48 8b 2b             	mov    (%rbx),%rbp
    a96a:	48 39 e8             	cmp    %rbp,%rax
    a96d:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    a972:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    a977:	48 0f 42 e8          	cmovb  %rax,%rbp
    a97b:	48 85 ed             	test   %rbp,%rbp
    a97e:	74 54                	je     a9d4 <fwp_cmp+0x104>
    a980:	49 8b 47 38          	mov    0x38(%r15),%rax
    a984:	48 89 04 24          	mov    %rax,(%rsp)
    a988:	41 bc 10 00 00 00    	mov    $0x10,%r12d
    a98e:	eb 09                	jmp    a999 <fwp_cmp+0xc9>
    a990:	49 83 c4 10          	add    $0x10,%r12
    a994:	48 ff cd             	dec    %rbp
    a997:	74 3b                	je     a9d4 <fwp_cmp+0x104>
    a999:	4b 8b 7c 26 f8       	mov    -0x8(%r14,%r12,1),%rdi
    a99e:	4a 8b 74 23 f8       	mov    -0x8(%rbx,%r12,1),%rsi
    a9a3:	48 8b 14 24          	mov    (%rsp),%rdx
    a9a7:	e8 24 ff ff ff       	call   a8d0 <fwp_cmp>
    a9ac:	85 c0                	test   %eax,%eax
    a9ae:	0f 85 6e ff ff ff    	jne    a922 <fwp_cmp+0x52>
    a9b4:	41 83 fd 12          	cmp    $0x12,%r13d
    a9b8:	75 d6                	jne    a990 <fwp_cmp+0xc0>
    a9ba:	4b 8b 3c 26          	mov    (%r14,%r12,1),%rdi
    a9be:	4a 8b 34 23          	mov    (%rbx,%r12,1),%rsi
    a9c2:	49 8b 57 40          	mov    0x40(%r15),%rdx
    a9c6:	e8 05 ff ff ff       	call   a8d0 <fwp_cmp>
    a9cb:	85 c0                	test   %eax,%eax
    a9cd:	74 c1                	je     a990 <fwp_cmp+0xc0>
    a9cf:	e9 4e ff ff ff       	jmp    a922 <fwp_cmp+0x52>
    a9d4:	31 c9                	xor    %ecx,%ecx
    a9d6:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    a9db:	48 39 44 24 10       	cmp    %rax,0x10(%rsp)
    a9e0:	e9 32 ff ff ff       	jmp    a917 <fwp_cmp+0x47>
    a9e5:	4c 89 f7             	mov    %r14,%rdi
    a9e8:	e8 73 02 00 00       	call   ac60 <fwp_u128>
    a9ed:	49 89 c7             	mov    %rax,%r15
    a9f0:	49 89 d6             	mov    %rdx,%r14
    a9f3:	48 89 df             	mov    %rbx,%rdi
    a9f6:	e8 65 02 00 00       	call   ac60 <fwp_u128>
    a9fb:	48 89 c1             	mov    %rax,%rcx
    a9fe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    aa03:	49 39 cf             	cmp    %rcx,%r15
    aa06:	4c 89 f6             	mov    %r14,%rsi
    aa09:	48 19 d6             	sbb    %rdx,%rsi
    aa0c:	0f 82 10 ff ff ff    	jb     a922 <fwp_cmp+0x52>
    aa12:	4c 39 f9             	cmp    %r15,%rcx
    aa15:	4c 19 f2             	sbb    %r14,%rdx
    aa18:	0f 92 c0             	setb   %al
    aa1b:	0f b6 c0             	movzbl %al,%eax
    aa1e:	e9 ff fe ff ff       	jmp    a922 <fwp_cmp+0x52>
    aa23:	4c 89 f7             	mov    %r14,%rdi
    aa26:	e8 85 b8 ff ff       	call   62b0 <fwp_f32>
    aa2b:	e8 40 02 00 00       	call   ac70 <fwp_total_key32>
    aa30:	89 c5                	mov    %eax,%ebp
    aa32:	48 89 df             	mov    %rbx,%rdi
    aa35:	e8 76 b8 ff ff       	call   62b0 <fwp_f32>
    aa3a:	e8 31 02 00 00       	call   ac70 <fwp_total_key32>
    aa3f:	89 c1                	mov    %eax,%ecx
    aa41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    aa46:	39 cd                	cmp    %ecx,%ebp
    aa48:	0f 8c d4 fe ff ff    	jl     a922 <fwp_cmp+0x52>
    aa4e:	eb 2e                	jmp    aa7e <fwp_cmp+0x1ae>
    aa50:	4c 89 f7             	mov    %r14,%rdi
    aa53:	e8 b8 98 ff ff       	call   4310 <fwp_f64>
    aa58:	e8 23 02 00 00       	call   ac80 <fwp_total_key64>
    aa5d:	49 89 c6             	mov    %rax,%r14
    aa60:	48 89 df             	mov    %rbx,%rdi
    aa63:	e8 a8 98 ff ff       	call   4310 <fwp_f64>
    aa68:	e8 13 02 00 00       	call   ac80 <fwp_total_key64>
    aa6d:	48 89 c1             	mov    %rax,%rcx
    aa70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    aa75:	49 39 ce             	cmp    %rcx,%r14
    aa78:	0f 8c a4 fe ff ff    	jl     a922 <fwp_cmp+0x52>
    aa7e:	0f 9f c0             	setg   %al
    aa81:	0f b6 c0             	movzbl %al,%eax
    aa84:	e9 99 fe ff ff       	jmp    a922 <fwp_cmp+0x52>
    aa89:	4c 89 f7             	mov    %r14,%rdi
    aa8c:	e8 bf 01 00 00       	call   ac50 <fwp_i128>
    aa91:	49 89 c7             	mov    %rax,%r15
    aa94:	49 89 d6             	mov    %rdx,%r14
    aa97:	48 89 df             	mov    %rbx,%rdi
    aa9a:	e8 b1 01 00 00       	call   ac50 <fwp_i128>
    aa9f:	48 89 c1             	mov    %rax,%rcx
    aaa2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    aaa7:	49 39 cf             	cmp    %rcx,%r15
    aaaa:	4c 89 f6             	mov    %r14,%rsi
    aaad:	48 19 d6             	sbb    %rdx,%rsi
    aab0:	0f 8c 6c fe ff ff    	jl     a922 <fwp_cmp+0x52>
    aab6:	4c 39 f9             	cmp    %r15,%rcx
    aab9:	4c 19 f2             	sbb    %r14,%rdx
    aabc:	0f 9c c0             	setl   %al
    aabf:	0f b6 c0             	movzbl %al,%eax
    aac2:	e9 5b fe ff ff       	jmp    a922 <fwp_cmp+0x52>
    aac7:	4d 85 f6             	test   %r14,%r14
    aaca:	0f 94 c0             	sete   %al
    aacd:	74 3e                	je     ab0d <fwp_cmp+0x23d>
    aacf:	48 85 db             	test   %rbx,%rbx
    aad2:	74 39                	je     ab0d <fwp_cmp+0x23d>
    aad4:	4d 8b 7f 38          	mov    0x38(%r15),%r15
    aad8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    aadf:	00 
    aae0:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    aae4:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    aae8:	4c 89 fa             	mov    %r15,%rdx
    aaeb:	e8 e0 fd ff ff       	call   a8d0 <fwp_cmp>
    aaf0:	85 c0                	test   %eax,%eax
    aaf2:	0f 85 2a fe ff ff    	jne    a922 <fwp_cmp+0x52>
    aaf8:	4d 8b 76 10          	mov    0x10(%r14),%r14
    aafc:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    ab00:	4d 85 f6             	test   %r14,%r14
    ab03:	0f 94 c0             	sete   %al
    ab06:	74 05                	je     ab0d <fwp_cmp+0x23d>
    ab08:	48 85 db             	test   %rbx,%rbx
    ab0b:	75 d3                	jne    aae0 <fwp_cmp+0x210>
    ab0d:	48 85 db             	test   %rbx,%rbx
    ab10:	0f 95 c1             	setne  %cl
    ab13:	08 c1                	or     %al,%cl
    ab15:	80 f1 01             	xor    $0x1,%cl
    ab18:	0f b6 c9             	movzbl %cl,%ecx
    ab1b:	84 c0                	test   %al,%al
    ab1d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    ab22:	0f 44 c1             	cmove  %ecx,%eax
    ab25:	48 85 db             	test   %rbx,%rbx
    ab28:	0f 44 c1             	cmove  %ecx,%eax
    ab2b:	e9 f2 fd ff ff       	jmp    a922 <fwp_cmp+0x52>
    ab30:	45 8b 67 10          	mov    0x10(%r15),%r12d
    ab34:	45 85 e4             	test   %r12d,%r12d
    ab37:	0f 8e f7 00 00 00    	jle    ac34 <fwp_cmp+0x364>
    ab3d:	4d 8b 7f 20          	mov    0x20(%r15),%r15
    ab41:	45 31 ed             	xor    %r13d,%r13d
    ab44:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    ab4b:	00 00 00 00 00 
    ab50:	4b 8b 7c ee 08       	mov    0x8(%r14,%r13,8),%rdi
    ab55:	4a 8b 74 eb 08       	mov    0x8(%rbx,%r13,8),%rsi
    ab5a:	4b 8b 14 ef          	mov    (%r15,%r13,8),%rdx
    ab5e:	e8 6d fd ff ff       	call   a8d0 <fwp_cmp>
    ab63:	85 c0                	test   %eax,%eax
    ab65:	0f 85 b7 fd ff ff    	jne    a922 <fwp_cmp+0x52>
    ab6b:	49 ff c5             	inc    %r13
    ab6e:	31 c0                	xor    %eax,%eax
    ab70:	4d 39 ec             	cmp    %r13,%r12
    ab73:	75 db                	jne    ab50 <fwp_cmp+0x280>
    ab75:	e9 a8 fd ff ff       	jmp    a922 <fwp_cmp+0x52>
    ab7a:	49 8b 06             	mov    (%r14),%rax
    ab7d:	4c 8b 2b             	mov    (%rbx),%r13
    ab80:	4c 39 e8             	cmp    %r13,%rax
    ab83:	4c 89 ed             	mov    %r13,%rbp
    ab86:	48 89 04 24          	mov    %rax,(%rsp)
    ab8a:	48 0f 42 e8          	cmovb  %rax,%rbp
    ab8e:	48 85 ed             	test   %rbp,%rbp
    ab91:	74 2f                	je     abc2 <fwp_cmp+0x2f2>
    ab93:	4d 8b 7f 38          	mov    0x38(%r15),%r15
    ab97:	45 31 e4             	xor    %r12d,%r12d
    ab9a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    aba0:	4b 8b 7c e6 08       	mov    0x8(%r14,%r12,8),%rdi
    aba5:	4a 8b 74 e3 08       	mov    0x8(%rbx,%r12,8),%rsi
    abaa:	4c 89 fa             	mov    %r15,%rdx
    abad:	e8 1e fd ff ff       	call   a8d0 <fwp_cmp>
    abb2:	85 c0                	test   %eax,%eax
    abb4:	0f 85 68 fd ff ff    	jne    a922 <fwp_cmp+0x52>
    abba:	49 ff c4             	inc    %r12
    abbd:	4c 39 e5             	cmp    %r12,%rbp
    abc0:	75 de                	jne    aba0 <fwp_cmp+0x2d0>
    abc2:	31 c9                	xor    %ecx,%ecx
    abc4:	4c 39 2c 24          	cmp    %r13,(%rsp)
    abc8:	e9 4a fd ff ff       	jmp    a917 <fwp_cmp+0x47>
    abcd:	4c 89 f7             	mov    %r14,%rdi
    abd0:	e8 cb 00 00 00       	call   aca0 <fwp_tag>
    abd5:	89 c5                	mov    %eax,%ebp
    abd7:	48 89 df             	mov    %rbx,%rdi
    abda:	e8 c1 00 00 00       	call   aca0 <fwp_tag>
    abdf:	39 c5                	cmp    %eax,%ebp
    abe1:	75 58                	jne    ac3b <fwp_cmp+0x36b>
    abe3:	49 8b 4f 28          	mov    0x28(%r15),%rcx
    abe7:	89 e8                	mov    %ebp,%eax
    abe9:	44 8b 24 81          	mov    (%rcx,%rax,4),%r12d
    abed:	45 85 e4             	test   %r12d,%r12d
    abf0:	7e 42                	jle    ac34 <fwp_cmp+0x364>
    abf2:	49 8b 4f 30          	mov    0x30(%r15),%rcx
    abf6:	4c 8b 3c c1          	mov    (%rcx,%rax,8),%r15
    abfa:	45 31 ed             	xor    %r13d,%r13d
    abfd:	0f 1f 00             	nopl   (%rax)
    ac00:	4b 8b 7c ee 08       	mov    0x8(%r14,%r13,8),%rdi
    ac05:	4a 8b 74 eb 08       	mov    0x8(%rbx,%r13,8),%rsi
    ac0a:	4b 8b 14 ef          	mov    (%r15,%r13,8),%rdx
    ac0e:	e8 bd fc ff ff       	call   a8d0 <fwp_cmp>
    ac13:	85 c0                	test   %eax,%eax
    ac15:	0f 85 07 fd ff ff    	jne    a922 <fwp_cmp+0x52>
    ac1b:	49 ff c5             	inc    %r13
    ac1e:	31 c0                	xor    %eax,%eax
    ac20:	4d 39 ec             	cmp    %r13,%r12
    ac23:	75 db                	jne    ac00 <fwp_cmp+0x330>
    ac25:	e9 f8 fc ff ff       	jmp    a922 <fwp_cmp+0x52>
    ac2a:	31 c9                	xor    %ecx,%ecx
    ac2c:	4d 39 e7             	cmp    %r12,%r15
    ac2f:	e9 e3 fc ff ff       	jmp    a917 <fwp_cmp+0x47>
    ac34:	31 c0                	xor    %eax,%eax
    ac36:	e9 e7 fc ff ff       	jmp    a922 <fwp_cmp+0x52>
    ac3b:	0f 97 c0             	seta   %al
    ac3e:	0f b6 c8             	movzbl %al,%ecx
    ac41:	e9 d4 fc ff ff       	jmp    a91a <fwp_cmp+0x4a>
    ac46:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    ac4d:	00 00 00 

000000000000ac50 <fwp_i128>:
    ac50:	48 8b 07             	mov    (%rdi),%rax
    ac53:	48 8b 57 08          	mov    0x8(%rdi),%rdx
    ac57:	c3                   	ret
    ac58:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    ac5f:	00 

000000000000ac60 <fwp_u128>:
    ac60:	48 8b 07             	mov    (%rdi),%rax
    ac63:	48 8b 57 08          	mov    0x8(%rdi),%rdx
    ac67:	c3                   	ret
    ac68:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    ac6f:	00 

000000000000ac70 <fwp_total_key32>:
    ac70:	66 0f 7e c1          	movd   %xmm0,%ecx
    ac74:	89 c8                	mov    %ecx,%eax
    ac76:	c1 f8 1f             	sar    $0x1f,%eax
    ac79:	d1 e8                	shr    $1,%eax
    ac7b:	31 c8                	xor    %ecx,%eax
    ac7d:	c3                   	ret
    ac7e:	66 90                	xchg   %ax,%ax

000000000000ac80 <fwp_total_key64>:
    ac80:	66 48 0f 7e c1       	movq   %xmm0,%rcx
    ac85:	48 89 c8             	mov    %rcx,%rax
    ac88:	48 c1 f8 3f          	sar    $0x3f,%rax
    ac8c:	48 d1 e8             	shr    $1,%rax
    ac8f:	48 31 c8             	xor    %rcx,%rax
    ac92:	c3                   	ret
    ac93:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ac9a:	84 00 00 00 00 00 

000000000000aca0 <fwp_tag>:
    aca0:	48 89 f8             	mov    %rdi,%rax
    aca3:	48 81 ff ff 0f 00 00 	cmp    $0xfff,%rdi
    acaa:	76 02                	jbe    acae <fwp_tag+0xe>
    acac:	8b 00                	mov    (%rax),%eax
    acae:	c3                   	ret
    acaf:	90                   	nop

000000000000acb0 <fwp_transport_off>:
    acb0:	50                   	push   %rax
    acb1:	48 8d 3d 42 57 00 00 	lea    0x5742(%rip),%rdi        # 103fa <exec_in_fp0+0xcfa>
    acb8:	e8 73 83 ff ff       	call   3030 <getenv@plt>
    acbd:	48 85 c0             	test   %rax,%rax
    acc0:	74 1a                	je     acdc <fwp_transport_off+0x2c>
    acc2:	48 8d 35 3f 57 00 00 	lea    0x573f(%rip),%rsi        # 10408 <exec_in_fp0+0xd08>
    acc9:	48 89 c7             	mov    %rax,%rdi
    accc:	e8 ff 85 ff ff       	call   32d0 <strcmp@plt>
    acd1:	89 c1                	mov    %eax,%ecx
    acd3:	31 c0                	xor    %eax,%eax
    acd5:	85 c9                	test   %ecx,%ecx
    acd7:	0f 94 c0             	sete   %al
    acda:	59                   	pop    %rcx
    acdb:	c3                   	ret
    acdc:	31 c0                	xor    %eax,%eax
    acde:	59                   	pop    %rcx
    acdf:	c3                   	ret

000000000000ace0 <fwp_pipe_addr>:
    ace0:	50                   	push   %rax
    ace1:	0f 57 c0             	xorps  %xmm0,%xmm0
    ace4:	0f 11 47 5e          	movups %xmm0,0x5e(%rdi)
    ace8:	0f 11 47 52          	movups %xmm0,0x52(%rdi)
    acec:	0f 11 47 42          	movups %xmm0,0x42(%rdi)
    acf0:	0f 11 47 32          	movups %xmm0,0x32(%rdi)
    acf4:	0f 11 47 22          	movups %xmm0,0x22(%rdi)
    acf8:	0f 11 47 12          	movups %xmm0,0x12(%rdi)
    acfc:	0f 11 47 02          	movups %xmm0,0x2(%rdi)
    ad00:	66 c7 07 01 00       	movw   $0x1,(%rdi)
    ad05:	48 83 c7 03          	add    $0x3,%rdi
    ad09:	48 8b 0e             	mov    (%rsi),%rcx
    ad0c:	4c 8b 46 08          	mov    0x8(%rsi),%r8
    ad10:	48 8d 15 f7 56 00 00 	lea    0x56f7(%rip),%rdx        # 1040e <exec_in_fp0+0xd0e>
    ad17:	be 6b 00 00 00       	mov    $0x6b,%esi
    ad1c:	31 c0                	xor    %eax,%eax
    ad1e:	e8 ad 84 ff ff       	call   31d0 <snprintf@plt>
    ad23:	83 c0 03             	add    $0x3,%eax
    ad26:	59                   	pop    %rcx
    ad27:	c3                   	ret
    ad28:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    ad2f:	00 

000000000000ad30 <fwp_now_ns>:
    ad30:	48 83 ec 18          	sub    $0x18,%rsp
    ad34:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    ad39:	bf 01 00 00 00       	mov    $0x1,%edi
    ad3e:	e8 ed 83 ff ff       	call   3130 <clock_gettime@plt>
    ad43:	48 69 44 24 08 00 ca 	imul   $0x3b9aca00,0x8(%rsp),%rax
    ad4a:	9a 3b 
    ad4c:	48 03 44 24 10       	add    0x10(%rsp),%rax
    ad51:	48 83 c4 18          	add    $0x18,%rsp
    ad55:	c3                   	ret
    ad56:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    ad5d:	00 00 00 

000000000000ad60 <fwp_ring_put>:
    ad60:	55                   	push   %rbp
    ad61:	41 57                	push   %r15
    ad63:	41 56                	push   %r14
    ad65:	41 55                	push   %r13
    ad67:	41 54                	push   %r12
    ad69:	53                   	push   %rbx
    ad6a:	48 83 ec 38          	sub    $0x38,%rsp
    ad6e:	48 89 3c 24          	mov    %rdi,(%rsp)
    ad72:	48 85 f6             	test   %rsi,%rsi
    ad75:	0f 84 27 01 00 00    	je     aea2 <fwp_ring_put+0x142>
    ad7b:	f6 05 d6 c6 02 00 01 	testb  $0x1,0x2c6d6(%rip)        # 37458 <fwp_po_gone>
    ad82:	0f 85 1a 01 00 00    	jne    aea2 <fwp_ring_put+0x142>
    ad88:	48 89 f3             	mov    %rsi,%rbx
    ad8b:	4c 8b 3d be c6 02 00 	mov    0x2c6be(%rip),%r15        # 37450 <fwp_po_ring>
    ad92:	49 8d 87 00 10 00 00 	lea    0x1000(%r15),%rax
    ad99:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    ad9e:	49 8d 87 c0 00 00 00 	lea    0xc0(%r15),%rax
    ada5:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    adaa:	49 8d 87 c4 00 00 00 	lea    0xc4(%r15),%rax
    adb1:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    adb6:	49 8d 87 00 01 00 00 	lea    0x100(%r15),%rax
    adbd:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    adc2:	49 8d 87 04 01 00 00 	lea    0x104(%r15),%rax
    adc9:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    adce:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    add3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    adda:	84 00 00 00 00 00 
    ade0:	4d 8b 67 40          	mov    0x40(%r15),%r12
    ade4:	49 8b af 80 00 00 00 	mov    0x80(%r15),%rbp
    adeb:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    adef:	4c 29 e5             	sub    %r12,%rbp
    adf2:	4c 01 ed             	add    %r13,%rbp
    adf5:	74 69                	je     ae60 <fwp_ring_put+0x100>
    adf7:	48 39 eb             	cmp    %rbp,%rbx
    adfa:	48 0f 42 eb          	cmovb  %rbx,%rbp
    adfe:	49 8d 7d ff          	lea    -0x1(%r13),%rdi
    ae02:	4c 21 e7             	and    %r12,%rdi
    ae05:	49 29 fd             	sub    %rdi,%r13
    ae08:	4c 39 ed             	cmp    %r13,%rbp
    ae0b:	4c 0f 42 ed          	cmovb  %rbp,%r13
    ae0f:	4c 01 f7             	add    %r14,%rdi
    ae12:	48 89 5c 24 30       	mov    %rbx,0x30(%rsp)
    ae17:	48 8b 1c 24          	mov    (%rsp),%rbx
    ae1b:	48 89 de             	mov    %rbx,%rsi
    ae1e:	4c 89 ea             	mov    %r13,%rdx
    ae21:	e8 0a 85 ff ff       	call   3330 <memcpy@plt>
    ae26:	4a 8d 34 2b          	lea    (%rbx,%r13,1),%rsi
    ae2a:	48 89 ea             	mov    %rbp,%rdx
    ae2d:	4c 29 ea             	sub    %r13,%rdx
    ae30:	4c 89 f7             	mov    %r14,%rdi
    ae33:	e8 f8 84 ff ff       	call   3330 <memcpy@plt>
    ae38:	49 01 ec             	add    %rbp,%r12
    ae3b:	4d 89 67 40          	mov    %r12,0x40(%r15)
    ae3f:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    ae44:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    ae49:	e8 82 02 00 00       	call   b0d0 <fwp_ring_wake>
    ae4e:	48 01 eb             	add    %rbp,%rbx
    ae51:	48 89 1c 24          	mov    %rbx,(%rsp)
    ae55:	48 8b 5c 24 30       	mov    0x30(%rsp),%rbx
    ae5a:	48 29 eb             	sub    %rbp,%rbx
    ae5d:	eb 31                	jmp    ae90 <fwp_ring_put+0x130>
    ae5f:	90                   	nop
    ae60:	44 8b 05 55 be 00 00 	mov    0xbe55(%rip),%r8d        # 16cbc <fwp_po_sock>
    ae67:	4c 89 ff             	mov    %r15,%rdi
    ae6a:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    ae6f:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    ae74:	48 8d 0d 35 02 00 00 	lea    0x235(%rip),%rcx        # b0b0 <fwp_ring_has_space>
    ae7b:	e8 f0 00 00 00       	call   af70 <fwp_ring_wait>
    ae80:	85 c0                	test   %eax,%eax
    ae82:	75 0c                	jne    ae90 <fwp_ring_put+0x130>
    ae84:	c6 05 cd c5 02 00 01 	movb   $0x1,0x2c5cd(%rip)        # 37458 <fwp_po_gone>
    ae8b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    ae90:	48 85 db             	test   %rbx,%rbx
    ae93:	74 0d                	je     aea2 <fwp_ring_put+0x142>
    ae95:	f6 05 bc c5 02 00 01 	testb  $0x1,0x2c5bc(%rip)        # 37458 <fwp_po_gone>
    ae9c:	0f 84 3e ff ff ff    	je     ade0 <fwp_ring_put+0x80>
    aea2:	48 83 c4 38          	add    $0x38,%rsp
    aea6:	5b                   	pop    %rbx
    aea7:	41 5c                	pop    %r12
    aea9:	41 5d                	pop    %r13
    aeab:	41 5e                	pop    %r14
    aead:	41 5f                	pop    %r15
    aeaf:	5d                   	pop    %rbp
    aeb0:	c3                   	ret
    aeb1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    aeb8:	0f 1f 84 00 00 00 00 
    aebf:	00 

000000000000aec0 <fwp_po_flush_sock>:
    aec0:	48 8b 15 81 c5 01 00 	mov    0x1c581(%rip),%rdx        # 27448 <fwp_po_len>
    aec7:	48 85 d2             	test   %rdx,%rdx
    aeca:	74 17                	je     aee3 <fwp_po_flush_sock+0x23>
    aecc:	50                   	push   %rax
    aecd:	8b 3d e9 bd 00 00    	mov    0xbde9(%rip),%edi        # 16cbc <fwp_po_sock>
    aed3:	48 8d 35 76 c5 01 00 	lea    0x1c576(%rip),%rsi        # 27450 <fwp_po_buf>
    aeda:	e8 11 00 00 00       	call   aef0 <fwp_po_write_raw>
    aedf:	48 83 c4 08          	add    $0x8,%rsp
    aee3:	48 c7 05 5a c5 01 00 	movq   $0x0,0x1c55a(%rip)        # 27448 <fwp_po_len>
    aeea:	00 00 00 00 
    aeee:	c3                   	ret
    aeef:	90                   	nop

000000000000aef0 <fwp_po_write_raw>:
    aef0:	48 85 d2             	test   %rdx,%rdx
    aef3:	74 70                	je     af65 <fwp_po_write_raw+0x75>
    aef5:	f6 05 5c c5 02 00 01 	testb  $0x1,0x2c55c(%rip)        # 37458 <fwp_po_gone>
    aefc:	75 67                	jne    af65 <fwp_po_write_raw+0x75>
    aefe:	55                   	push   %rbp
    aeff:	41 56                	push   %r14
    af01:	53                   	push   %rbx
    af02:	48 89 d3             	mov    %rdx,%rbx
    af05:	49 89 f6             	mov    %rsi,%r14
    af08:	89 fd                	mov    %edi,%ebp
    af0a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    af10:	89 ef                	mov    %ebp,%edi
    af12:	4c 89 f6             	mov    %r14,%rsi
    af15:	48 89 da             	mov    %rbx,%rdx
    af18:	b9 00 40 00 00       	mov    $0x4000,%ecx
    af1d:	e8 7e 82 ff ff       	call   31a0 <send@plt>
    af22:	48 85 c0             	test   %rax,%rax
    af25:	78 19                	js     af40 <fwp_po_write_raw+0x50>
    af27:	74 31                	je     af5a <fwp_po_write_raw+0x6a>
    af29:	49 01 c6             	add    %rax,%r14
    af2c:	48 29 c3             	sub    %rax,%rbx
    af2f:	eb 19                	jmp    af4a <fwp_po_write_raw+0x5a>
    af31:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    af38:	0f 1f 84 00 00 00 00 
    af3f:	00 
    af40:	e8 3b 81 ff ff       	call   3080 <__errno_location@plt>
    af45:	83 38 04             	cmpl   $0x4,(%rax)
    af48:	75 10                	jne    af5a <fwp_po_write_raw+0x6a>
    af4a:	48 85 db             	test   %rbx,%rbx
    af4d:	74 12                	je     af61 <fwp_po_write_raw+0x71>
    af4f:	f6 05 02 c5 02 00 01 	testb  $0x1,0x2c502(%rip)        # 37458 <fwp_po_gone>
    af56:	74 b8                	je     af10 <fwp_po_write_raw+0x20>
    af58:	eb 07                	jmp    af61 <fwp_po_write_raw+0x71>
    af5a:	c6 05 f7 c4 02 00 01 	movb   $0x1,0x2c4f7(%rip)        # 37458 <fwp_po_gone>
    af61:	5b                   	pop    %rbx
    af62:	41 5e                	pop    %r14
    af64:	5d                   	pop    %rbp
    af65:	c3                   	ret
    af66:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    af6d:	00 00 00 

000000000000af70 <fwp_ring_wait>:
    af70:	55                   	push   %rbp
    af71:	41 57                	push   %r15
    af73:	41 56                	push   %r14
    af75:	41 55                	push   %r13
    af77:	41 54                	push   %r12
    af79:	53                   	push   %rbx
    af7a:	50                   	push   %rax
    af7b:	44 89 44 24 04       	mov    %r8d,0x4(%rsp)
    af80:	49 89 cf             	mov    %rcx,%r15
    af83:	49 89 d6             	mov    %rdx,%r14
    af86:	49 89 f4             	mov    %rsi,%r12
    af89:	49 89 fd             	mov    %rdi,%r13
    af8c:	8b 0d 2e bd 00 00    	mov    0xbd2e(%rip),%ecx        # 16cc0 <fwp_ring_spin>
    af92:	85 c9                	test   %ecx,%ecx
    af94:	78 06                	js     af9c <fwp_ring_wait+0x2c>
    af96:	85 c9                	test   %ecx,%ecx
    af98:	75 1f                	jne    afb9 <fwp_ring_wait+0x49>
    af9a:	eb 6f                	jmp    b00b <fwp_ring_wait+0x9b>
    af9c:	bf 54 00 00 00       	mov    $0x54,%edi
    afa1:	e8 8a 84 ff ff       	call   3430 <sysconf@plt>
    afa6:	31 c9                	xor    %ecx,%ecx
    afa8:	48 83 f8 02          	cmp    $0x2,%rax
    afac:	0f 9d c1             	setge  %cl
    afaf:	89 0d 0b bd 00 00    	mov    %ecx,0xbd0b(%rip)        # 16cc0 <fwp_ring_spin>
    afb5:	85 c9                	test   %ecx,%ecx
    afb7:	74 52                	je     b00b <fwp_ring_wait+0x9b>
    afb9:	4c 89 ef             	mov    %r13,%rdi
    afbc:	41 ff d7             	call   *%r15
    afbf:	89 c1                	mov    %eax,%ecx
    afc1:	b8 01 00 00 00       	mov    $0x1,%eax
    afc6:	85 c9                	test   %ecx,%ecx
    afc8:	75 6a                	jne    b034 <fwp_ring_wait+0xc4>
    afca:	bd 01 00 00 00       	mov    $0x1,%ebp
    afcf:	31 db                	xor    %ebx,%ebx
    afd1:	eb 19                	jmp    afec <fwp_ring_wait+0x7c>
    afd3:	48 05 50 c3 00 00    	add    $0xc350,%rax
    afd9:	48 89 c3             	mov    %rax,%rbx
    afdc:	0f 1f 40 00          	nopl   0x0(%rax)
    afe0:	ff c5                	inc    %ebp
    afe2:	4c 89 ef             	mov    %r13,%rdi
    afe5:	41 ff d7             	call   *%r15
    afe8:	85 c0                	test   %eax,%eax
    afea:	75 43                	jne    b02f <fwp_ring_wait+0xbf>
    afec:	e8 ff 00 00 00       	call   b0f0 <fwp_cpu_relax>
    aff1:	40 f6 c5 3f          	test   $0x3f,%bpl
    aff5:	75 e9                	jne    afe0 <fwp_ring_wait+0x70>
    aff7:	e8 54 82 ff ff       	call   3250 <sched_yield@plt>
    affc:	e8 2f fd ff ff       	call   ad30 <fwp_now_ns>
    b001:	48 85 db             	test   %rbx,%rbx
    b004:	74 cd                	je     afd3 <fwp_ring_wait+0x63>
    b006:	48 39 d8             	cmp    %rbx,%rax
    b009:	7e d5                	jle    afe0 <fwp_ring_wait+0x70>
    b00b:	41 8b 2c 24          	mov    (%r12),%ebp
    b00f:	b8 01 00 00 00       	mov    $0x1,%eax
    b014:	41 87 06             	xchg   %eax,(%r14)
    b017:	0f ae f0             	mfence
    b01a:	4c 89 ef             	mov    %r13,%rdi
    b01d:	41 ff d7             	call   *%r15
    b020:	85 c0                	test   %eax,%eax
    b022:	8b 5c 24 04          	mov    0x4(%rsp),%ebx
    b026:	74 41                	je     b069 <fwp_ring_wait+0xf9>
    b028:	41 c7 06 00 00 00 00 	movl   $0x0,(%r14)
    b02f:	b8 01 00 00 00       	mov    $0x1,%eax
    b034:	48 83 c4 08          	add    $0x8,%rsp
    b038:	5b                   	pop    %rbx
    b039:	41 5c                	pop    %r12
    b03b:	41 5d                	pop    %r13
    b03d:	41 5e                	pop    %r14
    b03f:	41 5f                	pop    %r15
    b041:	5d                   	pop    %rbp
    b042:	c3                   	ret
    b043:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b04a:	84 00 00 00 00 00 
    b050:	41 8b 2c 24          	mov    (%r12),%ebp
    b054:	b8 01 00 00 00       	mov    $0x1,%eax
    b059:	41 87 06             	xchg   %eax,(%r14)
    b05c:	0f ae f0             	mfence
    b05f:	4c 89 ef             	mov    %r13,%rdi
    b062:	41 ff d7             	call   *%r15
    b065:	85 c0                	test   %eax,%eax
    b067:	75 bf                	jne    b028 <fwp_ring_wait+0xb8>
    b069:	4c 89 e7             	mov    %r12,%rdi
    b06c:	31 f6                	xor    %esi,%esi
    b06e:	89 ea                	mov    %ebp,%edx
    b070:	b9 64 00 00 00       	mov    $0x64,%ecx
    b075:	e8 86 00 00 00       	call   b100 <fwp_futex>
    b07a:	48 89 c5             	mov    %rax,%rbp
    b07d:	41 c7 06 00 00 00 00 	movl   $0x0,(%r14)
    b084:	4c 89 ef             	mov    %r13,%rdi
    b087:	41 ff d7             	call   *%r15
    b08a:	85 c0                	test   %eax,%eax
    b08c:	75 a1                	jne    b02f <fwp_ring_wait+0xbf>
    b08e:	48 85 ed             	test   %rbp,%rbp
    b091:	74 bd                	je     b050 <fwp_ring_wait+0xe0>
    b093:	e8 e8 7f ff ff       	call   3080 <__errno_location@plt>
    b098:	83 38 6e             	cmpl   $0x6e,(%rax)
    b09b:	75 b3                	jne    b050 <fwp_ring_wait+0xe0>
    b09d:	89 df                	mov    %ebx,%edi
    b09f:	e8 cc 00 00 00       	call   b170 <fwp_sock_gone>
    b0a4:	85 c0                	test   %eax,%eax
    b0a6:	74 a8                	je     b050 <fwp_ring_wait+0xe0>
    b0a8:	31 c0                	xor    %eax,%eax
    b0aa:	eb 88                	jmp    b034 <fwp_ring_wait+0xc4>
    b0ac:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000b0b0 <fwp_ring_has_space>:
    b0b0:	48 8b 8f 80 00 00 00 	mov    0x80(%rdi),%rcx
    b0b7:	48 2b 4f 40          	sub    0x40(%rdi),%rcx
    b0bb:	31 c0                	xor    %eax,%eax
    b0bd:	48 03 4f 08          	add    0x8(%rdi),%rcx
    b0c1:	0f 95 c0             	setne  %al
    b0c4:	c3                   	ret
    b0c5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b0cc:	00 00 00 00 

000000000000b0d0 <fwp_ring_wake>:
    b0d0:	0f ae f0             	mfence
    b0d3:	8b 06                	mov    (%rsi),%eax
    b0d5:	85 c0                	test   %eax,%eax
    b0d7:	74 14                	je     b0ed <fwp_ring_wake+0x1d>
    b0d9:	f0 ff 07             	lock incl (%rdi)
    b0dc:	be 01 00 00 00       	mov    $0x1,%esi
    b0e1:	ba ff ff ff 7f       	mov    $0x7fffffff,%edx
    b0e6:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    b0eb:	eb 13                	jmp    b100 <fwp_futex>
    b0ed:	c3                   	ret
    b0ee:	66 90                	xchg   %ax,%ax

000000000000b0f0 <fwp_cpu_relax>:
    b0f0:	f3 90                	pause
    b0f2:	c3                   	ret
    b0f3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b0fa:	84 00 00 00 00 00 

000000000000b100 <fwp_futex>:
    b100:	48 83 ec 18          	sub    $0x18,%rsp
    b104:	89 c8                	mov    %ecx,%eax
    b106:	89 d1                	mov    %edx,%ecx
    b108:	89 f2                	mov    %esi,%edx
    b10a:	48 89 fe             	mov    %rdi,%rsi
    b10d:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
    b114:	00 00 
    b116:	48 98                	cltq
    b118:	48 69 f8 d3 4d 62 10 	imul   $0x10624dd3,%rax,%rdi
    b11f:	49 89 f8             	mov    %rdi,%r8
    b122:	49 c1 e8 3f          	shr    $0x3f,%r8
    b126:	48 c1 ff 26          	sar    $0x26,%rdi
    b12a:	44 01 c7             	add    %r8d,%edi
    b12d:	69 ff e8 03 00 00    	imul   $0x3e8,%edi,%edi
    b133:	41 89 c0             	mov    %eax,%r8d
    b136:	41 29 f8             	sub    %edi,%r8d
    b139:	41 69 f8 40 42 0f 00 	imul   $0xf4240,%r8d,%edi
    b140:	48 63 ff             	movslq %edi,%rdi
    b143:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    b148:	31 ff                	xor    %edi,%edi
    b14a:	85 c0                	test   %eax,%eax
    b14c:	4c 8d 44 24 08       	lea    0x8(%rsp),%r8
    b151:	4c 0f 48 c7          	cmovs  %rdi,%r8
    b155:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    b15c:	bf ca 00 00 00       	mov    $0xca,%edi
    b161:	45 31 c9             	xor    %r9d,%r9d
    b164:	31 c0                	xor    %eax,%eax
    b166:	e8 95 81 ff ff       	call   3300 <syscall@plt>
    b16b:	48 83 c4 18          	add    $0x18,%rsp
    b16f:	c3                   	ret

000000000000b170 <fwp_sock_gone>:
    b170:	55                   	push   %rbp
    b171:	53                   	push   %rbx
    b172:	48 83 ec 18          	sub    $0x18,%rsp
    b176:	89 fb                	mov    %edi,%ebx
    b178:	89 7c 24 10          	mov    %edi,0x10(%rsp)
    b17c:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%rsp)
    b183:	00 
    b184:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    b189:	31 ed                	xor    %ebp,%ebp
    b18b:	be 01 00 00 00       	mov    $0x1,%esi
    b190:	31 d2                	xor    %edx,%edx
    b192:	e8 29 82 ff ff       	call   33c0 <poll@plt>
    b197:	85 c0                	test   %eax,%eax
    b199:	7e 2b                	jle    b1c6 <fwp_sock_gone+0x56>
    b19b:	bd 01 00 00 00       	mov    $0x1,%ebp
    b1a0:	f6 44 24 16 18       	testb  $0x18,0x16(%rsp)
    b1a5:	75 1f                	jne    b1c6 <fwp_sock_gone+0x56>
    b1a7:	48 8d 74 24 0f       	lea    0xf(%rsp),%rsi
    b1ac:	ba 01 00 00 00       	mov    $0x1,%edx
    b1b1:	89 df                	mov    %ebx,%edi
    b1b3:	b9 42 00 00 00       	mov    $0x42,%ecx
    b1b8:	e8 a3 7e ff ff       	call   3060 <recv@plt>
    b1bd:	31 ed                	xor    %ebp,%ebp
    b1bf:	48 85 c0             	test   %rax,%rax
    b1c2:	40 0f 94 c5          	sete   %bpl
    b1c6:	89 e8                	mov    %ebp,%eax
    b1c8:	48 83 c4 18          	add    $0x18,%rsp
    b1cc:	5b                   	pop    %rbx
    b1cd:	5d                   	pop    %rbp
    b1ce:	c3                   	ret
    b1cf:	90                   	nop

000000000000b1d0 <fwp_pipe_poll>:
    b1d0:	83 3d e1 ba 00 00 00 	cmpl   $0x0,0xbae1(%rip)        # 16cb8 <fwp_po_listen>
    b1d7:	0f 88 9b 01 00 00    	js     b378 <fwp_pipe_poll+0x1a8>
    b1dd:	55                   	push   %rbp
    b1de:	41 57                	push   %r15
    b1e0:	41 56                	push   %r14
    b1e2:	53                   	push   %rbx
    b1e3:	48 83 ec 28          	sub    $0x28,%rsp
    b1e7:	e8 44 fb ff ff       	call   ad30 <fwp_now_ns>
    b1ec:	48 3b 05 6d c2 02 00 	cmp    0x2c26d(%rip),%rax        # 37460 <fwp_po_next_check>
    b1f3:	0f 8c 75 01 00 00    	jl     b36e <fwp_pipe_poll+0x19e>
    b1f9:	49 89 c6             	mov    %rax,%r14
    b1fc:	48 05 40 42 0f 00    	add    $0xf4240,%rax
    b202:	48 89 05 57 c2 02 00 	mov    %rax,0x2c257(%rip)        # 37460 <fwp_po_next_check>
    b209:	8b 3d a9 ba 00 00    	mov    0xbaa9(%rip),%edi        # 16cb8 <fwp_po_listen>
    b20f:	31 f6                	xor    %esi,%esi
    b211:	31 d2                	xor    %edx,%edx
    b213:	e8 28 82 ff ff       	call   3440 <accept@plt>
    b218:	85 c0                	test   %eax,%eax
    b21a:	0f 88 10 01 00 00    	js     b330 <fwp_pipe_poll+0x160>
    b220:	89 c3                	mov    %eax,%ebx
    b222:	8b 3d 90 ba 00 00    	mov    0xba90(%rip),%edi        # 16cb8 <fwp_po_listen>
    b228:	e8 03 80 ff ff       	call   3230 <close@plt>
    b22d:	c7 05 81 ba 00 00 ff 	movl   $0xffffffff,0xba81(%rip)        # 16cb8 <fwp_po_listen>
    b234:	ff ff ff 
    b237:	89 df                	mov    %ebx,%edi
    b239:	be 02 00 00 00       	mov    $0x2,%esi
    b23e:	ba 01 00 00 00       	mov    $0x1,%edx
    b243:	31 c0                	xor    %eax,%eax
    b245:	e8 d6 7e ff ff       	call   3120 <fcntl@plt>
    b24a:	89 df                	mov    %ebx,%edi
    b24c:	be 03 00 00 00       	mov    $0x3,%esi
    b251:	31 c0                	xor    %eax,%eax
    b253:	e8 c8 7e ff ff       	call   3120 <fcntl@plt>
    b258:	25 ff f7 ff ff       	and    $0xfffff7ff,%eax
    b25d:	89 df                	mov    %ebx,%edi
    b25f:	be 04 00 00 00       	mov    $0x4,%esi
    b264:	89 c2                	mov    %eax,%edx
    b266:	31 c0                	xor    %eax,%eax
    b268:	e8 b3 7e ff ff       	call   3120 <fcntl@plt>
    b26d:	c7 44 24 18 0c 00 00 	movl   $0xc,0x18(%rsp)
    b274:	00 
    b275:	89 5c 24 10          	mov    %ebx,0x10(%rsp)
    b279:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%rsp)
    b280:	00 
    b281:	48 8d 4c 24 1c       	lea    0x1c(%rsp),%rcx
    b286:	4c 8d 44 24 18       	lea    0x18(%rsp),%r8
    b28b:	89 df                	mov    %ebx,%edi
    b28d:	be 01 00 00 00       	mov    $0x1,%esi
    b292:	ba 11 00 00 00       	mov    $0x11,%edx
    b297:	e8 04 80 ff ff       	call   32a0 <getsockopt@plt>
    b29c:	85 c0                	test   %eax,%eax
    b29e:	0f 85 c3 00 00 00    	jne    b367 <fwp_pipe_poll+0x197>
    b2a4:	8b 6c 24 20          	mov    0x20(%rsp),%ebp
    b2a8:	e8 d3 7e ff ff       	call   3180 <getuid@plt>
    b2ad:	39 c5                	cmp    %eax,%ebp
    b2af:	0f 85 b2 00 00 00    	jne    b367 <fwp_pipe_poll+0x197>
    b2b5:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    b2ba:	be 01 00 00 00       	mov    $0x1,%esi
    b2bf:	ba e8 03 00 00       	mov    $0x3e8,%edx
    b2c4:	e8 f7 80 ff ff       	call   33c0 <poll@plt>
    b2c9:	85 c0                	test   %eax,%eax
    b2cb:	0f 8e 96 00 00 00    	jle    b367 <fwp_pipe_poll+0x197>
    b2d1:	48 8d 74 24 03       	lea    0x3(%rsp),%rsi
    b2d6:	ba 05 00 00 00       	mov    $0x5,%edx
    b2db:	89 df                	mov    %ebx,%edi
    b2dd:	31 c9                	xor    %ecx,%ecx
    b2df:	e8 7c 7d ff ff       	call   3060 <recv@plt>
    b2e4:	48 85 c0             	test   %rax,%rax
    b2e7:	7e 7e                	jle    b367 <fwp_pipe_poll+0x197>
    b2e9:	49 89 c6             	mov    %rax,%r14
    b2ec:	4c 8d 7c 24 10       	lea    0x10(%rsp),%r15
    b2f1:	49 83 fe 04          	cmp    $0x4,%r14
    b2f5:	77 59                	ja     b350 <fwp_pipe_poll+0x180>
    b2f7:	be 01 00 00 00       	mov    $0x1,%esi
    b2fc:	4c 89 ff             	mov    %r15,%rdi
    b2ff:	ba e8 03 00 00       	mov    $0x3e8,%edx
    b304:	e8 b7 80 ff ff       	call   33c0 <poll@plt>
    b309:	85 c0                	test   %eax,%eax
    b30b:	7e 5a                	jle    b367 <fwp_pipe_poll+0x197>
    b30d:	4a 8d 34 34          	lea    (%rsp,%r14,1),%rsi
    b311:	48 83 c6 03          	add    $0x3,%rsi
    b315:	ba 05 00 00 00       	mov    $0x5,%edx
    b31a:	4c 29 f2             	sub    %r14,%rdx
    b31d:	89 df                	mov    %ebx,%edi
    b31f:	31 c9                	xor    %ecx,%ecx
    b321:	e8 3a 7d ff ff       	call   3060 <recv@plt>
    b326:	49 01 c6             	add    %rax,%r14
    b329:	48 85 c0             	test   %rax,%rax
    b32c:	7f c3                	jg     b2f1 <fwp_pipe_poll+0x121>
    b32e:	eb 37                	jmp    b367 <fwp_pipe_poll+0x197>
    b330:	4c 3b 35 01 c1 01 00 	cmp    0x1c101(%rip),%r14        # 27438 <fwp_po_give_up>
    b337:	7e 35                	jle    b36e <fwp_pipe_poll+0x19e>
    b339:	8b 3d 79 b9 00 00    	mov    0xb979(%rip),%edi        # 16cb8 <fwp_po_listen>
    b33f:	e8 ec 7e ff ff       	call   3230 <close@plt>
    b344:	c7 05 6a b9 00 00 ff 	movl   $0xffffffff,0xb96a(%rip)        # 16cb8 <fwp_po_listen>
    b34b:	ff ff ff 
    b34e:	eb 1e                	jmp    b36e <fwp_pipe_poll+0x19e>
    b350:	81 7c 24 03 46 57 50 	cmpl   $0x54505746,0x3(%rsp)
    b357:	54 
    b358:	75 0d                	jne    b367 <fwp_pipe_poll+0x197>
    b35a:	0f b6 44 24 07       	movzbl 0x7(%rsp),%eax
    b35f:	8d 48 fd             	lea    -0x3(%rax),%ecx
    b362:	80 f9 fd             	cmp    $0xfd,%cl
    b365:	77 12                	ja     b379 <fwp_pipe_poll+0x1a9>
    b367:	89 df                	mov    %ebx,%edi
    b369:	e8 c2 7e ff ff       	call   3230 <close@plt>
    b36e:	48 83 c4 28          	add    $0x28,%rsp
    b372:	5b                   	pop    %rbx
    b373:	41 5e                	pop    %r14
    b375:	41 5f                	pop    %r15
    b377:	5d                   	pop    %rbp
    b378:	c3                   	ret
    b379:	89 1d 3d b9 00 00    	mov    %ebx,0xb93d(%rip)        # 16cbc <fwp_po_sock>
    b37f:	bb 01 00 00 00       	mov    $0x1,%ebx
    b384:	3c 02                	cmp    $0x2,%al
    b386:	75 10                	jne    b398 <fwp_pipe_poll+0x1c8>
    b388:	e8 53 00 00 00       	call   b3e0 <fwp_po_make_ring>
    b38d:	83 f8 01             	cmp    $0x1,%eax
    b390:	bb 02 00 00 00       	mov    $0x2,%ebx
    b395:	83 db 00             	sbb    $0x0,%ebx
    b398:	c7 44 24 08 02 01 00 	movl   $0x102,0x8(%rsp)
    b39f:	00 
    b3a0:	c6 44 24 0c 00       	movb   $0x0,0xc(%rsp)
    b3a5:	88 5c 24 0d          	mov    %bl,0xd(%rsp)
    b3a9:	4c 8b 35 00 9c 00 00 	mov    0x9c00(%rip),%r14        # 14fb0 <stdout@GLIBC_2.2.5>
    b3b0:	49 8b 0e             	mov    (%r14),%rcx
    b3b3:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    b3b8:	be 01 00 00 00       	mov    $0x1,%esi
    b3bd:	ba 06 00 00 00       	mov    $0x6,%edx
    b3c2:	e8 d9 80 ff ff       	call   34a0 <fwrite@plt>
    b3c7:	49 8b 3e             	mov    (%r14),%rdi
    b3ca:	e8 81 7f ff ff       	call   3350 <fflush@plt>
    b3cf:	89 1d 6b c0 01 00    	mov    %ebx,0x1c06b(%rip)        # 27440 <fwp_po_kind>
    b3d5:	eb 97                	jmp    b36e <fwp_pipe_poll+0x19e>
    b3d7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    b3de:	00 00 

000000000000b3e0 <fwp_po_make_ring>:
    b3e0:	55                   	push   %rbp
    b3e1:	41 57                	push   %r15
    b3e3:	41 56                	push   %r14
    b3e5:	53                   	push   %rbx
    b3e6:	48 83 ec 68          	sub    $0x68,%rsp
    b3ea:	48 8d 35 35 50 00 00 	lea    0x5035(%rip),%rsi        # 10426 <exec_in_fp0+0xd26>
    b3f1:	31 ed                	xor    %ebp,%ebp
    b3f3:	bf 3f 01 00 00       	mov    $0x13f,%edi
    b3f8:	ba 01 00 00 00       	mov    $0x1,%edx
    b3fd:	31 c0                	xor    %eax,%eax
    b3ff:	e8 fc 7e ff ff       	call   3300 <syscall@plt>
    b404:	48 89 c3             	mov    %rax,%rbx
    b407:	85 db                	test   %ebx,%ebx
    b409:	78 17                	js     b422 <fwp_po_make_ring+0x42>
    b40b:	be 00 10 10 00       	mov    $0x101000,%esi
    b410:	89 df                	mov    %ebx,%edi
    b412:	e8 c9 7d ff ff       	call   31e0 <ftruncate@plt>
    b417:	85 c0                	test   %eax,%eax
    b419:	74 14                	je     b42f <fwp_po_make_ring+0x4f>
    b41b:	89 df                	mov    %ebx,%edi
    b41d:	e8 0e 7e ff ff       	call   3230 <close@plt>
    b422:	89 e8                	mov    %ebp,%eax
    b424:	48 83 c4 68          	add    $0x68,%rsp
    b428:	5b                   	pop    %rbx
    b429:	41 5e                	pop    %r14
    b42b:	41 5f                	pop    %r15
    b42d:	5d                   	pop    %rbp
    b42e:	c3                   	ret
    b42f:	be 00 10 10 00       	mov    $0x101000,%esi
    b434:	31 ff                	xor    %edi,%edi
    b436:	ba 03 00 00 00       	mov    $0x3,%edx
    b43b:	b9 01 00 00 00       	mov    $0x1,%ecx
    b440:	41 89 d8             	mov    %ebx,%r8d
    b443:	45 31 c9             	xor    %r9d,%r9d
    b446:	e8 45 7d ff ff       	call   3190 <mmap@plt>
    b44b:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    b44f:	74 ca                	je     b41b <fwp_po_make_ring+0x3b>
    b451:	49 89 c6             	mov    %rax,%r14
    b454:	48 b8 46 57 50 53 01 	movabs $0x153505746,%rax
    b45b:	00 00 00 
    b45e:	49 89 06             	mov    %rax,(%r14)
    b461:	49 c7 46 08 00 00 10 	movq   $0x100000,0x8(%r14)
    b468:	00 
    b469:	c6 44 24 07 53       	movb   $0x53,0x7(%rsp)
    b46e:	48 8d 44 24 07       	lea    0x7(%rsp),%rax
    b473:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    b478:	48 c7 44 24 28 01 00 	movq   $0x1,0x28(%rsp)
    b47f:	00 00 
    b481:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
    b488:	00 00 
    b48a:	0f 57 c0             	xorps  %xmm0,%xmm0
    b48d:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    b492:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
    b497:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    b49c:	48 c7 44 24 60 00 00 	movq   $0x0,0x60(%rsp)
    b4a3:	00 00 
    b4a5:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    b4aa:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    b4af:	48 c7 44 24 48 01 00 	movq   $0x1,0x48(%rsp)
    b4b6:	00 00 
    b4b8:	48 8d 44 24 08       	lea    0x8(%rsp),%rax
    b4bd:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    b4c2:	48 c7 44 24 58 18 00 	movq   $0x18,0x58(%rsp)
    b4c9:	00 00 
    b4cb:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
    b4d2:	00 00 00 
    b4d5:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    b4da:	48 c7 44 24 08 14 00 	movq   $0x14,0x8(%rsp)
    b4e1:	00 00 
    b4e3:	89 5c 24 18          	mov    %ebx,0x18(%rsp)
    b4e7:	8b 3d cf b7 00 00    	mov    0xb7cf(%rip),%edi        # 16cbc <fwp_po_sock>
    b4ed:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
    b4f2:	ba 00 40 00 00       	mov    $0x4000,%edx
    b4f7:	e8 c4 7b ff ff       	call   30c0 <sendmsg@plt>
    b4fc:	49 89 c7             	mov    %rax,%r15
    b4ff:	89 df                	mov    %ebx,%edi
    b501:	e8 2a 7d ff ff       	call   3230 <close@plt>
    b506:	49 83 ff 01          	cmp    $0x1,%r15
    b50a:	75 11                	jne    b51d <fwp_po_make_ring+0x13d>
    b50c:	4c 89 35 3d bf 02 00 	mov    %r14,0x2bf3d(%rip)        # 37450 <fwp_po_ring>
    b513:	bd 01 00 00 00       	mov    $0x1,%ebp
    b518:	e9 05 ff ff ff       	jmp    b422 <fwp_po_make_ring+0x42>
    b51d:	be 00 10 10 00       	mov    $0x101000,%esi
    b522:	4c 89 f7             	mov    %r14,%rdi
    b525:	e8 66 7e ff ff       	call   3390 <munmap@plt>
    b52a:	31 ed                	xor    %ebp,%ebp
    b52c:	e9 f1 fe ff ff       	jmp    b422 <fwp_po_make_ring+0x42>
    b531:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b538:	0f 1f 84 00 00 00 00 
    b53f:	00 

000000000000b540 <fwp_apply>:
    b540:	55                   	push   %rbp
    b541:	48 89 e5             	mov    %rsp,%rbp
    b544:	41 57                	push   %r15
    b546:	41 56                	push   %r14
    b548:	41 55                	push   %r13
    b54a:	41 54                	push   %r12
    b54c:	53                   	push   %rbx
    b54d:	48 83 ec 18          	sub    $0x18,%rsp
    b551:	48 89 f3             	mov    %rsi,%rbx
    b554:	49 89 ff             	mov    %rdi,%r15
    b557:	be 01 00 00 00       	mov    $0x1,%esi
    b55c:	eb 1e                	jmp    b57c <fwp_apply+0x3c>
    b55e:	66 90                	xchg   %ax,%ax
    b560:	4a 8d 1c f3          	lea    (%rbx,%r14,8),%rbx
    b564:	31 c9                	xor    %ecx,%ecx
    b566:	49 89 c7             	mov    %rax,%r15
    b569:	4c 8b 75 c8          	mov    -0x38(%rbp),%r14
    b56d:	48 8b 65 c0          	mov    -0x40(%rbp),%rsp
    b571:	89 d6                	mov    %edx,%esi
    b573:	83 f9 01             	cmp    $0x1,%ecx
    b576:	0f 84 ff 03 00 00    	je     b97b <fwp_apply+0x43b>
    b57c:	48 8b 05 1d be 00 00 	mov    0xbe1d(%rip),%rax        # 173a0 <fwp_fns>
    b583:	41 8b 0f             	mov    (%r15),%ecx
    b586:	45 8b 67 04          	mov    0x4(%r15),%r12d
    b58a:	48 c1 e1 05          	shl    $0x5,%rcx
    b58e:	44 8b 2c 08          	mov    (%rax,%rcx,1),%r13d
    b592:	4d 85 e4             	test   %r12,%r12
    b595:	75 39                	jne    b5d0 <fwp_apply+0x90>
    b597:	41 8d 55 ff          	lea    -0x1(%r13),%edx
    b59b:	39 f2                	cmp    %esi,%edx
    b59d:	73 31                	jae    b5d0 <fwp_apply+0x90>
    b59f:	49 89 f7             	mov    %rsi,%r15
    b5a2:	48 89 df             	mov    %rbx,%rdi
    b5a5:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    b5a9:	4c 89 fe             	mov    %r15,%rsi
    b5ac:	49 89 c7             	mov    %rax,%r15
    b5af:	44 39 ee             	cmp    %r13d,%esi
    b5b2:	0f 84 c0 03 00 00    	je     b978 <fwp_apply+0x438>
    b5b8:	4a 8d 1c eb          	lea    (%rbx,%r13,8),%rbx
    b5bc:	44 29 ee             	sub    %r13d,%esi
    b5bf:	b9 03 00 00 00       	mov    $0x3,%ecx
    b5c4:	83 f9 01             	cmp    $0x1,%ecx
    b5c7:	75 b3                	jne    b57c <fwp_apply+0x3c>
    b5c9:	e9 ad 03 00 00       	jmp    b97b <fwp_apply+0x43b>
    b5ce:	66 90                	xchg   %ax,%ax
    b5d0:	4c 89 75 c8          	mov    %r14,-0x38(%rbp)
    b5d4:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    b5d8:	45 8d 34 34          	lea    (%r12,%rsi,1),%r14d
    b5dc:	45 39 ee             	cmp    %r13d,%r14d
    b5df:	0f 82 1a 02 00 00    	jb     b7ff <fwp_apply+0x2bf>
    b5e5:	48 89 65 c0          	mov    %rsp,-0x40(%rbp)
    b5e9:	45 89 eb             	mov    %r13d,%r11d
    b5ec:	41 83 fd 02          	cmp    $0x2,%r13d
    b5f0:	ba 01 00 00 00       	mov    $0x1,%edx
    b5f5:	41 0f 43 d5          	cmovae %r13d,%edx
    b5f9:	48 8d 14 d5 0f 00 00 	lea    0xf(,%rdx,8),%rdx
    b600:	00 
    b601:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
    b605:	48 89 e7             	mov    %rsp,%rdi
    b608:	48 29 d7             	sub    %rdx,%rdi
    b60b:	48 89 fc             	mov    %rdi,%rsp
    b60e:	4d 85 e4             	test   %r12,%r12
    b611:	0f 84 c9 00 00 00    	je     b6e0 <fwp_apply+0x1a0>
    b617:	41 83 fc 04          	cmp    $0x4,%r12d
    b61b:	72 10                	jb     b62d <fwp_apply+0xed>
    b61d:	48 89 fa             	mov    %rdi,%rdx
    b620:	4c 29 fa             	sub    %r15,%rdx
    b623:	48 83 c2 f8          	add    $0xfffffffffffffff8,%rdx
    b627:	48 83 fa 20          	cmp    $0x20,%rdx
    b62b:	73 65                	jae    b692 <fwp_apply+0x152>
    b62d:	31 d2                	xor    %edx,%edx
    b62f:	4d 89 e0             	mov    %r12,%r8
    b632:	48 89 d6             	mov    %rdx,%rsi
    b635:	49 83 e0 03          	and    $0x3,%r8
    b639:	74 16                	je     b651 <fwp_apply+0x111>
    b63b:	48 89 d6             	mov    %rdx,%rsi
    b63e:	66 90                	xchg   %ax,%ax
    b640:	4d 8b 4c f7 08       	mov    0x8(%r15,%rsi,8),%r9
    b645:	4c 89 0c f7          	mov    %r9,(%rdi,%rsi,8)
    b649:	48 ff c6             	inc    %rsi
    b64c:	49 ff c8             	dec    %r8
    b64f:	75 ef                	jne    b640 <fwp_apply+0x100>
    b651:	4c 29 e2             	sub    %r12,%rdx
    b654:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    b658:	0f 87 82 00 00 00    	ja     b6e0 <fwp_apply+0x1a0>
    b65e:	66 90                	xchg   %ax,%ax
    b660:	49 8b 54 f7 08       	mov    0x8(%r15,%rsi,8),%rdx
    b665:	48 89 14 f7          	mov    %rdx,(%rdi,%rsi,8)
    b669:	49 8b 54 f7 10       	mov    0x10(%r15,%rsi,8),%rdx
    b66e:	48 89 54 f7 08       	mov    %rdx,0x8(%rdi,%rsi,8)
    b673:	49 8b 54 f7 18       	mov    0x18(%r15,%rsi,8),%rdx
    b678:	48 89 54 f7 10       	mov    %rdx,0x10(%rdi,%rsi,8)
    b67d:	49 8b 54 f7 20       	mov    0x20(%r15,%rsi,8),%rdx
    b682:	48 89 54 f7 18       	mov    %rdx,0x18(%rdi,%rsi,8)
    b687:	48 83 c6 04          	add    $0x4,%rsi
    b68b:	49 39 f4             	cmp    %rsi,%r12
    b68e:	75 d0                	jne    b660 <fwp_apply+0x120>
    b690:	eb 4e                	jmp    b6e0 <fwp_apply+0x1a0>
    b692:	44 89 e2             	mov    %r12d,%edx
    b695:	83 e2 fc             	and    $0xfffffffc,%edx
    b698:	4a 8d 34 e5 00 00 00 	lea    0x0(,%r12,8),%rsi
    b69f:	00 
    b6a0:	48 83 e6 e0          	and    $0xffffffffffffffe0,%rsi
    b6a4:	45 31 c0             	xor    %r8d,%r8d
    b6a7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    b6ae:	00 00 
    b6b0:	43 0f 10 44 07 08    	movups 0x8(%r15,%r8,1),%xmm0
    b6b6:	43 0f 10 4c 07 18    	movups 0x18(%r15,%r8,1),%xmm1
    b6bc:	42 0f 29 04 07       	movaps %xmm0,(%rdi,%r8,1)
    b6c1:	42 0f 29 4c 07 10    	movaps %xmm1,0x10(%rdi,%r8,1)
    b6c7:	49 83 c0 20          	add    $0x20,%r8
    b6cb:	4c 39 c6             	cmp    %r8,%rsi
    b6ce:	75 e0                	jne    b6b0 <fwp_apply+0x170>
    b6d0:	4c 39 e2             	cmp    %r12,%rdx
    b6d3:	0f 85 56 ff ff ff    	jne    b62f <fwp_apply+0xef>
    b6d9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    b6e0:	45 29 e3             	sub    %r12d,%r11d
    b6e3:	45 89 de             	mov    %r11d,%r14d
    b6e6:	45 39 e5             	cmp    %r12d,%r13d
    b6e9:	0f 84 85 00 00 00    	je     b774 <fwp_apply+0x234>
    b6ef:	41 83 fb 0e          	cmp    $0xe,%r11d
    b6f3:	0f 83 a0 00 00 00    	jae    b799 <fwp_apply+0x259>
    b6f9:	31 d2                	xor    %edx,%edx
    b6fb:	4d 89 f0             	mov    %r14,%r8
    b6fe:	48 89 d6             	mov    %rdx,%rsi
    b701:	49 83 e0 03          	and    $0x3,%r8
    b705:	74 1d                	je     b724 <fwp_apply+0x1e4>
    b707:	48 89 d6             	mov    %rdx,%rsi
    b70a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    b710:	4c 8b 0c f3          	mov    (%rbx,%rsi,8),%r9
    b714:	45 8d 14 34          	lea    (%r12,%rsi,1),%r10d
    b718:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    b71c:	48 ff c6             	inc    %rsi
    b71f:	49 ff c8             	dec    %r8
    b722:	75 ec                	jne    b710 <fwp_apply+0x1d0>
    b724:	4c 29 f2             	sub    %r14,%rdx
    b727:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    b72b:	77 47                	ja     b774 <fwp_apply+0x234>
    b72d:	0f 1f 00             	nopl   (%rax)
    b730:	48 8b 14 f3          	mov    (%rbx,%rsi,8),%rdx
    b734:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    b738:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b73c:	48 8b 54 f3 08       	mov    0x8(%rbx,%rsi,8),%rdx
    b741:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    b745:	41 ff c0             	inc    %r8d
    b748:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b74c:	48 8b 54 f3 10       	mov    0x10(%rbx,%rsi,8),%rdx
    b751:	45 8d 44 34 02       	lea    0x2(%r12,%rsi,1),%r8d
    b756:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b75a:	48 8b 54 f3 18       	mov    0x18(%rbx,%rsi,8),%rdx
    b75f:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    b763:	41 83 c0 03          	add    $0x3,%r8d
    b767:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b76b:	48 83 c6 04          	add    $0x4,%rsi
    b76f:	49 39 f6             	cmp    %rsi,%r14
    b772:	75 bc                	jne    b730 <fwp_apply+0x1f0>
    b774:	45 89 dc             	mov    %r11d,%r12d
    b777:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    b77b:	b9 01 00 00 00       	mov    $0x1,%ecx
    b780:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    b784:	89 f2                	mov    %esi,%edx
    b786:	44 29 e2             	sub    %r12d,%edx
    b789:	0f 85 d1 fd ff ff    	jne    b560 <fwp_apply+0x20>
    b78f:	89 f2                	mov    %esi,%edx
    b791:	49 89 c6             	mov    %rax,%r14
    b794:	e9 d4 fd ff ff       	jmp    b56d <fwp_apply+0x2d>
    b799:	49 8d 56 ff          	lea    -0x1(%r14),%rdx
    b79d:	89 d6                	mov    %edx,%esi
    b79f:	44 01 e6             	add    %r12d,%esi
    b7a2:	0f 82 51 ff ff ff    	jb     b6f9 <fwp_apply+0x1b9>
    b7a8:	48 c1 ea 20          	shr    $0x20,%rdx
    b7ac:	ba 00 00 00 00       	mov    $0x0,%edx
    b7b1:	0f 85 44 ff ff ff    	jne    b6fb <fwp_apply+0x1bb>
    b7b7:	4a 8d 14 e7          	lea    (%rdi,%r12,8),%rdx
    b7bb:	48 29 da             	sub    %rbx,%rdx
    b7be:	48 83 fa 20          	cmp    $0x20,%rdx
    b7c2:	0f 82 31 ff ff ff    	jb     b6f9 <fwp_apply+0x1b9>
    b7c8:	44 89 f2             	mov    %r14d,%edx
    b7cb:	83 e2 fc             	and    $0xfffffffc,%edx
    b7ce:	31 f6                	xor    %esi,%esi
    b7d0:	0f 10 04 f3          	movups (%rbx,%rsi,8),%xmm0
    b7d4:	0f 10 4c f3 10       	movups 0x10(%rbx,%rsi,8),%xmm1
    b7d9:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    b7dd:	42 0f 11 04 c7       	movups %xmm0,(%rdi,%r8,8)
    b7e2:	42 0f 11 4c c7 10    	movups %xmm1,0x10(%rdi,%r8,8)
    b7e8:	48 83 c6 04          	add    $0x4,%rsi
    b7ec:	48 39 f2             	cmp    %rsi,%rdx
    b7ef:	75 df                	jne    b7d0 <fwp_apply+0x290>
    b7f1:	4c 39 f2             	cmp    %r14,%rdx
    b7f4:	0f 85 01 ff ff ff    	jne    b6fb <fwp_apply+0x1bb>
    b7fa:	e9 75 ff ff ff       	jmp    b774 <fwp_apply+0x234>
    b7ff:	44 89 f0             	mov    %r14d,%eax
    b802:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    b809:	00 
    b80a:	e8 41 ad ff ff       	call   6550 <fwp_alloc>
    b80f:	41 8b 0f             	mov    (%r15),%ecx
    b812:	89 08                	mov    %ecx,(%rax)
    b814:	44 89 70 04          	mov    %r14d,0x4(%rax)
    b818:	49 89 c6             	mov    %rax,%r14
    b81b:	4d 85 e4             	test   %r12,%r12
    b81e:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    b822:	0f 84 b9 00 00 00    	je     b8e1 <fwp_apply+0x3a1>
    b828:	31 c0                	xor    %eax,%eax
    b82a:	41 83 fc 06          	cmp    $0x6,%r12d
    b82e:	72 46                	jb     b876 <fwp_apply+0x336>
    b830:	4c 89 f1             	mov    %r14,%rcx
    b833:	4c 29 f9             	sub    %r15,%rcx
    b836:	48 83 f9 20          	cmp    $0x20,%rcx
    b83a:	72 3a                	jb     b876 <fwp_apply+0x336>
    b83c:	44 89 e0             	mov    %r12d,%eax
    b83f:	83 e0 fc             	and    $0xfffffffc,%eax
    b842:	4a 8d 0c e5 00 00 00 	lea    0x0(,%r12,8),%rcx
    b849:	00 
    b84a:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    b84e:	31 d2                	xor    %edx,%edx
    b850:	41 0f 10 44 17 08    	movups 0x8(%r15,%rdx,1),%xmm0
    b856:	41 0f 10 4c 17 18    	movups 0x18(%r15,%rdx,1),%xmm1
    b85c:	41 0f 11 44 16 08    	movups %xmm0,0x8(%r14,%rdx,1)
    b862:	41 0f 11 4c 16 18    	movups %xmm1,0x18(%r14,%rdx,1)
    b868:	48 83 c2 20          	add    $0x20,%rdx
    b86c:	48 39 d1             	cmp    %rdx,%rcx
    b86f:	75 df                	jne    b850 <fwp_apply+0x310>
    b871:	4c 39 e0             	cmp    %r12,%rax
    b874:	74 6b                	je     b8e1 <fwp_apply+0x3a1>
    b876:	4c 89 e2             	mov    %r12,%rdx
    b879:	48 89 c1             	mov    %rax,%rcx
    b87c:	48 83 e2 03          	and    $0x3,%rdx
    b880:	74 20                	je     b8a2 <fwp_apply+0x362>
    b882:	48 89 c1             	mov    %rax,%rcx
    b885:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b88c:	00 00 00 00 
    b890:	49 8b 74 cf 08       	mov    0x8(%r15,%rcx,8),%rsi
    b895:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    b89a:	48 ff c1             	inc    %rcx
    b89d:	48 ff ca             	dec    %rdx
    b8a0:	75 ee                	jne    b890 <fwp_apply+0x350>
    b8a2:	4c 29 e0             	sub    %r12,%rax
    b8a5:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    b8a9:	77 36                	ja     b8e1 <fwp_apply+0x3a1>
    b8ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    b8b0:	49 8b 44 cf 08       	mov    0x8(%r15,%rcx,8),%rax
    b8b5:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    b8ba:	49 8b 44 cf 10       	mov    0x10(%r15,%rcx,8),%rax
    b8bf:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    b8c4:	49 8b 44 cf 18       	mov    0x18(%r15,%rcx,8),%rax
    b8c9:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    b8ce:	49 8b 44 cf 20       	mov    0x20(%r15,%rcx,8),%rax
    b8d3:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    b8d8:	48 83 c1 04          	add    $0x4,%rcx
    b8dc:	49 39 cc             	cmp    %rcx,%r12
    b8df:	75 cf                	jne    b8b0 <fwp_apply+0x370>
    b8e1:	85 ff                	test   %edi,%edi
    b8e3:	0f 84 92 00 00 00    	je     b97b <fwp_apply+0x43b>
    b8e9:	89 f8                	mov    %edi,%eax
    b8eb:	83 ff 14             	cmp    $0x14,%edi
    b8ee:	0f 83 99 00 00 00    	jae    b98d <fwp_apply+0x44d>
    b8f4:	31 c9                	xor    %ecx,%ecx
    b8f6:	48 89 c6             	mov    %rax,%rsi
    b8f9:	48 89 ca             	mov    %rcx,%rdx
    b8fc:	48 83 e6 03          	and    $0x3,%rsi
    b900:	74 23                	je     b925 <fwp_apply+0x3e5>
    b902:	48 89 ca             	mov    %rcx,%rdx
    b905:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b90c:	00 00 00 00 
    b910:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    b914:	45 8d 04 14          	lea    (%r12,%rdx,1),%r8d
    b918:	4b 89 7c c6 08       	mov    %rdi,0x8(%r14,%r8,8)
    b91d:	48 ff c2             	inc    %rdx
    b920:	48 ff ce             	dec    %rsi
    b923:	75 eb                	jne    b910 <fwp_apply+0x3d0>
    b925:	48 29 c1             	sub    %rax,%rcx
    b928:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    b92c:	77 4d                	ja     b97b <fwp_apply+0x43b>
    b92e:	66 90                	xchg   %ax,%ax
    b930:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    b934:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    b938:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    b93d:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    b942:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    b946:	ff c6                	inc    %esi
    b948:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    b94d:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    b952:	41 8d 74 14 02       	lea    0x2(%r12,%rdx,1),%esi
    b957:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    b95c:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    b961:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    b965:	83 c6 03             	add    $0x3,%esi
    b968:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    b96d:	48 83 c2 04          	add    $0x4,%rdx
    b971:	48 39 d0             	cmp    %rdx,%rax
    b974:	75 ba                	jne    b930 <fwp_apply+0x3f0>
    b976:	eb 03                	jmp    b97b <fwp_apply+0x43b>
    b978:	4d 89 fe             	mov    %r15,%r14
    b97b:	4c 89 f0             	mov    %r14,%rax
    b97e:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    b982:	5b                   	pop    %rbx
    b983:	41 5c                	pop    %r12
    b985:	41 5d                	pop    %r13
    b987:	41 5e                	pop    %r14
    b989:	41 5f                	pop    %r15
    b98b:	5d                   	pop    %rbp
    b98c:	c3                   	ret
    b98d:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    b991:	31 c9                	xor    %ecx,%ecx
    b993:	89 d6                	mov    %edx,%esi
    b995:	44 01 e6             	add    %r12d,%esi
    b998:	0f 82 58 ff ff ff    	jb     b8f6 <fwp_apply+0x3b6>
    b99e:	48 c1 ea 20          	shr    $0x20,%rdx
    b9a2:	0f 85 4e ff ff ff    	jne    b8f6 <fwp_apply+0x3b6>
    b9a8:	4b 8d 0c e6          	lea    (%r14,%r12,8),%rcx
    b9ac:	48 29 d9             	sub    %rbx,%rcx
    b9af:	48 83 c1 08          	add    $0x8,%rcx
    b9b3:	48 83 f9 20          	cmp    $0x20,%rcx
    b9b7:	0f 82 37 ff ff ff    	jb     b8f4 <fwp_apply+0x3b4>
    b9bd:	89 c1                	mov    %eax,%ecx
    b9bf:	83 e1 fc             	and    $0xfffffffc,%ecx
    b9c2:	31 d2                	xor    %edx,%edx
    b9c4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b9cb:	00 00 00 00 00 
    b9d0:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    b9d4:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    b9d9:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    b9dd:	41 0f 11 44 f6 08    	movups %xmm0,0x8(%r14,%rsi,8)
    b9e3:	41 0f 11 4c f6 18    	movups %xmm1,0x18(%r14,%rsi,8)
    b9e9:	48 83 c2 04          	add    $0x4,%rdx
    b9ed:	48 39 d1             	cmp    %rdx,%rcx
    b9f0:	75 de                	jne    b9d0 <fwp_apply+0x490>
    b9f2:	48 39 c1             	cmp    %rax,%rcx
    b9f5:	0f 85 fb fe ff ff    	jne    b8f6 <fwp_apply+0x3b6>
    b9fb:	e9 7b ff ff ff       	jmp    b97b <fwp_apply+0x43b>

000000000000ba00 <fwp_pap>:
    ba00:	50                   	push   %rax
    ba01:	bf 08 00 00 00       	mov    $0x8,%edi
    ba06:	e8 45 ab ff ff       	call   6550 <fwp_alloc>
    ba0b:	48 c7 00 02 00 00 00 	movq   $0x2,(%rax)
    ba12:	59                   	pop    %rcx
    ba13:	c3                   	ret
    ba14:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    ba1b:	00 00 00 00 00 

000000000000ba20 <fwp_exec_error>:
    ba20:	41 57                	push   %r15
    ba22:	41 56                	push   %r14
    ba24:	53                   	push   %rbx
    ba25:	48 89 f3             	mov    %rsi,%rbx
    ba28:	49 89 fe             	mov    %rdi,%r14
    ba2b:	e8 b0 bb ff ff       	call   75e0 <fwp_pipe_flush>
    ba30:	4c 8b 3d a1 95 00 00 	mov    0x95a1(%rip),%r15        # 14fd8 <stderr@GLIBC_2.2.5>
    ba37:	49 8b 3f             	mov    (%r15),%rdi
    ba3a:	48 8d 35 06 4a 00 00 	lea    0x4a06(%rip),%rsi        # 10447 <exec_in_fp0+0xd47>
    ba41:	48 8d 15 ad 3d 00 00 	lea    0x3dad(%rip),%rdx        # f7f5 <exec_in_fp0+0xf5>
    ba48:	31 c0                	xor    %eax,%eax
    ba4a:	e8 a1 78 ff ff       	call   32f0 <fprintf@plt>
    ba4f:	83 3b 10             	cmpl   $0x10,(%rbx)
    ba52:	75 1f                	jne    ba73 <fwp_exec_error+0x53>
    ba54:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    ba58:	48 85 ff             	test   %rdi,%rdi
    ba5b:	74 16                	je     ba73 <fwp_exec_error+0x53>
    ba5d:	48 8d 35 e8 49 00 00 	lea    0x49e8(%rip),%rsi        # 1044c <exec_in_fp0+0xd4c>
    ba64:	e8 67 78 ff ff       	call   32d0 <strcmp@plt>
    ba69:	85 c0                	test   %eax,%eax
    ba6b:	75 06                	jne    ba73 <fwp_exec_error+0x53>
    ba6d:	83 7b 10 02          	cmpl   $0x2,0x10(%rbx)
    ba71:	74 20                	je     ba93 <fwp_exec_error+0x73>
    ba73:	49 8b 17             	mov    (%r15),%rdx
    ba76:	4c 89 f7             	mov    %r14,%rdi
    ba79:	48 89 de             	mov    %rbx,%rsi
    ba7c:	e8 2f 00 00 00       	call   bab0 <fwp_display_top>
    ba81:	49 8b 37             	mov    (%r15),%rsi
    ba84:	bf 0a 00 00 00       	mov    $0xa,%edi
    ba89:	5b                   	pop    %rbx
    ba8a:	41 5e                	pop    %r14
    ba8c:	41 5f                	pop    %r15
    ba8e:	e9 ad 77 ff ff       	jmp    3240 <fputc@plt>
    ba93:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    ba97:	48 8b 17             	mov    (%rdi),%rdx
    ba9a:	48 83 c7 08          	add    $0x8,%rdi
    ba9e:	49 8b 0f             	mov    (%r15),%rcx
    baa1:	be 01 00 00 00       	mov    $0x1,%esi
    baa6:	e8 f5 79 ff ff       	call   34a0 <fwrite@plt>
    baab:	eb d4                	jmp    ba81 <fwp_exec_error+0x61>
    baad:	0f 1f 00             	nopl   (%rax)

000000000000bab0 <fwp_display_top>:
    bab0:	53                   	push   %rbx
    bab1:	48 83 ec 20          	sub    $0x20,%rsp
    bab5:	48 89 d3             	mov    %rdx,%rbx
    bab8:	48 89 f2             	mov    %rsi,%rdx
    babb:	48 89 fe             	mov    %rdi,%rsi
    babe:	0f 57 c0             	xorps  %xmm0,%xmm0
    bac1:	0f 29 04 24          	movaps %xmm0,(%rsp)
    bac5:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    bacc:	00 00 
    bace:	48 89 e7             	mov    %rsp,%rdi
    bad1:	b9 01 00 00 00       	mov    $0x1,%ecx
    bad6:	e8 35 00 00 00       	call   bb10 <fwp_write>
    badb:	48 8b 3c 24          	mov    (%rsp),%rdi
    badf:	48 85 ff             	test   %rdi,%rdi
    bae2:	74 18                	je     bafc <fwp_display_top+0x4c>
    bae4:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    bae9:	be 01 00 00 00       	mov    $0x1,%esi
    baee:	48 89 d9             	mov    %rbx,%rcx
    baf1:	e8 aa 79 ff ff       	call   34a0 <fwrite@plt>
    baf6:	48 8b 3c 24          	mov    (%rsp),%rdi
    bafa:	eb 02                	jmp    bafe <fwp_display_top+0x4e>
    bafc:	31 ff                	xor    %edi,%edi
    bafe:	e8 4d 75 ff ff       	call   3050 <free@plt>
    bb03:	48 83 c4 20          	add    $0x20,%rsp
    bb07:	5b                   	pop    %rbx
    bb08:	c3                   	ret
    bb09:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000bb10 <fwp_write>:
    bb10:	55                   	push   %rbp
    bb11:	41 57                	push   %r15
    bb13:	41 56                	push   %r14
    bb15:	41 55                	push   %r13
    bb17:	41 54                	push   %r12
    bb19:	53                   	push   %rbx
    bb1a:	48 81 ec 28 02 00 00 	sub    $0x228,%rsp
    bb21:	8b 02                	mov    (%rdx),%eax
    bb23:	48 83 f8 19          	cmp    $0x19,%rax
    bb27:	0f 87 3f 05 00 00    	ja     c06c <fwp_write+0x55c>
    bb2d:	49 89 f5             	mov    %rsi,%r13
    bb30:	48 89 fb             	mov    %rdi,%rbx
    bb33:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
    bb38:	48 8d 15 05 38 00 00 	lea    0x3805(%rip),%rdx        # f344 <_IO_stdin_used+0x344>
    bb3f:	48 63 34 82          	movslq (%rdx,%rax,4),%rsi
    bb43:	48 01 d6             	add    %rdx,%rsi
    bb46:	ff e6                	jmp    *%rsi
    bb48:	48 8d 15 05 49 00 00 	lea    0x4905(%rip),%rdx        # 10454 <exec_in_fp0+0xd54>
    bb4f:	eb 07                	jmp    bb58 <fwp_write+0x48>
    bb51:	48 8d 15 c4 48 00 00 	lea    0x48c4(%rip),%rdx        # 1041c <exec_in_fp0+0xd1c>
    bb58:	4c 8d 7c 24 20       	lea    0x20(%rsp),%r15
    bb5d:	be 00 02 00 00       	mov    $0x200,%esi
    bb62:	4c 89 ff             	mov    %r15,%rdi
    bb65:	4c 89 e9             	mov    %r13,%rcx
    bb68:	31 c0                	xor    %eax,%eax
    bb6a:	e8 61 76 ff ff       	call   31d0 <snprintf@plt>
    bb6f:	48 89 df             	mov    %rbx,%rdi
    bb72:	4c 89 fe             	mov    %r15,%rsi
    bb75:	e9 ed 04 00 00       	jmp    c067 <fwp_write+0x557>
    bb7a:	83 f8 13             	cmp    $0x13,%eax
    bb7d:	48 8d 05 01 49 00 00 	lea    0x4901(%rip),%rax        # 10485 <exec_in_fp0+0xd85>
    bb84:	48 8d 35 ff 48 00 00 	lea    0x48ff(%rip),%rsi        # 1048a <exec_in_fp0+0xd8a>
    bb8b:	48 0f 44 f0          	cmove  %rax,%rsi
    bb8f:	48 89 df             	mov    %rbx,%rdi
    bb92:	e8 19 ca ff ff       	call   85b0 <buf_puts>
    bb97:	49 83 7d 00 00       	cmpq   $0x0,0x0(%r13)
    bb9c:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    bba1:	0f 84 cb 00 00 00    	je     bc72 <fwp_write+0x162>
    bba7:	4d 89 ec             	mov    %r13,%r12
    bbaa:	48 8b 50 38          	mov    0x38(%rax),%rdx
    bbae:	48 89 df             	mov    %rbx,%rdi
    bbb1:	4c 89 eb             	mov    %r13,%rbx
    bbb4:	49 8b 74 24 08       	mov    0x8(%r12),%rsi
    bbb9:	49 89 c6             	mov    %rax,%r14
    bbbc:	49 89 ff             	mov    %rdi,%r15
    bbbf:	31 c9                	xor    %ecx,%ecx
    bbc1:	e8 4a ff ff ff       	call   bb10 <fwp_write>
    bbc6:	41 83 3e 12          	cmpl   $0x12,(%r14)
    bbca:	75 29                	jne    bbf5 <fwp_write+0xe5>
    bbcc:	48 8d 35 76 48 00 00 	lea    0x4876(%rip),%rsi        # 10449 <exec_in_fp0+0xd49>
    bbd3:	4d 89 fe             	mov    %r15,%r14
    bbd6:	4c 89 ff             	mov    %r15,%rdi
    bbd9:	e8 d2 c9 ff ff       	call   85b0 <buf_puts>
    bbde:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    bbe2:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    bbe7:	48 8b 50 40          	mov    0x40(%rax),%rdx
    bbeb:	4c 89 ff             	mov    %r15,%rdi
    bbee:	31 c9                	xor    %ecx,%ecx
    bbf0:	e8 1b ff ff ff       	call   bb10 <fwp_write>
    bbf5:	48 83 3b 02          	cmpq   $0x2,(%rbx)
    bbf9:	4c 89 fb             	mov    %r15,%rbx
    bbfc:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    bc01:	72 6f                	jb     bc72 <fwp_write+0x162>
    bc03:	4d 8d 74 24 20       	lea    0x20(%r12),%r14
    bc08:	bd 01 00 00 00       	mov    $0x1,%ebp
    bc0d:	4c 8d 2d 8f 47 00 00 	lea    0x478f(%rip),%r13        # 103a3 <exec_in_fp0+0xca3>
    bc14:	eb 17                	jmp    bc2d <fwp_write+0x11d>
    bc16:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    bc1d:	00 00 00 
    bc20:	48 ff c5             	inc    %rbp
    bc23:	49 83 c6 10          	add    $0x10,%r14
    bc27:	49 3b 2c 24          	cmp    (%r12),%rbp
    bc2b:	73 45                	jae    bc72 <fwp_write+0x162>
    bc2d:	48 89 df             	mov    %rbx,%rdi
    bc30:	4c 89 ee             	mov    %r13,%rsi
    bc33:	e8 78 c9 ff ff       	call   85b0 <buf_puts>
    bc38:	49 8b 76 f8          	mov    -0x8(%r14),%rsi
    bc3c:	49 8b 57 38          	mov    0x38(%r15),%rdx
    bc40:	48 89 df             	mov    %rbx,%rdi
    bc43:	31 c9                	xor    %ecx,%ecx
    bc45:	e8 c6 fe ff ff       	call   bb10 <fwp_write>
    bc4a:	41 83 3f 12          	cmpl   $0x12,(%r15)
    bc4e:	75 d0                	jne    bc20 <fwp_write+0x110>
    bc50:	48 89 df             	mov    %rbx,%rdi
    bc53:	48 8d 35 ef 47 00 00 	lea    0x47ef(%rip),%rsi        # 10449 <exec_in_fp0+0xd49>
    bc5a:	e8 51 c9 ff ff       	call   85b0 <buf_puts>
    bc5f:	49 8b 36             	mov    (%r14),%rsi
    bc62:	49 8b 57 40          	mov    0x40(%r15),%rdx
    bc66:	48 89 df             	mov    %rbx,%rdi
    bc69:	31 c9                	xor    %ecx,%ecx
    bc6b:	e8 a0 fe ff ff       	call   bb10 <fwp_write>
    bc70:	eb ae                	jmp    bc20 <fwp_write+0x110>
    bc72:	48 89 df             	mov    %rbx,%rdi
    bc75:	be 7d 00 00 00       	mov    $0x7d,%esi
    bc7a:	e9 48 05 00 00       	jmp    c1c7 <fwp_write+0x6b7>
    bc7f:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    bc84:	4d 8b 67 08          	mov    0x8(%r15),%r12
    bc88:	4d 85 e4             	test   %r12,%r12
    bc8b:	0f 84 38 04 00 00    	je     c0c9 <fwp_write+0x5b9>
    bc91:	48 8d 35 28 47 00 00 	lea    0x4728(%rip),%rsi        # 103c0 <exec_in_fp0+0xcc0>
    bc98:	4c 89 e7             	mov    %r12,%rdi
    bc9b:	e8 30 76 ff ff       	call   32d0 <strcmp@plt>
    bca0:	85 c0                	test   %eax,%eax
    bca2:	0f 84 44 05 00 00    	je     c1ec <fwp_write+0x6dc>
    bca8:	4d 8d 77 10          	lea    0x10(%r15),%r14
    bcac:	48 89 df             	mov    %rbx,%rdi
    bcaf:	4c 89 e6             	mov    %r12,%rsi
    bcb2:	e8 f9 c8 ff ff       	call   85b0 <buf_puts>
    bcb7:	48 89 df             	mov    %rbx,%rdi
    bcba:	be 20 00 00 00       	mov    $0x20,%esi
    bcbf:	e8 cc c8 ff ff       	call   8590 <buf_putc>
    bcc4:	31 ed                	xor    %ebp,%ebp
    bcc6:	e9 1f 04 00 00       	jmp    c0ea <fwp_write+0x5da>
    bccb:	4c 89 ef             	mov    %r13,%rdi
    bcce:	e8 cd ef ff ff       	call   aca0 <fwp_tag>
    bcd3:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    bcd8:	49 8b 4f 18          	mov    0x18(%r15),%rcx
    bcdc:	41 89 c6             	mov    %eax,%r14d
    bcdf:	4a 8b 34 f1          	mov    (%rcx,%r14,8),%rsi
    bce3:	48 89 df             	mov    %rbx,%rdi
    bce6:	e8 c5 c8 ff ff       	call   85b0 <buf_puts>
    bceb:	49 8b 47 28          	mov    0x28(%r15),%rax
    bcef:	42 83 3c b0 00       	cmpl   $0x0,(%rax,%r14,4)
    bcf4:	0f 8e 72 03 00 00    	jle    c06c <fwp_write+0x55c>
    bcfa:	4c 89 f1             	mov    %r14,%rcx
    bcfd:	45 31 f6             	xor    %r14d,%r14d
    bd00:	4c 89 6c 24 18       	mov    %r13,0x18(%rsp)
    bd05:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
    bd0a:	eb 3d                	jmp    bd49 <fwp_write+0x239>
    bd0c:	0f 1f 40 00          	nopl   0x0(%rax)
    bd10:	48 89 dd             	mov    %rbx,%rbp
    bd13:	48 89 df             	mov    %rbx,%rdi
    bd16:	4c 89 e6             	mov    %r12,%rsi
    bd19:	4c 89 ea             	mov    %r13,%rdx
    bd1c:	31 c9                	xor    %ecx,%ecx
    bd1e:	e8 ed fd ff ff       	call   bb10 <fwp_write>
    bd23:	49 ff c6             	inc    %r14
    bd26:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    bd2b:	49 8b 47 28          	mov    0x28(%r15),%rax
    bd2f:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    bd34:	48 63 04 88          	movslq (%rax,%rcx,4),%rax
    bd38:	49 39 c6             	cmp    %rax,%r14
    bd3b:	4c 8b 6c 24 18       	mov    0x18(%rsp),%r13
    bd40:	48 89 eb             	mov    %rbp,%rbx
    bd43:	0f 8d 23 03 00 00    	jge    c06c <fwp_write+0x55c>
    bd49:	4f 8b 64 f5 08       	mov    0x8(%r13,%r14,8),%r12
    bd4e:	49 8b 47 30          	mov    0x30(%r15),%rax
    bd52:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    bd56:	4e 8b 2c f0          	mov    (%rax,%r14,8),%r13
    bd5a:	48 89 df             	mov    %rbx,%rdi
    bd5d:	be 20 00 00 00       	mov    $0x20,%esi
    bd62:	e8 29 c8 ff ff       	call   8590 <buf_putc>
    bd67:	4c 89 e7             	mov    %r12,%rdi
    bd6a:	4c 89 ee             	mov    %r13,%rsi
    bd6d:	e8 8e 0e 00 00       	call   cc00 <fwp_needs_parens>
    bd72:	85 c0                	test   %eax,%eax
    bd74:	74 9a                	je     bd10 <fwp_write+0x200>
    bd76:	48 89 df             	mov    %rbx,%rdi
    bd79:	be 28 00 00 00       	mov    $0x28,%esi
    bd7e:	e8 0d c8 ff ff       	call   8590 <buf_putc>
    bd83:	48 89 df             	mov    %rbx,%rdi
    bd86:	4c 89 e6             	mov    %r12,%rsi
    bd89:	4c 89 ea             	mov    %r13,%rdx
    bd8c:	31 c9                	xor    %ecx,%ecx
    bd8e:	e8 7d fd ff ff       	call   bb10 <fwp_write>
    bd93:	48 89 dd             	mov    %rbx,%rbp
    bd96:	48 89 df             	mov    %rbx,%rdi
    bd99:	be 29 00 00 00       	mov    $0x29,%esi
    bd9e:	e8 ed c7 ff ff       	call   8590 <buf_putc>
    bda3:	e9 7b ff ff ff       	jmp    bd23 <fwp_write+0x213>
    bda8:	4c 89 ef             	mov    %r13,%rdi
    bdab:	e8 60 85 ff ff       	call   4310 <fwp_f64>
    bdb0:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    bdb5:	4c 89 f7             	mov    %r14,%rdi
    bdb8:	e8 93 08 00 00       	call   c650 <fwp_fmt_f64>
    bdbd:	e9 9f 02 00 00       	jmp    c061 <fwp_write+0x551>
    bdc2:	48 89 df             	mov    %rbx,%rdi
    bdc5:	be 3c 00 00 00       	mov    $0x3c,%esi
    bdca:	e8 c1 c7 ff ff       	call   8590 <buf_putc>
    bdcf:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    bdd4:	48 8b 70 08          	mov    0x8(%rax),%rsi
    bdd8:	48 89 df             	mov    %rbx,%rdi
    bddb:	e9 d7 02 00 00       	jmp    c0b7 <fwp_write+0x5a7>
    bde0:	48 8d 35 7d 46 00 00 	lea    0x467d(%rip),%rsi        # 10464 <exec_in_fp0+0xd64>
    bde7:	e9 99 02 00 00       	jmp    c085 <fwp_write+0x575>
    bdec:	49 8d 75 08          	lea    0x8(%r13),%rsi
    bdf0:	49 8b 55 00          	mov    0x0(%r13),%rdx
    bdf4:	48 89 df             	mov    %rbx,%rdi
    bdf7:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    bdfe:	85 c9                	test   %ecx,%ecx
    be00:	0f 84 d7 03 00 00    	je     c1dd <fwp_write+0x6cd>
    be06:	5b                   	pop    %rbx
    be07:	41 5c                	pop    %r12
    be09:	41 5d                	pop    %r13
    be0b:	41 5e                	pop    %r14
    be0d:	41 5f                	pop    %r15
    be0f:	5d                   	pop    %rbp
    be10:	e9 cb c7 ff ff       	jmp    85e0 <buf_put>
    be15:	4c 89 ef             	mov    %r13,%rdi
    be18:	e8 43 ee ff ff       	call   ac60 <fwp_u128>
    be1d:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    be22:	4c 89 f7             	mov    %r14,%rdi
    be25:	48 89 c6             	mov    %rax,%rsi
    be28:	e8 13 04 00 00       	call   c240 <fwp_fmt_u128>
    be2d:	e9 2f 02 00 00       	jmp    c061 <fwp_write+0x551>
    be32:	4c 89 ef             	mov    %r13,%rdi
    be35:	e8 16 ee ff ff       	call   ac50 <fwp_i128>
    be3a:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    be3f:	4c 89 f7             	mov    %r14,%rdi
    be42:	48 89 c6             	mov    %rax,%rsi
    be45:	e8 d6 03 00 00       	call   c220 <fwp_fmt_i128>
    be4a:	e9 12 02 00 00       	jmp    c061 <fwp_write+0x551>
    be4f:	48 89 df             	mov    %rbx,%rdi
    be52:	be 5b 00 00 00       	mov    $0x5b,%esi
    be57:	e8 34 c7 ff ff       	call   8590 <buf_putc>
    be5c:	4d 85 ed             	test   %r13,%r13
    be5f:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    be64:	0f 84 d5 01 00 00    	je     c03f <fwp_write+0x52f>
    be6a:	49 8b 57 38          	mov    0x38(%r15),%rdx
    be6e:	49 8b 75 08          	mov    0x8(%r13),%rsi
    be72:	48 89 df             	mov    %rbx,%rdi
    be75:	31 c9                	xor    %ecx,%ecx
    be77:	e8 94 fc ff ff       	call   bb10 <fwp_write>
    be7c:	4d 8b 65 10          	mov    0x10(%r13),%r12
    be80:	4d 85 e4             	test   %r12,%r12
    be83:	0f 84 b6 01 00 00    	je     c03f <fwp_write+0x52f>
    be89:	4c 8d 35 13 45 00 00 	lea    0x4513(%rip),%r14        # 103a3 <exec_in_fp0+0xca3>
    be90:	48 89 df             	mov    %rbx,%rdi
    be93:	4c 89 f6             	mov    %r14,%rsi
    be96:	e8 15 c7 ff ff       	call   85b0 <buf_puts>
    be9b:	49 8b 74 24 08       	mov    0x8(%r12),%rsi
    bea0:	49 8b 57 38          	mov    0x38(%r15),%rdx
    bea4:	48 89 df             	mov    %rbx,%rdi
    bea7:	31 c9                	xor    %ecx,%ecx
    bea9:	e8 62 fc ff ff       	call   bb10 <fwp_write>
    beae:	4d 8b 64 24 10       	mov    0x10(%r12),%r12
    beb3:	4d 85 e4             	test   %r12,%r12
    beb6:	75 d8                	jne    be90 <fwp_write+0x380>
    beb8:	e9 82 01 00 00       	jmp    c03f <fwp_write+0x52f>
    bebd:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    bec2:	8b 50 48             	mov    0x48(%rax),%edx
    bec5:	48 89 df             	mov    %rbx,%rdi
    bec8:	4c 89 ee             	mov    %r13,%rsi
    becb:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    bed2:	5b                   	pop    %rbx
    bed3:	41 5c                	pop    %r12
    bed5:	41 5d                	pop    %r13
    bed7:	41 5e                	pop    %r14
    bed9:	41 5f                	pop    %r15
    bedb:	5d                   	pop    %rbp
    bedc:	e9 2f 08 00 00       	jmp    c710 <fwp_trits>
    bee1:	49 83 fd ff          	cmp    $0xffffffffffffffff,%r13
    bee5:	48 8d 05 c3 44 00 00 	lea    0x44c3(%rip),%rax        # 103af <exec_in_fp0+0xcaf>
    beec:	48 8d 0d b8 45 00 00 	lea    0x45b8(%rip),%rcx        # 104ab <exec_in_fp0+0xdab>
    bef3:	48 0f 44 c8          	cmove  %rax,%rcx
    bef7:	49 83 fd 01          	cmp    $0x1,%r13
    befb:	48 8d 35 aa 44 00 00 	lea    0x44aa(%rip),%rsi        # 103ac <exec_in_fp0+0xcac>
    bf02:	48 0f 45 f1          	cmovne %rcx,%rsi
    bf06:	e9 7a 01 00 00       	jmp    c085 <fwp_write+0x575>
    bf0b:	48 8d 35 6c 45 00 00 	lea    0x456c(%rip),%rsi        # 1047e <exec_in_fp0+0xd7e>
    bf12:	48 89 df             	mov    %rbx,%rdi
    bf15:	e8 96 c6 ff ff       	call   85b0 <buf_puts>
    bf1a:	49 83 7d 00 00       	cmpq   $0x0,0x0(%r13)
    bf1f:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    bf24:	0f 84 15 01 00 00    	je     c03f <fwp_write+0x52f>
    bf2a:	49 8b 57 38          	mov    0x38(%r15),%rdx
    bf2e:	49 8b 75 08          	mov    0x8(%r13),%rsi
    bf32:	48 89 df             	mov    %rbx,%rdi
    bf35:	31 c9                	xor    %ecx,%ecx
    bf37:	e8 d4 fb ff ff       	call   bb10 <fwp_write>
    bf3c:	49 83 7d 00 02       	cmpq   $0x2,0x0(%r13)
    bf41:	0f 82 f8 00 00 00    	jb     c03f <fwp_write+0x52f>
    bf47:	41 be 01 00 00 00    	mov    $0x1,%r14d
    bf4d:	4c 8d 25 4f 44 00 00 	lea    0x444f(%rip),%r12        # 103a3 <exec_in_fp0+0xca3>
    bf54:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    bf5b:	00 00 00 00 00 
    bf60:	48 89 df             	mov    %rbx,%rdi
    bf63:	4c 89 e6             	mov    %r12,%rsi
    bf66:	e8 45 c6 ff ff       	call   85b0 <buf_puts>
    bf6b:	4b 8b 74 f5 08       	mov    0x8(%r13,%r14,8),%rsi
    bf70:	49 8b 57 38          	mov    0x38(%r15),%rdx
    bf74:	48 89 df             	mov    %rbx,%rdi
    bf77:	31 c9                	xor    %ecx,%ecx
    bf79:	e8 92 fb ff ff       	call   bb10 <fwp_write>
    bf7e:	49 ff c6             	inc    %r14
    bf81:	4d 3b 75 00          	cmp    0x0(%r13),%r14
    bf85:	72 d9                	jb     bf60 <fwp_write+0x450>
    bf87:	e9 b3 00 00 00       	jmp    c03f <fwp_write+0x52f>
    bf8c:	48 8d 35 e1 44 00 00 	lea    0x44e1(%rip),%rsi        # 10474 <exec_in_fp0+0xd74>
    bf93:	48 89 df             	mov    %rbx,%rdi
    bf96:	e8 15 c6 ff ff       	call   85b0 <buf_puts>
    bf9b:	49 83 7d 00 00       	cmpq   $0x0,0x0(%r13)
    bfa0:	0f 84 99 00 00 00    	je     c03f <fwp_write+0x52f>
    bfa6:	4c 89 ed             	mov    %r13,%rbp
    bfa9:	41 0f b6 4d 08       	movzbl 0x8(%r13),%ecx
    bfae:	48 8d 15 c6 44 00 00 	lea    0x44c6(%rip),%rdx        # 1047b <exec_in_fp0+0xd7b>
    bfb5:	4c 8d 7c 24 20       	lea    0x20(%rsp),%r15
    bfba:	be 00 02 00 00       	mov    $0x200,%esi
    bfbf:	4c 89 ff             	mov    %r15,%rdi
    bfc2:	31 c0                	xor    %eax,%eax
    bfc4:	e8 07 72 ff ff       	call   31d0 <snprintf@plt>
    bfc9:	48 89 df             	mov    %rbx,%rdi
    bfcc:	4c 89 fe             	mov    %r15,%rsi
    bfcf:	e8 dc c5 ff ff       	call   85b0 <buf_puts>
    bfd4:	49 83 7d 00 02       	cmpq   $0x2,0x0(%r13)
    bfd9:	72 64                	jb     c03f <fwp_write+0x52f>
    bfdb:	41 be 09 00 00 00    	mov    $0x9,%r14d
    bfe1:	4c 8d 3d bb 43 00 00 	lea    0x43bb(%rip),%r15        # 103a3 <exec_in_fp0+0xca3>
    bfe8:	4c 8d 25 8c 44 00 00 	lea    0x448c(%rip),%r12        # 1047b <exec_in_fp0+0xd7b>
    bfef:	4c 8d 6c 24 20       	lea    0x20(%rsp),%r13
    bff4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    bffb:	00 00 00 00 00 
    c000:	48 89 df             	mov    %rbx,%rdi
    c003:	4c 89 fe             	mov    %r15,%rsi
    c006:	e8 a5 c5 ff ff       	call   85b0 <buf_puts>
    c00b:	42 0f b6 4c 35 00    	movzbl 0x0(%rbp,%r14,1),%ecx
    c011:	be 00 02 00 00       	mov    $0x200,%esi
    c016:	4c 89 ef             	mov    %r13,%rdi
    c019:	4c 89 e2             	mov    %r12,%rdx
    c01c:	31 c0                	xor    %eax,%eax
    c01e:	e8 ad 71 ff ff       	call   31d0 <snprintf@plt>
    c023:	48 89 df             	mov    %rbx,%rdi
    c026:	4c 89 ee             	mov    %r13,%rsi
    c029:	e8 82 c5 ff ff       	call   85b0 <buf_puts>
    c02e:	49 8d 46 01          	lea    0x1(%r14),%rax
    c032:	49 83 c6 f9          	add    $0xfffffffffffffff9,%r14
    c036:	4c 3b 75 00          	cmp    0x0(%rbp),%r14
    c03a:	49 89 c6             	mov    %rax,%r14
    c03d:	72 c1                	jb     c000 <fwp_write+0x4f0>
    c03f:	48 89 df             	mov    %rbx,%rdi
    c042:	be 5d 00 00 00       	mov    $0x5d,%esi
    c047:	e9 7b 01 00 00       	jmp    c1c7 <fwp_write+0x6b7>
    c04c:	4c 89 ef             	mov    %r13,%rdi
    c04f:	e8 5c a2 ff ff       	call   62b0 <fwp_f32>
    c054:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    c059:	4c 89 f7             	mov    %r14,%rdi
    c05c:	e8 ef 03 00 00       	call   c450 <fwp_fmt_f32>
    c061:	48 89 df             	mov    %rbx,%rdi
    c064:	4c 89 f6             	mov    %r14,%rsi
    c067:	e8 44 c5 ff ff       	call   85b0 <buf_puts>
    c06c:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    c073:	5b                   	pop    %rbx
    c074:	41 5c                	pop    %r12
    c076:	41 5d                	pop    %r13
    c078:	41 5e                	pop    %r14
    c07a:	41 5f                	pop    %r15
    c07c:	5d                   	pop    %rbp
    c07d:	c3                   	ret
    c07e:	48 8d 35 d4 43 00 00 	lea    0x43d4(%rip),%rsi        # 10459 <exec_in_fp0+0xd59>
    c085:	48 89 df             	mov    %rbx,%rdi
    c088:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    c08f:	5b                   	pop    %rbx
    c090:	41 5c                	pop    %r12
    c092:	41 5d                	pop    %r13
    c094:	41 5e                	pop    %r14
    c096:	41 5f                	pop    %r15
    c098:	5d                   	pop    %rbp
    c099:	e9 12 c5 ff ff       	jmp    85b0 <buf_puts>
    c09e:	48 8d 35 c8 43 00 00 	lea    0x43c8(%rip),%rsi        # 1046d <exec_in_fp0+0xd6d>
    c0a5:	48 89 df             	mov    %rbx,%rdi
    c0a8:	e8 03 c5 ff ff       	call   85b0 <buf_puts>
    c0ad:	49 83 c5 10          	add    $0x10,%r13
    c0b1:	48 89 df             	mov    %rbx,%rdi
    c0b4:	4c 89 ee             	mov    %r13,%rsi
    c0b7:	e8 f4 c4 ff ff       	call   85b0 <buf_puts>
    c0bc:	48 89 df             	mov    %rbx,%rdi
    c0bf:	be 3e 00 00 00       	mov    $0x3e,%esi
    c0c4:	e9 fe 00 00 00       	jmp    c1c7 <fwp_write+0x6b7>
    c0c9:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    c0ce:	0f 84 35 01 00 00    	je     c209 <fwp_write+0x6f9>
    c0d4:	4d 8d 77 10          	lea    0x10(%r15),%r14
    c0d8:	4d 85 e4             	test   %r12,%r12
    c0db:	0f 94 c0             	sete   %al
    c0de:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
    c0e3:	40 0f 95 c5          	setne  %bpl
    c0e7:	40 20 c5             	and    %al,%bpl
    c0ea:	40 84 ed             	test   %bpl,%bpl
    c0ed:	b8 28 00 00 00       	mov    $0x28,%eax
    c0f2:	be 7b 00 00 00       	mov    $0x7b,%esi
    c0f7:	0f 45 f0             	cmovne %eax,%esi
    c0fa:	48 89 df             	mov    %rbx,%rdi
    c0fd:	e8 8e c4 ff ff       	call   8590 <buf_putc>
    c102:	41 83 3e 00          	cmpl   $0x0,(%r14)
    c106:	0f 8e a8 00 00 00    	jle    c1b4 <fwp_write+0x6a4>
    c10c:	40 84 ed             	test   %bpl,%bpl
    c10f:	75 1e                	jne    c12f <fwp_write+0x61f>
    c111:	49 8b 47 18          	mov    0x18(%r15),%rax
    c115:	48 8b 30             	mov    (%rax),%rsi
    c118:	48 89 df             	mov    %rbx,%rdi
    c11b:	e8 90 c4 ff ff       	call   85b0 <buf_puts>
    c120:	48 8d 35 6b 43 00 00 	lea    0x436b(%rip),%rsi        # 10492 <exec_in_fp0+0xd92>
    c127:	48 89 df             	mov    %rbx,%rdi
    c12a:	e8 81 c4 ff ff       	call   85b0 <buf_puts>
    c12f:	49 8b 75 08          	mov    0x8(%r13),%rsi
    c133:	49 8b 47 20          	mov    0x20(%r15),%rax
    c137:	48 8b 10             	mov    (%rax),%rdx
    c13a:	48 89 df             	mov    %rbx,%rdi
    c13d:	31 c9                	xor    %ecx,%ecx
    c13f:	e8 cc f9 ff ff       	call   bb10 <fwp_write>
    c144:	41 83 7f 10 02       	cmpl   $0x2,0x10(%r15)
    c149:	7c 69                	jl     c1b4 <fwp_write+0x6a4>
    c14b:	41 be 01 00 00 00    	mov    $0x1,%r14d
    c151:	4c 8d 25 4b 42 00 00 	lea    0x424b(%rip),%r12        # 103a3 <exec_in_fp0+0xca3>
    c158:	eb 29                	jmp    c183 <fwp_write+0x673>
    c15a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    c160:	4b 8b 74 f5 08       	mov    0x8(%r13,%r14,8),%rsi
    c165:	49 8b 47 20          	mov    0x20(%r15),%rax
    c169:	4a 8b 14 f0          	mov    (%rax,%r14,8),%rdx
    c16d:	48 89 df             	mov    %rbx,%rdi
    c170:	31 c9                	xor    %ecx,%ecx
    c172:	e8 99 f9 ff ff       	call   bb10 <fwp_write>
    c177:	49 ff c6             	inc    %r14
    c17a:	49 63 47 10          	movslq 0x10(%r15),%rax
    c17e:	49 39 c6             	cmp    %rax,%r14
    c181:	7d 31                	jge    c1b4 <fwp_write+0x6a4>
    c183:	48 89 df             	mov    %rbx,%rdi
    c186:	4c 89 e6             	mov    %r12,%rsi
    c189:	e8 22 c4 ff ff       	call   85b0 <buf_puts>
    c18e:	40 84 ed             	test   %bpl,%bpl
    c191:	75 cd                	jne    c160 <fwp_write+0x650>
    c193:	49 8b 47 18          	mov    0x18(%r15),%rax
    c197:	4a 8b 34 f0          	mov    (%rax,%r14,8),%rsi
    c19b:	48 89 df             	mov    %rbx,%rdi
    c19e:	e8 0d c4 ff ff       	call   85b0 <buf_puts>
    c1a3:	48 89 df             	mov    %rbx,%rdi
    c1a6:	48 8d 35 e5 42 00 00 	lea    0x42e5(%rip),%rsi        # 10492 <exec_in_fp0+0xd92>
    c1ad:	e8 fe c3 ff ff       	call   85b0 <buf_puts>
    c1b2:	eb ac                	jmp    c160 <fwp_write+0x650>
    c1b4:	40 84 ed             	test   %bpl,%bpl
    c1b7:	b8 29 00 00 00       	mov    $0x29,%eax
    c1bc:	be 7d 00 00 00       	mov    $0x7d,%esi
    c1c1:	0f 45 f0             	cmovne %eax,%esi
    c1c4:	48 89 df             	mov    %rbx,%rdi
    c1c7:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    c1ce:	5b                   	pop    %rbx
    c1cf:	41 5c                	pop    %r12
    c1d1:	41 5d                	pop    %r13
    c1d3:	41 5e                	pop    %r14
    c1d5:	41 5f                	pop    %r15
    c1d7:	5d                   	pop    %rbp
    c1d8:	e9 b3 c3 ff ff       	jmp    8590 <buf_putc>
    c1dd:	5b                   	pop    %rbx
    c1de:	41 5c                	pop    %r12
    c1e0:	41 5d                	pop    %r13
    c1e2:	41 5e                	pop    %r14
    c1e4:	41 5f                	pop    %r15
    c1e6:	5d                   	pop    %rbp
    c1e7:	e9 14 06 00 00       	jmp    c800 <fwp_escape>
    c1ec:	49 8b 75 08          	mov    0x8(%r13),%rsi
    c1f0:	48 89 f2             	mov    %rsi,%rdx
    c1f3:	48 c1 fa 3f          	sar    $0x3f,%rdx
    c1f7:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    c1fc:	4c 89 f7             	mov    %r14,%rdi
    c1ff:	e8 0c 07 00 00       	call   c910 <fwp_fmt_duration>
    c204:	e9 58 fe ff ff       	jmp    c061 <fwp_write+0x551>
    c209:	48 8d 35 7f 42 00 00 	lea    0x427f(%rip),%rsi        # 1048f <exec_in_fp0+0xd8f>
    c210:	e9 70 fe ff ff       	jmp    c085 <fwp_write+0x575>
    c215:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    c21c:	00 00 00 00 

000000000000c220 <fwp_fmt_i128>:
    c220:	48 85 d2             	test   %rdx,%rdx
    c223:	79 1b                	jns    c240 <fwp_fmt_u128>
    c225:	c6 07 2d             	movb   $0x2d,(%rdi)
    c228:	48 ff c7             	inc    %rdi
    c22b:	31 c0                	xor    %eax,%eax
    c22d:	48 f7 de             	neg    %rsi
    c230:	48 19 d0             	sbb    %rdx,%rax
    c233:	48 89 c2             	mov    %rax,%rdx
    c236:	eb 08                	jmp    c240 <fwp_fmt_u128>
    c238:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c23f:	00 

000000000000c240 <fwp_fmt_u128>:
    c240:	41 56                	push   %r14
    c242:	53                   	push   %rbx
    c243:	48 89 f0             	mov    %rsi,%rax
    c246:	48 09 d0             	or     %rdx,%rax
    c249:	0f 84 9d 00 00 00    	je     c2ec <fwp_fmt_u128+0xac>
    c24f:	48 89 d1             	mov    %rdx,%rcx
    c252:	45 31 d2             	xor    %r10d,%r10d
    c255:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    c25c:	cc cc cc 
    c25f:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
    c266:	cc cc cc 
    c269:	49 89 d6             	mov    %rdx,%r14
    c26c:	0f 1f 40 00          	nopl   0x0(%rax)
    c270:	49 89 c8             	mov    %rcx,%r8
    c273:	49 0f a4 f0 3f       	shld   $0x3f,%rsi,%r8
    c278:	49 d1 ee             	shr    $1,%r14
    c27b:	4d 89 c1             	mov    %r8,%r9
    c27e:	4d 01 f1             	add    %r14,%r9
    c281:	49 83 d1 00          	adc    $0x0,%r9
    c285:	4c 89 c8             	mov    %r9,%rax
    c288:	49 f7 e3             	mul    %r11
    c28b:	48 c1 ea 02          	shr    $0x2,%rdx
    c28f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    c293:	49 29 c1             	sub    %rax,%r9
    c296:	4d 29 c8             	sub    %r9,%r8
    c299:	49 83 de 00          	sbb    $0x0,%r14
    c29d:	4d 89 c1             	mov    %r8,%r9
    c2a0:	4c 0f af cb          	imul   %rbx,%r9
    c2a4:	4c 89 c0             	mov    %r8,%rax
    c2a7:	49 f7 e3             	mul    %r11
    c2aa:	4c 01 ca             	add    %r9,%rdx
    c2ad:	4d 0f af f3          	imul   %r11,%r14
    c2b1:	49 01 d6             	add    %rdx,%r14
    c2b4:	48 89 c2             	mov    %rax,%rdx
    c2b7:	48 01 c2             	add    %rax,%rdx
    c2ba:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
    c2be:	41 89 f0             	mov    %esi,%r8d
    c2c1:	41 29 d0             	sub    %edx,%r8d
    c2c4:	41 80 c8 30          	or     $0x30,%r8b
    c2c8:	46 88 44 14 b8       	mov    %r8b,-0x48(%rsp,%r10,1)
    c2cd:	49 ff c2             	inc    %r10
    c2d0:	48 83 fe 0a          	cmp    $0xa,%rsi
    c2d4:	48 83 d9 00          	sbb    $0x0,%rcx
    c2d8:	48 89 c6             	mov    %rax,%rsi
    c2db:	4c 89 f1             	mov    %r14,%rcx
    c2de:	73 90                	jae    c270 <fwp_fmt_u128+0x30>
    c2e0:	45 85 d2             	test   %r10d,%r10d
    c2e3:	7f 12                	jg     c2f7 <fwp_fmt_u128+0xb7>
    c2e5:	31 c0                	xor    %eax,%eax
    c2e7:	e9 56 01 00 00       	jmp    c442 <fwp_fmt_u128+0x202>
    c2ec:	c6 44 24 b8 30       	movb   $0x30,-0x48(%rsp)
    c2f1:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    c2f7:	44 89 d0             	mov    %r10d,%eax
    c2fa:	41 83 fa 08          	cmp    $0x8,%r10d
    c2fe:	73 0a                	jae    c30a <fwp_fmt_u128+0xca>
    c300:	31 c9                	xor    %ecx,%ecx
    c302:	48 89 c2             	mov    %rax,%rdx
    c305:	e9 10 01 00 00       	jmp    c41a <fwp_fmt_u128+0x1da>
    c30a:	83 f8 20             	cmp    $0x20,%eax
    c30d:	73 07                	jae    c316 <fwp_fmt_u128+0xd6>
    c30f:	31 c9                	xor    %ecx,%ecx
    c311:	e9 a4 00 00 00       	jmp    c3ba <fwp_fmt_u128+0x17a>
    c316:	89 c1                	mov    %eax,%ecx
    c318:	81 e1 e0 ff ff 7f    	and    $0x7fffffe0,%ecx
    c31e:	48 8d 54 24 b8       	lea    -0x48(%rsp),%rdx
    c323:	48 01 c2             	add    %rax,%rdx
    c326:	48 83 c2 f0          	add    $0xfffffffffffffff0,%rdx
    c32a:	31 f6                	xor    %esi,%esi
    c32c:	66 0f ef c0          	pxor   %xmm0,%xmm0
    c330:	f3 0f 6f 4a f0       	movdqu -0x10(%rdx),%xmm1
    c335:	f3 0f 6f 12          	movdqu (%rdx),%xmm2
    c339:	66 0f 6f da          	movdqa %xmm2,%xmm3
    c33d:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    c341:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    c346:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    c34b:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    c350:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    c354:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    c359:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    c35e:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    c363:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    c367:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    c36b:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    c36f:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    c374:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    c379:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    c37e:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    c382:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    c387:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    c38c:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    c391:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    c395:	f3 0f 7f 14 37       	movdqu %xmm2,(%rdi,%rsi,1)
    c39a:	f3 0f 7f 4c 37 10    	movdqu %xmm1,0x10(%rdi,%rsi,1)
    c3a0:	48 83 c6 20          	add    $0x20,%rsi
    c3a4:	48 83 c2 e0          	add    $0xffffffffffffffe0,%rdx
    c3a8:	48 39 f1             	cmp    %rsi,%rcx
    c3ab:	75 83                	jne    c330 <fwp_fmt_u128+0xf0>
    c3ad:	48 39 c1             	cmp    %rax,%rcx
    c3b0:	0f 84 8c 00 00 00    	je     c442 <fwp_fmt_u128+0x202>
    c3b6:	a8 18                	test   $0x18,%al
    c3b8:	74 5b                	je     c415 <fwp_fmt_u128+0x1d5>
    c3ba:	48 89 ce             	mov    %rcx,%rsi
    c3bd:	89 c1                	mov    %eax,%ecx
    c3bf:	81 e1 f8 ff ff 7f    	and    $0x7ffffff8,%ecx
    c3c5:	89 c2                	mov    %eax,%edx
    c3c7:	83 e2 07             	and    $0x7,%edx
    c3ca:	49 89 c0             	mov    %rax,%r8
    c3cd:	49 29 f0             	sub    %rsi,%r8
    c3d0:	49 01 e0             	add    %rsp,%r8
    c3d3:	49 83 c0 b0          	add    $0xffffffffffffffb0,%r8
    c3d7:	66 0f ef c0          	pxor   %xmm0,%xmm0
    c3db:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    c3e0:	f3 41 0f 7e 08       	movq   (%r8),%xmm1
    c3e5:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    c3e9:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    c3ee:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    c3f3:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    c3f8:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    c3fc:	66 0f d6 0c 37       	movq   %xmm1,(%rdi,%rsi,1)
    c401:	48 83 c6 08          	add    $0x8,%rsi
    c405:	49 83 c0 f8          	add    $0xfffffffffffffff8,%r8
    c409:	48 39 f1             	cmp    %rsi,%rcx
    c40c:	75 d2                	jne    c3e0 <fwp_fmt_u128+0x1a0>
    c40e:	48 39 c1             	cmp    %rax,%rcx
    c411:	75 07                	jne    c41a <fwp_fmt_u128+0x1da>
    c413:	eb 2d                	jmp    c442 <fwp_fmt_u128+0x202>
    c415:	89 c2                	mov    %eax,%edx
    c417:	83 e2 1f             	and    $0x1f,%edx
    c41a:	48 8d 74 24 b8       	lea    -0x48(%rsp),%rsi
    c41f:	48 01 f2             	add    %rsi,%rdx
    c422:	48 ff ca             	dec    %rdx
    c425:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    c42c:	00 00 00 00 
    c430:	0f b6 32             	movzbl (%rdx),%esi
    c433:	40 88 34 0f          	mov    %sil,(%rdi,%rcx,1)
    c437:	48 ff c1             	inc    %rcx
    c43a:	48 ff ca             	dec    %rdx
    c43d:	48 39 c8             	cmp    %rcx,%rax
    c440:	75 ee                	jne    c430 <fwp_fmt_u128+0x1f0>
    c442:	c6 04 07 00          	movb   $0x0,(%rdi,%rax,1)
    c446:	5b                   	pop    %rbx
    c447:	41 5e                	pop    %r14
    c449:	c3                   	ret
    c44a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000c450 <fwp_fmt_f32>:
    c450:	53                   	push   %rbx
    c451:	48 83 ec 20          	sub    $0x20,%rsp
    c455:	48 89 fb             	mov    %rdi,%rbx
    c458:	0f 2e c0             	ucomiss %xmm0,%xmm0
    c45b:	0f 8a d8 01 00 00    	jp     c639 <fwp_fmt_f32+0x1e9>
    c461:	0f 28 c8             	movaps %xmm0,%xmm1
    c464:	0f 28 05 95 2c 00 00 	movaps 0x2c95(%rip),%xmm0        # f100 <_IO_stdin_used+0x100>
    c46b:	0f 54 c1             	andps  %xmm1,%xmm0
    c46e:	0f 2e 05 8f 2b 00 00 	ucomiss 0x2b8f(%rip),%xmm0        # f004 <_IO_stdin_used+0x4>
    c475:	72 25                	jb     c49c <fwp_fmt_f32+0x4c>
    c477:	0f 57 c0             	xorps  %xmm0,%xmm0
    c47a:	0f 2e c8             	ucomiss %xmm0,%xmm1
    c47d:	48 8d 05 55 3f 00 00 	lea    0x3f55(%rip),%rax        # 103d9 <exec_in_fp0+0xcd9>
    c484:	48 8d 35 4d 3f 00 00 	lea    0x3f4d(%rip),%rsi        # 103d8 <exec_in_fp0+0xcd8>
    c48b:	48 0f 47 f0          	cmova  %rax,%rsi
    c48f:	48 89 df             	mov    %rbx,%rdi
    c492:	48 83 c4 20          	add    $0x20,%rsp
    c496:	5b                   	pop    %rbx
    c497:	e9 14 6c ff ff       	jmp    30b0 <strcpy@plt>
    c49c:	0f 57 c0             	xorps  %xmm0,%xmm0
    c49f:	f3 0f 5a c1          	cvtss2sd %xmm1,%xmm0
    c4a3:	48 89 df             	mov    %rbx,%rdi
    c4a6:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    c4ac:	be 01 00 00 00       	mov    $0x1,%esi
    c4b1:	0f 29 4c 24 10       	movaps %xmm1,0x10(%rsp)
    c4b6:	e8 95 07 00 00       	call   cc50 <fwp_format_g>
    c4bb:	48 89 df             	mov    %rbx,%rdi
    c4be:	31 f6                	xor    %esi,%esi
    c4c0:	e8 3b 6d ff ff       	call   3200 <strtof@plt>
    c4c5:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    c4ca:	75 06                	jne    c4d2 <fwp_fmt_f32+0x82>
    c4cc:	0f 8b 5a 01 00 00    	jnp    c62c <fwp_fmt_f32+0x1dc>
    c4d2:	48 89 df             	mov    %rbx,%rdi
    c4d5:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    c4db:	be 02 00 00 00       	mov    $0x2,%esi
    c4e0:	e8 6b 07 00 00       	call   cc50 <fwp_format_g>
    c4e5:	48 89 df             	mov    %rbx,%rdi
    c4e8:	31 f6                	xor    %esi,%esi
    c4ea:	e8 11 6d ff ff       	call   3200 <strtof@plt>
    c4ef:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    c4f4:	75 06                	jne    c4fc <fwp_fmt_f32+0xac>
    c4f6:	0f 8b 30 01 00 00    	jnp    c62c <fwp_fmt_f32+0x1dc>
    c4fc:	48 89 df             	mov    %rbx,%rdi
    c4ff:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    c505:	be 03 00 00 00       	mov    $0x3,%esi
    c50a:	e8 41 07 00 00       	call   cc50 <fwp_format_g>
    c50f:	48 89 df             	mov    %rbx,%rdi
    c512:	31 f6                	xor    %esi,%esi
    c514:	e8 e7 6c ff ff       	call   3200 <strtof@plt>
    c519:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    c51e:	75 06                	jne    c526 <fwp_fmt_f32+0xd6>
    c520:	0f 8b 06 01 00 00    	jnp    c62c <fwp_fmt_f32+0x1dc>
    c526:	48 89 df             	mov    %rbx,%rdi
    c529:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    c52f:	be 04 00 00 00       	mov    $0x4,%esi
    c534:	e8 17 07 00 00       	call   cc50 <fwp_format_g>
    c539:	48 89 df             	mov    %rbx,%rdi
    c53c:	31 f6                	xor    %esi,%esi
    c53e:	e8 bd 6c ff ff       	call   3200 <strtof@plt>
    c543:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    c548:	75 06                	jne    c550 <fwp_fmt_f32+0x100>
    c54a:	0f 8b dc 00 00 00    	jnp    c62c <fwp_fmt_f32+0x1dc>
    c550:	48 89 df             	mov    %rbx,%rdi
    c553:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    c559:	be 05 00 00 00       	mov    $0x5,%esi
    c55e:	e8 ed 06 00 00       	call   cc50 <fwp_format_g>
    c563:	48 89 df             	mov    %rbx,%rdi
    c566:	31 f6                	xor    %esi,%esi
    c568:	e8 93 6c ff ff       	call   3200 <strtof@plt>
    c56d:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    c572:	75 06                	jne    c57a <fwp_fmt_f32+0x12a>
    c574:	0f 8b b2 00 00 00    	jnp    c62c <fwp_fmt_f32+0x1dc>
    c57a:	48 89 df             	mov    %rbx,%rdi
    c57d:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    c583:	be 06 00 00 00       	mov    $0x6,%esi
    c588:	e8 c3 06 00 00       	call   cc50 <fwp_format_g>
    c58d:	48 89 df             	mov    %rbx,%rdi
    c590:	31 f6                	xor    %esi,%esi
    c592:	e8 69 6c ff ff       	call   3200 <strtof@plt>
    c597:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    c59c:	75 06                	jne    c5a4 <fwp_fmt_f32+0x154>
    c59e:	0f 8b 88 00 00 00    	jnp    c62c <fwp_fmt_f32+0x1dc>
    c5a4:	48 89 df             	mov    %rbx,%rdi
    c5a7:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    c5ad:	be 07 00 00 00       	mov    $0x7,%esi
    c5b2:	e8 99 06 00 00       	call   cc50 <fwp_format_g>
    c5b7:	48 89 df             	mov    %rbx,%rdi
    c5ba:	31 f6                	xor    %esi,%esi
    c5bc:	e8 3f 6c ff ff       	call   3200 <strtof@plt>
    c5c1:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    c5c6:	75 02                	jne    c5ca <fwp_fmt_f32+0x17a>
    c5c8:	7b 62                	jnp    c62c <fwp_fmt_f32+0x1dc>
    c5ca:	48 89 df             	mov    %rbx,%rdi
    c5cd:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    c5d3:	be 08 00 00 00       	mov    $0x8,%esi
    c5d8:	e8 73 06 00 00       	call   cc50 <fwp_format_g>
    c5dd:	48 89 df             	mov    %rbx,%rdi
    c5e0:	31 f6                	xor    %esi,%esi
    c5e2:	e8 19 6c ff ff       	call   3200 <strtof@plt>
    c5e7:	0f 28 4c 24 10       	movaps 0x10(%rsp),%xmm1
    c5ec:	0f 2e c1             	ucomiss %xmm1,%xmm0
    c5ef:	75 02                	jne    c5f3 <fwp_fmt_f32+0x1a3>
    c5f1:	7b 39                	jnp    c62c <fwp_fmt_f32+0x1dc>
    c5f3:	48 89 df             	mov    %rbx,%rdi
    c5f6:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    c5fc:	be 09 00 00 00       	mov    $0x9,%esi
    c601:	e8 4a 06 00 00       	call   cc50 <fwp_format_g>
    c606:	48 89 df             	mov    %rbx,%rdi
    c609:	31 f6                	xor    %esi,%esi
    c60b:	e8 f0 6b ff ff       	call   3200 <strtof@plt>
    c610:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    c615:	75 02                	jne    c619 <fwp_fmt_f32+0x1c9>
    c617:	7b 13                	jnp    c62c <fwp_fmt_f32+0x1dc>
    c619:	48 89 df             	mov    %rbx,%rdi
    c61c:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    c622:	be 09 00 00 00       	mov    $0x9,%esi
    c627:	e8 24 06 00 00       	call   cc50 <fwp_format_g>
    c62c:	48 89 df             	mov    %rbx,%rdi
    c62f:	48 83 c4 20          	add    $0x20,%rsp
    c633:	5b                   	pop    %rbx
    c634:	e9 97 07 00 00       	jmp    cdd0 <fwp_finish_float>
    c639:	c7 03 4e 61 4e 00    	movl   $0x4e614e,(%rbx)
    c63f:	48 83 c4 20          	add    $0x20,%rsp
    c643:	5b                   	pop    %rbx
    c644:	c3                   	ret
    c645:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    c64c:	00 00 00 00 

000000000000c650 <fwp_fmt_f64>:
    c650:	55                   	push   %rbp
    c651:	53                   	push   %rbx
    c652:	48 83 ec 18          	sub    $0x18,%rsp
    c656:	48 89 fb             	mov    %rdi,%rbx
    c659:	66 0f 2e c0          	ucomisd %xmm0,%xmm0
    c65d:	0f 8a 98 00 00 00    	jp     c6fb <fwp_fmt_f64+0xab>
    c663:	66 0f 28 c8          	movapd %xmm0,%xmm1
    c667:	66 0f 28 05 a1 2a 00 	movapd 0x2aa1(%rip),%xmm0        # f110 <_IO_stdin_used+0x110>
    c66e:	00 
    c66f:	66 0f 54 c1          	andpd  %xmm1,%xmm0
    c673:	66 0f 2e 05 e5 2a 00 	ucomisd 0x2ae5(%rip),%xmm0        # f160 <_IO_stdin_used+0x160>
    c67a:	00 
    c67b:	72 28                	jb     c6a5 <fwp_fmt_f64+0x55>
    c67d:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    c681:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
    c685:	48 8d 05 4d 3d 00 00 	lea    0x3d4d(%rip),%rax        # 103d9 <exec_in_fp0+0xcd9>
    c68c:	48 8d 35 45 3d 00 00 	lea    0x3d45(%rip),%rsi        # 103d8 <exec_in_fp0+0xcd8>
    c693:	48 0f 47 f0          	cmova  %rax,%rsi
    c697:	48 89 df             	mov    %rbx,%rdi
    c69a:	48 83 c4 18          	add    $0x18,%rsp
    c69e:	5b                   	pop    %rbx
    c69f:	5d                   	pop    %rbp
    c6a0:	e9 0b 6a ff ff       	jmp    30b0 <strcpy@plt>
    c6a5:	bd 01 00 00 00       	mov    $0x1,%ebp
    c6aa:	66 0f 29 0c 24       	movapd %xmm1,(%rsp)
    c6af:	90                   	nop
    c6b0:	48 89 df             	mov    %rbx,%rdi
    c6b3:	66 0f 28 c1          	movapd %xmm1,%xmm0
    c6b7:	89 ee                	mov    %ebp,%esi
    c6b9:	e8 92 05 00 00       	call   cc50 <fwp_format_g>
    c6be:	48 89 df             	mov    %rbx,%rdi
    c6c1:	31 f6                	xor    %esi,%esi
    c6c3:	e8 38 6a ff ff       	call   3100 <strtod@plt>
    c6c8:	66 0f 28 0c 24       	movapd (%rsp),%xmm1
    c6cd:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
    c6d1:	75 02                	jne    c6d5 <fwp_fmt_f64+0x85>
    c6d3:	7b 18                	jnp    c6ed <fwp_fmt_f64+0x9d>
    c6d5:	ff c5                	inc    %ebp
    c6d7:	83 fd 12             	cmp    $0x12,%ebp
    c6da:	75 d4                	jne    c6b0 <fwp_fmt_f64+0x60>
    c6dc:	48 89 df             	mov    %rbx,%rdi
    c6df:	66 0f 28 c1          	movapd %xmm1,%xmm0
    c6e3:	be 11 00 00 00       	mov    $0x11,%esi
    c6e8:	e8 63 05 00 00       	call   cc50 <fwp_format_g>
    c6ed:	48 89 df             	mov    %rbx,%rdi
    c6f0:	48 83 c4 18          	add    $0x18,%rsp
    c6f4:	5b                   	pop    %rbx
    c6f5:	5d                   	pop    %rbp
    c6f6:	e9 d5 06 00 00       	jmp    cdd0 <fwp_finish_float>
    c6fb:	c7 03 4e 61 4e 00    	movl   $0x4e614e,(%rbx)
    c701:	48 83 c4 18          	add    $0x18,%rsp
    c705:	5b                   	pop    %rbx
    c706:	5d                   	pop    %rbp
    c707:	c3                   	ret
    c708:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c70f:	00 

000000000000c710 <fwp_trits>:
    c710:	55                   	push   %rbp
    c711:	41 57                	push   %r15
    c713:	41 56                	push   %r14
    c715:	53                   	push   %rbx
    c716:	50                   	push   %rax
    c717:	89 d5                	mov    %edx,%ebp
    c719:	49 89 f6             	mov    %rsi,%r14
    c71c:	48 89 fb             	mov    %rdi,%rbx
    c71f:	4c 63 fa             	movslq %edx,%r15
    c722:	49 8d 7f 03          	lea    0x3(%r15),%rdi
    c726:	e8 85 aa ff ff       	call   71b0 <fwp_alloc_leaf>
    c72b:	48 89 c6             	mov    %rax,%rsi
    c72e:	66 c7 00 30 74       	movw   $0x7430,(%rax)
    c733:	45 85 ff             	test   %r15d,%r15d
    c736:	0f 8e 9f 00 00 00    	jle    c7db <fwp_trits+0xcb>
    c73c:	89 e9                	mov    %ebp,%ecx
    c73e:	48 8d 3c 31          	lea    (%rcx,%rsi,1),%rdi
    c742:	48 ff c7             	inc    %rdi
    c745:	48 f7 d9             	neg    %rcx
    c748:	45 31 c0             	xor    %r8d,%r8d
    c74b:	49 b9 56 55 55 55 55 	movabs $0x5555555555555556,%r9
    c752:	55 55 55 
    c755:	eb 35                	jmp    c78c <fwp_trits+0x7c>
    c757:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    c75e:	00 00 
    c760:	41 b3 30             	mov    $0x30,%r11b
    c763:	46 88 1c 07          	mov    %r11b,(%rdi,%r8,1)
    c767:	48 85 d2             	test   %rdx,%rdx
    c76a:	0f 95 c2             	setne  %dl
    c76d:	4d 85 f6             	test   %r14,%r14
    c770:	41 0f 98 c3          	sets   %r11b
    c774:	41 20 d3             	and    %dl,%r11b
    c777:	41 0f b6 d3          	movzbl %r11b,%edx
    c77b:	48 29 d0             	sub    %rdx,%rax
    c77e:	4c 01 d0             	add    %r10,%rax
    c781:	49 ff c8             	dec    %r8
    c784:	49 89 c6             	mov    %rax,%r14
    c787:	4c 39 c1             	cmp    %r8,%rcx
    c78a:	74 4f                	je     c7db <fwp_trits+0xcb>
    c78c:	4c 89 f0             	mov    %r14,%rax
    c78f:	49 f7 e9             	imul   %r9
    c792:	48 89 d0             	mov    %rdx,%rax
    c795:	48 c1 e8 3f          	shr    $0x3f,%rax
    c799:	48 01 d0             	add    %rdx,%rax
    c79c:	4c 8d 14 40          	lea    (%rax,%rax,2),%r10
    c7a0:	4c 89 f2             	mov    %r14,%rdx
    c7a3:	4c 29 d2             	sub    %r10,%rdx
    c7a6:	49 f7 da             	neg    %r10
    c7a9:	4d 01 f2             	add    %r14,%r10
    c7ac:	49 83 c2 03          	add    $0x3,%r10
    c7b0:	48 83 fa fd          	cmp    $0xfffffffffffffffd,%rdx
    c7b4:	4c 0f 42 d2          	cmovb  %rdx,%r10
    c7b8:	4d 85 d2             	test   %r10,%r10
    c7bb:	74 a3                	je     c760 <fwp_trits+0x50>
    c7bd:	49 83 fa 01          	cmp    $0x1,%r10
    c7c1:	75 0d                	jne    c7d0 <fwp_trits+0xc0>
    c7c3:	41 b3 2b             	mov    $0x2b,%r11b
    c7c6:	45 31 d2             	xor    %r10d,%r10d
    c7c9:	eb 98                	jmp    c763 <fwp_trits+0x53>
    c7cb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    c7d0:	41 b3 2d             	mov    $0x2d,%r11b
    c7d3:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    c7d9:	eb 88                	jmp    c763 <fwp_trits+0x53>
    c7db:	42 c6 44 3e 02 00    	movb   $0x0,0x2(%rsi,%r15,1)
    c7e1:	48 89 df             	mov    %rbx,%rdi
    c7e4:	48 83 c4 08          	add    $0x8,%rsp
    c7e8:	5b                   	pop    %rbx
    c7e9:	41 5e                	pop    %r14
    c7eb:	41 5f                	pop    %r15
    c7ed:	5d                   	pop    %rbp
    c7ee:	e9 bd bd ff ff       	jmp    85b0 <buf_puts>
    c7f3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c7fa:	84 00 00 00 00 00 

000000000000c800 <fwp_escape>:
    c800:	55                   	push   %rbp
    c801:	41 57                	push   %r15
    c803:	41 56                	push   %r14
    c805:	41 55                	push   %r13
    c807:	41 54                	push   %r12
    c809:	53                   	push   %rbx
    c80a:	48 83 ec 18          	sub    $0x18,%rsp
    c80e:	48 89 d3             	mov    %rdx,%rbx
    c811:	49 89 f7             	mov    %rsi,%r15
    c814:	49 89 fe             	mov    %rdi,%r14
    c817:	be 22 00 00 00       	mov    $0x22,%esi
    c81c:	e8 6f bd ff ff       	call   8590 <buf_putc>
    c821:	48 85 db             	test   %rbx,%rbx
    c824:	0f 84 c7 00 00 00    	je     c8f1 <fwp_escape+0xf1>
    c82a:	48 89 e5             	mov    %rsp,%rbp
    c82d:	4c 8d 2d 78 2b 00 00 	lea    0x2b78(%rip),%r13        # f3ac <_IO_stdin_used+0x3ac>
    c834:	45 31 e4             	xor    %r12d,%r12d
    c837:	eb 28                	jmp    c861 <fwp_escape+0x61>
    c839:	4c 89 f7             	mov    %r14,%rdi
    c83c:	48 8d 35 76 3c 00 00 	lea    0x3c76(%rip),%rsi        # 104b9 <exec_in_fp0+0xdb9>
    c843:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c84a:	84 00 00 00 00 00 
    c850:	e8 5b bd ff ff       	call   85b0 <buf_puts>
    c855:	49 ff c4             	inc    %r12
    c858:	4c 39 e3             	cmp    %r12,%rbx
    c85b:	0f 84 90 00 00 00    	je     c8f1 <fwp_escape+0xf1>
    c861:	43 0f b6 0c 27       	movzbl (%r15,%r12,1),%ecx
    c866:	8d 41 f7             	lea    -0x9(%rcx),%eax
    c869:	83 f8 19             	cmp    $0x19,%eax
    c86c:	77 22                	ja     c890 <fwp_escape+0x90>
    c86e:	49 63 44 85 00       	movslq 0x0(%r13,%rax,4),%rax
    c873:	4c 01 e8             	add    %r13,%rax
    c876:	ff e0                	jmp    *%rax
    c878:	4c 89 f7             	mov    %r14,%rdi
    c87b:	48 8d 35 34 3c 00 00 	lea    0x3c34(%rip),%rsi        # 104b6 <exec_in_fp0+0xdb6>
    c882:	eb cc                	jmp    c850 <fwp_escape+0x50>
    c884:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    c88b:	00 00 00 00 00 
    c890:	83 f9 5c             	cmp    $0x5c,%ecx
    c893:	75 0c                	jne    c8a1 <fwp_escape+0xa1>
    c895:	4c 89 f7             	mov    %r14,%rdi
    c898:	48 8d 35 11 3c 00 00 	lea    0x3c11(%rip),%rsi        # 104b0 <exec_in_fp0+0xdb0>
    c89f:	eb af                	jmp    c850 <fwp_escape+0x50>
    c8a1:	80 f9 20             	cmp    $0x20,%cl
    c8a4:	72 2a                	jb     c8d0 <fwp_escape+0xd0>
    c8a6:	80 f9 7f             	cmp    $0x7f,%cl
    c8a9:	74 25                	je     c8d0 <fwp_escape+0xd0>
    c8ab:	0f be f1             	movsbl %cl,%esi
    c8ae:	4c 89 f7             	mov    %r14,%rdi
    c8b1:	e8 da bc ff ff       	call   8590 <buf_putc>
    c8b6:	eb 9d                	jmp    c855 <fwp_escape+0x55>
    c8b8:	4c 89 f7             	mov    %r14,%rdi
    c8bb:	48 8d 35 eb 3b 00 00 	lea    0x3beb(%rip),%rsi        # 104ad <exec_in_fp0+0xdad>
    c8c2:	eb 8c                	jmp    c850 <fwp_escape+0x50>
    c8c4:	4c 89 f7             	mov    %r14,%rdi
    c8c7:	48 8d 35 e5 3b 00 00 	lea    0x3be5(%rip),%rsi        # 104b3 <exec_in_fp0+0xdb3>
    c8ce:	eb 80                	jmp    c850 <fwp_escape+0x50>
    c8d0:	be 10 00 00 00       	mov    $0x10,%esi
    c8d5:	48 89 ef             	mov    %rbp,%rdi
    c8d8:	48 8d 15 dd 3b 00 00 	lea    0x3bdd(%rip),%rdx        # 104bc <exec_in_fp0+0xdbc>
    c8df:	31 c0                	xor    %eax,%eax
    c8e1:	e8 ea 68 ff ff       	call   31d0 <snprintf@plt>
    c8e6:	4c 89 f7             	mov    %r14,%rdi
    c8e9:	48 89 ee             	mov    %rbp,%rsi
    c8ec:	e9 5f ff ff ff       	jmp    c850 <fwp_escape+0x50>
    c8f1:	4c 89 f7             	mov    %r14,%rdi
    c8f4:	be 22 00 00 00       	mov    $0x22,%esi
    c8f9:	48 83 c4 18          	add    $0x18,%rsp
    c8fd:	5b                   	pop    %rbx
    c8fe:	41 5c                	pop    %r12
    c900:	41 5d                	pop    %r13
    c902:	41 5e                	pop    %r14
    c904:	41 5f                	pop    %r15
    c906:	5d                   	pop    %rbp
    c907:	e9 84 bc ff ff       	jmp    8590 <buf_putc>
    c90c:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000c910 <fwp_fmt_duration>:
    c910:	41 57                	push   %r15
    c912:	41 56                	push   %r14
    c914:	41 54                	push   %r12
    c916:	53                   	push   %rbx
    c917:	48 83 ec 48          	sub    $0x48,%rsp
    c91b:	49 89 d0             	mov    %rdx,%r8
    c91e:	48 89 fb             	mov    %rdi,%rbx
    c921:	48 89 f0             	mov    %rsi,%rax
    c924:	48 09 d0             	or     %rdx,%rax
    c927:	0f 84 1b 02 00 00    	je     cb48 <fwp_fmt_duration+0x238>
    c92d:	48 b9 1d 3f c2 25 d6 	movabs $0xd2fe1d625c23f1d,%rcx
    c934:	e1 2f 0d 
    c937:	48 bf 0d b1 f3 e4 99 	movabs $0x1c52799e4f3b10d,%rdi
    c93e:	27 c5 01 
    c941:	48 89 f0             	mov    %rsi,%rax
    c944:	48 f7 e7             	mul    %rdi
    c947:	48 0f af ce          	imul   %rsi,%rcx
    c94b:	48 01 ca             	add    %rcx,%rdx
    c94e:	49 0f af f8          	imul   %r8,%rdi
    c952:	48 01 d7             	add    %rdx,%rdi
    c955:	48 b9 00 a0 34 52 a3 	movabs $0x6baf6aa35234a000,%rcx
    c95c:	6a af 6b 
    c95f:	48 01 c1             	add    %rax,%rcx
    c962:	48 b8 37 f9 ff e2 04 	movabs $0x4e2fff937,%rax
    c969:	00 00 00 
    c96c:	48 11 f8             	adc    %rdi,%rax
    c96f:	48 89 c2             	mov    %rax,%rdx
    c972:	48 0f ac ca 0d       	shrd   $0xd,%rcx,%rdx
    c977:	48 0f a4 c8 33       	shld   $0x33,%rcx,%rax
    c97c:	48 b9 4b 23 35 aa f6 	movabs $0x9376baf6aa35234b,%rcx
    c983:	ba 76 93 
    c986:	48 39 c8             	cmp    %rcx,%rax
    c989:	48 81 da ff 2f 4e 00 	sbb    $0x4e2fff,%rdx
    c990:	0f 82 d9 01 00 00    	jb     cb6f <fwp_fmt_duration+0x25f>
    c996:	48 b9 b3 b2 61 36 8c 	movabs $0xc5ce3b8c3661b2b3,%rcx
    c99d:	3b ce c5 
    c9a0:	48 bf c3 5f 47 6a 04 	movabs $0x1a8d52046a475fc3,%rdi
    c9a7:	52 8d 1a 
    c9aa:	48 89 f0             	mov    %rsi,%rax
    c9ad:	48 f7 e7             	mul    %rdi
    c9b0:	48 0f af ce          	imul   %rsi,%rcx
    c9b4:	48 01 ca             	add    %rcx,%rdx
    c9b7:	49 0f af f8          	imul   %r8,%rdi
    c9bb:	48 01 d7             	add    %rdx,%rdi
    c9be:	48 b9 00 a8 16 d1 91 	movabs $0x4f473f91d116a800,%rcx
    c9c5:	3f 47 4f 
    c9c8:	48 01 c1             	add    %rax,%rcx
    c9cb:	48 b8 3f 9a ff 4c 49 	movabs $0x494cff9a3f,%rax
    c9d2:	00 00 00 
    c9d5:	48 11 f8             	adc    %rdi,%rax
    c9d8:	48 89 c2             	mov    %rax,%rdx
    c9db:	48 0f ac ca 0b       	shrd   $0xb,%rcx,%rdx
    c9e0:	48 0f a4 c8 35       	shld   $0x35,%rcx,%rax
    c9e5:	48 b9 ab 45 74 e4 cf 	movabs $0x8fd3d1cfe47445ab,%rcx
    c9ec:	d1 d3 8f 
    c9ef:	48 39 c8             	cmp    %rcx,%rax
    c9f2:	48 81 da e6 3f 53 12 	sbb    $0x12533fe6,%rdx
    c9f9:	0f 82 7f 01 00 00    	jb     cb7e <fwp_fmt_duration+0x26e>
    c9ff:	48 b9 7e 78 b9 2f 37 	movabs $0x97157d372fb9787e,%rcx
    ca06:	7d 15 97 
    ca09:	48 0f af ce          	imul   %rsi,%rcx
    ca0d:	48 bf 6d 9c 2e 3a 42 	movabs $0x8e47ce423a2e9c6d,%rdi
    ca14:	ce 47 8e 
    ca17:	48 89 f0             	mov    %rsi,%rax
    ca1a:	48 f7 e7             	mul    %rdi
    ca1d:	48 01 ca             	add    %rcx,%rdx
    ca20:	49 0f af f8          	imul   %r8,%rdi
    ca24:	48 01 d7             	add    %rdx,%rdi
    ca27:	48 b9 00 46 54 40 8b 	movabs $0xa52cb98b40544600,%rcx
    ca2e:	b9 2c a5 
    ca31:	48 01 c1             	add    %rax,%rcx
    ca34:	48 b8 b5 09 fa 82 4b 	movabs $0x44b82fa09b5,%rax
    ca3b:	04 00 00 
    ca3e:	48 11 f8             	adc    %rdi,%rax
    ca41:	48 89 c2             	mov    %rax,%rdx
    ca44:	48 0f ac ca 09       	shrd   $0x9,%rcx,%rdx
    ca49:	48 0f a4 c8 37       	shld   $0x37,%rcx,%rax
    ca4e:	48 b9 47 54 40 8b b9 	movabs $0xb5a52cb98b405447,%rcx
    ca55:	2c a5 b5 
    ca58:	48 39 c8             	cmp    %rcx,%rax
    ca5b:	48 b8 09 fa 82 4b 04 	movabs $0x44b82fa09,%rax
    ca62:	00 00 00 
    ca65:	48 19 c2             	sbb    %rax,%rdx
    ca68:	0f 82 22 01 00 00    	jb     cb90 <fwp_fmt_duration+0x280>
    ca6e:	48 b9 cb d5 8f 4d f2 	movabs $0xc57e23f24d8fd5cb,%rcx
    ca75:	23 7e c5 
    ca78:	48 0f af ce          	imul   %rsi,%rcx
    ca7c:	48 bf 39 61 c2 68 56 	movabs $0x790fb65668c26139,%rdi
    ca83:	b6 0f 79 
    ca86:	48 89 f0             	mov    %rsi,%rax
    ca89:	48 f7 e7             	mul    %rdi
    ca8c:	48 01 ca             	add    %rcx,%rdx
    ca8f:	49 0f af f8          	imul   %r8,%rdi
    ca93:	48 01 d7             	add    %rdx,%rdi
    ca96:	48 b9 00 0b 27 69 fe 	movabs $0xa6d698fe69270b00,%rcx
    ca9d:	98 d6 a6 
    caa0:	48 01 c1             	add    %rax,%rcx
    caa3:	48 b8 b1 bd 16 f4 de 	movabs $0x218def416bdb1,%rax
    caaa:	18 02 00 
    caad:	48 11 f8             	adc    %rdi,%rax
    cab0:	48 89 c2             	mov    %rax,%rdx
    cab3:	48 0f ac ca 06       	shrd   $0x6,%rcx,%rdx
    cab8:	48 0f a4 c8 3a       	shld   $0x3a,%rcx,%rax
    cabd:	48 b9 59 38 49 f3 c7 	movabs $0x8d36b4c7f3493859,%rcx
    cac4:	b4 36 8d 
    cac7:	48 39 c8             	cmp    %rcx,%rax
    caca:	48 b8 ed b5 a0 f7 c6 	movabs $0x10c6f7a0b5ed,%rax
    cad1:	10 00 00 
    cad4:	48 19 c2             	sbb    %rax,%rdx
    cad7:	0f 82 c0 00 00 00    	jb     cb9d <fwp_fmt_duration+0x28d>
    cadd:	48 b9 5a 64 3b df 4f 	movabs $0x6e978d4fdf3b645a,%rcx
    cae4:	8d 97 6e 
    cae7:	48 0f af ce          	imul   %rsi,%rcx
    caeb:	48 bf d5 78 e9 26 31 	movabs $0x1cac083126e978d5,%rdi
    caf2:	08 ac 1c 
    caf5:	48 89 f0             	mov    %rsi,%rax
    caf8:	48 f7 e7             	mul    %rdi
    cafb:	48 01 ca             	add    %rcx,%rdx
    cafe:	49 0f af f8          	imul   %r8,%rdi
    cb02:	48 01 d7             	add    %rdx,%rdi
    cb05:	48 b9 48 62 10 58 39 	movabs $0x76c8b43958106248,%rcx
    cb0c:	b4 c8 76 
    cb0f:	48 01 c1             	add    %rax,%rcx
    cb12:	48 b8 be 9f 1a 2f dd 	movabs $0x10624dd2f1a9fbe,%rax
    cb19:	24 06 01 
    cb1c:	48 11 f8             	adc    %rdi,%rax
    cb1f:	48 89 c2             	mov    %rax,%rdx
    cb22:	48 0f ac ca 03       	shrd   $0x3,%rcx,%rdx
    cb27:	48 0f a4 c8 3d       	shld   $0x3d,%rcx,%rax
    cb2c:	48 b9 93 18 04 56 0e 	movabs $0x9db22d0e56041893,%rcx
    cb33:	2d b2 9d 
    cb36:	48 39 c8             	cmp    %rcx,%rax
    cb39:	48 b8 ef a7 c6 4b 37 	movabs $0x4189374bc6a7ef,%rax
    cb40:	89 41 00 
    cb43:	48 19 c2             	sbb    %rax,%rdx
    cb46:	72 62                	jb     cbaa <fwp_fmt_duration+0x29a>
    cb48:	49 89 e6             	mov    %rsp,%r14
    cb4b:	4c 89 f7             	mov    %r14,%rdi
    cb4e:	4c 89 c2             	mov    %r8,%rdx
    cb51:	e8 ca f6 ff ff       	call   c220 <fwp_fmt_i128>
    cb56:	48 8d 35 6b 39 00 00 	lea    0x396b(%rip),%rsi        # 104c8 <exec_in_fp0+0xdc8>
    cb5d:	48 89 df             	mov    %rbx,%rdi
    cb60:	4c 89 f2             	mov    %r14,%rdx
    cb63:	31 c0                	xor    %eax,%eax
    cb65:	e8 06 69 ff ff       	call   3470 <sprintf@plt>
    cb6a:	e9 84 00 00 00       	jmp    cbf3 <fwp_fmt_duration+0x2e3>
    cb6f:	48 ba 00 a0 b8 30 46 	movabs $0x34630b8a000,%rdx
    cb76:	03 00 00 
    cb79:	45 31 ff             	xor    %r15d,%r15d
    cb7c:	eb 37                	jmp    cbb5 <fwp_fmt_duration+0x2a5>
    cb7e:	48 ba 00 58 47 f8 0d 	movabs $0xdf8475800,%rdx
    cb85:	00 00 00 
    cb88:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    cb8e:	eb 25                	jmp    cbb5 <fwp_fmt_duration+0x2a5>
    cb90:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
    cb95:	41 bf 02 00 00 00    	mov    $0x2,%r15d
    cb9b:	eb 18                	jmp    cbb5 <fwp_fmt_duration+0x2a5>
    cb9d:	ba 40 42 0f 00       	mov    $0xf4240,%edx
    cba2:	41 bf 03 00 00 00    	mov    $0x3,%r15d
    cba8:	eb 0b                	jmp    cbb5 <fwp_fmt_duration+0x2a5>
    cbaa:	ba e8 03 00 00       	mov    $0x3e8,%edx
    cbaf:	41 bf 04 00 00 00    	mov    $0x4,%r15d
    cbb5:	31 c9                	xor    %ecx,%ecx
    cbb7:	41 c1 e7 04          	shl    $0x4,%r15d
    cbbb:	4c 8d 25 1e 81 00 00 	lea    0x811e(%rip),%r12        # 14ce0 <fwp_fmt_duration.units>
    cbc2:	48 89 f7             	mov    %rsi,%rdi
    cbc5:	4c 89 c6             	mov    %r8,%rsi
    cbc8:	e8 e3 14 00 00       	call   e0b0 <__divti3>
    cbcd:	49 89 e6             	mov    %rsp,%r14
    cbd0:	4c 89 f7             	mov    %r14,%rdi
    cbd3:	48 89 c6             	mov    %rax,%rsi
    cbd6:	e8 45 f6 ff ff       	call   c220 <fwp_fmt_i128>
    cbdb:	4b 8b 0c 27          	mov    (%r15,%r12,1),%rcx
    cbdf:	48 8d 35 dd 38 00 00 	lea    0x38dd(%rip),%rsi        # 104c3 <exec_in_fp0+0xdc3>
    cbe6:	48 89 df             	mov    %rbx,%rdi
    cbe9:	4c 89 f2             	mov    %r14,%rdx
    cbec:	31 c0                	xor    %eax,%eax
    cbee:	e8 7d 68 ff ff       	call   3470 <sprintf@plt>
    cbf3:	48 83 c4 48          	add    $0x48,%rsp
    cbf7:	5b                   	pop    %rbx
    cbf8:	41 5c                	pop    %r12
    cbfa:	41 5e                	pop    %r14
    cbfc:	41 5f                	pop    %r15
    cbfe:	c3                   	ret
    cbff:	90                   	nop

000000000000cc00 <fwp_needs_parens>:
    cc00:	8b 06                	mov    (%rsi),%eax
    cc02:	83 f8 10             	cmp    $0x10,%eax
    cc05:	74 16                	je     cc1d <fwp_needs_parens+0x1d>
    cc07:	83 f8 0e             	cmp    $0xe,%eax
    cc0a:	0f 85 30 02 00 00    	jne    ce40 <fwp_is_negative>
    cc10:	31 c0                	xor    %eax,%eax
    cc12:	48 81 ff 00 10 00 00 	cmp    $0x1000,%rdi
    cc19:	0f 93 c0             	setae  %al
    cc1c:	c3                   	ret
    cc1d:	48 8b 46 08          	mov    0x8(%rsi),%rax
    cc21:	48 85 c0             	test   %rax,%rax
    cc24:	0f 84 16 02 00 00    	je     ce40 <fwp_is_negative>
    cc2a:	50                   	push   %rax
    cc2b:	48 8d 35 8e 37 00 00 	lea    0x378e(%rip),%rsi        # 103c0 <exec_in_fp0+0xcc0>
    cc32:	48 89 c7             	mov    %rax,%rdi
    cc35:	e8 96 66 ff ff       	call   32d0 <strcmp@plt>
    cc3a:	89 c1                	mov    %eax,%ecx
    cc3c:	31 c0                	xor    %eax,%eax
    cc3e:	85 c9                	test   %ecx,%ecx
    cc40:	0f 95 c0             	setne  %al
    cc43:	48 83 c4 08          	add    $0x8,%rsp
    cc47:	c3                   	ret
    cc48:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    cc4f:	00 

000000000000cc50 <fwp_format_g>:
    cc50:	55                   	push   %rbp
    cc51:	41 57                	push   %r15
    cc53:	41 56                	push   %r14
    cc55:	41 55                	push   %r13
    cc57:	41 54                	push   %r12
    cc59:	53                   	push   %rbx
    cc5a:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    cc61:	89 f5                	mov    %esi,%ebp
    cc63:	48 89 fb             	mov    %rdi,%rbx
    cc66:	ff cd                	dec    %ebp
    cc68:	48 8d 15 27 38 00 00 	lea    0x3827(%rip),%rdx        # 10496 <exec_in_fp0+0xd96>
    cc6f:	4c 8d 64 24 50       	lea    0x50(%rsp),%r12
    cc74:	be 40 00 00 00       	mov    $0x40,%esi
    cc79:	4c 89 e7             	mov    %r12,%rdi
    cc7c:	89 e9                	mov    %ebp,%ecx
    cc7e:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    cc84:	b0 01                	mov    $0x1,%al
    cc86:	e8 45 65 ff ff       	call   31d0 <snprintf@plt>
    cc8b:	4c 89 e7             	mov    %r12,%rdi
    cc8e:	be 65 00 00 00       	mov    $0x65,%esi
    cc93:	e8 18 65 ff ff       	call   31b0 <strchr@plt>
    cc98:	49 89 c7             	mov    %rax,%r15
    cc9b:	48 8d 78 01          	lea    0x1(%rax),%rdi
    cc9f:	e8 bc 67 ff ff       	call   3460 <atoi@plt>
    cca4:	41 89 c6             	mov    %eax,%r14d
    cca7:	41 8d 46 ef          	lea    -0x11(%r14),%eax
    ccab:	83 f8 e9             	cmp    $0xffffffe9,%eax
    ccae:	77 58                	ja     cd08 <fwp_format_g+0xb8>
    ccb0:	4d 29 e7             	sub    %r12,%r15
    ccb3:	4c 8d 6c 24 10       	lea    0x10(%rsp),%r13
    ccb8:	4c 89 ef             	mov    %r13,%rdi
    ccbb:	4c 89 e6             	mov    %r12,%rsi
    ccbe:	4c 89 fa             	mov    %r15,%rdx
    ccc1:	e8 6a 66 ff ff       	call   3330 <memcpy@plt>
    ccc6:	42 c6 44 3c 10 00    	movb   $0x0,0x10(%rsp,%r15,1)
    cccc:	4c 89 ef             	mov    %r13,%rdi
    cccf:	be 2e 00 00 00       	mov    $0x2e,%esi
    ccd4:	e8 d7 64 ff ff       	call   31b0 <strchr@plt>
    ccd9:	48 85 c0             	test   %rax,%rax
    ccdc:	0f 84 91 00 00 00    	je     cd73 <fwp_format_g+0x123>
    cce2:	4d 85 ff             	test   %r15,%r15
    cce5:	0f 84 88 00 00 00    	je     cd73 <fwp_format_g+0x123>
    cceb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    ccf0:	42 0f b6 44 3c 0f    	movzbl 0xf(%rsp,%r15,1),%eax
    ccf6:	83 f8 30             	cmp    $0x30,%eax
    ccf9:	75 6d                	jne    cd68 <fwp_format_g+0x118>
    ccfb:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    cd01:	49 ff cf             	dec    %r15
    cd04:	75 ea                	jne    ccf0 <fwp_format_g+0xa0>
    cd06:	eb 6b                	jmp    cd73 <fwp_format_g+0x123>
    cd08:	44 29 f5             	sub    %r14d,%ebp
    cd0b:	31 c9                	xor    %ecx,%ecx
    cd0d:	85 ed                	test   %ebp,%ebp
    cd0f:	0f 4f cd             	cmovg  %ebp,%ecx
    cd12:	48 8d 15 8c 37 00 00 	lea    0x378c(%rip),%rdx        # 104a5 <exec_in_fp0+0xda5>
    cd19:	be 90 01 00 00       	mov    $0x190,%esi
    cd1e:	48 89 df             	mov    %rbx,%rdi
    cd21:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    cd27:	b0 01                	mov    $0x1,%al
    cd29:	e8 a2 64 ff ff       	call   31d0 <snprintf@plt>
    cd2e:	48 89 df             	mov    %rbx,%rdi
    cd31:	e8 3a 64 ff ff       	call   3170 <strlen@plt>
    cd36:	49 89 c6             	mov    %rax,%r14
    cd39:	48 89 df             	mov    %rbx,%rdi
    cd3c:	be 2e 00 00 00       	mov    $0x2e,%esi
    cd41:	e8 6a 64 ff ff       	call   31b0 <strchr@plt>
    cd46:	48 85 c0             	test   %rax,%rax
    cd49:	74 5b                	je     cda6 <fwp_format_g+0x156>
    cd4b:	4d 85 f6             	test   %r14,%r14
    cd4e:	74 56                	je     cda6 <fwp_format_g+0x156>
    cd50:	42 0f b6 44 33 ff    	movzbl -0x1(%rbx,%r14,1),%eax
    cd56:	83 f8 30             	cmp    $0x30,%eax
    cd59:	75 5d                	jne    cdb8 <fwp_format_g+0x168>
    cd5b:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    cd61:	49 ff ce             	dec    %r14
    cd64:	75 ea                	jne    cd50 <fwp_format_g+0x100>
    cd66:	eb 3e                	jmp    cda6 <fwp_format_g+0x156>
    cd68:	83 f8 2e             	cmp    $0x2e,%eax
    cd6b:	75 06                	jne    cd73 <fwp_format_g+0x123>
    cd6d:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    cd73:	44 89 f0             	mov    %r14d,%eax
    cd76:	c1 e8 1f             	shr    $0x1f,%eax
    cd79:	44 8d 04 45 2b 00 00 	lea    0x2b(,%rax,2),%r8d
    cd80:	00 
    cd81:	45 89 f1             	mov    %r14d,%r9d
    cd84:	41 f7 d9             	neg    %r9d
    cd87:	45 0f 48 ce          	cmovs  %r14d,%r9d
    cd8b:	48 8d 15 09 37 00 00 	lea    0x3709(%rip),%rdx        # 1049b <exec_in_fp0+0xd9b>
    cd92:	48 8d 4c 24 10       	lea    0x10(%rsp),%rcx
    cd97:	be 90 01 00 00       	mov    $0x190,%esi
    cd9c:	48 89 df             	mov    %rbx,%rdi
    cd9f:	31 c0                	xor    %eax,%eax
    cda1:	e8 2a 64 ff ff       	call   31d0 <snprintf@plt>
    cda6:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    cdad:	5b                   	pop    %rbx
    cdae:	41 5c                	pop    %r12
    cdb0:	41 5d                	pop    %r13
    cdb2:	41 5e                	pop    %r14
    cdb4:	41 5f                	pop    %r15
    cdb6:	5d                   	pop    %rbp
    cdb7:	c3                   	ret
    cdb8:	83 f8 2e             	cmp    $0x2e,%eax
    cdbb:	75 e9                	jne    cda6 <fwp_format_g+0x156>
    cdbd:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    cdc3:	eb e1                	jmp    cda6 <fwp_format_g+0x156>
    cdc5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    cdcc:	00 00 00 00 

000000000000cdd0 <fwp_finish_float>:
    cdd0:	53                   	push   %rbx
    cdd1:	48 89 fb             	mov    %rdi,%rbx
    cdd4:	be 2e 00 00 00       	mov    $0x2e,%esi
    cdd9:	e8 d2 63 ff ff       	call   31b0 <strchr@plt>
    cdde:	48 85 c0             	test   %rax,%rax
    cde1:	74 02                	je     cde5 <fwp_finish_float+0x15>
    cde3:	5b                   	pop    %rbx
    cde4:	c3                   	ret
    cde5:	48 89 df             	mov    %rbx,%rdi
    cde8:	be 65 00 00 00       	mov    $0x65,%esi
    cded:	e8 be 63 ff ff       	call   31b0 <strchr@plt>
    cdf2:	48 85 c0             	test   %rax,%rax
    cdf5:	75 ec                	jne    cde3 <fwp_finish_float+0x13>
    cdf7:	48 8d 35 db 35 00 00 	lea    0x35db(%rip),%rsi        # 103d9 <exec_in_fp0+0xcd9>
    cdfe:	48 89 df             	mov    %rbx,%rdi
    ce01:	e8 ea 66 ff ff       	call   34f0 <strstr@plt>
    ce06:	48 85 c0             	test   %rax,%rax
    ce09:	75 d8                	jne    cde3 <fwp_finish_float+0x13>
    ce0b:	48 8d 35 cb 35 00 00 	lea    0x35cb(%rip),%rsi        # 103dd <exec_in_fp0+0xcdd>
    ce12:	48 89 df             	mov    %rbx,%rdi
    ce15:	e8 d6 66 ff ff       	call   34f0 <strstr@plt>
    ce1a:	48 85 c0             	test   %rax,%rax
    ce1d:	75 c4                	jne    cde3 <fwp_finish_float+0x13>
    ce1f:	48 89 df             	mov    %rbx,%rdi
    ce22:	e8 49 63 ff ff       	call   3170 <strlen@plt>
    ce27:	66 c7 04 03 2e 30    	movw   $0x302e,(%rbx,%rax,1)
    ce2d:	c6 44 03 02 00       	movb   $0x0,0x2(%rbx,%rax,1)
    ce32:	5b                   	pop    %rbx
    ce33:	c3                   	ret
    ce34:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    ce3b:	00 00 00 00 00 

000000000000ce40 <fwp_is_negative>:
    ce40:	50                   	push   %rax
    ce41:	8b 0e                	mov    (%rsi),%ecx
    ce43:	31 c0                	xor    %eax,%eax
    ce45:	48 83 f9 0b          	cmp    $0xb,%rcx
    ce49:	77 16                	ja     ce61 <fwp_is_negative+0x21>
    ce4b:	48 8d 15 c2 25 00 00 	lea    0x25c2(%rip),%rdx        # f414 <_IO_stdin_used+0x414>
    ce52:	48 63 0c 8a          	movslq (%rdx,%rcx,4),%rcx
    ce56:	48 01 d1             	add    %rdx,%rcx
    ce59:	ff e1                	jmp    *%rcx
    ce5b:	48 c1 ef 3f          	shr    $0x3f,%rdi
    ce5f:	89 f8                	mov    %edi,%eax
    ce61:	59                   	pop    %rcx
    ce62:	c3                   	ret
    ce63:	e8 48 94 ff ff       	call   62b0 <fwp_f32>
    ce68:	0f 50 c0             	movmskps %xmm0,%eax
    ce6b:	eb 09                	jmp    ce76 <fwp_is_negative+0x36>
    ce6d:	e8 9e 74 ff ff       	call   4310 <fwp_f64>
    ce72:	66 0f 50 c0          	movmskpd %xmm0,%eax
    ce76:	83 e0 01             	and    $0x1,%eax
    ce79:	59                   	pop    %rcx
    ce7a:	c3                   	ret
    ce7b:	e8 d0 dd ff ff       	call   ac50 <fwp_i128>
    ce80:	48 89 d0             	mov    %rdx,%rax
    ce83:	48 c1 e8 3f          	shr    $0x3f,%rax
    ce87:	59                   	pop    %rcx
    ce88:	c3                   	ret
    ce89:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000ce90 <fwp_emit>:
    ce90:	53                   	push   %rbx
    ce91:	48 83 ec 30          	sub    $0x30,%rsp
    ce95:	48 89 f8             	mov    %rdi,%rax
    ce98:	83 3d 81 a5 01 00 00 	cmpl   $0x0,0x1a581(%rip)        # 27420 <fwp_exec_binary_out>
    ce9f:	74 66                	je     cf07 <fwp_emit+0x77>
    cea1:	0f 57 c0             	xorps  %xmm0,%xmm0
    cea4:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    cea9:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    ceb0:	00 00 
    ceb2:	48 8d 15 0f 9e 00 00 	lea    0x9e0f(%rip),%rdx        # 16cc8 <d1>
    ceb9:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    cebe:	48 89 c6             	mov    %rax,%rsi
    cec1:	e8 9a 00 00 00       	call   cf60 <fwp_encode>
    cec6:	c6 44 24 0b 01       	movb   $0x1,0xb(%rsp)
    cecb:	8b 44 24 18          	mov    0x18(%rsp),%eax
    cecf:	89 44 24 0c          	mov    %eax,0xc(%rsp)
    ced3:	48 8d 7c 24 0b       	lea    0xb(%rsp),%rdi
    ced8:	be 05 00 00 00       	mov    $0x5,%esi
    cedd:	e8 4e a6 ff ff       	call   7530 <fwp_pipe_write>
    cee2:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    cee7:	48 85 f6             	test   %rsi,%rsi
    ceea:	74 0a                	je     cef6 <fwp_emit+0x66>
    ceec:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    cef1:	e8 3a a6 ff ff       	call   7530 <fwp_pipe_write>
    cef6:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    cefb:	e8 50 61 ff ff       	call   3050 <free@plt>
    cf00:	e8 9b 02 00 00       	call   d1a0 <fwp_pipe_frame_done>
    cf05:	eb 1c                	jmp    cf23 <fwp_emit+0x93>
    cf07:	83 3d ba 9d 00 00 10 	cmpl   $0x10,0x9dba(%rip)        # 16cc8 <d1>
    cf0e:	75 19                	jne    cf29 <fwp_emit+0x99>
    cf10:	83 3d c1 9d 00 00 00 	cmpl   $0x0,0x9dc1(%rip)        # 16cd8 <d1+0x10>
    cf17:	75 10                	jne    cf29 <fwp_emit+0x99>
    cf19:	48 83 3d af 9d 00 00 	cmpq   $0x0,0x9daf(%rip)        # 16cd0 <d1+0x8>
    cf20:	00 
    cf21:	75 06                	jne    cf29 <fwp_emit+0x99>
    cf23:	48 83 c4 30          	add    $0x30,%rsp
    cf27:	5b                   	pop    %rbx
    cf28:	c3                   	ret
    cf29:	48 8b 1d 80 80 00 00 	mov    0x8080(%rip),%rbx        # 14fb0 <stdout@GLIBC_2.2.5>
    cf30:	48 8b 13             	mov    (%rbx),%rdx
    cf33:	48 8d 35 8e 9d 00 00 	lea    0x9d8e(%rip),%rsi        # 16cc8 <d1>
    cf3a:	48 89 c7             	mov    %rax,%rdi
    cf3d:	e8 6e eb ff ff       	call   bab0 <fwp_display_top>
    cf42:	48 8b 33             	mov    (%rbx),%rsi
    cf45:	bf 0a 00 00 00       	mov    $0xa,%edi
    cf4a:	48 83 c4 30          	add    $0x30,%rsp
    cf4e:	5b                   	pop    %rbx
    cf4f:	e9 ec 62 ff ff       	jmp    3240 <fputc@plt>
    cf54:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    cf5b:	00 00 00 00 00 

000000000000cf60 <fwp_encode>:
    cf60:	41 57                	push   %r15
    cf62:	41 56                	push   %r14
    cf64:	41 55                	push   %r13
    cf66:	41 54                	push   %r12
    cf68:	53                   	push   %rbx
    cf69:	8b 02                	mov    (%rdx),%eax
    cf6b:	48 83 f8 15          	cmp    $0x15,%rax
    cf6f:	0f 87 14 02 00 00    	ja     d189 <fwp_encode+0x229>
    cf75:	49 89 d7             	mov    %rdx,%r15
    cf78:	49 89 f6             	mov    %rsi,%r14
    cf7b:	48 89 fb             	mov    %rdi,%rbx
    cf7e:	48 8d 0d bf 24 00 00 	lea    0x24bf(%rip),%rcx        # f444 <_IO_stdin_used+0x444>
    cf85:	48 63 04 81          	movslq (%rcx,%rax,4),%rax
    cf89:	48 01 c8             	add    %rcx,%rax
    cf8c:	ff e0                	jmp    *%rax
    cf8e:	48 89 df             	mov    %rbx,%rdi
    cf91:	4c 89 f6             	mov    %r14,%rsi
    cf94:	ba 01 00 00 00       	mov    $0x1,%edx
    cf99:	e9 77 01 00 00       	jmp    d115 <fwp_encode+0x1b5>
    cf9e:	48 89 df             	mov    %rbx,%rdi
    cfa1:	4c 89 f6             	mov    %r14,%rsi
    cfa4:	ba 04 00 00 00       	mov    $0x4,%edx
    cfa9:	e9 67 01 00 00       	jmp    d115 <fwp_encode+0x1b5>
    cfae:	49 8b 36             	mov    (%r14),%rsi
    cfb1:	48 89 df             	mov    %rbx,%rdi
    cfb4:	e8 57 02 00 00       	call   d210 <fwp_leb128>
    cfb9:	49 8b 16             	mov    (%r14),%rdx
    cfbc:	49 83 c6 08          	add    $0x8,%r14
    cfc0:	48 89 df             	mov    %rbx,%rdi
    cfc3:	4c 89 f6             	mov    %r14,%rsi
    cfc6:	5b                   	pop    %rbx
    cfc7:	41 5c                	pop    %r12
    cfc9:	41 5d                	pop    %r13
    cfcb:	41 5e                	pop    %r14
    cfcd:	41 5f                	pop    %r15
    cfcf:	e9 0c b6 ff ff       	jmp    85e0 <buf_put>
    cfd4:	48 89 df             	mov    %rbx,%rdi
    cfd7:	4c 89 f6             	mov    %r14,%rsi
    cfda:	ba 02 00 00 00       	mov    $0x2,%edx
    cfdf:	e9 31 01 00 00       	jmp    d115 <fwp_encode+0x1b5>
    cfe4:	49 8b 36             	mov    (%r14),%rsi
    cfe7:	48 89 df             	mov    %rbx,%rdi
    cfea:	e8 21 02 00 00       	call   d210 <fwp_leb128>
    cfef:	49 83 3e 00          	cmpq   $0x0,(%r14)
    cff3:	0f 84 90 01 00 00    	je     d189 <fwp_encode+0x229>
    cff9:	4d 8d 66 10          	lea    0x10(%r14),%r12
    cffd:	45 31 ed             	xor    %r13d,%r13d
    d000:	eb 1e                	jmp    d020 <fwp_encode+0xc0>
    d002:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d009:	1f 84 00 00 00 00 00 
    d010:	49 ff c5             	inc    %r13
    d013:	49 83 c4 10          	add    $0x10,%r12
    d017:	4d 3b 2e             	cmp    (%r14),%r13
    d01a:	0f 83 69 01 00 00    	jae    d189 <fwp_encode+0x229>
    d020:	49 8b 74 24 f8       	mov    -0x8(%r12),%rsi
    d025:	49 8b 57 38          	mov    0x38(%r15),%rdx
    d029:	48 89 df             	mov    %rbx,%rdi
    d02c:	e8 2f ff ff ff       	call   cf60 <fwp_encode>
    d031:	41 83 3f 12          	cmpl   $0x12,(%r15)
    d035:	75 d9                	jne    d010 <fwp_encode+0xb0>
    d037:	49 8b 34 24          	mov    (%r12),%rsi
    d03b:	49 8b 57 40          	mov    0x40(%r15),%rdx
    d03f:	48 89 df             	mov    %rbx,%rdi
    d042:	e8 19 ff ff ff       	call   cf60 <fwp_encode>
    d047:	eb c7                	jmp    d010 <fwp_encode+0xb0>
    d049:	4c 89 f7             	mov    %r14,%rdi
    d04c:	e8 4f dc ff ff       	call   aca0 <fwp_tag>
    d051:	41 89 c4             	mov    %eax,%r12d
    d054:	48 89 df             	mov    %rbx,%rdi
    d057:	4c 89 e6             	mov    %r12,%rsi
    d05a:	e8 b1 01 00 00       	call   d210 <fwp_leb128>
    d05f:	49 8b 47 28          	mov    0x28(%r15),%rax
    d063:	42 83 3c a0 00       	cmpl   $0x0,(%rax,%r12,4)
    d068:	0f 8e 1b 01 00 00    	jle    d189 <fwp_encode+0x229>
    d06e:	45 31 ed             	xor    %r13d,%r13d
    d071:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d078:	0f 1f 84 00 00 00 00 
    d07f:	00 
    d080:	4b 8b 74 ee 08       	mov    0x8(%r14,%r13,8),%rsi
    d085:	49 8b 47 30          	mov    0x30(%r15),%rax
    d089:	4a 8b 04 e0          	mov    (%rax,%r12,8),%rax
    d08d:	4a 8b 14 e8          	mov    (%rax,%r13,8),%rdx
    d091:	48 89 df             	mov    %rbx,%rdi
    d094:	e8 c7 fe ff ff       	call   cf60 <fwp_encode>
    d099:	49 ff c5             	inc    %r13
    d09c:	49 8b 47 28          	mov    0x28(%r15),%rax
    d0a0:	4a 63 04 a0          	movslq (%rax,%r12,4),%rax
    d0a4:	49 39 c5             	cmp    %rax,%r13
    d0a7:	7c d7                	jl     d080 <fwp_encode+0x120>
    d0a9:	e9 db 00 00 00       	jmp    d189 <fwp_encode+0x229>
    d0ae:	4c 89 f7             	mov    %r14,%rdi
    d0b1:	e8 9a db ff ff       	call   ac50 <fwp_i128>
    d0b6:	eb 3f                	jmp    d0f7 <fwp_encode+0x197>
    d0b8:	4c 89 f7             	mov    %r14,%rdi
    d0bb:	e8 80 d6 ff ff       	call   a740 <fwp_list_len>
    d0c0:	48 89 df             	mov    %rbx,%rdi
    d0c3:	48 89 c6             	mov    %rax,%rsi
    d0c6:	e8 45 01 00 00       	call   d210 <fwp_leb128>
    d0cb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    d0d0:	4d 85 f6             	test   %r14,%r14
    d0d3:	0f 84 b0 00 00 00    	je     d189 <fwp_encode+0x229>
    d0d9:	49 8b 76 08          	mov    0x8(%r14),%rsi
    d0dd:	49 8b 57 38          	mov    0x38(%r15),%rdx
    d0e1:	48 89 df             	mov    %rbx,%rdi
    d0e4:	e8 77 fe ff ff       	call   cf60 <fwp_encode>
    d0e9:	4d 8b 76 10          	mov    0x10(%r14),%r14
    d0ed:	eb e1                	jmp    d0d0 <fwp_encode+0x170>
    d0ef:	4c 89 f7             	mov    %r14,%rdi
    d0f2:	e8 69 db ff ff       	call   ac60 <fwp_u128>
    d0f7:	49 89 d6             	mov    %rdx,%r14
    d0fa:	48 89 df             	mov    %rbx,%rdi
    d0fd:	48 89 c6             	mov    %rax,%rsi
    d100:	ba 08 00 00 00       	mov    $0x8,%edx
    d105:	e8 b6 00 00 00       	call   d1c0 <fwp_le>
    d10a:	48 89 df             	mov    %rbx,%rdi
    d10d:	4c 89 f6             	mov    %r14,%rsi
    d110:	ba 08 00 00 00       	mov    $0x8,%edx
    d115:	5b                   	pop    %rbx
    d116:	41 5c                	pop    %r12
    d118:	41 5d                	pop    %r13
    d11a:	41 5e                	pop    %r14
    d11c:	41 5f                	pop    %r15
    d11e:	e9 9d 00 00 00       	jmp    d1c0 <fwp_le>
    d123:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    d128:	7e 5f                	jle    d189 <fwp_encode+0x229>
    d12a:	45 31 e4             	xor    %r12d,%r12d
    d12d:	0f 1f 00             	nopl   (%rax)
    d130:	4b 8b 74 e6 08       	mov    0x8(%r14,%r12,8),%rsi
    d135:	49 8b 47 20          	mov    0x20(%r15),%rax
    d139:	4a 8b 14 e0          	mov    (%rax,%r12,8),%rdx
    d13d:	48 89 df             	mov    %rbx,%rdi
    d140:	e8 1b fe ff ff       	call   cf60 <fwp_encode>
    d145:	49 ff c4             	inc    %r12
    d148:	49 63 47 10          	movslq 0x10(%r15),%rax
    d14c:	49 39 c4             	cmp    %rax,%r12
    d14f:	7c df                	jl     d130 <fwp_encode+0x1d0>
    d151:	eb 36                	jmp    d189 <fwp_encode+0x229>
    d153:	49 8b 36             	mov    (%r14),%rsi
    d156:	48 89 df             	mov    %rbx,%rdi
    d159:	e8 b2 00 00 00       	call   d210 <fwp_leb128>
    d15e:	49 83 3e 00          	cmpq   $0x0,(%r14)
    d162:	74 25                	je     d189 <fwp_encode+0x229>
    d164:	45 31 e4             	xor    %r12d,%r12d
    d167:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    d16e:	00 00 
    d170:	4b 8b 74 e6 08       	mov    0x8(%r14,%r12,8),%rsi
    d175:	49 8b 57 38          	mov    0x38(%r15),%rdx
    d179:	48 89 df             	mov    %rbx,%rdi
    d17c:	e8 df fd ff ff       	call   cf60 <fwp_encode>
    d181:	49 ff c4             	inc    %r12
    d184:	4d 3b 26             	cmp    (%r14),%r12
    d187:	72 e7                	jb     d170 <fwp_encode+0x210>
    d189:	5b                   	pop    %rbx
    d18a:	41 5c                	pop    %r12
    d18c:	41 5d                	pop    %r13
    d18e:	41 5e                	pop    %r14
    d190:	41 5f                	pop    %r15
    d192:	c3                   	ret
    d193:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d19a:	84 00 00 00 00 00 

000000000000d1a0 <fwp_pipe_frame_done>:
    d1a0:	83 3d 11 9b 00 00 00 	cmpl   $0x0,0x9b11(%rip)        # 16cb8 <fwp_po_listen>
    d1a7:	78 16                	js     d1bf <fwp_pipe_frame_done+0x1f>
    d1a9:	8b 05 c1 a2 02 00    	mov    0x2a2c1(%rip),%eax        # 37470 <fwp_po_frames>
    d1af:	ff c0                	inc    %eax
    d1b1:	89 05 b9 a2 02 00    	mov    %eax,0x2a2b9(%rip)        # 37470 <fwp_po_frames>
    d1b7:	a8 3f                	test   $0x3f,%al
    d1b9:	0f 84 11 e0 ff ff    	je     b1d0 <fwp_pipe_poll>
    d1bf:	c3                   	ret

000000000000d1c0 <fwp_le>:
    d1c0:	85 d2                	test   %edx,%edx
    d1c2:	7e 44                	jle    d208 <fwp_le+0x48>
    d1c4:	41 57                	push   %r15
    d1c6:	41 56                	push   %r14
    d1c8:	41 54                	push   %r12
    d1ca:	53                   	push   %rbx
    d1cb:	50                   	push   %rax
    d1cc:	48 89 f3             	mov    %rsi,%rbx
    d1cf:	49 89 fe             	mov    %rdi,%r14
    d1d2:	41 89 d4             	mov    %edx,%r12d
    d1d5:	49 c1 e4 03          	shl    $0x3,%r12
    d1d9:	45 31 ff             	xor    %r15d,%r15d
    d1dc:	0f 1f 40 00          	nopl   0x0(%rax)
    d1e0:	48 89 d8             	mov    %rbx,%rax
    d1e3:	44 89 f9             	mov    %r15d,%ecx
    d1e6:	48 d3 e8             	shr    %cl,%rax
    d1e9:	0f be f0             	movsbl %al,%esi
    d1ec:	4c 89 f7             	mov    %r14,%rdi
    d1ef:	e8 9c b3 ff ff       	call   8590 <buf_putc>
    d1f4:	49 83 c7 08          	add    $0x8,%r15
    d1f8:	4d 39 fc             	cmp    %r15,%r12
    d1fb:	75 e3                	jne    d1e0 <fwp_le+0x20>
    d1fd:	48 83 c4 08          	add    $0x8,%rsp
    d201:	5b                   	pop    %rbx
    d202:	41 5c                	pop    %r12
    d204:	41 5e                	pop    %r14
    d206:	41 5f                	pop    %r15
    d208:	c3                   	ret
    d209:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000d210 <fwp_leb128>:
    d210:	41 57                	push   %r15
    d212:	41 56                	push   %r14
    d214:	53                   	push   %rbx
    d215:	49 89 f6             	mov    %rsi,%r14
    d218:	48 89 fb             	mov    %rdi,%rbx
    d21b:	48 81 fe 80 00 00 00 	cmp    $0x80,%rsi
    d222:	73 05                	jae    d229 <fwp_leb128+0x19>
    d224:	4d 89 f7             	mov    %r14,%r15
    d227:	eb 27                	jmp    d250 <fwp_leb128+0x40>
    d229:	4d 89 f7             	mov    %r14,%r15
    d22c:	0f 1f 40 00          	nopl   0x0(%rax)
    d230:	49 c1 ef 07          	shr    $0x7,%r15
    d234:	44 89 f0             	mov    %r14d,%eax
    d237:	0c 80                	or     $0x80,%al
    d239:	0f be f0             	movsbl %al,%esi
    d23c:	48 89 df             	mov    %rbx,%rdi
    d23f:	e8 4c b3 ff ff       	call   8590 <buf_putc>
    d244:	49 81 fe ff 3f 00 00 	cmp    $0x3fff,%r14
    d24b:	4d 89 fe             	mov    %r15,%r14
    d24e:	77 e0                	ja     d230 <fwp_leb128+0x20>
    d250:	41 0f be f7          	movsbl %r15b,%esi
    d254:	48 89 df             	mov    %rbx,%rdi
    d257:	5b                   	pop    %rbx
    d258:	41 5e                	pop    %r14
    d25a:	41 5f                	pop    %r15
    d25c:	e9 2f b3 ff ff       	jmp    8590 <buf_putc>
    d261:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d268:	0f 1f 84 00 00 00 00 
    d26f:	00 

000000000000d270 <fwp_pipe_read>:
    d270:	55                   	push   %rbp
    d271:	41 57                	push   %r15
    d273:	41 56                	push   %r14
    d275:	41 55                	push   %r13
    d277:	41 54                	push   %r12
    d279:	53                   	push   %rbx
    d27a:	50                   	push   %rax
    d27b:	48 89 f3             	mov    %rsi,%rbx
    d27e:	8b 05 f0 a1 02 00    	mov    0x2a1f0(%rip),%eax        # 37474 <fwp_pi_kind>
    d284:	83 f8 01             	cmp    $0x1,%eax
    d287:	0f 84 89 00 00 00    	je     d316 <fwp_pipe_read+0xa6>
    d28d:	83 f8 02             	cmp    $0x2,%eax
    d290:	0f 85 d7 00 00 00    	jne    d36d <fwp_pipe_read+0xfd>
    d296:	48 89 3c 24          	mov    %rdi,(%rsp)
    d29a:	4c 8b 25 d7 a1 02 00 	mov    0x2a1d7(%rip),%r12        # 37478 <fwp_pi_ring>
    d2a1:	4d 8d ac 24 c0 00 00 	lea    0xc0(%r12),%r13
    d2a8:	00 
    d2a9:	49 8d ac 24 c4 00 00 	lea    0xc4(%r12),%rbp
    d2b0:	00 
    d2b1:	4c 8d 35 b8 01 00 00 	lea    0x1b8(%rip),%r14        # d470 <fwp_ring_has_data>
    d2b8:	45 31 ff             	xor    %r15d,%r15d
    d2bb:	eb 23                	jmp    d2e0 <fwp_pipe_read+0x70>
    d2bd:	0f 1f 00             	nopl   (%rax)
    d2c0:	44 8b 05 fd 99 00 00 	mov    0x99fd(%rip),%r8d        # 16cc4 <fwp_pi_sock>
    d2c7:	4c 89 e7             	mov    %r12,%rdi
    d2ca:	4c 89 ee             	mov    %r13,%rsi
    d2cd:	48 89 ea             	mov    %rbp,%rdx
    d2d0:	4c 89 f1             	mov    %r14,%rcx
    d2d3:	e8 98 dc ff ff       	call   af70 <fwp_ring_wait>
    d2d8:	85 c0                	test   %eax,%eax
    d2da:	0f 84 6c 01 00 00    	je     d44c <fwp_pipe_read+0x1dc>
    d2e0:	49 8b 4c 24 40       	mov    0x40(%r12),%rcx
    d2e5:	49 8b 84 24 80 00 00 	mov    0x80(%r12),%rax
    d2ec:	00 
    d2ed:	48 29 c1             	sub    %rax,%rcx
    d2f0:	0f 85 9c 00 00 00    	jne    d392 <fwp_pipe_read+0x122>
    d2f6:	41 8b 84 24 40 01 00 	mov    0x140(%r12),%eax
    d2fd:	00 
    d2fe:	85 c0                	test   %eax,%eax
    d300:	74 be                	je     d2c0 <fwp_pipe_read+0x50>
    d302:	49 8b 44 24 40       	mov    0x40(%r12),%rax
    d307:	49 3b 84 24 80 00 00 	cmp    0x80(%r12),%rax
    d30e:	00 
    d30f:	75 af                	jne    d2c0 <fwp_pipe_read+0x50>
    d311:	e9 36 01 00 00       	jmp    d44c <fwp_pipe_read+0x1dc>
    d316:	4c 8b 35 63 a1 02 00 	mov    0x2a163(%rip),%r14        # 37480 <fwp_pi_pos>
    d31d:	4c 8b 3d 64 a1 02 00 	mov    0x2a164(%rip),%r15        # 37488 <fwp_pi_len>
    d324:	4d 39 fe             	cmp    %r15,%r14
    d327:	0f 85 f9 00 00 00    	jne    d426 <fwp_pipe_read+0x1b6>
    d32d:	49 89 fc             	mov    %rdi,%r12
    d330:	4c 8d 35 59 a1 02 00 	lea    0x2a159(%rip),%r14        # 37490 <fwp_pi_buf>
    d337:	45 31 ff             	xor    %r15d,%r15d
    d33a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    d340:	8b 3d 7e 99 00 00    	mov    0x997e(%rip),%edi        # 16cc4 <fwp_pi_sock>
    d346:	ba 00 00 01 00       	mov    $0x10000,%edx
    d34b:	4c 89 f6             	mov    %r14,%rsi
    d34e:	31 c9                	xor    %ecx,%ecx
    d350:	e8 0b 5d ff ff       	call   3060 <recv@plt>
    d355:	48 85 c0             	test   %rax,%rax
    d358:	0f 89 b6 00 00 00    	jns    d414 <fwp_pipe_read+0x1a4>
    d35e:	e8 1d 5d ff ff       	call   3080 <__errno_location@plt>
    d363:	83 38 04             	cmpl   $0x4,(%rax)
    d366:	74 d8                	je     d340 <fwp_pipe_read+0xd0>
    d368:	e9 df 00 00 00       	jmp    d44c <fwp_pipe_read+0x1dc>
    d36d:	48 8b 05 44 7c 00 00 	mov    0x7c44(%rip),%rax        # 14fb8 <stdin@GLIBC_2.2.5>
    d374:	48 8b 08             	mov    (%rax),%rcx
    d377:	be 01 00 00 00       	mov    $0x1,%esi
    d37c:	48 89 da             	mov    %rbx,%rdx
    d37f:	48 83 c4 08          	add    $0x8,%rsp
    d383:	5b                   	pop    %rbx
    d384:	41 5c                	pop    %r12
    d386:	41 5d                	pop    %r13
    d388:	41 5e                	pop    %r14
    d38a:	41 5f                	pop    %r15
    d38c:	5d                   	pop    %rbp
    d38d:	e9 5e 5d ff ff       	jmp    30f0 <fread@plt>
    d392:	48 39 d9             	cmp    %rbx,%rcx
    d395:	48 0f 42 d9          	cmovb  %rcx,%rbx
    d399:	4d 8b 74 24 08       	mov    0x8(%r12),%r14
    d39e:	49 8d 4e ff          	lea    -0x1(%r14),%rcx
    d3a2:	48 21 c1             	and    %rax,%rcx
    d3a5:	49 29 ce             	sub    %rcx,%r14
    d3a8:	4c 39 f3             	cmp    %r14,%rbx
    d3ab:	4c 0f 42 f3          	cmovb  %rbx,%r14
    d3af:	4d 8d bc 24 00 10 00 	lea    0x1000(%r12),%r15
    d3b6:	00 
    d3b7:	49 8d 34 0c          	lea    (%r12,%rcx,1),%rsi
    d3bb:	48 81 c6 00 10 00 00 	add    $0x1000,%rsi
    d3c2:	4c 8b 2c 24          	mov    (%rsp),%r13
    d3c6:	4c 89 ef             	mov    %r13,%rdi
    d3c9:	4c 89 f2             	mov    %r14,%rdx
    d3cc:	e8 5f 5f ff ff       	call   3330 <memcpy@plt>
    d3d1:	4d 01 f5             	add    %r14,%r13
    d3d4:	48 89 da             	mov    %rbx,%rdx
    d3d7:	4c 29 f2             	sub    %r14,%rdx
    d3da:	4c 89 ef             	mov    %r13,%rdi
    d3dd:	4c 89 fe             	mov    %r15,%rsi
    d3e0:	e8 4b 5f ff ff       	call   3330 <memcpy@plt>
    d3e5:	49 8b 84 24 80 00 00 	mov    0x80(%r12),%rax
    d3ec:	00 
    d3ed:	48 01 d8             	add    %rbx,%rax
    d3f0:	49 89 84 24 80 00 00 	mov    %rax,0x80(%r12)
    d3f7:	00 
    d3f8:	49 8d bc 24 00 01 00 	lea    0x100(%r12),%rdi
    d3ff:	00 
    d400:	49 81 c4 04 01 00 00 	add    $0x104,%r12
    d407:	4c 89 e6             	mov    %r12,%rsi
    d40a:	e8 c1 dc ff ff       	call   b0d0 <fwp_ring_wake>
    d40f:	49 89 df             	mov    %rbx,%r15
    d412:	eb 38                	jmp    d44c <fwp_pipe_read+0x1dc>
    d414:	74 48                	je     d45e <fwp_pipe_read+0x1ee>
    d416:	4c 89 e7             	mov    %r12,%rdi
    d419:	48 89 05 68 a0 02 00 	mov    %rax,0x2a068(%rip)        # 37488 <fwp_pi_len>
    d420:	45 31 f6             	xor    %r14d,%r14d
    d423:	49 89 c7             	mov    %rax,%r15
    d426:	4d 29 f7             	sub    %r14,%r15
    d429:	49 39 df             	cmp    %rbx,%r15
    d42c:	4c 0f 43 fb          	cmovae %rbx,%r15
    d430:	48 8d 35 59 a0 02 00 	lea    0x2a059(%rip),%rsi        # 37490 <fwp_pi_buf>
    d437:	4c 01 f6             	add    %r14,%rsi
    d43a:	4c 89 fa             	mov    %r15,%rdx
    d43d:	e8 ee 5e ff ff       	call   3330 <memcpy@plt>
    d442:	4d 01 fe             	add    %r15,%r14
    d445:	4c 89 35 34 a0 02 00 	mov    %r14,0x2a034(%rip)        # 37480 <fwp_pi_pos>
    d44c:	4c 89 f8             	mov    %r15,%rax
    d44f:	48 83 c4 08          	add    $0x8,%rsp
    d453:	5b                   	pop    %rbx
    d454:	41 5c                	pop    %r12
    d456:	41 5d                	pop    %r13
    d458:	41 5e                	pop    %r14
    d45a:	41 5f                	pop    %r15
    d45c:	5d                   	pop    %rbp
    d45d:	c3                   	ret
    d45e:	45 31 ff             	xor    %r15d,%r15d
    d461:	eb e9                	jmp    d44c <fwp_pipe_read+0x1dc>
    d463:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d46a:	84 00 00 00 00 00 

000000000000d470 <fwp_ring_has_data>:
    d470:	48 8b 4f 40          	mov    0x40(%rdi),%rcx
    d474:	b8 01 00 00 00       	mov    $0x1,%eax
    d479:	48 3b 8f 80 00 00 00 	cmp    0x80(%rdi),%rcx
    d480:	75 0d                	jne    d48f <fwp_ring_has_data+0x1f>
    d482:	8b 8f 40 01 00 00    	mov    0x140(%rdi),%ecx
    d488:	31 c0                	xor    %eax,%eax
    d48a:	85 c9                	test   %ecx,%ecx
    d48c:	0f 95 c0             	setne  %al
    d48f:	c3                   	ret

000000000000d490 <fwp_pipe_report>:
    d490:	53                   	push   %rbx
    d491:	48 89 fb             	mov    %rdi,%rbx
    d494:	48 8d 3d 3d 30 00 00 	lea    0x303d(%rip),%rdi        # 104d8 <exec_in_fp0+0xdd8>
    d49b:	e8 90 5b ff ff       	call   3030 <getenv@plt>
    d4a0:	48 85 c0             	test   %rax,%rax
    d4a3:	74 18                	je     d4bd <fwp_pipe_report+0x2d>
    d4a5:	80 38 00             	cmpb   $0x0,(%rax)
    d4a8:	74 13                	je     d4bd <fwp_pipe_report+0x2d>
    d4aa:	48 8d 35 fa 2f 00 00 	lea    0x2ffa(%rip),%rsi        # 104ab <exec_in_fp0+0xdab>
    d4b1:	48 89 c7             	mov    %rax,%rdi
    d4b4:	e8 17 5e ff ff       	call   32d0 <strcmp@plt>
    d4b9:	85 c0                	test   %eax,%eax
    d4bb:	75 02                	jne    d4bf <fwp_pipe_report+0x2f>
    d4bd:	5b                   	pop    %rbx
    d4be:	c3                   	ret
    d4bf:	48 8b 05 12 7b 00 00 	mov    0x7b12(%rip),%rax        # 14fd8 <stderr@GLIBC_2.2.5>
    d4c6:	48 8b 38             	mov    (%rax),%rdi
    d4c9:	48 8d 35 1d 30 00 00 	lea    0x301d(%rip),%rsi        # 104ed <exec_in_fp0+0xded>
    d4d0:	48 89 da             	mov    %rbx,%rdx
    d4d3:	31 c0                	xor    %eax,%eax
    d4d5:	5b                   	pop    %rbx
    d4d6:	e9 15 5e ff ff       	jmp    32f0 <fprintf@plt>
    d4db:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000d4e0 <rd_le>:
    d4e0:	55                   	push   %rbp
    d4e1:	41 56                	push   %r14
    d4e3:	53                   	push   %rbx
    d4e4:	48 83 ec 10          	sub    $0x10,%rsp
    d4e8:	48 89 d3             	mov    %rdx,%rbx
    d4eb:	89 f5                	mov    %esi,%ebp
    d4ed:	41 89 f6             	mov    %esi,%r14d
    d4f0:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    d4f5:	4c 89 f6             	mov    %r14,%rsi
    d4f8:	e8 23 01 00 00       	call   d620 <rd_take>
    d4fd:	85 c0                	test   %eax,%eax
    d4ff:	74 20                	je     d521 <rd_le+0x41>
    d501:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    d508:	b8 01 00 00 00       	mov    $0x1,%eax
    d50d:	85 ed                	test   %ebp,%ebp
    d50f:	7e 7d                	jle    d58e <rd_le+0xae>
    d511:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    d516:	83 fd 01             	cmp    $0x1,%ebp
    d519:	75 0a                	jne    d525 <rd_le+0x45>
    d51b:	31 d2                	xor    %edx,%edx
    d51d:	31 ff                	xor    %edi,%edi
    d51f:	eb 55                	jmp    d576 <rd_le+0x96>
    d521:	31 c0                	xor    %eax,%eax
    d523:	eb 69                	jmp    d58e <rd_le+0xae>
    d525:	45 89 f0             	mov    %r14d,%r8d
    d528:	41 81 e0 fe ff ff 7f 	and    $0x7ffffffe,%r8d
    d52f:	41 b9 08 00 00 00    	mov    $0x8,%r9d
    d535:	31 d2                	xor    %edx,%edx
    d537:	31 ff                	xor    %edi,%edi
    d539:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    d540:	44 0f b6 14 16       	movzbl (%rsi,%rdx,1),%r10d
    d545:	41 8d 49 f8          	lea    -0x8(%r9),%ecx
    d549:	80 e1 f0             	and    $0xf0,%cl
    d54c:	49 d3 e2             	shl    %cl,%r10
    d54f:	49 09 fa             	or     %rdi,%r10
    d552:	4c 89 13             	mov    %r10,(%rbx)
    d555:	0f b6 7c 16 01       	movzbl 0x1(%rsi,%rdx,1),%edi
    d55a:	44 89 c9             	mov    %r9d,%ecx
    d55d:	80 e1 f8             	and    $0xf8,%cl
    d560:	48 d3 e7             	shl    %cl,%rdi
    d563:	4c 09 d7             	or     %r10,%rdi
    d566:	48 89 3b             	mov    %rdi,(%rbx)
    d569:	48 83 c2 02          	add    $0x2,%rdx
    d56d:	49 83 c1 10          	add    $0x10,%r9
    d571:	49 39 d0             	cmp    %rdx,%r8
    d574:	75 ca                	jne    d540 <rd_le+0x60>
    d576:	41 f6 c6 01          	test   $0x1,%r14b
    d57a:	74 12                	je     d58e <rd_le+0xae>
    d57c:	0f b6 34 16          	movzbl (%rsi,%rdx,1),%esi
    d580:	c1 e2 03             	shl    $0x3,%edx
    d583:	89 d1                	mov    %edx,%ecx
    d585:	48 d3 e6             	shl    %cl,%rsi
    d588:	48 09 fe             	or     %rdi,%rsi
    d58b:	48 89 33             	mov    %rsi,(%rbx)
    d58e:	48 83 c4 10          	add    $0x10,%rsp
    d592:	5b                   	pop    %rbx
    d593:	41 5e                	pop    %r14
    d595:	5d                   	pop    %rbp
    d596:	c3                   	ret
    d597:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    d59e:	00 00 

000000000000d5a0 <rd_leb>:
    d5a0:	41 57                	push   %r15
    d5a2:	41 56                	push   %r14
    d5a4:	41 54                	push   %r12
    d5a6:	53                   	push   %rbx
    d5a7:	50                   	push   %rax
    d5a8:	48 89 f3             	mov    %rsi,%rbx
    d5ab:	49 89 fe             	mov    %rdi,%r14
    d5ae:	48 c7 06 00 00 00 00 	movq   $0x0,(%rsi)
    d5b5:	49 c7 c7 f9 ff ff ff 	mov    $0xfffffffffffffff9,%r15
    d5bc:	49 89 e4             	mov    %rsp,%r12
    d5bf:	90                   	nop
    d5c0:	be 01 00 00 00       	mov    $0x1,%esi
    d5c5:	4c 89 f7             	mov    %r14,%rdi
    d5c8:	4c 89 e2             	mov    %r12,%rdx
    d5cb:	e8 50 00 00 00       	call   d620 <rd_take>
    d5d0:	85 c0                	test   %eax,%eax
    d5d2:	74 2f                	je     d603 <rd_leb+0x63>
    d5d4:	48 8b 04 24          	mov    (%rsp),%rax
    d5d8:	0f b6 10             	movzbl (%rax),%edx
    d5db:	49 83 ff 38          	cmp    $0x38,%r15
    d5df:	75 07                	jne    d5e8 <rd_leb+0x48>
    d5e1:	89 d1                	mov    %edx,%ecx
    d5e3:	80 e1 7e             	and    $0x7e,%cl
    d5e6:	75 1b                	jne    d603 <rd_leb+0x63>
    d5e8:	49 83 c7 07          	add    $0x7,%r15
    d5ec:	83 e2 7f             	and    $0x7f,%edx
    d5ef:	44 89 f9             	mov    %r15d,%ecx
    d5f2:	48 d3 e2             	shl    %cl,%rdx
    d5f5:	48 09 13             	or     %rdx,(%rbx)
    d5f8:	80 38 00             	cmpb   $0x0,(%rax)
    d5fb:	79 0a                	jns    d607 <rd_leb+0x67>
    d5fd:	49 83 ff 38          	cmp    $0x38,%r15
    d601:	76 bd                	jbe    d5c0 <rd_leb+0x20>
    d603:	31 c0                	xor    %eax,%eax
    d605:	eb 05                	jmp    d60c <rd_leb+0x6c>
    d607:	b8 01 00 00 00       	mov    $0x1,%eax
    d60c:	48 83 c4 08          	add    $0x8,%rsp
    d610:	5b                   	pop    %rbx
    d611:	41 5c                	pop    %r12
    d613:	41 5e                	pop    %r14
    d615:	41 5f                	pop    %r15
    d617:	c3                   	ret
    d618:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    d61f:	00 

000000000000d620 <rd_take>:
    d620:	4c 8b 47 08          	mov    0x8(%rdi),%r8
    d624:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    d628:	49 29 c8             	sub    %rcx,%r8
    d62b:	31 c0                	xor    %eax,%eax
    d62d:	49 39 f0             	cmp    %rsi,%r8
    d630:	72 15                	jb     d647 <rd_take+0x27>
    d632:	48 8b 07             	mov    (%rdi),%rax
    d635:	48 01 c8             	add    %rcx,%rax
    d638:	48 89 02             	mov    %rax,(%rdx)
    d63b:	48 01 ce             	add    %rcx,%rsi
    d63e:	48 89 77 10          	mov    %rsi,0x10(%rdi)
    d642:	b8 01 00 00 00       	mov    $0x1,%eax
    d647:	c3                   	ret
    d648:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    d64f:	00 

000000000000d650 <fwp_getc>:
    d650:	48 63 05 d5 9d 01 00 	movslq 0x19dd5(%rip),%rax        # 2742c <fwp_in_ppos>
    d657:	3b 05 cb 9d 01 00    	cmp    0x19dcb(%rip),%eax        # 27428 <fwp_in_npend>
    d65d:	7d 15                	jge    d674 <fwp_getc+0x24>
    d65f:	8d 48 01             	lea    0x1(%rax),%ecx
    d662:	89 0d c4 9d 01 00    	mov    %ecx,0x19dc4(%rip)        # 2742c <fwp_in_ppos>
    d668:	48 8d 0d b5 9d 01 00 	lea    0x19db5(%rip),%rcx        # 27424 <fwp_in_pend>
    d66f:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax
    d673:	c3                   	ret
    d674:	48 8b 05 3d 79 00 00 	mov    0x793d(%rip),%rax        # 14fb8 <stdin@GLIBC_2.2.5>
    d67b:	48 8b 38             	mov    (%rax),%rdi
    d67e:	e9 9d 5b ff ff       	jmp    3220 <fgetc@plt>
    d683:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d68a:	84 00 00 00 00 00 

000000000000d690 <fwp_gc_find_data>:
    d690:	0f b7 77 18          	movzwl 0x18(%rdi),%esi
    d694:	48 85 f6             	test   %rsi,%rsi
    d697:	0f 84 be 00 00 00    	je     d75b <fwp_gc_find_data+0xcb>
    d69d:	53                   	push   %rbx
    d69e:	48 8b 07             	mov    (%rdi),%rax
    d6a1:	4c 8b 47 10          	mov    0x10(%rdi),%r8
    d6a5:	48 6b ce 38          	imul   $0x38,%rsi,%rcx
    d6a9:	45 31 c9             	xor    %r9d,%r9d
    d6ac:	48 8d 15 e5 7b 00 00 	lea    0x7be5(%rip),%rdx        # 15298 <fwp_gc>
    d6b3:	41 bb 01 00 00 00    	mov    $0x1,%r11d
    d6b9:	45 31 d2             	xor    %r10d,%r10d
    d6bc:	eb 0b                	jmp    d6c9 <fwp_gc_find_data+0x39>
    d6be:	66 90                	xchg   %ax,%ax
    d6c0:	49 83 c1 38          	add    $0x38,%r9
    d6c4:	4c 39 c9             	cmp    %r9,%rcx
    d6c7:	74 22                	je     d6eb <fwp_gc_find_data+0x5b>
    d6c9:	43 83 3c 08 01       	cmpl   $0x1,(%r8,%r9,1)
    d6ce:	75 f0                	jne    d6c0 <fwp_gc_find_data+0x30>
    d6d0:	4b 8b 5c 08 10       	mov    0x10(%r8,%r9,1),%rbx
    d6d5:	48 01 c3             	add    %rax,%rbx
    d6d8:	48 39 d3             	cmp    %rdx,%rbx
    d6db:	77 e3                	ja     d6c0 <fwp_gc_find_data+0x30>
    d6dd:	4b 03 5c 08 28       	add    0x28(%r8,%r9,1),%rbx
    d6e2:	48 39 d3             	cmp    %rdx,%rbx
    d6e5:	45 0f 47 d3          	cmova  %r11d,%r10d
    d6e9:	eb d5                	jmp    d6c0 <fwp_gc_find_data+0x30>
    d6eb:	31 c0                	xor    %eax,%eax
    d6ed:	45 85 d2             	test   %r10d,%r10d
    d6f0:	0f 95 c0             	setne  %al
    d6f3:	74 6e                	je     d763 <fwp_gc_find_data+0xd3>
    d6f5:	66 85 f6             	test   %si,%si
    d6f8:	74 69                	je     d763 <fwp_gc_find_data+0xd3>
    d6fa:	8b 05 28 8d 00 00    	mov    0x8d28(%rip),%eax        # 16428 <fwp_gc+0x1190>
    d700:	48 8b 77 10          	mov    0x10(%rdi),%rsi
    d704:	45 31 c0             	xor    %r8d,%r8d
    d707:	eb 10                	jmp    d719 <fwp_gc_find_data+0x89>
    d709:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    d710:	49 83 c0 38          	add    $0x38,%r8
    d714:	4c 39 c1             	cmp    %r8,%rcx
    d717:	74 45                	je     d75e <fwp_gc_find_data+0xce>
    d719:	42 83 3c 06 01       	cmpl   $0x1,(%rsi,%r8,1)
    d71e:	75 f0                	jne    d710 <fwp_gc_find_data+0x80>
    d720:	42 f6 44 06 04 02    	testb  $0x2,0x4(%rsi,%r8,1)
    d726:	74 e8                	je     d710 <fwp_gc_find_data+0x80>
    d728:	83 f8 10             	cmp    $0x10,%eax
    d72b:	74 31                	je     d75e <fwp_gc_find_data+0xce>
    d72d:	4e 8b 4c 06 10       	mov    0x10(%rsi,%r8,1),%r9
    d732:	4c 03 0f             	add    (%rdi),%r9
    d735:	4c 63 d0             	movslq %eax,%r10
    d738:	49 c1 e2 04          	shl    $0x4,%r10
    d73c:	4d 89 8c 12 90 10 00 	mov    %r9,0x1090(%r10,%rdx,1)
    d743:	00 
    d744:	4e 8b 4c 06 28       	mov    0x28(%rsi,%r8,1),%r9
    d749:	4d 89 8c 12 98 10 00 	mov    %r9,0x1098(%r10,%rdx,1)
    d750:	00 
    d751:	ff c0                	inc    %eax
    d753:	89 05 cf 8c 00 00    	mov    %eax,0x8ccf(%rip)        # 16428 <fwp_gc+0x1190>
    d759:	eb b5                	jmp    d710 <fwp_gc_find_data+0x80>
    d75b:	31 c0                	xor    %eax,%eax
    d75d:	c3                   	ret
    d75e:	b8 01 00 00 00       	mov    $0x1,%eax
    d763:	5b                   	pop    %rbx
    d764:	c3                   	ret
    d765:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    d76c:	00 00 00 00 

000000000000d770 <fwp_gc_report>:
    d770:	41 57                	push   %r15
    d772:	41 56                	push   %r14
    d774:	53                   	push   %rbx
    d775:	48 83 ec 50          	sub    $0x50,%rsp
    d779:	48 8b 05 28 8d 00 00 	mov    0x8d28(%rip),%rax        # 164a8 <fwp_gc+0x1210>
    d780:	48 8b 0d 11 7b 00 00 	mov    0x7b11(%rip),%rcx        # 15298 <fwp_gc>
    d787:	48 29 c8             	sub    %rcx,%rax
    d78a:	f2 48 0f 2a c8       	cvtsi2sd %rax,%xmm1
    d78f:	f2 0f 58 0d e9 8c 00 	addsd  0x8ce9(%rip),%xmm1        # 16480 <fwp_gc+0x11e8>
    d796:	00 
    d797:	f2 0f 11 0d e1 8c 00 	movsd  %xmm1,0x8ce1(%rip)        # 16480 <fwp_gc+0x11e8>
    d79e:	00 
    d79f:	48 89 0d 02 8d 00 00 	mov    %rcx,0x8d02(%rip)        # 164a8 <fwp_gc+0x1210>
    d7a6:	48 8b 05 2b 78 00 00 	mov    0x782b(%rip),%rax        # 14fd8 <stderr@GLIBC_2.2.5>
    d7ad:	4c 8b 38             	mov    (%rax),%r15
    d7b0:	48 8b 1d b9 8c 00 00 	mov    0x8cb9(%rip),%rbx        # 16470 <fwp_gc+0x11d8>
    d7b7:	4c 8b 35 f2 8a 00 00 	mov    0x8af2(%rip),%r14        # 162b0 <fwp_gc+0x1018>
    d7be:	f2 0f 10 15 da 8c 00 	movsd  0x8cda(%rip),%xmm2        # 164a0 <fwp_gc+0x1208>
    d7c5:	00 
    d7c6:	f2 0f 58 ca          	addsd  %xmm2,%xmm1
    d7ca:	f2 0f 10 05 a6 19 00 	movsd  0x19a6(%rip),%xmm0        # f178 <_IO_stdin_used+0x178>
    d7d1:	00 
    d7d2:	f2 0f 59 c8          	mulsd  %xmm0,%xmm1
    d7d6:	f2 0f 11 4c 24 18    	movsd  %xmm1,0x18(%rsp)
    d7dc:	f2 0f 59 d0          	mulsd  %xmm0,%xmm2
    d7e0:	f2 0f 11 54 24 10    	movsd  %xmm2,0x10(%rsp)
    d7e6:	f2 0f 10 0d f2 8a 00 	movsd  0x8af2(%rip),%xmm1        # 162e0 <fwp_gc+0x1048>
    d7ed:	00 
    d7ee:	66 0f 28 15 2a 19 00 	movapd 0x192a(%rip),%xmm2        # f120 <_IO_stdin_used+0x120>
    d7f5:	00 
    d7f6:	0f 14 ca             	unpcklps %xmm2,%xmm1
    d7f9:	66 0f 28 1d 2f 19 00 	movapd 0x192f(%rip),%xmm3        # f130 <_IO_stdin_used+0x130>
    d800:	00 
    d801:	66 0f 5c cb          	subpd  %xmm3,%xmm1
    d805:	66 0f 28 e1          	movapd %xmm1,%xmm4
    d809:	66 0f 15 e1          	unpckhpd %xmm1,%xmm4
    d80d:	f2 0f 58 e1          	addsd  %xmm1,%xmm4
    d811:	f2 0f 59 e0          	mulsd  %xmm0,%xmm4
    d815:	66 0f 29 64 24 40    	movapd %xmm4,0x40(%rsp)
    d81b:	f2 0f 10 0d 3d 8c 00 	movsd  0x8c3d(%rip),%xmm1        # 16460 <fwp_gc+0x11c8>
    d822:	00 
    d823:	0f 14 ca             	unpcklps %xmm2,%xmm1
    d826:	66 0f 5c cb          	subpd  %xmm3,%xmm1
    d82a:	66 0f 28 e1          	movapd %xmm1,%xmm4
    d82e:	66 0f 15 e1          	unpckhpd %xmm1,%xmm4
    d832:	f2 0f 58 e1          	addsd  %xmm1,%xmm4
    d836:	f2 0f 59 e0          	mulsd  %xmm0,%xmm4
    d83a:	66 0f 29 64 24 30    	movapd %xmm4,0x30(%rsp)
    d840:	f2 0f 10 0d 20 8c 00 	movsd  0x8c20(%rip),%xmm1        # 16468 <fwp_gc+0x11d0>
    d847:	00 
    d848:	0f 14 ca             	unpcklps %xmm2,%xmm1
    d84b:	66 0f 5c cb          	subpd  %xmm3,%xmm1
    d84f:	66 0f 28 d1          	movapd %xmm1,%xmm2
    d853:	66 0f 15 d1          	unpckhpd %xmm1,%xmm2
    d857:	f2 0f 58 d1          	addsd  %xmm1,%xmm2
    d85b:	f2 0f 59 d0          	mulsd  %xmm0,%xmm2
    d85f:	66 0f 29 54 24 20    	movapd %xmm2,0x20(%rsp)
    d865:	f2 0f 10 05 1b 8c 00 	movsd  0x8c1b(%rip),%xmm0        # 16488 <fwp_gc+0x11f0>
    d86c:	00 
    d86d:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    d873:	f2 0f 10 05 15 8c 00 	movsd  0x8c15(%rip),%xmm0        # 16490 <fwp_gc+0x11f8>
    d87a:	00 
    d87b:	f2 0f 11 04 24       	movsd  %xmm0,(%rsp)
    d880:	e8 6b 00 00 00       	call   d8f0 <fwp_gc_status_kb>
    d885:	83 3d 00 8a 00 00 00 	cmpl   $0x0,0x8a00(%rip)        # 1628c <fwp_gc+0xff4>
    d88c:	48 8d 0d f7 2d 00 00 	lea    0x2df7(%rip),%rcx        # 1068a <exec_in_fp0+0xf8a>
    d893:	4c 8d 0d 55 26 00 00 	lea    0x2655(%rip),%r9        # feef <exec_in_fp0+0x7ef>
    d89a:	4c 0f 44 c9          	cmove  %rcx,%r9
    d89e:	48 8d 35 30 2d 00 00 	lea    0x2d30(%rip),%rsi        # 105d5 <exec_in_fp0+0xed5>
    d8a5:	4c 89 ff             	mov    %r15,%rdi
    d8a8:	48 89 da             	mov    %rbx,%rdx
    d8ab:	4c 89 f1             	mov    %r14,%rcx
    d8ae:	f2 0f 10 44 24 18    	movsd  0x18(%rsp),%xmm0
    d8b4:	f2 0f 10 4c 24 10    	movsd  0x10(%rsp),%xmm1
    d8ba:	0f 28 54 24 40       	movaps 0x40(%rsp),%xmm2
    d8bf:	0f 28 5c 24 30       	movaps 0x30(%rsp),%xmm3
    d8c4:	0f 28 64 24 20       	movaps 0x20(%rsp),%xmm4
    d8c9:	f2 0f 10 6c 24 08    	movsd  0x8(%rsp),%xmm5
    d8cf:	f2 0f 10 34 24       	movsd  (%rsp),%xmm6
    d8d4:	49 89 c0             	mov    %rax,%r8
    d8d7:	b0 07                	mov    $0x7,%al
    d8d9:	48 83 c4 50          	add    $0x50,%rsp
    d8dd:	5b                   	pop    %rbx
    d8de:	41 5e                	pop    %r14
    d8e0:	41 5f                	pop    %r15
    d8e2:	e9 09 5a ff ff       	jmp    32f0 <fprintf@plt>
    d8e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    d8ee:	00 00 

000000000000d8f0 <fwp_gc_status_kb>:
    d8f0:	55                   	push   %rbp
    d8f1:	41 57                	push   %r15
    d8f3:	41 56                	push   %r14
    d8f5:	41 54                	push   %r12
    d8f7:	53                   	push   %rbx
    d8f8:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
    d8ff:	48 8d 3d 96 2d 00 00 	lea    0x2d96(%rip),%rdi        # 1069c <exec_in_fp0+0xf9c>
    d906:	48 8d 35 ad 2b 00 00 	lea    0x2bad(%rip),%rsi        # 104ba <exec_in_fp0+0xdba>
    d90d:	e8 0e 5b ff ff       	call   3420 <fopen@plt>
    d912:	48 85 c0             	test   %rax,%rax
    d915:	74 7d                	je     d994 <fwp_gc_status_kb+0xa4>
    d917:	48 89 c3             	mov    %rax,%rbx
    d91a:	48 89 e7             	mov    %rsp,%rdi
    d91d:	be 00 01 00 00       	mov    $0x100,%esi
    d922:	48 89 c2             	mov    %rax,%rdx
    d925:	e8 66 59 ff ff       	call   3290 <fgets@plt>
    d92a:	49 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%r14
    d931:	48 85 c0             	test   %rax,%rax
    d934:	74 54                	je     d98a <fwp_gc_status_kb+0x9a>
    d936:	4c 8d 7c 24 06       	lea    0x6(%rsp),%r15
    d93b:	bd 56 6d 48 57       	mov    $0x57486d56,%ebp
    d940:	49 89 e4             	mov    %rsp,%r12
    d943:	eb 20                	jmp    d965 <fwp_gc_status_kb+0x75>
    d945:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    d94c:	00 00 00 00 
    d950:	4c 89 e7             	mov    %r12,%rdi
    d953:	be 00 01 00 00       	mov    $0x100,%esi
    d958:	48 89 da             	mov    %rbx,%rdx
    d95b:	e8 30 59 ff ff       	call   3290 <fgets@plt>
    d960:	48 85 c0             	test   %rax,%rax
    d963:	74 25                	je     d98a <fwp_gc_status_kb+0x9a>
    d965:	8b 04 24             	mov    (%rsp),%eax
    d968:	31 e8                	xor    %ebp,%eax
    d96a:	0f b6 4c 24 04       	movzbl 0x4(%rsp),%ecx
    d96f:	83 f1 4d             	xor    $0x4d,%ecx
    d972:	09 c1                	or     %eax,%ecx
    d974:	75 da                	jne    d950 <fwp_gc_status_kb+0x60>
    d976:	80 7c 24 05 3a       	cmpb   $0x3a,0x5(%rsp)
    d97b:	75 d3                	jne    d950 <fwp_gc_status_kb+0x60>
    d97d:	4c 89 ff             	mov    %r15,%rdi
    d980:	e8 7b 5a ff ff       	call   3400 <atol@plt>
    d985:	49 89 c6             	mov    %rax,%r14
    d988:	eb c6                	jmp    d950 <fwp_gc_status_kb+0x60>
    d98a:	48 89 df             	mov    %rbx,%rdi
    d98d:	e8 be 57 ff ff       	call   3150 <fclose@plt>
    d992:	eb 07                	jmp    d99b <fwp_gc_status_kb+0xab>
    d994:	49 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%r14
    d99b:	4c 89 f0             	mov    %r14,%rax
    d99e:	48 81 c4 00 01 00 00 	add    $0x100,%rsp
    d9a5:	5b                   	pop    %rbx
    d9a6:	41 5c                	pop    %r12
    d9a8:	41 5e                	pop    %r14
    d9aa:	41 5f                	pop    %r15
    d9ac:	5d                   	pop    %rbp
    d9ad:	c3                   	ret
    d9ae:	66 90                	xchg   %ax,%ax

000000000000d9b0 <w2>:
    d9b0:	55                   	push   %rbp
    d9b1:	41 57                	push   %r15
    d9b3:	41 56                	push   %r14
    d9b5:	41 55                	push   %r13
    d9b7:	41 54                	push   %r12
    d9b9:	53                   	push   %rbx
    d9ba:	48 81 ec b8 01 00 00 	sub    $0x1b8,%rsp
    d9c1:	49 89 f6             	mov    %rsi,%r14
    d9c4:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
    d9c9:	48 89 f7             	mov    %rsi,%rdi
    d9cc:	48 c7 c6 80 ff ff ff 	mov    $0xffffffffffffff80,%rsi
    d9d3:	e8 78 8a ff ff       	call   6450 <f12>
    d9d8:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    d9dd:	49 89 c7             	mov    %rax,%r15
    d9e0:	48 8d 35 49 03 00 00 	lea    0x349(%rip),%rsi        # dd30 <fwp_owner_release0>
    d9e7:	4c 8d ac 24 a0 01 00 	lea    0x1a0(%rsp),%r13
    d9ee:	00 
    d9ef:	48 8d 54 24 30       	lea    0x30(%rsp),%rdx
    d9f4:	4c 89 ef             	mov    %r13,%rdi
    d9f7:	e8 a4 02 00 00       	call   dca0 <fwp_cleanup_push>
    d9fc:	be ff 00 00 00       	mov    $0xff,%esi
    da01:	4c 89 f7             	mov    %r14,%rdi
    da04:	e8 57 8b ff ff       	call   6560 <f14>
    da09:	49 89 c4             	mov    %rax,%r12
    da0c:	4c 89 ef             	mov    %r13,%rdi
    da0f:	e8 fc 02 00 00       	call   dd10 <fwp_cleanup_pop>
    da14:	4c 89 7c 24 38       	mov    %r15,0x38(%rsp)
    da19:	4c 89 64 24 40       	mov    %r12,0x40(%rsp)
    da1e:	48 8d 35 1b 03 00 00 	lea    0x31b(%rip),%rsi        # dd40 <fwp_owner_release1>
    da25:	4c 8d ac 24 88 01 00 	lea    0x188(%rsp),%r13
    da2c:	00 
    da2d:	48 8d 54 24 38       	lea    0x38(%rsp),%rdx
    da32:	4c 89 ef             	mov    %r13,%rdi
    da35:	e8 66 02 00 00       	call   dca0 <fwp_cleanup_push>
    da3a:	4c 89 f7             	mov    %r14,%rdi
    da3d:	48 c7 c6 00 80 ff ff 	mov    $0xffffffffffff8000,%rsi
    da44:	e8 27 8b ff ff       	call   6570 <f16>
    da49:	48 89 c5             	mov    %rax,%rbp
    da4c:	4c 89 ef             	mov    %r13,%rdi
    da4f:	e8 bc 02 00 00       	call   dd10 <fwp_cleanup_pop>
    da54:	4c 89 7c 24 48       	mov    %r15,0x48(%rsp)
    da59:	4c 89 64 24 50       	mov    %r12,0x50(%rsp)
    da5e:	48 89 6c 24 58       	mov    %rbp,0x58(%rsp)
    da63:	48 8d 35 f6 02 00 00 	lea    0x2f6(%rip),%rsi        # dd60 <fwp_owner_release2>
    da6a:	48 8d 9c 24 70 01 00 	lea    0x170(%rsp),%rbx
    da71:	00 
    da72:	48 8d 54 24 48       	lea    0x48(%rsp),%rdx
    da77:	48 89 df             	mov    %rbx,%rdi
    da7a:	e8 21 02 00 00       	call   dca0 <fwp_cleanup_push>
    da7f:	be ff ff 00 00       	mov    $0xffff,%esi
    da84:	4c 89 f7             	mov    %r14,%rdi
    da87:	e8 f4 8a ff ff       	call   6580 <f18>
    da8c:	49 89 c5             	mov    %rax,%r13
    da8f:	48 89 df             	mov    %rbx,%rdi
    da92:	e8 79 02 00 00       	call   dd10 <fwp_cleanup_pop>
    da97:	4c 89 7c 24 60       	mov    %r15,0x60(%rsp)
    da9c:	4c 89 3c 24          	mov    %r15,(%rsp)
    daa0:	4c 89 64 24 68       	mov    %r12,0x68(%rsp)
    daa5:	4c 89 e3             	mov    %r12,%rbx
    daa8:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
    daad:	48 89 6c 24 70       	mov    %rbp,0x70(%rsp)
    dab2:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
    dab7:	4c 89 6c 24 78       	mov    %r13,0x78(%rsp)
    dabc:	48 8d 35 bd 02 00 00 	lea    0x2bd(%rip),%rsi        # dd80 <fwp_owner_release3>
    dac3:	48 8d bc 24 40 01 00 	lea    0x140(%rsp),%rdi
    daca:	00 
    dacb:	48 8d 54 24 60       	lea    0x60(%rsp),%rdx
    dad0:	e8 cb 01 00 00       	call   dca0 <fwp_cleanup_push>
    dad5:	4c 89 f7             	mov    %r14,%rdi
    dad8:	48 c7 c6 00 00 00 80 	mov    $0xffffffff80000000,%rsi
    dadf:	e8 ac 8a ff ff       	call   6590 <f20>
    dae4:	49 89 c4             	mov    %rax,%r12
    dae7:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    daec:	48 8d bc 24 40 01 00 	lea    0x140(%rsp),%rdi
    daf3:	00 
    daf4:	e8 17 02 00 00       	call   dd10 <fwp_cleanup_pop>
    daf9:	4c 89 bc 24 80 00 00 	mov    %r15,0x80(%rsp)
    db00:	00 
    db01:	48 89 9c 24 88 00 00 	mov    %rbx,0x88(%rsp)
    db08:	00 
    db09:	48 89 ac 24 90 00 00 	mov    %rbp,0x90(%rsp)
    db10:	00 
    db11:	4c 89 ac 24 98 00 00 	mov    %r13,0x98(%rsp)
    db18:	00 
    db19:	4c 89 a4 24 a0 00 00 	mov    %r12,0xa0(%rsp)
    db20:	00 
    db21:	48 8d 35 88 02 00 00 	lea    0x288(%rip),%rsi        # ddb0 <fwp_owner_release4>
    db28:	4c 8d a4 24 58 01 00 	lea    0x158(%rsp),%r12
    db2f:	00 
    db30:	48 8d 94 24 80 00 00 	lea    0x80(%rsp),%rdx
    db37:	00 
    db38:	4c 89 e7             	mov    %r12,%rdi
    db3b:	e8 60 01 00 00       	call   dca0 <fwp_cleanup_push>
    db40:	b8 00 00 00 80       	mov    $0x80000000,%eax
    db45:	48 8d b0 ff ff ff 7f 	lea    0x7fffffff(%rax),%rsi
    db4c:	4c 89 f7             	mov    %r14,%rdi
    db4f:	4c 89 f3             	mov    %r14,%rbx
    db52:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    db57:	e8 44 8a ff ff       	call   65a0 <f22>
    db5c:	49 89 c7             	mov    %rax,%r15
    db5f:	4c 89 e7             	mov    %r12,%rdi
    db62:	e8 a9 01 00 00       	call   dd10 <fwp_cleanup_pop>
    db67:	48 8b 04 24          	mov    (%rsp),%rax
    db6b:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
    db72:	00 
    db73:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
    db78:	48 89 ac 24 b0 00 00 	mov    %rbp,0xb0(%rsp)
    db7f:	00 
    db80:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    db85:	4c 89 a4 24 b8 00 00 	mov    %r12,0xb8(%rsp)
    db8c:	00 
    db8d:	4c 89 ac 24 c0 00 00 	mov    %r13,0xc0(%rsp)
    db94:	00 
    db95:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
    db9a:	4c 89 b4 24 c8 00 00 	mov    %r14,0xc8(%rsp)
    dba1:	00 
    dba2:	4c 89 bc 24 d0 00 00 	mov    %r15,0xd0(%rsp)
    dba9:	00 
    dbaa:	48 8d 35 3f 02 00 00 	lea    0x23f(%rip),%rsi        # ddf0 <fwp_owner_release5>
    dbb1:	48 8d bc 24 28 01 00 	lea    0x128(%rsp),%rdi
    dbb8:	00 
    dbb9:	48 8d 94 24 a8 00 00 	lea    0xa8(%rsp),%rdx
    dbc0:	00 
    dbc1:	e8 da 00 00 00       	call   dca0 <fwp_cleanup_push>
    dbc6:	be 00 00 00 80       	mov    $0x80000000,%esi
    dbcb:	48 89 df             	mov    %rbx,%rdi
    dbce:	e8 dd 89 ff ff       	call   65b0 <f24>
    dbd3:	48 89 c3             	mov    %rax,%rbx
    dbd6:	48 8d bc 24 28 01 00 	lea    0x128(%rsp),%rdi
    dbdd:	00 
    dbde:	e8 2d 01 00 00       	call   dd10 <fwp_cleanup_pop>
    dbe3:	48 8b 04 24          	mov    (%rsp),%rax
    dbe7:	48 89 84 24 d8 00 00 	mov    %rax,0xd8(%rsp)
    dbee:	00 
    dbef:	48 89 ac 24 e0 00 00 	mov    %rbp,0xe0(%rsp)
    dbf6:	00 
    dbf7:	4c 89 a4 24 e8 00 00 	mov    %r12,0xe8(%rsp)
    dbfe:	00 
    dbff:	4c 89 ac 24 f0 00 00 	mov    %r13,0xf0(%rsp)
    dc06:	00 
    dc07:	4c 89 b4 24 f8 00 00 	mov    %r14,0xf8(%rsp)
    dc0e:	00 
    dc0f:	4c 89 bc 24 00 01 00 	mov    %r15,0x100(%rsp)
    dc16:	00 
    dc17:	48 89 9c 24 08 01 00 	mov    %rbx,0x108(%rsp)
    dc1e:	00 
    dc1f:	48 8d 35 0a 02 00 00 	lea    0x20a(%rip),%rsi        # de30 <fwp_owner_release6>
    dc26:	48 8d bc 24 10 01 00 	lea    0x110(%rsp),%rdi
    dc2d:	00 
    dc2e:	48 8d 94 24 d8 00 00 	lea    0xd8(%rsp),%rdx
    dc35:	00 
    dc36:	e8 65 00 00 00       	call   dca0 <fwp_cleanup_push>
    dc3b:	48 be 00 00 00 00 00 	movabs $0x8000000000000000,%rsi
    dc42:	00 00 80 
    dc45:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    dc4a:	e8 71 89 ff ff       	call   65c0 <f26>
    dc4f:	49 89 c6             	mov    %rax,%r14
    dc52:	48 8d bc 24 10 01 00 	lea    0x110(%rsp),%rdi
    dc59:	00 
    dc5a:	e8 b1 00 00 00       	call   dd10 <fwp_cleanup_pop>
    dc5f:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    dc64:	48 8b 0c 24          	mov    (%rsp),%rcx
    dc68:	48 89 08             	mov    %rcx,(%rax)
    dc6b:	48 89 68 08          	mov    %rbp,0x8(%rax)
    dc6f:	4c 89 60 10          	mov    %r12,0x10(%rax)
    dc73:	4c 89 68 18          	mov    %r13,0x18(%rax)
    dc77:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    dc7c:	48 89 48 20          	mov    %rcx,0x20(%rax)
    dc80:	4c 89 78 28          	mov    %r15,0x28(%rax)
    dc84:	48 89 58 30          	mov    %rbx,0x30(%rax)
    dc88:	4c 89 70 38          	mov    %r14,0x38(%rax)
    dc8c:	48 81 c4 b8 01 00 00 	add    $0x1b8,%rsp
    dc93:	5b                   	pop    %rbx
    dc94:	41 5c                	pop    %r12
    dc96:	41 5d                	pop    %r13
    dc98:	41 5e                	pop    %r14
    dc9a:	41 5f                	pop    %r15
    dc9c:	5d                   	pop    %rbp
    dc9d:	c3                   	ret
    dc9e:	66 90                	xchg   %ax,%ax

000000000000dca0 <fwp_cleanup_push>:
    dca0:	48 8b 05 31 97 00 00 	mov    0x9731(%rip),%rax        # 173d8 <fwp_cleanups>
    dca7:	48 89 07             	mov    %rax,(%rdi)
    dcaa:	48 89 77 08          	mov    %rsi,0x8(%rdi)
    dcae:	48 89 57 10          	mov    %rdx,0x10(%rdi)
    dcb2:	48 89 3d 1f 97 00 00 	mov    %rdi,0x971f(%rip)        # 173d8 <fwp_cleanups>
    dcb9:	c3                   	ret
    dcba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000dcc0 <fwp_owner_release7>:
    dcc0:	53                   	push   %rbx
    dcc1:	48 89 fb             	mov    %rdi,%rbx
    dcc4:	48 8b 3f             	mov    (%rdi),%rdi
    dcc7:	e8 b4 01 00 00       	call   de80 <fwp_drop0>
    dccc:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    dcd0:	e8 cb 01 00 00       	call   dea0 <fwp_drop1>
    dcd5:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    dcd9:	e8 e2 01 00 00       	call   dec0 <fwp_drop2>
    dcde:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    dce2:	e8 f9 01 00 00       	call   dee0 <fwp_drop3>
    dce7:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    dceb:	e8 10 02 00 00       	call   df00 <fwp_drop4>
    dcf0:	48 8b 7b 28          	mov    0x28(%rbx),%rdi
    dcf4:	e8 27 02 00 00       	call   df20 <fwp_drop5>
    dcf9:	48 8b 7b 30          	mov    0x30(%rbx),%rdi
    dcfd:	e8 3e 02 00 00       	call   df40 <fwp_drop6>
    dd02:	48 8b 7b 38          	mov    0x38(%rbx),%rdi
    dd06:	5b                   	pop    %rbx
    dd07:	e9 54 02 00 00       	jmp    df60 <fwp_drop7>
    dd0c:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000dd10 <fwp_cleanup_pop>:
    dd10:	48 39 3d c1 96 00 00 	cmp    %rdi,0x96c1(%rip)        # 173d8 <fwp_cleanups>
    dd17:	75 0b                	jne    dd24 <fwp_cleanup_pop+0x14>
    dd19:	48 8b 07             	mov    (%rdi),%rax
    dd1c:	48 89 05 b5 96 00 00 	mov    %rax,0x96b5(%rip)        # 173d8 <fwp_cleanups>
    dd23:	c3                   	ret
    dd24:	50                   	push   %rax
    dd25:	e8 46 53 ff ff       	call   3070 <abort@plt>
    dd2a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000dd30 <fwp_owner_release0>:
    dd30:	48 8b 3f             	mov    (%rdi),%rdi
    dd33:	e9 48 01 00 00       	jmp    de80 <fwp_drop0>
    dd38:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    dd3f:	00 

000000000000dd40 <fwp_owner_release1>:
    dd40:	53                   	push   %rbx
    dd41:	48 89 fb             	mov    %rdi,%rbx
    dd44:	48 8b 3f             	mov    (%rdi),%rdi
    dd47:	e8 34 01 00 00       	call   de80 <fwp_drop0>
    dd4c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    dd50:	5b                   	pop    %rbx
    dd51:	e9 4a 01 00 00       	jmp    dea0 <fwp_drop1>
    dd56:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    dd5d:	00 00 00 

000000000000dd60 <fwp_owner_release2>:
    dd60:	53                   	push   %rbx
    dd61:	48 89 fb             	mov    %rdi,%rbx
    dd64:	48 8b 3f             	mov    (%rdi),%rdi
    dd67:	e8 14 01 00 00       	call   de80 <fwp_drop0>
    dd6c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    dd70:	e8 2b 01 00 00       	call   dea0 <fwp_drop1>
    dd75:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    dd79:	5b                   	pop    %rbx
    dd7a:	e9 41 01 00 00       	jmp    dec0 <fwp_drop2>
    dd7f:	90                   	nop

000000000000dd80 <fwp_owner_release3>:
    dd80:	53                   	push   %rbx
    dd81:	48 89 fb             	mov    %rdi,%rbx
    dd84:	48 8b 3f             	mov    (%rdi),%rdi
    dd87:	e8 f4 00 00 00       	call   de80 <fwp_drop0>
    dd8c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    dd90:	e8 0b 01 00 00       	call   dea0 <fwp_drop1>
    dd95:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    dd99:	e8 22 01 00 00       	call   dec0 <fwp_drop2>
    dd9e:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    dda2:	5b                   	pop    %rbx
    dda3:	e9 38 01 00 00       	jmp    dee0 <fwp_drop3>
    dda8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    ddaf:	00 

000000000000ddb0 <fwp_owner_release4>:
    ddb0:	53                   	push   %rbx
    ddb1:	48 89 fb             	mov    %rdi,%rbx
    ddb4:	48 8b 3f             	mov    (%rdi),%rdi
    ddb7:	e8 c4 00 00 00       	call   de80 <fwp_drop0>
    ddbc:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    ddc0:	e8 db 00 00 00       	call   dea0 <fwp_drop1>
    ddc5:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    ddc9:	e8 f2 00 00 00       	call   dec0 <fwp_drop2>
    ddce:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    ddd2:	e8 09 01 00 00       	call   dee0 <fwp_drop3>
    ddd7:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    dddb:	5b                   	pop    %rbx
    dddc:	e9 1f 01 00 00       	jmp    df00 <fwp_drop4>
    dde1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    dde8:	0f 1f 84 00 00 00 00 
    ddef:	00 

000000000000ddf0 <fwp_owner_release5>:
    ddf0:	53                   	push   %rbx
    ddf1:	48 89 fb             	mov    %rdi,%rbx
    ddf4:	48 8b 3f             	mov    (%rdi),%rdi
    ddf7:	e8 84 00 00 00       	call   de80 <fwp_drop0>
    ddfc:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    de00:	e8 9b 00 00 00       	call   dea0 <fwp_drop1>
    de05:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    de09:	e8 b2 00 00 00       	call   dec0 <fwp_drop2>
    de0e:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    de12:	e8 c9 00 00 00       	call   dee0 <fwp_drop3>
    de17:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    de1b:	e8 e0 00 00 00       	call   df00 <fwp_drop4>
    de20:	48 8b 7b 28          	mov    0x28(%rbx),%rdi
    de24:	5b                   	pop    %rbx
    de25:	e9 f6 00 00 00       	jmp    df20 <fwp_drop5>
    de2a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000de30 <fwp_owner_release6>:
    de30:	53                   	push   %rbx
    de31:	48 89 fb             	mov    %rdi,%rbx
    de34:	48 8b 3f             	mov    (%rdi),%rdi
    de37:	e8 44 00 00 00       	call   de80 <fwp_drop0>
    de3c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    de40:	e8 5b 00 00 00       	call   dea0 <fwp_drop1>
    de45:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    de49:	e8 72 00 00 00       	call   dec0 <fwp_drop2>
    de4e:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    de52:	e8 89 00 00 00       	call   dee0 <fwp_drop3>
    de57:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    de5b:	e8 a0 00 00 00       	call   df00 <fwp_drop4>
    de60:	48 8b 7b 28          	mov    0x28(%rbx),%rdi
    de64:	e8 b7 00 00 00       	call   df20 <fwp_drop5>
    de69:	48 8b 7b 30          	mov    0x30(%rbx),%rdi
    de6d:	5b                   	pop    %rbx
    de6e:	e9 cd 00 00 00       	jmp    df40 <fwp_drop6>
    de73:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    de7a:	84 00 00 00 00 00 

000000000000de80 <fwp_drop0>:
    de80:	53                   	push   %rbx
    de81:	48 89 fb             	mov    %rdi,%rbx
    de84:	e8 c7 5d ff ff       	call   3c50 <fwp_rc_release_last>
    de89:	85 c0                	test   %eax,%eax
    de8b:	74 09                	je     de96 <fwp_drop0+0x16>
    de8d:	48 89 df             	mov    %rbx,%rdi
    de90:	5b                   	pop    %rbx
    de91:	e9 ea 5d ff ff       	jmp    3c80 <fwp_rc_free_arr>
    de96:	5b                   	pop    %rbx
    de97:	c3                   	ret
    de98:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    de9f:	00 

000000000000dea0 <fwp_drop1>:
    dea0:	53                   	push   %rbx
    dea1:	48 89 fb             	mov    %rdi,%rbx
    dea4:	e8 a7 5d ff ff       	call   3c50 <fwp_rc_release_last>
    dea9:	85 c0                	test   %eax,%eax
    deab:	74 09                	je     deb6 <fwp_drop1+0x16>
    dead:	48 89 df             	mov    %rbx,%rdi
    deb0:	5b                   	pop    %rbx
    deb1:	e9 ca 5d ff ff       	jmp    3c80 <fwp_rc_free_arr>
    deb6:	5b                   	pop    %rbx
    deb7:	c3                   	ret
    deb8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    debf:	00 

000000000000dec0 <fwp_drop2>:
    dec0:	53                   	push   %rbx
    dec1:	48 89 fb             	mov    %rdi,%rbx
    dec4:	e8 87 5d ff ff       	call   3c50 <fwp_rc_release_last>
    dec9:	85 c0                	test   %eax,%eax
    decb:	74 09                	je     ded6 <fwp_drop2+0x16>
    decd:	48 89 df             	mov    %rbx,%rdi
    ded0:	5b                   	pop    %rbx
    ded1:	e9 aa 5d ff ff       	jmp    3c80 <fwp_rc_free_arr>
    ded6:	5b                   	pop    %rbx
    ded7:	c3                   	ret
    ded8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    dedf:	00 

000000000000dee0 <fwp_drop3>:
    dee0:	53                   	push   %rbx
    dee1:	48 89 fb             	mov    %rdi,%rbx
    dee4:	e8 67 5d ff ff       	call   3c50 <fwp_rc_release_last>
    dee9:	85 c0                	test   %eax,%eax
    deeb:	74 09                	je     def6 <fwp_drop3+0x16>
    deed:	48 89 df             	mov    %rbx,%rdi
    def0:	5b                   	pop    %rbx
    def1:	e9 8a 5d ff ff       	jmp    3c80 <fwp_rc_free_arr>
    def6:	5b                   	pop    %rbx
    def7:	c3                   	ret
    def8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    deff:	00 

000000000000df00 <fwp_drop4>:
    df00:	53                   	push   %rbx
    df01:	48 89 fb             	mov    %rdi,%rbx
    df04:	e8 47 5d ff ff       	call   3c50 <fwp_rc_release_last>
    df09:	85 c0                	test   %eax,%eax
    df0b:	74 09                	je     df16 <fwp_drop4+0x16>
    df0d:	48 89 df             	mov    %rbx,%rdi
    df10:	5b                   	pop    %rbx
    df11:	e9 6a 5d ff ff       	jmp    3c80 <fwp_rc_free_arr>
    df16:	5b                   	pop    %rbx
    df17:	c3                   	ret
    df18:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    df1f:	00 

000000000000df20 <fwp_drop5>:
    df20:	53                   	push   %rbx
    df21:	48 89 fb             	mov    %rdi,%rbx
    df24:	e8 27 5d ff ff       	call   3c50 <fwp_rc_release_last>
    df29:	85 c0                	test   %eax,%eax
    df2b:	74 09                	je     df36 <fwp_drop5+0x16>
    df2d:	48 89 df             	mov    %rbx,%rdi
    df30:	5b                   	pop    %rbx
    df31:	e9 4a 5d ff ff       	jmp    3c80 <fwp_rc_free_arr>
    df36:	5b                   	pop    %rbx
    df37:	c3                   	ret
    df38:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    df3f:	00 

000000000000df40 <fwp_drop6>:
    df40:	53                   	push   %rbx
    df41:	48 89 fb             	mov    %rdi,%rbx
    df44:	e8 07 5d ff ff       	call   3c50 <fwp_rc_release_last>
    df49:	85 c0                	test   %eax,%eax
    df4b:	74 09                	je     df56 <fwp_drop6+0x16>
    df4d:	48 89 df             	mov    %rbx,%rdi
    df50:	5b                   	pop    %rbx
    df51:	e9 2a 5d ff ff       	jmp    3c80 <fwp_rc_free_arr>
    df56:	5b                   	pop    %rbx
    df57:	c3                   	ret
    df58:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    df5f:	00 

000000000000df60 <fwp_drop7>:
    df60:	53                   	push   %rbx
    df61:	48 89 fb             	mov    %rdi,%rbx
    df64:	e8 e7 5c ff ff       	call   3c50 <fwp_rc_release_last>
    df69:	85 c0                	test   %eax,%eax
    df6b:	74 09                	je     df76 <fwp_drop7+0x16>
    df6d:	48 89 df             	mov    %rbx,%rdi
    df70:	5b                   	pop    %rbx
    df71:	e9 0a 5d ff ff       	jmp    3c80 <fwp_rc_free_arr>
    df76:	5b                   	pop    %rbx
    df77:	c3                   	ret
    df78:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    df7f:	00 

000000000000df80 <fwp_rc_drop_slot>:
    df80:	0f b6 07             	movzbl (%rdi),%eax
    df83:	3c ff                	cmp    $0xff,%al
    df85:	74 09                	je     df90 <fwp_rc_wide_drop>
    df87:	3c 02                	cmp    $0x2,%al
    df89:	72 04                	jb     df8f <fwp_rc_drop_slot+0xf>
    df8b:	fe c8                	dec    %al
    df8d:	88 07                	mov    %al,(%rdi)
    df8f:	c3                   	ret

000000000000df90 <fwp_rc_wide_drop>:
    df90:	53                   	push   %rbx
    df91:	48 89 fb             	mov    %rdi,%rbx
    df94:	e8 87 62 ff ff       	call   4220 <fwp_rc_wide_link>
    df99:	48 8b 00             	mov    (%rax),%rax
    df9c:	48 85 c0             	test   %rax,%rax
    df9f:	74 21                	je     dfc2 <fwp_rc_wide_drop+0x32>
    dfa1:	48 8b 48 08          	mov    0x8(%rax),%rcx
    dfa5:	48 ff c9             	dec    %rcx
    dfa8:	48 89 48 08          	mov    %rcx,0x8(%rax)
    dfac:	48 81 f9 fe 00 00 00 	cmp    $0xfe,%rcx
    dfb3:	75 0b                	jne    dfc0 <fwp_rc_wide_drop+0x30>
    dfb5:	48 89 df             	mov    %rbx,%rdi
    dfb8:	e8 23 62 ff ff       	call   41e0 <fwp_rc_forget_slot>
    dfbd:	c6 03 fe             	movb   $0xfe,(%rbx)
    dfc0:	5b                   	pop    %rbx
    dfc1:	c3                   	ret
    dfc2:	48 8d 3d a9 18 00 00 	lea    0x18a9(%rip),%rdi        # f872 <exec_in_fp0+0x172>
    dfc9:	e8 b2 62 ff ff       	call   4280 <fwp_trap>
    dfce:	66 90                	xchg   %ax,%ax

000000000000dfd0 <fwp_rc_last>:
    dfd0:	50                   	push   %rax
    dfd1:	e8 6a 61 ff ff       	call   4140 <fwp_rc_slot>
    dfd6:	48 85 c0             	test   %rax,%rax
    dfd9:	74 0d                	je     dfe8 <fwp_rc_last+0x18>
    dfdb:	48 89 c1             	mov    %rax,%rcx
    dfde:	31 c0                	xor    %eax,%eax
    dfe0:	80 39 01             	cmpb   $0x1,(%rcx)
    dfe3:	0f 94 c0             	sete   %al
    dfe6:	59                   	pop    %rcx
    dfe7:	c3                   	ret
    dfe8:	31 c0                	xor    %eax,%eax
    dfea:	59                   	pop    %rcx
    dfeb:	c3                   	ret
    dfec:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000dff0 <fwp_rc_poison>:
    dff0:	53                   	push   %rbx
    dff1:	48 89 f9             	mov    %rdi,%rcx
    dff4:	48 2b 0d cd 82 00 00 	sub    0x82cd(%rip),%rcx        # 162c8 <fwp_gc+0x1030>
    dffb:	48 8b 05 0e 83 00 00 	mov    0x830e(%rip),%rax        # 16310 <fwp_gc+0x1078>
    e002:	48 c1 e9 10          	shr    $0x10,%rcx
    e006:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    e00d:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    e012:	75 0d                	jne    e021 <fwp_rc_poison+0x31>
    e014:	80 3c 08 02          	cmpb   $0x2,(%rax,%rcx,1)
    e018:	75 1e                	jne    e038 <fwp_rc_poison+0x48>
    e01a:	48 8b 54 08 18       	mov    0x18(%rax,%rcx,1),%rdx
    e01f:	eb 1b                	jmp    e03c <fwp_rc_poison+0x4c>
    e021:	c7 07 ad de 00 00    	movl   $0xdead,(%rdi)
    e027:	8b 47 04             	mov    0x4(%rdi),%eax
    e02a:	48 85 c0             	test   %rax,%rax
    e02d:	74 7e                	je     e0ad <fwp_rc_poison+0xbd>
    e02f:	83 f8 04             	cmp    $0x4,%eax
    e032:	73 22                	jae    e056 <fwp_rc_poison+0x66>
    e034:	31 c9                	xor    %ecx,%ecx
    e036:	eb 50                	jmp    e088 <fwp_rc_poison+0x98>
    e038:	8b 54 08 08          	mov    0x8(%rax,%rcx,1),%edx
    e03c:	48 89 fb             	mov    %rdi,%rbx
    e03f:	be dd 00 00 00       	mov    $0xdd,%esi
    e044:	e8 c7 51 ff ff       	call   3210 <memset@plt>
    e049:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    e050:	c6 43 08 00          	movb   $0x0,0x8(%rbx)
    e054:	5b                   	pop    %rbx
    e055:	c3                   	ret
    e056:	89 c1                	mov    %eax,%ecx
    e058:	83 e1 fc             	and    $0xfffffffc,%ecx
    e05b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    e062:	00 
    e063:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    e067:	31 f6                	xor    %esi,%esi
    e069:	0f 28 05 d0 10 00 00 	movaps 0x10d0(%rip),%xmm0        # f140 <_IO_stdin_used+0x140>
    e070:	0f 11 44 37 08       	movups %xmm0,0x8(%rdi,%rsi,1)
    e075:	0f 11 44 37 18       	movups %xmm0,0x18(%rdi,%rsi,1)
    e07a:	48 83 c6 20          	add    $0x20,%rsi
    e07e:	48 39 f2             	cmp    %rsi,%rdx
    e081:	75 ed                	jne    e070 <fwp_rc_poison+0x80>
    e083:	48 39 c1             	cmp    %rax,%rcx
    e086:	74 25                	je     e0ad <fwp_rc_poison+0xbd>
    e088:	48 ba ef be ad de ef 	movabs $0xdeadbeefdeadbeef,%rdx
    e08f:	be ad de 
    e092:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    e099:	1f 84 00 00 00 00 00 
    e0a0:	48 89 54 cf 08       	mov    %rdx,0x8(%rdi,%rcx,8)
    e0a5:	48 ff c1             	inc    %rcx
    e0a8:	48 39 c8             	cmp    %rcx,%rax
    e0ab:	75 f3                	jne    e0a0 <fwp_rc_poison+0xb0>
    e0ad:	5b                   	pop    %rbx
    e0ae:	c3                   	ret
    e0af:	90                   	nop

000000000000e0b0 <__divti3>:
    e0b0:	f3 0f 1e fa          	endbr64
    e0b4:	55                   	push   %rbp
    e0b5:	49 89 f8             	mov    %rdi,%r8
    e0b8:	49 89 d2             	mov    %rdx,%r10
    e0bb:	49 89 cb             	mov    %rcx,%r11
    e0be:	31 ff                	xor    %edi,%edi
    e0c0:	48 89 e5             	mov    %rsp,%rbp
    e0c3:	41 56                	push   %r14
    e0c5:	53                   	push   %rbx
    e0c6:	48 85 f6             	test   %rsi,%rsi
    e0c9:	79 13                	jns    e0de <__divti3+0x2e>
    e0cb:	45 31 c9             	xor    %r9d,%r9d
    e0ce:	49 f7 d8             	neg    %r8
    e0d1:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
    e0d8:	49 19 f1             	sbb    %rsi,%r9
    e0db:	4c 89 ce             	mov    %r9,%rsi
    e0de:	4c 89 da             	mov    %r11,%rdx
    e0e1:	4d 85 db             	test   %r11,%r11
    e0e4:	0f 88 f6 00 00 00    	js     e1e0 <__divti3+0x130>
    e0ea:	4d 89 d6             	mov    %r10,%r14
    e0ed:	75 31                	jne    e120 <__divti3+0x70>
    e0ef:	4c 39 f6             	cmp    %r14,%rsi
    e0f2:	0f 83 b8 00 00 00    	jae    e1b0 <__divti3+0x100>
    e0f8:	48 89 f2             	mov    %rsi,%rdx
    e0fb:	31 f6                	xor    %esi,%esi
    e0fd:	4c 89 c0             	mov    %r8,%rax
    e100:	49 f7 f6             	div    %r14
    e103:	48 89 f2             	mov    %rsi,%rdx
    e106:	48 85 ff             	test   %rdi,%rdi
    e109:	74 0a                	je     e115 <__divti3+0x65>
    e10b:	48 f7 d8             	neg    %rax
    e10e:	48 83 d2 00          	adc    $0x0,%rdx
    e112:	48 f7 da             	neg    %rdx
    e115:	5b                   	pop    %rbx
    e116:	41 5e                	pop    %r14
    e118:	5d                   	pop    %rbp
    e119:	c3                   	ret
    e11a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    e120:	4c 39 de             	cmp    %r11,%rsi
    e123:	0f 82 d5 00 00 00    	jb     e1fe <__divti3+0x14e>
    e129:	4d 0f bd d3          	bsr    %r11,%r10
    e12d:	41 83 f2 3f          	xor    $0x3f,%r10d
    e131:	44 89 d1             	mov    %r10d,%ecx
    e134:	b8 40 00 00 00       	mov    $0x40,%eax
    e139:	4c 89 f3             	mov    %r14,%rbx
    e13c:	4d 89 f1             	mov    %r14,%r9
    e13f:	48 d3 e2             	shl    %cl,%rdx
    e142:	49 63 ca             	movslq %r10d,%rcx
    e145:	49 89 f3             	mov    %rsi,%r11
    e148:	48 29 c8             	sub    %rcx,%rax
    e14b:	89 c1                	mov    %eax,%ecx
    e14d:	48 d3 eb             	shr    %cl,%rbx
    e150:	44 89 d1             	mov    %r10d,%ecx
    e153:	49 d3 e1             	shl    %cl,%r9
    e156:	89 c1                	mov    %eax,%ecx
    e158:	48 09 d3             	or     %rdx,%rbx
    e15b:	4c 89 c2             	mov    %r8,%rdx
    e15e:	49 d3 eb             	shr    %cl,%r11
    e161:	44 89 d1             	mov    %r10d,%ecx
    e164:	48 d3 e6             	shl    %cl,%rsi
    e167:	89 c1                	mov    %eax,%ecx
    e169:	48 d3 ea             	shr    %cl,%rdx
    e16c:	48 89 d0             	mov    %rdx,%rax
    e16f:	4c 89 da             	mov    %r11,%rdx
    e172:	48 09 f0             	or     %rsi,%rax
    e175:	48 f7 f3             	div    %rbx
    e178:	49 89 d3             	mov    %rdx,%r11
    e17b:	48 89 c6             	mov    %rax,%rsi
    e17e:	49 f7 e1             	mul    %r9
    e181:	49 39 d3             	cmp    %rdx,%r11
    e184:	0f 82 be 00 00 00    	jb     e248 <__divti3+0x198>
    e18a:	44 89 d1             	mov    %r10d,%ecx
    e18d:	49 d3 e0             	shl    %cl,%r8
    e190:	49 39 c0             	cmp    %rax,%r8
    e193:	73 09                	jae    e19e <__divti3+0xee>
    e195:	49 39 d3             	cmp    %rdx,%r11
    e198:	0f 84 aa 00 00 00    	je     e248 <__divti3+0x198>
    e19e:	48 89 f0             	mov    %rsi,%rax
    e1a1:	31 f6                	xor    %esi,%esi
    e1a3:	e9 5b ff ff ff       	jmp    e103 <__divti3+0x53>
    e1a8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    e1af:	00 
    e1b0:	4d 85 f6             	test   %r14,%r14
    e1b3:	75 0d                	jne    e1c2 <__divti3+0x112>
    e1b5:	b8 01 00 00 00       	mov    $0x1,%eax
    e1ba:	31 d2                	xor    %edx,%edx
    e1bc:	49 f7 f6             	div    %r14
    e1bf:	49 89 c6             	mov    %rax,%r14
    e1c2:	48 89 f0             	mov    %rsi,%rax
    e1c5:	31 d2                	xor    %edx,%edx
    e1c7:	49 f7 f6             	div    %r14
    e1ca:	48 89 c6             	mov    %rax,%rsi
    e1cd:	4c 89 c0             	mov    %r8,%rax
    e1d0:	49 f7 f6             	div    %r14
    e1d3:	e9 2b ff ff ff       	jmp    e103 <__divti3+0x53>
    e1d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    e1df:	00 
    e1e0:	49 f7 da             	neg    %r10
    e1e3:	48 f7 d7             	not    %rdi
    e1e6:	49 83 d3 00          	adc    $0x0,%r11
    e1ea:	4d 89 d6             	mov    %r10,%r14
    e1ed:	49 f7 db             	neg    %r11
    e1f0:	4c 89 da             	mov    %r11,%rdx
    e1f3:	0f 84 f6 fe ff ff    	je     e0ef <__divti3+0x3f>
    e1f9:	4c 39 de             	cmp    %r11,%rsi
    e1fc:	73 12                	jae    e210 <__divti3+0x160>
    e1fe:	31 f6                	xor    %esi,%esi
    e200:	31 c0                	xor    %eax,%eax
    e202:	e9 fc fe ff ff       	jmp    e103 <__divti3+0x53>
    e207:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    e20e:	00 00 
    e210:	49 0f bd c3          	bsr    %r11,%rax
    e214:	48 83 f0 3f          	xor    $0x3f,%rax
    e218:	41 89 c2             	mov    %eax,%r10d
    e21b:	85 c0                	test   %eax,%eax
    e21d:	0f 85 0e ff ff ff    	jne    e131 <__divti3+0x81>
    e223:	49 39 f3             	cmp    %rsi,%r11
    e226:	72 0d                	jb     e235 <__divti3+0x185>
    e228:	31 f6                	xor    %esi,%esi
    e22a:	31 c0                	xor    %eax,%eax
    e22c:	4d 39 f0             	cmp    %r14,%r8
    e22f:	0f 82 ce fe ff ff    	jb     e103 <__divti3+0x53>
    e235:	31 f6                	xor    %esi,%esi
    e237:	b8 01 00 00 00       	mov    $0x1,%eax
    e23c:	e9 c2 fe ff ff       	jmp    e103 <__divti3+0x53>
    e241:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    e248:	48 8d 46 ff          	lea    -0x1(%rsi),%rax
    e24c:	31 f6                	xor    %esi,%esi
    e24e:	e9 b0 fe ff ff       	jmp    e103 <__divti3+0x53>
    e253:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    e25a:	00 00 00 
    e25d:	0f 1f 00             	nopl   (%rax)

000000000000e260 <atexit>:
    e260:	f3 0f 1e fa          	endbr64
    e264:	48 8b 15 1d 70 00 00 	mov    0x701d(%rip),%rdx        # 15288 <__dso_handle>
    e26b:	31 f6                	xor    %esi,%esi
    e26d:	e9 de 51 ff ff       	jmp    3450 <__cxa_atexit@plt>

Disassembly of section .fini:

000000000000e274 <_fini>:
    e274:	f3 0f 1e fa          	endbr64
    e278:	48 83 ec 08          	sub    $0x8,%rsp
    e27c:	48 83 c4 08          	add    $0x8,%rsp
    e280:	c3                   	ret
