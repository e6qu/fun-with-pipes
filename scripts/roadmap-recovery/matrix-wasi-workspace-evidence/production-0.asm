
/tmp/fwp-array-fusion-allocation-3995/profile-0O2:     file format elf64-x86-64


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
    3654:	48 8d 3d 17 26 01 00 	lea    0x12617(%rip),%rdi        # 15c72 <exec_in_fp0+0x402>
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
    377d:	e8 ee 4b 00 00       	call   8370 <fwp_gc_init>
    3782:	48 89 2d 87 7b 01 00 	mov    %rbp,0x17b87(%rip)        # 1b310 <fwp_gc+0x1088>
    3789:	48 8d 3d d0 02 01 00 	lea    0x102d0(%rip),%rdi        # 13a60 <fwp_gc_find_data>
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
    37bf:	48 8d 3d 7a 03 01 00 	lea    0x1037a(%rip),%rdi        # 13b40 <fwp_gc_report>
    37c6:	e8 85 08 01 00       	call   14050 <atexit>
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
    382a:	48 89 0d a7 86 01 00 	mov    %rcx,0x186a7(%rip)        # 1bed8 <fwp_main_stack_top>
    3831:	48 89 05 a8 86 01 00 	mov    %rax,0x186a8(%rip)        # 1bee0 <fwp_main_stack_size>
    3838:	48 8d 05 b1 86 01 00 	lea    0x186b1(%rip),%rax        # 1bef0 <fwp_stack_guard_init.alt>
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
    38c4:	48 8d 05 05 78 00 00 	lea    0x7805(%rip),%rax        # b0d0 <fwp_segv>
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
    390e:	66 0f 7f 05 aa 85 01 	movdqa %xmm0,0x185aa(%rip)        # 1bec0 <fwp_cli_scripts>
    3915:	00 
    3916:	48 8b 05 73 63 01 00 	mov    0x16373(%rip),%rax        # 19c90 <exec_scripts+0x10>
    391d:	48 89 05 ac 85 01 00 	mov    %rax,0x185ac(%rip)        # 1bed0 <fwp_cli_scripts+0x10>
    3924:	4c 63 35 55 85 01 00 	movslq 0x18555(%rip),%r14        # 1be80 <fwp_argc>
    392b:	41 8d 46 ff          	lea    -0x1(%r14),%eax
    392f:	89 45 d0             	mov    %eax,-0x30(%rbp)
    3932:	4c 8b 2d 4f 85 01 00 	mov    0x1854f(%rip),%r13        # 1be88 <fwp_argv>
    3939:	49 83 fe 02          	cmp    $0x2,%r14
    393d:	7c 37                	jl     3976 <fwp_main_thread+0x216>
    393f:	49 8b 5d 08          	mov    0x8(%r13),%rbx
    3943:	48 8d 35 91 2c 01 00 	lea    0x12c91(%rip),%rsi        # 165db <exec_in_fp0+0xd6b>
    394a:	48 89 df             	mov    %rbx,%rdi
    394d:	e8 7e f9 ff ff       	call   32d0 <strcmp@plt>
    3952:	85 c0                	test   %eax,%eax
    3954:	0f 84 b0 00 00 00    	je     3a0a <fwp_main_thread+0x2aa>
    395a:	48 8d 35 80 2c 01 00 	lea    0x12c80(%rip),%rsi        # 165e1 <exec_in_fp0+0xd71>
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
    39ff:	e8 7c 48 00 00       	call   8280 <fwp_gc_alloc_slow>
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
    3a88:	e8 a3 76 00 00       	call   b130 <fwp_str_lossy>
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
    3b1f:	e8 5c 47 00 00       	call   8280 <fwp_gc_alloc_slow>
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
    3bc6:	e8 b5 46 00 00       	call   8280 <fwp_gc_alloc_slow>
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
    3c6f:	e8 0c 46 00 00       	call   8280 <fwp_gc_alloc_slow>
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
    3dcb:	48 8d 3d 99 2a 01 00 	lea    0x12a99(%rip),%rdi        # 1686b <exec_in_fp0+0xffb>
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
    3e65:	e8 16 44 00 00       	call   8280 <fwp_gc_alloc_slow>
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
    3ee9:	48 8d 35 b7 27 01 00 	lea    0x127b7(%rip),%rsi        # 166a7 <exec_in_fp0+0xe37>
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
    3f44:	e8 c7 97 00 00       	call   d710 <tp_value>
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
    3fc4:	48 8d 35 62 26 01 00 	lea    0x12662(%rip),%rsi        # 1662d <exec_in_fp0+0xdbd>
    3fcb:	48 89 df             	mov    %rbx,%rdi
    3fce:	e8 fd f2 ff ff       	call   32d0 <strcmp@plt>
    3fd3:	45 31 e4             	xor    %r12d,%r12d
    3fd6:	85 c0                	test   %eax,%eax
    3fd8:	0f 84 9e 00 00 00    	je     407c <fwp_main_thread+0x91c>
    3fde:	48 8d 35 4d 26 01 00 	lea    0x1264d(%rip),%rsi        # 16632 <exec_in_fp0+0xdc2>
    3fe5:	48 89 df             	mov    %rbx,%rdi
    3fe8:	e8 e3 f2 ff ff       	call   32d0 <strcmp@plt>
    3fed:	85 c0                	test   %eax,%eax
    3fef:	0f 84 98 0f 00 00    	je     4f8d <fwp_main_thread+0x182d>
    3ff5:	48 8d 35 3a 26 01 00 	lea    0x1263a(%rip),%rsi        # 16636 <exec_in_fp0+0xdc6>
    3ffc:	48 89 df             	mov    %rbx,%rdi
    3fff:	e8 cc f2 ff ff       	call   32d0 <strcmp@plt>
    4004:	b9 02 00 00 00       	mov    $0x2,%ecx
    4009:	85 c0                	test   %eax,%eax
    400b:	0f 84 81 0f 00 00    	je     4f92 <fwp_main_thread+0x1832>
    4011:	48 89 df             	mov    %rbx,%rdi
    4014:	e8 57 f1 ff ff       	call   3170 <strlen@plt>
    4019:	48 89 df             	mov    %rbx,%rdi
    401c:	48 89 c6             	mov    %rax,%rsi
    401f:	e8 0c 71 00 00       	call   b130 <fwp_str_lossy>
    4024:	48 8b 0d ad 5f 01 00 	mov    0x15fad(%rip),%rcx        # 19fd8 <stderr@GLIBC_2.2.5>
    402b:	48 8b 39             	mov    (%rcx),%rdi
    402e:	48 8d 48 08          	lea    0x8(%rax),%rcx
    4032:	48 8d 35 02 26 01 00 	lea    0x12602(%rip),%rsi        # 1663b <exec_in_fp0+0xdcb>
    4039:	48 8d 15 86 19 01 00 	lea    0x11986(%rip),%rdx        # 159c6 <exec_in_fp0+0x156>
    4040:	31 c0                	xor    %eax,%eax
    4042:	e8 a9 f2 ff ff       	call   32f0 <fprintf@plt>
    4047:	41 bc 02 00 00 00    	mov    $0x2,%r12d
    404d:	e9 a6 0f 00 00       	jmp    4ff8 <fwp_main_thread+0x1898>
    4052:	48 8b 05 7f 5f 01 00 	mov    0x15f7f(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    4059:	48 8b 38             	mov    (%rax),%rdi
    405c:	48 8d 35 99 26 01 00 	lea    0x12699(%rip),%rsi        # 166fc <exec_in_fp0+0xe8c>
    4063:	48 8d 15 a5 27 01 00 	lea    0x127a5(%rip),%rdx        # 1680f <exec_in_fp0+0xf9f>
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
    4149:	e8 82 90 00 00       	call   d1d0 <buf_put>
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
    420d:	e8 be 8f 00 00       	call   d1d0 <buf_put>
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
    42aa:	48 8d 3d 30 22 01 00 	lea    0x12230(%rip),%rdi        # 164e1 <exec_in_fp0+0xc71>
    42b1:	e8 7a ed ff ff       	call   3030 <getenv@plt>
    42b6:	48 85 c0             	test   %rax,%rax
    42b9:	74 27                	je     42e2 <fwp_main_thread+0xb82>
    42bb:	48 8d 35 27 22 01 00 	lea    0x12227(%rip),%rsi        # 164e9 <exec_in_fp0+0xc79>
    42c2:	48 89 c7             	mov    %rax,%rdi
    42c5:	e8 06 f0 ff ff       	call   32d0 <strcmp@plt>
    42ca:	31 c9                	xor    %ecx,%ecx
    42cc:	85 c0                	test   %eax,%eax
    42ce:	0f 94 c1             	sete   %cl
    42d1:	89 0d 19 7c 02 00    	mov    %ecx,0x27c19(%rip)        # 2bef0 <fwp_exec_binary_out>
    42d7:	75 29                	jne    4302 <fwp_main_thread+0xba2>
    42d9:	48 8b 05 f8 5c 01 00 	mov    0x15cf8(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    42e0:	eb 27                	jmp    4309 <fwp_main_thread+0xba9>
    42e2:	c7 05 04 7c 02 00 00 	movl   $0x0,0x27c04(%rip)        # 2bef0 <fwp_exec_binary_out>
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
    432e:	e8 ad 77 00 00       	call   bae0 <fwp_exec_call>
    4333:	48 89 c3             	mov    %rax,%rbx
    4336:	48 8b 3d 3b 7b 01 00 	mov    0x17b3b(%rip),%rdi        # 1be78 <fwp_prog_out>
    433d:	e8 0e f0 ff ff       	call   3350 <fflush@plt>
    4342:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    4348:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
    434c:	0f 85 69 09 00 00    	jne    4cbb <fwp_main_thread+0x155b>
    4352:	48 89 df             	mov    %rbx,%rdi
    4355:	e8 c6 79 00 00       	call   bd20 <fwp_emit_result>
    435a:	45 31 e4             	xor    %r12d,%r12d
    435d:	e9 59 09 00 00       	jmp    4cbb <fwp_main_thread+0x155b>
    4362:	48 8b 1d 4f 5c 01 00 	mov    0x15c4f(%rip),%rbx        # 19fb8 <stdin@GLIBC_2.2.5>
    4369:	48 8b 3b             	mov    (%rbx),%rdi
    436c:	b9 00 00 10 00       	mov    $0x100000,%ecx
    4371:	31 f6                	xor    %esi,%esi
    4373:	31 d2                	xor    %edx,%edx
    4375:	e8 36 f0 ff ff       	call   33b0 <setvbuf@plt>
    437a:	48 8b 0b             	mov    (%rbx),%rcx
    437d:	48 8d 3d 70 7b 02 00 	lea    0x27b70(%rip),%rdi        # 2bef4 <fwp_in_pend>
    4384:	be 01 00 00 00       	mov    $0x1,%esi
    4389:	ba 04 00 00 00       	mov    $0x4,%edx
    438e:	e8 5d ed ff ff       	call   30f0 <fread@plt>
    4393:	89 05 5f 7b 02 00    	mov    %eax,0x27b5f(%rip)        # 2bef8 <fwp_in_npend>
    4399:	c7 05 59 7b 02 00 00 	movl   $0x0,0x27b59(%rip)        # 2befc <fwp_in_ppos>
    43a0:	00 00 00 
    43a3:	b1 01                	mov    $0x1,%cl
    43a5:	89 4d c8             	mov    %ecx,-0x38(%rbp)
    43a8:	83 f8 04             	cmp    $0x4,%eax
    43ab:	4c 89 6d c0          	mov    %r13,-0x40(%rbp)
    43af:	75 10                	jne    43c1 <fwp_main_thread+0xc61>
    43b1:	81 3d 39 7b 02 00 46 	cmpl   $0x31505746,0x27b39(%rip)        # 2bef4 <fwp_in_pend>
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
    442f:	48 8d 3d ca 22 01 00 	lea    0x122ca(%rip),%rdi        # 16700 <exec_in_fp0+0xe90>
    4436:	e8 f5 eb ff ff       	call   3030 <getenv@plt>
    443b:	48 85 c0             	test   %rax,%rax
    443e:	74 17                	je     4457 <fwp_main_thread+0xcf7>
    4440:	48 8d 35 c7 22 01 00 	lea    0x122c7(%rip),%rsi        # 1670e <exec_in_fp0+0xe9e>
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
    44cd:	48 8d 15 40 22 01 00 	lea    0x12240(%rip),%rdx        # 16714 <exec_in_fp0+0xea4>
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
    451f:	e8 9c 70 00 00       	call   b5c0 <fwp_pipe_write>
    4524:	e8 f7 74 00 00       	call   ba20 <fwp_pipe_flush>
    4529:	48 8d 3d 0a 22 01 00 	lea    0x1220a(%rip),%rdi        # 1673a <exec_in_fp0+0xeca>
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
    45cb:	48 c7 05 5a 79 03 00 	movq   $0x0,0x3795a(%rip)        # 3bf30 <fwp_po_next_check>
    45d2:	00 00 00 00 
    45d6:	e8 a5 c4 00 00       	call   10a80 <fwp_pipe_poll>
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
    4607:	48 63 05 ee 78 02 00 	movslq 0x278ee(%rip),%rax        # 2befc <fwp_in_ppos>
    460e:	3b 05 e4 78 02 00    	cmp    0x278e4(%rip),%eax        # 2bef8 <fwp_in_npend>
    4614:	0f 8d d6 00 00 00    	jge    46f0 <fwp_main_thread+0xf90>
    461a:	8d 48 01             	lea    0x1(%rax),%ecx
    461d:	89 0d d9 78 02 00    	mov    %ecx,0x278d9(%rip)        # 2befc <fwp_in_ppos>
    4623:	48 8d 0d ca 78 02 00 	lea    0x278ca(%rip),%rcx        # 2bef4 <fwp_in_pend>
    462a:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax
    462e:	83 f8 0a             	cmp    $0xa,%eax
    4631:	0f 85 d1 00 00 00    	jne    4708 <fwp_main_thread+0xfa8>
    4637:	e9 84 01 00 00       	jmp    47c0 <fwp_main_thread+0x1060>
    463c:	0f 1f 40 00          	nopl   0x0(%rax)
    4640:	be 01 00 00 00       	mov    $0x1,%esi
    4645:	48 8d 7d a2          	lea    -0x5e(%rbp),%rdi
    4649:	e8 02 78 00 00       	call   be50 <fwp_read_exact>
    464e:	bb 0f 00 00 00       	mov    $0xf,%ebx
    4653:	85 c0                	test   %eax,%eax
    4655:	74 99                	je     45f0 <fwp_main_thread+0xe90>
    4657:	be 04 00 00 00       	mov    $0x4,%esi
    465c:	48 8d 7d a3          	lea    -0x5d(%rbp),%rdi
    4660:	e8 eb 77 00 00       	call   be50 <fwp_read_exact>
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
    472d:	e8 9e 8a 00 00       	call   d1d0 <buf_put>
    4732:	48 8b 1d 7f 58 01 00 	mov    0x1587f(%rip),%rbx        # 19fb8 <stdin@GLIBC_2.2.5>
    4739:	4c 8d 35 b4 77 02 00 	lea    0x277b4(%rip),%r14        # 2bef4 <fwp_in_pend>
    4740:	48 63 05 b5 77 02 00 	movslq 0x277b5(%rip),%rax        # 2befc <fwp_in_ppos>
    4747:	3b 05 ab 77 02 00    	cmp    0x277ab(%rip),%eax        # 2bef8 <fwp_in_npend>
    474d:	7d 21                	jge    4770 <fwp_main_thread+0x1010>
    474f:	8d 48 01             	lea    0x1(%rax),%ecx
    4752:	89 0d a4 77 02 00    	mov    %ecx,0x277a4(%rip)        # 2befc <fwp_in_ppos>
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
    4797:	e8 34 8a 00 00       	call   d1d0 <buf_put>
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
    47db:	48 8d 05 e4 19 01 00 	lea    0x119e4(%rip),%rax        # 161c6 <exec_in_fp0+0x956>
    47e2:	48 0f 44 f8          	cmove  %rax,%rdi
    47e6:	e8 45 69 00 00       	call   b130 <fwp_str_lossy>
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
    4828:	e8 e3 8e 00 00       	call   d710 <tp_value>
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
    48c4:	e8 b7 39 00 00       	call   8280 <fwp_gc_alloc_slow>
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
    48f9:	e8 52 75 00 00       	call   be50 <fwp_read_exact>
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
    4933:	83 3d 0a 76 03 00 00 	cmpl   $0x0,0x3760a(%rip)        # 3bf44 <fwp_pi_kind>
    493a:	0f 85 38 03 00 00    	jne    4c78 <fwp_main_thread+0x1518>
    4940:	41 0f b6 06          	movzbl (%r14),%eax
    4944:	83 f8 02             	cmp    $0x2,%eax
    4947:	0f 84 f7 00 00 00    	je     4a44 <fwp_main_thread+0x12e4>
    494d:	83 f8 01             	cmp    $0x1,%eax
    4950:	0f 85 22 03 00 00    	jne    4c78 <fwp_main_thread+0x1518>
    4956:	c7 05 e4 75 03 00 01 	movl   $0x1,0x375e4(%rip)        # 3bf44 <fwp_pi_kind>
    495d:	00 00 00 
    4960:	48 8d 3d 77 1e 01 00 	lea    0x11e77(%rip),%rdi        # 167de <exec_in_fp0+0xf6e>
    4967:	e8 c4 e6 ff ff       	call   3030 <getenv@plt>
    496c:	bb 10 00 00 00       	mov    $0x10,%ebx
    4971:	48 85 c0             	test   %rax,%rax
    4974:	0f 84 76 fc ff ff    	je     45f0 <fwp_main_thread+0xe90>
    497a:	80 38 00             	cmpb   $0x0,(%rax)
    497d:	0f 84 6d fc ff ff    	je     45f0 <fwp_main_thread+0xe90>
    4983:	48 89 c7             	mov    %rax,%rdi
    4986:	48 8d 35 24 1e 01 00 	lea    0x11e24(%rip),%rsi        # 167b1 <exec_in_fp0+0xf41>
    498d:	e8 3e e9 ff ff       	call   32d0 <strcmp@plt>
    4992:	85 c0                	test   %eax,%eax
    4994:	0f 84 56 fc ff ff    	je     45f0 <fwp_main_thread+0xe90>
    499a:	48 8b 05 37 56 01 00 	mov    0x15637(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    49a1:	48 8b 38             	mov    (%rax),%rdi
    49a4:	48 8d 35 48 1e 01 00 	lea    0x11e48(%rip),%rsi        # 167f3 <exec_in_fp0+0xf83>
    49ab:	48 8d 15 40 1b 01 00 	lea    0x11b40(%rip),%rdx        # 164f2 <exec_in_fp0+0xc82>
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
    49ec:	e8 5f 7b 00 00       	call   c550 <fwp_decode>
    49f1:	85 c0                	test   %eax,%eax
    49f3:	0f 84 9c 09 00 00    	je     5395 <fwp_main_thread+0x1c35>
    49f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    4a00:	48 8b 85 50 ff ff ff 	mov    -0xb0(%rbp),%rax
    4a07:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
    4a0b:	48 89 07             	mov    %rax,(%rdi)
    4a0e:	48 8d 75 bc          	lea    -0x44(%rbp),%rsi
    4a12:	e8 c9 70 00 00       	call   bae0 <fwp_exec_call>
    4a17:	48 89 c3             	mov    %rax,%rbx
    4a1a:	48 8b 3d 57 74 01 00 	mov    0x17457(%rip),%rdi        # 1be78 <fwp_prog_out>
    4a21:	e8 2a e9 ff ff       	call   3350 <fflush@plt>
    4a26:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
    4a2a:	0f 85 75 02 00 00    	jne    4ca5 <fwp_main_thread+0x1545>
    4a30:	48 89 df             	mov    %rbx,%rdi
    4a33:	e8 e8 72 00 00       	call   bd20 <fwp_emit_result>
    4a38:	e8 e3 6f 00 00       	call   ba20 <fwp_pipe_flush>
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
    4bf3:	4c 89 3d 4e 73 03 00 	mov    %r15,0x3734e(%rip)        # 3bf48 <fwp_pi_ring>
    4bfa:	c7 05 40 73 03 00 02 	movl   $0x2,0x37340(%rip)        # 3bf44 <fwp_pi_kind>
    4c01:	00 00 00 
    4c04:	48 8d 3d d3 1b 01 00 	lea    0x11bd3(%rip),%rdi        # 167de <exec_in_fp0+0xf6e>
    4c0b:	e8 20 e4 ff ff       	call   3030 <getenv@plt>
    4c10:	48 85 c0             	test   %rax,%rax
    4c13:	0f 84 c7 f9 ff ff    	je     45e0 <fwp_main_thread+0xe80>
    4c19:	80 38 00             	cmpb   $0x0,(%rax)
    4c1c:	0f 84 be f9 ff ff    	je     45e0 <fwp_main_thread+0xe80>
    4c22:	48 89 c7             	mov    %rax,%rdi
    4c25:	48 8d 35 85 1b 01 00 	lea    0x11b85(%rip),%rsi        # 167b1 <exec_in_fp0+0xf41>
    4c2c:	e8 9f e6 ff ff       	call   32d0 <strcmp@plt>
    4c31:	85 c0                	test   %eax,%eax
    4c33:	0f 84 a7 f9 ff ff    	je     45e0 <fwp_main_thread+0xe80>
    4c39:	48 8b 05 98 53 01 00 	mov    0x15398(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    4c40:	48 8b 38             	mov    (%rax),%rdi
    4c43:	48 8d 35 a9 1b 01 00 	lea    0x11ba9(%rip),%rsi        # 167f3 <exec_in_fp0+0xf83>
    4c4a:	48 8d 15 86 1b 01 00 	lea    0x11b86(%rip),%rdx        # 167d7 <exec_in_fp0+0xf67>
    4c51:	31 c0                	xor    %eax,%eax
    4c53:	e8 98 e6 ff ff       	call   32f0 <fprintf@plt>
    4c58:	e9 83 f9 ff ff       	jmp    45e0 <fwp_main_thread+0xe80>
    4c5d:	48 8b 05 74 53 01 00 	mov    0x15374(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    4c64:	48 8b 38             	mov    (%rax),%rdi
    4c67:	48 8d 35 e2 18 01 00 	lea    0x118e2(%rip),%rsi        # 16550 <exec_in_fp0+0xce0>
    4c6e:	eb 19                	jmp    4c89 <fwp_main_thread+0x1529>
    4c70:	44 89 f7             	mov    %r14d,%edi
    4c73:	e8 b8 e5 ff ff       	call   3230 <close@plt>
    4c78:	48 8b 05 59 53 01 00 	mov    0x15359(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    4c7f:	48 8b 38             	mov    (%rax),%rdi
    4c82:	48 8d 35 dc 18 01 00 	lea    0x118dc(%rip),%rsi        # 16565 <exec_in_fp0+0xcf5>
    4c89:	48 8d 15 36 0d 01 00 	lea    0x10d36(%rip),%rdx        # 159c6 <exec_in_fp0+0x156>
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
    4cbb:	83 3d 2e 72 02 00 00 	cmpl   $0x0,0x2722e(%rip)        # 2bef0 <fwp_exec_binary_out>
    4cc2:	0f 84 21 03 00 00    	je     4fe9 <fwp_main_thread+0x1889>
    4cc8:	48 8d 3d 6c 0b 01 00 	lea    0x10b6c(%rip),%rdi        # 1583b <fwp_exec.end>
    4ccf:	be 05 00 00 00       	mov    $0x5,%esi
    4cd4:	e8 e7 68 00 00       	call   b5c0 <fwp_pipe_write>
    4cd9:	8b 05 31 72 02 00    	mov    0x27231(%rip),%eax        # 2bf10 <fwp_po_kind>
    4cdf:	83 f8 02             	cmp    $0x2,%eax
    4ce2:	0f 84 83 00 00 00    	je     4d6b <fwp_main_thread+0x160b>
    4ce8:	83 f8 01             	cmp    $0x1,%eax
    4ceb:	0f 85 d2 00 00 00    	jne    4dc3 <fwp_main_thread+0x1663>
    4cf1:	48 8b 1d 20 72 02 00 	mov    0x27220(%rip),%rbx        # 2bf18 <fwp_po_len>
    4cf8:	48 85 db             	test   %rbx,%rbx
    4cfb:	0f 84 b4 02 00 00    	je     4fb5 <fwp_main_thread+0x1855>
    4d01:	80 3d 20 72 03 00 00 	cmpb   $0x0,0x37220(%rip)        # 3bf28 <fwp_po_gone>
    4d08:	0f 85 a7 02 00 00    	jne    4fb5 <fwp_main_thread+0x1855>
    4d0e:	44 8b 35 cf 70 01 00 	mov    0x170cf(%rip),%r14d        # 1bde4 <fwp_po_sock>
    4d15:	4c 8d 3d 04 72 02 00 	lea    0x27204(%rip),%r15        # 2bf20 <fwp_po_buf>
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
    4d5d:	f6 05 c4 71 03 00 01 	testb  $0x1,0x371c4(%rip)        # 3bf28 <fwp_po_gone>
    4d64:	74 ba                	je     4d20 <fwp_main_thread+0x15c0>
    4d66:	e9 4a 02 00 00       	jmp    4fb5 <fwp_main_thread+0x1855>
    4d6b:	48 8b 35 ae 71 03 00 	mov    0x371ae(%rip),%rsi        # 3bf20 <fwp_po_ring>
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
    4dd7:	c7 05 1b 71 02 00 04 	movl   $0x4,0x2711b(%rip)        # 2befc <fwp_in_ppos>
    4dde:	00 00 00 
    4de1:	48 8d 7d 80          	lea    -0x80(%rbp),%rdi
    4de5:	be 01 00 00 00       	mov    $0x1,%esi
    4dea:	e8 61 70 00 00       	call   be50 <fwp_read_exact>
    4def:	85 c0                	test   %eax,%eax
    4df1:	0f 84 16 05 00 00    	je     530d <fwp_main_thread+0x1bad>
    4df7:	49 c7 c6 f9 ff ff ff 	mov    $0xfffffffffffffff9,%r14
    4dfe:	45 31 ff             	xor    %r15d,%r15d
    4e01:	48 8d 9d d0 fd ff ff 	lea    -0x230(%rbp),%rbx
    4e08:	45 31 e4             	xor    %r12d,%r12d
    4e0b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    4e10:	be 01 00 00 00       	mov    $0x1,%esi
    4e15:	48 89 df             	mov    %rbx,%rdi
    4e18:	e8 33 70 00 00       	call   be50 <fwp_read_exact>
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
    4e9b:	e8 b0 6f 00 00       	call   be50 <fwp_read_exact>
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
    4ef8:	e8 53 6f 00 00       	call   be50 <fwp_read_exact>
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
    4f76:	e8 d5 6e 00 00       	call   be50 <fwp_read_exact>
    4f7b:	85 c0                	test   %eax,%eax
    4f7d:	0f 84 8a 03 00 00    	je     530d <fwp_main_thread+0x1bad>
    4f83:	49 29 dc             	sub    %rbx,%r12
    4f86:	75 d8                	jne    4f60 <fwp_main_thread+0x1800>
    4f88:	e9 45 ff ff ff       	jmp    4ed2 <fwp_main_thread+0x1772>
    4f8d:	b9 01 00 00 00       	mov    $0x1,%ecx
    4f92:	48 8d 05 27 6f 01 00 	lea    0x16f27(%rip),%rax        # 1bec0 <fwp_cli_scripts>
    4f99:	48 8b 3c c8          	mov    (%rax,%rcx,8),%rdi
    4f9d:	48 8b 05 0c 50 01 00 	mov    0x1500c(%rip),%rax        # 19fb0 <stdout@GLIBC_2.2.5>
    4fa4:	48 8b 30             	mov    (%rax),%rsi
    4fa7:	e8 44 e2 ff ff       	call   31f0 <fputs@plt>
    4fac:	eb 4a                	jmp    4ff8 <fwp_main_thread+0x1898>
    4fae:	c6 05 73 6f 03 00 01 	movb   $0x1,0x36f73(%rip)        # 3bf28 <fwp_po_gone>
    4fb5:	48 c7 05 58 6f 02 00 	movq   $0x0,0x26f58(%rip)        # 2bf18 <fwp_po_len>
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
    5026:	48 8d 3d 60 16 01 00 	lea    0x11660(%rip),%rdi        # 1668d <exec_in_fp0+0xe1d>
    502d:	48 8d 0d ba 18 01 00 	lea    0x118ba(%rip),%rcx        # 168ee <exec_in_fp0+0x107e>
    5034:	4c 89 e2             	mov    %r12,%rdx
    5037:	31 c0                	xor    %eax,%eax
    5039:	e8 82 83 00 00       	call   d3c0 <fwp_strf>
    503e:	48 8b 0d 93 4f 01 00 	mov    0x14f93(%rip),%rcx        # 19fd8 <stderr@GLIBC_2.2.5>
    5045:	48 8b 39             	mov    (%rcx),%rdi
    5048:	48 83 c0 08          	add    $0x8,%rax
    504c:	48 8d 35 98 16 01 00 	lea    0x11698(%rip),%rsi        # 166eb <exec_in_fp0+0xe7b>
    5053:	48 8d 15 6c 09 01 00 	lea    0x1096c(%rip),%rdx        # 159c6 <exec_in_fp0+0x156>
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
    508f:	e8 bc 6d 00 00       	call   be50 <fwp_read_exact>
    5094:	85 c0                	test   %eax,%eax
    5096:	0f 84 71 02 00 00    	je     530d <fwp_main_thread+0x1bad>
    509c:	48 8d bd 60 ff ff ff 	lea    -0xa0(%rbp),%rdi
    50a3:	e8 b8 72 00 00       	call   c360 <fwp_stdin_name_len>
    50a8:	83 f8 01             	cmp    $0x1,%eax
    50ab:	0f 85 50 02 00 00    	jne    5301 <fwp_main_thread+0x1ba1>
    50b1:	4c 8b b5 60 ff ff ff 	mov    -0xa0(%rbp),%r14
    50b8:	49 8d 7e 01          	lea    0x1(%r14),%rdi
    50bc:	e8 4f 64 00 00       	call   b510 <fwp_alloc_leaf>
    50c1:	48 89 c3             	mov    %rax,%rbx
    50c4:	4d 85 f6             	test   %r14,%r14
    50c7:	74 13                	je     50dc <fwp_main_thread+0x197c>
    50c9:	48 89 df             	mov    %rbx,%rdi
    50cc:	4c 89 f6             	mov    %r14,%rsi
    50cf:	e8 7c 6d 00 00       	call   be50 <fwp_read_exact>
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
    5113:	e8 d8 72 00 00       	call   c3f0 <fwp_pipe_in_offer>
    5118:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%rbp)
    511f:	e9 9d f2 ff ff       	jmp    43c1 <fwp_main_thread+0xc61>
    5124:	45 31 ff             	xor    %r15d,%r15d
    5127:	45 85 ff             	test   %r15d,%r15d
    512a:	0f 89 dd 01 00 00    	jns    530d <fwp_main_thread+0x1bad>
    5130:	48 8b 05 a1 4e 01 00 	mov    0x14ea1(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    5137:	48 8b 38             	mov    (%rax),%rdi
    513a:	48 8d 35 74 14 01 00 	lea    0x11474(%rip),%rsi        # 165b5 <exec_in_fp0+0xd45>
    5141:	e9 d8 01 00 00       	jmp    531e <fwp_main_thread+0x1bbe>
    5146:	48 8b 05 8b 4e 01 00 	mov    0x14e8b(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    514d:	48 8b 38             	mov    (%rax),%rdi
    5150:	41 8b 0f             	mov    (%r15),%ecx
    5153:	48 8d 35 36 14 01 00 	lea    0x11436(%rip),%rsi        # 16590 <exec_in_fp0+0xd20>
    515a:	48 8d 15 65 08 01 00 	lea    0x10865(%rip),%rdx        # 159c6 <exec_in_fp0+0x156>
    5161:	4c 8d 0d 86 17 01 00 	lea    0x11786(%rip),%r9        # 168ee <exec_in_fp0+0x107e>
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
    51d0:	48 8d 35 d5 14 01 00 	lea    0x114d5(%rip),%rsi        # 166ac <exec_in_fp0+0xe3c>
    51d7:	e8 f4 7f 00 00       	call   d1d0 <buf_put>
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
    520f:	e8 bc 7f 00 00       	call   d1d0 <buf_put>
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
    5259:	e8 72 7f 00 00       	call   d1d0 <buf_put>
    525e:	41 80 cd 20          	or     $0x20,%r13b
    5262:	44 88 6d 80          	mov    %r13b,-0x80(%rbp)
    5266:	ba 01 00 00 00       	mov    $0x1,%edx
    526b:	48 89 df             	mov    %rbx,%rdi
    526e:	4c 89 e6             	mov    %r12,%rsi
    5271:	e8 5a 7f 00 00       	call   d1d0 <buf_put>
    5276:	31 c0                	xor    %eax,%eax
    5278:	eb b3                	jmp    522d <fwp_main_thread+0x1acd>
    527a:	48 8d bd d0 fd ff ff 	lea    -0x230(%rbp),%rdi
    5281:	e8 3a 80 00 00       	call   d2c0 <buf_to_str>
    5286:	48 8d 48 08          	lea    0x8(%rax),%rcx
    528a:	48 8d 3d e4 13 01 00 	lea    0x113e4(%rip),%rdi        # 16675 <exec_in_fp0+0xe05>
    5291:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    5295:	48 8b 95 d8 fe ff ff 	mov    -0x128(%rbp),%rdx
    529c:	e9 96 fd ff ff       	jmp    5037 <fwp_main_thread+0x18d7>
    52a1:	48 8b 05 30 4d 01 00 	mov    0x14d30(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    52a8:	48 8b 38             	mov    (%rax),%rdi
    52ab:	48 8d 35 3d 13 01 00 	lea    0x1133d(%rip),%rsi        # 165ef <exec_in_fp0+0xd7f>
    52b2:	48 8d 15 0d 07 01 00 	lea    0x1070d(%rip),%rdx        # 159c6 <exec_in_fp0+0x156>
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
    52f5:	48 89 0d 0c 6c 02 00 	mov    %rcx,0x26c0c(%rip)        # 2bf08 <fwp_po_give_up>
    52fc:	e9 12 f2 ff ff       	jmp    4513 <fwp_main_thread+0xdb3>
    5301:	41 89 c7             	mov    %eax,%r15d
    5304:	45 85 ff             	test   %r15d,%r15d
    5307:	0f 88 23 fe ff ff    	js     5130 <fwp_main_thread+0x19d0>
    530d:	48 8b 05 c4 4c 01 00 	mov    0x14cc4(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    5314:	48 8b 38             	mov    (%rax),%rdi
    5317:	48 8d 35 a7 12 01 00 	lea    0x112a7(%rip),%rsi        # 165c5 <exec_in_fp0+0xd55>
    531e:	48 8d 15 a1 06 01 00 	lea    0x106a1(%rip),%rdx        # 159c6 <exec_in_fp0+0x156>
    5325:	31 c0                	xor    %eax,%eax
    5327:	e8 c4 df ff ff       	call   32f0 <fprintf@plt>
    532c:	41 bc 03 00 00 00    	mov    $0x3,%r12d
    5332:	e9 c1 fc ff ff       	jmp    4ff8 <fwp_main_thread+0x1898>
    5337:	48 8b 05 9a 4c 01 00 	mov    0x14c9a(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    533e:	48 8b 38             	mov    (%rax),%rdi
    5341:	48 8d 35 b1 11 01 00 	lea    0x111b1(%rip),%rsi        # 164f9 <exec_in_fp0+0xc89>
    5348:	48 8d 15 77 06 01 00 	lea    0x10677(%rip),%rdx        # 159c6 <exec_in_fp0+0x156>
    534f:	31 c0                	xor    %eax,%eax
    5351:	e8 9a df ff ff       	call   32f0 <fprintf@plt>
    5356:	41 bc 03 00 00 00    	mov    $0x3,%r12d
    535c:	e9 97 fc ff ff       	jmp    4ff8 <fwp_main_thread+0x1898>
    5361:	48 8b 05 70 4c 01 00 	mov    0x14c70(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    5368:	48 8b 38             	mov    (%rax),%rdi
    536b:	48 8d 35 ac 11 01 00 	lea    0x111ac(%rip),%rsi        # 1651e <exec_in_fp0+0xcae>
    5372:	48 8d 15 4d 06 01 00 	lea    0x1064d(%rip),%rdx        # 159c6 <exec_in_fp0+0x156>
    5379:	48 8d 0d 6e 15 01 00 	lea    0x1156e(%rip),%rcx        # 168ee <exec_in_fp0+0x107e>
    5380:	49 89 d8             	mov    %rbx,%r8
    5383:	31 c0                	xor    %eax,%eax
    5385:	e8 66 df ff ff       	call   32f0 <fprintf@plt>
    538a:	41 bc 03 00 00 00    	mov    $0x3,%r12d
    5390:	e9 63 fc ff ff       	jmp    4ff8 <fwp_main_thread+0x1898>
    5395:	48 8b 05 3c 4c 01 00 	mov    0x14c3c(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    539c:	48 8b 38             	mov    (%rax),%rdi
    539f:	48 8d 35 d5 11 01 00 	lea    0x111d5(%rip),%rsi        # 1657b <exec_in_fp0+0xd0b>
    53a6:	48 8d 15 19 06 01 00 	lea    0x10619(%rip),%rdx        # 159c6 <exec_in_fp0+0x156>
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
    53cd:	48 83 ec 78          	sub    $0x78,%rsp
    53d1:	83 3d 9c 5e 01 00 00 	cmpl   $0x0,0x15e9c(%rip)        # 1b274 <fwp_gc+0xfec>
    53d8:	75 05                	jne    53df <main+0x1f>
    53da:	e8 91 2f 00 00       	call   8370 <fwp_gc_init>
    53df:	48 89 2d 2a 5f 01 00 	mov    %rbp,0x15f2a(%rip)        # 1b310 <fwp_gc+0x1088>
    53e6:	48 8d 3d 73 e6 00 00 	lea    0xe673(%rip),%rdi        # 13a60 <fwp_gc_find_data>
    53ed:	31 f6                	xor    %esi,%esi
    53ef:	e8 4c dc ff ff       	call   3040 <dl_iterate_phdr@plt>
    53f4:	83 3d 7d 5e 01 00 00 	cmpl   $0x0,0x15e7d(%rip)        # 1b278 <fwp_gc+0xff0>
    53fb:	0f 95 c1             	setne  %cl
    53fe:	83 3d 13 60 01 00 00 	cmpl   $0x0,0x16013(%rip)        # 1b418 <fwp_gc+0x1190>
    5405:	0f 9f c0             	setg   %al
    5408:	20 c8                	and    %cl,%al
    540a:	0f b6 c8             	movzbl %al,%ecx
    540d:	89 0d 69 5e 01 00    	mov    %ecx,0x15e69(%rip)        # 1b27c <fwp_gc+0xff4>
    5413:	83 3d 6a 5e 01 00 00 	cmpl   $0x0,0x15e6a(%rip)        # 1b284 <fwp_gc+0xffc>
    541a:	74 16                	je     5432 <main+0x72>
    541c:	48 8d 3d 1d e7 00 00 	lea    0xe71d(%rip),%rdi        # 13b40 <fwp_gc_report>
    5423:	e8 28 ec 00 00       	call   14050 <atexit>
    5428:	83 3d 4d 5e 01 00 00 	cmpl   $0x0,0x15e4d(%rip)        # 1b27c <fwp_gc+0xff4>
    542f:	0f 95 c0             	setne  %al
    5432:	84 c0                	test   %al,%al
    5434:	74 43                	je     5479 <main+0xb9>
    5436:	48 83 3d 6a 5e 01 00 	cmpq   $0x0,0x15e6a(%rip)        # 1b2a8 <fwp_gc+0x1020>
    543d:	00 
    543e:	74 39                	je     5479 <main+0xb9>
    5440:	48 8b 05 51 60 01 00 	mov    0x16051(%rip),%rax        # 1b498 <fwp_gc+0x1210>
    5447:	48 2b 05 3a 4e 01 00 	sub    0x14e3a(%rip),%rax        # 1a288 <fwp_gc>
    544e:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    5453:	f2 0f 58 05 15 60 01 	addsd  0x16015(%rip),%xmm0        # 1b470 <fwp_gc+0x11e8>
    545a:	00 
    545b:	f2 0f 11 05 0d 60 01 	movsd  %xmm0,0x1600d(%rip)        # 1b470 <fwp_gc+0x11e8>
    5462:	00 
    5463:	48 c7 05 2a 60 01 00 	movq   $0x0,0x1602a(%rip)        # 1b498 <fwp_gc+0x1210>
    546a:	00 00 00 00 
    546e:	48 c7 05 0f 4e 01 00 	movq   $0x0,0x14e0f(%rip)        # 1a288 <fwp_gc>
    5475:	00 00 00 00 
    5479:	48 8d 05 00 44 01 00 	lea    0x14400(%rip),%rax        # 19880 <fwp_fn_table>
    5480:	48 89 05 e9 69 01 00 	mov    %rax,0x169e9(%rip)        # 1be70 <fwp_fns>
    5487:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    548b:	66 0f 29 85 60 ff ff 	movapd %xmm0,-0xa0(%rbp)
    5492:	ff 
    5493:	66 0f 29 45 b0       	movapd %xmm0,-0x50(%rbp)
    5498:	66 0f 29 45 a0       	movapd %xmm0,-0x60(%rbp)
    549d:	66 0f 29 45 90       	movapd %xmm0,-0x70(%rbp)
    54a2:	66 0f 29 45 80       	movapd %xmm0,-0x80(%rbp)
    54a7:	66 0f 29 85 70 ff ff 	movapd %xmm0,-0x90(%rbp)
    54ae:	ff 
    54af:	c7 85 60 ff ff ff 0b 	movl   $0xb,-0xa0(%rbp)
    54b6:	00 00 00 
    54b9:	48 8d 3d 88 04 01 00 	lea    0x10488(%rip),%rdi        # 15948 <exec_in_fp0+0xd8>
    54c0:	e8 0b dc ff ff       	call   30d0 <puts@plt>
    54c5:	45 31 f6             	xor    %r14d,%r14d
    54c8:	48 bb c5 4e ec c4 4e 	movabs $0x4ec4ec4ec4ec4ec5,%rbx
    54cf:	ec c4 4e 
    54d2:	49 bd 00 00 00 00 00 	movabs $0x8000000000000000,%r13
    54d9:	00 00 80 
    54dc:	0f 1f 40 00          	nopl   0x0(%rax)
    54e0:	49 83 fe 03          	cmp    $0x3,%r14
    54e4:	73 1a                	jae    5500 <main+0x140>
    54e6:	48 8d 05 93 03 01 00 	lea    0x10393(%rip),%rax        # 15880 <exec_in_fp0+0x10>
    54ed:	4e 8b 3c f0          	mov    (%rax,%r14,8),%r15
    54f1:	eb 1c                	jmp    550f <main+0x14f>
    54f3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    54fa:	84 00 00 00 00 00 
    5500:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    5506:	b8 07 00 00 00       	mov    $0x7,%eax
    550b:	4c 0f 44 f8          	cmove  %rax,%r15
    550f:	4c 89 ff             	mov    %r15,%rdi
    5512:	48 8d b5 60 ff ff ff 	lea    -0xa0(%rbp),%rsi
    5519:	e8 e2 02 00 00       	call   5800 <fwp_array_new_packed>
    551e:	49 89 c4             	mov    %rax,%r12
    5521:	48 2b 05 90 5d 01 00 	sub    0x15d90(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    5528:	48 8b 0d b1 5d 01 00 	mov    0x15db1(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    552f:	48 c1 e1 10          	shl    $0x10,%rcx
    5533:	48 39 c8             	cmp    %rcx,%rax
    5536:	f2 0f 10 0d 5a fc 00 	movsd  0xfc5a(%rip),%xmm1        # 15198 <_IO_stdin_used+0x198>
    553d:	00 
    553e:	f2 0f 10 15 5a fc 00 	movsd  0xfc5a(%rip),%xmm2        # 151a0 <_IO_stdin_used+0x1a0>
    5545:	00 
    5546:	f2 0f 10 1d 5a fc 00 	movsd  0xfc5a(%rip),%xmm3        # 151a8 <_IO_stdin_used+0x1a8>
    554d:	00 
    554e:	0f 83 8c 00 00 00    	jae    55e0 <main+0x220>
    5554:	48 8b 0d a5 5d 01 00 	mov    0x15da5(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    555b:	48 89 c2             	mov    %rax,%rdx
    555e:	48 c1 ea 10          	shr    $0x10,%rdx
    5562:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5569:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    556d:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5573:	75 1b                	jne    5590 <main+0x1d0>
    5575:	40 80 fe 02          	cmp    $0x2,%sil
    5579:	75 15                	jne    5590 <main+0x1d0>
    557b:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    557f:	48 05 28 02 00 00    	add    $0x228,%rax
    5585:	80 38 ff             	cmpb   $0xff,(%rax)
    5588:	74 2a                	je     55b4 <main+0x1f4>
    558a:	c6 00 01             	movb   $0x1,(%rax)
    558d:	eb 51                	jmp    55e0 <main+0x220>
    558f:	90                   	nop
    5590:	40 80 fe 01          	cmp    $0x1,%sil
    5594:	75 4a                	jne    55e0 <main+0x220>
    5596:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    559a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    559e:	48 0f af c1          	imul   %rcx,%rax
    55a2:	48 c1 e8 20          	shr    $0x20,%rax
    55a6:	48 01 f0             	add    %rsi,%rax
    55a9:	48 05 28 02 00 00    	add    $0x228,%rax
    55af:	80 38 ff             	cmpb   $0xff,(%rax)
    55b2:	75 d6                	jne    558a <main+0x1ca>
    55b4:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    55b8:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    55bc:	e8 4f 15 00 00       	call   6b10 <fwp_rc_forget_slot>
    55c1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    55c5:	f2 0f 10 1d db fb 00 	movsd  0xfbdb(%rip),%xmm3        # 151a8 <_IO_stdin_used+0x1a8>
    55cc:	00 
    55cd:	f2 0f 10 15 cb fb 00 	movsd  0xfbcb(%rip),%xmm2        # 151a0 <_IO_stdin_used+0x1a0>
    55d4:	00 
    55d5:	f2 0f 10 0d bb fb 00 	movsd  0xfbbb(%rip),%xmm1        # 15198 <_IO_stdin_used+0x198>
    55dc:	00 
    55dd:	eb ab                	jmp    558a <main+0x1ca>
    55df:	90                   	nop
    55e0:	f2 0f 10 25 a8 fb 00 	movsd  0xfba8(%rip),%xmm4        # 15190 <_IO_stdin_used+0x190>
    55e7:	00 
    55e8:	4d 85 ff             	test   %r15,%r15
    55eb:	bf 84 04 00 00       	mov    $0x484,%edi
    55f0:	41 b8 21 00 00 00    	mov    $0x21,%r8d
    55f6:	41 b9 42 00 00 00    	mov    $0x42,%r9d
    55fc:	0f 84 de 00 00 00    	je     56e0 <main+0x320>
    5602:	48 8d 35 67 00 01 00 	lea    0x10067(%rip),%rsi        # 15670 <main.edge>
    5609:	f2 0f 10 25 7f fb 00 	movsd  0xfb7f(%rip),%xmm4        # 15190 <_IO_stdin_used+0x190>
    5610:	00 
    5611:	31 c9                	xor    %ecx,%ecx
    5613:	eb 2c                	jmp    5641 <main+0x281>
    5615:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    561c:	00 00 00 00 
    5620:	41 89 44 8c 08       	mov    %eax,0x8(%r12,%rcx,4)
    5625:	f2 0f 59 c2          	mulsd  %xmm2,%xmm0
    5629:	f2 0f 58 c3          	addsd  %xmm3,%xmm0
    562d:	f2 0f 58 e0          	addsd  %xmm0,%xmm4
    5631:	48 ff c1             	inc    %rcx
    5634:	48 83 c6 08          	add    $0x8,%rsi
    5638:	49 39 cf             	cmp    %rcx,%r15
    563b:	0f 84 9f 00 00 00    	je     56e0 <main+0x320>
    5641:	48 89 c8             	mov    %rcx,%rax
    5644:	48 f7 e3             	mul    %rbx
    5647:	48 c1 ea 02          	shr    $0x2,%rdx
    564b:	8d 04 52             	lea    (%rdx,%rdx,2),%eax
    564e:	8d 04 82             	lea    (%rdx,%rax,4),%eax
    5651:	89 ca                	mov    %ecx,%edx
    5653:	29 c2                	sub    %eax,%edx
    5655:	83 c2 fa             	add    $0xfffffffa,%edx
    5658:	0f 57 c0             	xorps  %xmm0,%xmm0
    565b:	f2 0f 2a c2          	cvtsi2sd %edx,%xmm0
    565f:	f2 0f 59 c1          	mulsd  %xmm1,%xmm0
    5663:	4c 89 e8             	mov    %r13,%rax
    5666:	49 83 fe 04          	cmp    $0x4,%r14
    566a:	74 19                	je     5685 <main+0x2c5>
    566c:	49 83 fe 03          	cmp    $0x3,%r14
    5670:	75 0e                	jne    5680 <main+0x2c0>
    5672:	48 8b 06             	mov    (%rsi),%rax
    5675:	eb 0e                	jmp    5685 <main+0x2c5>
    5677:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    567e:	00 00 
    5680:	66 48 0f 7e c0       	movq   %xmm0,%rax
    5685:	49 83 3c 24 00       	cmpq   $0x0,(%r12)
    568a:	0f 88 39 01 00 00    	js     57c9 <main+0x409>
    5690:	8b 95 60 ff ff ff    	mov    -0xa0(%rbp),%edx
    5696:	83 fa 0a             	cmp    $0xa,%edx
    5699:	77 2f                	ja     56ca <main+0x30a>
    569b:	0f a3 d7             	bt     %edx,%edi
    569e:	72 80                	jb     5620 <main+0x260>
    56a0:	41 0f a3 d0          	bt     %edx,%r8d
    56a4:	72 1a                	jb     56c0 <main+0x300>
    56a6:	41 0f a3 d1          	bt     %edx,%r9d
    56aa:	73 1e                	jae    56ca <main+0x30a>
    56ac:	66 41 89 44 4c 08    	mov    %ax,0x8(%r12,%rcx,2)
    56b2:	e9 6e ff ff ff       	jmp    5625 <main+0x265>
    56b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    56be:	00 00 
    56c0:	41 88 44 0c 08       	mov    %al,0x8(%r12,%rcx,1)
    56c5:	e9 5b ff ff ff       	jmp    5625 <main+0x265>
    56ca:	49 89 44 cc 08       	mov    %rax,0x8(%r12,%rcx,8)
    56cf:	e9 51 ff ff ff       	jmp    5625 <main+0x265>
    56d4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    56db:	00 00 00 00 00 
    56e0:	f2 0f 11 65 c8       	movsd  %xmm4,-0x38(%rbp)
    56e5:	48 8b 1d bc 67 01 00 	mov    0x167bc(%rip),%rbx        # 1bea8 <measured_calls>
    56ec:	48 8b 05 bd 67 01 00 	mov    0x167bd(%rip),%rax        # 1beb0 <measured_bytes>
    56f3:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    56f7:	f3 0f 7e 05 91 5d 01 	movq   0x15d91(%rip),%xmm0        # 1b490 <fwp_gc+0x1208>
    56fe:	00 
    56ff:	66 0f d6 45 d0       	movq   %xmm0,-0x30(%rbp)
    5704:	4c 89 e7             	mov    %r12,%rdi
    5707:	e8 f4 02 00 00       	call   5a00 <f0>
    570c:	49 83 fe 02          	cmp    $0x2,%r14
    5710:	77 13                	ja     5725 <main+0x365>
    5712:	f3 0f 7e 45 c8       	movq   -0x38(%rbp),%xmm0
    5717:	66 48 0f 7e c1       	movq   %xmm0,%rcx
    571c:	48 39 c8             	cmp    %rcx,%rax
    571f:	0f 85 82 00 00 00    	jne    57a7 <main+0x3e7>
    5725:	48 8b 0d 7c 67 01 00 	mov    0x1677c(%rip),%rcx        # 1bea8 <measured_calls>
    572c:	48 29 d9             	sub    %rbx,%rcx
    572f:	48 83 f9 02          	cmp    $0x2,%rcx
    5733:	72 79                	jb     57ae <main+0x3ee>
    5735:	f2 0f 10 05 53 5d 01 	movsd  0x15d53(%rip),%xmm0        # 1b490 <fwp_gc+0x1208>
    573c:	00 
    573d:	f2 0f 10 4d d0       	movsd  -0x30(%rbp),%xmm1
    5742:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
    5746:	73 6d                	jae    57b5 <main+0x3f5>
    5748:	4c 8b 05 61 67 01 00 	mov    0x16761(%rip),%r8        # 1beb0 <measured_bytes>
    574f:	4c 2b 45 c0          	sub    -0x40(%rbp),%r8
    5753:	4d 85 f6             	test   %r14,%r14
    5756:	48 8d 35 63 02 01 00 	lea    0x10263(%rip),%rsi        # 159c0 <exec_in_fp0+0x150>
    575d:	48 8d 15 62 0a 01 00 	lea    0x10a62(%rip),%rdx        # 161c6 <exec_in_fp0+0x956>
    5764:	48 0f 44 f2          	cmove  %rdx,%rsi
    5768:	f2 0f 5c c1          	subsd  %xmm1,%xmm0
    576c:	48 8d 3d e0 01 01 00 	lea    0x101e0(%rip),%rdi        # 15953 <exec_in_fp0+0xe3>
    5773:	4c 89 fa             	mov    %r15,%rdx
    5776:	49 89 c1             	mov    %rax,%r9
    5779:	b0 01                	mov    $0x1,%al
    577b:	e8 40 da ff ff       	call   31c0 <printf@plt>
    5780:	49 ff c6             	inc    %r14
    5783:	49 83 fe 05          	cmp    $0x5,%r14
    5787:	48 bb c5 4e ec c4 4e 	movabs $0x4ec4ec4ec4ec4ec5,%rbx
    578e:	ec c4 4e 
    5791:	0f 85 49 fd ff ff    	jne    54e0 <main+0x120>
    5797:	48 8d 3d 25 02 01 00 	lea    0x10225(%rip),%rdi        # 159c3 <exec_in_fp0+0x153>
    579e:	e8 2d d9 ff ff       	call   30d0 <puts@plt>
    57a3:	31 c0                	xor    %eax,%eax
    57a5:	eb 13                	jmp    57ba <main+0x3fa>
    57a7:	b8 aa 00 00 00       	mov    $0xaa,%eax
    57ac:	eb 0c                	jmp    57ba <main+0x3fa>
    57ae:	b8 ac 00 00 00       	mov    $0xac,%eax
    57b3:	eb 05                	jmp    57ba <main+0x3fa>
    57b5:	b8 ad 00 00 00       	mov    $0xad,%eax
    57ba:	48 83 c4 78          	add    $0x78,%rsp
    57be:	5b                   	pop    %rbx
    57bf:	41 5c                	pop    %r12
    57c1:	41 5d                	pop    %r13
    57c3:	41 5e                	pop    %r14
    57c5:	41 5f                	pop    %r15
    57c7:	5d                   	pop    %rbp
    57c8:	c3                   	ret
    57c9:	e8 f2 13 00 00       	call   6bc0 <fwp_flush>
    57ce:	48 8b 05 03 48 01 00 	mov    0x14803(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    57d5:	48 8b 38             	mov    (%rax),%rdi
    57d8:	48 8d 35 ab 02 01 00 	lea    0x102ab(%rip),%rsi        # 15a8a <exec_in_fp0+0x21a>
    57df:	48 8d 15 ec 11 01 00 	lea    0x111ec(%rip),%rdx        # 169d2 <exec_in_fp0+0x1162>
    57e6:	31 c0                	xor    %eax,%eax
    57e8:	e8 03 db ff ff       	call   32f0 <fprintf@plt>
    57ed:	bf 65 00 00 00       	mov    $0x65,%edi
    57f2:	e8 69 dc ff ff       	call   3460 <exit@plt>
    57f7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    57fe:	00 00 

0000000000005800 <fwp_array_new_packed>:
    5800:	41 56                	push   %r14
    5802:	53                   	push   %rbx
    5803:	50                   	push   %rax
    5804:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    580b:	ff ff 1f 
    580e:	48 39 c7             	cmp    %rax,%rdi
    5811:	0f 83 b7 01 00 00    	jae    59ce <fwp_array_new_packed+0x1ce>
    5817:	48 89 fb             	mov    %rdi,%rbx
    581a:	48 85 f6             	test   %rsi,%rsi
    581d:	74 23                	je     5842 <fwp_array_new_packed+0x42>
    581f:	8b 06                	mov    (%rsi),%eax
    5821:	48 83 f8 0a          	cmp    $0xa,%rax
    5825:	77 0e                	ja     5835 <fwp_array_new_packed+0x35>
    5827:	b9 e7 04 00 00       	mov    $0x4e7,%ecx
    582c:	0f a3 c1             	bt     %eax,%ecx
    582f:	0f 82 a1 00 00 00    	jb     58d6 <fwp_array_new_packed+0xd6>
    5835:	48 8d 0c dd 00 00 00 	lea    0x0(,%rbx,8),%rcx
    583c:	00 
    583d:	e9 a3 00 00 00       	jmp    58e5 <fwp_array_new_packed+0xe5>
    5842:	48 8d 14 dd 08 00 00 	lea    0x8(,%rbx,8),%rdx
    5849:	00 
    584a:	48 ff 05 57 66 01 00 	incq   0x16657(%rip)        # 1bea8 <measured_calls>
    5851:	48 01 15 58 66 01 00 	add    %rdx,0x16658(%rip)        # 1beb0 <measured_bytes>
    5858:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    585f:	77 68                	ja     58c9 <fwp_array_new_packed+0xc9>
    5861:	48 8d 42 0f          	lea    0xf(%rdx),%rax
    5865:	48 c1 e8 04          	shr    $0x4,%rax
    5869:	48 8d 0d 18 4a 01 00 	lea    0x14a18(%rip),%rcx        # 1a288 <fwp_gc>
    5870:	0f b6 b4 08 e8 0b 00 	movzbl 0xbe8(%rax,%rcx,1),%esi
    5877:	00 
    5878:	8b 84 b1 48 0b 00 00 	mov    0xb48(%rcx,%rsi,4),%eax
    587f:	48 29 05 02 4a 01 00 	sub    %rax,0x14a02(%rip)        # 1a288 <fwp_gc>
    5886:	78 41                	js     58c9 <fwp_array_new_packed+0xc9>
    5888:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    588c:	48 8d 3c f1          	lea    (%rcx,%rsi,8),%rdi
    5890:	48 81 c7 88 07 00 00 	add    $0x788,%rdi
    5897:	4c 8b 37             	mov    (%rdi),%r14
    589a:	4d 85 f6             	test   %r14,%r14
    589d:	74 0e                	je     58ad <fwp_array_new_packed+0xad>
    589f:	49 8b 0e             	mov    (%r14),%rcx
    58a2:	48 f7 d1             	not    %rcx
    58a5:	48 89 0f             	mov    %rcx,(%rdi)
    58a8:	e9 06 01 00 00       	jmp    59b3 <fwp_array_new_packed+0x1b3>
    58ad:	4c 8b b4 f1 90 07 00 	mov    0x790(%rcx,%rsi,8),%r14
    58b4:	00 
    58b5:	48 8b bc f1 98 07 00 	mov    0x798(%rcx,%rsi,8),%rdi
    58bc:	00 
    58bd:	4c 29 f7             	sub    %r14,%rdi
    58c0:	48 39 c7             	cmp    %rax,%rdi
    58c3:	0f 83 d8 00 00 00    	jae    59a1 <fwp_array_new_packed+0x1a1>
    58c9:	48 89 d7             	mov    %rdx,%rdi
    58cc:	be 02 00 00 00       	mov    $0x2,%esi
    58d1:	e9 aa 00 00 00       	jmp    5980 <fwp_array_new_packed+0x180>
    58d6:	48 8d 0d bb ff 00 00 	lea    0xffbb(%rip),%rcx        # 15898 <exec_in_fp0+0x28>
    58dd:	48 8b 0c c1          	mov    (%rcx,%rax,8),%rcx
    58e1:	48 0f af cb          	imul   %rbx,%rcx
    58e5:	48 8d 51 08          	lea    0x8(%rcx),%rdx
    58e9:	83 f8 0b             	cmp    $0xb,%eax
    58ec:	0f 87 58 ff ff ff    	ja     584a <fwp_array_new_packed+0x4a>
    58f2:	be ef 0d 00 00       	mov    $0xdef,%esi
    58f7:	0f a3 c6             	bt     %eax,%esi
    58fa:	0f 83 4a ff ff ff    	jae    584a <fwp_array_new_packed+0x4a>
    5900:	48 ff 05 a1 65 01 00 	incq   0x165a1(%rip)        # 1bea8 <measured_calls>
    5907:	48 01 15 a2 65 01 00 	add    %rdx,0x165a2(%rip)        # 1beb0 <measured_bytes>
    590e:	48 81 f9 f8 3f 00 00 	cmp    $0x3ff8,%rcx
    5915:	77 61                	ja     5978 <fwp_array_new_packed+0x178>
    5917:	48 83 c1 17          	add    $0x17,%rcx
    591b:	48 c1 e9 04          	shr    $0x4,%rcx
    591f:	48 8d 05 62 49 01 00 	lea    0x14962(%rip),%rax        # 1a288 <fwp_gc>
    5926:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    592d:	00 
    592e:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    5935:	48 29 0d 4c 49 01 00 	sub    %rcx,0x1494c(%rip)        # 1a288 <fwp_gc>
    593c:	78 3a                	js     5978 <fwp_array_new_packed+0x178>
    593e:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    5942:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    5946:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    594d:	4c 8b 37             	mov    (%rdi),%r14
    5950:	4d 85 f6             	test   %r14,%r14
    5953:	74 0b                	je     5960 <fwp_array_new_packed+0x160>
    5955:	49 8b 06             	mov    (%r14),%rax
    5958:	48 f7 d0             	not    %rax
    595b:	48 89 07             	mov    %rax,(%rdi)
    595e:	eb 3a                	jmp    599a <fwp_array_new_packed+0x19a>
    5960:	4c 8b b4 f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r14
    5967:	00 
    5968:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    596f:	00 
    5970:	4c 29 f7             	sub    %r14,%rdi
    5973:	48 39 cf             	cmp    %rcx,%rdi
    5976:	73 12                	jae    598a <fwp_array_new_packed+0x18a>
    5978:	48 89 d7             	mov    %rdx,%rdi
    597b:	be 01 00 00 00       	mov    $0x1,%esi
    5980:	e8 fb 28 00 00       	call   8280 <fwp_gc_alloc_slow>
    5985:	49 89 c6             	mov    %rax,%r14
    5988:	eb 36                	jmp    59c0 <fwp_array_new_packed+0x1c0>
    598a:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    598e:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    5994:	4c 01 f1             	add    %r14,%rcx
    5997:	48 89 08             	mov    %rcx,(%rax)
    599a:	4c 89 f7             	mov    %r14,%rdi
    599d:	31 f6                	xor    %esi,%esi
    599f:	eb 1a                	jmp    59bb <fwp_array_new_packed+0x1bb>
    59a1:	48 8d 0c f1          	lea    (%rcx,%rsi,8),%rcx
    59a5:	48 81 c1 90 07 00 00 	add    $0x790,%rcx
    59ac:	49 8d 14 06          	lea    (%r14,%rax,1),%rdx
    59b0:	48 89 11             	mov    %rdx,(%rcx)
    59b3:	4c 89 f7             	mov    %r14,%rdi
    59b6:	31 f6                	xor    %esi,%esi
    59b8:	48 89 c2             	mov    %rax,%rdx
    59bb:	e8 50 d8 ff ff       	call   3210 <memset@plt>
    59c0:	49 89 1e             	mov    %rbx,(%r14)
    59c3:	4c 89 f0             	mov    %r14,%rax
    59c6:	48 83 c4 08          	add    $0x8,%rsp
    59ca:	5b                   	pop    %rbx
    59cb:	41 5e                	pop    %r14
    59cd:	c3                   	ret
    59ce:	e8 ed 11 00 00       	call   6bc0 <fwp_flush>
    59d3:	48 8b 05 fe 45 01 00 	mov    0x145fe(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    59da:	48 8b 38             	mov    (%rax),%rdi
    59dd:	48 8d 35 a6 00 01 00 	lea    0x100a6(%rip),%rsi        # 15a8a <exec_in_fp0+0x21a>
    59e4:	48 8d 15 ae 00 01 00 	lea    0x100ae(%rip),%rdx        # 15a99 <exec_in_fp0+0x229>
    59eb:	31 c0                	xor    %eax,%eax
    59ed:	e8 fe d8 ff ff       	call   32f0 <fprintf@plt>
    59f2:	bf 65 00 00 00       	mov    $0x65,%edi
    59f7:	e8 64 da ff ff       	call   3460 <exit@plt>
    59fc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000005a00 <f0>:
    5a00:	55                   	push   %rbp
    5a01:	41 57                	push   %r15
    5a03:	41 56                	push   %r14
    5a05:	41 55                	push   %r13
    5a07:	41 54                	push   %r12
    5a09:	53                   	push   %rbx
    5a0a:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    5a11:	48 89 fb             	mov    %rdi,%rbx
    5a14:	0f 10 05 55 f7 00 00 	movups 0xf755(%rip),%xmm0        # 15170 <_IO_stdin_used+0x170>
    5a1b:	0f 29 44 24 70       	movaps %xmm0,0x70(%rsp)
    5a20:	0f 10 05 59 f7 00 00 	movups 0xf759(%rip),%xmm0        # 15180 <_IO_stdin_used+0x180>
    5a27:	0f 29 44 24 60       	movaps %xmm0,0x60(%rsp)
    5a2c:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
    5a31:	48 8b 05 80 64 01 00 	mov    0x16480(%rip),%rax        # 1beb8 <fwp_cleanups>
    5a38:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
    5a3d:	48 8d 05 4c e3 00 00 	lea    0xe34c(%rip),%rax        # 13d90 <fwp_owner_release0>
    5a44:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    5a49:	48 8d 44 24 28       	lea    0x28(%rsp),%rax
    5a4e:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
    5a53:	4c 8d 7c 24 48       	lea    0x48(%rsp),%r15
    5a58:	4c 89 3d 59 64 01 00 	mov    %r15,0x16459(%rip)        # 1beb8 <fwp_cleanups>
    5a5f:	48 8d 0d 1a 63 01 00 	lea    0x1631a(%rip),%rcx        # 1bd80 <d2>
    5a66:	48 8d 7c 24 60       	lea    0x60(%rsp),%rdi
    5a6b:	48 89 de             	mov    %rbx,%rsi
    5a6e:	48 89 ca             	mov    %rcx,%rdx
    5a71:	e8 8a 12 00 00       	call   6d00 <fwp_p_array_map_typed>
    5a76:	4c 39 3d 3b 64 01 00 	cmp    %r15,0x1643b(%rip)        # 1beb8 <fwp_cleanups>
    5a7d:	0f 85 f6 01 00 00    	jne    5c79 <f0+0x279>
    5a83:	49 89 c6             	mov    %rax,%r14
    5a86:	48 8b 44 24 48       	mov    0x48(%rsp),%rax
    5a8b:	48 89 05 26 64 01 00 	mov    %rax,0x16426(%rip)        # 1beb8 <fwp_cleanups>
    5a92:	48 8d 44 24 60       	lea    0x60(%rsp),%rax
    5a97:	48 89 df             	mov    %rbx,%rdi
    5a9a:	e8 01 e3 00 00       	call   13da0 <fwp_drop0>
    5a9f:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    5aa4:	48 8b 05 0d 64 01 00 	mov    0x1640d(%rip),%rax        # 1beb8 <fwp_cleanups>
    5aab:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    5ab0:	48 8d 05 c9 e3 00 00 	lea    0xe3c9(%rip),%rax        # 13e80 <fwp_owner_release1>
    5ab7:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    5abc:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    5ac1:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    5ac6:	4c 8d 7c 24 30       	lea    0x30(%rsp),%r15
    5acb:	4c 89 3d e6 63 01 00 	mov    %r15,0x163e6(%rip)        # 1beb8 <fwp_cleanups>
    5ad2:	48 8d 0d a7 62 01 00 	lea    0x162a7(%rip),%rcx        # 1bd80 <d2>
    5ad9:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    5ade:	4c 89 f6             	mov    %r14,%rsi
    5ae1:	48 89 ca             	mov    %rcx,%rdx
    5ae4:	e8 17 12 00 00       	call   6d00 <fwp_p_array_map_typed>
    5ae9:	4c 39 3d c8 63 01 00 	cmp    %r15,0x163c8(%rip)        # 1beb8 <fwp_cleanups>
    5af0:	0f 85 83 01 00 00    	jne    5c79 <f0+0x279>
    5af6:	48 89 c3             	mov    %rax,%rbx
    5af9:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
    5b00:	ff ff 7f 
    5b03:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    5b08:	48 89 05 a9 63 01 00 	mov    %rax,0x163a9(%rip)        # 1beb8 <fwp_cleanups>
    5b0f:	48 8d 44 24 70       	lea    0x70(%rsp),%rax
    5b14:	4c 89 f7             	mov    %r14,%rdi
    5b17:	e8 84 e2 00 00       	call   13da0 <fwp_drop0>
    5b1c:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    5b21:	48 8b 05 90 63 01 00 	mov    0x16390(%rip),%rax        # 1beb8 <fwp_cleanups>
    5b28:	48 89 04 24          	mov    %rax,(%rsp)
    5b2c:	48 8d 05 5d e3 00 00 	lea    0xe35d(%rip),%rax        # 13e90 <fwp_owner_release2>
    5b33:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    5b38:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
    5b3d:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    5b42:	48 89 e0             	mov    %rsp,%rax
    5b45:	48 89 05 6c 63 01 00 	mov    %rax,0x1636c(%rip)        # 1beb8 <fwp_cleanups>
    5b4c:	48 8b 0b             	mov    (%rbx),%rcx
    5b4f:	48 8d 04 4d 00 00 00 	lea    0x0(,%rcx,2),%rax
    5b56:	00 
    5b57:	48 85 c0             	test   %rax,%rax
    5b5a:	0f 84 ce 00 00 00    	je     5c2e <f0+0x22e>
    5b60:	48 89 dd             	mov    %rbx,%rbp
    5b63:	48 83 c5 08          	add    $0x8,%rbp
    5b67:	49 8d 44 24 01       	lea    0x1(%r12),%rax
    5b6c:	45 31 ed             	xor    %r13d,%r13d
    5b6f:	4c 8d 35 da 62 01 00 	lea    0x162da(%rip),%r14        # 1be50 <fc21>
    5b76:	4c 8d bc 24 80 00 00 	lea    0x80(%rsp),%r15
    5b7d:	00 
    5b7e:	eb 3d                	jmp    5bbd <f0+0x1bd>
    5b80:	0f b7 0c 0e          	movzwl (%rsi,%rcx,1),%ecx
    5b84:	83 f8 01             	cmp    $0x1,%eax
    5b87:	48 0f bf c1          	movswq %cx,%rax
    5b8b:	48 0f 45 c1          	cmovne %rcx,%rax
    5b8f:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
    5b96:	00 
    5b97:	4c 89 f7             	mov    %r14,%rdi
    5b9a:	be 02 00 00 00       	mov    $0x2,%esi
    5b9f:	4c 89 fa             	mov    %r15,%rdx
    5ba2:	b9 01 00 00 00       	mov    $0x1,%ecx
    5ba7:	e8 c4 13 00 00       	call   6f70 <fwp_apply_borrowed_prefix>
    5bac:	49 ff c5             	inc    %r13
    5baf:	48 8b 0b             	mov    (%rbx),%rcx
    5bb2:	48 89 ca             	mov    %rcx,%rdx
    5bb5:	4c 21 e2             	and    %r12,%rdx
    5bb8:	49 39 d5             	cmp    %rdx,%r13
    5bbb:	73 77                	jae    5c34 <f0+0x234>
    5bbd:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
    5bc4:	00 
    5bc5:	8b 05 b5 61 01 00    	mov    0x161b5(%rip),%eax        # 1bd80 <d2>
    5bcb:	ba 08 00 00 00       	mov    $0x8,%edx
    5bd0:	48 83 f8 0a          	cmp    $0xa,%rax
    5bd4:	77 0b                	ja     5be1 <f0+0x1e1>
    5bd6:	48 8d 15 13 fd 00 00 	lea    0xfd13(%rip),%rdx        # 158f0 <exec_in_fp0+0x80>
    5bdd:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
    5be1:	48 89 ee             	mov    %rbp,%rsi
    5be4:	48 85 c9             	test   %rcx,%rcx
    5be7:	79 04                	jns    5bed <f0+0x1ed>
    5be9:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    5bed:	48 89 d1             	mov    %rdx,%rcx
    5bf0:	49 0f af cd          	imul   %r13,%rcx
    5bf4:	48 83 fa 01          	cmp    $0x1,%rdx
    5bf8:	74 16                	je     5c10 <f0+0x210>
    5bfa:	48 83 fa 02          	cmp    $0x2,%rdx
    5bfe:	74 80                	je     5b80 <f0+0x180>
    5c00:	48 83 fa 08          	cmp    $0x8,%rdx
    5c04:	75 1a                	jne    5c20 <f0+0x220>
    5c06:	48 8b 04 0e          	mov    (%rsi,%rcx,1),%rax
    5c0a:	eb 83                	jmp    5b8f <f0+0x18f>
    5c0c:	0f 1f 40 00          	nopl   0x0(%rax)
    5c10:	0f b6 0c 0e          	movzbl (%rsi,%rcx,1),%ecx
    5c14:	48 85 c0             	test   %rax,%rax
    5c17:	48 0f be c1          	movsbq %cl,%rax
    5c1b:	e9 6b ff ff ff       	jmp    5b8b <f0+0x18b>
    5c20:	8b 0c 0e             	mov    (%rsi,%rcx,1),%ecx
    5c23:	83 f8 02             	cmp    $0x2,%eax
    5c26:	48 63 c1             	movslq %ecx,%rax
    5c29:	e9 5d ff ff ff       	jmp    5b8b <f0+0x18b>
    5c2e:	49 ff c4             	inc    %r12
    5c31:	4c 89 e0             	mov    %r12,%rax
    5c34:	49 89 c6             	mov    %rax,%r14
    5c37:	48 8d 05 12 62 01 00 	lea    0x16212(%rip),%rax        # 1be50 <fc21>
    5c3e:	48 89 e0             	mov    %rsp,%rax
    5c41:	48 39 05 70 62 01 00 	cmp    %rax,0x16270(%rip)        # 1beb8 <fwp_cleanups>
    5c48:	75 2f                	jne    5c79 <f0+0x279>
    5c4a:	48 8b 04 24          	mov    (%rsp),%rax
    5c4e:	48 89 05 63 62 01 00 	mov    %rax,0x16263(%rip)        # 1beb8 <fwp_cleanups>
    5c55:	48 8d 05 f4 61 01 00 	lea    0x161f4(%rip),%rax        # 1be50 <fc21>
    5c5c:	48 89 df             	mov    %rbx,%rdi
    5c5f:	e8 3c e1 00 00       	call   13da0 <fwp_drop0>
    5c64:	4c 89 f0             	mov    %r14,%rax
    5c67:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    5c6e:	5b                   	pop    %rbx
    5c6f:	41 5c                	pop    %r12
    5c71:	41 5d                	pop    %r13
    5c73:	41 5e                	pop    %r14
    5c75:	41 5f                	pop    %r15
    5c77:	5d                   	pop    %rbp
    5c78:	c3                   	ret
    5c79:	e8 f2 d3 ff ff       	call   3070 <abort@plt>
    5c7e:	66 90                	xchg   %ax,%ax

0000000000005c80 <e0>:
    5c80:	53                   	push   %rbx
    5c81:	48 89 fb             	mov    %rdi,%rbx
    5c84:	48 8b 3f             	mov    (%rdi),%rdi
    5c87:	e8 54 0c 00 00       	call   68e0 <fwp_rc_share>
    5c8c:	48 8b 3b             	mov    (%rbx),%rdi
    5c8f:	e8 6c fd ff ff       	call   5a00 <f0>
    5c94:	48 89 c3             	mov    %rax,%rbx
    5c97:	48 89 c7             	mov    %rax,%rdi
    5c9a:	e8 41 0c 00 00       	call   68e0 <fwp_rc_share>
    5c9f:	48 89 d8             	mov    %rbx,%rax
    5ca2:	5b                   	pop    %rbx
    5ca3:	c3                   	ret
    5ca4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    5cab:	00 00 00 00 00 

0000000000005cb0 <e1>:
    5cb0:	55                   	push   %rbp
    5cb1:	41 57                	push   %r15
    5cb3:	41 56                	push   %r14
    5cb5:	41 55                	push   %r13
    5cb7:	41 54                	push   %r12
    5cb9:	53                   	push   %rbx
    5cba:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    5cc1:	48 89 fb             	mov    %rdi,%rbx
    5cc4:	48 8b 3f             	mov    (%rdi),%rdi
    5cc7:	e8 14 0c 00 00       	call   68e0 <fwp_rc_share>
    5ccc:	48 8b 1b             	mov    (%rbx),%rbx
    5ccf:	0f 10 05 6a f4 00 00 	movups 0xf46a(%rip),%xmm0        # 15140 <_IO_stdin_used+0x140>
    5cd6:	0f 29 44 24 70       	movaps %xmm0,0x70(%rsp)
    5cdb:	0f 10 05 6e f4 00 00 	movups 0xf46e(%rip),%xmm0        # 15150 <_IO_stdin_used+0x150>
    5ce2:	0f 29 44 24 60       	movaps %xmm0,0x60(%rsp)
    5ce7:	48 89 5c 24 28       	mov    %rbx,0x28(%rsp)
    5cec:	48 8b 05 c5 61 01 00 	mov    0x161c5(%rip),%rax        # 1beb8 <fwp_cleanups>
    5cf3:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
    5cf8:	48 8d 05 f1 0e 00 00 	lea    0xef1(%rip),%rax        # 6bf0 <fwp_owner_release3>
    5cff:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    5d04:	48 8d 44 24 28       	lea    0x28(%rsp),%rax
    5d09:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
    5d0e:	4c 8d 7c 24 48       	lea    0x48(%rsp),%r15
    5d13:	4c 89 3d 9e 61 01 00 	mov    %r15,0x1619e(%rip)        # 1beb8 <fwp_cleanups>
    5d1a:	48 8d 0d 8f 5f 01 00 	lea    0x15f8f(%rip),%rcx        # 1bcb0 <d1>
    5d21:	48 8d 7c 24 60       	lea    0x60(%rsp),%rdi
    5d26:	48 89 de             	mov    %rbx,%rsi
    5d29:	48 89 ca             	mov    %rcx,%rdx
    5d2c:	e8 cf 0f 00 00       	call   6d00 <fwp_p_array_map_typed>
    5d31:	4c 39 3d 80 61 01 00 	cmp    %r15,0x16180(%rip)        # 1beb8 <fwp_cleanups>
    5d38:	0f 85 02 02 00 00    	jne    5f40 <e1+0x290>
    5d3e:	49 89 c6             	mov    %rax,%r14
    5d41:	48 8b 44 24 48       	mov    0x48(%rsp),%rax
    5d46:	48 89 05 6b 61 01 00 	mov    %rax,0x1616b(%rip)        # 1beb8 <fwp_cleanups>
    5d4d:	48 8d 44 24 60       	lea    0x60(%rsp),%rax
    5d52:	48 89 df             	mov    %rbx,%rdi
    5d55:	e8 a6 0e 00 00       	call   6c00 <fwp_drop1>
    5d5a:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    5d5f:	48 8b 05 52 61 01 00 	mov    0x16152(%rip),%rax        # 1beb8 <fwp_cleanups>
    5d66:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    5d6b:	48 8d 05 6e 0f 00 00 	lea    0xf6e(%rip),%rax        # 6ce0 <fwp_owner_release4>
    5d72:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    5d77:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    5d7c:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    5d81:	4c 8d 7c 24 30       	lea    0x30(%rsp),%r15
    5d86:	4c 89 3d 2b 61 01 00 	mov    %r15,0x1612b(%rip)        # 1beb8 <fwp_cleanups>
    5d8d:	48 8d 0d 1c 5f 01 00 	lea    0x15f1c(%rip),%rcx        # 1bcb0 <d1>
    5d94:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    5d99:	4c 89 f6             	mov    %r14,%rsi
    5d9c:	48 89 ca             	mov    %rcx,%rdx
    5d9f:	e8 5c 0f 00 00       	call   6d00 <fwp_p_array_map_typed>
    5da4:	4c 39 3d 0d 61 01 00 	cmp    %r15,0x1610d(%rip)        # 1beb8 <fwp_cleanups>
    5dab:	0f 85 8f 01 00 00    	jne    5f40 <e1+0x290>
    5db1:	48 89 c3             	mov    %rax,%rbx
    5db4:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    5db9:	48 89 05 f8 60 01 00 	mov    %rax,0x160f8(%rip)        # 1beb8 <fwp_cleanups>
    5dc0:	48 8d 44 24 70       	lea    0x70(%rsp),%rax
    5dc5:	4c 89 f7             	mov    %r14,%rdi
    5dc8:	e8 33 0e 00 00       	call   6c00 <fwp_drop1>
    5dcd:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    5dd2:	48 8b 05 df 60 01 00 	mov    0x160df(%rip),%rax        # 1beb8 <fwp_cleanups>
    5dd9:	48 89 04 24          	mov    %rax,(%rsp)
    5ddd:	48 8d 05 0c 0f 00 00 	lea    0xf0c(%rip),%rax        # 6cf0 <fwp_owner_release5>
    5de4:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    5de9:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
    5dee:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    5df3:	48 89 e2             	mov    %rsp,%rdx
    5df6:	48 89 15 bb 60 01 00 	mov    %rdx,0x160bb(%rip)        # 1beb8 <fwp_cleanups>
    5dfd:	48 8b 0b             	mov    (%rbx),%rcx
    5e00:	48 8d 04 4d 00 00 00 	lea    0x0(,%rcx,2),%rax
    5e07:	00 
    5e08:	48 85 c0             	test   %rax,%rax
    5e0b:	0f 84 e5 00 00 00    	je     5ef6 <e1+0x246>
    5e11:	49 bd ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r13
    5e18:	ff ff 7f 
    5e1b:	48 89 dd             	mov    %rbx,%rbp
    5e1e:	48 83 c5 08          	add    $0x8,%rbp
    5e22:	45 31 e4             	xor    %r12d,%r12d
    5e25:	4c 8d 35 7c 5e 01 00 	lea    0x15e7c(%rip),%r14        # 1bca8 <fc13>
    5e2c:	4c 8d bc 24 80 00 00 	lea    0x80(%rsp),%r15
    5e33:	00 
    5e34:	31 c0                	xor    %eax,%eax
    5e36:	eb 45                	jmp    5e7d <e1+0x1cd>
    5e38:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    5e3f:	00 
    5e40:	0f b7 0c 0e          	movzwl (%rsi,%rcx,1),%ecx
    5e44:	83 f8 01             	cmp    $0x1,%eax
    5e47:	48 0f bf c1          	movswq %cx,%rax
    5e4b:	48 0f 45 c1          	cmovne %rcx,%rax
    5e4f:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
    5e56:	00 
    5e57:	4c 89 f7             	mov    %r14,%rdi
    5e5a:	be 02 00 00 00       	mov    $0x2,%esi
    5e5f:	4c 89 fa             	mov    %r15,%rdx
    5e62:	b9 01 00 00 00       	mov    $0x1,%ecx
    5e67:	e8 04 11 00 00       	call   6f70 <fwp_apply_borrowed_prefix>
    5e6c:	49 ff c4             	inc    %r12
    5e6f:	48 8b 0b             	mov    (%rbx),%rcx
    5e72:	48 89 ca             	mov    %rcx,%rdx
    5e75:	4c 21 ea             	and    %r13,%rdx
    5e78:	49 39 d4             	cmp    %rdx,%r12
    5e7b:	73 71                	jae    5eee <e1+0x23e>
    5e7d:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
    5e84:	00 
    5e85:	8b 05 25 5e 01 00    	mov    0x15e25(%rip),%eax        # 1bcb0 <d1>
    5e8b:	ba 08 00 00 00       	mov    $0x8,%edx
    5e90:	48 83 f8 0a          	cmp    $0xa,%rax
    5e94:	77 0b                	ja     5ea1 <e1+0x1f1>
    5e96:	48 8d 15 53 fa 00 00 	lea    0xfa53(%rip),%rdx        # 158f0 <exec_in_fp0+0x80>
    5e9d:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
    5ea1:	48 89 ee             	mov    %rbp,%rsi
    5ea4:	48 85 c9             	test   %rcx,%rcx
    5ea7:	79 04                	jns    5ead <e1+0x1fd>
    5ea9:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    5ead:	48 89 d1             	mov    %rdx,%rcx
    5eb0:	49 0f af cc          	imul   %r12,%rcx
    5eb4:	48 83 fa 01          	cmp    $0x1,%rdx
    5eb8:	74 16                	je     5ed0 <e1+0x220>
    5eba:	48 83 fa 02          	cmp    $0x2,%rdx
    5ebe:	74 80                	je     5e40 <e1+0x190>
    5ec0:	48 83 fa 08          	cmp    $0x8,%rdx
    5ec4:	75 1a                	jne    5ee0 <e1+0x230>
    5ec6:	48 8b 04 0e          	mov    (%rsi,%rcx,1),%rax
    5eca:	eb 83                	jmp    5e4f <e1+0x19f>
    5ecc:	0f 1f 40 00          	nopl   0x0(%rax)
    5ed0:	0f b6 0c 0e          	movzbl (%rsi,%rcx,1),%ecx
    5ed4:	48 85 c0             	test   %rax,%rax
    5ed7:	48 0f be c1          	movsbq %cl,%rax
    5edb:	e9 6b ff ff ff       	jmp    5e4b <e1+0x19b>
    5ee0:	8b 0c 0e             	mov    (%rsi,%rcx,1),%ecx
    5ee3:	83 f8 02             	cmp    $0x2,%eax
    5ee6:	48 63 c1             	movslq %ecx,%rax
    5ee9:	e9 5d ff ff ff       	jmp    5e4b <e1+0x19b>
    5eee:	41 89 c6             	mov    %eax,%r14d
    5ef1:	48 89 e2             	mov    %rsp,%rdx
    5ef4:	eb 03                	jmp    5ef9 <e1+0x249>
    5ef6:	45 31 f6             	xor    %r14d,%r14d
    5ef9:	48 8d 05 a8 5d 01 00 	lea    0x15da8(%rip),%rax        # 1bca8 <fc13>
    5f00:	48 39 15 b1 5f 01 00 	cmp    %rdx,0x15fb1(%rip)        # 1beb8 <fwp_cleanups>
    5f07:	75 37                	jne    5f40 <e1+0x290>
    5f09:	48 8b 04 24          	mov    (%rsp),%rax
    5f0d:	48 89 05 a4 5f 01 00 	mov    %rax,0x15fa4(%rip)        # 1beb8 <fwp_cleanups>
    5f14:	48 8d 05 8d 5d 01 00 	lea    0x15d8d(%rip),%rax        # 1bca8 <fc13>
    5f1b:	48 89 df             	mov    %rbx,%rdi
    5f1e:	e8 dd 0c 00 00       	call   6c00 <fwp_drop1>
    5f23:	4c 89 f7             	mov    %r14,%rdi
    5f26:	e8 b5 09 00 00       	call   68e0 <fwp_rc_share>
    5f2b:	4c 89 f0             	mov    %r14,%rax
    5f2e:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    5f35:	5b                   	pop    %rbx
    5f36:	41 5c                	pop    %r12
    5f38:	41 5d                	pop    %r13
    5f3a:	41 5e                	pop    %r14
    5f3c:	41 5f                	pop    %r15
    5f3e:	5d                   	pop    %rbp
    5f3f:	c3                   	ret
    5f40:	e8 2b d1 ff ff       	call   3070 <abort@plt>
    5f45:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    5f4c:	00 00 00 00 

0000000000005f50 <e2>:
    5f50:	41 57                	push   %r15
    5f52:	41 56                	push   %r14
    5f54:	53                   	push   %rbx
    5f55:	48 83 ec 60          	sub    $0x60,%rsp
    5f59:	48 89 fb             	mov    %rdi,%rbx
    5f5c:	48 8b 3f             	mov    (%rdi),%rdi
    5f5f:	e8 7c 09 00 00       	call   68e0 <fwp_rc_share>
    5f64:	48 8b 1b             	mov    (%rbx),%rbx
    5f67:	0f 10 05 f2 f1 00 00 	movups 0xf1f2(%rip),%xmm0        # 15160 <_IO_stdin_used+0x160>
    5f6e:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    5f73:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
    5f78:	48 8b 05 39 5f 01 00 	mov    0x15f39(%rip),%rax        # 1beb8 <fwp_cleanups>
    5f7f:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    5f84:	48 8d 05 b5 4e 00 00 	lea    0x4eb5(%rip),%rax        # ae40 <fwp_owner_release6>
    5f8b:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    5f90:	48 8d 44 24 10       	lea    0x10(%rsp),%rax
    5f95:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    5f9a:	4c 8d 7c 24 18       	lea    0x18(%rsp),%r15
    5f9f:	4c 89 3d 12 5f 01 00 	mov    %r15,0x15f12(%rip)        # 1beb8 <fwp_cleanups>
    5fa6:	48 8d 0d 6b 5d 01 00 	lea    0x15d6b(%rip),%rcx        # 1bd18 <d0>
    5fad:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    5fb2:	48 89 de             	mov    %rbx,%rsi
    5fb5:	48 89 ca             	mov    %rcx,%rdx
    5fb8:	e8 43 0d 00 00       	call   6d00 <fwp_p_array_map_typed>
    5fbd:	4c 39 3d f4 5e 01 00 	cmp    %r15,0x15ef4(%rip)        # 1beb8 <fwp_cleanups>
    5fc4:	0f 85 80 00 00 00    	jne    604a <e2+0xfa>
    5fca:	49 89 c6             	mov    %rax,%r14
    5fcd:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    5fd2:	48 89 05 df 5e 01 00 	mov    %rax,0x15edf(%rip)        # 1beb8 <fwp_cleanups>
    5fd9:	48 8d 44 24 30       	lea    0x30(%rsp),%rax
    5fde:	48 89 df             	mov    %rbx,%rdi
    5fe1:	e8 6a 4e 00 00       	call   ae50 <fwp_drop2>
    5fe6:	4c 89 74 24 08       	mov    %r14,0x8(%rsp)
    5feb:	48 8b 05 c6 5e 01 00 	mov    0x15ec6(%rip),%rax        # 1beb8 <fwp_cleanups>
    5ff2:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
    5ff7:	48 8d 0d 32 4f 00 00 	lea    0x4f32(%rip),%rcx        # af30 <fwp_owner_release7>
    5ffe:	48 89 4c 24 50       	mov    %rcx,0x50(%rsp)
    6003:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    6008:	48 89 4c 24 58       	mov    %rcx,0x58(%rsp)
    600d:	48 8d 4c 24 48       	lea    0x48(%rsp),%rcx
    6012:	48 89 0d 9f 5e 01 00 	mov    %rcx,0x15e9f(%rip)        # 1beb8 <fwp_cleanups>
    6019:	48 bb ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rbx
    6020:	ff ff 7f 
    6023:	49 23 1e             	and    (%r14),%rbx
    6026:	48 89 05 8b 5e 01 00 	mov    %rax,0x15e8b(%rip)        # 1beb8 <fwp_cleanups>
    602d:	4c 89 f7             	mov    %r14,%rdi
    6030:	e8 1b 4e 00 00       	call   ae50 <fwp_drop2>
    6035:	48 89 df             	mov    %rbx,%rdi
    6038:	e8 a3 08 00 00       	call   68e0 <fwp_rc_share>
    603d:	48 89 d8             	mov    %rbx,%rax
    6040:	48 83 c4 60          	add    $0x60,%rsp
    6044:	5b                   	pop    %rbx
    6045:	41 5e                	pop    %r14
    6047:	41 5f                	pop    %r15
    6049:	c3                   	ret
    604a:	e8 21 d0 ff ff       	call   3070 <abort@plt>
    604f:	90                   	nop

0000000000006050 <e3>:
    6050:	55                   	push   %rbp
    6051:	41 57                	push   %r15
    6053:	41 56                	push   %r14
    6055:	41 55                	push   %r13
    6057:	41 54                	push   %r12
    6059:	53                   	push   %rbx
    605a:	48 83 ec 68          	sub    $0x68,%rsp
    605e:	48 89 fb             	mov    %rdi,%rbx
    6061:	48 8b 3f             	mov    (%rdi),%rdi
    6064:	e8 77 08 00 00       	call   68e0 <fwp_rc_share>
    6069:	4c 8b 33             	mov    (%rbx),%r14
    606c:	0f 10 05 ed f0 00 00 	movups 0xf0ed(%rip),%xmm0        # 15160 <_IO_stdin_used+0x160>
    6073:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    6078:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    607d:	48 8b 05 34 5e 01 00 	mov    0x15e34(%rip),%rax        # 1beb8 <fwp_cleanups>
    6084:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    6089:	48 8d 05 b0 4e 00 00 	lea    0x4eb0(%rip),%rax        # af40 <fwp_owner_release8>
    6090:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    6095:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    609a:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    609f:	4c 8d 7c 24 28       	lea    0x28(%rsp),%r15
    60a4:	4c 89 3d 0d 5e 01 00 	mov    %r15,0x15e0d(%rip)        # 1beb8 <fwp_cleanups>
    60ab:	48 8d 0d 66 5c 01 00 	lea    0x15c66(%rip),%rcx        # 1bd18 <d0>
    60b2:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
    60b7:	4c 89 f6             	mov    %r14,%rsi
    60ba:	48 89 ca             	mov    %rcx,%rdx
    60bd:	e8 3e 0c 00 00       	call   6d00 <fwp_p_array_map_typed>
    60c2:	4c 39 3d ef 5d 01 00 	cmp    %r15,0x15def(%rip)        # 1beb8 <fwp_cleanups>
    60c9:	0f 85 8f 01 00 00    	jne    625e <e3+0x20e>
    60cf:	48 89 c3             	mov    %rax,%rbx
    60d2:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    60d7:	48 89 05 da 5d 01 00 	mov    %rax,0x15dda(%rip)        # 1beb8 <fwp_cleanups>
    60de:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
    60e3:	4c 89 f7             	mov    %r14,%rdi
    60e6:	e8 65 4d 00 00       	call   ae50 <fwp_drop2>
    60eb:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    60f0:	48 8b 05 c1 5d 01 00 	mov    0x15dc1(%rip),%rax        # 1beb8 <fwp_cleanups>
    60f7:	48 89 04 24          	mov    %rax,(%rsp)
    60fb:	48 8d 05 4e 4e 00 00 	lea    0x4e4e(%rip),%rax        # af50 <fwp_owner_release9>
    6102:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    6107:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
    610c:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    6111:	48 89 e2             	mov    %rsp,%rdx
    6114:	48 89 15 9d 5d 01 00 	mov    %rdx,0x15d9d(%rip)        # 1beb8 <fwp_cleanups>
    611b:	48 8b 0b             	mov    (%rbx),%rcx
    611e:	48 8d 04 4d 00 00 00 	lea    0x0(,%rcx,2),%rax
    6125:	00 
    6126:	48 85 c0             	test   %rax,%rax
    6129:	0f 84 e8 00 00 00    	je     6217 <e3+0x1c7>
    612f:	49 bd ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r13
    6136:	ff ff 7f 
    6139:	48 89 dd             	mov    %rbx,%rbp
    613c:	48 83 c5 08          	add    $0x8,%rbp
    6140:	45 31 e4             	xor    %r12d,%r12d
    6143:	4c 8d 35 2e 5c 01 00 	lea    0x15c2e(%rip),%r14        # 1bd78 <fc5>
    614a:	4c 8d 7c 24 50       	lea    0x50(%rsp),%r15
    614f:	31 c0                	xor    %eax,%eax
    6151:	eb 47                	jmp    619a <e3+0x14a>
    6153:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    615a:	84 00 00 00 00 00 
    6160:	0f b7 0c 0e          	movzwl (%rsi,%rcx,1),%ecx
    6164:	83 f8 01             	cmp    $0x1,%eax
    6167:	48 0f bf c1          	movswq %cx,%rax
    616b:	48 0f 45 c1          	cmovne %rcx,%rax
    616f:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
    6174:	4c 89 f7             	mov    %r14,%rdi
    6177:	be 02 00 00 00       	mov    $0x2,%esi
    617c:	4c 89 fa             	mov    %r15,%rdx
    617f:	b9 01 00 00 00       	mov    $0x1,%ecx
    6184:	e8 e7 0d 00 00       	call   6f70 <fwp_apply_borrowed_prefix>
    6189:	49 ff c4             	inc    %r12
    618c:	48 8b 0b             	mov    (%rbx),%rcx
    618f:	48 89 ca             	mov    %rcx,%rdx
    6192:	4c 21 ea             	and    %r13,%rdx
    6195:	49 39 d4             	cmp    %rdx,%r12
    6198:	73 74                	jae    620e <e3+0x1be>
    619a:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    619f:	8b 05 73 5b 01 00    	mov    0x15b73(%rip),%eax        # 1bd18 <d0>
    61a5:	ba 08 00 00 00       	mov    $0x8,%edx
    61aa:	48 83 f8 0a          	cmp    $0xa,%rax
    61ae:	77 0b                	ja     61bb <e3+0x16b>
    61b0:	48 8d 15 39 f7 00 00 	lea    0xf739(%rip),%rdx        # 158f0 <exec_in_fp0+0x80>
    61b7:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
    61bb:	48 89 ee             	mov    %rbp,%rsi
    61be:	48 85 c9             	test   %rcx,%rcx
    61c1:	79 04                	jns    61c7 <e3+0x177>
    61c3:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    61c7:	48 89 d1             	mov    %rdx,%rcx
    61ca:	49 0f af cc          	imul   %r12,%rcx
    61ce:	48 83 fa 01          	cmp    $0x1,%rdx
    61d2:	74 1c                	je     61f0 <e3+0x1a0>
    61d4:	48 83 fa 02          	cmp    $0x2,%rdx
    61d8:	74 86                	je     6160 <e3+0x110>
    61da:	48 83 fa 08          	cmp    $0x8,%rdx
    61de:	75 20                	jne    6200 <e3+0x1b0>
    61e0:	48 8b 04 0e          	mov    (%rsi,%rcx,1),%rax
    61e4:	eb 89                	jmp    616f <e3+0x11f>
    61e6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    61ed:	00 00 00 
    61f0:	0f b6 0c 0e          	movzbl (%rsi,%rcx,1),%ecx
    61f4:	48 85 c0             	test   %rax,%rax
    61f7:	48 0f be c1          	movsbq %cl,%rax
    61fb:	e9 6b ff ff ff       	jmp    616b <e3+0x11b>
    6200:	8b 0c 0e             	mov    (%rsi,%rcx,1),%ecx
    6203:	83 f8 02             	cmp    $0x2,%eax
    6206:	48 63 c1             	movslq %ecx,%rax
    6209:	e9 5d ff ff ff       	jmp    616b <e3+0x11b>
    620e:	4c 0f be f0          	movsbq %al,%r14
    6212:	48 89 e2             	mov    %rsp,%rdx
    6215:	eb 03                	jmp    621a <e3+0x1ca>
    6217:	45 31 f6             	xor    %r14d,%r14d
    621a:	48 8d 05 57 5b 01 00 	lea    0x15b57(%rip),%rax        # 1bd78 <fc5>
    6221:	48 39 15 90 5c 01 00 	cmp    %rdx,0x15c90(%rip)        # 1beb8 <fwp_cleanups>
    6228:	75 34                	jne    625e <e3+0x20e>
    622a:	48 8b 04 24          	mov    (%rsp),%rax
    622e:	48 89 05 83 5c 01 00 	mov    %rax,0x15c83(%rip)        # 1beb8 <fwp_cleanups>
    6235:	48 8d 05 3c 5b 01 00 	lea    0x15b3c(%rip),%rax        # 1bd78 <fc5>
    623c:	48 89 df             	mov    %rbx,%rdi
    623f:	e8 0c 4c 00 00       	call   ae50 <fwp_drop2>
    6244:	4c 89 f7             	mov    %r14,%rdi
    6247:	e8 94 06 00 00       	call   68e0 <fwp_rc_share>
    624c:	4c 89 f0             	mov    %r14,%rax
    624f:	48 83 c4 68          	add    $0x68,%rsp
    6253:	5b                   	pop    %rbx
    6254:	41 5c                	pop    %r12
    6256:	41 5d                	pop    %r13
    6258:	41 5e                	pop    %r14
    625a:	41 5f                	pop    %r15
    625c:	5d                   	pop    %rbp
    625d:	c3                   	ret
    625e:	e8 0d ce ff ff       	call   3070 <abort@plt>
    6263:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    626a:	84 00 00 00 00 00 

0000000000006270 <e4>:
    6270:	53                   	push   %rbx
    6271:	48 89 fb             	mov    %rdi,%rbx
    6274:	48 8b 3f             	mov    (%rdi),%rdi
    6277:	e8 64 06 00 00       	call   68e0 <fwp_rc_share>
    627c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    6280:	e8 5b 06 00 00       	call   68e0 <fwp_rc_share>
    6285:	48 8b 3b             	mov    (%rbx),%rdi
    6288:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    628c:	48 8d 0d 85 5a 01 00 	lea    0x15a85(%rip),%rcx        # 1bd18 <d0>
    6293:	48 89 ca             	mov    %rcx,%rdx
    6296:	e8 65 0a 00 00       	call   6d00 <fwp_p_array_map_typed>
    629b:	48 89 c3             	mov    %rax,%rbx
    629e:	48 89 c7             	mov    %rax,%rdi
    62a1:	e8 3a 06 00 00       	call   68e0 <fwp_rc_share>
    62a6:	48 89 d8             	mov    %rbx,%rax
    62a9:	5b                   	pop    %rbx
    62aa:	c3                   	ret
    62ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000062b0 <e5>:
    62b0:	53                   	push   %rbx
    62b1:	48 83 ec 60          	sub    $0x60,%rsp
    62b5:	48 0f be 07          	movsbq (%rdi),%rax
    62b9:	48 0f be 5f 08       	movsbq 0x8(%rdi),%rbx
    62be:	48 01 c3             	add    %rax,%rbx
    62c1:	48 0f be c3          	movsbq %bl,%rax
    62c5:	48 39 d8             	cmp    %rbx,%rax
    62c8:	75 11                	jne    62db <e5+0x2b>
    62ca:	48 89 df             	mov    %rbx,%rdi
    62cd:	e8 0e 06 00 00       	call   68e0 <fwp_rc_share>
    62d2:	48 89 d8             	mov    %rbx,%rax
    62d5:	48 83 c4 60          	add    $0x60,%rsp
    62d9:	5b                   	pop    %rbx
    62da:	c3                   	ret
    62db:	48 8d 15 72 f9 00 00 	lea    0xf972(%rip),%rdx        # 15c54 <exec_in_fp0+0x3e4>
    62e2:	48 8d 0d 68 f9 00 00 	lea    0xf968(%rip),%rcx        # 15c51 <exec_in_fp0+0x3e1>
    62e9:	48 89 e3             	mov    %rsp,%rbx
    62ec:	be 60 00 00 00       	mov    $0x60,%esi
    62f1:	48 89 df             	mov    %rbx,%rdi
    62f4:	31 c0                	xor    %eax,%eax
    62f6:	e8 d5 ce ff ff       	call   31d0 <snprintf@plt>
    62fb:	e8 c0 08 00 00       	call   6bc0 <fwp_flush>
    6300:	48 8b 05 d1 3c 01 00 	mov    0x13cd1(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    6307:	48 8b 38             	mov    (%rax),%rdi
    630a:	48 8d 35 79 f7 00 00 	lea    0xf779(%rip),%rsi        # 15a8a <exec_in_fp0+0x21a>
    6311:	48 89 da             	mov    %rbx,%rdx
    6314:	31 c0                	xor    %eax,%eax
    6316:	e8 d5 cf ff ff       	call   32f0 <fprintf@plt>
    631b:	bf 65 00 00 00       	mov    $0x65,%edi
    6320:	e8 3b d1 ff ff       	call   3460 <exit@plt>
    6325:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    632c:	00 00 00 00 

0000000000006330 <e6>:
    6330:	55                   	push   %rbp
    6331:	41 57                	push   %r15
    6333:	41 56                	push   %r14
    6335:	41 55                	push   %r13
    6337:	41 54                	push   %r12
    6339:	53                   	push   %rbx
    633a:	48 83 ec 18          	sub    $0x18,%rsp
    633e:	49 89 fe             	mov    %rdi,%r14
    6341:	48 8b 3f             	mov    (%rdi),%rdi
    6344:	e8 97 05 00 00       	call   68e0 <fwp_rc_share>
    6349:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    634d:	e8 8e 05 00 00       	call   68e0 <fwp_rc_share>
    6352:	49 8b 1e             	mov    (%r14),%rbx
    6355:	49 8b 46 08          	mov    0x8(%r14),%rax
    6359:	4d 8b 7e 10          	mov    0x10(%r14),%r15
    635d:	49 8b 0f             	mov    (%r15),%rcx
    6360:	48 8d 14 4d 00 00 00 	lea    0x0(,%rcx,2),%rdx
    6367:	00 
    6368:	48 85 d2             	test   %rdx,%rdx
    636b:	0f 84 cd 00 00 00    	je     643e <e6+0x10e>
    6371:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
    6378:	ff ff 7f 
    637b:	4d 8d 6f 08          	lea    0x8(%r15),%r13
    637f:	31 ed                	xor    %ebp,%ebp
    6381:	49 89 e6             	mov    %rsp,%r14
    6384:	eb 44                	jmp    63ca <e6+0x9a>
    6386:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    638d:	00 00 00 
    6390:	0f b7 0c 0e          	movzwl (%rsi,%rcx,1),%ecx
    6394:	83 f8 01             	cmp    $0x1,%eax
    6397:	48 0f bf c1          	movswq %cx,%rax
    639b:	48 0f 45 c1          	cmovne %rcx,%rax
    639f:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    63a4:	48 89 df             	mov    %rbx,%rdi
    63a7:	be 02 00 00 00       	mov    $0x2,%esi
    63ac:	4c 89 f2             	mov    %r14,%rdx
    63af:	b9 01 00 00 00       	mov    $0x1,%ecx
    63b4:	e8 b7 0b 00 00       	call   6f70 <fwp_apply_borrowed_prefix>
    63b9:	48 ff c5             	inc    %rbp
    63bc:	49 8b 0f             	mov    (%r15),%rcx
    63bf:	48 89 ca             	mov    %rcx,%rdx
    63c2:	4c 21 e2             	and    %r12,%rdx
    63c5:	48 39 d5             	cmp    %rdx,%rbp
    63c8:	73 74                	jae    643e <e6+0x10e>
    63ca:	48 89 04 24          	mov    %rax,(%rsp)
    63ce:	8b 05 44 59 01 00    	mov    0x15944(%rip),%eax        # 1bd18 <d0>
    63d4:	ba 08 00 00 00       	mov    $0x8,%edx
    63d9:	48 83 f8 0a          	cmp    $0xa,%rax
    63dd:	77 0b                	ja     63ea <e6+0xba>
    63df:	48 8d 15 0a f5 00 00 	lea    0xf50a(%rip),%rdx        # 158f0 <exec_in_fp0+0x80>
    63e6:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
    63ea:	4c 89 ee             	mov    %r13,%rsi
    63ed:	48 85 c9             	test   %rcx,%rcx
    63f0:	79 04                	jns    63f6 <e6+0xc6>
    63f2:	49 8b 77 10          	mov    0x10(%r15),%rsi
    63f6:	48 89 d1             	mov    %rdx,%rcx
    63f9:	48 0f af cd          	imul   %rbp,%rcx
    63fd:	48 83 fa 01          	cmp    $0x1,%rdx
    6401:	74 1d                	je     6420 <e6+0xf0>
    6403:	48 83 fa 02          	cmp    $0x2,%rdx
    6407:	74 87                	je     6390 <e6+0x60>
    6409:	48 83 fa 08          	cmp    $0x8,%rdx
    640d:	75 21                	jne    6430 <e6+0x100>
    640f:	48 8b 04 0e          	mov    (%rsi,%rcx,1),%rax
    6413:	eb 8a                	jmp    639f <e6+0x6f>
    6415:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    641c:	00 00 00 00 
    6420:	0f b6 0c 0e          	movzbl (%rsi,%rcx,1),%ecx
    6424:	48 85 c0             	test   %rax,%rax
    6427:	48 0f be c1          	movsbq %cl,%rax
    642b:	e9 6b ff ff ff       	jmp    639b <e6+0x6b>
    6430:	8b 0c 0e             	mov    (%rsi,%rcx,1),%ecx
    6433:	83 f8 02             	cmp    $0x2,%eax
    6436:	48 63 c1             	movslq %ecx,%rax
    6439:	e9 5d ff ff ff       	jmp    639b <e6+0x6b>
    643e:	48 89 c7             	mov    %rax,%rdi
    6441:	48 89 c3             	mov    %rax,%rbx
    6444:	e8 97 04 00 00       	call   68e0 <fwp_rc_share>
    6449:	48 89 d8             	mov    %rbx,%rax
    644c:	48 83 c4 18          	add    $0x18,%rsp
    6450:	5b                   	pop    %rbx
    6451:	41 5c                	pop    %r12
    6453:	41 5d                	pop    %r13
    6455:	41 5e                	pop    %r14
    6457:	41 5f                	pop    %r15
    6459:	5d                   	pop    %rbp
    645a:	c3                   	ret
    645b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006460 <e8>:
    6460:	53                   	push   %rbx
    6461:	48 83 ec 60          	sub    $0x60,%rsp
    6465:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    6469:	48 03 1f             	add    (%rdi),%rbx
    646c:	48 0f be c3          	movsbq %bl,%rax
    6470:	48 39 d8             	cmp    %rbx,%rax
    6473:	75 11                	jne    6486 <e8+0x26>
    6475:	48 89 df             	mov    %rbx,%rdi
    6478:	e8 63 04 00 00       	call   68e0 <fwp_rc_share>
    647d:	48 89 d8             	mov    %rbx,%rax
    6480:	48 83 c4 60          	add    $0x60,%rsp
    6484:	5b                   	pop    %rbx
    6485:	c3                   	ret
    6486:	48 8d 15 c7 f7 00 00 	lea    0xf7c7(%rip),%rdx        # 15c54 <exec_in_fp0+0x3e4>
    648d:	48 8d 0d bd f7 00 00 	lea    0xf7bd(%rip),%rcx        # 15c51 <exec_in_fp0+0x3e1>
    6494:	48 89 e3             	mov    %rsp,%rbx
    6497:	be 60 00 00 00       	mov    $0x60,%esi
    649c:	48 89 df             	mov    %rbx,%rdi
    649f:	31 c0                	xor    %eax,%eax
    64a1:	e8 2a cd ff ff       	call   31d0 <snprintf@plt>
    64a6:	e8 15 07 00 00       	call   6bc0 <fwp_flush>
    64ab:	48 8b 05 26 3b 01 00 	mov    0x13b26(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    64b2:	48 8b 38             	mov    (%rax),%rdi
    64b5:	48 8d 35 ce f5 00 00 	lea    0xf5ce(%rip),%rsi        # 15a8a <exec_in_fp0+0x21a>
    64bc:	48 89 da             	mov    %rbx,%rdx
    64bf:	31 c0                	xor    %eax,%eax
    64c1:	e8 2a ce ff ff       	call   32f0 <fprintf@plt>
    64c6:	bf 65 00 00 00       	mov    $0x65,%edi
    64cb:	e8 90 cf ff ff       	call   3460 <exit@plt>

00000000000064d0 <e9>:
    64d0:	53                   	push   %rbx
    64d1:	48 89 fb             	mov    %rdi,%rbx
    64d4:	48 8b 3f             	mov    (%rdi),%rdi
    64d7:	e8 04 04 00 00       	call   68e0 <fwp_rc_share>
    64dc:	48 8b 03             	mov    (%rbx),%rax
    64df:	48 bb ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rbx
    64e6:	ff ff 7f 
    64e9:	48 23 18             	and    (%rax),%rbx
    64ec:	48 89 df             	mov    %rbx,%rdi
    64ef:	e8 ec 03 00 00       	call   68e0 <fwp_rc_share>
    64f4:	48 89 d8             	mov    %rbx,%rax
    64f7:	5b                   	pop    %rbx
    64f8:	c3                   	ret
    64f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000006500 <e11>:
    6500:	53                   	push   %rbx
    6501:	48 89 fb             	mov    %rdi,%rbx
    6504:	48 8b 3f             	mov    (%rdi),%rdi
    6507:	e8 d4 03 00 00       	call   68e0 <fwp_rc_share>
    650c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    6510:	e8 cb 03 00 00       	call   68e0 <fwp_rc_share>
    6515:	48 8b 3b             	mov    (%rbx),%rdi
    6518:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    651c:	48 8d 0d 8d 57 01 00 	lea    0x1578d(%rip),%rcx        # 1bcb0 <d1>
    6523:	48 89 ca             	mov    %rcx,%rdx
    6526:	e8 d5 07 00 00       	call   6d00 <fwp_p_array_map_typed>
    652b:	48 89 c3             	mov    %rax,%rbx
    652e:	48 89 c7             	mov    %rax,%rdi
    6531:	e8 aa 03 00 00       	call   68e0 <fwp_rc_share>
    6536:	48 89 d8             	mov    %rbx,%rax
    6539:	5b                   	pop    %rbx
    653a:	c3                   	ret
    653b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006540 <e12>:
    6540:	53                   	push   %rbx
    6541:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    6545:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    654a:	0f 59 c8             	mulps  %xmm0,%xmm1
    654d:	66 0f 7e cb          	movd   %xmm1,%ebx
    6551:	48 89 df             	mov    %rbx,%rdi
    6554:	e8 87 03 00 00       	call   68e0 <fwp_rc_share>
    6559:	48 89 d8             	mov    %rbx,%rax
    655c:	5b                   	pop    %rbx
    655d:	c3                   	ret
    655e:	66 90                	xchg   %ax,%ax

0000000000006560 <e13>:
    6560:	53                   	push   %rbx
    6561:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    6565:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    656a:	0f 58 c8             	addps  %xmm0,%xmm1
    656d:	66 0f 7e cb          	movd   %xmm1,%ebx
    6571:	48 89 df             	mov    %rbx,%rdi
    6574:	e8 67 03 00 00       	call   68e0 <fwp_rc_share>
    6579:	48 89 d8             	mov    %rbx,%rax
    657c:	5b                   	pop    %rbx
    657d:	c3                   	ret
    657e:	66 90                	xchg   %ax,%ax

0000000000006580 <e15>:
    6580:	55                   	push   %rbp
    6581:	41 57                	push   %r15
    6583:	41 56                	push   %r14
    6585:	41 55                	push   %r13
    6587:	41 54                	push   %r12
    6589:	53                   	push   %rbx
    658a:	48 83 ec 18          	sub    $0x18,%rsp
    658e:	49 89 fe             	mov    %rdi,%r14
    6591:	48 8b 3f             	mov    (%rdi),%rdi
    6594:	e8 47 03 00 00       	call   68e0 <fwp_rc_share>
    6599:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    659d:	e8 3e 03 00 00       	call   68e0 <fwp_rc_share>
    65a2:	49 8b 1e             	mov    (%r14),%rbx
    65a5:	49 8b 46 08          	mov    0x8(%r14),%rax
    65a9:	4d 8b 7e 10          	mov    0x10(%r14),%r15
    65ad:	49 8b 0f             	mov    (%r15),%rcx
    65b0:	48 8d 14 4d 00 00 00 	lea    0x0(,%rcx,2),%rdx
    65b7:	00 
    65b8:	48 85 d2             	test   %rdx,%rdx
    65bb:	0f 84 cd 00 00 00    	je     668e <e15+0x10e>
    65c1:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
    65c8:	ff ff 7f 
    65cb:	4d 8d 6f 08          	lea    0x8(%r15),%r13
    65cf:	31 ed                	xor    %ebp,%ebp
    65d1:	49 89 e6             	mov    %rsp,%r14
    65d4:	eb 44                	jmp    661a <e15+0x9a>
    65d6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    65dd:	00 00 00 
    65e0:	0f b7 0c 0e          	movzwl (%rsi,%rcx,1),%ecx
    65e4:	83 f8 01             	cmp    $0x1,%eax
    65e7:	48 0f bf c1          	movswq %cx,%rax
    65eb:	48 0f 45 c1          	cmovne %rcx,%rax
    65ef:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    65f4:	48 89 df             	mov    %rbx,%rdi
    65f7:	be 02 00 00 00       	mov    $0x2,%esi
    65fc:	4c 89 f2             	mov    %r14,%rdx
    65ff:	b9 01 00 00 00       	mov    $0x1,%ecx
    6604:	e8 67 09 00 00       	call   6f70 <fwp_apply_borrowed_prefix>
    6609:	48 ff c5             	inc    %rbp
    660c:	49 8b 0f             	mov    (%r15),%rcx
    660f:	48 89 ca             	mov    %rcx,%rdx
    6612:	4c 21 e2             	and    %r12,%rdx
    6615:	48 39 d5             	cmp    %rdx,%rbp
    6618:	73 74                	jae    668e <e15+0x10e>
    661a:	48 89 04 24          	mov    %rax,(%rsp)
    661e:	8b 05 8c 56 01 00    	mov    0x1568c(%rip),%eax        # 1bcb0 <d1>
    6624:	ba 08 00 00 00       	mov    $0x8,%edx
    6629:	48 83 f8 0a          	cmp    $0xa,%rax
    662d:	77 0b                	ja     663a <e15+0xba>
    662f:	48 8d 15 ba f2 00 00 	lea    0xf2ba(%rip),%rdx        # 158f0 <exec_in_fp0+0x80>
    6636:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
    663a:	4c 89 ee             	mov    %r13,%rsi
    663d:	48 85 c9             	test   %rcx,%rcx
    6640:	79 04                	jns    6646 <e15+0xc6>
    6642:	49 8b 77 10          	mov    0x10(%r15),%rsi
    6646:	48 89 d1             	mov    %rdx,%rcx
    6649:	48 0f af cd          	imul   %rbp,%rcx
    664d:	48 83 fa 01          	cmp    $0x1,%rdx
    6651:	74 1d                	je     6670 <e15+0xf0>
    6653:	48 83 fa 02          	cmp    $0x2,%rdx
    6657:	74 87                	je     65e0 <e15+0x60>
    6659:	48 83 fa 08          	cmp    $0x8,%rdx
    665d:	75 21                	jne    6680 <e15+0x100>
    665f:	48 8b 04 0e          	mov    (%rsi,%rcx,1),%rax
    6663:	eb 8a                	jmp    65ef <e15+0x6f>
    6665:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    666c:	00 00 00 00 
    6670:	0f b6 0c 0e          	movzbl (%rsi,%rcx,1),%ecx
    6674:	48 85 c0             	test   %rax,%rax
    6677:	48 0f be c1          	movsbq %cl,%rax
    667b:	e9 6b ff ff ff       	jmp    65eb <e15+0x6b>
    6680:	8b 0c 0e             	mov    (%rsi,%rcx,1),%ecx
    6683:	83 f8 02             	cmp    $0x2,%eax
    6686:	48 63 c1             	movslq %ecx,%rax
    6689:	e9 5d ff ff ff       	jmp    65eb <e15+0x6b>
    668e:	48 89 c7             	mov    %rax,%rdi
    6691:	48 89 c3             	mov    %rax,%rbx
    6694:	e8 47 02 00 00       	call   68e0 <fwp_rc_share>
    6699:	48 89 d8             	mov    %rbx,%rax
    669c:	48 83 c4 18          	add    $0x18,%rsp
    66a0:	5b                   	pop    %rbx
    66a1:	41 5c                	pop    %r12
    66a3:	41 5d                	pop    %r13
    66a5:	41 5e                	pop    %r14
    66a7:	41 5f                	pop    %r15
    66a9:	5d                   	pop    %rbp
    66aa:	c3                   	ret
    66ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000066b0 <e17>:
    66b0:	53                   	push   %rbx
    66b1:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    66b5:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    66ba:	0f 58 c8             	addps  %xmm0,%xmm1
    66bd:	66 0f 7e cb          	movd   %xmm1,%ebx
    66c1:	48 89 df             	mov    %rbx,%rdi
    66c4:	e8 17 02 00 00       	call   68e0 <fwp_rc_share>
    66c9:	48 89 d8             	mov    %rbx,%rax
    66cc:	5b                   	pop    %rbx
    66cd:	c3                   	ret
    66ce:	66 90                	xchg   %ax,%ax

00000000000066d0 <e18>:
    66d0:	53                   	push   %rbx
    66d1:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    66d5:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    66da:	0f 59 c8             	mulps  %xmm0,%xmm1
    66dd:	66 0f 7e cb          	movd   %xmm1,%ebx
    66e1:	48 89 df             	mov    %rbx,%rdi
    66e4:	e8 f7 01 00 00       	call   68e0 <fwp_rc_share>
    66e9:	48 89 d8             	mov    %rbx,%rax
    66ec:	5b                   	pop    %rbx
    66ed:	c3                   	ret
    66ee:	66 90                	xchg   %ax,%ax

00000000000066f0 <e19>:
    66f0:	53                   	push   %rbx
    66f1:	48 89 fb             	mov    %rdi,%rbx
    66f4:	48 8b 3f             	mov    (%rdi),%rdi
    66f7:	e8 e4 01 00 00       	call   68e0 <fwp_rc_share>
    66fc:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    6700:	e8 db 01 00 00       	call   68e0 <fwp_rc_share>
    6705:	48 8b 3b             	mov    (%rbx),%rdi
    6708:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    670c:	48 8d 0d 6d 56 01 00 	lea    0x1566d(%rip),%rcx        # 1bd80 <d2>
    6713:	48 89 ca             	mov    %rcx,%rdx
    6716:	e8 e5 05 00 00       	call   6d00 <fwp_p_array_map_typed>
    671b:	48 89 c3             	mov    %rax,%rbx
    671e:	48 89 c7             	mov    %rax,%rdi
    6721:	e8 ba 01 00 00       	call   68e0 <fwp_rc_share>
    6726:	48 89 d8             	mov    %rbx,%rax
    6729:	5b                   	pop    %rbx
    672a:	c3                   	ret
    672b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006730 <e20>:
    6730:	53                   	push   %rbx
    6731:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    6735:	f2 0f 59 47 08       	mulsd  0x8(%rdi),%xmm0
    673a:	66 48 0f 7e c3       	movq   %xmm0,%rbx
    673f:	48 89 df             	mov    %rbx,%rdi
    6742:	e8 99 01 00 00       	call   68e0 <fwp_rc_share>
    6747:	48 89 d8             	mov    %rbx,%rax
    674a:	5b                   	pop    %rbx
    674b:	c3                   	ret
    674c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000006750 <e21>:
    6750:	53                   	push   %rbx
    6751:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    6755:	f2 0f 58 47 08       	addsd  0x8(%rdi),%xmm0
    675a:	66 48 0f 7e c3       	movq   %xmm0,%rbx
    675f:	48 89 df             	mov    %rbx,%rdi
    6762:	e8 79 01 00 00       	call   68e0 <fwp_rc_share>
    6767:	48 89 d8             	mov    %rbx,%rax
    676a:	5b                   	pop    %rbx
    676b:	c3                   	ret
    676c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000006770 <e23>:
    6770:	55                   	push   %rbp
    6771:	41 57                	push   %r15
    6773:	41 56                	push   %r14
    6775:	41 55                	push   %r13
    6777:	41 54                	push   %r12
    6779:	53                   	push   %rbx
    677a:	48 83 ec 18          	sub    $0x18,%rsp
    677e:	49 89 fe             	mov    %rdi,%r14
    6781:	48 8b 3f             	mov    (%rdi),%rdi
    6784:	e8 57 01 00 00       	call   68e0 <fwp_rc_share>
    6789:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    678d:	e8 4e 01 00 00       	call   68e0 <fwp_rc_share>
    6792:	49 8b 1e             	mov    (%r14),%rbx
    6795:	49 8b 46 08          	mov    0x8(%r14),%rax
    6799:	4d 8b 7e 10          	mov    0x10(%r14),%r15
    679d:	49 8b 0f             	mov    (%r15),%rcx
    67a0:	48 8d 14 4d 00 00 00 	lea    0x0(,%rcx,2),%rdx
    67a7:	00 
    67a8:	48 85 d2             	test   %rdx,%rdx
    67ab:	0f 84 cd 00 00 00    	je     687e <e23+0x10e>
    67b1:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
    67b8:	ff ff 7f 
    67bb:	4d 8d 6f 08          	lea    0x8(%r15),%r13
    67bf:	31 ed                	xor    %ebp,%ebp
    67c1:	49 89 e6             	mov    %rsp,%r14
    67c4:	eb 44                	jmp    680a <e23+0x9a>
    67c6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    67cd:	00 00 00 
    67d0:	0f b7 0c 0e          	movzwl (%rsi,%rcx,1),%ecx
    67d4:	83 f8 01             	cmp    $0x1,%eax
    67d7:	48 0f bf c1          	movswq %cx,%rax
    67db:	48 0f 45 c1          	cmovne %rcx,%rax
    67df:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    67e4:	48 89 df             	mov    %rbx,%rdi
    67e7:	be 02 00 00 00       	mov    $0x2,%esi
    67ec:	4c 89 f2             	mov    %r14,%rdx
    67ef:	b9 01 00 00 00       	mov    $0x1,%ecx
    67f4:	e8 77 07 00 00       	call   6f70 <fwp_apply_borrowed_prefix>
    67f9:	48 ff c5             	inc    %rbp
    67fc:	49 8b 0f             	mov    (%r15),%rcx
    67ff:	48 89 ca             	mov    %rcx,%rdx
    6802:	4c 21 e2             	and    %r12,%rdx
    6805:	48 39 d5             	cmp    %rdx,%rbp
    6808:	73 74                	jae    687e <e23+0x10e>
    680a:	48 89 04 24          	mov    %rax,(%rsp)
    680e:	8b 05 6c 55 01 00    	mov    0x1556c(%rip),%eax        # 1bd80 <d2>
    6814:	ba 08 00 00 00       	mov    $0x8,%edx
    6819:	48 83 f8 0a          	cmp    $0xa,%rax
    681d:	77 0b                	ja     682a <e23+0xba>
    681f:	48 8d 15 ca f0 00 00 	lea    0xf0ca(%rip),%rdx        # 158f0 <exec_in_fp0+0x80>
    6826:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
    682a:	4c 89 ee             	mov    %r13,%rsi
    682d:	48 85 c9             	test   %rcx,%rcx
    6830:	79 04                	jns    6836 <e23+0xc6>
    6832:	49 8b 77 10          	mov    0x10(%r15),%rsi
    6836:	48 89 d1             	mov    %rdx,%rcx
    6839:	48 0f af cd          	imul   %rbp,%rcx
    683d:	48 83 fa 01          	cmp    $0x1,%rdx
    6841:	74 1d                	je     6860 <e23+0xf0>
    6843:	48 83 fa 02          	cmp    $0x2,%rdx
    6847:	74 87                	je     67d0 <e23+0x60>
    6849:	48 83 fa 08          	cmp    $0x8,%rdx
    684d:	75 21                	jne    6870 <e23+0x100>
    684f:	48 8b 04 0e          	mov    (%rsi,%rcx,1),%rax
    6853:	eb 8a                	jmp    67df <e23+0x6f>
    6855:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    685c:	00 00 00 00 
    6860:	0f b6 0c 0e          	movzbl (%rsi,%rcx,1),%ecx
    6864:	48 85 c0             	test   %rax,%rax
    6867:	48 0f be c1          	movsbq %cl,%rax
    686b:	e9 6b ff ff ff       	jmp    67db <e23+0x6b>
    6870:	8b 0c 0e             	mov    (%rsi,%rcx,1),%ecx
    6873:	83 f8 02             	cmp    $0x2,%eax
    6876:	48 63 c1             	movslq %ecx,%rax
    6879:	e9 5d ff ff ff       	jmp    67db <e23+0x6b>
    687e:	48 89 c7             	mov    %rax,%rdi
    6881:	48 89 c3             	mov    %rax,%rbx
    6884:	e8 57 00 00 00       	call   68e0 <fwp_rc_share>
    6889:	48 89 d8             	mov    %rbx,%rax
    688c:	48 83 c4 18          	add    $0x18,%rsp
    6890:	5b                   	pop    %rbx
    6891:	41 5c                	pop    %r12
    6893:	41 5d                	pop    %r13
    6895:	41 5e                	pop    %r14
    6897:	41 5f                	pop    %r15
    6899:	5d                   	pop    %rbp
    689a:	c3                   	ret
    689b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000068a0 <e25>:
    68a0:	53                   	push   %rbx
    68a1:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    68a5:	f2 0f 58 47 08       	addsd  0x8(%rdi),%xmm0
    68aa:	66 48 0f 7e c3       	movq   %xmm0,%rbx
    68af:	48 89 df             	mov    %rbx,%rdi
    68b2:	e8 29 00 00 00       	call   68e0 <fwp_rc_share>
    68b7:	48 89 d8             	mov    %rbx,%rax
    68ba:	5b                   	pop    %rbx
    68bb:	c3                   	ret
    68bc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000068c0 <e26>:
    68c0:	53                   	push   %rbx
    68c1:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    68c5:	f2 0f 59 47 08       	mulsd  0x8(%rdi),%xmm0
    68ca:	66 48 0f 7e c3       	movq   %xmm0,%rbx
    68cf:	48 89 df             	mov    %rbx,%rdi
    68d2:	e8 09 00 00 00       	call   68e0 <fwp_rc_share>
    68d7:	48 89 d8             	mov    %rbx,%rax
    68da:	5b                   	pop    %rbx
    68db:	c3                   	ret
    68dc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000068e0 <fwp_rc_share>:
    68e0:	48 89 f8             	mov    %rdi,%rax
    68e3:	48 2b 05 ce 49 01 00 	sub    0x149ce(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    68ea:	48 8b 0d ef 49 01 00 	mov    0x149ef(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    68f1:	48 c1 e1 10          	shl    $0x10,%rcx
    68f5:	48 39 c8             	cmp    %rcx,%rax
    68f8:	0f 83 f9 01 00 00    	jae    6af7 <fwp_rc_share+0x217>
    68fe:	41 57                	push   %r15
    6900:	41 56                	push   %r14
    6902:	41 55                	push   %r13
    6904:	41 54                	push   %r12
    6906:	53                   	push   %rbx
    6907:	48 81 ec 00 02 00 00 	sub    $0x200,%rsp
    690e:	48 8b 0d eb 49 01 00 	mov    0x149eb(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    6915:	48 89 c2             	mov    %rax,%rdx
    6918:	48 c1 ea 10          	shr    $0x10,%rdx
    691c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6923:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6927:	48 25 ff ff 00 00    	and    $0xffff,%rax
    692d:	75 13                	jne    6942 <fwp_rc_share+0x62>
    692f:	40 80 fe 02          	cmp    $0x2,%sil
    6933:	75 0d                	jne    6942 <fwp_rc_share+0x62>
    6935:	48 8d 1c 11          	lea    (%rcx,%rdx,1),%rbx
    6939:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    6940:	eb 25                	jmp    6967 <fwp_rc_share+0x87>
    6942:	40 80 fe 01          	cmp    $0x1,%sil
    6946:	0f 85 9b 01 00 00    	jne    6ae7 <fwp_rc_share+0x207>
    694c:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6950:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6954:	48 0f af c1          	imul   %rcx,%rax
    6958:	48 c1 e8 20          	shr    $0x20,%rax
    695c:	48 8d 1c 30          	lea    (%rax,%rsi,1),%rbx
    6960:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    6967:	0f b6 03             	movzbl (%rbx),%eax
    696a:	84 c0                	test   %al,%al
    696c:	0f 84 75 01 00 00    	je     6ae7 <fwp_rc_share+0x207>
    6972:	3c ff                	cmp    $0xff,%al
    6974:	0f 84 7e 01 00 00    	je     6af8 <fwp_rc_share+0x218>
    697a:	c6 03 00             	movb   $0x0,(%rbx)
    697d:	48 89 3c 24          	mov    %rdi,(%rsp)
    6981:	41 be 01 00 00 00    	mov    $0x1,%r14d
    6987:	eb 10                	jmp    6999 <fwp_rc_share+0xb9>
    6989:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    6990:	4d 85 f6             	test   %r14,%r14
    6993:	0f 84 4e 01 00 00    	je     6ae7 <fwp_rc_share+0x207>
    6999:	4e 8b 7c f4 f8       	mov    -0x8(%rsp,%r14,8),%r15
    699e:	49 ff ce             	dec    %r14
    69a1:	48 8b 05 10 49 01 00 	mov    0x14910(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    69a8:	4c 89 f9             	mov    %r15,%rcx
    69ab:	48 29 c1             	sub    %rax,%rcx
    69ae:	48 89 ce             	mov    %rcx,%rsi
    69b1:	48 c1 ee 10          	shr    $0x10,%rsi
    69b5:	48 8b 15 44 49 01 00 	mov    0x14944(%rip),%rdx        # 1b300 <fwp_gc+0x1078>
    69bc:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    69c3:	80 7c 32 01 01       	cmpb   $0x1,0x1(%rdx,%rsi,1)
    69c8:	74 c6                	je     6990 <fwp_rc_share+0xb0>
    69ca:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    69ce:	40 80 ff 02          	cmp    $0x2,%dil
    69d2:	75 0c                	jne    69e0 <fwp_rc_share+0x100>
    69d4:	4c 8b 64 32 18       	mov    0x18(%rdx,%rsi,1),%r12
    69d9:	eb 32                	jmp    6a0d <fwp_rc_share+0x12d>
    69db:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    69e0:	44 8b 64 32 08       	mov    0x8(%rdx,%rsi,1),%r12d
    69e5:	40 80 ff 01          	cmp    $0x1,%dil
    69e9:	75 22                	jne    6a0d <fwp_rc_share+0x12d>
    69eb:	41 0f b7 ff          	movzwl %r15w,%edi
    69ef:	44 8b 7c 32 20       	mov    0x20(%rdx,%rsi,1),%r15d
    69f4:	4c 0f af ff          	imul   %rdi,%r15
    69f8:	49 c1 ef 20          	shr    $0x20,%r15
    69fc:	48 81 e1 00 00 ff ff 	and    $0xffffffffffff0000,%rcx
    6a03:	48 01 c8             	add    %rcx,%rax
    6a06:	4d 0f af fc          	imul   %r12,%r15
    6a0a:	49 01 c7             	add    %rax,%r15
    6a0d:	49 83 fc 08          	cmp    $0x8,%r12
    6a11:	0f 82 79 ff ff ff    	jb     6990 <fwp_rc_share+0xb0>
    6a17:	49 c1 ec 03          	shr    $0x3,%r12
    6a1b:	45 31 ed             	xor    %r13d,%r13d
    6a1e:	eb 1c                	jmp    6a3c <fwp_rc_share+0x15c>
    6a20:	e8 bb fe ff ff       	call   68e0 <fwp_rc_share>
    6a25:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    6a2c:	00 00 00 00 
    6a30:	49 ff c5             	inc    %r13
    6a33:	4d 39 ec             	cmp    %r13,%r12
    6a36:	0f 84 54 ff ff ff    	je     6990 <fwp_rc_share+0xb0>
    6a3c:	4b 8b 3c ef          	mov    (%r15,%r13,8),%rdi
    6a40:	48 89 f8             	mov    %rdi,%rax
    6a43:	48 2b 05 6e 48 01 00 	sub    0x1486e(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    6a4a:	48 8b 0d 8f 48 01 00 	mov    0x1488f(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    6a51:	48 c1 e1 10          	shl    $0x10,%rcx
    6a55:	48 39 c8             	cmp    %rcx,%rax
    6a58:	73 d6                	jae    6a30 <fwp_rc_share+0x150>
    6a5a:	48 8b 0d 9f 48 01 00 	mov    0x1489f(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    6a61:	48 89 c2             	mov    %rax,%rdx
    6a64:	48 c1 ea 10          	shr    $0x10,%rdx
    6a68:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6a6f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6a73:	48 25 ff ff 00 00    	and    $0xffff,%rax
    6a79:	75 15                	jne    6a90 <fwp_rc_share+0x1b0>
    6a7b:	40 80 fe 02          	cmp    $0x2,%sil
    6a7f:	75 0f                	jne    6a90 <fwp_rc_share+0x1b0>
    6a81:	48 8d 1c 11          	lea    (%rcx,%rdx,1),%rbx
    6a85:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    6a8c:	eb 23                	jmp    6ab1 <fwp_rc_share+0x1d1>
    6a8e:	66 90                	xchg   %ax,%ax
    6a90:	40 80 fe 01          	cmp    $0x1,%sil
    6a94:	75 9a                	jne    6a30 <fwp_rc_share+0x150>
    6a96:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6a9a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6a9e:	48 0f af c1          	imul   %rcx,%rax
    6aa2:	48 c1 e8 20          	shr    $0x20,%rax
    6aa6:	48 8d 1c 30          	lea    (%rax,%rsi,1),%rbx
    6aaa:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    6ab1:	0f b6 03             	movzbl (%rbx),%eax
    6ab4:	84 c0                	test   %al,%al
    6ab6:	0f 84 74 ff ff ff    	je     6a30 <fwp_rc_share+0x150>
    6abc:	49 83 fe 3f          	cmp    $0x3f,%r14
    6ac0:	0f 87 5a ff ff ff    	ja     6a20 <fwp_rc_share+0x140>
    6ac6:	3c ff                	cmp    $0xff,%al
    6ac8:	74 13                	je     6add <fwp_rc_share+0x1fd>
    6aca:	c6 03 00             	movb   $0x0,(%rbx)
    6acd:	4b 8b 04 ef          	mov    (%r15,%r13,8),%rax
    6ad1:	4a 89 04 f4          	mov    %rax,(%rsp,%r14,8)
    6ad5:	49 ff c6             	inc    %r14
    6ad8:	e9 53 ff ff ff       	jmp    6a30 <fwp_rc_share+0x150>
    6add:	48 89 df             	mov    %rbx,%rdi
    6ae0:	e8 2b 00 00 00       	call   6b10 <fwp_rc_forget_slot>
    6ae5:	eb e3                	jmp    6aca <fwp_rc_share+0x1ea>
    6ae7:	48 81 c4 00 02 00 00 	add    $0x200,%rsp
    6aee:	5b                   	pop    %rbx
    6aef:	41 5c                	pop    %r12
    6af1:	41 5d                	pop    %r13
    6af3:	41 5e                	pop    %r14
    6af5:	41 5f                	pop    %r15
    6af7:	c3                   	ret
    6af8:	49 89 fe             	mov    %rdi,%r14
    6afb:	48 89 df             	mov    %rbx,%rdi
    6afe:	e8 0d 00 00 00       	call   6b10 <fwp_rc_forget_slot>
    6b03:	4c 89 f7             	mov    %r14,%rdi
    6b06:	e9 6f fe ff ff       	jmp    697a <fwp_rc_share+0x9a>
    6b0b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006b10 <fwp_rc_forget_slot>:
    6b10:	50                   	push   %rax
    6b11:	80 3f ff             	cmpb   $0xff,(%rdi)
    6b14:	74 02                	je     6b18 <fwp_rc_forget_slot+0x8>
    6b16:	58                   	pop    %rax
    6b17:	c3                   	ret
    6b18:	48 89 f8             	mov    %rdi,%rax
    6b1b:	48 c1 e8 11          	shr    $0x11,%rax
    6b1f:	31 f8                	xor    %edi,%eax
    6b21:	89 c1                	mov    %eax,%ecx
    6b23:	c1 e9 09             	shr    $0x9,%ecx
    6b26:	31 c1                	xor    %eax,%ecx
    6b28:	0f b6 c9             	movzbl %cl,%ecx
    6b2b:	48 8d 15 56 37 01 00 	lea    0x13756(%rip),%rdx        # 1a288 <fwp_gc>
    6b32:	48 8b 84 ca 18 12 00 	mov    0x1218(%rdx,%rcx,8),%rax
    6b39:	00 
    6b3a:	48 85 c0             	test   %rax,%rax
    6b3d:	74 4b                	je     6b8a <fwp_rc_forget_slot+0x7a>
    6b3f:	48 39 38             	cmp    %rdi,(%rax)
    6b42:	74 23                	je     6b67 <fwp_rc_forget_slot+0x57>
    6b44:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    6b4b:	00 00 00 00 00 
    6b50:	48 89 c1             	mov    %rax,%rcx
    6b53:	48 8b 40 10          	mov    0x10(%rax),%rax
    6b57:	48 85 c0             	test   %rax,%rax
    6b5a:	74 2e                	je     6b8a <fwp_rc_forget_slot+0x7a>
    6b5c:	48 39 38             	cmp    %rdi,(%rax)
    6b5f:	75 ef                	jne    6b50 <fwp_rc_forget_slot+0x40>
    6b61:	48 83 c1 10          	add    $0x10,%rcx
    6b65:	eb 0b                	jmp    6b72 <fwp_rc_forget_slot+0x62>
    6b67:	48 8d 0c ca          	lea    (%rdx,%rcx,8),%rcx
    6b6b:	48 81 c1 18 12 00 00 	add    $0x1218,%rcx
    6b72:	48 8b 50 10          	mov    0x10(%rax),%rdx
    6b76:	48 89 11             	mov    %rdx,(%rcx)
    6b79:	48 89 c7             	mov    %rax,%rdi
    6b7c:	e8 cf c4 ff ff       	call   3050 <free@plt>
    6b81:	48 ff 0d 18 51 01 00 	decq   0x15118(%rip)        # 1bca0 <fwp_gc+0x1a18>
    6b88:	58                   	pop    %rax
    6b89:	c3                   	ret
    6b8a:	e8 31 00 00 00       	call   6bc0 <fwp_flush>
    6b8f:	48 8b 05 42 34 01 00 	mov    0x13442(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    6b96:	48 8b 38             	mov    (%rax),%rdi
    6b99:	48 8d 35 ea ee 00 00 	lea    0xeeea(%rip),%rsi        # 15a8a <exec_in_fp0+0x21a>
    6ba0:	48 8d 15 bc ee 00 00 	lea    0xeebc(%rip),%rdx        # 15a63 <exec_in_fp0+0x1f3>
    6ba7:	31 c0                	xor    %eax,%eax
    6ba9:	e8 42 c7 ff ff       	call   32f0 <fprintf@plt>
    6bae:	bf 65 00 00 00       	mov    $0x65,%edi
    6bb3:	e8 a8 c8 ff ff       	call   3460 <exit@plt>
    6bb8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6bbf:	00 

0000000000006bc0 <fwp_flush>:
    6bc0:	50                   	push   %rax
    6bc1:	48 8b 3d b0 52 01 00 	mov    0x152b0(%rip),%rdi        # 1be78 <fwp_prog_out>
    6bc8:	48 85 ff             	test   %rdi,%rdi
    6bcb:	74 05                	je     6bd2 <fwp_flush+0x12>
    6bcd:	e8 7e c7 ff ff       	call   3350 <fflush@plt>
    6bd2:	48 8b 05 d7 33 01 00 	mov    0x133d7(%rip),%rax        # 19fb0 <stdout@GLIBC_2.2.5>
    6bd9:	48 8b 38             	mov    (%rax),%rdi
    6bdc:	58                   	pop    %rax
    6bdd:	e9 6e c7 ff ff       	jmp    3350 <fflush@plt>
    6be2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6be9:	1f 84 00 00 00 00 00 

0000000000006bf0 <fwp_owner_release3>:
    6bf0:	48 8b 3f             	mov    (%rdi),%rdi
    6bf3:	eb 0b                	jmp    6c00 <fwp_drop1>
    6bf5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    6bfc:	00 00 00 00 

0000000000006c00 <fwp_drop1>:
    6c00:	53                   	push   %rbx
    6c01:	48 89 f8             	mov    %rdi,%rax
    6c04:	48 2b 05 ad 46 01 00 	sub    0x146ad(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    6c0b:	48 8b 0d ce 46 01 00 	mov    0x146ce(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    6c12:	48 c1 e1 10          	shl    $0x10,%rcx
    6c16:	48 39 c8             	cmp    %rcx,%rax
    6c19:	0f 83 9c 00 00 00    	jae    6cbb <fwp_drop1+0xbb>
    6c1f:	48 8b 0d da 46 01 00 	mov    0x146da(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    6c26:	48 89 c2             	mov    %rax,%rdx
    6c29:	48 c1 ea 10          	shr    $0x10,%rdx
    6c2d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6c34:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6c38:	48 25 ff ff 00 00    	and    $0xffff,%rax
    6c3e:	75 20                	jne    6c60 <fwp_drop1+0x60>
    6c40:	40 80 fe 02          	cmp    $0x2,%sil
    6c44:	75 1a                	jne    6c60 <fwp_drop1+0x60>
    6c46:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    6c4a:	48 05 28 02 00 00    	add    $0x228,%rax
    6c50:	eb 2d                	jmp    6c7f <fwp_drop1+0x7f>
    6c52:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6c59:	1f 84 00 00 00 00 00 
    6c60:	40 80 fe 01          	cmp    $0x1,%sil
    6c64:	75 55                	jne    6cbb <fwp_drop1+0xbb>
    6c66:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6c6a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6c6e:	48 0f af c1          	imul   %rcx,%rax
    6c72:	48 c1 e8 20          	shr    $0x20,%rax
    6c76:	48 01 f0             	add    %rsi,%rax
    6c79:	48 05 28 02 00 00    	add    $0x228,%rax
    6c7f:	0f b6 08             	movzbl (%rax),%ecx
    6c82:	85 c9                	test   %ecx,%ecx
    6c84:	74 35                	je     6cbb <fwp_drop1+0xbb>
    6c86:	83 f9 01             	cmp    $0x1,%ecx
    6c89:	75 32                	jne    6cbd <fwp_drop1+0xbd>
    6c8b:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    6c8f:	79 3a                	jns    6ccb <fwp_drop1+0xcb>
    6c91:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    6c95:	e8 96 40 00 00       	call   ad30 <fwp_rc_free_arr>
    6c9a:	48 89 d8             	mov    %rbx,%rax
    6c9d:	48 2b 05 14 46 01 00 	sub    0x14614(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    6ca4:	48 8b 0d 35 46 01 00 	mov    0x14635(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    6cab:	48 c1 e1 10          	shl    $0x10,%rcx
    6caf:	48 89 df             	mov    %rbx,%rdi
    6cb2:	48 39 c8             	cmp    %rcx,%rax
    6cb5:	0f 82 64 ff ff ff    	jb     6c1f <fwp_drop1+0x1f>
    6cbb:	5b                   	pop    %rbx
    6cbc:	c3                   	ret
    6cbd:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    6cc3:	74 0c                	je     6cd1 <fwp_drop1+0xd1>
    6cc5:	fe c9                	dec    %cl
    6cc7:	88 08                	mov    %cl,(%rax)
    6cc9:	5b                   	pop    %rbx
    6cca:	c3                   	ret
    6ccb:	5b                   	pop    %rbx
    6ccc:	e9 5f 40 00 00       	jmp    ad30 <fwp_rc_free_arr>
    6cd1:	48 89 c7             	mov    %rax,%rdi
    6cd4:	5b                   	pop    %rbx
    6cd5:	e9 d6 38 00 00       	jmp    a5b0 <fwp_rc_wide_drop>
    6cda:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000006ce0 <fwp_owner_release4>:
    6ce0:	48 8b 3f             	mov    (%rdi),%rdi
    6ce3:	e9 18 ff ff ff       	jmp    6c00 <fwp_drop1>
    6ce8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6cef:	00 

0000000000006cf0 <fwp_owner_release5>:
    6cf0:	48 8b 3f             	mov    (%rdi),%rdi
    6cf3:	e9 08 ff ff ff       	jmp    6c00 <fwp_drop1>
    6cf8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6cff:	00 

0000000000006d00 <fwp_p_array_map_typed>:
    6d00:	55                   	push   %rbp
    6d01:	41 57                	push   %r15
    6d03:	41 56                	push   %r14
    6d05:	41 55                	push   %r13
    6d07:	41 54                	push   %r12
    6d09:	53                   	push   %rbx
    6d0a:	48 83 ec 18          	sub    $0x18,%rsp
    6d0e:	48 89 3c 24          	mov    %rdi,(%rsp)
    6d12:	49 bf ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r15
    6d19:	ff ff 7f 
    6d1c:	4c 23 3e             	and    (%rsi),%r15
    6d1f:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    6d26:	ff ff 1f 
    6d29:	49 39 c7             	cmp    %rax,%r15
    6d2c:	0f 83 16 02 00 00    	jae    6f48 <fwp_p_array_map_typed+0x248>
    6d32:	49 89 ce             	mov    %rcx,%r14
    6d35:	49 89 d4             	mov    %rdx,%r12
    6d38:	48 89 f3             	mov    %rsi,%rbx
    6d3b:	4c 89 ff             	mov    %r15,%rdi
    6d3e:	48 89 d6             	mov    %rdx,%rsi
    6d41:	e8 ba ea ff ff       	call   5800 <fwp_array_new_packed>
    6d46:	48 89 c5             	mov    %rax,%rbp
    6d49:	48 2b 05 68 45 01 00 	sub    0x14568(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    6d50:	48 8b 0d 89 45 01 00 	mov    0x14589(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    6d57:	48 c1 e1 10          	shl    $0x10,%rcx
    6d5b:	48 39 c8             	cmp    %rcx,%rax
    6d5e:	73 72                	jae    6dd2 <fwp_p_array_map_typed+0xd2>
    6d60:	48 8b 0d 99 45 01 00 	mov    0x14599(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    6d67:	48 89 c2             	mov    %rax,%rdx
    6d6a:	48 c1 ea 10          	shr    $0x10,%rdx
    6d6e:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6d75:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6d79:	48 25 ff ff 00 00    	and    $0xffff,%rax
    6d7f:	75 1f                	jne    6da0 <fwp_p_array_map_typed+0xa0>
    6d81:	40 80 fe 02          	cmp    $0x2,%sil
    6d85:	75 19                	jne    6da0 <fwp_p_array_map_typed+0xa0>
    6d87:	4c 8d 2c 11          	lea    (%rcx,%rdx,1),%r13
    6d8b:	49 81 c5 28 02 00 00 	add    $0x228,%r13
    6d92:	41 80 7d 00 ff       	cmpb   $0xff,0x0(%r13)
    6d97:	74 2f                	je     6dc8 <fwp_p_array_map_typed+0xc8>
    6d99:	41 c6 45 00 01       	movb   $0x1,0x0(%r13)
    6d9e:	eb 32                	jmp    6dd2 <fwp_p_array_map_typed+0xd2>
    6da0:	40 80 fe 01          	cmp    $0x1,%sil
    6da4:	75 2c                	jne    6dd2 <fwp_p_array_map_typed+0xd2>
    6da6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6daa:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6dae:	48 0f af c1          	imul   %rcx,%rax
    6db2:	48 c1 e8 20          	shr    $0x20,%rax
    6db6:	4c 8d 2c 30          	lea    (%rax,%rsi,1),%r13
    6dba:	49 81 c5 28 02 00 00 	add    $0x228,%r13
    6dc1:	41 80 7d 00 ff       	cmpb   $0xff,0x0(%r13)
    6dc6:	75 d1                	jne    6d99 <fwp_p_array_map_typed+0x99>
    6dc8:	4c 89 ef             	mov    %r13,%rdi
    6dcb:	e8 40 fd ff ff       	call   6b10 <fwp_rc_forget_slot>
    6dd0:	eb c7                	jmp    6d99 <fwp_p_array_map_typed+0x99>
    6dd2:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
    6dd7:	4d 85 ff             	test   %r15,%r15
    6dda:	0f 84 24 01 00 00    	je     6f04 <fwp_p_array_map_typed+0x204>
    6de0:	4c 8d 7b 08          	lea    0x8(%rbx),%r15
    6de4:	45 31 ed             	xor    %r13d,%r13d
    6de7:	eb 1a                	jmp    6e03 <fwp_p_array_map_typed+0x103>
    6de9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    6df0:	4a 89 44 ed 08       	mov    %rax,0x8(%rbp,%r13,8)
    6df5:	49 ff c5             	inc    %r13
    6df8:	4c 39 6c 24 08       	cmp    %r13,0x8(%rsp)
    6dfd:	0f 84 01 01 00 00    	je     6f04 <fwp_p_array_map_typed+0x204>
    6e03:	b8 08 00 00 00       	mov    $0x8,%eax
    6e08:	4d 85 f6             	test   %r14,%r14
    6e0b:	74 14                	je     6e21 <fwp_p_array_map_typed+0x121>
    6e0d:	41 8b 0e             	mov    (%r14),%ecx
    6e10:	48 83 f9 0a          	cmp    $0xa,%rcx
    6e14:	77 0b                	ja     6e21 <fwp_p_array_map_typed+0x121>
    6e16:	48 8d 05 d3 ea 00 00 	lea    0xead3(%rip),%rax        # 158f0 <exec_in_fp0+0x80>
    6e1d:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    6e21:	48 83 3b 00          	cmpq   $0x0,(%rbx)
    6e25:	4c 89 f9             	mov    %r15,%rcx
    6e28:	79 04                	jns    6e2e <fwp_p_array_map_typed+0x12e>
    6e2a:	48 8b 4b 10          	mov    0x10(%rbx),%rcx
    6e2e:	48 89 c2             	mov    %rax,%rdx
    6e31:	49 0f af d5          	imul   %r13,%rdx
    6e35:	48 83 f8 01          	cmp    $0x1,%rax
    6e39:	74 25                	je     6e60 <fwp_p_array_map_typed+0x160>
    6e3b:	48 83 f8 02          	cmp    $0x2,%rax
    6e3f:	74 0f                	je     6e50 <fwp_p_array_map_typed+0x150>
    6e41:	48 83 f8 08          	cmp    $0x8,%rax
    6e45:	75 29                	jne    6e70 <fwp_p_array_map_typed+0x170>
    6e47:	48 8b 04 11          	mov    (%rcx,%rdx,1),%rax
    6e4b:	eb 31                	jmp    6e7e <fwp_p_array_map_typed+0x17e>
    6e4d:	0f 1f 00             	nopl   (%rax)
    6e50:	41 83 3e 01          	cmpl   $0x1,(%r14)
    6e54:	0f b7 0c 11          	movzwl (%rcx,%rdx,1),%ecx
    6e58:	48 0f bf c1          	movswq %cx,%rax
    6e5c:	eb 1c                	jmp    6e7a <fwp_p_array_map_typed+0x17a>
    6e5e:	66 90                	xchg   %ax,%ax
    6e60:	41 83 3e 00          	cmpl   $0x0,(%r14)
    6e64:	0f b6 0c 11          	movzbl (%rcx,%rdx,1),%ecx
    6e68:	48 0f be c1          	movsbq %cl,%rax
    6e6c:	eb 0c                	jmp    6e7a <fwp_p_array_map_typed+0x17a>
    6e6e:	66 90                	xchg   %ax,%ax
    6e70:	41 83 3e 02          	cmpl   $0x2,(%r14)
    6e74:	8b 0c 11             	mov    (%rcx,%rdx,1),%ecx
    6e77:	48 63 c1             	movslq %ecx,%rax
    6e7a:	48 0f 45 c1          	cmovne %rcx,%rax
    6e7e:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    6e83:	48 8b 3c 24          	mov    (%rsp),%rdi
    6e87:	be 01 00 00 00       	mov    $0x1,%esi
    6e8c:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    6e91:	31 c9                	xor    %ecx,%ecx
    6e93:	e8 d8 00 00 00       	call   6f70 <fwp_apply_borrowed_prefix>
    6e98:	48 83 7d 00 00       	cmpq   $0x0,0x0(%rbp)
    6e9d:	78 7b                	js     6f1a <fwp_p_array_map_typed+0x21a>
    6e9f:	4d 85 e4             	test   %r12,%r12
    6ea2:	0f 84 48 ff ff ff    	je     6df0 <fwp_p_array_map_typed+0xf0>
    6ea8:	41 8b 0c 24          	mov    (%r12),%ecx
    6eac:	83 f9 0a             	cmp    $0xa,%ecx
    6eaf:	0f 87 3b ff ff ff    	ja     6df0 <fwp_p_array_map_typed+0xf0>
    6eb5:	ba 84 04 00 00       	mov    $0x484,%edx
    6eba:	0f a3 ca             	bt     %ecx,%edx
    6ebd:	72 31                	jb     6ef0 <fwp_p_array_map_typed+0x1f0>
    6ebf:	ba 21 00 00 00       	mov    $0x21,%edx
    6ec4:	0f a3 ca             	bt     %ecx,%edx
    6ec7:	72 31                	jb     6efa <fwp_p_array_map_typed+0x1fa>
    6ec9:	ba 42 00 00 00       	mov    $0x42,%edx
    6ece:	0f a3 ca             	bt     %ecx,%edx
    6ed1:	0f 83 19 ff ff ff    	jae    6df0 <fwp_p_array_map_typed+0xf0>
    6ed7:	66 42 89 44 6d 08    	mov    %ax,0x8(%rbp,%r13,2)
    6edd:	e9 13 ff ff ff       	jmp    6df5 <fwp_p_array_map_typed+0xf5>
    6ee2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6ee9:	1f 84 00 00 00 00 00 
    6ef0:	42 89 44 ad 08       	mov    %eax,0x8(%rbp,%r13,4)
    6ef5:	e9 fb fe ff ff       	jmp    6df5 <fwp_p_array_map_typed+0xf5>
    6efa:	42 88 44 2d 08       	mov    %al,0x8(%rbp,%r13,1)
    6eff:	e9 f1 fe ff ff       	jmp    6df5 <fwp_p_array_map_typed+0xf5>
    6f04:	48 8b 04 24          	mov    (%rsp),%rax
    6f08:	48 89 e8             	mov    %rbp,%rax
    6f0b:	48 83 c4 18          	add    $0x18,%rsp
    6f0f:	5b                   	pop    %rbx
    6f10:	41 5c                	pop    %r12
    6f12:	41 5d                	pop    %r13
    6f14:	41 5e                	pop    %r14
    6f16:	41 5f                	pop    %r15
    6f18:	5d                   	pop    %rbp
    6f19:	c3                   	ret
    6f1a:	e8 a1 fc ff ff       	call   6bc0 <fwp_flush>
    6f1f:	48 8b 05 b2 30 01 00 	mov    0x130b2(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    6f26:	48 8b 38             	mov    (%rax),%rdi
    6f29:	48 8d 35 5a eb 00 00 	lea    0xeb5a(%rip),%rsi        # 15a8a <exec_in_fp0+0x21a>
    6f30:	48 8d 15 9b fa 00 00 	lea    0xfa9b(%rip),%rdx        # 169d2 <exec_in_fp0+0x1162>
    6f37:	31 c0                	xor    %eax,%eax
    6f39:	e8 b2 c3 ff ff       	call   32f0 <fprintf@plt>
    6f3e:	bf 65 00 00 00       	mov    $0x65,%edi
    6f43:	e8 18 c5 ff ff       	call   3460 <exit@plt>
    6f48:	e8 73 fc ff ff       	call   6bc0 <fwp_flush>
    6f4d:	48 8b 05 84 30 01 00 	mov    0x13084(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    6f54:	48 8b 38             	mov    (%rax),%rdi
    6f57:	48 8d 35 2c eb 00 00 	lea    0xeb2c(%rip),%rsi        # 15a8a <exec_in_fp0+0x21a>
    6f5e:	48 8d 15 34 eb 00 00 	lea    0xeb34(%rip),%rdx        # 15a99 <exec_in_fp0+0x229>
    6f65:	eb d0                	jmp    6f37 <fwp_p_array_map_typed+0x237>
    6f67:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    6f6e:	00 00 

0000000000006f70 <fwp_apply_borrowed_prefix>:
    6f70:	55                   	push   %rbp
    6f71:	41 57                	push   %r15
    6f73:	41 56                	push   %r14
    6f75:	41 55                	push   %r13
    6f77:	41 54                	push   %r12
    6f79:	53                   	push   %rbx
    6f7a:	48 81 ec a8 00 00 00 	sub    $0xa8,%rsp
    6f81:	41 89 cf             	mov    %ecx,%r15d
    6f84:	49 89 d5             	mov    %rdx,%r13
    6f87:	49 89 fe             	mov    %rdi,%r14
    6f8a:	4c 8b 25 df 4e 01 00 	mov    0x14edf(%rip),%r12        # 1be70 <fwp_fns>
    6f91:	8b 0f                	mov    (%rdi),%ecx
    6f93:	48 c1 e1 05          	shl    $0x5,%rcx
    6f97:	49 8b 44 0c 18       	mov    0x18(%r12,%rcx,1),%rax
    6f9c:	48 85 c0             	test   %rax,%rax
    6f9f:	0f 84 97 03 00 00    	je     733c <fwp_apply_borrowed_prefix+0x3cc>
    6fa5:	49 8d 2c 0c          	lea    (%r12,%rcx,1),%rbp
    6fa9:	48 83 c5 18          	add    $0x18,%rbp
    6fad:	49 01 cc             	add    %rcx,%r12
    6fb0:	31 c9                	xor    %ecx,%ecx
    6fb2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6fb9:	1f 84 00 00 00 00 00 
    6fc0:	f6 c1 01             	test   $0x1,%cl
    6fc3:	ba 00 00 00 00       	mov    $0x0,%edx
    6fc8:	49 0f 45 d6          	cmovne %r14,%rdx
    6fcc:	48 89 94 24 80 00 00 	mov    %rdx,0x80(%rsp)
    6fd3:	00 
    6fd4:	4c 89 ac 24 88 00 00 	mov    %r13,0x88(%rsp)
    6fdb:	00 
    6fdc:	48 89 84 24 90 00 00 	mov    %rax,0x90(%rsp)
    6fe3:	00 
    6fe4:	c7 84 24 98 00 00 00 	movl   $0x0,0x98(%rsp)
    6feb:	00 00 00 00 
    6fef:	41 8b 56 04          	mov    0x4(%r14),%edx
    6ff3:	89 94 24 9c 00 00 00 	mov    %edx,0x9c(%rsp)
    6ffa:	4c 89 f2             	mov    %r14,%rdx
    6ffd:	48 2b 15 b4 42 01 00 	sub    0x142b4(%rip),%rdx        # 1b2b8 <fwp_gc+0x1030>
    7004:	44 89 bc 24 a0 00 00 	mov    %r15d,0xa0(%rsp)
    700b:	00 
    700c:	4c 8b 1d cd 42 01 00 	mov    0x142cd(%rip),%r11        # 1b2e0 <fwp_gc+0x1058>
    7013:	49 c1 e3 10          	shl    $0x10,%r11
    7017:	4c 39 da             	cmp    %r11,%rdx
    701a:	73 74                	jae    7090 <fwp_apply_borrowed_prefix+0x120>
    701c:	48 8b 3d dd 42 01 00 	mov    0x142dd(%rip),%rdi        # 1b300 <fwp_gc+0x1078>
    7023:	49 89 d0             	mov    %rdx,%r8
    7026:	49 c1 e8 10          	shr    $0x10,%r8
    702a:	4d 69 c8 28 12 00 00 	imul   $0x1228,%r8,%r9
    7031:	46 0f b6 14 0f       	movzbl (%rdi,%r9,1),%r10d
    7036:	49 89 d0             	mov    %rdx,%r8
    7039:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    7040:	75 1e                	jne    7060 <fwp_apply_borrowed_prefix+0xf0>
    7042:	41 80 fa 02          	cmp    $0x2,%r10b
    7046:	75 18                	jne    7060 <fwp_apply_borrowed_prefix+0xf0>
    7048:	4c 01 cf             	add    %r9,%rdi
    704b:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    7052:	80 3f 00             	cmpb   $0x0,(%rdi)
    7055:	75 45                	jne    709c <fwp_apply_borrowed_prefix+0x12c>
    7057:	eb 37                	jmp    7090 <fwp_apply_borrowed_prefix+0x120>
    7059:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    7060:	41 80 fa 01          	cmp    $0x1,%r10b
    7064:	75 2a                	jne    7090 <fwp_apply_borrowed_prefix+0x120>
    7066:	4e 8d 14 0f          	lea    (%rdi,%r9,1),%r10
    706a:	42 8b 7c 0f 20       	mov    0x20(%rdi,%r9,1),%edi
    706f:	4c 0f af c7          	imul   %rdi,%r8
    7073:	49 c1 e8 20          	shr    $0x20,%r8
    7077:	4b 8d 3c 10          	lea    (%r8,%r10,1),%rdi
    707b:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    7082:	80 3f 00             	cmpb   $0x0,(%rdi)
    7085:	75 15                	jne    709c <fwp_apply_borrowed_prefix+0x12c>
    7087:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    708e:	00 00 
    7090:	45 85 ff             	test   %r15d,%r15d
    7093:	74 4b                	je     70e0 <fwp_apply_borrowed_prefix+0x170>
    7095:	48 83 78 18 00       	cmpq   $0x0,0x18(%rax)
    709a:	74 44                	je     70e0 <fwp_apply_borrowed_prefix+0x170>
    709c:	48 8b 3d 15 4e 01 00 	mov    0x14e15(%rip),%rdi        # 1beb8 <fwp_cleanups>
    70a3:	48 89 7c 24 68       	mov    %rdi,0x68(%rsp)
    70a8:	48 8d 3d 51 08 00 00 	lea    0x851(%rip),%rdi        # 7900 <fwp_apply_release>
    70af:	48 89 7c 24 70       	mov    %rdi,0x70(%rsp)
    70b4:	48 8d bc 24 80 00 00 	lea    0x80(%rsp),%rdi
    70bb:	00 
    70bc:	48 89 7c 24 78       	mov    %rdi,0x78(%rsp)
    70c1:	48 8d 7c 24 68       	lea    0x68(%rsp),%rdi
    70c6:	48 89 3d eb 4d 01 00 	mov    %rdi,0x14deb(%rip)        # 1beb8 <fwp_cleanups>
    70cd:	40 b7 01             	mov    $0x1,%dil
    70d0:	89 7c 24 04          	mov    %edi,0x4(%rsp)
    70d4:	f6 c1 01             	test   $0x1,%cl
    70d7:	74 14                	je     70ed <fwp_apply_borrowed_prefix+0x17d>
    70d9:	e9 88 00 00 00       	jmp    7166 <fwp_apply_borrowed_prefix+0x1f6>
    70de:	66 90                	xchg   %ax,%ax
    70e0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%rsp)
    70e7:	00 
    70e8:	f6 c1 01             	test   $0x1,%cl
    70eb:	75 79                	jne    7166 <fwp_apply_borrowed_prefix+0x1f6>
    70ed:	4c 39 da             	cmp    %r11,%rdx
    70f0:	73 68                	jae    715a <fwp_apply_borrowed_prefix+0x1ea>
    70f2:	48 8b 05 07 42 01 00 	mov    0x14207(%rip),%rax        # 1b300 <fwp_gc+0x1078>
    70f9:	48 89 d1             	mov    %rdx,%rcx
    70fc:	48 c1 e9 10          	shr    $0x10,%rcx
    7100:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    7107:	0f b6 3c 08          	movzbl (%rax,%rcx,1),%edi
    710b:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    7112:	75 13                	jne    7127 <fwp_apply_borrowed_prefix+0x1b7>
    7114:	40 80 ff 02          	cmp    $0x2,%dil
    7118:	75 0d                	jne    7127 <fwp_apply_borrowed_prefix+0x1b7>
    711a:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    711e:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    7125:	eb 20                	jmp    7147 <fwp_apply_borrowed_prefix+0x1d7>
    7127:	40 80 ff 01          	cmp    $0x1,%dil
    712b:	75 2d                	jne    715a <fwp_apply_borrowed_prefix+0x1ea>
    712d:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    7131:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    7135:	48 0f af d0          	imul   %rax,%rdx
    7139:	48 c1 ea 20          	shr    $0x20,%rdx
    713d:	48 01 d7             	add    %rdx,%rdi
    7140:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    7147:	0f b6 07             	movzbl (%rdi),%eax
    714a:	84 c0                	test   %al,%al
    714c:	74 0c                	je     715a <fwp_apply_borrowed_prefix+0x1ea>
    714e:	3c fe                	cmp    $0xfe,%al
    7150:	0f 83 d8 01 00 00    	jae    732e <fwp_apply_borrowed_prefix+0x3be>
    7156:	fe c0                	inc    %al
    7158:	88 07                	mov    %al,(%rdi)
    715a:	4c 89 b4 24 80 00 00 	mov    %r14,0x80(%rsp)
    7161:	00 
    7162:	48 8b 45 00          	mov    0x0(%rbp),%rax
    7166:	45 8b 24 24          	mov    (%r12),%r12d
    716a:	45 2b 66 04          	sub    0x4(%r14),%r12d
    716e:	44 39 e6             	cmp    %r12d,%esi
    7171:	44 89 64 24 14       	mov    %r12d,0x14(%rsp)
    7176:	44 0f 42 e6          	cmovb  %esi,%r12d
    717a:	45 39 e7             	cmp    %r12d,%r15d
    717d:	44 89 e2             	mov    %r12d,%edx
    7180:	41 0f 42 d7          	cmovb  %r15d,%edx
    7184:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    718b:	00 00 
    718d:	4c 89 6c 24 20       	mov    %r13,0x20(%rsp)
    7192:	4d 8d 6c d5 00       	lea    0x0(%r13,%rdx,8),%r13
    7197:	4c 89 6c 24 48       	mov    %r13,0x48(%rsp)
    719c:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    71a1:	c7 44 24 58 00 00 00 	movl   $0x0,0x58(%rsp)
    71a8:	00 
    71a9:	41 8b 4e 04          	mov    0x4(%r14),%ecx
    71ad:	01 d1                	add    %edx,%ecx
    71af:	89 4c 24 5c          	mov    %ecx,0x5c(%rsp)
    71b3:	c7 44 24 60 00 00 00 	movl   $0x0,0x60(%rsp)
    71ba:	00 
    71bb:	31 db                	xor    %ebx,%ebx
    71bd:	b9 00 00 00 00       	mov    $0x0,%ecx
    71c2:	45 39 fc             	cmp    %r15d,%r12d
    71c5:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)
    71ca:	0f 86 9d 00 00 00    	jbe    726d <fwp_apply_borrowed_prefix+0x2fd>
    71d0:	44 89 7c 24 0c       	mov    %r15d,0xc(%rsp)
    71d5:	89 74 24 10          	mov    %esi,0x10(%rsp)
    71d9:	48 83 78 18 00       	cmpq   $0x0,0x18(%rax)
    71de:	0f 95 c0             	setne  %al
    71e1:	89 44 24 08          	mov    %eax,0x8(%rsp)
    71e5:	74 2e                	je     7215 <fwp_apply_borrowed_prefix+0x2a5>
    71e7:	48 8b 05 ca 4c 01 00 	mov    0x14cca(%rip),%rax        # 1beb8 <fwp_cleanups>
    71ee:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    71f3:	48 8d 05 06 07 00 00 	lea    0x706(%rip),%rax        # 7900 <fwp_apply_release>
    71fa:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    71ff:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
    7204:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    7209:	48 8d 44 24 28       	lea    0x28(%rsp),%rax
    720e:	48 89 05 a3 4c 01 00 	mov    %rax,0x14ca3(%rip)        # 1beb8 <fwp_cleanups>
    7215:	45 89 e7             	mov    %r12d,%r15d
    7218:	41 29 d7             	sub    %edx,%r15d
    721b:	41 83 ff 01          	cmp    $0x1,%r15d
    721f:	41 83 d7 00          	adc    $0x0,%r15d
    7223:	49 c1 e7 03          	shl    $0x3,%r15
    7227:	89 d3                	mov    %edx,%ebx
    7229:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    7230:	48 8b 45 00          	mov    0x0(%rbp),%rax
    7234:	41 8b 76 04          	mov    0x4(%r14),%esi
    7238:	01 de                	add    %ebx,%esi
    723a:	4c 89 ef             	mov    %r13,%rdi
    723d:	ba 01 00 00 00       	mov    $0x1,%edx
    7242:	ff 50 10             	call   *0x10(%rax)
    7245:	8b 4c 24 60          	mov    0x60(%rsp),%ecx
    7249:	ff c1                	inc    %ecx
    724b:	89 4c 24 60          	mov    %ecx,0x60(%rsp)
    724f:	ff c3                	inc    %ebx
    7251:	49 83 c5 08          	add    $0x8,%r13
    7255:	49 83 c7 f8          	add    $0xfffffffffffffff8,%r15
    7259:	75 d5                	jne    7230 <fwp_apply_borrowed_prefix+0x2c0>
    725b:	8b 74 24 10          	mov    0x10(%rsp),%esi
    725f:	44 8b 7c 24 0c       	mov    0xc(%rsp),%r15d
    7264:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
    7269:	8b 5c 24 08          	mov    0x8(%rsp),%ebx
    726d:	89 f5                	mov    %esi,%ebp
    726f:	89 4c 24 58          	mov    %ecx,0x58(%rsp)
    7273:	48 c7 84 24 80 00 00 	movq   $0x0,0x80(%rsp)
    727a:	00 00 00 00 00 
    727f:	89 94 24 98 00 00 00 	mov    %edx,0x98(%rsp)
    7286:	4c 89 f7             	mov    %r14,%rdi
    7289:	44 89 e6             	mov    %r12d,%esi
    728c:	4c 8b 6c 24 20       	mov    0x20(%rsp),%r13
    7291:	4c 89 ea             	mov    %r13,%rdx
    7294:	e8 d7 06 00 00       	call   7970 <fwp_apply_owned>
    7299:	49 89 c6             	mov    %rax,%r14
    729c:	84 db                	test   %bl,%bl
    729e:	74 1e                	je     72be <fwp_apply_borrowed_prefix+0x34e>
    72a0:	48 8d 44 24 28       	lea    0x28(%rsp),%rax
    72a5:	48 39 05 0c 4c 01 00 	cmp    %rax,0x14c0c(%rip)        # 1beb8 <fwp_cleanups>
    72ac:	0f 85 e5 00 00 00    	jne    7397 <fwp_apply_borrowed_prefix+0x427>
    72b2:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    72b7:	48 89 05 fa 4b 01 00 	mov    %rax,0x14bfa(%rip)        # 1beb8 <fwp_cleanups>
    72be:	80 7c 24 04 00       	cmpb   $0x0,0x4(%rsp)
    72c3:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    72c8:	89 ee                	mov    %ebp,%esi
    72ca:	74 1e                	je     72ea <fwp_apply_borrowed_prefix+0x37a>
    72cc:	48 8d 44 24 68       	lea    0x68(%rsp),%rax
    72d1:	48 39 05 e0 4b 01 00 	cmp    %rax,0x14be0(%rip)        # 1beb8 <fwp_cleanups>
    72d8:	0f 85 b9 00 00 00    	jne    7397 <fwp_apply_borrowed_prefix+0x427>
    72de:	48 8b 44 24 68       	mov    0x68(%rsp),%rax
    72e3:	48 89 05 ce 4b 01 00 	mov    %rax,0x14bce(%rip)        # 1beb8 <fwp_cleanups>
    72ea:	3b 74 24 14          	cmp    0x14(%rsp),%esi
    72ee:	0f 86 8e 00 00 00    	jbe    7382 <fwp_apply_borrowed_prefix+0x412>
    72f4:	44 89 e0             	mov    %r12d,%eax
    72f7:	4d 8d 6c c5 00       	lea    0x0(%r13,%rax,8),%r13
    72fc:	44 29 e6             	sub    %r12d,%esi
    72ff:	41 29 cf             	sub    %ecx,%r15d
    7302:	48 8b 05 67 4b 01 00 	mov    0x14b67(%rip),%rax        # 1be70 <fwp_fns>
    7309:	41 8b 0e             	mov    (%r14),%ecx
    730c:	48 c1 e1 05          	shl    $0x5,%rcx
    7310:	4c 8d 24 08          	lea    (%rax,%rcx,1),%r12
    7314:	48 8d 2c 08          	lea    (%rax,%rcx,1),%rbp
    7318:	48 83 c5 18          	add    $0x18,%rbp
    731c:	48 8b 44 08 18       	mov    0x18(%rax,%rcx,1),%rax
    7321:	b1 01                	mov    $0x1,%cl
    7323:	48 85 c0             	test   %rax,%rax
    7326:	0f 85 94 fc ff ff    	jne    6fc0 <fwp_apply_borrowed_prefix+0x50>
    732c:	eb 0e                	jmp    733c <fwp_apply_borrowed_prefix+0x3cc>
    732e:	89 f3                	mov    %esi,%ebx
    7330:	e8 0b 33 00 00       	call   a640 <fwp_rc_wide_dup>
    7335:	89 de                	mov    %ebx,%esi
    7337:	e9 1e fe ff ff       	jmp    715a <fwp_apply_borrowed_prefix+0x1ea>
    733c:	4c 89 f7             	mov    %r14,%rdi
    733f:	89 f3                	mov    %esi,%ebx
    7341:	e8 9a f5 ff ff       	call   68e0 <fwp_rc_share>
    7346:	89 dd                	mov    %ebx,%ebp
    7348:	85 db                	test   %ebx,%ebx
    734a:	74 26                	je     7372 <fwp_apply_borrowed_prefix+0x402>
    734c:	89 eb                	mov    %ebp,%ebx
    734e:	45 31 ff             	xor    %r15d,%r15d
    7351:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7358:	0f 1f 84 00 00 00 00 
    735f:	00 
    7360:	4b 8b 7c fd 00       	mov    0x0(%r13,%r15,8),%rdi
    7365:	e8 76 f5 ff ff       	call   68e0 <fwp_rc_share>
    736a:	49 ff c7             	inc    %r15
    736d:	4c 39 fb             	cmp    %r15,%rbx
    7370:	75 ee                	jne    7360 <fwp_apply_borrowed_prefix+0x3f0>
    7372:	4c 89 f7             	mov    %r14,%rdi
    7375:	89 ee                	mov    %ebp,%esi
    7377:	4c 89 ea             	mov    %r13,%rdx
    737a:	e8 21 00 00 00       	call   73a0 <fwp_apply>
    737f:	49 89 c6             	mov    %rax,%r14
    7382:	4c 89 f0             	mov    %r14,%rax
    7385:	48 81 c4 a8 00 00 00 	add    $0xa8,%rsp
    738c:	5b                   	pop    %rbx
    738d:	41 5c                	pop    %r12
    738f:	41 5d                	pop    %r13
    7391:	41 5e                	pop    %r14
    7393:	41 5f                	pop    %r15
    7395:	5d                   	pop    %rbp
    7396:	c3                   	ret
    7397:	e8 d4 bc ff ff       	call   3070 <abort@plt>
    739c:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000073a0 <fwp_apply>:
    73a0:	55                   	push   %rbp
    73a1:	48 89 e5             	mov    %rsp,%rbp
    73a4:	41 57                	push   %r15
    73a6:	41 56                	push   %r14
    73a8:	41 55                	push   %r13
    73aa:	41 54                	push   %r12
    73ac:	53                   	push   %rbx
    73ad:	48 83 ec 18          	sub    $0x18,%rsp
    73b1:	48 89 d3             	mov    %rdx,%rbx
    73b4:	49 89 ff             	mov    %rdi,%r15
    73b7:	eb 23                	jmp    73dc <fwp_apply+0x3c>
    73b9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    73c0:	4a 8d 1c f3          	lea    (%rbx,%r14,8),%rbx
    73c4:	31 c9                	xor    %ecx,%ecx
    73c6:	49 89 c7             	mov    %rax,%r15
    73c9:	4c 8b 75 c8          	mov    -0x38(%rbp),%r14
    73cd:	48 8b 65 c0          	mov    -0x40(%rbp),%rsp
    73d1:	89 d6                	mov    %edx,%esi
    73d3:	83 f9 01             	cmp    $0x1,%ecx
    73d6:	0f 84 aa 04 00 00    	je     7886 <fwp_apply+0x4e6>
    73dc:	48 8b 05 8d 4a 01 00 	mov    0x14a8d(%rip),%rax        # 1be70 <fwp_fns>
    73e3:	41 8b 0f             	mov    (%r15),%ecx
    73e6:	45 8b 6f 04          	mov    0x4(%r15),%r13d
    73ea:	48 c1 e1 05          	shl    $0x5,%rcx
    73ee:	44 8b 24 08          	mov    (%rax,%rcx,1),%r12d
    73f2:	4d 85 ed             	test   %r13,%r13
    73f5:	75 39                	jne    7430 <fwp_apply+0x90>
    73f7:	41 8d 54 24 ff       	lea    -0x1(%r12),%edx
    73fc:	39 f2                	cmp    %esi,%edx
    73fe:	73 30                	jae    7430 <fwp_apply+0x90>
    7400:	48 89 df             	mov    %rbx,%rdi
    7403:	49 89 f7             	mov    %rsi,%r15
    7406:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    740a:	4c 89 fe             	mov    %r15,%rsi
    740d:	49 89 c7             	mov    %rax,%r15
    7410:	44 39 e6             	cmp    %r12d,%esi
    7413:	0f 84 b6 02 00 00    	je     76cf <fwp_apply+0x32f>
    7419:	4a 8d 1c e3          	lea    (%rbx,%r12,8),%rbx
    741d:	44 29 e6             	sub    %r12d,%esi
    7420:	b9 03 00 00 00       	mov    $0x3,%ecx
    7425:	83 f9 01             	cmp    $0x1,%ecx
    7428:	75 b2                	jne    73dc <fwp_apply+0x3c>
    742a:	e9 57 04 00 00       	jmp    7886 <fwp_apply+0x4e6>
    742f:	90                   	nop
    7430:	4c 89 75 c8          	mov    %r14,-0x38(%rbp)
    7434:	46 8d 34 2e          	lea    (%rsi,%r13,1),%r14d
    7438:	45 39 e6             	cmp    %r12d,%r14d
    743b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    743f:	0f 82 1a 02 00 00    	jb     765f <fwp_apply+0x2bf>
    7445:	48 89 65 c0          	mov    %rsp,-0x40(%rbp)
    7449:	45 89 e3             	mov    %r12d,%r11d
    744c:	41 83 fc 02          	cmp    $0x2,%r12d
    7450:	ba 01 00 00 00       	mov    $0x1,%edx
    7455:	41 0f 43 d4          	cmovae %r12d,%edx
    7459:	48 8d 14 d5 0f 00 00 	lea    0xf(,%rdx,8),%rdx
    7460:	00 
    7461:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
    7465:	48 89 e7             	mov    %rsp,%rdi
    7468:	48 29 d7             	sub    %rdx,%rdi
    746b:	48 89 fc             	mov    %rdi,%rsp
    746e:	4d 85 ed             	test   %r13,%r13
    7471:	0f 84 c9 00 00 00    	je     7540 <fwp_apply+0x1a0>
    7477:	41 83 fd 04          	cmp    $0x4,%r13d
    747b:	72 10                	jb     748d <fwp_apply+0xed>
    747d:	48 89 fa             	mov    %rdi,%rdx
    7480:	4c 29 fa             	sub    %r15,%rdx
    7483:	48 83 c2 f8          	add    $0xfffffffffffffff8,%rdx
    7487:	48 83 fa 20          	cmp    $0x20,%rdx
    748b:	73 65                	jae    74f2 <fwp_apply+0x152>
    748d:	31 d2                	xor    %edx,%edx
    748f:	4d 89 e8             	mov    %r13,%r8
    7492:	49 89 d2             	mov    %rdx,%r10
    7495:	49 83 e0 03          	and    $0x3,%r8
    7499:	74 16                	je     74b1 <fwp_apply+0x111>
    749b:	49 89 d2             	mov    %rdx,%r10
    749e:	66 90                	xchg   %ax,%ax
    74a0:	4f 8b 4c d7 08       	mov    0x8(%r15,%r10,8),%r9
    74a5:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    74a9:	49 ff c2             	inc    %r10
    74ac:	49 ff c8             	dec    %r8
    74af:	75 ef                	jne    74a0 <fwp_apply+0x100>
    74b1:	4c 29 ea             	sub    %r13,%rdx
    74b4:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    74b8:	0f 87 82 00 00 00    	ja     7540 <fwp_apply+0x1a0>
    74be:	66 90                	xchg   %ax,%ax
    74c0:	4b 8b 54 d7 08       	mov    0x8(%r15,%r10,8),%rdx
    74c5:	4a 89 14 d7          	mov    %rdx,(%rdi,%r10,8)
    74c9:	4b 8b 54 d7 10       	mov    0x10(%r15,%r10,8),%rdx
    74ce:	4a 89 54 d7 08       	mov    %rdx,0x8(%rdi,%r10,8)
    74d3:	4b 8b 54 d7 18       	mov    0x18(%r15,%r10,8),%rdx
    74d8:	4a 89 54 d7 10       	mov    %rdx,0x10(%rdi,%r10,8)
    74dd:	4b 8b 54 d7 20       	mov    0x20(%r15,%r10,8),%rdx
    74e2:	4a 89 54 d7 18       	mov    %rdx,0x18(%rdi,%r10,8)
    74e7:	49 83 c2 04          	add    $0x4,%r10
    74eb:	4d 39 d5             	cmp    %r10,%r13
    74ee:	75 d0                	jne    74c0 <fwp_apply+0x120>
    74f0:	eb 4e                	jmp    7540 <fwp_apply+0x1a0>
    74f2:	44 89 ea             	mov    %r13d,%edx
    74f5:	83 e2 fc             	and    $0xfffffffc,%edx
    74f8:	4e 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%r9
    74ff:	00 
    7500:	49 83 e1 e0          	and    $0xffffffffffffffe0,%r9
    7504:	45 31 c0             	xor    %r8d,%r8d
    7507:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    750e:	00 00 
    7510:	43 0f 10 44 07 08    	movups 0x8(%r15,%r8,1),%xmm0
    7516:	43 0f 10 4c 07 18    	movups 0x18(%r15,%r8,1),%xmm1
    751c:	42 0f 29 04 07       	movaps %xmm0,(%rdi,%r8,1)
    7521:	42 0f 29 4c 07 10    	movaps %xmm1,0x10(%rdi,%r8,1)
    7527:	49 83 c0 20          	add    $0x20,%r8
    752b:	4d 39 c1             	cmp    %r8,%r9
    752e:	75 e0                	jne    7510 <fwp_apply+0x170>
    7530:	4c 39 ea             	cmp    %r13,%rdx
    7533:	0f 85 56 ff ff ff    	jne    748f <fwp_apply+0xef>
    7539:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    7540:	45 29 eb             	sub    %r13d,%r11d
    7543:	45 89 de             	mov    %r11d,%r14d
    7546:	45 39 ec             	cmp    %r13d,%r12d
    7549:	0f 84 85 00 00 00    	je     75d4 <fwp_apply+0x234>
    754f:	41 83 fb 0e          	cmp    $0xe,%r11d
    7553:	0f 83 a0 00 00 00    	jae    75f9 <fwp_apply+0x259>
    7559:	31 d2                	xor    %edx,%edx
    755b:	4d 89 f0             	mov    %r14,%r8
    755e:	48 89 d6             	mov    %rdx,%rsi
    7561:	49 83 e0 03          	and    $0x3,%r8
    7565:	74 1d                	je     7584 <fwp_apply+0x1e4>
    7567:	48 89 d6             	mov    %rdx,%rsi
    756a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    7570:	4c 8b 0c f3          	mov    (%rbx,%rsi,8),%r9
    7574:	46 8d 14 2e          	lea    (%rsi,%r13,1),%r10d
    7578:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    757c:	48 ff c6             	inc    %rsi
    757f:	49 ff c8             	dec    %r8
    7582:	75 ec                	jne    7570 <fwp_apply+0x1d0>
    7584:	4c 29 f2             	sub    %r14,%rdx
    7587:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    758b:	77 47                	ja     75d4 <fwp_apply+0x234>
    758d:	0f 1f 00             	nopl   (%rax)
    7590:	48 8b 14 f3          	mov    (%rbx,%rsi,8),%rdx
    7594:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    7598:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    759c:	48 8b 54 f3 08       	mov    0x8(%rbx,%rsi,8),%rdx
    75a1:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    75a5:	41 ff c0             	inc    %r8d
    75a8:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    75ac:	48 8b 54 f3 10       	mov    0x10(%rbx,%rsi,8),%rdx
    75b1:	45 8d 44 35 02       	lea    0x2(%r13,%rsi,1),%r8d
    75b6:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    75ba:	48 8b 54 f3 18       	mov    0x18(%rbx,%rsi,8),%rdx
    75bf:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    75c3:	41 83 c0 03          	add    $0x3,%r8d
    75c7:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    75cb:	48 83 c6 04          	add    $0x4,%rsi
    75cf:	49 39 f6             	cmp    %rsi,%r14
    75d2:	75 bc                	jne    7590 <fwp_apply+0x1f0>
    75d4:	45 89 dc             	mov    %r11d,%r12d
    75d7:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    75db:	b9 01 00 00 00       	mov    $0x1,%ecx
    75e0:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    75e4:	89 f2                	mov    %esi,%edx
    75e6:	44 29 e2             	sub    %r12d,%edx
    75e9:	0f 85 d1 fd ff ff    	jne    73c0 <fwp_apply+0x20>
    75ef:	89 f2                	mov    %esi,%edx
    75f1:	49 89 c6             	mov    %rax,%r14
    75f4:	e9 d4 fd ff ff       	jmp    73cd <fwp_apply+0x2d>
    75f9:	49 8d 56 ff          	lea    -0x1(%r14),%rdx
    75fd:	89 d6                	mov    %edx,%esi
    75ff:	44 01 ee             	add    %r13d,%esi
    7602:	0f 82 51 ff ff ff    	jb     7559 <fwp_apply+0x1b9>
    7608:	48 c1 ea 20          	shr    $0x20,%rdx
    760c:	ba 00 00 00 00       	mov    $0x0,%edx
    7611:	0f 85 44 ff ff ff    	jne    755b <fwp_apply+0x1bb>
    7617:	4a 8d 14 ef          	lea    (%rdi,%r13,8),%rdx
    761b:	48 29 da             	sub    %rbx,%rdx
    761e:	48 83 fa 20          	cmp    $0x20,%rdx
    7622:	0f 82 31 ff ff ff    	jb     7559 <fwp_apply+0x1b9>
    7628:	44 89 f2             	mov    %r14d,%edx
    762b:	83 e2 fc             	and    $0xfffffffc,%edx
    762e:	31 f6                	xor    %esi,%esi
    7630:	0f 10 04 f3          	movups (%rbx,%rsi,8),%xmm0
    7634:	0f 10 4c f3 10       	movups 0x10(%rbx,%rsi,8),%xmm1
    7639:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    763d:	42 0f 11 04 c7       	movups %xmm0,(%rdi,%r8,8)
    7642:	42 0f 11 4c c7 10    	movups %xmm1,0x10(%rdi,%r8,8)
    7648:	48 83 c6 04          	add    $0x4,%rsi
    764c:	48 39 f2             	cmp    %rsi,%rdx
    764f:	75 df                	jne    7630 <fwp_apply+0x290>
    7651:	4c 39 f2             	cmp    %r14,%rdx
    7654:	0f 85 01 ff ff ff    	jne    755b <fwp_apply+0x1bb>
    765a:	e9 75 ff ff ff       	jmp    75d4 <fwp_apply+0x234>
    765f:	44 89 f1             	mov    %r14d,%ecx
    7662:	48 8d 3c cd 08 00 00 	lea    0x8(,%rcx,8),%rdi
    7669:	00 
    766a:	48 ff 05 37 48 01 00 	incq   0x14837(%rip)        # 1bea8 <measured_calls>
    7671:	48 01 3d 38 48 01 00 	add    %rdi,0x14838(%rip)        # 1beb0 <measured_bytes>
    7678:	41 81 fe ff 07 00 00 	cmp    $0x7ff,%r14d
    767f:	77 6e                	ja     76ef <fwp_apply+0x34f>
    7681:	48 c1 e1 03          	shl    $0x3,%rcx
    7685:	48 83 c1 17          	add    $0x17,%rcx
    7689:	48 c1 e9 04          	shr    $0x4,%rcx
    768d:	48 8d 05 f4 2b 01 00 	lea    0x12bf4(%rip),%rax        # 1a288 <fwp_gc>
    7694:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    769b:	00 
    769c:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    76a3:	48 29 15 de 2b 01 00 	sub    %rdx,0x12bde(%rip)        # 1a288 <fwp_gc>
    76aa:	78 43                	js     76ef <fwp_apply+0x34f>
    76ac:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    76b0:	4c 8d 04 c8          	lea    (%rax,%rcx,8),%r8
    76b4:	49 81 c0 88 07 00 00 	add    $0x788,%r8
    76bb:	4d 8b 20             	mov    (%r8),%r12
    76be:	4d 85 e4             	test   %r12,%r12
    76c1:	74 14                	je     76d7 <fwp_apply+0x337>
    76c3:	49 8b 04 24          	mov    (%r12),%rax
    76c7:	48 f7 d0             	not    %rax
    76ca:	49 89 00             	mov    %rax,(%r8)
    76cd:	eb 40                	jmp    770f <fwp_apply+0x36f>
    76cf:	4d 89 fe             	mov    %r15,%r14
    76d2:	e9 af 01 00 00       	jmp    7886 <fwp_apply+0x4e6>
    76d7:	4c 8b a4 c8 90 07 00 	mov    0x790(%rax,%rcx,8),%r12
    76de:	00 
    76df:	4c 8b 84 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%r8
    76e6:	00 
    76e7:	4d 29 e0             	sub    %r12,%r8
    76ea:	49 39 d0             	cmp    %rdx,%r8
    76ed:	73 0f                	jae    76fe <fwp_apply+0x35e>
    76ef:	be 02 00 00 00       	mov    $0x2,%esi
    76f4:	e8 87 0b 00 00       	call   8280 <fwp_gc_alloc_slow>
    76f9:	49 89 c4             	mov    %rax,%r12
    76fc:	eb 1b                	jmp    7719 <fwp_apply+0x379>
    76fe:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    7702:	48 05 90 07 00 00    	add    $0x790,%rax
    7708:	49 8d 0c 14          	lea    (%r12,%rdx,1),%rcx
    770c:	48 89 08             	mov    %rcx,(%rax)
    770f:	4c 89 e7             	mov    %r12,%rdi
    7712:	31 f6                	xor    %esi,%esi
    7714:	e8 f7 ba ff ff       	call   3210 <memset@plt>
    7719:	41 8b 07             	mov    (%r15),%eax
    771c:	41 89 04 24          	mov    %eax,(%r12)
    7720:	45 89 74 24 04       	mov    %r14d,0x4(%r12)
    7725:	4d 85 ed             	test   %r13,%r13
    7728:	4d 89 e6             	mov    %r12,%r14
    772b:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    772f:	0f 84 bc 00 00 00    	je     77f1 <fwp_apply+0x451>
    7735:	31 c0                	xor    %eax,%eax
    7737:	41 83 fd 06          	cmp    $0x6,%r13d
    773b:	72 49                	jb     7786 <fwp_apply+0x3e6>
    773d:	4c 89 f1             	mov    %r14,%rcx
    7740:	4c 29 f9             	sub    %r15,%rcx
    7743:	48 83 f9 20          	cmp    $0x20,%rcx
    7747:	72 3d                	jb     7786 <fwp_apply+0x3e6>
    7749:	44 89 e8             	mov    %r13d,%eax
    774c:	83 e0 fc             	and    $0xfffffffc,%eax
    774f:	4a 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%rcx
    7756:	00 
    7757:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    775b:	31 d2                	xor    %edx,%edx
    775d:	0f 1f 00             	nopl   (%rax)
    7760:	41 0f 10 44 17 08    	movups 0x8(%r15,%rdx,1),%xmm0
    7766:	41 0f 10 4c 17 18    	movups 0x18(%r15,%rdx,1),%xmm1
    776c:	41 0f 11 44 16 08    	movups %xmm0,0x8(%r14,%rdx,1)
    7772:	41 0f 11 4c 16 18    	movups %xmm1,0x18(%r14,%rdx,1)
    7778:	48 83 c2 20          	add    $0x20,%rdx
    777c:	48 39 d1             	cmp    %rdx,%rcx
    777f:	75 df                	jne    7760 <fwp_apply+0x3c0>
    7781:	4c 39 e8             	cmp    %r13,%rax
    7784:	74 6b                	je     77f1 <fwp_apply+0x451>
    7786:	4c 89 ea             	mov    %r13,%rdx
    7789:	48 89 c1             	mov    %rax,%rcx
    778c:	48 83 e2 03          	and    $0x3,%rdx
    7790:	74 20                	je     77b2 <fwp_apply+0x412>
    7792:	48 89 c1             	mov    %rax,%rcx
    7795:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    779c:	00 00 00 00 
    77a0:	49 8b 74 cf 08       	mov    0x8(%r15,%rcx,8),%rsi
    77a5:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    77aa:	48 ff c1             	inc    %rcx
    77ad:	48 ff ca             	dec    %rdx
    77b0:	75 ee                	jne    77a0 <fwp_apply+0x400>
    77b2:	4c 29 e8             	sub    %r13,%rax
    77b5:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    77b9:	77 36                	ja     77f1 <fwp_apply+0x451>
    77bb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    77c0:	49 8b 44 cf 08       	mov    0x8(%r15,%rcx,8),%rax
    77c5:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    77ca:	49 8b 44 cf 10       	mov    0x10(%r15,%rcx,8),%rax
    77cf:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    77d4:	49 8b 44 cf 18       	mov    0x18(%r15,%rcx,8),%rax
    77d9:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    77de:	49 8b 44 cf 20       	mov    0x20(%r15,%rcx,8),%rax
    77e3:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    77e8:	48 83 c1 04          	add    $0x4,%rcx
    77ec:	49 39 cd             	cmp    %rcx,%r13
    77ef:	75 cf                	jne    77c0 <fwp_apply+0x420>
    77f1:	85 ff                	test   %edi,%edi
    77f3:	0f 84 8d 00 00 00    	je     7886 <fwp_apply+0x4e6>
    77f9:	89 f8                	mov    %edi,%eax
    77fb:	83 ff 14             	cmp    $0x14,%edi
    77fe:	0f 83 94 00 00 00    	jae    7898 <fwp_apply+0x4f8>
    7804:	31 c9                	xor    %ecx,%ecx
    7806:	48 89 c6             	mov    %rax,%rsi
    7809:	48 89 ca             	mov    %rcx,%rdx
    780c:	48 83 e6 03          	and    $0x3,%rsi
    7810:	74 23                	je     7835 <fwp_apply+0x495>
    7812:	48 89 ca             	mov    %rcx,%rdx
    7815:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    781c:	00 00 00 00 
    7820:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    7824:	46 8d 04 2a          	lea    (%rdx,%r13,1),%r8d
    7828:	4b 89 7c c6 08       	mov    %rdi,0x8(%r14,%r8,8)
    782d:	48 ff c2             	inc    %rdx
    7830:	48 ff ce             	dec    %rsi
    7833:	75 eb                	jne    7820 <fwp_apply+0x480>
    7835:	48 29 c1             	sub    %rax,%rcx
    7838:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    783c:	77 48                	ja     7886 <fwp_apply+0x4e6>
    783e:	66 90                	xchg   %ax,%ax
    7840:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    7844:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    7848:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    784d:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    7852:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    7856:	ff c6                	inc    %esi
    7858:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    785d:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    7862:	41 8d 74 15 02       	lea    0x2(%r13,%rdx,1),%esi
    7867:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    786c:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    7871:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    7875:	83 c6 03             	add    $0x3,%esi
    7878:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    787d:	48 83 c2 04          	add    $0x4,%rdx
    7881:	48 39 d0             	cmp    %rdx,%rax
    7884:	75 ba                	jne    7840 <fwp_apply+0x4a0>
    7886:	4c 89 f0             	mov    %r14,%rax
    7889:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    788d:	5b                   	pop    %rbx
    788e:	41 5c                	pop    %r12
    7890:	41 5d                	pop    %r13
    7892:	41 5e                	pop    %r14
    7894:	41 5f                	pop    %r15
    7896:	5d                   	pop    %rbp
    7897:	c3                   	ret
    7898:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    789c:	31 c9                	xor    %ecx,%ecx
    789e:	89 d6                	mov    %edx,%esi
    78a0:	44 01 ee             	add    %r13d,%esi
    78a3:	0f 82 5d ff ff ff    	jb     7806 <fwp_apply+0x466>
    78a9:	48 c1 ea 20          	shr    $0x20,%rdx
    78ad:	0f 85 53 ff ff ff    	jne    7806 <fwp_apply+0x466>
    78b3:	4b 8d 0c ee          	lea    (%r14,%r13,8),%rcx
    78b7:	48 29 d9             	sub    %rbx,%rcx
    78ba:	48 83 c1 08          	add    $0x8,%rcx
    78be:	48 83 f9 20          	cmp    $0x20,%rcx
    78c2:	0f 82 3c ff ff ff    	jb     7804 <fwp_apply+0x464>
    78c8:	89 c1                	mov    %eax,%ecx
    78ca:	83 e1 fc             	and    $0xfffffffc,%ecx
    78cd:	31 d2                	xor    %edx,%edx
    78cf:	90                   	nop
    78d0:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    78d4:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    78d9:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    78dd:	41 0f 11 44 f6 08    	movups %xmm0,0x8(%r14,%rsi,8)
    78e3:	41 0f 11 4c f6 18    	movups %xmm1,0x18(%r14,%rsi,8)
    78e9:	48 83 c2 04          	add    $0x4,%rdx
    78ed:	48 39 d1             	cmp    %rdx,%rcx
    78f0:	75 de                	jne    78d0 <fwp_apply+0x530>
    78f2:	48 39 c1             	cmp    %rax,%rcx
    78f5:	0f 85 0b ff ff ff    	jne    7806 <fwp_apply+0x466>
    78fb:	eb 89                	jmp    7886 <fwp_apply+0x4e6>
    78fd:	0f 1f 00             	nopl   (%rax)

0000000000007900 <fwp_apply_release>:
    7900:	41 56                	push   %r14
    7902:	53                   	push   %rbx
    7903:	50                   	push   %rax
    7904:	48 8b 1f             	mov    (%rdi),%rbx
    7907:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    790e:	8b 47 20             	mov    0x20(%rdi),%eax
    7911:	8b 4f 18             	mov    0x18(%rdi),%ecx
    7914:	89 c2                	mov    %eax,%edx
    7916:	29 ca                	sub    %ecx,%edx
    7918:	74 2d                	je     7947 <fwp_apply_release+0x47>
    791a:	48 8b 77 10          	mov    0x10(%rdi),%rsi
    791e:	4c 8b 46 18          	mov    0x18(%rsi),%r8
    7922:	4d 85 c0             	test   %r8,%r8
    7925:	74 20                	je     7947 <fwp_apply_release+0x47>
    7927:	48 89 c8             	mov    %rcx,%rax
    792a:	48 c1 e0 03          	shl    $0x3,%rax
    792e:	48 03 47 08          	add    0x8(%rdi),%rax
    7932:	8b 77 1c             	mov    0x1c(%rdi),%esi
    7935:	01 ce                	add    %ecx,%esi
    7937:	49 89 fe             	mov    %rdi,%r14
    793a:	48 89 c7             	mov    %rax,%rdi
    793d:	41 ff d0             	call   *%r8
    7940:	4c 89 f7             	mov    %r14,%rdi
    7943:	41 8b 46 20          	mov    0x20(%r14),%eax
    7947:	89 47 18             	mov    %eax,0x18(%rdi)
    794a:	48 85 db             	test   %rbx,%rbx
    794d:	74 0f                	je     795e <fwp_apply_release+0x5e>
    794f:	48 89 df             	mov    %rbx,%rdi
    7952:	48 83 c4 08          	add    $0x8,%rsp
    7956:	5b                   	pop    %rbx
    7957:	41 5e                	pop    %r14
    7959:	e9 42 29 00 00       	jmp    a2a0 <fwp_closure_drop>
    795e:	48 83 c4 08          	add    $0x8,%rsp
    7962:	5b                   	pop    %rbx
    7963:	41 5e                	pop    %r14
    7965:	c3                   	ret
    7966:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    796d:	00 00 00 

0000000000007970 <fwp_apply_owned>:
    7970:	55                   	push   %rbp
    7971:	48 89 e5             	mov    %rsp,%rbp
    7974:	41 57                	push   %r15
    7976:	41 56                	push   %r14
    7978:	41 55                	push   %r13
    797a:	41 54                	push   %r12
    797c:	53                   	push   %rbx
    797d:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    7984:	48 89 d3             	mov    %rdx,%rbx
    7987:	41 89 f5             	mov    %esi,%r13d
    798a:	48 8b 05 df 44 01 00 	mov    0x144df(%rip),%rax        # 1be70 <fwp_fns>
    7991:	8b 17                	mov    (%rdi),%edx
    7993:	48 89 d6             	mov    %rdx,%rsi
    7996:	48 c1 e6 05          	shl    $0x5,%rsi
    799a:	48 8b 4c 30 18       	mov    0x18(%rax,%rsi,1),%rcx
    799f:	48 85 c9             	test   %rcx,%rcx
    79a2:	0f 84 fa 03 00 00    	je     7da2 <fwp_apply_owned+0x432>
    79a8:	4c 8d 14 30          	lea    (%rax,%rsi,1),%r10
    79ac:	49 83 c2 18          	add    $0x18,%r10
    79b0:	49 89 fc             	mov    %rdi,%r12
    79b3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    79ba:	84 00 00 00 00 00 
    79c0:	48 c1 e2 05          	shl    $0x5,%rdx
    79c4:	8b 04 10             	mov    (%rax,%rdx,1),%eax
    79c7:	45 8b 7c 24 04       	mov    0x4(%r12),%r15d
    79cc:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
    79d3:	48 89 9d 70 ff ff ff 	mov    %rbx,-0x90(%rbp)
    79da:	48 89 8d 78 ff ff ff 	mov    %rcx,-0x88(%rbp)
    79e1:	c7 45 80 00 00 00 00 	movl   $0x0,-0x80(%rbp)
    79e8:	44 89 7d 84          	mov    %r15d,-0x7c(%rbp)
    79ec:	48 89 fa             	mov    %rdi,%rdx
    79ef:	48 2b 15 c2 38 01 00 	sub    0x138c2(%rip),%rdx        # 1b2b8 <fwp_gc+0x1030>
    79f6:	44 89 6d 88          	mov    %r13d,-0x78(%rbp)
    79fa:	48 8b 35 df 38 01 00 	mov    0x138df(%rip),%rsi        # 1b2e0 <fwp_gc+0x1058>
    7a01:	48 c1 e6 10          	shl    $0x10,%rsi
    7a05:	48 39 f2             	cmp    %rsi,%rdx
    7a08:	73 76                	jae    7a80 <fwp_apply_owned+0x110>
    7a0a:	48 8b 35 ef 38 01 00 	mov    0x138ef(%rip),%rsi        # 1b300 <fwp_gc+0x1078>
    7a11:	49 89 d0             	mov    %rdx,%r8
    7a14:	49 c1 e8 10          	shr    $0x10,%r8
    7a18:	4d 69 c8 28 12 00 00 	imul   $0x1228,%r8,%r9
    7a1f:	46 0f b6 04 0e       	movzbl (%rsi,%r9,1),%r8d
    7a24:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    7a2b:	75 23                	jne    7a50 <fwp_apply_owned+0xe0>
    7a2d:	41 80 f8 02          	cmp    $0x2,%r8b
    7a31:	75 1d                	jne    7a50 <fwp_apply_owned+0xe0>
    7a33:	4a 8d 14 0e          	lea    (%rsi,%r9,1),%rdx
    7a37:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    7a3e:	80 3a 00             	cmpb   $0x0,(%rdx)
    7a41:	75 52                	jne    7a95 <fwp_apply_owned+0x125>
    7a43:	eb 3b                	jmp    7a80 <fwp_apply_owned+0x110>
    7a45:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    7a4c:	00 00 00 00 
    7a50:	41 80 f8 01          	cmp    $0x1,%r8b
    7a54:	75 2a                	jne    7a80 <fwp_apply_owned+0x110>
    7a56:	4e 8d 04 0e          	lea    (%rsi,%r9,1),%r8
    7a5a:	42 8b 74 0e 20       	mov    0x20(%rsi,%r9,1),%esi
    7a5f:	48 0f af d6          	imul   %rsi,%rdx
    7a63:	48 c1 ea 20          	shr    $0x20,%rdx
    7a67:	4c 01 c2             	add    %r8,%rdx
    7a6a:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    7a71:	80 3a 00             	cmpb   $0x0,(%rdx)
    7a74:	75 1f                	jne    7a95 <fwp_apply_owned+0x125>
    7a76:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    7a7d:	00 00 00 
    7a80:	48 83 79 18 00       	cmpq   $0x0,0x18(%rcx)
    7a85:	74 49                	je     7ad0 <fwp_apply_owned+0x160>
    7a87:	4d 85 ff             	test   %r15,%r15
    7a8a:	75 09                	jne    7a95 <fwp_apply_owned+0x125>
    7a8c:	31 d2                	xor    %edx,%edx
    7a8e:	41 39 c5             	cmp    %eax,%r13d
    7a91:	72 02                	jb     7a95 <fwp_apply_owned+0x125>
    7a93:	76 3d                	jbe    7ad2 <fwp_apply_owned+0x162>
    7a95:	48 8b 15 1c 44 01 00 	mov    0x1441c(%rip),%rdx        # 1beb8 <fwp_cleanups>
    7a9c:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
    7aa0:	48 8d 15 59 fe ff ff 	lea    -0x1a7(%rip),%rdx        # 7900 <fwp_apply_release>
    7aa7:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
    7aab:	48 8d 95 68 ff ff ff 	lea    -0x98(%rbp),%rdx
    7ab2:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
    7ab6:	48 8d 55 98          	lea    -0x68(%rbp),%rdx
    7aba:	48 89 15 f7 43 01 00 	mov    %rdx,0x143f7(%rip)        # 1beb8 <fwp_cleanups>
    7ac1:	b2 01                	mov    $0x1,%dl
    7ac3:	eb 0d                	jmp    7ad2 <fwp_apply_owned+0x162>
    7ac5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    7acc:	00 00 00 00 
    7ad0:	31 d2                	xor    %edx,%edx
    7ad2:	47 8d 34 2f          	lea    (%r15,%r13,1),%r14d
    7ad6:	41 39 c6             	cmp    %eax,%r14d
    7ad9:	89 55 cc             	mov    %edx,-0x34(%rbp)
    7adc:	0f 82 05 03 00 00    	jb     7de7 <fwp_apply_owned+0x477>
    7ae2:	41 89 c6             	mov    %eax,%r14d
    7ae5:	45 29 fe             	sub    %r15d,%r14d
    7ae8:	45 89 f1             	mov    %r14d,%r9d
    7aeb:	4d 85 ff             	test   %r15,%r15
    7aee:	4c 89 4d c0          	mov    %r9,-0x40(%rbp)
    7af2:	44 89 75 b8          	mov    %r14d,-0x48(%rbp)
    7af6:	75 18                	jne    7b10 <fwp_apply_owned+0x1a0>
    7af8:	85 c0                	test   %eax,%eax
    7afa:	74 14                	je     7b10 <fwp_apply_owned+0x1a0>
    7afc:	49 89 ff             	mov    %rdi,%r15
    7aff:	44 89 75 80          	mov    %r14d,-0x80(%rbp)
    7b03:	48 89 df             	mov    %rbx,%rdi
    7b06:	ff 11                	call   *(%rcx)
    7b08:	49 89 c4             	mov    %rax,%r12
    7b0b:	e9 29 02 00 00       	jmp    7d39 <fwp_apply_owned+0x3c9>
    7b10:	4c 89 6d d0          	mov    %r13,-0x30(%rbp)
    7b14:	48 89 65 90          	mov    %rsp,-0x70(%rbp)
    7b18:	85 c0                	test   %eax,%eax
    7b1a:	b9 01 00 00 00       	mov    $0x1,%ecx
    7b1f:	0f 45 c8             	cmovne %eax,%ecx
    7b22:	48 8d 0c cd 0f 00 00 	lea    0xf(,%rcx,8),%rcx
    7b29:	00 
    7b2a:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
    7b2e:	49 89 e5             	mov    %rsp,%r13
    7b31:	49 29 cd             	sub    %rcx,%r13
    7b34:	4c 89 ec             	mov    %r13,%rsp
    7b37:	4d 85 ff             	test   %r15,%r15
    7b3a:	0f 84 d0 00 00 00    	je     7c10 <fwp_apply_owned+0x2a0>
    7b40:	41 83 ff 04          	cmp    $0x4,%r15d
    7b44:	72 10                	jb     7b56 <fwp_apply_owned+0x1e6>
    7b46:	4c 89 e9             	mov    %r13,%rcx
    7b49:	4c 29 e1             	sub    %r12,%rcx
    7b4c:	48 83 c1 f8          	add    $0xfffffffffffffff8,%rcx
    7b50:	48 83 f9 20          	cmp    $0x20,%rcx
    7b54:	73 6d                	jae    7bc3 <fwp_apply_owned+0x253>
    7b56:	31 c9                	xor    %ecx,%ecx
    7b58:	4c 89 fe             	mov    %r15,%rsi
    7b5b:	48 89 ca             	mov    %rcx,%rdx
    7b5e:	48 83 e6 03          	and    $0x3,%rsi
    7b62:	74 1e                	je     7b82 <fwp_apply_owned+0x212>
    7b64:	48 89 ca             	mov    %rcx,%rdx
    7b67:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    7b6e:	00 00 
    7b70:	4d 8b 44 d4 08       	mov    0x8(%r12,%rdx,8),%r8
    7b75:	4d 89 44 d5 00       	mov    %r8,0x0(%r13,%rdx,8)
    7b7a:	48 ff c2             	inc    %rdx
    7b7d:	48 ff ce             	dec    %rsi
    7b80:	75 ee                	jne    7b70 <fwp_apply_owned+0x200>
    7b82:	4c 29 f9             	sub    %r15,%rcx
    7b85:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    7b89:	0f 87 81 00 00 00    	ja     7c10 <fwp_apply_owned+0x2a0>
    7b8f:	90                   	nop
    7b90:	49 8b 4c d4 08       	mov    0x8(%r12,%rdx,8),%rcx
    7b95:	49 89 4c d5 00       	mov    %rcx,0x0(%r13,%rdx,8)
    7b9a:	49 8b 4c d4 10       	mov    0x10(%r12,%rdx,8),%rcx
    7b9f:	49 89 4c d5 08       	mov    %rcx,0x8(%r13,%rdx,8)
    7ba4:	49 8b 4c d4 18       	mov    0x18(%r12,%rdx,8),%rcx
    7ba9:	49 89 4c d5 10       	mov    %rcx,0x10(%r13,%rdx,8)
    7bae:	49 8b 4c d4 20       	mov    0x20(%r12,%rdx,8),%rcx
    7bb3:	49 89 4c d5 18       	mov    %rcx,0x18(%r13,%rdx,8)
    7bb8:	48 83 c2 04          	add    $0x4,%rdx
    7bbc:	49 39 d7             	cmp    %rdx,%r15
    7bbf:	75 cf                	jne    7b90 <fwp_apply_owned+0x220>
    7bc1:	eb 4d                	jmp    7c10 <fwp_apply_owned+0x2a0>
    7bc3:	44 89 f9             	mov    %r15d,%ecx
    7bc6:	83 e1 fc             	and    $0xfffffffc,%ecx
    7bc9:	4a 8d 14 fd 00 00 00 	lea    0x0(,%r15,8),%rdx
    7bd0:	00 
    7bd1:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    7bd5:	31 f6                	xor    %esi,%esi
    7bd7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    7bde:	00 00 
    7be0:	41 0f 10 44 34 08    	movups 0x8(%r12,%rsi,1),%xmm0
    7be6:	41 0f 10 4c 34 18    	movups 0x18(%r12,%rsi,1),%xmm1
    7bec:	41 0f 29 44 35 00    	movaps %xmm0,0x0(%r13,%rsi,1)
    7bf2:	41 0f 29 4c 35 10    	movaps %xmm1,0x10(%r13,%rsi,1)
    7bf8:	48 83 c6 20          	add    $0x20,%rsi
    7bfc:	48 39 f2             	cmp    %rsi,%rdx
    7bff:	75 df                	jne    7be0 <fwp_apply_owned+0x270>
    7c01:	4c 39 f9             	cmp    %r15,%rcx
    7c04:	0f 85 4e ff ff ff    	jne    7b58 <fwp_apply_owned+0x1e8>
    7c0a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    7c10:	44 39 f8             	cmp    %r15d,%eax
    7c13:	0f 84 f7 00 00 00    	je     7d10 <fwp_apply_owned+0x3a0>
    7c19:	41 83 fe 0a          	cmp    $0xa,%r14d
    7c1d:	0f 83 95 00 00 00    	jae    7cb8 <fwp_apply_owned+0x348>
    7c23:	31 c0                	xor    %eax,%eax
    7c25:	4c 89 ca             	mov    %r9,%rdx
    7c28:	48 89 c1             	mov    %rax,%rcx
    7c2b:	48 83 e2 03          	and    $0x3,%rdx
    7c2f:	74 24                	je     7c55 <fwp_apply_owned+0x2e5>
    7c31:	48 89 c1             	mov    %rax,%rcx
    7c34:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    7c3b:	00 00 00 00 00 
    7c40:	48 8b 34 cb          	mov    (%rbx,%rcx,8),%rsi
    7c44:	45 8d 04 0f          	lea    (%r15,%rcx,1),%r8d
    7c48:	4b 89 74 c5 00       	mov    %rsi,0x0(%r13,%r8,8)
    7c4d:	48 ff c1             	inc    %rcx
    7c50:	48 ff ca             	dec    %rdx
    7c53:	75 eb                	jne    7c40 <fwp_apply_owned+0x2d0>
    7c55:	4c 29 c8             	sub    %r9,%rax
    7c58:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    7c5c:	0f 87 ae 00 00 00    	ja     7d10 <fwp_apply_owned+0x3a0>
    7c62:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7c69:	1f 84 00 00 00 00 00 
    7c70:	48 8b 04 cb          	mov    (%rbx,%rcx,8),%rax
    7c74:	41 8d 14 0f          	lea    (%r15,%rcx,1),%edx
    7c78:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    7c7d:	48 8b 44 cb 08       	mov    0x8(%rbx,%rcx,8),%rax
    7c82:	41 8d 14 0f          	lea    (%r15,%rcx,1),%edx
    7c86:	ff c2                	inc    %edx
    7c88:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    7c8d:	48 8b 44 cb 10       	mov    0x10(%rbx,%rcx,8),%rax
    7c92:	41 8d 54 0f 02       	lea    0x2(%r15,%rcx,1),%edx
    7c97:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    7c9c:	48 8b 44 cb 18       	mov    0x18(%rbx,%rcx,8),%rax
    7ca1:	41 8d 14 0f          	lea    (%r15,%rcx,1),%edx
    7ca5:	83 c2 03             	add    $0x3,%edx
    7ca8:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    7cad:	48 83 c1 04          	add    $0x4,%rcx
    7cb1:	49 39 c9             	cmp    %rcx,%r9
    7cb4:	75 ba                	jne    7c70 <fwp_apply_owned+0x300>
    7cb6:	eb 58                	jmp    7d10 <fwp_apply_owned+0x3a0>
    7cb8:	49 8d 41 ff          	lea    -0x1(%r9),%rax
    7cbc:	89 c1                	mov    %eax,%ecx
    7cbe:	44 01 f9             	add    %r15d,%ecx
    7cc1:	0f 82 5c ff ff ff    	jb     7c23 <fwp_apply_owned+0x2b3>
    7cc7:	48 c1 e8 20          	shr    $0x20,%rax
    7ccb:	b8 00 00 00 00       	mov    $0x0,%eax
    7cd0:	0f 85 4f ff ff ff    	jne    7c25 <fwp_apply_owned+0x2b5>
    7cd6:	44 89 c8             	mov    %r9d,%eax
    7cd9:	83 e0 fc             	and    $0xfffffffc,%eax
    7cdc:	31 c9                	xor    %ecx,%ecx
    7cde:	66 90                	xchg   %ax,%ax
    7ce0:	0f 10 04 cb          	movups (%rbx,%rcx,8),%xmm0
    7ce4:	0f 10 4c cb 10       	movups 0x10(%rbx,%rcx,8),%xmm1
    7ce9:	41 8d 14 0f          	lea    (%r15,%rcx,1),%edx
    7ced:	41 0f 11 44 d5 00    	movups %xmm0,0x0(%r13,%rdx,8)
    7cf3:	41 0f 11 4c d5 10    	movups %xmm1,0x10(%r13,%rdx,8)
    7cf9:	48 83 c1 04          	add    $0x4,%rcx
    7cfd:	48 39 c8             	cmp    %rcx,%rax
    7d00:	75 de                	jne    7ce0 <fwp_apply_owned+0x370>
    7d02:	4c 39 c8             	cmp    %r9,%rax
    7d05:	0f 85 1a ff ff ff    	jne    7c25 <fwp_apply_owned+0x2b5>
    7d0b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7d10:	49 8b 02             	mov    (%r10),%rax
    7d13:	49 89 ff             	mov    %rdi,%r15
    7d16:	be 01 00 00 00       	mov    $0x1,%esi
    7d1b:	4d 89 d4             	mov    %r10,%r12
    7d1e:	ff 50 08             	call   *0x8(%rax)
    7d21:	44 89 75 80          	mov    %r14d,-0x80(%rbp)
    7d25:	49 8b 04 24          	mov    (%r12),%rax
    7d29:	4c 89 ef             	mov    %r13,%rdi
    7d2c:	ff 10                	call   *(%rax)
    7d2e:	49 89 c4             	mov    %rax,%r12
    7d31:	48 8b 65 90          	mov    -0x70(%rbp),%rsp
    7d35:	4c 8b 6d d0          	mov    -0x30(%rbp),%r13
    7d39:	80 7d cc 00          	cmpb   $0x0,-0x34(%rbp)
    7d3d:	4c 89 ff             	mov    %r15,%rdi
    7d40:	74 1c                	je     7d5e <fwp_apply_owned+0x3ee>
    7d42:	48 8d 45 98          	lea    -0x68(%rbp),%rax
    7d46:	48 39 05 6b 41 01 00 	cmp    %rax,0x1416b(%rip)        # 1beb8 <fwp_cleanups>
    7d4d:	0f 85 74 04 00 00    	jne    81c7 <fwp_apply_owned+0x857>
    7d53:	48 8b 45 98          	mov    -0x68(%rbp),%rax
    7d57:	48 89 05 5a 41 01 00 	mov    %rax,0x1415a(%rip)        # 1beb8 <fwp_cleanups>
    7d5e:	e8 3d 25 00 00       	call   a2a0 <fwp_closure_drop>
    7d63:	44 2b 6d b8          	sub    -0x48(%rbp),%r13d
    7d67:	0f 84 48 04 00 00    	je     81b5 <fwp_apply_owned+0x845>
    7d6d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
    7d71:	48 8d 1c c3          	lea    (%rbx,%rax,8),%rbx
    7d75:	48 8b 05 f4 40 01 00 	mov    0x140f4(%rip),%rax        # 1be70 <fwp_fns>
    7d7c:	41 8b 14 24          	mov    (%r12),%edx
    7d80:	48 89 d1             	mov    %rdx,%rcx
    7d83:	48 c1 e1 05          	shl    $0x5,%rcx
    7d87:	4c 8d 14 08          	lea    (%rax,%rcx,1),%r10
    7d8b:	49 83 c2 18          	add    $0x18,%r10
    7d8f:	48 8b 4c 08 18       	mov    0x18(%rax,%rcx,1),%rcx
    7d94:	4c 89 e7             	mov    %r12,%rdi
    7d97:	48 85 c9             	test   %rcx,%rcx
    7d9a:	0f 85 20 fc ff ff    	jne    79c0 <fwp_apply_owned+0x50>
    7da0:	eb 03                	jmp    7da5 <fwp_apply_owned+0x435>
    7da2:	49 89 fc             	mov    %rdi,%r12
    7da5:	4c 89 e7             	mov    %r12,%rdi
    7da8:	e8 33 eb ff ff       	call   68e0 <fwp_rc_share>
    7dad:	45 85 ed             	test   %r13d,%r13d
    7db0:	74 1f                	je     7dd1 <fwp_apply_owned+0x461>
    7db2:	45 89 ee             	mov    %r13d,%r14d
    7db5:	45 31 ff             	xor    %r15d,%r15d
    7db8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    7dbf:	00 
    7dc0:	4a 8b 3c fb          	mov    (%rbx,%r15,8),%rdi
    7dc4:	e8 17 eb ff ff       	call   68e0 <fwp_rc_share>
    7dc9:	49 ff c7             	inc    %r15
    7dcc:	4d 39 fe             	cmp    %r15,%r14
    7dcf:	75 ef                	jne    7dc0 <fwp_apply_owned+0x450>
    7dd1:	4c 89 e7             	mov    %r12,%rdi
    7dd4:	44 89 ee             	mov    %r13d,%esi
    7dd7:	48 89 da             	mov    %rbx,%rdx
    7dda:	e8 c1 f5 ff ff       	call   73a0 <fwp_apply>
    7ddf:	49 89 c4             	mov    %rax,%r12
    7de2:	e9 ce 03 00 00       	jmp    81b5 <fwp_apply_owned+0x845>
    7de7:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    7deb:	4c 89 6d d0          	mov    %r13,-0x30(%rbp)
    7def:	44 89 f0             	mov    %r14d,%eax
    7df2:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    7df9:	00 
    7dfa:	4c 89 55 c0          	mov    %r10,-0x40(%rbp)
    7dfe:	e8 9d 29 00 00       	call   a7a0 <fwp_alloc_init>
    7e03:	4c 8b 55 c0          	mov    -0x40(%rbp),%r10
    7e07:	49 89 c5             	mov    %rax,%r13
    7e0a:	41 8b 04 24          	mov    (%r12),%eax
    7e0e:	41 89 45 00          	mov    %eax,0x0(%r13)
    7e12:	45 89 75 04          	mov    %r14d,0x4(%r13)
    7e16:	4c 89 e8             	mov    %r13,%rax
    7e19:	48 2b 05 98 34 01 00 	sub    0x13498(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    7e20:	48 8b 0d b9 34 01 00 	mov    0x134b9(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    7e27:	48 c1 e1 10          	shl    $0x10,%rcx
    7e2b:	48 39 c8             	cmp    %rcx,%rax
    7e2e:	73 73                	jae    7ea3 <fwp_apply_owned+0x533>
    7e30:	48 8b 0d c9 34 01 00 	mov    0x134c9(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    7e37:	48 89 c2             	mov    %rax,%rdx
    7e3a:	48 c1 ea 10          	shr    $0x10,%rdx
    7e3e:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    7e45:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    7e49:	48 25 ff ff 00 00    	and    $0xffff,%rax
    7e4f:	75 1d                	jne    7e6e <fwp_apply_owned+0x4fe>
    7e51:	40 80 fe 02          	cmp    $0x2,%sil
    7e55:	75 17                	jne    7e6e <fwp_apply_owned+0x4fe>
    7e57:	4c 8d 34 11          	lea    (%rcx,%rdx,1),%r14
    7e5b:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    7e62:	41 80 3e ff          	cmpb   $0xff,(%r14)
    7e66:	74 2d                	je     7e95 <fwp_apply_owned+0x525>
    7e68:	41 c6 06 01          	movb   $0x1,(%r14)
    7e6c:	eb 35                	jmp    7ea3 <fwp_apply_owned+0x533>
    7e6e:	40 80 fe 01          	cmp    $0x1,%sil
    7e72:	75 2f                	jne    7ea3 <fwp_apply_owned+0x533>
    7e74:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    7e78:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    7e7c:	48 0f af c1          	imul   %rcx,%rax
    7e80:	48 c1 e8 20          	shr    $0x20,%rax
    7e84:	4c 8d 34 30          	lea    (%rax,%rsi,1),%r14
    7e88:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    7e8f:	41 80 3e ff          	cmpb   $0xff,(%r14)
    7e93:	75 d3                	jne    7e68 <fwp_apply_owned+0x4f8>
    7e95:	4c 89 f7             	mov    %r14,%rdi
    7e98:	e8 73 ec ff ff       	call   6b10 <fwp_rc_forget_slot>
    7e9d:	4c 8b 55 c0          	mov    -0x40(%rbp),%r10
    7ea1:	eb c5                	jmp    7e68 <fwp_apply_owned+0x4f8>
    7ea3:	4c 89 6d b0          	mov    %r13,-0x50(%rbp)
    7ea7:	48 8b 05 0a 40 01 00 	mov    0x1400a(%rip),%rax        # 1beb8 <fwp_cleanups>
    7eae:	48 89 85 50 ff ff ff 	mov    %rax,-0xb0(%rbp)
    7eb5:	48 8d 05 24 2a 00 00 	lea    0x2a24(%rip),%rax        # a8e0 <fwp_rc_cleanup_cell>
    7ebc:	48 89 85 58 ff ff ff 	mov    %rax,-0xa8(%rbp)
    7ec3:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
    7ec7:	48 89 85 60 ff ff ff 	mov    %rax,-0xa0(%rbp)
    7ece:	4c 8d b5 50 ff ff ff 	lea    -0xb0(%rbp),%r14
    7ed5:	4c 89 35 dc 3f 01 00 	mov    %r14,0x13fdc(%rip)        # 1beb8 <fwp_cleanups>
    7edc:	4d 85 ff             	test   %r15,%r15
    7edf:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
    7ee3:	0f 84 c8 00 00 00    	je     7fb1 <fwp_apply_owned+0x641>
    7ee9:	31 c0                	xor    %eax,%eax
    7eeb:	41 83 ff 06          	cmp    $0x6,%r15d
    7eef:	72 55                	jb     7f46 <fwp_apply_owned+0x5d6>
    7ef1:	4c 89 e9             	mov    %r13,%rcx
    7ef4:	4c 29 e1             	sub    %r12,%rcx
    7ef7:	48 83 f9 20          	cmp    $0x20,%rcx
    7efb:	72 49                	jb     7f46 <fwp_apply_owned+0x5d6>
    7efd:	44 89 f8             	mov    %r15d,%eax
    7f00:	83 e0 fc             	and    $0xfffffffc,%eax
    7f03:	4a 8d 0c fd 00 00 00 	lea    0x0(,%r15,8),%rcx
    7f0a:	00 
    7f0b:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    7f0f:	31 d2                	xor    %edx,%edx
    7f11:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7f18:	0f 1f 84 00 00 00 00 
    7f1f:	00 
    7f20:	41 0f 10 44 14 08    	movups 0x8(%r12,%rdx,1),%xmm0
    7f26:	41 0f 10 4c 14 18    	movups 0x18(%r12,%rdx,1),%xmm1
    7f2c:	41 0f 11 44 15 08    	movups %xmm0,0x8(%r13,%rdx,1)
    7f32:	41 0f 11 4c 15 18    	movups %xmm1,0x18(%r13,%rdx,1)
    7f38:	48 83 c2 20          	add    $0x20,%rdx
    7f3c:	48 39 d1             	cmp    %rdx,%rcx
    7f3f:	75 df                	jne    7f20 <fwp_apply_owned+0x5b0>
    7f41:	4c 39 f8             	cmp    %r15,%rax
    7f44:	74 6b                	je     7fb1 <fwp_apply_owned+0x641>
    7f46:	4c 89 fa             	mov    %r15,%rdx
    7f49:	48 89 c1             	mov    %rax,%rcx
    7f4c:	48 83 e2 03          	and    $0x3,%rdx
    7f50:	74 20                	je     7f72 <fwp_apply_owned+0x602>
    7f52:	48 89 c1             	mov    %rax,%rcx
    7f55:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    7f5c:	00 00 00 00 
    7f60:	49 8b 74 cc 08       	mov    0x8(%r12,%rcx,8),%rsi
    7f65:	49 89 74 cd 08       	mov    %rsi,0x8(%r13,%rcx,8)
    7f6a:	48 ff c1             	inc    %rcx
    7f6d:	48 ff ca             	dec    %rdx
    7f70:	75 ee                	jne    7f60 <fwp_apply_owned+0x5f0>
    7f72:	4c 29 f8             	sub    %r15,%rax
    7f75:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    7f79:	77 36                	ja     7fb1 <fwp_apply_owned+0x641>
    7f7b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7f80:	49 8b 44 cc 08       	mov    0x8(%r12,%rcx,8),%rax
    7f85:	49 89 44 cd 08       	mov    %rax,0x8(%r13,%rcx,8)
    7f8a:	49 8b 44 cc 10       	mov    0x10(%r12,%rcx,8),%rax
    7f8f:	49 89 44 cd 10       	mov    %rax,0x10(%r13,%rcx,8)
    7f94:	49 8b 44 cc 18       	mov    0x18(%r12,%rcx,8),%rax
    7f99:	49 89 44 cd 18       	mov    %rax,0x18(%r13,%rcx,8)
    7f9e:	49 8b 44 cc 20       	mov    0x20(%r12,%rcx,8),%rax
    7fa3:	49 89 44 cd 20       	mov    %rax,0x20(%r13,%rcx,8)
    7fa8:	48 83 c1 04          	add    $0x4,%rcx
    7fac:	49 39 cf             	cmp    %rcx,%r15
    7faf:	75 cf                	jne    7f80 <fwp_apply_owned+0x610>
    7fb1:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
    7fb5:	0f 84 8b 00 00 00    	je     8046 <fwp_apply_owned+0x6d6>
    7fbb:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
    7fbf:	89 c8                	mov    %ecx,%eax
    7fc1:	83 f9 14             	cmp    $0x14,%ecx
    7fc4:	0f 83 f4 00 00 00    	jae    80be <fwp_apply_owned+0x74e>
    7fca:	31 c9                	xor    %ecx,%ecx
    7fcc:	48 89 c6             	mov    %rax,%rsi
    7fcf:	48 89 ca             	mov    %rcx,%rdx
    7fd2:	48 83 e6 03          	and    $0x3,%rsi
    7fd6:	74 1d                	je     7ff5 <fwp_apply_owned+0x685>
    7fd8:	48 89 ca             	mov    %rcx,%rdx
    7fdb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7fe0:	4c 8b 0c d3          	mov    (%rbx,%rdx,8),%r9
    7fe4:	45 8d 04 17          	lea    (%r15,%rdx,1),%r8d
    7fe8:	4f 89 4c c5 08       	mov    %r9,0x8(%r13,%r8,8)
    7fed:	48 ff c2             	inc    %rdx
    7ff0:	48 ff ce             	dec    %rsi
    7ff3:	75 eb                	jne    7fe0 <fwp_apply_owned+0x670>
    7ff5:	48 29 c1             	sub    %rax,%rcx
    7ff8:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    7ffc:	77 48                	ja     8046 <fwp_apply_owned+0x6d6>
    7ffe:	66 90                	xchg   %ax,%ax
    8000:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    8004:	41 8d 34 17          	lea    (%r15,%rdx,1),%esi
    8008:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    800d:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    8012:	41 8d 34 17          	lea    (%r15,%rdx,1),%esi
    8016:	ff c6                	inc    %esi
    8018:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    801d:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    8022:	41 8d 74 17 02       	lea    0x2(%r15,%rdx,1),%esi
    8027:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    802c:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    8031:	41 8d 34 17          	lea    (%r15,%rdx,1),%esi
    8035:	83 c6 03             	add    $0x3,%esi
    8038:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    803d:	48 83 c2 04          	add    $0x4,%rdx
    8041:	48 39 d0             	cmp    %rdx,%rax
    8044:	75 ba                	jne    8000 <fwp_apply_owned+0x690>
    8046:	49 8b 02             	mov    (%r10),%rax
    8049:	be 01 00 00 00       	mov    $0x1,%esi
    804e:	ff 50 08             	call   *0x8(%rax)
    8051:	4c 89 e8             	mov    %r13,%rax
    8054:	48 2b 05 5d 32 01 00 	sub    0x1325d(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    805b:	48 8b 0d 7e 32 01 00 	mov    0x1327e(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    8062:	48 c1 e1 10          	shl    $0x10,%rcx
    8066:	48 39 c8             	cmp    %rcx,%rax
    8069:	0f 83 fa 00 00 00    	jae    8169 <fwp_apply_owned+0x7f9>
    806f:	48 8b 0d 8a 32 01 00 	mov    0x1328a(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    8076:	48 89 c2             	mov    %rax,%rdx
    8079:	48 c1 ea 10          	shr    $0x10,%rdx
    807d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    8084:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    8088:	48 25 ff ff 00 00    	and    $0xffff,%rax
    808e:	0f 85 9c 00 00 00    	jne    8130 <fwp_apply_owned+0x7c0>
    8094:	40 80 fe 02          	cmp    $0x2,%sil
    8098:	0f 85 92 00 00 00    	jne    8130 <fwp_apply_owned+0x7c0>
    809e:	4c 8d 24 11          	lea    (%rcx,%rdx,1),%r12
    80a2:	49 81 c4 28 02 00 00 	add    $0x228,%r12
    80a9:	41 80 3c 24 ff       	cmpb   $0xff,(%r12)
    80ae:	0f 84 a8 00 00 00    	je     815c <fwp_apply_owned+0x7ec>
    80b4:	41 c6 04 24 01       	movb   $0x1,(%r12)
    80b9:	e9 ab 00 00 00       	jmp    8169 <fwp_apply_owned+0x7f9>
    80be:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    80c2:	31 c9                	xor    %ecx,%ecx
    80c4:	89 d6                	mov    %edx,%esi
    80c6:	44 01 fe             	add    %r15d,%esi
    80c9:	0f 82 fd fe ff ff    	jb     7fcc <fwp_apply_owned+0x65c>
    80cf:	48 c1 ea 20          	shr    $0x20,%rdx
    80d3:	0f 85 f3 fe ff ff    	jne    7fcc <fwp_apply_owned+0x65c>
    80d9:	4a 8d 0c fd 00 00 00 	lea    0x0(,%r15,8),%rcx
    80e0:	00 
    80e1:	4c 01 e9             	add    %r13,%rcx
    80e4:	48 29 d9             	sub    %rbx,%rcx
    80e7:	48 83 c1 08          	add    $0x8,%rcx
    80eb:	48 83 f9 20          	cmp    $0x20,%rcx
    80ef:	0f 82 d5 fe ff ff    	jb     7fca <fwp_apply_owned+0x65a>
    80f5:	89 c1                	mov    %eax,%ecx
    80f7:	83 e1 fc             	and    $0xfffffffc,%ecx
    80fa:	31 d2                	xor    %edx,%edx
    80fc:	0f 1f 40 00          	nopl   0x0(%rax)
    8100:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    8104:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    8109:	41 8d 34 17          	lea    (%r15,%rdx,1),%esi
    810d:	41 0f 11 44 f5 08    	movups %xmm0,0x8(%r13,%rsi,8)
    8113:	41 0f 11 4c f5 18    	movups %xmm1,0x18(%r13,%rsi,8)
    8119:	48 83 c2 04          	add    $0x4,%rdx
    811d:	48 39 d1             	cmp    %rdx,%rcx
    8120:	75 de                	jne    8100 <fwp_apply_owned+0x790>
    8122:	48 39 c1             	cmp    %rax,%rcx
    8125:	0f 85 a1 fe ff ff    	jne    7fcc <fwp_apply_owned+0x65c>
    812b:	e9 16 ff ff ff       	jmp    8046 <fwp_apply_owned+0x6d6>
    8130:	40 80 fe 01          	cmp    $0x1,%sil
    8134:	75 33                	jne    8169 <fwp_apply_owned+0x7f9>
    8136:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    813a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    813e:	48 0f af c1          	imul   %rcx,%rax
    8142:	48 c1 e8 20          	shr    $0x20,%rax
    8146:	4c 8d 24 30          	lea    (%rax,%rsi,1),%r12
    814a:	49 81 c4 28 02 00 00 	add    $0x228,%r12
    8151:	41 80 3c 24 ff       	cmpb   $0xff,(%r12)
    8156:	0f 85 58 ff ff ff    	jne    80b4 <fwp_apply_owned+0x744>
    815c:	4c 89 e7             	mov    %r12,%rdi
    815f:	e8 ac e9 ff ff       	call   6b10 <fwp_rc_forget_slot>
    8164:	e9 4b ff ff ff       	jmp    80b4 <fwp_apply_owned+0x744>
    8169:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    816d:	89 45 80             	mov    %eax,-0x80(%rbp)
    8170:	48 c7 45 b0 00 00 00 	movq   $0x0,-0x50(%rbp)
    8177:	00 
    8178:	4c 39 35 39 3d 01 00 	cmp    %r14,0x13d39(%rip)        # 1beb8 <fwp_cleanups>
    817f:	75 46                	jne    81c7 <fwp_apply_owned+0x857>
    8181:	48 8b 85 50 ff ff ff 	mov    -0xb0(%rbp),%rax
    8188:	48 89 05 29 3d 01 00 	mov    %rax,0x13d29(%rip)        # 1beb8 <fwp_cleanups>
    818f:	80 7d cc 00          	cmpb   $0x0,-0x34(%rbp)
    8193:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
    8197:	74 14                	je     81ad <fwp_apply_owned+0x83d>
    8199:	48 8d 4d 98          	lea    -0x68(%rbp),%rcx
    819d:	48 39 c8             	cmp    %rcx,%rax
    81a0:	75 25                	jne    81c7 <fwp_apply_owned+0x857>
    81a2:	48 8b 45 98          	mov    -0x68(%rbp),%rax
    81a6:	48 89 05 0b 3d 01 00 	mov    %rax,0x13d0b(%rip)        # 1beb8 <fwp_cleanups>
    81ad:	e8 ee 20 00 00       	call   a2a0 <fwp_closure_drop>
    81b2:	4d 89 ec             	mov    %r13,%r12
    81b5:	4c 89 e0             	mov    %r12,%rax
    81b8:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    81bc:	5b                   	pop    %rbx
    81bd:	41 5c                	pop    %r12
    81bf:	41 5d                	pop    %r13
    81c1:	41 5e                	pop    %r14
    81c3:	41 5f                	pop    %r15
    81c5:	5d                   	pop    %rbp
    81c6:	c3                   	ret
    81c7:	e8 a4 ae ff ff       	call   3070 <abort@plt>
    81cc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000081d0 <fwp_alloc>:
    81d0:	53                   	push   %rbx
    81d1:	48 ff 05 d0 3c 01 00 	incq   0x13cd0(%rip)        # 1bea8 <measured_calls>
    81d8:	48 01 3d d1 3c 01 00 	add    %rdi,0x13cd1(%rip)        # 1beb0 <measured_bytes>
    81df:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    81e6:	77 61                	ja     8249 <fwp_alloc+0x79>
    81e8:	48 8d 4f 0f          	lea    0xf(%rdi),%rcx
    81ec:	48 c1 e9 04          	shr    $0x4,%rcx
    81f0:	48 8d 05 91 20 01 00 	lea    0x12091(%rip),%rax        # 1a288 <fwp_gc>
    81f7:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    81fe:	00 
    81ff:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    8206:	48 29 15 7b 20 01 00 	sub    %rdx,0x1207b(%rip)        # 1a288 <fwp_gc>
    820d:	78 3a                	js     8249 <fwp_alloc+0x79>
    820f:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    8213:	48 8d 34 c8          	lea    (%rax,%rcx,8),%rsi
    8217:	48 81 c6 88 07 00 00 	add    $0x788,%rsi
    821e:	48 8b 1e             	mov    (%rsi),%rbx
    8221:	48 85 db             	test   %rbx,%rbx
    8224:	74 0b                	je     8231 <fwp_alloc+0x61>
    8226:	48 8b 03             	mov    (%rbx),%rax
    8229:	48 f7 d0             	not    %rax
    822c:	48 89 06             	mov    %rax,(%rsi)
    822f:	eb 31                	jmp    8262 <fwp_alloc+0x92>
    8231:	48 8b 9c c8 90 07 00 	mov    0x790(%rax,%rcx,8),%rbx
    8238:	00 
    8239:	48 8b b4 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%rsi
    8240:	00 
    8241:	48 29 de             	sub    %rbx,%rsi
    8244:	48 39 d6             	cmp    %rdx,%rsi
    8247:	73 08                	jae    8251 <fwp_alloc+0x81>
    8249:	be 02 00 00 00       	mov    $0x2,%esi
    824e:	5b                   	pop    %rbx
    824f:	eb 2f                	jmp    8280 <fwp_gc_alloc_slow>
    8251:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    8255:	48 05 90 07 00 00    	add    $0x790,%rax
    825b:	48 8d 0c 13          	lea    (%rbx,%rdx,1),%rcx
    825f:	48 89 08             	mov    %rcx,(%rax)
    8262:	48 89 df             	mov    %rbx,%rdi
    8265:	31 f6                	xor    %esi,%esi
    8267:	e8 a4 af ff ff       	call   3210 <memset@plt>
    826c:	48 89 d8             	mov    %rbx,%rax
    826f:	5b                   	pop    %rbx
    8270:	c3                   	ret
    8271:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8278:	0f 1f 84 00 00 00 00 
    827f:	00 

0000000000008280 <fwp_gc_alloc_slow>:
    8280:	55                   	push   %rbp
    8281:	41 57                	push   %r15
    8283:	41 56                	push   %r14
    8285:	41 54                	push   %r12
    8287:	53                   	push   %rbx
    8288:	89 f5                	mov    %esi,%ebp
    828a:	48 89 fb             	mov    %rdi,%rbx
    828d:	83 3d e0 2f 01 00 00 	cmpl   $0x0,0x12fe0(%rip)        # 1b274 <fwp_gc+0xfec>
    8294:	74 1b                	je     82b1 <fwp_gc_alloc_slow+0x31>
    8296:	48 81 fb 01 40 00 00 	cmp    $0x4001,%rbx
    829d:	72 20                	jb     82bf <fwp_gc_alloc_slow+0x3f>
    829f:	48 89 df             	mov    %rbx,%rdi
    82a2:	89 ee                	mov    %ebp,%esi
    82a4:	5b                   	pop    %rbx
    82a5:	41 5c                	pop    %r12
    82a7:	41 5e                	pop    %r14
    82a9:	41 5f                	pop    %r15
    82ab:	5d                   	pop    %rbp
    82ac:	e9 9f 04 00 00       	jmp    8750 <fwp_gc_alloc_big>
    82b1:	e8 ba 00 00 00       	call   8370 <fwp_gc_init>
    82b6:	48 81 fb 01 40 00 00 	cmp    $0x4001,%rbx
    82bd:	73 e0                	jae    829f <fwp_gc_alloc_slow+0x1f>
    82bf:	48 8d 43 0f          	lea    0xf(%rbx),%rax
    82c3:	48 c1 e8 04          	shr    $0x4,%rax
    82c7:	4c 8d 25 ba 1f 01 00 	lea    0x11fba(%rip),%r12        # 1a288 <fwp_gc>
    82ce:	46 0f b6 bc 20 e8 0b 	movzbl 0xbe8(%rax,%r12,1),%r15d
    82d5:	00 00 
    82d7:	47 8b b4 bc 48 0b 00 	mov    0xb48(%r12,%r15,4),%r14d
    82de:	00 
    82df:	48 83 3d a1 1f 01 00 	cmpq   $0x0,0x11fa1(%rip)        # 1a288 <fwp_gc>
    82e6:	00 
    82e7:	79 05                	jns    82ee <fwp_gc_alloc_slow+0x6e>
    82e9:	e8 02 06 00 00       	call   88f0 <fwp_gc_spent>
    82ee:	89 e8                	mov    %ebp,%eax
    82f0:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    82f7:	49 01 c4             	add    %rax,%r12
    82fa:	4b 8d 0c 7f          	lea    (%r15,%r15,2),%rcx
    82fe:	49 8d 04 cc          	lea    (%r12,%rcx,8),%rax
    8302:	48 83 c0 08          	add    $0x8,%rax
    8306:	49 8b 7c cc 08       	mov    0x8(%r12,%rcx,8),%rdi
    830b:	48 85 ff             	test   %rdi,%rdi
    830e:	74 08                	je     8318 <fwp_gc_alloc_slow+0x98>
    8310:	48 8b 0f             	mov    (%rdi),%rcx
    8313:	48 f7 d1             	not    %rcx
    8316:	eb 30                	jmp    8348 <fwp_gc_alloc_slow+0xc8>
    8318:	49 8b 7c cc 10       	mov    0x10(%r12,%rcx,8),%rdi
    831d:	49 8b 54 cc 18       	mov    0x18(%r12,%rcx,8),%rdx
    8322:	48 29 fa             	sub    %rdi,%rdx
    8325:	4c 39 f2             	cmp    %r14,%rdx
    8328:	73 12                	jae    833c <fwp_gc_alloc_slow+0xbc>
    832a:	48 89 c7             	mov    %rax,%rdi
    832d:	44 89 fe             	mov    %r15d,%esi
    8330:	89 ea                	mov    %ebp,%edx
    8332:	e8 89 06 00 00       	call   89c0 <fwp_gc_refill>
    8337:	48 89 c7             	mov    %rax,%rdi
    833a:	eb 0f                	jmp    834b <fwp_gc_alloc_slow+0xcb>
    833c:	49 8d 04 cc          	lea    (%r12,%rcx,8),%rax
    8340:	48 83 c0 10          	add    $0x10,%rax
    8344:	4a 8d 0c 37          	lea    (%rdi,%r14,1),%rcx
    8348:	48 89 08             	mov    %rcx,(%rax)
    834b:	83 fd 01             	cmp    $0x1,%ebp
    834e:	4c 0f 44 f3          	cmove  %rbx,%r14
    8352:	31 f6                	xor    %esi,%esi
    8354:	4c 89 f2             	mov    %r14,%rdx
    8357:	5b                   	pop    %rbx
    8358:	41 5c                	pop    %r12
    835a:	41 5e                	pop    %r14
    835c:	41 5f                	pop    %r15
    835e:	5d                   	pop    %rbp
    835f:	e9 ac ae ff ff       	jmp    3210 <memset@plt>
    8364:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    836b:	00 00 00 00 00 

0000000000008370 <fwp_gc_init>:
    8370:	53                   	push   %rbx
    8371:	c7 05 f9 2e 01 00 01 	movl   $0x1,0x12ef9(%rip)        # 1b274 <fwp_gc+0xfec>
    8378:	00 00 00 
    837b:	0f 28 05 9e cc 00 00 	movaps 0xcc9e(%rip),%xmm0        # 15020 <_IO_stdin_used+0x20>
    8382:	0f 11 05 47 2a 01 00 	movups %xmm0,0x12a47(%rip)        # 1add0 <fwp_gc+0xb48>
    8389:	0f 28 05 a0 cc 00 00 	movaps 0xcca0(%rip),%xmm0        # 15030 <_IO_stdin_used+0x30>
    8390:	0f 11 05 49 2a 01 00 	movups %xmm0,0x12a49(%rip)        # 1ade0 <fwp_gc+0xb58>
    8397:	0f 28 05 a2 cc 00 00 	movaps 0xcca2(%rip),%xmm0        # 15040 <_IO_stdin_used+0x40>
    839e:	0f 11 05 4b 2a 01 00 	movups %xmm0,0x12a4b(%rip)        # 1adf0 <fwp_gc+0xb68>
    83a5:	0f 28 05 a4 cc 00 00 	movaps 0xcca4(%rip),%xmm0        # 15050 <_IO_stdin_used+0x50>
    83ac:	0f 11 05 4d 2a 01 00 	movups %xmm0,0x12a4d(%rip)        # 1ae00 <fwp_gc+0xb78>
    83b3:	0f 28 05 a6 cc 00 00 	movaps 0xcca6(%rip),%xmm0        # 15060 <_IO_stdin_used+0x60>
    83ba:	0f 11 05 4f 2a 01 00 	movups %xmm0,0x12a4f(%rip)        # 1ae10 <fwp_gc+0xb88>
    83c1:	0f 28 05 a8 cc 00 00 	movaps 0xcca8(%rip),%xmm0        # 15070 <_IO_stdin_used+0x70>
    83c8:	0f 11 05 51 2a 01 00 	movups %xmm0,0x12a51(%rip)        # 1ae20 <fwp_gc+0xb98>
    83cf:	0f 28 05 aa cc 00 00 	movaps 0xccaa(%rip),%xmm0        # 15080 <_IO_stdin_used+0x80>
    83d6:	0f 11 05 53 2a 01 00 	movups %xmm0,0x12a53(%rip)        # 1ae30 <fwp_gc+0xba8>
    83dd:	0f 28 05 ac cc 00 00 	movaps 0xccac(%rip),%xmm0        # 15090 <_IO_stdin_used+0x90>
    83e4:	0f 11 05 55 2a 01 00 	movups %xmm0,0x12a55(%rip)        # 1ae40 <fwp_gc+0xbb8>
    83eb:	0f 28 05 ae cc 00 00 	movaps 0xccae(%rip),%xmm0        # 150a0 <_IO_stdin_used+0xa0>
    83f2:	0f 11 05 57 2a 01 00 	movups %xmm0,0x12a57(%rip)        # 1ae50 <fwp_gc+0xbc8>
    83f9:	0f 28 05 b0 cc 00 00 	movaps 0xccb0(%rip),%xmm0        # 150b0 <_IO_stdin_used+0xb0>
    8400:	0f 11 05 59 2a 01 00 	movups %xmm0,0x12a59(%rip)        # 1ae60 <fwp_gc+0xbd8>
    8407:	31 c9                	xor    %ecx,%ecx
    8409:	48 8d 05 78 1e 01 00 	lea    0x11e78(%rip),%rax        # 1a288 <fwp_gc>
    8410:	31 d2                	xor    %edx,%edx
    8412:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8419:	1f 84 00 00 00 00 00 
    8420:	89 d6                	mov    %edx,%esi
    8422:	c1 e6 04             	shl    $0x4,%esi
    8425:	48 ff c9             	dec    %rcx
    8428:	48 89 cf             	mov    %rcx,%rdi
    842b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8430:	48 89 f9             	mov    %rdi,%rcx
    8433:	48 ff c7             	inc    %rdi
    8436:	3b b4 88 4c 0b 00 00 	cmp    0xb4c(%rax,%rcx,4),%esi
    843d:	77 f1                	ja     8430 <fwp_gc_init+0xc0>
    843f:	40 88 bc 02 e8 0b 00 	mov    %dil,0xbe8(%rdx,%rax,1)
    8446:	00 
    8447:	48 89 d6             	mov    %rdx,%rsi
    844a:	48 83 ce 01          	or     $0x1,%rsi
    844e:	48 81 fe 01 04 00 00 	cmp    $0x401,%rsi
    8455:	74 26                	je     847d <fwp_gc_init+0x10d>
    8457:	89 f7                	mov    %esi,%edi
    8459:	c1 e7 04             	shl    $0x4,%edi
    845c:	0f 1f 40 00          	nopl   0x0(%rax)
    8460:	49 89 c8             	mov    %rcx,%r8
    8463:	48 ff c1             	inc    %rcx
    8466:	42 3b bc 80 4c 0b 00 	cmp    0xb4c(%rax,%r8,4),%edi
    846d:	00 
    846e:	77 f0                	ja     8460 <fwp_gc_init+0xf0>
    8470:	88 8c 06 e8 0b 00 00 	mov    %cl,0xbe8(%rsi,%rax,1)
    8477:	48 83 c2 02          	add    $0x2,%rdx
    847b:	eb a3                	jmp    8420 <fwp_gc_init+0xb0>
    847d:	48 bb 00 00 00 00 10 	movabs $0x1000000000,%rbx
    8484:	00 00 00 
    8487:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    848e:	31 ff                	xor    %edi,%edi
    8490:	31 d2                	xor    %edx,%edx
    8492:	b9 22 40 00 00       	mov    $0x4022,%ecx
    8497:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    849d:	45 31 c9             	xor    %r9d,%r9d
    84a0:	e8 eb ac ff ff       	call   3190 <mmap@plt>
    84a5:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    84a9:	75 60                	jne    850b <fwp_gc_init+0x19b>
    84ab:	48 bb 00 00 00 00 04 	movabs $0x400000000,%rbx
    84b2:	00 00 00 
    84b5:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    84bc:	31 ff                	xor    %edi,%edi
    84be:	31 d2                	xor    %edx,%edx
    84c0:	b9 22 40 00 00       	mov    $0x4022,%ecx
    84c5:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    84cb:	45 31 c9             	xor    %r9d,%r9d
    84ce:	e8 bd ac ff ff       	call   3190 <mmap@plt>
    84d3:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    84d7:	75 32                	jne    850b <fwp_gc_init+0x19b>
    84d9:	48 bb 00 00 00 00 01 	movabs $0x100000000,%rbx
    84e0:	00 00 00 
    84e3:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    84ea:	31 ff                	xor    %edi,%edi
    84ec:	31 d2                	xor    %edx,%edx
    84ee:	b9 22 40 00 00       	mov    $0x4022,%ecx
    84f3:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    84f9:	45 31 c9             	xor    %r9d,%r9d
    84fc:	e8 8f ac ff ff       	call   3190 <mmap@plt>
    8501:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    8505:	0f 84 b5 01 00 00    	je     86c0 <fwp_gc_init+0x350>
    850b:	48 85 c0             	test   %rax,%rax
    850e:	0f 84 0d 02 00 00    	je     8721 <fwp_gc_init+0x3b1>
    8514:	48 89 05 a5 2d 01 00 	mov    %rax,0x12da5(%rip)        # 1b2c0 <fwp_gc+0x1038>
    851b:	48 89 d9             	mov    %rbx,%rcx
    851e:	48 81 c9 00 00 01 00 	or     $0x10000,%rcx
    8525:	48 89 0d 9c 2d 01 00 	mov    %rcx,0x12d9c(%rip)        # 1b2c8 <fwp_gc+0x1040>
    852c:	48 05 ff ff 00 00    	add    $0xffff,%rax
    8532:	48 25 00 00 ff ff    	and    $0xffffffffffff0000,%rax
    8538:	48 89 05 79 2d 01 00 	mov    %rax,0x12d79(%rip)        # 1b2b8 <fwp_gc+0x1030>
    853f:	48 c1 eb 10          	shr    $0x10,%rbx
    8543:	48 89 1d 8e 2d 01 00 	mov    %rbx,0x12d8e(%rip)        # 1b2d8 <fwp_gc+0x1050>
    854a:	48 69 f3 28 12 00 00 	imul   $0x1228,%rbx,%rsi
    8551:	48 89 35 b0 2d 01 00 	mov    %rsi,0x12db0(%rip)        # 1b308 <fwp_gc+0x1080>
    8558:	31 ff                	xor    %edi,%edi
    855a:	31 d2                	xor    %edx,%edx
    855c:	b9 22 40 00 00       	mov    $0x4022,%ecx
    8561:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    8567:	45 31 c9             	xor    %r9d,%r9d
    856a:	e8 21 ac ff ff       	call   3190 <mmap@plt>
    856f:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    8573:	0f 84 a8 01 00 00    	je     8721 <fwp_gc_init+0x3b1>
    8579:	48 89 05 80 2d 01 00 	mov    %rax,0x12d80(%rip)        # 1b300 <fwp_gc+0x1078>
    8580:	48 8d 3d 22 d5 00 00 	lea    0xd522(%rip),%rdi        # 15aa9 <exec_in_fp0+0x239>
    8587:	e8 a4 aa ff ff       	call   3030 <getenv@plt>
    858c:	48 85 c0             	test   %rax,%rax
    858f:	74 2e                	je     85bf <fwp_gc_init+0x24f>
    8591:	48 89 c3             	mov    %rax,%rbx
    8594:	48 8d 35 15 d5 00 00 	lea    0xd515(%rip),%rsi        # 15ab0 <exec_in_fp0+0x240>
    859b:	48 89 c7             	mov    %rax,%rdi
    859e:	e8 2d ad ff ff       	call   32d0 <strcmp@plt>
    85a3:	85 c0                	test   %eax,%eax
    85a5:	74 1f                	je     85c6 <fwp_gc_init+0x256>
    85a7:	48 8d 35 03 e2 00 00 	lea    0xe203(%rip),%rsi        # 167b1 <exec_in_fp0+0xf41>
    85ae:	48 89 df             	mov    %rbx,%rdi
    85b1:	e8 1a ad ff ff       	call   32d0 <strcmp@plt>
    85b6:	31 c9                	xor    %ecx,%ecx
    85b8:	85 c0                	test   %eax,%eax
    85ba:	0f 95 c1             	setne  %cl
    85bd:	eb 09                	jmp    85c8 <fwp_gc_init+0x258>
    85bf:	b9 01 00 00 00       	mov    $0x1,%ecx
    85c4:	eb 02                	jmp    85c8 <fwp_gc_init+0x258>
    85c6:	31 c9                	xor    %ecx,%ecx
    85c8:	89 0d aa 2c 01 00    	mov    %ecx,0x12caa(%rip)        # 1b278 <fwp_gc+0xff0>
    85ce:	48 8d 3d df d4 00 00 	lea    0xd4df(%rip),%rdi        # 15ab4 <exec_in_fp0+0x244>
    85d5:	e8 56 aa ff ff       	call   3030 <getenv@plt>
    85da:	31 c9                	xor    %ecx,%ecx
    85dc:	48 85 c0             	test   %rax,%rax
    85df:	74 1b                	je     85fc <fwp_gc_init+0x28c>
    85e1:	80 38 00             	cmpb   $0x0,(%rax)
    85e4:	74 16                	je     85fc <fwp_gc_init+0x28c>
    85e6:	48 8d 35 c4 e1 00 00 	lea    0xe1c4(%rip),%rsi        # 167b1 <exec_in_fp0+0xf41>
    85ed:	48 89 c7             	mov    %rax,%rdi
    85f0:	e8 db ac ff ff       	call   32d0 <strcmp@plt>
    85f5:	31 c9                	xor    %ecx,%ecx
    85f7:	85 c0                	test   %eax,%eax
    85f9:	0f 95 c1             	setne  %cl
    85fc:	89 0d 82 2c 01 00    	mov    %ecx,0x12c82(%rip)        # 1b284 <fwp_gc+0xffc>
    8602:	48 8d 3d a0 d4 00 00 	lea    0xd4a0(%rip),%rdi        # 15aa9 <exec_in_fp0+0x239>
    8609:	e8 22 aa ff ff       	call   3030 <getenv@plt>
    860e:	48 85 c0             	test   %rax,%rax
    8611:	74 18                	je     862b <fwp_gc_init+0x2bb>
    8613:	48 8d 35 a7 d4 00 00 	lea    0xd4a7(%rip),%rsi        # 15ac1 <exec_in_fp0+0x251>
    861a:	48 89 c7             	mov    %rax,%rdi
    861d:	e8 ae ac ff ff       	call   32d0 <strcmp@plt>
    8622:	31 c9                	xor    %ecx,%ecx
    8624:	85 c0                	test   %eax,%eax
    8626:	0f 95 c1             	setne  %cl
    8629:	eb 05                	jmp    8630 <fwp_gc_init+0x2c0>
    862b:	b9 01 00 00 00       	mov    $0x1,%ecx
    8630:	89 0d 52 2c 01 00    	mov    %ecx,0x12c52(%rip)        # 1b288 <fwp_gc+0x1000>
    8636:	c7 05 50 2c 01 00 01 	movl   $0x1,0x12c50(%rip)        # 1b290 <fwp_gc+0x1008>
    863d:	00 00 00 
    8640:	48 8d 3d 7f d4 00 00 	lea    0xd47f(%rip),%rdi        # 15ac6 <exec_in_fp0+0x256>
    8647:	e8 e4 a9 ff ff       	call   3030 <getenv@plt>
    864c:	31 c9                	xor    %ecx,%ecx
    864e:	48 85 c0             	test   %rax,%rax
    8651:	74 1b                	je     866e <fwp_gc_init+0x2fe>
    8653:	80 38 00             	cmpb   $0x0,(%rax)
    8656:	74 16                	je     866e <fwp_gc_init+0x2fe>
    8658:	48 8d 35 52 e1 00 00 	lea    0xe152(%rip),%rsi        # 167b1 <exec_in_fp0+0xf41>
    865f:	48 89 c7             	mov    %rax,%rdi
    8662:	e8 69 ac ff ff       	call   32d0 <strcmp@plt>
    8667:	31 c9                	xor    %ecx,%ecx
    8669:	85 c0                	test   %eax,%eax
    866b:	0f 95 c1             	setne  %cl
    866e:	89 0d 18 2c 01 00    	mov    %ecx,0x12c18(%rip)        # 1b28c <fwp_gc+0x1004>
    8674:	48 8d 3d 59 d4 00 00 	lea    0xd459(%rip),%rdi        # 15ad4 <exec_in_fp0+0x264>
    867b:	e8 b0 a9 ff ff       	call   3030 <getenv@plt>
    8680:	48 85 c0             	test   %rax,%rax
    8683:	74 11                	je     8696 <fwp_gc_init+0x326>
    8685:	48 89 c7             	mov    %rax,%rdi
    8688:	31 f6                	xor    %esi,%esi
    868a:	ba 0a 00 00 00       	mov    $0xa,%edx
    868f:	e8 8c ac ff ff       	call   3320 <strtol@plt>
    8694:	eb 02                	jmp    8698 <fwp_gc_init+0x328>
    8696:	31 c0                	xor    %eax,%eax
    8698:	31 c9                	xor    %ecx,%ecx
    869a:	48 85 c0             	test   %rax,%rax
    869d:	48 0f 4f c8          	cmovg  %rax,%rcx
    86a1:	48 89 0d 00 2c 01 00 	mov    %rcx,0x12c00(%rip)        # 1b2a8 <fwp_gc+0x1020>
    86a8:	48 c7 05 e5 2d 01 00 	movq   $0x800000,0x12de5(%rip)        # 1b498 <fwp_gc+0x1210>
    86af:	00 00 80 00 
    86b3:	48 c7 05 ca 1b 01 00 	movq   $0x800000,0x11bca(%rip)        # 1a288 <fwp_gc>
    86ba:	00 00 80 00 
    86be:	5b                   	pop    %rbx
    86bf:	c3                   	ret
    86c0:	be 00 00 01 40       	mov    $0x40010000,%esi
    86c5:	31 ff                	xor    %edi,%edi
    86c7:	31 d2                	xor    %edx,%edx
    86c9:	b9 22 40 00 00       	mov    $0x4022,%ecx
    86ce:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    86d4:	45 31 c9             	xor    %r9d,%r9d
    86d7:	e8 b4 aa ff ff       	call   3190 <mmap@plt>
    86dc:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    86e0:	74 0f                	je     86f1 <fwp_gc_init+0x381>
    86e2:	48 85 c0             	test   %rax,%rax
    86e5:	74 3a                	je     8721 <fwp_gc_init+0x3b1>
    86e7:	bb 00 00 00 40       	mov    $0x40000000,%ebx
    86ec:	e9 23 fe ff ff       	jmp    8514 <fwp_gc_init+0x1a4>
    86f1:	be 00 00 01 10       	mov    $0x10010000,%esi
    86f6:	31 ff                	xor    %edi,%edi
    86f8:	31 d2                	xor    %edx,%edx
    86fa:	b9 22 40 00 00       	mov    $0x4022,%ecx
    86ff:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    8705:	45 31 c9             	xor    %r9d,%r9d
    8708:	e8 83 aa ff ff       	call   3190 <mmap@plt>
    870d:	48 8d 48 01          	lea    0x1(%rax),%rcx
    8711:	48 83 f9 02          	cmp    $0x2,%rcx
    8715:	72 0a                	jb     8721 <fwp_gc_init+0x3b1>
    8717:	bb 00 00 00 10       	mov    $0x10000000,%ebx
    871c:	e9 f3 fd ff ff       	jmp    8514 <fwp_gc_init+0x1a4>
    8721:	48 8b 05 b0 18 01 00 	mov    0x118b0(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    8728:	48 8b 08             	mov    (%rax),%rcx
    872b:	48 8d 3d b0 d3 00 00 	lea    0xd3b0(%rip),%rdi        # 15ae2 <exec_in_fp0+0x272>
    8732:	be 13 00 00 00       	mov    $0x13,%esi
    8737:	ba 01 00 00 00       	mov    $0x1,%edx
    873c:	e8 3f ad ff ff       	call   3480 <fwrite@plt>
    8741:	bf 66 00 00 00       	mov    $0x66,%edi
    8746:	e8 15 ad ff ff       	call   3460 <exit@plt>
    874b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000008750 <fwp_gc_alloc_big>:
    8750:	55                   	push   %rbp
    8751:	41 57                	push   %r15
    8753:	41 56                	push   %r14
    8755:	41 55                	push   %r13
    8757:	41 54                	push   %r12
    8759:	53                   	push   %rbx
    875a:	50                   	push   %rax
    875b:	48 b8 01 00 00 00 00 	movabs $0x4000000000000001,%rax
    8762:	00 00 40 
    8765:	48 39 c7             	cmp    %rax,%rdi
    8768:	0f 83 4e 01 00 00    	jae    88bc <fwp_gc_alloc_big+0x16c>
    876e:	89 f5                	mov    %esi,%ebp
    8770:	48 89 fb             	mov    %rdi,%rbx
    8773:	48 29 3d 0e 1b 01 00 	sub    %rdi,0x11b0e(%rip)        # 1a288 <fwp_gc>
    877a:	79 05                	jns    8781 <fwp_gc_alloc_big+0x31>
    877c:	e8 6f 01 00 00       	call   88f0 <fwp_gc_spent>
    8781:	4c 8d b3 ff ff 00 00 	lea    0xffff(%rbx),%r14
    8788:	49 c1 ee 10          	shr    $0x10,%r14
    878c:	4c 89 f7             	mov    %r14,%rdi
    878f:	e8 5c 03 00 00       	call   8af0 <fwp_gc_chunks>
    8794:	48 8b 0d 65 2b 01 00 	mov    0x12b65(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    879b:	4c 69 e0 28 12 00 00 	imul   $0x1228,%rax,%r12
    87a2:	42 c6 04 21 02       	movb   $0x2,(%rcx,%r12,1)
    87a7:	42 88 6c 21 01       	mov    %bpl,0x1(%rcx,%r12,1)
    87ac:	66 42 c7 44 21 03 00 	movw   $0x100,0x3(%rcx,%r12,1)
    87b3:	01 
    87b4:	46 89 74 21 10       	mov    %r14d,0x10(%rcx,%r12,1)
    87b9:	4a 89 5c 21 18       	mov    %rbx,0x18(%rcx,%r12,1)
    87be:	4e 8d 3c 21          	lea    (%rcx,%r12,1),%r15
    87c2:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    87c9:	42 80 bc 21 28 02 00 	cmpb   $0xff,0x228(%rcx,%r12,1)
    87d0:	00 ff 
    87d2:	0f 84 d1 00 00 00    	je     88a9 <fwp_gc_alloc_big+0x159>
    87d8:	41 c6 07 00          	movb   $0x0,(%r15)
    87dc:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    87e3:	0f 82 9a 00 00 00    	jb     8883 <fwp_gc_alloc_big+0x133>
    87e9:	49 83 fe 03          	cmp    $0x3,%r14
    87ed:	ba 02 00 00 00       	mov    $0x2,%edx
    87f2:	49 0f 43 d6          	cmovae %r14,%rdx
    87f6:	48 8b 0d 03 2b 01 00 	mov    0x12b03(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    87fd:	48 ff ca             	dec    %rdx
    8800:	be 01 00 00 00       	mov    $0x1,%esi
    8805:	48 81 fb 01 00 02 00 	cmp    $0x20001,%rbx
    880c:	72 59                	jb     8867 <fwp_gc_alloc_big+0x117>
    880e:	49 8d 3c 0c          	lea    (%r12,%rcx,1),%rdi
    8812:	48 81 c7 60 24 00 00 	add    $0x2460,%rdi
    8819:	49 89 d0             	mov    %rdx,%r8
    881c:	49 83 e0 fe          	and    $0xfffffffffffffffe,%r8
    8820:	49 f7 d8             	neg    %r8
    8823:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    882a:	84 00 00 00 00 00 
    8830:	c6 87 c8 ed ff ff 03 	movb   $0x3,-0x1238(%rdi)
    8837:	c6 87 cc ed ff ff 01 	movb   $0x1,-0x1234(%rdi)
    883e:	89 87 d8 ed ff ff    	mov    %eax,-0x1228(%rdi)
    8844:	c6 47 f0 03          	movb   $0x3,-0x10(%rdi)
    8848:	c6 47 f4 01          	movb   $0x1,-0xc(%rdi)
    884c:	89 07                	mov    %eax,(%rdi)
    884e:	48 81 c7 50 24 00 00 	add    $0x2450,%rdi
    8855:	4d 8d 0c 30          	lea    (%r8,%rsi,1),%r9
    8859:	49 83 c1 02          	add    $0x2,%r9
    885d:	48 83 c6 02          	add    $0x2,%rsi
    8861:	49 83 f9 01          	cmp    $0x1,%r9
    8865:	75 c9                	jne    8830 <fwp_gc_alloc_big+0xe0>
    8867:	f6 c2 01             	test   $0x1,%dl
    886a:	74 17                	je     8883 <fwp_gc_alloc_big+0x133>
    886c:	4c 01 e1             	add    %r12,%rcx
    886f:	48 69 d6 28 12 00 00 	imul   $0x1228,%rsi,%rdx
    8876:	c6 04 11 03          	movb   $0x3,(%rcx,%rdx,1)
    887a:	c6 44 11 04 01       	movb   $0x1,0x4(%rcx,%rdx,1)
    887f:	89 44 11 10          	mov    %eax,0x10(%rcx,%rdx,1)
    8883:	48 c1 e0 10          	shl    $0x10,%rax
    8887:	48 03 05 2a 2a 01 00 	add    0x12a2a(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    888e:	48 89 c7             	mov    %rax,%rdi
    8891:	31 f6                	xor    %esi,%esi
    8893:	48 89 da             	mov    %rbx,%rdx
    8896:	48 83 c4 08          	add    $0x8,%rsp
    889a:	5b                   	pop    %rbx
    889b:	41 5c                	pop    %r12
    889d:	41 5d                	pop    %r13
    889f:	41 5e                	pop    %r14
    88a1:	41 5f                	pop    %r15
    88a3:	5d                   	pop    %rbp
    88a4:	e9 67 a9 ff ff       	jmp    3210 <memset@plt>
    88a9:	4c 89 ff             	mov    %r15,%rdi
    88ac:	49 89 c5             	mov    %rax,%r13
    88af:	e8 5c e2 ff ff       	call   6b10 <fwp_rc_forget_slot>
    88b4:	4c 89 e8             	mov    %r13,%rax
    88b7:	e9 1c ff ff ff       	jmp    87d8 <fwp_gc_alloc_big+0x88>
    88bc:	48 8b 05 15 17 01 00 	mov    0x11715(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    88c3:	48 8b 08             	mov    (%rax),%rcx
    88c6:	48 8d 3d 15 d2 00 00 	lea    0xd215(%rip),%rdi        # 15ae2 <exec_in_fp0+0x272>
    88cd:	be 13 00 00 00       	mov    $0x13,%esi
    88d2:	ba 01 00 00 00       	mov    $0x1,%edx
    88d7:	e8 a4 ab ff ff       	call   3480 <fwrite@plt>
    88dc:	bf 66 00 00 00       	mov    $0x66,%edi
    88e1:	e8 7a ab ff ff       	call   3460 <exit@plt>
    88e6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    88ed:	00 00 00 

00000000000088f0 <fwp_gc_spent>:
    88f0:	50                   	push   %rax
    88f1:	83 3d 7c 29 01 00 00 	cmpl   $0x0,0x1297c(%rip)        # 1b274 <fwp_gc+0xfec>
    88f8:	75 05                	jne    88ff <fwp_gc_spent+0xf>
    88fa:	e8 71 fa ff ff       	call   8370 <fwp_gc_init>
    88ff:	8b 05 77 29 01 00    	mov    0x12977(%rip),%eax        # 1b27c <fwp_gc+0xff4>
    8905:	85 c0                	test   %eax,%eax
    8907:	74 6d                	je     8976 <fwp_gc_spent+0x86>
    8909:	48 8b 0d 98 29 01 00 	mov    0x12998(%rip),%rcx        # 1b2a8 <fwp_gc+0x1020>
    8910:	48 85 c9             	test   %rcx,%rcx
    8913:	74 61                	je     8976 <fwp_gc_spent+0x86>
    8915:	48 8b 05 94 29 01 00 	mov    0x12994(%rip),%rax        # 1b2b0 <fwp_gc+0x1028>
    891c:	48 ff c0             	inc    %rax
    891f:	48 89 05 8a 29 01 00 	mov    %rax,0x1298a(%rip)        # 1b2b0 <fwp_gc+0x1028>
    8926:	48 39 c8             	cmp    %rcx,%rax
    8929:	7c 10                	jl     893b <fwp_gc_spent+0x4b>
    892b:	48 c7 05 7a 29 01 00 	movq   $0x0,0x1297a(%rip)        # 1b2b0 <fwp_gc+0x1028>
    8932:	00 00 00 00 
    8936:	e8 45 03 00 00       	call   8c80 <fwp_gc_collect>
    893b:	48 8b 05 56 2b 01 00 	mov    0x12b56(%rip),%rax        # 1b498 <fwp_gc+0x1210>
    8942:	48 2b 05 3f 19 01 00 	sub    0x1193f(%rip),%rax        # 1a288 <fwp_gc>
    8949:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    894e:	f2 0f 58 05 1a 2b 01 	addsd  0x12b1a(%rip),%xmm0        # 1b470 <fwp_gc+0x11e8>
    8955:	00 
    8956:	f2 0f 11 05 12 2b 01 	movsd  %xmm0,0x12b12(%rip)        # 1b470 <fwp_gc+0x11e8>
    895d:	00 
    895e:	48 c7 05 2f 2b 01 00 	movq   $0x0,0x12b2f(%rip)        # 1b498 <fwp_gc+0x1210>
    8965:	00 00 00 00 
    8969:	48 c7 05 14 19 01 00 	movq   $0x0,0x11914(%rip)        # 1a288 <fwp_gc>
    8970:	00 00 00 00 
    8974:	58                   	pop    %rax
    8975:	c3                   	ret
    8976:	85 c0                	test   %eax,%eax
    8978:	74 06                	je     8980 <fwp_gc_spent+0x90>
    897a:	58                   	pop    %rax
    897b:	e9 00 03 00 00       	jmp    8c80 <fwp_gc_collect>
    8980:	48 8b 05 11 2b 01 00 	mov    0x12b11(%rip),%rax        # 1b498 <fwp_gc+0x1210>
    8987:	48 2b 05 fa 18 01 00 	sub    0x118fa(%rip),%rax        # 1a288 <fwp_gc>
    898e:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    8993:	f2 0f 58 05 d5 2a 01 	addsd  0x12ad5(%rip),%xmm0        # 1b470 <fwp_gc+0x11e8>
    899a:	00 
    899b:	f2 0f 11 05 cd 2a 01 	movsd  %xmm0,0x12acd(%rip)        # 1b470 <fwp_gc+0x11e8>
    89a2:	00 
    89a3:	48 c7 05 ea 2a 01 00 	movq   $0x800000,0x12aea(%rip)        # 1b498 <fwp_gc+0x1210>
    89aa:	00 00 80 00 
    89ae:	48 c7 05 cf 18 01 00 	movq   $0x800000,0x118cf(%rip)        # 1a288 <fwp_gc>
    89b5:	00 00 80 00 
    89b9:	58                   	pop    %rax
    89ba:	c3                   	ret
    89bb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000089c0 <fwp_gc_refill>:
    89c0:	55                   	push   %rbp
    89c1:	41 57                	push   %r15
    89c3:	41 56                	push   %r14
    89c5:	41 55                	push   %r13
    89c7:	41 54                	push   %r12
    89c9:	53                   	push   %rbx
    89ca:	50                   	push   %rax
    89cb:	89 d5                	mov    %edx,%ebp
    89cd:	41 89 f7             	mov    %esi,%r15d
    89d0:	48 89 fb             	mov    %rdi,%rbx
    89d3:	bf 01 00 00 00       	mov    $0x1,%edi
    89d8:	e8 13 01 00 00       	call   8af0 <fwp_gc_chunks>
    89dd:	49 89 c6             	mov    %rax,%r14
    89e0:	4c 8b 25 19 29 01 00 	mov    0x12919(%rip),%r12        # 1b300 <fwp_gc+0x1078>
    89e7:	48 8d 05 9a 18 01 00 	lea    0x1189a(%rip),%rax        # 1a288 <fwp_gc>
    89ee:	4d 69 ee 28 12 00 00 	imul   $0x1228,%r14,%r13
    89f5:	43 c6 04 2c 01       	movb   $0x1,(%r12,%r13,1)
    89fa:	43 88 6c 2c 01       	mov    %bpl,0x1(%r12,%r13,1)
    89ff:	47 88 7c 2c 02       	mov    %r15b,0x2(%r12,%r13,1)
    8a04:	43 c6 44 2c 04 01    	movb   $0x1,0x4(%r12,%r13,1)
    8a0a:	44 89 f9             	mov    %r15d,%ecx
    8a0d:	8b 8c 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%ecx
    8a14:	43 89 4c 2c 08       	mov    %ecx,0x8(%r12,%r13,1)
    8a19:	b8 00 00 01 00       	mov    $0x10000,%eax
    8a1e:	31 d2                	xor    %edx,%edx
    8a20:	f7 f1                	div    %ecx
    8a22:	43 89 44 2c 0c       	mov    %eax,0xc(%r12,%r13,1)
    8a27:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    8a2c:	48 01 c8             	add    %rcx,%rax
    8a2f:	48 0f ba e0 20       	bt     $0x20,%rax
    8a34:	73 07                	jae    8a3d <fwp_gc_refill+0x7d>
    8a36:	31 d2                	xor    %edx,%edx
    8a38:	48 f7 f1             	div    %rcx
    8a3b:	eb 04                	jmp    8a41 <fwp_gc_refill+0x81>
    8a3d:	31 d2                	xor    %edx,%edx
    8a3f:	f7 f1                	div    %ecx
    8a41:	43 89 44 2c 20       	mov    %eax,0x20(%r12,%r13,1)
    8a46:	48 83 3d 52 32 01 00 	cmpq   $0x0,0x13252(%rip)        # 1bca0 <fwp_gc+0x1a18>
    8a4d:	00 
    8a4e:	74 2e                	je     8a7e <fwp_gc_refill+0xbe>
    8a50:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    8a54:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    8a5b:	31 ed                	xor    %ebp,%ebp
    8a5d:	eb 0d                	jmp    8a6c <fwp_gc_refill+0xac>
    8a5f:	90                   	nop
    8a60:	48 ff c5             	inc    %rbp
    8a63:	48 81 fd 00 10 00 00 	cmp    $0x1000,%rbp
    8a6a:	74 12                	je     8a7e <fwp_gc_refill+0xbe>
    8a6c:	41 80 3c 2f ff       	cmpb   $0xff,(%r15,%rbp,1)
    8a71:	75 ed                	jne    8a60 <fwp_gc_refill+0xa0>
    8a73:	49 8d 3c 2f          	lea    (%r15,%rbp,1),%rdi
    8a77:	e8 94 e0 ff ff       	call   6b10 <fwp_rc_forget_slot>
    8a7c:	eb e2                	jmp    8a60 <fwp_gc_refill+0xa0>
    8a7e:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    8a82:	49 83 c7 08          	add    $0x8,%r15
    8a86:	4b 8d 3c 2c          	lea    (%r12,%r13,1),%rdi
    8a8a:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    8a91:	ba 00 10 00 00       	mov    $0x1000,%edx
    8a96:	31 f6                	xor    %esi,%esi
    8a98:	e8 73 a7 ff ff       	call   3210 <memset@plt>
    8a9d:	49 c1 e6 10          	shl    $0x10,%r14
    8aa1:	4c 03 35 10 28 01 00 	add    0x12810(%rip),%r14        # 1b2b8 <fwp_gc+0x1030>
    8aa8:	83 3d dd 27 01 00 00 	cmpl   $0x0,0x127dd(%rip)        # 1b28c <fwp_gc+0x1004>
    8aaf:	74 0f                	je     8ac0 <fwp_gc_refill+0x100>
    8ab1:	ba 00 00 01 00       	mov    $0x10000,%edx
    8ab6:	4c 89 f7             	mov    %r14,%rdi
    8ab9:	31 f6                	xor    %esi,%esi
    8abb:	e8 50 a7 ff ff       	call   3210 <memset@plt>
    8ac0:	41 8b 07             	mov    (%r15),%eax
    8ac3:	49 8d 0c 06          	lea    (%r14,%rax,1),%rcx
    8ac7:	48 89 4b 08          	mov    %rcx,0x8(%rbx)
    8acb:	41 8b 4f 04          	mov    0x4(%r15),%ecx
    8acf:	48 0f af c8          	imul   %rax,%rcx
    8ad3:	4c 01 f1             	add    %r14,%rcx
    8ad6:	48 89 4b 10          	mov    %rcx,0x10(%rbx)
    8ada:	4c 89 f0             	mov    %r14,%rax
    8add:	48 83 c4 08          	add    $0x8,%rsp
    8ae1:	5b                   	pop    %rbx
    8ae2:	41 5c                	pop    %r12
    8ae4:	41 5d                	pop    %r13
    8ae6:	41 5e                	pop    %r14
    8ae8:	41 5f                	pop    %r15
    8aea:	5d                   	pop    %rbp
    8aeb:	c3                   	ret
    8aec:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000008af0 <fwp_gc_chunks>:
    8af0:	41 57                	push   %r15
    8af2:	41 56                	push   %r14
    8af4:	53                   	push   %rbx
    8af5:	48 89 fb             	mov    %rdi,%rbx
    8af8:	31 d2                	xor    %edx,%edx
    8afa:	48 83 ff 01          	cmp    $0x1,%rdi
    8afe:	0f 95 c2             	setne  %dl
    8b01:	48 8d 0d 80 17 01 00 	lea    0x11780(%rip),%rcx        # 1a288 <fwp_gc>
    8b08:	48 8b 84 d1 68 10 00 	mov    0x1068(%rcx,%rdx,8),%rax
    8b0f:	00 
    8b10:	4c 8b 35 c9 27 01 00 	mov    0x127c9(%rip),%r14        # 1b2e0 <fwp_gc+0x1058>
    8b17:	48 89 c7             	mov    %rax,%rdi
    8b1a:	4c 29 f7             	sub    %r14,%rdi
    8b1d:	73 63                	jae    8b82 <fwp_gc_chunks+0x92>
    8b1f:	48 8d 34 d5 68 10 00 	lea    0x1068(,%rdx,8),%rsi
    8b26:	00 
    8b27:	4c 69 c0 28 12 00 00 	imul   $0x1228,%rax,%r8
    8b2e:	4c 03 05 cb 27 01 00 	add    0x127cb(%rip),%r8        # 1b300 <fwp_gc+0x1078>
    8b35:	31 d2                	xor    %edx,%edx
    8b37:	45 31 c9             	xor    %r9d,%r9d
    8b3a:	eb 16                	jmp    8b52 <fwp_gc_chunks+0x62>
    8b3c:	0f 1f 40 00          	nopl   0x0(%rax)
    8b40:	45 31 c9             	xor    %r9d,%r9d
    8b43:	48 ff ca             	dec    %rdx
    8b46:	49 81 c0 28 12 00 00 	add    $0x1228,%r8
    8b4d:	48 39 d7             	cmp    %rdx,%rdi
    8b50:	74 33                	je     8b85 <fwp_gc_chunks+0x95>
    8b52:	41 80 38 00          	cmpb   $0x0,(%r8)
    8b56:	75 e8                	jne    8b40 <fwp_gc_chunks+0x50>
    8b58:	49 ff c1             	inc    %r9
    8b5b:	49 39 d9             	cmp    %rbx,%r9
    8b5e:	75 e3                	jne    8b43 <fwp_gc_chunks+0x53>
    8b60:	48 ff c0             	inc    %rax
    8b63:	48 89 c7             	mov    %rax,%rdi
    8b66:	48 29 d7             	sub    %rdx,%rdi
    8b69:	48 89 3c 0e          	mov    %rdi,(%rsi,%rcx,1)
    8b6d:	48 29 1d f4 28 01 00 	sub    %rbx,0x128f4(%rip)        # 1b468 <fwp_gc+0x11e0>
    8b74:	48 29 d8             	sub    %rbx,%rax
    8b77:	48 29 d0             	sub    %rdx,%rax
    8b7a:	49 89 c6             	mov    %rax,%r14
    8b7d:	e9 ca 00 00 00       	jmp    8c4c <fwp_gc_chunks+0x15c>
    8b82:	45 31 c9             	xor    %r9d,%r9d
    8b85:	4c 29 0d dc 28 01 00 	sub    %r9,0x128dc(%rip)        # 1b468 <fwp_gc+0x11e0>
    8b8c:	4d 29 ce             	sub    %r9,%r14
    8b8f:	4c 01 f3             	add    %r14,%rbx
    8b92:	48 8b 3d 4f 27 01 00 	mov    0x1274f(%rip),%rdi        # 1b2e8 <fwp_gc+0x1060>
    8b99:	48 39 df             	cmp    %rbx,%rdi
    8b9c:	0f 83 8f 00 00 00    	jae    8c31 <fwp_gc_chunks+0x141>
    8ba2:	4c 8b 3d 2f 27 01 00 	mov    0x1272f(%rip),%r15        # 1b2d8 <fwp_gc+0x1050>
    8ba9:	49 39 df             	cmp    %rbx,%r15
    8bac:	0f 82 a3 00 00 00    	jb     8c55 <fwp_gc_chunks+0x165>
    8bb2:	48 8d 43 40          	lea    0x40(%rbx),%rax
    8bb6:	4c 39 f8             	cmp    %r15,%rax
    8bb9:	4c 0f 42 f8          	cmovb  %rax,%r15
    8bbd:	4c 89 fe             	mov    %r15,%rsi
    8bc0:	48 29 fe             	sub    %rdi,%rsi
    8bc3:	48 c1 e7 10          	shl    $0x10,%rdi
    8bc7:	48 03 3d ea 26 01 00 	add    0x126ea(%rip),%rdi        # 1b2b8 <fwp_gc+0x1030>
    8bce:	48 c1 e6 10          	shl    $0x10,%rsi
    8bd2:	ba 03 00 00 00       	mov    $0x3,%edx
    8bd7:	e8 24 a8 ff ff       	call   3400 <mprotect@plt>
    8bdc:	85 c0                	test   %eax,%eax
    8bde:	75 75                	jne    8c55 <fwp_gc_chunks+0x165>
    8be0:	bf 1e 00 00 00       	mov    $0x1e,%edi
    8be5:	e8 36 a8 ff ff       	call   3420 <sysconf@plt>
    8bea:	48 8b 0d 0f 27 01 00 	mov    0x1270f(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    8bf1:	48 69 3d ec 26 01 00 	imul   $0x1228,0x126ec(%rip),%rdi        # 1b2e8 <fwp_gc+0x1060>
    8bf8:	28 12 00 00 
    8bfc:	48 01 cf             	add    %rcx,%rdi
    8bff:	49 69 d7 28 12 00 00 	imul   $0x1228,%r15,%rdx
    8c06:	48 01 ca             	add    %rcx,%rdx
    8c09:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    8c0d:	48 ff ce             	dec    %rsi
    8c10:	48 f7 d8             	neg    %rax
    8c13:	48 21 c7             	and    %rax,%rdi
    8c16:	48 21 c6             	and    %rax,%rsi
    8c19:	48 29 fe             	sub    %rdi,%rsi
    8c1c:	ba 03 00 00 00       	mov    $0x3,%edx
    8c21:	e8 da a7 ff ff       	call   3400 <mprotect@plt>
    8c26:	85 c0                	test   %eax,%eax
    8c28:	75 2b                	jne    8c55 <fwp_gc_chunks+0x165>
    8c2a:	4c 89 3d b7 26 01 00 	mov    %r15,0x126b7(%rip)        # 1b2e8 <fwp_gc+0x1060>
    8c31:	48 89 1d a8 26 01 00 	mov    %rbx,0x126a8(%rip)        # 1b2e0 <fwp_gc+0x1058>
    8c38:	48 c1 e3 10          	shl    $0x10,%rbx
    8c3c:	48 3b 1d 8d 26 01 00 	cmp    0x1268d(%rip),%rbx        # 1b2d0 <fwp_gc+0x1048>
    8c43:	76 07                	jbe    8c4c <fwp_gc_chunks+0x15c>
    8c45:	48 89 1d 84 26 01 00 	mov    %rbx,0x12684(%rip)        # 1b2d0 <fwp_gc+0x1048>
    8c4c:	4c 89 f0             	mov    %r14,%rax
    8c4f:	5b                   	pop    %rbx
    8c50:	41 5e                	pop    %r14
    8c52:	41 5f                	pop    %r15
    8c54:	c3                   	ret
    8c55:	48 8b 05 7c 13 01 00 	mov    0x1137c(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    8c5c:	48 8b 08             	mov    (%rax),%rcx
    8c5f:	48 8d 3d 7c ce 00 00 	lea    0xce7c(%rip),%rdi        # 15ae2 <exec_in_fp0+0x272>
    8c66:	be 13 00 00 00       	mov    $0x13,%esi
    8c6b:	ba 01 00 00 00       	mov    $0x1,%edx
    8c70:	e8 0b a8 ff ff       	call   3480 <fwrite@plt>
    8c75:	bf 66 00 00 00       	mov    $0x66,%edi
    8c7a:	e8 e1 a7 ff ff       	call   3460 <exit@plt>
    8c7f:	90                   	nop

0000000000008c80 <fwp_gc_collect>:
    8c80:	55                   	push   %rbp
    8c81:	48 89 e5             	mov    %rsp,%rbp
    8c84:	41 57                	push   %r15
    8c86:	41 56                	push   %r14
    8c88:	41 55                	push   %r13
    8c8a:	41 54                	push   %r12
    8c8c:	53                   	push   %rbx
    8c8d:	48 81 ec a8 01 00 00 	sub    $0x1a8,%rsp
    8c94:	83 3d e5 25 01 00 00 	cmpl   $0x0,0x125e5(%rip)        # 1b280 <fwp_gc+0xff8>
    8c9b:	0f 85 a5 04 00 00    	jne    9146 <fwp_gc_collect+0x4c6>
    8ca1:	c7 05 d5 25 01 00 01 	movl   $0x1,0x125d5(%rip)        # 1b280 <fwp_gc+0xff8>
    8ca8:	00 00 00 
    8cab:	48 8d b5 20 ff ff ff 	lea    -0xe0(%rbp),%rsi
    8cb2:	bf 01 00 00 00       	mov    $0x1,%edi
    8cb7:	e8 74 a4 ff ff       	call   3130 <clock_gettime@plt>
    8cbc:	48 8b 05 d5 27 01 00 	mov    0x127d5(%rip),%rax        # 1b498 <fwp_gc+0x1210>
    8cc3:	48 2b 05 be 15 01 00 	sub    0x115be(%rip),%rax        # 1a288 <fwp_gc>
    8cca:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    8ccf:	f2 0f 58 05 99 27 01 	addsd  0x12799(%rip),%xmm0        # 1b470 <fwp_gc+0x11e8>
    8cd6:	00 
    8cd7:	f2 0f 11 05 91 27 01 	movsd  %xmm0,0x12791(%rip)        # 1b470 <fwp_gc+0x11e8>
    8cde:	00 
    8cdf:	83 3d a2 25 01 00 00 	cmpl   $0x0,0x125a2(%rip)        # 1b288 <fwp_gc+0x1000>
    8ce6:	0f 94 c0             	sete   %al
    8ce9:	83 3d a0 25 01 00 00 	cmpl   $0x0,0x125a0(%rip)        # 1b290 <fwp_gc+0x1008>
    8cf0:	41 0f 95 c4          	setne  %r12b
    8cf4:	41 08 c4             	or     %al,%r12b
    8cf7:	41 80 fc 01          	cmp    $0x1,%r12b
    8cfb:	0f 85 8f 00 00 00    	jne    8d90 <fwp_gc_collect+0x110>
    8d01:	48 8b 05 d8 25 01 00 	mov    0x125d8(%rip),%rax        # 1b2e0 <fwp_gc+0x1058>
    8d08:	48 85 c0             	test   %rax,%rax
    8d0b:	0f 84 c4 01 00 00    	je     8ed5 <fwp_gc_collect+0x255>
    8d11:	48 8b 15 e8 25 01 00 	mov    0x125e8(%rip),%rdx        # 1b300 <fwp_gc+0x1078>
    8d18:	31 db                	xor    %ebx,%ebx
    8d1a:	41 89 df             	mov    %ebx,%r15d
    8d1d:	4d 89 fe             	mov    %r15,%r14
    8d20:	48 89 c1             	mov    %rax,%rcx
    8d23:	48 89 d0             	mov    %rdx,%rax
    8d26:	eb 2a                	jmp    8d52 <fwp_gc_collect+0xd2>
    8d28:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    8d2f:	00 
    8d30:	42 c6 44 38 03 00    	movb   $0x0,0x3(%rax,%r15,1)
    8d36:	48 89 ca             	mov    %rcx,%rdx
    8d39:	4c 89 f6             	mov    %r14,%rsi
    8d3c:	48 ff c6             	inc    %rsi
    8d3f:	49 81 c7 28 12 00 00 	add    $0x1228,%r15
    8d46:	49 89 f6             	mov    %rsi,%r14
    8d49:	48 39 ce             	cmp    %rcx,%rsi
    8d4c:	0f 83 83 01 00 00    	jae    8ed5 <fwp_gc_collect+0x255>
    8d52:	42 0f b6 14 38       	movzbl (%rax,%r15,1),%edx
    8d57:	83 fa 02             	cmp    $0x2,%edx
    8d5a:	74 d4                	je     8d30 <fwp_gc_collect+0xb0>
    8d5c:	83 fa 01             	cmp    $0x1,%edx
    8d5f:	75 d5                	jne    8d36 <fwp_gc_collect+0xb6>
    8d61:	4a 8d 3c 38          	lea    (%rax,%r15,1),%rdi
    8d65:	48 83 c7 28          	add    $0x28,%rdi
    8d69:	42 8b 44 38 0c       	mov    0xc(%rax,%r15,1),%eax
    8d6e:	83 c0 3f             	add    $0x3f,%eax
    8d71:	c1 e8 03             	shr    $0x3,%eax
    8d74:	83 e0 f8             	and    $0xfffffff8,%eax
    8d77:	89 c2                	mov    %eax,%edx
    8d79:	89 de                	mov    %ebx,%esi
    8d7b:	e8 90 a4 ff ff       	call   3210 <memset@plt>
    8d80:	48 8b 05 79 25 01 00 	mov    0x12579(%rip),%rax        # 1b300 <fwp_gc+0x1078>
    8d87:	48 8b 0d 52 25 01 00 	mov    0x12552(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    8d8e:	eb a6                	jmp    8d36 <fwp_gc_collect+0xb6>
    8d90:	44 88 65 d7          	mov    %r12b,-0x29(%rbp)
    8d94:	48 8d bd 50 fe ff ff 	lea    -0x1b0(%rbp),%rdi
    8d9b:	e8 10 a5 ff ff       	call   32b0 <_setjmp@plt>
    8da0:	48 c7 05 dd 26 01 00 	movq   $0x0,0x126dd(%rip)        # 1b488 <fwp_gc+0x1200>
    8da7:	00 00 00 00 
    8dab:	e8 10 08 00 00       	call   95c0 <fwp_gc_mark_all>
    8db0:	48 83 3d 28 25 01 00 	cmpq   $0x0,0x12528(%rip)        # 1b2e0 <fwp_gc+0x1058>
    8db7:	00 
    8db8:	0f 84 53 01 00 00    	je     8f11 <fwp_gc_collect+0x291>
    8dbe:	31 c0                	xor    %eax,%eax
    8dc0:	eb 25                	jmp    8de7 <fwp_gc_collect+0x167>
    8dc2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8dc9:	1f 84 00 00 00 00 00 
    8dd0:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
    8dd4:	48 ff c1             	inc    %rcx
    8dd7:	48 89 c8             	mov    %rcx,%rax
    8dda:	48 3b 0d ff 24 01 00 	cmp    0x124ff(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    8de1:	0f 83 2a 01 00 00    	jae    8f11 <fwp_gc_collect+0x291>
    8de7:	48 8b 1d 12 25 01 00 	mov    0x12512(%rip),%rbx        # 1b300 <fwp_gc+0x1078>
    8dee:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    8df2:	48 69 c0 28 12 00 00 	imul   $0x1228,%rax,%rax
    8df9:	80 7c 03 01 02       	cmpb   $0x2,0x1(%rbx,%rax,1)
    8dfe:	75 d0                	jne    8dd0 <fwp_gc_collect+0x150>
    8e00:	0f b6 0c 03          	movzbl (%rbx,%rax,1),%ecx
    8e04:	83 f9 02             	cmp    $0x2,%ecx
    8e07:	0f 84 9f 00 00 00    	je     8eac <fwp_gc_collect+0x22c>
    8e0d:	83 f9 01             	cmp    $0x1,%ecx
    8e10:	75 be                	jne    8dd0 <fwp_gc_collect+0x150>
    8e12:	8b 4c 03 0c          	mov    0xc(%rbx,%rax,1),%ecx
    8e16:	83 c1 3f             	add    $0x3f,%ecx
    8e19:	83 f9 40             	cmp    $0x40,%ecx
    8e1c:	72 b2                	jb     8dd0 <fwp_gc_collect+0x150>
    8e1e:	4c 8b 7d c0          	mov    -0x40(%rbp),%r15
    8e22:	49 c1 e7 10          	shl    $0x10,%r15
    8e26:	4c 03 3d 8b 24 01 00 	add    0x1248b(%rip),%r15        # 1b2b8 <fwp_gc+0x1030>
    8e2d:	c1 e9 06             	shr    $0x6,%ecx
    8e30:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    8e34:	4c 8d 2c 03          	lea    (%rbx,%rax,1),%r13
    8e38:	49 83 c5 08          	add    $0x8,%r13
    8e3c:	31 c9                	xor    %ecx,%ecx
    8e3e:	41 89 cc             	mov    %ecx,%r12d
    8e41:	48 01 c3             	add    %rax,%rbx
    8e44:	48 89 5d 98          	mov    %rbx,-0x68(%rbp)
    8e48:	eb 1a                	jmp    8e64 <fwp_gc_collect+0x1e4>
    8e4a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8e50:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    8e54:	48 ff c0             	inc    %rax
    8e57:	49 89 c4             	mov    %rax,%r12
    8e5a:	48 3b 45 90          	cmp    -0x70(%rbp),%rax
    8e5e:	0f 84 6c ff ff ff    	je     8dd0 <fwp_gc_collect+0x150>
    8e64:	48 8b 45 98          	mov    -0x68(%rbp),%rax
    8e68:	4c 89 65 b0          	mov    %r12,-0x50(%rbp)
    8e6c:	4e 8b 64 e0 28       	mov    0x28(%rax,%r12,8),%r12
    8e71:	4d 85 e4             	test   %r12,%r12
    8e74:	74 da                	je     8e50 <fwp_gc_collect+0x1d0>
    8e76:	4c 8b 75 b0          	mov    -0x50(%rbp),%r14
    8e7a:	49 c1 e6 06          	shl    $0x6,%r14
    8e7e:	66 90                	xchg   %ax,%ax
    8e80:	f3 49 0f bc c4       	tzcnt  %r12,%rax
    8e85:	4c 09 f0             	or     %r14,%rax
    8e88:	49 8d 5c 24 ff       	lea    -0x1(%r12),%rbx
    8e8d:	41 8b 4d 00          	mov    0x0(%r13),%ecx
    8e91:	89 ce                	mov    %ecx,%esi
    8e93:	48 0f af c6          	imul   %rsi,%rax
    8e97:	48 89 c7             	mov    %rax,%rdi
    8e9a:	4c 01 ff             	add    %r15,%rdi
    8e9d:	e8 4e 13 00 00       	call   a1f0 <fwp_gc_push>
    8ea2:	4c 21 e3             	and    %r12,%rbx
    8ea5:	49 89 dc             	mov    %rbx,%r12
    8ea8:	75 d6                	jne    8e80 <fwp_gc_collect+0x200>
    8eaa:	eb a4                	jmp    8e50 <fwp_gc_collect+0x1d0>
    8eac:	80 7c 03 03 00       	cmpb   $0x0,0x3(%rbx,%rax,1)
    8eb1:	0f 84 19 ff ff ff    	je     8dd0 <fwp_gc_collect+0x150>
    8eb7:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
    8ebb:	48 c1 e7 10          	shl    $0x10,%rdi
    8ebf:	48 03 3d f2 23 01 00 	add    0x123f2(%rip),%rdi        # 1b2b8 <fwp_gc+0x1030>
    8ec6:	48 8b 74 03 18       	mov    0x18(%rbx,%rax,1),%rsi
    8ecb:	e8 20 13 00 00       	call   a1f0 <fwp_gc_push>
    8ed0:	e9 fb fe ff ff       	jmp    8dd0 <fwp_gc_collect+0x150>
    8ed5:	48 8d bd 50 fe ff ff 	lea    -0x1b0(%rbp),%rdi
    8edc:	e8 cf a3 ff ff       	call   32b0 <_setjmp@plt>
    8ee1:	48 c7 05 9c 25 01 00 	movq   $0x0,0x1259c(%rip)        # 1b488 <fwp_gc+0x1200>
    8ee8:	00 00 00 00 
    8eec:	e8 cf 06 00 00       	call   95c0 <fwp_gc_mark_all>
    8ef1:	e8 0a 08 00 00       	call   9700 <fwp_gc_finalize>
    8ef6:	e8 35 09 00 00       	call   9830 <fwp_gc_sweep>
    8efb:	48 8b 05 5e 25 01 00 	mov    0x1255e(%rip),%rax        # 1b460 <fwp_gc+0x11d8>
    8f02:	48 ff c0             	inc    %rax
    8f05:	48 89 05 54 25 01 00 	mov    %rax,0x12554(%rip)        # 1b460 <fwp_gc+0x11d8>
    8f0c:	e9 0d 01 00 00       	jmp    901e <fwp_gc_collect+0x39e>
    8f11:	48 8b 05 10 25 01 00 	mov    0x12510(%rip),%rax        # 1b428 <fwp_gc+0x11a0>
    8f18:	48 85 c0             	test   %rax,%rax
    8f1b:	74 3a                	je     8f57 <fwp_gc_collect+0x2d7>
    8f1d:	31 db                	xor    %ebx,%ebx
    8f1f:	90                   	nop
    8f20:	48 8b 0d f9 24 01 00 	mov    0x124f9(%rip),%rcx        # 1b420 <fwp_gc+0x1198>
    8f27:	48 ff c8             	dec    %rax
    8f2a:	48 89 05 f7 24 01 00 	mov    %rax,0x124f7(%rip)        # 1b428 <fwp_gc+0x11a0>
    8f31:	48 c1 e0 04          	shl    $0x4,%rax
    8f35:	48 8b 3c 01          	mov    (%rcx,%rax,1),%rdi
    8f39:	48 8b 74 01 08       	mov    0x8(%rcx,%rax,1),%rsi
    8f3e:	48 01 fe             	add    %rdi,%rsi
    8f41:	89 da                	mov    %ebx,%edx
    8f43:	e8 88 0f 00 00       	call   9ed0 <fwp_gc_scan>
    8f48:	48 8b 0d d9 24 01 00 	mov    0x124d9(%rip),%rcx        # 1b428 <fwp_gc+0x11a0>
    8f4f:	48 89 c8             	mov    %rcx,%rax
    8f52:	48 85 c9             	test   %rcx,%rcx
    8f55:	75 c9                	jne    8f20 <fwp_gc_collect+0x2a0>
    8f57:	83 3d 2e 23 01 00 00 	cmpl   $0x0,0x1232e(%rip)        # 1b28c <fwp_gc+0x1004>
    8f5e:	44 0f b6 65 d7       	movzbl -0x29(%rbp),%r12d
    8f63:	0f 84 93 00 00 00    	je     8ffc <fwp_gc_collect+0x37c>
    8f69:	4c 8b 35 70 23 01 00 	mov    0x12370(%rip),%r14        # 1b2e0 <fwp_gc+0x1058>
    8f70:	4c 89 f7             	mov    %r14,%rdi
    8f73:	48 c1 e7 09          	shl    $0x9,%rdi
    8f77:	e8 c4 a3 ff ff       	call   3340 <malloc@plt>
    8f7c:	48 89 c3             	mov    %rax,%rbx
    8f7f:	49 83 fe 01          	cmp    $0x1,%r14
    8f83:	4c 89 f7             	mov    %r14,%rdi
    8f86:	48 83 d7 00          	adc    $0x0,%rdi
    8f8a:	48 89 bd 40 ff ff ff 	mov    %rdi,-0xc0(%rbp)
    8f91:	e8 aa a3 ff ff       	call   3340 <malloc@plt>
    8f96:	48 89 5d c8          	mov    %rbx,-0x38(%rbp)
    8f9a:	48 85 db             	test   %rbx,%rbx
    8f9d:	0f 84 ea 05 00 00    	je     958d <fwp_gc_collect+0x90d>
    8fa3:	48 85 c0             	test   %rax,%rax
    8fa6:	0f 84 e1 05 00 00    	je     958d <fwp_gc_collect+0x90d>
    8fac:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
    8fb0:	48 89 4d a0          	mov    %rcx,-0x60(%rbp)
    8fb4:	49 89 c5             	mov    %rax,%r13
    8fb7:	4d 85 f6             	test   %r14,%r14
    8fba:	74 2a                	je     8fe6 <fwp_gc_collect+0x366>
    8fbc:	4c 89 6d b8          	mov    %r13,-0x48(%rbp)
    8fc0:	48 8b 0d 39 23 01 00 	mov    0x12339(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    8fc7:	49 83 fe 01          	cmp    $0x1,%r14
    8fcb:	4c 89 b5 48 ff ff ff 	mov    %r14,-0xb8(%rbp)
    8fd2:	48 89 8d 70 ff ff ff 	mov    %rcx,-0x90(%rbp)
    8fd9:	0f 85 79 01 00 00    	jne    9158 <fwp_gc_collect+0x4d8>
    8fdf:	31 c0                	xor    %eax,%eax
    8fe1:	e9 f8 01 00 00       	jmp    91de <fwp_gc_collect+0x55e>
    8fe6:	e8 d5 05 00 00       	call   95c0 <fwp_gc_mark_all>
    8feb:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
    8fef:	e8 5c a0 ff ff       	call   3050 <free@plt>
    8ff4:	4c 89 ef             	mov    %r13,%rdi
    8ff7:	e8 54 a0 ff ff       	call   3050 <free@plt>
    8ffc:	e8 ff 06 00 00       	call   9700 <fwp_gc_finalize>
    9001:	e8 2a 08 00 00       	call   9830 <fwp_gc_sweep>
    9006:	48 8b 05 53 24 01 00 	mov    0x12453(%rip),%rax        # 1b460 <fwp_gc+0x11d8>
    900d:	48 ff c0             	inc    %rax
    9010:	48 89 05 49 24 01 00 	mov    %rax,0x12449(%rip)        # 1b460 <fwp_gc+0x11d8>
    9017:	48 ff 05 82 22 01 00 	incq   0x12282(%rip)        # 1b2a0 <fwp_gc+0x1018>
    901e:	48 89 c1             	mov    %rax,%rcx
    9021:	48 8b 05 28 24 01 00 	mov    0x12428(%rip),%rax        # 1b450 <fwp_gc+0x11c8>
    9028:	48 3b 05 29 24 01 00 	cmp    0x12429(%rip),%rax        # 1b458 <fwp_gc+0x11d0>
    902f:	76 07                	jbe    9038 <fwp_gc_collect+0x3b8>
    9031:	48 89 05 20 24 01 00 	mov    %rax,0x12420(%rip)        # 1b458 <fwp_gc+0x11d0>
    9038:	45 84 e4             	test   %r12b,%r12b
    903b:	74 0b                	je     9048 <fwp_gc_collect+0x3c8>
    903d:	48 89 05 54 22 01 00 	mov    %rax,0x12254(%rip)        # 1b298 <fwp_gc+0x1010>
    9044:	31 d2                	xor    %edx,%edx
    9046:	eb 2d                	jmp    9075 <fwp_gc_collect+0x3f5>
    9048:	48 8b 15 49 22 01 00 	mov    0x12249(%rip),%rdx        # 1b298 <fwp_gc+0x1010>
    904f:	48 89 d6             	mov    %rdx,%rsi
    9052:	48 d1 ee             	shr    $1,%rsi
    9055:	48 01 d6             	add    %rdx,%rsi
    9058:	48 81 fe 01 00 00 01 	cmp    $0x1000001,%rsi
    905f:	ba 00 00 00 01       	mov    $0x1000000,%edx
    9064:	48 0f 43 d6          	cmovae %rsi,%rdx
    9068:	31 f6                	xor    %esi,%esi
    906a:	48 39 d0             	cmp    %rdx,%rax
    906d:	0f 97 c2             	seta   %dl
    9070:	40 88 d6             	mov    %dl,%sil
    9073:	89 f2                	mov    %esi,%edx
    9075:	f6 c1 07             	test   $0x7,%cl
    9078:	b9 01 00 00 00       	mov    $0x1,%ecx
    907d:	0f 45 ca             	cmovne %edx,%ecx
    9080:	48 83 3d 20 22 01 00 	cmpq   $0x0,0x12220(%rip)        # 1b2a8 <fwp_gc+0x1020>
    9087:	00 
    9088:	0f 44 ca             	cmove  %edx,%ecx
    908b:	89 0d ff 21 01 00    	mov    %ecx,0x121ff(%rip)        # 1b290 <fwp_gc+0x1008>
    9091:	83 3d f0 21 01 00 00 	cmpl   $0x0,0x121f0(%rip)        # 1b288 <fwp_gc+0x1000>
    9098:	0f 94 c1             	sete   %cl
    909b:	48 d3 e0             	shl    %cl,%rax
    909e:	f2 48 0f 2c 0d e1 23 	cvttsd2si 0x123e1(%rip),%rcx        # 1b488 <fwp_gc+0x1200>
    90a5:	01 00 
    90a7:	48 01 c1             	add    %rax,%rcx
    90aa:	48 81 f9 01 00 80 00 	cmp    $0x800001,%rcx
    90b1:	b8 00 00 80 00       	mov    $0x800000,%eax
    90b6:	48 0f 4d c1          	cmovge %rcx,%rax
    90ba:	48 89 05 d7 23 01 00 	mov    %rax,0x123d7(%rip)        # 1b498 <fwp_gc+0x1210>
    90c1:	48 89 05 c0 11 01 00 	mov    %rax,0x111c0(%rip)        # 1a288 <fwp_gc>
    90c8:	48 8d b5 30 ff ff ff 	lea    -0xd0(%rbp),%rsi
    90cf:	bf 01 00 00 00       	mov    $0x1,%edi
    90d4:	e8 57 a0 ff ff       	call   3130 <clock_gettime@plt>
    90d9:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    90e0:	48 8b 8d 38 ff ff ff 	mov    -0xc8(%rbp),%rcx
    90e7:	48 2b 85 20 ff ff ff 	sub    -0xe0(%rbp),%rax
    90ee:	f2 48 0f 2a c8       	cvtsi2sd %rax,%xmm1
    90f3:	f2 0f 59 0d b5 c0 00 	mulsd  0xc0b5(%rip),%xmm1        # 151b0 <_IO_stdin_used+0x1b0>
    90fa:	00 
    90fb:	48 2b 8d 28 ff ff ff 	sub    -0xd8(%rbp),%rcx
    9102:	0f 57 c0             	xorps  %xmm0,%xmm0
    9105:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    910a:	f2 0f 5e 05 a6 c0 00 	divsd  0xc0a6(%rip),%xmm0        # 151b8 <_IO_stdin_used+0x1b8>
    9111:	00 
    9112:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
    9116:	f2 0f 10 0d 5a 23 01 	movsd  0x1235a(%rip),%xmm1        # 1b478 <fwp_gc+0x11f0>
    911d:	00 
    911e:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
    9122:	f2 0f 11 0d 4e 23 01 	movsd  %xmm1,0x1234e(%rip)        # 1b478 <fwp_gc+0x11f0>
    9129:	00 
    912a:	66 0f 2e 05 4e 23 01 	ucomisd 0x1234e(%rip),%xmm0        # 1b480 <fwp_gc+0x11f8>
    9131:	00 
    9132:	76 08                	jbe    913c <fwp_gc_collect+0x4bc>
    9134:	f2 0f 11 05 44 23 01 	movsd  %xmm0,0x12344(%rip)        # 1b480 <fwp_gc+0x11f8>
    913b:	00 
    913c:	c7 05 3a 21 01 00 00 	movl   $0x0,0x1213a(%rip)        # 1b280 <fwp_gc+0xff8>
    9143:	00 00 00 
    9146:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    914d:	5b                   	pop    %rbx
    914e:	41 5c                	pop    %r12
    9150:	41 5d                	pop    %r13
    9152:	41 5e                	pop    %r14
    9154:	41 5f                	pop    %r15
    9156:	5d                   	pop    %rbp
    9157:	c3                   	ret
    9158:	49 83 e6 fe          	and    $0xfffffffffffffffe,%r14
    915c:	4c 89 75 88          	mov    %r14,-0x78(%rbp)
    9160:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    9164:	48 8d 98 00 02 00 00 	lea    0x200(%rax),%rbx
    916b:	4c 8d a1 50 12 00 00 	lea    0x1250(%rcx),%r12
    9172:	31 c0                	xor    %eax,%eax
    9174:	89 c1                	mov    %eax,%ecx
    9176:	41 bd 00 02 00 00    	mov    $0x200,%r13d
    917c:	4c 8b 75 b8          	mov    -0x48(%rbp),%r14
    9180:	49 89 cf             	mov    %rcx,%r15
    9183:	48 8d bb 00 fe ff ff 	lea    -0x200(%rbx),%rdi
    918a:	49 8d b4 24 d8 ed ff 	lea    -0x1228(%r12),%rsi
    9191:	ff 
    9192:	4c 89 ea             	mov    %r13,%rdx
    9195:	e8 96 a1 ff ff       	call   3330 <memcpy@plt>
    919a:	41 0f b6 84 24 b3 ed 	movzbl -0x124d(%r12),%eax
    91a1:	ff ff 
    91a3:	43 88 04 3e          	mov    %al,(%r14,%r15,1)
    91a7:	48 89 df             	mov    %rbx,%rdi
    91aa:	4c 89 e6             	mov    %r12,%rsi
    91ad:	4c 89 ea             	mov    %r13,%rdx
    91b0:	e8 7b a1 ff ff       	call   3330 <memcpy@plt>
    91b5:	41 0f b6 44 24 db    	movzbl -0x25(%r12),%eax
    91bb:	43 88 44 3e 01       	mov    %al,0x1(%r14,%r15,1)
    91c0:	49 83 c7 02          	add    $0x2,%r15
    91c4:	48 81 c3 00 04 00 00 	add    $0x400,%rbx
    91cb:	49 81 c4 50 24 00 00 	add    $0x2450,%r12
    91d2:	4c 89 f8             	mov    %r15,%rax
    91d5:	4c 89 f9             	mov    %r15,%rcx
    91d8:	4c 39 7d 88          	cmp    %r15,-0x78(%rbp)
    91dc:	75 a2                	jne    9180 <fwp_gc_collect+0x500>
    91de:	48 89 c3             	mov    %rax,%rbx
    91e1:	4c 8b bd 48 ff ff ff 	mov    -0xb8(%rbp),%r15
    91e8:	44 89 f8             	mov    %r15d,%eax
    91eb:	41 f6 c7 01          	test   $0x1,%r15b
    91ef:	44 0f b6 65 d7       	movzbl -0x29(%rbp),%r12d
    91f4:	48 8b 95 70 ff ff ff 	mov    -0x90(%rbp),%rdx
    91fb:	74 37                	je     9234 <fwp_gc_collect+0x5b4>
    91fd:	48 89 df             	mov    %rbx,%rdi
    9200:	48 c1 e7 09          	shl    $0x9,%rdi
    9204:	48 03 7d c8          	add    -0x38(%rbp),%rdi
    9208:	4c 69 f3 28 12 00 00 	imul   $0x1228,%rbx,%r14
    920f:	4a 8d 34 32          	lea    (%rdx,%r14,1),%rsi
    9213:	48 83 c6 28          	add    $0x28,%rsi
    9217:	49 89 d5             	mov    %rdx,%r13
    921a:	ba 00 02 00 00       	mov    $0x200,%edx
    921f:	e8 0c a1 ff ff       	call   3330 <memcpy@plt>
    9224:	4c 89 ea             	mov    %r13,%rdx
    9227:	43 0f b6 44 35 03    	movzbl 0x3(%r13,%r14,1),%eax
    922d:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
    9231:	88 04 19             	mov    %al,(%rcx,%rbx,1)
    9234:	45 31 ed             	xor    %r13d,%r13d
    9237:	45 89 ee             	mov    %r13d,%r14d
    923a:	4c 89 f3             	mov    %r14,%rbx
    923d:	4c 89 f9             	mov    %r15,%rcx
    9240:	48 89 d0             	mov    %rdx,%rax
    9243:	eb 29                	jmp    926e <fwp_gc_collect+0x5ee>
    9245:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    924c:	00 00 00 00 
    9250:	42 c6 44 30 03 00    	movb   $0x0,0x3(%rax,%r14,1)
    9256:	48 89 ca             	mov    %rcx,%rdx
    9259:	48 89 de             	mov    %rbx,%rsi
    925c:	48 ff c6             	inc    %rsi
    925f:	49 81 c6 28 12 00 00 	add    $0x1228,%r14
    9266:	48 89 f3             	mov    %rsi,%rbx
    9269:	48 39 ce             	cmp    %rcx,%rsi
    926c:	73 3f                	jae    92ad <fwp_gc_collect+0x62d>
    926e:	42 0f b6 14 30       	movzbl (%rax,%r14,1),%edx
    9273:	83 fa 02             	cmp    $0x2,%edx
    9276:	74 d8                	je     9250 <fwp_gc_collect+0x5d0>
    9278:	83 fa 01             	cmp    $0x1,%edx
    927b:	75 d9                	jne    9256 <fwp_gc_collect+0x5d6>
    927d:	4a 8d 3c 30          	lea    (%rax,%r14,1),%rdi
    9281:	48 83 c7 28          	add    $0x28,%rdi
    9285:	42 8b 44 30 0c       	mov    0xc(%rax,%r14,1),%eax
    928a:	83 c0 3f             	add    $0x3f,%eax
    928d:	c1 e8 03             	shr    $0x3,%eax
    9290:	83 e0 f8             	and    $0xfffffff8,%eax
    9293:	89 c2                	mov    %eax,%edx
    9295:	44 89 ee             	mov    %r13d,%esi
    9298:	e8 73 9f ff ff       	call   3210 <memset@plt>
    929d:	48 8b 05 5c 20 01 00 	mov    0x1205c(%rip),%rax        # 1b300 <fwp_gc+0x1078>
    92a4:	48 8b 0d 35 20 01 00 	mov    0x12035(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    92ab:	eb a9                	jmp    9256 <fwp_gc_collect+0x5d6>
    92ad:	e8 0e 03 00 00       	call   95c0 <fwp_gc_mark_all>
    92b2:	48 8b 05 47 20 01 00 	mov    0x12047(%rip),%rax        # 1b300 <fwp_gc+0x1078>
    92b9:	48 8d 78 28          	lea    0x28(%rax),%rdi
    92bd:	31 d2                	xor    %edx,%edx
    92bf:	89 d6                	mov    %edx,%esi
    92c1:	4c 8b 45 a0          	mov    -0x60(%rbp),%r8
    92c5:	4c 8b 6d b8          	mov    -0x48(%rbp),%r13
    92c9:	eb 35                	jmp    9300 <fwp_gc_collect+0x680>
    92cb:	4d 85 db             	test   %r11,%r11
    92ce:	0f 85 c8 00 00 00    	jne    939c <fwp_gc_collect+0x71c>
    92d4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    92db:	00 00 00 00 00 
    92e0:	48 89 f1             	mov    %rsi,%rcx
    92e3:	48 ff c1             	inc    %rcx
    92e6:	49 81 c0 00 02 00 00 	add    $0x200,%r8
    92ed:	48 81 c7 28 12 00 00 	add    $0x1228,%rdi
    92f4:	48 89 ce             	mov    %rcx,%rsi
    92f7:	4c 39 f9             	cmp    %r15,%rcx
    92fa:	0f 84 eb fc ff ff    	je     8feb <fwp_gc_collect+0x36b>
    9300:	48 69 ce 28 12 00 00 	imul   $0x1228,%rsi,%rcx
    9307:	44 0f b6 0c 08       	movzbl (%rax,%rcx,1),%r9d
    930c:	41 83 f9 02          	cmp    $0x2,%r9d
    9310:	74 5e                	je     9370 <fwp_gc_collect+0x6f0>
    9312:	41 83 f9 01          	cmp    $0x1,%r9d
    9316:	75 c8                	jne    92e0 <fwp_gc_collect+0x660>
    9318:	44 8b 4c 08 0c       	mov    0xc(%rax,%rcx,1),%r9d
    931d:	41 83 c1 3f          	add    $0x3f,%r9d
    9321:	41 83 f9 40          	cmp    $0x40,%r9d
    9325:	72 b9                	jb     92e0 <fwp_gc_collect+0x660>
    9327:	41 c1 e9 06          	shr    $0x6,%r9d
    932b:	49 c7 c6 c0 ff ff ff 	mov    $0xffffffffffffffc0,%r14
    9332:	89 d3                	mov    %edx,%ebx
    9334:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    933b:	00 00 00 00 00 
    9340:	4d 89 f2             	mov    %r14,%r10
    9343:	4d 8b 1c d8          	mov    (%r8,%rbx,8),%r11
    9347:	49 f7 d3             	not    %r11
    934a:	4c 23 1c df          	and    (%rdi,%rbx,8),%r11
    934e:	48 ff c3             	inc    %rbx
    9351:	49 83 c2 40          	add    $0x40,%r10
    9355:	4c 39 cb             	cmp    %r9,%rbx
    9358:	0f 83 6d ff ff ff    	jae    92cb <fwp_gc_collect+0x64b>
    935e:	4d 89 d6             	mov    %r10,%r14
    9361:	4d 85 db             	test   %r11,%r11
    9364:	74 da                	je     9340 <fwp_gc_collect+0x6c0>
    9366:	e9 60 ff ff ff       	jmp    92cb <fwp_gc_collect+0x64b>
    936b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    9370:	80 7c 08 03 00       	cmpb   $0x0,0x3(%rax,%rcx,1)
    9375:	0f 84 65 ff ff ff    	je     92e0 <fwp_gc_collect+0x660>
    937b:	41 80 7c 35 00 00    	cmpb   $0x0,0x0(%r13,%rsi,1)
    9381:	0f 85 59 ff ff ff    	jne    92e0 <fwp_gc_collect+0x660>
    9387:	49 89 f7             	mov    %rsi,%r15
    938a:	49 c1 e7 10          	shl    $0x10,%r15
    938e:	4c 03 3d 23 1f 01 00 	add    0x11f23(%rip),%r15        # 1b2b8 <fwp_gc+0x1030>
    9395:	48 8b 5c 08 18       	mov    0x18(%rax,%rcx,1),%rbx
    939a:	eb 20                	jmp    93bc <fwp_gc_collect+0x73c>
    939c:	f3 4d 0f bc fb       	tzcnt  %r11,%r15
    93a1:	48 c1 e6 10          	shl    $0x10,%rsi
    93a5:	48 03 35 0c 1f 01 00 	add    0x11f0c(%rip),%rsi        # 1b2b8 <fwp_gc+0x1030>
    93ac:	4d 01 d7             	add    %r10,%r15
    93af:	8b 7c 08 08          	mov    0x8(%rax,%rcx,1),%edi
    93b3:	89 fb                	mov    %edi,%ebx
    93b5:	4c 0f af fb          	imul   %rbx,%r15
    93b9:	49 01 f7             	add    %rsi,%r15
    93bc:	48 8b 15 15 0c 01 00 	mov    0x10c15(%rip),%rdx        # 19fd8 <stderr@GLIBC_2.2.5>
    93c3:	48 8b 3a             	mov    (%rdx),%rdi
    93c6:	0f b6 4c 08 01       	movzbl 0x1(%rax,%rcx,1),%ecx
    93cb:	48 8d 35 24 c7 00 00 	lea    0xc724(%rip),%rsi        # 15af6 <exec_in_fp0+0x286>
    93d2:	45 31 f6             	xor    %r14d,%r14d
    93d5:	44 89 f0             	mov    %r14d,%eax
    93d8:	4c 89 fa             	mov    %r15,%rdx
    93db:	49 89 d8             	mov    %rbx,%r8
    93de:	44 88 75 d6          	mov    %r14b,-0x2a(%rbp)
    93e2:	e8 09 9f ff ff       	call   32f0 <fprintf@plt>
    93e7:	48 89 de             	mov    %rbx,%rsi
    93ea:	4c 01 fe             	add    %r15,%rsi
    93ed:	44 89 f0             	mov    %r14d,%eax
    93f0:	48 89 c1             	mov    %rax,%rcx
    93f3:	48 89 b5 50 ff ff ff 	mov    %rsi,-0xb0(%rbp)
    93fa:	eb 24                	jmp    9420 <fwp_gc_collect+0x7a0>
    93fc:	0f 1f 40 00          	nopl   0x0(%rax)
    9400:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
    9404:	48 ff c2             	inc    %rdx
    9407:	48 89 f8             	mov    %rdi,%rax
    940a:	48 05 00 00 01 00    	add    $0x10000,%rax
    9410:	48 89 d1             	mov    %rdx,%rcx
    9413:	48 3b 95 40 ff ff ff 	cmp    -0xc0(%rbp),%rdx
    941a:	0f 84 68 01 00 00    	je     9588 <fwp_gc_collect+0x908>
    9420:	48 89 c7             	mov    %rax,%rdi
    9423:	48 8b 05 d6 1e 01 00 	mov    0x11ed6(%rip),%rax        # 1b300 <fwp_gc+0x1078>
    942a:	48 89 4d a8          	mov    %rcx,-0x58(%rbp)
    942e:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    9435:	80 3c 08 01          	cmpb   $0x1,(%rax,%rcx,1)
    9439:	75 c5                	jne    9400 <fwp_gc_collect+0x780>
    943b:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    9440:	74 be                	je     9400 <fwp_gc_collect+0x780>
    9442:	8b 54 08 0c          	mov    0xc(%rax,%rcx,1),%edx
    9446:	85 d2                	test   %edx,%edx
    9448:	74 b6                	je     9400 <fwp_gc_collect+0x780>
    944a:	4c 8d 0c 08          	lea    (%rax,%rcx,1),%r9
    944e:	49 ff c1             	inc    %r9
    9451:	48 8b 4d a8          	mov    -0x58(%rbp),%rcx
    9455:	48 89 c8             	mov    %rcx,%rax
    9458:	48 c1 e0 10          	shl    $0x10,%rax
    945c:	48 89 85 60 ff ff ff 	mov    %rax,-0xa0(%rbp)
    9463:	31 c0                	xor    %eax,%eax
    9465:	41 89 c5             	mov    %eax,%r13d
    9468:	48 89 c8             	mov    %rcx,%rax
    946b:	48 c1 e0 09          	shl    $0x9,%rax
    946f:	49 89 c0             	mov    %rax,%r8
    9472:	4c 03 45 c8          	add    -0x38(%rbp),%r8
    9476:	89 d0                	mov    %edx,%eax
    9478:	48 89 bd 58 ff ff ff 	mov    %rdi,-0xa8(%rbp)
    947f:	4c 89 85 68 ff ff ff 	mov    %r8,-0x98(%rbp)
    9486:	eb 35                	jmp    94bd <fwp_gc_collect+0x83d>
    9488:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    948f:	00 
    9490:	41 8b 41 0b          	mov    0xb(%r9),%eax
    9494:	48 8b bd 58 ff ff ff 	mov    -0xa8(%rbp),%rdi
    949b:	4c 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%r8
    94a2:	4c 8b ad 78 ff ff ff 	mov    -0x88(%rbp),%r13
    94a9:	4c 89 e9             	mov    %r13,%rcx
    94ac:	48 ff c1             	inc    %rcx
    94af:	89 c2                	mov    %eax,%edx
    94b1:	49 89 cd             	mov    %rcx,%r13
    94b4:	48 39 d1             	cmp    %rdx,%rcx
    94b7:	0f 83 43 ff ff ff    	jae    9400 <fwp_gc_collect+0x780>
    94bd:	4c 89 e9             	mov    %r13,%rcx
    94c0:	48 c1 e9 06          	shr    $0x6,%rcx
    94c4:	49 8b 0c c8          	mov    (%r8,%rcx,8),%rcx
    94c8:	4c 0f a3 e9          	bt     %r13,%rcx
    94cc:	73 db                	jae    94a9 <fwp_gc_collect+0x829>
    94ce:	41 8b 49 07          	mov    0x7(%r9),%ecx
    94d2:	41 89 cc             	mov    %ecx,%r12d
    94d5:	49 83 fc 08          	cmp    $0x8,%r12
    94d9:	72 ce                	jb     94a9 <fwp_gc_collect+0x829>
    94db:	4c 8b 35 d6 1d 01 00 	mov    0x11dd6(%rip),%r14        # 1b2b8 <fwp_gc+0x1030>
    94e2:	48 8b 8d 60 ff ff ff 	mov    -0xa0(%rbp),%rcx
    94e9:	4c 01 f1             	add    %r14,%rcx
    94ec:	48 89 4d 80          	mov    %rcx,-0x80(%rbp)
    94f0:	45 89 e0             	mov    %r12d,%r8d
    94f3:	4c 89 ad 78 ff ff ff 	mov    %r13,-0x88(%rbp)
    94fa:	4d 0f af e5          	imul   %r13,%r12
    94fe:	49 01 fe             	add    %rdi,%r14
    9501:	4d 01 e6             	add    %r12,%r14
    9504:	31 c0                	xor    %eax,%eax
    9506:	89 c3                	mov    %eax,%ebx
    9508:	eb 1e                	jmp    9528 <fwp_gc_collect+0x8a8>
    950a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9510:	44 89 c0             	mov    %r8d,%eax
    9513:	48 89 d9             	mov    %rbx,%rcx
    9516:	48 ff c1             	inc    %rcx
    9519:	c1 e8 03             	shr    $0x3,%eax
    951c:	48 89 cb             	mov    %rcx,%rbx
    951f:	48 39 c1             	cmp    %rax,%rcx
    9522:	0f 83 68 ff ff ff    	jae    9490 <fwp_gc_collect+0x810>
    9528:	49 8b 04 de          	mov    (%r14,%rbx,8),%rax
    952c:	4c 39 f8             	cmp    %r15,%rax
    952f:	72 df                	jb     9510 <fwp_gc_collect+0x890>
    9531:	48 39 f0             	cmp    %rsi,%rax
    9534:	73 da                	jae    9510 <fwp_gc_collect+0x890>
    9536:	48 8b 05 9b 0a 01 00 	mov    0x10a9b(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    953d:	48 8b 38             	mov    (%rax),%rdi
    9540:	41 0f b6 09          	movzbl (%r9),%ecx
    9544:	48 8b 45 80          	mov    -0x80(%rbp),%rax
    9548:	4a 8d 14 20          	lea    (%rax,%r12,1),%rdx
    954c:	66 42 0f 10 04 20    	movupd (%rax,%r12,1),%xmm0
    9552:	4a 8b 44 20 10       	mov    0x10(%rax,%r12,1),%rax
    9557:	48 89 e6             	mov    %rsp,%rsi
    955a:	48 89 46 10          	mov    %rax,0x10(%rsi)
    955e:	66 0f 11 06          	movupd %xmm0,(%rsi)
    9562:	48 8d 35 e7 c5 00 00 	lea    0xc5e7(%rip),%rsi        # 15b50 <exec_in_fp0+0x2e0>
    9569:	4d 89 cd             	mov    %r9,%r13
    956c:	49 89 d9             	mov    %rbx,%r9
    956f:	0f b6 45 d6          	movzbl -0x2a(%rbp),%eax
    9573:	e8 78 9d ff ff       	call   32f0 <fprintf@plt>
    9578:	4d 89 e9             	mov    %r13,%r9
    957b:	48 8b b5 50 ff ff ff 	mov    -0xb0(%rbp),%rsi
    9582:	45 8b 45 07          	mov    0x7(%r13),%r8d
    9586:	eb 88                	jmp    9510 <fwp_gc_collect+0x890>
    9588:	e8 e3 9a ff ff       	call   3070 <abort@plt>
    958d:	48 8b 05 44 0a 01 00 	mov    0x10a44(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    9594:	48 8b 08             	mov    (%rax),%rcx
    9597:	48 8d 3d 44 c5 00 00 	lea    0xc544(%rip),%rdi        # 15ae2 <exec_in_fp0+0x272>
    959e:	be 13 00 00 00       	mov    $0x13,%esi
    95a3:	ba 01 00 00 00       	mov    $0x1,%edx
    95a8:	e8 d3 9e ff ff       	call   3480 <fwrite@plt>
    95ad:	bf 66 00 00 00       	mov    $0x66,%edi
    95b2:	e8 a9 9e ff ff       	call   3460 <exit@plt>
    95b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    95be:	00 00 

00000000000095c0 <fwp_gc_mark_all>:
    95c0:	41 57                	push   %r15
    95c2:	41 56                	push   %r14
    95c4:	41 55                	push   %r13
    95c6:	41 54                	push   %r12
    95c8:	53                   	push   %rbx
    95c9:	e8 f2 08 00 00       	call   9ec0 <fwp_gc_sp>
    95ce:	48 85 c0             	test   %rax,%rax
    95d1:	74 56                	je     9629 <fwp_gc_mark_all+0x69>
    95d3:	48 8b 35 36 1d 01 00 	mov    0x11d36(%rip),%rsi        # 1b310 <fwp_gc+0x1088>
    95da:	48 89 f1             	mov    %rsi,%rcx
    95dd:	48 29 c1             	sub    %rax,%rcx
    95e0:	76 47                	jbe    9629 <fwp_gc_mark_all+0x69>
    95e2:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    95e7:	f2 0f 58 05 99 1e 01 	addsd  0x11e99(%rip),%xmm0        # 1b488 <fwp_gc+0x1200>
    95ee:	00 
    95ef:	f2 0f 11 05 91 1e 01 	movsd  %xmm0,0x11e91(%rip)        # 1b488 <fwp_gc+0x1200>
    95f6:	00 
    95f7:	48 89 c7             	mov    %rax,%rdi
    95fa:	ba 01 00 00 00       	mov    $0x1,%edx
    95ff:	eb 23                	jmp    9624 <fwp_gc_mark_all+0x64>
    9601:	48 8b 0d 18 1e 01 00 	mov    0x11e18(%rip),%rcx        # 1b420 <fwp_gc+0x1198>
    9608:	48 ff c8             	dec    %rax
    960b:	48 89 05 16 1e 01 00 	mov    %rax,0x11e16(%rip)        # 1b428 <fwp_gc+0x11a0>
    9612:	48 c1 e0 04          	shl    $0x4,%rax
    9616:	48 8b 3c 01          	mov    (%rcx,%rax,1),%rdi
    961a:	48 8b 74 01 08       	mov    0x8(%rcx,%rax,1),%rsi
    961f:	48 01 fe             	add    %rdi,%rsi
    9622:	31 d2                	xor    %edx,%edx
    9624:	e8 a7 08 00 00       	call   9ed0 <fwp_gc_scan>
    9629:	48 8b 05 f8 1d 01 00 	mov    0x11df8(%rip),%rax        # 1b428 <fwp_gc+0x11a0>
    9630:	48 85 c0             	test   %rax,%rax
    9633:	75 cc                	jne    9601 <fwp_gc_mark_all+0x41>
    9635:	83 3d dc 1d 01 00 00 	cmpl   $0x0,0x11ddc(%rip)        # 1b418 <fwp_gc+0x1190>
    963c:	0f 8e b2 00 00 00    	jle    96f4 <fwp_gc_mark_all+0x134>
    9642:	4c 8d 25 d7 1c 01 00 	lea    0x11cd7(%rip),%r12        # 1b320 <fwp_gc+0x1098>
    9649:	45 31 ed             	xor    %r13d,%r13d
    964c:	48 8d 1d 35 0c 01 00 	lea    0x10c35(%rip),%rbx        # 1a288 <fwp_gc>
    9653:	4c 8d 35 4e 26 01 00 	lea    0x1264e(%rip),%r14        # 1bca8 <fc13>
    965a:	eb 21                	jmp    967d <fwp_gc_mark_all+0xbd>
    965c:	0f 1f 40 00          	nopl   0x0(%rax)
    9660:	4c 89 fe             	mov    %r15,%rsi
    9663:	31 d2                	xor    %edx,%edx
    9665:	e8 66 08 00 00       	call   9ed0 <fwp_gc_scan>
    966a:	49 ff c5             	inc    %r13
    966d:	48 63 05 a4 1d 01 00 	movslq 0x11da4(%rip),%rax        # 1b418 <fwp_gc+0x1190>
    9674:	49 83 c4 10          	add    $0x10,%r12
    9678:	49 39 c5             	cmp    %rax,%r13
    967b:	7d 6b                	jge    96e8 <fwp_gc_mark_all+0x128>
    967d:	49 8b 7c 24 f8       	mov    -0x8(%r12),%rdi
    9682:	49 8b 04 24          	mov    (%r12),%rax
    9686:	4c 8d 3c 07          	lea    (%rdi,%rax,1),%r15
    968a:	0f 57 c0             	xorps  %xmm0,%xmm0
    968d:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    9692:	f2 0f 58 05 ee 1d 01 	addsd  0x11dee(%rip),%xmm0        # 1b488 <fwp_gc+0x1200>
    9699:	00 
    969a:	f2 0f 11 05 e6 1d 01 	movsd  %xmm0,0x11de6(%rip)        # 1b488 <fwp_gc+0x1200>
    96a1:	00 
    96a2:	48 39 df             	cmp    %rbx,%rdi
    96a5:	77 b9                	ja     9660 <fwp_gc_mark_all+0xa0>
    96a7:	4d 39 f7             	cmp    %r14,%r15
    96aa:	72 b4                	jb     9660 <fwp_gc_mark_all+0xa0>
    96ac:	48 89 de             	mov    %rbx,%rsi
    96af:	31 d2                	xor    %edx,%edx
    96b1:	e8 1a 08 00 00       	call   9ed0 <fwp_gc_scan>
    96b6:	4c 89 f7             	mov    %r14,%rdi
    96b9:	eb a5                	jmp    9660 <fwp_gc_mark_all+0xa0>
    96bb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    96c0:	48 8b 0d 59 1d 01 00 	mov    0x11d59(%rip),%rcx        # 1b420 <fwp_gc+0x1198>
    96c7:	48 ff c8             	dec    %rax
    96ca:	48 89 05 57 1d 01 00 	mov    %rax,0x11d57(%rip)        # 1b428 <fwp_gc+0x11a0>
    96d1:	48 c1 e0 04          	shl    $0x4,%rax
    96d5:	48 8b 3c 01          	mov    (%rcx,%rax,1),%rdi
    96d9:	48 8b 74 01 08       	mov    0x8(%rcx,%rax,1),%rsi
    96de:	48 01 fe             	add    %rdi,%rsi
    96e1:	31 d2                	xor    %edx,%edx
    96e3:	e8 e8 07 00 00       	call   9ed0 <fwp_gc_scan>
    96e8:	48 8b 05 39 1d 01 00 	mov    0x11d39(%rip),%rax        # 1b428 <fwp_gc+0x11a0>
    96ef:	48 85 c0             	test   %rax,%rax
    96f2:	75 cc                	jne    96c0 <fwp_gc_mark_all+0x100>
    96f4:	5b                   	pop    %rbx
    96f5:	41 5c                	pop    %r12
    96f7:	41 5d                	pop    %r13
    96f9:	41 5e                	pop    %r14
    96fb:	41 5f                	pop    %r15
    96fd:	c3                   	ret
    96fe:	66 90                	xchg   %ax,%ax

0000000000009700 <fwp_gc_finalize>:
    9700:	48 8b 0d 39 1d 01 00 	mov    0x11d39(%rip),%rcx        # 1b440 <fwp_gc+0x11b8>
    9707:	48 85 c9             	test   %rcx,%rcx
    970a:	0f 84 10 01 00 00    	je     9820 <fwp_gc_finalize+0x120>
    9710:	41 56                	push   %r14
    9712:	53                   	push   %rbx
    9713:	50                   	push   %rax
    9714:	48 8b 35 1d 1d 01 00 	mov    0x11d1d(%rip),%rsi        # 1b438 <fwp_gc+0x11b0>
    971b:	4c 8b 05 96 1b 01 00 	mov    0x11b96(%rip),%r8        # 1b2b8 <fwp_gc+0x1030>
    9722:	4c 8b 0d b7 1b 01 00 	mov    0x11bb7(%rip),%r9        # 1b2e0 <fwp_gc+0x1058>
    9729:	31 db                	xor    %ebx,%ebx
    972b:	eb 0f                	jmp    973c <fwp_gc_finalize+0x3c>
    972d:	0f 1f 00             	nopl   (%rax)
    9730:	48 ff c3             	inc    %rbx
    9733:	48 39 cb             	cmp    %rcx,%rbx
    9736:	0f 83 dd 00 00 00    	jae    9819 <fwp_gc_finalize+0x119>
    973c:	49 89 da             	mov    %rbx,%r10
    973f:	49 c1 e2 04          	shl    $0x4,%r10
    9743:	4a 8b 3c 16          	mov    (%rsi,%r10,1),%rdi
    9747:	48 89 f8             	mov    %rdi,%rax
    974a:	4c 29 c0             	sub    %r8,%rax
    974d:	4c 89 ca             	mov    %r9,%rdx
    9750:	48 c1 e2 10          	shl    $0x10,%rdx
    9754:	48 39 d0             	cmp    %rdx,%rax
    9757:	73 d7                	jae    9730 <fwp_gc_finalize+0x30>
    9759:	4c 8b 1d a0 1b 01 00 	mov    0x11ba0(%rip),%r11        # 1b300 <fwp_gc+0x1078>
    9760:	4d 85 db             	test   %r11,%r11
    9763:	74 cb                	je     9730 <fwp_gc_finalize+0x30>
    9765:	48 c1 e8 10          	shr    $0x10,%rax
    9769:	48 69 d0 28 12 00 00 	imul   $0x1228,%rax,%rdx
    9770:	41 0f b6 04 13       	movzbl (%r11,%rdx,1),%eax
    9775:	3c 03                	cmp    $0x3,%al
    9777:	75 16                	jne    978f <fwp_gc_finalize+0x8f>
    9779:	41 8b 44 13 10       	mov    0x10(%r11,%rdx,1),%eax
    977e:	48 69 d0 28 12 00 00 	imul   $0x1228,%rax,%rdx
    9785:	41 0f b6 04 13       	movzbl (%r11,%rdx,1),%eax
    978a:	49 01 d3             	add    %rdx,%r11
    978d:	eb 03                	jmp    9792 <fwp_gc_finalize+0x92>
    978f:	49 01 d3             	add    %rdx,%r11
    9792:	4e 8b 74 16 08       	mov    0x8(%rsi,%r10,1),%r14
    9797:	3c 01                	cmp    $0x1,%al
    9799:	74 13                	je     97ae <fwp_gc_finalize+0xae>
    979b:	0f b6 c0             	movzbl %al,%eax
    979e:	83 f8 02             	cmp    $0x2,%eax
    97a1:	75 35                	jne    97d8 <fwp_gc_finalize+0xd8>
    97a3:	41 0f b6 53 03       	movzbl 0x3(%r11),%edx
    97a8:	85 d2                	test   %edx,%edx
    97aa:	75 84                	jne    9730 <fwp_gc_finalize+0x30>
    97ac:	eb 2a                	jmp    97d8 <fwp_gc_finalize+0xd8>
    97ae:	0f b7 c7             	movzwl %di,%eax
    97b1:	31 d2                	xor    %edx,%edx
    97b3:	41 f7 73 08          	divl   0x8(%r11)
    97b7:	89 c2                	mov    %eax,%edx
    97b9:	c1 ea 03             	shr    $0x3,%edx
    97bc:	81 e2 f8 1f 00 00    	and    $0x1ff8,%edx
    97c2:	4d 8b 5c 13 28       	mov    0x28(%r11,%rdx,1),%r11
    97c7:	31 d2                	xor    %edx,%edx
    97c9:	49 0f a3 c3          	bt     %rax,%r11
    97cd:	0f 92 c2             	setb   %dl
    97d0:	85 d2                	test   %edx,%edx
    97d2:	0f 85 58 ff ff ff    	jne    9730 <fwp_gc_finalize+0x30>
    97d8:	49 01 f2             	add    %rsi,%r10
    97db:	48 ff c9             	dec    %rcx
    97de:	48 89 0d 5b 1c 01 00 	mov    %rcx,0x11c5b(%rip)        # 1b440 <fwp_gc+0x11b8>
    97e5:	48 c1 e1 04          	shl    $0x4,%rcx
    97e9:	0f 10 04 0e          	movups (%rsi,%rcx,1),%xmm0
    97ed:	41 0f 11 02          	movups %xmm0,(%r10)
    97f1:	41 ff d6             	call   *%r14
    97f4:	48 8b 35 3d 1c 01 00 	mov    0x11c3d(%rip),%rsi        # 1b438 <fwp_gc+0x11b0>
    97fb:	4c 8b 05 b6 1a 01 00 	mov    0x11ab6(%rip),%r8        # 1b2b8 <fwp_gc+0x1030>
    9802:	4c 8b 0d d7 1a 01 00 	mov    0x11ad7(%rip),%r9        # 1b2e0 <fwp_gc+0x1058>
    9809:	48 8b 0d 30 1c 01 00 	mov    0x11c30(%rip),%rcx        # 1b440 <fwp_gc+0x11b8>
    9810:	48 39 cb             	cmp    %rcx,%rbx
    9813:	0f 82 23 ff ff ff    	jb     973c <fwp_gc_finalize+0x3c>
    9819:	48 83 c4 08          	add    $0x8,%rsp
    981d:	5b                   	pop    %rbx
    981e:	41 5e                	pop    %r14
    9820:	c3                   	ret
    9821:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9828:	0f 1f 84 00 00 00 00 
    982f:	00 

0000000000009830 <fwp_gc_sweep>:
    9830:	55                   	push   %rbp
    9831:	41 57                	push   %r15
    9833:	41 56                	push   %r14
    9835:	41 55                	push   %r13
    9837:	41 54                	push   %r12
    9839:	53                   	push   %rbx
    983a:	48 83 ec 28          	sub    $0x28,%rsp
    983e:	48 8d 3d 4b 0a 01 00 	lea    0x10a4b(%rip),%rdi        # 1a290 <fwp_gc+0x8>
    9845:	31 ed                	xor    %ebp,%ebp
    9847:	ba 40 0b 00 00       	mov    $0xb40,%edx
    984c:	31 f6                	xor    %esi,%esi
    984e:	e8 bd 99 ff ff       	call   3210 <memset@plt>
    9853:	48 83 3d 85 1a 01 00 	cmpq   $0x0,0x11a85(%rip)        # 1b2e0 <fwp_gc+0x1058>
    985a:	00 
    985b:	0f 84 0f 05 00 00    	je     9d70 <fwp_gc_sweep+0x540>
    9861:	31 c0                	xor    %eax,%eax
    9863:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    9868:	49 b9 55 55 55 55 55 	movabs $0x5555555555555555,%r9
    986f:	55 55 55 
    9872:	49 ba 33 33 33 33 33 	movabs $0x3333333333333333,%r10
    9879:	33 33 33 
    987c:	49 bb 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r11
    9883:	0f 0f 0f 
    9886:	49 bc 01 01 01 01 01 	movabs $0x101010101010101,%r12
    988d:	01 01 01 
    9890:	66 0f 6f 2d 28 b8 00 	movdqa 0xb828(%rip),%xmm5        # 150c0 <_IO_stdin_used+0xc0>
    9897:	00 
    9898:	66 0f 6f 35 30 b8 00 	movdqa 0xb830(%rip),%xmm6        # 150d0 <_IO_stdin_used+0xd0>
    989f:	00 
    98a0:	66 0f 6f 3d 38 b8 00 	movdqa 0xb838(%rip),%xmm7        # 150e0 <_IO_stdin_used+0xe0>
    98a7:	00 
    98a8:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    98ad:	31 ed                	xor    %ebp,%ebp
    98af:	45 31 ed             	xor    %r13d,%r13d
    98b2:	eb 22                	jmp    98d6 <fwp_gc_sweep+0xa6>
    98b4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    98bb:	00 00 00 00 00 
    98c0:	48 ff c5             	inc    %rbp
    98c3:	49 ff c5             	inc    %r13
    98c6:	48 8b 05 13 1a 01 00 	mov    0x11a13(%rip),%rax        # 1b2e0 <fwp_gc+0x1058>
    98cd:	49 39 c5             	cmp    %rax,%r13
    98d0:	0f 83 a3 04 00 00    	jae    9d79 <fwp_gc_sweep+0x549>
    98d6:	48 8b 1d 23 1a 01 00 	mov    0x11a23(%rip),%rbx        # 1b300 <fwp_gc+0x1078>
    98dd:	4d 69 f5 28 12 00 00 	imul   $0x1228,%r13,%r14
    98e4:	42 0f b6 04 33       	movzbl (%rbx,%r14,1),%eax
    98e9:	85 c0                	test   %eax,%eax
    98eb:	74 d3                	je     98c0 <fwp_gc_sweep+0x90>
    98ed:	83 f8 01             	cmp    $0x1,%eax
    98f0:	74 2e                	je     9920 <fwp_gc_sweep+0xf0>
    98f2:	83 f8 02             	cmp    $0x2,%eax
    98f5:	75 cc                	jne    98c3 <fwp_gc_sweep+0x93>
    98f7:	46 8b 64 33 10       	mov    0x10(%rbx,%r14,1),%r12d
    98fc:	42 80 7c 33 03 00    	cmpb   $0x0,0x3(%rbx,%r14,1)
    9902:	74 50                	je     9954 <fwp_gc_sweep+0x124>
    9904:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    9909:	4a 03 44 33 18       	add    0x18(%rbx,%r14,1),%rax
    990e:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    9913:	e9 fb 03 00 00       	jmp    9d13 <fwp_gc_sweep+0x4e3>
    9918:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    991f:	00 
    9920:	4a 8d 04 33          	lea    (%rbx,%r14,1),%rax
    9924:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    9929:	46 8b 7c 33 0c       	mov    0xc(%rbx,%r14,1),%r15d
    992e:	4d 85 ff             	test   %r15,%r15
    9931:	0f 84 b5 02 00 00    	je     9bec <fwp_gc_sweep+0x3bc>
    9937:	49 8d 57 3f          	lea    0x3f(%r15),%rdx
    993b:	48 89 d0             	mov    %rdx,%rax
    993e:	48 c1 e8 06          	shr    $0x6,%rax
    9942:	41 81 ff c1 00 00 00 	cmp    $0xc1,%r15d
    9949:	73 48                	jae    9993 <fwp_gc_sweep+0x163>
    994b:	31 d2                	xor    %edx,%edx
    994d:	31 c9                	xor    %ecx,%ecx
    994f:	e9 1b 01 00 00       	jmp    9a6f <fwp_gc_sweep+0x23f>
    9954:	4e 8d 3c 33          	lea    (%rbx,%r14,1),%r15
    9958:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    995f:	42 80 bc 33 28 02 00 	cmpb   $0xff,0x228(%rbx,%r14,1)
    9966:	00 ff 
    9968:	0f 84 d8 03 00 00    	je     9d46 <fwp_gc_sweep+0x516>
    996e:	41 c6 07 00          	movb   $0x0,(%r15)
    9972:	4d 85 e4             	test   %r12,%r12
    9975:	0f 84 95 03 00 00    	je     9d10 <fwp_gc_sweep+0x4e0>
    997b:	48 8b 05 7e 19 01 00 	mov    0x1197e(%rip),%rax        # 1b300 <fwp_gc+0x1078>
    9982:	41 83 fc 04          	cmp    $0x4,%r12d
    9986:	0f 83 15 03 00 00    	jae    9ca1 <fwp_gc_sweep+0x471>
    998c:	31 c9                	xor    %ecx,%ecx
    998e:	e9 45 03 00 00       	jmp    9cd8 <fwp_gc_sweep+0x4a8>
    9993:	89 c1                	mov    %eax,%ecx
    9995:	83 e1 fc             	and    $0xfffffffc,%ecx
    9998:	4a 8d 34 33          	lea    (%rbx,%r14,1),%rsi
    999c:	48 83 c6 38          	add    $0x38,%rsi
    99a0:	48 c1 ea 03          	shr    $0x3,%rdx
    99a4:	83 e2 e0             	and    $0xffffffe0,%edx
    99a7:	66 0f ef c0          	pxor   %xmm0,%xmm0
    99ab:	31 ff                	xor    %edi,%edi
    99ad:	66 0f ef c9          	pxor   %xmm1,%xmm1
    99b1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    99b8:	0f 1f 84 00 00 00 00 
    99bf:	00 
    99c0:	f3 0f 6f 5c 3e f0    	movdqu -0x10(%rsi,%rdi,1),%xmm3
    99c6:	f3 0f 6f 14 3e       	movdqu (%rsi,%rdi,1),%xmm2
    99cb:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    99cf:	66 0f 71 d4 01       	psrlw  $0x1,%xmm4
    99d4:	66 0f db e5          	pand   %xmm5,%xmm4
    99d8:	66 0f f8 dc          	psubb  %xmm4,%xmm3
    99dc:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    99e0:	66 0f db e6          	pand   %xmm6,%xmm4
    99e4:	66 0f 71 d3 02       	psrlw  $0x2,%xmm3
    99e9:	66 0f db de          	pand   %xmm6,%xmm3
    99ed:	66 0f fc dc          	paddb  %xmm4,%xmm3
    99f1:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    99f5:	66 0f 71 d4 04       	psrlw  $0x4,%xmm4
    99fa:	66 0f fc e3          	paddb  %xmm3,%xmm4
    99fe:	66 0f db e7          	pand   %xmm7,%xmm4
    9a02:	66 41 0f f6 e0       	psadbw %xmm8,%xmm4
    9a07:	66 0f d4 c4          	paddq  %xmm4,%xmm0
    9a0b:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9a0f:	66 0f 71 d3 01       	psrlw  $0x1,%xmm3
    9a14:	66 0f db dd          	pand   %xmm5,%xmm3
    9a18:	66 0f f8 d3          	psubb  %xmm3,%xmm2
    9a1c:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9a20:	66 0f db de          	pand   %xmm6,%xmm3
    9a24:	66 0f 71 d2 02       	psrlw  $0x2,%xmm2
    9a29:	66 0f db d6          	pand   %xmm6,%xmm2
    9a2d:	66 0f fc d3          	paddb  %xmm3,%xmm2
    9a31:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9a35:	66 0f 71 d3 04       	psrlw  $0x4,%xmm3
    9a3a:	66 0f fc da          	paddb  %xmm2,%xmm3
    9a3e:	66 0f db df          	pand   %xmm7,%xmm3
    9a42:	66 41 0f f6 d8       	psadbw %xmm8,%xmm3
    9a47:	66 0f d4 cb          	paddq  %xmm3,%xmm1
    9a4b:	48 83 c7 20          	add    $0x20,%rdi
    9a4f:	48 39 fa             	cmp    %rdi,%rdx
    9a52:	0f 85 68 ff ff ff    	jne    99c0 <fwp_gc_sweep+0x190>
    9a58:	66 0f d4 c8          	paddq  %xmm0,%xmm1
    9a5c:	66 0f 70 c1 ee       	pshufd $0xee,%xmm1,%xmm0
    9a61:	66 0f d4 c1          	paddq  %xmm1,%xmm0
    9a65:	66 48 0f 7e c2       	movq   %xmm0,%rdx
    9a6a:	48 39 c8             	cmp    %rcx,%rax
    9a6d:	74 51                	je     9ac0 <fwp_gc_sweep+0x290>
    9a6f:	4a 8d 34 33          	lea    (%rbx,%r14,1),%rsi
    9a73:	48 83 c6 28          	add    $0x28,%rsi
    9a77:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    9a7e:	00 00 
    9a80:	48 8b 3c ce          	mov    (%rsi,%rcx,8),%rdi
    9a84:	49 89 f8             	mov    %rdi,%r8
    9a87:	49 d1 e8             	shr    $1,%r8
    9a8a:	4d 21 c8             	and    %r9,%r8
    9a8d:	4c 29 c7             	sub    %r8,%rdi
    9a90:	49 89 f8             	mov    %rdi,%r8
    9a93:	4d 21 d0             	and    %r10,%r8
    9a96:	48 c1 ef 02          	shr    $0x2,%rdi
    9a9a:	4c 21 d7             	and    %r10,%rdi
    9a9d:	4c 01 c7             	add    %r8,%rdi
    9aa0:	49 89 f8             	mov    %rdi,%r8
    9aa3:	49 c1 e8 04          	shr    $0x4,%r8
    9aa7:	49 01 f8             	add    %rdi,%r8
    9aaa:	4d 21 d8             	and    %r11,%r8
    9aad:	4d 0f af c4          	imul   %r12,%r8
    9ab1:	49 c1 e8 38          	shr    $0x38,%r8
    9ab5:	4c 01 c2             	add    %r8,%rdx
    9ab8:	48 ff c1             	inc    %rcx
    9abb:	48 39 c8             	cmp    %rcx,%rax
    9abe:	75 c0                	jne    9a80 <fwp_gc_sweep+0x250>
    9ac0:	48 85 d2             	test   %rdx,%rdx
    9ac3:	0f 84 23 01 00 00    	je     9bec <fwp_gc_sweep+0x3bc>
    9ac9:	42 8b 44 33 08       	mov    0x8(%rbx,%r14,1),%eax
    9ace:	48 0f af d0          	imul   %rax,%rdx
    9ad2:	48 01 54 24 08       	add    %rdx,0x8(%rsp)
    9ad7:	4d 85 ff             	test   %r15,%r15
    9ada:	0f 84 e3 fd ff ff    	je     98c3 <fwp_gc_sweep+0x93>
    9ae0:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
    9ae5:	42 0f b6 44 33 01    	movzbl 0x1(%rbx,%r14,1),%eax
    9aeb:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    9af2:	4d 89 ec             	mov    %r13,%r12
    9af5:	49 c1 e4 10          	shl    $0x10,%r12
    9af9:	4c 03 25 b8 17 01 00 	add    0x117b8(%rip),%r12        # 1b2b8 <fwp_gc+0x1030>
    9b00:	48 8d 0d 81 07 01 00 	lea    0x10781(%rip),%rcx        # 1a288 <fwp_gc>
    9b07:	48 01 c8             	add    %rcx,%rax
    9b0a:	4a 8d 0c 33          	lea    (%rbx,%r14,1),%rcx
    9b0e:	48 83 c1 08          	add    $0x8,%rcx
    9b12:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
    9b17:	42 0f b6 4c 33 02    	movzbl 0x2(%rbx,%r14,1),%ecx
    9b1d:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    9b21:	48 8d 2c c8          	lea    (%rax,%rcx,8),%rbp
    9b25:	48 83 c5 08          	add    $0x8,%rbp
    9b29:	4d 01 fe             	add    %r15,%r14
    9b2c:	4c 01 f3             	add    %r14,%rbx
    9b2f:	48 81 c3 27 02 00 00 	add    $0x227,%rbx
    9b36:	49 ff cf             	dec    %r15
    9b39:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    9b3e:	eb 23                	jmp    9b63 <fwp_gc_sweep+0x333>
    9b40:	80 3b ff             	cmpb   $0xff,(%rbx)
    9b43:	74 78                	je     9bbd <fwp_gc_sweep+0x38d>
    9b45:	c6 03 00             	movb   $0x0,(%rbx)
    9b48:	48 8b 45 00          	mov    0x0(%rbp),%rax
    9b4c:	48 f7 d0             	not    %rax
    9b4f:	49 89 06             	mov    %rax,(%r14)
    9b52:	4c 89 75 00          	mov    %r14,0x0(%rbp)
    9b56:	48 ff cb             	dec    %rbx
    9b59:	49 83 c7 ff          	add    $0xffffffffffffffff,%r15
    9b5d:	0f 83 37 01 00 00    	jae    9c9a <fwp_gc_sweep+0x46a>
    9b63:	4c 89 f8             	mov    %r15,%rax
    9b66:	48 c1 e8 06          	shr    $0x6,%rax
    9b6a:	48 8b 44 c1 28       	mov    0x28(%rcx,%rax,8),%rax
    9b6f:	4c 0f a3 f8          	bt     %r15,%rax
    9b73:	72 e1                	jb     9b56 <fwp_gc_sweep+0x326>
    9b75:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    9b7a:	8b 10                	mov    (%rax),%edx
    9b7c:	4d 89 fe             	mov    %r15,%r14
    9b7f:	4c 0f af f2          	imul   %rdx,%r14
    9b83:	4d 01 e6             	add    %r12,%r14
    9b86:	83 3d ff 16 01 00 00 	cmpl   $0x0,0x116ff(%rip)        # 1b28c <fwp_gc+0x1004>
    9b8d:	74 b1                	je     9b40 <fwp_gc_sweep+0x310>
    9b8f:	4c 89 f7             	mov    %r14,%rdi
    9b92:	31 f6                	xor    %esi,%esi
    9b94:	e8 77 96 ff ff       	call   3210 <memset@plt>
    9b99:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    9b9e:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    9ba3:	66 0f 6f 3d 35 b5 00 	movdqa 0xb535(%rip),%xmm7        # 150e0 <_IO_stdin_used+0xe0>
    9baa:	00 
    9bab:	66 0f 6f 35 1d b5 00 	movdqa 0xb51d(%rip),%xmm6        # 150d0 <_IO_stdin_used+0xd0>
    9bb2:	00 
    9bb3:	66 0f 6f 2d 05 b5 00 	movdqa 0xb505(%rip),%xmm5        # 150c0 <_IO_stdin_used+0xc0>
    9bba:	00 
    9bbb:	eb 83                	jmp    9b40 <fwp_gc_sweep+0x310>
    9bbd:	48 89 df             	mov    %rbx,%rdi
    9bc0:	e8 4b cf ff ff       	call   6b10 <fwp_rc_forget_slot>
    9bc5:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    9bca:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    9bcf:	66 0f 6f 3d 09 b5 00 	movdqa 0xb509(%rip),%xmm7        # 150e0 <_IO_stdin_used+0xe0>
    9bd6:	00 
    9bd7:	66 0f 6f 35 f1 b4 00 	movdqa 0xb4f1(%rip),%xmm6        # 150d0 <_IO_stdin_used+0xd0>
    9bde:	00 
    9bdf:	66 0f 6f 2d d9 b4 00 	movdqa 0xb4d9(%rip),%xmm5        # 150c0 <_IO_stdin_used+0xc0>
    9be6:	00 
    9be7:	e9 59 ff ff ff       	jmp    9b45 <fwp_gc_sweep+0x315>
    9bec:	48 83 3d ac 20 01 00 	cmpq   $0x0,0x120ac(%rip)        # 1bca0 <fwp_gc+0x1a18>
    9bf3:	00 
    9bf4:	74 38                	je     9c2e <fwp_gc_sweep+0x3fe>
    9bf6:	4e 8d 3c 33          	lea    (%rbx,%r14,1),%r15
    9bfa:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    9c01:	45 31 e4             	xor    %r12d,%r12d
    9c04:	eb 16                	jmp    9c1c <fwp_gc_sweep+0x3ec>
    9c06:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    9c0d:	00 00 00 
    9c10:	49 ff c4             	inc    %r12
    9c13:	49 81 fc 00 10 00 00 	cmp    $0x1000,%r12
    9c1a:	74 12                	je     9c2e <fwp_gc_sweep+0x3fe>
    9c1c:	43 80 3c 27 ff       	cmpb   $0xff,(%r15,%r12,1)
    9c21:	75 ed                	jne    9c10 <fwp_gc_sweep+0x3e0>
    9c23:	4b 8d 3c 27          	lea    (%r15,%r12,1),%rdi
    9c27:	e8 e4 ce ff ff       	call   6b10 <fwp_rc_forget_slot>
    9c2c:	eb e2                	jmp    9c10 <fwp_gc_sweep+0x3e0>
    9c2e:	4a 8d 3c 33          	lea    (%rbx,%r14,1),%rdi
    9c32:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    9c39:	ba 00 10 00 00       	mov    $0x1000,%edx
    9c3e:	31 f6                	xor    %esi,%esi
    9c40:	e8 cb 95 ff ff       	call   3210 <memset@plt>
    9c45:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    9c4a:	c6 00 00             	movb   $0x0,(%rax)
    9c4d:	48 ff c5             	inc    %rbp
    9c50:	49 b9 55 55 55 55 55 	movabs $0x5555555555555555,%r9
    9c57:	55 55 55 
    9c5a:	49 ba 33 33 33 33 33 	movabs $0x3333333333333333,%r10
    9c61:	33 33 33 
    9c64:	49 bb 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r11
    9c6b:	0f 0f 0f 
    9c6e:	49 bc 01 01 01 01 01 	movabs $0x101010101010101,%r12
    9c75:	01 01 01 
    9c78:	66 0f 6f 2d 40 b4 00 	movdqa 0xb440(%rip),%xmm5        # 150c0 <_IO_stdin_used+0xc0>
    9c7f:	00 
    9c80:	66 0f 6f 35 48 b4 00 	movdqa 0xb448(%rip),%xmm6        # 150d0 <_IO_stdin_used+0xd0>
    9c87:	00 
    9c88:	66 0f 6f 3d 50 b4 00 	movdqa 0xb450(%rip),%xmm7        # 150e0 <_IO_stdin_used+0xe0>
    9c8f:	00 
    9c90:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    9c95:	e9 29 fc ff ff       	jmp    98c3 <fwp_gc_sweep+0x93>
    9c9a:	48 8b 6c 24 18       	mov    0x18(%rsp),%rbp
    9c9f:	eb 78                	jmp    9d19 <fwp_gc_sweep+0x4e9>
    9ca1:	4a 8d 14 30          	lea    (%rax,%r14,1),%rdx
    9ca5:	44 89 e6             	mov    %r12d,%esi
    9ca8:	83 e6 fc             	and    $0xfffffffc,%esi
    9cab:	31 c9                	xor    %ecx,%ecx
    9cad:	0f 1f 00             	nopl   (%rax)
    9cb0:	c6 02 00             	movb   $0x0,(%rdx)
    9cb3:	c6 82 28 12 00 00 00 	movb   $0x0,0x1228(%rdx)
    9cba:	c6 82 50 24 00 00 00 	movb   $0x0,0x2450(%rdx)
    9cc1:	c6 82 78 36 00 00 00 	movb   $0x0,0x3678(%rdx)
    9cc8:	48 83 c1 04          	add    $0x4,%rcx
    9ccc:	48 81 c2 a0 48 00 00 	add    $0x48a0,%rdx
    9cd3:	48 39 ce             	cmp    %rcx,%rsi
    9cd6:	75 d8                	jne    9cb0 <fwp_gc_sweep+0x480>
    9cd8:	44 89 e2             	mov    %r12d,%edx
    9cdb:	83 e2 03             	and    $0x3,%edx
    9cde:	74 30                	je     9d10 <fwp_gc_sweep+0x4e0>
    9ce0:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    9ce7:	4c 01 f1             	add    %r14,%rcx
    9cea:	48 01 c8             	add    %rcx,%rax
    9ced:	48 69 ca 28 12 00 00 	imul   $0x1228,%rdx,%rcx
    9cf4:	31 d2                	xor    %edx,%edx
    9cf6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    9cfd:	00 00 00 
    9d00:	c6 04 10 00          	movb   $0x0,(%rax,%rdx,1)
    9d04:	48 81 c2 28 12 00 00 	add    $0x1228,%rdx
    9d0b:	48 39 d1             	cmp    %rdx,%rcx
    9d0e:	75 f0                	jne    9d00 <fwp_gc_sweep+0x4d0>
    9d10:	4c 01 e5             	add    %r12,%rbp
    9d13:	4d 01 e5             	add    %r12,%r13
    9d16:	49 ff cd             	dec    %r13
    9d19:	49 b9 55 55 55 55 55 	movabs $0x5555555555555555,%r9
    9d20:	55 55 55 
    9d23:	49 ba 33 33 33 33 33 	movabs $0x3333333333333333,%r10
    9d2a:	33 33 33 
    9d2d:	49 bb 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r11
    9d34:	0f 0f 0f 
    9d37:	49 bc 01 01 01 01 01 	movabs $0x101010101010101,%r12
    9d3e:	01 01 01 
    9d41:	e9 7d fb ff ff       	jmp    98c3 <fwp_gc_sweep+0x93>
    9d46:	4c 89 ff             	mov    %r15,%rdi
    9d49:	e8 c2 cd ff ff       	call   6b10 <fwp_rc_forget_slot>
    9d4e:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    9d53:	66 0f 6f 3d 85 b3 00 	movdqa 0xb385(%rip),%xmm7        # 150e0 <_IO_stdin_used+0xe0>
    9d5a:	00 
    9d5b:	66 0f 6f 35 6d b3 00 	movdqa 0xb36d(%rip),%xmm6        # 150d0 <_IO_stdin_used+0xd0>
    9d62:	00 
    9d63:	66 0f 6f 2d 55 b3 00 	movdqa 0xb355(%rip),%xmm5        # 150c0 <_IO_stdin_used+0xc0>
    9d6a:	00 
    9d6b:	e9 fe fb ff ff       	jmp    996e <fwp_gc_sweep+0x13e>
    9d70:	31 c0                	xor    %eax,%eax
    9d72:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    9d77:	31 c0                	xor    %eax,%eax
    9d79:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    9d7e:	48 89 15 cb 16 01 00 	mov    %rdx,0x116cb(%rip)        # 1b450 <fwp_gc+0x11c8>
    9d85:	48 89 2d dc 16 01 00 	mov    %rbp,0x116dc(%rip)        # 1b468 <fwp_gc+0x11e0>
    9d8c:	48 81 fa 01 00 00 01 	cmp    $0x1000001,%rdx
    9d93:	b9 00 00 00 01       	mov    $0x1000000,%ecx
    9d98:	48 0f 43 ca          	cmovae %rdx,%rcx
    9d9c:	48 c1 e9 10          	shr    $0x10,%rcx
    9da0:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9da4:	f3 0f 7f 05 44 15 01 	movdqu %xmm0,0x11544(%rip)        # 1b2f0 <fwp_gc+0x1068>
    9dab:	00 
    9dac:	48 29 cd             	sub    %rcx,%rbp
    9daf:	0f 86 fc 00 00 00    	jbe    9eb1 <fwp_gc_sweep+0x681>
    9db5:	48 85 c0             	test   %rax,%rax
    9db8:	0f 84 f3 00 00 00    	je     9eb1 <fwp_gc_sweep+0x681>
    9dbe:	48 85 ed             	test   %rbp,%rbp
    9dc1:	0f 84 ea 00 00 00    	je     9eb1 <fwp_gc_sweep+0x681>
    9dc7:	48 8b 0d 32 15 01 00 	mov    0x11532(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    9dce:	66 90                	xchg   %ax,%ax
    9dd0:	48 8d 58 ff          	lea    -0x1(%rax),%rbx
    9dd4:	48 69 d3 28 12 00 00 	imul   $0x1228,%rbx,%rdx
    9ddb:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
    9ddf:	0f 85 bb 00 00 00    	jne    9ea0 <fwp_gc_sweep+0x670>
    9de5:	4c 8d 75 ff          	lea    -0x1(%rbp),%r14
    9de9:	80 7c 11 04 00       	cmpb   $0x0,0x4(%rcx,%rdx,1)
    9dee:	0f 84 a9 00 00 00    	je     9e9d <fwp_gc_sweep+0x66d>
    9df4:	48 01 ca             	add    %rcx,%rdx
    9df7:	48 83 c2 04          	add    $0x4,%rdx
    9dfb:	c6 02 00             	movb   $0x0,(%rdx)
    9dfe:	be 01 00 00 00       	mov    $0x1,%esi
    9e03:	48 85 db             	test   %rbx,%rbx
    9e06:	74 72                	je     9e7a <fwp_gc_sweep+0x64a>
    9e08:	4d 85 f6             	test   %r14,%r14
    9e0b:	74 6d                	je     9e7a <fwp_gc_sweep+0x64a>
    9e0d:	ba 02 00 00 00       	mov    $0x2,%edx
    9e12:	48 29 c2             	sub    %rax,%rdx
    9e15:	48 69 c0 28 12 00 00 	imul   $0x1228,%rax,%rax
    9e1c:	48 01 c1             	add    %rax,%rcx
    9e1f:	48 81 c1 b4 db ff ff 	add    $0xffffffffffffdbb4,%rcx
    9e26:	bf 02 00 00 00       	mov    $0x2,%edi
    9e2b:	48 29 ef             	sub    %rbp,%rdi
    9e2e:	b8 01 00 00 00       	mov    $0x1,%eax
    9e33:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9e3a:	84 00 00 00 00 00 
    9e40:	80 79 fc 00          	cmpb   $0x0,-0x4(%rcx)
    9e44:	75 31                	jne    9e77 <fwp_gc_sweep+0x647>
    9e46:	80 39 00             	cmpb   $0x0,(%rcx)
    9e49:	74 2c                	je     9e77 <fwp_gc_sweep+0x647>
    9e4b:	48 ff cb             	dec    %rbx
    9e4e:	4c 8d 04 02          	lea    (%rdx,%rax,1),%r8
    9e52:	49 ff ce             	dec    %r14
    9e55:	c6 01 00             	movb   $0x0,(%rcx)
    9e58:	48 8d 70 01          	lea    0x1(%rax),%rsi
    9e5c:	49 83 f8 01          	cmp    $0x1,%r8
    9e60:	74 18                	je     9e7a <fwp_gc_sweep+0x64a>
    9e62:	48 01 f8             	add    %rdi,%rax
    9e65:	48 81 c1 d8 ed ff ff 	add    $0xffffffffffffedd8,%rcx
    9e6c:	48 83 f8 01          	cmp    $0x1,%rax
    9e70:	48 89 f0             	mov    %rsi,%rax
    9e73:	75 cb                	jne    9e40 <fwp_gc_sweep+0x610>
    9e75:	eb 03                	jmp    9e7a <fwp_gc_sweep+0x64a>
    9e77:	48 89 c6             	mov    %rax,%rsi
    9e7a:	48 89 df             	mov    %rbx,%rdi
    9e7d:	48 c1 e7 10          	shl    $0x10,%rdi
    9e81:	48 03 3d 30 14 01 00 	add    0x11430(%rip),%rdi        # 1b2b8 <fwp_gc+0x1030>
    9e88:	48 c1 e6 10          	shl    $0x10,%rsi
    9e8c:	ba 04 00 00 00       	mov    $0x4,%edx
    9e91:	e8 5a 95 ff ff       	call   33f0 <madvise@plt>
    9e96:	48 8b 0d 63 14 01 00 	mov    0x11463(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    9e9d:	4c 89 f5             	mov    %r14,%rbp
    9ea0:	48 89 d8             	mov    %rbx,%rax
    9ea3:	48 85 db             	test   %rbx,%rbx
    9ea6:	74 09                	je     9eb1 <fwp_gc_sweep+0x681>
    9ea8:	48 85 ed             	test   %rbp,%rbp
    9eab:	0f 85 1f ff ff ff    	jne    9dd0 <fwp_gc_sweep+0x5a0>
    9eb1:	48 83 c4 28          	add    $0x28,%rsp
    9eb5:	5b                   	pop    %rbx
    9eb6:	41 5c                	pop    %r12
    9eb8:	41 5d                	pop    %r13
    9eba:	41 5e                	pop    %r14
    9ebc:	41 5f                	pop    %r15
    9ebe:	5d                   	pop    %rbp
    9ebf:	c3                   	ret

0000000000009ec0 <fwp_gc_sp>:
    9ec0:	55                   	push   %rbp
    9ec1:	48 89 e5             	mov    %rsp,%rbp
    9ec4:	48 89 e8             	mov    %rbp,%rax
    9ec7:	5d                   	pop    %rbp
    9ec8:	c3                   	ret
    9ec9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000009ed0 <fwp_gc_scan>:
    9ed0:	55                   	push   %rbp
    9ed1:	41 57                	push   %r15
    9ed3:	41 56                	push   %r14
    9ed5:	41 55                	push   %r13
    9ed7:	41 54                	push   %r12
    9ed9:	53                   	push   %rbx
    9eda:	50                   	push   %rax
    9edb:	49 89 ff             	mov    %rdi,%r15
    9ede:	49 83 c7 07          	add    $0x7,%r15
    9ee2:	49 83 e7 f8          	and    $0xfffffffffffffff8,%r15
    9ee6:	49 8d 47 08          	lea    0x8(%r15),%rax
    9eea:	48 39 f0             	cmp    %rsi,%rax
    9eed:	76 0f                	jbe    9efe <fwp_gc_scan+0x2e>
    9eef:	48 83 c4 08          	add    $0x8,%rsp
    9ef3:	5b                   	pop    %rbx
    9ef4:	41 5c                	pop    %r12
    9ef6:	41 5d                	pop    %r13
    9ef8:	41 5e                	pop    %r14
    9efa:	41 5f                	pop    %r15
    9efc:	5d                   	pop    %rbp
    9efd:	c3                   	ret
    9efe:	89 d3                	mov    %edx,%ebx
    9f00:	49 89 f6             	mov    %rsi,%r14
    9f03:	4c 8b 25 ae 13 01 00 	mov    0x113ae(%rip),%r12        # 1b2b8 <fwp_gc+0x1030>
    9f0a:	4c 8b 2d cf 13 01 00 	mov    0x113cf(%rip),%r13        # 1b2e0 <fwp_gc+0x1058>
    9f11:	49 c1 e5 10          	shl    $0x10,%r13
    9f15:	eb 29                	jmp    9f40 <fwp_gc_scan+0x70>
    9f17:	4d 01 d0             	add    %r10,%r8
    9f1a:	41 80 78 03 00       	cmpb   $0x0,0x3(%r8)
    9f1f:	0f 84 a6 02 00 00    	je     a1cb <fwp_gc_scan+0x2fb>
    9f25:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    9f2c:	00 00 00 00 
    9f30:	49 8d 47 08          	lea    0x8(%r15),%rax
    9f34:	49 83 c7 10          	add    $0x10,%r15
    9f38:	4d 39 f7             	cmp    %r14,%r15
    9f3b:	49 89 c7             	mov    %rax,%r15
    9f3e:	77 af                	ja     9eef <fwp_gc_scan+0x1f>
    9f40:	49 8b 2f             	mov    (%r15),%rbp
    9f43:	48 89 e8             	mov    %rbp,%rax
    9f46:	4c 29 e0             	sub    %r12,%rax
    9f49:	4c 39 e8             	cmp    %r13,%rax
    9f4c:	0f 83 de 00 00 00    	jae    a030 <fwp_gc_scan+0x160>
    9f52:	48 8b 3d 5f 13 01 00 	mov    0x1135f(%rip),%rdi        # 1b2b8 <fwp_gc+0x1030>
    9f59:	49 89 e9             	mov    %rbp,%r9
    9f5c:	49 29 f9             	sub    %rdi,%r9
    9f5f:	48 8b 05 7a 13 01 00 	mov    0x1137a(%rip),%rax        # 1b2e0 <fwp_gc+0x1058>
    9f66:	48 c1 e0 10          	shl    $0x10,%rax
    9f6a:	49 39 c1             	cmp    %rax,%r9
    9f6d:	0f 83 6d 01 00 00    	jae    a0e0 <fwp_gc_scan+0x210>
    9f73:	4c 8b 05 86 13 01 00 	mov    0x11386(%rip),%r8        # 1b300 <fwp_gc+0x1078>
    9f7a:	4d 85 c0             	test   %r8,%r8
    9f7d:	0f 84 5d 01 00 00    	je     a0e0 <fwp_gc_scan+0x210>
    9f83:	4c 89 c8             	mov    %r9,%rax
    9f86:	48 c1 e8 10          	shr    $0x10,%rax
    9f8a:	4c 69 d0 28 12 00 00 	imul   $0x1228,%rax,%r10
    9f91:	43 0f b6 0c 10       	movzbl (%r8,%r10,1),%ecx
    9f96:	83 f9 03             	cmp    $0x3,%ecx
    9f99:	0f 84 0c 01 00 00    	je     a0ab <fwp_gc_scan+0x1db>
    9f9f:	83 f9 02             	cmp    $0x2,%ecx
    9fa2:	0f 84 f7 00 00 00    	je     a09f <fwp_gc_scan+0x1cf>
    9fa8:	83 f9 01             	cmp    $0x1,%ecx
    9fab:	0f 85 2f 01 00 00    	jne    a0e0 <fwp_gc_scan+0x210>
    9fb1:	43 8b 4c 10 08       	mov    0x8(%r8,%r10,1),%ecx
    9fb6:	0f b7 c5             	movzwl %bp,%eax
    9fb9:	31 d2                	xor    %edx,%edx
    9fbb:	48 89 0c 24          	mov    %rcx,(%rsp)
    9fbf:	f7 f1                	div    %ecx
    9fc1:	43 3b 44 10 0c       	cmp    0xc(%r8,%r10,1),%eax
    9fc6:	0f 83 14 01 00 00    	jae    a0e0 <fwp_gc_scan+0x210>
    9fcc:	ba 01 00 00 00       	mov    $0x1,%edx
    9fd1:	89 c1                	mov    %eax,%ecx
    9fd3:	48 d3 e2             	shl    %cl,%rdx
    9fd6:	4b 8d 34 10          	lea    (%r8,%r10,1),%rsi
    9fda:	41 89 c3             	mov    %eax,%r11d
    9fdd:	41 c1 eb 06          	shr    $0x6,%r11d
    9fe1:	4a 8b 4c de 28       	mov    0x28(%rsi,%r11,8),%rcx
    9fe6:	48 0f a3 c1          	bt     %rax,%rcx
    9fea:	0f 82 f0 00 00 00    	jb     a0e0 <fwp_gc_scan+0x210>
    9ff0:	4a 8d 34 de          	lea    (%rsi,%r11,8),%rsi
    9ff4:	48 83 c6 28          	add    $0x28,%rsi
    9ff8:	48 09 d1             	or     %rdx,%rcx
    9ffb:	48 89 0e             	mov    %rcx,(%rsi)
    9ffe:	43 80 7c 10 01 01    	cmpb   $0x1,0x1(%r8,%r10,1)
    a004:	0f 84 d6 00 00 00    	je     a0e0 <fwp_gc_scan+0x210>
    a00a:	49 81 e1 00 00 ff ff 	and    $0xffffffffffff0000,%r9
    a011:	4c 01 cf             	add    %r9,%rdi
    a014:	48 8b 34 24          	mov    (%rsp),%rsi
    a018:	48 0f af c6          	imul   %rsi,%rax
    a01c:	48 01 f8             	add    %rdi,%rax
    a01f:	48 89 c7             	mov    %rax,%rdi
    a022:	e9 b1 00 00 00       	jmp    a0d8 <fwp_gc_scan+0x208>
    a027:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    a02e:	00 00 
    a030:	85 db                	test   %ebx,%ebx
    a032:	0f 84 f8 fe ff ff    	je     9f30 <fwp_gc_scan+0x60>
    a038:	4c 39 e8             	cmp    %r13,%rax
    a03b:	0f 85 ef fe ff ff    	jne    9f30 <fwp_gc_scan+0x60>
    a041:	48 ff cd             	dec    %rbp
    a044:	48 8b 3d 6d 12 01 00 	mov    0x1126d(%rip),%rdi        # 1b2b8 <fwp_gc+0x1030>
    a04b:	49 89 e9             	mov    %rbp,%r9
    a04e:	49 29 f9             	sub    %rdi,%r9
    a051:	48 8b 05 88 12 01 00 	mov    0x11288(%rip),%rax        # 1b2e0 <fwp_gc+0x1058>
    a058:	48 c1 e0 10          	shl    $0x10,%rax
    a05c:	49 39 c1             	cmp    %rax,%r9
    a05f:	0f 83 cb fe ff ff    	jae    9f30 <fwp_gc_scan+0x60>
    a065:	4c 8b 05 94 12 01 00 	mov    0x11294(%rip),%r8        # 1b300 <fwp_gc+0x1078>
    a06c:	4d 85 c0             	test   %r8,%r8
    a06f:	0f 84 bb fe ff ff    	je     9f30 <fwp_gc_scan+0x60>
    a075:	4c 89 c8             	mov    %r9,%rax
    a078:	48 c1 e8 10          	shr    $0x10,%rax
    a07c:	4c 69 d0 28 12 00 00 	imul   $0x1228,%rax,%r10
    a083:	43 0f b6 0c 10       	movzbl (%r8,%r10,1),%ecx
    a088:	83 f9 03             	cmp    $0x3,%ecx
    a08b:	0f 84 20 01 00 00    	je     a1b1 <fwp_gc_scan+0x2e1>
    a091:	83 f9 02             	cmp    $0x2,%ecx
    a094:	0f 85 a3 00 00 00    	jne    a13d <fwp_gc_scan+0x26d>
    a09a:	e9 78 fe ff ff       	jmp    9f17 <fwp_gc_scan+0x47>
    a09f:	4d 01 d0             	add    %r10,%r8
    a0a2:	41 80 78 03 00       	cmpb   $0x0,0x3(%r8)
    a0a7:	75 37                	jne    a0e0 <fwp_gc_scan+0x210>
    a0a9:	eb 16                	jmp    a0c1 <fwp_gc_scan+0x1f1>
    a0ab:	43 8b 44 10 10       	mov    0x10(%r8,%r10,1),%eax
    a0b0:	48 69 c8 28 12 00 00 	imul   $0x1228,%rax,%rcx
    a0b7:	49 01 c8             	add    %rcx,%r8
    a0ba:	41 80 78 03 00       	cmpb   $0x0,0x3(%r8)
    a0bf:	75 1f                	jne    a0e0 <fwp_gc_scan+0x210>
    a0c1:	41 c6 40 03 01       	movb   $0x1,0x3(%r8)
    a0c6:	41 80 78 01 01       	cmpb   $0x1,0x1(%r8)
    a0cb:	74 13                	je     a0e0 <fwp_gc_scan+0x210>
    a0cd:	48 c1 e0 10          	shl    $0x10,%rax
    a0d1:	48 01 c7             	add    %rax,%rdi
    a0d4:	49 8b 70 18          	mov    0x18(%r8),%rsi
    a0d8:	e8 13 01 00 00       	call   a1f0 <fwp_gc_push>
    a0dd:	0f 1f 00             	nopl   (%rax)
    a0e0:	85 db                	test   %ebx,%ebx
    a0e2:	0f 84 48 fe ff ff    	je     9f30 <fwp_gc_scan+0x60>
    a0e8:	48 ff cd             	dec    %rbp
    a0eb:	48 8b 3d c6 11 01 00 	mov    0x111c6(%rip),%rdi        # 1b2b8 <fwp_gc+0x1030>
    a0f2:	49 89 e9             	mov    %rbp,%r9
    a0f5:	49 29 f9             	sub    %rdi,%r9
    a0f8:	48 8b 05 e1 11 01 00 	mov    0x111e1(%rip),%rax        # 1b2e0 <fwp_gc+0x1058>
    a0ff:	48 c1 e0 10          	shl    $0x10,%rax
    a103:	49 39 c1             	cmp    %rax,%r9
    a106:	0f 83 24 fe ff ff    	jae    9f30 <fwp_gc_scan+0x60>
    a10c:	4c 8b 05 ed 11 01 00 	mov    0x111ed(%rip),%r8        # 1b300 <fwp_gc+0x1078>
    a113:	4d 85 c0             	test   %r8,%r8
    a116:	0f 84 14 fe ff ff    	je     9f30 <fwp_gc_scan+0x60>
    a11c:	4c 89 c8             	mov    %r9,%rax
    a11f:	48 c1 e8 10          	shr    $0x10,%rax
    a123:	4c 69 d0 28 12 00 00 	imul   $0x1228,%rax,%r10
    a12a:	43 0f b6 0c 10       	movzbl (%r8,%r10,1),%ecx
    a12f:	83 f9 03             	cmp    $0x3,%ecx
    a132:	74 7d                	je     a1b1 <fwp_gc_scan+0x2e1>
    a134:	83 f9 02             	cmp    $0x2,%ecx
    a137:	0f 84 da fd ff ff    	je     9f17 <fwp_gc_scan+0x47>
    a13d:	83 f9 01             	cmp    $0x1,%ecx
    a140:	0f 85 ea fd ff ff    	jne    9f30 <fwp_gc_scan+0x60>
    a146:	43 8b 74 10 08       	mov    0x8(%r8,%r10,1),%esi
    a14b:	0f b7 c5             	movzwl %bp,%eax
    a14e:	31 d2                	xor    %edx,%edx
    a150:	f7 f6                	div    %esi
    a152:	43 3b 44 10 0c       	cmp    0xc(%r8,%r10,1),%eax
    a157:	0f 83 d3 fd ff ff    	jae    9f30 <fwp_gc_scan+0x60>
    a15d:	ba 01 00 00 00       	mov    $0x1,%edx
    a162:	89 c1                	mov    %eax,%ecx
    a164:	48 d3 e2             	shl    %cl,%rdx
    a167:	4b 8d 0c 10          	lea    (%r8,%r10,1),%rcx
    a16b:	41 89 c3             	mov    %eax,%r11d
    a16e:	41 c1 eb 06          	shr    $0x6,%r11d
    a172:	4a 8b 6c d9 28       	mov    0x28(%rcx,%r11,8),%rbp
    a177:	48 0f a3 c5          	bt     %rax,%rbp
    a17b:	0f 82 af fd ff ff    	jb     9f30 <fwp_gc_scan+0x60>
    a181:	4a 8d 0c d9          	lea    (%rcx,%r11,8),%rcx
    a185:	48 83 c1 28          	add    $0x28,%rcx
    a189:	48 09 d5             	or     %rdx,%rbp
    a18c:	48 89 29             	mov    %rbp,(%rcx)
    a18f:	43 80 7c 10 01 01    	cmpb   $0x1,0x1(%r8,%r10,1)
    a195:	0f 84 95 fd ff ff    	je     9f30 <fwp_gc_scan+0x60>
    a19b:	49 81 e1 00 00 ff ff 	and    $0xffffffffffff0000,%r9
    a1a2:	4c 01 cf             	add    %r9,%rdi
    a1a5:	48 0f af c6          	imul   %rsi,%rax
    a1a9:	48 01 f8             	add    %rdi,%rax
    a1ac:	48 89 c7             	mov    %rax,%rdi
    a1af:	eb 35                	jmp    a1e6 <fwp_gc_scan+0x316>
    a1b1:	43 8b 44 10 10       	mov    0x10(%r8,%r10,1),%eax
    a1b6:	48 69 c8 28 12 00 00 	imul   $0x1228,%rax,%rcx
    a1bd:	49 01 c8             	add    %rcx,%r8
    a1c0:	41 80 78 03 00       	cmpb   $0x0,0x3(%r8)
    a1c5:	0f 85 65 fd ff ff    	jne    9f30 <fwp_gc_scan+0x60>
    a1cb:	41 c6 40 03 01       	movb   $0x1,0x3(%r8)
    a1d0:	41 80 78 01 01       	cmpb   $0x1,0x1(%r8)
    a1d5:	0f 84 55 fd ff ff    	je     9f30 <fwp_gc_scan+0x60>
    a1db:	48 c1 e0 10          	shl    $0x10,%rax
    a1df:	48 01 c7             	add    %rax,%rdi
    a1e2:	49 8b 70 18          	mov    0x18(%r8),%rsi
    a1e6:	e8 05 00 00 00       	call   a1f0 <fwp_gc_push>
    a1eb:	e9 40 fd ff ff       	jmp    9f30 <fwp_gc_scan+0x60>

000000000000a1f0 <fwp_gc_push>:
    a1f0:	41 56                	push   %r14
    a1f2:	53                   	push   %rbx
    a1f3:	50                   	push   %rax
    a1f4:	48 89 f3             	mov    %rsi,%rbx
    a1f7:	49 89 fe             	mov    %rdi,%r14
    a1fa:	48 8b 0d 27 12 01 00 	mov    0x11227(%rip),%rcx        # 1b428 <fwp_gc+0x11a0>
    a201:	48 8b 05 18 12 01 00 	mov    0x11218(%rip),%rax        # 1b420 <fwp_gc+0x1198>
    a208:	48 3b 0d 21 12 01 00 	cmp    0x11221(%rip),%rcx        # 1b430 <fwp_gc+0x11a8>
    a20f:	75 36                	jne    a247 <fwp_gc_push+0x57>
    a211:	48 8d 14 09          	lea    (%rcx,%rcx,1),%rdx
    a215:	48 85 c9             	test   %rcx,%rcx
    a218:	be 00 10 00 00       	mov    $0x1000,%esi
    a21d:	48 0f 45 f2          	cmovne %rdx,%rsi
    a221:	48 89 35 08 12 01 00 	mov    %rsi,0x11208(%rip)        # 1b430 <fwp_gc+0x11a8>
    a228:	48 c1 e6 04          	shl    $0x4,%rsi
    a22c:	48 89 c7             	mov    %rax,%rdi
    a22f:	e8 4c 91 ff ff       	call   3380 <realloc@plt>
    a234:	48 89 05 e5 11 01 00 	mov    %rax,0x111e5(%rip)        # 1b420 <fwp_gc+0x1198>
    a23b:	48 85 c0             	test   %rax,%rax
    a23e:	74 29                	je     a269 <fwp_gc_push+0x79>
    a240:	48 8b 0d e1 11 01 00 	mov    0x111e1(%rip),%rcx        # 1b428 <fwp_gc+0x11a0>
    a247:	48 89 ca             	mov    %rcx,%rdx
    a24a:	48 c1 e2 04          	shl    $0x4,%rdx
    a24e:	4c 89 34 10          	mov    %r14,(%rax,%rdx,1)
    a252:	48 89 5c 10 08       	mov    %rbx,0x8(%rax,%rdx,1)
    a257:	48 ff c1             	inc    %rcx
    a25a:	48 89 0d c7 11 01 00 	mov    %rcx,0x111c7(%rip)        # 1b428 <fwp_gc+0x11a0>
    a261:	48 83 c4 08          	add    $0x8,%rsp
    a265:	5b                   	pop    %rbx
    a266:	41 5e                	pop    %r14
    a268:	c3                   	ret
    a269:	48 8b 05 68 fd 00 00 	mov    0xfd68(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a270:	48 8b 08             	mov    (%rax),%rcx
    a273:	48 8d 3d 68 b8 00 00 	lea    0xb868(%rip),%rdi        # 15ae2 <exec_in_fp0+0x272>
    a27a:	be 13 00 00 00       	mov    $0x13,%esi
    a27f:	ba 01 00 00 00       	mov    $0x1,%edx
    a284:	e8 f7 91 ff ff       	call   3480 <fwrite@plt>
    a289:	bf 66 00 00 00       	mov    $0x66,%edi
    a28e:	e8 cd 91 ff ff       	call   3460 <exit@plt>
    a293:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a29a:	84 00 00 00 00 00 

000000000000a2a0 <fwp_closure_drop>:
    a2a0:	41 57                	push   %r15
    a2a2:	41 56                	push   %r14
    a2a4:	53                   	push   %rbx
    a2a5:	48 81 ec 30 02 00 00 	sub    $0x230,%rsp
    a2ac:	48 89 f8             	mov    %rdi,%rax
    a2af:	48 2b 05 02 10 01 00 	sub    0x11002(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    a2b6:	48 8b 0d 23 10 01 00 	mov    0x11023(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    a2bd:	48 c1 e1 10          	shl    $0x10,%rcx
    a2c1:	48 39 c8             	cmp    %rcx,%rax
    a2c4:	0f 83 91 00 00 00    	jae    a35b <fwp_closure_drop+0xbb>
    a2ca:	48 89 fe             	mov    %rdi,%rsi
    a2cd:	48 8b 0d 2c 10 01 00 	mov    0x1102c(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    a2d4:	48 89 c2             	mov    %rax,%rdx
    a2d7:	48 c1 ea 10          	shr    $0x10,%rdx
    a2db:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a2e2:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
    a2e6:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a2ec:	75 13                	jne    a301 <fwp_closure_drop+0x61>
    a2ee:	40 80 ff 02          	cmp    $0x2,%dil
    a2f2:	75 0d                	jne    a301 <fwp_closure_drop+0x61>
    a2f4:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    a2f8:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    a2ff:	eb 20                	jmp    a321 <fwp_closure_drop+0x81>
    a301:	40 80 ff 01          	cmp    $0x1,%dil
    a305:	75 54                	jne    a35b <fwp_closure_drop+0xbb>
    a307:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    a30b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a30f:	48 0f af c1          	imul   %rcx,%rax
    a313:	48 c1 e8 20          	shr    $0x20,%rax
    a317:	48 01 c7             	add    %rax,%rdi
    a31a:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    a321:	0f b6 07             	movzbl (%rdi),%eax
    a324:	85 c0                	test   %eax,%eax
    a326:	74 33                	je     a35b <fwp_closure_drop+0xbb>
    a328:	83 f8 01             	cmp    $0x1,%eax
    a32b:	75 1f                	jne    a34c <fwp_closure_drop+0xac>
    a32d:	64 48 8b 3c 25 f8 ff 	mov    %fs:0xfffffffffffffff8,%rdi
    a334:	ff ff 
    a336:	48 85 ff             	test   %rdi,%rdi
    a339:	74 2d                	je     a368 <fwp_closure_drop+0xc8>
    a33b:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    a342:	5b                   	pop    %rbx
    a343:	41 5e                	pop    %r14
    a345:	41 5f                	pop    %r15
    a347:	e9 44 01 00 00       	jmp    a490 <fwp_closure_drop_push>
    a34c:	3d ff 00 00 00       	cmp    $0xff,%eax
    a351:	0f 84 e7 00 00 00    	je     a43e <fwp_closure_drop+0x19e>
    a357:	fe c8                	dec    %al
    a359:	88 07                	mov    %al,(%rdi)
    a35b:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    a362:	5b                   	pop    %rbx
    a363:	41 5e                	pop    %r14
    a365:	41 5f                	pop    %r15
    a367:	c3                   	ret
    a368:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
    a36f:	00 00 
    a371:	4c 8d b0 f8 ff ff ff 	lea    -0x8(%rax),%r14
    a378:	48 8d 5c 24 30       	lea    0x30(%rsp),%rbx
    a37d:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    a382:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    a389:	00 00 
    a38b:	48 c7 44 24 28 40 00 	movq   $0x40,0x28(%rsp)
    a392:	00 00 
    a394:	48 8b 05 1d 1b 01 00 	mov    0x11b1d(%rip),%rax        # 1beb8 <fwp_cleanups>
    a39b:	48 89 04 24          	mov    %rax,(%rsp)
    a39f:	48 8d 05 ca 01 00 00 	lea    0x1ca(%rip),%rax        # a570 <fwp_closure_drop_release>
    a3a6:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    a3ab:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    a3b0:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    a3b5:	49 89 e7             	mov    %rsp,%r15
    a3b8:	4c 89 3d f9 1a 01 00 	mov    %r15,0x11af9(%rip)        # 1beb8 <fwp_cleanups>
    a3bf:	49 89 3e             	mov    %rdi,(%r14)
    a3c2:	e8 c9 00 00 00       	call   a490 <fwp_closure_drop_push>
    a3c7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    a3ce:	00 00 
    a3d0:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    a3d5:	48 85 c0             	test   %rax,%rax
    a3d8:	74 31                	je     a40b <fwp_closure_drop+0x16b>
    a3da:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    a3df:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    a3e3:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
    a3e8:	48 8b 7c c1 f8       	mov    -0x8(%rcx,%rax,8),%rdi
    a3ed:	48 8b 05 7c 1a 01 00 	mov    0x11a7c(%rip),%rax        # 1be70 <fwp_fns>
    a3f4:	8b 0f                	mov    (%rdi),%ecx
    a3f6:	48 c1 e1 05          	shl    $0x5,%rcx
    a3fa:	48 8b 44 08 18       	mov    0x18(%rax,%rcx,1),%rax
    a3ff:	48 85 c0             	test   %rax,%rax
    a402:	74 4b                	je     a44f <fwp_closure_drop+0x1af>
    a404:	31 f6                	xor    %esi,%esi
    a406:	ff 50 08             	call   *0x8(%rax)
    a409:	eb c5                	jmp    a3d0 <fwp_closure_drop+0x130>
    a40b:	4c 39 3d a6 1a 01 00 	cmp    %r15,0x11aa6(%rip)        # 1beb8 <fwp_cleanups>
    a412:	75 69                	jne    a47d <fwp_closure_drop+0x1dd>
    a414:	48 8b 04 24          	mov    (%rsp),%rax
    a418:	48 89 05 99 1a 01 00 	mov    %rax,0x11a99(%rip)        # 1beb8 <fwp_cleanups>
    a41f:	49 c7 06 00 00 00 00 	movq   $0x0,(%r14)
    a426:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    a42b:	48 39 df             	cmp    %rbx,%rdi
    a42e:	0f 84 27 ff ff ff    	je     a35b <fwp_closure_drop+0xbb>
    a434:	e8 17 8c ff ff       	call   3050 <free@plt>
    a439:	e9 1d ff ff ff       	jmp    a35b <fwp_closure_drop+0xbb>
    a43e:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    a445:	5b                   	pop    %rbx
    a446:	41 5e                	pop    %r14
    a448:	41 5f                	pop    %r15
    a44a:	e9 61 01 00 00       	jmp    a5b0 <fwp_rc_wide_drop>
    a44f:	e8 6c c7 ff ff       	call   6bc0 <fwp_flush>
    a454:	48 8b 05 7d fb 00 00 	mov    0xfb7d(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a45b:	48 8b 38             	mov    (%rax),%rdi
    a45e:	48 8d 35 25 b6 00 00 	lea    0xb625(%rip),%rsi        # 15a8a <exec_in_fp0+0x21a>
    a465:	48 8d 15 3c b7 00 00 	lea    0xb73c(%rip),%rdx        # 15ba8 <exec_in_fp0+0x338>
    a46c:	31 c0                	xor    %eax,%eax
    a46e:	e8 7d 8e ff ff       	call   32f0 <fprintf@plt>
    a473:	bf 65 00 00 00       	mov    $0x65,%edi
    a478:	e8 e3 8f ff ff       	call   3460 <exit@plt>
    a47d:	e8 ee 8b ff ff       	call   3070 <abort@plt>
    a482:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a489:	1f 84 00 00 00 00 00 

000000000000a490 <fwp_closure_drop_push>:
    a490:	55                   	push   %rbp
    a491:	41 57                	push   %r15
    a493:	41 56                	push   %r14
    a495:	41 55                	push   %r13
    a497:	41 54                	push   %r12
    a499:	53                   	push   %rbx
    a49a:	50                   	push   %rax
    a49b:	48 89 f3             	mov    %rsi,%rbx
    a49e:	49 89 fe             	mov    %rdi,%r14
    a4a1:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    a4a5:	4c 3b 6f 10          	cmp    0x10(%rdi),%r13
    a4a9:	75 59                	jne    a504 <fwp_closure_drop_push+0x74>
    a4ab:	4c 89 e8             	mov    %r13,%rax
    a4ae:	48 c1 e8 3c          	shr    $0x3c,%rax
    a4b2:	75 6e                	jne    a522 <fwp_closure_drop_push+0x92>
    a4b4:	4c 89 ef             	mov    %r13,%rdi
    a4b7:	48 c1 e7 04          	shl    $0x4,%rdi
    a4bb:	e8 80 8e ff ff       	call   3340 <malloc@plt>
    a4c0:	48 85 c0             	test   %rax,%rax
    a4c3:	74 7c                	je     a541 <fwp_closure_drop_push+0xb1>
    a4c5:	49 89 c7             	mov    %rax,%r15
    a4c8:	4a 8d 2c 6d 00 00 00 	lea    0x0(,%r13,2),%rbp
    a4cf:	00 
    a4d0:	4d 8b 26             	mov    (%r14),%r12
    a4d3:	4a 8d 14 ed 00 00 00 	lea    0x0(,%r13,8),%rdx
    a4da:	00 
    a4db:	48 89 c7             	mov    %rax,%rdi
    a4de:	4c 89 e6             	mov    %r12,%rsi
    a4e1:	e8 4a 8e ff ff       	call   3330 <memcpy@plt>
    a4e6:	49 8d 46 18          	lea    0x18(%r14),%rax
    a4ea:	49 39 c4             	cmp    %rax,%r12
    a4ed:	74 0c                	je     a4fb <fwp_closure_drop_push+0x6b>
    a4ef:	4c 89 e7             	mov    %r12,%rdi
    a4f2:	e8 59 8b ff ff       	call   3050 <free@plt>
    a4f7:	4d 8b 6e 08          	mov    0x8(%r14),%r13
    a4fb:	4d 89 3e             	mov    %r15,(%r14)
    a4fe:	49 89 6e 10          	mov    %rbp,0x10(%r14)
    a502:	eb 03                	jmp    a507 <fwp_closure_drop_push+0x77>
    a504:	4d 8b 3e             	mov    (%r14),%r15
    a507:	49 8d 45 01          	lea    0x1(%r13),%rax
    a50b:	49 89 46 08          	mov    %rax,0x8(%r14)
    a50f:	4b 89 1c ef          	mov    %rbx,(%r15,%r13,8)
    a513:	48 83 c4 08          	add    $0x8,%rsp
    a517:	5b                   	pop    %rbx
    a518:	41 5c                	pop    %r12
    a51a:	41 5d                	pop    %r13
    a51c:	41 5e                	pop    %r14
    a51e:	41 5f                	pop    %r15
    a520:	5d                   	pop    %rbp
    a521:	c3                   	ret
    a522:	e8 99 c6 ff ff       	call   6bc0 <fwp_flush>
    a527:	48 8b 05 aa fa 00 00 	mov    0xfaaa(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a52e:	48 8b 38             	mov    (%rax),%rdi
    a531:	48 8d 35 52 b5 00 00 	lea    0xb552(%rip),%rsi        # 15a8a <exec_in_fp0+0x21a>
    a538:	48 8d 15 97 b6 00 00 	lea    0xb697(%rip),%rdx        # 15bd6 <exec_in_fp0+0x366>
    a53f:	eb 1d                	jmp    a55e <fwp_closure_drop_push+0xce>
    a541:	e8 7a c6 ff ff       	call   6bc0 <fwp_flush>
    a546:	48 8b 05 8b fa 00 00 	mov    0xfa8b(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a54d:	48 8b 38             	mov    (%rax),%rdi
    a550:	48 8d 35 33 b5 00 00 	lea    0xb533(%rip),%rsi        # 15a8a <exec_in_fp0+0x21a>
    a557:	48 8d 15 92 b6 00 00 	lea    0xb692(%rip),%rdx        # 15bf0 <exec_in_fp0+0x380>
    a55e:	31 c0                	xor    %eax,%eax
    a560:	e8 8b 8d ff ff       	call   32f0 <fprintf@plt>
    a565:	bf 65 00 00 00       	mov    $0x65,%edi
    a56a:	e8 f1 8e ff ff       	call   3460 <exit@plt>
    a56f:	90                   	nop

000000000000a570 <fwp_closure_drop_release>:
    a570:	41 56                	push   %r14
    a572:	53                   	push   %rbx
    a573:	50                   	push   %rax
    a574:	48 89 fb             	mov    %rdi,%rbx
    a577:	64 48 c7 04 25 f8 ff 	movq   $0x0,%fs:0xfffffffffffffff8
    a57e:	ff ff 00 00 00 00 
    a584:	48 8b 3f             	mov    (%rdi),%rdi
    a587:	4c 8d 73 18          	lea    0x18(%rbx),%r14
    a58b:	4c 39 f7             	cmp    %r14,%rdi
    a58e:	74 05                	je     a595 <fwp_closure_drop_release+0x25>
    a590:	e8 bb 8a ff ff       	call   3050 <free@plt>
    a595:	4c 89 33             	mov    %r14,(%rbx)
    a598:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
    a59f:	00 
    a5a0:	48 83 c4 08          	add    $0x8,%rsp
    a5a4:	5b                   	pop    %rbx
    a5a5:	41 5e                	pop    %r14
    a5a7:	c3                   	ret
    a5a8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a5af:	00 

000000000000a5b0 <fwp_rc_wide_drop>:
    a5b0:	53                   	push   %rbx
    a5b1:	48 89 f8             	mov    %rdi,%rax
    a5b4:	48 c1 e8 11          	shr    $0x11,%rax
    a5b8:	31 f8                	xor    %edi,%eax
    a5ba:	89 c1                	mov    %eax,%ecx
    a5bc:	c1 e9 09             	shr    $0x9,%ecx
    a5bf:	31 c1                	xor    %eax,%ecx
    a5c1:	0f b6 c1             	movzbl %cl,%eax
    a5c4:	48 8d 0d bd fc 00 00 	lea    0xfcbd(%rip),%rcx        # 1a288 <fwp_gc>
    a5cb:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    a5d2:	00 
    a5d3:	48 85 c0             	test   %rax,%rax
    a5d6:	74 16                	je     a5ee <fwp_rc_wide_drop+0x3e>
    a5d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a5df:	00 
    a5e0:	48 39 38             	cmp    %rdi,(%rax)
    a5e3:	74 37                	je     a61c <fwp_rc_wide_drop+0x6c>
    a5e5:	48 8b 40 10          	mov    0x10(%rax),%rax
    a5e9:	48 85 c0             	test   %rax,%rax
    a5ec:	75 f2                	jne    a5e0 <fwp_rc_wide_drop+0x30>
    a5ee:	e8 cd c5 ff ff       	call   6bc0 <fwp_flush>
    a5f3:	48 8b 05 de f9 00 00 	mov    0xf9de(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a5fa:	48 8b 38             	mov    (%rax),%rdi
    a5fd:	48 8d 35 86 b4 00 00 	lea    0xb486(%rip),%rsi        # 15a8a <exec_in_fp0+0x21a>
    a604:	48 8d 15 58 b4 00 00 	lea    0xb458(%rip),%rdx        # 15a63 <exec_in_fp0+0x1f3>
    a60b:	31 c0                	xor    %eax,%eax
    a60d:	e8 de 8c ff ff       	call   32f0 <fprintf@plt>
    a612:	bf 65 00 00 00       	mov    $0x65,%edi
    a617:	e8 44 8e ff ff       	call   3460 <exit@plt>
    a61c:	48 8b 48 08          	mov    0x8(%rax),%rcx
    a620:	48 ff c9             	dec    %rcx
    a623:	48 89 48 08          	mov    %rcx,0x8(%rax)
    a627:	48 81 f9 fe 00 00 00 	cmp    $0xfe,%rcx
    a62e:	75 0b                	jne    a63b <fwp_rc_wide_drop+0x8b>
    a630:	48 89 fb             	mov    %rdi,%rbx
    a633:	e8 d8 c4 ff ff       	call   6b10 <fwp_rc_forget_slot>
    a638:	c6 03 fe             	movb   $0xfe,(%rbx)
    a63b:	5b                   	pop    %rbx
    a63c:	c3                   	ret
    a63d:	0f 1f 00             	nopl   (%rax)

000000000000a640 <fwp_rc_wide_dup>:
    a640:	41 56                	push   %r14
    a642:	53                   	push   %rbx
    a643:	50                   	push   %rax
    a644:	48 89 fb             	mov    %rdi,%rbx
    a647:	48 89 f8             	mov    %rdi,%rax
    a64a:	48 c1 e8 11          	shr    $0x11,%rax
    a64e:	31 d8                	xor    %ebx,%eax
    a650:	89 c1                	mov    %eax,%ecx
    a652:	c1 e9 09             	shr    $0x9,%ecx
    a655:	31 c1                	xor    %eax,%ecx
    a657:	0f b6 c1             	movzbl %cl,%eax
    a65a:	48 8d 0d 27 fc 00 00 	lea    0xfc27(%rip),%rcx        # 1a288 <fwp_gc>
    a661:	4c 8d 34 c1          	lea    (%rcx,%rax,8),%r14
    a665:	49 81 c6 18 12 00 00 	add    $0x1218,%r14
    a66c:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    a673:	00 
    a674:	48 85 c0             	test   %rax,%rax
    a677:	74 1a                	je     a693 <fwp_rc_wide_dup+0x53>
    a679:	48 39 18             	cmp    %rbx,(%rax)
    a67c:	74 22                	je     a6a0 <fwp_rc_wide_dup+0x60>
    a67e:	66 90                	xchg   %ax,%ax
    a680:	49 89 c6             	mov    %rax,%r14
    a683:	48 8b 40 10          	mov    0x10(%rax),%rax
    a687:	48 85 c0             	test   %rax,%rax
    a68a:	74 0e                	je     a69a <fwp_rc_wide_dup+0x5a>
    a68c:	48 39 18             	cmp    %rbx,(%rax)
    a68f:	75 ef                	jne    a680 <fwp_rc_wide_dup+0x40>
    a691:	eb 09                	jmp    a69c <fwp_rc_wide_dup+0x5c>
    a693:	80 3b fe             	cmpb   $0xfe,(%rbx)
    a696:	74 16                	je     a6ae <fwp_rc_wide_dup+0x6e>
    a698:	eb 6d                	jmp    a707 <fwp_rc_wide_dup+0xc7>
    a69a:	31 c0                	xor    %eax,%eax
    a69c:	49 83 c6 10          	add    $0x10,%r14
    a6a0:	80 3b fe             	cmpb   $0xfe,(%rbx)
    a6a3:	75 41                	jne    a6e6 <fwp_rc_wide_dup+0xa6>
    a6a5:	48 85 c0             	test   %rax,%rax
    a6a8:	0f 85 a2 00 00 00    	jne    a750 <fwp_rc_wide_dup+0x110>
    a6ae:	bf 18 00 00 00       	mov    $0x18,%edi
    a6b3:	e8 88 8c ff ff       	call   3340 <malloc@plt>
    a6b8:	48 85 c0             	test   %rax,%rax
    a6bb:	74 69                	je     a726 <fwp_rc_wide_dup+0xe6>
    a6bd:	48 89 18             	mov    %rbx,(%rax)
    a6c0:	48 c7 40 08 ff 00 00 	movq   $0xff,0x8(%rax)
    a6c7:	00 
    a6c8:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
    a6cf:	00 
    a6d0:	49 89 06             	mov    %rax,(%r14)
    a6d3:	c6 03 ff             	movb   $0xff,(%rbx)
    a6d6:	48 8d 05 c3 15 01 00 	lea    0x115c3(%rip),%rax        # 1bca0 <fwp_gc+0x1a18>
    a6dd:	48 8b 0d bc 15 01 00 	mov    0x115bc(%rip),%rcx        # 1bca0 <fwp_gc+0x1a18>
    a6e4:	eb 13                	jmp    a6f9 <fwp_rc_wide_dup+0xb9>
    a6e6:	48 85 c0             	test   %rax,%rax
    a6e9:	74 1c                	je     a707 <fwp_rc_wide_dup+0xc7>
    a6eb:	48 8b 48 08          	mov    0x8(%rax),%rcx
    a6ef:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
    a6f3:	74 7a                	je     a76f <fwp_rc_wide_dup+0x12f>
    a6f5:	48 83 c0 08          	add    $0x8,%rax
    a6f9:	48 ff c1             	inc    %rcx
    a6fc:	48 89 08             	mov    %rcx,(%rax)
    a6ff:	48 83 c4 08          	add    $0x8,%rsp
    a703:	5b                   	pop    %rbx
    a704:	41 5e                	pop    %r14
    a706:	c3                   	ret
    a707:	e8 b4 c4 ff ff       	call   6bc0 <fwp_flush>
    a70c:	48 8b 05 c5 f8 00 00 	mov    0xf8c5(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a713:	48 8b 38             	mov    (%rax),%rdi
    a716:	48 8d 35 6d b3 00 00 	lea    0xb36d(%rip),%rsi        # 15a8a <exec_in_fp0+0x21a>
    a71d:	48 8d 15 3f b3 00 00 	lea    0xb33f(%rip),%rdx        # 15a63 <exec_in_fp0+0x1f3>
    a724:	eb 66                	jmp    a78c <fwp_rc_wide_dup+0x14c>
    a726:	48 8b 05 ab f8 00 00 	mov    0xf8ab(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a72d:	48 8b 08             	mov    (%rax),%rcx
    a730:	48 8d 3d ab b3 00 00 	lea    0xb3ab(%rip),%rdi        # 15ae2 <exec_in_fp0+0x272>
    a737:	be 13 00 00 00       	mov    $0x13,%esi
    a73c:	ba 01 00 00 00       	mov    $0x1,%edx
    a741:	e8 3a 8d ff ff       	call   3480 <fwrite@plt>
    a746:	bf 66 00 00 00       	mov    $0x66,%edi
    a74b:	e8 10 8d ff ff       	call   3460 <exit@plt>
    a750:	e8 6b c4 ff ff       	call   6bc0 <fwp_flush>
    a755:	48 8b 05 7c f8 00 00 	mov    0xf87c(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a75c:	48 8b 38             	mov    (%rax),%rdi
    a75f:	48 8d 35 24 b3 00 00 	lea    0xb324(%rip),%rsi        # 15a8a <exec_in_fp0+0x21a>
    a766:	48 8d 15 91 b4 00 00 	lea    0xb491(%rip),%rdx        # 15bfe <exec_in_fp0+0x38e>
    a76d:	eb 1d                	jmp    a78c <fwp_rc_wide_dup+0x14c>
    a76f:	e8 4c c4 ff ff       	call   6bc0 <fwp_flush>
    a774:	48 8b 05 5d f8 00 00 	mov    0xf85d(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a77b:	48 8b 38             	mov    (%rax),%rdi
    a77e:	48 8d 35 05 b3 00 00 	lea    0xb305(%rip),%rsi        # 15a8a <exec_in_fp0+0x21a>
    a785:	48 8d 15 97 b4 00 00 	lea    0xb497(%rip),%rdx        # 15c23 <exec_in_fp0+0x3b3>
    a78c:	31 c0                	xor    %eax,%eax
    a78e:	e8 5d 8b ff ff       	call   32f0 <fprintf@plt>
    a793:	bf 65 00 00 00       	mov    $0x65,%edi
    a798:	e8 c3 8c ff ff       	call   3460 <exit@plt>
    a79d:	0f 1f 00             	nopl   (%rax)

000000000000a7a0 <fwp_alloc_init>:
    a7a0:	53                   	push   %rbx
    a7a1:	48 ff 05 00 17 01 00 	incq   0x11700(%rip)        # 1bea8 <measured_calls>
    a7a8:	48 01 3d 01 17 01 00 	add    %rdi,0x11701(%rip)        # 1beb0 <measured_bytes>
    a7af:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    a7b6:	0f 87 f2 00 00 00    	ja     a8ae <fwp_alloc_init+0x10e>
    a7bc:	48 8d 77 0f          	lea    0xf(%rdi),%rsi
    a7c0:	48 c1 ee 04          	shr    $0x4,%rsi
    a7c4:	48 8d 05 bd fa 00 00 	lea    0xfabd(%rip),%rax        # 1a288 <fwp_gc>
    a7cb:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    a7d2:	00 
    a7d3:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    a7da:	4c 8b 05 a7 fa 00 00 	mov    0xfaa7(%rip),%r8        # 1a288 <fwp_gc>
    a7e1:	4d 89 c1             	mov    %r8,%r9
    a7e4:	49 29 d1             	sub    %rdx,%r9
    a7e7:	4c 89 0d 9a fa 00 00 	mov    %r9,0xfa9a(%rip)        # 1a288 <fwp_gc>
    a7ee:	0f 88 ba 00 00 00    	js     a8ae <fwp_alloc_init+0x10e>
    a7f4:	4c 8d 0c 49          	lea    (%rcx,%rcx,2),%r9
    a7f8:	4e 8d 14 c8          	lea    (%rax,%r9,8),%r10
    a7fc:	49 83 c2 08          	add    $0x8,%r10
    a800:	49 8b 1a             	mov    (%r10),%rbx
    a803:	48 85 db             	test   %rbx,%rbx
    a806:	74 35                	je     a83d <fwp_alloc_init+0x9d>
    a808:	48 8b 03             	mov    (%rbx),%rax
    a80b:	48 f7 d0             	not    %rax
    a80e:	49 89 02             	mov    %rax,(%r10)
    a811:	81 e7 f8 7f 00 00    	and    $0x7ff8,%edi
    a817:	48 39 d7             	cmp    %rdx,%rdi
    a81a:	0f 83 af 00 00 00    	jae    a8cf <fwp_alloc_init+0x12f>
    a820:	48 8d 04 3b          	lea    (%rbx,%rdi,1),%rax
    a824:	48 f7 d7             	not    %rdi
    a827:	48 01 d7             	add    %rdx,%rdi
    a82a:	48 83 e7 f8          	and    $0xfffffffffffffff8,%rdi
    a82e:	48 83 c7 08          	add    $0x8,%rdi
    a832:	48 89 fa             	mov    %rdi,%rdx
    a835:	48 89 c7             	mov    %rax,%rdi
    a838:	e9 8b 00 00 00       	jmp    a8c8 <fwp_alloc_init+0x128>
    a83d:	4a 8b 5c c8 10       	mov    0x10(%rax,%r9,8),%rbx
    a842:	4e 8b 54 c8 18       	mov    0x18(%rax,%r9,8),%r10
    a847:	49 29 da             	sub    %rbx,%r10
    a84a:	49 39 d2             	cmp    %rdx,%r10
    a84d:	72 2f                	jb     a87e <fwp_alloc_init+0xde>
    a84f:	4a 8d 0c c8          	lea    (%rax,%r9,8),%rcx
    a853:	48 83 c1 10          	add    $0x10,%rcx
    a857:	4c 8d 0c 13          	lea    (%rbx,%rdx,1),%r9
    a85b:	4c 89 09             	mov    %r9,(%rcx)
    a85e:	48 85 db             	test   %rbx,%rbx
    a861:	75 ae                	jne    a811 <fwp_alloc_init+0x71>
    a863:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    a86a:	00 
    a86b:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    a872:	49 29 d0             	sub    %rdx,%r8
    a875:	4c 89 05 0c fa 00 00 	mov    %r8,0xfa0c(%rip)        # 1a288 <fwp_gc>
    a87c:	78 30                	js     a8ae <fwp_alloc_init+0x10e>
    a87e:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    a882:	48 8b 5c c8 08       	mov    0x8(%rax,%rcx,8),%rbx
    a887:	48 85 db             	test   %rbx,%rbx
    a88a:	74 10                	je     a89c <fwp_alloc_init+0xfc>
    a88c:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    a890:	48 83 c0 08          	add    $0x8,%rax
    a894:	48 8b 0b             	mov    (%rbx),%rcx
    a897:	48 f7 d1             	not    %rcx
    a89a:	eb 26                	jmp    a8c2 <fwp_alloc_init+0x122>
    a89c:	48 8b 5c c8 10       	mov    0x10(%rax,%rcx,8),%rbx
    a8a1:	48 8b 74 c8 18       	mov    0x18(%rax,%rcx,8),%rsi
    a8a6:	48 29 de             	sub    %rbx,%rsi
    a8a9:	48 39 d6             	cmp    %rdx,%rsi
    a8ac:	73 08                	jae    a8b6 <fwp_alloc_init+0x116>
    a8ae:	31 f6                	xor    %esi,%esi
    a8b0:	5b                   	pop    %rbx
    a8b1:	e9 ca d9 ff ff       	jmp    8280 <fwp_gc_alloc_slow>
    a8b6:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    a8ba:	48 83 c0 10          	add    $0x10,%rax
    a8be:	48 8d 0c 13          	lea    (%rbx,%rdx,1),%rcx
    a8c2:	48 89 08             	mov    %rcx,(%rax)
    a8c5:	48 89 df             	mov    %rbx,%rdi
    a8c8:	31 f6                	xor    %esi,%esi
    a8ca:	e8 41 89 ff ff       	call   3210 <memset@plt>
    a8cf:	48 89 d8             	mov    %rbx,%rax
    a8d2:	5b                   	pop    %rbx
    a8d3:	c3                   	ret
    a8d4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    a8db:	00 00 00 00 00 

000000000000a8e0 <fwp_rc_cleanup_cell>:
    a8e0:	48 89 f8             	mov    %rdi,%rax
    a8e3:	48 8b 3f             	mov    (%rdi),%rdi
    a8e6:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    a8ed:	48 85 ff             	test   %rdi,%rdi
    a8f0:	75 0e                	jne    a900 <fwp_rc_free_obj>
    a8f2:	c3                   	ret
    a8f3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a8fa:	84 00 00 00 00 00 

000000000000a900 <fwp_rc_free_obj>:
    a900:	48 89 f8             	mov    %rdi,%rax
    a903:	48 2b 05 ae 09 01 00 	sub    0x109ae(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    a90a:	48 8b 0d cf 09 01 00 	mov    0x109cf(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    a911:	48 c1 e1 10          	shl    $0x10,%rcx
    a915:	48 39 c8             	cmp    %rcx,%rax
    a918:	0f 83 b8 01 00 00    	jae    aad6 <fwp_rc_free_obj+0x1d6>
    a91e:	55                   	push   %rbp
    a91f:	41 57                	push   %r15
    a921:	41 56                	push   %r14
    a923:	53                   	push   %rbx
    a924:	50                   	push   %rax
    a925:	48 8b 1d d4 09 01 00 	mov    0x109d4(%rip),%rbx        # 1b300 <fwp_gc+0x1078>
    a92c:	48 89 c1             	mov    %rax,%rcx
    a92f:	48 c1 e9 10          	shr    $0x10,%rcx
    a933:	4c 69 f1 28 12 00 00 	imul   $0x1228,%rcx,%r14
    a93a:	42 0f b6 2c 33       	movzbl (%rbx,%r14,1),%ebp
    a93f:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a945:	75 1a                	jne    a961 <fwp_rc_free_obj+0x61>
    a947:	40 80 fd 02          	cmp    $0x2,%bpl
    a94b:	75 14                	jne    a961 <fwp_rc_free_obj+0x61>
    a94d:	4a 8d 04 33          	lea    (%rbx,%r14,1),%rax
    a951:	48 05 28 02 00 00    	add    $0x228,%rax
    a957:	80 38 01             	cmpb   $0x1,(%rax)
    a95a:	74 32                	je     a98e <fwp_rc_free_obj+0x8e>
    a95c:	e9 6b 01 00 00       	jmp    aacc <fwp_rc_free_obj+0x1cc>
    a961:	40 80 fd 01          	cmp    $0x1,%bpl
    a965:	0f 85 61 01 00 00    	jne    aacc <fwp_rc_free_obj+0x1cc>
    a96b:	4a 8d 0c 33          	lea    (%rbx,%r14,1),%rcx
    a96f:	42 8b 54 33 20       	mov    0x20(%rbx,%r14,1),%edx
    a974:	48 0f af c2          	imul   %rdx,%rax
    a978:	48 c1 e8 20          	shr    $0x20,%rax
    a97c:	48 01 c8             	add    %rcx,%rax
    a97f:	48 05 28 02 00 00    	add    $0x228,%rax
    a985:	80 38 01             	cmpb   $0x1,(%rax)
    a988:	0f 85 3e 01 00 00    	jne    aacc <fwp_rc_free_obj+0x1cc>
    a98e:	8b 0d 7c 13 01 00    	mov    0x1137c(%rip),%ecx        # 1bd10 <fwp_reuse_verify>
    a994:	85 c9                	test   %ecx,%ecx
    a996:	0f 88 c3 00 00 00    	js     aa5f <fwp_rc_free_obj+0x15f>
    a99c:	85 c9                	test   %ecx,%ecx
    a99e:	0f 84 fd 00 00 00    	je     aaa1 <fwp_rc_free_obj+0x1a1>
    a9a4:	42 80 7c 33 01 01    	cmpb   $0x1,0x1(%rbx,%r14,1)
    a9aa:	75 0d                	jne    a9b9 <fwp_rc_free_obj+0xb9>
    a9ac:	40 80 fd 02          	cmp    $0x2,%bpl
    a9b0:	75 22                	jne    a9d4 <fwp_rc_free_obj+0xd4>
    a9b2:	4a 8b 54 33 18       	mov    0x18(%rbx,%r14,1),%rdx
    a9b7:	eb 20                	jmp    a9d9 <fwp_rc_free_obj+0xd9>
    a9b9:	c7 07 ad de 00 00    	movl   $0xdead,(%rdi)
    a9bf:	8b 47 04             	mov    0x4(%rdi),%eax
    a9c2:	48 85 c0             	test   %rax,%rax
    a9c5:	0f 84 01 01 00 00    	je     aacc <fwp_rc_free_obj+0x1cc>
    a9cb:	83 f8 04             	cmp    $0x4,%eax
    a9ce:	73 26                	jae    a9f6 <fwp_rc_free_obj+0xf6>
    a9d0:	31 c9                	xor    %ecx,%ecx
    a9d2:	eb 6a                	jmp    aa3e <fwp_rc_free_obj+0x13e>
    a9d4:	42 8b 54 33 08       	mov    0x8(%rbx,%r14,1),%edx
    a9d9:	48 89 fb             	mov    %rdi,%rbx
    a9dc:	be dd 00 00 00       	mov    $0xdd,%esi
    a9e1:	e8 2a 88 ff ff       	call   3210 <memset@plt>
    a9e6:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    a9ed:	c6 43 08 00          	movb   $0x0,0x8(%rbx)
    a9f1:	e9 d6 00 00 00       	jmp    aacc <fwp_rc_free_obj+0x1cc>
    a9f6:	89 c1                	mov    %eax,%ecx
    a9f8:	83 e1 fc             	and    $0xfffffffc,%ecx
    a9fb:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    aa02:	00 
    aa03:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    aa07:	31 f6                	xor    %esi,%esi
    aa09:	66 0f 28 05 df a6 00 	movapd 0xa6df(%rip),%xmm0        # 150f0 <_IO_stdin_used+0xf0>
    aa10:	00 
    aa11:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    aa18:	0f 1f 84 00 00 00 00 
    aa1f:	00 
    aa20:	66 0f 11 44 37 08    	movupd %xmm0,0x8(%rdi,%rsi,1)
    aa26:	66 0f 11 44 37 18    	movupd %xmm0,0x18(%rdi,%rsi,1)
    aa2c:	48 83 c6 20          	add    $0x20,%rsi
    aa30:	48 39 f2             	cmp    %rsi,%rdx
    aa33:	75 eb                	jne    aa20 <fwp_rc_free_obj+0x120>
    aa35:	48 39 c1             	cmp    %rax,%rcx
    aa38:	0f 84 8e 00 00 00    	je     aacc <fwp_rc_free_obj+0x1cc>
    aa3e:	48 ba ef be ad de ef 	movabs $0xdeadbeefdeadbeef,%rdx
    aa45:	be ad de 
    aa48:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    aa4f:	00 
    aa50:	48 89 54 cf 08       	mov    %rdx,0x8(%rdi,%rcx,8)
    aa55:	48 ff c1             	inc    %rcx
    aa58:	48 39 c8             	cmp    %rcx,%rax
    aa5b:	75 f3                	jne    aa50 <fwp_rc_free_obj+0x150>
    aa5d:	eb 6d                	jmp    aacc <fwp_rc_free_obj+0x1cc>
    aa5f:	49 89 ff             	mov    %rdi,%r15
    aa62:	48 8d 3d d3 b1 00 00 	lea    0xb1d3(%rip),%rdi        # 15c3c <exec_in_fp0+0x3cc>
    aa69:	e8 c2 85 ff ff       	call   3030 <getenv@plt>
    aa6e:	31 c9                	xor    %ecx,%ecx
    aa70:	48 85 c0             	test   %rax,%rax
    aa73:	74 1b                	je     aa90 <fwp_rc_free_obj+0x190>
    aa75:	80 38 00             	cmpb   $0x0,(%rax)
    aa78:	74 16                	je     aa90 <fwp_rc_free_obj+0x190>
    aa7a:	48 8d 35 30 bd 00 00 	lea    0xbd30(%rip),%rsi        # 167b1 <exec_in_fp0+0xf41>
    aa81:	48 89 c7             	mov    %rax,%rdi
    aa84:	e8 47 88 ff ff       	call   32d0 <strcmp@plt>
    aa89:	31 c9                	xor    %ecx,%ecx
    aa8b:	85 c0                	test   %eax,%eax
    aa8d:	0f 95 c1             	setne  %cl
    aa90:	89 0d 7a 12 01 00    	mov    %ecx,0x1127a(%rip)        # 1bd10 <fwp_reuse_verify>
    aa96:	4c 89 ff             	mov    %r15,%rdi
    aa99:	85 c9                	test   %ecx,%ecx
    aa9b:	0f 85 03 ff ff ff    	jne    a9a4 <fwp_rc_free_obj+0xa4>
    aaa1:	48 8b 1d e0 f7 00 00 	mov    0xf7e0(%rip),%rbx        # 1a288 <fwp_gc>
    aaa8:	e8 33 00 00 00       	call   aae0 <fwp_mem_free>
    aaad:	48 8b 05 d4 f7 00 00 	mov    0xf7d4(%rip),%rax        # 1a288 <fwp_gc>
    aab4:	48 29 d8             	sub    %rbx,%rax
    aab7:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    aabc:	f2 0f 58 05 cc 09 01 	addsd  0x109cc(%rip),%xmm0        # 1b490 <fwp_gc+0x1208>
    aac3:	00 
    aac4:	f2 0f 11 05 c4 09 01 	movsd  %xmm0,0x109c4(%rip)        # 1b490 <fwp_gc+0x1208>
    aacb:	00 
    aacc:	48 83 c4 08          	add    $0x8,%rsp
    aad0:	5b                   	pop    %rbx
    aad1:	41 5e                	pop    %r14
    aad3:	41 5f                	pop    %r15
    aad5:	5d                   	pop    %rbp
    aad6:	c3                   	ret
    aad7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    aade:	00 00 

000000000000aae0 <fwp_mem_free>:
    aae0:	48 85 ff             	test   %rdi,%rdi
    aae3:	0f 84 17 02 00 00    	je     ad00 <fwp_mem_free+0x220>
    aae9:	48 8b 05 c8 07 01 00 	mov    0x107c8(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    aaf0:	48 89 f9             	mov    %rdi,%rcx
    aaf3:	48 29 c1             	sub    %rax,%rcx
    aaf6:	48 8b 15 e3 07 01 00 	mov    0x107e3(%rip),%rdx        # 1b2e0 <fwp_gc+0x1058>
    aafd:	48 c1 e2 10          	shl    $0x10,%rdx
    ab01:	48 39 d1             	cmp    %rdx,%rcx
    ab04:	0f 83 f6 01 00 00    	jae    ad00 <fwp_mem_free+0x220>
    ab0a:	41 57                	push   %r15
    ab0c:	41 56                	push   %r14
    ab0e:	41 55                	push   %r13
    ab10:	41 54                	push   %r12
    ab12:	53                   	push   %rbx
    ab13:	4c 8b 25 e6 07 01 00 	mov    0x107e6(%rip),%r12        # 1b300 <fwp_gc+0x1078>
    ab1a:	4d 85 e4             	test   %r12,%r12
    ab1d:	0f 84 d4 01 00 00    	je     acf7 <fwp_mem_free+0x217>
    ab23:	49 89 cf             	mov    %rcx,%r15
    ab26:	49 c1 ef 10          	shr    $0x10,%r15
    ab2a:	4d 69 f7 28 12 00 00 	imul   $0x1228,%r15,%r14
    ab31:	43 0f b6 14 34       	movzbl (%r12,%r14,1),%edx
    ab36:	83 fa 02             	cmp    $0x2,%edx
    ab39:	0f 84 b9 00 00 00    	je     abf8 <fwp_mem_free+0x118>
    ab3f:	83 fa 01             	cmp    $0x1,%edx
    ab42:	0f 85 af 01 00 00    	jne    acf7 <fwp_mem_free+0x217>
    ab48:	47 0f b6 4c 34 01    	movzbl 0x1(%r12,%r14,1),%r9d
    ab4e:	47 0f b6 44 34 02    	movzbl 0x2(%r12,%r14,1),%r8d
    ab54:	43 8b 74 34 08       	mov    0x8(%r12,%r14,1),%esi
    ab59:	0f b7 c7             	movzwl %di,%eax
    ab5c:	31 d2                	xor    %edx,%edx
    ab5e:	f7 f6                	div    %esi
    ab60:	48 c7 c2 fe ff ff ff 	mov    $0xfffffffffffffffe,%rdx
    ab67:	89 c1                	mov    %eax,%ecx
    ab69:	48 d3 c2             	rol    %cl,%rdx
    ab6c:	4b 8d 0c 34          	lea    (%r12,%r14,1),%rcx
    ab70:	41 89 c2             	mov    %eax,%r10d
    ab73:	41 c1 ea 03          	shr    $0x3,%r10d
    ab77:	41 81 e2 f8 1f 00 00 	and    $0x1ff8,%r10d
    ab7e:	49 21 54 0a 28       	and    %rdx,0x28(%r10,%rcx,1)
    ab83:	49 69 d1 c0 03 00 00 	imul   $0x3c0,%r9,%rdx
    ab8a:	4c 8d 3d f7 f6 00 00 	lea    0xf6f7(%rip),%r15        # 1a288 <fwp_gc>
    ab91:	49 01 d7             	add    %rdx,%r15
    ab94:	4f 8d 2c 40          	lea    (%r8,%r8,2),%r13
    ab98:	4d 01 e6             	add    %r12,%r14
    ab9b:	49 83 c6 08          	add    $0x8,%r14
    ab9f:	48 8d 1c 08          	lea    (%rax,%rcx,1),%rbx
    aba3:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    abaa:	80 bc 08 28 02 00 00 	cmpb   $0xff,0x228(%rax,%rcx,1)
    abb1:	ff 
    abb2:	0f 84 49 01 00 00    	je     ad01 <fwp_mem_free+0x221>
    abb8:	4f 8d 3c ef          	lea    (%r15,%r13,8),%r15
    abbc:	49 83 c7 08          	add    $0x8,%r15
    abc0:	c6 03 00             	movb   $0x0,(%rbx)
    abc3:	83 3d c2 06 01 00 00 	cmpl   $0x0,0x106c2(%rip)        # 1b28c <fwp_gc+0x1004>
    abca:	74 12                	je     abde <fwp_mem_free+0xfe>
    abcc:	89 f2                	mov    %esi,%edx
    abce:	48 89 fb             	mov    %rdi,%rbx
    abd1:	31 f6                	xor    %esi,%esi
    abd3:	e8 38 86 ff ff       	call   3210 <memset@plt>
    abd8:	48 89 df             	mov    %rbx,%rdi
    abdb:	41 8b 36             	mov    (%r14),%esi
    abde:	49 8b 07             	mov    (%r15),%rax
    abe1:	48 f7 d0             	not    %rax
    abe4:	48 89 07             	mov    %rax,(%rdi)
    abe7:	49 89 3f             	mov    %rdi,(%r15)
    abea:	89 f0                	mov    %esi,%eax
    abec:	48 01 05 95 f6 00 00 	add    %rax,0xf695(%rip)        # 1a288 <fwp_gc>
    abf3:	e9 ff 00 00 00       	jmp    acf7 <fwp_mem_free+0x217>
    abf8:	48 81 e1 00 00 ff ff 	and    $0xffffffffffff0000,%rcx
    abff:	48 01 c8             	add    %rcx,%rax
    ac02:	48 39 f8             	cmp    %rdi,%rax
    ac05:	0f 85 ec 00 00 00    	jne    acf7 <fwp_mem_free+0x217>
    ac0b:	4b 8b 44 34 18       	mov    0x18(%r12,%r14,1),%rax
    ac10:	48 01 05 71 f6 00 00 	add    %rax,0xf671(%rip)        # 1a288 <fwp_gc>
    ac17:	43 c6 44 34 03 00    	movb   $0x0,0x3(%r12,%r14,1)
    ac1d:	4b 8d 1c 34          	lea    (%r12,%r14,1),%rbx
    ac21:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    ac28:	43 80 bc 34 28 02 00 	cmpb   $0xff,0x228(%r12,%r14,1)
    ac2f:	00 ff 
    ac31:	0f 84 e0 00 00 00    	je     ad17 <fwp_mem_free+0x237>
    ac37:	c6 03 00             	movb   $0x0,(%rbx)
    ac3a:	43 8b 44 34 10       	mov    0x10(%r12,%r14,1),%eax
    ac3f:	48 85 c0             	test   %rax,%rax
    ac42:	0f 84 88 00 00 00    	je     acd0 <fwp_mem_free+0x1f0>
    ac48:	48 8b 0d b1 06 01 00 	mov    0x106b1(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    ac4f:	89 c2                	mov    %eax,%edx
    ac51:	83 e2 03             	and    $0x3,%edx
    ac54:	83 f8 04             	cmp    $0x4,%eax
    ac57:	73 04                	jae    ac5d <fwp_mem_free+0x17d>
    ac59:	31 f6                	xor    %esi,%esi
    ac5b:	eb 3b                	jmp    ac98 <fwp_mem_free+0x1b8>
    ac5d:	4a 8d 3c 31          	lea    (%rcx,%r14,1),%rdi
    ac61:	41 89 c0             	mov    %eax,%r8d
    ac64:	41 83 e0 fc          	and    $0xfffffffc,%r8d
    ac68:	31 f6                	xor    %esi,%esi
    ac6a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    ac70:	c6 07 00             	movb   $0x0,(%rdi)
    ac73:	c6 87 28 12 00 00 00 	movb   $0x0,0x1228(%rdi)
    ac7a:	c6 87 50 24 00 00 00 	movb   $0x0,0x2450(%rdi)
    ac81:	c6 87 78 36 00 00 00 	movb   $0x0,0x3678(%rdi)
    ac88:	48 83 c6 04          	add    $0x4,%rsi
    ac8c:	48 81 c7 a0 48 00 00 	add    $0x48a0,%rdi
    ac93:	49 39 f0             	cmp    %rsi,%r8
    ac96:	75 d8                	jne    ac70 <fwp_mem_free+0x190>
    ac98:	48 85 d2             	test   %rdx,%rdx
    ac9b:	74 33                	je     acd0 <fwp_mem_free+0x1f0>
    ac9d:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    aca4:	4c 01 f6             	add    %r14,%rsi
    aca7:	48 01 f1             	add    %rsi,%rcx
    acaa:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    acb1:	31 f6                	xor    %esi,%esi
    acb3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    acba:	84 00 00 00 00 00 
    acc0:	c6 04 31 00          	movb   $0x0,(%rcx,%rsi,1)
    acc4:	48 81 c6 28 12 00 00 	add    $0x1228,%rsi
    accb:	48 39 f2             	cmp    %rsi,%rdx
    acce:	75 f0                	jne    acc0 <fwp_mem_free+0x1e0>
    acd0:	48 01 05 91 07 01 00 	add    %rax,0x10791(%rip)        # 1b468 <fwp_gc+0x11e0>
    acd7:	4c 3b 3d 1a 06 01 00 	cmp    0x1061a(%rip),%r15        # 1b2f8 <fwp_gc+0x1070>
    acde:	73 07                	jae    ace7 <fwp_mem_free+0x207>
    ace0:	4c 89 3d 11 06 01 00 	mov    %r15,0x10611(%rip)        # 1b2f8 <fwp_gc+0x1070>
    ace7:	4c 3b 3d 02 06 01 00 	cmp    0x10602(%rip),%r15        # 1b2f0 <fwp_gc+0x1068>
    acee:	73 07                	jae    acf7 <fwp_mem_free+0x217>
    acf0:	4c 89 3d f9 05 01 00 	mov    %r15,0x105f9(%rip)        # 1b2f0 <fwp_gc+0x1068>
    acf7:	5b                   	pop    %rbx
    acf8:	41 5c                	pop    %r12
    acfa:	41 5d                	pop    %r13
    acfc:	41 5e                	pop    %r14
    acfe:	41 5f                	pop    %r15
    ad00:	c3                   	ret
    ad01:	49 89 fc             	mov    %rdi,%r12
    ad04:	48 89 df             	mov    %rbx,%rdi
    ad07:	e8 04 be ff ff       	call   6b10 <fwp_rc_forget_slot>
    ad0c:	4c 89 e7             	mov    %r12,%rdi
    ad0f:	41 8b 36             	mov    (%r14),%esi
    ad12:	e9 a1 fe ff ff       	jmp    abb8 <fwp_mem_free+0xd8>
    ad17:	48 89 df             	mov    %rbx,%rdi
    ad1a:	e8 f1 bd ff ff       	call   6b10 <fwp_rc_forget_slot>
    ad1f:	e9 13 ff ff ff       	jmp    ac37 <fwp_mem_free+0x157>
    ad24:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    ad2b:	00 00 00 00 00 

000000000000ad30 <fwp_rc_free_arr>:
    ad30:	48 89 f8             	mov    %rdi,%rax
    ad33:	48 2b 05 7e 05 01 00 	sub    0x1057e(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    ad3a:	48 8b 0d 9f 05 01 00 	mov    0x1059f(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    ad41:	48 c1 e1 10          	shl    $0x10,%rcx
    ad45:	48 39 c8             	cmp    %rcx,%rax
    ad48:	0f 83 e9 00 00 00    	jae    ae37 <fwp_rc_free_arr+0x107>
    ad4e:	53                   	push   %rbx
    ad4f:	48 8b 0d aa 05 01 00 	mov    0x105aa(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    ad56:	48 89 c2             	mov    %rax,%rdx
    ad59:	48 c1 ea 10          	shr    $0x10,%rdx
    ad5d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    ad64:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    ad68:	48 25 ff ff 00 00    	and    $0xffff,%rax
    ad6e:	75 1a                	jne    ad8a <fwp_rc_free_arr+0x5a>
    ad70:	40 80 fe 02          	cmp    $0x2,%sil
    ad74:	75 14                	jne    ad8a <fwp_rc_free_arr+0x5a>
    ad76:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    ad7a:	48 05 28 02 00 00    	add    $0x228,%rax
    ad80:	80 38 01             	cmpb   $0x1,(%rax)
    ad83:	74 31                	je     adb6 <fwp_rc_free_arr+0x86>
    ad85:	e9 ac 00 00 00       	jmp    ae36 <fwp_rc_free_arr+0x106>
    ad8a:	40 80 fe 01          	cmp    $0x1,%sil
    ad8e:	0f 85 a2 00 00 00    	jne    ae36 <fwp_rc_free_arr+0x106>
    ad94:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    ad98:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ad9c:	48 0f af c1          	imul   %rcx,%rax
    ada0:	48 c1 e8 20          	shr    $0x20,%rax
    ada4:	48 01 f0             	add    %rsi,%rax
    ada7:	48 05 28 02 00 00    	add    $0x228,%rax
    adad:	80 38 01             	cmpb   $0x1,(%rax)
    adb0:	0f 85 80 00 00 00    	jne    ae36 <fwp_rc_free_arr+0x106>
    adb6:	8b 0d 54 0f 01 00    	mov    0x10f54(%rip),%ecx        # 1bd10 <fwp_reuse_verify>
    adbc:	85 c9                	test   %ecx,%ecx
    adbe:	78 0d                	js     adcd <fwp_rc_free_arr+0x9d>
    adc0:	85 c9                	test   %ecx,%ecx
    adc2:	74 47                	je     ae0b <fwp_rc_free_arr+0xdb>
    adc4:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    adcb:	eb 69                	jmp    ae36 <fwp_rc_free_arr+0x106>
    adcd:	48 89 fb             	mov    %rdi,%rbx
    add0:	48 8d 3d 65 ae 00 00 	lea    0xae65(%rip),%rdi        # 15c3c <exec_in_fp0+0x3cc>
    add7:	e8 54 82 ff ff       	call   3030 <getenv@plt>
    addc:	31 c9                	xor    %ecx,%ecx
    adde:	48 85 c0             	test   %rax,%rax
    ade1:	74 1b                	je     adfe <fwp_rc_free_arr+0xce>
    ade3:	80 38 00             	cmpb   $0x0,(%rax)
    ade6:	74 16                	je     adfe <fwp_rc_free_arr+0xce>
    ade8:	48 8d 35 c2 b9 00 00 	lea    0xb9c2(%rip),%rsi        # 167b1 <exec_in_fp0+0xf41>
    adef:	48 89 c7             	mov    %rax,%rdi
    adf2:	e8 d9 84 ff ff       	call   32d0 <strcmp@plt>
    adf7:	31 c9                	xor    %ecx,%ecx
    adf9:	85 c0                	test   %eax,%eax
    adfb:	0f 95 c1             	setne  %cl
    adfe:	89 0d 0c 0f 01 00    	mov    %ecx,0x10f0c(%rip)        # 1bd10 <fwp_reuse_verify>
    ae04:	48 89 df             	mov    %rbx,%rdi
    ae07:	85 c9                	test   %ecx,%ecx
    ae09:	75 b9                	jne    adc4 <fwp_rc_free_arr+0x94>
    ae0b:	48 8b 1d 76 f4 00 00 	mov    0xf476(%rip),%rbx        # 1a288 <fwp_gc>
    ae12:	e8 c9 fc ff ff       	call   aae0 <fwp_mem_free>
    ae17:	48 8b 05 6a f4 00 00 	mov    0xf46a(%rip),%rax        # 1a288 <fwp_gc>
    ae1e:	48 29 d8             	sub    %rbx,%rax
    ae21:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    ae26:	f2 0f 58 05 62 06 01 	addsd  0x10662(%rip),%xmm0        # 1b490 <fwp_gc+0x1208>
    ae2d:	00 
    ae2e:	f2 0f 11 05 5a 06 01 	movsd  %xmm0,0x1065a(%rip)        # 1b490 <fwp_gc+0x1208>
    ae35:	00 
    ae36:	5b                   	pop    %rbx
    ae37:	c3                   	ret
    ae38:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    ae3f:	00 

000000000000ae40 <fwp_owner_release6>:
    ae40:	48 8b 3f             	mov    (%rdi),%rdi
    ae43:	eb 0b                	jmp    ae50 <fwp_drop2>
    ae45:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    ae4c:	00 00 00 00 

000000000000ae50 <fwp_drop2>:
    ae50:	53                   	push   %rbx
    ae51:	48 89 f8             	mov    %rdi,%rax
    ae54:	48 2b 05 5d 04 01 00 	sub    0x1045d(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    ae5b:	48 8b 0d 7e 04 01 00 	mov    0x1047e(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    ae62:	48 c1 e1 10          	shl    $0x10,%rcx
    ae66:	48 39 c8             	cmp    %rcx,%rax
    ae69:	0f 83 9c 00 00 00    	jae    af0b <fwp_drop2+0xbb>
    ae6f:	48 8b 0d 8a 04 01 00 	mov    0x1048a(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    ae76:	48 89 c2             	mov    %rax,%rdx
    ae79:	48 c1 ea 10          	shr    $0x10,%rdx
    ae7d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    ae84:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    ae88:	48 25 ff ff 00 00    	and    $0xffff,%rax
    ae8e:	75 20                	jne    aeb0 <fwp_drop2+0x60>
    ae90:	40 80 fe 02          	cmp    $0x2,%sil
    ae94:	75 1a                	jne    aeb0 <fwp_drop2+0x60>
    ae96:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    ae9a:	48 05 28 02 00 00    	add    $0x228,%rax
    aea0:	eb 2d                	jmp    aecf <fwp_drop2+0x7f>
    aea2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    aea9:	1f 84 00 00 00 00 00 
    aeb0:	40 80 fe 01          	cmp    $0x1,%sil
    aeb4:	75 55                	jne    af0b <fwp_drop2+0xbb>
    aeb6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    aeba:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    aebe:	48 0f af c1          	imul   %rcx,%rax
    aec2:	48 c1 e8 20          	shr    $0x20,%rax
    aec6:	48 01 f0             	add    %rsi,%rax
    aec9:	48 05 28 02 00 00    	add    $0x228,%rax
    aecf:	0f b6 08             	movzbl (%rax),%ecx
    aed2:	85 c9                	test   %ecx,%ecx
    aed4:	74 35                	je     af0b <fwp_drop2+0xbb>
    aed6:	83 f9 01             	cmp    $0x1,%ecx
    aed9:	75 32                	jne    af0d <fwp_drop2+0xbd>
    aedb:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    aedf:	79 3a                	jns    af1b <fwp_drop2+0xcb>
    aee1:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    aee5:	e8 46 fe ff ff       	call   ad30 <fwp_rc_free_arr>
    aeea:	48 89 d8             	mov    %rbx,%rax
    aeed:	48 2b 05 c4 03 01 00 	sub    0x103c4(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    aef4:	48 8b 0d e5 03 01 00 	mov    0x103e5(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    aefb:	48 c1 e1 10          	shl    $0x10,%rcx
    aeff:	48 89 df             	mov    %rbx,%rdi
    af02:	48 39 c8             	cmp    %rcx,%rax
    af05:	0f 82 64 ff ff ff    	jb     ae6f <fwp_drop2+0x1f>
    af0b:	5b                   	pop    %rbx
    af0c:	c3                   	ret
    af0d:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    af13:	74 0c                	je     af21 <fwp_drop2+0xd1>
    af15:	fe c9                	dec    %cl
    af17:	88 08                	mov    %cl,(%rax)
    af19:	5b                   	pop    %rbx
    af1a:	c3                   	ret
    af1b:	5b                   	pop    %rbx
    af1c:	e9 0f fe ff ff       	jmp    ad30 <fwp_rc_free_arr>
    af21:	48 89 c7             	mov    %rax,%rdi
    af24:	5b                   	pop    %rbx
    af25:	e9 86 f6 ff ff       	jmp    a5b0 <fwp_rc_wide_drop>
    af2a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000af30 <fwp_owner_release7>:
    af30:	48 8b 3f             	mov    (%rdi),%rdi
    af33:	e9 18 ff ff ff       	jmp    ae50 <fwp_drop2>
    af38:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    af3f:	00 

000000000000af40 <fwp_owner_release8>:
    af40:	48 8b 3f             	mov    (%rdi),%rdi
    af43:	e9 08 ff ff ff       	jmp    ae50 <fwp_drop2>
    af48:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    af4f:	00 

000000000000af50 <fwp_owner_release9>:
    af50:	48 8b 3f             	mov    (%rdi),%rdi
    af53:	e9 f8 fe ff ff       	jmp    ae50 <fwp_drop2>
    af58:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    af5f:	00 

000000000000af60 <fwp_owned_entry5>:
    af60:	48 0f be 0f          	movsbq (%rdi),%rcx
    af64:	48 0f be 47 08       	movsbq 0x8(%rdi),%rax
    af69:	48 01 c8             	add    %rcx,%rax
    af6c:	48 0f be c8          	movsbq %al,%rcx
    af70:	48 39 c1             	cmp    %rax,%rcx
    af73:	75 01                	jne    af76 <fwp_owned_entry5+0x16>
    af75:	c3                   	ret
    af76:	53                   	push   %rbx
    af77:	48 83 ec 60          	sub    $0x60,%rsp
    af7b:	48 8d 15 d2 ac 00 00 	lea    0xacd2(%rip),%rdx        # 15c54 <exec_in_fp0+0x3e4>
    af82:	48 8d 0d c8 ac 00 00 	lea    0xacc8(%rip),%rcx        # 15c51 <exec_in_fp0+0x3e1>
    af89:	48 89 e3             	mov    %rsp,%rbx
    af8c:	be 60 00 00 00       	mov    $0x60,%esi
    af91:	48 89 df             	mov    %rbx,%rdi
    af94:	31 c0                	xor    %eax,%eax
    af96:	e8 35 82 ff ff       	call   31d0 <snprintf@plt>
    af9b:	e8 20 bc ff ff       	call   6bc0 <fwp_flush>
    afa0:	48 8b 05 31 f0 00 00 	mov    0xf031(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    afa7:	48 8b 38             	mov    (%rax),%rdi
    afaa:	48 8d 35 d9 aa 00 00 	lea    0xaad9(%rip),%rsi        # 15a8a <exec_in_fp0+0x21a>
    afb1:	48 89 da             	mov    %rbx,%rdx
    afb4:	31 c0                	xor    %eax,%eax
    afb6:	e8 35 83 ff ff       	call   32f0 <fprintf@plt>
    afbb:	bf 65 00 00 00       	mov    $0x65,%edi
    afc0:	e8 9b 84 ff ff       	call   3460 <exit@plt>
    afc5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    afcc:	00 00 00 00 

000000000000afd0 <fwp_caps5>:
    afd0:	85 f6                	test   %esi,%esi
    afd2:	0f 84 28 f9 ff ff    	je     a900 <fwp_rc_free_obj>
    afd8:	c3                   	ret
    afd9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000afe0 <fwp_args5>:
    afe0:	c3                   	ret
    afe1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    afe8:	0f 1f 84 00 00 00 00 
    afef:	00 

000000000000aff0 <fwp_owned_entry12>:
    aff0:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    aff4:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    aff9:	0f 59 c8             	mulps  %xmm0,%xmm1
    affc:	66 0f 7e c8          	movd   %xmm1,%eax
    b000:	c3                   	ret
    b001:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b008:	0f 1f 84 00 00 00 00 
    b00f:	00 

000000000000b010 <fwp_caps12>:
    b010:	85 f6                	test   %esi,%esi
    b012:	0f 84 e8 f8 ff ff    	je     a900 <fwp_rc_free_obj>
    b018:	c3                   	ret
    b019:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000b020 <fwp_args12>:
    b020:	c3                   	ret
    b021:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b028:	0f 1f 84 00 00 00 00 
    b02f:	00 

000000000000b030 <fwp_owned_entry13>:
    b030:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    b034:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    b039:	0f 58 c8             	addps  %xmm0,%xmm1
    b03c:	66 0f 7e c8          	movd   %xmm1,%eax
    b040:	c3                   	ret
    b041:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b048:	0f 1f 84 00 00 00 00 
    b04f:	00 

000000000000b050 <fwp_caps13>:
    b050:	85 f6                	test   %esi,%esi
    b052:	0f 84 a8 f8 ff ff    	je     a900 <fwp_rc_free_obj>
    b058:	c3                   	ret
    b059:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000b060 <fwp_args13>:
    b060:	c3                   	ret
    b061:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b068:	0f 1f 84 00 00 00 00 
    b06f:	00 

000000000000b070 <fwp_owned_entry20>:
    b070:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    b074:	f2 0f 59 47 08       	mulsd  0x8(%rdi),%xmm0
    b079:	66 48 0f 7e c0       	movq   %xmm0,%rax
    b07e:	c3                   	ret
    b07f:	90                   	nop

000000000000b080 <fwp_caps20>:
    b080:	85 f6                	test   %esi,%esi
    b082:	0f 84 78 f8 ff ff    	je     a900 <fwp_rc_free_obj>
    b088:	c3                   	ret
    b089:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000b090 <fwp_args20>:
    b090:	c3                   	ret
    b091:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b098:	0f 1f 84 00 00 00 00 
    b09f:	00 

000000000000b0a0 <fwp_owned_entry21>:
    b0a0:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    b0a4:	f2 0f 58 47 08       	addsd  0x8(%rdi),%xmm0
    b0a9:	66 48 0f 7e c0       	movq   %xmm0,%rax
    b0ae:	c3                   	ret
    b0af:	90                   	nop

000000000000b0b0 <fwp_caps21>:
    b0b0:	85 f6                	test   %esi,%esi
    b0b2:	0f 84 48 f8 ff ff    	je     a900 <fwp_rc_free_obj>
    b0b8:	c3                   	ret
    b0b9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000b0c0 <fwp_args21>:
    b0c0:	c3                   	ret
    b0c1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b0c8:	0f 1f 84 00 00 00 00 
    b0cf:	00 

000000000000b0d0 <fwp_segv>:
    b0d0:	48 8b 05 01 0e 01 00 	mov    0x10e01(%rip),%rax        # 1bed8 <fwp_main_stack_top>
    b0d7:	48 85 c0             	test   %rax,%rax
    b0da:	74 22                	je     b0fe <fwp_segv+0x2e>
    b0dc:	48 8b 4e 10          	mov    0x10(%rsi),%rcx
    b0e0:	48 2b 05 f9 0d 01 00 	sub    0x10df9(%rip),%rax        # 1bee0 <fwp_main_stack_size>
    b0e7:	48 8d 90 00 00 f0 ff 	lea    -0x100000(%rax),%rdx
    b0ee:	48 39 ca             	cmp    %rcx,%rdx
    b0f1:	77 0b                	ja     b0fe <fwp_segv+0x2e>
    b0f3:	48 05 00 00 10 00    	add    $0x100000,%rax
    b0f9:	48 39 c8             	cmp    %rcx,%rax
    b0fc:	77 07                	ja     b105 <fwp_segv+0x35>
    b0fe:	31 f6                	xor    %esi,%esi
    b100:	e9 db 81 ff ff       	jmp    32e0 <signal@plt>
    b105:	50                   	push   %rax
    b106:	e8 b5 ba ff ff       	call   6bc0 <fwp_flush>
    b10b:	48 8d 35 0e a7 00 00 	lea    0xa70e(%rip),%rsi        # 15820 <fwp_segv.msg>
    b112:	ba 1a 00 00 00       	mov    $0x1a,%edx
    b117:	bf 02 00 00 00       	mov    $0x2,%edi
    b11c:	e8 1f 80 ff ff       	call   3140 <write@plt>
    b121:	bf 65 00 00 00       	mov    $0x65,%edi
    b126:	e8 75 7f ff ff       	call   30a0 <_exit@plt>
    b12b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000b130 <fwp_str_lossy>:
    b130:	55                   	push   %rbp
    b131:	41 57                	push   %r15
    b133:	41 56                	push   %r14
    b135:	41 55                	push   %r13
    b137:	41 54                	push   %r12
    b139:	53                   	push   %rbx
    b13a:	48 83 ec 28          	sub    $0x28,%rsp
    b13e:	49 89 f6             	mov    %rsi,%r14
    b141:	48 89 fb             	mov    %rdi,%rbx
    b144:	48 85 f6             	test   %rsi,%rsi
    b147:	0f 84 47 01 00 00    	je     b294 <fwp_str_lossy+0x164>
    b14d:	31 c0                	xor    %eax,%eax
    b14f:	eb 1b                	jmp    b16c <fwp_str_lossy+0x3c>
    b151:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b158:	0f 1f 84 00 00 00 00 
    b15f:	00 
    b160:	48 ff c0             	inc    %rax
    b163:	4c 39 f0             	cmp    %r14,%rax
    b166:	0f 83 28 01 00 00    	jae    b294 <fwp_str_lossy+0x164>
    b16c:	0f b6 3c 03          	movzbl (%rbx,%rax,1),%edi
    b170:	40 84 ff             	test   %dil,%dil
    b173:	79 eb                	jns    b160 <fwp_str_lossy+0x30>
    b175:	8d 4f 3e             	lea    0x3e(%rdi),%ecx
    b178:	80 f9 1e             	cmp    $0x1e,%cl
    b17b:	73 11                	jae    b18e <fwp_str_lossy+0x5e>
    b17d:	b9 80 00 00 00       	mov    $0x80,%ecx
    b182:	be 01 00 00 00       	mov    $0x1,%esi
    b187:	ba 1f 00 00 00       	mov    $0x1f,%edx
    b18c:	eb 36                	jmp    b1c4 <fwp_str_lossy+0x94>
    b18e:	89 f9                	mov    %edi,%ecx
    b190:	80 e1 f0             	and    $0xf0,%cl
    b193:	80 f9 e0             	cmp    $0xe0,%cl
    b196:	75 11                	jne    b1a9 <fwp_str_lossy+0x79>
    b198:	b9 00 08 00 00       	mov    $0x800,%ecx
    b19d:	be 02 00 00 00       	mov    $0x2,%esi
    b1a2:	ba 0f 00 00 00       	mov    $0xf,%edx
    b1a7:	eb 1b                	jmp    b1c4 <fwp_str_lossy+0x94>
    b1a9:	8d 4f 10             	lea    0x10(%rdi),%ecx
    b1ac:	80 f9 04             	cmp    $0x4,%cl
    b1af:	0f 87 52 01 00 00    	ja     b307 <fwp_str_lossy+0x1d7>
    b1b5:	b9 00 00 01 00       	mov    $0x10000,%ecx
    b1ba:	be 03 00 00 00       	mov    $0x3,%esi
    b1bf:	ba 07 00 00 00       	mov    $0x7,%edx
    b1c4:	89 f6                	mov    %esi,%esi
    b1c6:	4c 8d 04 30          	lea    (%rax,%rsi,1),%r8
    b1ca:	4d 39 f0             	cmp    %r14,%r8
    b1cd:	0f 83 34 01 00 00    	jae    b307 <fwp_str_lossy+0x1d7>
    b1d3:	44 0f b6 44 03 01    	movzbl 0x1(%rbx,%rax,1),%r8d
    b1d9:	45 89 c1             	mov    %r8d,%r9d
    b1dc:	41 83 e1 c0          	and    $0xffffffc0,%r9d
    b1e0:	41 81 f9 80 00 00 00 	cmp    $0x80,%r9d
    b1e7:	0f 85 1a 01 00 00    	jne    b307 <fwp_str_lossy+0x1d7>
    b1ed:	21 fa                	and    %edi,%edx
    b1ef:	8d 7e 01             	lea    0x1(%rsi),%edi
    b1f2:	41 89 d1             	mov    %edx,%r9d
    b1f5:	41 c1 e1 06          	shl    $0x6,%r9d
    b1f9:	41 83 e0 3f          	and    $0x3f,%r8d
    b1fd:	45 09 c8             	or     %r9d,%r8d
    b200:	83 ff 02             	cmp    $0x2,%edi
    b203:	75 05                	jne    b20a <fwp_str_lossy+0xda>
    b205:	44 89 c7             	mov    %r8d,%edi
    b208:	eb 58                	jmp    b262 <fwp_str_lossy+0x132>
    b20a:	0f b6 54 03 02       	movzbl 0x2(%rbx,%rax,1),%edx
    b20f:	41 89 d1             	mov    %edx,%r9d
    b212:	41 83 e1 c0          	and    $0xffffffc0,%r9d
    b216:	41 81 f9 80 00 00 00 	cmp    $0x80,%r9d
    b21d:	0f 85 e4 00 00 00    	jne    b307 <fwp_str_lossy+0x1d7>
    b223:	45 89 c1             	mov    %r8d,%r9d
    b226:	41 c1 e1 06          	shl    $0x6,%r9d
    b22a:	83 e2 3f             	and    $0x3f,%edx
    b22d:	44 09 ca             	or     %r9d,%edx
    b230:	83 ff 03             	cmp    $0x3,%edi
    b233:	75 07                	jne    b23c <fwp_str_lossy+0x10c>
    b235:	89 d7                	mov    %edx,%edi
    b237:	44 89 c2             	mov    %r8d,%edx
    b23a:	eb 26                	jmp    b262 <fwp_str_lossy+0x132>
    b23c:	0f b6 7c 03 03       	movzbl 0x3(%rbx,%rax,1),%edi
    b241:	41 89 f8             	mov    %edi,%r8d
    b244:	41 83 e0 c0          	and    $0xffffffc0,%r8d
    b248:	41 81 f8 80 00 00 00 	cmp    $0x80,%r8d
    b24f:	0f 85 b2 00 00 00    	jne    b307 <fwp_str_lossy+0x1d7>
    b255:	41 89 d0             	mov    %edx,%r8d
    b258:	41 c1 e0 06          	shl    $0x6,%r8d
    b25c:	83 e7 3f             	and    $0x3f,%edi
    b25f:	44 09 c7             	or     %r8d,%edi
    b262:	83 e2 e0             	and    $0xffffffe0,%edx
    b265:	81 fa 60 03 00 00    	cmp    $0x360,%edx
    b26b:	0f 84 96 00 00 00    	je     b307 <fwp_str_lossy+0x1d7>
    b271:	39 cf                	cmp    %ecx,%edi
    b273:	0f 82 8e 00 00 00    	jb     b307 <fwp_str_lossy+0x1d7>
    b279:	81 ff ff ff 10 00    	cmp    $0x10ffff,%edi
    b27f:	0f 87 82 00 00 00    	ja     b307 <fwp_str_lossy+0x1d7>
    b285:	48 01 f0             	add    %rsi,%rax
    b288:	48 ff c0             	inc    %rax
    b28b:	4c 39 f0             	cmp    %r14,%rax
    b28e:	0f 82 d8 fe ff ff    	jb     b16c <fwp_str_lossy+0x3c>
    b294:	49 8d 56 09          	lea    0x9(%r14),%rdx
    b298:	48 ff 05 09 0c 01 00 	incq   0x10c09(%rip)        # 1bea8 <measured_calls>
    b29f:	48 01 15 0a 0c 01 00 	add    %rdx,0x10c0a(%rip)        # 1beb0 <measured_bytes>
    b2a6:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    b2ad:	0f 87 01 02 00 00    	ja     b4b4 <fwp_str_lossy+0x384>
    b2b3:	49 8d 4e 18          	lea    0x18(%r14),%rcx
    b2b7:	48 c1 e9 04          	shr    $0x4,%rcx
    b2bb:	48 8d 05 c6 ef 00 00 	lea    0xefc6(%rip),%rax        # 1a288 <fwp_gc>
    b2c2:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    b2c9:	00 
    b2ca:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    b2d1:	48 29 0d b0 ef 00 00 	sub    %rcx,0xefb0(%rip)        # 1a288 <fwp_gc>
    b2d8:	0f 88 d6 01 00 00    	js     b4b4 <fwp_str_lossy+0x384>
    b2de:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    b2e2:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    b2e6:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    b2ed:	4c 8b 3f             	mov    (%rdi),%r15
    b2f0:	4d 85 ff             	test   %r15,%r15
    b2f3:	0f 84 a3 01 00 00    	je     b49c <fwp_str_lossy+0x36c>
    b2f9:	49 8b 07             	mov    (%r15),%rax
    b2fc:	48 f7 d0             	not    %rax
    b2ff:	48 89 07             	mov    %rax,(%rdi)
    b302:	e9 cf 01 00 00       	jmp    b4d6 <fwp_str_lossy+0x3a6>
    b307:	0f 57 c0             	xorps  %xmm0,%xmm0
    b30a:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    b30f:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    b316:	00 00 
    b318:	31 ed                	xor    %ebp,%ebp
    b31a:	4c 8d 7c 24 10       	lea    0x10(%rsp),%r15
    b31f:	4c 8d 64 24 0f       	lea    0xf(%rsp),%r12
    b324:	eb 30                	jmp    b356 <fwp_str_lossy+0x226>
    b326:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    b32d:	00 00 00 
    b330:	88 44 24 0f          	mov    %al,0xf(%rsp)
    b334:	ba 01 00 00 00       	mov    $0x1,%edx
    b339:	4c 89 ff             	mov    %r15,%rdi
    b33c:	4c 89 e6             	mov    %r12,%rsi
    b33f:	e8 8c 1e 00 00       	call   d1d0 <buf_put>
    b344:	48 ff c5             	inc    %rbp
    b347:	49 89 ed             	mov    %rbp,%r13
    b34a:	4c 89 ed             	mov    %r13,%rbp
    b34d:	4d 39 f5             	cmp    %r14,%r13
    b350:	0f 83 37 01 00 00    	jae    b48d <fwp_str_lossy+0x35d>
    b356:	0f b6 04 2b          	movzbl (%rbx,%rbp,1),%eax
    b35a:	84 c0                	test   %al,%al
    b35c:	79 d2                	jns    b330 <fwp_str_lossy+0x200>
    b35e:	8d 48 20             	lea    0x20(%rax),%ecx
    b361:	80 f9 e1             	cmp    $0xe1,%cl
    b364:	77 34                	ja     b39a <fwp_str_lossy+0x26a>
    b366:	89 c2                	mov    %eax,%edx
    b368:	80 e2 f0             	and    $0xf0,%dl
    b36b:	80 fa e0             	cmp    $0xe0,%dl
    b36e:	0f 85 d5 00 00 00    	jne    b449 <fwp_str_lossy+0x319>
    b374:	3c e0                	cmp    $0xe0,%al
    b376:	40 0f 94 c6          	sete   %sil
    b37a:	40 c0 e6 05          	shl    $0x5,%sil
    b37e:	40 80 ce 80          	or     $0x80,%sil
    b382:	31 ff                	xor    %edi,%edi
    b384:	3c ed                	cmp    $0xed,%al
    b386:	40 0f 95 c7          	setne  %dil
    b38a:	c1 e7 05             	shl    $0x5,%edi
    b38d:	81 cf 9f 00 00 00    	or     $0x9f,%edi
    b393:	b8 02 00 00 00       	mov    $0x2,%eax
    b398:	eb 0d                	jmp    b3a7 <fwp_str_lossy+0x277>
    b39a:	bf bf 00 00 00       	mov    $0xbf,%edi
    b39f:	40 b6 80             	mov    $0x80,%sil
    b3a2:	b8 01 00 00 00       	mov    $0x1,%eax
    b3a7:	31 d2                	xor    %edx,%edx
    b3a9:	4c 8d 6d 01          	lea    0x1(%rbp),%r13
    b3ad:	4d 39 f5             	cmp    %r14,%r13
    b3b0:	73 7e                	jae    b430 <fwp_str_lossy+0x300>
    b3b2:	46 0f b6 04 2b       	movzbl (%rbx,%r13,1),%r8d
    b3b7:	41 38 f0             	cmp    %sil,%r8b
    b3ba:	72 74                	jb     b430 <fwp_str_lossy+0x300>
    b3bc:	44 39 c7             	cmp    %r8d,%edi
    b3bf:	72 6f                	jb     b430 <fwp_str_lossy+0x300>
    b3c1:	4c 8d 6d 02          	lea    0x2(%rbp),%r13
    b3c5:	be 01 00 00 00       	mov    $0x1,%esi
    b3ca:	80 f9 e1             	cmp    $0xe1,%cl
    b3cd:	77 44                	ja     b413 <fwp_str_lossy+0x2e3>
    b3cf:	4d 39 f5             	cmp    %r14,%r13
    b3d2:	73 3f                	jae    b413 <fwp_str_lossy+0x2e3>
    b3d4:	42 0f b6 0c 2b       	movzbl (%rbx,%r13,1),%ecx
    b3d9:	80 e1 c0             	and    $0xc0,%cl
    b3dc:	80 f9 80             	cmp    $0x80,%cl
    b3df:	75 32                	jne    b413 <fwp_str_lossy+0x2e3>
    b3e1:	4c 8d 6d 03          	lea    0x3(%rbp),%r13
    b3e5:	4d 39 f5             	cmp    %r14,%r13
    b3e8:	0f 93 c1             	setae  %cl
    b3eb:	80 f2 01             	xor    $0x1,%dl
    b3ee:	be 02 00 00 00       	mov    $0x2,%esi
    b3f3:	08 ca                	or     %cl,%dl
    b3f5:	75 1c                	jne    b413 <fwp_str_lossy+0x2e3>
    b3f7:	0f b6 4c 2b 03       	movzbl 0x3(%rbx,%rbp,1),%ecx
    b3fc:	80 e1 c0             	and    $0xc0,%cl
    b3ff:	31 f6                	xor    %esi,%esi
    b401:	80 f9 80             	cmp    $0x80,%cl
    b404:	0f 94 c1             	sete   %cl
    b407:	75 04                	jne    b40d <fwp_str_lossy+0x2dd>
    b409:	4c 8d 6d 04          	lea    0x4(%rbp),%r13
    b40d:	40 88 ce             	mov    %cl,%sil
    b410:	83 ce 02             	or     $0x2,%esi
    b413:	39 c6                	cmp    %eax,%esi
    b415:	75 19                	jne    b430 <fwp_str_lossy+0x300>
    b417:	48 8d 34 2b          	lea    (%rbx,%rbp,1),%rsi
    b41b:	4c 89 ea             	mov    %r13,%rdx
    b41e:	48 29 ea             	sub    %rbp,%rdx
    b421:	4c 89 ff             	mov    %r15,%rdi
    b424:	eb 19                	jmp    b43f <fwp_str_lossy+0x30f>
    b426:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    b42d:	00 00 00 
    b430:	ba 03 00 00 00       	mov    $0x3,%edx
    b435:	4c 89 ff             	mov    %r15,%rdi
    b438:	48 8d 35 28 b2 00 00 	lea    0xb228(%rip),%rsi        # 16667 <exec_in_fp0+0xdf7>
    b43f:	e8 8c 1d 00 00       	call   d1d0 <buf_put>
    b444:	e9 01 ff ff ff       	jmp    b34a <fwp_str_lossy+0x21a>
    b449:	8d 50 10             	lea    0x10(%rax),%edx
    b44c:	80 fa 04             	cmp    $0x4,%dl
    b44f:	77 28                	ja     b479 <fwp_str_lossy+0x349>
    b451:	3c f0                	cmp    $0xf0,%al
    b453:	40 0f 94 c6          	sete   %sil
    b457:	bf 8f 00 00 00       	mov    $0x8f,%edi
    b45c:	3c f4                	cmp    $0xf4,%al
    b45e:	74 05                	je     b465 <fwp_str_lossy+0x335>
    b460:	bf bf 00 00 00       	mov    $0xbf,%edi
    b465:	40 c0 e6 04          	shl    $0x4,%sil
    b469:	40 80 ce 80          	or     $0x80,%sil
    b46d:	b8 03 00 00 00       	mov    $0x3,%eax
    b472:	b2 01                	mov    $0x1,%dl
    b474:	e9 30 ff ff ff       	jmp    b3a9 <fwp_str_lossy+0x279>
    b479:	ba 03 00 00 00       	mov    $0x3,%edx
    b47e:	4c 89 ff             	mov    %r15,%rdi
    b481:	48 8d 35 df b1 00 00 	lea    0xb1df(%rip),%rsi        # 16667 <exec_in_fp0+0xdf7>
    b488:	e9 b2 fe ff ff       	jmp    b33f <fwp_str_lossy+0x20f>
    b48d:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    b492:	e8 29 1e 00 00       	call   d2c0 <buf_to_str>
    b497:	49 89 c7             	mov    %rax,%r15
    b49a:	eb 5c                	jmp    b4f8 <fwp_str_lossy+0x3c8>
    b49c:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    b4a3:	00 
    b4a4:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    b4ab:	00 
    b4ac:	4c 29 ff             	sub    %r15,%rdi
    b4af:	48 39 cf             	cmp    %rcx,%rdi
    b4b2:	73 12                	jae    b4c6 <fwp_str_lossy+0x396>
    b4b4:	48 89 d7             	mov    %rdx,%rdi
    b4b7:	be 01 00 00 00       	mov    $0x1,%esi
    b4bc:	e8 bf cd ff ff       	call   8280 <fwp_gc_alloc_slow>
    b4c1:	49 89 c7             	mov    %rax,%r15
    b4c4:	eb 1a                	jmp    b4e0 <fwp_str_lossy+0x3b0>
    b4c6:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    b4ca:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    b4d0:	4c 01 f9             	add    %r15,%rcx
    b4d3:	48 89 08             	mov    %rcx,(%rax)
    b4d6:	4c 89 ff             	mov    %r15,%rdi
    b4d9:	31 f6                	xor    %esi,%esi
    b4db:	e8 30 7d ff ff       	call   3210 <memset@plt>
    b4e0:	4d 89 37             	mov    %r14,(%r15)
    b4e3:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    b4e7:	48 89 de             	mov    %rbx,%rsi
    b4ea:	4c 89 f2             	mov    %r14,%rdx
    b4ed:	e8 3e 7e ff ff       	call   3330 <memcpy@plt>
    b4f2:	43 c6 44 37 08 00    	movb   $0x0,0x8(%r15,%r14,1)
    b4f8:	4c 89 f8             	mov    %r15,%rax
    b4fb:	48 83 c4 28          	add    $0x28,%rsp
    b4ff:	5b                   	pop    %rbx
    b500:	41 5c                	pop    %r12
    b502:	41 5d                	pop    %r13
    b504:	41 5e                	pop    %r14
    b506:	41 5f                	pop    %r15
    b508:	5d                   	pop    %rbp
    b509:	c3                   	ret
    b50a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000b510 <fwp_alloc_leaf>:
    b510:	53                   	push   %rbx
    b511:	48 89 fa             	mov    %rdi,%rdx
    b514:	48 ff 05 8d 09 01 00 	incq   0x1098d(%rip)        # 1bea8 <measured_calls>
    b51b:	48 01 3d 8e 09 01 00 	add    %rdi,0x1098e(%rip)        # 1beb0 <measured_bytes>
    b522:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    b529:	77 61                	ja     b58c <fwp_alloc_leaf+0x7c>
    b52b:	48 8d 4a 0f          	lea    0xf(%rdx),%rcx
    b52f:	48 c1 e9 04          	shr    $0x4,%rcx
    b533:	48 8d 05 4e ed 00 00 	lea    0xed4e(%rip),%rax        # 1a288 <fwp_gc>
    b53a:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    b541:	00 
    b542:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    b549:	48 29 0d 38 ed 00 00 	sub    %rcx,0xed38(%rip)        # 1a288 <fwp_gc>
    b550:	78 3a                	js     b58c <fwp_alloc_leaf+0x7c>
    b552:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    b556:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    b55a:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    b561:	48 8b 1f             	mov    (%rdi),%rbx
    b564:	48 85 db             	test   %rbx,%rbx
    b567:	74 0b                	je     b574 <fwp_alloc_leaf+0x64>
    b569:	48 8b 03             	mov    (%rbx),%rax
    b56c:	48 f7 d0             	not    %rax
    b56f:	48 89 07             	mov    %rax,(%rdi)
    b572:	eb 36                	jmp    b5aa <fwp_alloc_leaf+0x9a>
    b574:	48 8b 9c f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%rbx
    b57b:	00 
    b57c:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    b583:	00 
    b584:	48 29 df             	sub    %rbx,%rdi
    b587:	48 39 cf             	cmp    %rcx,%rdi
    b58a:	73 0e                	jae    b59a <fwp_alloc_leaf+0x8a>
    b58c:	48 89 d7             	mov    %rdx,%rdi
    b58f:	be 01 00 00 00       	mov    $0x1,%esi
    b594:	5b                   	pop    %rbx
    b595:	e9 e6 cc ff ff       	jmp    8280 <fwp_gc_alloc_slow>
    b59a:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    b59e:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    b5a4:	48 01 d9             	add    %rbx,%rcx
    b5a7:	48 89 08             	mov    %rcx,(%rax)
    b5aa:	48 89 df             	mov    %rbx,%rdi
    b5ad:	31 f6                	xor    %esi,%esi
    b5af:	e8 5c 7c ff ff       	call   3210 <memset@plt>
    b5b4:	48 89 d8             	mov    %rbx,%rax
    b5b7:	5b                   	pop    %rbx
    b5b8:	c3                   	ret
    b5b9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000b5c0 <fwp_pipe_write>:
    b5c0:	55                   	push   %rbp
    b5c1:	41 57                	push   %r15
    b5c3:	41 56                	push   %r14
    b5c5:	41 55                	push   %r13
    b5c7:	41 54                	push   %r12
    b5c9:	53                   	push   %rbx
    b5ca:	48 83 ec 48          	sub    $0x48,%rsp
    b5ce:	48 89 f3             	mov    %rsi,%rbx
    b5d1:	49 89 fe             	mov    %rdi,%r14
    b5d4:	8b 05 36 09 02 00    	mov    0x20936(%rip),%eax        # 2bf10 <fwp_po_kind>
    b5da:	83 f8 01             	cmp    $0x1,%eax
    b5dd:	0f 84 cc 02 00 00    	je     b8af <fwp_pipe_write+0x2ef>
    b5e3:	83 f8 02             	cmp    $0x2,%eax
    b5e6:	0f 85 4e 03 00 00    	jne    b93a <fwp_pipe_write+0x37a>
    b5ec:	48 85 db             	test   %rbx,%rbx
    b5ef:	0f 84 0d 04 00 00    	je     ba02 <fwp_pipe_write+0x442>
    b5f5:	f6 05 2c 09 03 00 01 	testb  $0x1,0x3092c(%rip)        # 3bf28 <fwp_po_gone>
    b5fc:	0f 85 00 04 00 00    	jne    ba02 <fwp_pipe_write+0x442>
    b602:	4c 8b 2d 17 09 03 00 	mov    0x30917(%rip),%r13        # 3bf20 <fwp_po_ring>
    b609:	49 8d 85 00 10 00 00 	lea    0x1000(%r13),%rax
    b610:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    b615:	49 8d 85 c0 00 00 00 	lea    0xc0(%r13),%rax
    b61c:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    b621:	49 8d 85 00 01 00 00 	lea    0x100(%r13),%rax
    b628:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    b62d:	0f 1f 00             	nopl   (%rax)
    b630:	49 8b 6d 40          	mov    0x40(%r13),%rbp
    b634:	4d 8b bd 80 00 00 00 	mov    0x80(%r13),%r15
    b63b:	4d 8b 65 08          	mov    0x8(%r13),%r12
    b63f:	49 29 ef             	sub    %rbp,%r15
    b642:	4d 01 e7             	add    %r12,%r15
    b645:	0f 84 b5 00 00 00    	je     b700 <fwp_pipe_write+0x140>
    b64b:	4c 39 fb             	cmp    %r15,%rbx
    b64e:	48 89 5c 24 38       	mov    %rbx,0x38(%rsp)
    b653:	4c 0f 42 fb          	cmovb  %rbx,%r15
    b657:	49 8d 7c 24 ff       	lea    -0x1(%r12),%rdi
    b65c:	48 21 ef             	and    %rbp,%rdi
    b65f:	49 29 fc             	sub    %rdi,%r12
    b662:	4d 39 e7             	cmp    %r12,%r15
    b665:	4d 0f 42 e7          	cmovb  %r15,%r12
    b669:	48 8b 5c 24 28       	mov    0x28(%rsp),%rbx
    b66e:	48 01 df             	add    %rbx,%rdi
    b671:	4c 89 f6             	mov    %r14,%rsi
    b674:	4c 89 e2             	mov    %r12,%rdx
    b677:	e8 b4 7c ff ff       	call   3330 <memcpy@plt>
    b67c:	4c 89 74 24 40       	mov    %r14,0x40(%rsp)
    b681:	4b 8d 34 26          	lea    (%r14,%r12,1),%rsi
    b685:	4c 89 fa             	mov    %r15,%rdx
    b688:	4c 29 e2             	sub    %r12,%rdx
    b68b:	48 89 df             	mov    %rbx,%rdi
    b68e:	e8 9d 7c ff ff       	call   3330 <memcpy@plt>
    b693:	4c 01 fd             	add    %r15,%rbp
    b696:	49 89 6d 40          	mov    %rbp,0x40(%r13)
    b69a:	0f ae f0             	mfence
    b69d:	41 8b 85 c4 00 00 00 	mov    0xc4(%r13),%eax
    b6a4:	85 c0                	test   %eax,%eax
    b6a6:	74 2b                	je     b6d3 <fwp_pipe_write+0x113>
    b6a8:	48 8b 74 24 20       	mov    0x20(%rsp),%rsi
    b6ad:	f0 ff 06             	lock incl (%rsi)
    b6b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    b6b7:	bf ca 00 00 00       	mov    $0xca,%edi
    b6bc:	ba 01 00 00 00       	mov    $0x1,%edx
    b6c1:	b9 ff ff ff 7f       	mov    $0x7fffffff,%ecx
    b6c6:	45 31 c0             	xor    %r8d,%r8d
    b6c9:	45 31 c9             	xor    %r9d,%r9d
    b6cc:	31 c0                	xor    %eax,%eax
    b6ce:	e8 2d 7c ff ff       	call   3300 <syscall@plt>
    b6d3:	4c 8b 74 24 40       	mov    0x40(%rsp),%r14
    b6d8:	4d 01 fe             	add    %r15,%r14
    b6db:	48 8b 5c 24 38       	mov    0x38(%rsp),%rbx
    b6e0:	4c 29 fb             	sub    %r15,%rbx
    b6e3:	48 85 db             	test   %rbx,%rbx
    b6e6:	0f 84 16 03 00 00    	je     ba02 <fwp_pipe_write+0x442>
    b6ec:	f6 05 35 08 03 00 01 	testb  $0x1,0x30835(%rip)        # 3bf28 <fwp_po_gone>
    b6f3:	0f 84 37 ff ff ff    	je     b630 <fwp_pipe_write+0x70>
    b6f9:	e9 04 03 00 00       	jmp    ba02 <fwp_pipe_write+0x442>
    b6fe:	66 90                	xchg   %ax,%ax
    b700:	44 8b 25 dd 06 01 00 	mov    0x106dd(%rip),%r12d        # 1bde4 <fwp_po_sock>
    b707:	8b 0d db 06 01 00    	mov    0x106db(%rip),%ecx        # 1bde8 <fwp_ring_spin>
    b70d:	85 c9                	test   %ecx,%ecx
    b70f:	78 09                	js     b71a <fwp_pipe_write+0x15a>
    b711:	85 c9                	test   %ecx,%ecx
    b713:	75 22                	jne    b737 <fwp_pipe_write+0x177>
    b715:	e9 96 00 00 00       	jmp    b7b0 <fwp_pipe_write+0x1f0>
    b71a:	bf 54 00 00 00       	mov    $0x54,%edi
    b71f:	e8 fc 7c ff ff       	call   3420 <sysconf@plt>
    b724:	31 c9                	xor    %ecx,%ecx
    b726:	48 83 f8 02          	cmp    $0x2,%rax
    b72a:	0f 9d c1             	setge  %cl
    b72d:	89 0d b5 06 01 00    	mov    %ecx,0x106b5(%rip)        # 1bde8 <fwp_ring_spin>
    b733:	85 c9                	test   %ecx,%ecx
    b735:	74 79                	je     b7b0 <fwp_pipe_write+0x1f0>
    b737:	49 8b 85 80 00 00 00 	mov    0x80(%r13),%rax
    b73e:	49 2b 45 40          	sub    0x40(%r13),%rax
    b742:	49 03 45 08          	add    0x8(%r13),%rax
    b746:	75 9b                	jne    b6e3 <fwp_pipe_write+0x123>
    b748:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    b74e:	31 ed                	xor    %ebp,%ebp
    b750:	eb 26                	jmp    b778 <fwp_pipe_write+0x1b8>
    b752:	48 05 50 c3 00 00    	add    $0xc350,%rax
    b758:	48 89 c5             	mov    %rax,%rbp
    b75b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    b760:	41 ff c7             	inc    %r15d
    b763:	49 8b 85 80 00 00 00 	mov    0x80(%r13),%rax
    b76a:	49 2b 45 40          	sub    0x40(%r13),%rax
    b76e:	49 03 45 08          	add    0x8(%r13),%rax
    b772:	0f 85 6b ff ff ff    	jne    b6e3 <fwp_pipe_write+0x123>
    b778:	f3 90                	pause
    b77a:	41 f6 c7 3f          	test   $0x3f,%r15b
    b77e:	75 e0                	jne    b760 <fwp_pipe_write+0x1a0>
    b780:	e8 cb 7a ff ff       	call   3250 <sched_yield@plt>
    b785:	bf 01 00 00 00       	mov    $0x1,%edi
    b78a:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    b78f:	e8 9c 79 ff ff       	call   3130 <clock_gettime@plt>
    b794:	48 69 44 24 10 00 ca 	imul   $0x3b9aca00,0x10(%rsp),%rax
    b79b:	9a 3b 
    b79d:	48 03 44 24 18       	add    0x18(%rsp),%rax
    b7a2:	48 85 ed             	test   %rbp,%rbp
    b7a5:	74 ab                	je     b752 <fwp_pipe_write+0x192>
    b7a7:	48 39 e8             	cmp    %rbp,%rax
    b7aa:	7e b4                	jle    b760 <fwp_pipe_write+0x1a0>
    b7ac:	0f 1f 40 00          	nopl   0x0(%rax)
    b7b0:	41 8b 8d 00 01 00 00 	mov    0x100(%r13),%ecx
    b7b7:	b8 01 00 00 00       	mov    $0x1,%eax
    b7bc:	41 87 85 04 01 00 00 	xchg   %eax,0x104(%r13)
    b7c3:	0f ae f0             	mfence
    b7c6:	49 8b 85 80 00 00 00 	mov    0x80(%r13),%rax
    b7cd:	49 2b 45 40          	sub    0x40(%r13),%rax
    b7d1:	49 03 45 08          	add    0x8(%r13),%rax
    b7d5:	0f 85 c4 00 00 00    	jne    b89f <fwp_pipe_write+0x2df>
    b7db:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    b7e2:	00 00 
    b7e4:	48 c7 44 24 18 00 e1 	movq   $0x5f5e100,0x18(%rsp)
    b7eb:	f5 05 
    b7ed:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    b7f4:	bf ca 00 00 00       	mov    $0xca,%edi
    b7f9:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    b7fe:	31 d2                	xor    %edx,%edx
    b800:	4c 8d 44 24 10       	lea    0x10(%rsp),%r8
    b805:	45 31 c9             	xor    %r9d,%r9d
    b808:	31 c0                	xor    %eax,%eax
    b80a:	e8 f1 7a ff ff       	call   3300 <syscall@plt>
    b80f:	41 c7 85 04 01 00 00 	movl   $0x0,0x104(%r13)
    b816:	00 00 00 00 
    b81a:	49 8b 8d 80 00 00 00 	mov    0x80(%r13),%rcx
    b821:	49 2b 4d 40          	sub    0x40(%r13),%rcx
    b825:	49 03 4d 08          	add    0x8(%r13),%rcx
    b829:	0f 85 b4 fe ff ff    	jne    b6e3 <fwp_pipe_write+0x123>
    b82f:	48 85 c0             	test   %rax,%rax
    b832:	0f 84 78 ff ff ff    	je     b7b0 <fwp_pipe_write+0x1f0>
    b838:	e8 43 78 ff ff       	call   3080 <__errno_location@plt>
    b83d:	83 38 6e             	cmpl   $0x6e,(%rax)
    b840:	0f 85 6a ff ff ff    	jne    b7b0 <fwp_pipe_write+0x1f0>
    b846:	44 89 64 24 10       	mov    %r12d,0x10(%rsp)
    b84b:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%rsp)
    b852:	00 
    b853:	be 01 00 00 00       	mov    $0x1,%esi
    b858:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    b85d:	31 d2                	xor    %edx,%edx
    b85f:	e8 5c 7b ff ff       	call   33c0 <poll@plt>
    b864:	85 c0                	test   %eax,%eax
    b866:	0f 8e 44 ff ff ff    	jle    b7b0 <fwp_pipe_write+0x1f0>
    b86c:	f6 44 24 16 18       	testb  $0x18,0x16(%rsp)
    b871:	75 20                	jne    b893 <fwp_pipe_write+0x2d3>
    b873:	ba 01 00 00 00       	mov    $0x1,%edx
    b878:	44 89 e7             	mov    %r12d,%edi
    b87b:	48 8d 74 24 0f       	lea    0xf(%rsp),%rsi
    b880:	b9 42 00 00 00       	mov    $0x42,%ecx
    b885:	e8 d6 77 ff ff       	call   3060 <recv@plt>
    b88a:	48 85 c0             	test   %rax,%rax
    b88d:	0f 85 1d ff ff ff    	jne    b7b0 <fwp_pipe_write+0x1f0>
    b893:	c6 05 8e 06 03 00 01 	movb   $0x1,0x3068e(%rip)        # 3bf28 <fwp_po_gone>
    b89a:	e9 44 fe ff ff       	jmp    b6e3 <fwp_pipe_write+0x123>
    b89f:	41 c7 85 04 01 00 00 	movl   $0x0,0x104(%r13)
    b8a6:	00 00 00 00 
    b8aa:	e9 34 fe ff ff       	jmp    b6e3 <fwp_pipe_write+0x123>
    b8af:	4c 8b 3d 62 06 02 00 	mov    0x20662(%rip),%r15        # 2bf18 <fwp_po_len>
    b8b6:	49 8d 04 1f          	lea    (%r15,%rbx,1),%rax
    b8ba:	48 3d 01 00 01 00    	cmp    $0x10001,%rax
    b8c0:	0f 82 b1 00 00 00    	jb     b977 <fwp_pipe_write+0x3b7>
    b8c6:	4d 85 ff             	test   %r15,%r15
    b8c9:	0f 84 9a 00 00 00    	je     b969 <fwp_pipe_write+0x3a9>
    b8cf:	80 3d 52 06 03 00 00 	cmpb   $0x0,0x30652(%rip)        # 3bf28 <fwp_po_gone>
    b8d6:	0f 85 8d 00 00 00    	jne    b969 <fwp_pipe_write+0x3a9>
    b8dc:	8b 2d 02 05 01 00    	mov    0x10502(%rip),%ebp        # 1bde4 <fwp_po_sock>
    b8e2:	4c 8d 25 37 06 02 00 	lea    0x20637(%rip),%r12        # 2bf20 <fwp_po_buf>
    b8e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    b8f0:	89 ef                	mov    %ebp,%edi
    b8f2:	4c 89 e6             	mov    %r12,%rsi
    b8f5:	4c 89 fa             	mov    %r15,%rdx
    b8f8:	b9 00 40 00 00       	mov    $0x4000,%ecx
    b8fd:	e8 9e 78 ff ff       	call   31a0 <send@plt>
    b902:	48 85 c0             	test   %rax,%rax
    b905:	78 19                	js     b920 <fwp_pipe_write+0x360>
    b907:	74 59                	je     b962 <fwp_pipe_write+0x3a2>
    b909:	49 01 c4             	add    %rax,%r12
    b90c:	49 29 c7             	sub    %rax,%r15
    b90f:	eb 19                	jmp    b92a <fwp_pipe_write+0x36a>
    b911:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b918:	0f 1f 84 00 00 00 00 
    b91f:	00 
    b920:	e8 5b 77 ff ff       	call   3080 <__errno_location@plt>
    b925:	83 38 04             	cmpl   $0x4,(%rax)
    b928:	75 38                	jne    b962 <fwp_pipe_write+0x3a2>
    b92a:	4d 85 ff             	test   %r15,%r15
    b92d:	74 3a                	je     b969 <fwp_pipe_write+0x3a9>
    b92f:	f6 05 f2 05 03 00 01 	testb  $0x1,0x305f2(%rip)        # 3bf28 <fwp_po_gone>
    b936:	74 b8                	je     b8f0 <fwp_pipe_write+0x330>
    b938:	eb 2f                	jmp    b969 <fwp_pipe_write+0x3a9>
    b93a:	48 8b 05 6f e6 00 00 	mov    0xe66f(%rip),%rax        # 19fb0 <stdout@GLIBC_2.2.5>
    b941:	48 8b 08             	mov    (%rax),%rcx
    b944:	be 01 00 00 00       	mov    $0x1,%esi
    b949:	4c 89 f7             	mov    %r14,%rdi
    b94c:	48 89 da             	mov    %rbx,%rdx
    b94f:	48 83 c4 48          	add    $0x48,%rsp
    b953:	5b                   	pop    %rbx
    b954:	41 5c                	pop    %r12
    b956:	41 5d                	pop    %r13
    b958:	41 5e                	pop    %r14
    b95a:	41 5f                	pop    %r15
    b95c:	5d                   	pop    %rbp
    b95d:	e9 1e 7b ff ff       	jmp    3480 <fwrite@plt>
    b962:	c6 05 bf 05 03 00 01 	movb   $0x1,0x305bf(%rip)        # 3bf28 <fwp_po_gone>
    b969:	48 c7 05 a4 05 02 00 	movq   $0x0,0x205a4(%rip)        # 2bf18 <fwp_po_len>
    b970:	00 00 00 00 
    b974:	45 31 ff             	xor    %r15d,%r15d
    b977:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    b97e:	72 5a                	jb     b9da <fwp_pipe_write+0x41a>
    b980:	80 3d a1 05 03 00 00 	cmpb   $0x0,0x305a1(%rip)        # 3bf28 <fwp_po_gone>
    b987:	75 79                	jne    ba02 <fwp_pipe_write+0x442>
    b989:	8b 2d 55 04 01 00    	mov    0x10455(%rip),%ebp        # 1bde4 <fwp_po_sock>
    b98f:	90                   	nop
    b990:	89 ef                	mov    %ebp,%edi
    b992:	4c 89 f6             	mov    %r14,%rsi
    b995:	48 89 da             	mov    %rbx,%rdx
    b998:	b9 00 40 00 00       	mov    $0x4000,%ecx
    b99d:	e8 fe 77 ff ff       	call   31a0 <send@plt>
    b9a2:	48 85 c0             	test   %rax,%rax
    b9a5:	78 19                	js     b9c0 <fwp_pipe_write+0x400>
    b9a7:	74 52                	je     b9fb <fwp_pipe_write+0x43b>
    b9a9:	49 01 c6             	add    %rax,%r14
    b9ac:	48 29 c3             	sub    %rax,%rbx
    b9af:	eb 19                	jmp    b9ca <fwp_pipe_write+0x40a>
    b9b1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b9b8:	0f 1f 84 00 00 00 00 
    b9bf:	00 
    b9c0:	e8 bb 76 ff ff       	call   3080 <__errno_location@plt>
    b9c5:	83 38 04             	cmpl   $0x4,(%rax)
    b9c8:	75 31                	jne    b9fb <fwp_pipe_write+0x43b>
    b9ca:	48 85 db             	test   %rbx,%rbx
    b9cd:	74 33                	je     ba02 <fwp_pipe_write+0x442>
    b9cf:	f6 05 52 05 03 00 01 	testb  $0x1,0x30552(%rip)        # 3bf28 <fwp_po_gone>
    b9d6:	74 b8                	je     b990 <fwp_pipe_write+0x3d0>
    b9d8:	eb 28                	jmp    ba02 <fwp_pipe_write+0x442>
    b9da:	48 8d 3d 3f 05 02 00 	lea    0x2053f(%rip),%rdi        # 2bf20 <fwp_po_buf>
    b9e1:	4c 01 ff             	add    %r15,%rdi
    b9e4:	4c 89 f6             	mov    %r14,%rsi
    b9e7:	48 89 da             	mov    %rbx,%rdx
    b9ea:	e8 41 79 ff ff       	call   3330 <memcpy@plt>
    b9ef:	49 01 df             	add    %rbx,%r15
    b9f2:	4c 89 3d 1f 05 02 00 	mov    %r15,0x2051f(%rip)        # 2bf18 <fwp_po_len>
    b9f9:	eb 07                	jmp    ba02 <fwp_pipe_write+0x442>
    b9fb:	c6 05 26 05 03 00 01 	movb   $0x1,0x30526(%rip)        # 3bf28 <fwp_po_gone>
    ba02:	48 83 c4 48          	add    $0x48,%rsp
    ba06:	5b                   	pop    %rbx
    ba07:	41 5c                	pop    %r12
    ba09:	41 5d                	pop    %r13
    ba0b:	41 5e                	pop    %r14
    ba0d:	41 5f                	pop    %r15
    ba0f:	5d                   	pop    %rbp
    ba10:	c3                   	ret
    ba11:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ba18:	0f 1f 84 00 00 00 00 
    ba1f:	00 

000000000000ba20 <fwp_pipe_flush>:
    ba20:	55                   	push   %rbp
    ba21:	41 56                	push   %r14
    ba23:	53                   	push   %rbx
    ba24:	8b 05 e6 04 02 00    	mov    0x204e6(%rip),%eax        # 2bf10 <fwp_po_kind>
    ba2a:	85 c0                	test   %eax,%eax
    ba2c:	74 7c                	je     baaa <fwp_pipe_flush+0x8a>
    ba2e:	83 f8 01             	cmp    $0x1,%eax
    ba31:	0f 85 9d 00 00 00    	jne    bad4 <fwp_pipe_flush+0xb4>
    ba37:	48 8b 1d da 04 02 00 	mov    0x204da(%rip),%rbx        # 2bf18 <fwp_po_len>
    ba3e:	48 85 db             	test   %rbx,%rbx
    ba41:	0f 84 82 00 00 00    	je     bac9 <fwp_pipe_flush+0xa9>
    ba47:	80 3d da 04 03 00 00 	cmpb   $0x0,0x304da(%rip)        # 3bf28 <fwp_po_gone>
    ba4e:	75 79                	jne    bac9 <fwp_pipe_flush+0xa9>
    ba50:	8b 2d 8e 03 01 00    	mov    0x1038e(%rip),%ebp        # 1bde4 <fwp_po_sock>
    ba56:	4c 8d 35 c3 04 02 00 	lea    0x204c3(%rip),%r14        # 2bf20 <fwp_po_buf>
    ba5d:	0f 1f 00             	nopl   (%rax)
    ba60:	89 ef                	mov    %ebp,%edi
    ba62:	4c 89 f6             	mov    %r14,%rsi
    ba65:	48 89 da             	mov    %rbx,%rdx
    ba68:	b9 00 40 00 00       	mov    $0x4000,%ecx
    ba6d:	e8 2e 77 ff ff       	call   31a0 <send@plt>
    ba72:	48 85 c0             	test   %rax,%rax
    ba75:	78 19                	js     ba90 <fwp_pipe_flush+0x70>
    ba77:	74 49                	je     bac2 <fwp_pipe_flush+0xa2>
    ba79:	49 01 c6             	add    %rax,%r14
    ba7c:	48 29 c3             	sub    %rax,%rbx
    ba7f:	eb 19                	jmp    ba9a <fwp_pipe_flush+0x7a>
    ba81:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ba88:	0f 1f 84 00 00 00 00 
    ba8f:	00 
    ba90:	e8 eb 75 ff ff       	call   3080 <__errno_location@plt>
    ba95:	83 38 04             	cmpl   $0x4,(%rax)
    ba98:	75 28                	jne    bac2 <fwp_pipe_flush+0xa2>
    ba9a:	48 85 db             	test   %rbx,%rbx
    ba9d:	74 2a                	je     bac9 <fwp_pipe_flush+0xa9>
    ba9f:	f6 05 82 04 03 00 01 	testb  $0x1,0x30482(%rip)        # 3bf28 <fwp_po_gone>
    baa6:	74 b8                	je     ba60 <fwp_pipe_flush+0x40>
    baa8:	eb 1f                	jmp    bac9 <fwp_pipe_flush+0xa9>
    baaa:	48 8b 05 ff e4 00 00 	mov    0xe4ff(%rip),%rax        # 19fb0 <stdout@GLIBC_2.2.5>
    bab1:	48 8b 38             	mov    (%rax),%rdi
    bab4:	e8 97 78 ff ff       	call   3350 <fflush@plt>
    bab9:	5b                   	pop    %rbx
    baba:	41 5e                	pop    %r14
    babc:	5d                   	pop    %rbp
    babd:	e9 be 4f 00 00       	jmp    10a80 <fwp_pipe_poll>
    bac2:	c6 05 5f 04 03 00 01 	movb   $0x1,0x3045f(%rip)        # 3bf28 <fwp_po_gone>
    bac9:	48 c7 05 44 04 02 00 	movq   $0x0,0x20444(%rip)        # 2bf18 <fwp_po_len>
    bad0:	00 00 00 00 
    bad4:	5b                   	pop    %rbx
    bad5:	41 5e                	pop    %r14
    bad7:	5d                   	pop    %rbp
    bad8:	c3                   	ret
    bad9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000bae0 <fwp_exec_call>:
    bae0:	41 57                	push   %r15
    bae2:	41 56                	push   %r14
    bae4:	41 55                	push   %r13
    bae6:	41 54                	push   %r12
    bae8:	53                   	push   %rbx
    bae9:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
    baf0:	48 89 f3             	mov    %rsi,%rbx
    baf3:	49 89 fe             	mov    %rdi,%r14
    baf6:	48 8b 05 3b 04 03 00 	mov    0x3043b(%rip),%rax        # 3bf38 <fwp_handlers>
    bafd:	48 89 84 24 e8 00 00 	mov    %rax,0xe8(%rsp)
    bb04:	00 
    bb05:	48 c7 84 24 00 01 00 	movq   $0x0,0x100(%rsp)
    bb0c:	00 00 00 00 00 
    bb11:	48 8b 05 a0 03 01 00 	mov    0x103a0(%rip),%rax        # 1beb8 <fwp_cleanups>
    bb18:	48 89 84 24 08 01 00 	mov    %rax,0x108(%rsp)
    bb1f:	00 
    bb20:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
    bb25:	48 89 3d 0c 04 03 00 	mov    %rdi,0x3040c(%rip)        # 3bf38 <fwp_handlers>
    bb2c:	e8 7f 77 ff ff       	call   32b0 <_setjmp@plt>
    bb31:	85 c0                	test   %eax,%eax
    bb33:	0f 85 d1 00 00 00    	jne    bc0a <fwp_exec_call+0x12a>
    bb39:	48 ff 05 68 03 01 00 	incq   0x10368(%rip)        # 1bea8 <measured_calls>
    bb40:	48 83 05 68 03 01 00 	addq   $0x8,0x10368(%rip)        # 1beb0 <measured_bytes>
    bb47:	08 
    bb48:	48 8d 05 39 e7 00 00 	lea    0xe739(%rip),%rax        # 1a288 <fwp_gc>
    bb4f:	0f b6 0d 1b f3 00 00 	movzbl 0xf31b(%rip),%ecx        # 1ae71 <fwp_gc+0xbe9>
    bb56:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    bb5d:	48 29 15 24 e7 00 00 	sub    %rdx,0xe724(%rip)        # 1a288 <fwp_gc>
    bb64:	78 3a                	js     bba0 <fwp_exec_call+0xc0>
    bb66:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    bb6a:	48 8d 34 c8          	lea    (%rax,%rcx,8),%rsi
    bb6e:	48 81 c6 88 07 00 00 	add    $0x788,%rsi
    bb75:	4c 8b 3e             	mov    (%rsi),%r15
    bb78:	4d 85 ff             	test   %r15,%r15
    bb7b:	74 0b                	je     bb88 <fwp_exec_call+0xa8>
    bb7d:	49 8b 07             	mov    (%r15),%rax
    bb80:	48 f7 d0             	not    %rax
    bb83:	48 89 06             	mov    %rax,(%rsi)
    bb86:	eb 3d                	jmp    bbc5 <fwp_exec_call+0xe5>
    bb88:	4c 8b bc c8 90 07 00 	mov    0x790(%rax,%rcx,8),%r15
    bb8f:	00 
    bb90:	48 8b b4 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%rsi
    bb97:	00 
    bb98:	4c 29 fe             	sub    %r15,%rsi
    bb9b:	48 39 d6             	cmp    %rdx,%rsi
    bb9e:	73 14                	jae    bbb4 <fwp_exec_call+0xd4>
    bba0:	bf 08 00 00 00       	mov    $0x8,%edi
    bba5:	be 02 00 00 00       	mov    $0x2,%esi
    bbaa:	e8 d1 c6 ff ff       	call   8280 <fwp_gc_alloc_slow>
    bbaf:	48 89 c7             	mov    %rax,%rdi
    bbb2:	eb 1e                	jmp    bbd2 <fwp_exec_call+0xf2>
    bbb4:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    bbb8:	48 05 90 07 00 00    	add    $0x790,%rax
    bbbe:	49 8d 0c 17          	lea    (%r15,%rdx,1),%rcx
    bbc2:	48 89 08             	mov    %rcx,(%rax)
    bbc5:	4c 89 ff             	mov    %r15,%rdi
    bbc8:	31 f6                	xor    %esi,%esi
    bbca:	e8 41 76 ff ff       	call   3210 <memset@plt>
    bbcf:	4c 89 ff             	mov    %r15,%rdi
    bbd2:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    bbd9:	be 01 00 00 00       	mov    $0x1,%esi
    bbde:	4c 89 f2             	mov    %r14,%rdx
    bbe1:	e8 ba b7 ff ff       	call   73a0 <fwp_apply>
    bbe6:	48 8b 8c 24 e8 00 00 	mov    0xe8(%rsp),%rcx
    bbed:	00 
    bbee:	48 89 0d 43 03 03 00 	mov    %rcx,0x30343(%rip)        # 3bf38 <fwp_handlers>
    bbf5:	31 c9                	xor    %ecx,%ecx
    bbf7:	89 0b                	mov    %ecx,(%rbx)
    bbf9:	48 81 c4 10 01 00 00 	add    $0x110,%rsp
    bc00:	5b                   	pop    %rbx
    bc01:	41 5c                	pop    %r12
    bc03:	41 5d                	pop    %r13
    bc05:	41 5e                	pop    %r14
    bc07:	41 5f                	pop    %r15
    bc09:	c3                   	ret
    bc0a:	48 8b 84 24 e8 00 00 	mov    0xe8(%rsp),%rax
    bc11:	00 
    bc12:	48 89 05 1f 03 03 00 	mov    %rax,0x3031f(%rip)        # 3bf38 <fwp_handlers>
    bc19:	48 8b 3d 58 02 01 00 	mov    0x10258(%rip),%rdi        # 1be78 <fwp_prog_out>
    bc20:	48 85 ff             	test   %rdi,%rdi
    bc23:	74 05                	je     bc2a <fwp_exec_call+0x14a>
    bc25:	e8 26 77 ff ff       	call   3350 <fflush@plt>
    bc2a:	48 8b 05 7f e3 00 00 	mov    0xe37f(%rip),%rax        # 19fb0 <stdout@GLIBC_2.2.5>
    bc31:	48 8b 38             	mov    (%rax),%rdi
    bc34:	e8 17 77 ff ff       	call   3350 <fflush@plt>
    bc39:	4c 8b b4 24 f0 00 00 	mov    0xf0(%rsp),%r14
    bc40:	00 
    bc41:	4c 8b bc 24 f8 00 00 	mov    0xf8(%rsp),%r15
    bc48:	00 
    bc49:	e8 d2 fd ff ff       	call   ba20 <fwp_pipe_flush>
    bc4e:	4c 8b 2d 83 e3 00 00 	mov    0xe383(%rip),%r13        # 19fd8 <stderr@GLIBC_2.2.5>
    bc55:	49 8b 7d 00          	mov    0x0(%r13),%rdi
    bc59:	48 8d 35 ed aa 00 00 	lea    0xaaed(%rip),%rsi        # 1674d <exec_in_fp0+0xedd>
    bc60:	48 8d 15 5f 9d 00 00 	lea    0x9d5f(%rip),%rdx        # 159c6 <exec_in_fp0+0x156>
    bc67:	31 c0                	xor    %eax,%eax
    bc69:	e8 82 76 ff ff       	call   32f0 <fprintf@plt>
    bc6e:	41 83 3f 10          	cmpl   $0x10,(%r15)
    bc72:	75 20                	jne    bc94 <fwp_exec_call+0x1b4>
    bc74:	49 8b 7f 08          	mov    0x8(%r15),%rdi
    bc78:	48 85 ff             	test   %rdi,%rdi
    bc7b:	74 17                	je     bc94 <fwp_exec_call+0x1b4>
    bc7d:	48 8d 35 ce aa 00 00 	lea    0xaace(%rip),%rsi        # 16752 <exec_in_fp0+0xee2>
    bc84:	e8 47 76 ff ff       	call   32d0 <strcmp@plt>
    bc89:	85 c0                	test   %eax,%eax
    bc8b:	75 07                	jne    bc94 <fwp_exec_call+0x1b4>
    bc8d:	41 83 7f 10 02       	cmpl   $0x2,0x10(%r15)
    bc92:	74 6b                	je     bcff <fwp_exec_call+0x21f>
    bc94:	4d 8b 65 00          	mov    0x0(%r13),%r12
    bc98:	0f 57 c0             	xorps  %xmm0,%xmm0
    bc9b:	0f 29 04 24          	movaps %xmm0,(%rsp)
    bc9f:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    bca6:	00 00 
    bca8:	48 89 e7             	mov    %rsp,%rdi
    bcab:	4c 89 f6             	mov    %r14,%rsi
    bcae:	4c 89 fa             	mov    %r15,%rdx
    bcb1:	b9 01 00 00 00       	mov    $0x1,%ecx
    bcb6:	e8 45 51 00 00       	call   10e00 <fwp_write>
    bcbb:	48 8b 3c 24          	mov    (%rsp),%rdi
    bcbf:	48 85 ff             	test   %rdi,%rdi
    bcc2:	75 23                	jne    bce7 <fwp_exec_call+0x207>
    bcc4:	31 c0                	xor    %eax,%eax
    bcc6:	89 c7                	mov    %eax,%edi
    bcc8:	e8 83 73 ff ff       	call   3050 <free@plt>
    bccd:	49 8b 75 00          	mov    0x0(%r13),%rsi
    bcd1:	bf 0a 00 00 00       	mov    $0xa,%edi
    bcd6:	e8 65 75 ff ff       	call   3240 <fputc@plt>
    bcdb:	b9 01 00 00 00       	mov    $0x1,%ecx
    bce0:	31 c0                	xor    %eax,%eax
    bce2:	e9 10 ff ff ff       	jmp    bbf7 <fwp_exec_call+0x117>
    bce7:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    bcec:	be 01 00 00 00       	mov    $0x1,%esi
    bcf1:	4c 89 e1             	mov    %r12,%rcx
    bcf4:	e8 87 77 ff ff       	call   3480 <fwrite@plt>
    bcf9:	48 8b 3c 24          	mov    (%rsp),%rdi
    bcfd:	eb c9                	jmp    bcc8 <fwp_exec_call+0x1e8>
    bcff:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    bd03:	48 8b 17             	mov    (%rdi),%rdx
    bd06:	48 83 c7 08          	add    $0x8,%rdi
    bd0a:	49 8b 4d 00          	mov    0x0(%r13),%rcx
    bd0e:	be 01 00 00 00       	mov    $0x1,%esi
    bd13:	e8 68 77 ff ff       	call   3480 <fwrite@plt>
    bd18:	eb b3                	jmp    bccd <fwp_exec_call+0x1ed>
    bd1a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000bd20 <fwp_emit_result>:
    bd20:	41 56                	push   %r14
    bd22:	53                   	push   %rbx
    bd23:	48 83 ec 28          	sub    $0x28,%rsp
    bd27:	48 89 fe             	mov    %rdi,%rsi
    bd2a:	83 3d bf 01 02 00 00 	cmpl   $0x0,0x201bf(%rip)        # 2bef0 <fwp_exec_binary_out>
    bd31:	0f 84 89 00 00 00    	je     bdc0 <fwp_emit_result+0xa0>
    bd37:	0f 57 c0             	xorps  %xmm0,%xmm0
    bd3a:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    bd3f:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    bd46:	00 00 
    bd48:	48 8d 15 31 00 01 00 	lea    0x10031(%rip),%rdx        # 1bd80 <d2>
    bd4f:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    bd54:	e8 a7 72 00 00       	call   13000 <fwp_encode>
    bd59:	c6 44 24 0b 01       	movb   $0x1,0xb(%rsp)
    bd5e:	8b 44 24 18          	mov    0x18(%rsp),%eax
    bd62:	89 44 24 0c          	mov    %eax,0xc(%rsp)
    bd66:	48 8d 7c 24 0b       	lea    0xb(%rsp),%rdi
    bd6b:	be 05 00 00 00       	mov    $0x5,%esi
    bd70:	e8 4b f8 ff ff       	call   b5c0 <fwp_pipe_write>
    bd75:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    bd7a:	48 85 f6             	test   %rsi,%rsi
    bd7d:	74 0a                	je     bd89 <fwp_emit_result+0x69>
    bd7f:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    bd84:	e8 37 f8 ff ff       	call   b5c0 <fwp_pipe_write>
    bd89:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    bd8e:	e8 bd 72 ff ff       	call   3050 <free@plt>
    bd93:	83 3d 46 00 01 00 00 	cmpl   $0x0,0x10046(%rip)        # 1bde0 <fwp_po_listen>
    bd9a:	0f 88 a4 00 00 00    	js     be44 <fwp_emit_result+0x124>
    bda0:	8b 05 9a 01 03 00    	mov    0x3019a(%rip),%eax        # 3bf40 <fwp_po_frames>
    bda6:	ff c0                	inc    %eax
    bda8:	89 05 92 01 03 00    	mov    %eax,0x30192(%rip)        # 3bf40 <fwp_po_frames>
    bdae:	a8 3f                	test   $0x3f,%al
    bdb0:	0f 85 8e 00 00 00    	jne    be44 <fwp_emit_result+0x124>
    bdb6:	e8 c5 4c 00 00       	call   10a80 <fwp_pipe_poll>
    bdbb:	e9 84 00 00 00       	jmp    be44 <fwp_emit_result+0x124>
    bdc0:	83 3d b9 ff 00 00 10 	cmpl   $0x10,0xffb9(%rip)        # 1bd80 <d2>
    bdc7:	75 13                	jne    bddc <fwp_emit_result+0xbc>
    bdc9:	83 3d c0 ff 00 00 00 	cmpl   $0x0,0xffc0(%rip)        # 1bd90 <d2+0x10>
    bdd0:	75 0a                	jne    bddc <fwp_emit_result+0xbc>
    bdd2:	48 83 3d ae ff 00 00 	cmpq   $0x0,0xffae(%rip)        # 1bd88 <d2+0x8>
    bdd9:	00 
    bdda:	74 68                	je     be44 <fwp_emit_result+0x124>
    bddc:	4c 8b 35 cd e1 00 00 	mov    0xe1cd(%rip),%r14        # 19fb0 <stdout@GLIBC_2.2.5>
    bde3:	49 8b 1e             	mov    (%r14),%rbx
    bde6:	0f 57 c0             	xorps  %xmm0,%xmm0
    bde9:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    bdee:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    bdf5:	00 00 
    bdf7:	48 8d 15 82 ff 00 00 	lea    0xff82(%rip),%rdx        # 1bd80 <d2>
    bdfe:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    be03:	b9 01 00 00 00       	mov    $0x1,%ecx
    be08:	e8 f3 4f 00 00       	call   10e00 <fwp_write>
    be0d:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    be12:	48 85 ff             	test   %rdi,%rdi
    be15:	74 19                	je     be30 <fwp_emit_result+0x110>
    be17:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
    be1c:	be 01 00 00 00       	mov    $0x1,%esi
    be21:	48 89 d9             	mov    %rbx,%rcx
    be24:	e8 57 76 ff ff       	call   3480 <fwrite@plt>
    be29:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    be2e:	eb 02                	jmp    be32 <fwp_emit_result+0x112>
    be30:	31 ff                	xor    %edi,%edi
    be32:	e8 19 72 ff ff       	call   3050 <free@plt>
    be37:	49 8b 36             	mov    (%r14),%rsi
    be3a:	bf 0a 00 00 00       	mov    $0xa,%edi
    be3f:	e8 fc 73 ff ff       	call   3240 <fputc@plt>
    be44:	48 83 c4 28          	add    $0x28,%rsp
    be48:	5b                   	pop    %rbx
    be49:	41 5e                	pop    %r14
    be4b:	c3                   	ret
    be4c:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000be50 <fwp_read_exact>:
    be50:	55                   	push   %rbp
    be51:	41 57                	push   %r15
    be53:	41 56                	push   %r14
    be55:	41 55                	push   %r13
    be57:	41 54                	push   %r12
    be59:	53                   	push   %rbx
    be5a:	48 83 ec 48          	sub    $0x48,%rsp
    be5e:	49 89 f7             	mov    %rsi,%r15
    be61:	49 89 fe             	mov    %rdi,%r14
    be64:	45 31 ed             	xor    %r13d,%r13d
    be67:	48 85 f6             	test   %rsi,%rsi
    be6a:	0f 84 b8 00 00 00    	je     bf28 <fwp_read_exact+0xd8>
    be70:	8b 05 82 00 02 00    	mov    0x20082(%rip),%eax        # 2bef8 <fwp_in_npend>
    be76:	8b 0d 80 00 02 00    	mov    0x20080(%rip),%ecx        # 2befc <fwp_in_ppos>
    be7c:	39 c1                	cmp    %eax,%ecx
    be7e:	0f 8d a4 00 00 00    	jge    bf28 <fwp_read_exact+0xd8>
    be84:	48 98                	cltq
    be86:	48 63 f1             	movslq %ecx,%rsi
    be89:	48 89 f2             	mov    %rsi,%rdx
    be8c:	48 f7 d2             	not    %rdx
    be8f:	48 01 c2             	add    %rax,%rdx
    be92:	49 8d 4f ff          	lea    -0x1(%r15),%rcx
    be96:	48 39 ca             	cmp    %rcx,%rdx
    be99:	48 0f 43 d1          	cmovae %rcx,%rdx
    be9d:	48 ff c2             	inc    %rdx
    bea0:	48 83 fa 20          	cmp    $0x20,%rdx
    bea4:	72 16                	jb     bebc <fwp_read_exact+0x6c>
    bea6:	48 8d 3d 47 00 02 00 	lea    0x20047(%rip),%rdi        # 2bef4 <fwp_in_pend>
    bead:	4d 89 f0             	mov    %r14,%r8
    beb0:	49 29 f0             	sub    %rsi,%r8
    beb3:	49 29 f8             	sub    %rdi,%r8
    beb6:	49 83 f8 20          	cmp    $0x20,%r8
    beba:	73 2e                	jae    beea <fwp_read_exact+0x9a>
    bebc:	45 31 ed             	xor    %r13d,%r13d
    bebf:	48 89 f1             	mov    %rsi,%rcx
    bec2:	48 8d 15 2b 00 02 00 	lea    0x2002b(%rip),%rdx        # 2bef4 <fwp_in_pend>
    bec9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    bed0:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    bed4:	48 ff c1             	inc    %rcx
    bed7:	43 88 34 2e          	mov    %sil,(%r14,%r13,1)
    bedb:	49 ff c5             	inc    %r13
    bede:	4d 39 fd             	cmp    %r15,%r13
    bee1:	73 3f                	jae    bf22 <fwp_read_exact+0xd2>
    bee3:	48 39 c1             	cmp    %rax,%rcx
    bee6:	7c e8                	jl     bed0 <fwp_read_exact+0x80>
    bee8:	eb 38                	jmp    bf22 <fwp_read_exact+0xd2>
    beea:	49 89 d5             	mov    %rdx,%r13
    beed:	49 83 e5 e0          	and    $0xffffffffffffffe0,%r13
    bef1:	4a 8d 0c 2e          	lea    (%rsi,%r13,1),%rcx
    bef5:	48 01 fe             	add    %rdi,%rsi
    bef8:	48 83 c6 10          	add    $0x10,%rsi
    befc:	31 ff                	xor    %edi,%edi
    befe:	66 90                	xchg   %ax,%ax
    bf00:	0f 10 44 3e f0       	movups -0x10(%rsi,%rdi,1),%xmm0
    bf05:	0f 10 0c 3e          	movups (%rsi,%rdi,1),%xmm1
    bf09:	41 0f 11 04 3e       	movups %xmm0,(%r14,%rdi,1)
    bf0e:	41 0f 11 4c 3e 10    	movups %xmm1,0x10(%r14,%rdi,1)
    bf14:	48 83 c7 20          	add    $0x20,%rdi
    bf18:	49 39 fd             	cmp    %rdi,%r13
    bf1b:	75 e3                	jne    bf00 <fwp_read_exact+0xb0>
    bf1d:	4c 39 ea             	cmp    %r13,%rdx
    bf20:	75 a0                	jne    bec2 <fwp_read_exact+0x72>
    bf22:	89 0d d4 ff 01 00    	mov    %ecx,0x1ffd4(%rip)        # 2befc <fwp_in_ppos>
    bf28:	4c 89 74 24 28       	mov    %r14,0x28(%rsp)
    bf2d:	4c 89 7c 24 38       	mov    %r15,0x38(%rsp)
    bf32:	eb 34                	jmp    bf68 <fwp_read_exact+0x118>
    bf34:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    bf3b:	00 00 00 00 00 
    bf40:	48 8b 05 71 e0 00 00 	mov    0xe071(%rip),%rax        # 19fb8 <stdin@GLIBC_2.2.5>
    bf47:	48 8b 08             	mov    (%rax),%rcx
    bf4a:	be 01 00 00 00       	mov    $0x1,%esi
    bf4f:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    bf54:	48 89 da             	mov    %rbx,%rdx
    bf57:	e8 94 71 ff ff       	call   30f0 <fread@plt>
    bf5c:	49 01 c5             	add    %rax,%r13
    bf5f:	48 85 c0             	test   %rax,%rax
    bf62:	0f 84 db 03 00 00    	je     c343 <fwp_read_exact+0x4f3>
    bf68:	4c 89 fb             	mov    %r15,%rbx
    bf6b:	4c 29 eb             	sub    %r13,%rbx
    bf6e:	0f 86 e0 03 00 00    	jbe    c354 <fwp_read_exact+0x504>
    bf74:	4b 8d 04 2e          	lea    (%r14,%r13,1),%rax
    bf78:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    bf7d:	8b 05 c1 ff 02 00    	mov    0x2ffc1(%rip),%eax        # 3bf44 <fwp_pi_kind>
    bf83:	83 f8 01             	cmp    $0x1,%eax
    bf86:	0f 84 64 02 00 00    	je     c1f0 <fwp_read_exact+0x3a0>
    bf8c:	83 f8 02             	cmp    $0x2,%eax
    bf8f:	75 af                	jne    bf40 <fwp_read_exact+0xf0>
    bf91:	4c 8b 3d b0 ff 02 00 	mov    0x2ffb0(%rip),%r15        # 3bf48 <fwp_pi_ring>
    bf98:	4d 8b 77 40          	mov    0x40(%r15),%r14
    bf9c:	49 8b 87 80 00 00 00 	mov    0x80(%r15),%rax
    bfa3:	49 39 c6             	cmp    %rax,%r14
    bfa6:	0f 85 94 02 00 00    	jne    c240 <fwp_read_exact+0x3f0>
    bfac:	49 8d 87 c0 00 00 00 	lea    0xc0(%r15),%rax
    bfb3:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    bfb8:	eb 25                	jmp    bfdf <fwp_read_exact+0x18f>
    bfba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    bfc0:	41 c7 87 c4 00 00 00 	movl   $0x0,0xc4(%r15)
    bfc7:	00 00 00 00 
    bfcb:	4d 8b 77 40          	mov    0x40(%r15),%r14
    bfcf:	49 8b 87 80 00 00 00 	mov    0x80(%r15),%rax
    bfd6:	49 39 c6             	cmp    %rax,%r14
    bfd9:	0f 85 61 02 00 00    	jne    c240 <fwp_read_exact+0x3f0>
    bfdf:	41 8b 87 40 01 00 00 	mov    0x140(%r15),%eax
    bfe6:	85 c0                	test   %eax,%eax
    bfe8:	74 11                	je     bffb <fwp_read_exact+0x1ab>
    bfea:	49 8b 47 40          	mov    0x40(%r15),%rax
    bfee:	49 3b 87 80 00 00 00 	cmp    0x80(%r15),%rax
    bff5:	0f 84 48 03 00 00    	je     c343 <fwp_read_exact+0x4f3>
    bffb:	44 8b 25 ea fd 00 00 	mov    0xfdea(%rip),%r12d        # 1bdec <fwp_pi_sock>
    c002:	8b 0d e0 fd 00 00    	mov    0xfde0(%rip),%ecx        # 1bde8 <fwp_ring_spin>
    c008:	85 c9                	test   %ecx,%ecx
    c00a:	78 14                	js     c020 <fwp_read_exact+0x1d0>
    c00c:	85 c9                	test   %ecx,%ecx
    c00e:	75 31                	jne    c041 <fwp_read_exact+0x1f1>
    c010:	e9 3b 01 00 00       	jmp    c150 <fwp_read_exact+0x300>
    c015:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    c01c:	00 00 00 00 
    c020:	bf 54 00 00 00       	mov    $0x54,%edi
    c025:	e8 f6 73 ff ff       	call   3420 <sysconf@plt>
    c02a:	31 c9                	xor    %ecx,%ecx
    c02c:	48 83 f8 02          	cmp    $0x2,%rax
    c030:	0f 9d c1             	setge  %cl
    c033:	89 0d af fd 00 00    	mov    %ecx,0xfdaf(%rip)        # 1bde8 <fwp_ring_spin>
    c039:	85 c9                	test   %ecx,%ecx
    c03b:	0f 84 0f 01 00 00    	je     c150 <fwp_read_exact+0x300>
    c041:	49 8b 47 40          	mov    0x40(%r15),%rax
    c045:	49 3b 87 80 00 00 00 	cmp    0x80(%r15),%rax
    c04c:	0f 85 79 ff ff ff    	jne    bfcb <fwp_read_exact+0x17b>
    c052:	41 8b 87 40 01 00 00 	mov    0x140(%r15),%eax
    c059:	85 c0                	test   %eax,%eax
    c05b:	0f 85 6a ff ff ff    	jne    bfcb <fwp_read_exact+0x17b>
    c061:	bd 01 00 00 00       	mov    $0x1,%ebp
    c066:	45 31 f6             	xor    %r14d,%r14d
    c069:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    c070:	f3 90                	pause
    c072:	40 f6 c5 3f          	test   $0x3f,%bpl
    c076:	75 48                	jne    c0c0 <fwp_read_exact+0x270>
    c078:	e8 d3 71 ff ff       	call   3250 <sched_yield@plt>
    c07d:	bf 01 00 00 00       	mov    $0x1,%edi
    c082:	48 8d 74 24 18       	lea    0x18(%rsp),%rsi
    c087:	e8 a4 70 ff ff       	call   3130 <clock_gettime@plt>
    c08c:	48 69 44 24 18 00 ca 	imul   $0x3b9aca00,0x18(%rsp),%rax
    c093:	9a 3b 
    c095:	48 03 44 24 20       	add    0x20(%rsp),%rax
    c09a:	4d 85 f6             	test   %r14,%r14
    c09d:	74 0a                	je     c0a9 <fwp_read_exact+0x259>
    c09f:	4c 39 f0             	cmp    %r14,%rax
    c0a2:	7e 1c                	jle    c0c0 <fwp_read_exact+0x270>
    c0a4:	e9 a7 00 00 00       	jmp    c150 <fwp_read_exact+0x300>
    c0a9:	48 05 50 c3 00 00    	add    $0xc350,%rax
    c0af:	49 89 c6             	mov    %rax,%r14
    c0b2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c0b9:	1f 84 00 00 00 00 00 
    c0c0:	49 8b 47 40          	mov    0x40(%r15),%rax
    c0c4:	49 3b 87 80 00 00 00 	cmp    0x80(%r15),%rax
    c0cb:	0f 85 fa fe ff ff    	jne    bfcb <fwp_read_exact+0x17b>
    c0d1:	ff c5                	inc    %ebp
    c0d3:	41 8b 87 40 01 00 00 	mov    0x140(%r15),%eax
    c0da:	85 c0                	test   %eax,%eax
    c0dc:	74 92                	je     c070 <fwp_read_exact+0x220>
    c0de:	e9 e8 fe ff ff       	jmp    bfcb <fwp_read_exact+0x17b>
    c0e3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c0ea:	84 00 00 00 00 00 
    c0f0:	48 85 c0             	test   %rax,%rax
    c0f3:	74 5b                	je     c150 <fwp_read_exact+0x300>
    c0f5:	e8 86 6f ff ff       	call   3080 <__errno_location@plt>
    c0fa:	83 38 6e             	cmpl   $0x6e,(%rax)
    c0fd:	75 51                	jne    c150 <fwp_read_exact+0x300>
    c0ff:	44 89 64 24 18       	mov    %r12d,0x18(%rsp)
    c104:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%rsp)
    c10b:	00 
    c10c:	be 01 00 00 00       	mov    $0x1,%esi
    c111:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    c116:	31 d2                	xor    %edx,%edx
    c118:	e8 a3 72 ff ff       	call   33c0 <poll@plt>
    c11d:	85 c0                	test   %eax,%eax
    c11f:	7e 2f                	jle    c150 <fwp_read_exact+0x300>
    c121:	f6 44 24 1e 18       	testb  $0x18,0x1e(%rsp)
    c126:	0f 85 17 02 00 00    	jne    c343 <fwp_read_exact+0x4f3>
    c12c:	ba 01 00 00 00       	mov    $0x1,%edx
    c131:	44 89 e7             	mov    %r12d,%edi
    c134:	48 8d 74 24 17       	lea    0x17(%rsp),%rsi
    c139:	b9 42 00 00 00       	mov    $0x42,%ecx
    c13e:	e8 1d 6f ff ff       	call   3060 <recv@plt>
    c143:	48 85 c0             	test   %rax,%rax
    c146:	0f 84 f7 01 00 00    	je     c343 <fwp_read_exact+0x4f3>
    c14c:	0f 1f 40 00          	nopl   0x0(%rax)
    c150:	41 8b 8f c0 00 00 00 	mov    0xc0(%r15),%ecx
    c157:	b8 01 00 00 00       	mov    $0x1,%eax
    c15c:	41 87 87 c4 00 00 00 	xchg   %eax,0xc4(%r15)
    c163:	0f ae f0             	mfence
    c166:	49 8b 47 40          	mov    0x40(%r15),%rax
    c16a:	49 3b 87 80 00 00 00 	cmp    0x80(%r15),%rax
    c171:	0f 85 49 fe ff ff    	jne    bfc0 <fwp_read_exact+0x170>
    c177:	41 8b 87 40 01 00 00 	mov    0x140(%r15),%eax
    c17e:	85 c0                	test   %eax,%eax
    c180:	0f 85 3a fe ff ff    	jne    bfc0 <fwp_read_exact+0x170>
    c186:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
    c18d:	00 00 
    c18f:	48 c7 44 24 20 00 e1 	movq   $0x5f5e100,0x20(%rsp)
    c196:	f5 05 
    c198:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    c19f:	bf ca 00 00 00       	mov    $0xca,%edi
    c1a4:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
    c1a9:	31 d2                	xor    %edx,%edx
    c1ab:	4c 8d 44 24 18       	lea    0x18(%rsp),%r8
    c1b0:	45 31 c9             	xor    %r9d,%r9d
    c1b3:	31 c0                	xor    %eax,%eax
    c1b5:	e8 46 71 ff ff       	call   3300 <syscall@plt>
    c1ba:	41 c7 87 c4 00 00 00 	movl   $0x0,0xc4(%r15)
    c1c1:	00 00 00 00 
    c1c5:	49 8b 4f 40          	mov    0x40(%r15),%rcx
    c1c9:	49 3b 8f 80 00 00 00 	cmp    0x80(%r15),%rcx
    c1d0:	0f 85 f5 fd ff ff    	jne    bfcb <fwp_read_exact+0x17b>
    c1d6:	41 8b 8f 40 01 00 00 	mov    0x140(%r15),%ecx
    c1dd:	85 c9                	test   %ecx,%ecx
    c1df:	0f 84 0b ff ff ff    	je     c0f0 <fwp_read_exact+0x2a0>
    c1e5:	e9 e1 fd ff ff       	jmp    bfcb <fwp_read_exact+0x17b>
    c1ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    c1f0:	4c 8b 35 59 fd 02 00 	mov    0x2fd59(%rip),%r14        # 3bf50 <fwp_pi_pos>
    c1f7:	48 8b 05 5a fd 02 00 	mov    0x2fd5a(%rip),%rax        # 3bf58 <fwp_pi_len>
    c1fe:	49 39 c6             	cmp    %rax,%r14
    c201:	0f 85 00 01 00 00    	jne    c307 <fwp_read_exact+0x4b7>
    c207:	4c 8d 35 52 fd 02 00 	lea    0x2fd52(%rip),%r14        # 3bf60 <fwp_pi_buf>
    c20e:	66 90                	xchg   %ax,%ax
    c210:	8b 3d d6 fb 00 00    	mov    0xfbd6(%rip),%edi        # 1bdec <fwp_pi_sock>
    c216:	ba 00 00 01 00       	mov    $0x10000,%edx
    c21b:	4c 89 f6             	mov    %r14,%rsi
    c21e:	31 c9                	xor    %ecx,%ecx
    c220:	e8 3b 6e ff ff       	call   3060 <recv@plt>
    c225:	48 85 c0             	test   %rax,%rax
    c228:	0f 89 cd 00 00 00    	jns    c2fb <fwp_read_exact+0x4ab>
    c22e:	e8 4d 6e ff ff       	call   3080 <__errno_location@plt>
    c233:	83 38 04             	cmpl   $0x4,(%rax)
    c236:	74 d8                	je     c210 <fwp_read_exact+0x3c0>
    c238:	e9 06 01 00 00       	jmp    c343 <fwp_read_exact+0x4f3>
    c23d:	0f 1f 00             	nopl   (%rax)
    c240:	49 29 c6             	sub    %rax,%r14
    c243:	49 39 de             	cmp    %rbx,%r14
    c246:	4c 0f 43 f3          	cmovae %rbx,%r14
    c24a:	49 8b 5f 08          	mov    0x8(%r15),%rbx
    c24e:	48 8d 4b ff          	lea    -0x1(%rbx),%rcx
    c252:	48 21 c1             	and    %rax,%rcx
    c255:	48 29 cb             	sub    %rcx,%rbx
    c258:	49 39 de             	cmp    %rbx,%r14
    c25b:	49 0f 42 de          	cmovb  %r14,%rbx
    c25f:	4d 8d a7 00 10 00 00 	lea    0x1000(%r15),%r12
    c266:	49 8d 34 0f          	lea    (%r15,%rcx,1),%rsi
    c26a:	48 81 c6 00 10 00 00 	add    $0x1000,%rsi
    c271:	48 8b 6c 24 30       	mov    0x30(%rsp),%rbp
    c276:	48 89 ef             	mov    %rbp,%rdi
    c279:	48 89 da             	mov    %rbx,%rdx
    c27c:	e8 af 70 ff ff       	call   3330 <memcpy@plt>
    c281:	48 01 dd             	add    %rbx,%rbp
    c284:	4c 89 f2             	mov    %r14,%rdx
    c287:	48 29 da             	sub    %rbx,%rdx
    c28a:	48 89 ef             	mov    %rbp,%rdi
    c28d:	4c 89 e6             	mov    %r12,%rsi
    c290:	e8 9b 70 ff ff       	call   3330 <memcpy@plt>
    c295:	49 8b 8f 80 00 00 00 	mov    0x80(%r15),%rcx
    c29c:	4c 01 f1             	add    %r14,%rcx
    c29f:	49 89 8f 80 00 00 00 	mov    %rcx,0x80(%r15)
    c2a6:	0f ae f0             	mfence
    c2a9:	41 8b 8f 04 01 00 00 	mov    0x104(%r15),%ecx
    c2b0:	85 c9                	test   %ecx,%ecx
    c2b2:	74 35                	je     c2e9 <fwp_read_exact+0x499>
    c2b4:	f0 41 ff 87 00 01 00 	lock incl 0x100(%r15)
    c2bb:	00 
    c2bc:	49 81 c7 00 01 00 00 	add    $0x100,%r15
    c2c3:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    c2ca:	bf ca 00 00 00       	mov    $0xca,%edi
    c2cf:	4c 89 fe             	mov    %r15,%rsi
    c2d2:	ba 01 00 00 00       	mov    $0x1,%edx
    c2d7:	b9 ff ff ff 7f       	mov    $0x7fffffff,%ecx
    c2dc:	45 31 c0             	xor    %r8d,%r8d
    c2df:	45 31 c9             	xor    %r9d,%r9d
    c2e2:	31 c0                	xor    %eax,%eax
    c2e4:	e8 17 70 ff ff       	call   3300 <syscall@plt>
    c2e9:	4c 89 f0             	mov    %r14,%rax
    c2ec:	4c 8b 7c 24 38       	mov    0x38(%rsp),%r15
    c2f1:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    c2f6:	e9 61 fc ff ff       	jmp    bf5c <fwp_read_exact+0x10c>
    c2fb:	74 46                	je     c343 <fwp_read_exact+0x4f3>
    c2fd:	48 89 05 54 fc 02 00 	mov    %rax,0x2fc54(%rip)        # 3bf58 <fwp_pi_len>
    c304:	45 31 f6             	xor    %r14d,%r14d
    c307:	4c 29 f0             	sub    %r14,%rax
    c30a:	48 39 d8             	cmp    %rbx,%rax
    c30d:	48 0f 43 c3          	cmovae %rbx,%rax
    c311:	48 8d 0d 48 fc 02 00 	lea    0x2fc48(%rip),%rcx        # 3bf60 <fwp_pi_buf>
    c318:	4a 8d 34 31          	lea    (%rcx,%r14,1),%rsi
    c31c:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    c321:	48 89 c2             	mov    %rax,%rdx
    c324:	48 89 c3             	mov    %rax,%rbx
    c327:	e8 04 70 ff ff       	call   3330 <memcpy@plt>
    c32c:	48 89 d8             	mov    %rbx,%rax
    c32f:	49 01 de             	add    %rbx,%r14
    c332:	4c 89 35 17 fc 02 00 	mov    %r14,0x2fc17(%rip)        # 3bf50 <fwp_pi_pos>
    c339:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    c33e:	e9 19 fc ff ff       	jmp    bf5c <fwp_read_exact+0x10c>
    c343:	31 c0                	xor    %eax,%eax
    c345:	48 83 c4 48          	add    $0x48,%rsp
    c349:	5b                   	pop    %rbx
    c34a:	41 5c                	pop    %r12
    c34c:	41 5d                	pop    %r13
    c34e:	41 5e                	pop    %r14
    c350:	41 5f                	pop    %r15
    c352:	5d                   	pop    %rbp
    c353:	c3                   	ret
    c354:	b8 01 00 00 00       	mov    $0x1,%eax
    c359:	eb ea                	jmp    c345 <fwp_read_exact+0x4f5>
    c35b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000c360 <fwp_stdin_name_len>:
    c360:	41 57                	push   %r15
    c362:	41 56                	push   %r14
    c364:	53                   	push   %rbx
    c365:	48 83 ec 10          	sub    $0x10,%rsp
    c369:	48 89 fb             	mov    %rdi,%rbx
    c36c:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    c373:	49 c7 c6 f9 ff ff ff 	mov    $0xfffffffffffffff9,%r14
    c37a:	4c 8d 7c 24 0f       	lea    0xf(%rsp),%r15
    c37f:	90                   	nop
    c380:	be 01 00 00 00       	mov    $0x1,%esi
    c385:	4c 89 ff             	mov    %r15,%rdi
    c388:	e8 c3 fa ff ff       	call   be50 <fwp_read_exact>
    c38d:	85 c0                	test   %eax,%eax
    c38f:	74 38                	je     c3c9 <fwp_stdin_name_len+0x69>
    c391:	0f b6 44 24 0f       	movzbl 0xf(%rsp),%eax
    c396:	49 83 fe 38          	cmp    $0x38,%r14
    c39a:	75 07                	jne    c3a3 <fwp_stdin_name_len+0x43>
    c39c:	89 c1                	mov    %eax,%ecx
    c39e:	80 e1 7e             	and    $0x7e,%cl
    c3a1:	75 1f                	jne    c3c2 <fwp_stdin_name_len+0x62>
    c3a3:	49 83 c6 07          	add    $0x7,%r14
    c3a7:	89 c2                	mov    %eax,%edx
    c3a9:	83 e2 7f             	and    $0x7f,%edx
    c3ac:	44 89 f1             	mov    %r14d,%ecx
    c3af:	48 d3 e2             	shl    %cl,%rdx
    c3b2:	48 0b 13             	or     (%rbx),%rdx
    c3b5:	48 89 13             	mov    %rdx,(%rbx)
    c3b8:	84 c0                	test   %al,%al
    c3ba:	79 11                	jns    c3cd <fwp_stdin_name_len+0x6d>
    c3bc:	49 83 fe 38          	cmp    $0x38,%r14
    c3c0:	76 be                	jbe    c380 <fwp_stdin_name_len+0x20>
    c3c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    c3c7:	eb 13                	jmp    c3dc <fwp_stdin_name_len+0x7c>
    c3c9:	31 c0                	xor    %eax,%eax
    c3cb:	eb 0f                	jmp    c3dc <fwp_stdin_name_len+0x7c>
    c3cd:	31 c0                	xor    %eax,%eax
    c3cf:	48 81 fa 01 00 10 00 	cmp    $0x100001,%rdx
    c3d6:	83 d0 ff             	adc    $0xffffffff,%eax
    c3d9:	83 c8 01             	or     $0x1,%eax
    c3dc:	48 83 c4 10          	add    $0x10,%rsp
    c3e0:	5b                   	pop    %rbx
    c3e1:	41 5e                	pop    %r14
    c3e3:	41 5f                	pop    %r15
    c3e5:	c3                   	ret
    c3e6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    c3ed:	00 00 00 

000000000000c3f0 <fwp_pipe_in_offer>:
    c3f0:	55                   	push   %rbp
    c3f1:	41 56                	push   %r14
    c3f3:	53                   	push   %rbx
    c3f4:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
    c3fb:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
    c402:	00 
    c403:	31 ff                	xor    %edi,%edi
    c405:	e8 b6 70 ff ff       	call   34c0 <fstat@plt>
    c40a:	85 c0                	test   %eax,%eax
    c40c:	0f 85 29 01 00 00    	jne    c53b <fwp_pipe_in_offer+0x14b>
    c412:	b8 00 f0 00 00       	mov    $0xf000,%eax
    c417:	23 84 24 98 00 00 00 	and    0x98(%rsp),%eax
    c41e:	3d 00 10 00 00       	cmp    $0x1000,%eax
    c423:	0f 85 12 01 00 00    	jne    c53b <fwp_pipe_in_offer+0x14b>
    c429:	bf 01 00 00 00       	mov    $0x1,%edi
    c42e:	be 01 00 08 00       	mov    $0x80001,%esi
    c433:	31 d2                	xor    %edx,%edx
    c435:	e8 b6 70 ff ff       	call   34f0 <socket@plt>
    c43a:	85 c0                	test   %eax,%eax
    c43c:	0f 88 f9 00 00 00    	js     c53b <fwp_pipe_in_offer+0x14b>
    c442:	89 c3                	mov    %eax,%ebx
    c444:	0f 57 c0             	xorps  %xmm0,%xmm0
    c447:	0f 11 44 24 70       	movups %xmm0,0x70(%rsp)
    c44c:	0f 11 44 24 64       	movups %xmm0,0x64(%rsp)
    c451:	0f 11 44 24 54       	movups %xmm0,0x54(%rsp)
    c456:	0f 11 44 24 44       	movups %xmm0,0x44(%rsp)
    c45b:	0f 11 44 24 34       	movups %xmm0,0x34(%rsp)
    c460:	0f 11 44 24 24       	movups %xmm0,0x24(%rsp)
    c465:	0f 11 44 24 14       	movups %xmm0,0x14(%rsp)
    c46a:	66 c7 44 24 12 01 00 	movw   $0x1,0x12(%rsp)
    c471:	48 8d 7c 24 15       	lea    0x15(%rsp),%rdi
    c476:	48 8b 8c 24 80 00 00 	mov    0x80(%rsp),%rcx
    c47d:	00 
    c47e:	4c 8b 84 24 88 00 00 	mov    0x88(%rsp),%r8
    c485:	00 
    c486:	48 8d 15 87 a2 00 00 	lea    0xa287(%rip),%rdx        # 16714 <exec_in_fp0+0xea4>
    c48d:	be 6b 00 00 00       	mov    $0x6b,%esi
    c492:	31 c0                	xor    %eax,%eax
    c494:	e8 37 6d ff ff       	call   31d0 <snprintf@plt>
    c499:	89 c5                	mov    %eax,%ebp
    c49b:	83 c5 03             	add    $0x3,%ebp
    c49e:	48 8d 3d 5b a2 00 00 	lea    0xa25b(%rip),%rdi        # 16700 <exec_in_fp0+0xe90>
    c4a5:	e8 86 6b ff ff       	call   3030 <getenv@plt>
    c4aa:	48 85 c0             	test   %rax,%rax
    c4ad:	74 36                	je     c4e5 <fwp_pipe_in_offer+0xf5>
    c4af:	49 89 c6             	mov    %rax,%r14
    c4b2:	48 8d 35 55 a2 00 00 	lea    0xa255(%rip),%rsi        # 1670e <exec_in_fp0+0xe9e>
    c4b9:	48 89 c7             	mov    %rax,%rdi
    c4bc:	e8 0f 6e ff ff       	call   32d0 <strcmp@plt>
    c4c1:	c7 44 24 0c 46 57 50 	movl   $0x54505746,0xc(%rsp)
    c4c8:	54 
    c4c9:	85 c0                	test   %eax,%eax
    c4cb:	74 27                	je     c4f4 <fwp_pipe_in_offer+0x104>
    c4cd:	48 8d 35 ff a2 00 00 	lea    0xa2ff(%rip),%rsi        # 167d3 <exec_in_fp0+0xf63>
    c4d4:	4c 89 f7             	mov    %r14,%rdi
    c4d7:	e8 f4 6d ff ff       	call   32d0 <strcmp@plt>
    c4dc:	83 f8 01             	cmp    $0x1,%eax
    c4df:	b0 02                	mov    $0x2,%al
    c4e1:	1c 00                	sbb    $0x0,%al
    c4e3:	eb 0a                	jmp    c4ef <fwp_pipe_in_offer+0xff>
    c4e5:	c7 44 24 0c 46 57 50 	movl   $0x54505746,0xc(%rsp)
    c4ec:	54 
    c4ed:	b0 02                	mov    $0x2,%al
    c4ef:	45 31 f6             	xor    %r14d,%r14d
    c4f2:	eb 05                	jmp    c4f9 <fwp_pipe_in_offer+0x109>
    c4f4:	31 c0                	xor    %eax,%eax
    c4f6:	41 b6 01             	mov    $0x1,%r14b
    c4f9:	88 44 24 10          	mov    %al,0x10(%rsp)
    c4fd:	48 8d 74 24 12       	lea    0x12(%rsp),%rsi
    c502:	89 df                	mov    %ebx,%edi
    c504:	89 ea                	mov    %ebp,%edx
    c506:	e8 65 6f ff ff       	call   3470 <connect@plt>
    c50b:	85 c0                	test   %eax,%eax
    c50d:	75 25                	jne    c534 <fwp_pipe_in_offer+0x144>
    c50f:	48 8d 74 24 0c       	lea    0xc(%rsp),%rsi
    c514:	ba 05 00 00 00       	mov    $0x5,%edx
    c519:	89 df                	mov    %ebx,%edi
    c51b:	b9 00 40 00 00       	mov    $0x4000,%ecx
    c520:	e8 7b 6c ff ff       	call   31a0 <send@plt>
    c525:	48 83 f8 05          	cmp    $0x5,%rax
    c529:	0f 94 c0             	sete   %al
    c52c:	41 f6 d6             	not    %r14b
    c52f:	41 84 c6             	test   %al,%r14b
    c532:	75 13                	jne    c547 <fwp_pipe_in_offer+0x157>
    c534:	89 df                	mov    %ebx,%edi
    c536:	e8 f5 6c ff ff       	call   3230 <close@plt>
    c53b:	48 81 c4 10 01 00 00 	add    $0x110,%rsp
    c542:	5b                   	pop    %rbx
    c543:	41 5e                	pop    %r14
    c545:	5d                   	pop    %rbp
    c546:	c3                   	ret
    c547:	89 1d 9f f8 00 00    	mov    %ebx,0xf89f(%rip)        # 1bdec <fwp_pi_sock>
    c54d:	eb ec                	jmp    c53b <fwp_pipe_in_offer+0x14b>
    c54f:	90                   	nop

000000000000c550 <fwp_decode>:
    c550:	55                   	push   %rbp
    c551:	41 57                	push   %r15
    c553:	41 56                	push   %r14
    c555:	41 55                	push   %r13
    c557:	41 54                	push   %r12
    c559:	53                   	push   %rbx
    c55a:	48 83 ec 38          	sub    $0x38,%rsp
    c55e:	8b 06                	mov    (%rsi),%eax
    c560:	45 31 e4             	xor    %r12d,%r12d
    c563:	48 83 f8 15          	cmp    $0x15,%rax
    c567:	0f 87 f3 00 00 00    	ja     c660 <fwp_decode+0x110>
    c56d:	48 89 d5             	mov    %rdx,%rbp
    c570:	49 89 f7             	mov    %rsi,%r15
    c573:	49 89 fe             	mov    %rdi,%r14
    c576:	48 8d 0d 63 8c 00 00 	lea    0x8c63(%rip),%rcx        # 151e0 <_IO_stdin_used+0x1e0>
    c57d:	48 63 14 81          	movslq (%rcx,%rax,4),%rdx
    c581:	48 01 ca             	add    %rcx,%rdx
    c584:	ff e2                	jmp    *%rdx
    c586:	31 c9                	xor    %ecx,%ecx
    c588:	83 f8 0a             	cmp    $0xa,%eax
    c58b:	0f 95 c1             	setne  %cl
    c58e:	4c 8d 04 8d 04 00 00 	lea    0x4(,%rcx,4),%r8
    c595:	00 
    c596:	49 8b 46 08          	mov    0x8(%r14),%rax
    c59a:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    c59e:	48 29 f8             	sub    %rdi,%rax
    c5a1:	4c 39 c0             	cmp    %r8,%rax
    c5a4:	0f 82 b6 00 00 00    	jb     c660 <fwp_decode+0x110>
    c5aa:	49 8b 16             	mov    (%r14),%rdx
    c5ad:	4a 8d 04 07          	lea    (%rdi,%r8,1),%rax
    c5b1:	49 89 46 10          	mov    %rax,0x10(%r14)
    c5b5:	44 89 c6             	mov    %r8d,%esi
    c5b8:	83 e6 03             	and    $0x3,%esi
    c5bb:	49 83 f8 04          	cmp    $0x4,%r8
    c5bf:	73 08                	jae    c5c9 <fwp_decode+0x79>
    c5c1:	45 31 d2             	xor    %r10d,%r10d
    c5c4:	45 31 c9             	xor    %r9d,%r9d
    c5c7:	eb 5e                	jmp    c627 <fwp_decode+0xd7>
    c5c9:	41 83 e0 fc          	and    $0xfffffffc,%r8d
    c5cd:	4c 8d 1c 17          	lea    (%rdi,%rdx,1),%r11
    c5d1:	49 83 c3 03          	add    $0x3,%r11
    c5d5:	b8 18 00 00 00       	mov    $0x18,%eax
    c5da:	45 31 d2             	xor    %r10d,%r10d
    c5dd:	45 31 c9             	xor    %r9d,%r9d
    c5e0:	43 0f b6 5c 13 fd    	movzbl -0x3(%r11,%r10,1),%ebx
    c5e6:	8d 48 e8             	lea    -0x18(%rax),%ecx
    c5e9:	48 d3 e3             	shl    %cl,%rbx
    c5ec:	47 0f b6 74 13 fe    	movzbl -0x2(%r11,%r10,1),%r14d
    c5f2:	8d 48 f0             	lea    -0x10(%rax),%ecx
    c5f5:	49 d3 e6             	shl    %cl,%r14
    c5f8:	47 0f b6 7c 13 ff    	movzbl -0x1(%r11,%r10,1),%r15d
    c5fe:	8d 48 f8             	lea    -0x8(%rax),%ecx
    c601:	49 d3 e7             	shl    %cl,%r15
    c604:	4c 09 cb             	or     %r9,%rbx
    c607:	4d 09 f7             	or     %r14,%r15
    c60a:	49 09 df             	or     %rbx,%r15
    c60d:	47 0f b6 0c 13       	movzbl (%r11,%r10,1),%r9d
    c612:	89 c1                	mov    %eax,%ecx
    c614:	49 d3 e1             	shl    %cl,%r9
    c617:	4d 09 f9             	or     %r15,%r9
    c61a:	49 83 c2 04          	add    $0x4,%r10
    c61e:	48 83 c0 20          	add    $0x20,%rax
    c622:	4d 39 d0             	cmp    %r10,%r8
    c625:	75 b9                	jne    c5e0 <fwp_decode+0x90>
    c627:	48 85 f6             	test   %rsi,%rsi
    c62a:	74 2a                	je     c656 <fwp_decode+0x106>
    c62c:	4a 8d 0c d5 00 00 00 	lea    0x0(,%r10,8),%rcx
    c633:	00 
    c634:	4c 01 d7             	add    %r10,%rdi
    c637:	48 01 fa             	add    %rdi,%rdx
    c63a:	31 c0                	xor    %eax,%eax
    c63c:	0f 1f 40 00          	nopl   0x0(%rax)
    c640:	0f b6 3c 02          	movzbl (%rdx,%rax,1),%edi
    c644:	48 d3 e7             	shl    %cl,%rdi
    c647:	49 09 f9             	or     %rdi,%r9
    c64a:	48 ff c0             	inc    %rax
    c64d:	48 83 c1 08          	add    $0x8,%rcx
    c651:	48 39 c6             	cmp    %rax,%rsi
    c654:	75 ea                	jne    c640 <fwp_decode+0xf0>
    c656:	4c 89 4d 00          	mov    %r9,0x0(%rbp)
    c65a:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    c660:	44 89 e0             	mov    %r12d,%eax
    c663:	48 83 c4 38          	add    $0x38,%rsp
    c667:	5b                   	pop    %rbx
    c668:	41 5c                	pop    %r12
    c66a:	41 5d                	pop    %r13
    c66c:	41 5e                	pop    %r14
    c66e:	41 5f                	pop    %r15
    c670:	5d                   	pop    %rbp
    c671:	c3                   	ret
    c672:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    c677:	4c 89 f7             	mov    %r14,%rdi
    c67a:	e8 51 71 00 00       	call   137d0 <rd_leb>
    c67f:	85 c0                	test   %eax,%eax
    c681:	74 dd                	je     c660 <fwp_decode+0x110>
    c683:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
    c688:	49 8b 4e 08          	mov    0x8(%r14),%rcx
    c68c:	49 39 cd             	cmp    %rcx,%r13
    c68f:	77 cf                	ja     c660 <fwp_decode+0x110>
    c691:	49 8b 46 10          	mov    0x10(%r14),%rax
    c695:	48 29 c1             	sub    %rax,%rcx
    c698:	4c 39 e9             	cmp    %r13,%rcx
    c69b:	72 c3                	jb     c660 <fwp_decode+0x110>
    c69d:	48 89 eb             	mov    %rbp,%rbx
    c6a0:	49 8b 2e             	mov    (%r14),%rbp
    c6a3:	48 01 c5             	add    %rax,%rbp
    c6a6:	4c 01 e8             	add    %r13,%rax
    c6a9:	49 89 46 10          	mov    %rax,0x10(%r14)
    c6ad:	41 83 3f 0c          	cmpl   $0xc,(%r15)
    c6b1:	75 0f                	jne    c6c2 <fwp_decode+0x172>
    c6b3:	48 89 ef             	mov    %rbp,%rdi
    c6b6:	4c 89 ee             	mov    %r13,%rsi
    c6b9:	e8 d2 08 00 00       	call   cf90 <fwp_valid_utf8>
    c6be:	85 c0                	test   %eax,%eax
    c6c0:	74 9e                	je     c660 <fwp_decode+0x110>
    c6c2:	48 89 ef             	mov    %rbp,%rdi
    c6c5:	4c 89 ee             	mov    %r13,%rsi
    c6c8:	e8 23 0a 00 00       	call   d0f0 <fwp_str_new>
    c6cd:	48 89 03             	mov    %rax,(%rbx)
    c6d0:	eb 88                	jmp    c65a <fwp_decode+0x10a>
    c6d2:	49 8b 46 10          	mov    0x10(%r14),%rax
    c6d6:	49 39 46 08          	cmp    %rax,0x8(%r14)
    c6da:	74 84                	je     c660 <fwp_decode+0x110>
    c6dc:	49 8b 0e             	mov    (%r14),%rcx
    c6df:	48 8d 50 01          	lea    0x1(%rax),%rdx
    c6e3:	49 89 56 10          	mov    %rdx,0x10(%r14)
    c6e7:	48 0f be 04 01       	movsbq (%rcx,%rax,1),%rax
    c6ec:	48 89 45 00          	mov    %rax,0x0(%rbp)
    c6f0:	e9 65 ff ff ff       	jmp    c65a <fwp_decode+0x10a>
    c6f5:	49 8b 76 08          	mov    0x8(%r14),%rsi
    c6f9:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    c6fd:	48 89 f2             	mov    %rsi,%rdx
    c700:	48 29 ca             	sub    %rcx,%rdx
    c703:	48 83 fa 08          	cmp    $0x8,%rdx
    c707:	0f 82 53 ff ff ff    	jb     c660 <fwp_decode+0x110>
    c70d:	49 8b 16             	mov    (%r14),%rdx
    c710:	48 8d 79 08          	lea    0x8(%rcx),%rdi
    c714:	49 89 7e 10          	mov    %rdi,0x10(%r14)
    c718:	48 29 fe             	sub    %rdi,%rsi
    c71b:	48 83 fe 08          	cmp    $0x8,%rsi
    c71f:	0f 82 3b ff ff ff    	jb     c660 <fwp_decode+0x110>
    c725:	48 8b 3c 0a          	mov    (%rdx,%rcx,1),%rdi
    c729:	48 8d 71 10          	lea    0x10(%rcx),%rsi
    c72d:	49 89 76 10          	mov    %rsi,0x10(%r14)
    c731:	48 8b 74 0a 08       	mov    0x8(%rdx,%rcx,1),%rsi
    c736:	83 f8 04             	cmp    $0x4,%eax
    c739:	0f 85 e7 03 00 00    	jne    cb26 <fwp_decode+0x5d6>
    c73f:	e8 dc 3b 00 00       	call   10320 <fwp_box_i128>
    c744:	48 89 45 00          	mov    %rax,0x0(%rbp)
    c748:	e9 0d ff ff ff       	jmp    c65a <fwp_decode+0x10a>
    c74d:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    c752:	49 8b 6f 38          	mov    0x38(%r15),%rbp
    c756:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    c75b:	4c 89 f7             	mov    %r14,%rdi
    c75e:	e8 6d 70 00 00       	call   137d0 <rd_leb>
    c763:	85 c0                	test   %eax,%eax
    c765:	0f 84 f5 fe ff ff    	je     c660 <fwp_decode+0x110>
    c76b:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
    c770:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    c777:	ff ff 1f 
    c77a:	49 39 c5             	cmp    %rax,%r13
    c77d:	0f 87 dd fe ff ff    	ja     c660 <fwp_decode+0x110>
    c783:	45 31 e4             	xor    %r12d,%r12d
    c786:	48 89 ef             	mov    %rbp,%rdi
    c789:	31 f6                	xor    %esi,%esi
    c78b:	e8 20 72 00 00       	call   139b0 <fwp_wire_empty_inner>
    c790:	85 c0                	test   %eax,%eax
    c792:	75 0a                	jne    c79e <fwp_decode+0x24e>
    c794:	4d 3b 6e 08          	cmp    0x8(%r14),%r13
    c798:	0f 87 c2 fe ff ff    	ja     c660 <fwp_decode+0x110>
    c79e:	41 83 3f 11          	cmpl   $0x11,(%r15)
    c7a2:	0f 85 fe 02 00 00    	jne    caa6 <fwp_decode+0x556>
    c7a8:	49 8b 77 38          	mov    0x38(%r15),%rsi
    c7ac:	4c 89 ef             	mov    %r13,%rdi
    c7af:	e8 4c 90 ff ff       	call   5800 <fwp_array_new_packed>
    c7b4:	49 89 c4             	mov    %rax,%r12
    c7b7:	4d 85 ed             	test   %r13,%r13
    c7ba:	0f 84 2e 04 00 00    	je     cbee <fwp_decode+0x69e>
    c7c0:	31 ed                	xor    %ebp,%ebp
    c7c2:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    c7c7:	eb 11                	jmp    c7da <fwp_decode+0x28a>
    c7c9:	49 89 44 ec 08       	mov    %rax,0x8(%r12,%rbp,8)
    c7ce:	48 ff c5             	inc    %rbp
    c7d1:	49 39 ed             	cmp    %rbp,%r13
    c7d4:	0f 84 14 04 00 00    	je     cbee <fwp_decode+0x69e>
    c7da:	49 8b 77 38          	mov    0x38(%r15),%rsi
    c7de:	4c 89 f7             	mov    %r14,%rdi
    c7e1:	48 89 da             	mov    %rbx,%rdx
    c7e4:	e8 67 fd ff ff       	call   c550 <fwp_decode>
    c7e9:	85 c0                	test   %eax,%eax
    c7eb:	0f 84 f2 05 00 00    	je     cde3 <fwp_decode+0x893>
    c7f1:	49 83 3c 24 00       	cmpq   $0x0,(%r12)
    c7f6:	0f 88 ef 05 00 00    	js     cdeb <fwp_decode+0x89b>
    c7fc:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    c801:	49 8b 4f 38          	mov    0x38(%r15),%rcx
    c805:	48 85 c9             	test   %rcx,%rcx
    c808:	74 bf                	je     c7c9 <fwp_decode+0x279>
    c80a:	8b 09                	mov    (%rcx),%ecx
    c80c:	83 f9 0a             	cmp    $0xa,%ecx
    c80f:	77 b8                	ja     c7c9 <fwp_decode+0x279>
    c811:	ba 84 04 00 00       	mov    $0x484,%edx
    c816:	0f a3 ca             	bt     %ecx,%edx
    c819:	72 1c                	jb     c837 <fwp_decode+0x2e7>
    c81b:	ba 21 00 00 00       	mov    $0x21,%edx
    c820:	0f a3 ca             	bt     %ecx,%edx
    c823:	72 19                	jb     c83e <fwp_decode+0x2ee>
    c825:	ba 42 00 00 00       	mov    $0x42,%edx
    c82a:	0f a3 ca             	bt     %ecx,%edx
    c82d:	73 9a                	jae    c7c9 <fwp_decode+0x279>
    c82f:	66 41 89 44 6c 08    	mov    %ax,0x8(%r12,%rbp,2)
    c835:	eb 97                	jmp    c7ce <fwp_decode+0x27e>
    c837:	41 89 44 ac 08       	mov    %eax,0x8(%r12,%rbp,4)
    c83c:	eb 90                	jmp    c7ce <fwp_decode+0x27e>
    c83e:	41 88 44 2c 08       	mov    %al,0x8(%r12,%rbp,1)
    c843:	eb 89                	jmp    c7ce <fwp_decode+0x27e>
    c845:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    c84a:	4c 89 f7             	mov    %r14,%rdi
    c84d:	e8 7e 6f 00 00       	call   137d0 <rd_leb>
    c852:	85 c0                	test   %eax,%eax
    c854:	0f 84 06 fe ff ff    	je     c660 <fwp_decode+0x110>
    c85a:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    c85f:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
    c864:	49 63 47 10          	movslq 0x10(%r15),%rax
    c868:	49 39 c5             	cmp    %rax,%r13
    c86b:	0f 83 ef fd ff ff    	jae    c660 <fwp_decode+0x110>
    c871:	49 8b 47 28          	mov    0x28(%r15),%rax
    c875:	4a 63 1c a8          	movslq (%rax,%r13,4),%rbx
    c879:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    c880:	00 
    c881:	e8 4a b9 ff ff       	call   81d0 <fwp_alloc>
    c886:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    c88b:	89 d8                	mov    %ebx,%eax
    c88d:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    c892:	48 85 db             	test   %rbx,%rbx
    c895:	7e 40                	jle    c8d7 <fwp_decode+0x387>
    c897:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    c89c:	48 8d 1c c5 00 00 00 	lea    0x0(,%rax,8),%rbx
    c8a3:	00 
    c8a4:	45 31 e4             	xor    %r12d,%r12d
    c8a7:	31 ed                	xor    %ebp,%ebp
    c8a9:	49 8b 47 30          	mov    0x30(%r15),%rax
    c8ad:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    c8b1:	48 8b 34 28          	mov    (%rax,%rbp,1),%rsi
    c8b5:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    c8ba:	48 8d 14 28          	lea    (%rax,%rbp,1),%rdx
    c8be:	4c 89 f7             	mov    %r14,%rdi
    c8c1:	e8 8a fc ff ff       	call   c550 <fwp_decode>
    c8c6:	85 c0                	test   %eax,%eax
    c8c8:	0f 84 92 fd ff ff    	je     c660 <fwp_decode+0x110>
    c8ce:	48 83 c5 08          	add    $0x8,%rbp
    c8d2:	48 39 eb             	cmp    %rbp,%rbx
    c8d5:	75 d2                	jne    c8a9 <fwp_decode+0x359>
    c8d7:	44 89 ef             	mov    %r13d,%edi
    c8da:	48 8b 74 24 28       	mov    0x28(%rsp),%rsi
    c8df:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
    c8e4:	e8 27 0d 00 00       	call   d610 <fwp_data>
    c8e9:	e9 e8 04 00 00       	jmp    cdd6 <fwp_decode+0x886>
    c8ee:	41 b8 01 00 00 00    	mov    $0x1,%r8d
    c8f4:	e9 9d fc ff ff       	jmp    c596 <fwp_decode+0x46>
    c8f9:	41 b8 02 00 00 00    	mov    $0x2,%r8d
    c8ff:	e9 92 fc ff ff       	jmp    c596 <fwp_decode+0x46>
    c904:	49 8b 4e 08          	mov    0x8(%r14),%rcx
    c908:	49 8b 46 10          	mov    0x10(%r14),%rax
    c90c:	48 29 c1             	sub    %rax,%rcx
    c90f:	48 83 f9 02          	cmp    $0x2,%rcx
    c913:	0f 82 47 fd ff ff    	jb     c660 <fwp_decode+0x110>
    c919:	49 8b 0e             	mov    (%r14),%rcx
    c91c:	48 8d 50 02          	lea    0x2(%rax),%rdx
    c920:	49 89 56 10          	mov    %rdx,0x10(%r14)
    c924:	0f b6 14 01          	movzbl (%rcx,%rax,1),%edx
    c928:	0f b6 44 01 01       	movzbl 0x1(%rcx,%rax,1),%eax
    c92d:	48 c1 e0 38          	shl    $0x38,%rax
    c931:	48 c1 e2 30          	shl    $0x30,%rdx
    c935:	48 09 c2             	or     %rax,%rdx
    c938:	48 c1 fa 30          	sar    $0x30,%rdx
    c93c:	48 89 55 00          	mov    %rdx,0x0(%rbp)
    c940:	e9 15 fd ff ff       	jmp    c65a <fwp_decode+0x10a>
    c945:	49 8b 4e 08          	mov    0x8(%r14),%rcx
    c949:	49 8b 46 10          	mov    0x10(%r14),%rax
    c94d:	48 29 c1             	sub    %rax,%rcx
    c950:	48 83 f9 04          	cmp    $0x4,%rcx
    c954:	0f 82 06 fd ff ff    	jb     c660 <fwp_decode+0x110>
    c95a:	49 8b 0e             	mov    (%r14),%rcx
    c95d:	48 8d 50 04          	lea    0x4(%rax),%rdx
    c961:	49 89 56 10          	mov    %rdx,0x10(%r14)
    c965:	0f b6 14 01          	movzbl (%rcx,%rax,1),%edx
    c969:	0f b6 74 01 01       	movzbl 0x1(%rcx,%rax,1),%esi
    c96e:	0f b6 7c 01 02       	movzbl 0x2(%rcx,%rax,1),%edi
    c973:	0f b6 44 01 03       	movzbl 0x3(%rcx,%rax,1),%eax
    c978:	48 c1 e0 38          	shl    $0x38,%rax
    c97c:	48 c1 e7 30          	shl    $0x30,%rdi
    c980:	48 c1 e6 28          	shl    $0x28,%rsi
    c984:	48 c1 e2 20          	shl    $0x20,%rdx
    c988:	48 09 f2             	or     %rsi,%rdx
    c98b:	48 09 fa             	or     %rdi,%rdx
    c98e:	48 09 c2             	or     %rax,%rdx
    c991:	48 c1 fa 20          	sar    $0x20,%rdx
    c995:	48 89 55 00          	mov    %rdx,0x0(%rbp)
    c999:	e9 bc fc ff ff       	jmp    c65a <fwp_decode+0x10a>
    c99e:	41 b8 04 00 00 00    	mov    $0x4,%r8d
    c9a4:	e9 ed fb ff ff       	jmp    c596 <fwp_decode+0x46>
    c9a9:	49 8b 7f 40          	mov    0x40(%r15),%rdi
    c9ad:	31 f6                	xor    %esi,%esi
    c9af:	e8 fc 6f 00 00       	call   139b0 <fwp_wire_empty_inner>
    c9b4:	85 c0                	test   %eax,%eax
    c9b6:	0f 95 c3             	setne  %bl
    c9b9:	eb 02                	jmp    c9bd <fwp_decode+0x46d>
    c9bb:	b3 01                	mov    $0x1,%bl
    c9bd:	4d 8b 6f 38          	mov    0x38(%r15),%r13
    c9c1:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    c9c6:	4c 89 f7             	mov    %r14,%rdi
    c9c9:	e8 02 6e 00 00       	call   137d0 <rd_leb>
    c9ce:	85 c0                	test   %eax,%eax
    c9d0:	0f 84 8a fc ff ff    	je     c660 <fwp_decode+0x110>
    c9d6:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    c9db:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
    c9e0:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    c9e7:	ff ff 1f 
    c9ea:	48 39 c5             	cmp    %rax,%rbp
    c9ed:	0f 87 6d fc ff ff    	ja     c660 <fwp_decode+0x110>
    c9f3:	45 31 e4             	xor    %r12d,%r12d
    c9f6:	4c 89 ef             	mov    %r13,%rdi
    c9f9:	31 f6                	xor    %esi,%esi
    c9fb:	e8 b0 6f 00 00       	call   139b0 <fwp_wire_empty_inner>
    ca00:	85 c0                	test   %eax,%eax
    ca02:	0f 84 2c 01 00 00    	je     cb34 <fwp_decode+0x5e4>
    ca08:	48 83 fd 02          	cmp    $0x2,%rbp
    ca0c:	0f 93 c0             	setae  %al
    ca0f:	84 d8                	test   %bl,%al
    ca11:	0f 85 49 fc ff ff    	jne    c660 <fwp_decode+0x110>
    ca17:	e9 22 01 00 00       	jmp    cb3e <fwp_decode+0x5ee>
    ca1c:	49 63 7f 10          	movslq 0x10(%r15),%rdi
    ca20:	48 85 ff             	test   %rdi,%rdi
    ca23:	74 74                	je     ca99 <fwp_decode+0x549>
    ca25:	48 c1 e7 03          	shl    $0x3,%rdi
    ca29:	48 ff 05 78 f4 00 00 	incq   0xf478(%rip)        # 1bea8 <measured_calls>
    ca30:	48 01 3d 79 f4 00 00 	add    %rdi,0xf479(%rip)        # 1beb0 <measured_bytes>
    ca37:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    ca3e:	0f 87 9b 01 00 00    	ja     cbdf <fwp_decode+0x68f>
    ca44:	48 8d 4f 0f          	lea    0xf(%rdi),%rcx
    ca48:	48 c1 e9 04          	shr    $0x4,%rcx
    ca4c:	48 8d 05 35 d8 00 00 	lea    0xd835(%rip),%rax        # 1a288 <fwp_gc>
    ca53:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    ca5a:	00 
    ca5b:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    ca62:	48 29 15 1f d8 00 00 	sub    %rdx,0xd81f(%rip)        # 1a288 <fwp_gc>
    ca69:	0f 88 70 01 00 00    	js     cbdf <fwp_decode+0x68f>
    ca6f:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    ca73:	48 8d 34 c8          	lea    (%rax,%rcx,8),%rsi
    ca77:	48 81 c6 88 07 00 00 	add    $0x788,%rsi
    ca7e:	4c 8b 2e             	mov    (%rsi),%r13
    ca81:	4d 85 ed             	test   %r13,%r13
    ca84:	0f 84 3d 01 00 00    	je     cbc7 <fwp_decode+0x677>
    ca8a:	49 8b 45 00          	mov    0x0(%r13),%rax
    ca8e:	48 f7 d0             	not    %rax
    ca91:	48 89 06             	mov    %rax,(%rsi)
    ca94:	e9 80 01 00 00       	jmp    cc19 <fwp_decode+0x6c9>
    ca99:	48 c7 45 00 00 00 00 	movq   $0x0,0x0(%rbp)
    caa0:	00 
    caa1:	e9 b4 fb ff ff       	jmp    c65a <fwp_decode+0x10a>
    caa6:	4a 8d 3c ed 08 00 00 	lea    0x8(,%r13,8),%rdi
    caad:	00 
    caae:	48 ff 05 f3 f3 00 00 	incq   0xf3f3(%rip)        # 1bea8 <measured_calls>
    cab5:	48 01 3d f4 f3 00 00 	add    %rdi,0xf3f4(%rip)        # 1beb0 <measured_bytes>
    cabc:	49 81 fd ff 07 00 00 	cmp    $0x7ff,%r13
    cac3:	0f 87 6c 02 00 00    	ja     cd35 <fwp_decode+0x7e5>
    cac9:	4a 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%rcx
    cad0:	00 
    cad1:	48 83 c1 17          	add    $0x17,%rcx
    cad5:	48 c1 e9 04          	shr    $0x4,%rcx
    cad9:	48 8d 05 a8 d7 00 00 	lea    0xd7a8(%rip),%rax        # 1a288 <fwp_gc>
    cae0:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    cae7:	00 
    cae8:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    caef:	48 29 15 92 d7 00 00 	sub    %rdx,0xd792(%rip)        # 1a288 <fwp_gc>
    caf6:	0f 88 39 02 00 00    	js     cd35 <fwp_decode+0x7e5>
    cafc:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    cb00:	48 8d 34 c8          	lea    (%rax,%rcx,8),%rsi
    cb04:	48 81 c6 88 07 00 00 	add    $0x788,%rsi
    cb0b:	4c 8b 26             	mov    (%rsi),%r12
    cb0e:	4d 85 e4             	test   %r12,%r12
    cb11:	0f 84 06 02 00 00    	je     cd1d <fwp_decode+0x7cd>
    cb17:	49 8b 04 24          	mov    (%r12),%rax
    cb1b:	48 f7 d0             	not    %rax
    cb1e:	48 89 06             	mov    %rax,(%rsi)
    cb21:	e9 74 02 00 00       	jmp    cd9a <fwp_decode+0x84a>
    cb26:	e8 45 37 00 00       	call   10270 <fwp_box_u128>
    cb2b:	48 89 45 00          	mov    %rax,0x0(%rbp)
    cb2f:	e9 26 fb ff ff       	jmp    c65a <fwp_decode+0x10a>
    cb34:	49 3b 6e 08          	cmp    0x8(%r14),%rbp
    cb38:	0f 87 22 fb ff ff    	ja     c660 <fwp_decode+0x110>
    cb3e:	84 db                	test   %bl,%bl
    cb40:	75 0a                	jne    cb4c <fwp_decode+0x5fc>
    cb42:	49 3b 6e 08          	cmp    0x8(%r14),%rbp
    cb46:	0f 87 14 fb ff ff    	ja     c660 <fwp_decode+0x110>
    cb4c:	4c 8d 25 ad f3 01 00 	lea    0x1f3ad(%rip),%r12        # 2bf00 <fwp_empty_map>
    cb53:	48 85 ed             	test   %rbp,%rbp
    cb56:	0f 84 9f 00 00 00    	je     cbfb <fwp_decode+0x6ab>
    cb5c:	4c 8d 6c 24 20       	lea    0x20(%rsp),%r13
    cb61:	48 8d 5c 24 30       	lea    0x30(%rsp),%rbx
    cb66:	eb 1b                	jmp    cb83 <fwp_decode+0x633>
    cb68:	31 f6                	xor    %esi,%esi
    cb6a:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    cb6f:	49 8b 4f 38          	mov    0x38(%r15),%rcx
    cb73:	4c 89 e2             	mov    %r12,%rdx
    cb76:	e8 35 33 00 00       	call   feb0 <fwp_p_map_insert>
    cb7b:	49 89 c4             	mov    %rax,%r12
    cb7e:	48 ff cd             	dec    %rbp
    cb81:	74 78                	je     cbfb <fwp_decode+0x6ab>
    cb83:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
    cb8a:	00 00 
    cb8c:	49 8b 77 38          	mov    0x38(%r15),%rsi
    cb90:	4c 89 f7             	mov    %r14,%rdi
    cb93:	4c 89 ea             	mov    %r13,%rdx
    cb96:	e8 b5 f9 ff ff       	call   c550 <fwp_decode>
    cb9b:	85 c0                	test   %eax,%eax
    cb9d:	0f 84 40 02 00 00    	je     cde3 <fwp_decode+0x893>
    cba3:	41 83 3f 12          	cmpl   $0x12,(%r15)
    cba7:	75 bf                	jne    cb68 <fwp_decode+0x618>
    cba9:	49 8b 77 40          	mov    0x40(%r15),%rsi
    cbad:	4c 89 f7             	mov    %r14,%rdi
    cbb0:	48 89 da             	mov    %rbx,%rdx
    cbb3:	e8 98 f9 ff ff       	call   c550 <fwp_decode>
    cbb8:	85 c0                	test   %eax,%eax
    cbba:	0f 84 23 02 00 00    	je     cde3 <fwp_decode+0x893>
    cbc0:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    cbc5:	eb a3                	jmp    cb6a <fwp_decode+0x61a>
    cbc7:	4c 8b ac c8 90 07 00 	mov    0x790(%rax,%rcx,8),%r13
    cbce:	00 
    cbcf:	48 8b b4 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%rsi
    cbd6:	00 
    cbd7:	4c 29 ee             	sub    %r13,%rsi
    cbda:	48 39 d6             	cmp    %rdx,%rsi
    cbdd:	73 29                	jae    cc08 <fwp_decode+0x6b8>
    cbdf:	be 02 00 00 00       	mov    $0x2,%esi
    cbe4:	e8 97 b6 ff ff       	call   8280 <fwp_gc_alloc_slow>
    cbe9:	49 89 c5             	mov    %rax,%r13
    cbec:	eb 35                	jmp    cc23 <fwp_decode+0x6d3>
    cbee:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    cbf3:	4c 89 20             	mov    %r12,(%rax)
    cbf6:	e9 5f fa ff ff       	jmp    c65a <fwp_decode+0x10a>
    cbfb:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    cc00:	4c 89 20             	mov    %r12,(%rax)
    cc03:	e9 52 fa ff ff       	jmp    c65a <fwp_decode+0x10a>
    cc08:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    cc0c:	48 05 90 07 00 00    	add    $0x790,%rax
    cc12:	4a 8d 0c 2a          	lea    (%rdx,%r13,1),%rcx
    cc16:	48 89 08             	mov    %rcx,(%rax)
    cc19:	4c 89 ef             	mov    %r13,%rdi
    cc1c:	31 f6                	xor    %esi,%esi
    cc1e:	e8 ed 65 ff ff       	call   3210 <memset@plt>
    cc23:	41 8b 5f 10          	mov    0x10(%r15),%ebx
    cc27:	85 db                	test   %ebx,%ebx
    cc29:	7e 4a                	jle    cc75 <fwp_decode+0x725>
    cc2b:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    cc30:	45 31 e4             	xor    %r12d,%r12d
    cc33:	4c 89 6c 24 18       	mov    %r13,0x18(%rsp)
    cc38:	4c 89 ed             	mov    %r13,%rbp
    cc3b:	45 31 ed             	xor    %r13d,%r13d
    cc3e:	66 90                	xchg   %ax,%ax
    cc40:	49 8b 47 20          	mov    0x20(%r15),%rax
    cc44:	4a 8b 34 e8          	mov    (%rax,%r13,8),%rsi
    cc48:	4c 89 f7             	mov    %r14,%rdi
    cc4b:	48 89 ea             	mov    %rbp,%rdx
    cc4e:	e8 fd f8 ff ff       	call   c550 <fwp_decode>
    cc53:	85 c0                	test   %eax,%eax
    cc55:	0f 84 05 fa ff ff    	je     c660 <fwp_decode+0x110>
    cc5b:	49 ff c5             	inc    %r13
    cc5e:	49 63 5f 10          	movslq 0x10(%r15),%rbx
    cc62:	48 83 c5 08          	add    $0x8,%rbp
    cc66:	49 39 dd             	cmp    %rbx,%r13
    cc69:	7c d5                	jl     cc40 <fwp_decode+0x6f0>
    cc6b:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    cc70:	4c 8b 6c 24 18       	mov    0x18(%rsp),%r13
    cc75:	85 db                	test   %ebx,%ebx
    cc77:	0f 84 95 00 00 00    	je     cd12 <fwp_decode+0x7c2>
    cc7d:	41 89 de             	mov    %ebx,%r14d
    cc80:	4a 8d 3c f5 08 00 00 	lea    0x8(,%r14,8),%rdi
    cc87:	00 
    cc88:	e8 13 db ff ff       	call   a7a0 <fwp_alloc_init>
    cc8d:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    cc93:	89 58 04             	mov    %ebx,0x4(%rax)
    cc96:	83 fb 08             	cmp    $0x8,%ebx
    cc99:	72 14                	jb     ccaf <fwp_decode+0x75f>
    cc9b:	48 89 c1             	mov    %rax,%rcx
    cc9e:	4c 29 e9             	sub    %r13,%rcx
    cca1:	48 83 c1 08          	add    $0x8,%rcx
    cca5:	48 83 f9 20          	cmp    $0x20,%rcx
    cca9:	0f 83 95 00 00 00    	jae    cd44 <fwp_decode+0x7f4>
    ccaf:	31 c9                	xor    %ecx,%ecx
    ccb1:	4c 89 f6             	mov    %r14,%rsi
    ccb4:	48 89 ca             	mov    %rcx,%rdx
    ccb7:	48 83 e6 03          	and    $0x3,%rsi
    ccbb:	74 15                	je     ccd2 <fwp_decode+0x782>
    ccbd:	48 89 ca             	mov    %rcx,%rdx
    ccc0:	49 8b 7c d5 00       	mov    0x0(%r13,%rdx,8),%rdi
    ccc5:	48 89 7c d0 08       	mov    %rdi,0x8(%rax,%rdx,8)
    ccca:	48 ff c2             	inc    %rdx
    cccd:	48 ff ce             	dec    %rsi
    ccd0:	75 ee                	jne    ccc0 <fwp_decode+0x770>
    ccd2:	4c 29 f1             	sub    %r14,%rcx
    ccd5:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    ccd9:	0f 87 a1 00 00 00    	ja     cd80 <fwp_decode+0x830>
    ccdf:	49 8b 4c d5 00       	mov    0x0(%r13,%rdx,8),%rcx
    cce4:	48 89 4c d0 08       	mov    %rcx,0x8(%rax,%rdx,8)
    cce9:	49 8b 4c d5 08       	mov    0x8(%r13,%rdx,8),%rcx
    ccee:	48 89 4c d0 10       	mov    %rcx,0x10(%rax,%rdx,8)
    ccf3:	49 8b 4c d5 10       	mov    0x10(%r13,%rdx,8),%rcx
    ccf8:	48 89 4c d0 18       	mov    %rcx,0x18(%rax,%rdx,8)
    ccfd:	49 8b 4c d5 18       	mov    0x18(%r13,%rdx,8),%rcx
    cd02:	48 89 4c d0 20       	mov    %rcx,0x20(%rax,%rdx,8)
    cd07:	48 83 c2 04          	add    $0x4,%rdx
    cd0b:	49 39 d6             	cmp    %rdx,%r14
    cd0e:	75 cf                	jne    ccdf <fwp_decode+0x78f>
    cd10:	eb 6e                	jmp    cd80 <fwp_decode+0x830>
    cd12:	31 c0                	xor    %eax,%eax
    cd14:	48 89 45 00          	mov    %rax,0x0(%rbp)
    cd18:	e9 3d f9 ff ff       	jmp    c65a <fwp_decode+0x10a>
    cd1d:	4c 8b a4 c8 90 07 00 	mov    0x790(%rax,%rcx,8),%r12
    cd24:	00 
    cd25:	48 8b b4 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%rsi
    cd2c:	00 
    cd2d:	4c 29 e6             	sub    %r12,%rsi
    cd30:	48 39 d6             	cmp    %rdx,%rsi
    cd33:	73 54                	jae    cd89 <fwp_decode+0x839>
    cd35:	be 02 00 00 00       	mov    $0x2,%esi
    cd3a:	e8 41 b5 ff ff       	call   8280 <fwp_gc_alloc_slow>
    cd3f:	49 89 c4             	mov    %rax,%r12
    cd42:	eb 60                	jmp    cda4 <fwp_decode+0x854>
    cd44:	44 89 f1             	mov    %r14d,%ecx
    cd47:	83 e1 fc             	and    $0xfffffffc,%ecx
    cd4a:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
    cd51:	00 
    cd52:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    cd56:	31 f6                	xor    %esi,%esi
    cd58:	41 0f 10 44 35 00    	movups 0x0(%r13,%rsi,1),%xmm0
    cd5e:	41 0f 10 4c 35 10    	movups 0x10(%r13,%rsi,1),%xmm1
    cd64:	0f 11 44 30 08       	movups %xmm0,0x8(%rax,%rsi,1)
    cd69:	0f 11 4c 30 18       	movups %xmm1,0x18(%rax,%rsi,1)
    cd6e:	48 83 c6 20          	add    $0x20,%rsi
    cd72:	48 39 f2             	cmp    %rsi,%rdx
    cd75:	75 e1                	jne    cd58 <fwp_decode+0x808>
    cd77:	4c 39 f1             	cmp    %r14,%rcx
    cd7a:	0f 85 31 ff ff ff    	jne    ccb1 <fwp_decode+0x761>
    cd80:	48 89 45 00          	mov    %rax,0x0(%rbp)
    cd84:	e9 d1 f8 ff ff       	jmp    c65a <fwp_decode+0x10a>
    cd89:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    cd8d:	48 05 90 07 00 00    	add    $0x790,%rax
    cd93:	49 8d 0c 14          	lea    (%r12,%rdx,1),%rcx
    cd97:	48 89 08             	mov    %rcx,(%rax)
    cd9a:	4c 89 e7             	mov    %r12,%rdi
    cd9d:	31 f6                	xor    %esi,%esi
    cd9f:	e8 6c 64 ff ff       	call   3210 <memset@plt>
    cda4:	4d 85 ed             	test   %r13,%r13
    cda7:	74 22                	je     cdcb <fwp_decode+0x87b>
    cda9:	4c 89 e5             	mov    %r12,%rbp
    cdac:	4c 89 eb             	mov    %r13,%rbx
    cdaf:	49 8b 77 38          	mov    0x38(%r15),%rsi
    cdb3:	4c 89 f7             	mov    %r14,%rdi
    cdb6:	48 89 ea             	mov    %rbp,%rdx
    cdb9:	e8 92 f7 ff ff       	call   c550 <fwp_decode>
    cdbe:	85 c0                	test   %eax,%eax
    cdc0:	74 21                	je     cde3 <fwp_decode+0x893>
    cdc2:	48 83 c5 08          	add    $0x8,%rbp
    cdc6:	48 ff cb             	dec    %rbx
    cdc9:	75 e4                	jne    cdaf <fwp_decode+0x85f>
    cdcb:	4c 89 e7             	mov    %r12,%rdi
    cdce:	4c 89 ee             	mov    %r13,%rsi
    cdd1:	e8 4a 00 00 00       	call   ce20 <fwp_list_from>
    cdd6:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    cddb:	48 89 01             	mov    %rax,(%rcx)
    cdde:	e9 77 f8 ff ff       	jmp    c65a <fwp_decode+0x10a>
    cde3:	45 31 e4             	xor    %r12d,%r12d
    cde6:	e9 75 f8 ff ff       	jmp    c660 <fwp_decode+0x110>
    cdeb:	e8 d0 9d ff ff       	call   6bc0 <fwp_flush>
    cdf0:	48 8b 05 e1 d1 00 00 	mov    0xd1e1(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    cdf7:	48 8b 38             	mov    (%rax),%rdi
    cdfa:	48 8d 35 89 8c 00 00 	lea    0x8c89(%rip),%rsi        # 15a8a <exec_in_fp0+0x21a>
    ce01:	48 8d 15 ca 9b 00 00 	lea    0x9bca(%rip),%rdx        # 169d2 <exec_in_fp0+0x1162>
    ce08:	31 c0                	xor    %eax,%eax
    ce0a:	e8 e1 64 ff ff       	call   32f0 <fprintf@plt>
    ce0f:	bf 65 00 00 00       	mov    $0x65,%edi
    ce14:	e8 47 66 ff ff       	call   3460 <exit@plt>
    ce19:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000ce20 <fwp_list_from>:
    ce20:	55                   	push   %rbp
    ce21:	41 57                	push   %r15
    ce23:	41 56                	push   %r14
    ce25:	41 55                	push   %r13
    ce27:	41 54                	push   %r12
    ce29:	53                   	push   %rbx
    ce2a:	48 83 ec 18          	sub    $0x18,%rsp
    ce2e:	48 89 fb             	mov    %rdi,%rbx
    ce31:	48 85 f6             	test   %rsi,%rsi
    ce34:	0f 84 41 01 00 00    	je     cf7b <fwp_list_from+0x15b>
    ce3a:	49 89 f6             	mov    %rsi,%r14
    ce3d:	45 31 ff             	xor    %r15d,%r15d
    ce40:	4c 8d 2d 41 d4 00 00 	lea    0xd441(%rip),%r13        # 1a288 <fwp_gc>
    ce47:	eb 3d                	jmp    ce86 <fwp_list_from+0x66>
    ce49:	bf 18 00 00 00       	mov    $0x18,%edi
    ce4e:	31 f6                	xor    %esi,%esi
    ce50:	e8 2b b4 ff ff       	call   8280 <fwp_gc_alloc_slow>
    ce55:	49 89 c7             	mov    %rax,%r15
    ce58:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    ce5f:	00 
    ce60:	48 b8 01 00 00 00 02 	movabs $0x200000001,%rax
    ce67:	00 00 00 
    ce6a:	49 89 07             	mov    %rax,(%r15)
    ce6d:	49 89 6f 08          	mov    %rbp,0x8(%r15)
    ce71:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    ce76:	49 89 47 10          	mov    %rax,0x10(%r15)
    ce7a:	48 89 e0             	mov    %rsp,%rax
    ce7d:	49 ff ce             	dec    %r14
    ce80:	0f 84 f8 00 00 00    	je     cf7e <fwp_list_from+0x15e>
    ce86:	4a 8b 6c f3 f8       	mov    -0x8(%rbx,%r14,8),%rbp
    ce8b:	48 89 2c 24          	mov    %rbp,(%rsp)
    ce8f:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
    ce94:	48 ff 05 0d f0 00 00 	incq   0xf00d(%rip)        # 1bea8 <measured_calls>
    ce9b:	48 83 05 0d f0 00 00 	addq   $0x18,0xf00d(%rip)        # 1beb0 <measured_bytes>
    cea2:	18 
    cea3:	0f b6 05 c8 df 00 00 	movzbl 0xdfc8(%rip),%eax        # 1ae72 <fwp_gc+0xbea>
    ceaa:	41 8b 94 85 48 0b 00 	mov    0xb48(%r13,%rax,4),%edx
    ceb1:	00 
    ceb2:	48 8b 0d cf d3 00 00 	mov    0xd3cf(%rip),%rcx        # 1a288 <fwp_gc>
    ceb9:	48 29 d1             	sub    %rdx,%rcx
    cebc:	48 89 0d c5 d3 00 00 	mov    %rcx,0xd3c5(%rip)        # 1a288 <fwp_gc>
    cec3:	78 84                	js     ce49 <fwp_list_from+0x29>
    cec5:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
    cec9:	48 8d 34 c5 08 00 00 	lea    0x8(,%rax,8),%rsi
    ced0:	00 
    ced1:	4c 01 ee             	add    %r13,%rsi
    ced4:	4c 8b 3e             	mov    (%rsi),%r15
    ced7:	4d 85 ff             	test   %r15,%r15
    ceda:	74 34                	je     cf10 <fwp_list_from+0xf0>
    cedc:	49 8b 07             	mov    (%r15),%rax
    cedf:	48 f7 d0             	not    %rax
    cee2:	48 89 06             	mov    %rax,(%rsi)
    cee5:	83 fa 19             	cmp    $0x19,%edx
    cee8:	0f 82 72 ff ff ff    	jb     ce60 <fwp_list_from+0x40>
    ceee:	49 8d 7f 18          	lea    0x18(%r15),%rdi
    cef2:	48 83 c2 e7          	add    $0xffffffffffffffe7,%rdx
    cef6:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    cefa:	48 83 c2 08          	add    $0x8,%rdx
    cefe:	31 f6                	xor    %esi,%esi
    cf00:	e8 0b 63 ff ff       	call   3210 <memset@plt>
    cf05:	e9 56 ff ff ff       	jmp    ce60 <fwp_list_from+0x40>
    cf0a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    cf10:	4d 8b 7c c5 10       	mov    0x10(%r13,%rax,8),%r15
    cf15:	49 8b 74 c5 18       	mov    0x18(%r13,%rax,8),%rsi
    cf1a:	48 89 f7             	mov    %rsi,%rdi
    cf1d:	4c 29 ff             	sub    %r15,%rdi
    cf20:	48 39 d7             	cmp    %rdx,%rdi
    cf23:	73 0e                	jae    cf33 <fwp_list_from+0x113>
    cf25:	4d 89 fc             	mov    %r15,%r12
    cf28:	48 39 d7             	cmp    %rdx,%rdi
    cf2b:	0f 82 18 ff ff ff    	jb     ce49 <fwp_list_from+0x29>
    cf31:	eb 2d                	jmp    cf60 <fwp_list_from+0x140>
    cf33:	48 8d 3c c5 10 00 00 	lea    0x10(,%rax,8),%rdi
    cf3a:	00 
    cf3b:	4c 01 ef             	add    %r13,%rdi
    cf3e:	4d 8d 24 17          	lea    (%r15,%rdx,1),%r12
    cf42:	4c 89 27             	mov    %r12,(%rdi)
    cf45:	4d 85 ff             	test   %r15,%r15
    cf48:	75 9b                	jne    cee5 <fwp_list_from+0xc5>
    cf4a:	48 89 0d 37 d3 00 00 	mov    %rcx,0xd337(%rip)        # 1a288 <fwp_gc>
    cf51:	4c 29 e6             	sub    %r12,%rsi
    cf54:	48 89 f7             	mov    %rsi,%rdi
    cf57:	48 39 d7             	cmp    %rdx,%rdi
    cf5a:	0f 82 e9 fe ff ff    	jb     ce49 <fwp_list_from+0x29>
    cf60:	49 8d 0c 14          	lea    (%r12,%rdx,1),%rcx
    cf64:	49 89 4c c5 10       	mov    %rcx,0x10(%r13,%rax,8)
    cf69:	4c 89 e7             	mov    %r12,%rdi
    cf6c:	31 f6                	xor    %esi,%esi
    cf6e:	e8 9d 62 ff ff       	call   3210 <memset@plt>
    cf73:	4d 89 e7             	mov    %r12,%r15
    cf76:	e9 e5 fe ff ff       	jmp    ce60 <fwp_list_from+0x40>
    cf7b:	45 31 ff             	xor    %r15d,%r15d
    cf7e:	4c 89 f8             	mov    %r15,%rax
    cf81:	48 83 c4 18          	add    $0x18,%rsp
    cf85:	5b                   	pop    %rbx
    cf86:	41 5c                	pop    %r12
    cf88:	41 5d                	pop    %r13
    cf8a:	41 5e                	pop    %r14
    cf8c:	41 5f                	pop    %r15
    cf8e:	5d                   	pop    %rbp
    cf8f:	c3                   	ret

000000000000cf90 <fwp_valid_utf8>:
    cf90:	48 85 f6             	test   %rsi,%rsi
    cf93:	0f 84 48 01 00 00    	je     d0e1 <fwp_valid_utf8+0x151>
    cf99:	53                   	push   %rbx
    cf9a:	31 c9                	xor    %ecx,%ecx
    cf9c:	eb 0e                	jmp    cfac <fwp_valid_utf8+0x1c>
    cf9e:	66 90                	xchg   %ax,%ax
    cfa0:	48 ff c1             	inc    %rcx
    cfa3:	48 39 f1             	cmp    %rsi,%rcx
    cfa6:	0f 83 2e 01 00 00    	jae    d0da <fwp_valid_utf8+0x14a>
    cfac:	44 0f b6 14 0f       	movzbl (%rdi,%rcx,1),%r10d
    cfb1:	45 84 d2             	test   %r10b,%r10b
    cfb4:	79 ea                	jns    cfa0 <fwp_valid_utf8+0x10>
    cfb6:	41 8d 42 3e          	lea    0x3e(%r10),%eax
    cfba:	3c 1e                	cmp    $0x1e,%al
    cfbc:	73 12                	jae    cfd0 <fwp_valid_utf8+0x40>
    cfbe:	ba 80 00 00 00       	mov    $0x80,%edx
    cfc3:	b8 01 00 00 00       	mov    $0x1,%eax
    cfc8:	41 b8 1f 00 00 00    	mov    $0x1f,%r8d
    cfce:	eb 37                	jmp    d007 <fwp_valid_utf8+0x77>
    cfd0:	44 89 d0             	mov    %r10d,%eax
    cfd3:	24 f0                	and    $0xf0,%al
    cfd5:	3c e0                	cmp    $0xe0,%al
    cfd7:	75 12                	jne    cfeb <fwp_valid_utf8+0x5b>
    cfd9:	ba 00 08 00 00       	mov    $0x800,%edx
    cfde:	b8 02 00 00 00       	mov    $0x2,%eax
    cfe3:	41 b8 0f 00 00 00    	mov    $0xf,%r8d
    cfe9:	eb 1c                	jmp    d007 <fwp_valid_utf8+0x77>
    cfeb:	41 8d 42 10          	lea    0x10(%r10),%eax
    cfef:	3c 04                	cmp    $0x4,%al
    cff1:	0f 87 f0 00 00 00    	ja     d0e7 <fwp_valid_utf8+0x157>
    cff7:	ba 00 00 01 00       	mov    $0x10000,%edx
    cffc:	b8 03 00 00 00       	mov    $0x3,%eax
    d001:	41 b8 07 00 00 00    	mov    $0x7,%r8d
    d007:	41 89 c1             	mov    %eax,%r9d
    d00a:	4e 8d 1c 09          	lea    (%rcx,%r9,1),%r11
    d00e:	31 c0                	xor    %eax,%eax
    d010:	49 39 f3             	cmp    %rsi,%r11
    d013:	0f 83 c6 00 00 00    	jae    d0df <fwp_valid_utf8+0x14f>
    d019:	44 0f b6 5c 0f 01    	movzbl 0x1(%rdi,%rcx,1),%r11d
    d01f:	44 89 db             	mov    %r11d,%ebx
    d022:	83 e3 c0             	and    $0xffffffc0,%ebx
    d025:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
    d02b:	0f 85 ae 00 00 00    	jne    d0df <fwp_valid_utf8+0x14f>
    d031:	45 21 d0             	and    %r10d,%r8d
    d034:	45 8d 51 01          	lea    0x1(%r9),%r10d
    d038:	44 89 c3             	mov    %r8d,%ebx
    d03b:	c1 e3 06             	shl    $0x6,%ebx
    d03e:	41 83 e3 3f          	and    $0x3f,%r11d
    d042:	41 09 db             	or     %ebx,%r11d
    d045:	41 83 fa 02          	cmp    $0x2,%r10d
    d049:	75 0d                	jne    d058 <fwp_valid_utf8+0xc8>
    d04b:	45 89 da             	mov    %r11d,%r10d
    d04e:	41 39 d2             	cmp    %edx,%r10d
    d051:	73 62                	jae    d0b5 <fwp_valid_utf8+0x125>
    d053:	e9 87 00 00 00       	jmp    d0df <fwp_valid_utf8+0x14f>
    d058:	44 0f b6 44 0f 02    	movzbl 0x2(%rdi,%rcx,1),%r8d
    d05e:	44 89 c3             	mov    %r8d,%ebx
    d061:	83 e3 c0             	and    $0xffffffc0,%ebx
    d064:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
    d06a:	75 73                	jne    d0df <fwp_valid_utf8+0x14f>
    d06c:	44 89 db             	mov    %r11d,%ebx
    d06f:	c1 e3 06             	shl    $0x6,%ebx
    d072:	41 83 e0 3f          	and    $0x3f,%r8d
    d076:	41 09 d8             	or     %ebx,%r8d
    d079:	41 83 fa 03          	cmp    $0x3,%r10d
    d07d:	75 0d                	jne    d08c <fwp_valid_utf8+0xfc>
    d07f:	45 89 c2             	mov    %r8d,%r10d
    d082:	45 89 d8             	mov    %r11d,%r8d
    d085:	41 39 d2             	cmp    %edx,%r10d
    d088:	73 2b                	jae    d0b5 <fwp_valid_utf8+0x125>
    d08a:	eb 53                	jmp    d0df <fwp_valid_utf8+0x14f>
    d08c:	44 0f b6 54 0f 03    	movzbl 0x3(%rdi,%rcx,1),%r10d
    d092:	45 89 d3             	mov    %r10d,%r11d
    d095:	41 83 e3 c0          	and    $0xffffffc0,%r11d
    d099:	41 81 fb 80 00 00 00 	cmp    $0x80,%r11d
    d0a0:	75 3d                	jne    d0df <fwp_valid_utf8+0x14f>
    d0a2:	45 89 c3             	mov    %r8d,%r11d
    d0a5:	41 c1 e3 06          	shl    $0x6,%r11d
    d0a9:	41 83 e2 3f          	and    $0x3f,%r10d
    d0ad:	45 09 da             	or     %r11d,%r10d
    d0b0:	41 39 d2             	cmp    %edx,%r10d
    d0b3:	72 2a                	jb     d0df <fwp_valid_utf8+0x14f>
    d0b5:	41 81 fa ff ff 10 00 	cmp    $0x10ffff,%r10d
    d0bc:	77 21                	ja     d0df <fwp_valid_utf8+0x14f>
    d0be:	41 83 e0 e0          	and    $0xffffffe0,%r8d
    d0c2:	41 81 f8 60 03 00 00 	cmp    $0x360,%r8d
    d0c9:	74 14                	je     d0df <fwp_valid_utf8+0x14f>
    d0cb:	4c 01 c9             	add    %r9,%rcx
    d0ce:	48 ff c1             	inc    %rcx
    d0d1:	48 39 f1             	cmp    %rsi,%rcx
    d0d4:	0f 82 d2 fe ff ff    	jb     cfac <fwp_valid_utf8+0x1c>
    d0da:	b8 01 00 00 00       	mov    $0x1,%eax
    d0df:	5b                   	pop    %rbx
    d0e0:	c3                   	ret
    d0e1:	b8 01 00 00 00       	mov    $0x1,%eax
    d0e6:	c3                   	ret
    d0e7:	31 c0                	xor    %eax,%eax
    d0e9:	5b                   	pop    %rbx
    d0ea:	c3                   	ret
    d0eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000d0f0 <fwp_str_new>:
    d0f0:	41 57                	push   %r15
    d0f2:	41 56                	push   %r14
    d0f4:	53                   	push   %rbx
    d0f5:	49 89 f6             	mov    %rsi,%r14
    d0f8:	48 89 fb             	mov    %rdi,%rbx
    d0fb:	48 8d 56 09          	lea    0x9(%rsi),%rdx
    d0ff:	48 ff 05 a2 ed 00 00 	incq   0xeda2(%rip)        # 1bea8 <measured_calls>
    d106:	48 01 15 a3 ed 00 00 	add    %rdx,0xeda3(%rip)        # 1beb0 <measured_bytes>
    d10d:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    d114:	77 61                	ja     d177 <fwp_str_new+0x87>
    d116:	49 8d 4e 18          	lea    0x18(%r14),%rcx
    d11a:	48 c1 e9 04          	shr    $0x4,%rcx
    d11e:	48 8d 05 63 d1 00 00 	lea    0xd163(%rip),%rax        # 1a288 <fwp_gc>
    d125:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    d12c:	00 
    d12d:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    d134:	48 29 0d 4d d1 00 00 	sub    %rcx,0xd14d(%rip)        # 1a288 <fwp_gc>
    d13b:	78 3a                	js     d177 <fwp_str_new+0x87>
    d13d:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    d141:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    d145:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    d14c:	4c 8b 3f             	mov    (%rdi),%r15
    d14f:	4d 85 ff             	test   %r15,%r15
    d152:	74 0b                	je     d15f <fwp_str_new+0x6f>
    d154:	49 8b 07             	mov    (%r15),%rax
    d157:	48 f7 d0             	not    %rax
    d15a:	48 89 07             	mov    %rax,(%rdi)
    d15d:	eb 3a                	jmp    d199 <fwp_str_new+0xa9>
    d15f:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    d166:	00 
    d167:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    d16e:	00 
    d16f:	4c 29 ff             	sub    %r15,%rdi
    d172:	48 39 cf             	cmp    %rcx,%rdi
    d175:	73 12                	jae    d189 <fwp_str_new+0x99>
    d177:	48 89 d7             	mov    %rdx,%rdi
    d17a:	be 01 00 00 00       	mov    $0x1,%esi
    d17f:	e8 fc b0 ff ff       	call   8280 <fwp_gc_alloc_slow>
    d184:	49 89 c7             	mov    %rax,%r15
    d187:	eb 1a                	jmp    d1a3 <fwp_str_new+0xb3>
    d189:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    d18d:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    d193:	4c 01 f9             	add    %r15,%rcx
    d196:	48 89 08             	mov    %rcx,(%rax)
    d199:	4c 89 ff             	mov    %r15,%rdi
    d19c:	31 f6                	xor    %esi,%esi
    d19e:	e8 6d 60 ff ff       	call   3210 <memset@plt>
    d1a3:	4d 89 37             	mov    %r14,(%r15)
    d1a6:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    d1aa:	48 89 de             	mov    %rbx,%rsi
    d1ad:	4c 89 f2             	mov    %r14,%rdx
    d1b0:	e8 7b 61 ff ff       	call   3330 <memcpy@plt>
    d1b5:	43 c6 44 37 08 00    	movb   $0x0,0x8(%r15,%r14,1)
    d1bb:	4c 89 f8             	mov    %r15,%rax
    d1be:	5b                   	pop    %rbx
    d1bf:	41 5e                	pop    %r14
    d1c1:	41 5f                	pop    %r15
    d1c3:	c3                   	ret
    d1c4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    d1cb:	00 00 00 00 00 

000000000000d1d0 <buf_put>:
    d1d0:	41 57                	push   %r15
    d1d2:	41 56                	push   %r14
    d1d4:	41 54                	push   %r12
    d1d6:	53                   	push   %rbx
    d1d7:	50                   	push   %rax
    d1d8:	49 89 fe             	mov    %rdi,%r14
    d1db:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    d1df:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
    d1e3:	0f 84 a2 00 00 00    	je     d28b <buf_put+0xbb>
    d1e9:	48 89 d3             	mov    %rdx,%rbx
    d1ec:	48 c7 c0 fe ff ff ff 	mov    $0xfffffffffffffffe,%rax
    d1f3:	48 29 f8             	sub    %rdi,%rax
    d1f6:	48 39 d0             	cmp    %rdx,%rax
    d1f9:	0f 82 8c 00 00 00    	jb     d28b <buf_put+0xbb>
    d1ff:	48 8d 04 3b          	lea    (%rbx,%rdi,1),%rax
    d203:	48 ff c0             	inc    %rax
    d206:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    d20a:	48 39 c8             	cmp    %rcx,%rax
    d20d:	76 30                	jbe    d23f <buf_put+0x6f>
    d20f:	48 85 c9             	test   %rcx,%rcx
    d212:	41 bf 40 00 00 00    	mov    $0x40,%r15d
    d218:	4c 0f 45 f9          	cmovne %rcx,%r15
    d21c:	49 89 f4             	mov    %rsi,%r12
    d21f:	49 39 c7             	cmp    %rax,%r15
    d222:	73 23                	jae    d247 <buf_put+0x77>
    d224:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    d22b:	00 00 00 00 00 
    d230:	4d 85 ff             	test   %r15,%r15
    d233:	78 0f                	js     d244 <buf_put+0x74>
    d235:	4d 01 ff             	add    %r15,%r15
    d238:	49 39 c7             	cmp    %rax,%r15
    d23b:	72 f3                	jb     d230 <buf_put+0x60>
    d23d:	eb 08                	jmp    d247 <buf_put+0x77>
    d23f:	49 8b 06             	mov    (%r14),%rax
    d242:	eb 21                	jmp    d265 <buf_put+0x95>
    d244:	49 89 c7             	mov    %rax,%r15
    d247:	49 8b 3e             	mov    (%r14),%rdi
    d24a:	4c 89 fe             	mov    %r15,%rsi
    d24d:	e8 2e 61 ff ff       	call   3380 <realloc@plt>
    d252:	48 85 c0             	test   %rax,%rax
    d255:	74 34                	je     d28b <buf_put+0xbb>
    d257:	49 89 06             	mov    %rax,(%r14)
    d25a:	4d 89 7e 10          	mov    %r15,0x10(%r14)
    d25e:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    d262:	4c 89 e6             	mov    %r12,%rsi
    d265:	48 01 c7             	add    %rax,%rdi
    d268:	48 89 da             	mov    %rbx,%rdx
    d26b:	e8 c0 60 ff ff       	call   3330 <memcpy@plt>
    d270:	49 03 5e 08          	add    0x8(%r14),%rbx
    d274:	49 89 5e 08          	mov    %rbx,0x8(%r14)
    d278:	49 8b 06             	mov    (%r14),%rax
    d27b:	c6 04 18 00          	movb   $0x0,(%rax,%rbx,1)
    d27f:	48 83 c4 08          	add    $0x8,%rsp
    d283:	5b                   	pop    %rbx
    d284:	41 5c                	pop    %r12
    d286:	41 5e                	pop    %r14
    d288:	41 5f                	pop    %r15
    d28a:	c3                   	ret
    d28b:	48 8b 05 46 cd 00 00 	mov    0xcd46(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    d292:	48 8b 08             	mov    (%rax),%rcx
    d295:	48 8d 3d 46 88 00 00 	lea    0x8846(%rip),%rdi        # 15ae2 <exec_in_fp0+0x272>
    d29c:	be 13 00 00 00       	mov    $0x13,%esi
    d2a1:	ba 01 00 00 00       	mov    $0x1,%edx
    d2a6:	e8 d5 61 ff ff       	call   3480 <fwrite@plt>
    d2ab:	bf 66 00 00 00       	mov    $0x66,%edi
    d2b0:	e8 ab 61 ff ff       	call   3460 <exit@plt>
    d2b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    d2bc:	00 00 00 00 

000000000000d2c0 <buf_to_str>:
    d2c0:	41 57                	push   %r15
    d2c2:	41 56                	push   %r14
    d2c4:	41 55                	push   %r13
    d2c6:	41 54                	push   %r12
    d2c8:	53                   	push   %rbx
    d2c9:	48 89 fb             	mov    %rdi,%rbx
    d2cc:	4c 8b 2f             	mov    (%rdi),%r13
    d2cf:	4c 8b 77 08          	mov    0x8(%rdi),%r14
    d2d3:	49 8d 56 09          	lea    0x9(%r14),%rdx
    d2d7:	48 ff 05 ca eb 00 00 	incq   0xebca(%rip)        # 1bea8 <measured_calls>
    d2de:	48 01 15 cb eb 00 00 	add    %rdx,0xebcb(%rip)        # 1beb0 <measured_bytes>
    d2e5:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    d2ec:	77 61                	ja     d34f <buf_to_str+0x8f>
    d2ee:	49 8d 4e 18          	lea    0x18(%r14),%rcx
    d2f2:	48 c1 e9 04          	shr    $0x4,%rcx
    d2f6:	48 8d 05 8b cf 00 00 	lea    0xcf8b(%rip),%rax        # 1a288 <fwp_gc>
    d2fd:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    d304:	00 
    d305:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    d30c:	48 29 0d 75 cf 00 00 	sub    %rcx,0xcf75(%rip)        # 1a288 <fwp_gc>
    d313:	78 3a                	js     d34f <buf_to_str+0x8f>
    d315:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    d319:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    d31d:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    d324:	4c 8b 3f             	mov    (%rdi),%r15
    d327:	4d 85 ff             	test   %r15,%r15
    d32a:	74 0b                	je     d337 <buf_to_str+0x77>
    d32c:	49 8b 07             	mov    (%r15),%rax
    d32f:	48 f7 d0             	not    %rax
    d332:	48 89 07             	mov    %rax,(%rdi)
    d335:	eb 3a                	jmp    d371 <buf_to_str+0xb1>
    d337:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    d33e:	00 
    d33f:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    d346:	00 
    d347:	4c 29 ff             	sub    %r15,%rdi
    d34a:	48 39 cf             	cmp    %rcx,%rdi
    d34d:	73 12                	jae    d361 <buf_to_str+0xa1>
    d34f:	48 89 d7             	mov    %rdx,%rdi
    d352:	be 01 00 00 00       	mov    $0x1,%esi
    d357:	e8 24 af ff ff       	call   8280 <fwp_gc_alloc_slow>
    d35c:	49 89 c7             	mov    %rax,%r15
    d35f:	eb 1a                	jmp    d37b <buf_to_str+0xbb>
    d361:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    d365:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    d36b:	4c 01 f9             	add    %r15,%rcx
    d36e:	48 89 08             	mov    %rcx,(%rax)
    d371:	4c 89 ff             	mov    %r15,%rdi
    d374:	31 f6                	xor    %esi,%esi
    d376:	e8 95 5e ff ff       	call   3210 <memset@plt>
    d37b:	4d 85 ed             	test   %r13,%r13
    d37e:	4c 8d 25 41 8e 00 00 	lea    0x8e41(%rip),%r12        # 161c6 <exec_in_fp0+0x956>
    d385:	4d 0f 45 e5          	cmovne %r13,%r12
    d389:	4d 89 37             	mov    %r14,(%r15)
    d38c:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    d390:	4c 89 e6             	mov    %r12,%rsi
    d393:	4c 89 f2             	mov    %r14,%rdx
    d396:	e8 95 5f ff ff       	call   3330 <memcpy@plt>
    d39b:	43 c6 44 37 08 00    	movb   $0x0,0x8(%r15,%r14,1)
    d3a1:	48 8b 3b             	mov    (%rbx),%rdi
    d3a4:	e8 a7 5c ff ff       	call   3050 <free@plt>
    d3a9:	4c 89 f8             	mov    %r15,%rax
    d3ac:	5b                   	pop    %rbx
    d3ad:	41 5c                	pop    %r12
    d3af:	41 5d                	pop    %r13
    d3b1:	41 5e                	pop    %r14
    d3b3:	41 5f                	pop    %r15
    d3b5:	c3                   	ret
    d3b6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    d3bd:	00 00 00 

000000000000d3c0 <fwp_strf>:
    d3c0:	55                   	push   %rbp
    d3c1:	41 57                	push   %r15
    d3c3:	41 56                	push   %r14
    d3c5:	41 55                	push   %r13
    d3c7:	41 54                	push   %r12
    d3c9:	53                   	push   %rbx
    d3ca:	48 81 ec d8 00 00 00 	sub    $0xd8,%rsp
    d3d1:	49 89 ff             	mov    %rdi,%r15
    d3d4:	48 89 74 24 28       	mov    %rsi,0x28(%rsp)
    d3d9:	48 89 54 24 30       	mov    %rdx,0x30(%rsp)
    d3de:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
    d3e3:	4c 89 44 24 40       	mov    %r8,0x40(%rsp)
    d3e8:	4c 89 4c 24 48       	mov    %r9,0x48(%rsp)
    d3ed:	84 c0                	test   %al,%al
    d3ef:	74 37                	je     d428 <fwp_strf+0x68>
    d3f1:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
    d3f6:	0f 29 4c 24 60       	movaps %xmm1,0x60(%rsp)
    d3fb:	0f 29 54 24 70       	movaps %xmm2,0x70(%rsp)
    d400:	0f 29 9c 24 80 00 00 	movaps %xmm3,0x80(%rsp)
    d407:	00 
    d408:	0f 29 a4 24 90 00 00 	movaps %xmm4,0x90(%rsp)
    d40f:	00 
    d410:	0f 29 ac 24 a0 00 00 	movaps %xmm5,0xa0(%rsp)
    d417:	00 
    d418:	0f 29 b4 24 b0 00 00 	movaps %xmm6,0xb0(%rsp)
    d41f:	00 
    d420:	0f 29 bc 24 c0 00 00 	movaps %xmm7,0xc0(%rsp)
    d427:	00 
    d428:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    d42d:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    d432:	48 8d 84 24 10 01 00 	lea    0x110(%rsp),%rax
    d439:	00 
    d43a:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    d43f:	48 bd 08 00 00 00 30 	movabs $0x3000000008,%rbp
    d446:	00 00 00 
    d449:	48 89 2c 24          	mov    %rbp,(%rsp)
    d44d:	48 89 e1             	mov    %rsp,%rcx
    d450:	31 ff                	xor    %edi,%edi
    d452:	31 f6                	xor    %esi,%esi
    d454:	4c 89 fa             	mov    %r15,%rdx
    d457:	e8 b4 5c ff ff       	call   3110 <vsnprintf@plt>
    d45c:	48 63 d8             	movslq %eax,%rbx
    d45f:	48 ff 05 42 ea 00 00 	incq   0xea42(%rip)        # 1bea8 <measured_calls>
    d466:	4c 8d 63 01          	lea    0x1(%rbx),%r12
    d46a:	4c 01 25 3f ea 00 00 	add    %r12,0xea3f(%rip)        # 1beb0 <measured_bytes>
    d471:	4c 8d 2d 10 ce 00 00 	lea    0xce10(%rip),%r13        # 1a288 <fwp_gc>
    d478:	49 81 fc 00 40 00 00 	cmp    $0x4000,%r12
    d47f:	77 5c                	ja     d4dd <fwp_strf+0x11d>
    d481:	48 8d 43 10          	lea    0x10(%rbx),%rax
    d485:	48 c1 e8 04          	shr    $0x4,%rax
    d489:	42 0f b6 8c 28 e8 0b 	movzbl 0xbe8(%rax,%r13,1),%ecx
    d490:	00 00 
    d492:	41 8b 84 8d 48 0b 00 	mov    0xb48(%r13,%rcx,4),%eax
    d499:	00 
    d49a:	48 29 05 e7 cd 00 00 	sub    %rax,0xcde7(%rip)        # 1a288 <fwp_gc>
    d4a1:	78 3a                	js     d4dd <fwp_strf+0x11d>
    d4a3:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    d4a7:	48 8d 14 cd c8 03 00 	lea    0x3c8(,%rcx,8),%rdx
    d4ae:	00 
    d4af:	4c 01 ea             	add    %r13,%rdx
    d4b2:	4c 8b 32             	mov    (%rdx),%r14
    d4b5:	4d 85 f6             	test   %r14,%r14
    d4b8:	74 0b                	je     d4c5 <fwp_strf+0x105>
    d4ba:	49 8b 06             	mov    (%r14),%rax
    d4bd:	48 f7 d0             	not    %rax
    d4c0:	48 89 02             	mov    %rax,(%rdx)
    d4c3:	eb 3b                	jmp    d500 <fwp_strf+0x140>
    d4c5:	4d 8b b4 cd d0 03 00 	mov    0x3d0(%r13,%rcx,8),%r14
    d4cc:	00 
    d4cd:	49 8b 94 cd d8 03 00 	mov    0x3d8(%r13,%rcx,8),%rdx
    d4d4:	00 
    d4d5:	4c 29 f2             	sub    %r14,%rdx
    d4d8:	48 39 c2             	cmp    %rax,%rdx
    d4db:	73 12                	jae    d4ef <fwp_strf+0x12f>
    d4dd:	4c 89 e7             	mov    %r12,%rdi
    d4e0:	be 01 00 00 00       	mov    $0x1,%esi
    d4e5:	e8 96 ad ff ff       	call   8280 <fwp_gc_alloc_slow>
    d4ea:	49 89 c6             	mov    %rax,%r14
    d4ed:	eb 1e                	jmp    d50d <fwp_strf+0x14d>
    d4ef:	48 8d 0c cd d0 03 00 	lea    0x3d0(,%rcx,8),%rcx
    d4f6:	00 
    d4f7:	4c 01 e9             	add    %r13,%rcx
    d4fa:	4c 01 f0             	add    %r14,%rax
    d4fd:	48 89 01             	mov    %rax,(%rcx)
    d500:	4c 89 f7             	mov    %r14,%rdi
    d503:	31 f6                	xor    %esi,%esi
    d505:	4c 89 e2             	mov    %r12,%rdx
    d508:	e8 03 5d ff ff       	call   3210 <memset@plt>
    d50d:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    d512:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    d517:	48 8d 84 24 10 01 00 	lea    0x110(%rsp),%rax
    d51e:	00 
    d51f:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    d524:	48 89 2c 24          	mov    %rbp,(%rsp)
    d528:	48 89 e1             	mov    %rsp,%rcx
    d52b:	4c 89 f7             	mov    %r14,%rdi
    d52e:	4c 89 e6             	mov    %r12,%rsi
    d531:	4c 89 fa             	mov    %r15,%rdx
    d534:	e8 d7 5b ff ff       	call   3110 <vsnprintf@plt>
    d539:	48 8d 53 09          	lea    0x9(%rbx),%rdx
    d53d:	48 ff 05 64 e9 00 00 	incq   0xe964(%rip)        # 1bea8 <measured_calls>
    d544:	48 01 15 65 e9 00 00 	add    %rdx,0xe965(%rip)        # 1beb0 <measured_bytes>
    d54b:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    d552:	77 5c                	ja     d5b0 <fwp_strf+0x1f0>
    d554:	48 8d 43 18          	lea    0x18(%rbx),%rax
    d558:	48 c1 e8 04          	shr    $0x4,%rax
    d55c:	42 0f b6 8c 28 e8 0b 	movzbl 0xbe8(%rax,%r13,1),%ecx
    d563:	00 00 
    d565:	41 8b 84 8d 48 0b 00 	mov    0xb48(%r13,%rcx,4),%eax
    d56c:	00 
    d56d:	48 29 05 14 cd 00 00 	sub    %rax,0xcd14(%rip)        # 1a288 <fwp_gc>
    d574:	78 3a                	js     d5b0 <fwp_strf+0x1f0>
    d576:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    d57a:	48 8d 34 cd c8 03 00 	lea    0x3c8(,%rcx,8),%rsi
    d581:	00 
    d582:	4c 01 ee             	add    %r13,%rsi
    d585:	4c 8b 3e             	mov    (%rsi),%r15
    d588:	4d 85 ff             	test   %r15,%r15
    d58b:	74 0b                	je     d598 <fwp_strf+0x1d8>
    d58d:	49 8b 07             	mov    (%r15),%rax
    d590:	48 f7 d0             	not    %rax
    d593:	48 89 06             	mov    %rax,(%rsi)
    d596:	eb 3b                	jmp    d5d3 <fwp_strf+0x213>
    d598:	4d 8b bc cd d0 03 00 	mov    0x3d0(%r13,%rcx,8),%r15
    d59f:	00 
    d5a0:	49 8b b4 cd d8 03 00 	mov    0x3d8(%r13,%rcx,8),%rsi
    d5a7:	00 
    d5a8:	4c 29 fe             	sub    %r15,%rsi
    d5ab:	48 39 c6             	cmp    %rax,%rsi
    d5ae:	73 12                	jae    d5c2 <fwp_strf+0x202>
    d5b0:	48 89 d7             	mov    %rdx,%rdi
    d5b3:	be 01 00 00 00       	mov    $0x1,%esi
    d5b8:	e8 c3 ac ff ff       	call   8280 <fwp_gc_alloc_slow>
    d5bd:	49 89 c7             	mov    %rax,%r15
    d5c0:	eb 1b                	jmp    d5dd <fwp_strf+0x21d>
    d5c2:	48 8d 0c cd d0 03 00 	lea    0x3d0(,%rcx,8),%rcx
    d5c9:	00 
    d5ca:	4c 01 e9             	add    %r13,%rcx
    d5cd:	4c 01 f8             	add    %r15,%rax
    d5d0:	48 89 01             	mov    %rax,(%rcx)
    d5d3:	4c 89 ff             	mov    %r15,%rdi
    d5d6:	31 f6                	xor    %esi,%esi
    d5d8:	e8 33 5c ff ff       	call   3210 <memset@plt>
    d5dd:	49 89 1f             	mov    %rbx,(%r15)
    d5e0:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    d5e4:	4c 89 f6             	mov    %r14,%rsi
    d5e7:	48 89 da             	mov    %rbx,%rdx
    d5ea:	e8 41 5d ff ff       	call   3330 <memcpy@plt>
    d5ef:	41 c6 44 1f 08 00    	movb   $0x0,0x8(%r15,%rbx,1)
    d5f5:	4c 89 f8             	mov    %r15,%rax
    d5f8:	48 81 c4 d8 00 00 00 	add    $0xd8,%rsp
    d5ff:	5b                   	pop    %rbx
    d600:	41 5c                	pop    %r12
    d602:	41 5d                	pop    %r13
    d604:	41 5e                	pop    %r14
    d606:	41 5f                	pop    %r15
    d608:	5d                   	pop    %rbp
    d609:	c3                   	ret
    d60a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000d610 <fwp_data>:
    d610:	55                   	push   %rbp
    d611:	41 57                	push   %r15
    d613:	41 56                	push   %r14
    d615:	53                   	push   %rbx
    d616:	50                   	push   %rax
    d617:	89 fd                	mov    %edi,%ebp
    d619:	85 f6                	test   %esi,%esi
    d61b:	0f 84 a1 00 00 00    	je     d6c2 <fwp_data+0xb2>
    d621:	48 89 d3             	mov    %rdx,%rbx
    d624:	41 89 f6             	mov    %esi,%r14d
    d627:	4a 8d 3c f5 08 00 00 	lea    0x8(,%r14,8),%rdi
    d62e:	00 
    d62f:	41 89 f7             	mov    %esi,%r15d
    d632:	e8 69 d1 ff ff       	call   a7a0 <fwp_alloc_init>
    d637:	89 28                	mov    %ebp,(%rax)
    d639:	44 89 78 04          	mov    %r15d,0x4(%rax)
    d63d:	41 83 ff 08          	cmp    $0x8,%r15d
    d641:	72 10                	jb     d653 <fwp_data+0x43>
    d643:	48 89 c1             	mov    %rax,%rcx
    d646:	48 29 d9             	sub    %rbx,%rcx
    d649:	48 83 c1 08          	add    $0x8,%rcx
    d64d:	48 83 f9 20          	cmp    $0x20,%rcx
    d651:	73 73                	jae    d6c6 <fwp_data+0xb6>
    d653:	31 c9                	xor    %ecx,%ecx
    d655:	4c 89 f6             	mov    %r14,%rsi
    d658:	48 89 ca             	mov    %rcx,%rdx
    d65b:	48 83 e6 03          	and    $0x3,%rsi
    d65f:	74 20                	je     d681 <fwp_data+0x71>
    d661:	48 89 ca             	mov    %rcx,%rdx
    d664:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    d66b:	00 00 00 00 00 
    d670:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    d674:	48 89 7c d0 08       	mov    %rdi,0x8(%rax,%rdx,8)
    d679:	48 ff c2             	inc    %rdx
    d67c:	48 ff ce             	dec    %rsi
    d67f:	75 ef                	jne    d670 <fwp_data+0x60>
    d681:	4c 29 f1             	sub    %r14,%rcx
    d684:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    d688:	77 7b                	ja     d705 <fwp_data+0xf5>
    d68a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    d690:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    d694:	48 89 4c d0 08       	mov    %rcx,0x8(%rax,%rdx,8)
    d699:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    d69e:	48 89 4c d0 10       	mov    %rcx,0x10(%rax,%rdx,8)
    d6a3:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    d6a8:	48 89 4c d0 18       	mov    %rcx,0x18(%rax,%rdx,8)
    d6ad:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    d6b2:	48 89 4c d0 20       	mov    %rcx,0x20(%rax,%rdx,8)
    d6b7:	48 83 c2 04          	add    $0x4,%rdx
    d6bb:	49 39 d6             	cmp    %rdx,%r14
    d6be:	75 d0                	jne    d690 <fwp_data+0x80>
    d6c0:	eb 43                	jmp    d705 <fwp_data+0xf5>
    d6c2:	89 e8                	mov    %ebp,%eax
    d6c4:	eb 3f                	jmp    d705 <fwp_data+0xf5>
    d6c6:	44 89 f1             	mov    %r14d,%ecx
    d6c9:	83 e1 fc             	and    $0xfffffffc,%ecx
    d6cc:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
    d6d3:	00 
    d6d4:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    d6d8:	31 f6                	xor    %esi,%esi
    d6da:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    d6e0:	0f 10 04 33          	movups (%rbx,%rsi,1),%xmm0
    d6e4:	0f 10 4c 33 10       	movups 0x10(%rbx,%rsi,1),%xmm1
    d6e9:	0f 11 44 30 08       	movups %xmm0,0x8(%rax,%rsi,1)
    d6ee:	0f 11 4c 30 18       	movups %xmm1,0x18(%rax,%rsi,1)
    d6f3:	48 83 c6 20          	add    $0x20,%rsi
    d6f7:	48 39 f2             	cmp    %rsi,%rdx
    d6fa:	75 e4                	jne    d6e0 <fwp_data+0xd0>
    d6fc:	4c 39 f1             	cmp    %r14,%rcx
    d6ff:	0f 85 50 ff ff ff    	jne    d655 <fwp_data+0x45>
    d705:	48 83 c4 08          	add    $0x8,%rsp
    d709:	5b                   	pop    %rbx
    d70a:	41 5e                	pop    %r14
    d70c:	41 5f                	pop    %r15
    d70e:	5d                   	pop    %rbp
    d70f:	c3                   	ret

000000000000d710 <tp_value>:
    d710:	55                   	push   %rbp
    d711:	41 57                	push   %r15
    d713:	41 56                	push   %r14
    d715:	41 55                	push   %r13
    d717:	41 54                	push   %r12
    d719:	53                   	push   %rbx
    d71a:	48 81 ec d8 01 00 00 	sub    $0x1d8,%rsp
    d721:	49 89 cc             	mov    %rcx,%r12
    d724:	85 d2                	test   %edx,%edx
    d726:	0f 84 99 00 00 00    	je     d7c5 <tp_value+0xb5>
    d72c:	83 3e 0c             	cmpl   $0xc,(%rsi)
    d72f:	0f 85 90 00 00 00    	jne    d7c5 <tp_value+0xb5>
    d735:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    d739:	4c 8b 7f 10          	mov    0x10(%rdi),%r15
    d73d:	4c 89 e5             	mov    %r12,%rbp
    d740:	4c 8b 27             	mov    (%rdi),%r12
    d743:	4d 01 fc             	add    %r15,%r12
    d746:	4d 29 fd             	sub    %r15,%r13
    d749:	0f 85 ea 00 00 00    	jne    d839 <tp_value+0x129>
    d74f:	49 8d 55 09          	lea    0x9(%r13),%rdx
    d753:	48 ff 05 4e e7 00 00 	incq   0xe74e(%rip)        # 1bea8 <measured_calls>
    d75a:	48 01 15 4f e7 00 00 	add    %rdx,0xe74f(%rip)        # 1beb0 <measured_bytes>
    d761:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    d768:	0f 87 38 02 00 00    	ja     d9a6 <tp_value+0x296>
    d76e:	49 8d 4d 18          	lea    0x18(%r13),%rcx
    d772:	48 c1 e9 04          	shr    $0x4,%rcx
    d776:	48 8d 05 0b cb 00 00 	lea    0xcb0b(%rip),%rax        # 1a288 <fwp_gc>
    d77d:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    d784:	00 
    d785:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    d78c:	48 29 0d f5 ca 00 00 	sub    %rcx,0xcaf5(%rip)        # 1a288 <fwp_gc>
    d793:	0f 88 0d 02 00 00    	js     d9a6 <tp_value+0x296>
    d799:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    d79d:	4c 8d 04 f0          	lea    (%rax,%rsi,8),%r8
    d7a1:	49 81 c0 c8 03 00 00 	add    $0x3c8,%r8
    d7a8:	4d 8b 30             	mov    (%r8),%r14
    d7ab:	4d 85 f6             	test   %r14,%r14
    d7ae:	0f 84 d6 01 00 00    	je     d98a <tp_value+0x27a>
    d7b4:	48 89 fb             	mov    %rdi,%rbx
    d7b7:	49 8b 06             	mov    (%r14),%rax
    d7ba:	48 f7 d0             	not    %rax
    d7bd:	49 89 00             	mov    %rax,(%r8)
    d7c0:	e9 de 04 00 00       	jmp    dca3 <tp_value+0x593>
    d7c5:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    d7c9:	4c 8b 7f 10          	mov    0x10(%rdi),%r15
    d7cd:	4d 39 ef             	cmp    %r13,%r15
    d7d0:	73 2e                	jae    d800 <tp_value+0xf0>
    d7d2:	48 8b 07             	mov    (%rdi),%rax
    d7d5:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    d7dc:	00 00 00 
    d7df:	90                   	nop
    d7e0:	46 0f b6 04 38       	movzbl (%rax,%r15,1),%r8d
    d7e5:	49 83 f8 20          	cmp    $0x20,%r8
    d7e9:	77 15                	ja     d800 <tp_value+0xf0>
    d7eb:	4c 0f a3 c1          	bt     %r8,%rcx
    d7ef:	73 0f                	jae    d800 <tp_value+0xf0>
    d7f1:	49 ff c7             	inc    %r15
    d7f4:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    d7f8:	4d 39 fd             	cmp    %r15,%r13
    d7fb:	75 e3                	jne    d7e0 <tp_value+0xd0>
    d7fd:	4d 89 ef             	mov    %r13,%r15
    d800:	8b 06                	mov    (%rsi),%eax
    d802:	45 31 f6             	xor    %r14d,%r14d
    d805:	48 83 f8 15          	cmp    $0x15,%rax
    d809:	0f 87 c8 04 00 00    	ja     dcd7 <tp_value+0x5c7>
    d80f:	48 8d 0d 22 7a 00 00 	lea    0x7a22(%rip),%rcx        # 15238 <_IO_stdin_used+0x238>
    d816:	4c 63 04 81          	movslq (%rcx,%rax,4),%r8
    d81a:	49 01 c8             	add    %rcx,%r8
    d81d:	41 ff e0             	jmp    *%r8
    d820:	4c 89 e2             	mov    %r12,%rdx
    d823:	48 81 c4 d8 01 00 00 	add    $0x1d8,%rsp
    d82a:	5b                   	pop    %rbx
    d82b:	41 5c                	pop    %r12
    d82d:	41 5d                	pop    %r13
    d82f:	41 5e                	pop    %r14
    d831:	41 5f                	pop    %r15
    d833:	5d                   	pop    %rbp
    d834:	e9 e7 16 00 00       	jmp    ef20 <tp_int>
    d839:	31 c0                	xor    %eax,%eax
    d83b:	eb 0f                	jmp    d84c <tp_value+0x13c>
    d83d:	0f 1f 00             	nopl   (%rax)
    d840:	48 ff c0             	inc    %rax
    d843:	4c 39 e8             	cmp    %r13,%rax
    d846:	0f 83 03 ff ff ff    	jae    d74f <tp_value+0x3f>
    d84c:	45 0f b6 04 04       	movzbl (%r12,%rax,1),%r8d
    d851:	45 84 c0             	test   %r8b,%r8b
    d854:	79 ea                	jns    d840 <tp_value+0x130>
    d856:	41 8d 48 3e          	lea    0x3e(%r8),%ecx
    d85a:	80 f9 1e             	cmp    $0x1e,%cl
    d85d:	73 11                	jae    d870 <tp_value+0x160>
    d85f:	b9 80 00 00 00       	mov    $0x80,%ecx
    d864:	be 01 00 00 00       	mov    $0x1,%esi
    d869:	ba 1f 00 00 00       	mov    $0x1f,%edx
    d86e:	eb 38                	jmp    d8a8 <tp_value+0x198>
    d870:	44 89 c1             	mov    %r8d,%ecx
    d873:	80 e1 f0             	and    $0xf0,%cl
    d876:	80 f9 e0             	cmp    $0xe0,%cl
    d879:	75 11                	jne    d88c <tp_value+0x17c>
    d87b:	b9 00 08 00 00       	mov    $0x800,%ecx
    d880:	be 02 00 00 00       	mov    $0x2,%esi
    d885:	ba 0f 00 00 00       	mov    $0xf,%edx
    d88a:	eb 1c                	jmp    d8a8 <tp_value+0x198>
    d88c:	41 8d 48 10          	lea    0x10(%r8),%ecx
    d890:	80 f9 04             	cmp    $0x4,%cl
    d893:	0f 87 8c 15 00 00    	ja     ee25 <tp_value+0x1715>
    d899:	b9 00 00 01 00       	mov    $0x10000,%ecx
    d89e:	be 03 00 00 00       	mov    $0x3,%esi
    d8a3:	ba 07 00 00 00       	mov    $0x7,%edx
    d8a8:	89 f6                	mov    %esi,%esi
    d8aa:	4c 8d 0c 30          	lea    (%rax,%rsi,1),%r9
    d8ae:	45 31 f6             	xor    %r14d,%r14d
    d8b1:	4d 39 e9             	cmp    %r13,%r9
    d8b4:	0f 83 1d 04 00 00    	jae    dcd7 <tp_value+0x5c7>
    d8ba:	45 0f b6 4c 04 01    	movzbl 0x1(%r12,%rax,1),%r9d
    d8c0:	45 89 ca             	mov    %r9d,%r10d
    d8c3:	41 83 e2 c0          	and    $0xffffffc0,%r10d
    d8c7:	41 81 fa 80 00 00 00 	cmp    $0x80,%r10d
    d8ce:	0f 85 03 04 00 00    	jne    dcd7 <tp_value+0x5c7>
    d8d4:	44 21 c2             	and    %r8d,%edx
    d8d7:	44 8d 46 01          	lea    0x1(%rsi),%r8d
    d8db:	41 89 d2             	mov    %edx,%r10d
    d8de:	41 c1 e2 06          	shl    $0x6,%r10d
    d8e2:	41 83 e1 3f          	and    $0x3f,%r9d
    d8e6:	45 09 d1             	or     %r10d,%r9d
    d8e9:	41 83 f8 02          	cmp    $0x2,%r8d
    d8ed:	75 05                	jne    d8f4 <tp_value+0x1e4>
    d8ef:	45 89 c8             	mov    %r9d,%r8d
    d8f2:	eb 5d                	jmp    d951 <tp_value+0x241>
    d8f4:	41 0f b6 54 04 02    	movzbl 0x2(%r12,%rax,1),%edx
    d8fa:	41 89 d2             	mov    %edx,%r10d
    d8fd:	41 83 e2 c0          	and    $0xffffffc0,%r10d
    d901:	41 81 fa 80 00 00 00 	cmp    $0x80,%r10d
    d908:	0f 85 c9 03 00 00    	jne    dcd7 <tp_value+0x5c7>
    d90e:	45 89 ca             	mov    %r9d,%r10d
    d911:	41 c1 e2 06          	shl    $0x6,%r10d
    d915:	83 e2 3f             	and    $0x3f,%edx
    d918:	44 09 d2             	or     %r10d,%edx
    d91b:	41 83 f8 03          	cmp    $0x3,%r8d
    d91f:	75 08                	jne    d929 <tp_value+0x219>
    d921:	41 89 d0             	mov    %edx,%r8d
    d924:	44 89 ca             	mov    %r9d,%edx
    d927:	eb 28                	jmp    d951 <tp_value+0x241>
    d929:	45 0f b6 44 04 03    	movzbl 0x3(%r12,%rax,1),%r8d
    d92f:	45 89 c1             	mov    %r8d,%r9d
    d932:	41 83 e1 c0          	and    $0xffffffc0,%r9d
    d936:	41 81 f9 80 00 00 00 	cmp    $0x80,%r9d
    d93d:	0f 85 94 03 00 00    	jne    dcd7 <tp_value+0x5c7>
    d943:	41 89 d1             	mov    %edx,%r9d
    d946:	41 c1 e1 06          	shl    $0x6,%r9d
    d94a:	41 83 e0 3f          	and    $0x3f,%r8d
    d94e:	45 09 c8             	or     %r9d,%r8d
    d951:	83 e2 e0             	and    $0xffffffe0,%edx
    d954:	81 fa 60 03 00 00    	cmp    $0x360,%edx
    d95a:	0f 84 77 03 00 00    	je     dcd7 <tp_value+0x5c7>
    d960:	41 39 c8             	cmp    %ecx,%r8d
    d963:	0f 82 6e 03 00 00    	jb     dcd7 <tp_value+0x5c7>
    d969:	41 81 f8 ff ff 10 00 	cmp    $0x10ffff,%r8d
    d970:	0f 87 61 03 00 00    	ja     dcd7 <tp_value+0x5c7>
    d976:	48 01 f0             	add    %rsi,%rax
    d979:	48 ff c0             	inc    %rax
    d97c:	4c 39 e8             	cmp    %r13,%rax
    d97f:	0f 82 c7 fe ff ff    	jb     d84c <tp_value+0x13c>
    d985:	e9 c5 fd ff ff       	jmp    d74f <tp_value+0x3f>
    d98a:	4c 8b b4 f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r14
    d991:	00 
    d992:	4c 8b 84 f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%r8
    d999:	00 
    d99a:	4d 29 f0             	sub    %r14,%r8
    d99d:	49 39 c8             	cmp    %rcx,%r8
    d9a0:	0f 83 ea 02 00 00    	jae    dc90 <tp_value+0x580>
    d9a6:	48 89 fb             	mov    %rdi,%rbx
    d9a9:	48 89 d7             	mov    %rdx,%rdi
    d9ac:	be 01 00 00 00       	mov    $0x1,%esi
    d9b1:	e8 ca a8 ff ff       	call   8280 <fwp_gc_alloc_slow>
    d9b6:	49 89 c6             	mov    %rax,%r14
    d9b9:	e9 ef 02 00 00       	jmp    dcad <tp_value+0x59d>
    d9be:	f3 0f 6f 46 38       	movdqu 0x38(%rsi),%xmm0
    d9c3:	66 0f 7f 44 24 50    	movdqa %xmm0,0x50(%rsp)
    d9c9:	31 c9                	xor    %ecx,%ecx
    d9cb:	83 f8 13             	cmp    $0x13,%eax
    d9ce:	0f 94 c1             	sete   %cl
    d9d1:	66 0f ef c0          	pxor   %xmm0,%xmm0
    d9d5:	66 0f 7f 44 24 60    	movdqa %xmm0,0x60(%rsp)
    d9db:	48 c7 44 24 70 00 00 	movq   $0x0,0x70(%rsp)
    d9e2:	00 00 
    d9e4:	89 4c 24 78          	mov    %ecx,0x78(%rsp)
    d9e8:	48 8d 0d d2 8c 00 00 	lea    0x8cd2(%rip),%rcx        # 166c1 <exec_in_fp0+0xe51>
    d9ef:	48 8d 05 f7 7f 00 00 	lea    0x7ff7(%rip),%rax        # 159ed <exec_in_fp0+0x17d>
    d9f6:	48 0f 44 c1          	cmove  %rcx,%rax
    d9fa:	4d 39 ef             	cmp    %r13,%r15
    d9fd:	73 31                	jae    da30 <tp_value+0x320>
    d9ff:	48 8b 0f             	mov    (%rdi),%rcx
    da02:	48 ba 00 26 00 00 01 	movabs $0x100002600,%rdx
    da09:	00 00 00 
    da0c:	0f 1f 40 00          	nopl   0x0(%rax)
    da10:	46 0f b6 04 39       	movzbl (%rcx,%r15,1),%r8d
    da15:	49 83 f8 20          	cmp    $0x20,%r8
    da19:	77 15                	ja     da30 <tp_value+0x320>
    da1b:	4c 0f a3 c2          	bt     %r8,%rdx
    da1f:	73 0f                	jae    da30 <tp_value+0x320>
    da21:	49 ff c7             	inc    %r15
    da24:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    da28:	4d 39 fd             	cmp    %r15,%r13
    da2b:	75 e3                	jne    da10 <tp_value+0x300>
    da2d:	4d 89 ef             	mov    %r13,%r15
    da30:	4d 29 fd             	sub    %r15,%r13
    da33:	45 31 f6             	xor    %r14d,%r14d
    da36:	49 83 fd 03          	cmp    $0x3,%r13
    da3a:	0f 82 97 02 00 00    	jb     dcd7 <tp_value+0x5c7>
    da40:	48 8b 0f             	mov    (%rdi),%rcx
    da43:	42 0f b7 14 39       	movzwl (%rcx,%r15,1),%edx
    da48:	66 33 10             	xor    (%rax),%dx
    da4b:	42 0f b6 4c 39 02    	movzbl 0x2(%rcx,%r15,1),%ecx
    da51:	32 48 02             	xor    0x2(%rax),%cl
    da54:	0f b6 c1             	movzbl %cl,%eax
    da57:	66 09 d0             	or     %dx,%ax
    da5a:	0f 85 77 02 00 00    	jne    dcd7 <tp_value+0x5c7>
    da60:	48 89 f3             	mov    %rsi,%rbx
    da63:	49 83 c7 03          	add    $0x3,%r15
    da67:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    da6b:	48 8d 35 21 8d 00 00 	lea    0x8d21(%rip),%rsi        # 16793 <exec_in_fp0+0xf23>
    da72:	48 8d 15 45 7f 00 00 	lea    0x7f45(%rip),%rdx        # 159be <exec_in_fp0+0x14e>
    da79:	48 8d 0d 50 23 00 00 	lea    0x2350(%rip),%rcx        # fdd0 <tp_kv_item>
    da80:	4c 8d 44 24 50       	lea    0x50(%rsp),%r8
    da85:	e8 e6 1f 00 00       	call   fa70 <tp_list_of>
    da8a:	85 c0                	test   %eax,%eax
    da8c:	0f 84 dc 0a 00 00    	je     e56e <tp_value+0xe5e>
    da92:	48 83 7c 24 68 00    	cmpq   $0x0,0x68(%rsp)
    da98:	0f 84 c3 0d 00 00    	je     e861 <tp_value+0x1151>
    da9e:	48 8d 05 5b e4 01 00 	lea    0x1e45b(%rip),%rax        # 2bf00 <fwp_empty_map>
    daa5:	45 31 f6             	xor    %r14d,%r14d
    daa8:	48 8b 4c 24 60       	mov    0x60(%rsp),%rcx
    daad:	4a 8b 3c f1          	mov    (%rcx,%r14,8),%rdi
    dab1:	4a 8b 74 f1 08       	mov    0x8(%rcx,%r14,8),%rsi
    dab6:	48 8b 4b 38          	mov    0x38(%rbx),%rcx
    daba:	48 89 c2             	mov    %rax,%rdx
    dabd:	e8 ee 23 00 00       	call   feb0 <fwp_p_map_insert>
    dac2:	49 83 c6 02          	add    $0x2,%r14
    dac6:	4c 3b 74 24 68       	cmp    0x68(%rsp),%r14
    dacb:	72 db                	jb     daa8 <tp_value+0x398>
    dacd:	e9 96 0d 00 00       	jmp    e868 <tp_value+0x1158>
    dad2:	66 0f ef c0          	pxor   %xmm0,%xmm0
    dad6:	f3 0f 7f 44 24 68    	movdqu %xmm0,0x68(%rsp)
    dadc:	f3 0f 7f 44 24 58    	movdqu %xmm0,0x58(%rsp)
    dae2:	48 c7 44 24 78 00 00 	movq   $0x0,0x78(%rsp)
    dae9:	00 00 
    daeb:	48 8b 4e 38          	mov    0x38(%rsi),%rcx
    daef:	48 89 4c 24 50       	mov    %rcx,0x50(%rsp)
    daf4:	83 f8 11             	cmp    $0x11,%eax
    daf7:	75 6c                	jne    db65 <tp_value+0x455>
    daf9:	4d 39 ef             	cmp    %r13,%r15
    dafc:	73 32                	jae    db30 <tp_value+0x420>
    dafe:	48 8b 07             	mov    (%rdi),%rax
    db01:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    db08:	00 00 00 
    db0b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    db10:	42 0f b6 14 38       	movzbl (%rax,%r15,1),%edx
    db15:	48 83 fa 20          	cmp    $0x20,%rdx
    db19:	77 15                	ja     db30 <tp_value+0x420>
    db1b:	48 0f a3 d1          	bt     %rdx,%rcx
    db1f:	73 0f                	jae    db30 <tp_value+0x420>
    db21:	49 ff c7             	inc    %r15
    db24:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    db28:	4d 39 fd             	cmp    %r15,%r13
    db2b:	75 e3                	jne    db10 <tp_value+0x400>
    db2d:	4d 89 ef             	mov    %r13,%r15
    db30:	4d 29 fd             	sub    %r15,%r13
    db33:	45 31 f6             	xor    %r14d,%r14d
    db36:	49 83 fd 05          	cmp    $0x5,%r13
    db3a:	0f 82 97 01 00 00    	jb     dcd7 <tp_value+0x5c7>
    db40:	48 8b 07             	mov    (%rdi),%rax
    db43:	b9 61 72 72 61       	mov    $0x61727261,%ecx
    db48:	42 33 0c 38          	xor    (%rax,%r15,1),%ecx
    db4c:	42 0f b6 44 38 04    	movzbl 0x4(%rax,%r15,1),%eax
    db52:	83 f0 79             	xor    $0x79,%eax
    db55:	09 c8                	or     %ecx,%eax
    db57:	0f 85 7a 01 00 00    	jne    dcd7 <tp_value+0x5c7>
    db5d:	49 83 c7 05          	add    $0x5,%r15
    db61:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    db65:	48 89 f3             	mov    %rsi,%rbx
    db68:	48 8d 35 e2 7d 00 00 	lea    0x7de2(%rip),%rsi        # 15951 <exec_in_fp0+0xe1>
    db6f:	48 8d 15 81 8d 00 00 	lea    0x8d81(%rip),%rdx        # 168f7 <exec_in_fp0+0x1087>
    db76:	48 8d 0d 13 22 00 00 	lea    0x2213(%rip),%rcx        # fd90 <tp_elem_item>
    db7d:	4c 8d 44 24 50       	lea    0x50(%rsp),%r8
    db82:	e8 e9 1e 00 00       	call   fa70 <tp_list_of>
    db87:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
    db8c:	85 c0                	test   %eax,%eax
    db8e:	0f 84 2a 05 00 00    	je     e0be <tp_value+0x9ae>
    db94:	48 8b 74 24 68       	mov    0x68(%rsp),%rsi
    db99:	e8 82 f2 ff ff       	call   ce20 <fwp_list_from>
    db9e:	49 89 c6             	mov    %rax,%r14
    dba1:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
    dba6:	e8 35 cf ff ff       	call   aae0 <fwp_mem_free>
    dbab:	83 3b 11             	cmpl   $0x11,(%rbx)
    dbae:	0f 85 4a 10 00 00    	jne    ebfe <tp_value+0x14ee>
    dbb4:	4c 8b 7b 38          	mov    0x38(%rbx),%r15
    dbb8:	4d 85 f6             	test   %r14,%r14
    dbbb:	0f 84 e5 0a 00 00    	je     e6a6 <tp_value+0xf96>
    dbc1:	31 ff                	xor    %edi,%edi
    dbc3:	4c 89 f0             	mov    %r14,%rax
    dbc6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    dbcd:	00 00 00 
    dbd0:	48 ff c7             	inc    %rdi
    dbd3:	48 8b 40 10          	mov    0x10(%rax),%rax
    dbd7:	48 85 c0             	test   %rax,%rax
    dbda:	75 f4                	jne    dbd0 <tp_value+0x4c0>
    dbdc:	4c 89 fe             	mov    %r15,%rsi
    dbdf:	e8 1c 7c ff ff       	call   5800 <fwp_array_new_packed>
    dbe4:	b9 04 00 00 00       	mov    $0x4,%ecx
    dbe9:	ba 84 04 00 00       	mov    $0x484,%edx
    dbee:	be 21 00 00 00       	mov    $0x21,%esi
    dbf3:	bf 42 00 00 00       	mov    $0x42,%edi
    dbf8:	4d 89 f0             	mov    %r14,%r8
    dbfb:	eb 15                	jmp    dc12 <tp_value+0x502>
    dbfd:	4c 89 4c c8 e8       	mov    %r9,-0x18(%rax,%rcx,8)
    dc02:	4d 8b 40 10          	mov    0x10(%r8),%r8
    dc06:	48 ff c1             	inc    %rcx
    dc09:	4d 85 c0             	test   %r8,%r8
    dc0c:	0f 84 9e 0a 00 00    	je     e6b0 <tp_value+0xfa0>
    dc12:	48 83 38 00          	cmpq   $0x0,(%rax)
    dc16:	0f 88 cb 12 00 00    	js     eee7 <tp_value+0x17d7>
    dc1c:	4d 8b 48 08          	mov    0x8(%r8),%r9
    dc20:	4d 85 ff             	test   %r15,%r15
    dc23:	74 d8                	je     dbfd <tp_value+0x4ed>
    dc25:	45 8b 17             	mov    (%r15),%r10d
    dc28:	41 83 fa 0a          	cmp    $0xa,%r10d
    dc2c:	77 cf                	ja     dbfd <tp_value+0x4ed>
    dc2e:	44 0f a3 d2          	bt     %r10d,%edx
    dc32:	72 13                	jb     dc47 <tp_value+0x537>
    dc34:	44 0f a3 d6          	bt     %r10d,%esi
    dc38:	72 14                	jb     dc4e <tp_value+0x53e>
    dc3a:	44 0f a3 d7          	bt     %r10d,%edi
    dc3e:	73 bd                	jae    dbfd <tp_value+0x4ed>
    dc40:	66 44 89 0c 48       	mov    %r9w,(%rax,%rcx,2)
    dc45:	eb bb                	jmp    dc02 <tp_value+0x4f2>
    dc47:	44 89 4c 88 f8       	mov    %r9d,-0x8(%rax,%rcx,4)
    dc4c:	eb b4                	jmp    dc02 <tp_value+0x4f2>
    dc4e:	44 88 4c 08 04       	mov    %r9b,0x4(%rax,%rcx,1)
    dc53:	eb ad                	jmp    dc02 <tp_value+0x4f2>
    dc55:	49 89 f7             	mov    %rsi,%r15
    dc58:	48 8d 74 24 50       	lea    0x50(%rsp),%rsi
    dc5d:	ba 80 00 00 00       	mov    $0x80,%edx
    dc62:	e8 49 20 00 00       	call   fcb0 <tp_token>
    dc67:	45 31 f6             	xor    %r14d,%r14d
    dc6a:	48 83 f8 7f          	cmp    $0x7f,%rax
    dc6e:	77 67                	ja     dcd7 <tp_value+0x5c7>
    dc70:	8b 54 24 50          	mov    0x50(%rsp),%edx
    dc74:	81 fa 69 6e 66 00    	cmp    $0x666e69,%edx
    dc7a:	0f 85 0c 04 00 00    	jne    e08c <tp_value+0x97c>
    dc80:	f2 0f 10 05 38 75 00 	movsd  0x7538(%rip),%xmm0        # 151c0 <_IO_stdin_used+0x1c0>
    dc87:	00 
    dc88:	4c 89 f9             	mov    %r15,%rcx
    dc8b:	e9 f5 08 00 00       	jmp    e585 <tp_value+0xe75>
    dc90:	48 89 fb             	mov    %rdi,%rbx
    dc93:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    dc97:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    dc9d:	4c 01 f1             	add    %r14,%rcx
    dca0:	48 89 08             	mov    %rcx,(%rax)
    dca3:	4c 89 f7             	mov    %r14,%rdi
    dca6:	31 f6                	xor    %esi,%esi
    dca8:	e8 63 55 ff ff       	call   3210 <memset@plt>
    dcad:	4d 89 2e             	mov    %r13,(%r14)
    dcb0:	49 8d 7e 08          	lea    0x8(%r14),%rdi
    dcb4:	4c 89 e6             	mov    %r12,%rsi
    dcb7:	4c 89 ea             	mov    %r13,%rdx
    dcba:	e8 71 56 ff ff       	call   3330 <memcpy@plt>
    dcbf:	43 c6 44 2e 08 00    	movb   $0x0,0x8(%r14,%r13,1)
    dcc5:	4c 89 75 00          	mov    %r14,0x0(%rbp)
    dcc9:	48 8b 43 08          	mov    0x8(%rbx),%rax
    dccd:	48 89 43 10          	mov    %rax,0x10(%rbx)
    dcd1:	41 be 01 00 00 00    	mov    $0x1,%r14d
    dcd7:	44 89 f0             	mov    %r14d,%eax
    dcda:	48 81 c4 d8 01 00 00 	add    $0x1d8,%rsp
    dce1:	5b                   	pop    %rbx
    dce2:	41 5c                	pop    %r12
    dce4:	41 5d                	pop    %r13
    dce6:	41 5e                	pop    %r14
    dce8:	41 5f                	pop    %r15
    dcea:	5d                   	pop    %rbp
    dceb:	c3                   	ret
    dcec:	85 d2                	test   %edx,%edx
    dcee:	0f 85 49 fa ff ff    	jne    d73d <tp_value+0x2d>
    dcf4:	4c 89 e6             	mov    %r12,%rsi
    dcf7:	48 81 c4 d8 01 00 00 	add    $0x1d8,%rsp
    dcfe:	5b                   	pop    %rbx
    dcff:	41 5c                	pop    %r12
    dd01:	41 5d                	pop    %r13
    dd03:	41 5e                	pop    %r14
    dd05:	41 5f                	pop    %r15
    dd07:	5d                   	pop    %rbp
    dd08:	e9 e3 18 00 00       	jmp    f5f0 <tp_quoted>
    dd0d:	66 0f ef c0          	pxor   %xmm0,%xmm0
    dd11:	66 0f 7f 44 24 70    	movdqa %xmm0,0x70(%rsp)
    dd17:	66 0f 7f 44 24 60    	movdqa %xmm0,0x60(%rsp)
    dd1d:	66 0f 7f 44 24 50    	movdqa %xmm0,0x50(%rsp)
    dd23:	4d 39 ef             	cmp    %r13,%r15
    dd26:	73 38                	jae    dd60 <tp_value+0x650>
    dd28:	48 8b 07             	mov    (%rdi),%rax
    dd2b:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    dd32:	00 00 00 
    dd35:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    dd3c:	00 00 00 00 
    dd40:	42 0f b6 14 38       	movzbl (%rax,%r15,1),%edx
    dd45:	48 83 fa 20          	cmp    $0x20,%rdx
    dd49:	77 15                	ja     dd60 <tp_value+0x650>
    dd4b:	48 0f a3 d1          	bt     %rdx,%rcx
    dd4f:	73 0f                	jae    dd60 <tp_value+0x650>
    dd51:	49 ff c7             	inc    %r15
    dd54:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    dd58:	4d 39 fd             	cmp    %r15,%r13
    dd5b:	75 e3                	jne    dd40 <tp_value+0x630>
    dd5d:	4d 89 ef             	mov    %r13,%r15
    dd60:	4d 29 fd             	sub    %r15,%r13
    dd63:	45 31 f6             	xor    %r14d,%r14d
    dd66:	49 83 fd 05          	cmp    $0x5,%r13
    dd6a:	72 1d                	jb     dd89 <tp_value+0x679>
    dd6c:	48 8b 07             	mov    (%rdi),%rax
    dd6f:	b9 62 79 74 65       	mov    $0x65747962,%ecx
    dd74:	42 33 0c 38          	xor    (%rax,%r15,1),%ecx
    dd78:	42 0f b6 44 38 04    	movzbl 0x4(%rax,%r15,1),%eax
    dd7e:	83 f0 73             	xor    $0x73,%eax
    dd81:	09 c8                	or     %ecx,%eax
    dd83:	0f 84 43 07 00 00    	je     e4cc <tp_value+0xdbc>
    dd89:	31 ff                	xor    %edi,%edi
    dd8b:	e8 50 cd ff ff       	call   aae0 <fwp_mem_free>
    dd90:	e9 42 ff ff ff       	jmp    dcd7 <tp_value+0x5c7>
    dd95:	48 89 f3             	mov    %rsi,%rbx
    dd98:	48 8d 74 24 50       	lea    0x50(%rsp),%rsi
    dd9d:	ba 00 01 00 00       	mov    $0x100,%edx
    dda2:	e8 09 1f 00 00       	call   fcb0 <tp_token>
    dda7:	45 31 f6             	xor    %r14d,%r14d
    ddaa:	48 83 f8 02          	cmp    $0x2,%rax
    ddae:	0f 82 23 ff ff ff    	jb     dcd7 <tp_value+0x5c7>
    ddb4:	80 7c 24 50 30       	cmpb   $0x30,0x50(%rsp)
    ddb9:	0f 85 18 ff ff ff    	jne    dcd7 <tp_value+0x5c7>
    ddbf:	80 7c 24 51 74       	cmpb   $0x74,0x51(%rsp)
    ddc4:	0f 85 0d ff ff ff    	jne    dcd7 <tp_value+0x5c7>
    ddca:	48 8d 48 fe          	lea    -0x2(%rax),%rcx
    ddce:	48 63 53 48          	movslq 0x48(%rbx),%rdx
    ddd2:	48 39 d1             	cmp    %rdx,%rcx
    ddd5:	0f 87 fc fe ff ff    	ja     dcd7 <tp_value+0x5c7>
    dddb:	48 83 f8 03          	cmp    $0x3,%rax
    dddf:	0f 82 d3 08 00 00    	jb     e6b8 <tp_value+0xfa8>
    dde5:	ba 02 00 00 00       	mov    $0x2,%edx
    ddea:	31 c9                	xor    %ecx,%ecx
    ddec:	e9 0a 02 00 00       	jmp    dffb <tp_value+0x8eb>
    ddf1:	48 8d 74 24 50       	lea    0x50(%rsp),%rsi
    ddf6:	ba 10 00 00 00       	mov    $0x10,%edx
    ddfb:	e8 b0 1e 00 00       	call   fcb0 <tp_token>
    de00:	8b 44 24 50          	mov    0x50(%rsp),%eax
    de04:	89 c1                	mov    %eax,%ecx
    de06:	81 f1 2b 31 00 00    	xor    $0x312b,%ecx
    de0c:	0f b6 54 24 52       	movzbl 0x52(%rsp),%edx
    de11:	66 09 ca             	or     %cx,%dx
    de14:	41 be 01 00 00 00    	mov    $0x1,%r14d
    de1a:	0f 84 de 0d 00 00    	je     ebfe <tp_value+0x14ee>
    de20:	66 83 f8 31          	cmp    $0x31,%ax
    de24:	0f 84 d4 0d 00 00    	je     ebfe <tp_value+0x14ee>
    de2a:	45 31 f6             	xor    %r14d,%r14d
    de2d:	66 83 f8 30          	cmp    $0x30,%ax
    de31:	0f 84 c7 0d 00 00    	je     ebfe <tp_value+0x14ee>
    de37:	b8 2d 31 00 00       	mov    $0x312d,%eax
    de3c:	33 44 24 50          	xor    0x50(%rsp),%eax
    de40:	0f b6 4c 24 52       	movzbl 0x52(%rsp),%ecx
    de45:	66 09 c1             	or     %ax,%cx
    de48:	0f 85 89 fe ff ff    	jne    dcd7 <tp_value+0x5c7>
    de4e:	49 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%r14
    de55:	e9 a4 0d 00 00       	jmp    ebfe <tp_value+0x14ee>
    de5a:	48 8b 6e 08          	mov    0x8(%rsi),%rbp
    de5e:	48 85 ed             	test   %rbp,%rbp
    de61:	4c 89 64 24 18       	mov    %r12,0x18(%rsp)
    de66:	0f 84 5f 02 00 00    	je     e0cb <tp_value+0x9bb>
    de6c:	48 89 f3             	mov    %rsi,%rbx
    de6f:	49 89 fe             	mov    %rdi,%r14
    de72:	48 8d 35 4c 88 00 00 	lea    0x884c(%rip),%rsi        # 166c5 <exec_in_fp0+0xe55>
    de79:	48 89 ef             	mov    %rbp,%rdi
    de7c:	e8 4f 54 ff ff       	call   32d0 <strcmp@plt>
    de81:	85 c0                	test   %eax,%eax
    de83:	0f 84 06 05 00 00    	je     e38f <tp_value+0xc7f>
    de89:	48 89 d8             	mov    %rbx,%rax
    de8c:	44 8b 63 10          	mov    0x10(%rbx),%r12d
    de90:	4d 39 ef             	cmp    %r13,%r15
    de93:	73 30                	jae    dec5 <tp_value+0x7b5>
    de95:	4c 89 f1             	mov    %r14,%rcx
    de98:	49 8b 16             	mov    (%r14),%rdx
    de9b:	48 be 00 26 00 00 01 	movabs $0x100002600,%rsi
    dea2:	00 00 00 
    dea5:	42 0f b6 3c 3a       	movzbl (%rdx,%r15,1),%edi
    deaa:	48 83 ff 20          	cmp    $0x20,%rdi
    deae:	77 15                	ja     dec5 <tp_value+0x7b5>
    deb0:	48 0f a3 fe          	bt     %rdi,%rsi
    deb4:	73 0f                	jae    dec5 <tp_value+0x7b5>
    deb6:	49 ff c7             	inc    %r15
    deb9:	4c 89 79 10          	mov    %r15,0x10(%rcx)
    debd:	4d 39 fd             	cmp    %r15,%r13
    dec0:	75 e3                	jne    dea5 <tp_value+0x795>
    dec2:	4d 89 ef             	mov    %r13,%r15
    dec5:	48 83 c0 10          	add    $0x10,%rax
    dec9:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    dece:	48 89 ef             	mov    %rbp,%rdi
    ded1:	e8 9a 52 ff ff       	call   3170 <strlen@plt>
    ded6:	4d 29 fd             	sub    %r15,%r13
    ded9:	49 39 c5             	cmp    %rax,%r13
    dedc:	72 1c                	jb     defa <tp_value+0x7ea>
    dede:	49 8b 3e             	mov    (%r14),%rdi
    dee1:	4c 01 ff             	add    %r15,%rdi
    dee4:	48 89 ee             	mov    %rbp,%rsi
    dee7:	49 89 c5             	mov    %rax,%r13
    deea:	48 89 c2             	mov    %rax,%rdx
    deed:	e8 7e 54 ff ff       	call   3370 <bcmp@plt>
    def2:	85 c0                	test   %eax,%eax
    def4:	0f 84 58 0b 00 00    	je     ea52 <tp_value+0x1342>
    defa:	4c 89 f7             	mov    %r14,%rdi
    defd:	48 89 de             	mov    %rbx,%rsi
    df00:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    df05:	49 63 c4             	movslq %r12d,%rax
    df08:	48 8d 04 c5 08 00 00 	lea    0x8(,%rax,8),%rax
    df0f:	00 
    df10:	4c 8b 25 91 df 00 00 	mov    0xdf91(%rip),%r12        # 1bea8 <measured_calls>
    df17:	49 ff c4             	inc    %r12
    df1a:	4c 89 25 87 df 00 00 	mov    %r12,0xdf87(%rip)        # 1bea8 <measured_calls>
    df21:	4c 8b 2d 88 df 00 00 	mov    0xdf88(%rip),%r13        # 1beb0 <measured_bytes>
    df28:	49 01 c5             	add    %rax,%r13
    df2b:	4c 89 2d 7e df 00 00 	mov    %r13,0xdf7e(%rip)        # 1beb0 <measured_bytes>
    df32:	4c 8d 35 4f c3 00 00 	lea    0xc34f(%rip),%r14        # 1a288 <fwp_gc>
    df39:	48 3d 00 40 00 00    	cmp    $0x4000,%rax
    df3f:	0f 87 79 06 00 00    	ja     e5be <tp_value+0xeae>
    df45:	48 8d 48 0f          	lea    0xf(%rax),%rcx
    df49:	48 c1 e9 04          	shr    $0x4,%rcx
    df4d:	42 0f b6 8c 31 e8 0b 	movzbl 0xbe8(%rcx,%r14,1),%ecx
    df54:	00 00 
    df56:	41 8b 94 8e 48 0b 00 	mov    0xb48(%r14,%rcx,4),%edx
    df5d:	00 
    df5e:	48 29 15 23 c3 00 00 	sub    %rdx,0xc323(%rip)        # 1a288 <fwp_gc>
    df65:	0f 88 53 06 00 00    	js     e5be <tp_value+0xeae>
    df6b:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    df6f:	4d 8d 04 ce          	lea    (%r14,%rcx,8),%r8
    df73:	49 81 c0 88 07 00 00 	add    $0x788,%r8
    df7a:	4d 8b 08             	mov    (%r8),%r9
    df7d:	4d 85 c9             	test   %r9,%r9
    df80:	0f 84 1c 06 00 00    	je     e5a2 <tp_value+0xe92>
    df86:	48 89 f5             	mov    %rsi,%rbp
    df89:	48 89 fb             	mov    %rdi,%rbx
    df8c:	49 8b 01             	mov    (%r9),%rax
    df8f:	48 f7 d0             	not    %rax
    df92:	49 89 00             	mov    %rax,(%r8)
    df95:	e9 40 07 00 00       	jmp    e6da <tp_value+0xfca>
    df9a:	48 8b 07             	mov    (%rdi),%rax
    df9d:	4d 39 ef             	cmp    %r13,%r15
    dfa0:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    dfa5:	89 54 24 08          	mov    %edx,0x8(%rsp)
    dfa9:	73 77                	jae    e022 <tp_value+0x912>
    dfab:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    dfb2:	00 00 00 
    dfb5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    dfbc:	00 00 00 00 
    dfc0:	46 0f b6 04 38       	movzbl (%rax,%r15,1),%r8d
    dfc5:	49 83 f8 20          	cmp    $0x20,%r8
    dfc9:	77 57                	ja     e022 <tp_value+0x912>
    dfcb:	4c 0f a3 c1          	bt     %r8,%rcx
    dfcf:	73 51                	jae    e022 <tp_value+0x912>
    dfd1:	49 ff c7             	inc    %r15
    dfd4:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    dfd8:	4d 39 fd             	cmp    %r15,%r13
    dfdb:	75 e3                	jne    dfc0 <tp_value+0x8b0>
    dfdd:	48 89 f5             	mov    %rsi,%rbp
    dfe0:	4d 89 ef             	mov    %r13,%r15
    dfe3:	e9 19 02 00 00       	jmp    e201 <tp_value+0xaf1>
    dfe8:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    dfec:	48 ff c9             	dec    %rcx
    dfef:	48 ff c2             	inc    %rdx
    dff2:	48 39 d0             	cmp    %rdx,%rax
    dff5:	0f 84 bf 06 00 00    	je     e6ba <tp_value+0xfaa>
    dffb:	0f b6 74 14 50       	movzbl 0x50(%rsp,%rdx,1),%esi
    e000:	83 fe 30             	cmp    $0x30,%esi
    e003:	74 17                	je     e01c <tp_value+0x90c>
    e005:	83 fe 2d             	cmp    $0x2d,%esi
    e008:	74 de                	je     dfe8 <tp_value+0x8d8>
    e00a:	83 fe 2b             	cmp    $0x2b,%esi
    e00d:	0f 85 12 0e 00 00    	jne    ee25 <tp_value+0x1715>
    e013:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    e017:	48 ff c1             	inc    %rcx
    e01a:	eb d3                	jmp    dfef <tp_value+0x8df>
    e01c:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    e020:	eb cd                	jmp    dfef <tp_value+0x8df>
    e022:	4d 39 ef             	cmp    %r13,%r15
    e025:	0f 83 cb 01 00 00    	jae    e1f6 <tp_value+0xae6>
    e02b:	49 b8 03 00 00 00 00 	movabs $0x4000000000003,%r8
    e032:	00 04 00 
    e035:	4c 89 f9             	mov    %r15,%rcx
    e038:	eb 16                	jmp    e050 <tp_value+0x940>
    e03a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    e040:	48 ff c1             	inc    %rcx
    e043:	48 89 4f 10          	mov    %rcx,0x10(%rdi)
    e047:	49 39 cd             	cmp    %rcx,%r13
    e04a:	0f 84 ae 01 00 00    	je     e1fe <tp_value+0xaee>
    e050:	44 0f b6 0c 08       	movzbl (%rax,%rcx,1),%r9d
    e055:	45 8d 51 d0          	lea    -0x30(%r9),%r10d
    e059:	41 80 fa 0a          	cmp    $0xa,%r10b
    e05d:	72 e1                	jb     e040 <tp_value+0x930>
    e05f:	45 89 ca             	mov    %r9d,%r10d
    e062:	41 80 e2 df          	and    $0xdf,%r10b
    e066:	41 80 c2 bf          	add    $0xbf,%r10b
    e06a:	41 80 fa 1a          	cmp    $0x1a,%r10b
    e06e:	72 d0                	jb     e040 <tp_value+0x930>
    e070:	45 0f b6 c9          	movzbl %r9b,%r9d
    e074:	41 83 c1 d3          	add    $0xffffffd3,%r9d
    e078:	41 83 f9 32          	cmp    $0x32,%r9d
    e07c:	77 06                	ja     e084 <tp_value+0x974>
    e07e:	4d 0f a3 c8          	bt     %r9,%r8
    e082:	72 bc                	jb     e040 <tp_value+0x930>
    e084:	48 89 f5             	mov    %rsi,%rbp
    e087:	e9 78 01 00 00       	jmp    e204 <tp_value+0xaf4>
    e08c:	b9 2d 69 6e 66       	mov    $0x666e692d,%ecx
    e091:	33 4c 24 50          	xor    0x50(%rsp),%ecx
    e095:	0f b6 74 24 54       	movzbl 0x54(%rsp),%esi
    e09a:	09 ce                	or     %ecx,%esi
    e09c:	4c 89 f9             	mov    %r15,%rcx
    e09f:	0f 84 d8 04 00 00    	je     e57d <tp_value+0xe6d>
    e0a5:	81 fa 4e 61 4e 00    	cmp    $0x4e614e,%edx
    e0ab:	0f 85 38 05 00 00    	jne    e5e9 <tp_value+0xed9>
    e0b1:	f2 0f 10 05 17 71 00 	movsd  0x7117(%rip),%xmm0        # 151d0 <_IO_stdin_used+0x1d0>
    e0b8:	00 
    e0b9:	e9 c7 04 00 00       	jmp    e585 <tp_value+0xe75>
    e0be:	e8 1d ca ff ff       	call   aae0 <fwp_mem_free>
    e0c3:	45 31 f6             	xor    %r14d,%r14d
    e0c6:	e9 0c fc ff ff       	jmp    dcd7 <tp_value+0x5c7>
    e0cb:	4c 63 66 10          	movslq 0x10(%rsi),%r12
    e0cf:	4d 85 e4             	test   %r12,%r12
    e0d2:	0f 84 8f 05 00 00    	je     e667 <tp_value+0xf57>
    e0d8:	4c 8d 7e 10          	lea    0x10(%rsi),%r15
    e0dc:	83 7e 48 00          	cmpl   $0x0,0x48(%rsi)
    e0e0:	0f 84 1f fe ff ff    	je     df05 <tp_value+0x7f5>
    e0e6:	48 89 f3             	mov    %rsi,%rbx
    e0e9:	49 c1 e4 03          	shl    $0x3,%r12
    e0ed:	49 89 fd             	mov    %rdi,%r13
    e0f0:	4c 89 e7             	mov    %r12,%rdi
    e0f3:	e8 d8 a0 ff ff       	call   81d0 <fwp_alloc>
    e0f8:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    e0fd:	48 8d 35 d1 85 00 00 	lea    0x85d1(%rip),%rsi        # 166d5 <exec_in_fp0+0xe65>
    e104:	4d 89 ec             	mov    %r13,%r12
    e107:	4c 89 ef             	mov    %r13,%rdi
    e10a:	e8 c1 18 00 00       	call   f9d0 <tp_eat>
    e10f:	85 c0                	test   %eax,%eax
    e111:	0f 84 c0 fb ff ff    	je     dcd7 <tp_value+0x5c7>
    e117:	41 83 3f 00          	cmpl   $0x0,(%r15)
    e11b:	4c 89 e7             	mov    %r12,%rdi
    e11e:	0f 8e 9e 00 00 00    	jle    e1c2 <tp_value+0xab2>
    e124:	45 31 ed             	xor    %r13d,%r13d
    e127:	48 bd 00 26 00 00 01 	movabs $0x100002600,%rbp
    e12e:	00 00 00 
    e131:	4d 85 ed             	test   %r13,%r13
    e134:	74 54                	je     e18a <tp_value+0xa7a>
    e136:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
    e13a:	48 8b 47 10          	mov    0x10(%rdi),%rax
    e13e:	48 39 c8             	cmp    %rcx,%rax
    e141:	73 27                	jae    e16a <tp_value+0xa5a>
    e143:	48 8b 17             	mov    (%rdi),%rdx
    e146:	0f b6 34 02          	movzbl (%rdx,%rax,1),%esi
    e14a:	48 83 fe 20          	cmp    $0x20,%rsi
    e14e:	77 1a                	ja     e16a <tp_value+0xa5a>
    e150:	48 0f a3 f5          	bt     %rsi,%rbp
    e154:	73 14                	jae    e16a <tp_value+0xa5a>
    e156:	48 ff c0             	inc    %rax
    e159:	48 89 47 10          	mov    %rax,0x10(%rdi)
    e15d:	45 31 f6             	xor    %r14d,%r14d
    e160:	48 39 c1             	cmp    %rax,%rcx
    e163:	75 e1                	jne    e146 <tp_value+0xa36>
    e165:	e9 6d fb ff ff       	jmp    dcd7 <tp_value+0x5c7>
    e16a:	45 31 f6             	xor    %r14d,%r14d
    e16d:	48 39 c1             	cmp    %rax,%rcx
    e170:	0f 84 61 fb ff ff    	je     dcd7 <tp_value+0x5c7>
    e176:	48 8b 0f             	mov    (%rdi),%rcx
    e179:	80 3c 01 2c          	cmpb   $0x2c,(%rcx,%rax,1)
    e17d:	0f 85 54 fb ff ff    	jne    dcd7 <tp_value+0x5c7>
    e183:	48 ff c0             	inc    %rax
    e186:	48 89 47 10          	mov    %rax,0x10(%rdi)
    e18a:	48 8b 43 20          	mov    0x20(%rbx),%rax
    e18e:	4a 8b 34 e8          	mov    (%rax,%r13,8),%rsi
    e192:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    e197:	4a 8d 0c e8          	lea    (%rax,%r13,8),%rcx
    e19b:	45 31 f6             	xor    %r14d,%r14d
    e19e:	4c 89 e7             	mov    %r12,%rdi
    e1a1:	31 d2                	xor    %edx,%edx
    e1a3:	e8 68 f5 ff ff       	call   d710 <tp_value>
    e1a8:	85 c0                	test   %eax,%eax
    e1aa:	0f 84 27 fb ff ff    	je     dcd7 <tp_value+0x5c7>
    e1b0:	4c 89 e7             	mov    %r12,%rdi
    e1b3:	49 ff c5             	inc    %r13
    e1b6:	49 63 07             	movslq (%r15),%rax
    e1b9:	49 39 c5             	cmp    %rax,%r13
    e1bc:	0f 8c 6f ff ff ff    	jl     e131 <tp_value+0xa21>
    e1c2:	48 8d 35 cd 85 00 00 	lea    0x85cd(%rip),%rsi        # 16796 <exec_in_fp0+0xf26>
    e1c9:	e8 02 18 00 00       	call   f9d0 <tp_eat>
    e1ce:	41 be 00 00 00 00    	mov    $0x0,%r14d
    e1d4:	85 c0                	test   %eax,%eax
    e1d6:	0f 84 fb fa ff ff    	je     dcd7 <tp_value+0x5c7>
    e1dc:	41 8b 3f             	mov    (%r15),%edi
    e1df:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    e1e4:	e8 87 1f 00 00       	call   10170 <fwp_record>
    e1e9:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    e1ee:	48 89 01             	mov    %rax,(%rcx)
    e1f1:	e9 db fa ff ff       	jmp    dcd1 <tp_value+0x5c1>
    e1f6:	48 89 f5             	mov    %rsi,%rbp
    e1f9:	4c 89 f9             	mov    %r15,%rcx
    e1fc:	eb 06                	jmp    e204 <tp_value+0xaf4>
    e1fe:	48 89 f5             	mov    %rsi,%rbp
    e201:	4c 89 e9             	mov    %r13,%rcx
    e204:	4c 89 64 24 18       	mov    %r12,0x18(%rsp)
    e209:	4c 29 f9             	sub    %r15,%rcx
    e20c:	48 81 f9 ff 00 00 00 	cmp    $0xff,%rcx
    e213:	41 be ff 00 00 00    	mov    $0xff,%r14d
    e219:	4c 0f 42 f1          	cmovb  %rcx,%r14
    e21d:	4c 01 f8             	add    %r15,%rax
    e220:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    e225:	48 89 c6             	mov    %rax,%rsi
    e228:	4c 89 f2             	mov    %r14,%rdx
    e22b:	e8 00 51 ff ff       	call   3330 <memcpy@plt>
    e230:	42 c6 44 34 50 00    	movb   $0x0,0x50(%rsp,%r14,1)
    e236:	44 8b 6d 10          	mov    0x10(%rbp),%r13d
    e23a:	45 85 ed             	test   %r13d,%r13d
    e23d:	7e 3d                	jle    e27c <tp_value+0xb6c>
    e23f:	49 89 ef             	mov    %rbp,%r15
    e242:	48 8b 5d 18          	mov    0x18(%rbp),%rbx
    e246:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    e24b:	45 31 e4             	xor    %r12d,%r12d
    e24e:	4c 8d 74 24 50       	lea    0x50(%rsp),%r14
    e253:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    e25a:	84 00 00 00 00 00 
    e260:	4a 8b 3c e3          	mov    (%rbx,%r12,8),%rdi
    e264:	4c 89 f6             	mov    %r14,%rsi
    e267:	e8 64 50 ff ff       	call   32d0 <strcmp@plt>
    e26c:	85 c0                	test   %eax,%eax
    e26e:	41 0f 44 ec          	cmove  %r12d,%ebp
    e272:	49 ff c4             	inc    %r12
    e275:	4d 39 e5             	cmp    %r12,%r13
    e278:	75 e6                	jne    e260 <tp_value+0xb50>
    e27a:	eb 08                	jmp    e284 <tp_value+0xb74>
    e27c:	49 89 ef             	mov    %rbp,%r15
    e27f:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    e284:	83 7c 24 08 00       	cmpl   $0x0,0x8(%rsp)
    e289:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    e28e:	74 60                	je     e2f0 <tp_value+0xbe0>
    e290:	85 ed                	test   %ebp,%ebp
    e292:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
    e297:	79 5c                	jns    e2f5 <tp_value+0xbe5>
    e299:	49 8b 7f 08          	mov    0x8(%r15),%rdi
    e29d:	45 31 f6             	xor    %r14d,%r14d
    e2a0:	48 85 ff             	test   %rdi,%rdi
    e2a3:	0f 84 2e fa ff ff    	je     dcd7 <tp_value+0x5c7>
    e2a9:	48 8d 35 f7 83 00 00 	lea    0x83f7(%rip),%rsi        # 166a7 <exec_in_fp0+0xe37>
    e2b0:	e8 1b 50 ff ff       	call   32d0 <strcmp@plt>
    e2b5:	85 c0                	test   %eax,%eax
    e2b7:	0f 85 1a fa ff ff    	jne    dcd7 <tp_value+0x5c7>
    e2bd:	4c 89 fe             	mov    %r15,%rsi
    e2c0:	8b 44 24 50          	mov    0x50(%rsp),%eax
    e2c4:	89 c2                	mov    %eax,%edx
    e2c6:	81 f2 74 72 75 65    	xor    $0x65757274,%edx
    e2cc:	0f b6 7c 24 54       	movzbl 0x54(%rsp),%edi
    e2d1:	09 d7                	or     %edx,%edi
    e2d3:	ba 01 00 00 00       	mov    $0x1,%edx
    e2d8:	0f 44 ea             	cmove  %edx,%ebp
    e2db:	35 66 61 6c 73       	xor    $0x736c6166,%eax
    e2e0:	0f b7 54 24 54       	movzwl 0x54(%rsp),%edx
    e2e5:	83 f2 65             	xor    $0x65,%edx
    e2e8:	09 c2                	or     %eax,%edx
    e2ea:	75 0c                	jne    e2f8 <tp_value+0xbe8>
    e2ec:	31 ed                	xor    %ebp,%ebp
    e2ee:	eb 10                	jmp    e300 <tp_value+0xbf0>
    e2f0:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
    e2f5:	4c 89 fe             	mov    %r15,%rsi
    e2f8:	85 ed                	test   %ebp,%ebp
    e2fa:	0f 88 25 0b 00 00    	js     ee25 <tp_value+0x1715>
    e300:	48 8b 46 28          	mov    0x28(%rsi),%rax
    e304:	41 89 ee             	mov    %ebp,%r14d
    e307:	4e 63 3c b0          	movslq (%rax,%r14,4),%r15
    e30b:	45 89 fa             	mov    %r15d,%r10d
    e30e:	4a 8d 3c fd 08 00 00 	lea    0x8(,%r15,8),%rdi
    e315:	00 
    e316:	48 ff 05 8b db 00 00 	incq   0xdb8b(%rip)        # 1bea8 <measured_calls>
    e31d:	48 01 3d 8c db 00 00 	add    %rdi,0xdb8c(%rip)        # 1beb0 <measured_bytes>
    e324:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    e32b:	4c 89 54 24 20       	mov    %r10,0x20(%rsp)
    e330:	0f 87 1a 03 00 00    	ja     e650 <tp_value+0xf40>
    e336:	48 8d 57 0f          	lea    0xf(%rdi),%rdx
    e33a:	48 c1 ea 04          	shr    $0x4,%rdx
    e33e:	48 8d 05 43 bf 00 00 	lea    0xbf43(%rip),%rax        # 1a288 <fwp_gc>
    e345:	44 0f b6 84 02 e8 0b 	movzbl 0xbe8(%rdx,%rax,1),%r8d
    e34c:	00 00 
    e34e:	42 8b 94 80 48 0b 00 	mov    0xb48(%rax,%r8,4),%edx
    e355:	00 
    e356:	48 29 15 2b bf 00 00 	sub    %rdx,0xbf2b(%rip)        # 1a288 <fwp_gc>
    e35d:	0f 88 ed 02 00 00    	js     e650 <tp_value+0xf40>
    e363:	4f 8d 04 40          	lea    (%r8,%r8,2),%r8
    e367:	4e 8d 0c c0          	lea    (%rax,%r8,8),%r9
    e36b:	49 81 c1 88 07 00 00 	add    $0x788,%r9
    e372:	4d 8b 19             	mov    (%r9),%r11
    e375:	4d 85 db             	test   %r11,%r11
    e378:	0f 84 b6 02 00 00    	je     e634 <tp_value+0xf24>
    e37e:	48 89 f3             	mov    %rsi,%rbx
    e381:	49 8b 03             	mov    (%r11),%rax
    e384:	48 f7 d0             	not    %rax
    e387:	49 89 01             	mov    %rax,(%r9)
    e38a:	e9 0b 05 00 00       	jmp    e89a <tp_value+0x118a>
    e38f:	48 8d 74 24 50       	lea    0x50(%rsp),%rsi
    e394:	ba 80 00 00 00       	mov    $0x80,%edx
    e399:	4c 89 f7             	mov    %r14,%rdi
    e39c:	e8 0f 19 00 00       	call   fcb0 <tp_token>
    e3a1:	49 89 c4             	mov    %rax,%r12
    e3a4:	4c 8d 34 04          	lea    (%rsp,%rax,1),%r14
    e3a8:	49 83 c6 50          	add    $0x50,%r14
    e3ac:	31 db                	xor    %ebx,%ebx
    e3ae:	eb 0d                	jmp    e3bd <tp_value+0xcad>
    e3b0:	48 ff c3             	inc    %rbx
    e3b3:	48 83 fb 06          	cmp    $0x6,%rbx
    e3b7:	0f 84 68 0a 00 00    	je     ee25 <tp_value+0x1715>
    e3bd:	49 89 df             	mov    %rbx,%r15
    e3c0:	49 c1 e7 04          	shl    $0x4,%r15
    e3c4:	48 8d 05 d5 b8 00 00 	lea    0xb8d5(%rip),%rax        # 19ca0 <tp_value.units>
    e3cb:	49 8b 2c 07          	mov    (%r15,%rax,1),%rbp
    e3cf:	48 89 ef             	mov    %rbp,%rdi
    e3d2:	e8 99 4d ff ff       	call   3170 <strlen@plt>
    e3d7:	4d 89 e5             	mov    %r12,%r13
    e3da:	49 29 c5             	sub    %rax,%r13
    e3dd:	76 d1                	jbe    e3b0 <tp_value+0xca0>
    e3df:	4c 89 f7             	mov    %r14,%rdi
    e3e2:	48 29 c7             	sub    %rax,%rdi
    e3e5:	48 89 ee             	mov    %rbp,%rsi
    e3e8:	e8 e3 4e ff ff       	call   32d0 <strcmp@plt>
    e3ed:	85 c0                	test   %eax,%eax
    e3ef:	75 bf                	jne    e3b0 <tp_value+0xca0>
    e3f1:	48 8d bc 24 50 01 00 	lea    0x150(%rsp),%rdi
    e3f8:	00 
    e3f9:	48 8d 74 24 50       	lea    0x50(%rsp),%rsi
    e3fe:	4c 89 ea             	mov    %r13,%rdx
    e401:	e8 2a 4f ff ff       	call   3330 <memcpy@plt>
    e406:	42 c6 84 2c 50 01 00 	movb   $0x0,0x150(%rsp,%r13,1)
    e40d:	00 00 
    e40f:	0f b6 b4 24 50 01 00 	movzbl 0x150(%rsp),%esi
    e416:	00 
    e417:	8d 46 d5             	lea    -0x2b(%rsi),%eax
    e41a:	31 c9                	xor    %ecx,%ecx
    e41c:	a8 fd                	test   $0xfd,%al
    e41e:	0f 94 c1             	sete   %cl
    e421:	49 39 cd             	cmp    %rcx,%r13
    e424:	74 8a                	je     e3b0 <tp_value+0xca0>
    e426:	76 1c                	jbe    e444 <tp_value+0xd34>
    e428:	0f b6 94 0c 50 01 00 	movzbl 0x150(%rsp,%rcx,1),%edx
    e42f:	00 
    e430:	80 c2 c6             	add    $0xc6,%dl
    e433:	80 fa f6             	cmp    $0xf6,%dl
    e436:	0f 82 74 ff ff ff    	jb     e3b0 <tp_value+0xca0>
    e43c:	48 ff c1             	inc    %rcx
    e43f:	49 39 cd             	cmp    %rcx,%r13
    e442:	75 e4                	jne    e428 <tp_value+0xd18>
    e444:	31 c9                	xor    %ecx,%ecx
    e446:	a8 fd                	test   $0xfd,%al
    e448:	0f 94 c1             	sete   %cl
    e44b:	44 0f b6 94 0c 50 01 	movzbl 0x150(%rsp,%rcx,1),%r10d
    e452:	00 00 
    e454:	45 31 f6             	xor    %r14d,%r14d
    e457:	45 84 d2             	test   %r10b,%r10b
    e45a:	0f 84 21 06 00 00    	je     ea81 <tp_value+0x1371>
    e460:	48 8d 84 24 50 01 00 	lea    0x150(%rsp),%rax
    e467:	00 
    e468:	48 01 c1             	add    %rax,%rcx
    e46b:	48 ff c1             	inc    %rcx
    e46e:	31 c0                	xor    %eax,%eax
    e470:	bf 0a 00 00 00       	mov    $0xa,%edi
    e475:	49 b9 00 00 00 00 00 	movabs $0x8000000000000000,%r9
    e47c:	00 00 80 
    e47f:	45 31 c0             	xor    %r8d,%r8d
    e482:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    e487:	48 f7 e7             	mul    %rdi
    e48a:	4f 8d 04 80          	lea    (%r8,%r8,4),%r8
    e48e:	4a 8d 14 42          	lea    (%rdx,%r8,2),%rdx
    e492:	45 0f be c2          	movsbl %r10b,%r8d
    e496:	41 83 c0 d0          	add    $0xffffffd0,%r8d
    e49a:	4d 63 d0             	movslq %r8d,%r10
    e49d:	4d 89 d0             	mov    %r10,%r8
    e4a0:	49 c1 f8 3f          	sar    $0x3f,%r8
    e4a4:	4c 01 d0             	add    %r10,%rax
    e4a7:	49 11 d0             	adc    %rdx,%r8
    e4aa:	49 39 c1             	cmp    %rax,%r9
    e4ad:	ba 00 00 00 00       	mov    $0x0,%edx
    e4b2:	4c 19 c2             	sbb    %r8,%rdx
    e4b5:	0f 8c 6a 09 00 00    	jl     ee25 <tp_value+0x1715>
    e4bb:	44 0f b6 11          	movzbl (%rcx),%r10d
    e4bf:	48 ff c1             	inc    %rcx
    e4c2:	45 84 d2             	test   %r10b,%r10b
    e4c5:	75 c0                	jne    e487 <tp_value+0xd77>
    e4c7:	e9 bf 05 00 00       	jmp    ea8b <tp_value+0x137b>
    e4cc:	49 83 c7 05          	add    $0x5,%r15
    e4d0:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    e4d4:	48 8d 35 76 74 00 00 	lea    0x7476(%rip),%rsi        # 15951 <exec_in_fp0+0xe1>
    e4db:	48 8d 15 15 84 00 00 	lea    0x8415(%rip),%rdx        # 168f7 <exec_in_fp0+0x1087>
    e4e2:	48 8d 0d 87 17 00 00 	lea    0x1787(%rip),%rcx        # fc70 <tp_byte_item>
    e4e9:	4c 8d 44 24 50       	lea    0x50(%rsp),%r8
    e4ee:	e8 7d 15 00 00       	call   fa70 <tp_list_of>
    e4f3:	85 c0                	test   %eax,%eax
    e4f5:	74 77                	je     e56e <tp_value+0xe5e>
    e4f7:	66 0f ef c0          	pxor   %xmm0,%xmm0
    e4fb:	66 0f 7f 84 24 50 01 	movdqa %xmm0,0x150(%rsp)
    e502:	00 00 
    e504:	48 c7 84 24 60 01 00 	movq   $0x0,0x160(%rsp)
    e50b:	00 00 00 00 00 
    e510:	48 83 7c 24 68 00    	cmpq   $0x0,0x68(%rsp)
    e516:	74 36                	je     e54e <tp_value+0xe3e>
    e518:	31 db                	xor    %ebx,%ebx
    e51a:	4c 8d b4 24 50 01 00 	lea    0x150(%rsp),%r14
    e521:	00 
    e522:	4c 8d 7c 24 38       	lea    0x38(%rsp),%r15
    e527:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
    e52c:	0f b6 04 d8          	movzbl (%rax,%rbx,8),%eax
    e530:	88 44 24 38          	mov    %al,0x38(%rsp)
    e534:	ba 01 00 00 00       	mov    $0x1,%edx
    e539:	4c 89 f7             	mov    %r14,%rdi
    e53c:	4c 89 fe             	mov    %r15,%rsi
    e53f:	e8 8c ec ff ff       	call   d1d0 <buf_put>
    e544:	48 ff c3             	inc    %rbx
    e547:	48 3b 5c 24 68       	cmp    0x68(%rsp),%rbx
    e54c:	72 d9                	jb     e527 <tp_value+0xe17>
    e54e:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
    e553:	e8 88 c5 ff ff       	call   aae0 <fwp_mem_free>
    e558:	48 8d bc 24 50 01 00 	lea    0x150(%rsp),%rdi
    e55f:	00 
    e560:	e8 5b ed ff ff       	call   d2c0 <buf_to_str>
    e565:	49 89 04 24          	mov    %rax,(%r12)
    e569:	e9 63 f7 ff ff       	jmp    dcd1 <tp_value+0x5c1>
    e56e:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
    e573:	e8 68 c5 ff ff       	call   aae0 <fwp_mem_free>
    e578:	e9 5a f7 ff ff       	jmp    dcd7 <tp_value+0x5c7>
    e57d:	f2 0f 10 05 43 6c 00 	movsd  0x6c43(%rip),%xmm0        # 151c8 <_IO_stdin_used+0x1c8>
    e584:	00 
    e585:	83 39 0a             	cmpl   $0xa,(%rcx)
    e588:	f2 0f 5a c8          	cvtsd2ss %xmm0,%xmm1
    e58c:	66 0f 7e c9          	movd   %xmm1,%ecx
    e590:	66 48 0f 7e c0       	movq   %xmm0,%rax
    e595:	48 0f 44 c1          	cmove  %rcx,%rax
    e599:	49 89 04 24          	mov    %rax,(%r12)
    e59d:	e9 2f f7 ff ff       	jmp    dcd1 <tp_value+0x5c1>
    e5a2:	4d 8b 8c ce 90 07 00 	mov    0x790(%r14,%rcx,8),%r9
    e5a9:	00 
    e5aa:	4d 8b 84 ce 98 07 00 	mov    0x798(%r14,%rcx,8),%r8
    e5b1:	00 
    e5b2:	4d 29 c8             	sub    %r9,%r8
    e5b5:	49 39 d0             	cmp    %rdx,%r8
    e5b8:	0f 83 05 01 00 00    	jae    e6c3 <tp_value+0xfb3>
    e5be:	48 89 f5             	mov    %rsi,%rbp
    e5c1:	48 89 fb             	mov    %rdi,%rbx
    e5c4:	48 89 c7             	mov    %rax,%rdi
    e5c7:	be 02 00 00 00       	mov    $0x2,%esi
    e5cc:	e8 af 9c ff ff       	call   8280 <fwp_gc_alloc_slow>
    e5d1:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    e5d6:	4c 8b 25 cb d8 00 00 	mov    0xd8cb(%rip),%r12        # 1bea8 <measured_calls>
    e5dd:	4c 8b 2d cc d8 00 00 	mov    0xd8cc(%rip),%r13        # 1beb0 <measured_bytes>
    e5e4:	e9 00 01 00 00       	jmp    e6e9 <tp_value+0xfd9>
    e5e9:	48 85 c0             	test   %rax,%rax
    e5ec:	40 0f 95 c6          	setne  %sil
    e5f0:	80 c2 d5             	add    $0xd5,%dl
    e5f3:	f6 c2 fd             	test   $0xfd,%dl
    e5f6:	0f 94 c2             	sete   %dl
    e5f9:	40 20 f2             	and    %sil,%dl
    e5fc:	0f b6 f2             	movzbl %dl,%esi
    e5ff:	41 b0 01             	mov    $0x1,%r8b
    e602:	48 89 f7             	mov    %rsi,%rdi
    e605:	48 39 f0             	cmp    %rsi,%rax
    e608:	0f 86 70 02 00 00    	jbe    e87e <tp_value+0x116e>
    e60e:	0f b6 54 3c 50       	movzbl 0x50(%rsp,%rdi,1),%edx
    e613:	44 8d 4a d0          	lea    -0x30(%rdx),%r9d
    e617:	41 80 f9 09          	cmp    $0x9,%r9b
    e61b:	0f 87 0f 05 00 00    	ja     eb30 <tp_value+0x1420>
    e621:	48 ff c7             	inc    %rdi
    e624:	48 39 f8             	cmp    %rdi,%rax
    e627:	75 e5                	jne    e60e <tp_value+0xefe>
    e629:	48 89 c7             	mov    %rax,%rdi
    e62c:	48 89 c2             	mov    %rax,%rdx
    e62f:	e9 fc 07 00 00       	jmp    ee30 <tp_value+0x1720>
    e634:	4e 8b 9c c0 90 07 00 	mov    0x790(%rax,%r8,8),%r11
    e63b:	00 
    e63c:	4e 8b 8c c0 98 07 00 	mov    0x798(%rax,%r8,8),%r9
    e643:	00 
    e644:	4d 29 d9             	sub    %r11,%r9
    e647:	49 39 d1             	cmp    %rdx,%r9
    e64a:	0f 83 36 02 00 00    	jae    e886 <tp_value+0x1176>
    e650:	48 89 f3             	mov    %rsi,%rbx
    e653:	be 02 00 00 00       	mov    $0x2,%esi
    e658:	e8 23 9c ff ff       	call   8280 <fwp_gc_alloc_slow>
    e65d:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    e662:	e9 42 02 00 00       	jmp    e8a9 <tp_value+0x1199>
    e667:	48 8d 35 67 80 00 00 	lea    0x8067(%rip),%rsi        # 166d5 <exec_in_fp0+0xe65>
    e66e:	49 89 ff             	mov    %rdi,%r15
    e671:	e8 5a 13 00 00       	call   f9d0 <tp_eat>
    e676:	85 c0                	test   %eax,%eax
    e678:	0f 84 59 f6 ff ff    	je     dcd7 <tp_value+0x5c7>
    e67e:	48 8d 35 11 81 00 00 	lea    0x8111(%rip),%rsi        # 16796 <exec_in_fp0+0xf26>
    e685:	4c 89 ff             	mov    %r15,%rdi
    e688:	e8 43 13 00 00       	call   f9d0 <tp_eat>
    e68d:	85 c0                	test   %eax,%eax
    e68f:	0f 84 42 f6 ff ff    	je     dcd7 <tp_value+0x5c7>
    e695:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    e69a:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    e6a1:	e9 2b f6 ff ff       	jmp    dcd1 <tp_value+0x5c1>
    e6a6:	31 ff                	xor    %edi,%edi
    e6a8:	4c 89 fe             	mov    %r15,%rsi
    e6ab:	e8 50 71 ff ff       	call   5800 <fwp_array_new_packed>
    e6b0:	49 89 c6             	mov    %rax,%r14
    e6b3:	e9 46 05 00 00       	jmp    ebfe <tp_value+0x14ee>
    e6b8:	31 c9                	xor    %ecx,%ecx
    e6ba:	49 89 0c 24          	mov    %rcx,(%r12)
    e6be:	e9 0e f6 ff ff       	jmp    dcd1 <tp_value+0x5c1>
    e6c3:	48 89 f5             	mov    %rsi,%rbp
    e6c6:	48 89 fb             	mov    %rdi,%rbx
    e6c9:	49 8d 04 ce          	lea    (%r14,%rcx,8),%rax
    e6cd:	48 05 90 07 00 00    	add    $0x790,%rax
    e6d3:	49 8d 0c 11          	lea    (%r9,%rdx,1),%rcx
    e6d7:	48 89 08             	mov    %rcx,(%rax)
    e6da:	4c 89 4c 24 20       	mov    %r9,0x20(%rsp)
    e6df:	4c 89 cf             	mov    %r9,%rdi
    e6e2:	31 f6                	xor    %esi,%esi
    e6e4:	e8 27 4b ff ff       	call   3210 <memset@plt>
    e6e9:	49 63 07             	movslq (%r15),%rax
    e6ec:	48 8d 50 01          	lea    0x1(%rax),%rdx
    e6f0:	49 ff c4             	inc    %r12
    e6f3:	4c 89 25 ae d7 00 00 	mov    %r12,0xd7ae(%rip)        # 1bea8 <measured_calls>
    e6fa:	4a 8d 0c 28          	lea    (%rax,%r13,1),%rcx
    e6fe:	48 ff c1             	inc    %rcx
    e701:	48 89 0d a8 d7 00 00 	mov    %rcx,0xd7a8(%rip)        # 1beb0 <measured_bytes>
    e708:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    e70f:	77 5d                	ja     e76e <tp_value+0x105e>
    e711:	48 83 c0 10          	add    $0x10,%rax
    e715:	48 c1 e8 04          	shr    $0x4,%rax
    e719:	42 0f b6 8c 30 e8 0b 	movzbl 0xbe8(%rax,%r14,1),%ecx
    e720:	00 00 
    e722:	41 8b 84 8e 48 0b 00 	mov    0xb48(%r14,%rcx,4),%eax
    e729:	00 
    e72a:	48 29 05 57 bb 00 00 	sub    %rax,0xbb57(%rip)        # 1a288 <fwp_gc>
    e731:	78 3b                	js     e76e <tp_value+0x105e>
    e733:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    e737:	49 8d 34 ce          	lea    (%r14,%rcx,8),%rsi
    e73b:	48 81 c6 c8 03 00 00 	add    $0x3c8,%rsi
    e742:	4c 8b 26             	mov    (%rsi),%r12
    e745:	4d 85 e4             	test   %r12,%r12
    e748:	74 0c                	je     e756 <tp_value+0x1046>
    e74a:	49 8b 04 24          	mov    (%r12),%rax
    e74e:	48 f7 d0             	not    %rax
    e751:	48 89 06             	mov    %rax,(%rsi)
    e754:	eb 3b                	jmp    e791 <tp_value+0x1081>
    e756:	4d 8b a4 ce d0 03 00 	mov    0x3d0(%r14,%rcx,8),%r12
    e75d:	00 
    e75e:	49 8b b4 ce d8 03 00 	mov    0x3d8(%r14,%rcx,8),%rsi
    e765:	00 
    e766:	4c 29 e6             	sub    %r12,%rsi
    e769:	48 39 c6             	cmp    %rax,%rsi
    e76c:	73 12                	jae    e780 <tp_value+0x1070>
    e76e:	48 89 d7             	mov    %rdx,%rdi
    e771:	be 01 00 00 00       	mov    $0x1,%esi
    e776:	e8 05 9b ff ff       	call   8280 <fwp_gc_alloc_slow>
    e77b:	49 89 c4             	mov    %rax,%r12
    e77e:	eb 1b                	jmp    e79b <tp_value+0x108b>
    e780:	49 8d 0c ce          	lea    (%r14,%rcx,8),%rcx
    e784:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
    e78b:	4c 01 e0             	add    %r12,%rax
    e78e:	48 89 01             	mov    %rax,(%rcx)
    e791:	4c 89 e7             	mov    %r12,%rdi
    e794:	31 f6                	xor    %esi,%esi
    e796:	e8 75 4a ff ff       	call   3210 <memset@plt>
    e79b:	49 63 17             	movslq (%r15),%rdx
    e79e:	48 ff c2             	inc    %rdx
    e7a1:	45 31 f6             	xor    %r14d,%r14d
    e7a4:	4c 89 e7             	mov    %r12,%rdi
    e7a7:	31 f6                	xor    %esi,%esi
    e7a9:	e8 62 4a ff ff       	call   3210 <memset@plt>
    e7ae:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    e7b2:	48 8b 43 10          	mov    0x10(%rbx),%rax
    e7b6:	48 39 c8             	cmp    %rcx,%rax
    e7b9:	73 2e                	jae    e7e9 <tp_value+0x10d9>
    e7bb:	48 8b 13             	mov    (%rbx),%rdx
    e7be:	48 be 00 26 00 00 01 	movabs $0x100002600,%rsi
    e7c5:	00 00 00 
    e7c8:	0f b6 3c 02          	movzbl (%rdx,%rax,1),%edi
    e7cc:	48 83 ff 20          	cmp    $0x20,%rdi
    e7d0:	77 17                	ja     e7e9 <tp_value+0x10d9>
    e7d2:	48 0f a3 fe          	bt     %rdi,%rsi
    e7d6:	73 11                	jae    e7e9 <tp_value+0x10d9>
    e7d8:	48 ff c0             	inc    %rax
    e7db:	48 89 43 10          	mov    %rax,0x10(%rbx)
    e7df:	48 39 c1             	cmp    %rax,%rcx
    e7e2:	75 e4                	jne    e7c8 <tp_value+0x10b8>
    e7e4:	e9 ee f4 ff ff       	jmp    dcd7 <tp_value+0x5c7>
    e7e9:	48 39 c1             	cmp    %rax,%rcx
    e7ec:	0f 84 e5 f4 ff ff    	je     dcd7 <tp_value+0x5c7>
    e7f2:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
    e7f7:	48 8b 0b             	mov    (%rbx),%rcx
    e7fa:	80 3c 01 7b          	cmpb   $0x7b,(%rcx,%rax,1)
    e7fe:	0f 85 d3 f4 ff ff    	jne    dcd7 <tp_value+0x5c7>
    e804:	48 ff c0             	inc    %rax
    e807:	48 89 43 10          	mov    %rax,0x10(%rbx)
    e80b:	48 8d 35 ac 71 00 00 	lea    0x71ac(%rip),%rsi        # 159be <exec_in_fp0+0x14e>
    e812:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
    e817:	48 89 df             	mov    %rbx,%rdi
    e81a:	e8 b1 11 00 00       	call   f9d0 <tp_eat>
    e81f:	85 c0                	test   %eax,%eax
    e821:	0f 84 e0 03 00 00    	je     ec07 <tp_value+0x14f7>
    e827:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    e82c:	8b 38                	mov    (%rax),%edi
    e82e:	85 ff                	test   %edi,%edi
    e830:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
    e835:	48 8b 74 24 20       	mov    0x20(%rsp),%rsi
    e83a:	7e 18                	jle    e854 <tp_value+0x1144>
    e83c:	45 31 f6             	xor    %r14d,%r14d
    e83f:	31 c0                	xor    %eax,%eax
    e841:	41 80 3c 04 00       	cmpb   $0x0,(%r12,%rax,1)
    e846:	0f 84 8b f4 ff ff    	je     dcd7 <tp_value+0x5c7>
    e84c:	48 ff c0             	inc    %rax
    e84f:	48 39 c7             	cmp    %rax,%rdi
    e852:	75 ed                	jne    e841 <tp_value+0x1131>
    e854:	e8 17 19 00 00       	call   10170 <fwp_record>
    e859:	48 89 03             	mov    %rax,(%rbx)
    e85c:	e9 70 f4 ff ff       	jmp    dcd1 <tp_value+0x5c1>
    e861:	48 8d 05 98 d6 01 00 	lea    0x1d698(%rip),%rax        # 2bf00 <fwp_empty_map>
    e868:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
    e86d:	48 89 c3             	mov    %rax,%rbx
    e870:	e8 6b c2 ff ff       	call   aae0 <fwp_mem_free>
    e875:	49 89 1c 24          	mov    %rbx,(%r12)
    e879:	e9 53 f4 ff ff       	jmp    dcd1 <tp_value+0x5c1>
    e87e:	48 89 f2             	mov    %rsi,%rdx
    e881:	e9 aa 05 00 00       	jmp    ee30 <tp_value+0x1720>
    e886:	48 89 f3             	mov    %rsi,%rbx
    e889:	4a 8d 04 c0          	lea    (%rax,%r8,8),%rax
    e88d:	48 05 90 07 00 00    	add    $0x790,%rax
    e893:	49 8d 0c 13          	lea    (%r11,%rdx,1),%rcx
    e897:	48 89 08             	mov    %rcx,(%rax)
    e89a:	4c 89 5c 24 08       	mov    %r11,0x8(%rsp)
    e89f:	4c 89 df             	mov    %r11,%rdi
    e8a2:	31 f6                	xor    %esi,%esi
    e8a4:	e8 67 49 ff ff       	call   3210 <memset@plt>
    e8a9:	4c 89 7c 24 28       	mov    %r15,0x28(%rsp)
    e8ae:	45 85 ff             	test   %r15d,%r15d
    e8b1:	0f 8e 60 01 00 00    	jle    ea17 <tp_value+0x1307>
    e8b7:	48 89 d8             	mov    %rbx,%rax
    e8ba:	31 db                	xor    %ebx,%ebx
    e8bc:	49 bf 00 26 00 00 01 	movabs $0x100002600,%r15
    e8c3:	00 00 00 
    e8c6:	4c 89 74 24 30       	mov    %r14,0x30(%rsp)
    e8cb:	48 8b 48 30          	mov    0x30(%rax),%rcx
    e8cf:	4a 8b 0c f1          	mov    (%rcx,%r14,8),%rcx
    e8d3:	48 8b 34 d9          	mov    (%rcx,%rbx,8),%rsi
    e8d7:	49 8b 7d 08          	mov    0x8(%r13),%rdi
    e8db:	49 8b 55 10          	mov    0x10(%r13),%rdx
    e8df:	48 39 fa             	cmp    %rdi,%rdx
    e8e2:	73 2c                	jae    e910 <tp_value+0x1200>
    e8e4:	49 8b 4d 00          	mov    0x0(%r13),%rcx
    e8e8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    e8ef:	00 
    e8f0:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    e8f5:	49 83 f8 20          	cmp    $0x20,%r8
    e8f9:	77 15                	ja     e910 <tp_value+0x1200>
    e8fb:	4d 0f a3 c7          	bt     %r8,%r15
    e8ff:	73 0f                	jae    e910 <tp_value+0x1200>
    e901:	48 ff c2             	inc    %rdx
    e904:	49 89 55 10          	mov    %rdx,0x10(%r13)
    e908:	48 39 d7             	cmp    %rdx,%rdi
    e90b:	75 e3                	jne    e8f0 <tp_value+0x11e0>
    e90d:	48 89 fa             	mov    %rdi,%rdx
    e910:	83 3e 10             	cmpl   $0x10,(%rsi)
    e913:	75 0b                	jne    e920 <tp_value+0x1210>
    e915:	48 83 7e 08 00       	cmpq   $0x0,0x8(%rsi)
    e91a:	0f 84 b4 00 00 00    	je     e9d4 <tp_value+0x12c4>
    e920:	45 31 c0             	xor    %r8d,%r8d
    e923:	49 89 c4             	mov    %rax,%r12
    e926:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    e92b:	48 8d 0c d8          	lea    (%rax,%rbx,8),%rcx
    e92f:	48 39 fa             	cmp    %rdi,%rdx
    e932:	73 10                	jae    e944 <tp_value+0x1234>
    e934:	49 8b 45 00          	mov    0x0(%r13),%rax
    e938:	80 3c 10 28          	cmpb   $0x28,(%rax,%rdx,1)
    e93c:	0f 95 c0             	setne  %al
    e93f:	44 08 c0             	or     %r8b,%al
    e942:	74 35                	je     e979 <tp_value+0x1269>
    e944:	45 31 f6             	xor    %r14d,%r14d
    e947:	4c 89 ef             	mov    %r13,%rdi
    e94a:	31 d2                	xor    %edx,%edx
    e94c:	e8 bf ed ff ff       	call   d710 <tp_value>
    e951:	85 c0                	test   %eax,%eax
    e953:	4c 89 e0             	mov    %r12,%rax
    e956:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    e95b:	0f 84 76 f3 ff ff    	je     dcd7 <tp_value+0x5c7>
    e961:	48 ff c3             	inc    %rbx
    e964:	48 3b 5c 24 20       	cmp    0x20(%rsp),%rbx
    e969:	4c 8b 74 24 30       	mov    0x30(%rsp),%r14
    e96e:	0f 85 57 ff ff ff    	jne    e8cb <tp_value+0x11bb>
    e974:	e9 9e 00 00 00       	jmp    ea17 <tp_value+0x1307>
    e979:	48 ff c2             	inc    %rdx
    e97c:	49 89 55 10          	mov    %rdx,0x10(%r13)
    e980:	45 31 f6             	xor    %r14d,%r14d
    e983:	4c 89 ef             	mov    %r13,%rdi
    e986:	31 d2                	xor    %edx,%edx
    e988:	e8 83 ed ff ff       	call   d710 <tp_value>
    e98d:	85 c0                	test   %eax,%eax
    e98f:	0f 84 42 f3 ff ff    	je     dcd7 <tp_value+0x5c7>
    e995:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
    e99a:	49 8b 55 08          	mov    0x8(%r13),%rdx
    e99e:	49 8b 4d 10          	mov    0x10(%r13),%rcx
    e9a2:	48 39 d1             	cmp    %rdx,%rcx
    e9a5:	4c 89 e0             	mov    %r12,%rax
    e9a8:	73 3d                	jae    e9e7 <tp_value+0x12d7>
    e9aa:	49 8b 75 00          	mov    0x0(%r13),%rsi
    e9ae:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    e9b3:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
    e9b7:	48 83 ff 20          	cmp    $0x20,%rdi
    e9bb:	77 2f                	ja     e9ec <tp_value+0x12dc>
    e9bd:	49 0f a3 ff          	bt     %rdi,%r15
    e9c1:	73 29                	jae    e9ec <tp_value+0x12dc>
    e9c3:	48 ff c1             	inc    %rcx
    e9c6:	49 89 4d 10          	mov    %rcx,0x10(%r13)
    e9ca:	48 39 ca             	cmp    %rcx,%rdx
    e9cd:	75 e4                	jne    e9b3 <tp_value+0x12a3>
    e9cf:	e9 03 f3 ff ff       	jmp    dcd7 <tp_value+0x5c7>
    e9d4:	83 7e 10 00          	cmpl   $0x0,0x10(%rsi)
    e9d8:	74 35                	je     ea0f <tp_value+0x12ff>
    e9da:	83 7e 48 00          	cmpl   $0x0,0x48(%rsi)
    e9de:	41 0f 95 c0          	setne  %r8b
    e9e2:	e9 3c ff ff ff       	jmp    e923 <tp_value+0x1213>
    e9e7:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    e9ec:	48 39 ca             	cmp    %rcx,%rdx
    e9ef:	0f 84 e2 f2 ff ff    	je     dcd7 <tp_value+0x5c7>
    e9f5:	49 8b 55 00          	mov    0x0(%r13),%rdx
    e9f9:	80 3c 0a 29          	cmpb   $0x29,(%rdx,%rcx,1)
    e9fd:	0f 85 d4 f2 ff ff    	jne    dcd7 <tp_value+0x5c7>
    ea03:	48 ff c1             	inc    %rcx
    ea06:	49 89 4d 10          	mov    %rcx,0x10(%r13)
    ea0a:	e9 52 ff ff ff       	jmp    e961 <tp_value+0x1251>
    ea0f:	41 b0 01             	mov    $0x1,%r8b
    ea12:	e9 0c ff ff ff       	jmp    e923 <tp_value+0x1213>
    ea17:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
    ea1c:	45 85 ff             	test   %r15d,%r15d
    ea1f:	0f 84 d9 01 00 00    	je     ebfe <tp_value+0x14ee>
    ea25:	48 8b 5c 24 20       	mov    0x20(%rsp),%rbx
    ea2a:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    ea31:	00 
    ea32:	e8 69 bd ff ff       	call   a7a0 <fwp_alloc_init>
    ea37:	49 89 c6             	mov    %rax,%r14
    ea3a:	89 28                	mov    %ebp,(%rax)
    ea3c:	44 89 78 04          	mov    %r15d,0x4(%rax)
    ea40:	41 83 ff 08          	cmp    $0x8,%r15d
    ea44:	73 1b                	jae    ea61 <tp_value+0x1351>
    ea46:	31 c0                	xor    %eax,%eax
    ea48:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    ea4d:	e9 53 01 00 00       	jmp    eba5 <tp_value+0x1495>
    ea52:	4d 01 fd             	add    %r15,%r13
    ea55:	4c 89 f7             	mov    %r14,%rdi
    ea58:	4d 89 6e 10          	mov    %r13,0x10(%r14)
    ea5c:	e9 9c f4 ff ff       	jmp    defd <tp_value+0x7ed>
    ea61:	4c 89 f0             	mov    %r14,%rax
    ea64:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    ea69:	48 29 f8             	sub    %rdi,%rax
    ea6c:	48 83 c0 08          	add    $0x8,%rax
    ea70:	48 83 f8 20          	cmp    $0x20,%rax
    ea74:	0f 83 f3 00 00 00    	jae    eb6d <tp_value+0x145d>
    ea7a:	31 c0                	xor    %eax,%eax
    ea7c:	e9 24 01 00 00       	jmp    eba5 <tp_value+0x1495>
    ea81:	31 c0                	xor    %eax,%eax
    ea83:	45 31 c0             	xor    %r8d,%r8d
    ea86:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    ea8b:	48 89 c1             	mov    %rax,%rcx
    ea8e:	48 f7 d9             	neg    %rcx
    ea91:	bf 00 00 00 00       	mov    $0x0,%edi
    ea96:	4c 19 c7             	sbb    %r8,%rdi
    ea99:	40 80 fe 2d          	cmp    $0x2d,%sil
    ea9d:	49 0f 45 f8          	cmovne %r8,%rdi
    eaa1:	48 0f 45 c8          	cmovne %rax,%rcx
    eaa5:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    eaac:	ff ff 7f 
    eaaf:	48 39 c8             	cmp    %rcx,%rax
    eab2:	b8 00 00 00 00       	mov    $0x0,%eax
    eab7:	48 19 f8             	sbb    %rdi,%rax
    eaba:	0f 8c 17 f2 ff ff    	jl     dcd7 <tp_value+0x5c7>
    eac0:	48 8d 05 d9 b1 00 00 	lea    0xb1d9(%rip),%rax        # 19ca0 <tp_value.units>
    eac7:	49 8b 74 07 08       	mov    0x8(%r15,%rax,1),%rsi
    eacc:	48 89 c8             	mov    %rcx,%rax
    eacf:	48 f7 e6             	mul    %rsi
    ead2:	48 0f af fe          	imul   %rsi,%rdi
    ead6:	48 c1 fe 3f          	sar    $0x3f,%rsi
    eada:	48 0f af f1          	imul   %rcx,%rsi
    eade:	48 01 d7             	add    %rdx,%rdi
    eae1:	48 01 f7             	add    %rsi,%rdi
    eae4:	48 b9 00 00 00 00 00 	movabs $0x8000000000000000,%rcx
    eaeb:	00 00 80 
    eaee:	48 01 c1             	add    %rax,%rcx
    eaf1:	48 83 d7 ff          	adc    $0xffffffffffffffff,%rdi
    eaf5:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
    eaf9:	0f 85 d8 f1 ff ff    	jne    dcd7 <tp_value+0x5c7>
    eaff:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    eb04:	bf 10 00 00 00       	mov    $0x10,%edi
    eb09:	48 89 c3             	mov    %rax,%rbx
    eb0c:	e8 8f bc ff ff       	call   a7a0 <fwp_alloc_init>
    eb11:	48 b9 00 00 00 00 01 	movabs $0x100000000,%rcx
    eb18:	00 00 00 
    eb1b:	48 89 08             	mov    %rcx,(%rax)
    eb1e:	48 89 58 08          	mov    %rbx,0x8(%rax)
    eb22:	48 8d 4c 24 38       	lea    0x38(%rsp),%rcx
    eb27:	49 89 04 24          	mov    %rax,(%r12)
    eb2b:	e9 a1 f1 ff ff       	jmp    dcd1 <tp_value+0x5c1>
    eb30:	80 fa 2e             	cmp    $0x2e,%dl
    eb33:	0f 85 f4 02 00 00    	jne    ee2d <tp_value+0x171d>
    eb39:	48 8d 57 01          	lea    0x1(%rdi),%rdx
    eb3d:	48 39 c2             	cmp    %rax,%rdx
    eb40:	73 1b                	jae    eb5d <tp_value+0x144d>
    eb42:	44 0f b6 44 14 50    	movzbl 0x50(%rsp,%rdx,1),%r8d
    eb48:	41 80 c0 d0          	add    $0xd0,%r8b
    eb4c:	41 80 f8 09          	cmp    $0x9,%r8b
    eb50:	77 0b                	ja     eb5d <tp_value+0x144d>
    eb52:	48 ff c2             	inc    %rdx
    eb55:	48 39 c2             	cmp    %rax,%rdx
    eb58:	72 e8                	jb     eb42 <tp_value+0x1432>
    eb5a:	48 89 c2             	mov    %rax,%rdx
    eb5d:	4c 8d 42 ff          	lea    -0x1(%rdx),%r8
    eb61:	49 39 f8             	cmp    %rdi,%r8
    eb64:	41 0f 94 c0          	sete   %r8b
    eb68:	e9 c3 02 00 00       	jmp    ee30 <tp_value+0x1720>
    eb6d:	89 d8                	mov    %ebx,%eax
    eb6f:	83 e0 fc             	and    $0xfffffffc,%eax
    eb72:	48 8d 0c dd 00 00 00 	lea    0x0(,%rbx,8),%rcx
    eb79:	00 
    eb7a:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    eb7e:	31 d2                	xor    %edx,%edx
    eb80:	f3 0f 6f 04 17       	movdqu (%rdi,%rdx,1),%xmm0
    eb85:	0f 10 4c 17 10       	movups 0x10(%rdi,%rdx,1),%xmm1
    eb8a:	f3 41 0f 7f 44 16 08 	movdqu %xmm0,0x8(%r14,%rdx,1)
    eb91:	41 0f 11 4c 16 18    	movups %xmm1,0x18(%r14,%rdx,1)
    eb97:	48 83 c2 20          	add    $0x20,%rdx
    eb9b:	48 39 d1             	cmp    %rdx,%rcx
    eb9e:	75 e0                	jne    eb80 <tp_value+0x1470>
    eba0:	48 39 d8             	cmp    %rbx,%rax
    eba3:	74 59                	je     ebfe <tp_value+0x14ee>
    eba5:	48 89 da             	mov    %rbx,%rdx
    eba8:	48 89 c1             	mov    %rax,%rcx
    ebab:	48 83 e2 03          	and    $0x3,%rdx
    ebaf:	74 14                	je     ebc5 <tp_value+0x14b5>
    ebb1:	48 89 c1             	mov    %rax,%rcx
    ebb4:	48 8b 34 cf          	mov    (%rdi,%rcx,8),%rsi
    ebb8:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    ebbd:	48 ff c1             	inc    %rcx
    ebc0:	48 ff ca             	dec    %rdx
    ebc3:	75 ef                	jne    ebb4 <tp_value+0x14a4>
    ebc5:	48 29 d8             	sub    %rbx,%rax
    ebc8:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    ebcc:	77 30                	ja     ebfe <tp_value+0x14ee>
    ebce:	48 8b 04 cf          	mov    (%rdi,%rcx,8),%rax
    ebd2:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    ebd7:	48 8b 44 cf 08       	mov    0x8(%rdi,%rcx,8),%rax
    ebdc:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    ebe1:	48 8b 44 cf 10       	mov    0x10(%rdi,%rcx,8),%rax
    ebe6:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    ebeb:	48 8b 44 cf 18       	mov    0x18(%rdi,%rcx,8),%rax
    ebf0:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    ebf5:	48 83 c1 04          	add    $0x4,%rcx
    ebf9:	48 39 cb             	cmp    %rcx,%rbx
    ebfc:	75 d0                	jne    ebce <tp_value+0x14be>
    ebfe:	4d 89 34 24          	mov    %r14,(%r12)
    ec02:	e9 ca f0 ff ff       	jmp    dcd1 <tp_value+0x5c1>
    ec07:	4c 89 64 24 40       	mov    %r12,0x40(%rsp)
    ec0c:	49 bf 00 26 00 00 01 	movabs $0x100002600,%r15
    ec13:	00 00 00 
    ec16:	41 b8 ff 00 00 00    	mov    $0xff,%r8d
    ec1c:	4c 8d 4c 24 50       	lea    0x50(%rsp),%r9
    ec21:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    ec26:	48 89 6c 24 48       	mov    %rbp,0x48(%rsp)
    ec2b:	4c 8b 21             	mov    (%rcx),%r12
    ec2e:	4c 8b 69 08          	mov    0x8(%rcx),%r13
    ec32:	48 8b 71 10          	mov    0x10(%rcx),%rsi
    ec36:	4c 39 ee             	cmp    %r13,%rsi
    ec39:	73 2a                	jae    ec65 <tp_value+0x1555>
    ec3b:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
    ec40:	41 0f b6 04 34       	movzbl (%r12,%rsi,1),%eax
    ec45:	48 83 f8 20          	cmp    $0x20,%rax
    ec49:	77 1f                	ja     ec6a <tp_value+0x155a>
    ec4b:	49 0f a3 c7          	bt     %rax,%r15
    ec4f:	73 19                	jae    ec6a <tp_value+0x155a>
    ec51:	48 ff c6             	inc    %rsi
    ec54:	48 89 71 10          	mov    %rsi,0x10(%rcx)
    ec58:	49 39 f5             	cmp    %rsi,%r13
    ec5b:	75 e3                	jne    ec40 <tp_value+0x1530>
    ec5d:	4c 89 eb             	mov    %r13,%rbx
    ec60:	4c 89 ee             	mov    %r13,%rsi
    ec63:	eb 55                	jmp    ecba <tp_value+0x15aa>
    ec65:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
    ec6a:	48 bf 03 00 00 00 00 	movabs $0x4000000000003,%rdi
    ec71:	00 04 00 
    ec74:	48 89 f3             	mov    %rsi,%rbx
    ec77:	4c 39 ee             	cmp    %r13,%rsi
    ec7a:	72 0e                	jb     ec8a <tp_value+0x157a>
    ec7c:	eb 3c                	jmp    ecba <tp_value+0x15aa>
    ec7e:	48 ff c3             	inc    %rbx
    ec81:	48 89 59 10          	mov    %rbx,0x10(%rcx)
    ec85:	49 39 dd             	cmp    %rbx,%r13
    ec88:	74 2d                	je     ecb7 <tp_value+0x15a7>
    ec8a:	41 0f b6 04 1c       	movzbl (%r12,%rbx,1),%eax
    ec8f:	8d 50 d0             	lea    -0x30(%rax),%edx
    ec92:	80 fa 0a             	cmp    $0xa,%dl
    ec95:	72 e7                	jb     ec7e <tp_value+0x156e>
    ec97:	89 c2                	mov    %eax,%edx
    ec99:	80 e2 df             	and    $0xdf,%dl
    ec9c:	80 c2 bf             	add    $0xbf,%dl
    ec9f:	80 fa 1a             	cmp    $0x1a,%dl
    eca2:	72 da                	jb     ec7e <tp_value+0x156e>
    eca4:	0f b6 c0             	movzbl %al,%eax
    eca7:	83 c0 d3             	add    $0xffffffd3,%eax
    ecaa:	83 f8 32             	cmp    $0x32,%eax
    ecad:	77 0b                	ja     ecba <tp_value+0x15aa>
    ecaf:	48 0f a3 c7          	bt     %rax,%rdi
    ecb3:	72 c9                	jb     ec7e <tp_value+0x156e>
    ecb5:	eb 03                	jmp    ecba <tp_value+0x15aa>
    ecb7:	4c 89 eb             	mov    %r13,%rbx
    ecba:	48 89 dd             	mov    %rbx,%rbp
    ecbd:	48 29 f5             	sub    %rsi,%rbp
    ecc0:	48 81 fd ff 00 00 00 	cmp    $0xff,%rbp
    ecc7:	49 0f 43 e8          	cmovae %r8,%rbp
    eccb:	4c 01 e6             	add    %r12,%rsi
    ecce:	4c 89 cf             	mov    %r9,%rdi
    ecd1:	48 89 ea             	mov    %rbp,%rdx
    ecd4:	e8 57 46 ff ff       	call   3330 <memcpy@plt>
    ecd9:	c6 44 2c 50 00       	movb   $0x0,0x50(%rsp,%rbp,1)
    ecde:	45 8b 3e             	mov    (%r14),%r15d
    ece1:	45 85 ff             	test   %r15d,%r15d
    ece4:	48 8b 44 24 48       	mov    0x48(%rsp),%rax
    ece9:	0f 8e 36 01 00 00    	jle    ee25 <tp_value+0x1715>
    ecef:	4c 89 6c 24 28       	mov    %r13,0x28(%rsp)
    ecf4:	4c 89 64 24 30       	mov    %r12,0x30(%rsp)
    ecf9:	4c 8b 60 18          	mov    0x18(%rax),%r12
    ecfd:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    ed02:	45 31 f6             	xor    %r14d,%r14d
    ed05:	4c 8d 6c 24 50       	lea    0x50(%rsp),%r13
    ed0a:	4b 8b 3c f4          	mov    (%r12,%r14,8),%rdi
    ed0e:	4c 89 ee             	mov    %r13,%rsi
    ed11:	e8 ba 45 ff ff       	call   32d0 <strcmp@plt>
    ed16:	85 c0                	test   %eax,%eax
    ed18:	41 0f 44 ee          	cmove  %r14d,%ebp
    ed1c:	49 ff c6             	inc    %r14
    ed1f:	4d 39 f7             	cmp    %r14,%r15
    ed22:	75 e6                	jne    ed0a <tp_value+0x15fa>
    ed24:	85 ed                	test   %ebp,%ebp
    ed26:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    ed2b:	48 8b 44 24 48       	mov    0x48(%rsp),%rax
    ed30:	49 bf 00 26 00 00 01 	movabs $0x100002600,%r15
    ed37:	00 00 00 
    ed3a:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    ed3f:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
    ed44:	0f 88 db 00 00 00    	js     ee25 <tp_value+0x1715>
    ed4a:	48 39 fb             	cmp    %rdi,%rbx
    ed4d:	73 21                	jae    ed70 <tp_value+0x1660>
    ed4f:	0f b6 14 1e          	movzbl (%rsi,%rbx,1),%edx
    ed53:	48 83 fa 20          	cmp    $0x20,%rdx
    ed57:	77 17                	ja     ed70 <tp_value+0x1660>
    ed59:	49 0f a3 d7          	bt     %rdx,%r15
    ed5d:	73 11                	jae    ed70 <tp_value+0x1660>
    ed5f:	48 ff c3             	inc    %rbx
    ed62:	48 89 59 10          	mov    %rbx,0x10(%rcx)
    ed66:	48 39 df             	cmp    %rbx,%rdi
    ed69:	75 e4                	jne    ed4f <tp_value+0x163f>
    ed6b:	e9 b5 00 00 00       	jmp    ee25 <tp_value+0x1715>
    ed70:	48 39 df             	cmp    %rbx,%rdi
    ed73:	0f 84 ac 00 00 00    	je     ee25 <tp_value+0x1715>
    ed79:	80 3c 1e 3d          	cmpb   $0x3d,(%rsi,%rbx,1)
    ed7d:	0f 85 a2 00 00 00    	jne    ee25 <tp_value+0x1715>
    ed83:	48 ff c3             	inc    %rbx
    ed86:	48 89 59 10          	mov    %rbx,0x10(%rcx)
    ed8a:	48 8b 40 20          	mov    0x20(%rax),%rax
    ed8e:	89 eb                	mov    %ebp,%ebx
    ed90:	48 8b 34 d8          	mov    (%rax,%rbx,8),%rsi
    ed94:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    ed99:	48 8d 0c d8          	lea    (%rax,%rbx,8),%rcx
    ed9d:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    eda2:	31 d2                	xor    %edx,%edx
    eda4:	e8 67 e9 ff ff       	call   d710 <tp_value>
    eda9:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    edae:	85 c0                	test   %eax,%eax
    edb0:	74 73                	je     ee25 <tp_value+0x1715>
    edb2:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
    edb7:	c6 04 18 01          	movb   $0x1,(%rax,%rbx,1)
    edbb:	48 8b 51 08          	mov    0x8(%rcx),%rdx
    edbf:	48 8b 41 10          	mov    0x10(%rcx),%rax
    edc3:	48 39 d0             	cmp    %rdx,%rax
    edc6:	73 21                	jae    ede9 <tp_value+0x16d9>
    edc8:	48 8b 31             	mov    (%rcx),%rsi
    edcb:	0f b6 3c 06          	movzbl (%rsi,%rax,1),%edi
    edcf:	48 83 ff 20          	cmp    $0x20,%rdi
    edd3:	77 14                	ja     ede9 <tp_value+0x16d9>
    edd5:	49 0f a3 ff          	bt     %rdi,%r15
    edd9:	73 0e                	jae    ede9 <tp_value+0x16d9>
    eddb:	48 ff c0             	inc    %rax
    edde:	48 89 41 10          	mov    %rax,0x10(%rcx)
    ede2:	48 39 c2             	cmp    %rax,%rdx
    ede5:	75 e4                	jne    edcb <tp_value+0x16bb>
    ede7:	eb 12                	jmp    edfb <tp_value+0x16eb>
    ede9:	48 39 c2             	cmp    %rax,%rdx
    edec:	74 0d                	je     edfb <tp_value+0x16eb>
    edee:	48 8b 11             	mov    (%rcx),%rdx
    edf1:	80 3c 02 7d          	cmpb   $0x7d,(%rdx,%rax,1)
    edf5:	0f 84 db 00 00 00    	je     eed6 <tp_value+0x17c6>
    edfb:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    ee00:	48 8d 35 d0 78 00 00 	lea    0x78d0(%rip),%rsi        # 166d7 <exec_in_fp0+0xe67>
    ee07:	e8 c4 0b 00 00       	call   f9d0 <tp_eat>
    ee0c:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    ee11:	85 c0                	test   %eax,%eax
    ee13:	74 10                	je     ee25 <tp_value+0x1715>
    ee15:	41 b8 ff 00 00 00    	mov    $0xff,%r8d
    ee1b:	4c 8d 4c 24 50       	lea    0x50(%rsp),%r9
    ee20:	e9 06 fe ff ff       	jmp    ec2b <tp_value+0x151b>
    ee25:	45 31 f6             	xor    %r14d,%r14d
    ee28:	e9 aa ee ff ff       	jmp    dcd7 <tp_value+0x5c7>
    ee2d:	48 89 fa             	mov    %rdi,%rdx
    ee30:	48 39 f7             	cmp    %rsi,%rdi
    ee33:	75 09                	jne    ee3e <tp_value+0x172e>
    ee35:	45 84 c0             	test   %r8b,%r8b
    ee38:	0f 85 99 ee ff ff    	jne    dcd7 <tp_value+0x5c7>
    ee3e:	48 39 c2             	cmp    %rax,%rdx
    ee41:	73 5b                	jae    ee9e <tp_value+0x178e>
    ee43:	0f b6 74 14 50       	movzbl 0x50(%rsp,%rdx,1),%esi
    ee48:	83 ce 20             	or     $0x20,%esi
    ee4b:	83 fe 65             	cmp    $0x65,%esi
    ee4e:	75 4e                	jne    ee9e <tp_value+0x178e>
    ee50:	48 8d 72 01          	lea    0x1(%rdx),%rsi
    ee54:	48 39 c6             	cmp    %rax,%rsi
    ee57:	73 16                	jae    ee6f <tp_value+0x175f>
    ee59:	0f b6 7c 34 50       	movzbl 0x50(%rsp,%rsi,1),%edi
    ee5e:	83 ff 2d             	cmp    $0x2d,%edi
    ee61:	74 05                	je     ee68 <tp_value+0x1758>
    ee63:	83 ff 2b             	cmp    $0x2b,%edi
    ee66:	75 07                	jne    ee6f <tp_value+0x175f>
    ee68:	48 83 c2 02          	add    $0x2,%rdx
    ee6c:	48 89 d6             	mov    %rdx,%rsi
    ee6f:	48 39 c6             	cmp    %rax,%rsi
    ee72:	0f 83 5f ee ff ff    	jae    dcd7 <tp_value+0x5c7>
    ee78:	48 89 f2             	mov    %rsi,%rdx
    ee7b:	0f b6 7c 14 50       	movzbl 0x50(%rsp,%rdx,1),%edi
    ee80:	40 80 c7 d0          	add    $0xd0,%dil
    ee84:	40 80 ff 09          	cmp    $0x9,%dil
    ee88:	77 0b                	ja     ee95 <tp_value+0x1785>
    ee8a:	48 ff c2             	inc    %rdx
    ee8d:	48 39 d0             	cmp    %rdx,%rax
    ee90:	75 e9                	jne    ee7b <tp_value+0x176b>
    ee92:	48 89 c2             	mov    %rax,%rdx
    ee95:	48 39 f2             	cmp    %rsi,%rdx
    ee98:	0f 84 39 ee ff ff    	je     dcd7 <tp_value+0x5c7>
    ee9e:	48 39 c2             	cmp    %rax,%rdx
    eea1:	0f 85 30 ee ff ff    	jne    dcd7 <tp_value+0x5c7>
    eea7:	83 39 0a             	cmpl   $0xa,(%rcx)
    eeaa:	75 19                	jne    eec5 <tp_value+0x17b5>
    eeac:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    eeb1:	31 f6                	xor    %esi,%esi
    eeb3:	e8 48 43 ff ff       	call   3200 <strtof@plt>
    eeb8:	66 0f 7e c0          	movd   %xmm0,%eax
    eebc:	49 89 04 24          	mov    %rax,(%r12)
    eec0:	e9 0c ee ff ff       	jmp    dcd1 <tp_value+0x5c1>
    eec5:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    eeca:	31 f6                	xor    %esi,%esi
    eecc:	e8 2f 42 ff ff       	call   3100 <strtod@plt>
    eed1:	e9 b2 ed ff ff       	jmp    dc88 <tp_value+0x578>
    eed6:	48 ff c0             	inc    %rax
    eed9:	48 89 41 10          	mov    %rax,0x10(%rcx)
    eedd:	4c 8b 64 24 40       	mov    0x40(%rsp),%r12
    eee2:	e9 40 f9 ff ff       	jmp    e827 <tp_value+0x1117>
    eee7:	e8 d4 7c ff ff       	call   6bc0 <fwp_flush>
    eeec:	48 8b 05 e5 b0 00 00 	mov    0xb0e5(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    eef3:	48 8b 38             	mov    (%rax),%rdi
    eef6:	48 8d 35 8d 6b 00 00 	lea    0x6b8d(%rip),%rsi        # 15a8a <exec_in_fp0+0x21a>
    eefd:	48 8d 15 ce 7a 00 00 	lea    0x7ace(%rip),%rdx        # 169d2 <exec_in_fp0+0x1162>
    ef04:	31 c0                	xor    %eax,%eax
    ef06:	e8 e5 43 ff ff       	call   32f0 <fprintf@plt>
    ef0b:	bf 65 00 00 00       	mov    $0x65,%edi
    ef10:	e8 4b 45 ff ff       	call   3460 <exit@plt>
    ef15:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    ef1c:	00 00 00 00 

000000000000ef20 <tp_int>:
    ef20:	55                   	push   %rbp
    ef21:	41 57                	push   %r15
    ef23:	41 56                	push   %r14
    ef25:	41 55                	push   %r13
    ef27:	41 54                	push   %r12
    ef29:	53                   	push   %rbx
    ef2a:	48 81 ec b8 00 00 00 	sub    $0xb8,%rsp
    ef31:	49 89 d6             	mov    %rdx,%r14
    ef34:	49 89 f4             	mov    %rsi,%r12
    ef37:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
    ef3c:	ba 80 00 00 00       	mov    $0x80,%edx
    ef41:	e8 6a 0d 00 00       	call   fcb0 <tp_token>
    ef46:	45 31 d2             	xor    %r10d,%r10d
    ef49:	48 83 f8 7f          	cmp    $0x7f,%rax
    ef4d:	0f 87 fa 00 00 00    	ja     f04d <tp_int+0x12d>
    ef53:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    ef58:	e8 13 42 ff ff       	call   3170 <strlen@plt>
    ef5d:	49 89 c5             	mov    %rax,%r13
    ef60:	48 ff 05 41 cf 00 00 	incq   0xcf41(%rip)        # 1bea8 <measured_calls>
    ef67:	48 8d 50 09          	lea    0x9(%rax),%rdx
    ef6b:	48 01 15 3e cf 00 00 	add    %rdx,0xcf3e(%rip)        # 1beb0 <measured_bytes>
    ef72:	48 8d 3d 0f b3 00 00 	lea    0xb30f(%rip),%rdi        # 1a288 <fwp_gc>
    ef79:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    ef80:	77 5e                	ja     efe0 <tp_int+0xc0>
    ef82:	4c 89 e8             	mov    %r13,%rax
    ef85:	48 83 c0 18          	add    $0x18,%rax
    ef89:	48 c1 e8 04          	shr    $0x4,%rax
    ef8d:	0f b6 8c 38 e8 0b 00 	movzbl 0xbe8(%rax,%rdi,1),%ecx
    ef94:	00 
    ef95:	8b 84 8f 48 0b 00 00 	mov    0xb48(%rdi,%rcx,4),%eax
    ef9c:	48 29 05 e5 b2 00 00 	sub    %rax,0xb2e5(%rip)        # 1a288 <fwp_gc>
    efa3:	78 3b                	js     efe0 <tp_int+0xc0>
    efa5:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    efa9:	48 8d 34 cf          	lea    (%rdi,%rcx,8),%rsi
    efad:	48 81 c6 c8 03 00 00 	add    $0x3c8,%rsi
    efb4:	48 8b 2e             	mov    (%rsi),%rbp
    efb7:	48 85 ed             	test   %rbp,%rbp
    efba:	74 0c                	je     efc8 <tp_int+0xa8>
    efbc:	48 8b 45 00          	mov    0x0(%rbp),%rax
    efc0:	48 f7 d0             	not    %rax
    efc3:	48 89 06             	mov    %rax,(%rsi)
    efc6:	eb 3b                	jmp    f003 <tp_int+0xe3>
    efc8:	48 8b ac cf d0 03 00 	mov    0x3d0(%rdi,%rcx,8),%rbp
    efcf:	00 
    efd0:	48 8b b4 cf d8 03 00 	mov    0x3d8(%rdi,%rcx,8),%rsi
    efd7:	00 
    efd8:	48 29 ee             	sub    %rbp,%rsi
    efdb:	48 39 c6             	cmp    %rax,%rsi
    efde:	73 12                	jae    eff2 <tp_int+0xd2>
    efe0:	48 89 d7             	mov    %rdx,%rdi
    efe3:	be 01 00 00 00       	mov    $0x1,%esi
    efe8:	e8 93 92 ff ff       	call   8280 <fwp_gc_alloc_slow>
    efed:	48 89 c5             	mov    %rax,%rbp
    eff0:	eb 1b                	jmp    f00d <tp_int+0xed>
    eff2:	48 8d 0c cf          	lea    (%rdi,%rcx,8),%rcx
    eff6:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
    effd:	48 01 e8             	add    %rbp,%rax
    f000:	48 89 01             	mov    %rax,(%rcx)
    f003:	48 89 ef             	mov    %rbp,%rdi
    f006:	31 f6                	xor    %esi,%esi
    f008:	e8 03 42 ff ff       	call   3210 <memset@plt>
    f00d:	4c 89 6d 00          	mov    %r13,0x0(%rbp)
    f011:	4c 8d 7d 08          	lea    0x8(%rbp),%r15
    f015:	48 8d 5c 24 30       	lea    0x30(%rsp),%rbx
    f01a:	4c 89 ff             	mov    %r15,%rdi
    f01d:	48 89 de             	mov    %rbx,%rsi
    f020:	4c 89 ea             	mov    %r13,%rdx
    f023:	e8 08 43 ff ff       	call   3330 <memcpy@plt>
    f028:	42 c6 44 2d 08 00    	movb   $0x0,0x8(%rbp,%r13,1)
    f02e:	4c 8b 5d 00          	mov    0x0(%rbp),%r11
    f032:	4d 85 db             	test   %r11,%r11
    f035:	74 13                	je     f04a <tp_int+0x12a>
    f037:	41 0f b6 3f          	movzbl (%r15),%edi
    f03b:	8d 47 d5             	lea    -0x2b(%rdi),%eax
    f03e:	31 c9                	xor    %ecx,%ecx
    f040:	a8 fd                	test   $0xfd,%al
    f042:	0f 94 c1             	sete   %cl
    f045:	49 39 cb             	cmp    %rcx,%r11
    f048:	75 18                	jne    f062 <tp_int+0x142>
    f04a:	45 31 d2             	xor    %r10d,%r10d
    f04d:	44 89 d0             	mov    %r10d,%eax
    f050:	48 81 c4 b8 00 00 00 	add    $0xb8,%rsp
    f057:	5b                   	pop    %rbx
    f058:	41 5c                	pop    %r12
    f05a:	41 5d                	pop    %r13
    f05c:	41 5e                	pop    %r14
    f05e:	41 5f                	pop    %r15
    f060:	5d                   	pop    %rbp
    f061:	c3                   	ret
    f062:	45 8b 04 24          	mov    (%r12),%r8d
    f066:	41 8b 74 24 48       	mov    0x48(%r12),%esi
    f06b:	76 18                	jbe    f085 <tp_int+0x165>
    f06d:	0f 1f 00             	nopl   (%rax)
    f070:	41 0f b6 14 0f       	movzbl (%r15,%rcx,1),%edx
    f075:	80 c2 c6             	add    $0xc6,%dl
    f078:	80 fa f6             	cmp    $0xf6,%dl
    f07b:	72 cd                	jb     f04a <tp_int+0x12a>
    f07d:	48 ff c1             	inc    %rcx
    f080:	49 39 cb             	cmp    %rcx,%r11
    f083:	75 eb                	jne    f070 <tp_int+0x150>
    f085:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
    f08a:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    f08f:	48 89 74 24 18       	mov    %rsi,0x18(%rsp)
    f094:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    f099:	31 db                	xor    %ebx,%ebx
    f09b:	a8 fd                	test   $0xfd,%al
    f09d:	0f 94 c3             	sete   %bl
    f0a0:	45 31 e4             	xor    %r12d,%r12d
    f0a3:	41 be 00 00 00 00    	mov    $0x0,%r14d
    f0a9:	49 39 db             	cmp    %rbx,%r11
    f0ac:	0f 86 bf 00 00 00    	jbe    f171 <tp_int+0x251>
    f0b2:	bd 0a 00 00 00       	mov    $0xa,%ebp
    f0b7:	49 b8 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r8
    f0be:	cc cc cc 
    f0c1:	49 ba cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r10
    f0c8:	cc cc cc 
    f0cb:	45 31 e4             	xor    %r12d,%r12d
    f0ce:	45 31 f6             	xor    %r14d,%r14d
    f0d1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    f0d8:	0f 1f 84 00 00 00 00 
    f0df:	00 
    f0e0:	4d 89 f1             	mov    %r14,%r9
    f0e3:	4c 89 e1             	mov    %r12,%rcx
    f0e6:	4c 89 e0             	mov    %r12,%rax
    f0e9:	48 f7 e5             	mul    %rbp
    f0ec:	4b 8d 34 b6          	lea    (%r14,%r14,4),%rsi
    f0f0:	48 8d 14 72          	lea    (%rdx,%rsi,2),%rdx
    f0f4:	41 0f be 34 1f       	movsbl (%r15,%rbx,1),%esi
    f0f9:	83 c6 d0             	add    $0xffffffd0,%esi
    f0fc:	48 63 f6             	movslq %esi,%rsi
    f0ff:	49 89 f6             	mov    %rsi,%r14
    f102:	49 c1 fe 3f          	sar    $0x3f,%r14
    f106:	49 89 c4             	mov    %rax,%r12
    f109:	49 01 f4             	add    %rsi,%r12
    f10c:	49 11 d6             	adc    %rdx,%r14
    f10f:	4c 89 f6             	mov    %r14,%rsi
    f112:	4c 0f a4 e6 3f       	shld   $0x3f,%r12,%rsi
    f117:	4d 89 f5             	mov    %r14,%r13
    f11a:	49 d1 ed             	shr    $1,%r13
    f11d:	48 89 f7             	mov    %rsi,%rdi
    f120:	4c 01 ef             	add    %r13,%rdi
    f123:	48 83 d7 00          	adc    $0x0,%rdi
    f127:	48 89 f8             	mov    %rdi,%rax
    f12a:	49 f7 e0             	mul    %r8
    f12d:	48 c1 ea 02          	shr    $0x2,%rdx
    f131:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    f135:	48 29 c7             	sub    %rax,%rdi
    f138:	48 29 fe             	sub    %rdi,%rsi
    f13b:	49 83 dd 00          	sbb    $0x0,%r13
    f13f:	48 89 f7             	mov    %rsi,%rdi
    f142:	49 0f af fa          	imul   %r10,%rdi
    f146:	48 89 f0             	mov    %rsi,%rax
    f149:	49 f7 e0             	mul    %r8
    f14c:	48 01 fa             	add    %rdi,%rdx
    f14f:	4d 0f af e8          	imul   %r8,%r13
    f153:	49 01 d5             	add    %rdx,%r13
    f156:	4d 31 cd             	xor    %r9,%r13
    f159:	48 31 c8             	xor    %rcx,%rax
    f15c:	4c 09 e8             	or     %r13,%rax
    f15f:	0f 85 e5 fe ff ff    	jne    f04a <tp_int+0x12a>
    f165:	48 ff c3             	inc    %rbx
    f168:	49 39 db             	cmp    %rbx,%r11
    f16b:	0f 85 6f ff ff ff    	jne    f0e0 <tp_int+0x1c0>
    f171:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
    f176:	41 83 f8 09          	cmp    $0x9,%r8d
    f17a:	75 71                	jne    f1ed <tp_int+0x2cd>
    f17c:	80 7c 24 10 2d       	cmpb   $0x2d,0x10(%rsp)
    f181:	4c 8d 0d 00 b1 00 00 	lea    0xb100(%rip),%r9        # 1a288 <fwp_gc>
    f188:	75 0f                	jne    f199 <tp_int+0x279>
    f18a:	45 31 d2             	xor    %r10d,%r10d
    f18d:	4c 89 e0             	mov    %r12,%rax
    f190:	4c 09 f0             	or     %r14,%rax
    f193:	0f 85 b4 fe ff ff    	jne    f04d <tp_int+0x12d>
    f199:	48 ff 05 08 cd 00 00 	incq   0xcd08(%rip)        # 1bea8 <measured_calls>
    f1a0:	48 83 05 08 cd 00 00 	addq   $0x10,0xcd08(%rip)        # 1beb0 <measured_bytes>
    f1a7:	10 
    f1a8:	0f b6 0d c2 bc 00 00 	movzbl 0xbcc2(%rip),%ecx        # 1ae71 <fwp_gc+0xbe9>
    f1af:	41 8b 84 89 48 0b 00 	mov    0xb48(%r9,%rcx,4),%eax
    f1b6:	00 
    f1b7:	48 29 05 ca b0 00 00 	sub    %rax,0xb0ca(%rip)        # 1a288 <fwp_gc>
    f1be:	0f 88 d7 00 00 00    	js     f29b <tp_int+0x37b>
    f1c4:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    f1c8:	49 8d 14 c9          	lea    (%r9,%rcx,8),%rdx
    f1cc:	48 81 c2 c8 03 00 00 	add    $0x3c8,%rdx
    f1d3:	4c 8b 3a             	mov    (%rdx),%r15
    f1d6:	4d 85 ff             	test   %r15,%r15
    f1d9:	0f 84 a4 00 00 00    	je     f283 <tp_int+0x363>
    f1df:	49 8b 07             	mov    (%r15),%rax
    f1e2:	48 f7 d0             	not    %rax
    f1e5:	48 89 02             	mov    %rax,(%rdx)
    f1e8:	e9 d9 00 00 00       	jmp    f2c6 <tp_int+0x3a6>
    f1ed:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    f1f2:	40 80 ff 2d          	cmp    $0x2d,%dil
    f1f6:	0f 94 c1             	sete   %cl
    f1f9:	48 b8 00 00 00 00 00 	movabs $0x8000000000000000,%rax
    f200:	00 00 80 
    f203:	4c 89 f2             	mov    %r14,%rdx
    f206:	48 31 c2             	xor    %rax,%rdx
    f209:	4c 09 e2             	or     %r12,%rdx
    f20c:	0f 95 c2             	setne  %dl
    f20f:	45 31 d2             	xor    %r10d,%r10d
    f212:	4c 89 e6             	mov    %r12,%rsi
    f215:	48 f7 de             	neg    %rsi
    f218:	48 89 c6             	mov    %rax,%rsi
    f21b:	4c 19 f6             	sbb    %r14,%rsi
    f21e:	4c 8d 0d 63 b0 00 00 	lea    0xb063(%rip),%r9        # 1a288 <fwp_gc>
    f225:	0f 82 22 fe ff ff    	jb     f04d <tp_int+0x12d>
    f22b:	08 d1                	or     %dl,%cl
    f22d:	0f 84 1a fe ff ff    	je     f04d <tp_int+0x12d>
    f233:	45 31 d2             	xor    %r10d,%r10d
    f236:	4d 89 e7             	mov    %r12,%r15
    f239:	49 f7 df             	neg    %r15
    f23c:	bb 00 00 00 00       	mov    $0x0,%ebx
    f241:	4c 19 f3             	sbb    %r14,%rbx
    f244:	40 80 ff 2d          	cmp    $0x2d,%dil
    f248:	4d 0f 45 fc          	cmovne %r12,%r15
    f24c:	49 0f 45 de          	cmovne %r14,%rbx
    f250:	41 83 f8 14          	cmp    $0x14,%r8d
    f254:	0f 87 f3 fd ff ff    	ja     f04d <tp_int+0x12d>
    f25a:	44 89 c1             	mov    %r8d,%ecx
    f25d:	48 8d 15 2c 60 00 00 	lea    0x602c(%rip),%rdx        # 15290 <_IO_stdin_used+0x290>
    f264:	48 63 0c 8a          	movslq (%rdx,%rcx,4),%rcx
    f268:	48 01 d1             	add    %rdx,%rcx
    f26b:	ff e1                	jmp    *%rcx
    f26d:	4c 89 f8             	mov    %r15,%rax
    f270:	48 83 c0 80          	add    $0xffffffffffffff80,%rax
    f274:	48 83 d3 ff          	adc    $0xffffffffffffffff,%rbx
    f278:	48 3d 00 ff ff ff    	cmp    $0xffffffffffffff00,%rax
    f27e:	e9 93 01 00 00       	jmp    f416 <tp_int+0x4f6>
    f283:	4d 8b bc c9 d0 03 00 	mov    0x3d0(%r9,%rcx,8),%r15
    f28a:	00 
    f28b:	49 8b 94 c9 d8 03 00 	mov    0x3d8(%r9,%rcx,8),%rdx
    f292:	00 
    f293:	4c 29 fa             	sub    %r15,%rdx
    f296:	48 39 c2             	cmp    %rax,%rdx
    f299:	73 1a                	jae    f2b5 <tp_int+0x395>
    f29b:	bf 10 00 00 00       	mov    $0x10,%edi
    f2a0:	be 01 00 00 00       	mov    $0x1,%esi
    f2a5:	4c 89 cb             	mov    %r9,%rbx
    f2a8:	e8 d3 8f ff ff       	call   8280 <fwp_gc_alloc_slow>
    f2ad:	49 89 d9             	mov    %rbx,%r9
    f2b0:	49 89 c7             	mov    %rax,%r15
    f2b3:	eb 18                	jmp    f2cd <tp_int+0x3ad>
    f2b5:	49 8d 0c c9          	lea    (%r9,%rcx,8),%rcx
    f2b9:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
    f2c0:	4c 01 f8             	add    %r15,%rax
    f2c3:	48 89 01             	mov    %rax,(%rcx)
    f2c6:	0f 57 c0             	xorps  %xmm0,%xmm0
    f2c9:	41 0f 11 07          	movups %xmm0,(%r15)
    f2cd:	4d 89 27             	mov    %r12,(%r15)
    f2d0:	4d 89 77 08          	mov    %r14,0x8(%r15)
    f2d4:	4c 89 7c 24 28       	mov    %r15,0x28(%rsp)
    f2d9:	48 ff 05 c8 cb 00 00 	incq   0xcbc8(%rip)        # 1bea8 <measured_calls>
    f2e0:	48 83 05 c8 cb 00 00 	addq   $0x10,0xcbc8(%rip)        # 1beb0 <measured_bytes>
    f2e7:	10 
    f2e8:	0f b6 05 82 bb 00 00 	movzbl 0xbb82(%rip),%eax        # 1ae71 <fwp_gc+0xbe9>
    f2ef:	41 8b 94 81 48 0b 00 	mov    0xb48(%r9,%rax,4),%edx
    f2f6:	00 
    f2f7:	48 8b 0d 8a af 00 00 	mov    0xaf8a(%rip),%rcx        # 1a288 <fwp_gc>
    f2fe:	48 29 d1             	sub    %rdx,%rcx
    f301:	48 89 0d 80 af 00 00 	mov    %rcx,0xaf80(%rip)        # 1a288 <fwp_gc>
    f308:	78 7f                	js     f389 <tp_int+0x469>
    f30a:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
    f30e:	49 8d 34 c1          	lea    (%r9,%rax,8),%rsi
    f312:	48 83 c6 08          	add    $0x8,%rsi
    f316:	4c 8b 36             	mov    (%rsi),%r14
    f319:	4d 85 f6             	test   %r14,%r14
    f31c:	74 2b                	je     f349 <tp_int+0x429>
    f31e:	49 8b 06             	mov    (%r14),%rax
    f321:	48 f7 d0             	not    %rax
    f324:	48 89 06             	mov    %rax,(%rsi)
    f327:	83 fa 11             	cmp    $0x11,%edx
    f32a:	0f 82 80 00 00 00    	jb     f3b0 <tp_int+0x490>
    f330:	49 8d 7e 10          	lea    0x10(%r14),%rdi
    f334:	48 83 c2 ef          	add    $0xffffffffffffffef,%rdx
    f338:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    f33c:	48 83 c2 08          	add    $0x8,%rdx
    f340:	31 f6                	xor    %esi,%esi
    f342:	e8 c9 3e ff ff       	call   3210 <memset@plt>
    f347:	eb 67                	jmp    f3b0 <tp_int+0x490>
    f349:	4d 8b 74 c1 10       	mov    0x10(%r9,%rax,8),%r14
    f34e:	49 8b 74 c1 18       	mov    0x18(%r9,%rax,8),%rsi
    f353:	48 89 f7             	mov    %rsi,%rdi
    f356:	4c 29 f7             	sub    %r14,%rdi
    f359:	48 39 d7             	cmp    %rdx,%rdi
    f35c:	73 05                	jae    f363 <tp_int+0x443>
    f35e:	4d 89 f4             	mov    %r14,%r12
    f361:	eb 21                	jmp    f384 <tp_int+0x464>
    f363:	49 8d 3c c1          	lea    (%r9,%rax,8),%rdi
    f367:	48 83 c7 10          	add    $0x10,%rdi
    f36b:	4d 8d 24 16          	lea    (%r14,%rdx,1),%r12
    f36f:	4c 89 27             	mov    %r12,(%rdi)
    f372:	4d 85 f6             	test   %r14,%r14
    f375:	75 b0                	jne    f327 <tp_int+0x407>
    f377:	48 89 0d 0a af 00 00 	mov    %rcx,0xaf0a(%rip)        # 1a288 <fwp_gc>
    f37e:	4c 29 e6             	sub    %r12,%rsi
    f381:	48 89 f7             	mov    %rsi,%rdi
    f384:	48 39 d7             	cmp    %rdx,%rdi
    f387:	73 11                	jae    f39a <tp_int+0x47a>
    f389:	bf 10 00 00 00       	mov    $0x10,%edi
    f38e:	31 f6                	xor    %esi,%esi
    f390:	e8 eb 8e ff ff       	call   8280 <fwp_gc_alloc_slow>
    f395:	49 89 c6             	mov    %rax,%r14
    f398:	eb 16                	jmp    f3b0 <tp_int+0x490>
    f39a:	49 8d 0c 14          	lea    (%r12,%rdx,1),%rcx
    f39e:	49 89 4c c1 10       	mov    %rcx,0x10(%r9,%rax,8)
    f3a3:	4c 89 e7             	mov    %r12,%rdi
    f3a6:	31 f6                	xor    %esi,%esi
    f3a8:	e8 63 3e ff ff       	call   3210 <memset@plt>
    f3ad:	4d 89 e6             	mov    %r12,%r14
    f3b0:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
    f3b7:	00 00 00 
    f3ba:	49 89 06             	mov    %rax,(%r14)
    f3bd:	4d 89 7e 08          	mov    %r15,0x8(%r14)
    f3c1:	48 8d 44 24 28       	lea    0x28(%rsp),%rax
    f3c6:	49 8b 46 08          	mov    0x8(%r14),%rax
    f3ca:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    f3cf:	48 89 01             	mov    %rax,(%rcx)
    f3d2:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    f3d8:	e9 70 fc ff ff       	jmp    f04d <tp_int+0x12d>
    f3dd:	4c 89 f8             	mov    %r15,%rax
    f3e0:	48 05 00 00 00 80    	add    $0xffffffff80000000,%rax
    f3e6:	48 83 d3 ff          	adc    $0xffffffffffffffff,%rbx
    f3ea:	48 b9 00 00 00 00 ff 	movabs $0xffffffff00000000,%rcx
    f3f1:	ff ff ff 
    f3f4:	48 39 c8             	cmp    %rcx,%rax
    f3f7:	eb 1d                	jmp    f416 <tp_int+0x4f6>
    f3f9:	45 31 d2             	xor    %r10d,%r10d
    f3fc:	b8 ff 00 00 00       	mov    $0xff,%eax
    f401:	eb 2a                	jmp    f42d <tp_int+0x50d>
    f403:	4c 89 f8             	mov    %r15,%rax
    f406:	48 05 00 80 ff ff    	add    $0xffffffffffff8000,%rax
    f40c:	48 83 d3 ff          	adc    $0xffffffffffffffff,%rbx
    f410:	48 3d 00 00 ff ff    	cmp    $0xffffffffffff0000,%rax
    f416:	48 83 db ff          	sbb    $0xffffffffffffffff,%rbx
    f41a:	0f 82 2d fc ff ff    	jb     f04d <tp_int+0x12d>
    f420:	e9 af fe ff ff       	jmp    f2d4 <tp_int+0x3b4>
    f425:	45 31 d2             	xor    %r10d,%r10d
    f428:	b8 ff ff 00 00       	mov    $0xffff,%eax
    f42d:	4c 39 f8             	cmp    %r15,%rax
    f430:	b8 00 00 00 00       	mov    $0x0,%eax
    f435:	48 19 d8             	sbb    %rbx,%rax
    f438:	0f 82 0f fc ff ff    	jb     f04d <tp_int+0x12d>
    f43e:	e9 91 fe ff ff       	jmp    f2d4 <tp_int+0x3b4>
    f443:	4c 89 f8             	mov    %r15,%rax
    f446:	48 c1 e8 20          	shr    $0x20,%rax
    f44a:	48 09 d8             	or     %rbx,%rax
    f44d:	0f 85 fa fb ff ff    	jne    f04d <tp_int+0x12d>
    f453:	e9 7c fe ff ff       	jmp    f2d4 <tp_int+0x3b4>
    f458:	4c 89 f9             	mov    %r15,%rcx
    f45b:	48 01 c1             	add    %rax,%rcx
    f45e:	48 83 d3 ff          	adc    $0xffffffffffffffff,%rbx
    f462:	48 83 fb ff          	cmp    $0xffffffffffffffff,%rbx
    f466:	0f 85 e1 fb ff ff    	jne    f04d <tp_int+0x12d>
    f46c:	e9 63 fe ff ff       	jmp    f2d4 <tp_int+0x3b4>
    f471:	48 ff 05 30 ca 00 00 	incq   0xca30(%rip)        # 1bea8 <measured_calls>
    f478:	48 83 05 30 ca 00 00 	addq   $0x10,0xca30(%rip)        # 1beb0 <measured_bytes>
    f47f:	10 
    f480:	0f b6 05 ea b9 00 00 	movzbl 0xb9ea(%rip),%eax        # 1ae71 <fwp_gc+0xbe9>
    f487:	41 8b 8c 81 48 0b 00 	mov    0xb48(%r9,%rax,4),%ecx
    f48e:	00 
    f48f:	48 29 0d f2 ad 00 00 	sub    %rcx,0xadf2(%rip)        # 1a288 <fwp_gc>
    f496:	0f 88 87 00 00 00    	js     f523 <tp_int+0x603>
    f49c:	48 8d 14 40          	lea    (%rax,%rax,2),%rdx
    f4a0:	49 8d 34 d1          	lea    (%r9,%rdx,8),%rsi
    f4a4:	48 81 c6 c8 03 00 00 	add    $0x3c8,%rsi
    f4ab:	48 8b 06             	mov    (%rsi),%rax
    f4ae:	48 85 c0             	test   %rax,%rax
    f4b1:	74 54                	je     f507 <tp_int+0x5e7>
    f4b3:	48 8b 08             	mov    (%rax),%rcx
    f4b6:	48 f7 d1             	not    %rcx
    f4b9:	48 89 0e             	mov    %rcx,(%rsi)
    f4bc:	e9 12 01 00 00       	jmp    f5d3 <tp_int+0x6b3>
    f4c1:	45 31 d2             	xor    %r10d,%r10d
    f4c4:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    f4c9:	85 c9                	test   %ecx,%ecx
    f4cb:	7e 31                	jle    f4fe <tp_int+0x5de>
    f4cd:	8d 41 ff             	lea    -0x1(%rcx),%eax
    f4d0:	83 f8 4f             	cmp    $0x4f,%eax
    f4d3:	bf 4f 00 00 00       	mov    $0x4f,%edi
    f4d8:	0f 42 f8             	cmovb  %eax,%edi
    f4db:	ff c7                	inc    %edi
    f4dd:	89 fe                	mov    %edi,%esi
    f4df:	83 e6 07             	and    $0x7,%esi
    f4e2:	83 f9 08             	cmp    $0x8,%ecx
    f4e5:	73 56                	jae    f53d <tp_int+0x61d>
    f4e7:	b8 01 00 00 00       	mov    $0x1,%eax
    f4ec:	31 c9                	xor    %ecx,%ecx
    f4ee:	eb 72                	jmp    f562 <tp_int+0x642>
    f4f0:	48 85 db             	test   %rbx,%rbx
    f4f3:	0f 85 54 fb ff ff    	jne    f04d <tp_int+0x12d>
    f4f9:	e9 d6 fd ff ff       	jmp    f2d4 <tp_int+0x3b4>
    f4fe:	31 d2                	xor    %edx,%edx
    f500:	31 c9                	xor    %ecx,%ecx
    f502:	e9 90 00 00 00       	jmp    f597 <tp_int+0x677>
    f507:	49 8b 84 d1 d0 03 00 	mov    0x3d0(%r9,%rdx,8),%rax
    f50e:	00 
    f50f:	49 8b b4 d1 d8 03 00 	mov    0x3d8(%r9,%rdx,8),%rsi
    f516:	00 
    f517:	48 29 c6             	sub    %rax,%rsi
    f51a:	48 39 ce             	cmp    %rcx,%rsi
    f51d:	0f 83 9f 00 00 00    	jae    f5c2 <tp_int+0x6a2>
    f523:	bf 10 00 00 00       	mov    $0x10,%edi
    f528:	be 01 00 00 00       	mov    $0x1,%esi
    f52d:	4d 89 ce             	mov    %r9,%r14
    f530:	e8 4b 8d ff ff       	call   8280 <fwp_gc_alloc_slow>
    f535:	4d 89 f1             	mov    %r14,%r9
    f538:	e9 9c 00 00 00       	jmp    f5d9 <tp_int+0x6b9>
    f53d:	81 e7 f8 00 00 00    	and    $0xf8,%edi
    f543:	b8 01 00 00 00       	mov    $0x1,%eax
    f548:	31 c9                	xor    %ecx,%ecx
    f54a:	41 b8 a1 19 00 00    	mov    $0x19a1,%r8d
    f550:	49 f7 e0             	mul    %r8
    f553:	48 69 c9 a1 19 00 00 	imul   $0x19a1,%rcx,%rcx
    f55a:	48 01 d1             	add    %rdx,%rcx
    f55d:	83 c7 f8             	add    $0xfffffff8,%edi
    f560:	75 ee                	jne    f550 <tp_int+0x630>
    f562:	85 f6                	test   %esi,%esi
    f564:	74 13                	je     f579 <tp_int+0x659>
    f566:	bf 03 00 00 00       	mov    $0x3,%edi
    f56b:	48 f7 e7             	mul    %rdi
    f56e:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    f572:	48 01 d1             	add    %rdx,%rcx
    f575:	ff ce                	dec    %esi
    f577:	75 f2                	jne    f56b <tp_int+0x64b>
    f579:	48 83 c0 ff          	add    $0xffffffffffffffff,%rax
    f57d:	48 83 d1 ff          	adc    $0xffffffffffffffff,%rcx
    f581:	48 89 ca             	mov    %rcx,%rdx
    f584:	48 c1 ea 3f          	shr    $0x3f,%rdx
    f588:	48 01 c2             	add    %rax,%rdx
    f58b:	48 83 d1 00          	adc    $0x0,%rcx
    f58f:	48 0f ac ca 01       	shrd   $0x1,%rcx,%rdx
    f594:	48 d1 f9             	sar    $1,%rcx
    f597:	48 89 d0             	mov    %rdx,%rax
    f59a:	48 f7 d8             	neg    %rax
    f59d:	be 00 00 00 00       	mov    $0x0,%esi
    f5a2:	48 19 ce             	sbb    %rcx,%rsi
    f5a5:	4c 39 fa             	cmp    %r15,%rdx
    f5a8:	48 19 d9             	sbb    %rbx,%rcx
    f5ab:	0f 8c 9c fa ff ff    	jl     f04d <tp_int+0x12d>
    f5b1:	49 39 c7             	cmp    %rax,%r15
    f5b4:	48 19 f3             	sbb    %rsi,%rbx
    f5b7:	0f 8d 17 fd ff ff    	jge    f2d4 <tp_int+0x3b4>
    f5bd:	e9 8b fa ff ff       	jmp    f04d <tp_int+0x12d>
    f5c2:	49 8d 14 d1          	lea    (%r9,%rdx,8),%rdx
    f5c6:	48 81 c2 d0 03 00 00 	add    $0x3d0,%rdx
    f5cd:	48 01 c1             	add    %rax,%rcx
    f5d0:	48 89 0a             	mov    %rcx,(%rdx)
    f5d3:	0f 57 c0             	xorps  %xmm0,%xmm0
    f5d6:	0f 11 00             	movups %xmm0,(%rax)
    f5d9:	4c 89 38             	mov    %r15,(%rax)
    f5dc:	48 89 58 08          	mov    %rbx,0x8(%rax)
    f5e0:	49 89 c7             	mov    %rax,%r15
    f5e3:	e9 ec fc ff ff       	jmp    f2d4 <tp_int+0x3b4>
    f5e8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    f5ef:	00 

000000000000f5f0 <tp_quoted>:
    f5f0:	55                   	push   %rbp
    f5f1:	41 57                	push   %r15
    f5f3:	41 56                	push   %r14
    f5f5:	41 55                	push   %r13
    f5f7:	41 54                	push   %r12
    f5f9:	53                   	push   %rbx
    f5fa:	48 83 ec 28          	sub    $0x28,%rsp
    f5fe:	48 89 f3             	mov    %rsi,%rbx
    f601:	49 89 ff             	mov    %rdi,%r15
    f604:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    f608:	48 8b 6f 10          	mov    0x10(%rdi),%rbp
    f60c:	4c 39 ed             	cmp    %r13,%rbp
    f60f:	73 33                	jae    f644 <tp_quoted+0x54>
    f611:	49 8b 07             	mov    (%r15),%rax
    f614:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    f61b:	00 00 00 
    f61e:	66 90                	xchg   %ax,%ax
    f620:	0f b6 14 28          	movzbl (%rax,%rbp,1),%edx
    f624:	48 83 fa 20          	cmp    $0x20,%rdx
    f628:	77 1a                	ja     f644 <tp_quoted+0x54>
    f62a:	48 0f a3 d1          	bt     %rdx,%rcx
    f62e:	73 14                	jae    f644 <tp_quoted+0x54>
    f630:	48 ff c5             	inc    %rbp
    f633:	49 89 6f 10          	mov    %rbp,0x10(%r15)
    f637:	49 39 ed             	cmp    %rbp,%r13
    f63a:	75 e4                	jne    f620 <tp_quoted+0x30>
    f63c:	45 31 f6             	xor    %r14d,%r14d
    f63f:	e9 f6 01 00 00       	jmp    f83a <tp_quoted+0x24a>
    f644:	45 31 f6             	xor    %r14d,%r14d
    f647:	4c 39 ed             	cmp    %r13,%rbp
    f64a:	0f 83 ea 01 00 00    	jae    f83a <tp_quoted+0x24a>
    f650:	49 8b 07             	mov    (%r15),%rax
    f653:	80 3c 28 22          	cmpb   $0x22,(%rax,%rbp,1)
    f657:	0f 85 dd 01 00 00    	jne    f83a <tp_quoted+0x24a>
    f65d:	48 ff c5             	inc    %rbp
    f660:	49 89 6f 10          	mov    %rbp,0x10(%r15)
    f664:	0f 57 c0             	xorps  %xmm0,%xmm0
    f667:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    f66c:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    f673:	00 00 
    f675:	45 31 f6             	xor    %r14d,%r14d
    f678:	4c 39 ed             	cmp    %r13,%rbp
    f67b:	0f 83 a6 01 00 00    	jae    f827 <tp_quoted+0x237>
    f681:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    f688:	0f 1f 84 00 00 00 00 
    f68f:	00 
    f690:	4d 8b 27             	mov    (%r15),%r12
    f693:	48 8d 4d 01          	lea    0x1(%rbp),%rcx
    f697:	49 89 4f 10          	mov    %rcx,0x10(%r15)
    f69b:	41 0f b6 04 2c       	movzbl (%r12,%rbp,1),%eax
    f6a0:	83 f8 5c             	cmp    $0x5c,%eax
    f6a3:	74 3b                	je     f6e0 <tp_quoted+0xf0>
    f6a5:	83 f8 22             	cmp    $0x22,%eax
    f6a8:	0f 84 9e 01 00 00    	je     f84c <tp_quoted+0x25c>
    f6ae:	88 44 24 0f          	mov    %al,0xf(%rsp)
    f6b2:	ba 01 00 00 00       	mov    $0x1,%edx
    f6b7:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    f6bc:	48 8d 74 24 0f       	lea    0xf(%rsp),%rsi
    f6c1:	e8 0a db ff ff       	call   d1d0 <buf_put>
    f6c6:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    f6ca:	49 8b 6f 10          	mov    0x10(%r15),%rbp
    f6ce:	4c 39 ed             	cmp    %r13,%rbp
    f6d1:	72 bd                	jb     f690 <tp_quoted+0xa0>
    f6d3:	e9 58 01 00 00       	jmp    f830 <tp_quoted+0x240>
    f6d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    f6df:	00 
    f6e0:	4c 39 e9             	cmp    %r13,%rcx
    f6e3:	0f 83 47 01 00 00    	jae    f830 <tp_quoted+0x240>
    f6e9:	48 8d 45 02          	lea    0x2(%rbp),%rax
    f6ed:	49 89 47 10          	mov    %rax,0x10(%r15)
    f6f1:	41 0f b6 4c 2c 01    	movzbl 0x1(%r12,%rbp,1),%ecx
    f6f7:	8d 51 a4             	lea    -0x5c(%rcx),%edx
    f6fa:	83 fa 19             	cmp    $0x19,%edx
    f6fd:	77 17                	ja     f716 <tp_quoted+0x126>
    f6ff:	48 8d 35 de 5b 00 00 	lea    0x5bde(%rip),%rsi        # 152e4 <_IO_stdin_used+0x2e4>
    f706:	48 63 0c 96          	movslq (%rsi,%rdx,4),%rcx
    f70a:	48 01 f1             	add    %rsi,%rcx
    f70d:	ff e1                	jmp    *%rcx
    f70f:	c6 44 24 0f 5c       	movb   $0x5c,0xf(%rsp)
    f714:	eb 9c                	jmp    f6b2 <tp_quoted+0xc2>
    f716:	83 f9 22             	cmp    $0x22,%ecx
    f719:	0f 84 c2 00 00 00    	je     f7e1 <tp_quoted+0x1f1>
    f71f:	83 f9 30             	cmp    $0x30,%ecx
    f722:	0f 85 08 01 00 00    	jne    f830 <tp_quoted+0x240>
    f728:	c6 44 24 0f 00       	movb   $0x0,0xf(%rsp)
    f72d:	eb 83                	jmp    f6b2 <tp_quoted+0xc2>
    f72f:	c6 44 24 0f 09       	movb   $0x9,0xf(%rsp)
    f734:	e9 79 ff ff ff       	jmp    f6b2 <tp_quoted+0xc2>
    f739:	c6 44 24 0f 0d       	movb   $0xd,0xf(%rsp)
    f73e:	e9 6f ff ff ff       	jmp    f6b2 <tp_quoted+0xc2>
    f743:	c6 44 24 0f 0a       	movb   $0xa,0xf(%rsp)
    f748:	e9 65 ff ff ff       	jmp    f6b2 <tp_quoted+0xc2>
    f74d:	4c 39 e8             	cmp    %r13,%rax
    f750:	0f 83 da 00 00 00    	jae    f830 <tp_quoted+0x240>
    f756:	41 80 3c 04 7b       	cmpb   $0x7b,(%r12,%rax,1)
    f75b:	0f 85 cf 00 00 00    	jne    f830 <tp_quoted+0x240>
    f761:	48 8d 45 03          	lea    0x3(%rbp),%rax
    f765:	49 89 47 10          	mov    %rax,0x10(%r15)
    f769:	4c 39 e8             	cmp    %r13,%rax
    f76c:	0f 83 be 00 00 00    	jae    f830 <tp_quoted+0x240>
    f772:	e8 69 3d ff ff       	call   34e0 <__ctype_b_loc@plt>
    f777:	48 8b 08             	mov    (%rax),%rcx
    f77a:	48 8d 55 04          	lea    0x4(%rbp),%rdx
    f77e:	49 8d 3c 2c          	lea    (%r12,%rbp,1),%rdi
    f782:	48 83 c7 03          	add    $0x3,%rdi
    f786:	49 29 ed             	sub    %rbp,%r13
    f789:	49 83 c5 fd          	add    $0xfffffffffffffffd,%r13
    f78d:	31 c0                	xor    %eax,%eax
    f78f:	31 f6                	xor    %esi,%esi
    f791:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    f798:	0f 1f 84 00 00 00 00 
    f79f:	00 
    f7a0:	44 0f b6 04 07       	movzbl (%rdi,%rax,1),%r8d
    f7a5:	42 f6 44 41 01 10    	testb  $0x10,0x1(%rcx,%r8,2)
    f7ab:	74 3e                	je     f7eb <tp_quoted+0x1fb>
    f7ad:	4c 8d 04 02          	lea    (%rdx,%rax,1),%r8
    f7b1:	4d 89 47 10          	mov    %r8,0x10(%r15)
    f7b5:	44 0f be 04 07       	movsbl (%rdi,%rax,1),%r8d
    f7ba:	c1 e6 04             	shl    $0x4,%esi
    f7bd:	45 8d 48 d0          	lea    -0x30(%r8),%r9d
    f7c1:	45 89 c2             	mov    %r8d,%r10d
    f7c4:	41 83 ca 20          	or     $0x20,%r10d
    f7c8:	41 83 c2 a9          	add    $0xffffffa9,%r10d
    f7cc:	41 83 f8 3a          	cmp    $0x3a,%r8d
    f7d0:	45 0f 4c d1          	cmovl  %r9d,%r10d
    f7d4:	44 01 d6             	add    %r10d,%esi
    f7d7:	48 ff c0             	inc    %rax
    f7da:	49 39 c5             	cmp    %rax,%r13
    f7dd:	75 c1                	jne    f7a0 <tp_quoted+0x1b0>
    f7df:	eb 4f                	jmp    f830 <tp_quoted+0x240>
    f7e1:	c6 44 24 0f 22       	movb   $0x22,0xf(%rsp)
    f7e6:	e9 c7 fe ff ff       	jmp    f6b2 <tp_quoted+0xc2>
    f7eb:	85 c0                	test   %eax,%eax
    f7ed:	74 41                	je     f830 <tp_quoted+0x240>
    f7ef:	41 80 f8 7d          	cmp    $0x7d,%r8b
    f7f3:	75 3b                	jne    f830 <tp_quoted+0x240>
    f7f5:	81 fe ff ff 10 00    	cmp    $0x10ffff,%esi
    f7fb:	77 33                	ja     f830 <tp_quoted+0x240>
    f7fd:	89 f1                	mov    %esi,%ecx
    f7ff:	81 e1 00 f8 ff ff    	and    $0xfffff800,%ecx
    f805:	81 f9 00 d8 00 00    	cmp    $0xd800,%ecx
    f80b:	74 23                	je     f830 <tp_quoted+0x240>
    f80d:	48 01 e8             	add    %rbp,%rax
    f810:	48 83 c0 04          	add    $0x4,%rax
    f814:	49 89 47 10          	mov    %rax,0x10(%r15)
    f818:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    f81d:	e8 ae 0b 00 00       	call   103d0 <fwp_utf8_put>
    f822:	e9 9f fe ff ff       	jmp    f6c6 <tp_quoted+0xd6>
    f827:	31 ff                	xor    %edi,%edi
    f829:	e8 22 38 ff ff       	call   3050 <free@plt>
    f82e:	eb 0a                	jmp    f83a <tp_quoted+0x24a>
    f830:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    f835:	e8 16 38 ff ff       	call   3050 <free@plt>
    f83a:	44 89 f0             	mov    %r14d,%eax
    f83d:	48 83 c4 28          	add    $0x28,%rsp
    f841:	5b                   	pop    %rbx
    f842:	41 5c                	pop    %r12
    f844:	41 5d                	pop    %r13
    f846:	41 5e                	pop    %r14
    f848:	41 5f                	pop    %r15
    f84a:	5d                   	pop    %rbp
    f84b:	c3                   	ret
    f84c:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    f851:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    f856:	48 85 ff             	test   %rdi,%rdi
    f859:	48 8d 0d 66 69 00 00 	lea    0x6966(%rip),%rcx        # 161c6 <exec_in_fp0+0x956>
    f860:	48 0f 45 cf          	cmovne %rdi,%rcx
    f864:	48 85 c0             	test   %rax,%rax
    f867:	0f 84 3e 01 00 00    	je     f9ab <tp_quoted+0x3bb>
    f86d:	31 d2                	xor    %edx,%edx
    f86f:	eb 0c                	jmp    f87d <tp_quoted+0x28d>
    f871:	48 ff c2             	inc    %rdx
    f874:	48 39 c2             	cmp    %rax,%rdx
    f877:	0f 83 2e 01 00 00    	jae    f9ab <tp_quoted+0x3bb>
    f87d:	44 0f b6 14 11       	movzbl (%rcx,%rdx,1),%r10d
    f882:	45 84 d2             	test   %r10b,%r10b
    f885:	79 ea                	jns    f871 <tp_quoted+0x281>
    f887:	41 8d 72 3e          	lea    0x3e(%r10),%esi
    f88b:	40 80 fe 1e          	cmp    $0x1e,%sil
    f88f:	73 13                	jae    f8a4 <tp_quoted+0x2b4>
    f891:	be 80 00 00 00       	mov    $0x80,%esi
    f896:	41 b9 01 00 00 00    	mov    $0x1,%r9d
    f89c:	41 b8 1f 00 00 00    	mov    $0x1f,%r8d
    f8a2:	eb 3f                	jmp    f8e3 <tp_quoted+0x2f3>
    f8a4:	44 89 d6             	mov    %r10d,%esi
    f8a7:	40 80 e6 f0          	and    $0xf0,%sil
    f8ab:	40 80 fe e0          	cmp    $0xe0,%sil
    f8af:	75 13                	jne    f8c4 <tp_quoted+0x2d4>
    f8b1:	be 00 08 00 00       	mov    $0x800,%esi
    f8b6:	41 b9 02 00 00 00    	mov    $0x2,%r9d
    f8bc:	41 b8 0f 00 00 00    	mov    $0xf,%r8d
    f8c2:	eb 1f                	jmp    f8e3 <tp_quoted+0x2f3>
    f8c4:	41 8d 72 10          	lea    0x10(%r10),%esi
    f8c8:	40 80 fe 04          	cmp    $0x4,%sil
    f8cc:	0f 87 f1 00 00 00    	ja     f9c3 <tp_quoted+0x3d3>
    f8d2:	be 00 00 01 00       	mov    $0x10000,%esi
    f8d7:	41 b9 03 00 00 00    	mov    $0x3,%r9d
    f8dd:	41 b8 07 00 00 00    	mov    $0x7,%r8d
    f8e3:	45 89 c9             	mov    %r9d,%r9d
    f8e6:	4e 8d 1c 0a          	lea    (%rdx,%r9,1),%r11
    f8ea:	49 39 c3             	cmp    %rax,%r11
    f8ed:	0f 83 d0 00 00 00    	jae    f9c3 <tp_quoted+0x3d3>
    f8f3:	44 0f b6 5c 11 01    	movzbl 0x1(%rcx,%rdx,1),%r11d
    f8f9:	44 89 dd             	mov    %r11d,%ebp
    f8fc:	83 e5 c0             	and    $0xffffffc0,%ebp
    f8ff:	81 fd 80 00 00 00    	cmp    $0x80,%ebp
    f905:	0f 85 b8 00 00 00    	jne    f9c3 <tp_quoted+0x3d3>
    f90b:	45 21 d0             	and    %r10d,%r8d
    f90e:	45 8d 51 01          	lea    0x1(%r9),%r10d
    f912:	44 89 c5             	mov    %r8d,%ebp
    f915:	c1 e5 06             	shl    $0x6,%ebp
    f918:	41 83 e3 3f          	and    $0x3f,%r11d
    f91c:	41 09 eb             	or     %ebp,%r11d
    f91f:	41 83 fa 02          	cmp    $0x2,%r10d
    f923:	75 05                	jne    f92a <tp_quoted+0x33a>
    f925:	45 89 da             	mov    %r11d,%r10d
    f928:	eb 57                	jmp    f981 <tp_quoted+0x391>
    f92a:	44 0f b6 44 11 02    	movzbl 0x2(%rcx,%rdx,1),%r8d
    f930:	44 89 c5             	mov    %r8d,%ebp
    f933:	83 e5 c0             	and    $0xffffffc0,%ebp
    f936:	81 fd 80 00 00 00    	cmp    $0x80,%ebp
    f93c:	0f 85 81 00 00 00    	jne    f9c3 <tp_quoted+0x3d3>
    f942:	44 89 dd             	mov    %r11d,%ebp
    f945:	c1 e5 06             	shl    $0x6,%ebp
    f948:	41 83 e0 3f          	and    $0x3f,%r8d
    f94c:	41 09 e8             	or     %ebp,%r8d
    f94f:	41 83 fa 03          	cmp    $0x3,%r10d
    f953:	75 08                	jne    f95d <tp_quoted+0x36d>
    f955:	45 89 c2             	mov    %r8d,%r10d
    f958:	45 89 d8             	mov    %r11d,%r8d
    f95b:	eb 24                	jmp    f981 <tp_quoted+0x391>
    f95d:	44 0f b6 54 11 03    	movzbl 0x3(%rcx,%rdx,1),%r10d
    f963:	45 89 d3             	mov    %r10d,%r11d
    f966:	41 83 e3 c0          	and    $0xffffffc0,%r11d
    f96a:	41 81 fb 80 00 00 00 	cmp    $0x80,%r11d
    f971:	75 50                	jne    f9c3 <tp_quoted+0x3d3>
    f973:	45 89 c3             	mov    %r8d,%r11d
    f976:	41 c1 e3 06          	shl    $0x6,%r11d
    f97a:	41 83 e2 3f          	and    $0x3f,%r10d
    f97e:	45 09 da             	or     %r11d,%r10d
    f981:	41 83 e0 e0          	and    $0xffffffe0,%r8d
    f985:	41 81 f8 60 03 00 00 	cmp    $0x360,%r8d
    f98c:	74 35                	je     f9c3 <tp_quoted+0x3d3>
    f98e:	41 39 f2             	cmp    %esi,%r10d
    f991:	72 30                	jb     f9c3 <tp_quoted+0x3d3>
    f993:	41 81 fa ff ff 10 00 	cmp    $0x10ffff,%r10d
    f99a:	77 27                	ja     f9c3 <tp_quoted+0x3d3>
    f99c:	4c 01 ca             	add    %r9,%rdx
    f99f:	48 ff c2             	inc    %rdx
    f9a2:	48 39 c2             	cmp    %rax,%rdx
    f9a5:	0f 82 d2 fe ff ff    	jb     f87d <tp_quoted+0x28d>
    f9ab:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    f9b0:	e8 0b d9 ff ff       	call   d2c0 <buf_to_str>
    f9b5:	48 89 03             	mov    %rax,(%rbx)
    f9b8:	41 be 01 00 00 00    	mov    $0x1,%r14d
    f9be:	e9 77 fe ff ff       	jmp    f83a <tp_quoted+0x24a>
    f9c3:	e8 88 36 ff ff       	call   3050 <free@plt>
    f9c8:	e9 6f fc ff ff       	jmp    f63c <tp_quoted+0x4c>
    f9cd:	0f 1f 00             	nopl   (%rax)

000000000000f9d0 <tp_eat>:
    f9d0:	55                   	push   %rbp
    f9d1:	41 57                	push   %r15
    f9d3:	41 56                	push   %r14
    f9d5:	41 54                	push   %r12
    f9d7:	53                   	push   %rbx
    f9d8:	49 89 f6             	mov    %rsi,%r14
    f9db:	48 89 fb             	mov    %rdi,%rbx
    f9de:	4c 8b 67 08          	mov    0x8(%rdi),%r12
    f9e2:	4c 8b 7f 10          	mov    0x10(%rdi),%r15
    f9e6:	4d 39 e7             	cmp    %r12,%r15
    f9e9:	73 35                	jae    fa20 <tp_eat+0x50>
    f9eb:	48 8b 03             	mov    (%rbx),%rax
    f9ee:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    f9f5:	00 00 00 
    f9f8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    f9ff:	00 
    fa00:	42 0f b6 14 38       	movzbl (%rax,%r15,1),%edx
    fa05:	48 83 fa 20          	cmp    $0x20,%rdx
    fa09:	77 15                	ja     fa20 <tp_eat+0x50>
    fa0b:	48 0f a3 d1          	bt     %rdx,%rcx
    fa0f:	73 0f                	jae    fa20 <tp_eat+0x50>
    fa11:	49 ff c7             	inc    %r15
    fa14:	4c 89 7b 10          	mov    %r15,0x10(%rbx)
    fa18:	4d 39 fc             	cmp    %r15,%r12
    fa1b:	75 e3                	jne    fa00 <tp_eat+0x30>
    fa1d:	4d 89 e7             	mov    %r12,%r15
    fa20:	4c 89 f7             	mov    %r14,%rdi
    fa23:	e8 48 37 ff ff       	call   3170 <strlen@plt>
    fa28:	4d 29 fc             	sub    %r15,%r12
    fa2b:	31 ed                	xor    %ebp,%ebp
    fa2d:	49 39 c4             	cmp    %rax,%r12
    fa30:	72 24                	jb     fa56 <tp_eat+0x86>
    fa32:	48 8b 3b             	mov    (%rbx),%rdi
    fa35:	4c 01 ff             	add    %r15,%rdi
    fa38:	4c 89 f6             	mov    %r14,%rsi
    fa3b:	49 89 c6             	mov    %rax,%r14
    fa3e:	48 89 c2             	mov    %rax,%rdx
    fa41:	e8 2a 39 ff ff       	call   3370 <bcmp@plt>
    fa46:	85 c0                	test   %eax,%eax
    fa48:	75 0c                	jne    fa56 <tp_eat+0x86>
    fa4a:	4d 01 f7             	add    %r14,%r15
    fa4d:	4c 89 7b 10          	mov    %r15,0x10(%rbx)
    fa51:	bd 01 00 00 00       	mov    $0x1,%ebp
    fa56:	89 e8                	mov    %ebp,%eax
    fa58:	5b                   	pop    %rbx
    fa59:	41 5c                	pop    %r12
    fa5b:	41 5e                	pop    %r14
    fa5d:	41 5f                	pop    %r15
    fa5f:	5d                   	pop    %rbp
    fa60:	c3                   	ret
    fa61:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    fa68:	0f 1f 84 00 00 00 00 
    fa6f:	00 

000000000000fa70 <tp_list_of>:
    fa70:	55                   	push   %rbp
    fa71:	41 57                	push   %r15
    fa73:	41 56                	push   %r14
    fa75:	41 55                	push   %r13
    fa77:	41 54                	push   %r12
    fa79:	53                   	push   %rbx
    fa7a:	48 83 ec 18          	sub    $0x18,%rsp
    fa7e:	4d 89 c6             	mov    %r8,%r14
    fa81:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
    fa86:	49 89 f7             	mov    %rsi,%r15
    fa89:	48 89 fb             	mov    %rdi,%rbx
    fa8c:	48 8b 6f 08          	mov    0x8(%rdi),%rbp
    fa90:	4c 8b 67 10          	mov    0x10(%rdi),%r12
    fa94:	49 39 ec             	cmp    %rbp,%r12
    fa97:	48 89 14 24          	mov    %rdx,(%rsp)
    fa9b:	73 33                	jae    fad0 <tp_list_of+0x60>
    fa9d:	48 8b 03             	mov    (%rbx),%rax
    faa0:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    faa7:	00 00 00 
    faaa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    fab0:	42 0f b6 34 20       	movzbl (%rax,%r12,1),%esi
    fab5:	48 83 fe 20          	cmp    $0x20,%rsi
    fab9:	77 15                	ja     fad0 <tp_list_of+0x60>
    fabb:	48 0f a3 f1          	bt     %rsi,%rcx
    fabf:	73 0f                	jae    fad0 <tp_list_of+0x60>
    fac1:	49 ff c4             	inc    %r12
    fac4:	4c 89 63 10          	mov    %r12,0x10(%rbx)
    fac8:	4c 39 e5             	cmp    %r12,%rbp
    facb:	75 e3                	jne    fab0 <tp_list_of+0x40>
    facd:	49 89 ec             	mov    %rbp,%r12
    fad0:	4c 89 ff             	mov    %r15,%rdi
    fad3:	e8 98 36 ff ff       	call   3170 <strlen@plt>
    fad8:	49 89 c5             	mov    %rax,%r13
    fadb:	48 89 e9             	mov    %rbp,%rcx
    fade:	4c 29 e1             	sub    %r12,%rcx
    fae1:	31 c0                	xor    %eax,%eax
    fae3:	4c 39 e9             	cmp    %r13,%rcx
    fae6:	72 1d                	jb     fb05 <tp_list_of+0x95>
    fae8:	4c 89 74 24 08       	mov    %r14,0x8(%rsp)
    faed:	4c 8b 33             	mov    (%rbx),%r14
    faf0:	4b 8d 3c 26          	lea    (%r14,%r12,1),%rdi
    faf4:	4c 89 fe             	mov    %r15,%rsi
    faf7:	4c 89 ea             	mov    %r13,%rdx
    fafa:	e8 71 38 ff ff       	call   3370 <bcmp@plt>
    faff:	85 c0                	test   %eax,%eax
    fb01:	74 11                	je     fb14 <tp_list_of+0xa4>
    fb03:	31 c0                	xor    %eax,%eax
    fb05:	48 83 c4 18          	add    $0x18,%rsp
    fb09:	5b                   	pop    %rbx
    fb0a:	41 5c                	pop    %r12
    fb0c:	41 5d                	pop    %r13
    fb0e:	41 5e                	pop    %r14
    fb10:	41 5f                	pop    %r15
    fb12:	5d                   	pop    %rbp
    fb13:	c3                   	ret
    fb14:	4d 01 e5             	add    %r12,%r13
    fb17:	4c 89 6b 10          	mov    %r13,0x10(%rbx)
    fb1b:	49 bc 00 26 00 00 01 	movabs $0x100002600,%r12
    fb22:	00 00 00 
    fb25:	49 39 ed             	cmp    %rbp,%r13
    fb28:	73 28                	jae    fb52 <tp_list_of+0xe2>
    fb2a:	48 8b 3c 24          	mov    (%rsp),%rdi
    fb2e:	66 90                	xchg   %ax,%ax
    fb30:	43 0f b6 04 2e       	movzbl (%r14,%r13,1),%eax
    fb35:	48 83 f8 20          	cmp    $0x20,%rax
    fb39:	77 1b                	ja     fb56 <tp_list_of+0xe6>
    fb3b:	49 0f a3 c4          	bt     %rax,%r12
    fb3f:	73 15                	jae    fb56 <tp_list_of+0xe6>
    fb41:	49 ff c5             	inc    %r13
    fb44:	4c 89 6b 10          	mov    %r13,0x10(%rbx)
    fb48:	4c 39 ed             	cmp    %r13,%rbp
    fb4b:	75 e3                	jne    fb30 <tp_list_of+0xc0>
    fb4d:	49 89 ed             	mov    %rbp,%r13
    fb50:	eb 04                	jmp    fb56 <tp_list_of+0xe6>
    fb52:	48 8b 3c 24          	mov    (%rsp),%rdi
    fb56:	e8 15 36 ff ff       	call   3170 <strlen@plt>
    fb5b:	4c 29 ed             	sub    %r13,%rbp
    fb5e:	48 39 c5             	cmp    %rax,%rbp
    fb61:	48 8b 34 24          	mov    (%rsp),%rsi
    fb65:	72 19                	jb     fb80 <tp_list_of+0x110>
    fb67:	49 89 c7             	mov    %rax,%r15
    fb6a:	4d 01 ee             	add    %r13,%r14
    fb6d:	4c 89 f7             	mov    %r14,%rdi
    fb70:	48 89 c2             	mov    %rax,%rdx
    fb73:	e8 f8 37 ff ff       	call   3370 <bcmp@plt>
    fb78:	85 c0                	test   %eax,%eax
    fb7a:	0f 84 da 00 00 00    	je     fc5a <tp_list_of+0x1ea>
    fb80:	48 89 df             	mov    %rbx,%rdi
    fb83:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    fb88:	ff 54 24 10          	call   *0x10(%rsp)
    fb8c:	85 c0                	test   %eax,%eax
    fb8e:	0f 84 6f ff ff ff    	je     fb03 <tp_list_of+0x93>
    fb94:	4c 8b 6b 08          	mov    0x8(%rbx),%r13
    fb98:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    fb9c:	4d 39 ee             	cmp    %r13,%r14
    fb9f:	73 31                	jae    fbd2 <tp_list_of+0x162>
    fba1:	48 8b 03             	mov    (%rbx),%rax
    fba4:	48 8b 2c 24          	mov    (%rsp),%rbp
    fba8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    fbaf:	00 
    fbb0:	42 0f b6 0c 30       	movzbl (%rax,%r14,1),%ecx
    fbb5:	48 83 f9 20          	cmp    $0x20,%rcx
    fbb9:	77 1b                	ja     fbd6 <tp_list_of+0x166>
    fbbb:	49 0f a3 cc          	bt     %rcx,%r12
    fbbf:	73 15                	jae    fbd6 <tp_list_of+0x166>
    fbc1:	49 ff c6             	inc    %r14
    fbc4:	4c 89 73 10          	mov    %r14,0x10(%rbx)
    fbc8:	4d 39 f5             	cmp    %r14,%r13
    fbcb:	75 e3                	jne    fbb0 <tp_list_of+0x140>
    fbcd:	4d 89 ee             	mov    %r13,%r14
    fbd0:	eb 04                	jmp    fbd6 <tp_list_of+0x166>
    fbd2:	48 8b 2c 24          	mov    (%rsp),%rbp
    fbd6:	48 89 ef             	mov    %rbp,%rdi
    fbd9:	e8 92 35 ff ff       	call   3170 <strlen@plt>
    fbde:	49 89 c7             	mov    %rax,%r15
    fbe1:	4c 89 e8             	mov    %r13,%rax
    fbe4:	4c 29 f0             	sub    %r14,%rax
    fbe7:	4c 39 f8             	cmp    %r15,%rax
    fbea:	72 15                	jb     fc01 <tp_list_of+0x191>
    fbec:	48 8b 3b             	mov    (%rbx),%rdi
    fbef:	4c 01 f7             	add    %r14,%rdi
    fbf2:	48 89 ee             	mov    %rbp,%rsi
    fbf5:	4c 89 fa             	mov    %r15,%rdx
    fbf8:	e8 73 37 ff ff       	call   3370 <bcmp@plt>
    fbfd:	85 c0                	test   %eax,%eax
    fbff:	74 6a                	je     fc6b <tp_list_of+0x1fb>
    fc01:	4d 39 f5             	cmp    %r14,%r13
    fc04:	76 2c                	jbe    fc32 <tp_list_of+0x1c2>
    fc06:	48 8b 03             	mov    (%rbx),%rax
    fc09:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    fc10:	42 0f b6 0c 30       	movzbl (%rax,%r14,1),%ecx
    fc15:	48 83 f9 20          	cmp    $0x20,%rcx
    fc19:	77 17                	ja     fc32 <tp_list_of+0x1c2>
    fc1b:	49 0f a3 cc          	bt     %rcx,%r12
    fc1f:	73 11                	jae    fc32 <tp_list_of+0x1c2>
    fc21:	49 ff c6             	inc    %r14
    fc24:	4c 89 73 10          	mov    %r14,0x10(%rbx)
    fc28:	4d 39 f5             	cmp    %r14,%r13
    fc2b:	75 e3                	jne    fc10 <tp_list_of+0x1a0>
    fc2d:	e9 d1 fe ff ff       	jmp    fb03 <tp_list_of+0x93>
    fc32:	4d 39 f5             	cmp    %r14,%r13
    fc35:	b8 00 00 00 00       	mov    $0x0,%eax
    fc3a:	0f 84 c5 fe ff ff    	je     fb05 <tp_list_of+0x95>
    fc40:	48 8b 0b             	mov    (%rbx),%rcx
    fc43:	42 80 3c 31 2c       	cmpb   $0x2c,(%rcx,%r14,1)
    fc48:	0f 85 b7 fe ff ff    	jne    fb05 <tp_list_of+0x95>
    fc4e:	49 ff c6             	inc    %r14
    fc51:	4c 89 73 10          	mov    %r14,0x10(%rbx)
    fc55:	e9 26 ff ff ff       	jmp    fb80 <tp_list_of+0x110>
    fc5a:	4d 01 ef             	add    %r13,%r15
    fc5d:	4c 89 7b 10          	mov    %r15,0x10(%rbx)
    fc61:	b8 01 00 00 00       	mov    $0x1,%eax
    fc66:	e9 9a fe ff ff       	jmp    fb05 <tp_list_of+0x95>
    fc6b:	4d 01 f7             	add    %r14,%r15
    fc6e:	eb ed                	jmp    fc5d <tp_list_of+0x1ed>

000000000000fc70 <tp_byte_item>:
    fc70:	53                   	push   %rbx
    fc71:	48 83 ec 10          	sub    $0x10,%rsp
    fc75:	48 89 f3             	mov    %rsi,%rbx
    fc78:	48 8d 35 81 a0 00 00 	lea    0xa081(%rip),%rsi        # 19d00 <tp_byte_item.u8d>
    fc7f:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    fc84:	e8 97 f2 ff ff       	call   ef20 <tp_int>
    fc89:	85 c0                	test   %eax,%eax
    fc8b:	74 14                	je     fca1 <tp_byte_item+0x31>
    fc8d:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    fc92:	48 89 df             	mov    %rbx,%rdi
    fc95:	e8 e6 07 00 00       	call   10480 <tp_push>
    fc9a:	b8 01 00 00 00       	mov    $0x1,%eax
    fc9f:	eb 02                	jmp    fca3 <tp_byte_item+0x33>
    fca1:	31 c0                	xor    %eax,%eax
    fca3:	48 83 c4 10          	add    $0x10,%rsp
    fca7:	5b                   	pop    %rbx
    fca8:	c3                   	ret
    fca9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000fcb0 <tp_token>:
    fcb0:	41 57                	push   %r15
    fcb2:	41 56                	push   %r14
    fcb4:	41 54                	push   %r12
    fcb6:	53                   	push   %rbx
    fcb7:	50                   	push   %rax
    fcb8:	49 89 f6             	mov    %rsi,%r14
    fcbb:	48 89 fb             	mov    %rdi,%rbx
    fcbe:	48 8b 37             	mov    (%rdi),%rsi
    fcc1:	48 8b 47 08          	mov    0x8(%rdi),%rax
    fcc5:	4c 8b 67 10          	mov    0x10(%rdi),%r12
    fcc9:	49 39 c4             	cmp    %rax,%r12
    fccc:	73 37                	jae    fd05 <tp_token+0x55>
    fcce:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    fcd5:	00 00 00 
    fcd8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    fcdf:	00 
    fce0:	42 0f b6 3c 26       	movzbl (%rsi,%r12,1),%edi
    fce5:	48 83 ff 20          	cmp    $0x20,%rdi
    fce9:	77 1a                	ja     fd05 <tp_token+0x55>
    fceb:	48 0f a3 f9          	bt     %rdi,%rcx
    fcef:	73 14                	jae    fd05 <tp_token+0x55>
    fcf1:	49 ff c4             	inc    %r12
    fcf4:	4c 89 63 10          	mov    %r12,0x10(%rbx)
    fcf8:	4c 39 e0             	cmp    %r12,%rax
    fcfb:	75 e3                	jne    fce0 <tp_token+0x30>
    fcfd:	49 89 c4             	mov    %rax,%r12
    fd00:	48 89 c1             	mov    %rax,%rcx
    fd03:	eb 49                	jmp    fd4e <tp_token+0x9e>
    fd05:	49 39 c4             	cmp    %rax,%r12
    fd08:	73 41                	jae    fd4b <tp_token+0x9b>
    fd0a:	48 8d 3d 3b 56 00 00 	lea    0x563b(%rip),%rdi        # 1534c <_IO_stdin_used+0x34c>
    fd11:	4c 89 e1             	mov    %r12,%rcx
    fd14:	eb 1c                	jmp    fd32 <tp_token+0x82>
    fd16:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    fd1d:	00 00 00 
    fd20:	41 83 f8 7d          	cmp    $0x7d,%r8d
    fd24:	74 28                	je     fd4e <tp_token+0x9e>
    fd26:	48 ff c1             	inc    %rcx
    fd29:	48 89 4b 10          	mov    %rcx,0x10(%rbx)
    fd2d:	48 39 c8             	cmp    %rcx,%rax
    fd30:	74 ce                	je     fd00 <tp_token+0x50>
    fd32:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
    fd37:	45 8d 48 f7          	lea    -0x9(%r8),%r9d
    fd3b:	41 83 f9 54          	cmp    $0x54,%r9d
    fd3f:	77 df                	ja     fd20 <tp_token+0x70>
    fd41:	4e 63 04 8f          	movslq (%rdi,%r9,4),%r8
    fd45:	49 01 f8             	add    %rdi,%r8
    fd48:	41 ff e0             	jmp    *%r8
    fd4b:	4c 89 e1             	mov    %r12,%rcx
    fd4e:	4c 29 e1             	sub    %r12,%rcx
    fd51:	4c 8d 7a ff          	lea    -0x1(%rdx),%r15
    fd55:	48 39 d1             	cmp    %rdx,%rcx
    fd58:	4c 0f 42 f9          	cmovb  %rcx,%r15
    fd5c:	4c 01 e6             	add    %r12,%rsi
    fd5f:	4c 89 f7             	mov    %r14,%rdi
    fd62:	4c 89 fa             	mov    %r15,%rdx
    fd65:	e8 c6 35 ff ff       	call   3330 <memcpy@plt>
    fd6a:	43 c6 04 3e 00       	movb   $0x0,(%r14,%r15,1)
    fd6f:	48 8b 43 10          	mov    0x10(%rbx),%rax
    fd73:	4c 29 e0             	sub    %r12,%rax
    fd76:	48 83 c4 08          	add    $0x8,%rsp
    fd7a:	5b                   	pop    %rbx
    fd7b:	41 5c                	pop    %r12
    fd7d:	41 5e                	pop    %r14
    fd7f:	41 5f                	pop    %r15
    fd81:	c3                   	ret
    fd82:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    fd89:	1f 84 00 00 00 00 00 

000000000000fd90 <tp_elem_item>:
    fd90:	55                   	push   %rbp
    fd91:	53                   	push   %rbx
    fd92:	50                   	push   %rax
    fd93:	48 89 f3             	mov    %rsi,%rbx
    fd96:	48 8b 36             	mov    (%rsi),%rsi
    fd99:	31 ed                	xor    %ebp,%ebp
    fd9b:	48 89 e1             	mov    %rsp,%rcx
    fd9e:	31 d2                	xor    %edx,%edx
    fda0:	e8 6b d9 ff ff       	call   d710 <tp_value>
    fda5:	85 c0                	test   %eax,%eax
    fda7:	74 11                	je     fdba <tp_elem_item+0x2a>
    fda9:	48 8b 34 24          	mov    (%rsp),%rsi
    fdad:	48 89 df             	mov    %rbx,%rdi
    fdb0:	e8 cb 06 00 00       	call   10480 <tp_push>
    fdb5:	bd 01 00 00 00       	mov    $0x1,%ebp
    fdba:	89 e8                	mov    %ebp,%eax
    fdbc:	48 83 c4 08          	add    $0x8,%rsp
    fdc0:	5b                   	pop    %rbx
    fdc1:	5d                   	pop    %rbp
    fdc2:	c3                   	ret
    fdc3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    fdca:	84 00 00 00 00 00 

000000000000fdd0 <tp_kv_item>:
    fdd0:	55                   	push   %rbp
    fdd1:	41 56                	push   %r14
    fdd3:	53                   	push   %rbx
    fdd4:	48 83 ec 10          	sub    $0x10,%rsp
    fdd8:	48 89 f3             	mov    %rsi,%rbx
    fddb:	49 89 fe             	mov    %rdi,%r14
    fdde:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
    fde5:	00 
    fde6:	48 8b 36             	mov    (%rsi),%rsi
    fde9:	31 ed                	xor    %ebp,%ebp
    fdeb:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    fdf0:	31 d2                	xor    %edx,%edx
    fdf2:	e8 19 d9 ff ff       	call   d710 <tp_value>
    fdf7:	85 c0                	test   %eax,%eax
    fdf9:	74 26                	je     fe21 <tp_kv_item+0x51>
    fdfb:	83 7b 28 00          	cmpl   $0x0,0x28(%rbx)
    fdff:	74 2b                	je     fe2c <tp_kv_item+0x5c>
    fe01:	45 31 f6             	xor    %r14d,%r14d
    fe04:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    fe09:	48 89 df             	mov    %rbx,%rdi
    fe0c:	e8 6f 06 00 00       	call   10480 <tp_push>
    fe11:	48 89 df             	mov    %rbx,%rdi
    fe14:	4c 89 f6             	mov    %r14,%rsi
    fe17:	e8 64 06 00 00       	call   10480 <tp_push>
    fe1c:	bd 01 00 00 00       	mov    $0x1,%ebp
    fe21:	89 e8                	mov    %ebp,%eax
    fe23:	48 83 c4 10          	add    $0x10,%rsp
    fe27:	5b                   	pop    %rbx
    fe28:	41 5e                	pop    %r14
    fe2a:	5d                   	pop    %rbp
    fe2b:	c3                   	ret
    fe2c:	49 8b 4e 08          	mov    0x8(%r14),%rcx
    fe30:	49 8b 46 10          	mov    0x10(%r14),%rax
    fe34:	48 39 c8             	cmp    %rcx,%rax
    fe37:	73 37                	jae    fe70 <tp_kv_item+0xa0>
    fe39:	49 8b 16             	mov    (%r14),%rdx
    fe3c:	48 be 00 26 00 00 01 	movabs $0x100002600,%rsi
    fe43:	00 00 00 
    fe46:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    fe4d:	00 00 00 
    fe50:	0f b6 3c 02          	movzbl (%rdx,%rax,1),%edi
    fe54:	48 83 ff 20          	cmp    $0x20,%rdi
    fe58:	77 16                	ja     fe70 <tp_kv_item+0xa0>
    fe5a:	48 0f a3 fe          	bt     %rdi,%rsi
    fe5e:	73 10                	jae    fe70 <tp_kv_item+0xa0>
    fe60:	48 ff c0             	inc    %rax
    fe63:	49 89 46 10          	mov    %rax,0x10(%r14)
    fe67:	48 39 c1             	cmp    %rax,%rcx
    fe6a:	75 e4                	jne    fe50 <tp_kv_item+0x80>
    fe6c:	31 ed                	xor    %ebp,%ebp
    fe6e:	eb b1                	jmp    fe21 <tp_kv_item+0x51>
    fe70:	31 ed                	xor    %ebp,%ebp
    fe72:	48 39 c1             	cmp    %rax,%rcx
    fe75:	74 aa                	je     fe21 <tp_kv_item+0x51>
    fe77:	49 8b 0e             	mov    (%r14),%rcx
    fe7a:	80 3c 01 3a          	cmpb   $0x3a,(%rcx,%rax,1)
    fe7e:	75 a1                	jne    fe21 <tp_kv_item+0x51>
    fe80:	48 ff c0             	inc    %rax
    fe83:	49 89 46 10          	mov    %rax,0x10(%r14)
    fe87:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    fe8b:	31 ed                	xor    %ebp,%ebp
    fe8d:	48 89 e1             	mov    %rsp,%rcx
    fe90:	4c 89 f7             	mov    %r14,%rdi
    fe93:	31 d2                	xor    %edx,%edx
    fe95:	e8 76 d8 ff ff       	call   d710 <tp_value>
    fe9a:	85 c0                	test   %eax,%eax
    fe9c:	74 83                	je     fe21 <tp_kv_item+0x51>
    fe9e:	4c 8b 34 24          	mov    (%rsp),%r14
    fea2:	e9 5d ff ff ff       	jmp    fe04 <tp_kv_item+0x34>
    fea7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    feae:	00 00 

000000000000feb0 <fwp_p_map_insert>:
    feb0:	55                   	push   %rbp
    feb1:	41 57                	push   %r15
    feb3:	41 56                	push   %r14
    feb5:	41 55                	push   %r13
    feb7:	41 54                	push   %r12
    feb9:	53                   	push   %rbx
    feba:	48 83 ec 28          	sub    $0x28,%rsp
    febe:	49 89 d7             	mov    %rdx,%r15
    fec1:	49 89 f8             	mov    %rdi,%r8
    fec4:	48 8b 1a             	mov    (%rdx),%rbx
    fec7:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
    fecc:	8b 01                	mov    (%rcx),%eax
    fece:	83 f8 04             	cmp    $0x4,%eax
    fed1:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
    fed6:	72 61                	jb     ff39 <fwp_p_map_insert+0x89>
    fed8:	83 c0 fb             	add    $0xfffffffb,%eax
    fedb:	83 f8 04             	cmp    $0x4,%eax
    fede:	0f 83 b7 00 00 00    	jae    ff9b <fwp_p_map_insert+0xeb>
    fee4:	48 85 db             	test   %rbx,%rbx
    fee7:	0f 84 1d 01 00 00    	je     1000a <fwp_p_map_insert+0x15a>
    feed:	45 31 e4             	xor    %r12d,%r12d
    fef0:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    fef7:	ff ff 1f 
    fefa:	48 89 d9             	mov    %rbx,%rcx
    fefd:	eb 0d                	jmp    ff0c <fwp_p_map_insert+0x5c>
    feff:	90                   	nop
    ff00:	48 89 d1             	mov    %rdx,%rcx
    ff03:	49 39 cc             	cmp    %rcx,%r12
    ff06:	0f 83 04 01 00 00    	jae    10010 <fwp_p_map_insert+0x160>
    ff0c:	4a 8d 34 21          	lea    (%rcx,%r12,1),%rsi
    ff10:	48 89 f2             	mov    %rsi,%rdx
    ff13:	48 d1 ea             	shr    $1,%rdx
    ff16:	48 21 c6             	and    %rax,%rsi
    ff19:	49 8b 74 f7 08       	mov    0x8(%r15,%rsi,8),%rsi
    ff1e:	4c 39 c6             	cmp    %r8,%rsi
    ff21:	41 0f 95 c6          	setne  %r14b
    ff25:	74 6f                	je     ff96 <fwp_p_map_insert+0xe6>
    ff27:	73 d7                	jae    ff00 <fwp_p_map_insert+0x50>
    ff29:	48 ff c2             	inc    %rdx
    ff2c:	49 89 d4             	mov    %rdx,%r12
    ff2f:	49 39 cc             	cmp    %rcx,%r12
    ff32:	72 d8                	jb     ff0c <fwp_p_map_insert+0x5c>
    ff34:	e9 d7 00 00 00       	jmp    10010 <fwp_p_map_insert+0x160>
    ff39:	48 85 db             	test   %rbx,%rbx
    ff3c:	0f 84 c8 00 00 00    	je     1000a <fwp_p_map_insert+0x15a>
    ff42:	45 31 e4             	xor    %r12d,%r12d
    ff45:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    ff4c:	ff ff 1f 
    ff4f:	48 89 d9             	mov    %rbx,%rcx
    ff52:	eb 18                	jmp    ff6c <fwp_p_map_insert+0xbc>
    ff54:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    ff5b:	00 00 00 00 00 
    ff60:	48 89 d1             	mov    %rdx,%rcx
    ff63:	49 39 cc             	cmp    %rcx,%r12
    ff66:	0f 83 a4 00 00 00    	jae    10010 <fwp_p_map_insert+0x160>
    ff6c:	4a 8d 34 21          	lea    (%rcx,%r12,1),%rsi
    ff70:	48 89 f2             	mov    %rsi,%rdx
    ff73:	48 d1 ea             	shr    $1,%rdx
    ff76:	48 21 c6             	and    %rax,%rsi
    ff79:	49 8b 74 f7 08       	mov    0x8(%r15,%rsi,8),%rsi
    ff7e:	4c 39 c6             	cmp    %r8,%rsi
    ff81:	41 0f 95 c6          	setne  %r14b
    ff85:	74 0f                	je     ff96 <fwp_p_map_insert+0xe6>
    ff87:	7d d7                	jge    ff60 <fwp_p_map_insert+0xb0>
    ff89:	48 ff c2             	inc    %rdx
    ff8c:	49 89 d4             	mov    %rdx,%r12
    ff8f:	49 39 cc             	cmp    %rcx,%r12
    ff92:	72 d8                	jb     ff6c <fwp_p_map_insert+0xbc>
    ff94:	eb 7a                	jmp    10010 <fwp_p_map_insert+0x160>
    ff96:	49 89 d4             	mov    %rdx,%r12
    ff99:	eb 75                	jmp    10010 <fwp_p_map_insert+0x160>
    ff9b:	48 85 db             	test   %rbx,%rbx
    ff9e:	74 6a                	je     1000a <fwp_p_map_insert+0x15a>
    ffa0:	45 31 e4             	xor    %r12d,%r12d
    ffa3:	48 89 d8             	mov    %rbx,%rax
    ffa6:	48 89 5c 24 08       	mov    %rbx,0x8(%rsp)
    ffab:	eb 13                	jmp    ffc0 <fwp_p_map_insert+0x110>
    ffad:	0f 1f 00             	nopl   (%rax)
    ffb0:	48 89 d8             	mov    %rbx,%rax
    ffb3:	49 89 e8             	mov    %rbp,%r8
    ffb6:	49 39 c4             	cmp    %rax,%r12
    ffb9:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    ffbe:	73 50                	jae    10010 <fwp_p_map_insert+0x160>
    ffc0:	49 89 c5             	mov    %rax,%r13
    ffc3:	4c 01 e0             	add    %r12,%rax
    ffc6:	48 89 c3             	mov    %rax,%rbx
    ffc9:	48 d1 eb             	shr    $1,%rbx
    ffcc:	48 b9 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rcx
    ffd3:	ff ff 1f 
    ffd6:	48 21 c8             	and    %rcx,%rax
    ffd9:	49 8b 7c c7 08       	mov    0x8(%r15,%rax,8),%rdi
    ffde:	4c 89 c5             	mov    %r8,%rbp
    ffe1:	4c 89 c6             	mov    %r8,%rsi
    ffe4:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    ffe9:	e8 d2 05 00 00       	call   105c0 <fwp_cmp>
    ffee:	85 c0                	test   %eax,%eax
    fff0:	41 0f 95 c6          	setne  %r14b
    fff4:	0f 84 5b 01 00 00    	je     10155 <fwp_p_map_insert+0x2a5>
    fffa:	79 b4                	jns    ffb0 <fwp_p_map_insert+0x100>
    fffc:	48 ff c3             	inc    %rbx
    ffff:	49 89 dc             	mov    %rbx,%r12
   10002:	49 89 e8             	mov    %rbp,%r8
   10005:	4c 89 e8             	mov    %r13,%rax
   10008:	eb ac                	jmp    ffb6 <fwp_p_map_insert+0x106>
   1000a:	41 b6 01             	mov    $0x1,%r14b
   1000d:	45 31 e4             	xor    %r12d,%r12d
   10010:	41 0f b6 ee          	movzbl %r14b,%ebp
   10014:	48 01 dd             	add    %rbx,%rbp
   10017:	48 89 e9             	mov    %rbp,%rcx
   1001a:	48 c1 e1 04          	shl    $0x4,%rcx
   1001e:	48 8d 79 08          	lea    0x8(%rcx),%rdi
   10022:	48 ff 05 7f be 00 00 	incq   0xbe7f(%rip)        # 1bea8 <measured_calls>
   10029:	48 01 3d 80 be 00 00 	add    %rdi,0xbe80(%rip)        # 1beb0 <measured_bytes>
   10030:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
   10037:	4c 89 44 24 18       	mov    %r8,0x18(%rsp)
   1003c:	77 62                	ja     100a0 <fwp_p_map_insert+0x1f0>
   1003e:	48 83 c1 17          	add    $0x17,%rcx
   10042:	48 c1 e9 04          	shr    $0x4,%rcx
   10046:	48 8d 05 3b a2 00 00 	lea    0xa23b(%rip),%rax        # 1a288 <fwp_gc>
   1004d:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
   10054:	00 
   10055:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
   1005c:	48 29 15 25 a2 00 00 	sub    %rdx,0xa225(%rip)        # 1a288 <fwp_gc>
   10063:	78 3b                	js     100a0 <fwp_p_map_insert+0x1f0>
   10065:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
   10069:	48 8d 34 c8          	lea    (%rax,%rcx,8),%rsi
   1006d:	48 81 c6 88 07 00 00 	add    $0x788,%rsi
   10074:	4c 8b 2e             	mov    (%rsi),%r13
   10077:	4d 85 ed             	test   %r13,%r13
   1007a:	74 0c                	je     10088 <fwp_p_map_insert+0x1d8>
   1007c:	49 8b 45 00          	mov    0x0(%r13),%rax
   10080:	48 f7 d0             	not    %rax
   10083:	48 89 06             	mov    %rax,(%rsi)
   10086:	eb 38                	jmp    100c0 <fwp_p_map_insert+0x210>
   10088:	4c 8b ac c8 90 07 00 	mov    0x790(%rax,%rcx,8),%r13
   1008f:	00 
   10090:	48 8b b4 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%rsi
   10097:	00 
   10098:	4c 29 ee             	sub    %r13,%rsi
   1009b:	48 39 d6             	cmp    %rdx,%rsi
   1009e:	73 0f                	jae    100af <fwp_p_map_insert+0x1ff>
   100a0:	be 02 00 00 00       	mov    $0x2,%esi
   100a5:	e8 d6 81 ff ff       	call   8280 <fwp_gc_alloc_slow>
   100aa:	49 89 c5             	mov    %rax,%r13
   100ad:	eb 1b                	jmp    100ca <fwp_p_map_insert+0x21a>
   100af:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
   100b3:	48 05 90 07 00 00    	add    $0x790,%rax
   100b9:	4a 8d 0c 2a          	lea    (%rdx,%r13,1),%rcx
   100bd:	48 89 08             	mov    %rcx,(%rax)
   100c0:	4c 89 ef             	mov    %r13,%rdi
   100c3:	31 f6                	xor    %esi,%esi
   100c5:	e8 46 31 ff ff       	call   3210 <memset@plt>
   100ca:	49 89 6d 00          	mov    %rbp,0x0(%r13)
   100ce:	49 8d 6d 08          	lea    0x8(%r13),%rbp
   100d2:	49 83 c7 08          	add    $0x8,%r15
   100d6:	45 84 f6             	test   %r14b,%r14b
   100d9:	74 48                	je     10123 <fwp_p_map_insert+0x273>
   100db:	4d 89 e6             	mov    %r12,%r14
   100de:	49 c1 e6 04          	shl    $0x4,%r14
   100e2:	48 89 ef             	mov    %rbp,%rdi
   100e5:	4c 89 fe             	mov    %r15,%rsi
   100e8:	4c 89 f2             	mov    %r14,%rdx
   100eb:	e8 40 32 ff ff       	call   3330 <memcpy@plt>
   100f0:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
   100f5:	4b 89 44 35 08       	mov    %rax,0x8(%r13,%r14,1)
   100fa:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
   100ff:	4b 89 44 35 10       	mov    %rax,0x10(%r13,%r14,1)
   10104:	49 8d 3c 2e          	lea    (%r14,%rbp,1),%rdi
   10108:	48 83 c7 10          	add    $0x10,%rdi
   1010c:	4d 01 fe             	add    %r15,%r14
   1010f:	4c 29 e3             	sub    %r12,%rbx
   10112:	48 c1 e3 04          	shl    $0x4,%rbx
   10116:	4c 89 f6             	mov    %r14,%rsi
   10119:	48 89 da             	mov    %rbx,%rdx
   1011c:	e8 0f 32 ff ff       	call   3330 <memcpy@plt>
   10121:	eb 20                	jmp    10143 <fwp_p_map_insert+0x293>
   10123:	48 c1 e3 04          	shl    $0x4,%rbx
   10127:	48 89 ef             	mov    %rbp,%rdi
   1012a:	4c 89 fe             	mov    %r15,%rsi
   1012d:	48 89 da             	mov    %rbx,%rdx
   10130:	e8 fb 31 ff ff       	call   3330 <memcpy@plt>
   10135:	49 c1 e4 04          	shl    $0x4,%r12
   10139:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
   1013e:	4b 89 44 25 10       	mov    %rax,0x10(%r13,%r12,1)
   10143:	4c 89 e8             	mov    %r13,%rax
   10146:	48 83 c4 28          	add    $0x28,%rsp
   1014a:	5b                   	pop    %rbx
   1014b:	41 5c                	pop    %r12
   1014d:	41 5d                	pop    %r13
   1014f:	41 5e                	pop    %r14
   10151:	41 5f                	pop    %r15
   10153:	5d                   	pop    %rbp
   10154:	c3                   	ret
   10155:	49 89 dc             	mov    %rbx,%r12
   10158:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
   1015d:	49 89 e8             	mov    %rbp,%r8
   10160:	e9 ab fe ff ff       	jmp    10010 <fwp_p_map_insert+0x160>
   10165:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   1016c:	00 00 00 00 

0000000000010170 <fwp_record>:
   10170:	85 ff                	test   %edi,%edi
   10172:	0f 84 aa 00 00 00    	je     10222 <fwp_record+0xb2>
   10178:	55                   	push   %rbp
   10179:	41 56                	push   %r14
   1017b:	53                   	push   %rbx
   1017c:	48 89 f3             	mov    %rsi,%rbx
   1017f:	41 89 fe             	mov    %edi,%r14d
   10182:	4a 8d 04 f5 08 00 00 	lea    0x8(,%r14,8),%rax
   10189:	00 
   1018a:	89 fd                	mov    %edi,%ebp
   1018c:	48 89 c7             	mov    %rax,%rdi
   1018f:	e8 0c a6 ff ff       	call   a7a0 <fwp_alloc_init>
   10194:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   1019a:	89 68 04             	mov    %ebp,0x4(%rax)
   1019d:	83 fd 08             	cmp    $0x8,%ebp
   101a0:	72 10                	jb     101b2 <fwp_record+0x42>
   101a2:	48 89 c1             	mov    %rax,%rcx
   101a5:	48 29 d9             	sub    %rbx,%rcx
   101a8:	48 83 c1 08          	add    $0x8,%rcx
   101ac:	48 83 f9 20          	cmp    $0x20,%rcx
   101b0:	73 73                	jae    10225 <fwp_record+0xb5>
   101b2:	31 c9                	xor    %ecx,%ecx
   101b4:	4c 89 f6             	mov    %r14,%rsi
   101b7:	48 89 ca             	mov    %rcx,%rdx
   101ba:	48 83 e6 03          	and    $0x3,%rsi
   101be:	74 21                	je     101e1 <fwp_record+0x71>
   101c0:	48 89 ca             	mov    %rcx,%rdx
   101c3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   101ca:	84 00 00 00 00 00 
   101d0:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
   101d4:	48 89 7c d0 08       	mov    %rdi,0x8(%rax,%rdx,8)
   101d9:	48 ff c2             	inc    %rdx
   101dc:	48 ff ce             	dec    %rsi
   101df:	75 ef                	jne    101d0 <fwp_record+0x60>
   101e1:	4c 29 f1             	sub    %r14,%rcx
   101e4:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
   101e8:	77 7b                	ja     10265 <fwp_record+0xf5>
   101ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   101f0:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
   101f4:	48 89 4c d0 08       	mov    %rcx,0x8(%rax,%rdx,8)
   101f9:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
   101fe:	48 89 4c d0 10       	mov    %rcx,0x10(%rax,%rdx,8)
   10203:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
   10208:	48 89 4c d0 18       	mov    %rcx,0x18(%rax,%rdx,8)
   1020d:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
   10212:	48 89 4c d0 20       	mov    %rcx,0x20(%rax,%rdx,8)
   10217:	48 83 c2 04          	add    $0x4,%rdx
   1021b:	49 39 d6             	cmp    %rdx,%r14
   1021e:	75 d0                	jne    101f0 <fwp_record+0x80>
   10220:	eb 43                	jmp    10265 <fwp_record+0xf5>
   10222:	31 c0                	xor    %eax,%eax
   10224:	c3                   	ret
   10225:	44 89 f1             	mov    %r14d,%ecx
   10228:	83 e1 fc             	and    $0xfffffffc,%ecx
   1022b:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
   10232:	00 
   10233:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
   10237:	31 f6                	xor    %esi,%esi
   10239:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   10240:	0f 10 04 33          	movups (%rbx,%rsi,1),%xmm0
   10244:	0f 10 4c 33 10       	movups 0x10(%rbx,%rsi,1),%xmm1
   10249:	0f 11 44 30 08       	movups %xmm0,0x8(%rax,%rsi,1)
   1024e:	0f 11 4c 30 18       	movups %xmm1,0x18(%rax,%rsi,1)
   10253:	48 83 c6 20          	add    $0x20,%rsi
   10257:	48 39 f2             	cmp    %rsi,%rdx
   1025a:	75 e4                	jne    10240 <fwp_record+0xd0>
   1025c:	4c 39 f1             	cmp    %r14,%rcx
   1025f:	0f 85 4f ff ff ff    	jne    101b4 <fwp_record+0x44>
   10265:	5b                   	pop    %rbx
   10266:	41 5e                	pop    %r14
   10268:	5d                   	pop    %rbp
   10269:	c3                   	ret
   1026a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000010270 <fwp_box_u128>:
   10270:	41 56                	push   %r14
   10272:	53                   	push   %rbx
   10273:	50                   	push   %rax
   10274:	48 ff 05 2d bc 00 00 	incq   0xbc2d(%rip)        # 1bea8 <measured_calls>
   1027b:	48 83 05 2d bc 00 00 	addq   $0x10,0xbc2d(%rip)        # 1beb0 <measured_bytes>
   10282:	10 
   10283:	48 8d 0d fe 9f 00 00 	lea    0x9ffe(%rip),%rcx        # 1a288 <fwp_gc>
   1028a:	0f b6 05 e0 ab 00 00 	movzbl 0xabe0(%rip),%eax        # 1ae71 <fwp_gc+0xbe9>
   10291:	8b 94 81 48 0b 00 00 	mov    0xb48(%rcx,%rax,4),%edx
   10298:	48 29 15 e9 9f 00 00 	sub    %rdx,0x9fe9(%rip)        # 1a288 <fwp_gc>
   1029f:	78 3a                	js     102db <fwp_box_u128+0x6b>
   102a1:	4c 8d 04 40          	lea    (%rax,%rax,2),%r8
   102a5:	4e 8d 0c c1          	lea    (%rcx,%r8,8),%r9
   102a9:	49 81 c1 c8 03 00 00 	add    $0x3c8,%r9
   102b0:	49 8b 01             	mov    (%r9),%rax
   102b3:	48 85 c0             	test   %rax,%rax
   102b6:	74 0b                	je     102c3 <fwp_box_u128+0x53>
   102b8:	48 8b 08             	mov    (%rax),%rcx
   102bb:	48 f7 d1             	not    %rcx
   102be:	49 89 09             	mov    %rcx,(%r9)
   102c1:	eb 46                	jmp    10309 <fwp_box_u128+0x99>
   102c3:	4a 8b 84 c1 d0 03 00 	mov    0x3d0(%rcx,%r8,8),%rax
   102ca:	00 
   102cb:	4e 8b 8c c1 d8 03 00 	mov    0x3d8(%rcx,%r8,8),%r9
   102d2:	00 
   102d3:	49 29 c1             	sub    %rax,%r9
   102d6:	49 39 d1             	cmp    %rdx,%r9
   102d9:	73 1d                	jae    102f8 <fwp_box_u128+0x88>
   102db:	48 89 fb             	mov    %rdi,%rbx
   102de:	bf 10 00 00 00       	mov    $0x10,%edi
   102e3:	49 89 f6             	mov    %rsi,%r14
   102e6:	be 01 00 00 00       	mov    $0x1,%esi
   102eb:	e8 90 7f ff ff       	call   8280 <fwp_gc_alloc_slow>
   102f0:	4c 89 f6             	mov    %r14,%rsi
   102f3:	48 89 df             	mov    %rbx,%rdi
   102f6:	eb 17                	jmp    1030f <fwp_box_u128+0x9f>
   102f8:	4a 8d 0c c1          	lea    (%rcx,%r8,8),%rcx
   102fc:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
   10303:	48 01 c2             	add    %rax,%rdx
   10306:	48 89 11             	mov    %rdx,(%rcx)
   10309:	0f 57 c0             	xorps  %xmm0,%xmm0
   1030c:	0f 11 00             	movups %xmm0,(%rax)
   1030f:	48 89 70 08          	mov    %rsi,0x8(%rax)
   10313:	48 89 38             	mov    %rdi,(%rax)
   10316:	48 83 c4 08          	add    $0x8,%rsp
   1031a:	5b                   	pop    %rbx
   1031b:	41 5e                	pop    %r14
   1031d:	c3                   	ret
   1031e:	66 90                	xchg   %ax,%ax

0000000000010320 <fwp_box_i128>:
   10320:	41 56                	push   %r14
   10322:	53                   	push   %rbx
   10323:	50                   	push   %rax
   10324:	48 ff 05 7d bb 00 00 	incq   0xbb7d(%rip)        # 1bea8 <measured_calls>
   1032b:	48 83 05 7d bb 00 00 	addq   $0x10,0xbb7d(%rip)        # 1beb0 <measured_bytes>
   10332:	10 
   10333:	48 8d 0d 4e 9f 00 00 	lea    0x9f4e(%rip),%rcx        # 1a288 <fwp_gc>
   1033a:	0f b6 05 30 ab 00 00 	movzbl 0xab30(%rip),%eax        # 1ae71 <fwp_gc+0xbe9>
   10341:	8b 94 81 48 0b 00 00 	mov    0xb48(%rcx,%rax,4),%edx
   10348:	48 29 15 39 9f 00 00 	sub    %rdx,0x9f39(%rip)        # 1a288 <fwp_gc>
   1034f:	78 3a                	js     1038b <fwp_box_i128+0x6b>
   10351:	4c 8d 04 40          	lea    (%rax,%rax,2),%r8
   10355:	4e 8d 0c c1          	lea    (%rcx,%r8,8),%r9
   10359:	49 81 c1 c8 03 00 00 	add    $0x3c8,%r9
   10360:	49 8b 01             	mov    (%r9),%rax
   10363:	48 85 c0             	test   %rax,%rax
   10366:	74 0b                	je     10373 <fwp_box_i128+0x53>
   10368:	48 8b 08             	mov    (%rax),%rcx
   1036b:	48 f7 d1             	not    %rcx
   1036e:	49 89 09             	mov    %rcx,(%r9)
   10371:	eb 46                	jmp    103b9 <fwp_box_i128+0x99>
   10373:	4a 8b 84 c1 d0 03 00 	mov    0x3d0(%rcx,%r8,8),%rax
   1037a:	00 
   1037b:	4e 8b 8c c1 d8 03 00 	mov    0x3d8(%rcx,%r8,8),%r9
   10382:	00 
   10383:	49 29 c1             	sub    %rax,%r9
   10386:	49 39 d1             	cmp    %rdx,%r9
   10389:	73 1d                	jae    103a8 <fwp_box_i128+0x88>
   1038b:	48 89 fb             	mov    %rdi,%rbx
   1038e:	bf 10 00 00 00       	mov    $0x10,%edi
   10393:	49 89 f6             	mov    %rsi,%r14
   10396:	be 01 00 00 00       	mov    $0x1,%esi
   1039b:	e8 e0 7e ff ff       	call   8280 <fwp_gc_alloc_slow>
   103a0:	4c 89 f6             	mov    %r14,%rsi
   103a3:	48 89 df             	mov    %rbx,%rdi
   103a6:	eb 17                	jmp    103bf <fwp_box_i128+0x9f>
   103a8:	4a 8d 0c c1          	lea    (%rcx,%r8,8),%rcx
   103ac:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
   103b3:	48 01 c2             	add    %rax,%rdx
   103b6:	48 89 11             	mov    %rdx,(%rcx)
   103b9:	0f 57 c0             	xorps  %xmm0,%xmm0
   103bc:	0f 11 00             	movups %xmm0,(%rax)
   103bf:	48 89 70 08          	mov    %rsi,0x8(%rax)
   103c3:	48 89 38             	mov    %rdi,(%rax)
   103c6:	48 83 c4 08          	add    $0x8,%rsp
   103ca:	5b                   	pop    %rbx
   103cb:	41 5e                	pop    %r14
   103cd:	c3                   	ret
   103ce:	66 90                	xchg   %ax,%ax

00000000000103d0 <fwp_utf8_put>:
   103d0:	50                   	push   %rax
   103d1:	83 fe 7f             	cmp    $0x7f,%esi
   103d4:	77 0f                	ja     103e5 <fwp_utf8_put+0x15>
   103d6:	40 88 74 24 04       	mov    %sil,0x4(%rsp)
   103db:	ba 01 00 00 00       	mov    $0x1,%edx
   103e0:	e9 8e 00 00 00       	jmp    10473 <fwp_utf8_put+0xa3>
   103e5:	89 f0                	mov    %esi,%eax
   103e7:	81 fe ff 07 00 00    	cmp    $0x7ff,%esi
   103ed:	77 1d                	ja     1040c <fwp_utf8_put+0x3c>
   103ef:	c1 e8 06             	shr    $0x6,%eax
   103f2:	0c c0                	or     $0xc0,%al
   103f4:	88 44 24 04          	mov    %al,0x4(%rsp)
   103f8:	40 80 e6 3f          	and    $0x3f,%sil
   103fc:	40 80 ce 80          	or     $0x80,%sil
   10400:	40 88 74 24 05       	mov    %sil,0x5(%rsp)
   10405:	ba 02 00 00 00       	mov    $0x2,%edx
   1040a:	eb 67                	jmp    10473 <fwp_utf8_put+0xa3>
   1040c:	81 fe ff ff 00 00    	cmp    $0xffff,%esi
   10412:	77 2a                	ja     1043e <fwp_utf8_put+0x6e>
   10414:	c1 e8 0c             	shr    $0xc,%eax
   10417:	0c e0                	or     $0xe0,%al
   10419:	88 44 24 04          	mov    %al,0x4(%rsp)
   1041d:	89 f0                	mov    %esi,%eax
   1041f:	c1 e8 06             	shr    $0x6,%eax
   10422:	24 3f                	and    $0x3f,%al
   10424:	0c 80                	or     $0x80,%al
   10426:	88 44 24 05          	mov    %al,0x5(%rsp)
   1042a:	40 80 e6 3f          	and    $0x3f,%sil
   1042e:	40 80 ce 80          	or     $0x80,%sil
   10432:	40 88 74 24 06       	mov    %sil,0x6(%rsp)
   10437:	ba 03 00 00 00       	mov    $0x3,%edx
   1043c:	eb 35                	jmp    10473 <fwp_utf8_put+0xa3>
   1043e:	c1 e8 12             	shr    $0x12,%eax
   10441:	0c f0                	or     $0xf0,%al
   10443:	88 44 24 04          	mov    %al,0x4(%rsp)
   10447:	89 f0                	mov    %esi,%eax
   10449:	c1 e8 0c             	shr    $0xc,%eax
   1044c:	24 3f                	and    $0x3f,%al
   1044e:	0c 80                	or     $0x80,%al
   10450:	88 44 24 05          	mov    %al,0x5(%rsp)
   10454:	89 f0                	mov    %esi,%eax
   10456:	c1 e8 06             	shr    $0x6,%eax
   10459:	24 3f                	and    $0x3f,%al
   1045b:	0c 80                	or     $0x80,%al
   1045d:	88 44 24 06          	mov    %al,0x6(%rsp)
   10461:	40 80 e6 3f          	and    $0x3f,%sil
   10465:	40 80 ce 80          	or     $0x80,%sil
   10469:	40 88 74 24 07       	mov    %sil,0x7(%rsp)
   1046e:	ba 04 00 00 00       	mov    $0x4,%edx
   10473:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
   10478:	e8 53 cd ff ff       	call   d1d0 <buf_put>
   1047d:	58                   	pop    %rax
   1047e:	c3                   	ret
   1047f:	90                   	nop

0000000000010480 <tp_push>:
   10480:	55                   	push   %rbp
   10481:	41 57                	push   %r15
   10483:	41 56                	push   %r14
   10485:	41 55                	push   %r13
   10487:	41 54                	push   %r12
   10489:	53                   	push   %rbx
   1048a:	50                   	push   %rax
   1048b:	48 89 f3             	mov    %rsi,%rbx
   1048e:	49 89 fe             	mov    %rdi,%r14
   10491:	4c 8b 7f 18          	mov    0x18(%rdi),%r15
   10495:	4c 3b 7f 20          	cmp    0x20(%rdi),%r15
   10499:	75 7d                	jne    10518 <tp_push+0x98>
   1049b:	4b 8d 04 3f          	lea    (%r15,%r15,1),%rax
   1049f:	4d 85 ff             	test   %r15,%r15
   104a2:	41 bd 08 00 00 00    	mov    $0x8,%r13d
   104a8:	4c 0f 45 e8          	cmovne %rax,%r13
   104ac:	4d 89 6e 20          	mov    %r13,0x20(%r14)
   104b0:	4d 8b 66 10          	mov    0x10(%r14),%r12
   104b4:	49 c1 e5 03          	shl    $0x3,%r13
   104b8:	48 ff 05 e9 b9 00 00 	incq   0xb9e9(%rip)        # 1bea8 <measured_calls>
   104bf:	4c 01 2d ea b9 00 00 	add    %r13,0xb9ea(%rip)        # 1beb0 <measured_bytes>
   104c6:	49 81 fd 00 40 00 00 	cmp    $0x4000,%r13
   104cd:	77 67                	ja     10536 <tp_push+0xb6>
   104cf:	4c 89 e9             	mov    %r13,%rcx
   104d2:	48 c1 e9 04          	shr    $0x4,%rcx
   104d6:	48 8d 05 ab 9d 00 00 	lea    0x9dab(%rip),%rax        # 1a288 <fwp_gc>
   104dd:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
   104e4:	00 
   104e5:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
   104ec:	48 29 15 95 9d 00 00 	sub    %rdx,0x9d95(%rip)        # 1a288 <fwp_gc>
   104f3:	78 41                	js     10536 <tp_push+0xb6>
   104f5:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
   104f9:	48 8d 34 c8          	lea    (%rax,%rcx,8),%rsi
   104fd:	48 81 c6 88 07 00 00 	add    $0x788,%rsi
   10504:	48 8b 2e             	mov    (%rsi),%rbp
   10507:	48 85 ed             	test   %rbp,%rbp
   1050a:	74 12                	je     1051e <tp_push+0x9e>
   1050c:	48 8b 45 00          	mov    0x0(%rbp),%rax
   10510:	48 f7 d0             	not    %rax
   10513:	48 89 06             	mov    %rax,(%rsi)
   10516:	eb 46                	jmp    1055e <tp_push+0xde>
   10518:	49 8b 6e 10          	mov    0x10(%r14),%rbp
   1051c:	eb 78                	jmp    10596 <tp_push+0x116>
   1051e:	48 8b ac c8 90 07 00 	mov    0x790(%rax,%rcx,8),%rbp
   10525:	00 
   10526:	48 8b b4 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%rsi
   1052d:	00 
   1052e:	48 29 ee             	sub    %rbp,%rsi
   10531:	48 39 d6             	cmp    %rdx,%rsi
   10534:	73 17                	jae    1054d <tp_push+0xcd>
   10536:	4c 89 ef             	mov    %r13,%rdi
   10539:	be 02 00 00 00       	mov    $0x2,%esi
   1053e:	e8 3d 7d ff ff       	call   8280 <fwp_gc_alloc_slow>
   10543:	48 89 c5             	mov    %rax,%rbp
   10546:	4d 85 e4             	test   %r12,%r12
   10549:	75 22                	jne    1056d <tp_push+0xed>
   1054b:	eb 41                	jmp    1058e <tp_push+0x10e>
   1054d:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
   10551:	48 05 90 07 00 00    	add    $0x790,%rax
   10557:	48 8d 0c 2a          	lea    (%rdx,%rbp,1),%rcx
   1055b:	48 89 08             	mov    %rcx,(%rax)
   1055e:	48 89 ef             	mov    %rbp,%rdi
   10561:	31 f6                	xor    %esi,%esi
   10563:	e8 a8 2c ff ff       	call   3210 <memset@plt>
   10568:	4d 85 e4             	test   %r12,%r12
   1056b:	74 21                	je     1058e <tp_push+0x10e>
   1056d:	49 c1 e7 03          	shl    $0x3,%r15
   10571:	4d 39 ef             	cmp    %r13,%r15
   10574:	4d 0f 43 fd          	cmovae %r13,%r15
   10578:	48 89 ef             	mov    %rbp,%rdi
   1057b:	4c 89 e6             	mov    %r12,%rsi
   1057e:	4c 89 fa             	mov    %r15,%rdx
   10581:	e8 aa 2d ff ff       	call   3330 <memcpy@plt>
   10586:	4c 89 e7             	mov    %r12,%rdi
   10589:	e8 52 a5 ff ff       	call   aae0 <fwp_mem_free>
   1058e:	49 89 6e 10          	mov    %rbp,0x10(%r14)
   10592:	4d 8b 7e 18          	mov    0x18(%r14),%r15
   10596:	49 8d 47 01          	lea    0x1(%r15),%rax
   1059a:	49 89 46 18          	mov    %rax,0x18(%r14)
   1059e:	4a 89 5c fd 00       	mov    %rbx,0x0(%rbp,%r15,8)
   105a3:	48 83 c4 08          	add    $0x8,%rsp
   105a7:	5b                   	pop    %rbx
   105a8:	41 5c                	pop    %r12
   105aa:	41 5d                	pop    %r13
   105ac:	41 5e                	pop    %r14
   105ae:	41 5f                	pop    %r15
   105b0:	5d                   	pop    %rbp
   105b1:	c3                   	ret
   105b2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   105b9:	1f 84 00 00 00 00 00 

00000000000105c0 <fwp_cmp>:
   105c0:	55                   	push   %rbp
   105c1:	41 57                	push   %r15
   105c3:	41 56                	push   %r14
   105c5:	41 55                	push   %r13
   105c7:	41 54                	push   %r12
   105c9:	53                   	push   %rbx
   105ca:	48 83 ec 28          	sub    $0x28,%rsp
   105ce:	48 89 f3             	mov    %rsi,%rbx
   105d1:	49 89 fe             	mov    %rdi,%r14
   105d4:	44 8b 2a             	mov    (%rdx),%r13d
   105d7:	49 83 fd 15          	cmp    $0x15,%r13
   105db:	77 25                	ja     10602 <fwp_cmp+0x42>
   105dd:	49 89 d7             	mov    %rdx,%r15
   105e0:	48 8d 05 b9 4e 00 00 	lea    0x4eb9(%rip),%rax        # 154a0 <_IO_stdin_used+0x4a0>
   105e7:	4a 63 0c a8          	movslq (%rax,%r13,4),%rcx
   105eb:	48 01 c1             	add    %rax,%rcx
   105ee:	ff e1                	jmp    *%rcx
   105f0:	31 c9                	xor    %ecx,%ecx
   105f2:	49 39 de             	cmp    %rbx,%r14
   105f5:	0f 9f c1             	setg   %cl
   105f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   105fd:	0f 4d c1             	cmovge %ecx,%eax
   10600:	eb 10                	jmp    10612 <fwp_cmp+0x52>
   10602:	31 c9                	xor    %ecx,%ecx
   10604:	49 39 de             	cmp    %rbx,%r14
   10607:	0f 97 c1             	seta   %cl
   1060a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   1060f:	0f 43 c1             	cmovae %ecx,%eax
   10612:	48 83 c4 28          	add    $0x28,%rsp
   10616:	5b                   	pop    %rbx
   10617:	41 5c                	pop    %r12
   10619:	41 5d                	pop    %r13
   1061b:	41 5e                	pop    %r14
   1061d:	41 5f                	pop    %r15
   1061f:	5d                   	pop    %rbp
   10620:	c3                   	ret
   10621:	4d 8b 3e             	mov    (%r14),%r15
   10624:	4c 8b 23             	mov    (%rbx),%r12
   10627:	49 83 c6 08          	add    $0x8,%r14
   1062b:	48 83 c3 08          	add    $0x8,%rbx
   1062f:	4d 39 e7             	cmp    %r12,%r15
   10632:	4c 89 e2             	mov    %r12,%rdx
   10635:	49 0f 42 d7          	cmovb  %r15,%rdx
   10639:	4c 89 f7             	mov    %r14,%rdi
   1063c:	48 89 de             	mov    %rbx,%rsi
   1063f:	e8 2c 2c ff ff       	call   3270 <memcmp@plt>
   10644:	85 c0                	test   %eax,%eax
   10646:	0f 84 bb 03 00 00    	je     10a07 <fwp_cmp+0x447>
   1064c:	c1 f8 1f             	sar    $0x1f,%eax
   1064f:	83 c8 01             	or     $0x1,%eax
   10652:	eb be                	jmp    10612 <fwp_cmp+0x52>
   10654:	49 8b 06             	mov    (%r14),%rax
   10657:	48 8b 2b             	mov    (%rbx),%rbp
   1065a:	48 39 e8             	cmp    %rbp,%rax
   1065d:	48 89 2c 24          	mov    %rbp,(%rsp)
   10661:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
   10666:	48 0f 42 e8          	cmovb  %rax,%rbp
   1066a:	48 85 ed             	test   %rbp,%rbp
   1066d:	74 56                	je     106c5 <fwp_cmp+0x105>
   1066f:	49 8b 47 38          	mov    0x38(%r15),%rax
   10673:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
   10678:	41 bc 10 00 00 00    	mov    $0x10,%r12d
   1067e:	eb 09                	jmp    10689 <fwp_cmp+0xc9>
   10680:	49 83 c4 10          	add    $0x10,%r12
   10684:	48 ff cd             	dec    %rbp
   10687:	74 3c                	je     106c5 <fwp_cmp+0x105>
   10689:	4b 8b 7c 26 f8       	mov    -0x8(%r14,%r12,1),%rdi
   1068e:	4a 8b 74 23 f8       	mov    -0x8(%rbx,%r12,1),%rsi
   10693:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
   10698:	e8 23 ff ff ff       	call   105c0 <fwp_cmp>
   1069d:	85 c0                	test   %eax,%eax
   1069f:	0f 85 6d ff ff ff    	jne    10612 <fwp_cmp+0x52>
   106a5:	41 83 fd 12          	cmp    $0x12,%r13d
   106a9:	75 d5                	jne    10680 <fwp_cmp+0xc0>
   106ab:	4b 8b 3c 26          	mov    (%r14,%r12,1),%rdi
   106af:	4a 8b 34 23          	mov    (%rbx,%r12,1),%rsi
   106b3:	49 8b 57 40          	mov    0x40(%r15),%rdx
   106b7:	e8 04 ff ff ff       	call   105c0 <fwp_cmp>
   106bc:	85 c0                	test   %eax,%eax
   106be:	74 c0                	je     10680 <fwp_cmp+0xc0>
   106c0:	e9 4d ff ff ff       	jmp    10612 <fwp_cmp+0x52>
   106c5:	31 c9                	xor    %ecx,%ecx
   106c7:	48 8b 04 24          	mov    (%rsp),%rax
   106cb:	48 39 44 24 08       	cmp    %rax,0x8(%rsp)
   106d0:	e9 32 ff ff ff       	jmp    10607 <fwp_cmp+0x47>
   106d5:	49 8b 16             	mov    (%r14),%rdx
   106d8:	49 8b 4e 08          	mov    0x8(%r14),%rcx
   106dc:	48 8b 3b             	mov    (%rbx),%rdi
   106df:	48 8b 73 08          	mov    0x8(%rbx),%rsi
   106e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   106e8:	48 39 fa             	cmp    %rdi,%rdx
   106eb:	49 89 c8             	mov    %rcx,%r8
   106ee:	49 19 f0             	sbb    %rsi,%r8
   106f1:	0f 82 1b ff ff ff    	jb     10612 <fwp_cmp+0x52>
   106f7:	48 39 d7             	cmp    %rdx,%rdi
   106fa:	48 19 ce             	sbb    %rcx,%rsi
   106fd:	0f 92 c0             	setb   %al
   10700:	0f b6 c0             	movzbl %al,%eax
   10703:	e9 0a ff ff ff       	jmp    10612 <fwp_cmp+0x52>
   10708:	44 89 f1             	mov    %r14d,%ecx
   1070b:	c1 f9 1f             	sar    $0x1f,%ecx
   1070e:	d1 e9                	shr    $1,%ecx
   10710:	44 31 f1             	xor    %r14d,%ecx
   10713:	89 da                	mov    %ebx,%edx
   10715:	c1 fa 1f             	sar    $0x1f,%edx
   10718:	d1 ea                	shr    $1,%edx
   1071a:	31 da                	xor    %ebx,%edx
   1071c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   10721:	39 d1                	cmp    %edx,%ecx
   10723:	0f 8c e9 fe ff ff    	jl     10612 <fwp_cmp+0x52>
   10729:	eb 28                	jmp    10753 <fwp_cmp+0x193>
   1072b:	4c 89 f1             	mov    %r14,%rcx
   1072e:	48 c1 f9 3f          	sar    $0x3f,%rcx
   10732:	48 d1 e9             	shr    $1,%rcx
   10735:	4c 31 f1             	xor    %r14,%rcx
   10738:	48 89 da             	mov    %rbx,%rdx
   1073b:	48 c1 fa 3f          	sar    $0x3f,%rdx
   1073f:	48 d1 ea             	shr    $1,%rdx
   10742:	48 31 da             	xor    %rbx,%rdx
   10745:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   1074a:	48 39 d1             	cmp    %rdx,%rcx
   1074d:	0f 8c bf fe ff ff    	jl     10612 <fwp_cmp+0x52>
   10753:	0f 9f c0             	setg   %al
   10756:	0f b6 c0             	movzbl %al,%eax
   10759:	e9 b4 fe ff ff       	jmp    10612 <fwp_cmp+0x52>
   1075e:	49 8b 16             	mov    (%r14),%rdx
   10761:	49 8b 4e 08          	mov    0x8(%r14),%rcx
   10765:	48 8b 3b             	mov    (%rbx),%rdi
   10768:	48 8b 73 08          	mov    0x8(%rbx),%rsi
   1076c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   10771:	48 39 fa             	cmp    %rdi,%rdx
   10774:	49 89 c8             	mov    %rcx,%r8
   10777:	49 19 f0             	sbb    %rsi,%r8
   1077a:	0f 8c 92 fe ff ff    	jl     10612 <fwp_cmp+0x52>
   10780:	48 39 d7             	cmp    %rdx,%rdi
   10783:	48 19 ce             	sbb    %rcx,%rsi
   10786:	0f 9c c0             	setl   %al
   10789:	0f b6 c0             	movzbl %al,%eax
   1078c:	e9 81 fe ff ff       	jmp    10612 <fwp_cmp+0x52>
   10791:	4d 85 f6             	test   %r14,%r14
   10794:	0f 94 c0             	sete   %al
   10797:	74 44                	je     107dd <fwp_cmp+0x21d>
   10799:	48 85 db             	test   %rbx,%rbx
   1079c:	74 3f                	je     107dd <fwp_cmp+0x21d>
   1079e:	4d 8b 7f 38          	mov    0x38(%r15),%r15
   107a2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   107a9:	1f 84 00 00 00 00 00 
   107b0:	49 8b 7e 08          	mov    0x8(%r14),%rdi
   107b4:	48 8b 73 08          	mov    0x8(%rbx),%rsi
   107b8:	4c 89 fa             	mov    %r15,%rdx
   107bb:	e8 00 fe ff ff       	call   105c0 <fwp_cmp>
   107c0:	85 c0                	test   %eax,%eax
   107c2:	0f 85 4a fe ff ff    	jne    10612 <fwp_cmp+0x52>
   107c8:	4d 8b 76 10          	mov    0x10(%r14),%r14
   107cc:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
   107d0:	4d 85 f6             	test   %r14,%r14
   107d3:	0f 94 c0             	sete   %al
   107d6:	74 05                	je     107dd <fwp_cmp+0x21d>
   107d8:	48 85 db             	test   %rbx,%rbx
   107db:	75 d3                	jne    107b0 <fwp_cmp+0x1f0>
   107dd:	48 85 db             	test   %rbx,%rbx
   107e0:	0f 95 c1             	setne  %cl
   107e3:	08 c1                	or     %al,%cl
   107e5:	80 f1 01             	xor    $0x1,%cl
   107e8:	0f b6 c9             	movzbl %cl,%ecx
   107eb:	84 c0                	test   %al,%al
   107ed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   107f2:	0f 44 c1             	cmove  %ecx,%eax
   107f5:	48 85 db             	test   %rbx,%rbx
   107f8:	0f 44 c1             	cmove  %ecx,%eax
   107fb:	e9 12 fe ff ff       	jmp    10612 <fwp_cmp+0x52>
   10800:	45 8b 67 10          	mov    0x10(%r15),%r12d
   10804:	45 85 e4             	test   %r12d,%r12d
   10807:	0f 8e 5d 02 00 00    	jle    10a6a <fwp_cmp+0x4aa>
   1080d:	4d 8b 7f 20          	mov    0x20(%r15),%r15
   10811:	45 31 ed             	xor    %r13d,%r13d
   10814:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
   1081b:	00 00 00 00 00 
   10820:	4b 8b 7c ee 08       	mov    0x8(%r14,%r13,8),%rdi
   10825:	4a 8b 74 eb 08       	mov    0x8(%rbx,%r13,8),%rsi
   1082a:	4b 8b 14 ef          	mov    (%r15,%r13,8),%rdx
   1082e:	e8 8d fd ff ff       	call   105c0 <fwp_cmp>
   10833:	85 c0                	test   %eax,%eax
   10835:	0f 85 d7 fd ff ff    	jne    10612 <fwp_cmp+0x52>
   1083b:	49 ff c5             	inc    %r13
   1083e:	31 c0                	xor    %eax,%eax
   10840:	4d 39 ec             	cmp    %r13,%r12
   10843:	75 db                	jne    10820 <fwp_cmp+0x260>
   10845:	e9 c8 fd ff ff       	jmp    10612 <fwp_cmp+0x52>
   1084a:	49 8b 06             	mov    (%r14),%rax
   1084d:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
   10854:	ff ff 7f 
   10857:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
   1085c:	4c 21 e0             	and    %r12,%rax
   1085f:	4c 8b 2b             	mov    (%rbx),%r13
   10862:	4d 21 ec             	and    %r13,%r12
   10865:	4c 39 e0             	cmp    %r12,%rax
   10868:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
   1086d:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
   10872:	4c 0f 42 e0          	cmovb  %rax,%r12
   10876:	4d 85 e4             	test   %r12,%r12
   10879:	0f 84 51 01 00 00    	je     109d0 <fwp_cmp+0x410>
   1087f:	4d 8b 7f 38          	mov    0x38(%r15),%r15
   10883:	49 8d 46 08          	lea    0x8(%r14),%rax
   10887:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
   1088c:	48 8d 43 08          	lea    0x8(%rbx),%rax
   10890:	48 89 04 24          	mov    %rax,(%rsp)
   10894:	31 ed                	xor    %ebp,%ebp
   10896:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   1089d:	00 00 00 
   108a0:	b8 08 00 00 00       	mov    $0x8,%eax
   108a5:	4d 85 ff             	test   %r15,%r15
   108a8:	74 14                	je     108be <fwp_cmp+0x2fe>
   108aa:	41 8b 0f             	mov    (%r15),%ecx
   108ad:	48 83 f9 0a          	cmp    $0xa,%rcx
   108b1:	77 0b                	ja     108be <fwp_cmp+0x2fe>
   108b3:	48 8d 05 36 50 00 00 	lea    0x5036(%rip),%rax        # 158f0 <exec_in_fp0+0x80>
   108ba:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
   108be:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
   108c3:	48 83 7c 24 10 00    	cmpq   $0x0,0x10(%rsp)
   108c9:	79 04                	jns    108cf <fwp_cmp+0x30f>
   108cb:	49 8b 4e 10          	mov    0x10(%r14),%rcx
   108cf:	48 89 c2             	mov    %rax,%rdx
   108d2:	48 0f af d5          	imul   %rbp,%rdx
   108d6:	48 83 f8 08          	cmp    $0x8,%rax
   108da:	74 2b                	je     10907 <fwp_cmp+0x347>
   108dc:	48 83 f8 02          	cmp    $0x2,%rax
   108e0:	74 15                	je     108f7 <fwp_cmp+0x337>
   108e2:	48 83 f8 01          	cmp    $0x1,%rax
   108e6:	75 2d                	jne    10915 <fwp_cmp+0x355>
   108e8:	0f b6 04 11          	movzbl (%rcx,%rdx,1),%eax
   108ec:	41 8b 0f             	mov    (%r15),%ecx
   108ef:	85 c9                	test   %ecx,%ecx
   108f1:	48 0f be f8          	movsbq %al,%rdi
   108f5:	eb 2a                	jmp    10921 <fwp_cmp+0x361>
   108f7:	0f b7 04 11          	movzwl (%rcx,%rdx,1),%eax
   108fb:	41 8b 0f             	mov    (%r15),%ecx
   108fe:	83 f9 01             	cmp    $0x1,%ecx
   10901:	48 0f bf f8          	movswq %ax,%rdi
   10905:	eb 1a                	jmp    10921 <fwp_cmp+0x361>
   10907:	48 8b 3c 11          	mov    (%rcx,%rdx,1),%rdi
   1090b:	4d 85 ff             	test   %r15,%r15
   1090e:	74 4b                	je     1095b <fwp_cmp+0x39b>
   10910:	41 8b 0f             	mov    (%r15),%ecx
   10913:	eb 10                	jmp    10925 <fwp_cmp+0x365>
   10915:	8b 04 11             	mov    (%rcx,%rdx,1),%eax
   10918:	41 8b 0f             	mov    (%r15),%ecx
   1091b:	83 f9 02             	cmp    $0x2,%ecx
   1091e:	48 63 f8             	movslq %eax,%rdi
   10921:	48 0f 45 f8          	cmovne %rax,%rdi
   10925:	83 f9 0a             	cmp    $0xa,%ecx
   10928:	77 31                	ja     1095b <fwp_cmp+0x39b>
   1092a:	b8 84 04 00 00       	mov    $0x484,%eax
   1092f:	0f a3 c8             	bt     %ecx,%eax
   10932:	72 20                	jb     10954 <fwp_cmp+0x394>
   10934:	b8 01 00 00 00       	mov    $0x1,%eax
   10939:	ba 21 00 00 00       	mov    $0x21,%edx
   1093e:	0f a3 ca             	bt     %ecx,%edx
   10941:	72 1d                	jb     10960 <fwp_cmp+0x3a0>
   10943:	b8 42 00 00 00       	mov    $0x42,%eax
   10948:	0f a3 c8             	bt     %ecx,%eax
   1094b:	73 0e                	jae    1095b <fwp_cmp+0x39b>
   1094d:	b8 02 00 00 00       	mov    $0x2,%eax
   10952:	eb 0c                	jmp    10960 <fwp_cmp+0x3a0>
   10954:	b8 04 00 00 00       	mov    $0x4,%eax
   10959:	eb 05                	jmp    10960 <fwp_cmp+0x3a0>
   1095b:	b8 08 00 00 00       	mov    $0x8,%eax
   10960:	48 8b 0c 24          	mov    (%rsp),%rcx
   10964:	4d 85 ed             	test   %r13,%r13
   10967:	79 04                	jns    1096d <fwp_cmp+0x3ad>
   10969:	48 8b 4b 10          	mov    0x10(%rbx),%rcx
   1096d:	48 89 c2             	mov    %rax,%rdx
   10970:	48 0f af d5          	imul   %rbp,%rdx
   10974:	48 83 f8 01          	cmp    $0x1,%rax
   10978:	74 1e                	je     10998 <fwp_cmp+0x3d8>
   1097a:	83 f8 02             	cmp    $0x2,%eax
   1097d:	74 0b                	je     1098a <fwp_cmp+0x3ca>
   1097f:	83 f8 08             	cmp    $0x8,%eax
   10982:	75 22                	jne    109a6 <fwp_cmp+0x3e6>
   10984:	48 8b 34 11          	mov    (%rcx,%rdx,1),%rsi
   10988:	eb 2a                	jmp    109b4 <fwp_cmp+0x3f4>
   1098a:	41 83 3f 01          	cmpl   $0x1,(%r15)
   1098e:	0f b7 04 11          	movzwl (%rcx,%rdx,1),%eax
   10992:	48 0f bf f0          	movswq %ax,%rsi
   10996:	eb 18                	jmp    109b0 <fwp_cmp+0x3f0>
   10998:	41 83 3f 00          	cmpl   $0x0,(%r15)
   1099c:	0f b6 04 11          	movzbl (%rcx,%rdx,1),%eax
   109a0:	48 0f be f0          	movsbq %al,%rsi
   109a4:	eb 0a                	jmp    109b0 <fwp_cmp+0x3f0>
   109a6:	41 83 3f 02          	cmpl   $0x2,(%r15)
   109aa:	8b 04 11             	mov    (%rcx,%rdx,1),%eax
   109ad:	48 63 f0             	movslq %eax,%rsi
   109b0:	48 0f 45 f0          	cmovne %rax,%rsi
   109b4:	4c 89 fa             	mov    %r15,%rdx
   109b7:	e8 04 fc ff ff       	call   105c0 <fwp_cmp>
   109bc:	85 c0                	test   %eax,%eax
   109be:	0f 85 4e fc ff ff    	jne    10612 <fwp_cmp+0x52>
   109c4:	48 ff c5             	inc    %rbp
   109c7:	49 39 ec             	cmp    %rbp,%r12
   109ca:	0f 85 d0 fe ff ff    	jne    108a0 <fwp_cmp+0x2e0>
   109d0:	31 c9                	xor    %ecx,%ecx
   109d2:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
   109d7:	48 3b 44 24 20       	cmp    0x20(%rsp),%rax
   109dc:	e9 26 fc ff ff       	jmp    10607 <fwp_cmp+0x47>
   109e1:	49 81 fe ff 0f 00 00 	cmp    $0xfff,%r14
   109e8:	77 27                	ja     10a11 <fwp_cmp+0x451>
   109ea:	44 89 f0             	mov    %r14d,%eax
   109ed:	48 81 fb ff 0f 00 00 	cmp    $0xfff,%rbx
   109f4:	76 27                	jbe    10a1d <fwp_cmp+0x45d>
   109f6:	8b 0b                	mov    (%rbx),%ecx
   109f8:	39 c8                	cmp    %ecx,%eax
   109fa:	74 27                	je     10a23 <fwp_cmp+0x463>
   109fc:	0f 97 c0             	seta   %al
   109ff:	0f b6 c8             	movzbl %al,%ecx
   10a02:	e9 03 fc ff ff       	jmp    1060a <fwp_cmp+0x4a>
   10a07:	31 c9                	xor    %ecx,%ecx
   10a09:	4d 39 e7             	cmp    %r12,%r15
   10a0c:	e9 f6 fb ff ff       	jmp    10607 <fwp_cmp+0x47>
   10a11:	41 8b 06             	mov    (%r14),%eax
   10a14:	48 81 fb ff 0f 00 00 	cmp    $0xfff,%rbx
   10a1b:	77 d9                	ja     109f6 <fwp_cmp+0x436>
   10a1d:	89 d9                	mov    %ebx,%ecx
   10a1f:	39 c8                	cmp    %ecx,%eax
   10a21:	75 d9                	jne    109fc <fwp_cmp+0x43c>
   10a23:	49 8b 4f 28          	mov    0x28(%r15),%rcx
   10a27:	89 c0                	mov    %eax,%eax
   10a29:	44 8b 24 81          	mov    (%rcx,%rax,4),%r12d
   10a2d:	45 85 e4             	test   %r12d,%r12d
   10a30:	7e 38                	jle    10a6a <fwp_cmp+0x4aa>
   10a32:	49 8b 4f 30          	mov    0x30(%r15),%rcx
   10a36:	4c 8b 3c c1          	mov    (%rcx,%rax,8),%r15
   10a3a:	45 31 ed             	xor    %r13d,%r13d
   10a3d:	0f 1f 00             	nopl   (%rax)
   10a40:	4b 8b 7c ee 08       	mov    0x8(%r14,%r13,8),%rdi
   10a45:	4a 8b 74 eb 08       	mov    0x8(%rbx,%r13,8),%rsi
   10a4a:	4b 8b 14 ef          	mov    (%r15,%r13,8),%rdx
   10a4e:	e8 6d fb ff ff       	call   105c0 <fwp_cmp>
   10a53:	85 c0                	test   %eax,%eax
   10a55:	0f 85 b7 fb ff ff    	jne    10612 <fwp_cmp+0x52>
   10a5b:	49 ff c5             	inc    %r13
   10a5e:	31 c0                	xor    %eax,%eax
   10a60:	4d 39 ec             	cmp    %r13,%r12
   10a63:	75 db                	jne    10a40 <fwp_cmp+0x480>
   10a65:	e9 a8 fb ff ff       	jmp    10612 <fwp_cmp+0x52>
   10a6a:	31 c0                	xor    %eax,%eax
   10a6c:	e9 a1 fb ff ff       	jmp    10612 <fwp_cmp+0x52>
   10a71:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   10a78:	0f 1f 84 00 00 00 00 
   10a7f:	00 

0000000000010a80 <fwp_pipe_poll>:
   10a80:	83 3d 59 b3 00 00 00 	cmpl   $0x0,0xb359(%rip)        # 1bde0 <fwp_po_listen>
   10a87:	0f 88 b1 01 00 00    	js     10c3e <fwp_pipe_poll+0x1be>
   10a8d:	55                   	push   %rbp
   10a8e:	41 57                	push   %r15
   10a90:	41 56                	push   %r14
   10a92:	53                   	push   %rbx
   10a93:	48 83 ec 38          	sub    $0x38,%rsp
   10a97:	48 8d 74 24 28       	lea    0x28(%rsp),%rsi
   10a9c:	bf 01 00 00 00       	mov    $0x1,%edi
   10aa1:	e8 8a 26 ff ff       	call   3130 <clock_gettime@plt>
   10aa6:	4c 69 74 24 28 00 ca 	imul   $0x3b9aca00,0x28(%rsp),%r14
   10aad:	9a 3b 
   10aaf:	4c 03 74 24 30       	add    0x30(%rsp),%r14
   10ab4:	4c 3b 35 75 b4 02 00 	cmp    0x2b475(%rip),%r14        # 3bf30 <fwp_po_next_check>
   10abb:	0f 8c 73 01 00 00    	jl     10c34 <fwp_pipe_poll+0x1b4>
   10ac1:	49 8d 86 40 42 0f 00 	lea    0xf4240(%r14),%rax
   10ac8:	48 89 05 61 b4 02 00 	mov    %rax,0x2b461(%rip)        # 3bf30 <fwp_po_next_check>
   10acf:	8b 3d 0b b3 00 00    	mov    0xb30b(%rip),%edi        # 1bde0 <fwp_po_listen>
   10ad5:	31 f6                	xor    %esi,%esi
   10ad7:	31 d2                	xor    %edx,%edx
   10ad9:	e8 52 29 ff ff       	call   3430 <accept@plt>
   10ade:	85 c0                	test   %eax,%eax
   10ae0:	0f 88 10 01 00 00    	js     10bf6 <fwp_pipe_poll+0x176>
   10ae6:	89 c3                	mov    %eax,%ebx
   10ae8:	8b 3d f2 b2 00 00    	mov    0xb2f2(%rip),%edi        # 1bde0 <fwp_po_listen>
   10aee:	e8 3d 27 ff ff       	call   3230 <close@plt>
   10af3:	c7 05 e3 b2 00 00 ff 	movl   $0xffffffff,0xb2e3(%rip)        # 1bde0 <fwp_po_listen>
   10afa:	ff ff ff 
   10afd:	89 df                	mov    %ebx,%edi
   10aff:	be 02 00 00 00       	mov    $0x2,%esi
   10b04:	ba 01 00 00 00       	mov    $0x1,%edx
   10b09:	31 c0                	xor    %eax,%eax
   10b0b:	e8 10 26 ff ff       	call   3120 <fcntl@plt>
   10b10:	89 df                	mov    %ebx,%edi
   10b12:	be 03 00 00 00       	mov    $0x3,%esi
   10b17:	31 c0                	xor    %eax,%eax
   10b19:	e8 02 26 ff ff       	call   3120 <fcntl@plt>
   10b1e:	25 ff f7 ff ff       	and    $0xfffff7ff,%eax
   10b23:	89 df                	mov    %ebx,%edi
   10b25:	be 04 00 00 00       	mov    $0x4,%esi
   10b2a:	89 c2                	mov    %eax,%edx
   10b2c:	31 c0                	xor    %eax,%eax
   10b2e:	e8 ed 25 ff ff       	call   3120 <fcntl@plt>
   10b33:	c7 44 24 24 0c 00 00 	movl   $0xc,0x24(%rsp)
   10b3a:	00 
   10b3b:	89 5c 24 1c          	mov    %ebx,0x1c(%rsp)
   10b3f:	c7 44 24 20 01 00 00 	movl   $0x1,0x20(%rsp)
   10b46:	00 
   10b47:	48 8d 4c 24 28       	lea    0x28(%rsp),%rcx
   10b4c:	4c 8d 44 24 24       	lea    0x24(%rsp),%r8
   10b51:	89 df                	mov    %ebx,%edi
   10b53:	be 01 00 00 00       	mov    $0x1,%esi
   10b58:	ba 11 00 00 00       	mov    $0x11,%edx
   10b5d:	e8 3e 27 ff ff       	call   32a0 <getsockopt@plt>
   10b62:	85 c0                	test   %eax,%eax
   10b64:	0f 85 c3 00 00 00    	jne    10c2d <fwp_pipe_poll+0x1ad>
   10b6a:	8b 6c 24 2c          	mov    0x2c(%rsp),%ebp
   10b6e:	e8 0d 26 ff ff       	call   3180 <getuid@plt>
   10b73:	39 c5                	cmp    %eax,%ebp
   10b75:	0f 85 b2 00 00 00    	jne    10c2d <fwp_pipe_poll+0x1ad>
   10b7b:	48 8d 7c 24 1c       	lea    0x1c(%rsp),%rdi
   10b80:	be 01 00 00 00       	mov    $0x1,%esi
   10b85:	ba e8 03 00 00       	mov    $0x3e8,%edx
   10b8a:	e8 31 28 ff ff       	call   33c0 <poll@plt>
   10b8f:	85 c0                	test   %eax,%eax
   10b91:	0f 8e 96 00 00 00    	jle    10c2d <fwp_pipe_poll+0x1ad>
   10b97:	48 8d 74 24 0f       	lea    0xf(%rsp),%rsi
   10b9c:	ba 05 00 00 00       	mov    $0x5,%edx
   10ba1:	89 df                	mov    %ebx,%edi
   10ba3:	31 c9                	xor    %ecx,%ecx
   10ba5:	e8 b6 24 ff ff       	call   3060 <recv@plt>
   10baa:	48 85 c0             	test   %rax,%rax
   10bad:	7e 7e                	jle    10c2d <fwp_pipe_poll+0x1ad>
   10baf:	49 89 c6             	mov    %rax,%r14
   10bb2:	4c 8d 7c 24 1c       	lea    0x1c(%rsp),%r15
   10bb7:	49 83 fe 04          	cmp    $0x4,%r14
   10bbb:	77 59                	ja     10c16 <fwp_pipe_poll+0x196>
   10bbd:	be 01 00 00 00       	mov    $0x1,%esi
   10bc2:	4c 89 ff             	mov    %r15,%rdi
   10bc5:	ba e8 03 00 00       	mov    $0x3e8,%edx
   10bca:	e8 f1 27 ff ff       	call   33c0 <poll@plt>
   10bcf:	85 c0                	test   %eax,%eax
   10bd1:	7e 5a                	jle    10c2d <fwp_pipe_poll+0x1ad>
   10bd3:	4a 8d 34 34          	lea    (%rsp,%r14,1),%rsi
   10bd7:	48 83 c6 0f          	add    $0xf,%rsi
   10bdb:	ba 05 00 00 00       	mov    $0x5,%edx
   10be0:	4c 29 f2             	sub    %r14,%rdx
   10be3:	89 df                	mov    %ebx,%edi
   10be5:	31 c9                	xor    %ecx,%ecx
   10be7:	e8 74 24 ff ff       	call   3060 <recv@plt>
   10bec:	49 01 c6             	add    %rax,%r14
   10bef:	48 85 c0             	test   %rax,%rax
   10bf2:	7f c3                	jg     10bb7 <fwp_pipe_poll+0x137>
   10bf4:	eb 37                	jmp    10c2d <fwp_pipe_poll+0x1ad>
   10bf6:	4c 3b 35 0b b3 01 00 	cmp    0x1b30b(%rip),%r14        # 2bf08 <fwp_po_give_up>
   10bfd:	7e 35                	jle    10c34 <fwp_pipe_poll+0x1b4>
   10bff:	8b 3d db b1 00 00    	mov    0xb1db(%rip),%edi        # 1bde0 <fwp_po_listen>
   10c05:	e8 26 26 ff ff       	call   3230 <close@plt>
   10c0a:	c7 05 cc b1 00 00 ff 	movl   $0xffffffff,0xb1cc(%rip)        # 1bde0 <fwp_po_listen>
   10c11:	ff ff ff 
   10c14:	eb 1e                	jmp    10c34 <fwp_pipe_poll+0x1b4>
   10c16:	81 7c 24 0f 46 57 50 	cmpl   $0x54505746,0xf(%rsp)
   10c1d:	54 
   10c1e:	75 0d                	jne    10c2d <fwp_pipe_poll+0x1ad>
   10c20:	0f b6 44 24 13       	movzbl 0x13(%rsp),%eax
   10c25:	8d 48 fd             	lea    -0x3(%rax),%ecx
   10c28:	80 f9 fd             	cmp    $0xfd,%cl
   10c2b:	77 12                	ja     10c3f <fwp_pipe_poll+0x1bf>
   10c2d:	89 df                	mov    %ebx,%edi
   10c2f:	e8 fc 25 ff ff       	call   3230 <close@plt>
   10c34:	48 83 c4 38          	add    $0x38,%rsp
   10c38:	5b                   	pop    %rbx
   10c39:	41 5e                	pop    %r14
   10c3b:	41 5f                	pop    %r15
   10c3d:	5d                   	pop    %rbp
   10c3e:	c3                   	ret
   10c3f:	89 1d 9f b1 00 00    	mov    %ebx,0xb19f(%rip)        # 1bde4 <fwp_po_sock>
   10c45:	bb 01 00 00 00       	mov    $0x1,%ebx
   10c4a:	3c 02                	cmp    $0x2,%al
   10c4c:	75 10                	jne    10c5e <fwp_pipe_poll+0x1de>
   10c4e:	e8 4d 00 00 00       	call   10ca0 <fwp_po_make_ring>
   10c53:	83 f8 01             	cmp    $0x1,%eax
   10c56:	bb 02 00 00 00       	mov    $0x2,%ebx
   10c5b:	83 db 00             	sbb    $0x0,%ebx
   10c5e:	c7 44 24 14 02 01 00 	movl   $0x102,0x14(%rsp)
   10c65:	00 
   10c66:	c6 44 24 18 00       	movb   $0x0,0x18(%rsp)
   10c6b:	88 5c 24 19          	mov    %bl,0x19(%rsp)
   10c6f:	4c 8b 35 3a 93 00 00 	mov    0x933a(%rip),%r14        # 19fb0 <stdout@GLIBC_2.2.5>
   10c76:	49 8b 0e             	mov    (%r14),%rcx
   10c79:	48 8d 7c 24 14       	lea    0x14(%rsp),%rdi
   10c7e:	be 01 00 00 00       	mov    $0x1,%esi
   10c83:	ba 06 00 00 00       	mov    $0x6,%edx
   10c88:	e8 f3 27 ff ff       	call   3480 <fwrite@plt>
   10c8d:	49 8b 3e             	mov    (%r14),%rdi
   10c90:	e8 bb 26 ff ff       	call   3350 <fflush@plt>
   10c95:	89 1d 75 b2 01 00    	mov    %ebx,0x1b275(%rip)        # 2bf10 <fwp_po_kind>
   10c9b:	eb 97                	jmp    10c34 <fwp_pipe_poll+0x1b4>
   10c9d:	0f 1f 00             	nopl   (%rax)

0000000000010ca0 <fwp_po_make_ring>:
   10ca0:	55                   	push   %rbp
   10ca1:	41 57                	push   %r15
   10ca3:	41 56                	push   %r14
   10ca5:	53                   	push   %rbx
   10ca6:	48 83 ec 68          	sub    $0x68,%rsp
   10caa:	48 8d 35 7b 5a 00 00 	lea    0x5a7b(%rip),%rsi        # 1672c <exec_in_fp0+0xebc>
   10cb1:	31 ed                	xor    %ebp,%ebp
   10cb3:	bf 3f 01 00 00       	mov    $0x13f,%edi
   10cb8:	ba 01 00 00 00       	mov    $0x1,%edx
   10cbd:	31 c0                	xor    %eax,%eax
   10cbf:	e8 3c 26 ff ff       	call   3300 <syscall@plt>
   10cc4:	48 89 c3             	mov    %rax,%rbx
   10cc7:	85 db                	test   %ebx,%ebx
   10cc9:	78 17                	js     10ce2 <fwp_po_make_ring+0x42>
   10ccb:	be 00 10 10 00       	mov    $0x101000,%esi
   10cd0:	89 df                	mov    %ebx,%edi
   10cd2:	e8 09 25 ff ff       	call   31e0 <ftruncate@plt>
   10cd7:	85 c0                	test   %eax,%eax
   10cd9:	74 14                	je     10cef <fwp_po_make_ring+0x4f>
   10cdb:	89 df                	mov    %ebx,%edi
   10cdd:	e8 4e 25 ff ff       	call   3230 <close@plt>
   10ce2:	89 e8                	mov    %ebp,%eax
   10ce4:	48 83 c4 68          	add    $0x68,%rsp
   10ce8:	5b                   	pop    %rbx
   10ce9:	41 5e                	pop    %r14
   10ceb:	41 5f                	pop    %r15
   10ced:	5d                   	pop    %rbp
   10cee:	c3                   	ret
   10cef:	be 00 10 10 00       	mov    $0x101000,%esi
   10cf4:	31 ff                	xor    %edi,%edi
   10cf6:	ba 03 00 00 00       	mov    $0x3,%edx
   10cfb:	b9 01 00 00 00       	mov    $0x1,%ecx
   10d00:	41 89 d8             	mov    %ebx,%r8d
   10d03:	45 31 c9             	xor    %r9d,%r9d
   10d06:	e8 85 24 ff ff       	call   3190 <mmap@plt>
   10d0b:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
   10d0f:	74 ca                	je     10cdb <fwp_po_make_ring+0x3b>
   10d11:	49 89 c6             	mov    %rax,%r14
   10d14:	48 b8 46 57 50 53 01 	movabs $0x153505746,%rax
   10d1b:	00 00 00 
   10d1e:	49 89 06             	mov    %rax,(%r14)
   10d21:	49 c7 46 08 00 00 10 	movq   $0x100000,0x8(%r14)
   10d28:	00 
   10d29:	c6 44 24 07 53       	movb   $0x53,0x7(%rsp)
   10d2e:	48 8d 44 24 07       	lea    0x7(%rsp),%rax
   10d33:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   10d38:	48 c7 44 24 28 01 00 	movq   $0x1,0x28(%rsp)
   10d3f:	00 00 
   10d41:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
   10d48:	00 00 
   10d4a:	0f 57 c0             	xorps  %xmm0,%xmm0
   10d4d:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
   10d52:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
   10d57:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
   10d5c:	48 c7 44 24 60 00 00 	movq   $0x0,0x60(%rsp)
   10d63:	00 00 
   10d65:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
   10d6a:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
   10d6f:	48 c7 44 24 48 01 00 	movq   $0x1,0x48(%rsp)
   10d76:	00 00 
   10d78:	48 8d 44 24 08       	lea    0x8(%rsp),%rax
   10d7d:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
   10d82:	48 c7 44 24 58 18 00 	movq   $0x18,0x58(%rsp)
   10d89:	00 00 
   10d8b:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
   10d92:	00 00 00 
   10d95:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
   10d9a:	48 c7 44 24 08 14 00 	movq   $0x14,0x8(%rsp)
   10da1:	00 00 
   10da3:	89 5c 24 18          	mov    %ebx,0x18(%rsp)
   10da7:	8b 3d 37 b0 00 00    	mov    0xb037(%rip),%edi        # 1bde4 <fwp_po_sock>
   10dad:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
   10db2:	ba 00 40 00 00       	mov    $0x4000,%edx
   10db7:	e8 04 23 ff ff       	call   30c0 <sendmsg@plt>
   10dbc:	49 89 c7             	mov    %rax,%r15
   10dbf:	89 df                	mov    %ebx,%edi
   10dc1:	e8 6a 24 ff ff       	call   3230 <close@plt>
   10dc6:	49 83 ff 01          	cmp    $0x1,%r15
   10dca:	75 11                	jne    10ddd <fwp_po_make_ring+0x13d>
   10dcc:	4c 89 35 4d b1 02 00 	mov    %r14,0x2b14d(%rip)        # 3bf20 <fwp_po_ring>
   10dd3:	bd 01 00 00 00       	mov    $0x1,%ebp
   10dd8:	e9 05 ff ff ff       	jmp    10ce2 <fwp_po_make_ring+0x42>
   10ddd:	be 00 10 10 00       	mov    $0x101000,%esi
   10de2:	4c 89 f7             	mov    %r14,%rdi
   10de5:	e8 a6 25 ff ff       	call   3390 <munmap@plt>
   10dea:	31 ed                	xor    %ebp,%ebp
   10dec:	e9 f1 fe ff ff       	jmp    10ce2 <fwp_po_make_ring+0x42>
   10df1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   10df8:	0f 1f 84 00 00 00 00 
   10dff:	00 

0000000000010e00 <fwp_write>:
   10e00:	55                   	push   %rbp
   10e01:	41 57                	push   %r15
   10e03:	41 56                	push   %r14
   10e05:	41 55                	push   %r13
   10e07:	41 54                	push   %r12
   10e09:	53                   	push   %rbx
   10e0a:	48 81 ec 78 02 00 00 	sub    $0x278,%rsp
   10e11:	8b 02                	mov    (%rdx),%eax
   10e13:	48 83 f8 19          	cmp    $0x19,%rax
   10e17:	0f 87 36 12 00 00    	ja     12053 <fwp_write+0x1253>
   10e1d:	49 89 d7             	mov    %rdx,%r15
   10e20:	49 89 f6             	mov    %rsi,%r14
   10e23:	48 89 fd             	mov    %rdi,%rbp
   10e26:	48 8d 15 cb 46 00 00 	lea    0x46cb(%rip),%rdx        # 154f8 <_IO_stdin_used+0x4f8>
   10e2d:	48 63 34 82          	movslq (%rdx,%rax,4),%rsi
   10e31:	48 01 d6             	add    %rdx,%rsi
   10e34:	48 89 3c 24          	mov    %rdi,(%rsp)
   10e38:	ff e6                	jmp    *%rsi
   10e3a:	48 8d 15 19 59 00 00 	lea    0x5919(%rip),%rdx        # 1675a <exec_in_fp0+0xeea>
   10e41:	eb 07                	jmp    10e4a <fwp_write+0x4a>
   10e43:	48 8d 15 d8 58 00 00 	lea    0x58d8(%rip),%rdx        # 16722 <exec_in_fp0+0xeb2>
   10e4a:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
   10e4f:	be 00 02 00 00       	mov    $0x200,%esi
   10e54:	4c 89 ff             	mov    %r15,%rdi
   10e57:	4c 89 f1             	mov    %r14,%rcx
   10e5a:	31 c0                	xor    %eax,%eax
   10e5c:	e8 6f 23 ff ff       	call   31d0 <snprintf@plt>
   10e61:	4c 89 ff             	mov    %r15,%rdi
   10e64:	e8 07 23 ff ff       	call   3170 <strlen@plt>
   10e69:	48 89 ef             	mov    %rbp,%rdi
   10e6c:	4c 89 fe             	mov    %r15,%rsi
   10e6f:	e9 d7 11 00 00       	jmp    1204b <fwp_write+0x124b>
   10e74:	83 f8 13             	cmp    $0x13,%eax
   10e77:	48 8d 05 0d 59 00 00 	lea    0x590d(%rip),%rax        # 1678b <exec_in_fp0+0xf1b>
   10e7e:	48 8d 35 0b 59 00 00 	lea    0x590b(%rip),%rsi        # 16790 <exec_in_fp0+0xf20>
   10e85:	48 0f 44 f0          	cmove  %rax,%rsi
   10e89:	ba 04 00 00 00       	mov    $0x4,%edx
   10e8e:	48 89 ef             	mov    %rbp,%rdi
   10e91:	e8 3a c3 ff ff       	call   d1d0 <buf_put>
   10e96:	49 83 3e 00          	cmpq   $0x0,(%r14)
   10e9a:	0f 84 c3 00 00 00    	je     10f63 <fwp_write+0x163>
   10ea0:	49 8b 57 38          	mov    0x38(%r15),%rdx
   10ea4:	49 8b 76 08          	mov    0x8(%r14),%rsi
   10ea8:	48 8b 1c 24          	mov    (%rsp),%rbx
   10eac:	48 89 df             	mov    %rbx,%rdi
   10eaf:	31 c9                	xor    %ecx,%ecx
   10eb1:	e8 4a ff ff ff       	call   10e00 <fwp_write>
   10eb6:	41 83 3f 12          	cmpl   $0x12,(%r15)
   10eba:	75 26                	jne    10ee2 <fwp_write+0xe2>
   10ebc:	48 8d 35 8c 58 00 00 	lea    0x588c(%rip),%rsi        # 1674f <exec_in_fp0+0xedf>
   10ec3:	ba 02 00 00 00       	mov    $0x2,%edx
   10ec8:	48 89 df             	mov    %rbx,%rdi
   10ecb:	e8 00 c3 ff ff       	call   d1d0 <buf_put>
   10ed0:	49 8b 76 10          	mov    0x10(%r14),%rsi
   10ed4:	49 8b 57 40          	mov    0x40(%r15),%rdx
   10ed8:	48 89 df             	mov    %rbx,%rdi
   10edb:	31 c9                	xor    %ecx,%ecx
   10edd:	e8 1e ff ff ff       	call   10e00 <fwp_write>
   10ee2:	49 83 3e 02          	cmpq   $0x2,(%r14)
   10ee6:	72 7b                	jb     10f63 <fwp_write+0x163>
   10ee8:	49 8d 5e 20          	lea    0x20(%r14),%rbx
   10eec:	bd 01 00 00 00       	mov    $0x1,%ebp
   10ef1:	4c 8d 25 b4 57 00 00 	lea    0x57b4(%rip),%r12        # 166ac <exec_in_fp0+0xe3c>
   10ef8:	eb 12                	jmp    10f0c <fwp_write+0x10c>
   10efa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   10f00:	48 ff c5             	inc    %rbp
   10f03:	48 83 c3 10          	add    $0x10,%rbx
   10f07:	49 3b 2e             	cmp    (%r14),%rbp
   10f0a:	73 57                	jae    10f63 <fwp_write+0x163>
   10f0c:	ba 02 00 00 00       	mov    $0x2,%edx
   10f11:	4c 8b 2c 24          	mov    (%rsp),%r13
   10f15:	4c 89 ef             	mov    %r13,%rdi
   10f18:	4c 89 e6             	mov    %r12,%rsi
   10f1b:	e8 b0 c2 ff ff       	call   d1d0 <buf_put>
   10f20:	48 8b 73 f8          	mov    -0x8(%rbx),%rsi
   10f24:	49 8b 57 38          	mov    0x38(%r15),%rdx
   10f28:	4c 89 ef             	mov    %r13,%rdi
   10f2b:	31 c9                	xor    %ecx,%ecx
   10f2d:	e8 ce fe ff ff       	call   10e00 <fwp_write>
   10f32:	41 83 3f 12          	cmpl   $0x12,(%r15)
   10f36:	75 c8                	jne    10f00 <fwp_write+0x100>
   10f38:	ba 02 00 00 00       	mov    $0x2,%edx
   10f3d:	4c 8b 2c 24          	mov    (%rsp),%r13
   10f41:	4c 89 ef             	mov    %r13,%rdi
   10f44:	48 8d 35 04 58 00 00 	lea    0x5804(%rip),%rsi        # 1674f <exec_in_fp0+0xedf>
   10f4b:	e8 80 c2 ff ff       	call   d1d0 <buf_put>
   10f50:	48 8b 33             	mov    (%rbx),%rsi
   10f53:	49 8b 57 40          	mov    0x40(%r15),%rdx
   10f57:	4c 89 ef             	mov    %r13,%rdi
   10f5a:	31 c9                	xor    %ecx,%ecx
   10f5c:	e8 9f fe ff ff       	call   10e00 <fwp_write>
   10f61:	eb 9d                	jmp    10f00 <fwp_write+0x100>
   10f63:	c6 44 24 70 7d       	movb   $0x7d,0x70(%rsp)
   10f68:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   10f6d:	ba 01 00 00 00       	mov    $0x1,%edx
   10f72:	48 8b 3c 24          	mov    (%rsp),%rdi
   10f76:	e9 d3 10 00 00       	jmp    1204e <fwp_write+0x124e>
   10f7b:	4d 8b 67 08          	mov    0x8(%r15),%r12
   10f7f:	4d 85 e4             	test   %r12,%r12
   10f82:	0f 84 bf 06 00 00    	je     11647 <fwp_write+0x847>
   10f88:	48 8d 35 36 57 00 00 	lea    0x5736(%rip),%rsi        # 166c5 <exec_in_fp0+0xe55>
   10f8f:	4c 89 e7             	mov    %r12,%rdi
   10f92:	e8 39 23 ff ff       	call   32d0 <strcmp@plt>
   10f97:	85 c0                	test   %eax,%eax
   10f99:	0f 84 46 0b 00 00    	je     11ae5 <fwp_write+0xce5>
   10f9f:	4d 8d 6f 10          	lea    0x10(%r15),%r13
   10fa3:	4c 89 e7             	mov    %r12,%rdi
   10fa6:	e8 c5 21 ff ff       	call   3170 <strlen@plt>
   10fab:	48 89 ef             	mov    %rbp,%rdi
   10fae:	4c 89 e6             	mov    %r12,%rsi
   10fb1:	48 89 c2             	mov    %rax,%rdx
   10fb4:	e8 17 c2 ff ff       	call   d1d0 <buf_put>
   10fb9:	c6 44 24 70 20       	movb   $0x20,0x70(%rsp)
   10fbe:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   10fc3:	ba 01 00 00 00       	mov    $0x1,%edx
   10fc8:	48 89 ef             	mov    %rbp,%rdi
   10fcb:	e8 00 c2 ff ff       	call   d1d0 <buf_put>
   10fd0:	31 db                	xor    %ebx,%ebx
   10fd2:	e9 8f 06 00 00       	jmp    11666 <fwp_write+0x866>
   10fd7:	49 81 fe ff 0f 00 00 	cmp    $0xfff,%r14
   10fde:	0f 87 10 05 00 00    	ja     114f4 <fwp_write+0x6f4>
   10fe4:	44 89 f0             	mov    %r14d,%eax
   10fe7:	e9 0b 05 00 00       	jmp    114f7 <fwp_write+0x6f7>
   10fec:	66 49 0f 6e ce       	movq   %r14,%xmm1
   10ff1:	66 0f 2e c9          	ucomisd %xmm1,%xmm1
   10ff5:	0f 8a e2 11 00 00    	jp     121dd <fwp_write+0x13dd>
   10ffb:	66 0f 28 05 fd 40 00 	movapd 0x40fd(%rip),%xmm0        # 15100 <_IO_stdin_used+0x100>
   11002:	00 
   11003:	66 0f 54 c1          	andpd  %xmm1,%xmm0
   11007:	66 0f 2e 05 b1 41 00 	ucomisd 0x41b1(%rip),%xmm0        # 151c0 <_IO_stdin_used+0x1c0>
   1100e:	00 
   1100f:	0f 82 76 08 00 00    	jb     1188b <fwp_write+0xa8b>
   11015:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
   11019:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
   1101d:	e9 65 04 00 00       	jmp    11487 <fwp_write+0x687>
   11022:	c6 44 24 70 3c       	movb   $0x3c,0x70(%rsp)
   11027:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   1102c:	ba 01 00 00 00       	mov    $0x1,%edx
   11031:	48 89 ef             	mov    %rbp,%rdi
   11034:	e8 97 c1 ff ff       	call   d1d0 <buf_put>
   11039:	4d 8b 77 08          	mov    0x8(%r15),%r14
   1103d:	e9 92 04 00 00       	jmp    114d4 <fwp_write+0x6d4>
   11042:	48 8d 35 21 57 00 00 	lea    0x5721(%rip),%rsi        # 1676a <exec_in_fp0+0xefa>
   11049:	ba 08 00 00 00       	mov    $0x8,%edx
   1104e:	48 89 ef             	mov    %rbp,%rdi
   11051:	e9 6c 0d 00 00       	jmp    11dc2 <fwp_write+0xfc2>
   11056:	49 8d 76 08          	lea    0x8(%r14),%rsi
   1105a:	49 8b 16             	mov    (%r14),%rdx
   1105d:	85 c9                	test   %ecx,%ecx
   1105f:	0f 84 23 07 00 00    	je     11788 <fwp_write+0x988>
   11065:	48 89 ef             	mov    %rbp,%rdi
   11068:	e9 55 0d 00 00       	jmp    11dc2 <fwp_write+0xfc2>
   1106d:	4d 8b 0e             	mov    (%r14),%r9
   11070:	4d 8b 46 08          	mov    0x8(%r14),%r8
   11074:	4c 89 c8             	mov    %r9,%rax
   11077:	4c 09 c0             	or     %r8,%rax
   1107a:	0f 84 21 07 00 00    	je     117a1 <fwp_write+0x9a1>
   11080:	31 ff                	xor    %edi,%edi
   11082:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
   11089:	cc cc cc 
   1108c:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
   11093:	cc cc cc 
   11096:	4c 89 c3             	mov    %r8,%rbx
   11099:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   110a0:	4c 89 c1             	mov    %r8,%rcx
   110a3:	4c 0f a4 c9 3f       	shld   $0x3f,%r9,%rcx
   110a8:	48 d1 eb             	shr    $1,%rbx
   110ab:	48 89 ce             	mov    %rcx,%rsi
   110ae:	48 01 de             	add    %rbx,%rsi
   110b1:	48 83 d6 00          	adc    $0x0,%rsi
   110b5:	48 89 f0             	mov    %rsi,%rax
   110b8:	49 f7 e2             	mul    %r10
   110bb:	48 c1 ea 02          	shr    $0x2,%rdx
   110bf:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   110c3:	48 29 c6             	sub    %rax,%rsi
   110c6:	48 29 f1             	sub    %rsi,%rcx
   110c9:	48 83 db 00          	sbb    $0x0,%rbx
   110cd:	48 89 ce             	mov    %rcx,%rsi
   110d0:	49 0f af f3          	imul   %r11,%rsi
   110d4:	48 89 c8             	mov    %rcx,%rax
   110d7:	49 f7 e2             	mul    %r10
   110da:	48 01 f2             	add    %rsi,%rdx
   110dd:	49 0f af da          	imul   %r10,%rbx
   110e1:	48 01 d3             	add    %rdx,%rbx
   110e4:	48 89 c1             	mov    %rax,%rcx
   110e7:	48 01 c1             	add    %rax,%rcx
   110ea:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
   110ee:	44 89 ca             	mov    %r9d,%edx
   110f1:	29 ca                	sub    %ecx,%edx
   110f3:	80 ca 30             	or     $0x30,%dl
   110f6:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
   110fa:	48 ff c7             	inc    %rdi
   110fd:	49 83 f9 0a          	cmp    $0xa,%r9
   11101:	49 83 d8 00          	sbb    $0x0,%r8
   11105:	49 89 c1             	mov    %rax,%r9
   11108:	49 89 d8             	mov    %rbx,%r8
   1110b:	73 93                	jae    110a0 <fwp_write+0x2a0>
   1110d:	85 ff                	test   %edi,%edi
   1110f:	0f 8f 96 06 00 00    	jg     117ab <fwp_write+0x9ab>
   11115:	e9 ab 00 00 00       	jmp    111c5 <fwp_write+0x3c5>
   1111a:	4d 8b 06             	mov    (%r14),%r8
   1111d:	4d 8b 4e 08          	mov    0x8(%r14),%r9
   11121:	4d 85 c9             	test   %r9,%r9
   11124:	0f 88 a3 06 00 00    	js     117cd <fwp_write+0x9cd>
   1112a:	4c 89 c0             	mov    %r8,%rax
   1112d:	4c 09 c8             	or     %r9,%rax
   11130:	0f 84 cc 09 00 00    	je     11b02 <fwp_write+0xd02>
   11136:	31 ff                	xor    %edi,%edi
   11138:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
   1113f:	cc cc cc 
   11142:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
   11149:	cc cc cc 
   1114c:	4c 89 cb             	mov    %r9,%rbx
   1114f:	90                   	nop
   11150:	4c 89 c9             	mov    %r9,%rcx
   11153:	4c 0f a4 c1 3f       	shld   $0x3f,%r8,%rcx
   11158:	48 d1 eb             	shr    $1,%rbx
   1115b:	48 89 ce             	mov    %rcx,%rsi
   1115e:	48 01 de             	add    %rbx,%rsi
   11161:	48 83 d6 00          	adc    $0x0,%rsi
   11165:	48 89 f0             	mov    %rsi,%rax
   11168:	49 f7 e2             	mul    %r10
   1116b:	48 c1 ea 02          	shr    $0x2,%rdx
   1116f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   11173:	48 29 c6             	sub    %rax,%rsi
   11176:	48 29 f1             	sub    %rsi,%rcx
   11179:	48 83 db 00          	sbb    $0x0,%rbx
   1117d:	48 89 ce             	mov    %rcx,%rsi
   11180:	49 0f af f3          	imul   %r11,%rsi
   11184:	48 89 c8             	mov    %rcx,%rax
   11187:	49 f7 e2             	mul    %r10
   1118a:	48 01 f2             	add    %rsi,%rdx
   1118d:	49 0f af da          	imul   %r10,%rbx
   11191:	48 01 d3             	add    %rdx,%rbx
   11194:	48 89 c1             	mov    %rax,%rcx
   11197:	48 01 c1             	add    %rax,%rcx
   1119a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
   1119e:	44 89 c2             	mov    %r8d,%edx
   111a1:	29 ca                	sub    %ecx,%edx
   111a3:	80 ca 30             	or     $0x30,%dl
   111a6:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
   111aa:	48 ff c7             	inc    %rdi
   111ad:	49 83 f8 0a          	cmp    $0xa,%r8
   111b1:	49 83 d9 00          	sbb    $0x0,%r9
   111b5:	49 89 c0             	mov    %rax,%r8
   111b8:	49 89 d9             	mov    %rbx,%r9
   111bb:	73 93                	jae    11150 <fwp_write+0x350>
   111bd:	85 ff                	test   %edi,%edi
   111bf:	0f 8f 47 09 00 00    	jg     11b0c <fwp_write+0xd0c>
   111c5:	31 c0                	xor    %eax,%eax
   111c7:	e9 67 0e 00 00       	jmp    12033 <fwp_write+0x1233>
   111cc:	c6 44 24 70 5b       	movb   $0x5b,0x70(%rsp)
   111d1:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   111d6:	ba 01 00 00 00       	mov    $0x1,%edx
   111db:	48 89 ef             	mov    %rbp,%rdi
   111de:	e8 ed bf ff ff       	call   d1d0 <buf_put>
   111e3:	4d 85 f6             	test   %r14,%r14
   111e6:	0f 84 f6 0c 00 00    	je     11ee2 <fwp_write+0x10e2>
   111ec:	49 8b 57 38          	mov    0x38(%r15),%rdx
   111f0:	49 8b 76 08          	mov    0x8(%r14),%rsi
   111f4:	48 89 ef             	mov    %rbp,%rdi
   111f7:	31 c9                	xor    %ecx,%ecx
   111f9:	e8 02 fc ff ff       	call   10e00 <fwp_write>
   111fe:	49 8b 5e 10          	mov    0x10(%r14),%rbx
   11202:	48 85 db             	test   %rbx,%rbx
   11205:	0f 84 d7 0c 00 00    	je     11ee2 <fwp_write+0x10e2>
   1120b:	4c 8d 35 9a 54 00 00 	lea    0x549a(%rip),%r14        # 166ac <exec_in_fp0+0xe3c>
   11212:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   11219:	1f 84 00 00 00 00 00 
   11220:	ba 02 00 00 00       	mov    $0x2,%edx
   11225:	48 89 ef             	mov    %rbp,%rdi
   11228:	4c 89 f6             	mov    %r14,%rsi
   1122b:	e8 a0 bf ff ff       	call   d1d0 <buf_put>
   11230:	48 8b 73 08          	mov    0x8(%rbx),%rsi
   11234:	49 8b 57 38          	mov    0x38(%r15),%rdx
   11238:	48 89 ef             	mov    %rbp,%rdi
   1123b:	31 c9                	xor    %ecx,%ecx
   1123d:	e8 be fb ff ff       	call   10e00 <fwp_write>
   11242:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
   11246:	48 85 db             	test   %rbx,%rbx
   11249:	75 d5                	jne    11220 <fwp_write+0x420>
   1124b:	e9 92 0c 00 00       	jmp    11ee2 <fwp_write+0x10e2>
   11250:	4d 63 67 48          	movslq 0x48(%r15),%r12
   11254:	44 89 e3             	mov    %r12d,%ebx
   11257:	49 8d 54 24 03       	lea    0x3(%r12),%rdx
   1125c:	48 ff 05 45 ac 00 00 	incq   0xac45(%rip)        # 1bea8 <measured_calls>
   11263:	48 01 15 46 ac 00 00 	add    %rdx,0xac46(%rip)        # 1beb0 <measured_bytes>
   1126a:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
   11271:	0f 87 59 08 00 00    	ja     11ad0 <fwp_write+0xcd0>
   11277:	49 8d 4c 24 12       	lea    0x12(%r12),%rcx
   1127c:	48 c1 e9 04          	shr    $0x4,%rcx
   11280:	48 8d 05 01 90 00 00 	lea    0x9001(%rip),%rax        # 1a288 <fwp_gc>
   11287:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
   1128e:	00 
   1128f:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
   11296:	48 29 0d eb 8f 00 00 	sub    %rcx,0x8feb(%rip)        # 1a288 <fwp_gc>
   1129d:	0f 88 2d 08 00 00    	js     11ad0 <fwp_write+0xcd0>
   112a3:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
   112a7:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
   112ab:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
   112b2:	4c 8b 3f             	mov    (%rdi),%r15
   112b5:	4d 85 ff             	test   %r15,%r15
   112b8:	0f 84 f6 07 00 00    	je     11ab4 <fwp_write+0xcb4>
   112be:	49 8b 07             	mov    (%r15),%rax
   112c1:	48 f7 d0             	not    %rax
   112c4:	48 89 07             	mov    %rax,(%rdi)
   112c7:	e9 2f 0a 00 00       	jmp    11cfb <fwp_write+0xefb>
   112cc:	49 83 fe ff          	cmp    $0xffffffffffffffff,%r14
   112d0:	48 8d 05 e1 53 00 00 	lea    0x53e1(%rip),%rax        # 166b8 <exec_in_fp0+0xe48>
   112d7:	48 8d 0d d3 54 00 00 	lea    0x54d3(%rip),%rcx        # 167b1 <exec_in_fp0+0xf41>
   112de:	48 0f 44 c8          	cmove  %rax,%rcx
   112e2:	49 83 fe 01          	cmp    $0x1,%r14
   112e6:	4c 8d 35 c8 53 00 00 	lea    0x53c8(%rip),%r14        # 166b5 <exec_in_fp0+0xe45>
   112ed:	4c 0f 45 f1          	cmovne %rcx,%r14
   112f1:	4c 89 f7             	mov    %r14,%rdi
   112f4:	e8 77 1e ff ff       	call   3170 <strlen@plt>
   112f9:	48 89 ef             	mov    %rbp,%rdi
   112fc:	4c 89 f6             	mov    %r14,%rsi
   112ff:	e9 bb 0a 00 00       	jmp    11dbf <fwp_write+0xfbf>
   11304:	48 8d 35 79 54 00 00 	lea    0x5479(%rip),%rsi        # 16784 <exec_in_fp0+0xf14>
   1130b:	ba 06 00 00 00       	mov    $0x6,%edx
   11310:	48 89 ef             	mov    %rbp,%rdi
   11313:	e8 b8 be ff ff       	call   d1d0 <buf_put>
   11318:	49 8b 36             	mov    (%r14),%rsi
   1131b:	48 8d 04 75 00 00 00 	lea    0x0(,%rsi,2),%rax
   11322:	00 
   11323:	48 85 c0             	test   %rax,%rax
   11326:	0f 84 b6 0b 00 00    	je     11ee2 <fwp_write+0x10e2>
   1132c:	49 8b 57 38          	mov    0x38(%r15),%rdx
   11330:	b8 08 00 00 00       	mov    $0x8,%eax
   11335:	48 85 d2             	test   %rdx,%rdx
   11338:	74 13                	je     1134d <fwp_write+0x54d>
   1133a:	8b 0a                	mov    (%rdx),%ecx
   1133c:	48 83 f9 0a          	cmp    $0xa,%rcx
   11340:	77 0b                	ja     1134d <fwp_write+0x54d>
   11342:	48 8d 05 a7 45 00 00 	lea    0x45a7(%rip),%rax        # 158f0 <exec_in_fp0+0x80>
   11349:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
   1134d:	4d 8d 6e 08          	lea    0x8(%r14),%r13
   11351:	4c 89 e9             	mov    %r13,%rcx
   11354:	48 85 f6             	test   %rsi,%rsi
   11357:	79 04                	jns    1135d <fwp_write+0x55d>
   11359:	49 8b 4e 10          	mov    0x10(%r14),%rcx
   1135d:	48 83 f8 01          	cmp    $0x1,%rax
   11361:	0f 84 76 0a 00 00    	je     11ddd <fwp_write+0xfdd>
   11367:	48 83 f8 08          	cmp    $0x8,%rax
   1136b:	0f 84 67 0a 00 00    	je     11dd8 <fwp_write+0xfd8>
   11371:	48 83 f8 02          	cmp    $0x2,%rax
   11375:	0f 85 6e 0a 00 00    	jne    11de9 <fwp_write+0xfe9>
   1137b:	83 3a 01             	cmpl   $0x1,(%rdx)
   1137e:	0f b7 01             	movzwl (%rcx),%eax
   11381:	48 0f bf f0          	movswq %ax,%rsi
   11385:	e9 67 0a 00 00       	jmp    11df1 <fwp_write+0xff1>
   1138a:	48 8d 35 e9 53 00 00 	lea    0x53e9(%rip),%rsi        # 1677a <exec_in_fp0+0xf0a>
   11391:	ba 06 00 00 00       	mov    $0x6,%edx
   11396:	48 89 ef             	mov    %rbp,%rdi
   11399:	e8 32 be ff ff       	call   d1d0 <buf_put>
   1139e:	49 83 3e 00          	cmpq   $0x0,(%r14)
   113a2:	0f 84 a5 00 00 00    	je     1144d <fwp_write+0x64d>
   113a8:	41 0f b6 4e 08       	movzbl 0x8(%r14),%ecx
   113ad:	48 8d 15 cd 53 00 00 	lea    0x53cd(%rip),%rdx        # 16781 <exec_in_fp0+0xf11>
   113b4:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
   113b9:	be 00 02 00 00       	mov    $0x200,%esi
   113be:	4c 89 ff             	mov    %r15,%rdi
   113c1:	31 c0                	xor    %eax,%eax
   113c3:	e8 08 1e ff ff       	call   31d0 <snprintf@plt>
   113c8:	4c 89 ff             	mov    %r15,%rdi
   113cb:	e8 a0 1d ff ff       	call   3170 <strlen@plt>
   113d0:	48 89 ef             	mov    %rbp,%rdi
   113d3:	4c 89 fe             	mov    %r15,%rsi
   113d6:	48 89 c2             	mov    %rax,%rdx
   113d9:	e8 f2 bd ff ff       	call   d1d0 <buf_put>
   113de:	49 83 3e 02          	cmpq   $0x2,(%r14)
   113e2:	72 69                	jb     1144d <fwp_write+0x64d>
   113e4:	bb 09 00 00 00       	mov    $0x9,%ebx
   113e9:	4c 8d 3d bc 52 00 00 	lea    0x52bc(%rip),%r15        # 166ac <exec_in_fp0+0xe3c>
   113f0:	4c 8d 25 8a 53 00 00 	lea    0x538a(%rip),%r12        # 16781 <exec_in_fp0+0xf11>
   113f7:	4c 8d 6c 24 70       	lea    0x70(%rsp),%r13
   113fc:	0f 1f 40 00          	nopl   0x0(%rax)
   11400:	ba 02 00 00 00       	mov    $0x2,%edx
   11405:	48 89 ef             	mov    %rbp,%rdi
   11408:	4c 89 fe             	mov    %r15,%rsi
   1140b:	e8 c0 bd ff ff       	call   d1d0 <buf_put>
   11410:	41 0f b6 0c 1e       	movzbl (%r14,%rbx,1),%ecx
   11415:	be 00 02 00 00       	mov    $0x200,%esi
   1141a:	4c 89 ef             	mov    %r13,%rdi
   1141d:	4c 89 e2             	mov    %r12,%rdx
   11420:	31 c0                	xor    %eax,%eax
   11422:	e8 a9 1d ff ff       	call   31d0 <snprintf@plt>
   11427:	4c 89 ef             	mov    %r13,%rdi
   1142a:	e8 41 1d ff ff       	call   3170 <strlen@plt>
   1142f:	48 89 ef             	mov    %rbp,%rdi
   11432:	4c 89 ee             	mov    %r13,%rsi
   11435:	48 89 c2             	mov    %rax,%rdx
   11438:	e8 93 bd ff ff       	call   d1d0 <buf_put>
   1143d:	48 8d 43 01          	lea    0x1(%rbx),%rax
   11441:	48 83 c3 f9          	add    $0xfffffffffffffff9,%rbx
   11445:	49 3b 1e             	cmp    (%r14),%rbx
   11448:	48 89 c3             	mov    %rax,%rbx
   1144b:	72 b3                	jb     11400 <fwp_write+0x600>
   1144d:	c6 44 24 20 5d       	movb   $0x5d,0x20(%rsp)
   11452:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
   11457:	e9 90 0a 00 00       	jmp    11eec <fwp_write+0x10ec>
   1145c:	66 41 0f 6e ce       	movd   %r14d,%xmm1
   11461:	0f 2e c9             	ucomiss %xmm1,%xmm1
   11464:	0f 8a 73 0d 00 00    	jp     121dd <fwp_write+0x13dd>
   1146a:	0f 28 05 9f 3c 00 00 	movaps 0x3c9f(%rip),%xmm0        # 15110 <_IO_stdin_used+0x110>
   11471:	0f 54 c1             	andps  %xmm1,%xmm0
   11474:	0f 2e 05 89 3b 00 00 	ucomiss 0x3b89(%rip),%xmm0        # 15004 <_IO_stdin_used+0x4>
   1147b:	0f 82 6e 04 00 00    	jb     118ef <fwp_write+0xaef>
   11481:	0f 57 c0             	xorps  %xmm0,%xmm0
   11484:	0f 2e c8             	ucomiss %xmm0,%xmm1
   11487:	48 8d 05 52 52 00 00 	lea    0x5252(%rip),%rax        # 166e0 <exec_in_fp0+0xe70>
   1148e:	48 8d 35 4a 52 00 00 	lea    0x524a(%rip),%rsi        # 166df <exec_in_fp0+0xe6f>
   11495:	48 0f 47 f0          	cmova  %rax,%rsi
   11499:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   1149e:	e8 0d 1c ff ff       	call   30b0 <strcpy@plt>
   114a3:	e9 90 0b 00 00       	jmp    12038 <fwp_write+0x1238>
   114a8:	48 8d 35 b0 52 00 00 	lea    0x52b0(%rip),%rsi        # 1675f <exec_in_fp0+0xeef>
   114af:	ba 0a 00 00 00       	mov    $0xa,%edx
   114b4:	48 89 ef             	mov    %rbp,%rdi
   114b7:	e9 06 09 00 00       	jmp    11dc2 <fwp_write+0xfc2>
   114bc:	48 8d 35 b0 52 00 00 	lea    0x52b0(%rip),%rsi        # 16773 <exec_in_fp0+0xf03>
   114c3:	ba 06 00 00 00       	mov    $0x6,%edx
   114c8:	48 89 ef             	mov    %rbp,%rdi
   114cb:	e8 00 bd ff ff       	call   d1d0 <buf_put>
   114d0:	49 83 c6 10          	add    $0x10,%r14
   114d4:	4c 89 f7             	mov    %r14,%rdi
   114d7:	e8 94 1c ff ff       	call   3170 <strlen@plt>
   114dc:	48 89 ef             	mov    %rbp,%rdi
   114df:	4c 89 f6             	mov    %r14,%rsi
   114e2:	48 89 c2             	mov    %rax,%rdx
   114e5:	e8 e6 bc ff ff       	call   d1d0 <buf_put>
   114ea:	c6 44 24 70 3e       	movb   $0x3e,0x70(%rsp)
   114ef:	e9 f3 09 00 00       	jmp    11ee7 <fwp_write+0x10e7>
   114f4:	41 8b 06             	mov    (%r14),%eax
   114f7:	49 8b 4f 18          	mov    0x18(%r15),%rcx
   114fb:	41 89 c5             	mov    %eax,%r13d
   114fe:	4e 8b 24 e9          	mov    (%rcx,%r13,8),%r12
   11502:	4c 89 e7             	mov    %r12,%rdi
   11505:	e8 66 1c ff ff       	call   3170 <strlen@plt>
   1150a:	48 89 ef             	mov    %rbp,%rdi
   1150d:	4c 89 e6             	mov    %r12,%rsi
   11510:	48 89 c2             	mov    %rax,%rdx
   11513:	e8 b8 bc ff ff       	call   d1d0 <buf_put>
   11518:	49 8b 47 28          	mov    0x28(%r15),%rax
   1151c:	42 83 3c a8 00       	cmpl   $0x0,(%rax,%r13,4)
   11521:	0f 8e 2c 0b 00 00    	jle    12053 <fwp_write+0x1253>
   11527:	45 31 e4             	xor    %r12d,%r12d
   1152a:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
   1152f:	4c 89 6c 24 68       	mov    %r13,0x68(%rsp)
   11534:	eb 3c                	jmp    11572 <fwp_write+0x772>
   11536:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   1153d:	00 00 00 
   11540:	48 8b 2c 24          	mov    (%rsp),%rbp
   11544:	48 89 ef             	mov    %rbp,%rdi
   11547:	48 89 de             	mov    %rbx,%rsi
   1154a:	4c 89 ea             	mov    %r13,%rdx
   1154d:	31 c9                	xor    %ecx,%ecx
   1154f:	e8 ac f8 ff ff       	call   10e00 <fwp_write>
   11554:	49 ff c4             	inc    %r12
   11557:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
   1155c:	49 8b 47 28          	mov    0x28(%r15),%rax
   11560:	4c 8b 6c 24 68       	mov    0x68(%rsp),%r13
   11565:	4a 63 04 a8          	movslq (%rax,%r13,4),%rax
   11569:	49 39 c4             	cmp    %rax,%r12
   1156c:	0f 8d e1 0a 00 00    	jge    12053 <fwp_write+0x1253>
   11572:	4b 8b 5c e6 08       	mov    0x8(%r14,%r12,8),%rbx
   11577:	49 8b 47 30          	mov    0x30(%r15),%rax
   1157b:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
   1157f:	4e 8b 2c e0          	mov    (%rax,%r12,8),%r13
   11583:	c6 44 24 70 20       	movb   $0x20,0x70(%rsp)
   11588:	ba 01 00 00 00       	mov    $0x1,%edx
   1158d:	48 89 ef             	mov    %rbp,%rdi
   11590:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   11595:	e8 36 bc ff ff       	call   d1d0 <buf_put>
   1159a:	41 8b 45 00          	mov    0x0(%r13),%eax
   1159e:	48 83 f8 10          	cmp    $0x10,%rax
   115a2:	77 9c                	ja     11540 <fwp_write+0x740>
   115a4:	48 8d 0d b5 3f 00 00 	lea    0x3fb5(%rip),%rcx        # 15560 <_IO_stdin_used+0x560>
   115ab:	48 63 04 81          	movslq (%rcx,%rax,4),%rax
   115af:	48 01 c8             	add    %rcx,%rax
   115b2:	ff e0                	jmp    *%rax
   115b4:	48 89 d9             	mov    %rbx,%rcx
   115b7:	48 c1 e9 3f          	shr    $0x3f,%rcx
   115bb:	85 c9                	test   %ecx,%ecx
   115bd:	74 81                	je     11540 <fwp_write+0x740>
   115bf:	c6 44 24 70 28       	movb   $0x28,0x70(%rsp)
   115c4:	ba 01 00 00 00       	mov    $0x1,%edx
   115c9:	48 8b 2c 24          	mov    (%rsp),%rbp
   115cd:	48 89 ef             	mov    %rbp,%rdi
   115d0:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
   115d5:	4c 89 fe             	mov    %r15,%rsi
   115d8:	e8 f3 bb ff ff       	call   d1d0 <buf_put>
   115dd:	48 89 ef             	mov    %rbp,%rdi
   115e0:	48 89 de             	mov    %rbx,%rsi
   115e3:	4c 89 ea             	mov    %r13,%rdx
   115e6:	31 c9                	xor    %ecx,%ecx
   115e8:	e8 13 f8 ff ff       	call   10e00 <fwp_write>
   115ed:	c6 44 24 70 29       	movb   $0x29,0x70(%rsp)
   115f2:	ba 01 00 00 00       	mov    $0x1,%edx
   115f7:	48 89 ef             	mov    %rbp,%rdi
   115fa:	4c 89 fe             	mov    %r15,%rsi
   115fd:	e8 ce bb ff ff       	call   d1d0 <buf_put>
   11602:	e9 4d ff ff ff       	jmp    11554 <fwp_write+0x754>
   11607:	31 c9                	xor    %ecx,%ecx
   11609:	48 81 fb 00 10 00 00 	cmp    $0x1000,%rbx
   11610:	0f 93 c1             	setae  %cl
   11613:	eb a6                	jmp    115bb <fwp_write+0x7bb>
   11615:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
   11619:	eb 9c                	jmp    115b7 <fwp_write+0x7b7>
   1161b:	89 d9                	mov    %ebx,%ecx
   1161d:	c1 e9 1f             	shr    $0x1f,%ecx
   11620:	eb 99                	jmp    115bb <fwp_write+0x7bb>
   11622:	49 8b 7d 08          	mov    0x8(%r13),%rdi
   11626:	48 85 ff             	test   %rdi,%rdi
   11629:	0f 84 11 ff ff ff    	je     11540 <fwp_write+0x740>
   1162f:	48 8d 35 8f 50 00 00 	lea    0x508f(%rip),%rsi        # 166c5 <exec_in_fp0+0xe55>
   11636:	e8 95 1c ff ff       	call   32d0 <strcmp@plt>
   1163b:	31 c9                	xor    %ecx,%ecx
   1163d:	85 c0                	test   %eax,%eax
   1163f:	0f 95 c1             	setne  %cl
   11642:	e9 74 ff ff ff       	jmp    115bb <fwp_write+0x7bb>
   11647:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
   1164c:	0f 84 a7 08 00 00    	je     11ef9 <fwp_write+0x10f9>
   11652:	4d 8d 6f 10          	lea    0x10(%r15),%r13
   11656:	4d 85 e4             	test   %r12,%r12
   11659:	0f 94 c0             	sete   %al
   1165c:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
   11661:	0f 95 c3             	setne  %bl
   11664:	20 c3                	and    %al,%bl
   11666:	84 db                	test   %bl,%bl
   11668:	b8 28 00 00 00       	mov    $0x28,%eax
   1166d:	b9 7b 00 00 00       	mov    $0x7b,%ecx
   11672:	0f 45 c8             	cmovne %eax,%ecx
   11675:	88 4c 24 70          	mov    %cl,0x70(%rsp)
   11679:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   1167e:	ba 01 00 00 00       	mov    $0x1,%edx
   11683:	48 89 ef             	mov    %rbp,%rdi
   11686:	e8 45 bb ff ff       	call   d1d0 <buf_put>
   1168b:	41 83 7d 00 00       	cmpl   $0x0,0x0(%r13)
   11690:	0f 8e da 00 00 00    	jle    11770 <fwp_write+0x970>
   11696:	84 db                	test   %bl,%bl
   11698:	75 31                	jne    116cb <fwp_write+0x8cb>
   1169a:	49 8b 47 18          	mov    0x18(%r15),%rax
   1169e:	4c 8b 20             	mov    (%rax),%r12
   116a1:	4c 89 e7             	mov    %r12,%rdi
   116a4:	e8 c7 1a ff ff       	call   3170 <strlen@plt>
   116a9:	48 89 ef             	mov    %rbp,%rdi
   116ac:	4c 89 e6             	mov    %r12,%rsi
   116af:	48 89 c2             	mov    %rax,%rdx
   116b2:	e8 19 bb ff ff       	call   d1d0 <buf_put>
   116b7:	48 8d 35 da 50 00 00 	lea    0x50da(%rip),%rsi        # 16798 <exec_in_fp0+0xf28>
   116be:	ba 03 00 00 00       	mov    $0x3,%edx
   116c3:	48 89 ef             	mov    %rbp,%rdi
   116c6:	e8 05 bb ff ff       	call   d1d0 <buf_put>
   116cb:	49 8b 76 08          	mov    0x8(%r14),%rsi
   116cf:	49 8b 47 20          	mov    0x20(%r15),%rax
   116d3:	48 8b 10             	mov    (%rax),%rdx
   116d6:	48 89 ef             	mov    %rbp,%rdi
   116d9:	31 c9                	xor    %ecx,%ecx
   116db:	e8 20 f7 ff ff       	call   10e00 <fwp_write>
   116e0:	41 83 7f 10 02       	cmpl   $0x2,0x10(%r15)
   116e5:	0f 8c 85 00 00 00    	jl     11770 <fwp_write+0x970>
   116eb:	41 bd 01 00 00 00    	mov    $0x1,%r13d
   116f1:	4c 8d 25 b4 4f 00 00 	lea    0x4fb4(%rip),%r12        # 166ac <exec_in_fp0+0xe3c>
   116f8:	eb 29                	jmp    11723 <fwp_write+0x923>
   116fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   11700:	4b 8b 74 ee 08       	mov    0x8(%r14,%r13,8),%rsi
   11705:	49 8b 47 20          	mov    0x20(%r15),%rax
   11709:	4a 8b 14 e8          	mov    (%rax,%r13,8),%rdx
   1170d:	48 89 ef             	mov    %rbp,%rdi
   11710:	31 c9                	xor    %ecx,%ecx
   11712:	e8 e9 f6 ff ff       	call   10e00 <fwp_write>
   11717:	49 ff c5             	inc    %r13
   1171a:	49 63 47 10          	movslq 0x10(%r15),%rax
   1171e:	49 39 c5             	cmp    %rax,%r13
   11721:	7d 4d                	jge    11770 <fwp_write+0x970>
   11723:	ba 02 00 00 00       	mov    $0x2,%edx
   11728:	48 89 ef             	mov    %rbp,%rdi
   1172b:	4c 89 e6             	mov    %r12,%rsi
   1172e:	e8 9d ba ff ff       	call   d1d0 <buf_put>
   11733:	84 db                	test   %bl,%bl
   11735:	75 c9                	jne    11700 <fwp_write+0x900>
   11737:	49 8b 47 18          	mov    0x18(%r15),%rax
   1173b:	4a 8b 2c e8          	mov    (%rax,%r13,8),%rbp
   1173f:	48 89 ef             	mov    %rbp,%rdi
   11742:	e8 29 1a ff ff       	call   3170 <strlen@plt>
   11747:	48 8b 3c 24          	mov    (%rsp),%rdi
   1174b:	48 89 ee             	mov    %rbp,%rsi
   1174e:	48 8b 2c 24          	mov    (%rsp),%rbp
   11752:	48 89 c2             	mov    %rax,%rdx
   11755:	e8 76 ba ff ff       	call   d1d0 <buf_put>
   1175a:	ba 03 00 00 00       	mov    $0x3,%edx
   1175f:	48 89 ef             	mov    %rbp,%rdi
   11762:	48 8d 35 2f 50 00 00 	lea    0x502f(%rip),%rsi        # 16798 <exec_in_fp0+0xf28>
   11769:	e8 62 ba ff ff       	call   d1d0 <buf_put>
   1176e:	eb 90                	jmp    11700 <fwp_write+0x900>
   11770:	84 db                	test   %bl,%bl
   11772:	b8 29 00 00 00       	mov    $0x29,%eax
   11777:	b9 7d 00 00 00       	mov    $0x7d,%ecx
   1177c:	0f 45 c8             	cmovne %eax,%ecx
   1177f:	88 4c 24 70          	mov    %cl,0x70(%rsp)
   11783:	e9 5f 07 00 00       	jmp    11ee7 <fwp_write+0x10e7>
   11788:	48 89 ef             	mov    %rbp,%rdi
   1178b:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
   11792:	5b                   	pop    %rbx
   11793:	41 5c                	pop    %r12
   11795:	41 5d                	pop    %r13
   11797:	41 5e                	pop    %r14
   11799:	41 5f                	pop    %r15
   1179b:	5d                   	pop    %rbp
   1179c:	e9 4f 0a 00 00       	jmp    121f0 <fwp_escape>
   117a1:	c6 44 24 20 30       	movb   $0x30,0x20(%rsp)
   117a6:	bf 01 00 00 00       	mov    $0x1,%edi
   117ab:	89 f8                	mov    %edi,%eax
   117ad:	48 83 f8 08          	cmp    $0x8,%rax
   117b1:	73 0a                	jae    117bd <fwp_write+0x9bd>
   117b3:	31 c9                	xor    %ecx,%ecx
   117b5:	48 89 c2             	mov    %rax,%rdx
   117b8:	e9 7a 04 00 00       	jmp    11c37 <fwp_write+0xe37>
   117bd:	83 f8 20             	cmp    $0x20,%eax
   117c0:	0f 83 68 03 00 00    	jae    11b2e <fwp_write+0xd2e>
   117c6:	31 c9                	xor    %ecx,%ecx
   117c8:	e9 10 04 00 00       	jmp    11bdd <fwp_write+0xddd>
   117cd:	31 ff                	xor    %edi,%edi
   117cf:	49 f7 d8             	neg    %r8
   117d2:	41 ba 00 00 00 00    	mov    $0x0,%r10d
   117d8:	4d 19 ca             	sbb    %r9,%r10
   117db:	c6 44 24 70 2d       	movb   $0x2d,0x70(%rsp)
   117e0:	49 b9 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r9
   117e7:	cc cc cc 
   117ea:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
   117f1:	cc cc cc 
   117f4:	4c 89 d3             	mov    %r10,%rbx
   117f7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   117fe:	00 00 
   11800:	4c 89 d1             	mov    %r10,%rcx
   11803:	4c 0f a4 c1 3f       	shld   $0x3f,%r8,%rcx
   11808:	48 d1 eb             	shr    $1,%rbx
   1180b:	48 89 ce             	mov    %rcx,%rsi
   1180e:	48 01 de             	add    %rbx,%rsi
   11811:	48 83 d6 00          	adc    $0x0,%rsi
   11815:	48 89 f0             	mov    %rsi,%rax
   11818:	49 f7 e1             	mul    %r9
   1181b:	48 c1 ea 02          	shr    $0x2,%rdx
   1181f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   11823:	48 29 c6             	sub    %rax,%rsi
   11826:	48 29 f1             	sub    %rsi,%rcx
   11829:	48 83 db 00          	sbb    $0x0,%rbx
   1182d:	48 89 ce             	mov    %rcx,%rsi
   11830:	49 0f af f3          	imul   %r11,%rsi
   11834:	48 89 c8             	mov    %rcx,%rax
   11837:	49 f7 e1             	mul    %r9
   1183a:	48 01 f2             	add    %rsi,%rdx
   1183d:	49 0f af d9          	imul   %r9,%rbx
   11841:	48 01 d3             	add    %rdx,%rbx
   11844:	48 89 c1             	mov    %rax,%rcx
   11847:	48 01 c1             	add    %rax,%rcx
   1184a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
   1184e:	44 89 c2             	mov    %r8d,%edx
   11851:	29 ca                	sub    %ecx,%edx
   11853:	80 ca 30             	or     $0x30,%dl
   11856:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
   1185a:	48 ff c7             	inc    %rdi
   1185d:	49 83 f8 0a          	cmp    $0xa,%r8
   11861:	49 83 da 00          	sbb    $0x0,%r10
   11865:	49 89 c0             	mov    %rax,%r8
   11868:	49 89 da             	mov    %rbx,%r10
   1186b:	73 93                	jae    11800 <fwp_write+0xa00>
   1186d:	85 ff                	test   %edi,%edi
   1186f:	0f 8e 98 06 00 00    	jle    11f0d <fwp_write+0x110d>
   11875:	89 f8                	mov    %edi,%eax
   11877:	48 83 f8 08          	cmp    $0x8,%rax
   1187b:	0f 83 e4 07 00 00    	jae    12065 <fwp_write+0x1265>
   11881:	31 c9                	xor    %ecx,%ecx
   11883:	48 89 c2             	mov    %rax,%rdx
   11886:	e9 fc 08 00 00       	jmp    12187 <fwp_write+0x1387>
   1188b:	bd 01 00 00 00       	mov    $0x1,%ebp
   11890:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11895:	0f 29 4c 24 10       	movaps %xmm1,0x10(%rsp)
   1189a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   118a0:	4c 89 f7             	mov    %r14,%rdi
   118a3:	66 0f 28 c1          	movapd %xmm1,%xmm0
   118a7:	89 ee                	mov    %ebp,%esi
   118a9:	e8 b2 15 00 00       	call   12e60 <fwp_format_g>
   118ae:	4c 89 f7             	mov    %r14,%rdi
   118b1:	31 f6                	xor    %esi,%esi
   118b3:	e8 48 18 ff ff       	call   3100 <strtod@plt>
   118b8:	66 0f 28 4c 24 10    	movapd 0x10(%rsp),%xmm1
   118be:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
   118c2:	75 06                	jne    118ca <fwp_write+0xaca>
   118c4:	0f 8b 9e 03 00 00    	jnp    11c68 <fwp_write+0xe68>
   118ca:	ff c5                	inc    %ebp
   118cc:	83 fd 12             	cmp    $0x12,%ebp
   118cf:	75 cf                	jne    118a0 <fwp_write+0xaa0>
   118d1:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   118d6:	4c 89 f7             	mov    %r14,%rdi
   118d9:	66 0f 28 c1          	movapd %xmm1,%xmm0
   118dd:	be 11 00 00 00       	mov    $0x11,%esi
   118e2:	e8 79 15 00 00       	call   12e60 <fwp_format_g>
   118e7:	4c 89 f7             	mov    %r14,%rdi
   118ea:	e9 7e 03 00 00       	jmp    11c6d <fwp_write+0xe6d>
   118ef:	0f 57 c0             	xorps  %xmm0,%xmm0
   118f2:	f3 0f 5a c1          	cvtss2sd %xmm1,%xmm0
   118f6:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   118fb:	4c 89 f7             	mov    %r14,%rdi
   118fe:	f2 0f 11 44 24 10    	movsd  %xmm0,0x10(%rsp)
   11904:	be 01 00 00 00       	mov    $0x1,%esi
   11909:	0f 29 0c 24          	movaps %xmm1,(%rsp)
   1190d:	e8 4e 15 00 00       	call   12e60 <fwp_format_g>
   11912:	4c 89 f7             	mov    %r14,%rdi
   11915:	31 f6                	xor    %esi,%esi
   11917:	e8 e4 18 ff ff       	call   3200 <strtof@plt>
   1191c:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   11920:	75 06                	jne    11928 <fwp_write+0xb28>
   11922:	0f 8b 6f 01 00 00    	jnp    11a97 <fwp_write+0xc97>
   11928:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   1192d:	4c 89 f7             	mov    %r14,%rdi
   11930:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   11936:	be 02 00 00 00       	mov    $0x2,%esi
   1193b:	e8 20 15 00 00       	call   12e60 <fwp_format_g>
   11940:	4c 89 f7             	mov    %r14,%rdi
   11943:	31 f6                	xor    %esi,%esi
   11945:	e8 b6 18 ff ff       	call   3200 <strtof@plt>
   1194a:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   1194e:	75 06                	jne    11956 <fwp_write+0xb56>
   11950:	0f 8b 41 01 00 00    	jnp    11a97 <fwp_write+0xc97>
   11956:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   1195b:	4c 89 f7             	mov    %r14,%rdi
   1195e:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   11964:	be 03 00 00 00       	mov    $0x3,%esi
   11969:	e8 f2 14 00 00       	call   12e60 <fwp_format_g>
   1196e:	4c 89 f7             	mov    %r14,%rdi
   11971:	31 f6                	xor    %esi,%esi
   11973:	e8 88 18 ff ff       	call   3200 <strtof@plt>
   11978:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   1197c:	75 06                	jne    11984 <fwp_write+0xb84>
   1197e:	0f 8b 13 01 00 00    	jnp    11a97 <fwp_write+0xc97>
   11984:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11989:	4c 89 f7             	mov    %r14,%rdi
   1198c:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   11992:	be 04 00 00 00       	mov    $0x4,%esi
   11997:	e8 c4 14 00 00       	call   12e60 <fwp_format_g>
   1199c:	4c 89 f7             	mov    %r14,%rdi
   1199f:	31 f6                	xor    %esi,%esi
   119a1:	e8 5a 18 ff ff       	call   3200 <strtof@plt>
   119a6:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   119aa:	75 06                	jne    119b2 <fwp_write+0xbb2>
   119ac:	0f 8b e5 00 00 00    	jnp    11a97 <fwp_write+0xc97>
   119b2:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   119b7:	4c 89 f7             	mov    %r14,%rdi
   119ba:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   119c0:	be 05 00 00 00       	mov    $0x5,%esi
   119c5:	e8 96 14 00 00       	call   12e60 <fwp_format_g>
   119ca:	4c 89 f7             	mov    %r14,%rdi
   119cd:	31 f6                	xor    %esi,%esi
   119cf:	e8 2c 18 ff ff       	call   3200 <strtof@plt>
   119d4:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   119d8:	75 06                	jne    119e0 <fwp_write+0xbe0>
   119da:	0f 8b b7 00 00 00    	jnp    11a97 <fwp_write+0xc97>
   119e0:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   119e5:	4c 89 f7             	mov    %r14,%rdi
   119e8:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   119ee:	be 06 00 00 00       	mov    $0x6,%esi
   119f3:	e8 68 14 00 00       	call   12e60 <fwp_format_g>
   119f8:	4c 89 f7             	mov    %r14,%rdi
   119fb:	31 f6                	xor    %esi,%esi
   119fd:	e8 fe 17 ff ff       	call   3200 <strtof@plt>
   11a02:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   11a06:	75 06                	jne    11a0e <fwp_write+0xc0e>
   11a08:	0f 8b 89 00 00 00    	jnp    11a97 <fwp_write+0xc97>
   11a0e:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11a13:	4c 89 f7             	mov    %r14,%rdi
   11a16:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   11a1c:	be 07 00 00 00       	mov    $0x7,%esi
   11a21:	e8 3a 14 00 00       	call   12e60 <fwp_format_g>
   11a26:	4c 89 f7             	mov    %r14,%rdi
   11a29:	31 f6                	xor    %esi,%esi
   11a2b:	e8 d0 17 ff ff       	call   3200 <strtof@plt>
   11a30:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   11a34:	75 02                	jne    11a38 <fwp_write+0xc38>
   11a36:	7b 5f                	jnp    11a97 <fwp_write+0xc97>
   11a38:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11a3d:	4c 89 f7             	mov    %r14,%rdi
   11a40:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   11a46:	be 08 00 00 00       	mov    $0x8,%esi
   11a4b:	e8 10 14 00 00       	call   12e60 <fwp_format_g>
   11a50:	4c 89 f7             	mov    %r14,%rdi
   11a53:	31 f6                	xor    %esi,%esi
   11a55:	e8 a6 17 ff ff       	call   3200 <strtof@plt>
   11a5a:	0f 28 0c 24          	movaps (%rsp),%xmm1
   11a5e:	0f 2e c1             	ucomiss %xmm1,%xmm0
   11a61:	75 02                	jne    11a65 <fwp_write+0xc65>
   11a63:	7b 32                	jnp    11a97 <fwp_write+0xc97>
   11a65:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11a6a:	4c 89 f7             	mov    %r14,%rdi
   11a6d:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   11a73:	be 09 00 00 00       	mov    $0x9,%esi
   11a78:	e8 e3 13 00 00       	call   12e60 <fwp_format_g>
   11a7d:	4c 89 f7             	mov    %r14,%rdi
   11a80:	31 f6                	xor    %esi,%esi
   11a82:	e8 79 17 ff ff       	call   3200 <strtof@plt>
   11a87:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   11a8b:	0f 85 2c 07 00 00    	jne    121bd <fwp_write+0x13bd>
   11a91:	0f 8a 26 07 00 00    	jp     121bd <fwp_write+0x13bd>
   11a97:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   11a9c:	be 2e 00 00 00       	mov    $0x2e,%esi
   11aa1:	e8 0a 17 ff ff       	call   31b0 <strchr@plt>
   11aa6:	48 85 c0             	test   %rax,%rax
   11aa9:	0f 85 89 05 00 00    	jne    12038 <fwp_write+0x1238>
   11aaf:	e9 d0 01 00 00       	jmp    11c84 <fwp_write+0xe84>
   11ab4:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
   11abb:	00 
   11abc:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
   11ac3:	00 
   11ac4:	4c 29 ff             	sub    %r15,%rdi
   11ac7:	48 39 cf             	cmp    %rcx,%rdi
   11aca:	0f 83 1b 02 00 00    	jae    11ceb <fwp_write+0xeeb>
   11ad0:	48 89 d7             	mov    %rdx,%rdi
   11ad3:	be 01 00 00 00       	mov    $0x1,%esi
   11ad8:	e8 a3 67 ff ff       	call   8280 <fwp_gc_alloc_slow>
   11add:	49 89 c7             	mov    %rax,%r15
   11ae0:	e9 20 02 00 00       	jmp    11d05 <fwp_write+0xf05>
   11ae5:	49 8b 76 08          	mov    0x8(%r14),%rsi
   11ae9:	48 89 f2             	mov    %rsi,%rdx
   11aec:	48 c1 fa 3f          	sar    $0x3f,%rdx
   11af0:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11af5:	4c 89 f7             	mov    %r14,%rdi
   11af8:	e8 33 08 00 00       	call   12330 <fwp_fmt_duration>
   11afd:	e9 3b 05 00 00       	jmp    1203d <fwp_write+0x123d>
   11b02:	c6 44 24 20 30       	movb   $0x30,0x20(%rsp)
   11b07:	bf 01 00 00 00       	mov    $0x1,%edi
   11b0c:	89 f8                	mov    %edi,%eax
   11b0e:	48 83 f8 08          	cmp    $0x8,%rax
   11b12:	73 0a                	jae    11b1e <fwp_write+0xd1e>
   11b14:	31 c9                	xor    %ecx,%ecx
   11b16:	48 89 c2             	mov    %rax,%rdx
   11b19:	e9 f2 04 00 00       	jmp    12010 <fwp_write+0x1210>
   11b1e:	83 f8 20             	cmp    $0x20,%eax
   11b21:	0f 83 f2 03 00 00    	jae    11f19 <fwp_write+0x1119>
   11b27:	31 c9                	xor    %ecx,%ecx
   11b29:	e9 92 04 00 00       	jmp    11fc0 <fwp_write+0x11c0>
   11b2e:	89 fa                	mov    %edi,%edx
   11b30:	83 e2 1f             	and    $0x1f,%edx
   11b33:	48 89 c1             	mov    %rax,%rcx
   11b36:	48 29 d1             	sub    %rdx,%rcx
   11b39:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
   11b40:	00 
   11b41:	66 0f ef c0          	pxor   %xmm0,%xmm0
   11b45:	49 89 c0             	mov    %rax,%r8
   11b48:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   11b4f:	00 
   11b50:	f3 42 0f 6f 0c 04    	movdqu (%rsp,%r8,1),%xmm1
   11b56:	f3 42 0f 6f 54 04 10 	movdqu 0x10(%rsp,%r8,1),%xmm2
   11b5d:	66 0f 6f da          	movdqa %xmm2,%xmm3
   11b61:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   11b65:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   11b6a:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   11b6f:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   11b74:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   11b78:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   11b7d:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   11b82:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   11b87:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   11b8b:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   11b8f:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   11b93:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   11b98:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   11b9d:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   11ba2:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   11ba6:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   11bab:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   11bb0:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   11bb5:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   11bb9:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
   11bbe:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
   11bc2:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
   11bc6:	48 83 c6 20          	add    $0x20,%rsi
   11bca:	4c 39 c2             	cmp    %r8,%rdx
   11bcd:	75 81                	jne    11b50 <fwp_write+0xd50>
   11bcf:	48 85 d2             	test   %rdx,%rdx
   11bd2:	0f 84 5b 04 00 00    	je     12033 <fwp_write+0x1233>
   11bd8:	83 fa 08             	cmp    $0x8,%edx
   11bdb:	72 5a                	jb     11c37 <fwp_write+0xe37>
   11bdd:	89 fa                	mov    %edi,%edx
   11bdf:	83 e2 07             	and    $0x7,%edx
   11be2:	48 89 c6             	mov    %rax,%rsi
   11be5:	48 29 ce             	sub    %rcx,%rsi
   11be8:	48 8d 3c 0c          	lea    (%rsp,%rcx,1),%rdi
   11bec:	48 83 c7 70          	add    $0x70,%rdi
   11bf0:	48 89 c1             	mov    %rax,%rcx
   11bf3:	48 29 d1             	sub    %rdx,%rcx
   11bf6:	66 0f ef c0          	pxor   %xmm0,%xmm0
   11bfa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   11c00:	f3 0f 7e 4c 34 18    	movq   0x18(%rsp,%rsi,1),%xmm1
   11c06:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   11c0a:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   11c0f:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   11c14:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   11c19:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   11c1d:	66 0f d6 0f          	movq   %xmm1,(%rdi)
   11c21:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
   11c25:	48 83 c7 08          	add    $0x8,%rdi
   11c29:	48 39 f2             	cmp    %rsi,%rdx
   11c2c:	75 d2                	jne    11c00 <fwp_write+0xe00>
   11c2e:	48 85 d2             	test   %rdx,%rdx
   11c31:	0f 84 fc 03 00 00    	je     12033 <fwp_write+0x1233>
   11c37:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
   11c3c:	48 01 f2             	add    %rsi,%rdx
   11c3f:	48 ff ca             	dec    %rdx
   11c42:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   11c49:	1f 84 00 00 00 00 00 
   11c50:	0f b6 32             	movzbl (%rdx),%esi
   11c53:	40 88 74 0c 70       	mov    %sil,0x70(%rsp,%rcx,1)
   11c58:	48 ff c1             	inc    %rcx
   11c5b:	48 ff ca             	dec    %rdx
   11c5e:	48 39 c8             	cmp    %rcx,%rax
   11c61:	75 ed                	jne    11c50 <fwp_write+0xe50>
   11c63:	e9 cb 03 00 00       	jmp    12033 <fwp_write+0x1233>
   11c68:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   11c6d:	be 2e 00 00 00       	mov    $0x2e,%esi
   11c72:	e8 39 15 ff ff       	call   31b0 <strchr@plt>
   11c77:	48 85 c0             	test   %rax,%rax
   11c7a:	48 8b 2c 24          	mov    (%rsp),%rbp
   11c7e:	0f 85 b4 03 00 00    	jne    12038 <fwp_write+0x1238>
   11c84:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   11c89:	be 65 00 00 00       	mov    $0x65,%esi
   11c8e:	e8 1d 15 ff ff       	call   31b0 <strchr@plt>
   11c93:	48 85 c0             	test   %rax,%rax
   11c96:	0f 85 9c 03 00 00    	jne    12038 <fwp_write+0x1238>
   11c9c:	48 8d 35 3d 4a 00 00 	lea    0x4a3d(%rip),%rsi        # 166e0 <exec_in_fp0+0xe70>
   11ca3:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   11ca8:	e8 23 18 ff ff       	call   34d0 <strstr@plt>
   11cad:	48 85 c0             	test   %rax,%rax
   11cb0:	0f 85 82 03 00 00    	jne    12038 <fwp_write+0x1238>
   11cb6:	48 8d 35 27 4a 00 00 	lea    0x4a27(%rip),%rsi        # 166e4 <exec_in_fp0+0xe74>
   11cbd:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   11cc2:	e8 09 18 ff ff       	call   34d0 <strstr@plt>
   11cc7:	48 85 c0             	test   %rax,%rax
   11cca:	0f 85 68 03 00 00    	jne    12038 <fwp_write+0x1238>
   11cd0:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   11cd5:	e8 96 14 ff ff       	call   3170 <strlen@plt>
   11cda:	66 c7 44 04 70 2e 30 	movw   $0x302e,0x70(%rsp,%rax,1)
   11ce1:	c6 44 04 72 00       	movb   $0x0,0x72(%rsp,%rax,1)
   11ce6:	e9 4d 03 00 00       	jmp    12038 <fwp_write+0x1238>
   11ceb:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
   11cef:	48 05 d0 03 00 00    	add    $0x3d0,%rax
   11cf5:	4c 01 f9             	add    %r15,%rcx
   11cf8:	48 89 08             	mov    %rcx,(%rax)
   11cfb:	4c 89 ff             	mov    %r15,%rdi
   11cfe:	31 f6                	xor    %esi,%esi
   11d00:	e8 0b 15 ff ff       	call   3210 <memset@plt>
   11d05:	66 41 c7 07 30 74    	movw   $0x7430,(%r15)
   11d0b:	85 db                	test   %ebx,%ebx
   11d0d:	0f 8e 98 00 00 00    	jle    11dab <fwp_write+0xfab>
   11d13:	44 89 e1             	mov    %r12d,%ecx
   11d16:	48 f7 d9             	neg    %rcx
   11d19:	4a 8d 34 3b          	lea    (%rbx,%r15,1),%rsi
   11d1d:	48 ff c6             	inc    %rsi
   11d20:	31 ff                	xor    %edi,%edi
   11d22:	49 b8 56 55 55 55 55 	movabs $0x5555555555555556,%r8
   11d29:	55 55 55 
   11d2c:	eb 2e                	jmp    11d5c <fwp_write+0xf5c>
   11d2e:	66 90                	xchg   %ax,%ax
   11d30:	41 b2 30             	mov    $0x30,%r10b
   11d33:	44 88 14 3e          	mov    %r10b,(%rsi,%rdi,1)
   11d37:	48 85 d2             	test   %rdx,%rdx
   11d3a:	0f 95 c2             	setne  %dl
   11d3d:	4d 85 f6             	test   %r14,%r14
   11d40:	41 0f 98 c2          	sets   %r10b
   11d44:	41 20 d2             	and    %dl,%r10b
   11d47:	41 0f b6 d2          	movzbl %r10b,%edx
   11d4b:	48 29 d0             	sub    %rdx,%rax
   11d4e:	4c 01 c8             	add    %r9,%rax
   11d51:	48 ff cf             	dec    %rdi
   11d54:	49 89 c6             	mov    %rax,%r14
   11d57:	48 39 f9             	cmp    %rdi,%rcx
   11d5a:	74 4f                	je     11dab <fwp_write+0xfab>
   11d5c:	4c 89 f0             	mov    %r14,%rax
   11d5f:	49 f7 e8             	imul   %r8
   11d62:	48 89 d0             	mov    %rdx,%rax
   11d65:	48 c1 e8 3f          	shr    $0x3f,%rax
   11d69:	48 01 d0             	add    %rdx,%rax
   11d6c:	4c 8d 0c 40          	lea    (%rax,%rax,2),%r9
   11d70:	4c 89 f2             	mov    %r14,%rdx
   11d73:	4c 29 ca             	sub    %r9,%rdx
   11d76:	49 f7 d9             	neg    %r9
   11d79:	4d 01 f1             	add    %r14,%r9
   11d7c:	49 83 c1 03          	add    $0x3,%r9
   11d80:	48 83 fa fd          	cmp    $0xfffffffffffffffd,%rdx
   11d84:	4c 0f 42 ca          	cmovb  %rdx,%r9
   11d88:	4d 85 c9             	test   %r9,%r9
   11d8b:	74 a3                	je     11d30 <fwp_write+0xf30>
   11d8d:	49 83 f9 01          	cmp    $0x1,%r9
   11d91:	75 0d                	jne    11da0 <fwp_write+0xfa0>
   11d93:	41 b2 2b             	mov    $0x2b,%r10b
   11d96:	45 31 c9             	xor    %r9d,%r9d
   11d99:	eb 98                	jmp    11d33 <fwp_write+0xf33>
   11d9b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   11da0:	41 b2 2d             	mov    $0x2d,%r10b
   11da3:	41 b9 01 00 00 00    	mov    $0x1,%r9d
   11da9:	eb 88                	jmp    11d33 <fwp_write+0xf33>
   11dab:	43 c6 44 27 02 00    	movb   $0x0,0x2(%r15,%r12,1)
   11db1:	4c 89 ff             	mov    %r15,%rdi
   11db4:	e8 b7 13 ff ff       	call   3170 <strlen@plt>
   11db9:	48 89 ef             	mov    %rbp,%rdi
   11dbc:	4c 89 fe             	mov    %r15,%rsi
   11dbf:	48 89 c2             	mov    %rax,%rdx
   11dc2:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
   11dc9:	5b                   	pop    %rbx
   11dca:	41 5c                	pop    %r12
   11dcc:	41 5d                	pop    %r13
   11dce:	41 5e                	pop    %r14
   11dd0:	41 5f                	pop    %r15
   11dd2:	5d                   	pop    %rbp
   11dd3:	e9 f8 b3 ff ff       	jmp    d1d0 <buf_put>
   11dd8:	48 8b 31             	mov    (%rcx),%rsi
   11ddb:	eb 18                	jmp    11df5 <fwp_write+0xff5>
   11ddd:	83 3a 00             	cmpl   $0x0,(%rdx)
   11de0:	0f b6 01             	movzbl (%rcx),%eax
   11de3:	48 0f be f0          	movsbq %al,%rsi
   11de7:	eb 08                	jmp    11df1 <fwp_write+0xff1>
   11de9:	83 3a 02             	cmpl   $0x2,(%rdx)
   11dec:	8b 01                	mov    (%rcx),%eax
   11dee:	48 63 f0             	movslq %eax,%rsi
   11df1:	48 0f 45 f0          	cmovne %rax,%rsi
   11df5:	48 8b 2c 24          	mov    (%rsp),%rbp
   11df9:	48 89 ef             	mov    %rbp,%rdi
   11dfc:	31 c9                	xor    %ecx,%ecx
   11dfe:	e8 fd ef ff ff       	call   10e00 <fwp_write>
   11e03:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
   11e0a:	ff ff 7f 
   11e0d:	48 ff c8             	dec    %rax
   11e10:	49 85 06             	test   %rax,(%r14)
   11e13:	0f 84 c9 00 00 00    	je     11ee2 <fwp_write+0x10e2>
   11e19:	bb 01 00 00 00       	mov    $0x1,%ebx
   11e1e:	4c 8d 25 87 48 00 00 	lea    0x4887(%rip),%r12        # 166ac <exec_in_fp0+0xe3c>
   11e25:	eb 39                	jmp    11e60 <fwp_write+0x1060>
   11e27:	83 3a 01             	cmpl   $0x1,(%rdx)
   11e2a:	0f b7 04 31          	movzwl (%rcx,%rsi,1),%eax
   11e2e:	48 0f bf f0          	movswq %ax,%rsi
   11e32:	48 0f 45 f0          	cmovne %rax,%rsi
   11e36:	48 8b 2c 24          	mov    (%rsp),%rbp
   11e3a:	48 89 ef             	mov    %rbp,%rdi
   11e3d:	31 c9                	xor    %ecx,%ecx
   11e3f:	e8 bc ef ff ff       	call   10e00 <fwp_write>
   11e44:	48 ff c3             	inc    %rbx
   11e47:	49 8b 06             	mov    (%r14),%rax
   11e4a:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
   11e51:	ff ff 7f 
   11e54:	48 21 c8             	and    %rcx,%rax
   11e57:	48 39 c3             	cmp    %rax,%rbx
   11e5a:	0f 83 82 00 00 00    	jae    11ee2 <fwp_write+0x10e2>
   11e60:	ba 02 00 00 00       	mov    $0x2,%edx
   11e65:	48 89 ef             	mov    %rbp,%rdi
   11e68:	4c 89 e6             	mov    %r12,%rsi
   11e6b:	e8 60 b3 ff ff       	call   d1d0 <buf_put>
   11e70:	49 8b 57 38          	mov    0x38(%r15),%rdx
   11e74:	b8 08 00 00 00       	mov    $0x8,%eax
   11e79:	48 85 d2             	test   %rdx,%rdx
   11e7c:	74 13                	je     11e91 <fwp_write+0x1091>
   11e7e:	8b 0a                	mov    (%rdx),%ecx
   11e80:	48 83 f9 0a          	cmp    $0xa,%rcx
   11e84:	77 0b                	ja     11e91 <fwp_write+0x1091>
   11e86:	48 8d 05 63 3a 00 00 	lea    0x3a63(%rip),%rax        # 158f0 <exec_in_fp0+0x80>
   11e8d:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
   11e91:	49 83 3e 00          	cmpq   $0x0,(%r14)
   11e95:	4c 89 e9             	mov    %r13,%rcx
   11e98:	79 04                	jns    11e9e <fwp_write+0x109e>
   11e9a:	49 8b 4e 10          	mov    0x10(%r14),%rcx
   11e9e:	48 89 c6             	mov    %rax,%rsi
   11ea1:	48 0f af f3          	imul   %rbx,%rsi
   11ea5:	48 83 f8 01          	cmp    $0x1,%rax
   11ea9:	74 19                	je     11ec4 <fwp_write+0x10c4>
   11eab:	48 83 f8 02          	cmp    $0x2,%rax
   11eaf:	0f 84 72 ff ff ff    	je     11e27 <fwp_write+0x1027>
   11eb5:	48 83 f8 08          	cmp    $0x8,%rax
   11eb9:	75 19                	jne    11ed4 <fwp_write+0x10d4>
   11ebb:	48 8b 34 31          	mov    (%rcx,%rsi,1),%rsi
   11ebf:	e9 72 ff ff ff       	jmp    11e36 <fwp_write+0x1036>
   11ec4:	83 3a 00             	cmpl   $0x0,(%rdx)
   11ec7:	0f b6 04 31          	movzbl (%rcx,%rsi,1),%eax
   11ecb:	48 0f be f0          	movsbq %al,%rsi
   11ecf:	e9 5e ff ff ff       	jmp    11e32 <fwp_write+0x1032>
   11ed4:	83 3a 02             	cmpl   $0x2,(%rdx)
   11ed7:	8b 04 31             	mov    (%rcx,%rsi,1),%eax
   11eda:	48 63 f0             	movslq %eax,%rsi
   11edd:	e9 50 ff ff ff       	jmp    11e32 <fwp_write+0x1032>
   11ee2:	c6 44 24 70 5d       	movb   $0x5d,0x70(%rsp)
   11ee7:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   11eec:	ba 01 00 00 00       	mov    $0x1,%edx
   11ef1:	48 89 ef             	mov    %rbp,%rdi
   11ef4:	e9 55 01 00 00       	jmp    1204e <fwp_write+0x124e>
   11ef9:	48 8d 35 95 48 00 00 	lea    0x4895(%rip),%rsi        # 16795 <exec_in_fp0+0xf25>
   11f00:	ba 02 00 00 00       	mov    $0x2,%edx
   11f05:	48 89 ef             	mov    %rbp,%rdi
   11f08:	e9 b5 fe ff ff       	jmp    11dc2 <fwp_write+0xfc2>
   11f0d:	31 c0                	xor    %eax,%eax
   11f0f:	c6 44 04 71 00       	movb   $0x0,0x71(%rsp,%rax,1)
   11f14:	e9 1f 01 00 00       	jmp    12038 <fwp_write+0x1238>
   11f19:	89 fa                	mov    %edi,%edx
   11f1b:	83 e2 1f             	and    $0x1f,%edx
   11f1e:	48 89 c1             	mov    %rax,%rcx
   11f21:	48 29 d1             	sub    %rdx,%rcx
   11f24:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
   11f2b:	00 
   11f2c:	66 0f ef c0          	pxor   %xmm0,%xmm0
   11f30:	49 89 c0             	mov    %rax,%r8
   11f33:	f3 42 0f 6f 0c 04    	movdqu (%rsp,%r8,1),%xmm1
   11f39:	f3 42 0f 6f 54 04 10 	movdqu 0x10(%rsp,%r8,1),%xmm2
   11f40:	66 0f 6f da          	movdqa %xmm2,%xmm3
   11f44:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   11f48:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   11f4d:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   11f52:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   11f57:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   11f5b:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   11f60:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   11f65:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   11f6a:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   11f6e:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   11f72:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   11f76:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   11f7b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   11f80:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   11f85:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   11f89:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   11f8e:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   11f93:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   11f98:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   11f9c:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
   11fa1:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
   11fa5:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
   11fa9:	48 83 c6 20          	add    $0x20,%rsi
   11fad:	4c 39 c2             	cmp    %r8,%rdx
   11fb0:	75 81                	jne    11f33 <fwp_write+0x1133>
   11fb2:	48 85 d2             	test   %rdx,%rdx
   11fb5:	0f 84 78 00 00 00    	je     12033 <fwp_write+0x1233>
   11fbb:	83 fa 08             	cmp    $0x8,%edx
   11fbe:	72 50                	jb     12010 <fwp_write+0x1210>
   11fc0:	89 fa                	mov    %edi,%edx
   11fc2:	83 e2 07             	and    $0x7,%edx
   11fc5:	48 89 c6             	mov    %rax,%rsi
   11fc8:	48 29 ce             	sub    %rcx,%rsi
   11fcb:	48 8d 3c 0c          	lea    (%rsp,%rcx,1),%rdi
   11fcf:	48 83 c7 70          	add    $0x70,%rdi
   11fd3:	48 89 c1             	mov    %rax,%rcx
   11fd6:	48 29 d1             	sub    %rdx,%rcx
   11fd9:	66 0f ef c0          	pxor   %xmm0,%xmm0
   11fdd:	f3 0f 7e 4c 34 18    	movq   0x18(%rsp,%rsi,1),%xmm1
   11fe3:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   11fe7:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   11fec:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   11ff1:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   11ff6:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   11ffa:	66 0f d6 0f          	movq   %xmm1,(%rdi)
   11ffe:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
   12002:	48 83 c7 08          	add    $0x8,%rdi
   12006:	48 39 f2             	cmp    %rsi,%rdx
   12009:	75 d2                	jne    11fdd <fwp_write+0x11dd>
   1200b:	48 85 d2             	test   %rdx,%rdx
   1200e:	74 23                	je     12033 <fwp_write+0x1233>
   12010:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
   12015:	48 01 f2             	add    %rsi,%rdx
   12018:	48 ff ca             	dec    %rdx
   1201b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   12020:	0f b6 32             	movzbl (%rdx),%esi
   12023:	40 88 74 0c 70       	mov    %sil,0x70(%rsp,%rcx,1)
   12028:	48 ff c1             	inc    %rcx
   1202b:	48 ff ca             	dec    %rdx
   1202e:	48 39 c8             	cmp    %rcx,%rax
   12031:	75 ed                	jne    12020 <fwp_write+0x1220>
   12033:	c6 44 04 70 00       	movb   $0x0,0x70(%rsp,%rax,1)
   12038:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   1203d:	4c 89 f7             	mov    %r14,%rdi
   12040:	e8 2b 11 ff ff       	call   3170 <strlen@plt>
   12045:	48 89 ef             	mov    %rbp,%rdi
   12048:	4c 89 f6             	mov    %r14,%rsi
   1204b:	48 89 c2             	mov    %rax,%rdx
   1204e:	e8 7d b1 ff ff       	call   d1d0 <buf_put>
   12053:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
   1205a:	5b                   	pop    %rbx
   1205b:	41 5c                	pop    %r12
   1205d:	41 5d                	pop    %r13
   1205f:	41 5e                	pop    %r14
   12061:	41 5f                	pop    %r15
   12063:	5d                   	pop    %rbp
   12064:	c3                   	ret
   12065:	83 f8 20             	cmp    $0x20,%eax
   12068:	73 07                	jae    12071 <fwp_write+0x1271>
   1206a:	31 c9                	xor    %ecx,%ecx
   1206c:	e9 b6 00 00 00       	jmp    12127 <fwp_write+0x1327>
   12071:	89 fe                	mov    %edi,%esi
   12073:	89 fa                	mov    %edi,%edx
   12075:	83 e2 1f             	and    $0x1f,%edx
   12078:	48 89 c1             	mov    %rax,%rcx
   1207b:	48 29 d1             	sub    %rdx,%rcx
   1207e:	4c 8d 04 34          	lea    (%rsp,%rsi,1),%r8
   12082:	49 83 c0 10          	add    $0x10,%r8
   12086:	48 29 d6             	sub    %rdx,%rsi
   12089:	45 31 c9             	xor    %r9d,%r9d
   1208c:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12090:	f3 41 0f 6f 48 f0    	movdqu -0x10(%r8),%xmm1
   12096:	f3 41 0f 6f 10       	movdqu (%r8),%xmm2
   1209b:	66 0f 6f da          	movdqa %xmm2,%xmm3
   1209f:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   120a3:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   120a8:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   120ad:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   120b2:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   120b6:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   120bb:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   120c0:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   120c5:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   120c9:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   120cd:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   120d1:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   120d6:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   120db:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   120e0:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   120e4:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   120e9:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   120ee:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   120f3:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   120f7:	f3 42 0f 7f 54 0c 71 	movdqu %xmm2,0x71(%rsp,%r9,1)
   120fe:	f3 42 0f 7f 8c 0c 81 	movdqu %xmm1,0x81(%rsp,%r9,1)
   12105:	00 00 00 
   12108:	49 83 c1 20          	add    $0x20,%r9
   1210c:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
   12110:	4c 39 ce             	cmp    %r9,%rsi
   12113:	0f 85 77 ff ff ff    	jne    12090 <fwp_write+0x1290>
   12119:	48 85 d2             	test   %rdx,%rdx
   1211c:	0f 84 91 00 00 00    	je     121b3 <fwp_write+0x13b3>
   12122:	83 fa 08             	cmp    $0x8,%edx
   12125:	72 60                	jb     12187 <fwp_write+0x1387>
   12127:	48 89 ce             	mov    %rcx,%rsi
   1212a:	41 89 f8             	mov    %edi,%r8d
   1212d:	89 fa                	mov    %edi,%edx
   1212f:	83 e2 07             	and    $0x7,%edx
   12132:	48 89 c1             	mov    %rax,%rcx
   12135:	48 29 d1             	sub    %rdx,%rcx
   12138:	49 89 f1             	mov    %rsi,%r9
   1213b:	49 f7 d9             	neg    %r9
   1213e:	49 01 e1             	add    %rsp,%r9
   12141:	49 83 c1 20          	add    $0x20,%r9
   12145:	4d 01 c1             	add    %r8,%r9
   12148:	49 83 c1 f8          	add    $0xfffffffffffffff8,%r9
   1214c:	49 29 d0             	sub    %rdx,%r8
   1214f:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12153:	f3 41 0f 7e 09       	movq   (%r9),%xmm1
   12158:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   1215c:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   12161:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12166:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   1216b:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   1216f:	66 0f d6 4c 34 71    	movq   %xmm1,0x71(%rsp,%rsi,1)
   12175:	48 83 c6 08          	add    $0x8,%rsi
   12179:	49 83 c1 f8          	add    $0xfffffffffffffff8,%r9
   1217d:	49 39 f0             	cmp    %rsi,%r8
   12180:	75 d1                	jne    12153 <fwp_write+0x1353>
   12182:	48 85 d2             	test   %rdx,%rdx
   12185:	74 2c                	je     121b3 <fwp_write+0x13b3>
   12187:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
   1218c:	48 01 f2             	add    %rsi,%rdx
   1218f:	48 ff ca             	dec    %rdx
   12192:	89 fe                	mov    %edi,%esi
   12194:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
   1219b:	00 00 00 00 00 
   121a0:	0f b6 3a             	movzbl (%rdx),%edi
   121a3:	40 88 7c 0c 71       	mov    %dil,0x71(%rsp,%rcx,1)
   121a8:	48 ff c1             	inc    %rcx
   121ab:	48 ff ca             	dec    %rdx
   121ae:	48 39 ce             	cmp    %rcx,%rsi
   121b1:	75 ed                	jne    121a0 <fwp_write+0x13a0>
   121b3:	c6 44 04 71 00       	movb   $0x0,0x71(%rsp,%rax,1)
   121b8:	e9 7b fe ff ff       	jmp    12038 <fwp_write+0x1238>
   121bd:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   121c2:	4c 89 f7             	mov    %r14,%rdi
   121c5:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   121cb:	be 09 00 00 00       	mov    $0x9,%esi
   121d0:	e8 8b 0c 00 00       	call   12e60 <fwp_format_g>
   121d5:	4c 89 f7             	mov    %r14,%rdi
   121d8:	e9 bf f8 ff ff       	jmp    11a9c <fwp_write+0xc9c>
   121dd:	c7 44 24 70 4e 61 4e 	movl   $0x4e614e,0x70(%rsp)
   121e4:	00 
   121e5:	e9 4e fe ff ff       	jmp    12038 <fwp_write+0x1238>
   121ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000121f0 <fwp_escape>:
   121f0:	55                   	push   %rbp
   121f1:	41 57                	push   %r15
   121f3:	41 56                	push   %r14
   121f5:	41 55                	push   %r13
   121f7:	41 54                	push   %r12
   121f9:	53                   	push   %rbx
   121fa:	48 83 ec 18          	sub    $0x18,%rsp
   121fe:	49 89 d6             	mov    %rdx,%r14
   12201:	49 89 f7             	mov    %rsi,%r15
   12204:	48 89 fb             	mov    %rdi,%rbx
   12207:	c6 04 24 22          	movb   $0x22,(%rsp)
   1220b:	48 89 e6             	mov    %rsp,%rsi
   1220e:	ba 01 00 00 00       	mov    $0x1,%edx
   12213:	e8 b8 af ff ff       	call   d1d0 <buf_put>
   12218:	4d 85 f6             	test   %r14,%r14
   1221b:	0f 84 de 00 00 00    	je     122ff <fwp_escape+0x10f>
   12221:	48 89 e5             	mov    %rsp,%rbp
   12224:	4c 8d 2d 79 33 00 00 	lea    0x3379(%rip),%r13        # 155a4 <_IO_stdin_used+0x5a4>
   1222b:	45 31 e4             	xor    %r12d,%r12d
   1222e:	eb 21                	jmp    12251 <fwp_escape+0x61>
   12230:	ba 02 00 00 00       	mov    $0x2,%edx
   12235:	48 89 df             	mov    %rbx,%rdi
   12238:	48 8d 35 80 45 00 00 	lea    0x4580(%rip),%rsi        # 167bf <exec_in_fp0+0xf4f>
   1223f:	90                   	nop
   12240:	e8 8b af ff ff       	call   d1d0 <buf_put>
   12245:	49 ff c4             	inc    %r12
   12248:	4d 39 e6             	cmp    %r12,%r14
   1224b:	0f 84 ae 00 00 00    	je     122ff <fwp_escape+0x10f>
   12251:	43 0f b6 04 27       	movzbl (%r15,%r12,1),%eax
   12256:	0f b6 c8             	movzbl %al,%ecx
   12259:	8d 51 f7             	lea    -0x9(%rcx),%edx
   1225c:	83 fa 19             	cmp    $0x19,%edx
   1225f:	77 1f                	ja     12280 <fwp_escape+0x90>
   12261:	49 63 54 95 00       	movslq 0x0(%r13,%rdx,4),%rdx
   12266:	4c 01 ea             	add    %r13,%rdx
   12269:	ff e2                	jmp    *%rdx
   1226b:	ba 02 00 00 00       	mov    $0x2,%edx
   12270:	48 89 df             	mov    %rbx,%rdi
   12273:	48 8d 35 42 45 00 00 	lea    0x4542(%rip),%rsi        # 167bc <exec_in_fp0+0xf4c>
   1227a:	eb c4                	jmp    12240 <fwp_escape+0x50>
   1227c:	0f 1f 40 00          	nopl   0x0(%rax)
   12280:	83 f9 5c             	cmp    $0x5c,%ecx
   12283:	75 11                	jne    12296 <fwp_escape+0xa6>
   12285:	ba 02 00 00 00       	mov    $0x2,%edx
   1228a:	48 89 df             	mov    %rbx,%rdi
   1228d:	48 8d 35 22 45 00 00 	lea    0x4522(%rip),%rsi        # 167b6 <exec_in_fp0+0xf46>
   12294:	eb aa                	jmp    12240 <fwp_escape+0x50>
   12296:	3c 20                	cmp    $0x20,%al
   12298:	72 39                	jb     122d3 <fwp_escape+0xe3>
   1229a:	3c 7f                	cmp    $0x7f,%al
   1229c:	74 35                	je     122d3 <fwp_escape+0xe3>
   1229e:	88 04 24             	mov    %al,(%rsp)
   122a1:	ba 01 00 00 00       	mov    $0x1,%edx
   122a6:	48 89 df             	mov    %rbx,%rdi
   122a9:	48 89 ee             	mov    %rbp,%rsi
   122ac:	eb 92                	jmp    12240 <fwp_escape+0x50>
   122ae:	ba 02 00 00 00       	mov    $0x2,%edx
   122b3:	48 89 df             	mov    %rbx,%rdi
   122b6:	48 8d 35 f6 44 00 00 	lea    0x44f6(%rip),%rsi        # 167b3 <exec_in_fp0+0xf43>
   122bd:	eb 81                	jmp    12240 <fwp_escape+0x50>
   122bf:	ba 02 00 00 00       	mov    $0x2,%edx
   122c4:	48 89 df             	mov    %rbx,%rdi
   122c7:	48 8d 35 eb 44 00 00 	lea    0x44eb(%rip),%rsi        # 167b9 <exec_in_fp0+0xf49>
   122ce:	e9 6d ff ff ff       	jmp    12240 <fwp_escape+0x50>
   122d3:	be 10 00 00 00       	mov    $0x10,%esi
   122d8:	48 89 ef             	mov    %rbp,%rdi
   122db:	48 8d 15 e0 44 00 00 	lea    0x44e0(%rip),%rdx        # 167c2 <exec_in_fp0+0xf52>
   122e2:	31 c0                	xor    %eax,%eax
   122e4:	e8 e7 0e ff ff       	call   31d0 <snprintf@plt>
   122e9:	48 89 ef             	mov    %rbp,%rdi
   122ec:	e8 7f 0e ff ff       	call   3170 <strlen@plt>
   122f1:	48 89 df             	mov    %rbx,%rdi
   122f4:	48 89 ee             	mov    %rbp,%rsi
   122f7:	48 89 c2             	mov    %rax,%rdx
   122fa:	e9 41 ff ff ff       	jmp    12240 <fwp_escape+0x50>
   122ff:	c6 04 24 22          	movb   $0x22,(%rsp)
   12303:	48 89 e6             	mov    %rsp,%rsi
   12306:	ba 01 00 00 00       	mov    $0x1,%edx
   1230b:	48 89 df             	mov    %rbx,%rdi
   1230e:	e8 bd ae ff ff       	call   d1d0 <buf_put>
   12313:	48 83 c4 18          	add    $0x18,%rsp
   12317:	5b                   	pop    %rbx
   12318:	41 5c                	pop    %r12
   1231a:	41 5d                	pop    %r13
   1231c:	41 5e                	pop    %r14
   1231e:	41 5f                	pop    %r15
   12320:	5d                   	pop    %rbp
   12321:	c3                   	ret
   12322:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   12329:	1f 84 00 00 00 00 00 

0000000000012330 <fwp_fmt_duration>:
   12330:	41 57                	push   %r15
   12332:	41 56                	push   %r14
   12334:	41 54                	push   %r12
   12336:	53                   	push   %rbx
   12337:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
   1233e:	48 89 f0             	mov    %rsi,%rax
   12341:	48 09 d0             	or     %rdx,%rax
   12344:	0f 84 bf 02 00 00    	je     12609 <fwp_fmt_duration+0x2d9>
   1234a:	49 89 d0             	mov    %rdx,%r8
   1234d:	48 b9 1d 3f c2 25 d6 	movabs $0xd2fe1d625c23f1d,%rcx
   12354:	e1 2f 0d 
   12357:	48 0f af ce          	imul   %rsi,%rcx
   1235b:	49 b9 0d b1 f3 e4 99 	movabs $0x1c52799e4f3b10d,%r9
   12362:	27 c5 01 
   12365:	48 89 f0             	mov    %rsi,%rax
   12368:	49 f7 e1             	mul    %r9
   1236b:	48 01 ca             	add    %rcx,%rdx
   1236e:	4d 0f af c8          	imul   %r8,%r9
   12372:	49 01 d1             	add    %rdx,%r9
   12375:	48 b9 00 a0 34 52 a3 	movabs $0x6baf6aa35234a000,%rcx
   1237c:	6a af 6b 
   1237f:	48 01 c1             	add    %rax,%rcx
   12382:	48 b8 37 f9 ff e2 04 	movabs $0x4e2fff937,%rax
   12389:	00 00 00 
   1238c:	4c 11 c8             	adc    %r9,%rax
   1238f:	48 89 c2             	mov    %rax,%rdx
   12392:	48 0f ac ca 0d       	shrd   $0xd,%rcx,%rdx
   12397:	48 0f a4 c8 33       	shld   $0x33,%rcx,%rax
   1239c:	48 b9 4a 23 35 aa f6 	movabs $0x9376baf6aa35234a,%rcx
   123a3:	ba 76 93 
   123a6:	48 39 c1             	cmp    %rax,%rcx
   123a9:	b8 ff 2f 4e 00       	mov    $0x4e2fff,%eax
   123ae:	48 19 d0             	sbb    %rdx,%rax
   123b1:	0f 83 70 02 00 00    	jae    12627 <fwp_fmt_duration+0x2f7>
   123b7:	48 b9 b3 b2 61 36 8c 	movabs $0xc5ce3b8c3661b2b3,%rcx
   123be:	3b ce c5 
   123c1:	49 b9 c3 5f 47 6a 04 	movabs $0x1a8d52046a475fc3,%r9
   123c8:	52 8d 1a 
   123cb:	48 89 f0             	mov    %rsi,%rax
   123ce:	49 f7 e1             	mul    %r9
   123d1:	48 0f af ce          	imul   %rsi,%rcx
   123d5:	48 01 ca             	add    %rcx,%rdx
   123d8:	4d 0f af c8          	imul   %r8,%r9
   123dc:	49 01 d1             	add    %rdx,%r9
   123df:	48 b9 00 a8 16 d1 91 	movabs $0x4f473f91d116a800,%rcx
   123e6:	3f 47 4f 
   123e9:	48 01 c1             	add    %rax,%rcx
   123ec:	48 b8 3f 9a ff 4c 49 	movabs $0x494cff9a3f,%rax
   123f3:	00 00 00 
   123f6:	4c 11 c8             	adc    %r9,%rax
   123f9:	48 89 c2             	mov    %rax,%rdx
   123fc:	48 0f ac ca 0b       	shrd   $0xb,%rcx,%rdx
   12401:	48 0f a4 c8 35       	shld   $0x35,%rcx,%rax
   12406:	48 b9 ab 45 74 e4 cf 	movabs $0x8fd3d1cfe47445ab,%rcx
   1240d:	d1 d3 8f 
   12410:	48 39 c8             	cmp    %rcx,%rax
   12413:	48 81 da e6 3f 53 12 	sbb    $0x12533fe6,%rdx
   1241a:	0f 82 27 02 00 00    	jb     12647 <fwp_fmt_duration+0x317>
   12420:	48 b9 7e 78 b9 2f 37 	movabs $0x97157d372fb9787e,%rcx
   12427:	7d 15 97 
   1242a:	48 0f af ce          	imul   %rsi,%rcx
   1242e:	49 b9 6d 9c 2e 3a 42 	movabs $0x8e47ce423a2e9c6d,%r9
   12435:	ce 47 8e 
   12438:	48 89 f0             	mov    %rsi,%rax
   1243b:	49 f7 e1             	mul    %r9
   1243e:	48 01 ca             	add    %rcx,%rdx
   12441:	4d 0f af c8          	imul   %r8,%r9
   12445:	49 01 d1             	add    %rdx,%r9
   12448:	48 b9 00 46 54 40 8b 	movabs $0xa52cb98b40544600,%rcx
   1244f:	b9 2c a5 
   12452:	48 01 c1             	add    %rax,%rcx
   12455:	48 b8 b5 09 fa 82 4b 	movabs $0x44b82fa09b5,%rax
   1245c:	04 00 00 
   1245f:	4c 11 c8             	adc    %r9,%rax
   12462:	48 89 c2             	mov    %rax,%rdx
   12465:	48 0f ac ca 09       	shrd   $0x9,%rcx,%rdx
   1246a:	48 0f a4 c8 37       	shld   $0x37,%rcx,%rax
   1246f:	48 b9 47 54 40 8b b9 	movabs $0xb5a52cb98b405447,%rcx
   12476:	2c a5 b5 
   12479:	48 39 c8             	cmp    %rcx,%rax
   1247c:	48 b8 09 fa 82 4b 04 	movabs $0x44b82fa09,%rax
   12483:	00 00 00 
   12486:	48 19 c2             	sbb    %rax,%rdx
   12489:	0f 82 0d 03 00 00    	jb     1279c <fwp_fmt_duration+0x46c>
   1248f:	48 b9 cb d5 8f 4d f2 	movabs $0xc57e23f24d8fd5cb,%rcx
   12496:	23 7e c5 
   12499:	48 0f af ce          	imul   %rsi,%rcx
   1249d:	49 b9 39 61 c2 68 56 	movabs $0x790fb65668c26139,%r9
   124a4:	b6 0f 79 
   124a7:	48 89 f0             	mov    %rsi,%rax
   124aa:	49 f7 e1             	mul    %r9
   124ad:	48 01 ca             	add    %rcx,%rdx
   124b0:	4d 0f af c8          	imul   %r8,%r9
   124b4:	49 01 d1             	add    %rdx,%r9
   124b7:	48 b9 00 0b 27 69 fe 	movabs $0xa6d698fe69270b00,%rcx
   124be:	98 d6 a6 
   124c1:	48 01 c1             	add    %rax,%rcx
   124c4:	48 b8 b1 bd 16 f4 de 	movabs $0x218def416bdb1,%rax
   124cb:	18 02 00 
   124ce:	4c 11 c8             	adc    %r9,%rax
   124d1:	48 89 c2             	mov    %rax,%rdx
   124d4:	48 0f ac ca 06       	shrd   $0x6,%rcx,%rdx
   124d9:	48 0f a4 c8 3a       	shld   $0x3a,%rcx,%rax
   124de:	48 b9 59 38 49 f3 c7 	movabs $0x8d36b4c7f3493859,%rcx
   124e5:	b4 36 8d 
   124e8:	48 39 c8             	cmp    %rcx,%rax
   124eb:	48 b8 ed b5 a0 f7 c6 	movabs $0x10c6f7a0b5ed,%rax
   124f2:	10 00 00 
   124f5:	48 19 c2             	sbb    %rax,%rdx
   124f8:	0f 82 ad 02 00 00    	jb     127ab <fwp_fmt_duration+0x47b>
   124fe:	48 b9 5a 64 3b df 4f 	movabs $0x6e978d4fdf3b645a,%rcx
   12505:	8d 97 6e 
   12508:	48 0f af ce          	imul   %rsi,%rcx
   1250c:	49 b9 d5 78 e9 26 31 	movabs $0x1cac083126e978d5,%r9
   12513:	08 ac 1c 
   12516:	48 89 f0             	mov    %rsi,%rax
   12519:	49 f7 e1             	mul    %r9
   1251c:	48 01 ca             	add    %rcx,%rdx
   1251f:	4d 0f af c8          	imul   %r8,%r9
   12523:	49 01 d1             	add    %rdx,%r9
   12526:	48 b9 48 62 10 58 39 	movabs $0x76c8b43958106248,%rcx
   1252d:	b4 c8 76 
   12530:	48 01 c1             	add    %rax,%rcx
   12533:	48 b8 be 9f 1a 2f dd 	movabs $0x10624dd2f1a9fbe,%rax
   1253a:	24 06 01 
   1253d:	4c 11 c8             	adc    %r9,%rax
   12540:	48 89 c2             	mov    %rax,%rdx
   12543:	48 0f ac ca 03       	shrd   $0x3,%rcx,%rdx
   12548:	48 0f a4 c8 3d       	shld   $0x3d,%rcx,%rax
   1254d:	48 b9 93 18 04 56 0e 	movabs $0x9db22d0e56041893,%rcx
   12554:	2d b2 9d 
   12557:	48 39 c8             	cmp    %rcx,%rax
   1255a:	48 b8 ef a7 c6 4b 37 	movabs $0x4189374bc6a7ef,%rax
   12561:	89 41 00 
   12564:	48 19 c2             	sbb    %rax,%rdx
   12567:	0f 82 4d 02 00 00    	jb     127ba <fwp_fmt_duration+0x48a>
   1256d:	4d 85 c0             	test   %r8,%r8
   12570:	0f 88 d6 06 00 00    	js     12c4c <fwp_fmt_duration+0x91c>
   12576:	45 31 d2             	xor    %r10d,%r10d
   12579:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
   12580:	cc cc cc 
   12583:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
   1258a:	cc cc cc 
   1258d:	4d 89 c6             	mov    %r8,%r14
   12590:	4c 89 c1             	mov    %r8,%rcx
   12593:	48 0f a4 f1 3f       	shld   $0x3f,%rsi,%rcx
   12598:	49 d1 ee             	shr    $1,%r14
   1259b:	49 89 c9             	mov    %rcx,%r9
   1259e:	4d 01 f1             	add    %r14,%r9
   125a1:	49 83 d1 00          	adc    $0x0,%r9
   125a5:	4c 89 c8             	mov    %r9,%rax
   125a8:	49 f7 e3             	mul    %r11
   125ab:	48 c1 ea 02          	shr    $0x2,%rdx
   125af:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   125b3:	49 29 c1             	sub    %rax,%r9
   125b6:	4c 29 c9             	sub    %r9,%rcx
   125b9:	49 83 de 00          	sbb    $0x0,%r14
   125bd:	49 89 c9             	mov    %rcx,%r9
   125c0:	4c 0f af cb          	imul   %rbx,%r9
   125c4:	48 89 c8             	mov    %rcx,%rax
   125c7:	49 f7 e3             	mul    %r11
   125ca:	4c 01 ca             	add    %r9,%rdx
   125cd:	4d 0f af f3          	imul   %r11,%r14
   125d1:	49 01 d6             	add    %rdx,%r14
   125d4:	48 89 c1             	mov    %rax,%rcx
   125d7:	48 01 c1             	add    %rax,%rcx
   125da:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
   125de:	89 f2                	mov    %esi,%edx
   125e0:	29 ca                	sub    %ecx,%edx
   125e2:	80 ca 30             	or     $0x30,%dl
   125e5:	42 88 54 14 40       	mov    %dl,0x40(%rsp,%r10,1)
   125ea:	49 ff c2             	inc    %r10
   125ed:	48 83 fe 0a          	cmp    $0xa,%rsi
   125f1:	49 83 d8 00          	sbb    $0x0,%r8
   125f5:	48 89 c6             	mov    %rax,%rsi
   125f8:	4d 89 f0             	mov    %r14,%r8
   125fb:	73 93                	jae    12590 <fwp_fmt_duration+0x260>
   125fd:	45 85 d2             	test   %r10d,%r10d
   12600:	7f 12                	jg     12614 <fwp_fmt_duration+0x2e4>
   12602:	31 c0                	xor    %eax,%eax
   12604:	e9 79 01 00 00       	jmp    12782 <fwp_fmt_duration+0x452>
   12609:	c6 44 24 40 30       	movb   $0x30,0x40(%rsp)
   1260e:	41 ba 01 00 00 00    	mov    $0x1,%r10d
   12614:	44 89 d0             	mov    %r10d,%eax
   12617:	48 83 f8 08          	cmp    $0x8,%rax
   1261b:	73 1e                	jae    1263b <fwp_fmt_duration+0x30b>
   1261d:	31 c9                	xor    %ecx,%ecx
   1261f:	48 89 c2             	mov    %rax,%rdx
   12622:	e9 3d 01 00 00       	jmp    12764 <fwp_fmt_duration+0x434>
   12627:	49 89 fe             	mov    %rdi,%r14
   1262a:	48 ba 00 a0 b8 30 46 	movabs $0x34630b8a000,%rdx
   12631:	03 00 00 
   12634:	31 c0                	xor    %eax,%eax
   12636:	e9 8c 01 00 00       	jmp    127c7 <fwp_fmt_duration+0x497>
   1263b:	83 f8 20             	cmp    $0x20,%eax
   1263e:	73 1e                	jae    1265e <fwp_fmt_duration+0x32e>
   12640:	31 c9                	xor    %ecx,%ecx
   12642:	e9 c3 00 00 00       	jmp    1270a <fwp_fmt_duration+0x3da>
   12647:	49 89 fe             	mov    %rdi,%r14
   1264a:	48 ba 00 58 47 f8 0d 	movabs $0xdf8475800,%rdx
   12651:	00 00 00 
   12654:	b8 01 00 00 00       	mov    $0x1,%eax
   12659:	e9 69 01 00 00       	jmp    127c7 <fwp_fmt_duration+0x497>
   1265e:	44 89 d2             	mov    %r10d,%edx
   12661:	83 e2 1f             	and    $0x1f,%edx
   12664:	48 89 c1             	mov    %rax,%rcx
   12667:	48 29 d1             	sub    %rdx,%rcx
   1266a:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
   1266f:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12673:	49 89 c0             	mov    %rax,%r8
   12676:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   1267d:	00 00 00 
   12680:	f3 42 0f 6f 4c 04 20 	movdqu 0x20(%rsp,%r8,1),%xmm1
   12687:	f3 42 0f 6f 54 04 30 	movdqu 0x30(%rsp,%r8,1),%xmm2
   1268e:	66 0f 6f da          	movdqa %xmm2,%xmm3
   12692:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12696:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   1269b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   126a0:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   126a5:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   126a9:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   126ae:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   126b3:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   126b8:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   126bc:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   126c0:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   126c4:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   126c9:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   126ce:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   126d3:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   126d7:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   126dc:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   126e1:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   126e6:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   126ea:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
   126ef:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
   126f3:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
   126f7:	48 83 c6 20          	add    $0x20,%rsi
   126fb:	4c 39 c2             	cmp    %r8,%rdx
   126fe:	75 80                	jne    12680 <fwp_fmt_duration+0x350>
   12700:	48 85 d2             	test   %rdx,%rdx
   12703:	74 7d                	je     12782 <fwp_fmt_duration+0x452>
   12705:	83 fa 08             	cmp    $0x8,%edx
   12708:	72 5a                	jb     12764 <fwp_fmt_duration+0x434>
   1270a:	44 89 d2             	mov    %r10d,%edx
   1270d:	83 e2 07             	and    $0x7,%edx
   12710:	48 89 c6             	mov    %rax,%rsi
   12713:	48 29 ce             	sub    %rcx,%rsi
   12716:	4c 8d 04 0c          	lea    (%rsp,%rcx,1),%r8
   1271a:	48 89 c1             	mov    %rax,%rcx
   1271d:	48 29 d1             	sub    %rdx,%rcx
   12720:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12724:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
   1272b:	00 00 00 00 00 
   12730:	f3 0f 7e 4c 34 38    	movq   0x38(%rsp,%rsi,1),%xmm1
   12736:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   1273a:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   1273f:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12744:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12749:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   1274d:	66 41 0f d6 08       	movq   %xmm1,(%r8)
   12752:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
   12756:	49 83 c0 08          	add    $0x8,%r8
   1275a:	48 39 f2             	cmp    %rsi,%rdx
   1275d:	75 d1                	jne    12730 <fwp_fmt_duration+0x400>
   1275f:	48 85 d2             	test   %rdx,%rdx
   12762:	74 1e                	je     12782 <fwp_fmt_duration+0x452>
   12764:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
   12769:	48 01 f2             	add    %rsi,%rdx
   1276c:	48 ff ca             	dec    %rdx
   1276f:	90                   	nop
   12770:	0f b6 32             	movzbl (%rdx),%esi
   12773:	40 88 34 0c          	mov    %sil,(%rsp,%rcx,1)
   12777:	48 ff c1             	inc    %rcx
   1277a:	48 ff ca             	dec    %rdx
   1277d:	48 39 c8             	cmp    %rcx,%rax
   12780:	75 ee                	jne    12770 <fwp_fmt_duration+0x440>
   12782:	c6 04 04 00          	movb   $0x0,(%rsp,%rax,1)
   12786:	48 8d 35 41 40 00 00 	lea    0x4041(%rip),%rsi        # 167ce <exec_in_fp0+0xf5e>
   1278d:	48 89 e2             	mov    %rsp,%rdx
   12790:	31 c0                	xor    %eax,%eax
   12792:	e8 b9 0c ff ff       	call   3450 <sprintf@plt>
   12797:	e9 a1 04 00 00       	jmp    12c3d <fwp_fmt_duration+0x90d>
   1279c:	49 89 fe             	mov    %rdi,%r14
   1279f:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
   127a4:	b8 02 00 00 00       	mov    $0x2,%eax
   127a9:	eb 1c                	jmp    127c7 <fwp_fmt_duration+0x497>
   127ab:	49 89 fe             	mov    %rdi,%r14
   127ae:	ba 40 42 0f 00       	mov    $0xf4240,%edx
   127b3:	b8 03 00 00 00       	mov    $0x3,%eax
   127b8:	eb 0d                	jmp    127c7 <fwp_fmt_duration+0x497>
   127ba:	49 89 fe             	mov    %rdi,%r14
   127bd:	ba e8 03 00 00       	mov    $0x3e8,%edx
   127c2:	b8 04 00 00 00       	mov    $0x4,%eax
   127c7:	31 c9                	xor    %ecx,%ecx
   127c9:	c1 e0 04             	shl    $0x4,%eax
   127cc:	48 8d 1d 8d 75 00 00 	lea    0x758d(%rip),%rbx        # 19d60 <fwp_fmt_duration.units>
   127d3:	48 01 c3             	add    %rax,%rbx
   127d6:	48 89 f7             	mov    %rsi,%rdi
   127d9:	4c 89 c6             	mov    %r8,%rsi
   127dc:	e8 bf 16 00 00       	call   13ea0 <__divti3>
   127e1:	48 89 c1             	mov    %rax,%rcx
   127e4:	48 89 d6             	mov    %rdx,%rsi
   127e7:	48 85 d2             	test   %rdx,%rdx
   127ea:	0f 88 b0 00 00 00    	js     128a0 <fwp_fmt_duration+0x570>
   127f0:	48 89 c8             	mov    %rcx,%rax
   127f3:	48 09 f0             	or     %rsi,%rax
   127f6:	0f 84 61 01 00 00    	je     1295d <fwp_fmt_duration+0x62d>
   127fc:	45 31 d2             	xor    %r10d,%r10d
   127ff:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
   12806:	cc cc cc 
   12809:	49 bf cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r15
   12810:	cc cc cc 
   12813:	49 89 f4             	mov    %rsi,%r12
   12816:	4c 89 f7             	mov    %r14,%rdi
   12819:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   12820:	49 89 f0             	mov    %rsi,%r8
   12823:	49 0f a4 c8 3f       	shld   $0x3f,%rcx,%r8
   12828:	49 d1 ec             	shr    $1,%r12
   1282b:	4d 89 c1             	mov    %r8,%r9
   1282e:	4d 01 e1             	add    %r12,%r9
   12831:	49 83 d1 00          	adc    $0x0,%r9
   12835:	4c 89 c8             	mov    %r9,%rax
   12838:	49 f7 e3             	mul    %r11
   1283b:	48 c1 ea 02          	shr    $0x2,%rdx
   1283f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   12843:	49 29 c1             	sub    %rax,%r9
   12846:	4d 29 c8             	sub    %r9,%r8
   12849:	49 83 dc 00          	sbb    $0x0,%r12
   1284d:	4d 89 c1             	mov    %r8,%r9
   12850:	4d 0f af cf          	imul   %r15,%r9
   12854:	4c 89 c0             	mov    %r8,%rax
   12857:	49 f7 e3             	mul    %r11
   1285a:	4c 01 ca             	add    %r9,%rdx
   1285d:	4d 0f af e3          	imul   %r11,%r12
   12861:	49 01 d4             	add    %rdx,%r12
   12864:	48 89 c2             	mov    %rax,%rdx
   12867:	48 01 c2             	add    %rax,%rdx
   1286a:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
   1286e:	41 89 c8             	mov    %ecx,%r8d
   12871:	41 29 d0             	sub    %edx,%r8d
   12874:	41 80 c8 30          	or     $0x30,%r8b
   12878:	46 88 44 14 40       	mov    %r8b,0x40(%rsp,%r10,1)
   1287d:	49 ff c2             	inc    %r10
   12880:	48 83 f9 0a          	cmp    $0xa,%rcx
   12884:	48 83 de 00          	sbb    $0x0,%rsi
   12888:	48 89 c1             	mov    %rax,%rcx
   1288b:	4c 89 e6             	mov    %r12,%rsi
   1288e:	73 90                	jae    12820 <fwp_fmt_duration+0x4f0>
   12890:	45 85 d2             	test   %r10d,%r10d
   12893:	0f 8f d2 00 00 00    	jg     1296b <fwp_fmt_duration+0x63b>
   12899:	31 c0                	xor    %eax,%eax
   1289b:	e9 12 02 00 00       	jmp    12ab2 <fwp_fmt_duration+0x782>
   128a0:	45 31 c0             	xor    %r8d,%r8d
   128a3:	48 f7 d9             	neg    %rcx
   128a6:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   128ac:	49 19 f1             	sbb    %rsi,%r9
   128af:	c6 04 24 2d          	movb   $0x2d,(%rsp)
   128b3:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
   128ba:	cc cc cc 
   128bd:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
   128c4:	cc cc cc 
   128c7:	4d 89 cf             	mov    %r9,%r15
   128ca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   128d0:	4c 89 ce             	mov    %r9,%rsi
   128d3:	48 0f a4 ce 3f       	shld   $0x3f,%rcx,%rsi
   128d8:	49 d1 ef             	shr    $1,%r15
   128db:	48 89 f7             	mov    %rsi,%rdi
   128de:	4c 01 ff             	add    %r15,%rdi
   128e1:	48 83 d7 00          	adc    $0x0,%rdi
   128e5:	48 89 f8             	mov    %rdi,%rax
   128e8:	49 f7 e2             	mul    %r10
   128eb:	48 c1 ea 02          	shr    $0x2,%rdx
   128ef:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   128f3:	48 29 c7             	sub    %rax,%rdi
   128f6:	48 29 fe             	sub    %rdi,%rsi
   128f9:	49 83 df 00          	sbb    $0x0,%r15
   128fd:	48 89 f7             	mov    %rsi,%rdi
   12900:	49 0f af fb          	imul   %r11,%rdi
   12904:	48 89 f0             	mov    %rsi,%rax
   12907:	49 f7 e2             	mul    %r10
   1290a:	48 01 fa             	add    %rdi,%rdx
   1290d:	4d 0f af fa          	imul   %r10,%r15
   12911:	49 01 d7             	add    %rdx,%r15
   12914:	48 89 c2             	mov    %rax,%rdx
   12917:	48 01 c2             	add    %rax,%rdx
   1291a:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
   1291e:	89 ce                	mov    %ecx,%esi
   12920:	29 d6                	sub    %edx,%esi
   12922:	40 80 ce 30          	or     $0x30,%sil
   12926:	42 88 74 04 40       	mov    %sil,0x40(%rsp,%r8,1)
   1292b:	49 ff c0             	inc    %r8
   1292e:	48 83 f9 0a          	cmp    $0xa,%rcx
   12932:	49 83 d9 00          	sbb    $0x0,%r9
   12936:	48 89 c1             	mov    %rax,%rcx
   12939:	4d 89 f9             	mov    %r15,%r9
   1293c:	73 92                	jae    128d0 <fwp_fmt_duration+0x5a0>
   1293e:	45 85 c0             	test   %r8d,%r8d
   12941:	4c 89 f7             	mov    %r14,%rdi
   12944:	7e 44                	jle    1298a <fwp_fmt_duration+0x65a>
   12946:	44 89 c0             	mov    %r8d,%eax
   12949:	48 83 f8 08          	cmp    $0x8,%rax
   1294d:	0f 83 68 01 00 00    	jae    12abb <fwp_fmt_duration+0x78b>
   12953:	31 c9                	xor    %ecx,%ecx
   12955:	48 89 c2             	mov    %rax,%rdx
   12958:	e9 97 02 00 00       	jmp    12bf4 <fwp_fmt_duration+0x8c4>
   1295d:	c6 44 24 40 30       	movb   $0x30,0x40(%rsp)
   12962:	41 ba 01 00 00 00    	mov    $0x1,%r10d
   12968:	4c 89 f7             	mov    %r14,%rdi
   1296b:	44 89 d0             	mov    %r10d,%eax
   1296e:	48 83 f8 08          	cmp    $0x8,%rax
   12972:	73 0a                	jae    1297e <fwp_fmt_duration+0x64e>
   12974:	31 c9                	xor    %ecx,%ecx
   12976:	48 89 c2             	mov    %rax,%rdx
   12979:	e9 16 01 00 00       	jmp    12a94 <fwp_fmt_duration+0x764>
   1297e:	83 f8 20             	cmp    $0x20,%eax
   12981:	73 0e                	jae    12991 <fwp_fmt_duration+0x661>
   12983:	31 c9                	xor    %ecx,%ecx
   12985:	e9 b0 00 00 00       	jmp    12a3a <fwp_fmt_duration+0x70a>
   1298a:	31 c0                	xor    %eax,%eax
   1298c:	e9 93 02 00 00       	jmp    12c24 <fwp_fmt_duration+0x8f4>
   12991:	44 89 d2             	mov    %r10d,%edx
   12994:	83 e2 1f             	and    $0x1f,%edx
   12997:	48 89 c1             	mov    %rax,%rcx
   1299a:	48 29 d1             	sub    %rdx,%rcx
   1299d:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
   129a2:	66 0f ef c0          	pxor   %xmm0,%xmm0
   129a6:	49 89 c0             	mov    %rax,%r8
   129a9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   129b0:	f3 42 0f 6f 4c 04 20 	movdqu 0x20(%rsp,%r8,1),%xmm1
   129b7:	f3 42 0f 6f 54 04 30 	movdqu 0x30(%rsp,%r8,1),%xmm2
   129be:	66 0f 6f da          	movdqa %xmm2,%xmm3
   129c2:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   129c6:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   129cb:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   129d0:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   129d5:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   129d9:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   129de:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   129e3:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   129e8:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   129ec:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   129f0:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   129f4:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   129f9:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   129fe:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12a03:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   12a07:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   12a0c:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12a11:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12a16:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   12a1a:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
   12a1f:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
   12a23:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
   12a27:	48 83 c6 20          	add    $0x20,%rsi
   12a2b:	4c 39 c2             	cmp    %r8,%rdx
   12a2e:	75 80                	jne    129b0 <fwp_fmt_duration+0x680>
   12a30:	48 85 d2             	test   %rdx,%rdx
   12a33:	74 7d                	je     12ab2 <fwp_fmt_duration+0x782>
   12a35:	83 fa 08             	cmp    $0x8,%edx
   12a38:	72 5a                	jb     12a94 <fwp_fmt_duration+0x764>
   12a3a:	44 89 d2             	mov    %r10d,%edx
   12a3d:	83 e2 07             	and    $0x7,%edx
   12a40:	48 89 c6             	mov    %rax,%rsi
   12a43:	48 29 ce             	sub    %rcx,%rsi
   12a46:	4c 8d 04 0c          	lea    (%rsp,%rcx,1),%r8
   12a4a:	48 89 c1             	mov    %rax,%rcx
   12a4d:	48 29 d1             	sub    %rdx,%rcx
   12a50:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12a54:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
   12a5b:	00 00 00 00 00 
   12a60:	f3 0f 7e 4c 34 38    	movq   0x38(%rsp,%rsi,1),%xmm1
   12a66:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   12a6a:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   12a6f:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12a74:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12a79:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   12a7d:	66 41 0f d6 08       	movq   %xmm1,(%r8)
   12a82:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
   12a86:	49 83 c0 08          	add    $0x8,%r8
   12a8a:	48 39 f2             	cmp    %rsi,%rdx
   12a8d:	75 d1                	jne    12a60 <fwp_fmt_duration+0x730>
   12a8f:	48 85 d2             	test   %rdx,%rdx
   12a92:	74 1e                	je     12ab2 <fwp_fmt_duration+0x782>
   12a94:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
   12a99:	48 01 f2             	add    %rsi,%rdx
   12a9c:	48 ff ca             	dec    %rdx
   12a9f:	90                   	nop
   12aa0:	0f b6 32             	movzbl (%rdx),%esi
   12aa3:	40 88 34 0c          	mov    %sil,(%rsp,%rcx,1)
   12aa7:	48 ff c1             	inc    %rcx
   12aaa:	48 ff ca             	dec    %rdx
   12aad:	48 39 c8             	cmp    %rcx,%rax
   12ab0:	75 ee                	jne    12aa0 <fwp_fmt_duration+0x770>
   12ab2:	c6 04 04 00          	movb   $0x0,(%rsp,%rax,1)
   12ab6:	e9 6e 01 00 00       	jmp    12c29 <fwp_fmt_duration+0x8f9>
   12abb:	83 f8 20             	cmp    $0x20,%eax
   12abe:	73 07                	jae    12ac7 <fwp_fmt_duration+0x797>
   12ac0:	31 c9                	xor    %ecx,%ecx
   12ac2:	e9 bd 00 00 00       	jmp    12b84 <fwp_fmt_duration+0x854>
   12ac7:	44 89 c6             	mov    %r8d,%esi
   12aca:	44 89 c2             	mov    %r8d,%edx
   12acd:	83 e2 1f             	and    $0x1f,%edx
   12ad0:	48 89 c1             	mov    %rax,%rcx
   12ad3:	48 29 d1             	sub    %rdx,%rcx
   12ad6:	4c 8d 0c 34          	lea    (%rsp,%rsi,1),%r9
   12ada:	49 83 c1 30          	add    $0x30,%r9
   12ade:	48 29 d6             	sub    %rdx,%rsi
   12ae1:	45 31 d2             	xor    %r10d,%r10d
   12ae4:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12ae8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   12aef:	00 
   12af0:	f3 41 0f 6f 49 f0    	movdqu -0x10(%r9),%xmm1
   12af6:	f3 41 0f 6f 11       	movdqu (%r9),%xmm2
   12afb:	66 0f 6f da          	movdqa %xmm2,%xmm3
   12aff:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12b03:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12b08:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   12b0d:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12b12:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   12b16:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   12b1b:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   12b20:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   12b25:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   12b29:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   12b2d:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12b31:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12b36:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   12b3b:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12b40:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   12b44:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   12b49:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12b4e:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12b53:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   12b57:	f3 42 0f 7f 54 14 01 	movdqu %xmm2,0x1(%rsp,%r10,1)
   12b5e:	f3 42 0f 7f 4c 14 11 	movdqu %xmm1,0x11(%rsp,%r10,1)
   12b65:	49 83 c2 20          	add    $0x20,%r10
   12b69:	49 83 c1 e0          	add    $0xffffffffffffffe0,%r9
   12b6d:	4c 39 d6             	cmp    %r10,%rsi
   12b70:	0f 85 7a ff ff ff    	jne    12af0 <fwp_fmt_duration+0x7c0>
   12b76:	48 85 d2             	test   %rdx,%rdx
   12b79:	0f 84 a5 00 00 00    	je     12c24 <fwp_fmt_duration+0x8f4>
   12b7f:	83 fa 08             	cmp    $0x8,%edx
   12b82:	72 70                	jb     12bf4 <fwp_fmt_duration+0x8c4>
   12b84:	48 89 ce             	mov    %rcx,%rsi
   12b87:	45 89 c1             	mov    %r8d,%r9d
   12b8a:	44 89 c2             	mov    %r8d,%edx
   12b8d:	83 e2 07             	and    $0x7,%edx
   12b90:	48 89 c1             	mov    %rax,%rcx
   12b93:	48 29 d1             	sub    %rdx,%rcx
   12b96:	49 89 f2             	mov    %rsi,%r10
   12b99:	49 f7 da             	neg    %r10
   12b9c:	49 01 e2             	add    %rsp,%r10
   12b9f:	49 83 c2 40          	add    $0x40,%r10
   12ba3:	4d 01 ca             	add    %r9,%r10
   12ba6:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
   12baa:	49 29 d1             	sub    %rdx,%r9
   12bad:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12bb1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   12bb8:	0f 1f 84 00 00 00 00 
   12bbf:	00 
   12bc0:	f3 41 0f 7e 0a       	movq   (%r10),%xmm1
   12bc5:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   12bc9:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   12bce:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12bd3:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12bd8:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   12bdc:	66 0f d6 4c 34 01    	movq   %xmm1,0x1(%rsp,%rsi,1)
   12be2:	48 83 c6 08          	add    $0x8,%rsi
   12be6:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
   12bea:	49 39 f1             	cmp    %rsi,%r9
   12bed:	75 d1                	jne    12bc0 <fwp_fmt_duration+0x890>
   12bef:	48 85 d2             	test   %rdx,%rdx
   12bf2:	74 30                	je     12c24 <fwp_fmt_duration+0x8f4>
   12bf4:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
   12bf9:	48 01 f2             	add    %rsi,%rdx
   12bfc:	48 ff ca             	dec    %rdx
   12bff:	44 89 c6             	mov    %r8d,%esi
   12c02:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   12c09:	1f 84 00 00 00 00 00 
   12c10:	44 0f b6 02          	movzbl (%rdx),%r8d
   12c14:	44 88 44 0c 01       	mov    %r8b,0x1(%rsp,%rcx,1)
   12c19:	48 ff c1             	inc    %rcx
   12c1c:	48 ff ca             	dec    %rdx
   12c1f:	48 39 ce             	cmp    %rcx,%rsi
   12c22:	75 ec                	jne    12c10 <fwp_fmt_duration+0x8e0>
   12c24:	c6 44 04 01 00       	movb   $0x0,0x1(%rsp,%rax,1)
   12c29:	48 8b 0b             	mov    (%rbx),%rcx
   12c2c:	48 8d 35 96 3b 00 00 	lea    0x3b96(%rip),%rsi        # 167c9 <exec_in_fp0+0xf59>
   12c33:	48 89 e2             	mov    %rsp,%rdx
   12c36:	31 c0                	xor    %eax,%eax
   12c38:	e8 13 08 ff ff       	call   3450 <sprintf@plt>
   12c3d:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
   12c44:	5b                   	pop    %rbx
   12c45:	41 5c                	pop    %r12
   12c47:	41 5e                	pop    %r14
   12c49:	41 5f                	pop    %r15
   12c4b:	c3                   	ret
   12c4c:	45 31 c9             	xor    %r9d,%r9d
   12c4f:	48 f7 de             	neg    %rsi
   12c52:	41 ba 00 00 00 00    	mov    $0x0,%r10d
   12c58:	4d 19 c2             	sbb    %r8,%r10
   12c5b:	c6 04 24 2d          	movb   $0x2d,(%rsp)
   12c5f:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
   12c66:	cc cc cc 
   12c69:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
   12c70:	cc cc cc 
   12c73:	4d 89 d6             	mov    %r10,%r14
   12c76:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   12c7d:	00 00 00 
   12c80:	4c 89 d1             	mov    %r10,%rcx
   12c83:	48 0f a4 f1 3f       	shld   $0x3f,%rsi,%rcx
   12c88:	49 d1 ee             	shr    $1,%r14
   12c8b:	49 89 c8             	mov    %rcx,%r8
   12c8e:	4d 01 f0             	add    %r14,%r8
   12c91:	49 83 d0 00          	adc    $0x0,%r8
   12c95:	4c 89 c0             	mov    %r8,%rax
   12c98:	49 f7 e3             	mul    %r11
   12c9b:	48 c1 ea 02          	shr    $0x2,%rdx
   12c9f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   12ca3:	49 29 c0             	sub    %rax,%r8
   12ca6:	4c 29 c1             	sub    %r8,%rcx
   12ca9:	49 83 de 00          	sbb    $0x0,%r14
   12cad:	49 89 c8             	mov    %rcx,%r8
   12cb0:	4c 0f af c3          	imul   %rbx,%r8
   12cb4:	48 89 c8             	mov    %rcx,%rax
   12cb7:	49 f7 e3             	mul    %r11
   12cba:	4c 01 c2             	add    %r8,%rdx
   12cbd:	4d 0f af f3          	imul   %r11,%r14
   12cc1:	49 01 d6             	add    %rdx,%r14
   12cc4:	48 89 c1             	mov    %rax,%rcx
   12cc7:	48 01 c1             	add    %rax,%rcx
   12cca:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
   12cce:	89 f2                	mov    %esi,%edx
   12cd0:	29 ca                	sub    %ecx,%edx
   12cd2:	80 ca 30             	or     $0x30,%dl
   12cd5:	42 88 54 0c 40       	mov    %dl,0x40(%rsp,%r9,1)
   12cda:	49 ff c1             	inc    %r9
   12cdd:	48 83 fe 0a          	cmp    $0xa,%rsi
   12ce1:	49 83 da 00          	sbb    $0x0,%r10
   12ce5:	48 89 c6             	mov    %rax,%rsi
   12ce8:	4d 89 f2             	mov    %r14,%r10
   12ceb:	73 93                	jae    12c80 <fwp_fmt_duration+0x950>
   12ced:	45 85 c9             	test   %r9d,%r9d
   12cf0:	7e 13                	jle    12d05 <fwp_fmt_duration+0x9d5>
   12cf2:	44 89 c8             	mov    %r9d,%eax
   12cf5:	48 83 f8 08          	cmp    $0x8,%rax
   12cf9:	73 11                	jae    12d0c <fwp_fmt_duration+0x9dc>
   12cfb:	31 c9                	xor    %ecx,%ecx
   12cfd:	48 89 c2             	mov    %rax,%rdx
   12d00:	e9 29 01 00 00       	jmp    12e2e <fwp_fmt_duration+0xafe>
   12d05:	31 c0                	xor    %eax,%eax
   12d07:	e9 48 01 00 00       	jmp    12e54 <fwp_fmt_duration+0xb24>
   12d0c:	83 f8 20             	cmp    $0x20,%eax
   12d0f:	73 07                	jae    12d18 <fwp_fmt_duration+0x9e8>
   12d11:	31 c9                	xor    %ecx,%ecx
   12d13:	e9 b5 00 00 00       	jmp    12dcd <fwp_fmt_duration+0xa9d>
   12d18:	44 89 ce             	mov    %r9d,%esi
   12d1b:	44 89 ca             	mov    %r9d,%edx
   12d1e:	83 e2 1f             	and    $0x1f,%edx
   12d21:	48 89 c1             	mov    %rax,%rcx
   12d24:	48 29 d1             	sub    %rdx,%rcx
   12d27:	4c 8d 04 34          	lea    (%rsp,%rsi,1),%r8
   12d2b:	49 83 c0 30          	add    $0x30,%r8
   12d2f:	48 29 d6             	sub    %rdx,%rsi
   12d32:	45 31 d2             	xor    %r10d,%r10d
   12d35:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12d39:	f3 41 0f 6f 48 f0    	movdqu -0x10(%r8),%xmm1
   12d3f:	f3 41 0f 6f 10       	movdqu (%r8),%xmm2
   12d44:	66 0f 6f da          	movdqa %xmm2,%xmm3
   12d48:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12d4c:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12d51:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   12d56:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12d5b:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   12d5f:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   12d64:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   12d69:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   12d6e:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   12d72:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   12d76:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12d7a:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12d7f:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   12d84:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12d89:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   12d8d:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   12d92:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12d97:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12d9c:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   12da0:	f3 42 0f 7f 54 14 01 	movdqu %xmm2,0x1(%rsp,%r10,1)
   12da7:	f3 42 0f 7f 4c 14 11 	movdqu %xmm1,0x11(%rsp,%r10,1)
   12dae:	49 83 c2 20          	add    $0x20,%r10
   12db2:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
   12db6:	4c 39 d6             	cmp    %r10,%rsi
   12db9:	0f 85 7a ff ff ff    	jne    12d39 <fwp_fmt_duration+0xa09>
   12dbf:	48 85 d2             	test   %rdx,%rdx
   12dc2:	0f 84 8c 00 00 00    	je     12e54 <fwp_fmt_duration+0xb24>
   12dc8:	83 fa 08             	cmp    $0x8,%edx
   12dcb:	72 61                	jb     12e2e <fwp_fmt_duration+0xafe>
   12dcd:	48 89 ce             	mov    %rcx,%rsi
   12dd0:	45 89 c8             	mov    %r9d,%r8d
   12dd3:	44 89 ca             	mov    %r9d,%edx
   12dd6:	83 e2 07             	and    $0x7,%edx
   12dd9:	48 89 c1             	mov    %rax,%rcx
   12ddc:	48 29 d1             	sub    %rdx,%rcx
   12ddf:	49 89 f2             	mov    %rsi,%r10
   12de2:	49 f7 da             	neg    %r10
   12de5:	49 01 e2             	add    %rsp,%r10
   12de8:	49 83 c2 40          	add    $0x40,%r10
   12dec:	4d 01 c2             	add    %r8,%r10
   12def:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
   12df3:	49 29 d0             	sub    %rdx,%r8
   12df6:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12dfa:	f3 41 0f 7e 0a       	movq   (%r10),%xmm1
   12dff:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   12e03:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   12e08:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12e0d:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12e12:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   12e16:	66 0f d6 4c 34 01    	movq   %xmm1,0x1(%rsp,%rsi,1)
   12e1c:	48 83 c6 08          	add    $0x8,%rsi
   12e20:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
   12e24:	49 39 f0             	cmp    %rsi,%r8
   12e27:	75 d1                	jne    12dfa <fwp_fmt_duration+0xaca>
   12e29:	48 85 d2             	test   %rdx,%rdx
   12e2c:	74 26                	je     12e54 <fwp_fmt_duration+0xb24>
   12e2e:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
   12e33:	48 01 f2             	add    %rsi,%rdx
   12e36:	48 ff ca             	dec    %rdx
   12e39:	44 89 ce             	mov    %r9d,%esi
   12e3c:	0f 1f 40 00          	nopl   0x0(%rax)
   12e40:	44 0f b6 02          	movzbl (%rdx),%r8d
   12e44:	44 88 44 0c 01       	mov    %r8b,0x1(%rsp,%rcx,1)
   12e49:	48 ff c1             	inc    %rcx
   12e4c:	48 ff ca             	dec    %rdx
   12e4f:	48 39 ce             	cmp    %rcx,%rsi
   12e52:	75 ec                	jne    12e40 <fwp_fmt_duration+0xb10>
   12e54:	c6 44 04 01 00       	movb   $0x0,0x1(%rsp,%rax,1)
   12e59:	e9 28 f9 ff ff       	jmp    12786 <fwp_fmt_duration+0x456>
   12e5e:	66 90                	xchg   %ax,%ax

0000000000012e60 <fwp_format_g>:
   12e60:	55                   	push   %rbp
   12e61:	41 57                	push   %r15
   12e63:	41 56                	push   %r14
   12e65:	41 55                	push   %r13
   12e67:	41 54                	push   %r12
   12e69:	53                   	push   %rbx
   12e6a:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   12e71:	89 f5                	mov    %esi,%ebp
   12e73:	48 89 fb             	mov    %rdi,%rbx
   12e76:	ff cd                	dec    %ebp
   12e78:	48 8d 15 1d 39 00 00 	lea    0x391d(%rip),%rdx        # 1679c <exec_in_fp0+0xf2c>
   12e7f:	4c 8d 64 24 50       	lea    0x50(%rsp),%r12
   12e84:	be 40 00 00 00       	mov    $0x40,%esi
   12e89:	4c 89 e7             	mov    %r12,%rdi
   12e8c:	89 e9                	mov    %ebp,%ecx
   12e8e:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
   12e94:	b0 01                	mov    $0x1,%al
   12e96:	e8 35 03 ff ff       	call   31d0 <snprintf@plt>
   12e9b:	4c 89 e7             	mov    %r12,%rdi
   12e9e:	be 65 00 00 00       	mov    $0x65,%esi
   12ea3:	e8 08 03 ff ff       	call   31b0 <strchr@plt>
   12ea8:	49 89 c7             	mov    %rax,%r15
   12eab:	48 8d 78 01          	lea    0x1(%rax),%rdi
   12eaf:	45 31 ed             	xor    %r13d,%r13d
   12eb2:	31 f6                	xor    %esi,%esi
   12eb4:	ba 0a 00 00 00       	mov    $0xa,%edx
   12eb9:	e8 62 04 ff ff       	call   3320 <strtol@plt>
   12ebe:	49 89 c6             	mov    %rax,%r14
   12ec1:	83 c0 ef             	add    $0xffffffef,%eax
   12ec4:	83 f8 e9             	cmp    $0xffffffe9,%eax
   12ec7:	77 5f                	ja     12f28 <fwp_format_g+0xc8>
   12ec9:	4d 29 e7             	sub    %r12,%r15
   12ecc:	4c 8d 6c 24 10       	lea    0x10(%rsp),%r13
   12ed1:	4c 89 ef             	mov    %r13,%rdi
   12ed4:	4c 89 e6             	mov    %r12,%rsi
   12ed7:	4c 89 fa             	mov    %r15,%rdx
   12eda:	e8 51 04 ff ff       	call   3330 <memcpy@plt>
   12edf:	42 c6 44 3c 10 00    	movb   $0x0,0x10(%rsp,%r15,1)
   12ee5:	4c 89 ef             	mov    %r13,%rdi
   12ee8:	be 2e 00 00 00       	mov    $0x2e,%esi
   12eed:	e8 be 02 ff ff       	call   31b0 <strchr@plt>
   12ef2:	48 85 c0             	test   %rax,%rax
   12ef5:	0f 84 a8 00 00 00    	je     12fa3 <fwp_format_g+0x143>
   12efb:	4d 85 ff             	test   %r15,%r15
   12efe:	0f 84 9f 00 00 00    	je     12fa3 <fwp_format_g+0x143>
   12f04:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
   12f0b:	00 00 00 00 00 
   12f10:	42 0f b6 44 3c 0f    	movzbl 0xf(%rsp,%r15,1),%eax
   12f16:	83 f8 30             	cmp    $0x30,%eax
   12f19:	75 7d                	jne    12f98 <fwp_format_g+0x138>
   12f1b:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
   12f21:	49 ff cf             	dec    %r15
   12f24:	75 ea                	jne    12f10 <fwp_format_g+0xb0>
   12f26:	eb 7b                	jmp    12fa3 <fwp_format_g+0x143>
   12f28:	44 29 f5             	sub    %r14d,%ebp
   12f2b:	85 ed                	test   %ebp,%ebp
   12f2d:	44 0f 4f ed          	cmovg  %ebp,%r13d
   12f31:	48 8d 15 73 38 00 00 	lea    0x3873(%rip),%rdx        # 167ab <exec_in_fp0+0xf3b>
   12f38:	be 90 01 00 00       	mov    $0x190,%esi
   12f3d:	48 89 df             	mov    %rbx,%rdi
   12f40:	44 89 e9             	mov    %r13d,%ecx
   12f43:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
   12f49:	b0 01                	mov    $0x1,%al
   12f4b:	e8 80 02 ff ff       	call   31d0 <snprintf@plt>
   12f50:	48 89 df             	mov    %rbx,%rdi
   12f53:	e8 18 02 ff ff       	call   3170 <strlen@plt>
   12f58:	49 89 c6             	mov    %rax,%r14
   12f5b:	48 89 df             	mov    %rbx,%rdi
   12f5e:	be 2e 00 00 00       	mov    $0x2e,%esi
   12f63:	e8 48 02 ff ff       	call   31b0 <strchr@plt>
   12f68:	48 85 c0             	test   %rax,%rax
   12f6b:	74 69                	je     12fd6 <fwp_format_g+0x176>
   12f6d:	4d 85 f6             	test   %r14,%r14
   12f70:	74 64                	je     12fd6 <fwp_format_g+0x176>
   12f72:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   12f79:	1f 84 00 00 00 00 00 
   12f80:	42 0f b6 44 33 ff    	movzbl -0x1(%rbx,%r14,1),%eax
   12f86:	83 f8 30             	cmp    $0x30,%eax
   12f89:	75 5d                	jne    12fe8 <fwp_format_g+0x188>
   12f8b:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
   12f91:	49 ff ce             	dec    %r14
   12f94:	75 ea                	jne    12f80 <fwp_format_g+0x120>
   12f96:	eb 3e                	jmp    12fd6 <fwp_format_g+0x176>
   12f98:	83 f8 2e             	cmp    $0x2e,%eax
   12f9b:	75 06                	jne    12fa3 <fwp_format_g+0x143>
   12f9d:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
   12fa3:	44 89 f0             	mov    %r14d,%eax
   12fa6:	c1 e8 1f             	shr    $0x1f,%eax
   12fa9:	44 8d 04 45 2b 00 00 	lea    0x2b(,%rax,2),%r8d
   12fb0:	00 
   12fb1:	45 89 f1             	mov    %r14d,%r9d
   12fb4:	41 f7 d9             	neg    %r9d
   12fb7:	45 0f 48 ce          	cmovs  %r14d,%r9d
   12fbb:	48 8d 15 df 37 00 00 	lea    0x37df(%rip),%rdx        # 167a1 <exec_in_fp0+0xf31>
   12fc2:	48 8d 4c 24 10       	lea    0x10(%rsp),%rcx
   12fc7:	be 90 01 00 00       	mov    $0x190,%esi
   12fcc:	48 89 df             	mov    %rbx,%rdi
   12fcf:	31 c0                	xor    %eax,%eax
   12fd1:	e8 fa 01 ff ff       	call   31d0 <snprintf@plt>
   12fd6:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
   12fdd:	5b                   	pop    %rbx
   12fde:	41 5c                	pop    %r12
   12fe0:	41 5d                	pop    %r13
   12fe2:	41 5e                	pop    %r14
   12fe4:	41 5f                	pop    %r15
   12fe6:	5d                   	pop    %rbp
   12fe7:	c3                   	ret
   12fe8:	83 f8 2e             	cmp    $0x2e,%eax
   12feb:	75 e9                	jne    12fd6 <fwp_format_g+0x176>
   12fed:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
   12ff3:	eb e1                	jmp    12fd6 <fwp_format_g+0x176>
   12ff5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   12ffc:	00 00 00 00 

0000000000013000 <fwp_encode>:
   13000:	55                   	push   %rbp
   13001:	41 57                	push   %r15
   13003:	41 56                	push   %r14
   13005:	41 55                	push   %r13
   13007:	41 54                	push   %r12
   13009:	53                   	push   %rbx
   1300a:	48 83 ec 28          	sub    $0x28,%rsp
   1300e:	8b 02                	mov    (%rdx),%eax
   13010:	48 83 f8 15          	cmp    $0x15,%rax
   13014:	0f 87 91 01 00 00    	ja     131ab <fwp_encode+0x1ab>
   1301a:	49 89 d6             	mov    %rdx,%r14
   1301d:	48 89 f3             	mov    %rsi,%rbx
   13020:	48 89 7c 24 08       	mov    %rdi,0x8(%rsp)
   13025:	48 8d 0d e0 25 00 00 	lea    0x25e0(%rip),%rcx        # 1560c <_IO_stdin_used+0x60c>
   1302c:	48 63 04 81          	movslq (%rcx,%rax,4),%rax
   13030:	48 01 c8             	add    %rcx,%rax
   13033:	ff e0                	jmp    *%rax
   13035:	88 5c 24 07          	mov    %bl,0x7(%rsp)
   13039:	4c 8d 74 24 07       	lea    0x7(%rsp),%r14
   1303e:	ba 01 00 00 00       	mov    $0x1,%edx
   13043:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
   13048:	4c 89 ff             	mov    %r15,%rdi
   1304b:	4c 89 f6             	mov    %r14,%rsi
   1304e:	e8 7d a1 ff ff       	call   d1d0 <buf_put>
   13053:	88 7c 24 07          	mov    %bh,0x7(%rsp)
   13057:	ba 01 00 00 00       	mov    $0x1,%edx
   1305c:	4c 89 ff             	mov    %r15,%rdi
   1305f:	4c 89 f6             	mov    %r14,%rsi
   13062:	e8 69 a1 ff ff       	call   d1d0 <buf_put>
   13067:	89 d8                	mov    %ebx,%eax
   13069:	c1 e8 10             	shr    $0x10,%eax
   1306c:	88 44 24 07          	mov    %al,0x7(%rsp)
   13070:	ba 01 00 00 00       	mov    $0x1,%edx
   13075:	4c 89 ff             	mov    %r15,%rdi
   13078:	4c 89 f6             	mov    %r14,%rsi
   1307b:	e8 50 a1 ff ff       	call   d1d0 <buf_put>
   13080:	89 d8                	mov    %ebx,%eax
   13082:	c1 e8 18             	shr    $0x18,%eax
   13085:	88 44 24 07          	mov    %al,0x7(%rsp)
   13089:	ba 01 00 00 00       	mov    $0x1,%edx
   1308e:	4c 89 ff             	mov    %r15,%rdi
   13091:	4c 89 f6             	mov    %r14,%rsi
   13094:	e8 37 a1 ff ff       	call   d1d0 <buf_put>
   13099:	48 89 d8             	mov    %rbx,%rax
   1309c:	48 c1 e8 20          	shr    $0x20,%rax
   130a0:	88 44 24 07          	mov    %al,0x7(%rsp)
   130a4:	ba 01 00 00 00       	mov    $0x1,%edx
   130a9:	4c 89 ff             	mov    %r15,%rdi
   130ac:	4c 89 f6             	mov    %r14,%rsi
   130af:	e8 1c a1 ff ff       	call   d1d0 <buf_put>
   130b4:	48 89 d8             	mov    %rbx,%rax
   130b7:	48 c1 e8 28          	shr    $0x28,%rax
   130bb:	88 44 24 07          	mov    %al,0x7(%rsp)
   130bf:	ba 01 00 00 00       	mov    $0x1,%edx
   130c4:	4c 89 ff             	mov    %r15,%rdi
   130c7:	4c 89 f6             	mov    %r14,%rsi
   130ca:	e8 01 a1 ff ff       	call   d1d0 <buf_put>
   130cf:	48 89 d8             	mov    %rbx,%rax
   130d2:	48 c1 e8 30          	shr    $0x30,%rax
   130d6:	88 44 24 07          	mov    %al,0x7(%rsp)
   130da:	ba 01 00 00 00       	mov    $0x1,%edx
   130df:	4c 89 ff             	mov    %r15,%rdi
   130e2:	4c 89 f6             	mov    %r14,%rsi
   130e5:	e8 e6 a0 ff ff       	call   d1d0 <buf_put>
   130ea:	48 c1 eb 38          	shr    $0x38,%rbx
   130ee:	eb 66                	jmp    13156 <fwp_encode+0x156>
   130f0:	88 5c 24 07          	mov    %bl,0x7(%rsp)
   130f4:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
   130f9:	ba 01 00 00 00       	mov    $0x1,%edx
   130fe:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
   13103:	e9 9e 00 00 00       	jmp    131a6 <fwp_encode+0x1a6>
   13108:	88 5c 24 07          	mov    %bl,0x7(%rsp)
   1310c:	4c 8d 74 24 07       	lea    0x7(%rsp),%r14
   13111:	ba 01 00 00 00       	mov    $0x1,%edx
   13116:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
   1311b:	4c 89 ff             	mov    %r15,%rdi
   1311e:	4c 89 f6             	mov    %r14,%rsi
   13121:	e8 aa a0 ff ff       	call   d1d0 <buf_put>
   13126:	88 7c 24 07          	mov    %bh,0x7(%rsp)
   1312a:	ba 01 00 00 00       	mov    $0x1,%edx
   1312f:	4c 89 ff             	mov    %r15,%rdi
   13132:	4c 89 f6             	mov    %r14,%rsi
   13135:	e8 96 a0 ff ff       	call   d1d0 <buf_put>
   1313a:	89 d8                	mov    %ebx,%eax
   1313c:	c1 e8 10             	shr    $0x10,%eax
   1313f:	88 44 24 07          	mov    %al,0x7(%rsp)
   13143:	ba 01 00 00 00       	mov    $0x1,%edx
   13148:	4c 89 ff             	mov    %r15,%rdi
   1314b:	4c 89 f6             	mov    %r14,%rsi
   1314e:	e8 7d a0 ff ff       	call   d1d0 <buf_put>
   13153:	c1 eb 18             	shr    $0x18,%ebx
   13156:	88 5c 24 07          	mov    %bl,0x7(%rsp)
   1315a:	eb 3f                	jmp    1319b <fwp_encode+0x19b>
   1315c:	4c 8b 3b             	mov    (%rbx),%r15
   1315f:	49 81 ff 80 00 00 00 	cmp    $0x80,%r15
   13166:	0f 83 4a 02 00 00    	jae    133b6 <fwp_encode+0x3b6>
   1316c:	4d 89 fd             	mov    %r15,%r13
   1316f:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   13174:	e9 80 02 00 00       	jmp    133f9 <fwp_encode+0x3f9>
   13179:	88 5c 24 07          	mov    %bl,0x7(%rsp)
   1317d:	4c 8d 74 24 07       	lea    0x7(%rsp),%r14
   13182:	ba 01 00 00 00       	mov    $0x1,%edx
   13187:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
   1318c:	4c 89 ff             	mov    %r15,%rdi
   1318f:	4c 89 f6             	mov    %r14,%rsi
   13192:	e8 39 a0 ff ff       	call   d1d0 <buf_put>
   13197:	88 7c 24 07          	mov    %bh,0x7(%rsp)
   1319b:	ba 01 00 00 00       	mov    $0x1,%edx
   131a0:	4c 89 ff             	mov    %r15,%rdi
   131a3:	4c 89 f6             	mov    %r14,%rsi
   131a6:	e8 25 a0 ff ff       	call   d1d0 <buf_put>
   131ab:	48 83 c4 28          	add    $0x28,%rsp
   131af:	5b                   	pop    %rbx
   131b0:	41 5c                	pop    %r12
   131b2:	41 5d                	pop    %r13
   131b4:	41 5e                	pop    %r14
   131b6:	41 5f                	pop    %r15
   131b8:	5d                   	pop    %rbp
   131b9:	c3                   	ret
   131ba:	48 8b 03             	mov    (%rbx),%rax
   131bd:	4c 8b 6b 08          	mov    0x8(%rbx),%r13
   131c1:	88 44 24 07          	mov    %al,0x7(%rsp)
   131c5:	48 89 c3             	mov    %rax,%rbx
   131c8:	4c 8d 74 24 07       	lea    0x7(%rsp),%r14
   131cd:	ba 01 00 00 00       	mov    $0x1,%edx
   131d2:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   131d7:	4c 89 e7             	mov    %r12,%rdi
   131da:	4c 89 f6             	mov    %r14,%rsi
   131dd:	e8 ee 9f ff ff       	call   d1d0 <buf_put>
   131e2:	88 7c 24 07          	mov    %bh,0x7(%rsp)
   131e6:	ba 01 00 00 00       	mov    $0x1,%edx
   131eb:	4c 89 e7             	mov    %r12,%rdi
   131ee:	4c 89 f6             	mov    %r14,%rsi
   131f1:	e8 da 9f ff ff       	call   d1d0 <buf_put>
   131f6:	44 89 e8             	mov    %r13d,%eax
   131f9:	c1 e8 10             	shr    $0x10,%eax
   131fc:	89 44 24 14          	mov    %eax,0x14(%rsp)
   13200:	89 d8                	mov    %ebx,%eax
   13202:	c1 e8 10             	shr    $0x10,%eax
   13205:	88 44 24 07          	mov    %al,0x7(%rsp)
   13209:	ba 01 00 00 00       	mov    $0x1,%edx
   1320e:	4c 89 e7             	mov    %r12,%rdi
   13211:	4c 89 f6             	mov    %r14,%rsi
   13214:	e8 b7 9f ff ff       	call   d1d0 <buf_put>
   13219:	44 89 e8             	mov    %r13d,%eax
   1321c:	c1 e8 18             	shr    $0x18,%eax
   1321f:	89 44 24 10          	mov    %eax,0x10(%rsp)
   13223:	89 d8                	mov    %ebx,%eax
   13225:	c1 e8 18             	shr    $0x18,%eax
   13228:	88 44 24 07          	mov    %al,0x7(%rsp)
   1322c:	ba 01 00 00 00       	mov    $0x1,%edx
   13231:	4c 89 e7             	mov    %r12,%rdi
   13234:	4c 89 f6             	mov    %r14,%rsi
   13237:	e8 94 9f ff ff       	call   d1d0 <buf_put>
   1323c:	4c 89 e8             	mov    %r13,%rax
   1323f:	48 c1 e8 20          	shr    $0x20,%rax
   13243:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   13248:	48 89 d8             	mov    %rbx,%rax
   1324b:	48 c1 e8 20          	shr    $0x20,%rax
   1324f:	88 44 24 07          	mov    %al,0x7(%rsp)
   13253:	ba 01 00 00 00       	mov    $0x1,%edx
   13258:	4c 89 e7             	mov    %r12,%rdi
   1325b:	4c 89 f6             	mov    %r14,%rsi
   1325e:	e8 6d 9f ff ff       	call   d1d0 <buf_put>
   13263:	4c 89 e8             	mov    %r13,%rax
   13266:	48 c1 e8 28          	shr    $0x28,%rax
   1326a:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
   1326f:	48 89 d8             	mov    %rbx,%rax
   13272:	48 c1 e8 28          	shr    $0x28,%rax
   13276:	88 44 24 07          	mov    %al,0x7(%rsp)
   1327a:	ba 01 00 00 00       	mov    $0x1,%edx
   1327f:	4c 89 e7             	mov    %r12,%rdi
   13282:	4c 89 f6             	mov    %r14,%rsi
   13285:	e8 46 9f ff ff       	call   d1d0 <buf_put>
   1328a:	4d 89 ef             	mov    %r13,%r15
   1328d:	49 c1 ef 30          	shr    $0x30,%r15
   13291:	48 89 d8             	mov    %rbx,%rax
   13294:	48 c1 e8 30          	shr    $0x30,%rax
   13298:	88 44 24 07          	mov    %al,0x7(%rsp)
   1329c:	ba 01 00 00 00       	mov    $0x1,%edx
   132a1:	4c 89 e7             	mov    %r12,%rdi
   132a4:	4c 89 f6             	mov    %r14,%rsi
   132a7:	e8 24 9f ff ff       	call   d1d0 <buf_put>
   132ac:	4c 89 ed             	mov    %r13,%rbp
   132af:	48 c1 ed 38          	shr    $0x38,%rbp
   132b3:	48 c1 eb 38          	shr    $0x38,%rbx
   132b7:	88 5c 24 07          	mov    %bl,0x7(%rsp)
   132bb:	ba 01 00 00 00       	mov    $0x1,%edx
   132c0:	4c 89 e7             	mov    %r12,%rdi
   132c3:	4c 89 f6             	mov    %r14,%rsi
   132c6:	e8 05 9f ff ff       	call   d1d0 <buf_put>
   132cb:	44 88 6c 24 07       	mov    %r13b,0x7(%rsp)
   132d0:	4c 89 eb             	mov    %r13,%rbx
   132d3:	4c 8d 74 24 07       	lea    0x7(%rsp),%r14
   132d8:	ba 01 00 00 00       	mov    $0x1,%edx
   132dd:	4c 89 e7             	mov    %r12,%rdi
   132e0:	4c 89 f6             	mov    %r14,%rsi
   132e3:	e8 e8 9e ff ff       	call   d1d0 <buf_put>
   132e8:	88 7c 24 07          	mov    %bh,0x7(%rsp)
   132ec:	ba 01 00 00 00       	mov    $0x1,%edx
   132f1:	4c 89 e7             	mov    %r12,%rdi
   132f4:	4c 89 f6             	mov    %r14,%rsi
   132f7:	e8 d4 9e ff ff       	call   d1d0 <buf_put>
   132fc:	8b 44 24 14          	mov    0x14(%rsp),%eax
   13300:	88 44 24 07          	mov    %al,0x7(%rsp)
   13304:	ba 01 00 00 00       	mov    $0x1,%edx
   13309:	4c 89 e7             	mov    %r12,%rdi
   1330c:	4c 89 f6             	mov    %r14,%rsi
   1330f:	e8 bc 9e ff ff       	call   d1d0 <buf_put>
   13314:	8b 44 24 10          	mov    0x10(%rsp),%eax
   13318:	88 44 24 07          	mov    %al,0x7(%rsp)
   1331c:	ba 01 00 00 00       	mov    $0x1,%edx
   13321:	4c 89 e7             	mov    %r12,%rdi
   13324:	4c 89 f6             	mov    %r14,%rsi
   13327:	e8 a4 9e ff ff       	call   d1d0 <buf_put>
   1332c:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
   13331:	88 44 24 07          	mov    %al,0x7(%rsp)
   13335:	ba 01 00 00 00       	mov    $0x1,%edx
   1333a:	4c 89 e7             	mov    %r12,%rdi
   1333d:	4c 89 f6             	mov    %r14,%rsi
   13340:	e8 8b 9e ff ff       	call   d1d0 <buf_put>
   13345:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
   1334a:	88 44 24 07          	mov    %al,0x7(%rsp)
   1334e:	ba 01 00 00 00       	mov    $0x1,%edx
   13353:	4c 89 e7             	mov    %r12,%rdi
   13356:	4c 89 f6             	mov    %r14,%rsi
   13359:	e8 72 9e ff ff       	call   d1d0 <buf_put>
   1335e:	44 88 7c 24 07       	mov    %r15b,0x7(%rsp)
   13363:	ba 01 00 00 00       	mov    $0x1,%edx
   13368:	4c 89 e7             	mov    %r12,%rdi
   1336b:	4c 89 f6             	mov    %r14,%rsi
   1336e:	e8 5d 9e ff ff       	call   d1d0 <buf_put>
   13373:	40 88 6c 24 07       	mov    %bpl,0x7(%rsp)
   13378:	ba 01 00 00 00       	mov    $0x1,%edx
   1337d:	4c 89 e7             	mov    %r12,%rdi
   13380:	e9 1e fe ff ff       	jmp    131a3 <fwp_encode+0x1a3>
   13385:	4c 8b 2b             	mov    (%rbx),%r13
   13388:	49 81 fd 80 00 00 00 	cmp    $0x80,%r13
   1338f:	0f 83 dc 00 00 00    	jae    13471 <fwp_encode+0x471>
   13395:	4c 89 ed             	mov    %r13,%rbp
   13398:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   1339d:	e9 07 01 00 00       	jmp    134a9 <fwp_encode+0x4a9>
   133a2:	48 81 fb ff 0f 00 00 	cmp    $0xfff,%rbx
   133a9:	0f 87 d1 01 00 00    	ja     13580 <fwp_encode+0x580>
   133af:	89 d8                	mov    %ebx,%eax
   133b1:	e9 cc 01 00 00       	jmp    13582 <fwp_encode+0x582>
   133b6:	4c 8d 74 24 07       	lea    0x7(%rsp),%r14
   133bb:	4d 89 fd             	mov    %r15,%r13
   133be:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   133c3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   133ca:	84 00 00 00 00 00 
   133d0:	49 c1 ed 07          	shr    $0x7,%r13
   133d4:	44 89 f8             	mov    %r15d,%eax
   133d7:	0c 80                	or     $0x80,%al
   133d9:	88 44 24 07          	mov    %al,0x7(%rsp)
   133dd:	ba 01 00 00 00       	mov    $0x1,%edx
   133e2:	4c 89 e7             	mov    %r12,%rdi
   133e5:	4c 89 f6             	mov    %r14,%rsi
   133e8:	e8 e3 9d ff ff       	call   d1d0 <buf_put>
   133ed:	49 81 ff ff 3f 00 00 	cmp    $0x3fff,%r15
   133f4:	4d 89 ef             	mov    %r13,%r15
   133f7:	77 d7                	ja     133d0 <fwp_encode+0x3d0>
   133f9:	44 88 6c 24 07       	mov    %r13b,0x7(%rsp)
   133fe:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
   13403:	ba 01 00 00 00       	mov    $0x1,%edx
   13408:	4c 89 e7             	mov    %r12,%rdi
   1340b:	e8 c0 9d ff ff       	call   d1d0 <buf_put>
   13410:	48 8b 13             	mov    (%rbx),%rdx
   13413:	48 83 c3 08          	add    $0x8,%rbx
   13417:	4c 89 e7             	mov    %r12,%rdi
   1341a:	48 89 de             	mov    %rbx,%rsi
   1341d:	48 83 c4 28          	add    $0x28,%rsp
   13421:	5b                   	pop    %rbx
   13422:	41 5c                	pop    %r12
   13424:	41 5d                	pop    %r13
   13426:	41 5e                	pop    %r14
   13428:	41 5f                	pop    %r15
   1342a:	5d                   	pop    %rbp
   1342b:	e9 a0 9d ff ff       	jmp    d1d0 <buf_put>
   13430:	48 85 db             	test   %rbx,%rbx
   13433:	0f 84 15 03 00 00    	je     1374e <fwp_encode+0x74e>
   13439:	45 31 ed             	xor    %r13d,%r13d
   1343c:	48 89 d8             	mov    %rbx,%rax
   1343f:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   13444:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
   1344b:	00 00 00 00 00 
   13450:	49 ff c5             	inc    %r13
   13453:	48 8b 40 10          	mov    0x10(%rax),%rax
   13457:	48 85 c0             	test   %rax,%rax
   1345a:	75 f4                	jne    13450 <fwp_encode+0x450>
   1345c:	49 81 fd 80 00 00 00 	cmp    $0x80,%r13
   13463:	0f 83 ef 02 00 00    	jae    13758 <fwp_encode+0x758>
   13469:	4c 89 ed             	mov    %r13,%rbp
   1346c:	e9 18 03 00 00       	jmp    13789 <fwp_encode+0x789>
   13471:	4c 8d 7c 24 07       	lea    0x7(%rsp),%r15
   13476:	4c 89 ed             	mov    %r13,%rbp
   13479:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   1347e:	66 90                	xchg   %ax,%ax
   13480:	48 c1 ed 07          	shr    $0x7,%rbp
   13484:	44 89 e8             	mov    %r13d,%eax
   13487:	0c 80                	or     $0x80,%al
   13489:	88 44 24 07          	mov    %al,0x7(%rsp)
   1348d:	ba 01 00 00 00       	mov    $0x1,%edx
   13492:	4c 89 e7             	mov    %r12,%rdi
   13495:	4c 89 fe             	mov    %r15,%rsi
   13498:	e8 33 9d ff ff       	call   d1d0 <buf_put>
   1349d:	49 81 fd ff 3f 00 00 	cmp    $0x3fff,%r13
   134a4:	49 89 ed             	mov    %rbp,%r13
   134a7:	77 d7                	ja     13480 <fwp_encode+0x480>
   134a9:	40 88 6c 24 07       	mov    %bpl,0x7(%rsp)
   134ae:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
   134b3:	ba 01 00 00 00       	mov    $0x1,%edx
   134b8:	4c 89 e7             	mov    %r12,%rdi
   134bb:	e8 10 9d ff ff       	call   d1d0 <buf_put>
   134c0:	48 83 3b 00          	cmpq   $0x0,(%rbx)
   134c4:	0f 84 e1 fc ff ff    	je     131ab <fwp_encode+0x1ab>
   134ca:	4c 8d 7b 10          	lea    0x10(%rbx),%r15
   134ce:	45 31 ed             	xor    %r13d,%r13d
   134d1:	eb 1d                	jmp    134f0 <fwp_encode+0x4f0>
   134d3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   134da:	84 00 00 00 00 00 
   134e0:	49 ff c5             	inc    %r13
   134e3:	49 83 c7 10          	add    $0x10,%r15
   134e7:	4c 3b 2b             	cmp    (%rbx),%r13
   134ea:	0f 83 bb fc ff ff    	jae    131ab <fwp_encode+0x1ab>
   134f0:	49 8b 77 f8          	mov    -0x8(%r15),%rsi
   134f4:	49 8b 56 38          	mov    0x38(%r14),%rdx
   134f8:	4c 89 e7             	mov    %r12,%rdi
   134fb:	e8 00 fb ff ff       	call   13000 <fwp_encode>
   13500:	41 83 3e 12          	cmpl   $0x12,(%r14)
   13504:	75 da                	jne    134e0 <fwp_encode+0x4e0>
   13506:	49 8b 37             	mov    (%r15),%rsi
   13509:	49 8b 56 40          	mov    0x40(%r14),%rdx
   1350d:	4c 89 e7             	mov    %r12,%rdi
   13510:	e8 eb fa ff ff       	call   13000 <fwp_encode>
   13515:	eb c9                	jmp    134e0 <fwp_encode+0x4e0>
   13517:	41 83 7e 10 00       	cmpl   $0x0,0x10(%r14)
   1351c:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   13521:	0f 8e 84 fc ff ff    	jle    131ab <fwp_encode+0x1ab>
   13527:	45 31 ff             	xor    %r15d,%r15d
   1352a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   13530:	4a 8b 74 fb 08       	mov    0x8(%rbx,%r15,8),%rsi
   13535:	49 8b 46 20          	mov    0x20(%r14),%rax
   13539:	4a 8b 14 f8          	mov    (%rax,%r15,8),%rdx
   1353d:	4c 89 e7             	mov    %r12,%rdi
   13540:	e8 bb fa ff ff       	call   13000 <fwp_encode>
   13545:	49 ff c7             	inc    %r15
   13548:	49 63 46 10          	movslq 0x10(%r14),%rax
   1354c:	49 39 c7             	cmp    %rax,%r15
   1354f:	7c df                	jl     13530 <fwp_encode+0x530>
   13551:	e9 55 fc ff ff       	jmp    131ab <fwp_encode+0x1ab>
   13556:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
   1355d:	ff ff 7f 
   13560:	4c 8b 2b             	mov    (%rbx),%r13
   13563:	49 21 c5             	and    %rax,%r13
   13566:	49 81 fd 80 00 00 00 	cmp    $0x80,%r13
   1356d:	0f 83 bb 00 00 00    	jae    1362e <fwp_encode+0x62e>
   13573:	4c 89 ed             	mov    %r13,%rbp
   13576:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   1357b:	e9 e9 00 00 00       	jmp    13669 <fwp_encode+0x669>
   13580:	8b 03                	mov    (%rbx),%eax
   13582:	41 89 c4             	mov    %eax,%r12d
   13585:	4c 89 e5             	mov    %r12,%rbp
   13588:	3d 80 00 00 00       	cmp    $0x80,%eax
   1358d:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
   13592:	72 37                	jb     135cb <fwp_encode+0x5cb>
   13594:	4d 89 e5             	mov    %r12,%r13
   13597:	4c 89 e5             	mov    %r12,%rbp
   1359a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   135a0:	48 c1 ed 07          	shr    $0x7,%rbp
   135a4:	44 89 e8             	mov    %r13d,%eax
   135a7:	0c 80                	or     $0x80,%al
   135a9:	88 44 24 07          	mov    %al,0x7(%rsp)
   135ad:	ba 01 00 00 00       	mov    $0x1,%edx
   135b2:	4c 89 ff             	mov    %r15,%rdi
   135b5:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
   135ba:	e8 11 9c ff ff       	call   d1d0 <buf_put>
   135bf:	49 81 fd ff 3f 00 00 	cmp    $0x3fff,%r13
   135c6:	49 89 ed             	mov    %rbp,%r13
   135c9:	77 d5                	ja     135a0 <fwp_encode+0x5a0>
   135cb:	40 88 6c 24 07       	mov    %bpl,0x7(%rsp)
   135d0:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
   135d5:	ba 01 00 00 00       	mov    $0x1,%edx
   135da:	4c 89 ff             	mov    %r15,%rdi
   135dd:	e8 ee 9b ff ff       	call   d1d0 <buf_put>
   135e2:	49 8b 46 28          	mov    0x28(%r14),%rax
   135e6:	42 83 3c a0 00       	cmpl   $0x0,(%rax,%r12,4)
   135eb:	0f 8e ba fb ff ff    	jle    131ab <fwp_encode+0x1ab>
   135f1:	4d 89 fd             	mov    %r15,%r13
   135f4:	45 31 ff             	xor    %r15d,%r15d
   135f7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   135fe:	00 00 
   13600:	4a 8b 74 fb 08       	mov    0x8(%rbx,%r15,8),%rsi
   13605:	49 8b 46 30          	mov    0x30(%r14),%rax
   13609:	4a 8b 04 e0          	mov    (%rax,%r12,8),%rax
   1360d:	4a 8b 14 f8          	mov    (%rax,%r15,8),%rdx
   13611:	4c 89 ef             	mov    %r13,%rdi
   13614:	e8 e7 f9 ff ff       	call   13000 <fwp_encode>
   13619:	49 ff c7             	inc    %r15
   1361c:	49 8b 46 28          	mov    0x28(%r14),%rax
   13620:	4a 63 04 a0          	movslq (%rax,%r12,4),%rax
   13624:	49 39 c7             	cmp    %rax,%r15
   13627:	7c d7                	jl     13600 <fwp_encode+0x600>
   13629:	e9 7d fb ff ff       	jmp    131ab <fwp_encode+0x1ab>
   1362e:	4c 8d 7c 24 07       	lea    0x7(%rsp),%r15
   13633:	4c 89 ed             	mov    %r13,%rbp
   13636:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   1363b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   13640:	48 c1 ed 07          	shr    $0x7,%rbp
   13644:	44 89 e8             	mov    %r13d,%eax
   13647:	0c 80                	or     $0x80,%al
   13649:	88 44 24 07          	mov    %al,0x7(%rsp)
   1364d:	ba 01 00 00 00       	mov    $0x1,%edx
   13652:	4c 89 e7             	mov    %r12,%rdi
   13655:	4c 89 fe             	mov    %r15,%rsi
   13658:	e8 73 9b ff ff       	call   d1d0 <buf_put>
   1365d:	49 81 fd ff 3f 00 00 	cmp    $0x3fff,%r13
   13664:	49 89 ed             	mov    %rbp,%r13
   13667:	77 d7                	ja     13640 <fwp_encode+0x640>
   13669:	40 88 6c 24 07       	mov    %bpl,0x7(%rsp)
   1366e:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
   13673:	ba 01 00 00 00       	mov    $0x1,%edx
   13678:	4c 89 e7             	mov    %r12,%rdi
   1367b:	e8 50 9b ff ff       	call   d1d0 <buf_put>
   13680:	48 8b 03             	mov    (%rbx),%rax
   13683:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
   1368a:	ff ff 7f 
   1368d:	4c 85 e0             	test   %r12,%rax
   13690:	0f 84 15 fb ff ff    	je     131ab <fwp_encode+0x1ab>
   13696:	4c 8d 7b 08          	lea    0x8(%rbx),%r15
   1369a:	31 ed                	xor    %ebp,%ebp
   1369c:	4c 8d 2d 4d 22 00 00 	lea    0x224d(%rip),%r13        # 158f0 <exec_in_fp0+0x80>
   136a3:	eb 34                	jmp    136d9 <fwp_encode+0x6d9>
   136a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   136ac:	00 00 00 00 
   136b0:	83 3a 01             	cmpl   $0x1,(%rdx)
   136b3:	0f b7 04 06          	movzwl (%rsi,%rax,1),%eax
   136b7:	48 0f bf f0          	movswq %ax,%rsi
   136bb:	48 0f 45 f0          	cmovne %rax,%rsi
   136bf:	e8 3c f9 ff ff       	call   13000 <fwp_encode>
   136c4:	48 ff c5             	inc    %rbp
   136c7:	48 8b 03             	mov    (%rbx),%rax
   136ca:	48 89 c1             	mov    %rax,%rcx
   136cd:	4c 21 e1             	and    %r12,%rcx
   136d0:	48 39 cd             	cmp    %rcx,%rbp
   136d3:	0f 83 d2 fa ff ff    	jae    131ab <fwp_encode+0x1ab>
   136d9:	49 8b 56 38          	mov    0x38(%r14),%rdx
   136dd:	b9 08 00 00 00       	mov    $0x8,%ecx
   136e2:	48 85 d2             	test   %rdx,%rdx
   136e5:	74 19                	je     13700 <fwp_encode+0x700>
   136e7:	8b 32                	mov    (%rdx),%esi
   136e9:	48 83 fe 0a          	cmp    $0xa,%rsi
   136ed:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
   136f2:	77 11                	ja     13705 <fwp_encode+0x705>
   136f4:	49 8b 4c f5 00       	mov    0x0(%r13,%rsi,8),%rcx
   136f9:	eb 0a                	jmp    13705 <fwp_encode+0x705>
   136fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   13700:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
   13705:	4c 89 fe             	mov    %r15,%rsi
   13708:	48 85 c0             	test   %rax,%rax
   1370b:	79 04                	jns    13711 <fwp_encode+0x711>
   1370d:	48 8b 73 10          	mov    0x10(%rbx),%rsi
   13711:	48 89 c8             	mov    %rcx,%rax
   13714:	48 0f af c5          	imul   %rbp,%rax
   13718:	48 83 f9 01          	cmp    $0x1,%rcx
   1371c:	74 12                	je     13730 <fwp_encode+0x730>
   1371e:	48 83 f9 02          	cmp    $0x2,%rcx
   13722:	74 8c                	je     136b0 <fwp_encode+0x6b0>
   13724:	48 83 f9 08          	cmp    $0x8,%rcx
   13728:	75 16                	jne    13740 <fwp_encode+0x740>
   1372a:	48 8b 34 06          	mov    (%rsi,%rax,1),%rsi
   1372e:	eb 8f                	jmp    136bf <fwp_encode+0x6bf>
   13730:	83 3a 00             	cmpl   $0x0,(%rdx)
   13733:	0f b6 04 06          	movzbl (%rsi,%rax,1),%eax
   13737:	48 0f be f0          	movsbq %al,%rsi
   1373b:	e9 7b ff ff ff       	jmp    136bb <fwp_encode+0x6bb>
   13740:	83 3a 02             	cmpl   $0x2,(%rdx)
   13743:	8b 04 06             	mov    (%rsi,%rax,1),%eax
   13746:	48 63 f0             	movslq %eax,%rsi
   13749:	e9 6d ff ff ff       	jmp    136bb <fwp_encode+0x6bb>
   1374e:	c6 44 24 07 00       	movb   $0x0,0x7(%rsp)
   13753:	e9 9c f9 ff ff       	jmp    130f4 <fwp_encode+0xf4>
   13758:	4c 8d 7c 24 07       	lea    0x7(%rsp),%r15
   1375d:	4c 89 ed             	mov    %r13,%rbp
   13760:	48 c1 ed 07          	shr    $0x7,%rbp
   13764:	44 89 e8             	mov    %r13d,%eax
   13767:	0c 80                	or     $0x80,%al
   13769:	88 44 24 07          	mov    %al,0x7(%rsp)
   1376d:	ba 01 00 00 00       	mov    $0x1,%edx
   13772:	4c 89 e7             	mov    %r12,%rdi
   13775:	4c 89 fe             	mov    %r15,%rsi
   13778:	e8 53 9a ff ff       	call   d1d0 <buf_put>
   1377d:	49 81 fd ff 3f 00 00 	cmp    $0x3fff,%r13
   13784:	49 89 ed             	mov    %rbp,%r13
   13787:	77 d7                	ja     13760 <fwp_encode+0x760>
   13789:	40 88 6c 24 07       	mov    %bpl,0x7(%rsp)
   1378e:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
   13793:	ba 01 00 00 00       	mov    $0x1,%edx
   13798:	4c 89 e7             	mov    %r12,%rdi
   1379b:	e8 30 9a ff ff       	call   d1d0 <buf_put>
   137a0:	48 85 db             	test   %rbx,%rbx
   137a3:	0f 84 02 fa ff ff    	je     131ab <fwp_encode+0x1ab>
   137a9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   137b0:	48 8b 73 08          	mov    0x8(%rbx),%rsi
   137b4:	49 8b 56 38          	mov    0x38(%r14),%rdx
   137b8:	4c 89 e7             	mov    %r12,%rdi
   137bb:	e8 40 f8 ff ff       	call   13000 <fwp_encode>
   137c0:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
   137c4:	48 85 db             	test   %rbx,%rbx
   137c7:	75 e7                	jne    137b0 <fwp_encode+0x7b0>
   137c9:	e9 dd f9 ff ff       	jmp    131ab <fwp_encode+0x1ab>
   137ce:	66 90                	xchg   %ax,%ax

00000000000137d0 <rd_leb>:
   137d0:	48 c7 06 00 00 00 00 	movq   $0x0,(%rsi)
   137d7:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   137db:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   137df:	75 03                	jne    137e4 <rd_leb+0x14>
   137e1:	31 c0                	xor    %eax,%eax
   137e3:	c3                   	ret
   137e4:	48 8b 0f             	mov    (%rdi),%rcx
   137e7:	48 8d 42 01          	lea    0x1(%rdx),%rax
   137eb:	48 89 47 10          	mov    %rax,0x10(%rdi)
   137ef:	0f b6 04 11          	movzbl (%rcx,%rdx,1),%eax
   137f3:	83 e0 7f             	and    $0x7f,%eax
   137f6:	48 09 06             	or     %rax,(%rsi)
   137f9:	b8 01 00 00 00       	mov    $0x1,%eax
   137fe:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   13802:	78 01                	js     13805 <rd_leb+0x35>
   13804:	c3                   	ret
   13805:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   13809:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   1380d:	74 d2                	je     137e1 <rd_leb+0x11>
   1380f:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   13813:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   13817:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   1381c:	41 83 e0 7f          	and    $0x7f,%r8d
   13820:	41 c1 e0 07          	shl    $0x7,%r8d
   13824:	4c 09 06             	or     %r8,(%rsi)
   13827:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   1382b:	79 d7                	jns    13804 <rd_leb+0x34>
   1382d:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   13831:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   13835:	74 aa                	je     137e1 <rd_leb+0x11>
   13837:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   1383b:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   1383f:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   13844:	41 83 e0 7f          	and    $0x7f,%r8d
   13848:	41 c1 e0 0e          	shl    $0xe,%r8d
   1384c:	4c 09 06             	or     %r8,(%rsi)
   1384f:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   13853:	79 af                	jns    13804 <rd_leb+0x34>
   13855:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   13859:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   1385d:	74 82                	je     137e1 <rd_leb+0x11>
   1385f:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   13863:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   13867:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   1386c:	41 83 e0 7f          	and    $0x7f,%r8d
   13870:	41 c1 e0 15          	shl    $0x15,%r8d
   13874:	4c 09 06             	or     %r8,(%rsi)
   13877:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   1387b:	79 87                	jns    13804 <rd_leb+0x34>
   1387d:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   13881:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   13885:	0f 84 56 ff ff ff    	je     137e1 <rd_leb+0x11>
   1388b:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   1388f:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   13893:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   13898:	41 83 e0 7f          	and    $0x7f,%r8d
   1389c:	49 c1 e0 1c          	shl    $0x1c,%r8
   138a0:	4c 09 06             	or     %r8,(%rsi)
   138a3:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   138a7:	0f 89 57 ff ff ff    	jns    13804 <rd_leb+0x34>
   138ad:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   138b1:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   138b5:	0f 84 26 ff ff ff    	je     137e1 <rd_leb+0x11>
   138bb:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   138bf:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   138c3:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   138c8:	41 83 e0 7f          	and    $0x7f,%r8d
   138cc:	49 c1 e0 23          	shl    $0x23,%r8
   138d0:	4c 09 06             	or     %r8,(%rsi)
   138d3:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   138d7:	0f 89 27 ff ff ff    	jns    13804 <rd_leb+0x34>
   138dd:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   138e1:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   138e5:	0f 84 f6 fe ff ff    	je     137e1 <rd_leb+0x11>
   138eb:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   138ef:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   138f3:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   138f8:	41 83 e0 7f          	and    $0x7f,%r8d
   138fc:	49 c1 e0 2a          	shl    $0x2a,%r8
   13900:	4c 09 06             	or     %r8,(%rsi)
   13903:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   13907:	0f 89 f7 fe ff ff    	jns    13804 <rd_leb+0x34>
   1390d:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   13911:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   13915:	0f 84 c6 fe ff ff    	je     137e1 <rd_leb+0x11>
   1391b:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   1391f:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   13923:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   13928:	41 83 e0 7f          	and    $0x7f,%r8d
   1392c:	49 c1 e0 31          	shl    $0x31,%r8
   13930:	4c 09 06             	or     %r8,(%rsi)
   13933:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   13937:	0f 89 c7 fe ff ff    	jns    13804 <rd_leb+0x34>
   1393d:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   13941:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   13945:	0f 84 96 fe ff ff    	je     137e1 <rd_leb+0x11>
   1394b:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   1394f:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   13953:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   13958:	41 83 e0 7f          	and    $0x7f,%r8d
   1395c:	49 c1 e0 38          	shl    $0x38,%r8
   13960:	4c 09 06             	or     %r8,(%rsi)
   13963:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   13967:	0f 89 97 fe ff ff    	jns    13804 <rd_leb+0x34>
   1396d:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   13971:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   13975:	0f 84 66 fe ff ff    	je     137e1 <rd_leb+0x11>
   1397b:	48 8d 42 01          	lea    0x1(%rdx),%rax
   1397f:	48 89 47 10          	mov    %rax,0x10(%rdi)
   13983:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
   13987:	b8 00 00 00 00       	mov    $0x0,%eax
   1398c:	40 f6 c7 7e          	test   $0x7e,%dil
   13990:	0f 85 6e fe ff ff    	jne    13804 <rd_leb+0x34>
   13996:	48 c1 e7 3f          	shl    $0x3f,%rdi
   1399a:	48 09 3e             	or     %rdi,(%rsi)
   1399d:	31 c0                	xor    %eax,%eax
   1399f:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   139a3:	0f 99 c0             	setns  %al
   139a6:	c3                   	ret
   139a7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   139ae:	00 00 

00000000000139b0 <fwp_wire_empty_inner>:
   139b0:	31 c0                	xor    %eax,%eax
   139b2:	48 85 ff             	test   %rdi,%rdi
   139b5:	0f 84 a0 00 00 00    	je     13a5b <fwp_wire_empty_inner+0xab>
   139bb:	83 3f 10             	cmpl   $0x10,(%rdi)
   139be:	0f 85 97 00 00 00    	jne    13a5b <fwp_wire_empty_inner+0xab>
   139c4:	41 57                	push   %r15
   139c6:	41 56                	push   %r14
   139c8:	41 54                	push   %r12
   139ca:	53                   	push   %rbx
   139cb:	48 83 ec 18          	sub    $0x18,%rsp
   139cf:	48 85 f6             	test   %rsi,%rsi
   139d2:	74 1a                	je     139ee <fwp_wire_empty_inner+0x3e>
   139d4:	48 89 f1             	mov    %rsi,%rcx
   139d7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   139de:	00 00 
   139e0:	48 39 39             	cmp    %rdi,(%rcx)
   139e3:	74 6b                	je     13a50 <fwp_wire_empty_inner+0xa0>
   139e5:	48 8b 49 08          	mov    0x8(%rcx),%rcx
   139e9:	48 85 c9             	test   %rcx,%rcx
   139ec:	75 f2                	jne    139e0 <fwp_wire_empty_inner+0x30>
   139ee:	48 89 7c 24 08       	mov    %rdi,0x8(%rsp)
   139f3:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
   139f8:	44 8b 77 10          	mov    0x10(%rdi),%r14d
   139fc:	45 85 f6             	test   %r14d,%r14d
   139ff:	7e 46                	jle    13a47 <fwp_wire_empty_inner+0x97>
   13a01:	4c 8b 7f 20          	mov    0x20(%rdi),%r15
   13a05:	49 8b 3f             	mov    (%r15),%rdi
   13a08:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
   13a0d:	e8 9e ff ff ff       	call   139b0 <fwp_wire_empty_inner>
   13a12:	85 c0                	test   %eax,%eax
   13a14:	74 38                	je     13a4e <fwp_wire_empty_inner+0x9e>
   13a16:	b9 01 00 00 00       	mov    $0x1,%ecx
   13a1b:	48 8d 5c 24 08       	lea    0x8(%rsp),%rbx
   13a20:	49 89 cc             	mov    %rcx,%r12
   13a23:	49 39 ce             	cmp    %rcx,%r14
   13a26:	74 15                	je     13a3d <fwp_wire_empty_inner+0x8d>
   13a28:	4b 8b 3c e7          	mov    (%r15,%r12,8),%rdi
   13a2c:	48 89 de             	mov    %rbx,%rsi
   13a2f:	e8 7c ff ff ff       	call   139b0 <fwp_wire_empty_inner>
   13a34:	49 8d 4c 24 01       	lea    0x1(%r12),%rcx
   13a39:	85 c0                	test   %eax,%eax
   13a3b:	75 e3                	jne    13a20 <fwp_wire_empty_inner+0x70>
   13a3d:	31 c0                	xor    %eax,%eax
   13a3f:	4d 39 f4             	cmp    %r14,%r12
   13a42:	0f 93 c0             	setae  %al
   13a45:	eb 09                	jmp    13a50 <fwp_wire_empty_inner+0xa0>
   13a47:	b8 01 00 00 00       	mov    $0x1,%eax
   13a4c:	eb 02                	jmp    13a50 <fwp_wire_empty_inner+0xa0>
   13a4e:	31 c0                	xor    %eax,%eax
   13a50:	48 83 c4 18          	add    $0x18,%rsp
   13a54:	5b                   	pop    %rbx
   13a55:	41 5c                	pop    %r12
   13a57:	41 5e                	pop    %r14
   13a59:	41 5f                	pop    %r15
   13a5b:	c3                   	ret
   13a5c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000013a60 <fwp_gc_find_data>:
   13a60:	0f b7 77 18          	movzwl 0x18(%rdi),%esi
   13a64:	48 85 f6             	test   %rsi,%rsi
   13a67:	0f 84 be 00 00 00    	je     13b2b <fwp_gc_find_data+0xcb>
   13a6d:	53                   	push   %rbx
   13a6e:	48 8b 07             	mov    (%rdi),%rax
   13a71:	4c 8b 47 10          	mov    0x10(%rdi),%r8
   13a75:	48 6b ce 38          	imul   $0x38,%rsi,%rcx
   13a79:	45 31 c9             	xor    %r9d,%r9d
   13a7c:	48 8d 15 05 68 00 00 	lea    0x6805(%rip),%rdx        # 1a288 <fwp_gc>
   13a83:	41 bb 01 00 00 00    	mov    $0x1,%r11d
   13a89:	45 31 d2             	xor    %r10d,%r10d
   13a8c:	eb 0b                	jmp    13a99 <fwp_gc_find_data+0x39>
   13a8e:	66 90                	xchg   %ax,%ax
   13a90:	49 83 c1 38          	add    $0x38,%r9
   13a94:	4c 39 c9             	cmp    %r9,%rcx
   13a97:	74 22                	je     13abb <fwp_gc_find_data+0x5b>
   13a99:	43 83 3c 08 01       	cmpl   $0x1,(%r8,%r9,1)
   13a9e:	75 f0                	jne    13a90 <fwp_gc_find_data+0x30>
   13aa0:	4b 8b 5c 08 10       	mov    0x10(%r8,%r9,1),%rbx
   13aa5:	48 01 c3             	add    %rax,%rbx
   13aa8:	48 39 d3             	cmp    %rdx,%rbx
   13aab:	77 e3                	ja     13a90 <fwp_gc_find_data+0x30>
   13aad:	4b 03 5c 08 28       	add    0x28(%r8,%r9,1),%rbx
   13ab2:	48 39 d3             	cmp    %rdx,%rbx
   13ab5:	45 0f 47 d3          	cmova  %r11d,%r10d
   13ab9:	eb d5                	jmp    13a90 <fwp_gc_find_data+0x30>
   13abb:	31 c0                	xor    %eax,%eax
   13abd:	45 85 d2             	test   %r10d,%r10d
   13ac0:	0f 95 c0             	setne  %al
   13ac3:	74 6e                	je     13b33 <fwp_gc_find_data+0xd3>
   13ac5:	66 85 f6             	test   %si,%si
   13ac8:	74 69                	je     13b33 <fwp_gc_find_data+0xd3>
   13aca:	8b 05 48 79 00 00    	mov    0x7948(%rip),%eax        # 1b418 <fwp_gc+0x1190>
   13ad0:	48 8b 77 10          	mov    0x10(%rdi),%rsi
   13ad4:	45 31 c0             	xor    %r8d,%r8d
   13ad7:	eb 10                	jmp    13ae9 <fwp_gc_find_data+0x89>
   13ad9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   13ae0:	49 83 c0 38          	add    $0x38,%r8
   13ae4:	4c 39 c1             	cmp    %r8,%rcx
   13ae7:	74 45                	je     13b2e <fwp_gc_find_data+0xce>
   13ae9:	42 83 3c 06 01       	cmpl   $0x1,(%rsi,%r8,1)
   13aee:	75 f0                	jne    13ae0 <fwp_gc_find_data+0x80>
   13af0:	42 f6 44 06 04 02    	testb  $0x2,0x4(%rsi,%r8,1)
   13af6:	74 e8                	je     13ae0 <fwp_gc_find_data+0x80>
   13af8:	83 f8 10             	cmp    $0x10,%eax
   13afb:	74 31                	je     13b2e <fwp_gc_find_data+0xce>
   13afd:	4e 8b 4c 06 10       	mov    0x10(%rsi,%r8,1),%r9
   13b02:	4c 03 0f             	add    (%rdi),%r9
   13b05:	4c 63 d0             	movslq %eax,%r10
   13b08:	49 c1 e2 04          	shl    $0x4,%r10
   13b0c:	4d 89 8c 12 90 10 00 	mov    %r9,0x1090(%r10,%rdx,1)
   13b13:	00 
   13b14:	4e 8b 4c 06 28       	mov    0x28(%rsi,%r8,1),%r9
   13b19:	4d 89 8c 12 98 10 00 	mov    %r9,0x1098(%r10,%rdx,1)
   13b20:	00 
   13b21:	ff c0                	inc    %eax
   13b23:	89 05 ef 78 00 00    	mov    %eax,0x78ef(%rip)        # 1b418 <fwp_gc+0x1190>
   13b29:	eb b5                	jmp    13ae0 <fwp_gc_find_data+0x80>
   13b2b:	31 c0                	xor    %eax,%eax
   13b2d:	c3                   	ret
   13b2e:	b8 01 00 00 00       	mov    $0x1,%eax
   13b33:	5b                   	pop    %rbx
   13b34:	c3                   	ret
   13b35:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   13b3c:	00 00 00 00 

0000000000013b40 <fwp_gc_report>:
   13b40:	55                   	push   %rbp
   13b41:	41 57                	push   %r15
   13b43:	41 56                	push   %r14
   13b45:	41 55                	push   %r13
   13b47:	41 54                	push   %r12
   13b49:	53                   	push   %rbx
   13b4a:	48 81 ec 58 01 00 00 	sub    $0x158,%rsp
   13b51:	48 8b 05 40 79 00 00 	mov    0x7940(%rip),%rax        # 1b498 <fwp_gc+0x1210>
   13b58:	48 8b 0d 29 67 00 00 	mov    0x6729(%rip),%rcx        # 1a288 <fwp_gc>
   13b5f:	48 29 c8             	sub    %rcx,%rax
   13b62:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
   13b67:	f2 0f 58 05 01 79 00 	addsd  0x7901(%rip),%xmm0        # 1b470 <fwp_gc+0x11e8>
   13b6e:	00 
   13b6f:	f2 0f 11 44 24 48    	movsd  %xmm0,0x48(%rsp)
   13b75:	f2 0f 11 05 f3 78 00 	movsd  %xmm0,0x78f3(%rip)        # 1b470 <fwp_gc+0x11e8>
   13b7c:	00 
   13b7d:	48 89 0d 14 79 00 00 	mov    %rcx,0x7914(%rip)        # 1b498 <fwp_gc+0x1210>
   13b84:	48 8b 05 4d 64 00 00 	mov    0x644d(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
   13b8b:	48 8b 28             	mov    (%rax),%rbp
   13b8e:	48 8b 1d cb 78 00 00 	mov    0x78cb(%rip),%rbx        # 1b460 <fwp_gc+0x11d8>
   13b95:	4c 8b 3d 04 77 00 00 	mov    0x7704(%rip),%r15        # 1b2a0 <fwp_gc+0x1018>
   13b9c:	f2 0f 10 05 ec 78 00 	movsd  0x78ec(%rip),%xmm0        # 1b490 <fwp_gc+0x1208>
   13ba3:	00 
   13ba4:	f2 0f 11 44 24 30    	movsd  %xmm0,0x30(%rsp)
   13baa:	48 8b 05 1f 77 00 00 	mov    0x771f(%rip),%rax        # 1b2d0 <fwp_gc+0x1048>
   13bb1:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
   13bb6:	48 8b 05 93 78 00 00 	mov    0x7893(%rip),%rax        # 1b450 <fwp_gc+0x11c8>
   13bbd:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   13bc2:	4c 8b 35 8f 78 00 00 	mov    0x788f(%rip),%r14        # 1b458 <fwp_gc+0x11d0>
   13bc9:	f2 0f 10 05 a7 78 00 	movsd  0x78a7(%rip),%xmm0        # 1b478 <fwp_gc+0x11f0>
   13bd0:	00 
   13bd1:	f2 0f 11 44 24 40    	movsd  %xmm0,0x40(%rsp)
   13bd7:	f2 0f 10 05 a1 78 00 	movsd  0x78a1(%rip),%xmm0        # 1b480 <fwp_gc+0x11f8>
   13bde:	00 
   13bdf:	f2 0f 11 44 24 38    	movsd  %xmm0,0x38(%rsp)
   13be5:	48 8d 3d d4 2d 00 00 	lea    0x2dd4(%rip),%rdi        # 169c0 <exec_in_fp0+0x1150>
   13bec:	48 8d 35 cd 2b 00 00 	lea    0x2bcd(%rip),%rsi        # 167c0 <exec_in_fp0+0xf50>
   13bf3:	e8 18 f8 fe ff       	call   3410 <fopen@plt>
   13bf8:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
   13bff:	48 85 c0             	test   %rax,%rax
   13c02:	74 4b                	je     13c4f <fwp_gc_report+0x10f>
   13c04:	49 89 c5             	mov    %rax,%r13
   13c07:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
   13c0c:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
   13c11:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
   13c16:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
   13c1b:	be 00 01 00 00       	mov    $0x100,%esi
   13c20:	48 89 c2             	mov    %rax,%rdx
   13c23:	e8 68 f6 fe ff       	call   3290 <fgets@plt>
   13c28:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
   13c2f:	48 85 c0             	test   %rax,%rax
   13c32:	0f 85 f1 00 00 00    	jne    13d29 <fwp_gc_report+0x1e9>
   13c38:	4c 89 ef             	mov    %r13,%rdi
   13c3b:	e8 10 f5 fe ff       	call   3150 <fclose@plt>
   13c40:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
   13c45:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
   13c4a:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
   13c4f:	66 49 0f 6e c6       	movq   %r14,%xmm0
   13c54:	66 0f 6f 0d c4 14 00 	movdqa 0x14c4(%rip),%xmm1        # 15120 <_IO_stdin_used+0x120>
   13c5b:	00 
   13c5c:	66 0f 62 c1          	punpckldq %xmm1,%xmm0
   13c60:	66 0f 28 15 c8 14 00 	movapd 0x14c8(%rip),%xmm2        # 15130 <_IO_stdin_used+0x130>
   13c67:	00 
   13c68:	66 0f 5c c2          	subpd  %xmm2,%xmm0
   13c6c:	66 0f 28 e0          	movapd %xmm0,%xmm4
   13c70:	66 0f 15 e0          	unpckhpd %xmm0,%xmm4
   13c74:	f2 0f 58 e0          	addsd  %xmm0,%xmm4
   13c78:	f2 0f 10 35 58 15 00 	movsd  0x1558(%rip),%xmm6        # 151d8 <_IO_stdin_used+0x1d8>
   13c7f:	00 
   13c80:	f2 0f 59 e6          	mulsd  %xmm6,%xmm4
   13c84:	f3 0f 7e 6c 24 20    	movq   0x20(%rsp),%xmm5
   13c8a:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
   13c8e:	66 0f 5c ea          	subpd  %xmm2,%xmm5
   13c92:	66 0f 28 dd          	movapd %xmm5,%xmm3
   13c96:	66 0f 15 dd          	unpckhpd %xmm5,%xmm3
   13c9a:	f2 0f 58 dd          	addsd  %xmm5,%xmm3
   13c9e:	f2 0f 59 de          	mulsd  %xmm6,%xmm3
   13ca2:	f3 0f 7e 6c 24 28    	movq   0x28(%rsp),%xmm5
   13ca8:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
   13cac:	66 0f 5c ea          	subpd  %xmm2,%xmm5
   13cb0:	66 0f 28 d5          	movapd %xmm5,%xmm2
   13cb4:	66 0f 15 d5          	unpckhpd %xmm5,%xmm2
   13cb8:	f2 0f 58 d5          	addsd  %xmm5,%xmm2
   13cbc:	f2 0f 59 d6          	mulsd  %xmm6,%xmm2
   13cc0:	f2 0f 10 44 24 48    	movsd  0x48(%rsp),%xmm0
   13cc6:	f2 0f 10 4c 24 30    	movsd  0x30(%rsp),%xmm1
   13ccc:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
   13cd0:	f2 0f 59 ce          	mulsd  %xmm6,%xmm1
   13cd4:	f2 0f 59 c6          	mulsd  %xmm6,%xmm0
   13cd8:	83 3d 9d 75 00 00 00 	cmpl   $0x0,0x759d(%rip)        # 1b27c <fwp_gc+0xff4>
   13cdf:	48 8d 05 c8 2c 00 00 	lea    0x2cc8(%rip),%rax        # 169ae <exec_in_fp0+0x113e>
   13ce6:	4c 8d 0d d9 24 00 00 	lea    0x24d9(%rip),%r9        # 161c6 <exec_in_fp0+0x956>
   13ced:	4c 0f 44 c8          	cmove  %rax,%r9
   13cf1:	48 8d 35 01 2c 00 00 	lea    0x2c01(%rip),%rsi        # 168f9 <exec_in_fp0+0x1089>
   13cf8:	48 89 ef             	mov    %rbp,%rdi
   13cfb:	48 89 da             	mov    %rbx,%rdx
   13cfe:	4c 89 f9             	mov    %r15,%rcx
   13d01:	f2 0f 10 6c 24 40    	movsd  0x40(%rsp),%xmm5
   13d07:	f2 0f 10 74 24 38    	movsd  0x38(%rsp),%xmm6
   13d0d:	4d 89 e0             	mov    %r12,%r8
   13d10:	b0 07                	mov    $0x7,%al
   13d12:	e8 d9 f5 fe ff       	call   32f0 <fprintf@plt>
   13d17:	48 81 c4 58 01 00 00 	add    $0x158,%rsp
   13d1e:	5b                   	pop    %rbx
   13d1f:	41 5c                	pop    %r12
   13d21:	41 5d                	pop    %r13
   13d23:	41 5e                	pop    %r14
   13d25:	41 5f                	pop    %r15
   13d27:	5d                   	pop    %rbp
   13d28:	c3                   	ret
   13d29:	48 8d 6c 24 56       	lea    0x56(%rsp),%rbp
   13d2e:	41 bf 56 6d 48 57    	mov    $0x57486d56,%r15d
   13d34:	48 8d 5c 24 50       	lea    0x50(%rsp),%rbx
   13d39:	eb 1e                	jmp    13d59 <fwp_gc_report+0x219>
   13d3b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   13d40:	48 89 df             	mov    %rbx,%rdi
   13d43:	be 00 01 00 00       	mov    $0x100,%esi
   13d48:	4c 89 ea             	mov    %r13,%rdx
   13d4b:	e8 40 f5 fe ff       	call   3290 <fgets@plt>
   13d50:	48 85 c0             	test   %rax,%rax
   13d53:	0f 84 df fe ff ff    	je     13c38 <fwp_gc_report+0xf8>
   13d59:	8b 44 24 50          	mov    0x50(%rsp),%eax
   13d5d:	44 31 f8             	xor    %r15d,%eax
   13d60:	0f b6 4c 24 54       	movzbl 0x54(%rsp),%ecx
   13d65:	83 f1 4d             	xor    $0x4d,%ecx
   13d68:	09 c1                	or     %eax,%ecx
   13d6a:	75 d4                	jne    13d40 <fwp_gc_report+0x200>
   13d6c:	80 7c 24 55 3a       	cmpb   $0x3a,0x55(%rsp)
   13d71:	75 cd                	jne    13d40 <fwp_gc_report+0x200>
   13d73:	48 89 ef             	mov    %rbp,%rdi
   13d76:	31 f6                	xor    %esi,%esi
   13d78:	ba 0a 00 00 00       	mov    $0xa,%edx
   13d7d:	e8 9e f5 fe ff       	call   3320 <strtol@plt>
   13d82:	49 89 c4             	mov    %rax,%r12
   13d85:	eb b9                	jmp    13d40 <fwp_gc_report+0x200>
   13d87:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   13d8e:	00 00 

0000000000013d90 <fwp_owner_release0>:
   13d90:	48 8b 3f             	mov    (%rdi),%rdi
   13d93:	eb 0b                	jmp    13da0 <fwp_drop0>
   13d95:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   13d9c:	00 00 00 00 

0000000000013da0 <fwp_drop0>:
   13da0:	53                   	push   %rbx
   13da1:	48 89 f8             	mov    %rdi,%rax
   13da4:	48 2b 05 0d 75 00 00 	sub    0x750d(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
   13dab:	48 8b 0d 2e 75 00 00 	mov    0x752e(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
   13db2:	48 c1 e1 10          	shl    $0x10,%rcx
   13db6:	48 39 c8             	cmp    %rcx,%rax
   13db9:	0f 83 9c 00 00 00    	jae    13e5b <fwp_drop0+0xbb>
   13dbf:	48 8b 0d 3a 75 00 00 	mov    0x753a(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
   13dc6:	48 89 c2             	mov    %rax,%rdx
   13dc9:	48 c1 ea 10          	shr    $0x10,%rdx
   13dcd:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
   13dd4:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
   13dd8:	48 25 ff ff 00 00    	and    $0xffff,%rax
   13dde:	75 20                	jne    13e00 <fwp_drop0+0x60>
   13de0:	40 80 fe 02          	cmp    $0x2,%sil
   13de4:	75 1a                	jne    13e00 <fwp_drop0+0x60>
   13de6:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
   13dea:	48 05 28 02 00 00    	add    $0x228,%rax
   13df0:	eb 2d                	jmp    13e1f <fwp_drop0+0x7f>
   13df2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   13df9:	1f 84 00 00 00 00 00 
   13e00:	40 80 fe 01          	cmp    $0x1,%sil
   13e04:	75 55                	jne    13e5b <fwp_drop0+0xbb>
   13e06:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
   13e0a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
   13e0e:	48 0f af c1          	imul   %rcx,%rax
   13e12:	48 c1 e8 20          	shr    $0x20,%rax
   13e16:	48 01 f0             	add    %rsi,%rax
   13e19:	48 05 28 02 00 00    	add    $0x228,%rax
   13e1f:	0f b6 08             	movzbl (%rax),%ecx
   13e22:	85 c9                	test   %ecx,%ecx
   13e24:	74 35                	je     13e5b <fwp_drop0+0xbb>
   13e26:	83 f9 01             	cmp    $0x1,%ecx
   13e29:	75 32                	jne    13e5d <fwp_drop0+0xbd>
   13e2b:	48 83 3f 00          	cmpq   $0x0,(%rdi)
   13e2f:	79 3a                	jns    13e6b <fwp_drop0+0xcb>
   13e31:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
   13e35:	e8 f6 6e ff ff       	call   ad30 <fwp_rc_free_arr>
   13e3a:	48 89 d8             	mov    %rbx,%rax
   13e3d:	48 2b 05 74 74 00 00 	sub    0x7474(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
   13e44:	48 8b 0d 95 74 00 00 	mov    0x7495(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
   13e4b:	48 c1 e1 10          	shl    $0x10,%rcx
   13e4f:	48 89 df             	mov    %rbx,%rdi
   13e52:	48 39 c8             	cmp    %rcx,%rax
   13e55:	0f 82 64 ff ff ff    	jb     13dbf <fwp_drop0+0x1f>
   13e5b:	5b                   	pop    %rbx
   13e5c:	c3                   	ret
   13e5d:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
   13e63:	74 0c                	je     13e71 <fwp_drop0+0xd1>
   13e65:	fe c9                	dec    %cl
   13e67:	88 08                	mov    %cl,(%rax)
   13e69:	5b                   	pop    %rbx
   13e6a:	c3                   	ret
   13e6b:	5b                   	pop    %rbx
   13e6c:	e9 bf 6e ff ff       	jmp    ad30 <fwp_rc_free_arr>
   13e71:	48 89 c7             	mov    %rax,%rdi
   13e74:	5b                   	pop    %rbx
   13e75:	e9 36 67 ff ff       	jmp    a5b0 <fwp_rc_wide_drop>
   13e7a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000013e80 <fwp_owner_release1>:
   13e80:	48 8b 3f             	mov    (%rdi),%rdi
   13e83:	e9 18 ff ff ff       	jmp    13da0 <fwp_drop0>
   13e88:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   13e8f:	00 

0000000000013e90 <fwp_owner_release2>:
   13e90:	48 8b 3f             	mov    (%rdi),%rdi
   13e93:	e9 08 ff ff ff       	jmp    13da0 <fwp_drop0>
   13e98:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   13e9f:	00 

0000000000013ea0 <__divti3>:
   13ea0:	f3 0f 1e fa          	endbr64
   13ea4:	55                   	push   %rbp
   13ea5:	49 89 f8             	mov    %rdi,%r8
   13ea8:	49 89 d2             	mov    %rdx,%r10
   13eab:	49 89 cb             	mov    %rcx,%r11
   13eae:	31 ff                	xor    %edi,%edi
   13eb0:	48 89 e5             	mov    %rsp,%rbp
   13eb3:	41 56                	push   %r14
   13eb5:	53                   	push   %rbx
   13eb6:	48 85 f6             	test   %rsi,%rsi
   13eb9:	79 13                	jns    13ece <__divti3+0x2e>
   13ebb:	45 31 c9             	xor    %r9d,%r9d
   13ebe:	49 f7 d8             	neg    %r8
   13ec1:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
   13ec8:	49 19 f1             	sbb    %rsi,%r9
   13ecb:	4c 89 ce             	mov    %r9,%rsi
   13ece:	4c 89 da             	mov    %r11,%rdx
   13ed1:	4d 85 db             	test   %r11,%r11
   13ed4:	0f 88 f6 00 00 00    	js     13fd0 <__divti3+0x130>
   13eda:	4d 89 d6             	mov    %r10,%r14
   13edd:	75 31                	jne    13f10 <__divti3+0x70>
   13edf:	4c 39 f6             	cmp    %r14,%rsi
   13ee2:	0f 83 b8 00 00 00    	jae    13fa0 <__divti3+0x100>
   13ee8:	48 89 f2             	mov    %rsi,%rdx
   13eeb:	31 f6                	xor    %esi,%esi
   13eed:	4c 89 c0             	mov    %r8,%rax
   13ef0:	49 f7 f6             	div    %r14
   13ef3:	48 89 f2             	mov    %rsi,%rdx
   13ef6:	48 85 ff             	test   %rdi,%rdi
   13ef9:	74 0a                	je     13f05 <__divti3+0x65>
   13efb:	48 f7 d8             	neg    %rax
   13efe:	48 83 d2 00          	adc    $0x0,%rdx
   13f02:	48 f7 da             	neg    %rdx
   13f05:	5b                   	pop    %rbx
   13f06:	41 5e                	pop    %r14
   13f08:	5d                   	pop    %rbp
   13f09:	c3                   	ret
   13f0a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   13f10:	4c 39 de             	cmp    %r11,%rsi
   13f13:	0f 82 d5 00 00 00    	jb     13fee <__divti3+0x14e>
   13f19:	4d 0f bd d3          	bsr    %r11,%r10
   13f1d:	41 83 f2 3f          	xor    $0x3f,%r10d
   13f21:	44 89 d1             	mov    %r10d,%ecx
   13f24:	b8 40 00 00 00       	mov    $0x40,%eax
   13f29:	4c 89 f3             	mov    %r14,%rbx
   13f2c:	4d 89 f1             	mov    %r14,%r9
   13f2f:	48 d3 e2             	shl    %cl,%rdx
   13f32:	49 63 ca             	movslq %r10d,%rcx
   13f35:	49 89 f3             	mov    %rsi,%r11
   13f38:	48 29 c8             	sub    %rcx,%rax
   13f3b:	89 c1                	mov    %eax,%ecx
   13f3d:	48 d3 eb             	shr    %cl,%rbx
   13f40:	44 89 d1             	mov    %r10d,%ecx
   13f43:	49 d3 e1             	shl    %cl,%r9
   13f46:	89 c1                	mov    %eax,%ecx
   13f48:	48 09 d3             	or     %rdx,%rbx
   13f4b:	4c 89 c2             	mov    %r8,%rdx
   13f4e:	49 d3 eb             	shr    %cl,%r11
   13f51:	44 89 d1             	mov    %r10d,%ecx
   13f54:	48 d3 e6             	shl    %cl,%rsi
   13f57:	89 c1                	mov    %eax,%ecx
   13f59:	48 d3 ea             	shr    %cl,%rdx
   13f5c:	48 89 d0             	mov    %rdx,%rax
   13f5f:	4c 89 da             	mov    %r11,%rdx
   13f62:	48 09 f0             	or     %rsi,%rax
   13f65:	48 f7 f3             	div    %rbx
   13f68:	49 89 d3             	mov    %rdx,%r11
   13f6b:	48 89 c6             	mov    %rax,%rsi
   13f6e:	49 f7 e1             	mul    %r9
   13f71:	49 39 d3             	cmp    %rdx,%r11
   13f74:	0f 82 be 00 00 00    	jb     14038 <__divti3+0x198>
   13f7a:	44 89 d1             	mov    %r10d,%ecx
   13f7d:	49 d3 e0             	shl    %cl,%r8
   13f80:	49 39 c0             	cmp    %rax,%r8
   13f83:	73 09                	jae    13f8e <__divti3+0xee>
   13f85:	49 39 d3             	cmp    %rdx,%r11
   13f88:	0f 84 aa 00 00 00    	je     14038 <__divti3+0x198>
   13f8e:	48 89 f0             	mov    %rsi,%rax
   13f91:	31 f6                	xor    %esi,%esi
   13f93:	e9 5b ff ff ff       	jmp    13ef3 <__divti3+0x53>
   13f98:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   13f9f:	00 
   13fa0:	4d 85 f6             	test   %r14,%r14
   13fa3:	75 0d                	jne    13fb2 <__divti3+0x112>
   13fa5:	b8 01 00 00 00       	mov    $0x1,%eax
   13faa:	31 d2                	xor    %edx,%edx
   13fac:	49 f7 f6             	div    %r14
   13faf:	49 89 c6             	mov    %rax,%r14
   13fb2:	48 89 f0             	mov    %rsi,%rax
   13fb5:	31 d2                	xor    %edx,%edx
   13fb7:	49 f7 f6             	div    %r14
   13fba:	48 89 c6             	mov    %rax,%rsi
   13fbd:	4c 89 c0             	mov    %r8,%rax
   13fc0:	49 f7 f6             	div    %r14
   13fc3:	e9 2b ff ff ff       	jmp    13ef3 <__divti3+0x53>
   13fc8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   13fcf:	00 
   13fd0:	49 f7 da             	neg    %r10
   13fd3:	48 f7 d7             	not    %rdi
   13fd6:	49 83 d3 00          	adc    $0x0,%r11
   13fda:	4d 89 d6             	mov    %r10,%r14
   13fdd:	49 f7 db             	neg    %r11
   13fe0:	4c 89 da             	mov    %r11,%rdx
   13fe3:	0f 84 f6 fe ff ff    	je     13edf <__divti3+0x3f>
   13fe9:	4c 39 de             	cmp    %r11,%rsi
   13fec:	73 12                	jae    14000 <__divti3+0x160>
   13fee:	31 f6                	xor    %esi,%esi
   13ff0:	31 c0                	xor    %eax,%eax
   13ff2:	e9 fc fe ff ff       	jmp    13ef3 <__divti3+0x53>
   13ff7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   13ffe:	00 00 
   14000:	49 0f bd c3          	bsr    %r11,%rax
   14004:	48 83 f0 3f          	xor    $0x3f,%rax
   14008:	41 89 c2             	mov    %eax,%r10d
   1400b:	85 c0                	test   %eax,%eax
   1400d:	0f 85 0e ff ff ff    	jne    13f21 <__divti3+0x81>
   14013:	49 39 f3             	cmp    %rsi,%r11
   14016:	72 0d                	jb     14025 <__divti3+0x185>
   14018:	31 f6                	xor    %esi,%esi
   1401a:	31 c0                	xor    %eax,%eax
   1401c:	4d 39 f0             	cmp    %r14,%r8
   1401f:	0f 82 ce fe ff ff    	jb     13ef3 <__divti3+0x53>
   14025:	31 f6                	xor    %esi,%esi
   14027:	b8 01 00 00 00       	mov    $0x1,%eax
   1402c:	e9 c2 fe ff ff       	jmp    13ef3 <__divti3+0x53>
   14031:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   14038:	48 8d 46 ff          	lea    -0x1(%rsi),%rax
   1403c:	31 f6                	xor    %esi,%esi
   1403e:	e9 b0 fe ff ff       	jmp    13ef3 <__divti3+0x53>
   14043:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   1404a:	00 00 00 
   1404d:	0f 1f 00             	nopl   (%rax)

0000000000014050 <atexit>:
   14050:	f3 0f 1e fa          	endbr64
   14054:	48 8b 15 1d 62 00 00 	mov    0x621d(%rip),%rdx        # 1a278 <__dso_handle>
   1405b:	31 f6                	xor    %esi,%esi
   1405d:	e9 de f3 fe ff       	jmp    3440 <__cxa_atexit@plt>

Disassembly of section .fini:

0000000000014064 <_fini>:
   14064:	f3 0f 1e fa          	endbr64
   14068:	48 83 ec 08          	sub    $0x8,%rsp
   1406c:	48 83 c4 08          	add    $0x8,%rsp
   14070:	c3                   	ret
