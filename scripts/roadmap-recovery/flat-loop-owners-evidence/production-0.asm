
/tmp/fwp-array-fusion-allocation-3593/profile-0O2:     file format elf64-x86-64


Disassembly of section .init:

0000000000003000 <_init>:
    3000:	f3 0f 1e fa          	endbr64
    3004:	48 83 ec 08          	sub    $0x8,%rsp
    3008:	48 8b 05 b1 6f 01 00 	mov    0x16fb1(%rip),%rax        # 19fc0 <__gmon_start__@Base>
    300f:	48 85 c0             	test   %rax,%rax
    3012:	74 02                	je     3016 <_init+0x16>
    3014:	ff d0                	call   *%rax
    3016:	48 83 c4 08          	add    $0x8,%rsp
    301a:	c3                   	ret

Disassembly of section .plt:

0000000000003020 <getenv@plt-0x10>:
    3020:	ff 35 ca 6f 01 00    	push   0x16fca(%rip)        # 19ff0 <_GLOBAL_OFFSET_TABLE_+0x8>
    3026:	ff 25 cc 6f 01 00    	jmp    *0x16fcc(%rip)        # 19ff8 <_GLOBAL_OFFSET_TABLE_+0x10>
    302c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000003030 <getenv@plt>:
    3030:	ff 25 ca 6f 01 00    	jmp    *0x16fca(%rip)        # 1a000 <getenv@GLIBC_2.2.5>
    3036:	68 00 00 00 00       	push   $0x0
    303b:	e9 e0 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003040 <dl_iterate_phdr@plt>:
    3040:	ff 25 c2 6f 01 00    	jmp    *0x16fc2(%rip)        # 1a008 <dl_iterate_phdr@GLIBC_2.2.5>
    3046:	68 01 00 00 00       	push   $0x1
    304b:	e9 d0 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003050 <free@plt>:
    3050:	ff 25 ba 6f 01 00    	jmp    *0x16fba(%rip)        # 1a010 <free@GLIBC_2.2.5>
    3056:	68 02 00 00 00       	push   $0x2
    305b:	e9 c0 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003060 <recv@plt>:
    3060:	ff 25 b2 6f 01 00    	jmp    *0x16fb2(%rip)        # 1a018 <recv@GLIBC_2.2.5>
    3066:	68 03 00 00 00       	push   $0x3
    306b:	e9 b0 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003070 <abort@plt>:
    3070:	ff 25 aa 6f 01 00    	jmp    *0x16faa(%rip)        # 1a020 <abort@GLIBC_2.2.5>
    3076:	68 04 00 00 00       	push   $0x4
    307b:	e9 a0 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003080 <__errno_location@plt>:
    3080:	ff 25 a2 6f 01 00    	jmp    *0x16fa2(%rip)        # 1a028 <__errno_location@GLIBC_2.2.5>
    3086:	68 05 00 00 00       	push   $0x5
    308b:	e9 90 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003090 <strncmp@plt>:
    3090:	ff 25 9a 6f 01 00    	jmp    *0x16f9a(%rip)        # 1a030 <strncmp@GLIBC_2.2.5>
    3096:	68 06 00 00 00       	push   $0x6
    309b:	e9 80 ff ff ff       	jmp    3020 <_init+0x20>

00000000000030a0 <_exit@plt>:
    30a0:	ff 25 92 6f 01 00    	jmp    *0x16f92(%rip)        # 1a038 <_exit@GLIBC_2.2.5>
    30a6:	68 07 00 00 00       	push   $0x7
    30ab:	e9 70 ff ff ff       	jmp    3020 <_init+0x20>

00000000000030b0 <strcpy@plt>:
    30b0:	ff 25 8a 6f 01 00    	jmp    *0x16f8a(%rip)        # 1a040 <strcpy@GLIBC_2.2.5>
    30b6:	68 08 00 00 00       	push   $0x8
    30bb:	e9 60 ff ff ff       	jmp    3020 <_init+0x20>

00000000000030c0 <sendmsg@plt>:
    30c0:	ff 25 82 6f 01 00    	jmp    *0x16f82(%rip)        # 1a048 <sendmsg@GLIBC_2.2.5>
    30c6:	68 09 00 00 00       	push   $0x9
    30cb:	e9 50 ff ff ff       	jmp    3020 <_init+0x20>

00000000000030d0 <puts@plt>:
    30d0:	ff 25 7a 6f 01 00    	jmp    *0x16f7a(%rip)        # 1a050 <puts@GLIBC_2.2.5>
    30d6:	68 0a 00 00 00       	push   $0xa
    30db:	e9 40 ff ff ff       	jmp    3020 <_init+0x20>

00000000000030e0 <sigaction@plt>:
    30e0:	ff 25 72 6f 01 00    	jmp    *0x16f72(%rip)        # 1a058 <sigaction@GLIBC_2.2.5>
    30e6:	68 0b 00 00 00       	push   $0xb
    30eb:	e9 30 ff ff ff       	jmp    3020 <_init+0x20>

00000000000030f0 <fread@plt>:
    30f0:	ff 25 6a 6f 01 00    	jmp    *0x16f6a(%rip)        # 1a060 <fread@GLIBC_2.2.5>
    30f6:	68 0c 00 00 00       	push   $0xc
    30fb:	e9 20 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003100 <strtod@plt>:
    3100:	ff 25 62 6f 01 00    	jmp    *0x16f62(%rip)        # 1a068 <strtod@GLIBC_2.2.5>
    3106:	68 0d 00 00 00       	push   $0xd
    310b:	e9 10 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003110 <vsnprintf@plt>:
    3110:	ff 25 5a 6f 01 00    	jmp    *0x16f5a(%rip)        # 1a070 <vsnprintf@GLIBC_2.2.5>
    3116:	68 0e 00 00 00       	push   $0xe
    311b:	e9 00 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003120 <fcntl@plt>:
    3120:	ff 25 52 6f 01 00    	jmp    *0x16f52(%rip)        # 1a078 <fcntl@GLIBC_2.2.5>
    3126:	68 0f 00 00 00       	push   $0xf
    312b:	e9 f0 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003130 <clock_gettime@plt>:
    3130:	ff 25 4a 6f 01 00    	jmp    *0x16f4a(%rip)        # 1a080 <clock_gettime@GLIBC_2.17>
    3136:	68 10 00 00 00       	push   $0x10
    313b:	e9 e0 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003140 <write@plt>:
    3140:	ff 25 42 6f 01 00    	jmp    *0x16f42(%rip)        # 1a088 <write@GLIBC_2.2.5>
    3146:	68 11 00 00 00       	push   $0x11
    314b:	e9 d0 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003150 <fclose@plt>:
    3150:	ff 25 3a 6f 01 00    	jmp    *0x16f3a(%rip)        # 1a090 <fclose@GLIBC_2.2.5>
    3156:	68 12 00 00 00       	push   $0x12
    315b:	e9 c0 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003160 <shutdown@plt>:
    3160:	ff 25 32 6f 01 00    	jmp    *0x16f32(%rip)        # 1a098 <shutdown@GLIBC_2.2.5>
    3166:	68 13 00 00 00       	push   $0x13
    316b:	e9 b0 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003170 <strlen@plt>:
    3170:	ff 25 2a 6f 01 00    	jmp    *0x16f2a(%rip)        # 1a0a0 <strlen@GLIBC_2.2.5>
    3176:	68 14 00 00 00       	push   $0x14
    317b:	e9 a0 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003180 <getuid@plt>:
    3180:	ff 25 22 6f 01 00    	jmp    *0x16f22(%rip)        # 1a0a8 <getuid@GLIBC_2.2.5>
    3186:	68 15 00 00 00       	push   $0x15
    318b:	e9 90 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003190 <mmap@plt>:
    3190:	ff 25 1a 6f 01 00    	jmp    *0x16f1a(%rip)        # 1a0b0 <mmap@GLIBC_2.2.5>
    3196:	68 16 00 00 00       	push   $0x16
    319b:	e9 80 fe ff ff       	jmp    3020 <_init+0x20>

00000000000031a0 <send@plt>:
    31a0:	ff 25 12 6f 01 00    	jmp    *0x16f12(%rip)        # 1a0b8 <send@GLIBC_2.2.5>
    31a6:	68 17 00 00 00       	push   $0x17
    31ab:	e9 70 fe ff ff       	jmp    3020 <_init+0x20>

00000000000031b0 <strchr@plt>:
    31b0:	ff 25 0a 6f 01 00    	jmp    *0x16f0a(%rip)        # 1a0c0 <strchr@GLIBC_2.2.5>
    31b6:	68 18 00 00 00       	push   $0x18
    31bb:	e9 60 fe ff ff       	jmp    3020 <_init+0x20>

00000000000031c0 <printf@plt>:
    31c0:	ff 25 02 6f 01 00    	jmp    *0x16f02(%rip)        # 1a0c8 <printf@GLIBC_2.2.5>
    31c6:	68 19 00 00 00       	push   $0x19
    31cb:	e9 50 fe ff ff       	jmp    3020 <_init+0x20>

00000000000031d0 <snprintf@plt>:
    31d0:	ff 25 fa 6e 01 00    	jmp    *0x16efa(%rip)        # 1a0d0 <snprintf@GLIBC_2.2.5>
    31d6:	68 1a 00 00 00       	push   $0x1a
    31db:	e9 40 fe ff ff       	jmp    3020 <_init+0x20>

00000000000031e0 <ftruncate@plt>:
    31e0:	ff 25 f2 6e 01 00    	jmp    *0x16ef2(%rip)        # 1a0d8 <ftruncate@GLIBC_2.2.5>
    31e6:	68 1b 00 00 00       	push   $0x1b
    31eb:	e9 30 fe ff ff       	jmp    3020 <_init+0x20>

00000000000031f0 <fputs@plt>:
    31f0:	ff 25 ea 6e 01 00    	jmp    *0x16eea(%rip)        # 1a0e0 <fputs@GLIBC_2.2.5>
    31f6:	68 1c 00 00 00       	push   $0x1c
    31fb:	e9 20 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003200 <strtof@plt>:
    3200:	ff 25 e2 6e 01 00    	jmp    *0x16ee2(%rip)        # 1a0e8 <strtof@GLIBC_2.2.5>
    3206:	68 1d 00 00 00       	push   $0x1d
    320b:	e9 10 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003210 <memset@plt>:
    3210:	ff 25 da 6e 01 00    	jmp    *0x16eda(%rip)        # 1a0f0 <memset@GLIBC_2.2.5>
    3216:	68 1e 00 00 00       	push   $0x1e
    321b:	e9 00 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003220 <fgetc@plt>:
    3220:	ff 25 d2 6e 01 00    	jmp    *0x16ed2(%rip)        # 1a0f8 <fgetc@GLIBC_2.2.5>
    3226:	68 1f 00 00 00       	push   $0x1f
    322b:	e9 f0 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003230 <close@plt>:
    3230:	ff 25 ca 6e 01 00    	jmp    *0x16eca(%rip)        # 1a100 <close@GLIBC_2.2.5>
    3236:	68 20 00 00 00       	push   $0x20
    323b:	e9 e0 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003240 <fputc@plt>:
    3240:	ff 25 c2 6e 01 00    	jmp    *0x16ec2(%rip)        # 1a108 <fputc@GLIBC_2.2.5>
    3246:	68 21 00 00 00       	push   $0x21
    324b:	e9 d0 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003250 <sched_yield@plt>:
    3250:	ff 25 ba 6e 01 00    	jmp    *0x16eba(%rip)        # 1a110 <sched_yield@GLIBC_2.2.5>
    3256:	68 22 00 00 00       	push   $0x22
    325b:	e9 c0 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003260 <memchr@plt>:
    3260:	ff 25 b2 6e 01 00    	jmp    *0x16eb2(%rip)        # 1a118 <memchr@GLIBC_2.2.5>
    3266:	68 23 00 00 00       	push   $0x23
    326b:	e9 b0 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003270 <memcmp@plt>:
    3270:	ff 25 aa 6e 01 00    	jmp    *0x16eaa(%rip)        # 1a120 <memcmp@GLIBC_2.2.5>
    3276:	68 24 00 00 00       	push   $0x24
    327b:	e9 a0 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003280 <pthread_attr_init@plt>:
    3280:	ff 25 a2 6e 01 00    	jmp    *0x16ea2(%rip)        # 1a128 <pthread_attr_init@GLIBC_2.2.5>
    3286:	68 25 00 00 00       	push   $0x25
    328b:	e9 90 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003290 <fgets@plt>:
    3290:	ff 25 9a 6e 01 00    	jmp    *0x16e9a(%rip)        # 1a130 <fgets@GLIBC_2.2.5>
    3296:	68 26 00 00 00       	push   $0x26
    329b:	e9 80 fd ff ff       	jmp    3020 <_init+0x20>

00000000000032a0 <getsockopt@plt>:
    32a0:	ff 25 92 6e 01 00    	jmp    *0x16e92(%rip)        # 1a138 <getsockopt@GLIBC_2.2.5>
    32a6:	68 27 00 00 00       	push   $0x27
    32ab:	e9 70 fd ff ff       	jmp    3020 <_init+0x20>

00000000000032b0 <_setjmp@plt>:
    32b0:	ff 25 8a 6e 01 00    	jmp    *0x16e8a(%rip)        # 1a140 <_setjmp@GLIBC_2.2.5>
    32b6:	68 28 00 00 00       	push   $0x28
    32bb:	e9 60 fd ff ff       	jmp    3020 <_init+0x20>

00000000000032c0 <strtoull@plt>:
    32c0:	ff 25 82 6e 01 00    	jmp    *0x16e82(%rip)        # 1a148 <strtoull@GLIBC_2.2.5>
    32c6:	68 29 00 00 00       	push   $0x29
    32cb:	e9 50 fd ff ff       	jmp    3020 <_init+0x20>

00000000000032d0 <strcmp@plt>:
    32d0:	ff 25 7a 6e 01 00    	jmp    *0x16e7a(%rip)        # 1a150 <strcmp@GLIBC_2.2.5>
    32d6:	68 2a 00 00 00       	push   $0x2a
    32db:	e9 40 fd ff ff       	jmp    3020 <_init+0x20>

00000000000032e0 <signal@plt>:
    32e0:	ff 25 72 6e 01 00    	jmp    *0x16e72(%rip)        # 1a158 <signal@GLIBC_2.2.5>
    32e6:	68 2b 00 00 00       	push   $0x2b
    32eb:	e9 30 fd ff ff       	jmp    3020 <_init+0x20>

00000000000032f0 <fprintf@plt>:
    32f0:	ff 25 6a 6e 01 00    	jmp    *0x16e6a(%rip)        # 1a160 <fprintf@GLIBC_2.2.5>
    32f6:	68 2c 00 00 00       	push   $0x2c
    32fb:	e9 20 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003300 <syscall@plt>:
    3300:	ff 25 62 6e 01 00    	jmp    *0x16e62(%rip)        # 1a168 <syscall@GLIBC_2.2.5>
    3306:	68 2d 00 00 00       	push   $0x2d
    330b:	e9 10 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003310 <sigemptyset@plt>:
    3310:	ff 25 5a 6e 01 00    	jmp    *0x16e5a(%rip)        # 1a170 <sigemptyset@GLIBC_2.2.5>
    3316:	68 2e 00 00 00       	push   $0x2e
    331b:	e9 00 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003320 <strtol@plt>:
    3320:	ff 25 52 6e 01 00    	jmp    *0x16e52(%rip)        # 1a178 <strtol@GLIBC_2.2.5>
    3326:	68 2f 00 00 00       	push   $0x2f
    332b:	e9 f0 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003330 <memcpy@plt>:
    3330:	ff 25 4a 6e 01 00    	jmp    *0x16e4a(%rip)        # 1a180 <memcpy@GLIBC_2.14>
    3336:	68 30 00 00 00       	push   $0x30
    333b:	e9 e0 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003340 <malloc@plt>:
    3340:	ff 25 42 6e 01 00    	jmp    *0x16e42(%rip)        # 1a188 <malloc@GLIBC_2.2.5>
    3346:	68 31 00 00 00       	push   $0x31
    334b:	e9 d0 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003350 <fflush@plt>:
    3350:	ff 25 3a 6e 01 00    	jmp    *0x16e3a(%rip)        # 1a190 <fflush@GLIBC_2.2.5>
    3356:	68 32 00 00 00       	push   $0x32
    335b:	e9 c0 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003360 <listen@plt>:
    3360:	ff 25 32 6e 01 00    	jmp    *0x16e32(%rip)        # 1a198 <listen@GLIBC_2.2.5>
    3366:	68 33 00 00 00       	push   $0x33
    336b:	e9 b0 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003370 <bcmp@plt>:
    3370:	ff 25 2a 6e 01 00    	jmp    *0x16e2a(%rip)        # 1a1a0 <bcmp@GLIBC_2.2.5>
    3376:	68 34 00 00 00       	push   $0x34
    337b:	e9 a0 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003380 <realloc@plt>:
    3380:	ff 25 22 6e 01 00    	jmp    *0x16e22(%rip)        # 1a1a8 <realloc@GLIBC_2.2.5>
    3386:	68 35 00 00 00       	push   $0x35
    338b:	e9 90 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003390 <munmap@plt>:
    3390:	ff 25 1a 6e 01 00    	jmp    *0x16e1a(%rip)        # 1a1b0 <munmap@GLIBC_2.2.5>
    3396:	68 36 00 00 00       	push   $0x36
    339b:	e9 80 fc ff ff       	jmp    3020 <_init+0x20>

00000000000033a0 <recvmsg@plt>:
    33a0:	ff 25 12 6e 01 00    	jmp    *0x16e12(%rip)        # 1a1b8 <recvmsg@GLIBC_2.2.5>
    33a6:	68 37 00 00 00       	push   $0x37
    33ab:	e9 70 fc ff ff       	jmp    3020 <_init+0x20>

00000000000033b0 <setvbuf@plt>:
    33b0:	ff 25 0a 6e 01 00    	jmp    *0x16e0a(%rip)        # 1a1c0 <setvbuf@GLIBC_2.2.5>
    33b6:	68 38 00 00 00       	push   $0x38
    33bb:	e9 60 fc ff ff       	jmp    3020 <_init+0x20>

00000000000033c0 <poll@plt>:
    33c0:	ff 25 02 6e 01 00    	jmp    *0x16e02(%rip)        # 1a1c8 <poll@GLIBC_2.2.5>
    33c6:	68 39 00 00 00       	push   $0x39
    33cb:	e9 50 fc ff ff       	jmp    3020 <_init+0x20>

00000000000033d0 <bind@plt>:
    33d0:	ff 25 fa 6d 01 00    	jmp    *0x16dfa(%rip)        # 1a1d0 <bind@GLIBC_2.2.5>
    33d6:	68 3a 00 00 00       	push   $0x3a
    33db:	e9 40 fc ff ff       	jmp    3020 <_init+0x20>

00000000000033e0 <pthread_create@plt>:
    33e0:	ff 25 f2 6d 01 00    	jmp    *0x16df2(%rip)        # 1a1d8 <pthread_create@GLIBC_2.34>
    33e6:	68 3b 00 00 00       	push   $0x3b
    33eb:	e9 30 fc ff ff       	jmp    3020 <_init+0x20>

00000000000033f0 <madvise@plt>:
    33f0:	ff 25 ea 6d 01 00    	jmp    *0x16dea(%rip)        # 1a1e0 <madvise@GLIBC_2.2.5>
    33f6:	68 3c 00 00 00       	push   $0x3c
    33fb:	e9 20 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003400 <mprotect@plt>:
    3400:	ff 25 e2 6d 01 00    	jmp    *0x16de2(%rip)        # 1a1e8 <mprotect@GLIBC_2.2.5>
    3406:	68 3d 00 00 00       	push   $0x3d
    340b:	e9 10 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003410 <fopen@plt>:
    3410:	ff 25 da 6d 01 00    	jmp    *0x16dda(%rip)        # 1a1f0 <fopen@GLIBC_2.2.5>
    3416:	68 3e 00 00 00       	push   $0x3e
    341b:	e9 00 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003420 <sysconf@plt>:
    3420:	ff 25 d2 6d 01 00    	jmp    *0x16dd2(%rip)        # 1a1f8 <sysconf@GLIBC_2.2.5>
    3426:	68 3f 00 00 00       	push   $0x3f
    342b:	e9 f0 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003430 <accept@plt>:
    3430:	ff 25 ca 6d 01 00    	jmp    *0x16dca(%rip)        # 1a200 <accept@GLIBC_2.2.5>
    3436:	68 40 00 00 00       	push   $0x40
    343b:	e9 e0 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003440 <__cxa_atexit@plt>:
    3440:	ff 25 c2 6d 01 00    	jmp    *0x16dc2(%rip)        # 1a208 <__cxa_atexit@GLIBC_2.2.5>
    3446:	68 41 00 00 00       	push   $0x41
    344b:	e9 d0 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003450 <sprintf@plt>:
    3450:	ff 25 ba 6d 01 00    	jmp    *0x16dba(%rip)        # 1a210 <sprintf@GLIBC_2.2.5>
    3456:	68 42 00 00 00       	push   $0x42
    345b:	e9 c0 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003460 <exit@plt>:
    3460:	ff 25 b2 6d 01 00    	jmp    *0x16db2(%rip)        # 1a218 <exit@GLIBC_2.2.5>
    3466:	68 43 00 00 00       	push   $0x43
    346b:	e9 b0 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003470 <connect@plt>:
    3470:	ff 25 aa 6d 01 00    	jmp    *0x16daa(%rip)        # 1a220 <connect@GLIBC_2.2.5>
    3476:	68 44 00 00 00       	push   $0x44
    347b:	e9 a0 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003480 <fwrite@plt>:
    3480:	ff 25 a2 6d 01 00    	jmp    *0x16da2(%rip)        # 1a228 <fwrite@GLIBC_2.2.5>
    3486:	68 45 00 00 00       	push   $0x45
    348b:	e9 90 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003490 <getrlimit@plt>:
    3490:	ff 25 9a 6d 01 00    	jmp    *0x16d9a(%rip)        # 1a230 <getrlimit@GLIBC_2.2.5>
    3496:	68 46 00 00 00       	push   $0x46
    349b:	e9 80 fb ff ff       	jmp    3020 <_init+0x20>

00000000000034a0 <pthread_join@plt>:
    34a0:	ff 25 92 6d 01 00    	jmp    *0x16d92(%rip)        # 1a238 <pthread_join@GLIBC_2.34>
    34a6:	68 47 00 00 00       	push   $0x47
    34ab:	e9 70 fb ff ff       	jmp    3020 <_init+0x20>

00000000000034b0 <sigaltstack@plt>:
    34b0:	ff 25 8a 6d 01 00    	jmp    *0x16d8a(%rip)        # 1a240 <sigaltstack@GLIBC_2.2.5>
    34b6:	68 48 00 00 00       	push   $0x48
    34bb:	e9 60 fb ff ff       	jmp    3020 <_init+0x20>

00000000000034c0 <fstat@plt>:
    34c0:	ff 25 82 6d 01 00    	jmp    *0x16d82(%rip)        # 1a248 <fstat@GLIBC_2.33>
    34c6:	68 49 00 00 00       	push   $0x49
    34cb:	e9 50 fb ff ff       	jmp    3020 <_init+0x20>

00000000000034d0 <strstr@plt>:
    34d0:	ff 25 7a 6d 01 00    	jmp    *0x16d7a(%rip)        # 1a250 <strstr@GLIBC_2.2.5>
    34d6:	68 4a 00 00 00       	push   $0x4a
    34db:	e9 40 fb ff ff       	jmp    3020 <_init+0x20>

00000000000034e0 <__ctype_b_loc@plt>:
    34e0:	ff 25 72 6d 01 00    	jmp    *0x16d72(%rip)        # 1a258 <__ctype_b_loc@GLIBC_2.3>
    34e6:	68 4b 00 00 00       	push   $0x4b
    34eb:	e9 30 fb ff ff       	jmp    3020 <_init+0x20>

00000000000034f0 <socket@plt>:
    34f0:	ff 25 6a 6d 01 00    	jmp    *0x16d6a(%rip)        # 1a260 <socket@GLIBC_2.2.5>
    34f6:	68 4c 00 00 00       	push   $0x4c
    34fb:	e9 20 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003500 <pthread_attr_setstacksize@plt>:
    3500:	ff 25 62 6d 01 00    	jmp    *0x16d62(%rip)        # 1a268 <pthread_attr_setstacksize@GLIBC_2.34>
    3506:	68 4d 00 00 00       	push   $0x4d
    350b:	e9 10 fb ff ff       	jmp    3020 <_init+0x20>

Disassembly of section .plt.got:

0000000000003510 <__cxa_finalize@plt>:
    3510:	ff 25 ba 6a 01 00    	jmp    *0x16aba(%rip)        # 19fd0 <__cxa_finalize@GLIBC_2.2.5>
    3516:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

0000000000003520 <_start>:
    3520:	f3 0f 1e fa          	endbr64
    3524:	31 ed                	xor    %ebp,%ebp
    3526:	49 89 d1             	mov    %rdx,%r9
    3529:	5e                   	pop    %rsi
    352a:	48 89 e2             	mov    %rsp,%rdx
    352d:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
    3531:	50                   	push   %rax
    3532:	54                   	push   %rsp
    3533:	45 31 c0             	xor    %r8d,%r8d
    3536:	31 c9                	xor    %ecx,%ecx
    3538:	48 8d 3d 81 1e 00 00 	lea    0x1e81(%rip),%rdi        # 53c0 <main>
    353f:	ff 15 5b 6a 01 00    	call   *0x16a5b(%rip)        # 19fa0 <__libc_start_main@GLIBC_2.34>
    3545:	f4                   	hlt
    3546:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    354d:	00 00 00 

0000000000003550 <deregister_tm_clones>:
    3550:	48 8d 3d 01 89 01 00 	lea    0x18901(%rip),%rdi        # 1be58 <__TMC_END__>
    3557:	48 8d 05 fa 88 01 00 	lea    0x188fa(%rip),%rax        # 1be58 <__TMC_END__>
    355e:	48 39 f8             	cmp    %rdi,%rax
    3561:	74 15                	je     3578 <deregister_tm_clones+0x28>
    3563:	48 8b 05 3e 6a 01 00 	mov    0x16a3e(%rip),%rax        # 19fa8 <_ITM_deregisterTMCloneTable@Base>
    356a:	48 85 c0             	test   %rax,%rax
    356d:	74 09                	je     3578 <deregister_tm_clones+0x28>
    356f:	ff e0                	jmp    *%rax
    3571:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    3578:	c3                   	ret
    3579:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000003580 <register_tm_clones>:
    3580:	48 8d 3d d1 88 01 00 	lea    0x188d1(%rip),%rdi        # 1be58 <__TMC_END__>
    3587:	48 8d 35 ca 88 01 00 	lea    0x188ca(%rip),%rsi        # 1be58 <__TMC_END__>
    358e:	48 29 fe             	sub    %rdi,%rsi
    3591:	48 89 f0             	mov    %rsi,%rax
    3594:	48 c1 ee 3f          	shr    $0x3f,%rsi
    3598:	48 c1 f8 03          	sar    $0x3,%rax
    359c:	48 01 c6             	add    %rax,%rsi
    359f:	48 d1 fe             	sar    $1,%rsi
    35a2:	74 14                	je     35b8 <register_tm_clones+0x38>
    35a4:	48 8b 05 1d 6a 01 00 	mov    0x16a1d(%rip),%rax        # 19fc8 <_ITM_registerTMCloneTable@Base>
    35ab:	48 85 c0             	test   %rax,%rax
    35ae:	74 08                	je     35b8 <register_tm_clones+0x38>
    35b0:	ff e0                	jmp    *%rax
    35b2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    35b8:	c3                   	ret
    35b9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000035c0 <__do_global_dtors_aux>:
    35c0:	f3 0f 1e fa          	endbr64
    35c4:	80 3d 95 88 01 00 00 	cmpb   $0x0,0x18895(%rip)        # 1be60 <completed.0>
    35cb:	75 2b                	jne    35f8 <__do_global_dtors_aux+0x38>
    35cd:	55                   	push   %rbp
    35ce:	48 83 3d fa 69 01 00 	cmpq   $0x0,0x169fa(%rip)        # 19fd0 <__cxa_finalize@GLIBC_2.2.5>
    35d5:	00 
    35d6:	48 89 e5             	mov    %rsp,%rbp
    35d9:	74 0c                	je     35e7 <__do_global_dtors_aux+0x27>
    35db:	48 8b 3d 96 6c 01 00 	mov    0x16c96(%rip),%rdi        # 1a278 <__dso_handle>
    35e2:	e8 29 ff ff ff       	call   3510 <__cxa_finalize@plt>
    35e7:	e8 64 ff ff ff       	call   3550 <deregister_tm_clones>
    35ec:	c6 05 6d 88 01 00 01 	movb   $0x1,0x1886d(%rip)        # 1be60 <completed.0>
    35f3:	5d                   	pop    %rbp
    35f4:	c3                   	ret
    35f5:	0f 1f 00             	nopl   (%rax)
    35f8:	c3                   	ret
    35f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000003600 <frame_dummy>:
    3600:	f3 0f 1e fa          	endbr64
    3604:	e9 77 ff ff ff       	jmp    3580 <register_tm_clones>
    3609:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000003610 <original_main>:
    3610:	41 56                	push   %r14
    3612:	53                   	push   %rbx
    3613:	48 83 ec 58          	sub    $0x58,%rsp
    3617:	48 8d 05 62 62 01 00 	lea    0x16262(%rip),%rax        # 19880 <fwp_fn_table>
    361e:	48 89 05 4b 88 01 00 	mov    %rax,0x1884b(%rip)        # 1be70 <fwp_fns>
    3625:	4c 8b 35 84 69 01 00 	mov    0x16984(%rip),%r14        # 19fb0 <stdout@GLIBC_2.2.5>
    362c:	49 8b 06             	mov    (%r14),%rax
    362f:	48 89 05 42 88 01 00 	mov    %rax,0x18842(%rip)        # 1be78 <fwp_prog_out>
    3636:	89 3d 44 88 01 00    	mov    %edi,0x18844(%rip)        # 1be80 <fwp_argc>
    363c:	48 89 35 45 88 01 00 	mov    %rsi,0x18845(%rip)        # 1be88 <fwp_argv>
    3643:	48 8d 35 46 88 01 00 	lea    0x18846(%rip),%rsi        # 1be90 <fwp_start_time>
    364a:	bf 01 00 00 00       	mov    $0x1,%edi
    364f:	e8 dc fa ff ff       	call   3130 <clock_gettime@plt>
    3654:	48 8d 3d 26 26 01 00 	lea    0x12626(%rip),%rdi        # 15c81 <exec_in_fp0+0x411>
    365b:	e8 d0 f9 ff ff       	call   3030 <getenv@plt>
    3660:	48 85 c0             	test   %rax,%rax
    3663:	74 28                	je     368d <original_main+0x7d>
    3665:	48 89 c3             	mov    %rax,%rbx
    3668:	80 38 00             	cmpb   $0x0,(%rax)
    366b:	74 20                	je     368d <original_main+0x7d>
    366d:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    3672:	48 89 df             	mov    %rbx,%rdi
    3675:	ba 0a 00 00 00       	mov    $0xa,%edx
    367a:	e8 41 fc ff ff       	call   32c0 <strtoull@plt>
    367f:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    3684:	80 38 00             	cmpb   $0x0,(%rax)
    3687:	0f 84 b9 00 00 00    	je     3746 <original_main+0x136>
    368d:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    3692:	31 ff                	xor    %edi,%edi
    3694:	e8 97 fa ff ff       	call   3130 <clock_gettime@plt>
    3699:	49 8b 3e             	mov    (%r14),%rdi
    369c:	b9 00 00 01 00       	mov    $0x10000,%ecx
    36a1:	31 f6                	xor    %esi,%esi
    36a3:	31 d2                	xor    %edx,%edx
    36a5:	e8 06 fd ff ff       	call   33b0 <setvbuf@plt>
    36aa:	be 01 00 00 00       	mov    $0x1,%esi
    36af:	bf 0d 00 00 00       	mov    $0xd,%edi
    36b4:	e8 27 fc ff ff       	call   32e0 <signal@plt>
    36b9:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    36be:	48 89 df             	mov    %rbx,%rdi
    36c1:	e8 ba fb ff ff       	call   3280 <pthread_attr_init@plt>
    36c6:	48 8b 35 b3 6b 01 00 	mov    0x16bb3(%rip),%rsi        # 1a280 <fwp_main_stack>
    36cd:	48 89 df             	mov    %rbx,%rdi
    36d0:	e8 2b fe ff ff       	call   3500 <pthread_attr_setstacksize@plt>
    36d5:	48 8d 15 84 00 00 00 	lea    0x84(%rip),%rdx        # 3760 <fwp_main_thread>
    36dc:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    36e1:	48 89 de             	mov    %rbx,%rsi
    36e4:	31 c9                	xor    %ecx,%ecx
    36e6:	e8 f5 fc ff ff       	call   33e0 <pthread_create@plt>
    36eb:	85 c0                	test   %eax,%eax
    36ed:	74 35                	je     3724 <original_main+0x114>
    36ef:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    36f4:	bf 03 00 00 00       	mov    $0x3,%edi
    36f9:	e8 92 fd ff ff       	call   3490 <getrlimit@plt>
    36fe:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    3703:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
    3707:	ba 00 00 80 00       	mov    $0x800000,%edx
    370c:	48 0f 44 ca          	cmove  %rdx,%rcx
    3710:	85 c0                	test   %eax,%eax
    3712:	48 0f 45 ca          	cmovne %rdx,%rcx
    3716:	48 89 0d 63 6b 01 00 	mov    %rcx,0x16b63(%rip)        # 1a280 <fwp_main_stack>
    371d:	e8 3e 00 00 00       	call   3760 <fwp_main_thread>
    3722:	eb 0c                	jmp    3730 <original_main+0x120>
    3724:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    3729:	31 f6                	xor    %esi,%esi
    372b:	e8 70 fd ff ff       	call   34a0 <pthread_join@plt>
    3730:	49 8b 3e             	mov    (%r14),%rdi
    3733:	e8 18 fc ff ff       	call   3350 <fflush@plt>
    3738:	8b 05 62 87 01 00    	mov    0x18762(%rip),%eax        # 1bea0 <fwp_exit_code>
    373e:	48 83 c4 58          	add    $0x58,%rsp
    3742:	5b                   	pop    %rbx
    3743:	41 5e                	pop    %r14
    3745:	c3                   	ret
    3746:	0f b6 03             	movzbl (%rbx),%eax
    3749:	83 f8 2d             	cmp    $0x2d,%eax
    374c:	0f 84 3b ff ff ff    	je     368d <original_main+0x7d>
    3752:	83 f8 2b             	cmp    $0x2b,%eax
    3755:	0f 84 32 ff ff ff    	je     368d <original_main+0x7d>
    375b:	e9 39 ff ff ff       	jmp    3699 <original_main+0x89>

0000000000003760 <fwp_main_thread>:
    3760:	55                   	push   %rbp
    3761:	48 89 e5             	mov    %rsp,%rbp
    3764:	41 57                	push   %r15
    3766:	41 56                	push   %r14
    3768:	41 55                	push   %r13
    376a:	41 54                	push   %r12
    376c:	53                   	push   %rbx
    376d:	48 81 ec 28 02 00 00 	sub    $0x228,%rsp
    3774:	83 3d f9 7a 01 00 00 	cmpl   $0x0,0x17af9(%rip)        # 1b274 <fwp_gc+0xfec>
    377b:	75 05                	jne    3782 <fwp_main_thread+0x22>
    377d:	e8 2e 4c 00 00       	call   83b0 <fwp_gc_init>
    3782:	48 89 2d 87 7b 01 00 	mov    %rbp,0x17b87(%rip)        # 1b310 <fwp_gc+0x1088>
    3789:	48 8d 3d 10 03 01 00 	lea    0x10310(%rip),%rdi        # 13aa0 <fwp_gc_find_data>
    3790:	31 f6                	xor    %esi,%esi
    3792:	e8 a9 f8 ff ff       	call   3040 <dl_iterate_phdr@plt>
    3797:	83 3d da 7a 01 00 00 	cmpl   $0x0,0x17ada(%rip)        # 1b278 <fwp_gc+0xff0>
    379e:	0f 95 c1             	setne  %cl
    37a1:	83 3d 70 7c 01 00 00 	cmpl   $0x0,0x17c70(%rip)        # 1b418 <fwp_gc+0x1190>
    37a8:	0f 9f c0             	setg   %al
    37ab:	20 c8                	and    %cl,%al
    37ad:	0f b6 c8             	movzbl %al,%ecx
    37b0:	89 0d c6 7a 01 00    	mov    %ecx,0x17ac6(%rip)        # 1b27c <fwp_gc+0xff4>
    37b6:	83 3d c7 7a 01 00 00 	cmpl   $0x0,0x17ac7(%rip)        # 1b284 <fwp_gc+0xffc>
    37bd:	74 16                	je     37d5 <fwp_main_thread+0x75>
    37bf:	48 8d 3d ba 03 01 00 	lea    0x103ba(%rip),%rdi        # 13b80 <fwp_gc_report>
    37c6:	e8 c5 08 01 00       	call   14090 <atexit>
    37cb:	83 3d aa 7a 01 00 00 	cmpl   $0x0,0x17aaa(%rip)        # 1b27c <fwp_gc+0xff4>
    37d2:	0f 95 c0             	setne  %al
    37d5:	84 c0                	test   %al,%al
    37d7:	74 43                	je     381c <fwp_main_thread+0xbc>
    37d9:	48 83 3d c7 7a 01 00 	cmpq   $0x0,0x17ac7(%rip)        # 1b2a8 <fwp_gc+0x1020>
    37e0:	00 
    37e1:	74 39                	je     381c <fwp_main_thread+0xbc>
    37e3:	48 8b 05 ae 7c 01 00 	mov    0x17cae(%rip),%rax        # 1b498 <fwp_gc+0x1210>
    37ea:	48 2b 05 97 6a 01 00 	sub    0x16a97(%rip),%rax        # 1a288 <fwp_gc>
    37f1:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    37f6:	f2 0f 58 05 72 7c 01 	addsd  0x17c72(%rip),%xmm0        # 1b470 <fwp_gc+0x11e8>
    37fd:	00 
    37fe:	f2 0f 11 05 6a 7c 01 	movsd  %xmm0,0x17c6a(%rip)        # 1b470 <fwp_gc+0x11e8>
    3805:	00 
    3806:	48 c7 05 87 7c 01 00 	movq   $0x0,0x17c87(%rip)        # 1b498 <fwp_gc+0x1210>
    380d:	00 00 00 00 
    3811:	48 c7 05 6c 6a 01 00 	movq   $0x0,0x16a6c(%rip)        # 1a288 <fwp_gc>
    3818:	00 00 00 00 
    381c:	48 8b 05 5d 6a 01 00 	mov    0x16a5d(%rip),%rax        # 1a280 <fwp_main_stack>
    3823:	48 8d 8d 60 ff ff ff 	lea    -0xa0(%rbp),%rcx
    382a:	48 89 0d b7 86 01 00 	mov    %rcx,0x186b7(%rip)        # 1bee8 <fwp_main_stack_top>
    3831:	48 89 05 b8 86 01 00 	mov    %rax,0x186b8(%rip)        # 1bef0 <fwp_main_stack_size>
    3838:	48 8d 05 c1 86 01 00 	lea    0x186c1(%rip),%rax        # 1bf00 <fwp_stack_guard_init.alt>
    383f:	48 89 85 e0 fe ff ff 	mov    %rax,-0x120(%rbp)
    3846:	48 c7 85 f0 fe ff ff 	movq   $0x10000,-0x110(%rbp)
    384d:	00 00 01 00 
    3851:	c7 85 e8 fe ff ff 00 	movl   $0x0,-0x118(%rbp)
    3858:	00 00 00 
    385b:	48 8d bd e0 fe ff ff 	lea    -0x120(%rbp),%rdi
    3862:	31 f6                	xor    %esi,%esi
    3864:	e8 47 fc ff ff       	call   34b0 <sigaltstack@plt>
    3869:	85 c0                	test   %eax,%eax
    386b:	0f 85 95 00 00 00    	jne    3906 <fwp_main_thread+0x1a6>
    3871:	48 8d bd d8 fd ff ff 	lea    -0x228(%rbp),%rdi
    3878:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    387c:	66 0f 11 85 58 fe ff 	movupd %xmm0,-0x1a8(%rbp)
    3883:	ff 
    3884:	66 0f 11 85 48 fe ff 	movupd %xmm0,-0x1b8(%rbp)
    388b:	ff 
    388c:	66 0f 11 85 38 fe ff 	movupd %xmm0,-0x1c8(%rbp)
    3893:	ff 
    3894:	66 0f 11 85 28 fe ff 	movupd %xmm0,-0x1d8(%rbp)
    389b:	ff 
    389c:	66 0f 11 85 18 fe ff 	movupd %xmm0,-0x1e8(%rbp)
    38a3:	ff 
    38a4:	66 0f 11 85 08 fe ff 	movupd %xmm0,-0x1f8(%rbp)
    38ab:	ff 
    38ac:	66 0f 11 85 f8 fd ff 	movupd %xmm0,-0x208(%rbp)
    38b3:	ff 
    38b4:	66 0f 11 85 e8 fd ff 	movupd %xmm0,-0x218(%rbp)
    38bb:	ff 
    38bc:	66 0f 11 85 d8 fd ff 	movupd %xmm0,-0x228(%rbp)
    38c3:	ff 
    38c4:	48 8d 05 45 78 00 00 	lea    0x7845(%rip),%rax        # b110 <fwp_segv>
    38cb:	48 89 85 d0 fd ff ff 	mov    %rax,-0x230(%rbp)
    38d2:	c7 85 58 fe ff ff 04 	movl   $0x8000004,-0x1a8(%rbp)
    38d9:	00 00 08 
    38dc:	e8 2f fa ff ff       	call   3310 <sigemptyset@plt>
    38e1:	48 8d 9d d0 fd ff ff 	lea    -0x230(%rbp),%rbx
    38e8:	bf 0b 00 00 00       	mov    $0xb,%edi
    38ed:	48 89 de             	mov    %rbx,%rsi
    38f0:	31 d2                	xor    %edx,%edx
    38f2:	e8 e9 f7 ff ff       	call   30e0 <sigaction@plt>
    38f7:	bf 07 00 00 00       	mov    $0x7,%edi
    38fc:	48 89 de             	mov    %rbx,%rsi
    38ff:	31 d2                	xor    %edx,%edx
    3901:	e8 da f7 ff ff       	call   30e0 <sigaction@plt>
    3906:	66 0f 6f 05 72 63 01 	movdqa 0x16372(%rip),%xmm0        # 19c80 <exec_scripts>
    390d:	00 
    390e:	66 0f 7f 05 ba 85 01 	movdqa %xmm0,0x185ba(%rip)        # 1bed0 <fwp_cli_scripts>
    3915:	00 
    3916:	48 8b 05 73 63 01 00 	mov    0x16373(%rip),%rax        # 19c90 <exec_scripts+0x10>
    391d:	48 89 05 bc 85 01 00 	mov    %rax,0x185bc(%rip)        # 1bee0 <fwp_cli_scripts+0x10>
    3924:	4c 63 35 55 85 01 00 	movslq 0x18555(%rip),%r14        # 1be80 <fwp_argc>
    392b:	41 8d 46 ff          	lea    -0x1(%r14),%eax
    392f:	89 45 d0             	mov    %eax,-0x30(%rbp)
    3932:	4c 8b 2d 4f 85 01 00 	mov    0x1854f(%rip),%r13        # 1be88 <fwp_argv>
    3939:	49 83 fe 02          	cmp    $0x2,%r14
    393d:	7c 37                	jl     3976 <fwp_main_thread+0x216>
    393f:	49 8b 5d 08          	mov    0x8(%r13),%rbx
    3943:	48 8d 35 a0 2c 01 00 	lea    0x12ca0(%rip),%rsi        # 165ea <exec_in_fp0+0xd7a>
    394a:	48 89 df             	mov    %rbx,%rdi
    394d:	e8 7e f9 ff ff       	call   32d0 <strcmp@plt>
    3952:	85 c0                	test   %eax,%eax
    3954:	0f 84 b0 00 00 00    	je     3a0a <fwp_main_thread+0x2aa>
    395a:	48 8d 35 8f 2c 01 00 	lea    0x12c8f(%rip),%rsi        # 165f0 <exec_in_fp0+0xd80>
    3961:	ba 0d 00 00 00       	mov    $0xd,%edx
    3966:	48 89 df             	mov    %rbx,%rdi
    3969:	e8 22 f7 ff ff       	call   3090 <strncmp@plt>
    396e:	85 c0                	test   %eax,%eax
    3970:	0f 84 f9 04 00 00    	je     3e6f <fwp_main_thread+0x70f>
    3976:	48 ff 05 2b 85 01 00 	incq   0x1852b(%rip)        # 1bea8 <measured_calls>
    397d:	4a 8d 3c f5 00 00 00 	lea    0x0(,%r14,8),%rdi
    3984:	00 
    3985:	48 01 3d 24 85 01 00 	add    %rdi,0x18524(%rip)        # 1beb0 <measured_bytes>
    398c:	48 8d 35 f5 68 01 00 	lea    0x168f5(%rip),%rsi        # 1a288 <fwp_gc>
    3993:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    399a:	48 89 7d b0          	mov    %rdi,-0x50(%rbp)
    399e:	77 5a                	ja     39fa <fwp_main_thread+0x29a>
    39a0:	48 8d 47 0f          	lea    0xf(%rdi),%rax
    39a4:	48 c1 e8 04          	shr    $0x4,%rax
    39a8:	0f b6 84 30 e8 0b 00 	movzbl 0xbe8(%rax,%rsi,1),%eax
    39af:	00 
    39b0:	8b 94 86 48 0b 00 00 	mov    0xb48(%rsi,%rax,4),%edx
    39b7:	48 29 15 ca 68 01 00 	sub    %rdx,0x168ca(%rip)        # 1a288 <fwp_gc>
    39be:	78 3a                	js     39fa <fwp_main_thread+0x29a>
    39c0:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
    39c4:	48 8d 0c c6          	lea    (%rsi,%rax,8),%rcx
    39c8:	48 81 c1 88 07 00 00 	add    $0x788,%rcx
    39cf:	4c 8b 01             	mov    (%rcx),%r8
    39d2:	4d 85 c0             	test   %r8,%r8
    39d5:	74 0b                	je     39e2 <fwp_main_thread+0x282>
    39d7:	49 8b 00             	mov    (%r8),%rax
    39da:	48 f7 d0             	not    %rax
    39dd:	48 89 01             	mov    %rax,(%rcx)
    39e0:	eb 61                	jmp    3a43 <fwp_main_thread+0x2e3>
    39e2:	4c 8b 84 c6 90 07 00 	mov    0x790(%rsi,%rax,8),%r8
    39e9:	00 
    39ea:	48 8b 8c c6 98 07 00 	mov    0x798(%rsi,%rax,8),%rcx
    39f1:	00 
    39f2:	4c 29 c1             	sub    %r8,%rcx
    39f5:	48 39 d1             	cmp    %rdx,%rcx
    39f8:	73 38                	jae    3a32 <fwp_main_thread+0x2d2>
    39fa:	be 02 00 00 00       	mov    $0x2,%esi
    39ff:	e8 bc 48 00 00       	call   82c0 <fwp_gc_alloc_slow>
    3a04:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    3a08:	eb 47                	jmp    3a51 <fwp_main_thread+0x2f1>
    3a0a:	48 8b 05 9f 65 01 00 	mov    0x1659f(%rip),%rax        # 19fb0 <stdout@GLIBC_2.2.5>
    3a11:	48 8b 08             	mov    (%rax),%rcx
    3a14:	48 8d 3d 95 1c 01 00 	lea    0x11c95(%rip),%rdi        # 156b0 <exec_man>
    3a1b:	be 63 01 00 00       	mov    $0x163,%esi
    3a20:	ba 01 00 00 00       	mov    $0x1,%edx
    3a25:	e8 56 fa ff ff       	call   3480 <fwrite@plt>
    3a2a:	45 31 e4             	xor    %r12d,%r12d
    3a2d:	e9 c6 15 00 00       	jmp    4ff8 <fwp_main_thread+0x1898>
    3a32:	48 8d 04 c6          	lea    (%rsi,%rax,8),%rax
    3a36:	48 05 90 07 00 00    	add    $0x790,%rax
    3a3c:	49 8d 0c 10          	lea    (%r8,%rdx,1),%rcx
    3a40:	48 89 08             	mov    %rcx,(%rax)
    3a43:	4c 89 45 c0          	mov    %r8,-0x40(%rbp)
    3a47:	4c 89 c7             	mov    %r8,%rdi
    3a4a:	31 f6                	xor    %esi,%esi
    3a4c:	e8 bf f7 ff ff       	call   3210 <memset@plt>
    3a51:	4c 89 75 a8          	mov    %r14,-0x58(%rbp)
    3a55:	41 83 fe 02          	cmp    $0x2,%r14d
    3a59:	48 8b 5d c0          	mov    -0x40(%rbp),%rbx
    3a5d:	7c 3b                	jl     3a9a <fwp_main_thread+0x33a>
    3a5f:	8b 4d d0             	mov    -0x30(%rbp),%ecx
    3a62:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    3a66:	45 31 e4             	xor    %r12d,%r12d
    3a69:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    3a70:	4d 8d 74 24 01       	lea    0x1(%r12),%r14
    3a75:	4f 8b 7c e5 08       	mov    0x8(%r13,%r12,8),%r15
    3a7a:	4c 89 ff             	mov    %r15,%rdi
    3a7d:	e8 ee f6 ff ff       	call   3170 <strlen@plt>
    3a82:	4c 89 ff             	mov    %r15,%rdi
    3a85:	48 89 c6             	mov    %rax,%rsi
    3a88:	e8 e3 76 00 00       	call   b170 <fwp_str_lossy>
    3a8d:	4a 89 04 e3          	mov    %rax,(%rbx,%r12,8)
    3a91:	4d 89 f4             	mov    %r14,%r12
    3a94:	4c 39 75 c8          	cmp    %r14,-0x38(%rbp)
    3a98:	75 d6                	jne    3a70 <fwp_main_thread+0x310>
    3a9a:	4c 8b 3d 07 84 01 00 	mov    0x18407(%rip),%r15        # 1bea8 <measured_calls>
    3aa1:	49 ff c7             	inc    %r15
    3aa4:	4c 89 3d fd 83 01 00 	mov    %r15,0x183fd(%rip)        # 1bea8 <measured_calls>
    3aab:	4c 8b 2d fe 83 01 00 	mov    0x183fe(%rip),%r13        # 1beb0 <measured_bytes>
    3ab2:	49 83 c5 08          	add    $0x8,%r13
    3ab6:	4c 89 2d f3 83 01 00 	mov    %r13,0x183f3(%rip)        # 1beb0 <measured_bytes>
    3abd:	0f b6 05 ad 73 01 00 	movzbl 0x173ad(%rip),%eax        # 1ae71 <fwp_gc+0xbe9>
    3ac4:	48 8d 1d bd 67 01 00 	lea    0x167bd(%rip),%rbx        # 1a288 <fwp_gc>
    3acb:	8b 94 83 48 0b 00 00 	mov    0xb48(%rbx,%rax,4),%edx
    3ad2:	48 29 15 af 67 01 00 	sub    %rdx,0x167af(%rip)        # 1a288 <fwp_gc>
    3ad9:	78 3a                	js     3b15 <fwp_main_thread+0x3b5>
    3adb:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
    3adf:	48 8d 0c c3          	lea    (%rbx,%rax,8),%rcx
    3ae3:	48 81 c1 88 07 00 00 	add    $0x788,%rcx
    3aea:	48 8b 39             	mov    (%rcx),%rdi
    3aed:	48 85 ff             	test   %rdi,%rdi
    3af0:	74 0b                	je     3afd <fwp_main_thread+0x39d>
    3af2:	48 8b 07             	mov    (%rdi),%rax
    3af5:	48 f7 d0             	not    %rax
    3af8:	48 89 01             	mov    %rax,(%rcx)
    3afb:	eb 48                	jmp    3b45 <fwp_main_thread+0x3e5>
    3afd:	48 8b bc c3 90 07 00 	mov    0x790(%rbx,%rax,8),%rdi
    3b04:	00 
    3b05:	48 8b 8c c3 98 07 00 	mov    0x798(%rbx,%rax,8),%rcx
    3b0c:	00 
    3b0d:	48 29 f9             	sub    %rdi,%rcx
    3b10:	48 39 d1             	cmp    %rdx,%rcx
    3b13:	73 1f                	jae    3b34 <fwp_main_thread+0x3d4>
    3b15:	bf 08 00 00 00       	mov    $0x8,%edi
    3b1a:	be 02 00 00 00       	mov    $0x2,%esi
    3b1f:	e8 9c 47 00 00       	call   82c0 <fwp_gc_alloc_slow>
    3b24:	4c 8b 3d 7d 83 01 00 	mov    0x1837d(%rip),%r15        # 1bea8 <measured_calls>
    3b2b:	4c 8b 2d 7e 83 01 00 	mov    0x1837e(%rip),%r13        # 1beb0 <measured_bytes>
    3b32:	eb 18                	jmp    3b4c <fwp_main_thread+0x3ec>
    3b34:	48 8d 04 c3          	lea    (%rbx,%rax,8),%rax
    3b38:	48 05 90 07 00 00    	add    $0x790,%rax
    3b3e:	48 8d 0c 17          	lea    (%rdi,%rdx,1),%rcx
    3b42:	48 89 08             	mov    %rcx,(%rax)
    3b45:	31 f6                	xor    %esi,%esi
    3b47:	e8 c4 f6 ff ff       	call   3210 <memset@plt>
    3b4c:	4c 8b 65 b0          	mov    -0x50(%rbp),%r12
    3b50:	49 ff c7             	inc    %r15
    3b53:	4c 89 3d 4e 83 01 00 	mov    %r15,0x1834e(%rip)        # 1bea8 <measured_calls>
    3b5a:	49 ff c5             	inc    %r13
    3b5d:	4c 89 2d 4c 83 01 00 	mov    %r13,0x1834c(%rip)        # 1beb0 <measured_bytes>
    3b64:	0f b6 0d 06 73 01 00 	movzbl 0x17306(%rip),%ecx        # 1ae71 <fwp_gc+0xbe9>
    3b6b:	8b 84 8b 48 0b 00 00 	mov    0xb48(%rbx,%rcx,4),%eax
    3b72:	48 29 05 0f 67 01 00 	sub    %rax,0x1670f(%rip)        # 1a288 <fwp_gc>
    3b79:	4c 8b 75 a8          	mov    -0x58(%rbp),%r14
    3b7d:	78 3d                	js     3bbc <fwp_main_thread+0x45c>
    3b7f:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    3b83:	48 8d 14 cb          	lea    (%rbx,%rcx,8),%rdx
    3b87:	48 81 c2 c8 03 00 00 	add    $0x3c8,%rdx
    3b8e:	48 8b 32             	mov    (%rdx),%rsi
    3b91:	48 85 f6             	test   %rsi,%rsi
    3b94:	74 0e                	je     3ba4 <fwp_main_thread+0x444>
    3b96:	48 8b 06             	mov    (%rsi),%rax
    3b99:	48 f7 d0             	not    %rax
    3b9c:	48 89 02             	mov    %rax,(%rdx)
    3b9f:	c6 06 00             	movb   $0x0,(%rsi)
    3ba2:	eb 4b                	jmp    3bef <fwp_main_thread+0x48f>
    3ba4:	48 8b 94 cb d0 03 00 	mov    0x3d0(%rbx,%rcx,8),%rdx
    3bab:	00 
    3bac:	48 8b b4 cb d8 03 00 	mov    0x3d8(%rbx,%rcx,8),%rsi
    3bb3:	00 
    3bb4:	48 29 d6             	sub    %rdx,%rsi
    3bb7:	48 39 c6             	cmp    %rax,%rsi
    3bba:	73 1f                	jae    3bdb <fwp_main_thread+0x47b>
    3bbc:	bf 01 00 00 00       	mov    $0x1,%edi
    3bc1:	be 01 00 00 00       	mov    $0x1,%esi
    3bc6:	e8 f5 46 00 00       	call   82c0 <fwp_gc_alloc_slow>
    3bcb:	4c 8b 3d d6 82 01 00 	mov    0x182d6(%rip),%r15        # 1bea8 <measured_calls>
    3bd2:	4c 8b 2d d7 82 01 00 	mov    0x182d7(%rip),%r13        # 1beb0 <measured_bytes>
    3bd9:	eb 14                	jmp    3bef <fwp_main_thread+0x48f>
    3bdb:	48 8d 0c cb          	lea    (%rbx,%rcx,8),%rcx
    3bdf:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
    3be6:	48 01 d0             	add    %rdx,%rax
    3be9:	48 89 01             	mov    %rax,(%rcx)
    3bec:	c6 02 00             	movb   $0x0,(%rdx)
    3bef:	49 ff c7             	inc    %r15
    3bf2:	4d 01 e5             	add    %r12,%r13
    3bf5:	4c 89 3d ac 82 01 00 	mov    %r15,0x182ac(%rip)        # 1bea8 <measured_calls>
    3bfc:	4c 89 2d ad 82 01 00 	mov    %r13,0x182ad(%rip)        # 1beb0 <measured_bytes>
    3c03:	49 81 fc 00 40 00 00 	cmp    $0x4000,%r12
    3c0a:	77 5b                	ja     3c67 <fwp_main_thread+0x507>
    3c0c:	49 8d 44 24 0f       	lea    0xf(%r12),%rax
    3c11:	48 c1 e8 04          	shr    $0x4,%rax
    3c15:	0f b6 84 18 e8 0b 00 	movzbl 0xbe8(%rax,%rbx,1),%eax
    3c1c:	00 
    3c1d:	8b 94 83 48 0b 00 00 	mov    0xb48(%rbx,%rax,4),%edx
    3c24:	48 29 15 5d 66 01 00 	sub    %rdx,0x1665d(%rip)        # 1a288 <fwp_gc>
    3c2b:	78 3a                	js     3c67 <fwp_main_thread+0x507>
    3c2d:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
    3c31:	48 8d 0c c3          	lea    (%rbx,%rax,8),%rcx
    3c35:	48 81 c1 88 07 00 00 	add    $0x788,%rcx
    3c3c:	4c 8b 39             	mov    (%rcx),%r15
    3c3f:	4d 85 ff             	test   %r15,%r15
    3c42:	74 0b                	je     3c4f <fwp_main_thread+0x4ef>
    3c44:	49 8b 07             	mov    (%r15),%rax
    3c47:	48 f7 d0             	not    %rax
    3c4a:	48 89 01             	mov    %rax,(%rcx)
    3c4d:	eb 3b                	jmp    3c8a <fwp_main_thread+0x52a>
    3c4f:	4c 8b bc c3 90 07 00 	mov    0x790(%rbx,%rax,8),%r15
    3c56:	00 
    3c57:	48 8b 8c c3 98 07 00 	mov    0x798(%rbx,%rax,8),%rcx
    3c5e:	00 
    3c5f:	4c 29 f9             	sub    %r15,%rcx
    3c62:	48 39 d1             	cmp    %rdx,%rcx
    3c65:	73 12                	jae    3c79 <fwp_main_thread+0x519>
    3c67:	4c 89 e7             	mov    %r12,%rdi
    3c6a:	be 02 00 00 00       	mov    $0x2,%esi
    3c6f:	e8 4c 46 00 00       	call   82c0 <fwp_gc_alloc_slow>
    3c74:	49 89 c3             	mov    %rax,%r11
    3c77:	eb 1e                	jmp    3c97 <fwp_main_thread+0x537>
    3c79:	48 8d 04 c3          	lea    (%rbx,%rax,8),%rax
    3c7d:	48 05 90 07 00 00    	add    $0x790,%rax
    3c83:	49 8d 0c 17          	lea    (%r15,%rdx,1),%rcx
    3c87:	48 89 08             	mov    %rcx,(%rax)
    3c8a:	4c 89 ff             	mov    %r15,%rdi
    3c8d:	31 f6                	xor    %esi,%esi
    3c8f:	e8 7c f5 ff ff       	call   3210 <memset@plt>
    3c94:	4d 89 fb             	mov    %r15,%r11
    3c97:	31 d2                	xor    %edx,%edx
    3c99:	41 83 fe 02          	cmp    $0x2,%r14d
    3c9d:	48 8b 75 c0          	mov    -0x40(%rbp),%rsi
    3ca1:	0f 8c 4a 01 00 00    	jl     3df1 <fwp_main_thread+0x691>
    3ca7:	44 8b 45 d0          	mov    -0x30(%rbp),%r8d
    3cab:	4d 89 c1             	mov    %r8,%r9
    3cae:	49 f7 d9             	neg    %r9
    3cb1:	41 b5 01             	mov    $0x1,%r13b
    3cb4:	31 d2                	xor    %edx,%edx
    3cb6:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    3cbc:	31 db                	xor    %ebx,%ebx
    3cbe:	66 90                	xchg   %ax,%ax
    3cc0:	4e 8b 64 fe f8       	mov    -0x8(%rsi,%r15,8),%r12
    3cc5:	85 db                	test   %ebx,%ebx
    3cc7:	0f 85 c3 00 00 00    	jne    3d90 <fwp_main_thread+0x630>
    3ccd:	4d 8b 34 24          	mov    (%r12),%r14
    3cd1:	49 83 fe 02          	cmp    $0x2,%r14
    3cd5:	0f 82 b5 00 00 00    	jb     3d90 <fwp_main_thread+0x630>
    3cdb:	41 80 7c 24 08 2d    	cmpb   $0x2d,0x8(%r12)
    3ce1:	0f 85 a9 00 00 00    	jne    3d90 <fwp_main_thread+0x630>
    3ce7:	41 0f b6 44 24 09    	movzbl 0x9(%r12),%eax
    3ced:	3c 2e                	cmp    $0x2e,%al
    3cef:	0f 84 9b 00 00 00    	je     3d90 <fwp_main_thread+0x630>
    3cf5:	8d 48 d0             	lea    -0x30(%rax),%ecx
    3cf8:	80 f9 0a             	cmp    $0xa,%cl
    3cfb:	0f 82 8f 00 00 00    	jb     3d90 <fwp_main_thread+0x630>
    3d01:	49 83 fe 02          	cmp    $0x2,%r14
    3d05:	75 0e                	jne    3d15 <fwp_main_thread+0x5b5>
    3d07:	3c 2d                	cmp    $0x2d,%al
    3d09:	75 0a                	jne    3d15 <fwp_main_thread+0x5b5>
    3d0b:	bb 01 00 00 00       	mov    $0x1,%ebx
    3d10:	e9 84 00 00 00       	jmp    3d99 <fwp_main_thread+0x639>
    3d15:	3c 2d                	cmp    $0x2d,%al
    3d17:	75 66                	jne    3d7f <fwp_main_thread+0x61f>
    3d19:	49 8d 7c 24 0a       	lea    0xa(%r12),%rdi
    3d1e:	48 89 bd 58 ff ff ff 	mov    %rdi,-0xa8(%rbp)
    3d25:	49 83 c6 fe          	add    $0xfffffffffffffffe,%r14
    3d29:	4c 89 5d d0          	mov    %r11,-0x30(%rbp)
    3d2d:	89 55 c8             	mov    %edx,-0x38(%rbp)
    3d30:	be 3d 00 00 00       	mov    $0x3d,%esi
    3d35:	4c 89 f2             	mov    %r14,%rdx
    3d38:	4c 89 45 a8          	mov    %r8,-0x58(%rbp)
    3d3c:	4c 89 4d b0          	mov    %r9,-0x50(%rbp)
    3d40:	e8 1b f5 ff ff       	call   3260 <memchr@plt>
    3d45:	4c 8b 95 58 ff ff ff 	mov    -0xa8(%rbp),%r10
    3d4c:	4c 8b 4d b0          	mov    -0x50(%rbp),%r9
    3d50:	4c 8b 45 a8          	mov    -0x58(%rbp),%r8
    3d54:	4c 8b 5d d0          	mov    -0x30(%rbp),%r11
    3d58:	48 8b 75 c0          	mov    -0x40(%rbp),%rsi
    3d5c:	8b 55 c8             	mov    -0x38(%rbp),%edx
    3d5f:	48 89 c1             	mov    %rax,%rcx
    3d62:	4c 29 d1             	sub    %r10,%rcx
    3d65:	48 85 c0             	test   %rax,%rax
    3d68:	49 0f 44 ce          	cmove  %r14,%rcx
    3d6c:	75 22                	jne    3d90 <fwp_main_thread+0x630>
    3d6e:	48 83 f9 04          	cmp    $0x4,%rcx
    3d72:	75 1c                	jne    3d90 <fwp_main_thread+0x630>
    3d74:	41 81 3a 68 65 6c 70 	cmpl   $0x706c6568,(%r10)
    3d7b:	75 13                	jne    3d90 <fwp_main_thread+0x630>
    3d7d:	eb 35                	jmp    3db4 <fwp_main_thread+0x654>
    3d7f:	49 83 fe 02          	cmp    $0x2,%r14
    3d83:	75 0b                	jne    3d90 <fwp_main_thread+0x630>
    3d85:	3c 68                	cmp    $0x68,%al
    3d87:	74 2b                	je     3db4 <fwp_main_thread+0x654>
    3d89:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    3d90:	48 63 c2             	movslq %edx,%rax
    3d93:	ff c2                	inc    %edx
    3d95:	4d 89 24 c3          	mov    %r12,(%r11,%rax,8)
    3d99:	4d 39 c7             	cmp    %r8,%r15
    3d9c:	41 0f 92 c5          	setb   %r13b
    3da0:	4b 8d 04 39          	lea    (%r9,%r15,1),%rax
    3da4:	48 ff c0             	inc    %rax
    3da7:	49 ff c7             	inc    %r15
    3daa:	48 83 f8 01          	cmp    $0x1,%rax
    3dae:	0f 85 0c ff ff ff    	jne    3cc0 <fwp_main_thread+0x560>
    3db4:	41 f6 c5 01          	test   $0x1,%r13b
    3db8:	48 8d 1d c9 64 01 00 	lea    0x164c9(%rip),%rbx        # 1a288 <fwp_gc>
    3dbf:	74 30                	je     3df1 <fwp_main_thread+0x691>
    3dc1:	48 8b 1d e8 61 01 00 	mov    0x161e8(%rip),%rbx        # 19fb0 <stdout@GLIBC_2.2.5>
    3dc8:	48 8b 0b             	mov    (%rbx),%rcx
    3dcb:	48 8d 3d a8 2a 01 00 	lea    0x12aa8(%rip),%rdi        # 1687a <exec_in_fp0+0x100a>
    3dd2:	be 82 00 00 00       	mov    $0x82,%esi
    3dd7:	ba 01 00 00 00       	mov    $0x1,%edx
    3ddc:	e8 9f f6 ff ff       	call   3480 <fwrite@plt>
    3de1:	48 8b 3b             	mov    (%rbx),%rdi
    3de4:	e8 67 f5 ff ff       	call   3350 <fflush@plt>
    3de9:	45 31 e4             	xor    %r12d,%r12d
    3dec:	e9 07 12 00 00       	jmp    4ff8 <fwp_main_thread+0x1898>
    3df1:	89 55 c8             	mov    %edx,-0x38(%rbp)
    3df4:	48 ff 05 ad 80 01 00 	incq   0x180ad(%rip)        # 1bea8 <measured_calls>
    3dfb:	48 83 05 ad 80 01 00 	addq   $0x10,0x180ad(%rip)        # 1beb0 <measured_bytes>
    3e02:	10 
    3e03:	0f b6 05 67 70 01 00 	movzbl 0x17067(%rip),%eax        # 1ae71 <fwp_gc+0xbe9>
    3e0a:	8b 94 83 48 0b 00 00 	mov    0xb48(%rbx,%rax,4),%edx
    3e11:	48 29 15 70 64 01 00 	sub    %rdx,0x16470(%rip)        # 1a288 <fwp_gc>
    3e18:	78 3e                	js     3e58 <fwp_main_thread+0x6f8>
    3e1a:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
    3e1e:	48 8d 0c c3          	lea    (%rbx,%rax,8),%rcx
    3e22:	48 81 c1 88 07 00 00 	add    $0x788,%rcx
    3e29:	4c 8b 29             	mov    (%rcx),%r13
    3e2c:	4d 85 ed             	test   %r13,%r13
    3e2f:	74 0f                	je     3e40 <fwp_main_thread+0x6e0>
    3e31:	4d 89 de             	mov    %r11,%r14
    3e34:	49 8b 45 00          	mov    0x0(%r13),%rax
    3e38:	48 f7 d0             	not    %rax
    3e3b:	48 89 01             	mov    %rax,(%rcx)
    3e3e:	eb 61                	jmp    3ea1 <fwp_main_thread+0x741>
    3e40:	4c 8b ac c3 90 07 00 	mov    0x790(%rbx,%rax,8),%r13
    3e47:	00 
    3e48:	48 8b 8c c3 98 07 00 	mov    0x798(%rbx,%rax,8),%rcx
    3e4f:	00 
    3e50:	4c 29 e9             	sub    %r13,%rcx
    3e53:	48 39 d1             	cmp    %rdx,%rcx
    3e56:	73 35                	jae    3e8d <fwp_main_thread+0x72d>
    3e58:	4d 89 de             	mov    %r11,%r14
    3e5b:	bf 10 00 00 00       	mov    $0x10,%edi
    3e60:	be 02 00 00 00       	mov    $0x2,%esi
    3e65:	e8 56 44 00 00       	call   82c0 <fwp_gc_alloc_slow>
    3e6a:	49 89 c5             	mov    %rax,%r13
    3e6d:	eb 3c                	jmp    3eab <fwp_main_thread+0x74b>
    3e6f:	0f b6 43 0d          	movzbl 0xd(%rbx),%eax
    3e73:	85 c0                	test   %eax,%eax
    3e75:	0f 84 3b 01 00 00    	je     3fb6 <fwp_main_thread+0x856>
    3e7b:	83 f8 3d             	cmp    $0x3d,%eax
    3e7e:	0f 85 f2 fa ff ff    	jne    3976 <fwp_main_thread+0x216>
    3e84:	48 83 c3 0e          	add    $0xe,%rbx
    3e88:	e9 37 01 00 00       	jmp    3fc4 <fwp_main_thread+0x864>
    3e8d:	4d 89 de             	mov    %r11,%r14
    3e90:	48 8d 04 c3          	lea    (%rbx,%rax,8),%rax
    3e94:	48 05 90 07 00 00    	add    $0x790,%rax
    3e9a:	4a 8d 0c 2a          	lea    (%rdx,%r13,1),%rcx
    3e9e:	48 89 08             	mov    %rcx,(%rax)
    3ea1:	4c 89 ef             	mov    %r13,%rdi
    3ea4:	31 f6                	xor    %esi,%esi
    3ea6:	e8 65 f3 ff ff       	call   3210 <memset@plt>
    3eab:	83 7d c8 01          	cmpl   $0x1,-0x38(%rbp)
    3eaf:	0f 87 9d 01 00 00    	ja     4052 <fwp_main_thread+0x8f2>
    3eb5:	0f 85 ef 03 00 00    	jne    42aa <fwp_main_thread+0xb4a>
    3ebb:	4d 8b 26             	mov    (%r14),%r12
    3ebe:	4d 8b 04 24          	mov    (%r12),%r8
    3ec2:	49 83 c4 08          	add    $0x8,%r12
    3ec6:	83 3d 23 7f 01 00 0e 	cmpl   $0xe,0x17f23(%rip)        # 1bdf0 <d3>
    3ecd:	4c 89 45 d0          	mov    %r8,-0x30(%rbp)
    3ed1:	75 42                	jne    3f15 <fwp_main_thread+0x7b5>
    3ed3:	8b 1d 27 7f 01 00    	mov    0x17f27(%rip),%ebx        # 1be00 <d3+0x10>
    3ed9:	85 db                	test   %ebx,%ebx
    3edb:	74 38                	je     3f15 <fwp_main_thread+0x7b5>
    3edd:	48 8b 3d 14 7f 01 00 	mov    0x17f14(%rip),%rdi        # 1bdf8 <d3+0x8>
    3ee4:	48 85 ff             	test   %rdi,%rdi
    3ee7:	74 14                	je     3efd <fwp_main_thread+0x79d>
    3ee9:	48 8d 35 c6 27 01 00 	lea    0x127c6(%rip),%rsi        # 166b6 <exec_in_fp0+0xe46>
    3ef0:	e8 db f3 ff ff       	call   32d0 <strcmp@plt>
    3ef5:	4c 8b 45 d0          	mov    -0x30(%rbp),%r8
    3ef9:	85 c0                	test   %eax,%eax
    3efb:	74 18                	je     3f15 <fwp_main_thread+0x7b5>
    3efd:	85 db                	test   %ebx,%ebx
    3eff:	0f 8e a7 01 00 00    	jle    40ac <fwp_main_thread+0x94c>
    3f05:	48 8b 05 0c 7f 01 00 	mov    0x17f0c(%rip),%rax        # 1be18 <d3+0x28>
    3f0c:	83 38 00             	cmpl   $0x0,(%rax)
    3f0f:	0f 84 6e 01 00 00    	je     4083 <fwp_main_thread+0x923>
    3f15:	4c 89 a5 d0 fd ff ff 	mov    %r12,-0x230(%rbp)
    3f1c:	4c 89 85 d8 fd ff ff 	mov    %r8,-0x228(%rbp)
    3f23:	48 c7 85 e0 fd ff ff 	movq   $0x0,-0x220(%rbp)
    3f2a:	00 00 00 00 
    3f2e:	48 8d 35 bb 7e 01 00 	lea    0x17ebb(%rip),%rsi        # 1bdf0 <d3>
    3f35:	48 8d bd d0 fd ff ff 	lea    -0x230(%rbp),%rdi
    3f3c:	ba 01 00 00 00       	mov    $0x1,%edx
    3f41:	4c 89 e9             	mov    %r13,%rcx
    3f44:	e8 07 98 00 00       	call   d750 <tp_value>
    3f49:	85 c0                	test   %eax,%eax
    3f4b:	0f 84 d1 10 00 00    	je     5022 <fwp_main_thread+0x18c2>
    3f51:	48 8b 85 d8 fd ff ff 	mov    -0x228(%rbp),%rax
    3f58:	48 8b 8d e0 fd ff ff 	mov    -0x220(%rbp),%rcx
    3f5f:	48 39 c1             	cmp    %rax,%rcx
    3f62:	73 40                	jae    3fa4 <fwp_main_thread+0x844>
    3f64:	48 8b 95 d0 fd ff ff 	mov    -0x230(%rbp),%rdx
    3f6b:	49 b8 00 26 00 00 01 	movabs $0x100002600,%r8
    3f72:	00 00 00 
    3f75:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    3f79:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    3f80:	0f b6 3c 0a          	movzbl (%rdx,%rcx,1),%edi
    3f84:	48 83 ff 20          	cmp    $0x20,%rdi
    3f88:	77 1e                	ja     3fa8 <fwp_main_thread+0x848>
    3f8a:	49 0f a3 f8          	bt     %rdi,%r8
    3f8e:	73 18                	jae    3fa8 <fwp_main_thread+0x848>
    3f90:	48 ff c1             	inc    %rcx
    3f93:	48 89 8d e0 fd ff ff 	mov    %rcx,-0x220(%rbp)
    3f9a:	48 39 c8             	cmp    %rcx,%rax
    3f9d:	75 e1                	jne    3f80 <fwp_main_thread+0x820>
    3f9f:	e9 06 03 00 00       	jmp    42aa <fwp_main_thread+0xb4a>
    3fa4:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    3fa8:	48 39 c1             	cmp    %rax,%rcx
    3fab:	0f 84 f9 02 00 00    	je     42aa <fwp_main_thread+0xb4a>
    3fb1:	e9 70 10 00 00       	jmp    5026 <fwp_main_thread+0x18c6>
    3fb6:	83 7d d0 01          	cmpl   $0x1,-0x30(%rbp)
    3fba:	0f 84 e1 12 00 00    	je     52a1 <fwp_main_thread+0x1b41>
    3fc0:	49 8b 5d 10          	mov    0x10(%r13),%rbx
    3fc4:	48 8d 35 71 26 01 00 	lea    0x12671(%rip),%rsi        # 1663c <exec_in_fp0+0xdcc>
    3fcb:	48 89 df             	mov    %rbx,%rdi
    3fce:	e8 fd f2 ff ff       	call   32d0 <strcmp@plt>
    3fd3:	45 31 e4             	xor    %r12d,%r12d
    3fd6:	85 c0                	test   %eax,%eax
    3fd8:	0f 84 9e 00 00 00    	je     407c <fwp_main_thread+0x91c>
    3fde:	48 8d 35 5c 26 01 00 	lea    0x1265c(%rip),%rsi        # 16641 <exec_in_fp0+0xdd1>
    3fe5:	48 89 df             	mov    %rbx,%rdi
    3fe8:	e8 e3 f2 ff ff       	call   32d0 <strcmp@plt>
    3fed:	85 c0                	test   %eax,%eax
    3fef:	0f 84 98 0f 00 00    	je     4f8d <fwp_main_thread+0x182d>
    3ff5:	48 8d 35 49 26 01 00 	lea    0x12649(%rip),%rsi        # 16645 <exec_in_fp0+0xdd5>
    3ffc:	48 89 df             	mov    %rbx,%rdi
    3fff:	e8 cc f2 ff ff       	call   32d0 <strcmp@plt>
    4004:	b9 02 00 00 00       	mov    $0x2,%ecx
    4009:	85 c0                	test   %eax,%eax
    400b:	0f 84 81 0f 00 00    	je     4f92 <fwp_main_thread+0x1832>
    4011:	48 89 df             	mov    %rbx,%rdi
    4014:	e8 57 f1 ff ff       	call   3170 <strlen@plt>
    4019:	48 89 df             	mov    %rbx,%rdi
    401c:	48 89 c6             	mov    %rax,%rsi
    401f:	e8 4c 71 00 00       	call   b170 <fwp_str_lossy>
    4024:	48 8b 0d ad 5f 01 00 	mov    0x15fad(%rip),%rcx        # 19fd8 <stderr@GLIBC_2.2.5>
    402b:	48 8b 39             	mov    (%rcx),%rdi
    402e:	48 8d 48 08          	lea    0x8(%rax),%rcx
    4032:	48 8d 35 11 26 01 00 	lea    0x12611(%rip),%rsi        # 1664a <exec_in_fp0+0xdda>
    4039:	48 8d 15 95 19 01 00 	lea    0x11995(%rip),%rdx        # 159d5 <exec_in_fp0+0x165>
    4040:	31 c0                	xor    %eax,%eax
    4042:	e8 a9 f2 ff ff       	call   32f0 <fprintf@plt>
    4047:	41 bc 02 00 00 00    	mov    $0x2,%r12d
    404d:	e9 a6 0f 00 00       	jmp    4ff8 <fwp_main_thread+0x1898>
    4052:	48 8b 05 7f 5f 01 00 	mov    0x15f7f(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    4059:	48 8b 38             	mov    (%rax),%rdi
    405c:	48 8d 35 a8 26 01 00 	lea    0x126a8(%rip),%rsi        # 1670b <exec_in_fp0+0xe9b>
    4063:	48 8d 15 b4 27 01 00 	lea    0x127b4(%rip),%rdx        # 1681e <exec_in_fp0+0xfae>
    406a:	31 c0                	xor    %eax,%eax
    406c:	e8 7f f2 ff ff       	call   32f0 <fprintf@plt>
    4071:	41 bc 02 00 00 00    	mov    $0x2,%r12d
    4077:	e9 7c 0f 00 00       	jmp    4ff8 <fwp_main_thread+0x1898>
    407c:	31 c9                	xor    %ecx,%ecx
    407e:	e9 0f 0f 00 00       	jmp    4f92 <fwp_main_thread+0x1832>
    4083:	48 8d 4b ff          	lea    -0x1(%rbx),%rcx
    4087:	31 d2                	xor    %edx,%edx
    4089:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    4090:	48 39 d1             	cmp    %rdx,%rcx
    4093:	74 17                	je     40ac <fwp_main_thread+0x94c>
    4095:	48 8d 72 01          	lea    0x1(%rdx),%rsi
    4099:	83 7c 90 04 00       	cmpl   $0x0,0x4(%rax,%rdx,4)
    409e:	48 89 f2             	mov    %rsi,%rdx
    40a1:	74 ed                	je     4090 <fwp_main_thread+0x930>
    40a3:	48 39 de             	cmp    %rbx,%rsi
    40a6:	0f 82 69 fe ff ff    	jb     3f15 <fwp_main_thread+0x7b5>
    40ac:	66 0f ef c0          	pxor   %xmm0,%xmm0
    40b0:	66 0f 7f 85 e0 fe ff 	movdqa %xmm0,-0x120(%rbp)
    40b7:	ff 
    40b8:	48 c7 85 f0 fe ff ff 	movq   $0x0,-0x110(%rbp)
    40bf:	00 00 00 00 
    40c3:	66 0f 7f 85 60 ff ff 	movdqa %xmm0,-0xa0(%rbp)
    40ca:	ff 
    40cb:	48 c7 85 70 ff ff ff 	movq   $0x0,-0x90(%rbp)
    40d2:	00 00 00 00 
    40d6:	48 c7 85 e8 fe ff ff 	movq   $0x0,-0x118(%rbp)
    40dd:	00 00 00 00 
    40e1:	4d 85 c0             	test   %r8,%r8
    40e4:	4c 89 a5 d8 fe ff ff 	mov    %r12,-0x128(%rbp)
    40eb:	0f 84 92 01 00 00    	je     4283 <fwp_main_thread+0xb23>
    40f1:	45 31 ff             	xor    %r15d,%r15d
    40f4:	48 8d 9d e0 fe ff ff 	lea    -0x120(%rbp),%rbx
    40fb:	4c 8d b5 d0 fd ff ff 	lea    -0x230(%rbp),%r14
    4102:	eb 14                	jmp    4118 <fwp_main_thread+0x9b8>
    4104:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    410b:	00 00 00 00 00 
    4110:	49 ff c7             	inc    %r15
    4113:	4d 39 f8             	cmp    %r15,%r8
    4116:	74 3c                	je     4154 <fwp_main_thread+0x9f4>
    4118:	43 0f b6 04 3c       	movzbl (%r12,%r15,1),%eax
    411d:	83 f8 2d             	cmp    $0x2d,%eax
    4120:	74 ee                	je     4110 <fwp_main_thread+0x9b0>
    4122:	83 f8 5f             	cmp    $0x5f,%eax
    4125:	74 e9                	je     4110 <fwp_main_thread+0x9b0>
    4127:	8d 48 bf             	lea    -0x41(%rax),%ecx
    412a:	0f b6 d0             	movzbl %al,%edx
    412d:	0c 20                	or     $0x20,%al
    412f:	80 f9 1a             	cmp    $0x1a,%cl
    4132:	0f b6 c0             	movzbl %al,%eax
    4135:	0f 43 c2             	cmovae %edx,%eax
    4138:	88 85 d0 fd ff ff    	mov    %al,-0x230(%rbp)
    413e:	ba 01 00 00 00       	mov    $0x1,%edx
    4143:	48 89 df             	mov    %rbx,%rdi
    4146:	4c 89 f6             	mov    %r14,%rsi
    4149:	e8 c2 90 00 00       	call   d210 <buf_put>
    414e:	4c 8b 45 d0          	mov    -0x30(%rbp),%r8
    4152:	eb bc                	jmp    4110 <fwp_main_thread+0x9b0>
    4154:	48 8b bd e0 fe ff ff 	mov    -0x120(%rbp),%rdi
    415b:	31 db                	xor    %ebx,%ebx
    415d:	83 3d 9c 7c 01 00 00 	cmpl   $0x0,0x17c9c(%rip)        # 1be00 <d3+0x10>
    4164:	0f 8e 1d 01 00 00    	jle    4287 <fwp_main_thread+0xb27>
    416a:	4c 8b b5 e8 fe ff ff 	mov    -0x118(%rbp),%r14
    4171:	4d 85 f6             	test   %r14,%r14
    4174:	41 bc ff ff ff ff    	mov    $0xffffffff,%r12d
    417a:	0f 84 0d 01 00 00    	je     428d <fwp_main_thread+0xb2d>
    4180:	48 89 bd 58 ff ff ff 	mov    %rdi,-0xa8(%rbp)
    4187:	4c 89 6d c0          	mov    %r13,-0x40(%rbp)
    418b:	45 31 ed             	xor    %r13d,%r13d
    418e:	4c 8d bd d0 fd ff ff 	lea    -0x230(%rbp),%r15
    4195:	4c 89 75 b0          	mov    %r14,-0x50(%rbp)
    4199:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    41a0:	48 8b 05 61 7c 01 00 	mov    0x17c61(%rip),%rax        # 1be08 <d3+0x18>
    41a7:	4a 8b 1c e8          	mov    (%rax,%r13,8),%rbx
    41ab:	48 89 df             	mov    %rbx,%rdi
    41ae:	e8 bd ef ff ff       	call   3170 <strlen@plt>
    41b3:	48 c7 85 68 ff ff ff 	movq   $0x0,-0x98(%rbp)
    41ba:	00 00 00 00 
    41be:	48 85 c0             	test   %rax,%rax
    41c1:	74 6d                	je     4230 <fwp_main_thread+0xad0>
    41c3:	49 89 c6             	mov    %rax,%r14
    41c6:	44 89 65 a8          	mov    %r12d,-0x58(%rbp)
    41ca:	45 31 e4             	xor    %r12d,%r12d
    41cd:	eb 09                	jmp    41d8 <fwp_main_thread+0xa78>
    41cf:	90                   	nop
    41d0:	49 ff c4             	inc    %r12
    41d3:	4d 39 e6             	cmp    %r12,%r14
    41d6:	74 48                	je     4220 <fwp_main_thread+0xac0>
    41d8:	42 0f b6 04 23       	movzbl (%rbx,%r12,1),%eax
    41dd:	83 f8 2d             	cmp    $0x2d,%eax
    41e0:	74 ee                	je     41d0 <fwp_main_thread+0xa70>
    41e2:	83 f8 5f             	cmp    $0x5f,%eax
    41e5:	74 e9                	je     41d0 <fwp_main_thread+0xa70>
    41e7:	8d 48 bf             	lea    -0x41(%rax),%ecx
    41ea:	0f b6 d0             	movzbl %al,%edx
    41ed:	0c 20                	or     $0x20,%al
    41ef:	80 f9 1a             	cmp    $0x1a,%cl
    41f2:	0f b6 c0             	movzbl %al,%eax
    41f5:	0f 43 c2             	cmovae %edx,%eax
    41f8:	88 85 d0 fd ff ff    	mov    %al,-0x230(%rbp)
    41fe:	ba 01 00 00 00       	mov    $0x1,%edx
    4203:	48 8d bd 60 ff ff ff 	lea    -0xa0(%rbp),%rdi
    420a:	4c 89 fe             	mov    %r15,%rsi
    420d:	e8 fe 8f 00 00       	call   d210 <buf_put>
    4212:	eb bc                	jmp    41d0 <fwp_main_thread+0xa70>
    4214:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    421b:	00 00 00 00 00 
    4220:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
    4227:	44 8b 65 a8          	mov    -0x58(%rbp),%r12d
    422b:	eb 05                	jmp    4232 <fwp_main_thread+0xad2>
    422d:	0f 1f 00             	nopl   (%rax)
    4230:	31 c0                	xor    %eax,%eax
    4232:	4c 8b 75 b0          	mov    -0x50(%rbp),%r14
    4236:	4c 39 f0             	cmp    %r14,%rax
    4239:	75 1c                	jne    4257 <fwp_main_thread+0xaf7>
    423b:	48 8b bd 60 ff ff ff 	mov    -0xa0(%rbp),%rdi
    4242:	48 8b b5 58 ff ff ff 	mov    -0xa8(%rbp),%rsi
    4249:	4c 89 f2             	mov    %r14,%rdx
    424c:	e8 1f f1 ff ff       	call   3370 <bcmp@plt>
    4251:	85 c0                	test   %eax,%eax
    4253:	45 0f 44 e5          	cmove  %r13d,%r12d
    4257:	49 ff c5             	inc    %r13
    425a:	48 63 05 9f 7b 01 00 	movslq 0x17b9f(%rip),%rax        # 1be00 <d3+0x10>
    4261:	49 39 c5             	cmp    %rax,%r13
    4264:	7d 09                	jge    426f <fwp_main_thread+0xb0f>
    4266:	45 85 e4             	test   %r12d,%r12d
    4269:	0f 88 31 ff ff ff    	js     41a0 <fwp_main_thread+0xa40>
    426f:	48 8b 9d 60 ff ff ff 	mov    -0xa0(%rbp),%rbx
    4276:	4c 8b 6d c0          	mov    -0x40(%rbp),%r13
    427a:	48 8b bd 58 ff ff ff 	mov    -0xa8(%rbp),%rdi
    4281:	eb 0a                	jmp    428d <fwp_main_thread+0xb2d>
    4283:	31 ff                	xor    %edi,%edi
    4285:	31 db                	xor    %ebx,%ebx
    4287:	41 bc ff ff ff ff    	mov    $0xffffffff,%r12d
    428d:	e8 be ed ff ff       	call   3050 <free@plt>
    4292:	48 89 df             	mov    %rbx,%rdi
    4295:	e8 b6 ed ff ff       	call   3050 <free@plt>
    429a:	45 85 e4             	test   %r12d,%r12d
    429d:	0f 88 d9 0e 00 00    	js     517c <fwp_main_thread+0x1a1c>
    42a3:	44 89 e0             	mov    %r12d,%eax
    42a6:	49 89 45 00          	mov    %rax,0x0(%r13)
    42aa:	48 8d 3d 3f 22 01 00 	lea    0x1223f(%rip),%rdi        # 164f0 <exec_in_fp0+0xc80>
    42b1:	e8 7a ed ff ff       	call   3030 <getenv@plt>
    42b6:	48 85 c0             	test   %rax,%rax
    42b9:	74 27                	je     42e2 <fwp_main_thread+0xb82>
    42bb:	48 8d 35 36 22 01 00 	lea    0x12236(%rip),%rsi        # 164f8 <exec_in_fp0+0xc88>
    42c2:	48 89 c7             	mov    %rax,%rdi
    42c5:	e8 06 f0 ff ff       	call   32d0 <strcmp@plt>
    42ca:	31 c9                	xor    %ecx,%ecx
    42cc:	85 c0                	test   %eax,%eax
    42ce:	0f 94 c1             	sete   %cl
    42d1:	89 0d 29 7c 02 00    	mov    %ecx,0x27c29(%rip)        # 2bf00 <fwp_exec_binary_out>
    42d7:	75 29                	jne    4302 <fwp_main_thread+0xba2>
    42d9:	48 8b 05 f8 5c 01 00 	mov    0x15cf8(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    42e0:	eb 27                	jmp    4309 <fwp_main_thread+0xba9>
    42e2:	c7 05 14 7c 02 00 00 	movl   $0x0,0x27c14(%rip)        # 2bf00 <fwp_exec_binary_out>
    42e9:	00 00 00 
    42ec:	48 8b 05 bd 5c 01 00 	mov    0x15cbd(%rip),%rax        # 19fb0 <stdout@GLIBC_2.2.5>
    42f3:	48 8b 00             	mov    (%rax),%rax
    42f6:	48 89 05 7b 7b 01 00 	mov    %rax,0x17b7b(%rip)        # 1be78 <fwp_prog_out>
    42fd:	8b 4d c8             	mov    -0x38(%rbp),%ecx
    4300:	eb 1a                	jmp    431c <fwp_main_thread+0xbbc>
    4302:	48 8b 05 a7 5c 01 00 	mov    0x15ca7(%rip),%rax        # 19fb0 <stdout@GLIBC_2.2.5>
    4309:	8b 4d c8             	mov    -0x38(%rbp),%ecx
    430c:	48 8b 00             	mov    (%rax),%rax
    430f:	48 89 05 62 7b 01 00 	mov    %rax,0x17b62(%rip)        # 1be78 <fwp_prog_out>
    4316:	0f 84 ce 00 00 00    	je     43ea <fwp_main_thread+0xc8a>
    431c:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%rbp)
    4323:	85 c9                	test   %ecx,%ecx
    4325:	7e 3b                	jle    4362 <fwp_main_thread+0xc02>
    4327:	48 8d 75 bc          	lea    -0x44(%rbp),%rsi
    432b:	4c 89 ef             	mov    %r13,%rdi
    432e:	e8 ed 77 00 00       	call   bb20 <fwp_exec_call>
    4333:	48 89 c3             	mov    %rax,%rbx
    4336:	48 8b 3d 3b 7b 01 00 	mov    0x17b3b(%rip),%rdi        # 1be78 <fwp_prog_out>
    433d:	e8 0e f0 ff ff       	call   3350 <fflush@plt>
    4342:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    4348:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
    434c:	0f 85 69 09 00 00    	jne    4cbb <fwp_main_thread+0x155b>
    4352:	48 89 df             	mov    %rbx,%rdi
    4355:	e8 06 7a 00 00       	call   bd60 <fwp_emit_result>
    435a:	45 31 e4             	xor    %r12d,%r12d
    435d:	e9 59 09 00 00       	jmp    4cbb <fwp_main_thread+0x155b>
    4362:	48 8b 1d 4f 5c 01 00 	mov    0x15c4f(%rip),%rbx        # 19fb8 <stdin@GLIBC_2.2.5>
    4369:	48 8b 3b             	mov    (%rbx),%rdi
    436c:	b9 00 00 10 00       	mov    $0x100000,%ecx
    4371:	31 f6                	xor    %esi,%esi
    4373:	31 d2                	xor    %edx,%edx
    4375:	e8 36 f0 ff ff       	call   33b0 <setvbuf@plt>
    437a:	48 8b 0b             	mov    (%rbx),%rcx
    437d:	48 8d 3d 80 7b 02 00 	lea    0x27b80(%rip),%rdi        # 2bf04 <fwp_in_pend>
    4384:	be 01 00 00 00       	mov    $0x1,%esi
    4389:	ba 04 00 00 00       	mov    $0x4,%edx
    438e:	e8 5d ed ff ff       	call   30f0 <fread@plt>
    4393:	89 05 6f 7b 02 00    	mov    %eax,0x27b6f(%rip)        # 2bf08 <fwp_in_npend>
    4399:	c7 05 69 7b 02 00 00 	movl   $0x0,0x27b69(%rip)        # 2bf0c <fwp_in_ppos>
    43a0:	00 00 00 
    43a3:	b1 01                	mov    $0x1,%cl
    43a5:	89 4d c8             	mov    %ecx,-0x38(%rbp)
    43a8:	83 f8 04             	cmp    $0x4,%eax
    43ab:	4c 89 6d c0          	mov    %r13,-0x40(%rbp)
    43af:	75 10                	jne    43c1 <fwp_main_thread+0xc61>
    43b1:	81 3d 49 7b 02 00 46 	cmpl   $0x31505746,0x27b49(%rip)        # 2bf04 <fwp_in_pend>
    43b8:	57 50 31 
    43bb:	0f 84 16 0a 00 00    	je     4dd7 <fwp_main_thread+0x1677>
    43c1:	66 0f ef c0          	pxor   %xmm0,%xmm0
    43c5:	66 0f 7f 45 80       	movdqa %xmm0,-0x80(%rbp)
    43ca:	48 c7 45 90 00 00 00 	movq   $0x0,-0x70(%rbp)
    43d1:	00 
    43d2:	49 bc 00 26 00 00 01 	movabs $0x100002600,%r12
    43d9:	00 00 00 
    43dc:	45 31 ed             	xor    %r13d,%r13d
    43df:	31 c0                	xor    %eax,%eax
    43e1:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    43e5:	e9 0f 02 00 00       	jmp    45f9 <fwp_main_thread+0xe99>
    43ea:	48 8d b5 d0 fd ff ff 	lea    -0x230(%rbp),%rsi
    43f1:	bf 01 00 00 00       	mov    $0x1,%edi
    43f6:	e8 c5 f0 ff ff       	call   34c0 <fstat@plt>
    43fb:	85 c0                	test   %eax,%eax
    43fd:	0f 85 10 01 00 00    	jne    4513 <fwp_main_thread+0xdb3>
    4403:	b8 00 f0 00 00       	mov    $0xf000,%eax
    4408:	23 85 e8 fd ff ff    	and    -0x218(%rbp),%eax
    440e:	3d 00 10 00 00       	cmp    $0x1000,%eax
    4413:	0f 85 fa 00 00 00    	jne    4513 <fwp_main_thread+0xdb3>
    4419:	bf 01 00 00 00       	mov    $0x1,%edi
    441e:	be 07 04 00 00       	mov    $0x407,%esi
    4423:	ba 00 00 10 00       	mov    $0x100000,%edx
    4428:	31 c0                	xor    %eax,%eax
    442a:	e8 f1 ec ff ff       	call   3120 <fcntl@plt>
    442f:	48 8d 3d d9 22 01 00 	lea    0x122d9(%rip),%rdi        # 1670f <exec_in_fp0+0xe9f>
    4436:	e8 f5 eb ff ff       	call   3030 <getenv@plt>
    443b:	48 85 c0             	test   %rax,%rax
    443e:	74 17                	je     4457 <fwp_main_thread+0xcf7>
    4440:	48 8d 35 d6 22 01 00 	lea    0x122d6(%rip),%rsi        # 1671d <exec_in_fp0+0xead>
    4447:	48 89 c7             	mov    %rax,%rdi
    444a:	e8 81 ee ff ff       	call   32d0 <strcmp@plt>
    444f:	85 c0                	test   %eax,%eax
    4451:	0f 84 bc 00 00 00    	je     4513 <fwp_main_thread+0xdb3>
    4457:	bf 01 00 00 00       	mov    $0x1,%edi
    445c:	be 01 08 08 00       	mov    $0x80801,%esi
    4461:	31 d2                	xor    %edx,%edx
    4463:	e8 88 f0 ff ff       	call   34f0 <socket@plt>
    4468:	85 c0                	test   %eax,%eax
    446a:	0f 88 a3 00 00 00    	js     4513 <fwp_main_thread+0xdb3>
    4470:	41 89 c6             	mov    %eax,%r14d
    4473:	66 0f ef c0          	pxor   %xmm0,%xmm0
    4477:	f3 0f 7f 85 3e ff ff 	movdqu %xmm0,-0xc2(%rbp)
    447e:	ff 
    447f:	f3 0f 7f 85 32 ff ff 	movdqu %xmm0,-0xce(%rbp)
    4486:	ff 
    4487:	f3 0f 7f 85 22 ff ff 	movdqu %xmm0,-0xde(%rbp)
    448e:	ff 
    448f:	f3 0f 7f 85 12 ff ff 	movdqu %xmm0,-0xee(%rbp)
    4496:	ff 
    4497:	f3 0f 7f 85 02 ff ff 	movdqu %xmm0,-0xfe(%rbp)
    449e:	ff 
    449f:	f3 0f 7f 85 f2 fe ff 	movdqu %xmm0,-0x10e(%rbp)
    44a6:	ff 
    44a7:	f3 0f 7f 85 e2 fe ff 	movdqu %xmm0,-0x11e(%rbp)
    44ae:	ff 
    44af:	66 c7 85 e0 fe ff ff 	movw   $0x1,-0x120(%rbp)
    44b6:	01 00 
    44b8:	48 8d bd e3 fe ff ff 	lea    -0x11d(%rbp),%rdi
    44bf:	48 8b 8d d0 fd ff ff 	mov    -0x230(%rbp),%rcx
    44c6:	4c 8b 85 d8 fd ff ff 	mov    -0x228(%rbp),%r8
    44cd:	48 8d 15 4f 22 01 00 	lea    0x1224f(%rip),%rdx        # 16723 <exec_in_fp0+0xeb3>
    44d4:	be 6b 00 00 00       	mov    $0x6b,%esi
    44d9:	31 c0                	xor    %eax,%eax
    44db:	e8 f0 ec ff ff       	call   31d0 <snprintf@plt>
    44e0:	8d 50 03             	lea    0x3(%rax),%edx
    44e3:	48 8d b5 e0 fe ff ff 	lea    -0x120(%rbp),%rsi
    44ea:	44 89 f7             	mov    %r14d,%edi
    44ed:	e8 de ee ff ff       	call   33d0 <bind@plt>
    44f2:	85 c0                	test   %eax,%eax
    44f4:	75 15                	jne    450b <fwp_main_thread+0xdab>
    44f6:	44 89 f7             	mov    %r14d,%edi
    44f9:	be 01 00 00 00       	mov    $0x1,%esi
    44fe:	e8 5d ee ff ff       	call   3360 <listen@plt>
    4503:	85 c0                	test   %eax,%eax
    4505:	0f 84 b3 0d 00 00    	je     52be <fwp_main_thread+0x1b5e>
    450b:	44 89 f7             	mov    %r14d,%edi
    450e:	e8 1d ed ff ff       	call   3230 <close@plt>
    4513:	48 8d 3d 26 13 01 00 	lea    0x11326(%rip),%rdi        # 15840 <exec_out_header0>
    451a:	be 30 00 00 00       	mov    $0x30,%esi
    451f:	e8 dc 70 00 00       	call   b600 <fwp_pipe_write>
    4524:	e8 37 75 00 00       	call   ba60 <fwp_pipe_flush>
    4529:	48 8d 3d 19 22 01 00 	lea    0x12219(%rip),%rdi        # 16749 <exec_in_fp0+0xed9>
    4530:	e8 fb ea ff ff       	call   3030 <getenv@plt>
    4535:	48 85 c0             	test   %rax,%rax
    4538:	8b 4d c8             	mov    -0x38(%rbp),%ecx
    453b:	0f 84 db fd ff ff    	je     431c <fwp_main_thread+0xbbc>
    4541:	83 3d 98 78 01 00 00 	cmpl   $0x0,0x17898(%rip)        # 1bde0 <fwp_po_listen>
    4548:	0f 88 ce fd ff ff    	js     431c <fwp_main_thread+0xbbc>
    454e:	80 38 00             	cmpb   $0x0,(%rax)
    4551:	0f 84 c5 fd ff ff    	je     431c <fwp_main_thread+0xbbc>
    4557:	48 89 c7             	mov    %rax,%rdi
    455a:	31 f6                	xor    %esi,%esi
    455c:	ba 0a 00 00 00       	mov    $0xa,%edx
    4561:	e8 ba ed ff ff       	call   3320 <strtol@plt>
    4566:	8b 0d 74 78 01 00    	mov    0x17874(%rip),%ecx        # 1bde0 <fwp_po_listen>
    456c:	89 8d d0 fd ff ff    	mov    %ecx,-0x230(%rbp)
    4572:	48 b9 01 00 00 00 01 	movabs $0x100000001,%rcx
    4579:	00 00 00 
    457c:	48 89 8d d4 fd ff ff 	mov    %rcx,-0x22c(%rbp)
    4583:	c7 85 dc fd ff ff 00 	movl   $0x0,-0x224(%rbp)
    458a:	00 00 00 
    458d:	48 85 c0             	test   %rax,%rax
    4590:	0f 8e 67 fd ff ff    	jle    42fd <fwp_main_thread+0xb9d>
    4596:	48 3d ff ff ff 7f    	cmp    $0x7fffffff,%rax
    459c:	ba ff ff ff 7f       	mov    $0x7fffffff,%edx
    45a1:	48 0f 4c d0          	cmovl  %rax,%rdx
    45a5:	48 8d bd d0 fd ff ff 	lea    -0x230(%rbp),%rdi
    45ac:	be 02 00 00 00       	mov    $0x2,%esi
    45b1:	e8 0a ee ff ff       	call   33c0 <poll@plt>
    45b6:	85 c0                	test   %eax,%eax
    45b8:	0f 8e 3f fd ff ff    	jle    42fd <fwp_main_thread+0xb9d>
    45be:	f6 85 d6 fd ff ff 01 	testb  $0x1,-0x22a(%rbp)
    45c5:	0f 84 32 fd ff ff    	je     42fd <fwp_main_thread+0xb9d>
    45cb:	48 c7 05 6a 79 03 00 	movq   $0x0,0x3796a(%rip)        # 3bf40 <fwp_po_next_check>
    45d2:	00 00 00 00 
    45d6:	e8 e5 c4 00 00       	call   10ac0 <fwp_pipe_poll>
    45db:	e9 1d fd ff ff       	jmp    42fd <fwp_main_thread+0xb9d>
    45e0:	bb 10 00 00 00       	mov    $0x10,%ebx
    45e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    45ec:	00 00 00 00 
    45f0:	83 fb 0f             	cmp    $0xf,%ebx
    45f3:	0f 84 b5 06 00 00    	je     4cae <fwp_main_thread+0x154e>
    45f9:	80 7d c8 00          	cmpb   $0x0,-0x38(%rbp)
    45fd:	74 41                	je     4640 <fwp_main_thread+0xee0>
    45ff:	48 c7 45 88 00 00 00 	movq   $0x0,-0x78(%rbp)
    4606:	00 
    4607:	48 63 05 fe 78 02 00 	movslq 0x278fe(%rip),%rax        # 2bf0c <fwp_in_ppos>
    460e:	3b 05 f4 78 02 00    	cmp    0x278f4(%rip),%eax        # 2bf08 <fwp_in_npend>
    4614:	0f 8d d6 00 00 00    	jge    46f0 <fwp_main_thread+0xf90>
    461a:	8d 48 01             	lea    0x1(%rax),%ecx
    461d:	89 0d e9 78 02 00    	mov    %ecx,0x278e9(%rip)        # 2bf0c <fwp_in_ppos>
    4623:	48 8d 0d da 78 02 00 	lea    0x278da(%rip),%rcx        # 2bf04 <fwp_in_pend>
    462a:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax
    462e:	83 f8 0a             	cmp    $0xa,%eax
    4631:	0f 85 d1 00 00 00    	jne    4708 <fwp_main_thread+0xfa8>
    4637:	e9 84 01 00 00       	jmp    47c0 <fwp_main_thread+0x1060>
    463c:	0f 1f 40 00          	nopl   0x0(%rax)
    4640:	be 01 00 00 00       	mov    $0x1,%esi
    4645:	48 8d 7d a2          	lea    -0x5e(%rbp),%rdi
    4649:	e8 42 78 00 00       	call   be90 <fwp_read_exact>
    464e:	bb 0f 00 00 00       	mov    $0xf,%ebx
    4653:	85 c0                	test   %eax,%eax
    4655:	74 99                	je     45f0 <fwp_main_thread+0xe90>
    4657:	be 04 00 00 00       	mov    $0x4,%esi
    465c:	48 8d 7d a3          	lea    -0x5d(%rbp),%rdi
    4660:	e8 2b 78 00 00       	call   be90 <fwp_read_exact>
    4665:	85 c0                	test   %eax,%eax
    4667:	0f 84 f0 05 00 00    	je     4c5d <fwp_main_thread+0x14fd>
    466d:	44 8b 7d a3          	mov    -0x5d(%rbp),%r15d
    4671:	49 8d 57 01          	lea    0x1(%r15),%rdx
    4675:	48 ff 05 2c 78 01 00 	incq   0x1782c(%rip)        # 1bea8 <measured_calls>
    467c:	48 01 15 2d 78 01 00 	add    %rdx,0x1782d(%rip)        # 1beb0 <measured_bytes>
    4683:	49 81 ff ff 3f 00 00 	cmp    $0x3fff,%r15
    468a:	48 8d 3d f7 5b 01 00 	lea    0x15bf7(%rip),%rdi        # 1a288 <fwp_gc>
    4691:	0f 87 25 02 00 00    	ja     48bc <fwp_main_thread+0x115c>
    4697:	49 8d 47 10          	lea    0x10(%r15),%rax
    469b:	48 c1 e8 04          	shr    $0x4,%rax
    469f:	0f b6 8c 38 e8 0b 00 	movzbl 0xbe8(%rax,%rdi,1),%ecx
    46a6:	00 
    46a7:	8b 84 8f 48 0b 00 00 	mov    0xb48(%rdi,%rcx,4),%eax
    46ae:	48 29 05 d3 5b 01 00 	sub    %rax,0x15bd3(%rip)        # 1a288 <fwp_gc>
    46b5:	0f 88 01 02 00 00    	js     48bc <fwp_main_thread+0x115c>
    46bb:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    46bf:	48 8d 34 cf          	lea    (%rdi,%rcx,8),%rsi
    46c3:	48 81 c6 c8 03 00 00 	add    $0x3c8,%rsi
    46ca:	4c 8b 36             	mov    (%rsi),%r14
    46cd:	4d 85 f6             	test   %r14,%r14
    46d0:	0f 84 ce 01 00 00    	je     48a4 <fwp_main_thread+0x1144>
    46d6:	49 8b 06             	mov    (%r14),%rax
    46d9:	48 f7 d0             	not    %rax
    46dc:	48 89 06             	mov    %rax,(%rsi)
    46df:	e9 00 02 00 00       	jmp    48e4 <fwp_main_thread+0x1184>
    46e4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    46eb:	00 00 00 00 00 
    46f0:	48 8b 05 c1 58 01 00 	mov    0x158c1(%rip),%rax        # 19fb8 <stdin@GLIBC_2.2.5>
    46f7:	48 8b 38             	mov    (%rax),%rdi
    46fa:	e8 21 eb ff ff       	call   3220 <fgetc@plt>
    46ff:	83 f8 0a             	cmp    $0xa,%eax
    4702:	0f 84 b8 00 00 00    	je     47c0 <fwp_main_thread+0x1060>
    4708:	83 f8 ff             	cmp    $0xffffffff,%eax
    470b:	0f 84 9d 05 00 00    	je     4cae <fwp_main_thread+0x154e>
    4711:	88 85 d0 fd ff ff    	mov    %al,-0x230(%rbp)
    4717:	ba 01 00 00 00       	mov    $0x1,%edx
    471c:	4c 8d 6d 80          	lea    -0x80(%rbp),%r13
    4720:	4c 89 ef             	mov    %r13,%rdi
    4723:	4c 8d bd d0 fd ff ff 	lea    -0x230(%rbp),%r15
    472a:	4c 89 fe             	mov    %r15,%rsi
    472d:	e8 de 8a 00 00       	call   d210 <buf_put>
    4732:	48 8b 1d 7f 58 01 00 	mov    0x1587f(%rip),%rbx        # 19fb8 <stdin@GLIBC_2.2.5>
    4739:	4c 8d 35 c4 77 02 00 	lea    0x277c4(%rip),%r14        # 2bf04 <fwp_in_pend>
    4740:	48 63 05 c5 77 02 00 	movslq 0x277c5(%rip),%rax        # 2bf0c <fwp_in_ppos>
    4747:	3b 05 bb 77 02 00    	cmp    0x277bb(%rip),%eax        # 2bf08 <fwp_in_npend>
    474d:	7d 21                	jge    4770 <fwp_main_thread+0x1010>
    474f:	8d 48 01             	lea    0x1(%rax),%ecx
    4752:	89 0d b4 77 02 00    	mov    %ecx,0x277b4(%rip)        # 2bf0c <fwp_in_ppos>
    4758:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax
    475d:	83 f8 ff             	cmp    $0xffffffff,%eax
    4760:	75 1f                	jne    4781 <fwp_main_thread+0x1021>
    4762:	e9 27 01 00 00       	jmp    488e <fwp_main_thread+0x112e>
    4767:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    476e:	00 00 
    4770:	48 8b 3b             	mov    (%rbx),%rdi
    4773:	e8 a8 ea ff ff       	call   3220 <fgetc@plt>
    4778:	83 f8 ff             	cmp    $0xffffffff,%eax
    477b:	0f 84 0d 01 00 00    	je     488e <fwp_main_thread+0x112e>
    4781:	83 f8 0a             	cmp    $0xa,%eax
    4784:	74 18                	je     479e <fwp_main_thread+0x103e>
    4786:	88 85 d0 fd ff ff    	mov    %al,-0x230(%rbp)
    478c:	ba 01 00 00 00       	mov    $0x1,%edx
    4791:	4c 89 ef             	mov    %r13,%rdi
    4794:	4c 89 fe             	mov    %r15,%rsi
    4797:	e8 74 8a 00 00       	call   d210 <buf_put>
    479c:	eb a2                	jmp    4740 <fwp_main_thread+0xfe0>
    479e:	4c 8b 6d 80          	mov    -0x80(%rbp),%r13
    47a2:	48 8b 75 88          	mov    -0x78(%rbp),%rsi
    47a6:	48 85 f6             	test   %rsi,%rsi
    47a9:	74 15                	je     47c0 <fwp_main_thread+0x1060>
    47ab:	41 80 7c 35 ff 0d    	cmpb   $0xd,-0x1(%r13,%rsi,1)
    47b1:	75 14                	jne    47c7 <fwp_main_thread+0x1067>
    47b3:	48 ff ce             	dec    %rsi
    47b6:	48 89 75 88          	mov    %rsi,-0x78(%rbp)
    47ba:	eb 0b                	jmp    47c7 <fwp_main_thread+0x1067>
    47bc:	0f 1f 40 00          	nopl   0x0(%rax)
    47c0:	31 f6                	xor    %esi,%esi
    47c2:	4d 85 ed             	test   %r13,%r13
    47c5:	74 0e                	je     47d5 <fwp_main_thread+0x1075>
    47c7:	41 c6 44 35 00 00    	movb   $0x0,0x0(%r13,%rsi,1)
    47cd:	4c 8b 6d 80          	mov    -0x80(%rbp),%r13
    47d1:	48 8b 75 88          	mov    -0x78(%rbp),%rsi
    47d5:	4d 85 ed             	test   %r13,%r13
    47d8:	4c 89 ef             	mov    %r13,%rdi
    47db:	48 8d 05 f3 19 01 00 	lea    0x119f3(%rip),%rax        # 161d5 <exec_in_fp0+0x965>
    47e2:	48 0f 44 f8          	cmove  %rax,%rdi
    47e6:	e8 85 69 00 00       	call   b170 <fwp_str_lossy>
    47eb:	49 89 c7             	mov    %rax,%r15
    47ee:	4c 8d 70 08          	lea    0x8(%rax),%r14
    47f2:	48 8b 00             	mov    (%rax),%rax
    47f5:	4c 89 b5 d0 fd ff ff 	mov    %r14,-0x230(%rbp)
    47fc:	48 89 85 d8 fd ff ff 	mov    %rax,-0x228(%rbp)
    4803:	48 c7 85 e0 fd ff ff 	movq   $0x0,-0x220(%rbp)
    480a:	00 00 00 00 
    480e:	48 8d bd d0 fd ff ff 	lea    -0x230(%rbp),%rdi
    4815:	48 8d 35 d4 75 01 00 	lea    0x175d4(%rip),%rsi        # 1bdf0 <d3>
    481c:	ba 01 00 00 00       	mov    $0x1,%edx
    4821:	48 8d 8d 50 ff ff ff 	lea    -0xb0(%rbp),%rcx
    4828:	e8 23 8f 00 00       	call   d750 <tp_value>
    482d:	85 c0                	test   %eax,%eax
    482f:	0f 84 11 09 00 00    	je     5146 <fwp_main_thread+0x19e6>
    4835:	48 8b 85 d8 fd ff ff 	mov    -0x228(%rbp),%rax
    483c:	48 8b 8d e0 fd ff ff 	mov    -0x220(%rbp),%rcx
    4843:	48 39 c1             	cmp    %rax,%rcx
    4846:	73 38                	jae    4880 <fwp_main_thread+0x1120>
    4848:	48 8b 95 d0 fd ff ff 	mov    -0x230(%rbp),%rdx
    484f:	90                   	nop
    4850:	0f b6 34 0a          	movzbl (%rdx,%rcx,1),%esi
    4854:	48 83 fe 20          	cmp    $0x20,%rsi
    4858:	77 26                	ja     4880 <fwp_main_thread+0x1120>
    485a:	49 0f a3 f4          	bt     %rsi,%r12
    485e:	73 20                	jae    4880 <fwp_main_thread+0x1120>
    4860:	48 ff c1             	inc    %rcx
    4863:	48 89 8d e0 fd ff ff 	mov    %rcx,-0x220(%rbp)
    486a:	48 39 c8             	cmp    %rcx,%rax
    486d:	75 e1                	jne    4850 <fwp_main_thread+0x10f0>
    486f:	e9 8c 01 00 00       	jmp    4a00 <fwp_main_thread+0x12a0>
    4874:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    487b:	00 00 00 00 00 
    4880:	48 39 c1             	cmp    %rax,%rcx
    4883:	0f 84 77 01 00 00    	je     4a00 <fwp_main_thread+0x12a0>
    4889:	e9 b8 08 00 00       	jmp    5146 <fwp_main_thread+0x19e6>
    488e:	4c 8b 6d 80          	mov    -0x80(%rbp),%r13
    4892:	48 8b 75 88          	mov    -0x78(%rbp),%rsi
    4896:	4d 85 ed             	test   %r13,%r13
    4899:	0f 85 28 ff ff ff    	jne    47c7 <fwp_main_thread+0x1067>
    489f:	e9 31 ff ff ff       	jmp    47d5 <fwp_main_thread+0x1075>
    48a4:	4c 8b b4 cf d0 03 00 	mov    0x3d0(%rdi,%rcx,8),%r14
    48ab:	00 
    48ac:	48 8b b4 cf d8 03 00 	mov    0x3d8(%rdi,%rcx,8),%rsi
    48b3:	00 
    48b4:	4c 29 f6             	sub    %r14,%rsi
    48b7:	48 39 c6             	cmp    %rax,%rsi
    48ba:	73 17                	jae    48d3 <fwp_main_thread+0x1173>
    48bc:	48 89 d7             	mov    %rdx,%rdi
    48bf:	be 01 00 00 00       	mov    $0x1,%esi
    48c4:	e8 f7 39 00 00       	call   82c0 <fwp_gc_alloc_slow>
    48c9:	49 89 c6             	mov    %rax,%r14
    48cc:	4d 85 ff             	test   %r15,%r15
    48cf:	75 22                	jne    48f3 <fwp_main_thread+0x1193>
    48d1:	eb 33                	jmp    4906 <fwp_main_thread+0x11a6>
    48d3:	48 8d 0c cf          	lea    (%rdi,%rcx,8),%rcx
    48d7:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
    48de:	4c 01 f0             	add    %r14,%rax
    48e1:	48 89 01             	mov    %rax,(%rcx)
    48e4:	4c 89 f7             	mov    %r14,%rdi
    48e7:	31 f6                	xor    %esi,%esi
    48e9:	e8 22 e9 ff ff       	call   3210 <memset@plt>
    48ee:	4d 85 ff             	test   %r15,%r15
    48f1:	74 13                	je     4906 <fwp_main_thread+0x11a6>
    48f3:	4c 89 f7             	mov    %r14,%rdi
    48f6:	4c 89 fe             	mov    %r15,%rsi
    48f9:	e8 92 75 00 00       	call   be90 <fwp_read_exact>
    48fe:	85 c0                	test   %eax,%eax
    4900:	0f 84 57 03 00 00    	je     4c5d <fwp_main_thread+0x14fd>
    4906:	0f b6 45 a2          	movzbl -0x5e(%rbp),%eax
    490a:	85 c0                	test   %eax,%eax
    490c:	0f 84 de fc ff ff    	je     45f0 <fwp_main_thread+0xe90>
    4912:	83 f8 02             	cmp    $0x2,%eax
    4915:	0f 85 a3 00 00 00    	jne    49be <fwp_main_thread+0x125e>
    491b:	41 83 ff 01          	cmp    $0x1,%r15d
    491f:	0f 85 53 03 00 00    	jne    4c78 <fwp_main_thread+0x1518>
    4925:	8b 3d c1 74 01 00    	mov    0x174c1(%rip),%edi        # 1bdec <fwp_pi_sock>
    492b:	85 ff                	test   %edi,%edi
    492d:	0f 88 45 03 00 00    	js     4c78 <fwp_main_thread+0x1518>
    4933:	83 3d 1a 76 03 00 00 	cmpl   $0x0,0x3761a(%rip)        # 3bf54 <fwp_pi_kind>
    493a:	0f 85 38 03 00 00    	jne    4c78 <fwp_main_thread+0x1518>
    4940:	41 0f b6 06          	movzbl (%r14),%eax
    4944:	83 f8 02             	cmp    $0x2,%eax
    4947:	0f 84 f7 00 00 00    	je     4a44 <fwp_main_thread+0x12e4>
    494d:	83 f8 01             	cmp    $0x1,%eax
    4950:	0f 85 22 03 00 00    	jne    4c78 <fwp_main_thread+0x1518>
    4956:	c7 05 f4 75 03 00 01 	movl   $0x1,0x375f4(%rip)        # 3bf54 <fwp_pi_kind>
    495d:	00 00 00 
    4960:	48 8d 3d 86 1e 01 00 	lea    0x11e86(%rip),%rdi        # 167ed <exec_in_fp0+0xf7d>
    4967:	e8 c4 e6 ff ff       	call   3030 <getenv@plt>
    496c:	bb 10 00 00 00       	mov    $0x10,%ebx
    4971:	48 85 c0             	test   %rax,%rax
    4974:	0f 84 76 fc ff ff    	je     45f0 <fwp_main_thread+0xe90>
    497a:	80 38 00             	cmpb   $0x0,(%rax)
    497d:	0f 84 6d fc ff ff    	je     45f0 <fwp_main_thread+0xe90>
    4983:	48 89 c7             	mov    %rax,%rdi
    4986:	48 8d 35 33 1e 01 00 	lea    0x11e33(%rip),%rsi        # 167c0 <exec_in_fp0+0xf50>
    498d:	e8 3e e9 ff ff       	call   32d0 <strcmp@plt>
    4992:	85 c0                	test   %eax,%eax
    4994:	0f 84 56 fc ff ff    	je     45f0 <fwp_main_thread+0xe90>
    499a:	48 8b 05 37 56 01 00 	mov    0x15637(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    49a1:	48 8b 38             	mov    (%rax),%rdi
    49a4:	48 8d 35 57 1e 01 00 	lea    0x11e57(%rip),%rsi        # 16802 <exec_in_fp0+0xf92>
    49ab:	48 8d 15 4f 1b 01 00 	lea    0x11b4f(%rip),%rdx        # 16501 <exec_in_fp0+0xc91>
    49b2:	31 c0                	xor    %eax,%eax
    49b4:	e8 37 e9 ff ff       	call   32f0 <fprintf@plt>
    49b9:	e9 32 fc ff ff       	jmp    45f0 <fwp_main_thread+0xe90>
    49be:	4c 89 b5 d0 fd ff ff 	mov    %r14,-0x230(%rbp)
    49c5:	4c 89 bd d8 fd ff ff 	mov    %r15,-0x228(%rbp)
    49cc:	48 c7 85 e0 fd ff ff 	movq   $0x0,-0x220(%rbp)
    49d3:	00 00 00 00 
    49d7:	48 8d bd d0 fd ff ff 	lea    -0x230(%rbp),%rdi
    49de:	48 8d 35 0b 74 01 00 	lea    0x1740b(%rip),%rsi        # 1bdf0 <d3>
    49e5:	48 8d 95 50 ff ff ff 	lea    -0xb0(%rbp),%rdx
    49ec:	e8 9f 7b 00 00       	call   c590 <fwp_decode>
    49f1:	85 c0                	test   %eax,%eax
    49f3:	0f 84 9c 09 00 00    	je     5395 <fwp_main_thread+0x1c35>
    49f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    4a00:	48 8b 85 50 ff ff ff 	mov    -0xb0(%rbp),%rax
    4a07:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
    4a0b:	48 89 07             	mov    %rax,(%rdi)
    4a0e:	48 8d 75 bc          	lea    -0x44(%rbp),%rsi
    4a12:	e8 09 71 00 00       	call   bb20 <fwp_exec_call>
    4a17:	48 89 c3             	mov    %rax,%rbx
    4a1a:	48 8b 3d 57 74 01 00 	mov    0x17457(%rip),%rdi        # 1be78 <fwp_prog_out>
    4a21:	e8 2a e9 ff ff       	call   3350 <fflush@plt>
    4a26:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
    4a2a:	0f 85 75 02 00 00    	jne    4ca5 <fwp_main_thread+0x1545>
    4a30:	48 89 df             	mov    %rbx,%rdi
    4a33:	e8 28 73 00 00       	call   bd60 <fwp_emit_result>
    4a38:	e8 23 70 00 00       	call   ba60 <fwp_pipe_flush>
    4a3d:	31 db                	xor    %ebx,%ebx
    4a3f:	e9 ac fb ff ff       	jmp    45f0 <fwp_main_thread+0xe90>
    4a44:	48 8d 45 a7          	lea    -0x59(%rbp),%rax
    4a48:	48 89 85 c0 fd ff ff 	mov    %rax,-0x240(%rbp)
    4a4f:	48 c7 85 c8 fd ff ff 	movq   $0x1,-0x238(%rbp)
    4a56:	01 00 00 00 
    4a5a:	66 0f ef c0          	pxor   %xmm0,%xmm0
    4a5e:	66 0f 7f 85 f0 fe ff 	movdqa %xmm0,-0x110(%rbp)
    4a65:	ff 
    4a66:	66 0f 7f 85 00 ff ff 	movdqa %xmm0,-0x100(%rbp)
    4a6d:	ff 
    4a6e:	66 0f 7f 85 e0 fe ff 	movdqa %xmm0,-0x120(%rbp)
    4a75:	ff 
    4a76:	48 c7 85 10 ff ff ff 	movq   $0x0,-0xf0(%rbp)
    4a7d:	00 00 00 00 
    4a81:	48 8d 85 c0 fd ff ff 	lea    -0x240(%rbp),%rax
    4a88:	48 89 85 f0 fe ff ff 	mov    %rax,-0x110(%rbp)
    4a8f:	48 c7 85 f8 fe ff ff 	movq   $0x1,-0x108(%rbp)
    4a96:	01 00 00 00 
    4a9a:	48 8d 85 60 ff ff ff 	lea    -0xa0(%rbp),%rax
    4aa1:	48 89 85 00 ff ff ff 	mov    %rax,-0x100(%rbp)
    4aa8:	48 c7 85 08 ff ff ff 	movq   $0x18,-0xf8(%rbp)
    4aaf:	18 00 00 00 
    4ab3:	48 8d b5 e0 fe ff ff 	lea    -0x120(%rbp),%rsi
    4aba:	ba 00 00 00 40       	mov    $0x40000000,%edx
    4abf:	e8 dc e8 ff ff       	call   33a0 <recvmsg@plt>
    4ac4:	48 83 f8 01          	cmp    $0x1,%rax
    4ac8:	0f 85 aa 01 00 00    	jne    4c78 <fwp_main_thread+0x1518>
    4ace:	48 83 bd 08 ff ff ff 	cmpq   $0x10,-0xf8(%rbp)
    4ad5:	10 
    4ad6:	0f 82 9c 01 00 00    	jb     4c78 <fwp_main_thread+0x1518>
    4adc:	48 8b 85 00 ff ff ff 	mov    -0x100(%rbp),%rax
    4ae3:	48 85 c0             	test   %rax,%rax
    4ae6:	0f 84 8c 01 00 00    	je     4c78 <fwp_main_thread+0x1518>
    4aec:	83 78 0c 01          	cmpl   $0x1,0xc(%rax)
    4af0:	0f 85 82 01 00 00    	jne    4c78 <fwp_main_thread+0x1518>
    4af6:	44 8b 70 10          	mov    0x10(%rax),%r14d
    4afa:	44 89 f7             	mov    %r14d,%edi
    4afd:	48 8d b5 d0 fd ff ff 	lea    -0x230(%rbp),%rsi
    4b04:	e8 b7 e9 ff ff       	call   34c0 <fstat@plt>
    4b09:	85 c0                	test   %eax,%eax
    4b0b:	0f 85 5f 01 00 00    	jne    4c70 <fwp_main_thread+0x1510>
    4b11:	48 8b b5 00 fe ff ff 	mov    -0x200(%rbp),%rsi
    4b18:	48 81 fe 00 10 00 00 	cmp    $0x1000,%rsi
    4b1f:	0f 86 4b 01 00 00    	jbe    4c70 <fwp_main_thread+0x1510>
    4b25:	31 ff                	xor    %edi,%edi
    4b27:	48 89 75 a8          	mov    %rsi,-0x58(%rbp)
    4b2b:	ba 03 00 00 00       	mov    $0x3,%edx
    4b30:	b9 01 00 00 00       	mov    $0x1,%ecx
    4b35:	45 89 f0             	mov    %r14d,%r8d
    4b38:	45 31 c9             	xor    %r9d,%r9d
    4b3b:	e8 50 e6 ff ff       	call   3190 <mmap@plt>
    4b40:	49 89 c7             	mov    %rax,%r15
    4b43:	44 89 f7             	mov    %r14d,%edi
    4b46:	e8 e5 e6 ff ff       	call   3230 <close@plt>
    4b4b:	49 83 ff ff          	cmp    $0xffffffffffffffff,%r15
    4b4f:	0f 84 23 01 00 00    	je     4c78 <fwp_main_thread+0x1518>
    4b55:	41 81 3f 46 57 50 53 	cmpl   $0x53505746,(%r15)
    4b5c:	0f 85 16 01 00 00    	jne    4c78 <fwp_main_thread+0x1518>
    4b62:	41 83 7f 04 01       	cmpl   $0x1,0x4(%r15)
    4b67:	0f 85 0b 01 00 00    	jne    4c78 <fwp_main_thread+0x1518>
    4b6d:	49 8b 47 08          	mov    0x8(%r15),%rax
    4b71:	48 85 c0             	test   %rax,%rax
    4b74:	0f 84 fe 00 00 00    	je     4c78 <fwp_main_thread+0x1518>
    4b7a:	48 89 c1             	mov    %rax,%rcx
    4b7d:	48 d1 e9             	shr    $1,%rcx
    4b80:	48 ba 55 55 55 55 55 	movabs $0x5555555555555555,%rdx
    4b87:	55 55 55 
    4b8a:	48 21 d1             	and    %rdx,%rcx
    4b8d:	48 89 c2             	mov    %rax,%rdx
    4b90:	48 29 ca             	sub    %rcx,%rdx
    4b93:	48 89 d1             	mov    %rdx,%rcx
    4b96:	48 be 33 33 33 33 33 	movabs $0x3333333333333333,%rsi
    4b9d:	33 33 33 
    4ba0:	48 21 f1             	and    %rsi,%rcx
    4ba3:	48 c1 ea 02          	shr    $0x2,%rdx
    4ba7:	48 21 f2             	and    %rsi,%rdx
    4baa:	48 01 ca             	add    %rcx,%rdx
    4bad:	48 89 d1             	mov    %rdx,%rcx
    4bb0:	48 c1 e9 04          	shr    $0x4,%rcx
    4bb4:	48 01 d1             	add    %rdx,%rcx
    4bb7:	48 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%rdx
    4bbe:	0f 0f 0f 
    4bc1:	48 21 d1             	and    %rdx,%rcx
    4bc4:	48 ba 01 01 01 01 01 	movabs $0x101010101010101,%rdx
    4bcb:	01 01 01 
    4bce:	48 0f af ca          	imul   %rdx,%rcx
    4bd2:	48 c1 e9 38          	shr    $0x38,%rcx
    4bd6:	83 f9 01             	cmp    $0x1,%ecx
    4bd9:	0f 87 99 00 00 00    	ja     4c78 <fwp_main_thread+0x1518>
    4bdf:	48 8b 4d a8          	mov    -0x58(%rbp),%rcx
    4be3:	48 81 c1 00 f0 ff ff 	add    $0xfffffffffffff000,%rcx
    4bea:	48 39 c8             	cmp    %rcx,%rax
    4bed:	0f 87 85 00 00 00    	ja     4c78 <fwp_main_thread+0x1518>
    4bf3:	4c 89 3d 5e 73 03 00 	mov    %r15,0x3735e(%rip)        # 3bf58 <fwp_pi_ring>
    4bfa:	c7 05 50 73 03 00 02 	movl   $0x2,0x37350(%rip)        # 3bf54 <fwp_pi_kind>
    4c01:	00 00 00 
    4c04:	48 8d 3d e2 1b 01 00 	lea    0x11be2(%rip),%rdi        # 167ed <exec_in_fp0+0xf7d>
    4c0b:	e8 20 e4 ff ff       	call   3030 <getenv@plt>
    4c10:	48 85 c0             	test   %rax,%rax
    4c13:	0f 84 c7 f9 ff ff    	je     45e0 <fwp_main_thread+0xe80>
    4c19:	80 38 00             	cmpb   $0x0,(%rax)
    4c1c:	0f 84 be f9 ff ff    	je     45e0 <fwp_main_thread+0xe80>
    4c22:	48 89 c7             	mov    %rax,%rdi
    4c25:	48 8d 35 94 1b 01 00 	lea    0x11b94(%rip),%rsi        # 167c0 <exec_in_fp0+0xf50>
    4c2c:	e8 9f e6 ff ff       	call   32d0 <strcmp@plt>
    4c31:	85 c0                	test   %eax,%eax
    4c33:	0f 84 a7 f9 ff ff    	je     45e0 <fwp_main_thread+0xe80>
    4c39:	48 8b 05 98 53 01 00 	mov    0x15398(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    4c40:	48 8b 38             	mov    (%rax),%rdi
    4c43:	48 8d 35 b8 1b 01 00 	lea    0x11bb8(%rip),%rsi        # 16802 <exec_in_fp0+0xf92>
    4c4a:	48 8d 15 95 1b 01 00 	lea    0x11b95(%rip),%rdx        # 167e6 <exec_in_fp0+0xf76>
    4c51:	31 c0                	xor    %eax,%eax
    4c53:	e8 98 e6 ff ff       	call   32f0 <fprintf@plt>
    4c58:	e9 83 f9 ff ff       	jmp    45e0 <fwp_main_thread+0xe80>
    4c5d:	48 8b 05 74 53 01 00 	mov    0x15374(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    4c64:	48 8b 38             	mov    (%rax),%rdi
    4c67:	48 8d 35 f1 18 01 00 	lea    0x118f1(%rip),%rsi        # 1655f <exec_in_fp0+0xcef>
    4c6e:	eb 19                	jmp    4c89 <fwp_main_thread+0x1529>
    4c70:	44 89 f7             	mov    %r14d,%edi
    4c73:	e8 b8 e5 ff ff       	call   3230 <close@plt>
    4c78:	48 8b 05 59 53 01 00 	mov    0x15359(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    4c7f:	48 8b 38             	mov    (%rax),%rdi
    4c82:	48 8d 35 eb 18 01 00 	lea    0x118eb(%rip),%rsi        # 16574 <exec_in_fp0+0xd04>
    4c89:	48 8d 15 45 0d 01 00 	lea    0x10d45(%rip),%rdx        # 159d5 <exec_in_fp0+0x165>
    4c90:	31 c0                	xor    %eax,%eax
    4c92:	e8 59 e6 ff ff       	call   32f0 <fprintf@plt>
    4c97:	b8 03 00 00 00       	mov    $0x3,%eax
    4c9c:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    4ca0:	e9 4b f9 ff ff       	jmp    45f0 <fwp_main_thread+0xe90>
    4ca5:	b8 01 00 00 00       	mov    $0x1,%eax
    4caa:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    4cae:	48 8b 7d 80          	mov    -0x80(%rbp),%rdi
    4cb2:	e8 99 e3 ff ff       	call   3050 <free@plt>
    4cb7:	4c 8b 65 d0          	mov    -0x30(%rbp),%r12
    4cbb:	83 3d 3e 72 02 00 00 	cmpl   $0x0,0x2723e(%rip)        # 2bf00 <fwp_exec_binary_out>
    4cc2:	0f 84 21 03 00 00    	je     4fe9 <fwp_main_thread+0x1889>
    4cc8:	48 8d 3d 6c 0b 01 00 	lea    0x10b6c(%rip),%rdi        # 1583b <fwp_exec.end>
    4ccf:	be 05 00 00 00       	mov    $0x5,%esi
    4cd4:	e8 27 69 00 00       	call   b600 <fwp_pipe_write>
    4cd9:	8b 05 41 72 02 00    	mov    0x27241(%rip),%eax        # 2bf20 <fwp_po_kind>
    4cdf:	83 f8 02             	cmp    $0x2,%eax
    4ce2:	0f 84 83 00 00 00    	je     4d6b <fwp_main_thread+0x160b>
    4ce8:	83 f8 01             	cmp    $0x1,%eax
    4ceb:	0f 85 d2 00 00 00    	jne    4dc3 <fwp_main_thread+0x1663>
    4cf1:	48 8b 1d 30 72 02 00 	mov    0x27230(%rip),%rbx        # 2bf28 <fwp_po_len>
    4cf8:	48 85 db             	test   %rbx,%rbx
    4cfb:	0f 84 b4 02 00 00    	je     4fb5 <fwp_main_thread+0x1855>
    4d01:	80 3d 30 72 03 00 00 	cmpb   $0x0,0x37230(%rip)        # 3bf38 <fwp_po_gone>
    4d08:	0f 85 a7 02 00 00    	jne    4fb5 <fwp_main_thread+0x1855>
    4d0e:	44 8b 35 cf 70 01 00 	mov    0x170cf(%rip),%r14d        # 1bde4 <fwp_po_sock>
    4d15:	4c 8d 3d 14 72 02 00 	lea    0x27214(%rip),%r15        # 2bf30 <fwp_po_buf>
    4d1c:	0f 1f 40 00          	nopl   0x0(%rax)
    4d20:	44 89 f7             	mov    %r14d,%edi
    4d23:	4c 89 fe             	mov    %r15,%rsi
    4d26:	48 89 da             	mov    %rbx,%rdx
    4d29:	b9 00 40 00 00       	mov    $0x4000,%ecx
    4d2e:	e8 6d e4 ff ff       	call   31a0 <send@plt>
    4d33:	48 85 c0             	test   %rax,%rax
    4d36:	78 0e                	js     4d46 <fwp_main_thread+0x15e6>
    4d38:	0f 84 70 02 00 00    	je     4fae <fwp_main_thread+0x184e>
    4d3e:	49 01 c7             	add    %rax,%r15
    4d41:	48 29 c3             	sub    %rax,%rbx
    4d44:	eb 0e                	jmp    4d54 <fwp_main_thread+0x15f4>
    4d46:	e8 35 e3 ff ff       	call   3080 <__errno_location@plt>
    4d4b:	83 38 04             	cmpl   $0x4,(%rax)
    4d4e:	0f 85 5a 02 00 00    	jne    4fae <fwp_main_thread+0x184e>
    4d54:	48 85 db             	test   %rbx,%rbx
    4d57:	0f 84 58 02 00 00    	je     4fb5 <fwp_main_thread+0x1855>
    4d5d:	f6 05 d4 71 03 00 01 	testb  $0x1,0x371d4(%rip)        # 3bf38 <fwp_po_gone>
    4d64:	74 ba                	je     4d20 <fwp_main_thread+0x15c0>
    4d66:	e9 4a 02 00 00       	jmp    4fb5 <fwp_main_thread+0x1855>
    4d6b:	48 8b 35 be 71 03 00 	mov    0x371be(%rip),%rsi        # 3bf30 <fwp_po_ring>
    4d72:	c7 86 40 01 00 00 01 	movl   $0x1,0x140(%rsi)
    4d79:	00 00 00 
    4d7c:	0f ae f0             	mfence
    4d7f:	8b 86 c4 00 00 00    	mov    0xc4(%rsi),%eax
    4d85:	85 c0                	test   %eax,%eax
    4d87:	0f 84 43 02 00 00    	je     4fd0 <fwp_main_thread+0x1870>
    4d8d:	f0 ff 86 c0 00 00 00 	lock incl 0xc0(%rsi)
    4d94:	48 81 c6 c0 00 00 00 	add    $0xc0,%rsi
    4d9b:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    4da2:	bf ca 00 00 00       	mov    $0xca,%edi
    4da7:	ba 01 00 00 00       	mov    $0x1,%edx
    4dac:	b9 ff ff ff 7f       	mov    $0x7fffffff,%ecx
    4db1:	45 31 c0             	xor    %r8d,%r8d
    4db4:	45 31 c9             	xor    %r9d,%r9d
    4db7:	31 c0                	xor    %eax,%eax
    4db9:	e8 42 e5 ff ff       	call   3300 <syscall@plt>
    4dbe:	e9 0d 02 00 00       	jmp    4fd0 <fwp_main_thread+0x1870>
    4dc3:	48 8b 05 e6 51 01 00 	mov    0x151e6(%rip),%rax        # 19fb0 <stdout@GLIBC_2.2.5>
    4dca:	48 8b 38             	mov    (%rax),%rdi
    4dcd:	e8 7e e5 ff ff       	call   3350 <fflush@plt>
    4dd2:	e9 f9 01 00 00       	jmp    4fd0 <fwp_main_thread+0x1870>
    4dd7:	c7 05 2b 71 02 00 04 	movl   $0x4,0x2712b(%rip)        # 2bf0c <fwp_in_ppos>
    4dde:	00 00 00 
    4de1:	48 8d 7d 80          	lea    -0x80(%rbp),%rdi
    4de5:	be 01 00 00 00       	mov    $0x1,%esi
    4dea:	e8 a1 70 00 00       	call   be90 <fwp_read_exact>
    4def:	85 c0                	test   %eax,%eax
    4df1:	0f 84 16 05 00 00    	je     530d <fwp_main_thread+0x1bad>
    4df7:	49 c7 c6 f9 ff ff ff 	mov    $0xfffffffffffffff9,%r14
    4dfe:	45 31 ff             	xor    %r15d,%r15d
    4e01:	48 8d 9d d0 fd ff ff 	lea    -0x230(%rbp),%rbx
    4e08:	45 31 e4             	xor    %r12d,%r12d
    4e0b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    4e10:	be 01 00 00 00       	mov    $0x1,%esi
    4e15:	48 89 df             	mov    %rbx,%rdi
    4e18:	e8 73 70 00 00       	call   be90 <fwp_read_exact>
    4e1d:	85 c0                	test   %eax,%eax
    4e1f:	0f 84 02 03 00 00    	je     5127 <fwp_main_thread+0x19c7>
    4e25:	0f b6 85 d0 fd ff ff 	movzbl -0x230(%rbp),%eax
    4e2c:	49 83 fe 38          	cmp    $0x38,%r14
    4e30:	75 07                	jne    4e39 <fwp_main_thread+0x16d9>
    4e32:	89 c1                	mov    %eax,%ecx
    4e34:	80 e1 7e             	and    $0x7e,%cl
    4e37:	75 1c                	jne    4e55 <fwp_main_thread+0x16f5>
    4e39:	49 83 c6 07          	add    $0x7,%r14
    4e3d:	89 c2                	mov    %eax,%edx
    4e3f:	83 e2 7f             	and    $0x7f,%edx
    4e42:	44 89 f1             	mov    %r14d,%ecx
    4e45:	48 d3 e2             	shl    %cl,%rdx
    4e48:	49 09 d4             	or     %rdx,%r12
    4e4b:	84 c0                	test   %al,%al
    4e4d:	79 1a                	jns    4e69 <fwp_main_thread+0x1709>
    4e4f:	49 83 fe 38          	cmp    $0x38,%r14
    4e53:	76 bb                	jbe    4e10 <fwp_main_thread+0x16b0>
    4e55:	41 bf ff ff ff ff    	mov    $0xffffffff,%r15d
    4e5b:	45 85 ff             	test   %r15d,%r15d
    4e5e:	0f 88 cc 02 00 00    	js     5130 <fwp_main_thread+0x19d0>
    4e64:	e9 a4 04 00 00       	jmp    530d <fwp_main_thread+0x1bad>
    4e69:	49 83 fc 40          	cmp    $0x40,%r12
    4e6d:	41 be 40 00 00 00    	mov    $0x40,%r14d
    4e73:	4d 0f 42 f4          	cmovb  %r12,%r14
    4e77:	4d 85 e4             	test   %r12,%r12
    4e7a:	0f 84 f1 01 00 00    	je     5071 <fwp_main_thread+0x1911>
    4e80:	45 31 ed             	xor    %r13d,%r13d
    4e83:	4c 8d bd d0 fd ff ff 	lea    -0x230(%rbp),%r15
    4e8a:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%rbp)
    4e91:	eb 4b                	jmp    4ede <fwp_main_thread+0x177e>
    4e93:	be 06 00 00 00       	mov    $0x6,%esi
    4e98:	4c 89 ff             	mov    %r15,%rdi
    4e9b:	e8 f0 6f 00 00       	call   be90 <fwp_read_exact>
    4ea0:	85 c0                	test   %eax,%eax
    4ea2:	0f 84 65 04 00 00    	je     530d <fwp_main_thread+0x1bad>
    4ea8:	8b 85 d0 fd ff ff    	mov    -0x230(%rbp),%eax
    4eae:	b9 55 44 53 5f       	mov    $0x5f534455,%ecx
    4eb3:	31 c8                	xor    %ecx,%eax
    4eb5:	0f b7 8d d4 fd ff ff 	movzwl -0x22c(%rbp),%ecx
    4ebc:	81 f1 56 31 00 00    	xor    $0x3156,%ecx
    4ec2:	09 c1                	or     %eax,%ecx
    4ec4:	8b 45 c8             	mov    -0x38(%rbp),%eax
    4ec7:	b9 01 00 00 00       	mov    $0x1,%ecx
    4ecc:	0f 44 c1             	cmove  %ecx,%eax
    4ecf:	89 45 c8             	mov    %eax,-0x38(%rbp)
    4ed2:	49 ff c5             	inc    %r13
    4ed5:	4d 39 f5             	cmp    %r14,%r13
    4ed8:	0f 84 9a 01 00 00    	je     5078 <fwp_main_thread+0x1918>
    4ede:	48 c7 c3 f9 ff ff ff 	mov    $0xfffffffffffffff9,%rbx
    4ee5:	45 31 e4             	xor    %r12d,%r12d
    4ee8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    4eef:	00 
    4ef0:	be 01 00 00 00       	mov    $0x1,%esi
    4ef5:	4c 89 ff             	mov    %r15,%rdi
    4ef8:	e8 93 6f 00 00       	call   be90 <fwp_read_exact>
    4efd:	85 c0                	test   %eax,%eax
    4eff:	0f 84 1f 02 00 00    	je     5124 <fwp_main_thread+0x19c4>
    4f05:	0f b6 85 d0 fd ff ff 	movzbl -0x230(%rbp),%eax
    4f0c:	48 83 fb 38          	cmp    $0x38,%rbx
    4f10:	75 0b                	jne    4f1d <fwp_main_thread+0x17bd>
    4f12:	89 c1                	mov    %eax,%ecx
    4f14:	80 e1 7e             	and    $0x7e,%cl
    4f17:	0f 85 38 ff ff ff    	jne    4e55 <fwp_main_thread+0x16f5>
    4f1d:	48 83 c3 07          	add    $0x7,%rbx
    4f21:	89 c2                	mov    %eax,%edx
    4f23:	83 e2 7f             	and    $0x7f,%edx
    4f26:	89 d9                	mov    %ebx,%ecx
    4f28:	48 d3 e2             	shl    %cl,%rdx
    4f2b:	49 09 d4             	or     %rdx,%r12
    4f2e:	84 c0                	test   %al,%al
    4f30:	79 0b                	jns    4f3d <fwp_main_thread+0x17dd>
    4f32:	48 83 fb 38          	cmp    $0x38,%rbx
    4f36:	76 b8                	jbe    4ef0 <fwp_main_thread+0x1790>
    4f38:	e9 18 ff ff ff       	jmp    4e55 <fwp_main_thread+0x16f5>
    4f3d:	49 81 fc 01 00 10 00 	cmp    $0x100001,%r12
    4f44:	0f 83 0b ff ff ff    	jae    4e55 <fwp_main_thread+0x16f5>
    4f4a:	4d 85 e4             	test   %r12,%r12
    4f4d:	74 83                	je     4ed2 <fwp_main_thread+0x1772>
    4f4f:	49 83 fc 06          	cmp    $0x6,%r12
    4f53:	0f 84 3a ff ff ff    	je     4e93 <fwp_main_thread+0x1733>
    4f59:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    4f60:	49 81 fc 00 01 00 00 	cmp    $0x100,%r12
    4f67:	bb 00 01 00 00       	mov    $0x100,%ebx
    4f6c:	49 0f 42 dc          	cmovb  %r12,%rbx
    4f70:	4c 89 ff             	mov    %r15,%rdi
    4f73:	48 89 de             	mov    %rbx,%rsi
    4f76:	e8 15 6f 00 00       	call   be90 <fwp_read_exact>
    4f7b:	85 c0                	test   %eax,%eax
    4f7d:	0f 84 8a 03 00 00    	je     530d <fwp_main_thread+0x1bad>
    4f83:	49 29 dc             	sub    %rbx,%r12
    4f86:	75 d8                	jne    4f60 <fwp_main_thread+0x1800>
    4f88:	e9 45 ff ff ff       	jmp    4ed2 <fwp_main_thread+0x1772>
    4f8d:	b9 01 00 00 00       	mov    $0x1,%ecx
    4f92:	48 8d 05 37 6f 01 00 	lea    0x16f37(%rip),%rax        # 1bed0 <fwp_cli_scripts>
    4f99:	48 8b 3c c8          	mov    (%rax,%rcx,8),%rdi
    4f9d:	48 8b 05 0c 50 01 00 	mov    0x1500c(%rip),%rax        # 19fb0 <stdout@GLIBC_2.2.5>
    4fa4:	48 8b 30             	mov    (%rax),%rsi
    4fa7:	e8 44 e2 ff ff       	call   31f0 <fputs@plt>
    4fac:	eb 4a                	jmp    4ff8 <fwp_main_thread+0x1898>
    4fae:	c6 05 83 6f 03 00 01 	movb   $0x1,0x36f83(%rip)        # 3bf38 <fwp_po_gone>
    4fb5:	48 c7 05 68 6f 02 00 	movq   $0x0,0x26f68(%rip)        # 2bf28 <fwp_po_len>
    4fbc:	00 00 00 00 
    4fc0:	8b 3d 1e 6e 01 00    	mov    0x16e1e(%rip),%edi        # 1bde4 <fwp_po_sock>
    4fc6:	be 01 00 00 00       	mov    $0x1,%esi
    4fcb:	e8 90 e1 ff ff       	call   3160 <shutdown@plt>
    4fd0:	8b 3d 0a 6e 01 00    	mov    0x16e0a(%rip),%edi        # 1bde0 <fwp_po_listen>
    4fd6:	85 ff                	test   %edi,%edi
    4fd8:	78 0f                	js     4fe9 <fwp_main_thread+0x1889>
    4fda:	e8 51 e2 ff ff       	call   3230 <close@plt>
    4fdf:	c7 05 f7 6d 01 00 ff 	movl   $0xffffffff,0x16df7(%rip)        # 1bde0 <fwp_po_listen>
    4fe6:	ff ff ff 
    4fe9:	48 8b 05 c0 4f 01 00 	mov    0x14fc0(%rip),%rax        # 19fb0 <stdout@GLIBC_2.2.5>
    4ff0:	48 8b 38             	mov    (%rax),%rdi
    4ff3:	e8 58 e3 ff ff       	call   3350 <fflush@plt>
    4ff8:	44 89 25 a1 6e 01 00 	mov    %r12d,0x16ea1(%rip)        # 1bea0 <fwp_exit_code>
    4fff:	48 8b 05 aa 4f 01 00 	mov    0x14faa(%rip),%rax        # 19fb0 <stdout@GLIBC_2.2.5>
    5006:	48 8b 38             	mov    (%rax),%rdi
    5009:	e8 42 e3 ff ff       	call   3350 <fflush@plt>
    500e:	31 c0                	xor    %eax,%eax
    5010:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    5017:	5b                   	pop    %rbx
    5018:	41 5c                	pop    %r12
    501a:	41 5d                	pop    %r13
    501c:	41 5e                	pop    %r14
    501e:	41 5f                	pop    %r15
    5020:	5d                   	pop    %rbp
    5021:	c3                   	ret
    5022:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    5026:	48 8d 3d 6f 16 01 00 	lea    0x1166f(%rip),%rdi        # 1669c <exec_in_fp0+0xe2c>
    502d:	48 8d 0d c9 18 01 00 	lea    0x118c9(%rip),%rcx        # 168fd <exec_in_fp0+0x108d>
    5034:	4c 89 e2             	mov    %r12,%rdx
    5037:	31 c0                	xor    %eax,%eax
    5039:	e8 c2 83 00 00       	call   d400 <fwp_strf>
    503e:	48 8b 0d 93 4f 01 00 	mov    0x14f93(%rip),%rcx        # 19fd8 <stderr@GLIBC_2.2.5>
    5045:	48 8b 39             	mov    (%rcx),%rdi
    5048:	48 83 c0 08          	add    $0x8,%rax
    504c:	48 8d 35 a7 16 01 00 	lea    0x116a7(%rip),%rsi        # 166fa <exec_in_fp0+0xe8a>
    5053:	48 8d 15 7b 09 01 00 	lea    0x1097b(%rip),%rdx        # 159d5 <exec_in_fp0+0x165>
    505a:	b9 01 00 00 00       	mov    $0x1,%ecx
    505f:	49 89 c0             	mov    %rax,%r8
    5062:	31 c0                	xor    %eax,%eax
    5064:	e8 87 e2 ff ff       	call   32f0 <fprintf@plt>
    5069:	41 bc 02 00 00 00    	mov    $0x2,%r12d
    506f:	eb 87                	jmp    4ff8 <fwp_main_thread+0x1898>
    5071:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%rbp)
    5078:	48 c7 85 60 ff ff ff 	movq   $0x0,-0xa0(%rbp)
    507f:	00 00 00 00 
    5083:	48 8d bd e0 fe ff ff 	lea    -0x120(%rbp),%rdi
    508a:	be 10 00 00 00       	mov    $0x10,%esi
    508f:	e8 fc 6d 00 00       	call   be90 <fwp_read_exact>
    5094:	85 c0                	test   %eax,%eax
    5096:	0f 84 71 02 00 00    	je     530d <fwp_main_thread+0x1bad>
    509c:	48 8d bd 60 ff ff ff 	lea    -0xa0(%rbp),%rdi
    50a3:	e8 f8 72 00 00       	call   c3a0 <fwp_stdin_name_len>
    50a8:	83 f8 01             	cmp    $0x1,%eax
    50ab:	0f 85 50 02 00 00    	jne    5301 <fwp_main_thread+0x1ba1>
    50b1:	4c 8b b5 60 ff ff ff 	mov    -0xa0(%rbp),%r14
    50b8:	49 8d 7e 01          	lea    0x1(%r14),%rdi
    50bc:	e8 8f 64 00 00       	call   b550 <fwp_alloc_leaf>
    50c1:	48 89 c3             	mov    %rax,%rbx
    50c4:	4d 85 f6             	test   %r14,%r14
    50c7:	74 13                	je     50dc <fwp_main_thread+0x197c>
    50c9:	48 89 df             	mov    %rbx,%rdi
    50cc:	4c 89 f6             	mov    %r14,%rsi
    50cf:	e8 bc 6d 00 00       	call   be90 <fwp_read_exact>
    50d4:	85 c0                	test   %eax,%eax
    50d6:	0f 84 31 02 00 00    	je     530d <fwp_main_thread+0x1bad>
    50dc:	42 c6 04 33 00       	movb   $0x0,(%rbx,%r14,1)
    50e1:	0f b6 4d 80          	movzbl -0x80(%rbp),%ecx
    50e5:	83 f9 01             	cmp    $0x1,%ecx
    50e8:	0f 85 49 02 00 00    	jne    5337 <fwp_main_thread+0x1bd7>
    50ee:	66 0f 6f 85 e0 fe ff 	movdqa -0x120(%rbp),%xmm0
    50f5:	ff 
    50f6:	66 0f 74 05 12 ff 00 	pcmpeqb 0xff12(%rip),%xmm0        # 15010 <_IO_stdin_used+0x10>
    50fd:	00 
    50fe:	66 0f d7 c0          	pmovmskb %xmm0,%eax
    5102:	3d ff ff 00 00       	cmp    $0xffff,%eax
    5107:	0f 85 54 02 00 00    	jne    5361 <fwp_main_thread+0x1c01>
    510d:	83 7d c8 00          	cmpl   $0x0,-0x38(%rbp)
    5111:	74 05                	je     5118 <fwp_main_thread+0x19b8>
    5113:	e8 18 73 00 00       	call   c430 <fwp_pipe_in_offer>
    5118:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%rbp)
    511f:	e9 9d f2 ff ff       	jmp    43c1 <fwp_main_thread+0xc61>
    5124:	45 31 ff             	xor    %r15d,%r15d
    5127:	45 85 ff             	test   %r15d,%r15d
    512a:	0f 89 dd 01 00 00    	jns    530d <fwp_main_thread+0x1bad>
    5130:	48 8b 05 a1 4e 01 00 	mov    0x14ea1(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    5137:	48 8b 38             	mov    (%rax),%rdi
    513a:	48 8d 35 83 14 01 00 	lea    0x11483(%rip),%rsi        # 165c4 <exec_in_fp0+0xd54>
    5141:	e9 d8 01 00 00       	jmp    531e <fwp_main_thread+0x1bbe>
    5146:	48 8b 05 8b 4e 01 00 	mov    0x14e8b(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    514d:	48 8b 38             	mov    (%rax),%rdi
    5150:	41 8b 0f             	mov    (%r15),%ecx
    5153:	48 8d 35 45 14 01 00 	lea    0x11445(%rip),%rsi        # 1659f <exec_in_fp0+0xd2f>
    515a:	48 8d 15 74 08 01 00 	lea    0x10874(%rip),%rdx        # 159d5 <exec_in_fp0+0x165>
    5161:	4c 8d 0d 95 17 01 00 	lea    0x11795(%rip),%r9        # 168fd <exec_in_fp0+0x108d>
    5168:	4d 89 f0             	mov    %r14,%r8
    516b:	31 c0                	xor    %eax,%eax
    516d:	e8 7e e1 ff ff       	call   32f0 <fprintf@plt>
    5172:	b8 03 00 00 00       	mov    $0x3,%eax
    5177:	e9 2e fb ff ff       	jmp    4caa <fwp_main_thread+0x154a>
    517c:	66 0f ef c0          	pxor   %xmm0,%xmm0
    5180:	66 0f 7f 85 d0 fd ff 	movdqa %xmm0,-0x230(%rbp)
    5187:	ff 
    5188:	48 c7 85 e0 fd ff ff 	movq   $0x0,-0x220(%rbp)
    518f:	00 00 00 00 
    5193:	83 3d 66 6c 01 00 00 	cmpl   $0x0,0x16c66(%rip)        # 1be00 <d3+0x10>
    519a:	0f 8e da 00 00 00    	jle    527a <fwp_main_thread+0x1b1a>
    51a0:	45 31 f6             	xor    %r14d,%r14d
    51a3:	48 8d 9d d0 fd ff ff 	lea    -0x230(%rbp),%rbx
    51aa:	4c 8d 65 80          	lea    -0x80(%rbp),%r12
    51ae:	eb 13                	jmp    51c3 <fwp_main_thread+0x1a63>
    51b0:	49 ff c6             	inc    %r14
    51b3:	48 63 05 46 6c 01 00 	movslq 0x16c46(%rip),%rax        # 1be00 <d3+0x10>
    51ba:	49 39 c6             	cmp    %rax,%r14
    51bd:	0f 8d b7 00 00 00    	jge    527a <fwp_main_thread+0x1b1a>
    51c3:	4d 85 f6             	test   %r14,%r14
    51c6:	74 14                	je     51dc <fwp_main_thread+0x1a7c>
    51c8:	ba 02 00 00 00       	mov    $0x2,%edx
    51cd:	48 89 df             	mov    %rbx,%rdi
    51d0:	48 8d 35 e4 14 01 00 	lea    0x114e4(%rip),%rsi        # 166bb <exec_in_fp0+0xe4b>
    51d7:	e8 34 80 00 00       	call   d210 <buf_put>
    51dc:	48 8b 05 25 6c 01 00 	mov    0x16c25(%rip),%rax        # 1be08 <d3+0x18>
    51e3:	4e 8b 3c f0          	mov    (%rax,%r14,8),%r15
    51e7:	45 0f b6 2f          	movzbl (%r15),%r13d
    51eb:	45 84 ed             	test   %r13b,%r13b
    51ee:	74 c0                	je     51b0 <fwp_main_thread+0x1a50>
    51f0:	49 ff c7             	inc    %r15
    51f3:	31 c0                	xor    %eax,%eax
    51f5:	eb 46                	jmp    523d <fwp_main_thread+0x1add>
    51f7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    51fe:	00 00 
    5200:	44 88 6d 80          	mov    %r13b,-0x80(%rbp)
    5204:	ba 01 00 00 00       	mov    $0x1,%edx
    5209:	48 89 df             	mov    %rbx,%rdi
    520c:	4c 89 e6             	mov    %r12,%rsi
    520f:	e8 fc 7f 00 00       	call   d210 <buf_put>
    5214:	41 8d 45 9f          	lea    -0x61(%r13),%eax
    5218:	3c 1a                	cmp    $0x1a,%al
    521a:	0f 92 c0             	setb   %al
    521d:	41 80 c5 d0          	add    $0xd0,%r13b
    5221:	41 80 fd 0a          	cmp    $0xa,%r13b
    5225:	0f 92 c1             	setb   %cl
    5228:	08 c1                	or     %al,%cl
    522a:	0f b6 c1             	movzbl %cl,%eax
    522d:	45 0f b6 2f          	movzbl (%r15),%r13d
    5231:	49 ff c7             	inc    %r15
    5234:	45 84 ed             	test   %r13b,%r13b
    5237:	0f 84 73 ff ff ff    	je     51b0 <fwp_main_thread+0x1a50>
    523d:	41 8d 4d bf          	lea    -0x41(%r13),%ecx
    5241:	80 f9 19             	cmp    $0x19,%cl
    5244:	77 ba                	ja     5200 <fwp_main_thread+0x1aa0>
    5246:	85 c0                	test   %eax,%eax
    5248:	74 14                	je     525e <fwp_main_thread+0x1afe>
    524a:	c6 45 80 2d          	movb   $0x2d,-0x80(%rbp)
    524e:	ba 01 00 00 00       	mov    $0x1,%edx
    5253:	48 89 df             	mov    %rbx,%rdi
    5256:	4c 89 e6             	mov    %r12,%rsi
    5259:	e8 b2 7f 00 00       	call   d210 <buf_put>
    525e:	41 80 cd 20          	or     $0x20,%r13b
    5262:	44 88 6d 80          	mov    %r13b,-0x80(%rbp)
    5266:	ba 01 00 00 00       	mov    $0x1,%edx
    526b:	48 89 df             	mov    %rbx,%rdi
    526e:	4c 89 e6             	mov    %r12,%rsi
    5271:	e8 9a 7f 00 00       	call   d210 <buf_put>
    5276:	31 c0                	xor    %eax,%eax
    5278:	eb b3                	jmp    522d <fwp_main_thread+0x1acd>
    527a:	48 8d bd d0 fd ff ff 	lea    -0x230(%rbp),%rdi
    5281:	e8 7a 80 00 00       	call   d300 <buf_to_str>
    5286:	48 8d 48 08          	lea    0x8(%rax),%rcx
    528a:	48 8d 3d f3 13 01 00 	lea    0x113f3(%rip),%rdi        # 16684 <exec_in_fp0+0xe14>
    5291:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    5295:	48 8b 95 d8 fe ff ff 	mov    -0x128(%rbp),%rdx
    529c:	e9 96 fd ff ff       	jmp    5037 <fwp_main_thread+0x18d7>
    52a1:	48 8b 05 30 4d 01 00 	mov    0x14d30(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    52a8:	48 8b 38             	mov    (%rax),%rdi
    52ab:	48 8d 35 4c 13 01 00 	lea    0x1134c(%rip),%rsi        # 165fe <exec_in_fp0+0xd8e>
    52b2:	48 8d 15 1c 07 01 00 	lea    0x1071c(%rip),%rdx        # 159d5 <exec_in_fp0+0x165>
    52b9:	e9 ac ed ff ff       	jmp    406a <fwp_main_thread+0x90a>
    52be:	44 89 35 1b 6b 01 00 	mov    %r14d,0x16b1b(%rip)        # 1bde0 <fwp_po_listen>
    52c5:	48 8d b5 60 ff ff ff 	lea    -0xa0(%rbp),%rsi
    52cc:	bf 01 00 00 00       	mov    $0x1,%edi
    52d1:	e8 5a de ff ff       	call   3130 <clock_gettime@plt>
    52d6:	48 69 85 60 ff ff ff 	imul   $0x3b9aca00,-0xa0(%rbp),%rax
    52dd:	00 ca 9a 3b 
    52e1:	48 03 85 68 ff ff ff 	add    -0x98(%rbp),%rax
    52e8:	48 b9 00 f2 05 2a 01 	movabs $0x12a05f200,%rcx
    52ef:	00 00 00 
    52f2:	48 01 c1             	add    %rax,%rcx
    52f5:	48 89 0d 1c 6c 02 00 	mov    %rcx,0x26c1c(%rip)        # 2bf18 <fwp_po_give_up>
    52fc:	e9 12 f2 ff ff       	jmp    4513 <fwp_main_thread+0xdb3>
    5301:	41 89 c7             	mov    %eax,%r15d
    5304:	45 85 ff             	test   %r15d,%r15d
    5307:	0f 88 23 fe ff ff    	js     5130 <fwp_main_thread+0x19d0>
    530d:	48 8b 05 c4 4c 01 00 	mov    0x14cc4(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    5314:	48 8b 38             	mov    (%rax),%rdi
    5317:	48 8d 35 b6 12 01 00 	lea    0x112b6(%rip),%rsi        # 165d4 <exec_in_fp0+0xd64>
    531e:	48 8d 15 b0 06 01 00 	lea    0x106b0(%rip),%rdx        # 159d5 <exec_in_fp0+0x165>
    5325:	31 c0                	xor    %eax,%eax
    5327:	e8 c4 df ff ff       	call   32f0 <fprintf@plt>
    532c:	41 bc 03 00 00 00    	mov    $0x3,%r12d
    5332:	e9 c1 fc ff ff       	jmp    4ff8 <fwp_main_thread+0x1898>
    5337:	48 8b 05 9a 4c 01 00 	mov    0x14c9a(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    533e:	48 8b 38             	mov    (%rax),%rdi
    5341:	48 8d 35 c0 11 01 00 	lea    0x111c0(%rip),%rsi        # 16508 <exec_in_fp0+0xc98>
    5348:	48 8d 15 86 06 01 00 	lea    0x10686(%rip),%rdx        # 159d5 <exec_in_fp0+0x165>
    534f:	31 c0                	xor    %eax,%eax
    5351:	e8 9a df ff ff       	call   32f0 <fprintf@plt>
    5356:	41 bc 03 00 00 00    	mov    $0x3,%r12d
    535c:	e9 97 fc ff ff       	jmp    4ff8 <fwp_main_thread+0x1898>
    5361:	48 8b 05 70 4c 01 00 	mov    0x14c70(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    5368:	48 8b 38             	mov    (%rax),%rdi
    536b:	48 8d 35 bb 11 01 00 	lea    0x111bb(%rip),%rsi        # 1652d <exec_in_fp0+0xcbd>
    5372:	48 8d 15 5c 06 01 00 	lea    0x1065c(%rip),%rdx        # 159d5 <exec_in_fp0+0x165>
    5379:	48 8d 0d 7d 15 01 00 	lea    0x1157d(%rip),%rcx        # 168fd <exec_in_fp0+0x108d>
    5380:	49 89 d8             	mov    %rbx,%r8
    5383:	31 c0                	xor    %eax,%eax
    5385:	e8 66 df ff ff       	call   32f0 <fprintf@plt>
    538a:	41 bc 03 00 00 00    	mov    $0x3,%r12d
    5390:	e9 63 fc ff ff       	jmp    4ff8 <fwp_main_thread+0x1898>
    5395:	48 8b 05 3c 4c 01 00 	mov    0x14c3c(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    539c:	48 8b 38             	mov    (%rax),%rdi
    539f:	48 8d 35 e4 11 01 00 	lea    0x111e4(%rip),%rsi        # 1658a <exec_in_fp0+0xd1a>
    53a6:	48 8d 15 28 06 01 00 	lea    0x10628(%rip),%rdx        # 159d5 <exec_in_fp0+0x165>
    53ad:	31 c0                	xor    %eax,%eax
    53af:	e8 3c df ff ff       	call   32f0 <fprintf@plt>
    53b4:	e9 b9 fd ff ff       	jmp    5172 <fwp_main_thread+0x1a12>
    53b9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000053c0 <main>:
    53c0:	55                   	push   %rbp
    53c1:	48 89 e5             	mov    %rsp,%rbp
    53c4:	41 57                	push   %r15
    53c6:	41 56                	push   %r14
    53c8:	41 55                	push   %r13
    53ca:	41 54                	push   %r12
    53cc:	53                   	push   %rbx
    53cd:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    53d4:	83 3d 99 5e 01 00 00 	cmpl   $0x0,0x15e99(%rip)        # 1b274 <fwp_gc+0xfec>
    53db:	75 05                	jne    53e2 <main+0x22>
    53dd:	e8 ce 2f 00 00       	call   83b0 <fwp_gc_init>
    53e2:	48 89 2d 27 5f 01 00 	mov    %rbp,0x15f27(%rip)        # 1b310 <fwp_gc+0x1088>
    53e9:	48 8d 3d b0 e6 00 00 	lea    0xe6b0(%rip),%rdi        # 13aa0 <fwp_gc_find_data>
    53f0:	31 f6                	xor    %esi,%esi
    53f2:	e8 49 dc ff ff       	call   3040 <dl_iterate_phdr@plt>
    53f7:	83 3d 7a 5e 01 00 00 	cmpl   $0x0,0x15e7a(%rip)        # 1b278 <fwp_gc+0xff0>
    53fe:	0f 95 c1             	setne  %cl
    5401:	83 3d 10 60 01 00 00 	cmpl   $0x0,0x16010(%rip)        # 1b418 <fwp_gc+0x1190>
    5408:	0f 9f c0             	setg   %al
    540b:	20 c8                	and    %cl,%al
    540d:	0f b6 c8             	movzbl %al,%ecx
    5410:	89 0d 66 5e 01 00    	mov    %ecx,0x15e66(%rip)        # 1b27c <fwp_gc+0xff4>
    5416:	83 3d 67 5e 01 00 00 	cmpl   $0x0,0x15e67(%rip)        # 1b284 <fwp_gc+0xffc>
    541d:	74 16                	je     5435 <main+0x75>
    541f:	48 8d 3d 5a e7 00 00 	lea    0xe75a(%rip),%rdi        # 13b80 <fwp_gc_report>
    5426:	e8 65 ec 00 00       	call   14090 <atexit>
    542b:	83 3d 4a 5e 01 00 00 	cmpl   $0x0,0x15e4a(%rip)        # 1b27c <fwp_gc+0xff4>
    5432:	0f 95 c0             	setne  %al
    5435:	84 c0                	test   %al,%al
    5437:	74 43                	je     547c <main+0xbc>
    5439:	48 83 3d 67 5e 01 00 	cmpq   $0x0,0x15e67(%rip)        # 1b2a8 <fwp_gc+0x1020>
    5440:	00 
    5441:	74 39                	je     547c <main+0xbc>
    5443:	48 8b 05 4e 60 01 00 	mov    0x1604e(%rip),%rax        # 1b498 <fwp_gc+0x1210>
    544a:	48 2b 05 37 4e 01 00 	sub    0x14e37(%rip),%rax        # 1a288 <fwp_gc>
    5451:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    5456:	f2 0f 58 05 12 60 01 	addsd  0x16012(%rip),%xmm0        # 1b470 <fwp_gc+0x11e8>
    545d:	00 
    545e:	f2 0f 11 05 0a 60 01 	movsd  %xmm0,0x1600a(%rip)        # 1b470 <fwp_gc+0x11e8>
    5465:	00 
    5466:	48 c7 05 27 60 01 00 	movq   $0x0,0x16027(%rip)        # 1b498 <fwp_gc+0x1210>
    546d:	00 00 00 00 
    5471:	48 c7 05 0c 4e 01 00 	movq   $0x0,0x14e0c(%rip)        # 1a288 <fwp_gc>
    5478:	00 00 00 00 
    547c:	48 8d 05 fd 43 01 00 	lea    0x143fd(%rip),%rax        # 19880 <fwp_fn_table>
    5483:	48 89 05 e6 69 01 00 	mov    %rax,0x169e6(%rip)        # 1be70 <fwp_fns>
    548a:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    548e:	66 0f 29 85 50 ff ff 	movapd %xmm0,-0xb0(%rbp)
    5495:	ff 
    5496:	66 0f 29 45 a0       	movapd %xmm0,-0x60(%rbp)
    549b:	66 0f 29 45 90       	movapd %xmm0,-0x70(%rbp)
    54a0:	66 0f 29 45 80       	movapd %xmm0,-0x80(%rbp)
    54a5:	66 0f 29 85 70 ff ff 	movapd %xmm0,-0x90(%rbp)
    54ac:	ff 
    54ad:	66 0f 29 85 60 ff ff 	movapd %xmm0,-0xa0(%rbp)
    54b4:	ff 
    54b5:	c7 85 50 ff ff ff 0b 	movl   $0xb,-0xb0(%rbp)
    54bc:	00 00 00 
    54bf:	48 8d 3d 82 04 01 00 	lea    0x10482(%rip),%rdi        # 15948 <exec_in_fp0+0xd8>
    54c6:	e8 05 dc ff ff       	call   30d0 <puts@plt>
    54cb:	45 31 f6             	xor    %r14d,%r14d
    54ce:	48 bb c5 4e ec c4 4e 	movabs $0x4ec4ec4ec4ec4ec5,%rbx
    54d5:	ec c4 4e 
    54d8:	49 bd 00 00 00 00 00 	movabs $0x8000000000000000,%r13
    54df:	00 00 80 
    54e2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    54e9:	1f 84 00 00 00 00 00 
    54f0:	49 83 fe 03          	cmp    $0x3,%r14
    54f4:	73 1a                	jae    5510 <main+0x150>
    54f6:	48 8d 05 83 03 01 00 	lea    0x10383(%rip),%rax        # 15880 <exec_in_fp0+0x10>
    54fd:	4e 8b 3c f0          	mov    (%rax,%r14,8),%r15
    5501:	eb 1c                	jmp    551f <main+0x15f>
    5503:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    550a:	84 00 00 00 00 00 
    5510:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    5516:	b8 07 00 00 00       	mov    $0x7,%eax
    551b:	4c 0f 44 f8          	cmove  %rax,%r15
    551f:	4c 89 ff             	mov    %r15,%rdi
    5522:	48 8d b5 50 ff ff ff 	lea    -0xb0(%rbp),%rsi
    5529:	e8 02 03 00 00       	call   5830 <fwp_array_new_packed>
    552e:	49 89 c4             	mov    %rax,%r12
    5531:	48 2b 05 80 5d 01 00 	sub    0x15d80(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    5538:	48 8b 0d a1 5d 01 00 	mov    0x15da1(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    553f:	48 c1 e1 10          	shl    $0x10,%rcx
    5543:	48 39 c8             	cmp    %rcx,%rax
    5546:	f2 0f 10 0d 4a fc 00 	movsd  0xfc4a(%rip),%xmm1        # 15198 <_IO_stdin_used+0x198>
    554d:	00 
    554e:	f2 0f 10 15 4a fc 00 	movsd  0xfc4a(%rip),%xmm2        # 151a0 <_IO_stdin_used+0x1a0>
    5555:	00 
    5556:	f2 0f 10 1d 4a fc 00 	movsd  0xfc4a(%rip),%xmm3        # 151a8 <_IO_stdin_used+0x1a8>
    555d:	00 
    555e:	0f 83 8c 00 00 00    	jae    55f0 <main+0x230>
    5564:	48 8b 0d 95 5d 01 00 	mov    0x15d95(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    556b:	48 89 c2             	mov    %rax,%rdx
    556e:	48 c1 ea 10          	shr    $0x10,%rdx
    5572:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5579:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    557d:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5583:	75 1b                	jne    55a0 <main+0x1e0>
    5585:	40 80 fe 02          	cmp    $0x2,%sil
    5589:	75 15                	jne    55a0 <main+0x1e0>
    558b:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    558f:	48 05 28 02 00 00    	add    $0x228,%rax
    5595:	80 38 ff             	cmpb   $0xff,(%rax)
    5598:	74 2a                	je     55c4 <main+0x204>
    559a:	c6 00 01             	movb   $0x1,(%rax)
    559d:	eb 51                	jmp    55f0 <main+0x230>
    559f:	90                   	nop
    55a0:	40 80 fe 01          	cmp    $0x1,%sil
    55a4:	75 4a                	jne    55f0 <main+0x230>
    55a6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    55aa:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    55ae:	48 0f af c1          	imul   %rcx,%rax
    55b2:	48 c1 e8 20          	shr    $0x20,%rax
    55b6:	48 01 f0             	add    %rsi,%rax
    55b9:	48 05 28 02 00 00    	add    $0x228,%rax
    55bf:	80 38 ff             	cmpb   $0xff,(%rax)
    55c2:	75 d6                	jne    559a <main+0x1da>
    55c4:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    55c8:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    55cc:	e8 6f 15 00 00       	call   6b40 <fwp_rc_forget_slot>
    55d1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    55d5:	f2 0f 10 1d cb fb 00 	movsd  0xfbcb(%rip),%xmm3        # 151a8 <_IO_stdin_used+0x1a8>
    55dc:	00 
    55dd:	f2 0f 10 15 bb fb 00 	movsd  0xfbbb(%rip),%xmm2        # 151a0 <_IO_stdin_used+0x1a0>
    55e4:	00 
    55e5:	f2 0f 10 0d ab fb 00 	movsd  0xfbab(%rip),%xmm1        # 15198 <_IO_stdin_used+0x198>
    55ec:	00 
    55ed:	eb ab                	jmp    559a <main+0x1da>
    55ef:	90                   	nop
    55f0:	f2 0f 10 25 98 fb 00 	movsd  0xfb98(%rip),%xmm4        # 15190 <_IO_stdin_used+0x190>
    55f7:	00 
    55f8:	4d 85 ff             	test   %r15,%r15
    55fb:	bf 84 04 00 00       	mov    $0x484,%edi
    5600:	41 b8 21 00 00 00    	mov    $0x21,%r8d
    5606:	41 b9 42 00 00 00    	mov    $0x42,%r9d
    560c:	0f 84 de 00 00 00    	je     56f0 <main+0x330>
    5612:	48 8d 35 57 00 01 00 	lea    0x10057(%rip),%rsi        # 15670 <main.edge>
    5619:	f2 0f 10 25 6f fb 00 	movsd  0xfb6f(%rip),%xmm4        # 15190 <_IO_stdin_used+0x190>
    5620:	00 
    5621:	31 c9                	xor    %ecx,%ecx
    5623:	eb 2c                	jmp    5651 <main+0x291>
    5625:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    562c:	00 00 00 00 
    5630:	41 89 44 8c 08       	mov    %eax,0x8(%r12,%rcx,4)
    5635:	f2 0f 59 c2          	mulsd  %xmm2,%xmm0
    5639:	f2 0f 58 c3          	addsd  %xmm3,%xmm0
    563d:	f2 0f 58 e0          	addsd  %xmm0,%xmm4
    5641:	48 ff c1             	inc    %rcx
    5644:	48 83 c6 08          	add    $0x8,%rsi
    5648:	49 39 cf             	cmp    %rcx,%r15
    564b:	0f 84 9f 00 00 00    	je     56f0 <main+0x330>
    5651:	48 89 c8             	mov    %rcx,%rax
    5654:	48 f7 e3             	mul    %rbx
    5657:	48 c1 ea 02          	shr    $0x2,%rdx
    565b:	8d 04 52             	lea    (%rdx,%rdx,2),%eax
    565e:	8d 04 82             	lea    (%rdx,%rax,4),%eax
    5661:	89 ca                	mov    %ecx,%edx
    5663:	29 c2                	sub    %eax,%edx
    5665:	83 c2 fa             	add    $0xfffffffa,%edx
    5668:	0f 57 c0             	xorps  %xmm0,%xmm0
    566b:	f2 0f 2a c2          	cvtsi2sd %edx,%xmm0
    566f:	f2 0f 59 c1          	mulsd  %xmm1,%xmm0
    5673:	4c 89 e8             	mov    %r13,%rax
    5676:	49 83 fe 04          	cmp    $0x4,%r14
    567a:	74 19                	je     5695 <main+0x2d5>
    567c:	49 83 fe 03          	cmp    $0x3,%r14
    5680:	75 0e                	jne    5690 <main+0x2d0>
    5682:	48 8b 06             	mov    (%rsi),%rax
    5685:	eb 0e                	jmp    5695 <main+0x2d5>
    5687:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    568e:	00 00 
    5690:	66 48 0f 7e c0       	movq   %xmm0,%rax
    5695:	49 83 3c 24 00       	cmpq   $0x0,(%r12)
    569a:	0f 88 57 01 00 00    	js     57f7 <main+0x437>
    56a0:	8b 95 50 ff ff ff    	mov    -0xb0(%rbp),%edx
    56a6:	83 fa 0a             	cmp    $0xa,%edx
    56a9:	77 2f                	ja     56da <main+0x31a>
    56ab:	0f a3 d7             	bt     %edx,%edi
    56ae:	72 80                	jb     5630 <main+0x270>
    56b0:	41 0f a3 d0          	bt     %edx,%r8d
    56b4:	72 1a                	jb     56d0 <main+0x310>
    56b6:	41 0f a3 d1          	bt     %edx,%r9d
    56ba:	73 1e                	jae    56da <main+0x31a>
    56bc:	66 41 89 44 4c 08    	mov    %ax,0x8(%r12,%rcx,2)
    56c2:	e9 6e ff ff ff       	jmp    5635 <main+0x275>
    56c7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    56ce:	00 00 
    56d0:	41 88 44 0c 08       	mov    %al,0x8(%r12,%rcx,1)
    56d5:	e9 5b ff ff ff       	jmp    5635 <main+0x275>
    56da:	49 89 44 cc 08       	mov    %rax,0x8(%r12,%rcx,8)
    56df:	e9 51 ff ff ff       	jmp    5635 <main+0x275>
    56e4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    56eb:	00 00 00 00 00 
    56f0:	f2 0f 11 65 c8       	movsd  %xmm4,-0x38(%rbp)
    56f5:	48 8b 1d ac 67 01 00 	mov    0x167ac(%rip),%rbx        # 1bea8 <measured_calls>
    56fc:	48 8b 05 ad 67 01 00 	mov    0x167ad(%rip),%rax        # 1beb0 <measured_bytes>
    5703:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    5707:	48 8b 05 aa 67 01 00 	mov    0x167aa(%rip),%rax        # 1beb8 <measured_retains>
    570e:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    5712:	f3 0f 7e 05 76 5d 01 	movq   0x15d76(%rip),%xmm0        # 1b490 <fwp_gc+0x1208>
    5719:	00 
    571a:	66 0f d6 45 d0       	movq   %xmm0,-0x30(%rbp)
    571f:	4c 89 e7             	mov    %r12,%rdi
    5722:	e8 09 03 00 00       	call   5a30 <f0>
    5727:	49 83 fe 02          	cmp    $0x2,%r14
    572b:	77 13                	ja     5740 <main+0x380>
    572d:	f3 0f 7e 45 c8       	movq   -0x38(%rbp),%xmm0
    5732:	66 48 0f 7e c1       	movq   %xmm0,%rcx
    5737:	48 39 c8             	cmp    %rcx,%rax
    573a:	0f 85 92 00 00 00    	jne    57d2 <main+0x412>
    5740:	48 8b 0d 61 67 01 00 	mov    0x16761(%rip),%rcx        # 1bea8 <measured_calls>
    5747:	48 29 d9             	sub    %rbx,%rcx
    574a:	48 83 f9 02          	cmp    $0x2,%rcx
    574e:	0f 82 85 00 00 00    	jb     57d9 <main+0x419>
    5754:	f2 0f 10 05 34 5d 01 	movsd  0x15d34(%rip),%xmm0        # 1b490 <fwp_gc+0x1208>
    575b:	00 
    575c:	f2 0f 10 4d d0       	movsd  -0x30(%rbp),%xmm1
    5761:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
    5765:	73 79                	jae    57e0 <main+0x420>
    5767:	4c 8b 05 42 67 01 00 	mov    0x16742(%rip),%r8        # 1beb0 <measured_bytes>
    576e:	4c 2b 45 c0          	sub    -0x40(%rbp),%r8
    5772:	4c 8b 0d 3f 67 01 00 	mov    0x1673f(%rip),%r9        # 1beb8 <measured_retains>
    5779:	4c 2b 4d b8          	sub    -0x48(%rbp),%r9
    577d:	4d 85 f6             	test   %r14,%r14
    5780:	48 8d 35 48 02 01 00 	lea    0x10248(%rip),%rsi        # 159cf <exec_in_fp0+0x15f>
    5787:	48 8d 15 47 0a 01 00 	lea    0x10a47(%rip),%rdx        # 161d5 <exec_in_fp0+0x965>
    578e:	48 0f 44 f2          	cmove  %rdx,%rsi
    5792:	f2 0f 5c c1          	subsd  %xmm1,%xmm0
    5796:	48 89 04 24          	mov    %rax,(%rsp)
    579a:	48 8d 3d b2 01 01 00 	lea    0x101b2(%rip),%rdi        # 15953 <exec_in_fp0+0xe3>
    57a1:	4c 89 fa             	mov    %r15,%rdx
    57a4:	b0 01                	mov    $0x1,%al
    57a6:	e8 15 da ff ff       	call   31c0 <printf@plt>
    57ab:	49 ff c6             	inc    %r14
    57ae:	49 83 fe 05          	cmp    $0x5,%r14
    57b2:	48 bb c5 4e ec c4 4e 	movabs $0x4ec4ec4ec4ec4ec5,%rbx
    57b9:	ec c4 4e 
    57bc:	0f 85 2e fd ff ff    	jne    54f0 <main+0x130>
    57c2:	48 8d 3d 09 02 01 00 	lea    0x10209(%rip),%rdi        # 159d2 <exec_in_fp0+0x162>
    57c9:	e8 02 d9 ff ff       	call   30d0 <puts@plt>
    57ce:	31 c0                	xor    %eax,%eax
    57d0:	eb 13                	jmp    57e5 <main+0x425>
    57d2:	b8 aa 00 00 00       	mov    $0xaa,%eax
    57d7:	eb 0c                	jmp    57e5 <main+0x425>
    57d9:	b8 ac 00 00 00       	mov    $0xac,%eax
    57de:	eb 05                	jmp    57e5 <main+0x425>
    57e0:	b8 ad 00 00 00       	mov    $0xad,%eax
    57e5:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    57ec:	5b                   	pop    %rbx
    57ed:	41 5c                	pop    %r12
    57ef:	41 5d                	pop    %r13
    57f1:	41 5e                	pop    %r14
    57f3:	41 5f                	pop    %r15
    57f5:	5d                   	pop    %rbp
    57f6:	c3                   	ret
    57f7:	e8 f4 13 00 00       	call   6bf0 <fwp_flush>
    57fc:	48 8b 05 d5 47 01 00 	mov    0x147d5(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    5803:	48 8b 38             	mov    (%rax),%rdi
    5806:	48 8d 35 8c 02 01 00 	lea    0x1028c(%rip),%rsi        # 15a99 <exec_in_fp0+0x229>
    580d:	48 8d 15 cd 11 01 00 	lea    0x111cd(%rip),%rdx        # 169e1 <exec_in_fp0+0x1171>
    5814:	31 c0                	xor    %eax,%eax
    5816:	e8 d5 da ff ff       	call   32f0 <fprintf@plt>
    581b:	bf 65 00 00 00       	mov    $0x65,%edi
    5820:	e8 3b dc ff ff       	call   3460 <exit@plt>
    5825:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    582c:	00 00 00 00 

0000000000005830 <fwp_array_new_packed>:
    5830:	41 56                	push   %r14
    5832:	53                   	push   %rbx
    5833:	50                   	push   %rax
    5834:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    583b:	ff ff 1f 
    583e:	48 39 c7             	cmp    %rax,%rdi
    5841:	0f 83 b7 01 00 00    	jae    59fe <fwp_array_new_packed+0x1ce>
    5847:	48 89 fb             	mov    %rdi,%rbx
    584a:	48 85 f6             	test   %rsi,%rsi
    584d:	74 23                	je     5872 <fwp_array_new_packed+0x42>
    584f:	8b 06                	mov    (%rsi),%eax
    5851:	48 83 f8 0a          	cmp    $0xa,%rax
    5855:	77 0e                	ja     5865 <fwp_array_new_packed+0x35>
    5857:	b9 e7 04 00 00       	mov    $0x4e7,%ecx
    585c:	0f a3 c1             	bt     %eax,%ecx
    585f:	0f 82 a1 00 00 00    	jb     5906 <fwp_array_new_packed+0xd6>
    5865:	48 8d 0c dd 00 00 00 	lea    0x0(,%rbx,8),%rcx
    586c:	00 
    586d:	e9 a3 00 00 00       	jmp    5915 <fwp_array_new_packed+0xe5>
    5872:	48 8d 14 dd 08 00 00 	lea    0x8(,%rbx,8),%rdx
    5879:	00 
    587a:	48 ff 05 27 66 01 00 	incq   0x16627(%rip)        # 1bea8 <measured_calls>
    5881:	48 01 15 28 66 01 00 	add    %rdx,0x16628(%rip)        # 1beb0 <measured_bytes>
    5888:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    588f:	77 68                	ja     58f9 <fwp_array_new_packed+0xc9>
    5891:	48 8d 42 0f          	lea    0xf(%rdx),%rax
    5895:	48 c1 e8 04          	shr    $0x4,%rax
    5899:	48 8d 0d e8 49 01 00 	lea    0x149e8(%rip),%rcx        # 1a288 <fwp_gc>
    58a0:	0f b6 b4 08 e8 0b 00 	movzbl 0xbe8(%rax,%rcx,1),%esi
    58a7:	00 
    58a8:	8b 84 b1 48 0b 00 00 	mov    0xb48(%rcx,%rsi,4),%eax
    58af:	48 29 05 d2 49 01 00 	sub    %rax,0x149d2(%rip)        # 1a288 <fwp_gc>
    58b6:	78 41                	js     58f9 <fwp_array_new_packed+0xc9>
    58b8:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    58bc:	48 8d 3c f1          	lea    (%rcx,%rsi,8),%rdi
    58c0:	48 81 c7 88 07 00 00 	add    $0x788,%rdi
    58c7:	4c 8b 37             	mov    (%rdi),%r14
    58ca:	4d 85 f6             	test   %r14,%r14
    58cd:	74 0e                	je     58dd <fwp_array_new_packed+0xad>
    58cf:	49 8b 0e             	mov    (%r14),%rcx
    58d2:	48 f7 d1             	not    %rcx
    58d5:	48 89 0f             	mov    %rcx,(%rdi)
    58d8:	e9 06 01 00 00       	jmp    59e3 <fwp_array_new_packed+0x1b3>
    58dd:	4c 8b b4 f1 90 07 00 	mov    0x790(%rcx,%rsi,8),%r14
    58e4:	00 
    58e5:	48 8b bc f1 98 07 00 	mov    0x798(%rcx,%rsi,8),%rdi
    58ec:	00 
    58ed:	4c 29 f7             	sub    %r14,%rdi
    58f0:	48 39 c7             	cmp    %rax,%rdi
    58f3:	0f 83 d8 00 00 00    	jae    59d1 <fwp_array_new_packed+0x1a1>
    58f9:	48 89 d7             	mov    %rdx,%rdi
    58fc:	be 02 00 00 00       	mov    $0x2,%esi
    5901:	e9 aa 00 00 00       	jmp    59b0 <fwp_array_new_packed+0x180>
    5906:	48 8d 0d 8b ff 00 00 	lea    0xff8b(%rip),%rcx        # 15898 <exec_in_fp0+0x28>
    590d:	48 8b 0c c1          	mov    (%rcx,%rax,8),%rcx
    5911:	48 0f af cb          	imul   %rbx,%rcx
    5915:	48 8d 51 08          	lea    0x8(%rcx),%rdx
    5919:	83 f8 0b             	cmp    $0xb,%eax
    591c:	0f 87 58 ff ff ff    	ja     587a <fwp_array_new_packed+0x4a>
    5922:	be ef 0d 00 00       	mov    $0xdef,%esi
    5927:	0f a3 c6             	bt     %eax,%esi
    592a:	0f 83 4a ff ff ff    	jae    587a <fwp_array_new_packed+0x4a>
    5930:	48 ff 05 71 65 01 00 	incq   0x16571(%rip)        # 1bea8 <measured_calls>
    5937:	48 01 15 72 65 01 00 	add    %rdx,0x16572(%rip)        # 1beb0 <measured_bytes>
    593e:	48 81 f9 f8 3f 00 00 	cmp    $0x3ff8,%rcx
    5945:	77 61                	ja     59a8 <fwp_array_new_packed+0x178>
    5947:	48 83 c1 17          	add    $0x17,%rcx
    594b:	48 c1 e9 04          	shr    $0x4,%rcx
    594f:	48 8d 05 32 49 01 00 	lea    0x14932(%rip),%rax        # 1a288 <fwp_gc>
    5956:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    595d:	00 
    595e:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    5965:	48 29 0d 1c 49 01 00 	sub    %rcx,0x1491c(%rip)        # 1a288 <fwp_gc>
    596c:	78 3a                	js     59a8 <fwp_array_new_packed+0x178>
    596e:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    5972:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    5976:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    597d:	4c 8b 37             	mov    (%rdi),%r14
    5980:	4d 85 f6             	test   %r14,%r14
    5983:	74 0b                	je     5990 <fwp_array_new_packed+0x160>
    5985:	49 8b 06             	mov    (%r14),%rax
    5988:	48 f7 d0             	not    %rax
    598b:	48 89 07             	mov    %rax,(%rdi)
    598e:	eb 3a                	jmp    59ca <fwp_array_new_packed+0x19a>
    5990:	4c 8b b4 f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r14
    5997:	00 
    5998:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    599f:	00 
    59a0:	4c 29 f7             	sub    %r14,%rdi
    59a3:	48 39 cf             	cmp    %rcx,%rdi
    59a6:	73 12                	jae    59ba <fwp_array_new_packed+0x18a>
    59a8:	48 89 d7             	mov    %rdx,%rdi
    59ab:	be 01 00 00 00       	mov    $0x1,%esi
    59b0:	e8 0b 29 00 00       	call   82c0 <fwp_gc_alloc_slow>
    59b5:	49 89 c6             	mov    %rax,%r14
    59b8:	eb 36                	jmp    59f0 <fwp_array_new_packed+0x1c0>
    59ba:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    59be:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    59c4:	4c 01 f1             	add    %r14,%rcx
    59c7:	48 89 08             	mov    %rcx,(%rax)
    59ca:	4c 89 f7             	mov    %r14,%rdi
    59cd:	31 f6                	xor    %esi,%esi
    59cf:	eb 1a                	jmp    59eb <fwp_array_new_packed+0x1bb>
    59d1:	48 8d 0c f1          	lea    (%rcx,%rsi,8),%rcx
    59d5:	48 81 c1 90 07 00 00 	add    $0x790,%rcx
    59dc:	49 8d 14 06          	lea    (%r14,%rax,1),%rdx
    59e0:	48 89 11             	mov    %rdx,(%rcx)
    59e3:	4c 89 f7             	mov    %r14,%rdi
    59e6:	31 f6                	xor    %esi,%esi
    59e8:	48 89 c2             	mov    %rax,%rdx
    59eb:	e8 20 d8 ff ff       	call   3210 <memset@plt>
    59f0:	49 89 1e             	mov    %rbx,(%r14)
    59f3:	4c 89 f0             	mov    %r14,%rax
    59f6:	48 83 c4 08          	add    $0x8,%rsp
    59fa:	5b                   	pop    %rbx
    59fb:	41 5e                	pop    %r14
    59fd:	c3                   	ret
    59fe:	e8 ed 11 00 00       	call   6bf0 <fwp_flush>
    5a03:	48 8b 05 ce 45 01 00 	mov    0x145ce(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    5a0a:	48 8b 38             	mov    (%rax),%rdi
    5a0d:	48 8d 35 85 00 01 00 	lea    0x10085(%rip),%rsi        # 15a99 <exec_in_fp0+0x229>
    5a14:	48 8d 15 8d 00 01 00 	lea    0x1008d(%rip),%rdx        # 15aa8 <exec_in_fp0+0x238>
    5a1b:	31 c0                	xor    %eax,%eax
    5a1d:	e8 ce d8 ff ff       	call   32f0 <fprintf@plt>
    5a22:	bf 65 00 00 00       	mov    $0x65,%edi
    5a27:	e8 34 da ff ff       	call   3460 <exit@plt>
    5a2c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000005a30 <f0>:
    5a30:	55                   	push   %rbp
    5a31:	41 57                	push   %r15
    5a33:	41 56                	push   %r14
    5a35:	41 55                	push   %r13
    5a37:	41 54                	push   %r12
    5a39:	53                   	push   %rbx
    5a3a:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    5a41:	48 89 fb             	mov    %rdi,%rbx
    5a44:	0f 10 05 25 f7 00 00 	movups 0xf725(%rip),%xmm0        # 15170 <_IO_stdin_used+0x170>
    5a4b:	0f 29 44 24 70       	movaps %xmm0,0x70(%rsp)
    5a50:	0f 10 05 29 f7 00 00 	movups 0xf729(%rip),%xmm0        # 15180 <_IO_stdin_used+0x180>
    5a57:	0f 29 44 24 60       	movaps %xmm0,0x60(%rsp)
    5a5c:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
    5a61:	48 8b 05 58 64 01 00 	mov    0x16458(%rip),%rax        # 1bec0 <fwp_cleanups>
    5a68:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
    5a6d:	48 8d 05 5c e3 00 00 	lea    0xe35c(%rip),%rax        # 13dd0 <fwp_owner_release0>
    5a74:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    5a79:	48 8d 44 24 28       	lea    0x28(%rsp),%rax
    5a7e:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
    5a83:	4c 8d 7c 24 48       	lea    0x48(%rsp),%r15
    5a88:	4c 89 3d 31 64 01 00 	mov    %r15,0x16431(%rip)        # 1bec0 <fwp_cleanups>
    5a8f:	48 8d 0d ea 62 01 00 	lea    0x162ea(%rip),%rcx        # 1bd80 <d2>
    5a96:	48 8d 7c 24 60       	lea    0x60(%rsp),%rdi
    5a9b:	48 89 de             	mov    %rbx,%rsi
    5a9e:	48 89 ca             	mov    %rcx,%rdx
    5aa1:	e8 8a 12 00 00       	call   6d30 <fwp_p_array_map_typed>
    5aa6:	4c 39 3d 13 64 01 00 	cmp    %r15,0x16413(%rip)        # 1bec0 <fwp_cleanups>
    5aad:	0f 85 f6 01 00 00    	jne    5ca9 <f0+0x279>
    5ab3:	49 89 c6             	mov    %rax,%r14
    5ab6:	48 8b 44 24 48       	mov    0x48(%rsp),%rax
    5abb:	48 89 05 fe 63 01 00 	mov    %rax,0x163fe(%rip)        # 1bec0 <fwp_cleanups>
    5ac2:	48 8d 44 24 60       	lea    0x60(%rsp),%rax
    5ac7:	48 89 df             	mov    %rbx,%rdi
    5aca:	e8 11 e3 00 00       	call   13de0 <fwp_drop0>
    5acf:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    5ad4:	48 8b 05 e5 63 01 00 	mov    0x163e5(%rip),%rax        # 1bec0 <fwp_cleanups>
    5adb:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    5ae0:	48 8d 05 d9 e3 00 00 	lea    0xe3d9(%rip),%rax        # 13ec0 <fwp_owner_release1>
    5ae7:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    5aec:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    5af1:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    5af6:	4c 8d 7c 24 30       	lea    0x30(%rsp),%r15
    5afb:	4c 89 3d be 63 01 00 	mov    %r15,0x163be(%rip)        # 1bec0 <fwp_cleanups>
    5b02:	48 8d 0d 77 62 01 00 	lea    0x16277(%rip),%rcx        # 1bd80 <d2>
    5b09:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    5b0e:	4c 89 f6             	mov    %r14,%rsi
    5b11:	48 89 ca             	mov    %rcx,%rdx
    5b14:	e8 17 12 00 00       	call   6d30 <fwp_p_array_map_typed>
    5b19:	4c 39 3d a0 63 01 00 	cmp    %r15,0x163a0(%rip)        # 1bec0 <fwp_cleanups>
    5b20:	0f 85 83 01 00 00    	jne    5ca9 <f0+0x279>
    5b26:	48 89 c3             	mov    %rax,%rbx
    5b29:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
    5b30:	ff ff 7f 
    5b33:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    5b38:	48 89 05 81 63 01 00 	mov    %rax,0x16381(%rip)        # 1bec0 <fwp_cleanups>
    5b3f:	48 8d 44 24 70       	lea    0x70(%rsp),%rax
    5b44:	4c 89 f7             	mov    %r14,%rdi
    5b47:	e8 94 e2 00 00       	call   13de0 <fwp_drop0>
    5b4c:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    5b51:	48 8b 05 68 63 01 00 	mov    0x16368(%rip),%rax        # 1bec0 <fwp_cleanups>
    5b58:	48 89 04 24          	mov    %rax,(%rsp)
    5b5c:	48 8d 05 6d e3 00 00 	lea    0xe36d(%rip),%rax        # 13ed0 <fwp_owner_release2>
    5b63:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    5b68:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
    5b6d:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    5b72:	48 89 e0             	mov    %rsp,%rax
    5b75:	48 89 05 44 63 01 00 	mov    %rax,0x16344(%rip)        # 1bec0 <fwp_cleanups>
    5b7c:	48 8b 0b             	mov    (%rbx),%rcx
    5b7f:	48 8d 04 4d 00 00 00 	lea    0x0(,%rcx,2),%rax
    5b86:	00 
    5b87:	48 85 c0             	test   %rax,%rax
    5b8a:	0f 84 ce 00 00 00    	je     5c5e <f0+0x22e>
    5b90:	48 89 dd             	mov    %rbx,%rbp
    5b93:	48 83 c5 08          	add    $0x8,%rbp
    5b97:	49 8d 44 24 01       	lea    0x1(%r12),%rax
    5b9c:	45 31 ed             	xor    %r13d,%r13d
    5b9f:	4c 8d 35 aa 62 01 00 	lea    0x162aa(%rip),%r14        # 1be50 <fc21>
    5ba6:	4c 8d bc 24 80 00 00 	lea    0x80(%rsp),%r15
    5bad:	00 
    5bae:	eb 3d                	jmp    5bed <f0+0x1bd>
    5bb0:	0f b7 0c 0e          	movzwl (%rsi,%rcx,1),%ecx
    5bb4:	83 f8 01             	cmp    $0x1,%eax
    5bb7:	48 0f bf c1          	movswq %cx,%rax
    5bbb:	48 0f 45 c1          	cmovne %rcx,%rax
    5bbf:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
    5bc6:	00 
    5bc7:	4c 89 f7             	mov    %r14,%rdi
    5bca:	be 02 00 00 00       	mov    $0x2,%esi
    5bcf:	4c 89 fa             	mov    %r15,%rdx
    5bd2:	b9 01 00 00 00       	mov    $0x1,%ecx
    5bd7:	e8 c4 13 00 00       	call   6fa0 <fwp_apply_borrowed_prefix>
    5bdc:	49 ff c5             	inc    %r13
    5bdf:	48 8b 0b             	mov    (%rbx),%rcx
    5be2:	48 89 ca             	mov    %rcx,%rdx
    5be5:	4c 21 e2             	and    %r12,%rdx
    5be8:	49 39 d5             	cmp    %rdx,%r13
    5beb:	73 77                	jae    5c64 <f0+0x234>
    5bed:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
    5bf4:	00 
    5bf5:	8b 05 85 61 01 00    	mov    0x16185(%rip),%eax        # 1bd80 <d2>
    5bfb:	ba 08 00 00 00       	mov    $0x8,%edx
    5c00:	48 83 f8 0a          	cmp    $0xa,%rax
    5c04:	77 0b                	ja     5c11 <f0+0x1e1>
    5c06:	48 8d 15 e3 fc 00 00 	lea    0xfce3(%rip),%rdx        # 158f0 <exec_in_fp0+0x80>
    5c0d:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
    5c11:	48 89 ee             	mov    %rbp,%rsi
    5c14:	48 85 c9             	test   %rcx,%rcx
    5c17:	79 04                	jns    5c1d <f0+0x1ed>
    5c19:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    5c1d:	48 89 d1             	mov    %rdx,%rcx
    5c20:	49 0f af cd          	imul   %r13,%rcx
    5c24:	48 83 fa 01          	cmp    $0x1,%rdx
    5c28:	74 16                	je     5c40 <f0+0x210>
    5c2a:	48 83 fa 02          	cmp    $0x2,%rdx
    5c2e:	74 80                	je     5bb0 <f0+0x180>
    5c30:	48 83 fa 08          	cmp    $0x8,%rdx
    5c34:	75 1a                	jne    5c50 <f0+0x220>
    5c36:	48 8b 04 0e          	mov    (%rsi,%rcx,1),%rax
    5c3a:	eb 83                	jmp    5bbf <f0+0x18f>
    5c3c:	0f 1f 40 00          	nopl   0x0(%rax)
    5c40:	0f b6 0c 0e          	movzbl (%rsi,%rcx,1),%ecx
    5c44:	48 85 c0             	test   %rax,%rax
    5c47:	48 0f be c1          	movsbq %cl,%rax
    5c4b:	e9 6b ff ff ff       	jmp    5bbb <f0+0x18b>
    5c50:	8b 0c 0e             	mov    (%rsi,%rcx,1),%ecx
    5c53:	83 f8 02             	cmp    $0x2,%eax
    5c56:	48 63 c1             	movslq %ecx,%rax
    5c59:	e9 5d ff ff ff       	jmp    5bbb <f0+0x18b>
    5c5e:	49 ff c4             	inc    %r12
    5c61:	4c 89 e0             	mov    %r12,%rax
    5c64:	49 89 c6             	mov    %rax,%r14
    5c67:	48 8d 05 e2 61 01 00 	lea    0x161e2(%rip),%rax        # 1be50 <fc21>
    5c6e:	48 89 e0             	mov    %rsp,%rax
    5c71:	48 39 05 48 62 01 00 	cmp    %rax,0x16248(%rip)        # 1bec0 <fwp_cleanups>
    5c78:	75 2f                	jne    5ca9 <f0+0x279>
    5c7a:	48 8b 04 24          	mov    (%rsp),%rax
    5c7e:	48 89 05 3b 62 01 00 	mov    %rax,0x1623b(%rip)        # 1bec0 <fwp_cleanups>
    5c85:	48 8d 05 c4 61 01 00 	lea    0x161c4(%rip),%rax        # 1be50 <fc21>
    5c8c:	48 89 df             	mov    %rbx,%rdi
    5c8f:	e8 4c e1 00 00       	call   13de0 <fwp_drop0>
    5c94:	4c 89 f0             	mov    %r14,%rax
    5c97:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    5c9e:	5b                   	pop    %rbx
    5c9f:	41 5c                	pop    %r12
    5ca1:	41 5d                	pop    %r13
    5ca3:	41 5e                	pop    %r14
    5ca5:	41 5f                	pop    %r15
    5ca7:	5d                   	pop    %rbp
    5ca8:	c3                   	ret
    5ca9:	e8 c2 d3 ff ff       	call   3070 <abort@plt>
    5cae:	66 90                	xchg   %ax,%ax

0000000000005cb0 <e0>:
    5cb0:	53                   	push   %rbx
    5cb1:	48 89 fb             	mov    %rdi,%rbx
    5cb4:	48 8b 3f             	mov    (%rdi),%rdi
    5cb7:	e8 54 0c 00 00       	call   6910 <fwp_rc_share>
    5cbc:	48 8b 3b             	mov    (%rbx),%rdi
    5cbf:	e8 6c fd ff ff       	call   5a30 <f0>
    5cc4:	48 89 c3             	mov    %rax,%rbx
    5cc7:	48 89 c7             	mov    %rax,%rdi
    5cca:	e8 41 0c 00 00       	call   6910 <fwp_rc_share>
    5ccf:	48 89 d8             	mov    %rbx,%rax
    5cd2:	5b                   	pop    %rbx
    5cd3:	c3                   	ret
    5cd4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    5cdb:	00 00 00 00 00 

0000000000005ce0 <e1>:
    5ce0:	55                   	push   %rbp
    5ce1:	41 57                	push   %r15
    5ce3:	41 56                	push   %r14
    5ce5:	41 55                	push   %r13
    5ce7:	41 54                	push   %r12
    5ce9:	53                   	push   %rbx
    5cea:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    5cf1:	48 89 fb             	mov    %rdi,%rbx
    5cf4:	48 8b 3f             	mov    (%rdi),%rdi
    5cf7:	e8 14 0c 00 00       	call   6910 <fwp_rc_share>
    5cfc:	48 8b 1b             	mov    (%rbx),%rbx
    5cff:	0f 10 05 3a f4 00 00 	movups 0xf43a(%rip),%xmm0        # 15140 <_IO_stdin_used+0x140>
    5d06:	0f 29 44 24 70       	movaps %xmm0,0x70(%rsp)
    5d0b:	0f 10 05 3e f4 00 00 	movups 0xf43e(%rip),%xmm0        # 15150 <_IO_stdin_used+0x150>
    5d12:	0f 29 44 24 60       	movaps %xmm0,0x60(%rsp)
    5d17:	48 89 5c 24 28       	mov    %rbx,0x28(%rsp)
    5d1c:	48 8b 05 9d 61 01 00 	mov    0x1619d(%rip),%rax        # 1bec0 <fwp_cleanups>
    5d23:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
    5d28:	48 8d 05 f1 0e 00 00 	lea    0xef1(%rip),%rax        # 6c20 <fwp_owner_release3>
    5d2f:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    5d34:	48 8d 44 24 28       	lea    0x28(%rsp),%rax
    5d39:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
    5d3e:	4c 8d 7c 24 48       	lea    0x48(%rsp),%r15
    5d43:	4c 89 3d 76 61 01 00 	mov    %r15,0x16176(%rip)        # 1bec0 <fwp_cleanups>
    5d4a:	48 8d 0d 5f 5f 01 00 	lea    0x15f5f(%rip),%rcx        # 1bcb0 <d1>
    5d51:	48 8d 7c 24 60       	lea    0x60(%rsp),%rdi
    5d56:	48 89 de             	mov    %rbx,%rsi
    5d59:	48 89 ca             	mov    %rcx,%rdx
    5d5c:	e8 cf 0f 00 00       	call   6d30 <fwp_p_array_map_typed>
    5d61:	4c 39 3d 58 61 01 00 	cmp    %r15,0x16158(%rip)        # 1bec0 <fwp_cleanups>
    5d68:	0f 85 02 02 00 00    	jne    5f70 <e1+0x290>
    5d6e:	49 89 c6             	mov    %rax,%r14
    5d71:	48 8b 44 24 48       	mov    0x48(%rsp),%rax
    5d76:	48 89 05 43 61 01 00 	mov    %rax,0x16143(%rip)        # 1bec0 <fwp_cleanups>
    5d7d:	48 8d 44 24 60       	lea    0x60(%rsp),%rax
    5d82:	48 89 df             	mov    %rbx,%rdi
    5d85:	e8 a6 0e 00 00       	call   6c30 <fwp_drop1>
    5d8a:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    5d8f:	48 8b 05 2a 61 01 00 	mov    0x1612a(%rip),%rax        # 1bec0 <fwp_cleanups>
    5d96:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    5d9b:	48 8d 05 6e 0f 00 00 	lea    0xf6e(%rip),%rax        # 6d10 <fwp_owner_release4>
    5da2:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    5da7:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    5dac:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    5db1:	4c 8d 7c 24 30       	lea    0x30(%rsp),%r15
    5db6:	4c 89 3d 03 61 01 00 	mov    %r15,0x16103(%rip)        # 1bec0 <fwp_cleanups>
    5dbd:	48 8d 0d ec 5e 01 00 	lea    0x15eec(%rip),%rcx        # 1bcb0 <d1>
    5dc4:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    5dc9:	4c 89 f6             	mov    %r14,%rsi
    5dcc:	48 89 ca             	mov    %rcx,%rdx
    5dcf:	e8 5c 0f 00 00       	call   6d30 <fwp_p_array_map_typed>
    5dd4:	4c 39 3d e5 60 01 00 	cmp    %r15,0x160e5(%rip)        # 1bec0 <fwp_cleanups>
    5ddb:	0f 85 8f 01 00 00    	jne    5f70 <e1+0x290>
    5de1:	48 89 c3             	mov    %rax,%rbx
    5de4:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    5de9:	48 89 05 d0 60 01 00 	mov    %rax,0x160d0(%rip)        # 1bec0 <fwp_cleanups>
    5df0:	48 8d 44 24 70       	lea    0x70(%rsp),%rax
    5df5:	4c 89 f7             	mov    %r14,%rdi
    5df8:	e8 33 0e 00 00       	call   6c30 <fwp_drop1>
    5dfd:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    5e02:	48 8b 05 b7 60 01 00 	mov    0x160b7(%rip),%rax        # 1bec0 <fwp_cleanups>
    5e09:	48 89 04 24          	mov    %rax,(%rsp)
    5e0d:	48 8d 05 0c 0f 00 00 	lea    0xf0c(%rip),%rax        # 6d20 <fwp_owner_release5>
    5e14:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    5e19:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
    5e1e:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    5e23:	48 89 e2             	mov    %rsp,%rdx
    5e26:	48 89 15 93 60 01 00 	mov    %rdx,0x16093(%rip)        # 1bec0 <fwp_cleanups>
    5e2d:	48 8b 0b             	mov    (%rbx),%rcx
    5e30:	48 8d 04 4d 00 00 00 	lea    0x0(,%rcx,2),%rax
    5e37:	00 
    5e38:	48 85 c0             	test   %rax,%rax
    5e3b:	0f 84 e5 00 00 00    	je     5f26 <e1+0x246>
    5e41:	49 bd ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r13
    5e48:	ff ff 7f 
    5e4b:	48 89 dd             	mov    %rbx,%rbp
    5e4e:	48 83 c5 08          	add    $0x8,%rbp
    5e52:	45 31 e4             	xor    %r12d,%r12d
    5e55:	4c 8d 35 4c 5e 01 00 	lea    0x15e4c(%rip),%r14        # 1bca8 <fc13>
    5e5c:	4c 8d bc 24 80 00 00 	lea    0x80(%rsp),%r15
    5e63:	00 
    5e64:	31 c0                	xor    %eax,%eax
    5e66:	eb 45                	jmp    5ead <e1+0x1cd>
    5e68:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    5e6f:	00 
    5e70:	0f b7 0c 0e          	movzwl (%rsi,%rcx,1),%ecx
    5e74:	83 f8 01             	cmp    $0x1,%eax
    5e77:	48 0f bf c1          	movswq %cx,%rax
    5e7b:	48 0f 45 c1          	cmovne %rcx,%rax
    5e7f:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
    5e86:	00 
    5e87:	4c 89 f7             	mov    %r14,%rdi
    5e8a:	be 02 00 00 00       	mov    $0x2,%esi
    5e8f:	4c 89 fa             	mov    %r15,%rdx
    5e92:	b9 01 00 00 00       	mov    $0x1,%ecx
    5e97:	e8 04 11 00 00       	call   6fa0 <fwp_apply_borrowed_prefix>
    5e9c:	49 ff c4             	inc    %r12
    5e9f:	48 8b 0b             	mov    (%rbx),%rcx
    5ea2:	48 89 ca             	mov    %rcx,%rdx
    5ea5:	4c 21 ea             	and    %r13,%rdx
    5ea8:	49 39 d4             	cmp    %rdx,%r12
    5eab:	73 71                	jae    5f1e <e1+0x23e>
    5ead:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
    5eb4:	00 
    5eb5:	8b 05 f5 5d 01 00    	mov    0x15df5(%rip),%eax        # 1bcb0 <d1>
    5ebb:	ba 08 00 00 00       	mov    $0x8,%edx
    5ec0:	48 83 f8 0a          	cmp    $0xa,%rax
    5ec4:	77 0b                	ja     5ed1 <e1+0x1f1>
    5ec6:	48 8d 15 23 fa 00 00 	lea    0xfa23(%rip),%rdx        # 158f0 <exec_in_fp0+0x80>
    5ecd:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
    5ed1:	48 89 ee             	mov    %rbp,%rsi
    5ed4:	48 85 c9             	test   %rcx,%rcx
    5ed7:	79 04                	jns    5edd <e1+0x1fd>
    5ed9:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    5edd:	48 89 d1             	mov    %rdx,%rcx
    5ee0:	49 0f af cc          	imul   %r12,%rcx
    5ee4:	48 83 fa 01          	cmp    $0x1,%rdx
    5ee8:	74 16                	je     5f00 <e1+0x220>
    5eea:	48 83 fa 02          	cmp    $0x2,%rdx
    5eee:	74 80                	je     5e70 <e1+0x190>
    5ef0:	48 83 fa 08          	cmp    $0x8,%rdx
    5ef4:	75 1a                	jne    5f10 <e1+0x230>
    5ef6:	48 8b 04 0e          	mov    (%rsi,%rcx,1),%rax
    5efa:	eb 83                	jmp    5e7f <e1+0x19f>
    5efc:	0f 1f 40 00          	nopl   0x0(%rax)
    5f00:	0f b6 0c 0e          	movzbl (%rsi,%rcx,1),%ecx
    5f04:	48 85 c0             	test   %rax,%rax
    5f07:	48 0f be c1          	movsbq %cl,%rax
    5f0b:	e9 6b ff ff ff       	jmp    5e7b <e1+0x19b>
    5f10:	8b 0c 0e             	mov    (%rsi,%rcx,1),%ecx
    5f13:	83 f8 02             	cmp    $0x2,%eax
    5f16:	48 63 c1             	movslq %ecx,%rax
    5f19:	e9 5d ff ff ff       	jmp    5e7b <e1+0x19b>
    5f1e:	41 89 c6             	mov    %eax,%r14d
    5f21:	48 89 e2             	mov    %rsp,%rdx
    5f24:	eb 03                	jmp    5f29 <e1+0x249>
    5f26:	45 31 f6             	xor    %r14d,%r14d
    5f29:	48 8d 05 78 5d 01 00 	lea    0x15d78(%rip),%rax        # 1bca8 <fc13>
    5f30:	48 39 15 89 5f 01 00 	cmp    %rdx,0x15f89(%rip)        # 1bec0 <fwp_cleanups>
    5f37:	75 37                	jne    5f70 <e1+0x290>
    5f39:	48 8b 04 24          	mov    (%rsp),%rax
    5f3d:	48 89 05 7c 5f 01 00 	mov    %rax,0x15f7c(%rip)        # 1bec0 <fwp_cleanups>
    5f44:	48 8d 05 5d 5d 01 00 	lea    0x15d5d(%rip),%rax        # 1bca8 <fc13>
    5f4b:	48 89 df             	mov    %rbx,%rdi
    5f4e:	e8 dd 0c 00 00       	call   6c30 <fwp_drop1>
    5f53:	4c 89 f7             	mov    %r14,%rdi
    5f56:	e8 b5 09 00 00       	call   6910 <fwp_rc_share>
    5f5b:	4c 89 f0             	mov    %r14,%rax
    5f5e:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    5f65:	5b                   	pop    %rbx
    5f66:	41 5c                	pop    %r12
    5f68:	41 5d                	pop    %r13
    5f6a:	41 5e                	pop    %r14
    5f6c:	41 5f                	pop    %r15
    5f6e:	5d                   	pop    %rbp
    5f6f:	c3                   	ret
    5f70:	e8 fb d0 ff ff       	call   3070 <abort@plt>
    5f75:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    5f7c:	00 00 00 00 

0000000000005f80 <e2>:
    5f80:	41 57                	push   %r15
    5f82:	41 56                	push   %r14
    5f84:	53                   	push   %rbx
    5f85:	48 83 ec 60          	sub    $0x60,%rsp
    5f89:	48 89 fb             	mov    %rdi,%rbx
    5f8c:	48 8b 3f             	mov    (%rdi),%rdi
    5f8f:	e8 7c 09 00 00       	call   6910 <fwp_rc_share>
    5f94:	48 8b 1b             	mov    (%rbx),%rbx
    5f97:	0f 10 05 c2 f1 00 00 	movups 0xf1c2(%rip),%xmm0        # 15160 <_IO_stdin_used+0x160>
    5f9e:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    5fa3:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
    5fa8:	48 8b 05 11 5f 01 00 	mov    0x15f11(%rip),%rax        # 1bec0 <fwp_cleanups>
    5faf:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    5fb4:	48 8d 05 c5 4e 00 00 	lea    0x4ec5(%rip),%rax        # ae80 <fwp_owner_release6>
    5fbb:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    5fc0:	48 8d 44 24 10       	lea    0x10(%rsp),%rax
    5fc5:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    5fca:	4c 8d 7c 24 18       	lea    0x18(%rsp),%r15
    5fcf:	4c 89 3d ea 5e 01 00 	mov    %r15,0x15eea(%rip)        # 1bec0 <fwp_cleanups>
    5fd6:	48 8d 0d 3b 5d 01 00 	lea    0x15d3b(%rip),%rcx        # 1bd18 <d0>
    5fdd:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    5fe2:	48 89 de             	mov    %rbx,%rsi
    5fe5:	48 89 ca             	mov    %rcx,%rdx
    5fe8:	e8 43 0d 00 00       	call   6d30 <fwp_p_array_map_typed>
    5fed:	4c 39 3d cc 5e 01 00 	cmp    %r15,0x15ecc(%rip)        # 1bec0 <fwp_cleanups>
    5ff4:	0f 85 80 00 00 00    	jne    607a <e2+0xfa>
    5ffa:	49 89 c6             	mov    %rax,%r14
    5ffd:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    6002:	48 89 05 b7 5e 01 00 	mov    %rax,0x15eb7(%rip)        # 1bec0 <fwp_cleanups>
    6009:	48 8d 44 24 30       	lea    0x30(%rsp),%rax
    600e:	48 89 df             	mov    %rbx,%rdi
    6011:	e8 7a 4e 00 00       	call   ae90 <fwp_drop2>
    6016:	4c 89 74 24 08       	mov    %r14,0x8(%rsp)
    601b:	48 8b 05 9e 5e 01 00 	mov    0x15e9e(%rip),%rax        # 1bec0 <fwp_cleanups>
    6022:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
    6027:	48 8d 0d 42 4f 00 00 	lea    0x4f42(%rip),%rcx        # af70 <fwp_owner_release7>
    602e:	48 89 4c 24 50       	mov    %rcx,0x50(%rsp)
    6033:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    6038:	48 89 4c 24 58       	mov    %rcx,0x58(%rsp)
    603d:	48 8d 4c 24 48       	lea    0x48(%rsp),%rcx
    6042:	48 89 0d 77 5e 01 00 	mov    %rcx,0x15e77(%rip)        # 1bec0 <fwp_cleanups>
    6049:	48 bb ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rbx
    6050:	ff ff 7f 
    6053:	49 23 1e             	and    (%r14),%rbx
    6056:	48 89 05 63 5e 01 00 	mov    %rax,0x15e63(%rip)        # 1bec0 <fwp_cleanups>
    605d:	4c 89 f7             	mov    %r14,%rdi
    6060:	e8 2b 4e 00 00       	call   ae90 <fwp_drop2>
    6065:	48 89 df             	mov    %rbx,%rdi
    6068:	e8 a3 08 00 00       	call   6910 <fwp_rc_share>
    606d:	48 89 d8             	mov    %rbx,%rax
    6070:	48 83 c4 60          	add    $0x60,%rsp
    6074:	5b                   	pop    %rbx
    6075:	41 5e                	pop    %r14
    6077:	41 5f                	pop    %r15
    6079:	c3                   	ret
    607a:	e8 f1 cf ff ff       	call   3070 <abort@plt>
    607f:	90                   	nop

0000000000006080 <e3>:
    6080:	55                   	push   %rbp
    6081:	41 57                	push   %r15
    6083:	41 56                	push   %r14
    6085:	41 55                	push   %r13
    6087:	41 54                	push   %r12
    6089:	53                   	push   %rbx
    608a:	48 83 ec 68          	sub    $0x68,%rsp
    608e:	48 89 fb             	mov    %rdi,%rbx
    6091:	48 8b 3f             	mov    (%rdi),%rdi
    6094:	e8 77 08 00 00       	call   6910 <fwp_rc_share>
    6099:	4c 8b 33             	mov    (%rbx),%r14
    609c:	0f 10 05 bd f0 00 00 	movups 0xf0bd(%rip),%xmm0        # 15160 <_IO_stdin_used+0x160>
    60a3:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    60a8:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    60ad:	48 8b 05 0c 5e 01 00 	mov    0x15e0c(%rip),%rax        # 1bec0 <fwp_cleanups>
    60b4:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    60b9:	48 8d 05 c0 4e 00 00 	lea    0x4ec0(%rip),%rax        # af80 <fwp_owner_release8>
    60c0:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    60c5:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    60ca:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    60cf:	4c 8d 7c 24 28       	lea    0x28(%rsp),%r15
    60d4:	4c 89 3d e5 5d 01 00 	mov    %r15,0x15de5(%rip)        # 1bec0 <fwp_cleanups>
    60db:	48 8d 0d 36 5c 01 00 	lea    0x15c36(%rip),%rcx        # 1bd18 <d0>
    60e2:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
    60e7:	4c 89 f6             	mov    %r14,%rsi
    60ea:	48 89 ca             	mov    %rcx,%rdx
    60ed:	e8 3e 0c 00 00       	call   6d30 <fwp_p_array_map_typed>
    60f2:	4c 39 3d c7 5d 01 00 	cmp    %r15,0x15dc7(%rip)        # 1bec0 <fwp_cleanups>
    60f9:	0f 85 8f 01 00 00    	jne    628e <e3+0x20e>
    60ff:	48 89 c3             	mov    %rax,%rbx
    6102:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    6107:	48 89 05 b2 5d 01 00 	mov    %rax,0x15db2(%rip)        # 1bec0 <fwp_cleanups>
    610e:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
    6113:	4c 89 f7             	mov    %r14,%rdi
    6116:	e8 75 4d 00 00       	call   ae90 <fwp_drop2>
    611b:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    6120:	48 8b 05 99 5d 01 00 	mov    0x15d99(%rip),%rax        # 1bec0 <fwp_cleanups>
    6127:	48 89 04 24          	mov    %rax,(%rsp)
    612b:	48 8d 05 5e 4e 00 00 	lea    0x4e5e(%rip),%rax        # af90 <fwp_owner_release9>
    6132:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    6137:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
    613c:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    6141:	48 89 e2             	mov    %rsp,%rdx
    6144:	48 89 15 75 5d 01 00 	mov    %rdx,0x15d75(%rip)        # 1bec0 <fwp_cleanups>
    614b:	48 8b 0b             	mov    (%rbx),%rcx
    614e:	48 8d 04 4d 00 00 00 	lea    0x0(,%rcx,2),%rax
    6155:	00 
    6156:	48 85 c0             	test   %rax,%rax
    6159:	0f 84 e8 00 00 00    	je     6247 <e3+0x1c7>
    615f:	49 bd ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r13
    6166:	ff ff 7f 
    6169:	48 89 dd             	mov    %rbx,%rbp
    616c:	48 83 c5 08          	add    $0x8,%rbp
    6170:	45 31 e4             	xor    %r12d,%r12d
    6173:	4c 8d 35 fe 5b 01 00 	lea    0x15bfe(%rip),%r14        # 1bd78 <fc5>
    617a:	4c 8d 7c 24 50       	lea    0x50(%rsp),%r15
    617f:	31 c0                	xor    %eax,%eax
    6181:	eb 47                	jmp    61ca <e3+0x14a>
    6183:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    618a:	84 00 00 00 00 00 
    6190:	0f b7 0c 0e          	movzwl (%rsi,%rcx,1),%ecx
    6194:	83 f8 01             	cmp    $0x1,%eax
    6197:	48 0f bf c1          	movswq %cx,%rax
    619b:	48 0f 45 c1          	cmovne %rcx,%rax
    619f:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
    61a4:	4c 89 f7             	mov    %r14,%rdi
    61a7:	be 02 00 00 00       	mov    $0x2,%esi
    61ac:	4c 89 fa             	mov    %r15,%rdx
    61af:	b9 01 00 00 00       	mov    $0x1,%ecx
    61b4:	e8 e7 0d 00 00       	call   6fa0 <fwp_apply_borrowed_prefix>
    61b9:	49 ff c4             	inc    %r12
    61bc:	48 8b 0b             	mov    (%rbx),%rcx
    61bf:	48 89 ca             	mov    %rcx,%rdx
    61c2:	4c 21 ea             	and    %r13,%rdx
    61c5:	49 39 d4             	cmp    %rdx,%r12
    61c8:	73 74                	jae    623e <e3+0x1be>
    61ca:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    61cf:	8b 05 43 5b 01 00    	mov    0x15b43(%rip),%eax        # 1bd18 <d0>
    61d5:	ba 08 00 00 00       	mov    $0x8,%edx
    61da:	48 83 f8 0a          	cmp    $0xa,%rax
    61de:	77 0b                	ja     61eb <e3+0x16b>
    61e0:	48 8d 15 09 f7 00 00 	lea    0xf709(%rip),%rdx        # 158f0 <exec_in_fp0+0x80>
    61e7:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
    61eb:	48 89 ee             	mov    %rbp,%rsi
    61ee:	48 85 c9             	test   %rcx,%rcx
    61f1:	79 04                	jns    61f7 <e3+0x177>
    61f3:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    61f7:	48 89 d1             	mov    %rdx,%rcx
    61fa:	49 0f af cc          	imul   %r12,%rcx
    61fe:	48 83 fa 01          	cmp    $0x1,%rdx
    6202:	74 1c                	je     6220 <e3+0x1a0>
    6204:	48 83 fa 02          	cmp    $0x2,%rdx
    6208:	74 86                	je     6190 <e3+0x110>
    620a:	48 83 fa 08          	cmp    $0x8,%rdx
    620e:	75 20                	jne    6230 <e3+0x1b0>
    6210:	48 8b 04 0e          	mov    (%rsi,%rcx,1),%rax
    6214:	eb 89                	jmp    619f <e3+0x11f>
    6216:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    621d:	00 00 00 
    6220:	0f b6 0c 0e          	movzbl (%rsi,%rcx,1),%ecx
    6224:	48 85 c0             	test   %rax,%rax
    6227:	48 0f be c1          	movsbq %cl,%rax
    622b:	e9 6b ff ff ff       	jmp    619b <e3+0x11b>
    6230:	8b 0c 0e             	mov    (%rsi,%rcx,1),%ecx
    6233:	83 f8 02             	cmp    $0x2,%eax
    6236:	48 63 c1             	movslq %ecx,%rax
    6239:	e9 5d ff ff ff       	jmp    619b <e3+0x11b>
    623e:	4c 0f be f0          	movsbq %al,%r14
    6242:	48 89 e2             	mov    %rsp,%rdx
    6245:	eb 03                	jmp    624a <e3+0x1ca>
    6247:	45 31 f6             	xor    %r14d,%r14d
    624a:	48 8d 05 27 5b 01 00 	lea    0x15b27(%rip),%rax        # 1bd78 <fc5>
    6251:	48 39 15 68 5c 01 00 	cmp    %rdx,0x15c68(%rip)        # 1bec0 <fwp_cleanups>
    6258:	75 34                	jne    628e <e3+0x20e>
    625a:	48 8b 04 24          	mov    (%rsp),%rax
    625e:	48 89 05 5b 5c 01 00 	mov    %rax,0x15c5b(%rip)        # 1bec0 <fwp_cleanups>
    6265:	48 8d 05 0c 5b 01 00 	lea    0x15b0c(%rip),%rax        # 1bd78 <fc5>
    626c:	48 89 df             	mov    %rbx,%rdi
    626f:	e8 1c 4c 00 00       	call   ae90 <fwp_drop2>
    6274:	4c 89 f7             	mov    %r14,%rdi
    6277:	e8 94 06 00 00       	call   6910 <fwp_rc_share>
    627c:	4c 89 f0             	mov    %r14,%rax
    627f:	48 83 c4 68          	add    $0x68,%rsp
    6283:	5b                   	pop    %rbx
    6284:	41 5c                	pop    %r12
    6286:	41 5d                	pop    %r13
    6288:	41 5e                	pop    %r14
    628a:	41 5f                	pop    %r15
    628c:	5d                   	pop    %rbp
    628d:	c3                   	ret
    628e:	e8 dd cd ff ff       	call   3070 <abort@plt>
    6293:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    629a:	84 00 00 00 00 00 

00000000000062a0 <e4>:
    62a0:	53                   	push   %rbx
    62a1:	48 89 fb             	mov    %rdi,%rbx
    62a4:	48 8b 3f             	mov    (%rdi),%rdi
    62a7:	e8 64 06 00 00       	call   6910 <fwp_rc_share>
    62ac:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    62b0:	e8 5b 06 00 00       	call   6910 <fwp_rc_share>
    62b5:	48 8b 3b             	mov    (%rbx),%rdi
    62b8:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    62bc:	48 8d 0d 55 5a 01 00 	lea    0x15a55(%rip),%rcx        # 1bd18 <d0>
    62c3:	48 89 ca             	mov    %rcx,%rdx
    62c6:	e8 65 0a 00 00       	call   6d30 <fwp_p_array_map_typed>
    62cb:	48 89 c3             	mov    %rax,%rbx
    62ce:	48 89 c7             	mov    %rax,%rdi
    62d1:	e8 3a 06 00 00       	call   6910 <fwp_rc_share>
    62d6:	48 89 d8             	mov    %rbx,%rax
    62d9:	5b                   	pop    %rbx
    62da:	c3                   	ret
    62db:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000062e0 <e5>:
    62e0:	53                   	push   %rbx
    62e1:	48 83 ec 60          	sub    $0x60,%rsp
    62e5:	48 0f be 07          	movsbq (%rdi),%rax
    62e9:	48 0f be 5f 08       	movsbq 0x8(%rdi),%rbx
    62ee:	48 01 c3             	add    %rax,%rbx
    62f1:	48 0f be c3          	movsbq %bl,%rax
    62f5:	48 39 d8             	cmp    %rbx,%rax
    62f8:	75 11                	jne    630b <e5+0x2b>
    62fa:	48 89 df             	mov    %rbx,%rdi
    62fd:	e8 0e 06 00 00       	call   6910 <fwp_rc_share>
    6302:	48 89 d8             	mov    %rbx,%rax
    6305:	48 83 c4 60          	add    $0x60,%rsp
    6309:	5b                   	pop    %rbx
    630a:	c3                   	ret
    630b:	48 8d 15 51 f9 00 00 	lea    0xf951(%rip),%rdx        # 15c63 <exec_in_fp0+0x3f3>
    6312:	48 8d 0d 47 f9 00 00 	lea    0xf947(%rip),%rcx        # 15c60 <exec_in_fp0+0x3f0>
    6319:	48 89 e3             	mov    %rsp,%rbx
    631c:	be 60 00 00 00       	mov    $0x60,%esi
    6321:	48 89 df             	mov    %rbx,%rdi
    6324:	31 c0                	xor    %eax,%eax
    6326:	e8 a5 ce ff ff       	call   31d0 <snprintf@plt>
    632b:	e8 c0 08 00 00       	call   6bf0 <fwp_flush>
    6330:	48 8b 05 a1 3c 01 00 	mov    0x13ca1(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    6337:	48 8b 38             	mov    (%rax),%rdi
    633a:	48 8d 35 58 f7 00 00 	lea    0xf758(%rip),%rsi        # 15a99 <exec_in_fp0+0x229>
    6341:	48 89 da             	mov    %rbx,%rdx
    6344:	31 c0                	xor    %eax,%eax
    6346:	e8 a5 cf ff ff       	call   32f0 <fprintf@plt>
    634b:	bf 65 00 00 00       	mov    $0x65,%edi
    6350:	e8 0b d1 ff ff       	call   3460 <exit@plt>
    6355:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    635c:	00 00 00 00 

0000000000006360 <e6>:
    6360:	55                   	push   %rbp
    6361:	41 57                	push   %r15
    6363:	41 56                	push   %r14
    6365:	41 55                	push   %r13
    6367:	41 54                	push   %r12
    6369:	53                   	push   %rbx
    636a:	48 83 ec 18          	sub    $0x18,%rsp
    636e:	49 89 fe             	mov    %rdi,%r14
    6371:	48 8b 3f             	mov    (%rdi),%rdi
    6374:	e8 97 05 00 00       	call   6910 <fwp_rc_share>
    6379:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    637d:	e8 8e 05 00 00       	call   6910 <fwp_rc_share>
    6382:	49 8b 1e             	mov    (%r14),%rbx
    6385:	49 8b 46 08          	mov    0x8(%r14),%rax
    6389:	4d 8b 7e 10          	mov    0x10(%r14),%r15
    638d:	49 8b 0f             	mov    (%r15),%rcx
    6390:	48 8d 14 4d 00 00 00 	lea    0x0(,%rcx,2),%rdx
    6397:	00 
    6398:	48 85 d2             	test   %rdx,%rdx
    639b:	0f 84 cd 00 00 00    	je     646e <e6+0x10e>
    63a1:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
    63a8:	ff ff 7f 
    63ab:	4d 8d 6f 08          	lea    0x8(%r15),%r13
    63af:	31 ed                	xor    %ebp,%ebp
    63b1:	49 89 e6             	mov    %rsp,%r14
    63b4:	eb 44                	jmp    63fa <e6+0x9a>
    63b6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    63bd:	00 00 00 
    63c0:	0f b7 0c 0e          	movzwl (%rsi,%rcx,1),%ecx
    63c4:	83 f8 01             	cmp    $0x1,%eax
    63c7:	48 0f bf c1          	movswq %cx,%rax
    63cb:	48 0f 45 c1          	cmovne %rcx,%rax
    63cf:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    63d4:	48 89 df             	mov    %rbx,%rdi
    63d7:	be 02 00 00 00       	mov    $0x2,%esi
    63dc:	4c 89 f2             	mov    %r14,%rdx
    63df:	b9 01 00 00 00       	mov    $0x1,%ecx
    63e4:	e8 b7 0b 00 00       	call   6fa0 <fwp_apply_borrowed_prefix>
    63e9:	48 ff c5             	inc    %rbp
    63ec:	49 8b 0f             	mov    (%r15),%rcx
    63ef:	48 89 ca             	mov    %rcx,%rdx
    63f2:	4c 21 e2             	and    %r12,%rdx
    63f5:	48 39 d5             	cmp    %rdx,%rbp
    63f8:	73 74                	jae    646e <e6+0x10e>
    63fa:	48 89 04 24          	mov    %rax,(%rsp)
    63fe:	8b 05 14 59 01 00    	mov    0x15914(%rip),%eax        # 1bd18 <d0>
    6404:	ba 08 00 00 00       	mov    $0x8,%edx
    6409:	48 83 f8 0a          	cmp    $0xa,%rax
    640d:	77 0b                	ja     641a <e6+0xba>
    640f:	48 8d 15 da f4 00 00 	lea    0xf4da(%rip),%rdx        # 158f0 <exec_in_fp0+0x80>
    6416:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
    641a:	4c 89 ee             	mov    %r13,%rsi
    641d:	48 85 c9             	test   %rcx,%rcx
    6420:	79 04                	jns    6426 <e6+0xc6>
    6422:	49 8b 77 10          	mov    0x10(%r15),%rsi
    6426:	48 89 d1             	mov    %rdx,%rcx
    6429:	48 0f af cd          	imul   %rbp,%rcx
    642d:	48 83 fa 01          	cmp    $0x1,%rdx
    6431:	74 1d                	je     6450 <e6+0xf0>
    6433:	48 83 fa 02          	cmp    $0x2,%rdx
    6437:	74 87                	je     63c0 <e6+0x60>
    6439:	48 83 fa 08          	cmp    $0x8,%rdx
    643d:	75 21                	jne    6460 <e6+0x100>
    643f:	48 8b 04 0e          	mov    (%rsi,%rcx,1),%rax
    6443:	eb 8a                	jmp    63cf <e6+0x6f>
    6445:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    644c:	00 00 00 00 
    6450:	0f b6 0c 0e          	movzbl (%rsi,%rcx,1),%ecx
    6454:	48 85 c0             	test   %rax,%rax
    6457:	48 0f be c1          	movsbq %cl,%rax
    645b:	e9 6b ff ff ff       	jmp    63cb <e6+0x6b>
    6460:	8b 0c 0e             	mov    (%rsi,%rcx,1),%ecx
    6463:	83 f8 02             	cmp    $0x2,%eax
    6466:	48 63 c1             	movslq %ecx,%rax
    6469:	e9 5d ff ff ff       	jmp    63cb <e6+0x6b>
    646e:	48 89 c7             	mov    %rax,%rdi
    6471:	48 89 c3             	mov    %rax,%rbx
    6474:	e8 97 04 00 00       	call   6910 <fwp_rc_share>
    6479:	48 89 d8             	mov    %rbx,%rax
    647c:	48 83 c4 18          	add    $0x18,%rsp
    6480:	5b                   	pop    %rbx
    6481:	41 5c                	pop    %r12
    6483:	41 5d                	pop    %r13
    6485:	41 5e                	pop    %r14
    6487:	41 5f                	pop    %r15
    6489:	5d                   	pop    %rbp
    648a:	c3                   	ret
    648b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006490 <e8>:
    6490:	53                   	push   %rbx
    6491:	48 83 ec 60          	sub    $0x60,%rsp
    6495:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    6499:	48 03 1f             	add    (%rdi),%rbx
    649c:	48 0f be c3          	movsbq %bl,%rax
    64a0:	48 39 d8             	cmp    %rbx,%rax
    64a3:	75 11                	jne    64b6 <e8+0x26>
    64a5:	48 89 df             	mov    %rbx,%rdi
    64a8:	e8 63 04 00 00       	call   6910 <fwp_rc_share>
    64ad:	48 89 d8             	mov    %rbx,%rax
    64b0:	48 83 c4 60          	add    $0x60,%rsp
    64b4:	5b                   	pop    %rbx
    64b5:	c3                   	ret
    64b6:	48 8d 15 a6 f7 00 00 	lea    0xf7a6(%rip),%rdx        # 15c63 <exec_in_fp0+0x3f3>
    64bd:	48 8d 0d 9c f7 00 00 	lea    0xf79c(%rip),%rcx        # 15c60 <exec_in_fp0+0x3f0>
    64c4:	48 89 e3             	mov    %rsp,%rbx
    64c7:	be 60 00 00 00       	mov    $0x60,%esi
    64cc:	48 89 df             	mov    %rbx,%rdi
    64cf:	31 c0                	xor    %eax,%eax
    64d1:	e8 fa cc ff ff       	call   31d0 <snprintf@plt>
    64d6:	e8 15 07 00 00       	call   6bf0 <fwp_flush>
    64db:	48 8b 05 f6 3a 01 00 	mov    0x13af6(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    64e2:	48 8b 38             	mov    (%rax),%rdi
    64e5:	48 8d 35 ad f5 00 00 	lea    0xf5ad(%rip),%rsi        # 15a99 <exec_in_fp0+0x229>
    64ec:	48 89 da             	mov    %rbx,%rdx
    64ef:	31 c0                	xor    %eax,%eax
    64f1:	e8 fa cd ff ff       	call   32f0 <fprintf@plt>
    64f6:	bf 65 00 00 00       	mov    $0x65,%edi
    64fb:	e8 60 cf ff ff       	call   3460 <exit@plt>

0000000000006500 <e9>:
    6500:	53                   	push   %rbx
    6501:	48 89 fb             	mov    %rdi,%rbx
    6504:	48 8b 3f             	mov    (%rdi),%rdi
    6507:	e8 04 04 00 00       	call   6910 <fwp_rc_share>
    650c:	48 8b 03             	mov    (%rbx),%rax
    650f:	48 bb ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rbx
    6516:	ff ff 7f 
    6519:	48 23 18             	and    (%rax),%rbx
    651c:	48 89 df             	mov    %rbx,%rdi
    651f:	e8 ec 03 00 00       	call   6910 <fwp_rc_share>
    6524:	48 89 d8             	mov    %rbx,%rax
    6527:	5b                   	pop    %rbx
    6528:	c3                   	ret
    6529:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000006530 <e11>:
    6530:	53                   	push   %rbx
    6531:	48 89 fb             	mov    %rdi,%rbx
    6534:	48 8b 3f             	mov    (%rdi),%rdi
    6537:	e8 d4 03 00 00       	call   6910 <fwp_rc_share>
    653c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    6540:	e8 cb 03 00 00       	call   6910 <fwp_rc_share>
    6545:	48 8b 3b             	mov    (%rbx),%rdi
    6548:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    654c:	48 8d 0d 5d 57 01 00 	lea    0x1575d(%rip),%rcx        # 1bcb0 <d1>
    6553:	48 89 ca             	mov    %rcx,%rdx
    6556:	e8 d5 07 00 00       	call   6d30 <fwp_p_array_map_typed>
    655b:	48 89 c3             	mov    %rax,%rbx
    655e:	48 89 c7             	mov    %rax,%rdi
    6561:	e8 aa 03 00 00       	call   6910 <fwp_rc_share>
    6566:	48 89 d8             	mov    %rbx,%rax
    6569:	5b                   	pop    %rbx
    656a:	c3                   	ret
    656b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006570 <e12>:
    6570:	53                   	push   %rbx
    6571:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    6575:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    657a:	0f 59 c8             	mulps  %xmm0,%xmm1
    657d:	66 0f 7e cb          	movd   %xmm1,%ebx
    6581:	48 89 df             	mov    %rbx,%rdi
    6584:	e8 87 03 00 00       	call   6910 <fwp_rc_share>
    6589:	48 89 d8             	mov    %rbx,%rax
    658c:	5b                   	pop    %rbx
    658d:	c3                   	ret
    658e:	66 90                	xchg   %ax,%ax

0000000000006590 <e13>:
    6590:	53                   	push   %rbx
    6591:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    6595:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    659a:	0f 58 c8             	addps  %xmm0,%xmm1
    659d:	66 0f 7e cb          	movd   %xmm1,%ebx
    65a1:	48 89 df             	mov    %rbx,%rdi
    65a4:	e8 67 03 00 00       	call   6910 <fwp_rc_share>
    65a9:	48 89 d8             	mov    %rbx,%rax
    65ac:	5b                   	pop    %rbx
    65ad:	c3                   	ret
    65ae:	66 90                	xchg   %ax,%ax

00000000000065b0 <e15>:
    65b0:	55                   	push   %rbp
    65b1:	41 57                	push   %r15
    65b3:	41 56                	push   %r14
    65b5:	41 55                	push   %r13
    65b7:	41 54                	push   %r12
    65b9:	53                   	push   %rbx
    65ba:	48 83 ec 18          	sub    $0x18,%rsp
    65be:	49 89 fe             	mov    %rdi,%r14
    65c1:	48 8b 3f             	mov    (%rdi),%rdi
    65c4:	e8 47 03 00 00       	call   6910 <fwp_rc_share>
    65c9:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    65cd:	e8 3e 03 00 00       	call   6910 <fwp_rc_share>
    65d2:	49 8b 1e             	mov    (%r14),%rbx
    65d5:	49 8b 46 08          	mov    0x8(%r14),%rax
    65d9:	4d 8b 7e 10          	mov    0x10(%r14),%r15
    65dd:	49 8b 0f             	mov    (%r15),%rcx
    65e0:	48 8d 14 4d 00 00 00 	lea    0x0(,%rcx,2),%rdx
    65e7:	00 
    65e8:	48 85 d2             	test   %rdx,%rdx
    65eb:	0f 84 cd 00 00 00    	je     66be <e15+0x10e>
    65f1:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
    65f8:	ff ff 7f 
    65fb:	4d 8d 6f 08          	lea    0x8(%r15),%r13
    65ff:	31 ed                	xor    %ebp,%ebp
    6601:	49 89 e6             	mov    %rsp,%r14
    6604:	eb 44                	jmp    664a <e15+0x9a>
    6606:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    660d:	00 00 00 
    6610:	0f b7 0c 0e          	movzwl (%rsi,%rcx,1),%ecx
    6614:	83 f8 01             	cmp    $0x1,%eax
    6617:	48 0f bf c1          	movswq %cx,%rax
    661b:	48 0f 45 c1          	cmovne %rcx,%rax
    661f:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    6624:	48 89 df             	mov    %rbx,%rdi
    6627:	be 02 00 00 00       	mov    $0x2,%esi
    662c:	4c 89 f2             	mov    %r14,%rdx
    662f:	b9 01 00 00 00       	mov    $0x1,%ecx
    6634:	e8 67 09 00 00       	call   6fa0 <fwp_apply_borrowed_prefix>
    6639:	48 ff c5             	inc    %rbp
    663c:	49 8b 0f             	mov    (%r15),%rcx
    663f:	48 89 ca             	mov    %rcx,%rdx
    6642:	4c 21 e2             	and    %r12,%rdx
    6645:	48 39 d5             	cmp    %rdx,%rbp
    6648:	73 74                	jae    66be <e15+0x10e>
    664a:	48 89 04 24          	mov    %rax,(%rsp)
    664e:	8b 05 5c 56 01 00    	mov    0x1565c(%rip),%eax        # 1bcb0 <d1>
    6654:	ba 08 00 00 00       	mov    $0x8,%edx
    6659:	48 83 f8 0a          	cmp    $0xa,%rax
    665d:	77 0b                	ja     666a <e15+0xba>
    665f:	48 8d 15 8a f2 00 00 	lea    0xf28a(%rip),%rdx        # 158f0 <exec_in_fp0+0x80>
    6666:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
    666a:	4c 89 ee             	mov    %r13,%rsi
    666d:	48 85 c9             	test   %rcx,%rcx
    6670:	79 04                	jns    6676 <e15+0xc6>
    6672:	49 8b 77 10          	mov    0x10(%r15),%rsi
    6676:	48 89 d1             	mov    %rdx,%rcx
    6679:	48 0f af cd          	imul   %rbp,%rcx
    667d:	48 83 fa 01          	cmp    $0x1,%rdx
    6681:	74 1d                	je     66a0 <e15+0xf0>
    6683:	48 83 fa 02          	cmp    $0x2,%rdx
    6687:	74 87                	je     6610 <e15+0x60>
    6689:	48 83 fa 08          	cmp    $0x8,%rdx
    668d:	75 21                	jne    66b0 <e15+0x100>
    668f:	48 8b 04 0e          	mov    (%rsi,%rcx,1),%rax
    6693:	eb 8a                	jmp    661f <e15+0x6f>
    6695:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    669c:	00 00 00 00 
    66a0:	0f b6 0c 0e          	movzbl (%rsi,%rcx,1),%ecx
    66a4:	48 85 c0             	test   %rax,%rax
    66a7:	48 0f be c1          	movsbq %cl,%rax
    66ab:	e9 6b ff ff ff       	jmp    661b <e15+0x6b>
    66b0:	8b 0c 0e             	mov    (%rsi,%rcx,1),%ecx
    66b3:	83 f8 02             	cmp    $0x2,%eax
    66b6:	48 63 c1             	movslq %ecx,%rax
    66b9:	e9 5d ff ff ff       	jmp    661b <e15+0x6b>
    66be:	48 89 c7             	mov    %rax,%rdi
    66c1:	48 89 c3             	mov    %rax,%rbx
    66c4:	e8 47 02 00 00       	call   6910 <fwp_rc_share>
    66c9:	48 89 d8             	mov    %rbx,%rax
    66cc:	48 83 c4 18          	add    $0x18,%rsp
    66d0:	5b                   	pop    %rbx
    66d1:	41 5c                	pop    %r12
    66d3:	41 5d                	pop    %r13
    66d5:	41 5e                	pop    %r14
    66d7:	41 5f                	pop    %r15
    66d9:	5d                   	pop    %rbp
    66da:	c3                   	ret
    66db:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000066e0 <e17>:
    66e0:	53                   	push   %rbx
    66e1:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    66e5:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    66ea:	0f 58 c8             	addps  %xmm0,%xmm1
    66ed:	66 0f 7e cb          	movd   %xmm1,%ebx
    66f1:	48 89 df             	mov    %rbx,%rdi
    66f4:	e8 17 02 00 00       	call   6910 <fwp_rc_share>
    66f9:	48 89 d8             	mov    %rbx,%rax
    66fc:	5b                   	pop    %rbx
    66fd:	c3                   	ret
    66fe:	66 90                	xchg   %ax,%ax

0000000000006700 <e18>:
    6700:	53                   	push   %rbx
    6701:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    6705:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    670a:	0f 59 c8             	mulps  %xmm0,%xmm1
    670d:	66 0f 7e cb          	movd   %xmm1,%ebx
    6711:	48 89 df             	mov    %rbx,%rdi
    6714:	e8 f7 01 00 00       	call   6910 <fwp_rc_share>
    6719:	48 89 d8             	mov    %rbx,%rax
    671c:	5b                   	pop    %rbx
    671d:	c3                   	ret
    671e:	66 90                	xchg   %ax,%ax

0000000000006720 <e19>:
    6720:	53                   	push   %rbx
    6721:	48 89 fb             	mov    %rdi,%rbx
    6724:	48 8b 3f             	mov    (%rdi),%rdi
    6727:	e8 e4 01 00 00       	call   6910 <fwp_rc_share>
    672c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    6730:	e8 db 01 00 00       	call   6910 <fwp_rc_share>
    6735:	48 8b 3b             	mov    (%rbx),%rdi
    6738:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    673c:	48 8d 0d 3d 56 01 00 	lea    0x1563d(%rip),%rcx        # 1bd80 <d2>
    6743:	48 89 ca             	mov    %rcx,%rdx
    6746:	e8 e5 05 00 00       	call   6d30 <fwp_p_array_map_typed>
    674b:	48 89 c3             	mov    %rax,%rbx
    674e:	48 89 c7             	mov    %rax,%rdi
    6751:	e8 ba 01 00 00       	call   6910 <fwp_rc_share>
    6756:	48 89 d8             	mov    %rbx,%rax
    6759:	5b                   	pop    %rbx
    675a:	c3                   	ret
    675b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006760 <e20>:
    6760:	53                   	push   %rbx
    6761:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    6765:	f2 0f 59 47 08       	mulsd  0x8(%rdi),%xmm0
    676a:	66 48 0f 7e c3       	movq   %xmm0,%rbx
    676f:	48 89 df             	mov    %rbx,%rdi
    6772:	e8 99 01 00 00       	call   6910 <fwp_rc_share>
    6777:	48 89 d8             	mov    %rbx,%rax
    677a:	5b                   	pop    %rbx
    677b:	c3                   	ret
    677c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000006780 <e21>:
    6780:	53                   	push   %rbx
    6781:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    6785:	f2 0f 58 47 08       	addsd  0x8(%rdi),%xmm0
    678a:	66 48 0f 7e c3       	movq   %xmm0,%rbx
    678f:	48 89 df             	mov    %rbx,%rdi
    6792:	e8 79 01 00 00       	call   6910 <fwp_rc_share>
    6797:	48 89 d8             	mov    %rbx,%rax
    679a:	5b                   	pop    %rbx
    679b:	c3                   	ret
    679c:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000067a0 <e23>:
    67a0:	55                   	push   %rbp
    67a1:	41 57                	push   %r15
    67a3:	41 56                	push   %r14
    67a5:	41 55                	push   %r13
    67a7:	41 54                	push   %r12
    67a9:	53                   	push   %rbx
    67aa:	48 83 ec 18          	sub    $0x18,%rsp
    67ae:	49 89 fe             	mov    %rdi,%r14
    67b1:	48 8b 3f             	mov    (%rdi),%rdi
    67b4:	e8 57 01 00 00       	call   6910 <fwp_rc_share>
    67b9:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    67bd:	e8 4e 01 00 00       	call   6910 <fwp_rc_share>
    67c2:	49 8b 1e             	mov    (%r14),%rbx
    67c5:	49 8b 46 08          	mov    0x8(%r14),%rax
    67c9:	4d 8b 7e 10          	mov    0x10(%r14),%r15
    67cd:	49 8b 0f             	mov    (%r15),%rcx
    67d0:	48 8d 14 4d 00 00 00 	lea    0x0(,%rcx,2),%rdx
    67d7:	00 
    67d8:	48 85 d2             	test   %rdx,%rdx
    67db:	0f 84 cd 00 00 00    	je     68ae <e23+0x10e>
    67e1:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
    67e8:	ff ff 7f 
    67eb:	4d 8d 6f 08          	lea    0x8(%r15),%r13
    67ef:	31 ed                	xor    %ebp,%ebp
    67f1:	49 89 e6             	mov    %rsp,%r14
    67f4:	eb 44                	jmp    683a <e23+0x9a>
    67f6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    67fd:	00 00 00 
    6800:	0f b7 0c 0e          	movzwl (%rsi,%rcx,1),%ecx
    6804:	83 f8 01             	cmp    $0x1,%eax
    6807:	48 0f bf c1          	movswq %cx,%rax
    680b:	48 0f 45 c1          	cmovne %rcx,%rax
    680f:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    6814:	48 89 df             	mov    %rbx,%rdi
    6817:	be 02 00 00 00       	mov    $0x2,%esi
    681c:	4c 89 f2             	mov    %r14,%rdx
    681f:	b9 01 00 00 00       	mov    $0x1,%ecx
    6824:	e8 77 07 00 00       	call   6fa0 <fwp_apply_borrowed_prefix>
    6829:	48 ff c5             	inc    %rbp
    682c:	49 8b 0f             	mov    (%r15),%rcx
    682f:	48 89 ca             	mov    %rcx,%rdx
    6832:	4c 21 e2             	and    %r12,%rdx
    6835:	48 39 d5             	cmp    %rdx,%rbp
    6838:	73 74                	jae    68ae <e23+0x10e>
    683a:	48 89 04 24          	mov    %rax,(%rsp)
    683e:	8b 05 3c 55 01 00    	mov    0x1553c(%rip),%eax        # 1bd80 <d2>
    6844:	ba 08 00 00 00       	mov    $0x8,%edx
    6849:	48 83 f8 0a          	cmp    $0xa,%rax
    684d:	77 0b                	ja     685a <e23+0xba>
    684f:	48 8d 15 9a f0 00 00 	lea    0xf09a(%rip),%rdx        # 158f0 <exec_in_fp0+0x80>
    6856:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
    685a:	4c 89 ee             	mov    %r13,%rsi
    685d:	48 85 c9             	test   %rcx,%rcx
    6860:	79 04                	jns    6866 <e23+0xc6>
    6862:	49 8b 77 10          	mov    0x10(%r15),%rsi
    6866:	48 89 d1             	mov    %rdx,%rcx
    6869:	48 0f af cd          	imul   %rbp,%rcx
    686d:	48 83 fa 01          	cmp    $0x1,%rdx
    6871:	74 1d                	je     6890 <e23+0xf0>
    6873:	48 83 fa 02          	cmp    $0x2,%rdx
    6877:	74 87                	je     6800 <e23+0x60>
    6879:	48 83 fa 08          	cmp    $0x8,%rdx
    687d:	75 21                	jne    68a0 <e23+0x100>
    687f:	48 8b 04 0e          	mov    (%rsi,%rcx,1),%rax
    6883:	eb 8a                	jmp    680f <e23+0x6f>
    6885:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    688c:	00 00 00 00 
    6890:	0f b6 0c 0e          	movzbl (%rsi,%rcx,1),%ecx
    6894:	48 85 c0             	test   %rax,%rax
    6897:	48 0f be c1          	movsbq %cl,%rax
    689b:	e9 6b ff ff ff       	jmp    680b <e23+0x6b>
    68a0:	8b 0c 0e             	mov    (%rsi,%rcx,1),%ecx
    68a3:	83 f8 02             	cmp    $0x2,%eax
    68a6:	48 63 c1             	movslq %ecx,%rax
    68a9:	e9 5d ff ff ff       	jmp    680b <e23+0x6b>
    68ae:	48 89 c7             	mov    %rax,%rdi
    68b1:	48 89 c3             	mov    %rax,%rbx
    68b4:	e8 57 00 00 00       	call   6910 <fwp_rc_share>
    68b9:	48 89 d8             	mov    %rbx,%rax
    68bc:	48 83 c4 18          	add    $0x18,%rsp
    68c0:	5b                   	pop    %rbx
    68c1:	41 5c                	pop    %r12
    68c3:	41 5d                	pop    %r13
    68c5:	41 5e                	pop    %r14
    68c7:	41 5f                	pop    %r15
    68c9:	5d                   	pop    %rbp
    68ca:	c3                   	ret
    68cb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000068d0 <e25>:
    68d0:	53                   	push   %rbx
    68d1:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    68d5:	f2 0f 58 47 08       	addsd  0x8(%rdi),%xmm0
    68da:	66 48 0f 7e c3       	movq   %xmm0,%rbx
    68df:	48 89 df             	mov    %rbx,%rdi
    68e2:	e8 29 00 00 00       	call   6910 <fwp_rc_share>
    68e7:	48 89 d8             	mov    %rbx,%rax
    68ea:	5b                   	pop    %rbx
    68eb:	c3                   	ret
    68ec:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000068f0 <e26>:
    68f0:	53                   	push   %rbx
    68f1:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    68f5:	f2 0f 59 47 08       	mulsd  0x8(%rdi),%xmm0
    68fa:	66 48 0f 7e c3       	movq   %xmm0,%rbx
    68ff:	48 89 df             	mov    %rbx,%rdi
    6902:	e8 09 00 00 00       	call   6910 <fwp_rc_share>
    6907:	48 89 d8             	mov    %rbx,%rax
    690a:	5b                   	pop    %rbx
    690b:	c3                   	ret
    690c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000006910 <fwp_rc_share>:
    6910:	48 89 f8             	mov    %rdi,%rax
    6913:	48 2b 05 9e 49 01 00 	sub    0x1499e(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    691a:	48 8b 0d bf 49 01 00 	mov    0x149bf(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    6921:	48 c1 e1 10          	shl    $0x10,%rcx
    6925:	48 39 c8             	cmp    %rcx,%rax
    6928:	0f 83 f9 01 00 00    	jae    6b27 <fwp_rc_share+0x217>
    692e:	41 57                	push   %r15
    6930:	41 56                	push   %r14
    6932:	41 55                	push   %r13
    6934:	41 54                	push   %r12
    6936:	53                   	push   %rbx
    6937:	48 81 ec 00 02 00 00 	sub    $0x200,%rsp
    693e:	48 8b 0d bb 49 01 00 	mov    0x149bb(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    6945:	48 89 c2             	mov    %rax,%rdx
    6948:	48 c1 ea 10          	shr    $0x10,%rdx
    694c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6953:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6957:	48 25 ff ff 00 00    	and    $0xffff,%rax
    695d:	75 13                	jne    6972 <fwp_rc_share+0x62>
    695f:	40 80 fe 02          	cmp    $0x2,%sil
    6963:	75 0d                	jne    6972 <fwp_rc_share+0x62>
    6965:	48 8d 1c 11          	lea    (%rcx,%rdx,1),%rbx
    6969:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    6970:	eb 25                	jmp    6997 <fwp_rc_share+0x87>
    6972:	40 80 fe 01          	cmp    $0x1,%sil
    6976:	0f 85 9b 01 00 00    	jne    6b17 <fwp_rc_share+0x207>
    697c:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6980:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6984:	48 0f af c1          	imul   %rcx,%rax
    6988:	48 c1 e8 20          	shr    $0x20,%rax
    698c:	48 8d 1c 30          	lea    (%rax,%rsi,1),%rbx
    6990:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    6997:	0f b6 03             	movzbl (%rbx),%eax
    699a:	84 c0                	test   %al,%al
    699c:	0f 84 75 01 00 00    	je     6b17 <fwp_rc_share+0x207>
    69a2:	3c ff                	cmp    $0xff,%al
    69a4:	0f 84 7e 01 00 00    	je     6b28 <fwp_rc_share+0x218>
    69aa:	c6 03 00             	movb   $0x0,(%rbx)
    69ad:	48 89 3c 24          	mov    %rdi,(%rsp)
    69b1:	41 be 01 00 00 00    	mov    $0x1,%r14d
    69b7:	eb 10                	jmp    69c9 <fwp_rc_share+0xb9>
    69b9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    69c0:	4d 85 f6             	test   %r14,%r14
    69c3:	0f 84 4e 01 00 00    	je     6b17 <fwp_rc_share+0x207>
    69c9:	4e 8b 7c f4 f8       	mov    -0x8(%rsp,%r14,8),%r15
    69ce:	49 ff ce             	dec    %r14
    69d1:	48 8b 05 e0 48 01 00 	mov    0x148e0(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    69d8:	4c 89 f9             	mov    %r15,%rcx
    69db:	48 29 c1             	sub    %rax,%rcx
    69de:	48 89 ce             	mov    %rcx,%rsi
    69e1:	48 c1 ee 10          	shr    $0x10,%rsi
    69e5:	48 8b 15 14 49 01 00 	mov    0x14914(%rip),%rdx        # 1b300 <fwp_gc+0x1078>
    69ec:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    69f3:	80 7c 32 01 01       	cmpb   $0x1,0x1(%rdx,%rsi,1)
    69f8:	74 c6                	je     69c0 <fwp_rc_share+0xb0>
    69fa:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    69fe:	40 80 ff 02          	cmp    $0x2,%dil
    6a02:	75 0c                	jne    6a10 <fwp_rc_share+0x100>
    6a04:	4c 8b 64 32 18       	mov    0x18(%rdx,%rsi,1),%r12
    6a09:	eb 32                	jmp    6a3d <fwp_rc_share+0x12d>
    6a0b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    6a10:	44 8b 64 32 08       	mov    0x8(%rdx,%rsi,1),%r12d
    6a15:	40 80 ff 01          	cmp    $0x1,%dil
    6a19:	75 22                	jne    6a3d <fwp_rc_share+0x12d>
    6a1b:	41 0f b7 ff          	movzwl %r15w,%edi
    6a1f:	44 8b 7c 32 20       	mov    0x20(%rdx,%rsi,1),%r15d
    6a24:	4c 0f af ff          	imul   %rdi,%r15
    6a28:	49 c1 ef 20          	shr    $0x20,%r15
    6a2c:	48 81 e1 00 00 ff ff 	and    $0xffffffffffff0000,%rcx
    6a33:	48 01 c8             	add    %rcx,%rax
    6a36:	4d 0f af fc          	imul   %r12,%r15
    6a3a:	49 01 c7             	add    %rax,%r15
    6a3d:	49 83 fc 08          	cmp    $0x8,%r12
    6a41:	0f 82 79 ff ff ff    	jb     69c0 <fwp_rc_share+0xb0>
    6a47:	49 c1 ec 03          	shr    $0x3,%r12
    6a4b:	45 31 ed             	xor    %r13d,%r13d
    6a4e:	eb 1c                	jmp    6a6c <fwp_rc_share+0x15c>
    6a50:	e8 bb fe ff ff       	call   6910 <fwp_rc_share>
    6a55:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    6a5c:	00 00 00 00 
    6a60:	49 ff c5             	inc    %r13
    6a63:	4d 39 ec             	cmp    %r13,%r12
    6a66:	0f 84 54 ff ff ff    	je     69c0 <fwp_rc_share+0xb0>
    6a6c:	4b 8b 3c ef          	mov    (%r15,%r13,8),%rdi
    6a70:	48 89 f8             	mov    %rdi,%rax
    6a73:	48 2b 05 3e 48 01 00 	sub    0x1483e(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    6a7a:	48 8b 0d 5f 48 01 00 	mov    0x1485f(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    6a81:	48 c1 e1 10          	shl    $0x10,%rcx
    6a85:	48 39 c8             	cmp    %rcx,%rax
    6a88:	73 d6                	jae    6a60 <fwp_rc_share+0x150>
    6a8a:	48 8b 0d 6f 48 01 00 	mov    0x1486f(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    6a91:	48 89 c2             	mov    %rax,%rdx
    6a94:	48 c1 ea 10          	shr    $0x10,%rdx
    6a98:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6a9f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6aa3:	48 25 ff ff 00 00    	and    $0xffff,%rax
    6aa9:	75 15                	jne    6ac0 <fwp_rc_share+0x1b0>
    6aab:	40 80 fe 02          	cmp    $0x2,%sil
    6aaf:	75 0f                	jne    6ac0 <fwp_rc_share+0x1b0>
    6ab1:	48 8d 1c 11          	lea    (%rcx,%rdx,1),%rbx
    6ab5:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    6abc:	eb 23                	jmp    6ae1 <fwp_rc_share+0x1d1>
    6abe:	66 90                	xchg   %ax,%ax
    6ac0:	40 80 fe 01          	cmp    $0x1,%sil
    6ac4:	75 9a                	jne    6a60 <fwp_rc_share+0x150>
    6ac6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6aca:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6ace:	48 0f af c1          	imul   %rcx,%rax
    6ad2:	48 c1 e8 20          	shr    $0x20,%rax
    6ad6:	48 8d 1c 30          	lea    (%rax,%rsi,1),%rbx
    6ada:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    6ae1:	0f b6 03             	movzbl (%rbx),%eax
    6ae4:	84 c0                	test   %al,%al
    6ae6:	0f 84 74 ff ff ff    	je     6a60 <fwp_rc_share+0x150>
    6aec:	49 83 fe 3f          	cmp    $0x3f,%r14
    6af0:	0f 87 5a ff ff ff    	ja     6a50 <fwp_rc_share+0x140>
    6af6:	3c ff                	cmp    $0xff,%al
    6af8:	74 13                	je     6b0d <fwp_rc_share+0x1fd>
    6afa:	c6 03 00             	movb   $0x0,(%rbx)
    6afd:	4b 8b 04 ef          	mov    (%r15,%r13,8),%rax
    6b01:	4a 89 04 f4          	mov    %rax,(%rsp,%r14,8)
    6b05:	49 ff c6             	inc    %r14
    6b08:	e9 53 ff ff ff       	jmp    6a60 <fwp_rc_share+0x150>
    6b0d:	48 89 df             	mov    %rbx,%rdi
    6b10:	e8 2b 00 00 00       	call   6b40 <fwp_rc_forget_slot>
    6b15:	eb e3                	jmp    6afa <fwp_rc_share+0x1ea>
    6b17:	48 81 c4 00 02 00 00 	add    $0x200,%rsp
    6b1e:	5b                   	pop    %rbx
    6b1f:	41 5c                	pop    %r12
    6b21:	41 5d                	pop    %r13
    6b23:	41 5e                	pop    %r14
    6b25:	41 5f                	pop    %r15
    6b27:	c3                   	ret
    6b28:	49 89 fe             	mov    %rdi,%r14
    6b2b:	48 89 df             	mov    %rbx,%rdi
    6b2e:	e8 0d 00 00 00       	call   6b40 <fwp_rc_forget_slot>
    6b33:	4c 89 f7             	mov    %r14,%rdi
    6b36:	e9 6f fe ff ff       	jmp    69aa <fwp_rc_share+0x9a>
    6b3b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006b40 <fwp_rc_forget_slot>:
    6b40:	50                   	push   %rax
    6b41:	80 3f ff             	cmpb   $0xff,(%rdi)
    6b44:	74 02                	je     6b48 <fwp_rc_forget_slot+0x8>
    6b46:	58                   	pop    %rax
    6b47:	c3                   	ret
    6b48:	48 89 f8             	mov    %rdi,%rax
    6b4b:	48 c1 e8 11          	shr    $0x11,%rax
    6b4f:	31 f8                	xor    %edi,%eax
    6b51:	89 c1                	mov    %eax,%ecx
    6b53:	c1 e9 09             	shr    $0x9,%ecx
    6b56:	31 c1                	xor    %eax,%ecx
    6b58:	0f b6 c9             	movzbl %cl,%ecx
    6b5b:	48 8d 15 26 37 01 00 	lea    0x13726(%rip),%rdx        # 1a288 <fwp_gc>
    6b62:	48 8b 84 ca 18 12 00 	mov    0x1218(%rdx,%rcx,8),%rax
    6b69:	00 
    6b6a:	48 85 c0             	test   %rax,%rax
    6b6d:	74 4b                	je     6bba <fwp_rc_forget_slot+0x7a>
    6b6f:	48 39 38             	cmp    %rdi,(%rax)
    6b72:	74 23                	je     6b97 <fwp_rc_forget_slot+0x57>
    6b74:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    6b7b:	00 00 00 00 00 
    6b80:	48 89 c1             	mov    %rax,%rcx
    6b83:	48 8b 40 10          	mov    0x10(%rax),%rax
    6b87:	48 85 c0             	test   %rax,%rax
    6b8a:	74 2e                	je     6bba <fwp_rc_forget_slot+0x7a>
    6b8c:	48 39 38             	cmp    %rdi,(%rax)
    6b8f:	75 ef                	jne    6b80 <fwp_rc_forget_slot+0x40>
    6b91:	48 83 c1 10          	add    $0x10,%rcx
    6b95:	eb 0b                	jmp    6ba2 <fwp_rc_forget_slot+0x62>
    6b97:	48 8d 0c ca          	lea    (%rdx,%rcx,8),%rcx
    6b9b:	48 81 c1 18 12 00 00 	add    $0x1218,%rcx
    6ba2:	48 8b 50 10          	mov    0x10(%rax),%rdx
    6ba6:	48 89 11             	mov    %rdx,(%rcx)
    6ba9:	48 89 c7             	mov    %rax,%rdi
    6bac:	e8 9f c4 ff ff       	call   3050 <free@plt>
    6bb1:	48 ff 0d e8 50 01 00 	decq   0x150e8(%rip)        # 1bca0 <fwp_gc+0x1a18>
    6bb8:	58                   	pop    %rax
    6bb9:	c3                   	ret
    6bba:	e8 31 00 00 00       	call   6bf0 <fwp_flush>
    6bbf:	48 8b 05 12 34 01 00 	mov    0x13412(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    6bc6:	48 8b 38             	mov    (%rax),%rdi
    6bc9:	48 8d 35 c9 ee 00 00 	lea    0xeec9(%rip),%rsi        # 15a99 <exec_in_fp0+0x229>
    6bd0:	48 8d 15 9b ee 00 00 	lea    0xee9b(%rip),%rdx        # 15a72 <exec_in_fp0+0x202>
    6bd7:	31 c0                	xor    %eax,%eax
    6bd9:	e8 12 c7 ff ff       	call   32f0 <fprintf@plt>
    6bde:	bf 65 00 00 00       	mov    $0x65,%edi
    6be3:	e8 78 c8 ff ff       	call   3460 <exit@plt>
    6be8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6bef:	00 

0000000000006bf0 <fwp_flush>:
    6bf0:	50                   	push   %rax
    6bf1:	48 8b 3d 80 52 01 00 	mov    0x15280(%rip),%rdi        # 1be78 <fwp_prog_out>
    6bf8:	48 85 ff             	test   %rdi,%rdi
    6bfb:	74 05                	je     6c02 <fwp_flush+0x12>
    6bfd:	e8 4e c7 ff ff       	call   3350 <fflush@plt>
    6c02:	48 8b 05 a7 33 01 00 	mov    0x133a7(%rip),%rax        # 19fb0 <stdout@GLIBC_2.2.5>
    6c09:	48 8b 38             	mov    (%rax),%rdi
    6c0c:	58                   	pop    %rax
    6c0d:	e9 3e c7 ff ff       	jmp    3350 <fflush@plt>
    6c12:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6c19:	1f 84 00 00 00 00 00 

0000000000006c20 <fwp_owner_release3>:
    6c20:	48 8b 3f             	mov    (%rdi),%rdi
    6c23:	eb 0b                	jmp    6c30 <fwp_drop1>
    6c25:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    6c2c:	00 00 00 00 

0000000000006c30 <fwp_drop1>:
    6c30:	53                   	push   %rbx
    6c31:	48 89 f8             	mov    %rdi,%rax
    6c34:	48 2b 05 7d 46 01 00 	sub    0x1467d(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    6c3b:	48 8b 0d 9e 46 01 00 	mov    0x1469e(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    6c42:	48 c1 e1 10          	shl    $0x10,%rcx
    6c46:	48 39 c8             	cmp    %rcx,%rax
    6c49:	0f 83 9c 00 00 00    	jae    6ceb <fwp_drop1+0xbb>
    6c4f:	48 8b 0d aa 46 01 00 	mov    0x146aa(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    6c56:	48 89 c2             	mov    %rax,%rdx
    6c59:	48 c1 ea 10          	shr    $0x10,%rdx
    6c5d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6c64:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6c68:	48 25 ff ff 00 00    	and    $0xffff,%rax
    6c6e:	75 20                	jne    6c90 <fwp_drop1+0x60>
    6c70:	40 80 fe 02          	cmp    $0x2,%sil
    6c74:	75 1a                	jne    6c90 <fwp_drop1+0x60>
    6c76:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    6c7a:	48 05 28 02 00 00    	add    $0x228,%rax
    6c80:	eb 2d                	jmp    6caf <fwp_drop1+0x7f>
    6c82:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6c89:	1f 84 00 00 00 00 00 
    6c90:	40 80 fe 01          	cmp    $0x1,%sil
    6c94:	75 55                	jne    6ceb <fwp_drop1+0xbb>
    6c96:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6c9a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6c9e:	48 0f af c1          	imul   %rcx,%rax
    6ca2:	48 c1 e8 20          	shr    $0x20,%rax
    6ca6:	48 01 f0             	add    %rsi,%rax
    6ca9:	48 05 28 02 00 00    	add    $0x228,%rax
    6caf:	0f b6 08             	movzbl (%rax),%ecx
    6cb2:	85 c9                	test   %ecx,%ecx
    6cb4:	74 35                	je     6ceb <fwp_drop1+0xbb>
    6cb6:	83 f9 01             	cmp    $0x1,%ecx
    6cb9:	75 32                	jne    6ced <fwp_drop1+0xbd>
    6cbb:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    6cbf:	79 3a                	jns    6cfb <fwp_drop1+0xcb>
    6cc1:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    6cc5:	e8 a6 40 00 00       	call   ad70 <fwp_rc_free_arr>
    6cca:	48 89 d8             	mov    %rbx,%rax
    6ccd:	48 2b 05 e4 45 01 00 	sub    0x145e4(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    6cd4:	48 8b 0d 05 46 01 00 	mov    0x14605(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    6cdb:	48 c1 e1 10          	shl    $0x10,%rcx
    6cdf:	48 89 df             	mov    %rbx,%rdi
    6ce2:	48 39 c8             	cmp    %rcx,%rax
    6ce5:	0f 82 64 ff ff ff    	jb     6c4f <fwp_drop1+0x1f>
    6ceb:	5b                   	pop    %rbx
    6cec:	c3                   	ret
    6ced:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    6cf3:	74 0c                	je     6d01 <fwp_drop1+0xd1>
    6cf5:	fe c9                	dec    %cl
    6cf7:	88 08                	mov    %cl,(%rax)
    6cf9:	5b                   	pop    %rbx
    6cfa:	c3                   	ret
    6cfb:	5b                   	pop    %rbx
    6cfc:	e9 6f 40 00 00       	jmp    ad70 <fwp_rc_free_arr>
    6d01:	48 89 c7             	mov    %rax,%rdi
    6d04:	5b                   	pop    %rbx
    6d05:	e9 e6 38 00 00       	jmp    a5f0 <fwp_rc_wide_drop>
    6d0a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000006d10 <fwp_owner_release4>:
    6d10:	48 8b 3f             	mov    (%rdi),%rdi
    6d13:	e9 18 ff ff ff       	jmp    6c30 <fwp_drop1>
    6d18:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6d1f:	00 

0000000000006d20 <fwp_owner_release5>:
    6d20:	48 8b 3f             	mov    (%rdi),%rdi
    6d23:	e9 08 ff ff ff       	jmp    6c30 <fwp_drop1>
    6d28:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6d2f:	00 

0000000000006d30 <fwp_p_array_map_typed>:
    6d30:	55                   	push   %rbp
    6d31:	41 57                	push   %r15
    6d33:	41 56                	push   %r14
    6d35:	41 55                	push   %r13
    6d37:	41 54                	push   %r12
    6d39:	53                   	push   %rbx
    6d3a:	48 83 ec 18          	sub    $0x18,%rsp
    6d3e:	48 89 3c 24          	mov    %rdi,(%rsp)
    6d42:	49 bf ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r15
    6d49:	ff ff 7f 
    6d4c:	4c 23 3e             	and    (%rsi),%r15
    6d4f:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    6d56:	ff ff 1f 
    6d59:	49 39 c7             	cmp    %rax,%r15
    6d5c:	0f 83 16 02 00 00    	jae    6f78 <fwp_p_array_map_typed+0x248>
    6d62:	49 89 ce             	mov    %rcx,%r14
    6d65:	49 89 d4             	mov    %rdx,%r12
    6d68:	48 89 f3             	mov    %rsi,%rbx
    6d6b:	4c 89 ff             	mov    %r15,%rdi
    6d6e:	48 89 d6             	mov    %rdx,%rsi
    6d71:	e8 ba ea ff ff       	call   5830 <fwp_array_new_packed>
    6d76:	48 89 c5             	mov    %rax,%rbp
    6d79:	48 2b 05 38 45 01 00 	sub    0x14538(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    6d80:	48 8b 0d 59 45 01 00 	mov    0x14559(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    6d87:	48 c1 e1 10          	shl    $0x10,%rcx
    6d8b:	48 39 c8             	cmp    %rcx,%rax
    6d8e:	73 72                	jae    6e02 <fwp_p_array_map_typed+0xd2>
    6d90:	48 8b 0d 69 45 01 00 	mov    0x14569(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    6d97:	48 89 c2             	mov    %rax,%rdx
    6d9a:	48 c1 ea 10          	shr    $0x10,%rdx
    6d9e:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6da5:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6da9:	48 25 ff ff 00 00    	and    $0xffff,%rax
    6daf:	75 1f                	jne    6dd0 <fwp_p_array_map_typed+0xa0>
    6db1:	40 80 fe 02          	cmp    $0x2,%sil
    6db5:	75 19                	jne    6dd0 <fwp_p_array_map_typed+0xa0>
    6db7:	4c 8d 2c 11          	lea    (%rcx,%rdx,1),%r13
    6dbb:	49 81 c5 28 02 00 00 	add    $0x228,%r13
    6dc2:	41 80 7d 00 ff       	cmpb   $0xff,0x0(%r13)
    6dc7:	74 2f                	je     6df8 <fwp_p_array_map_typed+0xc8>
    6dc9:	41 c6 45 00 01       	movb   $0x1,0x0(%r13)
    6dce:	eb 32                	jmp    6e02 <fwp_p_array_map_typed+0xd2>
    6dd0:	40 80 fe 01          	cmp    $0x1,%sil
    6dd4:	75 2c                	jne    6e02 <fwp_p_array_map_typed+0xd2>
    6dd6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6dda:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6dde:	48 0f af c1          	imul   %rcx,%rax
    6de2:	48 c1 e8 20          	shr    $0x20,%rax
    6de6:	4c 8d 2c 30          	lea    (%rax,%rsi,1),%r13
    6dea:	49 81 c5 28 02 00 00 	add    $0x228,%r13
    6df1:	41 80 7d 00 ff       	cmpb   $0xff,0x0(%r13)
    6df6:	75 d1                	jne    6dc9 <fwp_p_array_map_typed+0x99>
    6df8:	4c 89 ef             	mov    %r13,%rdi
    6dfb:	e8 40 fd ff ff       	call   6b40 <fwp_rc_forget_slot>
    6e00:	eb c7                	jmp    6dc9 <fwp_p_array_map_typed+0x99>
    6e02:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
    6e07:	4d 85 ff             	test   %r15,%r15
    6e0a:	0f 84 24 01 00 00    	je     6f34 <fwp_p_array_map_typed+0x204>
    6e10:	4c 8d 7b 08          	lea    0x8(%rbx),%r15
    6e14:	45 31 ed             	xor    %r13d,%r13d
    6e17:	eb 1a                	jmp    6e33 <fwp_p_array_map_typed+0x103>
    6e19:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    6e20:	4a 89 44 ed 08       	mov    %rax,0x8(%rbp,%r13,8)
    6e25:	49 ff c5             	inc    %r13
    6e28:	4c 39 6c 24 08       	cmp    %r13,0x8(%rsp)
    6e2d:	0f 84 01 01 00 00    	je     6f34 <fwp_p_array_map_typed+0x204>
    6e33:	b8 08 00 00 00       	mov    $0x8,%eax
    6e38:	4d 85 f6             	test   %r14,%r14
    6e3b:	74 14                	je     6e51 <fwp_p_array_map_typed+0x121>
    6e3d:	41 8b 0e             	mov    (%r14),%ecx
    6e40:	48 83 f9 0a          	cmp    $0xa,%rcx
    6e44:	77 0b                	ja     6e51 <fwp_p_array_map_typed+0x121>
    6e46:	48 8d 05 a3 ea 00 00 	lea    0xeaa3(%rip),%rax        # 158f0 <exec_in_fp0+0x80>
    6e4d:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    6e51:	48 83 3b 00          	cmpq   $0x0,(%rbx)
    6e55:	4c 89 f9             	mov    %r15,%rcx
    6e58:	79 04                	jns    6e5e <fwp_p_array_map_typed+0x12e>
    6e5a:	48 8b 4b 10          	mov    0x10(%rbx),%rcx
    6e5e:	48 89 c2             	mov    %rax,%rdx
    6e61:	49 0f af d5          	imul   %r13,%rdx
    6e65:	48 83 f8 01          	cmp    $0x1,%rax
    6e69:	74 25                	je     6e90 <fwp_p_array_map_typed+0x160>
    6e6b:	48 83 f8 02          	cmp    $0x2,%rax
    6e6f:	74 0f                	je     6e80 <fwp_p_array_map_typed+0x150>
    6e71:	48 83 f8 08          	cmp    $0x8,%rax
    6e75:	75 29                	jne    6ea0 <fwp_p_array_map_typed+0x170>
    6e77:	48 8b 04 11          	mov    (%rcx,%rdx,1),%rax
    6e7b:	eb 31                	jmp    6eae <fwp_p_array_map_typed+0x17e>
    6e7d:	0f 1f 00             	nopl   (%rax)
    6e80:	41 83 3e 01          	cmpl   $0x1,(%r14)
    6e84:	0f b7 0c 11          	movzwl (%rcx,%rdx,1),%ecx
    6e88:	48 0f bf c1          	movswq %cx,%rax
    6e8c:	eb 1c                	jmp    6eaa <fwp_p_array_map_typed+0x17a>
    6e8e:	66 90                	xchg   %ax,%ax
    6e90:	41 83 3e 00          	cmpl   $0x0,(%r14)
    6e94:	0f b6 0c 11          	movzbl (%rcx,%rdx,1),%ecx
    6e98:	48 0f be c1          	movsbq %cl,%rax
    6e9c:	eb 0c                	jmp    6eaa <fwp_p_array_map_typed+0x17a>
    6e9e:	66 90                	xchg   %ax,%ax
    6ea0:	41 83 3e 02          	cmpl   $0x2,(%r14)
    6ea4:	8b 0c 11             	mov    (%rcx,%rdx,1),%ecx
    6ea7:	48 63 c1             	movslq %ecx,%rax
    6eaa:	48 0f 45 c1          	cmovne %rcx,%rax
    6eae:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    6eb3:	48 8b 3c 24          	mov    (%rsp),%rdi
    6eb7:	be 01 00 00 00       	mov    $0x1,%esi
    6ebc:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    6ec1:	31 c9                	xor    %ecx,%ecx
    6ec3:	e8 d8 00 00 00       	call   6fa0 <fwp_apply_borrowed_prefix>
    6ec8:	48 83 7d 00 00       	cmpq   $0x0,0x0(%rbp)
    6ecd:	78 7b                	js     6f4a <fwp_p_array_map_typed+0x21a>
    6ecf:	4d 85 e4             	test   %r12,%r12
    6ed2:	0f 84 48 ff ff ff    	je     6e20 <fwp_p_array_map_typed+0xf0>
    6ed8:	41 8b 0c 24          	mov    (%r12),%ecx
    6edc:	83 f9 0a             	cmp    $0xa,%ecx
    6edf:	0f 87 3b ff ff ff    	ja     6e20 <fwp_p_array_map_typed+0xf0>
    6ee5:	ba 84 04 00 00       	mov    $0x484,%edx
    6eea:	0f a3 ca             	bt     %ecx,%edx
    6eed:	72 31                	jb     6f20 <fwp_p_array_map_typed+0x1f0>
    6eef:	ba 21 00 00 00       	mov    $0x21,%edx
    6ef4:	0f a3 ca             	bt     %ecx,%edx
    6ef7:	72 31                	jb     6f2a <fwp_p_array_map_typed+0x1fa>
    6ef9:	ba 42 00 00 00       	mov    $0x42,%edx
    6efe:	0f a3 ca             	bt     %ecx,%edx
    6f01:	0f 83 19 ff ff ff    	jae    6e20 <fwp_p_array_map_typed+0xf0>
    6f07:	66 42 89 44 6d 08    	mov    %ax,0x8(%rbp,%r13,2)
    6f0d:	e9 13 ff ff ff       	jmp    6e25 <fwp_p_array_map_typed+0xf5>
    6f12:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6f19:	1f 84 00 00 00 00 00 
    6f20:	42 89 44 ad 08       	mov    %eax,0x8(%rbp,%r13,4)
    6f25:	e9 fb fe ff ff       	jmp    6e25 <fwp_p_array_map_typed+0xf5>
    6f2a:	42 88 44 2d 08       	mov    %al,0x8(%rbp,%r13,1)
    6f2f:	e9 f1 fe ff ff       	jmp    6e25 <fwp_p_array_map_typed+0xf5>
    6f34:	48 8b 04 24          	mov    (%rsp),%rax
    6f38:	48 89 e8             	mov    %rbp,%rax
    6f3b:	48 83 c4 18          	add    $0x18,%rsp
    6f3f:	5b                   	pop    %rbx
    6f40:	41 5c                	pop    %r12
    6f42:	41 5d                	pop    %r13
    6f44:	41 5e                	pop    %r14
    6f46:	41 5f                	pop    %r15
    6f48:	5d                   	pop    %rbp
    6f49:	c3                   	ret
    6f4a:	e8 a1 fc ff ff       	call   6bf0 <fwp_flush>
    6f4f:	48 8b 05 82 30 01 00 	mov    0x13082(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    6f56:	48 8b 38             	mov    (%rax),%rdi
    6f59:	48 8d 35 39 eb 00 00 	lea    0xeb39(%rip),%rsi        # 15a99 <exec_in_fp0+0x229>
    6f60:	48 8d 15 7a fa 00 00 	lea    0xfa7a(%rip),%rdx        # 169e1 <exec_in_fp0+0x1171>
    6f67:	31 c0                	xor    %eax,%eax
    6f69:	e8 82 c3 ff ff       	call   32f0 <fprintf@plt>
    6f6e:	bf 65 00 00 00       	mov    $0x65,%edi
    6f73:	e8 e8 c4 ff ff       	call   3460 <exit@plt>
    6f78:	e8 73 fc ff ff       	call   6bf0 <fwp_flush>
    6f7d:	48 8b 05 54 30 01 00 	mov    0x13054(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    6f84:	48 8b 38             	mov    (%rax),%rdi
    6f87:	48 8d 35 0b eb 00 00 	lea    0xeb0b(%rip),%rsi        # 15a99 <exec_in_fp0+0x229>
    6f8e:	48 8d 15 13 eb 00 00 	lea    0xeb13(%rip),%rdx        # 15aa8 <exec_in_fp0+0x238>
    6f95:	eb d0                	jmp    6f67 <fwp_p_array_map_typed+0x237>
    6f97:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    6f9e:	00 00 

0000000000006fa0 <fwp_apply_borrowed_prefix>:
    6fa0:	55                   	push   %rbp
    6fa1:	41 57                	push   %r15
    6fa3:	41 56                	push   %r14
    6fa5:	41 55                	push   %r13
    6fa7:	41 54                	push   %r12
    6fa9:	53                   	push   %rbx
    6faa:	48 81 ec a8 00 00 00 	sub    $0xa8,%rsp
    6fb1:	41 89 cf             	mov    %ecx,%r15d
    6fb4:	49 89 d5             	mov    %rdx,%r13
    6fb7:	49 89 fe             	mov    %rdi,%r14
    6fba:	4c 8b 25 af 4e 01 00 	mov    0x14eaf(%rip),%r12        # 1be70 <fwp_fns>
    6fc1:	8b 0f                	mov    (%rdi),%ecx
    6fc3:	48 c1 e1 05          	shl    $0x5,%rcx
    6fc7:	49 8b 44 0c 18       	mov    0x18(%r12,%rcx,1),%rax
    6fcc:	48 85 c0             	test   %rax,%rax
    6fcf:	0f 84 a7 03 00 00    	je     737c <fwp_apply_borrowed_prefix+0x3dc>
    6fd5:	49 8d 2c 0c          	lea    (%r12,%rcx,1),%rbp
    6fd9:	48 83 c5 18          	add    $0x18,%rbp
    6fdd:	49 01 cc             	add    %rcx,%r12
    6fe0:	31 c9                	xor    %ecx,%ecx
    6fe2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6fe9:	1f 84 00 00 00 00 00 
    6ff0:	f6 c1 01             	test   $0x1,%cl
    6ff3:	ba 00 00 00 00       	mov    $0x0,%edx
    6ff8:	49 0f 45 d6          	cmovne %r14,%rdx
    6ffc:	48 89 94 24 80 00 00 	mov    %rdx,0x80(%rsp)
    7003:	00 
    7004:	4c 89 ac 24 88 00 00 	mov    %r13,0x88(%rsp)
    700b:	00 
    700c:	48 89 84 24 90 00 00 	mov    %rax,0x90(%rsp)
    7013:	00 
    7014:	c7 84 24 98 00 00 00 	movl   $0x0,0x98(%rsp)
    701b:	00 00 00 00 
    701f:	41 8b 56 04          	mov    0x4(%r14),%edx
    7023:	89 94 24 9c 00 00 00 	mov    %edx,0x9c(%rsp)
    702a:	4c 89 f2             	mov    %r14,%rdx
    702d:	48 2b 15 84 42 01 00 	sub    0x14284(%rip),%rdx        # 1b2b8 <fwp_gc+0x1030>
    7034:	44 89 bc 24 a0 00 00 	mov    %r15d,0xa0(%rsp)
    703b:	00 
    703c:	4c 8b 1d 9d 42 01 00 	mov    0x1429d(%rip),%r11        # 1b2e0 <fwp_gc+0x1058>
    7043:	49 c1 e3 10          	shl    $0x10,%r11
    7047:	4c 39 da             	cmp    %r11,%rdx
    704a:	73 74                	jae    70c0 <fwp_apply_borrowed_prefix+0x120>
    704c:	48 8b 3d ad 42 01 00 	mov    0x142ad(%rip),%rdi        # 1b300 <fwp_gc+0x1078>
    7053:	49 89 d0             	mov    %rdx,%r8
    7056:	49 c1 e8 10          	shr    $0x10,%r8
    705a:	4d 69 c8 28 12 00 00 	imul   $0x1228,%r8,%r9
    7061:	46 0f b6 14 0f       	movzbl (%rdi,%r9,1),%r10d
    7066:	49 89 d0             	mov    %rdx,%r8
    7069:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    7070:	75 1e                	jne    7090 <fwp_apply_borrowed_prefix+0xf0>
    7072:	41 80 fa 02          	cmp    $0x2,%r10b
    7076:	75 18                	jne    7090 <fwp_apply_borrowed_prefix+0xf0>
    7078:	4c 01 cf             	add    %r9,%rdi
    707b:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    7082:	80 3f 00             	cmpb   $0x0,(%rdi)
    7085:	75 45                	jne    70cc <fwp_apply_borrowed_prefix+0x12c>
    7087:	eb 37                	jmp    70c0 <fwp_apply_borrowed_prefix+0x120>
    7089:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    7090:	41 80 fa 01          	cmp    $0x1,%r10b
    7094:	75 2a                	jne    70c0 <fwp_apply_borrowed_prefix+0x120>
    7096:	4e 8d 14 0f          	lea    (%rdi,%r9,1),%r10
    709a:	42 8b 7c 0f 20       	mov    0x20(%rdi,%r9,1),%edi
    709f:	4c 0f af c7          	imul   %rdi,%r8
    70a3:	49 c1 e8 20          	shr    $0x20,%r8
    70a7:	4b 8d 3c 10          	lea    (%r8,%r10,1),%rdi
    70ab:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    70b2:	80 3f 00             	cmpb   $0x0,(%rdi)
    70b5:	75 15                	jne    70cc <fwp_apply_borrowed_prefix+0x12c>
    70b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    70be:	00 00 
    70c0:	45 85 ff             	test   %r15d,%r15d
    70c3:	74 4b                	je     7110 <fwp_apply_borrowed_prefix+0x170>
    70c5:	48 83 78 18 00       	cmpq   $0x0,0x18(%rax)
    70ca:	74 44                	je     7110 <fwp_apply_borrowed_prefix+0x170>
    70cc:	48 8b 3d ed 4d 01 00 	mov    0x14ded(%rip),%rdi        # 1bec0 <fwp_cleanups>
    70d3:	48 89 7c 24 68       	mov    %rdi,0x68(%rsp)
    70d8:	48 8d 3d 61 08 00 00 	lea    0x861(%rip),%rdi        # 7940 <fwp_apply_release>
    70df:	48 89 7c 24 70       	mov    %rdi,0x70(%rsp)
    70e4:	48 8d bc 24 80 00 00 	lea    0x80(%rsp),%rdi
    70eb:	00 
    70ec:	48 89 7c 24 78       	mov    %rdi,0x78(%rsp)
    70f1:	48 8d 7c 24 68       	lea    0x68(%rsp),%rdi
    70f6:	48 89 3d c3 4d 01 00 	mov    %rdi,0x14dc3(%rip)        # 1bec0 <fwp_cleanups>
    70fd:	40 b7 01             	mov    $0x1,%dil
    7100:	89 7c 24 04          	mov    %edi,0x4(%rsp)
    7104:	f6 c1 01             	test   $0x1,%cl
    7107:	74 18                	je     7121 <fwp_apply_borrowed_prefix+0x181>
    7109:	e9 93 00 00 00       	jmp    71a1 <fwp_apply_borrowed_prefix+0x201>
    710e:	66 90                	xchg   %ax,%ax
    7110:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%rsp)
    7117:	00 
    7118:	f6 c1 01             	test   $0x1,%cl
    711b:	0f 85 80 00 00 00    	jne    71a1 <fwp_apply_borrowed_prefix+0x201>
    7121:	4c 39 da             	cmp    %r11,%rdx
    7124:	73 6f                	jae    7195 <fwp_apply_borrowed_prefix+0x1f5>
    7126:	48 8b 05 d3 41 01 00 	mov    0x141d3(%rip),%rax        # 1b300 <fwp_gc+0x1078>
    712d:	48 89 d1             	mov    %rdx,%rcx
    7130:	48 c1 e9 10          	shr    $0x10,%rcx
    7134:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    713b:	0f b6 3c 08          	movzbl (%rax,%rcx,1),%edi
    713f:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    7146:	75 13                	jne    715b <fwp_apply_borrowed_prefix+0x1bb>
    7148:	40 80 ff 02          	cmp    $0x2,%dil
    714c:	75 0d                	jne    715b <fwp_apply_borrowed_prefix+0x1bb>
    714e:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    7152:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    7159:	eb 20                	jmp    717b <fwp_apply_borrowed_prefix+0x1db>
    715b:	40 80 ff 01          	cmp    $0x1,%dil
    715f:	75 34                	jne    7195 <fwp_apply_borrowed_prefix+0x1f5>
    7161:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    7165:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    7169:	48 0f af d0          	imul   %rax,%rdx
    716d:	48 c1 ea 20          	shr    $0x20,%rdx
    7171:	48 01 d7             	add    %rdx,%rdi
    7174:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    717b:	0f b6 07             	movzbl (%rdi),%eax
    717e:	84 c0                	test   %al,%al
    7180:	74 13                	je     7195 <fwp_apply_borrowed_prefix+0x1f5>
    7182:	48 ff 05 2f 4d 01 00 	incq   0x14d2f(%rip)        # 1beb8 <measured_retains>
    7189:	3c fe                	cmp    $0xfe,%al
    718b:	0f 83 dd 01 00 00    	jae    736e <fwp_apply_borrowed_prefix+0x3ce>
    7191:	fe c0                	inc    %al
    7193:	88 07                	mov    %al,(%rdi)
    7195:	4c 89 b4 24 80 00 00 	mov    %r14,0x80(%rsp)
    719c:	00 
    719d:	48 8b 45 00          	mov    0x0(%rbp),%rax
    71a1:	45 8b 24 24          	mov    (%r12),%r12d
    71a5:	45 2b 66 04          	sub    0x4(%r14),%r12d
    71a9:	44 39 e6             	cmp    %r12d,%esi
    71ac:	44 89 64 24 14       	mov    %r12d,0x14(%rsp)
    71b1:	44 0f 42 e6          	cmovb  %esi,%r12d
    71b5:	45 39 e7             	cmp    %r12d,%r15d
    71b8:	44 89 e2             	mov    %r12d,%edx
    71bb:	41 0f 42 d7          	cmovb  %r15d,%edx
    71bf:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    71c6:	00 00 
    71c8:	4c 89 6c 24 20       	mov    %r13,0x20(%rsp)
    71cd:	4d 8d 6c d5 00       	lea    0x0(%r13,%rdx,8),%r13
    71d2:	4c 89 6c 24 48       	mov    %r13,0x48(%rsp)
    71d7:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    71dc:	c7 44 24 58 00 00 00 	movl   $0x0,0x58(%rsp)
    71e3:	00 
    71e4:	41 8b 4e 04          	mov    0x4(%r14),%ecx
    71e8:	01 d1                	add    %edx,%ecx
    71ea:	89 4c 24 5c          	mov    %ecx,0x5c(%rsp)
    71ee:	c7 44 24 60 00 00 00 	movl   $0x0,0x60(%rsp)
    71f5:	00 
    71f6:	31 db                	xor    %ebx,%ebx
    71f8:	b9 00 00 00 00       	mov    $0x0,%ecx
    71fd:	45 39 fc             	cmp    %r15d,%r12d
    7200:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)
    7205:	0f 86 a2 00 00 00    	jbe    72ad <fwp_apply_borrowed_prefix+0x30d>
    720b:	44 89 7c 24 0c       	mov    %r15d,0xc(%rsp)
    7210:	89 74 24 10          	mov    %esi,0x10(%rsp)
    7214:	48 83 78 18 00       	cmpq   $0x0,0x18(%rax)
    7219:	0f 95 c0             	setne  %al
    721c:	89 44 24 08          	mov    %eax,0x8(%rsp)
    7220:	74 2e                	je     7250 <fwp_apply_borrowed_prefix+0x2b0>
    7222:	48 8b 05 97 4c 01 00 	mov    0x14c97(%rip),%rax        # 1bec0 <fwp_cleanups>
    7229:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    722e:	48 8d 05 0b 07 00 00 	lea    0x70b(%rip),%rax        # 7940 <fwp_apply_release>
    7235:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    723a:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
    723f:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    7244:	48 8d 44 24 28       	lea    0x28(%rsp),%rax
    7249:	48 89 05 70 4c 01 00 	mov    %rax,0x14c70(%rip)        # 1bec0 <fwp_cleanups>
    7250:	45 89 e7             	mov    %r12d,%r15d
    7253:	41 29 d7             	sub    %edx,%r15d
    7256:	41 83 ff 01          	cmp    $0x1,%r15d
    725a:	41 83 d7 00          	adc    $0x0,%r15d
    725e:	49 c1 e7 03          	shl    $0x3,%r15
    7262:	89 d3                	mov    %edx,%ebx
    7264:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    726b:	00 00 00 00 00 
    7270:	48 8b 45 00          	mov    0x0(%rbp),%rax
    7274:	41 8b 76 04          	mov    0x4(%r14),%esi
    7278:	01 de                	add    %ebx,%esi
    727a:	4c 89 ef             	mov    %r13,%rdi
    727d:	ba 01 00 00 00       	mov    $0x1,%edx
    7282:	ff 50 10             	call   *0x10(%rax)
    7285:	8b 4c 24 60          	mov    0x60(%rsp),%ecx
    7289:	ff c1                	inc    %ecx
    728b:	89 4c 24 60          	mov    %ecx,0x60(%rsp)
    728f:	ff c3                	inc    %ebx
    7291:	49 83 c5 08          	add    $0x8,%r13
    7295:	49 83 c7 f8          	add    $0xfffffffffffffff8,%r15
    7299:	75 d5                	jne    7270 <fwp_apply_borrowed_prefix+0x2d0>
    729b:	8b 74 24 10          	mov    0x10(%rsp),%esi
    729f:	44 8b 7c 24 0c       	mov    0xc(%rsp),%r15d
    72a4:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
    72a9:	8b 5c 24 08          	mov    0x8(%rsp),%ebx
    72ad:	89 f5                	mov    %esi,%ebp
    72af:	89 4c 24 58          	mov    %ecx,0x58(%rsp)
    72b3:	48 c7 84 24 80 00 00 	movq   $0x0,0x80(%rsp)
    72ba:	00 00 00 00 00 
    72bf:	89 94 24 98 00 00 00 	mov    %edx,0x98(%rsp)
    72c6:	4c 89 f7             	mov    %r14,%rdi
    72c9:	44 89 e6             	mov    %r12d,%esi
    72cc:	4c 8b 6c 24 20       	mov    0x20(%rsp),%r13
    72d1:	4c 89 ea             	mov    %r13,%rdx
    72d4:	e8 d7 06 00 00       	call   79b0 <fwp_apply_owned>
    72d9:	49 89 c6             	mov    %rax,%r14
    72dc:	84 db                	test   %bl,%bl
    72de:	74 1e                	je     72fe <fwp_apply_borrowed_prefix+0x35e>
    72e0:	48 8d 44 24 28       	lea    0x28(%rsp),%rax
    72e5:	48 39 05 d4 4b 01 00 	cmp    %rax,0x14bd4(%rip)        # 1bec0 <fwp_cleanups>
    72ec:	0f 85 e5 00 00 00    	jne    73d7 <fwp_apply_borrowed_prefix+0x437>
    72f2:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    72f7:	48 89 05 c2 4b 01 00 	mov    %rax,0x14bc2(%rip)        # 1bec0 <fwp_cleanups>
    72fe:	80 7c 24 04 00       	cmpb   $0x0,0x4(%rsp)
    7303:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    7308:	89 ee                	mov    %ebp,%esi
    730a:	74 1e                	je     732a <fwp_apply_borrowed_prefix+0x38a>
    730c:	48 8d 44 24 68       	lea    0x68(%rsp),%rax
    7311:	48 39 05 a8 4b 01 00 	cmp    %rax,0x14ba8(%rip)        # 1bec0 <fwp_cleanups>
    7318:	0f 85 b9 00 00 00    	jne    73d7 <fwp_apply_borrowed_prefix+0x437>
    731e:	48 8b 44 24 68       	mov    0x68(%rsp),%rax
    7323:	48 89 05 96 4b 01 00 	mov    %rax,0x14b96(%rip)        # 1bec0 <fwp_cleanups>
    732a:	3b 74 24 14          	cmp    0x14(%rsp),%esi
    732e:	0f 86 8e 00 00 00    	jbe    73c2 <fwp_apply_borrowed_prefix+0x422>
    7334:	44 89 e0             	mov    %r12d,%eax
    7337:	4d 8d 6c c5 00       	lea    0x0(%r13,%rax,8),%r13
    733c:	44 29 e6             	sub    %r12d,%esi
    733f:	41 29 cf             	sub    %ecx,%r15d
    7342:	48 8b 05 27 4b 01 00 	mov    0x14b27(%rip),%rax        # 1be70 <fwp_fns>
    7349:	41 8b 0e             	mov    (%r14),%ecx
    734c:	48 c1 e1 05          	shl    $0x5,%rcx
    7350:	4c 8d 24 08          	lea    (%rax,%rcx,1),%r12
    7354:	48 8d 2c 08          	lea    (%rax,%rcx,1),%rbp
    7358:	48 83 c5 18          	add    $0x18,%rbp
    735c:	48 8b 44 08 18       	mov    0x18(%rax,%rcx,1),%rax
    7361:	b1 01                	mov    $0x1,%cl
    7363:	48 85 c0             	test   %rax,%rax
    7366:	0f 85 84 fc ff ff    	jne    6ff0 <fwp_apply_borrowed_prefix+0x50>
    736c:	eb 0e                	jmp    737c <fwp_apply_borrowed_prefix+0x3dc>
    736e:	89 f3                	mov    %esi,%ebx
    7370:	e8 0b 33 00 00       	call   a680 <fwp_rc_wide_dup>
    7375:	89 de                	mov    %ebx,%esi
    7377:	e9 19 fe ff ff       	jmp    7195 <fwp_apply_borrowed_prefix+0x1f5>
    737c:	4c 89 f7             	mov    %r14,%rdi
    737f:	89 f3                	mov    %esi,%ebx
    7381:	e8 8a f5 ff ff       	call   6910 <fwp_rc_share>
    7386:	89 dd                	mov    %ebx,%ebp
    7388:	85 db                	test   %ebx,%ebx
    738a:	74 26                	je     73b2 <fwp_apply_borrowed_prefix+0x412>
    738c:	89 eb                	mov    %ebp,%ebx
    738e:	45 31 ff             	xor    %r15d,%r15d
    7391:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7398:	0f 1f 84 00 00 00 00 
    739f:	00 
    73a0:	4b 8b 7c fd 00       	mov    0x0(%r13,%r15,8),%rdi
    73a5:	e8 66 f5 ff ff       	call   6910 <fwp_rc_share>
    73aa:	49 ff c7             	inc    %r15
    73ad:	4c 39 fb             	cmp    %r15,%rbx
    73b0:	75 ee                	jne    73a0 <fwp_apply_borrowed_prefix+0x400>
    73b2:	4c 89 f7             	mov    %r14,%rdi
    73b5:	89 ee                	mov    %ebp,%esi
    73b7:	4c 89 ea             	mov    %r13,%rdx
    73ba:	e8 21 00 00 00       	call   73e0 <fwp_apply>
    73bf:	49 89 c6             	mov    %rax,%r14
    73c2:	4c 89 f0             	mov    %r14,%rax
    73c5:	48 81 c4 a8 00 00 00 	add    $0xa8,%rsp
    73cc:	5b                   	pop    %rbx
    73cd:	41 5c                	pop    %r12
    73cf:	41 5d                	pop    %r13
    73d1:	41 5e                	pop    %r14
    73d3:	41 5f                	pop    %r15
    73d5:	5d                   	pop    %rbp
    73d6:	c3                   	ret
    73d7:	e8 94 bc ff ff       	call   3070 <abort@plt>
    73dc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000073e0 <fwp_apply>:
    73e0:	55                   	push   %rbp
    73e1:	48 89 e5             	mov    %rsp,%rbp
    73e4:	41 57                	push   %r15
    73e6:	41 56                	push   %r14
    73e8:	41 55                	push   %r13
    73ea:	41 54                	push   %r12
    73ec:	53                   	push   %rbx
    73ed:	48 83 ec 18          	sub    $0x18,%rsp
    73f1:	48 89 d3             	mov    %rdx,%rbx
    73f4:	49 89 ff             	mov    %rdi,%r15
    73f7:	eb 23                	jmp    741c <fwp_apply+0x3c>
    73f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    7400:	4a 8d 1c f3          	lea    (%rbx,%r14,8),%rbx
    7404:	31 c9                	xor    %ecx,%ecx
    7406:	49 89 c7             	mov    %rax,%r15
    7409:	4c 8b 75 c8          	mov    -0x38(%rbp),%r14
    740d:	48 8b 65 c0          	mov    -0x40(%rbp),%rsp
    7411:	89 d6                	mov    %edx,%esi
    7413:	83 f9 01             	cmp    $0x1,%ecx
    7416:	0f 84 aa 04 00 00    	je     78c6 <fwp_apply+0x4e6>
    741c:	48 8b 05 4d 4a 01 00 	mov    0x14a4d(%rip),%rax        # 1be70 <fwp_fns>
    7423:	41 8b 0f             	mov    (%r15),%ecx
    7426:	45 8b 6f 04          	mov    0x4(%r15),%r13d
    742a:	48 c1 e1 05          	shl    $0x5,%rcx
    742e:	44 8b 24 08          	mov    (%rax,%rcx,1),%r12d
    7432:	4d 85 ed             	test   %r13,%r13
    7435:	75 39                	jne    7470 <fwp_apply+0x90>
    7437:	41 8d 54 24 ff       	lea    -0x1(%r12),%edx
    743c:	39 f2                	cmp    %esi,%edx
    743e:	73 30                	jae    7470 <fwp_apply+0x90>
    7440:	48 89 df             	mov    %rbx,%rdi
    7443:	49 89 f7             	mov    %rsi,%r15
    7446:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    744a:	4c 89 fe             	mov    %r15,%rsi
    744d:	49 89 c7             	mov    %rax,%r15
    7450:	44 39 e6             	cmp    %r12d,%esi
    7453:	0f 84 b6 02 00 00    	je     770f <fwp_apply+0x32f>
    7459:	4a 8d 1c e3          	lea    (%rbx,%r12,8),%rbx
    745d:	44 29 e6             	sub    %r12d,%esi
    7460:	b9 03 00 00 00       	mov    $0x3,%ecx
    7465:	83 f9 01             	cmp    $0x1,%ecx
    7468:	75 b2                	jne    741c <fwp_apply+0x3c>
    746a:	e9 57 04 00 00       	jmp    78c6 <fwp_apply+0x4e6>
    746f:	90                   	nop
    7470:	4c 89 75 c8          	mov    %r14,-0x38(%rbp)
    7474:	46 8d 34 2e          	lea    (%rsi,%r13,1),%r14d
    7478:	45 39 e6             	cmp    %r12d,%r14d
    747b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    747f:	0f 82 1a 02 00 00    	jb     769f <fwp_apply+0x2bf>
    7485:	48 89 65 c0          	mov    %rsp,-0x40(%rbp)
    7489:	45 89 e3             	mov    %r12d,%r11d
    748c:	41 83 fc 02          	cmp    $0x2,%r12d
    7490:	ba 01 00 00 00       	mov    $0x1,%edx
    7495:	41 0f 43 d4          	cmovae %r12d,%edx
    7499:	48 8d 14 d5 0f 00 00 	lea    0xf(,%rdx,8),%rdx
    74a0:	00 
    74a1:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
    74a5:	48 89 e7             	mov    %rsp,%rdi
    74a8:	48 29 d7             	sub    %rdx,%rdi
    74ab:	48 89 fc             	mov    %rdi,%rsp
    74ae:	4d 85 ed             	test   %r13,%r13
    74b1:	0f 84 c9 00 00 00    	je     7580 <fwp_apply+0x1a0>
    74b7:	41 83 fd 04          	cmp    $0x4,%r13d
    74bb:	72 10                	jb     74cd <fwp_apply+0xed>
    74bd:	48 89 fa             	mov    %rdi,%rdx
    74c0:	4c 29 fa             	sub    %r15,%rdx
    74c3:	48 83 c2 f8          	add    $0xfffffffffffffff8,%rdx
    74c7:	48 83 fa 20          	cmp    $0x20,%rdx
    74cb:	73 65                	jae    7532 <fwp_apply+0x152>
    74cd:	31 d2                	xor    %edx,%edx
    74cf:	4d 89 e8             	mov    %r13,%r8
    74d2:	49 89 d2             	mov    %rdx,%r10
    74d5:	49 83 e0 03          	and    $0x3,%r8
    74d9:	74 16                	je     74f1 <fwp_apply+0x111>
    74db:	49 89 d2             	mov    %rdx,%r10
    74de:	66 90                	xchg   %ax,%ax
    74e0:	4f 8b 4c d7 08       	mov    0x8(%r15,%r10,8),%r9
    74e5:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    74e9:	49 ff c2             	inc    %r10
    74ec:	49 ff c8             	dec    %r8
    74ef:	75 ef                	jne    74e0 <fwp_apply+0x100>
    74f1:	4c 29 ea             	sub    %r13,%rdx
    74f4:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    74f8:	0f 87 82 00 00 00    	ja     7580 <fwp_apply+0x1a0>
    74fe:	66 90                	xchg   %ax,%ax
    7500:	4b 8b 54 d7 08       	mov    0x8(%r15,%r10,8),%rdx
    7505:	4a 89 14 d7          	mov    %rdx,(%rdi,%r10,8)
    7509:	4b 8b 54 d7 10       	mov    0x10(%r15,%r10,8),%rdx
    750e:	4a 89 54 d7 08       	mov    %rdx,0x8(%rdi,%r10,8)
    7513:	4b 8b 54 d7 18       	mov    0x18(%r15,%r10,8),%rdx
    7518:	4a 89 54 d7 10       	mov    %rdx,0x10(%rdi,%r10,8)
    751d:	4b 8b 54 d7 20       	mov    0x20(%r15,%r10,8),%rdx
    7522:	4a 89 54 d7 18       	mov    %rdx,0x18(%rdi,%r10,8)
    7527:	49 83 c2 04          	add    $0x4,%r10
    752b:	4d 39 d5             	cmp    %r10,%r13
    752e:	75 d0                	jne    7500 <fwp_apply+0x120>
    7530:	eb 4e                	jmp    7580 <fwp_apply+0x1a0>
    7532:	44 89 ea             	mov    %r13d,%edx
    7535:	83 e2 fc             	and    $0xfffffffc,%edx
    7538:	4e 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%r9
    753f:	00 
    7540:	49 83 e1 e0          	and    $0xffffffffffffffe0,%r9
    7544:	45 31 c0             	xor    %r8d,%r8d
    7547:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    754e:	00 00 
    7550:	43 0f 10 44 07 08    	movups 0x8(%r15,%r8,1),%xmm0
    7556:	43 0f 10 4c 07 18    	movups 0x18(%r15,%r8,1),%xmm1
    755c:	42 0f 29 04 07       	movaps %xmm0,(%rdi,%r8,1)
    7561:	42 0f 29 4c 07 10    	movaps %xmm1,0x10(%rdi,%r8,1)
    7567:	49 83 c0 20          	add    $0x20,%r8
    756b:	4d 39 c1             	cmp    %r8,%r9
    756e:	75 e0                	jne    7550 <fwp_apply+0x170>
    7570:	4c 39 ea             	cmp    %r13,%rdx
    7573:	0f 85 56 ff ff ff    	jne    74cf <fwp_apply+0xef>
    7579:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    7580:	45 29 eb             	sub    %r13d,%r11d
    7583:	45 89 de             	mov    %r11d,%r14d
    7586:	45 39 ec             	cmp    %r13d,%r12d
    7589:	0f 84 85 00 00 00    	je     7614 <fwp_apply+0x234>
    758f:	41 83 fb 0e          	cmp    $0xe,%r11d
    7593:	0f 83 a0 00 00 00    	jae    7639 <fwp_apply+0x259>
    7599:	31 d2                	xor    %edx,%edx
    759b:	4d 89 f0             	mov    %r14,%r8
    759e:	48 89 d6             	mov    %rdx,%rsi
    75a1:	49 83 e0 03          	and    $0x3,%r8
    75a5:	74 1d                	je     75c4 <fwp_apply+0x1e4>
    75a7:	48 89 d6             	mov    %rdx,%rsi
    75aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    75b0:	4c 8b 0c f3          	mov    (%rbx,%rsi,8),%r9
    75b4:	46 8d 14 2e          	lea    (%rsi,%r13,1),%r10d
    75b8:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    75bc:	48 ff c6             	inc    %rsi
    75bf:	49 ff c8             	dec    %r8
    75c2:	75 ec                	jne    75b0 <fwp_apply+0x1d0>
    75c4:	4c 29 f2             	sub    %r14,%rdx
    75c7:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    75cb:	77 47                	ja     7614 <fwp_apply+0x234>
    75cd:	0f 1f 00             	nopl   (%rax)
    75d0:	48 8b 14 f3          	mov    (%rbx,%rsi,8),%rdx
    75d4:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    75d8:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    75dc:	48 8b 54 f3 08       	mov    0x8(%rbx,%rsi,8),%rdx
    75e1:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    75e5:	41 ff c0             	inc    %r8d
    75e8:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    75ec:	48 8b 54 f3 10       	mov    0x10(%rbx,%rsi,8),%rdx
    75f1:	45 8d 44 35 02       	lea    0x2(%r13,%rsi,1),%r8d
    75f6:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    75fa:	48 8b 54 f3 18       	mov    0x18(%rbx,%rsi,8),%rdx
    75ff:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    7603:	41 83 c0 03          	add    $0x3,%r8d
    7607:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    760b:	48 83 c6 04          	add    $0x4,%rsi
    760f:	49 39 f6             	cmp    %rsi,%r14
    7612:	75 bc                	jne    75d0 <fwp_apply+0x1f0>
    7614:	45 89 dc             	mov    %r11d,%r12d
    7617:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    761b:	b9 01 00 00 00       	mov    $0x1,%ecx
    7620:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    7624:	89 f2                	mov    %esi,%edx
    7626:	44 29 e2             	sub    %r12d,%edx
    7629:	0f 85 d1 fd ff ff    	jne    7400 <fwp_apply+0x20>
    762f:	89 f2                	mov    %esi,%edx
    7631:	49 89 c6             	mov    %rax,%r14
    7634:	e9 d4 fd ff ff       	jmp    740d <fwp_apply+0x2d>
    7639:	49 8d 56 ff          	lea    -0x1(%r14),%rdx
    763d:	89 d6                	mov    %edx,%esi
    763f:	44 01 ee             	add    %r13d,%esi
    7642:	0f 82 51 ff ff ff    	jb     7599 <fwp_apply+0x1b9>
    7648:	48 c1 ea 20          	shr    $0x20,%rdx
    764c:	ba 00 00 00 00       	mov    $0x0,%edx
    7651:	0f 85 44 ff ff ff    	jne    759b <fwp_apply+0x1bb>
    7657:	4a 8d 14 ef          	lea    (%rdi,%r13,8),%rdx
    765b:	48 29 da             	sub    %rbx,%rdx
    765e:	48 83 fa 20          	cmp    $0x20,%rdx
    7662:	0f 82 31 ff ff ff    	jb     7599 <fwp_apply+0x1b9>
    7668:	44 89 f2             	mov    %r14d,%edx
    766b:	83 e2 fc             	and    $0xfffffffc,%edx
    766e:	31 f6                	xor    %esi,%esi
    7670:	0f 10 04 f3          	movups (%rbx,%rsi,8),%xmm0
    7674:	0f 10 4c f3 10       	movups 0x10(%rbx,%rsi,8),%xmm1
    7679:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    767d:	42 0f 11 04 c7       	movups %xmm0,(%rdi,%r8,8)
    7682:	42 0f 11 4c c7 10    	movups %xmm1,0x10(%rdi,%r8,8)
    7688:	48 83 c6 04          	add    $0x4,%rsi
    768c:	48 39 f2             	cmp    %rsi,%rdx
    768f:	75 df                	jne    7670 <fwp_apply+0x290>
    7691:	4c 39 f2             	cmp    %r14,%rdx
    7694:	0f 85 01 ff ff ff    	jne    759b <fwp_apply+0x1bb>
    769a:	e9 75 ff ff ff       	jmp    7614 <fwp_apply+0x234>
    769f:	44 89 f1             	mov    %r14d,%ecx
    76a2:	48 8d 3c cd 08 00 00 	lea    0x8(,%rcx,8),%rdi
    76a9:	00 
    76aa:	48 ff 05 f7 47 01 00 	incq   0x147f7(%rip)        # 1bea8 <measured_calls>
    76b1:	48 01 3d f8 47 01 00 	add    %rdi,0x147f8(%rip)        # 1beb0 <measured_bytes>
    76b8:	41 81 fe ff 07 00 00 	cmp    $0x7ff,%r14d
    76bf:	77 6e                	ja     772f <fwp_apply+0x34f>
    76c1:	48 c1 e1 03          	shl    $0x3,%rcx
    76c5:	48 83 c1 17          	add    $0x17,%rcx
    76c9:	48 c1 e9 04          	shr    $0x4,%rcx
    76cd:	48 8d 05 b4 2b 01 00 	lea    0x12bb4(%rip),%rax        # 1a288 <fwp_gc>
    76d4:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    76db:	00 
    76dc:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    76e3:	48 29 15 9e 2b 01 00 	sub    %rdx,0x12b9e(%rip)        # 1a288 <fwp_gc>
    76ea:	78 43                	js     772f <fwp_apply+0x34f>
    76ec:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    76f0:	4c 8d 04 c8          	lea    (%rax,%rcx,8),%r8
    76f4:	49 81 c0 88 07 00 00 	add    $0x788,%r8
    76fb:	4d 8b 20             	mov    (%r8),%r12
    76fe:	4d 85 e4             	test   %r12,%r12
    7701:	74 14                	je     7717 <fwp_apply+0x337>
    7703:	49 8b 04 24          	mov    (%r12),%rax
    7707:	48 f7 d0             	not    %rax
    770a:	49 89 00             	mov    %rax,(%r8)
    770d:	eb 40                	jmp    774f <fwp_apply+0x36f>
    770f:	4d 89 fe             	mov    %r15,%r14
    7712:	e9 af 01 00 00       	jmp    78c6 <fwp_apply+0x4e6>
    7717:	4c 8b a4 c8 90 07 00 	mov    0x790(%rax,%rcx,8),%r12
    771e:	00 
    771f:	4c 8b 84 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%r8
    7726:	00 
    7727:	4d 29 e0             	sub    %r12,%r8
    772a:	49 39 d0             	cmp    %rdx,%r8
    772d:	73 0f                	jae    773e <fwp_apply+0x35e>
    772f:	be 02 00 00 00       	mov    $0x2,%esi
    7734:	e8 87 0b 00 00       	call   82c0 <fwp_gc_alloc_slow>
    7739:	49 89 c4             	mov    %rax,%r12
    773c:	eb 1b                	jmp    7759 <fwp_apply+0x379>
    773e:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    7742:	48 05 90 07 00 00    	add    $0x790,%rax
    7748:	49 8d 0c 14          	lea    (%r12,%rdx,1),%rcx
    774c:	48 89 08             	mov    %rcx,(%rax)
    774f:	4c 89 e7             	mov    %r12,%rdi
    7752:	31 f6                	xor    %esi,%esi
    7754:	e8 b7 ba ff ff       	call   3210 <memset@plt>
    7759:	41 8b 07             	mov    (%r15),%eax
    775c:	41 89 04 24          	mov    %eax,(%r12)
    7760:	45 89 74 24 04       	mov    %r14d,0x4(%r12)
    7765:	4d 85 ed             	test   %r13,%r13
    7768:	4d 89 e6             	mov    %r12,%r14
    776b:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    776f:	0f 84 bc 00 00 00    	je     7831 <fwp_apply+0x451>
    7775:	31 c0                	xor    %eax,%eax
    7777:	41 83 fd 06          	cmp    $0x6,%r13d
    777b:	72 49                	jb     77c6 <fwp_apply+0x3e6>
    777d:	4c 89 f1             	mov    %r14,%rcx
    7780:	4c 29 f9             	sub    %r15,%rcx
    7783:	48 83 f9 20          	cmp    $0x20,%rcx
    7787:	72 3d                	jb     77c6 <fwp_apply+0x3e6>
    7789:	44 89 e8             	mov    %r13d,%eax
    778c:	83 e0 fc             	and    $0xfffffffc,%eax
    778f:	4a 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%rcx
    7796:	00 
    7797:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    779b:	31 d2                	xor    %edx,%edx
    779d:	0f 1f 00             	nopl   (%rax)
    77a0:	41 0f 10 44 17 08    	movups 0x8(%r15,%rdx,1),%xmm0
    77a6:	41 0f 10 4c 17 18    	movups 0x18(%r15,%rdx,1),%xmm1
    77ac:	41 0f 11 44 16 08    	movups %xmm0,0x8(%r14,%rdx,1)
    77b2:	41 0f 11 4c 16 18    	movups %xmm1,0x18(%r14,%rdx,1)
    77b8:	48 83 c2 20          	add    $0x20,%rdx
    77bc:	48 39 d1             	cmp    %rdx,%rcx
    77bf:	75 df                	jne    77a0 <fwp_apply+0x3c0>
    77c1:	4c 39 e8             	cmp    %r13,%rax
    77c4:	74 6b                	je     7831 <fwp_apply+0x451>
    77c6:	4c 89 ea             	mov    %r13,%rdx
    77c9:	48 89 c1             	mov    %rax,%rcx
    77cc:	48 83 e2 03          	and    $0x3,%rdx
    77d0:	74 20                	je     77f2 <fwp_apply+0x412>
    77d2:	48 89 c1             	mov    %rax,%rcx
    77d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    77dc:	00 00 00 00 
    77e0:	49 8b 74 cf 08       	mov    0x8(%r15,%rcx,8),%rsi
    77e5:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    77ea:	48 ff c1             	inc    %rcx
    77ed:	48 ff ca             	dec    %rdx
    77f0:	75 ee                	jne    77e0 <fwp_apply+0x400>
    77f2:	4c 29 e8             	sub    %r13,%rax
    77f5:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    77f9:	77 36                	ja     7831 <fwp_apply+0x451>
    77fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7800:	49 8b 44 cf 08       	mov    0x8(%r15,%rcx,8),%rax
    7805:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    780a:	49 8b 44 cf 10       	mov    0x10(%r15,%rcx,8),%rax
    780f:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    7814:	49 8b 44 cf 18       	mov    0x18(%r15,%rcx,8),%rax
    7819:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    781e:	49 8b 44 cf 20       	mov    0x20(%r15,%rcx,8),%rax
    7823:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    7828:	48 83 c1 04          	add    $0x4,%rcx
    782c:	49 39 cd             	cmp    %rcx,%r13
    782f:	75 cf                	jne    7800 <fwp_apply+0x420>
    7831:	85 ff                	test   %edi,%edi
    7833:	0f 84 8d 00 00 00    	je     78c6 <fwp_apply+0x4e6>
    7839:	89 f8                	mov    %edi,%eax
    783b:	83 ff 14             	cmp    $0x14,%edi
    783e:	0f 83 94 00 00 00    	jae    78d8 <fwp_apply+0x4f8>
    7844:	31 c9                	xor    %ecx,%ecx
    7846:	48 89 c6             	mov    %rax,%rsi
    7849:	48 89 ca             	mov    %rcx,%rdx
    784c:	48 83 e6 03          	and    $0x3,%rsi
    7850:	74 23                	je     7875 <fwp_apply+0x495>
    7852:	48 89 ca             	mov    %rcx,%rdx
    7855:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    785c:	00 00 00 00 
    7860:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    7864:	46 8d 04 2a          	lea    (%rdx,%r13,1),%r8d
    7868:	4b 89 7c c6 08       	mov    %rdi,0x8(%r14,%r8,8)
    786d:	48 ff c2             	inc    %rdx
    7870:	48 ff ce             	dec    %rsi
    7873:	75 eb                	jne    7860 <fwp_apply+0x480>
    7875:	48 29 c1             	sub    %rax,%rcx
    7878:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    787c:	77 48                	ja     78c6 <fwp_apply+0x4e6>
    787e:	66 90                	xchg   %ax,%ax
    7880:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    7884:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    7888:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    788d:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    7892:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    7896:	ff c6                	inc    %esi
    7898:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    789d:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    78a2:	41 8d 74 15 02       	lea    0x2(%r13,%rdx,1),%esi
    78a7:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    78ac:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    78b1:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    78b5:	83 c6 03             	add    $0x3,%esi
    78b8:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    78bd:	48 83 c2 04          	add    $0x4,%rdx
    78c1:	48 39 d0             	cmp    %rdx,%rax
    78c4:	75 ba                	jne    7880 <fwp_apply+0x4a0>
    78c6:	4c 89 f0             	mov    %r14,%rax
    78c9:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    78cd:	5b                   	pop    %rbx
    78ce:	41 5c                	pop    %r12
    78d0:	41 5d                	pop    %r13
    78d2:	41 5e                	pop    %r14
    78d4:	41 5f                	pop    %r15
    78d6:	5d                   	pop    %rbp
    78d7:	c3                   	ret
    78d8:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    78dc:	31 c9                	xor    %ecx,%ecx
    78de:	89 d6                	mov    %edx,%esi
    78e0:	44 01 ee             	add    %r13d,%esi
    78e3:	0f 82 5d ff ff ff    	jb     7846 <fwp_apply+0x466>
    78e9:	48 c1 ea 20          	shr    $0x20,%rdx
    78ed:	0f 85 53 ff ff ff    	jne    7846 <fwp_apply+0x466>
    78f3:	4b 8d 0c ee          	lea    (%r14,%r13,8),%rcx
    78f7:	48 29 d9             	sub    %rbx,%rcx
    78fa:	48 83 c1 08          	add    $0x8,%rcx
    78fe:	48 83 f9 20          	cmp    $0x20,%rcx
    7902:	0f 82 3c ff ff ff    	jb     7844 <fwp_apply+0x464>
    7908:	89 c1                	mov    %eax,%ecx
    790a:	83 e1 fc             	and    $0xfffffffc,%ecx
    790d:	31 d2                	xor    %edx,%edx
    790f:	90                   	nop
    7910:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    7914:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    7919:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    791d:	41 0f 11 44 f6 08    	movups %xmm0,0x8(%r14,%rsi,8)
    7923:	41 0f 11 4c f6 18    	movups %xmm1,0x18(%r14,%rsi,8)
    7929:	48 83 c2 04          	add    $0x4,%rdx
    792d:	48 39 d1             	cmp    %rdx,%rcx
    7930:	75 de                	jne    7910 <fwp_apply+0x530>
    7932:	48 39 c1             	cmp    %rax,%rcx
    7935:	0f 85 0b ff ff ff    	jne    7846 <fwp_apply+0x466>
    793b:	eb 89                	jmp    78c6 <fwp_apply+0x4e6>
    793d:	0f 1f 00             	nopl   (%rax)

0000000000007940 <fwp_apply_release>:
    7940:	41 56                	push   %r14
    7942:	53                   	push   %rbx
    7943:	50                   	push   %rax
    7944:	48 8b 1f             	mov    (%rdi),%rbx
    7947:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    794e:	8b 47 20             	mov    0x20(%rdi),%eax
    7951:	8b 4f 18             	mov    0x18(%rdi),%ecx
    7954:	89 c2                	mov    %eax,%edx
    7956:	29 ca                	sub    %ecx,%edx
    7958:	74 2d                	je     7987 <fwp_apply_release+0x47>
    795a:	48 8b 77 10          	mov    0x10(%rdi),%rsi
    795e:	4c 8b 46 18          	mov    0x18(%rsi),%r8
    7962:	4d 85 c0             	test   %r8,%r8
    7965:	74 20                	je     7987 <fwp_apply_release+0x47>
    7967:	48 89 c8             	mov    %rcx,%rax
    796a:	48 c1 e0 03          	shl    $0x3,%rax
    796e:	48 03 47 08          	add    0x8(%rdi),%rax
    7972:	8b 77 1c             	mov    0x1c(%rdi),%esi
    7975:	01 ce                	add    %ecx,%esi
    7977:	49 89 fe             	mov    %rdi,%r14
    797a:	48 89 c7             	mov    %rax,%rdi
    797d:	41 ff d0             	call   *%r8
    7980:	4c 89 f7             	mov    %r14,%rdi
    7983:	41 8b 46 20          	mov    0x20(%r14),%eax
    7987:	89 47 18             	mov    %eax,0x18(%rdi)
    798a:	48 85 db             	test   %rbx,%rbx
    798d:	74 0f                	je     799e <fwp_apply_release+0x5e>
    798f:	48 89 df             	mov    %rbx,%rdi
    7992:	48 83 c4 08          	add    $0x8,%rsp
    7996:	5b                   	pop    %rbx
    7997:	41 5e                	pop    %r14
    7999:	e9 42 29 00 00       	jmp    a2e0 <fwp_closure_drop>
    799e:	48 83 c4 08          	add    $0x8,%rsp
    79a2:	5b                   	pop    %rbx
    79a3:	41 5e                	pop    %r14
    79a5:	c3                   	ret
    79a6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    79ad:	00 00 00 

00000000000079b0 <fwp_apply_owned>:
    79b0:	55                   	push   %rbp
    79b1:	48 89 e5             	mov    %rsp,%rbp
    79b4:	41 57                	push   %r15
    79b6:	41 56                	push   %r14
    79b8:	41 55                	push   %r13
    79ba:	41 54                	push   %r12
    79bc:	53                   	push   %rbx
    79bd:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    79c4:	48 89 d3             	mov    %rdx,%rbx
    79c7:	41 89 f5             	mov    %esi,%r13d
    79ca:	48 8b 05 9f 44 01 00 	mov    0x1449f(%rip),%rax        # 1be70 <fwp_fns>
    79d1:	8b 17                	mov    (%rdi),%edx
    79d3:	48 89 d6             	mov    %rdx,%rsi
    79d6:	48 c1 e6 05          	shl    $0x5,%rsi
    79da:	48 8b 4c 30 18       	mov    0x18(%rax,%rsi,1),%rcx
    79df:	48 85 c9             	test   %rcx,%rcx
    79e2:	0f 84 fa 03 00 00    	je     7de2 <fwp_apply_owned+0x432>
    79e8:	4c 8d 14 30          	lea    (%rax,%rsi,1),%r10
    79ec:	49 83 c2 18          	add    $0x18,%r10
    79f0:	49 89 fc             	mov    %rdi,%r12
    79f3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    79fa:	84 00 00 00 00 00 
    7a00:	48 c1 e2 05          	shl    $0x5,%rdx
    7a04:	8b 04 10             	mov    (%rax,%rdx,1),%eax
    7a07:	45 8b 7c 24 04       	mov    0x4(%r12),%r15d
    7a0c:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
    7a13:	48 89 9d 70 ff ff ff 	mov    %rbx,-0x90(%rbp)
    7a1a:	48 89 8d 78 ff ff ff 	mov    %rcx,-0x88(%rbp)
    7a21:	c7 45 80 00 00 00 00 	movl   $0x0,-0x80(%rbp)
    7a28:	44 89 7d 84          	mov    %r15d,-0x7c(%rbp)
    7a2c:	48 89 fa             	mov    %rdi,%rdx
    7a2f:	48 2b 15 82 38 01 00 	sub    0x13882(%rip),%rdx        # 1b2b8 <fwp_gc+0x1030>
    7a36:	44 89 6d 88          	mov    %r13d,-0x78(%rbp)
    7a3a:	48 8b 35 9f 38 01 00 	mov    0x1389f(%rip),%rsi        # 1b2e0 <fwp_gc+0x1058>
    7a41:	48 c1 e6 10          	shl    $0x10,%rsi
    7a45:	48 39 f2             	cmp    %rsi,%rdx
    7a48:	73 76                	jae    7ac0 <fwp_apply_owned+0x110>
    7a4a:	48 8b 35 af 38 01 00 	mov    0x138af(%rip),%rsi        # 1b300 <fwp_gc+0x1078>
    7a51:	49 89 d0             	mov    %rdx,%r8
    7a54:	49 c1 e8 10          	shr    $0x10,%r8
    7a58:	4d 69 c8 28 12 00 00 	imul   $0x1228,%r8,%r9
    7a5f:	46 0f b6 04 0e       	movzbl (%rsi,%r9,1),%r8d
    7a64:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    7a6b:	75 23                	jne    7a90 <fwp_apply_owned+0xe0>
    7a6d:	41 80 f8 02          	cmp    $0x2,%r8b
    7a71:	75 1d                	jne    7a90 <fwp_apply_owned+0xe0>
    7a73:	4a 8d 14 0e          	lea    (%rsi,%r9,1),%rdx
    7a77:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    7a7e:	80 3a 00             	cmpb   $0x0,(%rdx)
    7a81:	75 52                	jne    7ad5 <fwp_apply_owned+0x125>
    7a83:	eb 3b                	jmp    7ac0 <fwp_apply_owned+0x110>
    7a85:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    7a8c:	00 00 00 00 
    7a90:	41 80 f8 01          	cmp    $0x1,%r8b
    7a94:	75 2a                	jne    7ac0 <fwp_apply_owned+0x110>
    7a96:	4e 8d 04 0e          	lea    (%rsi,%r9,1),%r8
    7a9a:	42 8b 74 0e 20       	mov    0x20(%rsi,%r9,1),%esi
    7a9f:	48 0f af d6          	imul   %rsi,%rdx
    7aa3:	48 c1 ea 20          	shr    $0x20,%rdx
    7aa7:	4c 01 c2             	add    %r8,%rdx
    7aaa:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    7ab1:	80 3a 00             	cmpb   $0x0,(%rdx)
    7ab4:	75 1f                	jne    7ad5 <fwp_apply_owned+0x125>
    7ab6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    7abd:	00 00 00 
    7ac0:	48 83 79 18 00       	cmpq   $0x0,0x18(%rcx)
    7ac5:	74 49                	je     7b10 <fwp_apply_owned+0x160>
    7ac7:	4d 85 ff             	test   %r15,%r15
    7aca:	75 09                	jne    7ad5 <fwp_apply_owned+0x125>
    7acc:	31 d2                	xor    %edx,%edx
    7ace:	41 39 c5             	cmp    %eax,%r13d
    7ad1:	72 02                	jb     7ad5 <fwp_apply_owned+0x125>
    7ad3:	76 3d                	jbe    7b12 <fwp_apply_owned+0x162>
    7ad5:	48 8b 15 e4 43 01 00 	mov    0x143e4(%rip),%rdx        # 1bec0 <fwp_cleanups>
    7adc:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
    7ae0:	48 8d 15 59 fe ff ff 	lea    -0x1a7(%rip),%rdx        # 7940 <fwp_apply_release>
    7ae7:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
    7aeb:	48 8d 95 68 ff ff ff 	lea    -0x98(%rbp),%rdx
    7af2:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
    7af6:	48 8d 55 98          	lea    -0x68(%rbp),%rdx
    7afa:	48 89 15 bf 43 01 00 	mov    %rdx,0x143bf(%rip)        # 1bec0 <fwp_cleanups>
    7b01:	b2 01                	mov    $0x1,%dl
    7b03:	eb 0d                	jmp    7b12 <fwp_apply_owned+0x162>
    7b05:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    7b0c:	00 00 00 00 
    7b10:	31 d2                	xor    %edx,%edx
    7b12:	47 8d 34 2f          	lea    (%r15,%r13,1),%r14d
    7b16:	41 39 c6             	cmp    %eax,%r14d
    7b19:	89 55 cc             	mov    %edx,-0x34(%rbp)
    7b1c:	0f 82 05 03 00 00    	jb     7e27 <fwp_apply_owned+0x477>
    7b22:	41 89 c6             	mov    %eax,%r14d
    7b25:	45 29 fe             	sub    %r15d,%r14d
    7b28:	45 89 f1             	mov    %r14d,%r9d
    7b2b:	4d 85 ff             	test   %r15,%r15
    7b2e:	4c 89 4d c0          	mov    %r9,-0x40(%rbp)
    7b32:	44 89 75 b8          	mov    %r14d,-0x48(%rbp)
    7b36:	75 18                	jne    7b50 <fwp_apply_owned+0x1a0>
    7b38:	85 c0                	test   %eax,%eax
    7b3a:	74 14                	je     7b50 <fwp_apply_owned+0x1a0>
    7b3c:	49 89 ff             	mov    %rdi,%r15
    7b3f:	44 89 75 80          	mov    %r14d,-0x80(%rbp)
    7b43:	48 89 df             	mov    %rbx,%rdi
    7b46:	ff 11                	call   *(%rcx)
    7b48:	49 89 c4             	mov    %rax,%r12
    7b4b:	e9 29 02 00 00       	jmp    7d79 <fwp_apply_owned+0x3c9>
    7b50:	4c 89 6d d0          	mov    %r13,-0x30(%rbp)
    7b54:	48 89 65 90          	mov    %rsp,-0x70(%rbp)
    7b58:	85 c0                	test   %eax,%eax
    7b5a:	b9 01 00 00 00       	mov    $0x1,%ecx
    7b5f:	0f 45 c8             	cmovne %eax,%ecx
    7b62:	48 8d 0c cd 0f 00 00 	lea    0xf(,%rcx,8),%rcx
    7b69:	00 
    7b6a:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
    7b6e:	49 89 e5             	mov    %rsp,%r13
    7b71:	49 29 cd             	sub    %rcx,%r13
    7b74:	4c 89 ec             	mov    %r13,%rsp
    7b77:	4d 85 ff             	test   %r15,%r15
    7b7a:	0f 84 d0 00 00 00    	je     7c50 <fwp_apply_owned+0x2a0>
    7b80:	41 83 ff 04          	cmp    $0x4,%r15d
    7b84:	72 10                	jb     7b96 <fwp_apply_owned+0x1e6>
    7b86:	4c 89 e9             	mov    %r13,%rcx
    7b89:	4c 29 e1             	sub    %r12,%rcx
    7b8c:	48 83 c1 f8          	add    $0xfffffffffffffff8,%rcx
    7b90:	48 83 f9 20          	cmp    $0x20,%rcx
    7b94:	73 6d                	jae    7c03 <fwp_apply_owned+0x253>
    7b96:	31 c9                	xor    %ecx,%ecx
    7b98:	4c 89 fe             	mov    %r15,%rsi
    7b9b:	48 89 ca             	mov    %rcx,%rdx
    7b9e:	48 83 e6 03          	and    $0x3,%rsi
    7ba2:	74 1e                	je     7bc2 <fwp_apply_owned+0x212>
    7ba4:	48 89 ca             	mov    %rcx,%rdx
    7ba7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    7bae:	00 00 
    7bb0:	4d 8b 44 d4 08       	mov    0x8(%r12,%rdx,8),%r8
    7bb5:	4d 89 44 d5 00       	mov    %r8,0x0(%r13,%rdx,8)
    7bba:	48 ff c2             	inc    %rdx
    7bbd:	48 ff ce             	dec    %rsi
    7bc0:	75 ee                	jne    7bb0 <fwp_apply_owned+0x200>
    7bc2:	4c 29 f9             	sub    %r15,%rcx
    7bc5:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    7bc9:	0f 87 81 00 00 00    	ja     7c50 <fwp_apply_owned+0x2a0>
    7bcf:	90                   	nop
    7bd0:	49 8b 4c d4 08       	mov    0x8(%r12,%rdx,8),%rcx
    7bd5:	49 89 4c d5 00       	mov    %rcx,0x0(%r13,%rdx,8)
    7bda:	49 8b 4c d4 10       	mov    0x10(%r12,%rdx,8),%rcx
    7bdf:	49 89 4c d5 08       	mov    %rcx,0x8(%r13,%rdx,8)
    7be4:	49 8b 4c d4 18       	mov    0x18(%r12,%rdx,8),%rcx
    7be9:	49 89 4c d5 10       	mov    %rcx,0x10(%r13,%rdx,8)
    7bee:	49 8b 4c d4 20       	mov    0x20(%r12,%rdx,8),%rcx
    7bf3:	49 89 4c d5 18       	mov    %rcx,0x18(%r13,%rdx,8)
    7bf8:	48 83 c2 04          	add    $0x4,%rdx
    7bfc:	49 39 d7             	cmp    %rdx,%r15
    7bff:	75 cf                	jne    7bd0 <fwp_apply_owned+0x220>
    7c01:	eb 4d                	jmp    7c50 <fwp_apply_owned+0x2a0>
    7c03:	44 89 f9             	mov    %r15d,%ecx
    7c06:	83 e1 fc             	and    $0xfffffffc,%ecx
    7c09:	4a 8d 14 fd 00 00 00 	lea    0x0(,%r15,8),%rdx
    7c10:	00 
    7c11:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    7c15:	31 f6                	xor    %esi,%esi
    7c17:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    7c1e:	00 00 
    7c20:	41 0f 10 44 34 08    	movups 0x8(%r12,%rsi,1),%xmm0
    7c26:	41 0f 10 4c 34 18    	movups 0x18(%r12,%rsi,1),%xmm1
    7c2c:	41 0f 29 44 35 00    	movaps %xmm0,0x0(%r13,%rsi,1)
    7c32:	41 0f 29 4c 35 10    	movaps %xmm1,0x10(%r13,%rsi,1)
    7c38:	48 83 c6 20          	add    $0x20,%rsi
    7c3c:	48 39 f2             	cmp    %rsi,%rdx
    7c3f:	75 df                	jne    7c20 <fwp_apply_owned+0x270>
    7c41:	4c 39 f9             	cmp    %r15,%rcx
    7c44:	0f 85 4e ff ff ff    	jne    7b98 <fwp_apply_owned+0x1e8>
    7c4a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    7c50:	44 39 f8             	cmp    %r15d,%eax
    7c53:	0f 84 f7 00 00 00    	je     7d50 <fwp_apply_owned+0x3a0>
    7c59:	41 83 fe 0a          	cmp    $0xa,%r14d
    7c5d:	0f 83 95 00 00 00    	jae    7cf8 <fwp_apply_owned+0x348>
    7c63:	31 c0                	xor    %eax,%eax
    7c65:	4c 89 ca             	mov    %r9,%rdx
    7c68:	48 89 c1             	mov    %rax,%rcx
    7c6b:	48 83 e2 03          	and    $0x3,%rdx
    7c6f:	74 24                	je     7c95 <fwp_apply_owned+0x2e5>
    7c71:	48 89 c1             	mov    %rax,%rcx
    7c74:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    7c7b:	00 00 00 00 00 
    7c80:	48 8b 34 cb          	mov    (%rbx,%rcx,8),%rsi
    7c84:	45 8d 04 0f          	lea    (%r15,%rcx,1),%r8d
    7c88:	4b 89 74 c5 00       	mov    %rsi,0x0(%r13,%r8,8)
    7c8d:	48 ff c1             	inc    %rcx
    7c90:	48 ff ca             	dec    %rdx
    7c93:	75 eb                	jne    7c80 <fwp_apply_owned+0x2d0>
    7c95:	4c 29 c8             	sub    %r9,%rax
    7c98:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    7c9c:	0f 87 ae 00 00 00    	ja     7d50 <fwp_apply_owned+0x3a0>
    7ca2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7ca9:	1f 84 00 00 00 00 00 
    7cb0:	48 8b 04 cb          	mov    (%rbx,%rcx,8),%rax
    7cb4:	41 8d 14 0f          	lea    (%r15,%rcx,1),%edx
    7cb8:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    7cbd:	48 8b 44 cb 08       	mov    0x8(%rbx,%rcx,8),%rax
    7cc2:	41 8d 14 0f          	lea    (%r15,%rcx,1),%edx
    7cc6:	ff c2                	inc    %edx
    7cc8:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    7ccd:	48 8b 44 cb 10       	mov    0x10(%rbx,%rcx,8),%rax
    7cd2:	41 8d 54 0f 02       	lea    0x2(%r15,%rcx,1),%edx
    7cd7:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    7cdc:	48 8b 44 cb 18       	mov    0x18(%rbx,%rcx,8),%rax
    7ce1:	41 8d 14 0f          	lea    (%r15,%rcx,1),%edx
    7ce5:	83 c2 03             	add    $0x3,%edx
    7ce8:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    7ced:	48 83 c1 04          	add    $0x4,%rcx
    7cf1:	49 39 c9             	cmp    %rcx,%r9
    7cf4:	75 ba                	jne    7cb0 <fwp_apply_owned+0x300>
    7cf6:	eb 58                	jmp    7d50 <fwp_apply_owned+0x3a0>
    7cf8:	49 8d 41 ff          	lea    -0x1(%r9),%rax
    7cfc:	89 c1                	mov    %eax,%ecx
    7cfe:	44 01 f9             	add    %r15d,%ecx
    7d01:	0f 82 5c ff ff ff    	jb     7c63 <fwp_apply_owned+0x2b3>
    7d07:	48 c1 e8 20          	shr    $0x20,%rax
    7d0b:	b8 00 00 00 00       	mov    $0x0,%eax
    7d10:	0f 85 4f ff ff ff    	jne    7c65 <fwp_apply_owned+0x2b5>
    7d16:	44 89 c8             	mov    %r9d,%eax
    7d19:	83 e0 fc             	and    $0xfffffffc,%eax
    7d1c:	31 c9                	xor    %ecx,%ecx
    7d1e:	66 90                	xchg   %ax,%ax
    7d20:	0f 10 04 cb          	movups (%rbx,%rcx,8),%xmm0
    7d24:	0f 10 4c cb 10       	movups 0x10(%rbx,%rcx,8),%xmm1
    7d29:	41 8d 14 0f          	lea    (%r15,%rcx,1),%edx
    7d2d:	41 0f 11 44 d5 00    	movups %xmm0,0x0(%r13,%rdx,8)
    7d33:	41 0f 11 4c d5 10    	movups %xmm1,0x10(%r13,%rdx,8)
    7d39:	48 83 c1 04          	add    $0x4,%rcx
    7d3d:	48 39 c8             	cmp    %rcx,%rax
    7d40:	75 de                	jne    7d20 <fwp_apply_owned+0x370>
    7d42:	4c 39 c8             	cmp    %r9,%rax
    7d45:	0f 85 1a ff ff ff    	jne    7c65 <fwp_apply_owned+0x2b5>
    7d4b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7d50:	49 8b 02             	mov    (%r10),%rax
    7d53:	49 89 ff             	mov    %rdi,%r15
    7d56:	be 01 00 00 00       	mov    $0x1,%esi
    7d5b:	4d 89 d4             	mov    %r10,%r12
    7d5e:	ff 50 08             	call   *0x8(%rax)
    7d61:	44 89 75 80          	mov    %r14d,-0x80(%rbp)
    7d65:	49 8b 04 24          	mov    (%r12),%rax
    7d69:	4c 89 ef             	mov    %r13,%rdi
    7d6c:	ff 10                	call   *(%rax)
    7d6e:	49 89 c4             	mov    %rax,%r12
    7d71:	48 8b 65 90          	mov    -0x70(%rbp),%rsp
    7d75:	4c 8b 6d d0          	mov    -0x30(%rbp),%r13
    7d79:	80 7d cc 00          	cmpb   $0x0,-0x34(%rbp)
    7d7d:	4c 89 ff             	mov    %r15,%rdi
    7d80:	74 1c                	je     7d9e <fwp_apply_owned+0x3ee>
    7d82:	48 8d 45 98          	lea    -0x68(%rbp),%rax
    7d86:	48 39 05 33 41 01 00 	cmp    %rax,0x14133(%rip)        # 1bec0 <fwp_cleanups>
    7d8d:	0f 85 74 04 00 00    	jne    8207 <fwp_apply_owned+0x857>
    7d93:	48 8b 45 98          	mov    -0x68(%rbp),%rax
    7d97:	48 89 05 22 41 01 00 	mov    %rax,0x14122(%rip)        # 1bec0 <fwp_cleanups>
    7d9e:	e8 3d 25 00 00       	call   a2e0 <fwp_closure_drop>
    7da3:	44 2b 6d b8          	sub    -0x48(%rbp),%r13d
    7da7:	0f 84 48 04 00 00    	je     81f5 <fwp_apply_owned+0x845>
    7dad:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
    7db1:	48 8d 1c c3          	lea    (%rbx,%rax,8),%rbx
    7db5:	48 8b 05 b4 40 01 00 	mov    0x140b4(%rip),%rax        # 1be70 <fwp_fns>
    7dbc:	41 8b 14 24          	mov    (%r12),%edx
    7dc0:	48 89 d1             	mov    %rdx,%rcx
    7dc3:	48 c1 e1 05          	shl    $0x5,%rcx
    7dc7:	4c 8d 14 08          	lea    (%rax,%rcx,1),%r10
    7dcb:	49 83 c2 18          	add    $0x18,%r10
    7dcf:	48 8b 4c 08 18       	mov    0x18(%rax,%rcx,1),%rcx
    7dd4:	4c 89 e7             	mov    %r12,%rdi
    7dd7:	48 85 c9             	test   %rcx,%rcx
    7dda:	0f 85 20 fc ff ff    	jne    7a00 <fwp_apply_owned+0x50>
    7de0:	eb 03                	jmp    7de5 <fwp_apply_owned+0x435>
    7de2:	49 89 fc             	mov    %rdi,%r12
    7de5:	4c 89 e7             	mov    %r12,%rdi
    7de8:	e8 23 eb ff ff       	call   6910 <fwp_rc_share>
    7ded:	45 85 ed             	test   %r13d,%r13d
    7df0:	74 1f                	je     7e11 <fwp_apply_owned+0x461>
    7df2:	45 89 ee             	mov    %r13d,%r14d
    7df5:	45 31 ff             	xor    %r15d,%r15d
    7df8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    7dff:	00 
    7e00:	4a 8b 3c fb          	mov    (%rbx,%r15,8),%rdi
    7e04:	e8 07 eb ff ff       	call   6910 <fwp_rc_share>
    7e09:	49 ff c7             	inc    %r15
    7e0c:	4d 39 fe             	cmp    %r15,%r14
    7e0f:	75 ef                	jne    7e00 <fwp_apply_owned+0x450>
    7e11:	4c 89 e7             	mov    %r12,%rdi
    7e14:	44 89 ee             	mov    %r13d,%esi
    7e17:	48 89 da             	mov    %rbx,%rdx
    7e1a:	e8 c1 f5 ff ff       	call   73e0 <fwp_apply>
    7e1f:	49 89 c4             	mov    %rax,%r12
    7e22:	e9 ce 03 00 00       	jmp    81f5 <fwp_apply_owned+0x845>
    7e27:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    7e2b:	4c 89 6d d0          	mov    %r13,-0x30(%rbp)
    7e2f:	44 89 f0             	mov    %r14d,%eax
    7e32:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    7e39:	00 
    7e3a:	4c 89 55 c0          	mov    %r10,-0x40(%rbp)
    7e3e:	e8 9d 29 00 00       	call   a7e0 <fwp_alloc_init>
    7e43:	4c 8b 55 c0          	mov    -0x40(%rbp),%r10
    7e47:	49 89 c5             	mov    %rax,%r13
    7e4a:	41 8b 04 24          	mov    (%r12),%eax
    7e4e:	41 89 45 00          	mov    %eax,0x0(%r13)
    7e52:	45 89 75 04          	mov    %r14d,0x4(%r13)
    7e56:	4c 89 e8             	mov    %r13,%rax
    7e59:	48 2b 05 58 34 01 00 	sub    0x13458(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    7e60:	48 8b 0d 79 34 01 00 	mov    0x13479(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    7e67:	48 c1 e1 10          	shl    $0x10,%rcx
    7e6b:	48 39 c8             	cmp    %rcx,%rax
    7e6e:	73 73                	jae    7ee3 <fwp_apply_owned+0x533>
    7e70:	48 8b 0d 89 34 01 00 	mov    0x13489(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    7e77:	48 89 c2             	mov    %rax,%rdx
    7e7a:	48 c1 ea 10          	shr    $0x10,%rdx
    7e7e:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    7e85:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    7e89:	48 25 ff ff 00 00    	and    $0xffff,%rax
    7e8f:	75 1d                	jne    7eae <fwp_apply_owned+0x4fe>
    7e91:	40 80 fe 02          	cmp    $0x2,%sil
    7e95:	75 17                	jne    7eae <fwp_apply_owned+0x4fe>
    7e97:	4c 8d 34 11          	lea    (%rcx,%rdx,1),%r14
    7e9b:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    7ea2:	41 80 3e ff          	cmpb   $0xff,(%r14)
    7ea6:	74 2d                	je     7ed5 <fwp_apply_owned+0x525>
    7ea8:	41 c6 06 01          	movb   $0x1,(%r14)
    7eac:	eb 35                	jmp    7ee3 <fwp_apply_owned+0x533>
    7eae:	40 80 fe 01          	cmp    $0x1,%sil
    7eb2:	75 2f                	jne    7ee3 <fwp_apply_owned+0x533>
    7eb4:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    7eb8:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    7ebc:	48 0f af c1          	imul   %rcx,%rax
    7ec0:	48 c1 e8 20          	shr    $0x20,%rax
    7ec4:	4c 8d 34 30          	lea    (%rax,%rsi,1),%r14
    7ec8:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    7ecf:	41 80 3e ff          	cmpb   $0xff,(%r14)
    7ed3:	75 d3                	jne    7ea8 <fwp_apply_owned+0x4f8>
    7ed5:	4c 89 f7             	mov    %r14,%rdi
    7ed8:	e8 63 ec ff ff       	call   6b40 <fwp_rc_forget_slot>
    7edd:	4c 8b 55 c0          	mov    -0x40(%rbp),%r10
    7ee1:	eb c5                	jmp    7ea8 <fwp_apply_owned+0x4f8>
    7ee3:	4c 89 6d b0          	mov    %r13,-0x50(%rbp)
    7ee7:	48 8b 05 d2 3f 01 00 	mov    0x13fd2(%rip),%rax        # 1bec0 <fwp_cleanups>
    7eee:	48 89 85 50 ff ff ff 	mov    %rax,-0xb0(%rbp)
    7ef5:	48 8d 05 24 2a 00 00 	lea    0x2a24(%rip),%rax        # a920 <fwp_rc_cleanup_cell>
    7efc:	48 89 85 58 ff ff ff 	mov    %rax,-0xa8(%rbp)
    7f03:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
    7f07:	48 89 85 60 ff ff ff 	mov    %rax,-0xa0(%rbp)
    7f0e:	4c 8d b5 50 ff ff ff 	lea    -0xb0(%rbp),%r14
    7f15:	4c 89 35 a4 3f 01 00 	mov    %r14,0x13fa4(%rip)        # 1bec0 <fwp_cleanups>
    7f1c:	4d 85 ff             	test   %r15,%r15
    7f1f:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
    7f23:	0f 84 c8 00 00 00    	je     7ff1 <fwp_apply_owned+0x641>
    7f29:	31 c0                	xor    %eax,%eax
    7f2b:	41 83 ff 06          	cmp    $0x6,%r15d
    7f2f:	72 55                	jb     7f86 <fwp_apply_owned+0x5d6>
    7f31:	4c 89 e9             	mov    %r13,%rcx
    7f34:	4c 29 e1             	sub    %r12,%rcx
    7f37:	48 83 f9 20          	cmp    $0x20,%rcx
    7f3b:	72 49                	jb     7f86 <fwp_apply_owned+0x5d6>
    7f3d:	44 89 f8             	mov    %r15d,%eax
    7f40:	83 e0 fc             	and    $0xfffffffc,%eax
    7f43:	4a 8d 0c fd 00 00 00 	lea    0x0(,%r15,8),%rcx
    7f4a:	00 
    7f4b:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    7f4f:	31 d2                	xor    %edx,%edx
    7f51:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7f58:	0f 1f 84 00 00 00 00 
    7f5f:	00 
    7f60:	41 0f 10 44 14 08    	movups 0x8(%r12,%rdx,1),%xmm0
    7f66:	41 0f 10 4c 14 18    	movups 0x18(%r12,%rdx,1),%xmm1
    7f6c:	41 0f 11 44 15 08    	movups %xmm0,0x8(%r13,%rdx,1)
    7f72:	41 0f 11 4c 15 18    	movups %xmm1,0x18(%r13,%rdx,1)
    7f78:	48 83 c2 20          	add    $0x20,%rdx
    7f7c:	48 39 d1             	cmp    %rdx,%rcx
    7f7f:	75 df                	jne    7f60 <fwp_apply_owned+0x5b0>
    7f81:	4c 39 f8             	cmp    %r15,%rax
    7f84:	74 6b                	je     7ff1 <fwp_apply_owned+0x641>
    7f86:	4c 89 fa             	mov    %r15,%rdx
    7f89:	48 89 c1             	mov    %rax,%rcx
    7f8c:	48 83 e2 03          	and    $0x3,%rdx
    7f90:	74 20                	je     7fb2 <fwp_apply_owned+0x602>
    7f92:	48 89 c1             	mov    %rax,%rcx
    7f95:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    7f9c:	00 00 00 00 
    7fa0:	49 8b 74 cc 08       	mov    0x8(%r12,%rcx,8),%rsi
    7fa5:	49 89 74 cd 08       	mov    %rsi,0x8(%r13,%rcx,8)
    7faa:	48 ff c1             	inc    %rcx
    7fad:	48 ff ca             	dec    %rdx
    7fb0:	75 ee                	jne    7fa0 <fwp_apply_owned+0x5f0>
    7fb2:	4c 29 f8             	sub    %r15,%rax
    7fb5:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    7fb9:	77 36                	ja     7ff1 <fwp_apply_owned+0x641>
    7fbb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7fc0:	49 8b 44 cc 08       	mov    0x8(%r12,%rcx,8),%rax
    7fc5:	49 89 44 cd 08       	mov    %rax,0x8(%r13,%rcx,8)
    7fca:	49 8b 44 cc 10       	mov    0x10(%r12,%rcx,8),%rax
    7fcf:	49 89 44 cd 10       	mov    %rax,0x10(%r13,%rcx,8)
    7fd4:	49 8b 44 cc 18       	mov    0x18(%r12,%rcx,8),%rax
    7fd9:	49 89 44 cd 18       	mov    %rax,0x18(%r13,%rcx,8)
    7fde:	49 8b 44 cc 20       	mov    0x20(%r12,%rcx,8),%rax
    7fe3:	49 89 44 cd 20       	mov    %rax,0x20(%r13,%rcx,8)
    7fe8:	48 83 c1 04          	add    $0x4,%rcx
    7fec:	49 39 cf             	cmp    %rcx,%r15
    7fef:	75 cf                	jne    7fc0 <fwp_apply_owned+0x610>
    7ff1:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
    7ff5:	0f 84 8b 00 00 00    	je     8086 <fwp_apply_owned+0x6d6>
    7ffb:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
    7fff:	89 c8                	mov    %ecx,%eax
    8001:	83 f9 14             	cmp    $0x14,%ecx
    8004:	0f 83 f4 00 00 00    	jae    80fe <fwp_apply_owned+0x74e>
    800a:	31 c9                	xor    %ecx,%ecx
    800c:	48 89 c6             	mov    %rax,%rsi
    800f:	48 89 ca             	mov    %rcx,%rdx
    8012:	48 83 e6 03          	and    $0x3,%rsi
    8016:	74 1d                	je     8035 <fwp_apply_owned+0x685>
    8018:	48 89 ca             	mov    %rcx,%rdx
    801b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8020:	4c 8b 0c d3          	mov    (%rbx,%rdx,8),%r9
    8024:	45 8d 04 17          	lea    (%r15,%rdx,1),%r8d
    8028:	4f 89 4c c5 08       	mov    %r9,0x8(%r13,%r8,8)
    802d:	48 ff c2             	inc    %rdx
    8030:	48 ff ce             	dec    %rsi
    8033:	75 eb                	jne    8020 <fwp_apply_owned+0x670>
    8035:	48 29 c1             	sub    %rax,%rcx
    8038:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    803c:	77 48                	ja     8086 <fwp_apply_owned+0x6d6>
    803e:	66 90                	xchg   %ax,%ax
    8040:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    8044:	41 8d 34 17          	lea    (%r15,%rdx,1),%esi
    8048:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    804d:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    8052:	41 8d 34 17          	lea    (%r15,%rdx,1),%esi
    8056:	ff c6                	inc    %esi
    8058:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    805d:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    8062:	41 8d 74 17 02       	lea    0x2(%r15,%rdx,1),%esi
    8067:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    806c:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    8071:	41 8d 34 17          	lea    (%r15,%rdx,1),%esi
    8075:	83 c6 03             	add    $0x3,%esi
    8078:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    807d:	48 83 c2 04          	add    $0x4,%rdx
    8081:	48 39 d0             	cmp    %rdx,%rax
    8084:	75 ba                	jne    8040 <fwp_apply_owned+0x690>
    8086:	49 8b 02             	mov    (%r10),%rax
    8089:	be 01 00 00 00       	mov    $0x1,%esi
    808e:	ff 50 08             	call   *0x8(%rax)
    8091:	4c 89 e8             	mov    %r13,%rax
    8094:	48 2b 05 1d 32 01 00 	sub    0x1321d(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    809b:	48 8b 0d 3e 32 01 00 	mov    0x1323e(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    80a2:	48 c1 e1 10          	shl    $0x10,%rcx
    80a6:	48 39 c8             	cmp    %rcx,%rax
    80a9:	0f 83 fa 00 00 00    	jae    81a9 <fwp_apply_owned+0x7f9>
    80af:	48 8b 0d 4a 32 01 00 	mov    0x1324a(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    80b6:	48 89 c2             	mov    %rax,%rdx
    80b9:	48 c1 ea 10          	shr    $0x10,%rdx
    80bd:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    80c4:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    80c8:	48 25 ff ff 00 00    	and    $0xffff,%rax
    80ce:	0f 85 9c 00 00 00    	jne    8170 <fwp_apply_owned+0x7c0>
    80d4:	40 80 fe 02          	cmp    $0x2,%sil
    80d8:	0f 85 92 00 00 00    	jne    8170 <fwp_apply_owned+0x7c0>
    80de:	4c 8d 24 11          	lea    (%rcx,%rdx,1),%r12
    80e2:	49 81 c4 28 02 00 00 	add    $0x228,%r12
    80e9:	41 80 3c 24 ff       	cmpb   $0xff,(%r12)
    80ee:	0f 84 a8 00 00 00    	je     819c <fwp_apply_owned+0x7ec>
    80f4:	41 c6 04 24 01       	movb   $0x1,(%r12)
    80f9:	e9 ab 00 00 00       	jmp    81a9 <fwp_apply_owned+0x7f9>
    80fe:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    8102:	31 c9                	xor    %ecx,%ecx
    8104:	89 d6                	mov    %edx,%esi
    8106:	44 01 fe             	add    %r15d,%esi
    8109:	0f 82 fd fe ff ff    	jb     800c <fwp_apply_owned+0x65c>
    810f:	48 c1 ea 20          	shr    $0x20,%rdx
    8113:	0f 85 f3 fe ff ff    	jne    800c <fwp_apply_owned+0x65c>
    8119:	4a 8d 0c fd 00 00 00 	lea    0x0(,%r15,8),%rcx
    8120:	00 
    8121:	4c 01 e9             	add    %r13,%rcx
    8124:	48 29 d9             	sub    %rbx,%rcx
    8127:	48 83 c1 08          	add    $0x8,%rcx
    812b:	48 83 f9 20          	cmp    $0x20,%rcx
    812f:	0f 82 d5 fe ff ff    	jb     800a <fwp_apply_owned+0x65a>
    8135:	89 c1                	mov    %eax,%ecx
    8137:	83 e1 fc             	and    $0xfffffffc,%ecx
    813a:	31 d2                	xor    %edx,%edx
    813c:	0f 1f 40 00          	nopl   0x0(%rax)
    8140:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    8144:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    8149:	41 8d 34 17          	lea    (%r15,%rdx,1),%esi
    814d:	41 0f 11 44 f5 08    	movups %xmm0,0x8(%r13,%rsi,8)
    8153:	41 0f 11 4c f5 18    	movups %xmm1,0x18(%r13,%rsi,8)
    8159:	48 83 c2 04          	add    $0x4,%rdx
    815d:	48 39 d1             	cmp    %rdx,%rcx
    8160:	75 de                	jne    8140 <fwp_apply_owned+0x790>
    8162:	48 39 c1             	cmp    %rax,%rcx
    8165:	0f 85 a1 fe ff ff    	jne    800c <fwp_apply_owned+0x65c>
    816b:	e9 16 ff ff ff       	jmp    8086 <fwp_apply_owned+0x6d6>
    8170:	40 80 fe 01          	cmp    $0x1,%sil
    8174:	75 33                	jne    81a9 <fwp_apply_owned+0x7f9>
    8176:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    817a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    817e:	48 0f af c1          	imul   %rcx,%rax
    8182:	48 c1 e8 20          	shr    $0x20,%rax
    8186:	4c 8d 24 30          	lea    (%rax,%rsi,1),%r12
    818a:	49 81 c4 28 02 00 00 	add    $0x228,%r12
    8191:	41 80 3c 24 ff       	cmpb   $0xff,(%r12)
    8196:	0f 85 58 ff ff ff    	jne    80f4 <fwp_apply_owned+0x744>
    819c:	4c 89 e7             	mov    %r12,%rdi
    819f:	e8 9c e9 ff ff       	call   6b40 <fwp_rc_forget_slot>
    81a4:	e9 4b ff ff ff       	jmp    80f4 <fwp_apply_owned+0x744>
    81a9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    81ad:	89 45 80             	mov    %eax,-0x80(%rbp)
    81b0:	48 c7 45 b0 00 00 00 	movq   $0x0,-0x50(%rbp)
    81b7:	00 
    81b8:	4c 39 35 01 3d 01 00 	cmp    %r14,0x13d01(%rip)        # 1bec0 <fwp_cleanups>
    81bf:	75 46                	jne    8207 <fwp_apply_owned+0x857>
    81c1:	48 8b 85 50 ff ff ff 	mov    -0xb0(%rbp),%rax
    81c8:	48 89 05 f1 3c 01 00 	mov    %rax,0x13cf1(%rip)        # 1bec0 <fwp_cleanups>
    81cf:	80 7d cc 00          	cmpb   $0x0,-0x34(%rbp)
    81d3:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
    81d7:	74 14                	je     81ed <fwp_apply_owned+0x83d>
    81d9:	48 8d 4d 98          	lea    -0x68(%rbp),%rcx
    81dd:	48 39 c8             	cmp    %rcx,%rax
    81e0:	75 25                	jne    8207 <fwp_apply_owned+0x857>
    81e2:	48 8b 45 98          	mov    -0x68(%rbp),%rax
    81e6:	48 89 05 d3 3c 01 00 	mov    %rax,0x13cd3(%rip)        # 1bec0 <fwp_cleanups>
    81ed:	e8 ee 20 00 00       	call   a2e0 <fwp_closure_drop>
    81f2:	4d 89 ec             	mov    %r13,%r12
    81f5:	4c 89 e0             	mov    %r12,%rax
    81f8:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    81fc:	5b                   	pop    %rbx
    81fd:	41 5c                	pop    %r12
    81ff:	41 5d                	pop    %r13
    8201:	41 5e                	pop    %r14
    8203:	41 5f                	pop    %r15
    8205:	5d                   	pop    %rbp
    8206:	c3                   	ret
    8207:	e8 64 ae ff ff       	call   3070 <abort@plt>
    820c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000008210 <fwp_alloc>:
    8210:	53                   	push   %rbx
    8211:	48 ff 05 90 3c 01 00 	incq   0x13c90(%rip)        # 1bea8 <measured_calls>
    8218:	48 01 3d 91 3c 01 00 	add    %rdi,0x13c91(%rip)        # 1beb0 <measured_bytes>
    821f:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    8226:	77 61                	ja     8289 <fwp_alloc+0x79>
    8228:	48 8d 4f 0f          	lea    0xf(%rdi),%rcx
    822c:	48 c1 e9 04          	shr    $0x4,%rcx
    8230:	48 8d 05 51 20 01 00 	lea    0x12051(%rip),%rax        # 1a288 <fwp_gc>
    8237:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    823e:	00 
    823f:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    8246:	48 29 15 3b 20 01 00 	sub    %rdx,0x1203b(%rip)        # 1a288 <fwp_gc>
    824d:	78 3a                	js     8289 <fwp_alloc+0x79>
    824f:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    8253:	48 8d 34 c8          	lea    (%rax,%rcx,8),%rsi
    8257:	48 81 c6 88 07 00 00 	add    $0x788,%rsi
    825e:	48 8b 1e             	mov    (%rsi),%rbx
    8261:	48 85 db             	test   %rbx,%rbx
    8264:	74 0b                	je     8271 <fwp_alloc+0x61>
    8266:	48 8b 03             	mov    (%rbx),%rax
    8269:	48 f7 d0             	not    %rax
    826c:	48 89 06             	mov    %rax,(%rsi)
    826f:	eb 31                	jmp    82a2 <fwp_alloc+0x92>
    8271:	48 8b 9c c8 90 07 00 	mov    0x790(%rax,%rcx,8),%rbx
    8278:	00 
    8279:	48 8b b4 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%rsi
    8280:	00 
    8281:	48 29 de             	sub    %rbx,%rsi
    8284:	48 39 d6             	cmp    %rdx,%rsi
    8287:	73 08                	jae    8291 <fwp_alloc+0x81>
    8289:	be 02 00 00 00       	mov    $0x2,%esi
    828e:	5b                   	pop    %rbx
    828f:	eb 2f                	jmp    82c0 <fwp_gc_alloc_slow>
    8291:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    8295:	48 05 90 07 00 00    	add    $0x790,%rax
    829b:	48 8d 0c 13          	lea    (%rbx,%rdx,1),%rcx
    829f:	48 89 08             	mov    %rcx,(%rax)
    82a2:	48 89 df             	mov    %rbx,%rdi
    82a5:	31 f6                	xor    %esi,%esi
    82a7:	e8 64 af ff ff       	call   3210 <memset@plt>
    82ac:	48 89 d8             	mov    %rbx,%rax
    82af:	5b                   	pop    %rbx
    82b0:	c3                   	ret
    82b1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    82b8:	0f 1f 84 00 00 00 00 
    82bf:	00 

00000000000082c0 <fwp_gc_alloc_slow>:
    82c0:	55                   	push   %rbp
    82c1:	41 57                	push   %r15
    82c3:	41 56                	push   %r14
    82c5:	41 54                	push   %r12
    82c7:	53                   	push   %rbx
    82c8:	89 f5                	mov    %esi,%ebp
    82ca:	48 89 fb             	mov    %rdi,%rbx
    82cd:	83 3d a0 2f 01 00 00 	cmpl   $0x0,0x12fa0(%rip)        # 1b274 <fwp_gc+0xfec>
    82d4:	74 1b                	je     82f1 <fwp_gc_alloc_slow+0x31>
    82d6:	48 81 fb 01 40 00 00 	cmp    $0x4001,%rbx
    82dd:	72 20                	jb     82ff <fwp_gc_alloc_slow+0x3f>
    82df:	48 89 df             	mov    %rbx,%rdi
    82e2:	89 ee                	mov    %ebp,%esi
    82e4:	5b                   	pop    %rbx
    82e5:	41 5c                	pop    %r12
    82e7:	41 5e                	pop    %r14
    82e9:	41 5f                	pop    %r15
    82eb:	5d                   	pop    %rbp
    82ec:	e9 9f 04 00 00       	jmp    8790 <fwp_gc_alloc_big>
    82f1:	e8 ba 00 00 00       	call   83b0 <fwp_gc_init>
    82f6:	48 81 fb 01 40 00 00 	cmp    $0x4001,%rbx
    82fd:	73 e0                	jae    82df <fwp_gc_alloc_slow+0x1f>
    82ff:	48 8d 43 0f          	lea    0xf(%rbx),%rax
    8303:	48 c1 e8 04          	shr    $0x4,%rax
    8307:	4c 8d 25 7a 1f 01 00 	lea    0x11f7a(%rip),%r12        # 1a288 <fwp_gc>
    830e:	46 0f b6 bc 20 e8 0b 	movzbl 0xbe8(%rax,%r12,1),%r15d
    8315:	00 00 
    8317:	47 8b b4 bc 48 0b 00 	mov    0xb48(%r12,%r15,4),%r14d
    831e:	00 
    831f:	48 83 3d 61 1f 01 00 	cmpq   $0x0,0x11f61(%rip)        # 1a288 <fwp_gc>
    8326:	00 
    8327:	79 05                	jns    832e <fwp_gc_alloc_slow+0x6e>
    8329:	e8 02 06 00 00       	call   8930 <fwp_gc_spent>
    832e:	89 e8                	mov    %ebp,%eax
    8330:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    8337:	49 01 c4             	add    %rax,%r12
    833a:	4b 8d 0c 7f          	lea    (%r15,%r15,2),%rcx
    833e:	49 8d 04 cc          	lea    (%r12,%rcx,8),%rax
    8342:	48 83 c0 08          	add    $0x8,%rax
    8346:	49 8b 7c cc 08       	mov    0x8(%r12,%rcx,8),%rdi
    834b:	48 85 ff             	test   %rdi,%rdi
    834e:	74 08                	je     8358 <fwp_gc_alloc_slow+0x98>
    8350:	48 8b 0f             	mov    (%rdi),%rcx
    8353:	48 f7 d1             	not    %rcx
    8356:	eb 30                	jmp    8388 <fwp_gc_alloc_slow+0xc8>
    8358:	49 8b 7c cc 10       	mov    0x10(%r12,%rcx,8),%rdi
    835d:	49 8b 54 cc 18       	mov    0x18(%r12,%rcx,8),%rdx
    8362:	48 29 fa             	sub    %rdi,%rdx
    8365:	4c 39 f2             	cmp    %r14,%rdx
    8368:	73 12                	jae    837c <fwp_gc_alloc_slow+0xbc>
    836a:	48 89 c7             	mov    %rax,%rdi
    836d:	44 89 fe             	mov    %r15d,%esi
    8370:	89 ea                	mov    %ebp,%edx
    8372:	e8 89 06 00 00       	call   8a00 <fwp_gc_refill>
    8377:	48 89 c7             	mov    %rax,%rdi
    837a:	eb 0f                	jmp    838b <fwp_gc_alloc_slow+0xcb>
    837c:	49 8d 04 cc          	lea    (%r12,%rcx,8),%rax
    8380:	48 83 c0 10          	add    $0x10,%rax
    8384:	4a 8d 0c 37          	lea    (%rdi,%r14,1),%rcx
    8388:	48 89 08             	mov    %rcx,(%rax)
    838b:	83 fd 01             	cmp    $0x1,%ebp
    838e:	4c 0f 44 f3          	cmove  %rbx,%r14
    8392:	31 f6                	xor    %esi,%esi
    8394:	4c 89 f2             	mov    %r14,%rdx
    8397:	5b                   	pop    %rbx
    8398:	41 5c                	pop    %r12
    839a:	41 5e                	pop    %r14
    839c:	41 5f                	pop    %r15
    839e:	5d                   	pop    %rbp
    839f:	e9 6c ae ff ff       	jmp    3210 <memset@plt>
    83a4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    83ab:	00 00 00 00 00 

00000000000083b0 <fwp_gc_init>:
    83b0:	53                   	push   %rbx
    83b1:	c7 05 b9 2e 01 00 01 	movl   $0x1,0x12eb9(%rip)        # 1b274 <fwp_gc+0xfec>
    83b8:	00 00 00 
    83bb:	0f 28 05 5e cc 00 00 	movaps 0xcc5e(%rip),%xmm0        # 15020 <_IO_stdin_used+0x20>
    83c2:	0f 11 05 07 2a 01 00 	movups %xmm0,0x12a07(%rip)        # 1add0 <fwp_gc+0xb48>
    83c9:	0f 28 05 60 cc 00 00 	movaps 0xcc60(%rip),%xmm0        # 15030 <_IO_stdin_used+0x30>
    83d0:	0f 11 05 09 2a 01 00 	movups %xmm0,0x12a09(%rip)        # 1ade0 <fwp_gc+0xb58>
    83d7:	0f 28 05 62 cc 00 00 	movaps 0xcc62(%rip),%xmm0        # 15040 <_IO_stdin_used+0x40>
    83de:	0f 11 05 0b 2a 01 00 	movups %xmm0,0x12a0b(%rip)        # 1adf0 <fwp_gc+0xb68>
    83e5:	0f 28 05 64 cc 00 00 	movaps 0xcc64(%rip),%xmm0        # 15050 <_IO_stdin_used+0x50>
    83ec:	0f 11 05 0d 2a 01 00 	movups %xmm0,0x12a0d(%rip)        # 1ae00 <fwp_gc+0xb78>
    83f3:	0f 28 05 66 cc 00 00 	movaps 0xcc66(%rip),%xmm0        # 15060 <_IO_stdin_used+0x60>
    83fa:	0f 11 05 0f 2a 01 00 	movups %xmm0,0x12a0f(%rip)        # 1ae10 <fwp_gc+0xb88>
    8401:	0f 28 05 68 cc 00 00 	movaps 0xcc68(%rip),%xmm0        # 15070 <_IO_stdin_used+0x70>
    8408:	0f 11 05 11 2a 01 00 	movups %xmm0,0x12a11(%rip)        # 1ae20 <fwp_gc+0xb98>
    840f:	0f 28 05 6a cc 00 00 	movaps 0xcc6a(%rip),%xmm0        # 15080 <_IO_stdin_used+0x80>
    8416:	0f 11 05 13 2a 01 00 	movups %xmm0,0x12a13(%rip)        # 1ae30 <fwp_gc+0xba8>
    841d:	0f 28 05 6c cc 00 00 	movaps 0xcc6c(%rip),%xmm0        # 15090 <_IO_stdin_used+0x90>
    8424:	0f 11 05 15 2a 01 00 	movups %xmm0,0x12a15(%rip)        # 1ae40 <fwp_gc+0xbb8>
    842b:	0f 28 05 6e cc 00 00 	movaps 0xcc6e(%rip),%xmm0        # 150a0 <_IO_stdin_used+0xa0>
    8432:	0f 11 05 17 2a 01 00 	movups %xmm0,0x12a17(%rip)        # 1ae50 <fwp_gc+0xbc8>
    8439:	0f 28 05 70 cc 00 00 	movaps 0xcc70(%rip),%xmm0        # 150b0 <_IO_stdin_used+0xb0>
    8440:	0f 11 05 19 2a 01 00 	movups %xmm0,0x12a19(%rip)        # 1ae60 <fwp_gc+0xbd8>
    8447:	31 c9                	xor    %ecx,%ecx
    8449:	48 8d 05 38 1e 01 00 	lea    0x11e38(%rip),%rax        # 1a288 <fwp_gc>
    8450:	31 d2                	xor    %edx,%edx
    8452:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8459:	1f 84 00 00 00 00 00 
    8460:	89 d6                	mov    %edx,%esi
    8462:	c1 e6 04             	shl    $0x4,%esi
    8465:	48 ff c9             	dec    %rcx
    8468:	48 89 cf             	mov    %rcx,%rdi
    846b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8470:	48 89 f9             	mov    %rdi,%rcx
    8473:	48 ff c7             	inc    %rdi
    8476:	3b b4 88 4c 0b 00 00 	cmp    0xb4c(%rax,%rcx,4),%esi
    847d:	77 f1                	ja     8470 <fwp_gc_init+0xc0>
    847f:	40 88 bc 02 e8 0b 00 	mov    %dil,0xbe8(%rdx,%rax,1)
    8486:	00 
    8487:	48 89 d6             	mov    %rdx,%rsi
    848a:	48 83 ce 01          	or     $0x1,%rsi
    848e:	48 81 fe 01 04 00 00 	cmp    $0x401,%rsi
    8495:	74 26                	je     84bd <fwp_gc_init+0x10d>
    8497:	89 f7                	mov    %esi,%edi
    8499:	c1 e7 04             	shl    $0x4,%edi
    849c:	0f 1f 40 00          	nopl   0x0(%rax)
    84a0:	49 89 c8             	mov    %rcx,%r8
    84a3:	48 ff c1             	inc    %rcx
    84a6:	42 3b bc 80 4c 0b 00 	cmp    0xb4c(%rax,%r8,4),%edi
    84ad:	00 
    84ae:	77 f0                	ja     84a0 <fwp_gc_init+0xf0>
    84b0:	88 8c 06 e8 0b 00 00 	mov    %cl,0xbe8(%rsi,%rax,1)
    84b7:	48 83 c2 02          	add    $0x2,%rdx
    84bb:	eb a3                	jmp    8460 <fwp_gc_init+0xb0>
    84bd:	48 bb 00 00 00 00 10 	movabs $0x1000000000,%rbx
    84c4:	00 00 00 
    84c7:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    84ce:	31 ff                	xor    %edi,%edi
    84d0:	31 d2                	xor    %edx,%edx
    84d2:	b9 22 40 00 00       	mov    $0x4022,%ecx
    84d7:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    84dd:	45 31 c9             	xor    %r9d,%r9d
    84e0:	e8 ab ac ff ff       	call   3190 <mmap@plt>
    84e5:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    84e9:	75 60                	jne    854b <fwp_gc_init+0x19b>
    84eb:	48 bb 00 00 00 00 04 	movabs $0x400000000,%rbx
    84f2:	00 00 00 
    84f5:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    84fc:	31 ff                	xor    %edi,%edi
    84fe:	31 d2                	xor    %edx,%edx
    8500:	b9 22 40 00 00       	mov    $0x4022,%ecx
    8505:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    850b:	45 31 c9             	xor    %r9d,%r9d
    850e:	e8 7d ac ff ff       	call   3190 <mmap@plt>
    8513:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    8517:	75 32                	jne    854b <fwp_gc_init+0x19b>
    8519:	48 bb 00 00 00 00 01 	movabs $0x100000000,%rbx
    8520:	00 00 00 
    8523:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    852a:	31 ff                	xor    %edi,%edi
    852c:	31 d2                	xor    %edx,%edx
    852e:	b9 22 40 00 00       	mov    $0x4022,%ecx
    8533:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    8539:	45 31 c9             	xor    %r9d,%r9d
    853c:	e8 4f ac ff ff       	call   3190 <mmap@plt>
    8541:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    8545:	0f 84 b5 01 00 00    	je     8700 <fwp_gc_init+0x350>
    854b:	48 85 c0             	test   %rax,%rax
    854e:	0f 84 0d 02 00 00    	je     8761 <fwp_gc_init+0x3b1>
    8554:	48 89 05 65 2d 01 00 	mov    %rax,0x12d65(%rip)        # 1b2c0 <fwp_gc+0x1038>
    855b:	48 89 d9             	mov    %rbx,%rcx
    855e:	48 81 c9 00 00 01 00 	or     $0x10000,%rcx
    8565:	48 89 0d 5c 2d 01 00 	mov    %rcx,0x12d5c(%rip)        # 1b2c8 <fwp_gc+0x1040>
    856c:	48 05 ff ff 00 00    	add    $0xffff,%rax
    8572:	48 25 00 00 ff ff    	and    $0xffffffffffff0000,%rax
    8578:	48 89 05 39 2d 01 00 	mov    %rax,0x12d39(%rip)        # 1b2b8 <fwp_gc+0x1030>
    857f:	48 c1 eb 10          	shr    $0x10,%rbx
    8583:	48 89 1d 4e 2d 01 00 	mov    %rbx,0x12d4e(%rip)        # 1b2d8 <fwp_gc+0x1050>
    858a:	48 69 f3 28 12 00 00 	imul   $0x1228,%rbx,%rsi
    8591:	48 89 35 70 2d 01 00 	mov    %rsi,0x12d70(%rip)        # 1b308 <fwp_gc+0x1080>
    8598:	31 ff                	xor    %edi,%edi
    859a:	31 d2                	xor    %edx,%edx
    859c:	b9 22 40 00 00       	mov    $0x4022,%ecx
    85a1:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    85a7:	45 31 c9             	xor    %r9d,%r9d
    85aa:	e8 e1 ab ff ff       	call   3190 <mmap@plt>
    85af:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    85b3:	0f 84 a8 01 00 00    	je     8761 <fwp_gc_init+0x3b1>
    85b9:	48 89 05 40 2d 01 00 	mov    %rax,0x12d40(%rip)        # 1b300 <fwp_gc+0x1078>
    85c0:	48 8d 3d f1 d4 00 00 	lea    0xd4f1(%rip),%rdi        # 15ab8 <exec_in_fp0+0x248>
    85c7:	e8 64 aa ff ff       	call   3030 <getenv@plt>
    85cc:	48 85 c0             	test   %rax,%rax
    85cf:	74 2e                	je     85ff <fwp_gc_init+0x24f>
    85d1:	48 89 c3             	mov    %rax,%rbx
    85d4:	48 8d 35 e4 d4 00 00 	lea    0xd4e4(%rip),%rsi        # 15abf <exec_in_fp0+0x24f>
    85db:	48 89 c7             	mov    %rax,%rdi
    85de:	e8 ed ac ff ff       	call   32d0 <strcmp@plt>
    85e3:	85 c0                	test   %eax,%eax
    85e5:	74 1f                	je     8606 <fwp_gc_init+0x256>
    85e7:	48 8d 35 d2 e1 00 00 	lea    0xe1d2(%rip),%rsi        # 167c0 <exec_in_fp0+0xf50>
    85ee:	48 89 df             	mov    %rbx,%rdi
    85f1:	e8 da ac ff ff       	call   32d0 <strcmp@plt>
    85f6:	31 c9                	xor    %ecx,%ecx
    85f8:	85 c0                	test   %eax,%eax
    85fa:	0f 95 c1             	setne  %cl
    85fd:	eb 09                	jmp    8608 <fwp_gc_init+0x258>
    85ff:	b9 01 00 00 00       	mov    $0x1,%ecx
    8604:	eb 02                	jmp    8608 <fwp_gc_init+0x258>
    8606:	31 c9                	xor    %ecx,%ecx
    8608:	89 0d 6a 2c 01 00    	mov    %ecx,0x12c6a(%rip)        # 1b278 <fwp_gc+0xff0>
    860e:	48 8d 3d ae d4 00 00 	lea    0xd4ae(%rip),%rdi        # 15ac3 <exec_in_fp0+0x253>
    8615:	e8 16 aa ff ff       	call   3030 <getenv@plt>
    861a:	31 c9                	xor    %ecx,%ecx
    861c:	48 85 c0             	test   %rax,%rax
    861f:	74 1b                	je     863c <fwp_gc_init+0x28c>
    8621:	80 38 00             	cmpb   $0x0,(%rax)
    8624:	74 16                	je     863c <fwp_gc_init+0x28c>
    8626:	48 8d 35 93 e1 00 00 	lea    0xe193(%rip),%rsi        # 167c0 <exec_in_fp0+0xf50>
    862d:	48 89 c7             	mov    %rax,%rdi
    8630:	e8 9b ac ff ff       	call   32d0 <strcmp@plt>
    8635:	31 c9                	xor    %ecx,%ecx
    8637:	85 c0                	test   %eax,%eax
    8639:	0f 95 c1             	setne  %cl
    863c:	89 0d 42 2c 01 00    	mov    %ecx,0x12c42(%rip)        # 1b284 <fwp_gc+0xffc>
    8642:	48 8d 3d 6f d4 00 00 	lea    0xd46f(%rip),%rdi        # 15ab8 <exec_in_fp0+0x248>
    8649:	e8 e2 a9 ff ff       	call   3030 <getenv@plt>
    864e:	48 85 c0             	test   %rax,%rax
    8651:	74 18                	je     866b <fwp_gc_init+0x2bb>
    8653:	48 8d 35 76 d4 00 00 	lea    0xd476(%rip),%rsi        # 15ad0 <exec_in_fp0+0x260>
    865a:	48 89 c7             	mov    %rax,%rdi
    865d:	e8 6e ac ff ff       	call   32d0 <strcmp@plt>
    8662:	31 c9                	xor    %ecx,%ecx
    8664:	85 c0                	test   %eax,%eax
    8666:	0f 95 c1             	setne  %cl
    8669:	eb 05                	jmp    8670 <fwp_gc_init+0x2c0>
    866b:	b9 01 00 00 00       	mov    $0x1,%ecx
    8670:	89 0d 12 2c 01 00    	mov    %ecx,0x12c12(%rip)        # 1b288 <fwp_gc+0x1000>
    8676:	c7 05 10 2c 01 00 01 	movl   $0x1,0x12c10(%rip)        # 1b290 <fwp_gc+0x1008>
    867d:	00 00 00 
    8680:	48 8d 3d 4e d4 00 00 	lea    0xd44e(%rip),%rdi        # 15ad5 <exec_in_fp0+0x265>
    8687:	e8 a4 a9 ff ff       	call   3030 <getenv@plt>
    868c:	31 c9                	xor    %ecx,%ecx
    868e:	48 85 c0             	test   %rax,%rax
    8691:	74 1b                	je     86ae <fwp_gc_init+0x2fe>
    8693:	80 38 00             	cmpb   $0x0,(%rax)
    8696:	74 16                	je     86ae <fwp_gc_init+0x2fe>
    8698:	48 8d 35 21 e1 00 00 	lea    0xe121(%rip),%rsi        # 167c0 <exec_in_fp0+0xf50>
    869f:	48 89 c7             	mov    %rax,%rdi
    86a2:	e8 29 ac ff ff       	call   32d0 <strcmp@plt>
    86a7:	31 c9                	xor    %ecx,%ecx
    86a9:	85 c0                	test   %eax,%eax
    86ab:	0f 95 c1             	setne  %cl
    86ae:	89 0d d8 2b 01 00    	mov    %ecx,0x12bd8(%rip)        # 1b28c <fwp_gc+0x1004>
    86b4:	48 8d 3d 28 d4 00 00 	lea    0xd428(%rip),%rdi        # 15ae3 <exec_in_fp0+0x273>
    86bb:	e8 70 a9 ff ff       	call   3030 <getenv@plt>
    86c0:	48 85 c0             	test   %rax,%rax
    86c3:	74 11                	je     86d6 <fwp_gc_init+0x326>
    86c5:	48 89 c7             	mov    %rax,%rdi
    86c8:	31 f6                	xor    %esi,%esi
    86ca:	ba 0a 00 00 00       	mov    $0xa,%edx
    86cf:	e8 4c ac ff ff       	call   3320 <strtol@plt>
    86d4:	eb 02                	jmp    86d8 <fwp_gc_init+0x328>
    86d6:	31 c0                	xor    %eax,%eax
    86d8:	31 c9                	xor    %ecx,%ecx
    86da:	48 85 c0             	test   %rax,%rax
    86dd:	48 0f 4f c8          	cmovg  %rax,%rcx
    86e1:	48 89 0d c0 2b 01 00 	mov    %rcx,0x12bc0(%rip)        # 1b2a8 <fwp_gc+0x1020>
    86e8:	48 c7 05 a5 2d 01 00 	movq   $0x800000,0x12da5(%rip)        # 1b498 <fwp_gc+0x1210>
    86ef:	00 00 80 00 
    86f3:	48 c7 05 8a 1b 01 00 	movq   $0x800000,0x11b8a(%rip)        # 1a288 <fwp_gc>
    86fa:	00 00 80 00 
    86fe:	5b                   	pop    %rbx
    86ff:	c3                   	ret
    8700:	be 00 00 01 40       	mov    $0x40010000,%esi
    8705:	31 ff                	xor    %edi,%edi
    8707:	31 d2                	xor    %edx,%edx
    8709:	b9 22 40 00 00       	mov    $0x4022,%ecx
    870e:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    8714:	45 31 c9             	xor    %r9d,%r9d
    8717:	e8 74 aa ff ff       	call   3190 <mmap@plt>
    871c:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    8720:	74 0f                	je     8731 <fwp_gc_init+0x381>
    8722:	48 85 c0             	test   %rax,%rax
    8725:	74 3a                	je     8761 <fwp_gc_init+0x3b1>
    8727:	bb 00 00 00 40       	mov    $0x40000000,%ebx
    872c:	e9 23 fe ff ff       	jmp    8554 <fwp_gc_init+0x1a4>
    8731:	be 00 00 01 10       	mov    $0x10010000,%esi
    8736:	31 ff                	xor    %edi,%edi
    8738:	31 d2                	xor    %edx,%edx
    873a:	b9 22 40 00 00       	mov    $0x4022,%ecx
    873f:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    8745:	45 31 c9             	xor    %r9d,%r9d
    8748:	e8 43 aa ff ff       	call   3190 <mmap@plt>
    874d:	48 8d 48 01          	lea    0x1(%rax),%rcx
    8751:	48 83 f9 02          	cmp    $0x2,%rcx
    8755:	72 0a                	jb     8761 <fwp_gc_init+0x3b1>
    8757:	bb 00 00 00 10       	mov    $0x10000000,%ebx
    875c:	e9 f3 fd ff ff       	jmp    8554 <fwp_gc_init+0x1a4>
    8761:	48 8b 05 70 18 01 00 	mov    0x11870(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    8768:	48 8b 08             	mov    (%rax),%rcx
    876b:	48 8d 3d 7f d3 00 00 	lea    0xd37f(%rip),%rdi        # 15af1 <exec_in_fp0+0x281>
    8772:	be 13 00 00 00       	mov    $0x13,%esi
    8777:	ba 01 00 00 00       	mov    $0x1,%edx
    877c:	e8 ff ac ff ff       	call   3480 <fwrite@plt>
    8781:	bf 66 00 00 00       	mov    $0x66,%edi
    8786:	e8 d5 ac ff ff       	call   3460 <exit@plt>
    878b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000008790 <fwp_gc_alloc_big>:
    8790:	55                   	push   %rbp
    8791:	41 57                	push   %r15
    8793:	41 56                	push   %r14
    8795:	41 55                	push   %r13
    8797:	41 54                	push   %r12
    8799:	53                   	push   %rbx
    879a:	50                   	push   %rax
    879b:	48 b8 01 00 00 00 00 	movabs $0x4000000000000001,%rax
    87a2:	00 00 40 
    87a5:	48 39 c7             	cmp    %rax,%rdi
    87a8:	0f 83 4e 01 00 00    	jae    88fc <fwp_gc_alloc_big+0x16c>
    87ae:	89 f5                	mov    %esi,%ebp
    87b0:	48 89 fb             	mov    %rdi,%rbx
    87b3:	48 29 3d ce 1a 01 00 	sub    %rdi,0x11ace(%rip)        # 1a288 <fwp_gc>
    87ba:	79 05                	jns    87c1 <fwp_gc_alloc_big+0x31>
    87bc:	e8 6f 01 00 00       	call   8930 <fwp_gc_spent>
    87c1:	4c 8d b3 ff ff 00 00 	lea    0xffff(%rbx),%r14
    87c8:	49 c1 ee 10          	shr    $0x10,%r14
    87cc:	4c 89 f7             	mov    %r14,%rdi
    87cf:	e8 5c 03 00 00       	call   8b30 <fwp_gc_chunks>
    87d4:	48 8b 0d 25 2b 01 00 	mov    0x12b25(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    87db:	4c 69 e0 28 12 00 00 	imul   $0x1228,%rax,%r12
    87e2:	42 c6 04 21 02       	movb   $0x2,(%rcx,%r12,1)
    87e7:	42 88 6c 21 01       	mov    %bpl,0x1(%rcx,%r12,1)
    87ec:	66 42 c7 44 21 03 00 	movw   $0x100,0x3(%rcx,%r12,1)
    87f3:	01 
    87f4:	46 89 74 21 10       	mov    %r14d,0x10(%rcx,%r12,1)
    87f9:	4a 89 5c 21 18       	mov    %rbx,0x18(%rcx,%r12,1)
    87fe:	4e 8d 3c 21          	lea    (%rcx,%r12,1),%r15
    8802:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    8809:	42 80 bc 21 28 02 00 	cmpb   $0xff,0x228(%rcx,%r12,1)
    8810:	00 ff 
    8812:	0f 84 d1 00 00 00    	je     88e9 <fwp_gc_alloc_big+0x159>
    8818:	41 c6 07 00          	movb   $0x0,(%r15)
    881c:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    8823:	0f 82 9a 00 00 00    	jb     88c3 <fwp_gc_alloc_big+0x133>
    8829:	49 83 fe 03          	cmp    $0x3,%r14
    882d:	ba 02 00 00 00       	mov    $0x2,%edx
    8832:	49 0f 43 d6          	cmovae %r14,%rdx
    8836:	48 8b 0d c3 2a 01 00 	mov    0x12ac3(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    883d:	48 ff ca             	dec    %rdx
    8840:	be 01 00 00 00       	mov    $0x1,%esi
    8845:	48 81 fb 01 00 02 00 	cmp    $0x20001,%rbx
    884c:	72 59                	jb     88a7 <fwp_gc_alloc_big+0x117>
    884e:	49 8d 3c 0c          	lea    (%r12,%rcx,1),%rdi
    8852:	48 81 c7 60 24 00 00 	add    $0x2460,%rdi
    8859:	49 89 d0             	mov    %rdx,%r8
    885c:	49 83 e0 fe          	and    $0xfffffffffffffffe,%r8
    8860:	49 f7 d8             	neg    %r8
    8863:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    886a:	84 00 00 00 00 00 
    8870:	c6 87 c8 ed ff ff 03 	movb   $0x3,-0x1238(%rdi)
    8877:	c6 87 cc ed ff ff 01 	movb   $0x1,-0x1234(%rdi)
    887e:	89 87 d8 ed ff ff    	mov    %eax,-0x1228(%rdi)
    8884:	c6 47 f0 03          	movb   $0x3,-0x10(%rdi)
    8888:	c6 47 f4 01          	movb   $0x1,-0xc(%rdi)
    888c:	89 07                	mov    %eax,(%rdi)
    888e:	48 81 c7 50 24 00 00 	add    $0x2450,%rdi
    8895:	4d 8d 0c 30          	lea    (%r8,%rsi,1),%r9
    8899:	49 83 c1 02          	add    $0x2,%r9
    889d:	48 83 c6 02          	add    $0x2,%rsi
    88a1:	49 83 f9 01          	cmp    $0x1,%r9
    88a5:	75 c9                	jne    8870 <fwp_gc_alloc_big+0xe0>
    88a7:	f6 c2 01             	test   $0x1,%dl
    88aa:	74 17                	je     88c3 <fwp_gc_alloc_big+0x133>
    88ac:	4c 01 e1             	add    %r12,%rcx
    88af:	48 69 d6 28 12 00 00 	imul   $0x1228,%rsi,%rdx
    88b6:	c6 04 11 03          	movb   $0x3,(%rcx,%rdx,1)
    88ba:	c6 44 11 04 01       	movb   $0x1,0x4(%rcx,%rdx,1)
    88bf:	89 44 11 10          	mov    %eax,0x10(%rcx,%rdx,1)
    88c3:	48 c1 e0 10          	shl    $0x10,%rax
    88c7:	48 03 05 ea 29 01 00 	add    0x129ea(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    88ce:	48 89 c7             	mov    %rax,%rdi
    88d1:	31 f6                	xor    %esi,%esi
    88d3:	48 89 da             	mov    %rbx,%rdx
    88d6:	48 83 c4 08          	add    $0x8,%rsp
    88da:	5b                   	pop    %rbx
    88db:	41 5c                	pop    %r12
    88dd:	41 5d                	pop    %r13
    88df:	41 5e                	pop    %r14
    88e1:	41 5f                	pop    %r15
    88e3:	5d                   	pop    %rbp
    88e4:	e9 27 a9 ff ff       	jmp    3210 <memset@plt>
    88e9:	4c 89 ff             	mov    %r15,%rdi
    88ec:	49 89 c5             	mov    %rax,%r13
    88ef:	e8 4c e2 ff ff       	call   6b40 <fwp_rc_forget_slot>
    88f4:	4c 89 e8             	mov    %r13,%rax
    88f7:	e9 1c ff ff ff       	jmp    8818 <fwp_gc_alloc_big+0x88>
    88fc:	48 8b 05 d5 16 01 00 	mov    0x116d5(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    8903:	48 8b 08             	mov    (%rax),%rcx
    8906:	48 8d 3d e4 d1 00 00 	lea    0xd1e4(%rip),%rdi        # 15af1 <exec_in_fp0+0x281>
    890d:	be 13 00 00 00       	mov    $0x13,%esi
    8912:	ba 01 00 00 00       	mov    $0x1,%edx
    8917:	e8 64 ab ff ff       	call   3480 <fwrite@plt>
    891c:	bf 66 00 00 00       	mov    $0x66,%edi
    8921:	e8 3a ab ff ff       	call   3460 <exit@plt>
    8926:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    892d:	00 00 00 

0000000000008930 <fwp_gc_spent>:
    8930:	50                   	push   %rax
    8931:	83 3d 3c 29 01 00 00 	cmpl   $0x0,0x1293c(%rip)        # 1b274 <fwp_gc+0xfec>
    8938:	75 05                	jne    893f <fwp_gc_spent+0xf>
    893a:	e8 71 fa ff ff       	call   83b0 <fwp_gc_init>
    893f:	8b 05 37 29 01 00    	mov    0x12937(%rip),%eax        # 1b27c <fwp_gc+0xff4>
    8945:	85 c0                	test   %eax,%eax
    8947:	74 6d                	je     89b6 <fwp_gc_spent+0x86>
    8949:	48 8b 0d 58 29 01 00 	mov    0x12958(%rip),%rcx        # 1b2a8 <fwp_gc+0x1020>
    8950:	48 85 c9             	test   %rcx,%rcx
    8953:	74 61                	je     89b6 <fwp_gc_spent+0x86>
    8955:	48 8b 05 54 29 01 00 	mov    0x12954(%rip),%rax        # 1b2b0 <fwp_gc+0x1028>
    895c:	48 ff c0             	inc    %rax
    895f:	48 89 05 4a 29 01 00 	mov    %rax,0x1294a(%rip)        # 1b2b0 <fwp_gc+0x1028>
    8966:	48 39 c8             	cmp    %rcx,%rax
    8969:	7c 10                	jl     897b <fwp_gc_spent+0x4b>
    896b:	48 c7 05 3a 29 01 00 	movq   $0x0,0x1293a(%rip)        # 1b2b0 <fwp_gc+0x1028>
    8972:	00 00 00 00 
    8976:	e8 45 03 00 00       	call   8cc0 <fwp_gc_collect>
    897b:	48 8b 05 16 2b 01 00 	mov    0x12b16(%rip),%rax        # 1b498 <fwp_gc+0x1210>
    8982:	48 2b 05 ff 18 01 00 	sub    0x118ff(%rip),%rax        # 1a288 <fwp_gc>
    8989:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    898e:	f2 0f 58 05 da 2a 01 	addsd  0x12ada(%rip),%xmm0        # 1b470 <fwp_gc+0x11e8>
    8995:	00 
    8996:	f2 0f 11 05 d2 2a 01 	movsd  %xmm0,0x12ad2(%rip)        # 1b470 <fwp_gc+0x11e8>
    899d:	00 
    899e:	48 c7 05 ef 2a 01 00 	movq   $0x0,0x12aef(%rip)        # 1b498 <fwp_gc+0x1210>
    89a5:	00 00 00 00 
    89a9:	48 c7 05 d4 18 01 00 	movq   $0x0,0x118d4(%rip)        # 1a288 <fwp_gc>
    89b0:	00 00 00 00 
    89b4:	58                   	pop    %rax
    89b5:	c3                   	ret
    89b6:	85 c0                	test   %eax,%eax
    89b8:	74 06                	je     89c0 <fwp_gc_spent+0x90>
    89ba:	58                   	pop    %rax
    89bb:	e9 00 03 00 00       	jmp    8cc0 <fwp_gc_collect>
    89c0:	48 8b 05 d1 2a 01 00 	mov    0x12ad1(%rip),%rax        # 1b498 <fwp_gc+0x1210>
    89c7:	48 2b 05 ba 18 01 00 	sub    0x118ba(%rip),%rax        # 1a288 <fwp_gc>
    89ce:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    89d3:	f2 0f 58 05 95 2a 01 	addsd  0x12a95(%rip),%xmm0        # 1b470 <fwp_gc+0x11e8>
    89da:	00 
    89db:	f2 0f 11 05 8d 2a 01 	movsd  %xmm0,0x12a8d(%rip)        # 1b470 <fwp_gc+0x11e8>
    89e2:	00 
    89e3:	48 c7 05 aa 2a 01 00 	movq   $0x800000,0x12aaa(%rip)        # 1b498 <fwp_gc+0x1210>
    89ea:	00 00 80 00 
    89ee:	48 c7 05 8f 18 01 00 	movq   $0x800000,0x1188f(%rip)        # 1a288 <fwp_gc>
    89f5:	00 00 80 00 
    89f9:	58                   	pop    %rax
    89fa:	c3                   	ret
    89fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000008a00 <fwp_gc_refill>:
    8a00:	55                   	push   %rbp
    8a01:	41 57                	push   %r15
    8a03:	41 56                	push   %r14
    8a05:	41 55                	push   %r13
    8a07:	41 54                	push   %r12
    8a09:	53                   	push   %rbx
    8a0a:	50                   	push   %rax
    8a0b:	89 d5                	mov    %edx,%ebp
    8a0d:	41 89 f7             	mov    %esi,%r15d
    8a10:	48 89 fb             	mov    %rdi,%rbx
    8a13:	bf 01 00 00 00       	mov    $0x1,%edi
    8a18:	e8 13 01 00 00       	call   8b30 <fwp_gc_chunks>
    8a1d:	49 89 c6             	mov    %rax,%r14
    8a20:	4c 8b 25 d9 28 01 00 	mov    0x128d9(%rip),%r12        # 1b300 <fwp_gc+0x1078>
    8a27:	48 8d 05 5a 18 01 00 	lea    0x1185a(%rip),%rax        # 1a288 <fwp_gc>
    8a2e:	4d 69 ee 28 12 00 00 	imul   $0x1228,%r14,%r13
    8a35:	43 c6 04 2c 01       	movb   $0x1,(%r12,%r13,1)
    8a3a:	43 88 6c 2c 01       	mov    %bpl,0x1(%r12,%r13,1)
    8a3f:	47 88 7c 2c 02       	mov    %r15b,0x2(%r12,%r13,1)
    8a44:	43 c6 44 2c 04 01    	movb   $0x1,0x4(%r12,%r13,1)
    8a4a:	44 89 f9             	mov    %r15d,%ecx
    8a4d:	8b 8c 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%ecx
    8a54:	43 89 4c 2c 08       	mov    %ecx,0x8(%r12,%r13,1)
    8a59:	b8 00 00 01 00       	mov    $0x10000,%eax
    8a5e:	31 d2                	xor    %edx,%edx
    8a60:	f7 f1                	div    %ecx
    8a62:	43 89 44 2c 0c       	mov    %eax,0xc(%r12,%r13,1)
    8a67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    8a6c:	48 01 c8             	add    %rcx,%rax
    8a6f:	48 0f ba e0 20       	bt     $0x20,%rax
    8a74:	73 07                	jae    8a7d <fwp_gc_refill+0x7d>
    8a76:	31 d2                	xor    %edx,%edx
    8a78:	48 f7 f1             	div    %rcx
    8a7b:	eb 04                	jmp    8a81 <fwp_gc_refill+0x81>
    8a7d:	31 d2                	xor    %edx,%edx
    8a7f:	f7 f1                	div    %ecx
    8a81:	43 89 44 2c 20       	mov    %eax,0x20(%r12,%r13,1)
    8a86:	48 83 3d 12 32 01 00 	cmpq   $0x0,0x13212(%rip)        # 1bca0 <fwp_gc+0x1a18>
    8a8d:	00 
    8a8e:	74 2e                	je     8abe <fwp_gc_refill+0xbe>
    8a90:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    8a94:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    8a9b:	31 ed                	xor    %ebp,%ebp
    8a9d:	eb 0d                	jmp    8aac <fwp_gc_refill+0xac>
    8a9f:	90                   	nop
    8aa0:	48 ff c5             	inc    %rbp
    8aa3:	48 81 fd 00 10 00 00 	cmp    $0x1000,%rbp
    8aaa:	74 12                	je     8abe <fwp_gc_refill+0xbe>
    8aac:	41 80 3c 2f ff       	cmpb   $0xff,(%r15,%rbp,1)
    8ab1:	75 ed                	jne    8aa0 <fwp_gc_refill+0xa0>
    8ab3:	49 8d 3c 2f          	lea    (%r15,%rbp,1),%rdi
    8ab7:	e8 84 e0 ff ff       	call   6b40 <fwp_rc_forget_slot>
    8abc:	eb e2                	jmp    8aa0 <fwp_gc_refill+0xa0>
    8abe:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    8ac2:	49 83 c7 08          	add    $0x8,%r15
    8ac6:	4b 8d 3c 2c          	lea    (%r12,%r13,1),%rdi
    8aca:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    8ad1:	ba 00 10 00 00       	mov    $0x1000,%edx
    8ad6:	31 f6                	xor    %esi,%esi
    8ad8:	e8 33 a7 ff ff       	call   3210 <memset@plt>
    8add:	49 c1 e6 10          	shl    $0x10,%r14
    8ae1:	4c 03 35 d0 27 01 00 	add    0x127d0(%rip),%r14        # 1b2b8 <fwp_gc+0x1030>
    8ae8:	83 3d 9d 27 01 00 00 	cmpl   $0x0,0x1279d(%rip)        # 1b28c <fwp_gc+0x1004>
    8aef:	74 0f                	je     8b00 <fwp_gc_refill+0x100>
    8af1:	ba 00 00 01 00       	mov    $0x10000,%edx
    8af6:	4c 89 f7             	mov    %r14,%rdi
    8af9:	31 f6                	xor    %esi,%esi
    8afb:	e8 10 a7 ff ff       	call   3210 <memset@plt>
    8b00:	41 8b 07             	mov    (%r15),%eax
    8b03:	49 8d 0c 06          	lea    (%r14,%rax,1),%rcx
    8b07:	48 89 4b 08          	mov    %rcx,0x8(%rbx)
    8b0b:	41 8b 4f 04          	mov    0x4(%r15),%ecx
    8b0f:	48 0f af c8          	imul   %rax,%rcx
    8b13:	4c 01 f1             	add    %r14,%rcx
    8b16:	48 89 4b 10          	mov    %rcx,0x10(%rbx)
    8b1a:	4c 89 f0             	mov    %r14,%rax
    8b1d:	48 83 c4 08          	add    $0x8,%rsp
    8b21:	5b                   	pop    %rbx
    8b22:	41 5c                	pop    %r12
    8b24:	41 5d                	pop    %r13
    8b26:	41 5e                	pop    %r14
    8b28:	41 5f                	pop    %r15
    8b2a:	5d                   	pop    %rbp
    8b2b:	c3                   	ret
    8b2c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000008b30 <fwp_gc_chunks>:
    8b30:	41 57                	push   %r15
    8b32:	41 56                	push   %r14
    8b34:	53                   	push   %rbx
    8b35:	48 89 fb             	mov    %rdi,%rbx
    8b38:	31 d2                	xor    %edx,%edx
    8b3a:	48 83 ff 01          	cmp    $0x1,%rdi
    8b3e:	0f 95 c2             	setne  %dl
    8b41:	48 8d 0d 40 17 01 00 	lea    0x11740(%rip),%rcx        # 1a288 <fwp_gc>
    8b48:	48 8b 84 d1 68 10 00 	mov    0x1068(%rcx,%rdx,8),%rax
    8b4f:	00 
    8b50:	4c 8b 35 89 27 01 00 	mov    0x12789(%rip),%r14        # 1b2e0 <fwp_gc+0x1058>
    8b57:	48 89 c7             	mov    %rax,%rdi
    8b5a:	4c 29 f7             	sub    %r14,%rdi
    8b5d:	73 63                	jae    8bc2 <fwp_gc_chunks+0x92>
    8b5f:	48 8d 34 d5 68 10 00 	lea    0x1068(,%rdx,8),%rsi
    8b66:	00 
    8b67:	4c 69 c0 28 12 00 00 	imul   $0x1228,%rax,%r8
    8b6e:	4c 03 05 8b 27 01 00 	add    0x1278b(%rip),%r8        # 1b300 <fwp_gc+0x1078>
    8b75:	31 d2                	xor    %edx,%edx
    8b77:	45 31 c9             	xor    %r9d,%r9d
    8b7a:	eb 16                	jmp    8b92 <fwp_gc_chunks+0x62>
    8b7c:	0f 1f 40 00          	nopl   0x0(%rax)
    8b80:	45 31 c9             	xor    %r9d,%r9d
    8b83:	48 ff ca             	dec    %rdx
    8b86:	49 81 c0 28 12 00 00 	add    $0x1228,%r8
    8b8d:	48 39 d7             	cmp    %rdx,%rdi
    8b90:	74 33                	je     8bc5 <fwp_gc_chunks+0x95>
    8b92:	41 80 38 00          	cmpb   $0x0,(%r8)
    8b96:	75 e8                	jne    8b80 <fwp_gc_chunks+0x50>
    8b98:	49 ff c1             	inc    %r9
    8b9b:	49 39 d9             	cmp    %rbx,%r9
    8b9e:	75 e3                	jne    8b83 <fwp_gc_chunks+0x53>
    8ba0:	48 ff c0             	inc    %rax
    8ba3:	48 89 c7             	mov    %rax,%rdi
    8ba6:	48 29 d7             	sub    %rdx,%rdi
    8ba9:	48 89 3c 0e          	mov    %rdi,(%rsi,%rcx,1)
    8bad:	48 29 1d b4 28 01 00 	sub    %rbx,0x128b4(%rip)        # 1b468 <fwp_gc+0x11e0>
    8bb4:	48 29 d8             	sub    %rbx,%rax
    8bb7:	48 29 d0             	sub    %rdx,%rax
    8bba:	49 89 c6             	mov    %rax,%r14
    8bbd:	e9 ca 00 00 00       	jmp    8c8c <fwp_gc_chunks+0x15c>
    8bc2:	45 31 c9             	xor    %r9d,%r9d
    8bc5:	4c 29 0d 9c 28 01 00 	sub    %r9,0x1289c(%rip)        # 1b468 <fwp_gc+0x11e0>
    8bcc:	4d 29 ce             	sub    %r9,%r14
    8bcf:	4c 01 f3             	add    %r14,%rbx
    8bd2:	48 8b 3d 0f 27 01 00 	mov    0x1270f(%rip),%rdi        # 1b2e8 <fwp_gc+0x1060>
    8bd9:	48 39 df             	cmp    %rbx,%rdi
    8bdc:	0f 83 8f 00 00 00    	jae    8c71 <fwp_gc_chunks+0x141>
    8be2:	4c 8b 3d ef 26 01 00 	mov    0x126ef(%rip),%r15        # 1b2d8 <fwp_gc+0x1050>
    8be9:	49 39 df             	cmp    %rbx,%r15
    8bec:	0f 82 a3 00 00 00    	jb     8c95 <fwp_gc_chunks+0x165>
    8bf2:	48 8d 43 40          	lea    0x40(%rbx),%rax
    8bf6:	4c 39 f8             	cmp    %r15,%rax
    8bf9:	4c 0f 42 f8          	cmovb  %rax,%r15
    8bfd:	4c 89 fe             	mov    %r15,%rsi
    8c00:	48 29 fe             	sub    %rdi,%rsi
    8c03:	48 c1 e7 10          	shl    $0x10,%rdi
    8c07:	48 03 3d aa 26 01 00 	add    0x126aa(%rip),%rdi        # 1b2b8 <fwp_gc+0x1030>
    8c0e:	48 c1 e6 10          	shl    $0x10,%rsi
    8c12:	ba 03 00 00 00       	mov    $0x3,%edx
    8c17:	e8 e4 a7 ff ff       	call   3400 <mprotect@plt>
    8c1c:	85 c0                	test   %eax,%eax
    8c1e:	75 75                	jne    8c95 <fwp_gc_chunks+0x165>
    8c20:	bf 1e 00 00 00       	mov    $0x1e,%edi
    8c25:	e8 f6 a7 ff ff       	call   3420 <sysconf@plt>
    8c2a:	48 8b 0d cf 26 01 00 	mov    0x126cf(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    8c31:	48 69 3d ac 26 01 00 	imul   $0x1228,0x126ac(%rip),%rdi        # 1b2e8 <fwp_gc+0x1060>
    8c38:	28 12 00 00 
    8c3c:	48 01 cf             	add    %rcx,%rdi
    8c3f:	49 69 d7 28 12 00 00 	imul   $0x1228,%r15,%rdx
    8c46:	48 01 ca             	add    %rcx,%rdx
    8c49:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    8c4d:	48 ff ce             	dec    %rsi
    8c50:	48 f7 d8             	neg    %rax
    8c53:	48 21 c7             	and    %rax,%rdi
    8c56:	48 21 c6             	and    %rax,%rsi
    8c59:	48 29 fe             	sub    %rdi,%rsi
    8c5c:	ba 03 00 00 00       	mov    $0x3,%edx
    8c61:	e8 9a a7 ff ff       	call   3400 <mprotect@plt>
    8c66:	85 c0                	test   %eax,%eax
    8c68:	75 2b                	jne    8c95 <fwp_gc_chunks+0x165>
    8c6a:	4c 89 3d 77 26 01 00 	mov    %r15,0x12677(%rip)        # 1b2e8 <fwp_gc+0x1060>
    8c71:	48 89 1d 68 26 01 00 	mov    %rbx,0x12668(%rip)        # 1b2e0 <fwp_gc+0x1058>
    8c78:	48 c1 e3 10          	shl    $0x10,%rbx
    8c7c:	48 3b 1d 4d 26 01 00 	cmp    0x1264d(%rip),%rbx        # 1b2d0 <fwp_gc+0x1048>
    8c83:	76 07                	jbe    8c8c <fwp_gc_chunks+0x15c>
    8c85:	48 89 1d 44 26 01 00 	mov    %rbx,0x12644(%rip)        # 1b2d0 <fwp_gc+0x1048>
    8c8c:	4c 89 f0             	mov    %r14,%rax
    8c8f:	5b                   	pop    %rbx
    8c90:	41 5e                	pop    %r14
    8c92:	41 5f                	pop    %r15
    8c94:	c3                   	ret
    8c95:	48 8b 05 3c 13 01 00 	mov    0x1133c(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    8c9c:	48 8b 08             	mov    (%rax),%rcx
    8c9f:	48 8d 3d 4b ce 00 00 	lea    0xce4b(%rip),%rdi        # 15af1 <exec_in_fp0+0x281>
    8ca6:	be 13 00 00 00       	mov    $0x13,%esi
    8cab:	ba 01 00 00 00       	mov    $0x1,%edx
    8cb0:	e8 cb a7 ff ff       	call   3480 <fwrite@plt>
    8cb5:	bf 66 00 00 00       	mov    $0x66,%edi
    8cba:	e8 a1 a7 ff ff       	call   3460 <exit@plt>
    8cbf:	90                   	nop

0000000000008cc0 <fwp_gc_collect>:
    8cc0:	55                   	push   %rbp
    8cc1:	48 89 e5             	mov    %rsp,%rbp
    8cc4:	41 57                	push   %r15
    8cc6:	41 56                	push   %r14
    8cc8:	41 55                	push   %r13
    8cca:	41 54                	push   %r12
    8ccc:	53                   	push   %rbx
    8ccd:	48 81 ec a8 01 00 00 	sub    $0x1a8,%rsp
    8cd4:	83 3d a5 25 01 00 00 	cmpl   $0x0,0x125a5(%rip)        # 1b280 <fwp_gc+0xff8>
    8cdb:	0f 85 a5 04 00 00    	jne    9186 <fwp_gc_collect+0x4c6>
    8ce1:	c7 05 95 25 01 00 01 	movl   $0x1,0x12595(%rip)        # 1b280 <fwp_gc+0xff8>
    8ce8:	00 00 00 
    8ceb:	48 8d b5 20 ff ff ff 	lea    -0xe0(%rbp),%rsi
    8cf2:	bf 01 00 00 00       	mov    $0x1,%edi
    8cf7:	e8 34 a4 ff ff       	call   3130 <clock_gettime@plt>
    8cfc:	48 8b 05 95 27 01 00 	mov    0x12795(%rip),%rax        # 1b498 <fwp_gc+0x1210>
    8d03:	48 2b 05 7e 15 01 00 	sub    0x1157e(%rip),%rax        # 1a288 <fwp_gc>
    8d0a:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    8d0f:	f2 0f 58 05 59 27 01 	addsd  0x12759(%rip),%xmm0        # 1b470 <fwp_gc+0x11e8>
    8d16:	00 
    8d17:	f2 0f 11 05 51 27 01 	movsd  %xmm0,0x12751(%rip)        # 1b470 <fwp_gc+0x11e8>
    8d1e:	00 
    8d1f:	83 3d 62 25 01 00 00 	cmpl   $0x0,0x12562(%rip)        # 1b288 <fwp_gc+0x1000>
    8d26:	0f 94 c0             	sete   %al
    8d29:	83 3d 60 25 01 00 00 	cmpl   $0x0,0x12560(%rip)        # 1b290 <fwp_gc+0x1008>
    8d30:	41 0f 95 c4          	setne  %r12b
    8d34:	41 08 c4             	or     %al,%r12b
    8d37:	41 80 fc 01          	cmp    $0x1,%r12b
    8d3b:	0f 85 8f 00 00 00    	jne    8dd0 <fwp_gc_collect+0x110>
    8d41:	48 8b 05 98 25 01 00 	mov    0x12598(%rip),%rax        # 1b2e0 <fwp_gc+0x1058>
    8d48:	48 85 c0             	test   %rax,%rax
    8d4b:	0f 84 c4 01 00 00    	je     8f15 <fwp_gc_collect+0x255>
    8d51:	48 8b 15 a8 25 01 00 	mov    0x125a8(%rip),%rdx        # 1b300 <fwp_gc+0x1078>
    8d58:	31 db                	xor    %ebx,%ebx
    8d5a:	41 89 df             	mov    %ebx,%r15d
    8d5d:	4d 89 fe             	mov    %r15,%r14
    8d60:	48 89 c1             	mov    %rax,%rcx
    8d63:	48 89 d0             	mov    %rdx,%rax
    8d66:	eb 2a                	jmp    8d92 <fwp_gc_collect+0xd2>
    8d68:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    8d6f:	00 
    8d70:	42 c6 44 38 03 00    	movb   $0x0,0x3(%rax,%r15,1)
    8d76:	48 89 ca             	mov    %rcx,%rdx
    8d79:	4c 89 f6             	mov    %r14,%rsi
    8d7c:	48 ff c6             	inc    %rsi
    8d7f:	49 81 c7 28 12 00 00 	add    $0x1228,%r15
    8d86:	49 89 f6             	mov    %rsi,%r14
    8d89:	48 39 ce             	cmp    %rcx,%rsi
    8d8c:	0f 83 83 01 00 00    	jae    8f15 <fwp_gc_collect+0x255>
    8d92:	42 0f b6 14 38       	movzbl (%rax,%r15,1),%edx
    8d97:	83 fa 02             	cmp    $0x2,%edx
    8d9a:	74 d4                	je     8d70 <fwp_gc_collect+0xb0>
    8d9c:	83 fa 01             	cmp    $0x1,%edx
    8d9f:	75 d5                	jne    8d76 <fwp_gc_collect+0xb6>
    8da1:	4a 8d 3c 38          	lea    (%rax,%r15,1),%rdi
    8da5:	48 83 c7 28          	add    $0x28,%rdi
    8da9:	42 8b 44 38 0c       	mov    0xc(%rax,%r15,1),%eax
    8dae:	83 c0 3f             	add    $0x3f,%eax
    8db1:	c1 e8 03             	shr    $0x3,%eax
    8db4:	83 e0 f8             	and    $0xfffffff8,%eax
    8db7:	89 c2                	mov    %eax,%edx
    8db9:	89 de                	mov    %ebx,%esi
    8dbb:	e8 50 a4 ff ff       	call   3210 <memset@plt>
    8dc0:	48 8b 05 39 25 01 00 	mov    0x12539(%rip),%rax        # 1b300 <fwp_gc+0x1078>
    8dc7:	48 8b 0d 12 25 01 00 	mov    0x12512(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    8dce:	eb a6                	jmp    8d76 <fwp_gc_collect+0xb6>
    8dd0:	44 88 65 d7          	mov    %r12b,-0x29(%rbp)
    8dd4:	48 8d bd 50 fe ff ff 	lea    -0x1b0(%rbp),%rdi
    8ddb:	e8 d0 a4 ff ff       	call   32b0 <_setjmp@plt>
    8de0:	48 c7 05 9d 26 01 00 	movq   $0x0,0x1269d(%rip)        # 1b488 <fwp_gc+0x1200>
    8de7:	00 00 00 00 
    8deb:	e8 10 08 00 00       	call   9600 <fwp_gc_mark_all>
    8df0:	48 83 3d e8 24 01 00 	cmpq   $0x0,0x124e8(%rip)        # 1b2e0 <fwp_gc+0x1058>
    8df7:	00 
    8df8:	0f 84 53 01 00 00    	je     8f51 <fwp_gc_collect+0x291>
    8dfe:	31 c0                	xor    %eax,%eax
    8e00:	eb 25                	jmp    8e27 <fwp_gc_collect+0x167>
    8e02:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8e09:	1f 84 00 00 00 00 00 
    8e10:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
    8e14:	48 ff c1             	inc    %rcx
    8e17:	48 89 c8             	mov    %rcx,%rax
    8e1a:	48 3b 0d bf 24 01 00 	cmp    0x124bf(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    8e21:	0f 83 2a 01 00 00    	jae    8f51 <fwp_gc_collect+0x291>
    8e27:	48 8b 1d d2 24 01 00 	mov    0x124d2(%rip),%rbx        # 1b300 <fwp_gc+0x1078>
    8e2e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    8e32:	48 69 c0 28 12 00 00 	imul   $0x1228,%rax,%rax
    8e39:	80 7c 03 01 02       	cmpb   $0x2,0x1(%rbx,%rax,1)
    8e3e:	75 d0                	jne    8e10 <fwp_gc_collect+0x150>
    8e40:	0f b6 0c 03          	movzbl (%rbx,%rax,1),%ecx
    8e44:	83 f9 02             	cmp    $0x2,%ecx
    8e47:	0f 84 9f 00 00 00    	je     8eec <fwp_gc_collect+0x22c>
    8e4d:	83 f9 01             	cmp    $0x1,%ecx
    8e50:	75 be                	jne    8e10 <fwp_gc_collect+0x150>
    8e52:	8b 4c 03 0c          	mov    0xc(%rbx,%rax,1),%ecx
    8e56:	83 c1 3f             	add    $0x3f,%ecx
    8e59:	83 f9 40             	cmp    $0x40,%ecx
    8e5c:	72 b2                	jb     8e10 <fwp_gc_collect+0x150>
    8e5e:	4c 8b 7d c0          	mov    -0x40(%rbp),%r15
    8e62:	49 c1 e7 10          	shl    $0x10,%r15
    8e66:	4c 03 3d 4b 24 01 00 	add    0x1244b(%rip),%r15        # 1b2b8 <fwp_gc+0x1030>
    8e6d:	c1 e9 06             	shr    $0x6,%ecx
    8e70:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    8e74:	4c 8d 2c 03          	lea    (%rbx,%rax,1),%r13
    8e78:	49 83 c5 08          	add    $0x8,%r13
    8e7c:	31 c9                	xor    %ecx,%ecx
    8e7e:	41 89 cc             	mov    %ecx,%r12d
    8e81:	48 01 c3             	add    %rax,%rbx
    8e84:	48 89 5d 98          	mov    %rbx,-0x68(%rbp)
    8e88:	eb 1a                	jmp    8ea4 <fwp_gc_collect+0x1e4>
    8e8a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8e90:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    8e94:	48 ff c0             	inc    %rax
    8e97:	49 89 c4             	mov    %rax,%r12
    8e9a:	48 3b 45 90          	cmp    -0x70(%rbp),%rax
    8e9e:	0f 84 6c ff ff ff    	je     8e10 <fwp_gc_collect+0x150>
    8ea4:	48 8b 45 98          	mov    -0x68(%rbp),%rax
    8ea8:	4c 89 65 b0          	mov    %r12,-0x50(%rbp)
    8eac:	4e 8b 64 e0 28       	mov    0x28(%rax,%r12,8),%r12
    8eb1:	4d 85 e4             	test   %r12,%r12
    8eb4:	74 da                	je     8e90 <fwp_gc_collect+0x1d0>
    8eb6:	4c 8b 75 b0          	mov    -0x50(%rbp),%r14
    8eba:	49 c1 e6 06          	shl    $0x6,%r14
    8ebe:	66 90                	xchg   %ax,%ax
    8ec0:	f3 49 0f bc c4       	tzcnt  %r12,%rax
    8ec5:	4c 09 f0             	or     %r14,%rax
    8ec8:	49 8d 5c 24 ff       	lea    -0x1(%r12),%rbx
    8ecd:	41 8b 4d 00          	mov    0x0(%r13),%ecx
    8ed1:	89 ce                	mov    %ecx,%esi
    8ed3:	48 0f af c6          	imul   %rsi,%rax
    8ed7:	48 89 c7             	mov    %rax,%rdi
    8eda:	4c 01 ff             	add    %r15,%rdi
    8edd:	e8 4e 13 00 00       	call   a230 <fwp_gc_push>
    8ee2:	4c 21 e3             	and    %r12,%rbx
    8ee5:	49 89 dc             	mov    %rbx,%r12
    8ee8:	75 d6                	jne    8ec0 <fwp_gc_collect+0x200>
    8eea:	eb a4                	jmp    8e90 <fwp_gc_collect+0x1d0>
    8eec:	80 7c 03 03 00       	cmpb   $0x0,0x3(%rbx,%rax,1)
    8ef1:	0f 84 19 ff ff ff    	je     8e10 <fwp_gc_collect+0x150>
    8ef7:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
    8efb:	48 c1 e7 10          	shl    $0x10,%rdi
    8eff:	48 03 3d b2 23 01 00 	add    0x123b2(%rip),%rdi        # 1b2b8 <fwp_gc+0x1030>
    8f06:	48 8b 74 03 18       	mov    0x18(%rbx,%rax,1),%rsi
    8f0b:	e8 20 13 00 00       	call   a230 <fwp_gc_push>
    8f10:	e9 fb fe ff ff       	jmp    8e10 <fwp_gc_collect+0x150>
    8f15:	48 8d bd 50 fe ff ff 	lea    -0x1b0(%rbp),%rdi
    8f1c:	e8 8f a3 ff ff       	call   32b0 <_setjmp@plt>
    8f21:	48 c7 05 5c 25 01 00 	movq   $0x0,0x1255c(%rip)        # 1b488 <fwp_gc+0x1200>
    8f28:	00 00 00 00 
    8f2c:	e8 cf 06 00 00       	call   9600 <fwp_gc_mark_all>
    8f31:	e8 0a 08 00 00       	call   9740 <fwp_gc_finalize>
    8f36:	e8 35 09 00 00       	call   9870 <fwp_gc_sweep>
    8f3b:	48 8b 05 1e 25 01 00 	mov    0x1251e(%rip),%rax        # 1b460 <fwp_gc+0x11d8>
    8f42:	48 ff c0             	inc    %rax
    8f45:	48 89 05 14 25 01 00 	mov    %rax,0x12514(%rip)        # 1b460 <fwp_gc+0x11d8>
    8f4c:	e9 0d 01 00 00       	jmp    905e <fwp_gc_collect+0x39e>
    8f51:	48 8b 05 d0 24 01 00 	mov    0x124d0(%rip),%rax        # 1b428 <fwp_gc+0x11a0>
    8f58:	48 85 c0             	test   %rax,%rax
    8f5b:	74 3a                	je     8f97 <fwp_gc_collect+0x2d7>
    8f5d:	31 db                	xor    %ebx,%ebx
    8f5f:	90                   	nop
    8f60:	48 8b 0d b9 24 01 00 	mov    0x124b9(%rip),%rcx        # 1b420 <fwp_gc+0x1198>
    8f67:	48 ff c8             	dec    %rax
    8f6a:	48 89 05 b7 24 01 00 	mov    %rax,0x124b7(%rip)        # 1b428 <fwp_gc+0x11a0>
    8f71:	48 c1 e0 04          	shl    $0x4,%rax
    8f75:	48 8b 3c 01          	mov    (%rcx,%rax,1),%rdi
    8f79:	48 8b 74 01 08       	mov    0x8(%rcx,%rax,1),%rsi
    8f7e:	48 01 fe             	add    %rdi,%rsi
    8f81:	89 da                	mov    %ebx,%edx
    8f83:	e8 88 0f 00 00       	call   9f10 <fwp_gc_scan>
    8f88:	48 8b 0d 99 24 01 00 	mov    0x12499(%rip),%rcx        # 1b428 <fwp_gc+0x11a0>
    8f8f:	48 89 c8             	mov    %rcx,%rax
    8f92:	48 85 c9             	test   %rcx,%rcx
    8f95:	75 c9                	jne    8f60 <fwp_gc_collect+0x2a0>
    8f97:	83 3d ee 22 01 00 00 	cmpl   $0x0,0x122ee(%rip)        # 1b28c <fwp_gc+0x1004>
    8f9e:	44 0f b6 65 d7       	movzbl -0x29(%rbp),%r12d
    8fa3:	0f 84 93 00 00 00    	je     903c <fwp_gc_collect+0x37c>
    8fa9:	4c 8b 35 30 23 01 00 	mov    0x12330(%rip),%r14        # 1b2e0 <fwp_gc+0x1058>
    8fb0:	4c 89 f7             	mov    %r14,%rdi
    8fb3:	48 c1 e7 09          	shl    $0x9,%rdi
    8fb7:	e8 84 a3 ff ff       	call   3340 <malloc@plt>
    8fbc:	48 89 c3             	mov    %rax,%rbx
    8fbf:	49 83 fe 01          	cmp    $0x1,%r14
    8fc3:	4c 89 f7             	mov    %r14,%rdi
    8fc6:	48 83 d7 00          	adc    $0x0,%rdi
    8fca:	48 89 bd 40 ff ff ff 	mov    %rdi,-0xc0(%rbp)
    8fd1:	e8 6a a3 ff ff       	call   3340 <malloc@plt>
    8fd6:	48 89 5d c8          	mov    %rbx,-0x38(%rbp)
    8fda:	48 85 db             	test   %rbx,%rbx
    8fdd:	0f 84 ea 05 00 00    	je     95cd <fwp_gc_collect+0x90d>
    8fe3:	48 85 c0             	test   %rax,%rax
    8fe6:	0f 84 e1 05 00 00    	je     95cd <fwp_gc_collect+0x90d>
    8fec:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
    8ff0:	48 89 4d a0          	mov    %rcx,-0x60(%rbp)
    8ff4:	49 89 c5             	mov    %rax,%r13
    8ff7:	4d 85 f6             	test   %r14,%r14
    8ffa:	74 2a                	je     9026 <fwp_gc_collect+0x366>
    8ffc:	4c 89 6d b8          	mov    %r13,-0x48(%rbp)
    9000:	48 8b 0d f9 22 01 00 	mov    0x122f9(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    9007:	49 83 fe 01          	cmp    $0x1,%r14
    900b:	4c 89 b5 48 ff ff ff 	mov    %r14,-0xb8(%rbp)
    9012:	48 89 8d 70 ff ff ff 	mov    %rcx,-0x90(%rbp)
    9019:	0f 85 79 01 00 00    	jne    9198 <fwp_gc_collect+0x4d8>
    901f:	31 c0                	xor    %eax,%eax
    9021:	e9 f8 01 00 00       	jmp    921e <fwp_gc_collect+0x55e>
    9026:	e8 d5 05 00 00       	call   9600 <fwp_gc_mark_all>
    902b:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
    902f:	e8 1c a0 ff ff       	call   3050 <free@plt>
    9034:	4c 89 ef             	mov    %r13,%rdi
    9037:	e8 14 a0 ff ff       	call   3050 <free@plt>
    903c:	e8 ff 06 00 00       	call   9740 <fwp_gc_finalize>
    9041:	e8 2a 08 00 00       	call   9870 <fwp_gc_sweep>
    9046:	48 8b 05 13 24 01 00 	mov    0x12413(%rip),%rax        # 1b460 <fwp_gc+0x11d8>
    904d:	48 ff c0             	inc    %rax
    9050:	48 89 05 09 24 01 00 	mov    %rax,0x12409(%rip)        # 1b460 <fwp_gc+0x11d8>
    9057:	48 ff 05 42 22 01 00 	incq   0x12242(%rip)        # 1b2a0 <fwp_gc+0x1018>
    905e:	48 89 c1             	mov    %rax,%rcx
    9061:	48 8b 05 e8 23 01 00 	mov    0x123e8(%rip),%rax        # 1b450 <fwp_gc+0x11c8>
    9068:	48 3b 05 e9 23 01 00 	cmp    0x123e9(%rip),%rax        # 1b458 <fwp_gc+0x11d0>
    906f:	76 07                	jbe    9078 <fwp_gc_collect+0x3b8>
    9071:	48 89 05 e0 23 01 00 	mov    %rax,0x123e0(%rip)        # 1b458 <fwp_gc+0x11d0>
    9078:	45 84 e4             	test   %r12b,%r12b
    907b:	74 0b                	je     9088 <fwp_gc_collect+0x3c8>
    907d:	48 89 05 14 22 01 00 	mov    %rax,0x12214(%rip)        # 1b298 <fwp_gc+0x1010>
    9084:	31 d2                	xor    %edx,%edx
    9086:	eb 2d                	jmp    90b5 <fwp_gc_collect+0x3f5>
    9088:	48 8b 15 09 22 01 00 	mov    0x12209(%rip),%rdx        # 1b298 <fwp_gc+0x1010>
    908f:	48 89 d6             	mov    %rdx,%rsi
    9092:	48 d1 ee             	shr    $1,%rsi
    9095:	48 01 d6             	add    %rdx,%rsi
    9098:	48 81 fe 01 00 00 01 	cmp    $0x1000001,%rsi
    909f:	ba 00 00 00 01       	mov    $0x1000000,%edx
    90a4:	48 0f 43 d6          	cmovae %rsi,%rdx
    90a8:	31 f6                	xor    %esi,%esi
    90aa:	48 39 d0             	cmp    %rdx,%rax
    90ad:	0f 97 c2             	seta   %dl
    90b0:	40 88 d6             	mov    %dl,%sil
    90b3:	89 f2                	mov    %esi,%edx
    90b5:	f6 c1 07             	test   $0x7,%cl
    90b8:	b9 01 00 00 00       	mov    $0x1,%ecx
    90bd:	0f 45 ca             	cmovne %edx,%ecx
    90c0:	48 83 3d e0 21 01 00 	cmpq   $0x0,0x121e0(%rip)        # 1b2a8 <fwp_gc+0x1020>
    90c7:	00 
    90c8:	0f 44 ca             	cmove  %edx,%ecx
    90cb:	89 0d bf 21 01 00    	mov    %ecx,0x121bf(%rip)        # 1b290 <fwp_gc+0x1008>
    90d1:	83 3d b0 21 01 00 00 	cmpl   $0x0,0x121b0(%rip)        # 1b288 <fwp_gc+0x1000>
    90d8:	0f 94 c1             	sete   %cl
    90db:	48 d3 e0             	shl    %cl,%rax
    90de:	f2 48 0f 2c 0d a1 23 	cvttsd2si 0x123a1(%rip),%rcx        # 1b488 <fwp_gc+0x1200>
    90e5:	01 00 
    90e7:	48 01 c1             	add    %rax,%rcx
    90ea:	48 81 f9 01 00 80 00 	cmp    $0x800001,%rcx
    90f1:	b8 00 00 80 00       	mov    $0x800000,%eax
    90f6:	48 0f 4d c1          	cmovge %rcx,%rax
    90fa:	48 89 05 97 23 01 00 	mov    %rax,0x12397(%rip)        # 1b498 <fwp_gc+0x1210>
    9101:	48 89 05 80 11 01 00 	mov    %rax,0x11180(%rip)        # 1a288 <fwp_gc>
    9108:	48 8d b5 30 ff ff ff 	lea    -0xd0(%rbp),%rsi
    910f:	bf 01 00 00 00       	mov    $0x1,%edi
    9114:	e8 17 a0 ff ff       	call   3130 <clock_gettime@plt>
    9119:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    9120:	48 8b 8d 38 ff ff ff 	mov    -0xc8(%rbp),%rcx
    9127:	48 2b 85 20 ff ff ff 	sub    -0xe0(%rbp),%rax
    912e:	f2 48 0f 2a c8       	cvtsi2sd %rax,%xmm1
    9133:	f2 0f 59 0d 75 c0 00 	mulsd  0xc075(%rip),%xmm1        # 151b0 <_IO_stdin_used+0x1b0>
    913a:	00 
    913b:	48 2b 8d 28 ff ff ff 	sub    -0xd8(%rbp),%rcx
    9142:	0f 57 c0             	xorps  %xmm0,%xmm0
    9145:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    914a:	f2 0f 5e 05 66 c0 00 	divsd  0xc066(%rip),%xmm0        # 151b8 <_IO_stdin_used+0x1b8>
    9151:	00 
    9152:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
    9156:	f2 0f 10 0d 1a 23 01 	movsd  0x1231a(%rip),%xmm1        # 1b478 <fwp_gc+0x11f0>
    915d:	00 
    915e:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
    9162:	f2 0f 11 0d 0e 23 01 	movsd  %xmm1,0x1230e(%rip)        # 1b478 <fwp_gc+0x11f0>
    9169:	00 
    916a:	66 0f 2e 05 0e 23 01 	ucomisd 0x1230e(%rip),%xmm0        # 1b480 <fwp_gc+0x11f8>
    9171:	00 
    9172:	76 08                	jbe    917c <fwp_gc_collect+0x4bc>
    9174:	f2 0f 11 05 04 23 01 	movsd  %xmm0,0x12304(%rip)        # 1b480 <fwp_gc+0x11f8>
    917b:	00 
    917c:	c7 05 fa 20 01 00 00 	movl   $0x0,0x120fa(%rip)        # 1b280 <fwp_gc+0xff8>
    9183:	00 00 00 
    9186:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    918d:	5b                   	pop    %rbx
    918e:	41 5c                	pop    %r12
    9190:	41 5d                	pop    %r13
    9192:	41 5e                	pop    %r14
    9194:	41 5f                	pop    %r15
    9196:	5d                   	pop    %rbp
    9197:	c3                   	ret
    9198:	49 83 e6 fe          	and    $0xfffffffffffffffe,%r14
    919c:	4c 89 75 88          	mov    %r14,-0x78(%rbp)
    91a0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    91a4:	48 8d 98 00 02 00 00 	lea    0x200(%rax),%rbx
    91ab:	4c 8d a1 50 12 00 00 	lea    0x1250(%rcx),%r12
    91b2:	31 c0                	xor    %eax,%eax
    91b4:	89 c1                	mov    %eax,%ecx
    91b6:	41 bd 00 02 00 00    	mov    $0x200,%r13d
    91bc:	4c 8b 75 b8          	mov    -0x48(%rbp),%r14
    91c0:	49 89 cf             	mov    %rcx,%r15
    91c3:	48 8d bb 00 fe ff ff 	lea    -0x200(%rbx),%rdi
    91ca:	49 8d b4 24 d8 ed ff 	lea    -0x1228(%r12),%rsi
    91d1:	ff 
    91d2:	4c 89 ea             	mov    %r13,%rdx
    91d5:	e8 56 a1 ff ff       	call   3330 <memcpy@plt>
    91da:	41 0f b6 84 24 b3 ed 	movzbl -0x124d(%r12),%eax
    91e1:	ff ff 
    91e3:	43 88 04 3e          	mov    %al,(%r14,%r15,1)
    91e7:	48 89 df             	mov    %rbx,%rdi
    91ea:	4c 89 e6             	mov    %r12,%rsi
    91ed:	4c 89 ea             	mov    %r13,%rdx
    91f0:	e8 3b a1 ff ff       	call   3330 <memcpy@plt>
    91f5:	41 0f b6 44 24 db    	movzbl -0x25(%r12),%eax
    91fb:	43 88 44 3e 01       	mov    %al,0x1(%r14,%r15,1)
    9200:	49 83 c7 02          	add    $0x2,%r15
    9204:	48 81 c3 00 04 00 00 	add    $0x400,%rbx
    920b:	49 81 c4 50 24 00 00 	add    $0x2450,%r12
    9212:	4c 89 f8             	mov    %r15,%rax
    9215:	4c 89 f9             	mov    %r15,%rcx
    9218:	4c 39 7d 88          	cmp    %r15,-0x78(%rbp)
    921c:	75 a2                	jne    91c0 <fwp_gc_collect+0x500>
    921e:	48 89 c3             	mov    %rax,%rbx
    9221:	4c 8b bd 48 ff ff ff 	mov    -0xb8(%rbp),%r15
    9228:	44 89 f8             	mov    %r15d,%eax
    922b:	41 f6 c7 01          	test   $0x1,%r15b
    922f:	44 0f b6 65 d7       	movzbl -0x29(%rbp),%r12d
    9234:	48 8b 95 70 ff ff ff 	mov    -0x90(%rbp),%rdx
    923b:	74 37                	je     9274 <fwp_gc_collect+0x5b4>
    923d:	48 89 df             	mov    %rbx,%rdi
    9240:	48 c1 e7 09          	shl    $0x9,%rdi
    9244:	48 03 7d c8          	add    -0x38(%rbp),%rdi
    9248:	4c 69 f3 28 12 00 00 	imul   $0x1228,%rbx,%r14
    924f:	4a 8d 34 32          	lea    (%rdx,%r14,1),%rsi
    9253:	48 83 c6 28          	add    $0x28,%rsi
    9257:	49 89 d5             	mov    %rdx,%r13
    925a:	ba 00 02 00 00       	mov    $0x200,%edx
    925f:	e8 cc a0 ff ff       	call   3330 <memcpy@plt>
    9264:	4c 89 ea             	mov    %r13,%rdx
    9267:	43 0f b6 44 35 03    	movzbl 0x3(%r13,%r14,1),%eax
    926d:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
    9271:	88 04 19             	mov    %al,(%rcx,%rbx,1)
    9274:	45 31 ed             	xor    %r13d,%r13d
    9277:	45 89 ee             	mov    %r13d,%r14d
    927a:	4c 89 f3             	mov    %r14,%rbx
    927d:	4c 89 f9             	mov    %r15,%rcx
    9280:	48 89 d0             	mov    %rdx,%rax
    9283:	eb 29                	jmp    92ae <fwp_gc_collect+0x5ee>
    9285:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    928c:	00 00 00 00 
    9290:	42 c6 44 30 03 00    	movb   $0x0,0x3(%rax,%r14,1)
    9296:	48 89 ca             	mov    %rcx,%rdx
    9299:	48 89 de             	mov    %rbx,%rsi
    929c:	48 ff c6             	inc    %rsi
    929f:	49 81 c6 28 12 00 00 	add    $0x1228,%r14
    92a6:	48 89 f3             	mov    %rsi,%rbx
    92a9:	48 39 ce             	cmp    %rcx,%rsi
    92ac:	73 3f                	jae    92ed <fwp_gc_collect+0x62d>
    92ae:	42 0f b6 14 30       	movzbl (%rax,%r14,1),%edx
    92b3:	83 fa 02             	cmp    $0x2,%edx
    92b6:	74 d8                	je     9290 <fwp_gc_collect+0x5d0>
    92b8:	83 fa 01             	cmp    $0x1,%edx
    92bb:	75 d9                	jne    9296 <fwp_gc_collect+0x5d6>
    92bd:	4a 8d 3c 30          	lea    (%rax,%r14,1),%rdi
    92c1:	48 83 c7 28          	add    $0x28,%rdi
    92c5:	42 8b 44 30 0c       	mov    0xc(%rax,%r14,1),%eax
    92ca:	83 c0 3f             	add    $0x3f,%eax
    92cd:	c1 e8 03             	shr    $0x3,%eax
    92d0:	83 e0 f8             	and    $0xfffffff8,%eax
    92d3:	89 c2                	mov    %eax,%edx
    92d5:	44 89 ee             	mov    %r13d,%esi
    92d8:	e8 33 9f ff ff       	call   3210 <memset@plt>
    92dd:	48 8b 05 1c 20 01 00 	mov    0x1201c(%rip),%rax        # 1b300 <fwp_gc+0x1078>
    92e4:	48 8b 0d f5 1f 01 00 	mov    0x11ff5(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    92eb:	eb a9                	jmp    9296 <fwp_gc_collect+0x5d6>
    92ed:	e8 0e 03 00 00       	call   9600 <fwp_gc_mark_all>
    92f2:	48 8b 05 07 20 01 00 	mov    0x12007(%rip),%rax        # 1b300 <fwp_gc+0x1078>
    92f9:	48 8d 78 28          	lea    0x28(%rax),%rdi
    92fd:	31 d2                	xor    %edx,%edx
    92ff:	89 d6                	mov    %edx,%esi
    9301:	4c 8b 45 a0          	mov    -0x60(%rbp),%r8
    9305:	4c 8b 6d b8          	mov    -0x48(%rbp),%r13
    9309:	eb 35                	jmp    9340 <fwp_gc_collect+0x680>
    930b:	4d 85 db             	test   %r11,%r11
    930e:	0f 85 c8 00 00 00    	jne    93dc <fwp_gc_collect+0x71c>
    9314:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    931b:	00 00 00 00 00 
    9320:	48 89 f1             	mov    %rsi,%rcx
    9323:	48 ff c1             	inc    %rcx
    9326:	49 81 c0 00 02 00 00 	add    $0x200,%r8
    932d:	48 81 c7 28 12 00 00 	add    $0x1228,%rdi
    9334:	48 89 ce             	mov    %rcx,%rsi
    9337:	4c 39 f9             	cmp    %r15,%rcx
    933a:	0f 84 eb fc ff ff    	je     902b <fwp_gc_collect+0x36b>
    9340:	48 69 ce 28 12 00 00 	imul   $0x1228,%rsi,%rcx
    9347:	44 0f b6 0c 08       	movzbl (%rax,%rcx,1),%r9d
    934c:	41 83 f9 02          	cmp    $0x2,%r9d
    9350:	74 5e                	je     93b0 <fwp_gc_collect+0x6f0>
    9352:	41 83 f9 01          	cmp    $0x1,%r9d
    9356:	75 c8                	jne    9320 <fwp_gc_collect+0x660>
    9358:	44 8b 4c 08 0c       	mov    0xc(%rax,%rcx,1),%r9d
    935d:	41 83 c1 3f          	add    $0x3f,%r9d
    9361:	41 83 f9 40          	cmp    $0x40,%r9d
    9365:	72 b9                	jb     9320 <fwp_gc_collect+0x660>
    9367:	41 c1 e9 06          	shr    $0x6,%r9d
    936b:	49 c7 c6 c0 ff ff ff 	mov    $0xffffffffffffffc0,%r14
    9372:	89 d3                	mov    %edx,%ebx
    9374:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    937b:	00 00 00 00 00 
    9380:	4d 89 f2             	mov    %r14,%r10
    9383:	4d 8b 1c d8          	mov    (%r8,%rbx,8),%r11
    9387:	49 f7 d3             	not    %r11
    938a:	4c 23 1c df          	and    (%rdi,%rbx,8),%r11
    938e:	48 ff c3             	inc    %rbx
    9391:	49 83 c2 40          	add    $0x40,%r10
    9395:	4c 39 cb             	cmp    %r9,%rbx
    9398:	0f 83 6d ff ff ff    	jae    930b <fwp_gc_collect+0x64b>
    939e:	4d 89 d6             	mov    %r10,%r14
    93a1:	4d 85 db             	test   %r11,%r11
    93a4:	74 da                	je     9380 <fwp_gc_collect+0x6c0>
    93a6:	e9 60 ff ff ff       	jmp    930b <fwp_gc_collect+0x64b>
    93ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    93b0:	80 7c 08 03 00       	cmpb   $0x0,0x3(%rax,%rcx,1)
    93b5:	0f 84 65 ff ff ff    	je     9320 <fwp_gc_collect+0x660>
    93bb:	41 80 7c 35 00 00    	cmpb   $0x0,0x0(%r13,%rsi,1)
    93c1:	0f 85 59 ff ff ff    	jne    9320 <fwp_gc_collect+0x660>
    93c7:	49 89 f7             	mov    %rsi,%r15
    93ca:	49 c1 e7 10          	shl    $0x10,%r15
    93ce:	4c 03 3d e3 1e 01 00 	add    0x11ee3(%rip),%r15        # 1b2b8 <fwp_gc+0x1030>
    93d5:	48 8b 5c 08 18       	mov    0x18(%rax,%rcx,1),%rbx
    93da:	eb 20                	jmp    93fc <fwp_gc_collect+0x73c>
    93dc:	f3 4d 0f bc fb       	tzcnt  %r11,%r15
    93e1:	48 c1 e6 10          	shl    $0x10,%rsi
    93e5:	48 03 35 cc 1e 01 00 	add    0x11ecc(%rip),%rsi        # 1b2b8 <fwp_gc+0x1030>
    93ec:	4d 01 d7             	add    %r10,%r15
    93ef:	8b 7c 08 08          	mov    0x8(%rax,%rcx,1),%edi
    93f3:	89 fb                	mov    %edi,%ebx
    93f5:	4c 0f af fb          	imul   %rbx,%r15
    93f9:	49 01 f7             	add    %rsi,%r15
    93fc:	48 8b 15 d5 0b 01 00 	mov    0x10bd5(%rip),%rdx        # 19fd8 <stderr@GLIBC_2.2.5>
    9403:	48 8b 3a             	mov    (%rdx),%rdi
    9406:	0f b6 4c 08 01       	movzbl 0x1(%rax,%rcx,1),%ecx
    940b:	48 8d 35 f3 c6 00 00 	lea    0xc6f3(%rip),%rsi        # 15b05 <exec_in_fp0+0x295>
    9412:	45 31 f6             	xor    %r14d,%r14d
    9415:	44 89 f0             	mov    %r14d,%eax
    9418:	4c 89 fa             	mov    %r15,%rdx
    941b:	49 89 d8             	mov    %rbx,%r8
    941e:	44 88 75 d6          	mov    %r14b,-0x2a(%rbp)
    9422:	e8 c9 9e ff ff       	call   32f0 <fprintf@plt>
    9427:	48 89 de             	mov    %rbx,%rsi
    942a:	4c 01 fe             	add    %r15,%rsi
    942d:	44 89 f0             	mov    %r14d,%eax
    9430:	48 89 c1             	mov    %rax,%rcx
    9433:	48 89 b5 50 ff ff ff 	mov    %rsi,-0xb0(%rbp)
    943a:	eb 24                	jmp    9460 <fwp_gc_collect+0x7a0>
    943c:	0f 1f 40 00          	nopl   0x0(%rax)
    9440:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
    9444:	48 ff c2             	inc    %rdx
    9447:	48 89 f8             	mov    %rdi,%rax
    944a:	48 05 00 00 01 00    	add    $0x10000,%rax
    9450:	48 89 d1             	mov    %rdx,%rcx
    9453:	48 3b 95 40 ff ff ff 	cmp    -0xc0(%rbp),%rdx
    945a:	0f 84 68 01 00 00    	je     95c8 <fwp_gc_collect+0x908>
    9460:	48 89 c7             	mov    %rax,%rdi
    9463:	48 8b 05 96 1e 01 00 	mov    0x11e96(%rip),%rax        # 1b300 <fwp_gc+0x1078>
    946a:	48 89 4d a8          	mov    %rcx,-0x58(%rbp)
    946e:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    9475:	80 3c 08 01          	cmpb   $0x1,(%rax,%rcx,1)
    9479:	75 c5                	jne    9440 <fwp_gc_collect+0x780>
    947b:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    9480:	74 be                	je     9440 <fwp_gc_collect+0x780>
    9482:	8b 54 08 0c          	mov    0xc(%rax,%rcx,1),%edx
    9486:	85 d2                	test   %edx,%edx
    9488:	74 b6                	je     9440 <fwp_gc_collect+0x780>
    948a:	4c 8d 0c 08          	lea    (%rax,%rcx,1),%r9
    948e:	49 ff c1             	inc    %r9
    9491:	48 8b 4d a8          	mov    -0x58(%rbp),%rcx
    9495:	48 89 c8             	mov    %rcx,%rax
    9498:	48 c1 e0 10          	shl    $0x10,%rax
    949c:	48 89 85 60 ff ff ff 	mov    %rax,-0xa0(%rbp)
    94a3:	31 c0                	xor    %eax,%eax
    94a5:	41 89 c5             	mov    %eax,%r13d
    94a8:	48 89 c8             	mov    %rcx,%rax
    94ab:	48 c1 e0 09          	shl    $0x9,%rax
    94af:	49 89 c0             	mov    %rax,%r8
    94b2:	4c 03 45 c8          	add    -0x38(%rbp),%r8
    94b6:	89 d0                	mov    %edx,%eax
    94b8:	48 89 bd 58 ff ff ff 	mov    %rdi,-0xa8(%rbp)
    94bf:	4c 89 85 68 ff ff ff 	mov    %r8,-0x98(%rbp)
    94c6:	eb 35                	jmp    94fd <fwp_gc_collect+0x83d>
    94c8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    94cf:	00 
    94d0:	41 8b 41 0b          	mov    0xb(%r9),%eax
    94d4:	48 8b bd 58 ff ff ff 	mov    -0xa8(%rbp),%rdi
    94db:	4c 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%r8
    94e2:	4c 8b ad 78 ff ff ff 	mov    -0x88(%rbp),%r13
    94e9:	4c 89 e9             	mov    %r13,%rcx
    94ec:	48 ff c1             	inc    %rcx
    94ef:	89 c2                	mov    %eax,%edx
    94f1:	49 89 cd             	mov    %rcx,%r13
    94f4:	48 39 d1             	cmp    %rdx,%rcx
    94f7:	0f 83 43 ff ff ff    	jae    9440 <fwp_gc_collect+0x780>
    94fd:	4c 89 e9             	mov    %r13,%rcx
    9500:	48 c1 e9 06          	shr    $0x6,%rcx
    9504:	49 8b 0c c8          	mov    (%r8,%rcx,8),%rcx
    9508:	4c 0f a3 e9          	bt     %r13,%rcx
    950c:	73 db                	jae    94e9 <fwp_gc_collect+0x829>
    950e:	41 8b 49 07          	mov    0x7(%r9),%ecx
    9512:	41 89 cc             	mov    %ecx,%r12d
    9515:	49 83 fc 08          	cmp    $0x8,%r12
    9519:	72 ce                	jb     94e9 <fwp_gc_collect+0x829>
    951b:	4c 8b 35 96 1d 01 00 	mov    0x11d96(%rip),%r14        # 1b2b8 <fwp_gc+0x1030>
    9522:	48 8b 8d 60 ff ff ff 	mov    -0xa0(%rbp),%rcx
    9529:	4c 01 f1             	add    %r14,%rcx
    952c:	48 89 4d 80          	mov    %rcx,-0x80(%rbp)
    9530:	45 89 e0             	mov    %r12d,%r8d
    9533:	4c 89 ad 78 ff ff ff 	mov    %r13,-0x88(%rbp)
    953a:	4d 0f af e5          	imul   %r13,%r12
    953e:	49 01 fe             	add    %rdi,%r14
    9541:	4d 01 e6             	add    %r12,%r14
    9544:	31 c0                	xor    %eax,%eax
    9546:	89 c3                	mov    %eax,%ebx
    9548:	eb 1e                	jmp    9568 <fwp_gc_collect+0x8a8>
    954a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9550:	44 89 c0             	mov    %r8d,%eax
    9553:	48 89 d9             	mov    %rbx,%rcx
    9556:	48 ff c1             	inc    %rcx
    9559:	c1 e8 03             	shr    $0x3,%eax
    955c:	48 89 cb             	mov    %rcx,%rbx
    955f:	48 39 c1             	cmp    %rax,%rcx
    9562:	0f 83 68 ff ff ff    	jae    94d0 <fwp_gc_collect+0x810>
    9568:	49 8b 04 de          	mov    (%r14,%rbx,8),%rax
    956c:	4c 39 f8             	cmp    %r15,%rax
    956f:	72 df                	jb     9550 <fwp_gc_collect+0x890>
    9571:	48 39 f0             	cmp    %rsi,%rax
    9574:	73 da                	jae    9550 <fwp_gc_collect+0x890>
    9576:	48 8b 05 5b 0a 01 00 	mov    0x10a5b(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    957d:	48 8b 38             	mov    (%rax),%rdi
    9580:	41 0f b6 09          	movzbl (%r9),%ecx
    9584:	48 8b 45 80          	mov    -0x80(%rbp),%rax
    9588:	4a 8d 14 20          	lea    (%rax,%r12,1),%rdx
    958c:	66 42 0f 10 04 20    	movupd (%rax,%r12,1),%xmm0
    9592:	4a 8b 44 20 10       	mov    0x10(%rax,%r12,1),%rax
    9597:	48 89 e6             	mov    %rsp,%rsi
    959a:	48 89 46 10          	mov    %rax,0x10(%rsi)
    959e:	66 0f 11 06          	movupd %xmm0,(%rsi)
    95a2:	48 8d 35 b6 c5 00 00 	lea    0xc5b6(%rip),%rsi        # 15b5f <exec_in_fp0+0x2ef>
    95a9:	4d 89 cd             	mov    %r9,%r13
    95ac:	49 89 d9             	mov    %rbx,%r9
    95af:	0f b6 45 d6          	movzbl -0x2a(%rbp),%eax
    95b3:	e8 38 9d ff ff       	call   32f0 <fprintf@plt>
    95b8:	4d 89 e9             	mov    %r13,%r9
    95bb:	48 8b b5 50 ff ff ff 	mov    -0xb0(%rbp),%rsi
    95c2:	45 8b 45 07          	mov    0x7(%r13),%r8d
    95c6:	eb 88                	jmp    9550 <fwp_gc_collect+0x890>
    95c8:	e8 a3 9a ff ff       	call   3070 <abort@plt>
    95cd:	48 8b 05 04 0a 01 00 	mov    0x10a04(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    95d4:	48 8b 08             	mov    (%rax),%rcx
    95d7:	48 8d 3d 13 c5 00 00 	lea    0xc513(%rip),%rdi        # 15af1 <exec_in_fp0+0x281>
    95de:	be 13 00 00 00       	mov    $0x13,%esi
    95e3:	ba 01 00 00 00       	mov    $0x1,%edx
    95e8:	e8 93 9e ff ff       	call   3480 <fwrite@plt>
    95ed:	bf 66 00 00 00       	mov    $0x66,%edi
    95f2:	e8 69 9e ff ff       	call   3460 <exit@plt>
    95f7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    95fe:	00 00 

0000000000009600 <fwp_gc_mark_all>:
    9600:	41 57                	push   %r15
    9602:	41 56                	push   %r14
    9604:	41 55                	push   %r13
    9606:	41 54                	push   %r12
    9608:	53                   	push   %rbx
    9609:	e8 f2 08 00 00       	call   9f00 <fwp_gc_sp>
    960e:	48 85 c0             	test   %rax,%rax
    9611:	74 56                	je     9669 <fwp_gc_mark_all+0x69>
    9613:	48 8b 35 f6 1c 01 00 	mov    0x11cf6(%rip),%rsi        # 1b310 <fwp_gc+0x1088>
    961a:	48 89 f1             	mov    %rsi,%rcx
    961d:	48 29 c1             	sub    %rax,%rcx
    9620:	76 47                	jbe    9669 <fwp_gc_mark_all+0x69>
    9622:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    9627:	f2 0f 58 05 59 1e 01 	addsd  0x11e59(%rip),%xmm0        # 1b488 <fwp_gc+0x1200>
    962e:	00 
    962f:	f2 0f 11 05 51 1e 01 	movsd  %xmm0,0x11e51(%rip)        # 1b488 <fwp_gc+0x1200>
    9636:	00 
    9637:	48 89 c7             	mov    %rax,%rdi
    963a:	ba 01 00 00 00       	mov    $0x1,%edx
    963f:	eb 23                	jmp    9664 <fwp_gc_mark_all+0x64>
    9641:	48 8b 0d d8 1d 01 00 	mov    0x11dd8(%rip),%rcx        # 1b420 <fwp_gc+0x1198>
    9648:	48 ff c8             	dec    %rax
    964b:	48 89 05 d6 1d 01 00 	mov    %rax,0x11dd6(%rip)        # 1b428 <fwp_gc+0x11a0>
    9652:	48 c1 e0 04          	shl    $0x4,%rax
    9656:	48 8b 3c 01          	mov    (%rcx,%rax,1),%rdi
    965a:	48 8b 74 01 08       	mov    0x8(%rcx,%rax,1),%rsi
    965f:	48 01 fe             	add    %rdi,%rsi
    9662:	31 d2                	xor    %edx,%edx
    9664:	e8 a7 08 00 00       	call   9f10 <fwp_gc_scan>
    9669:	48 8b 05 b8 1d 01 00 	mov    0x11db8(%rip),%rax        # 1b428 <fwp_gc+0x11a0>
    9670:	48 85 c0             	test   %rax,%rax
    9673:	75 cc                	jne    9641 <fwp_gc_mark_all+0x41>
    9675:	83 3d 9c 1d 01 00 00 	cmpl   $0x0,0x11d9c(%rip)        # 1b418 <fwp_gc+0x1190>
    967c:	0f 8e b2 00 00 00    	jle    9734 <fwp_gc_mark_all+0x134>
    9682:	4c 8d 25 97 1c 01 00 	lea    0x11c97(%rip),%r12        # 1b320 <fwp_gc+0x1098>
    9689:	45 31 ed             	xor    %r13d,%r13d
    968c:	48 8d 1d f5 0b 01 00 	lea    0x10bf5(%rip),%rbx        # 1a288 <fwp_gc>
    9693:	4c 8d 35 0e 26 01 00 	lea    0x1260e(%rip),%r14        # 1bca8 <fc13>
    969a:	eb 21                	jmp    96bd <fwp_gc_mark_all+0xbd>
    969c:	0f 1f 40 00          	nopl   0x0(%rax)
    96a0:	4c 89 fe             	mov    %r15,%rsi
    96a3:	31 d2                	xor    %edx,%edx
    96a5:	e8 66 08 00 00       	call   9f10 <fwp_gc_scan>
    96aa:	49 ff c5             	inc    %r13
    96ad:	48 63 05 64 1d 01 00 	movslq 0x11d64(%rip),%rax        # 1b418 <fwp_gc+0x1190>
    96b4:	49 83 c4 10          	add    $0x10,%r12
    96b8:	49 39 c5             	cmp    %rax,%r13
    96bb:	7d 6b                	jge    9728 <fwp_gc_mark_all+0x128>
    96bd:	49 8b 7c 24 f8       	mov    -0x8(%r12),%rdi
    96c2:	49 8b 04 24          	mov    (%r12),%rax
    96c6:	4c 8d 3c 07          	lea    (%rdi,%rax,1),%r15
    96ca:	0f 57 c0             	xorps  %xmm0,%xmm0
    96cd:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    96d2:	f2 0f 58 05 ae 1d 01 	addsd  0x11dae(%rip),%xmm0        # 1b488 <fwp_gc+0x1200>
    96d9:	00 
    96da:	f2 0f 11 05 a6 1d 01 	movsd  %xmm0,0x11da6(%rip)        # 1b488 <fwp_gc+0x1200>
    96e1:	00 
    96e2:	48 39 df             	cmp    %rbx,%rdi
    96e5:	77 b9                	ja     96a0 <fwp_gc_mark_all+0xa0>
    96e7:	4d 39 f7             	cmp    %r14,%r15
    96ea:	72 b4                	jb     96a0 <fwp_gc_mark_all+0xa0>
    96ec:	48 89 de             	mov    %rbx,%rsi
    96ef:	31 d2                	xor    %edx,%edx
    96f1:	e8 1a 08 00 00       	call   9f10 <fwp_gc_scan>
    96f6:	4c 89 f7             	mov    %r14,%rdi
    96f9:	eb a5                	jmp    96a0 <fwp_gc_mark_all+0xa0>
    96fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    9700:	48 8b 0d 19 1d 01 00 	mov    0x11d19(%rip),%rcx        # 1b420 <fwp_gc+0x1198>
    9707:	48 ff c8             	dec    %rax
    970a:	48 89 05 17 1d 01 00 	mov    %rax,0x11d17(%rip)        # 1b428 <fwp_gc+0x11a0>
    9711:	48 c1 e0 04          	shl    $0x4,%rax
    9715:	48 8b 3c 01          	mov    (%rcx,%rax,1),%rdi
    9719:	48 8b 74 01 08       	mov    0x8(%rcx,%rax,1),%rsi
    971e:	48 01 fe             	add    %rdi,%rsi
    9721:	31 d2                	xor    %edx,%edx
    9723:	e8 e8 07 00 00       	call   9f10 <fwp_gc_scan>
    9728:	48 8b 05 f9 1c 01 00 	mov    0x11cf9(%rip),%rax        # 1b428 <fwp_gc+0x11a0>
    972f:	48 85 c0             	test   %rax,%rax
    9732:	75 cc                	jne    9700 <fwp_gc_mark_all+0x100>
    9734:	5b                   	pop    %rbx
    9735:	41 5c                	pop    %r12
    9737:	41 5d                	pop    %r13
    9739:	41 5e                	pop    %r14
    973b:	41 5f                	pop    %r15
    973d:	c3                   	ret
    973e:	66 90                	xchg   %ax,%ax

0000000000009740 <fwp_gc_finalize>:
    9740:	48 8b 0d f9 1c 01 00 	mov    0x11cf9(%rip),%rcx        # 1b440 <fwp_gc+0x11b8>
    9747:	48 85 c9             	test   %rcx,%rcx
    974a:	0f 84 10 01 00 00    	je     9860 <fwp_gc_finalize+0x120>
    9750:	41 56                	push   %r14
    9752:	53                   	push   %rbx
    9753:	50                   	push   %rax
    9754:	48 8b 35 dd 1c 01 00 	mov    0x11cdd(%rip),%rsi        # 1b438 <fwp_gc+0x11b0>
    975b:	4c 8b 05 56 1b 01 00 	mov    0x11b56(%rip),%r8        # 1b2b8 <fwp_gc+0x1030>
    9762:	4c 8b 0d 77 1b 01 00 	mov    0x11b77(%rip),%r9        # 1b2e0 <fwp_gc+0x1058>
    9769:	31 db                	xor    %ebx,%ebx
    976b:	eb 0f                	jmp    977c <fwp_gc_finalize+0x3c>
    976d:	0f 1f 00             	nopl   (%rax)
    9770:	48 ff c3             	inc    %rbx
    9773:	48 39 cb             	cmp    %rcx,%rbx
    9776:	0f 83 dd 00 00 00    	jae    9859 <fwp_gc_finalize+0x119>
    977c:	49 89 da             	mov    %rbx,%r10
    977f:	49 c1 e2 04          	shl    $0x4,%r10
    9783:	4a 8b 3c 16          	mov    (%rsi,%r10,1),%rdi
    9787:	48 89 f8             	mov    %rdi,%rax
    978a:	4c 29 c0             	sub    %r8,%rax
    978d:	4c 89 ca             	mov    %r9,%rdx
    9790:	48 c1 e2 10          	shl    $0x10,%rdx
    9794:	48 39 d0             	cmp    %rdx,%rax
    9797:	73 d7                	jae    9770 <fwp_gc_finalize+0x30>
    9799:	4c 8b 1d 60 1b 01 00 	mov    0x11b60(%rip),%r11        # 1b300 <fwp_gc+0x1078>
    97a0:	4d 85 db             	test   %r11,%r11
    97a3:	74 cb                	je     9770 <fwp_gc_finalize+0x30>
    97a5:	48 c1 e8 10          	shr    $0x10,%rax
    97a9:	48 69 d0 28 12 00 00 	imul   $0x1228,%rax,%rdx
    97b0:	41 0f b6 04 13       	movzbl (%r11,%rdx,1),%eax
    97b5:	3c 03                	cmp    $0x3,%al
    97b7:	75 16                	jne    97cf <fwp_gc_finalize+0x8f>
    97b9:	41 8b 44 13 10       	mov    0x10(%r11,%rdx,1),%eax
    97be:	48 69 d0 28 12 00 00 	imul   $0x1228,%rax,%rdx
    97c5:	41 0f b6 04 13       	movzbl (%r11,%rdx,1),%eax
    97ca:	49 01 d3             	add    %rdx,%r11
    97cd:	eb 03                	jmp    97d2 <fwp_gc_finalize+0x92>
    97cf:	49 01 d3             	add    %rdx,%r11
    97d2:	4e 8b 74 16 08       	mov    0x8(%rsi,%r10,1),%r14
    97d7:	3c 01                	cmp    $0x1,%al
    97d9:	74 13                	je     97ee <fwp_gc_finalize+0xae>
    97db:	0f b6 c0             	movzbl %al,%eax
    97de:	83 f8 02             	cmp    $0x2,%eax
    97e1:	75 35                	jne    9818 <fwp_gc_finalize+0xd8>
    97e3:	41 0f b6 53 03       	movzbl 0x3(%r11),%edx
    97e8:	85 d2                	test   %edx,%edx
    97ea:	75 84                	jne    9770 <fwp_gc_finalize+0x30>
    97ec:	eb 2a                	jmp    9818 <fwp_gc_finalize+0xd8>
    97ee:	0f b7 c7             	movzwl %di,%eax
    97f1:	31 d2                	xor    %edx,%edx
    97f3:	41 f7 73 08          	divl   0x8(%r11)
    97f7:	89 c2                	mov    %eax,%edx
    97f9:	c1 ea 03             	shr    $0x3,%edx
    97fc:	81 e2 f8 1f 00 00    	and    $0x1ff8,%edx
    9802:	4d 8b 5c 13 28       	mov    0x28(%r11,%rdx,1),%r11
    9807:	31 d2                	xor    %edx,%edx
    9809:	49 0f a3 c3          	bt     %rax,%r11
    980d:	0f 92 c2             	setb   %dl
    9810:	85 d2                	test   %edx,%edx
    9812:	0f 85 58 ff ff ff    	jne    9770 <fwp_gc_finalize+0x30>
    9818:	49 01 f2             	add    %rsi,%r10
    981b:	48 ff c9             	dec    %rcx
    981e:	48 89 0d 1b 1c 01 00 	mov    %rcx,0x11c1b(%rip)        # 1b440 <fwp_gc+0x11b8>
    9825:	48 c1 e1 04          	shl    $0x4,%rcx
    9829:	0f 10 04 0e          	movups (%rsi,%rcx,1),%xmm0
    982d:	41 0f 11 02          	movups %xmm0,(%r10)
    9831:	41 ff d6             	call   *%r14
    9834:	48 8b 35 fd 1b 01 00 	mov    0x11bfd(%rip),%rsi        # 1b438 <fwp_gc+0x11b0>
    983b:	4c 8b 05 76 1a 01 00 	mov    0x11a76(%rip),%r8        # 1b2b8 <fwp_gc+0x1030>
    9842:	4c 8b 0d 97 1a 01 00 	mov    0x11a97(%rip),%r9        # 1b2e0 <fwp_gc+0x1058>
    9849:	48 8b 0d f0 1b 01 00 	mov    0x11bf0(%rip),%rcx        # 1b440 <fwp_gc+0x11b8>
    9850:	48 39 cb             	cmp    %rcx,%rbx
    9853:	0f 82 23 ff ff ff    	jb     977c <fwp_gc_finalize+0x3c>
    9859:	48 83 c4 08          	add    $0x8,%rsp
    985d:	5b                   	pop    %rbx
    985e:	41 5e                	pop    %r14
    9860:	c3                   	ret
    9861:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9868:	0f 1f 84 00 00 00 00 
    986f:	00 

0000000000009870 <fwp_gc_sweep>:
    9870:	55                   	push   %rbp
    9871:	41 57                	push   %r15
    9873:	41 56                	push   %r14
    9875:	41 55                	push   %r13
    9877:	41 54                	push   %r12
    9879:	53                   	push   %rbx
    987a:	48 83 ec 28          	sub    $0x28,%rsp
    987e:	48 8d 3d 0b 0a 01 00 	lea    0x10a0b(%rip),%rdi        # 1a290 <fwp_gc+0x8>
    9885:	31 ed                	xor    %ebp,%ebp
    9887:	ba 40 0b 00 00       	mov    $0xb40,%edx
    988c:	31 f6                	xor    %esi,%esi
    988e:	e8 7d 99 ff ff       	call   3210 <memset@plt>
    9893:	48 83 3d 45 1a 01 00 	cmpq   $0x0,0x11a45(%rip)        # 1b2e0 <fwp_gc+0x1058>
    989a:	00 
    989b:	0f 84 0f 05 00 00    	je     9db0 <fwp_gc_sweep+0x540>
    98a1:	31 c0                	xor    %eax,%eax
    98a3:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    98a8:	49 b9 55 55 55 55 55 	movabs $0x5555555555555555,%r9
    98af:	55 55 55 
    98b2:	49 ba 33 33 33 33 33 	movabs $0x3333333333333333,%r10
    98b9:	33 33 33 
    98bc:	49 bb 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r11
    98c3:	0f 0f 0f 
    98c6:	49 bc 01 01 01 01 01 	movabs $0x101010101010101,%r12
    98cd:	01 01 01 
    98d0:	66 0f 6f 2d e8 b7 00 	movdqa 0xb7e8(%rip),%xmm5        # 150c0 <_IO_stdin_used+0xc0>
    98d7:	00 
    98d8:	66 0f 6f 35 f0 b7 00 	movdqa 0xb7f0(%rip),%xmm6        # 150d0 <_IO_stdin_used+0xd0>
    98df:	00 
    98e0:	66 0f 6f 3d f8 b7 00 	movdqa 0xb7f8(%rip),%xmm7        # 150e0 <_IO_stdin_used+0xe0>
    98e7:	00 
    98e8:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    98ed:	31 ed                	xor    %ebp,%ebp
    98ef:	45 31 ed             	xor    %r13d,%r13d
    98f2:	eb 22                	jmp    9916 <fwp_gc_sweep+0xa6>
    98f4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    98fb:	00 00 00 00 00 
    9900:	48 ff c5             	inc    %rbp
    9903:	49 ff c5             	inc    %r13
    9906:	48 8b 05 d3 19 01 00 	mov    0x119d3(%rip),%rax        # 1b2e0 <fwp_gc+0x1058>
    990d:	49 39 c5             	cmp    %rax,%r13
    9910:	0f 83 a3 04 00 00    	jae    9db9 <fwp_gc_sweep+0x549>
    9916:	48 8b 1d e3 19 01 00 	mov    0x119e3(%rip),%rbx        # 1b300 <fwp_gc+0x1078>
    991d:	4d 69 f5 28 12 00 00 	imul   $0x1228,%r13,%r14
    9924:	42 0f b6 04 33       	movzbl (%rbx,%r14,1),%eax
    9929:	85 c0                	test   %eax,%eax
    992b:	74 d3                	je     9900 <fwp_gc_sweep+0x90>
    992d:	83 f8 01             	cmp    $0x1,%eax
    9930:	74 2e                	je     9960 <fwp_gc_sweep+0xf0>
    9932:	83 f8 02             	cmp    $0x2,%eax
    9935:	75 cc                	jne    9903 <fwp_gc_sweep+0x93>
    9937:	46 8b 64 33 10       	mov    0x10(%rbx,%r14,1),%r12d
    993c:	42 80 7c 33 03 00    	cmpb   $0x0,0x3(%rbx,%r14,1)
    9942:	74 50                	je     9994 <fwp_gc_sweep+0x124>
    9944:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    9949:	4a 03 44 33 18       	add    0x18(%rbx,%r14,1),%rax
    994e:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    9953:	e9 fb 03 00 00       	jmp    9d53 <fwp_gc_sweep+0x4e3>
    9958:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    995f:	00 
    9960:	4a 8d 04 33          	lea    (%rbx,%r14,1),%rax
    9964:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    9969:	46 8b 7c 33 0c       	mov    0xc(%rbx,%r14,1),%r15d
    996e:	4d 85 ff             	test   %r15,%r15
    9971:	0f 84 b5 02 00 00    	je     9c2c <fwp_gc_sweep+0x3bc>
    9977:	49 8d 57 3f          	lea    0x3f(%r15),%rdx
    997b:	48 89 d0             	mov    %rdx,%rax
    997e:	48 c1 e8 06          	shr    $0x6,%rax
    9982:	41 81 ff c1 00 00 00 	cmp    $0xc1,%r15d
    9989:	73 48                	jae    99d3 <fwp_gc_sweep+0x163>
    998b:	31 d2                	xor    %edx,%edx
    998d:	31 c9                	xor    %ecx,%ecx
    998f:	e9 1b 01 00 00       	jmp    9aaf <fwp_gc_sweep+0x23f>
    9994:	4e 8d 3c 33          	lea    (%rbx,%r14,1),%r15
    9998:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    999f:	42 80 bc 33 28 02 00 	cmpb   $0xff,0x228(%rbx,%r14,1)
    99a6:	00 ff 
    99a8:	0f 84 d8 03 00 00    	je     9d86 <fwp_gc_sweep+0x516>
    99ae:	41 c6 07 00          	movb   $0x0,(%r15)
    99b2:	4d 85 e4             	test   %r12,%r12
    99b5:	0f 84 95 03 00 00    	je     9d50 <fwp_gc_sweep+0x4e0>
    99bb:	48 8b 05 3e 19 01 00 	mov    0x1193e(%rip),%rax        # 1b300 <fwp_gc+0x1078>
    99c2:	41 83 fc 04          	cmp    $0x4,%r12d
    99c6:	0f 83 15 03 00 00    	jae    9ce1 <fwp_gc_sweep+0x471>
    99cc:	31 c9                	xor    %ecx,%ecx
    99ce:	e9 45 03 00 00       	jmp    9d18 <fwp_gc_sweep+0x4a8>
    99d3:	89 c1                	mov    %eax,%ecx
    99d5:	83 e1 fc             	and    $0xfffffffc,%ecx
    99d8:	4a 8d 34 33          	lea    (%rbx,%r14,1),%rsi
    99dc:	48 83 c6 38          	add    $0x38,%rsi
    99e0:	48 c1 ea 03          	shr    $0x3,%rdx
    99e4:	83 e2 e0             	and    $0xffffffe0,%edx
    99e7:	66 0f ef c0          	pxor   %xmm0,%xmm0
    99eb:	31 ff                	xor    %edi,%edi
    99ed:	66 0f ef c9          	pxor   %xmm1,%xmm1
    99f1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    99f8:	0f 1f 84 00 00 00 00 
    99ff:	00 
    9a00:	f3 0f 6f 5c 3e f0    	movdqu -0x10(%rsi,%rdi,1),%xmm3
    9a06:	f3 0f 6f 14 3e       	movdqu (%rsi,%rdi,1),%xmm2
    9a0b:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    9a0f:	66 0f 71 d4 01       	psrlw  $0x1,%xmm4
    9a14:	66 0f db e5          	pand   %xmm5,%xmm4
    9a18:	66 0f f8 dc          	psubb  %xmm4,%xmm3
    9a1c:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    9a20:	66 0f db e6          	pand   %xmm6,%xmm4
    9a24:	66 0f 71 d3 02       	psrlw  $0x2,%xmm3
    9a29:	66 0f db de          	pand   %xmm6,%xmm3
    9a2d:	66 0f fc dc          	paddb  %xmm4,%xmm3
    9a31:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    9a35:	66 0f 71 d4 04       	psrlw  $0x4,%xmm4
    9a3a:	66 0f fc e3          	paddb  %xmm3,%xmm4
    9a3e:	66 0f db e7          	pand   %xmm7,%xmm4
    9a42:	66 41 0f f6 e0       	psadbw %xmm8,%xmm4
    9a47:	66 0f d4 c4          	paddq  %xmm4,%xmm0
    9a4b:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9a4f:	66 0f 71 d3 01       	psrlw  $0x1,%xmm3
    9a54:	66 0f db dd          	pand   %xmm5,%xmm3
    9a58:	66 0f f8 d3          	psubb  %xmm3,%xmm2
    9a5c:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9a60:	66 0f db de          	pand   %xmm6,%xmm3
    9a64:	66 0f 71 d2 02       	psrlw  $0x2,%xmm2
    9a69:	66 0f db d6          	pand   %xmm6,%xmm2
    9a6d:	66 0f fc d3          	paddb  %xmm3,%xmm2
    9a71:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9a75:	66 0f 71 d3 04       	psrlw  $0x4,%xmm3
    9a7a:	66 0f fc da          	paddb  %xmm2,%xmm3
    9a7e:	66 0f db df          	pand   %xmm7,%xmm3
    9a82:	66 41 0f f6 d8       	psadbw %xmm8,%xmm3
    9a87:	66 0f d4 cb          	paddq  %xmm3,%xmm1
    9a8b:	48 83 c7 20          	add    $0x20,%rdi
    9a8f:	48 39 fa             	cmp    %rdi,%rdx
    9a92:	0f 85 68 ff ff ff    	jne    9a00 <fwp_gc_sweep+0x190>
    9a98:	66 0f d4 c8          	paddq  %xmm0,%xmm1
    9a9c:	66 0f 70 c1 ee       	pshufd $0xee,%xmm1,%xmm0
    9aa1:	66 0f d4 c1          	paddq  %xmm1,%xmm0
    9aa5:	66 48 0f 7e c2       	movq   %xmm0,%rdx
    9aaa:	48 39 c8             	cmp    %rcx,%rax
    9aad:	74 51                	je     9b00 <fwp_gc_sweep+0x290>
    9aaf:	4a 8d 34 33          	lea    (%rbx,%r14,1),%rsi
    9ab3:	48 83 c6 28          	add    $0x28,%rsi
    9ab7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    9abe:	00 00 
    9ac0:	48 8b 3c ce          	mov    (%rsi,%rcx,8),%rdi
    9ac4:	49 89 f8             	mov    %rdi,%r8
    9ac7:	49 d1 e8             	shr    $1,%r8
    9aca:	4d 21 c8             	and    %r9,%r8
    9acd:	4c 29 c7             	sub    %r8,%rdi
    9ad0:	49 89 f8             	mov    %rdi,%r8
    9ad3:	4d 21 d0             	and    %r10,%r8
    9ad6:	48 c1 ef 02          	shr    $0x2,%rdi
    9ada:	4c 21 d7             	and    %r10,%rdi
    9add:	4c 01 c7             	add    %r8,%rdi
    9ae0:	49 89 f8             	mov    %rdi,%r8
    9ae3:	49 c1 e8 04          	shr    $0x4,%r8
    9ae7:	49 01 f8             	add    %rdi,%r8
    9aea:	4d 21 d8             	and    %r11,%r8
    9aed:	4d 0f af c4          	imul   %r12,%r8
    9af1:	49 c1 e8 38          	shr    $0x38,%r8
    9af5:	4c 01 c2             	add    %r8,%rdx
    9af8:	48 ff c1             	inc    %rcx
    9afb:	48 39 c8             	cmp    %rcx,%rax
    9afe:	75 c0                	jne    9ac0 <fwp_gc_sweep+0x250>
    9b00:	48 85 d2             	test   %rdx,%rdx
    9b03:	0f 84 23 01 00 00    	je     9c2c <fwp_gc_sweep+0x3bc>
    9b09:	42 8b 44 33 08       	mov    0x8(%rbx,%r14,1),%eax
    9b0e:	48 0f af d0          	imul   %rax,%rdx
    9b12:	48 01 54 24 08       	add    %rdx,0x8(%rsp)
    9b17:	4d 85 ff             	test   %r15,%r15
    9b1a:	0f 84 e3 fd ff ff    	je     9903 <fwp_gc_sweep+0x93>
    9b20:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
    9b25:	42 0f b6 44 33 01    	movzbl 0x1(%rbx,%r14,1),%eax
    9b2b:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    9b32:	4d 89 ec             	mov    %r13,%r12
    9b35:	49 c1 e4 10          	shl    $0x10,%r12
    9b39:	4c 03 25 78 17 01 00 	add    0x11778(%rip),%r12        # 1b2b8 <fwp_gc+0x1030>
    9b40:	48 8d 0d 41 07 01 00 	lea    0x10741(%rip),%rcx        # 1a288 <fwp_gc>
    9b47:	48 01 c8             	add    %rcx,%rax
    9b4a:	4a 8d 0c 33          	lea    (%rbx,%r14,1),%rcx
    9b4e:	48 83 c1 08          	add    $0x8,%rcx
    9b52:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
    9b57:	42 0f b6 4c 33 02    	movzbl 0x2(%rbx,%r14,1),%ecx
    9b5d:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    9b61:	48 8d 2c c8          	lea    (%rax,%rcx,8),%rbp
    9b65:	48 83 c5 08          	add    $0x8,%rbp
    9b69:	4d 01 fe             	add    %r15,%r14
    9b6c:	4c 01 f3             	add    %r14,%rbx
    9b6f:	48 81 c3 27 02 00 00 	add    $0x227,%rbx
    9b76:	49 ff cf             	dec    %r15
    9b79:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    9b7e:	eb 23                	jmp    9ba3 <fwp_gc_sweep+0x333>
    9b80:	80 3b ff             	cmpb   $0xff,(%rbx)
    9b83:	74 78                	je     9bfd <fwp_gc_sweep+0x38d>
    9b85:	c6 03 00             	movb   $0x0,(%rbx)
    9b88:	48 8b 45 00          	mov    0x0(%rbp),%rax
    9b8c:	48 f7 d0             	not    %rax
    9b8f:	49 89 06             	mov    %rax,(%r14)
    9b92:	4c 89 75 00          	mov    %r14,0x0(%rbp)
    9b96:	48 ff cb             	dec    %rbx
    9b99:	49 83 c7 ff          	add    $0xffffffffffffffff,%r15
    9b9d:	0f 83 37 01 00 00    	jae    9cda <fwp_gc_sweep+0x46a>
    9ba3:	4c 89 f8             	mov    %r15,%rax
    9ba6:	48 c1 e8 06          	shr    $0x6,%rax
    9baa:	48 8b 44 c1 28       	mov    0x28(%rcx,%rax,8),%rax
    9baf:	4c 0f a3 f8          	bt     %r15,%rax
    9bb3:	72 e1                	jb     9b96 <fwp_gc_sweep+0x326>
    9bb5:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    9bba:	8b 10                	mov    (%rax),%edx
    9bbc:	4d 89 fe             	mov    %r15,%r14
    9bbf:	4c 0f af f2          	imul   %rdx,%r14
    9bc3:	4d 01 e6             	add    %r12,%r14
    9bc6:	83 3d bf 16 01 00 00 	cmpl   $0x0,0x116bf(%rip)        # 1b28c <fwp_gc+0x1004>
    9bcd:	74 b1                	je     9b80 <fwp_gc_sweep+0x310>
    9bcf:	4c 89 f7             	mov    %r14,%rdi
    9bd2:	31 f6                	xor    %esi,%esi
    9bd4:	e8 37 96 ff ff       	call   3210 <memset@plt>
    9bd9:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    9bde:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    9be3:	66 0f 6f 3d f5 b4 00 	movdqa 0xb4f5(%rip),%xmm7        # 150e0 <_IO_stdin_used+0xe0>
    9bea:	00 
    9beb:	66 0f 6f 35 dd b4 00 	movdqa 0xb4dd(%rip),%xmm6        # 150d0 <_IO_stdin_used+0xd0>
    9bf2:	00 
    9bf3:	66 0f 6f 2d c5 b4 00 	movdqa 0xb4c5(%rip),%xmm5        # 150c0 <_IO_stdin_used+0xc0>
    9bfa:	00 
    9bfb:	eb 83                	jmp    9b80 <fwp_gc_sweep+0x310>
    9bfd:	48 89 df             	mov    %rbx,%rdi
    9c00:	e8 3b cf ff ff       	call   6b40 <fwp_rc_forget_slot>
    9c05:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    9c0a:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    9c0f:	66 0f 6f 3d c9 b4 00 	movdqa 0xb4c9(%rip),%xmm7        # 150e0 <_IO_stdin_used+0xe0>
    9c16:	00 
    9c17:	66 0f 6f 35 b1 b4 00 	movdqa 0xb4b1(%rip),%xmm6        # 150d0 <_IO_stdin_used+0xd0>
    9c1e:	00 
    9c1f:	66 0f 6f 2d 99 b4 00 	movdqa 0xb499(%rip),%xmm5        # 150c0 <_IO_stdin_used+0xc0>
    9c26:	00 
    9c27:	e9 59 ff ff ff       	jmp    9b85 <fwp_gc_sweep+0x315>
    9c2c:	48 83 3d 6c 20 01 00 	cmpq   $0x0,0x1206c(%rip)        # 1bca0 <fwp_gc+0x1a18>
    9c33:	00 
    9c34:	74 38                	je     9c6e <fwp_gc_sweep+0x3fe>
    9c36:	4e 8d 3c 33          	lea    (%rbx,%r14,1),%r15
    9c3a:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    9c41:	45 31 e4             	xor    %r12d,%r12d
    9c44:	eb 16                	jmp    9c5c <fwp_gc_sweep+0x3ec>
    9c46:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    9c4d:	00 00 00 
    9c50:	49 ff c4             	inc    %r12
    9c53:	49 81 fc 00 10 00 00 	cmp    $0x1000,%r12
    9c5a:	74 12                	je     9c6e <fwp_gc_sweep+0x3fe>
    9c5c:	43 80 3c 27 ff       	cmpb   $0xff,(%r15,%r12,1)
    9c61:	75 ed                	jne    9c50 <fwp_gc_sweep+0x3e0>
    9c63:	4b 8d 3c 27          	lea    (%r15,%r12,1),%rdi
    9c67:	e8 d4 ce ff ff       	call   6b40 <fwp_rc_forget_slot>
    9c6c:	eb e2                	jmp    9c50 <fwp_gc_sweep+0x3e0>
    9c6e:	4a 8d 3c 33          	lea    (%rbx,%r14,1),%rdi
    9c72:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    9c79:	ba 00 10 00 00       	mov    $0x1000,%edx
    9c7e:	31 f6                	xor    %esi,%esi
    9c80:	e8 8b 95 ff ff       	call   3210 <memset@plt>
    9c85:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    9c8a:	c6 00 00             	movb   $0x0,(%rax)
    9c8d:	48 ff c5             	inc    %rbp
    9c90:	49 b9 55 55 55 55 55 	movabs $0x5555555555555555,%r9
    9c97:	55 55 55 
    9c9a:	49 ba 33 33 33 33 33 	movabs $0x3333333333333333,%r10
    9ca1:	33 33 33 
    9ca4:	49 bb 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r11
    9cab:	0f 0f 0f 
    9cae:	49 bc 01 01 01 01 01 	movabs $0x101010101010101,%r12
    9cb5:	01 01 01 
    9cb8:	66 0f 6f 2d 00 b4 00 	movdqa 0xb400(%rip),%xmm5        # 150c0 <_IO_stdin_used+0xc0>
    9cbf:	00 
    9cc0:	66 0f 6f 35 08 b4 00 	movdqa 0xb408(%rip),%xmm6        # 150d0 <_IO_stdin_used+0xd0>
    9cc7:	00 
    9cc8:	66 0f 6f 3d 10 b4 00 	movdqa 0xb410(%rip),%xmm7        # 150e0 <_IO_stdin_used+0xe0>
    9ccf:	00 
    9cd0:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    9cd5:	e9 29 fc ff ff       	jmp    9903 <fwp_gc_sweep+0x93>
    9cda:	48 8b 6c 24 18       	mov    0x18(%rsp),%rbp
    9cdf:	eb 78                	jmp    9d59 <fwp_gc_sweep+0x4e9>
    9ce1:	4a 8d 14 30          	lea    (%rax,%r14,1),%rdx
    9ce5:	44 89 e6             	mov    %r12d,%esi
    9ce8:	83 e6 fc             	and    $0xfffffffc,%esi
    9ceb:	31 c9                	xor    %ecx,%ecx
    9ced:	0f 1f 00             	nopl   (%rax)
    9cf0:	c6 02 00             	movb   $0x0,(%rdx)
    9cf3:	c6 82 28 12 00 00 00 	movb   $0x0,0x1228(%rdx)
    9cfa:	c6 82 50 24 00 00 00 	movb   $0x0,0x2450(%rdx)
    9d01:	c6 82 78 36 00 00 00 	movb   $0x0,0x3678(%rdx)
    9d08:	48 83 c1 04          	add    $0x4,%rcx
    9d0c:	48 81 c2 a0 48 00 00 	add    $0x48a0,%rdx
    9d13:	48 39 ce             	cmp    %rcx,%rsi
    9d16:	75 d8                	jne    9cf0 <fwp_gc_sweep+0x480>
    9d18:	44 89 e2             	mov    %r12d,%edx
    9d1b:	83 e2 03             	and    $0x3,%edx
    9d1e:	74 30                	je     9d50 <fwp_gc_sweep+0x4e0>
    9d20:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    9d27:	4c 01 f1             	add    %r14,%rcx
    9d2a:	48 01 c8             	add    %rcx,%rax
    9d2d:	48 69 ca 28 12 00 00 	imul   $0x1228,%rdx,%rcx
    9d34:	31 d2                	xor    %edx,%edx
    9d36:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    9d3d:	00 00 00 
    9d40:	c6 04 10 00          	movb   $0x0,(%rax,%rdx,1)
    9d44:	48 81 c2 28 12 00 00 	add    $0x1228,%rdx
    9d4b:	48 39 d1             	cmp    %rdx,%rcx
    9d4e:	75 f0                	jne    9d40 <fwp_gc_sweep+0x4d0>
    9d50:	4c 01 e5             	add    %r12,%rbp
    9d53:	4d 01 e5             	add    %r12,%r13
    9d56:	49 ff cd             	dec    %r13
    9d59:	49 b9 55 55 55 55 55 	movabs $0x5555555555555555,%r9
    9d60:	55 55 55 
    9d63:	49 ba 33 33 33 33 33 	movabs $0x3333333333333333,%r10
    9d6a:	33 33 33 
    9d6d:	49 bb 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r11
    9d74:	0f 0f 0f 
    9d77:	49 bc 01 01 01 01 01 	movabs $0x101010101010101,%r12
    9d7e:	01 01 01 
    9d81:	e9 7d fb ff ff       	jmp    9903 <fwp_gc_sweep+0x93>
    9d86:	4c 89 ff             	mov    %r15,%rdi
    9d89:	e8 b2 cd ff ff       	call   6b40 <fwp_rc_forget_slot>
    9d8e:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    9d93:	66 0f 6f 3d 45 b3 00 	movdqa 0xb345(%rip),%xmm7        # 150e0 <_IO_stdin_used+0xe0>
    9d9a:	00 
    9d9b:	66 0f 6f 35 2d b3 00 	movdqa 0xb32d(%rip),%xmm6        # 150d0 <_IO_stdin_used+0xd0>
    9da2:	00 
    9da3:	66 0f 6f 2d 15 b3 00 	movdqa 0xb315(%rip),%xmm5        # 150c0 <_IO_stdin_used+0xc0>
    9daa:	00 
    9dab:	e9 fe fb ff ff       	jmp    99ae <fwp_gc_sweep+0x13e>
    9db0:	31 c0                	xor    %eax,%eax
    9db2:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    9db7:	31 c0                	xor    %eax,%eax
    9db9:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    9dbe:	48 89 15 8b 16 01 00 	mov    %rdx,0x1168b(%rip)        # 1b450 <fwp_gc+0x11c8>
    9dc5:	48 89 2d 9c 16 01 00 	mov    %rbp,0x1169c(%rip)        # 1b468 <fwp_gc+0x11e0>
    9dcc:	48 81 fa 01 00 00 01 	cmp    $0x1000001,%rdx
    9dd3:	b9 00 00 00 01       	mov    $0x1000000,%ecx
    9dd8:	48 0f 43 ca          	cmovae %rdx,%rcx
    9ddc:	48 c1 e9 10          	shr    $0x10,%rcx
    9de0:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9de4:	f3 0f 7f 05 04 15 01 	movdqu %xmm0,0x11504(%rip)        # 1b2f0 <fwp_gc+0x1068>
    9deb:	00 
    9dec:	48 29 cd             	sub    %rcx,%rbp
    9def:	0f 86 fc 00 00 00    	jbe    9ef1 <fwp_gc_sweep+0x681>
    9df5:	48 85 c0             	test   %rax,%rax
    9df8:	0f 84 f3 00 00 00    	je     9ef1 <fwp_gc_sweep+0x681>
    9dfe:	48 85 ed             	test   %rbp,%rbp
    9e01:	0f 84 ea 00 00 00    	je     9ef1 <fwp_gc_sweep+0x681>
    9e07:	48 8b 0d f2 14 01 00 	mov    0x114f2(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    9e0e:	66 90                	xchg   %ax,%ax
    9e10:	48 8d 58 ff          	lea    -0x1(%rax),%rbx
    9e14:	48 69 d3 28 12 00 00 	imul   $0x1228,%rbx,%rdx
    9e1b:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
    9e1f:	0f 85 bb 00 00 00    	jne    9ee0 <fwp_gc_sweep+0x670>
    9e25:	4c 8d 75 ff          	lea    -0x1(%rbp),%r14
    9e29:	80 7c 11 04 00       	cmpb   $0x0,0x4(%rcx,%rdx,1)
    9e2e:	0f 84 a9 00 00 00    	je     9edd <fwp_gc_sweep+0x66d>
    9e34:	48 01 ca             	add    %rcx,%rdx
    9e37:	48 83 c2 04          	add    $0x4,%rdx
    9e3b:	c6 02 00             	movb   $0x0,(%rdx)
    9e3e:	be 01 00 00 00       	mov    $0x1,%esi
    9e43:	48 85 db             	test   %rbx,%rbx
    9e46:	74 72                	je     9eba <fwp_gc_sweep+0x64a>
    9e48:	4d 85 f6             	test   %r14,%r14
    9e4b:	74 6d                	je     9eba <fwp_gc_sweep+0x64a>
    9e4d:	ba 02 00 00 00       	mov    $0x2,%edx
    9e52:	48 29 c2             	sub    %rax,%rdx
    9e55:	48 69 c0 28 12 00 00 	imul   $0x1228,%rax,%rax
    9e5c:	48 01 c1             	add    %rax,%rcx
    9e5f:	48 81 c1 b4 db ff ff 	add    $0xffffffffffffdbb4,%rcx
    9e66:	bf 02 00 00 00       	mov    $0x2,%edi
    9e6b:	48 29 ef             	sub    %rbp,%rdi
    9e6e:	b8 01 00 00 00       	mov    $0x1,%eax
    9e73:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9e7a:	84 00 00 00 00 00 
    9e80:	80 79 fc 00          	cmpb   $0x0,-0x4(%rcx)
    9e84:	75 31                	jne    9eb7 <fwp_gc_sweep+0x647>
    9e86:	80 39 00             	cmpb   $0x0,(%rcx)
    9e89:	74 2c                	je     9eb7 <fwp_gc_sweep+0x647>
    9e8b:	48 ff cb             	dec    %rbx
    9e8e:	4c 8d 04 02          	lea    (%rdx,%rax,1),%r8
    9e92:	49 ff ce             	dec    %r14
    9e95:	c6 01 00             	movb   $0x0,(%rcx)
    9e98:	48 8d 70 01          	lea    0x1(%rax),%rsi
    9e9c:	49 83 f8 01          	cmp    $0x1,%r8
    9ea0:	74 18                	je     9eba <fwp_gc_sweep+0x64a>
    9ea2:	48 01 f8             	add    %rdi,%rax
    9ea5:	48 81 c1 d8 ed ff ff 	add    $0xffffffffffffedd8,%rcx
    9eac:	48 83 f8 01          	cmp    $0x1,%rax
    9eb0:	48 89 f0             	mov    %rsi,%rax
    9eb3:	75 cb                	jne    9e80 <fwp_gc_sweep+0x610>
    9eb5:	eb 03                	jmp    9eba <fwp_gc_sweep+0x64a>
    9eb7:	48 89 c6             	mov    %rax,%rsi
    9eba:	48 89 df             	mov    %rbx,%rdi
    9ebd:	48 c1 e7 10          	shl    $0x10,%rdi
    9ec1:	48 03 3d f0 13 01 00 	add    0x113f0(%rip),%rdi        # 1b2b8 <fwp_gc+0x1030>
    9ec8:	48 c1 e6 10          	shl    $0x10,%rsi
    9ecc:	ba 04 00 00 00       	mov    $0x4,%edx
    9ed1:	e8 1a 95 ff ff       	call   33f0 <madvise@plt>
    9ed6:	48 8b 0d 23 14 01 00 	mov    0x11423(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    9edd:	4c 89 f5             	mov    %r14,%rbp
    9ee0:	48 89 d8             	mov    %rbx,%rax
    9ee3:	48 85 db             	test   %rbx,%rbx
    9ee6:	74 09                	je     9ef1 <fwp_gc_sweep+0x681>
    9ee8:	48 85 ed             	test   %rbp,%rbp
    9eeb:	0f 85 1f ff ff ff    	jne    9e10 <fwp_gc_sweep+0x5a0>
    9ef1:	48 83 c4 28          	add    $0x28,%rsp
    9ef5:	5b                   	pop    %rbx
    9ef6:	41 5c                	pop    %r12
    9ef8:	41 5d                	pop    %r13
    9efa:	41 5e                	pop    %r14
    9efc:	41 5f                	pop    %r15
    9efe:	5d                   	pop    %rbp
    9eff:	c3                   	ret

0000000000009f00 <fwp_gc_sp>:
    9f00:	55                   	push   %rbp
    9f01:	48 89 e5             	mov    %rsp,%rbp
    9f04:	48 89 e8             	mov    %rbp,%rax
    9f07:	5d                   	pop    %rbp
    9f08:	c3                   	ret
    9f09:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000009f10 <fwp_gc_scan>:
    9f10:	55                   	push   %rbp
    9f11:	41 57                	push   %r15
    9f13:	41 56                	push   %r14
    9f15:	41 55                	push   %r13
    9f17:	41 54                	push   %r12
    9f19:	53                   	push   %rbx
    9f1a:	50                   	push   %rax
    9f1b:	49 89 ff             	mov    %rdi,%r15
    9f1e:	49 83 c7 07          	add    $0x7,%r15
    9f22:	49 83 e7 f8          	and    $0xfffffffffffffff8,%r15
    9f26:	49 8d 47 08          	lea    0x8(%r15),%rax
    9f2a:	48 39 f0             	cmp    %rsi,%rax
    9f2d:	76 0f                	jbe    9f3e <fwp_gc_scan+0x2e>
    9f2f:	48 83 c4 08          	add    $0x8,%rsp
    9f33:	5b                   	pop    %rbx
    9f34:	41 5c                	pop    %r12
    9f36:	41 5d                	pop    %r13
    9f38:	41 5e                	pop    %r14
    9f3a:	41 5f                	pop    %r15
    9f3c:	5d                   	pop    %rbp
    9f3d:	c3                   	ret
    9f3e:	89 d3                	mov    %edx,%ebx
    9f40:	49 89 f6             	mov    %rsi,%r14
    9f43:	4c 8b 25 6e 13 01 00 	mov    0x1136e(%rip),%r12        # 1b2b8 <fwp_gc+0x1030>
    9f4a:	4c 8b 2d 8f 13 01 00 	mov    0x1138f(%rip),%r13        # 1b2e0 <fwp_gc+0x1058>
    9f51:	49 c1 e5 10          	shl    $0x10,%r13
    9f55:	eb 29                	jmp    9f80 <fwp_gc_scan+0x70>
    9f57:	4d 01 d0             	add    %r10,%r8
    9f5a:	41 80 78 03 00       	cmpb   $0x0,0x3(%r8)
    9f5f:	0f 84 a6 02 00 00    	je     a20b <fwp_gc_scan+0x2fb>
    9f65:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    9f6c:	00 00 00 00 
    9f70:	49 8d 47 08          	lea    0x8(%r15),%rax
    9f74:	49 83 c7 10          	add    $0x10,%r15
    9f78:	4d 39 f7             	cmp    %r14,%r15
    9f7b:	49 89 c7             	mov    %rax,%r15
    9f7e:	77 af                	ja     9f2f <fwp_gc_scan+0x1f>
    9f80:	49 8b 2f             	mov    (%r15),%rbp
    9f83:	48 89 e8             	mov    %rbp,%rax
    9f86:	4c 29 e0             	sub    %r12,%rax
    9f89:	4c 39 e8             	cmp    %r13,%rax
    9f8c:	0f 83 de 00 00 00    	jae    a070 <fwp_gc_scan+0x160>
    9f92:	48 8b 3d 1f 13 01 00 	mov    0x1131f(%rip),%rdi        # 1b2b8 <fwp_gc+0x1030>
    9f99:	49 89 e9             	mov    %rbp,%r9
    9f9c:	49 29 f9             	sub    %rdi,%r9
    9f9f:	48 8b 05 3a 13 01 00 	mov    0x1133a(%rip),%rax        # 1b2e0 <fwp_gc+0x1058>
    9fa6:	48 c1 e0 10          	shl    $0x10,%rax
    9faa:	49 39 c1             	cmp    %rax,%r9
    9fad:	0f 83 6d 01 00 00    	jae    a120 <fwp_gc_scan+0x210>
    9fb3:	4c 8b 05 46 13 01 00 	mov    0x11346(%rip),%r8        # 1b300 <fwp_gc+0x1078>
    9fba:	4d 85 c0             	test   %r8,%r8
    9fbd:	0f 84 5d 01 00 00    	je     a120 <fwp_gc_scan+0x210>
    9fc3:	4c 89 c8             	mov    %r9,%rax
    9fc6:	48 c1 e8 10          	shr    $0x10,%rax
    9fca:	4c 69 d0 28 12 00 00 	imul   $0x1228,%rax,%r10
    9fd1:	43 0f b6 0c 10       	movzbl (%r8,%r10,1),%ecx
    9fd6:	83 f9 03             	cmp    $0x3,%ecx
    9fd9:	0f 84 0c 01 00 00    	je     a0eb <fwp_gc_scan+0x1db>
    9fdf:	83 f9 02             	cmp    $0x2,%ecx
    9fe2:	0f 84 f7 00 00 00    	je     a0df <fwp_gc_scan+0x1cf>
    9fe8:	83 f9 01             	cmp    $0x1,%ecx
    9feb:	0f 85 2f 01 00 00    	jne    a120 <fwp_gc_scan+0x210>
    9ff1:	43 8b 4c 10 08       	mov    0x8(%r8,%r10,1),%ecx
    9ff6:	0f b7 c5             	movzwl %bp,%eax
    9ff9:	31 d2                	xor    %edx,%edx
    9ffb:	48 89 0c 24          	mov    %rcx,(%rsp)
    9fff:	f7 f1                	div    %ecx
    a001:	43 3b 44 10 0c       	cmp    0xc(%r8,%r10,1),%eax
    a006:	0f 83 14 01 00 00    	jae    a120 <fwp_gc_scan+0x210>
    a00c:	ba 01 00 00 00       	mov    $0x1,%edx
    a011:	89 c1                	mov    %eax,%ecx
    a013:	48 d3 e2             	shl    %cl,%rdx
    a016:	4b 8d 34 10          	lea    (%r8,%r10,1),%rsi
    a01a:	41 89 c3             	mov    %eax,%r11d
    a01d:	41 c1 eb 06          	shr    $0x6,%r11d
    a021:	4a 8b 4c de 28       	mov    0x28(%rsi,%r11,8),%rcx
    a026:	48 0f a3 c1          	bt     %rax,%rcx
    a02a:	0f 82 f0 00 00 00    	jb     a120 <fwp_gc_scan+0x210>
    a030:	4a 8d 34 de          	lea    (%rsi,%r11,8),%rsi
    a034:	48 83 c6 28          	add    $0x28,%rsi
    a038:	48 09 d1             	or     %rdx,%rcx
    a03b:	48 89 0e             	mov    %rcx,(%rsi)
    a03e:	43 80 7c 10 01 01    	cmpb   $0x1,0x1(%r8,%r10,1)
    a044:	0f 84 d6 00 00 00    	je     a120 <fwp_gc_scan+0x210>
    a04a:	49 81 e1 00 00 ff ff 	and    $0xffffffffffff0000,%r9
    a051:	4c 01 cf             	add    %r9,%rdi
    a054:	48 8b 34 24          	mov    (%rsp),%rsi
    a058:	48 0f af c6          	imul   %rsi,%rax
    a05c:	48 01 f8             	add    %rdi,%rax
    a05f:	48 89 c7             	mov    %rax,%rdi
    a062:	e9 b1 00 00 00       	jmp    a118 <fwp_gc_scan+0x208>
    a067:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    a06e:	00 00 
    a070:	85 db                	test   %ebx,%ebx
    a072:	0f 84 f8 fe ff ff    	je     9f70 <fwp_gc_scan+0x60>
    a078:	4c 39 e8             	cmp    %r13,%rax
    a07b:	0f 85 ef fe ff ff    	jne    9f70 <fwp_gc_scan+0x60>
    a081:	48 ff cd             	dec    %rbp
    a084:	48 8b 3d 2d 12 01 00 	mov    0x1122d(%rip),%rdi        # 1b2b8 <fwp_gc+0x1030>
    a08b:	49 89 e9             	mov    %rbp,%r9
    a08e:	49 29 f9             	sub    %rdi,%r9
    a091:	48 8b 05 48 12 01 00 	mov    0x11248(%rip),%rax        # 1b2e0 <fwp_gc+0x1058>
    a098:	48 c1 e0 10          	shl    $0x10,%rax
    a09c:	49 39 c1             	cmp    %rax,%r9
    a09f:	0f 83 cb fe ff ff    	jae    9f70 <fwp_gc_scan+0x60>
    a0a5:	4c 8b 05 54 12 01 00 	mov    0x11254(%rip),%r8        # 1b300 <fwp_gc+0x1078>
    a0ac:	4d 85 c0             	test   %r8,%r8
    a0af:	0f 84 bb fe ff ff    	je     9f70 <fwp_gc_scan+0x60>
    a0b5:	4c 89 c8             	mov    %r9,%rax
    a0b8:	48 c1 e8 10          	shr    $0x10,%rax
    a0bc:	4c 69 d0 28 12 00 00 	imul   $0x1228,%rax,%r10
    a0c3:	43 0f b6 0c 10       	movzbl (%r8,%r10,1),%ecx
    a0c8:	83 f9 03             	cmp    $0x3,%ecx
    a0cb:	0f 84 20 01 00 00    	je     a1f1 <fwp_gc_scan+0x2e1>
    a0d1:	83 f9 02             	cmp    $0x2,%ecx
    a0d4:	0f 85 a3 00 00 00    	jne    a17d <fwp_gc_scan+0x26d>
    a0da:	e9 78 fe ff ff       	jmp    9f57 <fwp_gc_scan+0x47>
    a0df:	4d 01 d0             	add    %r10,%r8
    a0e2:	41 80 78 03 00       	cmpb   $0x0,0x3(%r8)
    a0e7:	75 37                	jne    a120 <fwp_gc_scan+0x210>
    a0e9:	eb 16                	jmp    a101 <fwp_gc_scan+0x1f1>
    a0eb:	43 8b 44 10 10       	mov    0x10(%r8,%r10,1),%eax
    a0f0:	48 69 c8 28 12 00 00 	imul   $0x1228,%rax,%rcx
    a0f7:	49 01 c8             	add    %rcx,%r8
    a0fa:	41 80 78 03 00       	cmpb   $0x0,0x3(%r8)
    a0ff:	75 1f                	jne    a120 <fwp_gc_scan+0x210>
    a101:	41 c6 40 03 01       	movb   $0x1,0x3(%r8)
    a106:	41 80 78 01 01       	cmpb   $0x1,0x1(%r8)
    a10b:	74 13                	je     a120 <fwp_gc_scan+0x210>
    a10d:	48 c1 e0 10          	shl    $0x10,%rax
    a111:	48 01 c7             	add    %rax,%rdi
    a114:	49 8b 70 18          	mov    0x18(%r8),%rsi
    a118:	e8 13 01 00 00       	call   a230 <fwp_gc_push>
    a11d:	0f 1f 00             	nopl   (%rax)
    a120:	85 db                	test   %ebx,%ebx
    a122:	0f 84 48 fe ff ff    	je     9f70 <fwp_gc_scan+0x60>
    a128:	48 ff cd             	dec    %rbp
    a12b:	48 8b 3d 86 11 01 00 	mov    0x11186(%rip),%rdi        # 1b2b8 <fwp_gc+0x1030>
    a132:	49 89 e9             	mov    %rbp,%r9
    a135:	49 29 f9             	sub    %rdi,%r9
    a138:	48 8b 05 a1 11 01 00 	mov    0x111a1(%rip),%rax        # 1b2e0 <fwp_gc+0x1058>
    a13f:	48 c1 e0 10          	shl    $0x10,%rax
    a143:	49 39 c1             	cmp    %rax,%r9
    a146:	0f 83 24 fe ff ff    	jae    9f70 <fwp_gc_scan+0x60>
    a14c:	4c 8b 05 ad 11 01 00 	mov    0x111ad(%rip),%r8        # 1b300 <fwp_gc+0x1078>
    a153:	4d 85 c0             	test   %r8,%r8
    a156:	0f 84 14 fe ff ff    	je     9f70 <fwp_gc_scan+0x60>
    a15c:	4c 89 c8             	mov    %r9,%rax
    a15f:	48 c1 e8 10          	shr    $0x10,%rax
    a163:	4c 69 d0 28 12 00 00 	imul   $0x1228,%rax,%r10
    a16a:	43 0f b6 0c 10       	movzbl (%r8,%r10,1),%ecx
    a16f:	83 f9 03             	cmp    $0x3,%ecx
    a172:	74 7d                	je     a1f1 <fwp_gc_scan+0x2e1>
    a174:	83 f9 02             	cmp    $0x2,%ecx
    a177:	0f 84 da fd ff ff    	je     9f57 <fwp_gc_scan+0x47>
    a17d:	83 f9 01             	cmp    $0x1,%ecx
    a180:	0f 85 ea fd ff ff    	jne    9f70 <fwp_gc_scan+0x60>
    a186:	43 8b 74 10 08       	mov    0x8(%r8,%r10,1),%esi
    a18b:	0f b7 c5             	movzwl %bp,%eax
    a18e:	31 d2                	xor    %edx,%edx
    a190:	f7 f6                	div    %esi
    a192:	43 3b 44 10 0c       	cmp    0xc(%r8,%r10,1),%eax
    a197:	0f 83 d3 fd ff ff    	jae    9f70 <fwp_gc_scan+0x60>
    a19d:	ba 01 00 00 00       	mov    $0x1,%edx
    a1a2:	89 c1                	mov    %eax,%ecx
    a1a4:	48 d3 e2             	shl    %cl,%rdx
    a1a7:	4b 8d 0c 10          	lea    (%r8,%r10,1),%rcx
    a1ab:	41 89 c3             	mov    %eax,%r11d
    a1ae:	41 c1 eb 06          	shr    $0x6,%r11d
    a1b2:	4a 8b 6c d9 28       	mov    0x28(%rcx,%r11,8),%rbp
    a1b7:	48 0f a3 c5          	bt     %rax,%rbp
    a1bb:	0f 82 af fd ff ff    	jb     9f70 <fwp_gc_scan+0x60>
    a1c1:	4a 8d 0c d9          	lea    (%rcx,%r11,8),%rcx
    a1c5:	48 83 c1 28          	add    $0x28,%rcx
    a1c9:	48 09 d5             	or     %rdx,%rbp
    a1cc:	48 89 29             	mov    %rbp,(%rcx)
    a1cf:	43 80 7c 10 01 01    	cmpb   $0x1,0x1(%r8,%r10,1)
    a1d5:	0f 84 95 fd ff ff    	je     9f70 <fwp_gc_scan+0x60>
    a1db:	49 81 e1 00 00 ff ff 	and    $0xffffffffffff0000,%r9
    a1e2:	4c 01 cf             	add    %r9,%rdi
    a1e5:	48 0f af c6          	imul   %rsi,%rax
    a1e9:	48 01 f8             	add    %rdi,%rax
    a1ec:	48 89 c7             	mov    %rax,%rdi
    a1ef:	eb 35                	jmp    a226 <fwp_gc_scan+0x316>
    a1f1:	43 8b 44 10 10       	mov    0x10(%r8,%r10,1),%eax
    a1f6:	48 69 c8 28 12 00 00 	imul   $0x1228,%rax,%rcx
    a1fd:	49 01 c8             	add    %rcx,%r8
    a200:	41 80 78 03 00       	cmpb   $0x0,0x3(%r8)
    a205:	0f 85 65 fd ff ff    	jne    9f70 <fwp_gc_scan+0x60>
    a20b:	41 c6 40 03 01       	movb   $0x1,0x3(%r8)
    a210:	41 80 78 01 01       	cmpb   $0x1,0x1(%r8)
    a215:	0f 84 55 fd ff ff    	je     9f70 <fwp_gc_scan+0x60>
    a21b:	48 c1 e0 10          	shl    $0x10,%rax
    a21f:	48 01 c7             	add    %rax,%rdi
    a222:	49 8b 70 18          	mov    0x18(%r8),%rsi
    a226:	e8 05 00 00 00       	call   a230 <fwp_gc_push>
    a22b:	e9 40 fd ff ff       	jmp    9f70 <fwp_gc_scan+0x60>

000000000000a230 <fwp_gc_push>:
    a230:	41 56                	push   %r14
    a232:	53                   	push   %rbx
    a233:	50                   	push   %rax
    a234:	48 89 f3             	mov    %rsi,%rbx
    a237:	49 89 fe             	mov    %rdi,%r14
    a23a:	48 8b 0d e7 11 01 00 	mov    0x111e7(%rip),%rcx        # 1b428 <fwp_gc+0x11a0>
    a241:	48 8b 05 d8 11 01 00 	mov    0x111d8(%rip),%rax        # 1b420 <fwp_gc+0x1198>
    a248:	48 3b 0d e1 11 01 00 	cmp    0x111e1(%rip),%rcx        # 1b430 <fwp_gc+0x11a8>
    a24f:	75 36                	jne    a287 <fwp_gc_push+0x57>
    a251:	48 8d 14 09          	lea    (%rcx,%rcx,1),%rdx
    a255:	48 85 c9             	test   %rcx,%rcx
    a258:	be 00 10 00 00       	mov    $0x1000,%esi
    a25d:	48 0f 45 f2          	cmovne %rdx,%rsi
    a261:	48 89 35 c8 11 01 00 	mov    %rsi,0x111c8(%rip)        # 1b430 <fwp_gc+0x11a8>
    a268:	48 c1 e6 04          	shl    $0x4,%rsi
    a26c:	48 89 c7             	mov    %rax,%rdi
    a26f:	e8 0c 91 ff ff       	call   3380 <realloc@plt>
    a274:	48 89 05 a5 11 01 00 	mov    %rax,0x111a5(%rip)        # 1b420 <fwp_gc+0x1198>
    a27b:	48 85 c0             	test   %rax,%rax
    a27e:	74 29                	je     a2a9 <fwp_gc_push+0x79>
    a280:	48 8b 0d a1 11 01 00 	mov    0x111a1(%rip),%rcx        # 1b428 <fwp_gc+0x11a0>
    a287:	48 89 ca             	mov    %rcx,%rdx
    a28a:	48 c1 e2 04          	shl    $0x4,%rdx
    a28e:	4c 89 34 10          	mov    %r14,(%rax,%rdx,1)
    a292:	48 89 5c 10 08       	mov    %rbx,0x8(%rax,%rdx,1)
    a297:	48 ff c1             	inc    %rcx
    a29a:	48 89 0d 87 11 01 00 	mov    %rcx,0x11187(%rip)        # 1b428 <fwp_gc+0x11a0>
    a2a1:	48 83 c4 08          	add    $0x8,%rsp
    a2a5:	5b                   	pop    %rbx
    a2a6:	41 5e                	pop    %r14
    a2a8:	c3                   	ret
    a2a9:	48 8b 05 28 fd 00 00 	mov    0xfd28(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a2b0:	48 8b 08             	mov    (%rax),%rcx
    a2b3:	48 8d 3d 37 b8 00 00 	lea    0xb837(%rip),%rdi        # 15af1 <exec_in_fp0+0x281>
    a2ba:	be 13 00 00 00       	mov    $0x13,%esi
    a2bf:	ba 01 00 00 00       	mov    $0x1,%edx
    a2c4:	e8 b7 91 ff ff       	call   3480 <fwrite@plt>
    a2c9:	bf 66 00 00 00       	mov    $0x66,%edi
    a2ce:	e8 8d 91 ff ff       	call   3460 <exit@plt>
    a2d3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a2da:	84 00 00 00 00 00 

000000000000a2e0 <fwp_closure_drop>:
    a2e0:	41 57                	push   %r15
    a2e2:	41 56                	push   %r14
    a2e4:	53                   	push   %rbx
    a2e5:	48 81 ec 30 02 00 00 	sub    $0x230,%rsp
    a2ec:	48 89 f8             	mov    %rdi,%rax
    a2ef:	48 2b 05 c2 0f 01 00 	sub    0x10fc2(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    a2f6:	48 8b 0d e3 0f 01 00 	mov    0x10fe3(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    a2fd:	48 c1 e1 10          	shl    $0x10,%rcx
    a301:	48 39 c8             	cmp    %rcx,%rax
    a304:	0f 83 91 00 00 00    	jae    a39b <fwp_closure_drop+0xbb>
    a30a:	48 89 fe             	mov    %rdi,%rsi
    a30d:	48 8b 0d ec 0f 01 00 	mov    0x10fec(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    a314:	48 89 c2             	mov    %rax,%rdx
    a317:	48 c1 ea 10          	shr    $0x10,%rdx
    a31b:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a322:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
    a326:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a32c:	75 13                	jne    a341 <fwp_closure_drop+0x61>
    a32e:	40 80 ff 02          	cmp    $0x2,%dil
    a332:	75 0d                	jne    a341 <fwp_closure_drop+0x61>
    a334:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    a338:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    a33f:	eb 20                	jmp    a361 <fwp_closure_drop+0x81>
    a341:	40 80 ff 01          	cmp    $0x1,%dil
    a345:	75 54                	jne    a39b <fwp_closure_drop+0xbb>
    a347:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    a34b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a34f:	48 0f af c1          	imul   %rcx,%rax
    a353:	48 c1 e8 20          	shr    $0x20,%rax
    a357:	48 01 c7             	add    %rax,%rdi
    a35a:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    a361:	0f b6 07             	movzbl (%rdi),%eax
    a364:	85 c0                	test   %eax,%eax
    a366:	74 33                	je     a39b <fwp_closure_drop+0xbb>
    a368:	83 f8 01             	cmp    $0x1,%eax
    a36b:	75 1f                	jne    a38c <fwp_closure_drop+0xac>
    a36d:	64 48 8b 3c 25 f8 ff 	mov    %fs:0xfffffffffffffff8,%rdi
    a374:	ff ff 
    a376:	48 85 ff             	test   %rdi,%rdi
    a379:	74 2d                	je     a3a8 <fwp_closure_drop+0xc8>
    a37b:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    a382:	5b                   	pop    %rbx
    a383:	41 5e                	pop    %r14
    a385:	41 5f                	pop    %r15
    a387:	e9 44 01 00 00       	jmp    a4d0 <fwp_closure_drop_push>
    a38c:	3d ff 00 00 00       	cmp    $0xff,%eax
    a391:	0f 84 e7 00 00 00    	je     a47e <fwp_closure_drop+0x19e>
    a397:	fe c8                	dec    %al
    a399:	88 07                	mov    %al,(%rdi)
    a39b:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    a3a2:	5b                   	pop    %rbx
    a3a3:	41 5e                	pop    %r14
    a3a5:	41 5f                	pop    %r15
    a3a7:	c3                   	ret
    a3a8:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
    a3af:	00 00 
    a3b1:	4c 8d b0 f8 ff ff ff 	lea    -0x8(%rax),%r14
    a3b8:	48 8d 5c 24 30       	lea    0x30(%rsp),%rbx
    a3bd:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    a3c2:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    a3c9:	00 00 
    a3cb:	48 c7 44 24 28 40 00 	movq   $0x40,0x28(%rsp)
    a3d2:	00 00 
    a3d4:	48 8b 05 e5 1a 01 00 	mov    0x11ae5(%rip),%rax        # 1bec0 <fwp_cleanups>
    a3db:	48 89 04 24          	mov    %rax,(%rsp)
    a3df:	48 8d 05 ca 01 00 00 	lea    0x1ca(%rip),%rax        # a5b0 <fwp_closure_drop_release>
    a3e6:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    a3eb:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    a3f0:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    a3f5:	49 89 e7             	mov    %rsp,%r15
    a3f8:	4c 89 3d c1 1a 01 00 	mov    %r15,0x11ac1(%rip)        # 1bec0 <fwp_cleanups>
    a3ff:	49 89 3e             	mov    %rdi,(%r14)
    a402:	e8 c9 00 00 00       	call   a4d0 <fwp_closure_drop_push>
    a407:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    a40e:	00 00 
    a410:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    a415:	48 85 c0             	test   %rax,%rax
    a418:	74 31                	je     a44b <fwp_closure_drop+0x16b>
    a41a:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    a41f:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    a423:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
    a428:	48 8b 7c c1 f8       	mov    -0x8(%rcx,%rax,8),%rdi
    a42d:	48 8b 05 3c 1a 01 00 	mov    0x11a3c(%rip),%rax        # 1be70 <fwp_fns>
    a434:	8b 0f                	mov    (%rdi),%ecx
    a436:	48 c1 e1 05          	shl    $0x5,%rcx
    a43a:	48 8b 44 08 18       	mov    0x18(%rax,%rcx,1),%rax
    a43f:	48 85 c0             	test   %rax,%rax
    a442:	74 4b                	je     a48f <fwp_closure_drop+0x1af>
    a444:	31 f6                	xor    %esi,%esi
    a446:	ff 50 08             	call   *0x8(%rax)
    a449:	eb c5                	jmp    a410 <fwp_closure_drop+0x130>
    a44b:	4c 39 3d 6e 1a 01 00 	cmp    %r15,0x11a6e(%rip)        # 1bec0 <fwp_cleanups>
    a452:	75 69                	jne    a4bd <fwp_closure_drop+0x1dd>
    a454:	48 8b 04 24          	mov    (%rsp),%rax
    a458:	48 89 05 61 1a 01 00 	mov    %rax,0x11a61(%rip)        # 1bec0 <fwp_cleanups>
    a45f:	49 c7 06 00 00 00 00 	movq   $0x0,(%r14)
    a466:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    a46b:	48 39 df             	cmp    %rbx,%rdi
    a46e:	0f 84 27 ff ff ff    	je     a39b <fwp_closure_drop+0xbb>
    a474:	e8 d7 8b ff ff       	call   3050 <free@plt>
    a479:	e9 1d ff ff ff       	jmp    a39b <fwp_closure_drop+0xbb>
    a47e:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    a485:	5b                   	pop    %rbx
    a486:	41 5e                	pop    %r14
    a488:	41 5f                	pop    %r15
    a48a:	e9 61 01 00 00       	jmp    a5f0 <fwp_rc_wide_drop>
    a48f:	e8 5c c7 ff ff       	call   6bf0 <fwp_flush>
    a494:	48 8b 05 3d fb 00 00 	mov    0xfb3d(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a49b:	48 8b 38             	mov    (%rax),%rdi
    a49e:	48 8d 35 f4 b5 00 00 	lea    0xb5f4(%rip),%rsi        # 15a99 <exec_in_fp0+0x229>
    a4a5:	48 8d 15 0b b7 00 00 	lea    0xb70b(%rip),%rdx        # 15bb7 <exec_in_fp0+0x347>
    a4ac:	31 c0                	xor    %eax,%eax
    a4ae:	e8 3d 8e ff ff       	call   32f0 <fprintf@plt>
    a4b3:	bf 65 00 00 00       	mov    $0x65,%edi
    a4b8:	e8 a3 8f ff ff       	call   3460 <exit@plt>
    a4bd:	e8 ae 8b ff ff       	call   3070 <abort@plt>
    a4c2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a4c9:	1f 84 00 00 00 00 00 

000000000000a4d0 <fwp_closure_drop_push>:
    a4d0:	55                   	push   %rbp
    a4d1:	41 57                	push   %r15
    a4d3:	41 56                	push   %r14
    a4d5:	41 55                	push   %r13
    a4d7:	41 54                	push   %r12
    a4d9:	53                   	push   %rbx
    a4da:	50                   	push   %rax
    a4db:	48 89 f3             	mov    %rsi,%rbx
    a4de:	49 89 fe             	mov    %rdi,%r14
    a4e1:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    a4e5:	4c 3b 6f 10          	cmp    0x10(%rdi),%r13
    a4e9:	75 59                	jne    a544 <fwp_closure_drop_push+0x74>
    a4eb:	4c 89 e8             	mov    %r13,%rax
    a4ee:	48 c1 e8 3c          	shr    $0x3c,%rax
    a4f2:	75 6e                	jne    a562 <fwp_closure_drop_push+0x92>
    a4f4:	4c 89 ef             	mov    %r13,%rdi
    a4f7:	48 c1 e7 04          	shl    $0x4,%rdi
    a4fb:	e8 40 8e ff ff       	call   3340 <malloc@plt>
    a500:	48 85 c0             	test   %rax,%rax
    a503:	74 7c                	je     a581 <fwp_closure_drop_push+0xb1>
    a505:	49 89 c7             	mov    %rax,%r15
    a508:	4a 8d 2c 6d 00 00 00 	lea    0x0(,%r13,2),%rbp
    a50f:	00 
    a510:	4d 8b 26             	mov    (%r14),%r12
    a513:	4a 8d 14 ed 00 00 00 	lea    0x0(,%r13,8),%rdx
    a51a:	00 
    a51b:	48 89 c7             	mov    %rax,%rdi
    a51e:	4c 89 e6             	mov    %r12,%rsi
    a521:	e8 0a 8e ff ff       	call   3330 <memcpy@plt>
    a526:	49 8d 46 18          	lea    0x18(%r14),%rax
    a52a:	49 39 c4             	cmp    %rax,%r12
    a52d:	74 0c                	je     a53b <fwp_closure_drop_push+0x6b>
    a52f:	4c 89 e7             	mov    %r12,%rdi
    a532:	e8 19 8b ff ff       	call   3050 <free@plt>
    a537:	4d 8b 6e 08          	mov    0x8(%r14),%r13
    a53b:	4d 89 3e             	mov    %r15,(%r14)
    a53e:	49 89 6e 10          	mov    %rbp,0x10(%r14)
    a542:	eb 03                	jmp    a547 <fwp_closure_drop_push+0x77>
    a544:	4d 8b 3e             	mov    (%r14),%r15
    a547:	49 8d 45 01          	lea    0x1(%r13),%rax
    a54b:	49 89 46 08          	mov    %rax,0x8(%r14)
    a54f:	4b 89 1c ef          	mov    %rbx,(%r15,%r13,8)
    a553:	48 83 c4 08          	add    $0x8,%rsp
    a557:	5b                   	pop    %rbx
    a558:	41 5c                	pop    %r12
    a55a:	41 5d                	pop    %r13
    a55c:	41 5e                	pop    %r14
    a55e:	41 5f                	pop    %r15
    a560:	5d                   	pop    %rbp
    a561:	c3                   	ret
    a562:	e8 89 c6 ff ff       	call   6bf0 <fwp_flush>
    a567:	48 8b 05 6a fa 00 00 	mov    0xfa6a(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a56e:	48 8b 38             	mov    (%rax),%rdi
    a571:	48 8d 35 21 b5 00 00 	lea    0xb521(%rip),%rsi        # 15a99 <exec_in_fp0+0x229>
    a578:	48 8d 15 66 b6 00 00 	lea    0xb666(%rip),%rdx        # 15be5 <exec_in_fp0+0x375>
    a57f:	eb 1d                	jmp    a59e <fwp_closure_drop_push+0xce>
    a581:	e8 6a c6 ff ff       	call   6bf0 <fwp_flush>
    a586:	48 8b 05 4b fa 00 00 	mov    0xfa4b(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a58d:	48 8b 38             	mov    (%rax),%rdi
    a590:	48 8d 35 02 b5 00 00 	lea    0xb502(%rip),%rsi        # 15a99 <exec_in_fp0+0x229>
    a597:	48 8d 15 61 b6 00 00 	lea    0xb661(%rip),%rdx        # 15bff <exec_in_fp0+0x38f>
    a59e:	31 c0                	xor    %eax,%eax
    a5a0:	e8 4b 8d ff ff       	call   32f0 <fprintf@plt>
    a5a5:	bf 65 00 00 00       	mov    $0x65,%edi
    a5aa:	e8 b1 8e ff ff       	call   3460 <exit@plt>
    a5af:	90                   	nop

000000000000a5b0 <fwp_closure_drop_release>:
    a5b0:	41 56                	push   %r14
    a5b2:	53                   	push   %rbx
    a5b3:	50                   	push   %rax
    a5b4:	48 89 fb             	mov    %rdi,%rbx
    a5b7:	64 48 c7 04 25 f8 ff 	movq   $0x0,%fs:0xfffffffffffffff8
    a5be:	ff ff 00 00 00 00 
    a5c4:	48 8b 3f             	mov    (%rdi),%rdi
    a5c7:	4c 8d 73 18          	lea    0x18(%rbx),%r14
    a5cb:	4c 39 f7             	cmp    %r14,%rdi
    a5ce:	74 05                	je     a5d5 <fwp_closure_drop_release+0x25>
    a5d0:	e8 7b 8a ff ff       	call   3050 <free@plt>
    a5d5:	4c 89 33             	mov    %r14,(%rbx)
    a5d8:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
    a5df:	00 
    a5e0:	48 83 c4 08          	add    $0x8,%rsp
    a5e4:	5b                   	pop    %rbx
    a5e5:	41 5e                	pop    %r14
    a5e7:	c3                   	ret
    a5e8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a5ef:	00 

000000000000a5f0 <fwp_rc_wide_drop>:
    a5f0:	53                   	push   %rbx
    a5f1:	48 89 f8             	mov    %rdi,%rax
    a5f4:	48 c1 e8 11          	shr    $0x11,%rax
    a5f8:	31 f8                	xor    %edi,%eax
    a5fa:	89 c1                	mov    %eax,%ecx
    a5fc:	c1 e9 09             	shr    $0x9,%ecx
    a5ff:	31 c1                	xor    %eax,%ecx
    a601:	0f b6 c1             	movzbl %cl,%eax
    a604:	48 8d 0d 7d fc 00 00 	lea    0xfc7d(%rip),%rcx        # 1a288 <fwp_gc>
    a60b:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    a612:	00 
    a613:	48 85 c0             	test   %rax,%rax
    a616:	74 16                	je     a62e <fwp_rc_wide_drop+0x3e>
    a618:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a61f:	00 
    a620:	48 39 38             	cmp    %rdi,(%rax)
    a623:	74 37                	je     a65c <fwp_rc_wide_drop+0x6c>
    a625:	48 8b 40 10          	mov    0x10(%rax),%rax
    a629:	48 85 c0             	test   %rax,%rax
    a62c:	75 f2                	jne    a620 <fwp_rc_wide_drop+0x30>
    a62e:	e8 bd c5 ff ff       	call   6bf0 <fwp_flush>
    a633:	48 8b 05 9e f9 00 00 	mov    0xf99e(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a63a:	48 8b 38             	mov    (%rax),%rdi
    a63d:	48 8d 35 55 b4 00 00 	lea    0xb455(%rip),%rsi        # 15a99 <exec_in_fp0+0x229>
    a644:	48 8d 15 27 b4 00 00 	lea    0xb427(%rip),%rdx        # 15a72 <exec_in_fp0+0x202>
    a64b:	31 c0                	xor    %eax,%eax
    a64d:	e8 9e 8c ff ff       	call   32f0 <fprintf@plt>
    a652:	bf 65 00 00 00       	mov    $0x65,%edi
    a657:	e8 04 8e ff ff       	call   3460 <exit@plt>
    a65c:	48 8b 48 08          	mov    0x8(%rax),%rcx
    a660:	48 ff c9             	dec    %rcx
    a663:	48 89 48 08          	mov    %rcx,0x8(%rax)
    a667:	48 81 f9 fe 00 00 00 	cmp    $0xfe,%rcx
    a66e:	75 0b                	jne    a67b <fwp_rc_wide_drop+0x8b>
    a670:	48 89 fb             	mov    %rdi,%rbx
    a673:	e8 c8 c4 ff ff       	call   6b40 <fwp_rc_forget_slot>
    a678:	c6 03 fe             	movb   $0xfe,(%rbx)
    a67b:	5b                   	pop    %rbx
    a67c:	c3                   	ret
    a67d:	0f 1f 00             	nopl   (%rax)

000000000000a680 <fwp_rc_wide_dup>:
    a680:	41 56                	push   %r14
    a682:	53                   	push   %rbx
    a683:	50                   	push   %rax
    a684:	48 89 fb             	mov    %rdi,%rbx
    a687:	48 89 f8             	mov    %rdi,%rax
    a68a:	48 c1 e8 11          	shr    $0x11,%rax
    a68e:	31 d8                	xor    %ebx,%eax
    a690:	89 c1                	mov    %eax,%ecx
    a692:	c1 e9 09             	shr    $0x9,%ecx
    a695:	31 c1                	xor    %eax,%ecx
    a697:	0f b6 c1             	movzbl %cl,%eax
    a69a:	48 8d 0d e7 fb 00 00 	lea    0xfbe7(%rip),%rcx        # 1a288 <fwp_gc>
    a6a1:	4c 8d 34 c1          	lea    (%rcx,%rax,8),%r14
    a6a5:	49 81 c6 18 12 00 00 	add    $0x1218,%r14
    a6ac:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    a6b3:	00 
    a6b4:	48 85 c0             	test   %rax,%rax
    a6b7:	74 1a                	je     a6d3 <fwp_rc_wide_dup+0x53>
    a6b9:	48 39 18             	cmp    %rbx,(%rax)
    a6bc:	74 22                	je     a6e0 <fwp_rc_wide_dup+0x60>
    a6be:	66 90                	xchg   %ax,%ax
    a6c0:	49 89 c6             	mov    %rax,%r14
    a6c3:	48 8b 40 10          	mov    0x10(%rax),%rax
    a6c7:	48 85 c0             	test   %rax,%rax
    a6ca:	74 0e                	je     a6da <fwp_rc_wide_dup+0x5a>
    a6cc:	48 39 18             	cmp    %rbx,(%rax)
    a6cf:	75 ef                	jne    a6c0 <fwp_rc_wide_dup+0x40>
    a6d1:	eb 09                	jmp    a6dc <fwp_rc_wide_dup+0x5c>
    a6d3:	80 3b fe             	cmpb   $0xfe,(%rbx)
    a6d6:	74 16                	je     a6ee <fwp_rc_wide_dup+0x6e>
    a6d8:	eb 6d                	jmp    a747 <fwp_rc_wide_dup+0xc7>
    a6da:	31 c0                	xor    %eax,%eax
    a6dc:	49 83 c6 10          	add    $0x10,%r14
    a6e0:	80 3b fe             	cmpb   $0xfe,(%rbx)
    a6e3:	75 41                	jne    a726 <fwp_rc_wide_dup+0xa6>
    a6e5:	48 85 c0             	test   %rax,%rax
    a6e8:	0f 85 a2 00 00 00    	jne    a790 <fwp_rc_wide_dup+0x110>
    a6ee:	bf 18 00 00 00       	mov    $0x18,%edi
    a6f3:	e8 48 8c ff ff       	call   3340 <malloc@plt>
    a6f8:	48 85 c0             	test   %rax,%rax
    a6fb:	74 69                	je     a766 <fwp_rc_wide_dup+0xe6>
    a6fd:	48 89 18             	mov    %rbx,(%rax)
    a700:	48 c7 40 08 ff 00 00 	movq   $0xff,0x8(%rax)
    a707:	00 
    a708:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
    a70f:	00 
    a710:	49 89 06             	mov    %rax,(%r14)
    a713:	c6 03 ff             	movb   $0xff,(%rbx)
    a716:	48 8d 05 83 15 01 00 	lea    0x11583(%rip),%rax        # 1bca0 <fwp_gc+0x1a18>
    a71d:	48 8b 0d 7c 15 01 00 	mov    0x1157c(%rip),%rcx        # 1bca0 <fwp_gc+0x1a18>
    a724:	eb 13                	jmp    a739 <fwp_rc_wide_dup+0xb9>
    a726:	48 85 c0             	test   %rax,%rax
    a729:	74 1c                	je     a747 <fwp_rc_wide_dup+0xc7>
    a72b:	48 8b 48 08          	mov    0x8(%rax),%rcx
    a72f:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
    a733:	74 7a                	je     a7af <fwp_rc_wide_dup+0x12f>
    a735:	48 83 c0 08          	add    $0x8,%rax
    a739:	48 ff c1             	inc    %rcx
    a73c:	48 89 08             	mov    %rcx,(%rax)
    a73f:	48 83 c4 08          	add    $0x8,%rsp
    a743:	5b                   	pop    %rbx
    a744:	41 5e                	pop    %r14
    a746:	c3                   	ret
    a747:	e8 a4 c4 ff ff       	call   6bf0 <fwp_flush>
    a74c:	48 8b 05 85 f8 00 00 	mov    0xf885(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a753:	48 8b 38             	mov    (%rax),%rdi
    a756:	48 8d 35 3c b3 00 00 	lea    0xb33c(%rip),%rsi        # 15a99 <exec_in_fp0+0x229>
    a75d:	48 8d 15 0e b3 00 00 	lea    0xb30e(%rip),%rdx        # 15a72 <exec_in_fp0+0x202>
    a764:	eb 66                	jmp    a7cc <fwp_rc_wide_dup+0x14c>
    a766:	48 8b 05 6b f8 00 00 	mov    0xf86b(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a76d:	48 8b 08             	mov    (%rax),%rcx
    a770:	48 8d 3d 7a b3 00 00 	lea    0xb37a(%rip),%rdi        # 15af1 <exec_in_fp0+0x281>
    a777:	be 13 00 00 00       	mov    $0x13,%esi
    a77c:	ba 01 00 00 00       	mov    $0x1,%edx
    a781:	e8 fa 8c ff ff       	call   3480 <fwrite@plt>
    a786:	bf 66 00 00 00       	mov    $0x66,%edi
    a78b:	e8 d0 8c ff ff       	call   3460 <exit@plt>
    a790:	e8 5b c4 ff ff       	call   6bf0 <fwp_flush>
    a795:	48 8b 05 3c f8 00 00 	mov    0xf83c(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a79c:	48 8b 38             	mov    (%rax),%rdi
    a79f:	48 8d 35 f3 b2 00 00 	lea    0xb2f3(%rip),%rsi        # 15a99 <exec_in_fp0+0x229>
    a7a6:	48 8d 15 60 b4 00 00 	lea    0xb460(%rip),%rdx        # 15c0d <exec_in_fp0+0x39d>
    a7ad:	eb 1d                	jmp    a7cc <fwp_rc_wide_dup+0x14c>
    a7af:	e8 3c c4 ff ff       	call   6bf0 <fwp_flush>
    a7b4:	48 8b 05 1d f8 00 00 	mov    0xf81d(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a7bb:	48 8b 38             	mov    (%rax),%rdi
    a7be:	48 8d 35 d4 b2 00 00 	lea    0xb2d4(%rip),%rsi        # 15a99 <exec_in_fp0+0x229>
    a7c5:	48 8d 15 66 b4 00 00 	lea    0xb466(%rip),%rdx        # 15c32 <exec_in_fp0+0x3c2>
    a7cc:	31 c0                	xor    %eax,%eax
    a7ce:	e8 1d 8b ff ff       	call   32f0 <fprintf@plt>
    a7d3:	bf 65 00 00 00       	mov    $0x65,%edi
    a7d8:	e8 83 8c ff ff       	call   3460 <exit@plt>
    a7dd:	0f 1f 00             	nopl   (%rax)

000000000000a7e0 <fwp_alloc_init>:
    a7e0:	53                   	push   %rbx
    a7e1:	48 ff 05 c0 16 01 00 	incq   0x116c0(%rip)        # 1bea8 <measured_calls>
    a7e8:	48 01 3d c1 16 01 00 	add    %rdi,0x116c1(%rip)        # 1beb0 <measured_bytes>
    a7ef:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    a7f6:	0f 87 f2 00 00 00    	ja     a8ee <fwp_alloc_init+0x10e>
    a7fc:	48 8d 77 0f          	lea    0xf(%rdi),%rsi
    a800:	48 c1 ee 04          	shr    $0x4,%rsi
    a804:	48 8d 05 7d fa 00 00 	lea    0xfa7d(%rip),%rax        # 1a288 <fwp_gc>
    a80b:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    a812:	00 
    a813:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    a81a:	4c 8b 05 67 fa 00 00 	mov    0xfa67(%rip),%r8        # 1a288 <fwp_gc>
    a821:	4d 89 c1             	mov    %r8,%r9
    a824:	49 29 d1             	sub    %rdx,%r9
    a827:	4c 89 0d 5a fa 00 00 	mov    %r9,0xfa5a(%rip)        # 1a288 <fwp_gc>
    a82e:	0f 88 ba 00 00 00    	js     a8ee <fwp_alloc_init+0x10e>
    a834:	4c 8d 0c 49          	lea    (%rcx,%rcx,2),%r9
    a838:	4e 8d 14 c8          	lea    (%rax,%r9,8),%r10
    a83c:	49 83 c2 08          	add    $0x8,%r10
    a840:	49 8b 1a             	mov    (%r10),%rbx
    a843:	48 85 db             	test   %rbx,%rbx
    a846:	74 35                	je     a87d <fwp_alloc_init+0x9d>
    a848:	48 8b 03             	mov    (%rbx),%rax
    a84b:	48 f7 d0             	not    %rax
    a84e:	49 89 02             	mov    %rax,(%r10)
    a851:	81 e7 f8 7f 00 00    	and    $0x7ff8,%edi
    a857:	48 39 d7             	cmp    %rdx,%rdi
    a85a:	0f 83 af 00 00 00    	jae    a90f <fwp_alloc_init+0x12f>
    a860:	48 8d 04 3b          	lea    (%rbx,%rdi,1),%rax
    a864:	48 f7 d7             	not    %rdi
    a867:	48 01 d7             	add    %rdx,%rdi
    a86a:	48 83 e7 f8          	and    $0xfffffffffffffff8,%rdi
    a86e:	48 83 c7 08          	add    $0x8,%rdi
    a872:	48 89 fa             	mov    %rdi,%rdx
    a875:	48 89 c7             	mov    %rax,%rdi
    a878:	e9 8b 00 00 00       	jmp    a908 <fwp_alloc_init+0x128>
    a87d:	4a 8b 5c c8 10       	mov    0x10(%rax,%r9,8),%rbx
    a882:	4e 8b 54 c8 18       	mov    0x18(%rax,%r9,8),%r10
    a887:	49 29 da             	sub    %rbx,%r10
    a88a:	49 39 d2             	cmp    %rdx,%r10
    a88d:	72 2f                	jb     a8be <fwp_alloc_init+0xde>
    a88f:	4a 8d 0c c8          	lea    (%rax,%r9,8),%rcx
    a893:	48 83 c1 10          	add    $0x10,%rcx
    a897:	4c 8d 0c 13          	lea    (%rbx,%rdx,1),%r9
    a89b:	4c 89 09             	mov    %r9,(%rcx)
    a89e:	48 85 db             	test   %rbx,%rbx
    a8a1:	75 ae                	jne    a851 <fwp_alloc_init+0x71>
    a8a3:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    a8aa:	00 
    a8ab:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    a8b2:	49 29 d0             	sub    %rdx,%r8
    a8b5:	4c 89 05 cc f9 00 00 	mov    %r8,0xf9cc(%rip)        # 1a288 <fwp_gc>
    a8bc:	78 30                	js     a8ee <fwp_alloc_init+0x10e>
    a8be:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    a8c2:	48 8b 5c c8 08       	mov    0x8(%rax,%rcx,8),%rbx
    a8c7:	48 85 db             	test   %rbx,%rbx
    a8ca:	74 10                	je     a8dc <fwp_alloc_init+0xfc>
    a8cc:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    a8d0:	48 83 c0 08          	add    $0x8,%rax
    a8d4:	48 8b 0b             	mov    (%rbx),%rcx
    a8d7:	48 f7 d1             	not    %rcx
    a8da:	eb 26                	jmp    a902 <fwp_alloc_init+0x122>
    a8dc:	48 8b 5c c8 10       	mov    0x10(%rax,%rcx,8),%rbx
    a8e1:	48 8b 74 c8 18       	mov    0x18(%rax,%rcx,8),%rsi
    a8e6:	48 29 de             	sub    %rbx,%rsi
    a8e9:	48 39 d6             	cmp    %rdx,%rsi
    a8ec:	73 08                	jae    a8f6 <fwp_alloc_init+0x116>
    a8ee:	31 f6                	xor    %esi,%esi
    a8f0:	5b                   	pop    %rbx
    a8f1:	e9 ca d9 ff ff       	jmp    82c0 <fwp_gc_alloc_slow>
    a8f6:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    a8fa:	48 83 c0 10          	add    $0x10,%rax
    a8fe:	48 8d 0c 13          	lea    (%rbx,%rdx,1),%rcx
    a902:	48 89 08             	mov    %rcx,(%rax)
    a905:	48 89 df             	mov    %rbx,%rdi
    a908:	31 f6                	xor    %esi,%esi
    a90a:	e8 01 89 ff ff       	call   3210 <memset@plt>
    a90f:	48 89 d8             	mov    %rbx,%rax
    a912:	5b                   	pop    %rbx
    a913:	c3                   	ret
    a914:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    a91b:	00 00 00 00 00 

000000000000a920 <fwp_rc_cleanup_cell>:
    a920:	48 89 f8             	mov    %rdi,%rax
    a923:	48 8b 3f             	mov    (%rdi),%rdi
    a926:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    a92d:	48 85 ff             	test   %rdi,%rdi
    a930:	75 0e                	jne    a940 <fwp_rc_free_obj>
    a932:	c3                   	ret
    a933:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a93a:	84 00 00 00 00 00 

000000000000a940 <fwp_rc_free_obj>:
    a940:	48 89 f8             	mov    %rdi,%rax
    a943:	48 2b 05 6e 09 01 00 	sub    0x1096e(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    a94a:	48 8b 0d 8f 09 01 00 	mov    0x1098f(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    a951:	48 c1 e1 10          	shl    $0x10,%rcx
    a955:	48 39 c8             	cmp    %rcx,%rax
    a958:	0f 83 b8 01 00 00    	jae    ab16 <fwp_rc_free_obj+0x1d6>
    a95e:	55                   	push   %rbp
    a95f:	41 57                	push   %r15
    a961:	41 56                	push   %r14
    a963:	53                   	push   %rbx
    a964:	50                   	push   %rax
    a965:	48 8b 1d 94 09 01 00 	mov    0x10994(%rip),%rbx        # 1b300 <fwp_gc+0x1078>
    a96c:	48 89 c1             	mov    %rax,%rcx
    a96f:	48 c1 e9 10          	shr    $0x10,%rcx
    a973:	4c 69 f1 28 12 00 00 	imul   $0x1228,%rcx,%r14
    a97a:	42 0f b6 2c 33       	movzbl (%rbx,%r14,1),%ebp
    a97f:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a985:	75 1a                	jne    a9a1 <fwp_rc_free_obj+0x61>
    a987:	40 80 fd 02          	cmp    $0x2,%bpl
    a98b:	75 14                	jne    a9a1 <fwp_rc_free_obj+0x61>
    a98d:	4a 8d 04 33          	lea    (%rbx,%r14,1),%rax
    a991:	48 05 28 02 00 00    	add    $0x228,%rax
    a997:	80 38 01             	cmpb   $0x1,(%rax)
    a99a:	74 32                	je     a9ce <fwp_rc_free_obj+0x8e>
    a99c:	e9 6b 01 00 00       	jmp    ab0c <fwp_rc_free_obj+0x1cc>
    a9a1:	40 80 fd 01          	cmp    $0x1,%bpl
    a9a5:	0f 85 61 01 00 00    	jne    ab0c <fwp_rc_free_obj+0x1cc>
    a9ab:	4a 8d 0c 33          	lea    (%rbx,%r14,1),%rcx
    a9af:	42 8b 54 33 20       	mov    0x20(%rbx,%r14,1),%edx
    a9b4:	48 0f af c2          	imul   %rdx,%rax
    a9b8:	48 c1 e8 20          	shr    $0x20,%rax
    a9bc:	48 01 c8             	add    %rcx,%rax
    a9bf:	48 05 28 02 00 00    	add    $0x228,%rax
    a9c5:	80 38 01             	cmpb   $0x1,(%rax)
    a9c8:	0f 85 3e 01 00 00    	jne    ab0c <fwp_rc_free_obj+0x1cc>
    a9ce:	8b 0d 3c 13 01 00    	mov    0x1133c(%rip),%ecx        # 1bd10 <fwp_reuse_verify>
    a9d4:	85 c9                	test   %ecx,%ecx
    a9d6:	0f 88 c3 00 00 00    	js     aa9f <fwp_rc_free_obj+0x15f>
    a9dc:	85 c9                	test   %ecx,%ecx
    a9de:	0f 84 fd 00 00 00    	je     aae1 <fwp_rc_free_obj+0x1a1>
    a9e4:	42 80 7c 33 01 01    	cmpb   $0x1,0x1(%rbx,%r14,1)
    a9ea:	75 0d                	jne    a9f9 <fwp_rc_free_obj+0xb9>
    a9ec:	40 80 fd 02          	cmp    $0x2,%bpl
    a9f0:	75 22                	jne    aa14 <fwp_rc_free_obj+0xd4>
    a9f2:	4a 8b 54 33 18       	mov    0x18(%rbx,%r14,1),%rdx
    a9f7:	eb 20                	jmp    aa19 <fwp_rc_free_obj+0xd9>
    a9f9:	c7 07 ad de 00 00    	movl   $0xdead,(%rdi)
    a9ff:	8b 47 04             	mov    0x4(%rdi),%eax
    aa02:	48 85 c0             	test   %rax,%rax
    aa05:	0f 84 01 01 00 00    	je     ab0c <fwp_rc_free_obj+0x1cc>
    aa0b:	83 f8 04             	cmp    $0x4,%eax
    aa0e:	73 26                	jae    aa36 <fwp_rc_free_obj+0xf6>
    aa10:	31 c9                	xor    %ecx,%ecx
    aa12:	eb 6a                	jmp    aa7e <fwp_rc_free_obj+0x13e>
    aa14:	42 8b 54 33 08       	mov    0x8(%rbx,%r14,1),%edx
    aa19:	48 89 fb             	mov    %rdi,%rbx
    aa1c:	be dd 00 00 00       	mov    $0xdd,%esi
    aa21:	e8 ea 87 ff ff       	call   3210 <memset@plt>
    aa26:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    aa2d:	c6 43 08 00          	movb   $0x0,0x8(%rbx)
    aa31:	e9 d6 00 00 00       	jmp    ab0c <fwp_rc_free_obj+0x1cc>
    aa36:	89 c1                	mov    %eax,%ecx
    aa38:	83 e1 fc             	and    $0xfffffffc,%ecx
    aa3b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    aa42:	00 
    aa43:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    aa47:	31 f6                	xor    %esi,%esi
    aa49:	66 0f 28 05 9f a6 00 	movapd 0xa69f(%rip),%xmm0        # 150f0 <_IO_stdin_used+0xf0>
    aa50:	00 
    aa51:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    aa58:	0f 1f 84 00 00 00 00 
    aa5f:	00 
    aa60:	66 0f 11 44 37 08    	movupd %xmm0,0x8(%rdi,%rsi,1)
    aa66:	66 0f 11 44 37 18    	movupd %xmm0,0x18(%rdi,%rsi,1)
    aa6c:	48 83 c6 20          	add    $0x20,%rsi
    aa70:	48 39 f2             	cmp    %rsi,%rdx
    aa73:	75 eb                	jne    aa60 <fwp_rc_free_obj+0x120>
    aa75:	48 39 c1             	cmp    %rax,%rcx
    aa78:	0f 84 8e 00 00 00    	je     ab0c <fwp_rc_free_obj+0x1cc>
    aa7e:	48 ba ef be ad de ef 	movabs $0xdeadbeefdeadbeef,%rdx
    aa85:	be ad de 
    aa88:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    aa8f:	00 
    aa90:	48 89 54 cf 08       	mov    %rdx,0x8(%rdi,%rcx,8)
    aa95:	48 ff c1             	inc    %rcx
    aa98:	48 39 c8             	cmp    %rcx,%rax
    aa9b:	75 f3                	jne    aa90 <fwp_rc_free_obj+0x150>
    aa9d:	eb 6d                	jmp    ab0c <fwp_rc_free_obj+0x1cc>
    aa9f:	49 89 ff             	mov    %rdi,%r15
    aaa2:	48 8d 3d a2 b1 00 00 	lea    0xb1a2(%rip),%rdi        # 15c4b <exec_in_fp0+0x3db>
    aaa9:	e8 82 85 ff ff       	call   3030 <getenv@plt>
    aaae:	31 c9                	xor    %ecx,%ecx
    aab0:	48 85 c0             	test   %rax,%rax
    aab3:	74 1b                	je     aad0 <fwp_rc_free_obj+0x190>
    aab5:	80 38 00             	cmpb   $0x0,(%rax)
    aab8:	74 16                	je     aad0 <fwp_rc_free_obj+0x190>
    aaba:	48 8d 35 ff bc 00 00 	lea    0xbcff(%rip),%rsi        # 167c0 <exec_in_fp0+0xf50>
    aac1:	48 89 c7             	mov    %rax,%rdi
    aac4:	e8 07 88 ff ff       	call   32d0 <strcmp@plt>
    aac9:	31 c9                	xor    %ecx,%ecx
    aacb:	85 c0                	test   %eax,%eax
    aacd:	0f 95 c1             	setne  %cl
    aad0:	89 0d 3a 12 01 00    	mov    %ecx,0x1123a(%rip)        # 1bd10 <fwp_reuse_verify>
    aad6:	4c 89 ff             	mov    %r15,%rdi
    aad9:	85 c9                	test   %ecx,%ecx
    aadb:	0f 85 03 ff ff ff    	jne    a9e4 <fwp_rc_free_obj+0xa4>
    aae1:	48 8b 1d a0 f7 00 00 	mov    0xf7a0(%rip),%rbx        # 1a288 <fwp_gc>
    aae8:	e8 33 00 00 00       	call   ab20 <fwp_mem_free>
    aaed:	48 8b 05 94 f7 00 00 	mov    0xf794(%rip),%rax        # 1a288 <fwp_gc>
    aaf4:	48 29 d8             	sub    %rbx,%rax
    aaf7:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    aafc:	f2 0f 58 05 8c 09 01 	addsd  0x1098c(%rip),%xmm0        # 1b490 <fwp_gc+0x1208>
    ab03:	00 
    ab04:	f2 0f 11 05 84 09 01 	movsd  %xmm0,0x10984(%rip)        # 1b490 <fwp_gc+0x1208>
    ab0b:	00 
    ab0c:	48 83 c4 08          	add    $0x8,%rsp
    ab10:	5b                   	pop    %rbx
    ab11:	41 5e                	pop    %r14
    ab13:	41 5f                	pop    %r15
    ab15:	5d                   	pop    %rbp
    ab16:	c3                   	ret
    ab17:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    ab1e:	00 00 

000000000000ab20 <fwp_mem_free>:
    ab20:	48 85 ff             	test   %rdi,%rdi
    ab23:	0f 84 17 02 00 00    	je     ad40 <fwp_mem_free+0x220>
    ab29:	48 8b 05 88 07 01 00 	mov    0x10788(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    ab30:	48 89 f9             	mov    %rdi,%rcx
    ab33:	48 29 c1             	sub    %rax,%rcx
    ab36:	48 8b 15 a3 07 01 00 	mov    0x107a3(%rip),%rdx        # 1b2e0 <fwp_gc+0x1058>
    ab3d:	48 c1 e2 10          	shl    $0x10,%rdx
    ab41:	48 39 d1             	cmp    %rdx,%rcx
    ab44:	0f 83 f6 01 00 00    	jae    ad40 <fwp_mem_free+0x220>
    ab4a:	41 57                	push   %r15
    ab4c:	41 56                	push   %r14
    ab4e:	41 55                	push   %r13
    ab50:	41 54                	push   %r12
    ab52:	53                   	push   %rbx
    ab53:	4c 8b 25 a6 07 01 00 	mov    0x107a6(%rip),%r12        # 1b300 <fwp_gc+0x1078>
    ab5a:	4d 85 e4             	test   %r12,%r12
    ab5d:	0f 84 d4 01 00 00    	je     ad37 <fwp_mem_free+0x217>
    ab63:	49 89 cf             	mov    %rcx,%r15
    ab66:	49 c1 ef 10          	shr    $0x10,%r15
    ab6a:	4d 69 f7 28 12 00 00 	imul   $0x1228,%r15,%r14
    ab71:	43 0f b6 14 34       	movzbl (%r12,%r14,1),%edx
    ab76:	83 fa 02             	cmp    $0x2,%edx
    ab79:	0f 84 b9 00 00 00    	je     ac38 <fwp_mem_free+0x118>
    ab7f:	83 fa 01             	cmp    $0x1,%edx
    ab82:	0f 85 af 01 00 00    	jne    ad37 <fwp_mem_free+0x217>
    ab88:	47 0f b6 4c 34 01    	movzbl 0x1(%r12,%r14,1),%r9d
    ab8e:	47 0f b6 44 34 02    	movzbl 0x2(%r12,%r14,1),%r8d
    ab94:	43 8b 74 34 08       	mov    0x8(%r12,%r14,1),%esi
    ab99:	0f b7 c7             	movzwl %di,%eax
    ab9c:	31 d2                	xor    %edx,%edx
    ab9e:	f7 f6                	div    %esi
    aba0:	48 c7 c2 fe ff ff ff 	mov    $0xfffffffffffffffe,%rdx
    aba7:	89 c1                	mov    %eax,%ecx
    aba9:	48 d3 c2             	rol    %cl,%rdx
    abac:	4b 8d 0c 34          	lea    (%r12,%r14,1),%rcx
    abb0:	41 89 c2             	mov    %eax,%r10d
    abb3:	41 c1 ea 03          	shr    $0x3,%r10d
    abb7:	41 81 e2 f8 1f 00 00 	and    $0x1ff8,%r10d
    abbe:	49 21 54 0a 28       	and    %rdx,0x28(%r10,%rcx,1)
    abc3:	49 69 d1 c0 03 00 00 	imul   $0x3c0,%r9,%rdx
    abca:	4c 8d 3d b7 f6 00 00 	lea    0xf6b7(%rip),%r15        # 1a288 <fwp_gc>
    abd1:	49 01 d7             	add    %rdx,%r15
    abd4:	4f 8d 2c 40          	lea    (%r8,%r8,2),%r13
    abd8:	4d 01 e6             	add    %r12,%r14
    abdb:	49 83 c6 08          	add    $0x8,%r14
    abdf:	48 8d 1c 08          	lea    (%rax,%rcx,1),%rbx
    abe3:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    abea:	80 bc 08 28 02 00 00 	cmpb   $0xff,0x228(%rax,%rcx,1)
    abf1:	ff 
    abf2:	0f 84 49 01 00 00    	je     ad41 <fwp_mem_free+0x221>
    abf8:	4f 8d 3c ef          	lea    (%r15,%r13,8),%r15
    abfc:	49 83 c7 08          	add    $0x8,%r15
    ac00:	c6 03 00             	movb   $0x0,(%rbx)
    ac03:	83 3d 82 06 01 00 00 	cmpl   $0x0,0x10682(%rip)        # 1b28c <fwp_gc+0x1004>
    ac0a:	74 12                	je     ac1e <fwp_mem_free+0xfe>
    ac0c:	89 f2                	mov    %esi,%edx
    ac0e:	48 89 fb             	mov    %rdi,%rbx
    ac11:	31 f6                	xor    %esi,%esi
    ac13:	e8 f8 85 ff ff       	call   3210 <memset@plt>
    ac18:	48 89 df             	mov    %rbx,%rdi
    ac1b:	41 8b 36             	mov    (%r14),%esi
    ac1e:	49 8b 07             	mov    (%r15),%rax
    ac21:	48 f7 d0             	not    %rax
    ac24:	48 89 07             	mov    %rax,(%rdi)
    ac27:	49 89 3f             	mov    %rdi,(%r15)
    ac2a:	89 f0                	mov    %esi,%eax
    ac2c:	48 01 05 55 f6 00 00 	add    %rax,0xf655(%rip)        # 1a288 <fwp_gc>
    ac33:	e9 ff 00 00 00       	jmp    ad37 <fwp_mem_free+0x217>
    ac38:	48 81 e1 00 00 ff ff 	and    $0xffffffffffff0000,%rcx
    ac3f:	48 01 c8             	add    %rcx,%rax
    ac42:	48 39 f8             	cmp    %rdi,%rax
    ac45:	0f 85 ec 00 00 00    	jne    ad37 <fwp_mem_free+0x217>
    ac4b:	4b 8b 44 34 18       	mov    0x18(%r12,%r14,1),%rax
    ac50:	48 01 05 31 f6 00 00 	add    %rax,0xf631(%rip)        # 1a288 <fwp_gc>
    ac57:	43 c6 44 34 03 00    	movb   $0x0,0x3(%r12,%r14,1)
    ac5d:	4b 8d 1c 34          	lea    (%r12,%r14,1),%rbx
    ac61:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    ac68:	43 80 bc 34 28 02 00 	cmpb   $0xff,0x228(%r12,%r14,1)
    ac6f:	00 ff 
    ac71:	0f 84 e0 00 00 00    	je     ad57 <fwp_mem_free+0x237>
    ac77:	c6 03 00             	movb   $0x0,(%rbx)
    ac7a:	43 8b 44 34 10       	mov    0x10(%r12,%r14,1),%eax
    ac7f:	48 85 c0             	test   %rax,%rax
    ac82:	0f 84 88 00 00 00    	je     ad10 <fwp_mem_free+0x1f0>
    ac88:	48 8b 0d 71 06 01 00 	mov    0x10671(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    ac8f:	89 c2                	mov    %eax,%edx
    ac91:	83 e2 03             	and    $0x3,%edx
    ac94:	83 f8 04             	cmp    $0x4,%eax
    ac97:	73 04                	jae    ac9d <fwp_mem_free+0x17d>
    ac99:	31 f6                	xor    %esi,%esi
    ac9b:	eb 3b                	jmp    acd8 <fwp_mem_free+0x1b8>
    ac9d:	4a 8d 3c 31          	lea    (%rcx,%r14,1),%rdi
    aca1:	41 89 c0             	mov    %eax,%r8d
    aca4:	41 83 e0 fc          	and    $0xfffffffc,%r8d
    aca8:	31 f6                	xor    %esi,%esi
    acaa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    acb0:	c6 07 00             	movb   $0x0,(%rdi)
    acb3:	c6 87 28 12 00 00 00 	movb   $0x0,0x1228(%rdi)
    acba:	c6 87 50 24 00 00 00 	movb   $0x0,0x2450(%rdi)
    acc1:	c6 87 78 36 00 00 00 	movb   $0x0,0x3678(%rdi)
    acc8:	48 83 c6 04          	add    $0x4,%rsi
    accc:	48 81 c7 a0 48 00 00 	add    $0x48a0,%rdi
    acd3:	49 39 f0             	cmp    %rsi,%r8
    acd6:	75 d8                	jne    acb0 <fwp_mem_free+0x190>
    acd8:	48 85 d2             	test   %rdx,%rdx
    acdb:	74 33                	je     ad10 <fwp_mem_free+0x1f0>
    acdd:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    ace4:	4c 01 f6             	add    %r14,%rsi
    ace7:	48 01 f1             	add    %rsi,%rcx
    acea:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    acf1:	31 f6                	xor    %esi,%esi
    acf3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    acfa:	84 00 00 00 00 00 
    ad00:	c6 04 31 00          	movb   $0x0,(%rcx,%rsi,1)
    ad04:	48 81 c6 28 12 00 00 	add    $0x1228,%rsi
    ad0b:	48 39 f2             	cmp    %rsi,%rdx
    ad0e:	75 f0                	jne    ad00 <fwp_mem_free+0x1e0>
    ad10:	48 01 05 51 07 01 00 	add    %rax,0x10751(%rip)        # 1b468 <fwp_gc+0x11e0>
    ad17:	4c 3b 3d da 05 01 00 	cmp    0x105da(%rip),%r15        # 1b2f8 <fwp_gc+0x1070>
    ad1e:	73 07                	jae    ad27 <fwp_mem_free+0x207>
    ad20:	4c 89 3d d1 05 01 00 	mov    %r15,0x105d1(%rip)        # 1b2f8 <fwp_gc+0x1070>
    ad27:	4c 3b 3d c2 05 01 00 	cmp    0x105c2(%rip),%r15        # 1b2f0 <fwp_gc+0x1068>
    ad2e:	73 07                	jae    ad37 <fwp_mem_free+0x217>
    ad30:	4c 89 3d b9 05 01 00 	mov    %r15,0x105b9(%rip)        # 1b2f0 <fwp_gc+0x1068>
    ad37:	5b                   	pop    %rbx
    ad38:	41 5c                	pop    %r12
    ad3a:	41 5d                	pop    %r13
    ad3c:	41 5e                	pop    %r14
    ad3e:	41 5f                	pop    %r15
    ad40:	c3                   	ret
    ad41:	49 89 fc             	mov    %rdi,%r12
    ad44:	48 89 df             	mov    %rbx,%rdi
    ad47:	e8 f4 bd ff ff       	call   6b40 <fwp_rc_forget_slot>
    ad4c:	4c 89 e7             	mov    %r12,%rdi
    ad4f:	41 8b 36             	mov    (%r14),%esi
    ad52:	e9 a1 fe ff ff       	jmp    abf8 <fwp_mem_free+0xd8>
    ad57:	48 89 df             	mov    %rbx,%rdi
    ad5a:	e8 e1 bd ff ff       	call   6b40 <fwp_rc_forget_slot>
    ad5f:	e9 13 ff ff ff       	jmp    ac77 <fwp_mem_free+0x157>
    ad64:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    ad6b:	00 00 00 00 00 

000000000000ad70 <fwp_rc_free_arr>:
    ad70:	48 89 f8             	mov    %rdi,%rax
    ad73:	48 2b 05 3e 05 01 00 	sub    0x1053e(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    ad7a:	48 8b 0d 5f 05 01 00 	mov    0x1055f(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    ad81:	48 c1 e1 10          	shl    $0x10,%rcx
    ad85:	48 39 c8             	cmp    %rcx,%rax
    ad88:	0f 83 e9 00 00 00    	jae    ae77 <fwp_rc_free_arr+0x107>
    ad8e:	53                   	push   %rbx
    ad8f:	48 8b 0d 6a 05 01 00 	mov    0x1056a(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    ad96:	48 89 c2             	mov    %rax,%rdx
    ad99:	48 c1 ea 10          	shr    $0x10,%rdx
    ad9d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    ada4:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    ada8:	48 25 ff ff 00 00    	and    $0xffff,%rax
    adae:	75 1a                	jne    adca <fwp_rc_free_arr+0x5a>
    adb0:	40 80 fe 02          	cmp    $0x2,%sil
    adb4:	75 14                	jne    adca <fwp_rc_free_arr+0x5a>
    adb6:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    adba:	48 05 28 02 00 00    	add    $0x228,%rax
    adc0:	80 38 01             	cmpb   $0x1,(%rax)
    adc3:	74 31                	je     adf6 <fwp_rc_free_arr+0x86>
    adc5:	e9 ac 00 00 00       	jmp    ae76 <fwp_rc_free_arr+0x106>
    adca:	40 80 fe 01          	cmp    $0x1,%sil
    adce:	0f 85 a2 00 00 00    	jne    ae76 <fwp_rc_free_arr+0x106>
    add4:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    add8:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    addc:	48 0f af c1          	imul   %rcx,%rax
    ade0:	48 c1 e8 20          	shr    $0x20,%rax
    ade4:	48 01 f0             	add    %rsi,%rax
    ade7:	48 05 28 02 00 00    	add    $0x228,%rax
    aded:	80 38 01             	cmpb   $0x1,(%rax)
    adf0:	0f 85 80 00 00 00    	jne    ae76 <fwp_rc_free_arr+0x106>
    adf6:	8b 0d 14 0f 01 00    	mov    0x10f14(%rip),%ecx        # 1bd10 <fwp_reuse_verify>
    adfc:	85 c9                	test   %ecx,%ecx
    adfe:	78 0d                	js     ae0d <fwp_rc_free_arr+0x9d>
    ae00:	85 c9                	test   %ecx,%ecx
    ae02:	74 47                	je     ae4b <fwp_rc_free_arr+0xdb>
    ae04:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    ae0b:	eb 69                	jmp    ae76 <fwp_rc_free_arr+0x106>
    ae0d:	48 89 fb             	mov    %rdi,%rbx
    ae10:	48 8d 3d 34 ae 00 00 	lea    0xae34(%rip),%rdi        # 15c4b <exec_in_fp0+0x3db>
    ae17:	e8 14 82 ff ff       	call   3030 <getenv@plt>
    ae1c:	31 c9                	xor    %ecx,%ecx
    ae1e:	48 85 c0             	test   %rax,%rax
    ae21:	74 1b                	je     ae3e <fwp_rc_free_arr+0xce>
    ae23:	80 38 00             	cmpb   $0x0,(%rax)
    ae26:	74 16                	je     ae3e <fwp_rc_free_arr+0xce>
    ae28:	48 8d 35 91 b9 00 00 	lea    0xb991(%rip),%rsi        # 167c0 <exec_in_fp0+0xf50>
    ae2f:	48 89 c7             	mov    %rax,%rdi
    ae32:	e8 99 84 ff ff       	call   32d0 <strcmp@plt>
    ae37:	31 c9                	xor    %ecx,%ecx
    ae39:	85 c0                	test   %eax,%eax
    ae3b:	0f 95 c1             	setne  %cl
    ae3e:	89 0d cc 0e 01 00    	mov    %ecx,0x10ecc(%rip)        # 1bd10 <fwp_reuse_verify>
    ae44:	48 89 df             	mov    %rbx,%rdi
    ae47:	85 c9                	test   %ecx,%ecx
    ae49:	75 b9                	jne    ae04 <fwp_rc_free_arr+0x94>
    ae4b:	48 8b 1d 36 f4 00 00 	mov    0xf436(%rip),%rbx        # 1a288 <fwp_gc>
    ae52:	e8 c9 fc ff ff       	call   ab20 <fwp_mem_free>
    ae57:	48 8b 05 2a f4 00 00 	mov    0xf42a(%rip),%rax        # 1a288 <fwp_gc>
    ae5e:	48 29 d8             	sub    %rbx,%rax
    ae61:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    ae66:	f2 0f 58 05 22 06 01 	addsd  0x10622(%rip),%xmm0        # 1b490 <fwp_gc+0x1208>
    ae6d:	00 
    ae6e:	f2 0f 11 05 1a 06 01 	movsd  %xmm0,0x1061a(%rip)        # 1b490 <fwp_gc+0x1208>
    ae75:	00 
    ae76:	5b                   	pop    %rbx
    ae77:	c3                   	ret
    ae78:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    ae7f:	00 

000000000000ae80 <fwp_owner_release6>:
    ae80:	48 8b 3f             	mov    (%rdi),%rdi
    ae83:	eb 0b                	jmp    ae90 <fwp_drop2>
    ae85:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    ae8c:	00 00 00 00 

000000000000ae90 <fwp_drop2>:
    ae90:	53                   	push   %rbx
    ae91:	48 89 f8             	mov    %rdi,%rax
    ae94:	48 2b 05 1d 04 01 00 	sub    0x1041d(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    ae9b:	48 8b 0d 3e 04 01 00 	mov    0x1043e(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    aea2:	48 c1 e1 10          	shl    $0x10,%rcx
    aea6:	48 39 c8             	cmp    %rcx,%rax
    aea9:	0f 83 9c 00 00 00    	jae    af4b <fwp_drop2+0xbb>
    aeaf:	48 8b 0d 4a 04 01 00 	mov    0x1044a(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    aeb6:	48 89 c2             	mov    %rax,%rdx
    aeb9:	48 c1 ea 10          	shr    $0x10,%rdx
    aebd:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    aec4:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    aec8:	48 25 ff ff 00 00    	and    $0xffff,%rax
    aece:	75 20                	jne    aef0 <fwp_drop2+0x60>
    aed0:	40 80 fe 02          	cmp    $0x2,%sil
    aed4:	75 1a                	jne    aef0 <fwp_drop2+0x60>
    aed6:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    aeda:	48 05 28 02 00 00    	add    $0x228,%rax
    aee0:	eb 2d                	jmp    af0f <fwp_drop2+0x7f>
    aee2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    aee9:	1f 84 00 00 00 00 00 
    aef0:	40 80 fe 01          	cmp    $0x1,%sil
    aef4:	75 55                	jne    af4b <fwp_drop2+0xbb>
    aef6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    aefa:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    aefe:	48 0f af c1          	imul   %rcx,%rax
    af02:	48 c1 e8 20          	shr    $0x20,%rax
    af06:	48 01 f0             	add    %rsi,%rax
    af09:	48 05 28 02 00 00    	add    $0x228,%rax
    af0f:	0f b6 08             	movzbl (%rax),%ecx
    af12:	85 c9                	test   %ecx,%ecx
    af14:	74 35                	je     af4b <fwp_drop2+0xbb>
    af16:	83 f9 01             	cmp    $0x1,%ecx
    af19:	75 32                	jne    af4d <fwp_drop2+0xbd>
    af1b:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    af1f:	79 3a                	jns    af5b <fwp_drop2+0xcb>
    af21:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    af25:	e8 46 fe ff ff       	call   ad70 <fwp_rc_free_arr>
    af2a:	48 89 d8             	mov    %rbx,%rax
    af2d:	48 2b 05 84 03 01 00 	sub    0x10384(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    af34:	48 8b 0d a5 03 01 00 	mov    0x103a5(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    af3b:	48 c1 e1 10          	shl    $0x10,%rcx
    af3f:	48 89 df             	mov    %rbx,%rdi
    af42:	48 39 c8             	cmp    %rcx,%rax
    af45:	0f 82 64 ff ff ff    	jb     aeaf <fwp_drop2+0x1f>
    af4b:	5b                   	pop    %rbx
    af4c:	c3                   	ret
    af4d:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    af53:	74 0c                	je     af61 <fwp_drop2+0xd1>
    af55:	fe c9                	dec    %cl
    af57:	88 08                	mov    %cl,(%rax)
    af59:	5b                   	pop    %rbx
    af5a:	c3                   	ret
    af5b:	5b                   	pop    %rbx
    af5c:	e9 0f fe ff ff       	jmp    ad70 <fwp_rc_free_arr>
    af61:	48 89 c7             	mov    %rax,%rdi
    af64:	5b                   	pop    %rbx
    af65:	e9 86 f6 ff ff       	jmp    a5f0 <fwp_rc_wide_drop>
    af6a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000af70 <fwp_owner_release7>:
    af70:	48 8b 3f             	mov    (%rdi),%rdi
    af73:	e9 18 ff ff ff       	jmp    ae90 <fwp_drop2>
    af78:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    af7f:	00 

000000000000af80 <fwp_owner_release8>:
    af80:	48 8b 3f             	mov    (%rdi),%rdi
    af83:	e9 08 ff ff ff       	jmp    ae90 <fwp_drop2>
    af88:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    af8f:	00 

000000000000af90 <fwp_owner_release9>:
    af90:	48 8b 3f             	mov    (%rdi),%rdi
    af93:	e9 f8 fe ff ff       	jmp    ae90 <fwp_drop2>
    af98:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    af9f:	00 

000000000000afa0 <fwp_owned_entry5>:
    afa0:	48 0f be 0f          	movsbq (%rdi),%rcx
    afa4:	48 0f be 47 08       	movsbq 0x8(%rdi),%rax
    afa9:	48 01 c8             	add    %rcx,%rax
    afac:	48 0f be c8          	movsbq %al,%rcx
    afb0:	48 39 c1             	cmp    %rax,%rcx
    afb3:	75 01                	jne    afb6 <fwp_owned_entry5+0x16>
    afb5:	c3                   	ret
    afb6:	53                   	push   %rbx
    afb7:	48 83 ec 60          	sub    $0x60,%rsp
    afbb:	48 8d 15 a1 ac 00 00 	lea    0xaca1(%rip),%rdx        # 15c63 <exec_in_fp0+0x3f3>
    afc2:	48 8d 0d 97 ac 00 00 	lea    0xac97(%rip),%rcx        # 15c60 <exec_in_fp0+0x3f0>
    afc9:	48 89 e3             	mov    %rsp,%rbx
    afcc:	be 60 00 00 00       	mov    $0x60,%esi
    afd1:	48 89 df             	mov    %rbx,%rdi
    afd4:	31 c0                	xor    %eax,%eax
    afd6:	e8 f5 81 ff ff       	call   31d0 <snprintf@plt>
    afdb:	e8 10 bc ff ff       	call   6bf0 <fwp_flush>
    afe0:	48 8b 05 f1 ef 00 00 	mov    0xeff1(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    afe7:	48 8b 38             	mov    (%rax),%rdi
    afea:	48 8d 35 a8 aa 00 00 	lea    0xaaa8(%rip),%rsi        # 15a99 <exec_in_fp0+0x229>
    aff1:	48 89 da             	mov    %rbx,%rdx
    aff4:	31 c0                	xor    %eax,%eax
    aff6:	e8 f5 82 ff ff       	call   32f0 <fprintf@plt>
    affb:	bf 65 00 00 00       	mov    $0x65,%edi
    b000:	e8 5b 84 ff ff       	call   3460 <exit@plt>
    b005:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b00c:	00 00 00 00 

000000000000b010 <fwp_caps5>:
    b010:	85 f6                	test   %esi,%esi
    b012:	0f 84 28 f9 ff ff    	je     a940 <fwp_rc_free_obj>
    b018:	c3                   	ret
    b019:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000b020 <fwp_args5>:
    b020:	c3                   	ret
    b021:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b028:	0f 1f 84 00 00 00 00 
    b02f:	00 

000000000000b030 <fwp_owned_entry12>:
    b030:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    b034:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    b039:	0f 59 c8             	mulps  %xmm0,%xmm1
    b03c:	66 0f 7e c8          	movd   %xmm1,%eax
    b040:	c3                   	ret
    b041:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b048:	0f 1f 84 00 00 00 00 
    b04f:	00 

000000000000b050 <fwp_caps12>:
    b050:	85 f6                	test   %esi,%esi
    b052:	0f 84 e8 f8 ff ff    	je     a940 <fwp_rc_free_obj>
    b058:	c3                   	ret
    b059:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000b060 <fwp_args12>:
    b060:	c3                   	ret
    b061:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b068:	0f 1f 84 00 00 00 00 
    b06f:	00 

000000000000b070 <fwp_owned_entry13>:
    b070:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    b074:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    b079:	0f 58 c8             	addps  %xmm0,%xmm1
    b07c:	66 0f 7e c8          	movd   %xmm1,%eax
    b080:	c3                   	ret
    b081:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b088:	0f 1f 84 00 00 00 00 
    b08f:	00 

000000000000b090 <fwp_caps13>:
    b090:	85 f6                	test   %esi,%esi
    b092:	0f 84 a8 f8 ff ff    	je     a940 <fwp_rc_free_obj>
    b098:	c3                   	ret
    b099:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000b0a0 <fwp_args13>:
    b0a0:	c3                   	ret
    b0a1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b0a8:	0f 1f 84 00 00 00 00 
    b0af:	00 

000000000000b0b0 <fwp_owned_entry20>:
    b0b0:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    b0b4:	f2 0f 59 47 08       	mulsd  0x8(%rdi),%xmm0
    b0b9:	66 48 0f 7e c0       	movq   %xmm0,%rax
    b0be:	c3                   	ret
    b0bf:	90                   	nop

000000000000b0c0 <fwp_caps20>:
    b0c0:	85 f6                	test   %esi,%esi
    b0c2:	0f 84 78 f8 ff ff    	je     a940 <fwp_rc_free_obj>
    b0c8:	c3                   	ret
    b0c9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000b0d0 <fwp_args20>:
    b0d0:	c3                   	ret
    b0d1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b0d8:	0f 1f 84 00 00 00 00 
    b0df:	00 

000000000000b0e0 <fwp_owned_entry21>:
    b0e0:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    b0e4:	f2 0f 58 47 08       	addsd  0x8(%rdi),%xmm0
    b0e9:	66 48 0f 7e c0       	movq   %xmm0,%rax
    b0ee:	c3                   	ret
    b0ef:	90                   	nop

000000000000b0f0 <fwp_caps21>:
    b0f0:	85 f6                	test   %esi,%esi
    b0f2:	0f 84 48 f8 ff ff    	je     a940 <fwp_rc_free_obj>
    b0f8:	c3                   	ret
    b0f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000b100 <fwp_args21>:
    b100:	c3                   	ret
    b101:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b108:	0f 1f 84 00 00 00 00 
    b10f:	00 

000000000000b110 <fwp_segv>:
    b110:	48 8b 05 d1 0d 01 00 	mov    0x10dd1(%rip),%rax        # 1bee8 <fwp_main_stack_top>
    b117:	48 85 c0             	test   %rax,%rax
    b11a:	74 22                	je     b13e <fwp_segv+0x2e>
    b11c:	48 8b 4e 10          	mov    0x10(%rsi),%rcx
    b120:	48 2b 05 c9 0d 01 00 	sub    0x10dc9(%rip),%rax        # 1bef0 <fwp_main_stack_size>
    b127:	48 8d 90 00 00 f0 ff 	lea    -0x100000(%rax),%rdx
    b12e:	48 39 ca             	cmp    %rcx,%rdx
    b131:	77 0b                	ja     b13e <fwp_segv+0x2e>
    b133:	48 05 00 00 10 00    	add    $0x100000,%rax
    b139:	48 39 c8             	cmp    %rcx,%rax
    b13c:	77 07                	ja     b145 <fwp_segv+0x35>
    b13e:	31 f6                	xor    %esi,%esi
    b140:	e9 9b 81 ff ff       	jmp    32e0 <signal@plt>
    b145:	50                   	push   %rax
    b146:	e8 a5 ba ff ff       	call   6bf0 <fwp_flush>
    b14b:	48 8d 35 ce a6 00 00 	lea    0xa6ce(%rip),%rsi        # 15820 <fwp_segv.msg>
    b152:	ba 1a 00 00 00       	mov    $0x1a,%edx
    b157:	bf 02 00 00 00       	mov    $0x2,%edi
    b15c:	e8 df 7f ff ff       	call   3140 <write@plt>
    b161:	bf 65 00 00 00       	mov    $0x65,%edi
    b166:	e8 35 7f ff ff       	call   30a0 <_exit@plt>
    b16b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000b170 <fwp_str_lossy>:
    b170:	55                   	push   %rbp
    b171:	41 57                	push   %r15
    b173:	41 56                	push   %r14
    b175:	41 55                	push   %r13
    b177:	41 54                	push   %r12
    b179:	53                   	push   %rbx
    b17a:	48 83 ec 28          	sub    $0x28,%rsp
    b17e:	49 89 f6             	mov    %rsi,%r14
    b181:	48 89 fb             	mov    %rdi,%rbx
    b184:	48 85 f6             	test   %rsi,%rsi
    b187:	0f 84 47 01 00 00    	je     b2d4 <fwp_str_lossy+0x164>
    b18d:	31 c0                	xor    %eax,%eax
    b18f:	eb 1b                	jmp    b1ac <fwp_str_lossy+0x3c>
    b191:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b198:	0f 1f 84 00 00 00 00 
    b19f:	00 
    b1a0:	48 ff c0             	inc    %rax
    b1a3:	4c 39 f0             	cmp    %r14,%rax
    b1a6:	0f 83 28 01 00 00    	jae    b2d4 <fwp_str_lossy+0x164>
    b1ac:	0f b6 3c 03          	movzbl (%rbx,%rax,1),%edi
    b1b0:	40 84 ff             	test   %dil,%dil
    b1b3:	79 eb                	jns    b1a0 <fwp_str_lossy+0x30>
    b1b5:	8d 4f 3e             	lea    0x3e(%rdi),%ecx
    b1b8:	80 f9 1e             	cmp    $0x1e,%cl
    b1bb:	73 11                	jae    b1ce <fwp_str_lossy+0x5e>
    b1bd:	b9 80 00 00 00       	mov    $0x80,%ecx
    b1c2:	be 01 00 00 00       	mov    $0x1,%esi
    b1c7:	ba 1f 00 00 00       	mov    $0x1f,%edx
    b1cc:	eb 36                	jmp    b204 <fwp_str_lossy+0x94>
    b1ce:	89 f9                	mov    %edi,%ecx
    b1d0:	80 e1 f0             	and    $0xf0,%cl
    b1d3:	80 f9 e0             	cmp    $0xe0,%cl
    b1d6:	75 11                	jne    b1e9 <fwp_str_lossy+0x79>
    b1d8:	b9 00 08 00 00       	mov    $0x800,%ecx
    b1dd:	be 02 00 00 00       	mov    $0x2,%esi
    b1e2:	ba 0f 00 00 00       	mov    $0xf,%edx
    b1e7:	eb 1b                	jmp    b204 <fwp_str_lossy+0x94>
    b1e9:	8d 4f 10             	lea    0x10(%rdi),%ecx
    b1ec:	80 f9 04             	cmp    $0x4,%cl
    b1ef:	0f 87 52 01 00 00    	ja     b347 <fwp_str_lossy+0x1d7>
    b1f5:	b9 00 00 01 00       	mov    $0x10000,%ecx
    b1fa:	be 03 00 00 00       	mov    $0x3,%esi
    b1ff:	ba 07 00 00 00       	mov    $0x7,%edx
    b204:	89 f6                	mov    %esi,%esi
    b206:	4c 8d 04 30          	lea    (%rax,%rsi,1),%r8
    b20a:	4d 39 f0             	cmp    %r14,%r8
    b20d:	0f 83 34 01 00 00    	jae    b347 <fwp_str_lossy+0x1d7>
    b213:	44 0f b6 44 03 01    	movzbl 0x1(%rbx,%rax,1),%r8d
    b219:	45 89 c1             	mov    %r8d,%r9d
    b21c:	41 83 e1 c0          	and    $0xffffffc0,%r9d
    b220:	41 81 f9 80 00 00 00 	cmp    $0x80,%r9d
    b227:	0f 85 1a 01 00 00    	jne    b347 <fwp_str_lossy+0x1d7>
    b22d:	21 fa                	and    %edi,%edx
    b22f:	8d 7e 01             	lea    0x1(%rsi),%edi
    b232:	41 89 d1             	mov    %edx,%r9d
    b235:	41 c1 e1 06          	shl    $0x6,%r9d
    b239:	41 83 e0 3f          	and    $0x3f,%r8d
    b23d:	45 09 c8             	or     %r9d,%r8d
    b240:	83 ff 02             	cmp    $0x2,%edi
    b243:	75 05                	jne    b24a <fwp_str_lossy+0xda>
    b245:	44 89 c7             	mov    %r8d,%edi
    b248:	eb 58                	jmp    b2a2 <fwp_str_lossy+0x132>
    b24a:	0f b6 54 03 02       	movzbl 0x2(%rbx,%rax,1),%edx
    b24f:	41 89 d1             	mov    %edx,%r9d
    b252:	41 83 e1 c0          	and    $0xffffffc0,%r9d
    b256:	41 81 f9 80 00 00 00 	cmp    $0x80,%r9d
    b25d:	0f 85 e4 00 00 00    	jne    b347 <fwp_str_lossy+0x1d7>
    b263:	45 89 c1             	mov    %r8d,%r9d
    b266:	41 c1 e1 06          	shl    $0x6,%r9d
    b26a:	83 e2 3f             	and    $0x3f,%edx
    b26d:	44 09 ca             	or     %r9d,%edx
    b270:	83 ff 03             	cmp    $0x3,%edi
    b273:	75 07                	jne    b27c <fwp_str_lossy+0x10c>
    b275:	89 d7                	mov    %edx,%edi
    b277:	44 89 c2             	mov    %r8d,%edx
    b27a:	eb 26                	jmp    b2a2 <fwp_str_lossy+0x132>
    b27c:	0f b6 7c 03 03       	movzbl 0x3(%rbx,%rax,1),%edi
    b281:	41 89 f8             	mov    %edi,%r8d
    b284:	41 83 e0 c0          	and    $0xffffffc0,%r8d
    b288:	41 81 f8 80 00 00 00 	cmp    $0x80,%r8d
    b28f:	0f 85 b2 00 00 00    	jne    b347 <fwp_str_lossy+0x1d7>
    b295:	41 89 d0             	mov    %edx,%r8d
    b298:	41 c1 e0 06          	shl    $0x6,%r8d
    b29c:	83 e7 3f             	and    $0x3f,%edi
    b29f:	44 09 c7             	or     %r8d,%edi
    b2a2:	83 e2 e0             	and    $0xffffffe0,%edx
    b2a5:	81 fa 60 03 00 00    	cmp    $0x360,%edx
    b2ab:	0f 84 96 00 00 00    	je     b347 <fwp_str_lossy+0x1d7>
    b2b1:	39 cf                	cmp    %ecx,%edi
    b2b3:	0f 82 8e 00 00 00    	jb     b347 <fwp_str_lossy+0x1d7>
    b2b9:	81 ff ff ff 10 00    	cmp    $0x10ffff,%edi
    b2bf:	0f 87 82 00 00 00    	ja     b347 <fwp_str_lossy+0x1d7>
    b2c5:	48 01 f0             	add    %rsi,%rax
    b2c8:	48 ff c0             	inc    %rax
    b2cb:	4c 39 f0             	cmp    %r14,%rax
    b2ce:	0f 82 d8 fe ff ff    	jb     b1ac <fwp_str_lossy+0x3c>
    b2d4:	49 8d 56 09          	lea    0x9(%r14),%rdx
    b2d8:	48 ff 05 c9 0b 01 00 	incq   0x10bc9(%rip)        # 1bea8 <measured_calls>
    b2df:	48 01 15 ca 0b 01 00 	add    %rdx,0x10bca(%rip)        # 1beb0 <measured_bytes>
    b2e6:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    b2ed:	0f 87 01 02 00 00    	ja     b4f4 <fwp_str_lossy+0x384>
    b2f3:	49 8d 4e 18          	lea    0x18(%r14),%rcx
    b2f7:	48 c1 e9 04          	shr    $0x4,%rcx
    b2fb:	48 8d 05 86 ef 00 00 	lea    0xef86(%rip),%rax        # 1a288 <fwp_gc>
    b302:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    b309:	00 
    b30a:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    b311:	48 29 0d 70 ef 00 00 	sub    %rcx,0xef70(%rip)        # 1a288 <fwp_gc>
    b318:	0f 88 d6 01 00 00    	js     b4f4 <fwp_str_lossy+0x384>
    b31e:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    b322:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    b326:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    b32d:	4c 8b 3f             	mov    (%rdi),%r15
    b330:	4d 85 ff             	test   %r15,%r15
    b333:	0f 84 a3 01 00 00    	je     b4dc <fwp_str_lossy+0x36c>
    b339:	49 8b 07             	mov    (%r15),%rax
    b33c:	48 f7 d0             	not    %rax
    b33f:	48 89 07             	mov    %rax,(%rdi)
    b342:	e9 cf 01 00 00       	jmp    b516 <fwp_str_lossy+0x3a6>
    b347:	0f 57 c0             	xorps  %xmm0,%xmm0
    b34a:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    b34f:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    b356:	00 00 
    b358:	31 ed                	xor    %ebp,%ebp
    b35a:	4c 8d 7c 24 10       	lea    0x10(%rsp),%r15
    b35f:	4c 8d 64 24 0f       	lea    0xf(%rsp),%r12
    b364:	eb 30                	jmp    b396 <fwp_str_lossy+0x226>
    b366:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    b36d:	00 00 00 
    b370:	88 44 24 0f          	mov    %al,0xf(%rsp)
    b374:	ba 01 00 00 00       	mov    $0x1,%edx
    b379:	4c 89 ff             	mov    %r15,%rdi
    b37c:	4c 89 e6             	mov    %r12,%rsi
    b37f:	e8 8c 1e 00 00       	call   d210 <buf_put>
    b384:	48 ff c5             	inc    %rbp
    b387:	49 89 ed             	mov    %rbp,%r13
    b38a:	4c 89 ed             	mov    %r13,%rbp
    b38d:	4d 39 f5             	cmp    %r14,%r13
    b390:	0f 83 37 01 00 00    	jae    b4cd <fwp_str_lossy+0x35d>
    b396:	0f b6 04 2b          	movzbl (%rbx,%rbp,1),%eax
    b39a:	84 c0                	test   %al,%al
    b39c:	79 d2                	jns    b370 <fwp_str_lossy+0x200>
    b39e:	8d 48 20             	lea    0x20(%rax),%ecx
    b3a1:	80 f9 e1             	cmp    $0xe1,%cl
    b3a4:	77 34                	ja     b3da <fwp_str_lossy+0x26a>
    b3a6:	89 c2                	mov    %eax,%edx
    b3a8:	80 e2 f0             	and    $0xf0,%dl
    b3ab:	80 fa e0             	cmp    $0xe0,%dl
    b3ae:	0f 85 d5 00 00 00    	jne    b489 <fwp_str_lossy+0x319>
    b3b4:	3c e0                	cmp    $0xe0,%al
    b3b6:	40 0f 94 c6          	sete   %sil
    b3ba:	40 c0 e6 05          	shl    $0x5,%sil
    b3be:	40 80 ce 80          	or     $0x80,%sil
    b3c2:	31 ff                	xor    %edi,%edi
    b3c4:	3c ed                	cmp    $0xed,%al
    b3c6:	40 0f 95 c7          	setne  %dil
    b3ca:	c1 e7 05             	shl    $0x5,%edi
    b3cd:	81 cf 9f 00 00 00    	or     $0x9f,%edi
    b3d3:	b8 02 00 00 00       	mov    $0x2,%eax
    b3d8:	eb 0d                	jmp    b3e7 <fwp_str_lossy+0x277>
    b3da:	bf bf 00 00 00       	mov    $0xbf,%edi
    b3df:	40 b6 80             	mov    $0x80,%sil
    b3e2:	b8 01 00 00 00       	mov    $0x1,%eax
    b3e7:	31 d2                	xor    %edx,%edx
    b3e9:	4c 8d 6d 01          	lea    0x1(%rbp),%r13
    b3ed:	4d 39 f5             	cmp    %r14,%r13
    b3f0:	73 7e                	jae    b470 <fwp_str_lossy+0x300>
    b3f2:	46 0f b6 04 2b       	movzbl (%rbx,%r13,1),%r8d
    b3f7:	41 38 f0             	cmp    %sil,%r8b
    b3fa:	72 74                	jb     b470 <fwp_str_lossy+0x300>
    b3fc:	44 39 c7             	cmp    %r8d,%edi
    b3ff:	72 6f                	jb     b470 <fwp_str_lossy+0x300>
    b401:	4c 8d 6d 02          	lea    0x2(%rbp),%r13
    b405:	be 01 00 00 00       	mov    $0x1,%esi
    b40a:	80 f9 e1             	cmp    $0xe1,%cl
    b40d:	77 44                	ja     b453 <fwp_str_lossy+0x2e3>
    b40f:	4d 39 f5             	cmp    %r14,%r13
    b412:	73 3f                	jae    b453 <fwp_str_lossy+0x2e3>
    b414:	42 0f b6 0c 2b       	movzbl (%rbx,%r13,1),%ecx
    b419:	80 e1 c0             	and    $0xc0,%cl
    b41c:	80 f9 80             	cmp    $0x80,%cl
    b41f:	75 32                	jne    b453 <fwp_str_lossy+0x2e3>
    b421:	4c 8d 6d 03          	lea    0x3(%rbp),%r13
    b425:	4d 39 f5             	cmp    %r14,%r13
    b428:	0f 93 c1             	setae  %cl
    b42b:	80 f2 01             	xor    $0x1,%dl
    b42e:	be 02 00 00 00       	mov    $0x2,%esi
    b433:	08 ca                	or     %cl,%dl
    b435:	75 1c                	jne    b453 <fwp_str_lossy+0x2e3>
    b437:	0f b6 4c 2b 03       	movzbl 0x3(%rbx,%rbp,1),%ecx
    b43c:	80 e1 c0             	and    $0xc0,%cl
    b43f:	31 f6                	xor    %esi,%esi
    b441:	80 f9 80             	cmp    $0x80,%cl
    b444:	0f 94 c1             	sete   %cl
    b447:	75 04                	jne    b44d <fwp_str_lossy+0x2dd>
    b449:	4c 8d 6d 04          	lea    0x4(%rbp),%r13
    b44d:	40 88 ce             	mov    %cl,%sil
    b450:	83 ce 02             	or     $0x2,%esi
    b453:	39 c6                	cmp    %eax,%esi
    b455:	75 19                	jne    b470 <fwp_str_lossy+0x300>
    b457:	48 8d 34 2b          	lea    (%rbx,%rbp,1),%rsi
    b45b:	4c 89 ea             	mov    %r13,%rdx
    b45e:	48 29 ea             	sub    %rbp,%rdx
    b461:	4c 89 ff             	mov    %r15,%rdi
    b464:	eb 19                	jmp    b47f <fwp_str_lossy+0x30f>
    b466:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    b46d:	00 00 00 
    b470:	ba 03 00 00 00       	mov    $0x3,%edx
    b475:	4c 89 ff             	mov    %r15,%rdi
    b478:	48 8d 35 f7 b1 00 00 	lea    0xb1f7(%rip),%rsi        # 16676 <exec_in_fp0+0xe06>
    b47f:	e8 8c 1d 00 00       	call   d210 <buf_put>
    b484:	e9 01 ff ff ff       	jmp    b38a <fwp_str_lossy+0x21a>
    b489:	8d 50 10             	lea    0x10(%rax),%edx
    b48c:	80 fa 04             	cmp    $0x4,%dl
    b48f:	77 28                	ja     b4b9 <fwp_str_lossy+0x349>
    b491:	3c f0                	cmp    $0xf0,%al
    b493:	40 0f 94 c6          	sete   %sil
    b497:	bf 8f 00 00 00       	mov    $0x8f,%edi
    b49c:	3c f4                	cmp    $0xf4,%al
    b49e:	74 05                	je     b4a5 <fwp_str_lossy+0x335>
    b4a0:	bf bf 00 00 00       	mov    $0xbf,%edi
    b4a5:	40 c0 e6 04          	shl    $0x4,%sil
    b4a9:	40 80 ce 80          	or     $0x80,%sil
    b4ad:	b8 03 00 00 00       	mov    $0x3,%eax
    b4b2:	b2 01                	mov    $0x1,%dl
    b4b4:	e9 30 ff ff ff       	jmp    b3e9 <fwp_str_lossy+0x279>
    b4b9:	ba 03 00 00 00       	mov    $0x3,%edx
    b4be:	4c 89 ff             	mov    %r15,%rdi
    b4c1:	48 8d 35 ae b1 00 00 	lea    0xb1ae(%rip),%rsi        # 16676 <exec_in_fp0+0xe06>
    b4c8:	e9 b2 fe ff ff       	jmp    b37f <fwp_str_lossy+0x20f>
    b4cd:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    b4d2:	e8 29 1e 00 00       	call   d300 <buf_to_str>
    b4d7:	49 89 c7             	mov    %rax,%r15
    b4da:	eb 5c                	jmp    b538 <fwp_str_lossy+0x3c8>
    b4dc:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    b4e3:	00 
    b4e4:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    b4eb:	00 
    b4ec:	4c 29 ff             	sub    %r15,%rdi
    b4ef:	48 39 cf             	cmp    %rcx,%rdi
    b4f2:	73 12                	jae    b506 <fwp_str_lossy+0x396>
    b4f4:	48 89 d7             	mov    %rdx,%rdi
    b4f7:	be 01 00 00 00       	mov    $0x1,%esi
    b4fc:	e8 bf cd ff ff       	call   82c0 <fwp_gc_alloc_slow>
    b501:	49 89 c7             	mov    %rax,%r15
    b504:	eb 1a                	jmp    b520 <fwp_str_lossy+0x3b0>
    b506:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    b50a:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    b510:	4c 01 f9             	add    %r15,%rcx
    b513:	48 89 08             	mov    %rcx,(%rax)
    b516:	4c 89 ff             	mov    %r15,%rdi
    b519:	31 f6                	xor    %esi,%esi
    b51b:	e8 f0 7c ff ff       	call   3210 <memset@plt>
    b520:	4d 89 37             	mov    %r14,(%r15)
    b523:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    b527:	48 89 de             	mov    %rbx,%rsi
    b52a:	4c 89 f2             	mov    %r14,%rdx
    b52d:	e8 fe 7d ff ff       	call   3330 <memcpy@plt>
    b532:	43 c6 44 37 08 00    	movb   $0x0,0x8(%r15,%r14,1)
    b538:	4c 89 f8             	mov    %r15,%rax
    b53b:	48 83 c4 28          	add    $0x28,%rsp
    b53f:	5b                   	pop    %rbx
    b540:	41 5c                	pop    %r12
    b542:	41 5d                	pop    %r13
    b544:	41 5e                	pop    %r14
    b546:	41 5f                	pop    %r15
    b548:	5d                   	pop    %rbp
    b549:	c3                   	ret
    b54a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000b550 <fwp_alloc_leaf>:
    b550:	53                   	push   %rbx
    b551:	48 89 fa             	mov    %rdi,%rdx
    b554:	48 ff 05 4d 09 01 00 	incq   0x1094d(%rip)        # 1bea8 <measured_calls>
    b55b:	48 01 3d 4e 09 01 00 	add    %rdi,0x1094e(%rip)        # 1beb0 <measured_bytes>
    b562:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    b569:	77 61                	ja     b5cc <fwp_alloc_leaf+0x7c>
    b56b:	48 8d 4a 0f          	lea    0xf(%rdx),%rcx
    b56f:	48 c1 e9 04          	shr    $0x4,%rcx
    b573:	48 8d 05 0e ed 00 00 	lea    0xed0e(%rip),%rax        # 1a288 <fwp_gc>
    b57a:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    b581:	00 
    b582:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    b589:	48 29 0d f8 ec 00 00 	sub    %rcx,0xecf8(%rip)        # 1a288 <fwp_gc>
    b590:	78 3a                	js     b5cc <fwp_alloc_leaf+0x7c>
    b592:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    b596:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    b59a:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    b5a1:	48 8b 1f             	mov    (%rdi),%rbx
    b5a4:	48 85 db             	test   %rbx,%rbx
    b5a7:	74 0b                	je     b5b4 <fwp_alloc_leaf+0x64>
    b5a9:	48 8b 03             	mov    (%rbx),%rax
    b5ac:	48 f7 d0             	not    %rax
    b5af:	48 89 07             	mov    %rax,(%rdi)
    b5b2:	eb 36                	jmp    b5ea <fwp_alloc_leaf+0x9a>
    b5b4:	48 8b 9c f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%rbx
    b5bb:	00 
    b5bc:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    b5c3:	00 
    b5c4:	48 29 df             	sub    %rbx,%rdi
    b5c7:	48 39 cf             	cmp    %rcx,%rdi
    b5ca:	73 0e                	jae    b5da <fwp_alloc_leaf+0x8a>
    b5cc:	48 89 d7             	mov    %rdx,%rdi
    b5cf:	be 01 00 00 00       	mov    $0x1,%esi
    b5d4:	5b                   	pop    %rbx
    b5d5:	e9 e6 cc ff ff       	jmp    82c0 <fwp_gc_alloc_slow>
    b5da:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    b5de:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    b5e4:	48 01 d9             	add    %rbx,%rcx
    b5e7:	48 89 08             	mov    %rcx,(%rax)
    b5ea:	48 89 df             	mov    %rbx,%rdi
    b5ed:	31 f6                	xor    %esi,%esi
    b5ef:	e8 1c 7c ff ff       	call   3210 <memset@plt>
    b5f4:	48 89 d8             	mov    %rbx,%rax
    b5f7:	5b                   	pop    %rbx
    b5f8:	c3                   	ret
    b5f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000b600 <fwp_pipe_write>:
    b600:	55                   	push   %rbp
    b601:	41 57                	push   %r15
    b603:	41 56                	push   %r14
    b605:	41 55                	push   %r13
    b607:	41 54                	push   %r12
    b609:	53                   	push   %rbx
    b60a:	48 83 ec 48          	sub    $0x48,%rsp
    b60e:	48 89 f3             	mov    %rsi,%rbx
    b611:	49 89 fe             	mov    %rdi,%r14
    b614:	8b 05 06 09 02 00    	mov    0x20906(%rip),%eax        # 2bf20 <fwp_po_kind>
    b61a:	83 f8 01             	cmp    $0x1,%eax
    b61d:	0f 84 cc 02 00 00    	je     b8ef <fwp_pipe_write+0x2ef>
    b623:	83 f8 02             	cmp    $0x2,%eax
    b626:	0f 85 4e 03 00 00    	jne    b97a <fwp_pipe_write+0x37a>
    b62c:	48 85 db             	test   %rbx,%rbx
    b62f:	0f 84 0d 04 00 00    	je     ba42 <fwp_pipe_write+0x442>
    b635:	f6 05 fc 08 03 00 01 	testb  $0x1,0x308fc(%rip)        # 3bf38 <fwp_po_gone>
    b63c:	0f 85 00 04 00 00    	jne    ba42 <fwp_pipe_write+0x442>
    b642:	4c 8b 2d e7 08 03 00 	mov    0x308e7(%rip),%r13        # 3bf30 <fwp_po_ring>
    b649:	49 8d 85 00 10 00 00 	lea    0x1000(%r13),%rax
    b650:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    b655:	49 8d 85 c0 00 00 00 	lea    0xc0(%r13),%rax
    b65c:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    b661:	49 8d 85 00 01 00 00 	lea    0x100(%r13),%rax
    b668:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    b66d:	0f 1f 00             	nopl   (%rax)
    b670:	49 8b 6d 40          	mov    0x40(%r13),%rbp
    b674:	4d 8b bd 80 00 00 00 	mov    0x80(%r13),%r15
    b67b:	4d 8b 65 08          	mov    0x8(%r13),%r12
    b67f:	49 29 ef             	sub    %rbp,%r15
    b682:	4d 01 e7             	add    %r12,%r15
    b685:	0f 84 b5 00 00 00    	je     b740 <fwp_pipe_write+0x140>
    b68b:	4c 39 fb             	cmp    %r15,%rbx
    b68e:	48 89 5c 24 38       	mov    %rbx,0x38(%rsp)
    b693:	4c 0f 42 fb          	cmovb  %rbx,%r15
    b697:	49 8d 7c 24 ff       	lea    -0x1(%r12),%rdi
    b69c:	48 21 ef             	and    %rbp,%rdi
    b69f:	49 29 fc             	sub    %rdi,%r12
    b6a2:	4d 39 e7             	cmp    %r12,%r15
    b6a5:	4d 0f 42 e7          	cmovb  %r15,%r12
    b6a9:	48 8b 5c 24 28       	mov    0x28(%rsp),%rbx
    b6ae:	48 01 df             	add    %rbx,%rdi
    b6b1:	4c 89 f6             	mov    %r14,%rsi
    b6b4:	4c 89 e2             	mov    %r12,%rdx
    b6b7:	e8 74 7c ff ff       	call   3330 <memcpy@plt>
    b6bc:	4c 89 74 24 40       	mov    %r14,0x40(%rsp)
    b6c1:	4b 8d 34 26          	lea    (%r14,%r12,1),%rsi
    b6c5:	4c 89 fa             	mov    %r15,%rdx
    b6c8:	4c 29 e2             	sub    %r12,%rdx
    b6cb:	48 89 df             	mov    %rbx,%rdi
    b6ce:	e8 5d 7c ff ff       	call   3330 <memcpy@plt>
    b6d3:	4c 01 fd             	add    %r15,%rbp
    b6d6:	49 89 6d 40          	mov    %rbp,0x40(%r13)
    b6da:	0f ae f0             	mfence
    b6dd:	41 8b 85 c4 00 00 00 	mov    0xc4(%r13),%eax
    b6e4:	85 c0                	test   %eax,%eax
    b6e6:	74 2b                	je     b713 <fwp_pipe_write+0x113>
    b6e8:	48 8b 74 24 20       	mov    0x20(%rsp),%rsi
    b6ed:	f0 ff 06             	lock incl (%rsi)
    b6f0:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    b6f7:	bf ca 00 00 00       	mov    $0xca,%edi
    b6fc:	ba 01 00 00 00       	mov    $0x1,%edx
    b701:	b9 ff ff ff 7f       	mov    $0x7fffffff,%ecx
    b706:	45 31 c0             	xor    %r8d,%r8d
    b709:	45 31 c9             	xor    %r9d,%r9d
    b70c:	31 c0                	xor    %eax,%eax
    b70e:	e8 ed 7b ff ff       	call   3300 <syscall@plt>
    b713:	4c 8b 74 24 40       	mov    0x40(%rsp),%r14
    b718:	4d 01 fe             	add    %r15,%r14
    b71b:	48 8b 5c 24 38       	mov    0x38(%rsp),%rbx
    b720:	4c 29 fb             	sub    %r15,%rbx
    b723:	48 85 db             	test   %rbx,%rbx
    b726:	0f 84 16 03 00 00    	je     ba42 <fwp_pipe_write+0x442>
    b72c:	f6 05 05 08 03 00 01 	testb  $0x1,0x30805(%rip)        # 3bf38 <fwp_po_gone>
    b733:	0f 84 37 ff ff ff    	je     b670 <fwp_pipe_write+0x70>
    b739:	e9 04 03 00 00       	jmp    ba42 <fwp_pipe_write+0x442>
    b73e:	66 90                	xchg   %ax,%ax
    b740:	44 8b 25 9d 06 01 00 	mov    0x1069d(%rip),%r12d        # 1bde4 <fwp_po_sock>
    b747:	8b 0d 9b 06 01 00    	mov    0x1069b(%rip),%ecx        # 1bde8 <fwp_ring_spin>
    b74d:	85 c9                	test   %ecx,%ecx
    b74f:	78 09                	js     b75a <fwp_pipe_write+0x15a>
    b751:	85 c9                	test   %ecx,%ecx
    b753:	75 22                	jne    b777 <fwp_pipe_write+0x177>
    b755:	e9 96 00 00 00       	jmp    b7f0 <fwp_pipe_write+0x1f0>
    b75a:	bf 54 00 00 00       	mov    $0x54,%edi
    b75f:	e8 bc 7c ff ff       	call   3420 <sysconf@plt>
    b764:	31 c9                	xor    %ecx,%ecx
    b766:	48 83 f8 02          	cmp    $0x2,%rax
    b76a:	0f 9d c1             	setge  %cl
    b76d:	89 0d 75 06 01 00    	mov    %ecx,0x10675(%rip)        # 1bde8 <fwp_ring_spin>
    b773:	85 c9                	test   %ecx,%ecx
    b775:	74 79                	je     b7f0 <fwp_pipe_write+0x1f0>
    b777:	49 8b 85 80 00 00 00 	mov    0x80(%r13),%rax
    b77e:	49 2b 45 40          	sub    0x40(%r13),%rax
    b782:	49 03 45 08          	add    0x8(%r13),%rax
    b786:	75 9b                	jne    b723 <fwp_pipe_write+0x123>
    b788:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    b78e:	31 ed                	xor    %ebp,%ebp
    b790:	eb 26                	jmp    b7b8 <fwp_pipe_write+0x1b8>
    b792:	48 05 50 c3 00 00    	add    $0xc350,%rax
    b798:	48 89 c5             	mov    %rax,%rbp
    b79b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    b7a0:	41 ff c7             	inc    %r15d
    b7a3:	49 8b 85 80 00 00 00 	mov    0x80(%r13),%rax
    b7aa:	49 2b 45 40          	sub    0x40(%r13),%rax
    b7ae:	49 03 45 08          	add    0x8(%r13),%rax
    b7b2:	0f 85 6b ff ff ff    	jne    b723 <fwp_pipe_write+0x123>
    b7b8:	f3 90                	pause
    b7ba:	41 f6 c7 3f          	test   $0x3f,%r15b
    b7be:	75 e0                	jne    b7a0 <fwp_pipe_write+0x1a0>
    b7c0:	e8 8b 7a ff ff       	call   3250 <sched_yield@plt>
    b7c5:	bf 01 00 00 00       	mov    $0x1,%edi
    b7ca:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    b7cf:	e8 5c 79 ff ff       	call   3130 <clock_gettime@plt>
    b7d4:	48 69 44 24 10 00 ca 	imul   $0x3b9aca00,0x10(%rsp),%rax
    b7db:	9a 3b 
    b7dd:	48 03 44 24 18       	add    0x18(%rsp),%rax
    b7e2:	48 85 ed             	test   %rbp,%rbp
    b7e5:	74 ab                	je     b792 <fwp_pipe_write+0x192>
    b7e7:	48 39 e8             	cmp    %rbp,%rax
    b7ea:	7e b4                	jle    b7a0 <fwp_pipe_write+0x1a0>
    b7ec:	0f 1f 40 00          	nopl   0x0(%rax)
    b7f0:	41 8b 8d 00 01 00 00 	mov    0x100(%r13),%ecx
    b7f7:	b8 01 00 00 00       	mov    $0x1,%eax
    b7fc:	41 87 85 04 01 00 00 	xchg   %eax,0x104(%r13)
    b803:	0f ae f0             	mfence
    b806:	49 8b 85 80 00 00 00 	mov    0x80(%r13),%rax
    b80d:	49 2b 45 40          	sub    0x40(%r13),%rax
    b811:	49 03 45 08          	add    0x8(%r13),%rax
    b815:	0f 85 c4 00 00 00    	jne    b8df <fwp_pipe_write+0x2df>
    b81b:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    b822:	00 00 
    b824:	48 c7 44 24 18 00 e1 	movq   $0x5f5e100,0x18(%rsp)
    b82b:	f5 05 
    b82d:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    b834:	bf ca 00 00 00       	mov    $0xca,%edi
    b839:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    b83e:	31 d2                	xor    %edx,%edx
    b840:	4c 8d 44 24 10       	lea    0x10(%rsp),%r8
    b845:	45 31 c9             	xor    %r9d,%r9d
    b848:	31 c0                	xor    %eax,%eax
    b84a:	e8 b1 7a ff ff       	call   3300 <syscall@plt>
    b84f:	41 c7 85 04 01 00 00 	movl   $0x0,0x104(%r13)
    b856:	00 00 00 00 
    b85a:	49 8b 8d 80 00 00 00 	mov    0x80(%r13),%rcx
    b861:	49 2b 4d 40          	sub    0x40(%r13),%rcx
    b865:	49 03 4d 08          	add    0x8(%r13),%rcx
    b869:	0f 85 b4 fe ff ff    	jne    b723 <fwp_pipe_write+0x123>
    b86f:	48 85 c0             	test   %rax,%rax
    b872:	0f 84 78 ff ff ff    	je     b7f0 <fwp_pipe_write+0x1f0>
    b878:	e8 03 78 ff ff       	call   3080 <__errno_location@plt>
    b87d:	83 38 6e             	cmpl   $0x6e,(%rax)
    b880:	0f 85 6a ff ff ff    	jne    b7f0 <fwp_pipe_write+0x1f0>
    b886:	44 89 64 24 10       	mov    %r12d,0x10(%rsp)
    b88b:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%rsp)
    b892:	00 
    b893:	be 01 00 00 00       	mov    $0x1,%esi
    b898:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    b89d:	31 d2                	xor    %edx,%edx
    b89f:	e8 1c 7b ff ff       	call   33c0 <poll@plt>
    b8a4:	85 c0                	test   %eax,%eax
    b8a6:	0f 8e 44 ff ff ff    	jle    b7f0 <fwp_pipe_write+0x1f0>
    b8ac:	f6 44 24 16 18       	testb  $0x18,0x16(%rsp)
    b8b1:	75 20                	jne    b8d3 <fwp_pipe_write+0x2d3>
    b8b3:	ba 01 00 00 00       	mov    $0x1,%edx
    b8b8:	44 89 e7             	mov    %r12d,%edi
    b8bb:	48 8d 74 24 0f       	lea    0xf(%rsp),%rsi
    b8c0:	b9 42 00 00 00       	mov    $0x42,%ecx
    b8c5:	e8 96 77 ff ff       	call   3060 <recv@plt>
    b8ca:	48 85 c0             	test   %rax,%rax
    b8cd:	0f 85 1d ff ff ff    	jne    b7f0 <fwp_pipe_write+0x1f0>
    b8d3:	c6 05 5e 06 03 00 01 	movb   $0x1,0x3065e(%rip)        # 3bf38 <fwp_po_gone>
    b8da:	e9 44 fe ff ff       	jmp    b723 <fwp_pipe_write+0x123>
    b8df:	41 c7 85 04 01 00 00 	movl   $0x0,0x104(%r13)
    b8e6:	00 00 00 00 
    b8ea:	e9 34 fe ff ff       	jmp    b723 <fwp_pipe_write+0x123>
    b8ef:	4c 8b 3d 32 06 02 00 	mov    0x20632(%rip),%r15        # 2bf28 <fwp_po_len>
    b8f6:	49 8d 04 1f          	lea    (%r15,%rbx,1),%rax
    b8fa:	48 3d 01 00 01 00    	cmp    $0x10001,%rax
    b900:	0f 82 b1 00 00 00    	jb     b9b7 <fwp_pipe_write+0x3b7>
    b906:	4d 85 ff             	test   %r15,%r15
    b909:	0f 84 9a 00 00 00    	je     b9a9 <fwp_pipe_write+0x3a9>
    b90f:	80 3d 22 06 03 00 00 	cmpb   $0x0,0x30622(%rip)        # 3bf38 <fwp_po_gone>
    b916:	0f 85 8d 00 00 00    	jne    b9a9 <fwp_pipe_write+0x3a9>
    b91c:	8b 2d c2 04 01 00    	mov    0x104c2(%rip),%ebp        # 1bde4 <fwp_po_sock>
    b922:	4c 8d 25 07 06 02 00 	lea    0x20607(%rip),%r12        # 2bf30 <fwp_po_buf>
    b929:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    b930:	89 ef                	mov    %ebp,%edi
    b932:	4c 89 e6             	mov    %r12,%rsi
    b935:	4c 89 fa             	mov    %r15,%rdx
    b938:	b9 00 40 00 00       	mov    $0x4000,%ecx
    b93d:	e8 5e 78 ff ff       	call   31a0 <send@plt>
    b942:	48 85 c0             	test   %rax,%rax
    b945:	78 19                	js     b960 <fwp_pipe_write+0x360>
    b947:	74 59                	je     b9a2 <fwp_pipe_write+0x3a2>
    b949:	49 01 c4             	add    %rax,%r12
    b94c:	49 29 c7             	sub    %rax,%r15
    b94f:	eb 19                	jmp    b96a <fwp_pipe_write+0x36a>
    b951:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b958:	0f 1f 84 00 00 00 00 
    b95f:	00 
    b960:	e8 1b 77 ff ff       	call   3080 <__errno_location@plt>
    b965:	83 38 04             	cmpl   $0x4,(%rax)
    b968:	75 38                	jne    b9a2 <fwp_pipe_write+0x3a2>
    b96a:	4d 85 ff             	test   %r15,%r15
    b96d:	74 3a                	je     b9a9 <fwp_pipe_write+0x3a9>
    b96f:	f6 05 c2 05 03 00 01 	testb  $0x1,0x305c2(%rip)        # 3bf38 <fwp_po_gone>
    b976:	74 b8                	je     b930 <fwp_pipe_write+0x330>
    b978:	eb 2f                	jmp    b9a9 <fwp_pipe_write+0x3a9>
    b97a:	48 8b 05 2f e6 00 00 	mov    0xe62f(%rip),%rax        # 19fb0 <stdout@GLIBC_2.2.5>
    b981:	48 8b 08             	mov    (%rax),%rcx
    b984:	be 01 00 00 00       	mov    $0x1,%esi
    b989:	4c 89 f7             	mov    %r14,%rdi
    b98c:	48 89 da             	mov    %rbx,%rdx
    b98f:	48 83 c4 48          	add    $0x48,%rsp
    b993:	5b                   	pop    %rbx
    b994:	41 5c                	pop    %r12
    b996:	41 5d                	pop    %r13
    b998:	41 5e                	pop    %r14
    b99a:	41 5f                	pop    %r15
    b99c:	5d                   	pop    %rbp
    b99d:	e9 de 7a ff ff       	jmp    3480 <fwrite@plt>
    b9a2:	c6 05 8f 05 03 00 01 	movb   $0x1,0x3058f(%rip)        # 3bf38 <fwp_po_gone>
    b9a9:	48 c7 05 74 05 02 00 	movq   $0x0,0x20574(%rip)        # 2bf28 <fwp_po_len>
    b9b0:	00 00 00 00 
    b9b4:	45 31 ff             	xor    %r15d,%r15d
    b9b7:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    b9be:	72 5a                	jb     ba1a <fwp_pipe_write+0x41a>
    b9c0:	80 3d 71 05 03 00 00 	cmpb   $0x0,0x30571(%rip)        # 3bf38 <fwp_po_gone>
    b9c7:	75 79                	jne    ba42 <fwp_pipe_write+0x442>
    b9c9:	8b 2d 15 04 01 00    	mov    0x10415(%rip),%ebp        # 1bde4 <fwp_po_sock>
    b9cf:	90                   	nop
    b9d0:	89 ef                	mov    %ebp,%edi
    b9d2:	4c 89 f6             	mov    %r14,%rsi
    b9d5:	48 89 da             	mov    %rbx,%rdx
    b9d8:	b9 00 40 00 00       	mov    $0x4000,%ecx
    b9dd:	e8 be 77 ff ff       	call   31a0 <send@plt>
    b9e2:	48 85 c0             	test   %rax,%rax
    b9e5:	78 19                	js     ba00 <fwp_pipe_write+0x400>
    b9e7:	74 52                	je     ba3b <fwp_pipe_write+0x43b>
    b9e9:	49 01 c6             	add    %rax,%r14
    b9ec:	48 29 c3             	sub    %rax,%rbx
    b9ef:	eb 19                	jmp    ba0a <fwp_pipe_write+0x40a>
    b9f1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b9f8:	0f 1f 84 00 00 00 00 
    b9ff:	00 
    ba00:	e8 7b 76 ff ff       	call   3080 <__errno_location@plt>
    ba05:	83 38 04             	cmpl   $0x4,(%rax)
    ba08:	75 31                	jne    ba3b <fwp_pipe_write+0x43b>
    ba0a:	48 85 db             	test   %rbx,%rbx
    ba0d:	74 33                	je     ba42 <fwp_pipe_write+0x442>
    ba0f:	f6 05 22 05 03 00 01 	testb  $0x1,0x30522(%rip)        # 3bf38 <fwp_po_gone>
    ba16:	74 b8                	je     b9d0 <fwp_pipe_write+0x3d0>
    ba18:	eb 28                	jmp    ba42 <fwp_pipe_write+0x442>
    ba1a:	48 8d 3d 0f 05 02 00 	lea    0x2050f(%rip),%rdi        # 2bf30 <fwp_po_buf>
    ba21:	4c 01 ff             	add    %r15,%rdi
    ba24:	4c 89 f6             	mov    %r14,%rsi
    ba27:	48 89 da             	mov    %rbx,%rdx
    ba2a:	e8 01 79 ff ff       	call   3330 <memcpy@plt>
    ba2f:	49 01 df             	add    %rbx,%r15
    ba32:	4c 89 3d ef 04 02 00 	mov    %r15,0x204ef(%rip)        # 2bf28 <fwp_po_len>
    ba39:	eb 07                	jmp    ba42 <fwp_pipe_write+0x442>
    ba3b:	c6 05 f6 04 03 00 01 	movb   $0x1,0x304f6(%rip)        # 3bf38 <fwp_po_gone>
    ba42:	48 83 c4 48          	add    $0x48,%rsp
    ba46:	5b                   	pop    %rbx
    ba47:	41 5c                	pop    %r12
    ba49:	41 5d                	pop    %r13
    ba4b:	41 5e                	pop    %r14
    ba4d:	41 5f                	pop    %r15
    ba4f:	5d                   	pop    %rbp
    ba50:	c3                   	ret
    ba51:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ba58:	0f 1f 84 00 00 00 00 
    ba5f:	00 

000000000000ba60 <fwp_pipe_flush>:
    ba60:	55                   	push   %rbp
    ba61:	41 56                	push   %r14
    ba63:	53                   	push   %rbx
    ba64:	8b 05 b6 04 02 00    	mov    0x204b6(%rip),%eax        # 2bf20 <fwp_po_kind>
    ba6a:	85 c0                	test   %eax,%eax
    ba6c:	74 7c                	je     baea <fwp_pipe_flush+0x8a>
    ba6e:	83 f8 01             	cmp    $0x1,%eax
    ba71:	0f 85 9d 00 00 00    	jne    bb14 <fwp_pipe_flush+0xb4>
    ba77:	48 8b 1d aa 04 02 00 	mov    0x204aa(%rip),%rbx        # 2bf28 <fwp_po_len>
    ba7e:	48 85 db             	test   %rbx,%rbx
    ba81:	0f 84 82 00 00 00    	je     bb09 <fwp_pipe_flush+0xa9>
    ba87:	80 3d aa 04 03 00 00 	cmpb   $0x0,0x304aa(%rip)        # 3bf38 <fwp_po_gone>
    ba8e:	75 79                	jne    bb09 <fwp_pipe_flush+0xa9>
    ba90:	8b 2d 4e 03 01 00    	mov    0x1034e(%rip),%ebp        # 1bde4 <fwp_po_sock>
    ba96:	4c 8d 35 93 04 02 00 	lea    0x20493(%rip),%r14        # 2bf30 <fwp_po_buf>
    ba9d:	0f 1f 00             	nopl   (%rax)
    baa0:	89 ef                	mov    %ebp,%edi
    baa2:	4c 89 f6             	mov    %r14,%rsi
    baa5:	48 89 da             	mov    %rbx,%rdx
    baa8:	b9 00 40 00 00       	mov    $0x4000,%ecx
    baad:	e8 ee 76 ff ff       	call   31a0 <send@plt>
    bab2:	48 85 c0             	test   %rax,%rax
    bab5:	78 19                	js     bad0 <fwp_pipe_flush+0x70>
    bab7:	74 49                	je     bb02 <fwp_pipe_flush+0xa2>
    bab9:	49 01 c6             	add    %rax,%r14
    babc:	48 29 c3             	sub    %rax,%rbx
    babf:	eb 19                	jmp    bada <fwp_pipe_flush+0x7a>
    bac1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    bac8:	0f 1f 84 00 00 00 00 
    bacf:	00 
    bad0:	e8 ab 75 ff ff       	call   3080 <__errno_location@plt>
    bad5:	83 38 04             	cmpl   $0x4,(%rax)
    bad8:	75 28                	jne    bb02 <fwp_pipe_flush+0xa2>
    bada:	48 85 db             	test   %rbx,%rbx
    badd:	74 2a                	je     bb09 <fwp_pipe_flush+0xa9>
    badf:	f6 05 52 04 03 00 01 	testb  $0x1,0x30452(%rip)        # 3bf38 <fwp_po_gone>
    bae6:	74 b8                	je     baa0 <fwp_pipe_flush+0x40>
    bae8:	eb 1f                	jmp    bb09 <fwp_pipe_flush+0xa9>
    baea:	48 8b 05 bf e4 00 00 	mov    0xe4bf(%rip),%rax        # 19fb0 <stdout@GLIBC_2.2.5>
    baf1:	48 8b 38             	mov    (%rax),%rdi
    baf4:	e8 57 78 ff ff       	call   3350 <fflush@plt>
    baf9:	5b                   	pop    %rbx
    bafa:	41 5e                	pop    %r14
    bafc:	5d                   	pop    %rbp
    bafd:	e9 be 4f 00 00       	jmp    10ac0 <fwp_pipe_poll>
    bb02:	c6 05 2f 04 03 00 01 	movb   $0x1,0x3042f(%rip)        # 3bf38 <fwp_po_gone>
    bb09:	48 c7 05 14 04 02 00 	movq   $0x0,0x20414(%rip)        # 2bf28 <fwp_po_len>
    bb10:	00 00 00 00 
    bb14:	5b                   	pop    %rbx
    bb15:	41 5e                	pop    %r14
    bb17:	5d                   	pop    %rbp
    bb18:	c3                   	ret
    bb19:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000bb20 <fwp_exec_call>:
    bb20:	41 57                	push   %r15
    bb22:	41 56                	push   %r14
    bb24:	41 55                	push   %r13
    bb26:	41 54                	push   %r12
    bb28:	53                   	push   %rbx
    bb29:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
    bb30:	48 89 f3             	mov    %rsi,%rbx
    bb33:	49 89 fe             	mov    %rdi,%r14
    bb36:	48 8b 05 0b 04 03 00 	mov    0x3040b(%rip),%rax        # 3bf48 <fwp_handlers>
    bb3d:	48 89 84 24 e8 00 00 	mov    %rax,0xe8(%rsp)
    bb44:	00 
    bb45:	48 c7 84 24 00 01 00 	movq   $0x0,0x100(%rsp)
    bb4c:	00 00 00 00 00 
    bb51:	48 8b 05 68 03 01 00 	mov    0x10368(%rip),%rax        # 1bec0 <fwp_cleanups>
    bb58:	48 89 84 24 08 01 00 	mov    %rax,0x108(%rsp)
    bb5f:	00 
    bb60:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
    bb65:	48 89 3d dc 03 03 00 	mov    %rdi,0x303dc(%rip)        # 3bf48 <fwp_handlers>
    bb6c:	e8 3f 77 ff ff       	call   32b0 <_setjmp@plt>
    bb71:	85 c0                	test   %eax,%eax
    bb73:	0f 85 d1 00 00 00    	jne    bc4a <fwp_exec_call+0x12a>
    bb79:	48 ff 05 28 03 01 00 	incq   0x10328(%rip)        # 1bea8 <measured_calls>
    bb80:	48 83 05 28 03 01 00 	addq   $0x8,0x10328(%rip)        # 1beb0 <measured_bytes>
    bb87:	08 
    bb88:	48 8d 05 f9 e6 00 00 	lea    0xe6f9(%rip),%rax        # 1a288 <fwp_gc>
    bb8f:	0f b6 0d db f2 00 00 	movzbl 0xf2db(%rip),%ecx        # 1ae71 <fwp_gc+0xbe9>
    bb96:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    bb9d:	48 29 15 e4 e6 00 00 	sub    %rdx,0xe6e4(%rip)        # 1a288 <fwp_gc>
    bba4:	78 3a                	js     bbe0 <fwp_exec_call+0xc0>
    bba6:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    bbaa:	48 8d 34 c8          	lea    (%rax,%rcx,8),%rsi
    bbae:	48 81 c6 88 07 00 00 	add    $0x788,%rsi
    bbb5:	4c 8b 3e             	mov    (%rsi),%r15
    bbb8:	4d 85 ff             	test   %r15,%r15
    bbbb:	74 0b                	je     bbc8 <fwp_exec_call+0xa8>
    bbbd:	49 8b 07             	mov    (%r15),%rax
    bbc0:	48 f7 d0             	not    %rax
    bbc3:	48 89 06             	mov    %rax,(%rsi)
    bbc6:	eb 3d                	jmp    bc05 <fwp_exec_call+0xe5>
    bbc8:	4c 8b bc c8 90 07 00 	mov    0x790(%rax,%rcx,8),%r15
    bbcf:	00 
    bbd0:	48 8b b4 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%rsi
    bbd7:	00 
    bbd8:	4c 29 fe             	sub    %r15,%rsi
    bbdb:	48 39 d6             	cmp    %rdx,%rsi
    bbde:	73 14                	jae    bbf4 <fwp_exec_call+0xd4>
    bbe0:	bf 08 00 00 00       	mov    $0x8,%edi
    bbe5:	be 02 00 00 00       	mov    $0x2,%esi
    bbea:	e8 d1 c6 ff ff       	call   82c0 <fwp_gc_alloc_slow>
    bbef:	48 89 c7             	mov    %rax,%rdi
    bbf2:	eb 1e                	jmp    bc12 <fwp_exec_call+0xf2>
    bbf4:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    bbf8:	48 05 90 07 00 00    	add    $0x790,%rax
    bbfe:	49 8d 0c 17          	lea    (%r15,%rdx,1),%rcx
    bc02:	48 89 08             	mov    %rcx,(%rax)
    bc05:	4c 89 ff             	mov    %r15,%rdi
    bc08:	31 f6                	xor    %esi,%esi
    bc0a:	e8 01 76 ff ff       	call   3210 <memset@plt>
    bc0f:	4c 89 ff             	mov    %r15,%rdi
    bc12:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    bc19:	be 01 00 00 00       	mov    $0x1,%esi
    bc1e:	4c 89 f2             	mov    %r14,%rdx
    bc21:	e8 ba b7 ff ff       	call   73e0 <fwp_apply>
    bc26:	48 8b 8c 24 e8 00 00 	mov    0xe8(%rsp),%rcx
    bc2d:	00 
    bc2e:	48 89 0d 13 03 03 00 	mov    %rcx,0x30313(%rip)        # 3bf48 <fwp_handlers>
    bc35:	31 c9                	xor    %ecx,%ecx
    bc37:	89 0b                	mov    %ecx,(%rbx)
    bc39:	48 81 c4 10 01 00 00 	add    $0x110,%rsp
    bc40:	5b                   	pop    %rbx
    bc41:	41 5c                	pop    %r12
    bc43:	41 5d                	pop    %r13
    bc45:	41 5e                	pop    %r14
    bc47:	41 5f                	pop    %r15
    bc49:	c3                   	ret
    bc4a:	48 8b 84 24 e8 00 00 	mov    0xe8(%rsp),%rax
    bc51:	00 
    bc52:	48 89 05 ef 02 03 00 	mov    %rax,0x302ef(%rip)        # 3bf48 <fwp_handlers>
    bc59:	48 8b 3d 18 02 01 00 	mov    0x10218(%rip),%rdi        # 1be78 <fwp_prog_out>
    bc60:	48 85 ff             	test   %rdi,%rdi
    bc63:	74 05                	je     bc6a <fwp_exec_call+0x14a>
    bc65:	e8 e6 76 ff ff       	call   3350 <fflush@plt>
    bc6a:	48 8b 05 3f e3 00 00 	mov    0xe33f(%rip),%rax        # 19fb0 <stdout@GLIBC_2.2.5>
    bc71:	48 8b 38             	mov    (%rax),%rdi
    bc74:	e8 d7 76 ff ff       	call   3350 <fflush@plt>
    bc79:	4c 8b b4 24 f0 00 00 	mov    0xf0(%rsp),%r14
    bc80:	00 
    bc81:	4c 8b bc 24 f8 00 00 	mov    0xf8(%rsp),%r15
    bc88:	00 
    bc89:	e8 d2 fd ff ff       	call   ba60 <fwp_pipe_flush>
    bc8e:	4c 8b 2d 43 e3 00 00 	mov    0xe343(%rip),%r13        # 19fd8 <stderr@GLIBC_2.2.5>
    bc95:	49 8b 7d 00          	mov    0x0(%r13),%rdi
    bc99:	48 8d 35 bc aa 00 00 	lea    0xaabc(%rip),%rsi        # 1675c <exec_in_fp0+0xeec>
    bca0:	48 8d 15 2e 9d 00 00 	lea    0x9d2e(%rip),%rdx        # 159d5 <exec_in_fp0+0x165>
    bca7:	31 c0                	xor    %eax,%eax
    bca9:	e8 42 76 ff ff       	call   32f0 <fprintf@plt>
    bcae:	41 83 3f 10          	cmpl   $0x10,(%r15)
    bcb2:	75 20                	jne    bcd4 <fwp_exec_call+0x1b4>
    bcb4:	49 8b 7f 08          	mov    0x8(%r15),%rdi
    bcb8:	48 85 ff             	test   %rdi,%rdi
    bcbb:	74 17                	je     bcd4 <fwp_exec_call+0x1b4>
    bcbd:	48 8d 35 9d aa 00 00 	lea    0xaa9d(%rip),%rsi        # 16761 <exec_in_fp0+0xef1>
    bcc4:	e8 07 76 ff ff       	call   32d0 <strcmp@plt>
    bcc9:	85 c0                	test   %eax,%eax
    bccb:	75 07                	jne    bcd4 <fwp_exec_call+0x1b4>
    bccd:	41 83 7f 10 02       	cmpl   $0x2,0x10(%r15)
    bcd2:	74 6b                	je     bd3f <fwp_exec_call+0x21f>
    bcd4:	4d 8b 65 00          	mov    0x0(%r13),%r12
    bcd8:	0f 57 c0             	xorps  %xmm0,%xmm0
    bcdb:	0f 29 04 24          	movaps %xmm0,(%rsp)
    bcdf:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    bce6:	00 00 
    bce8:	48 89 e7             	mov    %rsp,%rdi
    bceb:	4c 89 f6             	mov    %r14,%rsi
    bcee:	4c 89 fa             	mov    %r15,%rdx
    bcf1:	b9 01 00 00 00       	mov    $0x1,%ecx
    bcf6:	e8 45 51 00 00       	call   10e40 <fwp_write>
    bcfb:	48 8b 3c 24          	mov    (%rsp),%rdi
    bcff:	48 85 ff             	test   %rdi,%rdi
    bd02:	75 23                	jne    bd27 <fwp_exec_call+0x207>
    bd04:	31 c0                	xor    %eax,%eax
    bd06:	89 c7                	mov    %eax,%edi
    bd08:	e8 43 73 ff ff       	call   3050 <free@plt>
    bd0d:	49 8b 75 00          	mov    0x0(%r13),%rsi
    bd11:	bf 0a 00 00 00       	mov    $0xa,%edi
    bd16:	e8 25 75 ff ff       	call   3240 <fputc@plt>
    bd1b:	b9 01 00 00 00       	mov    $0x1,%ecx
    bd20:	31 c0                	xor    %eax,%eax
    bd22:	e9 10 ff ff ff       	jmp    bc37 <fwp_exec_call+0x117>
    bd27:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    bd2c:	be 01 00 00 00       	mov    $0x1,%esi
    bd31:	4c 89 e1             	mov    %r12,%rcx
    bd34:	e8 47 77 ff ff       	call   3480 <fwrite@plt>
    bd39:	48 8b 3c 24          	mov    (%rsp),%rdi
    bd3d:	eb c9                	jmp    bd08 <fwp_exec_call+0x1e8>
    bd3f:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    bd43:	48 8b 17             	mov    (%rdi),%rdx
    bd46:	48 83 c7 08          	add    $0x8,%rdi
    bd4a:	49 8b 4d 00          	mov    0x0(%r13),%rcx
    bd4e:	be 01 00 00 00       	mov    $0x1,%esi
    bd53:	e8 28 77 ff ff       	call   3480 <fwrite@plt>
    bd58:	eb b3                	jmp    bd0d <fwp_exec_call+0x1ed>
    bd5a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000bd60 <fwp_emit_result>:
    bd60:	41 56                	push   %r14
    bd62:	53                   	push   %rbx
    bd63:	48 83 ec 28          	sub    $0x28,%rsp
    bd67:	48 89 fe             	mov    %rdi,%rsi
    bd6a:	83 3d 8f 01 02 00 00 	cmpl   $0x0,0x2018f(%rip)        # 2bf00 <fwp_exec_binary_out>
    bd71:	0f 84 89 00 00 00    	je     be00 <fwp_emit_result+0xa0>
    bd77:	0f 57 c0             	xorps  %xmm0,%xmm0
    bd7a:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    bd7f:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    bd86:	00 00 
    bd88:	48 8d 15 f1 ff 00 00 	lea    0xfff1(%rip),%rdx        # 1bd80 <d2>
    bd8f:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    bd94:	e8 a7 72 00 00       	call   13040 <fwp_encode>
    bd99:	c6 44 24 0b 01       	movb   $0x1,0xb(%rsp)
    bd9e:	8b 44 24 18          	mov    0x18(%rsp),%eax
    bda2:	89 44 24 0c          	mov    %eax,0xc(%rsp)
    bda6:	48 8d 7c 24 0b       	lea    0xb(%rsp),%rdi
    bdab:	be 05 00 00 00       	mov    $0x5,%esi
    bdb0:	e8 4b f8 ff ff       	call   b600 <fwp_pipe_write>
    bdb5:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    bdba:	48 85 f6             	test   %rsi,%rsi
    bdbd:	74 0a                	je     bdc9 <fwp_emit_result+0x69>
    bdbf:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    bdc4:	e8 37 f8 ff ff       	call   b600 <fwp_pipe_write>
    bdc9:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    bdce:	e8 7d 72 ff ff       	call   3050 <free@plt>
    bdd3:	83 3d 06 00 01 00 00 	cmpl   $0x0,0x10006(%rip)        # 1bde0 <fwp_po_listen>
    bdda:	0f 88 a4 00 00 00    	js     be84 <fwp_emit_result+0x124>
    bde0:	8b 05 6a 01 03 00    	mov    0x3016a(%rip),%eax        # 3bf50 <fwp_po_frames>
    bde6:	ff c0                	inc    %eax
    bde8:	89 05 62 01 03 00    	mov    %eax,0x30162(%rip)        # 3bf50 <fwp_po_frames>
    bdee:	a8 3f                	test   $0x3f,%al
    bdf0:	0f 85 8e 00 00 00    	jne    be84 <fwp_emit_result+0x124>
    bdf6:	e8 c5 4c 00 00       	call   10ac0 <fwp_pipe_poll>
    bdfb:	e9 84 00 00 00       	jmp    be84 <fwp_emit_result+0x124>
    be00:	83 3d 79 ff 00 00 10 	cmpl   $0x10,0xff79(%rip)        # 1bd80 <d2>
    be07:	75 13                	jne    be1c <fwp_emit_result+0xbc>
    be09:	83 3d 80 ff 00 00 00 	cmpl   $0x0,0xff80(%rip)        # 1bd90 <d2+0x10>
    be10:	75 0a                	jne    be1c <fwp_emit_result+0xbc>
    be12:	48 83 3d 6e ff 00 00 	cmpq   $0x0,0xff6e(%rip)        # 1bd88 <d2+0x8>
    be19:	00 
    be1a:	74 68                	je     be84 <fwp_emit_result+0x124>
    be1c:	4c 8b 35 8d e1 00 00 	mov    0xe18d(%rip),%r14        # 19fb0 <stdout@GLIBC_2.2.5>
    be23:	49 8b 1e             	mov    (%r14),%rbx
    be26:	0f 57 c0             	xorps  %xmm0,%xmm0
    be29:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    be2e:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    be35:	00 00 
    be37:	48 8d 15 42 ff 00 00 	lea    0xff42(%rip),%rdx        # 1bd80 <d2>
    be3e:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    be43:	b9 01 00 00 00       	mov    $0x1,%ecx
    be48:	e8 f3 4f 00 00       	call   10e40 <fwp_write>
    be4d:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    be52:	48 85 ff             	test   %rdi,%rdi
    be55:	74 19                	je     be70 <fwp_emit_result+0x110>
    be57:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
    be5c:	be 01 00 00 00       	mov    $0x1,%esi
    be61:	48 89 d9             	mov    %rbx,%rcx
    be64:	e8 17 76 ff ff       	call   3480 <fwrite@plt>
    be69:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    be6e:	eb 02                	jmp    be72 <fwp_emit_result+0x112>
    be70:	31 ff                	xor    %edi,%edi
    be72:	e8 d9 71 ff ff       	call   3050 <free@plt>
    be77:	49 8b 36             	mov    (%r14),%rsi
    be7a:	bf 0a 00 00 00       	mov    $0xa,%edi
    be7f:	e8 bc 73 ff ff       	call   3240 <fputc@plt>
    be84:	48 83 c4 28          	add    $0x28,%rsp
    be88:	5b                   	pop    %rbx
    be89:	41 5e                	pop    %r14
    be8b:	c3                   	ret
    be8c:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000be90 <fwp_read_exact>:
    be90:	55                   	push   %rbp
    be91:	41 57                	push   %r15
    be93:	41 56                	push   %r14
    be95:	41 55                	push   %r13
    be97:	41 54                	push   %r12
    be99:	53                   	push   %rbx
    be9a:	48 83 ec 48          	sub    $0x48,%rsp
    be9e:	49 89 f7             	mov    %rsi,%r15
    bea1:	49 89 fe             	mov    %rdi,%r14
    bea4:	45 31 ed             	xor    %r13d,%r13d
    bea7:	48 85 f6             	test   %rsi,%rsi
    beaa:	0f 84 b8 00 00 00    	je     bf68 <fwp_read_exact+0xd8>
    beb0:	8b 05 52 00 02 00    	mov    0x20052(%rip),%eax        # 2bf08 <fwp_in_npend>
    beb6:	8b 0d 50 00 02 00    	mov    0x20050(%rip),%ecx        # 2bf0c <fwp_in_ppos>
    bebc:	39 c1                	cmp    %eax,%ecx
    bebe:	0f 8d a4 00 00 00    	jge    bf68 <fwp_read_exact+0xd8>
    bec4:	48 98                	cltq
    bec6:	48 63 f1             	movslq %ecx,%rsi
    bec9:	48 89 f2             	mov    %rsi,%rdx
    becc:	48 f7 d2             	not    %rdx
    becf:	48 01 c2             	add    %rax,%rdx
    bed2:	49 8d 4f ff          	lea    -0x1(%r15),%rcx
    bed6:	48 39 ca             	cmp    %rcx,%rdx
    bed9:	48 0f 43 d1          	cmovae %rcx,%rdx
    bedd:	48 ff c2             	inc    %rdx
    bee0:	48 83 fa 20          	cmp    $0x20,%rdx
    bee4:	72 16                	jb     befc <fwp_read_exact+0x6c>
    bee6:	48 8d 3d 17 00 02 00 	lea    0x20017(%rip),%rdi        # 2bf04 <fwp_in_pend>
    beed:	4d 89 f0             	mov    %r14,%r8
    bef0:	49 29 f0             	sub    %rsi,%r8
    bef3:	49 29 f8             	sub    %rdi,%r8
    bef6:	49 83 f8 20          	cmp    $0x20,%r8
    befa:	73 2e                	jae    bf2a <fwp_read_exact+0x9a>
    befc:	45 31 ed             	xor    %r13d,%r13d
    beff:	48 89 f1             	mov    %rsi,%rcx
    bf02:	48 8d 15 fb ff 01 00 	lea    0x1fffb(%rip),%rdx        # 2bf04 <fwp_in_pend>
    bf09:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    bf10:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    bf14:	48 ff c1             	inc    %rcx
    bf17:	43 88 34 2e          	mov    %sil,(%r14,%r13,1)
    bf1b:	49 ff c5             	inc    %r13
    bf1e:	4d 39 fd             	cmp    %r15,%r13
    bf21:	73 3f                	jae    bf62 <fwp_read_exact+0xd2>
    bf23:	48 39 c1             	cmp    %rax,%rcx
    bf26:	7c e8                	jl     bf10 <fwp_read_exact+0x80>
    bf28:	eb 38                	jmp    bf62 <fwp_read_exact+0xd2>
    bf2a:	49 89 d5             	mov    %rdx,%r13
    bf2d:	49 83 e5 e0          	and    $0xffffffffffffffe0,%r13
    bf31:	4a 8d 0c 2e          	lea    (%rsi,%r13,1),%rcx
    bf35:	48 01 fe             	add    %rdi,%rsi
    bf38:	48 83 c6 10          	add    $0x10,%rsi
    bf3c:	31 ff                	xor    %edi,%edi
    bf3e:	66 90                	xchg   %ax,%ax
    bf40:	0f 10 44 3e f0       	movups -0x10(%rsi,%rdi,1),%xmm0
    bf45:	0f 10 0c 3e          	movups (%rsi,%rdi,1),%xmm1
    bf49:	41 0f 11 04 3e       	movups %xmm0,(%r14,%rdi,1)
    bf4e:	41 0f 11 4c 3e 10    	movups %xmm1,0x10(%r14,%rdi,1)
    bf54:	48 83 c7 20          	add    $0x20,%rdi
    bf58:	49 39 fd             	cmp    %rdi,%r13
    bf5b:	75 e3                	jne    bf40 <fwp_read_exact+0xb0>
    bf5d:	4c 39 ea             	cmp    %r13,%rdx
    bf60:	75 a0                	jne    bf02 <fwp_read_exact+0x72>
    bf62:	89 0d a4 ff 01 00    	mov    %ecx,0x1ffa4(%rip)        # 2bf0c <fwp_in_ppos>
    bf68:	4c 89 74 24 28       	mov    %r14,0x28(%rsp)
    bf6d:	4c 89 7c 24 38       	mov    %r15,0x38(%rsp)
    bf72:	eb 34                	jmp    bfa8 <fwp_read_exact+0x118>
    bf74:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    bf7b:	00 00 00 00 00 
    bf80:	48 8b 05 31 e0 00 00 	mov    0xe031(%rip),%rax        # 19fb8 <stdin@GLIBC_2.2.5>
    bf87:	48 8b 08             	mov    (%rax),%rcx
    bf8a:	be 01 00 00 00       	mov    $0x1,%esi
    bf8f:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    bf94:	48 89 da             	mov    %rbx,%rdx
    bf97:	e8 54 71 ff ff       	call   30f0 <fread@plt>
    bf9c:	49 01 c5             	add    %rax,%r13
    bf9f:	48 85 c0             	test   %rax,%rax
    bfa2:	0f 84 db 03 00 00    	je     c383 <fwp_read_exact+0x4f3>
    bfa8:	4c 89 fb             	mov    %r15,%rbx
    bfab:	4c 29 eb             	sub    %r13,%rbx
    bfae:	0f 86 e0 03 00 00    	jbe    c394 <fwp_read_exact+0x504>
    bfb4:	4b 8d 04 2e          	lea    (%r14,%r13,1),%rax
    bfb8:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    bfbd:	8b 05 91 ff 02 00    	mov    0x2ff91(%rip),%eax        # 3bf54 <fwp_pi_kind>
    bfc3:	83 f8 01             	cmp    $0x1,%eax
    bfc6:	0f 84 64 02 00 00    	je     c230 <fwp_read_exact+0x3a0>
    bfcc:	83 f8 02             	cmp    $0x2,%eax
    bfcf:	75 af                	jne    bf80 <fwp_read_exact+0xf0>
    bfd1:	4c 8b 3d 80 ff 02 00 	mov    0x2ff80(%rip),%r15        # 3bf58 <fwp_pi_ring>
    bfd8:	4d 8b 77 40          	mov    0x40(%r15),%r14
    bfdc:	49 8b 87 80 00 00 00 	mov    0x80(%r15),%rax
    bfe3:	49 39 c6             	cmp    %rax,%r14
    bfe6:	0f 85 94 02 00 00    	jne    c280 <fwp_read_exact+0x3f0>
    bfec:	49 8d 87 c0 00 00 00 	lea    0xc0(%r15),%rax
    bff3:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    bff8:	eb 25                	jmp    c01f <fwp_read_exact+0x18f>
    bffa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    c000:	41 c7 87 c4 00 00 00 	movl   $0x0,0xc4(%r15)
    c007:	00 00 00 00 
    c00b:	4d 8b 77 40          	mov    0x40(%r15),%r14
    c00f:	49 8b 87 80 00 00 00 	mov    0x80(%r15),%rax
    c016:	49 39 c6             	cmp    %rax,%r14
    c019:	0f 85 61 02 00 00    	jne    c280 <fwp_read_exact+0x3f0>
    c01f:	41 8b 87 40 01 00 00 	mov    0x140(%r15),%eax
    c026:	85 c0                	test   %eax,%eax
    c028:	74 11                	je     c03b <fwp_read_exact+0x1ab>
    c02a:	49 8b 47 40          	mov    0x40(%r15),%rax
    c02e:	49 3b 87 80 00 00 00 	cmp    0x80(%r15),%rax
    c035:	0f 84 48 03 00 00    	je     c383 <fwp_read_exact+0x4f3>
    c03b:	44 8b 25 aa fd 00 00 	mov    0xfdaa(%rip),%r12d        # 1bdec <fwp_pi_sock>
    c042:	8b 0d a0 fd 00 00    	mov    0xfda0(%rip),%ecx        # 1bde8 <fwp_ring_spin>
    c048:	85 c9                	test   %ecx,%ecx
    c04a:	78 14                	js     c060 <fwp_read_exact+0x1d0>
    c04c:	85 c9                	test   %ecx,%ecx
    c04e:	75 31                	jne    c081 <fwp_read_exact+0x1f1>
    c050:	e9 3b 01 00 00       	jmp    c190 <fwp_read_exact+0x300>
    c055:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    c05c:	00 00 00 00 
    c060:	bf 54 00 00 00       	mov    $0x54,%edi
    c065:	e8 b6 73 ff ff       	call   3420 <sysconf@plt>
    c06a:	31 c9                	xor    %ecx,%ecx
    c06c:	48 83 f8 02          	cmp    $0x2,%rax
    c070:	0f 9d c1             	setge  %cl
    c073:	89 0d 6f fd 00 00    	mov    %ecx,0xfd6f(%rip)        # 1bde8 <fwp_ring_spin>
    c079:	85 c9                	test   %ecx,%ecx
    c07b:	0f 84 0f 01 00 00    	je     c190 <fwp_read_exact+0x300>
    c081:	49 8b 47 40          	mov    0x40(%r15),%rax
    c085:	49 3b 87 80 00 00 00 	cmp    0x80(%r15),%rax
    c08c:	0f 85 79 ff ff ff    	jne    c00b <fwp_read_exact+0x17b>
    c092:	41 8b 87 40 01 00 00 	mov    0x140(%r15),%eax
    c099:	85 c0                	test   %eax,%eax
    c09b:	0f 85 6a ff ff ff    	jne    c00b <fwp_read_exact+0x17b>
    c0a1:	bd 01 00 00 00       	mov    $0x1,%ebp
    c0a6:	45 31 f6             	xor    %r14d,%r14d
    c0a9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    c0b0:	f3 90                	pause
    c0b2:	40 f6 c5 3f          	test   $0x3f,%bpl
    c0b6:	75 48                	jne    c100 <fwp_read_exact+0x270>
    c0b8:	e8 93 71 ff ff       	call   3250 <sched_yield@plt>
    c0bd:	bf 01 00 00 00       	mov    $0x1,%edi
    c0c2:	48 8d 74 24 18       	lea    0x18(%rsp),%rsi
    c0c7:	e8 64 70 ff ff       	call   3130 <clock_gettime@plt>
    c0cc:	48 69 44 24 18 00 ca 	imul   $0x3b9aca00,0x18(%rsp),%rax
    c0d3:	9a 3b 
    c0d5:	48 03 44 24 20       	add    0x20(%rsp),%rax
    c0da:	4d 85 f6             	test   %r14,%r14
    c0dd:	74 0a                	je     c0e9 <fwp_read_exact+0x259>
    c0df:	4c 39 f0             	cmp    %r14,%rax
    c0e2:	7e 1c                	jle    c100 <fwp_read_exact+0x270>
    c0e4:	e9 a7 00 00 00       	jmp    c190 <fwp_read_exact+0x300>
    c0e9:	48 05 50 c3 00 00    	add    $0xc350,%rax
    c0ef:	49 89 c6             	mov    %rax,%r14
    c0f2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c0f9:	1f 84 00 00 00 00 00 
    c100:	49 8b 47 40          	mov    0x40(%r15),%rax
    c104:	49 3b 87 80 00 00 00 	cmp    0x80(%r15),%rax
    c10b:	0f 85 fa fe ff ff    	jne    c00b <fwp_read_exact+0x17b>
    c111:	ff c5                	inc    %ebp
    c113:	41 8b 87 40 01 00 00 	mov    0x140(%r15),%eax
    c11a:	85 c0                	test   %eax,%eax
    c11c:	74 92                	je     c0b0 <fwp_read_exact+0x220>
    c11e:	e9 e8 fe ff ff       	jmp    c00b <fwp_read_exact+0x17b>
    c123:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c12a:	84 00 00 00 00 00 
    c130:	48 85 c0             	test   %rax,%rax
    c133:	74 5b                	je     c190 <fwp_read_exact+0x300>
    c135:	e8 46 6f ff ff       	call   3080 <__errno_location@plt>
    c13a:	83 38 6e             	cmpl   $0x6e,(%rax)
    c13d:	75 51                	jne    c190 <fwp_read_exact+0x300>
    c13f:	44 89 64 24 18       	mov    %r12d,0x18(%rsp)
    c144:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%rsp)
    c14b:	00 
    c14c:	be 01 00 00 00       	mov    $0x1,%esi
    c151:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    c156:	31 d2                	xor    %edx,%edx
    c158:	e8 63 72 ff ff       	call   33c0 <poll@plt>
    c15d:	85 c0                	test   %eax,%eax
    c15f:	7e 2f                	jle    c190 <fwp_read_exact+0x300>
    c161:	f6 44 24 1e 18       	testb  $0x18,0x1e(%rsp)
    c166:	0f 85 17 02 00 00    	jne    c383 <fwp_read_exact+0x4f3>
    c16c:	ba 01 00 00 00       	mov    $0x1,%edx
    c171:	44 89 e7             	mov    %r12d,%edi
    c174:	48 8d 74 24 17       	lea    0x17(%rsp),%rsi
    c179:	b9 42 00 00 00       	mov    $0x42,%ecx
    c17e:	e8 dd 6e ff ff       	call   3060 <recv@plt>
    c183:	48 85 c0             	test   %rax,%rax
    c186:	0f 84 f7 01 00 00    	je     c383 <fwp_read_exact+0x4f3>
    c18c:	0f 1f 40 00          	nopl   0x0(%rax)
    c190:	41 8b 8f c0 00 00 00 	mov    0xc0(%r15),%ecx
    c197:	b8 01 00 00 00       	mov    $0x1,%eax
    c19c:	41 87 87 c4 00 00 00 	xchg   %eax,0xc4(%r15)
    c1a3:	0f ae f0             	mfence
    c1a6:	49 8b 47 40          	mov    0x40(%r15),%rax
    c1aa:	49 3b 87 80 00 00 00 	cmp    0x80(%r15),%rax
    c1b1:	0f 85 49 fe ff ff    	jne    c000 <fwp_read_exact+0x170>
    c1b7:	41 8b 87 40 01 00 00 	mov    0x140(%r15),%eax
    c1be:	85 c0                	test   %eax,%eax
    c1c0:	0f 85 3a fe ff ff    	jne    c000 <fwp_read_exact+0x170>
    c1c6:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
    c1cd:	00 00 
    c1cf:	48 c7 44 24 20 00 e1 	movq   $0x5f5e100,0x20(%rsp)
    c1d6:	f5 05 
    c1d8:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    c1df:	bf ca 00 00 00       	mov    $0xca,%edi
    c1e4:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
    c1e9:	31 d2                	xor    %edx,%edx
    c1eb:	4c 8d 44 24 18       	lea    0x18(%rsp),%r8
    c1f0:	45 31 c9             	xor    %r9d,%r9d
    c1f3:	31 c0                	xor    %eax,%eax
    c1f5:	e8 06 71 ff ff       	call   3300 <syscall@plt>
    c1fa:	41 c7 87 c4 00 00 00 	movl   $0x0,0xc4(%r15)
    c201:	00 00 00 00 
    c205:	49 8b 4f 40          	mov    0x40(%r15),%rcx
    c209:	49 3b 8f 80 00 00 00 	cmp    0x80(%r15),%rcx
    c210:	0f 85 f5 fd ff ff    	jne    c00b <fwp_read_exact+0x17b>
    c216:	41 8b 8f 40 01 00 00 	mov    0x140(%r15),%ecx
    c21d:	85 c9                	test   %ecx,%ecx
    c21f:	0f 84 0b ff ff ff    	je     c130 <fwp_read_exact+0x2a0>
    c225:	e9 e1 fd ff ff       	jmp    c00b <fwp_read_exact+0x17b>
    c22a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    c230:	4c 8b 35 29 fd 02 00 	mov    0x2fd29(%rip),%r14        # 3bf60 <fwp_pi_pos>
    c237:	48 8b 05 2a fd 02 00 	mov    0x2fd2a(%rip),%rax        # 3bf68 <fwp_pi_len>
    c23e:	49 39 c6             	cmp    %rax,%r14
    c241:	0f 85 00 01 00 00    	jne    c347 <fwp_read_exact+0x4b7>
    c247:	4c 8d 35 22 fd 02 00 	lea    0x2fd22(%rip),%r14        # 3bf70 <fwp_pi_buf>
    c24e:	66 90                	xchg   %ax,%ax
    c250:	8b 3d 96 fb 00 00    	mov    0xfb96(%rip),%edi        # 1bdec <fwp_pi_sock>
    c256:	ba 00 00 01 00       	mov    $0x10000,%edx
    c25b:	4c 89 f6             	mov    %r14,%rsi
    c25e:	31 c9                	xor    %ecx,%ecx
    c260:	e8 fb 6d ff ff       	call   3060 <recv@plt>
    c265:	48 85 c0             	test   %rax,%rax
    c268:	0f 89 cd 00 00 00    	jns    c33b <fwp_read_exact+0x4ab>
    c26e:	e8 0d 6e ff ff       	call   3080 <__errno_location@plt>
    c273:	83 38 04             	cmpl   $0x4,(%rax)
    c276:	74 d8                	je     c250 <fwp_read_exact+0x3c0>
    c278:	e9 06 01 00 00       	jmp    c383 <fwp_read_exact+0x4f3>
    c27d:	0f 1f 00             	nopl   (%rax)
    c280:	49 29 c6             	sub    %rax,%r14
    c283:	49 39 de             	cmp    %rbx,%r14
    c286:	4c 0f 43 f3          	cmovae %rbx,%r14
    c28a:	49 8b 5f 08          	mov    0x8(%r15),%rbx
    c28e:	48 8d 4b ff          	lea    -0x1(%rbx),%rcx
    c292:	48 21 c1             	and    %rax,%rcx
    c295:	48 29 cb             	sub    %rcx,%rbx
    c298:	49 39 de             	cmp    %rbx,%r14
    c29b:	49 0f 42 de          	cmovb  %r14,%rbx
    c29f:	4d 8d a7 00 10 00 00 	lea    0x1000(%r15),%r12
    c2a6:	49 8d 34 0f          	lea    (%r15,%rcx,1),%rsi
    c2aa:	48 81 c6 00 10 00 00 	add    $0x1000,%rsi
    c2b1:	48 8b 6c 24 30       	mov    0x30(%rsp),%rbp
    c2b6:	48 89 ef             	mov    %rbp,%rdi
    c2b9:	48 89 da             	mov    %rbx,%rdx
    c2bc:	e8 6f 70 ff ff       	call   3330 <memcpy@plt>
    c2c1:	48 01 dd             	add    %rbx,%rbp
    c2c4:	4c 89 f2             	mov    %r14,%rdx
    c2c7:	48 29 da             	sub    %rbx,%rdx
    c2ca:	48 89 ef             	mov    %rbp,%rdi
    c2cd:	4c 89 e6             	mov    %r12,%rsi
    c2d0:	e8 5b 70 ff ff       	call   3330 <memcpy@plt>
    c2d5:	49 8b 8f 80 00 00 00 	mov    0x80(%r15),%rcx
    c2dc:	4c 01 f1             	add    %r14,%rcx
    c2df:	49 89 8f 80 00 00 00 	mov    %rcx,0x80(%r15)
    c2e6:	0f ae f0             	mfence
    c2e9:	41 8b 8f 04 01 00 00 	mov    0x104(%r15),%ecx
    c2f0:	85 c9                	test   %ecx,%ecx
    c2f2:	74 35                	je     c329 <fwp_read_exact+0x499>
    c2f4:	f0 41 ff 87 00 01 00 	lock incl 0x100(%r15)
    c2fb:	00 
    c2fc:	49 81 c7 00 01 00 00 	add    $0x100,%r15
    c303:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    c30a:	bf ca 00 00 00       	mov    $0xca,%edi
    c30f:	4c 89 fe             	mov    %r15,%rsi
    c312:	ba 01 00 00 00       	mov    $0x1,%edx
    c317:	b9 ff ff ff 7f       	mov    $0x7fffffff,%ecx
    c31c:	45 31 c0             	xor    %r8d,%r8d
    c31f:	45 31 c9             	xor    %r9d,%r9d
    c322:	31 c0                	xor    %eax,%eax
    c324:	e8 d7 6f ff ff       	call   3300 <syscall@plt>
    c329:	4c 89 f0             	mov    %r14,%rax
    c32c:	4c 8b 7c 24 38       	mov    0x38(%rsp),%r15
    c331:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    c336:	e9 61 fc ff ff       	jmp    bf9c <fwp_read_exact+0x10c>
    c33b:	74 46                	je     c383 <fwp_read_exact+0x4f3>
    c33d:	48 89 05 24 fc 02 00 	mov    %rax,0x2fc24(%rip)        # 3bf68 <fwp_pi_len>
    c344:	45 31 f6             	xor    %r14d,%r14d
    c347:	4c 29 f0             	sub    %r14,%rax
    c34a:	48 39 d8             	cmp    %rbx,%rax
    c34d:	48 0f 43 c3          	cmovae %rbx,%rax
    c351:	48 8d 0d 18 fc 02 00 	lea    0x2fc18(%rip),%rcx        # 3bf70 <fwp_pi_buf>
    c358:	4a 8d 34 31          	lea    (%rcx,%r14,1),%rsi
    c35c:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    c361:	48 89 c2             	mov    %rax,%rdx
    c364:	48 89 c3             	mov    %rax,%rbx
    c367:	e8 c4 6f ff ff       	call   3330 <memcpy@plt>
    c36c:	48 89 d8             	mov    %rbx,%rax
    c36f:	49 01 de             	add    %rbx,%r14
    c372:	4c 89 35 e7 fb 02 00 	mov    %r14,0x2fbe7(%rip)        # 3bf60 <fwp_pi_pos>
    c379:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    c37e:	e9 19 fc ff ff       	jmp    bf9c <fwp_read_exact+0x10c>
    c383:	31 c0                	xor    %eax,%eax
    c385:	48 83 c4 48          	add    $0x48,%rsp
    c389:	5b                   	pop    %rbx
    c38a:	41 5c                	pop    %r12
    c38c:	41 5d                	pop    %r13
    c38e:	41 5e                	pop    %r14
    c390:	41 5f                	pop    %r15
    c392:	5d                   	pop    %rbp
    c393:	c3                   	ret
    c394:	b8 01 00 00 00       	mov    $0x1,%eax
    c399:	eb ea                	jmp    c385 <fwp_read_exact+0x4f5>
    c39b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000c3a0 <fwp_stdin_name_len>:
    c3a0:	41 57                	push   %r15
    c3a2:	41 56                	push   %r14
    c3a4:	53                   	push   %rbx
    c3a5:	48 83 ec 10          	sub    $0x10,%rsp
    c3a9:	48 89 fb             	mov    %rdi,%rbx
    c3ac:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    c3b3:	49 c7 c6 f9 ff ff ff 	mov    $0xfffffffffffffff9,%r14
    c3ba:	4c 8d 7c 24 0f       	lea    0xf(%rsp),%r15
    c3bf:	90                   	nop
    c3c0:	be 01 00 00 00       	mov    $0x1,%esi
    c3c5:	4c 89 ff             	mov    %r15,%rdi
    c3c8:	e8 c3 fa ff ff       	call   be90 <fwp_read_exact>
    c3cd:	85 c0                	test   %eax,%eax
    c3cf:	74 38                	je     c409 <fwp_stdin_name_len+0x69>
    c3d1:	0f b6 44 24 0f       	movzbl 0xf(%rsp),%eax
    c3d6:	49 83 fe 38          	cmp    $0x38,%r14
    c3da:	75 07                	jne    c3e3 <fwp_stdin_name_len+0x43>
    c3dc:	89 c1                	mov    %eax,%ecx
    c3de:	80 e1 7e             	and    $0x7e,%cl
    c3e1:	75 1f                	jne    c402 <fwp_stdin_name_len+0x62>
    c3e3:	49 83 c6 07          	add    $0x7,%r14
    c3e7:	89 c2                	mov    %eax,%edx
    c3e9:	83 e2 7f             	and    $0x7f,%edx
    c3ec:	44 89 f1             	mov    %r14d,%ecx
    c3ef:	48 d3 e2             	shl    %cl,%rdx
    c3f2:	48 0b 13             	or     (%rbx),%rdx
    c3f5:	48 89 13             	mov    %rdx,(%rbx)
    c3f8:	84 c0                	test   %al,%al
    c3fa:	79 11                	jns    c40d <fwp_stdin_name_len+0x6d>
    c3fc:	49 83 fe 38          	cmp    $0x38,%r14
    c400:	76 be                	jbe    c3c0 <fwp_stdin_name_len+0x20>
    c402:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    c407:	eb 13                	jmp    c41c <fwp_stdin_name_len+0x7c>
    c409:	31 c0                	xor    %eax,%eax
    c40b:	eb 0f                	jmp    c41c <fwp_stdin_name_len+0x7c>
    c40d:	31 c0                	xor    %eax,%eax
    c40f:	48 81 fa 01 00 10 00 	cmp    $0x100001,%rdx
    c416:	83 d0 ff             	adc    $0xffffffff,%eax
    c419:	83 c8 01             	or     $0x1,%eax
    c41c:	48 83 c4 10          	add    $0x10,%rsp
    c420:	5b                   	pop    %rbx
    c421:	41 5e                	pop    %r14
    c423:	41 5f                	pop    %r15
    c425:	c3                   	ret
    c426:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    c42d:	00 00 00 

000000000000c430 <fwp_pipe_in_offer>:
    c430:	55                   	push   %rbp
    c431:	41 56                	push   %r14
    c433:	53                   	push   %rbx
    c434:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
    c43b:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
    c442:	00 
    c443:	31 ff                	xor    %edi,%edi
    c445:	e8 76 70 ff ff       	call   34c0 <fstat@plt>
    c44a:	85 c0                	test   %eax,%eax
    c44c:	0f 85 29 01 00 00    	jne    c57b <fwp_pipe_in_offer+0x14b>
    c452:	b8 00 f0 00 00       	mov    $0xf000,%eax
    c457:	23 84 24 98 00 00 00 	and    0x98(%rsp),%eax
    c45e:	3d 00 10 00 00       	cmp    $0x1000,%eax
    c463:	0f 85 12 01 00 00    	jne    c57b <fwp_pipe_in_offer+0x14b>
    c469:	bf 01 00 00 00       	mov    $0x1,%edi
    c46e:	be 01 00 08 00       	mov    $0x80001,%esi
    c473:	31 d2                	xor    %edx,%edx
    c475:	e8 76 70 ff ff       	call   34f0 <socket@plt>
    c47a:	85 c0                	test   %eax,%eax
    c47c:	0f 88 f9 00 00 00    	js     c57b <fwp_pipe_in_offer+0x14b>
    c482:	89 c3                	mov    %eax,%ebx
    c484:	0f 57 c0             	xorps  %xmm0,%xmm0
    c487:	0f 11 44 24 70       	movups %xmm0,0x70(%rsp)
    c48c:	0f 11 44 24 64       	movups %xmm0,0x64(%rsp)
    c491:	0f 11 44 24 54       	movups %xmm0,0x54(%rsp)
    c496:	0f 11 44 24 44       	movups %xmm0,0x44(%rsp)
    c49b:	0f 11 44 24 34       	movups %xmm0,0x34(%rsp)
    c4a0:	0f 11 44 24 24       	movups %xmm0,0x24(%rsp)
    c4a5:	0f 11 44 24 14       	movups %xmm0,0x14(%rsp)
    c4aa:	66 c7 44 24 12 01 00 	movw   $0x1,0x12(%rsp)
    c4b1:	48 8d 7c 24 15       	lea    0x15(%rsp),%rdi
    c4b6:	48 8b 8c 24 80 00 00 	mov    0x80(%rsp),%rcx
    c4bd:	00 
    c4be:	4c 8b 84 24 88 00 00 	mov    0x88(%rsp),%r8
    c4c5:	00 
    c4c6:	48 8d 15 56 a2 00 00 	lea    0xa256(%rip),%rdx        # 16723 <exec_in_fp0+0xeb3>
    c4cd:	be 6b 00 00 00       	mov    $0x6b,%esi
    c4d2:	31 c0                	xor    %eax,%eax
    c4d4:	e8 f7 6c ff ff       	call   31d0 <snprintf@plt>
    c4d9:	89 c5                	mov    %eax,%ebp
    c4db:	83 c5 03             	add    $0x3,%ebp
    c4de:	48 8d 3d 2a a2 00 00 	lea    0xa22a(%rip),%rdi        # 1670f <exec_in_fp0+0xe9f>
    c4e5:	e8 46 6b ff ff       	call   3030 <getenv@plt>
    c4ea:	48 85 c0             	test   %rax,%rax
    c4ed:	74 36                	je     c525 <fwp_pipe_in_offer+0xf5>
    c4ef:	49 89 c6             	mov    %rax,%r14
    c4f2:	48 8d 35 24 a2 00 00 	lea    0xa224(%rip),%rsi        # 1671d <exec_in_fp0+0xead>
    c4f9:	48 89 c7             	mov    %rax,%rdi
    c4fc:	e8 cf 6d ff ff       	call   32d0 <strcmp@plt>
    c501:	c7 44 24 0c 46 57 50 	movl   $0x54505746,0xc(%rsp)
    c508:	54 
    c509:	85 c0                	test   %eax,%eax
    c50b:	74 27                	je     c534 <fwp_pipe_in_offer+0x104>
    c50d:	48 8d 35 ce a2 00 00 	lea    0xa2ce(%rip),%rsi        # 167e2 <exec_in_fp0+0xf72>
    c514:	4c 89 f7             	mov    %r14,%rdi
    c517:	e8 b4 6d ff ff       	call   32d0 <strcmp@plt>
    c51c:	83 f8 01             	cmp    $0x1,%eax
    c51f:	b0 02                	mov    $0x2,%al
    c521:	1c 00                	sbb    $0x0,%al
    c523:	eb 0a                	jmp    c52f <fwp_pipe_in_offer+0xff>
    c525:	c7 44 24 0c 46 57 50 	movl   $0x54505746,0xc(%rsp)
    c52c:	54 
    c52d:	b0 02                	mov    $0x2,%al
    c52f:	45 31 f6             	xor    %r14d,%r14d
    c532:	eb 05                	jmp    c539 <fwp_pipe_in_offer+0x109>
    c534:	31 c0                	xor    %eax,%eax
    c536:	41 b6 01             	mov    $0x1,%r14b
    c539:	88 44 24 10          	mov    %al,0x10(%rsp)
    c53d:	48 8d 74 24 12       	lea    0x12(%rsp),%rsi
    c542:	89 df                	mov    %ebx,%edi
    c544:	89 ea                	mov    %ebp,%edx
    c546:	e8 25 6f ff ff       	call   3470 <connect@plt>
    c54b:	85 c0                	test   %eax,%eax
    c54d:	75 25                	jne    c574 <fwp_pipe_in_offer+0x144>
    c54f:	48 8d 74 24 0c       	lea    0xc(%rsp),%rsi
    c554:	ba 05 00 00 00       	mov    $0x5,%edx
    c559:	89 df                	mov    %ebx,%edi
    c55b:	b9 00 40 00 00       	mov    $0x4000,%ecx
    c560:	e8 3b 6c ff ff       	call   31a0 <send@plt>
    c565:	48 83 f8 05          	cmp    $0x5,%rax
    c569:	0f 94 c0             	sete   %al
    c56c:	41 f6 d6             	not    %r14b
    c56f:	41 84 c6             	test   %al,%r14b
    c572:	75 13                	jne    c587 <fwp_pipe_in_offer+0x157>
    c574:	89 df                	mov    %ebx,%edi
    c576:	e8 b5 6c ff ff       	call   3230 <close@plt>
    c57b:	48 81 c4 10 01 00 00 	add    $0x110,%rsp
    c582:	5b                   	pop    %rbx
    c583:	41 5e                	pop    %r14
    c585:	5d                   	pop    %rbp
    c586:	c3                   	ret
    c587:	89 1d 5f f8 00 00    	mov    %ebx,0xf85f(%rip)        # 1bdec <fwp_pi_sock>
    c58d:	eb ec                	jmp    c57b <fwp_pipe_in_offer+0x14b>
    c58f:	90                   	nop

000000000000c590 <fwp_decode>:
    c590:	55                   	push   %rbp
    c591:	41 57                	push   %r15
    c593:	41 56                	push   %r14
    c595:	41 55                	push   %r13
    c597:	41 54                	push   %r12
    c599:	53                   	push   %rbx
    c59a:	48 83 ec 38          	sub    $0x38,%rsp
    c59e:	8b 06                	mov    (%rsi),%eax
    c5a0:	45 31 e4             	xor    %r12d,%r12d
    c5a3:	48 83 f8 15          	cmp    $0x15,%rax
    c5a7:	0f 87 f3 00 00 00    	ja     c6a0 <fwp_decode+0x110>
    c5ad:	48 89 d5             	mov    %rdx,%rbp
    c5b0:	49 89 f7             	mov    %rsi,%r15
    c5b3:	49 89 fe             	mov    %rdi,%r14
    c5b6:	48 8d 0d 23 8c 00 00 	lea    0x8c23(%rip),%rcx        # 151e0 <_IO_stdin_used+0x1e0>
    c5bd:	48 63 14 81          	movslq (%rcx,%rax,4),%rdx
    c5c1:	48 01 ca             	add    %rcx,%rdx
    c5c4:	ff e2                	jmp    *%rdx
    c5c6:	31 c9                	xor    %ecx,%ecx
    c5c8:	83 f8 0a             	cmp    $0xa,%eax
    c5cb:	0f 95 c1             	setne  %cl
    c5ce:	4c 8d 04 8d 04 00 00 	lea    0x4(,%rcx,4),%r8
    c5d5:	00 
    c5d6:	49 8b 46 08          	mov    0x8(%r14),%rax
    c5da:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    c5de:	48 29 f8             	sub    %rdi,%rax
    c5e1:	4c 39 c0             	cmp    %r8,%rax
    c5e4:	0f 82 b6 00 00 00    	jb     c6a0 <fwp_decode+0x110>
    c5ea:	49 8b 16             	mov    (%r14),%rdx
    c5ed:	4a 8d 04 07          	lea    (%rdi,%r8,1),%rax
    c5f1:	49 89 46 10          	mov    %rax,0x10(%r14)
    c5f5:	44 89 c6             	mov    %r8d,%esi
    c5f8:	83 e6 03             	and    $0x3,%esi
    c5fb:	49 83 f8 04          	cmp    $0x4,%r8
    c5ff:	73 08                	jae    c609 <fwp_decode+0x79>
    c601:	45 31 d2             	xor    %r10d,%r10d
    c604:	45 31 c9             	xor    %r9d,%r9d
    c607:	eb 5e                	jmp    c667 <fwp_decode+0xd7>
    c609:	41 83 e0 fc          	and    $0xfffffffc,%r8d
    c60d:	4c 8d 1c 17          	lea    (%rdi,%rdx,1),%r11
    c611:	49 83 c3 03          	add    $0x3,%r11
    c615:	b8 18 00 00 00       	mov    $0x18,%eax
    c61a:	45 31 d2             	xor    %r10d,%r10d
    c61d:	45 31 c9             	xor    %r9d,%r9d
    c620:	43 0f b6 5c 13 fd    	movzbl -0x3(%r11,%r10,1),%ebx
    c626:	8d 48 e8             	lea    -0x18(%rax),%ecx
    c629:	48 d3 e3             	shl    %cl,%rbx
    c62c:	47 0f b6 74 13 fe    	movzbl -0x2(%r11,%r10,1),%r14d
    c632:	8d 48 f0             	lea    -0x10(%rax),%ecx
    c635:	49 d3 e6             	shl    %cl,%r14
    c638:	47 0f b6 7c 13 ff    	movzbl -0x1(%r11,%r10,1),%r15d
    c63e:	8d 48 f8             	lea    -0x8(%rax),%ecx
    c641:	49 d3 e7             	shl    %cl,%r15
    c644:	4c 09 cb             	or     %r9,%rbx
    c647:	4d 09 f7             	or     %r14,%r15
    c64a:	49 09 df             	or     %rbx,%r15
    c64d:	47 0f b6 0c 13       	movzbl (%r11,%r10,1),%r9d
    c652:	89 c1                	mov    %eax,%ecx
    c654:	49 d3 e1             	shl    %cl,%r9
    c657:	4d 09 f9             	or     %r15,%r9
    c65a:	49 83 c2 04          	add    $0x4,%r10
    c65e:	48 83 c0 20          	add    $0x20,%rax
    c662:	4d 39 d0             	cmp    %r10,%r8
    c665:	75 b9                	jne    c620 <fwp_decode+0x90>
    c667:	48 85 f6             	test   %rsi,%rsi
    c66a:	74 2a                	je     c696 <fwp_decode+0x106>
    c66c:	4a 8d 0c d5 00 00 00 	lea    0x0(,%r10,8),%rcx
    c673:	00 
    c674:	4c 01 d7             	add    %r10,%rdi
    c677:	48 01 fa             	add    %rdi,%rdx
    c67a:	31 c0                	xor    %eax,%eax
    c67c:	0f 1f 40 00          	nopl   0x0(%rax)
    c680:	0f b6 3c 02          	movzbl (%rdx,%rax,1),%edi
    c684:	48 d3 e7             	shl    %cl,%rdi
    c687:	49 09 f9             	or     %rdi,%r9
    c68a:	48 ff c0             	inc    %rax
    c68d:	48 83 c1 08          	add    $0x8,%rcx
    c691:	48 39 c6             	cmp    %rax,%rsi
    c694:	75 ea                	jne    c680 <fwp_decode+0xf0>
    c696:	4c 89 4d 00          	mov    %r9,0x0(%rbp)
    c69a:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    c6a0:	44 89 e0             	mov    %r12d,%eax
    c6a3:	48 83 c4 38          	add    $0x38,%rsp
    c6a7:	5b                   	pop    %rbx
    c6a8:	41 5c                	pop    %r12
    c6aa:	41 5d                	pop    %r13
    c6ac:	41 5e                	pop    %r14
    c6ae:	41 5f                	pop    %r15
    c6b0:	5d                   	pop    %rbp
    c6b1:	c3                   	ret
    c6b2:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    c6b7:	4c 89 f7             	mov    %r14,%rdi
    c6ba:	e8 51 71 00 00       	call   13810 <rd_leb>
    c6bf:	85 c0                	test   %eax,%eax
    c6c1:	74 dd                	je     c6a0 <fwp_decode+0x110>
    c6c3:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
    c6c8:	49 8b 4e 08          	mov    0x8(%r14),%rcx
    c6cc:	49 39 cd             	cmp    %rcx,%r13
    c6cf:	77 cf                	ja     c6a0 <fwp_decode+0x110>
    c6d1:	49 8b 46 10          	mov    0x10(%r14),%rax
    c6d5:	48 29 c1             	sub    %rax,%rcx
    c6d8:	4c 39 e9             	cmp    %r13,%rcx
    c6db:	72 c3                	jb     c6a0 <fwp_decode+0x110>
    c6dd:	48 89 eb             	mov    %rbp,%rbx
    c6e0:	49 8b 2e             	mov    (%r14),%rbp
    c6e3:	48 01 c5             	add    %rax,%rbp
    c6e6:	4c 01 e8             	add    %r13,%rax
    c6e9:	49 89 46 10          	mov    %rax,0x10(%r14)
    c6ed:	41 83 3f 0c          	cmpl   $0xc,(%r15)
    c6f1:	75 0f                	jne    c702 <fwp_decode+0x172>
    c6f3:	48 89 ef             	mov    %rbp,%rdi
    c6f6:	4c 89 ee             	mov    %r13,%rsi
    c6f9:	e8 d2 08 00 00       	call   cfd0 <fwp_valid_utf8>
    c6fe:	85 c0                	test   %eax,%eax
    c700:	74 9e                	je     c6a0 <fwp_decode+0x110>
    c702:	48 89 ef             	mov    %rbp,%rdi
    c705:	4c 89 ee             	mov    %r13,%rsi
    c708:	e8 23 0a 00 00       	call   d130 <fwp_str_new>
    c70d:	48 89 03             	mov    %rax,(%rbx)
    c710:	eb 88                	jmp    c69a <fwp_decode+0x10a>
    c712:	49 8b 46 10          	mov    0x10(%r14),%rax
    c716:	49 39 46 08          	cmp    %rax,0x8(%r14)
    c71a:	74 84                	je     c6a0 <fwp_decode+0x110>
    c71c:	49 8b 0e             	mov    (%r14),%rcx
    c71f:	48 8d 50 01          	lea    0x1(%rax),%rdx
    c723:	49 89 56 10          	mov    %rdx,0x10(%r14)
    c727:	48 0f be 04 01       	movsbq (%rcx,%rax,1),%rax
    c72c:	48 89 45 00          	mov    %rax,0x0(%rbp)
    c730:	e9 65 ff ff ff       	jmp    c69a <fwp_decode+0x10a>
    c735:	49 8b 76 08          	mov    0x8(%r14),%rsi
    c739:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    c73d:	48 89 f2             	mov    %rsi,%rdx
    c740:	48 29 ca             	sub    %rcx,%rdx
    c743:	48 83 fa 08          	cmp    $0x8,%rdx
    c747:	0f 82 53 ff ff ff    	jb     c6a0 <fwp_decode+0x110>
    c74d:	49 8b 16             	mov    (%r14),%rdx
    c750:	48 8d 79 08          	lea    0x8(%rcx),%rdi
    c754:	49 89 7e 10          	mov    %rdi,0x10(%r14)
    c758:	48 29 fe             	sub    %rdi,%rsi
    c75b:	48 83 fe 08          	cmp    $0x8,%rsi
    c75f:	0f 82 3b ff ff ff    	jb     c6a0 <fwp_decode+0x110>
    c765:	48 8b 3c 0a          	mov    (%rdx,%rcx,1),%rdi
    c769:	48 8d 71 10          	lea    0x10(%rcx),%rsi
    c76d:	49 89 76 10          	mov    %rsi,0x10(%r14)
    c771:	48 8b 74 0a 08       	mov    0x8(%rdx,%rcx,1),%rsi
    c776:	83 f8 04             	cmp    $0x4,%eax
    c779:	0f 85 e7 03 00 00    	jne    cb66 <fwp_decode+0x5d6>
    c77f:	e8 dc 3b 00 00       	call   10360 <fwp_box_i128>
    c784:	48 89 45 00          	mov    %rax,0x0(%rbp)
    c788:	e9 0d ff ff ff       	jmp    c69a <fwp_decode+0x10a>
    c78d:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    c792:	49 8b 6f 38          	mov    0x38(%r15),%rbp
    c796:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    c79b:	4c 89 f7             	mov    %r14,%rdi
    c79e:	e8 6d 70 00 00       	call   13810 <rd_leb>
    c7a3:	85 c0                	test   %eax,%eax
    c7a5:	0f 84 f5 fe ff ff    	je     c6a0 <fwp_decode+0x110>
    c7ab:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
    c7b0:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    c7b7:	ff ff 1f 
    c7ba:	49 39 c5             	cmp    %rax,%r13
    c7bd:	0f 87 dd fe ff ff    	ja     c6a0 <fwp_decode+0x110>
    c7c3:	45 31 e4             	xor    %r12d,%r12d
    c7c6:	48 89 ef             	mov    %rbp,%rdi
    c7c9:	31 f6                	xor    %esi,%esi
    c7cb:	e8 20 72 00 00       	call   139f0 <fwp_wire_empty_inner>
    c7d0:	85 c0                	test   %eax,%eax
    c7d2:	75 0a                	jne    c7de <fwp_decode+0x24e>
    c7d4:	4d 3b 6e 08          	cmp    0x8(%r14),%r13
    c7d8:	0f 87 c2 fe ff ff    	ja     c6a0 <fwp_decode+0x110>
    c7de:	41 83 3f 11          	cmpl   $0x11,(%r15)
    c7e2:	0f 85 fe 02 00 00    	jne    cae6 <fwp_decode+0x556>
    c7e8:	49 8b 77 38          	mov    0x38(%r15),%rsi
    c7ec:	4c 89 ef             	mov    %r13,%rdi
    c7ef:	e8 3c 90 ff ff       	call   5830 <fwp_array_new_packed>
    c7f4:	49 89 c4             	mov    %rax,%r12
    c7f7:	4d 85 ed             	test   %r13,%r13
    c7fa:	0f 84 2e 04 00 00    	je     cc2e <fwp_decode+0x69e>
    c800:	31 ed                	xor    %ebp,%ebp
    c802:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    c807:	eb 11                	jmp    c81a <fwp_decode+0x28a>
    c809:	49 89 44 ec 08       	mov    %rax,0x8(%r12,%rbp,8)
    c80e:	48 ff c5             	inc    %rbp
    c811:	49 39 ed             	cmp    %rbp,%r13
    c814:	0f 84 14 04 00 00    	je     cc2e <fwp_decode+0x69e>
    c81a:	49 8b 77 38          	mov    0x38(%r15),%rsi
    c81e:	4c 89 f7             	mov    %r14,%rdi
    c821:	48 89 da             	mov    %rbx,%rdx
    c824:	e8 67 fd ff ff       	call   c590 <fwp_decode>
    c829:	85 c0                	test   %eax,%eax
    c82b:	0f 84 f2 05 00 00    	je     ce23 <fwp_decode+0x893>
    c831:	49 83 3c 24 00       	cmpq   $0x0,(%r12)
    c836:	0f 88 ef 05 00 00    	js     ce2b <fwp_decode+0x89b>
    c83c:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    c841:	49 8b 4f 38          	mov    0x38(%r15),%rcx
    c845:	48 85 c9             	test   %rcx,%rcx
    c848:	74 bf                	je     c809 <fwp_decode+0x279>
    c84a:	8b 09                	mov    (%rcx),%ecx
    c84c:	83 f9 0a             	cmp    $0xa,%ecx
    c84f:	77 b8                	ja     c809 <fwp_decode+0x279>
    c851:	ba 84 04 00 00       	mov    $0x484,%edx
    c856:	0f a3 ca             	bt     %ecx,%edx
    c859:	72 1c                	jb     c877 <fwp_decode+0x2e7>
    c85b:	ba 21 00 00 00       	mov    $0x21,%edx
    c860:	0f a3 ca             	bt     %ecx,%edx
    c863:	72 19                	jb     c87e <fwp_decode+0x2ee>
    c865:	ba 42 00 00 00       	mov    $0x42,%edx
    c86a:	0f a3 ca             	bt     %ecx,%edx
    c86d:	73 9a                	jae    c809 <fwp_decode+0x279>
    c86f:	66 41 89 44 6c 08    	mov    %ax,0x8(%r12,%rbp,2)
    c875:	eb 97                	jmp    c80e <fwp_decode+0x27e>
    c877:	41 89 44 ac 08       	mov    %eax,0x8(%r12,%rbp,4)
    c87c:	eb 90                	jmp    c80e <fwp_decode+0x27e>
    c87e:	41 88 44 2c 08       	mov    %al,0x8(%r12,%rbp,1)
    c883:	eb 89                	jmp    c80e <fwp_decode+0x27e>
    c885:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    c88a:	4c 89 f7             	mov    %r14,%rdi
    c88d:	e8 7e 6f 00 00       	call   13810 <rd_leb>
    c892:	85 c0                	test   %eax,%eax
    c894:	0f 84 06 fe ff ff    	je     c6a0 <fwp_decode+0x110>
    c89a:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    c89f:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
    c8a4:	49 63 47 10          	movslq 0x10(%r15),%rax
    c8a8:	49 39 c5             	cmp    %rax,%r13
    c8ab:	0f 83 ef fd ff ff    	jae    c6a0 <fwp_decode+0x110>
    c8b1:	49 8b 47 28          	mov    0x28(%r15),%rax
    c8b5:	4a 63 1c a8          	movslq (%rax,%r13,4),%rbx
    c8b9:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    c8c0:	00 
    c8c1:	e8 4a b9 ff ff       	call   8210 <fwp_alloc>
    c8c6:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    c8cb:	89 d8                	mov    %ebx,%eax
    c8cd:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    c8d2:	48 85 db             	test   %rbx,%rbx
    c8d5:	7e 40                	jle    c917 <fwp_decode+0x387>
    c8d7:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    c8dc:	48 8d 1c c5 00 00 00 	lea    0x0(,%rax,8),%rbx
    c8e3:	00 
    c8e4:	45 31 e4             	xor    %r12d,%r12d
    c8e7:	31 ed                	xor    %ebp,%ebp
    c8e9:	49 8b 47 30          	mov    0x30(%r15),%rax
    c8ed:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    c8f1:	48 8b 34 28          	mov    (%rax,%rbp,1),%rsi
    c8f5:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    c8fa:	48 8d 14 28          	lea    (%rax,%rbp,1),%rdx
    c8fe:	4c 89 f7             	mov    %r14,%rdi
    c901:	e8 8a fc ff ff       	call   c590 <fwp_decode>
    c906:	85 c0                	test   %eax,%eax
    c908:	0f 84 92 fd ff ff    	je     c6a0 <fwp_decode+0x110>
    c90e:	48 83 c5 08          	add    $0x8,%rbp
    c912:	48 39 eb             	cmp    %rbp,%rbx
    c915:	75 d2                	jne    c8e9 <fwp_decode+0x359>
    c917:	44 89 ef             	mov    %r13d,%edi
    c91a:	48 8b 74 24 28       	mov    0x28(%rsp),%rsi
    c91f:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
    c924:	e8 27 0d 00 00       	call   d650 <fwp_data>
    c929:	e9 e8 04 00 00       	jmp    ce16 <fwp_decode+0x886>
    c92e:	41 b8 01 00 00 00    	mov    $0x1,%r8d
    c934:	e9 9d fc ff ff       	jmp    c5d6 <fwp_decode+0x46>
    c939:	41 b8 02 00 00 00    	mov    $0x2,%r8d
    c93f:	e9 92 fc ff ff       	jmp    c5d6 <fwp_decode+0x46>
    c944:	49 8b 4e 08          	mov    0x8(%r14),%rcx
    c948:	49 8b 46 10          	mov    0x10(%r14),%rax
    c94c:	48 29 c1             	sub    %rax,%rcx
    c94f:	48 83 f9 02          	cmp    $0x2,%rcx
    c953:	0f 82 47 fd ff ff    	jb     c6a0 <fwp_decode+0x110>
    c959:	49 8b 0e             	mov    (%r14),%rcx
    c95c:	48 8d 50 02          	lea    0x2(%rax),%rdx
    c960:	49 89 56 10          	mov    %rdx,0x10(%r14)
    c964:	0f b6 14 01          	movzbl (%rcx,%rax,1),%edx
    c968:	0f b6 44 01 01       	movzbl 0x1(%rcx,%rax,1),%eax
    c96d:	48 c1 e0 38          	shl    $0x38,%rax
    c971:	48 c1 e2 30          	shl    $0x30,%rdx
    c975:	48 09 c2             	or     %rax,%rdx
    c978:	48 c1 fa 30          	sar    $0x30,%rdx
    c97c:	48 89 55 00          	mov    %rdx,0x0(%rbp)
    c980:	e9 15 fd ff ff       	jmp    c69a <fwp_decode+0x10a>
    c985:	49 8b 4e 08          	mov    0x8(%r14),%rcx
    c989:	49 8b 46 10          	mov    0x10(%r14),%rax
    c98d:	48 29 c1             	sub    %rax,%rcx
    c990:	48 83 f9 04          	cmp    $0x4,%rcx
    c994:	0f 82 06 fd ff ff    	jb     c6a0 <fwp_decode+0x110>
    c99a:	49 8b 0e             	mov    (%r14),%rcx
    c99d:	48 8d 50 04          	lea    0x4(%rax),%rdx
    c9a1:	49 89 56 10          	mov    %rdx,0x10(%r14)
    c9a5:	0f b6 14 01          	movzbl (%rcx,%rax,1),%edx
    c9a9:	0f b6 74 01 01       	movzbl 0x1(%rcx,%rax,1),%esi
    c9ae:	0f b6 7c 01 02       	movzbl 0x2(%rcx,%rax,1),%edi
    c9b3:	0f b6 44 01 03       	movzbl 0x3(%rcx,%rax,1),%eax
    c9b8:	48 c1 e0 38          	shl    $0x38,%rax
    c9bc:	48 c1 e7 30          	shl    $0x30,%rdi
    c9c0:	48 c1 e6 28          	shl    $0x28,%rsi
    c9c4:	48 c1 e2 20          	shl    $0x20,%rdx
    c9c8:	48 09 f2             	or     %rsi,%rdx
    c9cb:	48 09 fa             	or     %rdi,%rdx
    c9ce:	48 09 c2             	or     %rax,%rdx
    c9d1:	48 c1 fa 20          	sar    $0x20,%rdx
    c9d5:	48 89 55 00          	mov    %rdx,0x0(%rbp)
    c9d9:	e9 bc fc ff ff       	jmp    c69a <fwp_decode+0x10a>
    c9de:	41 b8 04 00 00 00    	mov    $0x4,%r8d
    c9e4:	e9 ed fb ff ff       	jmp    c5d6 <fwp_decode+0x46>
    c9e9:	49 8b 7f 40          	mov    0x40(%r15),%rdi
    c9ed:	31 f6                	xor    %esi,%esi
    c9ef:	e8 fc 6f 00 00       	call   139f0 <fwp_wire_empty_inner>
    c9f4:	85 c0                	test   %eax,%eax
    c9f6:	0f 95 c3             	setne  %bl
    c9f9:	eb 02                	jmp    c9fd <fwp_decode+0x46d>
    c9fb:	b3 01                	mov    $0x1,%bl
    c9fd:	4d 8b 6f 38          	mov    0x38(%r15),%r13
    ca01:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    ca06:	4c 89 f7             	mov    %r14,%rdi
    ca09:	e8 02 6e 00 00       	call   13810 <rd_leb>
    ca0e:	85 c0                	test   %eax,%eax
    ca10:	0f 84 8a fc ff ff    	je     c6a0 <fwp_decode+0x110>
    ca16:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    ca1b:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
    ca20:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    ca27:	ff ff 1f 
    ca2a:	48 39 c5             	cmp    %rax,%rbp
    ca2d:	0f 87 6d fc ff ff    	ja     c6a0 <fwp_decode+0x110>
    ca33:	45 31 e4             	xor    %r12d,%r12d
    ca36:	4c 89 ef             	mov    %r13,%rdi
    ca39:	31 f6                	xor    %esi,%esi
    ca3b:	e8 b0 6f 00 00       	call   139f0 <fwp_wire_empty_inner>
    ca40:	85 c0                	test   %eax,%eax
    ca42:	0f 84 2c 01 00 00    	je     cb74 <fwp_decode+0x5e4>
    ca48:	48 83 fd 02          	cmp    $0x2,%rbp
    ca4c:	0f 93 c0             	setae  %al
    ca4f:	84 d8                	test   %bl,%al
    ca51:	0f 85 49 fc ff ff    	jne    c6a0 <fwp_decode+0x110>
    ca57:	e9 22 01 00 00       	jmp    cb7e <fwp_decode+0x5ee>
    ca5c:	49 63 7f 10          	movslq 0x10(%r15),%rdi
    ca60:	48 85 ff             	test   %rdi,%rdi
    ca63:	74 74                	je     cad9 <fwp_decode+0x549>
    ca65:	48 c1 e7 03          	shl    $0x3,%rdi
    ca69:	48 ff 05 38 f4 00 00 	incq   0xf438(%rip)        # 1bea8 <measured_calls>
    ca70:	48 01 3d 39 f4 00 00 	add    %rdi,0xf439(%rip)        # 1beb0 <measured_bytes>
    ca77:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    ca7e:	0f 87 9b 01 00 00    	ja     cc1f <fwp_decode+0x68f>
    ca84:	48 8d 4f 0f          	lea    0xf(%rdi),%rcx
    ca88:	48 c1 e9 04          	shr    $0x4,%rcx
    ca8c:	48 8d 05 f5 d7 00 00 	lea    0xd7f5(%rip),%rax        # 1a288 <fwp_gc>
    ca93:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    ca9a:	00 
    ca9b:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    caa2:	48 29 15 df d7 00 00 	sub    %rdx,0xd7df(%rip)        # 1a288 <fwp_gc>
    caa9:	0f 88 70 01 00 00    	js     cc1f <fwp_decode+0x68f>
    caaf:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    cab3:	48 8d 34 c8          	lea    (%rax,%rcx,8),%rsi
    cab7:	48 81 c6 88 07 00 00 	add    $0x788,%rsi
    cabe:	4c 8b 2e             	mov    (%rsi),%r13
    cac1:	4d 85 ed             	test   %r13,%r13
    cac4:	0f 84 3d 01 00 00    	je     cc07 <fwp_decode+0x677>
    caca:	49 8b 45 00          	mov    0x0(%r13),%rax
    cace:	48 f7 d0             	not    %rax
    cad1:	48 89 06             	mov    %rax,(%rsi)
    cad4:	e9 80 01 00 00       	jmp    cc59 <fwp_decode+0x6c9>
    cad9:	48 c7 45 00 00 00 00 	movq   $0x0,0x0(%rbp)
    cae0:	00 
    cae1:	e9 b4 fb ff ff       	jmp    c69a <fwp_decode+0x10a>
    cae6:	4a 8d 3c ed 08 00 00 	lea    0x8(,%r13,8),%rdi
    caed:	00 
    caee:	48 ff 05 b3 f3 00 00 	incq   0xf3b3(%rip)        # 1bea8 <measured_calls>
    caf5:	48 01 3d b4 f3 00 00 	add    %rdi,0xf3b4(%rip)        # 1beb0 <measured_bytes>
    cafc:	49 81 fd ff 07 00 00 	cmp    $0x7ff,%r13
    cb03:	0f 87 6c 02 00 00    	ja     cd75 <fwp_decode+0x7e5>
    cb09:	4a 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%rcx
    cb10:	00 
    cb11:	48 83 c1 17          	add    $0x17,%rcx
    cb15:	48 c1 e9 04          	shr    $0x4,%rcx
    cb19:	48 8d 05 68 d7 00 00 	lea    0xd768(%rip),%rax        # 1a288 <fwp_gc>
    cb20:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    cb27:	00 
    cb28:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    cb2f:	48 29 15 52 d7 00 00 	sub    %rdx,0xd752(%rip)        # 1a288 <fwp_gc>
    cb36:	0f 88 39 02 00 00    	js     cd75 <fwp_decode+0x7e5>
    cb3c:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    cb40:	48 8d 34 c8          	lea    (%rax,%rcx,8),%rsi
    cb44:	48 81 c6 88 07 00 00 	add    $0x788,%rsi
    cb4b:	4c 8b 26             	mov    (%rsi),%r12
    cb4e:	4d 85 e4             	test   %r12,%r12
    cb51:	0f 84 06 02 00 00    	je     cd5d <fwp_decode+0x7cd>
    cb57:	49 8b 04 24          	mov    (%r12),%rax
    cb5b:	48 f7 d0             	not    %rax
    cb5e:	48 89 06             	mov    %rax,(%rsi)
    cb61:	e9 74 02 00 00       	jmp    cdda <fwp_decode+0x84a>
    cb66:	e8 45 37 00 00       	call   102b0 <fwp_box_u128>
    cb6b:	48 89 45 00          	mov    %rax,0x0(%rbp)
    cb6f:	e9 26 fb ff ff       	jmp    c69a <fwp_decode+0x10a>
    cb74:	49 3b 6e 08          	cmp    0x8(%r14),%rbp
    cb78:	0f 87 22 fb ff ff    	ja     c6a0 <fwp_decode+0x110>
    cb7e:	84 db                	test   %bl,%bl
    cb80:	75 0a                	jne    cb8c <fwp_decode+0x5fc>
    cb82:	49 3b 6e 08          	cmp    0x8(%r14),%rbp
    cb86:	0f 87 14 fb ff ff    	ja     c6a0 <fwp_decode+0x110>
    cb8c:	4c 8d 25 7d f3 01 00 	lea    0x1f37d(%rip),%r12        # 2bf10 <fwp_empty_map>
    cb93:	48 85 ed             	test   %rbp,%rbp
    cb96:	0f 84 9f 00 00 00    	je     cc3b <fwp_decode+0x6ab>
    cb9c:	4c 8d 6c 24 20       	lea    0x20(%rsp),%r13
    cba1:	48 8d 5c 24 30       	lea    0x30(%rsp),%rbx
    cba6:	eb 1b                	jmp    cbc3 <fwp_decode+0x633>
    cba8:	31 f6                	xor    %esi,%esi
    cbaa:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    cbaf:	49 8b 4f 38          	mov    0x38(%r15),%rcx
    cbb3:	4c 89 e2             	mov    %r12,%rdx
    cbb6:	e8 35 33 00 00       	call   fef0 <fwp_p_map_insert>
    cbbb:	49 89 c4             	mov    %rax,%r12
    cbbe:	48 ff cd             	dec    %rbp
    cbc1:	74 78                	je     cc3b <fwp_decode+0x6ab>
    cbc3:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
    cbca:	00 00 
    cbcc:	49 8b 77 38          	mov    0x38(%r15),%rsi
    cbd0:	4c 89 f7             	mov    %r14,%rdi
    cbd3:	4c 89 ea             	mov    %r13,%rdx
    cbd6:	e8 b5 f9 ff ff       	call   c590 <fwp_decode>
    cbdb:	85 c0                	test   %eax,%eax
    cbdd:	0f 84 40 02 00 00    	je     ce23 <fwp_decode+0x893>
    cbe3:	41 83 3f 12          	cmpl   $0x12,(%r15)
    cbe7:	75 bf                	jne    cba8 <fwp_decode+0x618>
    cbe9:	49 8b 77 40          	mov    0x40(%r15),%rsi
    cbed:	4c 89 f7             	mov    %r14,%rdi
    cbf0:	48 89 da             	mov    %rbx,%rdx
    cbf3:	e8 98 f9 ff ff       	call   c590 <fwp_decode>
    cbf8:	85 c0                	test   %eax,%eax
    cbfa:	0f 84 23 02 00 00    	je     ce23 <fwp_decode+0x893>
    cc00:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    cc05:	eb a3                	jmp    cbaa <fwp_decode+0x61a>
    cc07:	4c 8b ac c8 90 07 00 	mov    0x790(%rax,%rcx,8),%r13
    cc0e:	00 
    cc0f:	48 8b b4 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%rsi
    cc16:	00 
    cc17:	4c 29 ee             	sub    %r13,%rsi
    cc1a:	48 39 d6             	cmp    %rdx,%rsi
    cc1d:	73 29                	jae    cc48 <fwp_decode+0x6b8>
    cc1f:	be 02 00 00 00       	mov    $0x2,%esi
    cc24:	e8 97 b6 ff ff       	call   82c0 <fwp_gc_alloc_slow>
    cc29:	49 89 c5             	mov    %rax,%r13
    cc2c:	eb 35                	jmp    cc63 <fwp_decode+0x6d3>
    cc2e:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    cc33:	4c 89 20             	mov    %r12,(%rax)
    cc36:	e9 5f fa ff ff       	jmp    c69a <fwp_decode+0x10a>
    cc3b:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    cc40:	4c 89 20             	mov    %r12,(%rax)
    cc43:	e9 52 fa ff ff       	jmp    c69a <fwp_decode+0x10a>
    cc48:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    cc4c:	48 05 90 07 00 00    	add    $0x790,%rax
    cc52:	4a 8d 0c 2a          	lea    (%rdx,%r13,1),%rcx
    cc56:	48 89 08             	mov    %rcx,(%rax)
    cc59:	4c 89 ef             	mov    %r13,%rdi
    cc5c:	31 f6                	xor    %esi,%esi
    cc5e:	e8 ad 65 ff ff       	call   3210 <memset@plt>
    cc63:	41 8b 5f 10          	mov    0x10(%r15),%ebx
    cc67:	85 db                	test   %ebx,%ebx
    cc69:	7e 4a                	jle    ccb5 <fwp_decode+0x725>
    cc6b:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    cc70:	45 31 e4             	xor    %r12d,%r12d
    cc73:	4c 89 6c 24 18       	mov    %r13,0x18(%rsp)
    cc78:	4c 89 ed             	mov    %r13,%rbp
    cc7b:	45 31 ed             	xor    %r13d,%r13d
    cc7e:	66 90                	xchg   %ax,%ax
    cc80:	49 8b 47 20          	mov    0x20(%r15),%rax
    cc84:	4a 8b 34 e8          	mov    (%rax,%r13,8),%rsi
    cc88:	4c 89 f7             	mov    %r14,%rdi
    cc8b:	48 89 ea             	mov    %rbp,%rdx
    cc8e:	e8 fd f8 ff ff       	call   c590 <fwp_decode>
    cc93:	85 c0                	test   %eax,%eax
    cc95:	0f 84 05 fa ff ff    	je     c6a0 <fwp_decode+0x110>
    cc9b:	49 ff c5             	inc    %r13
    cc9e:	49 63 5f 10          	movslq 0x10(%r15),%rbx
    cca2:	48 83 c5 08          	add    $0x8,%rbp
    cca6:	49 39 dd             	cmp    %rbx,%r13
    cca9:	7c d5                	jl     cc80 <fwp_decode+0x6f0>
    ccab:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    ccb0:	4c 8b 6c 24 18       	mov    0x18(%rsp),%r13
    ccb5:	85 db                	test   %ebx,%ebx
    ccb7:	0f 84 95 00 00 00    	je     cd52 <fwp_decode+0x7c2>
    ccbd:	41 89 de             	mov    %ebx,%r14d
    ccc0:	4a 8d 3c f5 08 00 00 	lea    0x8(,%r14,8),%rdi
    ccc7:	00 
    ccc8:	e8 13 db ff ff       	call   a7e0 <fwp_alloc_init>
    cccd:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    ccd3:	89 58 04             	mov    %ebx,0x4(%rax)
    ccd6:	83 fb 08             	cmp    $0x8,%ebx
    ccd9:	72 14                	jb     ccef <fwp_decode+0x75f>
    ccdb:	48 89 c1             	mov    %rax,%rcx
    ccde:	4c 29 e9             	sub    %r13,%rcx
    cce1:	48 83 c1 08          	add    $0x8,%rcx
    cce5:	48 83 f9 20          	cmp    $0x20,%rcx
    cce9:	0f 83 95 00 00 00    	jae    cd84 <fwp_decode+0x7f4>
    ccef:	31 c9                	xor    %ecx,%ecx
    ccf1:	4c 89 f6             	mov    %r14,%rsi
    ccf4:	48 89 ca             	mov    %rcx,%rdx
    ccf7:	48 83 e6 03          	and    $0x3,%rsi
    ccfb:	74 15                	je     cd12 <fwp_decode+0x782>
    ccfd:	48 89 ca             	mov    %rcx,%rdx
    cd00:	49 8b 7c d5 00       	mov    0x0(%r13,%rdx,8),%rdi
    cd05:	48 89 7c d0 08       	mov    %rdi,0x8(%rax,%rdx,8)
    cd0a:	48 ff c2             	inc    %rdx
    cd0d:	48 ff ce             	dec    %rsi
    cd10:	75 ee                	jne    cd00 <fwp_decode+0x770>
    cd12:	4c 29 f1             	sub    %r14,%rcx
    cd15:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    cd19:	0f 87 a1 00 00 00    	ja     cdc0 <fwp_decode+0x830>
    cd1f:	49 8b 4c d5 00       	mov    0x0(%r13,%rdx,8),%rcx
    cd24:	48 89 4c d0 08       	mov    %rcx,0x8(%rax,%rdx,8)
    cd29:	49 8b 4c d5 08       	mov    0x8(%r13,%rdx,8),%rcx
    cd2e:	48 89 4c d0 10       	mov    %rcx,0x10(%rax,%rdx,8)
    cd33:	49 8b 4c d5 10       	mov    0x10(%r13,%rdx,8),%rcx
    cd38:	48 89 4c d0 18       	mov    %rcx,0x18(%rax,%rdx,8)
    cd3d:	49 8b 4c d5 18       	mov    0x18(%r13,%rdx,8),%rcx
    cd42:	48 89 4c d0 20       	mov    %rcx,0x20(%rax,%rdx,8)
    cd47:	48 83 c2 04          	add    $0x4,%rdx
    cd4b:	49 39 d6             	cmp    %rdx,%r14
    cd4e:	75 cf                	jne    cd1f <fwp_decode+0x78f>
    cd50:	eb 6e                	jmp    cdc0 <fwp_decode+0x830>
    cd52:	31 c0                	xor    %eax,%eax
    cd54:	48 89 45 00          	mov    %rax,0x0(%rbp)
    cd58:	e9 3d f9 ff ff       	jmp    c69a <fwp_decode+0x10a>
    cd5d:	4c 8b a4 c8 90 07 00 	mov    0x790(%rax,%rcx,8),%r12
    cd64:	00 
    cd65:	48 8b b4 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%rsi
    cd6c:	00 
    cd6d:	4c 29 e6             	sub    %r12,%rsi
    cd70:	48 39 d6             	cmp    %rdx,%rsi
    cd73:	73 54                	jae    cdc9 <fwp_decode+0x839>
    cd75:	be 02 00 00 00       	mov    $0x2,%esi
    cd7a:	e8 41 b5 ff ff       	call   82c0 <fwp_gc_alloc_slow>
    cd7f:	49 89 c4             	mov    %rax,%r12
    cd82:	eb 60                	jmp    cde4 <fwp_decode+0x854>
    cd84:	44 89 f1             	mov    %r14d,%ecx
    cd87:	83 e1 fc             	and    $0xfffffffc,%ecx
    cd8a:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
    cd91:	00 
    cd92:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    cd96:	31 f6                	xor    %esi,%esi
    cd98:	41 0f 10 44 35 00    	movups 0x0(%r13,%rsi,1),%xmm0
    cd9e:	41 0f 10 4c 35 10    	movups 0x10(%r13,%rsi,1),%xmm1
    cda4:	0f 11 44 30 08       	movups %xmm0,0x8(%rax,%rsi,1)
    cda9:	0f 11 4c 30 18       	movups %xmm1,0x18(%rax,%rsi,1)
    cdae:	48 83 c6 20          	add    $0x20,%rsi
    cdb2:	48 39 f2             	cmp    %rsi,%rdx
    cdb5:	75 e1                	jne    cd98 <fwp_decode+0x808>
    cdb7:	4c 39 f1             	cmp    %r14,%rcx
    cdba:	0f 85 31 ff ff ff    	jne    ccf1 <fwp_decode+0x761>
    cdc0:	48 89 45 00          	mov    %rax,0x0(%rbp)
    cdc4:	e9 d1 f8 ff ff       	jmp    c69a <fwp_decode+0x10a>
    cdc9:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    cdcd:	48 05 90 07 00 00    	add    $0x790,%rax
    cdd3:	49 8d 0c 14          	lea    (%r12,%rdx,1),%rcx
    cdd7:	48 89 08             	mov    %rcx,(%rax)
    cdda:	4c 89 e7             	mov    %r12,%rdi
    cddd:	31 f6                	xor    %esi,%esi
    cddf:	e8 2c 64 ff ff       	call   3210 <memset@plt>
    cde4:	4d 85 ed             	test   %r13,%r13
    cde7:	74 22                	je     ce0b <fwp_decode+0x87b>
    cde9:	4c 89 e5             	mov    %r12,%rbp
    cdec:	4c 89 eb             	mov    %r13,%rbx
    cdef:	49 8b 77 38          	mov    0x38(%r15),%rsi
    cdf3:	4c 89 f7             	mov    %r14,%rdi
    cdf6:	48 89 ea             	mov    %rbp,%rdx
    cdf9:	e8 92 f7 ff ff       	call   c590 <fwp_decode>
    cdfe:	85 c0                	test   %eax,%eax
    ce00:	74 21                	je     ce23 <fwp_decode+0x893>
    ce02:	48 83 c5 08          	add    $0x8,%rbp
    ce06:	48 ff cb             	dec    %rbx
    ce09:	75 e4                	jne    cdef <fwp_decode+0x85f>
    ce0b:	4c 89 e7             	mov    %r12,%rdi
    ce0e:	4c 89 ee             	mov    %r13,%rsi
    ce11:	e8 4a 00 00 00       	call   ce60 <fwp_list_from>
    ce16:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    ce1b:	48 89 01             	mov    %rax,(%rcx)
    ce1e:	e9 77 f8 ff ff       	jmp    c69a <fwp_decode+0x10a>
    ce23:	45 31 e4             	xor    %r12d,%r12d
    ce26:	e9 75 f8 ff ff       	jmp    c6a0 <fwp_decode+0x110>
    ce2b:	e8 c0 9d ff ff       	call   6bf0 <fwp_flush>
    ce30:	48 8b 05 a1 d1 00 00 	mov    0xd1a1(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    ce37:	48 8b 38             	mov    (%rax),%rdi
    ce3a:	48 8d 35 58 8c 00 00 	lea    0x8c58(%rip),%rsi        # 15a99 <exec_in_fp0+0x229>
    ce41:	48 8d 15 99 9b 00 00 	lea    0x9b99(%rip),%rdx        # 169e1 <exec_in_fp0+0x1171>
    ce48:	31 c0                	xor    %eax,%eax
    ce4a:	e8 a1 64 ff ff       	call   32f0 <fprintf@plt>
    ce4f:	bf 65 00 00 00       	mov    $0x65,%edi
    ce54:	e8 07 66 ff ff       	call   3460 <exit@plt>
    ce59:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000ce60 <fwp_list_from>:
    ce60:	55                   	push   %rbp
    ce61:	41 57                	push   %r15
    ce63:	41 56                	push   %r14
    ce65:	41 55                	push   %r13
    ce67:	41 54                	push   %r12
    ce69:	53                   	push   %rbx
    ce6a:	48 83 ec 18          	sub    $0x18,%rsp
    ce6e:	48 89 fb             	mov    %rdi,%rbx
    ce71:	48 85 f6             	test   %rsi,%rsi
    ce74:	0f 84 41 01 00 00    	je     cfbb <fwp_list_from+0x15b>
    ce7a:	49 89 f6             	mov    %rsi,%r14
    ce7d:	45 31 ff             	xor    %r15d,%r15d
    ce80:	4c 8d 2d 01 d4 00 00 	lea    0xd401(%rip),%r13        # 1a288 <fwp_gc>
    ce87:	eb 3d                	jmp    cec6 <fwp_list_from+0x66>
    ce89:	bf 18 00 00 00       	mov    $0x18,%edi
    ce8e:	31 f6                	xor    %esi,%esi
    ce90:	e8 2b b4 ff ff       	call   82c0 <fwp_gc_alloc_slow>
    ce95:	49 89 c7             	mov    %rax,%r15
    ce98:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    ce9f:	00 
    cea0:	48 b8 01 00 00 00 02 	movabs $0x200000001,%rax
    cea7:	00 00 00 
    ceaa:	49 89 07             	mov    %rax,(%r15)
    cead:	49 89 6f 08          	mov    %rbp,0x8(%r15)
    ceb1:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    ceb6:	49 89 47 10          	mov    %rax,0x10(%r15)
    ceba:	48 89 e0             	mov    %rsp,%rax
    cebd:	49 ff ce             	dec    %r14
    cec0:	0f 84 f8 00 00 00    	je     cfbe <fwp_list_from+0x15e>
    cec6:	4a 8b 6c f3 f8       	mov    -0x8(%rbx,%r14,8),%rbp
    cecb:	48 89 2c 24          	mov    %rbp,(%rsp)
    cecf:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
    ced4:	48 ff 05 cd ef 00 00 	incq   0xefcd(%rip)        # 1bea8 <measured_calls>
    cedb:	48 83 05 cd ef 00 00 	addq   $0x18,0xefcd(%rip)        # 1beb0 <measured_bytes>
    cee2:	18 
    cee3:	0f b6 05 88 df 00 00 	movzbl 0xdf88(%rip),%eax        # 1ae72 <fwp_gc+0xbea>
    ceea:	41 8b 94 85 48 0b 00 	mov    0xb48(%r13,%rax,4),%edx
    cef1:	00 
    cef2:	48 8b 0d 8f d3 00 00 	mov    0xd38f(%rip),%rcx        # 1a288 <fwp_gc>
    cef9:	48 29 d1             	sub    %rdx,%rcx
    cefc:	48 89 0d 85 d3 00 00 	mov    %rcx,0xd385(%rip)        # 1a288 <fwp_gc>
    cf03:	78 84                	js     ce89 <fwp_list_from+0x29>
    cf05:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
    cf09:	48 8d 34 c5 08 00 00 	lea    0x8(,%rax,8),%rsi
    cf10:	00 
    cf11:	4c 01 ee             	add    %r13,%rsi
    cf14:	4c 8b 3e             	mov    (%rsi),%r15
    cf17:	4d 85 ff             	test   %r15,%r15
    cf1a:	74 34                	je     cf50 <fwp_list_from+0xf0>
    cf1c:	49 8b 07             	mov    (%r15),%rax
    cf1f:	48 f7 d0             	not    %rax
    cf22:	48 89 06             	mov    %rax,(%rsi)
    cf25:	83 fa 19             	cmp    $0x19,%edx
    cf28:	0f 82 72 ff ff ff    	jb     cea0 <fwp_list_from+0x40>
    cf2e:	49 8d 7f 18          	lea    0x18(%r15),%rdi
    cf32:	48 83 c2 e7          	add    $0xffffffffffffffe7,%rdx
    cf36:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    cf3a:	48 83 c2 08          	add    $0x8,%rdx
    cf3e:	31 f6                	xor    %esi,%esi
    cf40:	e8 cb 62 ff ff       	call   3210 <memset@plt>
    cf45:	e9 56 ff ff ff       	jmp    cea0 <fwp_list_from+0x40>
    cf4a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    cf50:	4d 8b 7c c5 10       	mov    0x10(%r13,%rax,8),%r15
    cf55:	49 8b 74 c5 18       	mov    0x18(%r13,%rax,8),%rsi
    cf5a:	48 89 f7             	mov    %rsi,%rdi
    cf5d:	4c 29 ff             	sub    %r15,%rdi
    cf60:	48 39 d7             	cmp    %rdx,%rdi
    cf63:	73 0e                	jae    cf73 <fwp_list_from+0x113>
    cf65:	4d 89 fc             	mov    %r15,%r12
    cf68:	48 39 d7             	cmp    %rdx,%rdi
    cf6b:	0f 82 18 ff ff ff    	jb     ce89 <fwp_list_from+0x29>
    cf71:	eb 2d                	jmp    cfa0 <fwp_list_from+0x140>
    cf73:	48 8d 3c c5 10 00 00 	lea    0x10(,%rax,8),%rdi
    cf7a:	00 
    cf7b:	4c 01 ef             	add    %r13,%rdi
    cf7e:	4d 8d 24 17          	lea    (%r15,%rdx,1),%r12
    cf82:	4c 89 27             	mov    %r12,(%rdi)
    cf85:	4d 85 ff             	test   %r15,%r15
    cf88:	75 9b                	jne    cf25 <fwp_list_from+0xc5>
    cf8a:	48 89 0d f7 d2 00 00 	mov    %rcx,0xd2f7(%rip)        # 1a288 <fwp_gc>
    cf91:	4c 29 e6             	sub    %r12,%rsi
    cf94:	48 89 f7             	mov    %rsi,%rdi
    cf97:	48 39 d7             	cmp    %rdx,%rdi
    cf9a:	0f 82 e9 fe ff ff    	jb     ce89 <fwp_list_from+0x29>
    cfa0:	49 8d 0c 14          	lea    (%r12,%rdx,1),%rcx
    cfa4:	49 89 4c c5 10       	mov    %rcx,0x10(%r13,%rax,8)
    cfa9:	4c 89 e7             	mov    %r12,%rdi
    cfac:	31 f6                	xor    %esi,%esi
    cfae:	e8 5d 62 ff ff       	call   3210 <memset@plt>
    cfb3:	4d 89 e7             	mov    %r12,%r15
    cfb6:	e9 e5 fe ff ff       	jmp    cea0 <fwp_list_from+0x40>
    cfbb:	45 31 ff             	xor    %r15d,%r15d
    cfbe:	4c 89 f8             	mov    %r15,%rax
    cfc1:	48 83 c4 18          	add    $0x18,%rsp
    cfc5:	5b                   	pop    %rbx
    cfc6:	41 5c                	pop    %r12
    cfc8:	41 5d                	pop    %r13
    cfca:	41 5e                	pop    %r14
    cfcc:	41 5f                	pop    %r15
    cfce:	5d                   	pop    %rbp
    cfcf:	c3                   	ret

000000000000cfd0 <fwp_valid_utf8>:
    cfd0:	48 85 f6             	test   %rsi,%rsi
    cfd3:	0f 84 48 01 00 00    	je     d121 <fwp_valid_utf8+0x151>
    cfd9:	53                   	push   %rbx
    cfda:	31 c9                	xor    %ecx,%ecx
    cfdc:	eb 0e                	jmp    cfec <fwp_valid_utf8+0x1c>
    cfde:	66 90                	xchg   %ax,%ax
    cfe0:	48 ff c1             	inc    %rcx
    cfe3:	48 39 f1             	cmp    %rsi,%rcx
    cfe6:	0f 83 2e 01 00 00    	jae    d11a <fwp_valid_utf8+0x14a>
    cfec:	44 0f b6 14 0f       	movzbl (%rdi,%rcx,1),%r10d
    cff1:	45 84 d2             	test   %r10b,%r10b
    cff4:	79 ea                	jns    cfe0 <fwp_valid_utf8+0x10>
    cff6:	41 8d 42 3e          	lea    0x3e(%r10),%eax
    cffa:	3c 1e                	cmp    $0x1e,%al
    cffc:	73 12                	jae    d010 <fwp_valid_utf8+0x40>
    cffe:	ba 80 00 00 00       	mov    $0x80,%edx
    d003:	b8 01 00 00 00       	mov    $0x1,%eax
    d008:	41 b8 1f 00 00 00    	mov    $0x1f,%r8d
    d00e:	eb 37                	jmp    d047 <fwp_valid_utf8+0x77>
    d010:	44 89 d0             	mov    %r10d,%eax
    d013:	24 f0                	and    $0xf0,%al
    d015:	3c e0                	cmp    $0xe0,%al
    d017:	75 12                	jne    d02b <fwp_valid_utf8+0x5b>
    d019:	ba 00 08 00 00       	mov    $0x800,%edx
    d01e:	b8 02 00 00 00       	mov    $0x2,%eax
    d023:	41 b8 0f 00 00 00    	mov    $0xf,%r8d
    d029:	eb 1c                	jmp    d047 <fwp_valid_utf8+0x77>
    d02b:	41 8d 42 10          	lea    0x10(%r10),%eax
    d02f:	3c 04                	cmp    $0x4,%al
    d031:	0f 87 f0 00 00 00    	ja     d127 <fwp_valid_utf8+0x157>
    d037:	ba 00 00 01 00       	mov    $0x10000,%edx
    d03c:	b8 03 00 00 00       	mov    $0x3,%eax
    d041:	41 b8 07 00 00 00    	mov    $0x7,%r8d
    d047:	41 89 c1             	mov    %eax,%r9d
    d04a:	4e 8d 1c 09          	lea    (%rcx,%r9,1),%r11
    d04e:	31 c0                	xor    %eax,%eax
    d050:	49 39 f3             	cmp    %rsi,%r11
    d053:	0f 83 c6 00 00 00    	jae    d11f <fwp_valid_utf8+0x14f>
    d059:	44 0f b6 5c 0f 01    	movzbl 0x1(%rdi,%rcx,1),%r11d
    d05f:	44 89 db             	mov    %r11d,%ebx
    d062:	83 e3 c0             	and    $0xffffffc0,%ebx
    d065:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
    d06b:	0f 85 ae 00 00 00    	jne    d11f <fwp_valid_utf8+0x14f>
    d071:	45 21 d0             	and    %r10d,%r8d
    d074:	45 8d 51 01          	lea    0x1(%r9),%r10d
    d078:	44 89 c3             	mov    %r8d,%ebx
    d07b:	c1 e3 06             	shl    $0x6,%ebx
    d07e:	41 83 e3 3f          	and    $0x3f,%r11d
    d082:	41 09 db             	or     %ebx,%r11d
    d085:	41 83 fa 02          	cmp    $0x2,%r10d
    d089:	75 0d                	jne    d098 <fwp_valid_utf8+0xc8>
    d08b:	45 89 da             	mov    %r11d,%r10d
    d08e:	41 39 d2             	cmp    %edx,%r10d
    d091:	73 62                	jae    d0f5 <fwp_valid_utf8+0x125>
    d093:	e9 87 00 00 00       	jmp    d11f <fwp_valid_utf8+0x14f>
    d098:	44 0f b6 44 0f 02    	movzbl 0x2(%rdi,%rcx,1),%r8d
    d09e:	44 89 c3             	mov    %r8d,%ebx
    d0a1:	83 e3 c0             	and    $0xffffffc0,%ebx
    d0a4:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
    d0aa:	75 73                	jne    d11f <fwp_valid_utf8+0x14f>
    d0ac:	44 89 db             	mov    %r11d,%ebx
    d0af:	c1 e3 06             	shl    $0x6,%ebx
    d0b2:	41 83 e0 3f          	and    $0x3f,%r8d
    d0b6:	41 09 d8             	or     %ebx,%r8d
    d0b9:	41 83 fa 03          	cmp    $0x3,%r10d
    d0bd:	75 0d                	jne    d0cc <fwp_valid_utf8+0xfc>
    d0bf:	45 89 c2             	mov    %r8d,%r10d
    d0c2:	45 89 d8             	mov    %r11d,%r8d
    d0c5:	41 39 d2             	cmp    %edx,%r10d
    d0c8:	73 2b                	jae    d0f5 <fwp_valid_utf8+0x125>
    d0ca:	eb 53                	jmp    d11f <fwp_valid_utf8+0x14f>
    d0cc:	44 0f b6 54 0f 03    	movzbl 0x3(%rdi,%rcx,1),%r10d
    d0d2:	45 89 d3             	mov    %r10d,%r11d
    d0d5:	41 83 e3 c0          	and    $0xffffffc0,%r11d
    d0d9:	41 81 fb 80 00 00 00 	cmp    $0x80,%r11d
    d0e0:	75 3d                	jne    d11f <fwp_valid_utf8+0x14f>
    d0e2:	45 89 c3             	mov    %r8d,%r11d
    d0e5:	41 c1 e3 06          	shl    $0x6,%r11d
    d0e9:	41 83 e2 3f          	and    $0x3f,%r10d
    d0ed:	45 09 da             	or     %r11d,%r10d
    d0f0:	41 39 d2             	cmp    %edx,%r10d
    d0f3:	72 2a                	jb     d11f <fwp_valid_utf8+0x14f>
    d0f5:	41 81 fa ff ff 10 00 	cmp    $0x10ffff,%r10d
    d0fc:	77 21                	ja     d11f <fwp_valid_utf8+0x14f>
    d0fe:	41 83 e0 e0          	and    $0xffffffe0,%r8d
    d102:	41 81 f8 60 03 00 00 	cmp    $0x360,%r8d
    d109:	74 14                	je     d11f <fwp_valid_utf8+0x14f>
    d10b:	4c 01 c9             	add    %r9,%rcx
    d10e:	48 ff c1             	inc    %rcx
    d111:	48 39 f1             	cmp    %rsi,%rcx
    d114:	0f 82 d2 fe ff ff    	jb     cfec <fwp_valid_utf8+0x1c>
    d11a:	b8 01 00 00 00       	mov    $0x1,%eax
    d11f:	5b                   	pop    %rbx
    d120:	c3                   	ret
    d121:	b8 01 00 00 00       	mov    $0x1,%eax
    d126:	c3                   	ret
    d127:	31 c0                	xor    %eax,%eax
    d129:	5b                   	pop    %rbx
    d12a:	c3                   	ret
    d12b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000d130 <fwp_str_new>:
    d130:	41 57                	push   %r15
    d132:	41 56                	push   %r14
    d134:	53                   	push   %rbx
    d135:	49 89 f6             	mov    %rsi,%r14
    d138:	48 89 fb             	mov    %rdi,%rbx
    d13b:	48 8d 56 09          	lea    0x9(%rsi),%rdx
    d13f:	48 ff 05 62 ed 00 00 	incq   0xed62(%rip)        # 1bea8 <measured_calls>
    d146:	48 01 15 63 ed 00 00 	add    %rdx,0xed63(%rip)        # 1beb0 <measured_bytes>
    d14d:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    d154:	77 61                	ja     d1b7 <fwp_str_new+0x87>
    d156:	49 8d 4e 18          	lea    0x18(%r14),%rcx
    d15a:	48 c1 e9 04          	shr    $0x4,%rcx
    d15e:	48 8d 05 23 d1 00 00 	lea    0xd123(%rip),%rax        # 1a288 <fwp_gc>
    d165:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    d16c:	00 
    d16d:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    d174:	48 29 0d 0d d1 00 00 	sub    %rcx,0xd10d(%rip)        # 1a288 <fwp_gc>
    d17b:	78 3a                	js     d1b7 <fwp_str_new+0x87>
    d17d:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    d181:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    d185:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    d18c:	4c 8b 3f             	mov    (%rdi),%r15
    d18f:	4d 85 ff             	test   %r15,%r15
    d192:	74 0b                	je     d19f <fwp_str_new+0x6f>
    d194:	49 8b 07             	mov    (%r15),%rax
    d197:	48 f7 d0             	not    %rax
    d19a:	48 89 07             	mov    %rax,(%rdi)
    d19d:	eb 3a                	jmp    d1d9 <fwp_str_new+0xa9>
    d19f:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    d1a6:	00 
    d1a7:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    d1ae:	00 
    d1af:	4c 29 ff             	sub    %r15,%rdi
    d1b2:	48 39 cf             	cmp    %rcx,%rdi
    d1b5:	73 12                	jae    d1c9 <fwp_str_new+0x99>
    d1b7:	48 89 d7             	mov    %rdx,%rdi
    d1ba:	be 01 00 00 00       	mov    $0x1,%esi
    d1bf:	e8 fc b0 ff ff       	call   82c0 <fwp_gc_alloc_slow>
    d1c4:	49 89 c7             	mov    %rax,%r15
    d1c7:	eb 1a                	jmp    d1e3 <fwp_str_new+0xb3>
    d1c9:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    d1cd:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    d1d3:	4c 01 f9             	add    %r15,%rcx
    d1d6:	48 89 08             	mov    %rcx,(%rax)
    d1d9:	4c 89 ff             	mov    %r15,%rdi
    d1dc:	31 f6                	xor    %esi,%esi
    d1de:	e8 2d 60 ff ff       	call   3210 <memset@plt>
    d1e3:	4d 89 37             	mov    %r14,(%r15)
    d1e6:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    d1ea:	48 89 de             	mov    %rbx,%rsi
    d1ed:	4c 89 f2             	mov    %r14,%rdx
    d1f0:	e8 3b 61 ff ff       	call   3330 <memcpy@plt>
    d1f5:	43 c6 44 37 08 00    	movb   $0x0,0x8(%r15,%r14,1)
    d1fb:	4c 89 f8             	mov    %r15,%rax
    d1fe:	5b                   	pop    %rbx
    d1ff:	41 5e                	pop    %r14
    d201:	41 5f                	pop    %r15
    d203:	c3                   	ret
    d204:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    d20b:	00 00 00 00 00 

000000000000d210 <buf_put>:
    d210:	41 57                	push   %r15
    d212:	41 56                	push   %r14
    d214:	41 54                	push   %r12
    d216:	53                   	push   %rbx
    d217:	50                   	push   %rax
    d218:	49 89 fe             	mov    %rdi,%r14
    d21b:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    d21f:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
    d223:	0f 84 a2 00 00 00    	je     d2cb <buf_put+0xbb>
    d229:	48 89 d3             	mov    %rdx,%rbx
    d22c:	48 c7 c0 fe ff ff ff 	mov    $0xfffffffffffffffe,%rax
    d233:	48 29 f8             	sub    %rdi,%rax
    d236:	48 39 d0             	cmp    %rdx,%rax
    d239:	0f 82 8c 00 00 00    	jb     d2cb <buf_put+0xbb>
    d23f:	48 8d 04 3b          	lea    (%rbx,%rdi,1),%rax
    d243:	48 ff c0             	inc    %rax
    d246:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    d24a:	48 39 c8             	cmp    %rcx,%rax
    d24d:	76 30                	jbe    d27f <buf_put+0x6f>
    d24f:	48 85 c9             	test   %rcx,%rcx
    d252:	41 bf 40 00 00 00    	mov    $0x40,%r15d
    d258:	4c 0f 45 f9          	cmovne %rcx,%r15
    d25c:	49 89 f4             	mov    %rsi,%r12
    d25f:	49 39 c7             	cmp    %rax,%r15
    d262:	73 23                	jae    d287 <buf_put+0x77>
    d264:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    d26b:	00 00 00 00 00 
    d270:	4d 85 ff             	test   %r15,%r15
    d273:	78 0f                	js     d284 <buf_put+0x74>
    d275:	4d 01 ff             	add    %r15,%r15
    d278:	49 39 c7             	cmp    %rax,%r15
    d27b:	72 f3                	jb     d270 <buf_put+0x60>
    d27d:	eb 08                	jmp    d287 <buf_put+0x77>
    d27f:	49 8b 06             	mov    (%r14),%rax
    d282:	eb 21                	jmp    d2a5 <buf_put+0x95>
    d284:	49 89 c7             	mov    %rax,%r15
    d287:	49 8b 3e             	mov    (%r14),%rdi
    d28a:	4c 89 fe             	mov    %r15,%rsi
    d28d:	e8 ee 60 ff ff       	call   3380 <realloc@plt>
    d292:	48 85 c0             	test   %rax,%rax
    d295:	74 34                	je     d2cb <buf_put+0xbb>
    d297:	49 89 06             	mov    %rax,(%r14)
    d29a:	4d 89 7e 10          	mov    %r15,0x10(%r14)
    d29e:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    d2a2:	4c 89 e6             	mov    %r12,%rsi
    d2a5:	48 01 c7             	add    %rax,%rdi
    d2a8:	48 89 da             	mov    %rbx,%rdx
    d2ab:	e8 80 60 ff ff       	call   3330 <memcpy@plt>
    d2b0:	49 03 5e 08          	add    0x8(%r14),%rbx
    d2b4:	49 89 5e 08          	mov    %rbx,0x8(%r14)
    d2b8:	49 8b 06             	mov    (%r14),%rax
    d2bb:	c6 04 18 00          	movb   $0x0,(%rax,%rbx,1)
    d2bf:	48 83 c4 08          	add    $0x8,%rsp
    d2c3:	5b                   	pop    %rbx
    d2c4:	41 5c                	pop    %r12
    d2c6:	41 5e                	pop    %r14
    d2c8:	41 5f                	pop    %r15
    d2ca:	c3                   	ret
    d2cb:	48 8b 05 06 cd 00 00 	mov    0xcd06(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    d2d2:	48 8b 08             	mov    (%rax),%rcx
    d2d5:	48 8d 3d 15 88 00 00 	lea    0x8815(%rip),%rdi        # 15af1 <exec_in_fp0+0x281>
    d2dc:	be 13 00 00 00       	mov    $0x13,%esi
    d2e1:	ba 01 00 00 00       	mov    $0x1,%edx
    d2e6:	e8 95 61 ff ff       	call   3480 <fwrite@plt>
    d2eb:	bf 66 00 00 00       	mov    $0x66,%edi
    d2f0:	e8 6b 61 ff ff       	call   3460 <exit@plt>
    d2f5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    d2fc:	00 00 00 00 

000000000000d300 <buf_to_str>:
    d300:	41 57                	push   %r15
    d302:	41 56                	push   %r14
    d304:	41 55                	push   %r13
    d306:	41 54                	push   %r12
    d308:	53                   	push   %rbx
    d309:	48 89 fb             	mov    %rdi,%rbx
    d30c:	4c 8b 2f             	mov    (%rdi),%r13
    d30f:	4c 8b 77 08          	mov    0x8(%rdi),%r14
    d313:	49 8d 56 09          	lea    0x9(%r14),%rdx
    d317:	48 ff 05 8a eb 00 00 	incq   0xeb8a(%rip)        # 1bea8 <measured_calls>
    d31e:	48 01 15 8b eb 00 00 	add    %rdx,0xeb8b(%rip)        # 1beb0 <measured_bytes>
    d325:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    d32c:	77 61                	ja     d38f <buf_to_str+0x8f>
    d32e:	49 8d 4e 18          	lea    0x18(%r14),%rcx
    d332:	48 c1 e9 04          	shr    $0x4,%rcx
    d336:	48 8d 05 4b cf 00 00 	lea    0xcf4b(%rip),%rax        # 1a288 <fwp_gc>
    d33d:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    d344:	00 
    d345:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    d34c:	48 29 0d 35 cf 00 00 	sub    %rcx,0xcf35(%rip)        # 1a288 <fwp_gc>
    d353:	78 3a                	js     d38f <buf_to_str+0x8f>
    d355:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    d359:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    d35d:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    d364:	4c 8b 3f             	mov    (%rdi),%r15
    d367:	4d 85 ff             	test   %r15,%r15
    d36a:	74 0b                	je     d377 <buf_to_str+0x77>
    d36c:	49 8b 07             	mov    (%r15),%rax
    d36f:	48 f7 d0             	not    %rax
    d372:	48 89 07             	mov    %rax,(%rdi)
    d375:	eb 3a                	jmp    d3b1 <buf_to_str+0xb1>
    d377:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    d37e:	00 
    d37f:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    d386:	00 
    d387:	4c 29 ff             	sub    %r15,%rdi
    d38a:	48 39 cf             	cmp    %rcx,%rdi
    d38d:	73 12                	jae    d3a1 <buf_to_str+0xa1>
    d38f:	48 89 d7             	mov    %rdx,%rdi
    d392:	be 01 00 00 00       	mov    $0x1,%esi
    d397:	e8 24 af ff ff       	call   82c0 <fwp_gc_alloc_slow>
    d39c:	49 89 c7             	mov    %rax,%r15
    d39f:	eb 1a                	jmp    d3bb <buf_to_str+0xbb>
    d3a1:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    d3a5:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    d3ab:	4c 01 f9             	add    %r15,%rcx
    d3ae:	48 89 08             	mov    %rcx,(%rax)
    d3b1:	4c 89 ff             	mov    %r15,%rdi
    d3b4:	31 f6                	xor    %esi,%esi
    d3b6:	e8 55 5e ff ff       	call   3210 <memset@plt>
    d3bb:	4d 85 ed             	test   %r13,%r13
    d3be:	4c 8d 25 10 8e 00 00 	lea    0x8e10(%rip),%r12        # 161d5 <exec_in_fp0+0x965>
    d3c5:	4d 0f 45 e5          	cmovne %r13,%r12
    d3c9:	4d 89 37             	mov    %r14,(%r15)
    d3cc:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    d3d0:	4c 89 e6             	mov    %r12,%rsi
    d3d3:	4c 89 f2             	mov    %r14,%rdx
    d3d6:	e8 55 5f ff ff       	call   3330 <memcpy@plt>
    d3db:	43 c6 44 37 08 00    	movb   $0x0,0x8(%r15,%r14,1)
    d3e1:	48 8b 3b             	mov    (%rbx),%rdi
    d3e4:	e8 67 5c ff ff       	call   3050 <free@plt>
    d3e9:	4c 89 f8             	mov    %r15,%rax
    d3ec:	5b                   	pop    %rbx
    d3ed:	41 5c                	pop    %r12
    d3ef:	41 5d                	pop    %r13
    d3f1:	41 5e                	pop    %r14
    d3f3:	41 5f                	pop    %r15
    d3f5:	c3                   	ret
    d3f6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    d3fd:	00 00 00 

000000000000d400 <fwp_strf>:
    d400:	55                   	push   %rbp
    d401:	41 57                	push   %r15
    d403:	41 56                	push   %r14
    d405:	41 55                	push   %r13
    d407:	41 54                	push   %r12
    d409:	53                   	push   %rbx
    d40a:	48 81 ec d8 00 00 00 	sub    $0xd8,%rsp
    d411:	49 89 ff             	mov    %rdi,%r15
    d414:	48 89 74 24 28       	mov    %rsi,0x28(%rsp)
    d419:	48 89 54 24 30       	mov    %rdx,0x30(%rsp)
    d41e:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
    d423:	4c 89 44 24 40       	mov    %r8,0x40(%rsp)
    d428:	4c 89 4c 24 48       	mov    %r9,0x48(%rsp)
    d42d:	84 c0                	test   %al,%al
    d42f:	74 37                	je     d468 <fwp_strf+0x68>
    d431:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
    d436:	0f 29 4c 24 60       	movaps %xmm1,0x60(%rsp)
    d43b:	0f 29 54 24 70       	movaps %xmm2,0x70(%rsp)
    d440:	0f 29 9c 24 80 00 00 	movaps %xmm3,0x80(%rsp)
    d447:	00 
    d448:	0f 29 a4 24 90 00 00 	movaps %xmm4,0x90(%rsp)
    d44f:	00 
    d450:	0f 29 ac 24 a0 00 00 	movaps %xmm5,0xa0(%rsp)
    d457:	00 
    d458:	0f 29 b4 24 b0 00 00 	movaps %xmm6,0xb0(%rsp)
    d45f:	00 
    d460:	0f 29 bc 24 c0 00 00 	movaps %xmm7,0xc0(%rsp)
    d467:	00 
    d468:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    d46d:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    d472:	48 8d 84 24 10 01 00 	lea    0x110(%rsp),%rax
    d479:	00 
    d47a:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    d47f:	48 bd 08 00 00 00 30 	movabs $0x3000000008,%rbp
    d486:	00 00 00 
    d489:	48 89 2c 24          	mov    %rbp,(%rsp)
    d48d:	48 89 e1             	mov    %rsp,%rcx
    d490:	31 ff                	xor    %edi,%edi
    d492:	31 f6                	xor    %esi,%esi
    d494:	4c 89 fa             	mov    %r15,%rdx
    d497:	e8 74 5c ff ff       	call   3110 <vsnprintf@plt>
    d49c:	48 63 d8             	movslq %eax,%rbx
    d49f:	48 ff 05 02 ea 00 00 	incq   0xea02(%rip)        # 1bea8 <measured_calls>
    d4a6:	4c 8d 63 01          	lea    0x1(%rbx),%r12
    d4aa:	4c 01 25 ff e9 00 00 	add    %r12,0xe9ff(%rip)        # 1beb0 <measured_bytes>
    d4b1:	4c 8d 2d d0 cd 00 00 	lea    0xcdd0(%rip),%r13        # 1a288 <fwp_gc>
    d4b8:	49 81 fc 00 40 00 00 	cmp    $0x4000,%r12
    d4bf:	77 5c                	ja     d51d <fwp_strf+0x11d>
    d4c1:	48 8d 43 10          	lea    0x10(%rbx),%rax
    d4c5:	48 c1 e8 04          	shr    $0x4,%rax
    d4c9:	42 0f b6 8c 28 e8 0b 	movzbl 0xbe8(%rax,%r13,1),%ecx
    d4d0:	00 00 
    d4d2:	41 8b 84 8d 48 0b 00 	mov    0xb48(%r13,%rcx,4),%eax
    d4d9:	00 
    d4da:	48 29 05 a7 cd 00 00 	sub    %rax,0xcda7(%rip)        # 1a288 <fwp_gc>
    d4e1:	78 3a                	js     d51d <fwp_strf+0x11d>
    d4e3:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    d4e7:	48 8d 14 cd c8 03 00 	lea    0x3c8(,%rcx,8),%rdx
    d4ee:	00 
    d4ef:	4c 01 ea             	add    %r13,%rdx
    d4f2:	4c 8b 32             	mov    (%rdx),%r14
    d4f5:	4d 85 f6             	test   %r14,%r14
    d4f8:	74 0b                	je     d505 <fwp_strf+0x105>
    d4fa:	49 8b 06             	mov    (%r14),%rax
    d4fd:	48 f7 d0             	not    %rax
    d500:	48 89 02             	mov    %rax,(%rdx)
    d503:	eb 3b                	jmp    d540 <fwp_strf+0x140>
    d505:	4d 8b b4 cd d0 03 00 	mov    0x3d0(%r13,%rcx,8),%r14
    d50c:	00 
    d50d:	49 8b 94 cd d8 03 00 	mov    0x3d8(%r13,%rcx,8),%rdx
    d514:	00 
    d515:	4c 29 f2             	sub    %r14,%rdx
    d518:	48 39 c2             	cmp    %rax,%rdx
    d51b:	73 12                	jae    d52f <fwp_strf+0x12f>
    d51d:	4c 89 e7             	mov    %r12,%rdi
    d520:	be 01 00 00 00       	mov    $0x1,%esi
    d525:	e8 96 ad ff ff       	call   82c0 <fwp_gc_alloc_slow>
    d52a:	49 89 c6             	mov    %rax,%r14
    d52d:	eb 1e                	jmp    d54d <fwp_strf+0x14d>
    d52f:	48 8d 0c cd d0 03 00 	lea    0x3d0(,%rcx,8),%rcx
    d536:	00 
    d537:	4c 01 e9             	add    %r13,%rcx
    d53a:	4c 01 f0             	add    %r14,%rax
    d53d:	48 89 01             	mov    %rax,(%rcx)
    d540:	4c 89 f7             	mov    %r14,%rdi
    d543:	31 f6                	xor    %esi,%esi
    d545:	4c 89 e2             	mov    %r12,%rdx
    d548:	e8 c3 5c ff ff       	call   3210 <memset@plt>
    d54d:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    d552:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    d557:	48 8d 84 24 10 01 00 	lea    0x110(%rsp),%rax
    d55e:	00 
    d55f:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    d564:	48 89 2c 24          	mov    %rbp,(%rsp)
    d568:	48 89 e1             	mov    %rsp,%rcx
    d56b:	4c 89 f7             	mov    %r14,%rdi
    d56e:	4c 89 e6             	mov    %r12,%rsi
    d571:	4c 89 fa             	mov    %r15,%rdx
    d574:	e8 97 5b ff ff       	call   3110 <vsnprintf@plt>
    d579:	48 8d 53 09          	lea    0x9(%rbx),%rdx
    d57d:	48 ff 05 24 e9 00 00 	incq   0xe924(%rip)        # 1bea8 <measured_calls>
    d584:	48 01 15 25 e9 00 00 	add    %rdx,0xe925(%rip)        # 1beb0 <measured_bytes>
    d58b:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    d592:	77 5c                	ja     d5f0 <fwp_strf+0x1f0>
    d594:	48 8d 43 18          	lea    0x18(%rbx),%rax
    d598:	48 c1 e8 04          	shr    $0x4,%rax
    d59c:	42 0f b6 8c 28 e8 0b 	movzbl 0xbe8(%rax,%r13,1),%ecx
    d5a3:	00 00 
    d5a5:	41 8b 84 8d 48 0b 00 	mov    0xb48(%r13,%rcx,4),%eax
    d5ac:	00 
    d5ad:	48 29 05 d4 cc 00 00 	sub    %rax,0xccd4(%rip)        # 1a288 <fwp_gc>
    d5b4:	78 3a                	js     d5f0 <fwp_strf+0x1f0>
    d5b6:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    d5ba:	48 8d 34 cd c8 03 00 	lea    0x3c8(,%rcx,8),%rsi
    d5c1:	00 
    d5c2:	4c 01 ee             	add    %r13,%rsi
    d5c5:	4c 8b 3e             	mov    (%rsi),%r15
    d5c8:	4d 85 ff             	test   %r15,%r15
    d5cb:	74 0b                	je     d5d8 <fwp_strf+0x1d8>
    d5cd:	49 8b 07             	mov    (%r15),%rax
    d5d0:	48 f7 d0             	not    %rax
    d5d3:	48 89 06             	mov    %rax,(%rsi)
    d5d6:	eb 3b                	jmp    d613 <fwp_strf+0x213>
    d5d8:	4d 8b bc cd d0 03 00 	mov    0x3d0(%r13,%rcx,8),%r15
    d5df:	00 
    d5e0:	49 8b b4 cd d8 03 00 	mov    0x3d8(%r13,%rcx,8),%rsi
    d5e7:	00 
    d5e8:	4c 29 fe             	sub    %r15,%rsi
    d5eb:	48 39 c6             	cmp    %rax,%rsi
    d5ee:	73 12                	jae    d602 <fwp_strf+0x202>
    d5f0:	48 89 d7             	mov    %rdx,%rdi
    d5f3:	be 01 00 00 00       	mov    $0x1,%esi
    d5f8:	e8 c3 ac ff ff       	call   82c0 <fwp_gc_alloc_slow>
    d5fd:	49 89 c7             	mov    %rax,%r15
    d600:	eb 1b                	jmp    d61d <fwp_strf+0x21d>
    d602:	48 8d 0c cd d0 03 00 	lea    0x3d0(,%rcx,8),%rcx
    d609:	00 
    d60a:	4c 01 e9             	add    %r13,%rcx
    d60d:	4c 01 f8             	add    %r15,%rax
    d610:	48 89 01             	mov    %rax,(%rcx)
    d613:	4c 89 ff             	mov    %r15,%rdi
    d616:	31 f6                	xor    %esi,%esi
    d618:	e8 f3 5b ff ff       	call   3210 <memset@plt>
    d61d:	49 89 1f             	mov    %rbx,(%r15)
    d620:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    d624:	4c 89 f6             	mov    %r14,%rsi
    d627:	48 89 da             	mov    %rbx,%rdx
    d62a:	e8 01 5d ff ff       	call   3330 <memcpy@plt>
    d62f:	41 c6 44 1f 08 00    	movb   $0x0,0x8(%r15,%rbx,1)
    d635:	4c 89 f8             	mov    %r15,%rax
    d638:	48 81 c4 d8 00 00 00 	add    $0xd8,%rsp
    d63f:	5b                   	pop    %rbx
    d640:	41 5c                	pop    %r12
    d642:	41 5d                	pop    %r13
    d644:	41 5e                	pop    %r14
    d646:	41 5f                	pop    %r15
    d648:	5d                   	pop    %rbp
    d649:	c3                   	ret
    d64a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000d650 <fwp_data>:
    d650:	55                   	push   %rbp
    d651:	41 57                	push   %r15
    d653:	41 56                	push   %r14
    d655:	53                   	push   %rbx
    d656:	50                   	push   %rax
    d657:	89 fd                	mov    %edi,%ebp
    d659:	85 f6                	test   %esi,%esi
    d65b:	0f 84 a1 00 00 00    	je     d702 <fwp_data+0xb2>
    d661:	48 89 d3             	mov    %rdx,%rbx
    d664:	41 89 f6             	mov    %esi,%r14d
    d667:	4a 8d 3c f5 08 00 00 	lea    0x8(,%r14,8),%rdi
    d66e:	00 
    d66f:	41 89 f7             	mov    %esi,%r15d
    d672:	e8 69 d1 ff ff       	call   a7e0 <fwp_alloc_init>
    d677:	89 28                	mov    %ebp,(%rax)
    d679:	44 89 78 04          	mov    %r15d,0x4(%rax)
    d67d:	41 83 ff 08          	cmp    $0x8,%r15d
    d681:	72 10                	jb     d693 <fwp_data+0x43>
    d683:	48 89 c1             	mov    %rax,%rcx
    d686:	48 29 d9             	sub    %rbx,%rcx
    d689:	48 83 c1 08          	add    $0x8,%rcx
    d68d:	48 83 f9 20          	cmp    $0x20,%rcx
    d691:	73 73                	jae    d706 <fwp_data+0xb6>
    d693:	31 c9                	xor    %ecx,%ecx
    d695:	4c 89 f6             	mov    %r14,%rsi
    d698:	48 89 ca             	mov    %rcx,%rdx
    d69b:	48 83 e6 03          	and    $0x3,%rsi
    d69f:	74 20                	je     d6c1 <fwp_data+0x71>
    d6a1:	48 89 ca             	mov    %rcx,%rdx
    d6a4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    d6ab:	00 00 00 00 00 
    d6b0:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    d6b4:	48 89 7c d0 08       	mov    %rdi,0x8(%rax,%rdx,8)
    d6b9:	48 ff c2             	inc    %rdx
    d6bc:	48 ff ce             	dec    %rsi
    d6bf:	75 ef                	jne    d6b0 <fwp_data+0x60>
    d6c1:	4c 29 f1             	sub    %r14,%rcx
    d6c4:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    d6c8:	77 7b                	ja     d745 <fwp_data+0xf5>
    d6ca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    d6d0:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    d6d4:	48 89 4c d0 08       	mov    %rcx,0x8(%rax,%rdx,8)
    d6d9:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    d6de:	48 89 4c d0 10       	mov    %rcx,0x10(%rax,%rdx,8)
    d6e3:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    d6e8:	48 89 4c d0 18       	mov    %rcx,0x18(%rax,%rdx,8)
    d6ed:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    d6f2:	48 89 4c d0 20       	mov    %rcx,0x20(%rax,%rdx,8)
    d6f7:	48 83 c2 04          	add    $0x4,%rdx
    d6fb:	49 39 d6             	cmp    %rdx,%r14
    d6fe:	75 d0                	jne    d6d0 <fwp_data+0x80>
    d700:	eb 43                	jmp    d745 <fwp_data+0xf5>
    d702:	89 e8                	mov    %ebp,%eax
    d704:	eb 3f                	jmp    d745 <fwp_data+0xf5>
    d706:	44 89 f1             	mov    %r14d,%ecx
    d709:	83 e1 fc             	and    $0xfffffffc,%ecx
    d70c:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
    d713:	00 
    d714:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    d718:	31 f6                	xor    %esi,%esi
    d71a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    d720:	0f 10 04 33          	movups (%rbx,%rsi,1),%xmm0
    d724:	0f 10 4c 33 10       	movups 0x10(%rbx,%rsi,1),%xmm1
    d729:	0f 11 44 30 08       	movups %xmm0,0x8(%rax,%rsi,1)
    d72e:	0f 11 4c 30 18       	movups %xmm1,0x18(%rax,%rsi,1)
    d733:	48 83 c6 20          	add    $0x20,%rsi
    d737:	48 39 f2             	cmp    %rsi,%rdx
    d73a:	75 e4                	jne    d720 <fwp_data+0xd0>
    d73c:	4c 39 f1             	cmp    %r14,%rcx
    d73f:	0f 85 50 ff ff ff    	jne    d695 <fwp_data+0x45>
    d745:	48 83 c4 08          	add    $0x8,%rsp
    d749:	5b                   	pop    %rbx
    d74a:	41 5e                	pop    %r14
    d74c:	41 5f                	pop    %r15
    d74e:	5d                   	pop    %rbp
    d74f:	c3                   	ret

000000000000d750 <tp_value>:
    d750:	55                   	push   %rbp
    d751:	41 57                	push   %r15
    d753:	41 56                	push   %r14
    d755:	41 55                	push   %r13
    d757:	41 54                	push   %r12
    d759:	53                   	push   %rbx
    d75a:	48 81 ec d8 01 00 00 	sub    $0x1d8,%rsp
    d761:	49 89 cc             	mov    %rcx,%r12
    d764:	85 d2                	test   %edx,%edx
    d766:	0f 84 99 00 00 00    	je     d805 <tp_value+0xb5>
    d76c:	83 3e 0c             	cmpl   $0xc,(%rsi)
    d76f:	0f 85 90 00 00 00    	jne    d805 <tp_value+0xb5>
    d775:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    d779:	4c 8b 7f 10          	mov    0x10(%rdi),%r15
    d77d:	4c 89 e5             	mov    %r12,%rbp
    d780:	4c 8b 27             	mov    (%rdi),%r12
    d783:	4d 01 fc             	add    %r15,%r12
    d786:	4d 29 fd             	sub    %r15,%r13
    d789:	0f 85 ea 00 00 00    	jne    d879 <tp_value+0x129>
    d78f:	49 8d 55 09          	lea    0x9(%r13),%rdx
    d793:	48 ff 05 0e e7 00 00 	incq   0xe70e(%rip)        # 1bea8 <measured_calls>
    d79a:	48 01 15 0f e7 00 00 	add    %rdx,0xe70f(%rip)        # 1beb0 <measured_bytes>
    d7a1:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    d7a8:	0f 87 38 02 00 00    	ja     d9e6 <tp_value+0x296>
    d7ae:	49 8d 4d 18          	lea    0x18(%r13),%rcx
    d7b2:	48 c1 e9 04          	shr    $0x4,%rcx
    d7b6:	48 8d 05 cb ca 00 00 	lea    0xcacb(%rip),%rax        # 1a288 <fwp_gc>
    d7bd:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    d7c4:	00 
    d7c5:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    d7cc:	48 29 0d b5 ca 00 00 	sub    %rcx,0xcab5(%rip)        # 1a288 <fwp_gc>
    d7d3:	0f 88 0d 02 00 00    	js     d9e6 <tp_value+0x296>
    d7d9:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    d7dd:	4c 8d 04 f0          	lea    (%rax,%rsi,8),%r8
    d7e1:	49 81 c0 c8 03 00 00 	add    $0x3c8,%r8
    d7e8:	4d 8b 30             	mov    (%r8),%r14
    d7eb:	4d 85 f6             	test   %r14,%r14
    d7ee:	0f 84 d6 01 00 00    	je     d9ca <tp_value+0x27a>
    d7f4:	48 89 fb             	mov    %rdi,%rbx
    d7f7:	49 8b 06             	mov    (%r14),%rax
    d7fa:	48 f7 d0             	not    %rax
    d7fd:	49 89 00             	mov    %rax,(%r8)
    d800:	e9 de 04 00 00       	jmp    dce3 <tp_value+0x593>
    d805:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    d809:	4c 8b 7f 10          	mov    0x10(%rdi),%r15
    d80d:	4d 39 ef             	cmp    %r13,%r15
    d810:	73 2e                	jae    d840 <tp_value+0xf0>
    d812:	48 8b 07             	mov    (%rdi),%rax
    d815:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    d81c:	00 00 00 
    d81f:	90                   	nop
    d820:	46 0f b6 04 38       	movzbl (%rax,%r15,1),%r8d
    d825:	49 83 f8 20          	cmp    $0x20,%r8
    d829:	77 15                	ja     d840 <tp_value+0xf0>
    d82b:	4c 0f a3 c1          	bt     %r8,%rcx
    d82f:	73 0f                	jae    d840 <tp_value+0xf0>
    d831:	49 ff c7             	inc    %r15
    d834:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    d838:	4d 39 fd             	cmp    %r15,%r13
    d83b:	75 e3                	jne    d820 <tp_value+0xd0>
    d83d:	4d 89 ef             	mov    %r13,%r15
    d840:	8b 06                	mov    (%rsi),%eax
    d842:	45 31 f6             	xor    %r14d,%r14d
    d845:	48 83 f8 15          	cmp    $0x15,%rax
    d849:	0f 87 c8 04 00 00    	ja     dd17 <tp_value+0x5c7>
    d84f:	48 8d 0d e2 79 00 00 	lea    0x79e2(%rip),%rcx        # 15238 <_IO_stdin_used+0x238>
    d856:	4c 63 04 81          	movslq (%rcx,%rax,4),%r8
    d85a:	49 01 c8             	add    %rcx,%r8
    d85d:	41 ff e0             	jmp    *%r8
    d860:	4c 89 e2             	mov    %r12,%rdx
    d863:	48 81 c4 d8 01 00 00 	add    $0x1d8,%rsp
    d86a:	5b                   	pop    %rbx
    d86b:	41 5c                	pop    %r12
    d86d:	41 5d                	pop    %r13
    d86f:	41 5e                	pop    %r14
    d871:	41 5f                	pop    %r15
    d873:	5d                   	pop    %rbp
    d874:	e9 e7 16 00 00       	jmp    ef60 <tp_int>
    d879:	31 c0                	xor    %eax,%eax
    d87b:	eb 0f                	jmp    d88c <tp_value+0x13c>
    d87d:	0f 1f 00             	nopl   (%rax)
    d880:	48 ff c0             	inc    %rax
    d883:	4c 39 e8             	cmp    %r13,%rax
    d886:	0f 83 03 ff ff ff    	jae    d78f <tp_value+0x3f>
    d88c:	45 0f b6 04 04       	movzbl (%r12,%rax,1),%r8d
    d891:	45 84 c0             	test   %r8b,%r8b
    d894:	79 ea                	jns    d880 <tp_value+0x130>
    d896:	41 8d 48 3e          	lea    0x3e(%r8),%ecx
    d89a:	80 f9 1e             	cmp    $0x1e,%cl
    d89d:	73 11                	jae    d8b0 <tp_value+0x160>
    d89f:	b9 80 00 00 00       	mov    $0x80,%ecx
    d8a4:	be 01 00 00 00       	mov    $0x1,%esi
    d8a9:	ba 1f 00 00 00       	mov    $0x1f,%edx
    d8ae:	eb 38                	jmp    d8e8 <tp_value+0x198>
    d8b0:	44 89 c1             	mov    %r8d,%ecx
    d8b3:	80 e1 f0             	and    $0xf0,%cl
    d8b6:	80 f9 e0             	cmp    $0xe0,%cl
    d8b9:	75 11                	jne    d8cc <tp_value+0x17c>
    d8bb:	b9 00 08 00 00       	mov    $0x800,%ecx
    d8c0:	be 02 00 00 00       	mov    $0x2,%esi
    d8c5:	ba 0f 00 00 00       	mov    $0xf,%edx
    d8ca:	eb 1c                	jmp    d8e8 <tp_value+0x198>
    d8cc:	41 8d 48 10          	lea    0x10(%r8),%ecx
    d8d0:	80 f9 04             	cmp    $0x4,%cl
    d8d3:	0f 87 8c 15 00 00    	ja     ee65 <tp_value+0x1715>
    d8d9:	b9 00 00 01 00       	mov    $0x10000,%ecx
    d8de:	be 03 00 00 00       	mov    $0x3,%esi
    d8e3:	ba 07 00 00 00       	mov    $0x7,%edx
    d8e8:	89 f6                	mov    %esi,%esi
    d8ea:	4c 8d 0c 30          	lea    (%rax,%rsi,1),%r9
    d8ee:	45 31 f6             	xor    %r14d,%r14d
    d8f1:	4d 39 e9             	cmp    %r13,%r9
    d8f4:	0f 83 1d 04 00 00    	jae    dd17 <tp_value+0x5c7>
    d8fa:	45 0f b6 4c 04 01    	movzbl 0x1(%r12,%rax,1),%r9d
    d900:	45 89 ca             	mov    %r9d,%r10d
    d903:	41 83 e2 c0          	and    $0xffffffc0,%r10d
    d907:	41 81 fa 80 00 00 00 	cmp    $0x80,%r10d
    d90e:	0f 85 03 04 00 00    	jne    dd17 <tp_value+0x5c7>
    d914:	44 21 c2             	and    %r8d,%edx
    d917:	44 8d 46 01          	lea    0x1(%rsi),%r8d
    d91b:	41 89 d2             	mov    %edx,%r10d
    d91e:	41 c1 e2 06          	shl    $0x6,%r10d
    d922:	41 83 e1 3f          	and    $0x3f,%r9d
    d926:	45 09 d1             	or     %r10d,%r9d
    d929:	41 83 f8 02          	cmp    $0x2,%r8d
    d92d:	75 05                	jne    d934 <tp_value+0x1e4>
    d92f:	45 89 c8             	mov    %r9d,%r8d
    d932:	eb 5d                	jmp    d991 <tp_value+0x241>
    d934:	41 0f b6 54 04 02    	movzbl 0x2(%r12,%rax,1),%edx
    d93a:	41 89 d2             	mov    %edx,%r10d
    d93d:	41 83 e2 c0          	and    $0xffffffc0,%r10d
    d941:	41 81 fa 80 00 00 00 	cmp    $0x80,%r10d
    d948:	0f 85 c9 03 00 00    	jne    dd17 <tp_value+0x5c7>
    d94e:	45 89 ca             	mov    %r9d,%r10d
    d951:	41 c1 e2 06          	shl    $0x6,%r10d
    d955:	83 e2 3f             	and    $0x3f,%edx
    d958:	44 09 d2             	or     %r10d,%edx
    d95b:	41 83 f8 03          	cmp    $0x3,%r8d
    d95f:	75 08                	jne    d969 <tp_value+0x219>
    d961:	41 89 d0             	mov    %edx,%r8d
    d964:	44 89 ca             	mov    %r9d,%edx
    d967:	eb 28                	jmp    d991 <tp_value+0x241>
    d969:	45 0f b6 44 04 03    	movzbl 0x3(%r12,%rax,1),%r8d
    d96f:	45 89 c1             	mov    %r8d,%r9d
    d972:	41 83 e1 c0          	and    $0xffffffc0,%r9d
    d976:	41 81 f9 80 00 00 00 	cmp    $0x80,%r9d
    d97d:	0f 85 94 03 00 00    	jne    dd17 <tp_value+0x5c7>
    d983:	41 89 d1             	mov    %edx,%r9d
    d986:	41 c1 e1 06          	shl    $0x6,%r9d
    d98a:	41 83 e0 3f          	and    $0x3f,%r8d
    d98e:	45 09 c8             	or     %r9d,%r8d
    d991:	83 e2 e0             	and    $0xffffffe0,%edx
    d994:	81 fa 60 03 00 00    	cmp    $0x360,%edx
    d99a:	0f 84 77 03 00 00    	je     dd17 <tp_value+0x5c7>
    d9a0:	41 39 c8             	cmp    %ecx,%r8d
    d9a3:	0f 82 6e 03 00 00    	jb     dd17 <tp_value+0x5c7>
    d9a9:	41 81 f8 ff ff 10 00 	cmp    $0x10ffff,%r8d
    d9b0:	0f 87 61 03 00 00    	ja     dd17 <tp_value+0x5c7>
    d9b6:	48 01 f0             	add    %rsi,%rax
    d9b9:	48 ff c0             	inc    %rax
    d9bc:	4c 39 e8             	cmp    %r13,%rax
    d9bf:	0f 82 c7 fe ff ff    	jb     d88c <tp_value+0x13c>
    d9c5:	e9 c5 fd ff ff       	jmp    d78f <tp_value+0x3f>
    d9ca:	4c 8b b4 f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r14
    d9d1:	00 
    d9d2:	4c 8b 84 f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%r8
    d9d9:	00 
    d9da:	4d 29 f0             	sub    %r14,%r8
    d9dd:	49 39 c8             	cmp    %rcx,%r8
    d9e0:	0f 83 ea 02 00 00    	jae    dcd0 <tp_value+0x580>
    d9e6:	48 89 fb             	mov    %rdi,%rbx
    d9e9:	48 89 d7             	mov    %rdx,%rdi
    d9ec:	be 01 00 00 00       	mov    $0x1,%esi
    d9f1:	e8 ca a8 ff ff       	call   82c0 <fwp_gc_alloc_slow>
    d9f6:	49 89 c6             	mov    %rax,%r14
    d9f9:	e9 ef 02 00 00       	jmp    dced <tp_value+0x59d>
    d9fe:	f3 0f 6f 46 38       	movdqu 0x38(%rsi),%xmm0
    da03:	66 0f 7f 44 24 50    	movdqa %xmm0,0x50(%rsp)
    da09:	31 c9                	xor    %ecx,%ecx
    da0b:	83 f8 13             	cmp    $0x13,%eax
    da0e:	0f 94 c1             	sete   %cl
    da11:	66 0f ef c0          	pxor   %xmm0,%xmm0
    da15:	66 0f 7f 44 24 60    	movdqa %xmm0,0x60(%rsp)
    da1b:	48 c7 44 24 70 00 00 	movq   $0x0,0x70(%rsp)
    da22:	00 00 
    da24:	89 4c 24 78          	mov    %ecx,0x78(%rsp)
    da28:	48 8d 0d a1 8c 00 00 	lea    0x8ca1(%rip),%rcx        # 166d0 <exec_in_fp0+0xe60>
    da2f:	48 8d 05 c6 7f 00 00 	lea    0x7fc6(%rip),%rax        # 159fc <exec_in_fp0+0x18c>
    da36:	48 0f 44 c1          	cmove  %rcx,%rax
    da3a:	4d 39 ef             	cmp    %r13,%r15
    da3d:	73 31                	jae    da70 <tp_value+0x320>
    da3f:	48 8b 0f             	mov    (%rdi),%rcx
    da42:	48 ba 00 26 00 00 01 	movabs $0x100002600,%rdx
    da49:	00 00 00 
    da4c:	0f 1f 40 00          	nopl   0x0(%rax)
    da50:	46 0f b6 04 39       	movzbl (%rcx,%r15,1),%r8d
    da55:	49 83 f8 20          	cmp    $0x20,%r8
    da59:	77 15                	ja     da70 <tp_value+0x320>
    da5b:	4c 0f a3 c2          	bt     %r8,%rdx
    da5f:	73 0f                	jae    da70 <tp_value+0x320>
    da61:	49 ff c7             	inc    %r15
    da64:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    da68:	4d 39 fd             	cmp    %r15,%r13
    da6b:	75 e3                	jne    da50 <tp_value+0x300>
    da6d:	4d 89 ef             	mov    %r13,%r15
    da70:	4d 29 fd             	sub    %r15,%r13
    da73:	45 31 f6             	xor    %r14d,%r14d
    da76:	49 83 fd 03          	cmp    $0x3,%r13
    da7a:	0f 82 97 02 00 00    	jb     dd17 <tp_value+0x5c7>
    da80:	48 8b 0f             	mov    (%rdi),%rcx
    da83:	42 0f b7 14 39       	movzwl (%rcx,%r15,1),%edx
    da88:	66 33 10             	xor    (%rax),%dx
    da8b:	42 0f b6 4c 39 02    	movzbl 0x2(%rcx,%r15,1),%ecx
    da91:	32 48 02             	xor    0x2(%rax),%cl
    da94:	0f b6 c1             	movzbl %cl,%eax
    da97:	66 09 d0             	or     %dx,%ax
    da9a:	0f 85 77 02 00 00    	jne    dd17 <tp_value+0x5c7>
    daa0:	48 89 f3             	mov    %rsi,%rbx
    daa3:	49 83 c7 03          	add    $0x3,%r15
    daa7:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    daab:	48 8d 35 f0 8c 00 00 	lea    0x8cf0(%rip),%rsi        # 167a2 <exec_in_fp0+0xf32>
    dab2:	48 8d 15 14 7f 00 00 	lea    0x7f14(%rip),%rdx        # 159cd <exec_in_fp0+0x15d>
    dab9:	48 8d 0d 50 23 00 00 	lea    0x2350(%rip),%rcx        # fe10 <tp_kv_item>
    dac0:	4c 8d 44 24 50       	lea    0x50(%rsp),%r8
    dac5:	e8 e6 1f 00 00       	call   fab0 <tp_list_of>
    daca:	85 c0                	test   %eax,%eax
    dacc:	0f 84 dc 0a 00 00    	je     e5ae <tp_value+0xe5e>
    dad2:	48 83 7c 24 68 00    	cmpq   $0x0,0x68(%rsp)
    dad8:	0f 84 c3 0d 00 00    	je     e8a1 <tp_value+0x1151>
    dade:	48 8d 05 2b e4 01 00 	lea    0x1e42b(%rip),%rax        # 2bf10 <fwp_empty_map>
    dae5:	45 31 f6             	xor    %r14d,%r14d
    dae8:	48 8b 4c 24 60       	mov    0x60(%rsp),%rcx
    daed:	4a 8b 3c f1          	mov    (%rcx,%r14,8),%rdi
    daf1:	4a 8b 74 f1 08       	mov    0x8(%rcx,%r14,8),%rsi
    daf6:	48 8b 4b 38          	mov    0x38(%rbx),%rcx
    dafa:	48 89 c2             	mov    %rax,%rdx
    dafd:	e8 ee 23 00 00       	call   fef0 <fwp_p_map_insert>
    db02:	49 83 c6 02          	add    $0x2,%r14
    db06:	4c 3b 74 24 68       	cmp    0x68(%rsp),%r14
    db0b:	72 db                	jb     dae8 <tp_value+0x398>
    db0d:	e9 96 0d 00 00       	jmp    e8a8 <tp_value+0x1158>
    db12:	66 0f ef c0          	pxor   %xmm0,%xmm0
    db16:	f3 0f 7f 44 24 68    	movdqu %xmm0,0x68(%rsp)
    db1c:	f3 0f 7f 44 24 58    	movdqu %xmm0,0x58(%rsp)
    db22:	48 c7 44 24 78 00 00 	movq   $0x0,0x78(%rsp)
    db29:	00 00 
    db2b:	48 8b 4e 38          	mov    0x38(%rsi),%rcx
    db2f:	48 89 4c 24 50       	mov    %rcx,0x50(%rsp)
    db34:	83 f8 11             	cmp    $0x11,%eax
    db37:	75 6c                	jne    dba5 <tp_value+0x455>
    db39:	4d 39 ef             	cmp    %r13,%r15
    db3c:	73 32                	jae    db70 <tp_value+0x420>
    db3e:	48 8b 07             	mov    (%rdi),%rax
    db41:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    db48:	00 00 00 
    db4b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    db50:	42 0f b6 14 38       	movzbl (%rax,%r15,1),%edx
    db55:	48 83 fa 20          	cmp    $0x20,%rdx
    db59:	77 15                	ja     db70 <tp_value+0x420>
    db5b:	48 0f a3 d1          	bt     %rdx,%rcx
    db5f:	73 0f                	jae    db70 <tp_value+0x420>
    db61:	49 ff c7             	inc    %r15
    db64:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    db68:	4d 39 fd             	cmp    %r15,%r13
    db6b:	75 e3                	jne    db50 <tp_value+0x400>
    db6d:	4d 89 ef             	mov    %r13,%r15
    db70:	4d 29 fd             	sub    %r15,%r13
    db73:	45 31 f6             	xor    %r14d,%r14d
    db76:	49 83 fd 05          	cmp    $0x5,%r13
    db7a:	0f 82 97 01 00 00    	jb     dd17 <tp_value+0x5c7>
    db80:	48 8b 07             	mov    (%rdi),%rax
    db83:	b9 61 72 72 61       	mov    $0x61727261,%ecx
    db88:	42 33 0c 38          	xor    (%rax,%r15,1),%ecx
    db8c:	42 0f b6 44 38 04    	movzbl 0x4(%rax,%r15,1),%eax
    db92:	83 f0 79             	xor    $0x79,%eax
    db95:	09 c8                	or     %ecx,%eax
    db97:	0f 85 7a 01 00 00    	jne    dd17 <tp_value+0x5c7>
    db9d:	49 83 c7 05          	add    $0x5,%r15
    dba1:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    dba5:	48 89 f3             	mov    %rsi,%rbx
    dba8:	48 8d 35 a2 7d 00 00 	lea    0x7da2(%rip),%rsi        # 15951 <exec_in_fp0+0xe1>
    dbaf:	48 8d 15 50 8d 00 00 	lea    0x8d50(%rip),%rdx        # 16906 <exec_in_fp0+0x1096>
    dbb6:	48 8d 0d 13 22 00 00 	lea    0x2213(%rip),%rcx        # fdd0 <tp_elem_item>
    dbbd:	4c 8d 44 24 50       	lea    0x50(%rsp),%r8
    dbc2:	e8 e9 1e 00 00       	call   fab0 <tp_list_of>
    dbc7:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
    dbcc:	85 c0                	test   %eax,%eax
    dbce:	0f 84 2a 05 00 00    	je     e0fe <tp_value+0x9ae>
    dbd4:	48 8b 74 24 68       	mov    0x68(%rsp),%rsi
    dbd9:	e8 82 f2 ff ff       	call   ce60 <fwp_list_from>
    dbde:	49 89 c6             	mov    %rax,%r14
    dbe1:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
    dbe6:	e8 35 cf ff ff       	call   ab20 <fwp_mem_free>
    dbeb:	83 3b 11             	cmpl   $0x11,(%rbx)
    dbee:	0f 85 4a 10 00 00    	jne    ec3e <tp_value+0x14ee>
    dbf4:	4c 8b 7b 38          	mov    0x38(%rbx),%r15
    dbf8:	4d 85 f6             	test   %r14,%r14
    dbfb:	0f 84 e5 0a 00 00    	je     e6e6 <tp_value+0xf96>
    dc01:	31 ff                	xor    %edi,%edi
    dc03:	4c 89 f0             	mov    %r14,%rax
    dc06:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    dc0d:	00 00 00 
    dc10:	48 ff c7             	inc    %rdi
    dc13:	48 8b 40 10          	mov    0x10(%rax),%rax
    dc17:	48 85 c0             	test   %rax,%rax
    dc1a:	75 f4                	jne    dc10 <tp_value+0x4c0>
    dc1c:	4c 89 fe             	mov    %r15,%rsi
    dc1f:	e8 0c 7c ff ff       	call   5830 <fwp_array_new_packed>
    dc24:	b9 04 00 00 00       	mov    $0x4,%ecx
    dc29:	ba 84 04 00 00       	mov    $0x484,%edx
    dc2e:	be 21 00 00 00       	mov    $0x21,%esi
    dc33:	bf 42 00 00 00       	mov    $0x42,%edi
    dc38:	4d 89 f0             	mov    %r14,%r8
    dc3b:	eb 15                	jmp    dc52 <tp_value+0x502>
    dc3d:	4c 89 4c c8 e8       	mov    %r9,-0x18(%rax,%rcx,8)
    dc42:	4d 8b 40 10          	mov    0x10(%r8),%r8
    dc46:	48 ff c1             	inc    %rcx
    dc49:	4d 85 c0             	test   %r8,%r8
    dc4c:	0f 84 9e 0a 00 00    	je     e6f0 <tp_value+0xfa0>
    dc52:	48 83 38 00          	cmpq   $0x0,(%rax)
    dc56:	0f 88 cb 12 00 00    	js     ef27 <tp_value+0x17d7>
    dc5c:	4d 8b 48 08          	mov    0x8(%r8),%r9
    dc60:	4d 85 ff             	test   %r15,%r15
    dc63:	74 d8                	je     dc3d <tp_value+0x4ed>
    dc65:	45 8b 17             	mov    (%r15),%r10d
    dc68:	41 83 fa 0a          	cmp    $0xa,%r10d
    dc6c:	77 cf                	ja     dc3d <tp_value+0x4ed>
    dc6e:	44 0f a3 d2          	bt     %r10d,%edx
    dc72:	72 13                	jb     dc87 <tp_value+0x537>
    dc74:	44 0f a3 d6          	bt     %r10d,%esi
    dc78:	72 14                	jb     dc8e <tp_value+0x53e>
    dc7a:	44 0f a3 d7          	bt     %r10d,%edi
    dc7e:	73 bd                	jae    dc3d <tp_value+0x4ed>
    dc80:	66 44 89 0c 48       	mov    %r9w,(%rax,%rcx,2)
    dc85:	eb bb                	jmp    dc42 <tp_value+0x4f2>
    dc87:	44 89 4c 88 f8       	mov    %r9d,-0x8(%rax,%rcx,4)
    dc8c:	eb b4                	jmp    dc42 <tp_value+0x4f2>
    dc8e:	44 88 4c 08 04       	mov    %r9b,0x4(%rax,%rcx,1)
    dc93:	eb ad                	jmp    dc42 <tp_value+0x4f2>
    dc95:	49 89 f7             	mov    %rsi,%r15
    dc98:	48 8d 74 24 50       	lea    0x50(%rsp),%rsi
    dc9d:	ba 80 00 00 00       	mov    $0x80,%edx
    dca2:	e8 49 20 00 00       	call   fcf0 <tp_token>
    dca7:	45 31 f6             	xor    %r14d,%r14d
    dcaa:	48 83 f8 7f          	cmp    $0x7f,%rax
    dcae:	77 67                	ja     dd17 <tp_value+0x5c7>
    dcb0:	8b 54 24 50          	mov    0x50(%rsp),%edx
    dcb4:	81 fa 69 6e 66 00    	cmp    $0x666e69,%edx
    dcba:	0f 85 0c 04 00 00    	jne    e0cc <tp_value+0x97c>
    dcc0:	f2 0f 10 05 f8 74 00 	movsd  0x74f8(%rip),%xmm0        # 151c0 <_IO_stdin_used+0x1c0>
    dcc7:	00 
    dcc8:	4c 89 f9             	mov    %r15,%rcx
    dccb:	e9 f5 08 00 00       	jmp    e5c5 <tp_value+0xe75>
    dcd0:	48 89 fb             	mov    %rdi,%rbx
    dcd3:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    dcd7:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    dcdd:	4c 01 f1             	add    %r14,%rcx
    dce0:	48 89 08             	mov    %rcx,(%rax)
    dce3:	4c 89 f7             	mov    %r14,%rdi
    dce6:	31 f6                	xor    %esi,%esi
    dce8:	e8 23 55 ff ff       	call   3210 <memset@plt>
    dced:	4d 89 2e             	mov    %r13,(%r14)
    dcf0:	49 8d 7e 08          	lea    0x8(%r14),%rdi
    dcf4:	4c 89 e6             	mov    %r12,%rsi
    dcf7:	4c 89 ea             	mov    %r13,%rdx
    dcfa:	e8 31 56 ff ff       	call   3330 <memcpy@plt>
    dcff:	43 c6 44 2e 08 00    	movb   $0x0,0x8(%r14,%r13,1)
    dd05:	4c 89 75 00          	mov    %r14,0x0(%rbp)
    dd09:	48 8b 43 08          	mov    0x8(%rbx),%rax
    dd0d:	48 89 43 10          	mov    %rax,0x10(%rbx)
    dd11:	41 be 01 00 00 00    	mov    $0x1,%r14d
    dd17:	44 89 f0             	mov    %r14d,%eax
    dd1a:	48 81 c4 d8 01 00 00 	add    $0x1d8,%rsp
    dd21:	5b                   	pop    %rbx
    dd22:	41 5c                	pop    %r12
    dd24:	41 5d                	pop    %r13
    dd26:	41 5e                	pop    %r14
    dd28:	41 5f                	pop    %r15
    dd2a:	5d                   	pop    %rbp
    dd2b:	c3                   	ret
    dd2c:	85 d2                	test   %edx,%edx
    dd2e:	0f 85 49 fa ff ff    	jne    d77d <tp_value+0x2d>
    dd34:	4c 89 e6             	mov    %r12,%rsi
    dd37:	48 81 c4 d8 01 00 00 	add    $0x1d8,%rsp
    dd3e:	5b                   	pop    %rbx
    dd3f:	41 5c                	pop    %r12
    dd41:	41 5d                	pop    %r13
    dd43:	41 5e                	pop    %r14
    dd45:	41 5f                	pop    %r15
    dd47:	5d                   	pop    %rbp
    dd48:	e9 e3 18 00 00       	jmp    f630 <tp_quoted>
    dd4d:	66 0f ef c0          	pxor   %xmm0,%xmm0
    dd51:	66 0f 7f 44 24 70    	movdqa %xmm0,0x70(%rsp)
    dd57:	66 0f 7f 44 24 60    	movdqa %xmm0,0x60(%rsp)
    dd5d:	66 0f 7f 44 24 50    	movdqa %xmm0,0x50(%rsp)
    dd63:	4d 39 ef             	cmp    %r13,%r15
    dd66:	73 38                	jae    dda0 <tp_value+0x650>
    dd68:	48 8b 07             	mov    (%rdi),%rax
    dd6b:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    dd72:	00 00 00 
    dd75:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    dd7c:	00 00 00 00 
    dd80:	42 0f b6 14 38       	movzbl (%rax,%r15,1),%edx
    dd85:	48 83 fa 20          	cmp    $0x20,%rdx
    dd89:	77 15                	ja     dda0 <tp_value+0x650>
    dd8b:	48 0f a3 d1          	bt     %rdx,%rcx
    dd8f:	73 0f                	jae    dda0 <tp_value+0x650>
    dd91:	49 ff c7             	inc    %r15
    dd94:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    dd98:	4d 39 fd             	cmp    %r15,%r13
    dd9b:	75 e3                	jne    dd80 <tp_value+0x630>
    dd9d:	4d 89 ef             	mov    %r13,%r15
    dda0:	4d 29 fd             	sub    %r15,%r13
    dda3:	45 31 f6             	xor    %r14d,%r14d
    dda6:	49 83 fd 05          	cmp    $0x5,%r13
    ddaa:	72 1d                	jb     ddc9 <tp_value+0x679>
    ddac:	48 8b 07             	mov    (%rdi),%rax
    ddaf:	b9 62 79 74 65       	mov    $0x65747962,%ecx
    ddb4:	42 33 0c 38          	xor    (%rax,%r15,1),%ecx
    ddb8:	42 0f b6 44 38 04    	movzbl 0x4(%rax,%r15,1),%eax
    ddbe:	83 f0 73             	xor    $0x73,%eax
    ddc1:	09 c8                	or     %ecx,%eax
    ddc3:	0f 84 43 07 00 00    	je     e50c <tp_value+0xdbc>
    ddc9:	31 ff                	xor    %edi,%edi
    ddcb:	e8 50 cd ff ff       	call   ab20 <fwp_mem_free>
    ddd0:	e9 42 ff ff ff       	jmp    dd17 <tp_value+0x5c7>
    ddd5:	48 89 f3             	mov    %rsi,%rbx
    ddd8:	48 8d 74 24 50       	lea    0x50(%rsp),%rsi
    dddd:	ba 00 01 00 00       	mov    $0x100,%edx
    dde2:	e8 09 1f 00 00       	call   fcf0 <tp_token>
    dde7:	45 31 f6             	xor    %r14d,%r14d
    ddea:	48 83 f8 02          	cmp    $0x2,%rax
    ddee:	0f 82 23 ff ff ff    	jb     dd17 <tp_value+0x5c7>
    ddf4:	80 7c 24 50 30       	cmpb   $0x30,0x50(%rsp)
    ddf9:	0f 85 18 ff ff ff    	jne    dd17 <tp_value+0x5c7>
    ddff:	80 7c 24 51 74       	cmpb   $0x74,0x51(%rsp)
    de04:	0f 85 0d ff ff ff    	jne    dd17 <tp_value+0x5c7>
    de0a:	48 8d 48 fe          	lea    -0x2(%rax),%rcx
    de0e:	48 63 53 48          	movslq 0x48(%rbx),%rdx
    de12:	48 39 d1             	cmp    %rdx,%rcx
    de15:	0f 87 fc fe ff ff    	ja     dd17 <tp_value+0x5c7>
    de1b:	48 83 f8 03          	cmp    $0x3,%rax
    de1f:	0f 82 d3 08 00 00    	jb     e6f8 <tp_value+0xfa8>
    de25:	ba 02 00 00 00       	mov    $0x2,%edx
    de2a:	31 c9                	xor    %ecx,%ecx
    de2c:	e9 0a 02 00 00       	jmp    e03b <tp_value+0x8eb>
    de31:	48 8d 74 24 50       	lea    0x50(%rsp),%rsi
    de36:	ba 10 00 00 00       	mov    $0x10,%edx
    de3b:	e8 b0 1e 00 00       	call   fcf0 <tp_token>
    de40:	8b 44 24 50          	mov    0x50(%rsp),%eax
    de44:	89 c1                	mov    %eax,%ecx
    de46:	81 f1 2b 31 00 00    	xor    $0x312b,%ecx
    de4c:	0f b6 54 24 52       	movzbl 0x52(%rsp),%edx
    de51:	66 09 ca             	or     %cx,%dx
    de54:	41 be 01 00 00 00    	mov    $0x1,%r14d
    de5a:	0f 84 de 0d 00 00    	je     ec3e <tp_value+0x14ee>
    de60:	66 83 f8 31          	cmp    $0x31,%ax
    de64:	0f 84 d4 0d 00 00    	je     ec3e <tp_value+0x14ee>
    de6a:	45 31 f6             	xor    %r14d,%r14d
    de6d:	66 83 f8 30          	cmp    $0x30,%ax
    de71:	0f 84 c7 0d 00 00    	je     ec3e <tp_value+0x14ee>
    de77:	b8 2d 31 00 00       	mov    $0x312d,%eax
    de7c:	33 44 24 50          	xor    0x50(%rsp),%eax
    de80:	0f b6 4c 24 52       	movzbl 0x52(%rsp),%ecx
    de85:	66 09 c1             	or     %ax,%cx
    de88:	0f 85 89 fe ff ff    	jne    dd17 <tp_value+0x5c7>
    de8e:	49 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%r14
    de95:	e9 a4 0d 00 00       	jmp    ec3e <tp_value+0x14ee>
    de9a:	48 8b 6e 08          	mov    0x8(%rsi),%rbp
    de9e:	48 85 ed             	test   %rbp,%rbp
    dea1:	4c 89 64 24 18       	mov    %r12,0x18(%rsp)
    dea6:	0f 84 5f 02 00 00    	je     e10b <tp_value+0x9bb>
    deac:	48 89 f3             	mov    %rsi,%rbx
    deaf:	49 89 fe             	mov    %rdi,%r14
    deb2:	48 8d 35 1b 88 00 00 	lea    0x881b(%rip),%rsi        # 166d4 <exec_in_fp0+0xe64>
    deb9:	48 89 ef             	mov    %rbp,%rdi
    debc:	e8 0f 54 ff ff       	call   32d0 <strcmp@plt>
    dec1:	85 c0                	test   %eax,%eax
    dec3:	0f 84 06 05 00 00    	je     e3cf <tp_value+0xc7f>
    dec9:	48 89 d8             	mov    %rbx,%rax
    decc:	44 8b 63 10          	mov    0x10(%rbx),%r12d
    ded0:	4d 39 ef             	cmp    %r13,%r15
    ded3:	73 30                	jae    df05 <tp_value+0x7b5>
    ded5:	4c 89 f1             	mov    %r14,%rcx
    ded8:	49 8b 16             	mov    (%r14),%rdx
    dedb:	48 be 00 26 00 00 01 	movabs $0x100002600,%rsi
    dee2:	00 00 00 
    dee5:	42 0f b6 3c 3a       	movzbl (%rdx,%r15,1),%edi
    deea:	48 83 ff 20          	cmp    $0x20,%rdi
    deee:	77 15                	ja     df05 <tp_value+0x7b5>
    def0:	48 0f a3 fe          	bt     %rdi,%rsi
    def4:	73 0f                	jae    df05 <tp_value+0x7b5>
    def6:	49 ff c7             	inc    %r15
    def9:	4c 89 79 10          	mov    %r15,0x10(%rcx)
    defd:	4d 39 fd             	cmp    %r15,%r13
    df00:	75 e3                	jne    dee5 <tp_value+0x795>
    df02:	4d 89 ef             	mov    %r13,%r15
    df05:	48 83 c0 10          	add    $0x10,%rax
    df09:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    df0e:	48 89 ef             	mov    %rbp,%rdi
    df11:	e8 5a 52 ff ff       	call   3170 <strlen@plt>
    df16:	4d 29 fd             	sub    %r15,%r13
    df19:	49 39 c5             	cmp    %rax,%r13
    df1c:	72 1c                	jb     df3a <tp_value+0x7ea>
    df1e:	49 8b 3e             	mov    (%r14),%rdi
    df21:	4c 01 ff             	add    %r15,%rdi
    df24:	48 89 ee             	mov    %rbp,%rsi
    df27:	49 89 c5             	mov    %rax,%r13
    df2a:	48 89 c2             	mov    %rax,%rdx
    df2d:	e8 3e 54 ff ff       	call   3370 <bcmp@plt>
    df32:	85 c0                	test   %eax,%eax
    df34:	0f 84 58 0b 00 00    	je     ea92 <tp_value+0x1342>
    df3a:	4c 89 f7             	mov    %r14,%rdi
    df3d:	48 89 de             	mov    %rbx,%rsi
    df40:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    df45:	49 63 c4             	movslq %r12d,%rax
    df48:	48 8d 04 c5 08 00 00 	lea    0x8(,%rax,8),%rax
    df4f:	00 
    df50:	4c 8b 25 51 df 00 00 	mov    0xdf51(%rip),%r12        # 1bea8 <measured_calls>
    df57:	49 ff c4             	inc    %r12
    df5a:	4c 89 25 47 df 00 00 	mov    %r12,0xdf47(%rip)        # 1bea8 <measured_calls>
    df61:	4c 8b 2d 48 df 00 00 	mov    0xdf48(%rip),%r13        # 1beb0 <measured_bytes>
    df68:	49 01 c5             	add    %rax,%r13
    df6b:	4c 89 2d 3e df 00 00 	mov    %r13,0xdf3e(%rip)        # 1beb0 <measured_bytes>
    df72:	4c 8d 35 0f c3 00 00 	lea    0xc30f(%rip),%r14        # 1a288 <fwp_gc>
    df79:	48 3d 00 40 00 00    	cmp    $0x4000,%rax
    df7f:	0f 87 79 06 00 00    	ja     e5fe <tp_value+0xeae>
    df85:	48 8d 48 0f          	lea    0xf(%rax),%rcx
    df89:	48 c1 e9 04          	shr    $0x4,%rcx
    df8d:	42 0f b6 8c 31 e8 0b 	movzbl 0xbe8(%rcx,%r14,1),%ecx
    df94:	00 00 
    df96:	41 8b 94 8e 48 0b 00 	mov    0xb48(%r14,%rcx,4),%edx
    df9d:	00 
    df9e:	48 29 15 e3 c2 00 00 	sub    %rdx,0xc2e3(%rip)        # 1a288 <fwp_gc>
    dfa5:	0f 88 53 06 00 00    	js     e5fe <tp_value+0xeae>
    dfab:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    dfaf:	4d 8d 04 ce          	lea    (%r14,%rcx,8),%r8
    dfb3:	49 81 c0 88 07 00 00 	add    $0x788,%r8
    dfba:	4d 8b 08             	mov    (%r8),%r9
    dfbd:	4d 85 c9             	test   %r9,%r9
    dfc0:	0f 84 1c 06 00 00    	je     e5e2 <tp_value+0xe92>
    dfc6:	48 89 f5             	mov    %rsi,%rbp
    dfc9:	48 89 fb             	mov    %rdi,%rbx
    dfcc:	49 8b 01             	mov    (%r9),%rax
    dfcf:	48 f7 d0             	not    %rax
    dfd2:	49 89 00             	mov    %rax,(%r8)
    dfd5:	e9 40 07 00 00       	jmp    e71a <tp_value+0xfca>
    dfda:	48 8b 07             	mov    (%rdi),%rax
    dfdd:	4d 39 ef             	cmp    %r13,%r15
    dfe0:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    dfe5:	89 54 24 08          	mov    %edx,0x8(%rsp)
    dfe9:	73 77                	jae    e062 <tp_value+0x912>
    dfeb:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    dff2:	00 00 00 
    dff5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    dffc:	00 00 00 00 
    e000:	46 0f b6 04 38       	movzbl (%rax,%r15,1),%r8d
    e005:	49 83 f8 20          	cmp    $0x20,%r8
    e009:	77 57                	ja     e062 <tp_value+0x912>
    e00b:	4c 0f a3 c1          	bt     %r8,%rcx
    e00f:	73 51                	jae    e062 <tp_value+0x912>
    e011:	49 ff c7             	inc    %r15
    e014:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    e018:	4d 39 fd             	cmp    %r15,%r13
    e01b:	75 e3                	jne    e000 <tp_value+0x8b0>
    e01d:	48 89 f5             	mov    %rsi,%rbp
    e020:	4d 89 ef             	mov    %r13,%r15
    e023:	e9 19 02 00 00       	jmp    e241 <tp_value+0xaf1>
    e028:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    e02c:	48 ff c9             	dec    %rcx
    e02f:	48 ff c2             	inc    %rdx
    e032:	48 39 d0             	cmp    %rdx,%rax
    e035:	0f 84 bf 06 00 00    	je     e6fa <tp_value+0xfaa>
    e03b:	0f b6 74 14 50       	movzbl 0x50(%rsp,%rdx,1),%esi
    e040:	83 fe 30             	cmp    $0x30,%esi
    e043:	74 17                	je     e05c <tp_value+0x90c>
    e045:	83 fe 2d             	cmp    $0x2d,%esi
    e048:	74 de                	je     e028 <tp_value+0x8d8>
    e04a:	83 fe 2b             	cmp    $0x2b,%esi
    e04d:	0f 85 12 0e 00 00    	jne    ee65 <tp_value+0x1715>
    e053:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    e057:	48 ff c1             	inc    %rcx
    e05a:	eb d3                	jmp    e02f <tp_value+0x8df>
    e05c:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    e060:	eb cd                	jmp    e02f <tp_value+0x8df>
    e062:	4d 39 ef             	cmp    %r13,%r15
    e065:	0f 83 cb 01 00 00    	jae    e236 <tp_value+0xae6>
    e06b:	49 b8 03 00 00 00 00 	movabs $0x4000000000003,%r8
    e072:	00 04 00 
    e075:	4c 89 f9             	mov    %r15,%rcx
    e078:	eb 16                	jmp    e090 <tp_value+0x940>
    e07a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    e080:	48 ff c1             	inc    %rcx
    e083:	48 89 4f 10          	mov    %rcx,0x10(%rdi)
    e087:	49 39 cd             	cmp    %rcx,%r13
    e08a:	0f 84 ae 01 00 00    	je     e23e <tp_value+0xaee>
    e090:	44 0f b6 0c 08       	movzbl (%rax,%rcx,1),%r9d
    e095:	45 8d 51 d0          	lea    -0x30(%r9),%r10d
    e099:	41 80 fa 0a          	cmp    $0xa,%r10b
    e09d:	72 e1                	jb     e080 <tp_value+0x930>
    e09f:	45 89 ca             	mov    %r9d,%r10d
    e0a2:	41 80 e2 df          	and    $0xdf,%r10b
    e0a6:	41 80 c2 bf          	add    $0xbf,%r10b
    e0aa:	41 80 fa 1a          	cmp    $0x1a,%r10b
    e0ae:	72 d0                	jb     e080 <tp_value+0x930>
    e0b0:	45 0f b6 c9          	movzbl %r9b,%r9d
    e0b4:	41 83 c1 d3          	add    $0xffffffd3,%r9d
    e0b8:	41 83 f9 32          	cmp    $0x32,%r9d
    e0bc:	77 06                	ja     e0c4 <tp_value+0x974>
    e0be:	4d 0f a3 c8          	bt     %r9,%r8
    e0c2:	72 bc                	jb     e080 <tp_value+0x930>
    e0c4:	48 89 f5             	mov    %rsi,%rbp
    e0c7:	e9 78 01 00 00       	jmp    e244 <tp_value+0xaf4>
    e0cc:	b9 2d 69 6e 66       	mov    $0x666e692d,%ecx
    e0d1:	33 4c 24 50          	xor    0x50(%rsp),%ecx
    e0d5:	0f b6 74 24 54       	movzbl 0x54(%rsp),%esi
    e0da:	09 ce                	or     %ecx,%esi
    e0dc:	4c 89 f9             	mov    %r15,%rcx
    e0df:	0f 84 d8 04 00 00    	je     e5bd <tp_value+0xe6d>
    e0e5:	81 fa 4e 61 4e 00    	cmp    $0x4e614e,%edx
    e0eb:	0f 85 38 05 00 00    	jne    e629 <tp_value+0xed9>
    e0f1:	f2 0f 10 05 d7 70 00 	movsd  0x70d7(%rip),%xmm0        # 151d0 <_IO_stdin_used+0x1d0>
    e0f8:	00 
    e0f9:	e9 c7 04 00 00       	jmp    e5c5 <tp_value+0xe75>
    e0fe:	e8 1d ca ff ff       	call   ab20 <fwp_mem_free>
    e103:	45 31 f6             	xor    %r14d,%r14d
    e106:	e9 0c fc ff ff       	jmp    dd17 <tp_value+0x5c7>
    e10b:	4c 63 66 10          	movslq 0x10(%rsi),%r12
    e10f:	4d 85 e4             	test   %r12,%r12
    e112:	0f 84 8f 05 00 00    	je     e6a7 <tp_value+0xf57>
    e118:	4c 8d 7e 10          	lea    0x10(%rsi),%r15
    e11c:	83 7e 48 00          	cmpl   $0x0,0x48(%rsi)
    e120:	0f 84 1f fe ff ff    	je     df45 <tp_value+0x7f5>
    e126:	48 89 f3             	mov    %rsi,%rbx
    e129:	49 c1 e4 03          	shl    $0x3,%r12
    e12d:	49 89 fd             	mov    %rdi,%r13
    e130:	4c 89 e7             	mov    %r12,%rdi
    e133:	e8 d8 a0 ff ff       	call   8210 <fwp_alloc>
    e138:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    e13d:	48 8d 35 a0 85 00 00 	lea    0x85a0(%rip),%rsi        # 166e4 <exec_in_fp0+0xe74>
    e144:	4d 89 ec             	mov    %r13,%r12
    e147:	4c 89 ef             	mov    %r13,%rdi
    e14a:	e8 c1 18 00 00       	call   fa10 <tp_eat>
    e14f:	85 c0                	test   %eax,%eax
    e151:	0f 84 c0 fb ff ff    	je     dd17 <tp_value+0x5c7>
    e157:	41 83 3f 00          	cmpl   $0x0,(%r15)
    e15b:	4c 89 e7             	mov    %r12,%rdi
    e15e:	0f 8e 9e 00 00 00    	jle    e202 <tp_value+0xab2>
    e164:	45 31 ed             	xor    %r13d,%r13d
    e167:	48 bd 00 26 00 00 01 	movabs $0x100002600,%rbp
    e16e:	00 00 00 
    e171:	4d 85 ed             	test   %r13,%r13
    e174:	74 54                	je     e1ca <tp_value+0xa7a>
    e176:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
    e17a:	48 8b 47 10          	mov    0x10(%rdi),%rax
    e17e:	48 39 c8             	cmp    %rcx,%rax
    e181:	73 27                	jae    e1aa <tp_value+0xa5a>
    e183:	48 8b 17             	mov    (%rdi),%rdx
    e186:	0f b6 34 02          	movzbl (%rdx,%rax,1),%esi
    e18a:	48 83 fe 20          	cmp    $0x20,%rsi
    e18e:	77 1a                	ja     e1aa <tp_value+0xa5a>
    e190:	48 0f a3 f5          	bt     %rsi,%rbp
    e194:	73 14                	jae    e1aa <tp_value+0xa5a>
    e196:	48 ff c0             	inc    %rax
    e199:	48 89 47 10          	mov    %rax,0x10(%rdi)
    e19d:	45 31 f6             	xor    %r14d,%r14d
    e1a0:	48 39 c1             	cmp    %rax,%rcx
    e1a3:	75 e1                	jne    e186 <tp_value+0xa36>
    e1a5:	e9 6d fb ff ff       	jmp    dd17 <tp_value+0x5c7>
    e1aa:	45 31 f6             	xor    %r14d,%r14d
    e1ad:	48 39 c1             	cmp    %rax,%rcx
    e1b0:	0f 84 61 fb ff ff    	je     dd17 <tp_value+0x5c7>
    e1b6:	48 8b 0f             	mov    (%rdi),%rcx
    e1b9:	80 3c 01 2c          	cmpb   $0x2c,(%rcx,%rax,1)
    e1bd:	0f 85 54 fb ff ff    	jne    dd17 <tp_value+0x5c7>
    e1c3:	48 ff c0             	inc    %rax
    e1c6:	48 89 47 10          	mov    %rax,0x10(%rdi)
    e1ca:	48 8b 43 20          	mov    0x20(%rbx),%rax
    e1ce:	4a 8b 34 e8          	mov    (%rax,%r13,8),%rsi
    e1d2:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    e1d7:	4a 8d 0c e8          	lea    (%rax,%r13,8),%rcx
    e1db:	45 31 f6             	xor    %r14d,%r14d
    e1de:	4c 89 e7             	mov    %r12,%rdi
    e1e1:	31 d2                	xor    %edx,%edx
    e1e3:	e8 68 f5 ff ff       	call   d750 <tp_value>
    e1e8:	85 c0                	test   %eax,%eax
    e1ea:	0f 84 27 fb ff ff    	je     dd17 <tp_value+0x5c7>
    e1f0:	4c 89 e7             	mov    %r12,%rdi
    e1f3:	49 ff c5             	inc    %r13
    e1f6:	49 63 07             	movslq (%r15),%rax
    e1f9:	49 39 c5             	cmp    %rax,%r13
    e1fc:	0f 8c 6f ff ff ff    	jl     e171 <tp_value+0xa21>
    e202:	48 8d 35 9c 85 00 00 	lea    0x859c(%rip),%rsi        # 167a5 <exec_in_fp0+0xf35>
    e209:	e8 02 18 00 00       	call   fa10 <tp_eat>
    e20e:	41 be 00 00 00 00    	mov    $0x0,%r14d
    e214:	85 c0                	test   %eax,%eax
    e216:	0f 84 fb fa ff ff    	je     dd17 <tp_value+0x5c7>
    e21c:	41 8b 3f             	mov    (%r15),%edi
    e21f:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    e224:	e8 87 1f 00 00       	call   101b0 <fwp_record>
    e229:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    e22e:	48 89 01             	mov    %rax,(%rcx)
    e231:	e9 db fa ff ff       	jmp    dd11 <tp_value+0x5c1>
    e236:	48 89 f5             	mov    %rsi,%rbp
    e239:	4c 89 f9             	mov    %r15,%rcx
    e23c:	eb 06                	jmp    e244 <tp_value+0xaf4>
    e23e:	48 89 f5             	mov    %rsi,%rbp
    e241:	4c 89 e9             	mov    %r13,%rcx
    e244:	4c 89 64 24 18       	mov    %r12,0x18(%rsp)
    e249:	4c 29 f9             	sub    %r15,%rcx
    e24c:	48 81 f9 ff 00 00 00 	cmp    $0xff,%rcx
    e253:	41 be ff 00 00 00    	mov    $0xff,%r14d
    e259:	4c 0f 42 f1          	cmovb  %rcx,%r14
    e25d:	4c 01 f8             	add    %r15,%rax
    e260:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    e265:	48 89 c6             	mov    %rax,%rsi
    e268:	4c 89 f2             	mov    %r14,%rdx
    e26b:	e8 c0 50 ff ff       	call   3330 <memcpy@plt>
    e270:	42 c6 44 34 50 00    	movb   $0x0,0x50(%rsp,%r14,1)
    e276:	44 8b 6d 10          	mov    0x10(%rbp),%r13d
    e27a:	45 85 ed             	test   %r13d,%r13d
    e27d:	7e 3d                	jle    e2bc <tp_value+0xb6c>
    e27f:	49 89 ef             	mov    %rbp,%r15
    e282:	48 8b 5d 18          	mov    0x18(%rbp),%rbx
    e286:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    e28b:	45 31 e4             	xor    %r12d,%r12d
    e28e:	4c 8d 74 24 50       	lea    0x50(%rsp),%r14
    e293:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    e29a:	84 00 00 00 00 00 
    e2a0:	4a 8b 3c e3          	mov    (%rbx,%r12,8),%rdi
    e2a4:	4c 89 f6             	mov    %r14,%rsi
    e2a7:	e8 24 50 ff ff       	call   32d0 <strcmp@plt>
    e2ac:	85 c0                	test   %eax,%eax
    e2ae:	41 0f 44 ec          	cmove  %r12d,%ebp
    e2b2:	49 ff c4             	inc    %r12
    e2b5:	4d 39 e5             	cmp    %r12,%r13
    e2b8:	75 e6                	jne    e2a0 <tp_value+0xb50>
    e2ba:	eb 08                	jmp    e2c4 <tp_value+0xb74>
    e2bc:	49 89 ef             	mov    %rbp,%r15
    e2bf:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    e2c4:	83 7c 24 08 00       	cmpl   $0x0,0x8(%rsp)
    e2c9:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    e2ce:	74 60                	je     e330 <tp_value+0xbe0>
    e2d0:	85 ed                	test   %ebp,%ebp
    e2d2:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
    e2d7:	79 5c                	jns    e335 <tp_value+0xbe5>
    e2d9:	49 8b 7f 08          	mov    0x8(%r15),%rdi
    e2dd:	45 31 f6             	xor    %r14d,%r14d
    e2e0:	48 85 ff             	test   %rdi,%rdi
    e2e3:	0f 84 2e fa ff ff    	je     dd17 <tp_value+0x5c7>
    e2e9:	48 8d 35 c6 83 00 00 	lea    0x83c6(%rip),%rsi        # 166b6 <exec_in_fp0+0xe46>
    e2f0:	e8 db 4f ff ff       	call   32d0 <strcmp@plt>
    e2f5:	85 c0                	test   %eax,%eax
    e2f7:	0f 85 1a fa ff ff    	jne    dd17 <tp_value+0x5c7>
    e2fd:	4c 89 fe             	mov    %r15,%rsi
    e300:	8b 44 24 50          	mov    0x50(%rsp),%eax
    e304:	89 c2                	mov    %eax,%edx
    e306:	81 f2 74 72 75 65    	xor    $0x65757274,%edx
    e30c:	0f b6 7c 24 54       	movzbl 0x54(%rsp),%edi
    e311:	09 d7                	or     %edx,%edi
    e313:	ba 01 00 00 00       	mov    $0x1,%edx
    e318:	0f 44 ea             	cmove  %edx,%ebp
    e31b:	35 66 61 6c 73       	xor    $0x736c6166,%eax
    e320:	0f b7 54 24 54       	movzwl 0x54(%rsp),%edx
    e325:	83 f2 65             	xor    $0x65,%edx
    e328:	09 c2                	or     %eax,%edx
    e32a:	75 0c                	jne    e338 <tp_value+0xbe8>
    e32c:	31 ed                	xor    %ebp,%ebp
    e32e:	eb 10                	jmp    e340 <tp_value+0xbf0>
    e330:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
    e335:	4c 89 fe             	mov    %r15,%rsi
    e338:	85 ed                	test   %ebp,%ebp
    e33a:	0f 88 25 0b 00 00    	js     ee65 <tp_value+0x1715>
    e340:	48 8b 46 28          	mov    0x28(%rsi),%rax
    e344:	41 89 ee             	mov    %ebp,%r14d
    e347:	4e 63 3c b0          	movslq (%rax,%r14,4),%r15
    e34b:	45 89 fa             	mov    %r15d,%r10d
    e34e:	4a 8d 3c fd 08 00 00 	lea    0x8(,%r15,8),%rdi
    e355:	00 
    e356:	48 ff 05 4b db 00 00 	incq   0xdb4b(%rip)        # 1bea8 <measured_calls>
    e35d:	48 01 3d 4c db 00 00 	add    %rdi,0xdb4c(%rip)        # 1beb0 <measured_bytes>
    e364:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    e36b:	4c 89 54 24 20       	mov    %r10,0x20(%rsp)
    e370:	0f 87 1a 03 00 00    	ja     e690 <tp_value+0xf40>
    e376:	48 8d 57 0f          	lea    0xf(%rdi),%rdx
    e37a:	48 c1 ea 04          	shr    $0x4,%rdx
    e37e:	48 8d 05 03 bf 00 00 	lea    0xbf03(%rip),%rax        # 1a288 <fwp_gc>
    e385:	44 0f b6 84 02 e8 0b 	movzbl 0xbe8(%rdx,%rax,1),%r8d
    e38c:	00 00 
    e38e:	42 8b 94 80 48 0b 00 	mov    0xb48(%rax,%r8,4),%edx
    e395:	00 
    e396:	48 29 15 eb be 00 00 	sub    %rdx,0xbeeb(%rip)        # 1a288 <fwp_gc>
    e39d:	0f 88 ed 02 00 00    	js     e690 <tp_value+0xf40>
    e3a3:	4f 8d 04 40          	lea    (%r8,%r8,2),%r8
    e3a7:	4e 8d 0c c0          	lea    (%rax,%r8,8),%r9
    e3ab:	49 81 c1 88 07 00 00 	add    $0x788,%r9
    e3b2:	4d 8b 19             	mov    (%r9),%r11
    e3b5:	4d 85 db             	test   %r11,%r11
    e3b8:	0f 84 b6 02 00 00    	je     e674 <tp_value+0xf24>
    e3be:	48 89 f3             	mov    %rsi,%rbx
    e3c1:	49 8b 03             	mov    (%r11),%rax
    e3c4:	48 f7 d0             	not    %rax
    e3c7:	49 89 01             	mov    %rax,(%r9)
    e3ca:	e9 0b 05 00 00       	jmp    e8da <tp_value+0x118a>
    e3cf:	48 8d 74 24 50       	lea    0x50(%rsp),%rsi
    e3d4:	ba 80 00 00 00       	mov    $0x80,%edx
    e3d9:	4c 89 f7             	mov    %r14,%rdi
    e3dc:	e8 0f 19 00 00       	call   fcf0 <tp_token>
    e3e1:	49 89 c4             	mov    %rax,%r12
    e3e4:	4c 8d 34 04          	lea    (%rsp,%rax,1),%r14
    e3e8:	49 83 c6 50          	add    $0x50,%r14
    e3ec:	31 db                	xor    %ebx,%ebx
    e3ee:	eb 0d                	jmp    e3fd <tp_value+0xcad>
    e3f0:	48 ff c3             	inc    %rbx
    e3f3:	48 83 fb 06          	cmp    $0x6,%rbx
    e3f7:	0f 84 68 0a 00 00    	je     ee65 <tp_value+0x1715>
    e3fd:	49 89 df             	mov    %rbx,%r15
    e400:	49 c1 e7 04          	shl    $0x4,%r15
    e404:	48 8d 05 95 b8 00 00 	lea    0xb895(%rip),%rax        # 19ca0 <tp_value.units>
    e40b:	49 8b 2c 07          	mov    (%r15,%rax,1),%rbp
    e40f:	48 89 ef             	mov    %rbp,%rdi
    e412:	e8 59 4d ff ff       	call   3170 <strlen@plt>
    e417:	4d 89 e5             	mov    %r12,%r13
    e41a:	49 29 c5             	sub    %rax,%r13
    e41d:	76 d1                	jbe    e3f0 <tp_value+0xca0>
    e41f:	4c 89 f7             	mov    %r14,%rdi
    e422:	48 29 c7             	sub    %rax,%rdi
    e425:	48 89 ee             	mov    %rbp,%rsi
    e428:	e8 a3 4e ff ff       	call   32d0 <strcmp@plt>
    e42d:	85 c0                	test   %eax,%eax
    e42f:	75 bf                	jne    e3f0 <tp_value+0xca0>
    e431:	48 8d bc 24 50 01 00 	lea    0x150(%rsp),%rdi
    e438:	00 
    e439:	48 8d 74 24 50       	lea    0x50(%rsp),%rsi
    e43e:	4c 89 ea             	mov    %r13,%rdx
    e441:	e8 ea 4e ff ff       	call   3330 <memcpy@plt>
    e446:	42 c6 84 2c 50 01 00 	movb   $0x0,0x150(%rsp,%r13,1)
    e44d:	00 00 
    e44f:	0f b6 b4 24 50 01 00 	movzbl 0x150(%rsp),%esi
    e456:	00 
    e457:	8d 46 d5             	lea    -0x2b(%rsi),%eax
    e45a:	31 c9                	xor    %ecx,%ecx
    e45c:	a8 fd                	test   $0xfd,%al
    e45e:	0f 94 c1             	sete   %cl
    e461:	49 39 cd             	cmp    %rcx,%r13
    e464:	74 8a                	je     e3f0 <tp_value+0xca0>
    e466:	76 1c                	jbe    e484 <tp_value+0xd34>
    e468:	0f b6 94 0c 50 01 00 	movzbl 0x150(%rsp,%rcx,1),%edx
    e46f:	00 
    e470:	80 c2 c6             	add    $0xc6,%dl
    e473:	80 fa f6             	cmp    $0xf6,%dl
    e476:	0f 82 74 ff ff ff    	jb     e3f0 <tp_value+0xca0>
    e47c:	48 ff c1             	inc    %rcx
    e47f:	49 39 cd             	cmp    %rcx,%r13
    e482:	75 e4                	jne    e468 <tp_value+0xd18>
    e484:	31 c9                	xor    %ecx,%ecx
    e486:	a8 fd                	test   $0xfd,%al
    e488:	0f 94 c1             	sete   %cl
    e48b:	44 0f b6 94 0c 50 01 	movzbl 0x150(%rsp,%rcx,1),%r10d
    e492:	00 00 
    e494:	45 31 f6             	xor    %r14d,%r14d
    e497:	45 84 d2             	test   %r10b,%r10b
    e49a:	0f 84 21 06 00 00    	je     eac1 <tp_value+0x1371>
    e4a0:	48 8d 84 24 50 01 00 	lea    0x150(%rsp),%rax
    e4a7:	00 
    e4a8:	48 01 c1             	add    %rax,%rcx
    e4ab:	48 ff c1             	inc    %rcx
    e4ae:	31 c0                	xor    %eax,%eax
    e4b0:	bf 0a 00 00 00       	mov    $0xa,%edi
    e4b5:	49 b9 00 00 00 00 00 	movabs $0x8000000000000000,%r9
    e4bc:	00 00 80 
    e4bf:	45 31 c0             	xor    %r8d,%r8d
    e4c2:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    e4c7:	48 f7 e7             	mul    %rdi
    e4ca:	4f 8d 04 80          	lea    (%r8,%r8,4),%r8
    e4ce:	4a 8d 14 42          	lea    (%rdx,%r8,2),%rdx
    e4d2:	45 0f be c2          	movsbl %r10b,%r8d
    e4d6:	41 83 c0 d0          	add    $0xffffffd0,%r8d
    e4da:	4d 63 d0             	movslq %r8d,%r10
    e4dd:	4d 89 d0             	mov    %r10,%r8
    e4e0:	49 c1 f8 3f          	sar    $0x3f,%r8
    e4e4:	4c 01 d0             	add    %r10,%rax
    e4e7:	49 11 d0             	adc    %rdx,%r8
    e4ea:	49 39 c1             	cmp    %rax,%r9
    e4ed:	ba 00 00 00 00       	mov    $0x0,%edx
    e4f2:	4c 19 c2             	sbb    %r8,%rdx
    e4f5:	0f 8c 6a 09 00 00    	jl     ee65 <tp_value+0x1715>
    e4fb:	44 0f b6 11          	movzbl (%rcx),%r10d
    e4ff:	48 ff c1             	inc    %rcx
    e502:	45 84 d2             	test   %r10b,%r10b
    e505:	75 c0                	jne    e4c7 <tp_value+0xd77>
    e507:	e9 bf 05 00 00       	jmp    eacb <tp_value+0x137b>
    e50c:	49 83 c7 05          	add    $0x5,%r15
    e510:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    e514:	48 8d 35 36 74 00 00 	lea    0x7436(%rip),%rsi        # 15951 <exec_in_fp0+0xe1>
    e51b:	48 8d 15 e4 83 00 00 	lea    0x83e4(%rip),%rdx        # 16906 <exec_in_fp0+0x1096>
    e522:	48 8d 0d 87 17 00 00 	lea    0x1787(%rip),%rcx        # fcb0 <tp_byte_item>
    e529:	4c 8d 44 24 50       	lea    0x50(%rsp),%r8
    e52e:	e8 7d 15 00 00       	call   fab0 <tp_list_of>
    e533:	85 c0                	test   %eax,%eax
    e535:	74 77                	je     e5ae <tp_value+0xe5e>
    e537:	66 0f ef c0          	pxor   %xmm0,%xmm0
    e53b:	66 0f 7f 84 24 50 01 	movdqa %xmm0,0x150(%rsp)
    e542:	00 00 
    e544:	48 c7 84 24 60 01 00 	movq   $0x0,0x160(%rsp)
    e54b:	00 00 00 00 00 
    e550:	48 83 7c 24 68 00    	cmpq   $0x0,0x68(%rsp)
    e556:	74 36                	je     e58e <tp_value+0xe3e>
    e558:	31 db                	xor    %ebx,%ebx
    e55a:	4c 8d b4 24 50 01 00 	lea    0x150(%rsp),%r14
    e561:	00 
    e562:	4c 8d 7c 24 38       	lea    0x38(%rsp),%r15
    e567:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
    e56c:	0f b6 04 d8          	movzbl (%rax,%rbx,8),%eax
    e570:	88 44 24 38          	mov    %al,0x38(%rsp)
    e574:	ba 01 00 00 00       	mov    $0x1,%edx
    e579:	4c 89 f7             	mov    %r14,%rdi
    e57c:	4c 89 fe             	mov    %r15,%rsi
    e57f:	e8 8c ec ff ff       	call   d210 <buf_put>
    e584:	48 ff c3             	inc    %rbx
    e587:	48 3b 5c 24 68       	cmp    0x68(%rsp),%rbx
    e58c:	72 d9                	jb     e567 <tp_value+0xe17>
    e58e:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
    e593:	e8 88 c5 ff ff       	call   ab20 <fwp_mem_free>
    e598:	48 8d bc 24 50 01 00 	lea    0x150(%rsp),%rdi
    e59f:	00 
    e5a0:	e8 5b ed ff ff       	call   d300 <buf_to_str>
    e5a5:	49 89 04 24          	mov    %rax,(%r12)
    e5a9:	e9 63 f7 ff ff       	jmp    dd11 <tp_value+0x5c1>
    e5ae:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
    e5b3:	e8 68 c5 ff ff       	call   ab20 <fwp_mem_free>
    e5b8:	e9 5a f7 ff ff       	jmp    dd17 <tp_value+0x5c7>
    e5bd:	f2 0f 10 05 03 6c 00 	movsd  0x6c03(%rip),%xmm0        # 151c8 <_IO_stdin_used+0x1c8>
    e5c4:	00 
    e5c5:	83 39 0a             	cmpl   $0xa,(%rcx)
    e5c8:	f2 0f 5a c8          	cvtsd2ss %xmm0,%xmm1
    e5cc:	66 0f 7e c9          	movd   %xmm1,%ecx
    e5d0:	66 48 0f 7e c0       	movq   %xmm0,%rax
    e5d5:	48 0f 44 c1          	cmove  %rcx,%rax
    e5d9:	49 89 04 24          	mov    %rax,(%r12)
    e5dd:	e9 2f f7 ff ff       	jmp    dd11 <tp_value+0x5c1>
    e5e2:	4d 8b 8c ce 90 07 00 	mov    0x790(%r14,%rcx,8),%r9
    e5e9:	00 
    e5ea:	4d 8b 84 ce 98 07 00 	mov    0x798(%r14,%rcx,8),%r8
    e5f1:	00 
    e5f2:	4d 29 c8             	sub    %r9,%r8
    e5f5:	49 39 d0             	cmp    %rdx,%r8
    e5f8:	0f 83 05 01 00 00    	jae    e703 <tp_value+0xfb3>
    e5fe:	48 89 f5             	mov    %rsi,%rbp
    e601:	48 89 fb             	mov    %rdi,%rbx
    e604:	48 89 c7             	mov    %rax,%rdi
    e607:	be 02 00 00 00       	mov    $0x2,%esi
    e60c:	e8 af 9c ff ff       	call   82c0 <fwp_gc_alloc_slow>
    e611:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    e616:	4c 8b 25 8b d8 00 00 	mov    0xd88b(%rip),%r12        # 1bea8 <measured_calls>
    e61d:	4c 8b 2d 8c d8 00 00 	mov    0xd88c(%rip),%r13        # 1beb0 <measured_bytes>
    e624:	e9 00 01 00 00       	jmp    e729 <tp_value+0xfd9>
    e629:	48 85 c0             	test   %rax,%rax
    e62c:	40 0f 95 c6          	setne  %sil
    e630:	80 c2 d5             	add    $0xd5,%dl
    e633:	f6 c2 fd             	test   $0xfd,%dl
    e636:	0f 94 c2             	sete   %dl
    e639:	40 20 f2             	and    %sil,%dl
    e63c:	0f b6 f2             	movzbl %dl,%esi
    e63f:	41 b0 01             	mov    $0x1,%r8b
    e642:	48 89 f7             	mov    %rsi,%rdi
    e645:	48 39 f0             	cmp    %rsi,%rax
    e648:	0f 86 70 02 00 00    	jbe    e8be <tp_value+0x116e>
    e64e:	0f b6 54 3c 50       	movzbl 0x50(%rsp,%rdi,1),%edx
    e653:	44 8d 4a d0          	lea    -0x30(%rdx),%r9d
    e657:	41 80 f9 09          	cmp    $0x9,%r9b
    e65b:	0f 87 0f 05 00 00    	ja     eb70 <tp_value+0x1420>
    e661:	48 ff c7             	inc    %rdi
    e664:	48 39 f8             	cmp    %rdi,%rax
    e667:	75 e5                	jne    e64e <tp_value+0xefe>
    e669:	48 89 c7             	mov    %rax,%rdi
    e66c:	48 89 c2             	mov    %rax,%rdx
    e66f:	e9 fc 07 00 00       	jmp    ee70 <tp_value+0x1720>
    e674:	4e 8b 9c c0 90 07 00 	mov    0x790(%rax,%r8,8),%r11
    e67b:	00 
    e67c:	4e 8b 8c c0 98 07 00 	mov    0x798(%rax,%r8,8),%r9
    e683:	00 
    e684:	4d 29 d9             	sub    %r11,%r9
    e687:	49 39 d1             	cmp    %rdx,%r9
    e68a:	0f 83 36 02 00 00    	jae    e8c6 <tp_value+0x1176>
    e690:	48 89 f3             	mov    %rsi,%rbx
    e693:	be 02 00 00 00       	mov    $0x2,%esi
    e698:	e8 23 9c ff ff       	call   82c0 <fwp_gc_alloc_slow>
    e69d:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    e6a2:	e9 42 02 00 00       	jmp    e8e9 <tp_value+0x1199>
    e6a7:	48 8d 35 36 80 00 00 	lea    0x8036(%rip),%rsi        # 166e4 <exec_in_fp0+0xe74>
    e6ae:	49 89 ff             	mov    %rdi,%r15
    e6b1:	e8 5a 13 00 00       	call   fa10 <tp_eat>
    e6b6:	85 c0                	test   %eax,%eax
    e6b8:	0f 84 59 f6 ff ff    	je     dd17 <tp_value+0x5c7>
    e6be:	48 8d 35 e0 80 00 00 	lea    0x80e0(%rip),%rsi        # 167a5 <exec_in_fp0+0xf35>
    e6c5:	4c 89 ff             	mov    %r15,%rdi
    e6c8:	e8 43 13 00 00       	call   fa10 <tp_eat>
    e6cd:	85 c0                	test   %eax,%eax
    e6cf:	0f 84 42 f6 ff ff    	je     dd17 <tp_value+0x5c7>
    e6d5:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    e6da:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    e6e1:	e9 2b f6 ff ff       	jmp    dd11 <tp_value+0x5c1>
    e6e6:	31 ff                	xor    %edi,%edi
    e6e8:	4c 89 fe             	mov    %r15,%rsi
    e6eb:	e8 40 71 ff ff       	call   5830 <fwp_array_new_packed>
    e6f0:	49 89 c6             	mov    %rax,%r14
    e6f3:	e9 46 05 00 00       	jmp    ec3e <tp_value+0x14ee>
    e6f8:	31 c9                	xor    %ecx,%ecx
    e6fa:	49 89 0c 24          	mov    %rcx,(%r12)
    e6fe:	e9 0e f6 ff ff       	jmp    dd11 <tp_value+0x5c1>
    e703:	48 89 f5             	mov    %rsi,%rbp
    e706:	48 89 fb             	mov    %rdi,%rbx
    e709:	49 8d 04 ce          	lea    (%r14,%rcx,8),%rax
    e70d:	48 05 90 07 00 00    	add    $0x790,%rax
    e713:	49 8d 0c 11          	lea    (%r9,%rdx,1),%rcx
    e717:	48 89 08             	mov    %rcx,(%rax)
    e71a:	4c 89 4c 24 20       	mov    %r9,0x20(%rsp)
    e71f:	4c 89 cf             	mov    %r9,%rdi
    e722:	31 f6                	xor    %esi,%esi
    e724:	e8 e7 4a ff ff       	call   3210 <memset@plt>
    e729:	49 63 07             	movslq (%r15),%rax
    e72c:	48 8d 50 01          	lea    0x1(%rax),%rdx
    e730:	49 ff c4             	inc    %r12
    e733:	4c 89 25 6e d7 00 00 	mov    %r12,0xd76e(%rip)        # 1bea8 <measured_calls>
    e73a:	4a 8d 0c 28          	lea    (%rax,%r13,1),%rcx
    e73e:	48 ff c1             	inc    %rcx
    e741:	48 89 0d 68 d7 00 00 	mov    %rcx,0xd768(%rip)        # 1beb0 <measured_bytes>
    e748:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    e74f:	77 5d                	ja     e7ae <tp_value+0x105e>
    e751:	48 83 c0 10          	add    $0x10,%rax
    e755:	48 c1 e8 04          	shr    $0x4,%rax
    e759:	42 0f b6 8c 30 e8 0b 	movzbl 0xbe8(%rax,%r14,1),%ecx
    e760:	00 00 
    e762:	41 8b 84 8e 48 0b 00 	mov    0xb48(%r14,%rcx,4),%eax
    e769:	00 
    e76a:	48 29 05 17 bb 00 00 	sub    %rax,0xbb17(%rip)        # 1a288 <fwp_gc>
    e771:	78 3b                	js     e7ae <tp_value+0x105e>
    e773:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    e777:	49 8d 34 ce          	lea    (%r14,%rcx,8),%rsi
    e77b:	48 81 c6 c8 03 00 00 	add    $0x3c8,%rsi
    e782:	4c 8b 26             	mov    (%rsi),%r12
    e785:	4d 85 e4             	test   %r12,%r12
    e788:	74 0c                	je     e796 <tp_value+0x1046>
    e78a:	49 8b 04 24          	mov    (%r12),%rax
    e78e:	48 f7 d0             	not    %rax
    e791:	48 89 06             	mov    %rax,(%rsi)
    e794:	eb 3b                	jmp    e7d1 <tp_value+0x1081>
    e796:	4d 8b a4 ce d0 03 00 	mov    0x3d0(%r14,%rcx,8),%r12
    e79d:	00 
    e79e:	49 8b b4 ce d8 03 00 	mov    0x3d8(%r14,%rcx,8),%rsi
    e7a5:	00 
    e7a6:	4c 29 e6             	sub    %r12,%rsi
    e7a9:	48 39 c6             	cmp    %rax,%rsi
    e7ac:	73 12                	jae    e7c0 <tp_value+0x1070>
    e7ae:	48 89 d7             	mov    %rdx,%rdi
    e7b1:	be 01 00 00 00       	mov    $0x1,%esi
    e7b6:	e8 05 9b ff ff       	call   82c0 <fwp_gc_alloc_slow>
    e7bb:	49 89 c4             	mov    %rax,%r12
    e7be:	eb 1b                	jmp    e7db <tp_value+0x108b>
    e7c0:	49 8d 0c ce          	lea    (%r14,%rcx,8),%rcx
    e7c4:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
    e7cb:	4c 01 e0             	add    %r12,%rax
    e7ce:	48 89 01             	mov    %rax,(%rcx)
    e7d1:	4c 89 e7             	mov    %r12,%rdi
    e7d4:	31 f6                	xor    %esi,%esi
    e7d6:	e8 35 4a ff ff       	call   3210 <memset@plt>
    e7db:	49 63 17             	movslq (%r15),%rdx
    e7de:	48 ff c2             	inc    %rdx
    e7e1:	45 31 f6             	xor    %r14d,%r14d
    e7e4:	4c 89 e7             	mov    %r12,%rdi
    e7e7:	31 f6                	xor    %esi,%esi
    e7e9:	e8 22 4a ff ff       	call   3210 <memset@plt>
    e7ee:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    e7f2:	48 8b 43 10          	mov    0x10(%rbx),%rax
    e7f6:	48 39 c8             	cmp    %rcx,%rax
    e7f9:	73 2e                	jae    e829 <tp_value+0x10d9>
    e7fb:	48 8b 13             	mov    (%rbx),%rdx
    e7fe:	48 be 00 26 00 00 01 	movabs $0x100002600,%rsi
    e805:	00 00 00 
    e808:	0f b6 3c 02          	movzbl (%rdx,%rax,1),%edi
    e80c:	48 83 ff 20          	cmp    $0x20,%rdi
    e810:	77 17                	ja     e829 <tp_value+0x10d9>
    e812:	48 0f a3 fe          	bt     %rdi,%rsi
    e816:	73 11                	jae    e829 <tp_value+0x10d9>
    e818:	48 ff c0             	inc    %rax
    e81b:	48 89 43 10          	mov    %rax,0x10(%rbx)
    e81f:	48 39 c1             	cmp    %rax,%rcx
    e822:	75 e4                	jne    e808 <tp_value+0x10b8>
    e824:	e9 ee f4 ff ff       	jmp    dd17 <tp_value+0x5c7>
    e829:	48 39 c1             	cmp    %rax,%rcx
    e82c:	0f 84 e5 f4 ff ff    	je     dd17 <tp_value+0x5c7>
    e832:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
    e837:	48 8b 0b             	mov    (%rbx),%rcx
    e83a:	80 3c 01 7b          	cmpb   $0x7b,(%rcx,%rax,1)
    e83e:	0f 85 d3 f4 ff ff    	jne    dd17 <tp_value+0x5c7>
    e844:	48 ff c0             	inc    %rax
    e847:	48 89 43 10          	mov    %rax,0x10(%rbx)
    e84b:	48 8d 35 7b 71 00 00 	lea    0x717b(%rip),%rsi        # 159cd <exec_in_fp0+0x15d>
    e852:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
    e857:	48 89 df             	mov    %rbx,%rdi
    e85a:	e8 b1 11 00 00       	call   fa10 <tp_eat>
    e85f:	85 c0                	test   %eax,%eax
    e861:	0f 84 e0 03 00 00    	je     ec47 <tp_value+0x14f7>
    e867:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    e86c:	8b 38                	mov    (%rax),%edi
    e86e:	85 ff                	test   %edi,%edi
    e870:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
    e875:	48 8b 74 24 20       	mov    0x20(%rsp),%rsi
    e87a:	7e 18                	jle    e894 <tp_value+0x1144>
    e87c:	45 31 f6             	xor    %r14d,%r14d
    e87f:	31 c0                	xor    %eax,%eax
    e881:	41 80 3c 04 00       	cmpb   $0x0,(%r12,%rax,1)
    e886:	0f 84 8b f4 ff ff    	je     dd17 <tp_value+0x5c7>
    e88c:	48 ff c0             	inc    %rax
    e88f:	48 39 c7             	cmp    %rax,%rdi
    e892:	75 ed                	jne    e881 <tp_value+0x1131>
    e894:	e8 17 19 00 00       	call   101b0 <fwp_record>
    e899:	48 89 03             	mov    %rax,(%rbx)
    e89c:	e9 70 f4 ff ff       	jmp    dd11 <tp_value+0x5c1>
    e8a1:	48 8d 05 68 d6 01 00 	lea    0x1d668(%rip),%rax        # 2bf10 <fwp_empty_map>
    e8a8:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
    e8ad:	48 89 c3             	mov    %rax,%rbx
    e8b0:	e8 6b c2 ff ff       	call   ab20 <fwp_mem_free>
    e8b5:	49 89 1c 24          	mov    %rbx,(%r12)
    e8b9:	e9 53 f4 ff ff       	jmp    dd11 <tp_value+0x5c1>
    e8be:	48 89 f2             	mov    %rsi,%rdx
    e8c1:	e9 aa 05 00 00       	jmp    ee70 <tp_value+0x1720>
    e8c6:	48 89 f3             	mov    %rsi,%rbx
    e8c9:	4a 8d 04 c0          	lea    (%rax,%r8,8),%rax
    e8cd:	48 05 90 07 00 00    	add    $0x790,%rax
    e8d3:	49 8d 0c 13          	lea    (%r11,%rdx,1),%rcx
    e8d7:	48 89 08             	mov    %rcx,(%rax)
    e8da:	4c 89 5c 24 08       	mov    %r11,0x8(%rsp)
    e8df:	4c 89 df             	mov    %r11,%rdi
    e8e2:	31 f6                	xor    %esi,%esi
    e8e4:	e8 27 49 ff ff       	call   3210 <memset@plt>
    e8e9:	4c 89 7c 24 28       	mov    %r15,0x28(%rsp)
    e8ee:	45 85 ff             	test   %r15d,%r15d
    e8f1:	0f 8e 60 01 00 00    	jle    ea57 <tp_value+0x1307>
    e8f7:	48 89 d8             	mov    %rbx,%rax
    e8fa:	31 db                	xor    %ebx,%ebx
    e8fc:	49 bf 00 26 00 00 01 	movabs $0x100002600,%r15
    e903:	00 00 00 
    e906:	4c 89 74 24 30       	mov    %r14,0x30(%rsp)
    e90b:	48 8b 48 30          	mov    0x30(%rax),%rcx
    e90f:	4a 8b 0c f1          	mov    (%rcx,%r14,8),%rcx
    e913:	48 8b 34 d9          	mov    (%rcx,%rbx,8),%rsi
    e917:	49 8b 7d 08          	mov    0x8(%r13),%rdi
    e91b:	49 8b 55 10          	mov    0x10(%r13),%rdx
    e91f:	48 39 fa             	cmp    %rdi,%rdx
    e922:	73 2c                	jae    e950 <tp_value+0x1200>
    e924:	49 8b 4d 00          	mov    0x0(%r13),%rcx
    e928:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    e92f:	00 
    e930:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    e935:	49 83 f8 20          	cmp    $0x20,%r8
    e939:	77 15                	ja     e950 <tp_value+0x1200>
    e93b:	4d 0f a3 c7          	bt     %r8,%r15
    e93f:	73 0f                	jae    e950 <tp_value+0x1200>
    e941:	48 ff c2             	inc    %rdx
    e944:	49 89 55 10          	mov    %rdx,0x10(%r13)
    e948:	48 39 d7             	cmp    %rdx,%rdi
    e94b:	75 e3                	jne    e930 <tp_value+0x11e0>
    e94d:	48 89 fa             	mov    %rdi,%rdx
    e950:	83 3e 10             	cmpl   $0x10,(%rsi)
    e953:	75 0b                	jne    e960 <tp_value+0x1210>
    e955:	48 83 7e 08 00       	cmpq   $0x0,0x8(%rsi)
    e95a:	0f 84 b4 00 00 00    	je     ea14 <tp_value+0x12c4>
    e960:	45 31 c0             	xor    %r8d,%r8d
    e963:	49 89 c4             	mov    %rax,%r12
    e966:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    e96b:	48 8d 0c d8          	lea    (%rax,%rbx,8),%rcx
    e96f:	48 39 fa             	cmp    %rdi,%rdx
    e972:	73 10                	jae    e984 <tp_value+0x1234>
    e974:	49 8b 45 00          	mov    0x0(%r13),%rax
    e978:	80 3c 10 28          	cmpb   $0x28,(%rax,%rdx,1)
    e97c:	0f 95 c0             	setne  %al
    e97f:	44 08 c0             	or     %r8b,%al
    e982:	74 35                	je     e9b9 <tp_value+0x1269>
    e984:	45 31 f6             	xor    %r14d,%r14d
    e987:	4c 89 ef             	mov    %r13,%rdi
    e98a:	31 d2                	xor    %edx,%edx
    e98c:	e8 bf ed ff ff       	call   d750 <tp_value>
    e991:	85 c0                	test   %eax,%eax
    e993:	4c 89 e0             	mov    %r12,%rax
    e996:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    e99b:	0f 84 76 f3 ff ff    	je     dd17 <tp_value+0x5c7>
    e9a1:	48 ff c3             	inc    %rbx
    e9a4:	48 3b 5c 24 20       	cmp    0x20(%rsp),%rbx
    e9a9:	4c 8b 74 24 30       	mov    0x30(%rsp),%r14
    e9ae:	0f 85 57 ff ff ff    	jne    e90b <tp_value+0x11bb>
    e9b4:	e9 9e 00 00 00       	jmp    ea57 <tp_value+0x1307>
    e9b9:	48 ff c2             	inc    %rdx
    e9bc:	49 89 55 10          	mov    %rdx,0x10(%r13)
    e9c0:	45 31 f6             	xor    %r14d,%r14d
    e9c3:	4c 89 ef             	mov    %r13,%rdi
    e9c6:	31 d2                	xor    %edx,%edx
    e9c8:	e8 83 ed ff ff       	call   d750 <tp_value>
    e9cd:	85 c0                	test   %eax,%eax
    e9cf:	0f 84 42 f3 ff ff    	je     dd17 <tp_value+0x5c7>
    e9d5:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
    e9da:	49 8b 55 08          	mov    0x8(%r13),%rdx
    e9de:	49 8b 4d 10          	mov    0x10(%r13),%rcx
    e9e2:	48 39 d1             	cmp    %rdx,%rcx
    e9e5:	4c 89 e0             	mov    %r12,%rax
    e9e8:	73 3d                	jae    ea27 <tp_value+0x12d7>
    e9ea:	49 8b 75 00          	mov    0x0(%r13),%rsi
    e9ee:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    e9f3:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
    e9f7:	48 83 ff 20          	cmp    $0x20,%rdi
    e9fb:	77 2f                	ja     ea2c <tp_value+0x12dc>
    e9fd:	49 0f a3 ff          	bt     %rdi,%r15
    ea01:	73 29                	jae    ea2c <tp_value+0x12dc>
    ea03:	48 ff c1             	inc    %rcx
    ea06:	49 89 4d 10          	mov    %rcx,0x10(%r13)
    ea0a:	48 39 ca             	cmp    %rcx,%rdx
    ea0d:	75 e4                	jne    e9f3 <tp_value+0x12a3>
    ea0f:	e9 03 f3 ff ff       	jmp    dd17 <tp_value+0x5c7>
    ea14:	83 7e 10 00          	cmpl   $0x0,0x10(%rsi)
    ea18:	74 35                	je     ea4f <tp_value+0x12ff>
    ea1a:	83 7e 48 00          	cmpl   $0x0,0x48(%rsi)
    ea1e:	41 0f 95 c0          	setne  %r8b
    ea22:	e9 3c ff ff ff       	jmp    e963 <tp_value+0x1213>
    ea27:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    ea2c:	48 39 ca             	cmp    %rcx,%rdx
    ea2f:	0f 84 e2 f2 ff ff    	je     dd17 <tp_value+0x5c7>
    ea35:	49 8b 55 00          	mov    0x0(%r13),%rdx
    ea39:	80 3c 0a 29          	cmpb   $0x29,(%rdx,%rcx,1)
    ea3d:	0f 85 d4 f2 ff ff    	jne    dd17 <tp_value+0x5c7>
    ea43:	48 ff c1             	inc    %rcx
    ea46:	49 89 4d 10          	mov    %rcx,0x10(%r13)
    ea4a:	e9 52 ff ff ff       	jmp    e9a1 <tp_value+0x1251>
    ea4f:	41 b0 01             	mov    $0x1,%r8b
    ea52:	e9 0c ff ff ff       	jmp    e963 <tp_value+0x1213>
    ea57:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
    ea5c:	45 85 ff             	test   %r15d,%r15d
    ea5f:	0f 84 d9 01 00 00    	je     ec3e <tp_value+0x14ee>
    ea65:	48 8b 5c 24 20       	mov    0x20(%rsp),%rbx
    ea6a:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    ea71:	00 
    ea72:	e8 69 bd ff ff       	call   a7e0 <fwp_alloc_init>
    ea77:	49 89 c6             	mov    %rax,%r14
    ea7a:	89 28                	mov    %ebp,(%rax)
    ea7c:	44 89 78 04          	mov    %r15d,0x4(%rax)
    ea80:	41 83 ff 08          	cmp    $0x8,%r15d
    ea84:	73 1b                	jae    eaa1 <tp_value+0x1351>
    ea86:	31 c0                	xor    %eax,%eax
    ea88:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    ea8d:	e9 53 01 00 00       	jmp    ebe5 <tp_value+0x1495>
    ea92:	4d 01 fd             	add    %r15,%r13
    ea95:	4c 89 f7             	mov    %r14,%rdi
    ea98:	4d 89 6e 10          	mov    %r13,0x10(%r14)
    ea9c:	e9 9c f4 ff ff       	jmp    df3d <tp_value+0x7ed>
    eaa1:	4c 89 f0             	mov    %r14,%rax
    eaa4:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    eaa9:	48 29 f8             	sub    %rdi,%rax
    eaac:	48 83 c0 08          	add    $0x8,%rax
    eab0:	48 83 f8 20          	cmp    $0x20,%rax
    eab4:	0f 83 f3 00 00 00    	jae    ebad <tp_value+0x145d>
    eaba:	31 c0                	xor    %eax,%eax
    eabc:	e9 24 01 00 00       	jmp    ebe5 <tp_value+0x1495>
    eac1:	31 c0                	xor    %eax,%eax
    eac3:	45 31 c0             	xor    %r8d,%r8d
    eac6:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    eacb:	48 89 c1             	mov    %rax,%rcx
    eace:	48 f7 d9             	neg    %rcx
    ead1:	bf 00 00 00 00       	mov    $0x0,%edi
    ead6:	4c 19 c7             	sbb    %r8,%rdi
    ead9:	40 80 fe 2d          	cmp    $0x2d,%sil
    eadd:	49 0f 45 f8          	cmovne %r8,%rdi
    eae1:	48 0f 45 c8          	cmovne %rax,%rcx
    eae5:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    eaec:	ff ff 7f 
    eaef:	48 39 c8             	cmp    %rcx,%rax
    eaf2:	b8 00 00 00 00       	mov    $0x0,%eax
    eaf7:	48 19 f8             	sbb    %rdi,%rax
    eafa:	0f 8c 17 f2 ff ff    	jl     dd17 <tp_value+0x5c7>
    eb00:	48 8d 05 99 b1 00 00 	lea    0xb199(%rip),%rax        # 19ca0 <tp_value.units>
    eb07:	49 8b 74 07 08       	mov    0x8(%r15,%rax,1),%rsi
    eb0c:	48 89 c8             	mov    %rcx,%rax
    eb0f:	48 f7 e6             	mul    %rsi
    eb12:	48 0f af fe          	imul   %rsi,%rdi
    eb16:	48 c1 fe 3f          	sar    $0x3f,%rsi
    eb1a:	48 0f af f1          	imul   %rcx,%rsi
    eb1e:	48 01 d7             	add    %rdx,%rdi
    eb21:	48 01 f7             	add    %rsi,%rdi
    eb24:	48 b9 00 00 00 00 00 	movabs $0x8000000000000000,%rcx
    eb2b:	00 00 80 
    eb2e:	48 01 c1             	add    %rax,%rcx
    eb31:	48 83 d7 ff          	adc    $0xffffffffffffffff,%rdi
    eb35:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
    eb39:	0f 85 d8 f1 ff ff    	jne    dd17 <tp_value+0x5c7>
    eb3f:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    eb44:	bf 10 00 00 00       	mov    $0x10,%edi
    eb49:	48 89 c3             	mov    %rax,%rbx
    eb4c:	e8 8f bc ff ff       	call   a7e0 <fwp_alloc_init>
    eb51:	48 b9 00 00 00 00 01 	movabs $0x100000000,%rcx
    eb58:	00 00 00 
    eb5b:	48 89 08             	mov    %rcx,(%rax)
    eb5e:	48 89 58 08          	mov    %rbx,0x8(%rax)
    eb62:	48 8d 4c 24 38       	lea    0x38(%rsp),%rcx
    eb67:	49 89 04 24          	mov    %rax,(%r12)
    eb6b:	e9 a1 f1 ff ff       	jmp    dd11 <tp_value+0x5c1>
    eb70:	80 fa 2e             	cmp    $0x2e,%dl
    eb73:	0f 85 f4 02 00 00    	jne    ee6d <tp_value+0x171d>
    eb79:	48 8d 57 01          	lea    0x1(%rdi),%rdx
    eb7d:	48 39 c2             	cmp    %rax,%rdx
    eb80:	73 1b                	jae    eb9d <tp_value+0x144d>
    eb82:	44 0f b6 44 14 50    	movzbl 0x50(%rsp,%rdx,1),%r8d
    eb88:	41 80 c0 d0          	add    $0xd0,%r8b
    eb8c:	41 80 f8 09          	cmp    $0x9,%r8b
    eb90:	77 0b                	ja     eb9d <tp_value+0x144d>
    eb92:	48 ff c2             	inc    %rdx
    eb95:	48 39 c2             	cmp    %rax,%rdx
    eb98:	72 e8                	jb     eb82 <tp_value+0x1432>
    eb9a:	48 89 c2             	mov    %rax,%rdx
    eb9d:	4c 8d 42 ff          	lea    -0x1(%rdx),%r8
    eba1:	49 39 f8             	cmp    %rdi,%r8
    eba4:	41 0f 94 c0          	sete   %r8b
    eba8:	e9 c3 02 00 00       	jmp    ee70 <tp_value+0x1720>
    ebad:	89 d8                	mov    %ebx,%eax
    ebaf:	83 e0 fc             	and    $0xfffffffc,%eax
    ebb2:	48 8d 0c dd 00 00 00 	lea    0x0(,%rbx,8),%rcx
    ebb9:	00 
    ebba:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    ebbe:	31 d2                	xor    %edx,%edx
    ebc0:	f3 0f 6f 04 17       	movdqu (%rdi,%rdx,1),%xmm0
    ebc5:	0f 10 4c 17 10       	movups 0x10(%rdi,%rdx,1),%xmm1
    ebca:	f3 41 0f 7f 44 16 08 	movdqu %xmm0,0x8(%r14,%rdx,1)
    ebd1:	41 0f 11 4c 16 18    	movups %xmm1,0x18(%r14,%rdx,1)
    ebd7:	48 83 c2 20          	add    $0x20,%rdx
    ebdb:	48 39 d1             	cmp    %rdx,%rcx
    ebde:	75 e0                	jne    ebc0 <tp_value+0x1470>
    ebe0:	48 39 d8             	cmp    %rbx,%rax
    ebe3:	74 59                	je     ec3e <tp_value+0x14ee>
    ebe5:	48 89 da             	mov    %rbx,%rdx
    ebe8:	48 89 c1             	mov    %rax,%rcx
    ebeb:	48 83 e2 03          	and    $0x3,%rdx
    ebef:	74 14                	je     ec05 <tp_value+0x14b5>
    ebf1:	48 89 c1             	mov    %rax,%rcx
    ebf4:	48 8b 34 cf          	mov    (%rdi,%rcx,8),%rsi
    ebf8:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    ebfd:	48 ff c1             	inc    %rcx
    ec00:	48 ff ca             	dec    %rdx
    ec03:	75 ef                	jne    ebf4 <tp_value+0x14a4>
    ec05:	48 29 d8             	sub    %rbx,%rax
    ec08:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    ec0c:	77 30                	ja     ec3e <tp_value+0x14ee>
    ec0e:	48 8b 04 cf          	mov    (%rdi,%rcx,8),%rax
    ec12:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    ec17:	48 8b 44 cf 08       	mov    0x8(%rdi,%rcx,8),%rax
    ec1c:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    ec21:	48 8b 44 cf 10       	mov    0x10(%rdi,%rcx,8),%rax
    ec26:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    ec2b:	48 8b 44 cf 18       	mov    0x18(%rdi,%rcx,8),%rax
    ec30:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    ec35:	48 83 c1 04          	add    $0x4,%rcx
    ec39:	48 39 cb             	cmp    %rcx,%rbx
    ec3c:	75 d0                	jne    ec0e <tp_value+0x14be>
    ec3e:	4d 89 34 24          	mov    %r14,(%r12)
    ec42:	e9 ca f0 ff ff       	jmp    dd11 <tp_value+0x5c1>
    ec47:	4c 89 64 24 40       	mov    %r12,0x40(%rsp)
    ec4c:	49 bf 00 26 00 00 01 	movabs $0x100002600,%r15
    ec53:	00 00 00 
    ec56:	41 b8 ff 00 00 00    	mov    $0xff,%r8d
    ec5c:	4c 8d 4c 24 50       	lea    0x50(%rsp),%r9
    ec61:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    ec66:	48 89 6c 24 48       	mov    %rbp,0x48(%rsp)
    ec6b:	4c 8b 21             	mov    (%rcx),%r12
    ec6e:	4c 8b 69 08          	mov    0x8(%rcx),%r13
    ec72:	48 8b 71 10          	mov    0x10(%rcx),%rsi
    ec76:	4c 39 ee             	cmp    %r13,%rsi
    ec79:	73 2a                	jae    eca5 <tp_value+0x1555>
    ec7b:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
    ec80:	41 0f b6 04 34       	movzbl (%r12,%rsi,1),%eax
    ec85:	48 83 f8 20          	cmp    $0x20,%rax
    ec89:	77 1f                	ja     ecaa <tp_value+0x155a>
    ec8b:	49 0f a3 c7          	bt     %rax,%r15
    ec8f:	73 19                	jae    ecaa <tp_value+0x155a>
    ec91:	48 ff c6             	inc    %rsi
    ec94:	48 89 71 10          	mov    %rsi,0x10(%rcx)
    ec98:	49 39 f5             	cmp    %rsi,%r13
    ec9b:	75 e3                	jne    ec80 <tp_value+0x1530>
    ec9d:	4c 89 eb             	mov    %r13,%rbx
    eca0:	4c 89 ee             	mov    %r13,%rsi
    eca3:	eb 55                	jmp    ecfa <tp_value+0x15aa>
    eca5:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
    ecaa:	48 bf 03 00 00 00 00 	movabs $0x4000000000003,%rdi
    ecb1:	00 04 00 
    ecb4:	48 89 f3             	mov    %rsi,%rbx
    ecb7:	4c 39 ee             	cmp    %r13,%rsi
    ecba:	72 0e                	jb     ecca <tp_value+0x157a>
    ecbc:	eb 3c                	jmp    ecfa <tp_value+0x15aa>
    ecbe:	48 ff c3             	inc    %rbx
    ecc1:	48 89 59 10          	mov    %rbx,0x10(%rcx)
    ecc5:	49 39 dd             	cmp    %rbx,%r13
    ecc8:	74 2d                	je     ecf7 <tp_value+0x15a7>
    ecca:	41 0f b6 04 1c       	movzbl (%r12,%rbx,1),%eax
    eccf:	8d 50 d0             	lea    -0x30(%rax),%edx
    ecd2:	80 fa 0a             	cmp    $0xa,%dl
    ecd5:	72 e7                	jb     ecbe <tp_value+0x156e>
    ecd7:	89 c2                	mov    %eax,%edx
    ecd9:	80 e2 df             	and    $0xdf,%dl
    ecdc:	80 c2 bf             	add    $0xbf,%dl
    ecdf:	80 fa 1a             	cmp    $0x1a,%dl
    ece2:	72 da                	jb     ecbe <tp_value+0x156e>
    ece4:	0f b6 c0             	movzbl %al,%eax
    ece7:	83 c0 d3             	add    $0xffffffd3,%eax
    ecea:	83 f8 32             	cmp    $0x32,%eax
    eced:	77 0b                	ja     ecfa <tp_value+0x15aa>
    ecef:	48 0f a3 c7          	bt     %rax,%rdi
    ecf3:	72 c9                	jb     ecbe <tp_value+0x156e>
    ecf5:	eb 03                	jmp    ecfa <tp_value+0x15aa>
    ecf7:	4c 89 eb             	mov    %r13,%rbx
    ecfa:	48 89 dd             	mov    %rbx,%rbp
    ecfd:	48 29 f5             	sub    %rsi,%rbp
    ed00:	48 81 fd ff 00 00 00 	cmp    $0xff,%rbp
    ed07:	49 0f 43 e8          	cmovae %r8,%rbp
    ed0b:	4c 01 e6             	add    %r12,%rsi
    ed0e:	4c 89 cf             	mov    %r9,%rdi
    ed11:	48 89 ea             	mov    %rbp,%rdx
    ed14:	e8 17 46 ff ff       	call   3330 <memcpy@plt>
    ed19:	c6 44 2c 50 00       	movb   $0x0,0x50(%rsp,%rbp,1)
    ed1e:	45 8b 3e             	mov    (%r14),%r15d
    ed21:	45 85 ff             	test   %r15d,%r15d
    ed24:	48 8b 44 24 48       	mov    0x48(%rsp),%rax
    ed29:	0f 8e 36 01 00 00    	jle    ee65 <tp_value+0x1715>
    ed2f:	4c 89 6c 24 28       	mov    %r13,0x28(%rsp)
    ed34:	4c 89 64 24 30       	mov    %r12,0x30(%rsp)
    ed39:	4c 8b 60 18          	mov    0x18(%rax),%r12
    ed3d:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    ed42:	45 31 f6             	xor    %r14d,%r14d
    ed45:	4c 8d 6c 24 50       	lea    0x50(%rsp),%r13
    ed4a:	4b 8b 3c f4          	mov    (%r12,%r14,8),%rdi
    ed4e:	4c 89 ee             	mov    %r13,%rsi
    ed51:	e8 7a 45 ff ff       	call   32d0 <strcmp@plt>
    ed56:	85 c0                	test   %eax,%eax
    ed58:	41 0f 44 ee          	cmove  %r14d,%ebp
    ed5c:	49 ff c6             	inc    %r14
    ed5f:	4d 39 f7             	cmp    %r14,%r15
    ed62:	75 e6                	jne    ed4a <tp_value+0x15fa>
    ed64:	85 ed                	test   %ebp,%ebp
    ed66:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    ed6b:	48 8b 44 24 48       	mov    0x48(%rsp),%rax
    ed70:	49 bf 00 26 00 00 01 	movabs $0x100002600,%r15
    ed77:	00 00 00 
    ed7a:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    ed7f:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
    ed84:	0f 88 db 00 00 00    	js     ee65 <tp_value+0x1715>
    ed8a:	48 39 fb             	cmp    %rdi,%rbx
    ed8d:	73 21                	jae    edb0 <tp_value+0x1660>
    ed8f:	0f b6 14 1e          	movzbl (%rsi,%rbx,1),%edx
    ed93:	48 83 fa 20          	cmp    $0x20,%rdx
    ed97:	77 17                	ja     edb0 <tp_value+0x1660>
    ed99:	49 0f a3 d7          	bt     %rdx,%r15
    ed9d:	73 11                	jae    edb0 <tp_value+0x1660>
    ed9f:	48 ff c3             	inc    %rbx
    eda2:	48 89 59 10          	mov    %rbx,0x10(%rcx)
    eda6:	48 39 df             	cmp    %rbx,%rdi
    eda9:	75 e4                	jne    ed8f <tp_value+0x163f>
    edab:	e9 b5 00 00 00       	jmp    ee65 <tp_value+0x1715>
    edb0:	48 39 df             	cmp    %rbx,%rdi
    edb3:	0f 84 ac 00 00 00    	je     ee65 <tp_value+0x1715>
    edb9:	80 3c 1e 3d          	cmpb   $0x3d,(%rsi,%rbx,1)
    edbd:	0f 85 a2 00 00 00    	jne    ee65 <tp_value+0x1715>
    edc3:	48 ff c3             	inc    %rbx
    edc6:	48 89 59 10          	mov    %rbx,0x10(%rcx)
    edca:	48 8b 40 20          	mov    0x20(%rax),%rax
    edce:	89 eb                	mov    %ebp,%ebx
    edd0:	48 8b 34 d8          	mov    (%rax,%rbx,8),%rsi
    edd4:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    edd9:	48 8d 0c d8          	lea    (%rax,%rbx,8),%rcx
    eddd:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    ede2:	31 d2                	xor    %edx,%edx
    ede4:	e8 67 e9 ff ff       	call   d750 <tp_value>
    ede9:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    edee:	85 c0                	test   %eax,%eax
    edf0:	74 73                	je     ee65 <tp_value+0x1715>
    edf2:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
    edf7:	c6 04 18 01          	movb   $0x1,(%rax,%rbx,1)
    edfb:	48 8b 51 08          	mov    0x8(%rcx),%rdx
    edff:	48 8b 41 10          	mov    0x10(%rcx),%rax
    ee03:	48 39 d0             	cmp    %rdx,%rax
    ee06:	73 21                	jae    ee29 <tp_value+0x16d9>
    ee08:	48 8b 31             	mov    (%rcx),%rsi
    ee0b:	0f b6 3c 06          	movzbl (%rsi,%rax,1),%edi
    ee0f:	48 83 ff 20          	cmp    $0x20,%rdi
    ee13:	77 14                	ja     ee29 <tp_value+0x16d9>
    ee15:	49 0f a3 ff          	bt     %rdi,%r15
    ee19:	73 0e                	jae    ee29 <tp_value+0x16d9>
    ee1b:	48 ff c0             	inc    %rax
    ee1e:	48 89 41 10          	mov    %rax,0x10(%rcx)
    ee22:	48 39 c2             	cmp    %rax,%rdx
    ee25:	75 e4                	jne    ee0b <tp_value+0x16bb>
    ee27:	eb 12                	jmp    ee3b <tp_value+0x16eb>
    ee29:	48 39 c2             	cmp    %rax,%rdx
    ee2c:	74 0d                	je     ee3b <tp_value+0x16eb>
    ee2e:	48 8b 11             	mov    (%rcx),%rdx
    ee31:	80 3c 02 7d          	cmpb   $0x7d,(%rdx,%rax,1)
    ee35:	0f 84 db 00 00 00    	je     ef16 <tp_value+0x17c6>
    ee3b:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    ee40:	48 8d 35 9f 78 00 00 	lea    0x789f(%rip),%rsi        # 166e6 <exec_in_fp0+0xe76>
    ee47:	e8 c4 0b 00 00       	call   fa10 <tp_eat>
    ee4c:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    ee51:	85 c0                	test   %eax,%eax
    ee53:	74 10                	je     ee65 <tp_value+0x1715>
    ee55:	41 b8 ff 00 00 00    	mov    $0xff,%r8d
    ee5b:	4c 8d 4c 24 50       	lea    0x50(%rsp),%r9
    ee60:	e9 06 fe ff ff       	jmp    ec6b <tp_value+0x151b>
    ee65:	45 31 f6             	xor    %r14d,%r14d
    ee68:	e9 aa ee ff ff       	jmp    dd17 <tp_value+0x5c7>
    ee6d:	48 89 fa             	mov    %rdi,%rdx
    ee70:	48 39 f7             	cmp    %rsi,%rdi
    ee73:	75 09                	jne    ee7e <tp_value+0x172e>
    ee75:	45 84 c0             	test   %r8b,%r8b
    ee78:	0f 85 99 ee ff ff    	jne    dd17 <tp_value+0x5c7>
    ee7e:	48 39 c2             	cmp    %rax,%rdx
    ee81:	73 5b                	jae    eede <tp_value+0x178e>
    ee83:	0f b6 74 14 50       	movzbl 0x50(%rsp,%rdx,1),%esi
    ee88:	83 ce 20             	or     $0x20,%esi
    ee8b:	83 fe 65             	cmp    $0x65,%esi
    ee8e:	75 4e                	jne    eede <tp_value+0x178e>
    ee90:	48 8d 72 01          	lea    0x1(%rdx),%rsi
    ee94:	48 39 c6             	cmp    %rax,%rsi
    ee97:	73 16                	jae    eeaf <tp_value+0x175f>
    ee99:	0f b6 7c 34 50       	movzbl 0x50(%rsp,%rsi,1),%edi
    ee9e:	83 ff 2d             	cmp    $0x2d,%edi
    eea1:	74 05                	je     eea8 <tp_value+0x1758>
    eea3:	83 ff 2b             	cmp    $0x2b,%edi
    eea6:	75 07                	jne    eeaf <tp_value+0x175f>
    eea8:	48 83 c2 02          	add    $0x2,%rdx
    eeac:	48 89 d6             	mov    %rdx,%rsi
    eeaf:	48 39 c6             	cmp    %rax,%rsi
    eeb2:	0f 83 5f ee ff ff    	jae    dd17 <tp_value+0x5c7>
    eeb8:	48 89 f2             	mov    %rsi,%rdx
    eebb:	0f b6 7c 14 50       	movzbl 0x50(%rsp,%rdx,1),%edi
    eec0:	40 80 c7 d0          	add    $0xd0,%dil
    eec4:	40 80 ff 09          	cmp    $0x9,%dil
    eec8:	77 0b                	ja     eed5 <tp_value+0x1785>
    eeca:	48 ff c2             	inc    %rdx
    eecd:	48 39 d0             	cmp    %rdx,%rax
    eed0:	75 e9                	jne    eebb <tp_value+0x176b>
    eed2:	48 89 c2             	mov    %rax,%rdx
    eed5:	48 39 f2             	cmp    %rsi,%rdx
    eed8:	0f 84 39 ee ff ff    	je     dd17 <tp_value+0x5c7>
    eede:	48 39 c2             	cmp    %rax,%rdx
    eee1:	0f 85 30 ee ff ff    	jne    dd17 <tp_value+0x5c7>
    eee7:	83 39 0a             	cmpl   $0xa,(%rcx)
    eeea:	75 19                	jne    ef05 <tp_value+0x17b5>
    eeec:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    eef1:	31 f6                	xor    %esi,%esi
    eef3:	e8 08 43 ff ff       	call   3200 <strtof@plt>
    eef8:	66 0f 7e c0          	movd   %xmm0,%eax
    eefc:	49 89 04 24          	mov    %rax,(%r12)
    ef00:	e9 0c ee ff ff       	jmp    dd11 <tp_value+0x5c1>
    ef05:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    ef0a:	31 f6                	xor    %esi,%esi
    ef0c:	e8 ef 41 ff ff       	call   3100 <strtod@plt>
    ef11:	e9 b2 ed ff ff       	jmp    dcc8 <tp_value+0x578>
    ef16:	48 ff c0             	inc    %rax
    ef19:	48 89 41 10          	mov    %rax,0x10(%rcx)
    ef1d:	4c 8b 64 24 40       	mov    0x40(%rsp),%r12
    ef22:	e9 40 f9 ff ff       	jmp    e867 <tp_value+0x1117>
    ef27:	e8 c4 7c ff ff       	call   6bf0 <fwp_flush>
    ef2c:	48 8b 05 a5 b0 00 00 	mov    0xb0a5(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    ef33:	48 8b 38             	mov    (%rax),%rdi
    ef36:	48 8d 35 5c 6b 00 00 	lea    0x6b5c(%rip),%rsi        # 15a99 <exec_in_fp0+0x229>
    ef3d:	48 8d 15 9d 7a 00 00 	lea    0x7a9d(%rip),%rdx        # 169e1 <exec_in_fp0+0x1171>
    ef44:	31 c0                	xor    %eax,%eax
    ef46:	e8 a5 43 ff ff       	call   32f0 <fprintf@plt>
    ef4b:	bf 65 00 00 00       	mov    $0x65,%edi
    ef50:	e8 0b 45 ff ff       	call   3460 <exit@plt>
    ef55:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    ef5c:	00 00 00 00 

000000000000ef60 <tp_int>:
    ef60:	55                   	push   %rbp
    ef61:	41 57                	push   %r15
    ef63:	41 56                	push   %r14
    ef65:	41 55                	push   %r13
    ef67:	41 54                	push   %r12
    ef69:	53                   	push   %rbx
    ef6a:	48 81 ec b8 00 00 00 	sub    $0xb8,%rsp
    ef71:	49 89 d6             	mov    %rdx,%r14
    ef74:	49 89 f4             	mov    %rsi,%r12
    ef77:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
    ef7c:	ba 80 00 00 00       	mov    $0x80,%edx
    ef81:	e8 6a 0d 00 00       	call   fcf0 <tp_token>
    ef86:	45 31 d2             	xor    %r10d,%r10d
    ef89:	48 83 f8 7f          	cmp    $0x7f,%rax
    ef8d:	0f 87 fa 00 00 00    	ja     f08d <tp_int+0x12d>
    ef93:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    ef98:	e8 d3 41 ff ff       	call   3170 <strlen@plt>
    ef9d:	49 89 c5             	mov    %rax,%r13
    efa0:	48 ff 05 01 cf 00 00 	incq   0xcf01(%rip)        # 1bea8 <measured_calls>
    efa7:	48 8d 50 09          	lea    0x9(%rax),%rdx
    efab:	48 01 15 fe ce 00 00 	add    %rdx,0xcefe(%rip)        # 1beb0 <measured_bytes>
    efb2:	48 8d 3d cf b2 00 00 	lea    0xb2cf(%rip),%rdi        # 1a288 <fwp_gc>
    efb9:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    efc0:	77 5e                	ja     f020 <tp_int+0xc0>
    efc2:	4c 89 e8             	mov    %r13,%rax
    efc5:	48 83 c0 18          	add    $0x18,%rax
    efc9:	48 c1 e8 04          	shr    $0x4,%rax
    efcd:	0f b6 8c 38 e8 0b 00 	movzbl 0xbe8(%rax,%rdi,1),%ecx
    efd4:	00 
    efd5:	8b 84 8f 48 0b 00 00 	mov    0xb48(%rdi,%rcx,4),%eax
    efdc:	48 29 05 a5 b2 00 00 	sub    %rax,0xb2a5(%rip)        # 1a288 <fwp_gc>
    efe3:	78 3b                	js     f020 <tp_int+0xc0>
    efe5:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    efe9:	48 8d 34 cf          	lea    (%rdi,%rcx,8),%rsi
    efed:	48 81 c6 c8 03 00 00 	add    $0x3c8,%rsi
    eff4:	48 8b 2e             	mov    (%rsi),%rbp
    eff7:	48 85 ed             	test   %rbp,%rbp
    effa:	74 0c                	je     f008 <tp_int+0xa8>
    effc:	48 8b 45 00          	mov    0x0(%rbp),%rax
    f000:	48 f7 d0             	not    %rax
    f003:	48 89 06             	mov    %rax,(%rsi)
    f006:	eb 3b                	jmp    f043 <tp_int+0xe3>
    f008:	48 8b ac cf d0 03 00 	mov    0x3d0(%rdi,%rcx,8),%rbp
    f00f:	00 
    f010:	48 8b b4 cf d8 03 00 	mov    0x3d8(%rdi,%rcx,8),%rsi
    f017:	00 
    f018:	48 29 ee             	sub    %rbp,%rsi
    f01b:	48 39 c6             	cmp    %rax,%rsi
    f01e:	73 12                	jae    f032 <tp_int+0xd2>
    f020:	48 89 d7             	mov    %rdx,%rdi
    f023:	be 01 00 00 00       	mov    $0x1,%esi
    f028:	e8 93 92 ff ff       	call   82c0 <fwp_gc_alloc_slow>
    f02d:	48 89 c5             	mov    %rax,%rbp
    f030:	eb 1b                	jmp    f04d <tp_int+0xed>
    f032:	48 8d 0c cf          	lea    (%rdi,%rcx,8),%rcx
    f036:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
    f03d:	48 01 e8             	add    %rbp,%rax
    f040:	48 89 01             	mov    %rax,(%rcx)
    f043:	48 89 ef             	mov    %rbp,%rdi
    f046:	31 f6                	xor    %esi,%esi
    f048:	e8 c3 41 ff ff       	call   3210 <memset@plt>
    f04d:	4c 89 6d 00          	mov    %r13,0x0(%rbp)
    f051:	4c 8d 7d 08          	lea    0x8(%rbp),%r15
    f055:	48 8d 5c 24 30       	lea    0x30(%rsp),%rbx
    f05a:	4c 89 ff             	mov    %r15,%rdi
    f05d:	48 89 de             	mov    %rbx,%rsi
    f060:	4c 89 ea             	mov    %r13,%rdx
    f063:	e8 c8 42 ff ff       	call   3330 <memcpy@plt>
    f068:	42 c6 44 2d 08 00    	movb   $0x0,0x8(%rbp,%r13,1)
    f06e:	4c 8b 5d 00          	mov    0x0(%rbp),%r11
    f072:	4d 85 db             	test   %r11,%r11
    f075:	74 13                	je     f08a <tp_int+0x12a>
    f077:	41 0f b6 3f          	movzbl (%r15),%edi
    f07b:	8d 47 d5             	lea    -0x2b(%rdi),%eax
    f07e:	31 c9                	xor    %ecx,%ecx
    f080:	a8 fd                	test   $0xfd,%al
    f082:	0f 94 c1             	sete   %cl
    f085:	49 39 cb             	cmp    %rcx,%r11
    f088:	75 18                	jne    f0a2 <tp_int+0x142>
    f08a:	45 31 d2             	xor    %r10d,%r10d
    f08d:	44 89 d0             	mov    %r10d,%eax
    f090:	48 81 c4 b8 00 00 00 	add    $0xb8,%rsp
    f097:	5b                   	pop    %rbx
    f098:	41 5c                	pop    %r12
    f09a:	41 5d                	pop    %r13
    f09c:	41 5e                	pop    %r14
    f09e:	41 5f                	pop    %r15
    f0a0:	5d                   	pop    %rbp
    f0a1:	c3                   	ret
    f0a2:	45 8b 04 24          	mov    (%r12),%r8d
    f0a6:	41 8b 74 24 48       	mov    0x48(%r12),%esi
    f0ab:	76 18                	jbe    f0c5 <tp_int+0x165>
    f0ad:	0f 1f 00             	nopl   (%rax)
    f0b0:	41 0f b6 14 0f       	movzbl (%r15,%rcx,1),%edx
    f0b5:	80 c2 c6             	add    $0xc6,%dl
    f0b8:	80 fa f6             	cmp    $0xf6,%dl
    f0bb:	72 cd                	jb     f08a <tp_int+0x12a>
    f0bd:	48 ff c1             	inc    %rcx
    f0c0:	49 39 cb             	cmp    %rcx,%r11
    f0c3:	75 eb                	jne    f0b0 <tp_int+0x150>
    f0c5:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
    f0ca:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    f0cf:	48 89 74 24 18       	mov    %rsi,0x18(%rsp)
    f0d4:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    f0d9:	31 db                	xor    %ebx,%ebx
    f0db:	a8 fd                	test   $0xfd,%al
    f0dd:	0f 94 c3             	sete   %bl
    f0e0:	45 31 e4             	xor    %r12d,%r12d
    f0e3:	41 be 00 00 00 00    	mov    $0x0,%r14d
    f0e9:	49 39 db             	cmp    %rbx,%r11
    f0ec:	0f 86 bf 00 00 00    	jbe    f1b1 <tp_int+0x251>
    f0f2:	bd 0a 00 00 00       	mov    $0xa,%ebp
    f0f7:	49 b8 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r8
    f0fe:	cc cc cc 
    f101:	49 ba cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r10
    f108:	cc cc cc 
    f10b:	45 31 e4             	xor    %r12d,%r12d
    f10e:	45 31 f6             	xor    %r14d,%r14d
    f111:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    f118:	0f 1f 84 00 00 00 00 
    f11f:	00 
    f120:	4d 89 f1             	mov    %r14,%r9
    f123:	4c 89 e1             	mov    %r12,%rcx
    f126:	4c 89 e0             	mov    %r12,%rax
    f129:	48 f7 e5             	mul    %rbp
    f12c:	4b 8d 34 b6          	lea    (%r14,%r14,4),%rsi
    f130:	48 8d 14 72          	lea    (%rdx,%rsi,2),%rdx
    f134:	41 0f be 34 1f       	movsbl (%r15,%rbx,1),%esi
    f139:	83 c6 d0             	add    $0xffffffd0,%esi
    f13c:	48 63 f6             	movslq %esi,%rsi
    f13f:	49 89 f6             	mov    %rsi,%r14
    f142:	49 c1 fe 3f          	sar    $0x3f,%r14
    f146:	49 89 c4             	mov    %rax,%r12
    f149:	49 01 f4             	add    %rsi,%r12
    f14c:	49 11 d6             	adc    %rdx,%r14
    f14f:	4c 89 f6             	mov    %r14,%rsi
    f152:	4c 0f a4 e6 3f       	shld   $0x3f,%r12,%rsi
    f157:	4d 89 f5             	mov    %r14,%r13
    f15a:	49 d1 ed             	shr    $1,%r13
    f15d:	48 89 f7             	mov    %rsi,%rdi
    f160:	4c 01 ef             	add    %r13,%rdi
    f163:	48 83 d7 00          	adc    $0x0,%rdi
    f167:	48 89 f8             	mov    %rdi,%rax
    f16a:	49 f7 e0             	mul    %r8
    f16d:	48 c1 ea 02          	shr    $0x2,%rdx
    f171:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    f175:	48 29 c7             	sub    %rax,%rdi
    f178:	48 29 fe             	sub    %rdi,%rsi
    f17b:	49 83 dd 00          	sbb    $0x0,%r13
    f17f:	48 89 f7             	mov    %rsi,%rdi
    f182:	49 0f af fa          	imul   %r10,%rdi
    f186:	48 89 f0             	mov    %rsi,%rax
    f189:	49 f7 e0             	mul    %r8
    f18c:	48 01 fa             	add    %rdi,%rdx
    f18f:	4d 0f af e8          	imul   %r8,%r13
    f193:	49 01 d5             	add    %rdx,%r13
    f196:	4d 31 cd             	xor    %r9,%r13
    f199:	48 31 c8             	xor    %rcx,%rax
    f19c:	4c 09 e8             	or     %r13,%rax
    f19f:	0f 85 e5 fe ff ff    	jne    f08a <tp_int+0x12a>
    f1a5:	48 ff c3             	inc    %rbx
    f1a8:	49 39 db             	cmp    %rbx,%r11
    f1ab:	0f 85 6f ff ff ff    	jne    f120 <tp_int+0x1c0>
    f1b1:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
    f1b6:	41 83 f8 09          	cmp    $0x9,%r8d
    f1ba:	75 71                	jne    f22d <tp_int+0x2cd>
    f1bc:	80 7c 24 10 2d       	cmpb   $0x2d,0x10(%rsp)
    f1c1:	4c 8d 0d c0 b0 00 00 	lea    0xb0c0(%rip),%r9        # 1a288 <fwp_gc>
    f1c8:	75 0f                	jne    f1d9 <tp_int+0x279>
    f1ca:	45 31 d2             	xor    %r10d,%r10d
    f1cd:	4c 89 e0             	mov    %r12,%rax
    f1d0:	4c 09 f0             	or     %r14,%rax
    f1d3:	0f 85 b4 fe ff ff    	jne    f08d <tp_int+0x12d>
    f1d9:	48 ff 05 c8 cc 00 00 	incq   0xccc8(%rip)        # 1bea8 <measured_calls>
    f1e0:	48 83 05 c8 cc 00 00 	addq   $0x10,0xccc8(%rip)        # 1beb0 <measured_bytes>
    f1e7:	10 
    f1e8:	0f b6 0d 82 bc 00 00 	movzbl 0xbc82(%rip),%ecx        # 1ae71 <fwp_gc+0xbe9>
    f1ef:	41 8b 84 89 48 0b 00 	mov    0xb48(%r9,%rcx,4),%eax
    f1f6:	00 
    f1f7:	48 29 05 8a b0 00 00 	sub    %rax,0xb08a(%rip)        # 1a288 <fwp_gc>
    f1fe:	0f 88 d7 00 00 00    	js     f2db <tp_int+0x37b>
    f204:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    f208:	49 8d 14 c9          	lea    (%r9,%rcx,8),%rdx
    f20c:	48 81 c2 c8 03 00 00 	add    $0x3c8,%rdx
    f213:	4c 8b 3a             	mov    (%rdx),%r15
    f216:	4d 85 ff             	test   %r15,%r15
    f219:	0f 84 a4 00 00 00    	je     f2c3 <tp_int+0x363>
    f21f:	49 8b 07             	mov    (%r15),%rax
    f222:	48 f7 d0             	not    %rax
    f225:	48 89 02             	mov    %rax,(%rdx)
    f228:	e9 d9 00 00 00       	jmp    f306 <tp_int+0x3a6>
    f22d:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    f232:	40 80 ff 2d          	cmp    $0x2d,%dil
    f236:	0f 94 c1             	sete   %cl
    f239:	48 b8 00 00 00 00 00 	movabs $0x8000000000000000,%rax
    f240:	00 00 80 
    f243:	4c 89 f2             	mov    %r14,%rdx
    f246:	48 31 c2             	xor    %rax,%rdx
    f249:	4c 09 e2             	or     %r12,%rdx
    f24c:	0f 95 c2             	setne  %dl
    f24f:	45 31 d2             	xor    %r10d,%r10d
    f252:	4c 89 e6             	mov    %r12,%rsi
    f255:	48 f7 de             	neg    %rsi
    f258:	48 89 c6             	mov    %rax,%rsi
    f25b:	4c 19 f6             	sbb    %r14,%rsi
    f25e:	4c 8d 0d 23 b0 00 00 	lea    0xb023(%rip),%r9        # 1a288 <fwp_gc>
    f265:	0f 82 22 fe ff ff    	jb     f08d <tp_int+0x12d>
    f26b:	08 d1                	or     %dl,%cl
    f26d:	0f 84 1a fe ff ff    	je     f08d <tp_int+0x12d>
    f273:	45 31 d2             	xor    %r10d,%r10d
    f276:	4d 89 e7             	mov    %r12,%r15
    f279:	49 f7 df             	neg    %r15
    f27c:	bb 00 00 00 00       	mov    $0x0,%ebx
    f281:	4c 19 f3             	sbb    %r14,%rbx
    f284:	40 80 ff 2d          	cmp    $0x2d,%dil
    f288:	4d 0f 45 fc          	cmovne %r12,%r15
    f28c:	49 0f 45 de          	cmovne %r14,%rbx
    f290:	41 83 f8 14          	cmp    $0x14,%r8d
    f294:	0f 87 f3 fd ff ff    	ja     f08d <tp_int+0x12d>
    f29a:	44 89 c1             	mov    %r8d,%ecx
    f29d:	48 8d 15 ec 5f 00 00 	lea    0x5fec(%rip),%rdx        # 15290 <_IO_stdin_used+0x290>
    f2a4:	48 63 0c 8a          	movslq (%rdx,%rcx,4),%rcx
    f2a8:	48 01 d1             	add    %rdx,%rcx
    f2ab:	ff e1                	jmp    *%rcx
    f2ad:	4c 89 f8             	mov    %r15,%rax
    f2b0:	48 83 c0 80          	add    $0xffffffffffffff80,%rax
    f2b4:	48 83 d3 ff          	adc    $0xffffffffffffffff,%rbx
    f2b8:	48 3d 00 ff ff ff    	cmp    $0xffffffffffffff00,%rax
    f2be:	e9 93 01 00 00       	jmp    f456 <tp_int+0x4f6>
    f2c3:	4d 8b bc c9 d0 03 00 	mov    0x3d0(%r9,%rcx,8),%r15
    f2ca:	00 
    f2cb:	49 8b 94 c9 d8 03 00 	mov    0x3d8(%r9,%rcx,8),%rdx
    f2d2:	00 
    f2d3:	4c 29 fa             	sub    %r15,%rdx
    f2d6:	48 39 c2             	cmp    %rax,%rdx
    f2d9:	73 1a                	jae    f2f5 <tp_int+0x395>
    f2db:	bf 10 00 00 00       	mov    $0x10,%edi
    f2e0:	be 01 00 00 00       	mov    $0x1,%esi
    f2e5:	4c 89 cb             	mov    %r9,%rbx
    f2e8:	e8 d3 8f ff ff       	call   82c0 <fwp_gc_alloc_slow>
    f2ed:	49 89 d9             	mov    %rbx,%r9
    f2f0:	49 89 c7             	mov    %rax,%r15
    f2f3:	eb 18                	jmp    f30d <tp_int+0x3ad>
    f2f5:	49 8d 0c c9          	lea    (%r9,%rcx,8),%rcx
    f2f9:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
    f300:	4c 01 f8             	add    %r15,%rax
    f303:	48 89 01             	mov    %rax,(%rcx)
    f306:	0f 57 c0             	xorps  %xmm0,%xmm0
    f309:	41 0f 11 07          	movups %xmm0,(%r15)
    f30d:	4d 89 27             	mov    %r12,(%r15)
    f310:	4d 89 77 08          	mov    %r14,0x8(%r15)
    f314:	4c 89 7c 24 28       	mov    %r15,0x28(%rsp)
    f319:	48 ff 05 88 cb 00 00 	incq   0xcb88(%rip)        # 1bea8 <measured_calls>
    f320:	48 83 05 88 cb 00 00 	addq   $0x10,0xcb88(%rip)        # 1beb0 <measured_bytes>
    f327:	10 
    f328:	0f b6 05 42 bb 00 00 	movzbl 0xbb42(%rip),%eax        # 1ae71 <fwp_gc+0xbe9>
    f32f:	41 8b 94 81 48 0b 00 	mov    0xb48(%r9,%rax,4),%edx
    f336:	00 
    f337:	48 8b 0d 4a af 00 00 	mov    0xaf4a(%rip),%rcx        # 1a288 <fwp_gc>
    f33e:	48 29 d1             	sub    %rdx,%rcx
    f341:	48 89 0d 40 af 00 00 	mov    %rcx,0xaf40(%rip)        # 1a288 <fwp_gc>
    f348:	78 7f                	js     f3c9 <tp_int+0x469>
    f34a:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
    f34e:	49 8d 34 c1          	lea    (%r9,%rax,8),%rsi
    f352:	48 83 c6 08          	add    $0x8,%rsi
    f356:	4c 8b 36             	mov    (%rsi),%r14
    f359:	4d 85 f6             	test   %r14,%r14
    f35c:	74 2b                	je     f389 <tp_int+0x429>
    f35e:	49 8b 06             	mov    (%r14),%rax
    f361:	48 f7 d0             	not    %rax
    f364:	48 89 06             	mov    %rax,(%rsi)
    f367:	83 fa 11             	cmp    $0x11,%edx
    f36a:	0f 82 80 00 00 00    	jb     f3f0 <tp_int+0x490>
    f370:	49 8d 7e 10          	lea    0x10(%r14),%rdi
    f374:	48 83 c2 ef          	add    $0xffffffffffffffef,%rdx
    f378:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    f37c:	48 83 c2 08          	add    $0x8,%rdx
    f380:	31 f6                	xor    %esi,%esi
    f382:	e8 89 3e ff ff       	call   3210 <memset@plt>
    f387:	eb 67                	jmp    f3f0 <tp_int+0x490>
    f389:	4d 8b 74 c1 10       	mov    0x10(%r9,%rax,8),%r14
    f38e:	49 8b 74 c1 18       	mov    0x18(%r9,%rax,8),%rsi
    f393:	48 89 f7             	mov    %rsi,%rdi
    f396:	4c 29 f7             	sub    %r14,%rdi
    f399:	48 39 d7             	cmp    %rdx,%rdi
    f39c:	73 05                	jae    f3a3 <tp_int+0x443>
    f39e:	4d 89 f4             	mov    %r14,%r12
    f3a1:	eb 21                	jmp    f3c4 <tp_int+0x464>
    f3a3:	49 8d 3c c1          	lea    (%r9,%rax,8),%rdi
    f3a7:	48 83 c7 10          	add    $0x10,%rdi
    f3ab:	4d 8d 24 16          	lea    (%r14,%rdx,1),%r12
    f3af:	4c 89 27             	mov    %r12,(%rdi)
    f3b2:	4d 85 f6             	test   %r14,%r14
    f3b5:	75 b0                	jne    f367 <tp_int+0x407>
    f3b7:	48 89 0d ca ae 00 00 	mov    %rcx,0xaeca(%rip)        # 1a288 <fwp_gc>
    f3be:	4c 29 e6             	sub    %r12,%rsi
    f3c1:	48 89 f7             	mov    %rsi,%rdi
    f3c4:	48 39 d7             	cmp    %rdx,%rdi
    f3c7:	73 11                	jae    f3da <tp_int+0x47a>
    f3c9:	bf 10 00 00 00       	mov    $0x10,%edi
    f3ce:	31 f6                	xor    %esi,%esi
    f3d0:	e8 eb 8e ff ff       	call   82c0 <fwp_gc_alloc_slow>
    f3d5:	49 89 c6             	mov    %rax,%r14
    f3d8:	eb 16                	jmp    f3f0 <tp_int+0x490>
    f3da:	49 8d 0c 14          	lea    (%r12,%rdx,1),%rcx
    f3de:	49 89 4c c1 10       	mov    %rcx,0x10(%r9,%rax,8)
    f3e3:	4c 89 e7             	mov    %r12,%rdi
    f3e6:	31 f6                	xor    %esi,%esi
    f3e8:	e8 23 3e ff ff       	call   3210 <memset@plt>
    f3ed:	4d 89 e6             	mov    %r12,%r14
    f3f0:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
    f3f7:	00 00 00 
    f3fa:	49 89 06             	mov    %rax,(%r14)
    f3fd:	4d 89 7e 08          	mov    %r15,0x8(%r14)
    f401:	48 8d 44 24 28       	lea    0x28(%rsp),%rax
    f406:	49 8b 46 08          	mov    0x8(%r14),%rax
    f40a:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    f40f:	48 89 01             	mov    %rax,(%rcx)
    f412:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    f418:	e9 70 fc ff ff       	jmp    f08d <tp_int+0x12d>
    f41d:	4c 89 f8             	mov    %r15,%rax
    f420:	48 05 00 00 00 80    	add    $0xffffffff80000000,%rax
    f426:	48 83 d3 ff          	adc    $0xffffffffffffffff,%rbx
    f42a:	48 b9 00 00 00 00 ff 	movabs $0xffffffff00000000,%rcx
    f431:	ff ff ff 
    f434:	48 39 c8             	cmp    %rcx,%rax
    f437:	eb 1d                	jmp    f456 <tp_int+0x4f6>
    f439:	45 31 d2             	xor    %r10d,%r10d
    f43c:	b8 ff 00 00 00       	mov    $0xff,%eax
    f441:	eb 2a                	jmp    f46d <tp_int+0x50d>
    f443:	4c 89 f8             	mov    %r15,%rax
    f446:	48 05 00 80 ff ff    	add    $0xffffffffffff8000,%rax
    f44c:	48 83 d3 ff          	adc    $0xffffffffffffffff,%rbx
    f450:	48 3d 00 00 ff ff    	cmp    $0xffffffffffff0000,%rax
    f456:	48 83 db ff          	sbb    $0xffffffffffffffff,%rbx
    f45a:	0f 82 2d fc ff ff    	jb     f08d <tp_int+0x12d>
    f460:	e9 af fe ff ff       	jmp    f314 <tp_int+0x3b4>
    f465:	45 31 d2             	xor    %r10d,%r10d
    f468:	b8 ff ff 00 00       	mov    $0xffff,%eax
    f46d:	4c 39 f8             	cmp    %r15,%rax
    f470:	b8 00 00 00 00       	mov    $0x0,%eax
    f475:	48 19 d8             	sbb    %rbx,%rax
    f478:	0f 82 0f fc ff ff    	jb     f08d <tp_int+0x12d>
    f47e:	e9 91 fe ff ff       	jmp    f314 <tp_int+0x3b4>
    f483:	4c 89 f8             	mov    %r15,%rax
    f486:	48 c1 e8 20          	shr    $0x20,%rax
    f48a:	48 09 d8             	or     %rbx,%rax
    f48d:	0f 85 fa fb ff ff    	jne    f08d <tp_int+0x12d>
    f493:	e9 7c fe ff ff       	jmp    f314 <tp_int+0x3b4>
    f498:	4c 89 f9             	mov    %r15,%rcx
    f49b:	48 01 c1             	add    %rax,%rcx
    f49e:	48 83 d3 ff          	adc    $0xffffffffffffffff,%rbx
    f4a2:	48 83 fb ff          	cmp    $0xffffffffffffffff,%rbx
    f4a6:	0f 85 e1 fb ff ff    	jne    f08d <tp_int+0x12d>
    f4ac:	e9 63 fe ff ff       	jmp    f314 <tp_int+0x3b4>
    f4b1:	48 ff 05 f0 c9 00 00 	incq   0xc9f0(%rip)        # 1bea8 <measured_calls>
    f4b8:	48 83 05 f0 c9 00 00 	addq   $0x10,0xc9f0(%rip)        # 1beb0 <measured_bytes>
    f4bf:	10 
    f4c0:	0f b6 05 aa b9 00 00 	movzbl 0xb9aa(%rip),%eax        # 1ae71 <fwp_gc+0xbe9>
    f4c7:	41 8b 8c 81 48 0b 00 	mov    0xb48(%r9,%rax,4),%ecx
    f4ce:	00 
    f4cf:	48 29 0d b2 ad 00 00 	sub    %rcx,0xadb2(%rip)        # 1a288 <fwp_gc>
    f4d6:	0f 88 87 00 00 00    	js     f563 <tp_int+0x603>
    f4dc:	48 8d 14 40          	lea    (%rax,%rax,2),%rdx
    f4e0:	49 8d 34 d1          	lea    (%r9,%rdx,8),%rsi
    f4e4:	48 81 c6 c8 03 00 00 	add    $0x3c8,%rsi
    f4eb:	48 8b 06             	mov    (%rsi),%rax
    f4ee:	48 85 c0             	test   %rax,%rax
    f4f1:	74 54                	je     f547 <tp_int+0x5e7>
    f4f3:	48 8b 08             	mov    (%rax),%rcx
    f4f6:	48 f7 d1             	not    %rcx
    f4f9:	48 89 0e             	mov    %rcx,(%rsi)
    f4fc:	e9 12 01 00 00       	jmp    f613 <tp_int+0x6b3>
    f501:	45 31 d2             	xor    %r10d,%r10d
    f504:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    f509:	85 c9                	test   %ecx,%ecx
    f50b:	7e 31                	jle    f53e <tp_int+0x5de>
    f50d:	8d 41 ff             	lea    -0x1(%rcx),%eax
    f510:	83 f8 4f             	cmp    $0x4f,%eax
    f513:	bf 4f 00 00 00       	mov    $0x4f,%edi
    f518:	0f 42 f8             	cmovb  %eax,%edi
    f51b:	ff c7                	inc    %edi
    f51d:	89 fe                	mov    %edi,%esi
    f51f:	83 e6 07             	and    $0x7,%esi
    f522:	83 f9 08             	cmp    $0x8,%ecx
    f525:	73 56                	jae    f57d <tp_int+0x61d>
    f527:	b8 01 00 00 00       	mov    $0x1,%eax
    f52c:	31 c9                	xor    %ecx,%ecx
    f52e:	eb 72                	jmp    f5a2 <tp_int+0x642>
    f530:	48 85 db             	test   %rbx,%rbx
    f533:	0f 85 54 fb ff ff    	jne    f08d <tp_int+0x12d>
    f539:	e9 d6 fd ff ff       	jmp    f314 <tp_int+0x3b4>
    f53e:	31 d2                	xor    %edx,%edx
    f540:	31 c9                	xor    %ecx,%ecx
    f542:	e9 90 00 00 00       	jmp    f5d7 <tp_int+0x677>
    f547:	49 8b 84 d1 d0 03 00 	mov    0x3d0(%r9,%rdx,8),%rax
    f54e:	00 
    f54f:	49 8b b4 d1 d8 03 00 	mov    0x3d8(%r9,%rdx,8),%rsi
    f556:	00 
    f557:	48 29 c6             	sub    %rax,%rsi
    f55a:	48 39 ce             	cmp    %rcx,%rsi
    f55d:	0f 83 9f 00 00 00    	jae    f602 <tp_int+0x6a2>
    f563:	bf 10 00 00 00       	mov    $0x10,%edi
    f568:	be 01 00 00 00       	mov    $0x1,%esi
    f56d:	4d 89 ce             	mov    %r9,%r14
    f570:	e8 4b 8d ff ff       	call   82c0 <fwp_gc_alloc_slow>
    f575:	4d 89 f1             	mov    %r14,%r9
    f578:	e9 9c 00 00 00       	jmp    f619 <tp_int+0x6b9>
    f57d:	81 e7 f8 00 00 00    	and    $0xf8,%edi
    f583:	b8 01 00 00 00       	mov    $0x1,%eax
    f588:	31 c9                	xor    %ecx,%ecx
    f58a:	41 b8 a1 19 00 00    	mov    $0x19a1,%r8d
    f590:	49 f7 e0             	mul    %r8
    f593:	48 69 c9 a1 19 00 00 	imul   $0x19a1,%rcx,%rcx
    f59a:	48 01 d1             	add    %rdx,%rcx
    f59d:	83 c7 f8             	add    $0xfffffff8,%edi
    f5a0:	75 ee                	jne    f590 <tp_int+0x630>
    f5a2:	85 f6                	test   %esi,%esi
    f5a4:	74 13                	je     f5b9 <tp_int+0x659>
    f5a6:	bf 03 00 00 00       	mov    $0x3,%edi
    f5ab:	48 f7 e7             	mul    %rdi
    f5ae:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    f5b2:	48 01 d1             	add    %rdx,%rcx
    f5b5:	ff ce                	dec    %esi
    f5b7:	75 f2                	jne    f5ab <tp_int+0x64b>
    f5b9:	48 83 c0 ff          	add    $0xffffffffffffffff,%rax
    f5bd:	48 83 d1 ff          	adc    $0xffffffffffffffff,%rcx
    f5c1:	48 89 ca             	mov    %rcx,%rdx
    f5c4:	48 c1 ea 3f          	shr    $0x3f,%rdx
    f5c8:	48 01 c2             	add    %rax,%rdx
    f5cb:	48 83 d1 00          	adc    $0x0,%rcx
    f5cf:	48 0f ac ca 01       	shrd   $0x1,%rcx,%rdx
    f5d4:	48 d1 f9             	sar    $1,%rcx
    f5d7:	48 89 d0             	mov    %rdx,%rax
    f5da:	48 f7 d8             	neg    %rax
    f5dd:	be 00 00 00 00       	mov    $0x0,%esi
    f5e2:	48 19 ce             	sbb    %rcx,%rsi
    f5e5:	4c 39 fa             	cmp    %r15,%rdx
    f5e8:	48 19 d9             	sbb    %rbx,%rcx
    f5eb:	0f 8c 9c fa ff ff    	jl     f08d <tp_int+0x12d>
    f5f1:	49 39 c7             	cmp    %rax,%r15
    f5f4:	48 19 f3             	sbb    %rsi,%rbx
    f5f7:	0f 8d 17 fd ff ff    	jge    f314 <tp_int+0x3b4>
    f5fd:	e9 8b fa ff ff       	jmp    f08d <tp_int+0x12d>
    f602:	49 8d 14 d1          	lea    (%r9,%rdx,8),%rdx
    f606:	48 81 c2 d0 03 00 00 	add    $0x3d0,%rdx
    f60d:	48 01 c1             	add    %rax,%rcx
    f610:	48 89 0a             	mov    %rcx,(%rdx)
    f613:	0f 57 c0             	xorps  %xmm0,%xmm0
    f616:	0f 11 00             	movups %xmm0,(%rax)
    f619:	4c 89 38             	mov    %r15,(%rax)
    f61c:	48 89 58 08          	mov    %rbx,0x8(%rax)
    f620:	49 89 c7             	mov    %rax,%r15
    f623:	e9 ec fc ff ff       	jmp    f314 <tp_int+0x3b4>
    f628:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    f62f:	00 

000000000000f630 <tp_quoted>:
    f630:	55                   	push   %rbp
    f631:	41 57                	push   %r15
    f633:	41 56                	push   %r14
    f635:	41 55                	push   %r13
    f637:	41 54                	push   %r12
    f639:	53                   	push   %rbx
    f63a:	48 83 ec 28          	sub    $0x28,%rsp
    f63e:	48 89 f3             	mov    %rsi,%rbx
    f641:	49 89 ff             	mov    %rdi,%r15
    f644:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    f648:	48 8b 6f 10          	mov    0x10(%rdi),%rbp
    f64c:	4c 39 ed             	cmp    %r13,%rbp
    f64f:	73 33                	jae    f684 <tp_quoted+0x54>
    f651:	49 8b 07             	mov    (%r15),%rax
    f654:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    f65b:	00 00 00 
    f65e:	66 90                	xchg   %ax,%ax
    f660:	0f b6 14 28          	movzbl (%rax,%rbp,1),%edx
    f664:	48 83 fa 20          	cmp    $0x20,%rdx
    f668:	77 1a                	ja     f684 <tp_quoted+0x54>
    f66a:	48 0f a3 d1          	bt     %rdx,%rcx
    f66e:	73 14                	jae    f684 <tp_quoted+0x54>
    f670:	48 ff c5             	inc    %rbp
    f673:	49 89 6f 10          	mov    %rbp,0x10(%r15)
    f677:	49 39 ed             	cmp    %rbp,%r13
    f67a:	75 e4                	jne    f660 <tp_quoted+0x30>
    f67c:	45 31 f6             	xor    %r14d,%r14d
    f67f:	e9 f6 01 00 00       	jmp    f87a <tp_quoted+0x24a>
    f684:	45 31 f6             	xor    %r14d,%r14d
    f687:	4c 39 ed             	cmp    %r13,%rbp
    f68a:	0f 83 ea 01 00 00    	jae    f87a <tp_quoted+0x24a>
    f690:	49 8b 07             	mov    (%r15),%rax
    f693:	80 3c 28 22          	cmpb   $0x22,(%rax,%rbp,1)
    f697:	0f 85 dd 01 00 00    	jne    f87a <tp_quoted+0x24a>
    f69d:	48 ff c5             	inc    %rbp
    f6a0:	49 89 6f 10          	mov    %rbp,0x10(%r15)
    f6a4:	0f 57 c0             	xorps  %xmm0,%xmm0
    f6a7:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    f6ac:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    f6b3:	00 00 
    f6b5:	45 31 f6             	xor    %r14d,%r14d
    f6b8:	4c 39 ed             	cmp    %r13,%rbp
    f6bb:	0f 83 a6 01 00 00    	jae    f867 <tp_quoted+0x237>
    f6c1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    f6c8:	0f 1f 84 00 00 00 00 
    f6cf:	00 
    f6d0:	4d 8b 27             	mov    (%r15),%r12
    f6d3:	48 8d 4d 01          	lea    0x1(%rbp),%rcx
    f6d7:	49 89 4f 10          	mov    %rcx,0x10(%r15)
    f6db:	41 0f b6 04 2c       	movzbl (%r12,%rbp,1),%eax
    f6e0:	83 f8 5c             	cmp    $0x5c,%eax
    f6e3:	74 3b                	je     f720 <tp_quoted+0xf0>
    f6e5:	83 f8 22             	cmp    $0x22,%eax
    f6e8:	0f 84 9e 01 00 00    	je     f88c <tp_quoted+0x25c>
    f6ee:	88 44 24 0f          	mov    %al,0xf(%rsp)
    f6f2:	ba 01 00 00 00       	mov    $0x1,%edx
    f6f7:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    f6fc:	48 8d 74 24 0f       	lea    0xf(%rsp),%rsi
    f701:	e8 0a db ff ff       	call   d210 <buf_put>
    f706:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    f70a:	49 8b 6f 10          	mov    0x10(%r15),%rbp
    f70e:	4c 39 ed             	cmp    %r13,%rbp
    f711:	72 bd                	jb     f6d0 <tp_quoted+0xa0>
    f713:	e9 58 01 00 00       	jmp    f870 <tp_quoted+0x240>
    f718:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    f71f:	00 
    f720:	4c 39 e9             	cmp    %r13,%rcx
    f723:	0f 83 47 01 00 00    	jae    f870 <tp_quoted+0x240>
    f729:	48 8d 45 02          	lea    0x2(%rbp),%rax
    f72d:	49 89 47 10          	mov    %rax,0x10(%r15)
    f731:	41 0f b6 4c 2c 01    	movzbl 0x1(%r12,%rbp,1),%ecx
    f737:	8d 51 a4             	lea    -0x5c(%rcx),%edx
    f73a:	83 fa 19             	cmp    $0x19,%edx
    f73d:	77 17                	ja     f756 <tp_quoted+0x126>
    f73f:	48 8d 35 9e 5b 00 00 	lea    0x5b9e(%rip),%rsi        # 152e4 <_IO_stdin_used+0x2e4>
    f746:	48 63 0c 96          	movslq (%rsi,%rdx,4),%rcx
    f74a:	48 01 f1             	add    %rsi,%rcx
    f74d:	ff e1                	jmp    *%rcx
    f74f:	c6 44 24 0f 5c       	movb   $0x5c,0xf(%rsp)
    f754:	eb 9c                	jmp    f6f2 <tp_quoted+0xc2>
    f756:	83 f9 22             	cmp    $0x22,%ecx
    f759:	0f 84 c2 00 00 00    	je     f821 <tp_quoted+0x1f1>
    f75f:	83 f9 30             	cmp    $0x30,%ecx
    f762:	0f 85 08 01 00 00    	jne    f870 <tp_quoted+0x240>
    f768:	c6 44 24 0f 00       	movb   $0x0,0xf(%rsp)
    f76d:	eb 83                	jmp    f6f2 <tp_quoted+0xc2>
    f76f:	c6 44 24 0f 09       	movb   $0x9,0xf(%rsp)
    f774:	e9 79 ff ff ff       	jmp    f6f2 <tp_quoted+0xc2>
    f779:	c6 44 24 0f 0d       	movb   $0xd,0xf(%rsp)
    f77e:	e9 6f ff ff ff       	jmp    f6f2 <tp_quoted+0xc2>
    f783:	c6 44 24 0f 0a       	movb   $0xa,0xf(%rsp)
    f788:	e9 65 ff ff ff       	jmp    f6f2 <tp_quoted+0xc2>
    f78d:	4c 39 e8             	cmp    %r13,%rax
    f790:	0f 83 da 00 00 00    	jae    f870 <tp_quoted+0x240>
    f796:	41 80 3c 04 7b       	cmpb   $0x7b,(%r12,%rax,1)
    f79b:	0f 85 cf 00 00 00    	jne    f870 <tp_quoted+0x240>
    f7a1:	48 8d 45 03          	lea    0x3(%rbp),%rax
    f7a5:	49 89 47 10          	mov    %rax,0x10(%r15)
    f7a9:	4c 39 e8             	cmp    %r13,%rax
    f7ac:	0f 83 be 00 00 00    	jae    f870 <tp_quoted+0x240>
    f7b2:	e8 29 3d ff ff       	call   34e0 <__ctype_b_loc@plt>
    f7b7:	48 8b 08             	mov    (%rax),%rcx
    f7ba:	48 8d 55 04          	lea    0x4(%rbp),%rdx
    f7be:	49 8d 3c 2c          	lea    (%r12,%rbp,1),%rdi
    f7c2:	48 83 c7 03          	add    $0x3,%rdi
    f7c6:	49 29 ed             	sub    %rbp,%r13
    f7c9:	49 83 c5 fd          	add    $0xfffffffffffffffd,%r13
    f7cd:	31 c0                	xor    %eax,%eax
    f7cf:	31 f6                	xor    %esi,%esi
    f7d1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    f7d8:	0f 1f 84 00 00 00 00 
    f7df:	00 
    f7e0:	44 0f b6 04 07       	movzbl (%rdi,%rax,1),%r8d
    f7e5:	42 f6 44 41 01 10    	testb  $0x10,0x1(%rcx,%r8,2)
    f7eb:	74 3e                	je     f82b <tp_quoted+0x1fb>
    f7ed:	4c 8d 04 02          	lea    (%rdx,%rax,1),%r8
    f7f1:	4d 89 47 10          	mov    %r8,0x10(%r15)
    f7f5:	44 0f be 04 07       	movsbl (%rdi,%rax,1),%r8d
    f7fa:	c1 e6 04             	shl    $0x4,%esi
    f7fd:	45 8d 48 d0          	lea    -0x30(%r8),%r9d
    f801:	45 89 c2             	mov    %r8d,%r10d
    f804:	41 83 ca 20          	or     $0x20,%r10d
    f808:	41 83 c2 a9          	add    $0xffffffa9,%r10d
    f80c:	41 83 f8 3a          	cmp    $0x3a,%r8d
    f810:	45 0f 4c d1          	cmovl  %r9d,%r10d
    f814:	44 01 d6             	add    %r10d,%esi
    f817:	48 ff c0             	inc    %rax
    f81a:	49 39 c5             	cmp    %rax,%r13
    f81d:	75 c1                	jne    f7e0 <tp_quoted+0x1b0>
    f81f:	eb 4f                	jmp    f870 <tp_quoted+0x240>
    f821:	c6 44 24 0f 22       	movb   $0x22,0xf(%rsp)
    f826:	e9 c7 fe ff ff       	jmp    f6f2 <tp_quoted+0xc2>
    f82b:	85 c0                	test   %eax,%eax
    f82d:	74 41                	je     f870 <tp_quoted+0x240>
    f82f:	41 80 f8 7d          	cmp    $0x7d,%r8b
    f833:	75 3b                	jne    f870 <tp_quoted+0x240>
    f835:	81 fe ff ff 10 00    	cmp    $0x10ffff,%esi
    f83b:	77 33                	ja     f870 <tp_quoted+0x240>
    f83d:	89 f1                	mov    %esi,%ecx
    f83f:	81 e1 00 f8 ff ff    	and    $0xfffff800,%ecx
    f845:	81 f9 00 d8 00 00    	cmp    $0xd800,%ecx
    f84b:	74 23                	je     f870 <tp_quoted+0x240>
    f84d:	48 01 e8             	add    %rbp,%rax
    f850:	48 83 c0 04          	add    $0x4,%rax
    f854:	49 89 47 10          	mov    %rax,0x10(%r15)
    f858:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    f85d:	e8 ae 0b 00 00       	call   10410 <fwp_utf8_put>
    f862:	e9 9f fe ff ff       	jmp    f706 <tp_quoted+0xd6>
    f867:	31 ff                	xor    %edi,%edi
    f869:	e8 e2 37 ff ff       	call   3050 <free@plt>
    f86e:	eb 0a                	jmp    f87a <tp_quoted+0x24a>
    f870:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    f875:	e8 d6 37 ff ff       	call   3050 <free@plt>
    f87a:	44 89 f0             	mov    %r14d,%eax
    f87d:	48 83 c4 28          	add    $0x28,%rsp
    f881:	5b                   	pop    %rbx
    f882:	41 5c                	pop    %r12
    f884:	41 5d                	pop    %r13
    f886:	41 5e                	pop    %r14
    f888:	41 5f                	pop    %r15
    f88a:	5d                   	pop    %rbp
    f88b:	c3                   	ret
    f88c:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    f891:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    f896:	48 85 ff             	test   %rdi,%rdi
    f899:	48 8d 0d 35 69 00 00 	lea    0x6935(%rip),%rcx        # 161d5 <exec_in_fp0+0x965>
    f8a0:	48 0f 45 cf          	cmovne %rdi,%rcx
    f8a4:	48 85 c0             	test   %rax,%rax
    f8a7:	0f 84 3e 01 00 00    	je     f9eb <tp_quoted+0x3bb>
    f8ad:	31 d2                	xor    %edx,%edx
    f8af:	eb 0c                	jmp    f8bd <tp_quoted+0x28d>
    f8b1:	48 ff c2             	inc    %rdx
    f8b4:	48 39 c2             	cmp    %rax,%rdx
    f8b7:	0f 83 2e 01 00 00    	jae    f9eb <tp_quoted+0x3bb>
    f8bd:	44 0f b6 14 11       	movzbl (%rcx,%rdx,1),%r10d
    f8c2:	45 84 d2             	test   %r10b,%r10b
    f8c5:	79 ea                	jns    f8b1 <tp_quoted+0x281>
    f8c7:	41 8d 72 3e          	lea    0x3e(%r10),%esi
    f8cb:	40 80 fe 1e          	cmp    $0x1e,%sil
    f8cf:	73 13                	jae    f8e4 <tp_quoted+0x2b4>
    f8d1:	be 80 00 00 00       	mov    $0x80,%esi
    f8d6:	41 b9 01 00 00 00    	mov    $0x1,%r9d
    f8dc:	41 b8 1f 00 00 00    	mov    $0x1f,%r8d
    f8e2:	eb 3f                	jmp    f923 <tp_quoted+0x2f3>
    f8e4:	44 89 d6             	mov    %r10d,%esi
    f8e7:	40 80 e6 f0          	and    $0xf0,%sil
    f8eb:	40 80 fe e0          	cmp    $0xe0,%sil
    f8ef:	75 13                	jne    f904 <tp_quoted+0x2d4>
    f8f1:	be 00 08 00 00       	mov    $0x800,%esi
    f8f6:	41 b9 02 00 00 00    	mov    $0x2,%r9d
    f8fc:	41 b8 0f 00 00 00    	mov    $0xf,%r8d
    f902:	eb 1f                	jmp    f923 <tp_quoted+0x2f3>
    f904:	41 8d 72 10          	lea    0x10(%r10),%esi
    f908:	40 80 fe 04          	cmp    $0x4,%sil
    f90c:	0f 87 f1 00 00 00    	ja     fa03 <tp_quoted+0x3d3>
    f912:	be 00 00 01 00       	mov    $0x10000,%esi
    f917:	41 b9 03 00 00 00    	mov    $0x3,%r9d
    f91d:	41 b8 07 00 00 00    	mov    $0x7,%r8d
    f923:	45 89 c9             	mov    %r9d,%r9d
    f926:	4e 8d 1c 0a          	lea    (%rdx,%r9,1),%r11
    f92a:	49 39 c3             	cmp    %rax,%r11
    f92d:	0f 83 d0 00 00 00    	jae    fa03 <tp_quoted+0x3d3>
    f933:	44 0f b6 5c 11 01    	movzbl 0x1(%rcx,%rdx,1),%r11d
    f939:	44 89 dd             	mov    %r11d,%ebp
    f93c:	83 e5 c0             	and    $0xffffffc0,%ebp
    f93f:	81 fd 80 00 00 00    	cmp    $0x80,%ebp
    f945:	0f 85 b8 00 00 00    	jne    fa03 <tp_quoted+0x3d3>
    f94b:	45 21 d0             	and    %r10d,%r8d
    f94e:	45 8d 51 01          	lea    0x1(%r9),%r10d
    f952:	44 89 c5             	mov    %r8d,%ebp
    f955:	c1 e5 06             	shl    $0x6,%ebp
    f958:	41 83 e3 3f          	and    $0x3f,%r11d
    f95c:	41 09 eb             	or     %ebp,%r11d
    f95f:	41 83 fa 02          	cmp    $0x2,%r10d
    f963:	75 05                	jne    f96a <tp_quoted+0x33a>
    f965:	45 89 da             	mov    %r11d,%r10d
    f968:	eb 57                	jmp    f9c1 <tp_quoted+0x391>
    f96a:	44 0f b6 44 11 02    	movzbl 0x2(%rcx,%rdx,1),%r8d
    f970:	44 89 c5             	mov    %r8d,%ebp
    f973:	83 e5 c0             	and    $0xffffffc0,%ebp
    f976:	81 fd 80 00 00 00    	cmp    $0x80,%ebp
    f97c:	0f 85 81 00 00 00    	jne    fa03 <tp_quoted+0x3d3>
    f982:	44 89 dd             	mov    %r11d,%ebp
    f985:	c1 e5 06             	shl    $0x6,%ebp
    f988:	41 83 e0 3f          	and    $0x3f,%r8d
    f98c:	41 09 e8             	or     %ebp,%r8d
    f98f:	41 83 fa 03          	cmp    $0x3,%r10d
    f993:	75 08                	jne    f99d <tp_quoted+0x36d>
    f995:	45 89 c2             	mov    %r8d,%r10d
    f998:	45 89 d8             	mov    %r11d,%r8d
    f99b:	eb 24                	jmp    f9c1 <tp_quoted+0x391>
    f99d:	44 0f b6 54 11 03    	movzbl 0x3(%rcx,%rdx,1),%r10d
    f9a3:	45 89 d3             	mov    %r10d,%r11d
    f9a6:	41 83 e3 c0          	and    $0xffffffc0,%r11d
    f9aa:	41 81 fb 80 00 00 00 	cmp    $0x80,%r11d
    f9b1:	75 50                	jne    fa03 <tp_quoted+0x3d3>
    f9b3:	45 89 c3             	mov    %r8d,%r11d
    f9b6:	41 c1 e3 06          	shl    $0x6,%r11d
    f9ba:	41 83 e2 3f          	and    $0x3f,%r10d
    f9be:	45 09 da             	or     %r11d,%r10d
    f9c1:	41 83 e0 e0          	and    $0xffffffe0,%r8d
    f9c5:	41 81 f8 60 03 00 00 	cmp    $0x360,%r8d
    f9cc:	74 35                	je     fa03 <tp_quoted+0x3d3>
    f9ce:	41 39 f2             	cmp    %esi,%r10d
    f9d1:	72 30                	jb     fa03 <tp_quoted+0x3d3>
    f9d3:	41 81 fa ff ff 10 00 	cmp    $0x10ffff,%r10d
    f9da:	77 27                	ja     fa03 <tp_quoted+0x3d3>
    f9dc:	4c 01 ca             	add    %r9,%rdx
    f9df:	48 ff c2             	inc    %rdx
    f9e2:	48 39 c2             	cmp    %rax,%rdx
    f9e5:	0f 82 d2 fe ff ff    	jb     f8bd <tp_quoted+0x28d>
    f9eb:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    f9f0:	e8 0b d9 ff ff       	call   d300 <buf_to_str>
    f9f5:	48 89 03             	mov    %rax,(%rbx)
    f9f8:	41 be 01 00 00 00    	mov    $0x1,%r14d
    f9fe:	e9 77 fe ff ff       	jmp    f87a <tp_quoted+0x24a>
    fa03:	e8 48 36 ff ff       	call   3050 <free@plt>
    fa08:	e9 6f fc ff ff       	jmp    f67c <tp_quoted+0x4c>
    fa0d:	0f 1f 00             	nopl   (%rax)

000000000000fa10 <tp_eat>:
    fa10:	55                   	push   %rbp
    fa11:	41 57                	push   %r15
    fa13:	41 56                	push   %r14
    fa15:	41 54                	push   %r12
    fa17:	53                   	push   %rbx
    fa18:	49 89 f6             	mov    %rsi,%r14
    fa1b:	48 89 fb             	mov    %rdi,%rbx
    fa1e:	4c 8b 67 08          	mov    0x8(%rdi),%r12
    fa22:	4c 8b 7f 10          	mov    0x10(%rdi),%r15
    fa26:	4d 39 e7             	cmp    %r12,%r15
    fa29:	73 35                	jae    fa60 <tp_eat+0x50>
    fa2b:	48 8b 03             	mov    (%rbx),%rax
    fa2e:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    fa35:	00 00 00 
    fa38:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    fa3f:	00 
    fa40:	42 0f b6 14 38       	movzbl (%rax,%r15,1),%edx
    fa45:	48 83 fa 20          	cmp    $0x20,%rdx
    fa49:	77 15                	ja     fa60 <tp_eat+0x50>
    fa4b:	48 0f a3 d1          	bt     %rdx,%rcx
    fa4f:	73 0f                	jae    fa60 <tp_eat+0x50>
    fa51:	49 ff c7             	inc    %r15
    fa54:	4c 89 7b 10          	mov    %r15,0x10(%rbx)
    fa58:	4d 39 fc             	cmp    %r15,%r12
    fa5b:	75 e3                	jne    fa40 <tp_eat+0x30>
    fa5d:	4d 89 e7             	mov    %r12,%r15
    fa60:	4c 89 f7             	mov    %r14,%rdi
    fa63:	e8 08 37 ff ff       	call   3170 <strlen@plt>
    fa68:	4d 29 fc             	sub    %r15,%r12
    fa6b:	31 ed                	xor    %ebp,%ebp
    fa6d:	49 39 c4             	cmp    %rax,%r12
    fa70:	72 24                	jb     fa96 <tp_eat+0x86>
    fa72:	48 8b 3b             	mov    (%rbx),%rdi
    fa75:	4c 01 ff             	add    %r15,%rdi
    fa78:	4c 89 f6             	mov    %r14,%rsi
    fa7b:	49 89 c6             	mov    %rax,%r14
    fa7e:	48 89 c2             	mov    %rax,%rdx
    fa81:	e8 ea 38 ff ff       	call   3370 <bcmp@plt>
    fa86:	85 c0                	test   %eax,%eax
    fa88:	75 0c                	jne    fa96 <tp_eat+0x86>
    fa8a:	4d 01 f7             	add    %r14,%r15
    fa8d:	4c 89 7b 10          	mov    %r15,0x10(%rbx)
    fa91:	bd 01 00 00 00       	mov    $0x1,%ebp
    fa96:	89 e8                	mov    %ebp,%eax
    fa98:	5b                   	pop    %rbx
    fa99:	41 5c                	pop    %r12
    fa9b:	41 5e                	pop    %r14
    fa9d:	41 5f                	pop    %r15
    fa9f:	5d                   	pop    %rbp
    faa0:	c3                   	ret
    faa1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    faa8:	0f 1f 84 00 00 00 00 
    faaf:	00 

000000000000fab0 <tp_list_of>:
    fab0:	55                   	push   %rbp
    fab1:	41 57                	push   %r15
    fab3:	41 56                	push   %r14
    fab5:	41 55                	push   %r13
    fab7:	41 54                	push   %r12
    fab9:	53                   	push   %rbx
    faba:	48 83 ec 18          	sub    $0x18,%rsp
    fabe:	4d 89 c6             	mov    %r8,%r14
    fac1:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
    fac6:	49 89 f7             	mov    %rsi,%r15
    fac9:	48 89 fb             	mov    %rdi,%rbx
    facc:	48 8b 6f 08          	mov    0x8(%rdi),%rbp
    fad0:	4c 8b 67 10          	mov    0x10(%rdi),%r12
    fad4:	49 39 ec             	cmp    %rbp,%r12
    fad7:	48 89 14 24          	mov    %rdx,(%rsp)
    fadb:	73 33                	jae    fb10 <tp_list_of+0x60>
    fadd:	48 8b 03             	mov    (%rbx),%rax
    fae0:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    fae7:	00 00 00 
    faea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    faf0:	42 0f b6 34 20       	movzbl (%rax,%r12,1),%esi
    faf5:	48 83 fe 20          	cmp    $0x20,%rsi
    faf9:	77 15                	ja     fb10 <tp_list_of+0x60>
    fafb:	48 0f a3 f1          	bt     %rsi,%rcx
    faff:	73 0f                	jae    fb10 <tp_list_of+0x60>
    fb01:	49 ff c4             	inc    %r12
    fb04:	4c 89 63 10          	mov    %r12,0x10(%rbx)
    fb08:	4c 39 e5             	cmp    %r12,%rbp
    fb0b:	75 e3                	jne    faf0 <tp_list_of+0x40>
    fb0d:	49 89 ec             	mov    %rbp,%r12
    fb10:	4c 89 ff             	mov    %r15,%rdi
    fb13:	e8 58 36 ff ff       	call   3170 <strlen@plt>
    fb18:	49 89 c5             	mov    %rax,%r13
    fb1b:	48 89 e9             	mov    %rbp,%rcx
    fb1e:	4c 29 e1             	sub    %r12,%rcx
    fb21:	31 c0                	xor    %eax,%eax
    fb23:	4c 39 e9             	cmp    %r13,%rcx
    fb26:	72 1d                	jb     fb45 <tp_list_of+0x95>
    fb28:	4c 89 74 24 08       	mov    %r14,0x8(%rsp)
    fb2d:	4c 8b 33             	mov    (%rbx),%r14
    fb30:	4b 8d 3c 26          	lea    (%r14,%r12,1),%rdi
    fb34:	4c 89 fe             	mov    %r15,%rsi
    fb37:	4c 89 ea             	mov    %r13,%rdx
    fb3a:	e8 31 38 ff ff       	call   3370 <bcmp@plt>
    fb3f:	85 c0                	test   %eax,%eax
    fb41:	74 11                	je     fb54 <tp_list_of+0xa4>
    fb43:	31 c0                	xor    %eax,%eax
    fb45:	48 83 c4 18          	add    $0x18,%rsp
    fb49:	5b                   	pop    %rbx
    fb4a:	41 5c                	pop    %r12
    fb4c:	41 5d                	pop    %r13
    fb4e:	41 5e                	pop    %r14
    fb50:	41 5f                	pop    %r15
    fb52:	5d                   	pop    %rbp
    fb53:	c3                   	ret
    fb54:	4d 01 e5             	add    %r12,%r13
    fb57:	4c 89 6b 10          	mov    %r13,0x10(%rbx)
    fb5b:	49 bc 00 26 00 00 01 	movabs $0x100002600,%r12
    fb62:	00 00 00 
    fb65:	49 39 ed             	cmp    %rbp,%r13
    fb68:	73 28                	jae    fb92 <tp_list_of+0xe2>
    fb6a:	48 8b 3c 24          	mov    (%rsp),%rdi
    fb6e:	66 90                	xchg   %ax,%ax
    fb70:	43 0f b6 04 2e       	movzbl (%r14,%r13,1),%eax
    fb75:	48 83 f8 20          	cmp    $0x20,%rax
    fb79:	77 1b                	ja     fb96 <tp_list_of+0xe6>
    fb7b:	49 0f a3 c4          	bt     %rax,%r12
    fb7f:	73 15                	jae    fb96 <tp_list_of+0xe6>
    fb81:	49 ff c5             	inc    %r13
    fb84:	4c 89 6b 10          	mov    %r13,0x10(%rbx)
    fb88:	4c 39 ed             	cmp    %r13,%rbp
    fb8b:	75 e3                	jne    fb70 <tp_list_of+0xc0>
    fb8d:	49 89 ed             	mov    %rbp,%r13
    fb90:	eb 04                	jmp    fb96 <tp_list_of+0xe6>
    fb92:	48 8b 3c 24          	mov    (%rsp),%rdi
    fb96:	e8 d5 35 ff ff       	call   3170 <strlen@plt>
    fb9b:	4c 29 ed             	sub    %r13,%rbp
    fb9e:	48 39 c5             	cmp    %rax,%rbp
    fba1:	48 8b 34 24          	mov    (%rsp),%rsi
    fba5:	72 19                	jb     fbc0 <tp_list_of+0x110>
    fba7:	49 89 c7             	mov    %rax,%r15
    fbaa:	4d 01 ee             	add    %r13,%r14
    fbad:	4c 89 f7             	mov    %r14,%rdi
    fbb0:	48 89 c2             	mov    %rax,%rdx
    fbb3:	e8 b8 37 ff ff       	call   3370 <bcmp@plt>
    fbb8:	85 c0                	test   %eax,%eax
    fbba:	0f 84 da 00 00 00    	je     fc9a <tp_list_of+0x1ea>
    fbc0:	48 89 df             	mov    %rbx,%rdi
    fbc3:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    fbc8:	ff 54 24 10          	call   *0x10(%rsp)
    fbcc:	85 c0                	test   %eax,%eax
    fbce:	0f 84 6f ff ff ff    	je     fb43 <tp_list_of+0x93>
    fbd4:	4c 8b 6b 08          	mov    0x8(%rbx),%r13
    fbd8:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    fbdc:	4d 39 ee             	cmp    %r13,%r14
    fbdf:	73 31                	jae    fc12 <tp_list_of+0x162>
    fbe1:	48 8b 03             	mov    (%rbx),%rax
    fbe4:	48 8b 2c 24          	mov    (%rsp),%rbp
    fbe8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    fbef:	00 
    fbf0:	42 0f b6 0c 30       	movzbl (%rax,%r14,1),%ecx
    fbf5:	48 83 f9 20          	cmp    $0x20,%rcx
    fbf9:	77 1b                	ja     fc16 <tp_list_of+0x166>
    fbfb:	49 0f a3 cc          	bt     %rcx,%r12
    fbff:	73 15                	jae    fc16 <tp_list_of+0x166>
    fc01:	49 ff c6             	inc    %r14
    fc04:	4c 89 73 10          	mov    %r14,0x10(%rbx)
    fc08:	4d 39 f5             	cmp    %r14,%r13
    fc0b:	75 e3                	jne    fbf0 <tp_list_of+0x140>
    fc0d:	4d 89 ee             	mov    %r13,%r14
    fc10:	eb 04                	jmp    fc16 <tp_list_of+0x166>
    fc12:	48 8b 2c 24          	mov    (%rsp),%rbp
    fc16:	48 89 ef             	mov    %rbp,%rdi
    fc19:	e8 52 35 ff ff       	call   3170 <strlen@plt>
    fc1e:	49 89 c7             	mov    %rax,%r15
    fc21:	4c 89 e8             	mov    %r13,%rax
    fc24:	4c 29 f0             	sub    %r14,%rax
    fc27:	4c 39 f8             	cmp    %r15,%rax
    fc2a:	72 15                	jb     fc41 <tp_list_of+0x191>
    fc2c:	48 8b 3b             	mov    (%rbx),%rdi
    fc2f:	4c 01 f7             	add    %r14,%rdi
    fc32:	48 89 ee             	mov    %rbp,%rsi
    fc35:	4c 89 fa             	mov    %r15,%rdx
    fc38:	e8 33 37 ff ff       	call   3370 <bcmp@plt>
    fc3d:	85 c0                	test   %eax,%eax
    fc3f:	74 6a                	je     fcab <tp_list_of+0x1fb>
    fc41:	4d 39 f5             	cmp    %r14,%r13
    fc44:	76 2c                	jbe    fc72 <tp_list_of+0x1c2>
    fc46:	48 8b 03             	mov    (%rbx),%rax
    fc49:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    fc50:	42 0f b6 0c 30       	movzbl (%rax,%r14,1),%ecx
    fc55:	48 83 f9 20          	cmp    $0x20,%rcx
    fc59:	77 17                	ja     fc72 <tp_list_of+0x1c2>
    fc5b:	49 0f a3 cc          	bt     %rcx,%r12
    fc5f:	73 11                	jae    fc72 <tp_list_of+0x1c2>
    fc61:	49 ff c6             	inc    %r14
    fc64:	4c 89 73 10          	mov    %r14,0x10(%rbx)
    fc68:	4d 39 f5             	cmp    %r14,%r13
    fc6b:	75 e3                	jne    fc50 <tp_list_of+0x1a0>
    fc6d:	e9 d1 fe ff ff       	jmp    fb43 <tp_list_of+0x93>
    fc72:	4d 39 f5             	cmp    %r14,%r13
    fc75:	b8 00 00 00 00       	mov    $0x0,%eax
    fc7a:	0f 84 c5 fe ff ff    	je     fb45 <tp_list_of+0x95>
    fc80:	48 8b 0b             	mov    (%rbx),%rcx
    fc83:	42 80 3c 31 2c       	cmpb   $0x2c,(%rcx,%r14,1)
    fc88:	0f 85 b7 fe ff ff    	jne    fb45 <tp_list_of+0x95>
    fc8e:	49 ff c6             	inc    %r14
    fc91:	4c 89 73 10          	mov    %r14,0x10(%rbx)
    fc95:	e9 26 ff ff ff       	jmp    fbc0 <tp_list_of+0x110>
    fc9a:	4d 01 ef             	add    %r13,%r15
    fc9d:	4c 89 7b 10          	mov    %r15,0x10(%rbx)
    fca1:	b8 01 00 00 00       	mov    $0x1,%eax
    fca6:	e9 9a fe ff ff       	jmp    fb45 <tp_list_of+0x95>
    fcab:	4d 01 f7             	add    %r14,%r15
    fcae:	eb ed                	jmp    fc9d <tp_list_of+0x1ed>

000000000000fcb0 <tp_byte_item>:
    fcb0:	53                   	push   %rbx
    fcb1:	48 83 ec 10          	sub    $0x10,%rsp
    fcb5:	48 89 f3             	mov    %rsi,%rbx
    fcb8:	48 8d 35 41 a0 00 00 	lea    0xa041(%rip),%rsi        # 19d00 <tp_byte_item.u8d>
    fcbf:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    fcc4:	e8 97 f2 ff ff       	call   ef60 <tp_int>
    fcc9:	85 c0                	test   %eax,%eax
    fccb:	74 14                	je     fce1 <tp_byte_item+0x31>
    fccd:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    fcd2:	48 89 df             	mov    %rbx,%rdi
    fcd5:	e8 e6 07 00 00       	call   104c0 <tp_push>
    fcda:	b8 01 00 00 00       	mov    $0x1,%eax
    fcdf:	eb 02                	jmp    fce3 <tp_byte_item+0x33>
    fce1:	31 c0                	xor    %eax,%eax
    fce3:	48 83 c4 10          	add    $0x10,%rsp
    fce7:	5b                   	pop    %rbx
    fce8:	c3                   	ret
    fce9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000fcf0 <tp_token>:
    fcf0:	41 57                	push   %r15
    fcf2:	41 56                	push   %r14
    fcf4:	41 54                	push   %r12
    fcf6:	53                   	push   %rbx
    fcf7:	50                   	push   %rax
    fcf8:	49 89 f6             	mov    %rsi,%r14
    fcfb:	48 89 fb             	mov    %rdi,%rbx
    fcfe:	48 8b 37             	mov    (%rdi),%rsi
    fd01:	48 8b 47 08          	mov    0x8(%rdi),%rax
    fd05:	4c 8b 67 10          	mov    0x10(%rdi),%r12
    fd09:	49 39 c4             	cmp    %rax,%r12
    fd0c:	73 37                	jae    fd45 <tp_token+0x55>
    fd0e:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    fd15:	00 00 00 
    fd18:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    fd1f:	00 
    fd20:	42 0f b6 3c 26       	movzbl (%rsi,%r12,1),%edi
    fd25:	48 83 ff 20          	cmp    $0x20,%rdi
    fd29:	77 1a                	ja     fd45 <tp_token+0x55>
    fd2b:	48 0f a3 f9          	bt     %rdi,%rcx
    fd2f:	73 14                	jae    fd45 <tp_token+0x55>
    fd31:	49 ff c4             	inc    %r12
    fd34:	4c 89 63 10          	mov    %r12,0x10(%rbx)
    fd38:	4c 39 e0             	cmp    %r12,%rax
    fd3b:	75 e3                	jne    fd20 <tp_token+0x30>
    fd3d:	49 89 c4             	mov    %rax,%r12
    fd40:	48 89 c1             	mov    %rax,%rcx
    fd43:	eb 49                	jmp    fd8e <tp_token+0x9e>
    fd45:	49 39 c4             	cmp    %rax,%r12
    fd48:	73 41                	jae    fd8b <tp_token+0x9b>
    fd4a:	48 8d 3d fb 55 00 00 	lea    0x55fb(%rip),%rdi        # 1534c <_IO_stdin_used+0x34c>
    fd51:	4c 89 e1             	mov    %r12,%rcx
    fd54:	eb 1c                	jmp    fd72 <tp_token+0x82>
    fd56:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    fd5d:	00 00 00 
    fd60:	41 83 f8 7d          	cmp    $0x7d,%r8d
    fd64:	74 28                	je     fd8e <tp_token+0x9e>
    fd66:	48 ff c1             	inc    %rcx
    fd69:	48 89 4b 10          	mov    %rcx,0x10(%rbx)
    fd6d:	48 39 c8             	cmp    %rcx,%rax
    fd70:	74 ce                	je     fd40 <tp_token+0x50>
    fd72:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
    fd77:	45 8d 48 f7          	lea    -0x9(%r8),%r9d
    fd7b:	41 83 f9 54          	cmp    $0x54,%r9d
    fd7f:	77 df                	ja     fd60 <tp_token+0x70>
    fd81:	4e 63 04 8f          	movslq (%rdi,%r9,4),%r8
    fd85:	49 01 f8             	add    %rdi,%r8
    fd88:	41 ff e0             	jmp    *%r8
    fd8b:	4c 89 e1             	mov    %r12,%rcx
    fd8e:	4c 29 e1             	sub    %r12,%rcx
    fd91:	4c 8d 7a ff          	lea    -0x1(%rdx),%r15
    fd95:	48 39 d1             	cmp    %rdx,%rcx
    fd98:	4c 0f 42 f9          	cmovb  %rcx,%r15
    fd9c:	4c 01 e6             	add    %r12,%rsi
    fd9f:	4c 89 f7             	mov    %r14,%rdi
    fda2:	4c 89 fa             	mov    %r15,%rdx
    fda5:	e8 86 35 ff ff       	call   3330 <memcpy@plt>
    fdaa:	43 c6 04 3e 00       	movb   $0x0,(%r14,%r15,1)
    fdaf:	48 8b 43 10          	mov    0x10(%rbx),%rax
    fdb3:	4c 29 e0             	sub    %r12,%rax
    fdb6:	48 83 c4 08          	add    $0x8,%rsp
    fdba:	5b                   	pop    %rbx
    fdbb:	41 5c                	pop    %r12
    fdbd:	41 5e                	pop    %r14
    fdbf:	41 5f                	pop    %r15
    fdc1:	c3                   	ret
    fdc2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    fdc9:	1f 84 00 00 00 00 00 

000000000000fdd0 <tp_elem_item>:
    fdd0:	55                   	push   %rbp
    fdd1:	53                   	push   %rbx
    fdd2:	50                   	push   %rax
    fdd3:	48 89 f3             	mov    %rsi,%rbx
    fdd6:	48 8b 36             	mov    (%rsi),%rsi
    fdd9:	31 ed                	xor    %ebp,%ebp
    fddb:	48 89 e1             	mov    %rsp,%rcx
    fdde:	31 d2                	xor    %edx,%edx
    fde0:	e8 6b d9 ff ff       	call   d750 <tp_value>
    fde5:	85 c0                	test   %eax,%eax
    fde7:	74 11                	je     fdfa <tp_elem_item+0x2a>
    fde9:	48 8b 34 24          	mov    (%rsp),%rsi
    fded:	48 89 df             	mov    %rbx,%rdi
    fdf0:	e8 cb 06 00 00       	call   104c0 <tp_push>
    fdf5:	bd 01 00 00 00       	mov    $0x1,%ebp
    fdfa:	89 e8                	mov    %ebp,%eax
    fdfc:	48 83 c4 08          	add    $0x8,%rsp
    fe00:	5b                   	pop    %rbx
    fe01:	5d                   	pop    %rbp
    fe02:	c3                   	ret
    fe03:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    fe0a:	84 00 00 00 00 00 

000000000000fe10 <tp_kv_item>:
    fe10:	55                   	push   %rbp
    fe11:	41 56                	push   %r14
    fe13:	53                   	push   %rbx
    fe14:	48 83 ec 10          	sub    $0x10,%rsp
    fe18:	48 89 f3             	mov    %rsi,%rbx
    fe1b:	49 89 fe             	mov    %rdi,%r14
    fe1e:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
    fe25:	00 
    fe26:	48 8b 36             	mov    (%rsi),%rsi
    fe29:	31 ed                	xor    %ebp,%ebp
    fe2b:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    fe30:	31 d2                	xor    %edx,%edx
    fe32:	e8 19 d9 ff ff       	call   d750 <tp_value>
    fe37:	85 c0                	test   %eax,%eax
    fe39:	74 26                	je     fe61 <tp_kv_item+0x51>
    fe3b:	83 7b 28 00          	cmpl   $0x0,0x28(%rbx)
    fe3f:	74 2b                	je     fe6c <tp_kv_item+0x5c>
    fe41:	45 31 f6             	xor    %r14d,%r14d
    fe44:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    fe49:	48 89 df             	mov    %rbx,%rdi
    fe4c:	e8 6f 06 00 00       	call   104c0 <tp_push>
    fe51:	48 89 df             	mov    %rbx,%rdi
    fe54:	4c 89 f6             	mov    %r14,%rsi
    fe57:	e8 64 06 00 00       	call   104c0 <tp_push>
    fe5c:	bd 01 00 00 00       	mov    $0x1,%ebp
    fe61:	89 e8                	mov    %ebp,%eax
    fe63:	48 83 c4 10          	add    $0x10,%rsp
    fe67:	5b                   	pop    %rbx
    fe68:	41 5e                	pop    %r14
    fe6a:	5d                   	pop    %rbp
    fe6b:	c3                   	ret
    fe6c:	49 8b 4e 08          	mov    0x8(%r14),%rcx
    fe70:	49 8b 46 10          	mov    0x10(%r14),%rax
    fe74:	48 39 c8             	cmp    %rcx,%rax
    fe77:	73 37                	jae    feb0 <tp_kv_item+0xa0>
    fe79:	49 8b 16             	mov    (%r14),%rdx
    fe7c:	48 be 00 26 00 00 01 	movabs $0x100002600,%rsi
    fe83:	00 00 00 
    fe86:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    fe8d:	00 00 00 
    fe90:	0f b6 3c 02          	movzbl (%rdx,%rax,1),%edi
    fe94:	48 83 ff 20          	cmp    $0x20,%rdi
    fe98:	77 16                	ja     feb0 <tp_kv_item+0xa0>
    fe9a:	48 0f a3 fe          	bt     %rdi,%rsi
    fe9e:	73 10                	jae    feb0 <tp_kv_item+0xa0>
    fea0:	48 ff c0             	inc    %rax
    fea3:	49 89 46 10          	mov    %rax,0x10(%r14)
    fea7:	48 39 c1             	cmp    %rax,%rcx
    feaa:	75 e4                	jne    fe90 <tp_kv_item+0x80>
    feac:	31 ed                	xor    %ebp,%ebp
    feae:	eb b1                	jmp    fe61 <tp_kv_item+0x51>
    feb0:	31 ed                	xor    %ebp,%ebp
    feb2:	48 39 c1             	cmp    %rax,%rcx
    feb5:	74 aa                	je     fe61 <tp_kv_item+0x51>
    feb7:	49 8b 0e             	mov    (%r14),%rcx
    feba:	80 3c 01 3a          	cmpb   $0x3a,(%rcx,%rax,1)
    febe:	75 a1                	jne    fe61 <tp_kv_item+0x51>
    fec0:	48 ff c0             	inc    %rax
    fec3:	49 89 46 10          	mov    %rax,0x10(%r14)
    fec7:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    fecb:	31 ed                	xor    %ebp,%ebp
    fecd:	48 89 e1             	mov    %rsp,%rcx
    fed0:	4c 89 f7             	mov    %r14,%rdi
    fed3:	31 d2                	xor    %edx,%edx
    fed5:	e8 76 d8 ff ff       	call   d750 <tp_value>
    feda:	85 c0                	test   %eax,%eax
    fedc:	74 83                	je     fe61 <tp_kv_item+0x51>
    fede:	4c 8b 34 24          	mov    (%rsp),%r14
    fee2:	e9 5d ff ff ff       	jmp    fe44 <tp_kv_item+0x34>
    fee7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    feee:	00 00 

000000000000fef0 <fwp_p_map_insert>:
    fef0:	55                   	push   %rbp
    fef1:	41 57                	push   %r15
    fef3:	41 56                	push   %r14
    fef5:	41 55                	push   %r13
    fef7:	41 54                	push   %r12
    fef9:	53                   	push   %rbx
    fefa:	48 83 ec 28          	sub    $0x28,%rsp
    fefe:	49 89 d7             	mov    %rdx,%r15
    ff01:	49 89 f8             	mov    %rdi,%r8
    ff04:	48 8b 1a             	mov    (%rdx),%rbx
    ff07:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
    ff0c:	8b 01                	mov    (%rcx),%eax
    ff0e:	83 f8 04             	cmp    $0x4,%eax
    ff11:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
    ff16:	72 61                	jb     ff79 <fwp_p_map_insert+0x89>
    ff18:	83 c0 fb             	add    $0xfffffffb,%eax
    ff1b:	83 f8 04             	cmp    $0x4,%eax
    ff1e:	0f 83 b7 00 00 00    	jae    ffdb <fwp_p_map_insert+0xeb>
    ff24:	48 85 db             	test   %rbx,%rbx
    ff27:	0f 84 1d 01 00 00    	je     1004a <fwp_p_map_insert+0x15a>
    ff2d:	45 31 e4             	xor    %r12d,%r12d
    ff30:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    ff37:	ff ff 1f 
    ff3a:	48 89 d9             	mov    %rbx,%rcx
    ff3d:	eb 0d                	jmp    ff4c <fwp_p_map_insert+0x5c>
    ff3f:	90                   	nop
    ff40:	48 89 d1             	mov    %rdx,%rcx
    ff43:	49 39 cc             	cmp    %rcx,%r12
    ff46:	0f 83 04 01 00 00    	jae    10050 <fwp_p_map_insert+0x160>
    ff4c:	4a 8d 34 21          	lea    (%rcx,%r12,1),%rsi
    ff50:	48 89 f2             	mov    %rsi,%rdx
    ff53:	48 d1 ea             	shr    $1,%rdx
    ff56:	48 21 c6             	and    %rax,%rsi
    ff59:	49 8b 74 f7 08       	mov    0x8(%r15,%rsi,8),%rsi
    ff5e:	4c 39 c6             	cmp    %r8,%rsi
    ff61:	41 0f 95 c6          	setne  %r14b
    ff65:	74 6f                	je     ffd6 <fwp_p_map_insert+0xe6>
    ff67:	73 d7                	jae    ff40 <fwp_p_map_insert+0x50>
    ff69:	48 ff c2             	inc    %rdx
    ff6c:	49 89 d4             	mov    %rdx,%r12
    ff6f:	49 39 cc             	cmp    %rcx,%r12
    ff72:	72 d8                	jb     ff4c <fwp_p_map_insert+0x5c>
    ff74:	e9 d7 00 00 00       	jmp    10050 <fwp_p_map_insert+0x160>
    ff79:	48 85 db             	test   %rbx,%rbx
    ff7c:	0f 84 c8 00 00 00    	je     1004a <fwp_p_map_insert+0x15a>
    ff82:	45 31 e4             	xor    %r12d,%r12d
    ff85:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    ff8c:	ff ff 1f 
    ff8f:	48 89 d9             	mov    %rbx,%rcx
    ff92:	eb 18                	jmp    ffac <fwp_p_map_insert+0xbc>
    ff94:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    ff9b:	00 00 00 00 00 
    ffa0:	48 89 d1             	mov    %rdx,%rcx
    ffa3:	49 39 cc             	cmp    %rcx,%r12
    ffa6:	0f 83 a4 00 00 00    	jae    10050 <fwp_p_map_insert+0x160>
    ffac:	4a 8d 34 21          	lea    (%rcx,%r12,1),%rsi
    ffb0:	48 89 f2             	mov    %rsi,%rdx
    ffb3:	48 d1 ea             	shr    $1,%rdx
    ffb6:	48 21 c6             	and    %rax,%rsi
    ffb9:	49 8b 74 f7 08       	mov    0x8(%r15,%rsi,8),%rsi
    ffbe:	4c 39 c6             	cmp    %r8,%rsi
    ffc1:	41 0f 95 c6          	setne  %r14b
    ffc5:	74 0f                	je     ffd6 <fwp_p_map_insert+0xe6>
    ffc7:	7d d7                	jge    ffa0 <fwp_p_map_insert+0xb0>
    ffc9:	48 ff c2             	inc    %rdx
    ffcc:	49 89 d4             	mov    %rdx,%r12
    ffcf:	49 39 cc             	cmp    %rcx,%r12
    ffd2:	72 d8                	jb     ffac <fwp_p_map_insert+0xbc>
    ffd4:	eb 7a                	jmp    10050 <fwp_p_map_insert+0x160>
    ffd6:	49 89 d4             	mov    %rdx,%r12
    ffd9:	eb 75                	jmp    10050 <fwp_p_map_insert+0x160>
    ffdb:	48 85 db             	test   %rbx,%rbx
    ffde:	74 6a                	je     1004a <fwp_p_map_insert+0x15a>
    ffe0:	45 31 e4             	xor    %r12d,%r12d
    ffe3:	48 89 d8             	mov    %rbx,%rax
    ffe6:	48 89 5c 24 08       	mov    %rbx,0x8(%rsp)
    ffeb:	eb 13                	jmp    10000 <fwp_p_map_insert+0x110>
    ffed:	0f 1f 00             	nopl   (%rax)
    fff0:	48 89 d8             	mov    %rbx,%rax
    fff3:	49 89 e8             	mov    %rbp,%r8
    fff6:	49 39 c4             	cmp    %rax,%r12
    fff9:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    fffe:	73 50                	jae    10050 <fwp_p_map_insert+0x160>
   10000:	49 89 c5             	mov    %rax,%r13
   10003:	4c 01 e0             	add    %r12,%rax
   10006:	48 89 c3             	mov    %rax,%rbx
   10009:	48 d1 eb             	shr    $1,%rbx
   1000c:	48 b9 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rcx
   10013:	ff ff 1f 
   10016:	48 21 c8             	and    %rcx,%rax
   10019:	49 8b 7c c7 08       	mov    0x8(%r15,%rax,8),%rdi
   1001e:	4c 89 c5             	mov    %r8,%rbp
   10021:	4c 89 c6             	mov    %r8,%rsi
   10024:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
   10029:	e8 d2 05 00 00       	call   10600 <fwp_cmp>
   1002e:	85 c0                	test   %eax,%eax
   10030:	41 0f 95 c6          	setne  %r14b
   10034:	0f 84 5b 01 00 00    	je     10195 <fwp_p_map_insert+0x2a5>
   1003a:	79 b4                	jns    fff0 <fwp_p_map_insert+0x100>
   1003c:	48 ff c3             	inc    %rbx
   1003f:	49 89 dc             	mov    %rbx,%r12
   10042:	49 89 e8             	mov    %rbp,%r8
   10045:	4c 89 e8             	mov    %r13,%rax
   10048:	eb ac                	jmp    fff6 <fwp_p_map_insert+0x106>
   1004a:	41 b6 01             	mov    $0x1,%r14b
   1004d:	45 31 e4             	xor    %r12d,%r12d
   10050:	41 0f b6 ee          	movzbl %r14b,%ebp
   10054:	48 01 dd             	add    %rbx,%rbp
   10057:	48 89 e9             	mov    %rbp,%rcx
   1005a:	48 c1 e1 04          	shl    $0x4,%rcx
   1005e:	48 8d 79 08          	lea    0x8(%rcx),%rdi
   10062:	48 ff 05 3f be 00 00 	incq   0xbe3f(%rip)        # 1bea8 <measured_calls>
   10069:	48 01 3d 40 be 00 00 	add    %rdi,0xbe40(%rip)        # 1beb0 <measured_bytes>
   10070:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
   10077:	4c 89 44 24 18       	mov    %r8,0x18(%rsp)
   1007c:	77 62                	ja     100e0 <fwp_p_map_insert+0x1f0>
   1007e:	48 83 c1 17          	add    $0x17,%rcx
   10082:	48 c1 e9 04          	shr    $0x4,%rcx
   10086:	48 8d 05 fb a1 00 00 	lea    0xa1fb(%rip),%rax        # 1a288 <fwp_gc>
   1008d:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
   10094:	00 
   10095:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
   1009c:	48 29 15 e5 a1 00 00 	sub    %rdx,0xa1e5(%rip)        # 1a288 <fwp_gc>
   100a3:	78 3b                	js     100e0 <fwp_p_map_insert+0x1f0>
   100a5:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
   100a9:	48 8d 34 c8          	lea    (%rax,%rcx,8),%rsi
   100ad:	48 81 c6 88 07 00 00 	add    $0x788,%rsi
   100b4:	4c 8b 2e             	mov    (%rsi),%r13
   100b7:	4d 85 ed             	test   %r13,%r13
   100ba:	74 0c                	je     100c8 <fwp_p_map_insert+0x1d8>
   100bc:	49 8b 45 00          	mov    0x0(%r13),%rax
   100c0:	48 f7 d0             	not    %rax
   100c3:	48 89 06             	mov    %rax,(%rsi)
   100c6:	eb 38                	jmp    10100 <fwp_p_map_insert+0x210>
   100c8:	4c 8b ac c8 90 07 00 	mov    0x790(%rax,%rcx,8),%r13
   100cf:	00 
   100d0:	48 8b b4 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%rsi
   100d7:	00 
   100d8:	4c 29 ee             	sub    %r13,%rsi
   100db:	48 39 d6             	cmp    %rdx,%rsi
   100de:	73 0f                	jae    100ef <fwp_p_map_insert+0x1ff>
   100e0:	be 02 00 00 00       	mov    $0x2,%esi
   100e5:	e8 d6 81 ff ff       	call   82c0 <fwp_gc_alloc_slow>
   100ea:	49 89 c5             	mov    %rax,%r13
   100ed:	eb 1b                	jmp    1010a <fwp_p_map_insert+0x21a>
   100ef:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
   100f3:	48 05 90 07 00 00    	add    $0x790,%rax
   100f9:	4a 8d 0c 2a          	lea    (%rdx,%r13,1),%rcx
   100fd:	48 89 08             	mov    %rcx,(%rax)
   10100:	4c 89 ef             	mov    %r13,%rdi
   10103:	31 f6                	xor    %esi,%esi
   10105:	e8 06 31 ff ff       	call   3210 <memset@plt>
   1010a:	49 89 6d 00          	mov    %rbp,0x0(%r13)
   1010e:	49 8d 6d 08          	lea    0x8(%r13),%rbp
   10112:	49 83 c7 08          	add    $0x8,%r15
   10116:	45 84 f6             	test   %r14b,%r14b
   10119:	74 48                	je     10163 <fwp_p_map_insert+0x273>
   1011b:	4d 89 e6             	mov    %r12,%r14
   1011e:	49 c1 e6 04          	shl    $0x4,%r14
   10122:	48 89 ef             	mov    %rbp,%rdi
   10125:	4c 89 fe             	mov    %r15,%rsi
   10128:	4c 89 f2             	mov    %r14,%rdx
   1012b:	e8 00 32 ff ff       	call   3330 <memcpy@plt>
   10130:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
   10135:	4b 89 44 35 08       	mov    %rax,0x8(%r13,%r14,1)
   1013a:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
   1013f:	4b 89 44 35 10       	mov    %rax,0x10(%r13,%r14,1)
   10144:	49 8d 3c 2e          	lea    (%r14,%rbp,1),%rdi
   10148:	48 83 c7 10          	add    $0x10,%rdi
   1014c:	4d 01 fe             	add    %r15,%r14
   1014f:	4c 29 e3             	sub    %r12,%rbx
   10152:	48 c1 e3 04          	shl    $0x4,%rbx
   10156:	4c 89 f6             	mov    %r14,%rsi
   10159:	48 89 da             	mov    %rbx,%rdx
   1015c:	e8 cf 31 ff ff       	call   3330 <memcpy@plt>
   10161:	eb 20                	jmp    10183 <fwp_p_map_insert+0x293>
   10163:	48 c1 e3 04          	shl    $0x4,%rbx
   10167:	48 89 ef             	mov    %rbp,%rdi
   1016a:	4c 89 fe             	mov    %r15,%rsi
   1016d:	48 89 da             	mov    %rbx,%rdx
   10170:	e8 bb 31 ff ff       	call   3330 <memcpy@plt>
   10175:	49 c1 e4 04          	shl    $0x4,%r12
   10179:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
   1017e:	4b 89 44 25 10       	mov    %rax,0x10(%r13,%r12,1)
   10183:	4c 89 e8             	mov    %r13,%rax
   10186:	48 83 c4 28          	add    $0x28,%rsp
   1018a:	5b                   	pop    %rbx
   1018b:	41 5c                	pop    %r12
   1018d:	41 5d                	pop    %r13
   1018f:	41 5e                	pop    %r14
   10191:	41 5f                	pop    %r15
   10193:	5d                   	pop    %rbp
   10194:	c3                   	ret
   10195:	49 89 dc             	mov    %rbx,%r12
   10198:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
   1019d:	49 89 e8             	mov    %rbp,%r8
   101a0:	e9 ab fe ff ff       	jmp    10050 <fwp_p_map_insert+0x160>
   101a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   101ac:	00 00 00 00 

00000000000101b0 <fwp_record>:
   101b0:	85 ff                	test   %edi,%edi
   101b2:	0f 84 aa 00 00 00    	je     10262 <fwp_record+0xb2>
   101b8:	55                   	push   %rbp
   101b9:	41 56                	push   %r14
   101bb:	53                   	push   %rbx
   101bc:	48 89 f3             	mov    %rsi,%rbx
   101bf:	41 89 fe             	mov    %edi,%r14d
   101c2:	4a 8d 04 f5 08 00 00 	lea    0x8(,%r14,8),%rax
   101c9:	00 
   101ca:	89 fd                	mov    %edi,%ebp
   101cc:	48 89 c7             	mov    %rax,%rdi
   101cf:	e8 0c a6 ff ff       	call   a7e0 <fwp_alloc_init>
   101d4:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   101da:	89 68 04             	mov    %ebp,0x4(%rax)
   101dd:	83 fd 08             	cmp    $0x8,%ebp
   101e0:	72 10                	jb     101f2 <fwp_record+0x42>
   101e2:	48 89 c1             	mov    %rax,%rcx
   101e5:	48 29 d9             	sub    %rbx,%rcx
   101e8:	48 83 c1 08          	add    $0x8,%rcx
   101ec:	48 83 f9 20          	cmp    $0x20,%rcx
   101f0:	73 73                	jae    10265 <fwp_record+0xb5>
   101f2:	31 c9                	xor    %ecx,%ecx
   101f4:	4c 89 f6             	mov    %r14,%rsi
   101f7:	48 89 ca             	mov    %rcx,%rdx
   101fa:	48 83 e6 03          	and    $0x3,%rsi
   101fe:	74 21                	je     10221 <fwp_record+0x71>
   10200:	48 89 ca             	mov    %rcx,%rdx
   10203:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   1020a:	84 00 00 00 00 00 
   10210:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
   10214:	48 89 7c d0 08       	mov    %rdi,0x8(%rax,%rdx,8)
   10219:	48 ff c2             	inc    %rdx
   1021c:	48 ff ce             	dec    %rsi
   1021f:	75 ef                	jne    10210 <fwp_record+0x60>
   10221:	4c 29 f1             	sub    %r14,%rcx
   10224:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
   10228:	77 7b                	ja     102a5 <fwp_record+0xf5>
   1022a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   10230:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
   10234:	48 89 4c d0 08       	mov    %rcx,0x8(%rax,%rdx,8)
   10239:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
   1023e:	48 89 4c d0 10       	mov    %rcx,0x10(%rax,%rdx,8)
   10243:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
   10248:	48 89 4c d0 18       	mov    %rcx,0x18(%rax,%rdx,8)
   1024d:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
   10252:	48 89 4c d0 20       	mov    %rcx,0x20(%rax,%rdx,8)
   10257:	48 83 c2 04          	add    $0x4,%rdx
   1025b:	49 39 d6             	cmp    %rdx,%r14
   1025e:	75 d0                	jne    10230 <fwp_record+0x80>
   10260:	eb 43                	jmp    102a5 <fwp_record+0xf5>
   10262:	31 c0                	xor    %eax,%eax
   10264:	c3                   	ret
   10265:	44 89 f1             	mov    %r14d,%ecx
   10268:	83 e1 fc             	and    $0xfffffffc,%ecx
   1026b:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
   10272:	00 
   10273:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
   10277:	31 f6                	xor    %esi,%esi
   10279:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   10280:	0f 10 04 33          	movups (%rbx,%rsi,1),%xmm0
   10284:	0f 10 4c 33 10       	movups 0x10(%rbx,%rsi,1),%xmm1
   10289:	0f 11 44 30 08       	movups %xmm0,0x8(%rax,%rsi,1)
   1028e:	0f 11 4c 30 18       	movups %xmm1,0x18(%rax,%rsi,1)
   10293:	48 83 c6 20          	add    $0x20,%rsi
   10297:	48 39 f2             	cmp    %rsi,%rdx
   1029a:	75 e4                	jne    10280 <fwp_record+0xd0>
   1029c:	4c 39 f1             	cmp    %r14,%rcx
   1029f:	0f 85 4f ff ff ff    	jne    101f4 <fwp_record+0x44>
   102a5:	5b                   	pop    %rbx
   102a6:	41 5e                	pop    %r14
   102a8:	5d                   	pop    %rbp
   102a9:	c3                   	ret
   102aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000102b0 <fwp_box_u128>:
   102b0:	41 56                	push   %r14
   102b2:	53                   	push   %rbx
   102b3:	50                   	push   %rax
   102b4:	48 ff 05 ed bb 00 00 	incq   0xbbed(%rip)        # 1bea8 <measured_calls>
   102bb:	48 83 05 ed bb 00 00 	addq   $0x10,0xbbed(%rip)        # 1beb0 <measured_bytes>
   102c2:	10 
   102c3:	48 8d 0d be 9f 00 00 	lea    0x9fbe(%rip),%rcx        # 1a288 <fwp_gc>
   102ca:	0f b6 05 a0 ab 00 00 	movzbl 0xaba0(%rip),%eax        # 1ae71 <fwp_gc+0xbe9>
   102d1:	8b 94 81 48 0b 00 00 	mov    0xb48(%rcx,%rax,4),%edx
   102d8:	48 29 15 a9 9f 00 00 	sub    %rdx,0x9fa9(%rip)        # 1a288 <fwp_gc>
   102df:	78 3a                	js     1031b <fwp_box_u128+0x6b>
   102e1:	4c 8d 04 40          	lea    (%rax,%rax,2),%r8
   102e5:	4e 8d 0c c1          	lea    (%rcx,%r8,8),%r9
   102e9:	49 81 c1 c8 03 00 00 	add    $0x3c8,%r9
   102f0:	49 8b 01             	mov    (%r9),%rax
   102f3:	48 85 c0             	test   %rax,%rax
   102f6:	74 0b                	je     10303 <fwp_box_u128+0x53>
   102f8:	48 8b 08             	mov    (%rax),%rcx
   102fb:	48 f7 d1             	not    %rcx
   102fe:	49 89 09             	mov    %rcx,(%r9)
   10301:	eb 46                	jmp    10349 <fwp_box_u128+0x99>
   10303:	4a 8b 84 c1 d0 03 00 	mov    0x3d0(%rcx,%r8,8),%rax
   1030a:	00 
   1030b:	4e 8b 8c c1 d8 03 00 	mov    0x3d8(%rcx,%r8,8),%r9
   10312:	00 
   10313:	49 29 c1             	sub    %rax,%r9
   10316:	49 39 d1             	cmp    %rdx,%r9
   10319:	73 1d                	jae    10338 <fwp_box_u128+0x88>
   1031b:	48 89 fb             	mov    %rdi,%rbx
   1031e:	bf 10 00 00 00       	mov    $0x10,%edi
   10323:	49 89 f6             	mov    %rsi,%r14
   10326:	be 01 00 00 00       	mov    $0x1,%esi
   1032b:	e8 90 7f ff ff       	call   82c0 <fwp_gc_alloc_slow>
   10330:	4c 89 f6             	mov    %r14,%rsi
   10333:	48 89 df             	mov    %rbx,%rdi
   10336:	eb 17                	jmp    1034f <fwp_box_u128+0x9f>
   10338:	4a 8d 0c c1          	lea    (%rcx,%r8,8),%rcx
   1033c:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
   10343:	48 01 c2             	add    %rax,%rdx
   10346:	48 89 11             	mov    %rdx,(%rcx)
   10349:	0f 57 c0             	xorps  %xmm0,%xmm0
   1034c:	0f 11 00             	movups %xmm0,(%rax)
   1034f:	48 89 70 08          	mov    %rsi,0x8(%rax)
   10353:	48 89 38             	mov    %rdi,(%rax)
   10356:	48 83 c4 08          	add    $0x8,%rsp
   1035a:	5b                   	pop    %rbx
   1035b:	41 5e                	pop    %r14
   1035d:	c3                   	ret
   1035e:	66 90                	xchg   %ax,%ax

0000000000010360 <fwp_box_i128>:
   10360:	41 56                	push   %r14
   10362:	53                   	push   %rbx
   10363:	50                   	push   %rax
   10364:	48 ff 05 3d bb 00 00 	incq   0xbb3d(%rip)        # 1bea8 <measured_calls>
   1036b:	48 83 05 3d bb 00 00 	addq   $0x10,0xbb3d(%rip)        # 1beb0 <measured_bytes>
   10372:	10 
   10373:	48 8d 0d 0e 9f 00 00 	lea    0x9f0e(%rip),%rcx        # 1a288 <fwp_gc>
   1037a:	0f b6 05 f0 aa 00 00 	movzbl 0xaaf0(%rip),%eax        # 1ae71 <fwp_gc+0xbe9>
   10381:	8b 94 81 48 0b 00 00 	mov    0xb48(%rcx,%rax,4),%edx
   10388:	48 29 15 f9 9e 00 00 	sub    %rdx,0x9ef9(%rip)        # 1a288 <fwp_gc>
   1038f:	78 3a                	js     103cb <fwp_box_i128+0x6b>
   10391:	4c 8d 04 40          	lea    (%rax,%rax,2),%r8
   10395:	4e 8d 0c c1          	lea    (%rcx,%r8,8),%r9
   10399:	49 81 c1 c8 03 00 00 	add    $0x3c8,%r9
   103a0:	49 8b 01             	mov    (%r9),%rax
   103a3:	48 85 c0             	test   %rax,%rax
   103a6:	74 0b                	je     103b3 <fwp_box_i128+0x53>
   103a8:	48 8b 08             	mov    (%rax),%rcx
   103ab:	48 f7 d1             	not    %rcx
   103ae:	49 89 09             	mov    %rcx,(%r9)
   103b1:	eb 46                	jmp    103f9 <fwp_box_i128+0x99>
   103b3:	4a 8b 84 c1 d0 03 00 	mov    0x3d0(%rcx,%r8,8),%rax
   103ba:	00 
   103bb:	4e 8b 8c c1 d8 03 00 	mov    0x3d8(%rcx,%r8,8),%r9
   103c2:	00 
   103c3:	49 29 c1             	sub    %rax,%r9
   103c6:	49 39 d1             	cmp    %rdx,%r9
   103c9:	73 1d                	jae    103e8 <fwp_box_i128+0x88>
   103cb:	48 89 fb             	mov    %rdi,%rbx
   103ce:	bf 10 00 00 00       	mov    $0x10,%edi
   103d3:	49 89 f6             	mov    %rsi,%r14
   103d6:	be 01 00 00 00       	mov    $0x1,%esi
   103db:	e8 e0 7e ff ff       	call   82c0 <fwp_gc_alloc_slow>
   103e0:	4c 89 f6             	mov    %r14,%rsi
   103e3:	48 89 df             	mov    %rbx,%rdi
   103e6:	eb 17                	jmp    103ff <fwp_box_i128+0x9f>
   103e8:	4a 8d 0c c1          	lea    (%rcx,%r8,8),%rcx
   103ec:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
   103f3:	48 01 c2             	add    %rax,%rdx
   103f6:	48 89 11             	mov    %rdx,(%rcx)
   103f9:	0f 57 c0             	xorps  %xmm0,%xmm0
   103fc:	0f 11 00             	movups %xmm0,(%rax)
   103ff:	48 89 70 08          	mov    %rsi,0x8(%rax)
   10403:	48 89 38             	mov    %rdi,(%rax)
   10406:	48 83 c4 08          	add    $0x8,%rsp
   1040a:	5b                   	pop    %rbx
   1040b:	41 5e                	pop    %r14
   1040d:	c3                   	ret
   1040e:	66 90                	xchg   %ax,%ax

0000000000010410 <fwp_utf8_put>:
   10410:	50                   	push   %rax
   10411:	83 fe 7f             	cmp    $0x7f,%esi
   10414:	77 0f                	ja     10425 <fwp_utf8_put+0x15>
   10416:	40 88 74 24 04       	mov    %sil,0x4(%rsp)
   1041b:	ba 01 00 00 00       	mov    $0x1,%edx
   10420:	e9 8e 00 00 00       	jmp    104b3 <fwp_utf8_put+0xa3>
   10425:	89 f0                	mov    %esi,%eax
   10427:	81 fe ff 07 00 00    	cmp    $0x7ff,%esi
   1042d:	77 1d                	ja     1044c <fwp_utf8_put+0x3c>
   1042f:	c1 e8 06             	shr    $0x6,%eax
   10432:	0c c0                	or     $0xc0,%al
   10434:	88 44 24 04          	mov    %al,0x4(%rsp)
   10438:	40 80 e6 3f          	and    $0x3f,%sil
   1043c:	40 80 ce 80          	or     $0x80,%sil
   10440:	40 88 74 24 05       	mov    %sil,0x5(%rsp)
   10445:	ba 02 00 00 00       	mov    $0x2,%edx
   1044a:	eb 67                	jmp    104b3 <fwp_utf8_put+0xa3>
   1044c:	81 fe ff ff 00 00    	cmp    $0xffff,%esi
   10452:	77 2a                	ja     1047e <fwp_utf8_put+0x6e>
   10454:	c1 e8 0c             	shr    $0xc,%eax
   10457:	0c e0                	or     $0xe0,%al
   10459:	88 44 24 04          	mov    %al,0x4(%rsp)
   1045d:	89 f0                	mov    %esi,%eax
   1045f:	c1 e8 06             	shr    $0x6,%eax
   10462:	24 3f                	and    $0x3f,%al
   10464:	0c 80                	or     $0x80,%al
   10466:	88 44 24 05          	mov    %al,0x5(%rsp)
   1046a:	40 80 e6 3f          	and    $0x3f,%sil
   1046e:	40 80 ce 80          	or     $0x80,%sil
   10472:	40 88 74 24 06       	mov    %sil,0x6(%rsp)
   10477:	ba 03 00 00 00       	mov    $0x3,%edx
   1047c:	eb 35                	jmp    104b3 <fwp_utf8_put+0xa3>
   1047e:	c1 e8 12             	shr    $0x12,%eax
   10481:	0c f0                	or     $0xf0,%al
   10483:	88 44 24 04          	mov    %al,0x4(%rsp)
   10487:	89 f0                	mov    %esi,%eax
   10489:	c1 e8 0c             	shr    $0xc,%eax
   1048c:	24 3f                	and    $0x3f,%al
   1048e:	0c 80                	or     $0x80,%al
   10490:	88 44 24 05          	mov    %al,0x5(%rsp)
   10494:	89 f0                	mov    %esi,%eax
   10496:	c1 e8 06             	shr    $0x6,%eax
   10499:	24 3f                	and    $0x3f,%al
   1049b:	0c 80                	or     $0x80,%al
   1049d:	88 44 24 06          	mov    %al,0x6(%rsp)
   104a1:	40 80 e6 3f          	and    $0x3f,%sil
   104a5:	40 80 ce 80          	or     $0x80,%sil
   104a9:	40 88 74 24 07       	mov    %sil,0x7(%rsp)
   104ae:	ba 04 00 00 00       	mov    $0x4,%edx
   104b3:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
   104b8:	e8 53 cd ff ff       	call   d210 <buf_put>
   104bd:	58                   	pop    %rax
   104be:	c3                   	ret
   104bf:	90                   	nop

00000000000104c0 <tp_push>:
   104c0:	55                   	push   %rbp
   104c1:	41 57                	push   %r15
   104c3:	41 56                	push   %r14
   104c5:	41 55                	push   %r13
   104c7:	41 54                	push   %r12
   104c9:	53                   	push   %rbx
   104ca:	50                   	push   %rax
   104cb:	48 89 f3             	mov    %rsi,%rbx
   104ce:	49 89 fe             	mov    %rdi,%r14
   104d1:	4c 8b 7f 18          	mov    0x18(%rdi),%r15
   104d5:	4c 3b 7f 20          	cmp    0x20(%rdi),%r15
   104d9:	75 7d                	jne    10558 <tp_push+0x98>
   104db:	4b 8d 04 3f          	lea    (%r15,%r15,1),%rax
   104df:	4d 85 ff             	test   %r15,%r15
   104e2:	41 bd 08 00 00 00    	mov    $0x8,%r13d
   104e8:	4c 0f 45 e8          	cmovne %rax,%r13
   104ec:	4d 89 6e 20          	mov    %r13,0x20(%r14)
   104f0:	4d 8b 66 10          	mov    0x10(%r14),%r12
   104f4:	49 c1 e5 03          	shl    $0x3,%r13
   104f8:	48 ff 05 a9 b9 00 00 	incq   0xb9a9(%rip)        # 1bea8 <measured_calls>
   104ff:	4c 01 2d aa b9 00 00 	add    %r13,0xb9aa(%rip)        # 1beb0 <measured_bytes>
   10506:	49 81 fd 00 40 00 00 	cmp    $0x4000,%r13
   1050d:	77 67                	ja     10576 <tp_push+0xb6>
   1050f:	4c 89 e9             	mov    %r13,%rcx
   10512:	48 c1 e9 04          	shr    $0x4,%rcx
   10516:	48 8d 05 6b 9d 00 00 	lea    0x9d6b(%rip),%rax        # 1a288 <fwp_gc>
   1051d:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
   10524:	00 
   10525:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
   1052c:	48 29 15 55 9d 00 00 	sub    %rdx,0x9d55(%rip)        # 1a288 <fwp_gc>
   10533:	78 41                	js     10576 <tp_push+0xb6>
   10535:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
   10539:	48 8d 34 c8          	lea    (%rax,%rcx,8),%rsi
   1053d:	48 81 c6 88 07 00 00 	add    $0x788,%rsi
   10544:	48 8b 2e             	mov    (%rsi),%rbp
   10547:	48 85 ed             	test   %rbp,%rbp
   1054a:	74 12                	je     1055e <tp_push+0x9e>
   1054c:	48 8b 45 00          	mov    0x0(%rbp),%rax
   10550:	48 f7 d0             	not    %rax
   10553:	48 89 06             	mov    %rax,(%rsi)
   10556:	eb 46                	jmp    1059e <tp_push+0xde>
   10558:	49 8b 6e 10          	mov    0x10(%r14),%rbp
   1055c:	eb 78                	jmp    105d6 <tp_push+0x116>
   1055e:	48 8b ac c8 90 07 00 	mov    0x790(%rax,%rcx,8),%rbp
   10565:	00 
   10566:	48 8b b4 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%rsi
   1056d:	00 
   1056e:	48 29 ee             	sub    %rbp,%rsi
   10571:	48 39 d6             	cmp    %rdx,%rsi
   10574:	73 17                	jae    1058d <tp_push+0xcd>
   10576:	4c 89 ef             	mov    %r13,%rdi
   10579:	be 02 00 00 00       	mov    $0x2,%esi
   1057e:	e8 3d 7d ff ff       	call   82c0 <fwp_gc_alloc_slow>
   10583:	48 89 c5             	mov    %rax,%rbp
   10586:	4d 85 e4             	test   %r12,%r12
   10589:	75 22                	jne    105ad <tp_push+0xed>
   1058b:	eb 41                	jmp    105ce <tp_push+0x10e>
   1058d:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
   10591:	48 05 90 07 00 00    	add    $0x790,%rax
   10597:	48 8d 0c 2a          	lea    (%rdx,%rbp,1),%rcx
   1059b:	48 89 08             	mov    %rcx,(%rax)
   1059e:	48 89 ef             	mov    %rbp,%rdi
   105a1:	31 f6                	xor    %esi,%esi
   105a3:	e8 68 2c ff ff       	call   3210 <memset@plt>
   105a8:	4d 85 e4             	test   %r12,%r12
   105ab:	74 21                	je     105ce <tp_push+0x10e>
   105ad:	49 c1 e7 03          	shl    $0x3,%r15
   105b1:	4d 39 ef             	cmp    %r13,%r15
   105b4:	4d 0f 43 fd          	cmovae %r13,%r15
   105b8:	48 89 ef             	mov    %rbp,%rdi
   105bb:	4c 89 e6             	mov    %r12,%rsi
   105be:	4c 89 fa             	mov    %r15,%rdx
   105c1:	e8 6a 2d ff ff       	call   3330 <memcpy@plt>
   105c6:	4c 89 e7             	mov    %r12,%rdi
   105c9:	e8 52 a5 ff ff       	call   ab20 <fwp_mem_free>
   105ce:	49 89 6e 10          	mov    %rbp,0x10(%r14)
   105d2:	4d 8b 7e 18          	mov    0x18(%r14),%r15
   105d6:	49 8d 47 01          	lea    0x1(%r15),%rax
   105da:	49 89 46 18          	mov    %rax,0x18(%r14)
   105de:	4a 89 5c fd 00       	mov    %rbx,0x0(%rbp,%r15,8)
   105e3:	48 83 c4 08          	add    $0x8,%rsp
   105e7:	5b                   	pop    %rbx
   105e8:	41 5c                	pop    %r12
   105ea:	41 5d                	pop    %r13
   105ec:	41 5e                	pop    %r14
   105ee:	41 5f                	pop    %r15
   105f0:	5d                   	pop    %rbp
   105f1:	c3                   	ret
   105f2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   105f9:	1f 84 00 00 00 00 00 

0000000000010600 <fwp_cmp>:
   10600:	55                   	push   %rbp
   10601:	41 57                	push   %r15
   10603:	41 56                	push   %r14
   10605:	41 55                	push   %r13
   10607:	41 54                	push   %r12
   10609:	53                   	push   %rbx
   1060a:	48 83 ec 28          	sub    $0x28,%rsp
   1060e:	48 89 f3             	mov    %rsi,%rbx
   10611:	49 89 fe             	mov    %rdi,%r14
   10614:	44 8b 2a             	mov    (%rdx),%r13d
   10617:	49 83 fd 15          	cmp    $0x15,%r13
   1061b:	77 25                	ja     10642 <fwp_cmp+0x42>
   1061d:	49 89 d7             	mov    %rdx,%r15
   10620:	48 8d 05 79 4e 00 00 	lea    0x4e79(%rip),%rax        # 154a0 <_IO_stdin_used+0x4a0>
   10627:	4a 63 0c a8          	movslq (%rax,%r13,4),%rcx
   1062b:	48 01 c1             	add    %rax,%rcx
   1062e:	ff e1                	jmp    *%rcx
   10630:	31 c9                	xor    %ecx,%ecx
   10632:	49 39 de             	cmp    %rbx,%r14
   10635:	0f 9f c1             	setg   %cl
   10638:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   1063d:	0f 4d c1             	cmovge %ecx,%eax
   10640:	eb 10                	jmp    10652 <fwp_cmp+0x52>
   10642:	31 c9                	xor    %ecx,%ecx
   10644:	49 39 de             	cmp    %rbx,%r14
   10647:	0f 97 c1             	seta   %cl
   1064a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   1064f:	0f 43 c1             	cmovae %ecx,%eax
   10652:	48 83 c4 28          	add    $0x28,%rsp
   10656:	5b                   	pop    %rbx
   10657:	41 5c                	pop    %r12
   10659:	41 5d                	pop    %r13
   1065b:	41 5e                	pop    %r14
   1065d:	41 5f                	pop    %r15
   1065f:	5d                   	pop    %rbp
   10660:	c3                   	ret
   10661:	4d 8b 3e             	mov    (%r14),%r15
   10664:	4c 8b 23             	mov    (%rbx),%r12
   10667:	49 83 c6 08          	add    $0x8,%r14
   1066b:	48 83 c3 08          	add    $0x8,%rbx
   1066f:	4d 39 e7             	cmp    %r12,%r15
   10672:	4c 89 e2             	mov    %r12,%rdx
   10675:	49 0f 42 d7          	cmovb  %r15,%rdx
   10679:	4c 89 f7             	mov    %r14,%rdi
   1067c:	48 89 de             	mov    %rbx,%rsi
   1067f:	e8 ec 2b ff ff       	call   3270 <memcmp@plt>
   10684:	85 c0                	test   %eax,%eax
   10686:	0f 84 bb 03 00 00    	je     10a47 <fwp_cmp+0x447>
   1068c:	c1 f8 1f             	sar    $0x1f,%eax
   1068f:	83 c8 01             	or     $0x1,%eax
   10692:	eb be                	jmp    10652 <fwp_cmp+0x52>
   10694:	49 8b 06             	mov    (%r14),%rax
   10697:	48 8b 2b             	mov    (%rbx),%rbp
   1069a:	48 39 e8             	cmp    %rbp,%rax
   1069d:	48 89 2c 24          	mov    %rbp,(%rsp)
   106a1:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
   106a6:	48 0f 42 e8          	cmovb  %rax,%rbp
   106aa:	48 85 ed             	test   %rbp,%rbp
   106ad:	74 56                	je     10705 <fwp_cmp+0x105>
   106af:	49 8b 47 38          	mov    0x38(%r15),%rax
   106b3:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
   106b8:	41 bc 10 00 00 00    	mov    $0x10,%r12d
   106be:	eb 09                	jmp    106c9 <fwp_cmp+0xc9>
   106c0:	49 83 c4 10          	add    $0x10,%r12
   106c4:	48 ff cd             	dec    %rbp
   106c7:	74 3c                	je     10705 <fwp_cmp+0x105>
   106c9:	4b 8b 7c 26 f8       	mov    -0x8(%r14,%r12,1),%rdi
   106ce:	4a 8b 74 23 f8       	mov    -0x8(%rbx,%r12,1),%rsi
   106d3:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
   106d8:	e8 23 ff ff ff       	call   10600 <fwp_cmp>
   106dd:	85 c0                	test   %eax,%eax
   106df:	0f 85 6d ff ff ff    	jne    10652 <fwp_cmp+0x52>
   106e5:	41 83 fd 12          	cmp    $0x12,%r13d
   106e9:	75 d5                	jne    106c0 <fwp_cmp+0xc0>
   106eb:	4b 8b 3c 26          	mov    (%r14,%r12,1),%rdi
   106ef:	4a 8b 34 23          	mov    (%rbx,%r12,1),%rsi
   106f3:	49 8b 57 40          	mov    0x40(%r15),%rdx
   106f7:	e8 04 ff ff ff       	call   10600 <fwp_cmp>
   106fc:	85 c0                	test   %eax,%eax
   106fe:	74 c0                	je     106c0 <fwp_cmp+0xc0>
   10700:	e9 4d ff ff ff       	jmp    10652 <fwp_cmp+0x52>
   10705:	31 c9                	xor    %ecx,%ecx
   10707:	48 8b 04 24          	mov    (%rsp),%rax
   1070b:	48 39 44 24 08       	cmp    %rax,0x8(%rsp)
   10710:	e9 32 ff ff ff       	jmp    10647 <fwp_cmp+0x47>
   10715:	49 8b 16             	mov    (%r14),%rdx
   10718:	49 8b 4e 08          	mov    0x8(%r14),%rcx
   1071c:	48 8b 3b             	mov    (%rbx),%rdi
   1071f:	48 8b 73 08          	mov    0x8(%rbx),%rsi
   10723:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   10728:	48 39 fa             	cmp    %rdi,%rdx
   1072b:	49 89 c8             	mov    %rcx,%r8
   1072e:	49 19 f0             	sbb    %rsi,%r8
   10731:	0f 82 1b ff ff ff    	jb     10652 <fwp_cmp+0x52>
   10737:	48 39 d7             	cmp    %rdx,%rdi
   1073a:	48 19 ce             	sbb    %rcx,%rsi
   1073d:	0f 92 c0             	setb   %al
   10740:	0f b6 c0             	movzbl %al,%eax
   10743:	e9 0a ff ff ff       	jmp    10652 <fwp_cmp+0x52>
   10748:	44 89 f1             	mov    %r14d,%ecx
   1074b:	c1 f9 1f             	sar    $0x1f,%ecx
   1074e:	d1 e9                	shr    $1,%ecx
   10750:	44 31 f1             	xor    %r14d,%ecx
   10753:	89 da                	mov    %ebx,%edx
   10755:	c1 fa 1f             	sar    $0x1f,%edx
   10758:	d1 ea                	shr    $1,%edx
   1075a:	31 da                	xor    %ebx,%edx
   1075c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   10761:	39 d1                	cmp    %edx,%ecx
   10763:	0f 8c e9 fe ff ff    	jl     10652 <fwp_cmp+0x52>
   10769:	eb 28                	jmp    10793 <fwp_cmp+0x193>
   1076b:	4c 89 f1             	mov    %r14,%rcx
   1076e:	48 c1 f9 3f          	sar    $0x3f,%rcx
   10772:	48 d1 e9             	shr    $1,%rcx
   10775:	4c 31 f1             	xor    %r14,%rcx
   10778:	48 89 da             	mov    %rbx,%rdx
   1077b:	48 c1 fa 3f          	sar    $0x3f,%rdx
   1077f:	48 d1 ea             	shr    $1,%rdx
   10782:	48 31 da             	xor    %rbx,%rdx
   10785:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   1078a:	48 39 d1             	cmp    %rdx,%rcx
   1078d:	0f 8c bf fe ff ff    	jl     10652 <fwp_cmp+0x52>
   10793:	0f 9f c0             	setg   %al
   10796:	0f b6 c0             	movzbl %al,%eax
   10799:	e9 b4 fe ff ff       	jmp    10652 <fwp_cmp+0x52>
   1079e:	49 8b 16             	mov    (%r14),%rdx
   107a1:	49 8b 4e 08          	mov    0x8(%r14),%rcx
   107a5:	48 8b 3b             	mov    (%rbx),%rdi
   107a8:	48 8b 73 08          	mov    0x8(%rbx),%rsi
   107ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   107b1:	48 39 fa             	cmp    %rdi,%rdx
   107b4:	49 89 c8             	mov    %rcx,%r8
   107b7:	49 19 f0             	sbb    %rsi,%r8
   107ba:	0f 8c 92 fe ff ff    	jl     10652 <fwp_cmp+0x52>
   107c0:	48 39 d7             	cmp    %rdx,%rdi
   107c3:	48 19 ce             	sbb    %rcx,%rsi
   107c6:	0f 9c c0             	setl   %al
   107c9:	0f b6 c0             	movzbl %al,%eax
   107cc:	e9 81 fe ff ff       	jmp    10652 <fwp_cmp+0x52>
   107d1:	4d 85 f6             	test   %r14,%r14
   107d4:	0f 94 c0             	sete   %al
   107d7:	74 44                	je     1081d <fwp_cmp+0x21d>
   107d9:	48 85 db             	test   %rbx,%rbx
   107dc:	74 3f                	je     1081d <fwp_cmp+0x21d>
   107de:	4d 8b 7f 38          	mov    0x38(%r15),%r15
   107e2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   107e9:	1f 84 00 00 00 00 00 
   107f0:	49 8b 7e 08          	mov    0x8(%r14),%rdi
   107f4:	48 8b 73 08          	mov    0x8(%rbx),%rsi
   107f8:	4c 89 fa             	mov    %r15,%rdx
   107fb:	e8 00 fe ff ff       	call   10600 <fwp_cmp>
   10800:	85 c0                	test   %eax,%eax
   10802:	0f 85 4a fe ff ff    	jne    10652 <fwp_cmp+0x52>
   10808:	4d 8b 76 10          	mov    0x10(%r14),%r14
   1080c:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
   10810:	4d 85 f6             	test   %r14,%r14
   10813:	0f 94 c0             	sete   %al
   10816:	74 05                	je     1081d <fwp_cmp+0x21d>
   10818:	48 85 db             	test   %rbx,%rbx
   1081b:	75 d3                	jne    107f0 <fwp_cmp+0x1f0>
   1081d:	48 85 db             	test   %rbx,%rbx
   10820:	0f 95 c1             	setne  %cl
   10823:	08 c1                	or     %al,%cl
   10825:	80 f1 01             	xor    $0x1,%cl
   10828:	0f b6 c9             	movzbl %cl,%ecx
   1082b:	84 c0                	test   %al,%al
   1082d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   10832:	0f 44 c1             	cmove  %ecx,%eax
   10835:	48 85 db             	test   %rbx,%rbx
   10838:	0f 44 c1             	cmove  %ecx,%eax
   1083b:	e9 12 fe ff ff       	jmp    10652 <fwp_cmp+0x52>
   10840:	45 8b 67 10          	mov    0x10(%r15),%r12d
   10844:	45 85 e4             	test   %r12d,%r12d
   10847:	0f 8e 5d 02 00 00    	jle    10aaa <fwp_cmp+0x4aa>
   1084d:	4d 8b 7f 20          	mov    0x20(%r15),%r15
   10851:	45 31 ed             	xor    %r13d,%r13d
   10854:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
   1085b:	00 00 00 00 00 
   10860:	4b 8b 7c ee 08       	mov    0x8(%r14,%r13,8),%rdi
   10865:	4a 8b 74 eb 08       	mov    0x8(%rbx,%r13,8),%rsi
   1086a:	4b 8b 14 ef          	mov    (%r15,%r13,8),%rdx
   1086e:	e8 8d fd ff ff       	call   10600 <fwp_cmp>
   10873:	85 c0                	test   %eax,%eax
   10875:	0f 85 d7 fd ff ff    	jne    10652 <fwp_cmp+0x52>
   1087b:	49 ff c5             	inc    %r13
   1087e:	31 c0                	xor    %eax,%eax
   10880:	4d 39 ec             	cmp    %r13,%r12
   10883:	75 db                	jne    10860 <fwp_cmp+0x260>
   10885:	e9 c8 fd ff ff       	jmp    10652 <fwp_cmp+0x52>
   1088a:	49 8b 06             	mov    (%r14),%rax
   1088d:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
   10894:	ff ff 7f 
   10897:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
   1089c:	4c 21 e0             	and    %r12,%rax
   1089f:	4c 8b 2b             	mov    (%rbx),%r13
   108a2:	4d 21 ec             	and    %r13,%r12
   108a5:	4c 39 e0             	cmp    %r12,%rax
   108a8:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
   108ad:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
   108b2:	4c 0f 42 e0          	cmovb  %rax,%r12
   108b6:	4d 85 e4             	test   %r12,%r12
   108b9:	0f 84 51 01 00 00    	je     10a10 <fwp_cmp+0x410>
   108bf:	4d 8b 7f 38          	mov    0x38(%r15),%r15
   108c3:	49 8d 46 08          	lea    0x8(%r14),%rax
   108c7:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
   108cc:	48 8d 43 08          	lea    0x8(%rbx),%rax
   108d0:	48 89 04 24          	mov    %rax,(%rsp)
   108d4:	31 ed                	xor    %ebp,%ebp
   108d6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   108dd:	00 00 00 
   108e0:	b8 08 00 00 00       	mov    $0x8,%eax
   108e5:	4d 85 ff             	test   %r15,%r15
   108e8:	74 14                	je     108fe <fwp_cmp+0x2fe>
   108ea:	41 8b 0f             	mov    (%r15),%ecx
   108ed:	48 83 f9 0a          	cmp    $0xa,%rcx
   108f1:	77 0b                	ja     108fe <fwp_cmp+0x2fe>
   108f3:	48 8d 05 f6 4f 00 00 	lea    0x4ff6(%rip),%rax        # 158f0 <exec_in_fp0+0x80>
   108fa:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
   108fe:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
   10903:	48 83 7c 24 10 00    	cmpq   $0x0,0x10(%rsp)
   10909:	79 04                	jns    1090f <fwp_cmp+0x30f>
   1090b:	49 8b 4e 10          	mov    0x10(%r14),%rcx
   1090f:	48 89 c2             	mov    %rax,%rdx
   10912:	48 0f af d5          	imul   %rbp,%rdx
   10916:	48 83 f8 08          	cmp    $0x8,%rax
   1091a:	74 2b                	je     10947 <fwp_cmp+0x347>
   1091c:	48 83 f8 02          	cmp    $0x2,%rax
   10920:	74 15                	je     10937 <fwp_cmp+0x337>
   10922:	48 83 f8 01          	cmp    $0x1,%rax
   10926:	75 2d                	jne    10955 <fwp_cmp+0x355>
   10928:	0f b6 04 11          	movzbl (%rcx,%rdx,1),%eax
   1092c:	41 8b 0f             	mov    (%r15),%ecx
   1092f:	85 c9                	test   %ecx,%ecx
   10931:	48 0f be f8          	movsbq %al,%rdi
   10935:	eb 2a                	jmp    10961 <fwp_cmp+0x361>
   10937:	0f b7 04 11          	movzwl (%rcx,%rdx,1),%eax
   1093b:	41 8b 0f             	mov    (%r15),%ecx
   1093e:	83 f9 01             	cmp    $0x1,%ecx
   10941:	48 0f bf f8          	movswq %ax,%rdi
   10945:	eb 1a                	jmp    10961 <fwp_cmp+0x361>
   10947:	48 8b 3c 11          	mov    (%rcx,%rdx,1),%rdi
   1094b:	4d 85 ff             	test   %r15,%r15
   1094e:	74 4b                	je     1099b <fwp_cmp+0x39b>
   10950:	41 8b 0f             	mov    (%r15),%ecx
   10953:	eb 10                	jmp    10965 <fwp_cmp+0x365>
   10955:	8b 04 11             	mov    (%rcx,%rdx,1),%eax
   10958:	41 8b 0f             	mov    (%r15),%ecx
   1095b:	83 f9 02             	cmp    $0x2,%ecx
   1095e:	48 63 f8             	movslq %eax,%rdi
   10961:	48 0f 45 f8          	cmovne %rax,%rdi
   10965:	83 f9 0a             	cmp    $0xa,%ecx
   10968:	77 31                	ja     1099b <fwp_cmp+0x39b>
   1096a:	b8 84 04 00 00       	mov    $0x484,%eax
   1096f:	0f a3 c8             	bt     %ecx,%eax
   10972:	72 20                	jb     10994 <fwp_cmp+0x394>
   10974:	b8 01 00 00 00       	mov    $0x1,%eax
   10979:	ba 21 00 00 00       	mov    $0x21,%edx
   1097e:	0f a3 ca             	bt     %ecx,%edx
   10981:	72 1d                	jb     109a0 <fwp_cmp+0x3a0>
   10983:	b8 42 00 00 00       	mov    $0x42,%eax
   10988:	0f a3 c8             	bt     %ecx,%eax
   1098b:	73 0e                	jae    1099b <fwp_cmp+0x39b>
   1098d:	b8 02 00 00 00       	mov    $0x2,%eax
   10992:	eb 0c                	jmp    109a0 <fwp_cmp+0x3a0>
   10994:	b8 04 00 00 00       	mov    $0x4,%eax
   10999:	eb 05                	jmp    109a0 <fwp_cmp+0x3a0>
   1099b:	b8 08 00 00 00       	mov    $0x8,%eax
   109a0:	48 8b 0c 24          	mov    (%rsp),%rcx
   109a4:	4d 85 ed             	test   %r13,%r13
   109a7:	79 04                	jns    109ad <fwp_cmp+0x3ad>
   109a9:	48 8b 4b 10          	mov    0x10(%rbx),%rcx
   109ad:	48 89 c2             	mov    %rax,%rdx
   109b0:	48 0f af d5          	imul   %rbp,%rdx
   109b4:	48 83 f8 01          	cmp    $0x1,%rax
   109b8:	74 1e                	je     109d8 <fwp_cmp+0x3d8>
   109ba:	83 f8 02             	cmp    $0x2,%eax
   109bd:	74 0b                	je     109ca <fwp_cmp+0x3ca>
   109bf:	83 f8 08             	cmp    $0x8,%eax
   109c2:	75 22                	jne    109e6 <fwp_cmp+0x3e6>
   109c4:	48 8b 34 11          	mov    (%rcx,%rdx,1),%rsi
   109c8:	eb 2a                	jmp    109f4 <fwp_cmp+0x3f4>
   109ca:	41 83 3f 01          	cmpl   $0x1,(%r15)
   109ce:	0f b7 04 11          	movzwl (%rcx,%rdx,1),%eax
   109d2:	48 0f bf f0          	movswq %ax,%rsi
   109d6:	eb 18                	jmp    109f0 <fwp_cmp+0x3f0>
   109d8:	41 83 3f 00          	cmpl   $0x0,(%r15)
   109dc:	0f b6 04 11          	movzbl (%rcx,%rdx,1),%eax
   109e0:	48 0f be f0          	movsbq %al,%rsi
   109e4:	eb 0a                	jmp    109f0 <fwp_cmp+0x3f0>
   109e6:	41 83 3f 02          	cmpl   $0x2,(%r15)
   109ea:	8b 04 11             	mov    (%rcx,%rdx,1),%eax
   109ed:	48 63 f0             	movslq %eax,%rsi
   109f0:	48 0f 45 f0          	cmovne %rax,%rsi
   109f4:	4c 89 fa             	mov    %r15,%rdx
   109f7:	e8 04 fc ff ff       	call   10600 <fwp_cmp>
   109fc:	85 c0                	test   %eax,%eax
   109fe:	0f 85 4e fc ff ff    	jne    10652 <fwp_cmp+0x52>
   10a04:	48 ff c5             	inc    %rbp
   10a07:	49 39 ec             	cmp    %rbp,%r12
   10a0a:	0f 85 d0 fe ff ff    	jne    108e0 <fwp_cmp+0x2e0>
   10a10:	31 c9                	xor    %ecx,%ecx
   10a12:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
   10a17:	48 3b 44 24 20       	cmp    0x20(%rsp),%rax
   10a1c:	e9 26 fc ff ff       	jmp    10647 <fwp_cmp+0x47>
   10a21:	49 81 fe ff 0f 00 00 	cmp    $0xfff,%r14
   10a28:	77 27                	ja     10a51 <fwp_cmp+0x451>
   10a2a:	44 89 f0             	mov    %r14d,%eax
   10a2d:	48 81 fb ff 0f 00 00 	cmp    $0xfff,%rbx
   10a34:	76 27                	jbe    10a5d <fwp_cmp+0x45d>
   10a36:	8b 0b                	mov    (%rbx),%ecx
   10a38:	39 c8                	cmp    %ecx,%eax
   10a3a:	74 27                	je     10a63 <fwp_cmp+0x463>
   10a3c:	0f 97 c0             	seta   %al
   10a3f:	0f b6 c8             	movzbl %al,%ecx
   10a42:	e9 03 fc ff ff       	jmp    1064a <fwp_cmp+0x4a>
   10a47:	31 c9                	xor    %ecx,%ecx
   10a49:	4d 39 e7             	cmp    %r12,%r15
   10a4c:	e9 f6 fb ff ff       	jmp    10647 <fwp_cmp+0x47>
   10a51:	41 8b 06             	mov    (%r14),%eax
   10a54:	48 81 fb ff 0f 00 00 	cmp    $0xfff,%rbx
   10a5b:	77 d9                	ja     10a36 <fwp_cmp+0x436>
   10a5d:	89 d9                	mov    %ebx,%ecx
   10a5f:	39 c8                	cmp    %ecx,%eax
   10a61:	75 d9                	jne    10a3c <fwp_cmp+0x43c>
   10a63:	49 8b 4f 28          	mov    0x28(%r15),%rcx
   10a67:	89 c0                	mov    %eax,%eax
   10a69:	44 8b 24 81          	mov    (%rcx,%rax,4),%r12d
   10a6d:	45 85 e4             	test   %r12d,%r12d
   10a70:	7e 38                	jle    10aaa <fwp_cmp+0x4aa>
   10a72:	49 8b 4f 30          	mov    0x30(%r15),%rcx
   10a76:	4c 8b 3c c1          	mov    (%rcx,%rax,8),%r15
   10a7a:	45 31 ed             	xor    %r13d,%r13d
   10a7d:	0f 1f 00             	nopl   (%rax)
   10a80:	4b 8b 7c ee 08       	mov    0x8(%r14,%r13,8),%rdi
   10a85:	4a 8b 74 eb 08       	mov    0x8(%rbx,%r13,8),%rsi
   10a8a:	4b 8b 14 ef          	mov    (%r15,%r13,8),%rdx
   10a8e:	e8 6d fb ff ff       	call   10600 <fwp_cmp>
   10a93:	85 c0                	test   %eax,%eax
   10a95:	0f 85 b7 fb ff ff    	jne    10652 <fwp_cmp+0x52>
   10a9b:	49 ff c5             	inc    %r13
   10a9e:	31 c0                	xor    %eax,%eax
   10aa0:	4d 39 ec             	cmp    %r13,%r12
   10aa3:	75 db                	jne    10a80 <fwp_cmp+0x480>
   10aa5:	e9 a8 fb ff ff       	jmp    10652 <fwp_cmp+0x52>
   10aaa:	31 c0                	xor    %eax,%eax
   10aac:	e9 a1 fb ff ff       	jmp    10652 <fwp_cmp+0x52>
   10ab1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   10ab8:	0f 1f 84 00 00 00 00 
   10abf:	00 

0000000000010ac0 <fwp_pipe_poll>:
   10ac0:	83 3d 19 b3 00 00 00 	cmpl   $0x0,0xb319(%rip)        # 1bde0 <fwp_po_listen>
   10ac7:	0f 88 b1 01 00 00    	js     10c7e <fwp_pipe_poll+0x1be>
   10acd:	55                   	push   %rbp
   10ace:	41 57                	push   %r15
   10ad0:	41 56                	push   %r14
   10ad2:	53                   	push   %rbx
   10ad3:	48 83 ec 38          	sub    $0x38,%rsp
   10ad7:	48 8d 74 24 28       	lea    0x28(%rsp),%rsi
   10adc:	bf 01 00 00 00       	mov    $0x1,%edi
   10ae1:	e8 4a 26 ff ff       	call   3130 <clock_gettime@plt>
   10ae6:	4c 69 74 24 28 00 ca 	imul   $0x3b9aca00,0x28(%rsp),%r14
   10aed:	9a 3b 
   10aef:	4c 03 74 24 30       	add    0x30(%rsp),%r14
   10af4:	4c 3b 35 45 b4 02 00 	cmp    0x2b445(%rip),%r14        # 3bf40 <fwp_po_next_check>
   10afb:	0f 8c 73 01 00 00    	jl     10c74 <fwp_pipe_poll+0x1b4>
   10b01:	49 8d 86 40 42 0f 00 	lea    0xf4240(%r14),%rax
   10b08:	48 89 05 31 b4 02 00 	mov    %rax,0x2b431(%rip)        # 3bf40 <fwp_po_next_check>
   10b0f:	8b 3d cb b2 00 00    	mov    0xb2cb(%rip),%edi        # 1bde0 <fwp_po_listen>
   10b15:	31 f6                	xor    %esi,%esi
   10b17:	31 d2                	xor    %edx,%edx
   10b19:	e8 12 29 ff ff       	call   3430 <accept@plt>
   10b1e:	85 c0                	test   %eax,%eax
   10b20:	0f 88 10 01 00 00    	js     10c36 <fwp_pipe_poll+0x176>
   10b26:	89 c3                	mov    %eax,%ebx
   10b28:	8b 3d b2 b2 00 00    	mov    0xb2b2(%rip),%edi        # 1bde0 <fwp_po_listen>
   10b2e:	e8 fd 26 ff ff       	call   3230 <close@plt>
   10b33:	c7 05 a3 b2 00 00 ff 	movl   $0xffffffff,0xb2a3(%rip)        # 1bde0 <fwp_po_listen>
   10b3a:	ff ff ff 
   10b3d:	89 df                	mov    %ebx,%edi
   10b3f:	be 02 00 00 00       	mov    $0x2,%esi
   10b44:	ba 01 00 00 00       	mov    $0x1,%edx
   10b49:	31 c0                	xor    %eax,%eax
   10b4b:	e8 d0 25 ff ff       	call   3120 <fcntl@plt>
   10b50:	89 df                	mov    %ebx,%edi
   10b52:	be 03 00 00 00       	mov    $0x3,%esi
   10b57:	31 c0                	xor    %eax,%eax
   10b59:	e8 c2 25 ff ff       	call   3120 <fcntl@plt>
   10b5e:	25 ff f7 ff ff       	and    $0xfffff7ff,%eax
   10b63:	89 df                	mov    %ebx,%edi
   10b65:	be 04 00 00 00       	mov    $0x4,%esi
   10b6a:	89 c2                	mov    %eax,%edx
   10b6c:	31 c0                	xor    %eax,%eax
   10b6e:	e8 ad 25 ff ff       	call   3120 <fcntl@plt>
   10b73:	c7 44 24 24 0c 00 00 	movl   $0xc,0x24(%rsp)
   10b7a:	00 
   10b7b:	89 5c 24 1c          	mov    %ebx,0x1c(%rsp)
   10b7f:	c7 44 24 20 01 00 00 	movl   $0x1,0x20(%rsp)
   10b86:	00 
   10b87:	48 8d 4c 24 28       	lea    0x28(%rsp),%rcx
   10b8c:	4c 8d 44 24 24       	lea    0x24(%rsp),%r8
   10b91:	89 df                	mov    %ebx,%edi
   10b93:	be 01 00 00 00       	mov    $0x1,%esi
   10b98:	ba 11 00 00 00       	mov    $0x11,%edx
   10b9d:	e8 fe 26 ff ff       	call   32a0 <getsockopt@plt>
   10ba2:	85 c0                	test   %eax,%eax
   10ba4:	0f 85 c3 00 00 00    	jne    10c6d <fwp_pipe_poll+0x1ad>
   10baa:	8b 6c 24 2c          	mov    0x2c(%rsp),%ebp
   10bae:	e8 cd 25 ff ff       	call   3180 <getuid@plt>
   10bb3:	39 c5                	cmp    %eax,%ebp
   10bb5:	0f 85 b2 00 00 00    	jne    10c6d <fwp_pipe_poll+0x1ad>
   10bbb:	48 8d 7c 24 1c       	lea    0x1c(%rsp),%rdi
   10bc0:	be 01 00 00 00       	mov    $0x1,%esi
   10bc5:	ba e8 03 00 00       	mov    $0x3e8,%edx
   10bca:	e8 f1 27 ff ff       	call   33c0 <poll@plt>
   10bcf:	85 c0                	test   %eax,%eax
   10bd1:	0f 8e 96 00 00 00    	jle    10c6d <fwp_pipe_poll+0x1ad>
   10bd7:	48 8d 74 24 0f       	lea    0xf(%rsp),%rsi
   10bdc:	ba 05 00 00 00       	mov    $0x5,%edx
   10be1:	89 df                	mov    %ebx,%edi
   10be3:	31 c9                	xor    %ecx,%ecx
   10be5:	e8 76 24 ff ff       	call   3060 <recv@plt>
   10bea:	48 85 c0             	test   %rax,%rax
   10bed:	7e 7e                	jle    10c6d <fwp_pipe_poll+0x1ad>
   10bef:	49 89 c6             	mov    %rax,%r14
   10bf2:	4c 8d 7c 24 1c       	lea    0x1c(%rsp),%r15
   10bf7:	49 83 fe 04          	cmp    $0x4,%r14
   10bfb:	77 59                	ja     10c56 <fwp_pipe_poll+0x196>
   10bfd:	be 01 00 00 00       	mov    $0x1,%esi
   10c02:	4c 89 ff             	mov    %r15,%rdi
   10c05:	ba e8 03 00 00       	mov    $0x3e8,%edx
   10c0a:	e8 b1 27 ff ff       	call   33c0 <poll@plt>
   10c0f:	85 c0                	test   %eax,%eax
   10c11:	7e 5a                	jle    10c6d <fwp_pipe_poll+0x1ad>
   10c13:	4a 8d 34 34          	lea    (%rsp,%r14,1),%rsi
   10c17:	48 83 c6 0f          	add    $0xf,%rsi
   10c1b:	ba 05 00 00 00       	mov    $0x5,%edx
   10c20:	4c 29 f2             	sub    %r14,%rdx
   10c23:	89 df                	mov    %ebx,%edi
   10c25:	31 c9                	xor    %ecx,%ecx
   10c27:	e8 34 24 ff ff       	call   3060 <recv@plt>
   10c2c:	49 01 c6             	add    %rax,%r14
   10c2f:	48 85 c0             	test   %rax,%rax
   10c32:	7f c3                	jg     10bf7 <fwp_pipe_poll+0x137>
   10c34:	eb 37                	jmp    10c6d <fwp_pipe_poll+0x1ad>
   10c36:	4c 3b 35 db b2 01 00 	cmp    0x1b2db(%rip),%r14        # 2bf18 <fwp_po_give_up>
   10c3d:	7e 35                	jle    10c74 <fwp_pipe_poll+0x1b4>
   10c3f:	8b 3d 9b b1 00 00    	mov    0xb19b(%rip),%edi        # 1bde0 <fwp_po_listen>
   10c45:	e8 e6 25 ff ff       	call   3230 <close@plt>
   10c4a:	c7 05 8c b1 00 00 ff 	movl   $0xffffffff,0xb18c(%rip)        # 1bde0 <fwp_po_listen>
   10c51:	ff ff ff 
   10c54:	eb 1e                	jmp    10c74 <fwp_pipe_poll+0x1b4>
   10c56:	81 7c 24 0f 46 57 50 	cmpl   $0x54505746,0xf(%rsp)
   10c5d:	54 
   10c5e:	75 0d                	jne    10c6d <fwp_pipe_poll+0x1ad>
   10c60:	0f b6 44 24 13       	movzbl 0x13(%rsp),%eax
   10c65:	8d 48 fd             	lea    -0x3(%rax),%ecx
   10c68:	80 f9 fd             	cmp    $0xfd,%cl
   10c6b:	77 12                	ja     10c7f <fwp_pipe_poll+0x1bf>
   10c6d:	89 df                	mov    %ebx,%edi
   10c6f:	e8 bc 25 ff ff       	call   3230 <close@plt>
   10c74:	48 83 c4 38          	add    $0x38,%rsp
   10c78:	5b                   	pop    %rbx
   10c79:	41 5e                	pop    %r14
   10c7b:	41 5f                	pop    %r15
   10c7d:	5d                   	pop    %rbp
   10c7e:	c3                   	ret
   10c7f:	89 1d 5f b1 00 00    	mov    %ebx,0xb15f(%rip)        # 1bde4 <fwp_po_sock>
   10c85:	bb 01 00 00 00       	mov    $0x1,%ebx
   10c8a:	3c 02                	cmp    $0x2,%al
   10c8c:	75 10                	jne    10c9e <fwp_pipe_poll+0x1de>
   10c8e:	e8 4d 00 00 00       	call   10ce0 <fwp_po_make_ring>
   10c93:	83 f8 01             	cmp    $0x1,%eax
   10c96:	bb 02 00 00 00       	mov    $0x2,%ebx
   10c9b:	83 db 00             	sbb    $0x0,%ebx
   10c9e:	c7 44 24 14 02 01 00 	movl   $0x102,0x14(%rsp)
   10ca5:	00 
   10ca6:	c6 44 24 18 00       	movb   $0x0,0x18(%rsp)
   10cab:	88 5c 24 19          	mov    %bl,0x19(%rsp)
   10caf:	4c 8b 35 fa 92 00 00 	mov    0x92fa(%rip),%r14        # 19fb0 <stdout@GLIBC_2.2.5>
   10cb6:	49 8b 0e             	mov    (%r14),%rcx
   10cb9:	48 8d 7c 24 14       	lea    0x14(%rsp),%rdi
   10cbe:	be 01 00 00 00       	mov    $0x1,%esi
   10cc3:	ba 06 00 00 00       	mov    $0x6,%edx
   10cc8:	e8 b3 27 ff ff       	call   3480 <fwrite@plt>
   10ccd:	49 8b 3e             	mov    (%r14),%rdi
   10cd0:	e8 7b 26 ff ff       	call   3350 <fflush@plt>
   10cd5:	89 1d 45 b2 01 00    	mov    %ebx,0x1b245(%rip)        # 2bf20 <fwp_po_kind>
   10cdb:	eb 97                	jmp    10c74 <fwp_pipe_poll+0x1b4>
   10cdd:	0f 1f 00             	nopl   (%rax)

0000000000010ce0 <fwp_po_make_ring>:
   10ce0:	55                   	push   %rbp
   10ce1:	41 57                	push   %r15
   10ce3:	41 56                	push   %r14
   10ce5:	53                   	push   %rbx
   10ce6:	48 83 ec 68          	sub    $0x68,%rsp
   10cea:	48 8d 35 4a 5a 00 00 	lea    0x5a4a(%rip),%rsi        # 1673b <exec_in_fp0+0xecb>
   10cf1:	31 ed                	xor    %ebp,%ebp
   10cf3:	bf 3f 01 00 00       	mov    $0x13f,%edi
   10cf8:	ba 01 00 00 00       	mov    $0x1,%edx
   10cfd:	31 c0                	xor    %eax,%eax
   10cff:	e8 fc 25 ff ff       	call   3300 <syscall@plt>
   10d04:	48 89 c3             	mov    %rax,%rbx
   10d07:	85 db                	test   %ebx,%ebx
   10d09:	78 17                	js     10d22 <fwp_po_make_ring+0x42>
   10d0b:	be 00 10 10 00       	mov    $0x101000,%esi
   10d10:	89 df                	mov    %ebx,%edi
   10d12:	e8 c9 24 ff ff       	call   31e0 <ftruncate@plt>
   10d17:	85 c0                	test   %eax,%eax
   10d19:	74 14                	je     10d2f <fwp_po_make_ring+0x4f>
   10d1b:	89 df                	mov    %ebx,%edi
   10d1d:	e8 0e 25 ff ff       	call   3230 <close@plt>
   10d22:	89 e8                	mov    %ebp,%eax
   10d24:	48 83 c4 68          	add    $0x68,%rsp
   10d28:	5b                   	pop    %rbx
   10d29:	41 5e                	pop    %r14
   10d2b:	41 5f                	pop    %r15
   10d2d:	5d                   	pop    %rbp
   10d2e:	c3                   	ret
   10d2f:	be 00 10 10 00       	mov    $0x101000,%esi
   10d34:	31 ff                	xor    %edi,%edi
   10d36:	ba 03 00 00 00       	mov    $0x3,%edx
   10d3b:	b9 01 00 00 00       	mov    $0x1,%ecx
   10d40:	41 89 d8             	mov    %ebx,%r8d
   10d43:	45 31 c9             	xor    %r9d,%r9d
   10d46:	e8 45 24 ff ff       	call   3190 <mmap@plt>
   10d4b:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
   10d4f:	74 ca                	je     10d1b <fwp_po_make_ring+0x3b>
   10d51:	49 89 c6             	mov    %rax,%r14
   10d54:	48 b8 46 57 50 53 01 	movabs $0x153505746,%rax
   10d5b:	00 00 00 
   10d5e:	49 89 06             	mov    %rax,(%r14)
   10d61:	49 c7 46 08 00 00 10 	movq   $0x100000,0x8(%r14)
   10d68:	00 
   10d69:	c6 44 24 07 53       	movb   $0x53,0x7(%rsp)
   10d6e:	48 8d 44 24 07       	lea    0x7(%rsp),%rax
   10d73:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   10d78:	48 c7 44 24 28 01 00 	movq   $0x1,0x28(%rsp)
   10d7f:	00 00 
   10d81:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
   10d88:	00 00 
   10d8a:	0f 57 c0             	xorps  %xmm0,%xmm0
   10d8d:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
   10d92:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
   10d97:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
   10d9c:	48 c7 44 24 60 00 00 	movq   $0x0,0x60(%rsp)
   10da3:	00 00 
   10da5:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
   10daa:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
   10daf:	48 c7 44 24 48 01 00 	movq   $0x1,0x48(%rsp)
   10db6:	00 00 
   10db8:	48 8d 44 24 08       	lea    0x8(%rsp),%rax
   10dbd:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
   10dc2:	48 c7 44 24 58 18 00 	movq   $0x18,0x58(%rsp)
   10dc9:	00 00 
   10dcb:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
   10dd2:	00 00 00 
   10dd5:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
   10dda:	48 c7 44 24 08 14 00 	movq   $0x14,0x8(%rsp)
   10de1:	00 00 
   10de3:	89 5c 24 18          	mov    %ebx,0x18(%rsp)
   10de7:	8b 3d f7 af 00 00    	mov    0xaff7(%rip),%edi        # 1bde4 <fwp_po_sock>
   10ded:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
   10df2:	ba 00 40 00 00       	mov    $0x4000,%edx
   10df7:	e8 c4 22 ff ff       	call   30c0 <sendmsg@plt>
   10dfc:	49 89 c7             	mov    %rax,%r15
   10dff:	89 df                	mov    %ebx,%edi
   10e01:	e8 2a 24 ff ff       	call   3230 <close@plt>
   10e06:	49 83 ff 01          	cmp    $0x1,%r15
   10e0a:	75 11                	jne    10e1d <fwp_po_make_ring+0x13d>
   10e0c:	4c 89 35 1d b1 02 00 	mov    %r14,0x2b11d(%rip)        # 3bf30 <fwp_po_ring>
   10e13:	bd 01 00 00 00       	mov    $0x1,%ebp
   10e18:	e9 05 ff ff ff       	jmp    10d22 <fwp_po_make_ring+0x42>
   10e1d:	be 00 10 10 00       	mov    $0x101000,%esi
   10e22:	4c 89 f7             	mov    %r14,%rdi
   10e25:	e8 66 25 ff ff       	call   3390 <munmap@plt>
   10e2a:	31 ed                	xor    %ebp,%ebp
   10e2c:	e9 f1 fe ff ff       	jmp    10d22 <fwp_po_make_ring+0x42>
   10e31:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   10e38:	0f 1f 84 00 00 00 00 
   10e3f:	00 

0000000000010e40 <fwp_write>:
   10e40:	55                   	push   %rbp
   10e41:	41 57                	push   %r15
   10e43:	41 56                	push   %r14
   10e45:	41 55                	push   %r13
   10e47:	41 54                	push   %r12
   10e49:	53                   	push   %rbx
   10e4a:	48 81 ec 78 02 00 00 	sub    $0x278,%rsp
   10e51:	8b 02                	mov    (%rdx),%eax
   10e53:	48 83 f8 19          	cmp    $0x19,%rax
   10e57:	0f 87 36 12 00 00    	ja     12093 <fwp_write+0x1253>
   10e5d:	49 89 d7             	mov    %rdx,%r15
   10e60:	49 89 f6             	mov    %rsi,%r14
   10e63:	48 89 fd             	mov    %rdi,%rbp
   10e66:	48 8d 15 8b 46 00 00 	lea    0x468b(%rip),%rdx        # 154f8 <_IO_stdin_used+0x4f8>
   10e6d:	48 63 34 82          	movslq (%rdx,%rax,4),%rsi
   10e71:	48 01 d6             	add    %rdx,%rsi
   10e74:	48 89 3c 24          	mov    %rdi,(%rsp)
   10e78:	ff e6                	jmp    *%rsi
   10e7a:	48 8d 15 e8 58 00 00 	lea    0x58e8(%rip),%rdx        # 16769 <exec_in_fp0+0xef9>
   10e81:	eb 07                	jmp    10e8a <fwp_write+0x4a>
   10e83:	48 8d 15 a7 58 00 00 	lea    0x58a7(%rip),%rdx        # 16731 <exec_in_fp0+0xec1>
   10e8a:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
   10e8f:	be 00 02 00 00       	mov    $0x200,%esi
   10e94:	4c 89 ff             	mov    %r15,%rdi
   10e97:	4c 89 f1             	mov    %r14,%rcx
   10e9a:	31 c0                	xor    %eax,%eax
   10e9c:	e8 2f 23 ff ff       	call   31d0 <snprintf@plt>
   10ea1:	4c 89 ff             	mov    %r15,%rdi
   10ea4:	e8 c7 22 ff ff       	call   3170 <strlen@plt>
   10ea9:	48 89 ef             	mov    %rbp,%rdi
   10eac:	4c 89 fe             	mov    %r15,%rsi
   10eaf:	e9 d7 11 00 00       	jmp    1208b <fwp_write+0x124b>
   10eb4:	83 f8 13             	cmp    $0x13,%eax
   10eb7:	48 8d 05 dc 58 00 00 	lea    0x58dc(%rip),%rax        # 1679a <exec_in_fp0+0xf2a>
   10ebe:	48 8d 35 da 58 00 00 	lea    0x58da(%rip),%rsi        # 1679f <exec_in_fp0+0xf2f>
   10ec5:	48 0f 44 f0          	cmove  %rax,%rsi
   10ec9:	ba 04 00 00 00       	mov    $0x4,%edx
   10ece:	48 89 ef             	mov    %rbp,%rdi
   10ed1:	e8 3a c3 ff ff       	call   d210 <buf_put>
   10ed6:	49 83 3e 00          	cmpq   $0x0,(%r14)
   10eda:	0f 84 c3 00 00 00    	je     10fa3 <fwp_write+0x163>
   10ee0:	49 8b 57 38          	mov    0x38(%r15),%rdx
   10ee4:	49 8b 76 08          	mov    0x8(%r14),%rsi
   10ee8:	48 8b 1c 24          	mov    (%rsp),%rbx
   10eec:	48 89 df             	mov    %rbx,%rdi
   10eef:	31 c9                	xor    %ecx,%ecx
   10ef1:	e8 4a ff ff ff       	call   10e40 <fwp_write>
   10ef6:	41 83 3f 12          	cmpl   $0x12,(%r15)
   10efa:	75 26                	jne    10f22 <fwp_write+0xe2>
   10efc:	48 8d 35 5b 58 00 00 	lea    0x585b(%rip),%rsi        # 1675e <exec_in_fp0+0xeee>
   10f03:	ba 02 00 00 00       	mov    $0x2,%edx
   10f08:	48 89 df             	mov    %rbx,%rdi
   10f0b:	e8 00 c3 ff ff       	call   d210 <buf_put>
   10f10:	49 8b 76 10          	mov    0x10(%r14),%rsi
   10f14:	49 8b 57 40          	mov    0x40(%r15),%rdx
   10f18:	48 89 df             	mov    %rbx,%rdi
   10f1b:	31 c9                	xor    %ecx,%ecx
   10f1d:	e8 1e ff ff ff       	call   10e40 <fwp_write>
   10f22:	49 83 3e 02          	cmpq   $0x2,(%r14)
   10f26:	72 7b                	jb     10fa3 <fwp_write+0x163>
   10f28:	49 8d 5e 20          	lea    0x20(%r14),%rbx
   10f2c:	bd 01 00 00 00       	mov    $0x1,%ebp
   10f31:	4c 8d 25 83 57 00 00 	lea    0x5783(%rip),%r12        # 166bb <exec_in_fp0+0xe4b>
   10f38:	eb 12                	jmp    10f4c <fwp_write+0x10c>
   10f3a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   10f40:	48 ff c5             	inc    %rbp
   10f43:	48 83 c3 10          	add    $0x10,%rbx
   10f47:	49 3b 2e             	cmp    (%r14),%rbp
   10f4a:	73 57                	jae    10fa3 <fwp_write+0x163>
   10f4c:	ba 02 00 00 00       	mov    $0x2,%edx
   10f51:	4c 8b 2c 24          	mov    (%rsp),%r13
   10f55:	4c 89 ef             	mov    %r13,%rdi
   10f58:	4c 89 e6             	mov    %r12,%rsi
   10f5b:	e8 b0 c2 ff ff       	call   d210 <buf_put>
   10f60:	48 8b 73 f8          	mov    -0x8(%rbx),%rsi
   10f64:	49 8b 57 38          	mov    0x38(%r15),%rdx
   10f68:	4c 89 ef             	mov    %r13,%rdi
   10f6b:	31 c9                	xor    %ecx,%ecx
   10f6d:	e8 ce fe ff ff       	call   10e40 <fwp_write>
   10f72:	41 83 3f 12          	cmpl   $0x12,(%r15)
   10f76:	75 c8                	jne    10f40 <fwp_write+0x100>
   10f78:	ba 02 00 00 00       	mov    $0x2,%edx
   10f7d:	4c 8b 2c 24          	mov    (%rsp),%r13
   10f81:	4c 89 ef             	mov    %r13,%rdi
   10f84:	48 8d 35 d3 57 00 00 	lea    0x57d3(%rip),%rsi        # 1675e <exec_in_fp0+0xeee>
   10f8b:	e8 80 c2 ff ff       	call   d210 <buf_put>
   10f90:	48 8b 33             	mov    (%rbx),%rsi
   10f93:	49 8b 57 40          	mov    0x40(%r15),%rdx
   10f97:	4c 89 ef             	mov    %r13,%rdi
   10f9a:	31 c9                	xor    %ecx,%ecx
   10f9c:	e8 9f fe ff ff       	call   10e40 <fwp_write>
   10fa1:	eb 9d                	jmp    10f40 <fwp_write+0x100>
   10fa3:	c6 44 24 70 7d       	movb   $0x7d,0x70(%rsp)
   10fa8:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   10fad:	ba 01 00 00 00       	mov    $0x1,%edx
   10fb2:	48 8b 3c 24          	mov    (%rsp),%rdi
   10fb6:	e9 d3 10 00 00       	jmp    1208e <fwp_write+0x124e>
   10fbb:	4d 8b 67 08          	mov    0x8(%r15),%r12
   10fbf:	4d 85 e4             	test   %r12,%r12
   10fc2:	0f 84 bf 06 00 00    	je     11687 <fwp_write+0x847>
   10fc8:	48 8d 35 05 57 00 00 	lea    0x5705(%rip),%rsi        # 166d4 <exec_in_fp0+0xe64>
   10fcf:	4c 89 e7             	mov    %r12,%rdi
   10fd2:	e8 f9 22 ff ff       	call   32d0 <strcmp@plt>
   10fd7:	85 c0                	test   %eax,%eax
   10fd9:	0f 84 46 0b 00 00    	je     11b25 <fwp_write+0xce5>
   10fdf:	4d 8d 6f 10          	lea    0x10(%r15),%r13
   10fe3:	4c 89 e7             	mov    %r12,%rdi
   10fe6:	e8 85 21 ff ff       	call   3170 <strlen@plt>
   10feb:	48 89 ef             	mov    %rbp,%rdi
   10fee:	4c 89 e6             	mov    %r12,%rsi
   10ff1:	48 89 c2             	mov    %rax,%rdx
   10ff4:	e8 17 c2 ff ff       	call   d210 <buf_put>
   10ff9:	c6 44 24 70 20       	movb   $0x20,0x70(%rsp)
   10ffe:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   11003:	ba 01 00 00 00       	mov    $0x1,%edx
   11008:	48 89 ef             	mov    %rbp,%rdi
   1100b:	e8 00 c2 ff ff       	call   d210 <buf_put>
   11010:	31 db                	xor    %ebx,%ebx
   11012:	e9 8f 06 00 00       	jmp    116a6 <fwp_write+0x866>
   11017:	49 81 fe ff 0f 00 00 	cmp    $0xfff,%r14
   1101e:	0f 87 10 05 00 00    	ja     11534 <fwp_write+0x6f4>
   11024:	44 89 f0             	mov    %r14d,%eax
   11027:	e9 0b 05 00 00       	jmp    11537 <fwp_write+0x6f7>
   1102c:	66 49 0f 6e ce       	movq   %r14,%xmm1
   11031:	66 0f 2e c9          	ucomisd %xmm1,%xmm1
   11035:	0f 8a e2 11 00 00    	jp     1221d <fwp_write+0x13dd>
   1103b:	66 0f 28 05 bd 40 00 	movapd 0x40bd(%rip),%xmm0        # 15100 <_IO_stdin_used+0x100>
   11042:	00 
   11043:	66 0f 54 c1          	andpd  %xmm1,%xmm0
   11047:	66 0f 2e 05 71 41 00 	ucomisd 0x4171(%rip),%xmm0        # 151c0 <_IO_stdin_used+0x1c0>
   1104e:	00 
   1104f:	0f 82 76 08 00 00    	jb     118cb <fwp_write+0xa8b>
   11055:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
   11059:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
   1105d:	e9 65 04 00 00       	jmp    114c7 <fwp_write+0x687>
   11062:	c6 44 24 70 3c       	movb   $0x3c,0x70(%rsp)
   11067:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   1106c:	ba 01 00 00 00       	mov    $0x1,%edx
   11071:	48 89 ef             	mov    %rbp,%rdi
   11074:	e8 97 c1 ff ff       	call   d210 <buf_put>
   11079:	4d 8b 77 08          	mov    0x8(%r15),%r14
   1107d:	e9 92 04 00 00       	jmp    11514 <fwp_write+0x6d4>
   11082:	48 8d 35 f0 56 00 00 	lea    0x56f0(%rip),%rsi        # 16779 <exec_in_fp0+0xf09>
   11089:	ba 08 00 00 00       	mov    $0x8,%edx
   1108e:	48 89 ef             	mov    %rbp,%rdi
   11091:	e9 6c 0d 00 00       	jmp    11e02 <fwp_write+0xfc2>
   11096:	49 8d 76 08          	lea    0x8(%r14),%rsi
   1109a:	49 8b 16             	mov    (%r14),%rdx
   1109d:	85 c9                	test   %ecx,%ecx
   1109f:	0f 84 23 07 00 00    	je     117c8 <fwp_write+0x988>
   110a5:	48 89 ef             	mov    %rbp,%rdi
   110a8:	e9 55 0d 00 00       	jmp    11e02 <fwp_write+0xfc2>
   110ad:	4d 8b 0e             	mov    (%r14),%r9
   110b0:	4d 8b 46 08          	mov    0x8(%r14),%r8
   110b4:	4c 89 c8             	mov    %r9,%rax
   110b7:	4c 09 c0             	or     %r8,%rax
   110ba:	0f 84 21 07 00 00    	je     117e1 <fwp_write+0x9a1>
   110c0:	31 ff                	xor    %edi,%edi
   110c2:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
   110c9:	cc cc cc 
   110cc:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
   110d3:	cc cc cc 
   110d6:	4c 89 c3             	mov    %r8,%rbx
   110d9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   110e0:	4c 89 c1             	mov    %r8,%rcx
   110e3:	4c 0f a4 c9 3f       	shld   $0x3f,%r9,%rcx
   110e8:	48 d1 eb             	shr    $1,%rbx
   110eb:	48 89 ce             	mov    %rcx,%rsi
   110ee:	48 01 de             	add    %rbx,%rsi
   110f1:	48 83 d6 00          	adc    $0x0,%rsi
   110f5:	48 89 f0             	mov    %rsi,%rax
   110f8:	49 f7 e2             	mul    %r10
   110fb:	48 c1 ea 02          	shr    $0x2,%rdx
   110ff:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   11103:	48 29 c6             	sub    %rax,%rsi
   11106:	48 29 f1             	sub    %rsi,%rcx
   11109:	48 83 db 00          	sbb    $0x0,%rbx
   1110d:	48 89 ce             	mov    %rcx,%rsi
   11110:	49 0f af f3          	imul   %r11,%rsi
   11114:	48 89 c8             	mov    %rcx,%rax
   11117:	49 f7 e2             	mul    %r10
   1111a:	48 01 f2             	add    %rsi,%rdx
   1111d:	49 0f af da          	imul   %r10,%rbx
   11121:	48 01 d3             	add    %rdx,%rbx
   11124:	48 89 c1             	mov    %rax,%rcx
   11127:	48 01 c1             	add    %rax,%rcx
   1112a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
   1112e:	44 89 ca             	mov    %r9d,%edx
   11131:	29 ca                	sub    %ecx,%edx
   11133:	80 ca 30             	or     $0x30,%dl
   11136:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
   1113a:	48 ff c7             	inc    %rdi
   1113d:	49 83 f9 0a          	cmp    $0xa,%r9
   11141:	49 83 d8 00          	sbb    $0x0,%r8
   11145:	49 89 c1             	mov    %rax,%r9
   11148:	49 89 d8             	mov    %rbx,%r8
   1114b:	73 93                	jae    110e0 <fwp_write+0x2a0>
   1114d:	85 ff                	test   %edi,%edi
   1114f:	0f 8f 96 06 00 00    	jg     117eb <fwp_write+0x9ab>
   11155:	e9 ab 00 00 00       	jmp    11205 <fwp_write+0x3c5>
   1115a:	4d 8b 06             	mov    (%r14),%r8
   1115d:	4d 8b 4e 08          	mov    0x8(%r14),%r9
   11161:	4d 85 c9             	test   %r9,%r9
   11164:	0f 88 a3 06 00 00    	js     1180d <fwp_write+0x9cd>
   1116a:	4c 89 c0             	mov    %r8,%rax
   1116d:	4c 09 c8             	or     %r9,%rax
   11170:	0f 84 cc 09 00 00    	je     11b42 <fwp_write+0xd02>
   11176:	31 ff                	xor    %edi,%edi
   11178:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
   1117f:	cc cc cc 
   11182:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
   11189:	cc cc cc 
   1118c:	4c 89 cb             	mov    %r9,%rbx
   1118f:	90                   	nop
   11190:	4c 89 c9             	mov    %r9,%rcx
   11193:	4c 0f a4 c1 3f       	shld   $0x3f,%r8,%rcx
   11198:	48 d1 eb             	shr    $1,%rbx
   1119b:	48 89 ce             	mov    %rcx,%rsi
   1119e:	48 01 de             	add    %rbx,%rsi
   111a1:	48 83 d6 00          	adc    $0x0,%rsi
   111a5:	48 89 f0             	mov    %rsi,%rax
   111a8:	49 f7 e2             	mul    %r10
   111ab:	48 c1 ea 02          	shr    $0x2,%rdx
   111af:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   111b3:	48 29 c6             	sub    %rax,%rsi
   111b6:	48 29 f1             	sub    %rsi,%rcx
   111b9:	48 83 db 00          	sbb    $0x0,%rbx
   111bd:	48 89 ce             	mov    %rcx,%rsi
   111c0:	49 0f af f3          	imul   %r11,%rsi
   111c4:	48 89 c8             	mov    %rcx,%rax
   111c7:	49 f7 e2             	mul    %r10
   111ca:	48 01 f2             	add    %rsi,%rdx
   111cd:	49 0f af da          	imul   %r10,%rbx
   111d1:	48 01 d3             	add    %rdx,%rbx
   111d4:	48 89 c1             	mov    %rax,%rcx
   111d7:	48 01 c1             	add    %rax,%rcx
   111da:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
   111de:	44 89 c2             	mov    %r8d,%edx
   111e1:	29 ca                	sub    %ecx,%edx
   111e3:	80 ca 30             	or     $0x30,%dl
   111e6:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
   111ea:	48 ff c7             	inc    %rdi
   111ed:	49 83 f8 0a          	cmp    $0xa,%r8
   111f1:	49 83 d9 00          	sbb    $0x0,%r9
   111f5:	49 89 c0             	mov    %rax,%r8
   111f8:	49 89 d9             	mov    %rbx,%r9
   111fb:	73 93                	jae    11190 <fwp_write+0x350>
   111fd:	85 ff                	test   %edi,%edi
   111ff:	0f 8f 47 09 00 00    	jg     11b4c <fwp_write+0xd0c>
   11205:	31 c0                	xor    %eax,%eax
   11207:	e9 67 0e 00 00       	jmp    12073 <fwp_write+0x1233>
   1120c:	c6 44 24 70 5b       	movb   $0x5b,0x70(%rsp)
   11211:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   11216:	ba 01 00 00 00       	mov    $0x1,%edx
   1121b:	48 89 ef             	mov    %rbp,%rdi
   1121e:	e8 ed bf ff ff       	call   d210 <buf_put>
   11223:	4d 85 f6             	test   %r14,%r14
   11226:	0f 84 f6 0c 00 00    	je     11f22 <fwp_write+0x10e2>
   1122c:	49 8b 57 38          	mov    0x38(%r15),%rdx
   11230:	49 8b 76 08          	mov    0x8(%r14),%rsi
   11234:	48 89 ef             	mov    %rbp,%rdi
   11237:	31 c9                	xor    %ecx,%ecx
   11239:	e8 02 fc ff ff       	call   10e40 <fwp_write>
   1123e:	49 8b 5e 10          	mov    0x10(%r14),%rbx
   11242:	48 85 db             	test   %rbx,%rbx
   11245:	0f 84 d7 0c 00 00    	je     11f22 <fwp_write+0x10e2>
   1124b:	4c 8d 35 69 54 00 00 	lea    0x5469(%rip),%r14        # 166bb <exec_in_fp0+0xe4b>
   11252:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   11259:	1f 84 00 00 00 00 00 
   11260:	ba 02 00 00 00       	mov    $0x2,%edx
   11265:	48 89 ef             	mov    %rbp,%rdi
   11268:	4c 89 f6             	mov    %r14,%rsi
   1126b:	e8 a0 bf ff ff       	call   d210 <buf_put>
   11270:	48 8b 73 08          	mov    0x8(%rbx),%rsi
   11274:	49 8b 57 38          	mov    0x38(%r15),%rdx
   11278:	48 89 ef             	mov    %rbp,%rdi
   1127b:	31 c9                	xor    %ecx,%ecx
   1127d:	e8 be fb ff ff       	call   10e40 <fwp_write>
   11282:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
   11286:	48 85 db             	test   %rbx,%rbx
   11289:	75 d5                	jne    11260 <fwp_write+0x420>
   1128b:	e9 92 0c 00 00       	jmp    11f22 <fwp_write+0x10e2>
   11290:	4d 63 67 48          	movslq 0x48(%r15),%r12
   11294:	44 89 e3             	mov    %r12d,%ebx
   11297:	49 8d 54 24 03       	lea    0x3(%r12),%rdx
   1129c:	48 ff 05 05 ac 00 00 	incq   0xac05(%rip)        # 1bea8 <measured_calls>
   112a3:	48 01 15 06 ac 00 00 	add    %rdx,0xac06(%rip)        # 1beb0 <measured_bytes>
   112aa:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
   112b1:	0f 87 59 08 00 00    	ja     11b10 <fwp_write+0xcd0>
   112b7:	49 8d 4c 24 12       	lea    0x12(%r12),%rcx
   112bc:	48 c1 e9 04          	shr    $0x4,%rcx
   112c0:	48 8d 05 c1 8f 00 00 	lea    0x8fc1(%rip),%rax        # 1a288 <fwp_gc>
   112c7:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
   112ce:	00 
   112cf:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
   112d6:	48 29 0d ab 8f 00 00 	sub    %rcx,0x8fab(%rip)        # 1a288 <fwp_gc>
   112dd:	0f 88 2d 08 00 00    	js     11b10 <fwp_write+0xcd0>
   112e3:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
   112e7:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
   112eb:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
   112f2:	4c 8b 3f             	mov    (%rdi),%r15
   112f5:	4d 85 ff             	test   %r15,%r15
   112f8:	0f 84 f6 07 00 00    	je     11af4 <fwp_write+0xcb4>
   112fe:	49 8b 07             	mov    (%r15),%rax
   11301:	48 f7 d0             	not    %rax
   11304:	48 89 07             	mov    %rax,(%rdi)
   11307:	e9 2f 0a 00 00       	jmp    11d3b <fwp_write+0xefb>
   1130c:	49 83 fe ff          	cmp    $0xffffffffffffffff,%r14
   11310:	48 8d 05 b0 53 00 00 	lea    0x53b0(%rip),%rax        # 166c7 <exec_in_fp0+0xe57>
   11317:	48 8d 0d a2 54 00 00 	lea    0x54a2(%rip),%rcx        # 167c0 <exec_in_fp0+0xf50>
   1131e:	48 0f 44 c8          	cmove  %rax,%rcx
   11322:	49 83 fe 01          	cmp    $0x1,%r14
   11326:	4c 8d 35 97 53 00 00 	lea    0x5397(%rip),%r14        # 166c4 <exec_in_fp0+0xe54>
   1132d:	4c 0f 45 f1          	cmovne %rcx,%r14
   11331:	4c 89 f7             	mov    %r14,%rdi
   11334:	e8 37 1e ff ff       	call   3170 <strlen@plt>
   11339:	48 89 ef             	mov    %rbp,%rdi
   1133c:	4c 89 f6             	mov    %r14,%rsi
   1133f:	e9 bb 0a 00 00       	jmp    11dff <fwp_write+0xfbf>
   11344:	48 8d 35 48 54 00 00 	lea    0x5448(%rip),%rsi        # 16793 <exec_in_fp0+0xf23>
   1134b:	ba 06 00 00 00       	mov    $0x6,%edx
   11350:	48 89 ef             	mov    %rbp,%rdi
   11353:	e8 b8 be ff ff       	call   d210 <buf_put>
   11358:	49 8b 36             	mov    (%r14),%rsi
   1135b:	48 8d 04 75 00 00 00 	lea    0x0(,%rsi,2),%rax
   11362:	00 
   11363:	48 85 c0             	test   %rax,%rax
   11366:	0f 84 b6 0b 00 00    	je     11f22 <fwp_write+0x10e2>
   1136c:	49 8b 57 38          	mov    0x38(%r15),%rdx
   11370:	b8 08 00 00 00       	mov    $0x8,%eax
   11375:	48 85 d2             	test   %rdx,%rdx
   11378:	74 13                	je     1138d <fwp_write+0x54d>
   1137a:	8b 0a                	mov    (%rdx),%ecx
   1137c:	48 83 f9 0a          	cmp    $0xa,%rcx
   11380:	77 0b                	ja     1138d <fwp_write+0x54d>
   11382:	48 8d 05 67 45 00 00 	lea    0x4567(%rip),%rax        # 158f0 <exec_in_fp0+0x80>
   11389:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
   1138d:	4d 8d 6e 08          	lea    0x8(%r14),%r13
   11391:	4c 89 e9             	mov    %r13,%rcx
   11394:	48 85 f6             	test   %rsi,%rsi
   11397:	79 04                	jns    1139d <fwp_write+0x55d>
   11399:	49 8b 4e 10          	mov    0x10(%r14),%rcx
   1139d:	48 83 f8 01          	cmp    $0x1,%rax
   113a1:	0f 84 76 0a 00 00    	je     11e1d <fwp_write+0xfdd>
   113a7:	48 83 f8 08          	cmp    $0x8,%rax
   113ab:	0f 84 67 0a 00 00    	je     11e18 <fwp_write+0xfd8>
   113b1:	48 83 f8 02          	cmp    $0x2,%rax
   113b5:	0f 85 6e 0a 00 00    	jne    11e29 <fwp_write+0xfe9>
   113bb:	83 3a 01             	cmpl   $0x1,(%rdx)
   113be:	0f b7 01             	movzwl (%rcx),%eax
   113c1:	48 0f bf f0          	movswq %ax,%rsi
   113c5:	e9 67 0a 00 00       	jmp    11e31 <fwp_write+0xff1>
   113ca:	48 8d 35 b8 53 00 00 	lea    0x53b8(%rip),%rsi        # 16789 <exec_in_fp0+0xf19>
   113d1:	ba 06 00 00 00       	mov    $0x6,%edx
   113d6:	48 89 ef             	mov    %rbp,%rdi
   113d9:	e8 32 be ff ff       	call   d210 <buf_put>
   113de:	49 83 3e 00          	cmpq   $0x0,(%r14)
   113e2:	0f 84 a5 00 00 00    	je     1148d <fwp_write+0x64d>
   113e8:	41 0f b6 4e 08       	movzbl 0x8(%r14),%ecx
   113ed:	48 8d 15 9c 53 00 00 	lea    0x539c(%rip),%rdx        # 16790 <exec_in_fp0+0xf20>
   113f4:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
   113f9:	be 00 02 00 00       	mov    $0x200,%esi
   113fe:	4c 89 ff             	mov    %r15,%rdi
   11401:	31 c0                	xor    %eax,%eax
   11403:	e8 c8 1d ff ff       	call   31d0 <snprintf@plt>
   11408:	4c 89 ff             	mov    %r15,%rdi
   1140b:	e8 60 1d ff ff       	call   3170 <strlen@plt>
   11410:	48 89 ef             	mov    %rbp,%rdi
   11413:	4c 89 fe             	mov    %r15,%rsi
   11416:	48 89 c2             	mov    %rax,%rdx
   11419:	e8 f2 bd ff ff       	call   d210 <buf_put>
   1141e:	49 83 3e 02          	cmpq   $0x2,(%r14)
   11422:	72 69                	jb     1148d <fwp_write+0x64d>
   11424:	bb 09 00 00 00       	mov    $0x9,%ebx
   11429:	4c 8d 3d 8b 52 00 00 	lea    0x528b(%rip),%r15        # 166bb <exec_in_fp0+0xe4b>
   11430:	4c 8d 25 59 53 00 00 	lea    0x5359(%rip),%r12        # 16790 <exec_in_fp0+0xf20>
   11437:	4c 8d 6c 24 70       	lea    0x70(%rsp),%r13
   1143c:	0f 1f 40 00          	nopl   0x0(%rax)
   11440:	ba 02 00 00 00       	mov    $0x2,%edx
   11445:	48 89 ef             	mov    %rbp,%rdi
   11448:	4c 89 fe             	mov    %r15,%rsi
   1144b:	e8 c0 bd ff ff       	call   d210 <buf_put>
   11450:	41 0f b6 0c 1e       	movzbl (%r14,%rbx,1),%ecx
   11455:	be 00 02 00 00       	mov    $0x200,%esi
   1145a:	4c 89 ef             	mov    %r13,%rdi
   1145d:	4c 89 e2             	mov    %r12,%rdx
   11460:	31 c0                	xor    %eax,%eax
   11462:	e8 69 1d ff ff       	call   31d0 <snprintf@plt>
   11467:	4c 89 ef             	mov    %r13,%rdi
   1146a:	e8 01 1d ff ff       	call   3170 <strlen@plt>
   1146f:	48 89 ef             	mov    %rbp,%rdi
   11472:	4c 89 ee             	mov    %r13,%rsi
   11475:	48 89 c2             	mov    %rax,%rdx
   11478:	e8 93 bd ff ff       	call   d210 <buf_put>
   1147d:	48 8d 43 01          	lea    0x1(%rbx),%rax
   11481:	48 83 c3 f9          	add    $0xfffffffffffffff9,%rbx
   11485:	49 3b 1e             	cmp    (%r14),%rbx
   11488:	48 89 c3             	mov    %rax,%rbx
   1148b:	72 b3                	jb     11440 <fwp_write+0x600>
   1148d:	c6 44 24 20 5d       	movb   $0x5d,0x20(%rsp)
   11492:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
   11497:	e9 90 0a 00 00       	jmp    11f2c <fwp_write+0x10ec>
   1149c:	66 41 0f 6e ce       	movd   %r14d,%xmm1
   114a1:	0f 2e c9             	ucomiss %xmm1,%xmm1
   114a4:	0f 8a 73 0d 00 00    	jp     1221d <fwp_write+0x13dd>
   114aa:	0f 28 05 5f 3c 00 00 	movaps 0x3c5f(%rip),%xmm0        # 15110 <_IO_stdin_used+0x110>
   114b1:	0f 54 c1             	andps  %xmm1,%xmm0
   114b4:	0f 2e 05 49 3b 00 00 	ucomiss 0x3b49(%rip),%xmm0        # 15004 <_IO_stdin_used+0x4>
   114bb:	0f 82 6e 04 00 00    	jb     1192f <fwp_write+0xaef>
   114c1:	0f 57 c0             	xorps  %xmm0,%xmm0
   114c4:	0f 2e c8             	ucomiss %xmm0,%xmm1
   114c7:	48 8d 05 21 52 00 00 	lea    0x5221(%rip),%rax        # 166ef <exec_in_fp0+0xe7f>
   114ce:	48 8d 35 19 52 00 00 	lea    0x5219(%rip),%rsi        # 166ee <exec_in_fp0+0xe7e>
   114d5:	48 0f 47 f0          	cmova  %rax,%rsi
   114d9:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   114de:	e8 cd 1b ff ff       	call   30b0 <strcpy@plt>
   114e3:	e9 90 0b 00 00       	jmp    12078 <fwp_write+0x1238>
   114e8:	48 8d 35 7f 52 00 00 	lea    0x527f(%rip),%rsi        # 1676e <exec_in_fp0+0xefe>
   114ef:	ba 0a 00 00 00       	mov    $0xa,%edx
   114f4:	48 89 ef             	mov    %rbp,%rdi
   114f7:	e9 06 09 00 00       	jmp    11e02 <fwp_write+0xfc2>
   114fc:	48 8d 35 7f 52 00 00 	lea    0x527f(%rip),%rsi        # 16782 <exec_in_fp0+0xf12>
   11503:	ba 06 00 00 00       	mov    $0x6,%edx
   11508:	48 89 ef             	mov    %rbp,%rdi
   1150b:	e8 00 bd ff ff       	call   d210 <buf_put>
   11510:	49 83 c6 10          	add    $0x10,%r14
   11514:	4c 89 f7             	mov    %r14,%rdi
   11517:	e8 54 1c ff ff       	call   3170 <strlen@plt>
   1151c:	48 89 ef             	mov    %rbp,%rdi
   1151f:	4c 89 f6             	mov    %r14,%rsi
   11522:	48 89 c2             	mov    %rax,%rdx
   11525:	e8 e6 bc ff ff       	call   d210 <buf_put>
   1152a:	c6 44 24 70 3e       	movb   $0x3e,0x70(%rsp)
   1152f:	e9 f3 09 00 00       	jmp    11f27 <fwp_write+0x10e7>
   11534:	41 8b 06             	mov    (%r14),%eax
   11537:	49 8b 4f 18          	mov    0x18(%r15),%rcx
   1153b:	41 89 c5             	mov    %eax,%r13d
   1153e:	4e 8b 24 e9          	mov    (%rcx,%r13,8),%r12
   11542:	4c 89 e7             	mov    %r12,%rdi
   11545:	e8 26 1c ff ff       	call   3170 <strlen@plt>
   1154a:	48 89 ef             	mov    %rbp,%rdi
   1154d:	4c 89 e6             	mov    %r12,%rsi
   11550:	48 89 c2             	mov    %rax,%rdx
   11553:	e8 b8 bc ff ff       	call   d210 <buf_put>
   11558:	49 8b 47 28          	mov    0x28(%r15),%rax
   1155c:	42 83 3c a8 00       	cmpl   $0x0,(%rax,%r13,4)
   11561:	0f 8e 2c 0b 00 00    	jle    12093 <fwp_write+0x1253>
   11567:	45 31 e4             	xor    %r12d,%r12d
   1156a:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
   1156f:	4c 89 6c 24 68       	mov    %r13,0x68(%rsp)
   11574:	eb 3c                	jmp    115b2 <fwp_write+0x772>
   11576:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   1157d:	00 00 00 
   11580:	48 8b 2c 24          	mov    (%rsp),%rbp
   11584:	48 89 ef             	mov    %rbp,%rdi
   11587:	48 89 de             	mov    %rbx,%rsi
   1158a:	4c 89 ea             	mov    %r13,%rdx
   1158d:	31 c9                	xor    %ecx,%ecx
   1158f:	e8 ac f8 ff ff       	call   10e40 <fwp_write>
   11594:	49 ff c4             	inc    %r12
   11597:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
   1159c:	49 8b 47 28          	mov    0x28(%r15),%rax
   115a0:	4c 8b 6c 24 68       	mov    0x68(%rsp),%r13
   115a5:	4a 63 04 a8          	movslq (%rax,%r13,4),%rax
   115a9:	49 39 c4             	cmp    %rax,%r12
   115ac:	0f 8d e1 0a 00 00    	jge    12093 <fwp_write+0x1253>
   115b2:	4b 8b 5c e6 08       	mov    0x8(%r14,%r12,8),%rbx
   115b7:	49 8b 47 30          	mov    0x30(%r15),%rax
   115bb:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
   115bf:	4e 8b 2c e0          	mov    (%rax,%r12,8),%r13
   115c3:	c6 44 24 70 20       	movb   $0x20,0x70(%rsp)
   115c8:	ba 01 00 00 00       	mov    $0x1,%edx
   115cd:	48 89 ef             	mov    %rbp,%rdi
   115d0:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   115d5:	e8 36 bc ff ff       	call   d210 <buf_put>
   115da:	41 8b 45 00          	mov    0x0(%r13),%eax
   115de:	48 83 f8 10          	cmp    $0x10,%rax
   115e2:	77 9c                	ja     11580 <fwp_write+0x740>
   115e4:	48 8d 0d 75 3f 00 00 	lea    0x3f75(%rip),%rcx        # 15560 <_IO_stdin_used+0x560>
   115eb:	48 63 04 81          	movslq (%rcx,%rax,4),%rax
   115ef:	48 01 c8             	add    %rcx,%rax
   115f2:	ff e0                	jmp    *%rax
   115f4:	48 89 d9             	mov    %rbx,%rcx
   115f7:	48 c1 e9 3f          	shr    $0x3f,%rcx
   115fb:	85 c9                	test   %ecx,%ecx
   115fd:	74 81                	je     11580 <fwp_write+0x740>
   115ff:	c6 44 24 70 28       	movb   $0x28,0x70(%rsp)
   11604:	ba 01 00 00 00       	mov    $0x1,%edx
   11609:	48 8b 2c 24          	mov    (%rsp),%rbp
   1160d:	48 89 ef             	mov    %rbp,%rdi
   11610:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
   11615:	4c 89 fe             	mov    %r15,%rsi
   11618:	e8 f3 bb ff ff       	call   d210 <buf_put>
   1161d:	48 89 ef             	mov    %rbp,%rdi
   11620:	48 89 de             	mov    %rbx,%rsi
   11623:	4c 89 ea             	mov    %r13,%rdx
   11626:	31 c9                	xor    %ecx,%ecx
   11628:	e8 13 f8 ff ff       	call   10e40 <fwp_write>
   1162d:	c6 44 24 70 29       	movb   $0x29,0x70(%rsp)
   11632:	ba 01 00 00 00       	mov    $0x1,%edx
   11637:	48 89 ef             	mov    %rbp,%rdi
   1163a:	4c 89 fe             	mov    %r15,%rsi
   1163d:	e8 ce bb ff ff       	call   d210 <buf_put>
   11642:	e9 4d ff ff ff       	jmp    11594 <fwp_write+0x754>
   11647:	31 c9                	xor    %ecx,%ecx
   11649:	48 81 fb 00 10 00 00 	cmp    $0x1000,%rbx
   11650:	0f 93 c1             	setae  %cl
   11653:	eb a6                	jmp    115fb <fwp_write+0x7bb>
   11655:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
   11659:	eb 9c                	jmp    115f7 <fwp_write+0x7b7>
   1165b:	89 d9                	mov    %ebx,%ecx
   1165d:	c1 e9 1f             	shr    $0x1f,%ecx
   11660:	eb 99                	jmp    115fb <fwp_write+0x7bb>
   11662:	49 8b 7d 08          	mov    0x8(%r13),%rdi
   11666:	48 85 ff             	test   %rdi,%rdi
   11669:	0f 84 11 ff ff ff    	je     11580 <fwp_write+0x740>
   1166f:	48 8d 35 5e 50 00 00 	lea    0x505e(%rip),%rsi        # 166d4 <exec_in_fp0+0xe64>
   11676:	e8 55 1c ff ff       	call   32d0 <strcmp@plt>
   1167b:	31 c9                	xor    %ecx,%ecx
   1167d:	85 c0                	test   %eax,%eax
   1167f:	0f 95 c1             	setne  %cl
   11682:	e9 74 ff ff ff       	jmp    115fb <fwp_write+0x7bb>
   11687:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
   1168c:	0f 84 a7 08 00 00    	je     11f39 <fwp_write+0x10f9>
   11692:	4d 8d 6f 10          	lea    0x10(%r15),%r13
   11696:	4d 85 e4             	test   %r12,%r12
   11699:	0f 94 c0             	sete   %al
   1169c:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
   116a1:	0f 95 c3             	setne  %bl
   116a4:	20 c3                	and    %al,%bl
   116a6:	84 db                	test   %bl,%bl
   116a8:	b8 28 00 00 00       	mov    $0x28,%eax
   116ad:	b9 7b 00 00 00       	mov    $0x7b,%ecx
   116b2:	0f 45 c8             	cmovne %eax,%ecx
   116b5:	88 4c 24 70          	mov    %cl,0x70(%rsp)
   116b9:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   116be:	ba 01 00 00 00       	mov    $0x1,%edx
   116c3:	48 89 ef             	mov    %rbp,%rdi
   116c6:	e8 45 bb ff ff       	call   d210 <buf_put>
   116cb:	41 83 7d 00 00       	cmpl   $0x0,0x0(%r13)
   116d0:	0f 8e da 00 00 00    	jle    117b0 <fwp_write+0x970>
   116d6:	84 db                	test   %bl,%bl
   116d8:	75 31                	jne    1170b <fwp_write+0x8cb>
   116da:	49 8b 47 18          	mov    0x18(%r15),%rax
   116de:	4c 8b 20             	mov    (%rax),%r12
   116e1:	4c 89 e7             	mov    %r12,%rdi
   116e4:	e8 87 1a ff ff       	call   3170 <strlen@plt>
   116e9:	48 89 ef             	mov    %rbp,%rdi
   116ec:	4c 89 e6             	mov    %r12,%rsi
   116ef:	48 89 c2             	mov    %rax,%rdx
   116f2:	e8 19 bb ff ff       	call   d210 <buf_put>
   116f7:	48 8d 35 a9 50 00 00 	lea    0x50a9(%rip),%rsi        # 167a7 <exec_in_fp0+0xf37>
   116fe:	ba 03 00 00 00       	mov    $0x3,%edx
   11703:	48 89 ef             	mov    %rbp,%rdi
   11706:	e8 05 bb ff ff       	call   d210 <buf_put>
   1170b:	49 8b 76 08          	mov    0x8(%r14),%rsi
   1170f:	49 8b 47 20          	mov    0x20(%r15),%rax
   11713:	48 8b 10             	mov    (%rax),%rdx
   11716:	48 89 ef             	mov    %rbp,%rdi
   11719:	31 c9                	xor    %ecx,%ecx
   1171b:	e8 20 f7 ff ff       	call   10e40 <fwp_write>
   11720:	41 83 7f 10 02       	cmpl   $0x2,0x10(%r15)
   11725:	0f 8c 85 00 00 00    	jl     117b0 <fwp_write+0x970>
   1172b:	41 bd 01 00 00 00    	mov    $0x1,%r13d
   11731:	4c 8d 25 83 4f 00 00 	lea    0x4f83(%rip),%r12        # 166bb <exec_in_fp0+0xe4b>
   11738:	eb 29                	jmp    11763 <fwp_write+0x923>
   1173a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   11740:	4b 8b 74 ee 08       	mov    0x8(%r14,%r13,8),%rsi
   11745:	49 8b 47 20          	mov    0x20(%r15),%rax
   11749:	4a 8b 14 e8          	mov    (%rax,%r13,8),%rdx
   1174d:	48 89 ef             	mov    %rbp,%rdi
   11750:	31 c9                	xor    %ecx,%ecx
   11752:	e8 e9 f6 ff ff       	call   10e40 <fwp_write>
   11757:	49 ff c5             	inc    %r13
   1175a:	49 63 47 10          	movslq 0x10(%r15),%rax
   1175e:	49 39 c5             	cmp    %rax,%r13
   11761:	7d 4d                	jge    117b0 <fwp_write+0x970>
   11763:	ba 02 00 00 00       	mov    $0x2,%edx
   11768:	48 89 ef             	mov    %rbp,%rdi
   1176b:	4c 89 e6             	mov    %r12,%rsi
   1176e:	e8 9d ba ff ff       	call   d210 <buf_put>
   11773:	84 db                	test   %bl,%bl
   11775:	75 c9                	jne    11740 <fwp_write+0x900>
   11777:	49 8b 47 18          	mov    0x18(%r15),%rax
   1177b:	4a 8b 2c e8          	mov    (%rax,%r13,8),%rbp
   1177f:	48 89 ef             	mov    %rbp,%rdi
   11782:	e8 e9 19 ff ff       	call   3170 <strlen@plt>
   11787:	48 8b 3c 24          	mov    (%rsp),%rdi
   1178b:	48 89 ee             	mov    %rbp,%rsi
   1178e:	48 8b 2c 24          	mov    (%rsp),%rbp
   11792:	48 89 c2             	mov    %rax,%rdx
   11795:	e8 76 ba ff ff       	call   d210 <buf_put>
   1179a:	ba 03 00 00 00       	mov    $0x3,%edx
   1179f:	48 89 ef             	mov    %rbp,%rdi
   117a2:	48 8d 35 fe 4f 00 00 	lea    0x4ffe(%rip),%rsi        # 167a7 <exec_in_fp0+0xf37>
   117a9:	e8 62 ba ff ff       	call   d210 <buf_put>
   117ae:	eb 90                	jmp    11740 <fwp_write+0x900>
   117b0:	84 db                	test   %bl,%bl
   117b2:	b8 29 00 00 00       	mov    $0x29,%eax
   117b7:	b9 7d 00 00 00       	mov    $0x7d,%ecx
   117bc:	0f 45 c8             	cmovne %eax,%ecx
   117bf:	88 4c 24 70          	mov    %cl,0x70(%rsp)
   117c3:	e9 5f 07 00 00       	jmp    11f27 <fwp_write+0x10e7>
   117c8:	48 89 ef             	mov    %rbp,%rdi
   117cb:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
   117d2:	5b                   	pop    %rbx
   117d3:	41 5c                	pop    %r12
   117d5:	41 5d                	pop    %r13
   117d7:	41 5e                	pop    %r14
   117d9:	41 5f                	pop    %r15
   117db:	5d                   	pop    %rbp
   117dc:	e9 4f 0a 00 00       	jmp    12230 <fwp_escape>
   117e1:	c6 44 24 20 30       	movb   $0x30,0x20(%rsp)
   117e6:	bf 01 00 00 00       	mov    $0x1,%edi
   117eb:	89 f8                	mov    %edi,%eax
   117ed:	48 83 f8 08          	cmp    $0x8,%rax
   117f1:	73 0a                	jae    117fd <fwp_write+0x9bd>
   117f3:	31 c9                	xor    %ecx,%ecx
   117f5:	48 89 c2             	mov    %rax,%rdx
   117f8:	e9 7a 04 00 00       	jmp    11c77 <fwp_write+0xe37>
   117fd:	83 f8 20             	cmp    $0x20,%eax
   11800:	0f 83 68 03 00 00    	jae    11b6e <fwp_write+0xd2e>
   11806:	31 c9                	xor    %ecx,%ecx
   11808:	e9 10 04 00 00       	jmp    11c1d <fwp_write+0xddd>
   1180d:	31 ff                	xor    %edi,%edi
   1180f:	49 f7 d8             	neg    %r8
   11812:	41 ba 00 00 00 00    	mov    $0x0,%r10d
   11818:	4d 19 ca             	sbb    %r9,%r10
   1181b:	c6 44 24 70 2d       	movb   $0x2d,0x70(%rsp)
   11820:	49 b9 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r9
   11827:	cc cc cc 
   1182a:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
   11831:	cc cc cc 
   11834:	4c 89 d3             	mov    %r10,%rbx
   11837:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   1183e:	00 00 
   11840:	4c 89 d1             	mov    %r10,%rcx
   11843:	4c 0f a4 c1 3f       	shld   $0x3f,%r8,%rcx
   11848:	48 d1 eb             	shr    $1,%rbx
   1184b:	48 89 ce             	mov    %rcx,%rsi
   1184e:	48 01 de             	add    %rbx,%rsi
   11851:	48 83 d6 00          	adc    $0x0,%rsi
   11855:	48 89 f0             	mov    %rsi,%rax
   11858:	49 f7 e1             	mul    %r9
   1185b:	48 c1 ea 02          	shr    $0x2,%rdx
   1185f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   11863:	48 29 c6             	sub    %rax,%rsi
   11866:	48 29 f1             	sub    %rsi,%rcx
   11869:	48 83 db 00          	sbb    $0x0,%rbx
   1186d:	48 89 ce             	mov    %rcx,%rsi
   11870:	49 0f af f3          	imul   %r11,%rsi
   11874:	48 89 c8             	mov    %rcx,%rax
   11877:	49 f7 e1             	mul    %r9
   1187a:	48 01 f2             	add    %rsi,%rdx
   1187d:	49 0f af d9          	imul   %r9,%rbx
   11881:	48 01 d3             	add    %rdx,%rbx
   11884:	48 89 c1             	mov    %rax,%rcx
   11887:	48 01 c1             	add    %rax,%rcx
   1188a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
   1188e:	44 89 c2             	mov    %r8d,%edx
   11891:	29 ca                	sub    %ecx,%edx
   11893:	80 ca 30             	or     $0x30,%dl
   11896:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
   1189a:	48 ff c7             	inc    %rdi
   1189d:	49 83 f8 0a          	cmp    $0xa,%r8
   118a1:	49 83 da 00          	sbb    $0x0,%r10
   118a5:	49 89 c0             	mov    %rax,%r8
   118a8:	49 89 da             	mov    %rbx,%r10
   118ab:	73 93                	jae    11840 <fwp_write+0xa00>
   118ad:	85 ff                	test   %edi,%edi
   118af:	0f 8e 98 06 00 00    	jle    11f4d <fwp_write+0x110d>
   118b5:	89 f8                	mov    %edi,%eax
   118b7:	48 83 f8 08          	cmp    $0x8,%rax
   118bb:	0f 83 e4 07 00 00    	jae    120a5 <fwp_write+0x1265>
   118c1:	31 c9                	xor    %ecx,%ecx
   118c3:	48 89 c2             	mov    %rax,%rdx
   118c6:	e9 fc 08 00 00       	jmp    121c7 <fwp_write+0x1387>
   118cb:	bd 01 00 00 00       	mov    $0x1,%ebp
   118d0:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   118d5:	0f 29 4c 24 10       	movaps %xmm1,0x10(%rsp)
   118da:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   118e0:	4c 89 f7             	mov    %r14,%rdi
   118e3:	66 0f 28 c1          	movapd %xmm1,%xmm0
   118e7:	89 ee                	mov    %ebp,%esi
   118e9:	e8 b2 15 00 00       	call   12ea0 <fwp_format_g>
   118ee:	4c 89 f7             	mov    %r14,%rdi
   118f1:	31 f6                	xor    %esi,%esi
   118f3:	e8 08 18 ff ff       	call   3100 <strtod@plt>
   118f8:	66 0f 28 4c 24 10    	movapd 0x10(%rsp),%xmm1
   118fe:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
   11902:	75 06                	jne    1190a <fwp_write+0xaca>
   11904:	0f 8b 9e 03 00 00    	jnp    11ca8 <fwp_write+0xe68>
   1190a:	ff c5                	inc    %ebp
   1190c:	83 fd 12             	cmp    $0x12,%ebp
   1190f:	75 cf                	jne    118e0 <fwp_write+0xaa0>
   11911:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11916:	4c 89 f7             	mov    %r14,%rdi
   11919:	66 0f 28 c1          	movapd %xmm1,%xmm0
   1191d:	be 11 00 00 00       	mov    $0x11,%esi
   11922:	e8 79 15 00 00       	call   12ea0 <fwp_format_g>
   11927:	4c 89 f7             	mov    %r14,%rdi
   1192a:	e9 7e 03 00 00       	jmp    11cad <fwp_write+0xe6d>
   1192f:	0f 57 c0             	xorps  %xmm0,%xmm0
   11932:	f3 0f 5a c1          	cvtss2sd %xmm1,%xmm0
   11936:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   1193b:	4c 89 f7             	mov    %r14,%rdi
   1193e:	f2 0f 11 44 24 10    	movsd  %xmm0,0x10(%rsp)
   11944:	be 01 00 00 00       	mov    $0x1,%esi
   11949:	0f 29 0c 24          	movaps %xmm1,(%rsp)
   1194d:	e8 4e 15 00 00       	call   12ea0 <fwp_format_g>
   11952:	4c 89 f7             	mov    %r14,%rdi
   11955:	31 f6                	xor    %esi,%esi
   11957:	e8 a4 18 ff ff       	call   3200 <strtof@plt>
   1195c:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   11960:	75 06                	jne    11968 <fwp_write+0xb28>
   11962:	0f 8b 6f 01 00 00    	jnp    11ad7 <fwp_write+0xc97>
   11968:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   1196d:	4c 89 f7             	mov    %r14,%rdi
   11970:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   11976:	be 02 00 00 00       	mov    $0x2,%esi
   1197b:	e8 20 15 00 00       	call   12ea0 <fwp_format_g>
   11980:	4c 89 f7             	mov    %r14,%rdi
   11983:	31 f6                	xor    %esi,%esi
   11985:	e8 76 18 ff ff       	call   3200 <strtof@plt>
   1198a:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   1198e:	75 06                	jne    11996 <fwp_write+0xb56>
   11990:	0f 8b 41 01 00 00    	jnp    11ad7 <fwp_write+0xc97>
   11996:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   1199b:	4c 89 f7             	mov    %r14,%rdi
   1199e:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   119a4:	be 03 00 00 00       	mov    $0x3,%esi
   119a9:	e8 f2 14 00 00       	call   12ea0 <fwp_format_g>
   119ae:	4c 89 f7             	mov    %r14,%rdi
   119b1:	31 f6                	xor    %esi,%esi
   119b3:	e8 48 18 ff ff       	call   3200 <strtof@plt>
   119b8:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   119bc:	75 06                	jne    119c4 <fwp_write+0xb84>
   119be:	0f 8b 13 01 00 00    	jnp    11ad7 <fwp_write+0xc97>
   119c4:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   119c9:	4c 89 f7             	mov    %r14,%rdi
   119cc:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   119d2:	be 04 00 00 00       	mov    $0x4,%esi
   119d7:	e8 c4 14 00 00       	call   12ea0 <fwp_format_g>
   119dc:	4c 89 f7             	mov    %r14,%rdi
   119df:	31 f6                	xor    %esi,%esi
   119e1:	e8 1a 18 ff ff       	call   3200 <strtof@plt>
   119e6:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   119ea:	75 06                	jne    119f2 <fwp_write+0xbb2>
   119ec:	0f 8b e5 00 00 00    	jnp    11ad7 <fwp_write+0xc97>
   119f2:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   119f7:	4c 89 f7             	mov    %r14,%rdi
   119fa:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   11a00:	be 05 00 00 00       	mov    $0x5,%esi
   11a05:	e8 96 14 00 00       	call   12ea0 <fwp_format_g>
   11a0a:	4c 89 f7             	mov    %r14,%rdi
   11a0d:	31 f6                	xor    %esi,%esi
   11a0f:	e8 ec 17 ff ff       	call   3200 <strtof@plt>
   11a14:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   11a18:	75 06                	jne    11a20 <fwp_write+0xbe0>
   11a1a:	0f 8b b7 00 00 00    	jnp    11ad7 <fwp_write+0xc97>
   11a20:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11a25:	4c 89 f7             	mov    %r14,%rdi
   11a28:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   11a2e:	be 06 00 00 00       	mov    $0x6,%esi
   11a33:	e8 68 14 00 00       	call   12ea0 <fwp_format_g>
   11a38:	4c 89 f7             	mov    %r14,%rdi
   11a3b:	31 f6                	xor    %esi,%esi
   11a3d:	e8 be 17 ff ff       	call   3200 <strtof@plt>
   11a42:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   11a46:	75 06                	jne    11a4e <fwp_write+0xc0e>
   11a48:	0f 8b 89 00 00 00    	jnp    11ad7 <fwp_write+0xc97>
   11a4e:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11a53:	4c 89 f7             	mov    %r14,%rdi
   11a56:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   11a5c:	be 07 00 00 00       	mov    $0x7,%esi
   11a61:	e8 3a 14 00 00       	call   12ea0 <fwp_format_g>
   11a66:	4c 89 f7             	mov    %r14,%rdi
   11a69:	31 f6                	xor    %esi,%esi
   11a6b:	e8 90 17 ff ff       	call   3200 <strtof@plt>
   11a70:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   11a74:	75 02                	jne    11a78 <fwp_write+0xc38>
   11a76:	7b 5f                	jnp    11ad7 <fwp_write+0xc97>
   11a78:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11a7d:	4c 89 f7             	mov    %r14,%rdi
   11a80:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   11a86:	be 08 00 00 00       	mov    $0x8,%esi
   11a8b:	e8 10 14 00 00       	call   12ea0 <fwp_format_g>
   11a90:	4c 89 f7             	mov    %r14,%rdi
   11a93:	31 f6                	xor    %esi,%esi
   11a95:	e8 66 17 ff ff       	call   3200 <strtof@plt>
   11a9a:	0f 28 0c 24          	movaps (%rsp),%xmm1
   11a9e:	0f 2e c1             	ucomiss %xmm1,%xmm0
   11aa1:	75 02                	jne    11aa5 <fwp_write+0xc65>
   11aa3:	7b 32                	jnp    11ad7 <fwp_write+0xc97>
   11aa5:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11aaa:	4c 89 f7             	mov    %r14,%rdi
   11aad:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   11ab3:	be 09 00 00 00       	mov    $0x9,%esi
   11ab8:	e8 e3 13 00 00       	call   12ea0 <fwp_format_g>
   11abd:	4c 89 f7             	mov    %r14,%rdi
   11ac0:	31 f6                	xor    %esi,%esi
   11ac2:	e8 39 17 ff ff       	call   3200 <strtof@plt>
   11ac7:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   11acb:	0f 85 2c 07 00 00    	jne    121fd <fwp_write+0x13bd>
   11ad1:	0f 8a 26 07 00 00    	jp     121fd <fwp_write+0x13bd>
   11ad7:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   11adc:	be 2e 00 00 00       	mov    $0x2e,%esi
   11ae1:	e8 ca 16 ff ff       	call   31b0 <strchr@plt>
   11ae6:	48 85 c0             	test   %rax,%rax
   11ae9:	0f 85 89 05 00 00    	jne    12078 <fwp_write+0x1238>
   11aef:	e9 d0 01 00 00       	jmp    11cc4 <fwp_write+0xe84>
   11af4:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
   11afb:	00 
   11afc:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
   11b03:	00 
   11b04:	4c 29 ff             	sub    %r15,%rdi
   11b07:	48 39 cf             	cmp    %rcx,%rdi
   11b0a:	0f 83 1b 02 00 00    	jae    11d2b <fwp_write+0xeeb>
   11b10:	48 89 d7             	mov    %rdx,%rdi
   11b13:	be 01 00 00 00       	mov    $0x1,%esi
   11b18:	e8 a3 67 ff ff       	call   82c0 <fwp_gc_alloc_slow>
   11b1d:	49 89 c7             	mov    %rax,%r15
   11b20:	e9 20 02 00 00       	jmp    11d45 <fwp_write+0xf05>
   11b25:	49 8b 76 08          	mov    0x8(%r14),%rsi
   11b29:	48 89 f2             	mov    %rsi,%rdx
   11b2c:	48 c1 fa 3f          	sar    $0x3f,%rdx
   11b30:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11b35:	4c 89 f7             	mov    %r14,%rdi
   11b38:	e8 33 08 00 00       	call   12370 <fwp_fmt_duration>
   11b3d:	e9 3b 05 00 00       	jmp    1207d <fwp_write+0x123d>
   11b42:	c6 44 24 20 30       	movb   $0x30,0x20(%rsp)
   11b47:	bf 01 00 00 00       	mov    $0x1,%edi
   11b4c:	89 f8                	mov    %edi,%eax
   11b4e:	48 83 f8 08          	cmp    $0x8,%rax
   11b52:	73 0a                	jae    11b5e <fwp_write+0xd1e>
   11b54:	31 c9                	xor    %ecx,%ecx
   11b56:	48 89 c2             	mov    %rax,%rdx
   11b59:	e9 f2 04 00 00       	jmp    12050 <fwp_write+0x1210>
   11b5e:	83 f8 20             	cmp    $0x20,%eax
   11b61:	0f 83 f2 03 00 00    	jae    11f59 <fwp_write+0x1119>
   11b67:	31 c9                	xor    %ecx,%ecx
   11b69:	e9 92 04 00 00       	jmp    12000 <fwp_write+0x11c0>
   11b6e:	89 fa                	mov    %edi,%edx
   11b70:	83 e2 1f             	and    $0x1f,%edx
   11b73:	48 89 c1             	mov    %rax,%rcx
   11b76:	48 29 d1             	sub    %rdx,%rcx
   11b79:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
   11b80:	00 
   11b81:	66 0f ef c0          	pxor   %xmm0,%xmm0
   11b85:	49 89 c0             	mov    %rax,%r8
   11b88:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   11b8f:	00 
   11b90:	f3 42 0f 6f 0c 04    	movdqu (%rsp,%r8,1),%xmm1
   11b96:	f3 42 0f 6f 54 04 10 	movdqu 0x10(%rsp,%r8,1),%xmm2
   11b9d:	66 0f 6f da          	movdqa %xmm2,%xmm3
   11ba1:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   11ba5:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   11baa:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   11baf:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   11bb4:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   11bb8:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   11bbd:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   11bc2:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   11bc7:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   11bcb:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   11bcf:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   11bd3:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   11bd8:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   11bdd:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   11be2:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   11be6:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   11beb:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   11bf0:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   11bf5:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   11bf9:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
   11bfe:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
   11c02:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
   11c06:	48 83 c6 20          	add    $0x20,%rsi
   11c0a:	4c 39 c2             	cmp    %r8,%rdx
   11c0d:	75 81                	jne    11b90 <fwp_write+0xd50>
   11c0f:	48 85 d2             	test   %rdx,%rdx
   11c12:	0f 84 5b 04 00 00    	je     12073 <fwp_write+0x1233>
   11c18:	83 fa 08             	cmp    $0x8,%edx
   11c1b:	72 5a                	jb     11c77 <fwp_write+0xe37>
   11c1d:	89 fa                	mov    %edi,%edx
   11c1f:	83 e2 07             	and    $0x7,%edx
   11c22:	48 89 c6             	mov    %rax,%rsi
   11c25:	48 29 ce             	sub    %rcx,%rsi
   11c28:	48 8d 3c 0c          	lea    (%rsp,%rcx,1),%rdi
   11c2c:	48 83 c7 70          	add    $0x70,%rdi
   11c30:	48 89 c1             	mov    %rax,%rcx
   11c33:	48 29 d1             	sub    %rdx,%rcx
   11c36:	66 0f ef c0          	pxor   %xmm0,%xmm0
   11c3a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   11c40:	f3 0f 7e 4c 34 18    	movq   0x18(%rsp,%rsi,1),%xmm1
   11c46:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   11c4a:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   11c4f:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   11c54:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   11c59:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   11c5d:	66 0f d6 0f          	movq   %xmm1,(%rdi)
   11c61:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
   11c65:	48 83 c7 08          	add    $0x8,%rdi
   11c69:	48 39 f2             	cmp    %rsi,%rdx
   11c6c:	75 d2                	jne    11c40 <fwp_write+0xe00>
   11c6e:	48 85 d2             	test   %rdx,%rdx
   11c71:	0f 84 fc 03 00 00    	je     12073 <fwp_write+0x1233>
   11c77:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
   11c7c:	48 01 f2             	add    %rsi,%rdx
   11c7f:	48 ff ca             	dec    %rdx
   11c82:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   11c89:	1f 84 00 00 00 00 00 
   11c90:	0f b6 32             	movzbl (%rdx),%esi
   11c93:	40 88 74 0c 70       	mov    %sil,0x70(%rsp,%rcx,1)
   11c98:	48 ff c1             	inc    %rcx
   11c9b:	48 ff ca             	dec    %rdx
   11c9e:	48 39 c8             	cmp    %rcx,%rax
   11ca1:	75 ed                	jne    11c90 <fwp_write+0xe50>
   11ca3:	e9 cb 03 00 00       	jmp    12073 <fwp_write+0x1233>
   11ca8:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   11cad:	be 2e 00 00 00       	mov    $0x2e,%esi
   11cb2:	e8 f9 14 ff ff       	call   31b0 <strchr@plt>
   11cb7:	48 85 c0             	test   %rax,%rax
   11cba:	48 8b 2c 24          	mov    (%rsp),%rbp
   11cbe:	0f 85 b4 03 00 00    	jne    12078 <fwp_write+0x1238>
   11cc4:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   11cc9:	be 65 00 00 00       	mov    $0x65,%esi
   11cce:	e8 dd 14 ff ff       	call   31b0 <strchr@plt>
   11cd3:	48 85 c0             	test   %rax,%rax
   11cd6:	0f 85 9c 03 00 00    	jne    12078 <fwp_write+0x1238>
   11cdc:	48 8d 35 0c 4a 00 00 	lea    0x4a0c(%rip),%rsi        # 166ef <exec_in_fp0+0xe7f>
   11ce3:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   11ce8:	e8 e3 17 ff ff       	call   34d0 <strstr@plt>
   11ced:	48 85 c0             	test   %rax,%rax
   11cf0:	0f 85 82 03 00 00    	jne    12078 <fwp_write+0x1238>
   11cf6:	48 8d 35 f6 49 00 00 	lea    0x49f6(%rip),%rsi        # 166f3 <exec_in_fp0+0xe83>
   11cfd:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   11d02:	e8 c9 17 ff ff       	call   34d0 <strstr@plt>
   11d07:	48 85 c0             	test   %rax,%rax
   11d0a:	0f 85 68 03 00 00    	jne    12078 <fwp_write+0x1238>
   11d10:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   11d15:	e8 56 14 ff ff       	call   3170 <strlen@plt>
   11d1a:	66 c7 44 04 70 2e 30 	movw   $0x302e,0x70(%rsp,%rax,1)
   11d21:	c6 44 04 72 00       	movb   $0x0,0x72(%rsp,%rax,1)
   11d26:	e9 4d 03 00 00       	jmp    12078 <fwp_write+0x1238>
   11d2b:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
   11d2f:	48 05 d0 03 00 00    	add    $0x3d0,%rax
   11d35:	4c 01 f9             	add    %r15,%rcx
   11d38:	48 89 08             	mov    %rcx,(%rax)
   11d3b:	4c 89 ff             	mov    %r15,%rdi
   11d3e:	31 f6                	xor    %esi,%esi
   11d40:	e8 cb 14 ff ff       	call   3210 <memset@plt>
   11d45:	66 41 c7 07 30 74    	movw   $0x7430,(%r15)
   11d4b:	85 db                	test   %ebx,%ebx
   11d4d:	0f 8e 98 00 00 00    	jle    11deb <fwp_write+0xfab>
   11d53:	44 89 e1             	mov    %r12d,%ecx
   11d56:	48 f7 d9             	neg    %rcx
   11d59:	4a 8d 34 3b          	lea    (%rbx,%r15,1),%rsi
   11d5d:	48 ff c6             	inc    %rsi
   11d60:	31 ff                	xor    %edi,%edi
   11d62:	49 b8 56 55 55 55 55 	movabs $0x5555555555555556,%r8
   11d69:	55 55 55 
   11d6c:	eb 2e                	jmp    11d9c <fwp_write+0xf5c>
   11d6e:	66 90                	xchg   %ax,%ax
   11d70:	41 b2 30             	mov    $0x30,%r10b
   11d73:	44 88 14 3e          	mov    %r10b,(%rsi,%rdi,1)
   11d77:	48 85 d2             	test   %rdx,%rdx
   11d7a:	0f 95 c2             	setne  %dl
   11d7d:	4d 85 f6             	test   %r14,%r14
   11d80:	41 0f 98 c2          	sets   %r10b
   11d84:	41 20 d2             	and    %dl,%r10b
   11d87:	41 0f b6 d2          	movzbl %r10b,%edx
   11d8b:	48 29 d0             	sub    %rdx,%rax
   11d8e:	4c 01 c8             	add    %r9,%rax
   11d91:	48 ff cf             	dec    %rdi
   11d94:	49 89 c6             	mov    %rax,%r14
   11d97:	48 39 f9             	cmp    %rdi,%rcx
   11d9a:	74 4f                	je     11deb <fwp_write+0xfab>
   11d9c:	4c 89 f0             	mov    %r14,%rax
   11d9f:	49 f7 e8             	imul   %r8
   11da2:	48 89 d0             	mov    %rdx,%rax
   11da5:	48 c1 e8 3f          	shr    $0x3f,%rax
   11da9:	48 01 d0             	add    %rdx,%rax
   11dac:	4c 8d 0c 40          	lea    (%rax,%rax,2),%r9
   11db0:	4c 89 f2             	mov    %r14,%rdx
   11db3:	4c 29 ca             	sub    %r9,%rdx
   11db6:	49 f7 d9             	neg    %r9
   11db9:	4d 01 f1             	add    %r14,%r9
   11dbc:	49 83 c1 03          	add    $0x3,%r9
   11dc0:	48 83 fa fd          	cmp    $0xfffffffffffffffd,%rdx
   11dc4:	4c 0f 42 ca          	cmovb  %rdx,%r9
   11dc8:	4d 85 c9             	test   %r9,%r9
   11dcb:	74 a3                	je     11d70 <fwp_write+0xf30>
   11dcd:	49 83 f9 01          	cmp    $0x1,%r9
   11dd1:	75 0d                	jne    11de0 <fwp_write+0xfa0>
   11dd3:	41 b2 2b             	mov    $0x2b,%r10b
   11dd6:	45 31 c9             	xor    %r9d,%r9d
   11dd9:	eb 98                	jmp    11d73 <fwp_write+0xf33>
   11ddb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   11de0:	41 b2 2d             	mov    $0x2d,%r10b
   11de3:	41 b9 01 00 00 00    	mov    $0x1,%r9d
   11de9:	eb 88                	jmp    11d73 <fwp_write+0xf33>
   11deb:	43 c6 44 27 02 00    	movb   $0x0,0x2(%r15,%r12,1)
   11df1:	4c 89 ff             	mov    %r15,%rdi
   11df4:	e8 77 13 ff ff       	call   3170 <strlen@plt>
   11df9:	48 89 ef             	mov    %rbp,%rdi
   11dfc:	4c 89 fe             	mov    %r15,%rsi
   11dff:	48 89 c2             	mov    %rax,%rdx
   11e02:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
   11e09:	5b                   	pop    %rbx
   11e0a:	41 5c                	pop    %r12
   11e0c:	41 5d                	pop    %r13
   11e0e:	41 5e                	pop    %r14
   11e10:	41 5f                	pop    %r15
   11e12:	5d                   	pop    %rbp
   11e13:	e9 f8 b3 ff ff       	jmp    d210 <buf_put>
   11e18:	48 8b 31             	mov    (%rcx),%rsi
   11e1b:	eb 18                	jmp    11e35 <fwp_write+0xff5>
   11e1d:	83 3a 00             	cmpl   $0x0,(%rdx)
   11e20:	0f b6 01             	movzbl (%rcx),%eax
   11e23:	48 0f be f0          	movsbq %al,%rsi
   11e27:	eb 08                	jmp    11e31 <fwp_write+0xff1>
   11e29:	83 3a 02             	cmpl   $0x2,(%rdx)
   11e2c:	8b 01                	mov    (%rcx),%eax
   11e2e:	48 63 f0             	movslq %eax,%rsi
   11e31:	48 0f 45 f0          	cmovne %rax,%rsi
   11e35:	48 8b 2c 24          	mov    (%rsp),%rbp
   11e39:	48 89 ef             	mov    %rbp,%rdi
   11e3c:	31 c9                	xor    %ecx,%ecx
   11e3e:	e8 fd ef ff ff       	call   10e40 <fwp_write>
   11e43:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
   11e4a:	ff ff 7f 
   11e4d:	48 ff c8             	dec    %rax
   11e50:	49 85 06             	test   %rax,(%r14)
   11e53:	0f 84 c9 00 00 00    	je     11f22 <fwp_write+0x10e2>
   11e59:	bb 01 00 00 00       	mov    $0x1,%ebx
   11e5e:	4c 8d 25 56 48 00 00 	lea    0x4856(%rip),%r12        # 166bb <exec_in_fp0+0xe4b>
   11e65:	eb 39                	jmp    11ea0 <fwp_write+0x1060>
   11e67:	83 3a 01             	cmpl   $0x1,(%rdx)
   11e6a:	0f b7 04 31          	movzwl (%rcx,%rsi,1),%eax
   11e6e:	48 0f bf f0          	movswq %ax,%rsi
   11e72:	48 0f 45 f0          	cmovne %rax,%rsi
   11e76:	48 8b 2c 24          	mov    (%rsp),%rbp
   11e7a:	48 89 ef             	mov    %rbp,%rdi
   11e7d:	31 c9                	xor    %ecx,%ecx
   11e7f:	e8 bc ef ff ff       	call   10e40 <fwp_write>
   11e84:	48 ff c3             	inc    %rbx
   11e87:	49 8b 06             	mov    (%r14),%rax
   11e8a:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
   11e91:	ff ff 7f 
   11e94:	48 21 c8             	and    %rcx,%rax
   11e97:	48 39 c3             	cmp    %rax,%rbx
   11e9a:	0f 83 82 00 00 00    	jae    11f22 <fwp_write+0x10e2>
   11ea0:	ba 02 00 00 00       	mov    $0x2,%edx
   11ea5:	48 89 ef             	mov    %rbp,%rdi
   11ea8:	4c 89 e6             	mov    %r12,%rsi
   11eab:	e8 60 b3 ff ff       	call   d210 <buf_put>
   11eb0:	49 8b 57 38          	mov    0x38(%r15),%rdx
   11eb4:	b8 08 00 00 00       	mov    $0x8,%eax
   11eb9:	48 85 d2             	test   %rdx,%rdx
   11ebc:	74 13                	je     11ed1 <fwp_write+0x1091>
   11ebe:	8b 0a                	mov    (%rdx),%ecx
   11ec0:	48 83 f9 0a          	cmp    $0xa,%rcx
   11ec4:	77 0b                	ja     11ed1 <fwp_write+0x1091>
   11ec6:	48 8d 05 23 3a 00 00 	lea    0x3a23(%rip),%rax        # 158f0 <exec_in_fp0+0x80>
   11ecd:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
   11ed1:	49 83 3e 00          	cmpq   $0x0,(%r14)
   11ed5:	4c 89 e9             	mov    %r13,%rcx
   11ed8:	79 04                	jns    11ede <fwp_write+0x109e>
   11eda:	49 8b 4e 10          	mov    0x10(%r14),%rcx
   11ede:	48 89 c6             	mov    %rax,%rsi
   11ee1:	48 0f af f3          	imul   %rbx,%rsi
   11ee5:	48 83 f8 01          	cmp    $0x1,%rax
   11ee9:	74 19                	je     11f04 <fwp_write+0x10c4>
   11eeb:	48 83 f8 02          	cmp    $0x2,%rax
   11eef:	0f 84 72 ff ff ff    	je     11e67 <fwp_write+0x1027>
   11ef5:	48 83 f8 08          	cmp    $0x8,%rax
   11ef9:	75 19                	jne    11f14 <fwp_write+0x10d4>
   11efb:	48 8b 34 31          	mov    (%rcx,%rsi,1),%rsi
   11eff:	e9 72 ff ff ff       	jmp    11e76 <fwp_write+0x1036>
   11f04:	83 3a 00             	cmpl   $0x0,(%rdx)
   11f07:	0f b6 04 31          	movzbl (%rcx,%rsi,1),%eax
   11f0b:	48 0f be f0          	movsbq %al,%rsi
   11f0f:	e9 5e ff ff ff       	jmp    11e72 <fwp_write+0x1032>
   11f14:	83 3a 02             	cmpl   $0x2,(%rdx)
   11f17:	8b 04 31             	mov    (%rcx,%rsi,1),%eax
   11f1a:	48 63 f0             	movslq %eax,%rsi
   11f1d:	e9 50 ff ff ff       	jmp    11e72 <fwp_write+0x1032>
   11f22:	c6 44 24 70 5d       	movb   $0x5d,0x70(%rsp)
   11f27:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   11f2c:	ba 01 00 00 00       	mov    $0x1,%edx
   11f31:	48 89 ef             	mov    %rbp,%rdi
   11f34:	e9 55 01 00 00       	jmp    1208e <fwp_write+0x124e>
   11f39:	48 8d 35 64 48 00 00 	lea    0x4864(%rip),%rsi        # 167a4 <exec_in_fp0+0xf34>
   11f40:	ba 02 00 00 00       	mov    $0x2,%edx
   11f45:	48 89 ef             	mov    %rbp,%rdi
   11f48:	e9 b5 fe ff ff       	jmp    11e02 <fwp_write+0xfc2>
   11f4d:	31 c0                	xor    %eax,%eax
   11f4f:	c6 44 04 71 00       	movb   $0x0,0x71(%rsp,%rax,1)
   11f54:	e9 1f 01 00 00       	jmp    12078 <fwp_write+0x1238>
   11f59:	89 fa                	mov    %edi,%edx
   11f5b:	83 e2 1f             	and    $0x1f,%edx
   11f5e:	48 89 c1             	mov    %rax,%rcx
   11f61:	48 29 d1             	sub    %rdx,%rcx
   11f64:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
   11f6b:	00 
   11f6c:	66 0f ef c0          	pxor   %xmm0,%xmm0
   11f70:	49 89 c0             	mov    %rax,%r8
   11f73:	f3 42 0f 6f 0c 04    	movdqu (%rsp,%r8,1),%xmm1
   11f79:	f3 42 0f 6f 54 04 10 	movdqu 0x10(%rsp,%r8,1),%xmm2
   11f80:	66 0f 6f da          	movdqa %xmm2,%xmm3
   11f84:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   11f88:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   11f8d:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   11f92:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   11f97:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   11f9b:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   11fa0:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   11fa5:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   11faa:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   11fae:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   11fb2:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   11fb6:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   11fbb:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   11fc0:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   11fc5:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   11fc9:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   11fce:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   11fd3:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   11fd8:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   11fdc:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
   11fe1:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
   11fe5:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
   11fe9:	48 83 c6 20          	add    $0x20,%rsi
   11fed:	4c 39 c2             	cmp    %r8,%rdx
   11ff0:	75 81                	jne    11f73 <fwp_write+0x1133>
   11ff2:	48 85 d2             	test   %rdx,%rdx
   11ff5:	0f 84 78 00 00 00    	je     12073 <fwp_write+0x1233>
   11ffb:	83 fa 08             	cmp    $0x8,%edx
   11ffe:	72 50                	jb     12050 <fwp_write+0x1210>
   12000:	89 fa                	mov    %edi,%edx
   12002:	83 e2 07             	and    $0x7,%edx
   12005:	48 89 c6             	mov    %rax,%rsi
   12008:	48 29 ce             	sub    %rcx,%rsi
   1200b:	48 8d 3c 0c          	lea    (%rsp,%rcx,1),%rdi
   1200f:	48 83 c7 70          	add    $0x70,%rdi
   12013:	48 89 c1             	mov    %rax,%rcx
   12016:	48 29 d1             	sub    %rdx,%rcx
   12019:	66 0f ef c0          	pxor   %xmm0,%xmm0
   1201d:	f3 0f 7e 4c 34 18    	movq   0x18(%rsp,%rsi,1),%xmm1
   12023:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   12027:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   1202c:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12031:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12036:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   1203a:	66 0f d6 0f          	movq   %xmm1,(%rdi)
   1203e:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
   12042:	48 83 c7 08          	add    $0x8,%rdi
   12046:	48 39 f2             	cmp    %rsi,%rdx
   12049:	75 d2                	jne    1201d <fwp_write+0x11dd>
   1204b:	48 85 d2             	test   %rdx,%rdx
   1204e:	74 23                	je     12073 <fwp_write+0x1233>
   12050:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
   12055:	48 01 f2             	add    %rsi,%rdx
   12058:	48 ff ca             	dec    %rdx
   1205b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   12060:	0f b6 32             	movzbl (%rdx),%esi
   12063:	40 88 74 0c 70       	mov    %sil,0x70(%rsp,%rcx,1)
   12068:	48 ff c1             	inc    %rcx
   1206b:	48 ff ca             	dec    %rdx
   1206e:	48 39 c8             	cmp    %rcx,%rax
   12071:	75 ed                	jne    12060 <fwp_write+0x1220>
   12073:	c6 44 04 70 00       	movb   $0x0,0x70(%rsp,%rax,1)
   12078:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   1207d:	4c 89 f7             	mov    %r14,%rdi
   12080:	e8 eb 10 ff ff       	call   3170 <strlen@plt>
   12085:	48 89 ef             	mov    %rbp,%rdi
   12088:	4c 89 f6             	mov    %r14,%rsi
   1208b:	48 89 c2             	mov    %rax,%rdx
   1208e:	e8 7d b1 ff ff       	call   d210 <buf_put>
   12093:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
   1209a:	5b                   	pop    %rbx
   1209b:	41 5c                	pop    %r12
   1209d:	41 5d                	pop    %r13
   1209f:	41 5e                	pop    %r14
   120a1:	41 5f                	pop    %r15
   120a3:	5d                   	pop    %rbp
   120a4:	c3                   	ret
   120a5:	83 f8 20             	cmp    $0x20,%eax
   120a8:	73 07                	jae    120b1 <fwp_write+0x1271>
   120aa:	31 c9                	xor    %ecx,%ecx
   120ac:	e9 b6 00 00 00       	jmp    12167 <fwp_write+0x1327>
   120b1:	89 fe                	mov    %edi,%esi
   120b3:	89 fa                	mov    %edi,%edx
   120b5:	83 e2 1f             	and    $0x1f,%edx
   120b8:	48 89 c1             	mov    %rax,%rcx
   120bb:	48 29 d1             	sub    %rdx,%rcx
   120be:	4c 8d 04 34          	lea    (%rsp,%rsi,1),%r8
   120c2:	49 83 c0 10          	add    $0x10,%r8
   120c6:	48 29 d6             	sub    %rdx,%rsi
   120c9:	45 31 c9             	xor    %r9d,%r9d
   120cc:	66 0f ef c0          	pxor   %xmm0,%xmm0
   120d0:	f3 41 0f 6f 48 f0    	movdqu -0x10(%r8),%xmm1
   120d6:	f3 41 0f 6f 10       	movdqu (%r8),%xmm2
   120db:	66 0f 6f da          	movdqa %xmm2,%xmm3
   120df:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   120e3:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   120e8:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   120ed:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   120f2:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   120f6:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   120fb:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   12100:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   12105:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   12109:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   1210d:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12111:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12116:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   1211b:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12120:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   12124:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   12129:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   1212e:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12133:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   12137:	f3 42 0f 7f 54 0c 71 	movdqu %xmm2,0x71(%rsp,%r9,1)
   1213e:	f3 42 0f 7f 8c 0c 81 	movdqu %xmm1,0x81(%rsp,%r9,1)
   12145:	00 00 00 
   12148:	49 83 c1 20          	add    $0x20,%r9
   1214c:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
   12150:	4c 39 ce             	cmp    %r9,%rsi
   12153:	0f 85 77 ff ff ff    	jne    120d0 <fwp_write+0x1290>
   12159:	48 85 d2             	test   %rdx,%rdx
   1215c:	0f 84 91 00 00 00    	je     121f3 <fwp_write+0x13b3>
   12162:	83 fa 08             	cmp    $0x8,%edx
   12165:	72 60                	jb     121c7 <fwp_write+0x1387>
   12167:	48 89 ce             	mov    %rcx,%rsi
   1216a:	41 89 f8             	mov    %edi,%r8d
   1216d:	89 fa                	mov    %edi,%edx
   1216f:	83 e2 07             	and    $0x7,%edx
   12172:	48 89 c1             	mov    %rax,%rcx
   12175:	48 29 d1             	sub    %rdx,%rcx
   12178:	49 89 f1             	mov    %rsi,%r9
   1217b:	49 f7 d9             	neg    %r9
   1217e:	49 01 e1             	add    %rsp,%r9
   12181:	49 83 c1 20          	add    $0x20,%r9
   12185:	4d 01 c1             	add    %r8,%r9
   12188:	49 83 c1 f8          	add    $0xfffffffffffffff8,%r9
   1218c:	49 29 d0             	sub    %rdx,%r8
   1218f:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12193:	f3 41 0f 7e 09       	movq   (%r9),%xmm1
   12198:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   1219c:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   121a1:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   121a6:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   121ab:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   121af:	66 0f d6 4c 34 71    	movq   %xmm1,0x71(%rsp,%rsi,1)
   121b5:	48 83 c6 08          	add    $0x8,%rsi
   121b9:	49 83 c1 f8          	add    $0xfffffffffffffff8,%r9
   121bd:	49 39 f0             	cmp    %rsi,%r8
   121c0:	75 d1                	jne    12193 <fwp_write+0x1353>
   121c2:	48 85 d2             	test   %rdx,%rdx
   121c5:	74 2c                	je     121f3 <fwp_write+0x13b3>
   121c7:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
   121cc:	48 01 f2             	add    %rsi,%rdx
   121cf:	48 ff ca             	dec    %rdx
   121d2:	89 fe                	mov    %edi,%esi
   121d4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
   121db:	00 00 00 00 00 
   121e0:	0f b6 3a             	movzbl (%rdx),%edi
   121e3:	40 88 7c 0c 71       	mov    %dil,0x71(%rsp,%rcx,1)
   121e8:	48 ff c1             	inc    %rcx
   121eb:	48 ff ca             	dec    %rdx
   121ee:	48 39 ce             	cmp    %rcx,%rsi
   121f1:	75 ed                	jne    121e0 <fwp_write+0x13a0>
   121f3:	c6 44 04 71 00       	movb   $0x0,0x71(%rsp,%rax,1)
   121f8:	e9 7b fe ff ff       	jmp    12078 <fwp_write+0x1238>
   121fd:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   12202:	4c 89 f7             	mov    %r14,%rdi
   12205:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   1220b:	be 09 00 00 00       	mov    $0x9,%esi
   12210:	e8 8b 0c 00 00       	call   12ea0 <fwp_format_g>
   12215:	4c 89 f7             	mov    %r14,%rdi
   12218:	e9 bf f8 ff ff       	jmp    11adc <fwp_write+0xc9c>
   1221d:	c7 44 24 70 4e 61 4e 	movl   $0x4e614e,0x70(%rsp)
   12224:	00 
   12225:	e9 4e fe ff ff       	jmp    12078 <fwp_write+0x1238>
   1222a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000012230 <fwp_escape>:
   12230:	55                   	push   %rbp
   12231:	41 57                	push   %r15
   12233:	41 56                	push   %r14
   12235:	41 55                	push   %r13
   12237:	41 54                	push   %r12
   12239:	53                   	push   %rbx
   1223a:	48 83 ec 18          	sub    $0x18,%rsp
   1223e:	49 89 d6             	mov    %rdx,%r14
   12241:	49 89 f7             	mov    %rsi,%r15
   12244:	48 89 fb             	mov    %rdi,%rbx
   12247:	c6 04 24 22          	movb   $0x22,(%rsp)
   1224b:	48 89 e6             	mov    %rsp,%rsi
   1224e:	ba 01 00 00 00       	mov    $0x1,%edx
   12253:	e8 b8 af ff ff       	call   d210 <buf_put>
   12258:	4d 85 f6             	test   %r14,%r14
   1225b:	0f 84 de 00 00 00    	je     1233f <fwp_escape+0x10f>
   12261:	48 89 e5             	mov    %rsp,%rbp
   12264:	4c 8d 2d 39 33 00 00 	lea    0x3339(%rip),%r13        # 155a4 <_IO_stdin_used+0x5a4>
   1226b:	45 31 e4             	xor    %r12d,%r12d
   1226e:	eb 21                	jmp    12291 <fwp_escape+0x61>
   12270:	ba 02 00 00 00       	mov    $0x2,%edx
   12275:	48 89 df             	mov    %rbx,%rdi
   12278:	48 8d 35 4f 45 00 00 	lea    0x454f(%rip),%rsi        # 167ce <exec_in_fp0+0xf5e>
   1227f:	90                   	nop
   12280:	e8 8b af ff ff       	call   d210 <buf_put>
   12285:	49 ff c4             	inc    %r12
   12288:	4d 39 e6             	cmp    %r12,%r14
   1228b:	0f 84 ae 00 00 00    	je     1233f <fwp_escape+0x10f>
   12291:	43 0f b6 04 27       	movzbl (%r15,%r12,1),%eax
   12296:	0f b6 c8             	movzbl %al,%ecx
   12299:	8d 51 f7             	lea    -0x9(%rcx),%edx
   1229c:	83 fa 19             	cmp    $0x19,%edx
   1229f:	77 1f                	ja     122c0 <fwp_escape+0x90>
   122a1:	49 63 54 95 00       	movslq 0x0(%r13,%rdx,4),%rdx
   122a6:	4c 01 ea             	add    %r13,%rdx
   122a9:	ff e2                	jmp    *%rdx
   122ab:	ba 02 00 00 00       	mov    $0x2,%edx
   122b0:	48 89 df             	mov    %rbx,%rdi
   122b3:	48 8d 35 11 45 00 00 	lea    0x4511(%rip),%rsi        # 167cb <exec_in_fp0+0xf5b>
   122ba:	eb c4                	jmp    12280 <fwp_escape+0x50>
   122bc:	0f 1f 40 00          	nopl   0x0(%rax)
   122c0:	83 f9 5c             	cmp    $0x5c,%ecx
   122c3:	75 11                	jne    122d6 <fwp_escape+0xa6>
   122c5:	ba 02 00 00 00       	mov    $0x2,%edx
   122ca:	48 89 df             	mov    %rbx,%rdi
   122cd:	48 8d 35 f1 44 00 00 	lea    0x44f1(%rip),%rsi        # 167c5 <exec_in_fp0+0xf55>
   122d4:	eb aa                	jmp    12280 <fwp_escape+0x50>
   122d6:	3c 20                	cmp    $0x20,%al
   122d8:	72 39                	jb     12313 <fwp_escape+0xe3>
   122da:	3c 7f                	cmp    $0x7f,%al
   122dc:	74 35                	je     12313 <fwp_escape+0xe3>
   122de:	88 04 24             	mov    %al,(%rsp)
   122e1:	ba 01 00 00 00       	mov    $0x1,%edx
   122e6:	48 89 df             	mov    %rbx,%rdi
   122e9:	48 89 ee             	mov    %rbp,%rsi
   122ec:	eb 92                	jmp    12280 <fwp_escape+0x50>
   122ee:	ba 02 00 00 00       	mov    $0x2,%edx
   122f3:	48 89 df             	mov    %rbx,%rdi
   122f6:	48 8d 35 c5 44 00 00 	lea    0x44c5(%rip),%rsi        # 167c2 <exec_in_fp0+0xf52>
   122fd:	eb 81                	jmp    12280 <fwp_escape+0x50>
   122ff:	ba 02 00 00 00       	mov    $0x2,%edx
   12304:	48 89 df             	mov    %rbx,%rdi
   12307:	48 8d 35 ba 44 00 00 	lea    0x44ba(%rip),%rsi        # 167c8 <exec_in_fp0+0xf58>
   1230e:	e9 6d ff ff ff       	jmp    12280 <fwp_escape+0x50>
   12313:	be 10 00 00 00       	mov    $0x10,%esi
   12318:	48 89 ef             	mov    %rbp,%rdi
   1231b:	48 8d 15 af 44 00 00 	lea    0x44af(%rip),%rdx        # 167d1 <exec_in_fp0+0xf61>
   12322:	31 c0                	xor    %eax,%eax
   12324:	e8 a7 0e ff ff       	call   31d0 <snprintf@plt>
   12329:	48 89 ef             	mov    %rbp,%rdi
   1232c:	e8 3f 0e ff ff       	call   3170 <strlen@plt>
   12331:	48 89 df             	mov    %rbx,%rdi
   12334:	48 89 ee             	mov    %rbp,%rsi
   12337:	48 89 c2             	mov    %rax,%rdx
   1233a:	e9 41 ff ff ff       	jmp    12280 <fwp_escape+0x50>
   1233f:	c6 04 24 22          	movb   $0x22,(%rsp)
   12343:	48 89 e6             	mov    %rsp,%rsi
   12346:	ba 01 00 00 00       	mov    $0x1,%edx
   1234b:	48 89 df             	mov    %rbx,%rdi
   1234e:	e8 bd ae ff ff       	call   d210 <buf_put>
   12353:	48 83 c4 18          	add    $0x18,%rsp
   12357:	5b                   	pop    %rbx
   12358:	41 5c                	pop    %r12
   1235a:	41 5d                	pop    %r13
   1235c:	41 5e                	pop    %r14
   1235e:	41 5f                	pop    %r15
   12360:	5d                   	pop    %rbp
   12361:	c3                   	ret
   12362:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   12369:	1f 84 00 00 00 00 00 

0000000000012370 <fwp_fmt_duration>:
   12370:	41 57                	push   %r15
   12372:	41 56                	push   %r14
   12374:	41 54                	push   %r12
   12376:	53                   	push   %rbx
   12377:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
   1237e:	48 89 f0             	mov    %rsi,%rax
   12381:	48 09 d0             	or     %rdx,%rax
   12384:	0f 84 bf 02 00 00    	je     12649 <fwp_fmt_duration+0x2d9>
   1238a:	49 89 d0             	mov    %rdx,%r8
   1238d:	48 b9 1d 3f c2 25 d6 	movabs $0xd2fe1d625c23f1d,%rcx
   12394:	e1 2f 0d 
   12397:	48 0f af ce          	imul   %rsi,%rcx
   1239b:	49 b9 0d b1 f3 e4 99 	movabs $0x1c52799e4f3b10d,%r9
   123a2:	27 c5 01 
   123a5:	48 89 f0             	mov    %rsi,%rax
   123a8:	49 f7 e1             	mul    %r9
   123ab:	48 01 ca             	add    %rcx,%rdx
   123ae:	4d 0f af c8          	imul   %r8,%r9
   123b2:	49 01 d1             	add    %rdx,%r9
   123b5:	48 b9 00 a0 34 52 a3 	movabs $0x6baf6aa35234a000,%rcx
   123bc:	6a af 6b 
   123bf:	48 01 c1             	add    %rax,%rcx
   123c2:	48 b8 37 f9 ff e2 04 	movabs $0x4e2fff937,%rax
   123c9:	00 00 00 
   123cc:	4c 11 c8             	adc    %r9,%rax
   123cf:	48 89 c2             	mov    %rax,%rdx
   123d2:	48 0f ac ca 0d       	shrd   $0xd,%rcx,%rdx
   123d7:	48 0f a4 c8 33       	shld   $0x33,%rcx,%rax
   123dc:	48 b9 4a 23 35 aa f6 	movabs $0x9376baf6aa35234a,%rcx
   123e3:	ba 76 93 
   123e6:	48 39 c1             	cmp    %rax,%rcx
   123e9:	b8 ff 2f 4e 00       	mov    $0x4e2fff,%eax
   123ee:	48 19 d0             	sbb    %rdx,%rax
   123f1:	0f 83 70 02 00 00    	jae    12667 <fwp_fmt_duration+0x2f7>
   123f7:	48 b9 b3 b2 61 36 8c 	movabs $0xc5ce3b8c3661b2b3,%rcx
   123fe:	3b ce c5 
   12401:	49 b9 c3 5f 47 6a 04 	movabs $0x1a8d52046a475fc3,%r9
   12408:	52 8d 1a 
   1240b:	48 89 f0             	mov    %rsi,%rax
   1240e:	49 f7 e1             	mul    %r9
   12411:	48 0f af ce          	imul   %rsi,%rcx
   12415:	48 01 ca             	add    %rcx,%rdx
   12418:	4d 0f af c8          	imul   %r8,%r9
   1241c:	49 01 d1             	add    %rdx,%r9
   1241f:	48 b9 00 a8 16 d1 91 	movabs $0x4f473f91d116a800,%rcx
   12426:	3f 47 4f 
   12429:	48 01 c1             	add    %rax,%rcx
   1242c:	48 b8 3f 9a ff 4c 49 	movabs $0x494cff9a3f,%rax
   12433:	00 00 00 
   12436:	4c 11 c8             	adc    %r9,%rax
   12439:	48 89 c2             	mov    %rax,%rdx
   1243c:	48 0f ac ca 0b       	shrd   $0xb,%rcx,%rdx
   12441:	48 0f a4 c8 35       	shld   $0x35,%rcx,%rax
   12446:	48 b9 ab 45 74 e4 cf 	movabs $0x8fd3d1cfe47445ab,%rcx
   1244d:	d1 d3 8f 
   12450:	48 39 c8             	cmp    %rcx,%rax
   12453:	48 81 da e6 3f 53 12 	sbb    $0x12533fe6,%rdx
   1245a:	0f 82 27 02 00 00    	jb     12687 <fwp_fmt_duration+0x317>
   12460:	48 b9 7e 78 b9 2f 37 	movabs $0x97157d372fb9787e,%rcx
   12467:	7d 15 97 
   1246a:	48 0f af ce          	imul   %rsi,%rcx
   1246e:	49 b9 6d 9c 2e 3a 42 	movabs $0x8e47ce423a2e9c6d,%r9
   12475:	ce 47 8e 
   12478:	48 89 f0             	mov    %rsi,%rax
   1247b:	49 f7 e1             	mul    %r9
   1247e:	48 01 ca             	add    %rcx,%rdx
   12481:	4d 0f af c8          	imul   %r8,%r9
   12485:	49 01 d1             	add    %rdx,%r9
   12488:	48 b9 00 46 54 40 8b 	movabs $0xa52cb98b40544600,%rcx
   1248f:	b9 2c a5 
   12492:	48 01 c1             	add    %rax,%rcx
   12495:	48 b8 b5 09 fa 82 4b 	movabs $0x44b82fa09b5,%rax
   1249c:	04 00 00 
   1249f:	4c 11 c8             	adc    %r9,%rax
   124a2:	48 89 c2             	mov    %rax,%rdx
   124a5:	48 0f ac ca 09       	shrd   $0x9,%rcx,%rdx
   124aa:	48 0f a4 c8 37       	shld   $0x37,%rcx,%rax
   124af:	48 b9 47 54 40 8b b9 	movabs $0xb5a52cb98b405447,%rcx
   124b6:	2c a5 b5 
   124b9:	48 39 c8             	cmp    %rcx,%rax
   124bc:	48 b8 09 fa 82 4b 04 	movabs $0x44b82fa09,%rax
   124c3:	00 00 00 
   124c6:	48 19 c2             	sbb    %rax,%rdx
   124c9:	0f 82 0d 03 00 00    	jb     127dc <fwp_fmt_duration+0x46c>
   124cf:	48 b9 cb d5 8f 4d f2 	movabs $0xc57e23f24d8fd5cb,%rcx
   124d6:	23 7e c5 
   124d9:	48 0f af ce          	imul   %rsi,%rcx
   124dd:	49 b9 39 61 c2 68 56 	movabs $0x790fb65668c26139,%r9
   124e4:	b6 0f 79 
   124e7:	48 89 f0             	mov    %rsi,%rax
   124ea:	49 f7 e1             	mul    %r9
   124ed:	48 01 ca             	add    %rcx,%rdx
   124f0:	4d 0f af c8          	imul   %r8,%r9
   124f4:	49 01 d1             	add    %rdx,%r9
   124f7:	48 b9 00 0b 27 69 fe 	movabs $0xa6d698fe69270b00,%rcx
   124fe:	98 d6 a6 
   12501:	48 01 c1             	add    %rax,%rcx
   12504:	48 b8 b1 bd 16 f4 de 	movabs $0x218def416bdb1,%rax
   1250b:	18 02 00 
   1250e:	4c 11 c8             	adc    %r9,%rax
   12511:	48 89 c2             	mov    %rax,%rdx
   12514:	48 0f ac ca 06       	shrd   $0x6,%rcx,%rdx
   12519:	48 0f a4 c8 3a       	shld   $0x3a,%rcx,%rax
   1251e:	48 b9 59 38 49 f3 c7 	movabs $0x8d36b4c7f3493859,%rcx
   12525:	b4 36 8d 
   12528:	48 39 c8             	cmp    %rcx,%rax
   1252b:	48 b8 ed b5 a0 f7 c6 	movabs $0x10c6f7a0b5ed,%rax
   12532:	10 00 00 
   12535:	48 19 c2             	sbb    %rax,%rdx
   12538:	0f 82 ad 02 00 00    	jb     127eb <fwp_fmt_duration+0x47b>
   1253e:	48 b9 5a 64 3b df 4f 	movabs $0x6e978d4fdf3b645a,%rcx
   12545:	8d 97 6e 
   12548:	48 0f af ce          	imul   %rsi,%rcx
   1254c:	49 b9 d5 78 e9 26 31 	movabs $0x1cac083126e978d5,%r9
   12553:	08 ac 1c 
   12556:	48 89 f0             	mov    %rsi,%rax
   12559:	49 f7 e1             	mul    %r9
   1255c:	48 01 ca             	add    %rcx,%rdx
   1255f:	4d 0f af c8          	imul   %r8,%r9
   12563:	49 01 d1             	add    %rdx,%r9
   12566:	48 b9 48 62 10 58 39 	movabs $0x76c8b43958106248,%rcx
   1256d:	b4 c8 76 
   12570:	48 01 c1             	add    %rax,%rcx
   12573:	48 b8 be 9f 1a 2f dd 	movabs $0x10624dd2f1a9fbe,%rax
   1257a:	24 06 01 
   1257d:	4c 11 c8             	adc    %r9,%rax
   12580:	48 89 c2             	mov    %rax,%rdx
   12583:	48 0f ac ca 03       	shrd   $0x3,%rcx,%rdx
   12588:	48 0f a4 c8 3d       	shld   $0x3d,%rcx,%rax
   1258d:	48 b9 93 18 04 56 0e 	movabs $0x9db22d0e56041893,%rcx
   12594:	2d b2 9d 
   12597:	48 39 c8             	cmp    %rcx,%rax
   1259a:	48 b8 ef a7 c6 4b 37 	movabs $0x4189374bc6a7ef,%rax
   125a1:	89 41 00 
   125a4:	48 19 c2             	sbb    %rax,%rdx
   125a7:	0f 82 4d 02 00 00    	jb     127fa <fwp_fmt_duration+0x48a>
   125ad:	4d 85 c0             	test   %r8,%r8
   125b0:	0f 88 d6 06 00 00    	js     12c8c <fwp_fmt_duration+0x91c>
   125b6:	45 31 d2             	xor    %r10d,%r10d
   125b9:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
   125c0:	cc cc cc 
   125c3:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
   125ca:	cc cc cc 
   125cd:	4d 89 c6             	mov    %r8,%r14
   125d0:	4c 89 c1             	mov    %r8,%rcx
   125d3:	48 0f a4 f1 3f       	shld   $0x3f,%rsi,%rcx
   125d8:	49 d1 ee             	shr    $1,%r14
   125db:	49 89 c9             	mov    %rcx,%r9
   125de:	4d 01 f1             	add    %r14,%r9
   125e1:	49 83 d1 00          	adc    $0x0,%r9
   125e5:	4c 89 c8             	mov    %r9,%rax
   125e8:	49 f7 e3             	mul    %r11
   125eb:	48 c1 ea 02          	shr    $0x2,%rdx
   125ef:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   125f3:	49 29 c1             	sub    %rax,%r9
   125f6:	4c 29 c9             	sub    %r9,%rcx
   125f9:	49 83 de 00          	sbb    $0x0,%r14
   125fd:	49 89 c9             	mov    %rcx,%r9
   12600:	4c 0f af cb          	imul   %rbx,%r9
   12604:	48 89 c8             	mov    %rcx,%rax
   12607:	49 f7 e3             	mul    %r11
   1260a:	4c 01 ca             	add    %r9,%rdx
   1260d:	4d 0f af f3          	imul   %r11,%r14
   12611:	49 01 d6             	add    %rdx,%r14
   12614:	48 89 c1             	mov    %rax,%rcx
   12617:	48 01 c1             	add    %rax,%rcx
   1261a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
   1261e:	89 f2                	mov    %esi,%edx
   12620:	29 ca                	sub    %ecx,%edx
   12622:	80 ca 30             	or     $0x30,%dl
   12625:	42 88 54 14 40       	mov    %dl,0x40(%rsp,%r10,1)
   1262a:	49 ff c2             	inc    %r10
   1262d:	48 83 fe 0a          	cmp    $0xa,%rsi
   12631:	49 83 d8 00          	sbb    $0x0,%r8
   12635:	48 89 c6             	mov    %rax,%rsi
   12638:	4d 89 f0             	mov    %r14,%r8
   1263b:	73 93                	jae    125d0 <fwp_fmt_duration+0x260>
   1263d:	45 85 d2             	test   %r10d,%r10d
   12640:	7f 12                	jg     12654 <fwp_fmt_duration+0x2e4>
   12642:	31 c0                	xor    %eax,%eax
   12644:	e9 79 01 00 00       	jmp    127c2 <fwp_fmt_duration+0x452>
   12649:	c6 44 24 40 30       	movb   $0x30,0x40(%rsp)
   1264e:	41 ba 01 00 00 00    	mov    $0x1,%r10d
   12654:	44 89 d0             	mov    %r10d,%eax
   12657:	48 83 f8 08          	cmp    $0x8,%rax
   1265b:	73 1e                	jae    1267b <fwp_fmt_duration+0x30b>
   1265d:	31 c9                	xor    %ecx,%ecx
   1265f:	48 89 c2             	mov    %rax,%rdx
   12662:	e9 3d 01 00 00       	jmp    127a4 <fwp_fmt_duration+0x434>
   12667:	49 89 fe             	mov    %rdi,%r14
   1266a:	48 ba 00 a0 b8 30 46 	movabs $0x34630b8a000,%rdx
   12671:	03 00 00 
   12674:	31 c0                	xor    %eax,%eax
   12676:	e9 8c 01 00 00       	jmp    12807 <fwp_fmt_duration+0x497>
   1267b:	83 f8 20             	cmp    $0x20,%eax
   1267e:	73 1e                	jae    1269e <fwp_fmt_duration+0x32e>
   12680:	31 c9                	xor    %ecx,%ecx
   12682:	e9 c3 00 00 00       	jmp    1274a <fwp_fmt_duration+0x3da>
   12687:	49 89 fe             	mov    %rdi,%r14
   1268a:	48 ba 00 58 47 f8 0d 	movabs $0xdf8475800,%rdx
   12691:	00 00 00 
   12694:	b8 01 00 00 00       	mov    $0x1,%eax
   12699:	e9 69 01 00 00       	jmp    12807 <fwp_fmt_duration+0x497>
   1269e:	44 89 d2             	mov    %r10d,%edx
   126a1:	83 e2 1f             	and    $0x1f,%edx
   126a4:	48 89 c1             	mov    %rax,%rcx
   126a7:	48 29 d1             	sub    %rdx,%rcx
   126aa:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
   126af:	66 0f ef c0          	pxor   %xmm0,%xmm0
   126b3:	49 89 c0             	mov    %rax,%r8
   126b6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   126bd:	00 00 00 
   126c0:	f3 42 0f 6f 4c 04 20 	movdqu 0x20(%rsp,%r8,1),%xmm1
   126c7:	f3 42 0f 6f 54 04 30 	movdqu 0x30(%rsp,%r8,1),%xmm2
   126ce:	66 0f 6f da          	movdqa %xmm2,%xmm3
   126d2:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   126d6:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   126db:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   126e0:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   126e5:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   126e9:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   126ee:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   126f3:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   126f8:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   126fc:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   12700:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12704:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12709:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   1270e:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12713:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   12717:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   1271c:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12721:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12726:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   1272a:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
   1272f:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
   12733:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
   12737:	48 83 c6 20          	add    $0x20,%rsi
   1273b:	4c 39 c2             	cmp    %r8,%rdx
   1273e:	75 80                	jne    126c0 <fwp_fmt_duration+0x350>
   12740:	48 85 d2             	test   %rdx,%rdx
   12743:	74 7d                	je     127c2 <fwp_fmt_duration+0x452>
   12745:	83 fa 08             	cmp    $0x8,%edx
   12748:	72 5a                	jb     127a4 <fwp_fmt_duration+0x434>
   1274a:	44 89 d2             	mov    %r10d,%edx
   1274d:	83 e2 07             	and    $0x7,%edx
   12750:	48 89 c6             	mov    %rax,%rsi
   12753:	48 29 ce             	sub    %rcx,%rsi
   12756:	4c 8d 04 0c          	lea    (%rsp,%rcx,1),%r8
   1275a:	48 89 c1             	mov    %rax,%rcx
   1275d:	48 29 d1             	sub    %rdx,%rcx
   12760:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12764:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
   1276b:	00 00 00 00 00 
   12770:	f3 0f 7e 4c 34 38    	movq   0x38(%rsp,%rsi,1),%xmm1
   12776:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   1277a:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   1277f:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12784:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12789:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   1278d:	66 41 0f d6 08       	movq   %xmm1,(%r8)
   12792:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
   12796:	49 83 c0 08          	add    $0x8,%r8
   1279a:	48 39 f2             	cmp    %rsi,%rdx
   1279d:	75 d1                	jne    12770 <fwp_fmt_duration+0x400>
   1279f:	48 85 d2             	test   %rdx,%rdx
   127a2:	74 1e                	je     127c2 <fwp_fmt_duration+0x452>
   127a4:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
   127a9:	48 01 f2             	add    %rsi,%rdx
   127ac:	48 ff ca             	dec    %rdx
   127af:	90                   	nop
   127b0:	0f b6 32             	movzbl (%rdx),%esi
   127b3:	40 88 34 0c          	mov    %sil,(%rsp,%rcx,1)
   127b7:	48 ff c1             	inc    %rcx
   127ba:	48 ff ca             	dec    %rdx
   127bd:	48 39 c8             	cmp    %rcx,%rax
   127c0:	75 ee                	jne    127b0 <fwp_fmt_duration+0x440>
   127c2:	c6 04 04 00          	movb   $0x0,(%rsp,%rax,1)
   127c6:	48 8d 35 10 40 00 00 	lea    0x4010(%rip),%rsi        # 167dd <exec_in_fp0+0xf6d>
   127cd:	48 89 e2             	mov    %rsp,%rdx
   127d0:	31 c0                	xor    %eax,%eax
   127d2:	e8 79 0c ff ff       	call   3450 <sprintf@plt>
   127d7:	e9 a1 04 00 00       	jmp    12c7d <fwp_fmt_duration+0x90d>
   127dc:	49 89 fe             	mov    %rdi,%r14
   127df:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
   127e4:	b8 02 00 00 00       	mov    $0x2,%eax
   127e9:	eb 1c                	jmp    12807 <fwp_fmt_duration+0x497>
   127eb:	49 89 fe             	mov    %rdi,%r14
   127ee:	ba 40 42 0f 00       	mov    $0xf4240,%edx
   127f3:	b8 03 00 00 00       	mov    $0x3,%eax
   127f8:	eb 0d                	jmp    12807 <fwp_fmt_duration+0x497>
   127fa:	49 89 fe             	mov    %rdi,%r14
   127fd:	ba e8 03 00 00       	mov    $0x3e8,%edx
   12802:	b8 04 00 00 00       	mov    $0x4,%eax
   12807:	31 c9                	xor    %ecx,%ecx
   12809:	c1 e0 04             	shl    $0x4,%eax
   1280c:	48 8d 1d 4d 75 00 00 	lea    0x754d(%rip),%rbx        # 19d60 <fwp_fmt_duration.units>
   12813:	48 01 c3             	add    %rax,%rbx
   12816:	48 89 f7             	mov    %rsi,%rdi
   12819:	4c 89 c6             	mov    %r8,%rsi
   1281c:	e8 bf 16 00 00       	call   13ee0 <__divti3>
   12821:	48 89 c1             	mov    %rax,%rcx
   12824:	48 89 d6             	mov    %rdx,%rsi
   12827:	48 85 d2             	test   %rdx,%rdx
   1282a:	0f 88 b0 00 00 00    	js     128e0 <fwp_fmt_duration+0x570>
   12830:	48 89 c8             	mov    %rcx,%rax
   12833:	48 09 f0             	or     %rsi,%rax
   12836:	0f 84 61 01 00 00    	je     1299d <fwp_fmt_duration+0x62d>
   1283c:	45 31 d2             	xor    %r10d,%r10d
   1283f:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
   12846:	cc cc cc 
   12849:	49 bf cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r15
   12850:	cc cc cc 
   12853:	49 89 f4             	mov    %rsi,%r12
   12856:	4c 89 f7             	mov    %r14,%rdi
   12859:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   12860:	49 89 f0             	mov    %rsi,%r8
   12863:	49 0f a4 c8 3f       	shld   $0x3f,%rcx,%r8
   12868:	49 d1 ec             	shr    $1,%r12
   1286b:	4d 89 c1             	mov    %r8,%r9
   1286e:	4d 01 e1             	add    %r12,%r9
   12871:	49 83 d1 00          	adc    $0x0,%r9
   12875:	4c 89 c8             	mov    %r9,%rax
   12878:	49 f7 e3             	mul    %r11
   1287b:	48 c1 ea 02          	shr    $0x2,%rdx
   1287f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   12883:	49 29 c1             	sub    %rax,%r9
   12886:	4d 29 c8             	sub    %r9,%r8
   12889:	49 83 dc 00          	sbb    $0x0,%r12
   1288d:	4d 89 c1             	mov    %r8,%r9
   12890:	4d 0f af cf          	imul   %r15,%r9
   12894:	4c 89 c0             	mov    %r8,%rax
   12897:	49 f7 e3             	mul    %r11
   1289a:	4c 01 ca             	add    %r9,%rdx
   1289d:	4d 0f af e3          	imul   %r11,%r12
   128a1:	49 01 d4             	add    %rdx,%r12
   128a4:	48 89 c2             	mov    %rax,%rdx
   128a7:	48 01 c2             	add    %rax,%rdx
   128aa:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
   128ae:	41 89 c8             	mov    %ecx,%r8d
   128b1:	41 29 d0             	sub    %edx,%r8d
   128b4:	41 80 c8 30          	or     $0x30,%r8b
   128b8:	46 88 44 14 40       	mov    %r8b,0x40(%rsp,%r10,1)
   128bd:	49 ff c2             	inc    %r10
   128c0:	48 83 f9 0a          	cmp    $0xa,%rcx
   128c4:	48 83 de 00          	sbb    $0x0,%rsi
   128c8:	48 89 c1             	mov    %rax,%rcx
   128cb:	4c 89 e6             	mov    %r12,%rsi
   128ce:	73 90                	jae    12860 <fwp_fmt_duration+0x4f0>
   128d0:	45 85 d2             	test   %r10d,%r10d
   128d3:	0f 8f d2 00 00 00    	jg     129ab <fwp_fmt_duration+0x63b>
   128d9:	31 c0                	xor    %eax,%eax
   128db:	e9 12 02 00 00       	jmp    12af2 <fwp_fmt_duration+0x782>
   128e0:	45 31 c0             	xor    %r8d,%r8d
   128e3:	48 f7 d9             	neg    %rcx
   128e6:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   128ec:	49 19 f1             	sbb    %rsi,%r9
   128ef:	c6 04 24 2d          	movb   $0x2d,(%rsp)
   128f3:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
   128fa:	cc cc cc 
   128fd:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
   12904:	cc cc cc 
   12907:	4d 89 cf             	mov    %r9,%r15
   1290a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   12910:	4c 89 ce             	mov    %r9,%rsi
   12913:	48 0f a4 ce 3f       	shld   $0x3f,%rcx,%rsi
   12918:	49 d1 ef             	shr    $1,%r15
   1291b:	48 89 f7             	mov    %rsi,%rdi
   1291e:	4c 01 ff             	add    %r15,%rdi
   12921:	48 83 d7 00          	adc    $0x0,%rdi
   12925:	48 89 f8             	mov    %rdi,%rax
   12928:	49 f7 e2             	mul    %r10
   1292b:	48 c1 ea 02          	shr    $0x2,%rdx
   1292f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   12933:	48 29 c7             	sub    %rax,%rdi
   12936:	48 29 fe             	sub    %rdi,%rsi
   12939:	49 83 df 00          	sbb    $0x0,%r15
   1293d:	48 89 f7             	mov    %rsi,%rdi
   12940:	49 0f af fb          	imul   %r11,%rdi
   12944:	48 89 f0             	mov    %rsi,%rax
   12947:	49 f7 e2             	mul    %r10
   1294a:	48 01 fa             	add    %rdi,%rdx
   1294d:	4d 0f af fa          	imul   %r10,%r15
   12951:	49 01 d7             	add    %rdx,%r15
   12954:	48 89 c2             	mov    %rax,%rdx
   12957:	48 01 c2             	add    %rax,%rdx
   1295a:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
   1295e:	89 ce                	mov    %ecx,%esi
   12960:	29 d6                	sub    %edx,%esi
   12962:	40 80 ce 30          	or     $0x30,%sil
   12966:	42 88 74 04 40       	mov    %sil,0x40(%rsp,%r8,1)
   1296b:	49 ff c0             	inc    %r8
   1296e:	48 83 f9 0a          	cmp    $0xa,%rcx
   12972:	49 83 d9 00          	sbb    $0x0,%r9
   12976:	48 89 c1             	mov    %rax,%rcx
   12979:	4d 89 f9             	mov    %r15,%r9
   1297c:	73 92                	jae    12910 <fwp_fmt_duration+0x5a0>
   1297e:	45 85 c0             	test   %r8d,%r8d
   12981:	4c 89 f7             	mov    %r14,%rdi
   12984:	7e 44                	jle    129ca <fwp_fmt_duration+0x65a>
   12986:	44 89 c0             	mov    %r8d,%eax
   12989:	48 83 f8 08          	cmp    $0x8,%rax
   1298d:	0f 83 68 01 00 00    	jae    12afb <fwp_fmt_duration+0x78b>
   12993:	31 c9                	xor    %ecx,%ecx
   12995:	48 89 c2             	mov    %rax,%rdx
   12998:	e9 97 02 00 00       	jmp    12c34 <fwp_fmt_duration+0x8c4>
   1299d:	c6 44 24 40 30       	movb   $0x30,0x40(%rsp)
   129a2:	41 ba 01 00 00 00    	mov    $0x1,%r10d
   129a8:	4c 89 f7             	mov    %r14,%rdi
   129ab:	44 89 d0             	mov    %r10d,%eax
   129ae:	48 83 f8 08          	cmp    $0x8,%rax
   129b2:	73 0a                	jae    129be <fwp_fmt_duration+0x64e>
   129b4:	31 c9                	xor    %ecx,%ecx
   129b6:	48 89 c2             	mov    %rax,%rdx
   129b9:	e9 16 01 00 00       	jmp    12ad4 <fwp_fmt_duration+0x764>
   129be:	83 f8 20             	cmp    $0x20,%eax
   129c1:	73 0e                	jae    129d1 <fwp_fmt_duration+0x661>
   129c3:	31 c9                	xor    %ecx,%ecx
   129c5:	e9 b0 00 00 00       	jmp    12a7a <fwp_fmt_duration+0x70a>
   129ca:	31 c0                	xor    %eax,%eax
   129cc:	e9 93 02 00 00       	jmp    12c64 <fwp_fmt_duration+0x8f4>
   129d1:	44 89 d2             	mov    %r10d,%edx
   129d4:	83 e2 1f             	and    $0x1f,%edx
   129d7:	48 89 c1             	mov    %rax,%rcx
   129da:	48 29 d1             	sub    %rdx,%rcx
   129dd:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
   129e2:	66 0f ef c0          	pxor   %xmm0,%xmm0
   129e6:	49 89 c0             	mov    %rax,%r8
   129e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   129f0:	f3 42 0f 6f 4c 04 20 	movdqu 0x20(%rsp,%r8,1),%xmm1
   129f7:	f3 42 0f 6f 54 04 30 	movdqu 0x30(%rsp,%r8,1),%xmm2
   129fe:	66 0f 6f da          	movdqa %xmm2,%xmm3
   12a02:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12a06:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12a0b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   12a10:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12a15:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   12a19:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   12a1e:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   12a23:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   12a28:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   12a2c:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   12a30:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12a34:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12a39:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   12a3e:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12a43:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   12a47:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   12a4c:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12a51:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12a56:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   12a5a:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
   12a5f:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
   12a63:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
   12a67:	48 83 c6 20          	add    $0x20,%rsi
   12a6b:	4c 39 c2             	cmp    %r8,%rdx
   12a6e:	75 80                	jne    129f0 <fwp_fmt_duration+0x680>
   12a70:	48 85 d2             	test   %rdx,%rdx
   12a73:	74 7d                	je     12af2 <fwp_fmt_duration+0x782>
   12a75:	83 fa 08             	cmp    $0x8,%edx
   12a78:	72 5a                	jb     12ad4 <fwp_fmt_duration+0x764>
   12a7a:	44 89 d2             	mov    %r10d,%edx
   12a7d:	83 e2 07             	and    $0x7,%edx
   12a80:	48 89 c6             	mov    %rax,%rsi
   12a83:	48 29 ce             	sub    %rcx,%rsi
   12a86:	4c 8d 04 0c          	lea    (%rsp,%rcx,1),%r8
   12a8a:	48 89 c1             	mov    %rax,%rcx
   12a8d:	48 29 d1             	sub    %rdx,%rcx
   12a90:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12a94:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
   12a9b:	00 00 00 00 00 
   12aa0:	f3 0f 7e 4c 34 38    	movq   0x38(%rsp,%rsi,1),%xmm1
   12aa6:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   12aaa:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   12aaf:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12ab4:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12ab9:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   12abd:	66 41 0f d6 08       	movq   %xmm1,(%r8)
   12ac2:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
   12ac6:	49 83 c0 08          	add    $0x8,%r8
   12aca:	48 39 f2             	cmp    %rsi,%rdx
   12acd:	75 d1                	jne    12aa0 <fwp_fmt_duration+0x730>
   12acf:	48 85 d2             	test   %rdx,%rdx
   12ad2:	74 1e                	je     12af2 <fwp_fmt_duration+0x782>
   12ad4:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
   12ad9:	48 01 f2             	add    %rsi,%rdx
   12adc:	48 ff ca             	dec    %rdx
   12adf:	90                   	nop
   12ae0:	0f b6 32             	movzbl (%rdx),%esi
   12ae3:	40 88 34 0c          	mov    %sil,(%rsp,%rcx,1)
   12ae7:	48 ff c1             	inc    %rcx
   12aea:	48 ff ca             	dec    %rdx
   12aed:	48 39 c8             	cmp    %rcx,%rax
   12af0:	75 ee                	jne    12ae0 <fwp_fmt_duration+0x770>
   12af2:	c6 04 04 00          	movb   $0x0,(%rsp,%rax,1)
   12af6:	e9 6e 01 00 00       	jmp    12c69 <fwp_fmt_duration+0x8f9>
   12afb:	83 f8 20             	cmp    $0x20,%eax
   12afe:	73 07                	jae    12b07 <fwp_fmt_duration+0x797>
   12b00:	31 c9                	xor    %ecx,%ecx
   12b02:	e9 bd 00 00 00       	jmp    12bc4 <fwp_fmt_duration+0x854>
   12b07:	44 89 c6             	mov    %r8d,%esi
   12b0a:	44 89 c2             	mov    %r8d,%edx
   12b0d:	83 e2 1f             	and    $0x1f,%edx
   12b10:	48 89 c1             	mov    %rax,%rcx
   12b13:	48 29 d1             	sub    %rdx,%rcx
   12b16:	4c 8d 0c 34          	lea    (%rsp,%rsi,1),%r9
   12b1a:	49 83 c1 30          	add    $0x30,%r9
   12b1e:	48 29 d6             	sub    %rdx,%rsi
   12b21:	45 31 d2             	xor    %r10d,%r10d
   12b24:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12b28:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   12b2f:	00 
   12b30:	f3 41 0f 6f 49 f0    	movdqu -0x10(%r9),%xmm1
   12b36:	f3 41 0f 6f 11       	movdqu (%r9),%xmm2
   12b3b:	66 0f 6f da          	movdqa %xmm2,%xmm3
   12b3f:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12b43:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12b48:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   12b4d:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12b52:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   12b56:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   12b5b:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   12b60:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   12b65:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   12b69:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   12b6d:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12b71:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12b76:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   12b7b:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12b80:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   12b84:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   12b89:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12b8e:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12b93:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   12b97:	f3 42 0f 7f 54 14 01 	movdqu %xmm2,0x1(%rsp,%r10,1)
   12b9e:	f3 42 0f 7f 4c 14 11 	movdqu %xmm1,0x11(%rsp,%r10,1)
   12ba5:	49 83 c2 20          	add    $0x20,%r10
   12ba9:	49 83 c1 e0          	add    $0xffffffffffffffe0,%r9
   12bad:	4c 39 d6             	cmp    %r10,%rsi
   12bb0:	0f 85 7a ff ff ff    	jne    12b30 <fwp_fmt_duration+0x7c0>
   12bb6:	48 85 d2             	test   %rdx,%rdx
   12bb9:	0f 84 a5 00 00 00    	je     12c64 <fwp_fmt_duration+0x8f4>
   12bbf:	83 fa 08             	cmp    $0x8,%edx
   12bc2:	72 70                	jb     12c34 <fwp_fmt_duration+0x8c4>
   12bc4:	48 89 ce             	mov    %rcx,%rsi
   12bc7:	45 89 c1             	mov    %r8d,%r9d
   12bca:	44 89 c2             	mov    %r8d,%edx
   12bcd:	83 e2 07             	and    $0x7,%edx
   12bd0:	48 89 c1             	mov    %rax,%rcx
   12bd3:	48 29 d1             	sub    %rdx,%rcx
   12bd6:	49 89 f2             	mov    %rsi,%r10
   12bd9:	49 f7 da             	neg    %r10
   12bdc:	49 01 e2             	add    %rsp,%r10
   12bdf:	49 83 c2 40          	add    $0x40,%r10
   12be3:	4d 01 ca             	add    %r9,%r10
   12be6:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
   12bea:	49 29 d1             	sub    %rdx,%r9
   12bed:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12bf1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   12bf8:	0f 1f 84 00 00 00 00 
   12bff:	00 
   12c00:	f3 41 0f 7e 0a       	movq   (%r10),%xmm1
   12c05:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   12c09:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   12c0e:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12c13:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12c18:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   12c1c:	66 0f d6 4c 34 01    	movq   %xmm1,0x1(%rsp,%rsi,1)
   12c22:	48 83 c6 08          	add    $0x8,%rsi
   12c26:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
   12c2a:	49 39 f1             	cmp    %rsi,%r9
   12c2d:	75 d1                	jne    12c00 <fwp_fmt_duration+0x890>
   12c2f:	48 85 d2             	test   %rdx,%rdx
   12c32:	74 30                	je     12c64 <fwp_fmt_duration+0x8f4>
   12c34:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
   12c39:	48 01 f2             	add    %rsi,%rdx
   12c3c:	48 ff ca             	dec    %rdx
   12c3f:	44 89 c6             	mov    %r8d,%esi
   12c42:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   12c49:	1f 84 00 00 00 00 00 
   12c50:	44 0f b6 02          	movzbl (%rdx),%r8d
   12c54:	44 88 44 0c 01       	mov    %r8b,0x1(%rsp,%rcx,1)
   12c59:	48 ff c1             	inc    %rcx
   12c5c:	48 ff ca             	dec    %rdx
   12c5f:	48 39 ce             	cmp    %rcx,%rsi
   12c62:	75 ec                	jne    12c50 <fwp_fmt_duration+0x8e0>
   12c64:	c6 44 04 01 00       	movb   $0x0,0x1(%rsp,%rax,1)
   12c69:	48 8b 0b             	mov    (%rbx),%rcx
   12c6c:	48 8d 35 65 3b 00 00 	lea    0x3b65(%rip),%rsi        # 167d8 <exec_in_fp0+0xf68>
   12c73:	48 89 e2             	mov    %rsp,%rdx
   12c76:	31 c0                	xor    %eax,%eax
   12c78:	e8 d3 07 ff ff       	call   3450 <sprintf@plt>
   12c7d:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
   12c84:	5b                   	pop    %rbx
   12c85:	41 5c                	pop    %r12
   12c87:	41 5e                	pop    %r14
   12c89:	41 5f                	pop    %r15
   12c8b:	c3                   	ret
   12c8c:	45 31 c9             	xor    %r9d,%r9d
   12c8f:	48 f7 de             	neg    %rsi
   12c92:	41 ba 00 00 00 00    	mov    $0x0,%r10d
   12c98:	4d 19 c2             	sbb    %r8,%r10
   12c9b:	c6 04 24 2d          	movb   $0x2d,(%rsp)
   12c9f:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
   12ca6:	cc cc cc 
   12ca9:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
   12cb0:	cc cc cc 
   12cb3:	4d 89 d6             	mov    %r10,%r14
   12cb6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   12cbd:	00 00 00 
   12cc0:	4c 89 d1             	mov    %r10,%rcx
   12cc3:	48 0f a4 f1 3f       	shld   $0x3f,%rsi,%rcx
   12cc8:	49 d1 ee             	shr    $1,%r14
   12ccb:	49 89 c8             	mov    %rcx,%r8
   12cce:	4d 01 f0             	add    %r14,%r8
   12cd1:	49 83 d0 00          	adc    $0x0,%r8
   12cd5:	4c 89 c0             	mov    %r8,%rax
   12cd8:	49 f7 e3             	mul    %r11
   12cdb:	48 c1 ea 02          	shr    $0x2,%rdx
   12cdf:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   12ce3:	49 29 c0             	sub    %rax,%r8
   12ce6:	4c 29 c1             	sub    %r8,%rcx
   12ce9:	49 83 de 00          	sbb    $0x0,%r14
   12ced:	49 89 c8             	mov    %rcx,%r8
   12cf0:	4c 0f af c3          	imul   %rbx,%r8
   12cf4:	48 89 c8             	mov    %rcx,%rax
   12cf7:	49 f7 e3             	mul    %r11
   12cfa:	4c 01 c2             	add    %r8,%rdx
   12cfd:	4d 0f af f3          	imul   %r11,%r14
   12d01:	49 01 d6             	add    %rdx,%r14
   12d04:	48 89 c1             	mov    %rax,%rcx
   12d07:	48 01 c1             	add    %rax,%rcx
   12d0a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
   12d0e:	89 f2                	mov    %esi,%edx
   12d10:	29 ca                	sub    %ecx,%edx
   12d12:	80 ca 30             	or     $0x30,%dl
   12d15:	42 88 54 0c 40       	mov    %dl,0x40(%rsp,%r9,1)
   12d1a:	49 ff c1             	inc    %r9
   12d1d:	48 83 fe 0a          	cmp    $0xa,%rsi
   12d21:	49 83 da 00          	sbb    $0x0,%r10
   12d25:	48 89 c6             	mov    %rax,%rsi
   12d28:	4d 89 f2             	mov    %r14,%r10
   12d2b:	73 93                	jae    12cc0 <fwp_fmt_duration+0x950>
   12d2d:	45 85 c9             	test   %r9d,%r9d
   12d30:	7e 13                	jle    12d45 <fwp_fmt_duration+0x9d5>
   12d32:	44 89 c8             	mov    %r9d,%eax
   12d35:	48 83 f8 08          	cmp    $0x8,%rax
   12d39:	73 11                	jae    12d4c <fwp_fmt_duration+0x9dc>
   12d3b:	31 c9                	xor    %ecx,%ecx
   12d3d:	48 89 c2             	mov    %rax,%rdx
   12d40:	e9 29 01 00 00       	jmp    12e6e <fwp_fmt_duration+0xafe>
   12d45:	31 c0                	xor    %eax,%eax
   12d47:	e9 48 01 00 00       	jmp    12e94 <fwp_fmt_duration+0xb24>
   12d4c:	83 f8 20             	cmp    $0x20,%eax
   12d4f:	73 07                	jae    12d58 <fwp_fmt_duration+0x9e8>
   12d51:	31 c9                	xor    %ecx,%ecx
   12d53:	e9 b5 00 00 00       	jmp    12e0d <fwp_fmt_duration+0xa9d>
   12d58:	44 89 ce             	mov    %r9d,%esi
   12d5b:	44 89 ca             	mov    %r9d,%edx
   12d5e:	83 e2 1f             	and    $0x1f,%edx
   12d61:	48 89 c1             	mov    %rax,%rcx
   12d64:	48 29 d1             	sub    %rdx,%rcx
   12d67:	4c 8d 04 34          	lea    (%rsp,%rsi,1),%r8
   12d6b:	49 83 c0 30          	add    $0x30,%r8
   12d6f:	48 29 d6             	sub    %rdx,%rsi
   12d72:	45 31 d2             	xor    %r10d,%r10d
   12d75:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12d79:	f3 41 0f 6f 48 f0    	movdqu -0x10(%r8),%xmm1
   12d7f:	f3 41 0f 6f 10       	movdqu (%r8),%xmm2
   12d84:	66 0f 6f da          	movdqa %xmm2,%xmm3
   12d88:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12d8c:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12d91:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   12d96:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12d9b:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   12d9f:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   12da4:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   12da9:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   12dae:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   12db2:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   12db6:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12dba:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12dbf:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   12dc4:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12dc9:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   12dcd:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   12dd2:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12dd7:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12ddc:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   12de0:	f3 42 0f 7f 54 14 01 	movdqu %xmm2,0x1(%rsp,%r10,1)
   12de7:	f3 42 0f 7f 4c 14 11 	movdqu %xmm1,0x11(%rsp,%r10,1)
   12dee:	49 83 c2 20          	add    $0x20,%r10
   12df2:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
   12df6:	4c 39 d6             	cmp    %r10,%rsi
   12df9:	0f 85 7a ff ff ff    	jne    12d79 <fwp_fmt_duration+0xa09>
   12dff:	48 85 d2             	test   %rdx,%rdx
   12e02:	0f 84 8c 00 00 00    	je     12e94 <fwp_fmt_duration+0xb24>
   12e08:	83 fa 08             	cmp    $0x8,%edx
   12e0b:	72 61                	jb     12e6e <fwp_fmt_duration+0xafe>
   12e0d:	48 89 ce             	mov    %rcx,%rsi
   12e10:	45 89 c8             	mov    %r9d,%r8d
   12e13:	44 89 ca             	mov    %r9d,%edx
   12e16:	83 e2 07             	and    $0x7,%edx
   12e19:	48 89 c1             	mov    %rax,%rcx
   12e1c:	48 29 d1             	sub    %rdx,%rcx
   12e1f:	49 89 f2             	mov    %rsi,%r10
   12e22:	49 f7 da             	neg    %r10
   12e25:	49 01 e2             	add    %rsp,%r10
   12e28:	49 83 c2 40          	add    $0x40,%r10
   12e2c:	4d 01 c2             	add    %r8,%r10
   12e2f:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
   12e33:	49 29 d0             	sub    %rdx,%r8
   12e36:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12e3a:	f3 41 0f 7e 0a       	movq   (%r10),%xmm1
   12e3f:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   12e43:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   12e48:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12e4d:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12e52:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   12e56:	66 0f d6 4c 34 01    	movq   %xmm1,0x1(%rsp,%rsi,1)
   12e5c:	48 83 c6 08          	add    $0x8,%rsi
   12e60:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
   12e64:	49 39 f0             	cmp    %rsi,%r8
   12e67:	75 d1                	jne    12e3a <fwp_fmt_duration+0xaca>
   12e69:	48 85 d2             	test   %rdx,%rdx
   12e6c:	74 26                	je     12e94 <fwp_fmt_duration+0xb24>
   12e6e:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
   12e73:	48 01 f2             	add    %rsi,%rdx
   12e76:	48 ff ca             	dec    %rdx
   12e79:	44 89 ce             	mov    %r9d,%esi
   12e7c:	0f 1f 40 00          	nopl   0x0(%rax)
   12e80:	44 0f b6 02          	movzbl (%rdx),%r8d
   12e84:	44 88 44 0c 01       	mov    %r8b,0x1(%rsp,%rcx,1)
   12e89:	48 ff c1             	inc    %rcx
   12e8c:	48 ff ca             	dec    %rdx
   12e8f:	48 39 ce             	cmp    %rcx,%rsi
   12e92:	75 ec                	jne    12e80 <fwp_fmt_duration+0xb10>
   12e94:	c6 44 04 01 00       	movb   $0x0,0x1(%rsp,%rax,1)
   12e99:	e9 28 f9 ff ff       	jmp    127c6 <fwp_fmt_duration+0x456>
   12e9e:	66 90                	xchg   %ax,%ax

0000000000012ea0 <fwp_format_g>:
   12ea0:	55                   	push   %rbp
   12ea1:	41 57                	push   %r15
   12ea3:	41 56                	push   %r14
   12ea5:	41 55                	push   %r13
   12ea7:	41 54                	push   %r12
   12ea9:	53                   	push   %rbx
   12eaa:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   12eb1:	89 f5                	mov    %esi,%ebp
   12eb3:	48 89 fb             	mov    %rdi,%rbx
   12eb6:	ff cd                	dec    %ebp
   12eb8:	48 8d 15 ec 38 00 00 	lea    0x38ec(%rip),%rdx        # 167ab <exec_in_fp0+0xf3b>
   12ebf:	4c 8d 64 24 50       	lea    0x50(%rsp),%r12
   12ec4:	be 40 00 00 00       	mov    $0x40,%esi
   12ec9:	4c 89 e7             	mov    %r12,%rdi
   12ecc:	89 e9                	mov    %ebp,%ecx
   12ece:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
   12ed4:	b0 01                	mov    $0x1,%al
   12ed6:	e8 f5 02 ff ff       	call   31d0 <snprintf@plt>
   12edb:	4c 89 e7             	mov    %r12,%rdi
   12ede:	be 65 00 00 00       	mov    $0x65,%esi
   12ee3:	e8 c8 02 ff ff       	call   31b0 <strchr@plt>
   12ee8:	49 89 c7             	mov    %rax,%r15
   12eeb:	48 8d 78 01          	lea    0x1(%rax),%rdi
   12eef:	45 31 ed             	xor    %r13d,%r13d
   12ef2:	31 f6                	xor    %esi,%esi
   12ef4:	ba 0a 00 00 00       	mov    $0xa,%edx
   12ef9:	e8 22 04 ff ff       	call   3320 <strtol@plt>
   12efe:	49 89 c6             	mov    %rax,%r14
   12f01:	83 c0 ef             	add    $0xffffffef,%eax
   12f04:	83 f8 e9             	cmp    $0xffffffe9,%eax
   12f07:	77 5f                	ja     12f68 <fwp_format_g+0xc8>
   12f09:	4d 29 e7             	sub    %r12,%r15
   12f0c:	4c 8d 6c 24 10       	lea    0x10(%rsp),%r13
   12f11:	4c 89 ef             	mov    %r13,%rdi
   12f14:	4c 89 e6             	mov    %r12,%rsi
   12f17:	4c 89 fa             	mov    %r15,%rdx
   12f1a:	e8 11 04 ff ff       	call   3330 <memcpy@plt>
   12f1f:	42 c6 44 3c 10 00    	movb   $0x0,0x10(%rsp,%r15,1)
   12f25:	4c 89 ef             	mov    %r13,%rdi
   12f28:	be 2e 00 00 00       	mov    $0x2e,%esi
   12f2d:	e8 7e 02 ff ff       	call   31b0 <strchr@plt>
   12f32:	48 85 c0             	test   %rax,%rax
   12f35:	0f 84 a8 00 00 00    	je     12fe3 <fwp_format_g+0x143>
   12f3b:	4d 85 ff             	test   %r15,%r15
   12f3e:	0f 84 9f 00 00 00    	je     12fe3 <fwp_format_g+0x143>
   12f44:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
   12f4b:	00 00 00 00 00 
   12f50:	42 0f b6 44 3c 0f    	movzbl 0xf(%rsp,%r15,1),%eax
   12f56:	83 f8 30             	cmp    $0x30,%eax
   12f59:	75 7d                	jne    12fd8 <fwp_format_g+0x138>
   12f5b:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
   12f61:	49 ff cf             	dec    %r15
   12f64:	75 ea                	jne    12f50 <fwp_format_g+0xb0>
   12f66:	eb 7b                	jmp    12fe3 <fwp_format_g+0x143>
   12f68:	44 29 f5             	sub    %r14d,%ebp
   12f6b:	85 ed                	test   %ebp,%ebp
   12f6d:	44 0f 4f ed          	cmovg  %ebp,%r13d
   12f71:	48 8d 15 42 38 00 00 	lea    0x3842(%rip),%rdx        # 167ba <exec_in_fp0+0xf4a>
   12f78:	be 90 01 00 00       	mov    $0x190,%esi
   12f7d:	48 89 df             	mov    %rbx,%rdi
   12f80:	44 89 e9             	mov    %r13d,%ecx
   12f83:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
   12f89:	b0 01                	mov    $0x1,%al
   12f8b:	e8 40 02 ff ff       	call   31d0 <snprintf@plt>
   12f90:	48 89 df             	mov    %rbx,%rdi
   12f93:	e8 d8 01 ff ff       	call   3170 <strlen@plt>
   12f98:	49 89 c6             	mov    %rax,%r14
   12f9b:	48 89 df             	mov    %rbx,%rdi
   12f9e:	be 2e 00 00 00       	mov    $0x2e,%esi
   12fa3:	e8 08 02 ff ff       	call   31b0 <strchr@plt>
   12fa8:	48 85 c0             	test   %rax,%rax
   12fab:	74 69                	je     13016 <fwp_format_g+0x176>
   12fad:	4d 85 f6             	test   %r14,%r14
   12fb0:	74 64                	je     13016 <fwp_format_g+0x176>
   12fb2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   12fb9:	1f 84 00 00 00 00 00 
   12fc0:	42 0f b6 44 33 ff    	movzbl -0x1(%rbx,%r14,1),%eax
   12fc6:	83 f8 30             	cmp    $0x30,%eax
   12fc9:	75 5d                	jne    13028 <fwp_format_g+0x188>
   12fcb:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
   12fd1:	49 ff ce             	dec    %r14
   12fd4:	75 ea                	jne    12fc0 <fwp_format_g+0x120>
   12fd6:	eb 3e                	jmp    13016 <fwp_format_g+0x176>
   12fd8:	83 f8 2e             	cmp    $0x2e,%eax
   12fdb:	75 06                	jne    12fe3 <fwp_format_g+0x143>
   12fdd:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
   12fe3:	44 89 f0             	mov    %r14d,%eax
   12fe6:	c1 e8 1f             	shr    $0x1f,%eax
   12fe9:	44 8d 04 45 2b 00 00 	lea    0x2b(,%rax,2),%r8d
   12ff0:	00 
   12ff1:	45 89 f1             	mov    %r14d,%r9d
   12ff4:	41 f7 d9             	neg    %r9d
   12ff7:	45 0f 48 ce          	cmovs  %r14d,%r9d
   12ffb:	48 8d 15 ae 37 00 00 	lea    0x37ae(%rip),%rdx        # 167b0 <exec_in_fp0+0xf40>
   13002:	48 8d 4c 24 10       	lea    0x10(%rsp),%rcx
   13007:	be 90 01 00 00       	mov    $0x190,%esi
   1300c:	48 89 df             	mov    %rbx,%rdi
   1300f:	31 c0                	xor    %eax,%eax
   13011:	e8 ba 01 ff ff       	call   31d0 <snprintf@plt>
   13016:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
   1301d:	5b                   	pop    %rbx
   1301e:	41 5c                	pop    %r12
   13020:	41 5d                	pop    %r13
   13022:	41 5e                	pop    %r14
   13024:	41 5f                	pop    %r15
   13026:	5d                   	pop    %rbp
   13027:	c3                   	ret
   13028:	83 f8 2e             	cmp    $0x2e,%eax
   1302b:	75 e9                	jne    13016 <fwp_format_g+0x176>
   1302d:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
   13033:	eb e1                	jmp    13016 <fwp_format_g+0x176>
   13035:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   1303c:	00 00 00 00 

0000000000013040 <fwp_encode>:
   13040:	55                   	push   %rbp
   13041:	41 57                	push   %r15
   13043:	41 56                	push   %r14
   13045:	41 55                	push   %r13
   13047:	41 54                	push   %r12
   13049:	53                   	push   %rbx
   1304a:	48 83 ec 28          	sub    $0x28,%rsp
   1304e:	8b 02                	mov    (%rdx),%eax
   13050:	48 83 f8 15          	cmp    $0x15,%rax
   13054:	0f 87 91 01 00 00    	ja     131eb <fwp_encode+0x1ab>
   1305a:	49 89 d6             	mov    %rdx,%r14
   1305d:	48 89 f3             	mov    %rsi,%rbx
   13060:	48 89 7c 24 08       	mov    %rdi,0x8(%rsp)
   13065:	48 8d 0d a0 25 00 00 	lea    0x25a0(%rip),%rcx        # 1560c <_IO_stdin_used+0x60c>
   1306c:	48 63 04 81          	movslq (%rcx,%rax,4),%rax
   13070:	48 01 c8             	add    %rcx,%rax
   13073:	ff e0                	jmp    *%rax
   13075:	88 5c 24 07          	mov    %bl,0x7(%rsp)
   13079:	4c 8d 74 24 07       	lea    0x7(%rsp),%r14
   1307e:	ba 01 00 00 00       	mov    $0x1,%edx
   13083:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
   13088:	4c 89 ff             	mov    %r15,%rdi
   1308b:	4c 89 f6             	mov    %r14,%rsi
   1308e:	e8 7d a1 ff ff       	call   d210 <buf_put>
   13093:	88 7c 24 07          	mov    %bh,0x7(%rsp)
   13097:	ba 01 00 00 00       	mov    $0x1,%edx
   1309c:	4c 89 ff             	mov    %r15,%rdi
   1309f:	4c 89 f6             	mov    %r14,%rsi
   130a2:	e8 69 a1 ff ff       	call   d210 <buf_put>
   130a7:	89 d8                	mov    %ebx,%eax
   130a9:	c1 e8 10             	shr    $0x10,%eax
   130ac:	88 44 24 07          	mov    %al,0x7(%rsp)
   130b0:	ba 01 00 00 00       	mov    $0x1,%edx
   130b5:	4c 89 ff             	mov    %r15,%rdi
   130b8:	4c 89 f6             	mov    %r14,%rsi
   130bb:	e8 50 a1 ff ff       	call   d210 <buf_put>
   130c0:	89 d8                	mov    %ebx,%eax
   130c2:	c1 e8 18             	shr    $0x18,%eax
   130c5:	88 44 24 07          	mov    %al,0x7(%rsp)
   130c9:	ba 01 00 00 00       	mov    $0x1,%edx
   130ce:	4c 89 ff             	mov    %r15,%rdi
   130d1:	4c 89 f6             	mov    %r14,%rsi
   130d4:	e8 37 a1 ff ff       	call   d210 <buf_put>
   130d9:	48 89 d8             	mov    %rbx,%rax
   130dc:	48 c1 e8 20          	shr    $0x20,%rax
   130e0:	88 44 24 07          	mov    %al,0x7(%rsp)
   130e4:	ba 01 00 00 00       	mov    $0x1,%edx
   130e9:	4c 89 ff             	mov    %r15,%rdi
   130ec:	4c 89 f6             	mov    %r14,%rsi
   130ef:	e8 1c a1 ff ff       	call   d210 <buf_put>
   130f4:	48 89 d8             	mov    %rbx,%rax
   130f7:	48 c1 e8 28          	shr    $0x28,%rax
   130fb:	88 44 24 07          	mov    %al,0x7(%rsp)
   130ff:	ba 01 00 00 00       	mov    $0x1,%edx
   13104:	4c 89 ff             	mov    %r15,%rdi
   13107:	4c 89 f6             	mov    %r14,%rsi
   1310a:	e8 01 a1 ff ff       	call   d210 <buf_put>
   1310f:	48 89 d8             	mov    %rbx,%rax
   13112:	48 c1 e8 30          	shr    $0x30,%rax
   13116:	88 44 24 07          	mov    %al,0x7(%rsp)
   1311a:	ba 01 00 00 00       	mov    $0x1,%edx
   1311f:	4c 89 ff             	mov    %r15,%rdi
   13122:	4c 89 f6             	mov    %r14,%rsi
   13125:	e8 e6 a0 ff ff       	call   d210 <buf_put>
   1312a:	48 c1 eb 38          	shr    $0x38,%rbx
   1312e:	eb 66                	jmp    13196 <fwp_encode+0x156>
   13130:	88 5c 24 07          	mov    %bl,0x7(%rsp)
   13134:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
   13139:	ba 01 00 00 00       	mov    $0x1,%edx
   1313e:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
   13143:	e9 9e 00 00 00       	jmp    131e6 <fwp_encode+0x1a6>
   13148:	88 5c 24 07          	mov    %bl,0x7(%rsp)
   1314c:	4c 8d 74 24 07       	lea    0x7(%rsp),%r14
   13151:	ba 01 00 00 00       	mov    $0x1,%edx
   13156:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
   1315b:	4c 89 ff             	mov    %r15,%rdi
   1315e:	4c 89 f6             	mov    %r14,%rsi
   13161:	e8 aa a0 ff ff       	call   d210 <buf_put>
   13166:	88 7c 24 07          	mov    %bh,0x7(%rsp)
   1316a:	ba 01 00 00 00       	mov    $0x1,%edx
   1316f:	4c 89 ff             	mov    %r15,%rdi
   13172:	4c 89 f6             	mov    %r14,%rsi
   13175:	e8 96 a0 ff ff       	call   d210 <buf_put>
   1317a:	89 d8                	mov    %ebx,%eax
   1317c:	c1 e8 10             	shr    $0x10,%eax
   1317f:	88 44 24 07          	mov    %al,0x7(%rsp)
   13183:	ba 01 00 00 00       	mov    $0x1,%edx
   13188:	4c 89 ff             	mov    %r15,%rdi
   1318b:	4c 89 f6             	mov    %r14,%rsi
   1318e:	e8 7d a0 ff ff       	call   d210 <buf_put>
   13193:	c1 eb 18             	shr    $0x18,%ebx
   13196:	88 5c 24 07          	mov    %bl,0x7(%rsp)
   1319a:	eb 3f                	jmp    131db <fwp_encode+0x19b>
   1319c:	4c 8b 3b             	mov    (%rbx),%r15
   1319f:	49 81 ff 80 00 00 00 	cmp    $0x80,%r15
   131a6:	0f 83 4a 02 00 00    	jae    133f6 <fwp_encode+0x3b6>
   131ac:	4d 89 fd             	mov    %r15,%r13
   131af:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   131b4:	e9 80 02 00 00       	jmp    13439 <fwp_encode+0x3f9>
   131b9:	88 5c 24 07          	mov    %bl,0x7(%rsp)
   131bd:	4c 8d 74 24 07       	lea    0x7(%rsp),%r14
   131c2:	ba 01 00 00 00       	mov    $0x1,%edx
   131c7:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
   131cc:	4c 89 ff             	mov    %r15,%rdi
   131cf:	4c 89 f6             	mov    %r14,%rsi
   131d2:	e8 39 a0 ff ff       	call   d210 <buf_put>
   131d7:	88 7c 24 07          	mov    %bh,0x7(%rsp)
   131db:	ba 01 00 00 00       	mov    $0x1,%edx
   131e0:	4c 89 ff             	mov    %r15,%rdi
   131e3:	4c 89 f6             	mov    %r14,%rsi
   131e6:	e8 25 a0 ff ff       	call   d210 <buf_put>
   131eb:	48 83 c4 28          	add    $0x28,%rsp
   131ef:	5b                   	pop    %rbx
   131f0:	41 5c                	pop    %r12
   131f2:	41 5d                	pop    %r13
   131f4:	41 5e                	pop    %r14
   131f6:	41 5f                	pop    %r15
   131f8:	5d                   	pop    %rbp
   131f9:	c3                   	ret
   131fa:	48 8b 03             	mov    (%rbx),%rax
   131fd:	4c 8b 6b 08          	mov    0x8(%rbx),%r13
   13201:	88 44 24 07          	mov    %al,0x7(%rsp)
   13205:	48 89 c3             	mov    %rax,%rbx
   13208:	4c 8d 74 24 07       	lea    0x7(%rsp),%r14
   1320d:	ba 01 00 00 00       	mov    $0x1,%edx
   13212:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   13217:	4c 89 e7             	mov    %r12,%rdi
   1321a:	4c 89 f6             	mov    %r14,%rsi
   1321d:	e8 ee 9f ff ff       	call   d210 <buf_put>
   13222:	88 7c 24 07          	mov    %bh,0x7(%rsp)
   13226:	ba 01 00 00 00       	mov    $0x1,%edx
   1322b:	4c 89 e7             	mov    %r12,%rdi
   1322e:	4c 89 f6             	mov    %r14,%rsi
   13231:	e8 da 9f ff ff       	call   d210 <buf_put>
   13236:	44 89 e8             	mov    %r13d,%eax
   13239:	c1 e8 10             	shr    $0x10,%eax
   1323c:	89 44 24 14          	mov    %eax,0x14(%rsp)
   13240:	89 d8                	mov    %ebx,%eax
   13242:	c1 e8 10             	shr    $0x10,%eax
   13245:	88 44 24 07          	mov    %al,0x7(%rsp)
   13249:	ba 01 00 00 00       	mov    $0x1,%edx
   1324e:	4c 89 e7             	mov    %r12,%rdi
   13251:	4c 89 f6             	mov    %r14,%rsi
   13254:	e8 b7 9f ff ff       	call   d210 <buf_put>
   13259:	44 89 e8             	mov    %r13d,%eax
   1325c:	c1 e8 18             	shr    $0x18,%eax
   1325f:	89 44 24 10          	mov    %eax,0x10(%rsp)
   13263:	89 d8                	mov    %ebx,%eax
   13265:	c1 e8 18             	shr    $0x18,%eax
   13268:	88 44 24 07          	mov    %al,0x7(%rsp)
   1326c:	ba 01 00 00 00       	mov    $0x1,%edx
   13271:	4c 89 e7             	mov    %r12,%rdi
   13274:	4c 89 f6             	mov    %r14,%rsi
   13277:	e8 94 9f ff ff       	call   d210 <buf_put>
   1327c:	4c 89 e8             	mov    %r13,%rax
   1327f:	48 c1 e8 20          	shr    $0x20,%rax
   13283:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   13288:	48 89 d8             	mov    %rbx,%rax
   1328b:	48 c1 e8 20          	shr    $0x20,%rax
   1328f:	88 44 24 07          	mov    %al,0x7(%rsp)
   13293:	ba 01 00 00 00       	mov    $0x1,%edx
   13298:	4c 89 e7             	mov    %r12,%rdi
   1329b:	4c 89 f6             	mov    %r14,%rsi
   1329e:	e8 6d 9f ff ff       	call   d210 <buf_put>
   132a3:	4c 89 e8             	mov    %r13,%rax
   132a6:	48 c1 e8 28          	shr    $0x28,%rax
   132aa:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
   132af:	48 89 d8             	mov    %rbx,%rax
   132b2:	48 c1 e8 28          	shr    $0x28,%rax
   132b6:	88 44 24 07          	mov    %al,0x7(%rsp)
   132ba:	ba 01 00 00 00       	mov    $0x1,%edx
   132bf:	4c 89 e7             	mov    %r12,%rdi
   132c2:	4c 89 f6             	mov    %r14,%rsi
   132c5:	e8 46 9f ff ff       	call   d210 <buf_put>
   132ca:	4d 89 ef             	mov    %r13,%r15
   132cd:	49 c1 ef 30          	shr    $0x30,%r15
   132d1:	48 89 d8             	mov    %rbx,%rax
   132d4:	48 c1 e8 30          	shr    $0x30,%rax
   132d8:	88 44 24 07          	mov    %al,0x7(%rsp)
   132dc:	ba 01 00 00 00       	mov    $0x1,%edx
   132e1:	4c 89 e7             	mov    %r12,%rdi
   132e4:	4c 89 f6             	mov    %r14,%rsi
   132e7:	e8 24 9f ff ff       	call   d210 <buf_put>
   132ec:	4c 89 ed             	mov    %r13,%rbp
   132ef:	48 c1 ed 38          	shr    $0x38,%rbp
   132f3:	48 c1 eb 38          	shr    $0x38,%rbx
   132f7:	88 5c 24 07          	mov    %bl,0x7(%rsp)
   132fb:	ba 01 00 00 00       	mov    $0x1,%edx
   13300:	4c 89 e7             	mov    %r12,%rdi
   13303:	4c 89 f6             	mov    %r14,%rsi
   13306:	e8 05 9f ff ff       	call   d210 <buf_put>
   1330b:	44 88 6c 24 07       	mov    %r13b,0x7(%rsp)
   13310:	4c 89 eb             	mov    %r13,%rbx
   13313:	4c 8d 74 24 07       	lea    0x7(%rsp),%r14
   13318:	ba 01 00 00 00       	mov    $0x1,%edx
   1331d:	4c 89 e7             	mov    %r12,%rdi
   13320:	4c 89 f6             	mov    %r14,%rsi
   13323:	e8 e8 9e ff ff       	call   d210 <buf_put>
   13328:	88 7c 24 07          	mov    %bh,0x7(%rsp)
   1332c:	ba 01 00 00 00       	mov    $0x1,%edx
   13331:	4c 89 e7             	mov    %r12,%rdi
   13334:	4c 89 f6             	mov    %r14,%rsi
   13337:	e8 d4 9e ff ff       	call   d210 <buf_put>
   1333c:	8b 44 24 14          	mov    0x14(%rsp),%eax
   13340:	88 44 24 07          	mov    %al,0x7(%rsp)
   13344:	ba 01 00 00 00       	mov    $0x1,%edx
   13349:	4c 89 e7             	mov    %r12,%rdi
   1334c:	4c 89 f6             	mov    %r14,%rsi
   1334f:	e8 bc 9e ff ff       	call   d210 <buf_put>
   13354:	8b 44 24 10          	mov    0x10(%rsp),%eax
   13358:	88 44 24 07          	mov    %al,0x7(%rsp)
   1335c:	ba 01 00 00 00       	mov    $0x1,%edx
   13361:	4c 89 e7             	mov    %r12,%rdi
   13364:	4c 89 f6             	mov    %r14,%rsi
   13367:	e8 a4 9e ff ff       	call   d210 <buf_put>
   1336c:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
   13371:	88 44 24 07          	mov    %al,0x7(%rsp)
   13375:	ba 01 00 00 00       	mov    $0x1,%edx
   1337a:	4c 89 e7             	mov    %r12,%rdi
   1337d:	4c 89 f6             	mov    %r14,%rsi
   13380:	e8 8b 9e ff ff       	call   d210 <buf_put>
   13385:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
   1338a:	88 44 24 07          	mov    %al,0x7(%rsp)
   1338e:	ba 01 00 00 00       	mov    $0x1,%edx
   13393:	4c 89 e7             	mov    %r12,%rdi
   13396:	4c 89 f6             	mov    %r14,%rsi
   13399:	e8 72 9e ff ff       	call   d210 <buf_put>
   1339e:	44 88 7c 24 07       	mov    %r15b,0x7(%rsp)
   133a3:	ba 01 00 00 00       	mov    $0x1,%edx
   133a8:	4c 89 e7             	mov    %r12,%rdi
   133ab:	4c 89 f6             	mov    %r14,%rsi
   133ae:	e8 5d 9e ff ff       	call   d210 <buf_put>
   133b3:	40 88 6c 24 07       	mov    %bpl,0x7(%rsp)
   133b8:	ba 01 00 00 00       	mov    $0x1,%edx
   133bd:	4c 89 e7             	mov    %r12,%rdi
   133c0:	e9 1e fe ff ff       	jmp    131e3 <fwp_encode+0x1a3>
   133c5:	4c 8b 2b             	mov    (%rbx),%r13
   133c8:	49 81 fd 80 00 00 00 	cmp    $0x80,%r13
   133cf:	0f 83 dc 00 00 00    	jae    134b1 <fwp_encode+0x471>
   133d5:	4c 89 ed             	mov    %r13,%rbp
   133d8:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   133dd:	e9 07 01 00 00       	jmp    134e9 <fwp_encode+0x4a9>
   133e2:	48 81 fb ff 0f 00 00 	cmp    $0xfff,%rbx
   133e9:	0f 87 d1 01 00 00    	ja     135c0 <fwp_encode+0x580>
   133ef:	89 d8                	mov    %ebx,%eax
   133f1:	e9 cc 01 00 00       	jmp    135c2 <fwp_encode+0x582>
   133f6:	4c 8d 74 24 07       	lea    0x7(%rsp),%r14
   133fb:	4d 89 fd             	mov    %r15,%r13
   133fe:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   13403:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   1340a:	84 00 00 00 00 00 
   13410:	49 c1 ed 07          	shr    $0x7,%r13
   13414:	44 89 f8             	mov    %r15d,%eax
   13417:	0c 80                	or     $0x80,%al
   13419:	88 44 24 07          	mov    %al,0x7(%rsp)
   1341d:	ba 01 00 00 00       	mov    $0x1,%edx
   13422:	4c 89 e7             	mov    %r12,%rdi
   13425:	4c 89 f6             	mov    %r14,%rsi
   13428:	e8 e3 9d ff ff       	call   d210 <buf_put>
   1342d:	49 81 ff ff 3f 00 00 	cmp    $0x3fff,%r15
   13434:	4d 89 ef             	mov    %r13,%r15
   13437:	77 d7                	ja     13410 <fwp_encode+0x3d0>
   13439:	44 88 6c 24 07       	mov    %r13b,0x7(%rsp)
   1343e:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
   13443:	ba 01 00 00 00       	mov    $0x1,%edx
   13448:	4c 89 e7             	mov    %r12,%rdi
   1344b:	e8 c0 9d ff ff       	call   d210 <buf_put>
   13450:	48 8b 13             	mov    (%rbx),%rdx
   13453:	48 83 c3 08          	add    $0x8,%rbx
   13457:	4c 89 e7             	mov    %r12,%rdi
   1345a:	48 89 de             	mov    %rbx,%rsi
   1345d:	48 83 c4 28          	add    $0x28,%rsp
   13461:	5b                   	pop    %rbx
   13462:	41 5c                	pop    %r12
   13464:	41 5d                	pop    %r13
   13466:	41 5e                	pop    %r14
   13468:	41 5f                	pop    %r15
   1346a:	5d                   	pop    %rbp
   1346b:	e9 a0 9d ff ff       	jmp    d210 <buf_put>
   13470:	48 85 db             	test   %rbx,%rbx
   13473:	0f 84 15 03 00 00    	je     1378e <fwp_encode+0x74e>
   13479:	45 31 ed             	xor    %r13d,%r13d
   1347c:	48 89 d8             	mov    %rbx,%rax
   1347f:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   13484:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
   1348b:	00 00 00 00 00 
   13490:	49 ff c5             	inc    %r13
   13493:	48 8b 40 10          	mov    0x10(%rax),%rax
   13497:	48 85 c0             	test   %rax,%rax
   1349a:	75 f4                	jne    13490 <fwp_encode+0x450>
   1349c:	49 81 fd 80 00 00 00 	cmp    $0x80,%r13
   134a3:	0f 83 ef 02 00 00    	jae    13798 <fwp_encode+0x758>
   134a9:	4c 89 ed             	mov    %r13,%rbp
   134ac:	e9 18 03 00 00       	jmp    137c9 <fwp_encode+0x789>
   134b1:	4c 8d 7c 24 07       	lea    0x7(%rsp),%r15
   134b6:	4c 89 ed             	mov    %r13,%rbp
   134b9:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   134be:	66 90                	xchg   %ax,%ax
   134c0:	48 c1 ed 07          	shr    $0x7,%rbp
   134c4:	44 89 e8             	mov    %r13d,%eax
   134c7:	0c 80                	or     $0x80,%al
   134c9:	88 44 24 07          	mov    %al,0x7(%rsp)
   134cd:	ba 01 00 00 00       	mov    $0x1,%edx
   134d2:	4c 89 e7             	mov    %r12,%rdi
   134d5:	4c 89 fe             	mov    %r15,%rsi
   134d8:	e8 33 9d ff ff       	call   d210 <buf_put>
   134dd:	49 81 fd ff 3f 00 00 	cmp    $0x3fff,%r13
   134e4:	49 89 ed             	mov    %rbp,%r13
   134e7:	77 d7                	ja     134c0 <fwp_encode+0x480>
   134e9:	40 88 6c 24 07       	mov    %bpl,0x7(%rsp)
   134ee:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
   134f3:	ba 01 00 00 00       	mov    $0x1,%edx
   134f8:	4c 89 e7             	mov    %r12,%rdi
   134fb:	e8 10 9d ff ff       	call   d210 <buf_put>
   13500:	48 83 3b 00          	cmpq   $0x0,(%rbx)
   13504:	0f 84 e1 fc ff ff    	je     131eb <fwp_encode+0x1ab>
   1350a:	4c 8d 7b 10          	lea    0x10(%rbx),%r15
   1350e:	45 31 ed             	xor    %r13d,%r13d
   13511:	eb 1d                	jmp    13530 <fwp_encode+0x4f0>
   13513:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   1351a:	84 00 00 00 00 00 
   13520:	49 ff c5             	inc    %r13
   13523:	49 83 c7 10          	add    $0x10,%r15
   13527:	4c 3b 2b             	cmp    (%rbx),%r13
   1352a:	0f 83 bb fc ff ff    	jae    131eb <fwp_encode+0x1ab>
   13530:	49 8b 77 f8          	mov    -0x8(%r15),%rsi
   13534:	49 8b 56 38          	mov    0x38(%r14),%rdx
   13538:	4c 89 e7             	mov    %r12,%rdi
   1353b:	e8 00 fb ff ff       	call   13040 <fwp_encode>
   13540:	41 83 3e 12          	cmpl   $0x12,(%r14)
   13544:	75 da                	jne    13520 <fwp_encode+0x4e0>
   13546:	49 8b 37             	mov    (%r15),%rsi
   13549:	49 8b 56 40          	mov    0x40(%r14),%rdx
   1354d:	4c 89 e7             	mov    %r12,%rdi
   13550:	e8 eb fa ff ff       	call   13040 <fwp_encode>
   13555:	eb c9                	jmp    13520 <fwp_encode+0x4e0>
   13557:	41 83 7e 10 00       	cmpl   $0x0,0x10(%r14)
   1355c:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   13561:	0f 8e 84 fc ff ff    	jle    131eb <fwp_encode+0x1ab>
   13567:	45 31 ff             	xor    %r15d,%r15d
   1356a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   13570:	4a 8b 74 fb 08       	mov    0x8(%rbx,%r15,8),%rsi
   13575:	49 8b 46 20          	mov    0x20(%r14),%rax
   13579:	4a 8b 14 f8          	mov    (%rax,%r15,8),%rdx
   1357d:	4c 89 e7             	mov    %r12,%rdi
   13580:	e8 bb fa ff ff       	call   13040 <fwp_encode>
   13585:	49 ff c7             	inc    %r15
   13588:	49 63 46 10          	movslq 0x10(%r14),%rax
   1358c:	49 39 c7             	cmp    %rax,%r15
   1358f:	7c df                	jl     13570 <fwp_encode+0x530>
   13591:	e9 55 fc ff ff       	jmp    131eb <fwp_encode+0x1ab>
   13596:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
   1359d:	ff ff 7f 
   135a0:	4c 8b 2b             	mov    (%rbx),%r13
   135a3:	49 21 c5             	and    %rax,%r13
   135a6:	49 81 fd 80 00 00 00 	cmp    $0x80,%r13
   135ad:	0f 83 bb 00 00 00    	jae    1366e <fwp_encode+0x62e>
   135b3:	4c 89 ed             	mov    %r13,%rbp
   135b6:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   135bb:	e9 e9 00 00 00       	jmp    136a9 <fwp_encode+0x669>
   135c0:	8b 03                	mov    (%rbx),%eax
   135c2:	41 89 c4             	mov    %eax,%r12d
   135c5:	4c 89 e5             	mov    %r12,%rbp
   135c8:	3d 80 00 00 00       	cmp    $0x80,%eax
   135cd:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
   135d2:	72 37                	jb     1360b <fwp_encode+0x5cb>
   135d4:	4d 89 e5             	mov    %r12,%r13
   135d7:	4c 89 e5             	mov    %r12,%rbp
   135da:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   135e0:	48 c1 ed 07          	shr    $0x7,%rbp
   135e4:	44 89 e8             	mov    %r13d,%eax
   135e7:	0c 80                	or     $0x80,%al
   135e9:	88 44 24 07          	mov    %al,0x7(%rsp)
   135ed:	ba 01 00 00 00       	mov    $0x1,%edx
   135f2:	4c 89 ff             	mov    %r15,%rdi
   135f5:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
   135fa:	e8 11 9c ff ff       	call   d210 <buf_put>
   135ff:	49 81 fd ff 3f 00 00 	cmp    $0x3fff,%r13
   13606:	49 89 ed             	mov    %rbp,%r13
   13609:	77 d5                	ja     135e0 <fwp_encode+0x5a0>
   1360b:	40 88 6c 24 07       	mov    %bpl,0x7(%rsp)
   13610:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
   13615:	ba 01 00 00 00       	mov    $0x1,%edx
   1361a:	4c 89 ff             	mov    %r15,%rdi
   1361d:	e8 ee 9b ff ff       	call   d210 <buf_put>
   13622:	49 8b 46 28          	mov    0x28(%r14),%rax
   13626:	42 83 3c a0 00       	cmpl   $0x0,(%rax,%r12,4)
   1362b:	0f 8e ba fb ff ff    	jle    131eb <fwp_encode+0x1ab>
   13631:	4d 89 fd             	mov    %r15,%r13
   13634:	45 31 ff             	xor    %r15d,%r15d
   13637:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   1363e:	00 00 
   13640:	4a 8b 74 fb 08       	mov    0x8(%rbx,%r15,8),%rsi
   13645:	49 8b 46 30          	mov    0x30(%r14),%rax
   13649:	4a 8b 04 e0          	mov    (%rax,%r12,8),%rax
   1364d:	4a 8b 14 f8          	mov    (%rax,%r15,8),%rdx
   13651:	4c 89 ef             	mov    %r13,%rdi
   13654:	e8 e7 f9 ff ff       	call   13040 <fwp_encode>
   13659:	49 ff c7             	inc    %r15
   1365c:	49 8b 46 28          	mov    0x28(%r14),%rax
   13660:	4a 63 04 a0          	movslq (%rax,%r12,4),%rax
   13664:	49 39 c7             	cmp    %rax,%r15
   13667:	7c d7                	jl     13640 <fwp_encode+0x600>
   13669:	e9 7d fb ff ff       	jmp    131eb <fwp_encode+0x1ab>
   1366e:	4c 8d 7c 24 07       	lea    0x7(%rsp),%r15
   13673:	4c 89 ed             	mov    %r13,%rbp
   13676:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   1367b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   13680:	48 c1 ed 07          	shr    $0x7,%rbp
   13684:	44 89 e8             	mov    %r13d,%eax
   13687:	0c 80                	or     $0x80,%al
   13689:	88 44 24 07          	mov    %al,0x7(%rsp)
   1368d:	ba 01 00 00 00       	mov    $0x1,%edx
   13692:	4c 89 e7             	mov    %r12,%rdi
   13695:	4c 89 fe             	mov    %r15,%rsi
   13698:	e8 73 9b ff ff       	call   d210 <buf_put>
   1369d:	49 81 fd ff 3f 00 00 	cmp    $0x3fff,%r13
   136a4:	49 89 ed             	mov    %rbp,%r13
   136a7:	77 d7                	ja     13680 <fwp_encode+0x640>
   136a9:	40 88 6c 24 07       	mov    %bpl,0x7(%rsp)
   136ae:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
   136b3:	ba 01 00 00 00       	mov    $0x1,%edx
   136b8:	4c 89 e7             	mov    %r12,%rdi
   136bb:	e8 50 9b ff ff       	call   d210 <buf_put>
   136c0:	48 8b 03             	mov    (%rbx),%rax
   136c3:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
   136ca:	ff ff 7f 
   136cd:	4c 85 e0             	test   %r12,%rax
   136d0:	0f 84 15 fb ff ff    	je     131eb <fwp_encode+0x1ab>
   136d6:	4c 8d 7b 08          	lea    0x8(%rbx),%r15
   136da:	31 ed                	xor    %ebp,%ebp
   136dc:	4c 8d 2d 0d 22 00 00 	lea    0x220d(%rip),%r13        # 158f0 <exec_in_fp0+0x80>
   136e3:	eb 34                	jmp    13719 <fwp_encode+0x6d9>
   136e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   136ec:	00 00 00 00 
   136f0:	83 3a 01             	cmpl   $0x1,(%rdx)
   136f3:	0f b7 04 06          	movzwl (%rsi,%rax,1),%eax
   136f7:	48 0f bf f0          	movswq %ax,%rsi
   136fb:	48 0f 45 f0          	cmovne %rax,%rsi
   136ff:	e8 3c f9 ff ff       	call   13040 <fwp_encode>
   13704:	48 ff c5             	inc    %rbp
   13707:	48 8b 03             	mov    (%rbx),%rax
   1370a:	48 89 c1             	mov    %rax,%rcx
   1370d:	4c 21 e1             	and    %r12,%rcx
   13710:	48 39 cd             	cmp    %rcx,%rbp
   13713:	0f 83 d2 fa ff ff    	jae    131eb <fwp_encode+0x1ab>
   13719:	49 8b 56 38          	mov    0x38(%r14),%rdx
   1371d:	b9 08 00 00 00       	mov    $0x8,%ecx
   13722:	48 85 d2             	test   %rdx,%rdx
   13725:	74 19                	je     13740 <fwp_encode+0x700>
   13727:	8b 32                	mov    (%rdx),%esi
   13729:	48 83 fe 0a          	cmp    $0xa,%rsi
   1372d:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
   13732:	77 11                	ja     13745 <fwp_encode+0x705>
   13734:	49 8b 4c f5 00       	mov    0x0(%r13,%rsi,8),%rcx
   13739:	eb 0a                	jmp    13745 <fwp_encode+0x705>
   1373b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   13740:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
   13745:	4c 89 fe             	mov    %r15,%rsi
   13748:	48 85 c0             	test   %rax,%rax
   1374b:	79 04                	jns    13751 <fwp_encode+0x711>
   1374d:	48 8b 73 10          	mov    0x10(%rbx),%rsi
   13751:	48 89 c8             	mov    %rcx,%rax
   13754:	48 0f af c5          	imul   %rbp,%rax
   13758:	48 83 f9 01          	cmp    $0x1,%rcx
   1375c:	74 12                	je     13770 <fwp_encode+0x730>
   1375e:	48 83 f9 02          	cmp    $0x2,%rcx
   13762:	74 8c                	je     136f0 <fwp_encode+0x6b0>
   13764:	48 83 f9 08          	cmp    $0x8,%rcx
   13768:	75 16                	jne    13780 <fwp_encode+0x740>
   1376a:	48 8b 34 06          	mov    (%rsi,%rax,1),%rsi
   1376e:	eb 8f                	jmp    136ff <fwp_encode+0x6bf>
   13770:	83 3a 00             	cmpl   $0x0,(%rdx)
   13773:	0f b6 04 06          	movzbl (%rsi,%rax,1),%eax
   13777:	48 0f be f0          	movsbq %al,%rsi
   1377b:	e9 7b ff ff ff       	jmp    136fb <fwp_encode+0x6bb>
   13780:	83 3a 02             	cmpl   $0x2,(%rdx)
   13783:	8b 04 06             	mov    (%rsi,%rax,1),%eax
   13786:	48 63 f0             	movslq %eax,%rsi
   13789:	e9 6d ff ff ff       	jmp    136fb <fwp_encode+0x6bb>
   1378e:	c6 44 24 07 00       	movb   $0x0,0x7(%rsp)
   13793:	e9 9c f9 ff ff       	jmp    13134 <fwp_encode+0xf4>
   13798:	4c 8d 7c 24 07       	lea    0x7(%rsp),%r15
   1379d:	4c 89 ed             	mov    %r13,%rbp
   137a0:	48 c1 ed 07          	shr    $0x7,%rbp
   137a4:	44 89 e8             	mov    %r13d,%eax
   137a7:	0c 80                	or     $0x80,%al
   137a9:	88 44 24 07          	mov    %al,0x7(%rsp)
   137ad:	ba 01 00 00 00       	mov    $0x1,%edx
   137b2:	4c 89 e7             	mov    %r12,%rdi
   137b5:	4c 89 fe             	mov    %r15,%rsi
   137b8:	e8 53 9a ff ff       	call   d210 <buf_put>
   137bd:	49 81 fd ff 3f 00 00 	cmp    $0x3fff,%r13
   137c4:	49 89 ed             	mov    %rbp,%r13
   137c7:	77 d7                	ja     137a0 <fwp_encode+0x760>
   137c9:	40 88 6c 24 07       	mov    %bpl,0x7(%rsp)
   137ce:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
   137d3:	ba 01 00 00 00       	mov    $0x1,%edx
   137d8:	4c 89 e7             	mov    %r12,%rdi
   137db:	e8 30 9a ff ff       	call   d210 <buf_put>
   137e0:	48 85 db             	test   %rbx,%rbx
   137e3:	0f 84 02 fa ff ff    	je     131eb <fwp_encode+0x1ab>
   137e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   137f0:	48 8b 73 08          	mov    0x8(%rbx),%rsi
   137f4:	49 8b 56 38          	mov    0x38(%r14),%rdx
   137f8:	4c 89 e7             	mov    %r12,%rdi
   137fb:	e8 40 f8 ff ff       	call   13040 <fwp_encode>
   13800:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
   13804:	48 85 db             	test   %rbx,%rbx
   13807:	75 e7                	jne    137f0 <fwp_encode+0x7b0>
   13809:	e9 dd f9 ff ff       	jmp    131eb <fwp_encode+0x1ab>
   1380e:	66 90                	xchg   %ax,%ax

0000000000013810 <rd_leb>:
   13810:	48 c7 06 00 00 00 00 	movq   $0x0,(%rsi)
   13817:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   1381b:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   1381f:	75 03                	jne    13824 <rd_leb+0x14>
   13821:	31 c0                	xor    %eax,%eax
   13823:	c3                   	ret
   13824:	48 8b 0f             	mov    (%rdi),%rcx
   13827:	48 8d 42 01          	lea    0x1(%rdx),%rax
   1382b:	48 89 47 10          	mov    %rax,0x10(%rdi)
   1382f:	0f b6 04 11          	movzbl (%rcx,%rdx,1),%eax
   13833:	83 e0 7f             	and    $0x7f,%eax
   13836:	48 09 06             	or     %rax,(%rsi)
   13839:	b8 01 00 00 00       	mov    $0x1,%eax
   1383e:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   13842:	78 01                	js     13845 <rd_leb+0x35>
   13844:	c3                   	ret
   13845:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   13849:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   1384d:	74 d2                	je     13821 <rd_leb+0x11>
   1384f:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   13853:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   13857:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   1385c:	41 83 e0 7f          	and    $0x7f,%r8d
   13860:	41 c1 e0 07          	shl    $0x7,%r8d
   13864:	4c 09 06             	or     %r8,(%rsi)
   13867:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   1386b:	79 d7                	jns    13844 <rd_leb+0x34>
   1386d:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   13871:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   13875:	74 aa                	je     13821 <rd_leb+0x11>
   13877:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   1387b:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   1387f:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   13884:	41 83 e0 7f          	and    $0x7f,%r8d
   13888:	41 c1 e0 0e          	shl    $0xe,%r8d
   1388c:	4c 09 06             	or     %r8,(%rsi)
   1388f:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   13893:	79 af                	jns    13844 <rd_leb+0x34>
   13895:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   13899:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   1389d:	74 82                	je     13821 <rd_leb+0x11>
   1389f:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   138a3:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   138a7:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   138ac:	41 83 e0 7f          	and    $0x7f,%r8d
   138b0:	41 c1 e0 15          	shl    $0x15,%r8d
   138b4:	4c 09 06             	or     %r8,(%rsi)
   138b7:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   138bb:	79 87                	jns    13844 <rd_leb+0x34>
   138bd:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   138c1:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   138c5:	0f 84 56 ff ff ff    	je     13821 <rd_leb+0x11>
   138cb:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   138cf:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   138d3:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   138d8:	41 83 e0 7f          	and    $0x7f,%r8d
   138dc:	49 c1 e0 1c          	shl    $0x1c,%r8
   138e0:	4c 09 06             	or     %r8,(%rsi)
   138e3:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   138e7:	0f 89 57 ff ff ff    	jns    13844 <rd_leb+0x34>
   138ed:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   138f1:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   138f5:	0f 84 26 ff ff ff    	je     13821 <rd_leb+0x11>
   138fb:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   138ff:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   13903:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   13908:	41 83 e0 7f          	and    $0x7f,%r8d
   1390c:	49 c1 e0 23          	shl    $0x23,%r8
   13910:	4c 09 06             	or     %r8,(%rsi)
   13913:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   13917:	0f 89 27 ff ff ff    	jns    13844 <rd_leb+0x34>
   1391d:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   13921:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   13925:	0f 84 f6 fe ff ff    	je     13821 <rd_leb+0x11>
   1392b:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   1392f:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   13933:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   13938:	41 83 e0 7f          	and    $0x7f,%r8d
   1393c:	49 c1 e0 2a          	shl    $0x2a,%r8
   13940:	4c 09 06             	or     %r8,(%rsi)
   13943:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   13947:	0f 89 f7 fe ff ff    	jns    13844 <rd_leb+0x34>
   1394d:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   13951:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   13955:	0f 84 c6 fe ff ff    	je     13821 <rd_leb+0x11>
   1395b:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   1395f:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   13963:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   13968:	41 83 e0 7f          	and    $0x7f,%r8d
   1396c:	49 c1 e0 31          	shl    $0x31,%r8
   13970:	4c 09 06             	or     %r8,(%rsi)
   13973:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   13977:	0f 89 c7 fe ff ff    	jns    13844 <rd_leb+0x34>
   1397d:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   13981:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   13985:	0f 84 96 fe ff ff    	je     13821 <rd_leb+0x11>
   1398b:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   1398f:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   13993:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   13998:	41 83 e0 7f          	and    $0x7f,%r8d
   1399c:	49 c1 e0 38          	shl    $0x38,%r8
   139a0:	4c 09 06             	or     %r8,(%rsi)
   139a3:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   139a7:	0f 89 97 fe ff ff    	jns    13844 <rd_leb+0x34>
   139ad:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   139b1:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   139b5:	0f 84 66 fe ff ff    	je     13821 <rd_leb+0x11>
   139bb:	48 8d 42 01          	lea    0x1(%rdx),%rax
   139bf:	48 89 47 10          	mov    %rax,0x10(%rdi)
   139c3:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
   139c7:	b8 00 00 00 00       	mov    $0x0,%eax
   139cc:	40 f6 c7 7e          	test   $0x7e,%dil
   139d0:	0f 85 6e fe ff ff    	jne    13844 <rd_leb+0x34>
   139d6:	48 c1 e7 3f          	shl    $0x3f,%rdi
   139da:	48 09 3e             	or     %rdi,(%rsi)
   139dd:	31 c0                	xor    %eax,%eax
   139df:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   139e3:	0f 99 c0             	setns  %al
   139e6:	c3                   	ret
   139e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   139ee:	00 00 

00000000000139f0 <fwp_wire_empty_inner>:
   139f0:	31 c0                	xor    %eax,%eax
   139f2:	48 85 ff             	test   %rdi,%rdi
   139f5:	0f 84 a0 00 00 00    	je     13a9b <fwp_wire_empty_inner+0xab>
   139fb:	83 3f 10             	cmpl   $0x10,(%rdi)
   139fe:	0f 85 97 00 00 00    	jne    13a9b <fwp_wire_empty_inner+0xab>
   13a04:	41 57                	push   %r15
   13a06:	41 56                	push   %r14
   13a08:	41 54                	push   %r12
   13a0a:	53                   	push   %rbx
   13a0b:	48 83 ec 18          	sub    $0x18,%rsp
   13a0f:	48 85 f6             	test   %rsi,%rsi
   13a12:	74 1a                	je     13a2e <fwp_wire_empty_inner+0x3e>
   13a14:	48 89 f1             	mov    %rsi,%rcx
   13a17:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   13a1e:	00 00 
   13a20:	48 39 39             	cmp    %rdi,(%rcx)
   13a23:	74 6b                	je     13a90 <fwp_wire_empty_inner+0xa0>
   13a25:	48 8b 49 08          	mov    0x8(%rcx),%rcx
   13a29:	48 85 c9             	test   %rcx,%rcx
   13a2c:	75 f2                	jne    13a20 <fwp_wire_empty_inner+0x30>
   13a2e:	48 89 7c 24 08       	mov    %rdi,0x8(%rsp)
   13a33:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
   13a38:	44 8b 77 10          	mov    0x10(%rdi),%r14d
   13a3c:	45 85 f6             	test   %r14d,%r14d
   13a3f:	7e 46                	jle    13a87 <fwp_wire_empty_inner+0x97>
   13a41:	4c 8b 7f 20          	mov    0x20(%rdi),%r15
   13a45:	49 8b 3f             	mov    (%r15),%rdi
   13a48:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
   13a4d:	e8 9e ff ff ff       	call   139f0 <fwp_wire_empty_inner>
   13a52:	85 c0                	test   %eax,%eax
   13a54:	74 38                	je     13a8e <fwp_wire_empty_inner+0x9e>
   13a56:	b9 01 00 00 00       	mov    $0x1,%ecx
   13a5b:	48 8d 5c 24 08       	lea    0x8(%rsp),%rbx
   13a60:	49 89 cc             	mov    %rcx,%r12
   13a63:	49 39 ce             	cmp    %rcx,%r14
   13a66:	74 15                	je     13a7d <fwp_wire_empty_inner+0x8d>
   13a68:	4b 8b 3c e7          	mov    (%r15,%r12,8),%rdi
   13a6c:	48 89 de             	mov    %rbx,%rsi
   13a6f:	e8 7c ff ff ff       	call   139f0 <fwp_wire_empty_inner>
   13a74:	49 8d 4c 24 01       	lea    0x1(%r12),%rcx
   13a79:	85 c0                	test   %eax,%eax
   13a7b:	75 e3                	jne    13a60 <fwp_wire_empty_inner+0x70>
   13a7d:	31 c0                	xor    %eax,%eax
   13a7f:	4d 39 f4             	cmp    %r14,%r12
   13a82:	0f 93 c0             	setae  %al
   13a85:	eb 09                	jmp    13a90 <fwp_wire_empty_inner+0xa0>
   13a87:	b8 01 00 00 00       	mov    $0x1,%eax
   13a8c:	eb 02                	jmp    13a90 <fwp_wire_empty_inner+0xa0>
   13a8e:	31 c0                	xor    %eax,%eax
   13a90:	48 83 c4 18          	add    $0x18,%rsp
   13a94:	5b                   	pop    %rbx
   13a95:	41 5c                	pop    %r12
   13a97:	41 5e                	pop    %r14
   13a99:	41 5f                	pop    %r15
   13a9b:	c3                   	ret
   13a9c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000013aa0 <fwp_gc_find_data>:
   13aa0:	0f b7 77 18          	movzwl 0x18(%rdi),%esi
   13aa4:	48 85 f6             	test   %rsi,%rsi
   13aa7:	0f 84 be 00 00 00    	je     13b6b <fwp_gc_find_data+0xcb>
   13aad:	53                   	push   %rbx
   13aae:	48 8b 07             	mov    (%rdi),%rax
   13ab1:	4c 8b 47 10          	mov    0x10(%rdi),%r8
   13ab5:	48 6b ce 38          	imul   $0x38,%rsi,%rcx
   13ab9:	45 31 c9             	xor    %r9d,%r9d
   13abc:	48 8d 15 c5 67 00 00 	lea    0x67c5(%rip),%rdx        # 1a288 <fwp_gc>
   13ac3:	41 bb 01 00 00 00    	mov    $0x1,%r11d
   13ac9:	45 31 d2             	xor    %r10d,%r10d
   13acc:	eb 0b                	jmp    13ad9 <fwp_gc_find_data+0x39>
   13ace:	66 90                	xchg   %ax,%ax
   13ad0:	49 83 c1 38          	add    $0x38,%r9
   13ad4:	4c 39 c9             	cmp    %r9,%rcx
   13ad7:	74 22                	je     13afb <fwp_gc_find_data+0x5b>
   13ad9:	43 83 3c 08 01       	cmpl   $0x1,(%r8,%r9,1)
   13ade:	75 f0                	jne    13ad0 <fwp_gc_find_data+0x30>
   13ae0:	4b 8b 5c 08 10       	mov    0x10(%r8,%r9,1),%rbx
   13ae5:	48 01 c3             	add    %rax,%rbx
   13ae8:	48 39 d3             	cmp    %rdx,%rbx
   13aeb:	77 e3                	ja     13ad0 <fwp_gc_find_data+0x30>
   13aed:	4b 03 5c 08 28       	add    0x28(%r8,%r9,1),%rbx
   13af2:	48 39 d3             	cmp    %rdx,%rbx
   13af5:	45 0f 47 d3          	cmova  %r11d,%r10d
   13af9:	eb d5                	jmp    13ad0 <fwp_gc_find_data+0x30>
   13afb:	31 c0                	xor    %eax,%eax
   13afd:	45 85 d2             	test   %r10d,%r10d
   13b00:	0f 95 c0             	setne  %al
   13b03:	74 6e                	je     13b73 <fwp_gc_find_data+0xd3>
   13b05:	66 85 f6             	test   %si,%si
   13b08:	74 69                	je     13b73 <fwp_gc_find_data+0xd3>
   13b0a:	8b 05 08 79 00 00    	mov    0x7908(%rip),%eax        # 1b418 <fwp_gc+0x1190>
   13b10:	48 8b 77 10          	mov    0x10(%rdi),%rsi
   13b14:	45 31 c0             	xor    %r8d,%r8d
   13b17:	eb 10                	jmp    13b29 <fwp_gc_find_data+0x89>
   13b19:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   13b20:	49 83 c0 38          	add    $0x38,%r8
   13b24:	4c 39 c1             	cmp    %r8,%rcx
   13b27:	74 45                	je     13b6e <fwp_gc_find_data+0xce>
   13b29:	42 83 3c 06 01       	cmpl   $0x1,(%rsi,%r8,1)
   13b2e:	75 f0                	jne    13b20 <fwp_gc_find_data+0x80>
   13b30:	42 f6 44 06 04 02    	testb  $0x2,0x4(%rsi,%r8,1)
   13b36:	74 e8                	je     13b20 <fwp_gc_find_data+0x80>
   13b38:	83 f8 10             	cmp    $0x10,%eax
   13b3b:	74 31                	je     13b6e <fwp_gc_find_data+0xce>
   13b3d:	4e 8b 4c 06 10       	mov    0x10(%rsi,%r8,1),%r9
   13b42:	4c 03 0f             	add    (%rdi),%r9
   13b45:	4c 63 d0             	movslq %eax,%r10
   13b48:	49 c1 e2 04          	shl    $0x4,%r10
   13b4c:	4d 89 8c 12 90 10 00 	mov    %r9,0x1090(%r10,%rdx,1)
   13b53:	00 
   13b54:	4e 8b 4c 06 28       	mov    0x28(%rsi,%r8,1),%r9
   13b59:	4d 89 8c 12 98 10 00 	mov    %r9,0x1098(%r10,%rdx,1)
   13b60:	00 
   13b61:	ff c0                	inc    %eax
   13b63:	89 05 af 78 00 00    	mov    %eax,0x78af(%rip)        # 1b418 <fwp_gc+0x1190>
   13b69:	eb b5                	jmp    13b20 <fwp_gc_find_data+0x80>
   13b6b:	31 c0                	xor    %eax,%eax
   13b6d:	c3                   	ret
   13b6e:	b8 01 00 00 00       	mov    $0x1,%eax
   13b73:	5b                   	pop    %rbx
   13b74:	c3                   	ret
   13b75:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   13b7c:	00 00 00 00 

0000000000013b80 <fwp_gc_report>:
   13b80:	55                   	push   %rbp
   13b81:	41 57                	push   %r15
   13b83:	41 56                	push   %r14
   13b85:	41 55                	push   %r13
   13b87:	41 54                	push   %r12
   13b89:	53                   	push   %rbx
   13b8a:	48 81 ec 58 01 00 00 	sub    $0x158,%rsp
   13b91:	48 8b 05 00 79 00 00 	mov    0x7900(%rip),%rax        # 1b498 <fwp_gc+0x1210>
   13b98:	48 8b 0d e9 66 00 00 	mov    0x66e9(%rip),%rcx        # 1a288 <fwp_gc>
   13b9f:	48 29 c8             	sub    %rcx,%rax
   13ba2:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
   13ba7:	f2 0f 58 05 c1 78 00 	addsd  0x78c1(%rip),%xmm0        # 1b470 <fwp_gc+0x11e8>
   13bae:	00 
   13baf:	f2 0f 11 44 24 48    	movsd  %xmm0,0x48(%rsp)
   13bb5:	f2 0f 11 05 b3 78 00 	movsd  %xmm0,0x78b3(%rip)        # 1b470 <fwp_gc+0x11e8>
   13bbc:	00 
   13bbd:	48 89 0d d4 78 00 00 	mov    %rcx,0x78d4(%rip)        # 1b498 <fwp_gc+0x1210>
   13bc4:	48 8b 05 0d 64 00 00 	mov    0x640d(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
   13bcb:	48 8b 28             	mov    (%rax),%rbp
   13bce:	48 8b 1d 8b 78 00 00 	mov    0x788b(%rip),%rbx        # 1b460 <fwp_gc+0x11d8>
   13bd5:	4c 8b 3d c4 76 00 00 	mov    0x76c4(%rip),%r15        # 1b2a0 <fwp_gc+0x1018>
   13bdc:	f2 0f 10 05 ac 78 00 	movsd  0x78ac(%rip),%xmm0        # 1b490 <fwp_gc+0x1208>
   13be3:	00 
   13be4:	f2 0f 11 44 24 30    	movsd  %xmm0,0x30(%rsp)
   13bea:	48 8b 05 df 76 00 00 	mov    0x76df(%rip),%rax        # 1b2d0 <fwp_gc+0x1048>
   13bf1:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
   13bf6:	48 8b 05 53 78 00 00 	mov    0x7853(%rip),%rax        # 1b450 <fwp_gc+0x11c8>
   13bfd:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   13c02:	4c 8b 35 4f 78 00 00 	mov    0x784f(%rip),%r14        # 1b458 <fwp_gc+0x11d0>
   13c09:	f2 0f 10 05 67 78 00 	movsd  0x7867(%rip),%xmm0        # 1b478 <fwp_gc+0x11f0>
   13c10:	00 
   13c11:	f2 0f 11 44 24 40    	movsd  %xmm0,0x40(%rsp)
   13c17:	f2 0f 10 05 61 78 00 	movsd  0x7861(%rip),%xmm0        # 1b480 <fwp_gc+0x11f8>
   13c1e:	00 
   13c1f:	f2 0f 11 44 24 38    	movsd  %xmm0,0x38(%rsp)
   13c25:	48 8d 3d a3 2d 00 00 	lea    0x2da3(%rip),%rdi        # 169cf <exec_in_fp0+0x115f>
   13c2c:	48 8d 35 9c 2b 00 00 	lea    0x2b9c(%rip),%rsi        # 167cf <exec_in_fp0+0xf5f>
   13c33:	e8 d8 f7 fe ff       	call   3410 <fopen@plt>
   13c38:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
   13c3f:	48 85 c0             	test   %rax,%rax
   13c42:	74 4b                	je     13c8f <fwp_gc_report+0x10f>
   13c44:	49 89 c5             	mov    %rax,%r13
   13c47:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
   13c4c:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
   13c51:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
   13c56:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
   13c5b:	be 00 01 00 00       	mov    $0x100,%esi
   13c60:	48 89 c2             	mov    %rax,%rdx
   13c63:	e8 28 f6 fe ff       	call   3290 <fgets@plt>
   13c68:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
   13c6f:	48 85 c0             	test   %rax,%rax
   13c72:	0f 85 f1 00 00 00    	jne    13d69 <fwp_gc_report+0x1e9>
   13c78:	4c 89 ef             	mov    %r13,%rdi
   13c7b:	e8 d0 f4 fe ff       	call   3150 <fclose@plt>
   13c80:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
   13c85:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
   13c8a:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
   13c8f:	66 49 0f 6e c6       	movq   %r14,%xmm0
   13c94:	66 0f 6f 0d 84 14 00 	movdqa 0x1484(%rip),%xmm1        # 15120 <_IO_stdin_used+0x120>
   13c9b:	00 
   13c9c:	66 0f 62 c1          	punpckldq %xmm1,%xmm0
   13ca0:	66 0f 28 15 88 14 00 	movapd 0x1488(%rip),%xmm2        # 15130 <_IO_stdin_used+0x130>
   13ca7:	00 
   13ca8:	66 0f 5c c2          	subpd  %xmm2,%xmm0
   13cac:	66 0f 28 e0          	movapd %xmm0,%xmm4
   13cb0:	66 0f 15 e0          	unpckhpd %xmm0,%xmm4
   13cb4:	f2 0f 58 e0          	addsd  %xmm0,%xmm4
   13cb8:	f2 0f 10 35 18 15 00 	movsd  0x1518(%rip),%xmm6        # 151d8 <_IO_stdin_used+0x1d8>
   13cbf:	00 
   13cc0:	f2 0f 59 e6          	mulsd  %xmm6,%xmm4
   13cc4:	f3 0f 7e 6c 24 20    	movq   0x20(%rsp),%xmm5
   13cca:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
   13cce:	66 0f 5c ea          	subpd  %xmm2,%xmm5
   13cd2:	66 0f 28 dd          	movapd %xmm5,%xmm3
   13cd6:	66 0f 15 dd          	unpckhpd %xmm5,%xmm3
   13cda:	f2 0f 58 dd          	addsd  %xmm5,%xmm3
   13cde:	f2 0f 59 de          	mulsd  %xmm6,%xmm3
   13ce2:	f3 0f 7e 6c 24 28    	movq   0x28(%rsp),%xmm5
   13ce8:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
   13cec:	66 0f 5c ea          	subpd  %xmm2,%xmm5
   13cf0:	66 0f 28 d5          	movapd %xmm5,%xmm2
   13cf4:	66 0f 15 d5          	unpckhpd %xmm5,%xmm2
   13cf8:	f2 0f 58 d5          	addsd  %xmm5,%xmm2
   13cfc:	f2 0f 59 d6          	mulsd  %xmm6,%xmm2
   13d00:	f2 0f 10 44 24 48    	movsd  0x48(%rsp),%xmm0
   13d06:	f2 0f 10 4c 24 30    	movsd  0x30(%rsp),%xmm1
   13d0c:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
   13d10:	f2 0f 59 ce          	mulsd  %xmm6,%xmm1
   13d14:	f2 0f 59 c6          	mulsd  %xmm6,%xmm0
   13d18:	83 3d 5d 75 00 00 00 	cmpl   $0x0,0x755d(%rip)        # 1b27c <fwp_gc+0xff4>
   13d1f:	48 8d 05 97 2c 00 00 	lea    0x2c97(%rip),%rax        # 169bd <exec_in_fp0+0x114d>
   13d26:	4c 8d 0d a8 24 00 00 	lea    0x24a8(%rip),%r9        # 161d5 <exec_in_fp0+0x965>
   13d2d:	4c 0f 44 c8          	cmove  %rax,%r9
   13d31:	48 8d 35 d0 2b 00 00 	lea    0x2bd0(%rip),%rsi        # 16908 <exec_in_fp0+0x1098>
   13d38:	48 89 ef             	mov    %rbp,%rdi
   13d3b:	48 89 da             	mov    %rbx,%rdx
   13d3e:	4c 89 f9             	mov    %r15,%rcx
   13d41:	f2 0f 10 6c 24 40    	movsd  0x40(%rsp),%xmm5
   13d47:	f2 0f 10 74 24 38    	movsd  0x38(%rsp),%xmm6
   13d4d:	4d 89 e0             	mov    %r12,%r8
   13d50:	b0 07                	mov    $0x7,%al
   13d52:	e8 99 f5 fe ff       	call   32f0 <fprintf@plt>
   13d57:	48 81 c4 58 01 00 00 	add    $0x158,%rsp
   13d5e:	5b                   	pop    %rbx
   13d5f:	41 5c                	pop    %r12
   13d61:	41 5d                	pop    %r13
   13d63:	41 5e                	pop    %r14
   13d65:	41 5f                	pop    %r15
   13d67:	5d                   	pop    %rbp
   13d68:	c3                   	ret
   13d69:	48 8d 6c 24 56       	lea    0x56(%rsp),%rbp
   13d6e:	41 bf 56 6d 48 57    	mov    $0x57486d56,%r15d
   13d74:	48 8d 5c 24 50       	lea    0x50(%rsp),%rbx
   13d79:	eb 1e                	jmp    13d99 <fwp_gc_report+0x219>
   13d7b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   13d80:	48 89 df             	mov    %rbx,%rdi
   13d83:	be 00 01 00 00       	mov    $0x100,%esi
   13d88:	4c 89 ea             	mov    %r13,%rdx
   13d8b:	e8 00 f5 fe ff       	call   3290 <fgets@plt>
   13d90:	48 85 c0             	test   %rax,%rax
   13d93:	0f 84 df fe ff ff    	je     13c78 <fwp_gc_report+0xf8>
   13d99:	8b 44 24 50          	mov    0x50(%rsp),%eax
   13d9d:	44 31 f8             	xor    %r15d,%eax
   13da0:	0f b6 4c 24 54       	movzbl 0x54(%rsp),%ecx
   13da5:	83 f1 4d             	xor    $0x4d,%ecx
   13da8:	09 c1                	or     %eax,%ecx
   13daa:	75 d4                	jne    13d80 <fwp_gc_report+0x200>
   13dac:	80 7c 24 55 3a       	cmpb   $0x3a,0x55(%rsp)
   13db1:	75 cd                	jne    13d80 <fwp_gc_report+0x200>
   13db3:	48 89 ef             	mov    %rbp,%rdi
   13db6:	31 f6                	xor    %esi,%esi
   13db8:	ba 0a 00 00 00       	mov    $0xa,%edx
   13dbd:	e8 5e f5 fe ff       	call   3320 <strtol@plt>
   13dc2:	49 89 c4             	mov    %rax,%r12
   13dc5:	eb b9                	jmp    13d80 <fwp_gc_report+0x200>
   13dc7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   13dce:	00 00 

0000000000013dd0 <fwp_owner_release0>:
   13dd0:	48 8b 3f             	mov    (%rdi),%rdi
   13dd3:	eb 0b                	jmp    13de0 <fwp_drop0>
   13dd5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   13ddc:	00 00 00 00 

0000000000013de0 <fwp_drop0>:
   13de0:	53                   	push   %rbx
   13de1:	48 89 f8             	mov    %rdi,%rax
   13de4:	48 2b 05 cd 74 00 00 	sub    0x74cd(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
   13deb:	48 8b 0d ee 74 00 00 	mov    0x74ee(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
   13df2:	48 c1 e1 10          	shl    $0x10,%rcx
   13df6:	48 39 c8             	cmp    %rcx,%rax
   13df9:	0f 83 9c 00 00 00    	jae    13e9b <fwp_drop0+0xbb>
   13dff:	48 8b 0d fa 74 00 00 	mov    0x74fa(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
   13e06:	48 89 c2             	mov    %rax,%rdx
   13e09:	48 c1 ea 10          	shr    $0x10,%rdx
   13e0d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
   13e14:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
   13e18:	48 25 ff ff 00 00    	and    $0xffff,%rax
   13e1e:	75 20                	jne    13e40 <fwp_drop0+0x60>
   13e20:	40 80 fe 02          	cmp    $0x2,%sil
   13e24:	75 1a                	jne    13e40 <fwp_drop0+0x60>
   13e26:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
   13e2a:	48 05 28 02 00 00    	add    $0x228,%rax
   13e30:	eb 2d                	jmp    13e5f <fwp_drop0+0x7f>
   13e32:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   13e39:	1f 84 00 00 00 00 00 
   13e40:	40 80 fe 01          	cmp    $0x1,%sil
   13e44:	75 55                	jne    13e9b <fwp_drop0+0xbb>
   13e46:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
   13e4a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
   13e4e:	48 0f af c1          	imul   %rcx,%rax
   13e52:	48 c1 e8 20          	shr    $0x20,%rax
   13e56:	48 01 f0             	add    %rsi,%rax
   13e59:	48 05 28 02 00 00    	add    $0x228,%rax
   13e5f:	0f b6 08             	movzbl (%rax),%ecx
   13e62:	85 c9                	test   %ecx,%ecx
   13e64:	74 35                	je     13e9b <fwp_drop0+0xbb>
   13e66:	83 f9 01             	cmp    $0x1,%ecx
   13e69:	75 32                	jne    13e9d <fwp_drop0+0xbd>
   13e6b:	48 83 3f 00          	cmpq   $0x0,(%rdi)
   13e6f:	79 3a                	jns    13eab <fwp_drop0+0xcb>
   13e71:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
   13e75:	e8 f6 6e ff ff       	call   ad70 <fwp_rc_free_arr>
   13e7a:	48 89 d8             	mov    %rbx,%rax
   13e7d:	48 2b 05 34 74 00 00 	sub    0x7434(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
   13e84:	48 8b 0d 55 74 00 00 	mov    0x7455(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
   13e8b:	48 c1 e1 10          	shl    $0x10,%rcx
   13e8f:	48 89 df             	mov    %rbx,%rdi
   13e92:	48 39 c8             	cmp    %rcx,%rax
   13e95:	0f 82 64 ff ff ff    	jb     13dff <fwp_drop0+0x1f>
   13e9b:	5b                   	pop    %rbx
   13e9c:	c3                   	ret
   13e9d:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
   13ea3:	74 0c                	je     13eb1 <fwp_drop0+0xd1>
   13ea5:	fe c9                	dec    %cl
   13ea7:	88 08                	mov    %cl,(%rax)
   13ea9:	5b                   	pop    %rbx
   13eaa:	c3                   	ret
   13eab:	5b                   	pop    %rbx
   13eac:	e9 bf 6e ff ff       	jmp    ad70 <fwp_rc_free_arr>
   13eb1:	48 89 c7             	mov    %rax,%rdi
   13eb4:	5b                   	pop    %rbx
   13eb5:	e9 36 67 ff ff       	jmp    a5f0 <fwp_rc_wide_drop>
   13eba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000013ec0 <fwp_owner_release1>:
   13ec0:	48 8b 3f             	mov    (%rdi),%rdi
   13ec3:	e9 18 ff ff ff       	jmp    13de0 <fwp_drop0>
   13ec8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   13ecf:	00 

0000000000013ed0 <fwp_owner_release2>:
   13ed0:	48 8b 3f             	mov    (%rdi),%rdi
   13ed3:	e9 08 ff ff ff       	jmp    13de0 <fwp_drop0>
   13ed8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   13edf:	00 

0000000000013ee0 <__divti3>:
   13ee0:	f3 0f 1e fa          	endbr64
   13ee4:	55                   	push   %rbp
   13ee5:	49 89 f8             	mov    %rdi,%r8
   13ee8:	49 89 d2             	mov    %rdx,%r10
   13eeb:	49 89 cb             	mov    %rcx,%r11
   13eee:	31 ff                	xor    %edi,%edi
   13ef0:	48 89 e5             	mov    %rsp,%rbp
   13ef3:	41 56                	push   %r14
   13ef5:	53                   	push   %rbx
   13ef6:	48 85 f6             	test   %rsi,%rsi
   13ef9:	79 13                	jns    13f0e <__divti3+0x2e>
   13efb:	45 31 c9             	xor    %r9d,%r9d
   13efe:	49 f7 d8             	neg    %r8
   13f01:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
   13f08:	49 19 f1             	sbb    %rsi,%r9
   13f0b:	4c 89 ce             	mov    %r9,%rsi
   13f0e:	4c 89 da             	mov    %r11,%rdx
   13f11:	4d 85 db             	test   %r11,%r11
   13f14:	0f 88 f6 00 00 00    	js     14010 <__divti3+0x130>
   13f1a:	4d 89 d6             	mov    %r10,%r14
   13f1d:	75 31                	jne    13f50 <__divti3+0x70>
   13f1f:	4c 39 f6             	cmp    %r14,%rsi
   13f22:	0f 83 b8 00 00 00    	jae    13fe0 <__divti3+0x100>
   13f28:	48 89 f2             	mov    %rsi,%rdx
   13f2b:	31 f6                	xor    %esi,%esi
   13f2d:	4c 89 c0             	mov    %r8,%rax
   13f30:	49 f7 f6             	div    %r14
   13f33:	48 89 f2             	mov    %rsi,%rdx
   13f36:	48 85 ff             	test   %rdi,%rdi
   13f39:	74 0a                	je     13f45 <__divti3+0x65>
   13f3b:	48 f7 d8             	neg    %rax
   13f3e:	48 83 d2 00          	adc    $0x0,%rdx
   13f42:	48 f7 da             	neg    %rdx
   13f45:	5b                   	pop    %rbx
   13f46:	41 5e                	pop    %r14
   13f48:	5d                   	pop    %rbp
   13f49:	c3                   	ret
   13f4a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   13f50:	4c 39 de             	cmp    %r11,%rsi
   13f53:	0f 82 d5 00 00 00    	jb     1402e <__divti3+0x14e>
   13f59:	4d 0f bd d3          	bsr    %r11,%r10
   13f5d:	41 83 f2 3f          	xor    $0x3f,%r10d
   13f61:	44 89 d1             	mov    %r10d,%ecx
   13f64:	b8 40 00 00 00       	mov    $0x40,%eax
   13f69:	4c 89 f3             	mov    %r14,%rbx
   13f6c:	4d 89 f1             	mov    %r14,%r9
   13f6f:	48 d3 e2             	shl    %cl,%rdx
   13f72:	49 63 ca             	movslq %r10d,%rcx
   13f75:	49 89 f3             	mov    %rsi,%r11
   13f78:	48 29 c8             	sub    %rcx,%rax
   13f7b:	89 c1                	mov    %eax,%ecx
   13f7d:	48 d3 eb             	shr    %cl,%rbx
   13f80:	44 89 d1             	mov    %r10d,%ecx
   13f83:	49 d3 e1             	shl    %cl,%r9
   13f86:	89 c1                	mov    %eax,%ecx
   13f88:	48 09 d3             	or     %rdx,%rbx
   13f8b:	4c 89 c2             	mov    %r8,%rdx
   13f8e:	49 d3 eb             	shr    %cl,%r11
   13f91:	44 89 d1             	mov    %r10d,%ecx
   13f94:	48 d3 e6             	shl    %cl,%rsi
   13f97:	89 c1                	mov    %eax,%ecx
   13f99:	48 d3 ea             	shr    %cl,%rdx
   13f9c:	48 89 d0             	mov    %rdx,%rax
   13f9f:	4c 89 da             	mov    %r11,%rdx
   13fa2:	48 09 f0             	or     %rsi,%rax
   13fa5:	48 f7 f3             	div    %rbx
   13fa8:	49 89 d3             	mov    %rdx,%r11
   13fab:	48 89 c6             	mov    %rax,%rsi
   13fae:	49 f7 e1             	mul    %r9
   13fb1:	49 39 d3             	cmp    %rdx,%r11
   13fb4:	0f 82 be 00 00 00    	jb     14078 <__divti3+0x198>
   13fba:	44 89 d1             	mov    %r10d,%ecx
   13fbd:	49 d3 e0             	shl    %cl,%r8
   13fc0:	49 39 c0             	cmp    %rax,%r8
   13fc3:	73 09                	jae    13fce <__divti3+0xee>
   13fc5:	49 39 d3             	cmp    %rdx,%r11
   13fc8:	0f 84 aa 00 00 00    	je     14078 <__divti3+0x198>
   13fce:	48 89 f0             	mov    %rsi,%rax
   13fd1:	31 f6                	xor    %esi,%esi
   13fd3:	e9 5b ff ff ff       	jmp    13f33 <__divti3+0x53>
   13fd8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   13fdf:	00 
   13fe0:	4d 85 f6             	test   %r14,%r14
   13fe3:	75 0d                	jne    13ff2 <__divti3+0x112>
   13fe5:	b8 01 00 00 00       	mov    $0x1,%eax
   13fea:	31 d2                	xor    %edx,%edx
   13fec:	49 f7 f6             	div    %r14
   13fef:	49 89 c6             	mov    %rax,%r14
   13ff2:	48 89 f0             	mov    %rsi,%rax
   13ff5:	31 d2                	xor    %edx,%edx
   13ff7:	49 f7 f6             	div    %r14
   13ffa:	48 89 c6             	mov    %rax,%rsi
   13ffd:	4c 89 c0             	mov    %r8,%rax
   14000:	49 f7 f6             	div    %r14
   14003:	e9 2b ff ff ff       	jmp    13f33 <__divti3+0x53>
   14008:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   1400f:	00 
   14010:	49 f7 da             	neg    %r10
   14013:	48 f7 d7             	not    %rdi
   14016:	49 83 d3 00          	adc    $0x0,%r11
   1401a:	4d 89 d6             	mov    %r10,%r14
   1401d:	49 f7 db             	neg    %r11
   14020:	4c 89 da             	mov    %r11,%rdx
   14023:	0f 84 f6 fe ff ff    	je     13f1f <__divti3+0x3f>
   14029:	4c 39 de             	cmp    %r11,%rsi
   1402c:	73 12                	jae    14040 <__divti3+0x160>
   1402e:	31 f6                	xor    %esi,%esi
   14030:	31 c0                	xor    %eax,%eax
   14032:	e9 fc fe ff ff       	jmp    13f33 <__divti3+0x53>
   14037:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   1403e:	00 00 
   14040:	49 0f bd c3          	bsr    %r11,%rax
   14044:	48 83 f0 3f          	xor    $0x3f,%rax
   14048:	41 89 c2             	mov    %eax,%r10d
   1404b:	85 c0                	test   %eax,%eax
   1404d:	0f 85 0e ff ff ff    	jne    13f61 <__divti3+0x81>
   14053:	49 39 f3             	cmp    %rsi,%r11
   14056:	72 0d                	jb     14065 <__divti3+0x185>
   14058:	31 f6                	xor    %esi,%esi
   1405a:	31 c0                	xor    %eax,%eax
   1405c:	4d 39 f0             	cmp    %r14,%r8
   1405f:	0f 82 ce fe ff ff    	jb     13f33 <__divti3+0x53>
   14065:	31 f6                	xor    %esi,%esi
   14067:	b8 01 00 00 00       	mov    $0x1,%eax
   1406c:	e9 c2 fe ff ff       	jmp    13f33 <__divti3+0x53>
   14071:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   14078:	48 8d 46 ff          	lea    -0x1(%rsi),%rax
   1407c:	31 f6                	xor    %esi,%esi
   1407e:	e9 b0 fe ff ff       	jmp    13f33 <__divti3+0x53>
   14083:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   1408a:	00 00 00 
   1408d:	0f 1f 00             	nopl   (%rax)

0000000000014090 <atexit>:
   14090:	f3 0f 1e fa          	endbr64
   14094:	48 8b 15 dd 61 00 00 	mov    0x61dd(%rip),%rdx        # 1a278 <__dso_handle>
   1409b:	31 f6                	xor    %esi,%esi
   1409d:	e9 9e f3 fe ff       	jmp    3440 <__cxa_atexit@plt>

Disassembly of section .fini:

00000000000140a4 <_fini>:
   140a4:	f3 0f 1e fa          	endbr64
   140a8:	48 83 ec 08          	sub    $0x8,%rsp
   140ac:	48 83 c4 08          	add    $0x8,%rsp
   140b0:	c3                   	ret
