
/tmp/fwp-array-fusion-allocation-4341/profile-0O2:     file format elf64-x86-64


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
    3654:	48 8d 3d 3b 26 01 00 	lea    0x1263b(%rip),%rdi        # 15c96 <exec_in_fp0+0x426>
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
    377d:	e8 ae 4c 00 00       	call   8430 <fwp_gc_init>
    3782:	48 89 2d 87 7b 01 00 	mov    %rbp,0x17b87(%rip)        # 1b310 <fwp_gc+0x1088>
    3789:	48 8d 3d 90 03 01 00 	lea    0x10390(%rip),%rdi        # 13b20 <fwp_gc_find_data>
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
    37bf:	48 8d 3d 3a 04 01 00 	lea    0x1043a(%rip),%rdi        # 13c00 <fwp_gc_report>
    37c6:	e8 45 09 01 00       	call   14110 <atexit>
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
    38c4:	48 8d 05 c5 78 00 00 	lea    0x78c5(%rip),%rax        # b190 <fwp_segv>
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
    3943:	48 8d 35 b5 2c 01 00 	lea    0x12cb5(%rip),%rsi        # 165ff <exec_in_fp0+0xd8f>
    394a:	48 89 df             	mov    %rbx,%rdi
    394d:	e8 7e f9 ff ff       	call   32d0 <strcmp@plt>
    3952:	85 c0                	test   %eax,%eax
    3954:	0f 84 b0 00 00 00    	je     3a0a <fwp_main_thread+0x2aa>
    395a:	48 8d 35 a4 2c 01 00 	lea    0x12ca4(%rip),%rsi        # 16605 <exec_in_fp0+0xd95>
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
    39ff:	e8 3c 49 00 00       	call   8340 <fwp_gc_alloc_slow>
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
    3a88:	e8 63 77 00 00       	call   b1f0 <fwp_str_lossy>
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
    3b1f:	e8 1c 48 00 00       	call   8340 <fwp_gc_alloc_slow>
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
    3bc6:	e8 75 47 00 00       	call   8340 <fwp_gc_alloc_slow>
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
    3c6f:	e8 cc 46 00 00       	call   8340 <fwp_gc_alloc_slow>
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
    3dcb:	48 8d 3d bd 2a 01 00 	lea    0x12abd(%rip),%rdi        # 1688f <exec_in_fp0+0x101f>
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
    3e65:	e8 d6 44 00 00       	call   8340 <fwp_gc_alloc_slow>
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
    3ee9:	48 8d 35 db 27 01 00 	lea    0x127db(%rip),%rsi        # 166cb <exec_in_fp0+0xe5b>
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
    3f44:	e8 87 98 00 00       	call   d7d0 <tp_value>
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
    3fc4:	48 8d 35 86 26 01 00 	lea    0x12686(%rip),%rsi        # 16651 <exec_in_fp0+0xde1>
    3fcb:	48 89 df             	mov    %rbx,%rdi
    3fce:	e8 fd f2 ff ff       	call   32d0 <strcmp@plt>
    3fd3:	45 31 e4             	xor    %r12d,%r12d
    3fd6:	85 c0                	test   %eax,%eax
    3fd8:	0f 84 9e 00 00 00    	je     407c <fwp_main_thread+0x91c>
    3fde:	48 8d 35 71 26 01 00 	lea    0x12671(%rip),%rsi        # 16656 <exec_in_fp0+0xde6>
    3fe5:	48 89 df             	mov    %rbx,%rdi
    3fe8:	e8 e3 f2 ff ff       	call   32d0 <strcmp@plt>
    3fed:	85 c0                	test   %eax,%eax
    3fef:	0f 84 98 0f 00 00    	je     4f8d <fwp_main_thread+0x182d>
    3ff5:	48 8d 35 5e 26 01 00 	lea    0x1265e(%rip),%rsi        # 1665a <exec_in_fp0+0xdea>
    3ffc:	48 89 df             	mov    %rbx,%rdi
    3fff:	e8 cc f2 ff ff       	call   32d0 <strcmp@plt>
    4004:	b9 02 00 00 00       	mov    $0x2,%ecx
    4009:	85 c0                	test   %eax,%eax
    400b:	0f 84 81 0f 00 00    	je     4f92 <fwp_main_thread+0x1832>
    4011:	48 89 df             	mov    %rbx,%rdi
    4014:	e8 57 f1 ff ff       	call   3170 <strlen@plt>
    4019:	48 89 df             	mov    %rbx,%rdi
    401c:	48 89 c6             	mov    %rax,%rsi
    401f:	e8 cc 71 00 00       	call   b1f0 <fwp_str_lossy>
    4024:	48 8b 0d ad 5f 01 00 	mov    0x15fad(%rip),%rcx        # 19fd8 <stderr@GLIBC_2.2.5>
    402b:	48 8b 39             	mov    (%rcx),%rdi
    402e:	48 8d 48 08          	lea    0x8(%rax),%rcx
    4032:	48 8d 35 26 26 01 00 	lea    0x12626(%rip),%rsi        # 1665f <exec_in_fp0+0xdef>
    4039:	48 8d 15 aa 19 01 00 	lea    0x119aa(%rip),%rdx        # 159ea <exec_in_fp0+0x17a>
    4040:	31 c0                	xor    %eax,%eax
    4042:	e8 a9 f2 ff ff       	call   32f0 <fprintf@plt>
    4047:	41 bc 02 00 00 00    	mov    $0x2,%r12d
    404d:	e9 a6 0f 00 00       	jmp    4ff8 <fwp_main_thread+0x1898>
    4052:	48 8b 05 7f 5f 01 00 	mov    0x15f7f(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    4059:	48 8b 38             	mov    (%rax),%rdi
    405c:	48 8d 35 bd 26 01 00 	lea    0x126bd(%rip),%rsi        # 16720 <exec_in_fp0+0xeb0>
    4063:	48 8d 15 c9 27 01 00 	lea    0x127c9(%rip),%rdx        # 16833 <exec_in_fp0+0xfc3>
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
    4149:	e8 42 91 00 00       	call   d290 <buf_put>
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
    420d:	e8 7e 90 00 00       	call   d290 <buf_put>
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
    42aa:	48 8d 3d 54 22 01 00 	lea    0x12254(%rip),%rdi        # 16505 <exec_in_fp0+0xc95>
    42b1:	e8 7a ed ff ff       	call   3030 <getenv@plt>
    42b6:	48 85 c0             	test   %rax,%rax
    42b9:	74 27                	je     42e2 <fwp_main_thread+0xb82>
    42bb:	48 8d 35 4b 22 01 00 	lea    0x1224b(%rip),%rsi        # 1650d <exec_in_fp0+0xc9d>
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
    432e:	e8 6d 78 00 00       	call   bba0 <fwp_exec_call>
    4333:	48 89 c3             	mov    %rax,%rbx
    4336:	48 8b 3d 3b 7b 01 00 	mov    0x17b3b(%rip),%rdi        # 1be78 <fwp_prog_out>
    433d:	e8 0e f0 ff ff       	call   3350 <fflush@plt>
    4342:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    4348:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
    434c:	0f 85 69 09 00 00    	jne    4cbb <fwp_main_thread+0x155b>
    4352:	48 89 df             	mov    %rbx,%rdi
    4355:	e8 86 7a 00 00       	call   bde0 <fwp_emit_result>
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
    442f:	48 8d 3d ee 22 01 00 	lea    0x122ee(%rip),%rdi        # 16724 <exec_in_fp0+0xeb4>
    4436:	e8 f5 eb ff ff       	call   3030 <getenv@plt>
    443b:	48 85 c0             	test   %rax,%rax
    443e:	74 17                	je     4457 <fwp_main_thread+0xcf7>
    4440:	48 8d 35 eb 22 01 00 	lea    0x122eb(%rip),%rsi        # 16732 <exec_in_fp0+0xec2>
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
    44cd:	48 8d 15 64 22 01 00 	lea    0x12264(%rip),%rdx        # 16738 <exec_in_fp0+0xec8>
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
    451f:	e8 5c 71 00 00       	call   b680 <fwp_pipe_write>
    4524:	e8 b7 75 00 00       	call   bae0 <fwp_pipe_flush>
    4529:	48 8d 3d 2e 22 01 00 	lea    0x1222e(%rip),%rdi        # 1675e <exec_in_fp0+0xeee>
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
    45d6:	e8 65 c5 00 00       	call   10b40 <fwp_pipe_poll>
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
    4649:	e8 c2 78 00 00       	call   bf10 <fwp_read_exact>
    464e:	bb 0f 00 00 00       	mov    $0xf,%ebx
    4653:	85 c0                	test   %eax,%eax
    4655:	74 99                	je     45f0 <fwp_main_thread+0xe90>
    4657:	be 04 00 00 00       	mov    $0x4,%esi
    465c:	48 8d 7d a3          	lea    -0x5d(%rbp),%rdi
    4660:	e8 ab 78 00 00       	call   bf10 <fwp_read_exact>
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
    472d:	e8 5e 8b 00 00       	call   d290 <buf_put>
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
    4797:	e8 f4 8a 00 00       	call   d290 <buf_put>
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
    47db:	48 8d 05 08 1a 01 00 	lea    0x11a08(%rip),%rax        # 161ea <exec_in_fp0+0x97a>
    47e2:	48 0f 44 f8          	cmove  %rax,%rdi
    47e6:	e8 05 6a 00 00       	call   b1f0 <fwp_str_lossy>
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
    4828:	e8 a3 8f 00 00       	call   d7d0 <tp_value>
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
    48c4:	e8 77 3a 00 00       	call   8340 <fwp_gc_alloc_slow>
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
    48f9:	e8 12 76 00 00       	call   bf10 <fwp_read_exact>
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
    4960:	48 8d 3d 9b 1e 01 00 	lea    0x11e9b(%rip),%rdi        # 16802 <exec_in_fp0+0xf92>
    4967:	e8 c4 e6 ff ff       	call   3030 <getenv@plt>
    496c:	bb 10 00 00 00       	mov    $0x10,%ebx
    4971:	48 85 c0             	test   %rax,%rax
    4974:	0f 84 76 fc ff ff    	je     45f0 <fwp_main_thread+0xe90>
    497a:	80 38 00             	cmpb   $0x0,(%rax)
    497d:	0f 84 6d fc ff ff    	je     45f0 <fwp_main_thread+0xe90>
    4983:	48 89 c7             	mov    %rax,%rdi
    4986:	48 8d 35 48 1e 01 00 	lea    0x11e48(%rip),%rsi        # 167d5 <exec_in_fp0+0xf65>
    498d:	e8 3e e9 ff ff       	call   32d0 <strcmp@plt>
    4992:	85 c0                	test   %eax,%eax
    4994:	0f 84 56 fc ff ff    	je     45f0 <fwp_main_thread+0xe90>
    499a:	48 8b 05 37 56 01 00 	mov    0x15637(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    49a1:	48 8b 38             	mov    (%rax),%rdi
    49a4:	48 8d 35 6c 1e 01 00 	lea    0x11e6c(%rip),%rsi        # 16817 <exec_in_fp0+0xfa7>
    49ab:	48 8d 15 64 1b 01 00 	lea    0x11b64(%rip),%rdx        # 16516 <exec_in_fp0+0xca6>
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
    49ec:	e8 1f 7c 00 00       	call   c610 <fwp_decode>
    49f1:	85 c0                	test   %eax,%eax
    49f3:	0f 84 9c 09 00 00    	je     5395 <fwp_main_thread+0x1c35>
    49f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    4a00:	48 8b 85 50 ff ff ff 	mov    -0xb0(%rbp),%rax
    4a07:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
    4a0b:	48 89 07             	mov    %rax,(%rdi)
    4a0e:	48 8d 75 bc          	lea    -0x44(%rbp),%rsi
    4a12:	e8 89 71 00 00       	call   bba0 <fwp_exec_call>
    4a17:	48 89 c3             	mov    %rax,%rbx
    4a1a:	48 8b 3d 57 74 01 00 	mov    0x17457(%rip),%rdi        # 1be78 <fwp_prog_out>
    4a21:	e8 2a e9 ff ff       	call   3350 <fflush@plt>
    4a26:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
    4a2a:	0f 85 75 02 00 00    	jne    4ca5 <fwp_main_thread+0x1545>
    4a30:	48 89 df             	mov    %rbx,%rdi
    4a33:	e8 a8 73 00 00       	call   bde0 <fwp_emit_result>
    4a38:	e8 a3 70 00 00       	call   bae0 <fwp_pipe_flush>
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
    4c04:	48 8d 3d f7 1b 01 00 	lea    0x11bf7(%rip),%rdi        # 16802 <exec_in_fp0+0xf92>
    4c0b:	e8 20 e4 ff ff       	call   3030 <getenv@plt>
    4c10:	48 85 c0             	test   %rax,%rax
    4c13:	0f 84 c7 f9 ff ff    	je     45e0 <fwp_main_thread+0xe80>
    4c19:	80 38 00             	cmpb   $0x0,(%rax)
    4c1c:	0f 84 be f9 ff ff    	je     45e0 <fwp_main_thread+0xe80>
    4c22:	48 89 c7             	mov    %rax,%rdi
    4c25:	48 8d 35 a9 1b 01 00 	lea    0x11ba9(%rip),%rsi        # 167d5 <exec_in_fp0+0xf65>
    4c2c:	e8 9f e6 ff ff       	call   32d0 <strcmp@plt>
    4c31:	85 c0                	test   %eax,%eax
    4c33:	0f 84 a7 f9 ff ff    	je     45e0 <fwp_main_thread+0xe80>
    4c39:	48 8b 05 98 53 01 00 	mov    0x15398(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    4c40:	48 8b 38             	mov    (%rax),%rdi
    4c43:	48 8d 35 cd 1b 01 00 	lea    0x11bcd(%rip),%rsi        # 16817 <exec_in_fp0+0xfa7>
    4c4a:	48 8d 15 aa 1b 01 00 	lea    0x11baa(%rip),%rdx        # 167fb <exec_in_fp0+0xf8b>
    4c51:	31 c0                	xor    %eax,%eax
    4c53:	e8 98 e6 ff ff       	call   32f0 <fprintf@plt>
    4c58:	e9 83 f9 ff ff       	jmp    45e0 <fwp_main_thread+0xe80>
    4c5d:	48 8b 05 74 53 01 00 	mov    0x15374(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    4c64:	48 8b 38             	mov    (%rax),%rdi
    4c67:	48 8d 35 06 19 01 00 	lea    0x11906(%rip),%rsi        # 16574 <exec_in_fp0+0xd04>
    4c6e:	eb 19                	jmp    4c89 <fwp_main_thread+0x1529>
    4c70:	44 89 f7             	mov    %r14d,%edi
    4c73:	e8 b8 e5 ff ff       	call   3230 <close@plt>
    4c78:	48 8b 05 59 53 01 00 	mov    0x15359(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    4c7f:	48 8b 38             	mov    (%rax),%rdi
    4c82:	48 8d 35 00 19 01 00 	lea    0x11900(%rip),%rsi        # 16589 <exec_in_fp0+0xd19>
    4c89:	48 8d 15 5a 0d 01 00 	lea    0x10d5a(%rip),%rdx        # 159ea <exec_in_fp0+0x17a>
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
    4cd4:	e8 a7 69 00 00       	call   b680 <fwp_pipe_write>
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
    4dea:	e8 21 71 00 00       	call   bf10 <fwp_read_exact>
    4def:	85 c0                	test   %eax,%eax
    4df1:	0f 84 16 05 00 00    	je     530d <fwp_main_thread+0x1bad>
    4df7:	49 c7 c6 f9 ff ff ff 	mov    $0xfffffffffffffff9,%r14
    4dfe:	45 31 ff             	xor    %r15d,%r15d
    4e01:	48 8d 9d d0 fd ff ff 	lea    -0x230(%rbp),%rbx
    4e08:	45 31 e4             	xor    %r12d,%r12d
    4e0b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    4e10:	be 01 00 00 00       	mov    $0x1,%esi
    4e15:	48 89 df             	mov    %rbx,%rdi
    4e18:	e8 f3 70 00 00       	call   bf10 <fwp_read_exact>
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
    4e9b:	e8 70 70 00 00       	call   bf10 <fwp_read_exact>
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
    4ef8:	e8 13 70 00 00       	call   bf10 <fwp_read_exact>
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
    4f76:	e8 95 6f 00 00       	call   bf10 <fwp_read_exact>
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
    5026:	48 8d 3d 84 16 01 00 	lea    0x11684(%rip),%rdi        # 166b1 <exec_in_fp0+0xe41>
    502d:	48 8d 0d de 18 01 00 	lea    0x118de(%rip),%rcx        # 16912 <exec_in_fp0+0x10a2>
    5034:	4c 89 e2             	mov    %r12,%rdx
    5037:	31 c0                	xor    %eax,%eax
    5039:	e8 42 84 00 00       	call   d480 <fwp_strf>
    503e:	48 8b 0d 93 4f 01 00 	mov    0x14f93(%rip),%rcx        # 19fd8 <stderr@GLIBC_2.2.5>
    5045:	48 8b 39             	mov    (%rcx),%rdi
    5048:	48 83 c0 08          	add    $0x8,%rax
    504c:	48 8d 35 bc 16 01 00 	lea    0x116bc(%rip),%rsi        # 1670f <exec_in_fp0+0xe9f>
    5053:	48 8d 15 90 09 01 00 	lea    0x10990(%rip),%rdx        # 159ea <exec_in_fp0+0x17a>
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
    508f:	e8 7c 6e 00 00       	call   bf10 <fwp_read_exact>
    5094:	85 c0                	test   %eax,%eax
    5096:	0f 84 71 02 00 00    	je     530d <fwp_main_thread+0x1bad>
    509c:	48 8d bd 60 ff ff ff 	lea    -0xa0(%rbp),%rdi
    50a3:	e8 78 73 00 00       	call   c420 <fwp_stdin_name_len>
    50a8:	83 f8 01             	cmp    $0x1,%eax
    50ab:	0f 85 50 02 00 00    	jne    5301 <fwp_main_thread+0x1ba1>
    50b1:	4c 8b b5 60 ff ff ff 	mov    -0xa0(%rbp),%r14
    50b8:	49 8d 7e 01          	lea    0x1(%r14),%rdi
    50bc:	e8 0f 65 00 00       	call   b5d0 <fwp_alloc_leaf>
    50c1:	48 89 c3             	mov    %rax,%rbx
    50c4:	4d 85 f6             	test   %r14,%r14
    50c7:	74 13                	je     50dc <fwp_main_thread+0x197c>
    50c9:	48 89 df             	mov    %rbx,%rdi
    50cc:	4c 89 f6             	mov    %r14,%rsi
    50cf:	e8 3c 6e 00 00       	call   bf10 <fwp_read_exact>
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
    5113:	e8 98 73 00 00       	call   c4b0 <fwp_pipe_in_offer>
    5118:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%rbp)
    511f:	e9 9d f2 ff ff       	jmp    43c1 <fwp_main_thread+0xc61>
    5124:	45 31 ff             	xor    %r15d,%r15d
    5127:	45 85 ff             	test   %r15d,%r15d
    512a:	0f 89 dd 01 00 00    	jns    530d <fwp_main_thread+0x1bad>
    5130:	48 8b 05 a1 4e 01 00 	mov    0x14ea1(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    5137:	48 8b 38             	mov    (%rax),%rdi
    513a:	48 8d 35 98 14 01 00 	lea    0x11498(%rip),%rsi        # 165d9 <exec_in_fp0+0xd69>
    5141:	e9 d8 01 00 00       	jmp    531e <fwp_main_thread+0x1bbe>
    5146:	48 8b 05 8b 4e 01 00 	mov    0x14e8b(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    514d:	48 8b 38             	mov    (%rax),%rdi
    5150:	41 8b 0f             	mov    (%r15),%ecx
    5153:	48 8d 35 5a 14 01 00 	lea    0x1145a(%rip),%rsi        # 165b4 <exec_in_fp0+0xd44>
    515a:	48 8d 15 89 08 01 00 	lea    0x10889(%rip),%rdx        # 159ea <exec_in_fp0+0x17a>
    5161:	4c 8d 0d aa 17 01 00 	lea    0x117aa(%rip),%r9        # 16912 <exec_in_fp0+0x10a2>
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
    51d0:	48 8d 35 f9 14 01 00 	lea    0x114f9(%rip),%rsi        # 166d0 <exec_in_fp0+0xe60>
    51d7:	e8 b4 80 00 00       	call   d290 <buf_put>
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
    520f:	e8 7c 80 00 00       	call   d290 <buf_put>
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
    5259:	e8 32 80 00 00       	call   d290 <buf_put>
    525e:	41 80 cd 20          	or     $0x20,%r13b
    5262:	44 88 6d 80          	mov    %r13b,-0x80(%rbp)
    5266:	ba 01 00 00 00       	mov    $0x1,%edx
    526b:	48 89 df             	mov    %rbx,%rdi
    526e:	4c 89 e6             	mov    %r12,%rsi
    5271:	e8 1a 80 00 00       	call   d290 <buf_put>
    5276:	31 c0                	xor    %eax,%eax
    5278:	eb b3                	jmp    522d <fwp_main_thread+0x1acd>
    527a:	48 8d bd d0 fd ff ff 	lea    -0x230(%rbp),%rdi
    5281:	e8 fa 80 00 00       	call   d380 <buf_to_str>
    5286:	48 8d 48 08          	lea    0x8(%rax),%rcx
    528a:	48 8d 3d 08 14 01 00 	lea    0x11408(%rip),%rdi        # 16699 <exec_in_fp0+0xe29>
    5291:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    5295:	48 8b 95 d8 fe ff ff 	mov    -0x128(%rbp),%rdx
    529c:	e9 96 fd ff ff       	jmp    5037 <fwp_main_thread+0x18d7>
    52a1:	48 8b 05 30 4d 01 00 	mov    0x14d30(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    52a8:	48 8b 38             	mov    (%rax),%rdi
    52ab:	48 8d 35 61 13 01 00 	lea    0x11361(%rip),%rsi        # 16613 <exec_in_fp0+0xda3>
    52b2:	48 8d 15 31 07 01 00 	lea    0x10731(%rip),%rdx        # 159ea <exec_in_fp0+0x17a>
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
    5317:	48 8d 35 cb 12 01 00 	lea    0x112cb(%rip),%rsi        # 165e9 <exec_in_fp0+0xd79>
    531e:	48 8d 15 c5 06 01 00 	lea    0x106c5(%rip),%rdx        # 159ea <exec_in_fp0+0x17a>
    5325:	31 c0                	xor    %eax,%eax
    5327:	e8 c4 df ff ff       	call   32f0 <fprintf@plt>
    532c:	41 bc 03 00 00 00    	mov    $0x3,%r12d
    5332:	e9 c1 fc ff ff       	jmp    4ff8 <fwp_main_thread+0x1898>
    5337:	48 8b 05 9a 4c 01 00 	mov    0x14c9a(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    533e:	48 8b 38             	mov    (%rax),%rdi
    5341:	48 8d 35 d5 11 01 00 	lea    0x111d5(%rip),%rsi        # 1651d <exec_in_fp0+0xcad>
    5348:	48 8d 15 9b 06 01 00 	lea    0x1069b(%rip),%rdx        # 159ea <exec_in_fp0+0x17a>
    534f:	31 c0                	xor    %eax,%eax
    5351:	e8 9a df ff ff       	call   32f0 <fprintf@plt>
    5356:	41 bc 03 00 00 00    	mov    $0x3,%r12d
    535c:	e9 97 fc ff ff       	jmp    4ff8 <fwp_main_thread+0x1898>
    5361:	48 8b 05 70 4c 01 00 	mov    0x14c70(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    5368:	48 8b 38             	mov    (%rax),%rdi
    536b:	48 8d 35 d0 11 01 00 	lea    0x111d0(%rip),%rsi        # 16542 <exec_in_fp0+0xcd2>
    5372:	48 8d 15 71 06 01 00 	lea    0x10671(%rip),%rdx        # 159ea <exec_in_fp0+0x17a>
    5379:	48 8d 0d 92 15 01 00 	lea    0x11592(%rip),%rcx        # 16912 <exec_in_fp0+0x10a2>
    5380:	49 89 d8             	mov    %rbx,%r8
    5383:	31 c0                	xor    %eax,%eax
    5385:	e8 66 df ff ff       	call   32f0 <fprintf@plt>
    538a:	41 bc 03 00 00 00    	mov    $0x3,%r12d
    5390:	e9 63 fc ff ff       	jmp    4ff8 <fwp_main_thread+0x1898>
    5395:	48 8b 05 3c 4c 01 00 	mov    0x14c3c(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    539c:	48 8b 38             	mov    (%rax),%rdi
    539f:	48 8d 35 f9 11 01 00 	lea    0x111f9(%rip),%rsi        # 1659f <exec_in_fp0+0xd2f>
    53a6:	48 8d 15 3d 06 01 00 	lea    0x1063d(%rip),%rdx        # 159ea <exec_in_fp0+0x17a>
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
    53cd:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    53d4:	83 3d 99 5e 01 00 00 	cmpl   $0x0,0x15e99(%rip)        # 1b274 <fwp_gc+0xfec>
    53db:	75 05                	jne    53e2 <main+0x22>
    53dd:	e8 4e 30 00 00       	call   8430 <fwp_gc_init>
    53e2:	48 89 2d 27 5f 01 00 	mov    %rbp,0x15f27(%rip)        # 1b310 <fwp_gc+0x1088>
    53e9:	48 8d 3d 30 e7 00 00 	lea    0xe730(%rip),%rdi        # 13b20 <fwp_gc_find_data>
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
    541f:	48 8d 3d da e7 00 00 	lea    0xe7da(%rip),%rdi        # 13c00 <fwp_gc_report>
    5426:	e8 e5 ec 00 00       	call   14110 <atexit>
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
    5529:	e8 22 03 00 00       	call   5850 <fwp_array_new_packed>
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
    55cc:	e8 df 15 00 00       	call   6bb0 <fwp_rc_forget_slot>
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
    569a:	0f 88 78 01 00 00    	js     5818 <main+0x458>
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
    5712:	48 8b 05 a7 67 01 00 	mov    0x167a7(%rip),%rax        # 1bec0 <measured_scopes>
    5719:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
    571d:	f3 0f 7e 05 6b 5d 01 	movq   0x15d6b(%rip),%xmm0        # 1b490 <fwp_gc+0x1208>
    5724:	00 
    5725:	66 0f d6 45 d0       	movq   %xmm0,-0x30(%rbp)
    572a:	4c 89 e7             	mov    %r12,%rdi
    572d:	e8 1e 03 00 00       	call   5a50 <f0>
    5732:	49 89 c2             	mov    %rax,%r10
    5735:	49 83 fe 02          	cmp    $0x2,%r14
    5739:	77 13                	ja     574e <main+0x38e>
    573b:	f3 0f 7e 45 c8       	movq   -0x38(%rbp),%xmm0
    5740:	66 48 0f 7e c0       	movq   %xmm0,%rax
    5745:	49 39 c2             	cmp    %rax,%r10
    5748:	0f 85 a5 00 00 00    	jne    57f3 <main+0x433>
    574e:	48 8b 0d 53 67 01 00 	mov    0x16753(%rip),%rcx        # 1bea8 <measured_calls>
    5755:	48 29 d9             	sub    %rbx,%rcx
    5758:	48 83 f9 02          	cmp    $0x2,%rcx
    575c:	0f 82 98 00 00 00    	jb     57fa <main+0x43a>
    5762:	f2 0f 10 05 26 5d 01 	movsd  0x15d26(%rip),%xmm0        # 1b490 <fwp_gc+0x1208>
    5769:	00 
    576a:	f2 0f 10 4d d0       	movsd  -0x30(%rbp),%xmm1
    576f:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
    5773:	0f 83 88 00 00 00    	jae    5801 <main+0x441>
    5779:	4c 8b 05 30 67 01 00 	mov    0x16730(%rip),%r8        # 1beb0 <measured_bytes>
    5780:	4c 2b 45 c0          	sub    -0x40(%rbp),%r8
    5784:	4c 8b 0d 2d 67 01 00 	mov    0x1672d(%rip),%r9        # 1beb8 <measured_retains>
    578b:	4c 2b 4d b8          	sub    -0x48(%rbp),%r9
    578f:	4c 8b 1d 2a 67 01 00 	mov    0x1672a(%rip),%r11        # 1bec0 <measured_scopes>
    5796:	4c 2b 5d b0          	sub    -0x50(%rbp),%r11
    579a:	4d 85 f6             	test   %r14,%r14
    579d:	48 8d 35 40 02 01 00 	lea    0x10240(%rip),%rsi        # 159e4 <exec_in_fp0+0x174>
    57a4:	48 8d 05 3f 0a 01 00 	lea    0x10a3f(%rip),%rax        # 161ea <exec_in_fp0+0x97a>
    57ab:	48 0f 44 f0          	cmove  %rax,%rsi
    57af:	f2 0f 5c c1          	subsd  %xmm1,%xmm0
    57b3:	48 8d 3d 99 01 01 00 	lea    0x10199(%rip),%rdi        # 15953 <exec_in_fp0+0xe3>
    57ba:	4c 89 fa             	mov    %r15,%rdx
    57bd:	b0 01                	mov    $0x1,%al
    57bf:	41 52                	push   %r10
    57c1:	41 53                	push   %r11
    57c3:	e8 f8 d9 ff ff       	call   31c0 <printf@plt>
    57c8:	48 83 c4 10          	add    $0x10,%rsp
    57cc:	49 ff c6             	inc    %r14
    57cf:	49 83 fe 05          	cmp    $0x5,%r14
    57d3:	48 bb c5 4e ec c4 4e 	movabs $0x4ec4ec4ec4ec4ec5,%rbx
    57da:	ec c4 4e 
    57dd:	0f 85 0d fd ff ff    	jne    54f0 <main+0x130>
    57e3:	48 8d 3d fd 01 01 00 	lea    0x101fd(%rip),%rdi        # 159e7 <exec_in_fp0+0x177>
    57ea:	e8 e1 d8 ff ff       	call   30d0 <puts@plt>
    57ef:	31 c0                	xor    %eax,%eax
    57f1:	eb 13                	jmp    5806 <main+0x446>
    57f3:	b8 aa 00 00 00       	mov    $0xaa,%eax
    57f8:	eb 0c                	jmp    5806 <main+0x446>
    57fa:	b8 ac 00 00 00       	mov    $0xac,%eax
    57ff:	eb 05                	jmp    5806 <main+0x446>
    5801:	b8 ad 00 00 00       	mov    $0xad,%eax
    5806:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
    580d:	5b                   	pop    %rbx
    580e:	41 5c                	pop    %r12
    5810:	41 5d                	pop    %r13
    5812:	41 5e                	pop    %r14
    5814:	41 5f                	pop    %r15
    5816:	5d                   	pop    %rbp
    5817:	c3                   	ret
    5818:	e8 43 14 00 00       	call   6c60 <fwp_flush>
    581d:	48 8b 05 b4 47 01 00 	mov    0x147b4(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    5824:	48 8b 38             	mov    (%rax),%rdi
    5827:	48 8d 35 80 02 01 00 	lea    0x10280(%rip),%rsi        # 15aae <exec_in_fp0+0x23e>
    582e:	48 8d 15 c1 11 01 00 	lea    0x111c1(%rip),%rdx        # 169f6 <exec_in_fp0+0x1186>
    5835:	31 c0                	xor    %eax,%eax
    5837:	e8 b4 da ff ff       	call   32f0 <fprintf@plt>
    583c:	bf 65 00 00 00       	mov    $0x65,%edi
    5841:	e8 1a dc ff ff       	call   3460 <exit@plt>
    5846:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    584d:	00 00 00 

0000000000005850 <fwp_array_new_packed>:
    5850:	41 56                	push   %r14
    5852:	53                   	push   %rbx
    5853:	50                   	push   %rax
    5854:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    585b:	ff ff 1f 
    585e:	48 39 c7             	cmp    %rax,%rdi
    5861:	0f 83 b7 01 00 00    	jae    5a1e <fwp_array_new_packed+0x1ce>
    5867:	48 89 fb             	mov    %rdi,%rbx
    586a:	48 85 f6             	test   %rsi,%rsi
    586d:	74 23                	je     5892 <fwp_array_new_packed+0x42>
    586f:	8b 06                	mov    (%rsi),%eax
    5871:	48 83 f8 0a          	cmp    $0xa,%rax
    5875:	77 0e                	ja     5885 <fwp_array_new_packed+0x35>
    5877:	b9 e7 04 00 00       	mov    $0x4e7,%ecx
    587c:	0f a3 c1             	bt     %eax,%ecx
    587f:	0f 82 a1 00 00 00    	jb     5926 <fwp_array_new_packed+0xd6>
    5885:	48 8d 0c dd 00 00 00 	lea    0x0(,%rbx,8),%rcx
    588c:	00 
    588d:	e9 a3 00 00 00       	jmp    5935 <fwp_array_new_packed+0xe5>
    5892:	48 8d 14 dd 08 00 00 	lea    0x8(,%rbx,8),%rdx
    5899:	00 
    589a:	48 ff 05 07 66 01 00 	incq   0x16607(%rip)        # 1bea8 <measured_calls>
    58a1:	48 01 15 08 66 01 00 	add    %rdx,0x16608(%rip)        # 1beb0 <measured_bytes>
    58a8:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    58af:	77 68                	ja     5919 <fwp_array_new_packed+0xc9>
    58b1:	48 8d 42 0f          	lea    0xf(%rdx),%rax
    58b5:	48 c1 e8 04          	shr    $0x4,%rax
    58b9:	48 8d 0d c8 49 01 00 	lea    0x149c8(%rip),%rcx        # 1a288 <fwp_gc>
    58c0:	0f b6 b4 08 e8 0b 00 	movzbl 0xbe8(%rax,%rcx,1),%esi
    58c7:	00 
    58c8:	8b 84 b1 48 0b 00 00 	mov    0xb48(%rcx,%rsi,4),%eax
    58cf:	48 29 05 b2 49 01 00 	sub    %rax,0x149b2(%rip)        # 1a288 <fwp_gc>
    58d6:	78 41                	js     5919 <fwp_array_new_packed+0xc9>
    58d8:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    58dc:	48 8d 3c f1          	lea    (%rcx,%rsi,8),%rdi
    58e0:	48 81 c7 88 07 00 00 	add    $0x788,%rdi
    58e7:	4c 8b 37             	mov    (%rdi),%r14
    58ea:	4d 85 f6             	test   %r14,%r14
    58ed:	74 0e                	je     58fd <fwp_array_new_packed+0xad>
    58ef:	49 8b 0e             	mov    (%r14),%rcx
    58f2:	48 f7 d1             	not    %rcx
    58f5:	48 89 0f             	mov    %rcx,(%rdi)
    58f8:	e9 06 01 00 00       	jmp    5a03 <fwp_array_new_packed+0x1b3>
    58fd:	4c 8b b4 f1 90 07 00 	mov    0x790(%rcx,%rsi,8),%r14
    5904:	00 
    5905:	48 8b bc f1 98 07 00 	mov    0x798(%rcx,%rsi,8),%rdi
    590c:	00 
    590d:	4c 29 f7             	sub    %r14,%rdi
    5910:	48 39 c7             	cmp    %rax,%rdi
    5913:	0f 83 d8 00 00 00    	jae    59f1 <fwp_array_new_packed+0x1a1>
    5919:	48 89 d7             	mov    %rdx,%rdi
    591c:	be 02 00 00 00       	mov    $0x2,%esi
    5921:	e9 aa 00 00 00       	jmp    59d0 <fwp_array_new_packed+0x180>
    5926:	48 8d 0d 6b ff 00 00 	lea    0xff6b(%rip),%rcx        # 15898 <exec_in_fp0+0x28>
    592d:	48 8b 0c c1          	mov    (%rcx,%rax,8),%rcx
    5931:	48 0f af cb          	imul   %rbx,%rcx
    5935:	48 8d 51 08          	lea    0x8(%rcx),%rdx
    5939:	83 f8 0b             	cmp    $0xb,%eax
    593c:	0f 87 58 ff ff ff    	ja     589a <fwp_array_new_packed+0x4a>
    5942:	be ef 0d 00 00       	mov    $0xdef,%esi
    5947:	0f a3 c6             	bt     %eax,%esi
    594a:	0f 83 4a ff ff ff    	jae    589a <fwp_array_new_packed+0x4a>
    5950:	48 ff 05 51 65 01 00 	incq   0x16551(%rip)        # 1bea8 <measured_calls>
    5957:	48 01 15 52 65 01 00 	add    %rdx,0x16552(%rip)        # 1beb0 <measured_bytes>
    595e:	48 81 f9 f8 3f 00 00 	cmp    $0x3ff8,%rcx
    5965:	77 61                	ja     59c8 <fwp_array_new_packed+0x178>
    5967:	48 83 c1 17          	add    $0x17,%rcx
    596b:	48 c1 e9 04          	shr    $0x4,%rcx
    596f:	48 8d 05 12 49 01 00 	lea    0x14912(%rip),%rax        # 1a288 <fwp_gc>
    5976:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    597d:	00 
    597e:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    5985:	48 29 0d fc 48 01 00 	sub    %rcx,0x148fc(%rip)        # 1a288 <fwp_gc>
    598c:	78 3a                	js     59c8 <fwp_array_new_packed+0x178>
    598e:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    5992:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    5996:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    599d:	4c 8b 37             	mov    (%rdi),%r14
    59a0:	4d 85 f6             	test   %r14,%r14
    59a3:	74 0b                	je     59b0 <fwp_array_new_packed+0x160>
    59a5:	49 8b 06             	mov    (%r14),%rax
    59a8:	48 f7 d0             	not    %rax
    59ab:	48 89 07             	mov    %rax,(%rdi)
    59ae:	eb 3a                	jmp    59ea <fwp_array_new_packed+0x19a>
    59b0:	4c 8b b4 f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r14
    59b7:	00 
    59b8:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    59bf:	00 
    59c0:	4c 29 f7             	sub    %r14,%rdi
    59c3:	48 39 cf             	cmp    %rcx,%rdi
    59c6:	73 12                	jae    59da <fwp_array_new_packed+0x18a>
    59c8:	48 89 d7             	mov    %rdx,%rdi
    59cb:	be 01 00 00 00       	mov    $0x1,%esi
    59d0:	e8 6b 29 00 00       	call   8340 <fwp_gc_alloc_slow>
    59d5:	49 89 c6             	mov    %rax,%r14
    59d8:	eb 36                	jmp    5a10 <fwp_array_new_packed+0x1c0>
    59da:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    59de:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    59e4:	4c 01 f1             	add    %r14,%rcx
    59e7:	48 89 08             	mov    %rcx,(%rax)
    59ea:	4c 89 f7             	mov    %r14,%rdi
    59ed:	31 f6                	xor    %esi,%esi
    59ef:	eb 1a                	jmp    5a0b <fwp_array_new_packed+0x1bb>
    59f1:	48 8d 0c f1          	lea    (%rcx,%rsi,8),%rcx
    59f5:	48 81 c1 90 07 00 00 	add    $0x790,%rcx
    59fc:	49 8d 14 06          	lea    (%r14,%rax,1),%rdx
    5a00:	48 89 11             	mov    %rdx,(%rcx)
    5a03:	4c 89 f7             	mov    %r14,%rdi
    5a06:	31 f6                	xor    %esi,%esi
    5a08:	48 89 c2             	mov    %rax,%rdx
    5a0b:	e8 00 d8 ff ff       	call   3210 <memset@plt>
    5a10:	49 89 1e             	mov    %rbx,(%r14)
    5a13:	4c 89 f0             	mov    %r14,%rax
    5a16:	48 83 c4 08          	add    $0x8,%rsp
    5a1a:	5b                   	pop    %rbx
    5a1b:	41 5e                	pop    %r14
    5a1d:	c3                   	ret
    5a1e:	e8 3d 12 00 00       	call   6c60 <fwp_flush>
    5a23:	48 8b 05 ae 45 01 00 	mov    0x145ae(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    5a2a:	48 8b 38             	mov    (%rax),%rdi
    5a2d:	48 8d 35 7a 00 01 00 	lea    0x1007a(%rip),%rsi        # 15aae <exec_in_fp0+0x23e>
    5a34:	48 8d 15 82 00 01 00 	lea    0x10082(%rip),%rdx        # 15abd <exec_in_fp0+0x24d>
    5a3b:	31 c0                	xor    %eax,%eax
    5a3d:	e8 ae d8 ff ff       	call   32f0 <fprintf@plt>
    5a42:	bf 65 00 00 00       	mov    $0x65,%edi
    5a47:	e8 14 da ff ff       	call   3460 <exit@plt>
    5a4c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000005a50 <f0>:
    5a50:	55                   	push   %rbp
    5a51:	41 57                	push   %r15
    5a53:	41 56                	push   %r14
    5a55:	41 55                	push   %r13
    5a57:	41 54                	push   %r12
    5a59:	53                   	push   %rbx
    5a5a:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    5a61:	48 89 fb             	mov    %rdi,%rbx
    5a64:	0f 10 05 05 f7 00 00 	movups 0xf705(%rip),%xmm0        # 15170 <_IO_stdin_used+0x170>
    5a6b:	0f 29 44 24 70       	movaps %xmm0,0x70(%rsp)
    5a70:	0f 10 05 09 f7 00 00 	movups 0xf709(%rip),%xmm0        # 15180 <_IO_stdin_used+0x180>
    5a77:	0f 29 44 24 60       	movaps %xmm0,0x60(%rsp)
    5a7c:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
    5a81:	48 ff 05 38 64 01 00 	incq   0x16438(%rip)        # 1bec0 <measured_scopes>
    5a88:	48 8b 05 39 64 01 00 	mov    0x16439(%rip),%rax        # 1bec8 <fwp_cleanups>
    5a8f:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
    5a94:	48 8d 05 b5 e3 00 00 	lea    0xe3b5(%rip),%rax        # 13e50 <fwp_owner_release0>
    5a9b:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    5aa0:	48 8d 44 24 28       	lea    0x28(%rsp),%rax
    5aa5:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
    5aaa:	4c 8d 7c 24 48       	lea    0x48(%rsp),%r15
    5aaf:	4c 89 3d 12 64 01 00 	mov    %r15,0x16412(%rip)        # 1bec8 <fwp_cleanups>
    5ab6:	48 8d 0d c3 62 01 00 	lea    0x162c3(%rip),%rcx        # 1bd80 <d2>
    5abd:	48 8d 7c 24 60       	lea    0x60(%rsp),%rdi
    5ac2:	48 89 de             	mov    %rbx,%rsi
    5ac5:	48 89 ca             	mov    %rcx,%rdx
    5ac8:	e8 d3 12 00 00       	call   6da0 <fwp_p_array_map_typed>
    5acd:	4c 39 3d f4 63 01 00 	cmp    %r15,0x163f4(%rip)        # 1bec8 <fwp_cleanups>
    5ad4:	0f 85 0f 02 00 00    	jne    5ce9 <f0+0x299>
    5ada:	49 89 c6             	mov    %rax,%r14
    5add:	48 8b 44 24 48       	mov    0x48(%rsp),%rax
    5ae2:	48 89 05 df 63 01 00 	mov    %rax,0x163df(%rip)        # 1bec8 <fwp_cleanups>
    5ae9:	48 8d 44 24 60       	lea    0x60(%rsp),%rax
    5aee:	48 89 df             	mov    %rbx,%rdi
    5af1:	e8 6a e3 00 00       	call   13e60 <fwp_drop0>
    5af6:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    5afb:	48 ff 05 be 63 01 00 	incq   0x163be(%rip)        # 1bec0 <measured_scopes>
    5b02:	48 8b 05 bf 63 01 00 	mov    0x163bf(%rip),%rax        # 1bec8 <fwp_cleanups>
    5b09:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    5b0e:	48 8d 05 2b e4 00 00 	lea    0xe42b(%rip),%rax        # 13f40 <fwp_owner_release1>
    5b15:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    5b1a:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    5b1f:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    5b24:	4c 8d 7c 24 30       	lea    0x30(%rsp),%r15
    5b29:	4c 89 3d 98 63 01 00 	mov    %r15,0x16398(%rip)        # 1bec8 <fwp_cleanups>
    5b30:	48 8d 0d 49 62 01 00 	lea    0x16249(%rip),%rcx        # 1bd80 <d2>
    5b37:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    5b3c:	4c 89 f6             	mov    %r14,%rsi
    5b3f:	48 89 ca             	mov    %rcx,%rdx
    5b42:	e8 59 12 00 00       	call   6da0 <fwp_p_array_map_typed>
    5b47:	4c 39 3d 7a 63 01 00 	cmp    %r15,0x1637a(%rip)        # 1bec8 <fwp_cleanups>
    5b4e:	0f 85 95 01 00 00    	jne    5ce9 <f0+0x299>
    5b54:	48 89 c3             	mov    %rax,%rbx
    5b57:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
    5b5e:	ff ff 7f 
    5b61:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    5b66:	48 89 05 5b 63 01 00 	mov    %rax,0x1635b(%rip)        # 1bec8 <fwp_cleanups>
    5b6d:	48 8d 44 24 70       	lea    0x70(%rsp),%rax
    5b72:	4c 89 f7             	mov    %r14,%rdi
    5b75:	e8 e6 e2 00 00       	call   13e60 <fwp_drop0>
    5b7a:	48 ff 05 3f 63 01 00 	incq   0x1633f(%rip)        # 1bec0 <measured_scopes>
    5b81:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    5b86:	48 8b 05 3b 63 01 00 	mov    0x1633b(%rip),%rax        # 1bec8 <fwp_cleanups>
    5b8d:	48 89 04 24          	mov    %rax,(%rsp)
    5b91:	48 8d 05 b8 e3 00 00 	lea    0xe3b8(%rip),%rax        # 13f50 <fwp_owner_release2>
    5b98:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    5b9d:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
    5ba2:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    5ba7:	48 89 e0             	mov    %rsp,%rax
    5baa:	48 89 05 17 63 01 00 	mov    %rax,0x16317(%rip)        # 1bec8 <fwp_cleanups>
    5bb1:	48 8b 0b             	mov    (%rbx),%rcx
    5bb4:	48 8d 04 4d 00 00 00 	lea    0x0(,%rcx,2),%rax
    5bbb:	00 
    5bbc:	48 85 c0             	test   %rax,%rax
    5bbf:	0f 84 d9 00 00 00    	je     5c9e <f0+0x24e>
    5bc5:	48 89 dd             	mov    %rbx,%rbp
    5bc8:	48 83 c5 08          	add    $0x8,%rbp
    5bcc:	49 8d 44 24 01       	lea    0x1(%r12),%rax
    5bd1:	45 31 ed             	xor    %r13d,%r13d
    5bd4:	4c 8d 35 75 62 01 00 	lea    0x16275(%rip),%r14        # 1be50 <fc21>
    5bdb:	4c 8d bc 24 80 00 00 	lea    0x80(%rsp),%r15
    5be2:	00 
    5be3:	eb 48                	jmp    5c2d <f0+0x1dd>
    5be5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    5bec:	00 00 00 00 
    5bf0:	0f b7 0c 0e          	movzwl (%rsi,%rcx,1),%ecx
    5bf4:	83 f8 01             	cmp    $0x1,%eax
    5bf7:	48 0f bf c1          	movswq %cx,%rax
    5bfb:	48 0f 45 c1          	cmovne %rcx,%rax
    5bff:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
    5c06:	00 
    5c07:	4c 89 f7             	mov    %r14,%rdi
    5c0a:	be 02 00 00 00       	mov    $0x2,%esi
    5c0f:	4c 89 fa             	mov    %r15,%rdx
    5c12:	b9 01 00 00 00       	mov    $0x1,%ecx
    5c17:	e8 f4 13 00 00       	call   7010 <fwp_apply_borrowed_prefix>
    5c1c:	49 ff c5             	inc    %r13
    5c1f:	48 8b 0b             	mov    (%rbx),%rcx
    5c22:	48 89 ca             	mov    %rcx,%rdx
    5c25:	4c 21 e2             	and    %r12,%rdx
    5c28:	49 39 d5             	cmp    %rdx,%r13
    5c2b:	73 77                	jae    5ca4 <f0+0x254>
    5c2d:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
    5c34:	00 
    5c35:	8b 05 45 61 01 00    	mov    0x16145(%rip),%eax        # 1bd80 <d2>
    5c3b:	ba 08 00 00 00       	mov    $0x8,%edx
    5c40:	48 83 f8 0a          	cmp    $0xa,%rax
    5c44:	77 0b                	ja     5c51 <f0+0x201>
    5c46:	48 8d 15 a3 fc 00 00 	lea    0xfca3(%rip),%rdx        # 158f0 <exec_in_fp0+0x80>
    5c4d:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
    5c51:	48 89 ee             	mov    %rbp,%rsi
    5c54:	48 85 c9             	test   %rcx,%rcx
    5c57:	79 04                	jns    5c5d <f0+0x20d>
    5c59:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    5c5d:	48 89 d1             	mov    %rdx,%rcx
    5c60:	49 0f af cd          	imul   %r13,%rcx
    5c64:	48 83 fa 01          	cmp    $0x1,%rdx
    5c68:	74 16                	je     5c80 <f0+0x230>
    5c6a:	48 83 fa 02          	cmp    $0x2,%rdx
    5c6e:	74 80                	je     5bf0 <f0+0x1a0>
    5c70:	48 83 fa 08          	cmp    $0x8,%rdx
    5c74:	75 1a                	jne    5c90 <f0+0x240>
    5c76:	48 8b 04 0e          	mov    (%rsi,%rcx,1),%rax
    5c7a:	eb 83                	jmp    5bff <f0+0x1af>
    5c7c:	0f 1f 40 00          	nopl   0x0(%rax)
    5c80:	0f b6 0c 0e          	movzbl (%rsi,%rcx,1),%ecx
    5c84:	48 85 c0             	test   %rax,%rax
    5c87:	48 0f be c1          	movsbq %cl,%rax
    5c8b:	e9 6b ff ff ff       	jmp    5bfb <f0+0x1ab>
    5c90:	8b 0c 0e             	mov    (%rsi,%rcx,1),%ecx
    5c93:	83 f8 02             	cmp    $0x2,%eax
    5c96:	48 63 c1             	movslq %ecx,%rax
    5c99:	e9 5d ff ff ff       	jmp    5bfb <f0+0x1ab>
    5c9e:	49 ff c4             	inc    %r12
    5ca1:	4c 89 e0             	mov    %r12,%rax
    5ca4:	49 89 c6             	mov    %rax,%r14
    5ca7:	48 8d 05 a2 61 01 00 	lea    0x161a2(%rip),%rax        # 1be50 <fc21>
    5cae:	48 89 e0             	mov    %rsp,%rax
    5cb1:	48 39 05 10 62 01 00 	cmp    %rax,0x16210(%rip)        # 1bec8 <fwp_cleanups>
    5cb8:	75 2f                	jne    5ce9 <f0+0x299>
    5cba:	48 8b 04 24          	mov    (%rsp),%rax
    5cbe:	48 89 05 03 62 01 00 	mov    %rax,0x16203(%rip)        # 1bec8 <fwp_cleanups>
    5cc5:	48 8d 05 84 61 01 00 	lea    0x16184(%rip),%rax        # 1be50 <fc21>
    5ccc:	48 89 df             	mov    %rbx,%rdi
    5ccf:	e8 8c e1 00 00       	call   13e60 <fwp_drop0>
    5cd4:	4c 89 f0             	mov    %r14,%rax
    5cd7:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    5cde:	5b                   	pop    %rbx
    5cdf:	41 5c                	pop    %r12
    5ce1:	41 5d                	pop    %r13
    5ce3:	41 5e                	pop    %r14
    5ce5:	41 5f                	pop    %r15
    5ce7:	5d                   	pop    %rbp
    5ce8:	c3                   	ret
    5ce9:	e8 82 d3 ff ff       	call   3070 <abort@plt>
    5cee:	66 90                	xchg   %ax,%ax

0000000000005cf0 <e0>:
    5cf0:	53                   	push   %rbx
    5cf1:	48 89 fb             	mov    %rdi,%rbx
    5cf4:	48 8b 3f             	mov    (%rdi),%rdi
    5cf7:	e8 84 0c 00 00       	call   6980 <fwp_rc_share>
    5cfc:	48 8b 3b             	mov    (%rbx),%rdi
    5cff:	e8 4c fd ff ff       	call   5a50 <f0>
    5d04:	48 89 c3             	mov    %rax,%rbx
    5d07:	48 89 c7             	mov    %rax,%rdi
    5d0a:	e8 71 0c 00 00       	call   6980 <fwp_rc_share>
    5d0f:	48 89 d8             	mov    %rbx,%rax
    5d12:	5b                   	pop    %rbx
    5d13:	c3                   	ret
    5d14:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    5d1b:	00 00 00 00 00 

0000000000005d20 <e1>:
    5d20:	55                   	push   %rbp
    5d21:	41 57                	push   %r15
    5d23:	41 56                	push   %r14
    5d25:	41 55                	push   %r13
    5d27:	41 54                	push   %r12
    5d29:	53                   	push   %rbx
    5d2a:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    5d31:	48 89 fb             	mov    %rdi,%rbx
    5d34:	48 8b 3f             	mov    (%rdi),%rdi
    5d37:	e8 44 0c 00 00       	call   6980 <fwp_rc_share>
    5d3c:	48 8b 1b             	mov    (%rbx),%rbx
    5d3f:	0f 10 05 fa f3 00 00 	movups 0xf3fa(%rip),%xmm0        # 15140 <_IO_stdin_used+0x140>
    5d46:	0f 29 44 24 70       	movaps %xmm0,0x70(%rsp)
    5d4b:	0f 10 05 fe f3 00 00 	movups 0xf3fe(%rip),%xmm0        # 15150 <_IO_stdin_used+0x150>
    5d52:	0f 29 44 24 60       	movaps %xmm0,0x60(%rsp)
    5d57:	48 89 5c 24 28       	mov    %rbx,0x28(%rsp)
    5d5c:	48 ff 05 5d 61 01 00 	incq   0x1615d(%rip)        # 1bec0 <measured_scopes>
    5d63:	48 8b 05 5e 61 01 00 	mov    0x1615e(%rip),%rax        # 1bec8 <fwp_cleanups>
    5d6a:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
    5d6f:	48 8d 05 1a 0f 00 00 	lea    0xf1a(%rip),%rax        # 6c90 <fwp_owner_release3>
    5d76:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    5d7b:	48 8d 44 24 28       	lea    0x28(%rsp),%rax
    5d80:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
    5d85:	4c 8d 7c 24 48       	lea    0x48(%rsp),%r15
    5d8a:	4c 89 3d 37 61 01 00 	mov    %r15,0x16137(%rip)        # 1bec8 <fwp_cleanups>
    5d91:	48 8d 0d 18 5f 01 00 	lea    0x15f18(%rip),%rcx        # 1bcb0 <d1>
    5d98:	48 8d 7c 24 60       	lea    0x60(%rsp),%rdi
    5d9d:	48 89 de             	mov    %rbx,%rsi
    5da0:	48 89 ca             	mov    %rcx,%rdx
    5da3:	e8 f8 0f 00 00       	call   6da0 <fwp_p_array_map_typed>
    5da8:	4c 39 3d 19 61 01 00 	cmp    %r15,0x16119(%rip)        # 1bec8 <fwp_cleanups>
    5daf:	0f 85 0b 02 00 00    	jne    5fc0 <e1+0x2a0>
    5db5:	49 89 c6             	mov    %rax,%r14
    5db8:	48 8b 44 24 48       	mov    0x48(%rsp),%rax
    5dbd:	48 89 05 04 61 01 00 	mov    %rax,0x16104(%rip)        # 1bec8 <fwp_cleanups>
    5dc4:	48 8d 44 24 60       	lea    0x60(%rsp),%rax
    5dc9:	48 89 df             	mov    %rbx,%rdi
    5dcc:	e8 cf 0e 00 00       	call   6ca0 <fwp_drop1>
    5dd1:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    5dd6:	48 ff 05 e3 60 01 00 	incq   0x160e3(%rip)        # 1bec0 <measured_scopes>
    5ddd:	48 8b 05 e4 60 01 00 	mov    0x160e4(%rip),%rax        # 1bec8 <fwp_cleanups>
    5de4:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    5de9:	48 8d 05 90 0f 00 00 	lea    0xf90(%rip),%rax        # 6d80 <fwp_owner_release4>
    5df0:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    5df5:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    5dfa:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    5dff:	4c 8d 7c 24 30       	lea    0x30(%rsp),%r15
    5e04:	4c 89 3d bd 60 01 00 	mov    %r15,0x160bd(%rip)        # 1bec8 <fwp_cleanups>
    5e0b:	48 8d 0d 9e 5e 01 00 	lea    0x15e9e(%rip),%rcx        # 1bcb0 <d1>
    5e12:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    5e17:	4c 89 f6             	mov    %r14,%rsi
    5e1a:	48 89 ca             	mov    %rcx,%rdx
    5e1d:	e8 7e 0f 00 00       	call   6da0 <fwp_p_array_map_typed>
    5e22:	4c 39 3d 9f 60 01 00 	cmp    %r15,0x1609f(%rip)        # 1bec8 <fwp_cleanups>
    5e29:	0f 85 91 01 00 00    	jne    5fc0 <e1+0x2a0>
    5e2f:	48 89 c3             	mov    %rax,%rbx
    5e32:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    5e37:	48 89 05 8a 60 01 00 	mov    %rax,0x1608a(%rip)        # 1bec8 <fwp_cleanups>
    5e3e:	48 8d 44 24 70       	lea    0x70(%rsp),%rax
    5e43:	4c 89 f7             	mov    %r14,%rdi
    5e46:	e8 55 0e 00 00       	call   6ca0 <fwp_drop1>
    5e4b:	48 ff 05 6e 60 01 00 	incq   0x1606e(%rip)        # 1bec0 <measured_scopes>
    5e52:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    5e57:	48 8b 05 6a 60 01 00 	mov    0x1606a(%rip),%rax        # 1bec8 <fwp_cleanups>
    5e5e:	48 89 04 24          	mov    %rax,(%rsp)
    5e62:	48 8d 05 27 0f 00 00 	lea    0xf27(%rip),%rax        # 6d90 <fwp_owner_release5>
    5e69:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    5e6e:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
    5e73:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    5e78:	48 89 e2             	mov    %rsp,%rdx
    5e7b:	48 89 15 46 60 01 00 	mov    %rdx,0x16046(%rip)        # 1bec8 <fwp_cleanups>
    5e82:	48 8b 0b             	mov    (%rbx),%rcx
    5e85:	48 8d 04 4d 00 00 00 	lea    0x0(,%rcx,2),%rax
    5e8c:	00 
    5e8d:	48 85 c0             	test   %rax,%rax
    5e90:	0f 84 e0 00 00 00    	je     5f76 <e1+0x256>
    5e96:	49 bd ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r13
    5e9d:	ff ff 7f 
    5ea0:	48 89 dd             	mov    %rbx,%rbp
    5ea3:	48 83 c5 08          	add    $0x8,%rbp
    5ea7:	45 31 e4             	xor    %r12d,%r12d
    5eaa:	4c 8d 35 f7 5d 01 00 	lea    0x15df7(%rip),%r14        # 1bca8 <fc13>
    5eb1:	4c 8d bc 24 80 00 00 	lea    0x80(%rsp),%r15
    5eb8:	00 
    5eb9:	31 c0                	xor    %eax,%eax
    5ebb:	eb 40                	jmp    5efd <e1+0x1dd>
    5ebd:	0f 1f 00             	nopl   (%rax)
    5ec0:	0f b7 0c 0e          	movzwl (%rsi,%rcx,1),%ecx
    5ec4:	83 f8 01             	cmp    $0x1,%eax
    5ec7:	48 0f bf c1          	movswq %cx,%rax
    5ecb:	48 0f 45 c1          	cmovne %rcx,%rax
    5ecf:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
    5ed6:	00 
    5ed7:	4c 89 f7             	mov    %r14,%rdi
    5eda:	be 02 00 00 00       	mov    $0x2,%esi
    5edf:	4c 89 fa             	mov    %r15,%rdx
    5ee2:	b9 01 00 00 00       	mov    $0x1,%ecx
    5ee7:	e8 24 11 00 00       	call   7010 <fwp_apply_borrowed_prefix>
    5eec:	49 ff c4             	inc    %r12
    5eef:	48 8b 0b             	mov    (%rbx),%rcx
    5ef2:	48 89 ca             	mov    %rcx,%rdx
    5ef5:	4c 21 ea             	and    %r13,%rdx
    5ef8:	49 39 d4             	cmp    %rdx,%r12
    5efb:	73 71                	jae    5f6e <e1+0x24e>
    5efd:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
    5f04:	00 
    5f05:	8b 05 a5 5d 01 00    	mov    0x15da5(%rip),%eax        # 1bcb0 <d1>
    5f0b:	ba 08 00 00 00       	mov    $0x8,%edx
    5f10:	48 83 f8 0a          	cmp    $0xa,%rax
    5f14:	77 0b                	ja     5f21 <e1+0x201>
    5f16:	48 8d 15 d3 f9 00 00 	lea    0xf9d3(%rip),%rdx        # 158f0 <exec_in_fp0+0x80>
    5f1d:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
    5f21:	48 89 ee             	mov    %rbp,%rsi
    5f24:	48 85 c9             	test   %rcx,%rcx
    5f27:	79 04                	jns    5f2d <e1+0x20d>
    5f29:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    5f2d:	48 89 d1             	mov    %rdx,%rcx
    5f30:	49 0f af cc          	imul   %r12,%rcx
    5f34:	48 83 fa 01          	cmp    $0x1,%rdx
    5f38:	74 16                	je     5f50 <e1+0x230>
    5f3a:	48 83 fa 02          	cmp    $0x2,%rdx
    5f3e:	74 80                	je     5ec0 <e1+0x1a0>
    5f40:	48 83 fa 08          	cmp    $0x8,%rdx
    5f44:	75 1a                	jne    5f60 <e1+0x240>
    5f46:	48 8b 04 0e          	mov    (%rsi,%rcx,1),%rax
    5f4a:	eb 83                	jmp    5ecf <e1+0x1af>
    5f4c:	0f 1f 40 00          	nopl   0x0(%rax)
    5f50:	0f b6 0c 0e          	movzbl (%rsi,%rcx,1),%ecx
    5f54:	48 85 c0             	test   %rax,%rax
    5f57:	48 0f be c1          	movsbq %cl,%rax
    5f5b:	e9 6b ff ff ff       	jmp    5ecb <e1+0x1ab>
    5f60:	8b 0c 0e             	mov    (%rsi,%rcx,1),%ecx
    5f63:	83 f8 02             	cmp    $0x2,%eax
    5f66:	48 63 c1             	movslq %ecx,%rax
    5f69:	e9 5d ff ff ff       	jmp    5ecb <e1+0x1ab>
    5f6e:	41 89 c6             	mov    %eax,%r14d
    5f71:	48 89 e2             	mov    %rsp,%rdx
    5f74:	eb 03                	jmp    5f79 <e1+0x259>
    5f76:	45 31 f6             	xor    %r14d,%r14d
    5f79:	48 8d 05 28 5d 01 00 	lea    0x15d28(%rip),%rax        # 1bca8 <fc13>
    5f80:	48 39 15 41 5f 01 00 	cmp    %rdx,0x15f41(%rip)        # 1bec8 <fwp_cleanups>
    5f87:	75 37                	jne    5fc0 <e1+0x2a0>
    5f89:	48 8b 04 24          	mov    (%rsp),%rax
    5f8d:	48 89 05 34 5f 01 00 	mov    %rax,0x15f34(%rip)        # 1bec8 <fwp_cleanups>
    5f94:	48 8d 05 0d 5d 01 00 	lea    0x15d0d(%rip),%rax        # 1bca8 <fc13>
    5f9b:	48 89 df             	mov    %rbx,%rdi
    5f9e:	e8 fd 0c 00 00       	call   6ca0 <fwp_drop1>
    5fa3:	4c 89 f7             	mov    %r14,%rdi
    5fa6:	e8 d5 09 00 00       	call   6980 <fwp_rc_share>
    5fab:	4c 89 f0             	mov    %r14,%rax
    5fae:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    5fb5:	5b                   	pop    %rbx
    5fb6:	41 5c                	pop    %r12
    5fb8:	41 5d                	pop    %r13
    5fba:	41 5e                	pop    %r14
    5fbc:	41 5f                	pop    %r15
    5fbe:	5d                   	pop    %rbp
    5fbf:	c3                   	ret
    5fc0:	e8 ab d0 ff ff       	call   3070 <abort@plt>
    5fc5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    5fcc:	00 00 00 00 

0000000000005fd0 <e2>:
    5fd0:	41 57                	push   %r15
    5fd2:	41 56                	push   %r14
    5fd4:	53                   	push   %rbx
    5fd5:	48 83 ec 60          	sub    $0x60,%rsp
    5fd9:	48 89 fb             	mov    %rdi,%rbx
    5fdc:	48 8b 3f             	mov    (%rdi),%rdi
    5fdf:	e8 9c 09 00 00       	call   6980 <fwp_rc_share>
    5fe4:	48 8b 1b             	mov    (%rbx),%rbx
    5fe7:	0f 10 05 72 f1 00 00 	movups 0xf172(%rip),%xmm0        # 15160 <_IO_stdin_used+0x160>
    5fee:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    5ff3:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
    5ff8:	48 ff 05 c1 5e 01 00 	incq   0x15ec1(%rip)        # 1bec0 <measured_scopes>
    5fff:	48 8b 05 c2 5e 01 00 	mov    0x15ec2(%rip),%rax        # 1bec8 <fwp_cleanups>
    6006:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    600b:	48 8d 05 ee 4e 00 00 	lea    0x4eee(%rip),%rax        # af00 <fwp_owner_release6>
    6012:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    6017:	48 8d 44 24 10       	lea    0x10(%rsp),%rax
    601c:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    6021:	4c 8d 7c 24 18       	lea    0x18(%rsp),%r15
    6026:	4c 89 3d 9b 5e 01 00 	mov    %r15,0x15e9b(%rip)        # 1bec8 <fwp_cleanups>
    602d:	48 8d 0d e4 5c 01 00 	lea    0x15ce4(%rip),%rcx        # 1bd18 <d0>
    6034:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    6039:	48 89 de             	mov    %rbx,%rsi
    603c:	48 89 ca             	mov    %rcx,%rdx
    603f:	e8 5c 0d 00 00       	call   6da0 <fwp_p_array_map_typed>
    6044:	4c 39 3d 7d 5e 01 00 	cmp    %r15,0x15e7d(%rip)        # 1bec8 <fwp_cleanups>
    604b:	0f 85 87 00 00 00    	jne    60d8 <e2+0x108>
    6051:	49 89 c6             	mov    %rax,%r14
    6054:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    6059:	48 89 05 68 5e 01 00 	mov    %rax,0x15e68(%rip)        # 1bec8 <fwp_cleanups>
    6060:	48 8d 44 24 30       	lea    0x30(%rsp),%rax
    6065:	48 89 df             	mov    %rbx,%rdi
    6068:	e8 a3 4e 00 00       	call   af10 <fwp_drop2>
    606d:	4c 89 74 24 08       	mov    %r14,0x8(%rsp)
    6072:	48 ff 05 47 5e 01 00 	incq   0x15e47(%rip)        # 1bec0 <measured_scopes>
    6079:	48 8b 05 48 5e 01 00 	mov    0x15e48(%rip),%rax        # 1bec8 <fwp_cleanups>
    6080:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
    6085:	48 8d 0d 64 4f 00 00 	lea    0x4f64(%rip),%rcx        # aff0 <fwp_owner_release7>
    608c:	48 89 4c 24 50       	mov    %rcx,0x50(%rsp)
    6091:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    6096:	48 89 4c 24 58       	mov    %rcx,0x58(%rsp)
    609b:	48 8d 4c 24 48       	lea    0x48(%rsp),%rcx
    60a0:	48 89 0d 21 5e 01 00 	mov    %rcx,0x15e21(%rip)        # 1bec8 <fwp_cleanups>
    60a7:	48 bb ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rbx
    60ae:	ff ff 7f 
    60b1:	49 23 1e             	and    (%r14),%rbx
    60b4:	48 89 05 0d 5e 01 00 	mov    %rax,0x15e0d(%rip)        # 1bec8 <fwp_cleanups>
    60bb:	4c 89 f7             	mov    %r14,%rdi
    60be:	e8 4d 4e 00 00       	call   af10 <fwp_drop2>
    60c3:	48 89 df             	mov    %rbx,%rdi
    60c6:	e8 b5 08 00 00       	call   6980 <fwp_rc_share>
    60cb:	48 89 d8             	mov    %rbx,%rax
    60ce:	48 83 c4 60          	add    $0x60,%rsp
    60d2:	5b                   	pop    %rbx
    60d3:	41 5e                	pop    %r14
    60d5:	41 5f                	pop    %r15
    60d7:	c3                   	ret
    60d8:	e8 93 cf ff ff       	call   3070 <abort@plt>
    60dd:	0f 1f 00             	nopl   (%rax)

00000000000060e0 <e3>:
    60e0:	55                   	push   %rbp
    60e1:	41 57                	push   %r15
    60e3:	41 56                	push   %r14
    60e5:	41 55                	push   %r13
    60e7:	41 54                	push   %r12
    60e9:	53                   	push   %rbx
    60ea:	48 83 ec 68          	sub    $0x68,%rsp
    60ee:	48 89 fb             	mov    %rdi,%rbx
    60f1:	48 8b 3f             	mov    (%rdi),%rdi
    60f4:	e8 87 08 00 00       	call   6980 <fwp_rc_share>
    60f9:	4c 8b 33             	mov    (%rbx),%r14
    60fc:	0f 10 05 5d f0 00 00 	movups 0xf05d(%rip),%xmm0        # 15160 <_IO_stdin_used+0x160>
    6103:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    6108:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    610d:	48 ff 05 ac 5d 01 00 	incq   0x15dac(%rip)        # 1bec0 <measured_scopes>
    6114:	48 8b 05 ad 5d 01 00 	mov    0x15dad(%rip),%rax        # 1bec8 <fwp_cleanups>
    611b:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    6120:	48 8d 05 d9 4e 00 00 	lea    0x4ed9(%rip),%rax        # b000 <fwp_owner_release8>
    6127:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    612c:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    6131:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    6136:	4c 8d 7c 24 28       	lea    0x28(%rsp),%r15
    613b:	4c 89 3d 86 5d 01 00 	mov    %r15,0x15d86(%rip)        # 1bec8 <fwp_cleanups>
    6142:	48 8d 0d cf 5b 01 00 	lea    0x15bcf(%rip),%rcx        # 1bd18 <d0>
    6149:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
    614e:	4c 89 f6             	mov    %r14,%rsi
    6151:	48 89 ca             	mov    %rcx,%rdx
    6154:	e8 47 0c 00 00       	call   6da0 <fwp_p_array_map_typed>
    6159:	4c 39 3d 68 5d 01 00 	cmp    %r15,0x15d68(%rip)        # 1bec8 <fwp_cleanups>
    6160:	0f 85 98 01 00 00    	jne    62fe <e3+0x21e>
    6166:	48 89 c3             	mov    %rax,%rbx
    6169:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    616e:	48 89 05 53 5d 01 00 	mov    %rax,0x15d53(%rip)        # 1bec8 <fwp_cleanups>
    6175:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
    617a:	4c 89 f7             	mov    %r14,%rdi
    617d:	e8 8e 4d 00 00       	call   af10 <fwp_drop2>
    6182:	48 ff 05 37 5d 01 00 	incq   0x15d37(%rip)        # 1bec0 <measured_scopes>
    6189:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    618e:	48 8b 05 33 5d 01 00 	mov    0x15d33(%rip),%rax        # 1bec8 <fwp_cleanups>
    6195:	48 89 04 24          	mov    %rax,(%rsp)
    6199:	48 8d 05 70 4e 00 00 	lea    0x4e70(%rip),%rax        # b010 <fwp_owner_release9>
    61a0:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    61a5:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
    61aa:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    61af:	48 89 e2             	mov    %rsp,%rdx
    61b2:	48 89 15 0f 5d 01 00 	mov    %rdx,0x15d0f(%rip)        # 1bec8 <fwp_cleanups>
    61b9:	48 8b 0b             	mov    (%rbx),%rcx
    61bc:	48 8d 04 4d 00 00 00 	lea    0x0(,%rcx,2),%rax
    61c3:	00 
    61c4:	48 85 c0             	test   %rax,%rax
    61c7:	0f 84 ea 00 00 00    	je     62b7 <e3+0x1d7>
    61cd:	49 bd ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r13
    61d4:	ff ff 7f 
    61d7:	48 89 dd             	mov    %rbx,%rbp
    61da:	48 83 c5 08          	add    $0x8,%rbp
    61de:	45 31 e4             	xor    %r12d,%r12d
    61e1:	4c 8d 35 90 5b 01 00 	lea    0x15b90(%rip),%r14        # 1bd78 <fc5>
    61e8:	4c 8d 7c 24 50       	lea    0x50(%rsp),%r15
    61ed:	31 c0                	xor    %eax,%eax
    61ef:	eb 49                	jmp    623a <e3+0x15a>
    61f1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    61f8:	0f 1f 84 00 00 00 00 
    61ff:	00 
    6200:	0f b7 0c 0e          	movzwl (%rsi,%rcx,1),%ecx
    6204:	83 f8 01             	cmp    $0x1,%eax
    6207:	48 0f bf c1          	movswq %cx,%rax
    620b:	48 0f 45 c1          	cmovne %rcx,%rax
    620f:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
    6214:	4c 89 f7             	mov    %r14,%rdi
    6217:	be 02 00 00 00       	mov    $0x2,%esi
    621c:	4c 89 fa             	mov    %r15,%rdx
    621f:	b9 01 00 00 00       	mov    $0x1,%ecx
    6224:	e8 e7 0d 00 00       	call   7010 <fwp_apply_borrowed_prefix>
    6229:	49 ff c4             	inc    %r12
    622c:	48 8b 0b             	mov    (%rbx),%rcx
    622f:	48 89 ca             	mov    %rcx,%rdx
    6232:	4c 21 ea             	and    %r13,%rdx
    6235:	49 39 d4             	cmp    %rdx,%r12
    6238:	73 74                	jae    62ae <e3+0x1ce>
    623a:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    623f:	8b 05 d3 5a 01 00    	mov    0x15ad3(%rip),%eax        # 1bd18 <d0>
    6245:	ba 08 00 00 00       	mov    $0x8,%edx
    624a:	48 83 f8 0a          	cmp    $0xa,%rax
    624e:	77 0b                	ja     625b <e3+0x17b>
    6250:	48 8d 15 99 f6 00 00 	lea    0xf699(%rip),%rdx        # 158f0 <exec_in_fp0+0x80>
    6257:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
    625b:	48 89 ee             	mov    %rbp,%rsi
    625e:	48 85 c9             	test   %rcx,%rcx
    6261:	79 04                	jns    6267 <e3+0x187>
    6263:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    6267:	48 89 d1             	mov    %rdx,%rcx
    626a:	49 0f af cc          	imul   %r12,%rcx
    626e:	48 83 fa 01          	cmp    $0x1,%rdx
    6272:	74 1c                	je     6290 <e3+0x1b0>
    6274:	48 83 fa 02          	cmp    $0x2,%rdx
    6278:	74 86                	je     6200 <e3+0x120>
    627a:	48 83 fa 08          	cmp    $0x8,%rdx
    627e:	75 20                	jne    62a0 <e3+0x1c0>
    6280:	48 8b 04 0e          	mov    (%rsi,%rcx,1),%rax
    6284:	eb 89                	jmp    620f <e3+0x12f>
    6286:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    628d:	00 00 00 
    6290:	0f b6 0c 0e          	movzbl (%rsi,%rcx,1),%ecx
    6294:	48 85 c0             	test   %rax,%rax
    6297:	48 0f be c1          	movsbq %cl,%rax
    629b:	e9 6b ff ff ff       	jmp    620b <e3+0x12b>
    62a0:	8b 0c 0e             	mov    (%rsi,%rcx,1),%ecx
    62a3:	83 f8 02             	cmp    $0x2,%eax
    62a6:	48 63 c1             	movslq %ecx,%rax
    62a9:	e9 5d ff ff ff       	jmp    620b <e3+0x12b>
    62ae:	4c 0f be f0          	movsbq %al,%r14
    62b2:	48 89 e2             	mov    %rsp,%rdx
    62b5:	eb 03                	jmp    62ba <e3+0x1da>
    62b7:	45 31 f6             	xor    %r14d,%r14d
    62ba:	48 8d 05 b7 5a 01 00 	lea    0x15ab7(%rip),%rax        # 1bd78 <fc5>
    62c1:	48 39 15 00 5c 01 00 	cmp    %rdx,0x15c00(%rip)        # 1bec8 <fwp_cleanups>
    62c8:	75 34                	jne    62fe <e3+0x21e>
    62ca:	48 8b 04 24          	mov    (%rsp),%rax
    62ce:	48 89 05 f3 5b 01 00 	mov    %rax,0x15bf3(%rip)        # 1bec8 <fwp_cleanups>
    62d5:	48 8d 05 9c 5a 01 00 	lea    0x15a9c(%rip),%rax        # 1bd78 <fc5>
    62dc:	48 89 df             	mov    %rbx,%rdi
    62df:	e8 2c 4c 00 00       	call   af10 <fwp_drop2>
    62e4:	4c 89 f7             	mov    %r14,%rdi
    62e7:	e8 94 06 00 00       	call   6980 <fwp_rc_share>
    62ec:	4c 89 f0             	mov    %r14,%rax
    62ef:	48 83 c4 68          	add    $0x68,%rsp
    62f3:	5b                   	pop    %rbx
    62f4:	41 5c                	pop    %r12
    62f6:	41 5d                	pop    %r13
    62f8:	41 5e                	pop    %r14
    62fa:	41 5f                	pop    %r15
    62fc:	5d                   	pop    %rbp
    62fd:	c3                   	ret
    62fe:	e8 6d cd ff ff       	call   3070 <abort@plt>
    6303:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    630a:	84 00 00 00 00 00 

0000000000006310 <e4>:
    6310:	53                   	push   %rbx
    6311:	48 89 fb             	mov    %rdi,%rbx
    6314:	48 8b 3f             	mov    (%rdi),%rdi
    6317:	e8 64 06 00 00       	call   6980 <fwp_rc_share>
    631c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    6320:	e8 5b 06 00 00       	call   6980 <fwp_rc_share>
    6325:	48 8b 3b             	mov    (%rbx),%rdi
    6328:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    632c:	48 8d 0d e5 59 01 00 	lea    0x159e5(%rip),%rcx        # 1bd18 <d0>
    6333:	48 89 ca             	mov    %rcx,%rdx
    6336:	e8 65 0a 00 00       	call   6da0 <fwp_p_array_map_typed>
    633b:	48 89 c3             	mov    %rax,%rbx
    633e:	48 89 c7             	mov    %rax,%rdi
    6341:	e8 3a 06 00 00       	call   6980 <fwp_rc_share>
    6346:	48 89 d8             	mov    %rbx,%rax
    6349:	5b                   	pop    %rbx
    634a:	c3                   	ret
    634b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006350 <e5>:
    6350:	53                   	push   %rbx
    6351:	48 83 ec 60          	sub    $0x60,%rsp
    6355:	48 0f be 07          	movsbq (%rdi),%rax
    6359:	48 0f be 5f 08       	movsbq 0x8(%rdi),%rbx
    635e:	48 01 c3             	add    %rax,%rbx
    6361:	48 0f be c3          	movsbq %bl,%rax
    6365:	48 39 d8             	cmp    %rbx,%rax
    6368:	75 11                	jne    637b <e5+0x2b>
    636a:	48 89 df             	mov    %rbx,%rdi
    636d:	e8 0e 06 00 00       	call   6980 <fwp_rc_share>
    6372:	48 89 d8             	mov    %rbx,%rax
    6375:	48 83 c4 60          	add    $0x60,%rsp
    6379:	5b                   	pop    %rbx
    637a:	c3                   	ret
    637b:	48 8d 15 f6 f8 00 00 	lea    0xf8f6(%rip),%rdx        # 15c78 <exec_in_fp0+0x408>
    6382:	48 8d 0d ec f8 00 00 	lea    0xf8ec(%rip),%rcx        # 15c75 <exec_in_fp0+0x405>
    6389:	48 89 e3             	mov    %rsp,%rbx
    638c:	be 60 00 00 00       	mov    $0x60,%esi
    6391:	48 89 df             	mov    %rbx,%rdi
    6394:	31 c0                	xor    %eax,%eax
    6396:	e8 35 ce ff ff       	call   31d0 <snprintf@plt>
    639b:	e8 c0 08 00 00       	call   6c60 <fwp_flush>
    63a0:	48 8b 05 31 3c 01 00 	mov    0x13c31(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    63a7:	48 8b 38             	mov    (%rax),%rdi
    63aa:	48 8d 35 fd f6 00 00 	lea    0xf6fd(%rip),%rsi        # 15aae <exec_in_fp0+0x23e>
    63b1:	48 89 da             	mov    %rbx,%rdx
    63b4:	31 c0                	xor    %eax,%eax
    63b6:	e8 35 cf ff ff       	call   32f0 <fprintf@plt>
    63bb:	bf 65 00 00 00       	mov    $0x65,%edi
    63c0:	e8 9b d0 ff ff       	call   3460 <exit@plt>
    63c5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    63cc:	00 00 00 00 

00000000000063d0 <e6>:
    63d0:	55                   	push   %rbp
    63d1:	41 57                	push   %r15
    63d3:	41 56                	push   %r14
    63d5:	41 55                	push   %r13
    63d7:	41 54                	push   %r12
    63d9:	53                   	push   %rbx
    63da:	48 83 ec 18          	sub    $0x18,%rsp
    63de:	49 89 fe             	mov    %rdi,%r14
    63e1:	48 8b 3f             	mov    (%rdi),%rdi
    63e4:	e8 97 05 00 00       	call   6980 <fwp_rc_share>
    63e9:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    63ed:	e8 8e 05 00 00       	call   6980 <fwp_rc_share>
    63f2:	49 8b 1e             	mov    (%r14),%rbx
    63f5:	49 8b 46 08          	mov    0x8(%r14),%rax
    63f9:	4d 8b 7e 10          	mov    0x10(%r14),%r15
    63fd:	49 8b 0f             	mov    (%r15),%rcx
    6400:	48 8d 14 4d 00 00 00 	lea    0x0(,%rcx,2),%rdx
    6407:	00 
    6408:	48 85 d2             	test   %rdx,%rdx
    640b:	0f 84 cd 00 00 00    	je     64de <e6+0x10e>
    6411:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
    6418:	ff ff 7f 
    641b:	4d 8d 6f 08          	lea    0x8(%r15),%r13
    641f:	31 ed                	xor    %ebp,%ebp
    6421:	49 89 e6             	mov    %rsp,%r14
    6424:	eb 44                	jmp    646a <e6+0x9a>
    6426:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    642d:	00 00 00 
    6430:	0f b7 0c 0e          	movzwl (%rsi,%rcx,1),%ecx
    6434:	83 f8 01             	cmp    $0x1,%eax
    6437:	48 0f bf c1          	movswq %cx,%rax
    643b:	48 0f 45 c1          	cmovne %rcx,%rax
    643f:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    6444:	48 89 df             	mov    %rbx,%rdi
    6447:	be 02 00 00 00       	mov    $0x2,%esi
    644c:	4c 89 f2             	mov    %r14,%rdx
    644f:	b9 01 00 00 00       	mov    $0x1,%ecx
    6454:	e8 b7 0b 00 00       	call   7010 <fwp_apply_borrowed_prefix>
    6459:	48 ff c5             	inc    %rbp
    645c:	49 8b 0f             	mov    (%r15),%rcx
    645f:	48 89 ca             	mov    %rcx,%rdx
    6462:	4c 21 e2             	and    %r12,%rdx
    6465:	48 39 d5             	cmp    %rdx,%rbp
    6468:	73 74                	jae    64de <e6+0x10e>
    646a:	48 89 04 24          	mov    %rax,(%rsp)
    646e:	8b 05 a4 58 01 00    	mov    0x158a4(%rip),%eax        # 1bd18 <d0>
    6474:	ba 08 00 00 00       	mov    $0x8,%edx
    6479:	48 83 f8 0a          	cmp    $0xa,%rax
    647d:	77 0b                	ja     648a <e6+0xba>
    647f:	48 8d 15 6a f4 00 00 	lea    0xf46a(%rip),%rdx        # 158f0 <exec_in_fp0+0x80>
    6486:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
    648a:	4c 89 ee             	mov    %r13,%rsi
    648d:	48 85 c9             	test   %rcx,%rcx
    6490:	79 04                	jns    6496 <e6+0xc6>
    6492:	49 8b 77 10          	mov    0x10(%r15),%rsi
    6496:	48 89 d1             	mov    %rdx,%rcx
    6499:	48 0f af cd          	imul   %rbp,%rcx
    649d:	48 83 fa 01          	cmp    $0x1,%rdx
    64a1:	74 1d                	je     64c0 <e6+0xf0>
    64a3:	48 83 fa 02          	cmp    $0x2,%rdx
    64a7:	74 87                	je     6430 <e6+0x60>
    64a9:	48 83 fa 08          	cmp    $0x8,%rdx
    64ad:	75 21                	jne    64d0 <e6+0x100>
    64af:	48 8b 04 0e          	mov    (%rsi,%rcx,1),%rax
    64b3:	eb 8a                	jmp    643f <e6+0x6f>
    64b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    64bc:	00 00 00 00 
    64c0:	0f b6 0c 0e          	movzbl (%rsi,%rcx,1),%ecx
    64c4:	48 85 c0             	test   %rax,%rax
    64c7:	48 0f be c1          	movsbq %cl,%rax
    64cb:	e9 6b ff ff ff       	jmp    643b <e6+0x6b>
    64d0:	8b 0c 0e             	mov    (%rsi,%rcx,1),%ecx
    64d3:	83 f8 02             	cmp    $0x2,%eax
    64d6:	48 63 c1             	movslq %ecx,%rax
    64d9:	e9 5d ff ff ff       	jmp    643b <e6+0x6b>
    64de:	48 89 c7             	mov    %rax,%rdi
    64e1:	48 89 c3             	mov    %rax,%rbx
    64e4:	e8 97 04 00 00       	call   6980 <fwp_rc_share>
    64e9:	48 89 d8             	mov    %rbx,%rax
    64ec:	48 83 c4 18          	add    $0x18,%rsp
    64f0:	5b                   	pop    %rbx
    64f1:	41 5c                	pop    %r12
    64f3:	41 5d                	pop    %r13
    64f5:	41 5e                	pop    %r14
    64f7:	41 5f                	pop    %r15
    64f9:	5d                   	pop    %rbp
    64fa:	c3                   	ret
    64fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006500 <e8>:
    6500:	53                   	push   %rbx
    6501:	48 83 ec 60          	sub    $0x60,%rsp
    6505:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    6509:	48 03 1f             	add    (%rdi),%rbx
    650c:	48 0f be c3          	movsbq %bl,%rax
    6510:	48 39 d8             	cmp    %rbx,%rax
    6513:	75 11                	jne    6526 <e8+0x26>
    6515:	48 89 df             	mov    %rbx,%rdi
    6518:	e8 63 04 00 00       	call   6980 <fwp_rc_share>
    651d:	48 89 d8             	mov    %rbx,%rax
    6520:	48 83 c4 60          	add    $0x60,%rsp
    6524:	5b                   	pop    %rbx
    6525:	c3                   	ret
    6526:	48 8d 15 4b f7 00 00 	lea    0xf74b(%rip),%rdx        # 15c78 <exec_in_fp0+0x408>
    652d:	48 8d 0d 41 f7 00 00 	lea    0xf741(%rip),%rcx        # 15c75 <exec_in_fp0+0x405>
    6534:	48 89 e3             	mov    %rsp,%rbx
    6537:	be 60 00 00 00       	mov    $0x60,%esi
    653c:	48 89 df             	mov    %rbx,%rdi
    653f:	31 c0                	xor    %eax,%eax
    6541:	e8 8a cc ff ff       	call   31d0 <snprintf@plt>
    6546:	e8 15 07 00 00       	call   6c60 <fwp_flush>
    654b:	48 8b 05 86 3a 01 00 	mov    0x13a86(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    6552:	48 8b 38             	mov    (%rax),%rdi
    6555:	48 8d 35 52 f5 00 00 	lea    0xf552(%rip),%rsi        # 15aae <exec_in_fp0+0x23e>
    655c:	48 89 da             	mov    %rbx,%rdx
    655f:	31 c0                	xor    %eax,%eax
    6561:	e8 8a cd ff ff       	call   32f0 <fprintf@plt>
    6566:	bf 65 00 00 00       	mov    $0x65,%edi
    656b:	e8 f0 ce ff ff       	call   3460 <exit@plt>

0000000000006570 <e9>:
    6570:	53                   	push   %rbx
    6571:	48 89 fb             	mov    %rdi,%rbx
    6574:	48 8b 3f             	mov    (%rdi),%rdi
    6577:	e8 04 04 00 00       	call   6980 <fwp_rc_share>
    657c:	48 8b 03             	mov    (%rbx),%rax
    657f:	48 bb ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rbx
    6586:	ff ff 7f 
    6589:	48 23 18             	and    (%rax),%rbx
    658c:	48 89 df             	mov    %rbx,%rdi
    658f:	e8 ec 03 00 00       	call   6980 <fwp_rc_share>
    6594:	48 89 d8             	mov    %rbx,%rax
    6597:	5b                   	pop    %rbx
    6598:	c3                   	ret
    6599:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000065a0 <e11>:
    65a0:	53                   	push   %rbx
    65a1:	48 89 fb             	mov    %rdi,%rbx
    65a4:	48 8b 3f             	mov    (%rdi),%rdi
    65a7:	e8 d4 03 00 00       	call   6980 <fwp_rc_share>
    65ac:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    65b0:	e8 cb 03 00 00       	call   6980 <fwp_rc_share>
    65b5:	48 8b 3b             	mov    (%rbx),%rdi
    65b8:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    65bc:	48 8d 0d ed 56 01 00 	lea    0x156ed(%rip),%rcx        # 1bcb0 <d1>
    65c3:	48 89 ca             	mov    %rcx,%rdx
    65c6:	e8 d5 07 00 00       	call   6da0 <fwp_p_array_map_typed>
    65cb:	48 89 c3             	mov    %rax,%rbx
    65ce:	48 89 c7             	mov    %rax,%rdi
    65d1:	e8 aa 03 00 00       	call   6980 <fwp_rc_share>
    65d6:	48 89 d8             	mov    %rbx,%rax
    65d9:	5b                   	pop    %rbx
    65da:	c3                   	ret
    65db:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000065e0 <e12>:
    65e0:	53                   	push   %rbx
    65e1:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    65e5:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    65ea:	0f 59 c8             	mulps  %xmm0,%xmm1
    65ed:	66 0f 7e cb          	movd   %xmm1,%ebx
    65f1:	48 89 df             	mov    %rbx,%rdi
    65f4:	e8 87 03 00 00       	call   6980 <fwp_rc_share>
    65f9:	48 89 d8             	mov    %rbx,%rax
    65fc:	5b                   	pop    %rbx
    65fd:	c3                   	ret
    65fe:	66 90                	xchg   %ax,%ax

0000000000006600 <e13>:
    6600:	53                   	push   %rbx
    6601:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    6605:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    660a:	0f 58 c8             	addps  %xmm0,%xmm1
    660d:	66 0f 7e cb          	movd   %xmm1,%ebx
    6611:	48 89 df             	mov    %rbx,%rdi
    6614:	e8 67 03 00 00       	call   6980 <fwp_rc_share>
    6619:	48 89 d8             	mov    %rbx,%rax
    661c:	5b                   	pop    %rbx
    661d:	c3                   	ret
    661e:	66 90                	xchg   %ax,%ax

0000000000006620 <e15>:
    6620:	55                   	push   %rbp
    6621:	41 57                	push   %r15
    6623:	41 56                	push   %r14
    6625:	41 55                	push   %r13
    6627:	41 54                	push   %r12
    6629:	53                   	push   %rbx
    662a:	48 83 ec 18          	sub    $0x18,%rsp
    662e:	49 89 fe             	mov    %rdi,%r14
    6631:	48 8b 3f             	mov    (%rdi),%rdi
    6634:	e8 47 03 00 00       	call   6980 <fwp_rc_share>
    6639:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    663d:	e8 3e 03 00 00       	call   6980 <fwp_rc_share>
    6642:	49 8b 1e             	mov    (%r14),%rbx
    6645:	49 8b 46 08          	mov    0x8(%r14),%rax
    6649:	4d 8b 7e 10          	mov    0x10(%r14),%r15
    664d:	49 8b 0f             	mov    (%r15),%rcx
    6650:	48 8d 14 4d 00 00 00 	lea    0x0(,%rcx,2),%rdx
    6657:	00 
    6658:	48 85 d2             	test   %rdx,%rdx
    665b:	0f 84 cd 00 00 00    	je     672e <e15+0x10e>
    6661:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
    6668:	ff ff 7f 
    666b:	4d 8d 6f 08          	lea    0x8(%r15),%r13
    666f:	31 ed                	xor    %ebp,%ebp
    6671:	49 89 e6             	mov    %rsp,%r14
    6674:	eb 44                	jmp    66ba <e15+0x9a>
    6676:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    667d:	00 00 00 
    6680:	0f b7 0c 0e          	movzwl (%rsi,%rcx,1),%ecx
    6684:	83 f8 01             	cmp    $0x1,%eax
    6687:	48 0f bf c1          	movswq %cx,%rax
    668b:	48 0f 45 c1          	cmovne %rcx,%rax
    668f:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    6694:	48 89 df             	mov    %rbx,%rdi
    6697:	be 02 00 00 00       	mov    $0x2,%esi
    669c:	4c 89 f2             	mov    %r14,%rdx
    669f:	b9 01 00 00 00       	mov    $0x1,%ecx
    66a4:	e8 67 09 00 00       	call   7010 <fwp_apply_borrowed_prefix>
    66a9:	48 ff c5             	inc    %rbp
    66ac:	49 8b 0f             	mov    (%r15),%rcx
    66af:	48 89 ca             	mov    %rcx,%rdx
    66b2:	4c 21 e2             	and    %r12,%rdx
    66b5:	48 39 d5             	cmp    %rdx,%rbp
    66b8:	73 74                	jae    672e <e15+0x10e>
    66ba:	48 89 04 24          	mov    %rax,(%rsp)
    66be:	8b 05 ec 55 01 00    	mov    0x155ec(%rip),%eax        # 1bcb0 <d1>
    66c4:	ba 08 00 00 00       	mov    $0x8,%edx
    66c9:	48 83 f8 0a          	cmp    $0xa,%rax
    66cd:	77 0b                	ja     66da <e15+0xba>
    66cf:	48 8d 15 1a f2 00 00 	lea    0xf21a(%rip),%rdx        # 158f0 <exec_in_fp0+0x80>
    66d6:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
    66da:	4c 89 ee             	mov    %r13,%rsi
    66dd:	48 85 c9             	test   %rcx,%rcx
    66e0:	79 04                	jns    66e6 <e15+0xc6>
    66e2:	49 8b 77 10          	mov    0x10(%r15),%rsi
    66e6:	48 89 d1             	mov    %rdx,%rcx
    66e9:	48 0f af cd          	imul   %rbp,%rcx
    66ed:	48 83 fa 01          	cmp    $0x1,%rdx
    66f1:	74 1d                	je     6710 <e15+0xf0>
    66f3:	48 83 fa 02          	cmp    $0x2,%rdx
    66f7:	74 87                	je     6680 <e15+0x60>
    66f9:	48 83 fa 08          	cmp    $0x8,%rdx
    66fd:	75 21                	jne    6720 <e15+0x100>
    66ff:	48 8b 04 0e          	mov    (%rsi,%rcx,1),%rax
    6703:	eb 8a                	jmp    668f <e15+0x6f>
    6705:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    670c:	00 00 00 00 
    6710:	0f b6 0c 0e          	movzbl (%rsi,%rcx,1),%ecx
    6714:	48 85 c0             	test   %rax,%rax
    6717:	48 0f be c1          	movsbq %cl,%rax
    671b:	e9 6b ff ff ff       	jmp    668b <e15+0x6b>
    6720:	8b 0c 0e             	mov    (%rsi,%rcx,1),%ecx
    6723:	83 f8 02             	cmp    $0x2,%eax
    6726:	48 63 c1             	movslq %ecx,%rax
    6729:	e9 5d ff ff ff       	jmp    668b <e15+0x6b>
    672e:	48 89 c7             	mov    %rax,%rdi
    6731:	48 89 c3             	mov    %rax,%rbx
    6734:	e8 47 02 00 00       	call   6980 <fwp_rc_share>
    6739:	48 89 d8             	mov    %rbx,%rax
    673c:	48 83 c4 18          	add    $0x18,%rsp
    6740:	5b                   	pop    %rbx
    6741:	41 5c                	pop    %r12
    6743:	41 5d                	pop    %r13
    6745:	41 5e                	pop    %r14
    6747:	41 5f                	pop    %r15
    6749:	5d                   	pop    %rbp
    674a:	c3                   	ret
    674b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006750 <e17>:
    6750:	53                   	push   %rbx
    6751:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    6755:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    675a:	0f 58 c8             	addps  %xmm0,%xmm1
    675d:	66 0f 7e cb          	movd   %xmm1,%ebx
    6761:	48 89 df             	mov    %rbx,%rdi
    6764:	e8 17 02 00 00       	call   6980 <fwp_rc_share>
    6769:	48 89 d8             	mov    %rbx,%rax
    676c:	5b                   	pop    %rbx
    676d:	c3                   	ret
    676e:	66 90                	xchg   %ax,%ax

0000000000006770 <e18>:
    6770:	53                   	push   %rbx
    6771:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    6775:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    677a:	0f 59 c8             	mulps  %xmm0,%xmm1
    677d:	66 0f 7e cb          	movd   %xmm1,%ebx
    6781:	48 89 df             	mov    %rbx,%rdi
    6784:	e8 f7 01 00 00       	call   6980 <fwp_rc_share>
    6789:	48 89 d8             	mov    %rbx,%rax
    678c:	5b                   	pop    %rbx
    678d:	c3                   	ret
    678e:	66 90                	xchg   %ax,%ax

0000000000006790 <e19>:
    6790:	53                   	push   %rbx
    6791:	48 89 fb             	mov    %rdi,%rbx
    6794:	48 8b 3f             	mov    (%rdi),%rdi
    6797:	e8 e4 01 00 00       	call   6980 <fwp_rc_share>
    679c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    67a0:	e8 db 01 00 00       	call   6980 <fwp_rc_share>
    67a5:	48 8b 3b             	mov    (%rbx),%rdi
    67a8:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    67ac:	48 8d 0d cd 55 01 00 	lea    0x155cd(%rip),%rcx        # 1bd80 <d2>
    67b3:	48 89 ca             	mov    %rcx,%rdx
    67b6:	e8 e5 05 00 00       	call   6da0 <fwp_p_array_map_typed>
    67bb:	48 89 c3             	mov    %rax,%rbx
    67be:	48 89 c7             	mov    %rax,%rdi
    67c1:	e8 ba 01 00 00       	call   6980 <fwp_rc_share>
    67c6:	48 89 d8             	mov    %rbx,%rax
    67c9:	5b                   	pop    %rbx
    67ca:	c3                   	ret
    67cb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000067d0 <e20>:
    67d0:	53                   	push   %rbx
    67d1:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    67d5:	f2 0f 59 47 08       	mulsd  0x8(%rdi),%xmm0
    67da:	66 48 0f 7e c3       	movq   %xmm0,%rbx
    67df:	48 89 df             	mov    %rbx,%rdi
    67e2:	e8 99 01 00 00       	call   6980 <fwp_rc_share>
    67e7:	48 89 d8             	mov    %rbx,%rax
    67ea:	5b                   	pop    %rbx
    67eb:	c3                   	ret
    67ec:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000067f0 <e21>:
    67f0:	53                   	push   %rbx
    67f1:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    67f5:	f2 0f 58 47 08       	addsd  0x8(%rdi),%xmm0
    67fa:	66 48 0f 7e c3       	movq   %xmm0,%rbx
    67ff:	48 89 df             	mov    %rbx,%rdi
    6802:	e8 79 01 00 00       	call   6980 <fwp_rc_share>
    6807:	48 89 d8             	mov    %rbx,%rax
    680a:	5b                   	pop    %rbx
    680b:	c3                   	ret
    680c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000006810 <e23>:
    6810:	55                   	push   %rbp
    6811:	41 57                	push   %r15
    6813:	41 56                	push   %r14
    6815:	41 55                	push   %r13
    6817:	41 54                	push   %r12
    6819:	53                   	push   %rbx
    681a:	48 83 ec 18          	sub    $0x18,%rsp
    681e:	49 89 fe             	mov    %rdi,%r14
    6821:	48 8b 3f             	mov    (%rdi),%rdi
    6824:	e8 57 01 00 00       	call   6980 <fwp_rc_share>
    6829:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    682d:	e8 4e 01 00 00       	call   6980 <fwp_rc_share>
    6832:	49 8b 1e             	mov    (%r14),%rbx
    6835:	49 8b 46 08          	mov    0x8(%r14),%rax
    6839:	4d 8b 7e 10          	mov    0x10(%r14),%r15
    683d:	49 8b 0f             	mov    (%r15),%rcx
    6840:	48 8d 14 4d 00 00 00 	lea    0x0(,%rcx,2),%rdx
    6847:	00 
    6848:	48 85 d2             	test   %rdx,%rdx
    684b:	0f 84 cd 00 00 00    	je     691e <e23+0x10e>
    6851:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
    6858:	ff ff 7f 
    685b:	4d 8d 6f 08          	lea    0x8(%r15),%r13
    685f:	31 ed                	xor    %ebp,%ebp
    6861:	49 89 e6             	mov    %rsp,%r14
    6864:	eb 44                	jmp    68aa <e23+0x9a>
    6866:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    686d:	00 00 00 
    6870:	0f b7 0c 0e          	movzwl (%rsi,%rcx,1),%ecx
    6874:	83 f8 01             	cmp    $0x1,%eax
    6877:	48 0f bf c1          	movswq %cx,%rax
    687b:	48 0f 45 c1          	cmovne %rcx,%rax
    687f:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    6884:	48 89 df             	mov    %rbx,%rdi
    6887:	be 02 00 00 00       	mov    $0x2,%esi
    688c:	4c 89 f2             	mov    %r14,%rdx
    688f:	b9 01 00 00 00       	mov    $0x1,%ecx
    6894:	e8 77 07 00 00       	call   7010 <fwp_apply_borrowed_prefix>
    6899:	48 ff c5             	inc    %rbp
    689c:	49 8b 0f             	mov    (%r15),%rcx
    689f:	48 89 ca             	mov    %rcx,%rdx
    68a2:	4c 21 e2             	and    %r12,%rdx
    68a5:	48 39 d5             	cmp    %rdx,%rbp
    68a8:	73 74                	jae    691e <e23+0x10e>
    68aa:	48 89 04 24          	mov    %rax,(%rsp)
    68ae:	8b 05 cc 54 01 00    	mov    0x154cc(%rip),%eax        # 1bd80 <d2>
    68b4:	ba 08 00 00 00       	mov    $0x8,%edx
    68b9:	48 83 f8 0a          	cmp    $0xa,%rax
    68bd:	77 0b                	ja     68ca <e23+0xba>
    68bf:	48 8d 15 2a f0 00 00 	lea    0xf02a(%rip),%rdx        # 158f0 <exec_in_fp0+0x80>
    68c6:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
    68ca:	4c 89 ee             	mov    %r13,%rsi
    68cd:	48 85 c9             	test   %rcx,%rcx
    68d0:	79 04                	jns    68d6 <e23+0xc6>
    68d2:	49 8b 77 10          	mov    0x10(%r15),%rsi
    68d6:	48 89 d1             	mov    %rdx,%rcx
    68d9:	48 0f af cd          	imul   %rbp,%rcx
    68dd:	48 83 fa 01          	cmp    $0x1,%rdx
    68e1:	74 1d                	je     6900 <e23+0xf0>
    68e3:	48 83 fa 02          	cmp    $0x2,%rdx
    68e7:	74 87                	je     6870 <e23+0x60>
    68e9:	48 83 fa 08          	cmp    $0x8,%rdx
    68ed:	75 21                	jne    6910 <e23+0x100>
    68ef:	48 8b 04 0e          	mov    (%rsi,%rcx,1),%rax
    68f3:	eb 8a                	jmp    687f <e23+0x6f>
    68f5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    68fc:	00 00 00 00 
    6900:	0f b6 0c 0e          	movzbl (%rsi,%rcx,1),%ecx
    6904:	48 85 c0             	test   %rax,%rax
    6907:	48 0f be c1          	movsbq %cl,%rax
    690b:	e9 6b ff ff ff       	jmp    687b <e23+0x6b>
    6910:	8b 0c 0e             	mov    (%rsi,%rcx,1),%ecx
    6913:	83 f8 02             	cmp    $0x2,%eax
    6916:	48 63 c1             	movslq %ecx,%rax
    6919:	e9 5d ff ff ff       	jmp    687b <e23+0x6b>
    691e:	48 89 c7             	mov    %rax,%rdi
    6921:	48 89 c3             	mov    %rax,%rbx
    6924:	e8 57 00 00 00       	call   6980 <fwp_rc_share>
    6929:	48 89 d8             	mov    %rbx,%rax
    692c:	48 83 c4 18          	add    $0x18,%rsp
    6930:	5b                   	pop    %rbx
    6931:	41 5c                	pop    %r12
    6933:	41 5d                	pop    %r13
    6935:	41 5e                	pop    %r14
    6937:	41 5f                	pop    %r15
    6939:	5d                   	pop    %rbp
    693a:	c3                   	ret
    693b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006940 <e25>:
    6940:	53                   	push   %rbx
    6941:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    6945:	f2 0f 58 47 08       	addsd  0x8(%rdi),%xmm0
    694a:	66 48 0f 7e c3       	movq   %xmm0,%rbx
    694f:	48 89 df             	mov    %rbx,%rdi
    6952:	e8 29 00 00 00       	call   6980 <fwp_rc_share>
    6957:	48 89 d8             	mov    %rbx,%rax
    695a:	5b                   	pop    %rbx
    695b:	c3                   	ret
    695c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000006960 <e26>:
    6960:	53                   	push   %rbx
    6961:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    6965:	f2 0f 59 47 08       	mulsd  0x8(%rdi),%xmm0
    696a:	66 48 0f 7e c3       	movq   %xmm0,%rbx
    696f:	48 89 df             	mov    %rbx,%rdi
    6972:	e8 09 00 00 00       	call   6980 <fwp_rc_share>
    6977:	48 89 d8             	mov    %rbx,%rax
    697a:	5b                   	pop    %rbx
    697b:	c3                   	ret
    697c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000006980 <fwp_rc_share>:
    6980:	48 89 f8             	mov    %rdi,%rax
    6983:	48 2b 05 2e 49 01 00 	sub    0x1492e(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    698a:	48 8b 0d 4f 49 01 00 	mov    0x1494f(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    6991:	48 c1 e1 10          	shl    $0x10,%rcx
    6995:	48 39 c8             	cmp    %rcx,%rax
    6998:	0f 83 f9 01 00 00    	jae    6b97 <fwp_rc_share+0x217>
    699e:	41 57                	push   %r15
    69a0:	41 56                	push   %r14
    69a2:	41 55                	push   %r13
    69a4:	41 54                	push   %r12
    69a6:	53                   	push   %rbx
    69a7:	48 81 ec 00 02 00 00 	sub    $0x200,%rsp
    69ae:	48 8b 0d 4b 49 01 00 	mov    0x1494b(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    69b5:	48 89 c2             	mov    %rax,%rdx
    69b8:	48 c1 ea 10          	shr    $0x10,%rdx
    69bc:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    69c3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    69c7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    69cd:	75 13                	jne    69e2 <fwp_rc_share+0x62>
    69cf:	40 80 fe 02          	cmp    $0x2,%sil
    69d3:	75 0d                	jne    69e2 <fwp_rc_share+0x62>
    69d5:	48 8d 1c 11          	lea    (%rcx,%rdx,1),%rbx
    69d9:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    69e0:	eb 25                	jmp    6a07 <fwp_rc_share+0x87>
    69e2:	40 80 fe 01          	cmp    $0x1,%sil
    69e6:	0f 85 9b 01 00 00    	jne    6b87 <fwp_rc_share+0x207>
    69ec:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    69f0:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    69f4:	48 0f af c1          	imul   %rcx,%rax
    69f8:	48 c1 e8 20          	shr    $0x20,%rax
    69fc:	48 8d 1c 30          	lea    (%rax,%rsi,1),%rbx
    6a00:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    6a07:	0f b6 03             	movzbl (%rbx),%eax
    6a0a:	84 c0                	test   %al,%al
    6a0c:	0f 84 75 01 00 00    	je     6b87 <fwp_rc_share+0x207>
    6a12:	3c ff                	cmp    $0xff,%al
    6a14:	0f 84 7e 01 00 00    	je     6b98 <fwp_rc_share+0x218>
    6a1a:	c6 03 00             	movb   $0x0,(%rbx)
    6a1d:	48 89 3c 24          	mov    %rdi,(%rsp)
    6a21:	41 be 01 00 00 00    	mov    $0x1,%r14d
    6a27:	eb 10                	jmp    6a39 <fwp_rc_share+0xb9>
    6a29:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    6a30:	4d 85 f6             	test   %r14,%r14
    6a33:	0f 84 4e 01 00 00    	je     6b87 <fwp_rc_share+0x207>
    6a39:	4e 8b 7c f4 f8       	mov    -0x8(%rsp,%r14,8),%r15
    6a3e:	49 ff ce             	dec    %r14
    6a41:	48 8b 05 70 48 01 00 	mov    0x14870(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    6a48:	4c 89 f9             	mov    %r15,%rcx
    6a4b:	48 29 c1             	sub    %rax,%rcx
    6a4e:	48 89 ce             	mov    %rcx,%rsi
    6a51:	48 c1 ee 10          	shr    $0x10,%rsi
    6a55:	48 8b 15 a4 48 01 00 	mov    0x148a4(%rip),%rdx        # 1b300 <fwp_gc+0x1078>
    6a5c:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    6a63:	80 7c 32 01 01       	cmpb   $0x1,0x1(%rdx,%rsi,1)
    6a68:	74 c6                	je     6a30 <fwp_rc_share+0xb0>
    6a6a:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    6a6e:	40 80 ff 02          	cmp    $0x2,%dil
    6a72:	75 0c                	jne    6a80 <fwp_rc_share+0x100>
    6a74:	4c 8b 64 32 18       	mov    0x18(%rdx,%rsi,1),%r12
    6a79:	eb 32                	jmp    6aad <fwp_rc_share+0x12d>
    6a7b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    6a80:	44 8b 64 32 08       	mov    0x8(%rdx,%rsi,1),%r12d
    6a85:	40 80 ff 01          	cmp    $0x1,%dil
    6a89:	75 22                	jne    6aad <fwp_rc_share+0x12d>
    6a8b:	41 0f b7 ff          	movzwl %r15w,%edi
    6a8f:	44 8b 7c 32 20       	mov    0x20(%rdx,%rsi,1),%r15d
    6a94:	4c 0f af ff          	imul   %rdi,%r15
    6a98:	49 c1 ef 20          	shr    $0x20,%r15
    6a9c:	48 81 e1 00 00 ff ff 	and    $0xffffffffffff0000,%rcx
    6aa3:	48 01 c8             	add    %rcx,%rax
    6aa6:	4d 0f af fc          	imul   %r12,%r15
    6aaa:	49 01 c7             	add    %rax,%r15
    6aad:	49 83 fc 08          	cmp    $0x8,%r12
    6ab1:	0f 82 79 ff ff ff    	jb     6a30 <fwp_rc_share+0xb0>
    6ab7:	49 c1 ec 03          	shr    $0x3,%r12
    6abb:	45 31 ed             	xor    %r13d,%r13d
    6abe:	eb 1c                	jmp    6adc <fwp_rc_share+0x15c>
    6ac0:	e8 bb fe ff ff       	call   6980 <fwp_rc_share>
    6ac5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    6acc:	00 00 00 00 
    6ad0:	49 ff c5             	inc    %r13
    6ad3:	4d 39 ec             	cmp    %r13,%r12
    6ad6:	0f 84 54 ff ff ff    	je     6a30 <fwp_rc_share+0xb0>
    6adc:	4b 8b 3c ef          	mov    (%r15,%r13,8),%rdi
    6ae0:	48 89 f8             	mov    %rdi,%rax
    6ae3:	48 2b 05 ce 47 01 00 	sub    0x147ce(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    6aea:	48 8b 0d ef 47 01 00 	mov    0x147ef(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    6af1:	48 c1 e1 10          	shl    $0x10,%rcx
    6af5:	48 39 c8             	cmp    %rcx,%rax
    6af8:	73 d6                	jae    6ad0 <fwp_rc_share+0x150>
    6afa:	48 8b 0d ff 47 01 00 	mov    0x147ff(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    6b01:	48 89 c2             	mov    %rax,%rdx
    6b04:	48 c1 ea 10          	shr    $0x10,%rdx
    6b08:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6b0f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6b13:	48 25 ff ff 00 00    	and    $0xffff,%rax
    6b19:	75 15                	jne    6b30 <fwp_rc_share+0x1b0>
    6b1b:	40 80 fe 02          	cmp    $0x2,%sil
    6b1f:	75 0f                	jne    6b30 <fwp_rc_share+0x1b0>
    6b21:	48 8d 1c 11          	lea    (%rcx,%rdx,1),%rbx
    6b25:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    6b2c:	eb 23                	jmp    6b51 <fwp_rc_share+0x1d1>
    6b2e:	66 90                	xchg   %ax,%ax
    6b30:	40 80 fe 01          	cmp    $0x1,%sil
    6b34:	75 9a                	jne    6ad0 <fwp_rc_share+0x150>
    6b36:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6b3a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6b3e:	48 0f af c1          	imul   %rcx,%rax
    6b42:	48 c1 e8 20          	shr    $0x20,%rax
    6b46:	48 8d 1c 30          	lea    (%rax,%rsi,1),%rbx
    6b4a:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    6b51:	0f b6 03             	movzbl (%rbx),%eax
    6b54:	84 c0                	test   %al,%al
    6b56:	0f 84 74 ff ff ff    	je     6ad0 <fwp_rc_share+0x150>
    6b5c:	49 83 fe 3f          	cmp    $0x3f,%r14
    6b60:	0f 87 5a ff ff ff    	ja     6ac0 <fwp_rc_share+0x140>
    6b66:	3c ff                	cmp    $0xff,%al
    6b68:	74 13                	je     6b7d <fwp_rc_share+0x1fd>
    6b6a:	c6 03 00             	movb   $0x0,(%rbx)
    6b6d:	4b 8b 04 ef          	mov    (%r15,%r13,8),%rax
    6b71:	4a 89 04 f4          	mov    %rax,(%rsp,%r14,8)
    6b75:	49 ff c6             	inc    %r14
    6b78:	e9 53 ff ff ff       	jmp    6ad0 <fwp_rc_share+0x150>
    6b7d:	48 89 df             	mov    %rbx,%rdi
    6b80:	e8 2b 00 00 00       	call   6bb0 <fwp_rc_forget_slot>
    6b85:	eb e3                	jmp    6b6a <fwp_rc_share+0x1ea>
    6b87:	48 81 c4 00 02 00 00 	add    $0x200,%rsp
    6b8e:	5b                   	pop    %rbx
    6b8f:	41 5c                	pop    %r12
    6b91:	41 5d                	pop    %r13
    6b93:	41 5e                	pop    %r14
    6b95:	41 5f                	pop    %r15
    6b97:	c3                   	ret
    6b98:	49 89 fe             	mov    %rdi,%r14
    6b9b:	48 89 df             	mov    %rbx,%rdi
    6b9e:	e8 0d 00 00 00       	call   6bb0 <fwp_rc_forget_slot>
    6ba3:	4c 89 f7             	mov    %r14,%rdi
    6ba6:	e9 6f fe ff ff       	jmp    6a1a <fwp_rc_share+0x9a>
    6bab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006bb0 <fwp_rc_forget_slot>:
    6bb0:	50                   	push   %rax
    6bb1:	80 3f ff             	cmpb   $0xff,(%rdi)
    6bb4:	74 02                	je     6bb8 <fwp_rc_forget_slot+0x8>
    6bb6:	58                   	pop    %rax
    6bb7:	c3                   	ret
    6bb8:	48 89 f8             	mov    %rdi,%rax
    6bbb:	48 c1 e8 11          	shr    $0x11,%rax
    6bbf:	31 f8                	xor    %edi,%eax
    6bc1:	89 c1                	mov    %eax,%ecx
    6bc3:	c1 e9 09             	shr    $0x9,%ecx
    6bc6:	31 c1                	xor    %eax,%ecx
    6bc8:	0f b6 c9             	movzbl %cl,%ecx
    6bcb:	48 8d 15 b6 36 01 00 	lea    0x136b6(%rip),%rdx        # 1a288 <fwp_gc>
    6bd2:	48 8b 84 ca 18 12 00 	mov    0x1218(%rdx,%rcx,8),%rax
    6bd9:	00 
    6bda:	48 85 c0             	test   %rax,%rax
    6bdd:	74 4b                	je     6c2a <fwp_rc_forget_slot+0x7a>
    6bdf:	48 39 38             	cmp    %rdi,(%rax)
    6be2:	74 23                	je     6c07 <fwp_rc_forget_slot+0x57>
    6be4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    6beb:	00 00 00 00 00 
    6bf0:	48 89 c1             	mov    %rax,%rcx
    6bf3:	48 8b 40 10          	mov    0x10(%rax),%rax
    6bf7:	48 85 c0             	test   %rax,%rax
    6bfa:	74 2e                	je     6c2a <fwp_rc_forget_slot+0x7a>
    6bfc:	48 39 38             	cmp    %rdi,(%rax)
    6bff:	75 ef                	jne    6bf0 <fwp_rc_forget_slot+0x40>
    6c01:	48 83 c1 10          	add    $0x10,%rcx
    6c05:	eb 0b                	jmp    6c12 <fwp_rc_forget_slot+0x62>
    6c07:	48 8d 0c ca          	lea    (%rdx,%rcx,8),%rcx
    6c0b:	48 81 c1 18 12 00 00 	add    $0x1218,%rcx
    6c12:	48 8b 50 10          	mov    0x10(%rax),%rdx
    6c16:	48 89 11             	mov    %rdx,(%rcx)
    6c19:	48 89 c7             	mov    %rax,%rdi
    6c1c:	e8 2f c4 ff ff       	call   3050 <free@plt>
    6c21:	48 ff 0d 78 50 01 00 	decq   0x15078(%rip)        # 1bca0 <fwp_gc+0x1a18>
    6c28:	58                   	pop    %rax
    6c29:	c3                   	ret
    6c2a:	e8 31 00 00 00       	call   6c60 <fwp_flush>
    6c2f:	48 8b 05 a2 33 01 00 	mov    0x133a2(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    6c36:	48 8b 38             	mov    (%rax),%rdi
    6c39:	48 8d 35 6e ee 00 00 	lea    0xee6e(%rip),%rsi        # 15aae <exec_in_fp0+0x23e>
    6c40:	48 8d 15 40 ee 00 00 	lea    0xee40(%rip),%rdx        # 15a87 <exec_in_fp0+0x217>
    6c47:	31 c0                	xor    %eax,%eax
    6c49:	e8 a2 c6 ff ff       	call   32f0 <fprintf@plt>
    6c4e:	bf 65 00 00 00       	mov    $0x65,%edi
    6c53:	e8 08 c8 ff ff       	call   3460 <exit@plt>
    6c58:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6c5f:	00 

0000000000006c60 <fwp_flush>:
    6c60:	50                   	push   %rax
    6c61:	48 8b 3d 10 52 01 00 	mov    0x15210(%rip),%rdi        # 1be78 <fwp_prog_out>
    6c68:	48 85 ff             	test   %rdi,%rdi
    6c6b:	74 05                	je     6c72 <fwp_flush+0x12>
    6c6d:	e8 de c6 ff ff       	call   3350 <fflush@plt>
    6c72:	48 8b 05 37 33 01 00 	mov    0x13337(%rip),%rax        # 19fb0 <stdout@GLIBC_2.2.5>
    6c79:	48 8b 38             	mov    (%rax),%rdi
    6c7c:	58                   	pop    %rax
    6c7d:	e9 ce c6 ff ff       	jmp    3350 <fflush@plt>
    6c82:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6c89:	1f 84 00 00 00 00 00 

0000000000006c90 <fwp_owner_release3>:
    6c90:	48 8b 3f             	mov    (%rdi),%rdi
    6c93:	eb 0b                	jmp    6ca0 <fwp_drop1>
    6c95:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    6c9c:	00 00 00 00 

0000000000006ca0 <fwp_drop1>:
    6ca0:	53                   	push   %rbx
    6ca1:	48 89 f8             	mov    %rdi,%rax
    6ca4:	48 2b 05 0d 46 01 00 	sub    0x1460d(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    6cab:	48 8b 0d 2e 46 01 00 	mov    0x1462e(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    6cb2:	48 c1 e1 10          	shl    $0x10,%rcx
    6cb6:	48 39 c8             	cmp    %rcx,%rax
    6cb9:	0f 83 9c 00 00 00    	jae    6d5b <fwp_drop1+0xbb>
    6cbf:	48 8b 0d 3a 46 01 00 	mov    0x1463a(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    6cc6:	48 89 c2             	mov    %rax,%rdx
    6cc9:	48 c1 ea 10          	shr    $0x10,%rdx
    6ccd:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6cd4:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6cd8:	48 25 ff ff 00 00    	and    $0xffff,%rax
    6cde:	75 20                	jne    6d00 <fwp_drop1+0x60>
    6ce0:	40 80 fe 02          	cmp    $0x2,%sil
    6ce4:	75 1a                	jne    6d00 <fwp_drop1+0x60>
    6ce6:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    6cea:	48 05 28 02 00 00    	add    $0x228,%rax
    6cf0:	eb 2d                	jmp    6d1f <fwp_drop1+0x7f>
    6cf2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6cf9:	1f 84 00 00 00 00 00 
    6d00:	40 80 fe 01          	cmp    $0x1,%sil
    6d04:	75 55                	jne    6d5b <fwp_drop1+0xbb>
    6d06:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6d0a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6d0e:	48 0f af c1          	imul   %rcx,%rax
    6d12:	48 c1 e8 20          	shr    $0x20,%rax
    6d16:	48 01 f0             	add    %rsi,%rax
    6d19:	48 05 28 02 00 00    	add    $0x228,%rax
    6d1f:	0f b6 08             	movzbl (%rax),%ecx
    6d22:	85 c9                	test   %ecx,%ecx
    6d24:	74 35                	je     6d5b <fwp_drop1+0xbb>
    6d26:	83 f9 01             	cmp    $0x1,%ecx
    6d29:	75 32                	jne    6d5d <fwp_drop1+0xbd>
    6d2b:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    6d2f:	79 3a                	jns    6d6b <fwp_drop1+0xcb>
    6d31:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    6d35:	e8 b6 40 00 00       	call   adf0 <fwp_rc_free_arr>
    6d3a:	48 89 d8             	mov    %rbx,%rax
    6d3d:	48 2b 05 74 45 01 00 	sub    0x14574(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    6d44:	48 8b 0d 95 45 01 00 	mov    0x14595(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    6d4b:	48 c1 e1 10          	shl    $0x10,%rcx
    6d4f:	48 89 df             	mov    %rbx,%rdi
    6d52:	48 39 c8             	cmp    %rcx,%rax
    6d55:	0f 82 64 ff ff ff    	jb     6cbf <fwp_drop1+0x1f>
    6d5b:	5b                   	pop    %rbx
    6d5c:	c3                   	ret
    6d5d:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    6d63:	74 0c                	je     6d71 <fwp_drop1+0xd1>
    6d65:	fe c9                	dec    %cl
    6d67:	88 08                	mov    %cl,(%rax)
    6d69:	5b                   	pop    %rbx
    6d6a:	c3                   	ret
    6d6b:	5b                   	pop    %rbx
    6d6c:	e9 7f 40 00 00       	jmp    adf0 <fwp_rc_free_arr>
    6d71:	48 89 c7             	mov    %rax,%rdi
    6d74:	5b                   	pop    %rbx
    6d75:	e9 f6 38 00 00       	jmp    a670 <fwp_rc_wide_drop>
    6d7a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000006d80 <fwp_owner_release4>:
    6d80:	48 8b 3f             	mov    (%rdi),%rdi
    6d83:	e9 18 ff ff ff       	jmp    6ca0 <fwp_drop1>
    6d88:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6d8f:	00 

0000000000006d90 <fwp_owner_release5>:
    6d90:	48 8b 3f             	mov    (%rdi),%rdi
    6d93:	e9 08 ff ff ff       	jmp    6ca0 <fwp_drop1>
    6d98:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6d9f:	00 

0000000000006da0 <fwp_p_array_map_typed>:
    6da0:	55                   	push   %rbp
    6da1:	41 57                	push   %r15
    6da3:	41 56                	push   %r14
    6da5:	41 55                	push   %r13
    6da7:	41 54                	push   %r12
    6da9:	53                   	push   %rbx
    6daa:	48 83 ec 18          	sub    $0x18,%rsp
    6dae:	48 89 3c 24          	mov    %rdi,(%rsp)
    6db2:	49 bf ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r15
    6db9:	ff ff 7f 
    6dbc:	4c 23 3e             	and    (%rsi),%r15
    6dbf:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    6dc6:	ff ff 1f 
    6dc9:	49 39 c7             	cmp    %rax,%r15
    6dcc:	0f 83 16 02 00 00    	jae    6fe8 <fwp_p_array_map_typed+0x248>
    6dd2:	49 89 ce             	mov    %rcx,%r14
    6dd5:	49 89 d4             	mov    %rdx,%r12
    6dd8:	48 89 f3             	mov    %rsi,%rbx
    6ddb:	4c 89 ff             	mov    %r15,%rdi
    6dde:	48 89 d6             	mov    %rdx,%rsi
    6de1:	e8 6a ea ff ff       	call   5850 <fwp_array_new_packed>
    6de6:	48 89 c5             	mov    %rax,%rbp
    6de9:	48 2b 05 c8 44 01 00 	sub    0x144c8(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    6df0:	48 8b 0d e9 44 01 00 	mov    0x144e9(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    6df7:	48 c1 e1 10          	shl    $0x10,%rcx
    6dfb:	48 39 c8             	cmp    %rcx,%rax
    6dfe:	73 72                	jae    6e72 <fwp_p_array_map_typed+0xd2>
    6e00:	48 8b 0d f9 44 01 00 	mov    0x144f9(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    6e07:	48 89 c2             	mov    %rax,%rdx
    6e0a:	48 c1 ea 10          	shr    $0x10,%rdx
    6e0e:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6e15:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6e19:	48 25 ff ff 00 00    	and    $0xffff,%rax
    6e1f:	75 1f                	jne    6e40 <fwp_p_array_map_typed+0xa0>
    6e21:	40 80 fe 02          	cmp    $0x2,%sil
    6e25:	75 19                	jne    6e40 <fwp_p_array_map_typed+0xa0>
    6e27:	4c 8d 2c 11          	lea    (%rcx,%rdx,1),%r13
    6e2b:	49 81 c5 28 02 00 00 	add    $0x228,%r13
    6e32:	41 80 7d 00 ff       	cmpb   $0xff,0x0(%r13)
    6e37:	74 2f                	je     6e68 <fwp_p_array_map_typed+0xc8>
    6e39:	41 c6 45 00 01       	movb   $0x1,0x0(%r13)
    6e3e:	eb 32                	jmp    6e72 <fwp_p_array_map_typed+0xd2>
    6e40:	40 80 fe 01          	cmp    $0x1,%sil
    6e44:	75 2c                	jne    6e72 <fwp_p_array_map_typed+0xd2>
    6e46:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6e4a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6e4e:	48 0f af c1          	imul   %rcx,%rax
    6e52:	48 c1 e8 20          	shr    $0x20,%rax
    6e56:	4c 8d 2c 30          	lea    (%rax,%rsi,1),%r13
    6e5a:	49 81 c5 28 02 00 00 	add    $0x228,%r13
    6e61:	41 80 7d 00 ff       	cmpb   $0xff,0x0(%r13)
    6e66:	75 d1                	jne    6e39 <fwp_p_array_map_typed+0x99>
    6e68:	4c 89 ef             	mov    %r13,%rdi
    6e6b:	e8 40 fd ff ff       	call   6bb0 <fwp_rc_forget_slot>
    6e70:	eb c7                	jmp    6e39 <fwp_p_array_map_typed+0x99>
    6e72:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
    6e77:	4d 85 ff             	test   %r15,%r15
    6e7a:	0f 84 24 01 00 00    	je     6fa4 <fwp_p_array_map_typed+0x204>
    6e80:	4c 8d 7b 08          	lea    0x8(%rbx),%r15
    6e84:	45 31 ed             	xor    %r13d,%r13d
    6e87:	eb 1a                	jmp    6ea3 <fwp_p_array_map_typed+0x103>
    6e89:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    6e90:	4a 89 44 ed 08       	mov    %rax,0x8(%rbp,%r13,8)
    6e95:	49 ff c5             	inc    %r13
    6e98:	4c 39 6c 24 08       	cmp    %r13,0x8(%rsp)
    6e9d:	0f 84 01 01 00 00    	je     6fa4 <fwp_p_array_map_typed+0x204>
    6ea3:	b8 08 00 00 00       	mov    $0x8,%eax
    6ea8:	4d 85 f6             	test   %r14,%r14
    6eab:	74 14                	je     6ec1 <fwp_p_array_map_typed+0x121>
    6ead:	41 8b 0e             	mov    (%r14),%ecx
    6eb0:	48 83 f9 0a          	cmp    $0xa,%rcx
    6eb4:	77 0b                	ja     6ec1 <fwp_p_array_map_typed+0x121>
    6eb6:	48 8d 05 33 ea 00 00 	lea    0xea33(%rip),%rax        # 158f0 <exec_in_fp0+0x80>
    6ebd:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    6ec1:	48 83 3b 00          	cmpq   $0x0,(%rbx)
    6ec5:	4c 89 f9             	mov    %r15,%rcx
    6ec8:	79 04                	jns    6ece <fwp_p_array_map_typed+0x12e>
    6eca:	48 8b 4b 10          	mov    0x10(%rbx),%rcx
    6ece:	48 89 c2             	mov    %rax,%rdx
    6ed1:	49 0f af d5          	imul   %r13,%rdx
    6ed5:	48 83 f8 01          	cmp    $0x1,%rax
    6ed9:	74 25                	je     6f00 <fwp_p_array_map_typed+0x160>
    6edb:	48 83 f8 02          	cmp    $0x2,%rax
    6edf:	74 0f                	je     6ef0 <fwp_p_array_map_typed+0x150>
    6ee1:	48 83 f8 08          	cmp    $0x8,%rax
    6ee5:	75 29                	jne    6f10 <fwp_p_array_map_typed+0x170>
    6ee7:	48 8b 04 11          	mov    (%rcx,%rdx,1),%rax
    6eeb:	eb 31                	jmp    6f1e <fwp_p_array_map_typed+0x17e>
    6eed:	0f 1f 00             	nopl   (%rax)
    6ef0:	41 83 3e 01          	cmpl   $0x1,(%r14)
    6ef4:	0f b7 0c 11          	movzwl (%rcx,%rdx,1),%ecx
    6ef8:	48 0f bf c1          	movswq %cx,%rax
    6efc:	eb 1c                	jmp    6f1a <fwp_p_array_map_typed+0x17a>
    6efe:	66 90                	xchg   %ax,%ax
    6f00:	41 83 3e 00          	cmpl   $0x0,(%r14)
    6f04:	0f b6 0c 11          	movzbl (%rcx,%rdx,1),%ecx
    6f08:	48 0f be c1          	movsbq %cl,%rax
    6f0c:	eb 0c                	jmp    6f1a <fwp_p_array_map_typed+0x17a>
    6f0e:	66 90                	xchg   %ax,%ax
    6f10:	41 83 3e 02          	cmpl   $0x2,(%r14)
    6f14:	8b 0c 11             	mov    (%rcx,%rdx,1),%ecx
    6f17:	48 63 c1             	movslq %ecx,%rax
    6f1a:	48 0f 45 c1          	cmovne %rcx,%rax
    6f1e:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    6f23:	48 8b 3c 24          	mov    (%rsp),%rdi
    6f27:	be 01 00 00 00       	mov    $0x1,%esi
    6f2c:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    6f31:	31 c9                	xor    %ecx,%ecx
    6f33:	e8 d8 00 00 00       	call   7010 <fwp_apply_borrowed_prefix>
    6f38:	48 83 7d 00 00       	cmpq   $0x0,0x0(%rbp)
    6f3d:	78 7b                	js     6fba <fwp_p_array_map_typed+0x21a>
    6f3f:	4d 85 e4             	test   %r12,%r12
    6f42:	0f 84 48 ff ff ff    	je     6e90 <fwp_p_array_map_typed+0xf0>
    6f48:	41 8b 0c 24          	mov    (%r12),%ecx
    6f4c:	83 f9 0a             	cmp    $0xa,%ecx
    6f4f:	0f 87 3b ff ff ff    	ja     6e90 <fwp_p_array_map_typed+0xf0>
    6f55:	ba 84 04 00 00       	mov    $0x484,%edx
    6f5a:	0f a3 ca             	bt     %ecx,%edx
    6f5d:	72 31                	jb     6f90 <fwp_p_array_map_typed+0x1f0>
    6f5f:	ba 21 00 00 00       	mov    $0x21,%edx
    6f64:	0f a3 ca             	bt     %ecx,%edx
    6f67:	72 31                	jb     6f9a <fwp_p_array_map_typed+0x1fa>
    6f69:	ba 42 00 00 00       	mov    $0x42,%edx
    6f6e:	0f a3 ca             	bt     %ecx,%edx
    6f71:	0f 83 19 ff ff ff    	jae    6e90 <fwp_p_array_map_typed+0xf0>
    6f77:	66 42 89 44 6d 08    	mov    %ax,0x8(%rbp,%r13,2)
    6f7d:	e9 13 ff ff ff       	jmp    6e95 <fwp_p_array_map_typed+0xf5>
    6f82:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6f89:	1f 84 00 00 00 00 00 
    6f90:	42 89 44 ad 08       	mov    %eax,0x8(%rbp,%r13,4)
    6f95:	e9 fb fe ff ff       	jmp    6e95 <fwp_p_array_map_typed+0xf5>
    6f9a:	42 88 44 2d 08       	mov    %al,0x8(%rbp,%r13,1)
    6f9f:	e9 f1 fe ff ff       	jmp    6e95 <fwp_p_array_map_typed+0xf5>
    6fa4:	48 8b 04 24          	mov    (%rsp),%rax
    6fa8:	48 89 e8             	mov    %rbp,%rax
    6fab:	48 83 c4 18          	add    $0x18,%rsp
    6faf:	5b                   	pop    %rbx
    6fb0:	41 5c                	pop    %r12
    6fb2:	41 5d                	pop    %r13
    6fb4:	41 5e                	pop    %r14
    6fb6:	41 5f                	pop    %r15
    6fb8:	5d                   	pop    %rbp
    6fb9:	c3                   	ret
    6fba:	e8 a1 fc ff ff       	call   6c60 <fwp_flush>
    6fbf:	48 8b 05 12 30 01 00 	mov    0x13012(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    6fc6:	48 8b 38             	mov    (%rax),%rdi
    6fc9:	48 8d 35 de ea 00 00 	lea    0xeade(%rip),%rsi        # 15aae <exec_in_fp0+0x23e>
    6fd0:	48 8d 15 1f fa 00 00 	lea    0xfa1f(%rip),%rdx        # 169f6 <exec_in_fp0+0x1186>
    6fd7:	31 c0                	xor    %eax,%eax
    6fd9:	e8 12 c3 ff ff       	call   32f0 <fprintf@plt>
    6fde:	bf 65 00 00 00       	mov    $0x65,%edi
    6fe3:	e8 78 c4 ff ff       	call   3460 <exit@plt>
    6fe8:	e8 73 fc ff ff       	call   6c60 <fwp_flush>
    6fed:	48 8b 05 e4 2f 01 00 	mov    0x12fe4(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    6ff4:	48 8b 38             	mov    (%rax),%rdi
    6ff7:	48 8d 35 b0 ea 00 00 	lea    0xeab0(%rip),%rsi        # 15aae <exec_in_fp0+0x23e>
    6ffe:	48 8d 15 b8 ea 00 00 	lea    0xeab8(%rip),%rdx        # 15abd <exec_in_fp0+0x24d>
    7005:	eb d0                	jmp    6fd7 <fwp_p_array_map_typed+0x237>
    7007:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    700e:	00 00 

0000000000007010 <fwp_apply_borrowed_prefix>:
    7010:	55                   	push   %rbp
    7011:	41 57                	push   %r15
    7013:	41 56                	push   %r14
    7015:	41 55                	push   %r13
    7017:	41 54                	push   %r12
    7019:	53                   	push   %rbx
    701a:	48 81 ec a8 00 00 00 	sub    $0xa8,%rsp
    7021:	41 89 cf             	mov    %ecx,%r15d
    7024:	49 89 d5             	mov    %rdx,%r13
    7027:	49 89 fe             	mov    %rdi,%r14
    702a:	4c 8b 25 3f 4e 01 00 	mov    0x14e3f(%rip),%r12        # 1be70 <fwp_fns>
    7031:	8b 0f                	mov    (%rdi),%ecx
    7033:	48 c1 e1 05          	shl    $0x5,%rcx
    7037:	49 8b 44 0c 18       	mov    0x18(%r12,%rcx,1),%rax
    703c:	48 85 c0             	test   %rax,%rax
    703f:	0f 84 b7 03 00 00    	je     73fc <fwp_apply_borrowed_prefix+0x3ec>
    7045:	49 8d 2c 0c          	lea    (%r12,%rcx,1),%rbp
    7049:	48 83 c5 18          	add    $0x18,%rbp
    704d:	49 01 cc             	add    %rcx,%r12
    7050:	31 c9                	xor    %ecx,%ecx
    7052:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7059:	1f 84 00 00 00 00 00 
    7060:	f6 c1 01             	test   $0x1,%cl
    7063:	ba 00 00 00 00       	mov    $0x0,%edx
    7068:	49 0f 45 d6          	cmovne %r14,%rdx
    706c:	48 89 94 24 80 00 00 	mov    %rdx,0x80(%rsp)
    7073:	00 
    7074:	4c 89 ac 24 88 00 00 	mov    %r13,0x88(%rsp)
    707b:	00 
    707c:	48 89 84 24 90 00 00 	mov    %rax,0x90(%rsp)
    7083:	00 
    7084:	c7 84 24 98 00 00 00 	movl   $0x0,0x98(%rsp)
    708b:	00 00 00 00 
    708f:	41 8b 56 04          	mov    0x4(%r14),%edx
    7093:	89 94 24 9c 00 00 00 	mov    %edx,0x9c(%rsp)
    709a:	4c 89 f2             	mov    %r14,%rdx
    709d:	48 2b 15 14 42 01 00 	sub    0x14214(%rip),%rdx        # 1b2b8 <fwp_gc+0x1030>
    70a4:	44 89 bc 24 a0 00 00 	mov    %r15d,0xa0(%rsp)
    70ab:	00 
    70ac:	4c 8b 1d 2d 42 01 00 	mov    0x1422d(%rip),%r11        # 1b2e0 <fwp_gc+0x1058>
    70b3:	49 c1 e3 10          	shl    $0x10,%r11
    70b7:	4c 39 da             	cmp    %r11,%rdx
    70ba:	73 74                	jae    7130 <fwp_apply_borrowed_prefix+0x120>
    70bc:	48 8b 3d 3d 42 01 00 	mov    0x1423d(%rip),%rdi        # 1b300 <fwp_gc+0x1078>
    70c3:	49 89 d0             	mov    %rdx,%r8
    70c6:	49 c1 e8 10          	shr    $0x10,%r8
    70ca:	4d 69 c8 28 12 00 00 	imul   $0x1228,%r8,%r9
    70d1:	46 0f b6 14 0f       	movzbl (%rdi,%r9,1),%r10d
    70d6:	49 89 d0             	mov    %rdx,%r8
    70d9:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    70e0:	75 1e                	jne    7100 <fwp_apply_borrowed_prefix+0xf0>
    70e2:	41 80 fa 02          	cmp    $0x2,%r10b
    70e6:	75 18                	jne    7100 <fwp_apply_borrowed_prefix+0xf0>
    70e8:	4c 01 cf             	add    %r9,%rdi
    70eb:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    70f2:	80 3f 00             	cmpb   $0x0,(%rdi)
    70f5:	75 45                	jne    713c <fwp_apply_borrowed_prefix+0x12c>
    70f7:	eb 37                	jmp    7130 <fwp_apply_borrowed_prefix+0x120>
    70f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    7100:	41 80 fa 01          	cmp    $0x1,%r10b
    7104:	75 2a                	jne    7130 <fwp_apply_borrowed_prefix+0x120>
    7106:	4e 8d 14 0f          	lea    (%rdi,%r9,1),%r10
    710a:	42 8b 7c 0f 20       	mov    0x20(%rdi,%r9,1),%edi
    710f:	4c 0f af c7          	imul   %rdi,%r8
    7113:	49 c1 e8 20          	shr    $0x20,%r8
    7117:	4b 8d 3c 10          	lea    (%r8,%r10,1),%rdi
    711b:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    7122:	80 3f 00             	cmpb   $0x0,(%rdi)
    7125:	75 15                	jne    713c <fwp_apply_borrowed_prefix+0x12c>
    7127:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    712e:	00 00 
    7130:	45 85 ff             	test   %r15d,%r15d
    7133:	74 5b                	je     7190 <fwp_apply_borrowed_prefix+0x180>
    7135:	48 83 78 18 00       	cmpq   $0x0,0x18(%rax)
    713a:	74 54                	je     7190 <fwp_apply_borrowed_prefix+0x180>
    713c:	48 ff 05 7d 4d 01 00 	incq   0x14d7d(%rip)        # 1bec0 <measured_scopes>
    7143:	48 8b 3d 7e 4d 01 00 	mov    0x14d7e(%rip),%rdi        # 1bec8 <fwp_cleanups>
    714a:	48 89 7c 24 68       	mov    %rdi,0x68(%rsp)
    714f:	48 8d 3d 6a 08 00 00 	lea    0x86a(%rip),%rdi        # 79c0 <fwp_apply_release>
    7156:	48 89 7c 24 70       	mov    %rdi,0x70(%rsp)
    715b:	48 8d bc 24 80 00 00 	lea    0x80(%rsp),%rdi
    7162:	00 
    7163:	48 89 7c 24 78       	mov    %rdi,0x78(%rsp)
    7168:	48 8d 7c 24 68       	lea    0x68(%rsp),%rdi
    716d:	48 89 3d 54 4d 01 00 	mov    %rdi,0x14d54(%rip)        # 1bec8 <fwp_cleanups>
    7174:	40 b7 01             	mov    $0x1,%dil
    7177:	89 7c 24 04          	mov    %edi,0x4(%rsp)
    717b:	f6 c1 01             	test   $0x1,%cl
    717e:	74 21                	je     71a1 <fwp_apply_borrowed_prefix+0x191>
    7180:	e9 9c 00 00 00       	jmp    7221 <fwp_apply_borrowed_prefix+0x211>
    7185:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    718c:	00 00 00 00 
    7190:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%rsp)
    7197:	00 
    7198:	f6 c1 01             	test   $0x1,%cl
    719b:	0f 85 80 00 00 00    	jne    7221 <fwp_apply_borrowed_prefix+0x211>
    71a1:	4c 39 da             	cmp    %r11,%rdx
    71a4:	73 6f                	jae    7215 <fwp_apply_borrowed_prefix+0x205>
    71a6:	48 8b 05 53 41 01 00 	mov    0x14153(%rip),%rax        # 1b300 <fwp_gc+0x1078>
    71ad:	48 89 d1             	mov    %rdx,%rcx
    71b0:	48 c1 e9 10          	shr    $0x10,%rcx
    71b4:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    71bb:	0f b6 3c 08          	movzbl (%rax,%rcx,1),%edi
    71bf:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    71c6:	75 13                	jne    71db <fwp_apply_borrowed_prefix+0x1cb>
    71c8:	40 80 ff 02          	cmp    $0x2,%dil
    71cc:	75 0d                	jne    71db <fwp_apply_borrowed_prefix+0x1cb>
    71ce:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    71d2:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    71d9:	eb 20                	jmp    71fb <fwp_apply_borrowed_prefix+0x1eb>
    71db:	40 80 ff 01          	cmp    $0x1,%dil
    71df:	75 34                	jne    7215 <fwp_apply_borrowed_prefix+0x205>
    71e1:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    71e5:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    71e9:	48 0f af d0          	imul   %rax,%rdx
    71ed:	48 c1 ea 20          	shr    $0x20,%rdx
    71f1:	48 01 d7             	add    %rdx,%rdi
    71f4:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    71fb:	0f b6 07             	movzbl (%rdi),%eax
    71fe:	84 c0                	test   %al,%al
    7200:	74 13                	je     7215 <fwp_apply_borrowed_prefix+0x205>
    7202:	48 ff 05 af 4c 01 00 	incq   0x14caf(%rip)        # 1beb8 <measured_retains>
    7209:	3c fe                	cmp    $0xfe,%al
    720b:	0f 83 dd 01 00 00    	jae    73ee <fwp_apply_borrowed_prefix+0x3de>
    7211:	fe c0                	inc    %al
    7213:	88 07                	mov    %al,(%rdi)
    7215:	4c 89 b4 24 80 00 00 	mov    %r14,0x80(%rsp)
    721c:	00 
    721d:	48 8b 45 00          	mov    0x0(%rbp),%rax
    7221:	45 8b 24 24          	mov    (%r12),%r12d
    7225:	45 2b 66 04          	sub    0x4(%r14),%r12d
    7229:	44 39 e6             	cmp    %r12d,%esi
    722c:	44 89 64 24 14       	mov    %r12d,0x14(%rsp)
    7231:	44 0f 42 e6          	cmovb  %esi,%r12d
    7235:	45 39 e7             	cmp    %r12d,%r15d
    7238:	44 89 e2             	mov    %r12d,%edx
    723b:	41 0f 42 d7          	cmovb  %r15d,%edx
    723f:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    7246:	00 00 
    7248:	4c 89 6c 24 20       	mov    %r13,0x20(%rsp)
    724d:	4d 8d 6c d5 00       	lea    0x0(%r13,%rdx,8),%r13
    7252:	4c 89 6c 24 48       	mov    %r13,0x48(%rsp)
    7257:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    725c:	c7 44 24 58 00 00 00 	movl   $0x0,0x58(%rsp)
    7263:	00 
    7264:	41 8b 4e 04          	mov    0x4(%r14),%ecx
    7268:	01 d1                	add    %edx,%ecx
    726a:	89 4c 24 5c          	mov    %ecx,0x5c(%rsp)
    726e:	c7 44 24 60 00 00 00 	movl   $0x0,0x60(%rsp)
    7275:	00 
    7276:	31 db                	xor    %ebx,%ebx
    7278:	b9 00 00 00 00       	mov    $0x0,%ecx
    727d:	45 39 fc             	cmp    %r15d,%r12d
    7280:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)
    7285:	0f 86 a2 00 00 00    	jbe    732d <fwp_apply_borrowed_prefix+0x31d>
    728b:	44 89 7c 24 0c       	mov    %r15d,0xc(%rsp)
    7290:	89 74 24 10          	mov    %esi,0x10(%rsp)
    7294:	48 83 78 18 00       	cmpq   $0x0,0x18(%rax)
    7299:	0f 95 c0             	setne  %al
    729c:	89 44 24 08          	mov    %eax,0x8(%rsp)
    72a0:	74 35                	je     72d7 <fwp_apply_borrowed_prefix+0x2c7>
    72a2:	48 ff 05 17 4c 01 00 	incq   0x14c17(%rip)        # 1bec0 <measured_scopes>
    72a9:	48 8b 05 18 4c 01 00 	mov    0x14c18(%rip),%rax        # 1bec8 <fwp_cleanups>
    72b0:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    72b5:	48 8d 05 04 07 00 00 	lea    0x704(%rip),%rax        # 79c0 <fwp_apply_release>
    72bc:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    72c1:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
    72c6:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    72cb:	48 8d 44 24 28       	lea    0x28(%rsp),%rax
    72d0:	48 89 05 f1 4b 01 00 	mov    %rax,0x14bf1(%rip)        # 1bec8 <fwp_cleanups>
    72d7:	45 89 e7             	mov    %r12d,%r15d
    72da:	41 29 d7             	sub    %edx,%r15d
    72dd:	41 83 ff 01          	cmp    $0x1,%r15d
    72e1:	41 83 d7 00          	adc    $0x0,%r15d
    72e5:	49 c1 e7 03          	shl    $0x3,%r15
    72e9:	89 d3                	mov    %edx,%ebx
    72eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    72f0:	48 8b 45 00          	mov    0x0(%rbp),%rax
    72f4:	41 8b 76 04          	mov    0x4(%r14),%esi
    72f8:	01 de                	add    %ebx,%esi
    72fa:	4c 89 ef             	mov    %r13,%rdi
    72fd:	ba 01 00 00 00       	mov    $0x1,%edx
    7302:	ff 50 10             	call   *0x10(%rax)
    7305:	8b 4c 24 60          	mov    0x60(%rsp),%ecx
    7309:	ff c1                	inc    %ecx
    730b:	89 4c 24 60          	mov    %ecx,0x60(%rsp)
    730f:	ff c3                	inc    %ebx
    7311:	49 83 c5 08          	add    $0x8,%r13
    7315:	49 83 c7 f8          	add    $0xfffffffffffffff8,%r15
    7319:	75 d5                	jne    72f0 <fwp_apply_borrowed_prefix+0x2e0>
    731b:	8b 74 24 10          	mov    0x10(%rsp),%esi
    731f:	44 8b 7c 24 0c       	mov    0xc(%rsp),%r15d
    7324:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
    7329:	8b 5c 24 08          	mov    0x8(%rsp),%ebx
    732d:	89 f5                	mov    %esi,%ebp
    732f:	89 4c 24 58          	mov    %ecx,0x58(%rsp)
    7333:	48 c7 84 24 80 00 00 	movq   $0x0,0x80(%rsp)
    733a:	00 00 00 00 00 
    733f:	89 94 24 98 00 00 00 	mov    %edx,0x98(%rsp)
    7346:	4c 89 f7             	mov    %r14,%rdi
    7349:	44 89 e6             	mov    %r12d,%esi
    734c:	4c 8b 6c 24 20       	mov    0x20(%rsp),%r13
    7351:	4c 89 ea             	mov    %r13,%rdx
    7354:	e8 d7 06 00 00       	call   7a30 <fwp_apply_owned>
    7359:	49 89 c6             	mov    %rax,%r14
    735c:	84 db                	test   %bl,%bl
    735e:	74 1e                	je     737e <fwp_apply_borrowed_prefix+0x36e>
    7360:	48 8d 44 24 28       	lea    0x28(%rsp),%rax
    7365:	48 39 05 5c 4b 01 00 	cmp    %rax,0x14b5c(%rip)        # 1bec8 <fwp_cleanups>
    736c:	0f 85 e5 00 00 00    	jne    7457 <fwp_apply_borrowed_prefix+0x447>
    7372:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    7377:	48 89 05 4a 4b 01 00 	mov    %rax,0x14b4a(%rip)        # 1bec8 <fwp_cleanups>
    737e:	80 7c 24 04 00       	cmpb   $0x0,0x4(%rsp)
    7383:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    7388:	89 ee                	mov    %ebp,%esi
    738a:	74 1e                	je     73aa <fwp_apply_borrowed_prefix+0x39a>
    738c:	48 8d 44 24 68       	lea    0x68(%rsp),%rax
    7391:	48 39 05 30 4b 01 00 	cmp    %rax,0x14b30(%rip)        # 1bec8 <fwp_cleanups>
    7398:	0f 85 b9 00 00 00    	jne    7457 <fwp_apply_borrowed_prefix+0x447>
    739e:	48 8b 44 24 68       	mov    0x68(%rsp),%rax
    73a3:	48 89 05 1e 4b 01 00 	mov    %rax,0x14b1e(%rip)        # 1bec8 <fwp_cleanups>
    73aa:	3b 74 24 14          	cmp    0x14(%rsp),%esi
    73ae:	0f 86 8e 00 00 00    	jbe    7442 <fwp_apply_borrowed_prefix+0x432>
    73b4:	44 89 e0             	mov    %r12d,%eax
    73b7:	4d 8d 6c c5 00       	lea    0x0(%r13,%rax,8),%r13
    73bc:	44 29 e6             	sub    %r12d,%esi
    73bf:	41 29 cf             	sub    %ecx,%r15d
    73c2:	48 8b 05 a7 4a 01 00 	mov    0x14aa7(%rip),%rax        # 1be70 <fwp_fns>
    73c9:	41 8b 0e             	mov    (%r14),%ecx
    73cc:	48 c1 e1 05          	shl    $0x5,%rcx
    73d0:	4c 8d 24 08          	lea    (%rax,%rcx,1),%r12
    73d4:	48 8d 2c 08          	lea    (%rax,%rcx,1),%rbp
    73d8:	48 83 c5 18          	add    $0x18,%rbp
    73dc:	48 8b 44 08 18       	mov    0x18(%rax,%rcx,1),%rax
    73e1:	b1 01                	mov    $0x1,%cl
    73e3:	48 85 c0             	test   %rax,%rax
    73e6:	0f 85 74 fc ff ff    	jne    7060 <fwp_apply_borrowed_prefix+0x50>
    73ec:	eb 0e                	jmp    73fc <fwp_apply_borrowed_prefix+0x3ec>
    73ee:	89 f3                	mov    %esi,%ebx
    73f0:	e8 0b 33 00 00       	call   a700 <fwp_rc_wide_dup>
    73f5:	89 de                	mov    %ebx,%esi
    73f7:	e9 19 fe ff ff       	jmp    7215 <fwp_apply_borrowed_prefix+0x205>
    73fc:	4c 89 f7             	mov    %r14,%rdi
    73ff:	89 f3                	mov    %esi,%ebx
    7401:	e8 7a f5 ff ff       	call   6980 <fwp_rc_share>
    7406:	89 dd                	mov    %ebx,%ebp
    7408:	85 db                	test   %ebx,%ebx
    740a:	74 26                	je     7432 <fwp_apply_borrowed_prefix+0x422>
    740c:	89 eb                	mov    %ebp,%ebx
    740e:	45 31 ff             	xor    %r15d,%r15d
    7411:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7418:	0f 1f 84 00 00 00 00 
    741f:	00 
    7420:	4b 8b 7c fd 00       	mov    0x0(%r13,%r15,8),%rdi
    7425:	e8 56 f5 ff ff       	call   6980 <fwp_rc_share>
    742a:	49 ff c7             	inc    %r15
    742d:	4c 39 fb             	cmp    %r15,%rbx
    7430:	75 ee                	jne    7420 <fwp_apply_borrowed_prefix+0x410>
    7432:	4c 89 f7             	mov    %r14,%rdi
    7435:	89 ee                	mov    %ebp,%esi
    7437:	4c 89 ea             	mov    %r13,%rdx
    743a:	e8 21 00 00 00       	call   7460 <fwp_apply>
    743f:	49 89 c6             	mov    %rax,%r14
    7442:	4c 89 f0             	mov    %r14,%rax
    7445:	48 81 c4 a8 00 00 00 	add    $0xa8,%rsp
    744c:	5b                   	pop    %rbx
    744d:	41 5c                	pop    %r12
    744f:	41 5d                	pop    %r13
    7451:	41 5e                	pop    %r14
    7453:	41 5f                	pop    %r15
    7455:	5d                   	pop    %rbp
    7456:	c3                   	ret
    7457:	e8 14 bc ff ff       	call   3070 <abort@plt>
    745c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000007460 <fwp_apply>:
    7460:	55                   	push   %rbp
    7461:	48 89 e5             	mov    %rsp,%rbp
    7464:	41 57                	push   %r15
    7466:	41 56                	push   %r14
    7468:	41 55                	push   %r13
    746a:	41 54                	push   %r12
    746c:	53                   	push   %rbx
    746d:	48 83 ec 18          	sub    $0x18,%rsp
    7471:	48 89 d3             	mov    %rdx,%rbx
    7474:	49 89 ff             	mov    %rdi,%r15
    7477:	eb 23                	jmp    749c <fwp_apply+0x3c>
    7479:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    7480:	4a 8d 1c f3          	lea    (%rbx,%r14,8),%rbx
    7484:	31 c9                	xor    %ecx,%ecx
    7486:	49 89 c7             	mov    %rax,%r15
    7489:	4c 8b 75 c8          	mov    -0x38(%rbp),%r14
    748d:	48 8b 65 c0          	mov    -0x40(%rbp),%rsp
    7491:	89 d6                	mov    %edx,%esi
    7493:	83 f9 01             	cmp    $0x1,%ecx
    7496:	0f 84 aa 04 00 00    	je     7946 <fwp_apply+0x4e6>
    749c:	48 8b 05 cd 49 01 00 	mov    0x149cd(%rip),%rax        # 1be70 <fwp_fns>
    74a3:	41 8b 0f             	mov    (%r15),%ecx
    74a6:	45 8b 6f 04          	mov    0x4(%r15),%r13d
    74aa:	48 c1 e1 05          	shl    $0x5,%rcx
    74ae:	44 8b 24 08          	mov    (%rax,%rcx,1),%r12d
    74b2:	4d 85 ed             	test   %r13,%r13
    74b5:	75 39                	jne    74f0 <fwp_apply+0x90>
    74b7:	41 8d 54 24 ff       	lea    -0x1(%r12),%edx
    74bc:	39 f2                	cmp    %esi,%edx
    74be:	73 30                	jae    74f0 <fwp_apply+0x90>
    74c0:	48 89 df             	mov    %rbx,%rdi
    74c3:	49 89 f7             	mov    %rsi,%r15
    74c6:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    74ca:	4c 89 fe             	mov    %r15,%rsi
    74cd:	49 89 c7             	mov    %rax,%r15
    74d0:	44 39 e6             	cmp    %r12d,%esi
    74d3:	0f 84 b6 02 00 00    	je     778f <fwp_apply+0x32f>
    74d9:	4a 8d 1c e3          	lea    (%rbx,%r12,8),%rbx
    74dd:	44 29 e6             	sub    %r12d,%esi
    74e0:	b9 03 00 00 00       	mov    $0x3,%ecx
    74e5:	83 f9 01             	cmp    $0x1,%ecx
    74e8:	75 b2                	jne    749c <fwp_apply+0x3c>
    74ea:	e9 57 04 00 00       	jmp    7946 <fwp_apply+0x4e6>
    74ef:	90                   	nop
    74f0:	4c 89 75 c8          	mov    %r14,-0x38(%rbp)
    74f4:	46 8d 34 2e          	lea    (%rsi,%r13,1),%r14d
    74f8:	45 39 e6             	cmp    %r12d,%r14d
    74fb:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    74ff:	0f 82 1a 02 00 00    	jb     771f <fwp_apply+0x2bf>
    7505:	48 89 65 c0          	mov    %rsp,-0x40(%rbp)
    7509:	45 89 e3             	mov    %r12d,%r11d
    750c:	41 83 fc 02          	cmp    $0x2,%r12d
    7510:	ba 01 00 00 00       	mov    $0x1,%edx
    7515:	41 0f 43 d4          	cmovae %r12d,%edx
    7519:	48 8d 14 d5 0f 00 00 	lea    0xf(,%rdx,8),%rdx
    7520:	00 
    7521:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
    7525:	48 89 e7             	mov    %rsp,%rdi
    7528:	48 29 d7             	sub    %rdx,%rdi
    752b:	48 89 fc             	mov    %rdi,%rsp
    752e:	4d 85 ed             	test   %r13,%r13
    7531:	0f 84 c9 00 00 00    	je     7600 <fwp_apply+0x1a0>
    7537:	41 83 fd 04          	cmp    $0x4,%r13d
    753b:	72 10                	jb     754d <fwp_apply+0xed>
    753d:	48 89 fa             	mov    %rdi,%rdx
    7540:	4c 29 fa             	sub    %r15,%rdx
    7543:	48 83 c2 f8          	add    $0xfffffffffffffff8,%rdx
    7547:	48 83 fa 20          	cmp    $0x20,%rdx
    754b:	73 65                	jae    75b2 <fwp_apply+0x152>
    754d:	31 d2                	xor    %edx,%edx
    754f:	4d 89 e8             	mov    %r13,%r8
    7552:	49 89 d2             	mov    %rdx,%r10
    7555:	49 83 e0 03          	and    $0x3,%r8
    7559:	74 16                	je     7571 <fwp_apply+0x111>
    755b:	49 89 d2             	mov    %rdx,%r10
    755e:	66 90                	xchg   %ax,%ax
    7560:	4f 8b 4c d7 08       	mov    0x8(%r15,%r10,8),%r9
    7565:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    7569:	49 ff c2             	inc    %r10
    756c:	49 ff c8             	dec    %r8
    756f:	75 ef                	jne    7560 <fwp_apply+0x100>
    7571:	4c 29 ea             	sub    %r13,%rdx
    7574:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    7578:	0f 87 82 00 00 00    	ja     7600 <fwp_apply+0x1a0>
    757e:	66 90                	xchg   %ax,%ax
    7580:	4b 8b 54 d7 08       	mov    0x8(%r15,%r10,8),%rdx
    7585:	4a 89 14 d7          	mov    %rdx,(%rdi,%r10,8)
    7589:	4b 8b 54 d7 10       	mov    0x10(%r15,%r10,8),%rdx
    758e:	4a 89 54 d7 08       	mov    %rdx,0x8(%rdi,%r10,8)
    7593:	4b 8b 54 d7 18       	mov    0x18(%r15,%r10,8),%rdx
    7598:	4a 89 54 d7 10       	mov    %rdx,0x10(%rdi,%r10,8)
    759d:	4b 8b 54 d7 20       	mov    0x20(%r15,%r10,8),%rdx
    75a2:	4a 89 54 d7 18       	mov    %rdx,0x18(%rdi,%r10,8)
    75a7:	49 83 c2 04          	add    $0x4,%r10
    75ab:	4d 39 d5             	cmp    %r10,%r13
    75ae:	75 d0                	jne    7580 <fwp_apply+0x120>
    75b0:	eb 4e                	jmp    7600 <fwp_apply+0x1a0>
    75b2:	44 89 ea             	mov    %r13d,%edx
    75b5:	83 e2 fc             	and    $0xfffffffc,%edx
    75b8:	4e 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%r9
    75bf:	00 
    75c0:	49 83 e1 e0          	and    $0xffffffffffffffe0,%r9
    75c4:	45 31 c0             	xor    %r8d,%r8d
    75c7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    75ce:	00 00 
    75d0:	43 0f 10 44 07 08    	movups 0x8(%r15,%r8,1),%xmm0
    75d6:	43 0f 10 4c 07 18    	movups 0x18(%r15,%r8,1),%xmm1
    75dc:	42 0f 29 04 07       	movaps %xmm0,(%rdi,%r8,1)
    75e1:	42 0f 29 4c 07 10    	movaps %xmm1,0x10(%rdi,%r8,1)
    75e7:	49 83 c0 20          	add    $0x20,%r8
    75eb:	4d 39 c1             	cmp    %r8,%r9
    75ee:	75 e0                	jne    75d0 <fwp_apply+0x170>
    75f0:	4c 39 ea             	cmp    %r13,%rdx
    75f3:	0f 85 56 ff ff ff    	jne    754f <fwp_apply+0xef>
    75f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    7600:	45 29 eb             	sub    %r13d,%r11d
    7603:	45 89 de             	mov    %r11d,%r14d
    7606:	45 39 ec             	cmp    %r13d,%r12d
    7609:	0f 84 85 00 00 00    	je     7694 <fwp_apply+0x234>
    760f:	41 83 fb 0e          	cmp    $0xe,%r11d
    7613:	0f 83 a0 00 00 00    	jae    76b9 <fwp_apply+0x259>
    7619:	31 d2                	xor    %edx,%edx
    761b:	4d 89 f0             	mov    %r14,%r8
    761e:	48 89 d6             	mov    %rdx,%rsi
    7621:	49 83 e0 03          	and    $0x3,%r8
    7625:	74 1d                	je     7644 <fwp_apply+0x1e4>
    7627:	48 89 d6             	mov    %rdx,%rsi
    762a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    7630:	4c 8b 0c f3          	mov    (%rbx,%rsi,8),%r9
    7634:	46 8d 14 2e          	lea    (%rsi,%r13,1),%r10d
    7638:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    763c:	48 ff c6             	inc    %rsi
    763f:	49 ff c8             	dec    %r8
    7642:	75 ec                	jne    7630 <fwp_apply+0x1d0>
    7644:	4c 29 f2             	sub    %r14,%rdx
    7647:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    764b:	77 47                	ja     7694 <fwp_apply+0x234>
    764d:	0f 1f 00             	nopl   (%rax)
    7650:	48 8b 14 f3          	mov    (%rbx,%rsi,8),%rdx
    7654:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    7658:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    765c:	48 8b 54 f3 08       	mov    0x8(%rbx,%rsi,8),%rdx
    7661:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    7665:	41 ff c0             	inc    %r8d
    7668:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    766c:	48 8b 54 f3 10       	mov    0x10(%rbx,%rsi,8),%rdx
    7671:	45 8d 44 35 02       	lea    0x2(%r13,%rsi,1),%r8d
    7676:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    767a:	48 8b 54 f3 18       	mov    0x18(%rbx,%rsi,8),%rdx
    767f:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    7683:	41 83 c0 03          	add    $0x3,%r8d
    7687:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    768b:	48 83 c6 04          	add    $0x4,%rsi
    768f:	49 39 f6             	cmp    %rsi,%r14
    7692:	75 bc                	jne    7650 <fwp_apply+0x1f0>
    7694:	45 89 dc             	mov    %r11d,%r12d
    7697:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    769b:	b9 01 00 00 00       	mov    $0x1,%ecx
    76a0:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    76a4:	89 f2                	mov    %esi,%edx
    76a6:	44 29 e2             	sub    %r12d,%edx
    76a9:	0f 85 d1 fd ff ff    	jne    7480 <fwp_apply+0x20>
    76af:	89 f2                	mov    %esi,%edx
    76b1:	49 89 c6             	mov    %rax,%r14
    76b4:	e9 d4 fd ff ff       	jmp    748d <fwp_apply+0x2d>
    76b9:	49 8d 56 ff          	lea    -0x1(%r14),%rdx
    76bd:	89 d6                	mov    %edx,%esi
    76bf:	44 01 ee             	add    %r13d,%esi
    76c2:	0f 82 51 ff ff ff    	jb     7619 <fwp_apply+0x1b9>
    76c8:	48 c1 ea 20          	shr    $0x20,%rdx
    76cc:	ba 00 00 00 00       	mov    $0x0,%edx
    76d1:	0f 85 44 ff ff ff    	jne    761b <fwp_apply+0x1bb>
    76d7:	4a 8d 14 ef          	lea    (%rdi,%r13,8),%rdx
    76db:	48 29 da             	sub    %rbx,%rdx
    76de:	48 83 fa 20          	cmp    $0x20,%rdx
    76e2:	0f 82 31 ff ff ff    	jb     7619 <fwp_apply+0x1b9>
    76e8:	44 89 f2             	mov    %r14d,%edx
    76eb:	83 e2 fc             	and    $0xfffffffc,%edx
    76ee:	31 f6                	xor    %esi,%esi
    76f0:	0f 10 04 f3          	movups (%rbx,%rsi,8),%xmm0
    76f4:	0f 10 4c f3 10       	movups 0x10(%rbx,%rsi,8),%xmm1
    76f9:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    76fd:	42 0f 11 04 c7       	movups %xmm0,(%rdi,%r8,8)
    7702:	42 0f 11 4c c7 10    	movups %xmm1,0x10(%rdi,%r8,8)
    7708:	48 83 c6 04          	add    $0x4,%rsi
    770c:	48 39 f2             	cmp    %rsi,%rdx
    770f:	75 df                	jne    76f0 <fwp_apply+0x290>
    7711:	4c 39 f2             	cmp    %r14,%rdx
    7714:	0f 85 01 ff ff ff    	jne    761b <fwp_apply+0x1bb>
    771a:	e9 75 ff ff ff       	jmp    7694 <fwp_apply+0x234>
    771f:	44 89 f1             	mov    %r14d,%ecx
    7722:	48 8d 3c cd 08 00 00 	lea    0x8(,%rcx,8),%rdi
    7729:	00 
    772a:	48 ff 05 77 47 01 00 	incq   0x14777(%rip)        # 1bea8 <measured_calls>
    7731:	48 01 3d 78 47 01 00 	add    %rdi,0x14778(%rip)        # 1beb0 <measured_bytes>
    7738:	41 81 fe ff 07 00 00 	cmp    $0x7ff,%r14d
    773f:	77 6e                	ja     77af <fwp_apply+0x34f>
    7741:	48 c1 e1 03          	shl    $0x3,%rcx
    7745:	48 83 c1 17          	add    $0x17,%rcx
    7749:	48 c1 e9 04          	shr    $0x4,%rcx
    774d:	48 8d 05 34 2b 01 00 	lea    0x12b34(%rip),%rax        # 1a288 <fwp_gc>
    7754:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    775b:	00 
    775c:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    7763:	48 29 15 1e 2b 01 00 	sub    %rdx,0x12b1e(%rip)        # 1a288 <fwp_gc>
    776a:	78 43                	js     77af <fwp_apply+0x34f>
    776c:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    7770:	4c 8d 04 c8          	lea    (%rax,%rcx,8),%r8
    7774:	49 81 c0 88 07 00 00 	add    $0x788,%r8
    777b:	4d 8b 20             	mov    (%r8),%r12
    777e:	4d 85 e4             	test   %r12,%r12
    7781:	74 14                	je     7797 <fwp_apply+0x337>
    7783:	49 8b 04 24          	mov    (%r12),%rax
    7787:	48 f7 d0             	not    %rax
    778a:	49 89 00             	mov    %rax,(%r8)
    778d:	eb 40                	jmp    77cf <fwp_apply+0x36f>
    778f:	4d 89 fe             	mov    %r15,%r14
    7792:	e9 af 01 00 00       	jmp    7946 <fwp_apply+0x4e6>
    7797:	4c 8b a4 c8 90 07 00 	mov    0x790(%rax,%rcx,8),%r12
    779e:	00 
    779f:	4c 8b 84 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%r8
    77a6:	00 
    77a7:	4d 29 e0             	sub    %r12,%r8
    77aa:	49 39 d0             	cmp    %rdx,%r8
    77ad:	73 0f                	jae    77be <fwp_apply+0x35e>
    77af:	be 02 00 00 00       	mov    $0x2,%esi
    77b4:	e8 87 0b 00 00       	call   8340 <fwp_gc_alloc_slow>
    77b9:	49 89 c4             	mov    %rax,%r12
    77bc:	eb 1b                	jmp    77d9 <fwp_apply+0x379>
    77be:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    77c2:	48 05 90 07 00 00    	add    $0x790,%rax
    77c8:	49 8d 0c 14          	lea    (%r12,%rdx,1),%rcx
    77cc:	48 89 08             	mov    %rcx,(%rax)
    77cf:	4c 89 e7             	mov    %r12,%rdi
    77d2:	31 f6                	xor    %esi,%esi
    77d4:	e8 37 ba ff ff       	call   3210 <memset@plt>
    77d9:	41 8b 07             	mov    (%r15),%eax
    77dc:	41 89 04 24          	mov    %eax,(%r12)
    77e0:	45 89 74 24 04       	mov    %r14d,0x4(%r12)
    77e5:	4d 85 ed             	test   %r13,%r13
    77e8:	4d 89 e6             	mov    %r12,%r14
    77eb:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    77ef:	0f 84 bc 00 00 00    	je     78b1 <fwp_apply+0x451>
    77f5:	31 c0                	xor    %eax,%eax
    77f7:	41 83 fd 06          	cmp    $0x6,%r13d
    77fb:	72 49                	jb     7846 <fwp_apply+0x3e6>
    77fd:	4c 89 f1             	mov    %r14,%rcx
    7800:	4c 29 f9             	sub    %r15,%rcx
    7803:	48 83 f9 20          	cmp    $0x20,%rcx
    7807:	72 3d                	jb     7846 <fwp_apply+0x3e6>
    7809:	44 89 e8             	mov    %r13d,%eax
    780c:	83 e0 fc             	and    $0xfffffffc,%eax
    780f:	4a 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%rcx
    7816:	00 
    7817:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    781b:	31 d2                	xor    %edx,%edx
    781d:	0f 1f 00             	nopl   (%rax)
    7820:	41 0f 10 44 17 08    	movups 0x8(%r15,%rdx,1),%xmm0
    7826:	41 0f 10 4c 17 18    	movups 0x18(%r15,%rdx,1),%xmm1
    782c:	41 0f 11 44 16 08    	movups %xmm0,0x8(%r14,%rdx,1)
    7832:	41 0f 11 4c 16 18    	movups %xmm1,0x18(%r14,%rdx,1)
    7838:	48 83 c2 20          	add    $0x20,%rdx
    783c:	48 39 d1             	cmp    %rdx,%rcx
    783f:	75 df                	jne    7820 <fwp_apply+0x3c0>
    7841:	4c 39 e8             	cmp    %r13,%rax
    7844:	74 6b                	je     78b1 <fwp_apply+0x451>
    7846:	4c 89 ea             	mov    %r13,%rdx
    7849:	48 89 c1             	mov    %rax,%rcx
    784c:	48 83 e2 03          	and    $0x3,%rdx
    7850:	74 20                	je     7872 <fwp_apply+0x412>
    7852:	48 89 c1             	mov    %rax,%rcx
    7855:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    785c:	00 00 00 00 
    7860:	49 8b 74 cf 08       	mov    0x8(%r15,%rcx,8),%rsi
    7865:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    786a:	48 ff c1             	inc    %rcx
    786d:	48 ff ca             	dec    %rdx
    7870:	75 ee                	jne    7860 <fwp_apply+0x400>
    7872:	4c 29 e8             	sub    %r13,%rax
    7875:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    7879:	77 36                	ja     78b1 <fwp_apply+0x451>
    787b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7880:	49 8b 44 cf 08       	mov    0x8(%r15,%rcx,8),%rax
    7885:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    788a:	49 8b 44 cf 10       	mov    0x10(%r15,%rcx,8),%rax
    788f:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    7894:	49 8b 44 cf 18       	mov    0x18(%r15,%rcx,8),%rax
    7899:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    789e:	49 8b 44 cf 20       	mov    0x20(%r15,%rcx,8),%rax
    78a3:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    78a8:	48 83 c1 04          	add    $0x4,%rcx
    78ac:	49 39 cd             	cmp    %rcx,%r13
    78af:	75 cf                	jne    7880 <fwp_apply+0x420>
    78b1:	85 ff                	test   %edi,%edi
    78b3:	0f 84 8d 00 00 00    	je     7946 <fwp_apply+0x4e6>
    78b9:	89 f8                	mov    %edi,%eax
    78bb:	83 ff 14             	cmp    $0x14,%edi
    78be:	0f 83 94 00 00 00    	jae    7958 <fwp_apply+0x4f8>
    78c4:	31 c9                	xor    %ecx,%ecx
    78c6:	48 89 c6             	mov    %rax,%rsi
    78c9:	48 89 ca             	mov    %rcx,%rdx
    78cc:	48 83 e6 03          	and    $0x3,%rsi
    78d0:	74 23                	je     78f5 <fwp_apply+0x495>
    78d2:	48 89 ca             	mov    %rcx,%rdx
    78d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    78dc:	00 00 00 00 
    78e0:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    78e4:	46 8d 04 2a          	lea    (%rdx,%r13,1),%r8d
    78e8:	4b 89 7c c6 08       	mov    %rdi,0x8(%r14,%r8,8)
    78ed:	48 ff c2             	inc    %rdx
    78f0:	48 ff ce             	dec    %rsi
    78f3:	75 eb                	jne    78e0 <fwp_apply+0x480>
    78f5:	48 29 c1             	sub    %rax,%rcx
    78f8:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    78fc:	77 48                	ja     7946 <fwp_apply+0x4e6>
    78fe:	66 90                	xchg   %ax,%ax
    7900:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    7904:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    7908:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    790d:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    7912:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    7916:	ff c6                	inc    %esi
    7918:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    791d:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    7922:	41 8d 74 15 02       	lea    0x2(%r13,%rdx,1),%esi
    7927:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    792c:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    7931:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    7935:	83 c6 03             	add    $0x3,%esi
    7938:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    793d:	48 83 c2 04          	add    $0x4,%rdx
    7941:	48 39 d0             	cmp    %rdx,%rax
    7944:	75 ba                	jne    7900 <fwp_apply+0x4a0>
    7946:	4c 89 f0             	mov    %r14,%rax
    7949:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    794d:	5b                   	pop    %rbx
    794e:	41 5c                	pop    %r12
    7950:	41 5d                	pop    %r13
    7952:	41 5e                	pop    %r14
    7954:	41 5f                	pop    %r15
    7956:	5d                   	pop    %rbp
    7957:	c3                   	ret
    7958:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    795c:	31 c9                	xor    %ecx,%ecx
    795e:	89 d6                	mov    %edx,%esi
    7960:	44 01 ee             	add    %r13d,%esi
    7963:	0f 82 5d ff ff ff    	jb     78c6 <fwp_apply+0x466>
    7969:	48 c1 ea 20          	shr    $0x20,%rdx
    796d:	0f 85 53 ff ff ff    	jne    78c6 <fwp_apply+0x466>
    7973:	4b 8d 0c ee          	lea    (%r14,%r13,8),%rcx
    7977:	48 29 d9             	sub    %rbx,%rcx
    797a:	48 83 c1 08          	add    $0x8,%rcx
    797e:	48 83 f9 20          	cmp    $0x20,%rcx
    7982:	0f 82 3c ff ff ff    	jb     78c4 <fwp_apply+0x464>
    7988:	89 c1                	mov    %eax,%ecx
    798a:	83 e1 fc             	and    $0xfffffffc,%ecx
    798d:	31 d2                	xor    %edx,%edx
    798f:	90                   	nop
    7990:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    7994:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    7999:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    799d:	41 0f 11 44 f6 08    	movups %xmm0,0x8(%r14,%rsi,8)
    79a3:	41 0f 11 4c f6 18    	movups %xmm1,0x18(%r14,%rsi,8)
    79a9:	48 83 c2 04          	add    $0x4,%rdx
    79ad:	48 39 d1             	cmp    %rdx,%rcx
    79b0:	75 de                	jne    7990 <fwp_apply+0x530>
    79b2:	48 39 c1             	cmp    %rax,%rcx
    79b5:	0f 85 0b ff ff ff    	jne    78c6 <fwp_apply+0x466>
    79bb:	eb 89                	jmp    7946 <fwp_apply+0x4e6>
    79bd:	0f 1f 00             	nopl   (%rax)

00000000000079c0 <fwp_apply_release>:
    79c0:	41 56                	push   %r14
    79c2:	53                   	push   %rbx
    79c3:	50                   	push   %rax
    79c4:	48 8b 1f             	mov    (%rdi),%rbx
    79c7:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    79ce:	8b 47 20             	mov    0x20(%rdi),%eax
    79d1:	8b 4f 18             	mov    0x18(%rdi),%ecx
    79d4:	89 c2                	mov    %eax,%edx
    79d6:	29 ca                	sub    %ecx,%edx
    79d8:	74 2d                	je     7a07 <fwp_apply_release+0x47>
    79da:	48 8b 77 10          	mov    0x10(%rdi),%rsi
    79de:	4c 8b 46 18          	mov    0x18(%rsi),%r8
    79e2:	4d 85 c0             	test   %r8,%r8
    79e5:	74 20                	je     7a07 <fwp_apply_release+0x47>
    79e7:	48 89 c8             	mov    %rcx,%rax
    79ea:	48 c1 e0 03          	shl    $0x3,%rax
    79ee:	48 03 47 08          	add    0x8(%rdi),%rax
    79f2:	8b 77 1c             	mov    0x1c(%rdi),%esi
    79f5:	01 ce                	add    %ecx,%esi
    79f7:	49 89 fe             	mov    %rdi,%r14
    79fa:	48 89 c7             	mov    %rax,%rdi
    79fd:	41 ff d0             	call   *%r8
    7a00:	4c 89 f7             	mov    %r14,%rdi
    7a03:	41 8b 46 20          	mov    0x20(%r14),%eax
    7a07:	89 47 18             	mov    %eax,0x18(%rdi)
    7a0a:	48 85 db             	test   %rbx,%rbx
    7a0d:	74 0f                	je     7a1e <fwp_apply_release+0x5e>
    7a0f:	48 89 df             	mov    %rbx,%rdi
    7a12:	48 83 c4 08          	add    $0x8,%rsp
    7a16:	5b                   	pop    %rbx
    7a17:	41 5e                	pop    %r14
    7a19:	e9 42 29 00 00       	jmp    a360 <fwp_closure_drop>
    7a1e:	48 83 c4 08          	add    $0x8,%rsp
    7a22:	5b                   	pop    %rbx
    7a23:	41 5e                	pop    %r14
    7a25:	c3                   	ret
    7a26:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    7a2d:	00 00 00 

0000000000007a30 <fwp_apply_owned>:
    7a30:	55                   	push   %rbp
    7a31:	48 89 e5             	mov    %rsp,%rbp
    7a34:	41 57                	push   %r15
    7a36:	41 56                	push   %r14
    7a38:	41 55                	push   %r13
    7a3a:	41 54                	push   %r12
    7a3c:	53                   	push   %rbx
    7a3d:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    7a44:	48 89 d3             	mov    %rdx,%rbx
    7a47:	41 89 f5             	mov    %esi,%r13d
    7a4a:	48 8b 05 1f 44 01 00 	mov    0x1441f(%rip),%rax        # 1be70 <fwp_fns>
    7a51:	8b 17                	mov    (%rdi),%edx
    7a53:	48 89 d6             	mov    %rdx,%rsi
    7a56:	48 c1 e6 05          	shl    $0x5,%rsi
    7a5a:	48 8b 4c 30 18       	mov    0x18(%rax,%rsi,1),%rcx
    7a5f:	48 85 c9             	test   %rcx,%rcx
    7a62:	0f 84 fa 03 00 00    	je     7e62 <fwp_apply_owned+0x432>
    7a68:	4c 8d 14 30          	lea    (%rax,%rsi,1),%r10
    7a6c:	49 83 c2 18          	add    $0x18,%r10
    7a70:	49 89 fc             	mov    %rdi,%r12
    7a73:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7a7a:	84 00 00 00 00 00 
    7a80:	48 c1 e2 05          	shl    $0x5,%rdx
    7a84:	8b 04 10             	mov    (%rax,%rdx,1),%eax
    7a87:	45 8b 7c 24 04       	mov    0x4(%r12),%r15d
    7a8c:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
    7a93:	48 89 9d 70 ff ff ff 	mov    %rbx,-0x90(%rbp)
    7a9a:	48 89 8d 78 ff ff ff 	mov    %rcx,-0x88(%rbp)
    7aa1:	c7 45 80 00 00 00 00 	movl   $0x0,-0x80(%rbp)
    7aa8:	44 89 7d 84          	mov    %r15d,-0x7c(%rbp)
    7aac:	48 89 fa             	mov    %rdi,%rdx
    7aaf:	48 2b 15 02 38 01 00 	sub    0x13802(%rip),%rdx        # 1b2b8 <fwp_gc+0x1030>
    7ab6:	44 89 6d 88          	mov    %r13d,-0x78(%rbp)
    7aba:	48 8b 35 1f 38 01 00 	mov    0x1381f(%rip),%rsi        # 1b2e0 <fwp_gc+0x1058>
    7ac1:	48 c1 e6 10          	shl    $0x10,%rsi
    7ac5:	48 39 f2             	cmp    %rsi,%rdx
    7ac8:	73 76                	jae    7b40 <fwp_apply_owned+0x110>
    7aca:	48 8b 35 2f 38 01 00 	mov    0x1382f(%rip),%rsi        # 1b300 <fwp_gc+0x1078>
    7ad1:	49 89 d0             	mov    %rdx,%r8
    7ad4:	49 c1 e8 10          	shr    $0x10,%r8
    7ad8:	4d 69 c8 28 12 00 00 	imul   $0x1228,%r8,%r9
    7adf:	46 0f b6 04 0e       	movzbl (%rsi,%r9,1),%r8d
    7ae4:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    7aeb:	75 23                	jne    7b10 <fwp_apply_owned+0xe0>
    7aed:	41 80 f8 02          	cmp    $0x2,%r8b
    7af1:	75 1d                	jne    7b10 <fwp_apply_owned+0xe0>
    7af3:	4a 8d 14 0e          	lea    (%rsi,%r9,1),%rdx
    7af7:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    7afe:	80 3a 00             	cmpb   $0x0,(%rdx)
    7b01:	75 52                	jne    7b55 <fwp_apply_owned+0x125>
    7b03:	eb 3b                	jmp    7b40 <fwp_apply_owned+0x110>
    7b05:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    7b0c:	00 00 00 00 
    7b10:	41 80 f8 01          	cmp    $0x1,%r8b
    7b14:	75 2a                	jne    7b40 <fwp_apply_owned+0x110>
    7b16:	4e 8d 04 0e          	lea    (%rsi,%r9,1),%r8
    7b1a:	42 8b 74 0e 20       	mov    0x20(%rsi,%r9,1),%esi
    7b1f:	48 0f af d6          	imul   %rsi,%rdx
    7b23:	48 c1 ea 20          	shr    $0x20,%rdx
    7b27:	4c 01 c2             	add    %r8,%rdx
    7b2a:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    7b31:	80 3a 00             	cmpb   $0x0,(%rdx)
    7b34:	75 1f                	jne    7b55 <fwp_apply_owned+0x125>
    7b36:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    7b3d:	00 00 00 
    7b40:	48 83 79 18 00       	cmpq   $0x0,0x18(%rcx)
    7b45:	74 49                	je     7b90 <fwp_apply_owned+0x160>
    7b47:	4d 85 ff             	test   %r15,%r15
    7b4a:	75 09                	jne    7b55 <fwp_apply_owned+0x125>
    7b4c:	31 d2                	xor    %edx,%edx
    7b4e:	41 39 c5             	cmp    %eax,%r13d
    7b51:	72 02                	jb     7b55 <fwp_apply_owned+0x125>
    7b53:	76 3d                	jbe    7b92 <fwp_apply_owned+0x162>
    7b55:	48 ff 05 64 43 01 00 	incq   0x14364(%rip)        # 1bec0 <measured_scopes>
    7b5c:	48 8b 15 65 43 01 00 	mov    0x14365(%rip),%rdx        # 1bec8 <fwp_cleanups>
    7b63:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
    7b67:	48 8d 15 52 fe ff ff 	lea    -0x1ae(%rip),%rdx        # 79c0 <fwp_apply_release>
    7b6e:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
    7b72:	48 8d 95 68 ff ff ff 	lea    -0x98(%rbp),%rdx
    7b79:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
    7b7d:	48 8d 55 98          	lea    -0x68(%rbp),%rdx
    7b81:	48 89 15 40 43 01 00 	mov    %rdx,0x14340(%rip)        # 1bec8 <fwp_cleanups>
    7b88:	b2 01                	mov    $0x1,%dl
    7b8a:	eb 06                	jmp    7b92 <fwp_apply_owned+0x162>
    7b8c:	0f 1f 40 00          	nopl   0x0(%rax)
    7b90:	31 d2                	xor    %edx,%edx
    7b92:	47 8d 34 2f          	lea    (%r15,%r13,1),%r14d
    7b96:	41 39 c6             	cmp    %eax,%r14d
    7b99:	89 55 cc             	mov    %edx,-0x34(%rbp)
    7b9c:	0f 82 05 03 00 00    	jb     7ea7 <fwp_apply_owned+0x477>
    7ba2:	41 89 c6             	mov    %eax,%r14d
    7ba5:	45 29 fe             	sub    %r15d,%r14d
    7ba8:	45 89 f1             	mov    %r14d,%r9d
    7bab:	4d 85 ff             	test   %r15,%r15
    7bae:	4c 89 4d c0          	mov    %r9,-0x40(%rbp)
    7bb2:	44 89 75 b8          	mov    %r14d,-0x48(%rbp)
    7bb6:	75 18                	jne    7bd0 <fwp_apply_owned+0x1a0>
    7bb8:	85 c0                	test   %eax,%eax
    7bba:	74 14                	je     7bd0 <fwp_apply_owned+0x1a0>
    7bbc:	49 89 ff             	mov    %rdi,%r15
    7bbf:	44 89 75 80          	mov    %r14d,-0x80(%rbp)
    7bc3:	48 89 df             	mov    %rbx,%rdi
    7bc6:	ff 11                	call   *(%rcx)
    7bc8:	49 89 c4             	mov    %rax,%r12
    7bcb:	e9 29 02 00 00       	jmp    7df9 <fwp_apply_owned+0x3c9>
    7bd0:	4c 89 6d d0          	mov    %r13,-0x30(%rbp)
    7bd4:	48 89 65 90          	mov    %rsp,-0x70(%rbp)
    7bd8:	85 c0                	test   %eax,%eax
    7bda:	b9 01 00 00 00       	mov    $0x1,%ecx
    7bdf:	0f 45 c8             	cmovne %eax,%ecx
    7be2:	48 8d 0c cd 0f 00 00 	lea    0xf(,%rcx,8),%rcx
    7be9:	00 
    7bea:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
    7bee:	49 89 e5             	mov    %rsp,%r13
    7bf1:	49 29 cd             	sub    %rcx,%r13
    7bf4:	4c 89 ec             	mov    %r13,%rsp
    7bf7:	4d 85 ff             	test   %r15,%r15
    7bfa:	0f 84 d0 00 00 00    	je     7cd0 <fwp_apply_owned+0x2a0>
    7c00:	41 83 ff 04          	cmp    $0x4,%r15d
    7c04:	72 10                	jb     7c16 <fwp_apply_owned+0x1e6>
    7c06:	4c 89 e9             	mov    %r13,%rcx
    7c09:	4c 29 e1             	sub    %r12,%rcx
    7c0c:	48 83 c1 f8          	add    $0xfffffffffffffff8,%rcx
    7c10:	48 83 f9 20          	cmp    $0x20,%rcx
    7c14:	73 6d                	jae    7c83 <fwp_apply_owned+0x253>
    7c16:	31 c9                	xor    %ecx,%ecx
    7c18:	4c 89 fe             	mov    %r15,%rsi
    7c1b:	48 89 ca             	mov    %rcx,%rdx
    7c1e:	48 83 e6 03          	and    $0x3,%rsi
    7c22:	74 1e                	je     7c42 <fwp_apply_owned+0x212>
    7c24:	48 89 ca             	mov    %rcx,%rdx
    7c27:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    7c2e:	00 00 
    7c30:	4d 8b 44 d4 08       	mov    0x8(%r12,%rdx,8),%r8
    7c35:	4d 89 44 d5 00       	mov    %r8,0x0(%r13,%rdx,8)
    7c3a:	48 ff c2             	inc    %rdx
    7c3d:	48 ff ce             	dec    %rsi
    7c40:	75 ee                	jne    7c30 <fwp_apply_owned+0x200>
    7c42:	4c 29 f9             	sub    %r15,%rcx
    7c45:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    7c49:	0f 87 81 00 00 00    	ja     7cd0 <fwp_apply_owned+0x2a0>
    7c4f:	90                   	nop
    7c50:	49 8b 4c d4 08       	mov    0x8(%r12,%rdx,8),%rcx
    7c55:	49 89 4c d5 00       	mov    %rcx,0x0(%r13,%rdx,8)
    7c5a:	49 8b 4c d4 10       	mov    0x10(%r12,%rdx,8),%rcx
    7c5f:	49 89 4c d5 08       	mov    %rcx,0x8(%r13,%rdx,8)
    7c64:	49 8b 4c d4 18       	mov    0x18(%r12,%rdx,8),%rcx
    7c69:	49 89 4c d5 10       	mov    %rcx,0x10(%r13,%rdx,8)
    7c6e:	49 8b 4c d4 20       	mov    0x20(%r12,%rdx,8),%rcx
    7c73:	49 89 4c d5 18       	mov    %rcx,0x18(%r13,%rdx,8)
    7c78:	48 83 c2 04          	add    $0x4,%rdx
    7c7c:	49 39 d7             	cmp    %rdx,%r15
    7c7f:	75 cf                	jne    7c50 <fwp_apply_owned+0x220>
    7c81:	eb 4d                	jmp    7cd0 <fwp_apply_owned+0x2a0>
    7c83:	44 89 f9             	mov    %r15d,%ecx
    7c86:	83 e1 fc             	and    $0xfffffffc,%ecx
    7c89:	4a 8d 14 fd 00 00 00 	lea    0x0(,%r15,8),%rdx
    7c90:	00 
    7c91:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    7c95:	31 f6                	xor    %esi,%esi
    7c97:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    7c9e:	00 00 
    7ca0:	41 0f 10 44 34 08    	movups 0x8(%r12,%rsi,1),%xmm0
    7ca6:	41 0f 10 4c 34 18    	movups 0x18(%r12,%rsi,1),%xmm1
    7cac:	41 0f 29 44 35 00    	movaps %xmm0,0x0(%r13,%rsi,1)
    7cb2:	41 0f 29 4c 35 10    	movaps %xmm1,0x10(%r13,%rsi,1)
    7cb8:	48 83 c6 20          	add    $0x20,%rsi
    7cbc:	48 39 f2             	cmp    %rsi,%rdx
    7cbf:	75 df                	jne    7ca0 <fwp_apply_owned+0x270>
    7cc1:	4c 39 f9             	cmp    %r15,%rcx
    7cc4:	0f 85 4e ff ff ff    	jne    7c18 <fwp_apply_owned+0x1e8>
    7cca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    7cd0:	44 39 f8             	cmp    %r15d,%eax
    7cd3:	0f 84 f7 00 00 00    	je     7dd0 <fwp_apply_owned+0x3a0>
    7cd9:	41 83 fe 0a          	cmp    $0xa,%r14d
    7cdd:	0f 83 95 00 00 00    	jae    7d78 <fwp_apply_owned+0x348>
    7ce3:	31 c0                	xor    %eax,%eax
    7ce5:	4c 89 ca             	mov    %r9,%rdx
    7ce8:	48 89 c1             	mov    %rax,%rcx
    7ceb:	48 83 e2 03          	and    $0x3,%rdx
    7cef:	74 24                	je     7d15 <fwp_apply_owned+0x2e5>
    7cf1:	48 89 c1             	mov    %rax,%rcx
    7cf4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    7cfb:	00 00 00 00 00 
    7d00:	48 8b 34 cb          	mov    (%rbx,%rcx,8),%rsi
    7d04:	45 8d 04 0f          	lea    (%r15,%rcx,1),%r8d
    7d08:	4b 89 74 c5 00       	mov    %rsi,0x0(%r13,%r8,8)
    7d0d:	48 ff c1             	inc    %rcx
    7d10:	48 ff ca             	dec    %rdx
    7d13:	75 eb                	jne    7d00 <fwp_apply_owned+0x2d0>
    7d15:	4c 29 c8             	sub    %r9,%rax
    7d18:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    7d1c:	0f 87 ae 00 00 00    	ja     7dd0 <fwp_apply_owned+0x3a0>
    7d22:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7d29:	1f 84 00 00 00 00 00 
    7d30:	48 8b 04 cb          	mov    (%rbx,%rcx,8),%rax
    7d34:	41 8d 14 0f          	lea    (%r15,%rcx,1),%edx
    7d38:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    7d3d:	48 8b 44 cb 08       	mov    0x8(%rbx,%rcx,8),%rax
    7d42:	41 8d 14 0f          	lea    (%r15,%rcx,1),%edx
    7d46:	ff c2                	inc    %edx
    7d48:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    7d4d:	48 8b 44 cb 10       	mov    0x10(%rbx,%rcx,8),%rax
    7d52:	41 8d 54 0f 02       	lea    0x2(%r15,%rcx,1),%edx
    7d57:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    7d5c:	48 8b 44 cb 18       	mov    0x18(%rbx,%rcx,8),%rax
    7d61:	41 8d 14 0f          	lea    (%r15,%rcx,1),%edx
    7d65:	83 c2 03             	add    $0x3,%edx
    7d68:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    7d6d:	48 83 c1 04          	add    $0x4,%rcx
    7d71:	49 39 c9             	cmp    %rcx,%r9
    7d74:	75 ba                	jne    7d30 <fwp_apply_owned+0x300>
    7d76:	eb 58                	jmp    7dd0 <fwp_apply_owned+0x3a0>
    7d78:	49 8d 41 ff          	lea    -0x1(%r9),%rax
    7d7c:	89 c1                	mov    %eax,%ecx
    7d7e:	44 01 f9             	add    %r15d,%ecx
    7d81:	0f 82 5c ff ff ff    	jb     7ce3 <fwp_apply_owned+0x2b3>
    7d87:	48 c1 e8 20          	shr    $0x20,%rax
    7d8b:	b8 00 00 00 00       	mov    $0x0,%eax
    7d90:	0f 85 4f ff ff ff    	jne    7ce5 <fwp_apply_owned+0x2b5>
    7d96:	44 89 c8             	mov    %r9d,%eax
    7d99:	83 e0 fc             	and    $0xfffffffc,%eax
    7d9c:	31 c9                	xor    %ecx,%ecx
    7d9e:	66 90                	xchg   %ax,%ax
    7da0:	0f 10 04 cb          	movups (%rbx,%rcx,8),%xmm0
    7da4:	0f 10 4c cb 10       	movups 0x10(%rbx,%rcx,8),%xmm1
    7da9:	41 8d 14 0f          	lea    (%r15,%rcx,1),%edx
    7dad:	41 0f 11 44 d5 00    	movups %xmm0,0x0(%r13,%rdx,8)
    7db3:	41 0f 11 4c d5 10    	movups %xmm1,0x10(%r13,%rdx,8)
    7db9:	48 83 c1 04          	add    $0x4,%rcx
    7dbd:	48 39 c8             	cmp    %rcx,%rax
    7dc0:	75 de                	jne    7da0 <fwp_apply_owned+0x370>
    7dc2:	4c 39 c8             	cmp    %r9,%rax
    7dc5:	0f 85 1a ff ff ff    	jne    7ce5 <fwp_apply_owned+0x2b5>
    7dcb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7dd0:	49 8b 02             	mov    (%r10),%rax
    7dd3:	49 89 ff             	mov    %rdi,%r15
    7dd6:	be 01 00 00 00       	mov    $0x1,%esi
    7ddb:	4d 89 d4             	mov    %r10,%r12
    7dde:	ff 50 08             	call   *0x8(%rax)
    7de1:	44 89 75 80          	mov    %r14d,-0x80(%rbp)
    7de5:	49 8b 04 24          	mov    (%r12),%rax
    7de9:	4c 89 ef             	mov    %r13,%rdi
    7dec:	ff 10                	call   *(%rax)
    7dee:	49 89 c4             	mov    %rax,%r12
    7df1:	48 8b 65 90          	mov    -0x70(%rbp),%rsp
    7df5:	4c 8b 6d d0          	mov    -0x30(%rbp),%r13
    7df9:	80 7d cc 00          	cmpb   $0x0,-0x34(%rbp)
    7dfd:	4c 89 ff             	mov    %r15,%rdi
    7e00:	74 1c                	je     7e1e <fwp_apply_owned+0x3ee>
    7e02:	48 8d 45 98          	lea    -0x68(%rbp),%rax
    7e06:	48 39 05 bb 40 01 00 	cmp    %rax,0x140bb(%rip)        # 1bec8 <fwp_cleanups>
    7e0d:	0f 85 74 04 00 00    	jne    8287 <fwp_apply_owned+0x857>
    7e13:	48 8b 45 98          	mov    -0x68(%rbp),%rax
    7e17:	48 89 05 aa 40 01 00 	mov    %rax,0x140aa(%rip)        # 1bec8 <fwp_cleanups>
    7e1e:	e8 3d 25 00 00       	call   a360 <fwp_closure_drop>
    7e23:	44 2b 6d b8          	sub    -0x48(%rbp),%r13d
    7e27:	0f 84 48 04 00 00    	je     8275 <fwp_apply_owned+0x845>
    7e2d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
    7e31:	48 8d 1c c3          	lea    (%rbx,%rax,8),%rbx
    7e35:	48 8b 05 34 40 01 00 	mov    0x14034(%rip),%rax        # 1be70 <fwp_fns>
    7e3c:	41 8b 14 24          	mov    (%r12),%edx
    7e40:	48 89 d1             	mov    %rdx,%rcx
    7e43:	48 c1 e1 05          	shl    $0x5,%rcx
    7e47:	4c 8d 14 08          	lea    (%rax,%rcx,1),%r10
    7e4b:	49 83 c2 18          	add    $0x18,%r10
    7e4f:	48 8b 4c 08 18       	mov    0x18(%rax,%rcx,1),%rcx
    7e54:	4c 89 e7             	mov    %r12,%rdi
    7e57:	48 85 c9             	test   %rcx,%rcx
    7e5a:	0f 85 20 fc ff ff    	jne    7a80 <fwp_apply_owned+0x50>
    7e60:	eb 03                	jmp    7e65 <fwp_apply_owned+0x435>
    7e62:	49 89 fc             	mov    %rdi,%r12
    7e65:	4c 89 e7             	mov    %r12,%rdi
    7e68:	e8 13 eb ff ff       	call   6980 <fwp_rc_share>
    7e6d:	45 85 ed             	test   %r13d,%r13d
    7e70:	74 1f                	je     7e91 <fwp_apply_owned+0x461>
    7e72:	45 89 ee             	mov    %r13d,%r14d
    7e75:	45 31 ff             	xor    %r15d,%r15d
    7e78:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    7e7f:	00 
    7e80:	4a 8b 3c fb          	mov    (%rbx,%r15,8),%rdi
    7e84:	e8 f7 ea ff ff       	call   6980 <fwp_rc_share>
    7e89:	49 ff c7             	inc    %r15
    7e8c:	4d 39 fe             	cmp    %r15,%r14
    7e8f:	75 ef                	jne    7e80 <fwp_apply_owned+0x450>
    7e91:	4c 89 e7             	mov    %r12,%rdi
    7e94:	44 89 ee             	mov    %r13d,%esi
    7e97:	48 89 da             	mov    %rbx,%rdx
    7e9a:	e8 c1 f5 ff ff       	call   7460 <fwp_apply>
    7e9f:	49 89 c4             	mov    %rax,%r12
    7ea2:	e9 ce 03 00 00       	jmp    8275 <fwp_apply_owned+0x845>
    7ea7:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    7eab:	4c 89 6d d0          	mov    %r13,-0x30(%rbp)
    7eaf:	44 89 f0             	mov    %r14d,%eax
    7eb2:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    7eb9:	00 
    7eba:	4c 89 55 c0          	mov    %r10,-0x40(%rbp)
    7ebe:	e8 9d 29 00 00       	call   a860 <fwp_alloc_init>
    7ec3:	4c 8b 55 c0          	mov    -0x40(%rbp),%r10
    7ec7:	49 89 c5             	mov    %rax,%r13
    7eca:	41 8b 04 24          	mov    (%r12),%eax
    7ece:	41 89 45 00          	mov    %eax,0x0(%r13)
    7ed2:	45 89 75 04          	mov    %r14d,0x4(%r13)
    7ed6:	4c 89 e8             	mov    %r13,%rax
    7ed9:	48 2b 05 d8 33 01 00 	sub    0x133d8(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    7ee0:	48 8b 0d f9 33 01 00 	mov    0x133f9(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    7ee7:	48 c1 e1 10          	shl    $0x10,%rcx
    7eeb:	48 39 c8             	cmp    %rcx,%rax
    7eee:	73 73                	jae    7f63 <fwp_apply_owned+0x533>
    7ef0:	48 8b 0d 09 34 01 00 	mov    0x13409(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    7ef7:	48 89 c2             	mov    %rax,%rdx
    7efa:	48 c1 ea 10          	shr    $0x10,%rdx
    7efe:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    7f05:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    7f09:	48 25 ff ff 00 00    	and    $0xffff,%rax
    7f0f:	75 1d                	jne    7f2e <fwp_apply_owned+0x4fe>
    7f11:	40 80 fe 02          	cmp    $0x2,%sil
    7f15:	75 17                	jne    7f2e <fwp_apply_owned+0x4fe>
    7f17:	4c 8d 34 11          	lea    (%rcx,%rdx,1),%r14
    7f1b:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    7f22:	41 80 3e ff          	cmpb   $0xff,(%r14)
    7f26:	74 2d                	je     7f55 <fwp_apply_owned+0x525>
    7f28:	41 c6 06 01          	movb   $0x1,(%r14)
    7f2c:	eb 35                	jmp    7f63 <fwp_apply_owned+0x533>
    7f2e:	40 80 fe 01          	cmp    $0x1,%sil
    7f32:	75 2f                	jne    7f63 <fwp_apply_owned+0x533>
    7f34:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    7f38:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    7f3c:	48 0f af c1          	imul   %rcx,%rax
    7f40:	48 c1 e8 20          	shr    $0x20,%rax
    7f44:	4c 8d 34 30          	lea    (%rax,%rsi,1),%r14
    7f48:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    7f4f:	41 80 3e ff          	cmpb   $0xff,(%r14)
    7f53:	75 d3                	jne    7f28 <fwp_apply_owned+0x4f8>
    7f55:	4c 89 f7             	mov    %r14,%rdi
    7f58:	e8 53 ec ff ff       	call   6bb0 <fwp_rc_forget_slot>
    7f5d:	4c 8b 55 c0          	mov    -0x40(%rbp),%r10
    7f61:	eb c5                	jmp    7f28 <fwp_apply_owned+0x4f8>
    7f63:	4c 89 6d b0          	mov    %r13,-0x50(%rbp)
    7f67:	48 ff 05 52 3f 01 00 	incq   0x13f52(%rip)        # 1bec0 <measured_scopes>
    7f6e:	48 8b 05 53 3f 01 00 	mov    0x13f53(%rip),%rax        # 1bec8 <fwp_cleanups>
    7f75:	48 89 85 50 ff ff ff 	mov    %rax,-0xb0(%rbp)
    7f7c:	48 8d 05 1d 2a 00 00 	lea    0x2a1d(%rip),%rax        # a9a0 <fwp_rc_cleanup_cell>
    7f83:	48 89 85 58 ff ff ff 	mov    %rax,-0xa8(%rbp)
    7f8a:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
    7f8e:	48 89 85 60 ff ff ff 	mov    %rax,-0xa0(%rbp)
    7f95:	4c 8d b5 50 ff ff ff 	lea    -0xb0(%rbp),%r14
    7f9c:	4c 89 35 25 3f 01 00 	mov    %r14,0x13f25(%rip)        # 1bec8 <fwp_cleanups>
    7fa3:	4d 85 ff             	test   %r15,%r15
    7fa6:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
    7faa:	0f 84 c1 00 00 00    	je     8071 <fwp_apply_owned+0x641>
    7fb0:	31 c0                	xor    %eax,%eax
    7fb2:	41 83 ff 06          	cmp    $0x6,%r15d
    7fb6:	72 4e                	jb     8006 <fwp_apply_owned+0x5d6>
    7fb8:	4c 89 e9             	mov    %r13,%rcx
    7fbb:	4c 29 e1             	sub    %r12,%rcx
    7fbe:	48 83 f9 20          	cmp    $0x20,%rcx
    7fc2:	72 42                	jb     8006 <fwp_apply_owned+0x5d6>
    7fc4:	44 89 f8             	mov    %r15d,%eax
    7fc7:	83 e0 fc             	and    $0xfffffffc,%eax
    7fca:	4a 8d 0c fd 00 00 00 	lea    0x0(,%r15,8),%rcx
    7fd1:	00 
    7fd2:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    7fd6:	31 d2                	xor    %edx,%edx
    7fd8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    7fdf:	00 
    7fe0:	41 0f 10 44 14 08    	movups 0x8(%r12,%rdx,1),%xmm0
    7fe6:	41 0f 10 4c 14 18    	movups 0x18(%r12,%rdx,1),%xmm1
    7fec:	41 0f 11 44 15 08    	movups %xmm0,0x8(%r13,%rdx,1)
    7ff2:	41 0f 11 4c 15 18    	movups %xmm1,0x18(%r13,%rdx,1)
    7ff8:	48 83 c2 20          	add    $0x20,%rdx
    7ffc:	48 39 d1             	cmp    %rdx,%rcx
    7fff:	75 df                	jne    7fe0 <fwp_apply_owned+0x5b0>
    8001:	4c 39 f8             	cmp    %r15,%rax
    8004:	74 6b                	je     8071 <fwp_apply_owned+0x641>
    8006:	4c 89 fa             	mov    %r15,%rdx
    8009:	48 89 c1             	mov    %rax,%rcx
    800c:	48 83 e2 03          	and    $0x3,%rdx
    8010:	74 20                	je     8032 <fwp_apply_owned+0x602>
    8012:	48 89 c1             	mov    %rax,%rcx
    8015:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    801c:	00 00 00 00 
    8020:	49 8b 74 cc 08       	mov    0x8(%r12,%rcx,8),%rsi
    8025:	49 89 74 cd 08       	mov    %rsi,0x8(%r13,%rcx,8)
    802a:	48 ff c1             	inc    %rcx
    802d:	48 ff ca             	dec    %rdx
    8030:	75 ee                	jne    8020 <fwp_apply_owned+0x5f0>
    8032:	4c 29 f8             	sub    %r15,%rax
    8035:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    8039:	77 36                	ja     8071 <fwp_apply_owned+0x641>
    803b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8040:	49 8b 44 cc 08       	mov    0x8(%r12,%rcx,8),%rax
    8045:	49 89 44 cd 08       	mov    %rax,0x8(%r13,%rcx,8)
    804a:	49 8b 44 cc 10       	mov    0x10(%r12,%rcx,8),%rax
    804f:	49 89 44 cd 10       	mov    %rax,0x10(%r13,%rcx,8)
    8054:	49 8b 44 cc 18       	mov    0x18(%r12,%rcx,8),%rax
    8059:	49 89 44 cd 18       	mov    %rax,0x18(%r13,%rcx,8)
    805e:	49 8b 44 cc 20       	mov    0x20(%r12,%rcx,8),%rax
    8063:	49 89 44 cd 20       	mov    %rax,0x20(%r13,%rcx,8)
    8068:	48 83 c1 04          	add    $0x4,%rcx
    806c:	49 39 cf             	cmp    %rcx,%r15
    806f:	75 cf                	jne    8040 <fwp_apply_owned+0x610>
    8071:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
    8075:	0f 84 8b 00 00 00    	je     8106 <fwp_apply_owned+0x6d6>
    807b:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
    807f:	89 c8                	mov    %ecx,%eax
    8081:	83 f9 14             	cmp    $0x14,%ecx
    8084:	0f 83 f4 00 00 00    	jae    817e <fwp_apply_owned+0x74e>
    808a:	31 c9                	xor    %ecx,%ecx
    808c:	48 89 c6             	mov    %rax,%rsi
    808f:	48 89 ca             	mov    %rcx,%rdx
    8092:	48 83 e6 03          	and    $0x3,%rsi
    8096:	74 1d                	je     80b5 <fwp_apply_owned+0x685>
    8098:	48 89 ca             	mov    %rcx,%rdx
    809b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    80a0:	4c 8b 0c d3          	mov    (%rbx,%rdx,8),%r9
    80a4:	45 8d 04 17          	lea    (%r15,%rdx,1),%r8d
    80a8:	4f 89 4c c5 08       	mov    %r9,0x8(%r13,%r8,8)
    80ad:	48 ff c2             	inc    %rdx
    80b0:	48 ff ce             	dec    %rsi
    80b3:	75 eb                	jne    80a0 <fwp_apply_owned+0x670>
    80b5:	48 29 c1             	sub    %rax,%rcx
    80b8:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    80bc:	77 48                	ja     8106 <fwp_apply_owned+0x6d6>
    80be:	66 90                	xchg   %ax,%ax
    80c0:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    80c4:	41 8d 34 17          	lea    (%r15,%rdx,1),%esi
    80c8:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    80cd:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    80d2:	41 8d 34 17          	lea    (%r15,%rdx,1),%esi
    80d6:	ff c6                	inc    %esi
    80d8:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    80dd:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    80e2:	41 8d 74 17 02       	lea    0x2(%r15,%rdx,1),%esi
    80e7:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    80ec:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    80f1:	41 8d 34 17          	lea    (%r15,%rdx,1),%esi
    80f5:	83 c6 03             	add    $0x3,%esi
    80f8:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    80fd:	48 83 c2 04          	add    $0x4,%rdx
    8101:	48 39 d0             	cmp    %rdx,%rax
    8104:	75 ba                	jne    80c0 <fwp_apply_owned+0x690>
    8106:	49 8b 02             	mov    (%r10),%rax
    8109:	be 01 00 00 00       	mov    $0x1,%esi
    810e:	ff 50 08             	call   *0x8(%rax)
    8111:	4c 89 e8             	mov    %r13,%rax
    8114:	48 2b 05 9d 31 01 00 	sub    0x1319d(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    811b:	48 8b 0d be 31 01 00 	mov    0x131be(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    8122:	48 c1 e1 10          	shl    $0x10,%rcx
    8126:	48 39 c8             	cmp    %rcx,%rax
    8129:	0f 83 fa 00 00 00    	jae    8229 <fwp_apply_owned+0x7f9>
    812f:	48 8b 0d ca 31 01 00 	mov    0x131ca(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    8136:	48 89 c2             	mov    %rax,%rdx
    8139:	48 c1 ea 10          	shr    $0x10,%rdx
    813d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    8144:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    8148:	48 25 ff ff 00 00    	and    $0xffff,%rax
    814e:	0f 85 9c 00 00 00    	jne    81f0 <fwp_apply_owned+0x7c0>
    8154:	40 80 fe 02          	cmp    $0x2,%sil
    8158:	0f 85 92 00 00 00    	jne    81f0 <fwp_apply_owned+0x7c0>
    815e:	4c 8d 24 11          	lea    (%rcx,%rdx,1),%r12
    8162:	49 81 c4 28 02 00 00 	add    $0x228,%r12
    8169:	41 80 3c 24 ff       	cmpb   $0xff,(%r12)
    816e:	0f 84 a8 00 00 00    	je     821c <fwp_apply_owned+0x7ec>
    8174:	41 c6 04 24 01       	movb   $0x1,(%r12)
    8179:	e9 ab 00 00 00       	jmp    8229 <fwp_apply_owned+0x7f9>
    817e:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    8182:	31 c9                	xor    %ecx,%ecx
    8184:	89 d6                	mov    %edx,%esi
    8186:	44 01 fe             	add    %r15d,%esi
    8189:	0f 82 fd fe ff ff    	jb     808c <fwp_apply_owned+0x65c>
    818f:	48 c1 ea 20          	shr    $0x20,%rdx
    8193:	0f 85 f3 fe ff ff    	jne    808c <fwp_apply_owned+0x65c>
    8199:	4a 8d 0c fd 00 00 00 	lea    0x0(,%r15,8),%rcx
    81a0:	00 
    81a1:	4c 01 e9             	add    %r13,%rcx
    81a4:	48 29 d9             	sub    %rbx,%rcx
    81a7:	48 83 c1 08          	add    $0x8,%rcx
    81ab:	48 83 f9 20          	cmp    $0x20,%rcx
    81af:	0f 82 d5 fe ff ff    	jb     808a <fwp_apply_owned+0x65a>
    81b5:	89 c1                	mov    %eax,%ecx
    81b7:	83 e1 fc             	and    $0xfffffffc,%ecx
    81ba:	31 d2                	xor    %edx,%edx
    81bc:	0f 1f 40 00          	nopl   0x0(%rax)
    81c0:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    81c4:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    81c9:	41 8d 34 17          	lea    (%r15,%rdx,1),%esi
    81cd:	41 0f 11 44 f5 08    	movups %xmm0,0x8(%r13,%rsi,8)
    81d3:	41 0f 11 4c f5 18    	movups %xmm1,0x18(%r13,%rsi,8)
    81d9:	48 83 c2 04          	add    $0x4,%rdx
    81dd:	48 39 d1             	cmp    %rdx,%rcx
    81e0:	75 de                	jne    81c0 <fwp_apply_owned+0x790>
    81e2:	48 39 c1             	cmp    %rax,%rcx
    81e5:	0f 85 a1 fe ff ff    	jne    808c <fwp_apply_owned+0x65c>
    81eb:	e9 16 ff ff ff       	jmp    8106 <fwp_apply_owned+0x6d6>
    81f0:	40 80 fe 01          	cmp    $0x1,%sil
    81f4:	75 33                	jne    8229 <fwp_apply_owned+0x7f9>
    81f6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    81fa:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    81fe:	48 0f af c1          	imul   %rcx,%rax
    8202:	48 c1 e8 20          	shr    $0x20,%rax
    8206:	4c 8d 24 30          	lea    (%rax,%rsi,1),%r12
    820a:	49 81 c4 28 02 00 00 	add    $0x228,%r12
    8211:	41 80 3c 24 ff       	cmpb   $0xff,(%r12)
    8216:	0f 85 58 ff ff ff    	jne    8174 <fwp_apply_owned+0x744>
    821c:	4c 89 e7             	mov    %r12,%rdi
    821f:	e8 8c e9 ff ff       	call   6bb0 <fwp_rc_forget_slot>
    8224:	e9 4b ff ff ff       	jmp    8174 <fwp_apply_owned+0x744>
    8229:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    822d:	89 45 80             	mov    %eax,-0x80(%rbp)
    8230:	48 c7 45 b0 00 00 00 	movq   $0x0,-0x50(%rbp)
    8237:	00 
    8238:	4c 39 35 89 3c 01 00 	cmp    %r14,0x13c89(%rip)        # 1bec8 <fwp_cleanups>
    823f:	75 46                	jne    8287 <fwp_apply_owned+0x857>
    8241:	48 8b 85 50 ff ff ff 	mov    -0xb0(%rbp),%rax
    8248:	48 89 05 79 3c 01 00 	mov    %rax,0x13c79(%rip)        # 1bec8 <fwp_cleanups>
    824f:	80 7d cc 00          	cmpb   $0x0,-0x34(%rbp)
    8253:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
    8257:	74 14                	je     826d <fwp_apply_owned+0x83d>
    8259:	48 8d 4d 98          	lea    -0x68(%rbp),%rcx
    825d:	48 39 c8             	cmp    %rcx,%rax
    8260:	75 25                	jne    8287 <fwp_apply_owned+0x857>
    8262:	48 8b 45 98          	mov    -0x68(%rbp),%rax
    8266:	48 89 05 5b 3c 01 00 	mov    %rax,0x13c5b(%rip)        # 1bec8 <fwp_cleanups>
    826d:	e8 ee 20 00 00       	call   a360 <fwp_closure_drop>
    8272:	4d 89 ec             	mov    %r13,%r12
    8275:	4c 89 e0             	mov    %r12,%rax
    8278:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    827c:	5b                   	pop    %rbx
    827d:	41 5c                	pop    %r12
    827f:	41 5d                	pop    %r13
    8281:	41 5e                	pop    %r14
    8283:	41 5f                	pop    %r15
    8285:	5d                   	pop    %rbp
    8286:	c3                   	ret
    8287:	e8 e4 ad ff ff       	call   3070 <abort@plt>
    828c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000008290 <fwp_alloc>:
    8290:	53                   	push   %rbx
    8291:	48 ff 05 10 3c 01 00 	incq   0x13c10(%rip)        # 1bea8 <measured_calls>
    8298:	48 01 3d 11 3c 01 00 	add    %rdi,0x13c11(%rip)        # 1beb0 <measured_bytes>
    829f:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    82a6:	77 61                	ja     8309 <fwp_alloc+0x79>
    82a8:	48 8d 4f 0f          	lea    0xf(%rdi),%rcx
    82ac:	48 c1 e9 04          	shr    $0x4,%rcx
    82b0:	48 8d 05 d1 1f 01 00 	lea    0x11fd1(%rip),%rax        # 1a288 <fwp_gc>
    82b7:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    82be:	00 
    82bf:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    82c6:	48 29 15 bb 1f 01 00 	sub    %rdx,0x11fbb(%rip)        # 1a288 <fwp_gc>
    82cd:	78 3a                	js     8309 <fwp_alloc+0x79>
    82cf:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    82d3:	48 8d 34 c8          	lea    (%rax,%rcx,8),%rsi
    82d7:	48 81 c6 88 07 00 00 	add    $0x788,%rsi
    82de:	48 8b 1e             	mov    (%rsi),%rbx
    82e1:	48 85 db             	test   %rbx,%rbx
    82e4:	74 0b                	je     82f1 <fwp_alloc+0x61>
    82e6:	48 8b 03             	mov    (%rbx),%rax
    82e9:	48 f7 d0             	not    %rax
    82ec:	48 89 06             	mov    %rax,(%rsi)
    82ef:	eb 31                	jmp    8322 <fwp_alloc+0x92>
    82f1:	48 8b 9c c8 90 07 00 	mov    0x790(%rax,%rcx,8),%rbx
    82f8:	00 
    82f9:	48 8b b4 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%rsi
    8300:	00 
    8301:	48 29 de             	sub    %rbx,%rsi
    8304:	48 39 d6             	cmp    %rdx,%rsi
    8307:	73 08                	jae    8311 <fwp_alloc+0x81>
    8309:	be 02 00 00 00       	mov    $0x2,%esi
    830e:	5b                   	pop    %rbx
    830f:	eb 2f                	jmp    8340 <fwp_gc_alloc_slow>
    8311:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    8315:	48 05 90 07 00 00    	add    $0x790,%rax
    831b:	48 8d 0c 13          	lea    (%rbx,%rdx,1),%rcx
    831f:	48 89 08             	mov    %rcx,(%rax)
    8322:	48 89 df             	mov    %rbx,%rdi
    8325:	31 f6                	xor    %esi,%esi
    8327:	e8 e4 ae ff ff       	call   3210 <memset@plt>
    832c:	48 89 d8             	mov    %rbx,%rax
    832f:	5b                   	pop    %rbx
    8330:	c3                   	ret
    8331:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8338:	0f 1f 84 00 00 00 00 
    833f:	00 

0000000000008340 <fwp_gc_alloc_slow>:
    8340:	55                   	push   %rbp
    8341:	41 57                	push   %r15
    8343:	41 56                	push   %r14
    8345:	41 54                	push   %r12
    8347:	53                   	push   %rbx
    8348:	89 f5                	mov    %esi,%ebp
    834a:	48 89 fb             	mov    %rdi,%rbx
    834d:	83 3d 20 2f 01 00 00 	cmpl   $0x0,0x12f20(%rip)        # 1b274 <fwp_gc+0xfec>
    8354:	74 1b                	je     8371 <fwp_gc_alloc_slow+0x31>
    8356:	48 81 fb 01 40 00 00 	cmp    $0x4001,%rbx
    835d:	72 20                	jb     837f <fwp_gc_alloc_slow+0x3f>
    835f:	48 89 df             	mov    %rbx,%rdi
    8362:	89 ee                	mov    %ebp,%esi
    8364:	5b                   	pop    %rbx
    8365:	41 5c                	pop    %r12
    8367:	41 5e                	pop    %r14
    8369:	41 5f                	pop    %r15
    836b:	5d                   	pop    %rbp
    836c:	e9 9f 04 00 00       	jmp    8810 <fwp_gc_alloc_big>
    8371:	e8 ba 00 00 00       	call   8430 <fwp_gc_init>
    8376:	48 81 fb 01 40 00 00 	cmp    $0x4001,%rbx
    837d:	73 e0                	jae    835f <fwp_gc_alloc_slow+0x1f>
    837f:	48 8d 43 0f          	lea    0xf(%rbx),%rax
    8383:	48 c1 e8 04          	shr    $0x4,%rax
    8387:	4c 8d 25 fa 1e 01 00 	lea    0x11efa(%rip),%r12        # 1a288 <fwp_gc>
    838e:	46 0f b6 bc 20 e8 0b 	movzbl 0xbe8(%rax,%r12,1),%r15d
    8395:	00 00 
    8397:	47 8b b4 bc 48 0b 00 	mov    0xb48(%r12,%r15,4),%r14d
    839e:	00 
    839f:	48 83 3d e1 1e 01 00 	cmpq   $0x0,0x11ee1(%rip)        # 1a288 <fwp_gc>
    83a6:	00 
    83a7:	79 05                	jns    83ae <fwp_gc_alloc_slow+0x6e>
    83a9:	e8 02 06 00 00       	call   89b0 <fwp_gc_spent>
    83ae:	89 e8                	mov    %ebp,%eax
    83b0:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    83b7:	49 01 c4             	add    %rax,%r12
    83ba:	4b 8d 0c 7f          	lea    (%r15,%r15,2),%rcx
    83be:	49 8d 04 cc          	lea    (%r12,%rcx,8),%rax
    83c2:	48 83 c0 08          	add    $0x8,%rax
    83c6:	49 8b 7c cc 08       	mov    0x8(%r12,%rcx,8),%rdi
    83cb:	48 85 ff             	test   %rdi,%rdi
    83ce:	74 08                	je     83d8 <fwp_gc_alloc_slow+0x98>
    83d0:	48 8b 0f             	mov    (%rdi),%rcx
    83d3:	48 f7 d1             	not    %rcx
    83d6:	eb 30                	jmp    8408 <fwp_gc_alloc_slow+0xc8>
    83d8:	49 8b 7c cc 10       	mov    0x10(%r12,%rcx,8),%rdi
    83dd:	49 8b 54 cc 18       	mov    0x18(%r12,%rcx,8),%rdx
    83e2:	48 29 fa             	sub    %rdi,%rdx
    83e5:	4c 39 f2             	cmp    %r14,%rdx
    83e8:	73 12                	jae    83fc <fwp_gc_alloc_slow+0xbc>
    83ea:	48 89 c7             	mov    %rax,%rdi
    83ed:	44 89 fe             	mov    %r15d,%esi
    83f0:	89 ea                	mov    %ebp,%edx
    83f2:	e8 89 06 00 00       	call   8a80 <fwp_gc_refill>
    83f7:	48 89 c7             	mov    %rax,%rdi
    83fa:	eb 0f                	jmp    840b <fwp_gc_alloc_slow+0xcb>
    83fc:	49 8d 04 cc          	lea    (%r12,%rcx,8),%rax
    8400:	48 83 c0 10          	add    $0x10,%rax
    8404:	4a 8d 0c 37          	lea    (%rdi,%r14,1),%rcx
    8408:	48 89 08             	mov    %rcx,(%rax)
    840b:	83 fd 01             	cmp    $0x1,%ebp
    840e:	4c 0f 44 f3          	cmove  %rbx,%r14
    8412:	31 f6                	xor    %esi,%esi
    8414:	4c 89 f2             	mov    %r14,%rdx
    8417:	5b                   	pop    %rbx
    8418:	41 5c                	pop    %r12
    841a:	41 5e                	pop    %r14
    841c:	41 5f                	pop    %r15
    841e:	5d                   	pop    %rbp
    841f:	e9 ec ad ff ff       	jmp    3210 <memset@plt>
    8424:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    842b:	00 00 00 00 00 

0000000000008430 <fwp_gc_init>:
    8430:	53                   	push   %rbx
    8431:	c7 05 39 2e 01 00 01 	movl   $0x1,0x12e39(%rip)        # 1b274 <fwp_gc+0xfec>
    8438:	00 00 00 
    843b:	0f 28 05 de cb 00 00 	movaps 0xcbde(%rip),%xmm0        # 15020 <_IO_stdin_used+0x20>
    8442:	0f 11 05 87 29 01 00 	movups %xmm0,0x12987(%rip)        # 1add0 <fwp_gc+0xb48>
    8449:	0f 28 05 e0 cb 00 00 	movaps 0xcbe0(%rip),%xmm0        # 15030 <_IO_stdin_used+0x30>
    8450:	0f 11 05 89 29 01 00 	movups %xmm0,0x12989(%rip)        # 1ade0 <fwp_gc+0xb58>
    8457:	0f 28 05 e2 cb 00 00 	movaps 0xcbe2(%rip),%xmm0        # 15040 <_IO_stdin_used+0x40>
    845e:	0f 11 05 8b 29 01 00 	movups %xmm0,0x1298b(%rip)        # 1adf0 <fwp_gc+0xb68>
    8465:	0f 28 05 e4 cb 00 00 	movaps 0xcbe4(%rip),%xmm0        # 15050 <_IO_stdin_used+0x50>
    846c:	0f 11 05 8d 29 01 00 	movups %xmm0,0x1298d(%rip)        # 1ae00 <fwp_gc+0xb78>
    8473:	0f 28 05 e6 cb 00 00 	movaps 0xcbe6(%rip),%xmm0        # 15060 <_IO_stdin_used+0x60>
    847a:	0f 11 05 8f 29 01 00 	movups %xmm0,0x1298f(%rip)        # 1ae10 <fwp_gc+0xb88>
    8481:	0f 28 05 e8 cb 00 00 	movaps 0xcbe8(%rip),%xmm0        # 15070 <_IO_stdin_used+0x70>
    8488:	0f 11 05 91 29 01 00 	movups %xmm0,0x12991(%rip)        # 1ae20 <fwp_gc+0xb98>
    848f:	0f 28 05 ea cb 00 00 	movaps 0xcbea(%rip),%xmm0        # 15080 <_IO_stdin_used+0x80>
    8496:	0f 11 05 93 29 01 00 	movups %xmm0,0x12993(%rip)        # 1ae30 <fwp_gc+0xba8>
    849d:	0f 28 05 ec cb 00 00 	movaps 0xcbec(%rip),%xmm0        # 15090 <_IO_stdin_used+0x90>
    84a4:	0f 11 05 95 29 01 00 	movups %xmm0,0x12995(%rip)        # 1ae40 <fwp_gc+0xbb8>
    84ab:	0f 28 05 ee cb 00 00 	movaps 0xcbee(%rip),%xmm0        # 150a0 <_IO_stdin_used+0xa0>
    84b2:	0f 11 05 97 29 01 00 	movups %xmm0,0x12997(%rip)        # 1ae50 <fwp_gc+0xbc8>
    84b9:	0f 28 05 f0 cb 00 00 	movaps 0xcbf0(%rip),%xmm0        # 150b0 <_IO_stdin_used+0xb0>
    84c0:	0f 11 05 99 29 01 00 	movups %xmm0,0x12999(%rip)        # 1ae60 <fwp_gc+0xbd8>
    84c7:	31 c9                	xor    %ecx,%ecx
    84c9:	48 8d 05 b8 1d 01 00 	lea    0x11db8(%rip),%rax        # 1a288 <fwp_gc>
    84d0:	31 d2                	xor    %edx,%edx
    84d2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    84d9:	1f 84 00 00 00 00 00 
    84e0:	89 d6                	mov    %edx,%esi
    84e2:	c1 e6 04             	shl    $0x4,%esi
    84e5:	48 ff c9             	dec    %rcx
    84e8:	48 89 cf             	mov    %rcx,%rdi
    84eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    84f0:	48 89 f9             	mov    %rdi,%rcx
    84f3:	48 ff c7             	inc    %rdi
    84f6:	3b b4 88 4c 0b 00 00 	cmp    0xb4c(%rax,%rcx,4),%esi
    84fd:	77 f1                	ja     84f0 <fwp_gc_init+0xc0>
    84ff:	40 88 bc 02 e8 0b 00 	mov    %dil,0xbe8(%rdx,%rax,1)
    8506:	00 
    8507:	48 89 d6             	mov    %rdx,%rsi
    850a:	48 83 ce 01          	or     $0x1,%rsi
    850e:	48 81 fe 01 04 00 00 	cmp    $0x401,%rsi
    8515:	74 26                	je     853d <fwp_gc_init+0x10d>
    8517:	89 f7                	mov    %esi,%edi
    8519:	c1 e7 04             	shl    $0x4,%edi
    851c:	0f 1f 40 00          	nopl   0x0(%rax)
    8520:	49 89 c8             	mov    %rcx,%r8
    8523:	48 ff c1             	inc    %rcx
    8526:	42 3b bc 80 4c 0b 00 	cmp    0xb4c(%rax,%r8,4),%edi
    852d:	00 
    852e:	77 f0                	ja     8520 <fwp_gc_init+0xf0>
    8530:	88 8c 06 e8 0b 00 00 	mov    %cl,0xbe8(%rsi,%rax,1)
    8537:	48 83 c2 02          	add    $0x2,%rdx
    853b:	eb a3                	jmp    84e0 <fwp_gc_init+0xb0>
    853d:	48 bb 00 00 00 00 10 	movabs $0x1000000000,%rbx
    8544:	00 00 00 
    8547:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    854e:	31 ff                	xor    %edi,%edi
    8550:	31 d2                	xor    %edx,%edx
    8552:	b9 22 40 00 00       	mov    $0x4022,%ecx
    8557:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    855d:	45 31 c9             	xor    %r9d,%r9d
    8560:	e8 2b ac ff ff       	call   3190 <mmap@plt>
    8565:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    8569:	75 60                	jne    85cb <fwp_gc_init+0x19b>
    856b:	48 bb 00 00 00 00 04 	movabs $0x400000000,%rbx
    8572:	00 00 00 
    8575:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    857c:	31 ff                	xor    %edi,%edi
    857e:	31 d2                	xor    %edx,%edx
    8580:	b9 22 40 00 00       	mov    $0x4022,%ecx
    8585:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    858b:	45 31 c9             	xor    %r9d,%r9d
    858e:	e8 fd ab ff ff       	call   3190 <mmap@plt>
    8593:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    8597:	75 32                	jne    85cb <fwp_gc_init+0x19b>
    8599:	48 bb 00 00 00 00 01 	movabs $0x100000000,%rbx
    85a0:	00 00 00 
    85a3:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    85aa:	31 ff                	xor    %edi,%edi
    85ac:	31 d2                	xor    %edx,%edx
    85ae:	b9 22 40 00 00       	mov    $0x4022,%ecx
    85b3:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    85b9:	45 31 c9             	xor    %r9d,%r9d
    85bc:	e8 cf ab ff ff       	call   3190 <mmap@plt>
    85c1:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    85c5:	0f 84 b5 01 00 00    	je     8780 <fwp_gc_init+0x350>
    85cb:	48 85 c0             	test   %rax,%rax
    85ce:	0f 84 0d 02 00 00    	je     87e1 <fwp_gc_init+0x3b1>
    85d4:	48 89 05 e5 2c 01 00 	mov    %rax,0x12ce5(%rip)        # 1b2c0 <fwp_gc+0x1038>
    85db:	48 89 d9             	mov    %rbx,%rcx
    85de:	48 81 c9 00 00 01 00 	or     $0x10000,%rcx
    85e5:	48 89 0d dc 2c 01 00 	mov    %rcx,0x12cdc(%rip)        # 1b2c8 <fwp_gc+0x1040>
    85ec:	48 05 ff ff 00 00    	add    $0xffff,%rax
    85f2:	48 25 00 00 ff ff    	and    $0xffffffffffff0000,%rax
    85f8:	48 89 05 b9 2c 01 00 	mov    %rax,0x12cb9(%rip)        # 1b2b8 <fwp_gc+0x1030>
    85ff:	48 c1 eb 10          	shr    $0x10,%rbx
    8603:	48 89 1d ce 2c 01 00 	mov    %rbx,0x12cce(%rip)        # 1b2d8 <fwp_gc+0x1050>
    860a:	48 69 f3 28 12 00 00 	imul   $0x1228,%rbx,%rsi
    8611:	48 89 35 f0 2c 01 00 	mov    %rsi,0x12cf0(%rip)        # 1b308 <fwp_gc+0x1080>
    8618:	31 ff                	xor    %edi,%edi
    861a:	31 d2                	xor    %edx,%edx
    861c:	b9 22 40 00 00       	mov    $0x4022,%ecx
    8621:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    8627:	45 31 c9             	xor    %r9d,%r9d
    862a:	e8 61 ab ff ff       	call   3190 <mmap@plt>
    862f:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    8633:	0f 84 a8 01 00 00    	je     87e1 <fwp_gc_init+0x3b1>
    8639:	48 89 05 c0 2c 01 00 	mov    %rax,0x12cc0(%rip)        # 1b300 <fwp_gc+0x1078>
    8640:	48 8d 3d 86 d4 00 00 	lea    0xd486(%rip),%rdi        # 15acd <exec_in_fp0+0x25d>
    8647:	e8 e4 a9 ff ff       	call   3030 <getenv@plt>
    864c:	48 85 c0             	test   %rax,%rax
    864f:	74 2e                	je     867f <fwp_gc_init+0x24f>
    8651:	48 89 c3             	mov    %rax,%rbx
    8654:	48 8d 35 79 d4 00 00 	lea    0xd479(%rip),%rsi        # 15ad4 <exec_in_fp0+0x264>
    865b:	48 89 c7             	mov    %rax,%rdi
    865e:	e8 6d ac ff ff       	call   32d0 <strcmp@plt>
    8663:	85 c0                	test   %eax,%eax
    8665:	74 1f                	je     8686 <fwp_gc_init+0x256>
    8667:	48 8d 35 67 e1 00 00 	lea    0xe167(%rip),%rsi        # 167d5 <exec_in_fp0+0xf65>
    866e:	48 89 df             	mov    %rbx,%rdi
    8671:	e8 5a ac ff ff       	call   32d0 <strcmp@plt>
    8676:	31 c9                	xor    %ecx,%ecx
    8678:	85 c0                	test   %eax,%eax
    867a:	0f 95 c1             	setne  %cl
    867d:	eb 09                	jmp    8688 <fwp_gc_init+0x258>
    867f:	b9 01 00 00 00       	mov    $0x1,%ecx
    8684:	eb 02                	jmp    8688 <fwp_gc_init+0x258>
    8686:	31 c9                	xor    %ecx,%ecx
    8688:	89 0d ea 2b 01 00    	mov    %ecx,0x12bea(%rip)        # 1b278 <fwp_gc+0xff0>
    868e:	48 8d 3d 43 d4 00 00 	lea    0xd443(%rip),%rdi        # 15ad8 <exec_in_fp0+0x268>
    8695:	e8 96 a9 ff ff       	call   3030 <getenv@plt>
    869a:	31 c9                	xor    %ecx,%ecx
    869c:	48 85 c0             	test   %rax,%rax
    869f:	74 1b                	je     86bc <fwp_gc_init+0x28c>
    86a1:	80 38 00             	cmpb   $0x0,(%rax)
    86a4:	74 16                	je     86bc <fwp_gc_init+0x28c>
    86a6:	48 8d 35 28 e1 00 00 	lea    0xe128(%rip),%rsi        # 167d5 <exec_in_fp0+0xf65>
    86ad:	48 89 c7             	mov    %rax,%rdi
    86b0:	e8 1b ac ff ff       	call   32d0 <strcmp@plt>
    86b5:	31 c9                	xor    %ecx,%ecx
    86b7:	85 c0                	test   %eax,%eax
    86b9:	0f 95 c1             	setne  %cl
    86bc:	89 0d c2 2b 01 00    	mov    %ecx,0x12bc2(%rip)        # 1b284 <fwp_gc+0xffc>
    86c2:	48 8d 3d 04 d4 00 00 	lea    0xd404(%rip),%rdi        # 15acd <exec_in_fp0+0x25d>
    86c9:	e8 62 a9 ff ff       	call   3030 <getenv@plt>
    86ce:	48 85 c0             	test   %rax,%rax
    86d1:	74 18                	je     86eb <fwp_gc_init+0x2bb>
    86d3:	48 8d 35 0b d4 00 00 	lea    0xd40b(%rip),%rsi        # 15ae5 <exec_in_fp0+0x275>
    86da:	48 89 c7             	mov    %rax,%rdi
    86dd:	e8 ee ab ff ff       	call   32d0 <strcmp@plt>
    86e2:	31 c9                	xor    %ecx,%ecx
    86e4:	85 c0                	test   %eax,%eax
    86e6:	0f 95 c1             	setne  %cl
    86e9:	eb 05                	jmp    86f0 <fwp_gc_init+0x2c0>
    86eb:	b9 01 00 00 00       	mov    $0x1,%ecx
    86f0:	89 0d 92 2b 01 00    	mov    %ecx,0x12b92(%rip)        # 1b288 <fwp_gc+0x1000>
    86f6:	c7 05 90 2b 01 00 01 	movl   $0x1,0x12b90(%rip)        # 1b290 <fwp_gc+0x1008>
    86fd:	00 00 00 
    8700:	48 8d 3d e3 d3 00 00 	lea    0xd3e3(%rip),%rdi        # 15aea <exec_in_fp0+0x27a>
    8707:	e8 24 a9 ff ff       	call   3030 <getenv@plt>
    870c:	31 c9                	xor    %ecx,%ecx
    870e:	48 85 c0             	test   %rax,%rax
    8711:	74 1b                	je     872e <fwp_gc_init+0x2fe>
    8713:	80 38 00             	cmpb   $0x0,(%rax)
    8716:	74 16                	je     872e <fwp_gc_init+0x2fe>
    8718:	48 8d 35 b6 e0 00 00 	lea    0xe0b6(%rip),%rsi        # 167d5 <exec_in_fp0+0xf65>
    871f:	48 89 c7             	mov    %rax,%rdi
    8722:	e8 a9 ab ff ff       	call   32d0 <strcmp@plt>
    8727:	31 c9                	xor    %ecx,%ecx
    8729:	85 c0                	test   %eax,%eax
    872b:	0f 95 c1             	setne  %cl
    872e:	89 0d 58 2b 01 00    	mov    %ecx,0x12b58(%rip)        # 1b28c <fwp_gc+0x1004>
    8734:	48 8d 3d bd d3 00 00 	lea    0xd3bd(%rip),%rdi        # 15af8 <exec_in_fp0+0x288>
    873b:	e8 f0 a8 ff ff       	call   3030 <getenv@plt>
    8740:	48 85 c0             	test   %rax,%rax
    8743:	74 11                	je     8756 <fwp_gc_init+0x326>
    8745:	48 89 c7             	mov    %rax,%rdi
    8748:	31 f6                	xor    %esi,%esi
    874a:	ba 0a 00 00 00       	mov    $0xa,%edx
    874f:	e8 cc ab ff ff       	call   3320 <strtol@plt>
    8754:	eb 02                	jmp    8758 <fwp_gc_init+0x328>
    8756:	31 c0                	xor    %eax,%eax
    8758:	31 c9                	xor    %ecx,%ecx
    875a:	48 85 c0             	test   %rax,%rax
    875d:	48 0f 4f c8          	cmovg  %rax,%rcx
    8761:	48 89 0d 40 2b 01 00 	mov    %rcx,0x12b40(%rip)        # 1b2a8 <fwp_gc+0x1020>
    8768:	48 c7 05 25 2d 01 00 	movq   $0x800000,0x12d25(%rip)        # 1b498 <fwp_gc+0x1210>
    876f:	00 00 80 00 
    8773:	48 c7 05 0a 1b 01 00 	movq   $0x800000,0x11b0a(%rip)        # 1a288 <fwp_gc>
    877a:	00 00 80 00 
    877e:	5b                   	pop    %rbx
    877f:	c3                   	ret
    8780:	be 00 00 01 40       	mov    $0x40010000,%esi
    8785:	31 ff                	xor    %edi,%edi
    8787:	31 d2                	xor    %edx,%edx
    8789:	b9 22 40 00 00       	mov    $0x4022,%ecx
    878e:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    8794:	45 31 c9             	xor    %r9d,%r9d
    8797:	e8 f4 a9 ff ff       	call   3190 <mmap@plt>
    879c:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    87a0:	74 0f                	je     87b1 <fwp_gc_init+0x381>
    87a2:	48 85 c0             	test   %rax,%rax
    87a5:	74 3a                	je     87e1 <fwp_gc_init+0x3b1>
    87a7:	bb 00 00 00 40       	mov    $0x40000000,%ebx
    87ac:	e9 23 fe ff ff       	jmp    85d4 <fwp_gc_init+0x1a4>
    87b1:	be 00 00 01 10       	mov    $0x10010000,%esi
    87b6:	31 ff                	xor    %edi,%edi
    87b8:	31 d2                	xor    %edx,%edx
    87ba:	b9 22 40 00 00       	mov    $0x4022,%ecx
    87bf:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    87c5:	45 31 c9             	xor    %r9d,%r9d
    87c8:	e8 c3 a9 ff ff       	call   3190 <mmap@plt>
    87cd:	48 8d 48 01          	lea    0x1(%rax),%rcx
    87d1:	48 83 f9 02          	cmp    $0x2,%rcx
    87d5:	72 0a                	jb     87e1 <fwp_gc_init+0x3b1>
    87d7:	bb 00 00 00 10       	mov    $0x10000000,%ebx
    87dc:	e9 f3 fd ff ff       	jmp    85d4 <fwp_gc_init+0x1a4>
    87e1:	48 8b 05 f0 17 01 00 	mov    0x117f0(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    87e8:	48 8b 08             	mov    (%rax),%rcx
    87eb:	48 8d 3d 14 d3 00 00 	lea    0xd314(%rip),%rdi        # 15b06 <exec_in_fp0+0x296>
    87f2:	be 13 00 00 00       	mov    $0x13,%esi
    87f7:	ba 01 00 00 00       	mov    $0x1,%edx
    87fc:	e8 7f ac ff ff       	call   3480 <fwrite@plt>
    8801:	bf 66 00 00 00       	mov    $0x66,%edi
    8806:	e8 55 ac ff ff       	call   3460 <exit@plt>
    880b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000008810 <fwp_gc_alloc_big>:
    8810:	55                   	push   %rbp
    8811:	41 57                	push   %r15
    8813:	41 56                	push   %r14
    8815:	41 55                	push   %r13
    8817:	41 54                	push   %r12
    8819:	53                   	push   %rbx
    881a:	50                   	push   %rax
    881b:	48 b8 01 00 00 00 00 	movabs $0x4000000000000001,%rax
    8822:	00 00 40 
    8825:	48 39 c7             	cmp    %rax,%rdi
    8828:	0f 83 4e 01 00 00    	jae    897c <fwp_gc_alloc_big+0x16c>
    882e:	89 f5                	mov    %esi,%ebp
    8830:	48 89 fb             	mov    %rdi,%rbx
    8833:	48 29 3d 4e 1a 01 00 	sub    %rdi,0x11a4e(%rip)        # 1a288 <fwp_gc>
    883a:	79 05                	jns    8841 <fwp_gc_alloc_big+0x31>
    883c:	e8 6f 01 00 00       	call   89b0 <fwp_gc_spent>
    8841:	4c 8d b3 ff ff 00 00 	lea    0xffff(%rbx),%r14
    8848:	49 c1 ee 10          	shr    $0x10,%r14
    884c:	4c 89 f7             	mov    %r14,%rdi
    884f:	e8 5c 03 00 00       	call   8bb0 <fwp_gc_chunks>
    8854:	48 8b 0d a5 2a 01 00 	mov    0x12aa5(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    885b:	4c 69 e0 28 12 00 00 	imul   $0x1228,%rax,%r12
    8862:	42 c6 04 21 02       	movb   $0x2,(%rcx,%r12,1)
    8867:	42 88 6c 21 01       	mov    %bpl,0x1(%rcx,%r12,1)
    886c:	66 42 c7 44 21 03 00 	movw   $0x100,0x3(%rcx,%r12,1)
    8873:	01 
    8874:	46 89 74 21 10       	mov    %r14d,0x10(%rcx,%r12,1)
    8879:	4a 89 5c 21 18       	mov    %rbx,0x18(%rcx,%r12,1)
    887e:	4e 8d 3c 21          	lea    (%rcx,%r12,1),%r15
    8882:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    8889:	42 80 bc 21 28 02 00 	cmpb   $0xff,0x228(%rcx,%r12,1)
    8890:	00 ff 
    8892:	0f 84 d1 00 00 00    	je     8969 <fwp_gc_alloc_big+0x159>
    8898:	41 c6 07 00          	movb   $0x0,(%r15)
    889c:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    88a3:	0f 82 9a 00 00 00    	jb     8943 <fwp_gc_alloc_big+0x133>
    88a9:	49 83 fe 03          	cmp    $0x3,%r14
    88ad:	ba 02 00 00 00       	mov    $0x2,%edx
    88b2:	49 0f 43 d6          	cmovae %r14,%rdx
    88b6:	48 8b 0d 43 2a 01 00 	mov    0x12a43(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    88bd:	48 ff ca             	dec    %rdx
    88c0:	be 01 00 00 00       	mov    $0x1,%esi
    88c5:	48 81 fb 01 00 02 00 	cmp    $0x20001,%rbx
    88cc:	72 59                	jb     8927 <fwp_gc_alloc_big+0x117>
    88ce:	49 8d 3c 0c          	lea    (%r12,%rcx,1),%rdi
    88d2:	48 81 c7 60 24 00 00 	add    $0x2460,%rdi
    88d9:	49 89 d0             	mov    %rdx,%r8
    88dc:	49 83 e0 fe          	and    $0xfffffffffffffffe,%r8
    88e0:	49 f7 d8             	neg    %r8
    88e3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    88ea:	84 00 00 00 00 00 
    88f0:	c6 87 c8 ed ff ff 03 	movb   $0x3,-0x1238(%rdi)
    88f7:	c6 87 cc ed ff ff 01 	movb   $0x1,-0x1234(%rdi)
    88fe:	89 87 d8 ed ff ff    	mov    %eax,-0x1228(%rdi)
    8904:	c6 47 f0 03          	movb   $0x3,-0x10(%rdi)
    8908:	c6 47 f4 01          	movb   $0x1,-0xc(%rdi)
    890c:	89 07                	mov    %eax,(%rdi)
    890e:	48 81 c7 50 24 00 00 	add    $0x2450,%rdi
    8915:	4d 8d 0c 30          	lea    (%r8,%rsi,1),%r9
    8919:	49 83 c1 02          	add    $0x2,%r9
    891d:	48 83 c6 02          	add    $0x2,%rsi
    8921:	49 83 f9 01          	cmp    $0x1,%r9
    8925:	75 c9                	jne    88f0 <fwp_gc_alloc_big+0xe0>
    8927:	f6 c2 01             	test   $0x1,%dl
    892a:	74 17                	je     8943 <fwp_gc_alloc_big+0x133>
    892c:	4c 01 e1             	add    %r12,%rcx
    892f:	48 69 d6 28 12 00 00 	imul   $0x1228,%rsi,%rdx
    8936:	c6 04 11 03          	movb   $0x3,(%rcx,%rdx,1)
    893a:	c6 44 11 04 01       	movb   $0x1,0x4(%rcx,%rdx,1)
    893f:	89 44 11 10          	mov    %eax,0x10(%rcx,%rdx,1)
    8943:	48 c1 e0 10          	shl    $0x10,%rax
    8947:	48 03 05 6a 29 01 00 	add    0x1296a(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    894e:	48 89 c7             	mov    %rax,%rdi
    8951:	31 f6                	xor    %esi,%esi
    8953:	48 89 da             	mov    %rbx,%rdx
    8956:	48 83 c4 08          	add    $0x8,%rsp
    895a:	5b                   	pop    %rbx
    895b:	41 5c                	pop    %r12
    895d:	41 5d                	pop    %r13
    895f:	41 5e                	pop    %r14
    8961:	41 5f                	pop    %r15
    8963:	5d                   	pop    %rbp
    8964:	e9 a7 a8 ff ff       	jmp    3210 <memset@plt>
    8969:	4c 89 ff             	mov    %r15,%rdi
    896c:	49 89 c5             	mov    %rax,%r13
    896f:	e8 3c e2 ff ff       	call   6bb0 <fwp_rc_forget_slot>
    8974:	4c 89 e8             	mov    %r13,%rax
    8977:	e9 1c ff ff ff       	jmp    8898 <fwp_gc_alloc_big+0x88>
    897c:	48 8b 05 55 16 01 00 	mov    0x11655(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    8983:	48 8b 08             	mov    (%rax),%rcx
    8986:	48 8d 3d 79 d1 00 00 	lea    0xd179(%rip),%rdi        # 15b06 <exec_in_fp0+0x296>
    898d:	be 13 00 00 00       	mov    $0x13,%esi
    8992:	ba 01 00 00 00       	mov    $0x1,%edx
    8997:	e8 e4 aa ff ff       	call   3480 <fwrite@plt>
    899c:	bf 66 00 00 00       	mov    $0x66,%edi
    89a1:	e8 ba aa ff ff       	call   3460 <exit@plt>
    89a6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    89ad:	00 00 00 

00000000000089b0 <fwp_gc_spent>:
    89b0:	50                   	push   %rax
    89b1:	83 3d bc 28 01 00 00 	cmpl   $0x0,0x128bc(%rip)        # 1b274 <fwp_gc+0xfec>
    89b8:	75 05                	jne    89bf <fwp_gc_spent+0xf>
    89ba:	e8 71 fa ff ff       	call   8430 <fwp_gc_init>
    89bf:	8b 05 b7 28 01 00    	mov    0x128b7(%rip),%eax        # 1b27c <fwp_gc+0xff4>
    89c5:	85 c0                	test   %eax,%eax
    89c7:	74 6d                	je     8a36 <fwp_gc_spent+0x86>
    89c9:	48 8b 0d d8 28 01 00 	mov    0x128d8(%rip),%rcx        # 1b2a8 <fwp_gc+0x1020>
    89d0:	48 85 c9             	test   %rcx,%rcx
    89d3:	74 61                	je     8a36 <fwp_gc_spent+0x86>
    89d5:	48 8b 05 d4 28 01 00 	mov    0x128d4(%rip),%rax        # 1b2b0 <fwp_gc+0x1028>
    89dc:	48 ff c0             	inc    %rax
    89df:	48 89 05 ca 28 01 00 	mov    %rax,0x128ca(%rip)        # 1b2b0 <fwp_gc+0x1028>
    89e6:	48 39 c8             	cmp    %rcx,%rax
    89e9:	7c 10                	jl     89fb <fwp_gc_spent+0x4b>
    89eb:	48 c7 05 ba 28 01 00 	movq   $0x0,0x128ba(%rip)        # 1b2b0 <fwp_gc+0x1028>
    89f2:	00 00 00 00 
    89f6:	e8 45 03 00 00       	call   8d40 <fwp_gc_collect>
    89fb:	48 8b 05 96 2a 01 00 	mov    0x12a96(%rip),%rax        # 1b498 <fwp_gc+0x1210>
    8a02:	48 2b 05 7f 18 01 00 	sub    0x1187f(%rip),%rax        # 1a288 <fwp_gc>
    8a09:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    8a0e:	f2 0f 58 05 5a 2a 01 	addsd  0x12a5a(%rip),%xmm0        # 1b470 <fwp_gc+0x11e8>
    8a15:	00 
    8a16:	f2 0f 11 05 52 2a 01 	movsd  %xmm0,0x12a52(%rip)        # 1b470 <fwp_gc+0x11e8>
    8a1d:	00 
    8a1e:	48 c7 05 6f 2a 01 00 	movq   $0x0,0x12a6f(%rip)        # 1b498 <fwp_gc+0x1210>
    8a25:	00 00 00 00 
    8a29:	48 c7 05 54 18 01 00 	movq   $0x0,0x11854(%rip)        # 1a288 <fwp_gc>
    8a30:	00 00 00 00 
    8a34:	58                   	pop    %rax
    8a35:	c3                   	ret
    8a36:	85 c0                	test   %eax,%eax
    8a38:	74 06                	je     8a40 <fwp_gc_spent+0x90>
    8a3a:	58                   	pop    %rax
    8a3b:	e9 00 03 00 00       	jmp    8d40 <fwp_gc_collect>
    8a40:	48 8b 05 51 2a 01 00 	mov    0x12a51(%rip),%rax        # 1b498 <fwp_gc+0x1210>
    8a47:	48 2b 05 3a 18 01 00 	sub    0x1183a(%rip),%rax        # 1a288 <fwp_gc>
    8a4e:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    8a53:	f2 0f 58 05 15 2a 01 	addsd  0x12a15(%rip),%xmm0        # 1b470 <fwp_gc+0x11e8>
    8a5a:	00 
    8a5b:	f2 0f 11 05 0d 2a 01 	movsd  %xmm0,0x12a0d(%rip)        # 1b470 <fwp_gc+0x11e8>
    8a62:	00 
    8a63:	48 c7 05 2a 2a 01 00 	movq   $0x800000,0x12a2a(%rip)        # 1b498 <fwp_gc+0x1210>
    8a6a:	00 00 80 00 
    8a6e:	48 c7 05 0f 18 01 00 	movq   $0x800000,0x1180f(%rip)        # 1a288 <fwp_gc>
    8a75:	00 00 80 00 
    8a79:	58                   	pop    %rax
    8a7a:	c3                   	ret
    8a7b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000008a80 <fwp_gc_refill>:
    8a80:	55                   	push   %rbp
    8a81:	41 57                	push   %r15
    8a83:	41 56                	push   %r14
    8a85:	41 55                	push   %r13
    8a87:	41 54                	push   %r12
    8a89:	53                   	push   %rbx
    8a8a:	50                   	push   %rax
    8a8b:	89 d5                	mov    %edx,%ebp
    8a8d:	41 89 f7             	mov    %esi,%r15d
    8a90:	48 89 fb             	mov    %rdi,%rbx
    8a93:	bf 01 00 00 00       	mov    $0x1,%edi
    8a98:	e8 13 01 00 00       	call   8bb0 <fwp_gc_chunks>
    8a9d:	49 89 c6             	mov    %rax,%r14
    8aa0:	4c 8b 25 59 28 01 00 	mov    0x12859(%rip),%r12        # 1b300 <fwp_gc+0x1078>
    8aa7:	48 8d 05 da 17 01 00 	lea    0x117da(%rip),%rax        # 1a288 <fwp_gc>
    8aae:	4d 69 ee 28 12 00 00 	imul   $0x1228,%r14,%r13
    8ab5:	43 c6 04 2c 01       	movb   $0x1,(%r12,%r13,1)
    8aba:	43 88 6c 2c 01       	mov    %bpl,0x1(%r12,%r13,1)
    8abf:	47 88 7c 2c 02       	mov    %r15b,0x2(%r12,%r13,1)
    8ac4:	43 c6 44 2c 04 01    	movb   $0x1,0x4(%r12,%r13,1)
    8aca:	44 89 f9             	mov    %r15d,%ecx
    8acd:	8b 8c 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%ecx
    8ad4:	43 89 4c 2c 08       	mov    %ecx,0x8(%r12,%r13,1)
    8ad9:	b8 00 00 01 00       	mov    $0x10000,%eax
    8ade:	31 d2                	xor    %edx,%edx
    8ae0:	f7 f1                	div    %ecx
    8ae2:	43 89 44 2c 0c       	mov    %eax,0xc(%r12,%r13,1)
    8ae7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    8aec:	48 01 c8             	add    %rcx,%rax
    8aef:	48 0f ba e0 20       	bt     $0x20,%rax
    8af4:	73 07                	jae    8afd <fwp_gc_refill+0x7d>
    8af6:	31 d2                	xor    %edx,%edx
    8af8:	48 f7 f1             	div    %rcx
    8afb:	eb 04                	jmp    8b01 <fwp_gc_refill+0x81>
    8afd:	31 d2                	xor    %edx,%edx
    8aff:	f7 f1                	div    %ecx
    8b01:	43 89 44 2c 20       	mov    %eax,0x20(%r12,%r13,1)
    8b06:	48 83 3d 92 31 01 00 	cmpq   $0x0,0x13192(%rip)        # 1bca0 <fwp_gc+0x1a18>
    8b0d:	00 
    8b0e:	74 2e                	je     8b3e <fwp_gc_refill+0xbe>
    8b10:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    8b14:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    8b1b:	31 ed                	xor    %ebp,%ebp
    8b1d:	eb 0d                	jmp    8b2c <fwp_gc_refill+0xac>
    8b1f:	90                   	nop
    8b20:	48 ff c5             	inc    %rbp
    8b23:	48 81 fd 00 10 00 00 	cmp    $0x1000,%rbp
    8b2a:	74 12                	je     8b3e <fwp_gc_refill+0xbe>
    8b2c:	41 80 3c 2f ff       	cmpb   $0xff,(%r15,%rbp,1)
    8b31:	75 ed                	jne    8b20 <fwp_gc_refill+0xa0>
    8b33:	49 8d 3c 2f          	lea    (%r15,%rbp,1),%rdi
    8b37:	e8 74 e0 ff ff       	call   6bb0 <fwp_rc_forget_slot>
    8b3c:	eb e2                	jmp    8b20 <fwp_gc_refill+0xa0>
    8b3e:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    8b42:	49 83 c7 08          	add    $0x8,%r15
    8b46:	4b 8d 3c 2c          	lea    (%r12,%r13,1),%rdi
    8b4a:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    8b51:	ba 00 10 00 00       	mov    $0x1000,%edx
    8b56:	31 f6                	xor    %esi,%esi
    8b58:	e8 b3 a6 ff ff       	call   3210 <memset@plt>
    8b5d:	49 c1 e6 10          	shl    $0x10,%r14
    8b61:	4c 03 35 50 27 01 00 	add    0x12750(%rip),%r14        # 1b2b8 <fwp_gc+0x1030>
    8b68:	83 3d 1d 27 01 00 00 	cmpl   $0x0,0x1271d(%rip)        # 1b28c <fwp_gc+0x1004>
    8b6f:	74 0f                	je     8b80 <fwp_gc_refill+0x100>
    8b71:	ba 00 00 01 00       	mov    $0x10000,%edx
    8b76:	4c 89 f7             	mov    %r14,%rdi
    8b79:	31 f6                	xor    %esi,%esi
    8b7b:	e8 90 a6 ff ff       	call   3210 <memset@plt>
    8b80:	41 8b 07             	mov    (%r15),%eax
    8b83:	49 8d 0c 06          	lea    (%r14,%rax,1),%rcx
    8b87:	48 89 4b 08          	mov    %rcx,0x8(%rbx)
    8b8b:	41 8b 4f 04          	mov    0x4(%r15),%ecx
    8b8f:	48 0f af c8          	imul   %rax,%rcx
    8b93:	4c 01 f1             	add    %r14,%rcx
    8b96:	48 89 4b 10          	mov    %rcx,0x10(%rbx)
    8b9a:	4c 89 f0             	mov    %r14,%rax
    8b9d:	48 83 c4 08          	add    $0x8,%rsp
    8ba1:	5b                   	pop    %rbx
    8ba2:	41 5c                	pop    %r12
    8ba4:	41 5d                	pop    %r13
    8ba6:	41 5e                	pop    %r14
    8ba8:	41 5f                	pop    %r15
    8baa:	5d                   	pop    %rbp
    8bab:	c3                   	ret
    8bac:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000008bb0 <fwp_gc_chunks>:
    8bb0:	41 57                	push   %r15
    8bb2:	41 56                	push   %r14
    8bb4:	53                   	push   %rbx
    8bb5:	48 89 fb             	mov    %rdi,%rbx
    8bb8:	31 d2                	xor    %edx,%edx
    8bba:	48 83 ff 01          	cmp    $0x1,%rdi
    8bbe:	0f 95 c2             	setne  %dl
    8bc1:	48 8d 0d c0 16 01 00 	lea    0x116c0(%rip),%rcx        # 1a288 <fwp_gc>
    8bc8:	48 8b 84 d1 68 10 00 	mov    0x1068(%rcx,%rdx,8),%rax
    8bcf:	00 
    8bd0:	4c 8b 35 09 27 01 00 	mov    0x12709(%rip),%r14        # 1b2e0 <fwp_gc+0x1058>
    8bd7:	48 89 c7             	mov    %rax,%rdi
    8bda:	4c 29 f7             	sub    %r14,%rdi
    8bdd:	73 63                	jae    8c42 <fwp_gc_chunks+0x92>
    8bdf:	48 8d 34 d5 68 10 00 	lea    0x1068(,%rdx,8),%rsi
    8be6:	00 
    8be7:	4c 69 c0 28 12 00 00 	imul   $0x1228,%rax,%r8
    8bee:	4c 03 05 0b 27 01 00 	add    0x1270b(%rip),%r8        # 1b300 <fwp_gc+0x1078>
    8bf5:	31 d2                	xor    %edx,%edx
    8bf7:	45 31 c9             	xor    %r9d,%r9d
    8bfa:	eb 16                	jmp    8c12 <fwp_gc_chunks+0x62>
    8bfc:	0f 1f 40 00          	nopl   0x0(%rax)
    8c00:	45 31 c9             	xor    %r9d,%r9d
    8c03:	48 ff ca             	dec    %rdx
    8c06:	49 81 c0 28 12 00 00 	add    $0x1228,%r8
    8c0d:	48 39 d7             	cmp    %rdx,%rdi
    8c10:	74 33                	je     8c45 <fwp_gc_chunks+0x95>
    8c12:	41 80 38 00          	cmpb   $0x0,(%r8)
    8c16:	75 e8                	jne    8c00 <fwp_gc_chunks+0x50>
    8c18:	49 ff c1             	inc    %r9
    8c1b:	49 39 d9             	cmp    %rbx,%r9
    8c1e:	75 e3                	jne    8c03 <fwp_gc_chunks+0x53>
    8c20:	48 ff c0             	inc    %rax
    8c23:	48 89 c7             	mov    %rax,%rdi
    8c26:	48 29 d7             	sub    %rdx,%rdi
    8c29:	48 89 3c 0e          	mov    %rdi,(%rsi,%rcx,1)
    8c2d:	48 29 1d 34 28 01 00 	sub    %rbx,0x12834(%rip)        # 1b468 <fwp_gc+0x11e0>
    8c34:	48 29 d8             	sub    %rbx,%rax
    8c37:	48 29 d0             	sub    %rdx,%rax
    8c3a:	49 89 c6             	mov    %rax,%r14
    8c3d:	e9 ca 00 00 00       	jmp    8d0c <fwp_gc_chunks+0x15c>
    8c42:	45 31 c9             	xor    %r9d,%r9d
    8c45:	4c 29 0d 1c 28 01 00 	sub    %r9,0x1281c(%rip)        # 1b468 <fwp_gc+0x11e0>
    8c4c:	4d 29 ce             	sub    %r9,%r14
    8c4f:	4c 01 f3             	add    %r14,%rbx
    8c52:	48 8b 3d 8f 26 01 00 	mov    0x1268f(%rip),%rdi        # 1b2e8 <fwp_gc+0x1060>
    8c59:	48 39 df             	cmp    %rbx,%rdi
    8c5c:	0f 83 8f 00 00 00    	jae    8cf1 <fwp_gc_chunks+0x141>
    8c62:	4c 8b 3d 6f 26 01 00 	mov    0x1266f(%rip),%r15        # 1b2d8 <fwp_gc+0x1050>
    8c69:	49 39 df             	cmp    %rbx,%r15
    8c6c:	0f 82 a3 00 00 00    	jb     8d15 <fwp_gc_chunks+0x165>
    8c72:	48 8d 43 40          	lea    0x40(%rbx),%rax
    8c76:	4c 39 f8             	cmp    %r15,%rax
    8c79:	4c 0f 42 f8          	cmovb  %rax,%r15
    8c7d:	4c 89 fe             	mov    %r15,%rsi
    8c80:	48 29 fe             	sub    %rdi,%rsi
    8c83:	48 c1 e7 10          	shl    $0x10,%rdi
    8c87:	48 03 3d 2a 26 01 00 	add    0x1262a(%rip),%rdi        # 1b2b8 <fwp_gc+0x1030>
    8c8e:	48 c1 e6 10          	shl    $0x10,%rsi
    8c92:	ba 03 00 00 00       	mov    $0x3,%edx
    8c97:	e8 64 a7 ff ff       	call   3400 <mprotect@plt>
    8c9c:	85 c0                	test   %eax,%eax
    8c9e:	75 75                	jne    8d15 <fwp_gc_chunks+0x165>
    8ca0:	bf 1e 00 00 00       	mov    $0x1e,%edi
    8ca5:	e8 76 a7 ff ff       	call   3420 <sysconf@plt>
    8caa:	48 8b 0d 4f 26 01 00 	mov    0x1264f(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    8cb1:	48 69 3d 2c 26 01 00 	imul   $0x1228,0x1262c(%rip),%rdi        # 1b2e8 <fwp_gc+0x1060>
    8cb8:	28 12 00 00 
    8cbc:	48 01 cf             	add    %rcx,%rdi
    8cbf:	49 69 d7 28 12 00 00 	imul   $0x1228,%r15,%rdx
    8cc6:	48 01 ca             	add    %rcx,%rdx
    8cc9:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    8ccd:	48 ff ce             	dec    %rsi
    8cd0:	48 f7 d8             	neg    %rax
    8cd3:	48 21 c7             	and    %rax,%rdi
    8cd6:	48 21 c6             	and    %rax,%rsi
    8cd9:	48 29 fe             	sub    %rdi,%rsi
    8cdc:	ba 03 00 00 00       	mov    $0x3,%edx
    8ce1:	e8 1a a7 ff ff       	call   3400 <mprotect@plt>
    8ce6:	85 c0                	test   %eax,%eax
    8ce8:	75 2b                	jne    8d15 <fwp_gc_chunks+0x165>
    8cea:	4c 89 3d f7 25 01 00 	mov    %r15,0x125f7(%rip)        # 1b2e8 <fwp_gc+0x1060>
    8cf1:	48 89 1d e8 25 01 00 	mov    %rbx,0x125e8(%rip)        # 1b2e0 <fwp_gc+0x1058>
    8cf8:	48 c1 e3 10          	shl    $0x10,%rbx
    8cfc:	48 3b 1d cd 25 01 00 	cmp    0x125cd(%rip),%rbx        # 1b2d0 <fwp_gc+0x1048>
    8d03:	76 07                	jbe    8d0c <fwp_gc_chunks+0x15c>
    8d05:	48 89 1d c4 25 01 00 	mov    %rbx,0x125c4(%rip)        # 1b2d0 <fwp_gc+0x1048>
    8d0c:	4c 89 f0             	mov    %r14,%rax
    8d0f:	5b                   	pop    %rbx
    8d10:	41 5e                	pop    %r14
    8d12:	41 5f                	pop    %r15
    8d14:	c3                   	ret
    8d15:	48 8b 05 bc 12 01 00 	mov    0x112bc(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    8d1c:	48 8b 08             	mov    (%rax),%rcx
    8d1f:	48 8d 3d e0 cd 00 00 	lea    0xcde0(%rip),%rdi        # 15b06 <exec_in_fp0+0x296>
    8d26:	be 13 00 00 00       	mov    $0x13,%esi
    8d2b:	ba 01 00 00 00       	mov    $0x1,%edx
    8d30:	e8 4b a7 ff ff       	call   3480 <fwrite@plt>
    8d35:	bf 66 00 00 00       	mov    $0x66,%edi
    8d3a:	e8 21 a7 ff ff       	call   3460 <exit@plt>
    8d3f:	90                   	nop

0000000000008d40 <fwp_gc_collect>:
    8d40:	55                   	push   %rbp
    8d41:	48 89 e5             	mov    %rsp,%rbp
    8d44:	41 57                	push   %r15
    8d46:	41 56                	push   %r14
    8d48:	41 55                	push   %r13
    8d4a:	41 54                	push   %r12
    8d4c:	53                   	push   %rbx
    8d4d:	48 81 ec a8 01 00 00 	sub    $0x1a8,%rsp
    8d54:	83 3d 25 25 01 00 00 	cmpl   $0x0,0x12525(%rip)        # 1b280 <fwp_gc+0xff8>
    8d5b:	0f 85 a5 04 00 00    	jne    9206 <fwp_gc_collect+0x4c6>
    8d61:	c7 05 15 25 01 00 01 	movl   $0x1,0x12515(%rip)        # 1b280 <fwp_gc+0xff8>
    8d68:	00 00 00 
    8d6b:	48 8d b5 20 ff ff ff 	lea    -0xe0(%rbp),%rsi
    8d72:	bf 01 00 00 00       	mov    $0x1,%edi
    8d77:	e8 b4 a3 ff ff       	call   3130 <clock_gettime@plt>
    8d7c:	48 8b 05 15 27 01 00 	mov    0x12715(%rip),%rax        # 1b498 <fwp_gc+0x1210>
    8d83:	48 2b 05 fe 14 01 00 	sub    0x114fe(%rip),%rax        # 1a288 <fwp_gc>
    8d8a:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    8d8f:	f2 0f 58 05 d9 26 01 	addsd  0x126d9(%rip),%xmm0        # 1b470 <fwp_gc+0x11e8>
    8d96:	00 
    8d97:	f2 0f 11 05 d1 26 01 	movsd  %xmm0,0x126d1(%rip)        # 1b470 <fwp_gc+0x11e8>
    8d9e:	00 
    8d9f:	83 3d e2 24 01 00 00 	cmpl   $0x0,0x124e2(%rip)        # 1b288 <fwp_gc+0x1000>
    8da6:	0f 94 c0             	sete   %al
    8da9:	83 3d e0 24 01 00 00 	cmpl   $0x0,0x124e0(%rip)        # 1b290 <fwp_gc+0x1008>
    8db0:	41 0f 95 c4          	setne  %r12b
    8db4:	41 08 c4             	or     %al,%r12b
    8db7:	41 80 fc 01          	cmp    $0x1,%r12b
    8dbb:	0f 85 8f 00 00 00    	jne    8e50 <fwp_gc_collect+0x110>
    8dc1:	48 8b 05 18 25 01 00 	mov    0x12518(%rip),%rax        # 1b2e0 <fwp_gc+0x1058>
    8dc8:	48 85 c0             	test   %rax,%rax
    8dcb:	0f 84 c4 01 00 00    	je     8f95 <fwp_gc_collect+0x255>
    8dd1:	48 8b 15 28 25 01 00 	mov    0x12528(%rip),%rdx        # 1b300 <fwp_gc+0x1078>
    8dd8:	31 db                	xor    %ebx,%ebx
    8dda:	41 89 df             	mov    %ebx,%r15d
    8ddd:	4d 89 fe             	mov    %r15,%r14
    8de0:	48 89 c1             	mov    %rax,%rcx
    8de3:	48 89 d0             	mov    %rdx,%rax
    8de6:	eb 2a                	jmp    8e12 <fwp_gc_collect+0xd2>
    8de8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    8def:	00 
    8df0:	42 c6 44 38 03 00    	movb   $0x0,0x3(%rax,%r15,1)
    8df6:	48 89 ca             	mov    %rcx,%rdx
    8df9:	4c 89 f6             	mov    %r14,%rsi
    8dfc:	48 ff c6             	inc    %rsi
    8dff:	49 81 c7 28 12 00 00 	add    $0x1228,%r15
    8e06:	49 89 f6             	mov    %rsi,%r14
    8e09:	48 39 ce             	cmp    %rcx,%rsi
    8e0c:	0f 83 83 01 00 00    	jae    8f95 <fwp_gc_collect+0x255>
    8e12:	42 0f b6 14 38       	movzbl (%rax,%r15,1),%edx
    8e17:	83 fa 02             	cmp    $0x2,%edx
    8e1a:	74 d4                	je     8df0 <fwp_gc_collect+0xb0>
    8e1c:	83 fa 01             	cmp    $0x1,%edx
    8e1f:	75 d5                	jne    8df6 <fwp_gc_collect+0xb6>
    8e21:	4a 8d 3c 38          	lea    (%rax,%r15,1),%rdi
    8e25:	48 83 c7 28          	add    $0x28,%rdi
    8e29:	42 8b 44 38 0c       	mov    0xc(%rax,%r15,1),%eax
    8e2e:	83 c0 3f             	add    $0x3f,%eax
    8e31:	c1 e8 03             	shr    $0x3,%eax
    8e34:	83 e0 f8             	and    $0xfffffff8,%eax
    8e37:	89 c2                	mov    %eax,%edx
    8e39:	89 de                	mov    %ebx,%esi
    8e3b:	e8 d0 a3 ff ff       	call   3210 <memset@plt>
    8e40:	48 8b 05 b9 24 01 00 	mov    0x124b9(%rip),%rax        # 1b300 <fwp_gc+0x1078>
    8e47:	48 8b 0d 92 24 01 00 	mov    0x12492(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    8e4e:	eb a6                	jmp    8df6 <fwp_gc_collect+0xb6>
    8e50:	44 88 65 d7          	mov    %r12b,-0x29(%rbp)
    8e54:	48 8d bd 50 fe ff ff 	lea    -0x1b0(%rbp),%rdi
    8e5b:	e8 50 a4 ff ff       	call   32b0 <_setjmp@plt>
    8e60:	48 c7 05 1d 26 01 00 	movq   $0x0,0x1261d(%rip)        # 1b488 <fwp_gc+0x1200>
    8e67:	00 00 00 00 
    8e6b:	e8 10 08 00 00       	call   9680 <fwp_gc_mark_all>
    8e70:	48 83 3d 68 24 01 00 	cmpq   $0x0,0x12468(%rip)        # 1b2e0 <fwp_gc+0x1058>
    8e77:	00 
    8e78:	0f 84 53 01 00 00    	je     8fd1 <fwp_gc_collect+0x291>
    8e7e:	31 c0                	xor    %eax,%eax
    8e80:	eb 25                	jmp    8ea7 <fwp_gc_collect+0x167>
    8e82:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8e89:	1f 84 00 00 00 00 00 
    8e90:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
    8e94:	48 ff c1             	inc    %rcx
    8e97:	48 89 c8             	mov    %rcx,%rax
    8e9a:	48 3b 0d 3f 24 01 00 	cmp    0x1243f(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    8ea1:	0f 83 2a 01 00 00    	jae    8fd1 <fwp_gc_collect+0x291>
    8ea7:	48 8b 1d 52 24 01 00 	mov    0x12452(%rip),%rbx        # 1b300 <fwp_gc+0x1078>
    8eae:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    8eb2:	48 69 c0 28 12 00 00 	imul   $0x1228,%rax,%rax
    8eb9:	80 7c 03 01 02       	cmpb   $0x2,0x1(%rbx,%rax,1)
    8ebe:	75 d0                	jne    8e90 <fwp_gc_collect+0x150>
    8ec0:	0f b6 0c 03          	movzbl (%rbx,%rax,1),%ecx
    8ec4:	83 f9 02             	cmp    $0x2,%ecx
    8ec7:	0f 84 9f 00 00 00    	je     8f6c <fwp_gc_collect+0x22c>
    8ecd:	83 f9 01             	cmp    $0x1,%ecx
    8ed0:	75 be                	jne    8e90 <fwp_gc_collect+0x150>
    8ed2:	8b 4c 03 0c          	mov    0xc(%rbx,%rax,1),%ecx
    8ed6:	83 c1 3f             	add    $0x3f,%ecx
    8ed9:	83 f9 40             	cmp    $0x40,%ecx
    8edc:	72 b2                	jb     8e90 <fwp_gc_collect+0x150>
    8ede:	4c 8b 7d c0          	mov    -0x40(%rbp),%r15
    8ee2:	49 c1 e7 10          	shl    $0x10,%r15
    8ee6:	4c 03 3d cb 23 01 00 	add    0x123cb(%rip),%r15        # 1b2b8 <fwp_gc+0x1030>
    8eed:	c1 e9 06             	shr    $0x6,%ecx
    8ef0:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    8ef4:	4c 8d 2c 03          	lea    (%rbx,%rax,1),%r13
    8ef8:	49 83 c5 08          	add    $0x8,%r13
    8efc:	31 c9                	xor    %ecx,%ecx
    8efe:	41 89 cc             	mov    %ecx,%r12d
    8f01:	48 01 c3             	add    %rax,%rbx
    8f04:	48 89 5d 98          	mov    %rbx,-0x68(%rbp)
    8f08:	eb 1a                	jmp    8f24 <fwp_gc_collect+0x1e4>
    8f0a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8f10:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    8f14:	48 ff c0             	inc    %rax
    8f17:	49 89 c4             	mov    %rax,%r12
    8f1a:	48 3b 45 90          	cmp    -0x70(%rbp),%rax
    8f1e:	0f 84 6c ff ff ff    	je     8e90 <fwp_gc_collect+0x150>
    8f24:	48 8b 45 98          	mov    -0x68(%rbp),%rax
    8f28:	4c 89 65 b0          	mov    %r12,-0x50(%rbp)
    8f2c:	4e 8b 64 e0 28       	mov    0x28(%rax,%r12,8),%r12
    8f31:	4d 85 e4             	test   %r12,%r12
    8f34:	74 da                	je     8f10 <fwp_gc_collect+0x1d0>
    8f36:	4c 8b 75 b0          	mov    -0x50(%rbp),%r14
    8f3a:	49 c1 e6 06          	shl    $0x6,%r14
    8f3e:	66 90                	xchg   %ax,%ax
    8f40:	f3 49 0f bc c4       	tzcnt  %r12,%rax
    8f45:	4c 09 f0             	or     %r14,%rax
    8f48:	49 8d 5c 24 ff       	lea    -0x1(%r12),%rbx
    8f4d:	41 8b 4d 00          	mov    0x0(%r13),%ecx
    8f51:	89 ce                	mov    %ecx,%esi
    8f53:	48 0f af c6          	imul   %rsi,%rax
    8f57:	48 89 c7             	mov    %rax,%rdi
    8f5a:	4c 01 ff             	add    %r15,%rdi
    8f5d:	e8 4e 13 00 00       	call   a2b0 <fwp_gc_push>
    8f62:	4c 21 e3             	and    %r12,%rbx
    8f65:	49 89 dc             	mov    %rbx,%r12
    8f68:	75 d6                	jne    8f40 <fwp_gc_collect+0x200>
    8f6a:	eb a4                	jmp    8f10 <fwp_gc_collect+0x1d0>
    8f6c:	80 7c 03 03 00       	cmpb   $0x0,0x3(%rbx,%rax,1)
    8f71:	0f 84 19 ff ff ff    	je     8e90 <fwp_gc_collect+0x150>
    8f77:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
    8f7b:	48 c1 e7 10          	shl    $0x10,%rdi
    8f7f:	48 03 3d 32 23 01 00 	add    0x12332(%rip),%rdi        # 1b2b8 <fwp_gc+0x1030>
    8f86:	48 8b 74 03 18       	mov    0x18(%rbx,%rax,1),%rsi
    8f8b:	e8 20 13 00 00       	call   a2b0 <fwp_gc_push>
    8f90:	e9 fb fe ff ff       	jmp    8e90 <fwp_gc_collect+0x150>
    8f95:	48 8d bd 50 fe ff ff 	lea    -0x1b0(%rbp),%rdi
    8f9c:	e8 0f a3 ff ff       	call   32b0 <_setjmp@plt>
    8fa1:	48 c7 05 dc 24 01 00 	movq   $0x0,0x124dc(%rip)        # 1b488 <fwp_gc+0x1200>
    8fa8:	00 00 00 00 
    8fac:	e8 cf 06 00 00       	call   9680 <fwp_gc_mark_all>
    8fb1:	e8 0a 08 00 00       	call   97c0 <fwp_gc_finalize>
    8fb6:	e8 35 09 00 00       	call   98f0 <fwp_gc_sweep>
    8fbb:	48 8b 05 9e 24 01 00 	mov    0x1249e(%rip),%rax        # 1b460 <fwp_gc+0x11d8>
    8fc2:	48 ff c0             	inc    %rax
    8fc5:	48 89 05 94 24 01 00 	mov    %rax,0x12494(%rip)        # 1b460 <fwp_gc+0x11d8>
    8fcc:	e9 0d 01 00 00       	jmp    90de <fwp_gc_collect+0x39e>
    8fd1:	48 8b 05 50 24 01 00 	mov    0x12450(%rip),%rax        # 1b428 <fwp_gc+0x11a0>
    8fd8:	48 85 c0             	test   %rax,%rax
    8fdb:	74 3a                	je     9017 <fwp_gc_collect+0x2d7>
    8fdd:	31 db                	xor    %ebx,%ebx
    8fdf:	90                   	nop
    8fe0:	48 8b 0d 39 24 01 00 	mov    0x12439(%rip),%rcx        # 1b420 <fwp_gc+0x1198>
    8fe7:	48 ff c8             	dec    %rax
    8fea:	48 89 05 37 24 01 00 	mov    %rax,0x12437(%rip)        # 1b428 <fwp_gc+0x11a0>
    8ff1:	48 c1 e0 04          	shl    $0x4,%rax
    8ff5:	48 8b 3c 01          	mov    (%rcx,%rax,1),%rdi
    8ff9:	48 8b 74 01 08       	mov    0x8(%rcx,%rax,1),%rsi
    8ffe:	48 01 fe             	add    %rdi,%rsi
    9001:	89 da                	mov    %ebx,%edx
    9003:	e8 88 0f 00 00       	call   9f90 <fwp_gc_scan>
    9008:	48 8b 0d 19 24 01 00 	mov    0x12419(%rip),%rcx        # 1b428 <fwp_gc+0x11a0>
    900f:	48 89 c8             	mov    %rcx,%rax
    9012:	48 85 c9             	test   %rcx,%rcx
    9015:	75 c9                	jne    8fe0 <fwp_gc_collect+0x2a0>
    9017:	83 3d 6e 22 01 00 00 	cmpl   $0x0,0x1226e(%rip)        # 1b28c <fwp_gc+0x1004>
    901e:	44 0f b6 65 d7       	movzbl -0x29(%rbp),%r12d
    9023:	0f 84 93 00 00 00    	je     90bc <fwp_gc_collect+0x37c>
    9029:	4c 8b 35 b0 22 01 00 	mov    0x122b0(%rip),%r14        # 1b2e0 <fwp_gc+0x1058>
    9030:	4c 89 f7             	mov    %r14,%rdi
    9033:	48 c1 e7 09          	shl    $0x9,%rdi
    9037:	e8 04 a3 ff ff       	call   3340 <malloc@plt>
    903c:	48 89 c3             	mov    %rax,%rbx
    903f:	49 83 fe 01          	cmp    $0x1,%r14
    9043:	4c 89 f7             	mov    %r14,%rdi
    9046:	48 83 d7 00          	adc    $0x0,%rdi
    904a:	48 89 bd 40 ff ff ff 	mov    %rdi,-0xc0(%rbp)
    9051:	e8 ea a2 ff ff       	call   3340 <malloc@plt>
    9056:	48 89 5d c8          	mov    %rbx,-0x38(%rbp)
    905a:	48 85 db             	test   %rbx,%rbx
    905d:	0f 84 ea 05 00 00    	je     964d <fwp_gc_collect+0x90d>
    9063:	48 85 c0             	test   %rax,%rax
    9066:	0f 84 e1 05 00 00    	je     964d <fwp_gc_collect+0x90d>
    906c:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
    9070:	48 89 4d a0          	mov    %rcx,-0x60(%rbp)
    9074:	49 89 c5             	mov    %rax,%r13
    9077:	4d 85 f6             	test   %r14,%r14
    907a:	74 2a                	je     90a6 <fwp_gc_collect+0x366>
    907c:	4c 89 6d b8          	mov    %r13,-0x48(%rbp)
    9080:	48 8b 0d 79 22 01 00 	mov    0x12279(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    9087:	49 83 fe 01          	cmp    $0x1,%r14
    908b:	4c 89 b5 48 ff ff ff 	mov    %r14,-0xb8(%rbp)
    9092:	48 89 8d 70 ff ff ff 	mov    %rcx,-0x90(%rbp)
    9099:	0f 85 79 01 00 00    	jne    9218 <fwp_gc_collect+0x4d8>
    909f:	31 c0                	xor    %eax,%eax
    90a1:	e9 f8 01 00 00       	jmp    929e <fwp_gc_collect+0x55e>
    90a6:	e8 d5 05 00 00       	call   9680 <fwp_gc_mark_all>
    90ab:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
    90af:	e8 9c 9f ff ff       	call   3050 <free@plt>
    90b4:	4c 89 ef             	mov    %r13,%rdi
    90b7:	e8 94 9f ff ff       	call   3050 <free@plt>
    90bc:	e8 ff 06 00 00       	call   97c0 <fwp_gc_finalize>
    90c1:	e8 2a 08 00 00       	call   98f0 <fwp_gc_sweep>
    90c6:	48 8b 05 93 23 01 00 	mov    0x12393(%rip),%rax        # 1b460 <fwp_gc+0x11d8>
    90cd:	48 ff c0             	inc    %rax
    90d0:	48 89 05 89 23 01 00 	mov    %rax,0x12389(%rip)        # 1b460 <fwp_gc+0x11d8>
    90d7:	48 ff 05 c2 21 01 00 	incq   0x121c2(%rip)        # 1b2a0 <fwp_gc+0x1018>
    90de:	48 89 c1             	mov    %rax,%rcx
    90e1:	48 8b 05 68 23 01 00 	mov    0x12368(%rip),%rax        # 1b450 <fwp_gc+0x11c8>
    90e8:	48 3b 05 69 23 01 00 	cmp    0x12369(%rip),%rax        # 1b458 <fwp_gc+0x11d0>
    90ef:	76 07                	jbe    90f8 <fwp_gc_collect+0x3b8>
    90f1:	48 89 05 60 23 01 00 	mov    %rax,0x12360(%rip)        # 1b458 <fwp_gc+0x11d0>
    90f8:	45 84 e4             	test   %r12b,%r12b
    90fb:	74 0b                	je     9108 <fwp_gc_collect+0x3c8>
    90fd:	48 89 05 94 21 01 00 	mov    %rax,0x12194(%rip)        # 1b298 <fwp_gc+0x1010>
    9104:	31 d2                	xor    %edx,%edx
    9106:	eb 2d                	jmp    9135 <fwp_gc_collect+0x3f5>
    9108:	48 8b 15 89 21 01 00 	mov    0x12189(%rip),%rdx        # 1b298 <fwp_gc+0x1010>
    910f:	48 89 d6             	mov    %rdx,%rsi
    9112:	48 d1 ee             	shr    $1,%rsi
    9115:	48 01 d6             	add    %rdx,%rsi
    9118:	48 81 fe 01 00 00 01 	cmp    $0x1000001,%rsi
    911f:	ba 00 00 00 01       	mov    $0x1000000,%edx
    9124:	48 0f 43 d6          	cmovae %rsi,%rdx
    9128:	31 f6                	xor    %esi,%esi
    912a:	48 39 d0             	cmp    %rdx,%rax
    912d:	0f 97 c2             	seta   %dl
    9130:	40 88 d6             	mov    %dl,%sil
    9133:	89 f2                	mov    %esi,%edx
    9135:	f6 c1 07             	test   $0x7,%cl
    9138:	b9 01 00 00 00       	mov    $0x1,%ecx
    913d:	0f 45 ca             	cmovne %edx,%ecx
    9140:	48 83 3d 60 21 01 00 	cmpq   $0x0,0x12160(%rip)        # 1b2a8 <fwp_gc+0x1020>
    9147:	00 
    9148:	0f 44 ca             	cmove  %edx,%ecx
    914b:	89 0d 3f 21 01 00    	mov    %ecx,0x1213f(%rip)        # 1b290 <fwp_gc+0x1008>
    9151:	83 3d 30 21 01 00 00 	cmpl   $0x0,0x12130(%rip)        # 1b288 <fwp_gc+0x1000>
    9158:	0f 94 c1             	sete   %cl
    915b:	48 d3 e0             	shl    %cl,%rax
    915e:	f2 48 0f 2c 0d 21 23 	cvttsd2si 0x12321(%rip),%rcx        # 1b488 <fwp_gc+0x1200>
    9165:	01 00 
    9167:	48 01 c1             	add    %rax,%rcx
    916a:	48 81 f9 01 00 80 00 	cmp    $0x800001,%rcx
    9171:	b8 00 00 80 00       	mov    $0x800000,%eax
    9176:	48 0f 4d c1          	cmovge %rcx,%rax
    917a:	48 89 05 17 23 01 00 	mov    %rax,0x12317(%rip)        # 1b498 <fwp_gc+0x1210>
    9181:	48 89 05 00 11 01 00 	mov    %rax,0x11100(%rip)        # 1a288 <fwp_gc>
    9188:	48 8d b5 30 ff ff ff 	lea    -0xd0(%rbp),%rsi
    918f:	bf 01 00 00 00       	mov    $0x1,%edi
    9194:	e8 97 9f ff ff       	call   3130 <clock_gettime@plt>
    9199:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    91a0:	48 8b 8d 38 ff ff ff 	mov    -0xc8(%rbp),%rcx
    91a7:	48 2b 85 20 ff ff ff 	sub    -0xe0(%rbp),%rax
    91ae:	f2 48 0f 2a c8       	cvtsi2sd %rax,%xmm1
    91b3:	f2 0f 59 0d f5 bf 00 	mulsd  0xbff5(%rip),%xmm1        # 151b0 <_IO_stdin_used+0x1b0>
    91ba:	00 
    91bb:	48 2b 8d 28 ff ff ff 	sub    -0xd8(%rbp),%rcx
    91c2:	0f 57 c0             	xorps  %xmm0,%xmm0
    91c5:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    91ca:	f2 0f 5e 05 e6 bf 00 	divsd  0xbfe6(%rip),%xmm0        # 151b8 <_IO_stdin_used+0x1b8>
    91d1:	00 
    91d2:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
    91d6:	f2 0f 10 0d 9a 22 01 	movsd  0x1229a(%rip),%xmm1        # 1b478 <fwp_gc+0x11f0>
    91dd:	00 
    91de:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
    91e2:	f2 0f 11 0d 8e 22 01 	movsd  %xmm1,0x1228e(%rip)        # 1b478 <fwp_gc+0x11f0>
    91e9:	00 
    91ea:	66 0f 2e 05 8e 22 01 	ucomisd 0x1228e(%rip),%xmm0        # 1b480 <fwp_gc+0x11f8>
    91f1:	00 
    91f2:	76 08                	jbe    91fc <fwp_gc_collect+0x4bc>
    91f4:	f2 0f 11 05 84 22 01 	movsd  %xmm0,0x12284(%rip)        # 1b480 <fwp_gc+0x11f8>
    91fb:	00 
    91fc:	c7 05 7a 20 01 00 00 	movl   $0x0,0x1207a(%rip)        # 1b280 <fwp_gc+0xff8>
    9203:	00 00 00 
    9206:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    920d:	5b                   	pop    %rbx
    920e:	41 5c                	pop    %r12
    9210:	41 5d                	pop    %r13
    9212:	41 5e                	pop    %r14
    9214:	41 5f                	pop    %r15
    9216:	5d                   	pop    %rbp
    9217:	c3                   	ret
    9218:	49 83 e6 fe          	and    $0xfffffffffffffffe,%r14
    921c:	4c 89 75 88          	mov    %r14,-0x78(%rbp)
    9220:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    9224:	48 8d 98 00 02 00 00 	lea    0x200(%rax),%rbx
    922b:	4c 8d a1 50 12 00 00 	lea    0x1250(%rcx),%r12
    9232:	31 c0                	xor    %eax,%eax
    9234:	89 c1                	mov    %eax,%ecx
    9236:	41 bd 00 02 00 00    	mov    $0x200,%r13d
    923c:	4c 8b 75 b8          	mov    -0x48(%rbp),%r14
    9240:	49 89 cf             	mov    %rcx,%r15
    9243:	48 8d bb 00 fe ff ff 	lea    -0x200(%rbx),%rdi
    924a:	49 8d b4 24 d8 ed ff 	lea    -0x1228(%r12),%rsi
    9251:	ff 
    9252:	4c 89 ea             	mov    %r13,%rdx
    9255:	e8 d6 a0 ff ff       	call   3330 <memcpy@plt>
    925a:	41 0f b6 84 24 b3 ed 	movzbl -0x124d(%r12),%eax
    9261:	ff ff 
    9263:	43 88 04 3e          	mov    %al,(%r14,%r15,1)
    9267:	48 89 df             	mov    %rbx,%rdi
    926a:	4c 89 e6             	mov    %r12,%rsi
    926d:	4c 89 ea             	mov    %r13,%rdx
    9270:	e8 bb a0 ff ff       	call   3330 <memcpy@plt>
    9275:	41 0f b6 44 24 db    	movzbl -0x25(%r12),%eax
    927b:	43 88 44 3e 01       	mov    %al,0x1(%r14,%r15,1)
    9280:	49 83 c7 02          	add    $0x2,%r15
    9284:	48 81 c3 00 04 00 00 	add    $0x400,%rbx
    928b:	49 81 c4 50 24 00 00 	add    $0x2450,%r12
    9292:	4c 89 f8             	mov    %r15,%rax
    9295:	4c 89 f9             	mov    %r15,%rcx
    9298:	4c 39 7d 88          	cmp    %r15,-0x78(%rbp)
    929c:	75 a2                	jne    9240 <fwp_gc_collect+0x500>
    929e:	48 89 c3             	mov    %rax,%rbx
    92a1:	4c 8b bd 48 ff ff ff 	mov    -0xb8(%rbp),%r15
    92a8:	44 89 f8             	mov    %r15d,%eax
    92ab:	41 f6 c7 01          	test   $0x1,%r15b
    92af:	44 0f b6 65 d7       	movzbl -0x29(%rbp),%r12d
    92b4:	48 8b 95 70 ff ff ff 	mov    -0x90(%rbp),%rdx
    92bb:	74 37                	je     92f4 <fwp_gc_collect+0x5b4>
    92bd:	48 89 df             	mov    %rbx,%rdi
    92c0:	48 c1 e7 09          	shl    $0x9,%rdi
    92c4:	48 03 7d c8          	add    -0x38(%rbp),%rdi
    92c8:	4c 69 f3 28 12 00 00 	imul   $0x1228,%rbx,%r14
    92cf:	4a 8d 34 32          	lea    (%rdx,%r14,1),%rsi
    92d3:	48 83 c6 28          	add    $0x28,%rsi
    92d7:	49 89 d5             	mov    %rdx,%r13
    92da:	ba 00 02 00 00       	mov    $0x200,%edx
    92df:	e8 4c a0 ff ff       	call   3330 <memcpy@plt>
    92e4:	4c 89 ea             	mov    %r13,%rdx
    92e7:	43 0f b6 44 35 03    	movzbl 0x3(%r13,%r14,1),%eax
    92ed:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
    92f1:	88 04 19             	mov    %al,(%rcx,%rbx,1)
    92f4:	45 31 ed             	xor    %r13d,%r13d
    92f7:	45 89 ee             	mov    %r13d,%r14d
    92fa:	4c 89 f3             	mov    %r14,%rbx
    92fd:	4c 89 f9             	mov    %r15,%rcx
    9300:	48 89 d0             	mov    %rdx,%rax
    9303:	eb 29                	jmp    932e <fwp_gc_collect+0x5ee>
    9305:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    930c:	00 00 00 00 
    9310:	42 c6 44 30 03 00    	movb   $0x0,0x3(%rax,%r14,1)
    9316:	48 89 ca             	mov    %rcx,%rdx
    9319:	48 89 de             	mov    %rbx,%rsi
    931c:	48 ff c6             	inc    %rsi
    931f:	49 81 c6 28 12 00 00 	add    $0x1228,%r14
    9326:	48 89 f3             	mov    %rsi,%rbx
    9329:	48 39 ce             	cmp    %rcx,%rsi
    932c:	73 3f                	jae    936d <fwp_gc_collect+0x62d>
    932e:	42 0f b6 14 30       	movzbl (%rax,%r14,1),%edx
    9333:	83 fa 02             	cmp    $0x2,%edx
    9336:	74 d8                	je     9310 <fwp_gc_collect+0x5d0>
    9338:	83 fa 01             	cmp    $0x1,%edx
    933b:	75 d9                	jne    9316 <fwp_gc_collect+0x5d6>
    933d:	4a 8d 3c 30          	lea    (%rax,%r14,1),%rdi
    9341:	48 83 c7 28          	add    $0x28,%rdi
    9345:	42 8b 44 30 0c       	mov    0xc(%rax,%r14,1),%eax
    934a:	83 c0 3f             	add    $0x3f,%eax
    934d:	c1 e8 03             	shr    $0x3,%eax
    9350:	83 e0 f8             	and    $0xfffffff8,%eax
    9353:	89 c2                	mov    %eax,%edx
    9355:	44 89 ee             	mov    %r13d,%esi
    9358:	e8 b3 9e ff ff       	call   3210 <memset@plt>
    935d:	48 8b 05 9c 1f 01 00 	mov    0x11f9c(%rip),%rax        # 1b300 <fwp_gc+0x1078>
    9364:	48 8b 0d 75 1f 01 00 	mov    0x11f75(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    936b:	eb a9                	jmp    9316 <fwp_gc_collect+0x5d6>
    936d:	e8 0e 03 00 00       	call   9680 <fwp_gc_mark_all>
    9372:	48 8b 05 87 1f 01 00 	mov    0x11f87(%rip),%rax        # 1b300 <fwp_gc+0x1078>
    9379:	48 8d 78 28          	lea    0x28(%rax),%rdi
    937d:	31 d2                	xor    %edx,%edx
    937f:	89 d6                	mov    %edx,%esi
    9381:	4c 8b 45 a0          	mov    -0x60(%rbp),%r8
    9385:	4c 8b 6d b8          	mov    -0x48(%rbp),%r13
    9389:	eb 35                	jmp    93c0 <fwp_gc_collect+0x680>
    938b:	4d 85 db             	test   %r11,%r11
    938e:	0f 85 c8 00 00 00    	jne    945c <fwp_gc_collect+0x71c>
    9394:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    939b:	00 00 00 00 00 
    93a0:	48 89 f1             	mov    %rsi,%rcx
    93a3:	48 ff c1             	inc    %rcx
    93a6:	49 81 c0 00 02 00 00 	add    $0x200,%r8
    93ad:	48 81 c7 28 12 00 00 	add    $0x1228,%rdi
    93b4:	48 89 ce             	mov    %rcx,%rsi
    93b7:	4c 39 f9             	cmp    %r15,%rcx
    93ba:	0f 84 eb fc ff ff    	je     90ab <fwp_gc_collect+0x36b>
    93c0:	48 69 ce 28 12 00 00 	imul   $0x1228,%rsi,%rcx
    93c7:	44 0f b6 0c 08       	movzbl (%rax,%rcx,1),%r9d
    93cc:	41 83 f9 02          	cmp    $0x2,%r9d
    93d0:	74 5e                	je     9430 <fwp_gc_collect+0x6f0>
    93d2:	41 83 f9 01          	cmp    $0x1,%r9d
    93d6:	75 c8                	jne    93a0 <fwp_gc_collect+0x660>
    93d8:	44 8b 4c 08 0c       	mov    0xc(%rax,%rcx,1),%r9d
    93dd:	41 83 c1 3f          	add    $0x3f,%r9d
    93e1:	41 83 f9 40          	cmp    $0x40,%r9d
    93e5:	72 b9                	jb     93a0 <fwp_gc_collect+0x660>
    93e7:	41 c1 e9 06          	shr    $0x6,%r9d
    93eb:	49 c7 c6 c0 ff ff ff 	mov    $0xffffffffffffffc0,%r14
    93f2:	89 d3                	mov    %edx,%ebx
    93f4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    93fb:	00 00 00 00 00 
    9400:	4d 89 f2             	mov    %r14,%r10
    9403:	4d 8b 1c d8          	mov    (%r8,%rbx,8),%r11
    9407:	49 f7 d3             	not    %r11
    940a:	4c 23 1c df          	and    (%rdi,%rbx,8),%r11
    940e:	48 ff c3             	inc    %rbx
    9411:	49 83 c2 40          	add    $0x40,%r10
    9415:	4c 39 cb             	cmp    %r9,%rbx
    9418:	0f 83 6d ff ff ff    	jae    938b <fwp_gc_collect+0x64b>
    941e:	4d 89 d6             	mov    %r10,%r14
    9421:	4d 85 db             	test   %r11,%r11
    9424:	74 da                	je     9400 <fwp_gc_collect+0x6c0>
    9426:	e9 60 ff ff ff       	jmp    938b <fwp_gc_collect+0x64b>
    942b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    9430:	80 7c 08 03 00       	cmpb   $0x0,0x3(%rax,%rcx,1)
    9435:	0f 84 65 ff ff ff    	je     93a0 <fwp_gc_collect+0x660>
    943b:	41 80 7c 35 00 00    	cmpb   $0x0,0x0(%r13,%rsi,1)
    9441:	0f 85 59 ff ff ff    	jne    93a0 <fwp_gc_collect+0x660>
    9447:	49 89 f7             	mov    %rsi,%r15
    944a:	49 c1 e7 10          	shl    $0x10,%r15
    944e:	4c 03 3d 63 1e 01 00 	add    0x11e63(%rip),%r15        # 1b2b8 <fwp_gc+0x1030>
    9455:	48 8b 5c 08 18       	mov    0x18(%rax,%rcx,1),%rbx
    945a:	eb 20                	jmp    947c <fwp_gc_collect+0x73c>
    945c:	f3 4d 0f bc fb       	tzcnt  %r11,%r15
    9461:	48 c1 e6 10          	shl    $0x10,%rsi
    9465:	48 03 35 4c 1e 01 00 	add    0x11e4c(%rip),%rsi        # 1b2b8 <fwp_gc+0x1030>
    946c:	4d 01 d7             	add    %r10,%r15
    946f:	8b 7c 08 08          	mov    0x8(%rax,%rcx,1),%edi
    9473:	89 fb                	mov    %edi,%ebx
    9475:	4c 0f af fb          	imul   %rbx,%r15
    9479:	49 01 f7             	add    %rsi,%r15
    947c:	48 8b 15 55 0b 01 00 	mov    0x10b55(%rip),%rdx        # 19fd8 <stderr@GLIBC_2.2.5>
    9483:	48 8b 3a             	mov    (%rdx),%rdi
    9486:	0f b6 4c 08 01       	movzbl 0x1(%rax,%rcx,1),%ecx
    948b:	48 8d 35 88 c6 00 00 	lea    0xc688(%rip),%rsi        # 15b1a <exec_in_fp0+0x2aa>
    9492:	45 31 f6             	xor    %r14d,%r14d
    9495:	44 89 f0             	mov    %r14d,%eax
    9498:	4c 89 fa             	mov    %r15,%rdx
    949b:	49 89 d8             	mov    %rbx,%r8
    949e:	44 88 75 d6          	mov    %r14b,-0x2a(%rbp)
    94a2:	e8 49 9e ff ff       	call   32f0 <fprintf@plt>
    94a7:	48 89 de             	mov    %rbx,%rsi
    94aa:	4c 01 fe             	add    %r15,%rsi
    94ad:	44 89 f0             	mov    %r14d,%eax
    94b0:	48 89 c1             	mov    %rax,%rcx
    94b3:	48 89 b5 50 ff ff ff 	mov    %rsi,-0xb0(%rbp)
    94ba:	eb 24                	jmp    94e0 <fwp_gc_collect+0x7a0>
    94bc:	0f 1f 40 00          	nopl   0x0(%rax)
    94c0:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
    94c4:	48 ff c2             	inc    %rdx
    94c7:	48 89 f8             	mov    %rdi,%rax
    94ca:	48 05 00 00 01 00    	add    $0x10000,%rax
    94d0:	48 89 d1             	mov    %rdx,%rcx
    94d3:	48 3b 95 40 ff ff ff 	cmp    -0xc0(%rbp),%rdx
    94da:	0f 84 68 01 00 00    	je     9648 <fwp_gc_collect+0x908>
    94e0:	48 89 c7             	mov    %rax,%rdi
    94e3:	48 8b 05 16 1e 01 00 	mov    0x11e16(%rip),%rax        # 1b300 <fwp_gc+0x1078>
    94ea:	48 89 4d a8          	mov    %rcx,-0x58(%rbp)
    94ee:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    94f5:	80 3c 08 01          	cmpb   $0x1,(%rax,%rcx,1)
    94f9:	75 c5                	jne    94c0 <fwp_gc_collect+0x780>
    94fb:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    9500:	74 be                	je     94c0 <fwp_gc_collect+0x780>
    9502:	8b 54 08 0c          	mov    0xc(%rax,%rcx,1),%edx
    9506:	85 d2                	test   %edx,%edx
    9508:	74 b6                	je     94c0 <fwp_gc_collect+0x780>
    950a:	4c 8d 0c 08          	lea    (%rax,%rcx,1),%r9
    950e:	49 ff c1             	inc    %r9
    9511:	48 8b 4d a8          	mov    -0x58(%rbp),%rcx
    9515:	48 89 c8             	mov    %rcx,%rax
    9518:	48 c1 e0 10          	shl    $0x10,%rax
    951c:	48 89 85 60 ff ff ff 	mov    %rax,-0xa0(%rbp)
    9523:	31 c0                	xor    %eax,%eax
    9525:	41 89 c5             	mov    %eax,%r13d
    9528:	48 89 c8             	mov    %rcx,%rax
    952b:	48 c1 e0 09          	shl    $0x9,%rax
    952f:	49 89 c0             	mov    %rax,%r8
    9532:	4c 03 45 c8          	add    -0x38(%rbp),%r8
    9536:	89 d0                	mov    %edx,%eax
    9538:	48 89 bd 58 ff ff ff 	mov    %rdi,-0xa8(%rbp)
    953f:	4c 89 85 68 ff ff ff 	mov    %r8,-0x98(%rbp)
    9546:	eb 35                	jmp    957d <fwp_gc_collect+0x83d>
    9548:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    954f:	00 
    9550:	41 8b 41 0b          	mov    0xb(%r9),%eax
    9554:	48 8b bd 58 ff ff ff 	mov    -0xa8(%rbp),%rdi
    955b:	4c 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%r8
    9562:	4c 8b ad 78 ff ff ff 	mov    -0x88(%rbp),%r13
    9569:	4c 89 e9             	mov    %r13,%rcx
    956c:	48 ff c1             	inc    %rcx
    956f:	89 c2                	mov    %eax,%edx
    9571:	49 89 cd             	mov    %rcx,%r13
    9574:	48 39 d1             	cmp    %rdx,%rcx
    9577:	0f 83 43 ff ff ff    	jae    94c0 <fwp_gc_collect+0x780>
    957d:	4c 89 e9             	mov    %r13,%rcx
    9580:	48 c1 e9 06          	shr    $0x6,%rcx
    9584:	49 8b 0c c8          	mov    (%r8,%rcx,8),%rcx
    9588:	4c 0f a3 e9          	bt     %r13,%rcx
    958c:	73 db                	jae    9569 <fwp_gc_collect+0x829>
    958e:	41 8b 49 07          	mov    0x7(%r9),%ecx
    9592:	41 89 cc             	mov    %ecx,%r12d
    9595:	49 83 fc 08          	cmp    $0x8,%r12
    9599:	72 ce                	jb     9569 <fwp_gc_collect+0x829>
    959b:	4c 8b 35 16 1d 01 00 	mov    0x11d16(%rip),%r14        # 1b2b8 <fwp_gc+0x1030>
    95a2:	48 8b 8d 60 ff ff ff 	mov    -0xa0(%rbp),%rcx
    95a9:	4c 01 f1             	add    %r14,%rcx
    95ac:	48 89 4d 80          	mov    %rcx,-0x80(%rbp)
    95b0:	45 89 e0             	mov    %r12d,%r8d
    95b3:	4c 89 ad 78 ff ff ff 	mov    %r13,-0x88(%rbp)
    95ba:	4d 0f af e5          	imul   %r13,%r12
    95be:	49 01 fe             	add    %rdi,%r14
    95c1:	4d 01 e6             	add    %r12,%r14
    95c4:	31 c0                	xor    %eax,%eax
    95c6:	89 c3                	mov    %eax,%ebx
    95c8:	eb 1e                	jmp    95e8 <fwp_gc_collect+0x8a8>
    95ca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    95d0:	44 89 c0             	mov    %r8d,%eax
    95d3:	48 89 d9             	mov    %rbx,%rcx
    95d6:	48 ff c1             	inc    %rcx
    95d9:	c1 e8 03             	shr    $0x3,%eax
    95dc:	48 89 cb             	mov    %rcx,%rbx
    95df:	48 39 c1             	cmp    %rax,%rcx
    95e2:	0f 83 68 ff ff ff    	jae    9550 <fwp_gc_collect+0x810>
    95e8:	49 8b 04 de          	mov    (%r14,%rbx,8),%rax
    95ec:	4c 39 f8             	cmp    %r15,%rax
    95ef:	72 df                	jb     95d0 <fwp_gc_collect+0x890>
    95f1:	48 39 f0             	cmp    %rsi,%rax
    95f4:	73 da                	jae    95d0 <fwp_gc_collect+0x890>
    95f6:	48 8b 05 db 09 01 00 	mov    0x109db(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    95fd:	48 8b 38             	mov    (%rax),%rdi
    9600:	41 0f b6 09          	movzbl (%r9),%ecx
    9604:	48 8b 45 80          	mov    -0x80(%rbp),%rax
    9608:	4a 8d 14 20          	lea    (%rax,%r12,1),%rdx
    960c:	66 42 0f 10 04 20    	movupd (%rax,%r12,1),%xmm0
    9612:	4a 8b 44 20 10       	mov    0x10(%rax,%r12,1),%rax
    9617:	48 89 e6             	mov    %rsp,%rsi
    961a:	48 89 46 10          	mov    %rax,0x10(%rsi)
    961e:	66 0f 11 06          	movupd %xmm0,(%rsi)
    9622:	48 8d 35 4b c5 00 00 	lea    0xc54b(%rip),%rsi        # 15b74 <exec_in_fp0+0x304>
    9629:	4d 89 cd             	mov    %r9,%r13
    962c:	49 89 d9             	mov    %rbx,%r9
    962f:	0f b6 45 d6          	movzbl -0x2a(%rbp),%eax
    9633:	e8 b8 9c ff ff       	call   32f0 <fprintf@plt>
    9638:	4d 89 e9             	mov    %r13,%r9
    963b:	48 8b b5 50 ff ff ff 	mov    -0xb0(%rbp),%rsi
    9642:	45 8b 45 07          	mov    0x7(%r13),%r8d
    9646:	eb 88                	jmp    95d0 <fwp_gc_collect+0x890>
    9648:	e8 23 9a ff ff       	call   3070 <abort@plt>
    964d:	48 8b 05 84 09 01 00 	mov    0x10984(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    9654:	48 8b 08             	mov    (%rax),%rcx
    9657:	48 8d 3d a8 c4 00 00 	lea    0xc4a8(%rip),%rdi        # 15b06 <exec_in_fp0+0x296>
    965e:	be 13 00 00 00       	mov    $0x13,%esi
    9663:	ba 01 00 00 00       	mov    $0x1,%edx
    9668:	e8 13 9e ff ff       	call   3480 <fwrite@plt>
    966d:	bf 66 00 00 00       	mov    $0x66,%edi
    9672:	e8 e9 9d ff ff       	call   3460 <exit@plt>
    9677:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    967e:	00 00 

0000000000009680 <fwp_gc_mark_all>:
    9680:	41 57                	push   %r15
    9682:	41 56                	push   %r14
    9684:	41 55                	push   %r13
    9686:	41 54                	push   %r12
    9688:	53                   	push   %rbx
    9689:	e8 f2 08 00 00       	call   9f80 <fwp_gc_sp>
    968e:	48 85 c0             	test   %rax,%rax
    9691:	74 56                	je     96e9 <fwp_gc_mark_all+0x69>
    9693:	48 8b 35 76 1c 01 00 	mov    0x11c76(%rip),%rsi        # 1b310 <fwp_gc+0x1088>
    969a:	48 89 f1             	mov    %rsi,%rcx
    969d:	48 29 c1             	sub    %rax,%rcx
    96a0:	76 47                	jbe    96e9 <fwp_gc_mark_all+0x69>
    96a2:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    96a7:	f2 0f 58 05 d9 1d 01 	addsd  0x11dd9(%rip),%xmm0        # 1b488 <fwp_gc+0x1200>
    96ae:	00 
    96af:	f2 0f 11 05 d1 1d 01 	movsd  %xmm0,0x11dd1(%rip)        # 1b488 <fwp_gc+0x1200>
    96b6:	00 
    96b7:	48 89 c7             	mov    %rax,%rdi
    96ba:	ba 01 00 00 00       	mov    $0x1,%edx
    96bf:	eb 23                	jmp    96e4 <fwp_gc_mark_all+0x64>
    96c1:	48 8b 0d 58 1d 01 00 	mov    0x11d58(%rip),%rcx        # 1b420 <fwp_gc+0x1198>
    96c8:	48 ff c8             	dec    %rax
    96cb:	48 89 05 56 1d 01 00 	mov    %rax,0x11d56(%rip)        # 1b428 <fwp_gc+0x11a0>
    96d2:	48 c1 e0 04          	shl    $0x4,%rax
    96d6:	48 8b 3c 01          	mov    (%rcx,%rax,1),%rdi
    96da:	48 8b 74 01 08       	mov    0x8(%rcx,%rax,1),%rsi
    96df:	48 01 fe             	add    %rdi,%rsi
    96e2:	31 d2                	xor    %edx,%edx
    96e4:	e8 a7 08 00 00       	call   9f90 <fwp_gc_scan>
    96e9:	48 8b 05 38 1d 01 00 	mov    0x11d38(%rip),%rax        # 1b428 <fwp_gc+0x11a0>
    96f0:	48 85 c0             	test   %rax,%rax
    96f3:	75 cc                	jne    96c1 <fwp_gc_mark_all+0x41>
    96f5:	83 3d 1c 1d 01 00 00 	cmpl   $0x0,0x11d1c(%rip)        # 1b418 <fwp_gc+0x1190>
    96fc:	0f 8e b2 00 00 00    	jle    97b4 <fwp_gc_mark_all+0x134>
    9702:	4c 8d 25 17 1c 01 00 	lea    0x11c17(%rip),%r12        # 1b320 <fwp_gc+0x1098>
    9709:	45 31 ed             	xor    %r13d,%r13d
    970c:	48 8d 1d 75 0b 01 00 	lea    0x10b75(%rip),%rbx        # 1a288 <fwp_gc>
    9713:	4c 8d 35 8e 25 01 00 	lea    0x1258e(%rip),%r14        # 1bca8 <fc13>
    971a:	eb 21                	jmp    973d <fwp_gc_mark_all+0xbd>
    971c:	0f 1f 40 00          	nopl   0x0(%rax)
    9720:	4c 89 fe             	mov    %r15,%rsi
    9723:	31 d2                	xor    %edx,%edx
    9725:	e8 66 08 00 00       	call   9f90 <fwp_gc_scan>
    972a:	49 ff c5             	inc    %r13
    972d:	48 63 05 e4 1c 01 00 	movslq 0x11ce4(%rip),%rax        # 1b418 <fwp_gc+0x1190>
    9734:	49 83 c4 10          	add    $0x10,%r12
    9738:	49 39 c5             	cmp    %rax,%r13
    973b:	7d 6b                	jge    97a8 <fwp_gc_mark_all+0x128>
    973d:	49 8b 7c 24 f8       	mov    -0x8(%r12),%rdi
    9742:	49 8b 04 24          	mov    (%r12),%rax
    9746:	4c 8d 3c 07          	lea    (%rdi,%rax,1),%r15
    974a:	0f 57 c0             	xorps  %xmm0,%xmm0
    974d:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    9752:	f2 0f 58 05 2e 1d 01 	addsd  0x11d2e(%rip),%xmm0        # 1b488 <fwp_gc+0x1200>
    9759:	00 
    975a:	f2 0f 11 05 26 1d 01 	movsd  %xmm0,0x11d26(%rip)        # 1b488 <fwp_gc+0x1200>
    9761:	00 
    9762:	48 39 df             	cmp    %rbx,%rdi
    9765:	77 b9                	ja     9720 <fwp_gc_mark_all+0xa0>
    9767:	4d 39 f7             	cmp    %r14,%r15
    976a:	72 b4                	jb     9720 <fwp_gc_mark_all+0xa0>
    976c:	48 89 de             	mov    %rbx,%rsi
    976f:	31 d2                	xor    %edx,%edx
    9771:	e8 1a 08 00 00       	call   9f90 <fwp_gc_scan>
    9776:	4c 89 f7             	mov    %r14,%rdi
    9779:	eb a5                	jmp    9720 <fwp_gc_mark_all+0xa0>
    977b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    9780:	48 8b 0d 99 1c 01 00 	mov    0x11c99(%rip),%rcx        # 1b420 <fwp_gc+0x1198>
    9787:	48 ff c8             	dec    %rax
    978a:	48 89 05 97 1c 01 00 	mov    %rax,0x11c97(%rip)        # 1b428 <fwp_gc+0x11a0>
    9791:	48 c1 e0 04          	shl    $0x4,%rax
    9795:	48 8b 3c 01          	mov    (%rcx,%rax,1),%rdi
    9799:	48 8b 74 01 08       	mov    0x8(%rcx,%rax,1),%rsi
    979e:	48 01 fe             	add    %rdi,%rsi
    97a1:	31 d2                	xor    %edx,%edx
    97a3:	e8 e8 07 00 00       	call   9f90 <fwp_gc_scan>
    97a8:	48 8b 05 79 1c 01 00 	mov    0x11c79(%rip),%rax        # 1b428 <fwp_gc+0x11a0>
    97af:	48 85 c0             	test   %rax,%rax
    97b2:	75 cc                	jne    9780 <fwp_gc_mark_all+0x100>
    97b4:	5b                   	pop    %rbx
    97b5:	41 5c                	pop    %r12
    97b7:	41 5d                	pop    %r13
    97b9:	41 5e                	pop    %r14
    97bb:	41 5f                	pop    %r15
    97bd:	c3                   	ret
    97be:	66 90                	xchg   %ax,%ax

00000000000097c0 <fwp_gc_finalize>:
    97c0:	48 8b 0d 79 1c 01 00 	mov    0x11c79(%rip),%rcx        # 1b440 <fwp_gc+0x11b8>
    97c7:	48 85 c9             	test   %rcx,%rcx
    97ca:	0f 84 10 01 00 00    	je     98e0 <fwp_gc_finalize+0x120>
    97d0:	41 56                	push   %r14
    97d2:	53                   	push   %rbx
    97d3:	50                   	push   %rax
    97d4:	48 8b 35 5d 1c 01 00 	mov    0x11c5d(%rip),%rsi        # 1b438 <fwp_gc+0x11b0>
    97db:	4c 8b 05 d6 1a 01 00 	mov    0x11ad6(%rip),%r8        # 1b2b8 <fwp_gc+0x1030>
    97e2:	4c 8b 0d f7 1a 01 00 	mov    0x11af7(%rip),%r9        # 1b2e0 <fwp_gc+0x1058>
    97e9:	31 db                	xor    %ebx,%ebx
    97eb:	eb 0f                	jmp    97fc <fwp_gc_finalize+0x3c>
    97ed:	0f 1f 00             	nopl   (%rax)
    97f0:	48 ff c3             	inc    %rbx
    97f3:	48 39 cb             	cmp    %rcx,%rbx
    97f6:	0f 83 dd 00 00 00    	jae    98d9 <fwp_gc_finalize+0x119>
    97fc:	49 89 da             	mov    %rbx,%r10
    97ff:	49 c1 e2 04          	shl    $0x4,%r10
    9803:	4a 8b 3c 16          	mov    (%rsi,%r10,1),%rdi
    9807:	48 89 f8             	mov    %rdi,%rax
    980a:	4c 29 c0             	sub    %r8,%rax
    980d:	4c 89 ca             	mov    %r9,%rdx
    9810:	48 c1 e2 10          	shl    $0x10,%rdx
    9814:	48 39 d0             	cmp    %rdx,%rax
    9817:	73 d7                	jae    97f0 <fwp_gc_finalize+0x30>
    9819:	4c 8b 1d e0 1a 01 00 	mov    0x11ae0(%rip),%r11        # 1b300 <fwp_gc+0x1078>
    9820:	4d 85 db             	test   %r11,%r11
    9823:	74 cb                	je     97f0 <fwp_gc_finalize+0x30>
    9825:	48 c1 e8 10          	shr    $0x10,%rax
    9829:	48 69 d0 28 12 00 00 	imul   $0x1228,%rax,%rdx
    9830:	41 0f b6 04 13       	movzbl (%r11,%rdx,1),%eax
    9835:	3c 03                	cmp    $0x3,%al
    9837:	75 16                	jne    984f <fwp_gc_finalize+0x8f>
    9839:	41 8b 44 13 10       	mov    0x10(%r11,%rdx,1),%eax
    983e:	48 69 d0 28 12 00 00 	imul   $0x1228,%rax,%rdx
    9845:	41 0f b6 04 13       	movzbl (%r11,%rdx,1),%eax
    984a:	49 01 d3             	add    %rdx,%r11
    984d:	eb 03                	jmp    9852 <fwp_gc_finalize+0x92>
    984f:	49 01 d3             	add    %rdx,%r11
    9852:	4e 8b 74 16 08       	mov    0x8(%rsi,%r10,1),%r14
    9857:	3c 01                	cmp    $0x1,%al
    9859:	74 13                	je     986e <fwp_gc_finalize+0xae>
    985b:	0f b6 c0             	movzbl %al,%eax
    985e:	83 f8 02             	cmp    $0x2,%eax
    9861:	75 35                	jne    9898 <fwp_gc_finalize+0xd8>
    9863:	41 0f b6 53 03       	movzbl 0x3(%r11),%edx
    9868:	85 d2                	test   %edx,%edx
    986a:	75 84                	jne    97f0 <fwp_gc_finalize+0x30>
    986c:	eb 2a                	jmp    9898 <fwp_gc_finalize+0xd8>
    986e:	0f b7 c7             	movzwl %di,%eax
    9871:	31 d2                	xor    %edx,%edx
    9873:	41 f7 73 08          	divl   0x8(%r11)
    9877:	89 c2                	mov    %eax,%edx
    9879:	c1 ea 03             	shr    $0x3,%edx
    987c:	81 e2 f8 1f 00 00    	and    $0x1ff8,%edx
    9882:	4d 8b 5c 13 28       	mov    0x28(%r11,%rdx,1),%r11
    9887:	31 d2                	xor    %edx,%edx
    9889:	49 0f a3 c3          	bt     %rax,%r11
    988d:	0f 92 c2             	setb   %dl
    9890:	85 d2                	test   %edx,%edx
    9892:	0f 85 58 ff ff ff    	jne    97f0 <fwp_gc_finalize+0x30>
    9898:	49 01 f2             	add    %rsi,%r10
    989b:	48 ff c9             	dec    %rcx
    989e:	48 89 0d 9b 1b 01 00 	mov    %rcx,0x11b9b(%rip)        # 1b440 <fwp_gc+0x11b8>
    98a5:	48 c1 e1 04          	shl    $0x4,%rcx
    98a9:	0f 10 04 0e          	movups (%rsi,%rcx,1),%xmm0
    98ad:	41 0f 11 02          	movups %xmm0,(%r10)
    98b1:	41 ff d6             	call   *%r14
    98b4:	48 8b 35 7d 1b 01 00 	mov    0x11b7d(%rip),%rsi        # 1b438 <fwp_gc+0x11b0>
    98bb:	4c 8b 05 f6 19 01 00 	mov    0x119f6(%rip),%r8        # 1b2b8 <fwp_gc+0x1030>
    98c2:	4c 8b 0d 17 1a 01 00 	mov    0x11a17(%rip),%r9        # 1b2e0 <fwp_gc+0x1058>
    98c9:	48 8b 0d 70 1b 01 00 	mov    0x11b70(%rip),%rcx        # 1b440 <fwp_gc+0x11b8>
    98d0:	48 39 cb             	cmp    %rcx,%rbx
    98d3:	0f 82 23 ff ff ff    	jb     97fc <fwp_gc_finalize+0x3c>
    98d9:	48 83 c4 08          	add    $0x8,%rsp
    98dd:	5b                   	pop    %rbx
    98de:	41 5e                	pop    %r14
    98e0:	c3                   	ret
    98e1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    98e8:	0f 1f 84 00 00 00 00 
    98ef:	00 

00000000000098f0 <fwp_gc_sweep>:
    98f0:	55                   	push   %rbp
    98f1:	41 57                	push   %r15
    98f3:	41 56                	push   %r14
    98f5:	41 55                	push   %r13
    98f7:	41 54                	push   %r12
    98f9:	53                   	push   %rbx
    98fa:	48 83 ec 28          	sub    $0x28,%rsp
    98fe:	48 8d 3d 8b 09 01 00 	lea    0x1098b(%rip),%rdi        # 1a290 <fwp_gc+0x8>
    9905:	31 ed                	xor    %ebp,%ebp
    9907:	ba 40 0b 00 00       	mov    $0xb40,%edx
    990c:	31 f6                	xor    %esi,%esi
    990e:	e8 fd 98 ff ff       	call   3210 <memset@plt>
    9913:	48 83 3d c5 19 01 00 	cmpq   $0x0,0x119c5(%rip)        # 1b2e0 <fwp_gc+0x1058>
    991a:	00 
    991b:	0f 84 0f 05 00 00    	je     9e30 <fwp_gc_sweep+0x540>
    9921:	31 c0                	xor    %eax,%eax
    9923:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    9928:	49 b9 55 55 55 55 55 	movabs $0x5555555555555555,%r9
    992f:	55 55 55 
    9932:	49 ba 33 33 33 33 33 	movabs $0x3333333333333333,%r10
    9939:	33 33 33 
    993c:	49 bb 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r11
    9943:	0f 0f 0f 
    9946:	49 bc 01 01 01 01 01 	movabs $0x101010101010101,%r12
    994d:	01 01 01 
    9950:	66 0f 6f 2d 68 b7 00 	movdqa 0xb768(%rip),%xmm5        # 150c0 <_IO_stdin_used+0xc0>
    9957:	00 
    9958:	66 0f 6f 35 70 b7 00 	movdqa 0xb770(%rip),%xmm6        # 150d0 <_IO_stdin_used+0xd0>
    995f:	00 
    9960:	66 0f 6f 3d 78 b7 00 	movdqa 0xb778(%rip),%xmm7        # 150e0 <_IO_stdin_used+0xe0>
    9967:	00 
    9968:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    996d:	31 ed                	xor    %ebp,%ebp
    996f:	45 31 ed             	xor    %r13d,%r13d
    9972:	eb 22                	jmp    9996 <fwp_gc_sweep+0xa6>
    9974:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    997b:	00 00 00 00 00 
    9980:	48 ff c5             	inc    %rbp
    9983:	49 ff c5             	inc    %r13
    9986:	48 8b 05 53 19 01 00 	mov    0x11953(%rip),%rax        # 1b2e0 <fwp_gc+0x1058>
    998d:	49 39 c5             	cmp    %rax,%r13
    9990:	0f 83 a3 04 00 00    	jae    9e39 <fwp_gc_sweep+0x549>
    9996:	48 8b 1d 63 19 01 00 	mov    0x11963(%rip),%rbx        # 1b300 <fwp_gc+0x1078>
    999d:	4d 69 f5 28 12 00 00 	imul   $0x1228,%r13,%r14
    99a4:	42 0f b6 04 33       	movzbl (%rbx,%r14,1),%eax
    99a9:	85 c0                	test   %eax,%eax
    99ab:	74 d3                	je     9980 <fwp_gc_sweep+0x90>
    99ad:	83 f8 01             	cmp    $0x1,%eax
    99b0:	74 2e                	je     99e0 <fwp_gc_sweep+0xf0>
    99b2:	83 f8 02             	cmp    $0x2,%eax
    99b5:	75 cc                	jne    9983 <fwp_gc_sweep+0x93>
    99b7:	46 8b 64 33 10       	mov    0x10(%rbx,%r14,1),%r12d
    99bc:	42 80 7c 33 03 00    	cmpb   $0x0,0x3(%rbx,%r14,1)
    99c2:	74 50                	je     9a14 <fwp_gc_sweep+0x124>
    99c4:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    99c9:	4a 03 44 33 18       	add    0x18(%rbx,%r14,1),%rax
    99ce:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    99d3:	e9 fb 03 00 00       	jmp    9dd3 <fwp_gc_sweep+0x4e3>
    99d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    99df:	00 
    99e0:	4a 8d 04 33          	lea    (%rbx,%r14,1),%rax
    99e4:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    99e9:	46 8b 7c 33 0c       	mov    0xc(%rbx,%r14,1),%r15d
    99ee:	4d 85 ff             	test   %r15,%r15
    99f1:	0f 84 b5 02 00 00    	je     9cac <fwp_gc_sweep+0x3bc>
    99f7:	49 8d 57 3f          	lea    0x3f(%r15),%rdx
    99fb:	48 89 d0             	mov    %rdx,%rax
    99fe:	48 c1 e8 06          	shr    $0x6,%rax
    9a02:	41 81 ff c1 00 00 00 	cmp    $0xc1,%r15d
    9a09:	73 48                	jae    9a53 <fwp_gc_sweep+0x163>
    9a0b:	31 d2                	xor    %edx,%edx
    9a0d:	31 c9                	xor    %ecx,%ecx
    9a0f:	e9 1b 01 00 00       	jmp    9b2f <fwp_gc_sweep+0x23f>
    9a14:	4e 8d 3c 33          	lea    (%rbx,%r14,1),%r15
    9a18:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    9a1f:	42 80 bc 33 28 02 00 	cmpb   $0xff,0x228(%rbx,%r14,1)
    9a26:	00 ff 
    9a28:	0f 84 d8 03 00 00    	je     9e06 <fwp_gc_sweep+0x516>
    9a2e:	41 c6 07 00          	movb   $0x0,(%r15)
    9a32:	4d 85 e4             	test   %r12,%r12
    9a35:	0f 84 95 03 00 00    	je     9dd0 <fwp_gc_sweep+0x4e0>
    9a3b:	48 8b 05 be 18 01 00 	mov    0x118be(%rip),%rax        # 1b300 <fwp_gc+0x1078>
    9a42:	41 83 fc 04          	cmp    $0x4,%r12d
    9a46:	0f 83 15 03 00 00    	jae    9d61 <fwp_gc_sweep+0x471>
    9a4c:	31 c9                	xor    %ecx,%ecx
    9a4e:	e9 45 03 00 00       	jmp    9d98 <fwp_gc_sweep+0x4a8>
    9a53:	89 c1                	mov    %eax,%ecx
    9a55:	83 e1 fc             	and    $0xfffffffc,%ecx
    9a58:	4a 8d 34 33          	lea    (%rbx,%r14,1),%rsi
    9a5c:	48 83 c6 38          	add    $0x38,%rsi
    9a60:	48 c1 ea 03          	shr    $0x3,%rdx
    9a64:	83 e2 e0             	and    $0xffffffe0,%edx
    9a67:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9a6b:	31 ff                	xor    %edi,%edi
    9a6d:	66 0f ef c9          	pxor   %xmm1,%xmm1
    9a71:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9a78:	0f 1f 84 00 00 00 00 
    9a7f:	00 
    9a80:	f3 0f 6f 5c 3e f0    	movdqu -0x10(%rsi,%rdi,1),%xmm3
    9a86:	f3 0f 6f 14 3e       	movdqu (%rsi,%rdi,1),%xmm2
    9a8b:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    9a8f:	66 0f 71 d4 01       	psrlw  $0x1,%xmm4
    9a94:	66 0f db e5          	pand   %xmm5,%xmm4
    9a98:	66 0f f8 dc          	psubb  %xmm4,%xmm3
    9a9c:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    9aa0:	66 0f db e6          	pand   %xmm6,%xmm4
    9aa4:	66 0f 71 d3 02       	psrlw  $0x2,%xmm3
    9aa9:	66 0f db de          	pand   %xmm6,%xmm3
    9aad:	66 0f fc dc          	paddb  %xmm4,%xmm3
    9ab1:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    9ab5:	66 0f 71 d4 04       	psrlw  $0x4,%xmm4
    9aba:	66 0f fc e3          	paddb  %xmm3,%xmm4
    9abe:	66 0f db e7          	pand   %xmm7,%xmm4
    9ac2:	66 41 0f f6 e0       	psadbw %xmm8,%xmm4
    9ac7:	66 0f d4 c4          	paddq  %xmm4,%xmm0
    9acb:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9acf:	66 0f 71 d3 01       	psrlw  $0x1,%xmm3
    9ad4:	66 0f db dd          	pand   %xmm5,%xmm3
    9ad8:	66 0f f8 d3          	psubb  %xmm3,%xmm2
    9adc:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9ae0:	66 0f db de          	pand   %xmm6,%xmm3
    9ae4:	66 0f 71 d2 02       	psrlw  $0x2,%xmm2
    9ae9:	66 0f db d6          	pand   %xmm6,%xmm2
    9aed:	66 0f fc d3          	paddb  %xmm3,%xmm2
    9af1:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9af5:	66 0f 71 d3 04       	psrlw  $0x4,%xmm3
    9afa:	66 0f fc da          	paddb  %xmm2,%xmm3
    9afe:	66 0f db df          	pand   %xmm7,%xmm3
    9b02:	66 41 0f f6 d8       	psadbw %xmm8,%xmm3
    9b07:	66 0f d4 cb          	paddq  %xmm3,%xmm1
    9b0b:	48 83 c7 20          	add    $0x20,%rdi
    9b0f:	48 39 fa             	cmp    %rdi,%rdx
    9b12:	0f 85 68 ff ff ff    	jne    9a80 <fwp_gc_sweep+0x190>
    9b18:	66 0f d4 c8          	paddq  %xmm0,%xmm1
    9b1c:	66 0f 70 c1 ee       	pshufd $0xee,%xmm1,%xmm0
    9b21:	66 0f d4 c1          	paddq  %xmm1,%xmm0
    9b25:	66 48 0f 7e c2       	movq   %xmm0,%rdx
    9b2a:	48 39 c8             	cmp    %rcx,%rax
    9b2d:	74 51                	je     9b80 <fwp_gc_sweep+0x290>
    9b2f:	4a 8d 34 33          	lea    (%rbx,%r14,1),%rsi
    9b33:	48 83 c6 28          	add    $0x28,%rsi
    9b37:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    9b3e:	00 00 
    9b40:	48 8b 3c ce          	mov    (%rsi,%rcx,8),%rdi
    9b44:	49 89 f8             	mov    %rdi,%r8
    9b47:	49 d1 e8             	shr    $1,%r8
    9b4a:	4d 21 c8             	and    %r9,%r8
    9b4d:	4c 29 c7             	sub    %r8,%rdi
    9b50:	49 89 f8             	mov    %rdi,%r8
    9b53:	4d 21 d0             	and    %r10,%r8
    9b56:	48 c1 ef 02          	shr    $0x2,%rdi
    9b5a:	4c 21 d7             	and    %r10,%rdi
    9b5d:	4c 01 c7             	add    %r8,%rdi
    9b60:	49 89 f8             	mov    %rdi,%r8
    9b63:	49 c1 e8 04          	shr    $0x4,%r8
    9b67:	49 01 f8             	add    %rdi,%r8
    9b6a:	4d 21 d8             	and    %r11,%r8
    9b6d:	4d 0f af c4          	imul   %r12,%r8
    9b71:	49 c1 e8 38          	shr    $0x38,%r8
    9b75:	4c 01 c2             	add    %r8,%rdx
    9b78:	48 ff c1             	inc    %rcx
    9b7b:	48 39 c8             	cmp    %rcx,%rax
    9b7e:	75 c0                	jne    9b40 <fwp_gc_sweep+0x250>
    9b80:	48 85 d2             	test   %rdx,%rdx
    9b83:	0f 84 23 01 00 00    	je     9cac <fwp_gc_sweep+0x3bc>
    9b89:	42 8b 44 33 08       	mov    0x8(%rbx,%r14,1),%eax
    9b8e:	48 0f af d0          	imul   %rax,%rdx
    9b92:	48 01 54 24 08       	add    %rdx,0x8(%rsp)
    9b97:	4d 85 ff             	test   %r15,%r15
    9b9a:	0f 84 e3 fd ff ff    	je     9983 <fwp_gc_sweep+0x93>
    9ba0:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
    9ba5:	42 0f b6 44 33 01    	movzbl 0x1(%rbx,%r14,1),%eax
    9bab:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    9bb2:	4d 89 ec             	mov    %r13,%r12
    9bb5:	49 c1 e4 10          	shl    $0x10,%r12
    9bb9:	4c 03 25 f8 16 01 00 	add    0x116f8(%rip),%r12        # 1b2b8 <fwp_gc+0x1030>
    9bc0:	48 8d 0d c1 06 01 00 	lea    0x106c1(%rip),%rcx        # 1a288 <fwp_gc>
    9bc7:	48 01 c8             	add    %rcx,%rax
    9bca:	4a 8d 0c 33          	lea    (%rbx,%r14,1),%rcx
    9bce:	48 83 c1 08          	add    $0x8,%rcx
    9bd2:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
    9bd7:	42 0f b6 4c 33 02    	movzbl 0x2(%rbx,%r14,1),%ecx
    9bdd:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    9be1:	48 8d 2c c8          	lea    (%rax,%rcx,8),%rbp
    9be5:	48 83 c5 08          	add    $0x8,%rbp
    9be9:	4d 01 fe             	add    %r15,%r14
    9bec:	4c 01 f3             	add    %r14,%rbx
    9bef:	48 81 c3 27 02 00 00 	add    $0x227,%rbx
    9bf6:	49 ff cf             	dec    %r15
    9bf9:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    9bfe:	eb 23                	jmp    9c23 <fwp_gc_sweep+0x333>
    9c00:	80 3b ff             	cmpb   $0xff,(%rbx)
    9c03:	74 78                	je     9c7d <fwp_gc_sweep+0x38d>
    9c05:	c6 03 00             	movb   $0x0,(%rbx)
    9c08:	48 8b 45 00          	mov    0x0(%rbp),%rax
    9c0c:	48 f7 d0             	not    %rax
    9c0f:	49 89 06             	mov    %rax,(%r14)
    9c12:	4c 89 75 00          	mov    %r14,0x0(%rbp)
    9c16:	48 ff cb             	dec    %rbx
    9c19:	49 83 c7 ff          	add    $0xffffffffffffffff,%r15
    9c1d:	0f 83 37 01 00 00    	jae    9d5a <fwp_gc_sweep+0x46a>
    9c23:	4c 89 f8             	mov    %r15,%rax
    9c26:	48 c1 e8 06          	shr    $0x6,%rax
    9c2a:	48 8b 44 c1 28       	mov    0x28(%rcx,%rax,8),%rax
    9c2f:	4c 0f a3 f8          	bt     %r15,%rax
    9c33:	72 e1                	jb     9c16 <fwp_gc_sweep+0x326>
    9c35:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    9c3a:	8b 10                	mov    (%rax),%edx
    9c3c:	4d 89 fe             	mov    %r15,%r14
    9c3f:	4c 0f af f2          	imul   %rdx,%r14
    9c43:	4d 01 e6             	add    %r12,%r14
    9c46:	83 3d 3f 16 01 00 00 	cmpl   $0x0,0x1163f(%rip)        # 1b28c <fwp_gc+0x1004>
    9c4d:	74 b1                	je     9c00 <fwp_gc_sweep+0x310>
    9c4f:	4c 89 f7             	mov    %r14,%rdi
    9c52:	31 f6                	xor    %esi,%esi
    9c54:	e8 b7 95 ff ff       	call   3210 <memset@plt>
    9c59:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    9c5e:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    9c63:	66 0f 6f 3d 75 b4 00 	movdqa 0xb475(%rip),%xmm7        # 150e0 <_IO_stdin_used+0xe0>
    9c6a:	00 
    9c6b:	66 0f 6f 35 5d b4 00 	movdqa 0xb45d(%rip),%xmm6        # 150d0 <_IO_stdin_used+0xd0>
    9c72:	00 
    9c73:	66 0f 6f 2d 45 b4 00 	movdqa 0xb445(%rip),%xmm5        # 150c0 <_IO_stdin_used+0xc0>
    9c7a:	00 
    9c7b:	eb 83                	jmp    9c00 <fwp_gc_sweep+0x310>
    9c7d:	48 89 df             	mov    %rbx,%rdi
    9c80:	e8 2b cf ff ff       	call   6bb0 <fwp_rc_forget_slot>
    9c85:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    9c8a:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    9c8f:	66 0f 6f 3d 49 b4 00 	movdqa 0xb449(%rip),%xmm7        # 150e0 <_IO_stdin_used+0xe0>
    9c96:	00 
    9c97:	66 0f 6f 35 31 b4 00 	movdqa 0xb431(%rip),%xmm6        # 150d0 <_IO_stdin_used+0xd0>
    9c9e:	00 
    9c9f:	66 0f 6f 2d 19 b4 00 	movdqa 0xb419(%rip),%xmm5        # 150c0 <_IO_stdin_used+0xc0>
    9ca6:	00 
    9ca7:	e9 59 ff ff ff       	jmp    9c05 <fwp_gc_sweep+0x315>
    9cac:	48 83 3d ec 1f 01 00 	cmpq   $0x0,0x11fec(%rip)        # 1bca0 <fwp_gc+0x1a18>
    9cb3:	00 
    9cb4:	74 38                	je     9cee <fwp_gc_sweep+0x3fe>
    9cb6:	4e 8d 3c 33          	lea    (%rbx,%r14,1),%r15
    9cba:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    9cc1:	45 31 e4             	xor    %r12d,%r12d
    9cc4:	eb 16                	jmp    9cdc <fwp_gc_sweep+0x3ec>
    9cc6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    9ccd:	00 00 00 
    9cd0:	49 ff c4             	inc    %r12
    9cd3:	49 81 fc 00 10 00 00 	cmp    $0x1000,%r12
    9cda:	74 12                	je     9cee <fwp_gc_sweep+0x3fe>
    9cdc:	43 80 3c 27 ff       	cmpb   $0xff,(%r15,%r12,1)
    9ce1:	75 ed                	jne    9cd0 <fwp_gc_sweep+0x3e0>
    9ce3:	4b 8d 3c 27          	lea    (%r15,%r12,1),%rdi
    9ce7:	e8 c4 ce ff ff       	call   6bb0 <fwp_rc_forget_slot>
    9cec:	eb e2                	jmp    9cd0 <fwp_gc_sweep+0x3e0>
    9cee:	4a 8d 3c 33          	lea    (%rbx,%r14,1),%rdi
    9cf2:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    9cf9:	ba 00 10 00 00       	mov    $0x1000,%edx
    9cfe:	31 f6                	xor    %esi,%esi
    9d00:	e8 0b 95 ff ff       	call   3210 <memset@plt>
    9d05:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    9d0a:	c6 00 00             	movb   $0x0,(%rax)
    9d0d:	48 ff c5             	inc    %rbp
    9d10:	49 b9 55 55 55 55 55 	movabs $0x5555555555555555,%r9
    9d17:	55 55 55 
    9d1a:	49 ba 33 33 33 33 33 	movabs $0x3333333333333333,%r10
    9d21:	33 33 33 
    9d24:	49 bb 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r11
    9d2b:	0f 0f 0f 
    9d2e:	49 bc 01 01 01 01 01 	movabs $0x101010101010101,%r12
    9d35:	01 01 01 
    9d38:	66 0f 6f 2d 80 b3 00 	movdqa 0xb380(%rip),%xmm5        # 150c0 <_IO_stdin_used+0xc0>
    9d3f:	00 
    9d40:	66 0f 6f 35 88 b3 00 	movdqa 0xb388(%rip),%xmm6        # 150d0 <_IO_stdin_used+0xd0>
    9d47:	00 
    9d48:	66 0f 6f 3d 90 b3 00 	movdqa 0xb390(%rip),%xmm7        # 150e0 <_IO_stdin_used+0xe0>
    9d4f:	00 
    9d50:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    9d55:	e9 29 fc ff ff       	jmp    9983 <fwp_gc_sweep+0x93>
    9d5a:	48 8b 6c 24 18       	mov    0x18(%rsp),%rbp
    9d5f:	eb 78                	jmp    9dd9 <fwp_gc_sweep+0x4e9>
    9d61:	4a 8d 14 30          	lea    (%rax,%r14,1),%rdx
    9d65:	44 89 e6             	mov    %r12d,%esi
    9d68:	83 e6 fc             	and    $0xfffffffc,%esi
    9d6b:	31 c9                	xor    %ecx,%ecx
    9d6d:	0f 1f 00             	nopl   (%rax)
    9d70:	c6 02 00             	movb   $0x0,(%rdx)
    9d73:	c6 82 28 12 00 00 00 	movb   $0x0,0x1228(%rdx)
    9d7a:	c6 82 50 24 00 00 00 	movb   $0x0,0x2450(%rdx)
    9d81:	c6 82 78 36 00 00 00 	movb   $0x0,0x3678(%rdx)
    9d88:	48 83 c1 04          	add    $0x4,%rcx
    9d8c:	48 81 c2 a0 48 00 00 	add    $0x48a0,%rdx
    9d93:	48 39 ce             	cmp    %rcx,%rsi
    9d96:	75 d8                	jne    9d70 <fwp_gc_sweep+0x480>
    9d98:	44 89 e2             	mov    %r12d,%edx
    9d9b:	83 e2 03             	and    $0x3,%edx
    9d9e:	74 30                	je     9dd0 <fwp_gc_sweep+0x4e0>
    9da0:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    9da7:	4c 01 f1             	add    %r14,%rcx
    9daa:	48 01 c8             	add    %rcx,%rax
    9dad:	48 69 ca 28 12 00 00 	imul   $0x1228,%rdx,%rcx
    9db4:	31 d2                	xor    %edx,%edx
    9db6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    9dbd:	00 00 00 
    9dc0:	c6 04 10 00          	movb   $0x0,(%rax,%rdx,1)
    9dc4:	48 81 c2 28 12 00 00 	add    $0x1228,%rdx
    9dcb:	48 39 d1             	cmp    %rdx,%rcx
    9dce:	75 f0                	jne    9dc0 <fwp_gc_sweep+0x4d0>
    9dd0:	4c 01 e5             	add    %r12,%rbp
    9dd3:	4d 01 e5             	add    %r12,%r13
    9dd6:	49 ff cd             	dec    %r13
    9dd9:	49 b9 55 55 55 55 55 	movabs $0x5555555555555555,%r9
    9de0:	55 55 55 
    9de3:	49 ba 33 33 33 33 33 	movabs $0x3333333333333333,%r10
    9dea:	33 33 33 
    9ded:	49 bb 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r11
    9df4:	0f 0f 0f 
    9df7:	49 bc 01 01 01 01 01 	movabs $0x101010101010101,%r12
    9dfe:	01 01 01 
    9e01:	e9 7d fb ff ff       	jmp    9983 <fwp_gc_sweep+0x93>
    9e06:	4c 89 ff             	mov    %r15,%rdi
    9e09:	e8 a2 cd ff ff       	call   6bb0 <fwp_rc_forget_slot>
    9e0e:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    9e13:	66 0f 6f 3d c5 b2 00 	movdqa 0xb2c5(%rip),%xmm7        # 150e0 <_IO_stdin_used+0xe0>
    9e1a:	00 
    9e1b:	66 0f 6f 35 ad b2 00 	movdqa 0xb2ad(%rip),%xmm6        # 150d0 <_IO_stdin_used+0xd0>
    9e22:	00 
    9e23:	66 0f 6f 2d 95 b2 00 	movdqa 0xb295(%rip),%xmm5        # 150c0 <_IO_stdin_used+0xc0>
    9e2a:	00 
    9e2b:	e9 fe fb ff ff       	jmp    9a2e <fwp_gc_sweep+0x13e>
    9e30:	31 c0                	xor    %eax,%eax
    9e32:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    9e37:	31 c0                	xor    %eax,%eax
    9e39:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    9e3e:	48 89 15 0b 16 01 00 	mov    %rdx,0x1160b(%rip)        # 1b450 <fwp_gc+0x11c8>
    9e45:	48 89 2d 1c 16 01 00 	mov    %rbp,0x1161c(%rip)        # 1b468 <fwp_gc+0x11e0>
    9e4c:	48 81 fa 01 00 00 01 	cmp    $0x1000001,%rdx
    9e53:	b9 00 00 00 01       	mov    $0x1000000,%ecx
    9e58:	48 0f 43 ca          	cmovae %rdx,%rcx
    9e5c:	48 c1 e9 10          	shr    $0x10,%rcx
    9e60:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9e64:	f3 0f 7f 05 84 14 01 	movdqu %xmm0,0x11484(%rip)        # 1b2f0 <fwp_gc+0x1068>
    9e6b:	00 
    9e6c:	48 29 cd             	sub    %rcx,%rbp
    9e6f:	0f 86 fc 00 00 00    	jbe    9f71 <fwp_gc_sweep+0x681>
    9e75:	48 85 c0             	test   %rax,%rax
    9e78:	0f 84 f3 00 00 00    	je     9f71 <fwp_gc_sweep+0x681>
    9e7e:	48 85 ed             	test   %rbp,%rbp
    9e81:	0f 84 ea 00 00 00    	je     9f71 <fwp_gc_sweep+0x681>
    9e87:	48 8b 0d 72 14 01 00 	mov    0x11472(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    9e8e:	66 90                	xchg   %ax,%ax
    9e90:	48 8d 58 ff          	lea    -0x1(%rax),%rbx
    9e94:	48 69 d3 28 12 00 00 	imul   $0x1228,%rbx,%rdx
    9e9b:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
    9e9f:	0f 85 bb 00 00 00    	jne    9f60 <fwp_gc_sweep+0x670>
    9ea5:	4c 8d 75 ff          	lea    -0x1(%rbp),%r14
    9ea9:	80 7c 11 04 00       	cmpb   $0x0,0x4(%rcx,%rdx,1)
    9eae:	0f 84 a9 00 00 00    	je     9f5d <fwp_gc_sweep+0x66d>
    9eb4:	48 01 ca             	add    %rcx,%rdx
    9eb7:	48 83 c2 04          	add    $0x4,%rdx
    9ebb:	c6 02 00             	movb   $0x0,(%rdx)
    9ebe:	be 01 00 00 00       	mov    $0x1,%esi
    9ec3:	48 85 db             	test   %rbx,%rbx
    9ec6:	74 72                	je     9f3a <fwp_gc_sweep+0x64a>
    9ec8:	4d 85 f6             	test   %r14,%r14
    9ecb:	74 6d                	je     9f3a <fwp_gc_sweep+0x64a>
    9ecd:	ba 02 00 00 00       	mov    $0x2,%edx
    9ed2:	48 29 c2             	sub    %rax,%rdx
    9ed5:	48 69 c0 28 12 00 00 	imul   $0x1228,%rax,%rax
    9edc:	48 01 c1             	add    %rax,%rcx
    9edf:	48 81 c1 b4 db ff ff 	add    $0xffffffffffffdbb4,%rcx
    9ee6:	bf 02 00 00 00       	mov    $0x2,%edi
    9eeb:	48 29 ef             	sub    %rbp,%rdi
    9eee:	b8 01 00 00 00       	mov    $0x1,%eax
    9ef3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9efa:	84 00 00 00 00 00 
    9f00:	80 79 fc 00          	cmpb   $0x0,-0x4(%rcx)
    9f04:	75 31                	jne    9f37 <fwp_gc_sweep+0x647>
    9f06:	80 39 00             	cmpb   $0x0,(%rcx)
    9f09:	74 2c                	je     9f37 <fwp_gc_sweep+0x647>
    9f0b:	48 ff cb             	dec    %rbx
    9f0e:	4c 8d 04 02          	lea    (%rdx,%rax,1),%r8
    9f12:	49 ff ce             	dec    %r14
    9f15:	c6 01 00             	movb   $0x0,(%rcx)
    9f18:	48 8d 70 01          	lea    0x1(%rax),%rsi
    9f1c:	49 83 f8 01          	cmp    $0x1,%r8
    9f20:	74 18                	je     9f3a <fwp_gc_sweep+0x64a>
    9f22:	48 01 f8             	add    %rdi,%rax
    9f25:	48 81 c1 d8 ed ff ff 	add    $0xffffffffffffedd8,%rcx
    9f2c:	48 83 f8 01          	cmp    $0x1,%rax
    9f30:	48 89 f0             	mov    %rsi,%rax
    9f33:	75 cb                	jne    9f00 <fwp_gc_sweep+0x610>
    9f35:	eb 03                	jmp    9f3a <fwp_gc_sweep+0x64a>
    9f37:	48 89 c6             	mov    %rax,%rsi
    9f3a:	48 89 df             	mov    %rbx,%rdi
    9f3d:	48 c1 e7 10          	shl    $0x10,%rdi
    9f41:	48 03 3d 70 13 01 00 	add    0x11370(%rip),%rdi        # 1b2b8 <fwp_gc+0x1030>
    9f48:	48 c1 e6 10          	shl    $0x10,%rsi
    9f4c:	ba 04 00 00 00       	mov    $0x4,%edx
    9f51:	e8 9a 94 ff ff       	call   33f0 <madvise@plt>
    9f56:	48 8b 0d a3 13 01 00 	mov    0x113a3(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    9f5d:	4c 89 f5             	mov    %r14,%rbp
    9f60:	48 89 d8             	mov    %rbx,%rax
    9f63:	48 85 db             	test   %rbx,%rbx
    9f66:	74 09                	je     9f71 <fwp_gc_sweep+0x681>
    9f68:	48 85 ed             	test   %rbp,%rbp
    9f6b:	0f 85 1f ff ff ff    	jne    9e90 <fwp_gc_sweep+0x5a0>
    9f71:	48 83 c4 28          	add    $0x28,%rsp
    9f75:	5b                   	pop    %rbx
    9f76:	41 5c                	pop    %r12
    9f78:	41 5d                	pop    %r13
    9f7a:	41 5e                	pop    %r14
    9f7c:	41 5f                	pop    %r15
    9f7e:	5d                   	pop    %rbp
    9f7f:	c3                   	ret

0000000000009f80 <fwp_gc_sp>:
    9f80:	55                   	push   %rbp
    9f81:	48 89 e5             	mov    %rsp,%rbp
    9f84:	48 89 e8             	mov    %rbp,%rax
    9f87:	5d                   	pop    %rbp
    9f88:	c3                   	ret
    9f89:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000009f90 <fwp_gc_scan>:
    9f90:	55                   	push   %rbp
    9f91:	41 57                	push   %r15
    9f93:	41 56                	push   %r14
    9f95:	41 55                	push   %r13
    9f97:	41 54                	push   %r12
    9f99:	53                   	push   %rbx
    9f9a:	50                   	push   %rax
    9f9b:	49 89 ff             	mov    %rdi,%r15
    9f9e:	49 83 c7 07          	add    $0x7,%r15
    9fa2:	49 83 e7 f8          	and    $0xfffffffffffffff8,%r15
    9fa6:	49 8d 47 08          	lea    0x8(%r15),%rax
    9faa:	48 39 f0             	cmp    %rsi,%rax
    9fad:	76 0f                	jbe    9fbe <fwp_gc_scan+0x2e>
    9faf:	48 83 c4 08          	add    $0x8,%rsp
    9fb3:	5b                   	pop    %rbx
    9fb4:	41 5c                	pop    %r12
    9fb6:	41 5d                	pop    %r13
    9fb8:	41 5e                	pop    %r14
    9fba:	41 5f                	pop    %r15
    9fbc:	5d                   	pop    %rbp
    9fbd:	c3                   	ret
    9fbe:	89 d3                	mov    %edx,%ebx
    9fc0:	49 89 f6             	mov    %rsi,%r14
    9fc3:	4c 8b 25 ee 12 01 00 	mov    0x112ee(%rip),%r12        # 1b2b8 <fwp_gc+0x1030>
    9fca:	4c 8b 2d 0f 13 01 00 	mov    0x1130f(%rip),%r13        # 1b2e0 <fwp_gc+0x1058>
    9fd1:	49 c1 e5 10          	shl    $0x10,%r13
    9fd5:	eb 29                	jmp    a000 <fwp_gc_scan+0x70>
    9fd7:	4d 01 d0             	add    %r10,%r8
    9fda:	41 80 78 03 00       	cmpb   $0x0,0x3(%r8)
    9fdf:	0f 84 a6 02 00 00    	je     a28b <fwp_gc_scan+0x2fb>
    9fe5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    9fec:	00 00 00 00 
    9ff0:	49 8d 47 08          	lea    0x8(%r15),%rax
    9ff4:	49 83 c7 10          	add    $0x10,%r15
    9ff8:	4d 39 f7             	cmp    %r14,%r15
    9ffb:	49 89 c7             	mov    %rax,%r15
    9ffe:	77 af                	ja     9faf <fwp_gc_scan+0x1f>
    a000:	49 8b 2f             	mov    (%r15),%rbp
    a003:	48 89 e8             	mov    %rbp,%rax
    a006:	4c 29 e0             	sub    %r12,%rax
    a009:	4c 39 e8             	cmp    %r13,%rax
    a00c:	0f 83 de 00 00 00    	jae    a0f0 <fwp_gc_scan+0x160>
    a012:	48 8b 3d 9f 12 01 00 	mov    0x1129f(%rip),%rdi        # 1b2b8 <fwp_gc+0x1030>
    a019:	49 89 e9             	mov    %rbp,%r9
    a01c:	49 29 f9             	sub    %rdi,%r9
    a01f:	48 8b 05 ba 12 01 00 	mov    0x112ba(%rip),%rax        # 1b2e0 <fwp_gc+0x1058>
    a026:	48 c1 e0 10          	shl    $0x10,%rax
    a02a:	49 39 c1             	cmp    %rax,%r9
    a02d:	0f 83 6d 01 00 00    	jae    a1a0 <fwp_gc_scan+0x210>
    a033:	4c 8b 05 c6 12 01 00 	mov    0x112c6(%rip),%r8        # 1b300 <fwp_gc+0x1078>
    a03a:	4d 85 c0             	test   %r8,%r8
    a03d:	0f 84 5d 01 00 00    	je     a1a0 <fwp_gc_scan+0x210>
    a043:	4c 89 c8             	mov    %r9,%rax
    a046:	48 c1 e8 10          	shr    $0x10,%rax
    a04a:	4c 69 d0 28 12 00 00 	imul   $0x1228,%rax,%r10
    a051:	43 0f b6 0c 10       	movzbl (%r8,%r10,1),%ecx
    a056:	83 f9 03             	cmp    $0x3,%ecx
    a059:	0f 84 0c 01 00 00    	je     a16b <fwp_gc_scan+0x1db>
    a05f:	83 f9 02             	cmp    $0x2,%ecx
    a062:	0f 84 f7 00 00 00    	je     a15f <fwp_gc_scan+0x1cf>
    a068:	83 f9 01             	cmp    $0x1,%ecx
    a06b:	0f 85 2f 01 00 00    	jne    a1a0 <fwp_gc_scan+0x210>
    a071:	43 8b 4c 10 08       	mov    0x8(%r8,%r10,1),%ecx
    a076:	0f b7 c5             	movzwl %bp,%eax
    a079:	31 d2                	xor    %edx,%edx
    a07b:	48 89 0c 24          	mov    %rcx,(%rsp)
    a07f:	f7 f1                	div    %ecx
    a081:	43 3b 44 10 0c       	cmp    0xc(%r8,%r10,1),%eax
    a086:	0f 83 14 01 00 00    	jae    a1a0 <fwp_gc_scan+0x210>
    a08c:	ba 01 00 00 00       	mov    $0x1,%edx
    a091:	89 c1                	mov    %eax,%ecx
    a093:	48 d3 e2             	shl    %cl,%rdx
    a096:	4b 8d 34 10          	lea    (%r8,%r10,1),%rsi
    a09a:	41 89 c3             	mov    %eax,%r11d
    a09d:	41 c1 eb 06          	shr    $0x6,%r11d
    a0a1:	4a 8b 4c de 28       	mov    0x28(%rsi,%r11,8),%rcx
    a0a6:	48 0f a3 c1          	bt     %rax,%rcx
    a0aa:	0f 82 f0 00 00 00    	jb     a1a0 <fwp_gc_scan+0x210>
    a0b0:	4a 8d 34 de          	lea    (%rsi,%r11,8),%rsi
    a0b4:	48 83 c6 28          	add    $0x28,%rsi
    a0b8:	48 09 d1             	or     %rdx,%rcx
    a0bb:	48 89 0e             	mov    %rcx,(%rsi)
    a0be:	43 80 7c 10 01 01    	cmpb   $0x1,0x1(%r8,%r10,1)
    a0c4:	0f 84 d6 00 00 00    	je     a1a0 <fwp_gc_scan+0x210>
    a0ca:	49 81 e1 00 00 ff ff 	and    $0xffffffffffff0000,%r9
    a0d1:	4c 01 cf             	add    %r9,%rdi
    a0d4:	48 8b 34 24          	mov    (%rsp),%rsi
    a0d8:	48 0f af c6          	imul   %rsi,%rax
    a0dc:	48 01 f8             	add    %rdi,%rax
    a0df:	48 89 c7             	mov    %rax,%rdi
    a0e2:	e9 b1 00 00 00       	jmp    a198 <fwp_gc_scan+0x208>
    a0e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    a0ee:	00 00 
    a0f0:	85 db                	test   %ebx,%ebx
    a0f2:	0f 84 f8 fe ff ff    	je     9ff0 <fwp_gc_scan+0x60>
    a0f8:	4c 39 e8             	cmp    %r13,%rax
    a0fb:	0f 85 ef fe ff ff    	jne    9ff0 <fwp_gc_scan+0x60>
    a101:	48 ff cd             	dec    %rbp
    a104:	48 8b 3d ad 11 01 00 	mov    0x111ad(%rip),%rdi        # 1b2b8 <fwp_gc+0x1030>
    a10b:	49 89 e9             	mov    %rbp,%r9
    a10e:	49 29 f9             	sub    %rdi,%r9
    a111:	48 8b 05 c8 11 01 00 	mov    0x111c8(%rip),%rax        # 1b2e0 <fwp_gc+0x1058>
    a118:	48 c1 e0 10          	shl    $0x10,%rax
    a11c:	49 39 c1             	cmp    %rax,%r9
    a11f:	0f 83 cb fe ff ff    	jae    9ff0 <fwp_gc_scan+0x60>
    a125:	4c 8b 05 d4 11 01 00 	mov    0x111d4(%rip),%r8        # 1b300 <fwp_gc+0x1078>
    a12c:	4d 85 c0             	test   %r8,%r8
    a12f:	0f 84 bb fe ff ff    	je     9ff0 <fwp_gc_scan+0x60>
    a135:	4c 89 c8             	mov    %r9,%rax
    a138:	48 c1 e8 10          	shr    $0x10,%rax
    a13c:	4c 69 d0 28 12 00 00 	imul   $0x1228,%rax,%r10
    a143:	43 0f b6 0c 10       	movzbl (%r8,%r10,1),%ecx
    a148:	83 f9 03             	cmp    $0x3,%ecx
    a14b:	0f 84 20 01 00 00    	je     a271 <fwp_gc_scan+0x2e1>
    a151:	83 f9 02             	cmp    $0x2,%ecx
    a154:	0f 85 a3 00 00 00    	jne    a1fd <fwp_gc_scan+0x26d>
    a15a:	e9 78 fe ff ff       	jmp    9fd7 <fwp_gc_scan+0x47>
    a15f:	4d 01 d0             	add    %r10,%r8
    a162:	41 80 78 03 00       	cmpb   $0x0,0x3(%r8)
    a167:	75 37                	jne    a1a0 <fwp_gc_scan+0x210>
    a169:	eb 16                	jmp    a181 <fwp_gc_scan+0x1f1>
    a16b:	43 8b 44 10 10       	mov    0x10(%r8,%r10,1),%eax
    a170:	48 69 c8 28 12 00 00 	imul   $0x1228,%rax,%rcx
    a177:	49 01 c8             	add    %rcx,%r8
    a17a:	41 80 78 03 00       	cmpb   $0x0,0x3(%r8)
    a17f:	75 1f                	jne    a1a0 <fwp_gc_scan+0x210>
    a181:	41 c6 40 03 01       	movb   $0x1,0x3(%r8)
    a186:	41 80 78 01 01       	cmpb   $0x1,0x1(%r8)
    a18b:	74 13                	je     a1a0 <fwp_gc_scan+0x210>
    a18d:	48 c1 e0 10          	shl    $0x10,%rax
    a191:	48 01 c7             	add    %rax,%rdi
    a194:	49 8b 70 18          	mov    0x18(%r8),%rsi
    a198:	e8 13 01 00 00       	call   a2b0 <fwp_gc_push>
    a19d:	0f 1f 00             	nopl   (%rax)
    a1a0:	85 db                	test   %ebx,%ebx
    a1a2:	0f 84 48 fe ff ff    	je     9ff0 <fwp_gc_scan+0x60>
    a1a8:	48 ff cd             	dec    %rbp
    a1ab:	48 8b 3d 06 11 01 00 	mov    0x11106(%rip),%rdi        # 1b2b8 <fwp_gc+0x1030>
    a1b2:	49 89 e9             	mov    %rbp,%r9
    a1b5:	49 29 f9             	sub    %rdi,%r9
    a1b8:	48 8b 05 21 11 01 00 	mov    0x11121(%rip),%rax        # 1b2e0 <fwp_gc+0x1058>
    a1bf:	48 c1 e0 10          	shl    $0x10,%rax
    a1c3:	49 39 c1             	cmp    %rax,%r9
    a1c6:	0f 83 24 fe ff ff    	jae    9ff0 <fwp_gc_scan+0x60>
    a1cc:	4c 8b 05 2d 11 01 00 	mov    0x1112d(%rip),%r8        # 1b300 <fwp_gc+0x1078>
    a1d3:	4d 85 c0             	test   %r8,%r8
    a1d6:	0f 84 14 fe ff ff    	je     9ff0 <fwp_gc_scan+0x60>
    a1dc:	4c 89 c8             	mov    %r9,%rax
    a1df:	48 c1 e8 10          	shr    $0x10,%rax
    a1e3:	4c 69 d0 28 12 00 00 	imul   $0x1228,%rax,%r10
    a1ea:	43 0f b6 0c 10       	movzbl (%r8,%r10,1),%ecx
    a1ef:	83 f9 03             	cmp    $0x3,%ecx
    a1f2:	74 7d                	je     a271 <fwp_gc_scan+0x2e1>
    a1f4:	83 f9 02             	cmp    $0x2,%ecx
    a1f7:	0f 84 da fd ff ff    	je     9fd7 <fwp_gc_scan+0x47>
    a1fd:	83 f9 01             	cmp    $0x1,%ecx
    a200:	0f 85 ea fd ff ff    	jne    9ff0 <fwp_gc_scan+0x60>
    a206:	43 8b 74 10 08       	mov    0x8(%r8,%r10,1),%esi
    a20b:	0f b7 c5             	movzwl %bp,%eax
    a20e:	31 d2                	xor    %edx,%edx
    a210:	f7 f6                	div    %esi
    a212:	43 3b 44 10 0c       	cmp    0xc(%r8,%r10,1),%eax
    a217:	0f 83 d3 fd ff ff    	jae    9ff0 <fwp_gc_scan+0x60>
    a21d:	ba 01 00 00 00       	mov    $0x1,%edx
    a222:	89 c1                	mov    %eax,%ecx
    a224:	48 d3 e2             	shl    %cl,%rdx
    a227:	4b 8d 0c 10          	lea    (%r8,%r10,1),%rcx
    a22b:	41 89 c3             	mov    %eax,%r11d
    a22e:	41 c1 eb 06          	shr    $0x6,%r11d
    a232:	4a 8b 6c d9 28       	mov    0x28(%rcx,%r11,8),%rbp
    a237:	48 0f a3 c5          	bt     %rax,%rbp
    a23b:	0f 82 af fd ff ff    	jb     9ff0 <fwp_gc_scan+0x60>
    a241:	4a 8d 0c d9          	lea    (%rcx,%r11,8),%rcx
    a245:	48 83 c1 28          	add    $0x28,%rcx
    a249:	48 09 d5             	or     %rdx,%rbp
    a24c:	48 89 29             	mov    %rbp,(%rcx)
    a24f:	43 80 7c 10 01 01    	cmpb   $0x1,0x1(%r8,%r10,1)
    a255:	0f 84 95 fd ff ff    	je     9ff0 <fwp_gc_scan+0x60>
    a25b:	49 81 e1 00 00 ff ff 	and    $0xffffffffffff0000,%r9
    a262:	4c 01 cf             	add    %r9,%rdi
    a265:	48 0f af c6          	imul   %rsi,%rax
    a269:	48 01 f8             	add    %rdi,%rax
    a26c:	48 89 c7             	mov    %rax,%rdi
    a26f:	eb 35                	jmp    a2a6 <fwp_gc_scan+0x316>
    a271:	43 8b 44 10 10       	mov    0x10(%r8,%r10,1),%eax
    a276:	48 69 c8 28 12 00 00 	imul   $0x1228,%rax,%rcx
    a27d:	49 01 c8             	add    %rcx,%r8
    a280:	41 80 78 03 00       	cmpb   $0x0,0x3(%r8)
    a285:	0f 85 65 fd ff ff    	jne    9ff0 <fwp_gc_scan+0x60>
    a28b:	41 c6 40 03 01       	movb   $0x1,0x3(%r8)
    a290:	41 80 78 01 01       	cmpb   $0x1,0x1(%r8)
    a295:	0f 84 55 fd ff ff    	je     9ff0 <fwp_gc_scan+0x60>
    a29b:	48 c1 e0 10          	shl    $0x10,%rax
    a29f:	48 01 c7             	add    %rax,%rdi
    a2a2:	49 8b 70 18          	mov    0x18(%r8),%rsi
    a2a6:	e8 05 00 00 00       	call   a2b0 <fwp_gc_push>
    a2ab:	e9 40 fd ff ff       	jmp    9ff0 <fwp_gc_scan+0x60>

000000000000a2b0 <fwp_gc_push>:
    a2b0:	41 56                	push   %r14
    a2b2:	53                   	push   %rbx
    a2b3:	50                   	push   %rax
    a2b4:	48 89 f3             	mov    %rsi,%rbx
    a2b7:	49 89 fe             	mov    %rdi,%r14
    a2ba:	48 8b 0d 67 11 01 00 	mov    0x11167(%rip),%rcx        # 1b428 <fwp_gc+0x11a0>
    a2c1:	48 8b 05 58 11 01 00 	mov    0x11158(%rip),%rax        # 1b420 <fwp_gc+0x1198>
    a2c8:	48 3b 0d 61 11 01 00 	cmp    0x11161(%rip),%rcx        # 1b430 <fwp_gc+0x11a8>
    a2cf:	75 36                	jne    a307 <fwp_gc_push+0x57>
    a2d1:	48 8d 14 09          	lea    (%rcx,%rcx,1),%rdx
    a2d5:	48 85 c9             	test   %rcx,%rcx
    a2d8:	be 00 10 00 00       	mov    $0x1000,%esi
    a2dd:	48 0f 45 f2          	cmovne %rdx,%rsi
    a2e1:	48 89 35 48 11 01 00 	mov    %rsi,0x11148(%rip)        # 1b430 <fwp_gc+0x11a8>
    a2e8:	48 c1 e6 04          	shl    $0x4,%rsi
    a2ec:	48 89 c7             	mov    %rax,%rdi
    a2ef:	e8 8c 90 ff ff       	call   3380 <realloc@plt>
    a2f4:	48 89 05 25 11 01 00 	mov    %rax,0x11125(%rip)        # 1b420 <fwp_gc+0x1198>
    a2fb:	48 85 c0             	test   %rax,%rax
    a2fe:	74 29                	je     a329 <fwp_gc_push+0x79>
    a300:	48 8b 0d 21 11 01 00 	mov    0x11121(%rip),%rcx        # 1b428 <fwp_gc+0x11a0>
    a307:	48 89 ca             	mov    %rcx,%rdx
    a30a:	48 c1 e2 04          	shl    $0x4,%rdx
    a30e:	4c 89 34 10          	mov    %r14,(%rax,%rdx,1)
    a312:	48 89 5c 10 08       	mov    %rbx,0x8(%rax,%rdx,1)
    a317:	48 ff c1             	inc    %rcx
    a31a:	48 89 0d 07 11 01 00 	mov    %rcx,0x11107(%rip)        # 1b428 <fwp_gc+0x11a0>
    a321:	48 83 c4 08          	add    $0x8,%rsp
    a325:	5b                   	pop    %rbx
    a326:	41 5e                	pop    %r14
    a328:	c3                   	ret
    a329:	48 8b 05 a8 fc 00 00 	mov    0xfca8(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a330:	48 8b 08             	mov    (%rax),%rcx
    a333:	48 8d 3d cc b7 00 00 	lea    0xb7cc(%rip),%rdi        # 15b06 <exec_in_fp0+0x296>
    a33a:	be 13 00 00 00       	mov    $0x13,%esi
    a33f:	ba 01 00 00 00       	mov    $0x1,%edx
    a344:	e8 37 91 ff ff       	call   3480 <fwrite@plt>
    a349:	bf 66 00 00 00       	mov    $0x66,%edi
    a34e:	e8 0d 91 ff ff       	call   3460 <exit@plt>
    a353:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a35a:	84 00 00 00 00 00 

000000000000a360 <fwp_closure_drop>:
    a360:	41 57                	push   %r15
    a362:	41 56                	push   %r14
    a364:	53                   	push   %rbx
    a365:	48 81 ec 30 02 00 00 	sub    $0x230,%rsp
    a36c:	48 89 f8             	mov    %rdi,%rax
    a36f:	48 2b 05 42 0f 01 00 	sub    0x10f42(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    a376:	48 8b 0d 63 0f 01 00 	mov    0x10f63(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    a37d:	48 c1 e1 10          	shl    $0x10,%rcx
    a381:	48 39 c8             	cmp    %rcx,%rax
    a384:	0f 83 91 00 00 00    	jae    a41b <fwp_closure_drop+0xbb>
    a38a:	48 89 fe             	mov    %rdi,%rsi
    a38d:	48 8b 0d 6c 0f 01 00 	mov    0x10f6c(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    a394:	48 89 c2             	mov    %rax,%rdx
    a397:	48 c1 ea 10          	shr    $0x10,%rdx
    a39b:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a3a2:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
    a3a6:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a3ac:	75 13                	jne    a3c1 <fwp_closure_drop+0x61>
    a3ae:	40 80 ff 02          	cmp    $0x2,%dil
    a3b2:	75 0d                	jne    a3c1 <fwp_closure_drop+0x61>
    a3b4:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    a3b8:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    a3bf:	eb 20                	jmp    a3e1 <fwp_closure_drop+0x81>
    a3c1:	40 80 ff 01          	cmp    $0x1,%dil
    a3c5:	75 54                	jne    a41b <fwp_closure_drop+0xbb>
    a3c7:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    a3cb:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a3cf:	48 0f af c1          	imul   %rcx,%rax
    a3d3:	48 c1 e8 20          	shr    $0x20,%rax
    a3d7:	48 01 c7             	add    %rax,%rdi
    a3da:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    a3e1:	0f b6 07             	movzbl (%rdi),%eax
    a3e4:	85 c0                	test   %eax,%eax
    a3e6:	74 33                	je     a41b <fwp_closure_drop+0xbb>
    a3e8:	83 f8 01             	cmp    $0x1,%eax
    a3eb:	75 1f                	jne    a40c <fwp_closure_drop+0xac>
    a3ed:	64 48 8b 3c 25 f8 ff 	mov    %fs:0xfffffffffffffff8,%rdi
    a3f4:	ff ff 
    a3f6:	48 85 ff             	test   %rdi,%rdi
    a3f9:	74 2d                	je     a428 <fwp_closure_drop+0xc8>
    a3fb:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    a402:	5b                   	pop    %rbx
    a403:	41 5e                	pop    %r14
    a405:	41 5f                	pop    %r15
    a407:	e9 44 01 00 00       	jmp    a550 <fwp_closure_drop_push>
    a40c:	3d ff 00 00 00       	cmp    $0xff,%eax
    a411:	0f 84 e7 00 00 00    	je     a4fe <fwp_closure_drop+0x19e>
    a417:	fe c8                	dec    %al
    a419:	88 07                	mov    %al,(%rdi)
    a41b:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    a422:	5b                   	pop    %rbx
    a423:	41 5e                	pop    %r14
    a425:	41 5f                	pop    %r15
    a427:	c3                   	ret
    a428:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
    a42f:	00 00 
    a431:	4c 8d b0 f8 ff ff ff 	lea    -0x8(%rax),%r14
    a438:	48 8d 5c 24 30       	lea    0x30(%rsp),%rbx
    a43d:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    a442:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    a449:	00 00 
    a44b:	48 c7 44 24 28 40 00 	movq   $0x40,0x28(%rsp)
    a452:	00 00 
    a454:	48 ff 05 65 1a 01 00 	incq   0x11a65(%rip)        # 1bec0 <measured_scopes>
    a45b:	48 8b 05 66 1a 01 00 	mov    0x11a66(%rip),%rax        # 1bec8 <fwp_cleanups>
    a462:	48 89 04 24          	mov    %rax,(%rsp)
    a466:	48 8d 05 c3 01 00 00 	lea    0x1c3(%rip),%rax        # a630 <fwp_closure_drop_release>
    a46d:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    a472:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    a477:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    a47c:	49 89 e7             	mov    %rsp,%r15
    a47f:	4c 89 3d 42 1a 01 00 	mov    %r15,0x11a42(%rip)        # 1bec8 <fwp_cleanups>
    a486:	49 89 3e             	mov    %rdi,(%r14)
    a489:	e8 c2 00 00 00       	call   a550 <fwp_closure_drop_push>
    a48e:	66 90                	xchg   %ax,%ax
    a490:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    a495:	48 85 c0             	test   %rax,%rax
    a498:	74 31                	je     a4cb <fwp_closure_drop+0x16b>
    a49a:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    a49f:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    a4a3:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
    a4a8:	48 8b 7c c1 f8       	mov    -0x8(%rcx,%rax,8),%rdi
    a4ad:	48 8b 05 bc 19 01 00 	mov    0x119bc(%rip),%rax        # 1be70 <fwp_fns>
    a4b4:	8b 0f                	mov    (%rdi),%ecx
    a4b6:	48 c1 e1 05          	shl    $0x5,%rcx
    a4ba:	48 8b 44 08 18       	mov    0x18(%rax,%rcx,1),%rax
    a4bf:	48 85 c0             	test   %rax,%rax
    a4c2:	74 4b                	je     a50f <fwp_closure_drop+0x1af>
    a4c4:	31 f6                	xor    %esi,%esi
    a4c6:	ff 50 08             	call   *0x8(%rax)
    a4c9:	eb c5                	jmp    a490 <fwp_closure_drop+0x130>
    a4cb:	4c 39 3d f6 19 01 00 	cmp    %r15,0x119f6(%rip)        # 1bec8 <fwp_cleanups>
    a4d2:	75 69                	jne    a53d <fwp_closure_drop+0x1dd>
    a4d4:	48 8b 04 24          	mov    (%rsp),%rax
    a4d8:	48 89 05 e9 19 01 00 	mov    %rax,0x119e9(%rip)        # 1bec8 <fwp_cleanups>
    a4df:	49 c7 06 00 00 00 00 	movq   $0x0,(%r14)
    a4e6:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    a4eb:	48 39 df             	cmp    %rbx,%rdi
    a4ee:	0f 84 27 ff ff ff    	je     a41b <fwp_closure_drop+0xbb>
    a4f4:	e8 57 8b ff ff       	call   3050 <free@plt>
    a4f9:	e9 1d ff ff ff       	jmp    a41b <fwp_closure_drop+0xbb>
    a4fe:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    a505:	5b                   	pop    %rbx
    a506:	41 5e                	pop    %r14
    a508:	41 5f                	pop    %r15
    a50a:	e9 61 01 00 00       	jmp    a670 <fwp_rc_wide_drop>
    a50f:	e8 4c c7 ff ff       	call   6c60 <fwp_flush>
    a514:	48 8b 05 bd fa 00 00 	mov    0xfabd(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a51b:	48 8b 38             	mov    (%rax),%rdi
    a51e:	48 8d 35 89 b5 00 00 	lea    0xb589(%rip),%rsi        # 15aae <exec_in_fp0+0x23e>
    a525:	48 8d 15 a0 b6 00 00 	lea    0xb6a0(%rip),%rdx        # 15bcc <exec_in_fp0+0x35c>
    a52c:	31 c0                	xor    %eax,%eax
    a52e:	e8 bd 8d ff ff       	call   32f0 <fprintf@plt>
    a533:	bf 65 00 00 00       	mov    $0x65,%edi
    a538:	e8 23 8f ff ff       	call   3460 <exit@plt>
    a53d:	e8 2e 8b ff ff       	call   3070 <abort@plt>
    a542:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a549:	1f 84 00 00 00 00 00 

000000000000a550 <fwp_closure_drop_push>:
    a550:	55                   	push   %rbp
    a551:	41 57                	push   %r15
    a553:	41 56                	push   %r14
    a555:	41 55                	push   %r13
    a557:	41 54                	push   %r12
    a559:	53                   	push   %rbx
    a55a:	50                   	push   %rax
    a55b:	48 89 f3             	mov    %rsi,%rbx
    a55e:	49 89 fe             	mov    %rdi,%r14
    a561:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    a565:	4c 3b 6f 10          	cmp    0x10(%rdi),%r13
    a569:	75 59                	jne    a5c4 <fwp_closure_drop_push+0x74>
    a56b:	4c 89 e8             	mov    %r13,%rax
    a56e:	48 c1 e8 3c          	shr    $0x3c,%rax
    a572:	75 6e                	jne    a5e2 <fwp_closure_drop_push+0x92>
    a574:	4c 89 ef             	mov    %r13,%rdi
    a577:	48 c1 e7 04          	shl    $0x4,%rdi
    a57b:	e8 c0 8d ff ff       	call   3340 <malloc@plt>
    a580:	48 85 c0             	test   %rax,%rax
    a583:	74 7c                	je     a601 <fwp_closure_drop_push+0xb1>
    a585:	49 89 c7             	mov    %rax,%r15
    a588:	4a 8d 2c 6d 00 00 00 	lea    0x0(,%r13,2),%rbp
    a58f:	00 
    a590:	4d 8b 26             	mov    (%r14),%r12
    a593:	4a 8d 14 ed 00 00 00 	lea    0x0(,%r13,8),%rdx
    a59a:	00 
    a59b:	48 89 c7             	mov    %rax,%rdi
    a59e:	4c 89 e6             	mov    %r12,%rsi
    a5a1:	e8 8a 8d ff ff       	call   3330 <memcpy@plt>
    a5a6:	49 8d 46 18          	lea    0x18(%r14),%rax
    a5aa:	49 39 c4             	cmp    %rax,%r12
    a5ad:	74 0c                	je     a5bb <fwp_closure_drop_push+0x6b>
    a5af:	4c 89 e7             	mov    %r12,%rdi
    a5b2:	e8 99 8a ff ff       	call   3050 <free@plt>
    a5b7:	4d 8b 6e 08          	mov    0x8(%r14),%r13
    a5bb:	4d 89 3e             	mov    %r15,(%r14)
    a5be:	49 89 6e 10          	mov    %rbp,0x10(%r14)
    a5c2:	eb 03                	jmp    a5c7 <fwp_closure_drop_push+0x77>
    a5c4:	4d 8b 3e             	mov    (%r14),%r15
    a5c7:	49 8d 45 01          	lea    0x1(%r13),%rax
    a5cb:	49 89 46 08          	mov    %rax,0x8(%r14)
    a5cf:	4b 89 1c ef          	mov    %rbx,(%r15,%r13,8)
    a5d3:	48 83 c4 08          	add    $0x8,%rsp
    a5d7:	5b                   	pop    %rbx
    a5d8:	41 5c                	pop    %r12
    a5da:	41 5d                	pop    %r13
    a5dc:	41 5e                	pop    %r14
    a5de:	41 5f                	pop    %r15
    a5e0:	5d                   	pop    %rbp
    a5e1:	c3                   	ret
    a5e2:	e8 79 c6 ff ff       	call   6c60 <fwp_flush>
    a5e7:	48 8b 05 ea f9 00 00 	mov    0xf9ea(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a5ee:	48 8b 38             	mov    (%rax),%rdi
    a5f1:	48 8d 35 b6 b4 00 00 	lea    0xb4b6(%rip),%rsi        # 15aae <exec_in_fp0+0x23e>
    a5f8:	48 8d 15 fb b5 00 00 	lea    0xb5fb(%rip),%rdx        # 15bfa <exec_in_fp0+0x38a>
    a5ff:	eb 1d                	jmp    a61e <fwp_closure_drop_push+0xce>
    a601:	e8 5a c6 ff ff       	call   6c60 <fwp_flush>
    a606:	48 8b 05 cb f9 00 00 	mov    0xf9cb(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a60d:	48 8b 38             	mov    (%rax),%rdi
    a610:	48 8d 35 97 b4 00 00 	lea    0xb497(%rip),%rsi        # 15aae <exec_in_fp0+0x23e>
    a617:	48 8d 15 f6 b5 00 00 	lea    0xb5f6(%rip),%rdx        # 15c14 <exec_in_fp0+0x3a4>
    a61e:	31 c0                	xor    %eax,%eax
    a620:	e8 cb 8c ff ff       	call   32f0 <fprintf@plt>
    a625:	bf 65 00 00 00       	mov    $0x65,%edi
    a62a:	e8 31 8e ff ff       	call   3460 <exit@plt>
    a62f:	90                   	nop

000000000000a630 <fwp_closure_drop_release>:
    a630:	41 56                	push   %r14
    a632:	53                   	push   %rbx
    a633:	50                   	push   %rax
    a634:	48 89 fb             	mov    %rdi,%rbx
    a637:	64 48 c7 04 25 f8 ff 	movq   $0x0,%fs:0xfffffffffffffff8
    a63e:	ff ff 00 00 00 00 
    a644:	48 8b 3f             	mov    (%rdi),%rdi
    a647:	4c 8d 73 18          	lea    0x18(%rbx),%r14
    a64b:	4c 39 f7             	cmp    %r14,%rdi
    a64e:	74 05                	je     a655 <fwp_closure_drop_release+0x25>
    a650:	e8 fb 89 ff ff       	call   3050 <free@plt>
    a655:	4c 89 33             	mov    %r14,(%rbx)
    a658:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
    a65f:	00 
    a660:	48 83 c4 08          	add    $0x8,%rsp
    a664:	5b                   	pop    %rbx
    a665:	41 5e                	pop    %r14
    a667:	c3                   	ret
    a668:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a66f:	00 

000000000000a670 <fwp_rc_wide_drop>:
    a670:	53                   	push   %rbx
    a671:	48 89 f8             	mov    %rdi,%rax
    a674:	48 c1 e8 11          	shr    $0x11,%rax
    a678:	31 f8                	xor    %edi,%eax
    a67a:	89 c1                	mov    %eax,%ecx
    a67c:	c1 e9 09             	shr    $0x9,%ecx
    a67f:	31 c1                	xor    %eax,%ecx
    a681:	0f b6 c1             	movzbl %cl,%eax
    a684:	48 8d 0d fd fb 00 00 	lea    0xfbfd(%rip),%rcx        # 1a288 <fwp_gc>
    a68b:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    a692:	00 
    a693:	48 85 c0             	test   %rax,%rax
    a696:	74 16                	je     a6ae <fwp_rc_wide_drop+0x3e>
    a698:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a69f:	00 
    a6a0:	48 39 38             	cmp    %rdi,(%rax)
    a6a3:	74 37                	je     a6dc <fwp_rc_wide_drop+0x6c>
    a6a5:	48 8b 40 10          	mov    0x10(%rax),%rax
    a6a9:	48 85 c0             	test   %rax,%rax
    a6ac:	75 f2                	jne    a6a0 <fwp_rc_wide_drop+0x30>
    a6ae:	e8 ad c5 ff ff       	call   6c60 <fwp_flush>
    a6b3:	48 8b 05 1e f9 00 00 	mov    0xf91e(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a6ba:	48 8b 38             	mov    (%rax),%rdi
    a6bd:	48 8d 35 ea b3 00 00 	lea    0xb3ea(%rip),%rsi        # 15aae <exec_in_fp0+0x23e>
    a6c4:	48 8d 15 bc b3 00 00 	lea    0xb3bc(%rip),%rdx        # 15a87 <exec_in_fp0+0x217>
    a6cb:	31 c0                	xor    %eax,%eax
    a6cd:	e8 1e 8c ff ff       	call   32f0 <fprintf@plt>
    a6d2:	bf 65 00 00 00       	mov    $0x65,%edi
    a6d7:	e8 84 8d ff ff       	call   3460 <exit@plt>
    a6dc:	48 8b 48 08          	mov    0x8(%rax),%rcx
    a6e0:	48 ff c9             	dec    %rcx
    a6e3:	48 89 48 08          	mov    %rcx,0x8(%rax)
    a6e7:	48 81 f9 fe 00 00 00 	cmp    $0xfe,%rcx
    a6ee:	75 0b                	jne    a6fb <fwp_rc_wide_drop+0x8b>
    a6f0:	48 89 fb             	mov    %rdi,%rbx
    a6f3:	e8 b8 c4 ff ff       	call   6bb0 <fwp_rc_forget_slot>
    a6f8:	c6 03 fe             	movb   $0xfe,(%rbx)
    a6fb:	5b                   	pop    %rbx
    a6fc:	c3                   	ret
    a6fd:	0f 1f 00             	nopl   (%rax)

000000000000a700 <fwp_rc_wide_dup>:
    a700:	41 56                	push   %r14
    a702:	53                   	push   %rbx
    a703:	50                   	push   %rax
    a704:	48 89 fb             	mov    %rdi,%rbx
    a707:	48 89 f8             	mov    %rdi,%rax
    a70a:	48 c1 e8 11          	shr    $0x11,%rax
    a70e:	31 d8                	xor    %ebx,%eax
    a710:	89 c1                	mov    %eax,%ecx
    a712:	c1 e9 09             	shr    $0x9,%ecx
    a715:	31 c1                	xor    %eax,%ecx
    a717:	0f b6 c1             	movzbl %cl,%eax
    a71a:	48 8d 0d 67 fb 00 00 	lea    0xfb67(%rip),%rcx        # 1a288 <fwp_gc>
    a721:	4c 8d 34 c1          	lea    (%rcx,%rax,8),%r14
    a725:	49 81 c6 18 12 00 00 	add    $0x1218,%r14
    a72c:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    a733:	00 
    a734:	48 85 c0             	test   %rax,%rax
    a737:	74 1a                	je     a753 <fwp_rc_wide_dup+0x53>
    a739:	48 39 18             	cmp    %rbx,(%rax)
    a73c:	74 22                	je     a760 <fwp_rc_wide_dup+0x60>
    a73e:	66 90                	xchg   %ax,%ax
    a740:	49 89 c6             	mov    %rax,%r14
    a743:	48 8b 40 10          	mov    0x10(%rax),%rax
    a747:	48 85 c0             	test   %rax,%rax
    a74a:	74 0e                	je     a75a <fwp_rc_wide_dup+0x5a>
    a74c:	48 39 18             	cmp    %rbx,(%rax)
    a74f:	75 ef                	jne    a740 <fwp_rc_wide_dup+0x40>
    a751:	eb 09                	jmp    a75c <fwp_rc_wide_dup+0x5c>
    a753:	80 3b fe             	cmpb   $0xfe,(%rbx)
    a756:	74 16                	je     a76e <fwp_rc_wide_dup+0x6e>
    a758:	eb 6d                	jmp    a7c7 <fwp_rc_wide_dup+0xc7>
    a75a:	31 c0                	xor    %eax,%eax
    a75c:	49 83 c6 10          	add    $0x10,%r14
    a760:	80 3b fe             	cmpb   $0xfe,(%rbx)
    a763:	75 41                	jne    a7a6 <fwp_rc_wide_dup+0xa6>
    a765:	48 85 c0             	test   %rax,%rax
    a768:	0f 85 a2 00 00 00    	jne    a810 <fwp_rc_wide_dup+0x110>
    a76e:	bf 18 00 00 00       	mov    $0x18,%edi
    a773:	e8 c8 8b ff ff       	call   3340 <malloc@plt>
    a778:	48 85 c0             	test   %rax,%rax
    a77b:	74 69                	je     a7e6 <fwp_rc_wide_dup+0xe6>
    a77d:	48 89 18             	mov    %rbx,(%rax)
    a780:	48 c7 40 08 ff 00 00 	movq   $0xff,0x8(%rax)
    a787:	00 
    a788:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
    a78f:	00 
    a790:	49 89 06             	mov    %rax,(%r14)
    a793:	c6 03 ff             	movb   $0xff,(%rbx)
    a796:	48 8d 05 03 15 01 00 	lea    0x11503(%rip),%rax        # 1bca0 <fwp_gc+0x1a18>
    a79d:	48 8b 0d fc 14 01 00 	mov    0x114fc(%rip),%rcx        # 1bca0 <fwp_gc+0x1a18>
    a7a4:	eb 13                	jmp    a7b9 <fwp_rc_wide_dup+0xb9>
    a7a6:	48 85 c0             	test   %rax,%rax
    a7a9:	74 1c                	je     a7c7 <fwp_rc_wide_dup+0xc7>
    a7ab:	48 8b 48 08          	mov    0x8(%rax),%rcx
    a7af:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
    a7b3:	74 7a                	je     a82f <fwp_rc_wide_dup+0x12f>
    a7b5:	48 83 c0 08          	add    $0x8,%rax
    a7b9:	48 ff c1             	inc    %rcx
    a7bc:	48 89 08             	mov    %rcx,(%rax)
    a7bf:	48 83 c4 08          	add    $0x8,%rsp
    a7c3:	5b                   	pop    %rbx
    a7c4:	41 5e                	pop    %r14
    a7c6:	c3                   	ret
    a7c7:	e8 94 c4 ff ff       	call   6c60 <fwp_flush>
    a7cc:	48 8b 05 05 f8 00 00 	mov    0xf805(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a7d3:	48 8b 38             	mov    (%rax),%rdi
    a7d6:	48 8d 35 d1 b2 00 00 	lea    0xb2d1(%rip),%rsi        # 15aae <exec_in_fp0+0x23e>
    a7dd:	48 8d 15 a3 b2 00 00 	lea    0xb2a3(%rip),%rdx        # 15a87 <exec_in_fp0+0x217>
    a7e4:	eb 66                	jmp    a84c <fwp_rc_wide_dup+0x14c>
    a7e6:	48 8b 05 eb f7 00 00 	mov    0xf7eb(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a7ed:	48 8b 08             	mov    (%rax),%rcx
    a7f0:	48 8d 3d 0f b3 00 00 	lea    0xb30f(%rip),%rdi        # 15b06 <exec_in_fp0+0x296>
    a7f7:	be 13 00 00 00       	mov    $0x13,%esi
    a7fc:	ba 01 00 00 00       	mov    $0x1,%edx
    a801:	e8 7a 8c ff ff       	call   3480 <fwrite@plt>
    a806:	bf 66 00 00 00       	mov    $0x66,%edi
    a80b:	e8 50 8c ff ff       	call   3460 <exit@plt>
    a810:	e8 4b c4 ff ff       	call   6c60 <fwp_flush>
    a815:	48 8b 05 bc f7 00 00 	mov    0xf7bc(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a81c:	48 8b 38             	mov    (%rax),%rdi
    a81f:	48 8d 35 88 b2 00 00 	lea    0xb288(%rip),%rsi        # 15aae <exec_in_fp0+0x23e>
    a826:	48 8d 15 f5 b3 00 00 	lea    0xb3f5(%rip),%rdx        # 15c22 <exec_in_fp0+0x3b2>
    a82d:	eb 1d                	jmp    a84c <fwp_rc_wide_dup+0x14c>
    a82f:	e8 2c c4 ff ff       	call   6c60 <fwp_flush>
    a834:	48 8b 05 9d f7 00 00 	mov    0xf79d(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    a83b:	48 8b 38             	mov    (%rax),%rdi
    a83e:	48 8d 35 69 b2 00 00 	lea    0xb269(%rip),%rsi        # 15aae <exec_in_fp0+0x23e>
    a845:	48 8d 15 fb b3 00 00 	lea    0xb3fb(%rip),%rdx        # 15c47 <exec_in_fp0+0x3d7>
    a84c:	31 c0                	xor    %eax,%eax
    a84e:	e8 9d 8a ff ff       	call   32f0 <fprintf@plt>
    a853:	bf 65 00 00 00       	mov    $0x65,%edi
    a858:	e8 03 8c ff ff       	call   3460 <exit@plt>
    a85d:	0f 1f 00             	nopl   (%rax)

000000000000a860 <fwp_alloc_init>:
    a860:	53                   	push   %rbx
    a861:	48 ff 05 40 16 01 00 	incq   0x11640(%rip)        # 1bea8 <measured_calls>
    a868:	48 01 3d 41 16 01 00 	add    %rdi,0x11641(%rip)        # 1beb0 <measured_bytes>
    a86f:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    a876:	0f 87 f2 00 00 00    	ja     a96e <fwp_alloc_init+0x10e>
    a87c:	48 8d 77 0f          	lea    0xf(%rdi),%rsi
    a880:	48 c1 ee 04          	shr    $0x4,%rsi
    a884:	48 8d 05 fd f9 00 00 	lea    0xf9fd(%rip),%rax        # 1a288 <fwp_gc>
    a88b:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    a892:	00 
    a893:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    a89a:	4c 8b 05 e7 f9 00 00 	mov    0xf9e7(%rip),%r8        # 1a288 <fwp_gc>
    a8a1:	4d 89 c1             	mov    %r8,%r9
    a8a4:	49 29 d1             	sub    %rdx,%r9
    a8a7:	4c 89 0d da f9 00 00 	mov    %r9,0xf9da(%rip)        # 1a288 <fwp_gc>
    a8ae:	0f 88 ba 00 00 00    	js     a96e <fwp_alloc_init+0x10e>
    a8b4:	4c 8d 0c 49          	lea    (%rcx,%rcx,2),%r9
    a8b8:	4e 8d 14 c8          	lea    (%rax,%r9,8),%r10
    a8bc:	49 83 c2 08          	add    $0x8,%r10
    a8c0:	49 8b 1a             	mov    (%r10),%rbx
    a8c3:	48 85 db             	test   %rbx,%rbx
    a8c6:	74 35                	je     a8fd <fwp_alloc_init+0x9d>
    a8c8:	48 8b 03             	mov    (%rbx),%rax
    a8cb:	48 f7 d0             	not    %rax
    a8ce:	49 89 02             	mov    %rax,(%r10)
    a8d1:	81 e7 f8 7f 00 00    	and    $0x7ff8,%edi
    a8d7:	48 39 d7             	cmp    %rdx,%rdi
    a8da:	0f 83 af 00 00 00    	jae    a98f <fwp_alloc_init+0x12f>
    a8e0:	48 8d 04 3b          	lea    (%rbx,%rdi,1),%rax
    a8e4:	48 f7 d7             	not    %rdi
    a8e7:	48 01 d7             	add    %rdx,%rdi
    a8ea:	48 83 e7 f8          	and    $0xfffffffffffffff8,%rdi
    a8ee:	48 83 c7 08          	add    $0x8,%rdi
    a8f2:	48 89 fa             	mov    %rdi,%rdx
    a8f5:	48 89 c7             	mov    %rax,%rdi
    a8f8:	e9 8b 00 00 00       	jmp    a988 <fwp_alloc_init+0x128>
    a8fd:	4a 8b 5c c8 10       	mov    0x10(%rax,%r9,8),%rbx
    a902:	4e 8b 54 c8 18       	mov    0x18(%rax,%r9,8),%r10
    a907:	49 29 da             	sub    %rbx,%r10
    a90a:	49 39 d2             	cmp    %rdx,%r10
    a90d:	72 2f                	jb     a93e <fwp_alloc_init+0xde>
    a90f:	4a 8d 0c c8          	lea    (%rax,%r9,8),%rcx
    a913:	48 83 c1 10          	add    $0x10,%rcx
    a917:	4c 8d 0c 13          	lea    (%rbx,%rdx,1),%r9
    a91b:	4c 89 09             	mov    %r9,(%rcx)
    a91e:	48 85 db             	test   %rbx,%rbx
    a921:	75 ae                	jne    a8d1 <fwp_alloc_init+0x71>
    a923:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    a92a:	00 
    a92b:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    a932:	49 29 d0             	sub    %rdx,%r8
    a935:	4c 89 05 4c f9 00 00 	mov    %r8,0xf94c(%rip)        # 1a288 <fwp_gc>
    a93c:	78 30                	js     a96e <fwp_alloc_init+0x10e>
    a93e:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    a942:	48 8b 5c c8 08       	mov    0x8(%rax,%rcx,8),%rbx
    a947:	48 85 db             	test   %rbx,%rbx
    a94a:	74 10                	je     a95c <fwp_alloc_init+0xfc>
    a94c:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    a950:	48 83 c0 08          	add    $0x8,%rax
    a954:	48 8b 0b             	mov    (%rbx),%rcx
    a957:	48 f7 d1             	not    %rcx
    a95a:	eb 26                	jmp    a982 <fwp_alloc_init+0x122>
    a95c:	48 8b 5c c8 10       	mov    0x10(%rax,%rcx,8),%rbx
    a961:	48 8b 74 c8 18       	mov    0x18(%rax,%rcx,8),%rsi
    a966:	48 29 de             	sub    %rbx,%rsi
    a969:	48 39 d6             	cmp    %rdx,%rsi
    a96c:	73 08                	jae    a976 <fwp_alloc_init+0x116>
    a96e:	31 f6                	xor    %esi,%esi
    a970:	5b                   	pop    %rbx
    a971:	e9 ca d9 ff ff       	jmp    8340 <fwp_gc_alloc_slow>
    a976:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    a97a:	48 83 c0 10          	add    $0x10,%rax
    a97e:	48 8d 0c 13          	lea    (%rbx,%rdx,1),%rcx
    a982:	48 89 08             	mov    %rcx,(%rax)
    a985:	48 89 df             	mov    %rbx,%rdi
    a988:	31 f6                	xor    %esi,%esi
    a98a:	e8 81 88 ff ff       	call   3210 <memset@plt>
    a98f:	48 89 d8             	mov    %rbx,%rax
    a992:	5b                   	pop    %rbx
    a993:	c3                   	ret
    a994:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    a99b:	00 00 00 00 00 

000000000000a9a0 <fwp_rc_cleanup_cell>:
    a9a0:	48 89 f8             	mov    %rdi,%rax
    a9a3:	48 8b 3f             	mov    (%rdi),%rdi
    a9a6:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    a9ad:	48 85 ff             	test   %rdi,%rdi
    a9b0:	75 0e                	jne    a9c0 <fwp_rc_free_obj>
    a9b2:	c3                   	ret
    a9b3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a9ba:	84 00 00 00 00 00 

000000000000a9c0 <fwp_rc_free_obj>:
    a9c0:	48 89 f8             	mov    %rdi,%rax
    a9c3:	48 2b 05 ee 08 01 00 	sub    0x108ee(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    a9ca:	48 8b 0d 0f 09 01 00 	mov    0x1090f(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    a9d1:	48 c1 e1 10          	shl    $0x10,%rcx
    a9d5:	48 39 c8             	cmp    %rcx,%rax
    a9d8:	0f 83 b8 01 00 00    	jae    ab96 <fwp_rc_free_obj+0x1d6>
    a9de:	55                   	push   %rbp
    a9df:	41 57                	push   %r15
    a9e1:	41 56                	push   %r14
    a9e3:	53                   	push   %rbx
    a9e4:	50                   	push   %rax
    a9e5:	48 8b 1d 14 09 01 00 	mov    0x10914(%rip),%rbx        # 1b300 <fwp_gc+0x1078>
    a9ec:	48 89 c1             	mov    %rax,%rcx
    a9ef:	48 c1 e9 10          	shr    $0x10,%rcx
    a9f3:	4c 69 f1 28 12 00 00 	imul   $0x1228,%rcx,%r14
    a9fa:	42 0f b6 2c 33       	movzbl (%rbx,%r14,1),%ebp
    a9ff:	48 25 ff ff 00 00    	and    $0xffff,%rax
    aa05:	75 1a                	jne    aa21 <fwp_rc_free_obj+0x61>
    aa07:	40 80 fd 02          	cmp    $0x2,%bpl
    aa0b:	75 14                	jne    aa21 <fwp_rc_free_obj+0x61>
    aa0d:	4a 8d 04 33          	lea    (%rbx,%r14,1),%rax
    aa11:	48 05 28 02 00 00    	add    $0x228,%rax
    aa17:	80 38 01             	cmpb   $0x1,(%rax)
    aa1a:	74 32                	je     aa4e <fwp_rc_free_obj+0x8e>
    aa1c:	e9 6b 01 00 00       	jmp    ab8c <fwp_rc_free_obj+0x1cc>
    aa21:	40 80 fd 01          	cmp    $0x1,%bpl
    aa25:	0f 85 61 01 00 00    	jne    ab8c <fwp_rc_free_obj+0x1cc>
    aa2b:	4a 8d 0c 33          	lea    (%rbx,%r14,1),%rcx
    aa2f:	42 8b 54 33 20       	mov    0x20(%rbx,%r14,1),%edx
    aa34:	48 0f af c2          	imul   %rdx,%rax
    aa38:	48 c1 e8 20          	shr    $0x20,%rax
    aa3c:	48 01 c8             	add    %rcx,%rax
    aa3f:	48 05 28 02 00 00    	add    $0x228,%rax
    aa45:	80 38 01             	cmpb   $0x1,(%rax)
    aa48:	0f 85 3e 01 00 00    	jne    ab8c <fwp_rc_free_obj+0x1cc>
    aa4e:	8b 0d bc 12 01 00    	mov    0x112bc(%rip),%ecx        # 1bd10 <fwp_reuse_verify>
    aa54:	85 c9                	test   %ecx,%ecx
    aa56:	0f 88 c3 00 00 00    	js     ab1f <fwp_rc_free_obj+0x15f>
    aa5c:	85 c9                	test   %ecx,%ecx
    aa5e:	0f 84 fd 00 00 00    	je     ab61 <fwp_rc_free_obj+0x1a1>
    aa64:	42 80 7c 33 01 01    	cmpb   $0x1,0x1(%rbx,%r14,1)
    aa6a:	75 0d                	jne    aa79 <fwp_rc_free_obj+0xb9>
    aa6c:	40 80 fd 02          	cmp    $0x2,%bpl
    aa70:	75 22                	jne    aa94 <fwp_rc_free_obj+0xd4>
    aa72:	4a 8b 54 33 18       	mov    0x18(%rbx,%r14,1),%rdx
    aa77:	eb 20                	jmp    aa99 <fwp_rc_free_obj+0xd9>
    aa79:	c7 07 ad de 00 00    	movl   $0xdead,(%rdi)
    aa7f:	8b 47 04             	mov    0x4(%rdi),%eax
    aa82:	48 85 c0             	test   %rax,%rax
    aa85:	0f 84 01 01 00 00    	je     ab8c <fwp_rc_free_obj+0x1cc>
    aa8b:	83 f8 04             	cmp    $0x4,%eax
    aa8e:	73 26                	jae    aab6 <fwp_rc_free_obj+0xf6>
    aa90:	31 c9                	xor    %ecx,%ecx
    aa92:	eb 6a                	jmp    aafe <fwp_rc_free_obj+0x13e>
    aa94:	42 8b 54 33 08       	mov    0x8(%rbx,%r14,1),%edx
    aa99:	48 89 fb             	mov    %rdi,%rbx
    aa9c:	be dd 00 00 00       	mov    $0xdd,%esi
    aaa1:	e8 6a 87 ff ff       	call   3210 <memset@plt>
    aaa6:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    aaad:	c6 43 08 00          	movb   $0x0,0x8(%rbx)
    aab1:	e9 d6 00 00 00       	jmp    ab8c <fwp_rc_free_obj+0x1cc>
    aab6:	89 c1                	mov    %eax,%ecx
    aab8:	83 e1 fc             	and    $0xfffffffc,%ecx
    aabb:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    aac2:	00 
    aac3:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    aac7:	31 f6                	xor    %esi,%esi
    aac9:	66 0f 28 05 1f a6 00 	movapd 0xa61f(%rip),%xmm0        # 150f0 <_IO_stdin_used+0xf0>
    aad0:	00 
    aad1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    aad8:	0f 1f 84 00 00 00 00 
    aadf:	00 
    aae0:	66 0f 11 44 37 08    	movupd %xmm0,0x8(%rdi,%rsi,1)
    aae6:	66 0f 11 44 37 18    	movupd %xmm0,0x18(%rdi,%rsi,1)
    aaec:	48 83 c6 20          	add    $0x20,%rsi
    aaf0:	48 39 f2             	cmp    %rsi,%rdx
    aaf3:	75 eb                	jne    aae0 <fwp_rc_free_obj+0x120>
    aaf5:	48 39 c1             	cmp    %rax,%rcx
    aaf8:	0f 84 8e 00 00 00    	je     ab8c <fwp_rc_free_obj+0x1cc>
    aafe:	48 ba ef be ad de ef 	movabs $0xdeadbeefdeadbeef,%rdx
    ab05:	be ad de 
    ab08:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    ab0f:	00 
    ab10:	48 89 54 cf 08       	mov    %rdx,0x8(%rdi,%rcx,8)
    ab15:	48 ff c1             	inc    %rcx
    ab18:	48 39 c8             	cmp    %rcx,%rax
    ab1b:	75 f3                	jne    ab10 <fwp_rc_free_obj+0x150>
    ab1d:	eb 6d                	jmp    ab8c <fwp_rc_free_obj+0x1cc>
    ab1f:	49 89 ff             	mov    %rdi,%r15
    ab22:	48 8d 3d 37 b1 00 00 	lea    0xb137(%rip),%rdi        # 15c60 <exec_in_fp0+0x3f0>
    ab29:	e8 02 85 ff ff       	call   3030 <getenv@plt>
    ab2e:	31 c9                	xor    %ecx,%ecx
    ab30:	48 85 c0             	test   %rax,%rax
    ab33:	74 1b                	je     ab50 <fwp_rc_free_obj+0x190>
    ab35:	80 38 00             	cmpb   $0x0,(%rax)
    ab38:	74 16                	je     ab50 <fwp_rc_free_obj+0x190>
    ab3a:	48 8d 35 94 bc 00 00 	lea    0xbc94(%rip),%rsi        # 167d5 <exec_in_fp0+0xf65>
    ab41:	48 89 c7             	mov    %rax,%rdi
    ab44:	e8 87 87 ff ff       	call   32d0 <strcmp@plt>
    ab49:	31 c9                	xor    %ecx,%ecx
    ab4b:	85 c0                	test   %eax,%eax
    ab4d:	0f 95 c1             	setne  %cl
    ab50:	89 0d ba 11 01 00    	mov    %ecx,0x111ba(%rip)        # 1bd10 <fwp_reuse_verify>
    ab56:	4c 89 ff             	mov    %r15,%rdi
    ab59:	85 c9                	test   %ecx,%ecx
    ab5b:	0f 85 03 ff ff ff    	jne    aa64 <fwp_rc_free_obj+0xa4>
    ab61:	48 8b 1d 20 f7 00 00 	mov    0xf720(%rip),%rbx        # 1a288 <fwp_gc>
    ab68:	e8 33 00 00 00       	call   aba0 <fwp_mem_free>
    ab6d:	48 8b 05 14 f7 00 00 	mov    0xf714(%rip),%rax        # 1a288 <fwp_gc>
    ab74:	48 29 d8             	sub    %rbx,%rax
    ab77:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    ab7c:	f2 0f 58 05 0c 09 01 	addsd  0x1090c(%rip),%xmm0        # 1b490 <fwp_gc+0x1208>
    ab83:	00 
    ab84:	f2 0f 11 05 04 09 01 	movsd  %xmm0,0x10904(%rip)        # 1b490 <fwp_gc+0x1208>
    ab8b:	00 
    ab8c:	48 83 c4 08          	add    $0x8,%rsp
    ab90:	5b                   	pop    %rbx
    ab91:	41 5e                	pop    %r14
    ab93:	41 5f                	pop    %r15
    ab95:	5d                   	pop    %rbp
    ab96:	c3                   	ret
    ab97:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    ab9e:	00 00 

000000000000aba0 <fwp_mem_free>:
    aba0:	48 85 ff             	test   %rdi,%rdi
    aba3:	0f 84 17 02 00 00    	je     adc0 <fwp_mem_free+0x220>
    aba9:	48 8b 05 08 07 01 00 	mov    0x10708(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    abb0:	48 89 f9             	mov    %rdi,%rcx
    abb3:	48 29 c1             	sub    %rax,%rcx
    abb6:	48 8b 15 23 07 01 00 	mov    0x10723(%rip),%rdx        # 1b2e0 <fwp_gc+0x1058>
    abbd:	48 c1 e2 10          	shl    $0x10,%rdx
    abc1:	48 39 d1             	cmp    %rdx,%rcx
    abc4:	0f 83 f6 01 00 00    	jae    adc0 <fwp_mem_free+0x220>
    abca:	41 57                	push   %r15
    abcc:	41 56                	push   %r14
    abce:	41 55                	push   %r13
    abd0:	41 54                	push   %r12
    abd2:	53                   	push   %rbx
    abd3:	4c 8b 25 26 07 01 00 	mov    0x10726(%rip),%r12        # 1b300 <fwp_gc+0x1078>
    abda:	4d 85 e4             	test   %r12,%r12
    abdd:	0f 84 d4 01 00 00    	je     adb7 <fwp_mem_free+0x217>
    abe3:	49 89 cf             	mov    %rcx,%r15
    abe6:	49 c1 ef 10          	shr    $0x10,%r15
    abea:	4d 69 f7 28 12 00 00 	imul   $0x1228,%r15,%r14
    abf1:	43 0f b6 14 34       	movzbl (%r12,%r14,1),%edx
    abf6:	83 fa 02             	cmp    $0x2,%edx
    abf9:	0f 84 b9 00 00 00    	je     acb8 <fwp_mem_free+0x118>
    abff:	83 fa 01             	cmp    $0x1,%edx
    ac02:	0f 85 af 01 00 00    	jne    adb7 <fwp_mem_free+0x217>
    ac08:	47 0f b6 4c 34 01    	movzbl 0x1(%r12,%r14,1),%r9d
    ac0e:	47 0f b6 44 34 02    	movzbl 0x2(%r12,%r14,1),%r8d
    ac14:	43 8b 74 34 08       	mov    0x8(%r12,%r14,1),%esi
    ac19:	0f b7 c7             	movzwl %di,%eax
    ac1c:	31 d2                	xor    %edx,%edx
    ac1e:	f7 f6                	div    %esi
    ac20:	48 c7 c2 fe ff ff ff 	mov    $0xfffffffffffffffe,%rdx
    ac27:	89 c1                	mov    %eax,%ecx
    ac29:	48 d3 c2             	rol    %cl,%rdx
    ac2c:	4b 8d 0c 34          	lea    (%r12,%r14,1),%rcx
    ac30:	41 89 c2             	mov    %eax,%r10d
    ac33:	41 c1 ea 03          	shr    $0x3,%r10d
    ac37:	41 81 e2 f8 1f 00 00 	and    $0x1ff8,%r10d
    ac3e:	49 21 54 0a 28       	and    %rdx,0x28(%r10,%rcx,1)
    ac43:	49 69 d1 c0 03 00 00 	imul   $0x3c0,%r9,%rdx
    ac4a:	4c 8d 3d 37 f6 00 00 	lea    0xf637(%rip),%r15        # 1a288 <fwp_gc>
    ac51:	49 01 d7             	add    %rdx,%r15
    ac54:	4f 8d 2c 40          	lea    (%r8,%r8,2),%r13
    ac58:	4d 01 e6             	add    %r12,%r14
    ac5b:	49 83 c6 08          	add    $0x8,%r14
    ac5f:	48 8d 1c 08          	lea    (%rax,%rcx,1),%rbx
    ac63:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    ac6a:	80 bc 08 28 02 00 00 	cmpb   $0xff,0x228(%rax,%rcx,1)
    ac71:	ff 
    ac72:	0f 84 49 01 00 00    	je     adc1 <fwp_mem_free+0x221>
    ac78:	4f 8d 3c ef          	lea    (%r15,%r13,8),%r15
    ac7c:	49 83 c7 08          	add    $0x8,%r15
    ac80:	c6 03 00             	movb   $0x0,(%rbx)
    ac83:	83 3d 02 06 01 00 00 	cmpl   $0x0,0x10602(%rip)        # 1b28c <fwp_gc+0x1004>
    ac8a:	74 12                	je     ac9e <fwp_mem_free+0xfe>
    ac8c:	89 f2                	mov    %esi,%edx
    ac8e:	48 89 fb             	mov    %rdi,%rbx
    ac91:	31 f6                	xor    %esi,%esi
    ac93:	e8 78 85 ff ff       	call   3210 <memset@plt>
    ac98:	48 89 df             	mov    %rbx,%rdi
    ac9b:	41 8b 36             	mov    (%r14),%esi
    ac9e:	49 8b 07             	mov    (%r15),%rax
    aca1:	48 f7 d0             	not    %rax
    aca4:	48 89 07             	mov    %rax,(%rdi)
    aca7:	49 89 3f             	mov    %rdi,(%r15)
    acaa:	89 f0                	mov    %esi,%eax
    acac:	48 01 05 d5 f5 00 00 	add    %rax,0xf5d5(%rip)        # 1a288 <fwp_gc>
    acb3:	e9 ff 00 00 00       	jmp    adb7 <fwp_mem_free+0x217>
    acb8:	48 81 e1 00 00 ff ff 	and    $0xffffffffffff0000,%rcx
    acbf:	48 01 c8             	add    %rcx,%rax
    acc2:	48 39 f8             	cmp    %rdi,%rax
    acc5:	0f 85 ec 00 00 00    	jne    adb7 <fwp_mem_free+0x217>
    accb:	4b 8b 44 34 18       	mov    0x18(%r12,%r14,1),%rax
    acd0:	48 01 05 b1 f5 00 00 	add    %rax,0xf5b1(%rip)        # 1a288 <fwp_gc>
    acd7:	43 c6 44 34 03 00    	movb   $0x0,0x3(%r12,%r14,1)
    acdd:	4b 8d 1c 34          	lea    (%r12,%r14,1),%rbx
    ace1:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    ace8:	43 80 bc 34 28 02 00 	cmpb   $0xff,0x228(%r12,%r14,1)
    acef:	00 ff 
    acf1:	0f 84 e0 00 00 00    	je     add7 <fwp_mem_free+0x237>
    acf7:	c6 03 00             	movb   $0x0,(%rbx)
    acfa:	43 8b 44 34 10       	mov    0x10(%r12,%r14,1),%eax
    acff:	48 85 c0             	test   %rax,%rax
    ad02:	0f 84 88 00 00 00    	je     ad90 <fwp_mem_free+0x1f0>
    ad08:	48 8b 0d f1 05 01 00 	mov    0x105f1(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    ad0f:	89 c2                	mov    %eax,%edx
    ad11:	83 e2 03             	and    $0x3,%edx
    ad14:	83 f8 04             	cmp    $0x4,%eax
    ad17:	73 04                	jae    ad1d <fwp_mem_free+0x17d>
    ad19:	31 f6                	xor    %esi,%esi
    ad1b:	eb 3b                	jmp    ad58 <fwp_mem_free+0x1b8>
    ad1d:	4a 8d 3c 31          	lea    (%rcx,%r14,1),%rdi
    ad21:	41 89 c0             	mov    %eax,%r8d
    ad24:	41 83 e0 fc          	and    $0xfffffffc,%r8d
    ad28:	31 f6                	xor    %esi,%esi
    ad2a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    ad30:	c6 07 00             	movb   $0x0,(%rdi)
    ad33:	c6 87 28 12 00 00 00 	movb   $0x0,0x1228(%rdi)
    ad3a:	c6 87 50 24 00 00 00 	movb   $0x0,0x2450(%rdi)
    ad41:	c6 87 78 36 00 00 00 	movb   $0x0,0x3678(%rdi)
    ad48:	48 83 c6 04          	add    $0x4,%rsi
    ad4c:	48 81 c7 a0 48 00 00 	add    $0x48a0,%rdi
    ad53:	49 39 f0             	cmp    %rsi,%r8
    ad56:	75 d8                	jne    ad30 <fwp_mem_free+0x190>
    ad58:	48 85 d2             	test   %rdx,%rdx
    ad5b:	74 33                	je     ad90 <fwp_mem_free+0x1f0>
    ad5d:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    ad64:	4c 01 f6             	add    %r14,%rsi
    ad67:	48 01 f1             	add    %rsi,%rcx
    ad6a:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    ad71:	31 f6                	xor    %esi,%esi
    ad73:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ad7a:	84 00 00 00 00 00 
    ad80:	c6 04 31 00          	movb   $0x0,(%rcx,%rsi,1)
    ad84:	48 81 c6 28 12 00 00 	add    $0x1228,%rsi
    ad8b:	48 39 f2             	cmp    %rsi,%rdx
    ad8e:	75 f0                	jne    ad80 <fwp_mem_free+0x1e0>
    ad90:	48 01 05 d1 06 01 00 	add    %rax,0x106d1(%rip)        # 1b468 <fwp_gc+0x11e0>
    ad97:	4c 3b 3d 5a 05 01 00 	cmp    0x1055a(%rip),%r15        # 1b2f8 <fwp_gc+0x1070>
    ad9e:	73 07                	jae    ada7 <fwp_mem_free+0x207>
    ada0:	4c 89 3d 51 05 01 00 	mov    %r15,0x10551(%rip)        # 1b2f8 <fwp_gc+0x1070>
    ada7:	4c 3b 3d 42 05 01 00 	cmp    0x10542(%rip),%r15        # 1b2f0 <fwp_gc+0x1068>
    adae:	73 07                	jae    adb7 <fwp_mem_free+0x217>
    adb0:	4c 89 3d 39 05 01 00 	mov    %r15,0x10539(%rip)        # 1b2f0 <fwp_gc+0x1068>
    adb7:	5b                   	pop    %rbx
    adb8:	41 5c                	pop    %r12
    adba:	41 5d                	pop    %r13
    adbc:	41 5e                	pop    %r14
    adbe:	41 5f                	pop    %r15
    adc0:	c3                   	ret
    adc1:	49 89 fc             	mov    %rdi,%r12
    adc4:	48 89 df             	mov    %rbx,%rdi
    adc7:	e8 e4 bd ff ff       	call   6bb0 <fwp_rc_forget_slot>
    adcc:	4c 89 e7             	mov    %r12,%rdi
    adcf:	41 8b 36             	mov    (%r14),%esi
    add2:	e9 a1 fe ff ff       	jmp    ac78 <fwp_mem_free+0xd8>
    add7:	48 89 df             	mov    %rbx,%rdi
    adda:	e8 d1 bd ff ff       	call   6bb0 <fwp_rc_forget_slot>
    addf:	e9 13 ff ff ff       	jmp    acf7 <fwp_mem_free+0x157>
    ade4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    adeb:	00 00 00 00 00 

000000000000adf0 <fwp_rc_free_arr>:
    adf0:	48 89 f8             	mov    %rdi,%rax
    adf3:	48 2b 05 be 04 01 00 	sub    0x104be(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    adfa:	48 8b 0d df 04 01 00 	mov    0x104df(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    ae01:	48 c1 e1 10          	shl    $0x10,%rcx
    ae05:	48 39 c8             	cmp    %rcx,%rax
    ae08:	0f 83 e9 00 00 00    	jae    aef7 <fwp_rc_free_arr+0x107>
    ae0e:	53                   	push   %rbx
    ae0f:	48 8b 0d ea 04 01 00 	mov    0x104ea(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    ae16:	48 89 c2             	mov    %rax,%rdx
    ae19:	48 c1 ea 10          	shr    $0x10,%rdx
    ae1d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    ae24:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    ae28:	48 25 ff ff 00 00    	and    $0xffff,%rax
    ae2e:	75 1a                	jne    ae4a <fwp_rc_free_arr+0x5a>
    ae30:	40 80 fe 02          	cmp    $0x2,%sil
    ae34:	75 14                	jne    ae4a <fwp_rc_free_arr+0x5a>
    ae36:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    ae3a:	48 05 28 02 00 00    	add    $0x228,%rax
    ae40:	80 38 01             	cmpb   $0x1,(%rax)
    ae43:	74 31                	je     ae76 <fwp_rc_free_arr+0x86>
    ae45:	e9 ac 00 00 00       	jmp    aef6 <fwp_rc_free_arr+0x106>
    ae4a:	40 80 fe 01          	cmp    $0x1,%sil
    ae4e:	0f 85 a2 00 00 00    	jne    aef6 <fwp_rc_free_arr+0x106>
    ae54:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    ae58:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ae5c:	48 0f af c1          	imul   %rcx,%rax
    ae60:	48 c1 e8 20          	shr    $0x20,%rax
    ae64:	48 01 f0             	add    %rsi,%rax
    ae67:	48 05 28 02 00 00    	add    $0x228,%rax
    ae6d:	80 38 01             	cmpb   $0x1,(%rax)
    ae70:	0f 85 80 00 00 00    	jne    aef6 <fwp_rc_free_arr+0x106>
    ae76:	8b 0d 94 0e 01 00    	mov    0x10e94(%rip),%ecx        # 1bd10 <fwp_reuse_verify>
    ae7c:	85 c9                	test   %ecx,%ecx
    ae7e:	78 0d                	js     ae8d <fwp_rc_free_arr+0x9d>
    ae80:	85 c9                	test   %ecx,%ecx
    ae82:	74 47                	je     aecb <fwp_rc_free_arr+0xdb>
    ae84:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    ae8b:	eb 69                	jmp    aef6 <fwp_rc_free_arr+0x106>
    ae8d:	48 89 fb             	mov    %rdi,%rbx
    ae90:	48 8d 3d c9 ad 00 00 	lea    0xadc9(%rip),%rdi        # 15c60 <exec_in_fp0+0x3f0>
    ae97:	e8 94 81 ff ff       	call   3030 <getenv@plt>
    ae9c:	31 c9                	xor    %ecx,%ecx
    ae9e:	48 85 c0             	test   %rax,%rax
    aea1:	74 1b                	je     aebe <fwp_rc_free_arr+0xce>
    aea3:	80 38 00             	cmpb   $0x0,(%rax)
    aea6:	74 16                	je     aebe <fwp_rc_free_arr+0xce>
    aea8:	48 8d 35 26 b9 00 00 	lea    0xb926(%rip),%rsi        # 167d5 <exec_in_fp0+0xf65>
    aeaf:	48 89 c7             	mov    %rax,%rdi
    aeb2:	e8 19 84 ff ff       	call   32d0 <strcmp@plt>
    aeb7:	31 c9                	xor    %ecx,%ecx
    aeb9:	85 c0                	test   %eax,%eax
    aebb:	0f 95 c1             	setne  %cl
    aebe:	89 0d 4c 0e 01 00    	mov    %ecx,0x10e4c(%rip)        # 1bd10 <fwp_reuse_verify>
    aec4:	48 89 df             	mov    %rbx,%rdi
    aec7:	85 c9                	test   %ecx,%ecx
    aec9:	75 b9                	jne    ae84 <fwp_rc_free_arr+0x94>
    aecb:	48 8b 1d b6 f3 00 00 	mov    0xf3b6(%rip),%rbx        # 1a288 <fwp_gc>
    aed2:	e8 c9 fc ff ff       	call   aba0 <fwp_mem_free>
    aed7:	48 8b 05 aa f3 00 00 	mov    0xf3aa(%rip),%rax        # 1a288 <fwp_gc>
    aede:	48 29 d8             	sub    %rbx,%rax
    aee1:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    aee6:	f2 0f 58 05 a2 05 01 	addsd  0x105a2(%rip),%xmm0        # 1b490 <fwp_gc+0x1208>
    aeed:	00 
    aeee:	f2 0f 11 05 9a 05 01 	movsd  %xmm0,0x1059a(%rip)        # 1b490 <fwp_gc+0x1208>
    aef5:	00 
    aef6:	5b                   	pop    %rbx
    aef7:	c3                   	ret
    aef8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    aeff:	00 

000000000000af00 <fwp_owner_release6>:
    af00:	48 8b 3f             	mov    (%rdi),%rdi
    af03:	eb 0b                	jmp    af10 <fwp_drop2>
    af05:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    af0c:	00 00 00 00 

000000000000af10 <fwp_drop2>:
    af10:	53                   	push   %rbx
    af11:	48 89 f8             	mov    %rdi,%rax
    af14:	48 2b 05 9d 03 01 00 	sub    0x1039d(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    af1b:	48 8b 0d be 03 01 00 	mov    0x103be(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    af22:	48 c1 e1 10          	shl    $0x10,%rcx
    af26:	48 39 c8             	cmp    %rcx,%rax
    af29:	0f 83 9c 00 00 00    	jae    afcb <fwp_drop2+0xbb>
    af2f:	48 8b 0d ca 03 01 00 	mov    0x103ca(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
    af36:	48 89 c2             	mov    %rax,%rdx
    af39:	48 c1 ea 10          	shr    $0x10,%rdx
    af3d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    af44:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    af48:	48 25 ff ff 00 00    	and    $0xffff,%rax
    af4e:	75 20                	jne    af70 <fwp_drop2+0x60>
    af50:	40 80 fe 02          	cmp    $0x2,%sil
    af54:	75 1a                	jne    af70 <fwp_drop2+0x60>
    af56:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    af5a:	48 05 28 02 00 00    	add    $0x228,%rax
    af60:	eb 2d                	jmp    af8f <fwp_drop2+0x7f>
    af62:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    af69:	1f 84 00 00 00 00 00 
    af70:	40 80 fe 01          	cmp    $0x1,%sil
    af74:	75 55                	jne    afcb <fwp_drop2+0xbb>
    af76:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    af7a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    af7e:	48 0f af c1          	imul   %rcx,%rax
    af82:	48 c1 e8 20          	shr    $0x20,%rax
    af86:	48 01 f0             	add    %rsi,%rax
    af89:	48 05 28 02 00 00    	add    $0x228,%rax
    af8f:	0f b6 08             	movzbl (%rax),%ecx
    af92:	85 c9                	test   %ecx,%ecx
    af94:	74 35                	je     afcb <fwp_drop2+0xbb>
    af96:	83 f9 01             	cmp    $0x1,%ecx
    af99:	75 32                	jne    afcd <fwp_drop2+0xbd>
    af9b:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    af9f:	79 3a                	jns    afdb <fwp_drop2+0xcb>
    afa1:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    afa5:	e8 46 fe ff ff       	call   adf0 <fwp_rc_free_arr>
    afaa:	48 89 d8             	mov    %rbx,%rax
    afad:	48 2b 05 04 03 01 00 	sub    0x10304(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
    afb4:	48 8b 0d 25 03 01 00 	mov    0x10325(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
    afbb:	48 c1 e1 10          	shl    $0x10,%rcx
    afbf:	48 89 df             	mov    %rbx,%rdi
    afc2:	48 39 c8             	cmp    %rcx,%rax
    afc5:	0f 82 64 ff ff ff    	jb     af2f <fwp_drop2+0x1f>
    afcb:	5b                   	pop    %rbx
    afcc:	c3                   	ret
    afcd:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    afd3:	74 0c                	je     afe1 <fwp_drop2+0xd1>
    afd5:	fe c9                	dec    %cl
    afd7:	88 08                	mov    %cl,(%rax)
    afd9:	5b                   	pop    %rbx
    afda:	c3                   	ret
    afdb:	5b                   	pop    %rbx
    afdc:	e9 0f fe ff ff       	jmp    adf0 <fwp_rc_free_arr>
    afe1:	48 89 c7             	mov    %rax,%rdi
    afe4:	5b                   	pop    %rbx
    afe5:	e9 86 f6 ff ff       	jmp    a670 <fwp_rc_wide_drop>
    afea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000aff0 <fwp_owner_release7>:
    aff0:	48 8b 3f             	mov    (%rdi),%rdi
    aff3:	e9 18 ff ff ff       	jmp    af10 <fwp_drop2>
    aff8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    afff:	00 

000000000000b000 <fwp_owner_release8>:
    b000:	48 8b 3f             	mov    (%rdi),%rdi
    b003:	e9 08 ff ff ff       	jmp    af10 <fwp_drop2>
    b008:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    b00f:	00 

000000000000b010 <fwp_owner_release9>:
    b010:	48 8b 3f             	mov    (%rdi),%rdi
    b013:	e9 f8 fe ff ff       	jmp    af10 <fwp_drop2>
    b018:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    b01f:	00 

000000000000b020 <fwp_owned_entry5>:
    b020:	48 0f be 0f          	movsbq (%rdi),%rcx
    b024:	48 0f be 47 08       	movsbq 0x8(%rdi),%rax
    b029:	48 01 c8             	add    %rcx,%rax
    b02c:	48 0f be c8          	movsbq %al,%rcx
    b030:	48 39 c1             	cmp    %rax,%rcx
    b033:	75 01                	jne    b036 <fwp_owned_entry5+0x16>
    b035:	c3                   	ret
    b036:	53                   	push   %rbx
    b037:	48 83 ec 60          	sub    $0x60,%rsp
    b03b:	48 8d 15 36 ac 00 00 	lea    0xac36(%rip),%rdx        # 15c78 <exec_in_fp0+0x408>
    b042:	48 8d 0d 2c ac 00 00 	lea    0xac2c(%rip),%rcx        # 15c75 <exec_in_fp0+0x405>
    b049:	48 89 e3             	mov    %rsp,%rbx
    b04c:	be 60 00 00 00       	mov    $0x60,%esi
    b051:	48 89 df             	mov    %rbx,%rdi
    b054:	31 c0                	xor    %eax,%eax
    b056:	e8 75 81 ff ff       	call   31d0 <snprintf@plt>
    b05b:	e8 00 bc ff ff       	call   6c60 <fwp_flush>
    b060:	48 8b 05 71 ef 00 00 	mov    0xef71(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    b067:	48 8b 38             	mov    (%rax),%rdi
    b06a:	48 8d 35 3d aa 00 00 	lea    0xaa3d(%rip),%rsi        # 15aae <exec_in_fp0+0x23e>
    b071:	48 89 da             	mov    %rbx,%rdx
    b074:	31 c0                	xor    %eax,%eax
    b076:	e8 75 82 ff ff       	call   32f0 <fprintf@plt>
    b07b:	bf 65 00 00 00       	mov    $0x65,%edi
    b080:	e8 db 83 ff ff       	call   3460 <exit@plt>
    b085:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b08c:	00 00 00 00 

000000000000b090 <fwp_caps5>:
    b090:	85 f6                	test   %esi,%esi
    b092:	0f 84 28 f9 ff ff    	je     a9c0 <fwp_rc_free_obj>
    b098:	c3                   	ret
    b099:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000b0a0 <fwp_args5>:
    b0a0:	c3                   	ret
    b0a1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b0a8:	0f 1f 84 00 00 00 00 
    b0af:	00 

000000000000b0b0 <fwp_owned_entry12>:
    b0b0:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    b0b4:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    b0b9:	0f 59 c8             	mulps  %xmm0,%xmm1
    b0bc:	66 0f 7e c8          	movd   %xmm1,%eax
    b0c0:	c3                   	ret
    b0c1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b0c8:	0f 1f 84 00 00 00 00 
    b0cf:	00 

000000000000b0d0 <fwp_caps12>:
    b0d0:	85 f6                	test   %esi,%esi
    b0d2:	0f 84 e8 f8 ff ff    	je     a9c0 <fwp_rc_free_obj>
    b0d8:	c3                   	ret
    b0d9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000b0e0 <fwp_args12>:
    b0e0:	c3                   	ret
    b0e1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b0e8:	0f 1f 84 00 00 00 00 
    b0ef:	00 

000000000000b0f0 <fwp_owned_entry13>:
    b0f0:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    b0f4:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    b0f9:	0f 58 c8             	addps  %xmm0,%xmm1
    b0fc:	66 0f 7e c8          	movd   %xmm1,%eax
    b100:	c3                   	ret
    b101:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b108:	0f 1f 84 00 00 00 00 
    b10f:	00 

000000000000b110 <fwp_caps13>:
    b110:	85 f6                	test   %esi,%esi
    b112:	0f 84 a8 f8 ff ff    	je     a9c0 <fwp_rc_free_obj>
    b118:	c3                   	ret
    b119:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000b120 <fwp_args13>:
    b120:	c3                   	ret
    b121:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b128:	0f 1f 84 00 00 00 00 
    b12f:	00 

000000000000b130 <fwp_owned_entry20>:
    b130:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    b134:	f2 0f 59 47 08       	mulsd  0x8(%rdi),%xmm0
    b139:	66 48 0f 7e c0       	movq   %xmm0,%rax
    b13e:	c3                   	ret
    b13f:	90                   	nop

000000000000b140 <fwp_caps20>:
    b140:	85 f6                	test   %esi,%esi
    b142:	0f 84 78 f8 ff ff    	je     a9c0 <fwp_rc_free_obj>
    b148:	c3                   	ret
    b149:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000b150 <fwp_args20>:
    b150:	c3                   	ret
    b151:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b158:	0f 1f 84 00 00 00 00 
    b15f:	00 

000000000000b160 <fwp_owned_entry21>:
    b160:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    b164:	f2 0f 58 47 08       	addsd  0x8(%rdi),%xmm0
    b169:	66 48 0f 7e c0       	movq   %xmm0,%rax
    b16e:	c3                   	ret
    b16f:	90                   	nop

000000000000b170 <fwp_caps21>:
    b170:	85 f6                	test   %esi,%esi
    b172:	0f 84 48 f8 ff ff    	je     a9c0 <fwp_rc_free_obj>
    b178:	c3                   	ret
    b179:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000b180 <fwp_args21>:
    b180:	c3                   	ret
    b181:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b188:	0f 1f 84 00 00 00 00 
    b18f:	00 

000000000000b190 <fwp_segv>:
    b190:	48 8b 05 51 0d 01 00 	mov    0x10d51(%rip),%rax        # 1bee8 <fwp_main_stack_top>
    b197:	48 85 c0             	test   %rax,%rax
    b19a:	74 22                	je     b1be <fwp_segv+0x2e>
    b19c:	48 8b 4e 10          	mov    0x10(%rsi),%rcx
    b1a0:	48 2b 05 49 0d 01 00 	sub    0x10d49(%rip),%rax        # 1bef0 <fwp_main_stack_size>
    b1a7:	48 8d 90 00 00 f0 ff 	lea    -0x100000(%rax),%rdx
    b1ae:	48 39 ca             	cmp    %rcx,%rdx
    b1b1:	77 0b                	ja     b1be <fwp_segv+0x2e>
    b1b3:	48 05 00 00 10 00    	add    $0x100000,%rax
    b1b9:	48 39 c8             	cmp    %rcx,%rax
    b1bc:	77 07                	ja     b1c5 <fwp_segv+0x35>
    b1be:	31 f6                	xor    %esi,%esi
    b1c0:	e9 1b 81 ff ff       	jmp    32e0 <signal@plt>
    b1c5:	50                   	push   %rax
    b1c6:	e8 95 ba ff ff       	call   6c60 <fwp_flush>
    b1cb:	48 8d 35 4e a6 00 00 	lea    0xa64e(%rip),%rsi        # 15820 <fwp_segv.msg>
    b1d2:	ba 1a 00 00 00       	mov    $0x1a,%edx
    b1d7:	bf 02 00 00 00       	mov    $0x2,%edi
    b1dc:	e8 5f 7f ff ff       	call   3140 <write@plt>
    b1e1:	bf 65 00 00 00       	mov    $0x65,%edi
    b1e6:	e8 b5 7e ff ff       	call   30a0 <_exit@plt>
    b1eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000b1f0 <fwp_str_lossy>:
    b1f0:	55                   	push   %rbp
    b1f1:	41 57                	push   %r15
    b1f3:	41 56                	push   %r14
    b1f5:	41 55                	push   %r13
    b1f7:	41 54                	push   %r12
    b1f9:	53                   	push   %rbx
    b1fa:	48 83 ec 28          	sub    $0x28,%rsp
    b1fe:	49 89 f6             	mov    %rsi,%r14
    b201:	48 89 fb             	mov    %rdi,%rbx
    b204:	48 85 f6             	test   %rsi,%rsi
    b207:	0f 84 47 01 00 00    	je     b354 <fwp_str_lossy+0x164>
    b20d:	31 c0                	xor    %eax,%eax
    b20f:	eb 1b                	jmp    b22c <fwp_str_lossy+0x3c>
    b211:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b218:	0f 1f 84 00 00 00 00 
    b21f:	00 
    b220:	48 ff c0             	inc    %rax
    b223:	4c 39 f0             	cmp    %r14,%rax
    b226:	0f 83 28 01 00 00    	jae    b354 <fwp_str_lossy+0x164>
    b22c:	0f b6 3c 03          	movzbl (%rbx,%rax,1),%edi
    b230:	40 84 ff             	test   %dil,%dil
    b233:	79 eb                	jns    b220 <fwp_str_lossy+0x30>
    b235:	8d 4f 3e             	lea    0x3e(%rdi),%ecx
    b238:	80 f9 1e             	cmp    $0x1e,%cl
    b23b:	73 11                	jae    b24e <fwp_str_lossy+0x5e>
    b23d:	b9 80 00 00 00       	mov    $0x80,%ecx
    b242:	be 01 00 00 00       	mov    $0x1,%esi
    b247:	ba 1f 00 00 00       	mov    $0x1f,%edx
    b24c:	eb 36                	jmp    b284 <fwp_str_lossy+0x94>
    b24e:	89 f9                	mov    %edi,%ecx
    b250:	80 e1 f0             	and    $0xf0,%cl
    b253:	80 f9 e0             	cmp    $0xe0,%cl
    b256:	75 11                	jne    b269 <fwp_str_lossy+0x79>
    b258:	b9 00 08 00 00       	mov    $0x800,%ecx
    b25d:	be 02 00 00 00       	mov    $0x2,%esi
    b262:	ba 0f 00 00 00       	mov    $0xf,%edx
    b267:	eb 1b                	jmp    b284 <fwp_str_lossy+0x94>
    b269:	8d 4f 10             	lea    0x10(%rdi),%ecx
    b26c:	80 f9 04             	cmp    $0x4,%cl
    b26f:	0f 87 52 01 00 00    	ja     b3c7 <fwp_str_lossy+0x1d7>
    b275:	b9 00 00 01 00       	mov    $0x10000,%ecx
    b27a:	be 03 00 00 00       	mov    $0x3,%esi
    b27f:	ba 07 00 00 00       	mov    $0x7,%edx
    b284:	89 f6                	mov    %esi,%esi
    b286:	4c 8d 04 30          	lea    (%rax,%rsi,1),%r8
    b28a:	4d 39 f0             	cmp    %r14,%r8
    b28d:	0f 83 34 01 00 00    	jae    b3c7 <fwp_str_lossy+0x1d7>
    b293:	44 0f b6 44 03 01    	movzbl 0x1(%rbx,%rax,1),%r8d
    b299:	45 89 c1             	mov    %r8d,%r9d
    b29c:	41 83 e1 c0          	and    $0xffffffc0,%r9d
    b2a0:	41 81 f9 80 00 00 00 	cmp    $0x80,%r9d
    b2a7:	0f 85 1a 01 00 00    	jne    b3c7 <fwp_str_lossy+0x1d7>
    b2ad:	21 fa                	and    %edi,%edx
    b2af:	8d 7e 01             	lea    0x1(%rsi),%edi
    b2b2:	41 89 d1             	mov    %edx,%r9d
    b2b5:	41 c1 e1 06          	shl    $0x6,%r9d
    b2b9:	41 83 e0 3f          	and    $0x3f,%r8d
    b2bd:	45 09 c8             	or     %r9d,%r8d
    b2c0:	83 ff 02             	cmp    $0x2,%edi
    b2c3:	75 05                	jne    b2ca <fwp_str_lossy+0xda>
    b2c5:	44 89 c7             	mov    %r8d,%edi
    b2c8:	eb 58                	jmp    b322 <fwp_str_lossy+0x132>
    b2ca:	0f b6 54 03 02       	movzbl 0x2(%rbx,%rax,1),%edx
    b2cf:	41 89 d1             	mov    %edx,%r9d
    b2d2:	41 83 e1 c0          	and    $0xffffffc0,%r9d
    b2d6:	41 81 f9 80 00 00 00 	cmp    $0x80,%r9d
    b2dd:	0f 85 e4 00 00 00    	jne    b3c7 <fwp_str_lossy+0x1d7>
    b2e3:	45 89 c1             	mov    %r8d,%r9d
    b2e6:	41 c1 e1 06          	shl    $0x6,%r9d
    b2ea:	83 e2 3f             	and    $0x3f,%edx
    b2ed:	44 09 ca             	or     %r9d,%edx
    b2f0:	83 ff 03             	cmp    $0x3,%edi
    b2f3:	75 07                	jne    b2fc <fwp_str_lossy+0x10c>
    b2f5:	89 d7                	mov    %edx,%edi
    b2f7:	44 89 c2             	mov    %r8d,%edx
    b2fa:	eb 26                	jmp    b322 <fwp_str_lossy+0x132>
    b2fc:	0f b6 7c 03 03       	movzbl 0x3(%rbx,%rax,1),%edi
    b301:	41 89 f8             	mov    %edi,%r8d
    b304:	41 83 e0 c0          	and    $0xffffffc0,%r8d
    b308:	41 81 f8 80 00 00 00 	cmp    $0x80,%r8d
    b30f:	0f 85 b2 00 00 00    	jne    b3c7 <fwp_str_lossy+0x1d7>
    b315:	41 89 d0             	mov    %edx,%r8d
    b318:	41 c1 e0 06          	shl    $0x6,%r8d
    b31c:	83 e7 3f             	and    $0x3f,%edi
    b31f:	44 09 c7             	or     %r8d,%edi
    b322:	83 e2 e0             	and    $0xffffffe0,%edx
    b325:	81 fa 60 03 00 00    	cmp    $0x360,%edx
    b32b:	0f 84 96 00 00 00    	je     b3c7 <fwp_str_lossy+0x1d7>
    b331:	39 cf                	cmp    %ecx,%edi
    b333:	0f 82 8e 00 00 00    	jb     b3c7 <fwp_str_lossy+0x1d7>
    b339:	81 ff ff ff 10 00    	cmp    $0x10ffff,%edi
    b33f:	0f 87 82 00 00 00    	ja     b3c7 <fwp_str_lossy+0x1d7>
    b345:	48 01 f0             	add    %rsi,%rax
    b348:	48 ff c0             	inc    %rax
    b34b:	4c 39 f0             	cmp    %r14,%rax
    b34e:	0f 82 d8 fe ff ff    	jb     b22c <fwp_str_lossy+0x3c>
    b354:	49 8d 56 09          	lea    0x9(%r14),%rdx
    b358:	48 ff 05 49 0b 01 00 	incq   0x10b49(%rip)        # 1bea8 <measured_calls>
    b35f:	48 01 15 4a 0b 01 00 	add    %rdx,0x10b4a(%rip)        # 1beb0 <measured_bytes>
    b366:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    b36d:	0f 87 01 02 00 00    	ja     b574 <fwp_str_lossy+0x384>
    b373:	49 8d 4e 18          	lea    0x18(%r14),%rcx
    b377:	48 c1 e9 04          	shr    $0x4,%rcx
    b37b:	48 8d 05 06 ef 00 00 	lea    0xef06(%rip),%rax        # 1a288 <fwp_gc>
    b382:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    b389:	00 
    b38a:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    b391:	48 29 0d f0 ee 00 00 	sub    %rcx,0xeef0(%rip)        # 1a288 <fwp_gc>
    b398:	0f 88 d6 01 00 00    	js     b574 <fwp_str_lossy+0x384>
    b39e:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    b3a2:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    b3a6:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    b3ad:	4c 8b 3f             	mov    (%rdi),%r15
    b3b0:	4d 85 ff             	test   %r15,%r15
    b3b3:	0f 84 a3 01 00 00    	je     b55c <fwp_str_lossy+0x36c>
    b3b9:	49 8b 07             	mov    (%r15),%rax
    b3bc:	48 f7 d0             	not    %rax
    b3bf:	48 89 07             	mov    %rax,(%rdi)
    b3c2:	e9 cf 01 00 00       	jmp    b596 <fwp_str_lossy+0x3a6>
    b3c7:	0f 57 c0             	xorps  %xmm0,%xmm0
    b3ca:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    b3cf:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    b3d6:	00 00 
    b3d8:	31 ed                	xor    %ebp,%ebp
    b3da:	4c 8d 7c 24 10       	lea    0x10(%rsp),%r15
    b3df:	4c 8d 64 24 0f       	lea    0xf(%rsp),%r12
    b3e4:	eb 30                	jmp    b416 <fwp_str_lossy+0x226>
    b3e6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    b3ed:	00 00 00 
    b3f0:	88 44 24 0f          	mov    %al,0xf(%rsp)
    b3f4:	ba 01 00 00 00       	mov    $0x1,%edx
    b3f9:	4c 89 ff             	mov    %r15,%rdi
    b3fc:	4c 89 e6             	mov    %r12,%rsi
    b3ff:	e8 8c 1e 00 00       	call   d290 <buf_put>
    b404:	48 ff c5             	inc    %rbp
    b407:	49 89 ed             	mov    %rbp,%r13
    b40a:	4c 89 ed             	mov    %r13,%rbp
    b40d:	4d 39 f5             	cmp    %r14,%r13
    b410:	0f 83 37 01 00 00    	jae    b54d <fwp_str_lossy+0x35d>
    b416:	0f b6 04 2b          	movzbl (%rbx,%rbp,1),%eax
    b41a:	84 c0                	test   %al,%al
    b41c:	79 d2                	jns    b3f0 <fwp_str_lossy+0x200>
    b41e:	8d 48 20             	lea    0x20(%rax),%ecx
    b421:	80 f9 e1             	cmp    $0xe1,%cl
    b424:	77 34                	ja     b45a <fwp_str_lossy+0x26a>
    b426:	89 c2                	mov    %eax,%edx
    b428:	80 e2 f0             	and    $0xf0,%dl
    b42b:	80 fa e0             	cmp    $0xe0,%dl
    b42e:	0f 85 d5 00 00 00    	jne    b509 <fwp_str_lossy+0x319>
    b434:	3c e0                	cmp    $0xe0,%al
    b436:	40 0f 94 c6          	sete   %sil
    b43a:	40 c0 e6 05          	shl    $0x5,%sil
    b43e:	40 80 ce 80          	or     $0x80,%sil
    b442:	31 ff                	xor    %edi,%edi
    b444:	3c ed                	cmp    $0xed,%al
    b446:	40 0f 95 c7          	setne  %dil
    b44a:	c1 e7 05             	shl    $0x5,%edi
    b44d:	81 cf 9f 00 00 00    	or     $0x9f,%edi
    b453:	b8 02 00 00 00       	mov    $0x2,%eax
    b458:	eb 0d                	jmp    b467 <fwp_str_lossy+0x277>
    b45a:	bf bf 00 00 00       	mov    $0xbf,%edi
    b45f:	40 b6 80             	mov    $0x80,%sil
    b462:	b8 01 00 00 00       	mov    $0x1,%eax
    b467:	31 d2                	xor    %edx,%edx
    b469:	4c 8d 6d 01          	lea    0x1(%rbp),%r13
    b46d:	4d 39 f5             	cmp    %r14,%r13
    b470:	73 7e                	jae    b4f0 <fwp_str_lossy+0x300>
    b472:	46 0f b6 04 2b       	movzbl (%rbx,%r13,1),%r8d
    b477:	41 38 f0             	cmp    %sil,%r8b
    b47a:	72 74                	jb     b4f0 <fwp_str_lossy+0x300>
    b47c:	44 39 c7             	cmp    %r8d,%edi
    b47f:	72 6f                	jb     b4f0 <fwp_str_lossy+0x300>
    b481:	4c 8d 6d 02          	lea    0x2(%rbp),%r13
    b485:	be 01 00 00 00       	mov    $0x1,%esi
    b48a:	80 f9 e1             	cmp    $0xe1,%cl
    b48d:	77 44                	ja     b4d3 <fwp_str_lossy+0x2e3>
    b48f:	4d 39 f5             	cmp    %r14,%r13
    b492:	73 3f                	jae    b4d3 <fwp_str_lossy+0x2e3>
    b494:	42 0f b6 0c 2b       	movzbl (%rbx,%r13,1),%ecx
    b499:	80 e1 c0             	and    $0xc0,%cl
    b49c:	80 f9 80             	cmp    $0x80,%cl
    b49f:	75 32                	jne    b4d3 <fwp_str_lossy+0x2e3>
    b4a1:	4c 8d 6d 03          	lea    0x3(%rbp),%r13
    b4a5:	4d 39 f5             	cmp    %r14,%r13
    b4a8:	0f 93 c1             	setae  %cl
    b4ab:	80 f2 01             	xor    $0x1,%dl
    b4ae:	be 02 00 00 00       	mov    $0x2,%esi
    b4b3:	08 ca                	or     %cl,%dl
    b4b5:	75 1c                	jne    b4d3 <fwp_str_lossy+0x2e3>
    b4b7:	0f b6 4c 2b 03       	movzbl 0x3(%rbx,%rbp,1),%ecx
    b4bc:	80 e1 c0             	and    $0xc0,%cl
    b4bf:	31 f6                	xor    %esi,%esi
    b4c1:	80 f9 80             	cmp    $0x80,%cl
    b4c4:	0f 94 c1             	sete   %cl
    b4c7:	75 04                	jne    b4cd <fwp_str_lossy+0x2dd>
    b4c9:	4c 8d 6d 04          	lea    0x4(%rbp),%r13
    b4cd:	40 88 ce             	mov    %cl,%sil
    b4d0:	83 ce 02             	or     $0x2,%esi
    b4d3:	39 c6                	cmp    %eax,%esi
    b4d5:	75 19                	jne    b4f0 <fwp_str_lossy+0x300>
    b4d7:	48 8d 34 2b          	lea    (%rbx,%rbp,1),%rsi
    b4db:	4c 89 ea             	mov    %r13,%rdx
    b4de:	48 29 ea             	sub    %rbp,%rdx
    b4e1:	4c 89 ff             	mov    %r15,%rdi
    b4e4:	eb 19                	jmp    b4ff <fwp_str_lossy+0x30f>
    b4e6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    b4ed:	00 00 00 
    b4f0:	ba 03 00 00 00       	mov    $0x3,%edx
    b4f5:	4c 89 ff             	mov    %r15,%rdi
    b4f8:	48 8d 35 8c b1 00 00 	lea    0xb18c(%rip),%rsi        # 1668b <exec_in_fp0+0xe1b>
    b4ff:	e8 8c 1d 00 00       	call   d290 <buf_put>
    b504:	e9 01 ff ff ff       	jmp    b40a <fwp_str_lossy+0x21a>
    b509:	8d 50 10             	lea    0x10(%rax),%edx
    b50c:	80 fa 04             	cmp    $0x4,%dl
    b50f:	77 28                	ja     b539 <fwp_str_lossy+0x349>
    b511:	3c f0                	cmp    $0xf0,%al
    b513:	40 0f 94 c6          	sete   %sil
    b517:	bf 8f 00 00 00       	mov    $0x8f,%edi
    b51c:	3c f4                	cmp    $0xf4,%al
    b51e:	74 05                	je     b525 <fwp_str_lossy+0x335>
    b520:	bf bf 00 00 00       	mov    $0xbf,%edi
    b525:	40 c0 e6 04          	shl    $0x4,%sil
    b529:	40 80 ce 80          	or     $0x80,%sil
    b52d:	b8 03 00 00 00       	mov    $0x3,%eax
    b532:	b2 01                	mov    $0x1,%dl
    b534:	e9 30 ff ff ff       	jmp    b469 <fwp_str_lossy+0x279>
    b539:	ba 03 00 00 00       	mov    $0x3,%edx
    b53e:	4c 89 ff             	mov    %r15,%rdi
    b541:	48 8d 35 43 b1 00 00 	lea    0xb143(%rip),%rsi        # 1668b <exec_in_fp0+0xe1b>
    b548:	e9 b2 fe ff ff       	jmp    b3ff <fwp_str_lossy+0x20f>
    b54d:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    b552:	e8 29 1e 00 00       	call   d380 <buf_to_str>
    b557:	49 89 c7             	mov    %rax,%r15
    b55a:	eb 5c                	jmp    b5b8 <fwp_str_lossy+0x3c8>
    b55c:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    b563:	00 
    b564:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    b56b:	00 
    b56c:	4c 29 ff             	sub    %r15,%rdi
    b56f:	48 39 cf             	cmp    %rcx,%rdi
    b572:	73 12                	jae    b586 <fwp_str_lossy+0x396>
    b574:	48 89 d7             	mov    %rdx,%rdi
    b577:	be 01 00 00 00       	mov    $0x1,%esi
    b57c:	e8 bf cd ff ff       	call   8340 <fwp_gc_alloc_slow>
    b581:	49 89 c7             	mov    %rax,%r15
    b584:	eb 1a                	jmp    b5a0 <fwp_str_lossy+0x3b0>
    b586:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    b58a:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    b590:	4c 01 f9             	add    %r15,%rcx
    b593:	48 89 08             	mov    %rcx,(%rax)
    b596:	4c 89 ff             	mov    %r15,%rdi
    b599:	31 f6                	xor    %esi,%esi
    b59b:	e8 70 7c ff ff       	call   3210 <memset@plt>
    b5a0:	4d 89 37             	mov    %r14,(%r15)
    b5a3:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    b5a7:	48 89 de             	mov    %rbx,%rsi
    b5aa:	4c 89 f2             	mov    %r14,%rdx
    b5ad:	e8 7e 7d ff ff       	call   3330 <memcpy@plt>
    b5b2:	43 c6 44 37 08 00    	movb   $0x0,0x8(%r15,%r14,1)
    b5b8:	4c 89 f8             	mov    %r15,%rax
    b5bb:	48 83 c4 28          	add    $0x28,%rsp
    b5bf:	5b                   	pop    %rbx
    b5c0:	41 5c                	pop    %r12
    b5c2:	41 5d                	pop    %r13
    b5c4:	41 5e                	pop    %r14
    b5c6:	41 5f                	pop    %r15
    b5c8:	5d                   	pop    %rbp
    b5c9:	c3                   	ret
    b5ca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000b5d0 <fwp_alloc_leaf>:
    b5d0:	53                   	push   %rbx
    b5d1:	48 89 fa             	mov    %rdi,%rdx
    b5d4:	48 ff 05 cd 08 01 00 	incq   0x108cd(%rip)        # 1bea8 <measured_calls>
    b5db:	48 01 3d ce 08 01 00 	add    %rdi,0x108ce(%rip)        # 1beb0 <measured_bytes>
    b5e2:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    b5e9:	77 61                	ja     b64c <fwp_alloc_leaf+0x7c>
    b5eb:	48 8d 4a 0f          	lea    0xf(%rdx),%rcx
    b5ef:	48 c1 e9 04          	shr    $0x4,%rcx
    b5f3:	48 8d 05 8e ec 00 00 	lea    0xec8e(%rip),%rax        # 1a288 <fwp_gc>
    b5fa:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    b601:	00 
    b602:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    b609:	48 29 0d 78 ec 00 00 	sub    %rcx,0xec78(%rip)        # 1a288 <fwp_gc>
    b610:	78 3a                	js     b64c <fwp_alloc_leaf+0x7c>
    b612:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    b616:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    b61a:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    b621:	48 8b 1f             	mov    (%rdi),%rbx
    b624:	48 85 db             	test   %rbx,%rbx
    b627:	74 0b                	je     b634 <fwp_alloc_leaf+0x64>
    b629:	48 8b 03             	mov    (%rbx),%rax
    b62c:	48 f7 d0             	not    %rax
    b62f:	48 89 07             	mov    %rax,(%rdi)
    b632:	eb 36                	jmp    b66a <fwp_alloc_leaf+0x9a>
    b634:	48 8b 9c f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%rbx
    b63b:	00 
    b63c:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    b643:	00 
    b644:	48 29 df             	sub    %rbx,%rdi
    b647:	48 39 cf             	cmp    %rcx,%rdi
    b64a:	73 0e                	jae    b65a <fwp_alloc_leaf+0x8a>
    b64c:	48 89 d7             	mov    %rdx,%rdi
    b64f:	be 01 00 00 00       	mov    $0x1,%esi
    b654:	5b                   	pop    %rbx
    b655:	e9 e6 cc ff ff       	jmp    8340 <fwp_gc_alloc_slow>
    b65a:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    b65e:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    b664:	48 01 d9             	add    %rbx,%rcx
    b667:	48 89 08             	mov    %rcx,(%rax)
    b66a:	48 89 df             	mov    %rbx,%rdi
    b66d:	31 f6                	xor    %esi,%esi
    b66f:	e8 9c 7b ff ff       	call   3210 <memset@plt>
    b674:	48 89 d8             	mov    %rbx,%rax
    b677:	5b                   	pop    %rbx
    b678:	c3                   	ret
    b679:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000b680 <fwp_pipe_write>:
    b680:	55                   	push   %rbp
    b681:	41 57                	push   %r15
    b683:	41 56                	push   %r14
    b685:	41 55                	push   %r13
    b687:	41 54                	push   %r12
    b689:	53                   	push   %rbx
    b68a:	48 83 ec 48          	sub    $0x48,%rsp
    b68e:	48 89 f3             	mov    %rsi,%rbx
    b691:	49 89 fe             	mov    %rdi,%r14
    b694:	8b 05 86 08 02 00    	mov    0x20886(%rip),%eax        # 2bf20 <fwp_po_kind>
    b69a:	83 f8 01             	cmp    $0x1,%eax
    b69d:	0f 84 cc 02 00 00    	je     b96f <fwp_pipe_write+0x2ef>
    b6a3:	83 f8 02             	cmp    $0x2,%eax
    b6a6:	0f 85 4e 03 00 00    	jne    b9fa <fwp_pipe_write+0x37a>
    b6ac:	48 85 db             	test   %rbx,%rbx
    b6af:	0f 84 0d 04 00 00    	je     bac2 <fwp_pipe_write+0x442>
    b6b5:	f6 05 7c 08 03 00 01 	testb  $0x1,0x3087c(%rip)        # 3bf38 <fwp_po_gone>
    b6bc:	0f 85 00 04 00 00    	jne    bac2 <fwp_pipe_write+0x442>
    b6c2:	4c 8b 2d 67 08 03 00 	mov    0x30867(%rip),%r13        # 3bf30 <fwp_po_ring>
    b6c9:	49 8d 85 00 10 00 00 	lea    0x1000(%r13),%rax
    b6d0:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    b6d5:	49 8d 85 c0 00 00 00 	lea    0xc0(%r13),%rax
    b6dc:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    b6e1:	49 8d 85 00 01 00 00 	lea    0x100(%r13),%rax
    b6e8:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    b6ed:	0f 1f 00             	nopl   (%rax)
    b6f0:	49 8b 6d 40          	mov    0x40(%r13),%rbp
    b6f4:	4d 8b bd 80 00 00 00 	mov    0x80(%r13),%r15
    b6fb:	4d 8b 65 08          	mov    0x8(%r13),%r12
    b6ff:	49 29 ef             	sub    %rbp,%r15
    b702:	4d 01 e7             	add    %r12,%r15
    b705:	0f 84 b5 00 00 00    	je     b7c0 <fwp_pipe_write+0x140>
    b70b:	4c 39 fb             	cmp    %r15,%rbx
    b70e:	48 89 5c 24 38       	mov    %rbx,0x38(%rsp)
    b713:	4c 0f 42 fb          	cmovb  %rbx,%r15
    b717:	49 8d 7c 24 ff       	lea    -0x1(%r12),%rdi
    b71c:	48 21 ef             	and    %rbp,%rdi
    b71f:	49 29 fc             	sub    %rdi,%r12
    b722:	4d 39 e7             	cmp    %r12,%r15
    b725:	4d 0f 42 e7          	cmovb  %r15,%r12
    b729:	48 8b 5c 24 28       	mov    0x28(%rsp),%rbx
    b72e:	48 01 df             	add    %rbx,%rdi
    b731:	4c 89 f6             	mov    %r14,%rsi
    b734:	4c 89 e2             	mov    %r12,%rdx
    b737:	e8 f4 7b ff ff       	call   3330 <memcpy@plt>
    b73c:	4c 89 74 24 40       	mov    %r14,0x40(%rsp)
    b741:	4b 8d 34 26          	lea    (%r14,%r12,1),%rsi
    b745:	4c 89 fa             	mov    %r15,%rdx
    b748:	4c 29 e2             	sub    %r12,%rdx
    b74b:	48 89 df             	mov    %rbx,%rdi
    b74e:	e8 dd 7b ff ff       	call   3330 <memcpy@plt>
    b753:	4c 01 fd             	add    %r15,%rbp
    b756:	49 89 6d 40          	mov    %rbp,0x40(%r13)
    b75a:	0f ae f0             	mfence
    b75d:	41 8b 85 c4 00 00 00 	mov    0xc4(%r13),%eax
    b764:	85 c0                	test   %eax,%eax
    b766:	74 2b                	je     b793 <fwp_pipe_write+0x113>
    b768:	48 8b 74 24 20       	mov    0x20(%rsp),%rsi
    b76d:	f0 ff 06             	lock incl (%rsi)
    b770:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    b777:	bf ca 00 00 00       	mov    $0xca,%edi
    b77c:	ba 01 00 00 00       	mov    $0x1,%edx
    b781:	b9 ff ff ff 7f       	mov    $0x7fffffff,%ecx
    b786:	45 31 c0             	xor    %r8d,%r8d
    b789:	45 31 c9             	xor    %r9d,%r9d
    b78c:	31 c0                	xor    %eax,%eax
    b78e:	e8 6d 7b ff ff       	call   3300 <syscall@plt>
    b793:	4c 8b 74 24 40       	mov    0x40(%rsp),%r14
    b798:	4d 01 fe             	add    %r15,%r14
    b79b:	48 8b 5c 24 38       	mov    0x38(%rsp),%rbx
    b7a0:	4c 29 fb             	sub    %r15,%rbx
    b7a3:	48 85 db             	test   %rbx,%rbx
    b7a6:	0f 84 16 03 00 00    	je     bac2 <fwp_pipe_write+0x442>
    b7ac:	f6 05 85 07 03 00 01 	testb  $0x1,0x30785(%rip)        # 3bf38 <fwp_po_gone>
    b7b3:	0f 84 37 ff ff ff    	je     b6f0 <fwp_pipe_write+0x70>
    b7b9:	e9 04 03 00 00       	jmp    bac2 <fwp_pipe_write+0x442>
    b7be:	66 90                	xchg   %ax,%ax
    b7c0:	44 8b 25 1d 06 01 00 	mov    0x1061d(%rip),%r12d        # 1bde4 <fwp_po_sock>
    b7c7:	8b 0d 1b 06 01 00    	mov    0x1061b(%rip),%ecx        # 1bde8 <fwp_ring_spin>
    b7cd:	85 c9                	test   %ecx,%ecx
    b7cf:	78 09                	js     b7da <fwp_pipe_write+0x15a>
    b7d1:	85 c9                	test   %ecx,%ecx
    b7d3:	75 22                	jne    b7f7 <fwp_pipe_write+0x177>
    b7d5:	e9 96 00 00 00       	jmp    b870 <fwp_pipe_write+0x1f0>
    b7da:	bf 54 00 00 00       	mov    $0x54,%edi
    b7df:	e8 3c 7c ff ff       	call   3420 <sysconf@plt>
    b7e4:	31 c9                	xor    %ecx,%ecx
    b7e6:	48 83 f8 02          	cmp    $0x2,%rax
    b7ea:	0f 9d c1             	setge  %cl
    b7ed:	89 0d f5 05 01 00    	mov    %ecx,0x105f5(%rip)        # 1bde8 <fwp_ring_spin>
    b7f3:	85 c9                	test   %ecx,%ecx
    b7f5:	74 79                	je     b870 <fwp_pipe_write+0x1f0>
    b7f7:	49 8b 85 80 00 00 00 	mov    0x80(%r13),%rax
    b7fe:	49 2b 45 40          	sub    0x40(%r13),%rax
    b802:	49 03 45 08          	add    0x8(%r13),%rax
    b806:	75 9b                	jne    b7a3 <fwp_pipe_write+0x123>
    b808:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    b80e:	31 ed                	xor    %ebp,%ebp
    b810:	eb 26                	jmp    b838 <fwp_pipe_write+0x1b8>
    b812:	48 05 50 c3 00 00    	add    $0xc350,%rax
    b818:	48 89 c5             	mov    %rax,%rbp
    b81b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    b820:	41 ff c7             	inc    %r15d
    b823:	49 8b 85 80 00 00 00 	mov    0x80(%r13),%rax
    b82a:	49 2b 45 40          	sub    0x40(%r13),%rax
    b82e:	49 03 45 08          	add    0x8(%r13),%rax
    b832:	0f 85 6b ff ff ff    	jne    b7a3 <fwp_pipe_write+0x123>
    b838:	f3 90                	pause
    b83a:	41 f6 c7 3f          	test   $0x3f,%r15b
    b83e:	75 e0                	jne    b820 <fwp_pipe_write+0x1a0>
    b840:	e8 0b 7a ff ff       	call   3250 <sched_yield@plt>
    b845:	bf 01 00 00 00       	mov    $0x1,%edi
    b84a:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    b84f:	e8 dc 78 ff ff       	call   3130 <clock_gettime@plt>
    b854:	48 69 44 24 10 00 ca 	imul   $0x3b9aca00,0x10(%rsp),%rax
    b85b:	9a 3b 
    b85d:	48 03 44 24 18       	add    0x18(%rsp),%rax
    b862:	48 85 ed             	test   %rbp,%rbp
    b865:	74 ab                	je     b812 <fwp_pipe_write+0x192>
    b867:	48 39 e8             	cmp    %rbp,%rax
    b86a:	7e b4                	jle    b820 <fwp_pipe_write+0x1a0>
    b86c:	0f 1f 40 00          	nopl   0x0(%rax)
    b870:	41 8b 8d 00 01 00 00 	mov    0x100(%r13),%ecx
    b877:	b8 01 00 00 00       	mov    $0x1,%eax
    b87c:	41 87 85 04 01 00 00 	xchg   %eax,0x104(%r13)
    b883:	0f ae f0             	mfence
    b886:	49 8b 85 80 00 00 00 	mov    0x80(%r13),%rax
    b88d:	49 2b 45 40          	sub    0x40(%r13),%rax
    b891:	49 03 45 08          	add    0x8(%r13),%rax
    b895:	0f 85 c4 00 00 00    	jne    b95f <fwp_pipe_write+0x2df>
    b89b:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    b8a2:	00 00 
    b8a4:	48 c7 44 24 18 00 e1 	movq   $0x5f5e100,0x18(%rsp)
    b8ab:	f5 05 
    b8ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    b8b4:	bf ca 00 00 00       	mov    $0xca,%edi
    b8b9:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    b8be:	31 d2                	xor    %edx,%edx
    b8c0:	4c 8d 44 24 10       	lea    0x10(%rsp),%r8
    b8c5:	45 31 c9             	xor    %r9d,%r9d
    b8c8:	31 c0                	xor    %eax,%eax
    b8ca:	e8 31 7a ff ff       	call   3300 <syscall@plt>
    b8cf:	41 c7 85 04 01 00 00 	movl   $0x0,0x104(%r13)
    b8d6:	00 00 00 00 
    b8da:	49 8b 8d 80 00 00 00 	mov    0x80(%r13),%rcx
    b8e1:	49 2b 4d 40          	sub    0x40(%r13),%rcx
    b8e5:	49 03 4d 08          	add    0x8(%r13),%rcx
    b8e9:	0f 85 b4 fe ff ff    	jne    b7a3 <fwp_pipe_write+0x123>
    b8ef:	48 85 c0             	test   %rax,%rax
    b8f2:	0f 84 78 ff ff ff    	je     b870 <fwp_pipe_write+0x1f0>
    b8f8:	e8 83 77 ff ff       	call   3080 <__errno_location@plt>
    b8fd:	83 38 6e             	cmpl   $0x6e,(%rax)
    b900:	0f 85 6a ff ff ff    	jne    b870 <fwp_pipe_write+0x1f0>
    b906:	44 89 64 24 10       	mov    %r12d,0x10(%rsp)
    b90b:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%rsp)
    b912:	00 
    b913:	be 01 00 00 00       	mov    $0x1,%esi
    b918:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    b91d:	31 d2                	xor    %edx,%edx
    b91f:	e8 9c 7a ff ff       	call   33c0 <poll@plt>
    b924:	85 c0                	test   %eax,%eax
    b926:	0f 8e 44 ff ff ff    	jle    b870 <fwp_pipe_write+0x1f0>
    b92c:	f6 44 24 16 18       	testb  $0x18,0x16(%rsp)
    b931:	75 20                	jne    b953 <fwp_pipe_write+0x2d3>
    b933:	ba 01 00 00 00       	mov    $0x1,%edx
    b938:	44 89 e7             	mov    %r12d,%edi
    b93b:	48 8d 74 24 0f       	lea    0xf(%rsp),%rsi
    b940:	b9 42 00 00 00       	mov    $0x42,%ecx
    b945:	e8 16 77 ff ff       	call   3060 <recv@plt>
    b94a:	48 85 c0             	test   %rax,%rax
    b94d:	0f 85 1d ff ff ff    	jne    b870 <fwp_pipe_write+0x1f0>
    b953:	c6 05 de 05 03 00 01 	movb   $0x1,0x305de(%rip)        # 3bf38 <fwp_po_gone>
    b95a:	e9 44 fe ff ff       	jmp    b7a3 <fwp_pipe_write+0x123>
    b95f:	41 c7 85 04 01 00 00 	movl   $0x0,0x104(%r13)
    b966:	00 00 00 00 
    b96a:	e9 34 fe ff ff       	jmp    b7a3 <fwp_pipe_write+0x123>
    b96f:	4c 8b 3d b2 05 02 00 	mov    0x205b2(%rip),%r15        # 2bf28 <fwp_po_len>
    b976:	49 8d 04 1f          	lea    (%r15,%rbx,1),%rax
    b97a:	48 3d 01 00 01 00    	cmp    $0x10001,%rax
    b980:	0f 82 b1 00 00 00    	jb     ba37 <fwp_pipe_write+0x3b7>
    b986:	4d 85 ff             	test   %r15,%r15
    b989:	0f 84 9a 00 00 00    	je     ba29 <fwp_pipe_write+0x3a9>
    b98f:	80 3d a2 05 03 00 00 	cmpb   $0x0,0x305a2(%rip)        # 3bf38 <fwp_po_gone>
    b996:	0f 85 8d 00 00 00    	jne    ba29 <fwp_pipe_write+0x3a9>
    b99c:	8b 2d 42 04 01 00    	mov    0x10442(%rip),%ebp        # 1bde4 <fwp_po_sock>
    b9a2:	4c 8d 25 87 05 02 00 	lea    0x20587(%rip),%r12        # 2bf30 <fwp_po_buf>
    b9a9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    b9b0:	89 ef                	mov    %ebp,%edi
    b9b2:	4c 89 e6             	mov    %r12,%rsi
    b9b5:	4c 89 fa             	mov    %r15,%rdx
    b9b8:	b9 00 40 00 00       	mov    $0x4000,%ecx
    b9bd:	e8 de 77 ff ff       	call   31a0 <send@plt>
    b9c2:	48 85 c0             	test   %rax,%rax
    b9c5:	78 19                	js     b9e0 <fwp_pipe_write+0x360>
    b9c7:	74 59                	je     ba22 <fwp_pipe_write+0x3a2>
    b9c9:	49 01 c4             	add    %rax,%r12
    b9cc:	49 29 c7             	sub    %rax,%r15
    b9cf:	eb 19                	jmp    b9ea <fwp_pipe_write+0x36a>
    b9d1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b9d8:	0f 1f 84 00 00 00 00 
    b9df:	00 
    b9e0:	e8 9b 76 ff ff       	call   3080 <__errno_location@plt>
    b9e5:	83 38 04             	cmpl   $0x4,(%rax)
    b9e8:	75 38                	jne    ba22 <fwp_pipe_write+0x3a2>
    b9ea:	4d 85 ff             	test   %r15,%r15
    b9ed:	74 3a                	je     ba29 <fwp_pipe_write+0x3a9>
    b9ef:	f6 05 42 05 03 00 01 	testb  $0x1,0x30542(%rip)        # 3bf38 <fwp_po_gone>
    b9f6:	74 b8                	je     b9b0 <fwp_pipe_write+0x330>
    b9f8:	eb 2f                	jmp    ba29 <fwp_pipe_write+0x3a9>
    b9fa:	48 8b 05 af e5 00 00 	mov    0xe5af(%rip),%rax        # 19fb0 <stdout@GLIBC_2.2.5>
    ba01:	48 8b 08             	mov    (%rax),%rcx
    ba04:	be 01 00 00 00       	mov    $0x1,%esi
    ba09:	4c 89 f7             	mov    %r14,%rdi
    ba0c:	48 89 da             	mov    %rbx,%rdx
    ba0f:	48 83 c4 48          	add    $0x48,%rsp
    ba13:	5b                   	pop    %rbx
    ba14:	41 5c                	pop    %r12
    ba16:	41 5d                	pop    %r13
    ba18:	41 5e                	pop    %r14
    ba1a:	41 5f                	pop    %r15
    ba1c:	5d                   	pop    %rbp
    ba1d:	e9 5e 7a ff ff       	jmp    3480 <fwrite@plt>
    ba22:	c6 05 0f 05 03 00 01 	movb   $0x1,0x3050f(%rip)        # 3bf38 <fwp_po_gone>
    ba29:	48 c7 05 f4 04 02 00 	movq   $0x0,0x204f4(%rip)        # 2bf28 <fwp_po_len>
    ba30:	00 00 00 00 
    ba34:	45 31 ff             	xor    %r15d,%r15d
    ba37:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    ba3e:	72 5a                	jb     ba9a <fwp_pipe_write+0x41a>
    ba40:	80 3d f1 04 03 00 00 	cmpb   $0x0,0x304f1(%rip)        # 3bf38 <fwp_po_gone>
    ba47:	75 79                	jne    bac2 <fwp_pipe_write+0x442>
    ba49:	8b 2d 95 03 01 00    	mov    0x10395(%rip),%ebp        # 1bde4 <fwp_po_sock>
    ba4f:	90                   	nop
    ba50:	89 ef                	mov    %ebp,%edi
    ba52:	4c 89 f6             	mov    %r14,%rsi
    ba55:	48 89 da             	mov    %rbx,%rdx
    ba58:	b9 00 40 00 00       	mov    $0x4000,%ecx
    ba5d:	e8 3e 77 ff ff       	call   31a0 <send@plt>
    ba62:	48 85 c0             	test   %rax,%rax
    ba65:	78 19                	js     ba80 <fwp_pipe_write+0x400>
    ba67:	74 52                	je     babb <fwp_pipe_write+0x43b>
    ba69:	49 01 c6             	add    %rax,%r14
    ba6c:	48 29 c3             	sub    %rax,%rbx
    ba6f:	eb 19                	jmp    ba8a <fwp_pipe_write+0x40a>
    ba71:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ba78:	0f 1f 84 00 00 00 00 
    ba7f:	00 
    ba80:	e8 fb 75 ff ff       	call   3080 <__errno_location@plt>
    ba85:	83 38 04             	cmpl   $0x4,(%rax)
    ba88:	75 31                	jne    babb <fwp_pipe_write+0x43b>
    ba8a:	48 85 db             	test   %rbx,%rbx
    ba8d:	74 33                	je     bac2 <fwp_pipe_write+0x442>
    ba8f:	f6 05 a2 04 03 00 01 	testb  $0x1,0x304a2(%rip)        # 3bf38 <fwp_po_gone>
    ba96:	74 b8                	je     ba50 <fwp_pipe_write+0x3d0>
    ba98:	eb 28                	jmp    bac2 <fwp_pipe_write+0x442>
    ba9a:	48 8d 3d 8f 04 02 00 	lea    0x2048f(%rip),%rdi        # 2bf30 <fwp_po_buf>
    baa1:	4c 01 ff             	add    %r15,%rdi
    baa4:	4c 89 f6             	mov    %r14,%rsi
    baa7:	48 89 da             	mov    %rbx,%rdx
    baaa:	e8 81 78 ff ff       	call   3330 <memcpy@plt>
    baaf:	49 01 df             	add    %rbx,%r15
    bab2:	4c 89 3d 6f 04 02 00 	mov    %r15,0x2046f(%rip)        # 2bf28 <fwp_po_len>
    bab9:	eb 07                	jmp    bac2 <fwp_pipe_write+0x442>
    babb:	c6 05 76 04 03 00 01 	movb   $0x1,0x30476(%rip)        # 3bf38 <fwp_po_gone>
    bac2:	48 83 c4 48          	add    $0x48,%rsp
    bac6:	5b                   	pop    %rbx
    bac7:	41 5c                	pop    %r12
    bac9:	41 5d                	pop    %r13
    bacb:	41 5e                	pop    %r14
    bacd:	41 5f                	pop    %r15
    bacf:	5d                   	pop    %rbp
    bad0:	c3                   	ret
    bad1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    bad8:	0f 1f 84 00 00 00 00 
    badf:	00 

000000000000bae0 <fwp_pipe_flush>:
    bae0:	55                   	push   %rbp
    bae1:	41 56                	push   %r14
    bae3:	53                   	push   %rbx
    bae4:	8b 05 36 04 02 00    	mov    0x20436(%rip),%eax        # 2bf20 <fwp_po_kind>
    baea:	85 c0                	test   %eax,%eax
    baec:	74 7c                	je     bb6a <fwp_pipe_flush+0x8a>
    baee:	83 f8 01             	cmp    $0x1,%eax
    baf1:	0f 85 9d 00 00 00    	jne    bb94 <fwp_pipe_flush+0xb4>
    baf7:	48 8b 1d 2a 04 02 00 	mov    0x2042a(%rip),%rbx        # 2bf28 <fwp_po_len>
    bafe:	48 85 db             	test   %rbx,%rbx
    bb01:	0f 84 82 00 00 00    	je     bb89 <fwp_pipe_flush+0xa9>
    bb07:	80 3d 2a 04 03 00 00 	cmpb   $0x0,0x3042a(%rip)        # 3bf38 <fwp_po_gone>
    bb0e:	75 79                	jne    bb89 <fwp_pipe_flush+0xa9>
    bb10:	8b 2d ce 02 01 00    	mov    0x102ce(%rip),%ebp        # 1bde4 <fwp_po_sock>
    bb16:	4c 8d 35 13 04 02 00 	lea    0x20413(%rip),%r14        # 2bf30 <fwp_po_buf>
    bb1d:	0f 1f 00             	nopl   (%rax)
    bb20:	89 ef                	mov    %ebp,%edi
    bb22:	4c 89 f6             	mov    %r14,%rsi
    bb25:	48 89 da             	mov    %rbx,%rdx
    bb28:	b9 00 40 00 00       	mov    $0x4000,%ecx
    bb2d:	e8 6e 76 ff ff       	call   31a0 <send@plt>
    bb32:	48 85 c0             	test   %rax,%rax
    bb35:	78 19                	js     bb50 <fwp_pipe_flush+0x70>
    bb37:	74 49                	je     bb82 <fwp_pipe_flush+0xa2>
    bb39:	49 01 c6             	add    %rax,%r14
    bb3c:	48 29 c3             	sub    %rax,%rbx
    bb3f:	eb 19                	jmp    bb5a <fwp_pipe_flush+0x7a>
    bb41:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    bb48:	0f 1f 84 00 00 00 00 
    bb4f:	00 
    bb50:	e8 2b 75 ff ff       	call   3080 <__errno_location@plt>
    bb55:	83 38 04             	cmpl   $0x4,(%rax)
    bb58:	75 28                	jne    bb82 <fwp_pipe_flush+0xa2>
    bb5a:	48 85 db             	test   %rbx,%rbx
    bb5d:	74 2a                	je     bb89 <fwp_pipe_flush+0xa9>
    bb5f:	f6 05 d2 03 03 00 01 	testb  $0x1,0x303d2(%rip)        # 3bf38 <fwp_po_gone>
    bb66:	74 b8                	je     bb20 <fwp_pipe_flush+0x40>
    bb68:	eb 1f                	jmp    bb89 <fwp_pipe_flush+0xa9>
    bb6a:	48 8b 05 3f e4 00 00 	mov    0xe43f(%rip),%rax        # 19fb0 <stdout@GLIBC_2.2.5>
    bb71:	48 8b 38             	mov    (%rax),%rdi
    bb74:	e8 d7 77 ff ff       	call   3350 <fflush@plt>
    bb79:	5b                   	pop    %rbx
    bb7a:	41 5e                	pop    %r14
    bb7c:	5d                   	pop    %rbp
    bb7d:	e9 be 4f 00 00       	jmp    10b40 <fwp_pipe_poll>
    bb82:	c6 05 af 03 03 00 01 	movb   $0x1,0x303af(%rip)        # 3bf38 <fwp_po_gone>
    bb89:	48 c7 05 94 03 02 00 	movq   $0x0,0x20394(%rip)        # 2bf28 <fwp_po_len>
    bb90:	00 00 00 00 
    bb94:	5b                   	pop    %rbx
    bb95:	41 5e                	pop    %r14
    bb97:	5d                   	pop    %rbp
    bb98:	c3                   	ret
    bb99:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000bba0 <fwp_exec_call>:
    bba0:	41 57                	push   %r15
    bba2:	41 56                	push   %r14
    bba4:	41 55                	push   %r13
    bba6:	41 54                	push   %r12
    bba8:	53                   	push   %rbx
    bba9:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
    bbb0:	48 89 f3             	mov    %rsi,%rbx
    bbb3:	49 89 fe             	mov    %rdi,%r14
    bbb6:	48 8b 05 8b 03 03 00 	mov    0x3038b(%rip),%rax        # 3bf48 <fwp_handlers>
    bbbd:	48 89 84 24 e8 00 00 	mov    %rax,0xe8(%rsp)
    bbc4:	00 
    bbc5:	48 c7 84 24 00 01 00 	movq   $0x0,0x100(%rsp)
    bbcc:	00 00 00 00 00 
    bbd1:	48 8b 05 f0 02 01 00 	mov    0x102f0(%rip),%rax        # 1bec8 <fwp_cleanups>
    bbd8:	48 89 84 24 08 01 00 	mov    %rax,0x108(%rsp)
    bbdf:	00 
    bbe0:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
    bbe5:	48 89 3d 5c 03 03 00 	mov    %rdi,0x3035c(%rip)        # 3bf48 <fwp_handlers>
    bbec:	e8 bf 76 ff ff       	call   32b0 <_setjmp@plt>
    bbf1:	85 c0                	test   %eax,%eax
    bbf3:	0f 85 d1 00 00 00    	jne    bcca <fwp_exec_call+0x12a>
    bbf9:	48 ff 05 a8 02 01 00 	incq   0x102a8(%rip)        # 1bea8 <measured_calls>
    bc00:	48 83 05 a8 02 01 00 	addq   $0x8,0x102a8(%rip)        # 1beb0 <measured_bytes>
    bc07:	08 
    bc08:	48 8d 05 79 e6 00 00 	lea    0xe679(%rip),%rax        # 1a288 <fwp_gc>
    bc0f:	0f b6 0d 5b f2 00 00 	movzbl 0xf25b(%rip),%ecx        # 1ae71 <fwp_gc+0xbe9>
    bc16:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    bc1d:	48 29 15 64 e6 00 00 	sub    %rdx,0xe664(%rip)        # 1a288 <fwp_gc>
    bc24:	78 3a                	js     bc60 <fwp_exec_call+0xc0>
    bc26:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    bc2a:	48 8d 34 c8          	lea    (%rax,%rcx,8),%rsi
    bc2e:	48 81 c6 88 07 00 00 	add    $0x788,%rsi
    bc35:	4c 8b 3e             	mov    (%rsi),%r15
    bc38:	4d 85 ff             	test   %r15,%r15
    bc3b:	74 0b                	je     bc48 <fwp_exec_call+0xa8>
    bc3d:	49 8b 07             	mov    (%r15),%rax
    bc40:	48 f7 d0             	not    %rax
    bc43:	48 89 06             	mov    %rax,(%rsi)
    bc46:	eb 3d                	jmp    bc85 <fwp_exec_call+0xe5>
    bc48:	4c 8b bc c8 90 07 00 	mov    0x790(%rax,%rcx,8),%r15
    bc4f:	00 
    bc50:	48 8b b4 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%rsi
    bc57:	00 
    bc58:	4c 29 fe             	sub    %r15,%rsi
    bc5b:	48 39 d6             	cmp    %rdx,%rsi
    bc5e:	73 14                	jae    bc74 <fwp_exec_call+0xd4>
    bc60:	bf 08 00 00 00       	mov    $0x8,%edi
    bc65:	be 02 00 00 00       	mov    $0x2,%esi
    bc6a:	e8 d1 c6 ff ff       	call   8340 <fwp_gc_alloc_slow>
    bc6f:	48 89 c7             	mov    %rax,%rdi
    bc72:	eb 1e                	jmp    bc92 <fwp_exec_call+0xf2>
    bc74:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    bc78:	48 05 90 07 00 00    	add    $0x790,%rax
    bc7e:	49 8d 0c 17          	lea    (%r15,%rdx,1),%rcx
    bc82:	48 89 08             	mov    %rcx,(%rax)
    bc85:	4c 89 ff             	mov    %r15,%rdi
    bc88:	31 f6                	xor    %esi,%esi
    bc8a:	e8 81 75 ff ff       	call   3210 <memset@plt>
    bc8f:	4c 89 ff             	mov    %r15,%rdi
    bc92:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    bc99:	be 01 00 00 00       	mov    $0x1,%esi
    bc9e:	4c 89 f2             	mov    %r14,%rdx
    bca1:	e8 ba b7 ff ff       	call   7460 <fwp_apply>
    bca6:	48 8b 8c 24 e8 00 00 	mov    0xe8(%rsp),%rcx
    bcad:	00 
    bcae:	48 89 0d 93 02 03 00 	mov    %rcx,0x30293(%rip)        # 3bf48 <fwp_handlers>
    bcb5:	31 c9                	xor    %ecx,%ecx
    bcb7:	89 0b                	mov    %ecx,(%rbx)
    bcb9:	48 81 c4 10 01 00 00 	add    $0x110,%rsp
    bcc0:	5b                   	pop    %rbx
    bcc1:	41 5c                	pop    %r12
    bcc3:	41 5d                	pop    %r13
    bcc5:	41 5e                	pop    %r14
    bcc7:	41 5f                	pop    %r15
    bcc9:	c3                   	ret
    bcca:	48 8b 84 24 e8 00 00 	mov    0xe8(%rsp),%rax
    bcd1:	00 
    bcd2:	48 89 05 6f 02 03 00 	mov    %rax,0x3026f(%rip)        # 3bf48 <fwp_handlers>
    bcd9:	48 8b 3d 98 01 01 00 	mov    0x10198(%rip),%rdi        # 1be78 <fwp_prog_out>
    bce0:	48 85 ff             	test   %rdi,%rdi
    bce3:	74 05                	je     bcea <fwp_exec_call+0x14a>
    bce5:	e8 66 76 ff ff       	call   3350 <fflush@plt>
    bcea:	48 8b 05 bf e2 00 00 	mov    0xe2bf(%rip),%rax        # 19fb0 <stdout@GLIBC_2.2.5>
    bcf1:	48 8b 38             	mov    (%rax),%rdi
    bcf4:	e8 57 76 ff ff       	call   3350 <fflush@plt>
    bcf9:	4c 8b b4 24 f0 00 00 	mov    0xf0(%rsp),%r14
    bd00:	00 
    bd01:	4c 8b bc 24 f8 00 00 	mov    0xf8(%rsp),%r15
    bd08:	00 
    bd09:	e8 d2 fd ff ff       	call   bae0 <fwp_pipe_flush>
    bd0e:	4c 8b 2d c3 e2 00 00 	mov    0xe2c3(%rip),%r13        # 19fd8 <stderr@GLIBC_2.2.5>
    bd15:	49 8b 7d 00          	mov    0x0(%r13),%rdi
    bd19:	48 8d 35 51 aa 00 00 	lea    0xaa51(%rip),%rsi        # 16771 <exec_in_fp0+0xf01>
    bd20:	48 8d 15 c3 9c 00 00 	lea    0x9cc3(%rip),%rdx        # 159ea <exec_in_fp0+0x17a>
    bd27:	31 c0                	xor    %eax,%eax
    bd29:	e8 c2 75 ff ff       	call   32f0 <fprintf@plt>
    bd2e:	41 83 3f 10          	cmpl   $0x10,(%r15)
    bd32:	75 20                	jne    bd54 <fwp_exec_call+0x1b4>
    bd34:	49 8b 7f 08          	mov    0x8(%r15),%rdi
    bd38:	48 85 ff             	test   %rdi,%rdi
    bd3b:	74 17                	je     bd54 <fwp_exec_call+0x1b4>
    bd3d:	48 8d 35 32 aa 00 00 	lea    0xaa32(%rip),%rsi        # 16776 <exec_in_fp0+0xf06>
    bd44:	e8 87 75 ff ff       	call   32d0 <strcmp@plt>
    bd49:	85 c0                	test   %eax,%eax
    bd4b:	75 07                	jne    bd54 <fwp_exec_call+0x1b4>
    bd4d:	41 83 7f 10 02       	cmpl   $0x2,0x10(%r15)
    bd52:	74 6b                	je     bdbf <fwp_exec_call+0x21f>
    bd54:	4d 8b 65 00          	mov    0x0(%r13),%r12
    bd58:	0f 57 c0             	xorps  %xmm0,%xmm0
    bd5b:	0f 29 04 24          	movaps %xmm0,(%rsp)
    bd5f:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    bd66:	00 00 
    bd68:	48 89 e7             	mov    %rsp,%rdi
    bd6b:	4c 89 f6             	mov    %r14,%rsi
    bd6e:	4c 89 fa             	mov    %r15,%rdx
    bd71:	b9 01 00 00 00       	mov    $0x1,%ecx
    bd76:	e8 45 51 00 00       	call   10ec0 <fwp_write>
    bd7b:	48 8b 3c 24          	mov    (%rsp),%rdi
    bd7f:	48 85 ff             	test   %rdi,%rdi
    bd82:	75 23                	jne    bda7 <fwp_exec_call+0x207>
    bd84:	31 c0                	xor    %eax,%eax
    bd86:	89 c7                	mov    %eax,%edi
    bd88:	e8 c3 72 ff ff       	call   3050 <free@plt>
    bd8d:	49 8b 75 00          	mov    0x0(%r13),%rsi
    bd91:	bf 0a 00 00 00       	mov    $0xa,%edi
    bd96:	e8 a5 74 ff ff       	call   3240 <fputc@plt>
    bd9b:	b9 01 00 00 00       	mov    $0x1,%ecx
    bda0:	31 c0                	xor    %eax,%eax
    bda2:	e9 10 ff ff ff       	jmp    bcb7 <fwp_exec_call+0x117>
    bda7:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    bdac:	be 01 00 00 00       	mov    $0x1,%esi
    bdb1:	4c 89 e1             	mov    %r12,%rcx
    bdb4:	e8 c7 76 ff ff       	call   3480 <fwrite@plt>
    bdb9:	48 8b 3c 24          	mov    (%rsp),%rdi
    bdbd:	eb c9                	jmp    bd88 <fwp_exec_call+0x1e8>
    bdbf:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    bdc3:	48 8b 17             	mov    (%rdi),%rdx
    bdc6:	48 83 c7 08          	add    $0x8,%rdi
    bdca:	49 8b 4d 00          	mov    0x0(%r13),%rcx
    bdce:	be 01 00 00 00       	mov    $0x1,%esi
    bdd3:	e8 a8 76 ff ff       	call   3480 <fwrite@plt>
    bdd8:	eb b3                	jmp    bd8d <fwp_exec_call+0x1ed>
    bdda:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000bde0 <fwp_emit_result>:
    bde0:	41 56                	push   %r14
    bde2:	53                   	push   %rbx
    bde3:	48 83 ec 28          	sub    $0x28,%rsp
    bde7:	48 89 fe             	mov    %rdi,%rsi
    bdea:	83 3d 0f 01 02 00 00 	cmpl   $0x0,0x2010f(%rip)        # 2bf00 <fwp_exec_binary_out>
    bdf1:	0f 84 89 00 00 00    	je     be80 <fwp_emit_result+0xa0>
    bdf7:	0f 57 c0             	xorps  %xmm0,%xmm0
    bdfa:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    bdff:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    be06:	00 00 
    be08:	48 8d 15 71 ff 00 00 	lea    0xff71(%rip),%rdx        # 1bd80 <d2>
    be0f:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    be14:	e8 a7 72 00 00       	call   130c0 <fwp_encode>
    be19:	c6 44 24 0b 01       	movb   $0x1,0xb(%rsp)
    be1e:	8b 44 24 18          	mov    0x18(%rsp),%eax
    be22:	89 44 24 0c          	mov    %eax,0xc(%rsp)
    be26:	48 8d 7c 24 0b       	lea    0xb(%rsp),%rdi
    be2b:	be 05 00 00 00       	mov    $0x5,%esi
    be30:	e8 4b f8 ff ff       	call   b680 <fwp_pipe_write>
    be35:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    be3a:	48 85 f6             	test   %rsi,%rsi
    be3d:	74 0a                	je     be49 <fwp_emit_result+0x69>
    be3f:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    be44:	e8 37 f8 ff ff       	call   b680 <fwp_pipe_write>
    be49:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    be4e:	e8 fd 71 ff ff       	call   3050 <free@plt>
    be53:	83 3d 86 ff 00 00 00 	cmpl   $0x0,0xff86(%rip)        # 1bde0 <fwp_po_listen>
    be5a:	0f 88 a4 00 00 00    	js     bf04 <fwp_emit_result+0x124>
    be60:	8b 05 ea 00 03 00    	mov    0x300ea(%rip),%eax        # 3bf50 <fwp_po_frames>
    be66:	ff c0                	inc    %eax
    be68:	89 05 e2 00 03 00    	mov    %eax,0x300e2(%rip)        # 3bf50 <fwp_po_frames>
    be6e:	a8 3f                	test   $0x3f,%al
    be70:	0f 85 8e 00 00 00    	jne    bf04 <fwp_emit_result+0x124>
    be76:	e8 c5 4c 00 00       	call   10b40 <fwp_pipe_poll>
    be7b:	e9 84 00 00 00       	jmp    bf04 <fwp_emit_result+0x124>
    be80:	83 3d f9 fe 00 00 10 	cmpl   $0x10,0xfef9(%rip)        # 1bd80 <d2>
    be87:	75 13                	jne    be9c <fwp_emit_result+0xbc>
    be89:	83 3d 00 ff 00 00 00 	cmpl   $0x0,0xff00(%rip)        # 1bd90 <d2+0x10>
    be90:	75 0a                	jne    be9c <fwp_emit_result+0xbc>
    be92:	48 83 3d ee fe 00 00 	cmpq   $0x0,0xfeee(%rip)        # 1bd88 <d2+0x8>
    be99:	00 
    be9a:	74 68                	je     bf04 <fwp_emit_result+0x124>
    be9c:	4c 8b 35 0d e1 00 00 	mov    0xe10d(%rip),%r14        # 19fb0 <stdout@GLIBC_2.2.5>
    bea3:	49 8b 1e             	mov    (%r14),%rbx
    bea6:	0f 57 c0             	xorps  %xmm0,%xmm0
    bea9:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    beae:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    beb5:	00 00 
    beb7:	48 8d 15 c2 fe 00 00 	lea    0xfec2(%rip),%rdx        # 1bd80 <d2>
    bebe:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    bec3:	b9 01 00 00 00       	mov    $0x1,%ecx
    bec8:	e8 f3 4f 00 00       	call   10ec0 <fwp_write>
    becd:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    bed2:	48 85 ff             	test   %rdi,%rdi
    bed5:	74 19                	je     bef0 <fwp_emit_result+0x110>
    bed7:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
    bedc:	be 01 00 00 00       	mov    $0x1,%esi
    bee1:	48 89 d9             	mov    %rbx,%rcx
    bee4:	e8 97 75 ff ff       	call   3480 <fwrite@plt>
    bee9:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    beee:	eb 02                	jmp    bef2 <fwp_emit_result+0x112>
    bef0:	31 ff                	xor    %edi,%edi
    bef2:	e8 59 71 ff ff       	call   3050 <free@plt>
    bef7:	49 8b 36             	mov    (%r14),%rsi
    befa:	bf 0a 00 00 00       	mov    $0xa,%edi
    beff:	e8 3c 73 ff ff       	call   3240 <fputc@plt>
    bf04:	48 83 c4 28          	add    $0x28,%rsp
    bf08:	5b                   	pop    %rbx
    bf09:	41 5e                	pop    %r14
    bf0b:	c3                   	ret
    bf0c:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000bf10 <fwp_read_exact>:
    bf10:	55                   	push   %rbp
    bf11:	41 57                	push   %r15
    bf13:	41 56                	push   %r14
    bf15:	41 55                	push   %r13
    bf17:	41 54                	push   %r12
    bf19:	53                   	push   %rbx
    bf1a:	48 83 ec 48          	sub    $0x48,%rsp
    bf1e:	49 89 f7             	mov    %rsi,%r15
    bf21:	49 89 fe             	mov    %rdi,%r14
    bf24:	45 31 ed             	xor    %r13d,%r13d
    bf27:	48 85 f6             	test   %rsi,%rsi
    bf2a:	0f 84 b8 00 00 00    	je     bfe8 <fwp_read_exact+0xd8>
    bf30:	8b 05 d2 ff 01 00    	mov    0x1ffd2(%rip),%eax        # 2bf08 <fwp_in_npend>
    bf36:	8b 0d d0 ff 01 00    	mov    0x1ffd0(%rip),%ecx        # 2bf0c <fwp_in_ppos>
    bf3c:	39 c1                	cmp    %eax,%ecx
    bf3e:	0f 8d a4 00 00 00    	jge    bfe8 <fwp_read_exact+0xd8>
    bf44:	48 98                	cltq
    bf46:	48 63 f1             	movslq %ecx,%rsi
    bf49:	48 89 f2             	mov    %rsi,%rdx
    bf4c:	48 f7 d2             	not    %rdx
    bf4f:	48 01 c2             	add    %rax,%rdx
    bf52:	49 8d 4f ff          	lea    -0x1(%r15),%rcx
    bf56:	48 39 ca             	cmp    %rcx,%rdx
    bf59:	48 0f 43 d1          	cmovae %rcx,%rdx
    bf5d:	48 ff c2             	inc    %rdx
    bf60:	48 83 fa 20          	cmp    $0x20,%rdx
    bf64:	72 16                	jb     bf7c <fwp_read_exact+0x6c>
    bf66:	48 8d 3d 97 ff 01 00 	lea    0x1ff97(%rip),%rdi        # 2bf04 <fwp_in_pend>
    bf6d:	4d 89 f0             	mov    %r14,%r8
    bf70:	49 29 f0             	sub    %rsi,%r8
    bf73:	49 29 f8             	sub    %rdi,%r8
    bf76:	49 83 f8 20          	cmp    $0x20,%r8
    bf7a:	73 2e                	jae    bfaa <fwp_read_exact+0x9a>
    bf7c:	45 31 ed             	xor    %r13d,%r13d
    bf7f:	48 89 f1             	mov    %rsi,%rcx
    bf82:	48 8d 15 7b ff 01 00 	lea    0x1ff7b(%rip),%rdx        # 2bf04 <fwp_in_pend>
    bf89:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    bf90:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    bf94:	48 ff c1             	inc    %rcx
    bf97:	43 88 34 2e          	mov    %sil,(%r14,%r13,1)
    bf9b:	49 ff c5             	inc    %r13
    bf9e:	4d 39 fd             	cmp    %r15,%r13
    bfa1:	73 3f                	jae    bfe2 <fwp_read_exact+0xd2>
    bfa3:	48 39 c1             	cmp    %rax,%rcx
    bfa6:	7c e8                	jl     bf90 <fwp_read_exact+0x80>
    bfa8:	eb 38                	jmp    bfe2 <fwp_read_exact+0xd2>
    bfaa:	49 89 d5             	mov    %rdx,%r13
    bfad:	49 83 e5 e0          	and    $0xffffffffffffffe0,%r13
    bfb1:	4a 8d 0c 2e          	lea    (%rsi,%r13,1),%rcx
    bfb5:	48 01 fe             	add    %rdi,%rsi
    bfb8:	48 83 c6 10          	add    $0x10,%rsi
    bfbc:	31 ff                	xor    %edi,%edi
    bfbe:	66 90                	xchg   %ax,%ax
    bfc0:	0f 10 44 3e f0       	movups -0x10(%rsi,%rdi,1),%xmm0
    bfc5:	0f 10 0c 3e          	movups (%rsi,%rdi,1),%xmm1
    bfc9:	41 0f 11 04 3e       	movups %xmm0,(%r14,%rdi,1)
    bfce:	41 0f 11 4c 3e 10    	movups %xmm1,0x10(%r14,%rdi,1)
    bfd4:	48 83 c7 20          	add    $0x20,%rdi
    bfd8:	49 39 fd             	cmp    %rdi,%r13
    bfdb:	75 e3                	jne    bfc0 <fwp_read_exact+0xb0>
    bfdd:	4c 39 ea             	cmp    %r13,%rdx
    bfe0:	75 a0                	jne    bf82 <fwp_read_exact+0x72>
    bfe2:	89 0d 24 ff 01 00    	mov    %ecx,0x1ff24(%rip)        # 2bf0c <fwp_in_ppos>
    bfe8:	4c 89 74 24 28       	mov    %r14,0x28(%rsp)
    bfed:	4c 89 7c 24 38       	mov    %r15,0x38(%rsp)
    bff2:	eb 34                	jmp    c028 <fwp_read_exact+0x118>
    bff4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    bffb:	00 00 00 00 00 
    c000:	48 8b 05 b1 df 00 00 	mov    0xdfb1(%rip),%rax        # 19fb8 <stdin@GLIBC_2.2.5>
    c007:	48 8b 08             	mov    (%rax),%rcx
    c00a:	be 01 00 00 00       	mov    $0x1,%esi
    c00f:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    c014:	48 89 da             	mov    %rbx,%rdx
    c017:	e8 d4 70 ff ff       	call   30f0 <fread@plt>
    c01c:	49 01 c5             	add    %rax,%r13
    c01f:	48 85 c0             	test   %rax,%rax
    c022:	0f 84 db 03 00 00    	je     c403 <fwp_read_exact+0x4f3>
    c028:	4c 89 fb             	mov    %r15,%rbx
    c02b:	4c 29 eb             	sub    %r13,%rbx
    c02e:	0f 86 e0 03 00 00    	jbe    c414 <fwp_read_exact+0x504>
    c034:	4b 8d 04 2e          	lea    (%r14,%r13,1),%rax
    c038:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    c03d:	8b 05 11 ff 02 00    	mov    0x2ff11(%rip),%eax        # 3bf54 <fwp_pi_kind>
    c043:	83 f8 01             	cmp    $0x1,%eax
    c046:	0f 84 64 02 00 00    	je     c2b0 <fwp_read_exact+0x3a0>
    c04c:	83 f8 02             	cmp    $0x2,%eax
    c04f:	75 af                	jne    c000 <fwp_read_exact+0xf0>
    c051:	4c 8b 3d 00 ff 02 00 	mov    0x2ff00(%rip),%r15        # 3bf58 <fwp_pi_ring>
    c058:	4d 8b 77 40          	mov    0x40(%r15),%r14
    c05c:	49 8b 87 80 00 00 00 	mov    0x80(%r15),%rax
    c063:	49 39 c6             	cmp    %rax,%r14
    c066:	0f 85 94 02 00 00    	jne    c300 <fwp_read_exact+0x3f0>
    c06c:	49 8d 87 c0 00 00 00 	lea    0xc0(%r15),%rax
    c073:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    c078:	eb 25                	jmp    c09f <fwp_read_exact+0x18f>
    c07a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    c080:	41 c7 87 c4 00 00 00 	movl   $0x0,0xc4(%r15)
    c087:	00 00 00 00 
    c08b:	4d 8b 77 40          	mov    0x40(%r15),%r14
    c08f:	49 8b 87 80 00 00 00 	mov    0x80(%r15),%rax
    c096:	49 39 c6             	cmp    %rax,%r14
    c099:	0f 85 61 02 00 00    	jne    c300 <fwp_read_exact+0x3f0>
    c09f:	41 8b 87 40 01 00 00 	mov    0x140(%r15),%eax
    c0a6:	85 c0                	test   %eax,%eax
    c0a8:	74 11                	je     c0bb <fwp_read_exact+0x1ab>
    c0aa:	49 8b 47 40          	mov    0x40(%r15),%rax
    c0ae:	49 3b 87 80 00 00 00 	cmp    0x80(%r15),%rax
    c0b5:	0f 84 48 03 00 00    	je     c403 <fwp_read_exact+0x4f3>
    c0bb:	44 8b 25 2a fd 00 00 	mov    0xfd2a(%rip),%r12d        # 1bdec <fwp_pi_sock>
    c0c2:	8b 0d 20 fd 00 00    	mov    0xfd20(%rip),%ecx        # 1bde8 <fwp_ring_spin>
    c0c8:	85 c9                	test   %ecx,%ecx
    c0ca:	78 14                	js     c0e0 <fwp_read_exact+0x1d0>
    c0cc:	85 c9                	test   %ecx,%ecx
    c0ce:	75 31                	jne    c101 <fwp_read_exact+0x1f1>
    c0d0:	e9 3b 01 00 00       	jmp    c210 <fwp_read_exact+0x300>
    c0d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    c0dc:	00 00 00 00 
    c0e0:	bf 54 00 00 00       	mov    $0x54,%edi
    c0e5:	e8 36 73 ff ff       	call   3420 <sysconf@plt>
    c0ea:	31 c9                	xor    %ecx,%ecx
    c0ec:	48 83 f8 02          	cmp    $0x2,%rax
    c0f0:	0f 9d c1             	setge  %cl
    c0f3:	89 0d ef fc 00 00    	mov    %ecx,0xfcef(%rip)        # 1bde8 <fwp_ring_spin>
    c0f9:	85 c9                	test   %ecx,%ecx
    c0fb:	0f 84 0f 01 00 00    	je     c210 <fwp_read_exact+0x300>
    c101:	49 8b 47 40          	mov    0x40(%r15),%rax
    c105:	49 3b 87 80 00 00 00 	cmp    0x80(%r15),%rax
    c10c:	0f 85 79 ff ff ff    	jne    c08b <fwp_read_exact+0x17b>
    c112:	41 8b 87 40 01 00 00 	mov    0x140(%r15),%eax
    c119:	85 c0                	test   %eax,%eax
    c11b:	0f 85 6a ff ff ff    	jne    c08b <fwp_read_exact+0x17b>
    c121:	bd 01 00 00 00       	mov    $0x1,%ebp
    c126:	45 31 f6             	xor    %r14d,%r14d
    c129:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    c130:	f3 90                	pause
    c132:	40 f6 c5 3f          	test   $0x3f,%bpl
    c136:	75 48                	jne    c180 <fwp_read_exact+0x270>
    c138:	e8 13 71 ff ff       	call   3250 <sched_yield@plt>
    c13d:	bf 01 00 00 00       	mov    $0x1,%edi
    c142:	48 8d 74 24 18       	lea    0x18(%rsp),%rsi
    c147:	e8 e4 6f ff ff       	call   3130 <clock_gettime@plt>
    c14c:	48 69 44 24 18 00 ca 	imul   $0x3b9aca00,0x18(%rsp),%rax
    c153:	9a 3b 
    c155:	48 03 44 24 20       	add    0x20(%rsp),%rax
    c15a:	4d 85 f6             	test   %r14,%r14
    c15d:	74 0a                	je     c169 <fwp_read_exact+0x259>
    c15f:	4c 39 f0             	cmp    %r14,%rax
    c162:	7e 1c                	jle    c180 <fwp_read_exact+0x270>
    c164:	e9 a7 00 00 00       	jmp    c210 <fwp_read_exact+0x300>
    c169:	48 05 50 c3 00 00    	add    $0xc350,%rax
    c16f:	49 89 c6             	mov    %rax,%r14
    c172:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c179:	1f 84 00 00 00 00 00 
    c180:	49 8b 47 40          	mov    0x40(%r15),%rax
    c184:	49 3b 87 80 00 00 00 	cmp    0x80(%r15),%rax
    c18b:	0f 85 fa fe ff ff    	jne    c08b <fwp_read_exact+0x17b>
    c191:	ff c5                	inc    %ebp
    c193:	41 8b 87 40 01 00 00 	mov    0x140(%r15),%eax
    c19a:	85 c0                	test   %eax,%eax
    c19c:	74 92                	je     c130 <fwp_read_exact+0x220>
    c19e:	e9 e8 fe ff ff       	jmp    c08b <fwp_read_exact+0x17b>
    c1a3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c1aa:	84 00 00 00 00 00 
    c1b0:	48 85 c0             	test   %rax,%rax
    c1b3:	74 5b                	je     c210 <fwp_read_exact+0x300>
    c1b5:	e8 c6 6e ff ff       	call   3080 <__errno_location@plt>
    c1ba:	83 38 6e             	cmpl   $0x6e,(%rax)
    c1bd:	75 51                	jne    c210 <fwp_read_exact+0x300>
    c1bf:	44 89 64 24 18       	mov    %r12d,0x18(%rsp)
    c1c4:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%rsp)
    c1cb:	00 
    c1cc:	be 01 00 00 00       	mov    $0x1,%esi
    c1d1:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    c1d6:	31 d2                	xor    %edx,%edx
    c1d8:	e8 e3 71 ff ff       	call   33c0 <poll@plt>
    c1dd:	85 c0                	test   %eax,%eax
    c1df:	7e 2f                	jle    c210 <fwp_read_exact+0x300>
    c1e1:	f6 44 24 1e 18       	testb  $0x18,0x1e(%rsp)
    c1e6:	0f 85 17 02 00 00    	jne    c403 <fwp_read_exact+0x4f3>
    c1ec:	ba 01 00 00 00       	mov    $0x1,%edx
    c1f1:	44 89 e7             	mov    %r12d,%edi
    c1f4:	48 8d 74 24 17       	lea    0x17(%rsp),%rsi
    c1f9:	b9 42 00 00 00       	mov    $0x42,%ecx
    c1fe:	e8 5d 6e ff ff       	call   3060 <recv@plt>
    c203:	48 85 c0             	test   %rax,%rax
    c206:	0f 84 f7 01 00 00    	je     c403 <fwp_read_exact+0x4f3>
    c20c:	0f 1f 40 00          	nopl   0x0(%rax)
    c210:	41 8b 8f c0 00 00 00 	mov    0xc0(%r15),%ecx
    c217:	b8 01 00 00 00       	mov    $0x1,%eax
    c21c:	41 87 87 c4 00 00 00 	xchg   %eax,0xc4(%r15)
    c223:	0f ae f0             	mfence
    c226:	49 8b 47 40          	mov    0x40(%r15),%rax
    c22a:	49 3b 87 80 00 00 00 	cmp    0x80(%r15),%rax
    c231:	0f 85 49 fe ff ff    	jne    c080 <fwp_read_exact+0x170>
    c237:	41 8b 87 40 01 00 00 	mov    0x140(%r15),%eax
    c23e:	85 c0                	test   %eax,%eax
    c240:	0f 85 3a fe ff ff    	jne    c080 <fwp_read_exact+0x170>
    c246:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
    c24d:	00 00 
    c24f:	48 c7 44 24 20 00 e1 	movq   $0x5f5e100,0x20(%rsp)
    c256:	f5 05 
    c258:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    c25f:	bf ca 00 00 00       	mov    $0xca,%edi
    c264:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
    c269:	31 d2                	xor    %edx,%edx
    c26b:	4c 8d 44 24 18       	lea    0x18(%rsp),%r8
    c270:	45 31 c9             	xor    %r9d,%r9d
    c273:	31 c0                	xor    %eax,%eax
    c275:	e8 86 70 ff ff       	call   3300 <syscall@plt>
    c27a:	41 c7 87 c4 00 00 00 	movl   $0x0,0xc4(%r15)
    c281:	00 00 00 00 
    c285:	49 8b 4f 40          	mov    0x40(%r15),%rcx
    c289:	49 3b 8f 80 00 00 00 	cmp    0x80(%r15),%rcx
    c290:	0f 85 f5 fd ff ff    	jne    c08b <fwp_read_exact+0x17b>
    c296:	41 8b 8f 40 01 00 00 	mov    0x140(%r15),%ecx
    c29d:	85 c9                	test   %ecx,%ecx
    c29f:	0f 84 0b ff ff ff    	je     c1b0 <fwp_read_exact+0x2a0>
    c2a5:	e9 e1 fd ff ff       	jmp    c08b <fwp_read_exact+0x17b>
    c2aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    c2b0:	4c 8b 35 a9 fc 02 00 	mov    0x2fca9(%rip),%r14        # 3bf60 <fwp_pi_pos>
    c2b7:	48 8b 05 aa fc 02 00 	mov    0x2fcaa(%rip),%rax        # 3bf68 <fwp_pi_len>
    c2be:	49 39 c6             	cmp    %rax,%r14
    c2c1:	0f 85 00 01 00 00    	jne    c3c7 <fwp_read_exact+0x4b7>
    c2c7:	4c 8d 35 a2 fc 02 00 	lea    0x2fca2(%rip),%r14        # 3bf70 <fwp_pi_buf>
    c2ce:	66 90                	xchg   %ax,%ax
    c2d0:	8b 3d 16 fb 00 00    	mov    0xfb16(%rip),%edi        # 1bdec <fwp_pi_sock>
    c2d6:	ba 00 00 01 00       	mov    $0x10000,%edx
    c2db:	4c 89 f6             	mov    %r14,%rsi
    c2de:	31 c9                	xor    %ecx,%ecx
    c2e0:	e8 7b 6d ff ff       	call   3060 <recv@plt>
    c2e5:	48 85 c0             	test   %rax,%rax
    c2e8:	0f 89 cd 00 00 00    	jns    c3bb <fwp_read_exact+0x4ab>
    c2ee:	e8 8d 6d ff ff       	call   3080 <__errno_location@plt>
    c2f3:	83 38 04             	cmpl   $0x4,(%rax)
    c2f6:	74 d8                	je     c2d0 <fwp_read_exact+0x3c0>
    c2f8:	e9 06 01 00 00       	jmp    c403 <fwp_read_exact+0x4f3>
    c2fd:	0f 1f 00             	nopl   (%rax)
    c300:	49 29 c6             	sub    %rax,%r14
    c303:	49 39 de             	cmp    %rbx,%r14
    c306:	4c 0f 43 f3          	cmovae %rbx,%r14
    c30a:	49 8b 5f 08          	mov    0x8(%r15),%rbx
    c30e:	48 8d 4b ff          	lea    -0x1(%rbx),%rcx
    c312:	48 21 c1             	and    %rax,%rcx
    c315:	48 29 cb             	sub    %rcx,%rbx
    c318:	49 39 de             	cmp    %rbx,%r14
    c31b:	49 0f 42 de          	cmovb  %r14,%rbx
    c31f:	4d 8d a7 00 10 00 00 	lea    0x1000(%r15),%r12
    c326:	49 8d 34 0f          	lea    (%r15,%rcx,1),%rsi
    c32a:	48 81 c6 00 10 00 00 	add    $0x1000,%rsi
    c331:	48 8b 6c 24 30       	mov    0x30(%rsp),%rbp
    c336:	48 89 ef             	mov    %rbp,%rdi
    c339:	48 89 da             	mov    %rbx,%rdx
    c33c:	e8 ef 6f ff ff       	call   3330 <memcpy@plt>
    c341:	48 01 dd             	add    %rbx,%rbp
    c344:	4c 89 f2             	mov    %r14,%rdx
    c347:	48 29 da             	sub    %rbx,%rdx
    c34a:	48 89 ef             	mov    %rbp,%rdi
    c34d:	4c 89 e6             	mov    %r12,%rsi
    c350:	e8 db 6f ff ff       	call   3330 <memcpy@plt>
    c355:	49 8b 8f 80 00 00 00 	mov    0x80(%r15),%rcx
    c35c:	4c 01 f1             	add    %r14,%rcx
    c35f:	49 89 8f 80 00 00 00 	mov    %rcx,0x80(%r15)
    c366:	0f ae f0             	mfence
    c369:	41 8b 8f 04 01 00 00 	mov    0x104(%r15),%ecx
    c370:	85 c9                	test   %ecx,%ecx
    c372:	74 35                	je     c3a9 <fwp_read_exact+0x499>
    c374:	f0 41 ff 87 00 01 00 	lock incl 0x100(%r15)
    c37b:	00 
    c37c:	49 81 c7 00 01 00 00 	add    $0x100,%r15
    c383:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    c38a:	bf ca 00 00 00       	mov    $0xca,%edi
    c38f:	4c 89 fe             	mov    %r15,%rsi
    c392:	ba 01 00 00 00       	mov    $0x1,%edx
    c397:	b9 ff ff ff 7f       	mov    $0x7fffffff,%ecx
    c39c:	45 31 c0             	xor    %r8d,%r8d
    c39f:	45 31 c9             	xor    %r9d,%r9d
    c3a2:	31 c0                	xor    %eax,%eax
    c3a4:	e8 57 6f ff ff       	call   3300 <syscall@plt>
    c3a9:	4c 89 f0             	mov    %r14,%rax
    c3ac:	4c 8b 7c 24 38       	mov    0x38(%rsp),%r15
    c3b1:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    c3b6:	e9 61 fc ff ff       	jmp    c01c <fwp_read_exact+0x10c>
    c3bb:	74 46                	je     c403 <fwp_read_exact+0x4f3>
    c3bd:	48 89 05 a4 fb 02 00 	mov    %rax,0x2fba4(%rip)        # 3bf68 <fwp_pi_len>
    c3c4:	45 31 f6             	xor    %r14d,%r14d
    c3c7:	4c 29 f0             	sub    %r14,%rax
    c3ca:	48 39 d8             	cmp    %rbx,%rax
    c3cd:	48 0f 43 c3          	cmovae %rbx,%rax
    c3d1:	48 8d 0d 98 fb 02 00 	lea    0x2fb98(%rip),%rcx        # 3bf70 <fwp_pi_buf>
    c3d8:	4a 8d 34 31          	lea    (%rcx,%r14,1),%rsi
    c3dc:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    c3e1:	48 89 c2             	mov    %rax,%rdx
    c3e4:	48 89 c3             	mov    %rax,%rbx
    c3e7:	e8 44 6f ff ff       	call   3330 <memcpy@plt>
    c3ec:	48 89 d8             	mov    %rbx,%rax
    c3ef:	49 01 de             	add    %rbx,%r14
    c3f2:	4c 89 35 67 fb 02 00 	mov    %r14,0x2fb67(%rip)        # 3bf60 <fwp_pi_pos>
    c3f9:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    c3fe:	e9 19 fc ff ff       	jmp    c01c <fwp_read_exact+0x10c>
    c403:	31 c0                	xor    %eax,%eax
    c405:	48 83 c4 48          	add    $0x48,%rsp
    c409:	5b                   	pop    %rbx
    c40a:	41 5c                	pop    %r12
    c40c:	41 5d                	pop    %r13
    c40e:	41 5e                	pop    %r14
    c410:	41 5f                	pop    %r15
    c412:	5d                   	pop    %rbp
    c413:	c3                   	ret
    c414:	b8 01 00 00 00       	mov    $0x1,%eax
    c419:	eb ea                	jmp    c405 <fwp_read_exact+0x4f5>
    c41b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000c420 <fwp_stdin_name_len>:
    c420:	41 57                	push   %r15
    c422:	41 56                	push   %r14
    c424:	53                   	push   %rbx
    c425:	48 83 ec 10          	sub    $0x10,%rsp
    c429:	48 89 fb             	mov    %rdi,%rbx
    c42c:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    c433:	49 c7 c6 f9 ff ff ff 	mov    $0xfffffffffffffff9,%r14
    c43a:	4c 8d 7c 24 0f       	lea    0xf(%rsp),%r15
    c43f:	90                   	nop
    c440:	be 01 00 00 00       	mov    $0x1,%esi
    c445:	4c 89 ff             	mov    %r15,%rdi
    c448:	e8 c3 fa ff ff       	call   bf10 <fwp_read_exact>
    c44d:	85 c0                	test   %eax,%eax
    c44f:	74 38                	je     c489 <fwp_stdin_name_len+0x69>
    c451:	0f b6 44 24 0f       	movzbl 0xf(%rsp),%eax
    c456:	49 83 fe 38          	cmp    $0x38,%r14
    c45a:	75 07                	jne    c463 <fwp_stdin_name_len+0x43>
    c45c:	89 c1                	mov    %eax,%ecx
    c45e:	80 e1 7e             	and    $0x7e,%cl
    c461:	75 1f                	jne    c482 <fwp_stdin_name_len+0x62>
    c463:	49 83 c6 07          	add    $0x7,%r14
    c467:	89 c2                	mov    %eax,%edx
    c469:	83 e2 7f             	and    $0x7f,%edx
    c46c:	44 89 f1             	mov    %r14d,%ecx
    c46f:	48 d3 e2             	shl    %cl,%rdx
    c472:	48 0b 13             	or     (%rbx),%rdx
    c475:	48 89 13             	mov    %rdx,(%rbx)
    c478:	84 c0                	test   %al,%al
    c47a:	79 11                	jns    c48d <fwp_stdin_name_len+0x6d>
    c47c:	49 83 fe 38          	cmp    $0x38,%r14
    c480:	76 be                	jbe    c440 <fwp_stdin_name_len+0x20>
    c482:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    c487:	eb 13                	jmp    c49c <fwp_stdin_name_len+0x7c>
    c489:	31 c0                	xor    %eax,%eax
    c48b:	eb 0f                	jmp    c49c <fwp_stdin_name_len+0x7c>
    c48d:	31 c0                	xor    %eax,%eax
    c48f:	48 81 fa 01 00 10 00 	cmp    $0x100001,%rdx
    c496:	83 d0 ff             	adc    $0xffffffff,%eax
    c499:	83 c8 01             	or     $0x1,%eax
    c49c:	48 83 c4 10          	add    $0x10,%rsp
    c4a0:	5b                   	pop    %rbx
    c4a1:	41 5e                	pop    %r14
    c4a3:	41 5f                	pop    %r15
    c4a5:	c3                   	ret
    c4a6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    c4ad:	00 00 00 

000000000000c4b0 <fwp_pipe_in_offer>:
    c4b0:	55                   	push   %rbp
    c4b1:	41 56                	push   %r14
    c4b3:	53                   	push   %rbx
    c4b4:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
    c4bb:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
    c4c2:	00 
    c4c3:	31 ff                	xor    %edi,%edi
    c4c5:	e8 f6 6f ff ff       	call   34c0 <fstat@plt>
    c4ca:	85 c0                	test   %eax,%eax
    c4cc:	0f 85 29 01 00 00    	jne    c5fb <fwp_pipe_in_offer+0x14b>
    c4d2:	b8 00 f0 00 00       	mov    $0xf000,%eax
    c4d7:	23 84 24 98 00 00 00 	and    0x98(%rsp),%eax
    c4de:	3d 00 10 00 00       	cmp    $0x1000,%eax
    c4e3:	0f 85 12 01 00 00    	jne    c5fb <fwp_pipe_in_offer+0x14b>
    c4e9:	bf 01 00 00 00       	mov    $0x1,%edi
    c4ee:	be 01 00 08 00       	mov    $0x80001,%esi
    c4f3:	31 d2                	xor    %edx,%edx
    c4f5:	e8 f6 6f ff ff       	call   34f0 <socket@plt>
    c4fa:	85 c0                	test   %eax,%eax
    c4fc:	0f 88 f9 00 00 00    	js     c5fb <fwp_pipe_in_offer+0x14b>
    c502:	89 c3                	mov    %eax,%ebx
    c504:	0f 57 c0             	xorps  %xmm0,%xmm0
    c507:	0f 11 44 24 70       	movups %xmm0,0x70(%rsp)
    c50c:	0f 11 44 24 64       	movups %xmm0,0x64(%rsp)
    c511:	0f 11 44 24 54       	movups %xmm0,0x54(%rsp)
    c516:	0f 11 44 24 44       	movups %xmm0,0x44(%rsp)
    c51b:	0f 11 44 24 34       	movups %xmm0,0x34(%rsp)
    c520:	0f 11 44 24 24       	movups %xmm0,0x24(%rsp)
    c525:	0f 11 44 24 14       	movups %xmm0,0x14(%rsp)
    c52a:	66 c7 44 24 12 01 00 	movw   $0x1,0x12(%rsp)
    c531:	48 8d 7c 24 15       	lea    0x15(%rsp),%rdi
    c536:	48 8b 8c 24 80 00 00 	mov    0x80(%rsp),%rcx
    c53d:	00 
    c53e:	4c 8b 84 24 88 00 00 	mov    0x88(%rsp),%r8
    c545:	00 
    c546:	48 8d 15 eb a1 00 00 	lea    0xa1eb(%rip),%rdx        # 16738 <exec_in_fp0+0xec8>
    c54d:	be 6b 00 00 00       	mov    $0x6b,%esi
    c552:	31 c0                	xor    %eax,%eax
    c554:	e8 77 6c ff ff       	call   31d0 <snprintf@plt>
    c559:	89 c5                	mov    %eax,%ebp
    c55b:	83 c5 03             	add    $0x3,%ebp
    c55e:	48 8d 3d bf a1 00 00 	lea    0xa1bf(%rip),%rdi        # 16724 <exec_in_fp0+0xeb4>
    c565:	e8 c6 6a ff ff       	call   3030 <getenv@plt>
    c56a:	48 85 c0             	test   %rax,%rax
    c56d:	74 36                	je     c5a5 <fwp_pipe_in_offer+0xf5>
    c56f:	49 89 c6             	mov    %rax,%r14
    c572:	48 8d 35 b9 a1 00 00 	lea    0xa1b9(%rip),%rsi        # 16732 <exec_in_fp0+0xec2>
    c579:	48 89 c7             	mov    %rax,%rdi
    c57c:	e8 4f 6d ff ff       	call   32d0 <strcmp@plt>
    c581:	c7 44 24 0c 46 57 50 	movl   $0x54505746,0xc(%rsp)
    c588:	54 
    c589:	85 c0                	test   %eax,%eax
    c58b:	74 27                	je     c5b4 <fwp_pipe_in_offer+0x104>
    c58d:	48 8d 35 63 a2 00 00 	lea    0xa263(%rip),%rsi        # 167f7 <exec_in_fp0+0xf87>
    c594:	4c 89 f7             	mov    %r14,%rdi
    c597:	e8 34 6d ff ff       	call   32d0 <strcmp@plt>
    c59c:	83 f8 01             	cmp    $0x1,%eax
    c59f:	b0 02                	mov    $0x2,%al
    c5a1:	1c 00                	sbb    $0x0,%al
    c5a3:	eb 0a                	jmp    c5af <fwp_pipe_in_offer+0xff>
    c5a5:	c7 44 24 0c 46 57 50 	movl   $0x54505746,0xc(%rsp)
    c5ac:	54 
    c5ad:	b0 02                	mov    $0x2,%al
    c5af:	45 31 f6             	xor    %r14d,%r14d
    c5b2:	eb 05                	jmp    c5b9 <fwp_pipe_in_offer+0x109>
    c5b4:	31 c0                	xor    %eax,%eax
    c5b6:	41 b6 01             	mov    $0x1,%r14b
    c5b9:	88 44 24 10          	mov    %al,0x10(%rsp)
    c5bd:	48 8d 74 24 12       	lea    0x12(%rsp),%rsi
    c5c2:	89 df                	mov    %ebx,%edi
    c5c4:	89 ea                	mov    %ebp,%edx
    c5c6:	e8 a5 6e ff ff       	call   3470 <connect@plt>
    c5cb:	85 c0                	test   %eax,%eax
    c5cd:	75 25                	jne    c5f4 <fwp_pipe_in_offer+0x144>
    c5cf:	48 8d 74 24 0c       	lea    0xc(%rsp),%rsi
    c5d4:	ba 05 00 00 00       	mov    $0x5,%edx
    c5d9:	89 df                	mov    %ebx,%edi
    c5db:	b9 00 40 00 00       	mov    $0x4000,%ecx
    c5e0:	e8 bb 6b ff ff       	call   31a0 <send@plt>
    c5e5:	48 83 f8 05          	cmp    $0x5,%rax
    c5e9:	0f 94 c0             	sete   %al
    c5ec:	41 f6 d6             	not    %r14b
    c5ef:	41 84 c6             	test   %al,%r14b
    c5f2:	75 13                	jne    c607 <fwp_pipe_in_offer+0x157>
    c5f4:	89 df                	mov    %ebx,%edi
    c5f6:	e8 35 6c ff ff       	call   3230 <close@plt>
    c5fb:	48 81 c4 10 01 00 00 	add    $0x110,%rsp
    c602:	5b                   	pop    %rbx
    c603:	41 5e                	pop    %r14
    c605:	5d                   	pop    %rbp
    c606:	c3                   	ret
    c607:	89 1d df f7 00 00    	mov    %ebx,0xf7df(%rip)        # 1bdec <fwp_pi_sock>
    c60d:	eb ec                	jmp    c5fb <fwp_pipe_in_offer+0x14b>
    c60f:	90                   	nop

000000000000c610 <fwp_decode>:
    c610:	55                   	push   %rbp
    c611:	41 57                	push   %r15
    c613:	41 56                	push   %r14
    c615:	41 55                	push   %r13
    c617:	41 54                	push   %r12
    c619:	53                   	push   %rbx
    c61a:	48 83 ec 38          	sub    $0x38,%rsp
    c61e:	8b 06                	mov    (%rsi),%eax
    c620:	45 31 e4             	xor    %r12d,%r12d
    c623:	48 83 f8 15          	cmp    $0x15,%rax
    c627:	0f 87 f3 00 00 00    	ja     c720 <fwp_decode+0x110>
    c62d:	48 89 d5             	mov    %rdx,%rbp
    c630:	49 89 f7             	mov    %rsi,%r15
    c633:	49 89 fe             	mov    %rdi,%r14
    c636:	48 8d 0d a3 8b 00 00 	lea    0x8ba3(%rip),%rcx        # 151e0 <_IO_stdin_used+0x1e0>
    c63d:	48 63 14 81          	movslq (%rcx,%rax,4),%rdx
    c641:	48 01 ca             	add    %rcx,%rdx
    c644:	ff e2                	jmp    *%rdx
    c646:	31 c9                	xor    %ecx,%ecx
    c648:	83 f8 0a             	cmp    $0xa,%eax
    c64b:	0f 95 c1             	setne  %cl
    c64e:	4c 8d 04 8d 04 00 00 	lea    0x4(,%rcx,4),%r8
    c655:	00 
    c656:	49 8b 46 08          	mov    0x8(%r14),%rax
    c65a:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    c65e:	48 29 f8             	sub    %rdi,%rax
    c661:	4c 39 c0             	cmp    %r8,%rax
    c664:	0f 82 b6 00 00 00    	jb     c720 <fwp_decode+0x110>
    c66a:	49 8b 16             	mov    (%r14),%rdx
    c66d:	4a 8d 04 07          	lea    (%rdi,%r8,1),%rax
    c671:	49 89 46 10          	mov    %rax,0x10(%r14)
    c675:	44 89 c6             	mov    %r8d,%esi
    c678:	83 e6 03             	and    $0x3,%esi
    c67b:	49 83 f8 04          	cmp    $0x4,%r8
    c67f:	73 08                	jae    c689 <fwp_decode+0x79>
    c681:	45 31 d2             	xor    %r10d,%r10d
    c684:	45 31 c9             	xor    %r9d,%r9d
    c687:	eb 5e                	jmp    c6e7 <fwp_decode+0xd7>
    c689:	41 83 e0 fc          	and    $0xfffffffc,%r8d
    c68d:	4c 8d 1c 17          	lea    (%rdi,%rdx,1),%r11
    c691:	49 83 c3 03          	add    $0x3,%r11
    c695:	b8 18 00 00 00       	mov    $0x18,%eax
    c69a:	45 31 d2             	xor    %r10d,%r10d
    c69d:	45 31 c9             	xor    %r9d,%r9d
    c6a0:	43 0f b6 5c 13 fd    	movzbl -0x3(%r11,%r10,1),%ebx
    c6a6:	8d 48 e8             	lea    -0x18(%rax),%ecx
    c6a9:	48 d3 e3             	shl    %cl,%rbx
    c6ac:	47 0f b6 74 13 fe    	movzbl -0x2(%r11,%r10,1),%r14d
    c6b2:	8d 48 f0             	lea    -0x10(%rax),%ecx
    c6b5:	49 d3 e6             	shl    %cl,%r14
    c6b8:	47 0f b6 7c 13 ff    	movzbl -0x1(%r11,%r10,1),%r15d
    c6be:	8d 48 f8             	lea    -0x8(%rax),%ecx
    c6c1:	49 d3 e7             	shl    %cl,%r15
    c6c4:	4c 09 cb             	or     %r9,%rbx
    c6c7:	4d 09 f7             	or     %r14,%r15
    c6ca:	49 09 df             	or     %rbx,%r15
    c6cd:	47 0f b6 0c 13       	movzbl (%r11,%r10,1),%r9d
    c6d2:	89 c1                	mov    %eax,%ecx
    c6d4:	49 d3 e1             	shl    %cl,%r9
    c6d7:	4d 09 f9             	or     %r15,%r9
    c6da:	49 83 c2 04          	add    $0x4,%r10
    c6de:	48 83 c0 20          	add    $0x20,%rax
    c6e2:	4d 39 d0             	cmp    %r10,%r8
    c6e5:	75 b9                	jne    c6a0 <fwp_decode+0x90>
    c6e7:	48 85 f6             	test   %rsi,%rsi
    c6ea:	74 2a                	je     c716 <fwp_decode+0x106>
    c6ec:	4a 8d 0c d5 00 00 00 	lea    0x0(,%r10,8),%rcx
    c6f3:	00 
    c6f4:	4c 01 d7             	add    %r10,%rdi
    c6f7:	48 01 fa             	add    %rdi,%rdx
    c6fa:	31 c0                	xor    %eax,%eax
    c6fc:	0f 1f 40 00          	nopl   0x0(%rax)
    c700:	0f b6 3c 02          	movzbl (%rdx,%rax,1),%edi
    c704:	48 d3 e7             	shl    %cl,%rdi
    c707:	49 09 f9             	or     %rdi,%r9
    c70a:	48 ff c0             	inc    %rax
    c70d:	48 83 c1 08          	add    $0x8,%rcx
    c711:	48 39 c6             	cmp    %rax,%rsi
    c714:	75 ea                	jne    c700 <fwp_decode+0xf0>
    c716:	4c 89 4d 00          	mov    %r9,0x0(%rbp)
    c71a:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    c720:	44 89 e0             	mov    %r12d,%eax
    c723:	48 83 c4 38          	add    $0x38,%rsp
    c727:	5b                   	pop    %rbx
    c728:	41 5c                	pop    %r12
    c72a:	41 5d                	pop    %r13
    c72c:	41 5e                	pop    %r14
    c72e:	41 5f                	pop    %r15
    c730:	5d                   	pop    %rbp
    c731:	c3                   	ret
    c732:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    c737:	4c 89 f7             	mov    %r14,%rdi
    c73a:	e8 51 71 00 00       	call   13890 <rd_leb>
    c73f:	85 c0                	test   %eax,%eax
    c741:	74 dd                	je     c720 <fwp_decode+0x110>
    c743:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
    c748:	49 8b 4e 08          	mov    0x8(%r14),%rcx
    c74c:	49 39 cd             	cmp    %rcx,%r13
    c74f:	77 cf                	ja     c720 <fwp_decode+0x110>
    c751:	49 8b 46 10          	mov    0x10(%r14),%rax
    c755:	48 29 c1             	sub    %rax,%rcx
    c758:	4c 39 e9             	cmp    %r13,%rcx
    c75b:	72 c3                	jb     c720 <fwp_decode+0x110>
    c75d:	48 89 eb             	mov    %rbp,%rbx
    c760:	49 8b 2e             	mov    (%r14),%rbp
    c763:	48 01 c5             	add    %rax,%rbp
    c766:	4c 01 e8             	add    %r13,%rax
    c769:	49 89 46 10          	mov    %rax,0x10(%r14)
    c76d:	41 83 3f 0c          	cmpl   $0xc,(%r15)
    c771:	75 0f                	jne    c782 <fwp_decode+0x172>
    c773:	48 89 ef             	mov    %rbp,%rdi
    c776:	4c 89 ee             	mov    %r13,%rsi
    c779:	e8 d2 08 00 00       	call   d050 <fwp_valid_utf8>
    c77e:	85 c0                	test   %eax,%eax
    c780:	74 9e                	je     c720 <fwp_decode+0x110>
    c782:	48 89 ef             	mov    %rbp,%rdi
    c785:	4c 89 ee             	mov    %r13,%rsi
    c788:	e8 23 0a 00 00       	call   d1b0 <fwp_str_new>
    c78d:	48 89 03             	mov    %rax,(%rbx)
    c790:	eb 88                	jmp    c71a <fwp_decode+0x10a>
    c792:	49 8b 46 10          	mov    0x10(%r14),%rax
    c796:	49 39 46 08          	cmp    %rax,0x8(%r14)
    c79a:	74 84                	je     c720 <fwp_decode+0x110>
    c79c:	49 8b 0e             	mov    (%r14),%rcx
    c79f:	48 8d 50 01          	lea    0x1(%rax),%rdx
    c7a3:	49 89 56 10          	mov    %rdx,0x10(%r14)
    c7a7:	48 0f be 04 01       	movsbq (%rcx,%rax,1),%rax
    c7ac:	48 89 45 00          	mov    %rax,0x0(%rbp)
    c7b0:	e9 65 ff ff ff       	jmp    c71a <fwp_decode+0x10a>
    c7b5:	49 8b 76 08          	mov    0x8(%r14),%rsi
    c7b9:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    c7bd:	48 89 f2             	mov    %rsi,%rdx
    c7c0:	48 29 ca             	sub    %rcx,%rdx
    c7c3:	48 83 fa 08          	cmp    $0x8,%rdx
    c7c7:	0f 82 53 ff ff ff    	jb     c720 <fwp_decode+0x110>
    c7cd:	49 8b 16             	mov    (%r14),%rdx
    c7d0:	48 8d 79 08          	lea    0x8(%rcx),%rdi
    c7d4:	49 89 7e 10          	mov    %rdi,0x10(%r14)
    c7d8:	48 29 fe             	sub    %rdi,%rsi
    c7db:	48 83 fe 08          	cmp    $0x8,%rsi
    c7df:	0f 82 3b ff ff ff    	jb     c720 <fwp_decode+0x110>
    c7e5:	48 8b 3c 0a          	mov    (%rdx,%rcx,1),%rdi
    c7e9:	48 8d 71 10          	lea    0x10(%rcx),%rsi
    c7ed:	49 89 76 10          	mov    %rsi,0x10(%r14)
    c7f1:	48 8b 74 0a 08       	mov    0x8(%rdx,%rcx,1),%rsi
    c7f6:	83 f8 04             	cmp    $0x4,%eax
    c7f9:	0f 85 e7 03 00 00    	jne    cbe6 <fwp_decode+0x5d6>
    c7ff:	e8 dc 3b 00 00       	call   103e0 <fwp_box_i128>
    c804:	48 89 45 00          	mov    %rax,0x0(%rbp)
    c808:	e9 0d ff ff ff       	jmp    c71a <fwp_decode+0x10a>
    c80d:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    c812:	49 8b 6f 38          	mov    0x38(%r15),%rbp
    c816:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    c81b:	4c 89 f7             	mov    %r14,%rdi
    c81e:	e8 6d 70 00 00       	call   13890 <rd_leb>
    c823:	85 c0                	test   %eax,%eax
    c825:	0f 84 f5 fe ff ff    	je     c720 <fwp_decode+0x110>
    c82b:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
    c830:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    c837:	ff ff 1f 
    c83a:	49 39 c5             	cmp    %rax,%r13
    c83d:	0f 87 dd fe ff ff    	ja     c720 <fwp_decode+0x110>
    c843:	45 31 e4             	xor    %r12d,%r12d
    c846:	48 89 ef             	mov    %rbp,%rdi
    c849:	31 f6                	xor    %esi,%esi
    c84b:	e8 20 72 00 00       	call   13a70 <fwp_wire_empty_inner>
    c850:	85 c0                	test   %eax,%eax
    c852:	75 0a                	jne    c85e <fwp_decode+0x24e>
    c854:	4d 3b 6e 08          	cmp    0x8(%r14),%r13
    c858:	0f 87 c2 fe ff ff    	ja     c720 <fwp_decode+0x110>
    c85e:	41 83 3f 11          	cmpl   $0x11,(%r15)
    c862:	0f 85 fe 02 00 00    	jne    cb66 <fwp_decode+0x556>
    c868:	49 8b 77 38          	mov    0x38(%r15),%rsi
    c86c:	4c 89 ef             	mov    %r13,%rdi
    c86f:	e8 dc 8f ff ff       	call   5850 <fwp_array_new_packed>
    c874:	49 89 c4             	mov    %rax,%r12
    c877:	4d 85 ed             	test   %r13,%r13
    c87a:	0f 84 2e 04 00 00    	je     ccae <fwp_decode+0x69e>
    c880:	31 ed                	xor    %ebp,%ebp
    c882:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    c887:	eb 11                	jmp    c89a <fwp_decode+0x28a>
    c889:	49 89 44 ec 08       	mov    %rax,0x8(%r12,%rbp,8)
    c88e:	48 ff c5             	inc    %rbp
    c891:	49 39 ed             	cmp    %rbp,%r13
    c894:	0f 84 14 04 00 00    	je     ccae <fwp_decode+0x69e>
    c89a:	49 8b 77 38          	mov    0x38(%r15),%rsi
    c89e:	4c 89 f7             	mov    %r14,%rdi
    c8a1:	48 89 da             	mov    %rbx,%rdx
    c8a4:	e8 67 fd ff ff       	call   c610 <fwp_decode>
    c8a9:	85 c0                	test   %eax,%eax
    c8ab:	0f 84 f2 05 00 00    	je     cea3 <fwp_decode+0x893>
    c8b1:	49 83 3c 24 00       	cmpq   $0x0,(%r12)
    c8b6:	0f 88 ef 05 00 00    	js     ceab <fwp_decode+0x89b>
    c8bc:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    c8c1:	49 8b 4f 38          	mov    0x38(%r15),%rcx
    c8c5:	48 85 c9             	test   %rcx,%rcx
    c8c8:	74 bf                	je     c889 <fwp_decode+0x279>
    c8ca:	8b 09                	mov    (%rcx),%ecx
    c8cc:	83 f9 0a             	cmp    $0xa,%ecx
    c8cf:	77 b8                	ja     c889 <fwp_decode+0x279>
    c8d1:	ba 84 04 00 00       	mov    $0x484,%edx
    c8d6:	0f a3 ca             	bt     %ecx,%edx
    c8d9:	72 1c                	jb     c8f7 <fwp_decode+0x2e7>
    c8db:	ba 21 00 00 00       	mov    $0x21,%edx
    c8e0:	0f a3 ca             	bt     %ecx,%edx
    c8e3:	72 19                	jb     c8fe <fwp_decode+0x2ee>
    c8e5:	ba 42 00 00 00       	mov    $0x42,%edx
    c8ea:	0f a3 ca             	bt     %ecx,%edx
    c8ed:	73 9a                	jae    c889 <fwp_decode+0x279>
    c8ef:	66 41 89 44 6c 08    	mov    %ax,0x8(%r12,%rbp,2)
    c8f5:	eb 97                	jmp    c88e <fwp_decode+0x27e>
    c8f7:	41 89 44 ac 08       	mov    %eax,0x8(%r12,%rbp,4)
    c8fc:	eb 90                	jmp    c88e <fwp_decode+0x27e>
    c8fe:	41 88 44 2c 08       	mov    %al,0x8(%r12,%rbp,1)
    c903:	eb 89                	jmp    c88e <fwp_decode+0x27e>
    c905:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    c90a:	4c 89 f7             	mov    %r14,%rdi
    c90d:	e8 7e 6f 00 00       	call   13890 <rd_leb>
    c912:	85 c0                	test   %eax,%eax
    c914:	0f 84 06 fe ff ff    	je     c720 <fwp_decode+0x110>
    c91a:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    c91f:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
    c924:	49 63 47 10          	movslq 0x10(%r15),%rax
    c928:	49 39 c5             	cmp    %rax,%r13
    c92b:	0f 83 ef fd ff ff    	jae    c720 <fwp_decode+0x110>
    c931:	49 8b 47 28          	mov    0x28(%r15),%rax
    c935:	4a 63 1c a8          	movslq (%rax,%r13,4),%rbx
    c939:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    c940:	00 
    c941:	e8 4a b9 ff ff       	call   8290 <fwp_alloc>
    c946:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    c94b:	89 d8                	mov    %ebx,%eax
    c94d:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    c952:	48 85 db             	test   %rbx,%rbx
    c955:	7e 40                	jle    c997 <fwp_decode+0x387>
    c957:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    c95c:	48 8d 1c c5 00 00 00 	lea    0x0(,%rax,8),%rbx
    c963:	00 
    c964:	45 31 e4             	xor    %r12d,%r12d
    c967:	31 ed                	xor    %ebp,%ebp
    c969:	49 8b 47 30          	mov    0x30(%r15),%rax
    c96d:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    c971:	48 8b 34 28          	mov    (%rax,%rbp,1),%rsi
    c975:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    c97a:	48 8d 14 28          	lea    (%rax,%rbp,1),%rdx
    c97e:	4c 89 f7             	mov    %r14,%rdi
    c981:	e8 8a fc ff ff       	call   c610 <fwp_decode>
    c986:	85 c0                	test   %eax,%eax
    c988:	0f 84 92 fd ff ff    	je     c720 <fwp_decode+0x110>
    c98e:	48 83 c5 08          	add    $0x8,%rbp
    c992:	48 39 eb             	cmp    %rbp,%rbx
    c995:	75 d2                	jne    c969 <fwp_decode+0x359>
    c997:	44 89 ef             	mov    %r13d,%edi
    c99a:	48 8b 74 24 28       	mov    0x28(%rsp),%rsi
    c99f:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
    c9a4:	e8 27 0d 00 00       	call   d6d0 <fwp_data>
    c9a9:	e9 e8 04 00 00       	jmp    ce96 <fwp_decode+0x886>
    c9ae:	41 b8 01 00 00 00    	mov    $0x1,%r8d
    c9b4:	e9 9d fc ff ff       	jmp    c656 <fwp_decode+0x46>
    c9b9:	41 b8 02 00 00 00    	mov    $0x2,%r8d
    c9bf:	e9 92 fc ff ff       	jmp    c656 <fwp_decode+0x46>
    c9c4:	49 8b 4e 08          	mov    0x8(%r14),%rcx
    c9c8:	49 8b 46 10          	mov    0x10(%r14),%rax
    c9cc:	48 29 c1             	sub    %rax,%rcx
    c9cf:	48 83 f9 02          	cmp    $0x2,%rcx
    c9d3:	0f 82 47 fd ff ff    	jb     c720 <fwp_decode+0x110>
    c9d9:	49 8b 0e             	mov    (%r14),%rcx
    c9dc:	48 8d 50 02          	lea    0x2(%rax),%rdx
    c9e0:	49 89 56 10          	mov    %rdx,0x10(%r14)
    c9e4:	0f b6 14 01          	movzbl (%rcx,%rax,1),%edx
    c9e8:	0f b6 44 01 01       	movzbl 0x1(%rcx,%rax,1),%eax
    c9ed:	48 c1 e0 38          	shl    $0x38,%rax
    c9f1:	48 c1 e2 30          	shl    $0x30,%rdx
    c9f5:	48 09 c2             	or     %rax,%rdx
    c9f8:	48 c1 fa 30          	sar    $0x30,%rdx
    c9fc:	48 89 55 00          	mov    %rdx,0x0(%rbp)
    ca00:	e9 15 fd ff ff       	jmp    c71a <fwp_decode+0x10a>
    ca05:	49 8b 4e 08          	mov    0x8(%r14),%rcx
    ca09:	49 8b 46 10          	mov    0x10(%r14),%rax
    ca0d:	48 29 c1             	sub    %rax,%rcx
    ca10:	48 83 f9 04          	cmp    $0x4,%rcx
    ca14:	0f 82 06 fd ff ff    	jb     c720 <fwp_decode+0x110>
    ca1a:	49 8b 0e             	mov    (%r14),%rcx
    ca1d:	48 8d 50 04          	lea    0x4(%rax),%rdx
    ca21:	49 89 56 10          	mov    %rdx,0x10(%r14)
    ca25:	0f b6 14 01          	movzbl (%rcx,%rax,1),%edx
    ca29:	0f b6 74 01 01       	movzbl 0x1(%rcx,%rax,1),%esi
    ca2e:	0f b6 7c 01 02       	movzbl 0x2(%rcx,%rax,1),%edi
    ca33:	0f b6 44 01 03       	movzbl 0x3(%rcx,%rax,1),%eax
    ca38:	48 c1 e0 38          	shl    $0x38,%rax
    ca3c:	48 c1 e7 30          	shl    $0x30,%rdi
    ca40:	48 c1 e6 28          	shl    $0x28,%rsi
    ca44:	48 c1 e2 20          	shl    $0x20,%rdx
    ca48:	48 09 f2             	or     %rsi,%rdx
    ca4b:	48 09 fa             	or     %rdi,%rdx
    ca4e:	48 09 c2             	or     %rax,%rdx
    ca51:	48 c1 fa 20          	sar    $0x20,%rdx
    ca55:	48 89 55 00          	mov    %rdx,0x0(%rbp)
    ca59:	e9 bc fc ff ff       	jmp    c71a <fwp_decode+0x10a>
    ca5e:	41 b8 04 00 00 00    	mov    $0x4,%r8d
    ca64:	e9 ed fb ff ff       	jmp    c656 <fwp_decode+0x46>
    ca69:	49 8b 7f 40          	mov    0x40(%r15),%rdi
    ca6d:	31 f6                	xor    %esi,%esi
    ca6f:	e8 fc 6f 00 00       	call   13a70 <fwp_wire_empty_inner>
    ca74:	85 c0                	test   %eax,%eax
    ca76:	0f 95 c3             	setne  %bl
    ca79:	eb 02                	jmp    ca7d <fwp_decode+0x46d>
    ca7b:	b3 01                	mov    $0x1,%bl
    ca7d:	4d 8b 6f 38          	mov    0x38(%r15),%r13
    ca81:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    ca86:	4c 89 f7             	mov    %r14,%rdi
    ca89:	e8 02 6e 00 00       	call   13890 <rd_leb>
    ca8e:	85 c0                	test   %eax,%eax
    ca90:	0f 84 8a fc ff ff    	je     c720 <fwp_decode+0x110>
    ca96:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    ca9b:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
    caa0:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    caa7:	ff ff 1f 
    caaa:	48 39 c5             	cmp    %rax,%rbp
    caad:	0f 87 6d fc ff ff    	ja     c720 <fwp_decode+0x110>
    cab3:	45 31 e4             	xor    %r12d,%r12d
    cab6:	4c 89 ef             	mov    %r13,%rdi
    cab9:	31 f6                	xor    %esi,%esi
    cabb:	e8 b0 6f 00 00       	call   13a70 <fwp_wire_empty_inner>
    cac0:	85 c0                	test   %eax,%eax
    cac2:	0f 84 2c 01 00 00    	je     cbf4 <fwp_decode+0x5e4>
    cac8:	48 83 fd 02          	cmp    $0x2,%rbp
    cacc:	0f 93 c0             	setae  %al
    cacf:	84 d8                	test   %bl,%al
    cad1:	0f 85 49 fc ff ff    	jne    c720 <fwp_decode+0x110>
    cad7:	e9 22 01 00 00       	jmp    cbfe <fwp_decode+0x5ee>
    cadc:	49 63 7f 10          	movslq 0x10(%r15),%rdi
    cae0:	48 85 ff             	test   %rdi,%rdi
    cae3:	74 74                	je     cb59 <fwp_decode+0x549>
    cae5:	48 c1 e7 03          	shl    $0x3,%rdi
    cae9:	48 ff 05 b8 f3 00 00 	incq   0xf3b8(%rip)        # 1bea8 <measured_calls>
    caf0:	48 01 3d b9 f3 00 00 	add    %rdi,0xf3b9(%rip)        # 1beb0 <measured_bytes>
    caf7:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    cafe:	0f 87 9b 01 00 00    	ja     cc9f <fwp_decode+0x68f>
    cb04:	48 8d 4f 0f          	lea    0xf(%rdi),%rcx
    cb08:	48 c1 e9 04          	shr    $0x4,%rcx
    cb0c:	48 8d 05 75 d7 00 00 	lea    0xd775(%rip),%rax        # 1a288 <fwp_gc>
    cb13:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    cb1a:	00 
    cb1b:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    cb22:	48 29 15 5f d7 00 00 	sub    %rdx,0xd75f(%rip)        # 1a288 <fwp_gc>
    cb29:	0f 88 70 01 00 00    	js     cc9f <fwp_decode+0x68f>
    cb2f:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    cb33:	48 8d 34 c8          	lea    (%rax,%rcx,8),%rsi
    cb37:	48 81 c6 88 07 00 00 	add    $0x788,%rsi
    cb3e:	4c 8b 2e             	mov    (%rsi),%r13
    cb41:	4d 85 ed             	test   %r13,%r13
    cb44:	0f 84 3d 01 00 00    	je     cc87 <fwp_decode+0x677>
    cb4a:	49 8b 45 00          	mov    0x0(%r13),%rax
    cb4e:	48 f7 d0             	not    %rax
    cb51:	48 89 06             	mov    %rax,(%rsi)
    cb54:	e9 80 01 00 00       	jmp    ccd9 <fwp_decode+0x6c9>
    cb59:	48 c7 45 00 00 00 00 	movq   $0x0,0x0(%rbp)
    cb60:	00 
    cb61:	e9 b4 fb ff ff       	jmp    c71a <fwp_decode+0x10a>
    cb66:	4a 8d 3c ed 08 00 00 	lea    0x8(,%r13,8),%rdi
    cb6d:	00 
    cb6e:	48 ff 05 33 f3 00 00 	incq   0xf333(%rip)        # 1bea8 <measured_calls>
    cb75:	48 01 3d 34 f3 00 00 	add    %rdi,0xf334(%rip)        # 1beb0 <measured_bytes>
    cb7c:	49 81 fd ff 07 00 00 	cmp    $0x7ff,%r13
    cb83:	0f 87 6c 02 00 00    	ja     cdf5 <fwp_decode+0x7e5>
    cb89:	4a 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%rcx
    cb90:	00 
    cb91:	48 83 c1 17          	add    $0x17,%rcx
    cb95:	48 c1 e9 04          	shr    $0x4,%rcx
    cb99:	48 8d 05 e8 d6 00 00 	lea    0xd6e8(%rip),%rax        # 1a288 <fwp_gc>
    cba0:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    cba7:	00 
    cba8:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    cbaf:	48 29 15 d2 d6 00 00 	sub    %rdx,0xd6d2(%rip)        # 1a288 <fwp_gc>
    cbb6:	0f 88 39 02 00 00    	js     cdf5 <fwp_decode+0x7e5>
    cbbc:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    cbc0:	48 8d 34 c8          	lea    (%rax,%rcx,8),%rsi
    cbc4:	48 81 c6 88 07 00 00 	add    $0x788,%rsi
    cbcb:	4c 8b 26             	mov    (%rsi),%r12
    cbce:	4d 85 e4             	test   %r12,%r12
    cbd1:	0f 84 06 02 00 00    	je     cddd <fwp_decode+0x7cd>
    cbd7:	49 8b 04 24          	mov    (%r12),%rax
    cbdb:	48 f7 d0             	not    %rax
    cbde:	48 89 06             	mov    %rax,(%rsi)
    cbe1:	e9 74 02 00 00       	jmp    ce5a <fwp_decode+0x84a>
    cbe6:	e8 45 37 00 00       	call   10330 <fwp_box_u128>
    cbeb:	48 89 45 00          	mov    %rax,0x0(%rbp)
    cbef:	e9 26 fb ff ff       	jmp    c71a <fwp_decode+0x10a>
    cbf4:	49 3b 6e 08          	cmp    0x8(%r14),%rbp
    cbf8:	0f 87 22 fb ff ff    	ja     c720 <fwp_decode+0x110>
    cbfe:	84 db                	test   %bl,%bl
    cc00:	75 0a                	jne    cc0c <fwp_decode+0x5fc>
    cc02:	49 3b 6e 08          	cmp    0x8(%r14),%rbp
    cc06:	0f 87 14 fb ff ff    	ja     c720 <fwp_decode+0x110>
    cc0c:	4c 8d 25 fd f2 01 00 	lea    0x1f2fd(%rip),%r12        # 2bf10 <fwp_empty_map>
    cc13:	48 85 ed             	test   %rbp,%rbp
    cc16:	0f 84 9f 00 00 00    	je     ccbb <fwp_decode+0x6ab>
    cc1c:	4c 8d 6c 24 20       	lea    0x20(%rsp),%r13
    cc21:	48 8d 5c 24 30       	lea    0x30(%rsp),%rbx
    cc26:	eb 1b                	jmp    cc43 <fwp_decode+0x633>
    cc28:	31 f6                	xor    %esi,%esi
    cc2a:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    cc2f:	49 8b 4f 38          	mov    0x38(%r15),%rcx
    cc33:	4c 89 e2             	mov    %r12,%rdx
    cc36:	e8 35 33 00 00       	call   ff70 <fwp_p_map_insert>
    cc3b:	49 89 c4             	mov    %rax,%r12
    cc3e:	48 ff cd             	dec    %rbp
    cc41:	74 78                	je     ccbb <fwp_decode+0x6ab>
    cc43:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
    cc4a:	00 00 
    cc4c:	49 8b 77 38          	mov    0x38(%r15),%rsi
    cc50:	4c 89 f7             	mov    %r14,%rdi
    cc53:	4c 89 ea             	mov    %r13,%rdx
    cc56:	e8 b5 f9 ff ff       	call   c610 <fwp_decode>
    cc5b:	85 c0                	test   %eax,%eax
    cc5d:	0f 84 40 02 00 00    	je     cea3 <fwp_decode+0x893>
    cc63:	41 83 3f 12          	cmpl   $0x12,(%r15)
    cc67:	75 bf                	jne    cc28 <fwp_decode+0x618>
    cc69:	49 8b 77 40          	mov    0x40(%r15),%rsi
    cc6d:	4c 89 f7             	mov    %r14,%rdi
    cc70:	48 89 da             	mov    %rbx,%rdx
    cc73:	e8 98 f9 ff ff       	call   c610 <fwp_decode>
    cc78:	85 c0                	test   %eax,%eax
    cc7a:	0f 84 23 02 00 00    	je     cea3 <fwp_decode+0x893>
    cc80:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    cc85:	eb a3                	jmp    cc2a <fwp_decode+0x61a>
    cc87:	4c 8b ac c8 90 07 00 	mov    0x790(%rax,%rcx,8),%r13
    cc8e:	00 
    cc8f:	48 8b b4 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%rsi
    cc96:	00 
    cc97:	4c 29 ee             	sub    %r13,%rsi
    cc9a:	48 39 d6             	cmp    %rdx,%rsi
    cc9d:	73 29                	jae    ccc8 <fwp_decode+0x6b8>
    cc9f:	be 02 00 00 00       	mov    $0x2,%esi
    cca4:	e8 97 b6 ff ff       	call   8340 <fwp_gc_alloc_slow>
    cca9:	49 89 c5             	mov    %rax,%r13
    ccac:	eb 35                	jmp    cce3 <fwp_decode+0x6d3>
    ccae:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    ccb3:	4c 89 20             	mov    %r12,(%rax)
    ccb6:	e9 5f fa ff ff       	jmp    c71a <fwp_decode+0x10a>
    ccbb:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    ccc0:	4c 89 20             	mov    %r12,(%rax)
    ccc3:	e9 52 fa ff ff       	jmp    c71a <fwp_decode+0x10a>
    ccc8:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    cccc:	48 05 90 07 00 00    	add    $0x790,%rax
    ccd2:	4a 8d 0c 2a          	lea    (%rdx,%r13,1),%rcx
    ccd6:	48 89 08             	mov    %rcx,(%rax)
    ccd9:	4c 89 ef             	mov    %r13,%rdi
    ccdc:	31 f6                	xor    %esi,%esi
    ccde:	e8 2d 65 ff ff       	call   3210 <memset@plt>
    cce3:	41 8b 5f 10          	mov    0x10(%r15),%ebx
    cce7:	85 db                	test   %ebx,%ebx
    cce9:	7e 4a                	jle    cd35 <fwp_decode+0x725>
    cceb:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    ccf0:	45 31 e4             	xor    %r12d,%r12d
    ccf3:	4c 89 6c 24 18       	mov    %r13,0x18(%rsp)
    ccf8:	4c 89 ed             	mov    %r13,%rbp
    ccfb:	45 31 ed             	xor    %r13d,%r13d
    ccfe:	66 90                	xchg   %ax,%ax
    cd00:	49 8b 47 20          	mov    0x20(%r15),%rax
    cd04:	4a 8b 34 e8          	mov    (%rax,%r13,8),%rsi
    cd08:	4c 89 f7             	mov    %r14,%rdi
    cd0b:	48 89 ea             	mov    %rbp,%rdx
    cd0e:	e8 fd f8 ff ff       	call   c610 <fwp_decode>
    cd13:	85 c0                	test   %eax,%eax
    cd15:	0f 84 05 fa ff ff    	je     c720 <fwp_decode+0x110>
    cd1b:	49 ff c5             	inc    %r13
    cd1e:	49 63 5f 10          	movslq 0x10(%r15),%rbx
    cd22:	48 83 c5 08          	add    $0x8,%rbp
    cd26:	49 39 dd             	cmp    %rbx,%r13
    cd29:	7c d5                	jl     cd00 <fwp_decode+0x6f0>
    cd2b:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    cd30:	4c 8b 6c 24 18       	mov    0x18(%rsp),%r13
    cd35:	85 db                	test   %ebx,%ebx
    cd37:	0f 84 95 00 00 00    	je     cdd2 <fwp_decode+0x7c2>
    cd3d:	41 89 de             	mov    %ebx,%r14d
    cd40:	4a 8d 3c f5 08 00 00 	lea    0x8(,%r14,8),%rdi
    cd47:	00 
    cd48:	e8 13 db ff ff       	call   a860 <fwp_alloc_init>
    cd4d:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    cd53:	89 58 04             	mov    %ebx,0x4(%rax)
    cd56:	83 fb 08             	cmp    $0x8,%ebx
    cd59:	72 14                	jb     cd6f <fwp_decode+0x75f>
    cd5b:	48 89 c1             	mov    %rax,%rcx
    cd5e:	4c 29 e9             	sub    %r13,%rcx
    cd61:	48 83 c1 08          	add    $0x8,%rcx
    cd65:	48 83 f9 20          	cmp    $0x20,%rcx
    cd69:	0f 83 95 00 00 00    	jae    ce04 <fwp_decode+0x7f4>
    cd6f:	31 c9                	xor    %ecx,%ecx
    cd71:	4c 89 f6             	mov    %r14,%rsi
    cd74:	48 89 ca             	mov    %rcx,%rdx
    cd77:	48 83 e6 03          	and    $0x3,%rsi
    cd7b:	74 15                	je     cd92 <fwp_decode+0x782>
    cd7d:	48 89 ca             	mov    %rcx,%rdx
    cd80:	49 8b 7c d5 00       	mov    0x0(%r13,%rdx,8),%rdi
    cd85:	48 89 7c d0 08       	mov    %rdi,0x8(%rax,%rdx,8)
    cd8a:	48 ff c2             	inc    %rdx
    cd8d:	48 ff ce             	dec    %rsi
    cd90:	75 ee                	jne    cd80 <fwp_decode+0x770>
    cd92:	4c 29 f1             	sub    %r14,%rcx
    cd95:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    cd99:	0f 87 a1 00 00 00    	ja     ce40 <fwp_decode+0x830>
    cd9f:	49 8b 4c d5 00       	mov    0x0(%r13,%rdx,8),%rcx
    cda4:	48 89 4c d0 08       	mov    %rcx,0x8(%rax,%rdx,8)
    cda9:	49 8b 4c d5 08       	mov    0x8(%r13,%rdx,8),%rcx
    cdae:	48 89 4c d0 10       	mov    %rcx,0x10(%rax,%rdx,8)
    cdb3:	49 8b 4c d5 10       	mov    0x10(%r13,%rdx,8),%rcx
    cdb8:	48 89 4c d0 18       	mov    %rcx,0x18(%rax,%rdx,8)
    cdbd:	49 8b 4c d5 18       	mov    0x18(%r13,%rdx,8),%rcx
    cdc2:	48 89 4c d0 20       	mov    %rcx,0x20(%rax,%rdx,8)
    cdc7:	48 83 c2 04          	add    $0x4,%rdx
    cdcb:	49 39 d6             	cmp    %rdx,%r14
    cdce:	75 cf                	jne    cd9f <fwp_decode+0x78f>
    cdd0:	eb 6e                	jmp    ce40 <fwp_decode+0x830>
    cdd2:	31 c0                	xor    %eax,%eax
    cdd4:	48 89 45 00          	mov    %rax,0x0(%rbp)
    cdd8:	e9 3d f9 ff ff       	jmp    c71a <fwp_decode+0x10a>
    cddd:	4c 8b a4 c8 90 07 00 	mov    0x790(%rax,%rcx,8),%r12
    cde4:	00 
    cde5:	48 8b b4 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%rsi
    cdec:	00 
    cded:	4c 29 e6             	sub    %r12,%rsi
    cdf0:	48 39 d6             	cmp    %rdx,%rsi
    cdf3:	73 54                	jae    ce49 <fwp_decode+0x839>
    cdf5:	be 02 00 00 00       	mov    $0x2,%esi
    cdfa:	e8 41 b5 ff ff       	call   8340 <fwp_gc_alloc_slow>
    cdff:	49 89 c4             	mov    %rax,%r12
    ce02:	eb 60                	jmp    ce64 <fwp_decode+0x854>
    ce04:	44 89 f1             	mov    %r14d,%ecx
    ce07:	83 e1 fc             	and    $0xfffffffc,%ecx
    ce0a:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
    ce11:	00 
    ce12:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    ce16:	31 f6                	xor    %esi,%esi
    ce18:	41 0f 10 44 35 00    	movups 0x0(%r13,%rsi,1),%xmm0
    ce1e:	41 0f 10 4c 35 10    	movups 0x10(%r13,%rsi,1),%xmm1
    ce24:	0f 11 44 30 08       	movups %xmm0,0x8(%rax,%rsi,1)
    ce29:	0f 11 4c 30 18       	movups %xmm1,0x18(%rax,%rsi,1)
    ce2e:	48 83 c6 20          	add    $0x20,%rsi
    ce32:	48 39 f2             	cmp    %rsi,%rdx
    ce35:	75 e1                	jne    ce18 <fwp_decode+0x808>
    ce37:	4c 39 f1             	cmp    %r14,%rcx
    ce3a:	0f 85 31 ff ff ff    	jne    cd71 <fwp_decode+0x761>
    ce40:	48 89 45 00          	mov    %rax,0x0(%rbp)
    ce44:	e9 d1 f8 ff ff       	jmp    c71a <fwp_decode+0x10a>
    ce49:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    ce4d:	48 05 90 07 00 00    	add    $0x790,%rax
    ce53:	49 8d 0c 14          	lea    (%r12,%rdx,1),%rcx
    ce57:	48 89 08             	mov    %rcx,(%rax)
    ce5a:	4c 89 e7             	mov    %r12,%rdi
    ce5d:	31 f6                	xor    %esi,%esi
    ce5f:	e8 ac 63 ff ff       	call   3210 <memset@plt>
    ce64:	4d 85 ed             	test   %r13,%r13
    ce67:	74 22                	je     ce8b <fwp_decode+0x87b>
    ce69:	4c 89 e5             	mov    %r12,%rbp
    ce6c:	4c 89 eb             	mov    %r13,%rbx
    ce6f:	49 8b 77 38          	mov    0x38(%r15),%rsi
    ce73:	4c 89 f7             	mov    %r14,%rdi
    ce76:	48 89 ea             	mov    %rbp,%rdx
    ce79:	e8 92 f7 ff ff       	call   c610 <fwp_decode>
    ce7e:	85 c0                	test   %eax,%eax
    ce80:	74 21                	je     cea3 <fwp_decode+0x893>
    ce82:	48 83 c5 08          	add    $0x8,%rbp
    ce86:	48 ff cb             	dec    %rbx
    ce89:	75 e4                	jne    ce6f <fwp_decode+0x85f>
    ce8b:	4c 89 e7             	mov    %r12,%rdi
    ce8e:	4c 89 ee             	mov    %r13,%rsi
    ce91:	e8 4a 00 00 00       	call   cee0 <fwp_list_from>
    ce96:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    ce9b:	48 89 01             	mov    %rax,(%rcx)
    ce9e:	e9 77 f8 ff ff       	jmp    c71a <fwp_decode+0x10a>
    cea3:	45 31 e4             	xor    %r12d,%r12d
    cea6:	e9 75 f8 ff ff       	jmp    c720 <fwp_decode+0x110>
    ceab:	e8 b0 9d ff ff       	call   6c60 <fwp_flush>
    ceb0:	48 8b 05 21 d1 00 00 	mov    0xd121(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    ceb7:	48 8b 38             	mov    (%rax),%rdi
    ceba:	48 8d 35 ed 8b 00 00 	lea    0x8bed(%rip),%rsi        # 15aae <exec_in_fp0+0x23e>
    cec1:	48 8d 15 2e 9b 00 00 	lea    0x9b2e(%rip),%rdx        # 169f6 <exec_in_fp0+0x1186>
    cec8:	31 c0                	xor    %eax,%eax
    ceca:	e8 21 64 ff ff       	call   32f0 <fprintf@plt>
    cecf:	bf 65 00 00 00       	mov    $0x65,%edi
    ced4:	e8 87 65 ff ff       	call   3460 <exit@plt>
    ced9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000cee0 <fwp_list_from>:
    cee0:	55                   	push   %rbp
    cee1:	41 57                	push   %r15
    cee3:	41 56                	push   %r14
    cee5:	41 55                	push   %r13
    cee7:	41 54                	push   %r12
    cee9:	53                   	push   %rbx
    ceea:	48 83 ec 18          	sub    $0x18,%rsp
    ceee:	48 89 fb             	mov    %rdi,%rbx
    cef1:	48 85 f6             	test   %rsi,%rsi
    cef4:	0f 84 41 01 00 00    	je     d03b <fwp_list_from+0x15b>
    cefa:	49 89 f6             	mov    %rsi,%r14
    cefd:	45 31 ff             	xor    %r15d,%r15d
    cf00:	4c 8d 2d 81 d3 00 00 	lea    0xd381(%rip),%r13        # 1a288 <fwp_gc>
    cf07:	eb 3d                	jmp    cf46 <fwp_list_from+0x66>
    cf09:	bf 18 00 00 00       	mov    $0x18,%edi
    cf0e:	31 f6                	xor    %esi,%esi
    cf10:	e8 2b b4 ff ff       	call   8340 <fwp_gc_alloc_slow>
    cf15:	49 89 c7             	mov    %rax,%r15
    cf18:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    cf1f:	00 
    cf20:	48 b8 01 00 00 00 02 	movabs $0x200000001,%rax
    cf27:	00 00 00 
    cf2a:	49 89 07             	mov    %rax,(%r15)
    cf2d:	49 89 6f 08          	mov    %rbp,0x8(%r15)
    cf31:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    cf36:	49 89 47 10          	mov    %rax,0x10(%r15)
    cf3a:	48 89 e0             	mov    %rsp,%rax
    cf3d:	49 ff ce             	dec    %r14
    cf40:	0f 84 f8 00 00 00    	je     d03e <fwp_list_from+0x15e>
    cf46:	4a 8b 6c f3 f8       	mov    -0x8(%rbx,%r14,8),%rbp
    cf4b:	48 89 2c 24          	mov    %rbp,(%rsp)
    cf4f:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
    cf54:	48 ff 05 4d ef 00 00 	incq   0xef4d(%rip)        # 1bea8 <measured_calls>
    cf5b:	48 83 05 4d ef 00 00 	addq   $0x18,0xef4d(%rip)        # 1beb0 <measured_bytes>
    cf62:	18 
    cf63:	0f b6 05 08 df 00 00 	movzbl 0xdf08(%rip),%eax        # 1ae72 <fwp_gc+0xbea>
    cf6a:	41 8b 94 85 48 0b 00 	mov    0xb48(%r13,%rax,4),%edx
    cf71:	00 
    cf72:	48 8b 0d 0f d3 00 00 	mov    0xd30f(%rip),%rcx        # 1a288 <fwp_gc>
    cf79:	48 29 d1             	sub    %rdx,%rcx
    cf7c:	48 89 0d 05 d3 00 00 	mov    %rcx,0xd305(%rip)        # 1a288 <fwp_gc>
    cf83:	78 84                	js     cf09 <fwp_list_from+0x29>
    cf85:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
    cf89:	48 8d 34 c5 08 00 00 	lea    0x8(,%rax,8),%rsi
    cf90:	00 
    cf91:	4c 01 ee             	add    %r13,%rsi
    cf94:	4c 8b 3e             	mov    (%rsi),%r15
    cf97:	4d 85 ff             	test   %r15,%r15
    cf9a:	74 34                	je     cfd0 <fwp_list_from+0xf0>
    cf9c:	49 8b 07             	mov    (%r15),%rax
    cf9f:	48 f7 d0             	not    %rax
    cfa2:	48 89 06             	mov    %rax,(%rsi)
    cfa5:	83 fa 19             	cmp    $0x19,%edx
    cfa8:	0f 82 72 ff ff ff    	jb     cf20 <fwp_list_from+0x40>
    cfae:	49 8d 7f 18          	lea    0x18(%r15),%rdi
    cfb2:	48 83 c2 e7          	add    $0xffffffffffffffe7,%rdx
    cfb6:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    cfba:	48 83 c2 08          	add    $0x8,%rdx
    cfbe:	31 f6                	xor    %esi,%esi
    cfc0:	e8 4b 62 ff ff       	call   3210 <memset@plt>
    cfc5:	e9 56 ff ff ff       	jmp    cf20 <fwp_list_from+0x40>
    cfca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    cfd0:	4d 8b 7c c5 10       	mov    0x10(%r13,%rax,8),%r15
    cfd5:	49 8b 74 c5 18       	mov    0x18(%r13,%rax,8),%rsi
    cfda:	48 89 f7             	mov    %rsi,%rdi
    cfdd:	4c 29 ff             	sub    %r15,%rdi
    cfe0:	48 39 d7             	cmp    %rdx,%rdi
    cfe3:	73 0e                	jae    cff3 <fwp_list_from+0x113>
    cfe5:	4d 89 fc             	mov    %r15,%r12
    cfe8:	48 39 d7             	cmp    %rdx,%rdi
    cfeb:	0f 82 18 ff ff ff    	jb     cf09 <fwp_list_from+0x29>
    cff1:	eb 2d                	jmp    d020 <fwp_list_from+0x140>
    cff3:	48 8d 3c c5 10 00 00 	lea    0x10(,%rax,8),%rdi
    cffa:	00 
    cffb:	4c 01 ef             	add    %r13,%rdi
    cffe:	4d 8d 24 17          	lea    (%r15,%rdx,1),%r12
    d002:	4c 89 27             	mov    %r12,(%rdi)
    d005:	4d 85 ff             	test   %r15,%r15
    d008:	75 9b                	jne    cfa5 <fwp_list_from+0xc5>
    d00a:	48 89 0d 77 d2 00 00 	mov    %rcx,0xd277(%rip)        # 1a288 <fwp_gc>
    d011:	4c 29 e6             	sub    %r12,%rsi
    d014:	48 89 f7             	mov    %rsi,%rdi
    d017:	48 39 d7             	cmp    %rdx,%rdi
    d01a:	0f 82 e9 fe ff ff    	jb     cf09 <fwp_list_from+0x29>
    d020:	49 8d 0c 14          	lea    (%r12,%rdx,1),%rcx
    d024:	49 89 4c c5 10       	mov    %rcx,0x10(%r13,%rax,8)
    d029:	4c 89 e7             	mov    %r12,%rdi
    d02c:	31 f6                	xor    %esi,%esi
    d02e:	e8 dd 61 ff ff       	call   3210 <memset@plt>
    d033:	4d 89 e7             	mov    %r12,%r15
    d036:	e9 e5 fe ff ff       	jmp    cf20 <fwp_list_from+0x40>
    d03b:	45 31 ff             	xor    %r15d,%r15d
    d03e:	4c 89 f8             	mov    %r15,%rax
    d041:	48 83 c4 18          	add    $0x18,%rsp
    d045:	5b                   	pop    %rbx
    d046:	41 5c                	pop    %r12
    d048:	41 5d                	pop    %r13
    d04a:	41 5e                	pop    %r14
    d04c:	41 5f                	pop    %r15
    d04e:	5d                   	pop    %rbp
    d04f:	c3                   	ret

000000000000d050 <fwp_valid_utf8>:
    d050:	48 85 f6             	test   %rsi,%rsi
    d053:	0f 84 48 01 00 00    	je     d1a1 <fwp_valid_utf8+0x151>
    d059:	53                   	push   %rbx
    d05a:	31 c9                	xor    %ecx,%ecx
    d05c:	eb 0e                	jmp    d06c <fwp_valid_utf8+0x1c>
    d05e:	66 90                	xchg   %ax,%ax
    d060:	48 ff c1             	inc    %rcx
    d063:	48 39 f1             	cmp    %rsi,%rcx
    d066:	0f 83 2e 01 00 00    	jae    d19a <fwp_valid_utf8+0x14a>
    d06c:	44 0f b6 14 0f       	movzbl (%rdi,%rcx,1),%r10d
    d071:	45 84 d2             	test   %r10b,%r10b
    d074:	79 ea                	jns    d060 <fwp_valid_utf8+0x10>
    d076:	41 8d 42 3e          	lea    0x3e(%r10),%eax
    d07a:	3c 1e                	cmp    $0x1e,%al
    d07c:	73 12                	jae    d090 <fwp_valid_utf8+0x40>
    d07e:	ba 80 00 00 00       	mov    $0x80,%edx
    d083:	b8 01 00 00 00       	mov    $0x1,%eax
    d088:	41 b8 1f 00 00 00    	mov    $0x1f,%r8d
    d08e:	eb 37                	jmp    d0c7 <fwp_valid_utf8+0x77>
    d090:	44 89 d0             	mov    %r10d,%eax
    d093:	24 f0                	and    $0xf0,%al
    d095:	3c e0                	cmp    $0xe0,%al
    d097:	75 12                	jne    d0ab <fwp_valid_utf8+0x5b>
    d099:	ba 00 08 00 00       	mov    $0x800,%edx
    d09e:	b8 02 00 00 00       	mov    $0x2,%eax
    d0a3:	41 b8 0f 00 00 00    	mov    $0xf,%r8d
    d0a9:	eb 1c                	jmp    d0c7 <fwp_valid_utf8+0x77>
    d0ab:	41 8d 42 10          	lea    0x10(%r10),%eax
    d0af:	3c 04                	cmp    $0x4,%al
    d0b1:	0f 87 f0 00 00 00    	ja     d1a7 <fwp_valid_utf8+0x157>
    d0b7:	ba 00 00 01 00       	mov    $0x10000,%edx
    d0bc:	b8 03 00 00 00       	mov    $0x3,%eax
    d0c1:	41 b8 07 00 00 00    	mov    $0x7,%r8d
    d0c7:	41 89 c1             	mov    %eax,%r9d
    d0ca:	4e 8d 1c 09          	lea    (%rcx,%r9,1),%r11
    d0ce:	31 c0                	xor    %eax,%eax
    d0d0:	49 39 f3             	cmp    %rsi,%r11
    d0d3:	0f 83 c6 00 00 00    	jae    d19f <fwp_valid_utf8+0x14f>
    d0d9:	44 0f b6 5c 0f 01    	movzbl 0x1(%rdi,%rcx,1),%r11d
    d0df:	44 89 db             	mov    %r11d,%ebx
    d0e2:	83 e3 c0             	and    $0xffffffc0,%ebx
    d0e5:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
    d0eb:	0f 85 ae 00 00 00    	jne    d19f <fwp_valid_utf8+0x14f>
    d0f1:	45 21 d0             	and    %r10d,%r8d
    d0f4:	45 8d 51 01          	lea    0x1(%r9),%r10d
    d0f8:	44 89 c3             	mov    %r8d,%ebx
    d0fb:	c1 e3 06             	shl    $0x6,%ebx
    d0fe:	41 83 e3 3f          	and    $0x3f,%r11d
    d102:	41 09 db             	or     %ebx,%r11d
    d105:	41 83 fa 02          	cmp    $0x2,%r10d
    d109:	75 0d                	jne    d118 <fwp_valid_utf8+0xc8>
    d10b:	45 89 da             	mov    %r11d,%r10d
    d10e:	41 39 d2             	cmp    %edx,%r10d
    d111:	73 62                	jae    d175 <fwp_valid_utf8+0x125>
    d113:	e9 87 00 00 00       	jmp    d19f <fwp_valid_utf8+0x14f>
    d118:	44 0f b6 44 0f 02    	movzbl 0x2(%rdi,%rcx,1),%r8d
    d11e:	44 89 c3             	mov    %r8d,%ebx
    d121:	83 e3 c0             	and    $0xffffffc0,%ebx
    d124:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
    d12a:	75 73                	jne    d19f <fwp_valid_utf8+0x14f>
    d12c:	44 89 db             	mov    %r11d,%ebx
    d12f:	c1 e3 06             	shl    $0x6,%ebx
    d132:	41 83 e0 3f          	and    $0x3f,%r8d
    d136:	41 09 d8             	or     %ebx,%r8d
    d139:	41 83 fa 03          	cmp    $0x3,%r10d
    d13d:	75 0d                	jne    d14c <fwp_valid_utf8+0xfc>
    d13f:	45 89 c2             	mov    %r8d,%r10d
    d142:	45 89 d8             	mov    %r11d,%r8d
    d145:	41 39 d2             	cmp    %edx,%r10d
    d148:	73 2b                	jae    d175 <fwp_valid_utf8+0x125>
    d14a:	eb 53                	jmp    d19f <fwp_valid_utf8+0x14f>
    d14c:	44 0f b6 54 0f 03    	movzbl 0x3(%rdi,%rcx,1),%r10d
    d152:	45 89 d3             	mov    %r10d,%r11d
    d155:	41 83 e3 c0          	and    $0xffffffc0,%r11d
    d159:	41 81 fb 80 00 00 00 	cmp    $0x80,%r11d
    d160:	75 3d                	jne    d19f <fwp_valid_utf8+0x14f>
    d162:	45 89 c3             	mov    %r8d,%r11d
    d165:	41 c1 e3 06          	shl    $0x6,%r11d
    d169:	41 83 e2 3f          	and    $0x3f,%r10d
    d16d:	45 09 da             	or     %r11d,%r10d
    d170:	41 39 d2             	cmp    %edx,%r10d
    d173:	72 2a                	jb     d19f <fwp_valid_utf8+0x14f>
    d175:	41 81 fa ff ff 10 00 	cmp    $0x10ffff,%r10d
    d17c:	77 21                	ja     d19f <fwp_valid_utf8+0x14f>
    d17e:	41 83 e0 e0          	and    $0xffffffe0,%r8d
    d182:	41 81 f8 60 03 00 00 	cmp    $0x360,%r8d
    d189:	74 14                	je     d19f <fwp_valid_utf8+0x14f>
    d18b:	4c 01 c9             	add    %r9,%rcx
    d18e:	48 ff c1             	inc    %rcx
    d191:	48 39 f1             	cmp    %rsi,%rcx
    d194:	0f 82 d2 fe ff ff    	jb     d06c <fwp_valid_utf8+0x1c>
    d19a:	b8 01 00 00 00       	mov    $0x1,%eax
    d19f:	5b                   	pop    %rbx
    d1a0:	c3                   	ret
    d1a1:	b8 01 00 00 00       	mov    $0x1,%eax
    d1a6:	c3                   	ret
    d1a7:	31 c0                	xor    %eax,%eax
    d1a9:	5b                   	pop    %rbx
    d1aa:	c3                   	ret
    d1ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000d1b0 <fwp_str_new>:
    d1b0:	41 57                	push   %r15
    d1b2:	41 56                	push   %r14
    d1b4:	53                   	push   %rbx
    d1b5:	49 89 f6             	mov    %rsi,%r14
    d1b8:	48 89 fb             	mov    %rdi,%rbx
    d1bb:	48 8d 56 09          	lea    0x9(%rsi),%rdx
    d1bf:	48 ff 05 e2 ec 00 00 	incq   0xece2(%rip)        # 1bea8 <measured_calls>
    d1c6:	48 01 15 e3 ec 00 00 	add    %rdx,0xece3(%rip)        # 1beb0 <measured_bytes>
    d1cd:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    d1d4:	77 61                	ja     d237 <fwp_str_new+0x87>
    d1d6:	49 8d 4e 18          	lea    0x18(%r14),%rcx
    d1da:	48 c1 e9 04          	shr    $0x4,%rcx
    d1de:	48 8d 05 a3 d0 00 00 	lea    0xd0a3(%rip),%rax        # 1a288 <fwp_gc>
    d1e5:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    d1ec:	00 
    d1ed:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    d1f4:	48 29 0d 8d d0 00 00 	sub    %rcx,0xd08d(%rip)        # 1a288 <fwp_gc>
    d1fb:	78 3a                	js     d237 <fwp_str_new+0x87>
    d1fd:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    d201:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    d205:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    d20c:	4c 8b 3f             	mov    (%rdi),%r15
    d20f:	4d 85 ff             	test   %r15,%r15
    d212:	74 0b                	je     d21f <fwp_str_new+0x6f>
    d214:	49 8b 07             	mov    (%r15),%rax
    d217:	48 f7 d0             	not    %rax
    d21a:	48 89 07             	mov    %rax,(%rdi)
    d21d:	eb 3a                	jmp    d259 <fwp_str_new+0xa9>
    d21f:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    d226:	00 
    d227:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    d22e:	00 
    d22f:	4c 29 ff             	sub    %r15,%rdi
    d232:	48 39 cf             	cmp    %rcx,%rdi
    d235:	73 12                	jae    d249 <fwp_str_new+0x99>
    d237:	48 89 d7             	mov    %rdx,%rdi
    d23a:	be 01 00 00 00       	mov    $0x1,%esi
    d23f:	e8 fc b0 ff ff       	call   8340 <fwp_gc_alloc_slow>
    d244:	49 89 c7             	mov    %rax,%r15
    d247:	eb 1a                	jmp    d263 <fwp_str_new+0xb3>
    d249:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    d24d:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    d253:	4c 01 f9             	add    %r15,%rcx
    d256:	48 89 08             	mov    %rcx,(%rax)
    d259:	4c 89 ff             	mov    %r15,%rdi
    d25c:	31 f6                	xor    %esi,%esi
    d25e:	e8 ad 5f ff ff       	call   3210 <memset@plt>
    d263:	4d 89 37             	mov    %r14,(%r15)
    d266:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    d26a:	48 89 de             	mov    %rbx,%rsi
    d26d:	4c 89 f2             	mov    %r14,%rdx
    d270:	e8 bb 60 ff ff       	call   3330 <memcpy@plt>
    d275:	43 c6 44 37 08 00    	movb   $0x0,0x8(%r15,%r14,1)
    d27b:	4c 89 f8             	mov    %r15,%rax
    d27e:	5b                   	pop    %rbx
    d27f:	41 5e                	pop    %r14
    d281:	41 5f                	pop    %r15
    d283:	c3                   	ret
    d284:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    d28b:	00 00 00 00 00 

000000000000d290 <buf_put>:
    d290:	41 57                	push   %r15
    d292:	41 56                	push   %r14
    d294:	41 54                	push   %r12
    d296:	53                   	push   %rbx
    d297:	50                   	push   %rax
    d298:	49 89 fe             	mov    %rdi,%r14
    d29b:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    d29f:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
    d2a3:	0f 84 a2 00 00 00    	je     d34b <buf_put+0xbb>
    d2a9:	48 89 d3             	mov    %rdx,%rbx
    d2ac:	48 c7 c0 fe ff ff ff 	mov    $0xfffffffffffffffe,%rax
    d2b3:	48 29 f8             	sub    %rdi,%rax
    d2b6:	48 39 d0             	cmp    %rdx,%rax
    d2b9:	0f 82 8c 00 00 00    	jb     d34b <buf_put+0xbb>
    d2bf:	48 8d 04 3b          	lea    (%rbx,%rdi,1),%rax
    d2c3:	48 ff c0             	inc    %rax
    d2c6:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    d2ca:	48 39 c8             	cmp    %rcx,%rax
    d2cd:	76 30                	jbe    d2ff <buf_put+0x6f>
    d2cf:	48 85 c9             	test   %rcx,%rcx
    d2d2:	41 bf 40 00 00 00    	mov    $0x40,%r15d
    d2d8:	4c 0f 45 f9          	cmovne %rcx,%r15
    d2dc:	49 89 f4             	mov    %rsi,%r12
    d2df:	49 39 c7             	cmp    %rax,%r15
    d2e2:	73 23                	jae    d307 <buf_put+0x77>
    d2e4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    d2eb:	00 00 00 00 00 
    d2f0:	4d 85 ff             	test   %r15,%r15
    d2f3:	78 0f                	js     d304 <buf_put+0x74>
    d2f5:	4d 01 ff             	add    %r15,%r15
    d2f8:	49 39 c7             	cmp    %rax,%r15
    d2fb:	72 f3                	jb     d2f0 <buf_put+0x60>
    d2fd:	eb 08                	jmp    d307 <buf_put+0x77>
    d2ff:	49 8b 06             	mov    (%r14),%rax
    d302:	eb 21                	jmp    d325 <buf_put+0x95>
    d304:	49 89 c7             	mov    %rax,%r15
    d307:	49 8b 3e             	mov    (%r14),%rdi
    d30a:	4c 89 fe             	mov    %r15,%rsi
    d30d:	e8 6e 60 ff ff       	call   3380 <realloc@plt>
    d312:	48 85 c0             	test   %rax,%rax
    d315:	74 34                	je     d34b <buf_put+0xbb>
    d317:	49 89 06             	mov    %rax,(%r14)
    d31a:	4d 89 7e 10          	mov    %r15,0x10(%r14)
    d31e:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    d322:	4c 89 e6             	mov    %r12,%rsi
    d325:	48 01 c7             	add    %rax,%rdi
    d328:	48 89 da             	mov    %rbx,%rdx
    d32b:	e8 00 60 ff ff       	call   3330 <memcpy@plt>
    d330:	49 03 5e 08          	add    0x8(%r14),%rbx
    d334:	49 89 5e 08          	mov    %rbx,0x8(%r14)
    d338:	49 8b 06             	mov    (%r14),%rax
    d33b:	c6 04 18 00          	movb   $0x0,(%rax,%rbx,1)
    d33f:	48 83 c4 08          	add    $0x8,%rsp
    d343:	5b                   	pop    %rbx
    d344:	41 5c                	pop    %r12
    d346:	41 5e                	pop    %r14
    d348:	41 5f                	pop    %r15
    d34a:	c3                   	ret
    d34b:	48 8b 05 86 cc 00 00 	mov    0xcc86(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    d352:	48 8b 08             	mov    (%rax),%rcx
    d355:	48 8d 3d aa 87 00 00 	lea    0x87aa(%rip),%rdi        # 15b06 <exec_in_fp0+0x296>
    d35c:	be 13 00 00 00       	mov    $0x13,%esi
    d361:	ba 01 00 00 00       	mov    $0x1,%edx
    d366:	e8 15 61 ff ff       	call   3480 <fwrite@plt>
    d36b:	bf 66 00 00 00       	mov    $0x66,%edi
    d370:	e8 eb 60 ff ff       	call   3460 <exit@plt>
    d375:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    d37c:	00 00 00 00 

000000000000d380 <buf_to_str>:
    d380:	41 57                	push   %r15
    d382:	41 56                	push   %r14
    d384:	41 55                	push   %r13
    d386:	41 54                	push   %r12
    d388:	53                   	push   %rbx
    d389:	48 89 fb             	mov    %rdi,%rbx
    d38c:	4c 8b 2f             	mov    (%rdi),%r13
    d38f:	4c 8b 77 08          	mov    0x8(%rdi),%r14
    d393:	49 8d 56 09          	lea    0x9(%r14),%rdx
    d397:	48 ff 05 0a eb 00 00 	incq   0xeb0a(%rip)        # 1bea8 <measured_calls>
    d39e:	48 01 15 0b eb 00 00 	add    %rdx,0xeb0b(%rip)        # 1beb0 <measured_bytes>
    d3a5:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    d3ac:	77 61                	ja     d40f <buf_to_str+0x8f>
    d3ae:	49 8d 4e 18          	lea    0x18(%r14),%rcx
    d3b2:	48 c1 e9 04          	shr    $0x4,%rcx
    d3b6:	48 8d 05 cb ce 00 00 	lea    0xcecb(%rip),%rax        # 1a288 <fwp_gc>
    d3bd:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    d3c4:	00 
    d3c5:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    d3cc:	48 29 0d b5 ce 00 00 	sub    %rcx,0xceb5(%rip)        # 1a288 <fwp_gc>
    d3d3:	78 3a                	js     d40f <buf_to_str+0x8f>
    d3d5:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    d3d9:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    d3dd:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    d3e4:	4c 8b 3f             	mov    (%rdi),%r15
    d3e7:	4d 85 ff             	test   %r15,%r15
    d3ea:	74 0b                	je     d3f7 <buf_to_str+0x77>
    d3ec:	49 8b 07             	mov    (%r15),%rax
    d3ef:	48 f7 d0             	not    %rax
    d3f2:	48 89 07             	mov    %rax,(%rdi)
    d3f5:	eb 3a                	jmp    d431 <buf_to_str+0xb1>
    d3f7:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    d3fe:	00 
    d3ff:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    d406:	00 
    d407:	4c 29 ff             	sub    %r15,%rdi
    d40a:	48 39 cf             	cmp    %rcx,%rdi
    d40d:	73 12                	jae    d421 <buf_to_str+0xa1>
    d40f:	48 89 d7             	mov    %rdx,%rdi
    d412:	be 01 00 00 00       	mov    $0x1,%esi
    d417:	e8 24 af ff ff       	call   8340 <fwp_gc_alloc_slow>
    d41c:	49 89 c7             	mov    %rax,%r15
    d41f:	eb 1a                	jmp    d43b <buf_to_str+0xbb>
    d421:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    d425:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    d42b:	4c 01 f9             	add    %r15,%rcx
    d42e:	48 89 08             	mov    %rcx,(%rax)
    d431:	4c 89 ff             	mov    %r15,%rdi
    d434:	31 f6                	xor    %esi,%esi
    d436:	e8 d5 5d ff ff       	call   3210 <memset@plt>
    d43b:	4d 85 ed             	test   %r13,%r13
    d43e:	4c 8d 25 a5 8d 00 00 	lea    0x8da5(%rip),%r12        # 161ea <exec_in_fp0+0x97a>
    d445:	4d 0f 45 e5          	cmovne %r13,%r12
    d449:	4d 89 37             	mov    %r14,(%r15)
    d44c:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    d450:	4c 89 e6             	mov    %r12,%rsi
    d453:	4c 89 f2             	mov    %r14,%rdx
    d456:	e8 d5 5e ff ff       	call   3330 <memcpy@plt>
    d45b:	43 c6 44 37 08 00    	movb   $0x0,0x8(%r15,%r14,1)
    d461:	48 8b 3b             	mov    (%rbx),%rdi
    d464:	e8 e7 5b ff ff       	call   3050 <free@plt>
    d469:	4c 89 f8             	mov    %r15,%rax
    d46c:	5b                   	pop    %rbx
    d46d:	41 5c                	pop    %r12
    d46f:	41 5d                	pop    %r13
    d471:	41 5e                	pop    %r14
    d473:	41 5f                	pop    %r15
    d475:	c3                   	ret
    d476:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    d47d:	00 00 00 

000000000000d480 <fwp_strf>:
    d480:	55                   	push   %rbp
    d481:	41 57                	push   %r15
    d483:	41 56                	push   %r14
    d485:	41 55                	push   %r13
    d487:	41 54                	push   %r12
    d489:	53                   	push   %rbx
    d48a:	48 81 ec d8 00 00 00 	sub    $0xd8,%rsp
    d491:	49 89 ff             	mov    %rdi,%r15
    d494:	48 89 74 24 28       	mov    %rsi,0x28(%rsp)
    d499:	48 89 54 24 30       	mov    %rdx,0x30(%rsp)
    d49e:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
    d4a3:	4c 89 44 24 40       	mov    %r8,0x40(%rsp)
    d4a8:	4c 89 4c 24 48       	mov    %r9,0x48(%rsp)
    d4ad:	84 c0                	test   %al,%al
    d4af:	74 37                	je     d4e8 <fwp_strf+0x68>
    d4b1:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
    d4b6:	0f 29 4c 24 60       	movaps %xmm1,0x60(%rsp)
    d4bb:	0f 29 54 24 70       	movaps %xmm2,0x70(%rsp)
    d4c0:	0f 29 9c 24 80 00 00 	movaps %xmm3,0x80(%rsp)
    d4c7:	00 
    d4c8:	0f 29 a4 24 90 00 00 	movaps %xmm4,0x90(%rsp)
    d4cf:	00 
    d4d0:	0f 29 ac 24 a0 00 00 	movaps %xmm5,0xa0(%rsp)
    d4d7:	00 
    d4d8:	0f 29 b4 24 b0 00 00 	movaps %xmm6,0xb0(%rsp)
    d4df:	00 
    d4e0:	0f 29 bc 24 c0 00 00 	movaps %xmm7,0xc0(%rsp)
    d4e7:	00 
    d4e8:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    d4ed:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    d4f2:	48 8d 84 24 10 01 00 	lea    0x110(%rsp),%rax
    d4f9:	00 
    d4fa:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    d4ff:	48 bd 08 00 00 00 30 	movabs $0x3000000008,%rbp
    d506:	00 00 00 
    d509:	48 89 2c 24          	mov    %rbp,(%rsp)
    d50d:	48 89 e1             	mov    %rsp,%rcx
    d510:	31 ff                	xor    %edi,%edi
    d512:	31 f6                	xor    %esi,%esi
    d514:	4c 89 fa             	mov    %r15,%rdx
    d517:	e8 f4 5b ff ff       	call   3110 <vsnprintf@plt>
    d51c:	48 63 d8             	movslq %eax,%rbx
    d51f:	48 ff 05 82 e9 00 00 	incq   0xe982(%rip)        # 1bea8 <measured_calls>
    d526:	4c 8d 63 01          	lea    0x1(%rbx),%r12
    d52a:	4c 01 25 7f e9 00 00 	add    %r12,0xe97f(%rip)        # 1beb0 <measured_bytes>
    d531:	4c 8d 2d 50 cd 00 00 	lea    0xcd50(%rip),%r13        # 1a288 <fwp_gc>
    d538:	49 81 fc 00 40 00 00 	cmp    $0x4000,%r12
    d53f:	77 5c                	ja     d59d <fwp_strf+0x11d>
    d541:	48 8d 43 10          	lea    0x10(%rbx),%rax
    d545:	48 c1 e8 04          	shr    $0x4,%rax
    d549:	42 0f b6 8c 28 e8 0b 	movzbl 0xbe8(%rax,%r13,1),%ecx
    d550:	00 00 
    d552:	41 8b 84 8d 48 0b 00 	mov    0xb48(%r13,%rcx,4),%eax
    d559:	00 
    d55a:	48 29 05 27 cd 00 00 	sub    %rax,0xcd27(%rip)        # 1a288 <fwp_gc>
    d561:	78 3a                	js     d59d <fwp_strf+0x11d>
    d563:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    d567:	48 8d 14 cd c8 03 00 	lea    0x3c8(,%rcx,8),%rdx
    d56e:	00 
    d56f:	4c 01 ea             	add    %r13,%rdx
    d572:	4c 8b 32             	mov    (%rdx),%r14
    d575:	4d 85 f6             	test   %r14,%r14
    d578:	74 0b                	je     d585 <fwp_strf+0x105>
    d57a:	49 8b 06             	mov    (%r14),%rax
    d57d:	48 f7 d0             	not    %rax
    d580:	48 89 02             	mov    %rax,(%rdx)
    d583:	eb 3b                	jmp    d5c0 <fwp_strf+0x140>
    d585:	4d 8b b4 cd d0 03 00 	mov    0x3d0(%r13,%rcx,8),%r14
    d58c:	00 
    d58d:	49 8b 94 cd d8 03 00 	mov    0x3d8(%r13,%rcx,8),%rdx
    d594:	00 
    d595:	4c 29 f2             	sub    %r14,%rdx
    d598:	48 39 c2             	cmp    %rax,%rdx
    d59b:	73 12                	jae    d5af <fwp_strf+0x12f>
    d59d:	4c 89 e7             	mov    %r12,%rdi
    d5a0:	be 01 00 00 00       	mov    $0x1,%esi
    d5a5:	e8 96 ad ff ff       	call   8340 <fwp_gc_alloc_slow>
    d5aa:	49 89 c6             	mov    %rax,%r14
    d5ad:	eb 1e                	jmp    d5cd <fwp_strf+0x14d>
    d5af:	48 8d 0c cd d0 03 00 	lea    0x3d0(,%rcx,8),%rcx
    d5b6:	00 
    d5b7:	4c 01 e9             	add    %r13,%rcx
    d5ba:	4c 01 f0             	add    %r14,%rax
    d5bd:	48 89 01             	mov    %rax,(%rcx)
    d5c0:	4c 89 f7             	mov    %r14,%rdi
    d5c3:	31 f6                	xor    %esi,%esi
    d5c5:	4c 89 e2             	mov    %r12,%rdx
    d5c8:	e8 43 5c ff ff       	call   3210 <memset@plt>
    d5cd:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    d5d2:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    d5d7:	48 8d 84 24 10 01 00 	lea    0x110(%rsp),%rax
    d5de:	00 
    d5df:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    d5e4:	48 89 2c 24          	mov    %rbp,(%rsp)
    d5e8:	48 89 e1             	mov    %rsp,%rcx
    d5eb:	4c 89 f7             	mov    %r14,%rdi
    d5ee:	4c 89 e6             	mov    %r12,%rsi
    d5f1:	4c 89 fa             	mov    %r15,%rdx
    d5f4:	e8 17 5b ff ff       	call   3110 <vsnprintf@plt>
    d5f9:	48 8d 53 09          	lea    0x9(%rbx),%rdx
    d5fd:	48 ff 05 a4 e8 00 00 	incq   0xe8a4(%rip)        # 1bea8 <measured_calls>
    d604:	48 01 15 a5 e8 00 00 	add    %rdx,0xe8a5(%rip)        # 1beb0 <measured_bytes>
    d60b:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    d612:	77 5c                	ja     d670 <fwp_strf+0x1f0>
    d614:	48 8d 43 18          	lea    0x18(%rbx),%rax
    d618:	48 c1 e8 04          	shr    $0x4,%rax
    d61c:	42 0f b6 8c 28 e8 0b 	movzbl 0xbe8(%rax,%r13,1),%ecx
    d623:	00 00 
    d625:	41 8b 84 8d 48 0b 00 	mov    0xb48(%r13,%rcx,4),%eax
    d62c:	00 
    d62d:	48 29 05 54 cc 00 00 	sub    %rax,0xcc54(%rip)        # 1a288 <fwp_gc>
    d634:	78 3a                	js     d670 <fwp_strf+0x1f0>
    d636:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    d63a:	48 8d 34 cd c8 03 00 	lea    0x3c8(,%rcx,8),%rsi
    d641:	00 
    d642:	4c 01 ee             	add    %r13,%rsi
    d645:	4c 8b 3e             	mov    (%rsi),%r15
    d648:	4d 85 ff             	test   %r15,%r15
    d64b:	74 0b                	je     d658 <fwp_strf+0x1d8>
    d64d:	49 8b 07             	mov    (%r15),%rax
    d650:	48 f7 d0             	not    %rax
    d653:	48 89 06             	mov    %rax,(%rsi)
    d656:	eb 3b                	jmp    d693 <fwp_strf+0x213>
    d658:	4d 8b bc cd d0 03 00 	mov    0x3d0(%r13,%rcx,8),%r15
    d65f:	00 
    d660:	49 8b b4 cd d8 03 00 	mov    0x3d8(%r13,%rcx,8),%rsi
    d667:	00 
    d668:	4c 29 fe             	sub    %r15,%rsi
    d66b:	48 39 c6             	cmp    %rax,%rsi
    d66e:	73 12                	jae    d682 <fwp_strf+0x202>
    d670:	48 89 d7             	mov    %rdx,%rdi
    d673:	be 01 00 00 00       	mov    $0x1,%esi
    d678:	e8 c3 ac ff ff       	call   8340 <fwp_gc_alloc_slow>
    d67d:	49 89 c7             	mov    %rax,%r15
    d680:	eb 1b                	jmp    d69d <fwp_strf+0x21d>
    d682:	48 8d 0c cd d0 03 00 	lea    0x3d0(,%rcx,8),%rcx
    d689:	00 
    d68a:	4c 01 e9             	add    %r13,%rcx
    d68d:	4c 01 f8             	add    %r15,%rax
    d690:	48 89 01             	mov    %rax,(%rcx)
    d693:	4c 89 ff             	mov    %r15,%rdi
    d696:	31 f6                	xor    %esi,%esi
    d698:	e8 73 5b ff ff       	call   3210 <memset@plt>
    d69d:	49 89 1f             	mov    %rbx,(%r15)
    d6a0:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    d6a4:	4c 89 f6             	mov    %r14,%rsi
    d6a7:	48 89 da             	mov    %rbx,%rdx
    d6aa:	e8 81 5c ff ff       	call   3330 <memcpy@plt>
    d6af:	41 c6 44 1f 08 00    	movb   $0x0,0x8(%r15,%rbx,1)
    d6b5:	4c 89 f8             	mov    %r15,%rax
    d6b8:	48 81 c4 d8 00 00 00 	add    $0xd8,%rsp
    d6bf:	5b                   	pop    %rbx
    d6c0:	41 5c                	pop    %r12
    d6c2:	41 5d                	pop    %r13
    d6c4:	41 5e                	pop    %r14
    d6c6:	41 5f                	pop    %r15
    d6c8:	5d                   	pop    %rbp
    d6c9:	c3                   	ret
    d6ca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000d6d0 <fwp_data>:
    d6d0:	55                   	push   %rbp
    d6d1:	41 57                	push   %r15
    d6d3:	41 56                	push   %r14
    d6d5:	53                   	push   %rbx
    d6d6:	50                   	push   %rax
    d6d7:	89 fd                	mov    %edi,%ebp
    d6d9:	85 f6                	test   %esi,%esi
    d6db:	0f 84 a1 00 00 00    	je     d782 <fwp_data+0xb2>
    d6e1:	48 89 d3             	mov    %rdx,%rbx
    d6e4:	41 89 f6             	mov    %esi,%r14d
    d6e7:	4a 8d 3c f5 08 00 00 	lea    0x8(,%r14,8),%rdi
    d6ee:	00 
    d6ef:	41 89 f7             	mov    %esi,%r15d
    d6f2:	e8 69 d1 ff ff       	call   a860 <fwp_alloc_init>
    d6f7:	89 28                	mov    %ebp,(%rax)
    d6f9:	44 89 78 04          	mov    %r15d,0x4(%rax)
    d6fd:	41 83 ff 08          	cmp    $0x8,%r15d
    d701:	72 10                	jb     d713 <fwp_data+0x43>
    d703:	48 89 c1             	mov    %rax,%rcx
    d706:	48 29 d9             	sub    %rbx,%rcx
    d709:	48 83 c1 08          	add    $0x8,%rcx
    d70d:	48 83 f9 20          	cmp    $0x20,%rcx
    d711:	73 73                	jae    d786 <fwp_data+0xb6>
    d713:	31 c9                	xor    %ecx,%ecx
    d715:	4c 89 f6             	mov    %r14,%rsi
    d718:	48 89 ca             	mov    %rcx,%rdx
    d71b:	48 83 e6 03          	and    $0x3,%rsi
    d71f:	74 20                	je     d741 <fwp_data+0x71>
    d721:	48 89 ca             	mov    %rcx,%rdx
    d724:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    d72b:	00 00 00 00 00 
    d730:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    d734:	48 89 7c d0 08       	mov    %rdi,0x8(%rax,%rdx,8)
    d739:	48 ff c2             	inc    %rdx
    d73c:	48 ff ce             	dec    %rsi
    d73f:	75 ef                	jne    d730 <fwp_data+0x60>
    d741:	4c 29 f1             	sub    %r14,%rcx
    d744:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    d748:	77 7b                	ja     d7c5 <fwp_data+0xf5>
    d74a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    d750:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    d754:	48 89 4c d0 08       	mov    %rcx,0x8(%rax,%rdx,8)
    d759:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    d75e:	48 89 4c d0 10       	mov    %rcx,0x10(%rax,%rdx,8)
    d763:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    d768:	48 89 4c d0 18       	mov    %rcx,0x18(%rax,%rdx,8)
    d76d:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    d772:	48 89 4c d0 20       	mov    %rcx,0x20(%rax,%rdx,8)
    d777:	48 83 c2 04          	add    $0x4,%rdx
    d77b:	49 39 d6             	cmp    %rdx,%r14
    d77e:	75 d0                	jne    d750 <fwp_data+0x80>
    d780:	eb 43                	jmp    d7c5 <fwp_data+0xf5>
    d782:	89 e8                	mov    %ebp,%eax
    d784:	eb 3f                	jmp    d7c5 <fwp_data+0xf5>
    d786:	44 89 f1             	mov    %r14d,%ecx
    d789:	83 e1 fc             	and    $0xfffffffc,%ecx
    d78c:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
    d793:	00 
    d794:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    d798:	31 f6                	xor    %esi,%esi
    d79a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    d7a0:	0f 10 04 33          	movups (%rbx,%rsi,1),%xmm0
    d7a4:	0f 10 4c 33 10       	movups 0x10(%rbx,%rsi,1),%xmm1
    d7a9:	0f 11 44 30 08       	movups %xmm0,0x8(%rax,%rsi,1)
    d7ae:	0f 11 4c 30 18       	movups %xmm1,0x18(%rax,%rsi,1)
    d7b3:	48 83 c6 20          	add    $0x20,%rsi
    d7b7:	48 39 f2             	cmp    %rsi,%rdx
    d7ba:	75 e4                	jne    d7a0 <fwp_data+0xd0>
    d7bc:	4c 39 f1             	cmp    %r14,%rcx
    d7bf:	0f 85 50 ff ff ff    	jne    d715 <fwp_data+0x45>
    d7c5:	48 83 c4 08          	add    $0x8,%rsp
    d7c9:	5b                   	pop    %rbx
    d7ca:	41 5e                	pop    %r14
    d7cc:	41 5f                	pop    %r15
    d7ce:	5d                   	pop    %rbp
    d7cf:	c3                   	ret

000000000000d7d0 <tp_value>:
    d7d0:	55                   	push   %rbp
    d7d1:	41 57                	push   %r15
    d7d3:	41 56                	push   %r14
    d7d5:	41 55                	push   %r13
    d7d7:	41 54                	push   %r12
    d7d9:	53                   	push   %rbx
    d7da:	48 81 ec d8 01 00 00 	sub    $0x1d8,%rsp
    d7e1:	49 89 cc             	mov    %rcx,%r12
    d7e4:	85 d2                	test   %edx,%edx
    d7e6:	0f 84 99 00 00 00    	je     d885 <tp_value+0xb5>
    d7ec:	83 3e 0c             	cmpl   $0xc,(%rsi)
    d7ef:	0f 85 90 00 00 00    	jne    d885 <tp_value+0xb5>
    d7f5:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    d7f9:	4c 8b 7f 10          	mov    0x10(%rdi),%r15
    d7fd:	4c 89 e5             	mov    %r12,%rbp
    d800:	4c 8b 27             	mov    (%rdi),%r12
    d803:	4d 01 fc             	add    %r15,%r12
    d806:	4d 29 fd             	sub    %r15,%r13
    d809:	0f 85 ea 00 00 00    	jne    d8f9 <tp_value+0x129>
    d80f:	49 8d 55 09          	lea    0x9(%r13),%rdx
    d813:	48 ff 05 8e e6 00 00 	incq   0xe68e(%rip)        # 1bea8 <measured_calls>
    d81a:	48 01 15 8f e6 00 00 	add    %rdx,0xe68f(%rip)        # 1beb0 <measured_bytes>
    d821:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    d828:	0f 87 38 02 00 00    	ja     da66 <tp_value+0x296>
    d82e:	49 8d 4d 18          	lea    0x18(%r13),%rcx
    d832:	48 c1 e9 04          	shr    $0x4,%rcx
    d836:	48 8d 05 4b ca 00 00 	lea    0xca4b(%rip),%rax        # 1a288 <fwp_gc>
    d83d:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    d844:	00 
    d845:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    d84c:	48 29 0d 35 ca 00 00 	sub    %rcx,0xca35(%rip)        # 1a288 <fwp_gc>
    d853:	0f 88 0d 02 00 00    	js     da66 <tp_value+0x296>
    d859:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    d85d:	4c 8d 04 f0          	lea    (%rax,%rsi,8),%r8
    d861:	49 81 c0 c8 03 00 00 	add    $0x3c8,%r8
    d868:	4d 8b 30             	mov    (%r8),%r14
    d86b:	4d 85 f6             	test   %r14,%r14
    d86e:	0f 84 d6 01 00 00    	je     da4a <tp_value+0x27a>
    d874:	48 89 fb             	mov    %rdi,%rbx
    d877:	49 8b 06             	mov    (%r14),%rax
    d87a:	48 f7 d0             	not    %rax
    d87d:	49 89 00             	mov    %rax,(%r8)
    d880:	e9 de 04 00 00       	jmp    dd63 <tp_value+0x593>
    d885:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    d889:	4c 8b 7f 10          	mov    0x10(%rdi),%r15
    d88d:	4d 39 ef             	cmp    %r13,%r15
    d890:	73 2e                	jae    d8c0 <tp_value+0xf0>
    d892:	48 8b 07             	mov    (%rdi),%rax
    d895:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    d89c:	00 00 00 
    d89f:	90                   	nop
    d8a0:	46 0f b6 04 38       	movzbl (%rax,%r15,1),%r8d
    d8a5:	49 83 f8 20          	cmp    $0x20,%r8
    d8a9:	77 15                	ja     d8c0 <tp_value+0xf0>
    d8ab:	4c 0f a3 c1          	bt     %r8,%rcx
    d8af:	73 0f                	jae    d8c0 <tp_value+0xf0>
    d8b1:	49 ff c7             	inc    %r15
    d8b4:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    d8b8:	4d 39 fd             	cmp    %r15,%r13
    d8bb:	75 e3                	jne    d8a0 <tp_value+0xd0>
    d8bd:	4d 89 ef             	mov    %r13,%r15
    d8c0:	8b 06                	mov    (%rsi),%eax
    d8c2:	45 31 f6             	xor    %r14d,%r14d
    d8c5:	48 83 f8 15          	cmp    $0x15,%rax
    d8c9:	0f 87 c8 04 00 00    	ja     dd97 <tp_value+0x5c7>
    d8cf:	48 8d 0d 62 79 00 00 	lea    0x7962(%rip),%rcx        # 15238 <_IO_stdin_used+0x238>
    d8d6:	4c 63 04 81          	movslq (%rcx,%rax,4),%r8
    d8da:	49 01 c8             	add    %rcx,%r8
    d8dd:	41 ff e0             	jmp    *%r8
    d8e0:	4c 89 e2             	mov    %r12,%rdx
    d8e3:	48 81 c4 d8 01 00 00 	add    $0x1d8,%rsp
    d8ea:	5b                   	pop    %rbx
    d8eb:	41 5c                	pop    %r12
    d8ed:	41 5d                	pop    %r13
    d8ef:	41 5e                	pop    %r14
    d8f1:	41 5f                	pop    %r15
    d8f3:	5d                   	pop    %rbp
    d8f4:	e9 e7 16 00 00       	jmp    efe0 <tp_int>
    d8f9:	31 c0                	xor    %eax,%eax
    d8fb:	eb 0f                	jmp    d90c <tp_value+0x13c>
    d8fd:	0f 1f 00             	nopl   (%rax)
    d900:	48 ff c0             	inc    %rax
    d903:	4c 39 e8             	cmp    %r13,%rax
    d906:	0f 83 03 ff ff ff    	jae    d80f <tp_value+0x3f>
    d90c:	45 0f b6 04 04       	movzbl (%r12,%rax,1),%r8d
    d911:	45 84 c0             	test   %r8b,%r8b
    d914:	79 ea                	jns    d900 <tp_value+0x130>
    d916:	41 8d 48 3e          	lea    0x3e(%r8),%ecx
    d91a:	80 f9 1e             	cmp    $0x1e,%cl
    d91d:	73 11                	jae    d930 <tp_value+0x160>
    d91f:	b9 80 00 00 00       	mov    $0x80,%ecx
    d924:	be 01 00 00 00       	mov    $0x1,%esi
    d929:	ba 1f 00 00 00       	mov    $0x1f,%edx
    d92e:	eb 38                	jmp    d968 <tp_value+0x198>
    d930:	44 89 c1             	mov    %r8d,%ecx
    d933:	80 e1 f0             	and    $0xf0,%cl
    d936:	80 f9 e0             	cmp    $0xe0,%cl
    d939:	75 11                	jne    d94c <tp_value+0x17c>
    d93b:	b9 00 08 00 00       	mov    $0x800,%ecx
    d940:	be 02 00 00 00       	mov    $0x2,%esi
    d945:	ba 0f 00 00 00       	mov    $0xf,%edx
    d94a:	eb 1c                	jmp    d968 <tp_value+0x198>
    d94c:	41 8d 48 10          	lea    0x10(%r8),%ecx
    d950:	80 f9 04             	cmp    $0x4,%cl
    d953:	0f 87 8c 15 00 00    	ja     eee5 <tp_value+0x1715>
    d959:	b9 00 00 01 00       	mov    $0x10000,%ecx
    d95e:	be 03 00 00 00       	mov    $0x3,%esi
    d963:	ba 07 00 00 00       	mov    $0x7,%edx
    d968:	89 f6                	mov    %esi,%esi
    d96a:	4c 8d 0c 30          	lea    (%rax,%rsi,1),%r9
    d96e:	45 31 f6             	xor    %r14d,%r14d
    d971:	4d 39 e9             	cmp    %r13,%r9
    d974:	0f 83 1d 04 00 00    	jae    dd97 <tp_value+0x5c7>
    d97a:	45 0f b6 4c 04 01    	movzbl 0x1(%r12,%rax,1),%r9d
    d980:	45 89 ca             	mov    %r9d,%r10d
    d983:	41 83 e2 c0          	and    $0xffffffc0,%r10d
    d987:	41 81 fa 80 00 00 00 	cmp    $0x80,%r10d
    d98e:	0f 85 03 04 00 00    	jne    dd97 <tp_value+0x5c7>
    d994:	44 21 c2             	and    %r8d,%edx
    d997:	44 8d 46 01          	lea    0x1(%rsi),%r8d
    d99b:	41 89 d2             	mov    %edx,%r10d
    d99e:	41 c1 e2 06          	shl    $0x6,%r10d
    d9a2:	41 83 e1 3f          	and    $0x3f,%r9d
    d9a6:	45 09 d1             	or     %r10d,%r9d
    d9a9:	41 83 f8 02          	cmp    $0x2,%r8d
    d9ad:	75 05                	jne    d9b4 <tp_value+0x1e4>
    d9af:	45 89 c8             	mov    %r9d,%r8d
    d9b2:	eb 5d                	jmp    da11 <tp_value+0x241>
    d9b4:	41 0f b6 54 04 02    	movzbl 0x2(%r12,%rax,1),%edx
    d9ba:	41 89 d2             	mov    %edx,%r10d
    d9bd:	41 83 e2 c0          	and    $0xffffffc0,%r10d
    d9c1:	41 81 fa 80 00 00 00 	cmp    $0x80,%r10d
    d9c8:	0f 85 c9 03 00 00    	jne    dd97 <tp_value+0x5c7>
    d9ce:	45 89 ca             	mov    %r9d,%r10d
    d9d1:	41 c1 e2 06          	shl    $0x6,%r10d
    d9d5:	83 e2 3f             	and    $0x3f,%edx
    d9d8:	44 09 d2             	or     %r10d,%edx
    d9db:	41 83 f8 03          	cmp    $0x3,%r8d
    d9df:	75 08                	jne    d9e9 <tp_value+0x219>
    d9e1:	41 89 d0             	mov    %edx,%r8d
    d9e4:	44 89 ca             	mov    %r9d,%edx
    d9e7:	eb 28                	jmp    da11 <tp_value+0x241>
    d9e9:	45 0f b6 44 04 03    	movzbl 0x3(%r12,%rax,1),%r8d
    d9ef:	45 89 c1             	mov    %r8d,%r9d
    d9f2:	41 83 e1 c0          	and    $0xffffffc0,%r9d
    d9f6:	41 81 f9 80 00 00 00 	cmp    $0x80,%r9d
    d9fd:	0f 85 94 03 00 00    	jne    dd97 <tp_value+0x5c7>
    da03:	41 89 d1             	mov    %edx,%r9d
    da06:	41 c1 e1 06          	shl    $0x6,%r9d
    da0a:	41 83 e0 3f          	and    $0x3f,%r8d
    da0e:	45 09 c8             	or     %r9d,%r8d
    da11:	83 e2 e0             	and    $0xffffffe0,%edx
    da14:	81 fa 60 03 00 00    	cmp    $0x360,%edx
    da1a:	0f 84 77 03 00 00    	je     dd97 <tp_value+0x5c7>
    da20:	41 39 c8             	cmp    %ecx,%r8d
    da23:	0f 82 6e 03 00 00    	jb     dd97 <tp_value+0x5c7>
    da29:	41 81 f8 ff ff 10 00 	cmp    $0x10ffff,%r8d
    da30:	0f 87 61 03 00 00    	ja     dd97 <tp_value+0x5c7>
    da36:	48 01 f0             	add    %rsi,%rax
    da39:	48 ff c0             	inc    %rax
    da3c:	4c 39 e8             	cmp    %r13,%rax
    da3f:	0f 82 c7 fe ff ff    	jb     d90c <tp_value+0x13c>
    da45:	e9 c5 fd ff ff       	jmp    d80f <tp_value+0x3f>
    da4a:	4c 8b b4 f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r14
    da51:	00 
    da52:	4c 8b 84 f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%r8
    da59:	00 
    da5a:	4d 29 f0             	sub    %r14,%r8
    da5d:	49 39 c8             	cmp    %rcx,%r8
    da60:	0f 83 ea 02 00 00    	jae    dd50 <tp_value+0x580>
    da66:	48 89 fb             	mov    %rdi,%rbx
    da69:	48 89 d7             	mov    %rdx,%rdi
    da6c:	be 01 00 00 00       	mov    $0x1,%esi
    da71:	e8 ca a8 ff ff       	call   8340 <fwp_gc_alloc_slow>
    da76:	49 89 c6             	mov    %rax,%r14
    da79:	e9 ef 02 00 00       	jmp    dd6d <tp_value+0x59d>
    da7e:	f3 0f 6f 46 38       	movdqu 0x38(%rsi),%xmm0
    da83:	66 0f 7f 44 24 50    	movdqa %xmm0,0x50(%rsp)
    da89:	31 c9                	xor    %ecx,%ecx
    da8b:	83 f8 13             	cmp    $0x13,%eax
    da8e:	0f 94 c1             	sete   %cl
    da91:	66 0f ef c0          	pxor   %xmm0,%xmm0
    da95:	66 0f 7f 44 24 60    	movdqa %xmm0,0x60(%rsp)
    da9b:	48 c7 44 24 70 00 00 	movq   $0x0,0x70(%rsp)
    daa2:	00 00 
    daa4:	89 4c 24 78          	mov    %ecx,0x78(%rsp)
    daa8:	48 8d 0d 36 8c 00 00 	lea    0x8c36(%rip),%rcx        # 166e5 <exec_in_fp0+0xe75>
    daaf:	48 8d 05 5b 7f 00 00 	lea    0x7f5b(%rip),%rax        # 15a11 <exec_in_fp0+0x1a1>
    dab6:	48 0f 44 c1          	cmove  %rcx,%rax
    daba:	4d 39 ef             	cmp    %r13,%r15
    dabd:	73 31                	jae    daf0 <tp_value+0x320>
    dabf:	48 8b 0f             	mov    (%rdi),%rcx
    dac2:	48 ba 00 26 00 00 01 	movabs $0x100002600,%rdx
    dac9:	00 00 00 
    dacc:	0f 1f 40 00          	nopl   0x0(%rax)
    dad0:	46 0f b6 04 39       	movzbl (%rcx,%r15,1),%r8d
    dad5:	49 83 f8 20          	cmp    $0x20,%r8
    dad9:	77 15                	ja     daf0 <tp_value+0x320>
    dadb:	4c 0f a3 c2          	bt     %r8,%rdx
    dadf:	73 0f                	jae    daf0 <tp_value+0x320>
    dae1:	49 ff c7             	inc    %r15
    dae4:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    dae8:	4d 39 fd             	cmp    %r15,%r13
    daeb:	75 e3                	jne    dad0 <tp_value+0x300>
    daed:	4d 89 ef             	mov    %r13,%r15
    daf0:	4d 29 fd             	sub    %r15,%r13
    daf3:	45 31 f6             	xor    %r14d,%r14d
    daf6:	49 83 fd 03          	cmp    $0x3,%r13
    dafa:	0f 82 97 02 00 00    	jb     dd97 <tp_value+0x5c7>
    db00:	48 8b 0f             	mov    (%rdi),%rcx
    db03:	42 0f b7 14 39       	movzwl (%rcx,%r15,1),%edx
    db08:	66 33 10             	xor    (%rax),%dx
    db0b:	42 0f b6 4c 39 02    	movzbl 0x2(%rcx,%r15,1),%ecx
    db11:	32 48 02             	xor    0x2(%rax),%cl
    db14:	0f b6 c1             	movzbl %cl,%eax
    db17:	66 09 d0             	or     %dx,%ax
    db1a:	0f 85 77 02 00 00    	jne    dd97 <tp_value+0x5c7>
    db20:	48 89 f3             	mov    %rsi,%rbx
    db23:	49 83 c7 03          	add    $0x3,%r15
    db27:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    db2b:	48 8d 35 85 8c 00 00 	lea    0x8c85(%rip),%rsi        # 167b7 <exec_in_fp0+0xf47>
    db32:	48 8d 15 a9 7e 00 00 	lea    0x7ea9(%rip),%rdx        # 159e2 <exec_in_fp0+0x172>
    db39:	48 8d 0d 50 23 00 00 	lea    0x2350(%rip),%rcx        # fe90 <tp_kv_item>
    db40:	4c 8d 44 24 50       	lea    0x50(%rsp),%r8
    db45:	e8 e6 1f 00 00       	call   fb30 <tp_list_of>
    db4a:	85 c0                	test   %eax,%eax
    db4c:	0f 84 dc 0a 00 00    	je     e62e <tp_value+0xe5e>
    db52:	48 83 7c 24 68 00    	cmpq   $0x0,0x68(%rsp)
    db58:	0f 84 c3 0d 00 00    	je     e921 <tp_value+0x1151>
    db5e:	48 8d 05 ab e3 01 00 	lea    0x1e3ab(%rip),%rax        # 2bf10 <fwp_empty_map>
    db65:	45 31 f6             	xor    %r14d,%r14d
    db68:	48 8b 4c 24 60       	mov    0x60(%rsp),%rcx
    db6d:	4a 8b 3c f1          	mov    (%rcx,%r14,8),%rdi
    db71:	4a 8b 74 f1 08       	mov    0x8(%rcx,%r14,8),%rsi
    db76:	48 8b 4b 38          	mov    0x38(%rbx),%rcx
    db7a:	48 89 c2             	mov    %rax,%rdx
    db7d:	e8 ee 23 00 00       	call   ff70 <fwp_p_map_insert>
    db82:	49 83 c6 02          	add    $0x2,%r14
    db86:	4c 3b 74 24 68       	cmp    0x68(%rsp),%r14
    db8b:	72 db                	jb     db68 <tp_value+0x398>
    db8d:	e9 96 0d 00 00       	jmp    e928 <tp_value+0x1158>
    db92:	66 0f ef c0          	pxor   %xmm0,%xmm0
    db96:	f3 0f 7f 44 24 68    	movdqu %xmm0,0x68(%rsp)
    db9c:	f3 0f 7f 44 24 58    	movdqu %xmm0,0x58(%rsp)
    dba2:	48 c7 44 24 78 00 00 	movq   $0x0,0x78(%rsp)
    dba9:	00 00 
    dbab:	48 8b 4e 38          	mov    0x38(%rsi),%rcx
    dbaf:	48 89 4c 24 50       	mov    %rcx,0x50(%rsp)
    dbb4:	83 f8 11             	cmp    $0x11,%eax
    dbb7:	75 6c                	jne    dc25 <tp_value+0x455>
    dbb9:	4d 39 ef             	cmp    %r13,%r15
    dbbc:	73 32                	jae    dbf0 <tp_value+0x420>
    dbbe:	48 8b 07             	mov    (%rdi),%rax
    dbc1:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    dbc8:	00 00 00 
    dbcb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    dbd0:	42 0f b6 14 38       	movzbl (%rax,%r15,1),%edx
    dbd5:	48 83 fa 20          	cmp    $0x20,%rdx
    dbd9:	77 15                	ja     dbf0 <tp_value+0x420>
    dbdb:	48 0f a3 d1          	bt     %rdx,%rcx
    dbdf:	73 0f                	jae    dbf0 <tp_value+0x420>
    dbe1:	49 ff c7             	inc    %r15
    dbe4:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    dbe8:	4d 39 fd             	cmp    %r15,%r13
    dbeb:	75 e3                	jne    dbd0 <tp_value+0x400>
    dbed:	4d 89 ef             	mov    %r13,%r15
    dbf0:	4d 29 fd             	sub    %r15,%r13
    dbf3:	45 31 f6             	xor    %r14d,%r14d
    dbf6:	49 83 fd 05          	cmp    $0x5,%r13
    dbfa:	0f 82 97 01 00 00    	jb     dd97 <tp_value+0x5c7>
    dc00:	48 8b 07             	mov    (%rdi),%rax
    dc03:	b9 61 72 72 61       	mov    $0x61727261,%ecx
    dc08:	42 33 0c 38          	xor    (%rax,%r15,1),%ecx
    dc0c:	42 0f b6 44 38 04    	movzbl 0x4(%rax,%r15,1),%eax
    dc12:	83 f0 79             	xor    $0x79,%eax
    dc15:	09 c8                	or     %ecx,%eax
    dc17:	0f 85 7a 01 00 00    	jne    dd97 <tp_value+0x5c7>
    dc1d:	49 83 c7 05          	add    $0x5,%r15
    dc21:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    dc25:	48 89 f3             	mov    %rsi,%rbx
    dc28:	48 8d 35 22 7d 00 00 	lea    0x7d22(%rip),%rsi        # 15951 <exec_in_fp0+0xe1>
    dc2f:	48 8d 15 e5 8c 00 00 	lea    0x8ce5(%rip),%rdx        # 1691b <exec_in_fp0+0x10ab>
    dc36:	48 8d 0d 13 22 00 00 	lea    0x2213(%rip),%rcx        # fe50 <tp_elem_item>
    dc3d:	4c 8d 44 24 50       	lea    0x50(%rsp),%r8
    dc42:	e8 e9 1e 00 00       	call   fb30 <tp_list_of>
    dc47:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
    dc4c:	85 c0                	test   %eax,%eax
    dc4e:	0f 84 2a 05 00 00    	je     e17e <tp_value+0x9ae>
    dc54:	48 8b 74 24 68       	mov    0x68(%rsp),%rsi
    dc59:	e8 82 f2 ff ff       	call   cee0 <fwp_list_from>
    dc5e:	49 89 c6             	mov    %rax,%r14
    dc61:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
    dc66:	e8 35 cf ff ff       	call   aba0 <fwp_mem_free>
    dc6b:	83 3b 11             	cmpl   $0x11,(%rbx)
    dc6e:	0f 85 4a 10 00 00    	jne    ecbe <tp_value+0x14ee>
    dc74:	4c 8b 7b 38          	mov    0x38(%rbx),%r15
    dc78:	4d 85 f6             	test   %r14,%r14
    dc7b:	0f 84 e5 0a 00 00    	je     e766 <tp_value+0xf96>
    dc81:	31 ff                	xor    %edi,%edi
    dc83:	4c 89 f0             	mov    %r14,%rax
    dc86:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    dc8d:	00 00 00 
    dc90:	48 ff c7             	inc    %rdi
    dc93:	48 8b 40 10          	mov    0x10(%rax),%rax
    dc97:	48 85 c0             	test   %rax,%rax
    dc9a:	75 f4                	jne    dc90 <tp_value+0x4c0>
    dc9c:	4c 89 fe             	mov    %r15,%rsi
    dc9f:	e8 ac 7b ff ff       	call   5850 <fwp_array_new_packed>
    dca4:	b9 04 00 00 00       	mov    $0x4,%ecx
    dca9:	ba 84 04 00 00       	mov    $0x484,%edx
    dcae:	be 21 00 00 00       	mov    $0x21,%esi
    dcb3:	bf 42 00 00 00       	mov    $0x42,%edi
    dcb8:	4d 89 f0             	mov    %r14,%r8
    dcbb:	eb 15                	jmp    dcd2 <tp_value+0x502>
    dcbd:	4c 89 4c c8 e8       	mov    %r9,-0x18(%rax,%rcx,8)
    dcc2:	4d 8b 40 10          	mov    0x10(%r8),%r8
    dcc6:	48 ff c1             	inc    %rcx
    dcc9:	4d 85 c0             	test   %r8,%r8
    dccc:	0f 84 9e 0a 00 00    	je     e770 <tp_value+0xfa0>
    dcd2:	48 83 38 00          	cmpq   $0x0,(%rax)
    dcd6:	0f 88 cb 12 00 00    	js     efa7 <tp_value+0x17d7>
    dcdc:	4d 8b 48 08          	mov    0x8(%r8),%r9
    dce0:	4d 85 ff             	test   %r15,%r15
    dce3:	74 d8                	je     dcbd <tp_value+0x4ed>
    dce5:	45 8b 17             	mov    (%r15),%r10d
    dce8:	41 83 fa 0a          	cmp    $0xa,%r10d
    dcec:	77 cf                	ja     dcbd <tp_value+0x4ed>
    dcee:	44 0f a3 d2          	bt     %r10d,%edx
    dcf2:	72 13                	jb     dd07 <tp_value+0x537>
    dcf4:	44 0f a3 d6          	bt     %r10d,%esi
    dcf8:	72 14                	jb     dd0e <tp_value+0x53e>
    dcfa:	44 0f a3 d7          	bt     %r10d,%edi
    dcfe:	73 bd                	jae    dcbd <tp_value+0x4ed>
    dd00:	66 44 89 0c 48       	mov    %r9w,(%rax,%rcx,2)
    dd05:	eb bb                	jmp    dcc2 <tp_value+0x4f2>
    dd07:	44 89 4c 88 f8       	mov    %r9d,-0x8(%rax,%rcx,4)
    dd0c:	eb b4                	jmp    dcc2 <tp_value+0x4f2>
    dd0e:	44 88 4c 08 04       	mov    %r9b,0x4(%rax,%rcx,1)
    dd13:	eb ad                	jmp    dcc2 <tp_value+0x4f2>
    dd15:	49 89 f7             	mov    %rsi,%r15
    dd18:	48 8d 74 24 50       	lea    0x50(%rsp),%rsi
    dd1d:	ba 80 00 00 00       	mov    $0x80,%edx
    dd22:	e8 49 20 00 00       	call   fd70 <tp_token>
    dd27:	45 31 f6             	xor    %r14d,%r14d
    dd2a:	48 83 f8 7f          	cmp    $0x7f,%rax
    dd2e:	77 67                	ja     dd97 <tp_value+0x5c7>
    dd30:	8b 54 24 50          	mov    0x50(%rsp),%edx
    dd34:	81 fa 69 6e 66 00    	cmp    $0x666e69,%edx
    dd3a:	0f 85 0c 04 00 00    	jne    e14c <tp_value+0x97c>
    dd40:	f2 0f 10 05 78 74 00 	movsd  0x7478(%rip),%xmm0        # 151c0 <_IO_stdin_used+0x1c0>
    dd47:	00 
    dd48:	4c 89 f9             	mov    %r15,%rcx
    dd4b:	e9 f5 08 00 00       	jmp    e645 <tp_value+0xe75>
    dd50:	48 89 fb             	mov    %rdi,%rbx
    dd53:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    dd57:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    dd5d:	4c 01 f1             	add    %r14,%rcx
    dd60:	48 89 08             	mov    %rcx,(%rax)
    dd63:	4c 89 f7             	mov    %r14,%rdi
    dd66:	31 f6                	xor    %esi,%esi
    dd68:	e8 a3 54 ff ff       	call   3210 <memset@plt>
    dd6d:	4d 89 2e             	mov    %r13,(%r14)
    dd70:	49 8d 7e 08          	lea    0x8(%r14),%rdi
    dd74:	4c 89 e6             	mov    %r12,%rsi
    dd77:	4c 89 ea             	mov    %r13,%rdx
    dd7a:	e8 b1 55 ff ff       	call   3330 <memcpy@plt>
    dd7f:	43 c6 44 2e 08 00    	movb   $0x0,0x8(%r14,%r13,1)
    dd85:	4c 89 75 00          	mov    %r14,0x0(%rbp)
    dd89:	48 8b 43 08          	mov    0x8(%rbx),%rax
    dd8d:	48 89 43 10          	mov    %rax,0x10(%rbx)
    dd91:	41 be 01 00 00 00    	mov    $0x1,%r14d
    dd97:	44 89 f0             	mov    %r14d,%eax
    dd9a:	48 81 c4 d8 01 00 00 	add    $0x1d8,%rsp
    dda1:	5b                   	pop    %rbx
    dda2:	41 5c                	pop    %r12
    dda4:	41 5d                	pop    %r13
    dda6:	41 5e                	pop    %r14
    dda8:	41 5f                	pop    %r15
    ddaa:	5d                   	pop    %rbp
    ddab:	c3                   	ret
    ddac:	85 d2                	test   %edx,%edx
    ddae:	0f 85 49 fa ff ff    	jne    d7fd <tp_value+0x2d>
    ddb4:	4c 89 e6             	mov    %r12,%rsi
    ddb7:	48 81 c4 d8 01 00 00 	add    $0x1d8,%rsp
    ddbe:	5b                   	pop    %rbx
    ddbf:	41 5c                	pop    %r12
    ddc1:	41 5d                	pop    %r13
    ddc3:	41 5e                	pop    %r14
    ddc5:	41 5f                	pop    %r15
    ddc7:	5d                   	pop    %rbp
    ddc8:	e9 e3 18 00 00       	jmp    f6b0 <tp_quoted>
    ddcd:	66 0f ef c0          	pxor   %xmm0,%xmm0
    ddd1:	66 0f 7f 44 24 70    	movdqa %xmm0,0x70(%rsp)
    ddd7:	66 0f 7f 44 24 60    	movdqa %xmm0,0x60(%rsp)
    dddd:	66 0f 7f 44 24 50    	movdqa %xmm0,0x50(%rsp)
    dde3:	4d 39 ef             	cmp    %r13,%r15
    dde6:	73 38                	jae    de20 <tp_value+0x650>
    dde8:	48 8b 07             	mov    (%rdi),%rax
    ddeb:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    ddf2:	00 00 00 
    ddf5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    ddfc:	00 00 00 00 
    de00:	42 0f b6 14 38       	movzbl (%rax,%r15,1),%edx
    de05:	48 83 fa 20          	cmp    $0x20,%rdx
    de09:	77 15                	ja     de20 <tp_value+0x650>
    de0b:	48 0f a3 d1          	bt     %rdx,%rcx
    de0f:	73 0f                	jae    de20 <tp_value+0x650>
    de11:	49 ff c7             	inc    %r15
    de14:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    de18:	4d 39 fd             	cmp    %r15,%r13
    de1b:	75 e3                	jne    de00 <tp_value+0x630>
    de1d:	4d 89 ef             	mov    %r13,%r15
    de20:	4d 29 fd             	sub    %r15,%r13
    de23:	45 31 f6             	xor    %r14d,%r14d
    de26:	49 83 fd 05          	cmp    $0x5,%r13
    de2a:	72 1d                	jb     de49 <tp_value+0x679>
    de2c:	48 8b 07             	mov    (%rdi),%rax
    de2f:	b9 62 79 74 65       	mov    $0x65747962,%ecx
    de34:	42 33 0c 38          	xor    (%rax,%r15,1),%ecx
    de38:	42 0f b6 44 38 04    	movzbl 0x4(%rax,%r15,1),%eax
    de3e:	83 f0 73             	xor    $0x73,%eax
    de41:	09 c8                	or     %ecx,%eax
    de43:	0f 84 43 07 00 00    	je     e58c <tp_value+0xdbc>
    de49:	31 ff                	xor    %edi,%edi
    de4b:	e8 50 cd ff ff       	call   aba0 <fwp_mem_free>
    de50:	e9 42 ff ff ff       	jmp    dd97 <tp_value+0x5c7>
    de55:	48 89 f3             	mov    %rsi,%rbx
    de58:	48 8d 74 24 50       	lea    0x50(%rsp),%rsi
    de5d:	ba 00 01 00 00       	mov    $0x100,%edx
    de62:	e8 09 1f 00 00       	call   fd70 <tp_token>
    de67:	45 31 f6             	xor    %r14d,%r14d
    de6a:	48 83 f8 02          	cmp    $0x2,%rax
    de6e:	0f 82 23 ff ff ff    	jb     dd97 <tp_value+0x5c7>
    de74:	80 7c 24 50 30       	cmpb   $0x30,0x50(%rsp)
    de79:	0f 85 18 ff ff ff    	jne    dd97 <tp_value+0x5c7>
    de7f:	80 7c 24 51 74       	cmpb   $0x74,0x51(%rsp)
    de84:	0f 85 0d ff ff ff    	jne    dd97 <tp_value+0x5c7>
    de8a:	48 8d 48 fe          	lea    -0x2(%rax),%rcx
    de8e:	48 63 53 48          	movslq 0x48(%rbx),%rdx
    de92:	48 39 d1             	cmp    %rdx,%rcx
    de95:	0f 87 fc fe ff ff    	ja     dd97 <tp_value+0x5c7>
    de9b:	48 83 f8 03          	cmp    $0x3,%rax
    de9f:	0f 82 d3 08 00 00    	jb     e778 <tp_value+0xfa8>
    dea5:	ba 02 00 00 00       	mov    $0x2,%edx
    deaa:	31 c9                	xor    %ecx,%ecx
    deac:	e9 0a 02 00 00       	jmp    e0bb <tp_value+0x8eb>
    deb1:	48 8d 74 24 50       	lea    0x50(%rsp),%rsi
    deb6:	ba 10 00 00 00       	mov    $0x10,%edx
    debb:	e8 b0 1e 00 00       	call   fd70 <tp_token>
    dec0:	8b 44 24 50          	mov    0x50(%rsp),%eax
    dec4:	89 c1                	mov    %eax,%ecx
    dec6:	81 f1 2b 31 00 00    	xor    $0x312b,%ecx
    decc:	0f b6 54 24 52       	movzbl 0x52(%rsp),%edx
    ded1:	66 09 ca             	or     %cx,%dx
    ded4:	41 be 01 00 00 00    	mov    $0x1,%r14d
    deda:	0f 84 de 0d 00 00    	je     ecbe <tp_value+0x14ee>
    dee0:	66 83 f8 31          	cmp    $0x31,%ax
    dee4:	0f 84 d4 0d 00 00    	je     ecbe <tp_value+0x14ee>
    deea:	45 31 f6             	xor    %r14d,%r14d
    deed:	66 83 f8 30          	cmp    $0x30,%ax
    def1:	0f 84 c7 0d 00 00    	je     ecbe <tp_value+0x14ee>
    def7:	b8 2d 31 00 00       	mov    $0x312d,%eax
    defc:	33 44 24 50          	xor    0x50(%rsp),%eax
    df00:	0f b6 4c 24 52       	movzbl 0x52(%rsp),%ecx
    df05:	66 09 c1             	or     %ax,%cx
    df08:	0f 85 89 fe ff ff    	jne    dd97 <tp_value+0x5c7>
    df0e:	49 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%r14
    df15:	e9 a4 0d 00 00       	jmp    ecbe <tp_value+0x14ee>
    df1a:	48 8b 6e 08          	mov    0x8(%rsi),%rbp
    df1e:	48 85 ed             	test   %rbp,%rbp
    df21:	4c 89 64 24 18       	mov    %r12,0x18(%rsp)
    df26:	0f 84 5f 02 00 00    	je     e18b <tp_value+0x9bb>
    df2c:	48 89 f3             	mov    %rsi,%rbx
    df2f:	49 89 fe             	mov    %rdi,%r14
    df32:	48 8d 35 b0 87 00 00 	lea    0x87b0(%rip),%rsi        # 166e9 <exec_in_fp0+0xe79>
    df39:	48 89 ef             	mov    %rbp,%rdi
    df3c:	e8 8f 53 ff ff       	call   32d0 <strcmp@plt>
    df41:	85 c0                	test   %eax,%eax
    df43:	0f 84 06 05 00 00    	je     e44f <tp_value+0xc7f>
    df49:	48 89 d8             	mov    %rbx,%rax
    df4c:	44 8b 63 10          	mov    0x10(%rbx),%r12d
    df50:	4d 39 ef             	cmp    %r13,%r15
    df53:	73 30                	jae    df85 <tp_value+0x7b5>
    df55:	4c 89 f1             	mov    %r14,%rcx
    df58:	49 8b 16             	mov    (%r14),%rdx
    df5b:	48 be 00 26 00 00 01 	movabs $0x100002600,%rsi
    df62:	00 00 00 
    df65:	42 0f b6 3c 3a       	movzbl (%rdx,%r15,1),%edi
    df6a:	48 83 ff 20          	cmp    $0x20,%rdi
    df6e:	77 15                	ja     df85 <tp_value+0x7b5>
    df70:	48 0f a3 fe          	bt     %rdi,%rsi
    df74:	73 0f                	jae    df85 <tp_value+0x7b5>
    df76:	49 ff c7             	inc    %r15
    df79:	4c 89 79 10          	mov    %r15,0x10(%rcx)
    df7d:	4d 39 fd             	cmp    %r15,%r13
    df80:	75 e3                	jne    df65 <tp_value+0x795>
    df82:	4d 89 ef             	mov    %r13,%r15
    df85:	48 83 c0 10          	add    $0x10,%rax
    df89:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    df8e:	48 89 ef             	mov    %rbp,%rdi
    df91:	e8 da 51 ff ff       	call   3170 <strlen@plt>
    df96:	4d 29 fd             	sub    %r15,%r13
    df99:	49 39 c5             	cmp    %rax,%r13
    df9c:	72 1c                	jb     dfba <tp_value+0x7ea>
    df9e:	49 8b 3e             	mov    (%r14),%rdi
    dfa1:	4c 01 ff             	add    %r15,%rdi
    dfa4:	48 89 ee             	mov    %rbp,%rsi
    dfa7:	49 89 c5             	mov    %rax,%r13
    dfaa:	48 89 c2             	mov    %rax,%rdx
    dfad:	e8 be 53 ff ff       	call   3370 <bcmp@plt>
    dfb2:	85 c0                	test   %eax,%eax
    dfb4:	0f 84 58 0b 00 00    	je     eb12 <tp_value+0x1342>
    dfba:	4c 89 f7             	mov    %r14,%rdi
    dfbd:	48 89 de             	mov    %rbx,%rsi
    dfc0:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    dfc5:	49 63 c4             	movslq %r12d,%rax
    dfc8:	48 8d 04 c5 08 00 00 	lea    0x8(,%rax,8),%rax
    dfcf:	00 
    dfd0:	4c 8b 25 d1 de 00 00 	mov    0xded1(%rip),%r12        # 1bea8 <measured_calls>
    dfd7:	49 ff c4             	inc    %r12
    dfda:	4c 89 25 c7 de 00 00 	mov    %r12,0xdec7(%rip)        # 1bea8 <measured_calls>
    dfe1:	4c 8b 2d c8 de 00 00 	mov    0xdec8(%rip),%r13        # 1beb0 <measured_bytes>
    dfe8:	49 01 c5             	add    %rax,%r13
    dfeb:	4c 89 2d be de 00 00 	mov    %r13,0xdebe(%rip)        # 1beb0 <measured_bytes>
    dff2:	4c 8d 35 8f c2 00 00 	lea    0xc28f(%rip),%r14        # 1a288 <fwp_gc>
    dff9:	48 3d 00 40 00 00    	cmp    $0x4000,%rax
    dfff:	0f 87 79 06 00 00    	ja     e67e <tp_value+0xeae>
    e005:	48 8d 48 0f          	lea    0xf(%rax),%rcx
    e009:	48 c1 e9 04          	shr    $0x4,%rcx
    e00d:	42 0f b6 8c 31 e8 0b 	movzbl 0xbe8(%rcx,%r14,1),%ecx
    e014:	00 00 
    e016:	41 8b 94 8e 48 0b 00 	mov    0xb48(%r14,%rcx,4),%edx
    e01d:	00 
    e01e:	48 29 15 63 c2 00 00 	sub    %rdx,0xc263(%rip)        # 1a288 <fwp_gc>
    e025:	0f 88 53 06 00 00    	js     e67e <tp_value+0xeae>
    e02b:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    e02f:	4d 8d 04 ce          	lea    (%r14,%rcx,8),%r8
    e033:	49 81 c0 88 07 00 00 	add    $0x788,%r8
    e03a:	4d 8b 08             	mov    (%r8),%r9
    e03d:	4d 85 c9             	test   %r9,%r9
    e040:	0f 84 1c 06 00 00    	je     e662 <tp_value+0xe92>
    e046:	48 89 f5             	mov    %rsi,%rbp
    e049:	48 89 fb             	mov    %rdi,%rbx
    e04c:	49 8b 01             	mov    (%r9),%rax
    e04f:	48 f7 d0             	not    %rax
    e052:	49 89 00             	mov    %rax,(%r8)
    e055:	e9 40 07 00 00       	jmp    e79a <tp_value+0xfca>
    e05a:	48 8b 07             	mov    (%rdi),%rax
    e05d:	4d 39 ef             	cmp    %r13,%r15
    e060:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    e065:	89 54 24 08          	mov    %edx,0x8(%rsp)
    e069:	73 77                	jae    e0e2 <tp_value+0x912>
    e06b:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    e072:	00 00 00 
    e075:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    e07c:	00 00 00 00 
    e080:	46 0f b6 04 38       	movzbl (%rax,%r15,1),%r8d
    e085:	49 83 f8 20          	cmp    $0x20,%r8
    e089:	77 57                	ja     e0e2 <tp_value+0x912>
    e08b:	4c 0f a3 c1          	bt     %r8,%rcx
    e08f:	73 51                	jae    e0e2 <tp_value+0x912>
    e091:	49 ff c7             	inc    %r15
    e094:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    e098:	4d 39 fd             	cmp    %r15,%r13
    e09b:	75 e3                	jne    e080 <tp_value+0x8b0>
    e09d:	48 89 f5             	mov    %rsi,%rbp
    e0a0:	4d 89 ef             	mov    %r13,%r15
    e0a3:	e9 19 02 00 00       	jmp    e2c1 <tp_value+0xaf1>
    e0a8:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    e0ac:	48 ff c9             	dec    %rcx
    e0af:	48 ff c2             	inc    %rdx
    e0b2:	48 39 d0             	cmp    %rdx,%rax
    e0b5:	0f 84 bf 06 00 00    	je     e77a <tp_value+0xfaa>
    e0bb:	0f b6 74 14 50       	movzbl 0x50(%rsp,%rdx,1),%esi
    e0c0:	83 fe 30             	cmp    $0x30,%esi
    e0c3:	74 17                	je     e0dc <tp_value+0x90c>
    e0c5:	83 fe 2d             	cmp    $0x2d,%esi
    e0c8:	74 de                	je     e0a8 <tp_value+0x8d8>
    e0ca:	83 fe 2b             	cmp    $0x2b,%esi
    e0cd:	0f 85 12 0e 00 00    	jne    eee5 <tp_value+0x1715>
    e0d3:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    e0d7:	48 ff c1             	inc    %rcx
    e0da:	eb d3                	jmp    e0af <tp_value+0x8df>
    e0dc:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    e0e0:	eb cd                	jmp    e0af <tp_value+0x8df>
    e0e2:	4d 39 ef             	cmp    %r13,%r15
    e0e5:	0f 83 cb 01 00 00    	jae    e2b6 <tp_value+0xae6>
    e0eb:	49 b8 03 00 00 00 00 	movabs $0x4000000000003,%r8
    e0f2:	00 04 00 
    e0f5:	4c 89 f9             	mov    %r15,%rcx
    e0f8:	eb 16                	jmp    e110 <tp_value+0x940>
    e0fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    e100:	48 ff c1             	inc    %rcx
    e103:	48 89 4f 10          	mov    %rcx,0x10(%rdi)
    e107:	49 39 cd             	cmp    %rcx,%r13
    e10a:	0f 84 ae 01 00 00    	je     e2be <tp_value+0xaee>
    e110:	44 0f b6 0c 08       	movzbl (%rax,%rcx,1),%r9d
    e115:	45 8d 51 d0          	lea    -0x30(%r9),%r10d
    e119:	41 80 fa 0a          	cmp    $0xa,%r10b
    e11d:	72 e1                	jb     e100 <tp_value+0x930>
    e11f:	45 89 ca             	mov    %r9d,%r10d
    e122:	41 80 e2 df          	and    $0xdf,%r10b
    e126:	41 80 c2 bf          	add    $0xbf,%r10b
    e12a:	41 80 fa 1a          	cmp    $0x1a,%r10b
    e12e:	72 d0                	jb     e100 <tp_value+0x930>
    e130:	45 0f b6 c9          	movzbl %r9b,%r9d
    e134:	41 83 c1 d3          	add    $0xffffffd3,%r9d
    e138:	41 83 f9 32          	cmp    $0x32,%r9d
    e13c:	77 06                	ja     e144 <tp_value+0x974>
    e13e:	4d 0f a3 c8          	bt     %r9,%r8
    e142:	72 bc                	jb     e100 <tp_value+0x930>
    e144:	48 89 f5             	mov    %rsi,%rbp
    e147:	e9 78 01 00 00       	jmp    e2c4 <tp_value+0xaf4>
    e14c:	b9 2d 69 6e 66       	mov    $0x666e692d,%ecx
    e151:	33 4c 24 50          	xor    0x50(%rsp),%ecx
    e155:	0f b6 74 24 54       	movzbl 0x54(%rsp),%esi
    e15a:	09 ce                	or     %ecx,%esi
    e15c:	4c 89 f9             	mov    %r15,%rcx
    e15f:	0f 84 d8 04 00 00    	je     e63d <tp_value+0xe6d>
    e165:	81 fa 4e 61 4e 00    	cmp    $0x4e614e,%edx
    e16b:	0f 85 38 05 00 00    	jne    e6a9 <tp_value+0xed9>
    e171:	f2 0f 10 05 57 70 00 	movsd  0x7057(%rip),%xmm0        # 151d0 <_IO_stdin_used+0x1d0>
    e178:	00 
    e179:	e9 c7 04 00 00       	jmp    e645 <tp_value+0xe75>
    e17e:	e8 1d ca ff ff       	call   aba0 <fwp_mem_free>
    e183:	45 31 f6             	xor    %r14d,%r14d
    e186:	e9 0c fc ff ff       	jmp    dd97 <tp_value+0x5c7>
    e18b:	4c 63 66 10          	movslq 0x10(%rsi),%r12
    e18f:	4d 85 e4             	test   %r12,%r12
    e192:	0f 84 8f 05 00 00    	je     e727 <tp_value+0xf57>
    e198:	4c 8d 7e 10          	lea    0x10(%rsi),%r15
    e19c:	83 7e 48 00          	cmpl   $0x0,0x48(%rsi)
    e1a0:	0f 84 1f fe ff ff    	je     dfc5 <tp_value+0x7f5>
    e1a6:	48 89 f3             	mov    %rsi,%rbx
    e1a9:	49 c1 e4 03          	shl    $0x3,%r12
    e1ad:	49 89 fd             	mov    %rdi,%r13
    e1b0:	4c 89 e7             	mov    %r12,%rdi
    e1b3:	e8 d8 a0 ff ff       	call   8290 <fwp_alloc>
    e1b8:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    e1bd:	48 8d 35 35 85 00 00 	lea    0x8535(%rip),%rsi        # 166f9 <exec_in_fp0+0xe89>
    e1c4:	4d 89 ec             	mov    %r13,%r12
    e1c7:	4c 89 ef             	mov    %r13,%rdi
    e1ca:	e8 c1 18 00 00       	call   fa90 <tp_eat>
    e1cf:	85 c0                	test   %eax,%eax
    e1d1:	0f 84 c0 fb ff ff    	je     dd97 <tp_value+0x5c7>
    e1d7:	41 83 3f 00          	cmpl   $0x0,(%r15)
    e1db:	4c 89 e7             	mov    %r12,%rdi
    e1de:	0f 8e 9e 00 00 00    	jle    e282 <tp_value+0xab2>
    e1e4:	45 31 ed             	xor    %r13d,%r13d
    e1e7:	48 bd 00 26 00 00 01 	movabs $0x100002600,%rbp
    e1ee:	00 00 00 
    e1f1:	4d 85 ed             	test   %r13,%r13
    e1f4:	74 54                	je     e24a <tp_value+0xa7a>
    e1f6:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
    e1fa:	48 8b 47 10          	mov    0x10(%rdi),%rax
    e1fe:	48 39 c8             	cmp    %rcx,%rax
    e201:	73 27                	jae    e22a <tp_value+0xa5a>
    e203:	48 8b 17             	mov    (%rdi),%rdx
    e206:	0f b6 34 02          	movzbl (%rdx,%rax,1),%esi
    e20a:	48 83 fe 20          	cmp    $0x20,%rsi
    e20e:	77 1a                	ja     e22a <tp_value+0xa5a>
    e210:	48 0f a3 f5          	bt     %rsi,%rbp
    e214:	73 14                	jae    e22a <tp_value+0xa5a>
    e216:	48 ff c0             	inc    %rax
    e219:	48 89 47 10          	mov    %rax,0x10(%rdi)
    e21d:	45 31 f6             	xor    %r14d,%r14d
    e220:	48 39 c1             	cmp    %rax,%rcx
    e223:	75 e1                	jne    e206 <tp_value+0xa36>
    e225:	e9 6d fb ff ff       	jmp    dd97 <tp_value+0x5c7>
    e22a:	45 31 f6             	xor    %r14d,%r14d
    e22d:	48 39 c1             	cmp    %rax,%rcx
    e230:	0f 84 61 fb ff ff    	je     dd97 <tp_value+0x5c7>
    e236:	48 8b 0f             	mov    (%rdi),%rcx
    e239:	80 3c 01 2c          	cmpb   $0x2c,(%rcx,%rax,1)
    e23d:	0f 85 54 fb ff ff    	jne    dd97 <tp_value+0x5c7>
    e243:	48 ff c0             	inc    %rax
    e246:	48 89 47 10          	mov    %rax,0x10(%rdi)
    e24a:	48 8b 43 20          	mov    0x20(%rbx),%rax
    e24e:	4a 8b 34 e8          	mov    (%rax,%r13,8),%rsi
    e252:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    e257:	4a 8d 0c e8          	lea    (%rax,%r13,8),%rcx
    e25b:	45 31 f6             	xor    %r14d,%r14d
    e25e:	4c 89 e7             	mov    %r12,%rdi
    e261:	31 d2                	xor    %edx,%edx
    e263:	e8 68 f5 ff ff       	call   d7d0 <tp_value>
    e268:	85 c0                	test   %eax,%eax
    e26a:	0f 84 27 fb ff ff    	je     dd97 <tp_value+0x5c7>
    e270:	4c 89 e7             	mov    %r12,%rdi
    e273:	49 ff c5             	inc    %r13
    e276:	49 63 07             	movslq (%r15),%rax
    e279:	49 39 c5             	cmp    %rax,%r13
    e27c:	0f 8c 6f ff ff ff    	jl     e1f1 <tp_value+0xa21>
    e282:	48 8d 35 31 85 00 00 	lea    0x8531(%rip),%rsi        # 167ba <exec_in_fp0+0xf4a>
    e289:	e8 02 18 00 00       	call   fa90 <tp_eat>
    e28e:	41 be 00 00 00 00    	mov    $0x0,%r14d
    e294:	85 c0                	test   %eax,%eax
    e296:	0f 84 fb fa ff ff    	je     dd97 <tp_value+0x5c7>
    e29c:	41 8b 3f             	mov    (%r15),%edi
    e29f:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    e2a4:	e8 87 1f 00 00       	call   10230 <fwp_record>
    e2a9:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    e2ae:	48 89 01             	mov    %rax,(%rcx)
    e2b1:	e9 db fa ff ff       	jmp    dd91 <tp_value+0x5c1>
    e2b6:	48 89 f5             	mov    %rsi,%rbp
    e2b9:	4c 89 f9             	mov    %r15,%rcx
    e2bc:	eb 06                	jmp    e2c4 <tp_value+0xaf4>
    e2be:	48 89 f5             	mov    %rsi,%rbp
    e2c1:	4c 89 e9             	mov    %r13,%rcx
    e2c4:	4c 89 64 24 18       	mov    %r12,0x18(%rsp)
    e2c9:	4c 29 f9             	sub    %r15,%rcx
    e2cc:	48 81 f9 ff 00 00 00 	cmp    $0xff,%rcx
    e2d3:	41 be ff 00 00 00    	mov    $0xff,%r14d
    e2d9:	4c 0f 42 f1          	cmovb  %rcx,%r14
    e2dd:	4c 01 f8             	add    %r15,%rax
    e2e0:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    e2e5:	48 89 c6             	mov    %rax,%rsi
    e2e8:	4c 89 f2             	mov    %r14,%rdx
    e2eb:	e8 40 50 ff ff       	call   3330 <memcpy@plt>
    e2f0:	42 c6 44 34 50 00    	movb   $0x0,0x50(%rsp,%r14,1)
    e2f6:	44 8b 6d 10          	mov    0x10(%rbp),%r13d
    e2fa:	45 85 ed             	test   %r13d,%r13d
    e2fd:	7e 3d                	jle    e33c <tp_value+0xb6c>
    e2ff:	49 89 ef             	mov    %rbp,%r15
    e302:	48 8b 5d 18          	mov    0x18(%rbp),%rbx
    e306:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    e30b:	45 31 e4             	xor    %r12d,%r12d
    e30e:	4c 8d 74 24 50       	lea    0x50(%rsp),%r14
    e313:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    e31a:	84 00 00 00 00 00 
    e320:	4a 8b 3c e3          	mov    (%rbx,%r12,8),%rdi
    e324:	4c 89 f6             	mov    %r14,%rsi
    e327:	e8 a4 4f ff ff       	call   32d0 <strcmp@plt>
    e32c:	85 c0                	test   %eax,%eax
    e32e:	41 0f 44 ec          	cmove  %r12d,%ebp
    e332:	49 ff c4             	inc    %r12
    e335:	4d 39 e5             	cmp    %r12,%r13
    e338:	75 e6                	jne    e320 <tp_value+0xb50>
    e33a:	eb 08                	jmp    e344 <tp_value+0xb74>
    e33c:	49 89 ef             	mov    %rbp,%r15
    e33f:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    e344:	83 7c 24 08 00       	cmpl   $0x0,0x8(%rsp)
    e349:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    e34e:	74 60                	je     e3b0 <tp_value+0xbe0>
    e350:	85 ed                	test   %ebp,%ebp
    e352:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
    e357:	79 5c                	jns    e3b5 <tp_value+0xbe5>
    e359:	49 8b 7f 08          	mov    0x8(%r15),%rdi
    e35d:	45 31 f6             	xor    %r14d,%r14d
    e360:	48 85 ff             	test   %rdi,%rdi
    e363:	0f 84 2e fa ff ff    	je     dd97 <tp_value+0x5c7>
    e369:	48 8d 35 5b 83 00 00 	lea    0x835b(%rip),%rsi        # 166cb <exec_in_fp0+0xe5b>
    e370:	e8 5b 4f ff ff       	call   32d0 <strcmp@plt>
    e375:	85 c0                	test   %eax,%eax
    e377:	0f 85 1a fa ff ff    	jne    dd97 <tp_value+0x5c7>
    e37d:	4c 89 fe             	mov    %r15,%rsi
    e380:	8b 44 24 50          	mov    0x50(%rsp),%eax
    e384:	89 c2                	mov    %eax,%edx
    e386:	81 f2 74 72 75 65    	xor    $0x65757274,%edx
    e38c:	0f b6 7c 24 54       	movzbl 0x54(%rsp),%edi
    e391:	09 d7                	or     %edx,%edi
    e393:	ba 01 00 00 00       	mov    $0x1,%edx
    e398:	0f 44 ea             	cmove  %edx,%ebp
    e39b:	35 66 61 6c 73       	xor    $0x736c6166,%eax
    e3a0:	0f b7 54 24 54       	movzwl 0x54(%rsp),%edx
    e3a5:	83 f2 65             	xor    $0x65,%edx
    e3a8:	09 c2                	or     %eax,%edx
    e3aa:	75 0c                	jne    e3b8 <tp_value+0xbe8>
    e3ac:	31 ed                	xor    %ebp,%ebp
    e3ae:	eb 10                	jmp    e3c0 <tp_value+0xbf0>
    e3b0:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
    e3b5:	4c 89 fe             	mov    %r15,%rsi
    e3b8:	85 ed                	test   %ebp,%ebp
    e3ba:	0f 88 25 0b 00 00    	js     eee5 <tp_value+0x1715>
    e3c0:	48 8b 46 28          	mov    0x28(%rsi),%rax
    e3c4:	41 89 ee             	mov    %ebp,%r14d
    e3c7:	4e 63 3c b0          	movslq (%rax,%r14,4),%r15
    e3cb:	45 89 fa             	mov    %r15d,%r10d
    e3ce:	4a 8d 3c fd 08 00 00 	lea    0x8(,%r15,8),%rdi
    e3d5:	00 
    e3d6:	48 ff 05 cb da 00 00 	incq   0xdacb(%rip)        # 1bea8 <measured_calls>
    e3dd:	48 01 3d cc da 00 00 	add    %rdi,0xdacc(%rip)        # 1beb0 <measured_bytes>
    e3e4:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    e3eb:	4c 89 54 24 20       	mov    %r10,0x20(%rsp)
    e3f0:	0f 87 1a 03 00 00    	ja     e710 <tp_value+0xf40>
    e3f6:	48 8d 57 0f          	lea    0xf(%rdi),%rdx
    e3fa:	48 c1 ea 04          	shr    $0x4,%rdx
    e3fe:	48 8d 05 83 be 00 00 	lea    0xbe83(%rip),%rax        # 1a288 <fwp_gc>
    e405:	44 0f b6 84 02 e8 0b 	movzbl 0xbe8(%rdx,%rax,1),%r8d
    e40c:	00 00 
    e40e:	42 8b 94 80 48 0b 00 	mov    0xb48(%rax,%r8,4),%edx
    e415:	00 
    e416:	48 29 15 6b be 00 00 	sub    %rdx,0xbe6b(%rip)        # 1a288 <fwp_gc>
    e41d:	0f 88 ed 02 00 00    	js     e710 <tp_value+0xf40>
    e423:	4f 8d 04 40          	lea    (%r8,%r8,2),%r8
    e427:	4e 8d 0c c0          	lea    (%rax,%r8,8),%r9
    e42b:	49 81 c1 88 07 00 00 	add    $0x788,%r9
    e432:	4d 8b 19             	mov    (%r9),%r11
    e435:	4d 85 db             	test   %r11,%r11
    e438:	0f 84 b6 02 00 00    	je     e6f4 <tp_value+0xf24>
    e43e:	48 89 f3             	mov    %rsi,%rbx
    e441:	49 8b 03             	mov    (%r11),%rax
    e444:	48 f7 d0             	not    %rax
    e447:	49 89 01             	mov    %rax,(%r9)
    e44a:	e9 0b 05 00 00       	jmp    e95a <tp_value+0x118a>
    e44f:	48 8d 74 24 50       	lea    0x50(%rsp),%rsi
    e454:	ba 80 00 00 00       	mov    $0x80,%edx
    e459:	4c 89 f7             	mov    %r14,%rdi
    e45c:	e8 0f 19 00 00       	call   fd70 <tp_token>
    e461:	49 89 c4             	mov    %rax,%r12
    e464:	4c 8d 34 04          	lea    (%rsp,%rax,1),%r14
    e468:	49 83 c6 50          	add    $0x50,%r14
    e46c:	31 db                	xor    %ebx,%ebx
    e46e:	eb 0d                	jmp    e47d <tp_value+0xcad>
    e470:	48 ff c3             	inc    %rbx
    e473:	48 83 fb 06          	cmp    $0x6,%rbx
    e477:	0f 84 68 0a 00 00    	je     eee5 <tp_value+0x1715>
    e47d:	49 89 df             	mov    %rbx,%r15
    e480:	49 c1 e7 04          	shl    $0x4,%r15
    e484:	48 8d 05 15 b8 00 00 	lea    0xb815(%rip),%rax        # 19ca0 <tp_value.units>
    e48b:	49 8b 2c 07          	mov    (%r15,%rax,1),%rbp
    e48f:	48 89 ef             	mov    %rbp,%rdi
    e492:	e8 d9 4c ff ff       	call   3170 <strlen@plt>
    e497:	4d 89 e5             	mov    %r12,%r13
    e49a:	49 29 c5             	sub    %rax,%r13
    e49d:	76 d1                	jbe    e470 <tp_value+0xca0>
    e49f:	4c 89 f7             	mov    %r14,%rdi
    e4a2:	48 29 c7             	sub    %rax,%rdi
    e4a5:	48 89 ee             	mov    %rbp,%rsi
    e4a8:	e8 23 4e ff ff       	call   32d0 <strcmp@plt>
    e4ad:	85 c0                	test   %eax,%eax
    e4af:	75 bf                	jne    e470 <tp_value+0xca0>
    e4b1:	48 8d bc 24 50 01 00 	lea    0x150(%rsp),%rdi
    e4b8:	00 
    e4b9:	48 8d 74 24 50       	lea    0x50(%rsp),%rsi
    e4be:	4c 89 ea             	mov    %r13,%rdx
    e4c1:	e8 6a 4e ff ff       	call   3330 <memcpy@plt>
    e4c6:	42 c6 84 2c 50 01 00 	movb   $0x0,0x150(%rsp,%r13,1)
    e4cd:	00 00 
    e4cf:	0f b6 b4 24 50 01 00 	movzbl 0x150(%rsp),%esi
    e4d6:	00 
    e4d7:	8d 46 d5             	lea    -0x2b(%rsi),%eax
    e4da:	31 c9                	xor    %ecx,%ecx
    e4dc:	a8 fd                	test   $0xfd,%al
    e4de:	0f 94 c1             	sete   %cl
    e4e1:	49 39 cd             	cmp    %rcx,%r13
    e4e4:	74 8a                	je     e470 <tp_value+0xca0>
    e4e6:	76 1c                	jbe    e504 <tp_value+0xd34>
    e4e8:	0f b6 94 0c 50 01 00 	movzbl 0x150(%rsp,%rcx,1),%edx
    e4ef:	00 
    e4f0:	80 c2 c6             	add    $0xc6,%dl
    e4f3:	80 fa f6             	cmp    $0xf6,%dl
    e4f6:	0f 82 74 ff ff ff    	jb     e470 <tp_value+0xca0>
    e4fc:	48 ff c1             	inc    %rcx
    e4ff:	49 39 cd             	cmp    %rcx,%r13
    e502:	75 e4                	jne    e4e8 <tp_value+0xd18>
    e504:	31 c9                	xor    %ecx,%ecx
    e506:	a8 fd                	test   $0xfd,%al
    e508:	0f 94 c1             	sete   %cl
    e50b:	44 0f b6 94 0c 50 01 	movzbl 0x150(%rsp,%rcx,1),%r10d
    e512:	00 00 
    e514:	45 31 f6             	xor    %r14d,%r14d
    e517:	45 84 d2             	test   %r10b,%r10b
    e51a:	0f 84 21 06 00 00    	je     eb41 <tp_value+0x1371>
    e520:	48 8d 84 24 50 01 00 	lea    0x150(%rsp),%rax
    e527:	00 
    e528:	48 01 c1             	add    %rax,%rcx
    e52b:	48 ff c1             	inc    %rcx
    e52e:	31 c0                	xor    %eax,%eax
    e530:	bf 0a 00 00 00       	mov    $0xa,%edi
    e535:	49 b9 00 00 00 00 00 	movabs $0x8000000000000000,%r9
    e53c:	00 00 80 
    e53f:	45 31 c0             	xor    %r8d,%r8d
    e542:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    e547:	48 f7 e7             	mul    %rdi
    e54a:	4f 8d 04 80          	lea    (%r8,%r8,4),%r8
    e54e:	4a 8d 14 42          	lea    (%rdx,%r8,2),%rdx
    e552:	45 0f be c2          	movsbl %r10b,%r8d
    e556:	41 83 c0 d0          	add    $0xffffffd0,%r8d
    e55a:	4d 63 d0             	movslq %r8d,%r10
    e55d:	4d 89 d0             	mov    %r10,%r8
    e560:	49 c1 f8 3f          	sar    $0x3f,%r8
    e564:	4c 01 d0             	add    %r10,%rax
    e567:	49 11 d0             	adc    %rdx,%r8
    e56a:	49 39 c1             	cmp    %rax,%r9
    e56d:	ba 00 00 00 00       	mov    $0x0,%edx
    e572:	4c 19 c2             	sbb    %r8,%rdx
    e575:	0f 8c 6a 09 00 00    	jl     eee5 <tp_value+0x1715>
    e57b:	44 0f b6 11          	movzbl (%rcx),%r10d
    e57f:	48 ff c1             	inc    %rcx
    e582:	45 84 d2             	test   %r10b,%r10b
    e585:	75 c0                	jne    e547 <tp_value+0xd77>
    e587:	e9 bf 05 00 00       	jmp    eb4b <tp_value+0x137b>
    e58c:	49 83 c7 05          	add    $0x5,%r15
    e590:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    e594:	48 8d 35 b6 73 00 00 	lea    0x73b6(%rip),%rsi        # 15951 <exec_in_fp0+0xe1>
    e59b:	48 8d 15 79 83 00 00 	lea    0x8379(%rip),%rdx        # 1691b <exec_in_fp0+0x10ab>
    e5a2:	48 8d 0d 87 17 00 00 	lea    0x1787(%rip),%rcx        # fd30 <tp_byte_item>
    e5a9:	4c 8d 44 24 50       	lea    0x50(%rsp),%r8
    e5ae:	e8 7d 15 00 00       	call   fb30 <tp_list_of>
    e5b3:	85 c0                	test   %eax,%eax
    e5b5:	74 77                	je     e62e <tp_value+0xe5e>
    e5b7:	66 0f ef c0          	pxor   %xmm0,%xmm0
    e5bb:	66 0f 7f 84 24 50 01 	movdqa %xmm0,0x150(%rsp)
    e5c2:	00 00 
    e5c4:	48 c7 84 24 60 01 00 	movq   $0x0,0x160(%rsp)
    e5cb:	00 00 00 00 00 
    e5d0:	48 83 7c 24 68 00    	cmpq   $0x0,0x68(%rsp)
    e5d6:	74 36                	je     e60e <tp_value+0xe3e>
    e5d8:	31 db                	xor    %ebx,%ebx
    e5da:	4c 8d b4 24 50 01 00 	lea    0x150(%rsp),%r14
    e5e1:	00 
    e5e2:	4c 8d 7c 24 38       	lea    0x38(%rsp),%r15
    e5e7:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
    e5ec:	0f b6 04 d8          	movzbl (%rax,%rbx,8),%eax
    e5f0:	88 44 24 38          	mov    %al,0x38(%rsp)
    e5f4:	ba 01 00 00 00       	mov    $0x1,%edx
    e5f9:	4c 89 f7             	mov    %r14,%rdi
    e5fc:	4c 89 fe             	mov    %r15,%rsi
    e5ff:	e8 8c ec ff ff       	call   d290 <buf_put>
    e604:	48 ff c3             	inc    %rbx
    e607:	48 3b 5c 24 68       	cmp    0x68(%rsp),%rbx
    e60c:	72 d9                	jb     e5e7 <tp_value+0xe17>
    e60e:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
    e613:	e8 88 c5 ff ff       	call   aba0 <fwp_mem_free>
    e618:	48 8d bc 24 50 01 00 	lea    0x150(%rsp),%rdi
    e61f:	00 
    e620:	e8 5b ed ff ff       	call   d380 <buf_to_str>
    e625:	49 89 04 24          	mov    %rax,(%r12)
    e629:	e9 63 f7 ff ff       	jmp    dd91 <tp_value+0x5c1>
    e62e:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
    e633:	e8 68 c5 ff ff       	call   aba0 <fwp_mem_free>
    e638:	e9 5a f7 ff ff       	jmp    dd97 <tp_value+0x5c7>
    e63d:	f2 0f 10 05 83 6b 00 	movsd  0x6b83(%rip),%xmm0        # 151c8 <_IO_stdin_used+0x1c8>
    e644:	00 
    e645:	83 39 0a             	cmpl   $0xa,(%rcx)
    e648:	f2 0f 5a c8          	cvtsd2ss %xmm0,%xmm1
    e64c:	66 0f 7e c9          	movd   %xmm1,%ecx
    e650:	66 48 0f 7e c0       	movq   %xmm0,%rax
    e655:	48 0f 44 c1          	cmove  %rcx,%rax
    e659:	49 89 04 24          	mov    %rax,(%r12)
    e65d:	e9 2f f7 ff ff       	jmp    dd91 <tp_value+0x5c1>
    e662:	4d 8b 8c ce 90 07 00 	mov    0x790(%r14,%rcx,8),%r9
    e669:	00 
    e66a:	4d 8b 84 ce 98 07 00 	mov    0x798(%r14,%rcx,8),%r8
    e671:	00 
    e672:	4d 29 c8             	sub    %r9,%r8
    e675:	49 39 d0             	cmp    %rdx,%r8
    e678:	0f 83 05 01 00 00    	jae    e783 <tp_value+0xfb3>
    e67e:	48 89 f5             	mov    %rsi,%rbp
    e681:	48 89 fb             	mov    %rdi,%rbx
    e684:	48 89 c7             	mov    %rax,%rdi
    e687:	be 02 00 00 00       	mov    $0x2,%esi
    e68c:	e8 af 9c ff ff       	call   8340 <fwp_gc_alloc_slow>
    e691:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    e696:	4c 8b 25 0b d8 00 00 	mov    0xd80b(%rip),%r12        # 1bea8 <measured_calls>
    e69d:	4c 8b 2d 0c d8 00 00 	mov    0xd80c(%rip),%r13        # 1beb0 <measured_bytes>
    e6a4:	e9 00 01 00 00       	jmp    e7a9 <tp_value+0xfd9>
    e6a9:	48 85 c0             	test   %rax,%rax
    e6ac:	40 0f 95 c6          	setne  %sil
    e6b0:	80 c2 d5             	add    $0xd5,%dl
    e6b3:	f6 c2 fd             	test   $0xfd,%dl
    e6b6:	0f 94 c2             	sete   %dl
    e6b9:	40 20 f2             	and    %sil,%dl
    e6bc:	0f b6 f2             	movzbl %dl,%esi
    e6bf:	41 b0 01             	mov    $0x1,%r8b
    e6c2:	48 89 f7             	mov    %rsi,%rdi
    e6c5:	48 39 f0             	cmp    %rsi,%rax
    e6c8:	0f 86 70 02 00 00    	jbe    e93e <tp_value+0x116e>
    e6ce:	0f b6 54 3c 50       	movzbl 0x50(%rsp,%rdi,1),%edx
    e6d3:	44 8d 4a d0          	lea    -0x30(%rdx),%r9d
    e6d7:	41 80 f9 09          	cmp    $0x9,%r9b
    e6db:	0f 87 0f 05 00 00    	ja     ebf0 <tp_value+0x1420>
    e6e1:	48 ff c7             	inc    %rdi
    e6e4:	48 39 f8             	cmp    %rdi,%rax
    e6e7:	75 e5                	jne    e6ce <tp_value+0xefe>
    e6e9:	48 89 c7             	mov    %rax,%rdi
    e6ec:	48 89 c2             	mov    %rax,%rdx
    e6ef:	e9 fc 07 00 00       	jmp    eef0 <tp_value+0x1720>
    e6f4:	4e 8b 9c c0 90 07 00 	mov    0x790(%rax,%r8,8),%r11
    e6fb:	00 
    e6fc:	4e 8b 8c c0 98 07 00 	mov    0x798(%rax,%r8,8),%r9
    e703:	00 
    e704:	4d 29 d9             	sub    %r11,%r9
    e707:	49 39 d1             	cmp    %rdx,%r9
    e70a:	0f 83 36 02 00 00    	jae    e946 <tp_value+0x1176>
    e710:	48 89 f3             	mov    %rsi,%rbx
    e713:	be 02 00 00 00       	mov    $0x2,%esi
    e718:	e8 23 9c ff ff       	call   8340 <fwp_gc_alloc_slow>
    e71d:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    e722:	e9 42 02 00 00       	jmp    e969 <tp_value+0x1199>
    e727:	48 8d 35 cb 7f 00 00 	lea    0x7fcb(%rip),%rsi        # 166f9 <exec_in_fp0+0xe89>
    e72e:	49 89 ff             	mov    %rdi,%r15
    e731:	e8 5a 13 00 00       	call   fa90 <tp_eat>
    e736:	85 c0                	test   %eax,%eax
    e738:	0f 84 59 f6 ff ff    	je     dd97 <tp_value+0x5c7>
    e73e:	48 8d 35 75 80 00 00 	lea    0x8075(%rip),%rsi        # 167ba <exec_in_fp0+0xf4a>
    e745:	4c 89 ff             	mov    %r15,%rdi
    e748:	e8 43 13 00 00       	call   fa90 <tp_eat>
    e74d:	85 c0                	test   %eax,%eax
    e74f:	0f 84 42 f6 ff ff    	je     dd97 <tp_value+0x5c7>
    e755:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    e75a:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    e761:	e9 2b f6 ff ff       	jmp    dd91 <tp_value+0x5c1>
    e766:	31 ff                	xor    %edi,%edi
    e768:	4c 89 fe             	mov    %r15,%rsi
    e76b:	e8 e0 70 ff ff       	call   5850 <fwp_array_new_packed>
    e770:	49 89 c6             	mov    %rax,%r14
    e773:	e9 46 05 00 00       	jmp    ecbe <tp_value+0x14ee>
    e778:	31 c9                	xor    %ecx,%ecx
    e77a:	49 89 0c 24          	mov    %rcx,(%r12)
    e77e:	e9 0e f6 ff ff       	jmp    dd91 <tp_value+0x5c1>
    e783:	48 89 f5             	mov    %rsi,%rbp
    e786:	48 89 fb             	mov    %rdi,%rbx
    e789:	49 8d 04 ce          	lea    (%r14,%rcx,8),%rax
    e78d:	48 05 90 07 00 00    	add    $0x790,%rax
    e793:	49 8d 0c 11          	lea    (%r9,%rdx,1),%rcx
    e797:	48 89 08             	mov    %rcx,(%rax)
    e79a:	4c 89 4c 24 20       	mov    %r9,0x20(%rsp)
    e79f:	4c 89 cf             	mov    %r9,%rdi
    e7a2:	31 f6                	xor    %esi,%esi
    e7a4:	e8 67 4a ff ff       	call   3210 <memset@plt>
    e7a9:	49 63 07             	movslq (%r15),%rax
    e7ac:	48 8d 50 01          	lea    0x1(%rax),%rdx
    e7b0:	49 ff c4             	inc    %r12
    e7b3:	4c 89 25 ee d6 00 00 	mov    %r12,0xd6ee(%rip)        # 1bea8 <measured_calls>
    e7ba:	4a 8d 0c 28          	lea    (%rax,%r13,1),%rcx
    e7be:	48 ff c1             	inc    %rcx
    e7c1:	48 89 0d e8 d6 00 00 	mov    %rcx,0xd6e8(%rip)        # 1beb0 <measured_bytes>
    e7c8:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    e7cf:	77 5d                	ja     e82e <tp_value+0x105e>
    e7d1:	48 83 c0 10          	add    $0x10,%rax
    e7d5:	48 c1 e8 04          	shr    $0x4,%rax
    e7d9:	42 0f b6 8c 30 e8 0b 	movzbl 0xbe8(%rax,%r14,1),%ecx
    e7e0:	00 00 
    e7e2:	41 8b 84 8e 48 0b 00 	mov    0xb48(%r14,%rcx,4),%eax
    e7e9:	00 
    e7ea:	48 29 05 97 ba 00 00 	sub    %rax,0xba97(%rip)        # 1a288 <fwp_gc>
    e7f1:	78 3b                	js     e82e <tp_value+0x105e>
    e7f3:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    e7f7:	49 8d 34 ce          	lea    (%r14,%rcx,8),%rsi
    e7fb:	48 81 c6 c8 03 00 00 	add    $0x3c8,%rsi
    e802:	4c 8b 26             	mov    (%rsi),%r12
    e805:	4d 85 e4             	test   %r12,%r12
    e808:	74 0c                	je     e816 <tp_value+0x1046>
    e80a:	49 8b 04 24          	mov    (%r12),%rax
    e80e:	48 f7 d0             	not    %rax
    e811:	48 89 06             	mov    %rax,(%rsi)
    e814:	eb 3b                	jmp    e851 <tp_value+0x1081>
    e816:	4d 8b a4 ce d0 03 00 	mov    0x3d0(%r14,%rcx,8),%r12
    e81d:	00 
    e81e:	49 8b b4 ce d8 03 00 	mov    0x3d8(%r14,%rcx,8),%rsi
    e825:	00 
    e826:	4c 29 e6             	sub    %r12,%rsi
    e829:	48 39 c6             	cmp    %rax,%rsi
    e82c:	73 12                	jae    e840 <tp_value+0x1070>
    e82e:	48 89 d7             	mov    %rdx,%rdi
    e831:	be 01 00 00 00       	mov    $0x1,%esi
    e836:	e8 05 9b ff ff       	call   8340 <fwp_gc_alloc_slow>
    e83b:	49 89 c4             	mov    %rax,%r12
    e83e:	eb 1b                	jmp    e85b <tp_value+0x108b>
    e840:	49 8d 0c ce          	lea    (%r14,%rcx,8),%rcx
    e844:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
    e84b:	4c 01 e0             	add    %r12,%rax
    e84e:	48 89 01             	mov    %rax,(%rcx)
    e851:	4c 89 e7             	mov    %r12,%rdi
    e854:	31 f6                	xor    %esi,%esi
    e856:	e8 b5 49 ff ff       	call   3210 <memset@plt>
    e85b:	49 63 17             	movslq (%r15),%rdx
    e85e:	48 ff c2             	inc    %rdx
    e861:	45 31 f6             	xor    %r14d,%r14d
    e864:	4c 89 e7             	mov    %r12,%rdi
    e867:	31 f6                	xor    %esi,%esi
    e869:	e8 a2 49 ff ff       	call   3210 <memset@plt>
    e86e:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    e872:	48 8b 43 10          	mov    0x10(%rbx),%rax
    e876:	48 39 c8             	cmp    %rcx,%rax
    e879:	73 2e                	jae    e8a9 <tp_value+0x10d9>
    e87b:	48 8b 13             	mov    (%rbx),%rdx
    e87e:	48 be 00 26 00 00 01 	movabs $0x100002600,%rsi
    e885:	00 00 00 
    e888:	0f b6 3c 02          	movzbl (%rdx,%rax,1),%edi
    e88c:	48 83 ff 20          	cmp    $0x20,%rdi
    e890:	77 17                	ja     e8a9 <tp_value+0x10d9>
    e892:	48 0f a3 fe          	bt     %rdi,%rsi
    e896:	73 11                	jae    e8a9 <tp_value+0x10d9>
    e898:	48 ff c0             	inc    %rax
    e89b:	48 89 43 10          	mov    %rax,0x10(%rbx)
    e89f:	48 39 c1             	cmp    %rax,%rcx
    e8a2:	75 e4                	jne    e888 <tp_value+0x10b8>
    e8a4:	e9 ee f4 ff ff       	jmp    dd97 <tp_value+0x5c7>
    e8a9:	48 39 c1             	cmp    %rax,%rcx
    e8ac:	0f 84 e5 f4 ff ff    	je     dd97 <tp_value+0x5c7>
    e8b2:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
    e8b7:	48 8b 0b             	mov    (%rbx),%rcx
    e8ba:	80 3c 01 7b          	cmpb   $0x7b,(%rcx,%rax,1)
    e8be:	0f 85 d3 f4 ff ff    	jne    dd97 <tp_value+0x5c7>
    e8c4:	48 ff c0             	inc    %rax
    e8c7:	48 89 43 10          	mov    %rax,0x10(%rbx)
    e8cb:	48 8d 35 10 71 00 00 	lea    0x7110(%rip),%rsi        # 159e2 <exec_in_fp0+0x172>
    e8d2:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
    e8d7:	48 89 df             	mov    %rbx,%rdi
    e8da:	e8 b1 11 00 00       	call   fa90 <tp_eat>
    e8df:	85 c0                	test   %eax,%eax
    e8e1:	0f 84 e0 03 00 00    	je     ecc7 <tp_value+0x14f7>
    e8e7:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    e8ec:	8b 38                	mov    (%rax),%edi
    e8ee:	85 ff                	test   %edi,%edi
    e8f0:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
    e8f5:	48 8b 74 24 20       	mov    0x20(%rsp),%rsi
    e8fa:	7e 18                	jle    e914 <tp_value+0x1144>
    e8fc:	45 31 f6             	xor    %r14d,%r14d
    e8ff:	31 c0                	xor    %eax,%eax
    e901:	41 80 3c 04 00       	cmpb   $0x0,(%r12,%rax,1)
    e906:	0f 84 8b f4 ff ff    	je     dd97 <tp_value+0x5c7>
    e90c:	48 ff c0             	inc    %rax
    e90f:	48 39 c7             	cmp    %rax,%rdi
    e912:	75 ed                	jne    e901 <tp_value+0x1131>
    e914:	e8 17 19 00 00       	call   10230 <fwp_record>
    e919:	48 89 03             	mov    %rax,(%rbx)
    e91c:	e9 70 f4 ff ff       	jmp    dd91 <tp_value+0x5c1>
    e921:	48 8d 05 e8 d5 01 00 	lea    0x1d5e8(%rip),%rax        # 2bf10 <fwp_empty_map>
    e928:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
    e92d:	48 89 c3             	mov    %rax,%rbx
    e930:	e8 6b c2 ff ff       	call   aba0 <fwp_mem_free>
    e935:	49 89 1c 24          	mov    %rbx,(%r12)
    e939:	e9 53 f4 ff ff       	jmp    dd91 <tp_value+0x5c1>
    e93e:	48 89 f2             	mov    %rsi,%rdx
    e941:	e9 aa 05 00 00       	jmp    eef0 <tp_value+0x1720>
    e946:	48 89 f3             	mov    %rsi,%rbx
    e949:	4a 8d 04 c0          	lea    (%rax,%r8,8),%rax
    e94d:	48 05 90 07 00 00    	add    $0x790,%rax
    e953:	49 8d 0c 13          	lea    (%r11,%rdx,1),%rcx
    e957:	48 89 08             	mov    %rcx,(%rax)
    e95a:	4c 89 5c 24 08       	mov    %r11,0x8(%rsp)
    e95f:	4c 89 df             	mov    %r11,%rdi
    e962:	31 f6                	xor    %esi,%esi
    e964:	e8 a7 48 ff ff       	call   3210 <memset@plt>
    e969:	4c 89 7c 24 28       	mov    %r15,0x28(%rsp)
    e96e:	45 85 ff             	test   %r15d,%r15d
    e971:	0f 8e 60 01 00 00    	jle    ead7 <tp_value+0x1307>
    e977:	48 89 d8             	mov    %rbx,%rax
    e97a:	31 db                	xor    %ebx,%ebx
    e97c:	49 bf 00 26 00 00 01 	movabs $0x100002600,%r15
    e983:	00 00 00 
    e986:	4c 89 74 24 30       	mov    %r14,0x30(%rsp)
    e98b:	48 8b 48 30          	mov    0x30(%rax),%rcx
    e98f:	4a 8b 0c f1          	mov    (%rcx,%r14,8),%rcx
    e993:	48 8b 34 d9          	mov    (%rcx,%rbx,8),%rsi
    e997:	49 8b 7d 08          	mov    0x8(%r13),%rdi
    e99b:	49 8b 55 10          	mov    0x10(%r13),%rdx
    e99f:	48 39 fa             	cmp    %rdi,%rdx
    e9a2:	73 2c                	jae    e9d0 <tp_value+0x1200>
    e9a4:	49 8b 4d 00          	mov    0x0(%r13),%rcx
    e9a8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    e9af:	00 
    e9b0:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    e9b5:	49 83 f8 20          	cmp    $0x20,%r8
    e9b9:	77 15                	ja     e9d0 <tp_value+0x1200>
    e9bb:	4d 0f a3 c7          	bt     %r8,%r15
    e9bf:	73 0f                	jae    e9d0 <tp_value+0x1200>
    e9c1:	48 ff c2             	inc    %rdx
    e9c4:	49 89 55 10          	mov    %rdx,0x10(%r13)
    e9c8:	48 39 d7             	cmp    %rdx,%rdi
    e9cb:	75 e3                	jne    e9b0 <tp_value+0x11e0>
    e9cd:	48 89 fa             	mov    %rdi,%rdx
    e9d0:	83 3e 10             	cmpl   $0x10,(%rsi)
    e9d3:	75 0b                	jne    e9e0 <tp_value+0x1210>
    e9d5:	48 83 7e 08 00       	cmpq   $0x0,0x8(%rsi)
    e9da:	0f 84 b4 00 00 00    	je     ea94 <tp_value+0x12c4>
    e9e0:	45 31 c0             	xor    %r8d,%r8d
    e9e3:	49 89 c4             	mov    %rax,%r12
    e9e6:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    e9eb:	48 8d 0c d8          	lea    (%rax,%rbx,8),%rcx
    e9ef:	48 39 fa             	cmp    %rdi,%rdx
    e9f2:	73 10                	jae    ea04 <tp_value+0x1234>
    e9f4:	49 8b 45 00          	mov    0x0(%r13),%rax
    e9f8:	80 3c 10 28          	cmpb   $0x28,(%rax,%rdx,1)
    e9fc:	0f 95 c0             	setne  %al
    e9ff:	44 08 c0             	or     %r8b,%al
    ea02:	74 35                	je     ea39 <tp_value+0x1269>
    ea04:	45 31 f6             	xor    %r14d,%r14d
    ea07:	4c 89 ef             	mov    %r13,%rdi
    ea0a:	31 d2                	xor    %edx,%edx
    ea0c:	e8 bf ed ff ff       	call   d7d0 <tp_value>
    ea11:	85 c0                	test   %eax,%eax
    ea13:	4c 89 e0             	mov    %r12,%rax
    ea16:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    ea1b:	0f 84 76 f3 ff ff    	je     dd97 <tp_value+0x5c7>
    ea21:	48 ff c3             	inc    %rbx
    ea24:	48 3b 5c 24 20       	cmp    0x20(%rsp),%rbx
    ea29:	4c 8b 74 24 30       	mov    0x30(%rsp),%r14
    ea2e:	0f 85 57 ff ff ff    	jne    e98b <tp_value+0x11bb>
    ea34:	e9 9e 00 00 00       	jmp    ead7 <tp_value+0x1307>
    ea39:	48 ff c2             	inc    %rdx
    ea3c:	49 89 55 10          	mov    %rdx,0x10(%r13)
    ea40:	45 31 f6             	xor    %r14d,%r14d
    ea43:	4c 89 ef             	mov    %r13,%rdi
    ea46:	31 d2                	xor    %edx,%edx
    ea48:	e8 83 ed ff ff       	call   d7d0 <tp_value>
    ea4d:	85 c0                	test   %eax,%eax
    ea4f:	0f 84 42 f3 ff ff    	je     dd97 <tp_value+0x5c7>
    ea55:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
    ea5a:	49 8b 55 08          	mov    0x8(%r13),%rdx
    ea5e:	49 8b 4d 10          	mov    0x10(%r13),%rcx
    ea62:	48 39 d1             	cmp    %rdx,%rcx
    ea65:	4c 89 e0             	mov    %r12,%rax
    ea68:	73 3d                	jae    eaa7 <tp_value+0x12d7>
    ea6a:	49 8b 75 00          	mov    0x0(%r13),%rsi
    ea6e:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    ea73:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
    ea77:	48 83 ff 20          	cmp    $0x20,%rdi
    ea7b:	77 2f                	ja     eaac <tp_value+0x12dc>
    ea7d:	49 0f a3 ff          	bt     %rdi,%r15
    ea81:	73 29                	jae    eaac <tp_value+0x12dc>
    ea83:	48 ff c1             	inc    %rcx
    ea86:	49 89 4d 10          	mov    %rcx,0x10(%r13)
    ea8a:	48 39 ca             	cmp    %rcx,%rdx
    ea8d:	75 e4                	jne    ea73 <tp_value+0x12a3>
    ea8f:	e9 03 f3 ff ff       	jmp    dd97 <tp_value+0x5c7>
    ea94:	83 7e 10 00          	cmpl   $0x0,0x10(%rsi)
    ea98:	74 35                	je     eacf <tp_value+0x12ff>
    ea9a:	83 7e 48 00          	cmpl   $0x0,0x48(%rsi)
    ea9e:	41 0f 95 c0          	setne  %r8b
    eaa2:	e9 3c ff ff ff       	jmp    e9e3 <tp_value+0x1213>
    eaa7:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    eaac:	48 39 ca             	cmp    %rcx,%rdx
    eaaf:	0f 84 e2 f2 ff ff    	je     dd97 <tp_value+0x5c7>
    eab5:	49 8b 55 00          	mov    0x0(%r13),%rdx
    eab9:	80 3c 0a 29          	cmpb   $0x29,(%rdx,%rcx,1)
    eabd:	0f 85 d4 f2 ff ff    	jne    dd97 <tp_value+0x5c7>
    eac3:	48 ff c1             	inc    %rcx
    eac6:	49 89 4d 10          	mov    %rcx,0x10(%r13)
    eaca:	e9 52 ff ff ff       	jmp    ea21 <tp_value+0x1251>
    eacf:	41 b0 01             	mov    $0x1,%r8b
    ead2:	e9 0c ff ff ff       	jmp    e9e3 <tp_value+0x1213>
    ead7:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
    eadc:	45 85 ff             	test   %r15d,%r15d
    eadf:	0f 84 d9 01 00 00    	je     ecbe <tp_value+0x14ee>
    eae5:	48 8b 5c 24 20       	mov    0x20(%rsp),%rbx
    eaea:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    eaf1:	00 
    eaf2:	e8 69 bd ff ff       	call   a860 <fwp_alloc_init>
    eaf7:	49 89 c6             	mov    %rax,%r14
    eafa:	89 28                	mov    %ebp,(%rax)
    eafc:	44 89 78 04          	mov    %r15d,0x4(%rax)
    eb00:	41 83 ff 08          	cmp    $0x8,%r15d
    eb04:	73 1b                	jae    eb21 <tp_value+0x1351>
    eb06:	31 c0                	xor    %eax,%eax
    eb08:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    eb0d:	e9 53 01 00 00       	jmp    ec65 <tp_value+0x1495>
    eb12:	4d 01 fd             	add    %r15,%r13
    eb15:	4c 89 f7             	mov    %r14,%rdi
    eb18:	4d 89 6e 10          	mov    %r13,0x10(%r14)
    eb1c:	e9 9c f4 ff ff       	jmp    dfbd <tp_value+0x7ed>
    eb21:	4c 89 f0             	mov    %r14,%rax
    eb24:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    eb29:	48 29 f8             	sub    %rdi,%rax
    eb2c:	48 83 c0 08          	add    $0x8,%rax
    eb30:	48 83 f8 20          	cmp    $0x20,%rax
    eb34:	0f 83 f3 00 00 00    	jae    ec2d <tp_value+0x145d>
    eb3a:	31 c0                	xor    %eax,%eax
    eb3c:	e9 24 01 00 00       	jmp    ec65 <tp_value+0x1495>
    eb41:	31 c0                	xor    %eax,%eax
    eb43:	45 31 c0             	xor    %r8d,%r8d
    eb46:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    eb4b:	48 89 c1             	mov    %rax,%rcx
    eb4e:	48 f7 d9             	neg    %rcx
    eb51:	bf 00 00 00 00       	mov    $0x0,%edi
    eb56:	4c 19 c7             	sbb    %r8,%rdi
    eb59:	40 80 fe 2d          	cmp    $0x2d,%sil
    eb5d:	49 0f 45 f8          	cmovne %r8,%rdi
    eb61:	48 0f 45 c8          	cmovne %rax,%rcx
    eb65:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    eb6c:	ff ff 7f 
    eb6f:	48 39 c8             	cmp    %rcx,%rax
    eb72:	b8 00 00 00 00       	mov    $0x0,%eax
    eb77:	48 19 f8             	sbb    %rdi,%rax
    eb7a:	0f 8c 17 f2 ff ff    	jl     dd97 <tp_value+0x5c7>
    eb80:	48 8d 05 19 b1 00 00 	lea    0xb119(%rip),%rax        # 19ca0 <tp_value.units>
    eb87:	49 8b 74 07 08       	mov    0x8(%r15,%rax,1),%rsi
    eb8c:	48 89 c8             	mov    %rcx,%rax
    eb8f:	48 f7 e6             	mul    %rsi
    eb92:	48 0f af fe          	imul   %rsi,%rdi
    eb96:	48 c1 fe 3f          	sar    $0x3f,%rsi
    eb9a:	48 0f af f1          	imul   %rcx,%rsi
    eb9e:	48 01 d7             	add    %rdx,%rdi
    eba1:	48 01 f7             	add    %rsi,%rdi
    eba4:	48 b9 00 00 00 00 00 	movabs $0x8000000000000000,%rcx
    ebab:	00 00 80 
    ebae:	48 01 c1             	add    %rax,%rcx
    ebb1:	48 83 d7 ff          	adc    $0xffffffffffffffff,%rdi
    ebb5:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
    ebb9:	0f 85 d8 f1 ff ff    	jne    dd97 <tp_value+0x5c7>
    ebbf:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    ebc4:	bf 10 00 00 00       	mov    $0x10,%edi
    ebc9:	48 89 c3             	mov    %rax,%rbx
    ebcc:	e8 8f bc ff ff       	call   a860 <fwp_alloc_init>
    ebd1:	48 b9 00 00 00 00 01 	movabs $0x100000000,%rcx
    ebd8:	00 00 00 
    ebdb:	48 89 08             	mov    %rcx,(%rax)
    ebde:	48 89 58 08          	mov    %rbx,0x8(%rax)
    ebe2:	48 8d 4c 24 38       	lea    0x38(%rsp),%rcx
    ebe7:	49 89 04 24          	mov    %rax,(%r12)
    ebeb:	e9 a1 f1 ff ff       	jmp    dd91 <tp_value+0x5c1>
    ebf0:	80 fa 2e             	cmp    $0x2e,%dl
    ebf3:	0f 85 f4 02 00 00    	jne    eeed <tp_value+0x171d>
    ebf9:	48 8d 57 01          	lea    0x1(%rdi),%rdx
    ebfd:	48 39 c2             	cmp    %rax,%rdx
    ec00:	73 1b                	jae    ec1d <tp_value+0x144d>
    ec02:	44 0f b6 44 14 50    	movzbl 0x50(%rsp,%rdx,1),%r8d
    ec08:	41 80 c0 d0          	add    $0xd0,%r8b
    ec0c:	41 80 f8 09          	cmp    $0x9,%r8b
    ec10:	77 0b                	ja     ec1d <tp_value+0x144d>
    ec12:	48 ff c2             	inc    %rdx
    ec15:	48 39 c2             	cmp    %rax,%rdx
    ec18:	72 e8                	jb     ec02 <tp_value+0x1432>
    ec1a:	48 89 c2             	mov    %rax,%rdx
    ec1d:	4c 8d 42 ff          	lea    -0x1(%rdx),%r8
    ec21:	49 39 f8             	cmp    %rdi,%r8
    ec24:	41 0f 94 c0          	sete   %r8b
    ec28:	e9 c3 02 00 00       	jmp    eef0 <tp_value+0x1720>
    ec2d:	89 d8                	mov    %ebx,%eax
    ec2f:	83 e0 fc             	and    $0xfffffffc,%eax
    ec32:	48 8d 0c dd 00 00 00 	lea    0x0(,%rbx,8),%rcx
    ec39:	00 
    ec3a:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    ec3e:	31 d2                	xor    %edx,%edx
    ec40:	f3 0f 6f 04 17       	movdqu (%rdi,%rdx,1),%xmm0
    ec45:	0f 10 4c 17 10       	movups 0x10(%rdi,%rdx,1),%xmm1
    ec4a:	f3 41 0f 7f 44 16 08 	movdqu %xmm0,0x8(%r14,%rdx,1)
    ec51:	41 0f 11 4c 16 18    	movups %xmm1,0x18(%r14,%rdx,1)
    ec57:	48 83 c2 20          	add    $0x20,%rdx
    ec5b:	48 39 d1             	cmp    %rdx,%rcx
    ec5e:	75 e0                	jne    ec40 <tp_value+0x1470>
    ec60:	48 39 d8             	cmp    %rbx,%rax
    ec63:	74 59                	je     ecbe <tp_value+0x14ee>
    ec65:	48 89 da             	mov    %rbx,%rdx
    ec68:	48 89 c1             	mov    %rax,%rcx
    ec6b:	48 83 e2 03          	and    $0x3,%rdx
    ec6f:	74 14                	je     ec85 <tp_value+0x14b5>
    ec71:	48 89 c1             	mov    %rax,%rcx
    ec74:	48 8b 34 cf          	mov    (%rdi,%rcx,8),%rsi
    ec78:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    ec7d:	48 ff c1             	inc    %rcx
    ec80:	48 ff ca             	dec    %rdx
    ec83:	75 ef                	jne    ec74 <tp_value+0x14a4>
    ec85:	48 29 d8             	sub    %rbx,%rax
    ec88:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    ec8c:	77 30                	ja     ecbe <tp_value+0x14ee>
    ec8e:	48 8b 04 cf          	mov    (%rdi,%rcx,8),%rax
    ec92:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    ec97:	48 8b 44 cf 08       	mov    0x8(%rdi,%rcx,8),%rax
    ec9c:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    eca1:	48 8b 44 cf 10       	mov    0x10(%rdi,%rcx,8),%rax
    eca6:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    ecab:	48 8b 44 cf 18       	mov    0x18(%rdi,%rcx,8),%rax
    ecb0:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    ecb5:	48 83 c1 04          	add    $0x4,%rcx
    ecb9:	48 39 cb             	cmp    %rcx,%rbx
    ecbc:	75 d0                	jne    ec8e <tp_value+0x14be>
    ecbe:	4d 89 34 24          	mov    %r14,(%r12)
    ecc2:	e9 ca f0 ff ff       	jmp    dd91 <tp_value+0x5c1>
    ecc7:	4c 89 64 24 40       	mov    %r12,0x40(%rsp)
    eccc:	49 bf 00 26 00 00 01 	movabs $0x100002600,%r15
    ecd3:	00 00 00 
    ecd6:	41 b8 ff 00 00 00    	mov    $0xff,%r8d
    ecdc:	4c 8d 4c 24 50       	lea    0x50(%rsp),%r9
    ece1:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    ece6:	48 89 6c 24 48       	mov    %rbp,0x48(%rsp)
    eceb:	4c 8b 21             	mov    (%rcx),%r12
    ecee:	4c 8b 69 08          	mov    0x8(%rcx),%r13
    ecf2:	48 8b 71 10          	mov    0x10(%rcx),%rsi
    ecf6:	4c 39 ee             	cmp    %r13,%rsi
    ecf9:	73 2a                	jae    ed25 <tp_value+0x1555>
    ecfb:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
    ed00:	41 0f b6 04 34       	movzbl (%r12,%rsi,1),%eax
    ed05:	48 83 f8 20          	cmp    $0x20,%rax
    ed09:	77 1f                	ja     ed2a <tp_value+0x155a>
    ed0b:	49 0f a3 c7          	bt     %rax,%r15
    ed0f:	73 19                	jae    ed2a <tp_value+0x155a>
    ed11:	48 ff c6             	inc    %rsi
    ed14:	48 89 71 10          	mov    %rsi,0x10(%rcx)
    ed18:	49 39 f5             	cmp    %rsi,%r13
    ed1b:	75 e3                	jne    ed00 <tp_value+0x1530>
    ed1d:	4c 89 eb             	mov    %r13,%rbx
    ed20:	4c 89 ee             	mov    %r13,%rsi
    ed23:	eb 55                	jmp    ed7a <tp_value+0x15aa>
    ed25:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
    ed2a:	48 bf 03 00 00 00 00 	movabs $0x4000000000003,%rdi
    ed31:	00 04 00 
    ed34:	48 89 f3             	mov    %rsi,%rbx
    ed37:	4c 39 ee             	cmp    %r13,%rsi
    ed3a:	72 0e                	jb     ed4a <tp_value+0x157a>
    ed3c:	eb 3c                	jmp    ed7a <tp_value+0x15aa>
    ed3e:	48 ff c3             	inc    %rbx
    ed41:	48 89 59 10          	mov    %rbx,0x10(%rcx)
    ed45:	49 39 dd             	cmp    %rbx,%r13
    ed48:	74 2d                	je     ed77 <tp_value+0x15a7>
    ed4a:	41 0f b6 04 1c       	movzbl (%r12,%rbx,1),%eax
    ed4f:	8d 50 d0             	lea    -0x30(%rax),%edx
    ed52:	80 fa 0a             	cmp    $0xa,%dl
    ed55:	72 e7                	jb     ed3e <tp_value+0x156e>
    ed57:	89 c2                	mov    %eax,%edx
    ed59:	80 e2 df             	and    $0xdf,%dl
    ed5c:	80 c2 bf             	add    $0xbf,%dl
    ed5f:	80 fa 1a             	cmp    $0x1a,%dl
    ed62:	72 da                	jb     ed3e <tp_value+0x156e>
    ed64:	0f b6 c0             	movzbl %al,%eax
    ed67:	83 c0 d3             	add    $0xffffffd3,%eax
    ed6a:	83 f8 32             	cmp    $0x32,%eax
    ed6d:	77 0b                	ja     ed7a <tp_value+0x15aa>
    ed6f:	48 0f a3 c7          	bt     %rax,%rdi
    ed73:	72 c9                	jb     ed3e <tp_value+0x156e>
    ed75:	eb 03                	jmp    ed7a <tp_value+0x15aa>
    ed77:	4c 89 eb             	mov    %r13,%rbx
    ed7a:	48 89 dd             	mov    %rbx,%rbp
    ed7d:	48 29 f5             	sub    %rsi,%rbp
    ed80:	48 81 fd ff 00 00 00 	cmp    $0xff,%rbp
    ed87:	49 0f 43 e8          	cmovae %r8,%rbp
    ed8b:	4c 01 e6             	add    %r12,%rsi
    ed8e:	4c 89 cf             	mov    %r9,%rdi
    ed91:	48 89 ea             	mov    %rbp,%rdx
    ed94:	e8 97 45 ff ff       	call   3330 <memcpy@plt>
    ed99:	c6 44 2c 50 00       	movb   $0x0,0x50(%rsp,%rbp,1)
    ed9e:	45 8b 3e             	mov    (%r14),%r15d
    eda1:	45 85 ff             	test   %r15d,%r15d
    eda4:	48 8b 44 24 48       	mov    0x48(%rsp),%rax
    eda9:	0f 8e 36 01 00 00    	jle    eee5 <tp_value+0x1715>
    edaf:	4c 89 6c 24 28       	mov    %r13,0x28(%rsp)
    edb4:	4c 89 64 24 30       	mov    %r12,0x30(%rsp)
    edb9:	4c 8b 60 18          	mov    0x18(%rax),%r12
    edbd:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    edc2:	45 31 f6             	xor    %r14d,%r14d
    edc5:	4c 8d 6c 24 50       	lea    0x50(%rsp),%r13
    edca:	4b 8b 3c f4          	mov    (%r12,%r14,8),%rdi
    edce:	4c 89 ee             	mov    %r13,%rsi
    edd1:	e8 fa 44 ff ff       	call   32d0 <strcmp@plt>
    edd6:	85 c0                	test   %eax,%eax
    edd8:	41 0f 44 ee          	cmove  %r14d,%ebp
    eddc:	49 ff c6             	inc    %r14
    eddf:	4d 39 f7             	cmp    %r14,%r15
    ede2:	75 e6                	jne    edca <tp_value+0x15fa>
    ede4:	85 ed                	test   %ebp,%ebp
    ede6:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    edeb:	48 8b 44 24 48       	mov    0x48(%rsp),%rax
    edf0:	49 bf 00 26 00 00 01 	movabs $0x100002600,%r15
    edf7:	00 00 00 
    edfa:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    edff:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
    ee04:	0f 88 db 00 00 00    	js     eee5 <tp_value+0x1715>
    ee0a:	48 39 fb             	cmp    %rdi,%rbx
    ee0d:	73 21                	jae    ee30 <tp_value+0x1660>
    ee0f:	0f b6 14 1e          	movzbl (%rsi,%rbx,1),%edx
    ee13:	48 83 fa 20          	cmp    $0x20,%rdx
    ee17:	77 17                	ja     ee30 <tp_value+0x1660>
    ee19:	49 0f a3 d7          	bt     %rdx,%r15
    ee1d:	73 11                	jae    ee30 <tp_value+0x1660>
    ee1f:	48 ff c3             	inc    %rbx
    ee22:	48 89 59 10          	mov    %rbx,0x10(%rcx)
    ee26:	48 39 df             	cmp    %rbx,%rdi
    ee29:	75 e4                	jne    ee0f <tp_value+0x163f>
    ee2b:	e9 b5 00 00 00       	jmp    eee5 <tp_value+0x1715>
    ee30:	48 39 df             	cmp    %rbx,%rdi
    ee33:	0f 84 ac 00 00 00    	je     eee5 <tp_value+0x1715>
    ee39:	80 3c 1e 3d          	cmpb   $0x3d,(%rsi,%rbx,1)
    ee3d:	0f 85 a2 00 00 00    	jne    eee5 <tp_value+0x1715>
    ee43:	48 ff c3             	inc    %rbx
    ee46:	48 89 59 10          	mov    %rbx,0x10(%rcx)
    ee4a:	48 8b 40 20          	mov    0x20(%rax),%rax
    ee4e:	89 eb                	mov    %ebp,%ebx
    ee50:	48 8b 34 d8          	mov    (%rax,%rbx,8),%rsi
    ee54:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    ee59:	48 8d 0c d8          	lea    (%rax,%rbx,8),%rcx
    ee5d:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    ee62:	31 d2                	xor    %edx,%edx
    ee64:	e8 67 e9 ff ff       	call   d7d0 <tp_value>
    ee69:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    ee6e:	85 c0                	test   %eax,%eax
    ee70:	74 73                	je     eee5 <tp_value+0x1715>
    ee72:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
    ee77:	c6 04 18 01          	movb   $0x1,(%rax,%rbx,1)
    ee7b:	48 8b 51 08          	mov    0x8(%rcx),%rdx
    ee7f:	48 8b 41 10          	mov    0x10(%rcx),%rax
    ee83:	48 39 d0             	cmp    %rdx,%rax
    ee86:	73 21                	jae    eea9 <tp_value+0x16d9>
    ee88:	48 8b 31             	mov    (%rcx),%rsi
    ee8b:	0f b6 3c 06          	movzbl (%rsi,%rax,1),%edi
    ee8f:	48 83 ff 20          	cmp    $0x20,%rdi
    ee93:	77 14                	ja     eea9 <tp_value+0x16d9>
    ee95:	49 0f a3 ff          	bt     %rdi,%r15
    ee99:	73 0e                	jae    eea9 <tp_value+0x16d9>
    ee9b:	48 ff c0             	inc    %rax
    ee9e:	48 89 41 10          	mov    %rax,0x10(%rcx)
    eea2:	48 39 c2             	cmp    %rax,%rdx
    eea5:	75 e4                	jne    ee8b <tp_value+0x16bb>
    eea7:	eb 12                	jmp    eebb <tp_value+0x16eb>
    eea9:	48 39 c2             	cmp    %rax,%rdx
    eeac:	74 0d                	je     eebb <tp_value+0x16eb>
    eeae:	48 8b 11             	mov    (%rcx),%rdx
    eeb1:	80 3c 02 7d          	cmpb   $0x7d,(%rdx,%rax,1)
    eeb5:	0f 84 db 00 00 00    	je     ef96 <tp_value+0x17c6>
    eebb:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    eec0:	48 8d 35 34 78 00 00 	lea    0x7834(%rip),%rsi        # 166fb <exec_in_fp0+0xe8b>
    eec7:	e8 c4 0b 00 00       	call   fa90 <tp_eat>
    eecc:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    eed1:	85 c0                	test   %eax,%eax
    eed3:	74 10                	je     eee5 <tp_value+0x1715>
    eed5:	41 b8 ff 00 00 00    	mov    $0xff,%r8d
    eedb:	4c 8d 4c 24 50       	lea    0x50(%rsp),%r9
    eee0:	e9 06 fe ff ff       	jmp    eceb <tp_value+0x151b>
    eee5:	45 31 f6             	xor    %r14d,%r14d
    eee8:	e9 aa ee ff ff       	jmp    dd97 <tp_value+0x5c7>
    eeed:	48 89 fa             	mov    %rdi,%rdx
    eef0:	48 39 f7             	cmp    %rsi,%rdi
    eef3:	75 09                	jne    eefe <tp_value+0x172e>
    eef5:	45 84 c0             	test   %r8b,%r8b
    eef8:	0f 85 99 ee ff ff    	jne    dd97 <tp_value+0x5c7>
    eefe:	48 39 c2             	cmp    %rax,%rdx
    ef01:	73 5b                	jae    ef5e <tp_value+0x178e>
    ef03:	0f b6 74 14 50       	movzbl 0x50(%rsp,%rdx,1),%esi
    ef08:	83 ce 20             	or     $0x20,%esi
    ef0b:	83 fe 65             	cmp    $0x65,%esi
    ef0e:	75 4e                	jne    ef5e <tp_value+0x178e>
    ef10:	48 8d 72 01          	lea    0x1(%rdx),%rsi
    ef14:	48 39 c6             	cmp    %rax,%rsi
    ef17:	73 16                	jae    ef2f <tp_value+0x175f>
    ef19:	0f b6 7c 34 50       	movzbl 0x50(%rsp,%rsi,1),%edi
    ef1e:	83 ff 2d             	cmp    $0x2d,%edi
    ef21:	74 05                	je     ef28 <tp_value+0x1758>
    ef23:	83 ff 2b             	cmp    $0x2b,%edi
    ef26:	75 07                	jne    ef2f <tp_value+0x175f>
    ef28:	48 83 c2 02          	add    $0x2,%rdx
    ef2c:	48 89 d6             	mov    %rdx,%rsi
    ef2f:	48 39 c6             	cmp    %rax,%rsi
    ef32:	0f 83 5f ee ff ff    	jae    dd97 <tp_value+0x5c7>
    ef38:	48 89 f2             	mov    %rsi,%rdx
    ef3b:	0f b6 7c 14 50       	movzbl 0x50(%rsp,%rdx,1),%edi
    ef40:	40 80 c7 d0          	add    $0xd0,%dil
    ef44:	40 80 ff 09          	cmp    $0x9,%dil
    ef48:	77 0b                	ja     ef55 <tp_value+0x1785>
    ef4a:	48 ff c2             	inc    %rdx
    ef4d:	48 39 d0             	cmp    %rdx,%rax
    ef50:	75 e9                	jne    ef3b <tp_value+0x176b>
    ef52:	48 89 c2             	mov    %rax,%rdx
    ef55:	48 39 f2             	cmp    %rsi,%rdx
    ef58:	0f 84 39 ee ff ff    	je     dd97 <tp_value+0x5c7>
    ef5e:	48 39 c2             	cmp    %rax,%rdx
    ef61:	0f 85 30 ee ff ff    	jne    dd97 <tp_value+0x5c7>
    ef67:	83 39 0a             	cmpl   $0xa,(%rcx)
    ef6a:	75 19                	jne    ef85 <tp_value+0x17b5>
    ef6c:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    ef71:	31 f6                	xor    %esi,%esi
    ef73:	e8 88 42 ff ff       	call   3200 <strtof@plt>
    ef78:	66 0f 7e c0          	movd   %xmm0,%eax
    ef7c:	49 89 04 24          	mov    %rax,(%r12)
    ef80:	e9 0c ee ff ff       	jmp    dd91 <tp_value+0x5c1>
    ef85:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    ef8a:	31 f6                	xor    %esi,%esi
    ef8c:	e8 6f 41 ff ff       	call   3100 <strtod@plt>
    ef91:	e9 b2 ed ff ff       	jmp    dd48 <tp_value+0x578>
    ef96:	48 ff c0             	inc    %rax
    ef99:	48 89 41 10          	mov    %rax,0x10(%rcx)
    ef9d:	4c 8b 64 24 40       	mov    0x40(%rsp),%r12
    efa2:	e9 40 f9 ff ff       	jmp    e8e7 <tp_value+0x1117>
    efa7:	e8 b4 7c ff ff       	call   6c60 <fwp_flush>
    efac:	48 8b 05 25 b0 00 00 	mov    0xb025(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
    efb3:	48 8b 38             	mov    (%rax),%rdi
    efb6:	48 8d 35 f1 6a 00 00 	lea    0x6af1(%rip),%rsi        # 15aae <exec_in_fp0+0x23e>
    efbd:	48 8d 15 32 7a 00 00 	lea    0x7a32(%rip),%rdx        # 169f6 <exec_in_fp0+0x1186>
    efc4:	31 c0                	xor    %eax,%eax
    efc6:	e8 25 43 ff ff       	call   32f0 <fprintf@plt>
    efcb:	bf 65 00 00 00       	mov    $0x65,%edi
    efd0:	e8 8b 44 ff ff       	call   3460 <exit@plt>
    efd5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    efdc:	00 00 00 00 

000000000000efe0 <tp_int>:
    efe0:	55                   	push   %rbp
    efe1:	41 57                	push   %r15
    efe3:	41 56                	push   %r14
    efe5:	41 55                	push   %r13
    efe7:	41 54                	push   %r12
    efe9:	53                   	push   %rbx
    efea:	48 81 ec b8 00 00 00 	sub    $0xb8,%rsp
    eff1:	49 89 d6             	mov    %rdx,%r14
    eff4:	49 89 f4             	mov    %rsi,%r12
    eff7:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
    effc:	ba 80 00 00 00       	mov    $0x80,%edx
    f001:	e8 6a 0d 00 00       	call   fd70 <tp_token>
    f006:	45 31 d2             	xor    %r10d,%r10d
    f009:	48 83 f8 7f          	cmp    $0x7f,%rax
    f00d:	0f 87 fa 00 00 00    	ja     f10d <tp_int+0x12d>
    f013:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    f018:	e8 53 41 ff ff       	call   3170 <strlen@plt>
    f01d:	49 89 c5             	mov    %rax,%r13
    f020:	48 ff 05 81 ce 00 00 	incq   0xce81(%rip)        # 1bea8 <measured_calls>
    f027:	48 8d 50 09          	lea    0x9(%rax),%rdx
    f02b:	48 01 15 7e ce 00 00 	add    %rdx,0xce7e(%rip)        # 1beb0 <measured_bytes>
    f032:	48 8d 3d 4f b2 00 00 	lea    0xb24f(%rip),%rdi        # 1a288 <fwp_gc>
    f039:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    f040:	77 5e                	ja     f0a0 <tp_int+0xc0>
    f042:	4c 89 e8             	mov    %r13,%rax
    f045:	48 83 c0 18          	add    $0x18,%rax
    f049:	48 c1 e8 04          	shr    $0x4,%rax
    f04d:	0f b6 8c 38 e8 0b 00 	movzbl 0xbe8(%rax,%rdi,1),%ecx
    f054:	00 
    f055:	8b 84 8f 48 0b 00 00 	mov    0xb48(%rdi,%rcx,4),%eax
    f05c:	48 29 05 25 b2 00 00 	sub    %rax,0xb225(%rip)        # 1a288 <fwp_gc>
    f063:	78 3b                	js     f0a0 <tp_int+0xc0>
    f065:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    f069:	48 8d 34 cf          	lea    (%rdi,%rcx,8),%rsi
    f06d:	48 81 c6 c8 03 00 00 	add    $0x3c8,%rsi
    f074:	48 8b 2e             	mov    (%rsi),%rbp
    f077:	48 85 ed             	test   %rbp,%rbp
    f07a:	74 0c                	je     f088 <tp_int+0xa8>
    f07c:	48 8b 45 00          	mov    0x0(%rbp),%rax
    f080:	48 f7 d0             	not    %rax
    f083:	48 89 06             	mov    %rax,(%rsi)
    f086:	eb 3b                	jmp    f0c3 <tp_int+0xe3>
    f088:	48 8b ac cf d0 03 00 	mov    0x3d0(%rdi,%rcx,8),%rbp
    f08f:	00 
    f090:	48 8b b4 cf d8 03 00 	mov    0x3d8(%rdi,%rcx,8),%rsi
    f097:	00 
    f098:	48 29 ee             	sub    %rbp,%rsi
    f09b:	48 39 c6             	cmp    %rax,%rsi
    f09e:	73 12                	jae    f0b2 <tp_int+0xd2>
    f0a0:	48 89 d7             	mov    %rdx,%rdi
    f0a3:	be 01 00 00 00       	mov    $0x1,%esi
    f0a8:	e8 93 92 ff ff       	call   8340 <fwp_gc_alloc_slow>
    f0ad:	48 89 c5             	mov    %rax,%rbp
    f0b0:	eb 1b                	jmp    f0cd <tp_int+0xed>
    f0b2:	48 8d 0c cf          	lea    (%rdi,%rcx,8),%rcx
    f0b6:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
    f0bd:	48 01 e8             	add    %rbp,%rax
    f0c0:	48 89 01             	mov    %rax,(%rcx)
    f0c3:	48 89 ef             	mov    %rbp,%rdi
    f0c6:	31 f6                	xor    %esi,%esi
    f0c8:	e8 43 41 ff ff       	call   3210 <memset@plt>
    f0cd:	4c 89 6d 00          	mov    %r13,0x0(%rbp)
    f0d1:	4c 8d 7d 08          	lea    0x8(%rbp),%r15
    f0d5:	48 8d 5c 24 30       	lea    0x30(%rsp),%rbx
    f0da:	4c 89 ff             	mov    %r15,%rdi
    f0dd:	48 89 de             	mov    %rbx,%rsi
    f0e0:	4c 89 ea             	mov    %r13,%rdx
    f0e3:	e8 48 42 ff ff       	call   3330 <memcpy@plt>
    f0e8:	42 c6 44 2d 08 00    	movb   $0x0,0x8(%rbp,%r13,1)
    f0ee:	4c 8b 5d 00          	mov    0x0(%rbp),%r11
    f0f2:	4d 85 db             	test   %r11,%r11
    f0f5:	74 13                	je     f10a <tp_int+0x12a>
    f0f7:	41 0f b6 3f          	movzbl (%r15),%edi
    f0fb:	8d 47 d5             	lea    -0x2b(%rdi),%eax
    f0fe:	31 c9                	xor    %ecx,%ecx
    f100:	a8 fd                	test   $0xfd,%al
    f102:	0f 94 c1             	sete   %cl
    f105:	49 39 cb             	cmp    %rcx,%r11
    f108:	75 18                	jne    f122 <tp_int+0x142>
    f10a:	45 31 d2             	xor    %r10d,%r10d
    f10d:	44 89 d0             	mov    %r10d,%eax
    f110:	48 81 c4 b8 00 00 00 	add    $0xb8,%rsp
    f117:	5b                   	pop    %rbx
    f118:	41 5c                	pop    %r12
    f11a:	41 5d                	pop    %r13
    f11c:	41 5e                	pop    %r14
    f11e:	41 5f                	pop    %r15
    f120:	5d                   	pop    %rbp
    f121:	c3                   	ret
    f122:	45 8b 04 24          	mov    (%r12),%r8d
    f126:	41 8b 74 24 48       	mov    0x48(%r12),%esi
    f12b:	76 18                	jbe    f145 <tp_int+0x165>
    f12d:	0f 1f 00             	nopl   (%rax)
    f130:	41 0f b6 14 0f       	movzbl (%r15,%rcx,1),%edx
    f135:	80 c2 c6             	add    $0xc6,%dl
    f138:	80 fa f6             	cmp    $0xf6,%dl
    f13b:	72 cd                	jb     f10a <tp_int+0x12a>
    f13d:	48 ff c1             	inc    %rcx
    f140:	49 39 cb             	cmp    %rcx,%r11
    f143:	75 eb                	jne    f130 <tp_int+0x150>
    f145:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
    f14a:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    f14f:	48 89 74 24 18       	mov    %rsi,0x18(%rsp)
    f154:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    f159:	31 db                	xor    %ebx,%ebx
    f15b:	a8 fd                	test   $0xfd,%al
    f15d:	0f 94 c3             	sete   %bl
    f160:	45 31 e4             	xor    %r12d,%r12d
    f163:	41 be 00 00 00 00    	mov    $0x0,%r14d
    f169:	49 39 db             	cmp    %rbx,%r11
    f16c:	0f 86 bf 00 00 00    	jbe    f231 <tp_int+0x251>
    f172:	bd 0a 00 00 00       	mov    $0xa,%ebp
    f177:	49 b8 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r8
    f17e:	cc cc cc 
    f181:	49 ba cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r10
    f188:	cc cc cc 
    f18b:	45 31 e4             	xor    %r12d,%r12d
    f18e:	45 31 f6             	xor    %r14d,%r14d
    f191:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    f198:	0f 1f 84 00 00 00 00 
    f19f:	00 
    f1a0:	4d 89 f1             	mov    %r14,%r9
    f1a3:	4c 89 e1             	mov    %r12,%rcx
    f1a6:	4c 89 e0             	mov    %r12,%rax
    f1a9:	48 f7 e5             	mul    %rbp
    f1ac:	4b 8d 34 b6          	lea    (%r14,%r14,4),%rsi
    f1b0:	48 8d 14 72          	lea    (%rdx,%rsi,2),%rdx
    f1b4:	41 0f be 34 1f       	movsbl (%r15,%rbx,1),%esi
    f1b9:	83 c6 d0             	add    $0xffffffd0,%esi
    f1bc:	48 63 f6             	movslq %esi,%rsi
    f1bf:	49 89 f6             	mov    %rsi,%r14
    f1c2:	49 c1 fe 3f          	sar    $0x3f,%r14
    f1c6:	49 89 c4             	mov    %rax,%r12
    f1c9:	49 01 f4             	add    %rsi,%r12
    f1cc:	49 11 d6             	adc    %rdx,%r14
    f1cf:	4c 89 f6             	mov    %r14,%rsi
    f1d2:	4c 0f a4 e6 3f       	shld   $0x3f,%r12,%rsi
    f1d7:	4d 89 f5             	mov    %r14,%r13
    f1da:	49 d1 ed             	shr    $1,%r13
    f1dd:	48 89 f7             	mov    %rsi,%rdi
    f1e0:	4c 01 ef             	add    %r13,%rdi
    f1e3:	48 83 d7 00          	adc    $0x0,%rdi
    f1e7:	48 89 f8             	mov    %rdi,%rax
    f1ea:	49 f7 e0             	mul    %r8
    f1ed:	48 c1 ea 02          	shr    $0x2,%rdx
    f1f1:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    f1f5:	48 29 c7             	sub    %rax,%rdi
    f1f8:	48 29 fe             	sub    %rdi,%rsi
    f1fb:	49 83 dd 00          	sbb    $0x0,%r13
    f1ff:	48 89 f7             	mov    %rsi,%rdi
    f202:	49 0f af fa          	imul   %r10,%rdi
    f206:	48 89 f0             	mov    %rsi,%rax
    f209:	49 f7 e0             	mul    %r8
    f20c:	48 01 fa             	add    %rdi,%rdx
    f20f:	4d 0f af e8          	imul   %r8,%r13
    f213:	49 01 d5             	add    %rdx,%r13
    f216:	4d 31 cd             	xor    %r9,%r13
    f219:	48 31 c8             	xor    %rcx,%rax
    f21c:	4c 09 e8             	or     %r13,%rax
    f21f:	0f 85 e5 fe ff ff    	jne    f10a <tp_int+0x12a>
    f225:	48 ff c3             	inc    %rbx
    f228:	49 39 db             	cmp    %rbx,%r11
    f22b:	0f 85 6f ff ff ff    	jne    f1a0 <tp_int+0x1c0>
    f231:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
    f236:	41 83 f8 09          	cmp    $0x9,%r8d
    f23a:	75 71                	jne    f2ad <tp_int+0x2cd>
    f23c:	80 7c 24 10 2d       	cmpb   $0x2d,0x10(%rsp)
    f241:	4c 8d 0d 40 b0 00 00 	lea    0xb040(%rip),%r9        # 1a288 <fwp_gc>
    f248:	75 0f                	jne    f259 <tp_int+0x279>
    f24a:	45 31 d2             	xor    %r10d,%r10d
    f24d:	4c 89 e0             	mov    %r12,%rax
    f250:	4c 09 f0             	or     %r14,%rax
    f253:	0f 85 b4 fe ff ff    	jne    f10d <tp_int+0x12d>
    f259:	48 ff 05 48 cc 00 00 	incq   0xcc48(%rip)        # 1bea8 <measured_calls>
    f260:	48 83 05 48 cc 00 00 	addq   $0x10,0xcc48(%rip)        # 1beb0 <measured_bytes>
    f267:	10 
    f268:	0f b6 0d 02 bc 00 00 	movzbl 0xbc02(%rip),%ecx        # 1ae71 <fwp_gc+0xbe9>
    f26f:	41 8b 84 89 48 0b 00 	mov    0xb48(%r9,%rcx,4),%eax
    f276:	00 
    f277:	48 29 05 0a b0 00 00 	sub    %rax,0xb00a(%rip)        # 1a288 <fwp_gc>
    f27e:	0f 88 d7 00 00 00    	js     f35b <tp_int+0x37b>
    f284:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    f288:	49 8d 14 c9          	lea    (%r9,%rcx,8),%rdx
    f28c:	48 81 c2 c8 03 00 00 	add    $0x3c8,%rdx
    f293:	4c 8b 3a             	mov    (%rdx),%r15
    f296:	4d 85 ff             	test   %r15,%r15
    f299:	0f 84 a4 00 00 00    	je     f343 <tp_int+0x363>
    f29f:	49 8b 07             	mov    (%r15),%rax
    f2a2:	48 f7 d0             	not    %rax
    f2a5:	48 89 02             	mov    %rax,(%rdx)
    f2a8:	e9 d9 00 00 00       	jmp    f386 <tp_int+0x3a6>
    f2ad:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    f2b2:	40 80 ff 2d          	cmp    $0x2d,%dil
    f2b6:	0f 94 c1             	sete   %cl
    f2b9:	48 b8 00 00 00 00 00 	movabs $0x8000000000000000,%rax
    f2c0:	00 00 80 
    f2c3:	4c 89 f2             	mov    %r14,%rdx
    f2c6:	48 31 c2             	xor    %rax,%rdx
    f2c9:	4c 09 e2             	or     %r12,%rdx
    f2cc:	0f 95 c2             	setne  %dl
    f2cf:	45 31 d2             	xor    %r10d,%r10d
    f2d2:	4c 89 e6             	mov    %r12,%rsi
    f2d5:	48 f7 de             	neg    %rsi
    f2d8:	48 89 c6             	mov    %rax,%rsi
    f2db:	4c 19 f6             	sbb    %r14,%rsi
    f2de:	4c 8d 0d a3 af 00 00 	lea    0xafa3(%rip),%r9        # 1a288 <fwp_gc>
    f2e5:	0f 82 22 fe ff ff    	jb     f10d <tp_int+0x12d>
    f2eb:	08 d1                	or     %dl,%cl
    f2ed:	0f 84 1a fe ff ff    	je     f10d <tp_int+0x12d>
    f2f3:	45 31 d2             	xor    %r10d,%r10d
    f2f6:	4d 89 e7             	mov    %r12,%r15
    f2f9:	49 f7 df             	neg    %r15
    f2fc:	bb 00 00 00 00       	mov    $0x0,%ebx
    f301:	4c 19 f3             	sbb    %r14,%rbx
    f304:	40 80 ff 2d          	cmp    $0x2d,%dil
    f308:	4d 0f 45 fc          	cmovne %r12,%r15
    f30c:	49 0f 45 de          	cmovne %r14,%rbx
    f310:	41 83 f8 14          	cmp    $0x14,%r8d
    f314:	0f 87 f3 fd ff ff    	ja     f10d <tp_int+0x12d>
    f31a:	44 89 c1             	mov    %r8d,%ecx
    f31d:	48 8d 15 6c 5f 00 00 	lea    0x5f6c(%rip),%rdx        # 15290 <_IO_stdin_used+0x290>
    f324:	48 63 0c 8a          	movslq (%rdx,%rcx,4),%rcx
    f328:	48 01 d1             	add    %rdx,%rcx
    f32b:	ff e1                	jmp    *%rcx
    f32d:	4c 89 f8             	mov    %r15,%rax
    f330:	48 83 c0 80          	add    $0xffffffffffffff80,%rax
    f334:	48 83 d3 ff          	adc    $0xffffffffffffffff,%rbx
    f338:	48 3d 00 ff ff ff    	cmp    $0xffffffffffffff00,%rax
    f33e:	e9 93 01 00 00       	jmp    f4d6 <tp_int+0x4f6>
    f343:	4d 8b bc c9 d0 03 00 	mov    0x3d0(%r9,%rcx,8),%r15
    f34a:	00 
    f34b:	49 8b 94 c9 d8 03 00 	mov    0x3d8(%r9,%rcx,8),%rdx
    f352:	00 
    f353:	4c 29 fa             	sub    %r15,%rdx
    f356:	48 39 c2             	cmp    %rax,%rdx
    f359:	73 1a                	jae    f375 <tp_int+0x395>
    f35b:	bf 10 00 00 00       	mov    $0x10,%edi
    f360:	be 01 00 00 00       	mov    $0x1,%esi
    f365:	4c 89 cb             	mov    %r9,%rbx
    f368:	e8 d3 8f ff ff       	call   8340 <fwp_gc_alloc_slow>
    f36d:	49 89 d9             	mov    %rbx,%r9
    f370:	49 89 c7             	mov    %rax,%r15
    f373:	eb 18                	jmp    f38d <tp_int+0x3ad>
    f375:	49 8d 0c c9          	lea    (%r9,%rcx,8),%rcx
    f379:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
    f380:	4c 01 f8             	add    %r15,%rax
    f383:	48 89 01             	mov    %rax,(%rcx)
    f386:	0f 57 c0             	xorps  %xmm0,%xmm0
    f389:	41 0f 11 07          	movups %xmm0,(%r15)
    f38d:	4d 89 27             	mov    %r12,(%r15)
    f390:	4d 89 77 08          	mov    %r14,0x8(%r15)
    f394:	4c 89 7c 24 28       	mov    %r15,0x28(%rsp)
    f399:	48 ff 05 08 cb 00 00 	incq   0xcb08(%rip)        # 1bea8 <measured_calls>
    f3a0:	48 83 05 08 cb 00 00 	addq   $0x10,0xcb08(%rip)        # 1beb0 <measured_bytes>
    f3a7:	10 
    f3a8:	0f b6 05 c2 ba 00 00 	movzbl 0xbac2(%rip),%eax        # 1ae71 <fwp_gc+0xbe9>
    f3af:	41 8b 94 81 48 0b 00 	mov    0xb48(%r9,%rax,4),%edx
    f3b6:	00 
    f3b7:	48 8b 0d ca ae 00 00 	mov    0xaeca(%rip),%rcx        # 1a288 <fwp_gc>
    f3be:	48 29 d1             	sub    %rdx,%rcx
    f3c1:	48 89 0d c0 ae 00 00 	mov    %rcx,0xaec0(%rip)        # 1a288 <fwp_gc>
    f3c8:	78 7f                	js     f449 <tp_int+0x469>
    f3ca:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
    f3ce:	49 8d 34 c1          	lea    (%r9,%rax,8),%rsi
    f3d2:	48 83 c6 08          	add    $0x8,%rsi
    f3d6:	4c 8b 36             	mov    (%rsi),%r14
    f3d9:	4d 85 f6             	test   %r14,%r14
    f3dc:	74 2b                	je     f409 <tp_int+0x429>
    f3de:	49 8b 06             	mov    (%r14),%rax
    f3e1:	48 f7 d0             	not    %rax
    f3e4:	48 89 06             	mov    %rax,(%rsi)
    f3e7:	83 fa 11             	cmp    $0x11,%edx
    f3ea:	0f 82 80 00 00 00    	jb     f470 <tp_int+0x490>
    f3f0:	49 8d 7e 10          	lea    0x10(%r14),%rdi
    f3f4:	48 83 c2 ef          	add    $0xffffffffffffffef,%rdx
    f3f8:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    f3fc:	48 83 c2 08          	add    $0x8,%rdx
    f400:	31 f6                	xor    %esi,%esi
    f402:	e8 09 3e ff ff       	call   3210 <memset@plt>
    f407:	eb 67                	jmp    f470 <tp_int+0x490>
    f409:	4d 8b 74 c1 10       	mov    0x10(%r9,%rax,8),%r14
    f40e:	49 8b 74 c1 18       	mov    0x18(%r9,%rax,8),%rsi
    f413:	48 89 f7             	mov    %rsi,%rdi
    f416:	4c 29 f7             	sub    %r14,%rdi
    f419:	48 39 d7             	cmp    %rdx,%rdi
    f41c:	73 05                	jae    f423 <tp_int+0x443>
    f41e:	4d 89 f4             	mov    %r14,%r12
    f421:	eb 21                	jmp    f444 <tp_int+0x464>
    f423:	49 8d 3c c1          	lea    (%r9,%rax,8),%rdi
    f427:	48 83 c7 10          	add    $0x10,%rdi
    f42b:	4d 8d 24 16          	lea    (%r14,%rdx,1),%r12
    f42f:	4c 89 27             	mov    %r12,(%rdi)
    f432:	4d 85 f6             	test   %r14,%r14
    f435:	75 b0                	jne    f3e7 <tp_int+0x407>
    f437:	48 89 0d 4a ae 00 00 	mov    %rcx,0xae4a(%rip)        # 1a288 <fwp_gc>
    f43e:	4c 29 e6             	sub    %r12,%rsi
    f441:	48 89 f7             	mov    %rsi,%rdi
    f444:	48 39 d7             	cmp    %rdx,%rdi
    f447:	73 11                	jae    f45a <tp_int+0x47a>
    f449:	bf 10 00 00 00       	mov    $0x10,%edi
    f44e:	31 f6                	xor    %esi,%esi
    f450:	e8 eb 8e ff ff       	call   8340 <fwp_gc_alloc_slow>
    f455:	49 89 c6             	mov    %rax,%r14
    f458:	eb 16                	jmp    f470 <tp_int+0x490>
    f45a:	49 8d 0c 14          	lea    (%r12,%rdx,1),%rcx
    f45e:	49 89 4c c1 10       	mov    %rcx,0x10(%r9,%rax,8)
    f463:	4c 89 e7             	mov    %r12,%rdi
    f466:	31 f6                	xor    %esi,%esi
    f468:	e8 a3 3d ff ff       	call   3210 <memset@plt>
    f46d:	4d 89 e6             	mov    %r12,%r14
    f470:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
    f477:	00 00 00 
    f47a:	49 89 06             	mov    %rax,(%r14)
    f47d:	4d 89 7e 08          	mov    %r15,0x8(%r14)
    f481:	48 8d 44 24 28       	lea    0x28(%rsp),%rax
    f486:	49 8b 46 08          	mov    0x8(%r14),%rax
    f48a:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    f48f:	48 89 01             	mov    %rax,(%rcx)
    f492:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    f498:	e9 70 fc ff ff       	jmp    f10d <tp_int+0x12d>
    f49d:	4c 89 f8             	mov    %r15,%rax
    f4a0:	48 05 00 00 00 80    	add    $0xffffffff80000000,%rax
    f4a6:	48 83 d3 ff          	adc    $0xffffffffffffffff,%rbx
    f4aa:	48 b9 00 00 00 00 ff 	movabs $0xffffffff00000000,%rcx
    f4b1:	ff ff ff 
    f4b4:	48 39 c8             	cmp    %rcx,%rax
    f4b7:	eb 1d                	jmp    f4d6 <tp_int+0x4f6>
    f4b9:	45 31 d2             	xor    %r10d,%r10d
    f4bc:	b8 ff 00 00 00       	mov    $0xff,%eax
    f4c1:	eb 2a                	jmp    f4ed <tp_int+0x50d>
    f4c3:	4c 89 f8             	mov    %r15,%rax
    f4c6:	48 05 00 80 ff ff    	add    $0xffffffffffff8000,%rax
    f4cc:	48 83 d3 ff          	adc    $0xffffffffffffffff,%rbx
    f4d0:	48 3d 00 00 ff ff    	cmp    $0xffffffffffff0000,%rax
    f4d6:	48 83 db ff          	sbb    $0xffffffffffffffff,%rbx
    f4da:	0f 82 2d fc ff ff    	jb     f10d <tp_int+0x12d>
    f4e0:	e9 af fe ff ff       	jmp    f394 <tp_int+0x3b4>
    f4e5:	45 31 d2             	xor    %r10d,%r10d
    f4e8:	b8 ff ff 00 00       	mov    $0xffff,%eax
    f4ed:	4c 39 f8             	cmp    %r15,%rax
    f4f0:	b8 00 00 00 00       	mov    $0x0,%eax
    f4f5:	48 19 d8             	sbb    %rbx,%rax
    f4f8:	0f 82 0f fc ff ff    	jb     f10d <tp_int+0x12d>
    f4fe:	e9 91 fe ff ff       	jmp    f394 <tp_int+0x3b4>
    f503:	4c 89 f8             	mov    %r15,%rax
    f506:	48 c1 e8 20          	shr    $0x20,%rax
    f50a:	48 09 d8             	or     %rbx,%rax
    f50d:	0f 85 fa fb ff ff    	jne    f10d <tp_int+0x12d>
    f513:	e9 7c fe ff ff       	jmp    f394 <tp_int+0x3b4>
    f518:	4c 89 f9             	mov    %r15,%rcx
    f51b:	48 01 c1             	add    %rax,%rcx
    f51e:	48 83 d3 ff          	adc    $0xffffffffffffffff,%rbx
    f522:	48 83 fb ff          	cmp    $0xffffffffffffffff,%rbx
    f526:	0f 85 e1 fb ff ff    	jne    f10d <tp_int+0x12d>
    f52c:	e9 63 fe ff ff       	jmp    f394 <tp_int+0x3b4>
    f531:	48 ff 05 70 c9 00 00 	incq   0xc970(%rip)        # 1bea8 <measured_calls>
    f538:	48 83 05 70 c9 00 00 	addq   $0x10,0xc970(%rip)        # 1beb0 <measured_bytes>
    f53f:	10 
    f540:	0f b6 05 2a b9 00 00 	movzbl 0xb92a(%rip),%eax        # 1ae71 <fwp_gc+0xbe9>
    f547:	41 8b 8c 81 48 0b 00 	mov    0xb48(%r9,%rax,4),%ecx
    f54e:	00 
    f54f:	48 29 0d 32 ad 00 00 	sub    %rcx,0xad32(%rip)        # 1a288 <fwp_gc>
    f556:	0f 88 87 00 00 00    	js     f5e3 <tp_int+0x603>
    f55c:	48 8d 14 40          	lea    (%rax,%rax,2),%rdx
    f560:	49 8d 34 d1          	lea    (%r9,%rdx,8),%rsi
    f564:	48 81 c6 c8 03 00 00 	add    $0x3c8,%rsi
    f56b:	48 8b 06             	mov    (%rsi),%rax
    f56e:	48 85 c0             	test   %rax,%rax
    f571:	74 54                	je     f5c7 <tp_int+0x5e7>
    f573:	48 8b 08             	mov    (%rax),%rcx
    f576:	48 f7 d1             	not    %rcx
    f579:	48 89 0e             	mov    %rcx,(%rsi)
    f57c:	e9 12 01 00 00       	jmp    f693 <tp_int+0x6b3>
    f581:	45 31 d2             	xor    %r10d,%r10d
    f584:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    f589:	85 c9                	test   %ecx,%ecx
    f58b:	7e 31                	jle    f5be <tp_int+0x5de>
    f58d:	8d 41 ff             	lea    -0x1(%rcx),%eax
    f590:	83 f8 4f             	cmp    $0x4f,%eax
    f593:	bf 4f 00 00 00       	mov    $0x4f,%edi
    f598:	0f 42 f8             	cmovb  %eax,%edi
    f59b:	ff c7                	inc    %edi
    f59d:	89 fe                	mov    %edi,%esi
    f59f:	83 e6 07             	and    $0x7,%esi
    f5a2:	83 f9 08             	cmp    $0x8,%ecx
    f5a5:	73 56                	jae    f5fd <tp_int+0x61d>
    f5a7:	b8 01 00 00 00       	mov    $0x1,%eax
    f5ac:	31 c9                	xor    %ecx,%ecx
    f5ae:	eb 72                	jmp    f622 <tp_int+0x642>
    f5b0:	48 85 db             	test   %rbx,%rbx
    f5b3:	0f 85 54 fb ff ff    	jne    f10d <tp_int+0x12d>
    f5b9:	e9 d6 fd ff ff       	jmp    f394 <tp_int+0x3b4>
    f5be:	31 d2                	xor    %edx,%edx
    f5c0:	31 c9                	xor    %ecx,%ecx
    f5c2:	e9 90 00 00 00       	jmp    f657 <tp_int+0x677>
    f5c7:	49 8b 84 d1 d0 03 00 	mov    0x3d0(%r9,%rdx,8),%rax
    f5ce:	00 
    f5cf:	49 8b b4 d1 d8 03 00 	mov    0x3d8(%r9,%rdx,8),%rsi
    f5d6:	00 
    f5d7:	48 29 c6             	sub    %rax,%rsi
    f5da:	48 39 ce             	cmp    %rcx,%rsi
    f5dd:	0f 83 9f 00 00 00    	jae    f682 <tp_int+0x6a2>
    f5e3:	bf 10 00 00 00       	mov    $0x10,%edi
    f5e8:	be 01 00 00 00       	mov    $0x1,%esi
    f5ed:	4d 89 ce             	mov    %r9,%r14
    f5f0:	e8 4b 8d ff ff       	call   8340 <fwp_gc_alloc_slow>
    f5f5:	4d 89 f1             	mov    %r14,%r9
    f5f8:	e9 9c 00 00 00       	jmp    f699 <tp_int+0x6b9>
    f5fd:	81 e7 f8 00 00 00    	and    $0xf8,%edi
    f603:	b8 01 00 00 00       	mov    $0x1,%eax
    f608:	31 c9                	xor    %ecx,%ecx
    f60a:	41 b8 a1 19 00 00    	mov    $0x19a1,%r8d
    f610:	49 f7 e0             	mul    %r8
    f613:	48 69 c9 a1 19 00 00 	imul   $0x19a1,%rcx,%rcx
    f61a:	48 01 d1             	add    %rdx,%rcx
    f61d:	83 c7 f8             	add    $0xfffffff8,%edi
    f620:	75 ee                	jne    f610 <tp_int+0x630>
    f622:	85 f6                	test   %esi,%esi
    f624:	74 13                	je     f639 <tp_int+0x659>
    f626:	bf 03 00 00 00       	mov    $0x3,%edi
    f62b:	48 f7 e7             	mul    %rdi
    f62e:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    f632:	48 01 d1             	add    %rdx,%rcx
    f635:	ff ce                	dec    %esi
    f637:	75 f2                	jne    f62b <tp_int+0x64b>
    f639:	48 83 c0 ff          	add    $0xffffffffffffffff,%rax
    f63d:	48 83 d1 ff          	adc    $0xffffffffffffffff,%rcx
    f641:	48 89 ca             	mov    %rcx,%rdx
    f644:	48 c1 ea 3f          	shr    $0x3f,%rdx
    f648:	48 01 c2             	add    %rax,%rdx
    f64b:	48 83 d1 00          	adc    $0x0,%rcx
    f64f:	48 0f ac ca 01       	shrd   $0x1,%rcx,%rdx
    f654:	48 d1 f9             	sar    $1,%rcx
    f657:	48 89 d0             	mov    %rdx,%rax
    f65a:	48 f7 d8             	neg    %rax
    f65d:	be 00 00 00 00       	mov    $0x0,%esi
    f662:	48 19 ce             	sbb    %rcx,%rsi
    f665:	4c 39 fa             	cmp    %r15,%rdx
    f668:	48 19 d9             	sbb    %rbx,%rcx
    f66b:	0f 8c 9c fa ff ff    	jl     f10d <tp_int+0x12d>
    f671:	49 39 c7             	cmp    %rax,%r15
    f674:	48 19 f3             	sbb    %rsi,%rbx
    f677:	0f 8d 17 fd ff ff    	jge    f394 <tp_int+0x3b4>
    f67d:	e9 8b fa ff ff       	jmp    f10d <tp_int+0x12d>
    f682:	49 8d 14 d1          	lea    (%r9,%rdx,8),%rdx
    f686:	48 81 c2 d0 03 00 00 	add    $0x3d0,%rdx
    f68d:	48 01 c1             	add    %rax,%rcx
    f690:	48 89 0a             	mov    %rcx,(%rdx)
    f693:	0f 57 c0             	xorps  %xmm0,%xmm0
    f696:	0f 11 00             	movups %xmm0,(%rax)
    f699:	4c 89 38             	mov    %r15,(%rax)
    f69c:	48 89 58 08          	mov    %rbx,0x8(%rax)
    f6a0:	49 89 c7             	mov    %rax,%r15
    f6a3:	e9 ec fc ff ff       	jmp    f394 <tp_int+0x3b4>
    f6a8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    f6af:	00 

000000000000f6b0 <tp_quoted>:
    f6b0:	55                   	push   %rbp
    f6b1:	41 57                	push   %r15
    f6b3:	41 56                	push   %r14
    f6b5:	41 55                	push   %r13
    f6b7:	41 54                	push   %r12
    f6b9:	53                   	push   %rbx
    f6ba:	48 83 ec 28          	sub    $0x28,%rsp
    f6be:	48 89 f3             	mov    %rsi,%rbx
    f6c1:	49 89 ff             	mov    %rdi,%r15
    f6c4:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    f6c8:	48 8b 6f 10          	mov    0x10(%rdi),%rbp
    f6cc:	4c 39 ed             	cmp    %r13,%rbp
    f6cf:	73 33                	jae    f704 <tp_quoted+0x54>
    f6d1:	49 8b 07             	mov    (%r15),%rax
    f6d4:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    f6db:	00 00 00 
    f6de:	66 90                	xchg   %ax,%ax
    f6e0:	0f b6 14 28          	movzbl (%rax,%rbp,1),%edx
    f6e4:	48 83 fa 20          	cmp    $0x20,%rdx
    f6e8:	77 1a                	ja     f704 <tp_quoted+0x54>
    f6ea:	48 0f a3 d1          	bt     %rdx,%rcx
    f6ee:	73 14                	jae    f704 <tp_quoted+0x54>
    f6f0:	48 ff c5             	inc    %rbp
    f6f3:	49 89 6f 10          	mov    %rbp,0x10(%r15)
    f6f7:	49 39 ed             	cmp    %rbp,%r13
    f6fa:	75 e4                	jne    f6e0 <tp_quoted+0x30>
    f6fc:	45 31 f6             	xor    %r14d,%r14d
    f6ff:	e9 f6 01 00 00       	jmp    f8fa <tp_quoted+0x24a>
    f704:	45 31 f6             	xor    %r14d,%r14d
    f707:	4c 39 ed             	cmp    %r13,%rbp
    f70a:	0f 83 ea 01 00 00    	jae    f8fa <tp_quoted+0x24a>
    f710:	49 8b 07             	mov    (%r15),%rax
    f713:	80 3c 28 22          	cmpb   $0x22,(%rax,%rbp,1)
    f717:	0f 85 dd 01 00 00    	jne    f8fa <tp_quoted+0x24a>
    f71d:	48 ff c5             	inc    %rbp
    f720:	49 89 6f 10          	mov    %rbp,0x10(%r15)
    f724:	0f 57 c0             	xorps  %xmm0,%xmm0
    f727:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    f72c:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    f733:	00 00 
    f735:	45 31 f6             	xor    %r14d,%r14d
    f738:	4c 39 ed             	cmp    %r13,%rbp
    f73b:	0f 83 a6 01 00 00    	jae    f8e7 <tp_quoted+0x237>
    f741:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    f748:	0f 1f 84 00 00 00 00 
    f74f:	00 
    f750:	4d 8b 27             	mov    (%r15),%r12
    f753:	48 8d 4d 01          	lea    0x1(%rbp),%rcx
    f757:	49 89 4f 10          	mov    %rcx,0x10(%r15)
    f75b:	41 0f b6 04 2c       	movzbl (%r12,%rbp,1),%eax
    f760:	83 f8 5c             	cmp    $0x5c,%eax
    f763:	74 3b                	je     f7a0 <tp_quoted+0xf0>
    f765:	83 f8 22             	cmp    $0x22,%eax
    f768:	0f 84 9e 01 00 00    	je     f90c <tp_quoted+0x25c>
    f76e:	88 44 24 0f          	mov    %al,0xf(%rsp)
    f772:	ba 01 00 00 00       	mov    $0x1,%edx
    f777:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    f77c:	48 8d 74 24 0f       	lea    0xf(%rsp),%rsi
    f781:	e8 0a db ff ff       	call   d290 <buf_put>
    f786:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    f78a:	49 8b 6f 10          	mov    0x10(%r15),%rbp
    f78e:	4c 39 ed             	cmp    %r13,%rbp
    f791:	72 bd                	jb     f750 <tp_quoted+0xa0>
    f793:	e9 58 01 00 00       	jmp    f8f0 <tp_quoted+0x240>
    f798:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    f79f:	00 
    f7a0:	4c 39 e9             	cmp    %r13,%rcx
    f7a3:	0f 83 47 01 00 00    	jae    f8f0 <tp_quoted+0x240>
    f7a9:	48 8d 45 02          	lea    0x2(%rbp),%rax
    f7ad:	49 89 47 10          	mov    %rax,0x10(%r15)
    f7b1:	41 0f b6 4c 2c 01    	movzbl 0x1(%r12,%rbp,1),%ecx
    f7b7:	8d 51 a4             	lea    -0x5c(%rcx),%edx
    f7ba:	83 fa 19             	cmp    $0x19,%edx
    f7bd:	77 17                	ja     f7d6 <tp_quoted+0x126>
    f7bf:	48 8d 35 1e 5b 00 00 	lea    0x5b1e(%rip),%rsi        # 152e4 <_IO_stdin_used+0x2e4>
    f7c6:	48 63 0c 96          	movslq (%rsi,%rdx,4),%rcx
    f7ca:	48 01 f1             	add    %rsi,%rcx
    f7cd:	ff e1                	jmp    *%rcx
    f7cf:	c6 44 24 0f 5c       	movb   $0x5c,0xf(%rsp)
    f7d4:	eb 9c                	jmp    f772 <tp_quoted+0xc2>
    f7d6:	83 f9 22             	cmp    $0x22,%ecx
    f7d9:	0f 84 c2 00 00 00    	je     f8a1 <tp_quoted+0x1f1>
    f7df:	83 f9 30             	cmp    $0x30,%ecx
    f7e2:	0f 85 08 01 00 00    	jne    f8f0 <tp_quoted+0x240>
    f7e8:	c6 44 24 0f 00       	movb   $0x0,0xf(%rsp)
    f7ed:	eb 83                	jmp    f772 <tp_quoted+0xc2>
    f7ef:	c6 44 24 0f 09       	movb   $0x9,0xf(%rsp)
    f7f4:	e9 79 ff ff ff       	jmp    f772 <tp_quoted+0xc2>
    f7f9:	c6 44 24 0f 0d       	movb   $0xd,0xf(%rsp)
    f7fe:	e9 6f ff ff ff       	jmp    f772 <tp_quoted+0xc2>
    f803:	c6 44 24 0f 0a       	movb   $0xa,0xf(%rsp)
    f808:	e9 65 ff ff ff       	jmp    f772 <tp_quoted+0xc2>
    f80d:	4c 39 e8             	cmp    %r13,%rax
    f810:	0f 83 da 00 00 00    	jae    f8f0 <tp_quoted+0x240>
    f816:	41 80 3c 04 7b       	cmpb   $0x7b,(%r12,%rax,1)
    f81b:	0f 85 cf 00 00 00    	jne    f8f0 <tp_quoted+0x240>
    f821:	48 8d 45 03          	lea    0x3(%rbp),%rax
    f825:	49 89 47 10          	mov    %rax,0x10(%r15)
    f829:	4c 39 e8             	cmp    %r13,%rax
    f82c:	0f 83 be 00 00 00    	jae    f8f0 <tp_quoted+0x240>
    f832:	e8 a9 3c ff ff       	call   34e0 <__ctype_b_loc@plt>
    f837:	48 8b 08             	mov    (%rax),%rcx
    f83a:	48 8d 55 04          	lea    0x4(%rbp),%rdx
    f83e:	49 8d 3c 2c          	lea    (%r12,%rbp,1),%rdi
    f842:	48 83 c7 03          	add    $0x3,%rdi
    f846:	49 29 ed             	sub    %rbp,%r13
    f849:	49 83 c5 fd          	add    $0xfffffffffffffffd,%r13
    f84d:	31 c0                	xor    %eax,%eax
    f84f:	31 f6                	xor    %esi,%esi
    f851:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    f858:	0f 1f 84 00 00 00 00 
    f85f:	00 
    f860:	44 0f b6 04 07       	movzbl (%rdi,%rax,1),%r8d
    f865:	42 f6 44 41 01 10    	testb  $0x10,0x1(%rcx,%r8,2)
    f86b:	74 3e                	je     f8ab <tp_quoted+0x1fb>
    f86d:	4c 8d 04 02          	lea    (%rdx,%rax,1),%r8
    f871:	4d 89 47 10          	mov    %r8,0x10(%r15)
    f875:	44 0f be 04 07       	movsbl (%rdi,%rax,1),%r8d
    f87a:	c1 e6 04             	shl    $0x4,%esi
    f87d:	45 8d 48 d0          	lea    -0x30(%r8),%r9d
    f881:	45 89 c2             	mov    %r8d,%r10d
    f884:	41 83 ca 20          	or     $0x20,%r10d
    f888:	41 83 c2 a9          	add    $0xffffffa9,%r10d
    f88c:	41 83 f8 3a          	cmp    $0x3a,%r8d
    f890:	45 0f 4c d1          	cmovl  %r9d,%r10d
    f894:	44 01 d6             	add    %r10d,%esi
    f897:	48 ff c0             	inc    %rax
    f89a:	49 39 c5             	cmp    %rax,%r13
    f89d:	75 c1                	jne    f860 <tp_quoted+0x1b0>
    f89f:	eb 4f                	jmp    f8f0 <tp_quoted+0x240>
    f8a1:	c6 44 24 0f 22       	movb   $0x22,0xf(%rsp)
    f8a6:	e9 c7 fe ff ff       	jmp    f772 <tp_quoted+0xc2>
    f8ab:	85 c0                	test   %eax,%eax
    f8ad:	74 41                	je     f8f0 <tp_quoted+0x240>
    f8af:	41 80 f8 7d          	cmp    $0x7d,%r8b
    f8b3:	75 3b                	jne    f8f0 <tp_quoted+0x240>
    f8b5:	81 fe ff ff 10 00    	cmp    $0x10ffff,%esi
    f8bb:	77 33                	ja     f8f0 <tp_quoted+0x240>
    f8bd:	89 f1                	mov    %esi,%ecx
    f8bf:	81 e1 00 f8 ff ff    	and    $0xfffff800,%ecx
    f8c5:	81 f9 00 d8 00 00    	cmp    $0xd800,%ecx
    f8cb:	74 23                	je     f8f0 <tp_quoted+0x240>
    f8cd:	48 01 e8             	add    %rbp,%rax
    f8d0:	48 83 c0 04          	add    $0x4,%rax
    f8d4:	49 89 47 10          	mov    %rax,0x10(%r15)
    f8d8:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    f8dd:	e8 ae 0b 00 00       	call   10490 <fwp_utf8_put>
    f8e2:	e9 9f fe ff ff       	jmp    f786 <tp_quoted+0xd6>
    f8e7:	31 ff                	xor    %edi,%edi
    f8e9:	e8 62 37 ff ff       	call   3050 <free@plt>
    f8ee:	eb 0a                	jmp    f8fa <tp_quoted+0x24a>
    f8f0:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    f8f5:	e8 56 37 ff ff       	call   3050 <free@plt>
    f8fa:	44 89 f0             	mov    %r14d,%eax
    f8fd:	48 83 c4 28          	add    $0x28,%rsp
    f901:	5b                   	pop    %rbx
    f902:	41 5c                	pop    %r12
    f904:	41 5d                	pop    %r13
    f906:	41 5e                	pop    %r14
    f908:	41 5f                	pop    %r15
    f90a:	5d                   	pop    %rbp
    f90b:	c3                   	ret
    f90c:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    f911:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    f916:	48 85 ff             	test   %rdi,%rdi
    f919:	48 8d 0d ca 68 00 00 	lea    0x68ca(%rip),%rcx        # 161ea <exec_in_fp0+0x97a>
    f920:	48 0f 45 cf          	cmovne %rdi,%rcx
    f924:	48 85 c0             	test   %rax,%rax
    f927:	0f 84 3e 01 00 00    	je     fa6b <tp_quoted+0x3bb>
    f92d:	31 d2                	xor    %edx,%edx
    f92f:	eb 0c                	jmp    f93d <tp_quoted+0x28d>
    f931:	48 ff c2             	inc    %rdx
    f934:	48 39 c2             	cmp    %rax,%rdx
    f937:	0f 83 2e 01 00 00    	jae    fa6b <tp_quoted+0x3bb>
    f93d:	44 0f b6 14 11       	movzbl (%rcx,%rdx,1),%r10d
    f942:	45 84 d2             	test   %r10b,%r10b
    f945:	79 ea                	jns    f931 <tp_quoted+0x281>
    f947:	41 8d 72 3e          	lea    0x3e(%r10),%esi
    f94b:	40 80 fe 1e          	cmp    $0x1e,%sil
    f94f:	73 13                	jae    f964 <tp_quoted+0x2b4>
    f951:	be 80 00 00 00       	mov    $0x80,%esi
    f956:	41 b9 01 00 00 00    	mov    $0x1,%r9d
    f95c:	41 b8 1f 00 00 00    	mov    $0x1f,%r8d
    f962:	eb 3f                	jmp    f9a3 <tp_quoted+0x2f3>
    f964:	44 89 d6             	mov    %r10d,%esi
    f967:	40 80 e6 f0          	and    $0xf0,%sil
    f96b:	40 80 fe e0          	cmp    $0xe0,%sil
    f96f:	75 13                	jne    f984 <tp_quoted+0x2d4>
    f971:	be 00 08 00 00       	mov    $0x800,%esi
    f976:	41 b9 02 00 00 00    	mov    $0x2,%r9d
    f97c:	41 b8 0f 00 00 00    	mov    $0xf,%r8d
    f982:	eb 1f                	jmp    f9a3 <tp_quoted+0x2f3>
    f984:	41 8d 72 10          	lea    0x10(%r10),%esi
    f988:	40 80 fe 04          	cmp    $0x4,%sil
    f98c:	0f 87 f1 00 00 00    	ja     fa83 <tp_quoted+0x3d3>
    f992:	be 00 00 01 00       	mov    $0x10000,%esi
    f997:	41 b9 03 00 00 00    	mov    $0x3,%r9d
    f99d:	41 b8 07 00 00 00    	mov    $0x7,%r8d
    f9a3:	45 89 c9             	mov    %r9d,%r9d
    f9a6:	4e 8d 1c 0a          	lea    (%rdx,%r9,1),%r11
    f9aa:	49 39 c3             	cmp    %rax,%r11
    f9ad:	0f 83 d0 00 00 00    	jae    fa83 <tp_quoted+0x3d3>
    f9b3:	44 0f b6 5c 11 01    	movzbl 0x1(%rcx,%rdx,1),%r11d
    f9b9:	44 89 dd             	mov    %r11d,%ebp
    f9bc:	83 e5 c0             	and    $0xffffffc0,%ebp
    f9bf:	81 fd 80 00 00 00    	cmp    $0x80,%ebp
    f9c5:	0f 85 b8 00 00 00    	jne    fa83 <tp_quoted+0x3d3>
    f9cb:	45 21 d0             	and    %r10d,%r8d
    f9ce:	45 8d 51 01          	lea    0x1(%r9),%r10d
    f9d2:	44 89 c5             	mov    %r8d,%ebp
    f9d5:	c1 e5 06             	shl    $0x6,%ebp
    f9d8:	41 83 e3 3f          	and    $0x3f,%r11d
    f9dc:	41 09 eb             	or     %ebp,%r11d
    f9df:	41 83 fa 02          	cmp    $0x2,%r10d
    f9e3:	75 05                	jne    f9ea <tp_quoted+0x33a>
    f9e5:	45 89 da             	mov    %r11d,%r10d
    f9e8:	eb 57                	jmp    fa41 <tp_quoted+0x391>
    f9ea:	44 0f b6 44 11 02    	movzbl 0x2(%rcx,%rdx,1),%r8d
    f9f0:	44 89 c5             	mov    %r8d,%ebp
    f9f3:	83 e5 c0             	and    $0xffffffc0,%ebp
    f9f6:	81 fd 80 00 00 00    	cmp    $0x80,%ebp
    f9fc:	0f 85 81 00 00 00    	jne    fa83 <tp_quoted+0x3d3>
    fa02:	44 89 dd             	mov    %r11d,%ebp
    fa05:	c1 e5 06             	shl    $0x6,%ebp
    fa08:	41 83 e0 3f          	and    $0x3f,%r8d
    fa0c:	41 09 e8             	or     %ebp,%r8d
    fa0f:	41 83 fa 03          	cmp    $0x3,%r10d
    fa13:	75 08                	jne    fa1d <tp_quoted+0x36d>
    fa15:	45 89 c2             	mov    %r8d,%r10d
    fa18:	45 89 d8             	mov    %r11d,%r8d
    fa1b:	eb 24                	jmp    fa41 <tp_quoted+0x391>
    fa1d:	44 0f b6 54 11 03    	movzbl 0x3(%rcx,%rdx,1),%r10d
    fa23:	45 89 d3             	mov    %r10d,%r11d
    fa26:	41 83 e3 c0          	and    $0xffffffc0,%r11d
    fa2a:	41 81 fb 80 00 00 00 	cmp    $0x80,%r11d
    fa31:	75 50                	jne    fa83 <tp_quoted+0x3d3>
    fa33:	45 89 c3             	mov    %r8d,%r11d
    fa36:	41 c1 e3 06          	shl    $0x6,%r11d
    fa3a:	41 83 e2 3f          	and    $0x3f,%r10d
    fa3e:	45 09 da             	or     %r11d,%r10d
    fa41:	41 83 e0 e0          	and    $0xffffffe0,%r8d
    fa45:	41 81 f8 60 03 00 00 	cmp    $0x360,%r8d
    fa4c:	74 35                	je     fa83 <tp_quoted+0x3d3>
    fa4e:	41 39 f2             	cmp    %esi,%r10d
    fa51:	72 30                	jb     fa83 <tp_quoted+0x3d3>
    fa53:	41 81 fa ff ff 10 00 	cmp    $0x10ffff,%r10d
    fa5a:	77 27                	ja     fa83 <tp_quoted+0x3d3>
    fa5c:	4c 01 ca             	add    %r9,%rdx
    fa5f:	48 ff c2             	inc    %rdx
    fa62:	48 39 c2             	cmp    %rax,%rdx
    fa65:	0f 82 d2 fe ff ff    	jb     f93d <tp_quoted+0x28d>
    fa6b:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    fa70:	e8 0b d9 ff ff       	call   d380 <buf_to_str>
    fa75:	48 89 03             	mov    %rax,(%rbx)
    fa78:	41 be 01 00 00 00    	mov    $0x1,%r14d
    fa7e:	e9 77 fe ff ff       	jmp    f8fa <tp_quoted+0x24a>
    fa83:	e8 c8 35 ff ff       	call   3050 <free@plt>
    fa88:	e9 6f fc ff ff       	jmp    f6fc <tp_quoted+0x4c>
    fa8d:	0f 1f 00             	nopl   (%rax)

000000000000fa90 <tp_eat>:
    fa90:	55                   	push   %rbp
    fa91:	41 57                	push   %r15
    fa93:	41 56                	push   %r14
    fa95:	41 54                	push   %r12
    fa97:	53                   	push   %rbx
    fa98:	49 89 f6             	mov    %rsi,%r14
    fa9b:	48 89 fb             	mov    %rdi,%rbx
    fa9e:	4c 8b 67 08          	mov    0x8(%rdi),%r12
    faa2:	4c 8b 7f 10          	mov    0x10(%rdi),%r15
    faa6:	4d 39 e7             	cmp    %r12,%r15
    faa9:	73 35                	jae    fae0 <tp_eat+0x50>
    faab:	48 8b 03             	mov    (%rbx),%rax
    faae:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    fab5:	00 00 00 
    fab8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    fabf:	00 
    fac0:	42 0f b6 14 38       	movzbl (%rax,%r15,1),%edx
    fac5:	48 83 fa 20          	cmp    $0x20,%rdx
    fac9:	77 15                	ja     fae0 <tp_eat+0x50>
    facb:	48 0f a3 d1          	bt     %rdx,%rcx
    facf:	73 0f                	jae    fae0 <tp_eat+0x50>
    fad1:	49 ff c7             	inc    %r15
    fad4:	4c 89 7b 10          	mov    %r15,0x10(%rbx)
    fad8:	4d 39 fc             	cmp    %r15,%r12
    fadb:	75 e3                	jne    fac0 <tp_eat+0x30>
    fadd:	4d 89 e7             	mov    %r12,%r15
    fae0:	4c 89 f7             	mov    %r14,%rdi
    fae3:	e8 88 36 ff ff       	call   3170 <strlen@plt>
    fae8:	4d 29 fc             	sub    %r15,%r12
    faeb:	31 ed                	xor    %ebp,%ebp
    faed:	49 39 c4             	cmp    %rax,%r12
    faf0:	72 24                	jb     fb16 <tp_eat+0x86>
    faf2:	48 8b 3b             	mov    (%rbx),%rdi
    faf5:	4c 01 ff             	add    %r15,%rdi
    faf8:	4c 89 f6             	mov    %r14,%rsi
    fafb:	49 89 c6             	mov    %rax,%r14
    fafe:	48 89 c2             	mov    %rax,%rdx
    fb01:	e8 6a 38 ff ff       	call   3370 <bcmp@plt>
    fb06:	85 c0                	test   %eax,%eax
    fb08:	75 0c                	jne    fb16 <tp_eat+0x86>
    fb0a:	4d 01 f7             	add    %r14,%r15
    fb0d:	4c 89 7b 10          	mov    %r15,0x10(%rbx)
    fb11:	bd 01 00 00 00       	mov    $0x1,%ebp
    fb16:	89 e8                	mov    %ebp,%eax
    fb18:	5b                   	pop    %rbx
    fb19:	41 5c                	pop    %r12
    fb1b:	41 5e                	pop    %r14
    fb1d:	41 5f                	pop    %r15
    fb1f:	5d                   	pop    %rbp
    fb20:	c3                   	ret
    fb21:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    fb28:	0f 1f 84 00 00 00 00 
    fb2f:	00 

000000000000fb30 <tp_list_of>:
    fb30:	55                   	push   %rbp
    fb31:	41 57                	push   %r15
    fb33:	41 56                	push   %r14
    fb35:	41 55                	push   %r13
    fb37:	41 54                	push   %r12
    fb39:	53                   	push   %rbx
    fb3a:	48 83 ec 18          	sub    $0x18,%rsp
    fb3e:	4d 89 c6             	mov    %r8,%r14
    fb41:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
    fb46:	49 89 f7             	mov    %rsi,%r15
    fb49:	48 89 fb             	mov    %rdi,%rbx
    fb4c:	48 8b 6f 08          	mov    0x8(%rdi),%rbp
    fb50:	4c 8b 67 10          	mov    0x10(%rdi),%r12
    fb54:	49 39 ec             	cmp    %rbp,%r12
    fb57:	48 89 14 24          	mov    %rdx,(%rsp)
    fb5b:	73 33                	jae    fb90 <tp_list_of+0x60>
    fb5d:	48 8b 03             	mov    (%rbx),%rax
    fb60:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    fb67:	00 00 00 
    fb6a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    fb70:	42 0f b6 34 20       	movzbl (%rax,%r12,1),%esi
    fb75:	48 83 fe 20          	cmp    $0x20,%rsi
    fb79:	77 15                	ja     fb90 <tp_list_of+0x60>
    fb7b:	48 0f a3 f1          	bt     %rsi,%rcx
    fb7f:	73 0f                	jae    fb90 <tp_list_of+0x60>
    fb81:	49 ff c4             	inc    %r12
    fb84:	4c 89 63 10          	mov    %r12,0x10(%rbx)
    fb88:	4c 39 e5             	cmp    %r12,%rbp
    fb8b:	75 e3                	jne    fb70 <tp_list_of+0x40>
    fb8d:	49 89 ec             	mov    %rbp,%r12
    fb90:	4c 89 ff             	mov    %r15,%rdi
    fb93:	e8 d8 35 ff ff       	call   3170 <strlen@plt>
    fb98:	49 89 c5             	mov    %rax,%r13
    fb9b:	48 89 e9             	mov    %rbp,%rcx
    fb9e:	4c 29 e1             	sub    %r12,%rcx
    fba1:	31 c0                	xor    %eax,%eax
    fba3:	4c 39 e9             	cmp    %r13,%rcx
    fba6:	72 1d                	jb     fbc5 <tp_list_of+0x95>
    fba8:	4c 89 74 24 08       	mov    %r14,0x8(%rsp)
    fbad:	4c 8b 33             	mov    (%rbx),%r14
    fbb0:	4b 8d 3c 26          	lea    (%r14,%r12,1),%rdi
    fbb4:	4c 89 fe             	mov    %r15,%rsi
    fbb7:	4c 89 ea             	mov    %r13,%rdx
    fbba:	e8 b1 37 ff ff       	call   3370 <bcmp@plt>
    fbbf:	85 c0                	test   %eax,%eax
    fbc1:	74 11                	je     fbd4 <tp_list_of+0xa4>
    fbc3:	31 c0                	xor    %eax,%eax
    fbc5:	48 83 c4 18          	add    $0x18,%rsp
    fbc9:	5b                   	pop    %rbx
    fbca:	41 5c                	pop    %r12
    fbcc:	41 5d                	pop    %r13
    fbce:	41 5e                	pop    %r14
    fbd0:	41 5f                	pop    %r15
    fbd2:	5d                   	pop    %rbp
    fbd3:	c3                   	ret
    fbd4:	4d 01 e5             	add    %r12,%r13
    fbd7:	4c 89 6b 10          	mov    %r13,0x10(%rbx)
    fbdb:	49 bc 00 26 00 00 01 	movabs $0x100002600,%r12
    fbe2:	00 00 00 
    fbe5:	49 39 ed             	cmp    %rbp,%r13
    fbe8:	73 28                	jae    fc12 <tp_list_of+0xe2>
    fbea:	48 8b 3c 24          	mov    (%rsp),%rdi
    fbee:	66 90                	xchg   %ax,%ax
    fbf0:	43 0f b6 04 2e       	movzbl (%r14,%r13,1),%eax
    fbf5:	48 83 f8 20          	cmp    $0x20,%rax
    fbf9:	77 1b                	ja     fc16 <tp_list_of+0xe6>
    fbfb:	49 0f a3 c4          	bt     %rax,%r12
    fbff:	73 15                	jae    fc16 <tp_list_of+0xe6>
    fc01:	49 ff c5             	inc    %r13
    fc04:	4c 89 6b 10          	mov    %r13,0x10(%rbx)
    fc08:	4c 39 ed             	cmp    %r13,%rbp
    fc0b:	75 e3                	jne    fbf0 <tp_list_of+0xc0>
    fc0d:	49 89 ed             	mov    %rbp,%r13
    fc10:	eb 04                	jmp    fc16 <tp_list_of+0xe6>
    fc12:	48 8b 3c 24          	mov    (%rsp),%rdi
    fc16:	e8 55 35 ff ff       	call   3170 <strlen@plt>
    fc1b:	4c 29 ed             	sub    %r13,%rbp
    fc1e:	48 39 c5             	cmp    %rax,%rbp
    fc21:	48 8b 34 24          	mov    (%rsp),%rsi
    fc25:	72 19                	jb     fc40 <tp_list_of+0x110>
    fc27:	49 89 c7             	mov    %rax,%r15
    fc2a:	4d 01 ee             	add    %r13,%r14
    fc2d:	4c 89 f7             	mov    %r14,%rdi
    fc30:	48 89 c2             	mov    %rax,%rdx
    fc33:	e8 38 37 ff ff       	call   3370 <bcmp@plt>
    fc38:	85 c0                	test   %eax,%eax
    fc3a:	0f 84 da 00 00 00    	je     fd1a <tp_list_of+0x1ea>
    fc40:	48 89 df             	mov    %rbx,%rdi
    fc43:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    fc48:	ff 54 24 10          	call   *0x10(%rsp)
    fc4c:	85 c0                	test   %eax,%eax
    fc4e:	0f 84 6f ff ff ff    	je     fbc3 <tp_list_of+0x93>
    fc54:	4c 8b 6b 08          	mov    0x8(%rbx),%r13
    fc58:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    fc5c:	4d 39 ee             	cmp    %r13,%r14
    fc5f:	73 31                	jae    fc92 <tp_list_of+0x162>
    fc61:	48 8b 03             	mov    (%rbx),%rax
    fc64:	48 8b 2c 24          	mov    (%rsp),%rbp
    fc68:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    fc6f:	00 
    fc70:	42 0f b6 0c 30       	movzbl (%rax,%r14,1),%ecx
    fc75:	48 83 f9 20          	cmp    $0x20,%rcx
    fc79:	77 1b                	ja     fc96 <tp_list_of+0x166>
    fc7b:	49 0f a3 cc          	bt     %rcx,%r12
    fc7f:	73 15                	jae    fc96 <tp_list_of+0x166>
    fc81:	49 ff c6             	inc    %r14
    fc84:	4c 89 73 10          	mov    %r14,0x10(%rbx)
    fc88:	4d 39 f5             	cmp    %r14,%r13
    fc8b:	75 e3                	jne    fc70 <tp_list_of+0x140>
    fc8d:	4d 89 ee             	mov    %r13,%r14
    fc90:	eb 04                	jmp    fc96 <tp_list_of+0x166>
    fc92:	48 8b 2c 24          	mov    (%rsp),%rbp
    fc96:	48 89 ef             	mov    %rbp,%rdi
    fc99:	e8 d2 34 ff ff       	call   3170 <strlen@plt>
    fc9e:	49 89 c7             	mov    %rax,%r15
    fca1:	4c 89 e8             	mov    %r13,%rax
    fca4:	4c 29 f0             	sub    %r14,%rax
    fca7:	4c 39 f8             	cmp    %r15,%rax
    fcaa:	72 15                	jb     fcc1 <tp_list_of+0x191>
    fcac:	48 8b 3b             	mov    (%rbx),%rdi
    fcaf:	4c 01 f7             	add    %r14,%rdi
    fcb2:	48 89 ee             	mov    %rbp,%rsi
    fcb5:	4c 89 fa             	mov    %r15,%rdx
    fcb8:	e8 b3 36 ff ff       	call   3370 <bcmp@plt>
    fcbd:	85 c0                	test   %eax,%eax
    fcbf:	74 6a                	je     fd2b <tp_list_of+0x1fb>
    fcc1:	4d 39 f5             	cmp    %r14,%r13
    fcc4:	76 2c                	jbe    fcf2 <tp_list_of+0x1c2>
    fcc6:	48 8b 03             	mov    (%rbx),%rax
    fcc9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    fcd0:	42 0f b6 0c 30       	movzbl (%rax,%r14,1),%ecx
    fcd5:	48 83 f9 20          	cmp    $0x20,%rcx
    fcd9:	77 17                	ja     fcf2 <tp_list_of+0x1c2>
    fcdb:	49 0f a3 cc          	bt     %rcx,%r12
    fcdf:	73 11                	jae    fcf2 <tp_list_of+0x1c2>
    fce1:	49 ff c6             	inc    %r14
    fce4:	4c 89 73 10          	mov    %r14,0x10(%rbx)
    fce8:	4d 39 f5             	cmp    %r14,%r13
    fceb:	75 e3                	jne    fcd0 <tp_list_of+0x1a0>
    fced:	e9 d1 fe ff ff       	jmp    fbc3 <tp_list_of+0x93>
    fcf2:	4d 39 f5             	cmp    %r14,%r13
    fcf5:	b8 00 00 00 00       	mov    $0x0,%eax
    fcfa:	0f 84 c5 fe ff ff    	je     fbc5 <tp_list_of+0x95>
    fd00:	48 8b 0b             	mov    (%rbx),%rcx
    fd03:	42 80 3c 31 2c       	cmpb   $0x2c,(%rcx,%r14,1)
    fd08:	0f 85 b7 fe ff ff    	jne    fbc5 <tp_list_of+0x95>
    fd0e:	49 ff c6             	inc    %r14
    fd11:	4c 89 73 10          	mov    %r14,0x10(%rbx)
    fd15:	e9 26 ff ff ff       	jmp    fc40 <tp_list_of+0x110>
    fd1a:	4d 01 ef             	add    %r13,%r15
    fd1d:	4c 89 7b 10          	mov    %r15,0x10(%rbx)
    fd21:	b8 01 00 00 00       	mov    $0x1,%eax
    fd26:	e9 9a fe ff ff       	jmp    fbc5 <tp_list_of+0x95>
    fd2b:	4d 01 f7             	add    %r14,%r15
    fd2e:	eb ed                	jmp    fd1d <tp_list_of+0x1ed>

000000000000fd30 <tp_byte_item>:
    fd30:	53                   	push   %rbx
    fd31:	48 83 ec 10          	sub    $0x10,%rsp
    fd35:	48 89 f3             	mov    %rsi,%rbx
    fd38:	48 8d 35 c1 9f 00 00 	lea    0x9fc1(%rip),%rsi        # 19d00 <tp_byte_item.u8d>
    fd3f:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    fd44:	e8 97 f2 ff ff       	call   efe0 <tp_int>
    fd49:	85 c0                	test   %eax,%eax
    fd4b:	74 14                	je     fd61 <tp_byte_item+0x31>
    fd4d:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    fd52:	48 89 df             	mov    %rbx,%rdi
    fd55:	e8 e6 07 00 00       	call   10540 <tp_push>
    fd5a:	b8 01 00 00 00       	mov    $0x1,%eax
    fd5f:	eb 02                	jmp    fd63 <tp_byte_item+0x33>
    fd61:	31 c0                	xor    %eax,%eax
    fd63:	48 83 c4 10          	add    $0x10,%rsp
    fd67:	5b                   	pop    %rbx
    fd68:	c3                   	ret
    fd69:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000fd70 <tp_token>:
    fd70:	41 57                	push   %r15
    fd72:	41 56                	push   %r14
    fd74:	41 54                	push   %r12
    fd76:	53                   	push   %rbx
    fd77:	50                   	push   %rax
    fd78:	49 89 f6             	mov    %rsi,%r14
    fd7b:	48 89 fb             	mov    %rdi,%rbx
    fd7e:	48 8b 37             	mov    (%rdi),%rsi
    fd81:	48 8b 47 08          	mov    0x8(%rdi),%rax
    fd85:	4c 8b 67 10          	mov    0x10(%rdi),%r12
    fd89:	49 39 c4             	cmp    %rax,%r12
    fd8c:	73 37                	jae    fdc5 <tp_token+0x55>
    fd8e:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    fd95:	00 00 00 
    fd98:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    fd9f:	00 
    fda0:	42 0f b6 3c 26       	movzbl (%rsi,%r12,1),%edi
    fda5:	48 83 ff 20          	cmp    $0x20,%rdi
    fda9:	77 1a                	ja     fdc5 <tp_token+0x55>
    fdab:	48 0f a3 f9          	bt     %rdi,%rcx
    fdaf:	73 14                	jae    fdc5 <tp_token+0x55>
    fdb1:	49 ff c4             	inc    %r12
    fdb4:	4c 89 63 10          	mov    %r12,0x10(%rbx)
    fdb8:	4c 39 e0             	cmp    %r12,%rax
    fdbb:	75 e3                	jne    fda0 <tp_token+0x30>
    fdbd:	49 89 c4             	mov    %rax,%r12
    fdc0:	48 89 c1             	mov    %rax,%rcx
    fdc3:	eb 49                	jmp    fe0e <tp_token+0x9e>
    fdc5:	49 39 c4             	cmp    %rax,%r12
    fdc8:	73 41                	jae    fe0b <tp_token+0x9b>
    fdca:	48 8d 3d 7b 55 00 00 	lea    0x557b(%rip),%rdi        # 1534c <_IO_stdin_used+0x34c>
    fdd1:	4c 89 e1             	mov    %r12,%rcx
    fdd4:	eb 1c                	jmp    fdf2 <tp_token+0x82>
    fdd6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    fddd:	00 00 00 
    fde0:	41 83 f8 7d          	cmp    $0x7d,%r8d
    fde4:	74 28                	je     fe0e <tp_token+0x9e>
    fde6:	48 ff c1             	inc    %rcx
    fde9:	48 89 4b 10          	mov    %rcx,0x10(%rbx)
    fded:	48 39 c8             	cmp    %rcx,%rax
    fdf0:	74 ce                	je     fdc0 <tp_token+0x50>
    fdf2:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
    fdf7:	45 8d 48 f7          	lea    -0x9(%r8),%r9d
    fdfb:	41 83 f9 54          	cmp    $0x54,%r9d
    fdff:	77 df                	ja     fde0 <tp_token+0x70>
    fe01:	4e 63 04 8f          	movslq (%rdi,%r9,4),%r8
    fe05:	49 01 f8             	add    %rdi,%r8
    fe08:	41 ff e0             	jmp    *%r8
    fe0b:	4c 89 e1             	mov    %r12,%rcx
    fe0e:	4c 29 e1             	sub    %r12,%rcx
    fe11:	4c 8d 7a ff          	lea    -0x1(%rdx),%r15
    fe15:	48 39 d1             	cmp    %rdx,%rcx
    fe18:	4c 0f 42 f9          	cmovb  %rcx,%r15
    fe1c:	4c 01 e6             	add    %r12,%rsi
    fe1f:	4c 89 f7             	mov    %r14,%rdi
    fe22:	4c 89 fa             	mov    %r15,%rdx
    fe25:	e8 06 35 ff ff       	call   3330 <memcpy@plt>
    fe2a:	43 c6 04 3e 00       	movb   $0x0,(%r14,%r15,1)
    fe2f:	48 8b 43 10          	mov    0x10(%rbx),%rax
    fe33:	4c 29 e0             	sub    %r12,%rax
    fe36:	48 83 c4 08          	add    $0x8,%rsp
    fe3a:	5b                   	pop    %rbx
    fe3b:	41 5c                	pop    %r12
    fe3d:	41 5e                	pop    %r14
    fe3f:	41 5f                	pop    %r15
    fe41:	c3                   	ret
    fe42:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    fe49:	1f 84 00 00 00 00 00 

000000000000fe50 <tp_elem_item>:
    fe50:	55                   	push   %rbp
    fe51:	53                   	push   %rbx
    fe52:	50                   	push   %rax
    fe53:	48 89 f3             	mov    %rsi,%rbx
    fe56:	48 8b 36             	mov    (%rsi),%rsi
    fe59:	31 ed                	xor    %ebp,%ebp
    fe5b:	48 89 e1             	mov    %rsp,%rcx
    fe5e:	31 d2                	xor    %edx,%edx
    fe60:	e8 6b d9 ff ff       	call   d7d0 <tp_value>
    fe65:	85 c0                	test   %eax,%eax
    fe67:	74 11                	je     fe7a <tp_elem_item+0x2a>
    fe69:	48 8b 34 24          	mov    (%rsp),%rsi
    fe6d:	48 89 df             	mov    %rbx,%rdi
    fe70:	e8 cb 06 00 00       	call   10540 <tp_push>
    fe75:	bd 01 00 00 00       	mov    $0x1,%ebp
    fe7a:	89 e8                	mov    %ebp,%eax
    fe7c:	48 83 c4 08          	add    $0x8,%rsp
    fe80:	5b                   	pop    %rbx
    fe81:	5d                   	pop    %rbp
    fe82:	c3                   	ret
    fe83:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    fe8a:	84 00 00 00 00 00 

000000000000fe90 <tp_kv_item>:
    fe90:	55                   	push   %rbp
    fe91:	41 56                	push   %r14
    fe93:	53                   	push   %rbx
    fe94:	48 83 ec 10          	sub    $0x10,%rsp
    fe98:	48 89 f3             	mov    %rsi,%rbx
    fe9b:	49 89 fe             	mov    %rdi,%r14
    fe9e:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
    fea5:	00 
    fea6:	48 8b 36             	mov    (%rsi),%rsi
    fea9:	31 ed                	xor    %ebp,%ebp
    feab:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    feb0:	31 d2                	xor    %edx,%edx
    feb2:	e8 19 d9 ff ff       	call   d7d0 <tp_value>
    feb7:	85 c0                	test   %eax,%eax
    feb9:	74 26                	je     fee1 <tp_kv_item+0x51>
    febb:	83 7b 28 00          	cmpl   $0x0,0x28(%rbx)
    febf:	74 2b                	je     feec <tp_kv_item+0x5c>
    fec1:	45 31 f6             	xor    %r14d,%r14d
    fec4:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    fec9:	48 89 df             	mov    %rbx,%rdi
    fecc:	e8 6f 06 00 00       	call   10540 <tp_push>
    fed1:	48 89 df             	mov    %rbx,%rdi
    fed4:	4c 89 f6             	mov    %r14,%rsi
    fed7:	e8 64 06 00 00       	call   10540 <tp_push>
    fedc:	bd 01 00 00 00       	mov    $0x1,%ebp
    fee1:	89 e8                	mov    %ebp,%eax
    fee3:	48 83 c4 10          	add    $0x10,%rsp
    fee7:	5b                   	pop    %rbx
    fee8:	41 5e                	pop    %r14
    feea:	5d                   	pop    %rbp
    feeb:	c3                   	ret
    feec:	49 8b 4e 08          	mov    0x8(%r14),%rcx
    fef0:	49 8b 46 10          	mov    0x10(%r14),%rax
    fef4:	48 39 c8             	cmp    %rcx,%rax
    fef7:	73 37                	jae    ff30 <tp_kv_item+0xa0>
    fef9:	49 8b 16             	mov    (%r14),%rdx
    fefc:	48 be 00 26 00 00 01 	movabs $0x100002600,%rsi
    ff03:	00 00 00 
    ff06:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    ff0d:	00 00 00 
    ff10:	0f b6 3c 02          	movzbl (%rdx,%rax,1),%edi
    ff14:	48 83 ff 20          	cmp    $0x20,%rdi
    ff18:	77 16                	ja     ff30 <tp_kv_item+0xa0>
    ff1a:	48 0f a3 fe          	bt     %rdi,%rsi
    ff1e:	73 10                	jae    ff30 <tp_kv_item+0xa0>
    ff20:	48 ff c0             	inc    %rax
    ff23:	49 89 46 10          	mov    %rax,0x10(%r14)
    ff27:	48 39 c1             	cmp    %rax,%rcx
    ff2a:	75 e4                	jne    ff10 <tp_kv_item+0x80>
    ff2c:	31 ed                	xor    %ebp,%ebp
    ff2e:	eb b1                	jmp    fee1 <tp_kv_item+0x51>
    ff30:	31 ed                	xor    %ebp,%ebp
    ff32:	48 39 c1             	cmp    %rax,%rcx
    ff35:	74 aa                	je     fee1 <tp_kv_item+0x51>
    ff37:	49 8b 0e             	mov    (%r14),%rcx
    ff3a:	80 3c 01 3a          	cmpb   $0x3a,(%rcx,%rax,1)
    ff3e:	75 a1                	jne    fee1 <tp_kv_item+0x51>
    ff40:	48 ff c0             	inc    %rax
    ff43:	49 89 46 10          	mov    %rax,0x10(%r14)
    ff47:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    ff4b:	31 ed                	xor    %ebp,%ebp
    ff4d:	48 89 e1             	mov    %rsp,%rcx
    ff50:	4c 89 f7             	mov    %r14,%rdi
    ff53:	31 d2                	xor    %edx,%edx
    ff55:	e8 76 d8 ff ff       	call   d7d0 <tp_value>
    ff5a:	85 c0                	test   %eax,%eax
    ff5c:	74 83                	je     fee1 <tp_kv_item+0x51>
    ff5e:	4c 8b 34 24          	mov    (%rsp),%r14
    ff62:	e9 5d ff ff ff       	jmp    fec4 <tp_kv_item+0x34>
    ff67:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    ff6e:	00 00 

000000000000ff70 <fwp_p_map_insert>:
    ff70:	55                   	push   %rbp
    ff71:	41 57                	push   %r15
    ff73:	41 56                	push   %r14
    ff75:	41 55                	push   %r13
    ff77:	41 54                	push   %r12
    ff79:	53                   	push   %rbx
    ff7a:	48 83 ec 28          	sub    $0x28,%rsp
    ff7e:	49 89 d7             	mov    %rdx,%r15
    ff81:	49 89 f8             	mov    %rdi,%r8
    ff84:	48 8b 1a             	mov    (%rdx),%rbx
    ff87:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
    ff8c:	8b 01                	mov    (%rcx),%eax
    ff8e:	83 f8 04             	cmp    $0x4,%eax
    ff91:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
    ff96:	72 61                	jb     fff9 <fwp_p_map_insert+0x89>
    ff98:	83 c0 fb             	add    $0xfffffffb,%eax
    ff9b:	83 f8 04             	cmp    $0x4,%eax
    ff9e:	0f 83 b7 00 00 00    	jae    1005b <fwp_p_map_insert+0xeb>
    ffa4:	48 85 db             	test   %rbx,%rbx
    ffa7:	0f 84 1d 01 00 00    	je     100ca <fwp_p_map_insert+0x15a>
    ffad:	45 31 e4             	xor    %r12d,%r12d
    ffb0:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    ffb7:	ff ff 1f 
    ffba:	48 89 d9             	mov    %rbx,%rcx
    ffbd:	eb 0d                	jmp    ffcc <fwp_p_map_insert+0x5c>
    ffbf:	90                   	nop
    ffc0:	48 89 d1             	mov    %rdx,%rcx
    ffc3:	49 39 cc             	cmp    %rcx,%r12
    ffc6:	0f 83 04 01 00 00    	jae    100d0 <fwp_p_map_insert+0x160>
    ffcc:	4a 8d 34 21          	lea    (%rcx,%r12,1),%rsi
    ffd0:	48 89 f2             	mov    %rsi,%rdx
    ffd3:	48 d1 ea             	shr    $1,%rdx
    ffd6:	48 21 c6             	and    %rax,%rsi
    ffd9:	49 8b 74 f7 08       	mov    0x8(%r15,%rsi,8),%rsi
    ffde:	4c 39 c6             	cmp    %r8,%rsi
    ffe1:	41 0f 95 c6          	setne  %r14b
    ffe5:	74 6f                	je     10056 <fwp_p_map_insert+0xe6>
    ffe7:	73 d7                	jae    ffc0 <fwp_p_map_insert+0x50>
    ffe9:	48 ff c2             	inc    %rdx
    ffec:	49 89 d4             	mov    %rdx,%r12
    ffef:	49 39 cc             	cmp    %rcx,%r12
    fff2:	72 d8                	jb     ffcc <fwp_p_map_insert+0x5c>
    fff4:	e9 d7 00 00 00       	jmp    100d0 <fwp_p_map_insert+0x160>
    fff9:	48 85 db             	test   %rbx,%rbx
    fffc:	0f 84 c8 00 00 00    	je     100ca <fwp_p_map_insert+0x15a>
   10002:	45 31 e4             	xor    %r12d,%r12d
   10005:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
   1000c:	ff ff 1f 
   1000f:	48 89 d9             	mov    %rbx,%rcx
   10012:	eb 18                	jmp    1002c <fwp_p_map_insert+0xbc>
   10014:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
   1001b:	00 00 00 00 00 
   10020:	48 89 d1             	mov    %rdx,%rcx
   10023:	49 39 cc             	cmp    %rcx,%r12
   10026:	0f 83 a4 00 00 00    	jae    100d0 <fwp_p_map_insert+0x160>
   1002c:	4a 8d 34 21          	lea    (%rcx,%r12,1),%rsi
   10030:	48 89 f2             	mov    %rsi,%rdx
   10033:	48 d1 ea             	shr    $1,%rdx
   10036:	48 21 c6             	and    %rax,%rsi
   10039:	49 8b 74 f7 08       	mov    0x8(%r15,%rsi,8),%rsi
   1003e:	4c 39 c6             	cmp    %r8,%rsi
   10041:	41 0f 95 c6          	setne  %r14b
   10045:	74 0f                	je     10056 <fwp_p_map_insert+0xe6>
   10047:	7d d7                	jge    10020 <fwp_p_map_insert+0xb0>
   10049:	48 ff c2             	inc    %rdx
   1004c:	49 89 d4             	mov    %rdx,%r12
   1004f:	49 39 cc             	cmp    %rcx,%r12
   10052:	72 d8                	jb     1002c <fwp_p_map_insert+0xbc>
   10054:	eb 7a                	jmp    100d0 <fwp_p_map_insert+0x160>
   10056:	49 89 d4             	mov    %rdx,%r12
   10059:	eb 75                	jmp    100d0 <fwp_p_map_insert+0x160>
   1005b:	48 85 db             	test   %rbx,%rbx
   1005e:	74 6a                	je     100ca <fwp_p_map_insert+0x15a>
   10060:	45 31 e4             	xor    %r12d,%r12d
   10063:	48 89 d8             	mov    %rbx,%rax
   10066:	48 89 5c 24 08       	mov    %rbx,0x8(%rsp)
   1006b:	eb 13                	jmp    10080 <fwp_p_map_insert+0x110>
   1006d:	0f 1f 00             	nopl   (%rax)
   10070:	48 89 d8             	mov    %rbx,%rax
   10073:	49 89 e8             	mov    %rbp,%r8
   10076:	49 39 c4             	cmp    %rax,%r12
   10079:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
   1007e:	73 50                	jae    100d0 <fwp_p_map_insert+0x160>
   10080:	49 89 c5             	mov    %rax,%r13
   10083:	4c 01 e0             	add    %r12,%rax
   10086:	48 89 c3             	mov    %rax,%rbx
   10089:	48 d1 eb             	shr    $1,%rbx
   1008c:	48 b9 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rcx
   10093:	ff ff 1f 
   10096:	48 21 c8             	and    %rcx,%rax
   10099:	49 8b 7c c7 08       	mov    0x8(%r15,%rax,8),%rdi
   1009e:	4c 89 c5             	mov    %r8,%rbp
   100a1:	4c 89 c6             	mov    %r8,%rsi
   100a4:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
   100a9:	e8 d2 05 00 00       	call   10680 <fwp_cmp>
   100ae:	85 c0                	test   %eax,%eax
   100b0:	41 0f 95 c6          	setne  %r14b
   100b4:	0f 84 5b 01 00 00    	je     10215 <fwp_p_map_insert+0x2a5>
   100ba:	79 b4                	jns    10070 <fwp_p_map_insert+0x100>
   100bc:	48 ff c3             	inc    %rbx
   100bf:	49 89 dc             	mov    %rbx,%r12
   100c2:	49 89 e8             	mov    %rbp,%r8
   100c5:	4c 89 e8             	mov    %r13,%rax
   100c8:	eb ac                	jmp    10076 <fwp_p_map_insert+0x106>
   100ca:	41 b6 01             	mov    $0x1,%r14b
   100cd:	45 31 e4             	xor    %r12d,%r12d
   100d0:	41 0f b6 ee          	movzbl %r14b,%ebp
   100d4:	48 01 dd             	add    %rbx,%rbp
   100d7:	48 89 e9             	mov    %rbp,%rcx
   100da:	48 c1 e1 04          	shl    $0x4,%rcx
   100de:	48 8d 79 08          	lea    0x8(%rcx),%rdi
   100e2:	48 ff 05 bf bd 00 00 	incq   0xbdbf(%rip)        # 1bea8 <measured_calls>
   100e9:	48 01 3d c0 bd 00 00 	add    %rdi,0xbdc0(%rip)        # 1beb0 <measured_bytes>
   100f0:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
   100f7:	4c 89 44 24 18       	mov    %r8,0x18(%rsp)
   100fc:	77 62                	ja     10160 <fwp_p_map_insert+0x1f0>
   100fe:	48 83 c1 17          	add    $0x17,%rcx
   10102:	48 c1 e9 04          	shr    $0x4,%rcx
   10106:	48 8d 05 7b a1 00 00 	lea    0xa17b(%rip),%rax        # 1a288 <fwp_gc>
   1010d:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
   10114:	00 
   10115:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
   1011c:	48 29 15 65 a1 00 00 	sub    %rdx,0xa165(%rip)        # 1a288 <fwp_gc>
   10123:	78 3b                	js     10160 <fwp_p_map_insert+0x1f0>
   10125:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
   10129:	48 8d 34 c8          	lea    (%rax,%rcx,8),%rsi
   1012d:	48 81 c6 88 07 00 00 	add    $0x788,%rsi
   10134:	4c 8b 2e             	mov    (%rsi),%r13
   10137:	4d 85 ed             	test   %r13,%r13
   1013a:	74 0c                	je     10148 <fwp_p_map_insert+0x1d8>
   1013c:	49 8b 45 00          	mov    0x0(%r13),%rax
   10140:	48 f7 d0             	not    %rax
   10143:	48 89 06             	mov    %rax,(%rsi)
   10146:	eb 38                	jmp    10180 <fwp_p_map_insert+0x210>
   10148:	4c 8b ac c8 90 07 00 	mov    0x790(%rax,%rcx,8),%r13
   1014f:	00 
   10150:	48 8b b4 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%rsi
   10157:	00 
   10158:	4c 29 ee             	sub    %r13,%rsi
   1015b:	48 39 d6             	cmp    %rdx,%rsi
   1015e:	73 0f                	jae    1016f <fwp_p_map_insert+0x1ff>
   10160:	be 02 00 00 00       	mov    $0x2,%esi
   10165:	e8 d6 81 ff ff       	call   8340 <fwp_gc_alloc_slow>
   1016a:	49 89 c5             	mov    %rax,%r13
   1016d:	eb 1b                	jmp    1018a <fwp_p_map_insert+0x21a>
   1016f:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
   10173:	48 05 90 07 00 00    	add    $0x790,%rax
   10179:	4a 8d 0c 2a          	lea    (%rdx,%r13,1),%rcx
   1017d:	48 89 08             	mov    %rcx,(%rax)
   10180:	4c 89 ef             	mov    %r13,%rdi
   10183:	31 f6                	xor    %esi,%esi
   10185:	e8 86 30 ff ff       	call   3210 <memset@plt>
   1018a:	49 89 6d 00          	mov    %rbp,0x0(%r13)
   1018e:	49 8d 6d 08          	lea    0x8(%r13),%rbp
   10192:	49 83 c7 08          	add    $0x8,%r15
   10196:	45 84 f6             	test   %r14b,%r14b
   10199:	74 48                	je     101e3 <fwp_p_map_insert+0x273>
   1019b:	4d 89 e6             	mov    %r12,%r14
   1019e:	49 c1 e6 04          	shl    $0x4,%r14
   101a2:	48 89 ef             	mov    %rbp,%rdi
   101a5:	4c 89 fe             	mov    %r15,%rsi
   101a8:	4c 89 f2             	mov    %r14,%rdx
   101ab:	e8 80 31 ff ff       	call   3330 <memcpy@plt>
   101b0:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
   101b5:	4b 89 44 35 08       	mov    %rax,0x8(%r13,%r14,1)
   101ba:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
   101bf:	4b 89 44 35 10       	mov    %rax,0x10(%r13,%r14,1)
   101c4:	49 8d 3c 2e          	lea    (%r14,%rbp,1),%rdi
   101c8:	48 83 c7 10          	add    $0x10,%rdi
   101cc:	4d 01 fe             	add    %r15,%r14
   101cf:	4c 29 e3             	sub    %r12,%rbx
   101d2:	48 c1 e3 04          	shl    $0x4,%rbx
   101d6:	4c 89 f6             	mov    %r14,%rsi
   101d9:	48 89 da             	mov    %rbx,%rdx
   101dc:	e8 4f 31 ff ff       	call   3330 <memcpy@plt>
   101e1:	eb 20                	jmp    10203 <fwp_p_map_insert+0x293>
   101e3:	48 c1 e3 04          	shl    $0x4,%rbx
   101e7:	48 89 ef             	mov    %rbp,%rdi
   101ea:	4c 89 fe             	mov    %r15,%rsi
   101ed:	48 89 da             	mov    %rbx,%rdx
   101f0:	e8 3b 31 ff ff       	call   3330 <memcpy@plt>
   101f5:	49 c1 e4 04          	shl    $0x4,%r12
   101f9:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
   101fe:	4b 89 44 25 10       	mov    %rax,0x10(%r13,%r12,1)
   10203:	4c 89 e8             	mov    %r13,%rax
   10206:	48 83 c4 28          	add    $0x28,%rsp
   1020a:	5b                   	pop    %rbx
   1020b:	41 5c                	pop    %r12
   1020d:	41 5d                	pop    %r13
   1020f:	41 5e                	pop    %r14
   10211:	41 5f                	pop    %r15
   10213:	5d                   	pop    %rbp
   10214:	c3                   	ret
   10215:	49 89 dc             	mov    %rbx,%r12
   10218:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
   1021d:	49 89 e8             	mov    %rbp,%r8
   10220:	e9 ab fe ff ff       	jmp    100d0 <fwp_p_map_insert+0x160>
   10225:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   1022c:	00 00 00 00 

0000000000010230 <fwp_record>:
   10230:	85 ff                	test   %edi,%edi
   10232:	0f 84 aa 00 00 00    	je     102e2 <fwp_record+0xb2>
   10238:	55                   	push   %rbp
   10239:	41 56                	push   %r14
   1023b:	53                   	push   %rbx
   1023c:	48 89 f3             	mov    %rsi,%rbx
   1023f:	41 89 fe             	mov    %edi,%r14d
   10242:	4a 8d 04 f5 08 00 00 	lea    0x8(,%r14,8),%rax
   10249:	00 
   1024a:	89 fd                	mov    %edi,%ebp
   1024c:	48 89 c7             	mov    %rax,%rdi
   1024f:	e8 0c a6 ff ff       	call   a860 <fwp_alloc_init>
   10254:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   1025a:	89 68 04             	mov    %ebp,0x4(%rax)
   1025d:	83 fd 08             	cmp    $0x8,%ebp
   10260:	72 10                	jb     10272 <fwp_record+0x42>
   10262:	48 89 c1             	mov    %rax,%rcx
   10265:	48 29 d9             	sub    %rbx,%rcx
   10268:	48 83 c1 08          	add    $0x8,%rcx
   1026c:	48 83 f9 20          	cmp    $0x20,%rcx
   10270:	73 73                	jae    102e5 <fwp_record+0xb5>
   10272:	31 c9                	xor    %ecx,%ecx
   10274:	4c 89 f6             	mov    %r14,%rsi
   10277:	48 89 ca             	mov    %rcx,%rdx
   1027a:	48 83 e6 03          	and    $0x3,%rsi
   1027e:	74 21                	je     102a1 <fwp_record+0x71>
   10280:	48 89 ca             	mov    %rcx,%rdx
   10283:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   1028a:	84 00 00 00 00 00 
   10290:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
   10294:	48 89 7c d0 08       	mov    %rdi,0x8(%rax,%rdx,8)
   10299:	48 ff c2             	inc    %rdx
   1029c:	48 ff ce             	dec    %rsi
   1029f:	75 ef                	jne    10290 <fwp_record+0x60>
   102a1:	4c 29 f1             	sub    %r14,%rcx
   102a4:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
   102a8:	77 7b                	ja     10325 <fwp_record+0xf5>
   102aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   102b0:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
   102b4:	48 89 4c d0 08       	mov    %rcx,0x8(%rax,%rdx,8)
   102b9:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
   102be:	48 89 4c d0 10       	mov    %rcx,0x10(%rax,%rdx,8)
   102c3:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
   102c8:	48 89 4c d0 18       	mov    %rcx,0x18(%rax,%rdx,8)
   102cd:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
   102d2:	48 89 4c d0 20       	mov    %rcx,0x20(%rax,%rdx,8)
   102d7:	48 83 c2 04          	add    $0x4,%rdx
   102db:	49 39 d6             	cmp    %rdx,%r14
   102de:	75 d0                	jne    102b0 <fwp_record+0x80>
   102e0:	eb 43                	jmp    10325 <fwp_record+0xf5>
   102e2:	31 c0                	xor    %eax,%eax
   102e4:	c3                   	ret
   102e5:	44 89 f1             	mov    %r14d,%ecx
   102e8:	83 e1 fc             	and    $0xfffffffc,%ecx
   102eb:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
   102f2:	00 
   102f3:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
   102f7:	31 f6                	xor    %esi,%esi
   102f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   10300:	0f 10 04 33          	movups (%rbx,%rsi,1),%xmm0
   10304:	0f 10 4c 33 10       	movups 0x10(%rbx,%rsi,1),%xmm1
   10309:	0f 11 44 30 08       	movups %xmm0,0x8(%rax,%rsi,1)
   1030e:	0f 11 4c 30 18       	movups %xmm1,0x18(%rax,%rsi,1)
   10313:	48 83 c6 20          	add    $0x20,%rsi
   10317:	48 39 f2             	cmp    %rsi,%rdx
   1031a:	75 e4                	jne    10300 <fwp_record+0xd0>
   1031c:	4c 39 f1             	cmp    %r14,%rcx
   1031f:	0f 85 4f ff ff ff    	jne    10274 <fwp_record+0x44>
   10325:	5b                   	pop    %rbx
   10326:	41 5e                	pop    %r14
   10328:	5d                   	pop    %rbp
   10329:	c3                   	ret
   1032a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000010330 <fwp_box_u128>:
   10330:	41 56                	push   %r14
   10332:	53                   	push   %rbx
   10333:	50                   	push   %rax
   10334:	48 ff 05 6d bb 00 00 	incq   0xbb6d(%rip)        # 1bea8 <measured_calls>
   1033b:	48 83 05 6d bb 00 00 	addq   $0x10,0xbb6d(%rip)        # 1beb0 <measured_bytes>
   10342:	10 
   10343:	48 8d 0d 3e 9f 00 00 	lea    0x9f3e(%rip),%rcx        # 1a288 <fwp_gc>
   1034a:	0f b6 05 20 ab 00 00 	movzbl 0xab20(%rip),%eax        # 1ae71 <fwp_gc+0xbe9>
   10351:	8b 94 81 48 0b 00 00 	mov    0xb48(%rcx,%rax,4),%edx
   10358:	48 29 15 29 9f 00 00 	sub    %rdx,0x9f29(%rip)        # 1a288 <fwp_gc>
   1035f:	78 3a                	js     1039b <fwp_box_u128+0x6b>
   10361:	4c 8d 04 40          	lea    (%rax,%rax,2),%r8
   10365:	4e 8d 0c c1          	lea    (%rcx,%r8,8),%r9
   10369:	49 81 c1 c8 03 00 00 	add    $0x3c8,%r9
   10370:	49 8b 01             	mov    (%r9),%rax
   10373:	48 85 c0             	test   %rax,%rax
   10376:	74 0b                	je     10383 <fwp_box_u128+0x53>
   10378:	48 8b 08             	mov    (%rax),%rcx
   1037b:	48 f7 d1             	not    %rcx
   1037e:	49 89 09             	mov    %rcx,(%r9)
   10381:	eb 46                	jmp    103c9 <fwp_box_u128+0x99>
   10383:	4a 8b 84 c1 d0 03 00 	mov    0x3d0(%rcx,%r8,8),%rax
   1038a:	00 
   1038b:	4e 8b 8c c1 d8 03 00 	mov    0x3d8(%rcx,%r8,8),%r9
   10392:	00 
   10393:	49 29 c1             	sub    %rax,%r9
   10396:	49 39 d1             	cmp    %rdx,%r9
   10399:	73 1d                	jae    103b8 <fwp_box_u128+0x88>
   1039b:	48 89 fb             	mov    %rdi,%rbx
   1039e:	bf 10 00 00 00       	mov    $0x10,%edi
   103a3:	49 89 f6             	mov    %rsi,%r14
   103a6:	be 01 00 00 00       	mov    $0x1,%esi
   103ab:	e8 90 7f ff ff       	call   8340 <fwp_gc_alloc_slow>
   103b0:	4c 89 f6             	mov    %r14,%rsi
   103b3:	48 89 df             	mov    %rbx,%rdi
   103b6:	eb 17                	jmp    103cf <fwp_box_u128+0x9f>
   103b8:	4a 8d 0c c1          	lea    (%rcx,%r8,8),%rcx
   103bc:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
   103c3:	48 01 c2             	add    %rax,%rdx
   103c6:	48 89 11             	mov    %rdx,(%rcx)
   103c9:	0f 57 c0             	xorps  %xmm0,%xmm0
   103cc:	0f 11 00             	movups %xmm0,(%rax)
   103cf:	48 89 70 08          	mov    %rsi,0x8(%rax)
   103d3:	48 89 38             	mov    %rdi,(%rax)
   103d6:	48 83 c4 08          	add    $0x8,%rsp
   103da:	5b                   	pop    %rbx
   103db:	41 5e                	pop    %r14
   103dd:	c3                   	ret
   103de:	66 90                	xchg   %ax,%ax

00000000000103e0 <fwp_box_i128>:
   103e0:	41 56                	push   %r14
   103e2:	53                   	push   %rbx
   103e3:	50                   	push   %rax
   103e4:	48 ff 05 bd ba 00 00 	incq   0xbabd(%rip)        # 1bea8 <measured_calls>
   103eb:	48 83 05 bd ba 00 00 	addq   $0x10,0xbabd(%rip)        # 1beb0 <measured_bytes>
   103f2:	10 
   103f3:	48 8d 0d 8e 9e 00 00 	lea    0x9e8e(%rip),%rcx        # 1a288 <fwp_gc>
   103fa:	0f b6 05 70 aa 00 00 	movzbl 0xaa70(%rip),%eax        # 1ae71 <fwp_gc+0xbe9>
   10401:	8b 94 81 48 0b 00 00 	mov    0xb48(%rcx,%rax,4),%edx
   10408:	48 29 15 79 9e 00 00 	sub    %rdx,0x9e79(%rip)        # 1a288 <fwp_gc>
   1040f:	78 3a                	js     1044b <fwp_box_i128+0x6b>
   10411:	4c 8d 04 40          	lea    (%rax,%rax,2),%r8
   10415:	4e 8d 0c c1          	lea    (%rcx,%r8,8),%r9
   10419:	49 81 c1 c8 03 00 00 	add    $0x3c8,%r9
   10420:	49 8b 01             	mov    (%r9),%rax
   10423:	48 85 c0             	test   %rax,%rax
   10426:	74 0b                	je     10433 <fwp_box_i128+0x53>
   10428:	48 8b 08             	mov    (%rax),%rcx
   1042b:	48 f7 d1             	not    %rcx
   1042e:	49 89 09             	mov    %rcx,(%r9)
   10431:	eb 46                	jmp    10479 <fwp_box_i128+0x99>
   10433:	4a 8b 84 c1 d0 03 00 	mov    0x3d0(%rcx,%r8,8),%rax
   1043a:	00 
   1043b:	4e 8b 8c c1 d8 03 00 	mov    0x3d8(%rcx,%r8,8),%r9
   10442:	00 
   10443:	49 29 c1             	sub    %rax,%r9
   10446:	49 39 d1             	cmp    %rdx,%r9
   10449:	73 1d                	jae    10468 <fwp_box_i128+0x88>
   1044b:	48 89 fb             	mov    %rdi,%rbx
   1044e:	bf 10 00 00 00       	mov    $0x10,%edi
   10453:	49 89 f6             	mov    %rsi,%r14
   10456:	be 01 00 00 00       	mov    $0x1,%esi
   1045b:	e8 e0 7e ff ff       	call   8340 <fwp_gc_alloc_slow>
   10460:	4c 89 f6             	mov    %r14,%rsi
   10463:	48 89 df             	mov    %rbx,%rdi
   10466:	eb 17                	jmp    1047f <fwp_box_i128+0x9f>
   10468:	4a 8d 0c c1          	lea    (%rcx,%r8,8),%rcx
   1046c:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
   10473:	48 01 c2             	add    %rax,%rdx
   10476:	48 89 11             	mov    %rdx,(%rcx)
   10479:	0f 57 c0             	xorps  %xmm0,%xmm0
   1047c:	0f 11 00             	movups %xmm0,(%rax)
   1047f:	48 89 70 08          	mov    %rsi,0x8(%rax)
   10483:	48 89 38             	mov    %rdi,(%rax)
   10486:	48 83 c4 08          	add    $0x8,%rsp
   1048a:	5b                   	pop    %rbx
   1048b:	41 5e                	pop    %r14
   1048d:	c3                   	ret
   1048e:	66 90                	xchg   %ax,%ax

0000000000010490 <fwp_utf8_put>:
   10490:	50                   	push   %rax
   10491:	83 fe 7f             	cmp    $0x7f,%esi
   10494:	77 0f                	ja     104a5 <fwp_utf8_put+0x15>
   10496:	40 88 74 24 04       	mov    %sil,0x4(%rsp)
   1049b:	ba 01 00 00 00       	mov    $0x1,%edx
   104a0:	e9 8e 00 00 00       	jmp    10533 <fwp_utf8_put+0xa3>
   104a5:	89 f0                	mov    %esi,%eax
   104a7:	81 fe ff 07 00 00    	cmp    $0x7ff,%esi
   104ad:	77 1d                	ja     104cc <fwp_utf8_put+0x3c>
   104af:	c1 e8 06             	shr    $0x6,%eax
   104b2:	0c c0                	or     $0xc0,%al
   104b4:	88 44 24 04          	mov    %al,0x4(%rsp)
   104b8:	40 80 e6 3f          	and    $0x3f,%sil
   104bc:	40 80 ce 80          	or     $0x80,%sil
   104c0:	40 88 74 24 05       	mov    %sil,0x5(%rsp)
   104c5:	ba 02 00 00 00       	mov    $0x2,%edx
   104ca:	eb 67                	jmp    10533 <fwp_utf8_put+0xa3>
   104cc:	81 fe ff ff 00 00    	cmp    $0xffff,%esi
   104d2:	77 2a                	ja     104fe <fwp_utf8_put+0x6e>
   104d4:	c1 e8 0c             	shr    $0xc,%eax
   104d7:	0c e0                	or     $0xe0,%al
   104d9:	88 44 24 04          	mov    %al,0x4(%rsp)
   104dd:	89 f0                	mov    %esi,%eax
   104df:	c1 e8 06             	shr    $0x6,%eax
   104e2:	24 3f                	and    $0x3f,%al
   104e4:	0c 80                	or     $0x80,%al
   104e6:	88 44 24 05          	mov    %al,0x5(%rsp)
   104ea:	40 80 e6 3f          	and    $0x3f,%sil
   104ee:	40 80 ce 80          	or     $0x80,%sil
   104f2:	40 88 74 24 06       	mov    %sil,0x6(%rsp)
   104f7:	ba 03 00 00 00       	mov    $0x3,%edx
   104fc:	eb 35                	jmp    10533 <fwp_utf8_put+0xa3>
   104fe:	c1 e8 12             	shr    $0x12,%eax
   10501:	0c f0                	or     $0xf0,%al
   10503:	88 44 24 04          	mov    %al,0x4(%rsp)
   10507:	89 f0                	mov    %esi,%eax
   10509:	c1 e8 0c             	shr    $0xc,%eax
   1050c:	24 3f                	and    $0x3f,%al
   1050e:	0c 80                	or     $0x80,%al
   10510:	88 44 24 05          	mov    %al,0x5(%rsp)
   10514:	89 f0                	mov    %esi,%eax
   10516:	c1 e8 06             	shr    $0x6,%eax
   10519:	24 3f                	and    $0x3f,%al
   1051b:	0c 80                	or     $0x80,%al
   1051d:	88 44 24 06          	mov    %al,0x6(%rsp)
   10521:	40 80 e6 3f          	and    $0x3f,%sil
   10525:	40 80 ce 80          	or     $0x80,%sil
   10529:	40 88 74 24 07       	mov    %sil,0x7(%rsp)
   1052e:	ba 04 00 00 00       	mov    $0x4,%edx
   10533:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
   10538:	e8 53 cd ff ff       	call   d290 <buf_put>
   1053d:	58                   	pop    %rax
   1053e:	c3                   	ret
   1053f:	90                   	nop

0000000000010540 <tp_push>:
   10540:	55                   	push   %rbp
   10541:	41 57                	push   %r15
   10543:	41 56                	push   %r14
   10545:	41 55                	push   %r13
   10547:	41 54                	push   %r12
   10549:	53                   	push   %rbx
   1054a:	50                   	push   %rax
   1054b:	48 89 f3             	mov    %rsi,%rbx
   1054e:	49 89 fe             	mov    %rdi,%r14
   10551:	4c 8b 7f 18          	mov    0x18(%rdi),%r15
   10555:	4c 3b 7f 20          	cmp    0x20(%rdi),%r15
   10559:	75 7d                	jne    105d8 <tp_push+0x98>
   1055b:	4b 8d 04 3f          	lea    (%r15,%r15,1),%rax
   1055f:	4d 85 ff             	test   %r15,%r15
   10562:	41 bd 08 00 00 00    	mov    $0x8,%r13d
   10568:	4c 0f 45 e8          	cmovne %rax,%r13
   1056c:	4d 89 6e 20          	mov    %r13,0x20(%r14)
   10570:	4d 8b 66 10          	mov    0x10(%r14),%r12
   10574:	49 c1 e5 03          	shl    $0x3,%r13
   10578:	48 ff 05 29 b9 00 00 	incq   0xb929(%rip)        # 1bea8 <measured_calls>
   1057f:	4c 01 2d 2a b9 00 00 	add    %r13,0xb92a(%rip)        # 1beb0 <measured_bytes>
   10586:	49 81 fd 00 40 00 00 	cmp    $0x4000,%r13
   1058d:	77 67                	ja     105f6 <tp_push+0xb6>
   1058f:	4c 89 e9             	mov    %r13,%rcx
   10592:	48 c1 e9 04          	shr    $0x4,%rcx
   10596:	48 8d 05 eb 9c 00 00 	lea    0x9ceb(%rip),%rax        # 1a288 <fwp_gc>
   1059d:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
   105a4:	00 
   105a5:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
   105ac:	48 29 15 d5 9c 00 00 	sub    %rdx,0x9cd5(%rip)        # 1a288 <fwp_gc>
   105b3:	78 41                	js     105f6 <tp_push+0xb6>
   105b5:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
   105b9:	48 8d 34 c8          	lea    (%rax,%rcx,8),%rsi
   105bd:	48 81 c6 88 07 00 00 	add    $0x788,%rsi
   105c4:	48 8b 2e             	mov    (%rsi),%rbp
   105c7:	48 85 ed             	test   %rbp,%rbp
   105ca:	74 12                	je     105de <tp_push+0x9e>
   105cc:	48 8b 45 00          	mov    0x0(%rbp),%rax
   105d0:	48 f7 d0             	not    %rax
   105d3:	48 89 06             	mov    %rax,(%rsi)
   105d6:	eb 46                	jmp    1061e <tp_push+0xde>
   105d8:	49 8b 6e 10          	mov    0x10(%r14),%rbp
   105dc:	eb 78                	jmp    10656 <tp_push+0x116>
   105de:	48 8b ac c8 90 07 00 	mov    0x790(%rax,%rcx,8),%rbp
   105e5:	00 
   105e6:	48 8b b4 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%rsi
   105ed:	00 
   105ee:	48 29 ee             	sub    %rbp,%rsi
   105f1:	48 39 d6             	cmp    %rdx,%rsi
   105f4:	73 17                	jae    1060d <tp_push+0xcd>
   105f6:	4c 89 ef             	mov    %r13,%rdi
   105f9:	be 02 00 00 00       	mov    $0x2,%esi
   105fe:	e8 3d 7d ff ff       	call   8340 <fwp_gc_alloc_slow>
   10603:	48 89 c5             	mov    %rax,%rbp
   10606:	4d 85 e4             	test   %r12,%r12
   10609:	75 22                	jne    1062d <tp_push+0xed>
   1060b:	eb 41                	jmp    1064e <tp_push+0x10e>
   1060d:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
   10611:	48 05 90 07 00 00    	add    $0x790,%rax
   10617:	48 8d 0c 2a          	lea    (%rdx,%rbp,1),%rcx
   1061b:	48 89 08             	mov    %rcx,(%rax)
   1061e:	48 89 ef             	mov    %rbp,%rdi
   10621:	31 f6                	xor    %esi,%esi
   10623:	e8 e8 2b ff ff       	call   3210 <memset@plt>
   10628:	4d 85 e4             	test   %r12,%r12
   1062b:	74 21                	je     1064e <tp_push+0x10e>
   1062d:	49 c1 e7 03          	shl    $0x3,%r15
   10631:	4d 39 ef             	cmp    %r13,%r15
   10634:	4d 0f 43 fd          	cmovae %r13,%r15
   10638:	48 89 ef             	mov    %rbp,%rdi
   1063b:	4c 89 e6             	mov    %r12,%rsi
   1063e:	4c 89 fa             	mov    %r15,%rdx
   10641:	e8 ea 2c ff ff       	call   3330 <memcpy@plt>
   10646:	4c 89 e7             	mov    %r12,%rdi
   10649:	e8 52 a5 ff ff       	call   aba0 <fwp_mem_free>
   1064e:	49 89 6e 10          	mov    %rbp,0x10(%r14)
   10652:	4d 8b 7e 18          	mov    0x18(%r14),%r15
   10656:	49 8d 47 01          	lea    0x1(%r15),%rax
   1065a:	49 89 46 18          	mov    %rax,0x18(%r14)
   1065e:	4a 89 5c fd 00       	mov    %rbx,0x0(%rbp,%r15,8)
   10663:	48 83 c4 08          	add    $0x8,%rsp
   10667:	5b                   	pop    %rbx
   10668:	41 5c                	pop    %r12
   1066a:	41 5d                	pop    %r13
   1066c:	41 5e                	pop    %r14
   1066e:	41 5f                	pop    %r15
   10670:	5d                   	pop    %rbp
   10671:	c3                   	ret
   10672:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   10679:	1f 84 00 00 00 00 00 

0000000000010680 <fwp_cmp>:
   10680:	55                   	push   %rbp
   10681:	41 57                	push   %r15
   10683:	41 56                	push   %r14
   10685:	41 55                	push   %r13
   10687:	41 54                	push   %r12
   10689:	53                   	push   %rbx
   1068a:	48 83 ec 28          	sub    $0x28,%rsp
   1068e:	48 89 f3             	mov    %rsi,%rbx
   10691:	49 89 fe             	mov    %rdi,%r14
   10694:	44 8b 2a             	mov    (%rdx),%r13d
   10697:	49 83 fd 15          	cmp    $0x15,%r13
   1069b:	77 25                	ja     106c2 <fwp_cmp+0x42>
   1069d:	49 89 d7             	mov    %rdx,%r15
   106a0:	48 8d 05 f9 4d 00 00 	lea    0x4df9(%rip),%rax        # 154a0 <_IO_stdin_used+0x4a0>
   106a7:	4a 63 0c a8          	movslq (%rax,%r13,4),%rcx
   106ab:	48 01 c1             	add    %rax,%rcx
   106ae:	ff e1                	jmp    *%rcx
   106b0:	31 c9                	xor    %ecx,%ecx
   106b2:	49 39 de             	cmp    %rbx,%r14
   106b5:	0f 9f c1             	setg   %cl
   106b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   106bd:	0f 4d c1             	cmovge %ecx,%eax
   106c0:	eb 10                	jmp    106d2 <fwp_cmp+0x52>
   106c2:	31 c9                	xor    %ecx,%ecx
   106c4:	49 39 de             	cmp    %rbx,%r14
   106c7:	0f 97 c1             	seta   %cl
   106ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   106cf:	0f 43 c1             	cmovae %ecx,%eax
   106d2:	48 83 c4 28          	add    $0x28,%rsp
   106d6:	5b                   	pop    %rbx
   106d7:	41 5c                	pop    %r12
   106d9:	41 5d                	pop    %r13
   106db:	41 5e                	pop    %r14
   106dd:	41 5f                	pop    %r15
   106df:	5d                   	pop    %rbp
   106e0:	c3                   	ret
   106e1:	4d 8b 3e             	mov    (%r14),%r15
   106e4:	4c 8b 23             	mov    (%rbx),%r12
   106e7:	49 83 c6 08          	add    $0x8,%r14
   106eb:	48 83 c3 08          	add    $0x8,%rbx
   106ef:	4d 39 e7             	cmp    %r12,%r15
   106f2:	4c 89 e2             	mov    %r12,%rdx
   106f5:	49 0f 42 d7          	cmovb  %r15,%rdx
   106f9:	4c 89 f7             	mov    %r14,%rdi
   106fc:	48 89 de             	mov    %rbx,%rsi
   106ff:	e8 6c 2b ff ff       	call   3270 <memcmp@plt>
   10704:	85 c0                	test   %eax,%eax
   10706:	0f 84 bb 03 00 00    	je     10ac7 <fwp_cmp+0x447>
   1070c:	c1 f8 1f             	sar    $0x1f,%eax
   1070f:	83 c8 01             	or     $0x1,%eax
   10712:	eb be                	jmp    106d2 <fwp_cmp+0x52>
   10714:	49 8b 06             	mov    (%r14),%rax
   10717:	48 8b 2b             	mov    (%rbx),%rbp
   1071a:	48 39 e8             	cmp    %rbp,%rax
   1071d:	48 89 2c 24          	mov    %rbp,(%rsp)
   10721:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
   10726:	48 0f 42 e8          	cmovb  %rax,%rbp
   1072a:	48 85 ed             	test   %rbp,%rbp
   1072d:	74 56                	je     10785 <fwp_cmp+0x105>
   1072f:	49 8b 47 38          	mov    0x38(%r15),%rax
   10733:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
   10738:	41 bc 10 00 00 00    	mov    $0x10,%r12d
   1073e:	eb 09                	jmp    10749 <fwp_cmp+0xc9>
   10740:	49 83 c4 10          	add    $0x10,%r12
   10744:	48 ff cd             	dec    %rbp
   10747:	74 3c                	je     10785 <fwp_cmp+0x105>
   10749:	4b 8b 7c 26 f8       	mov    -0x8(%r14,%r12,1),%rdi
   1074e:	4a 8b 74 23 f8       	mov    -0x8(%rbx,%r12,1),%rsi
   10753:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
   10758:	e8 23 ff ff ff       	call   10680 <fwp_cmp>
   1075d:	85 c0                	test   %eax,%eax
   1075f:	0f 85 6d ff ff ff    	jne    106d2 <fwp_cmp+0x52>
   10765:	41 83 fd 12          	cmp    $0x12,%r13d
   10769:	75 d5                	jne    10740 <fwp_cmp+0xc0>
   1076b:	4b 8b 3c 26          	mov    (%r14,%r12,1),%rdi
   1076f:	4a 8b 34 23          	mov    (%rbx,%r12,1),%rsi
   10773:	49 8b 57 40          	mov    0x40(%r15),%rdx
   10777:	e8 04 ff ff ff       	call   10680 <fwp_cmp>
   1077c:	85 c0                	test   %eax,%eax
   1077e:	74 c0                	je     10740 <fwp_cmp+0xc0>
   10780:	e9 4d ff ff ff       	jmp    106d2 <fwp_cmp+0x52>
   10785:	31 c9                	xor    %ecx,%ecx
   10787:	48 8b 04 24          	mov    (%rsp),%rax
   1078b:	48 39 44 24 08       	cmp    %rax,0x8(%rsp)
   10790:	e9 32 ff ff ff       	jmp    106c7 <fwp_cmp+0x47>
   10795:	49 8b 16             	mov    (%r14),%rdx
   10798:	49 8b 4e 08          	mov    0x8(%r14),%rcx
   1079c:	48 8b 3b             	mov    (%rbx),%rdi
   1079f:	48 8b 73 08          	mov    0x8(%rbx),%rsi
   107a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   107a8:	48 39 fa             	cmp    %rdi,%rdx
   107ab:	49 89 c8             	mov    %rcx,%r8
   107ae:	49 19 f0             	sbb    %rsi,%r8
   107b1:	0f 82 1b ff ff ff    	jb     106d2 <fwp_cmp+0x52>
   107b7:	48 39 d7             	cmp    %rdx,%rdi
   107ba:	48 19 ce             	sbb    %rcx,%rsi
   107bd:	0f 92 c0             	setb   %al
   107c0:	0f b6 c0             	movzbl %al,%eax
   107c3:	e9 0a ff ff ff       	jmp    106d2 <fwp_cmp+0x52>
   107c8:	44 89 f1             	mov    %r14d,%ecx
   107cb:	c1 f9 1f             	sar    $0x1f,%ecx
   107ce:	d1 e9                	shr    $1,%ecx
   107d0:	44 31 f1             	xor    %r14d,%ecx
   107d3:	89 da                	mov    %ebx,%edx
   107d5:	c1 fa 1f             	sar    $0x1f,%edx
   107d8:	d1 ea                	shr    $1,%edx
   107da:	31 da                	xor    %ebx,%edx
   107dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   107e1:	39 d1                	cmp    %edx,%ecx
   107e3:	0f 8c e9 fe ff ff    	jl     106d2 <fwp_cmp+0x52>
   107e9:	eb 28                	jmp    10813 <fwp_cmp+0x193>
   107eb:	4c 89 f1             	mov    %r14,%rcx
   107ee:	48 c1 f9 3f          	sar    $0x3f,%rcx
   107f2:	48 d1 e9             	shr    $1,%rcx
   107f5:	4c 31 f1             	xor    %r14,%rcx
   107f8:	48 89 da             	mov    %rbx,%rdx
   107fb:	48 c1 fa 3f          	sar    $0x3f,%rdx
   107ff:	48 d1 ea             	shr    $1,%rdx
   10802:	48 31 da             	xor    %rbx,%rdx
   10805:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   1080a:	48 39 d1             	cmp    %rdx,%rcx
   1080d:	0f 8c bf fe ff ff    	jl     106d2 <fwp_cmp+0x52>
   10813:	0f 9f c0             	setg   %al
   10816:	0f b6 c0             	movzbl %al,%eax
   10819:	e9 b4 fe ff ff       	jmp    106d2 <fwp_cmp+0x52>
   1081e:	49 8b 16             	mov    (%r14),%rdx
   10821:	49 8b 4e 08          	mov    0x8(%r14),%rcx
   10825:	48 8b 3b             	mov    (%rbx),%rdi
   10828:	48 8b 73 08          	mov    0x8(%rbx),%rsi
   1082c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   10831:	48 39 fa             	cmp    %rdi,%rdx
   10834:	49 89 c8             	mov    %rcx,%r8
   10837:	49 19 f0             	sbb    %rsi,%r8
   1083a:	0f 8c 92 fe ff ff    	jl     106d2 <fwp_cmp+0x52>
   10840:	48 39 d7             	cmp    %rdx,%rdi
   10843:	48 19 ce             	sbb    %rcx,%rsi
   10846:	0f 9c c0             	setl   %al
   10849:	0f b6 c0             	movzbl %al,%eax
   1084c:	e9 81 fe ff ff       	jmp    106d2 <fwp_cmp+0x52>
   10851:	4d 85 f6             	test   %r14,%r14
   10854:	0f 94 c0             	sete   %al
   10857:	74 44                	je     1089d <fwp_cmp+0x21d>
   10859:	48 85 db             	test   %rbx,%rbx
   1085c:	74 3f                	je     1089d <fwp_cmp+0x21d>
   1085e:	4d 8b 7f 38          	mov    0x38(%r15),%r15
   10862:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   10869:	1f 84 00 00 00 00 00 
   10870:	49 8b 7e 08          	mov    0x8(%r14),%rdi
   10874:	48 8b 73 08          	mov    0x8(%rbx),%rsi
   10878:	4c 89 fa             	mov    %r15,%rdx
   1087b:	e8 00 fe ff ff       	call   10680 <fwp_cmp>
   10880:	85 c0                	test   %eax,%eax
   10882:	0f 85 4a fe ff ff    	jne    106d2 <fwp_cmp+0x52>
   10888:	4d 8b 76 10          	mov    0x10(%r14),%r14
   1088c:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
   10890:	4d 85 f6             	test   %r14,%r14
   10893:	0f 94 c0             	sete   %al
   10896:	74 05                	je     1089d <fwp_cmp+0x21d>
   10898:	48 85 db             	test   %rbx,%rbx
   1089b:	75 d3                	jne    10870 <fwp_cmp+0x1f0>
   1089d:	48 85 db             	test   %rbx,%rbx
   108a0:	0f 95 c1             	setne  %cl
   108a3:	08 c1                	or     %al,%cl
   108a5:	80 f1 01             	xor    $0x1,%cl
   108a8:	0f b6 c9             	movzbl %cl,%ecx
   108ab:	84 c0                	test   %al,%al
   108ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   108b2:	0f 44 c1             	cmove  %ecx,%eax
   108b5:	48 85 db             	test   %rbx,%rbx
   108b8:	0f 44 c1             	cmove  %ecx,%eax
   108bb:	e9 12 fe ff ff       	jmp    106d2 <fwp_cmp+0x52>
   108c0:	45 8b 67 10          	mov    0x10(%r15),%r12d
   108c4:	45 85 e4             	test   %r12d,%r12d
   108c7:	0f 8e 5d 02 00 00    	jle    10b2a <fwp_cmp+0x4aa>
   108cd:	4d 8b 7f 20          	mov    0x20(%r15),%r15
   108d1:	45 31 ed             	xor    %r13d,%r13d
   108d4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
   108db:	00 00 00 00 00 
   108e0:	4b 8b 7c ee 08       	mov    0x8(%r14,%r13,8),%rdi
   108e5:	4a 8b 74 eb 08       	mov    0x8(%rbx,%r13,8),%rsi
   108ea:	4b 8b 14 ef          	mov    (%r15,%r13,8),%rdx
   108ee:	e8 8d fd ff ff       	call   10680 <fwp_cmp>
   108f3:	85 c0                	test   %eax,%eax
   108f5:	0f 85 d7 fd ff ff    	jne    106d2 <fwp_cmp+0x52>
   108fb:	49 ff c5             	inc    %r13
   108fe:	31 c0                	xor    %eax,%eax
   10900:	4d 39 ec             	cmp    %r13,%r12
   10903:	75 db                	jne    108e0 <fwp_cmp+0x260>
   10905:	e9 c8 fd ff ff       	jmp    106d2 <fwp_cmp+0x52>
   1090a:	49 8b 06             	mov    (%r14),%rax
   1090d:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
   10914:	ff ff 7f 
   10917:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
   1091c:	4c 21 e0             	and    %r12,%rax
   1091f:	4c 8b 2b             	mov    (%rbx),%r13
   10922:	4d 21 ec             	and    %r13,%r12
   10925:	4c 39 e0             	cmp    %r12,%rax
   10928:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
   1092d:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
   10932:	4c 0f 42 e0          	cmovb  %rax,%r12
   10936:	4d 85 e4             	test   %r12,%r12
   10939:	0f 84 51 01 00 00    	je     10a90 <fwp_cmp+0x410>
   1093f:	4d 8b 7f 38          	mov    0x38(%r15),%r15
   10943:	49 8d 46 08          	lea    0x8(%r14),%rax
   10947:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
   1094c:	48 8d 43 08          	lea    0x8(%rbx),%rax
   10950:	48 89 04 24          	mov    %rax,(%rsp)
   10954:	31 ed                	xor    %ebp,%ebp
   10956:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   1095d:	00 00 00 
   10960:	b8 08 00 00 00       	mov    $0x8,%eax
   10965:	4d 85 ff             	test   %r15,%r15
   10968:	74 14                	je     1097e <fwp_cmp+0x2fe>
   1096a:	41 8b 0f             	mov    (%r15),%ecx
   1096d:	48 83 f9 0a          	cmp    $0xa,%rcx
   10971:	77 0b                	ja     1097e <fwp_cmp+0x2fe>
   10973:	48 8d 05 76 4f 00 00 	lea    0x4f76(%rip),%rax        # 158f0 <exec_in_fp0+0x80>
   1097a:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
   1097e:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
   10983:	48 83 7c 24 10 00    	cmpq   $0x0,0x10(%rsp)
   10989:	79 04                	jns    1098f <fwp_cmp+0x30f>
   1098b:	49 8b 4e 10          	mov    0x10(%r14),%rcx
   1098f:	48 89 c2             	mov    %rax,%rdx
   10992:	48 0f af d5          	imul   %rbp,%rdx
   10996:	48 83 f8 08          	cmp    $0x8,%rax
   1099a:	74 2b                	je     109c7 <fwp_cmp+0x347>
   1099c:	48 83 f8 02          	cmp    $0x2,%rax
   109a0:	74 15                	je     109b7 <fwp_cmp+0x337>
   109a2:	48 83 f8 01          	cmp    $0x1,%rax
   109a6:	75 2d                	jne    109d5 <fwp_cmp+0x355>
   109a8:	0f b6 04 11          	movzbl (%rcx,%rdx,1),%eax
   109ac:	41 8b 0f             	mov    (%r15),%ecx
   109af:	85 c9                	test   %ecx,%ecx
   109b1:	48 0f be f8          	movsbq %al,%rdi
   109b5:	eb 2a                	jmp    109e1 <fwp_cmp+0x361>
   109b7:	0f b7 04 11          	movzwl (%rcx,%rdx,1),%eax
   109bb:	41 8b 0f             	mov    (%r15),%ecx
   109be:	83 f9 01             	cmp    $0x1,%ecx
   109c1:	48 0f bf f8          	movswq %ax,%rdi
   109c5:	eb 1a                	jmp    109e1 <fwp_cmp+0x361>
   109c7:	48 8b 3c 11          	mov    (%rcx,%rdx,1),%rdi
   109cb:	4d 85 ff             	test   %r15,%r15
   109ce:	74 4b                	je     10a1b <fwp_cmp+0x39b>
   109d0:	41 8b 0f             	mov    (%r15),%ecx
   109d3:	eb 10                	jmp    109e5 <fwp_cmp+0x365>
   109d5:	8b 04 11             	mov    (%rcx,%rdx,1),%eax
   109d8:	41 8b 0f             	mov    (%r15),%ecx
   109db:	83 f9 02             	cmp    $0x2,%ecx
   109de:	48 63 f8             	movslq %eax,%rdi
   109e1:	48 0f 45 f8          	cmovne %rax,%rdi
   109e5:	83 f9 0a             	cmp    $0xa,%ecx
   109e8:	77 31                	ja     10a1b <fwp_cmp+0x39b>
   109ea:	b8 84 04 00 00       	mov    $0x484,%eax
   109ef:	0f a3 c8             	bt     %ecx,%eax
   109f2:	72 20                	jb     10a14 <fwp_cmp+0x394>
   109f4:	b8 01 00 00 00       	mov    $0x1,%eax
   109f9:	ba 21 00 00 00       	mov    $0x21,%edx
   109fe:	0f a3 ca             	bt     %ecx,%edx
   10a01:	72 1d                	jb     10a20 <fwp_cmp+0x3a0>
   10a03:	b8 42 00 00 00       	mov    $0x42,%eax
   10a08:	0f a3 c8             	bt     %ecx,%eax
   10a0b:	73 0e                	jae    10a1b <fwp_cmp+0x39b>
   10a0d:	b8 02 00 00 00       	mov    $0x2,%eax
   10a12:	eb 0c                	jmp    10a20 <fwp_cmp+0x3a0>
   10a14:	b8 04 00 00 00       	mov    $0x4,%eax
   10a19:	eb 05                	jmp    10a20 <fwp_cmp+0x3a0>
   10a1b:	b8 08 00 00 00       	mov    $0x8,%eax
   10a20:	48 8b 0c 24          	mov    (%rsp),%rcx
   10a24:	4d 85 ed             	test   %r13,%r13
   10a27:	79 04                	jns    10a2d <fwp_cmp+0x3ad>
   10a29:	48 8b 4b 10          	mov    0x10(%rbx),%rcx
   10a2d:	48 89 c2             	mov    %rax,%rdx
   10a30:	48 0f af d5          	imul   %rbp,%rdx
   10a34:	48 83 f8 01          	cmp    $0x1,%rax
   10a38:	74 1e                	je     10a58 <fwp_cmp+0x3d8>
   10a3a:	83 f8 02             	cmp    $0x2,%eax
   10a3d:	74 0b                	je     10a4a <fwp_cmp+0x3ca>
   10a3f:	83 f8 08             	cmp    $0x8,%eax
   10a42:	75 22                	jne    10a66 <fwp_cmp+0x3e6>
   10a44:	48 8b 34 11          	mov    (%rcx,%rdx,1),%rsi
   10a48:	eb 2a                	jmp    10a74 <fwp_cmp+0x3f4>
   10a4a:	41 83 3f 01          	cmpl   $0x1,(%r15)
   10a4e:	0f b7 04 11          	movzwl (%rcx,%rdx,1),%eax
   10a52:	48 0f bf f0          	movswq %ax,%rsi
   10a56:	eb 18                	jmp    10a70 <fwp_cmp+0x3f0>
   10a58:	41 83 3f 00          	cmpl   $0x0,(%r15)
   10a5c:	0f b6 04 11          	movzbl (%rcx,%rdx,1),%eax
   10a60:	48 0f be f0          	movsbq %al,%rsi
   10a64:	eb 0a                	jmp    10a70 <fwp_cmp+0x3f0>
   10a66:	41 83 3f 02          	cmpl   $0x2,(%r15)
   10a6a:	8b 04 11             	mov    (%rcx,%rdx,1),%eax
   10a6d:	48 63 f0             	movslq %eax,%rsi
   10a70:	48 0f 45 f0          	cmovne %rax,%rsi
   10a74:	4c 89 fa             	mov    %r15,%rdx
   10a77:	e8 04 fc ff ff       	call   10680 <fwp_cmp>
   10a7c:	85 c0                	test   %eax,%eax
   10a7e:	0f 85 4e fc ff ff    	jne    106d2 <fwp_cmp+0x52>
   10a84:	48 ff c5             	inc    %rbp
   10a87:	49 39 ec             	cmp    %rbp,%r12
   10a8a:	0f 85 d0 fe ff ff    	jne    10960 <fwp_cmp+0x2e0>
   10a90:	31 c9                	xor    %ecx,%ecx
   10a92:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
   10a97:	48 3b 44 24 20       	cmp    0x20(%rsp),%rax
   10a9c:	e9 26 fc ff ff       	jmp    106c7 <fwp_cmp+0x47>
   10aa1:	49 81 fe ff 0f 00 00 	cmp    $0xfff,%r14
   10aa8:	77 27                	ja     10ad1 <fwp_cmp+0x451>
   10aaa:	44 89 f0             	mov    %r14d,%eax
   10aad:	48 81 fb ff 0f 00 00 	cmp    $0xfff,%rbx
   10ab4:	76 27                	jbe    10add <fwp_cmp+0x45d>
   10ab6:	8b 0b                	mov    (%rbx),%ecx
   10ab8:	39 c8                	cmp    %ecx,%eax
   10aba:	74 27                	je     10ae3 <fwp_cmp+0x463>
   10abc:	0f 97 c0             	seta   %al
   10abf:	0f b6 c8             	movzbl %al,%ecx
   10ac2:	e9 03 fc ff ff       	jmp    106ca <fwp_cmp+0x4a>
   10ac7:	31 c9                	xor    %ecx,%ecx
   10ac9:	4d 39 e7             	cmp    %r12,%r15
   10acc:	e9 f6 fb ff ff       	jmp    106c7 <fwp_cmp+0x47>
   10ad1:	41 8b 06             	mov    (%r14),%eax
   10ad4:	48 81 fb ff 0f 00 00 	cmp    $0xfff,%rbx
   10adb:	77 d9                	ja     10ab6 <fwp_cmp+0x436>
   10add:	89 d9                	mov    %ebx,%ecx
   10adf:	39 c8                	cmp    %ecx,%eax
   10ae1:	75 d9                	jne    10abc <fwp_cmp+0x43c>
   10ae3:	49 8b 4f 28          	mov    0x28(%r15),%rcx
   10ae7:	89 c0                	mov    %eax,%eax
   10ae9:	44 8b 24 81          	mov    (%rcx,%rax,4),%r12d
   10aed:	45 85 e4             	test   %r12d,%r12d
   10af0:	7e 38                	jle    10b2a <fwp_cmp+0x4aa>
   10af2:	49 8b 4f 30          	mov    0x30(%r15),%rcx
   10af6:	4c 8b 3c c1          	mov    (%rcx,%rax,8),%r15
   10afa:	45 31 ed             	xor    %r13d,%r13d
   10afd:	0f 1f 00             	nopl   (%rax)
   10b00:	4b 8b 7c ee 08       	mov    0x8(%r14,%r13,8),%rdi
   10b05:	4a 8b 74 eb 08       	mov    0x8(%rbx,%r13,8),%rsi
   10b0a:	4b 8b 14 ef          	mov    (%r15,%r13,8),%rdx
   10b0e:	e8 6d fb ff ff       	call   10680 <fwp_cmp>
   10b13:	85 c0                	test   %eax,%eax
   10b15:	0f 85 b7 fb ff ff    	jne    106d2 <fwp_cmp+0x52>
   10b1b:	49 ff c5             	inc    %r13
   10b1e:	31 c0                	xor    %eax,%eax
   10b20:	4d 39 ec             	cmp    %r13,%r12
   10b23:	75 db                	jne    10b00 <fwp_cmp+0x480>
   10b25:	e9 a8 fb ff ff       	jmp    106d2 <fwp_cmp+0x52>
   10b2a:	31 c0                	xor    %eax,%eax
   10b2c:	e9 a1 fb ff ff       	jmp    106d2 <fwp_cmp+0x52>
   10b31:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   10b38:	0f 1f 84 00 00 00 00 
   10b3f:	00 

0000000000010b40 <fwp_pipe_poll>:
   10b40:	83 3d 99 b2 00 00 00 	cmpl   $0x0,0xb299(%rip)        # 1bde0 <fwp_po_listen>
   10b47:	0f 88 b1 01 00 00    	js     10cfe <fwp_pipe_poll+0x1be>
   10b4d:	55                   	push   %rbp
   10b4e:	41 57                	push   %r15
   10b50:	41 56                	push   %r14
   10b52:	53                   	push   %rbx
   10b53:	48 83 ec 38          	sub    $0x38,%rsp
   10b57:	48 8d 74 24 28       	lea    0x28(%rsp),%rsi
   10b5c:	bf 01 00 00 00       	mov    $0x1,%edi
   10b61:	e8 ca 25 ff ff       	call   3130 <clock_gettime@plt>
   10b66:	4c 69 74 24 28 00 ca 	imul   $0x3b9aca00,0x28(%rsp),%r14
   10b6d:	9a 3b 
   10b6f:	4c 03 74 24 30       	add    0x30(%rsp),%r14
   10b74:	4c 3b 35 c5 b3 02 00 	cmp    0x2b3c5(%rip),%r14        # 3bf40 <fwp_po_next_check>
   10b7b:	0f 8c 73 01 00 00    	jl     10cf4 <fwp_pipe_poll+0x1b4>
   10b81:	49 8d 86 40 42 0f 00 	lea    0xf4240(%r14),%rax
   10b88:	48 89 05 b1 b3 02 00 	mov    %rax,0x2b3b1(%rip)        # 3bf40 <fwp_po_next_check>
   10b8f:	8b 3d 4b b2 00 00    	mov    0xb24b(%rip),%edi        # 1bde0 <fwp_po_listen>
   10b95:	31 f6                	xor    %esi,%esi
   10b97:	31 d2                	xor    %edx,%edx
   10b99:	e8 92 28 ff ff       	call   3430 <accept@plt>
   10b9e:	85 c0                	test   %eax,%eax
   10ba0:	0f 88 10 01 00 00    	js     10cb6 <fwp_pipe_poll+0x176>
   10ba6:	89 c3                	mov    %eax,%ebx
   10ba8:	8b 3d 32 b2 00 00    	mov    0xb232(%rip),%edi        # 1bde0 <fwp_po_listen>
   10bae:	e8 7d 26 ff ff       	call   3230 <close@plt>
   10bb3:	c7 05 23 b2 00 00 ff 	movl   $0xffffffff,0xb223(%rip)        # 1bde0 <fwp_po_listen>
   10bba:	ff ff ff 
   10bbd:	89 df                	mov    %ebx,%edi
   10bbf:	be 02 00 00 00       	mov    $0x2,%esi
   10bc4:	ba 01 00 00 00       	mov    $0x1,%edx
   10bc9:	31 c0                	xor    %eax,%eax
   10bcb:	e8 50 25 ff ff       	call   3120 <fcntl@plt>
   10bd0:	89 df                	mov    %ebx,%edi
   10bd2:	be 03 00 00 00       	mov    $0x3,%esi
   10bd7:	31 c0                	xor    %eax,%eax
   10bd9:	e8 42 25 ff ff       	call   3120 <fcntl@plt>
   10bde:	25 ff f7 ff ff       	and    $0xfffff7ff,%eax
   10be3:	89 df                	mov    %ebx,%edi
   10be5:	be 04 00 00 00       	mov    $0x4,%esi
   10bea:	89 c2                	mov    %eax,%edx
   10bec:	31 c0                	xor    %eax,%eax
   10bee:	e8 2d 25 ff ff       	call   3120 <fcntl@plt>
   10bf3:	c7 44 24 24 0c 00 00 	movl   $0xc,0x24(%rsp)
   10bfa:	00 
   10bfb:	89 5c 24 1c          	mov    %ebx,0x1c(%rsp)
   10bff:	c7 44 24 20 01 00 00 	movl   $0x1,0x20(%rsp)
   10c06:	00 
   10c07:	48 8d 4c 24 28       	lea    0x28(%rsp),%rcx
   10c0c:	4c 8d 44 24 24       	lea    0x24(%rsp),%r8
   10c11:	89 df                	mov    %ebx,%edi
   10c13:	be 01 00 00 00       	mov    $0x1,%esi
   10c18:	ba 11 00 00 00       	mov    $0x11,%edx
   10c1d:	e8 7e 26 ff ff       	call   32a0 <getsockopt@plt>
   10c22:	85 c0                	test   %eax,%eax
   10c24:	0f 85 c3 00 00 00    	jne    10ced <fwp_pipe_poll+0x1ad>
   10c2a:	8b 6c 24 2c          	mov    0x2c(%rsp),%ebp
   10c2e:	e8 4d 25 ff ff       	call   3180 <getuid@plt>
   10c33:	39 c5                	cmp    %eax,%ebp
   10c35:	0f 85 b2 00 00 00    	jne    10ced <fwp_pipe_poll+0x1ad>
   10c3b:	48 8d 7c 24 1c       	lea    0x1c(%rsp),%rdi
   10c40:	be 01 00 00 00       	mov    $0x1,%esi
   10c45:	ba e8 03 00 00       	mov    $0x3e8,%edx
   10c4a:	e8 71 27 ff ff       	call   33c0 <poll@plt>
   10c4f:	85 c0                	test   %eax,%eax
   10c51:	0f 8e 96 00 00 00    	jle    10ced <fwp_pipe_poll+0x1ad>
   10c57:	48 8d 74 24 0f       	lea    0xf(%rsp),%rsi
   10c5c:	ba 05 00 00 00       	mov    $0x5,%edx
   10c61:	89 df                	mov    %ebx,%edi
   10c63:	31 c9                	xor    %ecx,%ecx
   10c65:	e8 f6 23 ff ff       	call   3060 <recv@plt>
   10c6a:	48 85 c0             	test   %rax,%rax
   10c6d:	7e 7e                	jle    10ced <fwp_pipe_poll+0x1ad>
   10c6f:	49 89 c6             	mov    %rax,%r14
   10c72:	4c 8d 7c 24 1c       	lea    0x1c(%rsp),%r15
   10c77:	49 83 fe 04          	cmp    $0x4,%r14
   10c7b:	77 59                	ja     10cd6 <fwp_pipe_poll+0x196>
   10c7d:	be 01 00 00 00       	mov    $0x1,%esi
   10c82:	4c 89 ff             	mov    %r15,%rdi
   10c85:	ba e8 03 00 00       	mov    $0x3e8,%edx
   10c8a:	e8 31 27 ff ff       	call   33c0 <poll@plt>
   10c8f:	85 c0                	test   %eax,%eax
   10c91:	7e 5a                	jle    10ced <fwp_pipe_poll+0x1ad>
   10c93:	4a 8d 34 34          	lea    (%rsp,%r14,1),%rsi
   10c97:	48 83 c6 0f          	add    $0xf,%rsi
   10c9b:	ba 05 00 00 00       	mov    $0x5,%edx
   10ca0:	4c 29 f2             	sub    %r14,%rdx
   10ca3:	89 df                	mov    %ebx,%edi
   10ca5:	31 c9                	xor    %ecx,%ecx
   10ca7:	e8 b4 23 ff ff       	call   3060 <recv@plt>
   10cac:	49 01 c6             	add    %rax,%r14
   10caf:	48 85 c0             	test   %rax,%rax
   10cb2:	7f c3                	jg     10c77 <fwp_pipe_poll+0x137>
   10cb4:	eb 37                	jmp    10ced <fwp_pipe_poll+0x1ad>
   10cb6:	4c 3b 35 5b b2 01 00 	cmp    0x1b25b(%rip),%r14        # 2bf18 <fwp_po_give_up>
   10cbd:	7e 35                	jle    10cf4 <fwp_pipe_poll+0x1b4>
   10cbf:	8b 3d 1b b1 00 00    	mov    0xb11b(%rip),%edi        # 1bde0 <fwp_po_listen>
   10cc5:	e8 66 25 ff ff       	call   3230 <close@plt>
   10cca:	c7 05 0c b1 00 00 ff 	movl   $0xffffffff,0xb10c(%rip)        # 1bde0 <fwp_po_listen>
   10cd1:	ff ff ff 
   10cd4:	eb 1e                	jmp    10cf4 <fwp_pipe_poll+0x1b4>
   10cd6:	81 7c 24 0f 46 57 50 	cmpl   $0x54505746,0xf(%rsp)
   10cdd:	54 
   10cde:	75 0d                	jne    10ced <fwp_pipe_poll+0x1ad>
   10ce0:	0f b6 44 24 13       	movzbl 0x13(%rsp),%eax
   10ce5:	8d 48 fd             	lea    -0x3(%rax),%ecx
   10ce8:	80 f9 fd             	cmp    $0xfd,%cl
   10ceb:	77 12                	ja     10cff <fwp_pipe_poll+0x1bf>
   10ced:	89 df                	mov    %ebx,%edi
   10cef:	e8 3c 25 ff ff       	call   3230 <close@plt>
   10cf4:	48 83 c4 38          	add    $0x38,%rsp
   10cf8:	5b                   	pop    %rbx
   10cf9:	41 5e                	pop    %r14
   10cfb:	41 5f                	pop    %r15
   10cfd:	5d                   	pop    %rbp
   10cfe:	c3                   	ret
   10cff:	89 1d df b0 00 00    	mov    %ebx,0xb0df(%rip)        # 1bde4 <fwp_po_sock>
   10d05:	bb 01 00 00 00       	mov    $0x1,%ebx
   10d0a:	3c 02                	cmp    $0x2,%al
   10d0c:	75 10                	jne    10d1e <fwp_pipe_poll+0x1de>
   10d0e:	e8 4d 00 00 00       	call   10d60 <fwp_po_make_ring>
   10d13:	83 f8 01             	cmp    $0x1,%eax
   10d16:	bb 02 00 00 00       	mov    $0x2,%ebx
   10d1b:	83 db 00             	sbb    $0x0,%ebx
   10d1e:	c7 44 24 14 02 01 00 	movl   $0x102,0x14(%rsp)
   10d25:	00 
   10d26:	c6 44 24 18 00       	movb   $0x0,0x18(%rsp)
   10d2b:	88 5c 24 19          	mov    %bl,0x19(%rsp)
   10d2f:	4c 8b 35 7a 92 00 00 	mov    0x927a(%rip),%r14        # 19fb0 <stdout@GLIBC_2.2.5>
   10d36:	49 8b 0e             	mov    (%r14),%rcx
   10d39:	48 8d 7c 24 14       	lea    0x14(%rsp),%rdi
   10d3e:	be 01 00 00 00       	mov    $0x1,%esi
   10d43:	ba 06 00 00 00       	mov    $0x6,%edx
   10d48:	e8 33 27 ff ff       	call   3480 <fwrite@plt>
   10d4d:	49 8b 3e             	mov    (%r14),%rdi
   10d50:	e8 fb 25 ff ff       	call   3350 <fflush@plt>
   10d55:	89 1d c5 b1 01 00    	mov    %ebx,0x1b1c5(%rip)        # 2bf20 <fwp_po_kind>
   10d5b:	eb 97                	jmp    10cf4 <fwp_pipe_poll+0x1b4>
   10d5d:	0f 1f 00             	nopl   (%rax)

0000000000010d60 <fwp_po_make_ring>:
   10d60:	55                   	push   %rbp
   10d61:	41 57                	push   %r15
   10d63:	41 56                	push   %r14
   10d65:	53                   	push   %rbx
   10d66:	48 83 ec 68          	sub    $0x68,%rsp
   10d6a:	48 8d 35 df 59 00 00 	lea    0x59df(%rip),%rsi        # 16750 <exec_in_fp0+0xee0>
   10d71:	31 ed                	xor    %ebp,%ebp
   10d73:	bf 3f 01 00 00       	mov    $0x13f,%edi
   10d78:	ba 01 00 00 00       	mov    $0x1,%edx
   10d7d:	31 c0                	xor    %eax,%eax
   10d7f:	e8 7c 25 ff ff       	call   3300 <syscall@plt>
   10d84:	48 89 c3             	mov    %rax,%rbx
   10d87:	85 db                	test   %ebx,%ebx
   10d89:	78 17                	js     10da2 <fwp_po_make_ring+0x42>
   10d8b:	be 00 10 10 00       	mov    $0x101000,%esi
   10d90:	89 df                	mov    %ebx,%edi
   10d92:	e8 49 24 ff ff       	call   31e0 <ftruncate@plt>
   10d97:	85 c0                	test   %eax,%eax
   10d99:	74 14                	je     10daf <fwp_po_make_ring+0x4f>
   10d9b:	89 df                	mov    %ebx,%edi
   10d9d:	e8 8e 24 ff ff       	call   3230 <close@plt>
   10da2:	89 e8                	mov    %ebp,%eax
   10da4:	48 83 c4 68          	add    $0x68,%rsp
   10da8:	5b                   	pop    %rbx
   10da9:	41 5e                	pop    %r14
   10dab:	41 5f                	pop    %r15
   10dad:	5d                   	pop    %rbp
   10dae:	c3                   	ret
   10daf:	be 00 10 10 00       	mov    $0x101000,%esi
   10db4:	31 ff                	xor    %edi,%edi
   10db6:	ba 03 00 00 00       	mov    $0x3,%edx
   10dbb:	b9 01 00 00 00       	mov    $0x1,%ecx
   10dc0:	41 89 d8             	mov    %ebx,%r8d
   10dc3:	45 31 c9             	xor    %r9d,%r9d
   10dc6:	e8 c5 23 ff ff       	call   3190 <mmap@plt>
   10dcb:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
   10dcf:	74 ca                	je     10d9b <fwp_po_make_ring+0x3b>
   10dd1:	49 89 c6             	mov    %rax,%r14
   10dd4:	48 b8 46 57 50 53 01 	movabs $0x153505746,%rax
   10ddb:	00 00 00 
   10dde:	49 89 06             	mov    %rax,(%r14)
   10de1:	49 c7 46 08 00 00 10 	movq   $0x100000,0x8(%r14)
   10de8:	00 
   10de9:	c6 44 24 07 53       	movb   $0x53,0x7(%rsp)
   10dee:	48 8d 44 24 07       	lea    0x7(%rsp),%rax
   10df3:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   10df8:	48 c7 44 24 28 01 00 	movq   $0x1,0x28(%rsp)
   10dff:	00 00 
   10e01:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
   10e08:	00 00 
   10e0a:	0f 57 c0             	xorps  %xmm0,%xmm0
   10e0d:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
   10e12:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
   10e17:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
   10e1c:	48 c7 44 24 60 00 00 	movq   $0x0,0x60(%rsp)
   10e23:	00 00 
   10e25:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
   10e2a:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
   10e2f:	48 c7 44 24 48 01 00 	movq   $0x1,0x48(%rsp)
   10e36:	00 00 
   10e38:	48 8d 44 24 08       	lea    0x8(%rsp),%rax
   10e3d:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
   10e42:	48 c7 44 24 58 18 00 	movq   $0x18,0x58(%rsp)
   10e49:	00 00 
   10e4b:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
   10e52:	00 00 00 
   10e55:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
   10e5a:	48 c7 44 24 08 14 00 	movq   $0x14,0x8(%rsp)
   10e61:	00 00 
   10e63:	89 5c 24 18          	mov    %ebx,0x18(%rsp)
   10e67:	8b 3d 77 af 00 00    	mov    0xaf77(%rip),%edi        # 1bde4 <fwp_po_sock>
   10e6d:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
   10e72:	ba 00 40 00 00       	mov    $0x4000,%edx
   10e77:	e8 44 22 ff ff       	call   30c0 <sendmsg@plt>
   10e7c:	49 89 c7             	mov    %rax,%r15
   10e7f:	89 df                	mov    %ebx,%edi
   10e81:	e8 aa 23 ff ff       	call   3230 <close@plt>
   10e86:	49 83 ff 01          	cmp    $0x1,%r15
   10e8a:	75 11                	jne    10e9d <fwp_po_make_ring+0x13d>
   10e8c:	4c 89 35 9d b0 02 00 	mov    %r14,0x2b09d(%rip)        # 3bf30 <fwp_po_ring>
   10e93:	bd 01 00 00 00       	mov    $0x1,%ebp
   10e98:	e9 05 ff ff ff       	jmp    10da2 <fwp_po_make_ring+0x42>
   10e9d:	be 00 10 10 00       	mov    $0x101000,%esi
   10ea2:	4c 89 f7             	mov    %r14,%rdi
   10ea5:	e8 e6 24 ff ff       	call   3390 <munmap@plt>
   10eaa:	31 ed                	xor    %ebp,%ebp
   10eac:	e9 f1 fe ff ff       	jmp    10da2 <fwp_po_make_ring+0x42>
   10eb1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   10eb8:	0f 1f 84 00 00 00 00 
   10ebf:	00 

0000000000010ec0 <fwp_write>:
   10ec0:	55                   	push   %rbp
   10ec1:	41 57                	push   %r15
   10ec3:	41 56                	push   %r14
   10ec5:	41 55                	push   %r13
   10ec7:	41 54                	push   %r12
   10ec9:	53                   	push   %rbx
   10eca:	48 81 ec 78 02 00 00 	sub    $0x278,%rsp
   10ed1:	8b 02                	mov    (%rdx),%eax
   10ed3:	48 83 f8 19          	cmp    $0x19,%rax
   10ed7:	0f 87 36 12 00 00    	ja     12113 <fwp_write+0x1253>
   10edd:	49 89 d7             	mov    %rdx,%r15
   10ee0:	49 89 f6             	mov    %rsi,%r14
   10ee3:	48 89 fd             	mov    %rdi,%rbp
   10ee6:	48 8d 15 0b 46 00 00 	lea    0x460b(%rip),%rdx        # 154f8 <_IO_stdin_used+0x4f8>
   10eed:	48 63 34 82          	movslq (%rdx,%rax,4),%rsi
   10ef1:	48 01 d6             	add    %rdx,%rsi
   10ef4:	48 89 3c 24          	mov    %rdi,(%rsp)
   10ef8:	ff e6                	jmp    *%rsi
   10efa:	48 8d 15 7d 58 00 00 	lea    0x587d(%rip),%rdx        # 1677e <exec_in_fp0+0xf0e>
   10f01:	eb 07                	jmp    10f0a <fwp_write+0x4a>
   10f03:	48 8d 15 3c 58 00 00 	lea    0x583c(%rip),%rdx        # 16746 <exec_in_fp0+0xed6>
   10f0a:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
   10f0f:	be 00 02 00 00       	mov    $0x200,%esi
   10f14:	4c 89 ff             	mov    %r15,%rdi
   10f17:	4c 89 f1             	mov    %r14,%rcx
   10f1a:	31 c0                	xor    %eax,%eax
   10f1c:	e8 af 22 ff ff       	call   31d0 <snprintf@plt>
   10f21:	4c 89 ff             	mov    %r15,%rdi
   10f24:	e8 47 22 ff ff       	call   3170 <strlen@plt>
   10f29:	48 89 ef             	mov    %rbp,%rdi
   10f2c:	4c 89 fe             	mov    %r15,%rsi
   10f2f:	e9 d7 11 00 00       	jmp    1210b <fwp_write+0x124b>
   10f34:	83 f8 13             	cmp    $0x13,%eax
   10f37:	48 8d 05 71 58 00 00 	lea    0x5871(%rip),%rax        # 167af <exec_in_fp0+0xf3f>
   10f3e:	48 8d 35 6f 58 00 00 	lea    0x586f(%rip),%rsi        # 167b4 <exec_in_fp0+0xf44>
   10f45:	48 0f 44 f0          	cmove  %rax,%rsi
   10f49:	ba 04 00 00 00       	mov    $0x4,%edx
   10f4e:	48 89 ef             	mov    %rbp,%rdi
   10f51:	e8 3a c3 ff ff       	call   d290 <buf_put>
   10f56:	49 83 3e 00          	cmpq   $0x0,(%r14)
   10f5a:	0f 84 c3 00 00 00    	je     11023 <fwp_write+0x163>
   10f60:	49 8b 57 38          	mov    0x38(%r15),%rdx
   10f64:	49 8b 76 08          	mov    0x8(%r14),%rsi
   10f68:	48 8b 1c 24          	mov    (%rsp),%rbx
   10f6c:	48 89 df             	mov    %rbx,%rdi
   10f6f:	31 c9                	xor    %ecx,%ecx
   10f71:	e8 4a ff ff ff       	call   10ec0 <fwp_write>
   10f76:	41 83 3f 12          	cmpl   $0x12,(%r15)
   10f7a:	75 26                	jne    10fa2 <fwp_write+0xe2>
   10f7c:	48 8d 35 f0 57 00 00 	lea    0x57f0(%rip),%rsi        # 16773 <exec_in_fp0+0xf03>
   10f83:	ba 02 00 00 00       	mov    $0x2,%edx
   10f88:	48 89 df             	mov    %rbx,%rdi
   10f8b:	e8 00 c3 ff ff       	call   d290 <buf_put>
   10f90:	49 8b 76 10          	mov    0x10(%r14),%rsi
   10f94:	49 8b 57 40          	mov    0x40(%r15),%rdx
   10f98:	48 89 df             	mov    %rbx,%rdi
   10f9b:	31 c9                	xor    %ecx,%ecx
   10f9d:	e8 1e ff ff ff       	call   10ec0 <fwp_write>
   10fa2:	49 83 3e 02          	cmpq   $0x2,(%r14)
   10fa6:	72 7b                	jb     11023 <fwp_write+0x163>
   10fa8:	49 8d 5e 20          	lea    0x20(%r14),%rbx
   10fac:	bd 01 00 00 00       	mov    $0x1,%ebp
   10fb1:	4c 8d 25 18 57 00 00 	lea    0x5718(%rip),%r12        # 166d0 <exec_in_fp0+0xe60>
   10fb8:	eb 12                	jmp    10fcc <fwp_write+0x10c>
   10fba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   10fc0:	48 ff c5             	inc    %rbp
   10fc3:	48 83 c3 10          	add    $0x10,%rbx
   10fc7:	49 3b 2e             	cmp    (%r14),%rbp
   10fca:	73 57                	jae    11023 <fwp_write+0x163>
   10fcc:	ba 02 00 00 00       	mov    $0x2,%edx
   10fd1:	4c 8b 2c 24          	mov    (%rsp),%r13
   10fd5:	4c 89 ef             	mov    %r13,%rdi
   10fd8:	4c 89 e6             	mov    %r12,%rsi
   10fdb:	e8 b0 c2 ff ff       	call   d290 <buf_put>
   10fe0:	48 8b 73 f8          	mov    -0x8(%rbx),%rsi
   10fe4:	49 8b 57 38          	mov    0x38(%r15),%rdx
   10fe8:	4c 89 ef             	mov    %r13,%rdi
   10feb:	31 c9                	xor    %ecx,%ecx
   10fed:	e8 ce fe ff ff       	call   10ec0 <fwp_write>
   10ff2:	41 83 3f 12          	cmpl   $0x12,(%r15)
   10ff6:	75 c8                	jne    10fc0 <fwp_write+0x100>
   10ff8:	ba 02 00 00 00       	mov    $0x2,%edx
   10ffd:	4c 8b 2c 24          	mov    (%rsp),%r13
   11001:	4c 89 ef             	mov    %r13,%rdi
   11004:	48 8d 35 68 57 00 00 	lea    0x5768(%rip),%rsi        # 16773 <exec_in_fp0+0xf03>
   1100b:	e8 80 c2 ff ff       	call   d290 <buf_put>
   11010:	48 8b 33             	mov    (%rbx),%rsi
   11013:	49 8b 57 40          	mov    0x40(%r15),%rdx
   11017:	4c 89 ef             	mov    %r13,%rdi
   1101a:	31 c9                	xor    %ecx,%ecx
   1101c:	e8 9f fe ff ff       	call   10ec0 <fwp_write>
   11021:	eb 9d                	jmp    10fc0 <fwp_write+0x100>
   11023:	c6 44 24 70 7d       	movb   $0x7d,0x70(%rsp)
   11028:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   1102d:	ba 01 00 00 00       	mov    $0x1,%edx
   11032:	48 8b 3c 24          	mov    (%rsp),%rdi
   11036:	e9 d3 10 00 00       	jmp    1210e <fwp_write+0x124e>
   1103b:	4d 8b 67 08          	mov    0x8(%r15),%r12
   1103f:	4d 85 e4             	test   %r12,%r12
   11042:	0f 84 bf 06 00 00    	je     11707 <fwp_write+0x847>
   11048:	48 8d 35 9a 56 00 00 	lea    0x569a(%rip),%rsi        # 166e9 <exec_in_fp0+0xe79>
   1104f:	4c 89 e7             	mov    %r12,%rdi
   11052:	e8 79 22 ff ff       	call   32d0 <strcmp@plt>
   11057:	85 c0                	test   %eax,%eax
   11059:	0f 84 46 0b 00 00    	je     11ba5 <fwp_write+0xce5>
   1105f:	4d 8d 6f 10          	lea    0x10(%r15),%r13
   11063:	4c 89 e7             	mov    %r12,%rdi
   11066:	e8 05 21 ff ff       	call   3170 <strlen@plt>
   1106b:	48 89 ef             	mov    %rbp,%rdi
   1106e:	4c 89 e6             	mov    %r12,%rsi
   11071:	48 89 c2             	mov    %rax,%rdx
   11074:	e8 17 c2 ff ff       	call   d290 <buf_put>
   11079:	c6 44 24 70 20       	movb   $0x20,0x70(%rsp)
   1107e:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   11083:	ba 01 00 00 00       	mov    $0x1,%edx
   11088:	48 89 ef             	mov    %rbp,%rdi
   1108b:	e8 00 c2 ff ff       	call   d290 <buf_put>
   11090:	31 db                	xor    %ebx,%ebx
   11092:	e9 8f 06 00 00       	jmp    11726 <fwp_write+0x866>
   11097:	49 81 fe ff 0f 00 00 	cmp    $0xfff,%r14
   1109e:	0f 87 10 05 00 00    	ja     115b4 <fwp_write+0x6f4>
   110a4:	44 89 f0             	mov    %r14d,%eax
   110a7:	e9 0b 05 00 00       	jmp    115b7 <fwp_write+0x6f7>
   110ac:	66 49 0f 6e ce       	movq   %r14,%xmm1
   110b1:	66 0f 2e c9          	ucomisd %xmm1,%xmm1
   110b5:	0f 8a e2 11 00 00    	jp     1229d <fwp_write+0x13dd>
   110bb:	66 0f 28 05 3d 40 00 	movapd 0x403d(%rip),%xmm0        # 15100 <_IO_stdin_used+0x100>
   110c2:	00 
   110c3:	66 0f 54 c1          	andpd  %xmm1,%xmm0
   110c7:	66 0f 2e 05 f1 40 00 	ucomisd 0x40f1(%rip),%xmm0        # 151c0 <_IO_stdin_used+0x1c0>
   110ce:	00 
   110cf:	0f 82 76 08 00 00    	jb     1194b <fwp_write+0xa8b>
   110d5:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
   110d9:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
   110dd:	e9 65 04 00 00       	jmp    11547 <fwp_write+0x687>
   110e2:	c6 44 24 70 3c       	movb   $0x3c,0x70(%rsp)
   110e7:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   110ec:	ba 01 00 00 00       	mov    $0x1,%edx
   110f1:	48 89 ef             	mov    %rbp,%rdi
   110f4:	e8 97 c1 ff ff       	call   d290 <buf_put>
   110f9:	4d 8b 77 08          	mov    0x8(%r15),%r14
   110fd:	e9 92 04 00 00       	jmp    11594 <fwp_write+0x6d4>
   11102:	48 8d 35 85 56 00 00 	lea    0x5685(%rip),%rsi        # 1678e <exec_in_fp0+0xf1e>
   11109:	ba 08 00 00 00       	mov    $0x8,%edx
   1110e:	48 89 ef             	mov    %rbp,%rdi
   11111:	e9 6c 0d 00 00       	jmp    11e82 <fwp_write+0xfc2>
   11116:	49 8d 76 08          	lea    0x8(%r14),%rsi
   1111a:	49 8b 16             	mov    (%r14),%rdx
   1111d:	85 c9                	test   %ecx,%ecx
   1111f:	0f 84 23 07 00 00    	je     11848 <fwp_write+0x988>
   11125:	48 89 ef             	mov    %rbp,%rdi
   11128:	e9 55 0d 00 00       	jmp    11e82 <fwp_write+0xfc2>
   1112d:	4d 8b 0e             	mov    (%r14),%r9
   11130:	4d 8b 46 08          	mov    0x8(%r14),%r8
   11134:	4c 89 c8             	mov    %r9,%rax
   11137:	4c 09 c0             	or     %r8,%rax
   1113a:	0f 84 21 07 00 00    	je     11861 <fwp_write+0x9a1>
   11140:	31 ff                	xor    %edi,%edi
   11142:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
   11149:	cc cc cc 
   1114c:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
   11153:	cc cc cc 
   11156:	4c 89 c3             	mov    %r8,%rbx
   11159:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   11160:	4c 89 c1             	mov    %r8,%rcx
   11163:	4c 0f a4 c9 3f       	shld   $0x3f,%r9,%rcx
   11168:	48 d1 eb             	shr    $1,%rbx
   1116b:	48 89 ce             	mov    %rcx,%rsi
   1116e:	48 01 de             	add    %rbx,%rsi
   11171:	48 83 d6 00          	adc    $0x0,%rsi
   11175:	48 89 f0             	mov    %rsi,%rax
   11178:	49 f7 e2             	mul    %r10
   1117b:	48 c1 ea 02          	shr    $0x2,%rdx
   1117f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   11183:	48 29 c6             	sub    %rax,%rsi
   11186:	48 29 f1             	sub    %rsi,%rcx
   11189:	48 83 db 00          	sbb    $0x0,%rbx
   1118d:	48 89 ce             	mov    %rcx,%rsi
   11190:	49 0f af f3          	imul   %r11,%rsi
   11194:	48 89 c8             	mov    %rcx,%rax
   11197:	49 f7 e2             	mul    %r10
   1119a:	48 01 f2             	add    %rsi,%rdx
   1119d:	49 0f af da          	imul   %r10,%rbx
   111a1:	48 01 d3             	add    %rdx,%rbx
   111a4:	48 89 c1             	mov    %rax,%rcx
   111a7:	48 01 c1             	add    %rax,%rcx
   111aa:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
   111ae:	44 89 ca             	mov    %r9d,%edx
   111b1:	29 ca                	sub    %ecx,%edx
   111b3:	80 ca 30             	or     $0x30,%dl
   111b6:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
   111ba:	48 ff c7             	inc    %rdi
   111bd:	49 83 f9 0a          	cmp    $0xa,%r9
   111c1:	49 83 d8 00          	sbb    $0x0,%r8
   111c5:	49 89 c1             	mov    %rax,%r9
   111c8:	49 89 d8             	mov    %rbx,%r8
   111cb:	73 93                	jae    11160 <fwp_write+0x2a0>
   111cd:	85 ff                	test   %edi,%edi
   111cf:	0f 8f 96 06 00 00    	jg     1186b <fwp_write+0x9ab>
   111d5:	e9 ab 00 00 00       	jmp    11285 <fwp_write+0x3c5>
   111da:	4d 8b 06             	mov    (%r14),%r8
   111dd:	4d 8b 4e 08          	mov    0x8(%r14),%r9
   111e1:	4d 85 c9             	test   %r9,%r9
   111e4:	0f 88 a3 06 00 00    	js     1188d <fwp_write+0x9cd>
   111ea:	4c 89 c0             	mov    %r8,%rax
   111ed:	4c 09 c8             	or     %r9,%rax
   111f0:	0f 84 cc 09 00 00    	je     11bc2 <fwp_write+0xd02>
   111f6:	31 ff                	xor    %edi,%edi
   111f8:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
   111ff:	cc cc cc 
   11202:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
   11209:	cc cc cc 
   1120c:	4c 89 cb             	mov    %r9,%rbx
   1120f:	90                   	nop
   11210:	4c 89 c9             	mov    %r9,%rcx
   11213:	4c 0f a4 c1 3f       	shld   $0x3f,%r8,%rcx
   11218:	48 d1 eb             	shr    $1,%rbx
   1121b:	48 89 ce             	mov    %rcx,%rsi
   1121e:	48 01 de             	add    %rbx,%rsi
   11221:	48 83 d6 00          	adc    $0x0,%rsi
   11225:	48 89 f0             	mov    %rsi,%rax
   11228:	49 f7 e2             	mul    %r10
   1122b:	48 c1 ea 02          	shr    $0x2,%rdx
   1122f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   11233:	48 29 c6             	sub    %rax,%rsi
   11236:	48 29 f1             	sub    %rsi,%rcx
   11239:	48 83 db 00          	sbb    $0x0,%rbx
   1123d:	48 89 ce             	mov    %rcx,%rsi
   11240:	49 0f af f3          	imul   %r11,%rsi
   11244:	48 89 c8             	mov    %rcx,%rax
   11247:	49 f7 e2             	mul    %r10
   1124a:	48 01 f2             	add    %rsi,%rdx
   1124d:	49 0f af da          	imul   %r10,%rbx
   11251:	48 01 d3             	add    %rdx,%rbx
   11254:	48 89 c1             	mov    %rax,%rcx
   11257:	48 01 c1             	add    %rax,%rcx
   1125a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
   1125e:	44 89 c2             	mov    %r8d,%edx
   11261:	29 ca                	sub    %ecx,%edx
   11263:	80 ca 30             	or     $0x30,%dl
   11266:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
   1126a:	48 ff c7             	inc    %rdi
   1126d:	49 83 f8 0a          	cmp    $0xa,%r8
   11271:	49 83 d9 00          	sbb    $0x0,%r9
   11275:	49 89 c0             	mov    %rax,%r8
   11278:	49 89 d9             	mov    %rbx,%r9
   1127b:	73 93                	jae    11210 <fwp_write+0x350>
   1127d:	85 ff                	test   %edi,%edi
   1127f:	0f 8f 47 09 00 00    	jg     11bcc <fwp_write+0xd0c>
   11285:	31 c0                	xor    %eax,%eax
   11287:	e9 67 0e 00 00       	jmp    120f3 <fwp_write+0x1233>
   1128c:	c6 44 24 70 5b       	movb   $0x5b,0x70(%rsp)
   11291:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   11296:	ba 01 00 00 00       	mov    $0x1,%edx
   1129b:	48 89 ef             	mov    %rbp,%rdi
   1129e:	e8 ed bf ff ff       	call   d290 <buf_put>
   112a3:	4d 85 f6             	test   %r14,%r14
   112a6:	0f 84 f6 0c 00 00    	je     11fa2 <fwp_write+0x10e2>
   112ac:	49 8b 57 38          	mov    0x38(%r15),%rdx
   112b0:	49 8b 76 08          	mov    0x8(%r14),%rsi
   112b4:	48 89 ef             	mov    %rbp,%rdi
   112b7:	31 c9                	xor    %ecx,%ecx
   112b9:	e8 02 fc ff ff       	call   10ec0 <fwp_write>
   112be:	49 8b 5e 10          	mov    0x10(%r14),%rbx
   112c2:	48 85 db             	test   %rbx,%rbx
   112c5:	0f 84 d7 0c 00 00    	je     11fa2 <fwp_write+0x10e2>
   112cb:	4c 8d 35 fe 53 00 00 	lea    0x53fe(%rip),%r14        # 166d0 <exec_in_fp0+0xe60>
   112d2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   112d9:	1f 84 00 00 00 00 00 
   112e0:	ba 02 00 00 00       	mov    $0x2,%edx
   112e5:	48 89 ef             	mov    %rbp,%rdi
   112e8:	4c 89 f6             	mov    %r14,%rsi
   112eb:	e8 a0 bf ff ff       	call   d290 <buf_put>
   112f0:	48 8b 73 08          	mov    0x8(%rbx),%rsi
   112f4:	49 8b 57 38          	mov    0x38(%r15),%rdx
   112f8:	48 89 ef             	mov    %rbp,%rdi
   112fb:	31 c9                	xor    %ecx,%ecx
   112fd:	e8 be fb ff ff       	call   10ec0 <fwp_write>
   11302:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
   11306:	48 85 db             	test   %rbx,%rbx
   11309:	75 d5                	jne    112e0 <fwp_write+0x420>
   1130b:	e9 92 0c 00 00       	jmp    11fa2 <fwp_write+0x10e2>
   11310:	4d 63 67 48          	movslq 0x48(%r15),%r12
   11314:	44 89 e3             	mov    %r12d,%ebx
   11317:	49 8d 54 24 03       	lea    0x3(%r12),%rdx
   1131c:	48 ff 05 85 ab 00 00 	incq   0xab85(%rip)        # 1bea8 <measured_calls>
   11323:	48 01 15 86 ab 00 00 	add    %rdx,0xab86(%rip)        # 1beb0 <measured_bytes>
   1132a:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
   11331:	0f 87 59 08 00 00    	ja     11b90 <fwp_write+0xcd0>
   11337:	49 8d 4c 24 12       	lea    0x12(%r12),%rcx
   1133c:	48 c1 e9 04          	shr    $0x4,%rcx
   11340:	48 8d 05 41 8f 00 00 	lea    0x8f41(%rip),%rax        # 1a288 <fwp_gc>
   11347:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
   1134e:	00 
   1134f:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
   11356:	48 29 0d 2b 8f 00 00 	sub    %rcx,0x8f2b(%rip)        # 1a288 <fwp_gc>
   1135d:	0f 88 2d 08 00 00    	js     11b90 <fwp_write+0xcd0>
   11363:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
   11367:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
   1136b:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
   11372:	4c 8b 3f             	mov    (%rdi),%r15
   11375:	4d 85 ff             	test   %r15,%r15
   11378:	0f 84 f6 07 00 00    	je     11b74 <fwp_write+0xcb4>
   1137e:	49 8b 07             	mov    (%r15),%rax
   11381:	48 f7 d0             	not    %rax
   11384:	48 89 07             	mov    %rax,(%rdi)
   11387:	e9 2f 0a 00 00       	jmp    11dbb <fwp_write+0xefb>
   1138c:	49 83 fe ff          	cmp    $0xffffffffffffffff,%r14
   11390:	48 8d 05 45 53 00 00 	lea    0x5345(%rip),%rax        # 166dc <exec_in_fp0+0xe6c>
   11397:	48 8d 0d 37 54 00 00 	lea    0x5437(%rip),%rcx        # 167d5 <exec_in_fp0+0xf65>
   1139e:	48 0f 44 c8          	cmove  %rax,%rcx
   113a2:	49 83 fe 01          	cmp    $0x1,%r14
   113a6:	4c 8d 35 2c 53 00 00 	lea    0x532c(%rip),%r14        # 166d9 <exec_in_fp0+0xe69>
   113ad:	4c 0f 45 f1          	cmovne %rcx,%r14
   113b1:	4c 89 f7             	mov    %r14,%rdi
   113b4:	e8 b7 1d ff ff       	call   3170 <strlen@plt>
   113b9:	48 89 ef             	mov    %rbp,%rdi
   113bc:	4c 89 f6             	mov    %r14,%rsi
   113bf:	e9 bb 0a 00 00       	jmp    11e7f <fwp_write+0xfbf>
   113c4:	48 8d 35 dd 53 00 00 	lea    0x53dd(%rip),%rsi        # 167a8 <exec_in_fp0+0xf38>
   113cb:	ba 06 00 00 00       	mov    $0x6,%edx
   113d0:	48 89 ef             	mov    %rbp,%rdi
   113d3:	e8 b8 be ff ff       	call   d290 <buf_put>
   113d8:	49 8b 36             	mov    (%r14),%rsi
   113db:	48 8d 04 75 00 00 00 	lea    0x0(,%rsi,2),%rax
   113e2:	00 
   113e3:	48 85 c0             	test   %rax,%rax
   113e6:	0f 84 b6 0b 00 00    	je     11fa2 <fwp_write+0x10e2>
   113ec:	49 8b 57 38          	mov    0x38(%r15),%rdx
   113f0:	b8 08 00 00 00       	mov    $0x8,%eax
   113f5:	48 85 d2             	test   %rdx,%rdx
   113f8:	74 13                	je     1140d <fwp_write+0x54d>
   113fa:	8b 0a                	mov    (%rdx),%ecx
   113fc:	48 83 f9 0a          	cmp    $0xa,%rcx
   11400:	77 0b                	ja     1140d <fwp_write+0x54d>
   11402:	48 8d 05 e7 44 00 00 	lea    0x44e7(%rip),%rax        # 158f0 <exec_in_fp0+0x80>
   11409:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
   1140d:	4d 8d 6e 08          	lea    0x8(%r14),%r13
   11411:	4c 89 e9             	mov    %r13,%rcx
   11414:	48 85 f6             	test   %rsi,%rsi
   11417:	79 04                	jns    1141d <fwp_write+0x55d>
   11419:	49 8b 4e 10          	mov    0x10(%r14),%rcx
   1141d:	48 83 f8 01          	cmp    $0x1,%rax
   11421:	0f 84 76 0a 00 00    	je     11e9d <fwp_write+0xfdd>
   11427:	48 83 f8 08          	cmp    $0x8,%rax
   1142b:	0f 84 67 0a 00 00    	je     11e98 <fwp_write+0xfd8>
   11431:	48 83 f8 02          	cmp    $0x2,%rax
   11435:	0f 85 6e 0a 00 00    	jne    11ea9 <fwp_write+0xfe9>
   1143b:	83 3a 01             	cmpl   $0x1,(%rdx)
   1143e:	0f b7 01             	movzwl (%rcx),%eax
   11441:	48 0f bf f0          	movswq %ax,%rsi
   11445:	e9 67 0a 00 00       	jmp    11eb1 <fwp_write+0xff1>
   1144a:	48 8d 35 4d 53 00 00 	lea    0x534d(%rip),%rsi        # 1679e <exec_in_fp0+0xf2e>
   11451:	ba 06 00 00 00       	mov    $0x6,%edx
   11456:	48 89 ef             	mov    %rbp,%rdi
   11459:	e8 32 be ff ff       	call   d290 <buf_put>
   1145e:	49 83 3e 00          	cmpq   $0x0,(%r14)
   11462:	0f 84 a5 00 00 00    	je     1150d <fwp_write+0x64d>
   11468:	41 0f b6 4e 08       	movzbl 0x8(%r14),%ecx
   1146d:	48 8d 15 31 53 00 00 	lea    0x5331(%rip),%rdx        # 167a5 <exec_in_fp0+0xf35>
   11474:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
   11479:	be 00 02 00 00       	mov    $0x200,%esi
   1147e:	4c 89 ff             	mov    %r15,%rdi
   11481:	31 c0                	xor    %eax,%eax
   11483:	e8 48 1d ff ff       	call   31d0 <snprintf@plt>
   11488:	4c 89 ff             	mov    %r15,%rdi
   1148b:	e8 e0 1c ff ff       	call   3170 <strlen@plt>
   11490:	48 89 ef             	mov    %rbp,%rdi
   11493:	4c 89 fe             	mov    %r15,%rsi
   11496:	48 89 c2             	mov    %rax,%rdx
   11499:	e8 f2 bd ff ff       	call   d290 <buf_put>
   1149e:	49 83 3e 02          	cmpq   $0x2,(%r14)
   114a2:	72 69                	jb     1150d <fwp_write+0x64d>
   114a4:	bb 09 00 00 00       	mov    $0x9,%ebx
   114a9:	4c 8d 3d 20 52 00 00 	lea    0x5220(%rip),%r15        # 166d0 <exec_in_fp0+0xe60>
   114b0:	4c 8d 25 ee 52 00 00 	lea    0x52ee(%rip),%r12        # 167a5 <exec_in_fp0+0xf35>
   114b7:	4c 8d 6c 24 70       	lea    0x70(%rsp),%r13
   114bc:	0f 1f 40 00          	nopl   0x0(%rax)
   114c0:	ba 02 00 00 00       	mov    $0x2,%edx
   114c5:	48 89 ef             	mov    %rbp,%rdi
   114c8:	4c 89 fe             	mov    %r15,%rsi
   114cb:	e8 c0 bd ff ff       	call   d290 <buf_put>
   114d0:	41 0f b6 0c 1e       	movzbl (%r14,%rbx,1),%ecx
   114d5:	be 00 02 00 00       	mov    $0x200,%esi
   114da:	4c 89 ef             	mov    %r13,%rdi
   114dd:	4c 89 e2             	mov    %r12,%rdx
   114e0:	31 c0                	xor    %eax,%eax
   114e2:	e8 e9 1c ff ff       	call   31d0 <snprintf@plt>
   114e7:	4c 89 ef             	mov    %r13,%rdi
   114ea:	e8 81 1c ff ff       	call   3170 <strlen@plt>
   114ef:	48 89 ef             	mov    %rbp,%rdi
   114f2:	4c 89 ee             	mov    %r13,%rsi
   114f5:	48 89 c2             	mov    %rax,%rdx
   114f8:	e8 93 bd ff ff       	call   d290 <buf_put>
   114fd:	48 8d 43 01          	lea    0x1(%rbx),%rax
   11501:	48 83 c3 f9          	add    $0xfffffffffffffff9,%rbx
   11505:	49 3b 1e             	cmp    (%r14),%rbx
   11508:	48 89 c3             	mov    %rax,%rbx
   1150b:	72 b3                	jb     114c0 <fwp_write+0x600>
   1150d:	c6 44 24 20 5d       	movb   $0x5d,0x20(%rsp)
   11512:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
   11517:	e9 90 0a 00 00       	jmp    11fac <fwp_write+0x10ec>
   1151c:	66 41 0f 6e ce       	movd   %r14d,%xmm1
   11521:	0f 2e c9             	ucomiss %xmm1,%xmm1
   11524:	0f 8a 73 0d 00 00    	jp     1229d <fwp_write+0x13dd>
   1152a:	0f 28 05 df 3b 00 00 	movaps 0x3bdf(%rip),%xmm0        # 15110 <_IO_stdin_used+0x110>
   11531:	0f 54 c1             	andps  %xmm1,%xmm0
   11534:	0f 2e 05 c9 3a 00 00 	ucomiss 0x3ac9(%rip),%xmm0        # 15004 <_IO_stdin_used+0x4>
   1153b:	0f 82 6e 04 00 00    	jb     119af <fwp_write+0xaef>
   11541:	0f 57 c0             	xorps  %xmm0,%xmm0
   11544:	0f 2e c8             	ucomiss %xmm0,%xmm1
   11547:	48 8d 05 b6 51 00 00 	lea    0x51b6(%rip),%rax        # 16704 <exec_in_fp0+0xe94>
   1154e:	48 8d 35 ae 51 00 00 	lea    0x51ae(%rip),%rsi        # 16703 <exec_in_fp0+0xe93>
   11555:	48 0f 47 f0          	cmova  %rax,%rsi
   11559:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   1155e:	e8 4d 1b ff ff       	call   30b0 <strcpy@plt>
   11563:	e9 90 0b 00 00       	jmp    120f8 <fwp_write+0x1238>
   11568:	48 8d 35 14 52 00 00 	lea    0x5214(%rip),%rsi        # 16783 <exec_in_fp0+0xf13>
   1156f:	ba 0a 00 00 00       	mov    $0xa,%edx
   11574:	48 89 ef             	mov    %rbp,%rdi
   11577:	e9 06 09 00 00       	jmp    11e82 <fwp_write+0xfc2>
   1157c:	48 8d 35 14 52 00 00 	lea    0x5214(%rip),%rsi        # 16797 <exec_in_fp0+0xf27>
   11583:	ba 06 00 00 00       	mov    $0x6,%edx
   11588:	48 89 ef             	mov    %rbp,%rdi
   1158b:	e8 00 bd ff ff       	call   d290 <buf_put>
   11590:	49 83 c6 10          	add    $0x10,%r14
   11594:	4c 89 f7             	mov    %r14,%rdi
   11597:	e8 d4 1b ff ff       	call   3170 <strlen@plt>
   1159c:	48 89 ef             	mov    %rbp,%rdi
   1159f:	4c 89 f6             	mov    %r14,%rsi
   115a2:	48 89 c2             	mov    %rax,%rdx
   115a5:	e8 e6 bc ff ff       	call   d290 <buf_put>
   115aa:	c6 44 24 70 3e       	movb   $0x3e,0x70(%rsp)
   115af:	e9 f3 09 00 00       	jmp    11fa7 <fwp_write+0x10e7>
   115b4:	41 8b 06             	mov    (%r14),%eax
   115b7:	49 8b 4f 18          	mov    0x18(%r15),%rcx
   115bb:	41 89 c5             	mov    %eax,%r13d
   115be:	4e 8b 24 e9          	mov    (%rcx,%r13,8),%r12
   115c2:	4c 89 e7             	mov    %r12,%rdi
   115c5:	e8 a6 1b ff ff       	call   3170 <strlen@plt>
   115ca:	48 89 ef             	mov    %rbp,%rdi
   115cd:	4c 89 e6             	mov    %r12,%rsi
   115d0:	48 89 c2             	mov    %rax,%rdx
   115d3:	e8 b8 bc ff ff       	call   d290 <buf_put>
   115d8:	49 8b 47 28          	mov    0x28(%r15),%rax
   115dc:	42 83 3c a8 00       	cmpl   $0x0,(%rax,%r13,4)
   115e1:	0f 8e 2c 0b 00 00    	jle    12113 <fwp_write+0x1253>
   115e7:	45 31 e4             	xor    %r12d,%r12d
   115ea:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
   115ef:	4c 89 6c 24 68       	mov    %r13,0x68(%rsp)
   115f4:	eb 3c                	jmp    11632 <fwp_write+0x772>
   115f6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   115fd:	00 00 00 
   11600:	48 8b 2c 24          	mov    (%rsp),%rbp
   11604:	48 89 ef             	mov    %rbp,%rdi
   11607:	48 89 de             	mov    %rbx,%rsi
   1160a:	4c 89 ea             	mov    %r13,%rdx
   1160d:	31 c9                	xor    %ecx,%ecx
   1160f:	e8 ac f8 ff ff       	call   10ec0 <fwp_write>
   11614:	49 ff c4             	inc    %r12
   11617:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
   1161c:	49 8b 47 28          	mov    0x28(%r15),%rax
   11620:	4c 8b 6c 24 68       	mov    0x68(%rsp),%r13
   11625:	4a 63 04 a8          	movslq (%rax,%r13,4),%rax
   11629:	49 39 c4             	cmp    %rax,%r12
   1162c:	0f 8d e1 0a 00 00    	jge    12113 <fwp_write+0x1253>
   11632:	4b 8b 5c e6 08       	mov    0x8(%r14,%r12,8),%rbx
   11637:	49 8b 47 30          	mov    0x30(%r15),%rax
   1163b:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
   1163f:	4e 8b 2c e0          	mov    (%rax,%r12,8),%r13
   11643:	c6 44 24 70 20       	movb   $0x20,0x70(%rsp)
   11648:	ba 01 00 00 00       	mov    $0x1,%edx
   1164d:	48 89 ef             	mov    %rbp,%rdi
   11650:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   11655:	e8 36 bc ff ff       	call   d290 <buf_put>
   1165a:	41 8b 45 00          	mov    0x0(%r13),%eax
   1165e:	48 83 f8 10          	cmp    $0x10,%rax
   11662:	77 9c                	ja     11600 <fwp_write+0x740>
   11664:	48 8d 0d f5 3e 00 00 	lea    0x3ef5(%rip),%rcx        # 15560 <_IO_stdin_used+0x560>
   1166b:	48 63 04 81          	movslq (%rcx,%rax,4),%rax
   1166f:	48 01 c8             	add    %rcx,%rax
   11672:	ff e0                	jmp    *%rax
   11674:	48 89 d9             	mov    %rbx,%rcx
   11677:	48 c1 e9 3f          	shr    $0x3f,%rcx
   1167b:	85 c9                	test   %ecx,%ecx
   1167d:	74 81                	je     11600 <fwp_write+0x740>
   1167f:	c6 44 24 70 28       	movb   $0x28,0x70(%rsp)
   11684:	ba 01 00 00 00       	mov    $0x1,%edx
   11689:	48 8b 2c 24          	mov    (%rsp),%rbp
   1168d:	48 89 ef             	mov    %rbp,%rdi
   11690:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
   11695:	4c 89 fe             	mov    %r15,%rsi
   11698:	e8 f3 bb ff ff       	call   d290 <buf_put>
   1169d:	48 89 ef             	mov    %rbp,%rdi
   116a0:	48 89 de             	mov    %rbx,%rsi
   116a3:	4c 89 ea             	mov    %r13,%rdx
   116a6:	31 c9                	xor    %ecx,%ecx
   116a8:	e8 13 f8 ff ff       	call   10ec0 <fwp_write>
   116ad:	c6 44 24 70 29       	movb   $0x29,0x70(%rsp)
   116b2:	ba 01 00 00 00       	mov    $0x1,%edx
   116b7:	48 89 ef             	mov    %rbp,%rdi
   116ba:	4c 89 fe             	mov    %r15,%rsi
   116bd:	e8 ce bb ff ff       	call   d290 <buf_put>
   116c2:	e9 4d ff ff ff       	jmp    11614 <fwp_write+0x754>
   116c7:	31 c9                	xor    %ecx,%ecx
   116c9:	48 81 fb 00 10 00 00 	cmp    $0x1000,%rbx
   116d0:	0f 93 c1             	setae  %cl
   116d3:	eb a6                	jmp    1167b <fwp_write+0x7bb>
   116d5:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
   116d9:	eb 9c                	jmp    11677 <fwp_write+0x7b7>
   116db:	89 d9                	mov    %ebx,%ecx
   116dd:	c1 e9 1f             	shr    $0x1f,%ecx
   116e0:	eb 99                	jmp    1167b <fwp_write+0x7bb>
   116e2:	49 8b 7d 08          	mov    0x8(%r13),%rdi
   116e6:	48 85 ff             	test   %rdi,%rdi
   116e9:	0f 84 11 ff ff ff    	je     11600 <fwp_write+0x740>
   116ef:	48 8d 35 f3 4f 00 00 	lea    0x4ff3(%rip),%rsi        # 166e9 <exec_in_fp0+0xe79>
   116f6:	e8 d5 1b ff ff       	call   32d0 <strcmp@plt>
   116fb:	31 c9                	xor    %ecx,%ecx
   116fd:	85 c0                	test   %eax,%eax
   116ff:	0f 95 c1             	setne  %cl
   11702:	e9 74 ff ff ff       	jmp    1167b <fwp_write+0x7bb>
   11707:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
   1170c:	0f 84 a7 08 00 00    	je     11fb9 <fwp_write+0x10f9>
   11712:	4d 8d 6f 10          	lea    0x10(%r15),%r13
   11716:	4d 85 e4             	test   %r12,%r12
   11719:	0f 94 c0             	sete   %al
   1171c:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
   11721:	0f 95 c3             	setne  %bl
   11724:	20 c3                	and    %al,%bl
   11726:	84 db                	test   %bl,%bl
   11728:	b8 28 00 00 00       	mov    $0x28,%eax
   1172d:	b9 7b 00 00 00       	mov    $0x7b,%ecx
   11732:	0f 45 c8             	cmovne %eax,%ecx
   11735:	88 4c 24 70          	mov    %cl,0x70(%rsp)
   11739:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   1173e:	ba 01 00 00 00       	mov    $0x1,%edx
   11743:	48 89 ef             	mov    %rbp,%rdi
   11746:	e8 45 bb ff ff       	call   d290 <buf_put>
   1174b:	41 83 7d 00 00       	cmpl   $0x0,0x0(%r13)
   11750:	0f 8e da 00 00 00    	jle    11830 <fwp_write+0x970>
   11756:	84 db                	test   %bl,%bl
   11758:	75 31                	jne    1178b <fwp_write+0x8cb>
   1175a:	49 8b 47 18          	mov    0x18(%r15),%rax
   1175e:	4c 8b 20             	mov    (%rax),%r12
   11761:	4c 89 e7             	mov    %r12,%rdi
   11764:	e8 07 1a ff ff       	call   3170 <strlen@plt>
   11769:	48 89 ef             	mov    %rbp,%rdi
   1176c:	4c 89 e6             	mov    %r12,%rsi
   1176f:	48 89 c2             	mov    %rax,%rdx
   11772:	e8 19 bb ff ff       	call   d290 <buf_put>
   11777:	48 8d 35 3e 50 00 00 	lea    0x503e(%rip),%rsi        # 167bc <exec_in_fp0+0xf4c>
   1177e:	ba 03 00 00 00       	mov    $0x3,%edx
   11783:	48 89 ef             	mov    %rbp,%rdi
   11786:	e8 05 bb ff ff       	call   d290 <buf_put>
   1178b:	49 8b 76 08          	mov    0x8(%r14),%rsi
   1178f:	49 8b 47 20          	mov    0x20(%r15),%rax
   11793:	48 8b 10             	mov    (%rax),%rdx
   11796:	48 89 ef             	mov    %rbp,%rdi
   11799:	31 c9                	xor    %ecx,%ecx
   1179b:	e8 20 f7 ff ff       	call   10ec0 <fwp_write>
   117a0:	41 83 7f 10 02       	cmpl   $0x2,0x10(%r15)
   117a5:	0f 8c 85 00 00 00    	jl     11830 <fwp_write+0x970>
   117ab:	41 bd 01 00 00 00    	mov    $0x1,%r13d
   117b1:	4c 8d 25 18 4f 00 00 	lea    0x4f18(%rip),%r12        # 166d0 <exec_in_fp0+0xe60>
   117b8:	eb 29                	jmp    117e3 <fwp_write+0x923>
   117ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   117c0:	4b 8b 74 ee 08       	mov    0x8(%r14,%r13,8),%rsi
   117c5:	49 8b 47 20          	mov    0x20(%r15),%rax
   117c9:	4a 8b 14 e8          	mov    (%rax,%r13,8),%rdx
   117cd:	48 89 ef             	mov    %rbp,%rdi
   117d0:	31 c9                	xor    %ecx,%ecx
   117d2:	e8 e9 f6 ff ff       	call   10ec0 <fwp_write>
   117d7:	49 ff c5             	inc    %r13
   117da:	49 63 47 10          	movslq 0x10(%r15),%rax
   117de:	49 39 c5             	cmp    %rax,%r13
   117e1:	7d 4d                	jge    11830 <fwp_write+0x970>
   117e3:	ba 02 00 00 00       	mov    $0x2,%edx
   117e8:	48 89 ef             	mov    %rbp,%rdi
   117eb:	4c 89 e6             	mov    %r12,%rsi
   117ee:	e8 9d ba ff ff       	call   d290 <buf_put>
   117f3:	84 db                	test   %bl,%bl
   117f5:	75 c9                	jne    117c0 <fwp_write+0x900>
   117f7:	49 8b 47 18          	mov    0x18(%r15),%rax
   117fb:	4a 8b 2c e8          	mov    (%rax,%r13,8),%rbp
   117ff:	48 89 ef             	mov    %rbp,%rdi
   11802:	e8 69 19 ff ff       	call   3170 <strlen@plt>
   11807:	48 8b 3c 24          	mov    (%rsp),%rdi
   1180b:	48 89 ee             	mov    %rbp,%rsi
   1180e:	48 8b 2c 24          	mov    (%rsp),%rbp
   11812:	48 89 c2             	mov    %rax,%rdx
   11815:	e8 76 ba ff ff       	call   d290 <buf_put>
   1181a:	ba 03 00 00 00       	mov    $0x3,%edx
   1181f:	48 89 ef             	mov    %rbp,%rdi
   11822:	48 8d 35 93 4f 00 00 	lea    0x4f93(%rip),%rsi        # 167bc <exec_in_fp0+0xf4c>
   11829:	e8 62 ba ff ff       	call   d290 <buf_put>
   1182e:	eb 90                	jmp    117c0 <fwp_write+0x900>
   11830:	84 db                	test   %bl,%bl
   11832:	b8 29 00 00 00       	mov    $0x29,%eax
   11837:	b9 7d 00 00 00       	mov    $0x7d,%ecx
   1183c:	0f 45 c8             	cmovne %eax,%ecx
   1183f:	88 4c 24 70          	mov    %cl,0x70(%rsp)
   11843:	e9 5f 07 00 00       	jmp    11fa7 <fwp_write+0x10e7>
   11848:	48 89 ef             	mov    %rbp,%rdi
   1184b:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
   11852:	5b                   	pop    %rbx
   11853:	41 5c                	pop    %r12
   11855:	41 5d                	pop    %r13
   11857:	41 5e                	pop    %r14
   11859:	41 5f                	pop    %r15
   1185b:	5d                   	pop    %rbp
   1185c:	e9 4f 0a 00 00       	jmp    122b0 <fwp_escape>
   11861:	c6 44 24 20 30       	movb   $0x30,0x20(%rsp)
   11866:	bf 01 00 00 00       	mov    $0x1,%edi
   1186b:	89 f8                	mov    %edi,%eax
   1186d:	48 83 f8 08          	cmp    $0x8,%rax
   11871:	73 0a                	jae    1187d <fwp_write+0x9bd>
   11873:	31 c9                	xor    %ecx,%ecx
   11875:	48 89 c2             	mov    %rax,%rdx
   11878:	e9 7a 04 00 00       	jmp    11cf7 <fwp_write+0xe37>
   1187d:	83 f8 20             	cmp    $0x20,%eax
   11880:	0f 83 68 03 00 00    	jae    11bee <fwp_write+0xd2e>
   11886:	31 c9                	xor    %ecx,%ecx
   11888:	e9 10 04 00 00       	jmp    11c9d <fwp_write+0xddd>
   1188d:	31 ff                	xor    %edi,%edi
   1188f:	49 f7 d8             	neg    %r8
   11892:	41 ba 00 00 00 00    	mov    $0x0,%r10d
   11898:	4d 19 ca             	sbb    %r9,%r10
   1189b:	c6 44 24 70 2d       	movb   $0x2d,0x70(%rsp)
   118a0:	49 b9 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r9
   118a7:	cc cc cc 
   118aa:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
   118b1:	cc cc cc 
   118b4:	4c 89 d3             	mov    %r10,%rbx
   118b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   118be:	00 00 
   118c0:	4c 89 d1             	mov    %r10,%rcx
   118c3:	4c 0f a4 c1 3f       	shld   $0x3f,%r8,%rcx
   118c8:	48 d1 eb             	shr    $1,%rbx
   118cb:	48 89 ce             	mov    %rcx,%rsi
   118ce:	48 01 de             	add    %rbx,%rsi
   118d1:	48 83 d6 00          	adc    $0x0,%rsi
   118d5:	48 89 f0             	mov    %rsi,%rax
   118d8:	49 f7 e1             	mul    %r9
   118db:	48 c1 ea 02          	shr    $0x2,%rdx
   118df:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   118e3:	48 29 c6             	sub    %rax,%rsi
   118e6:	48 29 f1             	sub    %rsi,%rcx
   118e9:	48 83 db 00          	sbb    $0x0,%rbx
   118ed:	48 89 ce             	mov    %rcx,%rsi
   118f0:	49 0f af f3          	imul   %r11,%rsi
   118f4:	48 89 c8             	mov    %rcx,%rax
   118f7:	49 f7 e1             	mul    %r9
   118fa:	48 01 f2             	add    %rsi,%rdx
   118fd:	49 0f af d9          	imul   %r9,%rbx
   11901:	48 01 d3             	add    %rdx,%rbx
   11904:	48 89 c1             	mov    %rax,%rcx
   11907:	48 01 c1             	add    %rax,%rcx
   1190a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
   1190e:	44 89 c2             	mov    %r8d,%edx
   11911:	29 ca                	sub    %ecx,%edx
   11913:	80 ca 30             	or     $0x30,%dl
   11916:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
   1191a:	48 ff c7             	inc    %rdi
   1191d:	49 83 f8 0a          	cmp    $0xa,%r8
   11921:	49 83 da 00          	sbb    $0x0,%r10
   11925:	49 89 c0             	mov    %rax,%r8
   11928:	49 89 da             	mov    %rbx,%r10
   1192b:	73 93                	jae    118c0 <fwp_write+0xa00>
   1192d:	85 ff                	test   %edi,%edi
   1192f:	0f 8e 98 06 00 00    	jle    11fcd <fwp_write+0x110d>
   11935:	89 f8                	mov    %edi,%eax
   11937:	48 83 f8 08          	cmp    $0x8,%rax
   1193b:	0f 83 e4 07 00 00    	jae    12125 <fwp_write+0x1265>
   11941:	31 c9                	xor    %ecx,%ecx
   11943:	48 89 c2             	mov    %rax,%rdx
   11946:	e9 fc 08 00 00       	jmp    12247 <fwp_write+0x1387>
   1194b:	bd 01 00 00 00       	mov    $0x1,%ebp
   11950:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11955:	0f 29 4c 24 10       	movaps %xmm1,0x10(%rsp)
   1195a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   11960:	4c 89 f7             	mov    %r14,%rdi
   11963:	66 0f 28 c1          	movapd %xmm1,%xmm0
   11967:	89 ee                	mov    %ebp,%esi
   11969:	e8 b2 15 00 00       	call   12f20 <fwp_format_g>
   1196e:	4c 89 f7             	mov    %r14,%rdi
   11971:	31 f6                	xor    %esi,%esi
   11973:	e8 88 17 ff ff       	call   3100 <strtod@plt>
   11978:	66 0f 28 4c 24 10    	movapd 0x10(%rsp),%xmm1
   1197e:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
   11982:	75 06                	jne    1198a <fwp_write+0xaca>
   11984:	0f 8b 9e 03 00 00    	jnp    11d28 <fwp_write+0xe68>
   1198a:	ff c5                	inc    %ebp
   1198c:	83 fd 12             	cmp    $0x12,%ebp
   1198f:	75 cf                	jne    11960 <fwp_write+0xaa0>
   11991:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11996:	4c 89 f7             	mov    %r14,%rdi
   11999:	66 0f 28 c1          	movapd %xmm1,%xmm0
   1199d:	be 11 00 00 00       	mov    $0x11,%esi
   119a2:	e8 79 15 00 00       	call   12f20 <fwp_format_g>
   119a7:	4c 89 f7             	mov    %r14,%rdi
   119aa:	e9 7e 03 00 00       	jmp    11d2d <fwp_write+0xe6d>
   119af:	0f 57 c0             	xorps  %xmm0,%xmm0
   119b2:	f3 0f 5a c1          	cvtss2sd %xmm1,%xmm0
   119b6:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   119bb:	4c 89 f7             	mov    %r14,%rdi
   119be:	f2 0f 11 44 24 10    	movsd  %xmm0,0x10(%rsp)
   119c4:	be 01 00 00 00       	mov    $0x1,%esi
   119c9:	0f 29 0c 24          	movaps %xmm1,(%rsp)
   119cd:	e8 4e 15 00 00       	call   12f20 <fwp_format_g>
   119d2:	4c 89 f7             	mov    %r14,%rdi
   119d5:	31 f6                	xor    %esi,%esi
   119d7:	e8 24 18 ff ff       	call   3200 <strtof@plt>
   119dc:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   119e0:	75 06                	jne    119e8 <fwp_write+0xb28>
   119e2:	0f 8b 6f 01 00 00    	jnp    11b57 <fwp_write+0xc97>
   119e8:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   119ed:	4c 89 f7             	mov    %r14,%rdi
   119f0:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   119f6:	be 02 00 00 00       	mov    $0x2,%esi
   119fb:	e8 20 15 00 00       	call   12f20 <fwp_format_g>
   11a00:	4c 89 f7             	mov    %r14,%rdi
   11a03:	31 f6                	xor    %esi,%esi
   11a05:	e8 f6 17 ff ff       	call   3200 <strtof@plt>
   11a0a:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   11a0e:	75 06                	jne    11a16 <fwp_write+0xb56>
   11a10:	0f 8b 41 01 00 00    	jnp    11b57 <fwp_write+0xc97>
   11a16:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11a1b:	4c 89 f7             	mov    %r14,%rdi
   11a1e:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   11a24:	be 03 00 00 00       	mov    $0x3,%esi
   11a29:	e8 f2 14 00 00       	call   12f20 <fwp_format_g>
   11a2e:	4c 89 f7             	mov    %r14,%rdi
   11a31:	31 f6                	xor    %esi,%esi
   11a33:	e8 c8 17 ff ff       	call   3200 <strtof@plt>
   11a38:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   11a3c:	75 06                	jne    11a44 <fwp_write+0xb84>
   11a3e:	0f 8b 13 01 00 00    	jnp    11b57 <fwp_write+0xc97>
   11a44:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11a49:	4c 89 f7             	mov    %r14,%rdi
   11a4c:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   11a52:	be 04 00 00 00       	mov    $0x4,%esi
   11a57:	e8 c4 14 00 00       	call   12f20 <fwp_format_g>
   11a5c:	4c 89 f7             	mov    %r14,%rdi
   11a5f:	31 f6                	xor    %esi,%esi
   11a61:	e8 9a 17 ff ff       	call   3200 <strtof@plt>
   11a66:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   11a6a:	75 06                	jne    11a72 <fwp_write+0xbb2>
   11a6c:	0f 8b e5 00 00 00    	jnp    11b57 <fwp_write+0xc97>
   11a72:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11a77:	4c 89 f7             	mov    %r14,%rdi
   11a7a:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   11a80:	be 05 00 00 00       	mov    $0x5,%esi
   11a85:	e8 96 14 00 00       	call   12f20 <fwp_format_g>
   11a8a:	4c 89 f7             	mov    %r14,%rdi
   11a8d:	31 f6                	xor    %esi,%esi
   11a8f:	e8 6c 17 ff ff       	call   3200 <strtof@plt>
   11a94:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   11a98:	75 06                	jne    11aa0 <fwp_write+0xbe0>
   11a9a:	0f 8b b7 00 00 00    	jnp    11b57 <fwp_write+0xc97>
   11aa0:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11aa5:	4c 89 f7             	mov    %r14,%rdi
   11aa8:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   11aae:	be 06 00 00 00       	mov    $0x6,%esi
   11ab3:	e8 68 14 00 00       	call   12f20 <fwp_format_g>
   11ab8:	4c 89 f7             	mov    %r14,%rdi
   11abb:	31 f6                	xor    %esi,%esi
   11abd:	e8 3e 17 ff ff       	call   3200 <strtof@plt>
   11ac2:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   11ac6:	75 06                	jne    11ace <fwp_write+0xc0e>
   11ac8:	0f 8b 89 00 00 00    	jnp    11b57 <fwp_write+0xc97>
   11ace:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11ad3:	4c 89 f7             	mov    %r14,%rdi
   11ad6:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   11adc:	be 07 00 00 00       	mov    $0x7,%esi
   11ae1:	e8 3a 14 00 00       	call   12f20 <fwp_format_g>
   11ae6:	4c 89 f7             	mov    %r14,%rdi
   11ae9:	31 f6                	xor    %esi,%esi
   11aeb:	e8 10 17 ff ff       	call   3200 <strtof@plt>
   11af0:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   11af4:	75 02                	jne    11af8 <fwp_write+0xc38>
   11af6:	7b 5f                	jnp    11b57 <fwp_write+0xc97>
   11af8:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11afd:	4c 89 f7             	mov    %r14,%rdi
   11b00:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   11b06:	be 08 00 00 00       	mov    $0x8,%esi
   11b0b:	e8 10 14 00 00       	call   12f20 <fwp_format_g>
   11b10:	4c 89 f7             	mov    %r14,%rdi
   11b13:	31 f6                	xor    %esi,%esi
   11b15:	e8 e6 16 ff ff       	call   3200 <strtof@plt>
   11b1a:	0f 28 0c 24          	movaps (%rsp),%xmm1
   11b1e:	0f 2e c1             	ucomiss %xmm1,%xmm0
   11b21:	75 02                	jne    11b25 <fwp_write+0xc65>
   11b23:	7b 32                	jnp    11b57 <fwp_write+0xc97>
   11b25:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11b2a:	4c 89 f7             	mov    %r14,%rdi
   11b2d:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   11b33:	be 09 00 00 00       	mov    $0x9,%esi
   11b38:	e8 e3 13 00 00       	call   12f20 <fwp_format_g>
   11b3d:	4c 89 f7             	mov    %r14,%rdi
   11b40:	31 f6                	xor    %esi,%esi
   11b42:	e8 b9 16 ff ff       	call   3200 <strtof@plt>
   11b47:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   11b4b:	0f 85 2c 07 00 00    	jne    1227d <fwp_write+0x13bd>
   11b51:	0f 8a 26 07 00 00    	jp     1227d <fwp_write+0x13bd>
   11b57:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   11b5c:	be 2e 00 00 00       	mov    $0x2e,%esi
   11b61:	e8 4a 16 ff ff       	call   31b0 <strchr@plt>
   11b66:	48 85 c0             	test   %rax,%rax
   11b69:	0f 85 89 05 00 00    	jne    120f8 <fwp_write+0x1238>
   11b6f:	e9 d0 01 00 00       	jmp    11d44 <fwp_write+0xe84>
   11b74:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
   11b7b:	00 
   11b7c:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
   11b83:	00 
   11b84:	4c 29 ff             	sub    %r15,%rdi
   11b87:	48 39 cf             	cmp    %rcx,%rdi
   11b8a:	0f 83 1b 02 00 00    	jae    11dab <fwp_write+0xeeb>
   11b90:	48 89 d7             	mov    %rdx,%rdi
   11b93:	be 01 00 00 00       	mov    $0x1,%esi
   11b98:	e8 a3 67 ff ff       	call   8340 <fwp_gc_alloc_slow>
   11b9d:	49 89 c7             	mov    %rax,%r15
   11ba0:	e9 20 02 00 00       	jmp    11dc5 <fwp_write+0xf05>
   11ba5:	49 8b 76 08          	mov    0x8(%r14),%rsi
   11ba9:	48 89 f2             	mov    %rsi,%rdx
   11bac:	48 c1 fa 3f          	sar    $0x3f,%rdx
   11bb0:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11bb5:	4c 89 f7             	mov    %r14,%rdi
   11bb8:	e8 33 08 00 00       	call   123f0 <fwp_fmt_duration>
   11bbd:	e9 3b 05 00 00       	jmp    120fd <fwp_write+0x123d>
   11bc2:	c6 44 24 20 30       	movb   $0x30,0x20(%rsp)
   11bc7:	bf 01 00 00 00       	mov    $0x1,%edi
   11bcc:	89 f8                	mov    %edi,%eax
   11bce:	48 83 f8 08          	cmp    $0x8,%rax
   11bd2:	73 0a                	jae    11bde <fwp_write+0xd1e>
   11bd4:	31 c9                	xor    %ecx,%ecx
   11bd6:	48 89 c2             	mov    %rax,%rdx
   11bd9:	e9 f2 04 00 00       	jmp    120d0 <fwp_write+0x1210>
   11bde:	83 f8 20             	cmp    $0x20,%eax
   11be1:	0f 83 f2 03 00 00    	jae    11fd9 <fwp_write+0x1119>
   11be7:	31 c9                	xor    %ecx,%ecx
   11be9:	e9 92 04 00 00       	jmp    12080 <fwp_write+0x11c0>
   11bee:	89 fa                	mov    %edi,%edx
   11bf0:	83 e2 1f             	and    $0x1f,%edx
   11bf3:	48 89 c1             	mov    %rax,%rcx
   11bf6:	48 29 d1             	sub    %rdx,%rcx
   11bf9:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
   11c00:	00 
   11c01:	66 0f ef c0          	pxor   %xmm0,%xmm0
   11c05:	49 89 c0             	mov    %rax,%r8
   11c08:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   11c0f:	00 
   11c10:	f3 42 0f 6f 0c 04    	movdqu (%rsp,%r8,1),%xmm1
   11c16:	f3 42 0f 6f 54 04 10 	movdqu 0x10(%rsp,%r8,1),%xmm2
   11c1d:	66 0f 6f da          	movdqa %xmm2,%xmm3
   11c21:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   11c25:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   11c2a:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   11c2f:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   11c34:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   11c38:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   11c3d:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   11c42:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   11c47:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   11c4b:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   11c4f:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   11c53:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   11c58:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   11c5d:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   11c62:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   11c66:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   11c6b:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   11c70:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   11c75:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   11c79:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
   11c7e:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
   11c82:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
   11c86:	48 83 c6 20          	add    $0x20,%rsi
   11c8a:	4c 39 c2             	cmp    %r8,%rdx
   11c8d:	75 81                	jne    11c10 <fwp_write+0xd50>
   11c8f:	48 85 d2             	test   %rdx,%rdx
   11c92:	0f 84 5b 04 00 00    	je     120f3 <fwp_write+0x1233>
   11c98:	83 fa 08             	cmp    $0x8,%edx
   11c9b:	72 5a                	jb     11cf7 <fwp_write+0xe37>
   11c9d:	89 fa                	mov    %edi,%edx
   11c9f:	83 e2 07             	and    $0x7,%edx
   11ca2:	48 89 c6             	mov    %rax,%rsi
   11ca5:	48 29 ce             	sub    %rcx,%rsi
   11ca8:	48 8d 3c 0c          	lea    (%rsp,%rcx,1),%rdi
   11cac:	48 83 c7 70          	add    $0x70,%rdi
   11cb0:	48 89 c1             	mov    %rax,%rcx
   11cb3:	48 29 d1             	sub    %rdx,%rcx
   11cb6:	66 0f ef c0          	pxor   %xmm0,%xmm0
   11cba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   11cc0:	f3 0f 7e 4c 34 18    	movq   0x18(%rsp,%rsi,1),%xmm1
   11cc6:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   11cca:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   11ccf:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   11cd4:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   11cd9:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   11cdd:	66 0f d6 0f          	movq   %xmm1,(%rdi)
   11ce1:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
   11ce5:	48 83 c7 08          	add    $0x8,%rdi
   11ce9:	48 39 f2             	cmp    %rsi,%rdx
   11cec:	75 d2                	jne    11cc0 <fwp_write+0xe00>
   11cee:	48 85 d2             	test   %rdx,%rdx
   11cf1:	0f 84 fc 03 00 00    	je     120f3 <fwp_write+0x1233>
   11cf7:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
   11cfc:	48 01 f2             	add    %rsi,%rdx
   11cff:	48 ff ca             	dec    %rdx
   11d02:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   11d09:	1f 84 00 00 00 00 00 
   11d10:	0f b6 32             	movzbl (%rdx),%esi
   11d13:	40 88 74 0c 70       	mov    %sil,0x70(%rsp,%rcx,1)
   11d18:	48 ff c1             	inc    %rcx
   11d1b:	48 ff ca             	dec    %rdx
   11d1e:	48 39 c8             	cmp    %rcx,%rax
   11d21:	75 ed                	jne    11d10 <fwp_write+0xe50>
   11d23:	e9 cb 03 00 00       	jmp    120f3 <fwp_write+0x1233>
   11d28:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   11d2d:	be 2e 00 00 00       	mov    $0x2e,%esi
   11d32:	e8 79 14 ff ff       	call   31b0 <strchr@plt>
   11d37:	48 85 c0             	test   %rax,%rax
   11d3a:	48 8b 2c 24          	mov    (%rsp),%rbp
   11d3e:	0f 85 b4 03 00 00    	jne    120f8 <fwp_write+0x1238>
   11d44:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   11d49:	be 65 00 00 00       	mov    $0x65,%esi
   11d4e:	e8 5d 14 ff ff       	call   31b0 <strchr@plt>
   11d53:	48 85 c0             	test   %rax,%rax
   11d56:	0f 85 9c 03 00 00    	jne    120f8 <fwp_write+0x1238>
   11d5c:	48 8d 35 a1 49 00 00 	lea    0x49a1(%rip),%rsi        # 16704 <exec_in_fp0+0xe94>
   11d63:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   11d68:	e8 63 17 ff ff       	call   34d0 <strstr@plt>
   11d6d:	48 85 c0             	test   %rax,%rax
   11d70:	0f 85 82 03 00 00    	jne    120f8 <fwp_write+0x1238>
   11d76:	48 8d 35 8b 49 00 00 	lea    0x498b(%rip),%rsi        # 16708 <exec_in_fp0+0xe98>
   11d7d:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   11d82:	e8 49 17 ff ff       	call   34d0 <strstr@plt>
   11d87:	48 85 c0             	test   %rax,%rax
   11d8a:	0f 85 68 03 00 00    	jne    120f8 <fwp_write+0x1238>
   11d90:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   11d95:	e8 d6 13 ff ff       	call   3170 <strlen@plt>
   11d9a:	66 c7 44 04 70 2e 30 	movw   $0x302e,0x70(%rsp,%rax,1)
   11da1:	c6 44 04 72 00       	movb   $0x0,0x72(%rsp,%rax,1)
   11da6:	e9 4d 03 00 00       	jmp    120f8 <fwp_write+0x1238>
   11dab:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
   11daf:	48 05 d0 03 00 00    	add    $0x3d0,%rax
   11db5:	4c 01 f9             	add    %r15,%rcx
   11db8:	48 89 08             	mov    %rcx,(%rax)
   11dbb:	4c 89 ff             	mov    %r15,%rdi
   11dbe:	31 f6                	xor    %esi,%esi
   11dc0:	e8 4b 14 ff ff       	call   3210 <memset@plt>
   11dc5:	66 41 c7 07 30 74    	movw   $0x7430,(%r15)
   11dcb:	85 db                	test   %ebx,%ebx
   11dcd:	0f 8e 98 00 00 00    	jle    11e6b <fwp_write+0xfab>
   11dd3:	44 89 e1             	mov    %r12d,%ecx
   11dd6:	48 f7 d9             	neg    %rcx
   11dd9:	4a 8d 34 3b          	lea    (%rbx,%r15,1),%rsi
   11ddd:	48 ff c6             	inc    %rsi
   11de0:	31 ff                	xor    %edi,%edi
   11de2:	49 b8 56 55 55 55 55 	movabs $0x5555555555555556,%r8
   11de9:	55 55 55 
   11dec:	eb 2e                	jmp    11e1c <fwp_write+0xf5c>
   11dee:	66 90                	xchg   %ax,%ax
   11df0:	41 b2 30             	mov    $0x30,%r10b
   11df3:	44 88 14 3e          	mov    %r10b,(%rsi,%rdi,1)
   11df7:	48 85 d2             	test   %rdx,%rdx
   11dfa:	0f 95 c2             	setne  %dl
   11dfd:	4d 85 f6             	test   %r14,%r14
   11e00:	41 0f 98 c2          	sets   %r10b
   11e04:	41 20 d2             	and    %dl,%r10b
   11e07:	41 0f b6 d2          	movzbl %r10b,%edx
   11e0b:	48 29 d0             	sub    %rdx,%rax
   11e0e:	4c 01 c8             	add    %r9,%rax
   11e11:	48 ff cf             	dec    %rdi
   11e14:	49 89 c6             	mov    %rax,%r14
   11e17:	48 39 f9             	cmp    %rdi,%rcx
   11e1a:	74 4f                	je     11e6b <fwp_write+0xfab>
   11e1c:	4c 89 f0             	mov    %r14,%rax
   11e1f:	49 f7 e8             	imul   %r8
   11e22:	48 89 d0             	mov    %rdx,%rax
   11e25:	48 c1 e8 3f          	shr    $0x3f,%rax
   11e29:	48 01 d0             	add    %rdx,%rax
   11e2c:	4c 8d 0c 40          	lea    (%rax,%rax,2),%r9
   11e30:	4c 89 f2             	mov    %r14,%rdx
   11e33:	4c 29 ca             	sub    %r9,%rdx
   11e36:	49 f7 d9             	neg    %r9
   11e39:	4d 01 f1             	add    %r14,%r9
   11e3c:	49 83 c1 03          	add    $0x3,%r9
   11e40:	48 83 fa fd          	cmp    $0xfffffffffffffffd,%rdx
   11e44:	4c 0f 42 ca          	cmovb  %rdx,%r9
   11e48:	4d 85 c9             	test   %r9,%r9
   11e4b:	74 a3                	je     11df0 <fwp_write+0xf30>
   11e4d:	49 83 f9 01          	cmp    $0x1,%r9
   11e51:	75 0d                	jne    11e60 <fwp_write+0xfa0>
   11e53:	41 b2 2b             	mov    $0x2b,%r10b
   11e56:	45 31 c9             	xor    %r9d,%r9d
   11e59:	eb 98                	jmp    11df3 <fwp_write+0xf33>
   11e5b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   11e60:	41 b2 2d             	mov    $0x2d,%r10b
   11e63:	41 b9 01 00 00 00    	mov    $0x1,%r9d
   11e69:	eb 88                	jmp    11df3 <fwp_write+0xf33>
   11e6b:	43 c6 44 27 02 00    	movb   $0x0,0x2(%r15,%r12,1)
   11e71:	4c 89 ff             	mov    %r15,%rdi
   11e74:	e8 f7 12 ff ff       	call   3170 <strlen@plt>
   11e79:	48 89 ef             	mov    %rbp,%rdi
   11e7c:	4c 89 fe             	mov    %r15,%rsi
   11e7f:	48 89 c2             	mov    %rax,%rdx
   11e82:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
   11e89:	5b                   	pop    %rbx
   11e8a:	41 5c                	pop    %r12
   11e8c:	41 5d                	pop    %r13
   11e8e:	41 5e                	pop    %r14
   11e90:	41 5f                	pop    %r15
   11e92:	5d                   	pop    %rbp
   11e93:	e9 f8 b3 ff ff       	jmp    d290 <buf_put>
   11e98:	48 8b 31             	mov    (%rcx),%rsi
   11e9b:	eb 18                	jmp    11eb5 <fwp_write+0xff5>
   11e9d:	83 3a 00             	cmpl   $0x0,(%rdx)
   11ea0:	0f b6 01             	movzbl (%rcx),%eax
   11ea3:	48 0f be f0          	movsbq %al,%rsi
   11ea7:	eb 08                	jmp    11eb1 <fwp_write+0xff1>
   11ea9:	83 3a 02             	cmpl   $0x2,(%rdx)
   11eac:	8b 01                	mov    (%rcx),%eax
   11eae:	48 63 f0             	movslq %eax,%rsi
   11eb1:	48 0f 45 f0          	cmovne %rax,%rsi
   11eb5:	48 8b 2c 24          	mov    (%rsp),%rbp
   11eb9:	48 89 ef             	mov    %rbp,%rdi
   11ebc:	31 c9                	xor    %ecx,%ecx
   11ebe:	e8 fd ef ff ff       	call   10ec0 <fwp_write>
   11ec3:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
   11eca:	ff ff 7f 
   11ecd:	48 ff c8             	dec    %rax
   11ed0:	49 85 06             	test   %rax,(%r14)
   11ed3:	0f 84 c9 00 00 00    	je     11fa2 <fwp_write+0x10e2>
   11ed9:	bb 01 00 00 00       	mov    $0x1,%ebx
   11ede:	4c 8d 25 eb 47 00 00 	lea    0x47eb(%rip),%r12        # 166d0 <exec_in_fp0+0xe60>
   11ee5:	eb 39                	jmp    11f20 <fwp_write+0x1060>
   11ee7:	83 3a 01             	cmpl   $0x1,(%rdx)
   11eea:	0f b7 04 31          	movzwl (%rcx,%rsi,1),%eax
   11eee:	48 0f bf f0          	movswq %ax,%rsi
   11ef2:	48 0f 45 f0          	cmovne %rax,%rsi
   11ef6:	48 8b 2c 24          	mov    (%rsp),%rbp
   11efa:	48 89 ef             	mov    %rbp,%rdi
   11efd:	31 c9                	xor    %ecx,%ecx
   11eff:	e8 bc ef ff ff       	call   10ec0 <fwp_write>
   11f04:	48 ff c3             	inc    %rbx
   11f07:	49 8b 06             	mov    (%r14),%rax
   11f0a:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
   11f11:	ff ff 7f 
   11f14:	48 21 c8             	and    %rcx,%rax
   11f17:	48 39 c3             	cmp    %rax,%rbx
   11f1a:	0f 83 82 00 00 00    	jae    11fa2 <fwp_write+0x10e2>
   11f20:	ba 02 00 00 00       	mov    $0x2,%edx
   11f25:	48 89 ef             	mov    %rbp,%rdi
   11f28:	4c 89 e6             	mov    %r12,%rsi
   11f2b:	e8 60 b3 ff ff       	call   d290 <buf_put>
   11f30:	49 8b 57 38          	mov    0x38(%r15),%rdx
   11f34:	b8 08 00 00 00       	mov    $0x8,%eax
   11f39:	48 85 d2             	test   %rdx,%rdx
   11f3c:	74 13                	je     11f51 <fwp_write+0x1091>
   11f3e:	8b 0a                	mov    (%rdx),%ecx
   11f40:	48 83 f9 0a          	cmp    $0xa,%rcx
   11f44:	77 0b                	ja     11f51 <fwp_write+0x1091>
   11f46:	48 8d 05 a3 39 00 00 	lea    0x39a3(%rip),%rax        # 158f0 <exec_in_fp0+0x80>
   11f4d:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
   11f51:	49 83 3e 00          	cmpq   $0x0,(%r14)
   11f55:	4c 89 e9             	mov    %r13,%rcx
   11f58:	79 04                	jns    11f5e <fwp_write+0x109e>
   11f5a:	49 8b 4e 10          	mov    0x10(%r14),%rcx
   11f5e:	48 89 c6             	mov    %rax,%rsi
   11f61:	48 0f af f3          	imul   %rbx,%rsi
   11f65:	48 83 f8 01          	cmp    $0x1,%rax
   11f69:	74 19                	je     11f84 <fwp_write+0x10c4>
   11f6b:	48 83 f8 02          	cmp    $0x2,%rax
   11f6f:	0f 84 72 ff ff ff    	je     11ee7 <fwp_write+0x1027>
   11f75:	48 83 f8 08          	cmp    $0x8,%rax
   11f79:	75 19                	jne    11f94 <fwp_write+0x10d4>
   11f7b:	48 8b 34 31          	mov    (%rcx,%rsi,1),%rsi
   11f7f:	e9 72 ff ff ff       	jmp    11ef6 <fwp_write+0x1036>
   11f84:	83 3a 00             	cmpl   $0x0,(%rdx)
   11f87:	0f b6 04 31          	movzbl (%rcx,%rsi,1),%eax
   11f8b:	48 0f be f0          	movsbq %al,%rsi
   11f8f:	e9 5e ff ff ff       	jmp    11ef2 <fwp_write+0x1032>
   11f94:	83 3a 02             	cmpl   $0x2,(%rdx)
   11f97:	8b 04 31             	mov    (%rcx,%rsi,1),%eax
   11f9a:	48 63 f0             	movslq %eax,%rsi
   11f9d:	e9 50 ff ff ff       	jmp    11ef2 <fwp_write+0x1032>
   11fa2:	c6 44 24 70 5d       	movb   $0x5d,0x70(%rsp)
   11fa7:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   11fac:	ba 01 00 00 00       	mov    $0x1,%edx
   11fb1:	48 89 ef             	mov    %rbp,%rdi
   11fb4:	e9 55 01 00 00       	jmp    1210e <fwp_write+0x124e>
   11fb9:	48 8d 35 f9 47 00 00 	lea    0x47f9(%rip),%rsi        # 167b9 <exec_in_fp0+0xf49>
   11fc0:	ba 02 00 00 00       	mov    $0x2,%edx
   11fc5:	48 89 ef             	mov    %rbp,%rdi
   11fc8:	e9 b5 fe ff ff       	jmp    11e82 <fwp_write+0xfc2>
   11fcd:	31 c0                	xor    %eax,%eax
   11fcf:	c6 44 04 71 00       	movb   $0x0,0x71(%rsp,%rax,1)
   11fd4:	e9 1f 01 00 00       	jmp    120f8 <fwp_write+0x1238>
   11fd9:	89 fa                	mov    %edi,%edx
   11fdb:	83 e2 1f             	and    $0x1f,%edx
   11fde:	48 89 c1             	mov    %rax,%rcx
   11fe1:	48 29 d1             	sub    %rdx,%rcx
   11fe4:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
   11feb:	00 
   11fec:	66 0f ef c0          	pxor   %xmm0,%xmm0
   11ff0:	49 89 c0             	mov    %rax,%r8
   11ff3:	f3 42 0f 6f 0c 04    	movdqu (%rsp,%r8,1),%xmm1
   11ff9:	f3 42 0f 6f 54 04 10 	movdqu 0x10(%rsp,%r8,1),%xmm2
   12000:	66 0f 6f da          	movdqa %xmm2,%xmm3
   12004:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12008:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   1200d:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   12012:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12017:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   1201b:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   12020:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   12025:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   1202a:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   1202e:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   12032:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12036:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   1203b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   12040:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12045:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   12049:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   1204e:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12053:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12058:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   1205c:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
   12061:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
   12065:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
   12069:	48 83 c6 20          	add    $0x20,%rsi
   1206d:	4c 39 c2             	cmp    %r8,%rdx
   12070:	75 81                	jne    11ff3 <fwp_write+0x1133>
   12072:	48 85 d2             	test   %rdx,%rdx
   12075:	0f 84 78 00 00 00    	je     120f3 <fwp_write+0x1233>
   1207b:	83 fa 08             	cmp    $0x8,%edx
   1207e:	72 50                	jb     120d0 <fwp_write+0x1210>
   12080:	89 fa                	mov    %edi,%edx
   12082:	83 e2 07             	and    $0x7,%edx
   12085:	48 89 c6             	mov    %rax,%rsi
   12088:	48 29 ce             	sub    %rcx,%rsi
   1208b:	48 8d 3c 0c          	lea    (%rsp,%rcx,1),%rdi
   1208f:	48 83 c7 70          	add    $0x70,%rdi
   12093:	48 89 c1             	mov    %rax,%rcx
   12096:	48 29 d1             	sub    %rdx,%rcx
   12099:	66 0f ef c0          	pxor   %xmm0,%xmm0
   1209d:	f3 0f 7e 4c 34 18    	movq   0x18(%rsp,%rsi,1),%xmm1
   120a3:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   120a7:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   120ac:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   120b1:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   120b6:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   120ba:	66 0f d6 0f          	movq   %xmm1,(%rdi)
   120be:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
   120c2:	48 83 c7 08          	add    $0x8,%rdi
   120c6:	48 39 f2             	cmp    %rsi,%rdx
   120c9:	75 d2                	jne    1209d <fwp_write+0x11dd>
   120cb:	48 85 d2             	test   %rdx,%rdx
   120ce:	74 23                	je     120f3 <fwp_write+0x1233>
   120d0:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
   120d5:	48 01 f2             	add    %rsi,%rdx
   120d8:	48 ff ca             	dec    %rdx
   120db:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   120e0:	0f b6 32             	movzbl (%rdx),%esi
   120e3:	40 88 74 0c 70       	mov    %sil,0x70(%rsp,%rcx,1)
   120e8:	48 ff c1             	inc    %rcx
   120eb:	48 ff ca             	dec    %rdx
   120ee:	48 39 c8             	cmp    %rcx,%rax
   120f1:	75 ed                	jne    120e0 <fwp_write+0x1220>
   120f3:	c6 44 04 70 00       	movb   $0x0,0x70(%rsp,%rax,1)
   120f8:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   120fd:	4c 89 f7             	mov    %r14,%rdi
   12100:	e8 6b 10 ff ff       	call   3170 <strlen@plt>
   12105:	48 89 ef             	mov    %rbp,%rdi
   12108:	4c 89 f6             	mov    %r14,%rsi
   1210b:	48 89 c2             	mov    %rax,%rdx
   1210e:	e8 7d b1 ff ff       	call   d290 <buf_put>
   12113:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
   1211a:	5b                   	pop    %rbx
   1211b:	41 5c                	pop    %r12
   1211d:	41 5d                	pop    %r13
   1211f:	41 5e                	pop    %r14
   12121:	41 5f                	pop    %r15
   12123:	5d                   	pop    %rbp
   12124:	c3                   	ret
   12125:	83 f8 20             	cmp    $0x20,%eax
   12128:	73 07                	jae    12131 <fwp_write+0x1271>
   1212a:	31 c9                	xor    %ecx,%ecx
   1212c:	e9 b6 00 00 00       	jmp    121e7 <fwp_write+0x1327>
   12131:	89 fe                	mov    %edi,%esi
   12133:	89 fa                	mov    %edi,%edx
   12135:	83 e2 1f             	and    $0x1f,%edx
   12138:	48 89 c1             	mov    %rax,%rcx
   1213b:	48 29 d1             	sub    %rdx,%rcx
   1213e:	4c 8d 04 34          	lea    (%rsp,%rsi,1),%r8
   12142:	49 83 c0 10          	add    $0x10,%r8
   12146:	48 29 d6             	sub    %rdx,%rsi
   12149:	45 31 c9             	xor    %r9d,%r9d
   1214c:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12150:	f3 41 0f 6f 48 f0    	movdqu -0x10(%r8),%xmm1
   12156:	f3 41 0f 6f 10       	movdqu (%r8),%xmm2
   1215b:	66 0f 6f da          	movdqa %xmm2,%xmm3
   1215f:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12163:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12168:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   1216d:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12172:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   12176:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   1217b:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   12180:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   12185:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   12189:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   1218d:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12191:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12196:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   1219b:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   121a0:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   121a4:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   121a9:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   121ae:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   121b3:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   121b7:	f3 42 0f 7f 54 0c 71 	movdqu %xmm2,0x71(%rsp,%r9,1)
   121be:	f3 42 0f 7f 8c 0c 81 	movdqu %xmm1,0x81(%rsp,%r9,1)
   121c5:	00 00 00 
   121c8:	49 83 c1 20          	add    $0x20,%r9
   121cc:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
   121d0:	4c 39 ce             	cmp    %r9,%rsi
   121d3:	0f 85 77 ff ff ff    	jne    12150 <fwp_write+0x1290>
   121d9:	48 85 d2             	test   %rdx,%rdx
   121dc:	0f 84 91 00 00 00    	je     12273 <fwp_write+0x13b3>
   121e2:	83 fa 08             	cmp    $0x8,%edx
   121e5:	72 60                	jb     12247 <fwp_write+0x1387>
   121e7:	48 89 ce             	mov    %rcx,%rsi
   121ea:	41 89 f8             	mov    %edi,%r8d
   121ed:	89 fa                	mov    %edi,%edx
   121ef:	83 e2 07             	and    $0x7,%edx
   121f2:	48 89 c1             	mov    %rax,%rcx
   121f5:	48 29 d1             	sub    %rdx,%rcx
   121f8:	49 89 f1             	mov    %rsi,%r9
   121fb:	49 f7 d9             	neg    %r9
   121fe:	49 01 e1             	add    %rsp,%r9
   12201:	49 83 c1 20          	add    $0x20,%r9
   12205:	4d 01 c1             	add    %r8,%r9
   12208:	49 83 c1 f8          	add    $0xfffffffffffffff8,%r9
   1220c:	49 29 d0             	sub    %rdx,%r8
   1220f:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12213:	f3 41 0f 7e 09       	movq   (%r9),%xmm1
   12218:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   1221c:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   12221:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12226:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   1222b:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   1222f:	66 0f d6 4c 34 71    	movq   %xmm1,0x71(%rsp,%rsi,1)
   12235:	48 83 c6 08          	add    $0x8,%rsi
   12239:	49 83 c1 f8          	add    $0xfffffffffffffff8,%r9
   1223d:	49 39 f0             	cmp    %rsi,%r8
   12240:	75 d1                	jne    12213 <fwp_write+0x1353>
   12242:	48 85 d2             	test   %rdx,%rdx
   12245:	74 2c                	je     12273 <fwp_write+0x13b3>
   12247:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
   1224c:	48 01 f2             	add    %rsi,%rdx
   1224f:	48 ff ca             	dec    %rdx
   12252:	89 fe                	mov    %edi,%esi
   12254:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
   1225b:	00 00 00 00 00 
   12260:	0f b6 3a             	movzbl (%rdx),%edi
   12263:	40 88 7c 0c 71       	mov    %dil,0x71(%rsp,%rcx,1)
   12268:	48 ff c1             	inc    %rcx
   1226b:	48 ff ca             	dec    %rdx
   1226e:	48 39 ce             	cmp    %rcx,%rsi
   12271:	75 ed                	jne    12260 <fwp_write+0x13a0>
   12273:	c6 44 04 71 00       	movb   $0x0,0x71(%rsp,%rax,1)
   12278:	e9 7b fe ff ff       	jmp    120f8 <fwp_write+0x1238>
   1227d:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   12282:	4c 89 f7             	mov    %r14,%rdi
   12285:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   1228b:	be 09 00 00 00       	mov    $0x9,%esi
   12290:	e8 8b 0c 00 00       	call   12f20 <fwp_format_g>
   12295:	4c 89 f7             	mov    %r14,%rdi
   12298:	e9 bf f8 ff ff       	jmp    11b5c <fwp_write+0xc9c>
   1229d:	c7 44 24 70 4e 61 4e 	movl   $0x4e614e,0x70(%rsp)
   122a4:	00 
   122a5:	e9 4e fe ff ff       	jmp    120f8 <fwp_write+0x1238>
   122aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000122b0 <fwp_escape>:
   122b0:	55                   	push   %rbp
   122b1:	41 57                	push   %r15
   122b3:	41 56                	push   %r14
   122b5:	41 55                	push   %r13
   122b7:	41 54                	push   %r12
   122b9:	53                   	push   %rbx
   122ba:	48 83 ec 18          	sub    $0x18,%rsp
   122be:	49 89 d6             	mov    %rdx,%r14
   122c1:	49 89 f7             	mov    %rsi,%r15
   122c4:	48 89 fb             	mov    %rdi,%rbx
   122c7:	c6 04 24 22          	movb   $0x22,(%rsp)
   122cb:	48 89 e6             	mov    %rsp,%rsi
   122ce:	ba 01 00 00 00       	mov    $0x1,%edx
   122d3:	e8 b8 af ff ff       	call   d290 <buf_put>
   122d8:	4d 85 f6             	test   %r14,%r14
   122db:	0f 84 de 00 00 00    	je     123bf <fwp_escape+0x10f>
   122e1:	48 89 e5             	mov    %rsp,%rbp
   122e4:	4c 8d 2d b9 32 00 00 	lea    0x32b9(%rip),%r13        # 155a4 <_IO_stdin_used+0x5a4>
   122eb:	45 31 e4             	xor    %r12d,%r12d
   122ee:	eb 21                	jmp    12311 <fwp_escape+0x61>
   122f0:	ba 02 00 00 00       	mov    $0x2,%edx
   122f5:	48 89 df             	mov    %rbx,%rdi
   122f8:	48 8d 35 e4 44 00 00 	lea    0x44e4(%rip),%rsi        # 167e3 <exec_in_fp0+0xf73>
   122ff:	90                   	nop
   12300:	e8 8b af ff ff       	call   d290 <buf_put>
   12305:	49 ff c4             	inc    %r12
   12308:	4d 39 e6             	cmp    %r12,%r14
   1230b:	0f 84 ae 00 00 00    	je     123bf <fwp_escape+0x10f>
   12311:	43 0f b6 04 27       	movzbl (%r15,%r12,1),%eax
   12316:	0f b6 c8             	movzbl %al,%ecx
   12319:	8d 51 f7             	lea    -0x9(%rcx),%edx
   1231c:	83 fa 19             	cmp    $0x19,%edx
   1231f:	77 1f                	ja     12340 <fwp_escape+0x90>
   12321:	49 63 54 95 00       	movslq 0x0(%r13,%rdx,4),%rdx
   12326:	4c 01 ea             	add    %r13,%rdx
   12329:	ff e2                	jmp    *%rdx
   1232b:	ba 02 00 00 00       	mov    $0x2,%edx
   12330:	48 89 df             	mov    %rbx,%rdi
   12333:	48 8d 35 a6 44 00 00 	lea    0x44a6(%rip),%rsi        # 167e0 <exec_in_fp0+0xf70>
   1233a:	eb c4                	jmp    12300 <fwp_escape+0x50>
   1233c:	0f 1f 40 00          	nopl   0x0(%rax)
   12340:	83 f9 5c             	cmp    $0x5c,%ecx
   12343:	75 11                	jne    12356 <fwp_escape+0xa6>
   12345:	ba 02 00 00 00       	mov    $0x2,%edx
   1234a:	48 89 df             	mov    %rbx,%rdi
   1234d:	48 8d 35 86 44 00 00 	lea    0x4486(%rip),%rsi        # 167da <exec_in_fp0+0xf6a>
   12354:	eb aa                	jmp    12300 <fwp_escape+0x50>
   12356:	3c 20                	cmp    $0x20,%al
   12358:	72 39                	jb     12393 <fwp_escape+0xe3>
   1235a:	3c 7f                	cmp    $0x7f,%al
   1235c:	74 35                	je     12393 <fwp_escape+0xe3>
   1235e:	88 04 24             	mov    %al,(%rsp)
   12361:	ba 01 00 00 00       	mov    $0x1,%edx
   12366:	48 89 df             	mov    %rbx,%rdi
   12369:	48 89 ee             	mov    %rbp,%rsi
   1236c:	eb 92                	jmp    12300 <fwp_escape+0x50>
   1236e:	ba 02 00 00 00       	mov    $0x2,%edx
   12373:	48 89 df             	mov    %rbx,%rdi
   12376:	48 8d 35 5a 44 00 00 	lea    0x445a(%rip),%rsi        # 167d7 <exec_in_fp0+0xf67>
   1237d:	eb 81                	jmp    12300 <fwp_escape+0x50>
   1237f:	ba 02 00 00 00       	mov    $0x2,%edx
   12384:	48 89 df             	mov    %rbx,%rdi
   12387:	48 8d 35 4f 44 00 00 	lea    0x444f(%rip),%rsi        # 167dd <exec_in_fp0+0xf6d>
   1238e:	e9 6d ff ff ff       	jmp    12300 <fwp_escape+0x50>
   12393:	be 10 00 00 00       	mov    $0x10,%esi
   12398:	48 89 ef             	mov    %rbp,%rdi
   1239b:	48 8d 15 44 44 00 00 	lea    0x4444(%rip),%rdx        # 167e6 <exec_in_fp0+0xf76>
   123a2:	31 c0                	xor    %eax,%eax
   123a4:	e8 27 0e ff ff       	call   31d0 <snprintf@plt>
   123a9:	48 89 ef             	mov    %rbp,%rdi
   123ac:	e8 bf 0d ff ff       	call   3170 <strlen@plt>
   123b1:	48 89 df             	mov    %rbx,%rdi
   123b4:	48 89 ee             	mov    %rbp,%rsi
   123b7:	48 89 c2             	mov    %rax,%rdx
   123ba:	e9 41 ff ff ff       	jmp    12300 <fwp_escape+0x50>
   123bf:	c6 04 24 22          	movb   $0x22,(%rsp)
   123c3:	48 89 e6             	mov    %rsp,%rsi
   123c6:	ba 01 00 00 00       	mov    $0x1,%edx
   123cb:	48 89 df             	mov    %rbx,%rdi
   123ce:	e8 bd ae ff ff       	call   d290 <buf_put>
   123d3:	48 83 c4 18          	add    $0x18,%rsp
   123d7:	5b                   	pop    %rbx
   123d8:	41 5c                	pop    %r12
   123da:	41 5d                	pop    %r13
   123dc:	41 5e                	pop    %r14
   123de:	41 5f                	pop    %r15
   123e0:	5d                   	pop    %rbp
   123e1:	c3                   	ret
   123e2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   123e9:	1f 84 00 00 00 00 00 

00000000000123f0 <fwp_fmt_duration>:
   123f0:	41 57                	push   %r15
   123f2:	41 56                	push   %r14
   123f4:	41 54                	push   %r12
   123f6:	53                   	push   %rbx
   123f7:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
   123fe:	48 89 f0             	mov    %rsi,%rax
   12401:	48 09 d0             	or     %rdx,%rax
   12404:	0f 84 bf 02 00 00    	je     126c9 <fwp_fmt_duration+0x2d9>
   1240a:	49 89 d0             	mov    %rdx,%r8
   1240d:	48 b9 1d 3f c2 25 d6 	movabs $0xd2fe1d625c23f1d,%rcx
   12414:	e1 2f 0d 
   12417:	48 0f af ce          	imul   %rsi,%rcx
   1241b:	49 b9 0d b1 f3 e4 99 	movabs $0x1c52799e4f3b10d,%r9
   12422:	27 c5 01 
   12425:	48 89 f0             	mov    %rsi,%rax
   12428:	49 f7 e1             	mul    %r9
   1242b:	48 01 ca             	add    %rcx,%rdx
   1242e:	4d 0f af c8          	imul   %r8,%r9
   12432:	49 01 d1             	add    %rdx,%r9
   12435:	48 b9 00 a0 34 52 a3 	movabs $0x6baf6aa35234a000,%rcx
   1243c:	6a af 6b 
   1243f:	48 01 c1             	add    %rax,%rcx
   12442:	48 b8 37 f9 ff e2 04 	movabs $0x4e2fff937,%rax
   12449:	00 00 00 
   1244c:	4c 11 c8             	adc    %r9,%rax
   1244f:	48 89 c2             	mov    %rax,%rdx
   12452:	48 0f ac ca 0d       	shrd   $0xd,%rcx,%rdx
   12457:	48 0f a4 c8 33       	shld   $0x33,%rcx,%rax
   1245c:	48 b9 4a 23 35 aa f6 	movabs $0x9376baf6aa35234a,%rcx
   12463:	ba 76 93 
   12466:	48 39 c1             	cmp    %rax,%rcx
   12469:	b8 ff 2f 4e 00       	mov    $0x4e2fff,%eax
   1246e:	48 19 d0             	sbb    %rdx,%rax
   12471:	0f 83 70 02 00 00    	jae    126e7 <fwp_fmt_duration+0x2f7>
   12477:	48 b9 b3 b2 61 36 8c 	movabs $0xc5ce3b8c3661b2b3,%rcx
   1247e:	3b ce c5 
   12481:	49 b9 c3 5f 47 6a 04 	movabs $0x1a8d52046a475fc3,%r9
   12488:	52 8d 1a 
   1248b:	48 89 f0             	mov    %rsi,%rax
   1248e:	49 f7 e1             	mul    %r9
   12491:	48 0f af ce          	imul   %rsi,%rcx
   12495:	48 01 ca             	add    %rcx,%rdx
   12498:	4d 0f af c8          	imul   %r8,%r9
   1249c:	49 01 d1             	add    %rdx,%r9
   1249f:	48 b9 00 a8 16 d1 91 	movabs $0x4f473f91d116a800,%rcx
   124a6:	3f 47 4f 
   124a9:	48 01 c1             	add    %rax,%rcx
   124ac:	48 b8 3f 9a ff 4c 49 	movabs $0x494cff9a3f,%rax
   124b3:	00 00 00 
   124b6:	4c 11 c8             	adc    %r9,%rax
   124b9:	48 89 c2             	mov    %rax,%rdx
   124bc:	48 0f ac ca 0b       	shrd   $0xb,%rcx,%rdx
   124c1:	48 0f a4 c8 35       	shld   $0x35,%rcx,%rax
   124c6:	48 b9 ab 45 74 e4 cf 	movabs $0x8fd3d1cfe47445ab,%rcx
   124cd:	d1 d3 8f 
   124d0:	48 39 c8             	cmp    %rcx,%rax
   124d3:	48 81 da e6 3f 53 12 	sbb    $0x12533fe6,%rdx
   124da:	0f 82 27 02 00 00    	jb     12707 <fwp_fmt_duration+0x317>
   124e0:	48 b9 7e 78 b9 2f 37 	movabs $0x97157d372fb9787e,%rcx
   124e7:	7d 15 97 
   124ea:	48 0f af ce          	imul   %rsi,%rcx
   124ee:	49 b9 6d 9c 2e 3a 42 	movabs $0x8e47ce423a2e9c6d,%r9
   124f5:	ce 47 8e 
   124f8:	48 89 f0             	mov    %rsi,%rax
   124fb:	49 f7 e1             	mul    %r9
   124fe:	48 01 ca             	add    %rcx,%rdx
   12501:	4d 0f af c8          	imul   %r8,%r9
   12505:	49 01 d1             	add    %rdx,%r9
   12508:	48 b9 00 46 54 40 8b 	movabs $0xa52cb98b40544600,%rcx
   1250f:	b9 2c a5 
   12512:	48 01 c1             	add    %rax,%rcx
   12515:	48 b8 b5 09 fa 82 4b 	movabs $0x44b82fa09b5,%rax
   1251c:	04 00 00 
   1251f:	4c 11 c8             	adc    %r9,%rax
   12522:	48 89 c2             	mov    %rax,%rdx
   12525:	48 0f ac ca 09       	shrd   $0x9,%rcx,%rdx
   1252a:	48 0f a4 c8 37       	shld   $0x37,%rcx,%rax
   1252f:	48 b9 47 54 40 8b b9 	movabs $0xb5a52cb98b405447,%rcx
   12536:	2c a5 b5 
   12539:	48 39 c8             	cmp    %rcx,%rax
   1253c:	48 b8 09 fa 82 4b 04 	movabs $0x44b82fa09,%rax
   12543:	00 00 00 
   12546:	48 19 c2             	sbb    %rax,%rdx
   12549:	0f 82 0d 03 00 00    	jb     1285c <fwp_fmt_duration+0x46c>
   1254f:	48 b9 cb d5 8f 4d f2 	movabs $0xc57e23f24d8fd5cb,%rcx
   12556:	23 7e c5 
   12559:	48 0f af ce          	imul   %rsi,%rcx
   1255d:	49 b9 39 61 c2 68 56 	movabs $0x790fb65668c26139,%r9
   12564:	b6 0f 79 
   12567:	48 89 f0             	mov    %rsi,%rax
   1256a:	49 f7 e1             	mul    %r9
   1256d:	48 01 ca             	add    %rcx,%rdx
   12570:	4d 0f af c8          	imul   %r8,%r9
   12574:	49 01 d1             	add    %rdx,%r9
   12577:	48 b9 00 0b 27 69 fe 	movabs $0xa6d698fe69270b00,%rcx
   1257e:	98 d6 a6 
   12581:	48 01 c1             	add    %rax,%rcx
   12584:	48 b8 b1 bd 16 f4 de 	movabs $0x218def416bdb1,%rax
   1258b:	18 02 00 
   1258e:	4c 11 c8             	adc    %r9,%rax
   12591:	48 89 c2             	mov    %rax,%rdx
   12594:	48 0f ac ca 06       	shrd   $0x6,%rcx,%rdx
   12599:	48 0f a4 c8 3a       	shld   $0x3a,%rcx,%rax
   1259e:	48 b9 59 38 49 f3 c7 	movabs $0x8d36b4c7f3493859,%rcx
   125a5:	b4 36 8d 
   125a8:	48 39 c8             	cmp    %rcx,%rax
   125ab:	48 b8 ed b5 a0 f7 c6 	movabs $0x10c6f7a0b5ed,%rax
   125b2:	10 00 00 
   125b5:	48 19 c2             	sbb    %rax,%rdx
   125b8:	0f 82 ad 02 00 00    	jb     1286b <fwp_fmt_duration+0x47b>
   125be:	48 b9 5a 64 3b df 4f 	movabs $0x6e978d4fdf3b645a,%rcx
   125c5:	8d 97 6e 
   125c8:	48 0f af ce          	imul   %rsi,%rcx
   125cc:	49 b9 d5 78 e9 26 31 	movabs $0x1cac083126e978d5,%r9
   125d3:	08 ac 1c 
   125d6:	48 89 f0             	mov    %rsi,%rax
   125d9:	49 f7 e1             	mul    %r9
   125dc:	48 01 ca             	add    %rcx,%rdx
   125df:	4d 0f af c8          	imul   %r8,%r9
   125e3:	49 01 d1             	add    %rdx,%r9
   125e6:	48 b9 48 62 10 58 39 	movabs $0x76c8b43958106248,%rcx
   125ed:	b4 c8 76 
   125f0:	48 01 c1             	add    %rax,%rcx
   125f3:	48 b8 be 9f 1a 2f dd 	movabs $0x10624dd2f1a9fbe,%rax
   125fa:	24 06 01 
   125fd:	4c 11 c8             	adc    %r9,%rax
   12600:	48 89 c2             	mov    %rax,%rdx
   12603:	48 0f ac ca 03       	shrd   $0x3,%rcx,%rdx
   12608:	48 0f a4 c8 3d       	shld   $0x3d,%rcx,%rax
   1260d:	48 b9 93 18 04 56 0e 	movabs $0x9db22d0e56041893,%rcx
   12614:	2d b2 9d 
   12617:	48 39 c8             	cmp    %rcx,%rax
   1261a:	48 b8 ef a7 c6 4b 37 	movabs $0x4189374bc6a7ef,%rax
   12621:	89 41 00 
   12624:	48 19 c2             	sbb    %rax,%rdx
   12627:	0f 82 4d 02 00 00    	jb     1287a <fwp_fmt_duration+0x48a>
   1262d:	4d 85 c0             	test   %r8,%r8
   12630:	0f 88 d6 06 00 00    	js     12d0c <fwp_fmt_duration+0x91c>
   12636:	45 31 d2             	xor    %r10d,%r10d
   12639:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
   12640:	cc cc cc 
   12643:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
   1264a:	cc cc cc 
   1264d:	4d 89 c6             	mov    %r8,%r14
   12650:	4c 89 c1             	mov    %r8,%rcx
   12653:	48 0f a4 f1 3f       	shld   $0x3f,%rsi,%rcx
   12658:	49 d1 ee             	shr    $1,%r14
   1265b:	49 89 c9             	mov    %rcx,%r9
   1265e:	4d 01 f1             	add    %r14,%r9
   12661:	49 83 d1 00          	adc    $0x0,%r9
   12665:	4c 89 c8             	mov    %r9,%rax
   12668:	49 f7 e3             	mul    %r11
   1266b:	48 c1 ea 02          	shr    $0x2,%rdx
   1266f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   12673:	49 29 c1             	sub    %rax,%r9
   12676:	4c 29 c9             	sub    %r9,%rcx
   12679:	49 83 de 00          	sbb    $0x0,%r14
   1267d:	49 89 c9             	mov    %rcx,%r9
   12680:	4c 0f af cb          	imul   %rbx,%r9
   12684:	48 89 c8             	mov    %rcx,%rax
   12687:	49 f7 e3             	mul    %r11
   1268a:	4c 01 ca             	add    %r9,%rdx
   1268d:	4d 0f af f3          	imul   %r11,%r14
   12691:	49 01 d6             	add    %rdx,%r14
   12694:	48 89 c1             	mov    %rax,%rcx
   12697:	48 01 c1             	add    %rax,%rcx
   1269a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
   1269e:	89 f2                	mov    %esi,%edx
   126a0:	29 ca                	sub    %ecx,%edx
   126a2:	80 ca 30             	or     $0x30,%dl
   126a5:	42 88 54 14 40       	mov    %dl,0x40(%rsp,%r10,1)
   126aa:	49 ff c2             	inc    %r10
   126ad:	48 83 fe 0a          	cmp    $0xa,%rsi
   126b1:	49 83 d8 00          	sbb    $0x0,%r8
   126b5:	48 89 c6             	mov    %rax,%rsi
   126b8:	4d 89 f0             	mov    %r14,%r8
   126bb:	73 93                	jae    12650 <fwp_fmt_duration+0x260>
   126bd:	45 85 d2             	test   %r10d,%r10d
   126c0:	7f 12                	jg     126d4 <fwp_fmt_duration+0x2e4>
   126c2:	31 c0                	xor    %eax,%eax
   126c4:	e9 79 01 00 00       	jmp    12842 <fwp_fmt_duration+0x452>
   126c9:	c6 44 24 40 30       	movb   $0x30,0x40(%rsp)
   126ce:	41 ba 01 00 00 00    	mov    $0x1,%r10d
   126d4:	44 89 d0             	mov    %r10d,%eax
   126d7:	48 83 f8 08          	cmp    $0x8,%rax
   126db:	73 1e                	jae    126fb <fwp_fmt_duration+0x30b>
   126dd:	31 c9                	xor    %ecx,%ecx
   126df:	48 89 c2             	mov    %rax,%rdx
   126e2:	e9 3d 01 00 00       	jmp    12824 <fwp_fmt_duration+0x434>
   126e7:	49 89 fe             	mov    %rdi,%r14
   126ea:	48 ba 00 a0 b8 30 46 	movabs $0x34630b8a000,%rdx
   126f1:	03 00 00 
   126f4:	31 c0                	xor    %eax,%eax
   126f6:	e9 8c 01 00 00       	jmp    12887 <fwp_fmt_duration+0x497>
   126fb:	83 f8 20             	cmp    $0x20,%eax
   126fe:	73 1e                	jae    1271e <fwp_fmt_duration+0x32e>
   12700:	31 c9                	xor    %ecx,%ecx
   12702:	e9 c3 00 00 00       	jmp    127ca <fwp_fmt_duration+0x3da>
   12707:	49 89 fe             	mov    %rdi,%r14
   1270a:	48 ba 00 58 47 f8 0d 	movabs $0xdf8475800,%rdx
   12711:	00 00 00 
   12714:	b8 01 00 00 00       	mov    $0x1,%eax
   12719:	e9 69 01 00 00       	jmp    12887 <fwp_fmt_duration+0x497>
   1271e:	44 89 d2             	mov    %r10d,%edx
   12721:	83 e2 1f             	and    $0x1f,%edx
   12724:	48 89 c1             	mov    %rax,%rcx
   12727:	48 29 d1             	sub    %rdx,%rcx
   1272a:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
   1272f:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12733:	49 89 c0             	mov    %rax,%r8
   12736:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   1273d:	00 00 00 
   12740:	f3 42 0f 6f 4c 04 20 	movdqu 0x20(%rsp,%r8,1),%xmm1
   12747:	f3 42 0f 6f 54 04 30 	movdqu 0x30(%rsp,%r8,1),%xmm2
   1274e:	66 0f 6f da          	movdqa %xmm2,%xmm3
   12752:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12756:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   1275b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   12760:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12765:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   12769:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   1276e:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   12773:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   12778:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   1277c:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   12780:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12784:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12789:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   1278e:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12793:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   12797:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   1279c:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   127a1:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   127a6:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   127aa:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
   127af:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
   127b3:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
   127b7:	48 83 c6 20          	add    $0x20,%rsi
   127bb:	4c 39 c2             	cmp    %r8,%rdx
   127be:	75 80                	jne    12740 <fwp_fmt_duration+0x350>
   127c0:	48 85 d2             	test   %rdx,%rdx
   127c3:	74 7d                	je     12842 <fwp_fmt_duration+0x452>
   127c5:	83 fa 08             	cmp    $0x8,%edx
   127c8:	72 5a                	jb     12824 <fwp_fmt_duration+0x434>
   127ca:	44 89 d2             	mov    %r10d,%edx
   127cd:	83 e2 07             	and    $0x7,%edx
   127d0:	48 89 c6             	mov    %rax,%rsi
   127d3:	48 29 ce             	sub    %rcx,%rsi
   127d6:	4c 8d 04 0c          	lea    (%rsp,%rcx,1),%r8
   127da:	48 89 c1             	mov    %rax,%rcx
   127dd:	48 29 d1             	sub    %rdx,%rcx
   127e0:	66 0f ef c0          	pxor   %xmm0,%xmm0
   127e4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
   127eb:	00 00 00 00 00 
   127f0:	f3 0f 7e 4c 34 38    	movq   0x38(%rsp,%rsi,1),%xmm1
   127f6:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   127fa:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   127ff:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12804:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12809:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   1280d:	66 41 0f d6 08       	movq   %xmm1,(%r8)
   12812:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
   12816:	49 83 c0 08          	add    $0x8,%r8
   1281a:	48 39 f2             	cmp    %rsi,%rdx
   1281d:	75 d1                	jne    127f0 <fwp_fmt_duration+0x400>
   1281f:	48 85 d2             	test   %rdx,%rdx
   12822:	74 1e                	je     12842 <fwp_fmt_duration+0x452>
   12824:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
   12829:	48 01 f2             	add    %rsi,%rdx
   1282c:	48 ff ca             	dec    %rdx
   1282f:	90                   	nop
   12830:	0f b6 32             	movzbl (%rdx),%esi
   12833:	40 88 34 0c          	mov    %sil,(%rsp,%rcx,1)
   12837:	48 ff c1             	inc    %rcx
   1283a:	48 ff ca             	dec    %rdx
   1283d:	48 39 c8             	cmp    %rcx,%rax
   12840:	75 ee                	jne    12830 <fwp_fmt_duration+0x440>
   12842:	c6 04 04 00          	movb   $0x0,(%rsp,%rax,1)
   12846:	48 8d 35 a5 3f 00 00 	lea    0x3fa5(%rip),%rsi        # 167f2 <exec_in_fp0+0xf82>
   1284d:	48 89 e2             	mov    %rsp,%rdx
   12850:	31 c0                	xor    %eax,%eax
   12852:	e8 f9 0b ff ff       	call   3450 <sprintf@plt>
   12857:	e9 a1 04 00 00       	jmp    12cfd <fwp_fmt_duration+0x90d>
   1285c:	49 89 fe             	mov    %rdi,%r14
   1285f:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
   12864:	b8 02 00 00 00       	mov    $0x2,%eax
   12869:	eb 1c                	jmp    12887 <fwp_fmt_duration+0x497>
   1286b:	49 89 fe             	mov    %rdi,%r14
   1286e:	ba 40 42 0f 00       	mov    $0xf4240,%edx
   12873:	b8 03 00 00 00       	mov    $0x3,%eax
   12878:	eb 0d                	jmp    12887 <fwp_fmt_duration+0x497>
   1287a:	49 89 fe             	mov    %rdi,%r14
   1287d:	ba e8 03 00 00       	mov    $0x3e8,%edx
   12882:	b8 04 00 00 00       	mov    $0x4,%eax
   12887:	31 c9                	xor    %ecx,%ecx
   12889:	c1 e0 04             	shl    $0x4,%eax
   1288c:	48 8d 1d cd 74 00 00 	lea    0x74cd(%rip),%rbx        # 19d60 <fwp_fmt_duration.units>
   12893:	48 01 c3             	add    %rax,%rbx
   12896:	48 89 f7             	mov    %rsi,%rdi
   12899:	4c 89 c6             	mov    %r8,%rsi
   1289c:	e8 bf 16 00 00       	call   13f60 <__divti3>
   128a1:	48 89 c1             	mov    %rax,%rcx
   128a4:	48 89 d6             	mov    %rdx,%rsi
   128a7:	48 85 d2             	test   %rdx,%rdx
   128aa:	0f 88 b0 00 00 00    	js     12960 <fwp_fmt_duration+0x570>
   128b0:	48 89 c8             	mov    %rcx,%rax
   128b3:	48 09 f0             	or     %rsi,%rax
   128b6:	0f 84 61 01 00 00    	je     12a1d <fwp_fmt_duration+0x62d>
   128bc:	45 31 d2             	xor    %r10d,%r10d
   128bf:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
   128c6:	cc cc cc 
   128c9:	49 bf cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r15
   128d0:	cc cc cc 
   128d3:	49 89 f4             	mov    %rsi,%r12
   128d6:	4c 89 f7             	mov    %r14,%rdi
   128d9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   128e0:	49 89 f0             	mov    %rsi,%r8
   128e3:	49 0f a4 c8 3f       	shld   $0x3f,%rcx,%r8
   128e8:	49 d1 ec             	shr    $1,%r12
   128eb:	4d 89 c1             	mov    %r8,%r9
   128ee:	4d 01 e1             	add    %r12,%r9
   128f1:	49 83 d1 00          	adc    $0x0,%r9
   128f5:	4c 89 c8             	mov    %r9,%rax
   128f8:	49 f7 e3             	mul    %r11
   128fb:	48 c1 ea 02          	shr    $0x2,%rdx
   128ff:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   12903:	49 29 c1             	sub    %rax,%r9
   12906:	4d 29 c8             	sub    %r9,%r8
   12909:	49 83 dc 00          	sbb    $0x0,%r12
   1290d:	4d 89 c1             	mov    %r8,%r9
   12910:	4d 0f af cf          	imul   %r15,%r9
   12914:	4c 89 c0             	mov    %r8,%rax
   12917:	49 f7 e3             	mul    %r11
   1291a:	4c 01 ca             	add    %r9,%rdx
   1291d:	4d 0f af e3          	imul   %r11,%r12
   12921:	49 01 d4             	add    %rdx,%r12
   12924:	48 89 c2             	mov    %rax,%rdx
   12927:	48 01 c2             	add    %rax,%rdx
   1292a:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
   1292e:	41 89 c8             	mov    %ecx,%r8d
   12931:	41 29 d0             	sub    %edx,%r8d
   12934:	41 80 c8 30          	or     $0x30,%r8b
   12938:	46 88 44 14 40       	mov    %r8b,0x40(%rsp,%r10,1)
   1293d:	49 ff c2             	inc    %r10
   12940:	48 83 f9 0a          	cmp    $0xa,%rcx
   12944:	48 83 de 00          	sbb    $0x0,%rsi
   12948:	48 89 c1             	mov    %rax,%rcx
   1294b:	4c 89 e6             	mov    %r12,%rsi
   1294e:	73 90                	jae    128e0 <fwp_fmt_duration+0x4f0>
   12950:	45 85 d2             	test   %r10d,%r10d
   12953:	0f 8f d2 00 00 00    	jg     12a2b <fwp_fmt_duration+0x63b>
   12959:	31 c0                	xor    %eax,%eax
   1295b:	e9 12 02 00 00       	jmp    12b72 <fwp_fmt_duration+0x782>
   12960:	45 31 c0             	xor    %r8d,%r8d
   12963:	48 f7 d9             	neg    %rcx
   12966:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   1296c:	49 19 f1             	sbb    %rsi,%r9
   1296f:	c6 04 24 2d          	movb   $0x2d,(%rsp)
   12973:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
   1297a:	cc cc cc 
   1297d:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
   12984:	cc cc cc 
   12987:	4d 89 cf             	mov    %r9,%r15
   1298a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   12990:	4c 89 ce             	mov    %r9,%rsi
   12993:	48 0f a4 ce 3f       	shld   $0x3f,%rcx,%rsi
   12998:	49 d1 ef             	shr    $1,%r15
   1299b:	48 89 f7             	mov    %rsi,%rdi
   1299e:	4c 01 ff             	add    %r15,%rdi
   129a1:	48 83 d7 00          	adc    $0x0,%rdi
   129a5:	48 89 f8             	mov    %rdi,%rax
   129a8:	49 f7 e2             	mul    %r10
   129ab:	48 c1 ea 02          	shr    $0x2,%rdx
   129af:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   129b3:	48 29 c7             	sub    %rax,%rdi
   129b6:	48 29 fe             	sub    %rdi,%rsi
   129b9:	49 83 df 00          	sbb    $0x0,%r15
   129bd:	48 89 f7             	mov    %rsi,%rdi
   129c0:	49 0f af fb          	imul   %r11,%rdi
   129c4:	48 89 f0             	mov    %rsi,%rax
   129c7:	49 f7 e2             	mul    %r10
   129ca:	48 01 fa             	add    %rdi,%rdx
   129cd:	4d 0f af fa          	imul   %r10,%r15
   129d1:	49 01 d7             	add    %rdx,%r15
   129d4:	48 89 c2             	mov    %rax,%rdx
   129d7:	48 01 c2             	add    %rax,%rdx
   129da:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
   129de:	89 ce                	mov    %ecx,%esi
   129e0:	29 d6                	sub    %edx,%esi
   129e2:	40 80 ce 30          	or     $0x30,%sil
   129e6:	42 88 74 04 40       	mov    %sil,0x40(%rsp,%r8,1)
   129eb:	49 ff c0             	inc    %r8
   129ee:	48 83 f9 0a          	cmp    $0xa,%rcx
   129f2:	49 83 d9 00          	sbb    $0x0,%r9
   129f6:	48 89 c1             	mov    %rax,%rcx
   129f9:	4d 89 f9             	mov    %r15,%r9
   129fc:	73 92                	jae    12990 <fwp_fmt_duration+0x5a0>
   129fe:	45 85 c0             	test   %r8d,%r8d
   12a01:	4c 89 f7             	mov    %r14,%rdi
   12a04:	7e 44                	jle    12a4a <fwp_fmt_duration+0x65a>
   12a06:	44 89 c0             	mov    %r8d,%eax
   12a09:	48 83 f8 08          	cmp    $0x8,%rax
   12a0d:	0f 83 68 01 00 00    	jae    12b7b <fwp_fmt_duration+0x78b>
   12a13:	31 c9                	xor    %ecx,%ecx
   12a15:	48 89 c2             	mov    %rax,%rdx
   12a18:	e9 97 02 00 00       	jmp    12cb4 <fwp_fmt_duration+0x8c4>
   12a1d:	c6 44 24 40 30       	movb   $0x30,0x40(%rsp)
   12a22:	41 ba 01 00 00 00    	mov    $0x1,%r10d
   12a28:	4c 89 f7             	mov    %r14,%rdi
   12a2b:	44 89 d0             	mov    %r10d,%eax
   12a2e:	48 83 f8 08          	cmp    $0x8,%rax
   12a32:	73 0a                	jae    12a3e <fwp_fmt_duration+0x64e>
   12a34:	31 c9                	xor    %ecx,%ecx
   12a36:	48 89 c2             	mov    %rax,%rdx
   12a39:	e9 16 01 00 00       	jmp    12b54 <fwp_fmt_duration+0x764>
   12a3e:	83 f8 20             	cmp    $0x20,%eax
   12a41:	73 0e                	jae    12a51 <fwp_fmt_duration+0x661>
   12a43:	31 c9                	xor    %ecx,%ecx
   12a45:	e9 b0 00 00 00       	jmp    12afa <fwp_fmt_duration+0x70a>
   12a4a:	31 c0                	xor    %eax,%eax
   12a4c:	e9 93 02 00 00       	jmp    12ce4 <fwp_fmt_duration+0x8f4>
   12a51:	44 89 d2             	mov    %r10d,%edx
   12a54:	83 e2 1f             	and    $0x1f,%edx
   12a57:	48 89 c1             	mov    %rax,%rcx
   12a5a:	48 29 d1             	sub    %rdx,%rcx
   12a5d:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
   12a62:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12a66:	49 89 c0             	mov    %rax,%r8
   12a69:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   12a70:	f3 42 0f 6f 4c 04 20 	movdqu 0x20(%rsp,%r8,1),%xmm1
   12a77:	f3 42 0f 6f 54 04 30 	movdqu 0x30(%rsp,%r8,1),%xmm2
   12a7e:	66 0f 6f da          	movdqa %xmm2,%xmm3
   12a82:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12a86:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12a8b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   12a90:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12a95:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   12a99:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   12a9e:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   12aa3:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   12aa8:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   12aac:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   12ab0:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12ab4:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12ab9:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   12abe:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12ac3:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   12ac7:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   12acc:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12ad1:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12ad6:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   12ada:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
   12adf:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
   12ae3:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
   12ae7:	48 83 c6 20          	add    $0x20,%rsi
   12aeb:	4c 39 c2             	cmp    %r8,%rdx
   12aee:	75 80                	jne    12a70 <fwp_fmt_duration+0x680>
   12af0:	48 85 d2             	test   %rdx,%rdx
   12af3:	74 7d                	je     12b72 <fwp_fmt_duration+0x782>
   12af5:	83 fa 08             	cmp    $0x8,%edx
   12af8:	72 5a                	jb     12b54 <fwp_fmt_duration+0x764>
   12afa:	44 89 d2             	mov    %r10d,%edx
   12afd:	83 e2 07             	and    $0x7,%edx
   12b00:	48 89 c6             	mov    %rax,%rsi
   12b03:	48 29 ce             	sub    %rcx,%rsi
   12b06:	4c 8d 04 0c          	lea    (%rsp,%rcx,1),%r8
   12b0a:	48 89 c1             	mov    %rax,%rcx
   12b0d:	48 29 d1             	sub    %rdx,%rcx
   12b10:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12b14:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
   12b1b:	00 00 00 00 00 
   12b20:	f3 0f 7e 4c 34 38    	movq   0x38(%rsp,%rsi,1),%xmm1
   12b26:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   12b2a:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   12b2f:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12b34:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12b39:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   12b3d:	66 41 0f d6 08       	movq   %xmm1,(%r8)
   12b42:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
   12b46:	49 83 c0 08          	add    $0x8,%r8
   12b4a:	48 39 f2             	cmp    %rsi,%rdx
   12b4d:	75 d1                	jne    12b20 <fwp_fmt_duration+0x730>
   12b4f:	48 85 d2             	test   %rdx,%rdx
   12b52:	74 1e                	je     12b72 <fwp_fmt_duration+0x782>
   12b54:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
   12b59:	48 01 f2             	add    %rsi,%rdx
   12b5c:	48 ff ca             	dec    %rdx
   12b5f:	90                   	nop
   12b60:	0f b6 32             	movzbl (%rdx),%esi
   12b63:	40 88 34 0c          	mov    %sil,(%rsp,%rcx,1)
   12b67:	48 ff c1             	inc    %rcx
   12b6a:	48 ff ca             	dec    %rdx
   12b6d:	48 39 c8             	cmp    %rcx,%rax
   12b70:	75 ee                	jne    12b60 <fwp_fmt_duration+0x770>
   12b72:	c6 04 04 00          	movb   $0x0,(%rsp,%rax,1)
   12b76:	e9 6e 01 00 00       	jmp    12ce9 <fwp_fmt_duration+0x8f9>
   12b7b:	83 f8 20             	cmp    $0x20,%eax
   12b7e:	73 07                	jae    12b87 <fwp_fmt_duration+0x797>
   12b80:	31 c9                	xor    %ecx,%ecx
   12b82:	e9 bd 00 00 00       	jmp    12c44 <fwp_fmt_duration+0x854>
   12b87:	44 89 c6             	mov    %r8d,%esi
   12b8a:	44 89 c2             	mov    %r8d,%edx
   12b8d:	83 e2 1f             	and    $0x1f,%edx
   12b90:	48 89 c1             	mov    %rax,%rcx
   12b93:	48 29 d1             	sub    %rdx,%rcx
   12b96:	4c 8d 0c 34          	lea    (%rsp,%rsi,1),%r9
   12b9a:	49 83 c1 30          	add    $0x30,%r9
   12b9e:	48 29 d6             	sub    %rdx,%rsi
   12ba1:	45 31 d2             	xor    %r10d,%r10d
   12ba4:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12ba8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   12baf:	00 
   12bb0:	f3 41 0f 6f 49 f0    	movdqu -0x10(%r9),%xmm1
   12bb6:	f3 41 0f 6f 11       	movdqu (%r9),%xmm2
   12bbb:	66 0f 6f da          	movdqa %xmm2,%xmm3
   12bbf:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12bc3:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12bc8:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   12bcd:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12bd2:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   12bd6:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   12bdb:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   12be0:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   12be5:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   12be9:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   12bed:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12bf1:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12bf6:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   12bfb:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12c00:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   12c04:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   12c09:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12c0e:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12c13:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   12c17:	f3 42 0f 7f 54 14 01 	movdqu %xmm2,0x1(%rsp,%r10,1)
   12c1e:	f3 42 0f 7f 4c 14 11 	movdqu %xmm1,0x11(%rsp,%r10,1)
   12c25:	49 83 c2 20          	add    $0x20,%r10
   12c29:	49 83 c1 e0          	add    $0xffffffffffffffe0,%r9
   12c2d:	4c 39 d6             	cmp    %r10,%rsi
   12c30:	0f 85 7a ff ff ff    	jne    12bb0 <fwp_fmt_duration+0x7c0>
   12c36:	48 85 d2             	test   %rdx,%rdx
   12c39:	0f 84 a5 00 00 00    	je     12ce4 <fwp_fmt_duration+0x8f4>
   12c3f:	83 fa 08             	cmp    $0x8,%edx
   12c42:	72 70                	jb     12cb4 <fwp_fmt_duration+0x8c4>
   12c44:	48 89 ce             	mov    %rcx,%rsi
   12c47:	45 89 c1             	mov    %r8d,%r9d
   12c4a:	44 89 c2             	mov    %r8d,%edx
   12c4d:	83 e2 07             	and    $0x7,%edx
   12c50:	48 89 c1             	mov    %rax,%rcx
   12c53:	48 29 d1             	sub    %rdx,%rcx
   12c56:	49 89 f2             	mov    %rsi,%r10
   12c59:	49 f7 da             	neg    %r10
   12c5c:	49 01 e2             	add    %rsp,%r10
   12c5f:	49 83 c2 40          	add    $0x40,%r10
   12c63:	4d 01 ca             	add    %r9,%r10
   12c66:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
   12c6a:	49 29 d1             	sub    %rdx,%r9
   12c6d:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12c71:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   12c78:	0f 1f 84 00 00 00 00 
   12c7f:	00 
   12c80:	f3 41 0f 7e 0a       	movq   (%r10),%xmm1
   12c85:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   12c89:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   12c8e:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12c93:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12c98:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   12c9c:	66 0f d6 4c 34 01    	movq   %xmm1,0x1(%rsp,%rsi,1)
   12ca2:	48 83 c6 08          	add    $0x8,%rsi
   12ca6:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
   12caa:	49 39 f1             	cmp    %rsi,%r9
   12cad:	75 d1                	jne    12c80 <fwp_fmt_duration+0x890>
   12caf:	48 85 d2             	test   %rdx,%rdx
   12cb2:	74 30                	je     12ce4 <fwp_fmt_duration+0x8f4>
   12cb4:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
   12cb9:	48 01 f2             	add    %rsi,%rdx
   12cbc:	48 ff ca             	dec    %rdx
   12cbf:	44 89 c6             	mov    %r8d,%esi
   12cc2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   12cc9:	1f 84 00 00 00 00 00 
   12cd0:	44 0f b6 02          	movzbl (%rdx),%r8d
   12cd4:	44 88 44 0c 01       	mov    %r8b,0x1(%rsp,%rcx,1)
   12cd9:	48 ff c1             	inc    %rcx
   12cdc:	48 ff ca             	dec    %rdx
   12cdf:	48 39 ce             	cmp    %rcx,%rsi
   12ce2:	75 ec                	jne    12cd0 <fwp_fmt_duration+0x8e0>
   12ce4:	c6 44 04 01 00       	movb   $0x0,0x1(%rsp,%rax,1)
   12ce9:	48 8b 0b             	mov    (%rbx),%rcx
   12cec:	48 8d 35 fa 3a 00 00 	lea    0x3afa(%rip),%rsi        # 167ed <exec_in_fp0+0xf7d>
   12cf3:	48 89 e2             	mov    %rsp,%rdx
   12cf6:	31 c0                	xor    %eax,%eax
   12cf8:	e8 53 07 ff ff       	call   3450 <sprintf@plt>
   12cfd:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
   12d04:	5b                   	pop    %rbx
   12d05:	41 5c                	pop    %r12
   12d07:	41 5e                	pop    %r14
   12d09:	41 5f                	pop    %r15
   12d0b:	c3                   	ret
   12d0c:	45 31 c9             	xor    %r9d,%r9d
   12d0f:	48 f7 de             	neg    %rsi
   12d12:	41 ba 00 00 00 00    	mov    $0x0,%r10d
   12d18:	4d 19 c2             	sbb    %r8,%r10
   12d1b:	c6 04 24 2d          	movb   $0x2d,(%rsp)
   12d1f:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
   12d26:	cc cc cc 
   12d29:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
   12d30:	cc cc cc 
   12d33:	4d 89 d6             	mov    %r10,%r14
   12d36:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   12d3d:	00 00 00 
   12d40:	4c 89 d1             	mov    %r10,%rcx
   12d43:	48 0f a4 f1 3f       	shld   $0x3f,%rsi,%rcx
   12d48:	49 d1 ee             	shr    $1,%r14
   12d4b:	49 89 c8             	mov    %rcx,%r8
   12d4e:	4d 01 f0             	add    %r14,%r8
   12d51:	49 83 d0 00          	adc    $0x0,%r8
   12d55:	4c 89 c0             	mov    %r8,%rax
   12d58:	49 f7 e3             	mul    %r11
   12d5b:	48 c1 ea 02          	shr    $0x2,%rdx
   12d5f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   12d63:	49 29 c0             	sub    %rax,%r8
   12d66:	4c 29 c1             	sub    %r8,%rcx
   12d69:	49 83 de 00          	sbb    $0x0,%r14
   12d6d:	49 89 c8             	mov    %rcx,%r8
   12d70:	4c 0f af c3          	imul   %rbx,%r8
   12d74:	48 89 c8             	mov    %rcx,%rax
   12d77:	49 f7 e3             	mul    %r11
   12d7a:	4c 01 c2             	add    %r8,%rdx
   12d7d:	4d 0f af f3          	imul   %r11,%r14
   12d81:	49 01 d6             	add    %rdx,%r14
   12d84:	48 89 c1             	mov    %rax,%rcx
   12d87:	48 01 c1             	add    %rax,%rcx
   12d8a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
   12d8e:	89 f2                	mov    %esi,%edx
   12d90:	29 ca                	sub    %ecx,%edx
   12d92:	80 ca 30             	or     $0x30,%dl
   12d95:	42 88 54 0c 40       	mov    %dl,0x40(%rsp,%r9,1)
   12d9a:	49 ff c1             	inc    %r9
   12d9d:	48 83 fe 0a          	cmp    $0xa,%rsi
   12da1:	49 83 da 00          	sbb    $0x0,%r10
   12da5:	48 89 c6             	mov    %rax,%rsi
   12da8:	4d 89 f2             	mov    %r14,%r10
   12dab:	73 93                	jae    12d40 <fwp_fmt_duration+0x950>
   12dad:	45 85 c9             	test   %r9d,%r9d
   12db0:	7e 13                	jle    12dc5 <fwp_fmt_duration+0x9d5>
   12db2:	44 89 c8             	mov    %r9d,%eax
   12db5:	48 83 f8 08          	cmp    $0x8,%rax
   12db9:	73 11                	jae    12dcc <fwp_fmt_duration+0x9dc>
   12dbb:	31 c9                	xor    %ecx,%ecx
   12dbd:	48 89 c2             	mov    %rax,%rdx
   12dc0:	e9 29 01 00 00       	jmp    12eee <fwp_fmt_duration+0xafe>
   12dc5:	31 c0                	xor    %eax,%eax
   12dc7:	e9 48 01 00 00       	jmp    12f14 <fwp_fmt_duration+0xb24>
   12dcc:	83 f8 20             	cmp    $0x20,%eax
   12dcf:	73 07                	jae    12dd8 <fwp_fmt_duration+0x9e8>
   12dd1:	31 c9                	xor    %ecx,%ecx
   12dd3:	e9 b5 00 00 00       	jmp    12e8d <fwp_fmt_duration+0xa9d>
   12dd8:	44 89 ce             	mov    %r9d,%esi
   12ddb:	44 89 ca             	mov    %r9d,%edx
   12dde:	83 e2 1f             	and    $0x1f,%edx
   12de1:	48 89 c1             	mov    %rax,%rcx
   12de4:	48 29 d1             	sub    %rdx,%rcx
   12de7:	4c 8d 04 34          	lea    (%rsp,%rsi,1),%r8
   12deb:	49 83 c0 30          	add    $0x30,%r8
   12def:	48 29 d6             	sub    %rdx,%rsi
   12df2:	45 31 d2             	xor    %r10d,%r10d
   12df5:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12df9:	f3 41 0f 6f 48 f0    	movdqu -0x10(%r8),%xmm1
   12dff:	f3 41 0f 6f 10       	movdqu (%r8),%xmm2
   12e04:	66 0f 6f da          	movdqa %xmm2,%xmm3
   12e08:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12e0c:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12e11:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   12e16:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12e1b:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   12e1f:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   12e24:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   12e29:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   12e2e:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   12e32:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   12e36:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12e3a:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12e3f:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   12e44:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12e49:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   12e4d:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   12e52:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12e57:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12e5c:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   12e60:	f3 42 0f 7f 54 14 01 	movdqu %xmm2,0x1(%rsp,%r10,1)
   12e67:	f3 42 0f 7f 4c 14 11 	movdqu %xmm1,0x11(%rsp,%r10,1)
   12e6e:	49 83 c2 20          	add    $0x20,%r10
   12e72:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
   12e76:	4c 39 d6             	cmp    %r10,%rsi
   12e79:	0f 85 7a ff ff ff    	jne    12df9 <fwp_fmt_duration+0xa09>
   12e7f:	48 85 d2             	test   %rdx,%rdx
   12e82:	0f 84 8c 00 00 00    	je     12f14 <fwp_fmt_duration+0xb24>
   12e88:	83 fa 08             	cmp    $0x8,%edx
   12e8b:	72 61                	jb     12eee <fwp_fmt_duration+0xafe>
   12e8d:	48 89 ce             	mov    %rcx,%rsi
   12e90:	45 89 c8             	mov    %r9d,%r8d
   12e93:	44 89 ca             	mov    %r9d,%edx
   12e96:	83 e2 07             	and    $0x7,%edx
   12e99:	48 89 c1             	mov    %rax,%rcx
   12e9c:	48 29 d1             	sub    %rdx,%rcx
   12e9f:	49 89 f2             	mov    %rsi,%r10
   12ea2:	49 f7 da             	neg    %r10
   12ea5:	49 01 e2             	add    %rsp,%r10
   12ea8:	49 83 c2 40          	add    $0x40,%r10
   12eac:	4d 01 c2             	add    %r8,%r10
   12eaf:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
   12eb3:	49 29 d0             	sub    %rdx,%r8
   12eb6:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12eba:	f3 41 0f 7e 0a       	movq   (%r10),%xmm1
   12ebf:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   12ec3:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   12ec8:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12ecd:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12ed2:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   12ed6:	66 0f d6 4c 34 01    	movq   %xmm1,0x1(%rsp,%rsi,1)
   12edc:	48 83 c6 08          	add    $0x8,%rsi
   12ee0:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
   12ee4:	49 39 f0             	cmp    %rsi,%r8
   12ee7:	75 d1                	jne    12eba <fwp_fmt_duration+0xaca>
   12ee9:	48 85 d2             	test   %rdx,%rdx
   12eec:	74 26                	je     12f14 <fwp_fmt_duration+0xb24>
   12eee:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
   12ef3:	48 01 f2             	add    %rsi,%rdx
   12ef6:	48 ff ca             	dec    %rdx
   12ef9:	44 89 ce             	mov    %r9d,%esi
   12efc:	0f 1f 40 00          	nopl   0x0(%rax)
   12f00:	44 0f b6 02          	movzbl (%rdx),%r8d
   12f04:	44 88 44 0c 01       	mov    %r8b,0x1(%rsp,%rcx,1)
   12f09:	48 ff c1             	inc    %rcx
   12f0c:	48 ff ca             	dec    %rdx
   12f0f:	48 39 ce             	cmp    %rcx,%rsi
   12f12:	75 ec                	jne    12f00 <fwp_fmt_duration+0xb10>
   12f14:	c6 44 04 01 00       	movb   $0x0,0x1(%rsp,%rax,1)
   12f19:	e9 28 f9 ff ff       	jmp    12846 <fwp_fmt_duration+0x456>
   12f1e:	66 90                	xchg   %ax,%ax

0000000000012f20 <fwp_format_g>:
   12f20:	55                   	push   %rbp
   12f21:	41 57                	push   %r15
   12f23:	41 56                	push   %r14
   12f25:	41 55                	push   %r13
   12f27:	41 54                	push   %r12
   12f29:	53                   	push   %rbx
   12f2a:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   12f31:	89 f5                	mov    %esi,%ebp
   12f33:	48 89 fb             	mov    %rdi,%rbx
   12f36:	ff cd                	dec    %ebp
   12f38:	48 8d 15 81 38 00 00 	lea    0x3881(%rip),%rdx        # 167c0 <exec_in_fp0+0xf50>
   12f3f:	4c 8d 64 24 50       	lea    0x50(%rsp),%r12
   12f44:	be 40 00 00 00       	mov    $0x40,%esi
   12f49:	4c 89 e7             	mov    %r12,%rdi
   12f4c:	89 e9                	mov    %ebp,%ecx
   12f4e:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
   12f54:	b0 01                	mov    $0x1,%al
   12f56:	e8 75 02 ff ff       	call   31d0 <snprintf@plt>
   12f5b:	4c 89 e7             	mov    %r12,%rdi
   12f5e:	be 65 00 00 00       	mov    $0x65,%esi
   12f63:	e8 48 02 ff ff       	call   31b0 <strchr@plt>
   12f68:	49 89 c7             	mov    %rax,%r15
   12f6b:	48 8d 78 01          	lea    0x1(%rax),%rdi
   12f6f:	45 31 ed             	xor    %r13d,%r13d
   12f72:	31 f6                	xor    %esi,%esi
   12f74:	ba 0a 00 00 00       	mov    $0xa,%edx
   12f79:	e8 a2 03 ff ff       	call   3320 <strtol@plt>
   12f7e:	49 89 c6             	mov    %rax,%r14
   12f81:	83 c0 ef             	add    $0xffffffef,%eax
   12f84:	83 f8 e9             	cmp    $0xffffffe9,%eax
   12f87:	77 5f                	ja     12fe8 <fwp_format_g+0xc8>
   12f89:	4d 29 e7             	sub    %r12,%r15
   12f8c:	4c 8d 6c 24 10       	lea    0x10(%rsp),%r13
   12f91:	4c 89 ef             	mov    %r13,%rdi
   12f94:	4c 89 e6             	mov    %r12,%rsi
   12f97:	4c 89 fa             	mov    %r15,%rdx
   12f9a:	e8 91 03 ff ff       	call   3330 <memcpy@plt>
   12f9f:	42 c6 44 3c 10 00    	movb   $0x0,0x10(%rsp,%r15,1)
   12fa5:	4c 89 ef             	mov    %r13,%rdi
   12fa8:	be 2e 00 00 00       	mov    $0x2e,%esi
   12fad:	e8 fe 01 ff ff       	call   31b0 <strchr@plt>
   12fb2:	48 85 c0             	test   %rax,%rax
   12fb5:	0f 84 a8 00 00 00    	je     13063 <fwp_format_g+0x143>
   12fbb:	4d 85 ff             	test   %r15,%r15
   12fbe:	0f 84 9f 00 00 00    	je     13063 <fwp_format_g+0x143>
   12fc4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
   12fcb:	00 00 00 00 00 
   12fd0:	42 0f b6 44 3c 0f    	movzbl 0xf(%rsp,%r15,1),%eax
   12fd6:	83 f8 30             	cmp    $0x30,%eax
   12fd9:	75 7d                	jne    13058 <fwp_format_g+0x138>
   12fdb:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
   12fe1:	49 ff cf             	dec    %r15
   12fe4:	75 ea                	jne    12fd0 <fwp_format_g+0xb0>
   12fe6:	eb 7b                	jmp    13063 <fwp_format_g+0x143>
   12fe8:	44 29 f5             	sub    %r14d,%ebp
   12feb:	85 ed                	test   %ebp,%ebp
   12fed:	44 0f 4f ed          	cmovg  %ebp,%r13d
   12ff1:	48 8d 15 d7 37 00 00 	lea    0x37d7(%rip),%rdx        # 167cf <exec_in_fp0+0xf5f>
   12ff8:	be 90 01 00 00       	mov    $0x190,%esi
   12ffd:	48 89 df             	mov    %rbx,%rdi
   13000:	44 89 e9             	mov    %r13d,%ecx
   13003:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
   13009:	b0 01                	mov    $0x1,%al
   1300b:	e8 c0 01 ff ff       	call   31d0 <snprintf@plt>
   13010:	48 89 df             	mov    %rbx,%rdi
   13013:	e8 58 01 ff ff       	call   3170 <strlen@plt>
   13018:	49 89 c6             	mov    %rax,%r14
   1301b:	48 89 df             	mov    %rbx,%rdi
   1301e:	be 2e 00 00 00       	mov    $0x2e,%esi
   13023:	e8 88 01 ff ff       	call   31b0 <strchr@plt>
   13028:	48 85 c0             	test   %rax,%rax
   1302b:	74 69                	je     13096 <fwp_format_g+0x176>
   1302d:	4d 85 f6             	test   %r14,%r14
   13030:	74 64                	je     13096 <fwp_format_g+0x176>
   13032:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   13039:	1f 84 00 00 00 00 00 
   13040:	42 0f b6 44 33 ff    	movzbl -0x1(%rbx,%r14,1),%eax
   13046:	83 f8 30             	cmp    $0x30,%eax
   13049:	75 5d                	jne    130a8 <fwp_format_g+0x188>
   1304b:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
   13051:	49 ff ce             	dec    %r14
   13054:	75 ea                	jne    13040 <fwp_format_g+0x120>
   13056:	eb 3e                	jmp    13096 <fwp_format_g+0x176>
   13058:	83 f8 2e             	cmp    $0x2e,%eax
   1305b:	75 06                	jne    13063 <fwp_format_g+0x143>
   1305d:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
   13063:	44 89 f0             	mov    %r14d,%eax
   13066:	c1 e8 1f             	shr    $0x1f,%eax
   13069:	44 8d 04 45 2b 00 00 	lea    0x2b(,%rax,2),%r8d
   13070:	00 
   13071:	45 89 f1             	mov    %r14d,%r9d
   13074:	41 f7 d9             	neg    %r9d
   13077:	45 0f 48 ce          	cmovs  %r14d,%r9d
   1307b:	48 8d 15 43 37 00 00 	lea    0x3743(%rip),%rdx        # 167c5 <exec_in_fp0+0xf55>
   13082:	48 8d 4c 24 10       	lea    0x10(%rsp),%rcx
   13087:	be 90 01 00 00       	mov    $0x190,%esi
   1308c:	48 89 df             	mov    %rbx,%rdi
   1308f:	31 c0                	xor    %eax,%eax
   13091:	e8 3a 01 ff ff       	call   31d0 <snprintf@plt>
   13096:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
   1309d:	5b                   	pop    %rbx
   1309e:	41 5c                	pop    %r12
   130a0:	41 5d                	pop    %r13
   130a2:	41 5e                	pop    %r14
   130a4:	41 5f                	pop    %r15
   130a6:	5d                   	pop    %rbp
   130a7:	c3                   	ret
   130a8:	83 f8 2e             	cmp    $0x2e,%eax
   130ab:	75 e9                	jne    13096 <fwp_format_g+0x176>
   130ad:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
   130b3:	eb e1                	jmp    13096 <fwp_format_g+0x176>
   130b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   130bc:	00 00 00 00 

00000000000130c0 <fwp_encode>:
   130c0:	55                   	push   %rbp
   130c1:	41 57                	push   %r15
   130c3:	41 56                	push   %r14
   130c5:	41 55                	push   %r13
   130c7:	41 54                	push   %r12
   130c9:	53                   	push   %rbx
   130ca:	48 83 ec 28          	sub    $0x28,%rsp
   130ce:	8b 02                	mov    (%rdx),%eax
   130d0:	48 83 f8 15          	cmp    $0x15,%rax
   130d4:	0f 87 91 01 00 00    	ja     1326b <fwp_encode+0x1ab>
   130da:	49 89 d6             	mov    %rdx,%r14
   130dd:	48 89 f3             	mov    %rsi,%rbx
   130e0:	48 89 7c 24 08       	mov    %rdi,0x8(%rsp)
   130e5:	48 8d 0d 20 25 00 00 	lea    0x2520(%rip),%rcx        # 1560c <_IO_stdin_used+0x60c>
   130ec:	48 63 04 81          	movslq (%rcx,%rax,4),%rax
   130f0:	48 01 c8             	add    %rcx,%rax
   130f3:	ff e0                	jmp    *%rax
   130f5:	88 5c 24 07          	mov    %bl,0x7(%rsp)
   130f9:	4c 8d 74 24 07       	lea    0x7(%rsp),%r14
   130fe:	ba 01 00 00 00       	mov    $0x1,%edx
   13103:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
   13108:	4c 89 ff             	mov    %r15,%rdi
   1310b:	4c 89 f6             	mov    %r14,%rsi
   1310e:	e8 7d a1 ff ff       	call   d290 <buf_put>
   13113:	88 7c 24 07          	mov    %bh,0x7(%rsp)
   13117:	ba 01 00 00 00       	mov    $0x1,%edx
   1311c:	4c 89 ff             	mov    %r15,%rdi
   1311f:	4c 89 f6             	mov    %r14,%rsi
   13122:	e8 69 a1 ff ff       	call   d290 <buf_put>
   13127:	89 d8                	mov    %ebx,%eax
   13129:	c1 e8 10             	shr    $0x10,%eax
   1312c:	88 44 24 07          	mov    %al,0x7(%rsp)
   13130:	ba 01 00 00 00       	mov    $0x1,%edx
   13135:	4c 89 ff             	mov    %r15,%rdi
   13138:	4c 89 f6             	mov    %r14,%rsi
   1313b:	e8 50 a1 ff ff       	call   d290 <buf_put>
   13140:	89 d8                	mov    %ebx,%eax
   13142:	c1 e8 18             	shr    $0x18,%eax
   13145:	88 44 24 07          	mov    %al,0x7(%rsp)
   13149:	ba 01 00 00 00       	mov    $0x1,%edx
   1314e:	4c 89 ff             	mov    %r15,%rdi
   13151:	4c 89 f6             	mov    %r14,%rsi
   13154:	e8 37 a1 ff ff       	call   d290 <buf_put>
   13159:	48 89 d8             	mov    %rbx,%rax
   1315c:	48 c1 e8 20          	shr    $0x20,%rax
   13160:	88 44 24 07          	mov    %al,0x7(%rsp)
   13164:	ba 01 00 00 00       	mov    $0x1,%edx
   13169:	4c 89 ff             	mov    %r15,%rdi
   1316c:	4c 89 f6             	mov    %r14,%rsi
   1316f:	e8 1c a1 ff ff       	call   d290 <buf_put>
   13174:	48 89 d8             	mov    %rbx,%rax
   13177:	48 c1 e8 28          	shr    $0x28,%rax
   1317b:	88 44 24 07          	mov    %al,0x7(%rsp)
   1317f:	ba 01 00 00 00       	mov    $0x1,%edx
   13184:	4c 89 ff             	mov    %r15,%rdi
   13187:	4c 89 f6             	mov    %r14,%rsi
   1318a:	e8 01 a1 ff ff       	call   d290 <buf_put>
   1318f:	48 89 d8             	mov    %rbx,%rax
   13192:	48 c1 e8 30          	shr    $0x30,%rax
   13196:	88 44 24 07          	mov    %al,0x7(%rsp)
   1319a:	ba 01 00 00 00       	mov    $0x1,%edx
   1319f:	4c 89 ff             	mov    %r15,%rdi
   131a2:	4c 89 f6             	mov    %r14,%rsi
   131a5:	e8 e6 a0 ff ff       	call   d290 <buf_put>
   131aa:	48 c1 eb 38          	shr    $0x38,%rbx
   131ae:	eb 66                	jmp    13216 <fwp_encode+0x156>
   131b0:	88 5c 24 07          	mov    %bl,0x7(%rsp)
   131b4:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
   131b9:	ba 01 00 00 00       	mov    $0x1,%edx
   131be:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
   131c3:	e9 9e 00 00 00       	jmp    13266 <fwp_encode+0x1a6>
   131c8:	88 5c 24 07          	mov    %bl,0x7(%rsp)
   131cc:	4c 8d 74 24 07       	lea    0x7(%rsp),%r14
   131d1:	ba 01 00 00 00       	mov    $0x1,%edx
   131d6:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
   131db:	4c 89 ff             	mov    %r15,%rdi
   131de:	4c 89 f6             	mov    %r14,%rsi
   131e1:	e8 aa a0 ff ff       	call   d290 <buf_put>
   131e6:	88 7c 24 07          	mov    %bh,0x7(%rsp)
   131ea:	ba 01 00 00 00       	mov    $0x1,%edx
   131ef:	4c 89 ff             	mov    %r15,%rdi
   131f2:	4c 89 f6             	mov    %r14,%rsi
   131f5:	e8 96 a0 ff ff       	call   d290 <buf_put>
   131fa:	89 d8                	mov    %ebx,%eax
   131fc:	c1 e8 10             	shr    $0x10,%eax
   131ff:	88 44 24 07          	mov    %al,0x7(%rsp)
   13203:	ba 01 00 00 00       	mov    $0x1,%edx
   13208:	4c 89 ff             	mov    %r15,%rdi
   1320b:	4c 89 f6             	mov    %r14,%rsi
   1320e:	e8 7d a0 ff ff       	call   d290 <buf_put>
   13213:	c1 eb 18             	shr    $0x18,%ebx
   13216:	88 5c 24 07          	mov    %bl,0x7(%rsp)
   1321a:	eb 3f                	jmp    1325b <fwp_encode+0x19b>
   1321c:	4c 8b 3b             	mov    (%rbx),%r15
   1321f:	49 81 ff 80 00 00 00 	cmp    $0x80,%r15
   13226:	0f 83 4a 02 00 00    	jae    13476 <fwp_encode+0x3b6>
   1322c:	4d 89 fd             	mov    %r15,%r13
   1322f:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   13234:	e9 80 02 00 00       	jmp    134b9 <fwp_encode+0x3f9>
   13239:	88 5c 24 07          	mov    %bl,0x7(%rsp)
   1323d:	4c 8d 74 24 07       	lea    0x7(%rsp),%r14
   13242:	ba 01 00 00 00       	mov    $0x1,%edx
   13247:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
   1324c:	4c 89 ff             	mov    %r15,%rdi
   1324f:	4c 89 f6             	mov    %r14,%rsi
   13252:	e8 39 a0 ff ff       	call   d290 <buf_put>
   13257:	88 7c 24 07          	mov    %bh,0x7(%rsp)
   1325b:	ba 01 00 00 00       	mov    $0x1,%edx
   13260:	4c 89 ff             	mov    %r15,%rdi
   13263:	4c 89 f6             	mov    %r14,%rsi
   13266:	e8 25 a0 ff ff       	call   d290 <buf_put>
   1326b:	48 83 c4 28          	add    $0x28,%rsp
   1326f:	5b                   	pop    %rbx
   13270:	41 5c                	pop    %r12
   13272:	41 5d                	pop    %r13
   13274:	41 5e                	pop    %r14
   13276:	41 5f                	pop    %r15
   13278:	5d                   	pop    %rbp
   13279:	c3                   	ret
   1327a:	48 8b 03             	mov    (%rbx),%rax
   1327d:	4c 8b 6b 08          	mov    0x8(%rbx),%r13
   13281:	88 44 24 07          	mov    %al,0x7(%rsp)
   13285:	48 89 c3             	mov    %rax,%rbx
   13288:	4c 8d 74 24 07       	lea    0x7(%rsp),%r14
   1328d:	ba 01 00 00 00       	mov    $0x1,%edx
   13292:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   13297:	4c 89 e7             	mov    %r12,%rdi
   1329a:	4c 89 f6             	mov    %r14,%rsi
   1329d:	e8 ee 9f ff ff       	call   d290 <buf_put>
   132a2:	88 7c 24 07          	mov    %bh,0x7(%rsp)
   132a6:	ba 01 00 00 00       	mov    $0x1,%edx
   132ab:	4c 89 e7             	mov    %r12,%rdi
   132ae:	4c 89 f6             	mov    %r14,%rsi
   132b1:	e8 da 9f ff ff       	call   d290 <buf_put>
   132b6:	44 89 e8             	mov    %r13d,%eax
   132b9:	c1 e8 10             	shr    $0x10,%eax
   132bc:	89 44 24 14          	mov    %eax,0x14(%rsp)
   132c0:	89 d8                	mov    %ebx,%eax
   132c2:	c1 e8 10             	shr    $0x10,%eax
   132c5:	88 44 24 07          	mov    %al,0x7(%rsp)
   132c9:	ba 01 00 00 00       	mov    $0x1,%edx
   132ce:	4c 89 e7             	mov    %r12,%rdi
   132d1:	4c 89 f6             	mov    %r14,%rsi
   132d4:	e8 b7 9f ff ff       	call   d290 <buf_put>
   132d9:	44 89 e8             	mov    %r13d,%eax
   132dc:	c1 e8 18             	shr    $0x18,%eax
   132df:	89 44 24 10          	mov    %eax,0x10(%rsp)
   132e3:	89 d8                	mov    %ebx,%eax
   132e5:	c1 e8 18             	shr    $0x18,%eax
   132e8:	88 44 24 07          	mov    %al,0x7(%rsp)
   132ec:	ba 01 00 00 00       	mov    $0x1,%edx
   132f1:	4c 89 e7             	mov    %r12,%rdi
   132f4:	4c 89 f6             	mov    %r14,%rsi
   132f7:	e8 94 9f ff ff       	call   d290 <buf_put>
   132fc:	4c 89 e8             	mov    %r13,%rax
   132ff:	48 c1 e8 20          	shr    $0x20,%rax
   13303:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   13308:	48 89 d8             	mov    %rbx,%rax
   1330b:	48 c1 e8 20          	shr    $0x20,%rax
   1330f:	88 44 24 07          	mov    %al,0x7(%rsp)
   13313:	ba 01 00 00 00       	mov    $0x1,%edx
   13318:	4c 89 e7             	mov    %r12,%rdi
   1331b:	4c 89 f6             	mov    %r14,%rsi
   1331e:	e8 6d 9f ff ff       	call   d290 <buf_put>
   13323:	4c 89 e8             	mov    %r13,%rax
   13326:	48 c1 e8 28          	shr    $0x28,%rax
   1332a:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
   1332f:	48 89 d8             	mov    %rbx,%rax
   13332:	48 c1 e8 28          	shr    $0x28,%rax
   13336:	88 44 24 07          	mov    %al,0x7(%rsp)
   1333a:	ba 01 00 00 00       	mov    $0x1,%edx
   1333f:	4c 89 e7             	mov    %r12,%rdi
   13342:	4c 89 f6             	mov    %r14,%rsi
   13345:	e8 46 9f ff ff       	call   d290 <buf_put>
   1334a:	4d 89 ef             	mov    %r13,%r15
   1334d:	49 c1 ef 30          	shr    $0x30,%r15
   13351:	48 89 d8             	mov    %rbx,%rax
   13354:	48 c1 e8 30          	shr    $0x30,%rax
   13358:	88 44 24 07          	mov    %al,0x7(%rsp)
   1335c:	ba 01 00 00 00       	mov    $0x1,%edx
   13361:	4c 89 e7             	mov    %r12,%rdi
   13364:	4c 89 f6             	mov    %r14,%rsi
   13367:	e8 24 9f ff ff       	call   d290 <buf_put>
   1336c:	4c 89 ed             	mov    %r13,%rbp
   1336f:	48 c1 ed 38          	shr    $0x38,%rbp
   13373:	48 c1 eb 38          	shr    $0x38,%rbx
   13377:	88 5c 24 07          	mov    %bl,0x7(%rsp)
   1337b:	ba 01 00 00 00       	mov    $0x1,%edx
   13380:	4c 89 e7             	mov    %r12,%rdi
   13383:	4c 89 f6             	mov    %r14,%rsi
   13386:	e8 05 9f ff ff       	call   d290 <buf_put>
   1338b:	44 88 6c 24 07       	mov    %r13b,0x7(%rsp)
   13390:	4c 89 eb             	mov    %r13,%rbx
   13393:	4c 8d 74 24 07       	lea    0x7(%rsp),%r14
   13398:	ba 01 00 00 00       	mov    $0x1,%edx
   1339d:	4c 89 e7             	mov    %r12,%rdi
   133a0:	4c 89 f6             	mov    %r14,%rsi
   133a3:	e8 e8 9e ff ff       	call   d290 <buf_put>
   133a8:	88 7c 24 07          	mov    %bh,0x7(%rsp)
   133ac:	ba 01 00 00 00       	mov    $0x1,%edx
   133b1:	4c 89 e7             	mov    %r12,%rdi
   133b4:	4c 89 f6             	mov    %r14,%rsi
   133b7:	e8 d4 9e ff ff       	call   d290 <buf_put>
   133bc:	8b 44 24 14          	mov    0x14(%rsp),%eax
   133c0:	88 44 24 07          	mov    %al,0x7(%rsp)
   133c4:	ba 01 00 00 00       	mov    $0x1,%edx
   133c9:	4c 89 e7             	mov    %r12,%rdi
   133cc:	4c 89 f6             	mov    %r14,%rsi
   133cf:	e8 bc 9e ff ff       	call   d290 <buf_put>
   133d4:	8b 44 24 10          	mov    0x10(%rsp),%eax
   133d8:	88 44 24 07          	mov    %al,0x7(%rsp)
   133dc:	ba 01 00 00 00       	mov    $0x1,%edx
   133e1:	4c 89 e7             	mov    %r12,%rdi
   133e4:	4c 89 f6             	mov    %r14,%rsi
   133e7:	e8 a4 9e ff ff       	call   d290 <buf_put>
   133ec:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
   133f1:	88 44 24 07          	mov    %al,0x7(%rsp)
   133f5:	ba 01 00 00 00       	mov    $0x1,%edx
   133fa:	4c 89 e7             	mov    %r12,%rdi
   133fd:	4c 89 f6             	mov    %r14,%rsi
   13400:	e8 8b 9e ff ff       	call   d290 <buf_put>
   13405:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
   1340a:	88 44 24 07          	mov    %al,0x7(%rsp)
   1340e:	ba 01 00 00 00       	mov    $0x1,%edx
   13413:	4c 89 e7             	mov    %r12,%rdi
   13416:	4c 89 f6             	mov    %r14,%rsi
   13419:	e8 72 9e ff ff       	call   d290 <buf_put>
   1341e:	44 88 7c 24 07       	mov    %r15b,0x7(%rsp)
   13423:	ba 01 00 00 00       	mov    $0x1,%edx
   13428:	4c 89 e7             	mov    %r12,%rdi
   1342b:	4c 89 f6             	mov    %r14,%rsi
   1342e:	e8 5d 9e ff ff       	call   d290 <buf_put>
   13433:	40 88 6c 24 07       	mov    %bpl,0x7(%rsp)
   13438:	ba 01 00 00 00       	mov    $0x1,%edx
   1343d:	4c 89 e7             	mov    %r12,%rdi
   13440:	e9 1e fe ff ff       	jmp    13263 <fwp_encode+0x1a3>
   13445:	4c 8b 2b             	mov    (%rbx),%r13
   13448:	49 81 fd 80 00 00 00 	cmp    $0x80,%r13
   1344f:	0f 83 dc 00 00 00    	jae    13531 <fwp_encode+0x471>
   13455:	4c 89 ed             	mov    %r13,%rbp
   13458:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   1345d:	e9 07 01 00 00       	jmp    13569 <fwp_encode+0x4a9>
   13462:	48 81 fb ff 0f 00 00 	cmp    $0xfff,%rbx
   13469:	0f 87 d1 01 00 00    	ja     13640 <fwp_encode+0x580>
   1346f:	89 d8                	mov    %ebx,%eax
   13471:	e9 cc 01 00 00       	jmp    13642 <fwp_encode+0x582>
   13476:	4c 8d 74 24 07       	lea    0x7(%rsp),%r14
   1347b:	4d 89 fd             	mov    %r15,%r13
   1347e:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   13483:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   1348a:	84 00 00 00 00 00 
   13490:	49 c1 ed 07          	shr    $0x7,%r13
   13494:	44 89 f8             	mov    %r15d,%eax
   13497:	0c 80                	or     $0x80,%al
   13499:	88 44 24 07          	mov    %al,0x7(%rsp)
   1349d:	ba 01 00 00 00       	mov    $0x1,%edx
   134a2:	4c 89 e7             	mov    %r12,%rdi
   134a5:	4c 89 f6             	mov    %r14,%rsi
   134a8:	e8 e3 9d ff ff       	call   d290 <buf_put>
   134ad:	49 81 ff ff 3f 00 00 	cmp    $0x3fff,%r15
   134b4:	4d 89 ef             	mov    %r13,%r15
   134b7:	77 d7                	ja     13490 <fwp_encode+0x3d0>
   134b9:	44 88 6c 24 07       	mov    %r13b,0x7(%rsp)
   134be:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
   134c3:	ba 01 00 00 00       	mov    $0x1,%edx
   134c8:	4c 89 e7             	mov    %r12,%rdi
   134cb:	e8 c0 9d ff ff       	call   d290 <buf_put>
   134d0:	48 8b 13             	mov    (%rbx),%rdx
   134d3:	48 83 c3 08          	add    $0x8,%rbx
   134d7:	4c 89 e7             	mov    %r12,%rdi
   134da:	48 89 de             	mov    %rbx,%rsi
   134dd:	48 83 c4 28          	add    $0x28,%rsp
   134e1:	5b                   	pop    %rbx
   134e2:	41 5c                	pop    %r12
   134e4:	41 5d                	pop    %r13
   134e6:	41 5e                	pop    %r14
   134e8:	41 5f                	pop    %r15
   134ea:	5d                   	pop    %rbp
   134eb:	e9 a0 9d ff ff       	jmp    d290 <buf_put>
   134f0:	48 85 db             	test   %rbx,%rbx
   134f3:	0f 84 15 03 00 00    	je     1380e <fwp_encode+0x74e>
   134f9:	45 31 ed             	xor    %r13d,%r13d
   134fc:	48 89 d8             	mov    %rbx,%rax
   134ff:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   13504:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
   1350b:	00 00 00 00 00 
   13510:	49 ff c5             	inc    %r13
   13513:	48 8b 40 10          	mov    0x10(%rax),%rax
   13517:	48 85 c0             	test   %rax,%rax
   1351a:	75 f4                	jne    13510 <fwp_encode+0x450>
   1351c:	49 81 fd 80 00 00 00 	cmp    $0x80,%r13
   13523:	0f 83 ef 02 00 00    	jae    13818 <fwp_encode+0x758>
   13529:	4c 89 ed             	mov    %r13,%rbp
   1352c:	e9 18 03 00 00       	jmp    13849 <fwp_encode+0x789>
   13531:	4c 8d 7c 24 07       	lea    0x7(%rsp),%r15
   13536:	4c 89 ed             	mov    %r13,%rbp
   13539:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   1353e:	66 90                	xchg   %ax,%ax
   13540:	48 c1 ed 07          	shr    $0x7,%rbp
   13544:	44 89 e8             	mov    %r13d,%eax
   13547:	0c 80                	or     $0x80,%al
   13549:	88 44 24 07          	mov    %al,0x7(%rsp)
   1354d:	ba 01 00 00 00       	mov    $0x1,%edx
   13552:	4c 89 e7             	mov    %r12,%rdi
   13555:	4c 89 fe             	mov    %r15,%rsi
   13558:	e8 33 9d ff ff       	call   d290 <buf_put>
   1355d:	49 81 fd ff 3f 00 00 	cmp    $0x3fff,%r13
   13564:	49 89 ed             	mov    %rbp,%r13
   13567:	77 d7                	ja     13540 <fwp_encode+0x480>
   13569:	40 88 6c 24 07       	mov    %bpl,0x7(%rsp)
   1356e:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
   13573:	ba 01 00 00 00       	mov    $0x1,%edx
   13578:	4c 89 e7             	mov    %r12,%rdi
   1357b:	e8 10 9d ff ff       	call   d290 <buf_put>
   13580:	48 83 3b 00          	cmpq   $0x0,(%rbx)
   13584:	0f 84 e1 fc ff ff    	je     1326b <fwp_encode+0x1ab>
   1358a:	4c 8d 7b 10          	lea    0x10(%rbx),%r15
   1358e:	45 31 ed             	xor    %r13d,%r13d
   13591:	eb 1d                	jmp    135b0 <fwp_encode+0x4f0>
   13593:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   1359a:	84 00 00 00 00 00 
   135a0:	49 ff c5             	inc    %r13
   135a3:	49 83 c7 10          	add    $0x10,%r15
   135a7:	4c 3b 2b             	cmp    (%rbx),%r13
   135aa:	0f 83 bb fc ff ff    	jae    1326b <fwp_encode+0x1ab>
   135b0:	49 8b 77 f8          	mov    -0x8(%r15),%rsi
   135b4:	49 8b 56 38          	mov    0x38(%r14),%rdx
   135b8:	4c 89 e7             	mov    %r12,%rdi
   135bb:	e8 00 fb ff ff       	call   130c0 <fwp_encode>
   135c0:	41 83 3e 12          	cmpl   $0x12,(%r14)
   135c4:	75 da                	jne    135a0 <fwp_encode+0x4e0>
   135c6:	49 8b 37             	mov    (%r15),%rsi
   135c9:	49 8b 56 40          	mov    0x40(%r14),%rdx
   135cd:	4c 89 e7             	mov    %r12,%rdi
   135d0:	e8 eb fa ff ff       	call   130c0 <fwp_encode>
   135d5:	eb c9                	jmp    135a0 <fwp_encode+0x4e0>
   135d7:	41 83 7e 10 00       	cmpl   $0x0,0x10(%r14)
   135dc:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   135e1:	0f 8e 84 fc ff ff    	jle    1326b <fwp_encode+0x1ab>
   135e7:	45 31 ff             	xor    %r15d,%r15d
   135ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   135f0:	4a 8b 74 fb 08       	mov    0x8(%rbx,%r15,8),%rsi
   135f5:	49 8b 46 20          	mov    0x20(%r14),%rax
   135f9:	4a 8b 14 f8          	mov    (%rax,%r15,8),%rdx
   135fd:	4c 89 e7             	mov    %r12,%rdi
   13600:	e8 bb fa ff ff       	call   130c0 <fwp_encode>
   13605:	49 ff c7             	inc    %r15
   13608:	49 63 46 10          	movslq 0x10(%r14),%rax
   1360c:	49 39 c7             	cmp    %rax,%r15
   1360f:	7c df                	jl     135f0 <fwp_encode+0x530>
   13611:	e9 55 fc ff ff       	jmp    1326b <fwp_encode+0x1ab>
   13616:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
   1361d:	ff ff 7f 
   13620:	4c 8b 2b             	mov    (%rbx),%r13
   13623:	49 21 c5             	and    %rax,%r13
   13626:	49 81 fd 80 00 00 00 	cmp    $0x80,%r13
   1362d:	0f 83 bb 00 00 00    	jae    136ee <fwp_encode+0x62e>
   13633:	4c 89 ed             	mov    %r13,%rbp
   13636:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   1363b:	e9 e9 00 00 00       	jmp    13729 <fwp_encode+0x669>
   13640:	8b 03                	mov    (%rbx),%eax
   13642:	41 89 c4             	mov    %eax,%r12d
   13645:	4c 89 e5             	mov    %r12,%rbp
   13648:	3d 80 00 00 00       	cmp    $0x80,%eax
   1364d:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
   13652:	72 37                	jb     1368b <fwp_encode+0x5cb>
   13654:	4d 89 e5             	mov    %r12,%r13
   13657:	4c 89 e5             	mov    %r12,%rbp
   1365a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   13660:	48 c1 ed 07          	shr    $0x7,%rbp
   13664:	44 89 e8             	mov    %r13d,%eax
   13667:	0c 80                	or     $0x80,%al
   13669:	88 44 24 07          	mov    %al,0x7(%rsp)
   1366d:	ba 01 00 00 00       	mov    $0x1,%edx
   13672:	4c 89 ff             	mov    %r15,%rdi
   13675:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
   1367a:	e8 11 9c ff ff       	call   d290 <buf_put>
   1367f:	49 81 fd ff 3f 00 00 	cmp    $0x3fff,%r13
   13686:	49 89 ed             	mov    %rbp,%r13
   13689:	77 d5                	ja     13660 <fwp_encode+0x5a0>
   1368b:	40 88 6c 24 07       	mov    %bpl,0x7(%rsp)
   13690:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
   13695:	ba 01 00 00 00       	mov    $0x1,%edx
   1369a:	4c 89 ff             	mov    %r15,%rdi
   1369d:	e8 ee 9b ff ff       	call   d290 <buf_put>
   136a2:	49 8b 46 28          	mov    0x28(%r14),%rax
   136a6:	42 83 3c a0 00       	cmpl   $0x0,(%rax,%r12,4)
   136ab:	0f 8e ba fb ff ff    	jle    1326b <fwp_encode+0x1ab>
   136b1:	4d 89 fd             	mov    %r15,%r13
   136b4:	45 31 ff             	xor    %r15d,%r15d
   136b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   136be:	00 00 
   136c0:	4a 8b 74 fb 08       	mov    0x8(%rbx,%r15,8),%rsi
   136c5:	49 8b 46 30          	mov    0x30(%r14),%rax
   136c9:	4a 8b 04 e0          	mov    (%rax,%r12,8),%rax
   136cd:	4a 8b 14 f8          	mov    (%rax,%r15,8),%rdx
   136d1:	4c 89 ef             	mov    %r13,%rdi
   136d4:	e8 e7 f9 ff ff       	call   130c0 <fwp_encode>
   136d9:	49 ff c7             	inc    %r15
   136dc:	49 8b 46 28          	mov    0x28(%r14),%rax
   136e0:	4a 63 04 a0          	movslq (%rax,%r12,4),%rax
   136e4:	49 39 c7             	cmp    %rax,%r15
   136e7:	7c d7                	jl     136c0 <fwp_encode+0x600>
   136e9:	e9 7d fb ff ff       	jmp    1326b <fwp_encode+0x1ab>
   136ee:	4c 8d 7c 24 07       	lea    0x7(%rsp),%r15
   136f3:	4c 89 ed             	mov    %r13,%rbp
   136f6:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   136fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   13700:	48 c1 ed 07          	shr    $0x7,%rbp
   13704:	44 89 e8             	mov    %r13d,%eax
   13707:	0c 80                	or     $0x80,%al
   13709:	88 44 24 07          	mov    %al,0x7(%rsp)
   1370d:	ba 01 00 00 00       	mov    $0x1,%edx
   13712:	4c 89 e7             	mov    %r12,%rdi
   13715:	4c 89 fe             	mov    %r15,%rsi
   13718:	e8 73 9b ff ff       	call   d290 <buf_put>
   1371d:	49 81 fd ff 3f 00 00 	cmp    $0x3fff,%r13
   13724:	49 89 ed             	mov    %rbp,%r13
   13727:	77 d7                	ja     13700 <fwp_encode+0x640>
   13729:	40 88 6c 24 07       	mov    %bpl,0x7(%rsp)
   1372e:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
   13733:	ba 01 00 00 00       	mov    $0x1,%edx
   13738:	4c 89 e7             	mov    %r12,%rdi
   1373b:	e8 50 9b ff ff       	call   d290 <buf_put>
   13740:	48 8b 03             	mov    (%rbx),%rax
   13743:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
   1374a:	ff ff 7f 
   1374d:	4c 85 e0             	test   %r12,%rax
   13750:	0f 84 15 fb ff ff    	je     1326b <fwp_encode+0x1ab>
   13756:	4c 8d 7b 08          	lea    0x8(%rbx),%r15
   1375a:	31 ed                	xor    %ebp,%ebp
   1375c:	4c 8d 2d 8d 21 00 00 	lea    0x218d(%rip),%r13        # 158f0 <exec_in_fp0+0x80>
   13763:	eb 34                	jmp    13799 <fwp_encode+0x6d9>
   13765:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   1376c:	00 00 00 00 
   13770:	83 3a 01             	cmpl   $0x1,(%rdx)
   13773:	0f b7 04 06          	movzwl (%rsi,%rax,1),%eax
   13777:	48 0f bf f0          	movswq %ax,%rsi
   1377b:	48 0f 45 f0          	cmovne %rax,%rsi
   1377f:	e8 3c f9 ff ff       	call   130c0 <fwp_encode>
   13784:	48 ff c5             	inc    %rbp
   13787:	48 8b 03             	mov    (%rbx),%rax
   1378a:	48 89 c1             	mov    %rax,%rcx
   1378d:	4c 21 e1             	and    %r12,%rcx
   13790:	48 39 cd             	cmp    %rcx,%rbp
   13793:	0f 83 d2 fa ff ff    	jae    1326b <fwp_encode+0x1ab>
   13799:	49 8b 56 38          	mov    0x38(%r14),%rdx
   1379d:	b9 08 00 00 00       	mov    $0x8,%ecx
   137a2:	48 85 d2             	test   %rdx,%rdx
   137a5:	74 19                	je     137c0 <fwp_encode+0x700>
   137a7:	8b 32                	mov    (%rdx),%esi
   137a9:	48 83 fe 0a          	cmp    $0xa,%rsi
   137ad:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
   137b2:	77 11                	ja     137c5 <fwp_encode+0x705>
   137b4:	49 8b 4c f5 00       	mov    0x0(%r13,%rsi,8),%rcx
   137b9:	eb 0a                	jmp    137c5 <fwp_encode+0x705>
   137bb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   137c0:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
   137c5:	4c 89 fe             	mov    %r15,%rsi
   137c8:	48 85 c0             	test   %rax,%rax
   137cb:	79 04                	jns    137d1 <fwp_encode+0x711>
   137cd:	48 8b 73 10          	mov    0x10(%rbx),%rsi
   137d1:	48 89 c8             	mov    %rcx,%rax
   137d4:	48 0f af c5          	imul   %rbp,%rax
   137d8:	48 83 f9 01          	cmp    $0x1,%rcx
   137dc:	74 12                	je     137f0 <fwp_encode+0x730>
   137de:	48 83 f9 02          	cmp    $0x2,%rcx
   137e2:	74 8c                	je     13770 <fwp_encode+0x6b0>
   137e4:	48 83 f9 08          	cmp    $0x8,%rcx
   137e8:	75 16                	jne    13800 <fwp_encode+0x740>
   137ea:	48 8b 34 06          	mov    (%rsi,%rax,1),%rsi
   137ee:	eb 8f                	jmp    1377f <fwp_encode+0x6bf>
   137f0:	83 3a 00             	cmpl   $0x0,(%rdx)
   137f3:	0f b6 04 06          	movzbl (%rsi,%rax,1),%eax
   137f7:	48 0f be f0          	movsbq %al,%rsi
   137fb:	e9 7b ff ff ff       	jmp    1377b <fwp_encode+0x6bb>
   13800:	83 3a 02             	cmpl   $0x2,(%rdx)
   13803:	8b 04 06             	mov    (%rsi,%rax,1),%eax
   13806:	48 63 f0             	movslq %eax,%rsi
   13809:	e9 6d ff ff ff       	jmp    1377b <fwp_encode+0x6bb>
   1380e:	c6 44 24 07 00       	movb   $0x0,0x7(%rsp)
   13813:	e9 9c f9 ff ff       	jmp    131b4 <fwp_encode+0xf4>
   13818:	4c 8d 7c 24 07       	lea    0x7(%rsp),%r15
   1381d:	4c 89 ed             	mov    %r13,%rbp
   13820:	48 c1 ed 07          	shr    $0x7,%rbp
   13824:	44 89 e8             	mov    %r13d,%eax
   13827:	0c 80                	or     $0x80,%al
   13829:	88 44 24 07          	mov    %al,0x7(%rsp)
   1382d:	ba 01 00 00 00       	mov    $0x1,%edx
   13832:	4c 89 e7             	mov    %r12,%rdi
   13835:	4c 89 fe             	mov    %r15,%rsi
   13838:	e8 53 9a ff ff       	call   d290 <buf_put>
   1383d:	49 81 fd ff 3f 00 00 	cmp    $0x3fff,%r13
   13844:	49 89 ed             	mov    %rbp,%r13
   13847:	77 d7                	ja     13820 <fwp_encode+0x760>
   13849:	40 88 6c 24 07       	mov    %bpl,0x7(%rsp)
   1384e:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
   13853:	ba 01 00 00 00       	mov    $0x1,%edx
   13858:	4c 89 e7             	mov    %r12,%rdi
   1385b:	e8 30 9a ff ff       	call   d290 <buf_put>
   13860:	48 85 db             	test   %rbx,%rbx
   13863:	0f 84 02 fa ff ff    	je     1326b <fwp_encode+0x1ab>
   13869:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   13870:	48 8b 73 08          	mov    0x8(%rbx),%rsi
   13874:	49 8b 56 38          	mov    0x38(%r14),%rdx
   13878:	4c 89 e7             	mov    %r12,%rdi
   1387b:	e8 40 f8 ff ff       	call   130c0 <fwp_encode>
   13880:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
   13884:	48 85 db             	test   %rbx,%rbx
   13887:	75 e7                	jne    13870 <fwp_encode+0x7b0>
   13889:	e9 dd f9 ff ff       	jmp    1326b <fwp_encode+0x1ab>
   1388e:	66 90                	xchg   %ax,%ax

0000000000013890 <rd_leb>:
   13890:	48 c7 06 00 00 00 00 	movq   $0x0,(%rsi)
   13897:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   1389b:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   1389f:	75 03                	jne    138a4 <rd_leb+0x14>
   138a1:	31 c0                	xor    %eax,%eax
   138a3:	c3                   	ret
   138a4:	48 8b 0f             	mov    (%rdi),%rcx
   138a7:	48 8d 42 01          	lea    0x1(%rdx),%rax
   138ab:	48 89 47 10          	mov    %rax,0x10(%rdi)
   138af:	0f b6 04 11          	movzbl (%rcx,%rdx,1),%eax
   138b3:	83 e0 7f             	and    $0x7f,%eax
   138b6:	48 09 06             	or     %rax,(%rsi)
   138b9:	b8 01 00 00 00       	mov    $0x1,%eax
   138be:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   138c2:	78 01                	js     138c5 <rd_leb+0x35>
   138c4:	c3                   	ret
   138c5:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   138c9:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   138cd:	74 d2                	je     138a1 <rd_leb+0x11>
   138cf:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   138d3:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   138d7:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   138dc:	41 83 e0 7f          	and    $0x7f,%r8d
   138e0:	41 c1 e0 07          	shl    $0x7,%r8d
   138e4:	4c 09 06             	or     %r8,(%rsi)
   138e7:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   138eb:	79 d7                	jns    138c4 <rd_leb+0x34>
   138ed:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   138f1:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   138f5:	74 aa                	je     138a1 <rd_leb+0x11>
   138f7:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   138fb:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   138ff:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   13904:	41 83 e0 7f          	and    $0x7f,%r8d
   13908:	41 c1 e0 0e          	shl    $0xe,%r8d
   1390c:	4c 09 06             	or     %r8,(%rsi)
   1390f:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   13913:	79 af                	jns    138c4 <rd_leb+0x34>
   13915:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   13919:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   1391d:	74 82                	je     138a1 <rd_leb+0x11>
   1391f:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   13923:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   13927:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   1392c:	41 83 e0 7f          	and    $0x7f,%r8d
   13930:	41 c1 e0 15          	shl    $0x15,%r8d
   13934:	4c 09 06             	or     %r8,(%rsi)
   13937:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   1393b:	79 87                	jns    138c4 <rd_leb+0x34>
   1393d:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   13941:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   13945:	0f 84 56 ff ff ff    	je     138a1 <rd_leb+0x11>
   1394b:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   1394f:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   13953:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   13958:	41 83 e0 7f          	and    $0x7f,%r8d
   1395c:	49 c1 e0 1c          	shl    $0x1c,%r8
   13960:	4c 09 06             	or     %r8,(%rsi)
   13963:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   13967:	0f 89 57 ff ff ff    	jns    138c4 <rd_leb+0x34>
   1396d:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   13971:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   13975:	0f 84 26 ff ff ff    	je     138a1 <rd_leb+0x11>
   1397b:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   1397f:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   13983:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   13988:	41 83 e0 7f          	and    $0x7f,%r8d
   1398c:	49 c1 e0 23          	shl    $0x23,%r8
   13990:	4c 09 06             	or     %r8,(%rsi)
   13993:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   13997:	0f 89 27 ff ff ff    	jns    138c4 <rd_leb+0x34>
   1399d:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   139a1:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   139a5:	0f 84 f6 fe ff ff    	je     138a1 <rd_leb+0x11>
   139ab:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   139af:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   139b3:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   139b8:	41 83 e0 7f          	and    $0x7f,%r8d
   139bc:	49 c1 e0 2a          	shl    $0x2a,%r8
   139c0:	4c 09 06             	or     %r8,(%rsi)
   139c3:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   139c7:	0f 89 f7 fe ff ff    	jns    138c4 <rd_leb+0x34>
   139cd:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   139d1:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   139d5:	0f 84 c6 fe ff ff    	je     138a1 <rd_leb+0x11>
   139db:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   139df:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   139e3:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   139e8:	41 83 e0 7f          	and    $0x7f,%r8d
   139ec:	49 c1 e0 31          	shl    $0x31,%r8
   139f0:	4c 09 06             	or     %r8,(%rsi)
   139f3:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   139f7:	0f 89 c7 fe ff ff    	jns    138c4 <rd_leb+0x34>
   139fd:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   13a01:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   13a05:	0f 84 96 fe ff ff    	je     138a1 <rd_leb+0x11>
   13a0b:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   13a0f:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   13a13:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   13a18:	41 83 e0 7f          	and    $0x7f,%r8d
   13a1c:	49 c1 e0 38          	shl    $0x38,%r8
   13a20:	4c 09 06             	or     %r8,(%rsi)
   13a23:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   13a27:	0f 89 97 fe ff ff    	jns    138c4 <rd_leb+0x34>
   13a2d:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   13a31:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   13a35:	0f 84 66 fe ff ff    	je     138a1 <rd_leb+0x11>
   13a3b:	48 8d 42 01          	lea    0x1(%rdx),%rax
   13a3f:	48 89 47 10          	mov    %rax,0x10(%rdi)
   13a43:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
   13a47:	b8 00 00 00 00       	mov    $0x0,%eax
   13a4c:	40 f6 c7 7e          	test   $0x7e,%dil
   13a50:	0f 85 6e fe ff ff    	jne    138c4 <rd_leb+0x34>
   13a56:	48 c1 e7 3f          	shl    $0x3f,%rdi
   13a5a:	48 09 3e             	or     %rdi,(%rsi)
   13a5d:	31 c0                	xor    %eax,%eax
   13a5f:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   13a63:	0f 99 c0             	setns  %al
   13a66:	c3                   	ret
   13a67:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   13a6e:	00 00 

0000000000013a70 <fwp_wire_empty_inner>:
   13a70:	31 c0                	xor    %eax,%eax
   13a72:	48 85 ff             	test   %rdi,%rdi
   13a75:	0f 84 a0 00 00 00    	je     13b1b <fwp_wire_empty_inner+0xab>
   13a7b:	83 3f 10             	cmpl   $0x10,(%rdi)
   13a7e:	0f 85 97 00 00 00    	jne    13b1b <fwp_wire_empty_inner+0xab>
   13a84:	41 57                	push   %r15
   13a86:	41 56                	push   %r14
   13a88:	41 54                	push   %r12
   13a8a:	53                   	push   %rbx
   13a8b:	48 83 ec 18          	sub    $0x18,%rsp
   13a8f:	48 85 f6             	test   %rsi,%rsi
   13a92:	74 1a                	je     13aae <fwp_wire_empty_inner+0x3e>
   13a94:	48 89 f1             	mov    %rsi,%rcx
   13a97:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   13a9e:	00 00 
   13aa0:	48 39 39             	cmp    %rdi,(%rcx)
   13aa3:	74 6b                	je     13b10 <fwp_wire_empty_inner+0xa0>
   13aa5:	48 8b 49 08          	mov    0x8(%rcx),%rcx
   13aa9:	48 85 c9             	test   %rcx,%rcx
   13aac:	75 f2                	jne    13aa0 <fwp_wire_empty_inner+0x30>
   13aae:	48 89 7c 24 08       	mov    %rdi,0x8(%rsp)
   13ab3:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
   13ab8:	44 8b 77 10          	mov    0x10(%rdi),%r14d
   13abc:	45 85 f6             	test   %r14d,%r14d
   13abf:	7e 46                	jle    13b07 <fwp_wire_empty_inner+0x97>
   13ac1:	4c 8b 7f 20          	mov    0x20(%rdi),%r15
   13ac5:	49 8b 3f             	mov    (%r15),%rdi
   13ac8:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
   13acd:	e8 9e ff ff ff       	call   13a70 <fwp_wire_empty_inner>
   13ad2:	85 c0                	test   %eax,%eax
   13ad4:	74 38                	je     13b0e <fwp_wire_empty_inner+0x9e>
   13ad6:	b9 01 00 00 00       	mov    $0x1,%ecx
   13adb:	48 8d 5c 24 08       	lea    0x8(%rsp),%rbx
   13ae0:	49 89 cc             	mov    %rcx,%r12
   13ae3:	49 39 ce             	cmp    %rcx,%r14
   13ae6:	74 15                	je     13afd <fwp_wire_empty_inner+0x8d>
   13ae8:	4b 8b 3c e7          	mov    (%r15,%r12,8),%rdi
   13aec:	48 89 de             	mov    %rbx,%rsi
   13aef:	e8 7c ff ff ff       	call   13a70 <fwp_wire_empty_inner>
   13af4:	49 8d 4c 24 01       	lea    0x1(%r12),%rcx
   13af9:	85 c0                	test   %eax,%eax
   13afb:	75 e3                	jne    13ae0 <fwp_wire_empty_inner+0x70>
   13afd:	31 c0                	xor    %eax,%eax
   13aff:	4d 39 f4             	cmp    %r14,%r12
   13b02:	0f 93 c0             	setae  %al
   13b05:	eb 09                	jmp    13b10 <fwp_wire_empty_inner+0xa0>
   13b07:	b8 01 00 00 00       	mov    $0x1,%eax
   13b0c:	eb 02                	jmp    13b10 <fwp_wire_empty_inner+0xa0>
   13b0e:	31 c0                	xor    %eax,%eax
   13b10:	48 83 c4 18          	add    $0x18,%rsp
   13b14:	5b                   	pop    %rbx
   13b15:	41 5c                	pop    %r12
   13b17:	41 5e                	pop    %r14
   13b19:	41 5f                	pop    %r15
   13b1b:	c3                   	ret
   13b1c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000013b20 <fwp_gc_find_data>:
   13b20:	0f b7 77 18          	movzwl 0x18(%rdi),%esi
   13b24:	48 85 f6             	test   %rsi,%rsi
   13b27:	0f 84 be 00 00 00    	je     13beb <fwp_gc_find_data+0xcb>
   13b2d:	53                   	push   %rbx
   13b2e:	48 8b 07             	mov    (%rdi),%rax
   13b31:	4c 8b 47 10          	mov    0x10(%rdi),%r8
   13b35:	48 6b ce 38          	imul   $0x38,%rsi,%rcx
   13b39:	45 31 c9             	xor    %r9d,%r9d
   13b3c:	48 8d 15 45 67 00 00 	lea    0x6745(%rip),%rdx        # 1a288 <fwp_gc>
   13b43:	41 bb 01 00 00 00    	mov    $0x1,%r11d
   13b49:	45 31 d2             	xor    %r10d,%r10d
   13b4c:	eb 0b                	jmp    13b59 <fwp_gc_find_data+0x39>
   13b4e:	66 90                	xchg   %ax,%ax
   13b50:	49 83 c1 38          	add    $0x38,%r9
   13b54:	4c 39 c9             	cmp    %r9,%rcx
   13b57:	74 22                	je     13b7b <fwp_gc_find_data+0x5b>
   13b59:	43 83 3c 08 01       	cmpl   $0x1,(%r8,%r9,1)
   13b5e:	75 f0                	jne    13b50 <fwp_gc_find_data+0x30>
   13b60:	4b 8b 5c 08 10       	mov    0x10(%r8,%r9,1),%rbx
   13b65:	48 01 c3             	add    %rax,%rbx
   13b68:	48 39 d3             	cmp    %rdx,%rbx
   13b6b:	77 e3                	ja     13b50 <fwp_gc_find_data+0x30>
   13b6d:	4b 03 5c 08 28       	add    0x28(%r8,%r9,1),%rbx
   13b72:	48 39 d3             	cmp    %rdx,%rbx
   13b75:	45 0f 47 d3          	cmova  %r11d,%r10d
   13b79:	eb d5                	jmp    13b50 <fwp_gc_find_data+0x30>
   13b7b:	31 c0                	xor    %eax,%eax
   13b7d:	45 85 d2             	test   %r10d,%r10d
   13b80:	0f 95 c0             	setne  %al
   13b83:	74 6e                	je     13bf3 <fwp_gc_find_data+0xd3>
   13b85:	66 85 f6             	test   %si,%si
   13b88:	74 69                	je     13bf3 <fwp_gc_find_data+0xd3>
   13b8a:	8b 05 88 78 00 00    	mov    0x7888(%rip),%eax        # 1b418 <fwp_gc+0x1190>
   13b90:	48 8b 77 10          	mov    0x10(%rdi),%rsi
   13b94:	45 31 c0             	xor    %r8d,%r8d
   13b97:	eb 10                	jmp    13ba9 <fwp_gc_find_data+0x89>
   13b99:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   13ba0:	49 83 c0 38          	add    $0x38,%r8
   13ba4:	4c 39 c1             	cmp    %r8,%rcx
   13ba7:	74 45                	je     13bee <fwp_gc_find_data+0xce>
   13ba9:	42 83 3c 06 01       	cmpl   $0x1,(%rsi,%r8,1)
   13bae:	75 f0                	jne    13ba0 <fwp_gc_find_data+0x80>
   13bb0:	42 f6 44 06 04 02    	testb  $0x2,0x4(%rsi,%r8,1)
   13bb6:	74 e8                	je     13ba0 <fwp_gc_find_data+0x80>
   13bb8:	83 f8 10             	cmp    $0x10,%eax
   13bbb:	74 31                	je     13bee <fwp_gc_find_data+0xce>
   13bbd:	4e 8b 4c 06 10       	mov    0x10(%rsi,%r8,1),%r9
   13bc2:	4c 03 0f             	add    (%rdi),%r9
   13bc5:	4c 63 d0             	movslq %eax,%r10
   13bc8:	49 c1 e2 04          	shl    $0x4,%r10
   13bcc:	4d 89 8c 12 90 10 00 	mov    %r9,0x1090(%r10,%rdx,1)
   13bd3:	00 
   13bd4:	4e 8b 4c 06 28       	mov    0x28(%rsi,%r8,1),%r9
   13bd9:	4d 89 8c 12 98 10 00 	mov    %r9,0x1098(%r10,%rdx,1)
   13be0:	00 
   13be1:	ff c0                	inc    %eax
   13be3:	89 05 2f 78 00 00    	mov    %eax,0x782f(%rip)        # 1b418 <fwp_gc+0x1190>
   13be9:	eb b5                	jmp    13ba0 <fwp_gc_find_data+0x80>
   13beb:	31 c0                	xor    %eax,%eax
   13bed:	c3                   	ret
   13bee:	b8 01 00 00 00       	mov    $0x1,%eax
   13bf3:	5b                   	pop    %rbx
   13bf4:	c3                   	ret
   13bf5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   13bfc:	00 00 00 00 

0000000000013c00 <fwp_gc_report>:
   13c00:	55                   	push   %rbp
   13c01:	41 57                	push   %r15
   13c03:	41 56                	push   %r14
   13c05:	41 55                	push   %r13
   13c07:	41 54                	push   %r12
   13c09:	53                   	push   %rbx
   13c0a:	48 81 ec 58 01 00 00 	sub    $0x158,%rsp
   13c11:	48 8b 05 80 78 00 00 	mov    0x7880(%rip),%rax        # 1b498 <fwp_gc+0x1210>
   13c18:	48 8b 0d 69 66 00 00 	mov    0x6669(%rip),%rcx        # 1a288 <fwp_gc>
   13c1f:	48 29 c8             	sub    %rcx,%rax
   13c22:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
   13c27:	f2 0f 58 05 41 78 00 	addsd  0x7841(%rip),%xmm0        # 1b470 <fwp_gc+0x11e8>
   13c2e:	00 
   13c2f:	f2 0f 11 44 24 48    	movsd  %xmm0,0x48(%rsp)
   13c35:	f2 0f 11 05 33 78 00 	movsd  %xmm0,0x7833(%rip)        # 1b470 <fwp_gc+0x11e8>
   13c3c:	00 
   13c3d:	48 89 0d 54 78 00 00 	mov    %rcx,0x7854(%rip)        # 1b498 <fwp_gc+0x1210>
   13c44:	48 8b 05 8d 63 00 00 	mov    0x638d(%rip),%rax        # 19fd8 <stderr@GLIBC_2.2.5>
   13c4b:	48 8b 28             	mov    (%rax),%rbp
   13c4e:	48 8b 1d 0b 78 00 00 	mov    0x780b(%rip),%rbx        # 1b460 <fwp_gc+0x11d8>
   13c55:	4c 8b 3d 44 76 00 00 	mov    0x7644(%rip),%r15        # 1b2a0 <fwp_gc+0x1018>
   13c5c:	f2 0f 10 05 2c 78 00 	movsd  0x782c(%rip),%xmm0        # 1b490 <fwp_gc+0x1208>
   13c63:	00 
   13c64:	f2 0f 11 44 24 30    	movsd  %xmm0,0x30(%rsp)
   13c6a:	48 8b 05 5f 76 00 00 	mov    0x765f(%rip),%rax        # 1b2d0 <fwp_gc+0x1048>
   13c71:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
   13c76:	48 8b 05 d3 77 00 00 	mov    0x77d3(%rip),%rax        # 1b450 <fwp_gc+0x11c8>
   13c7d:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   13c82:	4c 8b 35 cf 77 00 00 	mov    0x77cf(%rip),%r14        # 1b458 <fwp_gc+0x11d0>
   13c89:	f2 0f 10 05 e7 77 00 	movsd  0x77e7(%rip),%xmm0        # 1b478 <fwp_gc+0x11f0>
   13c90:	00 
   13c91:	f2 0f 11 44 24 40    	movsd  %xmm0,0x40(%rsp)
   13c97:	f2 0f 10 05 e1 77 00 	movsd  0x77e1(%rip),%xmm0        # 1b480 <fwp_gc+0x11f8>
   13c9e:	00 
   13c9f:	f2 0f 11 44 24 38    	movsd  %xmm0,0x38(%rsp)
   13ca5:	48 8d 3d 38 2d 00 00 	lea    0x2d38(%rip),%rdi        # 169e4 <exec_in_fp0+0x1174>
   13cac:	48 8d 35 31 2b 00 00 	lea    0x2b31(%rip),%rsi        # 167e4 <exec_in_fp0+0xf74>
   13cb3:	e8 58 f7 fe ff       	call   3410 <fopen@plt>
   13cb8:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
   13cbf:	48 85 c0             	test   %rax,%rax
   13cc2:	74 4b                	je     13d0f <fwp_gc_report+0x10f>
   13cc4:	49 89 c5             	mov    %rax,%r13
   13cc7:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
   13ccc:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
   13cd1:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
   13cd6:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
   13cdb:	be 00 01 00 00       	mov    $0x100,%esi
   13ce0:	48 89 c2             	mov    %rax,%rdx
   13ce3:	e8 a8 f5 fe ff       	call   3290 <fgets@plt>
   13ce8:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
   13cef:	48 85 c0             	test   %rax,%rax
   13cf2:	0f 85 f1 00 00 00    	jne    13de9 <fwp_gc_report+0x1e9>
   13cf8:	4c 89 ef             	mov    %r13,%rdi
   13cfb:	e8 50 f4 fe ff       	call   3150 <fclose@plt>
   13d00:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
   13d05:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
   13d0a:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
   13d0f:	66 49 0f 6e c6       	movq   %r14,%xmm0
   13d14:	66 0f 6f 0d 04 14 00 	movdqa 0x1404(%rip),%xmm1        # 15120 <_IO_stdin_used+0x120>
   13d1b:	00 
   13d1c:	66 0f 62 c1          	punpckldq %xmm1,%xmm0
   13d20:	66 0f 28 15 08 14 00 	movapd 0x1408(%rip),%xmm2        # 15130 <_IO_stdin_used+0x130>
   13d27:	00 
   13d28:	66 0f 5c c2          	subpd  %xmm2,%xmm0
   13d2c:	66 0f 28 e0          	movapd %xmm0,%xmm4
   13d30:	66 0f 15 e0          	unpckhpd %xmm0,%xmm4
   13d34:	f2 0f 58 e0          	addsd  %xmm0,%xmm4
   13d38:	f2 0f 10 35 98 14 00 	movsd  0x1498(%rip),%xmm6        # 151d8 <_IO_stdin_used+0x1d8>
   13d3f:	00 
   13d40:	f2 0f 59 e6          	mulsd  %xmm6,%xmm4
   13d44:	f3 0f 7e 6c 24 20    	movq   0x20(%rsp),%xmm5
   13d4a:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
   13d4e:	66 0f 5c ea          	subpd  %xmm2,%xmm5
   13d52:	66 0f 28 dd          	movapd %xmm5,%xmm3
   13d56:	66 0f 15 dd          	unpckhpd %xmm5,%xmm3
   13d5a:	f2 0f 58 dd          	addsd  %xmm5,%xmm3
   13d5e:	f2 0f 59 de          	mulsd  %xmm6,%xmm3
   13d62:	f3 0f 7e 6c 24 28    	movq   0x28(%rsp),%xmm5
   13d68:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
   13d6c:	66 0f 5c ea          	subpd  %xmm2,%xmm5
   13d70:	66 0f 28 d5          	movapd %xmm5,%xmm2
   13d74:	66 0f 15 d5          	unpckhpd %xmm5,%xmm2
   13d78:	f2 0f 58 d5          	addsd  %xmm5,%xmm2
   13d7c:	f2 0f 59 d6          	mulsd  %xmm6,%xmm2
   13d80:	f2 0f 10 44 24 48    	movsd  0x48(%rsp),%xmm0
   13d86:	f2 0f 10 4c 24 30    	movsd  0x30(%rsp),%xmm1
   13d8c:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
   13d90:	f2 0f 59 ce          	mulsd  %xmm6,%xmm1
   13d94:	f2 0f 59 c6          	mulsd  %xmm6,%xmm0
   13d98:	83 3d dd 74 00 00 00 	cmpl   $0x0,0x74dd(%rip)        # 1b27c <fwp_gc+0xff4>
   13d9f:	48 8d 05 2c 2c 00 00 	lea    0x2c2c(%rip),%rax        # 169d2 <exec_in_fp0+0x1162>
   13da6:	4c 8d 0d 3d 24 00 00 	lea    0x243d(%rip),%r9        # 161ea <exec_in_fp0+0x97a>
   13dad:	4c 0f 44 c8          	cmove  %rax,%r9
   13db1:	48 8d 35 65 2b 00 00 	lea    0x2b65(%rip),%rsi        # 1691d <exec_in_fp0+0x10ad>
   13db8:	48 89 ef             	mov    %rbp,%rdi
   13dbb:	48 89 da             	mov    %rbx,%rdx
   13dbe:	4c 89 f9             	mov    %r15,%rcx
   13dc1:	f2 0f 10 6c 24 40    	movsd  0x40(%rsp),%xmm5
   13dc7:	f2 0f 10 74 24 38    	movsd  0x38(%rsp),%xmm6
   13dcd:	4d 89 e0             	mov    %r12,%r8
   13dd0:	b0 07                	mov    $0x7,%al
   13dd2:	e8 19 f5 fe ff       	call   32f0 <fprintf@plt>
   13dd7:	48 81 c4 58 01 00 00 	add    $0x158,%rsp
   13dde:	5b                   	pop    %rbx
   13ddf:	41 5c                	pop    %r12
   13de1:	41 5d                	pop    %r13
   13de3:	41 5e                	pop    %r14
   13de5:	41 5f                	pop    %r15
   13de7:	5d                   	pop    %rbp
   13de8:	c3                   	ret
   13de9:	48 8d 6c 24 56       	lea    0x56(%rsp),%rbp
   13dee:	41 bf 56 6d 48 57    	mov    $0x57486d56,%r15d
   13df4:	48 8d 5c 24 50       	lea    0x50(%rsp),%rbx
   13df9:	eb 1e                	jmp    13e19 <fwp_gc_report+0x219>
   13dfb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   13e00:	48 89 df             	mov    %rbx,%rdi
   13e03:	be 00 01 00 00       	mov    $0x100,%esi
   13e08:	4c 89 ea             	mov    %r13,%rdx
   13e0b:	e8 80 f4 fe ff       	call   3290 <fgets@plt>
   13e10:	48 85 c0             	test   %rax,%rax
   13e13:	0f 84 df fe ff ff    	je     13cf8 <fwp_gc_report+0xf8>
   13e19:	8b 44 24 50          	mov    0x50(%rsp),%eax
   13e1d:	44 31 f8             	xor    %r15d,%eax
   13e20:	0f b6 4c 24 54       	movzbl 0x54(%rsp),%ecx
   13e25:	83 f1 4d             	xor    $0x4d,%ecx
   13e28:	09 c1                	or     %eax,%ecx
   13e2a:	75 d4                	jne    13e00 <fwp_gc_report+0x200>
   13e2c:	80 7c 24 55 3a       	cmpb   $0x3a,0x55(%rsp)
   13e31:	75 cd                	jne    13e00 <fwp_gc_report+0x200>
   13e33:	48 89 ef             	mov    %rbp,%rdi
   13e36:	31 f6                	xor    %esi,%esi
   13e38:	ba 0a 00 00 00       	mov    $0xa,%edx
   13e3d:	e8 de f4 fe ff       	call   3320 <strtol@plt>
   13e42:	49 89 c4             	mov    %rax,%r12
   13e45:	eb b9                	jmp    13e00 <fwp_gc_report+0x200>
   13e47:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   13e4e:	00 00 

0000000000013e50 <fwp_owner_release0>:
   13e50:	48 8b 3f             	mov    (%rdi),%rdi
   13e53:	eb 0b                	jmp    13e60 <fwp_drop0>
   13e55:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   13e5c:	00 00 00 00 

0000000000013e60 <fwp_drop0>:
   13e60:	53                   	push   %rbx
   13e61:	48 89 f8             	mov    %rdi,%rax
   13e64:	48 2b 05 4d 74 00 00 	sub    0x744d(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
   13e6b:	48 8b 0d 6e 74 00 00 	mov    0x746e(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
   13e72:	48 c1 e1 10          	shl    $0x10,%rcx
   13e76:	48 39 c8             	cmp    %rcx,%rax
   13e79:	0f 83 9c 00 00 00    	jae    13f1b <fwp_drop0+0xbb>
   13e7f:	48 8b 0d 7a 74 00 00 	mov    0x747a(%rip),%rcx        # 1b300 <fwp_gc+0x1078>
   13e86:	48 89 c2             	mov    %rax,%rdx
   13e89:	48 c1 ea 10          	shr    $0x10,%rdx
   13e8d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
   13e94:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
   13e98:	48 25 ff ff 00 00    	and    $0xffff,%rax
   13e9e:	75 20                	jne    13ec0 <fwp_drop0+0x60>
   13ea0:	40 80 fe 02          	cmp    $0x2,%sil
   13ea4:	75 1a                	jne    13ec0 <fwp_drop0+0x60>
   13ea6:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
   13eaa:	48 05 28 02 00 00    	add    $0x228,%rax
   13eb0:	eb 2d                	jmp    13edf <fwp_drop0+0x7f>
   13eb2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   13eb9:	1f 84 00 00 00 00 00 
   13ec0:	40 80 fe 01          	cmp    $0x1,%sil
   13ec4:	75 55                	jne    13f1b <fwp_drop0+0xbb>
   13ec6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
   13eca:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
   13ece:	48 0f af c1          	imul   %rcx,%rax
   13ed2:	48 c1 e8 20          	shr    $0x20,%rax
   13ed6:	48 01 f0             	add    %rsi,%rax
   13ed9:	48 05 28 02 00 00    	add    $0x228,%rax
   13edf:	0f b6 08             	movzbl (%rax),%ecx
   13ee2:	85 c9                	test   %ecx,%ecx
   13ee4:	74 35                	je     13f1b <fwp_drop0+0xbb>
   13ee6:	83 f9 01             	cmp    $0x1,%ecx
   13ee9:	75 32                	jne    13f1d <fwp_drop0+0xbd>
   13eeb:	48 83 3f 00          	cmpq   $0x0,(%rdi)
   13eef:	79 3a                	jns    13f2b <fwp_drop0+0xcb>
   13ef1:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
   13ef5:	e8 f6 6e ff ff       	call   adf0 <fwp_rc_free_arr>
   13efa:	48 89 d8             	mov    %rbx,%rax
   13efd:	48 2b 05 b4 73 00 00 	sub    0x73b4(%rip),%rax        # 1b2b8 <fwp_gc+0x1030>
   13f04:	48 8b 0d d5 73 00 00 	mov    0x73d5(%rip),%rcx        # 1b2e0 <fwp_gc+0x1058>
   13f0b:	48 c1 e1 10          	shl    $0x10,%rcx
   13f0f:	48 89 df             	mov    %rbx,%rdi
   13f12:	48 39 c8             	cmp    %rcx,%rax
   13f15:	0f 82 64 ff ff ff    	jb     13e7f <fwp_drop0+0x1f>
   13f1b:	5b                   	pop    %rbx
   13f1c:	c3                   	ret
   13f1d:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
   13f23:	74 0c                	je     13f31 <fwp_drop0+0xd1>
   13f25:	fe c9                	dec    %cl
   13f27:	88 08                	mov    %cl,(%rax)
   13f29:	5b                   	pop    %rbx
   13f2a:	c3                   	ret
   13f2b:	5b                   	pop    %rbx
   13f2c:	e9 bf 6e ff ff       	jmp    adf0 <fwp_rc_free_arr>
   13f31:	48 89 c7             	mov    %rax,%rdi
   13f34:	5b                   	pop    %rbx
   13f35:	e9 36 67 ff ff       	jmp    a670 <fwp_rc_wide_drop>
   13f3a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000013f40 <fwp_owner_release1>:
   13f40:	48 8b 3f             	mov    (%rdi),%rdi
   13f43:	e9 18 ff ff ff       	jmp    13e60 <fwp_drop0>
   13f48:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   13f4f:	00 

0000000000013f50 <fwp_owner_release2>:
   13f50:	48 8b 3f             	mov    (%rdi),%rdi
   13f53:	e9 08 ff ff ff       	jmp    13e60 <fwp_drop0>
   13f58:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   13f5f:	00 

0000000000013f60 <__divti3>:
   13f60:	f3 0f 1e fa          	endbr64
   13f64:	55                   	push   %rbp
   13f65:	49 89 f8             	mov    %rdi,%r8
   13f68:	49 89 d2             	mov    %rdx,%r10
   13f6b:	49 89 cb             	mov    %rcx,%r11
   13f6e:	31 ff                	xor    %edi,%edi
   13f70:	48 89 e5             	mov    %rsp,%rbp
   13f73:	41 56                	push   %r14
   13f75:	53                   	push   %rbx
   13f76:	48 85 f6             	test   %rsi,%rsi
   13f79:	79 13                	jns    13f8e <__divti3+0x2e>
   13f7b:	45 31 c9             	xor    %r9d,%r9d
   13f7e:	49 f7 d8             	neg    %r8
   13f81:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
   13f88:	49 19 f1             	sbb    %rsi,%r9
   13f8b:	4c 89 ce             	mov    %r9,%rsi
   13f8e:	4c 89 da             	mov    %r11,%rdx
   13f91:	4d 85 db             	test   %r11,%r11
   13f94:	0f 88 f6 00 00 00    	js     14090 <__divti3+0x130>
   13f9a:	4d 89 d6             	mov    %r10,%r14
   13f9d:	75 31                	jne    13fd0 <__divti3+0x70>
   13f9f:	4c 39 f6             	cmp    %r14,%rsi
   13fa2:	0f 83 b8 00 00 00    	jae    14060 <__divti3+0x100>
   13fa8:	48 89 f2             	mov    %rsi,%rdx
   13fab:	31 f6                	xor    %esi,%esi
   13fad:	4c 89 c0             	mov    %r8,%rax
   13fb0:	49 f7 f6             	div    %r14
   13fb3:	48 89 f2             	mov    %rsi,%rdx
   13fb6:	48 85 ff             	test   %rdi,%rdi
   13fb9:	74 0a                	je     13fc5 <__divti3+0x65>
   13fbb:	48 f7 d8             	neg    %rax
   13fbe:	48 83 d2 00          	adc    $0x0,%rdx
   13fc2:	48 f7 da             	neg    %rdx
   13fc5:	5b                   	pop    %rbx
   13fc6:	41 5e                	pop    %r14
   13fc8:	5d                   	pop    %rbp
   13fc9:	c3                   	ret
   13fca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   13fd0:	4c 39 de             	cmp    %r11,%rsi
   13fd3:	0f 82 d5 00 00 00    	jb     140ae <__divti3+0x14e>
   13fd9:	4d 0f bd d3          	bsr    %r11,%r10
   13fdd:	41 83 f2 3f          	xor    $0x3f,%r10d
   13fe1:	44 89 d1             	mov    %r10d,%ecx
   13fe4:	b8 40 00 00 00       	mov    $0x40,%eax
   13fe9:	4c 89 f3             	mov    %r14,%rbx
   13fec:	4d 89 f1             	mov    %r14,%r9
   13fef:	48 d3 e2             	shl    %cl,%rdx
   13ff2:	49 63 ca             	movslq %r10d,%rcx
   13ff5:	49 89 f3             	mov    %rsi,%r11
   13ff8:	48 29 c8             	sub    %rcx,%rax
   13ffb:	89 c1                	mov    %eax,%ecx
   13ffd:	48 d3 eb             	shr    %cl,%rbx
   14000:	44 89 d1             	mov    %r10d,%ecx
   14003:	49 d3 e1             	shl    %cl,%r9
   14006:	89 c1                	mov    %eax,%ecx
   14008:	48 09 d3             	or     %rdx,%rbx
   1400b:	4c 89 c2             	mov    %r8,%rdx
   1400e:	49 d3 eb             	shr    %cl,%r11
   14011:	44 89 d1             	mov    %r10d,%ecx
   14014:	48 d3 e6             	shl    %cl,%rsi
   14017:	89 c1                	mov    %eax,%ecx
   14019:	48 d3 ea             	shr    %cl,%rdx
   1401c:	48 89 d0             	mov    %rdx,%rax
   1401f:	4c 89 da             	mov    %r11,%rdx
   14022:	48 09 f0             	or     %rsi,%rax
   14025:	48 f7 f3             	div    %rbx
   14028:	49 89 d3             	mov    %rdx,%r11
   1402b:	48 89 c6             	mov    %rax,%rsi
   1402e:	49 f7 e1             	mul    %r9
   14031:	49 39 d3             	cmp    %rdx,%r11
   14034:	0f 82 be 00 00 00    	jb     140f8 <__divti3+0x198>
   1403a:	44 89 d1             	mov    %r10d,%ecx
   1403d:	49 d3 e0             	shl    %cl,%r8
   14040:	49 39 c0             	cmp    %rax,%r8
   14043:	73 09                	jae    1404e <__divti3+0xee>
   14045:	49 39 d3             	cmp    %rdx,%r11
   14048:	0f 84 aa 00 00 00    	je     140f8 <__divti3+0x198>
   1404e:	48 89 f0             	mov    %rsi,%rax
   14051:	31 f6                	xor    %esi,%esi
   14053:	e9 5b ff ff ff       	jmp    13fb3 <__divti3+0x53>
   14058:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   1405f:	00 
   14060:	4d 85 f6             	test   %r14,%r14
   14063:	75 0d                	jne    14072 <__divti3+0x112>
   14065:	b8 01 00 00 00       	mov    $0x1,%eax
   1406a:	31 d2                	xor    %edx,%edx
   1406c:	49 f7 f6             	div    %r14
   1406f:	49 89 c6             	mov    %rax,%r14
   14072:	48 89 f0             	mov    %rsi,%rax
   14075:	31 d2                	xor    %edx,%edx
   14077:	49 f7 f6             	div    %r14
   1407a:	48 89 c6             	mov    %rax,%rsi
   1407d:	4c 89 c0             	mov    %r8,%rax
   14080:	49 f7 f6             	div    %r14
   14083:	e9 2b ff ff ff       	jmp    13fb3 <__divti3+0x53>
   14088:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   1408f:	00 
   14090:	49 f7 da             	neg    %r10
   14093:	48 f7 d7             	not    %rdi
   14096:	49 83 d3 00          	adc    $0x0,%r11
   1409a:	4d 89 d6             	mov    %r10,%r14
   1409d:	49 f7 db             	neg    %r11
   140a0:	4c 89 da             	mov    %r11,%rdx
   140a3:	0f 84 f6 fe ff ff    	je     13f9f <__divti3+0x3f>
   140a9:	4c 39 de             	cmp    %r11,%rsi
   140ac:	73 12                	jae    140c0 <__divti3+0x160>
   140ae:	31 f6                	xor    %esi,%esi
   140b0:	31 c0                	xor    %eax,%eax
   140b2:	e9 fc fe ff ff       	jmp    13fb3 <__divti3+0x53>
   140b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   140be:	00 00 
   140c0:	49 0f bd c3          	bsr    %r11,%rax
   140c4:	48 83 f0 3f          	xor    $0x3f,%rax
   140c8:	41 89 c2             	mov    %eax,%r10d
   140cb:	85 c0                	test   %eax,%eax
   140cd:	0f 85 0e ff ff ff    	jne    13fe1 <__divti3+0x81>
   140d3:	49 39 f3             	cmp    %rsi,%r11
   140d6:	72 0d                	jb     140e5 <__divti3+0x185>
   140d8:	31 f6                	xor    %esi,%esi
   140da:	31 c0                	xor    %eax,%eax
   140dc:	4d 39 f0             	cmp    %r14,%r8
   140df:	0f 82 ce fe ff ff    	jb     13fb3 <__divti3+0x53>
   140e5:	31 f6                	xor    %esi,%esi
   140e7:	b8 01 00 00 00       	mov    $0x1,%eax
   140ec:	e9 c2 fe ff ff       	jmp    13fb3 <__divti3+0x53>
   140f1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140f8:	48 8d 46 ff          	lea    -0x1(%rsi),%rax
   140fc:	31 f6                	xor    %esi,%esi
   140fe:	e9 b0 fe ff ff       	jmp    13fb3 <__divti3+0x53>
   14103:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   1410a:	00 00 00 
   1410d:	0f 1f 00             	nopl   (%rax)

0000000000014110 <atexit>:
   14110:	f3 0f 1e fa          	endbr64
   14114:	48 8b 15 5d 61 00 00 	mov    0x615d(%rip),%rdx        # 1a278 <__dso_handle>
   1411b:	31 f6                	xor    %esi,%esi
   1411d:	e9 1e f3 fe ff       	jmp    3440 <__cxa_atexit@plt>

Disassembly of section .fini:

0000000000014124 <_fini>:
   14124:	f3 0f 1e fa          	endbr64
   14128:	48 83 ec 08          	sub    $0x8,%rsp
   1412c:	48 83 c4 08          	add    $0x8,%rsp
   14130:	c3                   	ret
