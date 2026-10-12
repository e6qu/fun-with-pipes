
/tmp/fwp-array-fusion-allocation-5114/profile-0O2:     file format elf64-x86-64


Disassembly of section .init:

0000000000003000 <_init>:
    3000:	f3 0f 1e fa          	endbr64
    3004:	48 83 ec 08          	sub    $0x8,%rsp
    3008:	48 8b 05 b1 5f 01 00 	mov    0x15fb1(%rip),%rax        # 18fc0 <__gmon_start__@Base>
    300f:	48 85 c0             	test   %rax,%rax
    3012:	74 02                	je     3016 <_init+0x16>
    3014:	ff d0                	call   *%rax
    3016:	48 83 c4 08          	add    $0x8,%rsp
    301a:	c3                   	ret

Disassembly of section .plt:

0000000000003020 <getenv@plt-0x10>:
    3020:	ff 35 ca 5f 01 00    	push   0x15fca(%rip)        # 18ff0 <_GLOBAL_OFFSET_TABLE_+0x8>
    3026:	ff 25 cc 5f 01 00    	jmp    *0x15fcc(%rip)        # 18ff8 <_GLOBAL_OFFSET_TABLE_+0x10>
    302c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000003030 <getenv@plt>:
    3030:	ff 25 ca 5f 01 00    	jmp    *0x15fca(%rip)        # 19000 <getenv@GLIBC_2.2.5>
    3036:	68 00 00 00 00       	push   $0x0
    303b:	e9 e0 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003040 <dl_iterate_phdr@plt>:
    3040:	ff 25 c2 5f 01 00    	jmp    *0x15fc2(%rip)        # 19008 <dl_iterate_phdr@GLIBC_2.2.5>
    3046:	68 01 00 00 00       	push   $0x1
    304b:	e9 d0 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003050 <free@plt>:
    3050:	ff 25 ba 5f 01 00    	jmp    *0x15fba(%rip)        # 19010 <free@GLIBC_2.2.5>
    3056:	68 02 00 00 00       	push   $0x2
    305b:	e9 c0 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003060 <recv@plt>:
    3060:	ff 25 b2 5f 01 00    	jmp    *0x15fb2(%rip)        # 19018 <recv@GLIBC_2.2.5>
    3066:	68 03 00 00 00       	push   $0x3
    306b:	e9 b0 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003070 <abort@plt>:
    3070:	ff 25 aa 5f 01 00    	jmp    *0x15faa(%rip)        # 19020 <abort@GLIBC_2.2.5>
    3076:	68 04 00 00 00       	push   $0x4
    307b:	e9 a0 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003080 <__errno_location@plt>:
    3080:	ff 25 a2 5f 01 00    	jmp    *0x15fa2(%rip)        # 19028 <__errno_location@GLIBC_2.2.5>
    3086:	68 05 00 00 00       	push   $0x5
    308b:	e9 90 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003090 <strncmp@plt>:
    3090:	ff 25 9a 5f 01 00    	jmp    *0x15f9a(%rip)        # 19030 <strncmp@GLIBC_2.2.5>
    3096:	68 06 00 00 00       	push   $0x6
    309b:	e9 80 ff ff ff       	jmp    3020 <_init+0x20>

00000000000030a0 <_exit@plt>:
    30a0:	ff 25 92 5f 01 00    	jmp    *0x15f92(%rip)        # 19038 <_exit@GLIBC_2.2.5>
    30a6:	68 07 00 00 00       	push   $0x7
    30ab:	e9 70 ff ff ff       	jmp    3020 <_init+0x20>

00000000000030b0 <strcpy@plt>:
    30b0:	ff 25 8a 5f 01 00    	jmp    *0x15f8a(%rip)        # 19040 <strcpy@GLIBC_2.2.5>
    30b6:	68 08 00 00 00       	push   $0x8
    30bb:	e9 60 ff ff ff       	jmp    3020 <_init+0x20>

00000000000030c0 <sendmsg@plt>:
    30c0:	ff 25 82 5f 01 00    	jmp    *0x15f82(%rip)        # 19048 <sendmsg@GLIBC_2.2.5>
    30c6:	68 09 00 00 00       	push   $0x9
    30cb:	e9 50 ff ff ff       	jmp    3020 <_init+0x20>

00000000000030d0 <puts@plt>:
    30d0:	ff 25 7a 5f 01 00    	jmp    *0x15f7a(%rip)        # 19050 <puts@GLIBC_2.2.5>
    30d6:	68 0a 00 00 00       	push   $0xa
    30db:	e9 40 ff ff ff       	jmp    3020 <_init+0x20>

00000000000030e0 <sigaction@plt>:
    30e0:	ff 25 72 5f 01 00    	jmp    *0x15f72(%rip)        # 19058 <sigaction@GLIBC_2.2.5>
    30e6:	68 0b 00 00 00       	push   $0xb
    30eb:	e9 30 ff ff ff       	jmp    3020 <_init+0x20>

00000000000030f0 <fread@plt>:
    30f0:	ff 25 6a 5f 01 00    	jmp    *0x15f6a(%rip)        # 19060 <fread@GLIBC_2.2.5>
    30f6:	68 0c 00 00 00       	push   $0xc
    30fb:	e9 20 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003100 <strtod@plt>:
    3100:	ff 25 62 5f 01 00    	jmp    *0x15f62(%rip)        # 19068 <strtod@GLIBC_2.2.5>
    3106:	68 0d 00 00 00       	push   $0xd
    310b:	e9 10 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003110 <vsnprintf@plt>:
    3110:	ff 25 5a 5f 01 00    	jmp    *0x15f5a(%rip)        # 19070 <vsnprintf@GLIBC_2.2.5>
    3116:	68 0e 00 00 00       	push   $0xe
    311b:	e9 00 ff ff ff       	jmp    3020 <_init+0x20>

0000000000003120 <fcntl@plt>:
    3120:	ff 25 52 5f 01 00    	jmp    *0x15f52(%rip)        # 19078 <fcntl@GLIBC_2.2.5>
    3126:	68 0f 00 00 00       	push   $0xf
    312b:	e9 f0 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003130 <clock_gettime@plt>:
    3130:	ff 25 4a 5f 01 00    	jmp    *0x15f4a(%rip)        # 19080 <clock_gettime@GLIBC_2.17>
    3136:	68 10 00 00 00       	push   $0x10
    313b:	e9 e0 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003140 <write@plt>:
    3140:	ff 25 42 5f 01 00    	jmp    *0x15f42(%rip)        # 19088 <write@GLIBC_2.2.5>
    3146:	68 11 00 00 00       	push   $0x11
    314b:	e9 d0 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003150 <fclose@plt>:
    3150:	ff 25 3a 5f 01 00    	jmp    *0x15f3a(%rip)        # 19090 <fclose@GLIBC_2.2.5>
    3156:	68 12 00 00 00       	push   $0x12
    315b:	e9 c0 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003160 <shutdown@plt>:
    3160:	ff 25 32 5f 01 00    	jmp    *0x15f32(%rip)        # 19098 <shutdown@GLIBC_2.2.5>
    3166:	68 13 00 00 00       	push   $0x13
    316b:	e9 b0 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003170 <strlen@plt>:
    3170:	ff 25 2a 5f 01 00    	jmp    *0x15f2a(%rip)        # 190a0 <strlen@GLIBC_2.2.5>
    3176:	68 14 00 00 00       	push   $0x14
    317b:	e9 a0 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003180 <getuid@plt>:
    3180:	ff 25 22 5f 01 00    	jmp    *0x15f22(%rip)        # 190a8 <getuid@GLIBC_2.2.5>
    3186:	68 15 00 00 00       	push   $0x15
    318b:	e9 90 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003190 <mmap@plt>:
    3190:	ff 25 1a 5f 01 00    	jmp    *0x15f1a(%rip)        # 190b0 <mmap@GLIBC_2.2.5>
    3196:	68 16 00 00 00       	push   $0x16
    319b:	e9 80 fe ff ff       	jmp    3020 <_init+0x20>

00000000000031a0 <send@plt>:
    31a0:	ff 25 12 5f 01 00    	jmp    *0x15f12(%rip)        # 190b8 <send@GLIBC_2.2.5>
    31a6:	68 17 00 00 00       	push   $0x17
    31ab:	e9 70 fe ff ff       	jmp    3020 <_init+0x20>

00000000000031b0 <strchr@plt>:
    31b0:	ff 25 0a 5f 01 00    	jmp    *0x15f0a(%rip)        # 190c0 <strchr@GLIBC_2.2.5>
    31b6:	68 18 00 00 00       	push   $0x18
    31bb:	e9 60 fe ff ff       	jmp    3020 <_init+0x20>

00000000000031c0 <printf@plt>:
    31c0:	ff 25 02 5f 01 00    	jmp    *0x15f02(%rip)        # 190c8 <printf@GLIBC_2.2.5>
    31c6:	68 19 00 00 00       	push   $0x19
    31cb:	e9 50 fe ff ff       	jmp    3020 <_init+0x20>

00000000000031d0 <snprintf@plt>:
    31d0:	ff 25 fa 5e 01 00    	jmp    *0x15efa(%rip)        # 190d0 <snprintf@GLIBC_2.2.5>
    31d6:	68 1a 00 00 00       	push   $0x1a
    31db:	e9 40 fe ff ff       	jmp    3020 <_init+0x20>

00000000000031e0 <ftruncate@plt>:
    31e0:	ff 25 f2 5e 01 00    	jmp    *0x15ef2(%rip)        # 190d8 <ftruncate@GLIBC_2.2.5>
    31e6:	68 1b 00 00 00       	push   $0x1b
    31eb:	e9 30 fe ff ff       	jmp    3020 <_init+0x20>

00000000000031f0 <fputs@plt>:
    31f0:	ff 25 ea 5e 01 00    	jmp    *0x15eea(%rip)        # 190e0 <fputs@GLIBC_2.2.5>
    31f6:	68 1c 00 00 00       	push   $0x1c
    31fb:	e9 20 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003200 <strtof@plt>:
    3200:	ff 25 e2 5e 01 00    	jmp    *0x15ee2(%rip)        # 190e8 <strtof@GLIBC_2.2.5>
    3206:	68 1d 00 00 00       	push   $0x1d
    320b:	e9 10 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003210 <memset@plt>:
    3210:	ff 25 da 5e 01 00    	jmp    *0x15eda(%rip)        # 190f0 <memset@GLIBC_2.2.5>
    3216:	68 1e 00 00 00       	push   $0x1e
    321b:	e9 00 fe ff ff       	jmp    3020 <_init+0x20>

0000000000003220 <fgetc@plt>:
    3220:	ff 25 d2 5e 01 00    	jmp    *0x15ed2(%rip)        # 190f8 <fgetc@GLIBC_2.2.5>
    3226:	68 1f 00 00 00       	push   $0x1f
    322b:	e9 f0 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003230 <close@plt>:
    3230:	ff 25 ca 5e 01 00    	jmp    *0x15eca(%rip)        # 19100 <close@GLIBC_2.2.5>
    3236:	68 20 00 00 00       	push   $0x20
    323b:	e9 e0 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003240 <fputc@plt>:
    3240:	ff 25 c2 5e 01 00    	jmp    *0x15ec2(%rip)        # 19108 <fputc@GLIBC_2.2.5>
    3246:	68 21 00 00 00       	push   $0x21
    324b:	e9 d0 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003250 <sched_yield@plt>:
    3250:	ff 25 ba 5e 01 00    	jmp    *0x15eba(%rip)        # 19110 <sched_yield@GLIBC_2.2.5>
    3256:	68 22 00 00 00       	push   $0x22
    325b:	e9 c0 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003260 <memchr@plt>:
    3260:	ff 25 b2 5e 01 00    	jmp    *0x15eb2(%rip)        # 19118 <memchr@GLIBC_2.2.5>
    3266:	68 23 00 00 00       	push   $0x23
    326b:	e9 b0 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003270 <memcmp@plt>:
    3270:	ff 25 aa 5e 01 00    	jmp    *0x15eaa(%rip)        # 19120 <memcmp@GLIBC_2.2.5>
    3276:	68 24 00 00 00       	push   $0x24
    327b:	e9 a0 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003280 <pthread_attr_init@plt>:
    3280:	ff 25 a2 5e 01 00    	jmp    *0x15ea2(%rip)        # 19128 <pthread_attr_init@GLIBC_2.2.5>
    3286:	68 25 00 00 00       	push   $0x25
    328b:	e9 90 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003290 <fgets@plt>:
    3290:	ff 25 9a 5e 01 00    	jmp    *0x15e9a(%rip)        # 19130 <fgets@GLIBC_2.2.5>
    3296:	68 26 00 00 00       	push   $0x26
    329b:	e9 80 fd ff ff       	jmp    3020 <_init+0x20>

00000000000032a0 <getsockopt@plt>:
    32a0:	ff 25 92 5e 01 00    	jmp    *0x15e92(%rip)        # 19138 <getsockopt@GLIBC_2.2.5>
    32a6:	68 27 00 00 00       	push   $0x27
    32ab:	e9 70 fd ff ff       	jmp    3020 <_init+0x20>

00000000000032b0 <_setjmp@plt>:
    32b0:	ff 25 8a 5e 01 00    	jmp    *0x15e8a(%rip)        # 19140 <_setjmp@GLIBC_2.2.5>
    32b6:	68 28 00 00 00       	push   $0x28
    32bb:	e9 60 fd ff ff       	jmp    3020 <_init+0x20>

00000000000032c0 <strtoull@plt>:
    32c0:	ff 25 82 5e 01 00    	jmp    *0x15e82(%rip)        # 19148 <strtoull@GLIBC_2.2.5>
    32c6:	68 29 00 00 00       	push   $0x29
    32cb:	e9 50 fd ff ff       	jmp    3020 <_init+0x20>

00000000000032d0 <strcmp@plt>:
    32d0:	ff 25 7a 5e 01 00    	jmp    *0x15e7a(%rip)        # 19150 <strcmp@GLIBC_2.2.5>
    32d6:	68 2a 00 00 00       	push   $0x2a
    32db:	e9 40 fd ff ff       	jmp    3020 <_init+0x20>

00000000000032e0 <signal@plt>:
    32e0:	ff 25 72 5e 01 00    	jmp    *0x15e72(%rip)        # 19158 <signal@GLIBC_2.2.5>
    32e6:	68 2b 00 00 00       	push   $0x2b
    32eb:	e9 30 fd ff ff       	jmp    3020 <_init+0x20>

00000000000032f0 <fprintf@plt>:
    32f0:	ff 25 6a 5e 01 00    	jmp    *0x15e6a(%rip)        # 19160 <fprintf@GLIBC_2.2.5>
    32f6:	68 2c 00 00 00       	push   $0x2c
    32fb:	e9 20 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003300 <syscall@plt>:
    3300:	ff 25 62 5e 01 00    	jmp    *0x15e62(%rip)        # 19168 <syscall@GLIBC_2.2.5>
    3306:	68 2d 00 00 00       	push   $0x2d
    330b:	e9 10 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003310 <sigemptyset@plt>:
    3310:	ff 25 5a 5e 01 00    	jmp    *0x15e5a(%rip)        # 19170 <sigemptyset@GLIBC_2.2.5>
    3316:	68 2e 00 00 00       	push   $0x2e
    331b:	e9 00 fd ff ff       	jmp    3020 <_init+0x20>

0000000000003320 <strtol@plt>:
    3320:	ff 25 52 5e 01 00    	jmp    *0x15e52(%rip)        # 19178 <strtol@GLIBC_2.2.5>
    3326:	68 2f 00 00 00       	push   $0x2f
    332b:	e9 f0 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003330 <memcpy@plt>:
    3330:	ff 25 4a 5e 01 00    	jmp    *0x15e4a(%rip)        # 19180 <memcpy@GLIBC_2.14>
    3336:	68 30 00 00 00       	push   $0x30
    333b:	e9 e0 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003340 <malloc@plt>:
    3340:	ff 25 42 5e 01 00    	jmp    *0x15e42(%rip)        # 19188 <malloc@GLIBC_2.2.5>
    3346:	68 31 00 00 00       	push   $0x31
    334b:	e9 d0 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003350 <fflush@plt>:
    3350:	ff 25 3a 5e 01 00    	jmp    *0x15e3a(%rip)        # 19190 <fflush@GLIBC_2.2.5>
    3356:	68 32 00 00 00       	push   $0x32
    335b:	e9 c0 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003360 <listen@plt>:
    3360:	ff 25 32 5e 01 00    	jmp    *0x15e32(%rip)        # 19198 <listen@GLIBC_2.2.5>
    3366:	68 33 00 00 00       	push   $0x33
    336b:	e9 b0 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003370 <bcmp@plt>:
    3370:	ff 25 2a 5e 01 00    	jmp    *0x15e2a(%rip)        # 191a0 <bcmp@GLIBC_2.2.5>
    3376:	68 34 00 00 00       	push   $0x34
    337b:	e9 a0 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003380 <realloc@plt>:
    3380:	ff 25 22 5e 01 00    	jmp    *0x15e22(%rip)        # 191a8 <realloc@GLIBC_2.2.5>
    3386:	68 35 00 00 00       	push   $0x35
    338b:	e9 90 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003390 <munmap@plt>:
    3390:	ff 25 1a 5e 01 00    	jmp    *0x15e1a(%rip)        # 191b0 <munmap@GLIBC_2.2.5>
    3396:	68 36 00 00 00       	push   $0x36
    339b:	e9 80 fc ff ff       	jmp    3020 <_init+0x20>

00000000000033a0 <recvmsg@plt>:
    33a0:	ff 25 12 5e 01 00    	jmp    *0x15e12(%rip)        # 191b8 <recvmsg@GLIBC_2.2.5>
    33a6:	68 37 00 00 00       	push   $0x37
    33ab:	e9 70 fc ff ff       	jmp    3020 <_init+0x20>

00000000000033b0 <setvbuf@plt>:
    33b0:	ff 25 0a 5e 01 00    	jmp    *0x15e0a(%rip)        # 191c0 <setvbuf@GLIBC_2.2.5>
    33b6:	68 38 00 00 00       	push   $0x38
    33bb:	e9 60 fc ff ff       	jmp    3020 <_init+0x20>

00000000000033c0 <poll@plt>:
    33c0:	ff 25 02 5e 01 00    	jmp    *0x15e02(%rip)        # 191c8 <poll@GLIBC_2.2.5>
    33c6:	68 39 00 00 00       	push   $0x39
    33cb:	e9 50 fc ff ff       	jmp    3020 <_init+0x20>

00000000000033d0 <bind@plt>:
    33d0:	ff 25 fa 5d 01 00    	jmp    *0x15dfa(%rip)        # 191d0 <bind@GLIBC_2.2.5>
    33d6:	68 3a 00 00 00       	push   $0x3a
    33db:	e9 40 fc ff ff       	jmp    3020 <_init+0x20>

00000000000033e0 <pthread_create@plt>:
    33e0:	ff 25 f2 5d 01 00    	jmp    *0x15df2(%rip)        # 191d8 <pthread_create@GLIBC_2.34>
    33e6:	68 3b 00 00 00       	push   $0x3b
    33eb:	e9 30 fc ff ff       	jmp    3020 <_init+0x20>

00000000000033f0 <madvise@plt>:
    33f0:	ff 25 ea 5d 01 00    	jmp    *0x15dea(%rip)        # 191e0 <madvise@GLIBC_2.2.5>
    33f6:	68 3c 00 00 00       	push   $0x3c
    33fb:	e9 20 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003400 <mprotect@plt>:
    3400:	ff 25 e2 5d 01 00    	jmp    *0x15de2(%rip)        # 191e8 <mprotect@GLIBC_2.2.5>
    3406:	68 3d 00 00 00       	push   $0x3d
    340b:	e9 10 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003410 <fopen@plt>:
    3410:	ff 25 da 5d 01 00    	jmp    *0x15dda(%rip)        # 191f0 <fopen@GLIBC_2.2.5>
    3416:	68 3e 00 00 00       	push   $0x3e
    341b:	e9 00 fc ff ff       	jmp    3020 <_init+0x20>

0000000000003420 <sysconf@plt>:
    3420:	ff 25 d2 5d 01 00    	jmp    *0x15dd2(%rip)        # 191f8 <sysconf@GLIBC_2.2.5>
    3426:	68 3f 00 00 00       	push   $0x3f
    342b:	e9 f0 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003430 <accept@plt>:
    3430:	ff 25 ca 5d 01 00    	jmp    *0x15dca(%rip)        # 19200 <accept@GLIBC_2.2.5>
    3436:	68 40 00 00 00       	push   $0x40
    343b:	e9 e0 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003440 <__cxa_atexit@plt>:
    3440:	ff 25 c2 5d 01 00    	jmp    *0x15dc2(%rip)        # 19208 <__cxa_atexit@GLIBC_2.2.5>
    3446:	68 41 00 00 00       	push   $0x41
    344b:	e9 d0 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003450 <sprintf@plt>:
    3450:	ff 25 ba 5d 01 00    	jmp    *0x15dba(%rip)        # 19210 <sprintf@GLIBC_2.2.5>
    3456:	68 42 00 00 00       	push   $0x42
    345b:	e9 c0 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003460 <exit@plt>:
    3460:	ff 25 b2 5d 01 00    	jmp    *0x15db2(%rip)        # 19218 <exit@GLIBC_2.2.5>
    3466:	68 43 00 00 00       	push   $0x43
    346b:	e9 b0 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003470 <connect@plt>:
    3470:	ff 25 aa 5d 01 00    	jmp    *0x15daa(%rip)        # 19220 <connect@GLIBC_2.2.5>
    3476:	68 44 00 00 00       	push   $0x44
    347b:	e9 a0 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003480 <fwrite@plt>:
    3480:	ff 25 a2 5d 01 00    	jmp    *0x15da2(%rip)        # 19228 <fwrite@GLIBC_2.2.5>
    3486:	68 45 00 00 00       	push   $0x45
    348b:	e9 90 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003490 <getrlimit@plt>:
    3490:	ff 25 9a 5d 01 00    	jmp    *0x15d9a(%rip)        # 19230 <getrlimit@GLIBC_2.2.5>
    3496:	68 46 00 00 00       	push   $0x46
    349b:	e9 80 fb ff ff       	jmp    3020 <_init+0x20>

00000000000034a0 <pthread_join@plt>:
    34a0:	ff 25 92 5d 01 00    	jmp    *0x15d92(%rip)        # 19238 <pthread_join@GLIBC_2.34>
    34a6:	68 47 00 00 00       	push   $0x47
    34ab:	e9 70 fb ff ff       	jmp    3020 <_init+0x20>

00000000000034b0 <sigaltstack@plt>:
    34b0:	ff 25 8a 5d 01 00    	jmp    *0x15d8a(%rip)        # 19240 <sigaltstack@GLIBC_2.2.5>
    34b6:	68 48 00 00 00       	push   $0x48
    34bb:	e9 60 fb ff ff       	jmp    3020 <_init+0x20>

00000000000034c0 <fstat@plt>:
    34c0:	ff 25 82 5d 01 00    	jmp    *0x15d82(%rip)        # 19248 <fstat@GLIBC_2.33>
    34c6:	68 49 00 00 00       	push   $0x49
    34cb:	e9 50 fb ff ff       	jmp    3020 <_init+0x20>

00000000000034d0 <strstr@plt>:
    34d0:	ff 25 7a 5d 01 00    	jmp    *0x15d7a(%rip)        # 19250 <strstr@GLIBC_2.2.5>
    34d6:	68 4a 00 00 00       	push   $0x4a
    34db:	e9 40 fb ff ff       	jmp    3020 <_init+0x20>

00000000000034e0 <__ctype_b_loc@plt>:
    34e0:	ff 25 72 5d 01 00    	jmp    *0x15d72(%rip)        # 19258 <__ctype_b_loc@GLIBC_2.3>
    34e6:	68 4b 00 00 00       	push   $0x4b
    34eb:	e9 30 fb ff ff       	jmp    3020 <_init+0x20>

00000000000034f0 <socket@plt>:
    34f0:	ff 25 6a 5d 01 00    	jmp    *0x15d6a(%rip)        # 19260 <socket@GLIBC_2.2.5>
    34f6:	68 4c 00 00 00       	push   $0x4c
    34fb:	e9 20 fb ff ff       	jmp    3020 <_init+0x20>

0000000000003500 <pthread_attr_setstacksize@plt>:
    3500:	ff 25 62 5d 01 00    	jmp    *0x15d62(%rip)        # 19268 <pthread_attr_setstacksize@GLIBC_2.34>
    3506:	68 4d 00 00 00       	push   $0x4d
    350b:	e9 10 fb ff ff       	jmp    3020 <_init+0x20>

Disassembly of section .plt.got:

0000000000003510 <__cxa_finalize@plt>:
    3510:	ff 25 ba 5a 01 00    	jmp    *0x15aba(%rip)        # 18fd0 <__cxa_finalize@GLIBC_2.2.5>
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
    3538:	48 8d 3d 01 1b 00 00 	lea    0x1b01(%rip),%rdi        # 5040 <main>
    353f:	ff 15 5b 5a 01 00    	call   *0x15a5b(%rip)        # 18fa0 <__libc_start_main@GLIBC_2.34>
    3545:	f4                   	hlt
    3546:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    354d:	00 00 00 

0000000000003550 <deregister_tm_clones>:
    3550:	48 8d 3d 81 77 01 00 	lea    0x17781(%rip),%rdi        # 1acd8 <__TMC_END__>
    3557:	48 8d 05 7a 77 01 00 	lea    0x1777a(%rip),%rax        # 1acd8 <__TMC_END__>
    355e:	48 39 f8             	cmp    %rdi,%rax
    3561:	74 15                	je     3578 <deregister_tm_clones+0x28>
    3563:	48 8b 05 3e 5a 01 00 	mov    0x15a3e(%rip),%rax        # 18fa8 <_ITM_deregisterTMCloneTable@Base>
    356a:	48 85 c0             	test   %rax,%rax
    356d:	74 09                	je     3578 <deregister_tm_clones+0x28>
    356f:	ff e0                	jmp    *%rax
    3571:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    3578:	c3                   	ret
    3579:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000003580 <register_tm_clones>:
    3580:	48 8d 3d 51 77 01 00 	lea    0x17751(%rip),%rdi        # 1acd8 <__TMC_END__>
    3587:	48 8d 35 4a 77 01 00 	lea    0x1774a(%rip),%rsi        # 1acd8 <__TMC_END__>
    358e:	48 29 fe             	sub    %rdi,%rsi
    3591:	48 89 f0             	mov    %rsi,%rax
    3594:	48 c1 ee 3f          	shr    $0x3f,%rsi
    3598:	48 c1 f8 03          	sar    $0x3,%rax
    359c:	48 01 c6             	add    %rax,%rsi
    359f:	48 d1 fe             	sar    $1,%rsi
    35a2:	74 14                	je     35b8 <register_tm_clones+0x38>
    35a4:	48 8b 05 1d 5a 01 00 	mov    0x15a1d(%rip),%rax        # 18fc8 <_ITM_registerTMCloneTable@Base>
    35ab:	48 85 c0             	test   %rax,%rax
    35ae:	74 08                	je     35b8 <register_tm_clones+0x38>
    35b0:	ff e0                	jmp    *%rax
    35b2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    35b8:	c3                   	ret
    35b9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000035c0 <__do_global_dtors_aux>:
    35c0:	f3 0f 1e fa          	endbr64
    35c4:	80 3d 15 77 01 00 00 	cmpb   $0x0,0x17715(%rip)        # 1ace0 <completed.0>
    35cb:	75 2b                	jne    35f8 <__do_global_dtors_aux+0x38>
    35cd:	55                   	push   %rbp
    35ce:	48 83 3d fa 59 01 00 	cmpq   $0x0,0x159fa(%rip)        # 18fd0 <__cxa_finalize@GLIBC_2.2.5>
    35d5:	00 
    35d6:	48 89 e5             	mov    %rsp,%rbp
    35d9:	74 0c                	je     35e7 <__do_global_dtors_aux+0x27>
    35db:	48 8b 3d 96 5c 01 00 	mov    0x15c96(%rip),%rdi        # 19278 <__dso_handle>
    35e2:	e8 29 ff ff ff       	call   3510 <__cxa_finalize@plt>
    35e7:	e8 64 ff ff ff       	call   3550 <deregister_tm_clones>
    35ec:	c6 05 ed 76 01 00 01 	movb   $0x1,0x176ed(%rip)        # 1ace0 <completed.0>
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
    3617:	48 8d 05 e2 50 01 00 	lea    0x150e2(%rip),%rax        # 18700 <fwp_fn_table>
    361e:	48 89 05 cb 76 01 00 	mov    %rax,0x176cb(%rip)        # 1acf0 <fwp_fns>
    3625:	4c 8b 35 84 59 01 00 	mov    0x15984(%rip),%r14        # 18fb0 <stdout@GLIBC_2.2.5>
    362c:	49 8b 06             	mov    (%r14),%rax
    362f:	48 89 05 c2 76 01 00 	mov    %rax,0x176c2(%rip)        # 1acf8 <fwp_prog_out>
    3636:	89 3d c4 76 01 00    	mov    %edi,0x176c4(%rip)        # 1ad00 <fwp_argc>
    363c:	48 89 35 c5 76 01 00 	mov    %rsi,0x176c5(%rip)        # 1ad08 <fwp_argv>
    3643:	48 8d 35 c6 76 01 00 	lea    0x176c6(%rip),%rsi        # 1ad10 <fwp_start_time>
    364a:	bf 01 00 00 00       	mov    $0x1,%edi
    364f:	e8 dc fa ff ff       	call   3130 <clock_gettime@plt>
    3654:	48 8d 3d db 15 01 00 	lea    0x115db(%rip),%rdi        # 14c36 <exec_in_fp0+0x426>
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
    36c6:	48 8b 35 b3 5b 01 00 	mov    0x15bb3(%rip),%rsi        # 19280 <fwp_main_stack>
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
    3716:	48 89 0d 63 5b 01 00 	mov    %rcx,0x15b63(%rip)        # 19280 <fwp_main_stack>
    371d:	e8 3e 00 00 00       	call   3760 <fwp_main_thread>
    3722:	eb 0c                	jmp    3730 <original_main+0x120>
    3724:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    3729:	31 f6                	xor    %esi,%esi
    372b:	e8 70 fd ff ff       	call   34a0 <pthread_join@plt>
    3730:	49 8b 3e             	mov    (%r14),%rdi
    3733:	e8 18 fc ff ff       	call   3350 <fflush@plt>
    3738:	8b 05 e2 75 01 00    	mov    0x175e2(%rip),%eax        # 1ad20 <fwp_exit_code>
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
    376d:	48 81 ec 08 02 00 00 	sub    $0x208,%rsp
    3774:	83 3d f9 6a 01 00 00 	cmpl   $0x0,0x16af9(%rip)        # 1a274 <fwp_gc+0xfec>
    377b:	75 05                	jne    3782 <fwp_main_thread+0x22>
    377d:	e8 8e 46 00 00       	call   7e10 <fwp_gc_init>
    3782:	48 89 2d 87 6b 01 00 	mov    %rbp,0x16b87(%rip)        # 1a310 <fwp_gc+0x1088>
    3789:	48 8d 3d 40 f6 00 00 	lea    0xf640(%rip),%rdi        # 12dd0 <fwp_gc_find_data>
    3790:	31 f6                	xor    %esi,%esi
    3792:	e8 a9 f8 ff ff       	call   3040 <dl_iterate_phdr@plt>
    3797:	83 3d da 6a 01 00 00 	cmpl   $0x0,0x16ada(%rip)        # 1a278 <fwp_gc+0xff0>
    379e:	0f 95 c1             	setne  %cl
    37a1:	83 3d 70 6c 01 00 00 	cmpl   $0x0,0x16c70(%rip)        # 1a418 <fwp_gc+0x1190>
    37a8:	0f 9f c0             	setg   %al
    37ab:	20 c8                	and    %cl,%al
    37ad:	0f b6 c8             	movzbl %al,%ecx
    37b0:	89 0d c6 6a 01 00    	mov    %ecx,0x16ac6(%rip)        # 1a27c <fwp_gc+0xff4>
    37b6:	83 3d c7 6a 01 00 00 	cmpl   $0x0,0x16ac7(%rip)        # 1a284 <fwp_gc+0xffc>
    37bd:	74 16                	je     37d5 <fwp_main_thread+0x75>
    37bf:	48 8d 3d ea f6 00 00 	lea    0xf6ea(%rip),%rdi        # 12eb0 <fwp_gc_report>
    37c6:	e8 f5 fb 00 00       	call   133c0 <atexit>
    37cb:	83 3d aa 6a 01 00 00 	cmpl   $0x0,0x16aaa(%rip)        # 1a27c <fwp_gc+0xff4>
    37d2:	0f 95 c0             	setne  %al
    37d5:	84 c0                	test   %al,%al
    37d7:	74 43                	je     381c <fwp_main_thread+0xbc>
    37d9:	48 83 3d c7 6a 01 00 	cmpq   $0x0,0x16ac7(%rip)        # 1a2a8 <fwp_gc+0x1020>
    37e0:	00 
    37e1:	74 39                	je     381c <fwp_main_thread+0xbc>
    37e3:	48 8b 05 ae 6c 01 00 	mov    0x16cae(%rip),%rax        # 1a498 <fwp_gc+0x1210>
    37ea:	48 2b 05 97 5a 01 00 	sub    0x15a97(%rip),%rax        # 19288 <fwp_gc>
    37f1:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    37f6:	f2 0f 58 05 72 6c 01 	addsd  0x16c72(%rip),%xmm0        # 1a470 <fwp_gc+0x11e8>
    37fd:	00 
    37fe:	f2 0f 11 05 6a 6c 01 	movsd  %xmm0,0x16c6a(%rip)        # 1a470 <fwp_gc+0x11e8>
    3805:	00 
    3806:	48 c7 05 87 6c 01 00 	movq   $0x0,0x16c87(%rip)        # 1a498 <fwp_gc+0x1210>
    380d:	00 00 00 00 
    3811:	48 c7 05 6c 5a 01 00 	movq   $0x0,0x15a6c(%rip)        # 19288 <fwp_gc>
    3818:	00 00 00 00 
    381c:	48 8b 05 5d 5a 01 00 	mov    0x15a5d(%rip),%rax        # 19280 <fwp_main_stack>
    3823:	48 8d 8d 70 ff ff ff 	lea    -0x90(%rbp),%rcx
    382a:	48 89 0d 37 75 01 00 	mov    %rcx,0x17537(%rip)        # 1ad68 <fwp_main_stack_top>
    3831:	48 89 05 38 75 01 00 	mov    %rax,0x17538(%rip)        # 1ad70 <fwp_main_stack_size>
    3838:	48 8d 05 41 75 01 00 	lea    0x17541(%rip),%rax        # 1ad80 <fwp_stack_guard_init.alt>
    383f:	48 89 85 f0 fe ff ff 	mov    %rax,-0x110(%rbp)
    3846:	48 c7 85 00 ff ff ff 	movq   $0x10000,-0x100(%rbp)
    384d:	00 00 01 00 
    3851:	c7 85 f8 fe ff ff 00 	movl   $0x0,-0x108(%rbp)
    3858:	00 00 00 
    385b:	48 8d bd f0 fe ff ff 	lea    -0x110(%rbp),%rdi
    3862:	31 f6                	xor    %esi,%esi
    3864:	e8 47 fc ff ff       	call   34b0 <sigaltstack@plt>
    3869:	85 c0                	test   %eax,%eax
    386b:	0f 85 95 00 00 00    	jne    3906 <fwp_main_thread+0x1a6>
    3871:	48 8d bd f8 fd ff ff 	lea    -0x208(%rbp),%rdi
    3878:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    387c:	66 0f 11 85 78 fe ff 	movupd %xmm0,-0x188(%rbp)
    3883:	ff 
    3884:	66 0f 11 85 68 fe ff 	movupd %xmm0,-0x198(%rbp)
    388b:	ff 
    388c:	66 0f 11 85 58 fe ff 	movupd %xmm0,-0x1a8(%rbp)
    3893:	ff 
    3894:	66 0f 11 85 48 fe ff 	movupd %xmm0,-0x1b8(%rbp)
    389b:	ff 
    389c:	66 0f 11 85 38 fe ff 	movupd %xmm0,-0x1c8(%rbp)
    38a3:	ff 
    38a4:	66 0f 11 85 28 fe ff 	movupd %xmm0,-0x1d8(%rbp)
    38ab:	ff 
    38ac:	66 0f 11 85 18 fe ff 	movupd %xmm0,-0x1e8(%rbp)
    38b3:	ff 
    38b4:	66 0f 11 85 08 fe ff 	movupd %xmm0,-0x1f8(%rbp)
    38bb:	ff 
    38bc:	66 0f 11 85 f8 fd ff 	movupd %xmm0,-0x208(%rbp)
    38c3:	ff 
    38c4:	48 8d 05 a5 72 00 00 	lea    0x72a5(%rip),%rax        # ab70 <fwp_segv>
    38cb:	48 89 85 f0 fd ff ff 	mov    %rax,-0x210(%rbp)
    38d2:	c7 85 78 fe ff ff 04 	movl   $0x8000004,-0x188(%rbp)
    38d9:	00 00 08 
    38dc:	e8 2f fa ff ff       	call   3310 <sigemptyset@plt>
    38e1:	48 8d 9d f0 fd ff ff 	lea    -0x210(%rbp),%rbx
    38e8:	bf 0b 00 00 00       	mov    $0xb,%edi
    38ed:	48 89 de             	mov    %rbx,%rsi
    38f0:	31 d2                	xor    %edx,%edx
    38f2:	e8 e9 f7 ff ff       	call   30e0 <sigaction@plt>
    38f7:	bf 07 00 00 00       	mov    $0x7,%edi
    38fc:	48 89 de             	mov    %rbx,%rsi
    38ff:	31 d2                	xor    %edx,%edx
    3901:	e8 da f7 ff ff       	call   30e0 <sigaction@plt>
    3906:	66 0f 6f 05 12 53 01 	movdqa 0x15312(%rip),%xmm0        # 18c20 <exec_scripts>
    390d:	00 
    390e:	66 0f 7f 05 3a 74 01 	movdqa %xmm0,0x1743a(%rip)        # 1ad50 <fwp_cli_scripts>
    3915:	00 
    3916:	48 8b 05 13 53 01 00 	mov    0x15313(%rip),%rax        # 18c30 <exec_scripts+0x10>
    391d:	48 89 05 3c 74 01 00 	mov    %rax,0x1743c(%rip)        # 1ad60 <fwp_cli_scripts+0x10>
    3924:	4c 63 35 d5 73 01 00 	movslq 0x173d5(%rip),%r14        # 1ad00 <fwp_argc>
    392b:	45 8d 7e ff          	lea    -0x1(%r14),%r15d
    392f:	4c 8b 2d d2 73 01 00 	mov    0x173d2(%rip),%r13        # 1ad08 <fwp_argv>
    3936:	49 83 fe 02          	cmp    $0x2,%r14
    393a:	7c 37                	jl     3973 <fwp_main_thread+0x213>
    393c:	49 8b 5d 08          	mov    0x8(%r13),%rbx
    3940:	48 8d 35 58 1c 01 00 	lea    0x11c58(%rip),%rsi        # 1559f <exec_in_fp0+0xd8f>
    3947:	48 89 df             	mov    %rbx,%rdi
    394a:	e8 81 f9 ff ff       	call   32d0 <strcmp@plt>
    394f:	85 c0                	test   %eax,%eax
    3951:	0f 84 b3 00 00 00    	je     3a0a <fwp_main_thread+0x2aa>
    3957:	48 8d 35 47 1c 01 00 	lea    0x11c47(%rip),%rsi        # 155a5 <exec_in_fp0+0xd95>
    395e:	ba 0d 00 00 00       	mov    $0xd,%edx
    3963:	48 89 df             	mov    %rbx,%rdi
    3966:	e8 25 f7 ff ff       	call   3090 <strncmp@plt>
    396b:	85 c0                	test   %eax,%eax
    396d:	0f 84 23 05 00 00    	je     3e96 <fwp_main_thread+0x736>
    3973:	48 ff 05 ae 73 01 00 	incq   0x173ae(%rip)        # 1ad28 <measured_calls>
    397a:	4e 8d 04 f5 00 00 00 	lea    0x0(,%r14,8),%r8
    3981:	00 
    3982:	4c 01 05 a7 73 01 00 	add    %r8,0x173a7(%rip)        # 1ad30 <measured_bytes>
    3989:	48 8d 35 f8 58 01 00 	lea    0x158f8(%rip),%rsi        # 19288 <fwp_gc>
    3990:	49 81 f8 00 40 00 00 	cmp    $0x4000,%r8
    3997:	4c 89 45 a8          	mov    %r8,-0x58(%rbp)
    399b:	77 5a                	ja     39f7 <fwp_main_thread+0x297>
    399d:	49 8d 40 0f          	lea    0xf(%r8),%rax
    39a1:	48 c1 e8 04          	shr    $0x4,%rax
    39a5:	0f b6 84 30 e8 0b 00 	movzbl 0xbe8(%rax,%rsi,1),%eax
    39ac:	00 
    39ad:	8b 94 86 48 0b 00 00 	mov    0xb48(%rsi,%rax,4),%edx
    39b4:	48 29 15 cd 58 01 00 	sub    %rdx,0x158cd(%rip)        # 19288 <fwp_gc>
    39bb:	78 3a                	js     39f7 <fwp_main_thread+0x297>
    39bd:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
    39c1:	48 8d 0c c6          	lea    (%rsi,%rax,8),%rcx
    39c5:	48 81 c1 88 07 00 00 	add    $0x788,%rcx
    39cc:	48 8b 39             	mov    (%rcx),%rdi
    39cf:	48 85 ff             	test   %rdi,%rdi
    39d2:	74 0b                	je     39df <fwp_main_thread+0x27f>
    39d4:	48 8b 07             	mov    (%rdi),%rax
    39d7:	48 f7 d0             	not    %rax
    39da:	48 89 01             	mov    %rax,(%rcx)
    39dd:	eb 64                	jmp    3a43 <fwp_main_thread+0x2e3>
    39df:	48 8b bc c6 90 07 00 	mov    0x790(%rsi,%rax,8),%rdi
    39e6:	00 
    39e7:	48 8b 8c c6 98 07 00 	mov    0x798(%rsi,%rax,8),%rcx
    39ee:	00 
    39ef:	48 29 f9             	sub    %rdi,%rcx
    39f2:	48 39 d1             	cmp    %rdx,%rcx
    39f5:	73 3b                	jae    3a32 <fwp_main_thread+0x2d2>
    39f7:	4c 89 c7             	mov    %r8,%rdi
    39fa:	be 02 00 00 00       	mov    $0x2,%esi
    39ff:	e8 1c 43 00 00       	call   7d20 <fwp_gc_alloc_slow>
    3a04:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    3a08:	eb 44                	jmp    3a4e <fwp_main_thread+0x2ee>
    3a0a:	48 8b 05 9f 55 01 00 	mov    0x1559f(%rip),%rax        # 18fb0 <stdout@GLIBC_2.2.5>
    3a11:	48 8b 08             	mov    (%rax),%rcx
    3a14:	48 8d 3d 35 0c 01 00 	lea    0x10c35(%rip),%rdi        # 14650 <exec_man>
    3a1b:	be 63 01 00 00       	mov    $0x163,%esi
    3a20:	ba 01 00 00 00       	mov    $0x1,%edx
    3a25:	e8 56 fa ff ff       	call   3480 <fwrite@plt>
    3a2a:	45 31 e4             	xor    %r12d,%r12d
    3a2d:	e9 b6 13 00 00       	jmp    4de8 <fwp_main_thread+0x1688>
    3a32:	48 8d 04 c6          	lea    (%rsi,%rax,8),%rax
    3a36:	48 05 90 07 00 00    	add    $0x790,%rax
    3a3c:	48 8d 0c 17          	lea    (%rdi,%rdx,1),%rcx
    3a40:	48 89 08             	mov    %rcx,(%rax)
    3a43:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    3a47:	31 f6                	xor    %esi,%esi
    3a49:	e8 c2 f7 ff ff       	call   3210 <memset@plt>
    3a4e:	44 89 f8             	mov    %r15d,%eax
    3a51:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    3a55:	4c 89 75 d0          	mov    %r14,-0x30(%rbp)
    3a59:	41 83 fe 02          	cmp    $0x2,%r14d
    3a5d:	4c 8b 75 b8          	mov    -0x48(%rbp),%r14
    3a61:	7c 36                	jl     3a99 <fwp_main_thread+0x339>
    3a63:	31 db                	xor    %ebx,%ebx
    3a65:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    3a6c:	00 00 00 00 
    3a70:	4c 8d 63 01          	lea    0x1(%rbx),%r12
    3a74:	4d 8b 7c dd 08       	mov    0x8(%r13,%rbx,8),%r15
    3a79:	4c 89 ff             	mov    %r15,%rdi
    3a7c:	e8 ef f6 ff ff       	call   3170 <strlen@plt>
    3a81:	4c 89 ff             	mov    %r15,%rdi
    3a84:	48 89 c6             	mov    %rax,%rsi
    3a87:	e8 44 71 00 00       	call   abd0 <fwp_str_lossy>
    3a8c:	49 89 04 de          	mov    %rax,(%r14,%rbx,8)
    3a90:	4c 89 e3             	mov    %r12,%rbx
    3a93:	4c 39 65 c0          	cmp    %r12,-0x40(%rbp)
    3a97:	75 d7                	jne    3a70 <fwp_main_thread+0x310>
    3a99:	4c 8b 3d 88 72 01 00 	mov    0x17288(%rip),%r15        # 1ad28 <measured_calls>
    3aa0:	49 ff c7             	inc    %r15
    3aa3:	4c 89 3d 7e 72 01 00 	mov    %r15,0x1727e(%rip)        # 1ad28 <measured_calls>
    3aaa:	4c 8b 25 7f 72 01 00 	mov    0x1727f(%rip),%r12        # 1ad30 <measured_bytes>
    3ab1:	49 83 c4 08          	add    $0x8,%r12
    3ab5:	4c 89 25 74 72 01 00 	mov    %r12,0x17274(%rip)        # 1ad30 <measured_bytes>
    3abc:	0f b6 05 ae 63 01 00 	movzbl 0x163ae(%rip),%eax        # 19e71 <fwp_gc+0xbe9>
    3ac3:	48 8d 35 be 57 01 00 	lea    0x157be(%rip),%rsi        # 19288 <fwp_gc>
    3aca:	8b 94 86 48 0b 00 00 	mov    0xb48(%rsi,%rax,4),%edx
    3ad1:	48 29 15 b0 57 01 00 	sub    %rdx,0x157b0(%rip)        # 19288 <fwp_gc>
    3ad8:	48 8b 5d d0          	mov    -0x30(%rbp),%rbx
    3adc:	78 3a                	js     3b18 <fwp_main_thread+0x3b8>
    3ade:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
    3ae2:	48 8d 0c c6          	lea    (%rsi,%rax,8),%rcx
    3ae6:	48 81 c1 88 07 00 00 	add    $0x788,%rcx
    3aed:	48 8b 39             	mov    (%rcx),%rdi
    3af0:	48 85 ff             	test   %rdi,%rdi
    3af3:	74 0b                	je     3b00 <fwp_main_thread+0x3a0>
    3af5:	48 8b 07             	mov    (%rdi),%rax
    3af8:	48 f7 d0             	not    %rax
    3afb:	48 89 01             	mov    %rax,(%rcx)
    3afe:	eb 48                	jmp    3b48 <fwp_main_thread+0x3e8>
    3b00:	48 8b bc c6 90 07 00 	mov    0x790(%rsi,%rax,8),%rdi
    3b07:	00 
    3b08:	48 8b 8c c6 98 07 00 	mov    0x798(%rsi,%rax,8),%rcx
    3b0f:	00 
    3b10:	48 29 f9             	sub    %rdi,%rcx
    3b13:	48 39 d1             	cmp    %rdx,%rcx
    3b16:	73 1f                	jae    3b37 <fwp_main_thread+0x3d7>
    3b18:	bf 08 00 00 00       	mov    $0x8,%edi
    3b1d:	be 02 00 00 00       	mov    $0x2,%esi
    3b22:	e8 f9 41 00 00       	call   7d20 <fwp_gc_alloc_slow>
    3b27:	4c 8b 3d fa 71 01 00 	mov    0x171fa(%rip),%r15        # 1ad28 <measured_calls>
    3b2e:	4c 8b 25 fb 71 01 00 	mov    0x171fb(%rip),%r12        # 1ad30 <measured_bytes>
    3b35:	eb 18                	jmp    3b4f <fwp_main_thread+0x3ef>
    3b37:	48 8d 04 c6          	lea    (%rsi,%rax,8),%rax
    3b3b:	48 05 90 07 00 00    	add    $0x790,%rax
    3b41:	48 8d 0c 17          	lea    (%rdi,%rdx,1),%rcx
    3b45:	48 89 08             	mov    %rcx,(%rax)
    3b48:	31 f6                	xor    %esi,%esi
    3b4a:	e8 c1 f6 ff ff       	call   3210 <memset@plt>
    3b4f:	49 ff c7             	inc    %r15
    3b52:	4c 89 3d cf 71 01 00 	mov    %r15,0x171cf(%rip)        # 1ad28 <measured_calls>
    3b59:	49 ff c4             	inc    %r12
    3b5c:	4c 89 25 cd 71 01 00 	mov    %r12,0x171cd(%rip)        # 1ad30 <measured_bytes>
    3b63:	0f b6 0d 07 63 01 00 	movzbl 0x16307(%rip),%ecx        # 19e71 <fwp_gc+0xbe9>
    3b6a:	4c 8d 05 17 57 01 00 	lea    0x15717(%rip),%r8        # 19288 <fwp_gc>
    3b71:	41 8b 84 88 48 0b 00 	mov    0xb48(%r8,%rcx,4),%eax
    3b78:	00 
    3b79:	48 29 05 08 57 01 00 	sub    %rax,0x15708(%rip)        # 19288 <fwp_gc>
    3b80:	78 3d                	js     3bbf <fwp_main_thread+0x45f>
    3b82:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    3b86:	49 8d 14 c8          	lea    (%r8,%rcx,8),%rdx
    3b8a:	48 81 c2 c8 03 00 00 	add    $0x3c8,%rdx
    3b91:	48 8b 32             	mov    (%rdx),%rsi
    3b94:	48 85 f6             	test   %rsi,%rsi
    3b97:	74 0e                	je     3ba7 <fwp_main_thread+0x447>
    3b99:	48 8b 06             	mov    (%rsi),%rax
    3b9c:	48 f7 d0             	not    %rax
    3b9f:	48 89 02             	mov    %rax,(%rdx)
    3ba2:	c6 06 00             	movb   $0x0,(%rsi)
    3ba5:	eb 52                	jmp    3bf9 <fwp_main_thread+0x499>
    3ba7:	49 8b 94 c8 d0 03 00 	mov    0x3d0(%r8,%rcx,8),%rdx
    3bae:	00 
    3baf:	49 8b b4 c8 d8 03 00 	mov    0x3d8(%r8,%rcx,8),%rsi
    3bb6:	00 
    3bb7:	48 29 d6             	sub    %rdx,%rsi
    3bba:	48 39 c6             	cmp    %rax,%rsi
    3bbd:	73 26                	jae    3be5 <fwp_main_thread+0x485>
    3bbf:	bf 01 00 00 00       	mov    $0x1,%edi
    3bc4:	be 01 00 00 00       	mov    $0x1,%esi
    3bc9:	e8 52 41 00 00       	call   7d20 <fwp_gc_alloc_slow>
    3bce:	4c 8d 05 b3 56 01 00 	lea    0x156b3(%rip),%r8        # 19288 <fwp_gc>
    3bd5:	4c 8b 3d 4c 71 01 00 	mov    0x1714c(%rip),%r15        # 1ad28 <measured_calls>
    3bdc:	4c 8b 25 4d 71 01 00 	mov    0x1714d(%rip),%r12        # 1ad30 <measured_bytes>
    3be3:	eb 14                	jmp    3bf9 <fwp_main_thread+0x499>
    3be5:	49 8d 0c c8          	lea    (%r8,%rcx,8),%rcx
    3be9:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
    3bf0:	48 01 d0             	add    %rdx,%rax
    3bf3:	48 89 01             	mov    %rax,(%rcx)
    3bf6:	c6 02 00             	movb   $0x0,(%rdx)
    3bf9:	49 ff c7             	inc    %r15
    3bfc:	48 8b 7d a8          	mov    -0x58(%rbp),%rdi
    3c00:	49 01 fc             	add    %rdi,%r12
    3c03:	4c 89 3d 1e 71 01 00 	mov    %r15,0x1711e(%rip)        # 1ad28 <measured_calls>
    3c0a:	4c 89 25 1f 71 01 00 	mov    %r12,0x1711f(%rip)        # 1ad30 <measured_bytes>
    3c11:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    3c18:	77 5c                	ja     3c76 <fwp_main_thread+0x516>
    3c1a:	48 8d 47 0f          	lea    0xf(%rdi),%rax
    3c1e:	48 c1 e8 04          	shr    $0x4,%rax
    3c22:	42 0f b6 84 00 e8 0b 	movzbl 0xbe8(%rax,%r8,1),%eax
    3c29:	00 00 
    3c2b:	41 8b 94 80 48 0b 00 	mov    0xb48(%r8,%rax,4),%edx
    3c32:	00 
    3c33:	48 29 15 4e 56 01 00 	sub    %rdx,0x1564e(%rip)        # 19288 <fwp_gc>
    3c3a:	78 3a                	js     3c76 <fwp_main_thread+0x516>
    3c3c:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
    3c40:	49 8d 0c c0          	lea    (%r8,%rax,8),%rcx
    3c44:	48 81 c1 88 07 00 00 	add    $0x788,%rcx
    3c4b:	4c 8b 09             	mov    (%rcx),%r9
    3c4e:	4d 85 c9             	test   %r9,%r9
    3c51:	74 0b                	je     3c5e <fwp_main_thread+0x4fe>
    3c53:	49 8b 01             	mov    (%r9),%rax
    3c56:	48 f7 d0             	not    %rax
    3c59:	48 89 01             	mov    %rax,(%rcx)
    3c5c:	eb 38                	jmp    3c96 <fwp_main_thread+0x536>
    3c5e:	4d 8b 8c c0 90 07 00 	mov    0x790(%r8,%rax,8),%r9
    3c65:	00 
    3c66:	49 8b 8c c0 98 07 00 	mov    0x798(%r8,%rax,8),%rcx
    3c6d:	00 
    3c6e:	4c 29 c9             	sub    %r9,%rcx
    3c71:	48 39 d1             	cmp    %rdx,%rcx
    3c74:	73 0f                	jae    3c85 <fwp_main_thread+0x525>
    3c76:	be 02 00 00 00       	mov    $0x2,%esi
    3c7b:	e8 a0 40 00 00       	call   7d20 <fwp_gc_alloc_slow>
    3c80:	49 89 c1             	mov    %rax,%r9
    3c83:	eb 21                	jmp    3ca6 <fwp_main_thread+0x546>
    3c85:	49 8d 04 c0          	lea    (%r8,%rax,8),%rax
    3c89:	48 05 90 07 00 00    	add    $0x790,%rax
    3c8f:	49 8d 0c 11          	lea    (%r9,%rdx,1),%rcx
    3c93:	48 89 08             	mov    %rcx,(%rax)
    3c96:	4c 89 cf             	mov    %r9,%rdi
    3c99:	31 f6                	xor    %esi,%esi
    3c9b:	4d 89 ce             	mov    %r9,%r14
    3c9e:	e8 6d f5 ff ff       	call   3210 <memset@plt>
    3ca3:	4d 89 f1             	mov    %r14,%r9
    3ca6:	45 31 db             	xor    %r11d,%r11d
    3ca9:	83 fb 02             	cmp    $0x2,%ebx
    3cac:	48 8d 35 d5 55 01 00 	lea    0x155d5(%rip),%rsi        # 19288 <fwp_gc>
    3cb3:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
    3cb7:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
    3cbb:	0f 8c 58 01 00 00    	jl     3e19 <fwp_main_thread+0x6b9>
    3cc1:	4d 89 c2             	mov    %r8,%r10
    3cc4:	49 f7 da             	neg    %r10
    3cc7:	b3 01                	mov    $0x1,%bl
    3cc9:	45 31 db             	xor    %r11d,%r11d
    3ccc:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    3cd2:	45 31 ed             	xor    %r13d,%r13d
    3cd5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    3cdc:	00 00 00 00 
    3ce0:	4e 8b 64 fa f8       	mov    -0x8(%rdx,%r15,8),%r12
    3ce5:	45 85 ed             	test   %r13d,%r13d
    3ce8:	0f 85 d2 00 00 00    	jne    3dc0 <fwp_main_thread+0x660>
    3cee:	4d 8b 34 24          	mov    (%r12),%r14
    3cf2:	49 83 fe 02          	cmp    $0x2,%r14
    3cf6:	0f 82 c4 00 00 00    	jb     3dc0 <fwp_main_thread+0x660>
    3cfc:	41 80 7c 24 08 2d    	cmpb   $0x2d,0x8(%r12)
    3d02:	0f 85 b8 00 00 00    	jne    3dc0 <fwp_main_thread+0x660>
    3d08:	41 0f b6 44 24 09    	movzbl 0x9(%r12),%eax
    3d0e:	3c 2e                	cmp    $0x2e,%al
    3d10:	0f 84 aa 00 00 00    	je     3dc0 <fwp_main_thread+0x660>
    3d16:	8d 48 d0             	lea    -0x30(%rax),%ecx
    3d19:	80 f9 0a             	cmp    $0xa,%cl
    3d1c:	0f 82 9e 00 00 00    	jb     3dc0 <fwp_main_thread+0x660>
    3d22:	49 83 fe 02          	cmp    $0x2,%r14
    3d26:	75 0f                	jne    3d37 <fwp_main_thread+0x5d7>
    3d28:	3c 2d                	cmp    $0x2d,%al
    3d2a:	75 0b                	jne    3d37 <fwp_main_thread+0x5d7>
    3d2c:	41 bd 01 00 00 00    	mov    $0x1,%r13d
    3d32:	e9 93 00 00 00       	jmp    3dca <fwp_main_thread+0x66a>
    3d37:	3c 2d                	cmp    $0x2d,%al
    3d39:	75 70                	jne    3dab <fwp_main_thread+0x64b>
    3d3b:	49 8d 7c 24 0a       	lea    0xa(%r12),%rdi
    3d40:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
    3d47:	49 83 c6 fe          	add    $0xfffffffffffffffe,%r14
    3d4b:	44 89 5d d0          	mov    %r11d,-0x30(%rbp)
    3d4f:	be 3d 00 00 00       	mov    $0x3d,%esi
    3d54:	4c 89 f2             	mov    %r14,%rdx
    3d57:	4c 89 4d a8          	mov    %r9,-0x58(%rbp)
    3d5b:	4c 89 95 60 ff ff ff 	mov    %r10,-0xa0(%rbp)
    3d62:	e8 f9 f4 ff ff       	call   3260 <memchr@plt>
    3d67:	48 8b bd 68 ff ff ff 	mov    -0x98(%rbp),%rdi
    3d6e:	4c 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%r10
    3d75:	4c 8b 4d a8          	mov    -0x58(%rbp),%r9
    3d79:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
    3d7d:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
    3d81:	44 8b 5d d0          	mov    -0x30(%rbp),%r11d
    3d85:	48 8d 35 fc 54 01 00 	lea    0x154fc(%rip),%rsi        # 19288 <fwp_gc>
    3d8c:	48 89 c1             	mov    %rax,%rcx
    3d8f:	48 29 f9             	sub    %rdi,%rcx
    3d92:	48 85 c0             	test   %rax,%rax
    3d95:	49 0f 44 ce          	cmove  %r14,%rcx
    3d99:	75 25                	jne    3dc0 <fwp_main_thread+0x660>
    3d9b:	48 83 f9 04          	cmp    $0x4,%rcx
    3d9f:	75 1f                	jne    3dc0 <fwp_main_thread+0x660>
    3da1:	81 3f 68 65 6c 70    	cmpl   $0x706c6568,(%rdi)
    3da7:	75 17                	jne    3dc0 <fwp_main_thread+0x660>
    3da9:	eb 39                	jmp    3de4 <fwp_main_thread+0x684>
    3dab:	49 83 fe 02          	cmp    $0x2,%r14
    3daf:	75 0f                	jne    3dc0 <fwp_main_thread+0x660>
    3db1:	3c 68                	cmp    $0x68,%al
    3db3:	74 2f                	je     3de4 <fwp_main_thread+0x684>
    3db5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    3dbc:	00 00 00 00 
    3dc0:	49 63 c3             	movslq %r11d,%rax
    3dc3:	41 ff c3             	inc    %r11d
    3dc6:	4d 89 24 c1          	mov    %r12,(%r9,%rax,8)
    3dca:	4d 39 c7             	cmp    %r8,%r15
    3dcd:	0f 92 c3             	setb   %bl
    3dd0:	4b 8d 04 3a          	lea    (%r10,%r15,1),%rax
    3dd4:	48 ff c0             	inc    %rax
    3dd7:	49 ff c7             	inc    %r15
    3dda:	48 83 f8 01          	cmp    $0x1,%rax
    3dde:	0f 85 fc fe ff ff    	jne    3ce0 <fwp_main_thread+0x580>
    3de4:	f6 c3 01             	test   $0x1,%bl
    3de7:	74 30                	je     3e19 <fwp_main_thread+0x6b9>
    3de9:	48 8b 1d c0 51 01 00 	mov    0x151c0(%rip),%rbx        # 18fb0 <stdout@GLIBC_2.2.5>
    3df0:	48 8b 0b             	mov    (%rbx),%rcx
    3df3:	48 8d 3d 1d 1a 01 00 	lea    0x11a1d(%rip),%rdi        # 15817 <exec_in_fp0+0x1007>
    3dfa:	be 82 00 00 00       	mov    $0x82,%esi
    3dff:	ba 01 00 00 00       	mov    $0x1,%edx
    3e04:	e8 77 f6 ff ff       	call   3480 <fwrite@plt>
    3e09:	48 8b 3b             	mov    (%rbx),%rdi
    3e0c:	e8 3f f5 ff ff       	call   3350 <fflush@plt>
    3e11:	45 31 e4             	xor    %r12d,%r12d
    3e14:	e9 cf 0f 00 00       	jmp    4de8 <fwp_main_thread+0x1688>
    3e19:	48 ff 05 08 6f 01 00 	incq   0x16f08(%rip)        # 1ad28 <measured_calls>
    3e20:	48 83 05 08 6f 01 00 	addq   $0x10,0x16f08(%rip)        # 1ad30 <measured_bytes>
    3e27:	10 
    3e28:	0f b6 05 42 60 01 00 	movzbl 0x16042(%rip),%eax        # 19e71 <fwp_gc+0xbe9>
    3e2f:	8b 94 86 48 0b 00 00 	mov    0xb48(%rsi,%rax,4),%edx
    3e36:	48 29 15 4b 54 01 00 	sub    %rdx,0x1544b(%rip)        # 19288 <fwp_gc>
    3e3d:	45 89 dc             	mov    %r11d,%r12d
    3e40:	78 3d                	js     3e7f <fwp_main_thread+0x71f>
    3e42:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
    3e46:	48 8d 0c c6          	lea    (%rsi,%rax,8),%rcx
    3e4a:	48 81 c1 88 07 00 00 	add    $0x788,%rcx
    3e51:	48 8b 19             	mov    (%rcx),%rbx
    3e54:	48 85 db             	test   %rbx,%rbx
    3e57:	74 0e                	je     3e67 <fwp_main_thread+0x707>
    3e59:	4d 89 ce             	mov    %r9,%r14
    3e5c:	48 8b 03             	mov    (%rbx),%rax
    3e5f:	48 f7 d0             	not    %rax
    3e62:	48 89 01             	mov    %rax,(%rcx)
    3e65:	eb 61                	jmp    3ec8 <fwp_main_thread+0x768>
    3e67:	48 8b 9c c6 90 07 00 	mov    0x790(%rsi,%rax,8),%rbx
    3e6e:	00 
    3e6f:	48 8b 8c c6 98 07 00 	mov    0x798(%rsi,%rax,8),%rcx
    3e76:	00 
    3e77:	48 29 d9             	sub    %rbx,%rcx
    3e7a:	48 39 d1             	cmp    %rdx,%rcx
    3e7d:	73 35                	jae    3eb4 <fwp_main_thread+0x754>
    3e7f:	4d 89 ce             	mov    %r9,%r14
    3e82:	bf 10 00 00 00       	mov    $0x10,%edi
    3e87:	be 02 00 00 00       	mov    $0x2,%esi
    3e8c:	e8 8f 3e 00 00       	call   7d20 <fwp_gc_alloc_slow>
    3e91:	48 89 c3             	mov    %rax,%rbx
    3e94:	eb 3c                	jmp    3ed2 <fwp_main_thread+0x772>
    3e96:	0f b6 43 0d          	movzbl 0xd(%rbx),%eax
    3e9a:	85 c0                	test   %eax,%eax
    3e9c:	0f 84 05 0c 00 00    	je     4aa7 <fwp_main_thread+0x1347>
    3ea2:	83 f8 3d             	cmp    $0x3d,%eax
    3ea5:	0f 85 c8 fa ff ff    	jne    3973 <fwp_main_thread+0x213>
    3eab:	48 83 c3 0e          	add    $0xe,%rbx
    3eaf:	e9 01 0c 00 00       	jmp    4ab5 <fwp_main_thread+0x1355>
    3eb4:	4d 89 ce             	mov    %r9,%r14
    3eb7:	48 8d 04 c6          	lea    (%rsi,%rax,8),%rax
    3ebb:	48 05 90 07 00 00    	add    $0x790,%rax
    3ec1:	48 8d 0c 13          	lea    (%rbx,%rdx,1),%rcx
    3ec5:	48 89 08             	mov    %rcx,(%rax)
    3ec8:	48 89 df             	mov    %rbx,%rdi
    3ecb:	31 f6                	xor    %esi,%esi
    3ecd:	e8 3e f3 ff ff       	call   3210 <memset@plt>
    3ed2:	44 89 e0             	mov    %r12d,%eax
    3ed5:	41 83 fc 01          	cmp    $0x1,%r12d
    3ed9:	0f 87 fa 0c 00 00    	ja     4bd9 <fwp_main_thread+0x1479>
    3edf:	0f 85 95 00 00 00    	jne    3f7a <fwp_main_thread+0x81a>
    3ee5:	4d 8b 36             	mov    (%r14),%r14
    3ee8:	4d 8b 3e             	mov    (%r14),%r15
    3eeb:	49 83 c6 08          	add    $0x8,%r14
    3eef:	4c 89 b5 f0 fd ff ff 	mov    %r14,-0x210(%rbp)
    3ef6:	4c 89 bd f8 fd ff ff 	mov    %r15,-0x208(%rbp)
    3efd:	48 c7 85 00 fe ff ff 	movq   $0x0,-0x200(%rbp)
    3f04:	00 00 00 00 
    3f08:	48 8d 35 41 4e 01 00 	lea    0x14e41(%rip),%rsi        # 18d50 <d3>
    3f0f:	48 8d bd f0 fd ff ff 	lea    -0x210(%rbp),%rdi
    3f16:	ba 01 00 00 00       	mov    $0x1,%edx
    3f1b:	48 89 d9             	mov    %rbx,%rcx
    3f1e:	e8 2d 93 00 00       	call   d250 <tp_value>
    3f23:	85 c0                	test   %eax,%eax
    3f25:	0f 84 0f 0d 00 00    	je     4c3a <fwp_main_thread+0x14da>
    3f2b:	48 8b 85 f8 fd ff ff 	mov    -0x208(%rbp),%rax
    3f32:	48 8b 8d 00 fe ff ff 	mov    -0x200(%rbp),%rcx
    3f39:	48 39 c1             	cmp    %rax,%rcx
    3f3c:	73 33                	jae    3f71 <fwp_main_thread+0x811>
    3f3e:	48 8b 95 f0 fd ff ff 	mov    -0x210(%rbp),%rdx
    3f45:	48 be 00 26 00 00 01 	movabs $0x100002600,%rsi
    3f4c:	00 00 00 
    3f4f:	90                   	nop
    3f50:	0f b6 3c 0a          	movzbl (%rdx,%rcx,1),%edi
    3f54:	48 83 ff 20          	cmp    $0x20,%rdi
    3f58:	77 17                	ja     3f71 <fwp_main_thread+0x811>
    3f5a:	48 0f a3 fe          	bt     %rdi,%rsi
    3f5e:	73 11                	jae    3f71 <fwp_main_thread+0x811>
    3f60:	48 ff c1             	inc    %rcx
    3f63:	48 89 8d 00 fe ff ff 	mov    %rcx,-0x200(%rbp)
    3f6a:	48 39 c8             	cmp    %rcx,%rax
    3f6d:	75 e1                	jne    3f50 <fwp_main_thread+0x7f0>
    3f6f:	eb 09                	jmp    3f7a <fwp_main_thread+0x81a>
    3f71:	48 39 c1             	cmp    %rax,%rcx
    3f74:	0f 85 c0 0c 00 00    	jne    4c3a <fwp_main_thread+0x14da>
    3f7a:	48 8d 3d 24 15 01 00 	lea    0x11524(%rip),%rdi        # 154a5 <exec_in_fp0+0xc95>
    3f81:	e8 aa f0 ff ff       	call   3030 <getenv@plt>
    3f86:	48 85 c0             	test   %rax,%rax
    3f89:	74 27                	je     3fb2 <fwp_main_thread+0x852>
    3f8b:	48 8d 35 1b 15 01 00 	lea    0x1151b(%rip),%rsi        # 154ad <exec_in_fp0+0xc9d>
    3f92:	48 89 c7             	mov    %rax,%rdi
    3f95:	e8 36 f3 ff ff       	call   32d0 <strcmp@plt>
    3f9a:	31 c9                	xor    %ecx,%ecx
    3f9c:	85 c0                	test   %eax,%eax
    3f9e:	0f 94 c1             	sete   %cl
    3fa1:	89 0d d9 6d 02 00    	mov    %ecx,0x26dd9(%rip)        # 2ad80 <fwp_exec_binary_out>
    3fa7:	75 29                	jne    3fd2 <fwp_main_thread+0x872>
    3fa9:	48 8b 05 28 50 01 00 	mov    0x15028(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    3fb0:	eb 27                	jmp    3fd9 <fwp_main_thread+0x879>
    3fb2:	c7 05 c4 6d 02 00 00 	movl   $0x0,0x26dc4(%rip)        # 2ad80 <fwp_exec_binary_out>
    3fb9:	00 00 00 
    3fbc:	48 8b 05 ed 4f 01 00 	mov    0x14fed(%rip),%rax        # 18fb0 <stdout@GLIBC_2.2.5>
    3fc3:	48 8b 00             	mov    (%rax),%rax
    3fc6:	48 89 05 2b 6d 01 00 	mov    %rax,0x16d2b(%rip)        # 1acf8 <fwp_prog_out>
    3fcd:	44 89 e1             	mov    %r12d,%ecx
    3fd0:	eb 1a                	jmp    3fec <fwp_main_thread+0x88c>
    3fd2:	48 8b 05 d7 4f 01 00 	mov    0x14fd7(%rip),%rax        # 18fb0 <stdout@GLIBC_2.2.5>
    3fd9:	44 89 e1             	mov    %r12d,%ecx
    3fdc:	48 8b 00             	mov    (%rax),%rax
    3fdf:	48 89 05 12 6d 01 00 	mov    %rax,0x16d12(%rip)        # 1acf8 <fwp_prog_out>
    3fe6:	0f 84 ce 00 00 00    	je     40ba <fwp_main_thread+0x95a>
    3fec:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%rbp)
    3ff3:	85 c9                	test   %ecx,%ecx
    3ff5:	7e 3b                	jle    4032 <fwp_main_thread+0x8d2>
    3ff7:	48 8d 75 cc          	lea    -0x34(%rbp),%rsi
    3ffb:	48 89 df             	mov    %rbx,%rdi
    3ffe:	e8 7d 75 00 00       	call   b580 <fwp_exec_call>
    4003:	48 89 c3             	mov    %rax,%rbx
    4006:	48 8b 3d eb 6c 01 00 	mov    0x16ceb(%rip),%rdi        # 1acf8 <fwp_prog_out>
    400d:	e8 3e f3 ff ff       	call   3350 <fflush@plt>
    4012:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    4018:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
    401c:	0f 85 66 09 00 00    	jne    4988 <fwp_main_thread+0x1228>
    4022:	48 89 df             	mov    %rbx,%rdi
    4025:	e8 96 77 00 00       	call   b7c0 <fwp_emit_result>
    402a:	45 31 e4             	xor    %r12d,%r12d
    402d:	e9 56 09 00 00       	jmp    4988 <fwp_main_thread+0x1228>
    4032:	4c 8b 35 7f 4f 01 00 	mov    0x14f7f(%rip),%r14        # 18fb8 <stdin@GLIBC_2.2.5>
    4039:	49 8b 3e             	mov    (%r14),%rdi
    403c:	b9 00 00 10 00       	mov    $0x100000,%ecx
    4041:	31 f6                	xor    %esi,%esi
    4043:	31 d2                	xor    %edx,%edx
    4045:	e8 66 f3 ff ff       	call   33b0 <setvbuf@plt>
    404a:	49 8b 0e             	mov    (%r14),%rcx
    404d:	48 8d 3d 30 6d 02 00 	lea    0x26d30(%rip),%rdi        # 2ad84 <fwp_in_pend>
    4054:	be 01 00 00 00       	mov    $0x1,%esi
    4059:	ba 04 00 00 00       	mov    $0x4,%edx
    405e:	e8 8d f0 ff ff       	call   30f0 <fread@plt>
    4063:	89 05 1f 6d 02 00    	mov    %eax,0x26d1f(%rip)        # 2ad88 <fwp_in_npend>
    4069:	c7 05 19 6d 02 00 00 	movl   $0x0,0x26d19(%rip)        # 2ad8c <fwp_in_ppos>
    4070:	00 00 00 
    4073:	b1 01                	mov    $0x1,%cl
    4075:	89 4d c0             	mov    %ecx,-0x40(%rbp)
    4078:	83 f8 04             	cmp    $0x4,%eax
    407b:	48 89 5d b8          	mov    %rbx,-0x48(%rbp)
    407f:	75 10                	jne    4091 <fwp_main_thread+0x931>
    4081:	81 3d f9 6c 02 00 46 	cmpl   $0x31505746,0x26cf9(%rip)        # 2ad84 <fwp_in_pend>
    4088:	57 50 31 
    408b:	0f 84 b2 0a 00 00    	je     4b43 <fwp_main_thread+0x13e3>
    4091:	66 0f ef c0          	pxor   %xmm0,%xmm0
    4095:	66 0f 7f 45 90       	movdqa %xmm0,-0x70(%rbp)
    409a:	48 c7 45 a0 00 00 00 	movq   $0x0,-0x60(%rbp)
    40a1:	00 
    40a2:	49 bc 00 26 00 00 01 	movabs $0x100002600,%r12
    40a9:	00 00 00 
    40ac:	45 31 ed             	xor    %r13d,%r13d
    40af:	31 c0                	xor    %eax,%eax
    40b1:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    40b5:	e9 0f 02 00 00       	jmp    42c9 <fwp_main_thread+0xb69>
    40ba:	48 8d b5 f0 fd ff ff 	lea    -0x210(%rbp),%rsi
    40c1:	bf 01 00 00 00       	mov    $0x1,%edi
    40c6:	e8 f5 f3 ff ff       	call   34c0 <fstat@plt>
    40cb:	85 c0                	test   %eax,%eax
    40cd:	0f 85 10 01 00 00    	jne    41e3 <fwp_main_thread+0xa83>
    40d3:	b8 00 f0 00 00       	mov    $0xf000,%eax
    40d8:	23 85 08 fe ff ff    	and    -0x1f8(%rbp),%eax
    40de:	3d 00 10 00 00       	cmp    $0x1000,%eax
    40e3:	0f 85 fa 00 00 00    	jne    41e3 <fwp_main_thread+0xa83>
    40e9:	bf 01 00 00 00       	mov    $0x1,%edi
    40ee:	be 07 04 00 00       	mov    $0x407,%esi
    40f3:	ba 00 00 10 00       	mov    $0x100000,%edx
    40f8:	31 c0                	xor    %eax,%eax
    40fa:	e8 21 f0 ff ff       	call   3120 <fcntl@plt>
    40ff:	48 8d 3d a6 15 01 00 	lea    0x115a6(%rip),%rdi        # 156ac <exec_in_fp0+0xe9c>
    4106:	e8 25 ef ff ff       	call   3030 <getenv@plt>
    410b:	48 85 c0             	test   %rax,%rax
    410e:	74 17                	je     4127 <fwp_main_thread+0x9c7>
    4110:	48 8d 35 a3 15 01 00 	lea    0x115a3(%rip),%rsi        # 156ba <exec_in_fp0+0xeaa>
    4117:	48 89 c7             	mov    %rax,%rdi
    411a:	e8 b1 f1 ff ff       	call   32d0 <strcmp@plt>
    411f:	85 c0                	test   %eax,%eax
    4121:	0f 84 bc 00 00 00    	je     41e3 <fwp_main_thread+0xa83>
    4127:	bf 01 00 00 00       	mov    $0x1,%edi
    412c:	be 01 08 08 00       	mov    $0x80801,%esi
    4131:	31 d2                	xor    %edx,%edx
    4133:	e8 b8 f3 ff ff       	call   34f0 <socket@plt>
    4138:	85 c0                	test   %eax,%eax
    413a:	0f 88 a3 00 00 00    	js     41e3 <fwp_main_thread+0xa83>
    4140:	41 89 c6             	mov    %eax,%r14d
    4143:	66 0f ef c0          	pxor   %xmm0,%xmm0
    4147:	f3 0f 7f 85 4e ff ff 	movdqu %xmm0,-0xb2(%rbp)
    414e:	ff 
    414f:	f3 0f 7f 85 42 ff ff 	movdqu %xmm0,-0xbe(%rbp)
    4156:	ff 
    4157:	f3 0f 7f 85 32 ff ff 	movdqu %xmm0,-0xce(%rbp)
    415e:	ff 
    415f:	f3 0f 7f 85 22 ff ff 	movdqu %xmm0,-0xde(%rbp)
    4166:	ff 
    4167:	f3 0f 7f 85 12 ff ff 	movdqu %xmm0,-0xee(%rbp)
    416e:	ff 
    416f:	f3 0f 7f 85 02 ff ff 	movdqu %xmm0,-0xfe(%rbp)
    4176:	ff 
    4177:	f3 0f 7f 85 f2 fe ff 	movdqu %xmm0,-0x10e(%rbp)
    417e:	ff 
    417f:	66 c7 85 f0 fe ff ff 	movw   $0x1,-0x110(%rbp)
    4186:	01 00 
    4188:	48 8d bd f3 fe ff ff 	lea    -0x10d(%rbp),%rdi
    418f:	48 8b 8d f0 fd ff ff 	mov    -0x210(%rbp),%rcx
    4196:	4c 8b 85 f8 fd ff ff 	mov    -0x208(%rbp),%r8
    419d:	48 8d 15 1c 15 01 00 	lea    0x1151c(%rip),%rdx        # 156c0 <exec_in_fp0+0xeb0>
    41a4:	be 6b 00 00 00       	mov    $0x6b,%esi
    41a9:	31 c0                	xor    %eax,%eax
    41ab:	e8 20 f0 ff ff       	call   31d0 <snprintf@plt>
    41b0:	8d 50 03             	lea    0x3(%rax),%edx
    41b3:	48 8d b5 f0 fe ff ff 	lea    -0x110(%rbp),%rsi
    41ba:	44 89 f7             	mov    %r14d,%edi
    41bd:	e8 0e f2 ff ff       	call   33d0 <bind@plt>
    41c2:	85 c0                	test   %eax,%eax
    41c4:	75 15                	jne    41db <fwp_main_thread+0xa7b>
    41c6:	44 89 f7             	mov    %r14d,%edi
    41c9:	be 01 00 00 00       	mov    $0x1,%esi
    41ce:	e8 8d f1 ff ff       	call   3360 <listen@plt>
    41d3:	85 c0                	test   %eax,%eax
    41d5:	0f 84 5f 0d 00 00    	je     4f3a <fwp_main_thread+0x17da>
    41db:	44 89 f7             	mov    %r14d,%edi
    41de:	e8 4d f0 ff ff       	call   3230 <close@plt>
    41e3:	48 8d 3d f6 05 01 00 	lea    0x105f6(%rip),%rdi        # 147e0 <exec_out_header0>
    41ea:	be 30 00 00 00       	mov    $0x30,%esi
    41ef:	e8 6c 6e 00 00       	call   b060 <fwp_pipe_write>
    41f4:	e8 c7 72 00 00       	call   b4c0 <fwp_pipe_flush>
    41f9:	48 8d 3d e6 14 01 00 	lea    0x114e6(%rip),%rdi        # 156e6 <exec_in_fp0+0xed6>
    4200:	e8 2b ee ff ff       	call   3030 <getenv@plt>
    4205:	48 85 c0             	test   %rax,%rax
    4208:	44 89 e1             	mov    %r12d,%ecx
    420b:	0f 84 db fd ff ff    	je     3fec <fwp_main_thread+0x88c>
    4211:	83 3d a8 6a 01 00 00 	cmpl   $0x0,0x16aa8(%rip)        # 1acc0 <fwp_po_listen>
    4218:	0f 88 ce fd ff ff    	js     3fec <fwp_main_thread+0x88c>
    421e:	80 38 00             	cmpb   $0x0,(%rax)
    4221:	0f 84 c5 fd ff ff    	je     3fec <fwp_main_thread+0x88c>
    4227:	48 89 c7             	mov    %rax,%rdi
    422a:	31 f6                	xor    %esi,%esi
    422c:	ba 0a 00 00 00       	mov    $0xa,%edx
    4231:	e8 ea f0 ff ff       	call   3320 <strtol@plt>
    4236:	8b 0d 84 6a 01 00    	mov    0x16a84(%rip),%ecx        # 1acc0 <fwp_po_listen>
    423c:	89 8d f0 fd ff ff    	mov    %ecx,-0x210(%rbp)
    4242:	48 b9 01 00 00 00 01 	movabs $0x100000001,%rcx
    4249:	00 00 00 
    424c:	48 89 8d f4 fd ff ff 	mov    %rcx,-0x20c(%rbp)
    4253:	c7 85 fc fd ff ff 00 	movl   $0x0,-0x204(%rbp)
    425a:	00 00 00 
    425d:	48 85 c0             	test   %rax,%rax
    4260:	0f 8e 67 fd ff ff    	jle    3fcd <fwp_main_thread+0x86d>
    4266:	48 3d ff ff ff 7f    	cmp    $0x7fffffff,%rax
    426c:	ba ff ff ff 7f       	mov    $0x7fffffff,%edx
    4271:	48 0f 4c d0          	cmovl  %rax,%rdx
    4275:	48 8d bd f0 fd ff ff 	lea    -0x210(%rbp),%rdi
    427c:	be 02 00 00 00       	mov    $0x2,%esi
    4281:	e8 3a f1 ff ff       	call   33c0 <poll@plt>
    4286:	85 c0                	test   %eax,%eax
    4288:	0f 8e 3f fd ff ff    	jle    3fcd <fwp_main_thread+0x86d>
    428e:	f6 85 f6 fd ff ff 01 	testb  $0x1,-0x20a(%rbp)
    4295:	0f 84 32 fd ff ff    	je     3fcd <fwp_main_thread+0x86d>
    429b:	48 c7 05 1a 6b 03 00 	movq   $0x0,0x36b1a(%rip)        # 3adc0 <fwp_po_next_check>
    42a2:	00 00 00 00 
    42a6:	e8 15 c3 00 00       	call   105c0 <fwp_pipe_poll>
    42ab:	e9 1d fd ff ff       	jmp    3fcd <fwp_main_thread+0x86d>
    42b0:	bb 10 00 00 00       	mov    $0x10,%ebx
    42b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    42bc:	00 00 00 00 
    42c0:	83 fb 0f             	cmp    $0xf,%ebx
    42c3:	0f 84 b2 06 00 00    	je     497b <fwp_main_thread+0x121b>
    42c9:	80 7d c0 00          	cmpb   $0x0,-0x40(%rbp)
    42cd:	74 41                	je     4310 <fwp_main_thread+0xbb0>
    42cf:	48 c7 45 98 00 00 00 	movq   $0x0,-0x68(%rbp)
    42d6:	00 
    42d7:	48 63 05 ae 6a 02 00 	movslq 0x26aae(%rip),%rax        # 2ad8c <fwp_in_ppos>
    42de:	3b 05 a4 6a 02 00    	cmp    0x26aa4(%rip),%eax        # 2ad88 <fwp_in_npend>
    42e4:	0f 8d d6 00 00 00    	jge    43c0 <fwp_main_thread+0xc60>
    42ea:	8d 48 01             	lea    0x1(%rax),%ecx
    42ed:	89 0d 99 6a 02 00    	mov    %ecx,0x26a99(%rip)        # 2ad8c <fwp_in_ppos>
    42f3:	48 8d 0d 8a 6a 02 00 	lea    0x26a8a(%rip),%rcx        # 2ad84 <fwp_in_pend>
    42fa:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax
    42fe:	83 f8 0a             	cmp    $0xa,%eax
    4301:	0f 85 d1 00 00 00    	jne    43d8 <fwp_main_thread+0xc78>
    4307:	e9 84 01 00 00       	jmp    4490 <fwp_main_thread+0xd30>
    430c:	0f 1f 40 00          	nopl   0x0(%rax)
    4310:	be 01 00 00 00       	mov    $0x1,%esi
    4315:	48 8d 7d b2          	lea    -0x4e(%rbp),%rdi
    4319:	e8 72 76 00 00       	call   b990 <fwp_read_exact>
    431e:	bb 0f 00 00 00       	mov    $0xf,%ebx
    4323:	85 c0                	test   %eax,%eax
    4325:	74 99                	je     42c0 <fwp_main_thread+0xb60>
    4327:	be 04 00 00 00       	mov    $0x4,%esi
    432c:	48 8d 7d b3          	lea    -0x4d(%rbp),%rdi
    4330:	e8 5b 76 00 00       	call   b990 <fwp_read_exact>
    4335:	85 c0                	test   %eax,%eax
    4337:	0f 84 ed 05 00 00    	je     492a <fwp_main_thread+0x11ca>
    433d:	44 8b 7d b3          	mov    -0x4d(%rbp),%r15d
    4341:	49 8d 57 01          	lea    0x1(%r15),%rdx
    4345:	48 ff 05 dc 69 01 00 	incq   0x169dc(%rip)        # 1ad28 <measured_calls>
    434c:	48 01 15 dd 69 01 00 	add    %rdx,0x169dd(%rip)        # 1ad30 <measured_bytes>
    4353:	49 81 ff ff 3f 00 00 	cmp    $0x3fff,%r15
    435a:	48 8d 3d 27 4f 01 00 	lea    0x14f27(%rip),%rdi        # 19288 <fwp_gc>
    4361:	0f 87 25 02 00 00    	ja     458c <fwp_main_thread+0xe2c>
    4367:	49 8d 47 10          	lea    0x10(%r15),%rax
    436b:	48 c1 e8 04          	shr    $0x4,%rax
    436f:	0f b6 8c 38 e8 0b 00 	movzbl 0xbe8(%rax,%rdi,1),%ecx
    4376:	00 
    4377:	8b 84 8f 48 0b 00 00 	mov    0xb48(%rdi,%rcx,4),%eax
    437e:	48 29 05 03 4f 01 00 	sub    %rax,0x14f03(%rip)        # 19288 <fwp_gc>
    4385:	0f 88 01 02 00 00    	js     458c <fwp_main_thread+0xe2c>
    438b:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    438f:	48 8d 34 cf          	lea    (%rdi,%rcx,8),%rsi
    4393:	48 81 c6 c8 03 00 00 	add    $0x3c8,%rsi
    439a:	4c 8b 36             	mov    (%rsi),%r14
    439d:	4d 85 f6             	test   %r14,%r14
    43a0:	0f 84 ce 01 00 00    	je     4574 <fwp_main_thread+0xe14>
    43a6:	49 8b 06             	mov    (%r14),%rax
    43a9:	48 f7 d0             	not    %rax
    43ac:	48 89 06             	mov    %rax,(%rsi)
    43af:	e9 00 02 00 00       	jmp    45b4 <fwp_main_thread+0xe54>
    43b4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    43bb:	00 00 00 00 00 
    43c0:	48 8b 05 f1 4b 01 00 	mov    0x14bf1(%rip),%rax        # 18fb8 <stdin@GLIBC_2.2.5>
    43c7:	48 8b 38             	mov    (%rax),%rdi
    43ca:	e8 51 ee ff ff       	call   3220 <fgetc@plt>
    43cf:	83 f8 0a             	cmp    $0xa,%eax
    43d2:	0f 84 b8 00 00 00    	je     4490 <fwp_main_thread+0xd30>
    43d8:	83 f8 ff             	cmp    $0xffffffff,%eax
    43db:	0f 84 9a 05 00 00    	je     497b <fwp_main_thread+0x121b>
    43e1:	88 85 f0 fd ff ff    	mov    %al,-0x210(%rbp)
    43e7:	ba 01 00 00 00       	mov    $0x1,%edx
    43ec:	4c 8d 6d 90          	lea    -0x70(%rbp),%r13
    43f0:	4c 89 ef             	mov    %r13,%rdi
    43f3:	4c 8d bd f0 fd ff ff 	lea    -0x210(%rbp),%r15
    43fa:	4c 89 fe             	mov    %r15,%rsi
    43fd:	e8 0e 89 00 00       	call   cd10 <buf_put>
    4402:	48 8b 1d af 4b 01 00 	mov    0x14baf(%rip),%rbx        # 18fb8 <stdin@GLIBC_2.2.5>
    4409:	4c 8d 35 74 69 02 00 	lea    0x26974(%rip),%r14        # 2ad84 <fwp_in_pend>
    4410:	48 63 05 75 69 02 00 	movslq 0x26975(%rip),%rax        # 2ad8c <fwp_in_ppos>
    4417:	3b 05 6b 69 02 00    	cmp    0x2696b(%rip),%eax        # 2ad88 <fwp_in_npend>
    441d:	7d 21                	jge    4440 <fwp_main_thread+0xce0>
    441f:	8d 48 01             	lea    0x1(%rax),%ecx
    4422:	89 0d 64 69 02 00    	mov    %ecx,0x26964(%rip)        # 2ad8c <fwp_in_ppos>
    4428:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax
    442d:	83 f8 ff             	cmp    $0xffffffff,%eax
    4430:	75 1f                	jne    4451 <fwp_main_thread+0xcf1>
    4432:	e9 27 01 00 00       	jmp    455e <fwp_main_thread+0xdfe>
    4437:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    443e:	00 00 
    4440:	48 8b 3b             	mov    (%rbx),%rdi
    4443:	e8 d8 ed ff ff       	call   3220 <fgetc@plt>
    4448:	83 f8 ff             	cmp    $0xffffffff,%eax
    444b:	0f 84 0d 01 00 00    	je     455e <fwp_main_thread+0xdfe>
    4451:	83 f8 0a             	cmp    $0xa,%eax
    4454:	74 18                	je     446e <fwp_main_thread+0xd0e>
    4456:	88 85 f0 fd ff ff    	mov    %al,-0x210(%rbp)
    445c:	ba 01 00 00 00       	mov    $0x1,%edx
    4461:	4c 89 ef             	mov    %r13,%rdi
    4464:	4c 89 fe             	mov    %r15,%rsi
    4467:	e8 a4 88 00 00       	call   cd10 <buf_put>
    446c:	eb a2                	jmp    4410 <fwp_main_thread+0xcb0>
    446e:	4c 8b 6d 90          	mov    -0x70(%rbp),%r13
    4472:	48 8b 75 98          	mov    -0x68(%rbp),%rsi
    4476:	48 85 f6             	test   %rsi,%rsi
    4479:	74 15                	je     4490 <fwp_main_thread+0xd30>
    447b:	41 80 7c 35 ff 0d    	cmpb   $0xd,-0x1(%r13,%rsi,1)
    4481:	75 14                	jne    4497 <fwp_main_thread+0xd37>
    4483:	48 ff ce             	dec    %rsi
    4486:	48 89 75 98          	mov    %rsi,-0x68(%rbp)
    448a:	eb 0b                	jmp    4497 <fwp_main_thread+0xd37>
    448c:	0f 1f 40 00          	nopl   0x0(%rax)
    4490:	31 f6                	xor    %esi,%esi
    4492:	4d 85 ed             	test   %r13,%r13
    4495:	74 0e                	je     44a5 <fwp_main_thread+0xd45>
    4497:	41 c6 44 35 00 00    	movb   $0x0,0x0(%r13,%rsi,1)
    449d:	4c 8b 6d 90          	mov    -0x70(%rbp),%r13
    44a1:	48 8b 75 98          	mov    -0x68(%rbp),%rsi
    44a5:	4d 85 ed             	test   %r13,%r13
    44a8:	4c 89 ef             	mov    %r13,%rdi
    44ab:	48 8d 05 d8 0c 01 00 	lea    0x10cd8(%rip),%rax        # 1518a <exec_in_fp0+0x97a>
    44b2:	48 0f 44 f8          	cmove  %rax,%rdi
    44b6:	e8 15 67 00 00       	call   abd0 <fwp_str_lossy>
    44bb:	49 89 c7             	mov    %rax,%r15
    44be:	4c 8d 70 08          	lea    0x8(%rax),%r14
    44c2:	48 8b 00             	mov    (%rax),%rax
    44c5:	4c 89 b5 f0 fd ff ff 	mov    %r14,-0x210(%rbp)
    44cc:	48 89 85 f8 fd ff ff 	mov    %rax,-0x208(%rbp)
    44d3:	48 c7 85 00 fe ff ff 	movq   $0x0,-0x200(%rbp)
    44da:	00 00 00 00 
    44de:	48 8d bd f0 fd ff ff 	lea    -0x210(%rbp),%rdi
    44e5:	48 8d 35 64 48 01 00 	lea    0x14864(%rip),%rsi        # 18d50 <d3>
    44ec:	ba 01 00 00 00       	mov    $0x1,%edx
    44f1:	48 8d 4d 88          	lea    -0x78(%rbp),%rcx
    44f5:	e8 56 8d 00 00       	call   d250 <tp_value>
    44fa:	85 c0                	test   %eax,%eax
    44fc:	0f 84 e5 09 00 00    	je     4ee7 <fwp_main_thread+0x1787>
    4502:	48 8b 85 f8 fd ff ff 	mov    -0x208(%rbp),%rax
    4509:	48 8b 8d 00 fe ff ff 	mov    -0x200(%rbp),%rcx
    4510:	48 39 c1             	cmp    %rax,%rcx
    4513:	73 3b                	jae    4550 <fwp_main_thread+0xdf0>
    4515:	48 8b 95 f0 fd ff ff 	mov    -0x210(%rbp),%rdx
    451c:	0f 1f 40 00          	nopl   0x0(%rax)
    4520:	0f b6 34 0a          	movzbl (%rdx,%rcx,1),%esi
    4524:	48 83 fe 20          	cmp    $0x20,%rsi
    4528:	77 26                	ja     4550 <fwp_main_thread+0xdf0>
    452a:	49 0f a3 f4          	bt     %rsi,%r12
    452e:	73 20                	jae    4550 <fwp_main_thread+0xdf0>
    4530:	48 ff c1             	inc    %rcx
    4533:	48 89 8d 00 fe ff ff 	mov    %rcx,-0x200(%rbp)
    453a:	48 39 c8             	cmp    %rcx,%rax
    453d:	75 e1                	jne    4520 <fwp_main_thread+0xdc0>
    453f:	e9 8c 01 00 00       	jmp    46d0 <fwp_main_thread+0xf70>
    4544:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    454b:	00 00 00 00 00 
    4550:	48 39 c1             	cmp    %rax,%rcx
    4553:	0f 84 77 01 00 00    	je     46d0 <fwp_main_thread+0xf70>
    4559:	e9 89 09 00 00       	jmp    4ee7 <fwp_main_thread+0x1787>
    455e:	4c 8b 6d 90          	mov    -0x70(%rbp),%r13
    4562:	48 8b 75 98          	mov    -0x68(%rbp),%rsi
    4566:	4d 85 ed             	test   %r13,%r13
    4569:	0f 85 28 ff ff ff    	jne    4497 <fwp_main_thread+0xd37>
    456f:	e9 31 ff ff ff       	jmp    44a5 <fwp_main_thread+0xd45>
    4574:	4c 8b b4 cf d0 03 00 	mov    0x3d0(%rdi,%rcx,8),%r14
    457b:	00 
    457c:	48 8b b4 cf d8 03 00 	mov    0x3d8(%rdi,%rcx,8),%rsi
    4583:	00 
    4584:	4c 29 f6             	sub    %r14,%rsi
    4587:	48 39 c6             	cmp    %rax,%rsi
    458a:	73 17                	jae    45a3 <fwp_main_thread+0xe43>
    458c:	48 89 d7             	mov    %rdx,%rdi
    458f:	be 01 00 00 00       	mov    $0x1,%esi
    4594:	e8 87 37 00 00       	call   7d20 <fwp_gc_alloc_slow>
    4599:	49 89 c6             	mov    %rax,%r14
    459c:	4d 85 ff             	test   %r15,%r15
    459f:	75 22                	jne    45c3 <fwp_main_thread+0xe63>
    45a1:	eb 33                	jmp    45d6 <fwp_main_thread+0xe76>
    45a3:	48 8d 0c cf          	lea    (%rdi,%rcx,8),%rcx
    45a7:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
    45ae:	4c 01 f0             	add    %r14,%rax
    45b1:	48 89 01             	mov    %rax,(%rcx)
    45b4:	4c 89 f7             	mov    %r14,%rdi
    45b7:	31 f6                	xor    %esi,%esi
    45b9:	e8 52 ec ff ff       	call   3210 <memset@plt>
    45be:	4d 85 ff             	test   %r15,%r15
    45c1:	74 13                	je     45d6 <fwp_main_thread+0xe76>
    45c3:	4c 89 f7             	mov    %r14,%rdi
    45c6:	4c 89 fe             	mov    %r15,%rsi
    45c9:	e8 c2 73 00 00       	call   b990 <fwp_read_exact>
    45ce:	85 c0                	test   %eax,%eax
    45d0:	0f 84 54 03 00 00    	je     492a <fwp_main_thread+0x11ca>
    45d6:	0f b6 45 b2          	movzbl -0x4e(%rbp),%eax
    45da:	85 c0                	test   %eax,%eax
    45dc:	0f 84 de fc ff ff    	je     42c0 <fwp_main_thread+0xb60>
    45e2:	83 f8 02             	cmp    $0x2,%eax
    45e5:	0f 85 a3 00 00 00    	jne    468e <fwp_main_thread+0xf2e>
    45eb:	41 83 ff 01          	cmp    $0x1,%r15d
    45ef:	0f 85 50 03 00 00    	jne    4945 <fwp_main_thread+0x11e5>
    45f5:	8b 3d d1 66 01 00    	mov    0x166d1(%rip),%edi        # 1accc <fwp_pi_sock>
    45fb:	85 ff                	test   %edi,%edi
    45fd:	0f 88 42 03 00 00    	js     4945 <fwp_main_thread+0x11e5>
    4603:	83 3d ca 67 03 00 00 	cmpl   $0x0,0x367ca(%rip)        # 3add4 <fwp_pi_kind>
    460a:	0f 85 35 03 00 00    	jne    4945 <fwp_main_thread+0x11e5>
    4610:	41 0f b6 06          	movzbl (%r14),%eax
    4614:	83 f8 02             	cmp    $0x2,%eax
    4617:	0f 84 f4 00 00 00    	je     4711 <fwp_main_thread+0xfb1>
    461d:	83 f8 01             	cmp    $0x1,%eax
    4620:	0f 85 1f 03 00 00    	jne    4945 <fwp_main_thread+0x11e5>
    4626:	c7 05 a4 67 03 00 01 	movl   $0x1,0x367a4(%rip)        # 3add4 <fwp_pi_kind>
    462d:	00 00 00 
    4630:	48 8d 3d 53 11 01 00 	lea    0x11153(%rip),%rdi        # 1578a <exec_in_fp0+0xf7a>
    4637:	e8 f4 e9 ff ff       	call   3030 <getenv@plt>
    463c:	bb 10 00 00 00       	mov    $0x10,%ebx
    4641:	48 85 c0             	test   %rax,%rax
    4644:	0f 84 76 fc ff ff    	je     42c0 <fwp_main_thread+0xb60>
    464a:	80 38 00             	cmpb   $0x0,(%rax)
    464d:	0f 84 6d fc ff ff    	je     42c0 <fwp_main_thread+0xb60>
    4653:	48 89 c7             	mov    %rax,%rdi
    4656:	48 8d 35 00 11 01 00 	lea    0x11100(%rip),%rsi        # 1575d <exec_in_fp0+0xf4d>
    465d:	e8 6e ec ff ff       	call   32d0 <strcmp@plt>
    4662:	85 c0                	test   %eax,%eax
    4664:	0f 84 56 fc ff ff    	je     42c0 <fwp_main_thread+0xb60>
    466a:	48 8b 05 67 49 01 00 	mov    0x14967(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    4671:	48 8b 38             	mov    (%rax),%rdi
    4674:	48 8d 35 24 11 01 00 	lea    0x11124(%rip),%rsi        # 1579f <exec_in_fp0+0xf8f>
    467b:	48 8d 15 34 0e 01 00 	lea    0x10e34(%rip),%rdx        # 154b6 <exec_in_fp0+0xca6>
    4682:	31 c0                	xor    %eax,%eax
    4684:	e8 67 ec ff ff       	call   32f0 <fprintf@plt>
    4689:	e9 32 fc ff ff       	jmp    42c0 <fwp_main_thread+0xb60>
    468e:	4c 89 b5 f0 fd ff ff 	mov    %r14,-0x210(%rbp)
    4695:	4c 89 bd f8 fd ff ff 	mov    %r15,-0x208(%rbp)
    469c:	48 c7 85 00 fe ff ff 	movq   $0x0,-0x200(%rbp)
    46a3:	00 00 00 00 
    46a7:	48 8d bd f0 fd ff ff 	lea    -0x210(%rbp),%rdi
    46ae:	48 8d 35 9b 46 01 00 	lea    0x1469b(%rip),%rsi        # 18d50 <d3>
    46b5:	48 8d 55 88          	lea    -0x78(%rbp),%rdx
    46b9:	e8 d2 79 00 00       	call   c090 <fwp_decode>
    46be:	85 c0                	test   %eax,%eax
    46c0:	0f 84 4b 09 00 00    	je     5011 <fwp_main_thread+0x18b1>
    46c6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    46cd:	00 00 00 
    46d0:	48 8b 45 88          	mov    -0x78(%rbp),%rax
    46d4:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
    46d8:	48 89 07             	mov    %rax,(%rdi)
    46db:	48 8d 75 cc          	lea    -0x34(%rbp),%rsi
    46df:	e8 9c 6e 00 00       	call   b580 <fwp_exec_call>
    46e4:	48 89 c3             	mov    %rax,%rbx
    46e7:	48 8b 3d 0a 66 01 00 	mov    0x1660a(%rip),%rdi        # 1acf8 <fwp_prog_out>
    46ee:	e8 5d ec ff ff       	call   3350 <fflush@plt>
    46f3:	83 7d cc 00          	cmpl   $0x0,-0x34(%rbp)
    46f7:	0f 85 75 02 00 00    	jne    4972 <fwp_main_thread+0x1212>
    46fd:	48 89 df             	mov    %rbx,%rdi
    4700:	e8 bb 70 00 00       	call   b7c0 <fwp_emit_result>
    4705:	e8 b6 6d 00 00       	call   b4c0 <fwp_pipe_flush>
    470a:	31 db                	xor    %ebx,%ebx
    470c:	e9 af fb ff ff       	jmp    42c0 <fwp_main_thread+0xb60>
    4711:	48 8d 45 b7          	lea    -0x49(%rbp),%rax
    4715:	48 89 85 e0 fd ff ff 	mov    %rax,-0x220(%rbp)
    471c:	48 c7 85 e8 fd ff ff 	movq   $0x1,-0x218(%rbp)
    4723:	01 00 00 00 
    4727:	66 0f ef c0          	pxor   %xmm0,%xmm0
    472b:	66 0f 7f 85 00 ff ff 	movdqa %xmm0,-0x100(%rbp)
    4732:	ff 
    4733:	66 0f 7f 85 10 ff ff 	movdqa %xmm0,-0xf0(%rbp)
    473a:	ff 
    473b:	66 0f 7f 85 f0 fe ff 	movdqa %xmm0,-0x110(%rbp)
    4742:	ff 
    4743:	48 c7 85 20 ff ff ff 	movq   $0x0,-0xe0(%rbp)
    474a:	00 00 00 00 
    474e:	48 8d 85 e0 fd ff ff 	lea    -0x220(%rbp),%rax
    4755:	48 89 85 00 ff ff ff 	mov    %rax,-0x100(%rbp)
    475c:	48 c7 85 08 ff ff ff 	movq   $0x1,-0xf8(%rbp)
    4763:	01 00 00 00 
    4767:	48 8d 85 70 ff ff ff 	lea    -0x90(%rbp),%rax
    476e:	48 89 85 10 ff ff ff 	mov    %rax,-0xf0(%rbp)
    4775:	48 c7 85 18 ff ff ff 	movq   $0x18,-0xe8(%rbp)
    477c:	18 00 00 00 
    4780:	48 8d b5 f0 fe ff ff 	lea    -0x110(%rbp),%rsi
    4787:	ba 00 00 00 40       	mov    $0x40000000,%edx
    478c:	e8 0f ec ff ff       	call   33a0 <recvmsg@plt>
    4791:	48 83 f8 01          	cmp    $0x1,%rax
    4795:	0f 85 aa 01 00 00    	jne    4945 <fwp_main_thread+0x11e5>
    479b:	48 83 bd 18 ff ff ff 	cmpq   $0x10,-0xe8(%rbp)
    47a2:	10 
    47a3:	0f 82 9c 01 00 00    	jb     4945 <fwp_main_thread+0x11e5>
    47a9:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    47b0:	48 85 c0             	test   %rax,%rax
    47b3:	0f 84 8c 01 00 00    	je     4945 <fwp_main_thread+0x11e5>
    47b9:	83 78 0c 01          	cmpl   $0x1,0xc(%rax)
    47bd:	0f 85 82 01 00 00    	jne    4945 <fwp_main_thread+0x11e5>
    47c3:	44 8b 70 10          	mov    0x10(%rax),%r14d
    47c7:	44 89 f7             	mov    %r14d,%edi
    47ca:	48 8d b5 f0 fd ff ff 	lea    -0x210(%rbp),%rsi
    47d1:	e8 ea ec ff ff       	call   34c0 <fstat@plt>
    47d6:	85 c0                	test   %eax,%eax
    47d8:	0f 85 5f 01 00 00    	jne    493d <fwp_main_thread+0x11dd>
    47de:	48 8b b5 20 fe ff ff 	mov    -0x1e0(%rbp),%rsi
    47e5:	48 81 fe 00 10 00 00 	cmp    $0x1000,%rsi
    47ec:	0f 86 4b 01 00 00    	jbe    493d <fwp_main_thread+0x11dd>
    47f2:	31 ff                	xor    %edi,%edi
    47f4:	48 89 75 a8          	mov    %rsi,-0x58(%rbp)
    47f8:	ba 03 00 00 00       	mov    $0x3,%edx
    47fd:	b9 01 00 00 00       	mov    $0x1,%ecx
    4802:	45 89 f0             	mov    %r14d,%r8d
    4805:	45 31 c9             	xor    %r9d,%r9d
    4808:	e8 83 e9 ff ff       	call   3190 <mmap@plt>
    480d:	49 89 c7             	mov    %rax,%r15
    4810:	44 89 f7             	mov    %r14d,%edi
    4813:	e8 18 ea ff ff       	call   3230 <close@plt>
    4818:	49 83 ff ff          	cmp    $0xffffffffffffffff,%r15
    481c:	0f 84 23 01 00 00    	je     4945 <fwp_main_thread+0x11e5>
    4822:	41 81 3f 46 57 50 53 	cmpl   $0x53505746,(%r15)
    4829:	0f 85 16 01 00 00    	jne    4945 <fwp_main_thread+0x11e5>
    482f:	41 83 7f 04 01       	cmpl   $0x1,0x4(%r15)
    4834:	0f 85 0b 01 00 00    	jne    4945 <fwp_main_thread+0x11e5>
    483a:	49 8b 47 08          	mov    0x8(%r15),%rax
    483e:	48 85 c0             	test   %rax,%rax
    4841:	0f 84 fe 00 00 00    	je     4945 <fwp_main_thread+0x11e5>
    4847:	48 89 c1             	mov    %rax,%rcx
    484a:	48 d1 e9             	shr    $1,%rcx
    484d:	48 ba 55 55 55 55 55 	movabs $0x5555555555555555,%rdx
    4854:	55 55 55 
    4857:	48 21 d1             	and    %rdx,%rcx
    485a:	48 89 c2             	mov    %rax,%rdx
    485d:	48 29 ca             	sub    %rcx,%rdx
    4860:	48 89 d1             	mov    %rdx,%rcx
    4863:	48 be 33 33 33 33 33 	movabs $0x3333333333333333,%rsi
    486a:	33 33 33 
    486d:	48 21 f1             	and    %rsi,%rcx
    4870:	48 c1 ea 02          	shr    $0x2,%rdx
    4874:	48 21 f2             	and    %rsi,%rdx
    4877:	48 01 ca             	add    %rcx,%rdx
    487a:	48 89 d1             	mov    %rdx,%rcx
    487d:	48 c1 e9 04          	shr    $0x4,%rcx
    4881:	48 01 d1             	add    %rdx,%rcx
    4884:	48 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%rdx
    488b:	0f 0f 0f 
    488e:	48 21 d1             	and    %rdx,%rcx
    4891:	48 ba 01 01 01 01 01 	movabs $0x101010101010101,%rdx
    4898:	01 01 01 
    489b:	48 0f af ca          	imul   %rdx,%rcx
    489f:	48 c1 e9 38          	shr    $0x38,%rcx
    48a3:	83 f9 01             	cmp    $0x1,%ecx
    48a6:	0f 87 99 00 00 00    	ja     4945 <fwp_main_thread+0x11e5>
    48ac:	48 8b 4d a8          	mov    -0x58(%rbp),%rcx
    48b0:	48 81 c1 00 f0 ff ff 	add    $0xfffffffffffff000,%rcx
    48b7:	48 39 c8             	cmp    %rcx,%rax
    48ba:	0f 87 85 00 00 00    	ja     4945 <fwp_main_thread+0x11e5>
    48c0:	4c 89 3d 11 65 03 00 	mov    %r15,0x36511(%rip)        # 3add8 <fwp_pi_ring>
    48c7:	c7 05 03 65 03 00 02 	movl   $0x2,0x36503(%rip)        # 3add4 <fwp_pi_kind>
    48ce:	00 00 00 
    48d1:	48 8d 3d b2 0e 01 00 	lea    0x10eb2(%rip),%rdi        # 1578a <exec_in_fp0+0xf7a>
    48d8:	e8 53 e7 ff ff       	call   3030 <getenv@plt>
    48dd:	48 85 c0             	test   %rax,%rax
    48e0:	0f 84 ca f9 ff ff    	je     42b0 <fwp_main_thread+0xb50>
    48e6:	80 38 00             	cmpb   $0x0,(%rax)
    48e9:	0f 84 c1 f9 ff ff    	je     42b0 <fwp_main_thread+0xb50>
    48ef:	48 89 c7             	mov    %rax,%rdi
    48f2:	48 8d 35 64 0e 01 00 	lea    0x10e64(%rip),%rsi        # 1575d <exec_in_fp0+0xf4d>
    48f9:	e8 d2 e9 ff ff       	call   32d0 <strcmp@plt>
    48fe:	85 c0                	test   %eax,%eax
    4900:	0f 84 aa f9 ff ff    	je     42b0 <fwp_main_thread+0xb50>
    4906:	48 8b 05 cb 46 01 00 	mov    0x146cb(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    490d:	48 8b 38             	mov    (%rax),%rdi
    4910:	48 8d 35 88 0e 01 00 	lea    0x10e88(%rip),%rsi        # 1579f <exec_in_fp0+0xf8f>
    4917:	48 8d 15 65 0e 01 00 	lea    0x10e65(%rip),%rdx        # 15783 <exec_in_fp0+0xf73>
    491e:	31 c0                	xor    %eax,%eax
    4920:	e8 cb e9 ff ff       	call   32f0 <fprintf@plt>
    4925:	e9 86 f9 ff ff       	jmp    42b0 <fwp_main_thread+0xb50>
    492a:	48 8b 05 a7 46 01 00 	mov    0x146a7(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    4931:	48 8b 38             	mov    (%rax),%rdi
    4934:	48 8d 35 d9 0b 01 00 	lea    0x10bd9(%rip),%rsi        # 15514 <exec_in_fp0+0xd04>
    493b:	eb 19                	jmp    4956 <fwp_main_thread+0x11f6>
    493d:	44 89 f7             	mov    %r14d,%edi
    4940:	e8 eb e8 ff ff       	call   3230 <close@plt>
    4945:	48 8b 05 8c 46 01 00 	mov    0x1468c(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    494c:	48 8b 38             	mov    (%rax),%rdi
    494f:	48 8d 35 d3 0b 01 00 	lea    0x10bd3(%rip),%rsi        # 15529 <exec_in_fp0+0xd19>
    4956:	48 8d 15 2d 00 01 00 	lea    0x1002d(%rip),%rdx        # 1498a <exec_in_fp0+0x17a>
    495d:	31 c0                	xor    %eax,%eax
    495f:	e8 8c e9 ff ff       	call   32f0 <fprintf@plt>
    4964:	b8 03 00 00 00       	mov    $0x3,%eax
    4969:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    496d:	e9 4e f9 ff ff       	jmp    42c0 <fwp_main_thread+0xb60>
    4972:	b8 01 00 00 00       	mov    $0x1,%eax
    4977:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    497b:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
    497f:	e8 cc e6 ff ff       	call   3050 <free@plt>
    4984:	4c 8b 65 d0          	mov    -0x30(%rbp),%r12
    4988:	83 3d f1 63 02 00 00 	cmpl   $0x0,0x263f1(%rip)        # 2ad80 <fwp_exec_binary_out>
    498f:	0f 84 44 04 00 00    	je     4dd9 <fwp_main_thread+0x1679>
    4995:	48 8d 3d 3f fe 00 00 	lea    0xfe3f(%rip),%rdi        # 147db <fwp_exec.end>
    499c:	be 05 00 00 00       	mov    $0x5,%esi
    49a1:	e8 ba 66 00 00       	call   b060 <fwp_pipe_write>
    49a6:	8b 05 f4 63 02 00    	mov    0x263f4(%rip),%eax        # 2ada0 <fwp_po_kind>
    49ac:	83 f8 02             	cmp    $0x2,%eax
    49af:	0f 84 86 00 00 00    	je     4a3b <fwp_main_thread+0x12db>
    49b5:	83 f8 01             	cmp    $0x1,%eax
    49b8:	0f 85 d5 00 00 00    	jne    4a93 <fwp_main_thread+0x1333>
    49be:	48 8b 1d e3 63 02 00 	mov    0x263e3(%rip),%rbx        # 2ada8 <fwp_po_len>
    49c5:	48 85 db             	test   %rbx,%rbx
    49c8:	0f 84 d7 03 00 00    	je     4da5 <fwp_main_thread+0x1645>
    49ce:	80 3d e3 63 03 00 00 	cmpb   $0x0,0x363e3(%rip)        # 3adb8 <fwp_po_gone>
    49d5:	0f 85 ca 03 00 00    	jne    4da5 <fwp_main_thread+0x1645>
    49db:	44 8b 35 e2 62 01 00 	mov    0x162e2(%rip),%r14d        # 1acc4 <fwp_po_sock>
    49e2:	4c 8d 3d c7 63 02 00 	lea    0x263c7(%rip),%r15        # 2adb0 <fwp_po_buf>
    49e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    49f0:	44 89 f7             	mov    %r14d,%edi
    49f3:	4c 89 fe             	mov    %r15,%rsi
    49f6:	48 89 da             	mov    %rbx,%rdx
    49f9:	b9 00 40 00 00       	mov    $0x4000,%ecx
    49fe:	e8 9d e7 ff ff       	call   31a0 <send@plt>
    4a03:	48 85 c0             	test   %rax,%rax
    4a06:	78 0e                	js     4a16 <fwp_main_thread+0x12b6>
    4a08:	0f 84 90 03 00 00    	je     4d9e <fwp_main_thread+0x163e>
    4a0e:	49 01 c7             	add    %rax,%r15
    4a11:	48 29 c3             	sub    %rax,%rbx
    4a14:	eb 0e                	jmp    4a24 <fwp_main_thread+0x12c4>
    4a16:	e8 65 e6 ff ff       	call   3080 <__errno_location@plt>
    4a1b:	83 38 04             	cmpl   $0x4,(%rax)
    4a1e:	0f 85 7a 03 00 00    	jne    4d9e <fwp_main_thread+0x163e>
    4a24:	48 85 db             	test   %rbx,%rbx
    4a27:	0f 84 78 03 00 00    	je     4da5 <fwp_main_thread+0x1645>
    4a2d:	f6 05 84 63 03 00 01 	testb  $0x1,0x36384(%rip)        # 3adb8 <fwp_po_gone>
    4a34:	74 ba                	je     49f0 <fwp_main_thread+0x1290>
    4a36:	e9 6a 03 00 00       	jmp    4da5 <fwp_main_thread+0x1645>
    4a3b:	48 8b 35 6e 63 03 00 	mov    0x3636e(%rip),%rsi        # 3adb0 <fwp_po_ring>
    4a42:	c7 86 40 01 00 00 01 	movl   $0x1,0x140(%rsi)
    4a49:	00 00 00 
    4a4c:	0f ae f0             	mfence
    4a4f:	8b 86 c4 00 00 00    	mov    0xc4(%rsi),%eax
    4a55:	85 c0                	test   %eax,%eax
    4a57:	0f 84 63 03 00 00    	je     4dc0 <fwp_main_thread+0x1660>
    4a5d:	f0 ff 86 c0 00 00 00 	lock incl 0xc0(%rsi)
    4a64:	48 81 c6 c0 00 00 00 	add    $0xc0,%rsi
    4a6b:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    4a72:	bf ca 00 00 00       	mov    $0xca,%edi
    4a77:	ba 01 00 00 00       	mov    $0x1,%edx
    4a7c:	b9 ff ff ff 7f       	mov    $0x7fffffff,%ecx
    4a81:	45 31 c0             	xor    %r8d,%r8d
    4a84:	45 31 c9             	xor    %r9d,%r9d
    4a87:	31 c0                	xor    %eax,%eax
    4a89:	e8 72 e8 ff ff       	call   3300 <syscall@plt>
    4a8e:	e9 2d 03 00 00       	jmp    4dc0 <fwp_main_thread+0x1660>
    4a93:	48 8b 05 16 45 01 00 	mov    0x14516(%rip),%rax        # 18fb0 <stdout@GLIBC_2.2.5>
    4a9a:	48 8b 38             	mov    (%rax),%rdi
    4a9d:	e8 ae e8 ff ff       	call   3350 <fflush@plt>
    4aa2:	e9 19 03 00 00       	jmp    4dc0 <fwp_main_thread+0x1660>
    4aa7:	41 83 ff 01          	cmp    $0x1,%r15d
    4aab:	0f 84 6c 04 00 00    	je     4f1d <fwp_main_thread+0x17bd>
    4ab1:	49 8b 5d 10          	mov    0x10(%r13),%rbx
    4ab5:	48 8d 35 35 0b 01 00 	lea    0x10b35(%rip),%rsi        # 155f1 <exec_in_fp0+0xde1>
    4abc:	48 89 df             	mov    %rbx,%rdi
    4abf:	e8 0c e8 ff ff       	call   32d0 <strcmp@plt>
    4ac4:	45 31 e4             	xor    %r12d,%r12d
    4ac7:	85 c0                	test   %eax,%eax
    4ac9:	0f 84 34 01 00 00    	je     4c03 <fwp_main_thread+0x14a3>
    4acf:	48 8d 35 20 0b 01 00 	lea    0x10b20(%rip),%rsi        # 155f6 <exec_in_fp0+0xde6>
    4ad6:	48 89 df             	mov    %rbx,%rdi
    4ad9:	e8 f2 e7 ff ff       	call   32d0 <strcmp@plt>
    4ade:	85 c0                	test   %eax,%eax
    4ae0:	0f 84 97 02 00 00    	je     4d7d <fwp_main_thread+0x161d>
    4ae6:	48 8d 35 0d 0b 01 00 	lea    0x10b0d(%rip),%rsi        # 155fa <exec_in_fp0+0xdea>
    4aed:	48 89 df             	mov    %rbx,%rdi
    4af0:	e8 db e7 ff ff       	call   32d0 <strcmp@plt>
    4af5:	b9 02 00 00 00       	mov    $0x2,%ecx
    4afa:	85 c0                	test   %eax,%eax
    4afc:	0f 84 80 02 00 00    	je     4d82 <fwp_main_thread+0x1622>
    4b02:	48 89 df             	mov    %rbx,%rdi
    4b05:	e8 66 e6 ff ff       	call   3170 <strlen@plt>
    4b0a:	48 89 df             	mov    %rbx,%rdi
    4b0d:	48 89 c6             	mov    %rax,%rsi
    4b10:	e8 bb 60 00 00       	call   abd0 <fwp_str_lossy>
    4b15:	48 8b 0d bc 44 01 00 	mov    0x144bc(%rip),%rcx        # 18fd8 <stderr@GLIBC_2.2.5>
    4b1c:	48 8b 39             	mov    (%rcx),%rdi
    4b1f:	48 8d 48 08          	lea    0x8(%rax),%rcx
    4b23:	48 8d 35 d5 0a 01 00 	lea    0x10ad5(%rip),%rsi        # 155ff <exec_in_fp0+0xdef>
    4b2a:	48 8d 15 59 fe 00 00 	lea    0xfe59(%rip),%rdx        # 1498a <exec_in_fp0+0x17a>
    4b31:	31 c0                	xor    %eax,%eax
    4b33:	e8 b8 e7 ff ff       	call   32f0 <fprintf@plt>
    4b38:	41 bc 02 00 00 00    	mov    $0x2,%r12d
    4b3e:	e9 a5 02 00 00       	jmp    4de8 <fwp_main_thread+0x1688>
    4b43:	c7 05 3f 62 02 00 04 	movl   $0x4,0x2623f(%rip)        # 2ad8c <fwp_in_ppos>
    4b4a:	00 00 00 
    4b4d:	48 8d 7d 90          	lea    -0x70(%rbp),%rdi
    4b51:	be 01 00 00 00       	mov    $0x1,%esi
    4b56:	e8 35 6e 00 00       	call   b990 <fwp_read_exact>
    4b5b:	85 c0                	test   %eax,%eax
    4b5d:	0f 84 26 04 00 00    	je     4f89 <fwp_main_thread+0x1829>
    4b63:	49 c7 c6 f9 ff ff ff 	mov    $0xfffffffffffffff9,%r14
    4b6a:	45 31 ff             	xor    %r15d,%r15d
    4b6d:	4c 8d a5 f0 fd ff ff 	lea    -0x210(%rbp),%r12
    4b74:	31 db                	xor    %ebx,%ebx
    4b76:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    4b7d:	00 00 00 
    4b80:	be 01 00 00 00       	mov    $0x1,%esi
    4b85:	4c 89 e7             	mov    %r12,%rdi
    4b88:	e8 03 6e 00 00       	call   b990 <fwp_read_exact>
    4b8d:	85 c0                	test   %eax,%eax
    4b8f:	0f 84 33 03 00 00    	je     4ec8 <fwp_main_thread+0x1768>
    4b95:	0f b6 85 f0 fd ff ff 	movzbl -0x210(%rbp),%eax
    4b9c:	49 83 fe 38          	cmp    $0x38,%r14
    4ba0:	75 07                	jne    4ba9 <fwp_main_thread+0x1449>
    4ba2:	89 c1                	mov    %eax,%ecx
    4ba4:	80 e1 7e             	and    $0x7e,%cl
    4ba7:	75 1c                	jne    4bc5 <fwp_main_thread+0x1465>
    4ba9:	49 83 c6 07          	add    $0x7,%r14
    4bad:	89 c2                	mov    %eax,%edx
    4baf:	83 e2 7f             	and    $0x7f,%edx
    4bb2:	44 89 f1             	mov    %r14d,%ecx
    4bb5:	48 d3 e2             	shl    %cl,%rdx
    4bb8:	48 09 d3             	or     %rdx,%rbx
    4bbb:	84 c0                	test   %al,%al
    4bbd:	79 4b                	jns    4c0a <fwp_main_thread+0x14aa>
    4bbf:	49 83 fe 38          	cmp    $0x38,%r14
    4bc3:	76 bb                	jbe    4b80 <fwp_main_thread+0x1420>
    4bc5:	41 bf ff ff ff ff    	mov    $0xffffffff,%r15d
    4bcb:	45 85 ff             	test   %r15d,%r15d
    4bce:	0f 88 fd 02 00 00    	js     4ed1 <fwp_main_thread+0x1771>
    4bd4:	e9 b0 03 00 00       	jmp    4f89 <fwp_main_thread+0x1829>
    4bd9:	48 8b 05 f8 43 01 00 	mov    0x143f8(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    4be0:	48 8b 38             	mov    (%rax),%rdi
    4be3:	48 8d 35 be 0a 01 00 	lea    0x10abe(%rip),%rsi        # 156a8 <exec_in_fp0+0xe98>
    4bea:	48 8d 15 ca 0b 01 00 	lea    0x10bca(%rip),%rdx        # 157bb <exec_in_fp0+0xfab>
    4bf1:	31 c0                	xor    %eax,%eax
    4bf3:	e8 f8 e6 ff ff       	call   32f0 <fprintf@plt>
    4bf8:	41 bc 02 00 00 00    	mov    $0x2,%r12d
    4bfe:	e9 e5 01 00 00       	jmp    4de8 <fwp_main_thread+0x1688>
    4c03:	31 c9                	xor    %ecx,%ecx
    4c05:	e9 78 01 00 00       	jmp    4d82 <fwp_main_thread+0x1622>
    4c0a:	48 83 fb 40          	cmp    $0x40,%rbx
    4c0e:	b8 40 00 00 00       	mov    $0x40,%eax
    4c13:	48 0f 42 c3          	cmovb  %rbx,%rax
    4c17:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    4c1b:	48 85 db             	test   %rbx,%rbx
    4c1e:	0f 84 ee 01 00 00    	je     4e12 <fwp_main_thread+0x16b2>
    4c24:	45 31 e4             	xor    %r12d,%r12d
    4c27:	4c 8d bd f0 fd ff ff 	lea    -0x210(%rbp),%r15
    4c2e:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%rbp)
    4c35:	e9 93 00 00 00       	jmp    4ccd <fwp_main_thread+0x156d>
    4c3a:	48 8d 0d 59 0c 01 00 	lea    0x10c59(%rip),%rcx        # 1589a <exec_in_fp0+0x108a>
    4c41:	44 89 fe             	mov    %r15d,%esi
    4c44:	4c 89 f2             	mov    %r14,%rdx
    4c47:	31 c0                	xor    %eax,%eax
    4c49:	e8 b2 82 00 00       	call   cf00 <fwp_strf>
    4c4e:	48 8b 0d 83 43 01 00 	mov    0x14383(%rip),%rcx        # 18fd8 <stderr@GLIBC_2.2.5>
    4c55:	48 8b 39             	mov    (%rcx),%rdi
    4c58:	4c 8d 40 08          	lea    0x8(%rax),%r8
    4c5c:	48 8d 35 34 0a 01 00 	lea    0x10a34(%rip),%rsi        # 15697 <exec_in_fp0+0xe87>
    4c63:	48 8d 15 20 fd 00 00 	lea    0xfd20(%rip),%rdx        # 1498a <exec_in_fp0+0x17a>
    4c6a:	b9 01 00 00 00       	mov    $0x1,%ecx
    4c6f:	31 c0                	xor    %eax,%eax
    4c71:	e8 7a e6 ff ff       	call   32f0 <fprintf@plt>
    4c76:	41 bc 02 00 00 00    	mov    $0x2,%r12d
    4c7c:	e9 67 01 00 00       	jmp    4de8 <fwp_main_thread+0x1688>
    4c81:	be 06 00 00 00       	mov    $0x6,%esi
    4c86:	4c 89 ff             	mov    %r15,%rdi
    4c89:	e8 02 6d 00 00       	call   b990 <fwp_read_exact>
    4c8e:	85 c0                	test   %eax,%eax
    4c90:	0f 84 f3 02 00 00    	je     4f89 <fwp_main_thread+0x1829>
    4c96:	8b 85 f0 fd ff ff    	mov    -0x210(%rbp),%eax
    4c9c:	b9 55 44 53 5f       	mov    $0x5f534455,%ecx
    4ca1:	31 c8                	xor    %ecx,%eax
    4ca3:	0f b7 8d f4 fd ff ff 	movzwl -0x20c(%rbp),%ecx
    4caa:	81 f1 56 31 00 00    	xor    $0x3156,%ecx
    4cb0:	09 c1                	or     %eax,%ecx
    4cb2:	8b 45 d0             	mov    -0x30(%rbp),%eax
    4cb5:	b9 01 00 00 00       	mov    $0x1,%ecx
    4cba:	0f 44 c1             	cmove  %ecx,%eax
    4cbd:	89 45 d0             	mov    %eax,-0x30(%rbp)
    4cc0:	49 ff c4             	inc    %r12
    4cc3:	4c 3b 65 c0          	cmp    -0x40(%rbp),%r12
    4cc7:	0f 84 4c 01 00 00    	je     4e19 <fwp_main_thread+0x16b9>
    4ccd:	49 c7 c6 f9 ff ff ff 	mov    $0xfffffffffffffff9,%r14
    4cd4:	45 31 ed             	xor    %r13d,%r13d
    4cd7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    4cde:	00 00 
    4ce0:	be 01 00 00 00       	mov    $0x1,%esi
    4ce5:	4c 89 ff             	mov    %r15,%rdi
    4ce8:	e8 a3 6c 00 00       	call   b990 <fwp_read_exact>
    4ced:	85 c0                	test   %eax,%eax
    4cef:	0f 84 d0 01 00 00    	je     4ec5 <fwp_main_thread+0x1765>
    4cf5:	0f b6 85 f0 fd ff ff 	movzbl -0x210(%rbp),%eax
    4cfc:	49 83 fe 38          	cmp    $0x38,%r14
    4d00:	75 0b                	jne    4d0d <fwp_main_thread+0x15ad>
    4d02:	89 c1                	mov    %eax,%ecx
    4d04:	80 e1 7e             	and    $0x7e,%cl
    4d07:	0f 85 b8 fe ff ff    	jne    4bc5 <fwp_main_thread+0x1465>
    4d0d:	49 83 c6 07          	add    $0x7,%r14
    4d11:	89 c2                	mov    %eax,%edx
    4d13:	83 e2 7f             	and    $0x7f,%edx
    4d16:	44 89 f1             	mov    %r14d,%ecx
    4d19:	48 d3 e2             	shl    %cl,%rdx
    4d1c:	49 09 d5             	or     %rdx,%r13
    4d1f:	84 c0                	test   %al,%al
    4d21:	79 0b                	jns    4d2e <fwp_main_thread+0x15ce>
    4d23:	49 83 fe 38          	cmp    $0x38,%r14
    4d27:	76 b7                	jbe    4ce0 <fwp_main_thread+0x1580>
    4d29:	e9 97 fe ff ff       	jmp    4bc5 <fwp_main_thread+0x1465>
    4d2e:	49 81 fd 01 00 10 00 	cmp    $0x100001,%r13
    4d35:	0f 83 8a fe ff ff    	jae    4bc5 <fwp_main_thread+0x1465>
    4d3b:	4d 85 ed             	test   %r13,%r13
    4d3e:	74 80                	je     4cc0 <fwp_main_thread+0x1560>
    4d40:	49 83 fd 06          	cmp    $0x6,%r13
    4d44:	0f 84 37 ff ff ff    	je     4c81 <fwp_main_thread+0x1521>
    4d4a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    4d50:	49 81 fd 00 01 00 00 	cmp    $0x100,%r13
    4d57:	bb 00 01 00 00       	mov    $0x100,%ebx
    4d5c:	49 0f 42 dd          	cmovb  %r13,%rbx
    4d60:	4c 89 ff             	mov    %r15,%rdi
    4d63:	48 89 de             	mov    %rbx,%rsi
    4d66:	e8 25 6c 00 00       	call   b990 <fwp_read_exact>
    4d6b:	85 c0                	test   %eax,%eax
    4d6d:	0f 84 16 02 00 00    	je     4f89 <fwp_main_thread+0x1829>
    4d73:	49 29 dd             	sub    %rbx,%r13
    4d76:	75 d8                	jne    4d50 <fwp_main_thread+0x15f0>
    4d78:	e9 43 ff ff ff       	jmp    4cc0 <fwp_main_thread+0x1560>
    4d7d:	b9 01 00 00 00       	mov    $0x1,%ecx
    4d82:	48 8d 05 c7 5f 01 00 	lea    0x15fc7(%rip),%rax        # 1ad50 <fwp_cli_scripts>
    4d89:	48 8b 3c c8          	mov    (%rax,%rcx,8),%rdi
    4d8d:	48 8b 05 1c 42 01 00 	mov    0x1421c(%rip),%rax        # 18fb0 <stdout@GLIBC_2.2.5>
    4d94:	48 8b 30             	mov    (%rax),%rsi
    4d97:	e8 54 e4 ff ff       	call   31f0 <fputs@plt>
    4d9c:	eb 4a                	jmp    4de8 <fwp_main_thread+0x1688>
    4d9e:	c6 05 13 60 03 00 01 	movb   $0x1,0x36013(%rip)        # 3adb8 <fwp_po_gone>
    4da5:	48 c7 05 f8 5f 02 00 	movq   $0x0,0x25ff8(%rip)        # 2ada8 <fwp_po_len>
    4dac:	00 00 00 00 
    4db0:	8b 3d 0e 5f 01 00    	mov    0x15f0e(%rip),%edi        # 1acc4 <fwp_po_sock>
    4db6:	be 01 00 00 00       	mov    $0x1,%esi
    4dbb:	e8 a0 e3 ff ff       	call   3160 <shutdown@plt>
    4dc0:	8b 3d fa 5e 01 00    	mov    0x15efa(%rip),%edi        # 1acc0 <fwp_po_listen>
    4dc6:	85 ff                	test   %edi,%edi
    4dc8:	78 0f                	js     4dd9 <fwp_main_thread+0x1679>
    4dca:	e8 61 e4 ff ff       	call   3230 <close@plt>
    4dcf:	c7 05 e7 5e 01 00 ff 	movl   $0xffffffff,0x15ee7(%rip)        # 1acc0 <fwp_po_listen>
    4dd6:	ff ff ff 
    4dd9:	48 8b 05 d0 41 01 00 	mov    0x141d0(%rip),%rax        # 18fb0 <stdout@GLIBC_2.2.5>
    4de0:	48 8b 38             	mov    (%rax),%rdi
    4de3:	e8 68 e5 ff ff       	call   3350 <fflush@plt>
    4de8:	44 89 25 31 5f 01 00 	mov    %r12d,0x15f31(%rip)        # 1ad20 <fwp_exit_code>
    4def:	48 8b 05 ba 41 01 00 	mov    0x141ba(%rip),%rax        # 18fb0 <stdout@GLIBC_2.2.5>
    4df6:	48 8b 38             	mov    (%rax),%rdi
    4df9:	e8 52 e5 ff ff       	call   3350 <fflush@plt>
    4dfe:	31 c0                	xor    %eax,%eax
    4e00:	48 81 c4 08 02 00 00 	add    $0x208,%rsp
    4e07:	5b                   	pop    %rbx
    4e08:	41 5c                	pop    %r12
    4e0a:	41 5d                	pop    %r13
    4e0c:	41 5e                	pop    %r14
    4e0e:	41 5f                	pop    %r15
    4e10:	5d                   	pop    %rbp
    4e11:	c3                   	ret
    4e12:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%rbp)
    4e19:	48 c7 85 70 ff ff ff 	movq   $0x0,-0x90(%rbp)
    4e20:	00 00 00 00 
    4e24:	48 8d bd f0 fe ff ff 	lea    -0x110(%rbp),%rdi
    4e2b:	be 10 00 00 00       	mov    $0x10,%esi
    4e30:	e8 5b 6b 00 00       	call   b990 <fwp_read_exact>
    4e35:	85 c0                	test   %eax,%eax
    4e37:	0f 84 4c 01 00 00    	je     4f89 <fwp_main_thread+0x1829>
    4e3d:	48 8d bd 70 ff ff ff 	lea    -0x90(%rbp),%rdi
    4e44:	e8 57 70 00 00       	call   bea0 <fwp_stdin_name_len>
    4e49:	83 f8 01             	cmp    $0x1,%eax
    4e4c:	0f 85 2b 01 00 00    	jne    4f7d <fwp_main_thread+0x181d>
    4e52:	48 8b 9d 70 ff ff ff 	mov    -0x90(%rbp),%rbx
    4e59:	48 8d 7b 01          	lea    0x1(%rbx),%rdi
    4e5d:	e8 4e 61 00 00       	call   afb0 <fwp_alloc_leaf>
    4e62:	49 89 c6             	mov    %rax,%r14
    4e65:	48 85 db             	test   %rbx,%rbx
    4e68:	74 13                	je     4e7d <fwp_main_thread+0x171d>
    4e6a:	4c 89 f7             	mov    %r14,%rdi
    4e6d:	48 89 de             	mov    %rbx,%rsi
    4e70:	e8 1b 6b 00 00       	call   b990 <fwp_read_exact>
    4e75:	85 c0                	test   %eax,%eax
    4e77:	0f 84 0c 01 00 00    	je     4f89 <fwp_main_thread+0x1829>
    4e7d:	41 c6 04 1e 00       	movb   $0x0,(%r14,%rbx,1)
    4e82:	0f b6 4d 90          	movzbl -0x70(%rbp),%ecx
    4e86:	83 f9 01             	cmp    $0x1,%ecx
    4e89:	0f 85 24 01 00 00    	jne    4fb3 <fwp_main_thread+0x1853>
    4e8f:	66 0f 6f 85 f0 fe ff 	movdqa -0x110(%rbp),%xmm0
    4e96:	ff 
    4e97:	66 0f 74 05 71 f1 00 	pcmpeqb 0xf171(%rip),%xmm0        # 14010 <_IO_stdin_used+0x10>
    4e9e:	00 
    4e9f:	66 0f d7 c0          	pmovmskb %xmm0,%eax
    4ea3:	3d ff ff 00 00       	cmp    $0xffff,%eax
    4ea8:	0f 85 2f 01 00 00    	jne    4fdd <fwp_main_thread+0x187d>
    4eae:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
    4eb2:	74 05                	je     4eb9 <fwp_main_thread+0x1759>
    4eb4:	e8 77 70 00 00       	call   bf30 <fwp_pipe_in_offer>
    4eb9:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%rbp)
    4ec0:	e9 cc f1 ff ff       	jmp    4091 <fwp_main_thread+0x931>
    4ec5:	45 31 ff             	xor    %r15d,%r15d
    4ec8:	45 85 ff             	test   %r15d,%r15d
    4ecb:	0f 89 b8 00 00 00    	jns    4f89 <fwp_main_thread+0x1829>
    4ed1:	48 8b 05 00 41 01 00 	mov    0x14100(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    4ed8:	48 8b 38             	mov    (%rax),%rdi
    4edb:	48 8d 35 97 06 01 00 	lea    0x10697(%rip),%rsi        # 15579 <exec_in_fp0+0xd69>
    4ee2:	e9 b3 00 00 00       	jmp    4f9a <fwp_main_thread+0x183a>
    4ee7:	48 8b 05 ea 40 01 00 	mov    0x140ea(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    4eee:	48 8b 38             	mov    (%rax),%rdi
    4ef1:	41 8b 0f             	mov    (%r15),%ecx
    4ef4:	48 8d 35 59 06 01 00 	lea    0x10659(%rip),%rsi        # 15554 <exec_in_fp0+0xd44>
    4efb:	48 8d 15 88 fa 00 00 	lea    0xfa88(%rip),%rdx        # 1498a <exec_in_fp0+0x17a>
    4f02:	4c 8d 0d 91 09 01 00 	lea    0x10991(%rip),%r9        # 1589a <exec_in_fp0+0x108a>
    4f09:	4d 89 f0             	mov    %r14,%r8
    4f0c:	31 c0                	xor    %eax,%eax
    4f0e:	e8 dd e3 ff ff       	call   32f0 <fprintf@plt>
    4f13:	b8 03 00 00 00       	mov    $0x3,%eax
    4f18:	e9 5a fa ff ff       	jmp    4977 <fwp_main_thread+0x1217>
    4f1d:	48 8b 05 b4 40 01 00 	mov    0x140b4(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    4f24:	48 8b 38             	mov    (%rax),%rdi
    4f27:	48 8d 35 85 06 01 00 	lea    0x10685(%rip),%rsi        # 155b3 <exec_in_fp0+0xda3>
    4f2e:	48 8d 15 55 fa 00 00 	lea    0xfa55(%rip),%rdx        # 1498a <exec_in_fp0+0x17a>
    4f35:	e9 b7 fc ff ff       	jmp    4bf1 <fwp_main_thread+0x1491>
    4f3a:	44 89 35 7f 5d 01 00 	mov    %r14d,0x15d7f(%rip)        # 1acc0 <fwp_po_listen>
    4f41:	48 8d b5 70 ff ff ff 	lea    -0x90(%rbp),%rsi
    4f48:	bf 01 00 00 00       	mov    $0x1,%edi
    4f4d:	e8 de e1 ff ff       	call   3130 <clock_gettime@plt>
    4f52:	48 69 85 70 ff ff ff 	imul   $0x3b9aca00,-0x90(%rbp),%rax
    4f59:	00 ca 9a 3b 
    4f5d:	48 03 85 78 ff ff ff 	add    -0x88(%rbp),%rax
    4f64:	48 b9 00 f2 05 2a 01 	movabs $0x12a05f200,%rcx
    4f6b:	00 00 00 
    4f6e:	48 01 c1             	add    %rax,%rcx
    4f71:	48 89 0d 20 5e 02 00 	mov    %rcx,0x25e20(%rip)        # 2ad98 <fwp_po_give_up>
    4f78:	e9 66 f2 ff ff       	jmp    41e3 <fwp_main_thread+0xa83>
    4f7d:	41 89 c7             	mov    %eax,%r15d
    4f80:	45 85 ff             	test   %r15d,%r15d
    4f83:	0f 88 48 ff ff ff    	js     4ed1 <fwp_main_thread+0x1771>
    4f89:	48 8b 05 48 40 01 00 	mov    0x14048(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    4f90:	48 8b 38             	mov    (%rax),%rdi
    4f93:	48 8d 35 ef 05 01 00 	lea    0x105ef(%rip),%rsi        # 15589 <exec_in_fp0+0xd79>
    4f9a:	48 8d 15 e9 f9 00 00 	lea    0xf9e9(%rip),%rdx        # 1498a <exec_in_fp0+0x17a>
    4fa1:	31 c0                	xor    %eax,%eax
    4fa3:	e8 48 e3 ff ff       	call   32f0 <fprintf@plt>
    4fa8:	41 bc 03 00 00 00    	mov    $0x3,%r12d
    4fae:	e9 35 fe ff ff       	jmp    4de8 <fwp_main_thread+0x1688>
    4fb3:	48 8b 05 1e 40 01 00 	mov    0x1401e(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    4fba:	48 8b 38             	mov    (%rax),%rdi
    4fbd:	48 8d 35 f9 04 01 00 	lea    0x104f9(%rip),%rsi        # 154bd <exec_in_fp0+0xcad>
    4fc4:	48 8d 15 bf f9 00 00 	lea    0xf9bf(%rip),%rdx        # 1498a <exec_in_fp0+0x17a>
    4fcb:	31 c0                	xor    %eax,%eax
    4fcd:	e8 1e e3 ff ff       	call   32f0 <fprintf@plt>
    4fd2:	41 bc 03 00 00 00    	mov    $0x3,%r12d
    4fd8:	e9 0b fe ff ff       	jmp    4de8 <fwp_main_thread+0x1688>
    4fdd:	48 8b 05 f4 3f 01 00 	mov    0x13ff4(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    4fe4:	48 8b 38             	mov    (%rax),%rdi
    4fe7:	48 8d 35 f4 04 01 00 	lea    0x104f4(%rip),%rsi        # 154e2 <exec_in_fp0+0xcd2>
    4fee:	48 8d 15 95 f9 00 00 	lea    0xf995(%rip),%rdx        # 1498a <exec_in_fp0+0x17a>
    4ff5:	48 8d 0d 9e 08 01 00 	lea    0x1089e(%rip),%rcx        # 1589a <exec_in_fp0+0x108a>
    4ffc:	4d 89 f0             	mov    %r14,%r8
    4fff:	31 c0                	xor    %eax,%eax
    5001:	e8 ea e2 ff ff       	call   32f0 <fprintf@plt>
    5006:	41 bc 03 00 00 00    	mov    $0x3,%r12d
    500c:	e9 d7 fd ff ff       	jmp    4de8 <fwp_main_thread+0x1688>
    5011:	48 8b 05 c0 3f 01 00 	mov    0x13fc0(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    5018:	48 8b 38             	mov    (%rax),%rdi
    501b:	48 8d 35 1d 05 01 00 	lea    0x1051d(%rip),%rsi        # 1553f <exec_in_fp0+0xd2f>
    5022:	48 8d 15 61 f9 00 00 	lea    0xf961(%rip),%rdx        # 1498a <exec_in_fp0+0x17a>
    5029:	31 c0                	xor    %eax,%eax
    502b:	e8 c0 e2 ff ff       	call   32f0 <fprintf@plt>
    5030:	e9 de fe ff ff       	jmp    4f13 <fwp_main_thread+0x17b3>
    5035:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    503c:	00 00 00 00 

0000000000005040 <main>:
    5040:	55                   	push   %rbp
    5041:	48 89 e5             	mov    %rsp,%rbp
    5044:	41 57                	push   %r15
    5046:	41 56                	push   %r14
    5048:	41 55                	push   %r13
    504a:	41 54                	push   %r12
    504c:	53                   	push   %rbx
    504d:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    5054:	83 3d 19 52 01 00 00 	cmpl   $0x0,0x15219(%rip)        # 1a274 <fwp_gc+0xfec>
    505b:	75 05                	jne    5062 <main+0x22>
    505d:	e8 ae 2d 00 00       	call   7e10 <fwp_gc_init>
    5062:	48 89 2d a7 52 01 00 	mov    %rbp,0x152a7(%rip)        # 1a310 <fwp_gc+0x1088>
    5069:	48 8d 3d 60 dd 00 00 	lea    0xdd60(%rip),%rdi        # 12dd0 <fwp_gc_find_data>
    5070:	31 f6                	xor    %esi,%esi
    5072:	e8 c9 df ff ff       	call   3040 <dl_iterate_phdr@plt>
    5077:	83 3d fa 51 01 00 00 	cmpl   $0x0,0x151fa(%rip)        # 1a278 <fwp_gc+0xff0>
    507e:	0f 95 c1             	setne  %cl
    5081:	83 3d 90 53 01 00 00 	cmpl   $0x0,0x15390(%rip)        # 1a418 <fwp_gc+0x1190>
    5088:	0f 9f c0             	setg   %al
    508b:	20 c8                	and    %cl,%al
    508d:	0f b6 c8             	movzbl %al,%ecx
    5090:	89 0d e6 51 01 00    	mov    %ecx,0x151e6(%rip)        # 1a27c <fwp_gc+0xff4>
    5096:	83 3d e7 51 01 00 00 	cmpl   $0x0,0x151e7(%rip)        # 1a284 <fwp_gc+0xffc>
    509d:	74 16                	je     50b5 <main+0x75>
    509f:	48 8d 3d 0a de 00 00 	lea    0xde0a(%rip),%rdi        # 12eb0 <fwp_gc_report>
    50a6:	e8 15 e3 00 00       	call   133c0 <atexit>
    50ab:	83 3d ca 51 01 00 00 	cmpl   $0x0,0x151ca(%rip)        # 1a27c <fwp_gc+0xff4>
    50b2:	0f 95 c0             	setne  %al
    50b5:	84 c0                	test   %al,%al
    50b7:	74 43                	je     50fc <main+0xbc>
    50b9:	48 83 3d e7 51 01 00 	cmpq   $0x0,0x151e7(%rip)        # 1a2a8 <fwp_gc+0x1020>
    50c0:	00 
    50c1:	74 39                	je     50fc <main+0xbc>
    50c3:	48 8b 05 ce 53 01 00 	mov    0x153ce(%rip),%rax        # 1a498 <fwp_gc+0x1210>
    50ca:	48 2b 05 b7 41 01 00 	sub    0x141b7(%rip),%rax        # 19288 <fwp_gc>
    50d1:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    50d6:	f2 0f 58 05 92 53 01 	addsd  0x15392(%rip),%xmm0        # 1a470 <fwp_gc+0x11e8>
    50dd:	00 
    50de:	f2 0f 11 05 8a 53 01 	movsd  %xmm0,0x1538a(%rip)        # 1a470 <fwp_gc+0x11e8>
    50e5:	00 
    50e6:	48 c7 05 a7 53 01 00 	movq   $0x0,0x153a7(%rip)        # 1a498 <fwp_gc+0x1210>
    50ed:	00 00 00 00 
    50f1:	48 c7 05 8c 41 01 00 	movq   $0x0,0x1418c(%rip)        # 19288 <fwp_gc>
    50f8:	00 00 00 00 
    50fc:	48 8d 05 fd 35 01 00 	lea    0x135fd(%rip),%rax        # 18700 <fwp_fn_table>
    5103:	48 89 05 e6 5b 01 00 	mov    %rax,0x15be6(%rip)        # 1acf0 <fwp_fns>
    510a:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    510e:	66 0f 29 85 50 ff ff 	movapd %xmm0,-0xb0(%rbp)
    5115:	ff 
    5116:	66 0f 29 45 a0       	movapd %xmm0,-0x60(%rbp)
    511b:	66 0f 29 45 90       	movapd %xmm0,-0x70(%rbp)
    5120:	66 0f 29 45 80       	movapd %xmm0,-0x80(%rbp)
    5125:	66 0f 29 85 70 ff ff 	movapd %xmm0,-0x90(%rbp)
    512c:	ff 
    512d:	66 0f 29 85 60 ff ff 	movapd %xmm0,-0xa0(%rbp)
    5134:	ff 
    5135:	c7 85 50 ff ff ff 0b 	movl   $0xb,-0xb0(%rbp)
    513c:	00 00 00 
    513f:	48 8d 3d a2 f7 00 00 	lea    0xf7a2(%rip),%rdi        # 148e8 <exec_in_fp0+0xd8>
    5146:	e8 85 df ff ff       	call   30d0 <puts@plt>
    514b:	45 31 f6             	xor    %r14d,%r14d
    514e:	48 bb c5 4e ec c4 4e 	movabs $0x4ec4ec4ec4ec4ec5,%rbx
    5155:	ec c4 4e 
    5158:	49 bd 00 00 00 00 00 	movabs $0x8000000000000000,%r13
    515f:	00 00 80 
    5162:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5169:	1f 84 00 00 00 00 00 
    5170:	49 83 fe 03          	cmp    $0x3,%r14
    5174:	73 1a                	jae    5190 <main+0x150>
    5176:	48 8d 05 a3 f6 00 00 	lea    0xf6a3(%rip),%rax        # 14820 <exec_in_fp0+0x10>
    517d:	4e 8b 3c f0          	mov    (%rax,%r14,8),%r15
    5181:	eb 1c                	jmp    519f <main+0x15f>
    5183:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    518a:	84 00 00 00 00 00 
    5190:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    5196:	b8 07 00 00 00       	mov    $0x7,%eax
    519b:	4c 0f 44 f8          	cmove  %rax,%r15
    519f:	4c 89 ff             	mov    %r15,%rdi
    51a2:	48 8d b5 50 ff ff ff 	lea    -0xb0(%rbp),%rsi
    51a9:	e8 22 03 00 00       	call   54d0 <fwp_array_new_packed>
    51ae:	49 89 c4             	mov    %rax,%r12
    51b1:	48 2b 05 00 51 01 00 	sub    0x15100(%rip),%rax        # 1a2b8 <fwp_gc+0x1030>
    51b8:	48 8b 0d 21 51 01 00 	mov    0x15121(%rip),%rcx        # 1a2e0 <fwp_gc+0x1058>
    51bf:	48 c1 e1 10          	shl    $0x10,%rcx
    51c3:	48 39 c8             	cmp    %rcx,%rax
    51c6:	f2 0f 10 0d ca ef 00 	movsd  0xefca(%rip),%xmm1        # 14198 <_IO_stdin_used+0x198>
    51cd:	00 
    51ce:	f2 0f 10 15 ca ef 00 	movsd  0xefca(%rip),%xmm2        # 141a0 <_IO_stdin_used+0x1a0>
    51d5:	00 
    51d6:	f2 0f 10 1d ca ef 00 	movsd  0xefca(%rip),%xmm3        # 141a8 <_IO_stdin_used+0x1a8>
    51dd:	00 
    51de:	0f 83 8c 00 00 00    	jae    5270 <main+0x230>
    51e4:	48 8b 0d 15 51 01 00 	mov    0x15115(%rip),%rcx        # 1a300 <fwp_gc+0x1078>
    51eb:	48 89 c2             	mov    %rax,%rdx
    51ee:	48 c1 ea 10          	shr    $0x10,%rdx
    51f2:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    51f9:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    51fd:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5203:	75 1b                	jne    5220 <main+0x1e0>
    5205:	40 80 fe 02          	cmp    $0x2,%sil
    5209:	75 15                	jne    5220 <main+0x1e0>
    520b:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    520f:	48 05 28 02 00 00    	add    $0x228,%rax
    5215:	80 38 ff             	cmpb   $0xff,(%rax)
    5218:	74 2a                	je     5244 <main+0x204>
    521a:	c6 00 01             	movb   $0x1,(%rax)
    521d:	eb 51                	jmp    5270 <main+0x230>
    521f:	90                   	nop
    5220:	40 80 fe 01          	cmp    $0x1,%sil
    5224:	75 4a                	jne    5270 <main+0x230>
    5226:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    522a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    522e:	48 0f af c1          	imul   %rcx,%rax
    5232:	48 c1 e8 20          	shr    $0x20,%rax
    5236:	48 01 f0             	add    %rsi,%rax
    5239:	48 05 28 02 00 00    	add    $0x228,%rax
    523f:	80 38 ff             	cmpb   $0xff,(%rax)
    5242:	75 d6                	jne    521a <main+0x1da>
    5244:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    5248:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    524c:	e8 3f 13 00 00       	call   6590 <fwp_rc_forget_slot>
    5251:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    5255:	f2 0f 10 1d 4b ef 00 	movsd  0xef4b(%rip),%xmm3        # 141a8 <_IO_stdin_used+0x1a8>
    525c:	00 
    525d:	f2 0f 10 15 3b ef 00 	movsd  0xef3b(%rip),%xmm2        # 141a0 <_IO_stdin_used+0x1a0>
    5264:	00 
    5265:	f2 0f 10 0d 2b ef 00 	movsd  0xef2b(%rip),%xmm1        # 14198 <_IO_stdin_used+0x198>
    526c:	00 
    526d:	eb ab                	jmp    521a <main+0x1da>
    526f:	90                   	nop
    5270:	f2 0f 10 25 18 ef 00 	movsd  0xef18(%rip),%xmm4        # 14190 <_IO_stdin_used+0x190>
    5277:	00 
    5278:	4d 85 ff             	test   %r15,%r15
    527b:	bf 84 04 00 00       	mov    $0x484,%edi
    5280:	41 b8 21 00 00 00    	mov    $0x21,%r8d
    5286:	41 b9 42 00 00 00    	mov    $0x42,%r9d
    528c:	0f 84 de 00 00 00    	je     5370 <main+0x330>
    5292:	48 8d 35 77 f3 00 00 	lea    0xf377(%rip),%rsi        # 14610 <main.edge>
    5299:	f2 0f 10 25 ef ee 00 	movsd  0xeeef(%rip),%xmm4        # 14190 <_IO_stdin_used+0x190>
    52a0:	00 
    52a1:	31 c9                	xor    %ecx,%ecx
    52a3:	eb 2c                	jmp    52d1 <main+0x291>
    52a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    52ac:	00 00 00 00 
    52b0:	41 89 44 8c 08       	mov    %eax,0x8(%r12,%rcx,4)
    52b5:	f2 0f 59 c2          	mulsd  %xmm2,%xmm0
    52b9:	f2 0f 58 c3          	addsd  %xmm3,%xmm0
    52bd:	f2 0f 58 e0          	addsd  %xmm0,%xmm4
    52c1:	48 ff c1             	inc    %rcx
    52c4:	48 83 c6 08          	add    $0x8,%rsi
    52c8:	49 39 cf             	cmp    %rcx,%r15
    52cb:	0f 84 9f 00 00 00    	je     5370 <main+0x330>
    52d1:	48 89 c8             	mov    %rcx,%rax
    52d4:	48 f7 e3             	mul    %rbx
    52d7:	48 c1 ea 02          	shr    $0x2,%rdx
    52db:	8d 04 52             	lea    (%rdx,%rdx,2),%eax
    52de:	8d 04 82             	lea    (%rdx,%rax,4),%eax
    52e1:	89 ca                	mov    %ecx,%edx
    52e3:	29 c2                	sub    %eax,%edx
    52e5:	83 c2 fa             	add    $0xfffffffa,%edx
    52e8:	0f 57 c0             	xorps  %xmm0,%xmm0
    52eb:	f2 0f 2a c2          	cvtsi2sd %edx,%xmm0
    52ef:	f2 0f 59 c1          	mulsd  %xmm1,%xmm0
    52f3:	4c 89 e8             	mov    %r13,%rax
    52f6:	49 83 fe 04          	cmp    $0x4,%r14
    52fa:	74 19                	je     5315 <main+0x2d5>
    52fc:	49 83 fe 03          	cmp    $0x3,%r14
    5300:	75 0e                	jne    5310 <main+0x2d0>
    5302:	48 8b 06             	mov    (%rsi),%rax
    5305:	eb 0e                	jmp    5315 <main+0x2d5>
    5307:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    530e:	00 00 
    5310:	66 48 0f 7e c0       	movq   %xmm0,%rax
    5315:	49 83 3c 24 00       	cmpq   $0x0,(%r12)
    531a:	0f 88 78 01 00 00    	js     5498 <main+0x458>
    5320:	8b 95 50 ff ff ff    	mov    -0xb0(%rbp),%edx
    5326:	83 fa 0a             	cmp    $0xa,%edx
    5329:	77 2f                	ja     535a <main+0x31a>
    532b:	0f a3 d7             	bt     %edx,%edi
    532e:	72 80                	jb     52b0 <main+0x270>
    5330:	41 0f a3 d0          	bt     %edx,%r8d
    5334:	72 1a                	jb     5350 <main+0x310>
    5336:	41 0f a3 d1          	bt     %edx,%r9d
    533a:	73 1e                	jae    535a <main+0x31a>
    533c:	66 41 89 44 4c 08    	mov    %ax,0x8(%r12,%rcx,2)
    5342:	e9 6e ff ff ff       	jmp    52b5 <main+0x275>
    5347:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    534e:	00 00 
    5350:	41 88 44 0c 08       	mov    %al,0x8(%r12,%rcx,1)
    5355:	e9 5b ff ff ff       	jmp    52b5 <main+0x275>
    535a:	49 89 44 cc 08       	mov    %rax,0x8(%r12,%rcx,8)
    535f:	e9 51 ff ff ff       	jmp    52b5 <main+0x275>
    5364:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    536b:	00 00 00 00 00 
    5370:	f2 0f 11 65 c8       	movsd  %xmm4,-0x38(%rbp)
    5375:	48 8b 1d ac 59 01 00 	mov    0x159ac(%rip),%rbx        # 1ad28 <measured_calls>
    537c:	48 8b 05 ad 59 01 00 	mov    0x159ad(%rip),%rax        # 1ad30 <measured_bytes>
    5383:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    5387:	48 8b 05 aa 59 01 00 	mov    0x159aa(%rip),%rax        # 1ad38 <measured_retains>
    538e:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    5392:	48 8b 05 a7 59 01 00 	mov    0x159a7(%rip),%rax        # 1ad40 <measured_scopes>
    5399:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
    539d:	f3 0f 7e 05 eb 50 01 	movq   0x150eb(%rip),%xmm0        # 1a490 <fwp_gc+0x1208>
    53a4:	00 
    53a5:	66 0f d6 45 d0       	movq   %xmm0,-0x30(%rbp)
    53aa:	4c 89 e7             	mov    %r12,%rdi
    53ad:	e8 1e 03 00 00       	call   56d0 <f0>
    53b2:	49 89 c2             	mov    %rax,%r10
    53b5:	49 83 fe 02          	cmp    $0x2,%r14
    53b9:	77 13                	ja     53ce <main+0x38e>
    53bb:	f3 0f 7e 45 c8       	movq   -0x38(%rbp),%xmm0
    53c0:	66 48 0f 7e c0       	movq   %xmm0,%rax
    53c5:	49 39 c2             	cmp    %rax,%r10
    53c8:	0f 85 a5 00 00 00    	jne    5473 <main+0x433>
    53ce:	48 8b 0d 53 59 01 00 	mov    0x15953(%rip),%rcx        # 1ad28 <measured_calls>
    53d5:	48 29 d9             	sub    %rbx,%rcx
    53d8:	48 83 f9 02          	cmp    $0x2,%rcx
    53dc:	0f 82 98 00 00 00    	jb     547a <main+0x43a>
    53e2:	f2 0f 10 05 a6 50 01 	movsd  0x150a6(%rip),%xmm0        # 1a490 <fwp_gc+0x1208>
    53e9:	00 
    53ea:	f2 0f 10 4d d0       	movsd  -0x30(%rbp),%xmm1
    53ef:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
    53f3:	0f 83 88 00 00 00    	jae    5481 <main+0x441>
    53f9:	4c 8b 05 30 59 01 00 	mov    0x15930(%rip),%r8        # 1ad30 <measured_bytes>
    5400:	4c 2b 45 c0          	sub    -0x40(%rbp),%r8
    5404:	4c 8b 0d 2d 59 01 00 	mov    0x1592d(%rip),%r9        # 1ad38 <measured_retains>
    540b:	4c 2b 4d b8          	sub    -0x48(%rbp),%r9
    540f:	4c 8b 1d 2a 59 01 00 	mov    0x1592a(%rip),%r11        # 1ad40 <measured_scopes>
    5416:	4c 2b 5d b0          	sub    -0x50(%rbp),%r11
    541a:	4d 85 f6             	test   %r14,%r14
    541d:	48 8d 35 60 f5 00 00 	lea    0xf560(%rip),%rsi        # 14984 <exec_in_fp0+0x174>
    5424:	48 8d 05 5f fd 00 00 	lea    0xfd5f(%rip),%rax        # 1518a <exec_in_fp0+0x97a>
    542b:	48 0f 44 f0          	cmove  %rax,%rsi
    542f:	f2 0f 5c c1          	subsd  %xmm1,%xmm0
    5433:	48 8d 3d b9 f4 00 00 	lea    0xf4b9(%rip),%rdi        # 148f3 <exec_in_fp0+0xe3>
    543a:	4c 89 fa             	mov    %r15,%rdx
    543d:	b0 01                	mov    $0x1,%al
    543f:	41 52                	push   %r10
    5441:	41 53                	push   %r11
    5443:	e8 78 dd ff ff       	call   31c0 <printf@plt>
    5448:	48 83 c4 10          	add    $0x10,%rsp
    544c:	49 ff c6             	inc    %r14
    544f:	49 83 fe 05          	cmp    $0x5,%r14
    5453:	48 bb c5 4e ec c4 4e 	movabs $0x4ec4ec4ec4ec4ec5,%rbx
    545a:	ec c4 4e 
    545d:	0f 85 0d fd ff ff    	jne    5170 <main+0x130>
    5463:	48 8d 3d 1d f5 00 00 	lea    0xf51d(%rip),%rdi        # 14987 <exec_in_fp0+0x177>
    546a:	e8 61 dc ff ff       	call   30d0 <puts@plt>
    546f:	31 c0                	xor    %eax,%eax
    5471:	eb 13                	jmp    5486 <main+0x446>
    5473:	b8 aa 00 00 00       	mov    $0xaa,%eax
    5478:	eb 0c                	jmp    5486 <main+0x446>
    547a:	b8 ac 00 00 00       	mov    $0xac,%eax
    547f:	eb 05                	jmp    5486 <main+0x446>
    5481:	b8 ad 00 00 00       	mov    $0xad,%eax
    5486:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
    548d:	5b                   	pop    %rbx
    548e:	41 5c                	pop    %r12
    5490:	41 5d                	pop    %r13
    5492:	41 5e                	pop    %r14
    5494:	41 5f                	pop    %r15
    5496:	5d                   	pop    %rbp
    5497:	c3                   	ret
    5498:	e8 a3 11 00 00       	call   6640 <fwp_flush>
    549d:	48 8b 05 34 3b 01 00 	mov    0x13b34(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    54a4:	48 8b 38             	mov    (%rax),%rdi
    54a7:	48 8d 35 a0 f5 00 00 	lea    0xf5a0(%rip),%rsi        # 14a4e <exec_in_fp0+0x23e>
    54ae:	48 8d 15 c9 04 01 00 	lea    0x104c9(%rip),%rdx        # 1597e <exec_in_fp0+0x116e>
    54b5:	31 c0                	xor    %eax,%eax
    54b7:	e8 34 de ff ff       	call   32f0 <fprintf@plt>
    54bc:	bf 65 00 00 00       	mov    $0x65,%edi
    54c1:	e8 9a df ff ff       	call   3460 <exit@plt>
    54c6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    54cd:	00 00 00 

00000000000054d0 <fwp_array_new_packed>:
    54d0:	41 56                	push   %r14
    54d2:	53                   	push   %rbx
    54d3:	50                   	push   %rax
    54d4:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    54db:	ff ff 1f 
    54de:	48 39 c7             	cmp    %rax,%rdi
    54e1:	0f 83 b7 01 00 00    	jae    569e <fwp_array_new_packed+0x1ce>
    54e7:	48 89 fb             	mov    %rdi,%rbx
    54ea:	48 85 f6             	test   %rsi,%rsi
    54ed:	74 23                	je     5512 <fwp_array_new_packed+0x42>
    54ef:	8b 06                	mov    (%rsi),%eax
    54f1:	48 83 f8 0a          	cmp    $0xa,%rax
    54f5:	77 0e                	ja     5505 <fwp_array_new_packed+0x35>
    54f7:	b9 e7 04 00 00       	mov    $0x4e7,%ecx
    54fc:	0f a3 c1             	bt     %eax,%ecx
    54ff:	0f 82 a1 00 00 00    	jb     55a6 <fwp_array_new_packed+0xd6>
    5505:	48 8d 0c dd 00 00 00 	lea    0x0(,%rbx,8),%rcx
    550c:	00 
    550d:	e9 a3 00 00 00       	jmp    55b5 <fwp_array_new_packed+0xe5>
    5512:	48 8d 14 dd 08 00 00 	lea    0x8(,%rbx,8),%rdx
    5519:	00 
    551a:	48 ff 05 07 58 01 00 	incq   0x15807(%rip)        # 1ad28 <measured_calls>
    5521:	48 01 15 08 58 01 00 	add    %rdx,0x15808(%rip)        # 1ad30 <measured_bytes>
    5528:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    552f:	77 68                	ja     5599 <fwp_array_new_packed+0xc9>
    5531:	48 8d 42 0f          	lea    0xf(%rdx),%rax
    5535:	48 c1 e8 04          	shr    $0x4,%rax
    5539:	48 8d 0d 48 3d 01 00 	lea    0x13d48(%rip),%rcx        # 19288 <fwp_gc>
    5540:	0f b6 b4 08 e8 0b 00 	movzbl 0xbe8(%rax,%rcx,1),%esi
    5547:	00 
    5548:	8b 84 b1 48 0b 00 00 	mov    0xb48(%rcx,%rsi,4),%eax
    554f:	48 29 05 32 3d 01 00 	sub    %rax,0x13d32(%rip)        # 19288 <fwp_gc>
    5556:	78 41                	js     5599 <fwp_array_new_packed+0xc9>
    5558:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    555c:	48 8d 3c f1          	lea    (%rcx,%rsi,8),%rdi
    5560:	48 81 c7 88 07 00 00 	add    $0x788,%rdi
    5567:	4c 8b 37             	mov    (%rdi),%r14
    556a:	4d 85 f6             	test   %r14,%r14
    556d:	74 0e                	je     557d <fwp_array_new_packed+0xad>
    556f:	49 8b 0e             	mov    (%r14),%rcx
    5572:	48 f7 d1             	not    %rcx
    5575:	48 89 0f             	mov    %rcx,(%rdi)
    5578:	e9 06 01 00 00       	jmp    5683 <fwp_array_new_packed+0x1b3>
    557d:	4c 8b b4 f1 90 07 00 	mov    0x790(%rcx,%rsi,8),%r14
    5584:	00 
    5585:	48 8b bc f1 98 07 00 	mov    0x798(%rcx,%rsi,8),%rdi
    558c:	00 
    558d:	4c 29 f7             	sub    %r14,%rdi
    5590:	48 39 c7             	cmp    %rax,%rdi
    5593:	0f 83 d8 00 00 00    	jae    5671 <fwp_array_new_packed+0x1a1>
    5599:	48 89 d7             	mov    %rdx,%rdi
    559c:	be 02 00 00 00       	mov    $0x2,%esi
    55a1:	e9 aa 00 00 00       	jmp    5650 <fwp_array_new_packed+0x180>
    55a6:	48 8d 0d 8b f2 00 00 	lea    0xf28b(%rip),%rcx        # 14838 <exec_in_fp0+0x28>
    55ad:	48 8b 0c c1          	mov    (%rcx,%rax,8),%rcx
    55b1:	48 0f af cb          	imul   %rbx,%rcx
    55b5:	48 8d 51 08          	lea    0x8(%rcx),%rdx
    55b9:	83 f8 0b             	cmp    $0xb,%eax
    55bc:	0f 87 58 ff ff ff    	ja     551a <fwp_array_new_packed+0x4a>
    55c2:	be ef 0d 00 00       	mov    $0xdef,%esi
    55c7:	0f a3 c6             	bt     %eax,%esi
    55ca:	0f 83 4a ff ff ff    	jae    551a <fwp_array_new_packed+0x4a>
    55d0:	48 ff 05 51 57 01 00 	incq   0x15751(%rip)        # 1ad28 <measured_calls>
    55d7:	48 01 15 52 57 01 00 	add    %rdx,0x15752(%rip)        # 1ad30 <measured_bytes>
    55de:	48 81 f9 f8 3f 00 00 	cmp    $0x3ff8,%rcx
    55e5:	77 61                	ja     5648 <fwp_array_new_packed+0x178>
    55e7:	48 83 c1 17          	add    $0x17,%rcx
    55eb:	48 c1 e9 04          	shr    $0x4,%rcx
    55ef:	48 8d 05 92 3c 01 00 	lea    0x13c92(%rip),%rax        # 19288 <fwp_gc>
    55f6:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    55fd:	00 
    55fe:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    5605:	48 29 0d 7c 3c 01 00 	sub    %rcx,0x13c7c(%rip)        # 19288 <fwp_gc>
    560c:	78 3a                	js     5648 <fwp_array_new_packed+0x178>
    560e:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    5612:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    5616:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    561d:	4c 8b 37             	mov    (%rdi),%r14
    5620:	4d 85 f6             	test   %r14,%r14
    5623:	74 0b                	je     5630 <fwp_array_new_packed+0x160>
    5625:	49 8b 06             	mov    (%r14),%rax
    5628:	48 f7 d0             	not    %rax
    562b:	48 89 07             	mov    %rax,(%rdi)
    562e:	eb 3a                	jmp    566a <fwp_array_new_packed+0x19a>
    5630:	4c 8b b4 f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r14
    5637:	00 
    5638:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    563f:	00 
    5640:	4c 29 f7             	sub    %r14,%rdi
    5643:	48 39 cf             	cmp    %rcx,%rdi
    5646:	73 12                	jae    565a <fwp_array_new_packed+0x18a>
    5648:	48 89 d7             	mov    %rdx,%rdi
    564b:	be 01 00 00 00       	mov    $0x1,%esi
    5650:	e8 cb 26 00 00       	call   7d20 <fwp_gc_alloc_slow>
    5655:	49 89 c6             	mov    %rax,%r14
    5658:	eb 36                	jmp    5690 <fwp_array_new_packed+0x1c0>
    565a:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    565e:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    5664:	4c 01 f1             	add    %r14,%rcx
    5667:	48 89 08             	mov    %rcx,(%rax)
    566a:	4c 89 f7             	mov    %r14,%rdi
    566d:	31 f6                	xor    %esi,%esi
    566f:	eb 1a                	jmp    568b <fwp_array_new_packed+0x1bb>
    5671:	48 8d 0c f1          	lea    (%rcx,%rsi,8),%rcx
    5675:	48 81 c1 90 07 00 00 	add    $0x790,%rcx
    567c:	49 8d 14 06          	lea    (%r14,%rax,1),%rdx
    5680:	48 89 11             	mov    %rdx,(%rcx)
    5683:	4c 89 f7             	mov    %r14,%rdi
    5686:	31 f6                	xor    %esi,%esi
    5688:	48 89 c2             	mov    %rax,%rdx
    568b:	e8 80 db ff ff       	call   3210 <memset@plt>
    5690:	49 89 1e             	mov    %rbx,(%r14)
    5693:	4c 89 f0             	mov    %r14,%rax
    5696:	48 83 c4 08          	add    $0x8,%rsp
    569a:	5b                   	pop    %rbx
    569b:	41 5e                	pop    %r14
    569d:	c3                   	ret
    569e:	e8 9d 0f 00 00       	call   6640 <fwp_flush>
    56a3:	48 8b 05 2e 39 01 00 	mov    0x1392e(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    56aa:	48 8b 38             	mov    (%rax),%rdi
    56ad:	48 8d 35 9a f3 00 00 	lea    0xf39a(%rip),%rsi        # 14a4e <exec_in_fp0+0x23e>
    56b4:	48 8d 15 a2 f3 00 00 	lea    0xf3a2(%rip),%rdx        # 14a5d <exec_in_fp0+0x24d>
    56bb:	31 c0                	xor    %eax,%eax
    56bd:	e8 2e dc ff ff       	call   32f0 <fprintf@plt>
    56c2:	bf 65 00 00 00       	mov    $0x65,%edi
    56c7:	e8 94 dd ff ff       	call   3460 <exit@plt>
    56cc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000056d0 <f0>:
    56d0:	55                   	push   %rbp
    56d1:	41 57                	push   %r15
    56d3:	41 56                	push   %r14
    56d5:	41 55                	push   %r13
    56d7:	41 54                	push   %r12
    56d9:	53                   	push   %rbx
    56da:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    56e1:	48 89 fb             	mov    %rdi,%rbx
    56e4:	0f 10 05 85 ea 00 00 	movups 0xea85(%rip),%xmm0        # 14170 <_IO_stdin_used+0x170>
    56eb:	0f 29 44 24 70       	movaps %xmm0,0x70(%rsp)
    56f0:	0f 10 05 89 ea 00 00 	movups 0xea89(%rip),%xmm0        # 14180 <_IO_stdin_used+0x180>
    56f7:	0f 29 44 24 60       	movaps %xmm0,0x60(%rsp)
    56fc:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
    5701:	48 ff 05 38 56 01 00 	incq   0x15638(%rip)        # 1ad40 <measured_scopes>
    5708:	48 8b 05 39 56 01 00 	mov    0x15639(%rip),%rax        # 1ad48 <fwp_cleanups>
    570f:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
    5714:	48 8d 05 e5 d9 00 00 	lea    0xd9e5(%rip),%rax        # 13100 <fwp_owner_release0>
    571b:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    5720:	48 8d 44 24 28       	lea    0x28(%rsp),%rax
    5725:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
    572a:	4c 8d 7c 24 48       	lea    0x48(%rsp),%r15
    572f:	4c 89 3d 12 56 01 00 	mov    %r15,0x15612(%rip)        # 1ad48 <fwp_cleanups>
    5736:	48 8d 0d 83 34 01 00 	lea    0x13483(%rip),%rcx        # 18bc0 <d2>
    573d:	48 8d 7c 24 60       	lea    0x60(%rsp),%rdi
    5742:	48 89 de             	mov    %rbx,%rsi
    5745:	48 89 ca             	mov    %rcx,%rdx
    5748:	e8 33 10 00 00       	call   6780 <fwp_p_array_map_typed>
    574d:	4c 39 3d f4 55 01 00 	cmp    %r15,0x155f4(%rip)        # 1ad48 <fwp_cleanups>
    5754:	0f 85 a9 01 00 00    	jne    5903 <f0+0x233>
    575a:	49 89 c6             	mov    %rax,%r14
    575d:	48 8b 44 24 48       	mov    0x48(%rsp),%rax
    5762:	48 89 05 df 55 01 00 	mov    %rax,0x155df(%rip)        # 1ad48 <fwp_cleanups>
    5769:	48 8d 44 24 60       	lea    0x60(%rsp),%rax
    576e:	48 89 df             	mov    %rbx,%rdi
    5771:	e8 9a d9 00 00       	call   13110 <fwp_drop0>
    5776:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    577b:	48 ff 05 be 55 01 00 	incq   0x155be(%rip)        # 1ad40 <measured_scopes>
    5782:	48 8b 05 bf 55 01 00 	mov    0x155bf(%rip),%rax        # 1ad48 <fwp_cleanups>
    5789:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    578e:	48 8d 05 5b da 00 00 	lea    0xda5b(%rip),%rax        # 131f0 <fwp_owner_release1>
    5795:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    579a:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    579f:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    57a4:	4c 8d 7c 24 30       	lea    0x30(%rsp),%r15
    57a9:	4c 89 3d 98 55 01 00 	mov    %r15,0x15598(%rip)        # 1ad48 <fwp_cleanups>
    57b0:	48 8d 0d 09 34 01 00 	lea    0x13409(%rip),%rcx        # 18bc0 <d2>
    57b7:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    57bc:	4c 89 f6             	mov    %r14,%rsi
    57bf:	48 89 ca             	mov    %rcx,%rdx
    57c2:	e8 b9 0f 00 00       	call   6780 <fwp_p_array_map_typed>
    57c7:	4c 39 3d 7a 55 01 00 	cmp    %r15,0x1557a(%rip)        # 1ad48 <fwp_cleanups>
    57ce:	0f 85 2f 01 00 00    	jne    5903 <f0+0x233>
    57d4:	48 89 c3             	mov    %rax,%rbx
    57d7:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
    57de:	ff ff 7f 
    57e1:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    57e6:	48 89 05 5b 55 01 00 	mov    %rax,0x1555b(%rip)        # 1ad48 <fwp_cleanups>
    57ed:	48 8d 44 24 70       	lea    0x70(%rsp),%rax
    57f2:	4c 89 f7             	mov    %r14,%rdi
    57f5:	e8 16 d9 00 00       	call   13110 <fwp_drop0>
    57fa:	48 ff 05 3f 55 01 00 	incq   0x1553f(%rip)        # 1ad40 <measured_scopes>
    5801:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    5806:	48 8b 05 3b 55 01 00 	mov    0x1553b(%rip),%rax        # 1ad48 <fwp_cleanups>
    580d:	48 89 04 24          	mov    %rax,(%rsp)
    5811:	48 8d 05 e8 d9 00 00 	lea    0xd9e8(%rip),%rax        # 13200 <fwp_owner_release2>
    5818:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    581d:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
    5822:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    5827:	48 89 e0             	mov    %rsp,%rax
    582a:	48 89 05 17 55 01 00 	mov    %rax,0x15517(%rip)        # 1ad48 <fwp_cleanups>
    5831:	48 8b 0b             	mov    (%rbx),%rcx
    5834:	48 8d 04 4d 00 00 00 	lea    0x0(,%rcx,2),%rax
    583b:	00 
    583c:	48 85 c0             	test   %rax,%rax
    583f:	74 77                	je     58b8 <f0+0x1e8>
    5841:	48 89 dd             	mov    %rbx,%rbp
    5844:	48 83 c5 08          	add    $0x8,%rbp
    5848:	49 8d 44 24 01       	lea    0x1(%r12),%rax
    584d:	45 31 ed             	xor    %r13d,%r13d
    5850:	4c 8d 35 79 54 01 00 	lea    0x15479(%rip),%r14        # 1acd0 <fc21>
    5857:	4c 8d bc 24 80 00 00 	lea    0x80(%rsp),%r15
    585e:	00 
    585f:	eb 41                	jmp    58a2 <f0+0x1d2>
    5861:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5868:	0f 1f 84 00 00 00 00 
    586f:	00 
    5870:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    5874:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
    587b:	00 
    587c:	4c 89 f7             	mov    %r14,%rdi
    587f:	be 02 00 00 00       	mov    $0x2,%esi
    5884:	4c 89 fa             	mov    %r15,%rdx
    5887:	b9 01 00 00 00       	mov    $0x1,%ecx
    588c:	e8 5f 11 00 00       	call   69f0 <fwp_apply_borrowed_prefix>
    5891:	49 ff c5             	inc    %r13
    5894:	48 8b 0b             	mov    (%rbx),%rcx
    5897:	48 89 ca             	mov    %rcx,%rdx
    589a:	4c 21 e2             	and    %r12,%rdx
    589d:	49 39 d5             	cmp    %rdx,%r13
    58a0:	73 1c                	jae    58be <f0+0x1ee>
    58a2:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
    58a9:	00 
    58aa:	48 89 e8             	mov    %rbp,%rax
    58ad:	48 85 c9             	test   %rcx,%rcx
    58b0:	79 be                	jns    5870 <f0+0x1a0>
    58b2:	48 8b 43 10          	mov    0x10(%rbx),%rax
    58b6:	eb b8                	jmp    5870 <f0+0x1a0>
    58b8:	49 ff c4             	inc    %r12
    58bb:	4c 89 e0             	mov    %r12,%rax
    58be:	49 89 c6             	mov    %rax,%r14
    58c1:	48 8d 05 08 54 01 00 	lea    0x15408(%rip),%rax        # 1acd0 <fc21>
    58c8:	48 89 e0             	mov    %rsp,%rax
    58cb:	48 39 05 76 54 01 00 	cmp    %rax,0x15476(%rip)        # 1ad48 <fwp_cleanups>
    58d2:	75 2f                	jne    5903 <f0+0x233>
    58d4:	48 8b 04 24          	mov    (%rsp),%rax
    58d8:	48 89 05 69 54 01 00 	mov    %rax,0x15469(%rip)        # 1ad48 <fwp_cleanups>
    58df:	48 8d 05 ea 53 01 00 	lea    0x153ea(%rip),%rax        # 1acd0 <fc21>
    58e6:	48 89 df             	mov    %rbx,%rdi
    58e9:	e8 22 d8 00 00       	call   13110 <fwp_drop0>
    58ee:	4c 89 f0             	mov    %r14,%rax
    58f1:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    58f8:	5b                   	pop    %rbx
    58f9:	41 5c                	pop    %r12
    58fb:	41 5d                	pop    %r13
    58fd:	41 5e                	pop    %r14
    58ff:	41 5f                	pop    %r15
    5901:	5d                   	pop    %rbp
    5902:	c3                   	ret
    5903:	e8 68 d7 ff ff       	call   3070 <abort@plt>
    5908:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    590f:	00 

0000000000005910 <e0>:
    5910:	53                   	push   %rbx
    5911:	48 89 fb             	mov    %rdi,%rbx
    5914:	48 8b 3f             	mov    (%rdi),%rdi
    5917:	e8 44 0a 00 00       	call   6360 <fwp_rc_share>
    591c:	48 8b 3b             	mov    (%rbx),%rdi
    591f:	e8 ac fd ff ff       	call   56d0 <f0>
    5924:	48 89 c3             	mov    %rax,%rbx
    5927:	48 89 c7             	mov    %rax,%rdi
    592a:	e8 31 0a 00 00       	call   6360 <fwp_rc_share>
    592f:	48 89 d8             	mov    %rbx,%rax
    5932:	5b                   	pop    %rbx
    5933:	c3                   	ret
    5934:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    593b:	00 00 00 00 00 

0000000000005940 <e1>:
    5940:	55                   	push   %rbp
    5941:	41 57                	push   %r15
    5943:	41 56                	push   %r14
    5945:	41 55                	push   %r13
    5947:	41 54                	push   %r12
    5949:	53                   	push   %rbx
    594a:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    5951:	48 89 fb             	mov    %rdi,%rbx
    5954:	48 8b 3f             	mov    (%rdi),%rdi
    5957:	e8 04 0a 00 00       	call   6360 <fwp_rc_share>
    595c:	48 8b 1b             	mov    (%rbx),%rbx
    595f:	0f 10 05 da e7 00 00 	movups 0xe7da(%rip),%xmm0        # 14140 <_IO_stdin_used+0x140>
    5966:	0f 29 44 24 70       	movaps %xmm0,0x70(%rsp)
    596b:	0f 10 05 de e7 00 00 	movups 0xe7de(%rip),%xmm0        # 14150 <_IO_stdin_used+0x150>
    5972:	0f 29 44 24 60       	movaps %xmm0,0x60(%rsp)
    5977:	48 89 5c 24 28       	mov    %rbx,0x28(%rsp)
    597c:	48 ff 05 bd 53 01 00 	incq   0x153bd(%rip)        # 1ad40 <measured_scopes>
    5983:	48 8b 05 be 53 01 00 	mov    0x153be(%rip),%rax        # 1ad48 <fwp_cleanups>
    598a:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
    598f:	48 8d 05 da 0c 00 00 	lea    0xcda(%rip),%rax        # 6670 <fwp_owner_release3>
    5996:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    599b:	48 8d 44 24 28       	lea    0x28(%rsp),%rax
    59a0:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
    59a5:	4c 8d 7c 24 48       	lea    0x48(%rsp),%r15
    59aa:	4c 89 3d 97 53 01 00 	mov    %r15,0x15397(%rip)        # 1ad48 <fwp_cleanups>
    59b1:	48 8d 0d 48 31 01 00 	lea    0x13148(%rip),%rcx        # 18b00 <d1>
    59b8:	48 8d 7c 24 60       	lea    0x60(%rsp),%rdi
    59bd:	48 89 de             	mov    %rbx,%rsi
    59c0:	48 89 ca             	mov    %rcx,%rdx
    59c3:	e8 b8 0d 00 00       	call   6780 <fwp_p_array_map_typed>
    59c8:	4c 39 3d 79 53 01 00 	cmp    %r15,0x15379(%rip)        # 1ad48 <fwp_cleanups>
    59cf:	0f 85 a5 01 00 00    	jne    5b7a <e1+0x23a>
    59d5:	49 89 c6             	mov    %rax,%r14
    59d8:	48 8b 44 24 48       	mov    0x48(%rsp),%rax
    59dd:	48 89 05 64 53 01 00 	mov    %rax,0x15364(%rip)        # 1ad48 <fwp_cleanups>
    59e4:	48 8d 44 24 60       	lea    0x60(%rsp),%rax
    59e9:	48 89 df             	mov    %rbx,%rdi
    59ec:	e8 8f 0c 00 00       	call   6680 <fwp_drop1>
    59f1:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    59f6:	48 ff 05 43 53 01 00 	incq   0x15343(%rip)        # 1ad40 <measured_scopes>
    59fd:	48 8b 05 44 53 01 00 	mov    0x15344(%rip),%rax        # 1ad48 <fwp_cleanups>
    5a04:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    5a09:	48 8d 05 50 0d 00 00 	lea    0xd50(%rip),%rax        # 6760 <fwp_owner_release4>
    5a10:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    5a15:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    5a1a:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    5a1f:	4c 8d 7c 24 30       	lea    0x30(%rsp),%r15
    5a24:	4c 89 3d 1d 53 01 00 	mov    %r15,0x1531d(%rip)        # 1ad48 <fwp_cleanups>
    5a2b:	48 8d 0d ce 30 01 00 	lea    0x130ce(%rip),%rcx        # 18b00 <d1>
    5a32:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    5a37:	4c 89 f6             	mov    %r14,%rsi
    5a3a:	48 89 ca             	mov    %rcx,%rdx
    5a3d:	e8 3e 0d 00 00       	call   6780 <fwp_p_array_map_typed>
    5a42:	4c 39 3d ff 52 01 00 	cmp    %r15,0x152ff(%rip)        # 1ad48 <fwp_cleanups>
    5a49:	0f 85 2b 01 00 00    	jne    5b7a <e1+0x23a>
    5a4f:	48 89 c3             	mov    %rax,%rbx
    5a52:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    5a57:	48 89 05 ea 52 01 00 	mov    %rax,0x152ea(%rip)        # 1ad48 <fwp_cleanups>
    5a5e:	48 8d 44 24 70       	lea    0x70(%rsp),%rax
    5a63:	4c 89 f7             	mov    %r14,%rdi
    5a66:	e8 15 0c 00 00       	call   6680 <fwp_drop1>
    5a6b:	48 ff 05 ce 52 01 00 	incq   0x152ce(%rip)        # 1ad40 <measured_scopes>
    5a72:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    5a77:	48 8b 05 ca 52 01 00 	mov    0x152ca(%rip),%rax        # 1ad48 <fwp_cleanups>
    5a7e:	48 89 04 24          	mov    %rax,(%rsp)
    5a82:	48 8d 05 e7 0c 00 00 	lea    0xce7(%rip),%rax        # 6770 <fwp_owner_release5>
    5a89:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    5a8e:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
    5a93:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    5a98:	48 89 e2             	mov    %rsp,%rdx
    5a9b:	48 89 15 a6 52 01 00 	mov    %rdx,0x152a6(%rip)        # 1ad48 <fwp_cleanups>
    5aa2:	48 8b 0b             	mov    (%rbx),%rcx
    5aa5:	48 8d 04 4d 00 00 00 	lea    0x0(,%rcx,2),%rax
    5aac:	00 
    5aad:	48 85 c0             	test   %rax,%rax
    5ab0:	0f 84 7a 00 00 00    	je     5b30 <e1+0x1f0>
    5ab6:	49 bd ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r13
    5abd:	ff ff 7f 
    5ac0:	48 89 dd             	mov    %rbx,%rbp
    5ac3:	48 83 c5 08          	add    $0x8,%rbp
    5ac7:	45 31 e4             	xor    %r12d,%r12d
    5aca:	4c 8d 35 d7 51 01 00 	lea    0x151d7(%rip),%r14        # 1aca8 <fc13>
    5ad1:	4c 8d bc 24 80 00 00 	lea    0x80(%rsp),%r15
    5ad8:	00 
    5ad9:	31 c0                	xor    %eax,%eax
    5adb:	eb 35                	jmp    5b12 <e1+0x1d2>
    5add:	0f 1f 00             	nopl   (%rax)
    5ae0:	42 8b 04 a0          	mov    (%rax,%r12,4),%eax
    5ae4:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
    5aeb:	00 
    5aec:	4c 89 f7             	mov    %r14,%rdi
    5aef:	be 02 00 00 00       	mov    $0x2,%esi
    5af4:	4c 89 fa             	mov    %r15,%rdx
    5af7:	b9 01 00 00 00       	mov    $0x1,%ecx
    5afc:	e8 ef 0e 00 00       	call   69f0 <fwp_apply_borrowed_prefix>
    5b01:	49 ff c4             	inc    %r12
    5b04:	48 8b 0b             	mov    (%rbx),%rcx
    5b07:	48 89 ca             	mov    %rcx,%rdx
    5b0a:	4c 21 ea             	and    %r13,%rdx
    5b0d:	49 39 d4             	cmp    %rdx,%r12
    5b10:	73 16                	jae    5b28 <e1+0x1e8>
    5b12:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
    5b19:	00 
    5b1a:	48 89 e8             	mov    %rbp,%rax
    5b1d:	48 85 c9             	test   %rcx,%rcx
    5b20:	79 be                	jns    5ae0 <e1+0x1a0>
    5b22:	48 8b 43 10          	mov    0x10(%rbx),%rax
    5b26:	eb b8                	jmp    5ae0 <e1+0x1a0>
    5b28:	41 89 c6             	mov    %eax,%r14d
    5b2b:	48 89 e2             	mov    %rsp,%rdx
    5b2e:	eb 03                	jmp    5b33 <e1+0x1f3>
    5b30:	45 31 f6             	xor    %r14d,%r14d
    5b33:	48 8d 05 6e 51 01 00 	lea    0x1516e(%rip),%rax        # 1aca8 <fc13>
    5b3a:	48 39 15 07 52 01 00 	cmp    %rdx,0x15207(%rip)        # 1ad48 <fwp_cleanups>
    5b41:	75 37                	jne    5b7a <e1+0x23a>
    5b43:	48 8b 04 24          	mov    (%rsp),%rax
    5b47:	48 89 05 fa 51 01 00 	mov    %rax,0x151fa(%rip)        # 1ad48 <fwp_cleanups>
    5b4e:	48 8d 05 53 51 01 00 	lea    0x15153(%rip),%rax        # 1aca8 <fc13>
    5b55:	48 89 df             	mov    %rbx,%rdi
    5b58:	e8 23 0b 00 00       	call   6680 <fwp_drop1>
    5b5d:	4c 89 f7             	mov    %r14,%rdi
    5b60:	e8 fb 07 00 00       	call   6360 <fwp_rc_share>
    5b65:	4c 89 f0             	mov    %r14,%rax
    5b68:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    5b6f:	5b                   	pop    %rbx
    5b70:	41 5c                	pop    %r12
    5b72:	41 5d                	pop    %r13
    5b74:	41 5e                	pop    %r14
    5b76:	41 5f                	pop    %r15
    5b78:	5d                   	pop    %rbp
    5b79:	c3                   	ret
    5b7a:	e8 f1 d4 ff ff       	call   3070 <abort@plt>
    5b7f:	90                   	nop

0000000000005b80 <e2>:
    5b80:	41 57                	push   %r15
    5b82:	41 56                	push   %r14
    5b84:	53                   	push   %rbx
    5b85:	48 83 ec 60          	sub    $0x60,%rsp
    5b89:	48 89 fb             	mov    %rdi,%rbx
    5b8c:	48 8b 3f             	mov    (%rdi),%rdi
    5b8f:	e8 cc 07 00 00       	call   6360 <fwp_rc_share>
    5b94:	48 8b 1b             	mov    (%rbx),%rbx
    5b97:	0f 10 05 c2 e5 00 00 	movups 0xe5c2(%rip),%xmm0        # 14160 <_IO_stdin_used+0x160>
    5b9e:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    5ba3:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
    5ba8:	48 ff 05 91 51 01 00 	incq   0x15191(%rip)        # 1ad40 <measured_scopes>
    5baf:	48 8b 05 92 51 01 00 	mov    0x15192(%rip),%rax        # 1ad48 <fwp_cleanups>
    5bb6:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    5bbb:	48 8d 05 1e 4d 00 00 	lea    0x4d1e(%rip),%rax        # a8e0 <fwp_owner_release6>
    5bc2:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    5bc7:	48 8d 44 24 10       	lea    0x10(%rsp),%rax
    5bcc:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    5bd1:	4c 8d 7c 24 18       	lea    0x18(%rsp),%r15
    5bd6:	4c 89 3d 6b 51 01 00 	mov    %r15,0x1516b(%rip)        # 1ad48 <fwp_cleanups>
    5bdd:	48 8d 0d 7c 2f 01 00 	lea    0x12f7c(%rip),%rcx        # 18b60 <d0>
    5be4:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    5be9:	48 89 de             	mov    %rbx,%rsi
    5bec:	48 89 ca             	mov    %rcx,%rdx
    5bef:	e8 8c 0b 00 00       	call   6780 <fwp_p_array_map_typed>
    5bf4:	4c 39 3d 4d 51 01 00 	cmp    %r15,0x1514d(%rip)        # 1ad48 <fwp_cleanups>
    5bfb:	0f 85 87 00 00 00    	jne    5c88 <e2+0x108>
    5c01:	49 89 c6             	mov    %rax,%r14
    5c04:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    5c09:	48 89 05 38 51 01 00 	mov    %rax,0x15138(%rip)        # 1ad48 <fwp_cleanups>
    5c10:	48 8d 44 24 30       	lea    0x30(%rsp),%rax
    5c15:	48 89 df             	mov    %rbx,%rdi
    5c18:	e8 d3 4c 00 00       	call   a8f0 <fwp_drop2>
    5c1d:	4c 89 74 24 08       	mov    %r14,0x8(%rsp)
    5c22:	48 ff 05 17 51 01 00 	incq   0x15117(%rip)        # 1ad40 <measured_scopes>
    5c29:	48 8b 05 18 51 01 00 	mov    0x15118(%rip),%rax        # 1ad48 <fwp_cleanups>
    5c30:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
    5c35:	48 8d 0d 94 4d 00 00 	lea    0x4d94(%rip),%rcx        # a9d0 <fwp_owner_release7>
    5c3c:	48 89 4c 24 50       	mov    %rcx,0x50(%rsp)
    5c41:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    5c46:	48 89 4c 24 58       	mov    %rcx,0x58(%rsp)
    5c4b:	48 8d 4c 24 48       	lea    0x48(%rsp),%rcx
    5c50:	48 89 0d f1 50 01 00 	mov    %rcx,0x150f1(%rip)        # 1ad48 <fwp_cleanups>
    5c57:	48 bb ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rbx
    5c5e:	ff ff 7f 
    5c61:	49 23 1e             	and    (%r14),%rbx
    5c64:	48 89 05 dd 50 01 00 	mov    %rax,0x150dd(%rip)        # 1ad48 <fwp_cleanups>
    5c6b:	4c 89 f7             	mov    %r14,%rdi
    5c6e:	e8 7d 4c 00 00       	call   a8f0 <fwp_drop2>
    5c73:	48 89 df             	mov    %rbx,%rdi
    5c76:	e8 e5 06 00 00       	call   6360 <fwp_rc_share>
    5c7b:	48 89 d8             	mov    %rbx,%rax
    5c7e:	48 83 c4 60          	add    $0x60,%rsp
    5c82:	5b                   	pop    %rbx
    5c83:	41 5e                	pop    %r14
    5c85:	41 5f                	pop    %r15
    5c87:	c3                   	ret
    5c88:	e8 e3 d3 ff ff       	call   3070 <abort@plt>
    5c8d:	0f 1f 00             	nopl   (%rax)

0000000000005c90 <e3>:
    5c90:	55                   	push   %rbp
    5c91:	41 57                	push   %r15
    5c93:	41 56                	push   %r14
    5c95:	41 55                	push   %r13
    5c97:	41 54                	push   %r12
    5c99:	53                   	push   %rbx
    5c9a:	48 83 ec 68          	sub    $0x68,%rsp
    5c9e:	48 89 fb             	mov    %rdi,%rbx
    5ca1:	48 8b 3f             	mov    (%rdi),%rdi
    5ca4:	e8 b7 06 00 00       	call   6360 <fwp_rc_share>
    5ca9:	4c 8b 33             	mov    (%rbx),%r14
    5cac:	0f 10 05 ad e4 00 00 	movups 0xe4ad(%rip),%xmm0        # 14160 <_IO_stdin_used+0x160>
    5cb3:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    5cb8:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    5cbd:	48 ff 05 7c 50 01 00 	incq   0x1507c(%rip)        # 1ad40 <measured_scopes>
    5cc4:	48 8b 05 7d 50 01 00 	mov    0x1507d(%rip),%rax        # 1ad48 <fwp_cleanups>
    5ccb:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    5cd0:	48 8d 05 09 4d 00 00 	lea    0x4d09(%rip),%rax        # a9e0 <fwp_owner_release8>
    5cd7:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    5cdc:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    5ce1:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    5ce6:	4c 8d 7c 24 28       	lea    0x28(%rsp),%r15
    5ceb:	4c 89 3d 56 50 01 00 	mov    %r15,0x15056(%rip)        # 1ad48 <fwp_cleanups>
    5cf2:	48 8d 0d 67 2e 01 00 	lea    0x12e67(%rip),%rcx        # 18b60 <d0>
    5cf9:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
    5cfe:	4c 89 f6             	mov    %r14,%rsi
    5d01:	48 89 ca             	mov    %rcx,%rdx
    5d04:	e8 77 0a 00 00       	call   6780 <fwp_p_array_map_typed>
    5d09:	4c 39 3d 38 50 01 00 	cmp    %r15,0x15038(%rip)        # 1ad48 <fwp_cleanups>
    5d10:	0f 85 1d 01 00 00    	jne    5e33 <e3+0x1a3>
    5d16:	48 89 c3             	mov    %rax,%rbx
    5d19:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    5d1e:	48 89 05 23 50 01 00 	mov    %rax,0x15023(%rip)        # 1ad48 <fwp_cleanups>
    5d25:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
    5d2a:	4c 89 f7             	mov    %r14,%rdi
    5d2d:	e8 be 4b 00 00       	call   a8f0 <fwp_drop2>
    5d32:	48 ff 05 07 50 01 00 	incq   0x15007(%rip)        # 1ad40 <measured_scopes>
    5d39:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    5d3e:	48 8b 05 03 50 01 00 	mov    0x15003(%rip),%rax        # 1ad48 <fwp_cleanups>
    5d45:	48 89 04 24          	mov    %rax,(%rsp)
    5d49:	48 8d 05 a0 4c 00 00 	lea    0x4ca0(%rip),%rax        # a9f0 <fwp_owner_release9>
    5d50:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    5d55:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
    5d5a:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    5d5f:	48 89 e2             	mov    %rsp,%rdx
    5d62:	48 89 15 df 4f 01 00 	mov    %rdx,0x14fdf(%rip)        # 1ad48 <fwp_cleanups>
    5d69:	48 8b 0b             	mov    (%rbx),%rcx
    5d6c:	48 8d 04 4d 00 00 00 	lea    0x0(,%rcx,2),%rax
    5d73:	00 
    5d74:	48 85 c0             	test   %rax,%rax
    5d77:	74 73                	je     5dec <e3+0x15c>
    5d79:	49 bd ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r13
    5d80:	ff ff 7f 
    5d83:	48 89 dd             	mov    %rbx,%rbp
    5d86:	48 83 c5 08          	add    $0x8,%rbp
    5d8a:	45 31 e4             	xor    %r12d,%r12d
    5d8d:	4c 8d 35 24 4f 01 00 	lea    0x14f24(%rip),%r14        # 1acb8 <fc5>
    5d94:	4c 8d 7c 24 50       	lea    0x50(%rsp),%r15
    5d99:	31 c0                	xor    %eax,%eax
    5d9b:	eb 33                	jmp    5dd0 <e3+0x140>
    5d9d:	0f 1f 00             	nopl   (%rax)
    5da0:	4a 0f be 04 20       	movsbq (%rax,%r12,1),%rax
    5da5:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
    5daa:	4c 89 f7             	mov    %r14,%rdi
    5dad:	be 02 00 00 00       	mov    $0x2,%esi
    5db2:	4c 89 fa             	mov    %r15,%rdx
    5db5:	b9 01 00 00 00       	mov    $0x1,%ecx
    5dba:	e8 31 0c 00 00       	call   69f0 <fwp_apply_borrowed_prefix>
    5dbf:	49 ff c4             	inc    %r12
    5dc2:	48 8b 0b             	mov    (%rbx),%rcx
    5dc5:	48 89 ca             	mov    %rcx,%rdx
    5dc8:	4c 21 ea             	and    %r13,%rdx
    5dcb:	49 39 d4             	cmp    %rdx,%r12
    5dce:	73 13                	jae    5de3 <e3+0x153>
    5dd0:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    5dd5:	48 89 e8             	mov    %rbp,%rax
    5dd8:	48 85 c9             	test   %rcx,%rcx
    5ddb:	79 c3                	jns    5da0 <e3+0x110>
    5ddd:	48 8b 43 10          	mov    0x10(%rbx),%rax
    5de1:	eb bd                	jmp    5da0 <e3+0x110>
    5de3:	4c 0f be f0          	movsbq %al,%r14
    5de7:	48 89 e2             	mov    %rsp,%rdx
    5dea:	eb 03                	jmp    5def <e3+0x15f>
    5dec:	45 31 f6             	xor    %r14d,%r14d
    5def:	48 8d 05 c2 4e 01 00 	lea    0x14ec2(%rip),%rax        # 1acb8 <fc5>
    5df6:	48 39 15 4b 4f 01 00 	cmp    %rdx,0x14f4b(%rip)        # 1ad48 <fwp_cleanups>
    5dfd:	75 34                	jne    5e33 <e3+0x1a3>
    5dff:	48 8b 04 24          	mov    (%rsp),%rax
    5e03:	48 89 05 3e 4f 01 00 	mov    %rax,0x14f3e(%rip)        # 1ad48 <fwp_cleanups>
    5e0a:	48 8d 05 a7 4e 01 00 	lea    0x14ea7(%rip),%rax        # 1acb8 <fc5>
    5e11:	48 89 df             	mov    %rbx,%rdi
    5e14:	e8 d7 4a 00 00       	call   a8f0 <fwp_drop2>
    5e19:	4c 89 f7             	mov    %r14,%rdi
    5e1c:	e8 3f 05 00 00       	call   6360 <fwp_rc_share>
    5e21:	4c 89 f0             	mov    %r14,%rax
    5e24:	48 83 c4 68          	add    $0x68,%rsp
    5e28:	5b                   	pop    %rbx
    5e29:	41 5c                	pop    %r12
    5e2b:	41 5d                	pop    %r13
    5e2d:	41 5e                	pop    %r14
    5e2f:	41 5f                	pop    %r15
    5e31:	5d                   	pop    %rbp
    5e32:	c3                   	ret
    5e33:	e8 38 d2 ff ff       	call   3070 <abort@plt>
    5e38:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    5e3f:	00 

0000000000005e40 <e4>:
    5e40:	53                   	push   %rbx
    5e41:	48 89 fb             	mov    %rdi,%rbx
    5e44:	48 8b 3f             	mov    (%rdi),%rdi
    5e47:	e8 14 05 00 00       	call   6360 <fwp_rc_share>
    5e4c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    5e50:	e8 0b 05 00 00       	call   6360 <fwp_rc_share>
    5e55:	48 8b 3b             	mov    (%rbx),%rdi
    5e58:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    5e5c:	48 8d 0d fd 2c 01 00 	lea    0x12cfd(%rip),%rcx        # 18b60 <d0>
    5e63:	48 89 ca             	mov    %rcx,%rdx
    5e66:	e8 15 09 00 00       	call   6780 <fwp_p_array_map_typed>
    5e6b:	48 89 c3             	mov    %rax,%rbx
    5e6e:	48 89 c7             	mov    %rax,%rdi
    5e71:	e8 ea 04 00 00       	call   6360 <fwp_rc_share>
    5e76:	48 89 d8             	mov    %rbx,%rax
    5e79:	5b                   	pop    %rbx
    5e7a:	c3                   	ret
    5e7b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000005e80 <e5>:
    5e80:	53                   	push   %rbx
    5e81:	48 83 ec 60          	sub    $0x60,%rsp
    5e85:	48 0f be 07          	movsbq (%rdi),%rax
    5e89:	48 0f be 5f 08       	movsbq 0x8(%rdi),%rbx
    5e8e:	48 01 c3             	add    %rax,%rbx
    5e91:	48 0f be c3          	movsbq %bl,%rax
    5e95:	48 39 d8             	cmp    %rbx,%rax
    5e98:	75 11                	jne    5eab <e5+0x2b>
    5e9a:	48 89 df             	mov    %rbx,%rdi
    5e9d:	e8 be 04 00 00       	call   6360 <fwp_rc_share>
    5ea2:	48 89 d8             	mov    %rbx,%rax
    5ea5:	48 83 c4 60          	add    $0x60,%rsp
    5ea9:	5b                   	pop    %rbx
    5eaa:	c3                   	ret
    5eab:	48 8d 15 66 ed 00 00 	lea    0xed66(%rip),%rdx        # 14c18 <exec_in_fp0+0x408>
    5eb2:	48 8d 0d 5c ed 00 00 	lea    0xed5c(%rip),%rcx        # 14c15 <exec_in_fp0+0x405>
    5eb9:	48 89 e3             	mov    %rsp,%rbx
    5ebc:	be 60 00 00 00       	mov    $0x60,%esi
    5ec1:	48 89 df             	mov    %rbx,%rdi
    5ec4:	31 c0                	xor    %eax,%eax
    5ec6:	e8 05 d3 ff ff       	call   31d0 <snprintf@plt>
    5ecb:	e8 70 07 00 00       	call   6640 <fwp_flush>
    5ed0:	48 8b 05 01 31 01 00 	mov    0x13101(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    5ed7:	48 8b 38             	mov    (%rax),%rdi
    5eda:	48 8d 35 6d eb 00 00 	lea    0xeb6d(%rip),%rsi        # 14a4e <exec_in_fp0+0x23e>
    5ee1:	48 89 da             	mov    %rbx,%rdx
    5ee4:	31 c0                	xor    %eax,%eax
    5ee6:	e8 05 d4 ff ff       	call   32f0 <fprintf@plt>
    5eeb:	bf 65 00 00 00       	mov    $0x65,%edi
    5ef0:	e8 6b d5 ff ff       	call   3460 <exit@plt>
    5ef5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    5efc:	00 00 00 00 

0000000000005f00 <e6>:
    5f00:	55                   	push   %rbp
    5f01:	41 57                	push   %r15
    5f03:	41 56                	push   %r14
    5f05:	41 55                	push   %r13
    5f07:	41 54                	push   %r12
    5f09:	53                   	push   %rbx
    5f0a:	48 83 ec 18          	sub    $0x18,%rsp
    5f0e:	49 89 fe             	mov    %rdi,%r14
    5f11:	48 8b 3f             	mov    (%rdi),%rdi
    5f14:	e8 47 04 00 00       	call   6360 <fwp_rc_share>
    5f19:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    5f1d:	e8 3e 04 00 00       	call   6360 <fwp_rc_share>
    5f22:	49 8b 1e             	mov    (%r14),%rbx
    5f25:	49 8b 46 08          	mov    0x8(%r14),%rax
    5f29:	4d 8b 7e 10          	mov    0x10(%r14),%r15
    5f2d:	49 8b 0f             	mov    (%r15),%rcx
    5f30:	48 8d 14 4d 00 00 00 	lea    0x0(,%rcx,2),%rdx
    5f37:	00 
    5f38:	48 85 d2             	test   %rdx,%rdx
    5f3b:	74 65                	je     5fa2 <e6+0xa2>
    5f3d:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
    5f44:	ff ff 7f 
    5f47:	4d 8d 6f 08          	lea    0x8(%r15),%r13
    5f4b:	31 ed                	xor    %ebp,%ebp
    5f4d:	49 89 e6             	mov    %rsp,%r14
    5f50:	eb 3e                	jmp    5f90 <e6+0x90>
    5f52:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5f59:	1f 84 00 00 00 00 00 
    5f60:	48 0f be 04 28       	movsbq (%rax,%rbp,1),%rax
    5f65:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    5f6a:	48 89 df             	mov    %rbx,%rdi
    5f6d:	be 02 00 00 00       	mov    $0x2,%esi
    5f72:	4c 89 f2             	mov    %r14,%rdx
    5f75:	b9 01 00 00 00       	mov    $0x1,%ecx
    5f7a:	e8 71 0a 00 00       	call   69f0 <fwp_apply_borrowed_prefix>
    5f7f:	48 ff c5             	inc    %rbp
    5f82:	49 8b 0f             	mov    (%r15),%rcx
    5f85:	48 89 ca             	mov    %rcx,%rdx
    5f88:	4c 21 e2             	and    %r12,%rdx
    5f8b:	48 39 d5             	cmp    %rdx,%rbp
    5f8e:	73 12                	jae    5fa2 <e6+0xa2>
    5f90:	48 89 04 24          	mov    %rax,(%rsp)
    5f94:	4c 89 e8             	mov    %r13,%rax
    5f97:	48 85 c9             	test   %rcx,%rcx
    5f9a:	79 c4                	jns    5f60 <e6+0x60>
    5f9c:	49 8b 47 10          	mov    0x10(%r15),%rax
    5fa0:	eb be                	jmp    5f60 <e6+0x60>
    5fa2:	48 89 c7             	mov    %rax,%rdi
    5fa5:	48 89 c3             	mov    %rax,%rbx
    5fa8:	e8 b3 03 00 00       	call   6360 <fwp_rc_share>
    5fad:	48 89 d8             	mov    %rbx,%rax
    5fb0:	48 83 c4 18          	add    $0x18,%rsp
    5fb4:	5b                   	pop    %rbx
    5fb5:	41 5c                	pop    %r12
    5fb7:	41 5d                	pop    %r13
    5fb9:	41 5e                	pop    %r14
    5fbb:	41 5f                	pop    %r15
    5fbd:	5d                   	pop    %rbp
    5fbe:	c3                   	ret
    5fbf:	90                   	nop

0000000000005fc0 <e8>:
    5fc0:	53                   	push   %rbx
    5fc1:	48 83 ec 60          	sub    $0x60,%rsp
    5fc5:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    5fc9:	48 03 1f             	add    (%rdi),%rbx
    5fcc:	48 0f be c3          	movsbq %bl,%rax
    5fd0:	48 39 d8             	cmp    %rbx,%rax
    5fd3:	75 11                	jne    5fe6 <e8+0x26>
    5fd5:	48 89 df             	mov    %rbx,%rdi
    5fd8:	e8 83 03 00 00       	call   6360 <fwp_rc_share>
    5fdd:	48 89 d8             	mov    %rbx,%rax
    5fe0:	48 83 c4 60          	add    $0x60,%rsp
    5fe4:	5b                   	pop    %rbx
    5fe5:	c3                   	ret
    5fe6:	48 8d 15 2b ec 00 00 	lea    0xec2b(%rip),%rdx        # 14c18 <exec_in_fp0+0x408>
    5fed:	48 8d 0d 21 ec 00 00 	lea    0xec21(%rip),%rcx        # 14c15 <exec_in_fp0+0x405>
    5ff4:	48 89 e3             	mov    %rsp,%rbx
    5ff7:	be 60 00 00 00       	mov    $0x60,%esi
    5ffc:	48 89 df             	mov    %rbx,%rdi
    5fff:	31 c0                	xor    %eax,%eax
    6001:	e8 ca d1 ff ff       	call   31d0 <snprintf@plt>
    6006:	e8 35 06 00 00       	call   6640 <fwp_flush>
    600b:	48 8b 05 c6 2f 01 00 	mov    0x12fc6(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    6012:	48 8b 38             	mov    (%rax),%rdi
    6015:	48 8d 35 32 ea 00 00 	lea    0xea32(%rip),%rsi        # 14a4e <exec_in_fp0+0x23e>
    601c:	48 89 da             	mov    %rbx,%rdx
    601f:	31 c0                	xor    %eax,%eax
    6021:	e8 ca d2 ff ff       	call   32f0 <fprintf@plt>
    6026:	bf 65 00 00 00       	mov    $0x65,%edi
    602b:	e8 30 d4 ff ff       	call   3460 <exit@plt>

0000000000006030 <e9>:
    6030:	53                   	push   %rbx
    6031:	48 89 fb             	mov    %rdi,%rbx
    6034:	48 8b 3f             	mov    (%rdi),%rdi
    6037:	e8 24 03 00 00       	call   6360 <fwp_rc_share>
    603c:	48 8b 03             	mov    (%rbx),%rax
    603f:	48 bb ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rbx
    6046:	ff ff 7f 
    6049:	48 23 18             	and    (%rax),%rbx
    604c:	48 89 df             	mov    %rbx,%rdi
    604f:	e8 0c 03 00 00       	call   6360 <fwp_rc_share>
    6054:	48 89 d8             	mov    %rbx,%rax
    6057:	5b                   	pop    %rbx
    6058:	c3                   	ret
    6059:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000006060 <e11>:
    6060:	53                   	push   %rbx
    6061:	48 89 fb             	mov    %rdi,%rbx
    6064:	48 8b 3f             	mov    (%rdi),%rdi
    6067:	e8 f4 02 00 00       	call   6360 <fwp_rc_share>
    606c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    6070:	e8 eb 02 00 00       	call   6360 <fwp_rc_share>
    6075:	48 8b 3b             	mov    (%rbx),%rdi
    6078:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    607c:	48 8d 0d 7d 2a 01 00 	lea    0x12a7d(%rip),%rcx        # 18b00 <d1>
    6083:	48 89 ca             	mov    %rcx,%rdx
    6086:	e8 f5 06 00 00       	call   6780 <fwp_p_array_map_typed>
    608b:	48 89 c3             	mov    %rax,%rbx
    608e:	48 89 c7             	mov    %rax,%rdi
    6091:	e8 ca 02 00 00       	call   6360 <fwp_rc_share>
    6096:	48 89 d8             	mov    %rbx,%rax
    6099:	5b                   	pop    %rbx
    609a:	c3                   	ret
    609b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000060a0 <e12>:
    60a0:	53                   	push   %rbx
    60a1:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    60a5:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    60aa:	0f 59 c8             	mulps  %xmm0,%xmm1
    60ad:	66 0f 7e cb          	movd   %xmm1,%ebx
    60b1:	48 89 df             	mov    %rbx,%rdi
    60b4:	e8 a7 02 00 00       	call   6360 <fwp_rc_share>
    60b9:	48 89 d8             	mov    %rbx,%rax
    60bc:	5b                   	pop    %rbx
    60bd:	c3                   	ret
    60be:	66 90                	xchg   %ax,%ax

00000000000060c0 <e13>:
    60c0:	53                   	push   %rbx
    60c1:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    60c5:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    60ca:	0f 58 c8             	addps  %xmm0,%xmm1
    60cd:	66 0f 7e cb          	movd   %xmm1,%ebx
    60d1:	48 89 df             	mov    %rbx,%rdi
    60d4:	e8 87 02 00 00       	call   6360 <fwp_rc_share>
    60d9:	48 89 d8             	mov    %rbx,%rax
    60dc:	5b                   	pop    %rbx
    60dd:	c3                   	ret
    60de:	66 90                	xchg   %ax,%ax

00000000000060e0 <e15>:
    60e0:	55                   	push   %rbp
    60e1:	41 57                	push   %r15
    60e3:	41 56                	push   %r14
    60e5:	41 55                	push   %r13
    60e7:	41 54                	push   %r12
    60e9:	53                   	push   %rbx
    60ea:	48 83 ec 18          	sub    $0x18,%rsp
    60ee:	49 89 fe             	mov    %rdi,%r14
    60f1:	48 8b 3f             	mov    (%rdi),%rdi
    60f4:	e8 67 02 00 00       	call   6360 <fwp_rc_share>
    60f9:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    60fd:	e8 5e 02 00 00       	call   6360 <fwp_rc_share>
    6102:	49 8b 1e             	mov    (%r14),%rbx
    6105:	49 8b 46 08          	mov    0x8(%r14),%rax
    6109:	4d 8b 7e 10          	mov    0x10(%r14),%r15
    610d:	49 8b 0f             	mov    (%r15),%rcx
    6110:	48 8d 14 4d 00 00 00 	lea    0x0(,%rcx,2),%rdx
    6117:	00 
    6118:	48 85 d2             	test   %rdx,%rdx
    611b:	74 63                	je     6180 <e15+0xa0>
    611d:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
    6124:	ff ff 7f 
    6127:	4d 8d 6f 08          	lea    0x8(%r15),%r13
    612b:	31 ed                	xor    %ebp,%ebp
    612d:	49 89 e6             	mov    %rsp,%r14
    6130:	eb 3c                	jmp    616e <e15+0x8e>
    6132:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6139:	1f 84 00 00 00 00 00 
    6140:	8b 04 a8             	mov    (%rax,%rbp,4),%eax
    6143:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    6148:	48 89 df             	mov    %rbx,%rdi
    614b:	be 02 00 00 00       	mov    $0x2,%esi
    6150:	4c 89 f2             	mov    %r14,%rdx
    6153:	b9 01 00 00 00       	mov    $0x1,%ecx
    6158:	e8 93 08 00 00       	call   69f0 <fwp_apply_borrowed_prefix>
    615d:	48 ff c5             	inc    %rbp
    6160:	49 8b 0f             	mov    (%r15),%rcx
    6163:	48 89 ca             	mov    %rcx,%rdx
    6166:	4c 21 e2             	and    %r12,%rdx
    6169:	48 39 d5             	cmp    %rdx,%rbp
    616c:	73 12                	jae    6180 <e15+0xa0>
    616e:	48 89 04 24          	mov    %rax,(%rsp)
    6172:	4c 89 e8             	mov    %r13,%rax
    6175:	48 85 c9             	test   %rcx,%rcx
    6178:	79 c6                	jns    6140 <e15+0x60>
    617a:	49 8b 47 10          	mov    0x10(%r15),%rax
    617e:	eb c0                	jmp    6140 <e15+0x60>
    6180:	48 89 c7             	mov    %rax,%rdi
    6183:	48 89 c3             	mov    %rax,%rbx
    6186:	e8 d5 01 00 00       	call   6360 <fwp_rc_share>
    618b:	48 89 d8             	mov    %rbx,%rax
    618e:	48 83 c4 18          	add    $0x18,%rsp
    6192:	5b                   	pop    %rbx
    6193:	41 5c                	pop    %r12
    6195:	41 5d                	pop    %r13
    6197:	41 5e                	pop    %r14
    6199:	41 5f                	pop    %r15
    619b:	5d                   	pop    %rbp
    619c:	c3                   	ret
    619d:	0f 1f 00             	nopl   (%rax)

00000000000061a0 <e17>:
    61a0:	53                   	push   %rbx
    61a1:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    61a5:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    61aa:	0f 58 c8             	addps  %xmm0,%xmm1
    61ad:	66 0f 7e cb          	movd   %xmm1,%ebx
    61b1:	48 89 df             	mov    %rbx,%rdi
    61b4:	e8 a7 01 00 00       	call   6360 <fwp_rc_share>
    61b9:	48 89 d8             	mov    %rbx,%rax
    61bc:	5b                   	pop    %rbx
    61bd:	c3                   	ret
    61be:	66 90                	xchg   %ax,%ax

00000000000061c0 <e18>:
    61c0:	53                   	push   %rbx
    61c1:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    61c5:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    61ca:	0f 59 c8             	mulps  %xmm0,%xmm1
    61cd:	66 0f 7e cb          	movd   %xmm1,%ebx
    61d1:	48 89 df             	mov    %rbx,%rdi
    61d4:	e8 87 01 00 00       	call   6360 <fwp_rc_share>
    61d9:	48 89 d8             	mov    %rbx,%rax
    61dc:	5b                   	pop    %rbx
    61dd:	c3                   	ret
    61de:	66 90                	xchg   %ax,%ax

00000000000061e0 <e19>:
    61e0:	53                   	push   %rbx
    61e1:	48 89 fb             	mov    %rdi,%rbx
    61e4:	48 8b 3f             	mov    (%rdi),%rdi
    61e7:	e8 74 01 00 00       	call   6360 <fwp_rc_share>
    61ec:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    61f0:	e8 6b 01 00 00       	call   6360 <fwp_rc_share>
    61f5:	48 8b 3b             	mov    (%rbx),%rdi
    61f8:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    61fc:	48 8d 0d bd 29 01 00 	lea    0x129bd(%rip),%rcx        # 18bc0 <d2>
    6203:	48 89 ca             	mov    %rcx,%rdx
    6206:	e8 75 05 00 00       	call   6780 <fwp_p_array_map_typed>
    620b:	48 89 c3             	mov    %rax,%rbx
    620e:	48 89 c7             	mov    %rax,%rdi
    6211:	e8 4a 01 00 00       	call   6360 <fwp_rc_share>
    6216:	48 89 d8             	mov    %rbx,%rax
    6219:	5b                   	pop    %rbx
    621a:	c3                   	ret
    621b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006220 <e20>:
    6220:	53                   	push   %rbx
    6221:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    6225:	f2 0f 59 47 08       	mulsd  0x8(%rdi),%xmm0
    622a:	66 48 0f 7e c3       	movq   %xmm0,%rbx
    622f:	48 89 df             	mov    %rbx,%rdi
    6232:	e8 29 01 00 00       	call   6360 <fwp_rc_share>
    6237:	48 89 d8             	mov    %rbx,%rax
    623a:	5b                   	pop    %rbx
    623b:	c3                   	ret
    623c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000006240 <e21>:
    6240:	53                   	push   %rbx
    6241:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    6245:	f2 0f 58 47 08       	addsd  0x8(%rdi),%xmm0
    624a:	66 48 0f 7e c3       	movq   %xmm0,%rbx
    624f:	48 89 df             	mov    %rbx,%rdi
    6252:	e8 09 01 00 00       	call   6360 <fwp_rc_share>
    6257:	48 89 d8             	mov    %rbx,%rax
    625a:	5b                   	pop    %rbx
    625b:	c3                   	ret
    625c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000006260 <e23>:
    6260:	55                   	push   %rbp
    6261:	41 57                	push   %r15
    6263:	41 56                	push   %r14
    6265:	41 55                	push   %r13
    6267:	41 54                	push   %r12
    6269:	53                   	push   %rbx
    626a:	48 83 ec 18          	sub    $0x18,%rsp
    626e:	49 89 fe             	mov    %rdi,%r14
    6271:	48 8b 3f             	mov    (%rdi),%rdi
    6274:	e8 e7 00 00 00       	call   6360 <fwp_rc_share>
    6279:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    627d:	e8 de 00 00 00       	call   6360 <fwp_rc_share>
    6282:	49 8b 1e             	mov    (%r14),%rbx
    6285:	49 8b 46 08          	mov    0x8(%r14),%rax
    6289:	4d 8b 7e 10          	mov    0x10(%r14),%r15
    628d:	49 8b 0f             	mov    (%r15),%rcx
    6290:	48 8d 14 4d 00 00 00 	lea    0x0(,%rcx,2),%rdx
    6297:	00 
    6298:	48 85 d2             	test   %rdx,%rdx
    629b:	74 64                	je     6301 <e23+0xa1>
    629d:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
    62a4:	ff ff 7f 
    62a7:	4d 8d 6f 08          	lea    0x8(%r15),%r13
    62ab:	31 ed                	xor    %ebp,%ebp
    62ad:	49 89 e6             	mov    %rsp,%r14
    62b0:	eb 3d                	jmp    62ef <e23+0x8f>
    62b2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    62b9:	1f 84 00 00 00 00 00 
    62c0:	48 8b 04 e8          	mov    (%rax,%rbp,8),%rax
    62c4:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    62c9:	48 89 df             	mov    %rbx,%rdi
    62cc:	be 02 00 00 00       	mov    $0x2,%esi
    62d1:	4c 89 f2             	mov    %r14,%rdx
    62d4:	b9 01 00 00 00       	mov    $0x1,%ecx
    62d9:	e8 12 07 00 00       	call   69f0 <fwp_apply_borrowed_prefix>
    62de:	48 ff c5             	inc    %rbp
    62e1:	49 8b 0f             	mov    (%r15),%rcx
    62e4:	48 89 ca             	mov    %rcx,%rdx
    62e7:	4c 21 e2             	and    %r12,%rdx
    62ea:	48 39 d5             	cmp    %rdx,%rbp
    62ed:	73 12                	jae    6301 <e23+0xa1>
    62ef:	48 89 04 24          	mov    %rax,(%rsp)
    62f3:	4c 89 e8             	mov    %r13,%rax
    62f6:	48 85 c9             	test   %rcx,%rcx
    62f9:	79 c5                	jns    62c0 <e23+0x60>
    62fb:	49 8b 47 10          	mov    0x10(%r15),%rax
    62ff:	eb bf                	jmp    62c0 <e23+0x60>
    6301:	48 89 c7             	mov    %rax,%rdi
    6304:	48 89 c3             	mov    %rax,%rbx
    6307:	e8 54 00 00 00       	call   6360 <fwp_rc_share>
    630c:	48 89 d8             	mov    %rbx,%rax
    630f:	48 83 c4 18          	add    $0x18,%rsp
    6313:	5b                   	pop    %rbx
    6314:	41 5c                	pop    %r12
    6316:	41 5d                	pop    %r13
    6318:	41 5e                	pop    %r14
    631a:	41 5f                	pop    %r15
    631c:	5d                   	pop    %rbp
    631d:	c3                   	ret
    631e:	66 90                	xchg   %ax,%ax

0000000000006320 <e25>:
    6320:	53                   	push   %rbx
    6321:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    6325:	f2 0f 58 47 08       	addsd  0x8(%rdi),%xmm0
    632a:	66 48 0f 7e c3       	movq   %xmm0,%rbx
    632f:	48 89 df             	mov    %rbx,%rdi
    6332:	e8 29 00 00 00       	call   6360 <fwp_rc_share>
    6337:	48 89 d8             	mov    %rbx,%rax
    633a:	5b                   	pop    %rbx
    633b:	c3                   	ret
    633c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000006340 <e26>:
    6340:	53                   	push   %rbx
    6341:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    6345:	f2 0f 59 47 08       	mulsd  0x8(%rdi),%xmm0
    634a:	66 48 0f 7e c3       	movq   %xmm0,%rbx
    634f:	48 89 df             	mov    %rbx,%rdi
    6352:	e8 09 00 00 00       	call   6360 <fwp_rc_share>
    6357:	48 89 d8             	mov    %rbx,%rax
    635a:	5b                   	pop    %rbx
    635b:	c3                   	ret
    635c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000006360 <fwp_rc_share>:
    6360:	48 89 f8             	mov    %rdi,%rax
    6363:	48 2b 05 4e 3f 01 00 	sub    0x13f4e(%rip),%rax        # 1a2b8 <fwp_gc+0x1030>
    636a:	48 8b 0d 6f 3f 01 00 	mov    0x13f6f(%rip),%rcx        # 1a2e0 <fwp_gc+0x1058>
    6371:	48 c1 e1 10          	shl    $0x10,%rcx
    6375:	48 39 c8             	cmp    %rcx,%rax
    6378:	0f 83 f9 01 00 00    	jae    6577 <fwp_rc_share+0x217>
    637e:	41 57                	push   %r15
    6380:	41 56                	push   %r14
    6382:	41 55                	push   %r13
    6384:	41 54                	push   %r12
    6386:	53                   	push   %rbx
    6387:	48 81 ec 00 02 00 00 	sub    $0x200,%rsp
    638e:	48 8b 0d 6b 3f 01 00 	mov    0x13f6b(%rip),%rcx        # 1a300 <fwp_gc+0x1078>
    6395:	48 89 c2             	mov    %rax,%rdx
    6398:	48 c1 ea 10          	shr    $0x10,%rdx
    639c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    63a3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    63a7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    63ad:	75 13                	jne    63c2 <fwp_rc_share+0x62>
    63af:	40 80 fe 02          	cmp    $0x2,%sil
    63b3:	75 0d                	jne    63c2 <fwp_rc_share+0x62>
    63b5:	48 8d 1c 11          	lea    (%rcx,%rdx,1),%rbx
    63b9:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    63c0:	eb 25                	jmp    63e7 <fwp_rc_share+0x87>
    63c2:	40 80 fe 01          	cmp    $0x1,%sil
    63c6:	0f 85 9b 01 00 00    	jne    6567 <fwp_rc_share+0x207>
    63cc:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    63d0:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    63d4:	48 0f af c1          	imul   %rcx,%rax
    63d8:	48 c1 e8 20          	shr    $0x20,%rax
    63dc:	48 8d 1c 30          	lea    (%rax,%rsi,1),%rbx
    63e0:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    63e7:	0f b6 03             	movzbl (%rbx),%eax
    63ea:	84 c0                	test   %al,%al
    63ec:	0f 84 75 01 00 00    	je     6567 <fwp_rc_share+0x207>
    63f2:	3c ff                	cmp    $0xff,%al
    63f4:	0f 84 7e 01 00 00    	je     6578 <fwp_rc_share+0x218>
    63fa:	c6 03 00             	movb   $0x0,(%rbx)
    63fd:	48 89 3c 24          	mov    %rdi,(%rsp)
    6401:	41 be 01 00 00 00    	mov    $0x1,%r14d
    6407:	eb 10                	jmp    6419 <fwp_rc_share+0xb9>
    6409:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    6410:	4d 85 f6             	test   %r14,%r14
    6413:	0f 84 4e 01 00 00    	je     6567 <fwp_rc_share+0x207>
    6419:	4e 8b 7c f4 f8       	mov    -0x8(%rsp,%r14,8),%r15
    641e:	49 ff ce             	dec    %r14
    6421:	48 8b 05 90 3e 01 00 	mov    0x13e90(%rip),%rax        # 1a2b8 <fwp_gc+0x1030>
    6428:	4c 89 f9             	mov    %r15,%rcx
    642b:	48 29 c1             	sub    %rax,%rcx
    642e:	48 89 ce             	mov    %rcx,%rsi
    6431:	48 c1 ee 10          	shr    $0x10,%rsi
    6435:	48 8b 15 c4 3e 01 00 	mov    0x13ec4(%rip),%rdx        # 1a300 <fwp_gc+0x1078>
    643c:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    6443:	80 7c 32 01 01       	cmpb   $0x1,0x1(%rdx,%rsi,1)
    6448:	74 c6                	je     6410 <fwp_rc_share+0xb0>
    644a:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    644e:	40 80 ff 02          	cmp    $0x2,%dil
    6452:	75 0c                	jne    6460 <fwp_rc_share+0x100>
    6454:	4c 8b 64 32 18       	mov    0x18(%rdx,%rsi,1),%r12
    6459:	eb 32                	jmp    648d <fwp_rc_share+0x12d>
    645b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    6460:	44 8b 64 32 08       	mov    0x8(%rdx,%rsi,1),%r12d
    6465:	40 80 ff 01          	cmp    $0x1,%dil
    6469:	75 22                	jne    648d <fwp_rc_share+0x12d>
    646b:	41 0f b7 ff          	movzwl %r15w,%edi
    646f:	44 8b 7c 32 20       	mov    0x20(%rdx,%rsi,1),%r15d
    6474:	4c 0f af ff          	imul   %rdi,%r15
    6478:	49 c1 ef 20          	shr    $0x20,%r15
    647c:	48 81 e1 00 00 ff ff 	and    $0xffffffffffff0000,%rcx
    6483:	48 01 c8             	add    %rcx,%rax
    6486:	4d 0f af fc          	imul   %r12,%r15
    648a:	49 01 c7             	add    %rax,%r15
    648d:	49 83 fc 08          	cmp    $0x8,%r12
    6491:	0f 82 79 ff ff ff    	jb     6410 <fwp_rc_share+0xb0>
    6497:	49 c1 ec 03          	shr    $0x3,%r12
    649b:	45 31 ed             	xor    %r13d,%r13d
    649e:	eb 1c                	jmp    64bc <fwp_rc_share+0x15c>
    64a0:	e8 bb fe ff ff       	call   6360 <fwp_rc_share>
    64a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    64ac:	00 00 00 00 
    64b0:	49 ff c5             	inc    %r13
    64b3:	4d 39 ec             	cmp    %r13,%r12
    64b6:	0f 84 54 ff ff ff    	je     6410 <fwp_rc_share+0xb0>
    64bc:	4b 8b 3c ef          	mov    (%r15,%r13,8),%rdi
    64c0:	48 89 f8             	mov    %rdi,%rax
    64c3:	48 2b 05 ee 3d 01 00 	sub    0x13dee(%rip),%rax        # 1a2b8 <fwp_gc+0x1030>
    64ca:	48 8b 0d 0f 3e 01 00 	mov    0x13e0f(%rip),%rcx        # 1a2e0 <fwp_gc+0x1058>
    64d1:	48 c1 e1 10          	shl    $0x10,%rcx
    64d5:	48 39 c8             	cmp    %rcx,%rax
    64d8:	73 d6                	jae    64b0 <fwp_rc_share+0x150>
    64da:	48 8b 0d 1f 3e 01 00 	mov    0x13e1f(%rip),%rcx        # 1a300 <fwp_gc+0x1078>
    64e1:	48 89 c2             	mov    %rax,%rdx
    64e4:	48 c1 ea 10          	shr    $0x10,%rdx
    64e8:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    64ef:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    64f3:	48 25 ff ff 00 00    	and    $0xffff,%rax
    64f9:	75 15                	jne    6510 <fwp_rc_share+0x1b0>
    64fb:	40 80 fe 02          	cmp    $0x2,%sil
    64ff:	75 0f                	jne    6510 <fwp_rc_share+0x1b0>
    6501:	48 8d 1c 11          	lea    (%rcx,%rdx,1),%rbx
    6505:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    650c:	eb 23                	jmp    6531 <fwp_rc_share+0x1d1>
    650e:	66 90                	xchg   %ax,%ax
    6510:	40 80 fe 01          	cmp    $0x1,%sil
    6514:	75 9a                	jne    64b0 <fwp_rc_share+0x150>
    6516:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    651a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    651e:	48 0f af c1          	imul   %rcx,%rax
    6522:	48 c1 e8 20          	shr    $0x20,%rax
    6526:	48 8d 1c 30          	lea    (%rax,%rsi,1),%rbx
    652a:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    6531:	0f b6 03             	movzbl (%rbx),%eax
    6534:	84 c0                	test   %al,%al
    6536:	0f 84 74 ff ff ff    	je     64b0 <fwp_rc_share+0x150>
    653c:	49 83 fe 3f          	cmp    $0x3f,%r14
    6540:	0f 87 5a ff ff ff    	ja     64a0 <fwp_rc_share+0x140>
    6546:	3c ff                	cmp    $0xff,%al
    6548:	74 13                	je     655d <fwp_rc_share+0x1fd>
    654a:	c6 03 00             	movb   $0x0,(%rbx)
    654d:	4b 8b 04 ef          	mov    (%r15,%r13,8),%rax
    6551:	4a 89 04 f4          	mov    %rax,(%rsp,%r14,8)
    6555:	49 ff c6             	inc    %r14
    6558:	e9 53 ff ff ff       	jmp    64b0 <fwp_rc_share+0x150>
    655d:	48 89 df             	mov    %rbx,%rdi
    6560:	e8 2b 00 00 00       	call   6590 <fwp_rc_forget_slot>
    6565:	eb e3                	jmp    654a <fwp_rc_share+0x1ea>
    6567:	48 81 c4 00 02 00 00 	add    $0x200,%rsp
    656e:	5b                   	pop    %rbx
    656f:	41 5c                	pop    %r12
    6571:	41 5d                	pop    %r13
    6573:	41 5e                	pop    %r14
    6575:	41 5f                	pop    %r15
    6577:	c3                   	ret
    6578:	49 89 fe             	mov    %rdi,%r14
    657b:	48 89 df             	mov    %rbx,%rdi
    657e:	e8 0d 00 00 00       	call   6590 <fwp_rc_forget_slot>
    6583:	4c 89 f7             	mov    %r14,%rdi
    6586:	e9 6f fe ff ff       	jmp    63fa <fwp_rc_share+0x9a>
    658b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006590 <fwp_rc_forget_slot>:
    6590:	50                   	push   %rax
    6591:	80 3f ff             	cmpb   $0xff,(%rdi)
    6594:	74 02                	je     6598 <fwp_rc_forget_slot+0x8>
    6596:	58                   	pop    %rax
    6597:	c3                   	ret
    6598:	48 89 f8             	mov    %rdi,%rax
    659b:	48 c1 e8 11          	shr    $0x11,%rax
    659f:	31 f8                	xor    %edi,%eax
    65a1:	89 c1                	mov    %eax,%ecx
    65a3:	c1 e9 09             	shr    $0x9,%ecx
    65a6:	31 c1                	xor    %eax,%ecx
    65a8:	0f b6 c9             	movzbl %cl,%ecx
    65ab:	48 8d 15 d6 2c 01 00 	lea    0x12cd6(%rip),%rdx        # 19288 <fwp_gc>
    65b2:	48 8b 84 ca 18 12 00 	mov    0x1218(%rdx,%rcx,8),%rax
    65b9:	00 
    65ba:	48 85 c0             	test   %rax,%rax
    65bd:	74 4b                	je     660a <fwp_rc_forget_slot+0x7a>
    65bf:	48 39 38             	cmp    %rdi,(%rax)
    65c2:	74 23                	je     65e7 <fwp_rc_forget_slot+0x57>
    65c4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    65cb:	00 00 00 00 00 
    65d0:	48 89 c1             	mov    %rax,%rcx
    65d3:	48 8b 40 10          	mov    0x10(%rax),%rax
    65d7:	48 85 c0             	test   %rax,%rax
    65da:	74 2e                	je     660a <fwp_rc_forget_slot+0x7a>
    65dc:	48 39 38             	cmp    %rdi,(%rax)
    65df:	75 ef                	jne    65d0 <fwp_rc_forget_slot+0x40>
    65e1:	48 83 c1 10          	add    $0x10,%rcx
    65e5:	eb 0b                	jmp    65f2 <fwp_rc_forget_slot+0x62>
    65e7:	48 8d 0c ca          	lea    (%rdx,%rcx,8),%rcx
    65eb:	48 81 c1 18 12 00 00 	add    $0x1218,%rcx
    65f2:	48 8b 50 10          	mov    0x10(%rax),%rdx
    65f6:	48 89 11             	mov    %rdx,(%rcx)
    65f9:	48 89 c7             	mov    %rax,%rdi
    65fc:	e8 4f ca ff ff       	call   3050 <free@plt>
    6601:	48 ff 0d 98 46 01 00 	decq   0x14698(%rip)        # 1aca0 <fwp_gc+0x1a18>
    6608:	58                   	pop    %rax
    6609:	c3                   	ret
    660a:	e8 31 00 00 00       	call   6640 <fwp_flush>
    660f:	48 8b 05 c2 29 01 00 	mov    0x129c2(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    6616:	48 8b 38             	mov    (%rax),%rdi
    6619:	48 8d 35 2e e4 00 00 	lea    0xe42e(%rip),%rsi        # 14a4e <exec_in_fp0+0x23e>
    6620:	48 8d 15 00 e4 00 00 	lea    0xe400(%rip),%rdx        # 14a27 <exec_in_fp0+0x217>
    6627:	31 c0                	xor    %eax,%eax
    6629:	e8 c2 cc ff ff       	call   32f0 <fprintf@plt>
    662e:	bf 65 00 00 00       	mov    $0x65,%edi
    6633:	e8 28 ce ff ff       	call   3460 <exit@plt>
    6638:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    663f:	00 

0000000000006640 <fwp_flush>:
    6640:	50                   	push   %rax
    6641:	48 8b 3d b0 46 01 00 	mov    0x146b0(%rip),%rdi        # 1acf8 <fwp_prog_out>
    6648:	48 85 ff             	test   %rdi,%rdi
    664b:	74 05                	je     6652 <fwp_flush+0x12>
    664d:	e8 fe cc ff ff       	call   3350 <fflush@plt>
    6652:	48 8b 05 57 29 01 00 	mov    0x12957(%rip),%rax        # 18fb0 <stdout@GLIBC_2.2.5>
    6659:	48 8b 38             	mov    (%rax),%rdi
    665c:	58                   	pop    %rax
    665d:	e9 ee cc ff ff       	jmp    3350 <fflush@plt>
    6662:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6669:	1f 84 00 00 00 00 00 

0000000000006670 <fwp_owner_release3>:
    6670:	48 8b 3f             	mov    (%rdi),%rdi
    6673:	eb 0b                	jmp    6680 <fwp_drop1>
    6675:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    667c:	00 00 00 00 

0000000000006680 <fwp_drop1>:
    6680:	53                   	push   %rbx
    6681:	48 89 f8             	mov    %rdi,%rax
    6684:	48 2b 05 2d 3c 01 00 	sub    0x13c2d(%rip),%rax        # 1a2b8 <fwp_gc+0x1030>
    668b:	48 8b 0d 4e 3c 01 00 	mov    0x13c4e(%rip),%rcx        # 1a2e0 <fwp_gc+0x1058>
    6692:	48 c1 e1 10          	shl    $0x10,%rcx
    6696:	48 39 c8             	cmp    %rcx,%rax
    6699:	0f 83 9c 00 00 00    	jae    673b <fwp_drop1+0xbb>
    669f:	48 8b 0d 5a 3c 01 00 	mov    0x13c5a(%rip),%rcx        # 1a300 <fwp_gc+0x1078>
    66a6:	48 89 c2             	mov    %rax,%rdx
    66a9:	48 c1 ea 10          	shr    $0x10,%rdx
    66ad:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    66b4:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    66b8:	48 25 ff ff 00 00    	and    $0xffff,%rax
    66be:	75 20                	jne    66e0 <fwp_drop1+0x60>
    66c0:	40 80 fe 02          	cmp    $0x2,%sil
    66c4:	75 1a                	jne    66e0 <fwp_drop1+0x60>
    66c6:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    66ca:	48 05 28 02 00 00    	add    $0x228,%rax
    66d0:	eb 2d                	jmp    66ff <fwp_drop1+0x7f>
    66d2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    66d9:	1f 84 00 00 00 00 00 
    66e0:	40 80 fe 01          	cmp    $0x1,%sil
    66e4:	75 55                	jne    673b <fwp_drop1+0xbb>
    66e6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    66ea:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    66ee:	48 0f af c1          	imul   %rcx,%rax
    66f2:	48 c1 e8 20          	shr    $0x20,%rax
    66f6:	48 01 f0             	add    %rsi,%rax
    66f9:	48 05 28 02 00 00    	add    $0x228,%rax
    66ff:	0f b6 08             	movzbl (%rax),%ecx
    6702:	85 c9                	test   %ecx,%ecx
    6704:	74 35                	je     673b <fwp_drop1+0xbb>
    6706:	83 f9 01             	cmp    $0x1,%ecx
    6709:	75 32                	jne    673d <fwp_drop1+0xbd>
    670b:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    670f:	79 3a                	jns    674b <fwp_drop1+0xcb>
    6711:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    6715:	e8 b6 40 00 00       	call   a7d0 <fwp_rc_free_arr>
    671a:	48 89 d8             	mov    %rbx,%rax
    671d:	48 2b 05 94 3b 01 00 	sub    0x13b94(%rip),%rax        # 1a2b8 <fwp_gc+0x1030>
    6724:	48 8b 0d b5 3b 01 00 	mov    0x13bb5(%rip),%rcx        # 1a2e0 <fwp_gc+0x1058>
    672b:	48 c1 e1 10          	shl    $0x10,%rcx
    672f:	48 89 df             	mov    %rbx,%rdi
    6732:	48 39 c8             	cmp    %rcx,%rax
    6735:	0f 82 64 ff ff ff    	jb     669f <fwp_drop1+0x1f>
    673b:	5b                   	pop    %rbx
    673c:	c3                   	ret
    673d:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    6743:	74 0c                	je     6751 <fwp_drop1+0xd1>
    6745:	fe c9                	dec    %cl
    6747:	88 08                	mov    %cl,(%rax)
    6749:	5b                   	pop    %rbx
    674a:	c3                   	ret
    674b:	5b                   	pop    %rbx
    674c:	e9 7f 40 00 00       	jmp    a7d0 <fwp_rc_free_arr>
    6751:	48 89 c7             	mov    %rax,%rdi
    6754:	5b                   	pop    %rbx
    6755:	e9 f6 38 00 00       	jmp    a050 <fwp_rc_wide_drop>
    675a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000006760 <fwp_owner_release4>:
    6760:	48 8b 3f             	mov    (%rdi),%rdi
    6763:	e9 18 ff ff ff       	jmp    6680 <fwp_drop1>
    6768:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    676f:	00 

0000000000006770 <fwp_owner_release5>:
    6770:	48 8b 3f             	mov    (%rdi),%rdi
    6773:	e9 08 ff ff ff       	jmp    6680 <fwp_drop1>
    6778:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    677f:	00 

0000000000006780 <fwp_p_array_map_typed>:
    6780:	55                   	push   %rbp
    6781:	41 57                	push   %r15
    6783:	41 56                	push   %r14
    6785:	41 55                	push   %r13
    6787:	41 54                	push   %r12
    6789:	53                   	push   %rbx
    678a:	48 83 ec 18          	sub    $0x18,%rsp
    678e:	48 89 3c 24          	mov    %rdi,(%rsp)
    6792:	49 bf ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r15
    6799:	ff ff 7f 
    679c:	4c 23 3e             	and    (%rsi),%r15
    679f:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    67a6:	ff ff 1f 
    67a9:	49 39 c7             	cmp    %rax,%r15
    67ac:	0f 83 16 02 00 00    	jae    69c8 <fwp_p_array_map_typed+0x248>
    67b2:	49 89 ce             	mov    %rcx,%r14
    67b5:	49 89 d4             	mov    %rdx,%r12
    67b8:	48 89 f3             	mov    %rsi,%rbx
    67bb:	4c 89 ff             	mov    %r15,%rdi
    67be:	48 89 d6             	mov    %rdx,%rsi
    67c1:	e8 0a ed ff ff       	call   54d0 <fwp_array_new_packed>
    67c6:	48 89 c5             	mov    %rax,%rbp
    67c9:	48 2b 05 e8 3a 01 00 	sub    0x13ae8(%rip),%rax        # 1a2b8 <fwp_gc+0x1030>
    67d0:	48 8b 0d 09 3b 01 00 	mov    0x13b09(%rip),%rcx        # 1a2e0 <fwp_gc+0x1058>
    67d7:	48 c1 e1 10          	shl    $0x10,%rcx
    67db:	48 39 c8             	cmp    %rcx,%rax
    67de:	73 72                	jae    6852 <fwp_p_array_map_typed+0xd2>
    67e0:	48 8b 0d 19 3b 01 00 	mov    0x13b19(%rip),%rcx        # 1a300 <fwp_gc+0x1078>
    67e7:	48 89 c2             	mov    %rax,%rdx
    67ea:	48 c1 ea 10          	shr    $0x10,%rdx
    67ee:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    67f5:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    67f9:	48 25 ff ff 00 00    	and    $0xffff,%rax
    67ff:	75 1f                	jne    6820 <fwp_p_array_map_typed+0xa0>
    6801:	40 80 fe 02          	cmp    $0x2,%sil
    6805:	75 19                	jne    6820 <fwp_p_array_map_typed+0xa0>
    6807:	4c 8d 2c 11          	lea    (%rcx,%rdx,1),%r13
    680b:	49 81 c5 28 02 00 00 	add    $0x228,%r13
    6812:	41 80 7d 00 ff       	cmpb   $0xff,0x0(%r13)
    6817:	74 2f                	je     6848 <fwp_p_array_map_typed+0xc8>
    6819:	41 c6 45 00 01       	movb   $0x1,0x0(%r13)
    681e:	eb 32                	jmp    6852 <fwp_p_array_map_typed+0xd2>
    6820:	40 80 fe 01          	cmp    $0x1,%sil
    6824:	75 2c                	jne    6852 <fwp_p_array_map_typed+0xd2>
    6826:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    682a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    682e:	48 0f af c1          	imul   %rcx,%rax
    6832:	48 c1 e8 20          	shr    $0x20,%rax
    6836:	4c 8d 2c 30          	lea    (%rax,%rsi,1),%r13
    683a:	49 81 c5 28 02 00 00 	add    $0x228,%r13
    6841:	41 80 7d 00 ff       	cmpb   $0xff,0x0(%r13)
    6846:	75 d1                	jne    6819 <fwp_p_array_map_typed+0x99>
    6848:	4c 89 ef             	mov    %r13,%rdi
    684b:	e8 40 fd ff ff       	call   6590 <fwp_rc_forget_slot>
    6850:	eb c7                	jmp    6819 <fwp_p_array_map_typed+0x99>
    6852:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
    6857:	4d 85 ff             	test   %r15,%r15
    685a:	0f 84 24 01 00 00    	je     6984 <fwp_p_array_map_typed+0x204>
    6860:	4c 8d 7b 08          	lea    0x8(%rbx),%r15
    6864:	45 31 ed             	xor    %r13d,%r13d
    6867:	eb 1a                	jmp    6883 <fwp_p_array_map_typed+0x103>
    6869:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    6870:	4a 89 44 ed 08       	mov    %rax,0x8(%rbp,%r13,8)
    6875:	49 ff c5             	inc    %r13
    6878:	4c 39 6c 24 08       	cmp    %r13,0x8(%rsp)
    687d:	0f 84 01 01 00 00    	je     6984 <fwp_p_array_map_typed+0x204>
    6883:	b8 08 00 00 00       	mov    $0x8,%eax
    6888:	4d 85 f6             	test   %r14,%r14
    688b:	74 14                	je     68a1 <fwp_p_array_map_typed+0x121>
    688d:	41 8b 0e             	mov    (%r14),%ecx
    6890:	48 83 f9 0a          	cmp    $0xa,%rcx
    6894:	77 0b                	ja     68a1 <fwp_p_array_map_typed+0x121>
    6896:	48 8d 05 f3 df 00 00 	lea    0xdff3(%rip),%rax        # 14890 <exec_in_fp0+0x80>
    689d:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    68a1:	48 83 3b 00          	cmpq   $0x0,(%rbx)
    68a5:	4c 89 f9             	mov    %r15,%rcx
    68a8:	79 04                	jns    68ae <fwp_p_array_map_typed+0x12e>
    68aa:	48 8b 4b 10          	mov    0x10(%rbx),%rcx
    68ae:	48 89 c2             	mov    %rax,%rdx
    68b1:	49 0f af d5          	imul   %r13,%rdx
    68b5:	48 83 f8 01          	cmp    $0x1,%rax
    68b9:	74 25                	je     68e0 <fwp_p_array_map_typed+0x160>
    68bb:	48 83 f8 02          	cmp    $0x2,%rax
    68bf:	74 0f                	je     68d0 <fwp_p_array_map_typed+0x150>
    68c1:	48 83 f8 08          	cmp    $0x8,%rax
    68c5:	75 29                	jne    68f0 <fwp_p_array_map_typed+0x170>
    68c7:	48 8b 04 11          	mov    (%rcx,%rdx,1),%rax
    68cb:	eb 31                	jmp    68fe <fwp_p_array_map_typed+0x17e>
    68cd:	0f 1f 00             	nopl   (%rax)
    68d0:	41 83 3e 01          	cmpl   $0x1,(%r14)
    68d4:	0f b7 0c 11          	movzwl (%rcx,%rdx,1),%ecx
    68d8:	48 0f bf c1          	movswq %cx,%rax
    68dc:	eb 1c                	jmp    68fa <fwp_p_array_map_typed+0x17a>
    68de:	66 90                	xchg   %ax,%ax
    68e0:	41 83 3e 00          	cmpl   $0x0,(%r14)
    68e4:	0f b6 0c 11          	movzbl (%rcx,%rdx,1),%ecx
    68e8:	48 0f be c1          	movsbq %cl,%rax
    68ec:	eb 0c                	jmp    68fa <fwp_p_array_map_typed+0x17a>
    68ee:	66 90                	xchg   %ax,%ax
    68f0:	41 83 3e 02          	cmpl   $0x2,(%r14)
    68f4:	8b 0c 11             	mov    (%rcx,%rdx,1),%ecx
    68f7:	48 63 c1             	movslq %ecx,%rax
    68fa:	48 0f 45 c1          	cmovne %rcx,%rax
    68fe:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    6903:	48 8b 3c 24          	mov    (%rsp),%rdi
    6907:	be 01 00 00 00       	mov    $0x1,%esi
    690c:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    6911:	31 c9                	xor    %ecx,%ecx
    6913:	e8 d8 00 00 00       	call   69f0 <fwp_apply_borrowed_prefix>
    6918:	48 83 7d 00 00       	cmpq   $0x0,0x0(%rbp)
    691d:	78 7b                	js     699a <fwp_p_array_map_typed+0x21a>
    691f:	4d 85 e4             	test   %r12,%r12
    6922:	0f 84 48 ff ff ff    	je     6870 <fwp_p_array_map_typed+0xf0>
    6928:	41 8b 0c 24          	mov    (%r12),%ecx
    692c:	83 f9 0a             	cmp    $0xa,%ecx
    692f:	0f 87 3b ff ff ff    	ja     6870 <fwp_p_array_map_typed+0xf0>
    6935:	ba 84 04 00 00       	mov    $0x484,%edx
    693a:	0f a3 ca             	bt     %ecx,%edx
    693d:	72 31                	jb     6970 <fwp_p_array_map_typed+0x1f0>
    693f:	ba 21 00 00 00       	mov    $0x21,%edx
    6944:	0f a3 ca             	bt     %ecx,%edx
    6947:	72 31                	jb     697a <fwp_p_array_map_typed+0x1fa>
    6949:	ba 42 00 00 00       	mov    $0x42,%edx
    694e:	0f a3 ca             	bt     %ecx,%edx
    6951:	0f 83 19 ff ff ff    	jae    6870 <fwp_p_array_map_typed+0xf0>
    6957:	66 42 89 44 6d 08    	mov    %ax,0x8(%rbp,%r13,2)
    695d:	e9 13 ff ff ff       	jmp    6875 <fwp_p_array_map_typed+0xf5>
    6962:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6969:	1f 84 00 00 00 00 00 
    6970:	42 89 44 ad 08       	mov    %eax,0x8(%rbp,%r13,4)
    6975:	e9 fb fe ff ff       	jmp    6875 <fwp_p_array_map_typed+0xf5>
    697a:	42 88 44 2d 08       	mov    %al,0x8(%rbp,%r13,1)
    697f:	e9 f1 fe ff ff       	jmp    6875 <fwp_p_array_map_typed+0xf5>
    6984:	48 8b 04 24          	mov    (%rsp),%rax
    6988:	48 89 e8             	mov    %rbp,%rax
    698b:	48 83 c4 18          	add    $0x18,%rsp
    698f:	5b                   	pop    %rbx
    6990:	41 5c                	pop    %r12
    6992:	41 5d                	pop    %r13
    6994:	41 5e                	pop    %r14
    6996:	41 5f                	pop    %r15
    6998:	5d                   	pop    %rbp
    6999:	c3                   	ret
    699a:	e8 a1 fc ff ff       	call   6640 <fwp_flush>
    699f:	48 8b 05 32 26 01 00 	mov    0x12632(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    69a6:	48 8b 38             	mov    (%rax),%rdi
    69a9:	48 8d 35 9e e0 00 00 	lea    0xe09e(%rip),%rsi        # 14a4e <exec_in_fp0+0x23e>
    69b0:	48 8d 15 c7 ef 00 00 	lea    0xefc7(%rip),%rdx        # 1597e <exec_in_fp0+0x116e>
    69b7:	31 c0                	xor    %eax,%eax
    69b9:	e8 32 c9 ff ff       	call   32f0 <fprintf@plt>
    69be:	bf 65 00 00 00       	mov    $0x65,%edi
    69c3:	e8 98 ca ff ff       	call   3460 <exit@plt>
    69c8:	e8 73 fc ff ff       	call   6640 <fwp_flush>
    69cd:	48 8b 05 04 26 01 00 	mov    0x12604(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    69d4:	48 8b 38             	mov    (%rax),%rdi
    69d7:	48 8d 35 70 e0 00 00 	lea    0xe070(%rip),%rsi        # 14a4e <exec_in_fp0+0x23e>
    69de:	48 8d 15 78 e0 00 00 	lea    0xe078(%rip),%rdx        # 14a5d <exec_in_fp0+0x24d>
    69e5:	eb d0                	jmp    69b7 <fwp_p_array_map_typed+0x237>
    69e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    69ee:	00 00 

00000000000069f0 <fwp_apply_borrowed_prefix>:
    69f0:	55                   	push   %rbp
    69f1:	41 57                	push   %r15
    69f3:	41 56                	push   %r14
    69f5:	41 55                	push   %r13
    69f7:	41 54                	push   %r12
    69f9:	53                   	push   %rbx
    69fa:	48 81 ec a8 00 00 00 	sub    $0xa8,%rsp
    6a01:	41 89 cf             	mov    %ecx,%r15d
    6a04:	49 89 d5             	mov    %rdx,%r13
    6a07:	49 89 fe             	mov    %rdi,%r14
    6a0a:	4c 8b 25 df 42 01 00 	mov    0x142df(%rip),%r12        # 1acf0 <fwp_fns>
    6a11:	8b 0f                	mov    (%rdi),%ecx
    6a13:	48 c1 e1 05          	shl    $0x5,%rcx
    6a17:	49 8b 44 0c 18       	mov    0x18(%r12,%rcx,1),%rax
    6a1c:	48 85 c0             	test   %rax,%rax
    6a1f:	0f 84 b7 03 00 00    	je     6ddc <fwp_apply_borrowed_prefix+0x3ec>
    6a25:	49 8d 2c 0c          	lea    (%r12,%rcx,1),%rbp
    6a29:	48 83 c5 18          	add    $0x18,%rbp
    6a2d:	49 01 cc             	add    %rcx,%r12
    6a30:	31 c9                	xor    %ecx,%ecx
    6a32:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6a39:	1f 84 00 00 00 00 00 
    6a40:	f6 c1 01             	test   $0x1,%cl
    6a43:	ba 00 00 00 00       	mov    $0x0,%edx
    6a48:	49 0f 45 d6          	cmovne %r14,%rdx
    6a4c:	48 89 94 24 80 00 00 	mov    %rdx,0x80(%rsp)
    6a53:	00 
    6a54:	4c 89 ac 24 88 00 00 	mov    %r13,0x88(%rsp)
    6a5b:	00 
    6a5c:	48 89 84 24 90 00 00 	mov    %rax,0x90(%rsp)
    6a63:	00 
    6a64:	c7 84 24 98 00 00 00 	movl   $0x0,0x98(%rsp)
    6a6b:	00 00 00 00 
    6a6f:	41 8b 56 04          	mov    0x4(%r14),%edx
    6a73:	89 94 24 9c 00 00 00 	mov    %edx,0x9c(%rsp)
    6a7a:	4c 89 f2             	mov    %r14,%rdx
    6a7d:	48 2b 15 34 38 01 00 	sub    0x13834(%rip),%rdx        # 1a2b8 <fwp_gc+0x1030>
    6a84:	44 89 bc 24 a0 00 00 	mov    %r15d,0xa0(%rsp)
    6a8b:	00 
    6a8c:	4c 8b 1d 4d 38 01 00 	mov    0x1384d(%rip),%r11        # 1a2e0 <fwp_gc+0x1058>
    6a93:	49 c1 e3 10          	shl    $0x10,%r11
    6a97:	4c 39 da             	cmp    %r11,%rdx
    6a9a:	73 74                	jae    6b10 <fwp_apply_borrowed_prefix+0x120>
    6a9c:	48 8b 3d 5d 38 01 00 	mov    0x1385d(%rip),%rdi        # 1a300 <fwp_gc+0x1078>
    6aa3:	49 89 d0             	mov    %rdx,%r8
    6aa6:	49 c1 e8 10          	shr    $0x10,%r8
    6aaa:	4d 69 c8 28 12 00 00 	imul   $0x1228,%r8,%r9
    6ab1:	46 0f b6 14 0f       	movzbl (%rdi,%r9,1),%r10d
    6ab6:	49 89 d0             	mov    %rdx,%r8
    6ab9:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    6ac0:	75 1e                	jne    6ae0 <fwp_apply_borrowed_prefix+0xf0>
    6ac2:	41 80 fa 02          	cmp    $0x2,%r10b
    6ac6:	75 18                	jne    6ae0 <fwp_apply_borrowed_prefix+0xf0>
    6ac8:	4c 01 cf             	add    %r9,%rdi
    6acb:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    6ad2:	80 3f 00             	cmpb   $0x0,(%rdi)
    6ad5:	75 45                	jne    6b1c <fwp_apply_borrowed_prefix+0x12c>
    6ad7:	eb 37                	jmp    6b10 <fwp_apply_borrowed_prefix+0x120>
    6ad9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    6ae0:	41 80 fa 01          	cmp    $0x1,%r10b
    6ae4:	75 2a                	jne    6b10 <fwp_apply_borrowed_prefix+0x120>
    6ae6:	4e 8d 14 0f          	lea    (%rdi,%r9,1),%r10
    6aea:	42 8b 7c 0f 20       	mov    0x20(%rdi,%r9,1),%edi
    6aef:	4c 0f af c7          	imul   %rdi,%r8
    6af3:	49 c1 e8 20          	shr    $0x20,%r8
    6af7:	4b 8d 3c 10          	lea    (%r8,%r10,1),%rdi
    6afb:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    6b02:	80 3f 00             	cmpb   $0x0,(%rdi)
    6b05:	75 15                	jne    6b1c <fwp_apply_borrowed_prefix+0x12c>
    6b07:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    6b0e:	00 00 
    6b10:	45 85 ff             	test   %r15d,%r15d
    6b13:	74 5b                	je     6b70 <fwp_apply_borrowed_prefix+0x180>
    6b15:	48 83 78 18 00       	cmpq   $0x0,0x18(%rax)
    6b1a:	74 54                	je     6b70 <fwp_apply_borrowed_prefix+0x180>
    6b1c:	48 ff 05 1d 42 01 00 	incq   0x1421d(%rip)        # 1ad40 <measured_scopes>
    6b23:	48 8b 3d 1e 42 01 00 	mov    0x1421e(%rip),%rdi        # 1ad48 <fwp_cleanups>
    6b2a:	48 89 7c 24 68       	mov    %rdi,0x68(%rsp)
    6b2f:	48 8d 3d 6a 08 00 00 	lea    0x86a(%rip),%rdi        # 73a0 <fwp_apply_release>
    6b36:	48 89 7c 24 70       	mov    %rdi,0x70(%rsp)
    6b3b:	48 8d bc 24 80 00 00 	lea    0x80(%rsp),%rdi
    6b42:	00 
    6b43:	48 89 7c 24 78       	mov    %rdi,0x78(%rsp)
    6b48:	48 8d 7c 24 68       	lea    0x68(%rsp),%rdi
    6b4d:	48 89 3d f4 41 01 00 	mov    %rdi,0x141f4(%rip)        # 1ad48 <fwp_cleanups>
    6b54:	40 b7 01             	mov    $0x1,%dil
    6b57:	89 7c 24 04          	mov    %edi,0x4(%rsp)
    6b5b:	f6 c1 01             	test   $0x1,%cl
    6b5e:	74 21                	je     6b81 <fwp_apply_borrowed_prefix+0x191>
    6b60:	e9 9c 00 00 00       	jmp    6c01 <fwp_apply_borrowed_prefix+0x211>
    6b65:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    6b6c:	00 00 00 00 
    6b70:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%rsp)
    6b77:	00 
    6b78:	f6 c1 01             	test   $0x1,%cl
    6b7b:	0f 85 80 00 00 00    	jne    6c01 <fwp_apply_borrowed_prefix+0x211>
    6b81:	4c 39 da             	cmp    %r11,%rdx
    6b84:	73 6f                	jae    6bf5 <fwp_apply_borrowed_prefix+0x205>
    6b86:	48 8b 05 73 37 01 00 	mov    0x13773(%rip),%rax        # 1a300 <fwp_gc+0x1078>
    6b8d:	48 89 d1             	mov    %rdx,%rcx
    6b90:	48 c1 e9 10          	shr    $0x10,%rcx
    6b94:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    6b9b:	0f b6 3c 08          	movzbl (%rax,%rcx,1),%edi
    6b9f:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    6ba6:	75 13                	jne    6bbb <fwp_apply_borrowed_prefix+0x1cb>
    6ba8:	40 80 ff 02          	cmp    $0x2,%dil
    6bac:	75 0d                	jne    6bbb <fwp_apply_borrowed_prefix+0x1cb>
    6bae:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    6bb2:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    6bb9:	eb 20                	jmp    6bdb <fwp_apply_borrowed_prefix+0x1eb>
    6bbb:	40 80 ff 01          	cmp    $0x1,%dil
    6bbf:	75 34                	jne    6bf5 <fwp_apply_borrowed_prefix+0x205>
    6bc1:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    6bc5:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    6bc9:	48 0f af d0          	imul   %rax,%rdx
    6bcd:	48 c1 ea 20          	shr    $0x20,%rdx
    6bd1:	48 01 d7             	add    %rdx,%rdi
    6bd4:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    6bdb:	0f b6 07             	movzbl (%rdi),%eax
    6bde:	84 c0                	test   %al,%al
    6be0:	74 13                	je     6bf5 <fwp_apply_borrowed_prefix+0x205>
    6be2:	48 ff 05 4f 41 01 00 	incq   0x1414f(%rip)        # 1ad38 <measured_retains>
    6be9:	3c fe                	cmp    $0xfe,%al
    6beb:	0f 83 dd 01 00 00    	jae    6dce <fwp_apply_borrowed_prefix+0x3de>
    6bf1:	fe c0                	inc    %al
    6bf3:	88 07                	mov    %al,(%rdi)
    6bf5:	4c 89 b4 24 80 00 00 	mov    %r14,0x80(%rsp)
    6bfc:	00 
    6bfd:	48 8b 45 00          	mov    0x0(%rbp),%rax
    6c01:	45 8b 24 24          	mov    (%r12),%r12d
    6c05:	45 2b 66 04          	sub    0x4(%r14),%r12d
    6c09:	44 39 e6             	cmp    %r12d,%esi
    6c0c:	44 89 64 24 14       	mov    %r12d,0x14(%rsp)
    6c11:	44 0f 42 e6          	cmovb  %esi,%r12d
    6c15:	45 39 e7             	cmp    %r12d,%r15d
    6c18:	44 89 e2             	mov    %r12d,%edx
    6c1b:	41 0f 42 d7          	cmovb  %r15d,%edx
    6c1f:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    6c26:	00 00 
    6c28:	4c 89 6c 24 20       	mov    %r13,0x20(%rsp)
    6c2d:	4d 8d 6c d5 00       	lea    0x0(%r13,%rdx,8),%r13
    6c32:	4c 89 6c 24 48       	mov    %r13,0x48(%rsp)
    6c37:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    6c3c:	c7 44 24 58 00 00 00 	movl   $0x0,0x58(%rsp)
    6c43:	00 
    6c44:	41 8b 4e 04          	mov    0x4(%r14),%ecx
    6c48:	01 d1                	add    %edx,%ecx
    6c4a:	89 4c 24 5c          	mov    %ecx,0x5c(%rsp)
    6c4e:	c7 44 24 60 00 00 00 	movl   $0x0,0x60(%rsp)
    6c55:	00 
    6c56:	31 db                	xor    %ebx,%ebx
    6c58:	b9 00 00 00 00       	mov    $0x0,%ecx
    6c5d:	45 39 fc             	cmp    %r15d,%r12d
    6c60:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)
    6c65:	0f 86 a2 00 00 00    	jbe    6d0d <fwp_apply_borrowed_prefix+0x31d>
    6c6b:	44 89 7c 24 0c       	mov    %r15d,0xc(%rsp)
    6c70:	89 74 24 10          	mov    %esi,0x10(%rsp)
    6c74:	48 83 78 18 00       	cmpq   $0x0,0x18(%rax)
    6c79:	0f 95 c0             	setne  %al
    6c7c:	89 44 24 08          	mov    %eax,0x8(%rsp)
    6c80:	74 35                	je     6cb7 <fwp_apply_borrowed_prefix+0x2c7>
    6c82:	48 ff 05 b7 40 01 00 	incq   0x140b7(%rip)        # 1ad40 <measured_scopes>
    6c89:	48 8b 05 b8 40 01 00 	mov    0x140b8(%rip),%rax        # 1ad48 <fwp_cleanups>
    6c90:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    6c95:	48 8d 05 04 07 00 00 	lea    0x704(%rip),%rax        # 73a0 <fwp_apply_release>
    6c9c:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    6ca1:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
    6ca6:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    6cab:	48 8d 44 24 28       	lea    0x28(%rsp),%rax
    6cb0:	48 89 05 91 40 01 00 	mov    %rax,0x14091(%rip)        # 1ad48 <fwp_cleanups>
    6cb7:	45 89 e7             	mov    %r12d,%r15d
    6cba:	41 29 d7             	sub    %edx,%r15d
    6cbd:	41 83 ff 01          	cmp    $0x1,%r15d
    6cc1:	41 83 d7 00          	adc    $0x0,%r15d
    6cc5:	49 c1 e7 03          	shl    $0x3,%r15
    6cc9:	89 d3                	mov    %edx,%ebx
    6ccb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    6cd0:	48 8b 45 00          	mov    0x0(%rbp),%rax
    6cd4:	41 8b 76 04          	mov    0x4(%r14),%esi
    6cd8:	01 de                	add    %ebx,%esi
    6cda:	4c 89 ef             	mov    %r13,%rdi
    6cdd:	ba 01 00 00 00       	mov    $0x1,%edx
    6ce2:	ff 50 10             	call   *0x10(%rax)
    6ce5:	8b 4c 24 60          	mov    0x60(%rsp),%ecx
    6ce9:	ff c1                	inc    %ecx
    6ceb:	89 4c 24 60          	mov    %ecx,0x60(%rsp)
    6cef:	ff c3                	inc    %ebx
    6cf1:	49 83 c5 08          	add    $0x8,%r13
    6cf5:	49 83 c7 f8          	add    $0xfffffffffffffff8,%r15
    6cf9:	75 d5                	jne    6cd0 <fwp_apply_borrowed_prefix+0x2e0>
    6cfb:	8b 74 24 10          	mov    0x10(%rsp),%esi
    6cff:	44 8b 7c 24 0c       	mov    0xc(%rsp),%r15d
    6d04:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
    6d09:	8b 5c 24 08          	mov    0x8(%rsp),%ebx
    6d0d:	89 f5                	mov    %esi,%ebp
    6d0f:	89 4c 24 58          	mov    %ecx,0x58(%rsp)
    6d13:	48 c7 84 24 80 00 00 	movq   $0x0,0x80(%rsp)
    6d1a:	00 00 00 00 00 
    6d1f:	89 94 24 98 00 00 00 	mov    %edx,0x98(%rsp)
    6d26:	4c 89 f7             	mov    %r14,%rdi
    6d29:	44 89 e6             	mov    %r12d,%esi
    6d2c:	4c 8b 6c 24 20       	mov    0x20(%rsp),%r13
    6d31:	4c 89 ea             	mov    %r13,%rdx
    6d34:	e8 d7 06 00 00       	call   7410 <fwp_apply_owned>
    6d39:	49 89 c6             	mov    %rax,%r14
    6d3c:	84 db                	test   %bl,%bl
    6d3e:	74 1e                	je     6d5e <fwp_apply_borrowed_prefix+0x36e>
    6d40:	48 8d 44 24 28       	lea    0x28(%rsp),%rax
    6d45:	48 39 05 fc 3f 01 00 	cmp    %rax,0x13ffc(%rip)        # 1ad48 <fwp_cleanups>
    6d4c:	0f 85 e5 00 00 00    	jne    6e37 <fwp_apply_borrowed_prefix+0x447>
    6d52:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    6d57:	48 89 05 ea 3f 01 00 	mov    %rax,0x13fea(%rip)        # 1ad48 <fwp_cleanups>
    6d5e:	80 7c 24 04 00       	cmpb   $0x0,0x4(%rsp)
    6d63:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    6d68:	89 ee                	mov    %ebp,%esi
    6d6a:	74 1e                	je     6d8a <fwp_apply_borrowed_prefix+0x39a>
    6d6c:	48 8d 44 24 68       	lea    0x68(%rsp),%rax
    6d71:	48 39 05 d0 3f 01 00 	cmp    %rax,0x13fd0(%rip)        # 1ad48 <fwp_cleanups>
    6d78:	0f 85 b9 00 00 00    	jne    6e37 <fwp_apply_borrowed_prefix+0x447>
    6d7e:	48 8b 44 24 68       	mov    0x68(%rsp),%rax
    6d83:	48 89 05 be 3f 01 00 	mov    %rax,0x13fbe(%rip)        # 1ad48 <fwp_cleanups>
    6d8a:	3b 74 24 14          	cmp    0x14(%rsp),%esi
    6d8e:	0f 86 8e 00 00 00    	jbe    6e22 <fwp_apply_borrowed_prefix+0x432>
    6d94:	44 89 e0             	mov    %r12d,%eax
    6d97:	4d 8d 6c c5 00       	lea    0x0(%r13,%rax,8),%r13
    6d9c:	44 29 e6             	sub    %r12d,%esi
    6d9f:	41 29 cf             	sub    %ecx,%r15d
    6da2:	48 8b 05 47 3f 01 00 	mov    0x13f47(%rip),%rax        # 1acf0 <fwp_fns>
    6da9:	41 8b 0e             	mov    (%r14),%ecx
    6dac:	48 c1 e1 05          	shl    $0x5,%rcx
    6db0:	4c 8d 24 08          	lea    (%rax,%rcx,1),%r12
    6db4:	48 8d 2c 08          	lea    (%rax,%rcx,1),%rbp
    6db8:	48 83 c5 18          	add    $0x18,%rbp
    6dbc:	48 8b 44 08 18       	mov    0x18(%rax,%rcx,1),%rax
    6dc1:	b1 01                	mov    $0x1,%cl
    6dc3:	48 85 c0             	test   %rax,%rax
    6dc6:	0f 85 74 fc ff ff    	jne    6a40 <fwp_apply_borrowed_prefix+0x50>
    6dcc:	eb 0e                	jmp    6ddc <fwp_apply_borrowed_prefix+0x3ec>
    6dce:	89 f3                	mov    %esi,%ebx
    6dd0:	e8 0b 33 00 00       	call   a0e0 <fwp_rc_wide_dup>
    6dd5:	89 de                	mov    %ebx,%esi
    6dd7:	e9 19 fe ff ff       	jmp    6bf5 <fwp_apply_borrowed_prefix+0x205>
    6ddc:	4c 89 f7             	mov    %r14,%rdi
    6ddf:	89 f3                	mov    %esi,%ebx
    6de1:	e8 7a f5 ff ff       	call   6360 <fwp_rc_share>
    6de6:	89 dd                	mov    %ebx,%ebp
    6de8:	85 db                	test   %ebx,%ebx
    6dea:	74 26                	je     6e12 <fwp_apply_borrowed_prefix+0x422>
    6dec:	89 eb                	mov    %ebp,%ebx
    6dee:	45 31 ff             	xor    %r15d,%r15d
    6df1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6df8:	0f 1f 84 00 00 00 00 
    6dff:	00 
    6e00:	4b 8b 7c fd 00       	mov    0x0(%r13,%r15,8),%rdi
    6e05:	e8 56 f5 ff ff       	call   6360 <fwp_rc_share>
    6e0a:	49 ff c7             	inc    %r15
    6e0d:	4c 39 fb             	cmp    %r15,%rbx
    6e10:	75 ee                	jne    6e00 <fwp_apply_borrowed_prefix+0x410>
    6e12:	4c 89 f7             	mov    %r14,%rdi
    6e15:	89 ee                	mov    %ebp,%esi
    6e17:	4c 89 ea             	mov    %r13,%rdx
    6e1a:	e8 21 00 00 00       	call   6e40 <fwp_apply>
    6e1f:	49 89 c6             	mov    %rax,%r14
    6e22:	4c 89 f0             	mov    %r14,%rax
    6e25:	48 81 c4 a8 00 00 00 	add    $0xa8,%rsp
    6e2c:	5b                   	pop    %rbx
    6e2d:	41 5c                	pop    %r12
    6e2f:	41 5d                	pop    %r13
    6e31:	41 5e                	pop    %r14
    6e33:	41 5f                	pop    %r15
    6e35:	5d                   	pop    %rbp
    6e36:	c3                   	ret
    6e37:	e8 34 c2 ff ff       	call   3070 <abort@plt>
    6e3c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000006e40 <fwp_apply>:
    6e40:	55                   	push   %rbp
    6e41:	48 89 e5             	mov    %rsp,%rbp
    6e44:	41 57                	push   %r15
    6e46:	41 56                	push   %r14
    6e48:	41 55                	push   %r13
    6e4a:	41 54                	push   %r12
    6e4c:	53                   	push   %rbx
    6e4d:	48 83 ec 18          	sub    $0x18,%rsp
    6e51:	48 89 d3             	mov    %rdx,%rbx
    6e54:	49 89 ff             	mov    %rdi,%r15
    6e57:	eb 23                	jmp    6e7c <fwp_apply+0x3c>
    6e59:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    6e60:	4a 8d 1c f3          	lea    (%rbx,%r14,8),%rbx
    6e64:	31 c9                	xor    %ecx,%ecx
    6e66:	49 89 c7             	mov    %rax,%r15
    6e69:	4c 8b 75 c8          	mov    -0x38(%rbp),%r14
    6e6d:	48 8b 65 c0          	mov    -0x40(%rbp),%rsp
    6e71:	89 d6                	mov    %edx,%esi
    6e73:	83 f9 01             	cmp    $0x1,%ecx
    6e76:	0f 84 aa 04 00 00    	je     7326 <fwp_apply+0x4e6>
    6e7c:	48 8b 05 6d 3e 01 00 	mov    0x13e6d(%rip),%rax        # 1acf0 <fwp_fns>
    6e83:	41 8b 0f             	mov    (%r15),%ecx
    6e86:	45 8b 6f 04          	mov    0x4(%r15),%r13d
    6e8a:	48 c1 e1 05          	shl    $0x5,%rcx
    6e8e:	44 8b 24 08          	mov    (%rax,%rcx,1),%r12d
    6e92:	4d 85 ed             	test   %r13,%r13
    6e95:	75 39                	jne    6ed0 <fwp_apply+0x90>
    6e97:	41 8d 54 24 ff       	lea    -0x1(%r12),%edx
    6e9c:	39 f2                	cmp    %esi,%edx
    6e9e:	73 30                	jae    6ed0 <fwp_apply+0x90>
    6ea0:	48 89 df             	mov    %rbx,%rdi
    6ea3:	49 89 f7             	mov    %rsi,%r15
    6ea6:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    6eaa:	4c 89 fe             	mov    %r15,%rsi
    6ead:	49 89 c7             	mov    %rax,%r15
    6eb0:	44 39 e6             	cmp    %r12d,%esi
    6eb3:	0f 84 b6 02 00 00    	je     716f <fwp_apply+0x32f>
    6eb9:	4a 8d 1c e3          	lea    (%rbx,%r12,8),%rbx
    6ebd:	44 29 e6             	sub    %r12d,%esi
    6ec0:	b9 03 00 00 00       	mov    $0x3,%ecx
    6ec5:	83 f9 01             	cmp    $0x1,%ecx
    6ec8:	75 b2                	jne    6e7c <fwp_apply+0x3c>
    6eca:	e9 57 04 00 00       	jmp    7326 <fwp_apply+0x4e6>
    6ecf:	90                   	nop
    6ed0:	4c 89 75 c8          	mov    %r14,-0x38(%rbp)
    6ed4:	46 8d 34 2e          	lea    (%rsi,%r13,1),%r14d
    6ed8:	45 39 e6             	cmp    %r12d,%r14d
    6edb:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    6edf:	0f 82 1a 02 00 00    	jb     70ff <fwp_apply+0x2bf>
    6ee5:	48 89 65 c0          	mov    %rsp,-0x40(%rbp)
    6ee9:	45 89 e3             	mov    %r12d,%r11d
    6eec:	41 83 fc 02          	cmp    $0x2,%r12d
    6ef0:	ba 01 00 00 00       	mov    $0x1,%edx
    6ef5:	41 0f 43 d4          	cmovae %r12d,%edx
    6ef9:	48 8d 14 d5 0f 00 00 	lea    0xf(,%rdx,8),%rdx
    6f00:	00 
    6f01:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
    6f05:	48 89 e7             	mov    %rsp,%rdi
    6f08:	48 29 d7             	sub    %rdx,%rdi
    6f0b:	48 89 fc             	mov    %rdi,%rsp
    6f0e:	4d 85 ed             	test   %r13,%r13
    6f11:	0f 84 c9 00 00 00    	je     6fe0 <fwp_apply+0x1a0>
    6f17:	41 83 fd 04          	cmp    $0x4,%r13d
    6f1b:	72 10                	jb     6f2d <fwp_apply+0xed>
    6f1d:	48 89 fa             	mov    %rdi,%rdx
    6f20:	4c 29 fa             	sub    %r15,%rdx
    6f23:	48 83 c2 f8          	add    $0xfffffffffffffff8,%rdx
    6f27:	48 83 fa 20          	cmp    $0x20,%rdx
    6f2b:	73 65                	jae    6f92 <fwp_apply+0x152>
    6f2d:	31 d2                	xor    %edx,%edx
    6f2f:	4d 89 e8             	mov    %r13,%r8
    6f32:	49 89 d2             	mov    %rdx,%r10
    6f35:	49 83 e0 03          	and    $0x3,%r8
    6f39:	74 16                	je     6f51 <fwp_apply+0x111>
    6f3b:	49 89 d2             	mov    %rdx,%r10
    6f3e:	66 90                	xchg   %ax,%ax
    6f40:	4f 8b 4c d7 08       	mov    0x8(%r15,%r10,8),%r9
    6f45:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    6f49:	49 ff c2             	inc    %r10
    6f4c:	49 ff c8             	dec    %r8
    6f4f:	75 ef                	jne    6f40 <fwp_apply+0x100>
    6f51:	4c 29 ea             	sub    %r13,%rdx
    6f54:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    6f58:	0f 87 82 00 00 00    	ja     6fe0 <fwp_apply+0x1a0>
    6f5e:	66 90                	xchg   %ax,%ax
    6f60:	4b 8b 54 d7 08       	mov    0x8(%r15,%r10,8),%rdx
    6f65:	4a 89 14 d7          	mov    %rdx,(%rdi,%r10,8)
    6f69:	4b 8b 54 d7 10       	mov    0x10(%r15,%r10,8),%rdx
    6f6e:	4a 89 54 d7 08       	mov    %rdx,0x8(%rdi,%r10,8)
    6f73:	4b 8b 54 d7 18       	mov    0x18(%r15,%r10,8),%rdx
    6f78:	4a 89 54 d7 10       	mov    %rdx,0x10(%rdi,%r10,8)
    6f7d:	4b 8b 54 d7 20       	mov    0x20(%r15,%r10,8),%rdx
    6f82:	4a 89 54 d7 18       	mov    %rdx,0x18(%rdi,%r10,8)
    6f87:	49 83 c2 04          	add    $0x4,%r10
    6f8b:	4d 39 d5             	cmp    %r10,%r13
    6f8e:	75 d0                	jne    6f60 <fwp_apply+0x120>
    6f90:	eb 4e                	jmp    6fe0 <fwp_apply+0x1a0>
    6f92:	44 89 ea             	mov    %r13d,%edx
    6f95:	83 e2 fc             	and    $0xfffffffc,%edx
    6f98:	4e 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%r9
    6f9f:	00 
    6fa0:	49 83 e1 e0          	and    $0xffffffffffffffe0,%r9
    6fa4:	45 31 c0             	xor    %r8d,%r8d
    6fa7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    6fae:	00 00 
    6fb0:	43 0f 10 44 07 08    	movups 0x8(%r15,%r8,1),%xmm0
    6fb6:	43 0f 10 4c 07 18    	movups 0x18(%r15,%r8,1),%xmm1
    6fbc:	42 0f 29 04 07       	movaps %xmm0,(%rdi,%r8,1)
    6fc1:	42 0f 29 4c 07 10    	movaps %xmm1,0x10(%rdi,%r8,1)
    6fc7:	49 83 c0 20          	add    $0x20,%r8
    6fcb:	4d 39 c1             	cmp    %r8,%r9
    6fce:	75 e0                	jne    6fb0 <fwp_apply+0x170>
    6fd0:	4c 39 ea             	cmp    %r13,%rdx
    6fd3:	0f 85 56 ff ff ff    	jne    6f2f <fwp_apply+0xef>
    6fd9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    6fe0:	45 29 eb             	sub    %r13d,%r11d
    6fe3:	45 89 de             	mov    %r11d,%r14d
    6fe6:	45 39 ec             	cmp    %r13d,%r12d
    6fe9:	0f 84 85 00 00 00    	je     7074 <fwp_apply+0x234>
    6fef:	41 83 fb 0e          	cmp    $0xe,%r11d
    6ff3:	0f 83 a0 00 00 00    	jae    7099 <fwp_apply+0x259>
    6ff9:	31 d2                	xor    %edx,%edx
    6ffb:	4d 89 f0             	mov    %r14,%r8
    6ffe:	48 89 d6             	mov    %rdx,%rsi
    7001:	49 83 e0 03          	and    $0x3,%r8
    7005:	74 1d                	je     7024 <fwp_apply+0x1e4>
    7007:	48 89 d6             	mov    %rdx,%rsi
    700a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    7010:	4c 8b 0c f3          	mov    (%rbx,%rsi,8),%r9
    7014:	46 8d 14 2e          	lea    (%rsi,%r13,1),%r10d
    7018:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    701c:	48 ff c6             	inc    %rsi
    701f:	49 ff c8             	dec    %r8
    7022:	75 ec                	jne    7010 <fwp_apply+0x1d0>
    7024:	4c 29 f2             	sub    %r14,%rdx
    7027:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    702b:	77 47                	ja     7074 <fwp_apply+0x234>
    702d:	0f 1f 00             	nopl   (%rax)
    7030:	48 8b 14 f3          	mov    (%rbx,%rsi,8),%rdx
    7034:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    7038:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    703c:	48 8b 54 f3 08       	mov    0x8(%rbx,%rsi,8),%rdx
    7041:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    7045:	41 ff c0             	inc    %r8d
    7048:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    704c:	48 8b 54 f3 10       	mov    0x10(%rbx,%rsi,8),%rdx
    7051:	45 8d 44 35 02       	lea    0x2(%r13,%rsi,1),%r8d
    7056:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    705a:	48 8b 54 f3 18       	mov    0x18(%rbx,%rsi,8),%rdx
    705f:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    7063:	41 83 c0 03          	add    $0x3,%r8d
    7067:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    706b:	48 83 c6 04          	add    $0x4,%rsi
    706f:	49 39 f6             	cmp    %rsi,%r14
    7072:	75 bc                	jne    7030 <fwp_apply+0x1f0>
    7074:	45 89 dc             	mov    %r11d,%r12d
    7077:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    707b:	b9 01 00 00 00       	mov    $0x1,%ecx
    7080:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    7084:	89 f2                	mov    %esi,%edx
    7086:	44 29 e2             	sub    %r12d,%edx
    7089:	0f 85 d1 fd ff ff    	jne    6e60 <fwp_apply+0x20>
    708f:	89 f2                	mov    %esi,%edx
    7091:	49 89 c6             	mov    %rax,%r14
    7094:	e9 d4 fd ff ff       	jmp    6e6d <fwp_apply+0x2d>
    7099:	49 8d 56 ff          	lea    -0x1(%r14),%rdx
    709d:	89 d6                	mov    %edx,%esi
    709f:	44 01 ee             	add    %r13d,%esi
    70a2:	0f 82 51 ff ff ff    	jb     6ff9 <fwp_apply+0x1b9>
    70a8:	48 c1 ea 20          	shr    $0x20,%rdx
    70ac:	ba 00 00 00 00       	mov    $0x0,%edx
    70b1:	0f 85 44 ff ff ff    	jne    6ffb <fwp_apply+0x1bb>
    70b7:	4a 8d 14 ef          	lea    (%rdi,%r13,8),%rdx
    70bb:	48 29 da             	sub    %rbx,%rdx
    70be:	48 83 fa 20          	cmp    $0x20,%rdx
    70c2:	0f 82 31 ff ff ff    	jb     6ff9 <fwp_apply+0x1b9>
    70c8:	44 89 f2             	mov    %r14d,%edx
    70cb:	83 e2 fc             	and    $0xfffffffc,%edx
    70ce:	31 f6                	xor    %esi,%esi
    70d0:	0f 10 04 f3          	movups (%rbx,%rsi,8),%xmm0
    70d4:	0f 10 4c f3 10       	movups 0x10(%rbx,%rsi,8),%xmm1
    70d9:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    70dd:	42 0f 11 04 c7       	movups %xmm0,(%rdi,%r8,8)
    70e2:	42 0f 11 4c c7 10    	movups %xmm1,0x10(%rdi,%r8,8)
    70e8:	48 83 c6 04          	add    $0x4,%rsi
    70ec:	48 39 f2             	cmp    %rsi,%rdx
    70ef:	75 df                	jne    70d0 <fwp_apply+0x290>
    70f1:	4c 39 f2             	cmp    %r14,%rdx
    70f4:	0f 85 01 ff ff ff    	jne    6ffb <fwp_apply+0x1bb>
    70fa:	e9 75 ff ff ff       	jmp    7074 <fwp_apply+0x234>
    70ff:	44 89 f1             	mov    %r14d,%ecx
    7102:	48 8d 3c cd 08 00 00 	lea    0x8(,%rcx,8),%rdi
    7109:	00 
    710a:	48 ff 05 17 3c 01 00 	incq   0x13c17(%rip)        # 1ad28 <measured_calls>
    7111:	48 01 3d 18 3c 01 00 	add    %rdi,0x13c18(%rip)        # 1ad30 <measured_bytes>
    7118:	41 81 fe ff 07 00 00 	cmp    $0x7ff,%r14d
    711f:	77 6e                	ja     718f <fwp_apply+0x34f>
    7121:	48 c1 e1 03          	shl    $0x3,%rcx
    7125:	48 83 c1 17          	add    $0x17,%rcx
    7129:	48 c1 e9 04          	shr    $0x4,%rcx
    712d:	48 8d 05 54 21 01 00 	lea    0x12154(%rip),%rax        # 19288 <fwp_gc>
    7134:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    713b:	00 
    713c:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    7143:	48 29 15 3e 21 01 00 	sub    %rdx,0x1213e(%rip)        # 19288 <fwp_gc>
    714a:	78 43                	js     718f <fwp_apply+0x34f>
    714c:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    7150:	4c 8d 04 c8          	lea    (%rax,%rcx,8),%r8
    7154:	49 81 c0 88 07 00 00 	add    $0x788,%r8
    715b:	4d 8b 20             	mov    (%r8),%r12
    715e:	4d 85 e4             	test   %r12,%r12
    7161:	74 14                	je     7177 <fwp_apply+0x337>
    7163:	49 8b 04 24          	mov    (%r12),%rax
    7167:	48 f7 d0             	not    %rax
    716a:	49 89 00             	mov    %rax,(%r8)
    716d:	eb 40                	jmp    71af <fwp_apply+0x36f>
    716f:	4d 89 fe             	mov    %r15,%r14
    7172:	e9 af 01 00 00       	jmp    7326 <fwp_apply+0x4e6>
    7177:	4c 8b a4 c8 90 07 00 	mov    0x790(%rax,%rcx,8),%r12
    717e:	00 
    717f:	4c 8b 84 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%r8
    7186:	00 
    7187:	4d 29 e0             	sub    %r12,%r8
    718a:	49 39 d0             	cmp    %rdx,%r8
    718d:	73 0f                	jae    719e <fwp_apply+0x35e>
    718f:	be 02 00 00 00       	mov    $0x2,%esi
    7194:	e8 87 0b 00 00       	call   7d20 <fwp_gc_alloc_slow>
    7199:	49 89 c4             	mov    %rax,%r12
    719c:	eb 1b                	jmp    71b9 <fwp_apply+0x379>
    719e:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    71a2:	48 05 90 07 00 00    	add    $0x790,%rax
    71a8:	49 8d 0c 14          	lea    (%r12,%rdx,1),%rcx
    71ac:	48 89 08             	mov    %rcx,(%rax)
    71af:	4c 89 e7             	mov    %r12,%rdi
    71b2:	31 f6                	xor    %esi,%esi
    71b4:	e8 57 c0 ff ff       	call   3210 <memset@plt>
    71b9:	41 8b 07             	mov    (%r15),%eax
    71bc:	41 89 04 24          	mov    %eax,(%r12)
    71c0:	45 89 74 24 04       	mov    %r14d,0x4(%r12)
    71c5:	4d 85 ed             	test   %r13,%r13
    71c8:	4d 89 e6             	mov    %r12,%r14
    71cb:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    71cf:	0f 84 bc 00 00 00    	je     7291 <fwp_apply+0x451>
    71d5:	31 c0                	xor    %eax,%eax
    71d7:	41 83 fd 06          	cmp    $0x6,%r13d
    71db:	72 49                	jb     7226 <fwp_apply+0x3e6>
    71dd:	4c 89 f1             	mov    %r14,%rcx
    71e0:	4c 29 f9             	sub    %r15,%rcx
    71e3:	48 83 f9 20          	cmp    $0x20,%rcx
    71e7:	72 3d                	jb     7226 <fwp_apply+0x3e6>
    71e9:	44 89 e8             	mov    %r13d,%eax
    71ec:	83 e0 fc             	and    $0xfffffffc,%eax
    71ef:	4a 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%rcx
    71f6:	00 
    71f7:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    71fb:	31 d2                	xor    %edx,%edx
    71fd:	0f 1f 00             	nopl   (%rax)
    7200:	41 0f 10 44 17 08    	movups 0x8(%r15,%rdx,1),%xmm0
    7206:	41 0f 10 4c 17 18    	movups 0x18(%r15,%rdx,1),%xmm1
    720c:	41 0f 11 44 16 08    	movups %xmm0,0x8(%r14,%rdx,1)
    7212:	41 0f 11 4c 16 18    	movups %xmm1,0x18(%r14,%rdx,1)
    7218:	48 83 c2 20          	add    $0x20,%rdx
    721c:	48 39 d1             	cmp    %rdx,%rcx
    721f:	75 df                	jne    7200 <fwp_apply+0x3c0>
    7221:	4c 39 e8             	cmp    %r13,%rax
    7224:	74 6b                	je     7291 <fwp_apply+0x451>
    7226:	4c 89 ea             	mov    %r13,%rdx
    7229:	48 89 c1             	mov    %rax,%rcx
    722c:	48 83 e2 03          	and    $0x3,%rdx
    7230:	74 20                	je     7252 <fwp_apply+0x412>
    7232:	48 89 c1             	mov    %rax,%rcx
    7235:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    723c:	00 00 00 00 
    7240:	49 8b 74 cf 08       	mov    0x8(%r15,%rcx,8),%rsi
    7245:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    724a:	48 ff c1             	inc    %rcx
    724d:	48 ff ca             	dec    %rdx
    7250:	75 ee                	jne    7240 <fwp_apply+0x400>
    7252:	4c 29 e8             	sub    %r13,%rax
    7255:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    7259:	77 36                	ja     7291 <fwp_apply+0x451>
    725b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7260:	49 8b 44 cf 08       	mov    0x8(%r15,%rcx,8),%rax
    7265:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    726a:	49 8b 44 cf 10       	mov    0x10(%r15,%rcx,8),%rax
    726f:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    7274:	49 8b 44 cf 18       	mov    0x18(%r15,%rcx,8),%rax
    7279:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    727e:	49 8b 44 cf 20       	mov    0x20(%r15,%rcx,8),%rax
    7283:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    7288:	48 83 c1 04          	add    $0x4,%rcx
    728c:	49 39 cd             	cmp    %rcx,%r13
    728f:	75 cf                	jne    7260 <fwp_apply+0x420>
    7291:	85 ff                	test   %edi,%edi
    7293:	0f 84 8d 00 00 00    	je     7326 <fwp_apply+0x4e6>
    7299:	89 f8                	mov    %edi,%eax
    729b:	83 ff 14             	cmp    $0x14,%edi
    729e:	0f 83 94 00 00 00    	jae    7338 <fwp_apply+0x4f8>
    72a4:	31 c9                	xor    %ecx,%ecx
    72a6:	48 89 c6             	mov    %rax,%rsi
    72a9:	48 89 ca             	mov    %rcx,%rdx
    72ac:	48 83 e6 03          	and    $0x3,%rsi
    72b0:	74 23                	je     72d5 <fwp_apply+0x495>
    72b2:	48 89 ca             	mov    %rcx,%rdx
    72b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    72bc:	00 00 00 00 
    72c0:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    72c4:	46 8d 04 2a          	lea    (%rdx,%r13,1),%r8d
    72c8:	4b 89 7c c6 08       	mov    %rdi,0x8(%r14,%r8,8)
    72cd:	48 ff c2             	inc    %rdx
    72d0:	48 ff ce             	dec    %rsi
    72d3:	75 eb                	jne    72c0 <fwp_apply+0x480>
    72d5:	48 29 c1             	sub    %rax,%rcx
    72d8:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    72dc:	77 48                	ja     7326 <fwp_apply+0x4e6>
    72de:	66 90                	xchg   %ax,%ax
    72e0:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    72e4:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    72e8:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    72ed:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    72f2:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    72f6:	ff c6                	inc    %esi
    72f8:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    72fd:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    7302:	41 8d 74 15 02       	lea    0x2(%r13,%rdx,1),%esi
    7307:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    730c:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    7311:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    7315:	83 c6 03             	add    $0x3,%esi
    7318:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    731d:	48 83 c2 04          	add    $0x4,%rdx
    7321:	48 39 d0             	cmp    %rdx,%rax
    7324:	75 ba                	jne    72e0 <fwp_apply+0x4a0>
    7326:	4c 89 f0             	mov    %r14,%rax
    7329:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    732d:	5b                   	pop    %rbx
    732e:	41 5c                	pop    %r12
    7330:	41 5d                	pop    %r13
    7332:	41 5e                	pop    %r14
    7334:	41 5f                	pop    %r15
    7336:	5d                   	pop    %rbp
    7337:	c3                   	ret
    7338:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    733c:	31 c9                	xor    %ecx,%ecx
    733e:	89 d6                	mov    %edx,%esi
    7340:	44 01 ee             	add    %r13d,%esi
    7343:	0f 82 5d ff ff ff    	jb     72a6 <fwp_apply+0x466>
    7349:	48 c1 ea 20          	shr    $0x20,%rdx
    734d:	0f 85 53 ff ff ff    	jne    72a6 <fwp_apply+0x466>
    7353:	4b 8d 0c ee          	lea    (%r14,%r13,8),%rcx
    7357:	48 29 d9             	sub    %rbx,%rcx
    735a:	48 83 c1 08          	add    $0x8,%rcx
    735e:	48 83 f9 20          	cmp    $0x20,%rcx
    7362:	0f 82 3c ff ff ff    	jb     72a4 <fwp_apply+0x464>
    7368:	89 c1                	mov    %eax,%ecx
    736a:	83 e1 fc             	and    $0xfffffffc,%ecx
    736d:	31 d2                	xor    %edx,%edx
    736f:	90                   	nop
    7370:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    7374:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    7379:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    737d:	41 0f 11 44 f6 08    	movups %xmm0,0x8(%r14,%rsi,8)
    7383:	41 0f 11 4c f6 18    	movups %xmm1,0x18(%r14,%rsi,8)
    7389:	48 83 c2 04          	add    $0x4,%rdx
    738d:	48 39 d1             	cmp    %rdx,%rcx
    7390:	75 de                	jne    7370 <fwp_apply+0x530>
    7392:	48 39 c1             	cmp    %rax,%rcx
    7395:	0f 85 0b ff ff ff    	jne    72a6 <fwp_apply+0x466>
    739b:	eb 89                	jmp    7326 <fwp_apply+0x4e6>
    739d:	0f 1f 00             	nopl   (%rax)

00000000000073a0 <fwp_apply_release>:
    73a0:	41 56                	push   %r14
    73a2:	53                   	push   %rbx
    73a3:	50                   	push   %rax
    73a4:	48 8b 1f             	mov    (%rdi),%rbx
    73a7:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    73ae:	8b 47 20             	mov    0x20(%rdi),%eax
    73b1:	8b 4f 18             	mov    0x18(%rdi),%ecx
    73b4:	89 c2                	mov    %eax,%edx
    73b6:	29 ca                	sub    %ecx,%edx
    73b8:	74 2d                	je     73e7 <fwp_apply_release+0x47>
    73ba:	48 8b 77 10          	mov    0x10(%rdi),%rsi
    73be:	4c 8b 46 18          	mov    0x18(%rsi),%r8
    73c2:	4d 85 c0             	test   %r8,%r8
    73c5:	74 20                	je     73e7 <fwp_apply_release+0x47>
    73c7:	48 89 c8             	mov    %rcx,%rax
    73ca:	48 c1 e0 03          	shl    $0x3,%rax
    73ce:	48 03 47 08          	add    0x8(%rdi),%rax
    73d2:	8b 77 1c             	mov    0x1c(%rdi),%esi
    73d5:	01 ce                	add    %ecx,%esi
    73d7:	49 89 fe             	mov    %rdi,%r14
    73da:	48 89 c7             	mov    %rax,%rdi
    73dd:	41 ff d0             	call   *%r8
    73e0:	4c 89 f7             	mov    %r14,%rdi
    73e3:	41 8b 46 20          	mov    0x20(%r14),%eax
    73e7:	89 47 18             	mov    %eax,0x18(%rdi)
    73ea:	48 85 db             	test   %rbx,%rbx
    73ed:	74 0f                	je     73fe <fwp_apply_release+0x5e>
    73ef:	48 89 df             	mov    %rbx,%rdi
    73f2:	48 83 c4 08          	add    $0x8,%rsp
    73f6:	5b                   	pop    %rbx
    73f7:	41 5e                	pop    %r14
    73f9:	e9 42 29 00 00       	jmp    9d40 <fwp_closure_drop>
    73fe:	48 83 c4 08          	add    $0x8,%rsp
    7402:	5b                   	pop    %rbx
    7403:	41 5e                	pop    %r14
    7405:	c3                   	ret
    7406:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    740d:	00 00 00 

0000000000007410 <fwp_apply_owned>:
    7410:	55                   	push   %rbp
    7411:	48 89 e5             	mov    %rsp,%rbp
    7414:	41 57                	push   %r15
    7416:	41 56                	push   %r14
    7418:	41 55                	push   %r13
    741a:	41 54                	push   %r12
    741c:	53                   	push   %rbx
    741d:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    7424:	48 89 d3             	mov    %rdx,%rbx
    7427:	41 89 f5             	mov    %esi,%r13d
    742a:	48 8b 05 bf 38 01 00 	mov    0x138bf(%rip),%rax        # 1acf0 <fwp_fns>
    7431:	8b 17                	mov    (%rdi),%edx
    7433:	48 89 d6             	mov    %rdx,%rsi
    7436:	48 c1 e6 05          	shl    $0x5,%rsi
    743a:	48 8b 4c 30 18       	mov    0x18(%rax,%rsi,1),%rcx
    743f:	48 85 c9             	test   %rcx,%rcx
    7442:	0f 84 fa 03 00 00    	je     7842 <fwp_apply_owned+0x432>
    7448:	4c 8d 14 30          	lea    (%rax,%rsi,1),%r10
    744c:	49 83 c2 18          	add    $0x18,%r10
    7450:	49 89 fc             	mov    %rdi,%r12
    7453:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    745a:	84 00 00 00 00 00 
    7460:	48 c1 e2 05          	shl    $0x5,%rdx
    7464:	8b 04 10             	mov    (%rax,%rdx,1),%eax
    7467:	45 8b 7c 24 04       	mov    0x4(%r12),%r15d
    746c:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
    7473:	48 89 9d 70 ff ff ff 	mov    %rbx,-0x90(%rbp)
    747a:	48 89 8d 78 ff ff ff 	mov    %rcx,-0x88(%rbp)
    7481:	c7 45 80 00 00 00 00 	movl   $0x0,-0x80(%rbp)
    7488:	44 89 7d 84          	mov    %r15d,-0x7c(%rbp)
    748c:	48 89 fa             	mov    %rdi,%rdx
    748f:	48 2b 15 22 2e 01 00 	sub    0x12e22(%rip),%rdx        # 1a2b8 <fwp_gc+0x1030>
    7496:	44 89 6d 88          	mov    %r13d,-0x78(%rbp)
    749a:	48 8b 35 3f 2e 01 00 	mov    0x12e3f(%rip),%rsi        # 1a2e0 <fwp_gc+0x1058>
    74a1:	48 c1 e6 10          	shl    $0x10,%rsi
    74a5:	48 39 f2             	cmp    %rsi,%rdx
    74a8:	73 76                	jae    7520 <fwp_apply_owned+0x110>
    74aa:	48 8b 35 4f 2e 01 00 	mov    0x12e4f(%rip),%rsi        # 1a300 <fwp_gc+0x1078>
    74b1:	49 89 d0             	mov    %rdx,%r8
    74b4:	49 c1 e8 10          	shr    $0x10,%r8
    74b8:	4d 69 c8 28 12 00 00 	imul   $0x1228,%r8,%r9
    74bf:	46 0f b6 04 0e       	movzbl (%rsi,%r9,1),%r8d
    74c4:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    74cb:	75 23                	jne    74f0 <fwp_apply_owned+0xe0>
    74cd:	41 80 f8 02          	cmp    $0x2,%r8b
    74d1:	75 1d                	jne    74f0 <fwp_apply_owned+0xe0>
    74d3:	4a 8d 14 0e          	lea    (%rsi,%r9,1),%rdx
    74d7:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    74de:	80 3a 00             	cmpb   $0x0,(%rdx)
    74e1:	75 52                	jne    7535 <fwp_apply_owned+0x125>
    74e3:	eb 3b                	jmp    7520 <fwp_apply_owned+0x110>
    74e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    74ec:	00 00 00 00 
    74f0:	41 80 f8 01          	cmp    $0x1,%r8b
    74f4:	75 2a                	jne    7520 <fwp_apply_owned+0x110>
    74f6:	4e 8d 04 0e          	lea    (%rsi,%r9,1),%r8
    74fa:	42 8b 74 0e 20       	mov    0x20(%rsi,%r9,1),%esi
    74ff:	48 0f af d6          	imul   %rsi,%rdx
    7503:	48 c1 ea 20          	shr    $0x20,%rdx
    7507:	4c 01 c2             	add    %r8,%rdx
    750a:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    7511:	80 3a 00             	cmpb   $0x0,(%rdx)
    7514:	75 1f                	jne    7535 <fwp_apply_owned+0x125>
    7516:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    751d:	00 00 00 
    7520:	48 83 79 18 00       	cmpq   $0x0,0x18(%rcx)
    7525:	74 49                	je     7570 <fwp_apply_owned+0x160>
    7527:	4d 85 ff             	test   %r15,%r15
    752a:	75 09                	jne    7535 <fwp_apply_owned+0x125>
    752c:	31 d2                	xor    %edx,%edx
    752e:	41 39 c5             	cmp    %eax,%r13d
    7531:	72 02                	jb     7535 <fwp_apply_owned+0x125>
    7533:	76 3d                	jbe    7572 <fwp_apply_owned+0x162>
    7535:	48 ff 05 04 38 01 00 	incq   0x13804(%rip)        # 1ad40 <measured_scopes>
    753c:	48 8b 15 05 38 01 00 	mov    0x13805(%rip),%rdx        # 1ad48 <fwp_cleanups>
    7543:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
    7547:	48 8d 15 52 fe ff ff 	lea    -0x1ae(%rip),%rdx        # 73a0 <fwp_apply_release>
    754e:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
    7552:	48 8d 95 68 ff ff ff 	lea    -0x98(%rbp),%rdx
    7559:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
    755d:	48 8d 55 98          	lea    -0x68(%rbp),%rdx
    7561:	48 89 15 e0 37 01 00 	mov    %rdx,0x137e0(%rip)        # 1ad48 <fwp_cleanups>
    7568:	b2 01                	mov    $0x1,%dl
    756a:	eb 06                	jmp    7572 <fwp_apply_owned+0x162>
    756c:	0f 1f 40 00          	nopl   0x0(%rax)
    7570:	31 d2                	xor    %edx,%edx
    7572:	47 8d 34 2f          	lea    (%r15,%r13,1),%r14d
    7576:	41 39 c6             	cmp    %eax,%r14d
    7579:	89 55 cc             	mov    %edx,-0x34(%rbp)
    757c:	0f 82 05 03 00 00    	jb     7887 <fwp_apply_owned+0x477>
    7582:	41 89 c6             	mov    %eax,%r14d
    7585:	45 29 fe             	sub    %r15d,%r14d
    7588:	45 89 f1             	mov    %r14d,%r9d
    758b:	4d 85 ff             	test   %r15,%r15
    758e:	4c 89 4d c0          	mov    %r9,-0x40(%rbp)
    7592:	44 89 75 b8          	mov    %r14d,-0x48(%rbp)
    7596:	75 18                	jne    75b0 <fwp_apply_owned+0x1a0>
    7598:	85 c0                	test   %eax,%eax
    759a:	74 14                	je     75b0 <fwp_apply_owned+0x1a0>
    759c:	49 89 ff             	mov    %rdi,%r15
    759f:	44 89 75 80          	mov    %r14d,-0x80(%rbp)
    75a3:	48 89 df             	mov    %rbx,%rdi
    75a6:	ff 11                	call   *(%rcx)
    75a8:	49 89 c4             	mov    %rax,%r12
    75ab:	e9 29 02 00 00       	jmp    77d9 <fwp_apply_owned+0x3c9>
    75b0:	4c 89 6d d0          	mov    %r13,-0x30(%rbp)
    75b4:	48 89 65 90          	mov    %rsp,-0x70(%rbp)
    75b8:	85 c0                	test   %eax,%eax
    75ba:	b9 01 00 00 00       	mov    $0x1,%ecx
    75bf:	0f 45 c8             	cmovne %eax,%ecx
    75c2:	48 8d 0c cd 0f 00 00 	lea    0xf(,%rcx,8),%rcx
    75c9:	00 
    75ca:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
    75ce:	49 89 e5             	mov    %rsp,%r13
    75d1:	49 29 cd             	sub    %rcx,%r13
    75d4:	4c 89 ec             	mov    %r13,%rsp
    75d7:	4d 85 ff             	test   %r15,%r15
    75da:	0f 84 d0 00 00 00    	je     76b0 <fwp_apply_owned+0x2a0>
    75e0:	41 83 ff 04          	cmp    $0x4,%r15d
    75e4:	72 10                	jb     75f6 <fwp_apply_owned+0x1e6>
    75e6:	4c 89 e9             	mov    %r13,%rcx
    75e9:	4c 29 e1             	sub    %r12,%rcx
    75ec:	48 83 c1 f8          	add    $0xfffffffffffffff8,%rcx
    75f0:	48 83 f9 20          	cmp    $0x20,%rcx
    75f4:	73 6d                	jae    7663 <fwp_apply_owned+0x253>
    75f6:	31 c9                	xor    %ecx,%ecx
    75f8:	4c 89 fe             	mov    %r15,%rsi
    75fb:	48 89 ca             	mov    %rcx,%rdx
    75fe:	48 83 e6 03          	and    $0x3,%rsi
    7602:	74 1e                	je     7622 <fwp_apply_owned+0x212>
    7604:	48 89 ca             	mov    %rcx,%rdx
    7607:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    760e:	00 00 
    7610:	4d 8b 44 d4 08       	mov    0x8(%r12,%rdx,8),%r8
    7615:	4d 89 44 d5 00       	mov    %r8,0x0(%r13,%rdx,8)
    761a:	48 ff c2             	inc    %rdx
    761d:	48 ff ce             	dec    %rsi
    7620:	75 ee                	jne    7610 <fwp_apply_owned+0x200>
    7622:	4c 29 f9             	sub    %r15,%rcx
    7625:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    7629:	0f 87 81 00 00 00    	ja     76b0 <fwp_apply_owned+0x2a0>
    762f:	90                   	nop
    7630:	49 8b 4c d4 08       	mov    0x8(%r12,%rdx,8),%rcx
    7635:	49 89 4c d5 00       	mov    %rcx,0x0(%r13,%rdx,8)
    763a:	49 8b 4c d4 10       	mov    0x10(%r12,%rdx,8),%rcx
    763f:	49 89 4c d5 08       	mov    %rcx,0x8(%r13,%rdx,8)
    7644:	49 8b 4c d4 18       	mov    0x18(%r12,%rdx,8),%rcx
    7649:	49 89 4c d5 10       	mov    %rcx,0x10(%r13,%rdx,8)
    764e:	49 8b 4c d4 20       	mov    0x20(%r12,%rdx,8),%rcx
    7653:	49 89 4c d5 18       	mov    %rcx,0x18(%r13,%rdx,8)
    7658:	48 83 c2 04          	add    $0x4,%rdx
    765c:	49 39 d7             	cmp    %rdx,%r15
    765f:	75 cf                	jne    7630 <fwp_apply_owned+0x220>
    7661:	eb 4d                	jmp    76b0 <fwp_apply_owned+0x2a0>
    7663:	44 89 f9             	mov    %r15d,%ecx
    7666:	83 e1 fc             	and    $0xfffffffc,%ecx
    7669:	4a 8d 14 fd 00 00 00 	lea    0x0(,%r15,8),%rdx
    7670:	00 
    7671:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    7675:	31 f6                	xor    %esi,%esi
    7677:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    767e:	00 00 
    7680:	41 0f 10 44 34 08    	movups 0x8(%r12,%rsi,1),%xmm0
    7686:	41 0f 10 4c 34 18    	movups 0x18(%r12,%rsi,1),%xmm1
    768c:	41 0f 29 44 35 00    	movaps %xmm0,0x0(%r13,%rsi,1)
    7692:	41 0f 29 4c 35 10    	movaps %xmm1,0x10(%r13,%rsi,1)
    7698:	48 83 c6 20          	add    $0x20,%rsi
    769c:	48 39 f2             	cmp    %rsi,%rdx
    769f:	75 df                	jne    7680 <fwp_apply_owned+0x270>
    76a1:	4c 39 f9             	cmp    %r15,%rcx
    76a4:	0f 85 4e ff ff ff    	jne    75f8 <fwp_apply_owned+0x1e8>
    76aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    76b0:	44 39 f8             	cmp    %r15d,%eax
    76b3:	0f 84 f7 00 00 00    	je     77b0 <fwp_apply_owned+0x3a0>
    76b9:	41 83 fe 0a          	cmp    $0xa,%r14d
    76bd:	0f 83 95 00 00 00    	jae    7758 <fwp_apply_owned+0x348>
    76c3:	31 c0                	xor    %eax,%eax
    76c5:	4c 89 ca             	mov    %r9,%rdx
    76c8:	48 89 c1             	mov    %rax,%rcx
    76cb:	48 83 e2 03          	and    $0x3,%rdx
    76cf:	74 24                	je     76f5 <fwp_apply_owned+0x2e5>
    76d1:	48 89 c1             	mov    %rax,%rcx
    76d4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    76db:	00 00 00 00 00 
    76e0:	48 8b 34 cb          	mov    (%rbx,%rcx,8),%rsi
    76e4:	45 8d 04 0f          	lea    (%r15,%rcx,1),%r8d
    76e8:	4b 89 74 c5 00       	mov    %rsi,0x0(%r13,%r8,8)
    76ed:	48 ff c1             	inc    %rcx
    76f0:	48 ff ca             	dec    %rdx
    76f3:	75 eb                	jne    76e0 <fwp_apply_owned+0x2d0>
    76f5:	4c 29 c8             	sub    %r9,%rax
    76f8:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    76fc:	0f 87 ae 00 00 00    	ja     77b0 <fwp_apply_owned+0x3a0>
    7702:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7709:	1f 84 00 00 00 00 00 
    7710:	48 8b 04 cb          	mov    (%rbx,%rcx,8),%rax
    7714:	41 8d 14 0f          	lea    (%r15,%rcx,1),%edx
    7718:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    771d:	48 8b 44 cb 08       	mov    0x8(%rbx,%rcx,8),%rax
    7722:	41 8d 14 0f          	lea    (%r15,%rcx,1),%edx
    7726:	ff c2                	inc    %edx
    7728:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    772d:	48 8b 44 cb 10       	mov    0x10(%rbx,%rcx,8),%rax
    7732:	41 8d 54 0f 02       	lea    0x2(%r15,%rcx,1),%edx
    7737:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    773c:	48 8b 44 cb 18       	mov    0x18(%rbx,%rcx,8),%rax
    7741:	41 8d 14 0f          	lea    (%r15,%rcx,1),%edx
    7745:	83 c2 03             	add    $0x3,%edx
    7748:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    774d:	48 83 c1 04          	add    $0x4,%rcx
    7751:	49 39 c9             	cmp    %rcx,%r9
    7754:	75 ba                	jne    7710 <fwp_apply_owned+0x300>
    7756:	eb 58                	jmp    77b0 <fwp_apply_owned+0x3a0>
    7758:	49 8d 41 ff          	lea    -0x1(%r9),%rax
    775c:	89 c1                	mov    %eax,%ecx
    775e:	44 01 f9             	add    %r15d,%ecx
    7761:	0f 82 5c ff ff ff    	jb     76c3 <fwp_apply_owned+0x2b3>
    7767:	48 c1 e8 20          	shr    $0x20,%rax
    776b:	b8 00 00 00 00       	mov    $0x0,%eax
    7770:	0f 85 4f ff ff ff    	jne    76c5 <fwp_apply_owned+0x2b5>
    7776:	44 89 c8             	mov    %r9d,%eax
    7779:	83 e0 fc             	and    $0xfffffffc,%eax
    777c:	31 c9                	xor    %ecx,%ecx
    777e:	66 90                	xchg   %ax,%ax
    7780:	0f 10 04 cb          	movups (%rbx,%rcx,8),%xmm0
    7784:	0f 10 4c cb 10       	movups 0x10(%rbx,%rcx,8),%xmm1
    7789:	41 8d 14 0f          	lea    (%r15,%rcx,1),%edx
    778d:	41 0f 11 44 d5 00    	movups %xmm0,0x0(%r13,%rdx,8)
    7793:	41 0f 11 4c d5 10    	movups %xmm1,0x10(%r13,%rdx,8)
    7799:	48 83 c1 04          	add    $0x4,%rcx
    779d:	48 39 c8             	cmp    %rcx,%rax
    77a0:	75 de                	jne    7780 <fwp_apply_owned+0x370>
    77a2:	4c 39 c8             	cmp    %r9,%rax
    77a5:	0f 85 1a ff ff ff    	jne    76c5 <fwp_apply_owned+0x2b5>
    77ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    77b0:	49 8b 02             	mov    (%r10),%rax
    77b3:	49 89 ff             	mov    %rdi,%r15
    77b6:	be 01 00 00 00       	mov    $0x1,%esi
    77bb:	4d 89 d4             	mov    %r10,%r12
    77be:	ff 50 08             	call   *0x8(%rax)
    77c1:	44 89 75 80          	mov    %r14d,-0x80(%rbp)
    77c5:	49 8b 04 24          	mov    (%r12),%rax
    77c9:	4c 89 ef             	mov    %r13,%rdi
    77cc:	ff 10                	call   *(%rax)
    77ce:	49 89 c4             	mov    %rax,%r12
    77d1:	48 8b 65 90          	mov    -0x70(%rbp),%rsp
    77d5:	4c 8b 6d d0          	mov    -0x30(%rbp),%r13
    77d9:	80 7d cc 00          	cmpb   $0x0,-0x34(%rbp)
    77dd:	4c 89 ff             	mov    %r15,%rdi
    77e0:	74 1c                	je     77fe <fwp_apply_owned+0x3ee>
    77e2:	48 8d 45 98          	lea    -0x68(%rbp),%rax
    77e6:	48 39 05 5b 35 01 00 	cmp    %rax,0x1355b(%rip)        # 1ad48 <fwp_cleanups>
    77ed:	0f 85 74 04 00 00    	jne    7c67 <fwp_apply_owned+0x857>
    77f3:	48 8b 45 98          	mov    -0x68(%rbp),%rax
    77f7:	48 89 05 4a 35 01 00 	mov    %rax,0x1354a(%rip)        # 1ad48 <fwp_cleanups>
    77fe:	e8 3d 25 00 00       	call   9d40 <fwp_closure_drop>
    7803:	44 2b 6d b8          	sub    -0x48(%rbp),%r13d
    7807:	0f 84 48 04 00 00    	je     7c55 <fwp_apply_owned+0x845>
    780d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
    7811:	48 8d 1c c3          	lea    (%rbx,%rax,8),%rbx
    7815:	48 8b 05 d4 34 01 00 	mov    0x134d4(%rip),%rax        # 1acf0 <fwp_fns>
    781c:	41 8b 14 24          	mov    (%r12),%edx
    7820:	48 89 d1             	mov    %rdx,%rcx
    7823:	48 c1 e1 05          	shl    $0x5,%rcx
    7827:	4c 8d 14 08          	lea    (%rax,%rcx,1),%r10
    782b:	49 83 c2 18          	add    $0x18,%r10
    782f:	48 8b 4c 08 18       	mov    0x18(%rax,%rcx,1),%rcx
    7834:	4c 89 e7             	mov    %r12,%rdi
    7837:	48 85 c9             	test   %rcx,%rcx
    783a:	0f 85 20 fc ff ff    	jne    7460 <fwp_apply_owned+0x50>
    7840:	eb 03                	jmp    7845 <fwp_apply_owned+0x435>
    7842:	49 89 fc             	mov    %rdi,%r12
    7845:	4c 89 e7             	mov    %r12,%rdi
    7848:	e8 13 eb ff ff       	call   6360 <fwp_rc_share>
    784d:	45 85 ed             	test   %r13d,%r13d
    7850:	74 1f                	je     7871 <fwp_apply_owned+0x461>
    7852:	45 89 ee             	mov    %r13d,%r14d
    7855:	45 31 ff             	xor    %r15d,%r15d
    7858:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    785f:	00 
    7860:	4a 8b 3c fb          	mov    (%rbx,%r15,8),%rdi
    7864:	e8 f7 ea ff ff       	call   6360 <fwp_rc_share>
    7869:	49 ff c7             	inc    %r15
    786c:	4d 39 fe             	cmp    %r15,%r14
    786f:	75 ef                	jne    7860 <fwp_apply_owned+0x450>
    7871:	4c 89 e7             	mov    %r12,%rdi
    7874:	44 89 ee             	mov    %r13d,%esi
    7877:	48 89 da             	mov    %rbx,%rdx
    787a:	e8 c1 f5 ff ff       	call   6e40 <fwp_apply>
    787f:	49 89 c4             	mov    %rax,%r12
    7882:	e9 ce 03 00 00       	jmp    7c55 <fwp_apply_owned+0x845>
    7887:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    788b:	4c 89 6d d0          	mov    %r13,-0x30(%rbp)
    788f:	44 89 f0             	mov    %r14d,%eax
    7892:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    7899:	00 
    789a:	4c 89 55 c0          	mov    %r10,-0x40(%rbp)
    789e:	e8 9d 29 00 00       	call   a240 <fwp_alloc_init>
    78a3:	4c 8b 55 c0          	mov    -0x40(%rbp),%r10
    78a7:	49 89 c5             	mov    %rax,%r13
    78aa:	41 8b 04 24          	mov    (%r12),%eax
    78ae:	41 89 45 00          	mov    %eax,0x0(%r13)
    78b2:	45 89 75 04          	mov    %r14d,0x4(%r13)
    78b6:	4c 89 e8             	mov    %r13,%rax
    78b9:	48 2b 05 f8 29 01 00 	sub    0x129f8(%rip),%rax        # 1a2b8 <fwp_gc+0x1030>
    78c0:	48 8b 0d 19 2a 01 00 	mov    0x12a19(%rip),%rcx        # 1a2e0 <fwp_gc+0x1058>
    78c7:	48 c1 e1 10          	shl    $0x10,%rcx
    78cb:	48 39 c8             	cmp    %rcx,%rax
    78ce:	73 73                	jae    7943 <fwp_apply_owned+0x533>
    78d0:	48 8b 0d 29 2a 01 00 	mov    0x12a29(%rip),%rcx        # 1a300 <fwp_gc+0x1078>
    78d7:	48 89 c2             	mov    %rax,%rdx
    78da:	48 c1 ea 10          	shr    $0x10,%rdx
    78de:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    78e5:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    78e9:	48 25 ff ff 00 00    	and    $0xffff,%rax
    78ef:	75 1d                	jne    790e <fwp_apply_owned+0x4fe>
    78f1:	40 80 fe 02          	cmp    $0x2,%sil
    78f5:	75 17                	jne    790e <fwp_apply_owned+0x4fe>
    78f7:	4c 8d 34 11          	lea    (%rcx,%rdx,1),%r14
    78fb:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    7902:	41 80 3e ff          	cmpb   $0xff,(%r14)
    7906:	74 2d                	je     7935 <fwp_apply_owned+0x525>
    7908:	41 c6 06 01          	movb   $0x1,(%r14)
    790c:	eb 35                	jmp    7943 <fwp_apply_owned+0x533>
    790e:	40 80 fe 01          	cmp    $0x1,%sil
    7912:	75 2f                	jne    7943 <fwp_apply_owned+0x533>
    7914:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    7918:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    791c:	48 0f af c1          	imul   %rcx,%rax
    7920:	48 c1 e8 20          	shr    $0x20,%rax
    7924:	4c 8d 34 30          	lea    (%rax,%rsi,1),%r14
    7928:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    792f:	41 80 3e ff          	cmpb   $0xff,(%r14)
    7933:	75 d3                	jne    7908 <fwp_apply_owned+0x4f8>
    7935:	4c 89 f7             	mov    %r14,%rdi
    7938:	e8 53 ec ff ff       	call   6590 <fwp_rc_forget_slot>
    793d:	4c 8b 55 c0          	mov    -0x40(%rbp),%r10
    7941:	eb c5                	jmp    7908 <fwp_apply_owned+0x4f8>
    7943:	4c 89 6d b0          	mov    %r13,-0x50(%rbp)
    7947:	48 ff 05 f2 33 01 00 	incq   0x133f2(%rip)        # 1ad40 <measured_scopes>
    794e:	48 8b 05 f3 33 01 00 	mov    0x133f3(%rip),%rax        # 1ad48 <fwp_cleanups>
    7955:	48 89 85 50 ff ff ff 	mov    %rax,-0xb0(%rbp)
    795c:	48 8d 05 1d 2a 00 00 	lea    0x2a1d(%rip),%rax        # a380 <fwp_rc_cleanup_cell>
    7963:	48 89 85 58 ff ff ff 	mov    %rax,-0xa8(%rbp)
    796a:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
    796e:	48 89 85 60 ff ff ff 	mov    %rax,-0xa0(%rbp)
    7975:	4c 8d b5 50 ff ff ff 	lea    -0xb0(%rbp),%r14
    797c:	4c 89 35 c5 33 01 00 	mov    %r14,0x133c5(%rip)        # 1ad48 <fwp_cleanups>
    7983:	4d 85 ff             	test   %r15,%r15
    7986:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
    798a:	0f 84 c1 00 00 00    	je     7a51 <fwp_apply_owned+0x641>
    7990:	31 c0                	xor    %eax,%eax
    7992:	41 83 ff 06          	cmp    $0x6,%r15d
    7996:	72 4e                	jb     79e6 <fwp_apply_owned+0x5d6>
    7998:	4c 89 e9             	mov    %r13,%rcx
    799b:	4c 29 e1             	sub    %r12,%rcx
    799e:	48 83 f9 20          	cmp    $0x20,%rcx
    79a2:	72 42                	jb     79e6 <fwp_apply_owned+0x5d6>
    79a4:	44 89 f8             	mov    %r15d,%eax
    79a7:	83 e0 fc             	and    $0xfffffffc,%eax
    79aa:	4a 8d 0c fd 00 00 00 	lea    0x0(,%r15,8),%rcx
    79b1:	00 
    79b2:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    79b6:	31 d2                	xor    %edx,%edx
    79b8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    79bf:	00 
    79c0:	41 0f 10 44 14 08    	movups 0x8(%r12,%rdx,1),%xmm0
    79c6:	41 0f 10 4c 14 18    	movups 0x18(%r12,%rdx,1),%xmm1
    79cc:	41 0f 11 44 15 08    	movups %xmm0,0x8(%r13,%rdx,1)
    79d2:	41 0f 11 4c 15 18    	movups %xmm1,0x18(%r13,%rdx,1)
    79d8:	48 83 c2 20          	add    $0x20,%rdx
    79dc:	48 39 d1             	cmp    %rdx,%rcx
    79df:	75 df                	jne    79c0 <fwp_apply_owned+0x5b0>
    79e1:	4c 39 f8             	cmp    %r15,%rax
    79e4:	74 6b                	je     7a51 <fwp_apply_owned+0x641>
    79e6:	4c 89 fa             	mov    %r15,%rdx
    79e9:	48 89 c1             	mov    %rax,%rcx
    79ec:	48 83 e2 03          	and    $0x3,%rdx
    79f0:	74 20                	je     7a12 <fwp_apply_owned+0x602>
    79f2:	48 89 c1             	mov    %rax,%rcx
    79f5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    79fc:	00 00 00 00 
    7a00:	49 8b 74 cc 08       	mov    0x8(%r12,%rcx,8),%rsi
    7a05:	49 89 74 cd 08       	mov    %rsi,0x8(%r13,%rcx,8)
    7a0a:	48 ff c1             	inc    %rcx
    7a0d:	48 ff ca             	dec    %rdx
    7a10:	75 ee                	jne    7a00 <fwp_apply_owned+0x5f0>
    7a12:	4c 29 f8             	sub    %r15,%rax
    7a15:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    7a19:	77 36                	ja     7a51 <fwp_apply_owned+0x641>
    7a1b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7a20:	49 8b 44 cc 08       	mov    0x8(%r12,%rcx,8),%rax
    7a25:	49 89 44 cd 08       	mov    %rax,0x8(%r13,%rcx,8)
    7a2a:	49 8b 44 cc 10       	mov    0x10(%r12,%rcx,8),%rax
    7a2f:	49 89 44 cd 10       	mov    %rax,0x10(%r13,%rcx,8)
    7a34:	49 8b 44 cc 18       	mov    0x18(%r12,%rcx,8),%rax
    7a39:	49 89 44 cd 18       	mov    %rax,0x18(%r13,%rcx,8)
    7a3e:	49 8b 44 cc 20       	mov    0x20(%r12,%rcx,8),%rax
    7a43:	49 89 44 cd 20       	mov    %rax,0x20(%r13,%rcx,8)
    7a48:	48 83 c1 04          	add    $0x4,%rcx
    7a4c:	49 39 cf             	cmp    %rcx,%r15
    7a4f:	75 cf                	jne    7a20 <fwp_apply_owned+0x610>
    7a51:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
    7a55:	0f 84 8b 00 00 00    	je     7ae6 <fwp_apply_owned+0x6d6>
    7a5b:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
    7a5f:	89 c8                	mov    %ecx,%eax
    7a61:	83 f9 14             	cmp    $0x14,%ecx
    7a64:	0f 83 f4 00 00 00    	jae    7b5e <fwp_apply_owned+0x74e>
    7a6a:	31 c9                	xor    %ecx,%ecx
    7a6c:	48 89 c6             	mov    %rax,%rsi
    7a6f:	48 89 ca             	mov    %rcx,%rdx
    7a72:	48 83 e6 03          	and    $0x3,%rsi
    7a76:	74 1d                	je     7a95 <fwp_apply_owned+0x685>
    7a78:	48 89 ca             	mov    %rcx,%rdx
    7a7b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7a80:	4c 8b 0c d3          	mov    (%rbx,%rdx,8),%r9
    7a84:	45 8d 04 17          	lea    (%r15,%rdx,1),%r8d
    7a88:	4f 89 4c c5 08       	mov    %r9,0x8(%r13,%r8,8)
    7a8d:	48 ff c2             	inc    %rdx
    7a90:	48 ff ce             	dec    %rsi
    7a93:	75 eb                	jne    7a80 <fwp_apply_owned+0x670>
    7a95:	48 29 c1             	sub    %rax,%rcx
    7a98:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    7a9c:	77 48                	ja     7ae6 <fwp_apply_owned+0x6d6>
    7a9e:	66 90                	xchg   %ax,%ax
    7aa0:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    7aa4:	41 8d 34 17          	lea    (%r15,%rdx,1),%esi
    7aa8:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    7aad:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    7ab2:	41 8d 34 17          	lea    (%r15,%rdx,1),%esi
    7ab6:	ff c6                	inc    %esi
    7ab8:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    7abd:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    7ac2:	41 8d 74 17 02       	lea    0x2(%r15,%rdx,1),%esi
    7ac7:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    7acc:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    7ad1:	41 8d 34 17          	lea    (%r15,%rdx,1),%esi
    7ad5:	83 c6 03             	add    $0x3,%esi
    7ad8:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    7add:	48 83 c2 04          	add    $0x4,%rdx
    7ae1:	48 39 d0             	cmp    %rdx,%rax
    7ae4:	75 ba                	jne    7aa0 <fwp_apply_owned+0x690>
    7ae6:	49 8b 02             	mov    (%r10),%rax
    7ae9:	be 01 00 00 00       	mov    $0x1,%esi
    7aee:	ff 50 08             	call   *0x8(%rax)
    7af1:	4c 89 e8             	mov    %r13,%rax
    7af4:	48 2b 05 bd 27 01 00 	sub    0x127bd(%rip),%rax        # 1a2b8 <fwp_gc+0x1030>
    7afb:	48 8b 0d de 27 01 00 	mov    0x127de(%rip),%rcx        # 1a2e0 <fwp_gc+0x1058>
    7b02:	48 c1 e1 10          	shl    $0x10,%rcx
    7b06:	48 39 c8             	cmp    %rcx,%rax
    7b09:	0f 83 fa 00 00 00    	jae    7c09 <fwp_apply_owned+0x7f9>
    7b0f:	48 8b 0d ea 27 01 00 	mov    0x127ea(%rip),%rcx        # 1a300 <fwp_gc+0x1078>
    7b16:	48 89 c2             	mov    %rax,%rdx
    7b19:	48 c1 ea 10          	shr    $0x10,%rdx
    7b1d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    7b24:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    7b28:	48 25 ff ff 00 00    	and    $0xffff,%rax
    7b2e:	0f 85 9c 00 00 00    	jne    7bd0 <fwp_apply_owned+0x7c0>
    7b34:	40 80 fe 02          	cmp    $0x2,%sil
    7b38:	0f 85 92 00 00 00    	jne    7bd0 <fwp_apply_owned+0x7c0>
    7b3e:	4c 8d 24 11          	lea    (%rcx,%rdx,1),%r12
    7b42:	49 81 c4 28 02 00 00 	add    $0x228,%r12
    7b49:	41 80 3c 24 ff       	cmpb   $0xff,(%r12)
    7b4e:	0f 84 a8 00 00 00    	je     7bfc <fwp_apply_owned+0x7ec>
    7b54:	41 c6 04 24 01       	movb   $0x1,(%r12)
    7b59:	e9 ab 00 00 00       	jmp    7c09 <fwp_apply_owned+0x7f9>
    7b5e:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    7b62:	31 c9                	xor    %ecx,%ecx
    7b64:	89 d6                	mov    %edx,%esi
    7b66:	44 01 fe             	add    %r15d,%esi
    7b69:	0f 82 fd fe ff ff    	jb     7a6c <fwp_apply_owned+0x65c>
    7b6f:	48 c1 ea 20          	shr    $0x20,%rdx
    7b73:	0f 85 f3 fe ff ff    	jne    7a6c <fwp_apply_owned+0x65c>
    7b79:	4a 8d 0c fd 00 00 00 	lea    0x0(,%r15,8),%rcx
    7b80:	00 
    7b81:	4c 01 e9             	add    %r13,%rcx
    7b84:	48 29 d9             	sub    %rbx,%rcx
    7b87:	48 83 c1 08          	add    $0x8,%rcx
    7b8b:	48 83 f9 20          	cmp    $0x20,%rcx
    7b8f:	0f 82 d5 fe ff ff    	jb     7a6a <fwp_apply_owned+0x65a>
    7b95:	89 c1                	mov    %eax,%ecx
    7b97:	83 e1 fc             	and    $0xfffffffc,%ecx
    7b9a:	31 d2                	xor    %edx,%edx
    7b9c:	0f 1f 40 00          	nopl   0x0(%rax)
    7ba0:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    7ba4:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    7ba9:	41 8d 34 17          	lea    (%r15,%rdx,1),%esi
    7bad:	41 0f 11 44 f5 08    	movups %xmm0,0x8(%r13,%rsi,8)
    7bb3:	41 0f 11 4c f5 18    	movups %xmm1,0x18(%r13,%rsi,8)
    7bb9:	48 83 c2 04          	add    $0x4,%rdx
    7bbd:	48 39 d1             	cmp    %rdx,%rcx
    7bc0:	75 de                	jne    7ba0 <fwp_apply_owned+0x790>
    7bc2:	48 39 c1             	cmp    %rax,%rcx
    7bc5:	0f 85 a1 fe ff ff    	jne    7a6c <fwp_apply_owned+0x65c>
    7bcb:	e9 16 ff ff ff       	jmp    7ae6 <fwp_apply_owned+0x6d6>
    7bd0:	40 80 fe 01          	cmp    $0x1,%sil
    7bd4:	75 33                	jne    7c09 <fwp_apply_owned+0x7f9>
    7bd6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    7bda:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    7bde:	48 0f af c1          	imul   %rcx,%rax
    7be2:	48 c1 e8 20          	shr    $0x20,%rax
    7be6:	4c 8d 24 30          	lea    (%rax,%rsi,1),%r12
    7bea:	49 81 c4 28 02 00 00 	add    $0x228,%r12
    7bf1:	41 80 3c 24 ff       	cmpb   $0xff,(%r12)
    7bf6:	0f 85 58 ff ff ff    	jne    7b54 <fwp_apply_owned+0x744>
    7bfc:	4c 89 e7             	mov    %r12,%rdi
    7bff:	e8 8c e9 ff ff       	call   6590 <fwp_rc_forget_slot>
    7c04:	e9 4b ff ff ff       	jmp    7b54 <fwp_apply_owned+0x744>
    7c09:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    7c0d:	89 45 80             	mov    %eax,-0x80(%rbp)
    7c10:	48 c7 45 b0 00 00 00 	movq   $0x0,-0x50(%rbp)
    7c17:	00 
    7c18:	4c 39 35 29 31 01 00 	cmp    %r14,0x13129(%rip)        # 1ad48 <fwp_cleanups>
    7c1f:	75 46                	jne    7c67 <fwp_apply_owned+0x857>
    7c21:	48 8b 85 50 ff ff ff 	mov    -0xb0(%rbp),%rax
    7c28:	48 89 05 19 31 01 00 	mov    %rax,0x13119(%rip)        # 1ad48 <fwp_cleanups>
    7c2f:	80 7d cc 00          	cmpb   $0x0,-0x34(%rbp)
    7c33:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
    7c37:	74 14                	je     7c4d <fwp_apply_owned+0x83d>
    7c39:	48 8d 4d 98          	lea    -0x68(%rbp),%rcx
    7c3d:	48 39 c8             	cmp    %rcx,%rax
    7c40:	75 25                	jne    7c67 <fwp_apply_owned+0x857>
    7c42:	48 8b 45 98          	mov    -0x68(%rbp),%rax
    7c46:	48 89 05 fb 30 01 00 	mov    %rax,0x130fb(%rip)        # 1ad48 <fwp_cleanups>
    7c4d:	e8 ee 20 00 00       	call   9d40 <fwp_closure_drop>
    7c52:	4d 89 ec             	mov    %r13,%r12
    7c55:	4c 89 e0             	mov    %r12,%rax
    7c58:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    7c5c:	5b                   	pop    %rbx
    7c5d:	41 5c                	pop    %r12
    7c5f:	41 5d                	pop    %r13
    7c61:	41 5e                	pop    %r14
    7c63:	41 5f                	pop    %r15
    7c65:	5d                   	pop    %rbp
    7c66:	c3                   	ret
    7c67:	e8 04 b4 ff ff       	call   3070 <abort@plt>
    7c6c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000007c70 <fwp_alloc>:
    7c70:	53                   	push   %rbx
    7c71:	48 ff 05 b0 30 01 00 	incq   0x130b0(%rip)        # 1ad28 <measured_calls>
    7c78:	48 01 3d b1 30 01 00 	add    %rdi,0x130b1(%rip)        # 1ad30 <measured_bytes>
    7c7f:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    7c86:	77 61                	ja     7ce9 <fwp_alloc+0x79>
    7c88:	48 8d 4f 0f          	lea    0xf(%rdi),%rcx
    7c8c:	48 c1 e9 04          	shr    $0x4,%rcx
    7c90:	48 8d 05 f1 15 01 00 	lea    0x115f1(%rip),%rax        # 19288 <fwp_gc>
    7c97:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    7c9e:	00 
    7c9f:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    7ca6:	48 29 15 db 15 01 00 	sub    %rdx,0x115db(%rip)        # 19288 <fwp_gc>
    7cad:	78 3a                	js     7ce9 <fwp_alloc+0x79>
    7caf:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    7cb3:	48 8d 34 c8          	lea    (%rax,%rcx,8),%rsi
    7cb7:	48 81 c6 88 07 00 00 	add    $0x788,%rsi
    7cbe:	48 8b 1e             	mov    (%rsi),%rbx
    7cc1:	48 85 db             	test   %rbx,%rbx
    7cc4:	74 0b                	je     7cd1 <fwp_alloc+0x61>
    7cc6:	48 8b 03             	mov    (%rbx),%rax
    7cc9:	48 f7 d0             	not    %rax
    7ccc:	48 89 06             	mov    %rax,(%rsi)
    7ccf:	eb 31                	jmp    7d02 <fwp_alloc+0x92>
    7cd1:	48 8b 9c c8 90 07 00 	mov    0x790(%rax,%rcx,8),%rbx
    7cd8:	00 
    7cd9:	48 8b b4 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%rsi
    7ce0:	00 
    7ce1:	48 29 de             	sub    %rbx,%rsi
    7ce4:	48 39 d6             	cmp    %rdx,%rsi
    7ce7:	73 08                	jae    7cf1 <fwp_alloc+0x81>
    7ce9:	be 02 00 00 00       	mov    $0x2,%esi
    7cee:	5b                   	pop    %rbx
    7cef:	eb 2f                	jmp    7d20 <fwp_gc_alloc_slow>
    7cf1:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    7cf5:	48 05 90 07 00 00    	add    $0x790,%rax
    7cfb:	48 8d 0c 13          	lea    (%rbx,%rdx,1),%rcx
    7cff:	48 89 08             	mov    %rcx,(%rax)
    7d02:	48 89 df             	mov    %rbx,%rdi
    7d05:	31 f6                	xor    %esi,%esi
    7d07:	e8 04 b5 ff ff       	call   3210 <memset@plt>
    7d0c:	48 89 d8             	mov    %rbx,%rax
    7d0f:	5b                   	pop    %rbx
    7d10:	c3                   	ret
    7d11:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7d18:	0f 1f 84 00 00 00 00 
    7d1f:	00 

0000000000007d20 <fwp_gc_alloc_slow>:
    7d20:	55                   	push   %rbp
    7d21:	41 57                	push   %r15
    7d23:	41 56                	push   %r14
    7d25:	41 54                	push   %r12
    7d27:	53                   	push   %rbx
    7d28:	89 f5                	mov    %esi,%ebp
    7d2a:	48 89 fb             	mov    %rdi,%rbx
    7d2d:	83 3d 40 25 01 00 00 	cmpl   $0x0,0x12540(%rip)        # 1a274 <fwp_gc+0xfec>
    7d34:	74 1b                	je     7d51 <fwp_gc_alloc_slow+0x31>
    7d36:	48 81 fb 01 40 00 00 	cmp    $0x4001,%rbx
    7d3d:	72 20                	jb     7d5f <fwp_gc_alloc_slow+0x3f>
    7d3f:	48 89 df             	mov    %rbx,%rdi
    7d42:	89 ee                	mov    %ebp,%esi
    7d44:	5b                   	pop    %rbx
    7d45:	41 5c                	pop    %r12
    7d47:	41 5e                	pop    %r14
    7d49:	41 5f                	pop    %r15
    7d4b:	5d                   	pop    %rbp
    7d4c:	e9 9f 04 00 00       	jmp    81f0 <fwp_gc_alloc_big>
    7d51:	e8 ba 00 00 00       	call   7e10 <fwp_gc_init>
    7d56:	48 81 fb 01 40 00 00 	cmp    $0x4001,%rbx
    7d5d:	73 e0                	jae    7d3f <fwp_gc_alloc_slow+0x1f>
    7d5f:	48 8d 43 0f          	lea    0xf(%rbx),%rax
    7d63:	48 c1 e8 04          	shr    $0x4,%rax
    7d67:	4c 8d 25 1a 15 01 00 	lea    0x1151a(%rip),%r12        # 19288 <fwp_gc>
    7d6e:	46 0f b6 bc 20 e8 0b 	movzbl 0xbe8(%rax,%r12,1),%r15d
    7d75:	00 00 
    7d77:	47 8b b4 bc 48 0b 00 	mov    0xb48(%r12,%r15,4),%r14d
    7d7e:	00 
    7d7f:	48 83 3d 01 15 01 00 	cmpq   $0x0,0x11501(%rip)        # 19288 <fwp_gc>
    7d86:	00 
    7d87:	79 05                	jns    7d8e <fwp_gc_alloc_slow+0x6e>
    7d89:	e8 02 06 00 00       	call   8390 <fwp_gc_spent>
    7d8e:	89 e8                	mov    %ebp,%eax
    7d90:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    7d97:	49 01 c4             	add    %rax,%r12
    7d9a:	4b 8d 0c 7f          	lea    (%r15,%r15,2),%rcx
    7d9e:	49 8d 04 cc          	lea    (%r12,%rcx,8),%rax
    7da2:	48 83 c0 08          	add    $0x8,%rax
    7da6:	49 8b 7c cc 08       	mov    0x8(%r12,%rcx,8),%rdi
    7dab:	48 85 ff             	test   %rdi,%rdi
    7dae:	74 08                	je     7db8 <fwp_gc_alloc_slow+0x98>
    7db0:	48 8b 0f             	mov    (%rdi),%rcx
    7db3:	48 f7 d1             	not    %rcx
    7db6:	eb 30                	jmp    7de8 <fwp_gc_alloc_slow+0xc8>
    7db8:	49 8b 7c cc 10       	mov    0x10(%r12,%rcx,8),%rdi
    7dbd:	49 8b 54 cc 18       	mov    0x18(%r12,%rcx,8),%rdx
    7dc2:	48 29 fa             	sub    %rdi,%rdx
    7dc5:	4c 39 f2             	cmp    %r14,%rdx
    7dc8:	73 12                	jae    7ddc <fwp_gc_alloc_slow+0xbc>
    7dca:	48 89 c7             	mov    %rax,%rdi
    7dcd:	44 89 fe             	mov    %r15d,%esi
    7dd0:	89 ea                	mov    %ebp,%edx
    7dd2:	e8 89 06 00 00       	call   8460 <fwp_gc_refill>
    7dd7:	48 89 c7             	mov    %rax,%rdi
    7dda:	eb 0f                	jmp    7deb <fwp_gc_alloc_slow+0xcb>
    7ddc:	49 8d 04 cc          	lea    (%r12,%rcx,8),%rax
    7de0:	48 83 c0 10          	add    $0x10,%rax
    7de4:	4a 8d 0c 37          	lea    (%rdi,%r14,1),%rcx
    7de8:	48 89 08             	mov    %rcx,(%rax)
    7deb:	83 fd 01             	cmp    $0x1,%ebp
    7dee:	4c 0f 44 f3          	cmove  %rbx,%r14
    7df2:	31 f6                	xor    %esi,%esi
    7df4:	4c 89 f2             	mov    %r14,%rdx
    7df7:	5b                   	pop    %rbx
    7df8:	41 5c                	pop    %r12
    7dfa:	41 5e                	pop    %r14
    7dfc:	41 5f                	pop    %r15
    7dfe:	5d                   	pop    %rbp
    7dff:	e9 0c b4 ff ff       	jmp    3210 <memset@plt>
    7e04:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    7e0b:	00 00 00 00 00 

0000000000007e10 <fwp_gc_init>:
    7e10:	53                   	push   %rbx
    7e11:	c7 05 59 24 01 00 01 	movl   $0x1,0x12459(%rip)        # 1a274 <fwp_gc+0xfec>
    7e18:	00 00 00 
    7e1b:	0f 28 05 fe c1 00 00 	movaps 0xc1fe(%rip),%xmm0        # 14020 <_IO_stdin_used+0x20>
    7e22:	0f 11 05 a7 1f 01 00 	movups %xmm0,0x11fa7(%rip)        # 19dd0 <fwp_gc+0xb48>
    7e29:	0f 28 05 00 c2 00 00 	movaps 0xc200(%rip),%xmm0        # 14030 <_IO_stdin_used+0x30>
    7e30:	0f 11 05 a9 1f 01 00 	movups %xmm0,0x11fa9(%rip)        # 19de0 <fwp_gc+0xb58>
    7e37:	0f 28 05 02 c2 00 00 	movaps 0xc202(%rip),%xmm0        # 14040 <_IO_stdin_used+0x40>
    7e3e:	0f 11 05 ab 1f 01 00 	movups %xmm0,0x11fab(%rip)        # 19df0 <fwp_gc+0xb68>
    7e45:	0f 28 05 04 c2 00 00 	movaps 0xc204(%rip),%xmm0        # 14050 <_IO_stdin_used+0x50>
    7e4c:	0f 11 05 ad 1f 01 00 	movups %xmm0,0x11fad(%rip)        # 19e00 <fwp_gc+0xb78>
    7e53:	0f 28 05 06 c2 00 00 	movaps 0xc206(%rip),%xmm0        # 14060 <_IO_stdin_used+0x60>
    7e5a:	0f 11 05 af 1f 01 00 	movups %xmm0,0x11faf(%rip)        # 19e10 <fwp_gc+0xb88>
    7e61:	0f 28 05 08 c2 00 00 	movaps 0xc208(%rip),%xmm0        # 14070 <_IO_stdin_used+0x70>
    7e68:	0f 11 05 b1 1f 01 00 	movups %xmm0,0x11fb1(%rip)        # 19e20 <fwp_gc+0xb98>
    7e6f:	0f 28 05 0a c2 00 00 	movaps 0xc20a(%rip),%xmm0        # 14080 <_IO_stdin_used+0x80>
    7e76:	0f 11 05 b3 1f 01 00 	movups %xmm0,0x11fb3(%rip)        # 19e30 <fwp_gc+0xba8>
    7e7d:	0f 28 05 0c c2 00 00 	movaps 0xc20c(%rip),%xmm0        # 14090 <_IO_stdin_used+0x90>
    7e84:	0f 11 05 b5 1f 01 00 	movups %xmm0,0x11fb5(%rip)        # 19e40 <fwp_gc+0xbb8>
    7e8b:	0f 28 05 0e c2 00 00 	movaps 0xc20e(%rip),%xmm0        # 140a0 <_IO_stdin_used+0xa0>
    7e92:	0f 11 05 b7 1f 01 00 	movups %xmm0,0x11fb7(%rip)        # 19e50 <fwp_gc+0xbc8>
    7e99:	0f 28 05 10 c2 00 00 	movaps 0xc210(%rip),%xmm0        # 140b0 <_IO_stdin_used+0xb0>
    7ea0:	0f 11 05 b9 1f 01 00 	movups %xmm0,0x11fb9(%rip)        # 19e60 <fwp_gc+0xbd8>
    7ea7:	31 c9                	xor    %ecx,%ecx
    7ea9:	48 8d 05 d8 13 01 00 	lea    0x113d8(%rip),%rax        # 19288 <fwp_gc>
    7eb0:	31 d2                	xor    %edx,%edx
    7eb2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7eb9:	1f 84 00 00 00 00 00 
    7ec0:	89 d6                	mov    %edx,%esi
    7ec2:	c1 e6 04             	shl    $0x4,%esi
    7ec5:	48 ff c9             	dec    %rcx
    7ec8:	48 89 cf             	mov    %rcx,%rdi
    7ecb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7ed0:	48 89 f9             	mov    %rdi,%rcx
    7ed3:	48 ff c7             	inc    %rdi
    7ed6:	3b b4 88 4c 0b 00 00 	cmp    0xb4c(%rax,%rcx,4),%esi
    7edd:	77 f1                	ja     7ed0 <fwp_gc_init+0xc0>
    7edf:	40 88 bc 02 e8 0b 00 	mov    %dil,0xbe8(%rdx,%rax,1)
    7ee6:	00 
    7ee7:	48 89 d6             	mov    %rdx,%rsi
    7eea:	48 83 ce 01          	or     $0x1,%rsi
    7eee:	48 81 fe 01 04 00 00 	cmp    $0x401,%rsi
    7ef5:	74 26                	je     7f1d <fwp_gc_init+0x10d>
    7ef7:	89 f7                	mov    %esi,%edi
    7ef9:	c1 e7 04             	shl    $0x4,%edi
    7efc:	0f 1f 40 00          	nopl   0x0(%rax)
    7f00:	49 89 c8             	mov    %rcx,%r8
    7f03:	48 ff c1             	inc    %rcx
    7f06:	42 3b bc 80 4c 0b 00 	cmp    0xb4c(%rax,%r8,4),%edi
    7f0d:	00 
    7f0e:	77 f0                	ja     7f00 <fwp_gc_init+0xf0>
    7f10:	88 8c 06 e8 0b 00 00 	mov    %cl,0xbe8(%rsi,%rax,1)
    7f17:	48 83 c2 02          	add    $0x2,%rdx
    7f1b:	eb a3                	jmp    7ec0 <fwp_gc_init+0xb0>
    7f1d:	48 bb 00 00 00 00 10 	movabs $0x1000000000,%rbx
    7f24:	00 00 00 
    7f27:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    7f2e:	31 ff                	xor    %edi,%edi
    7f30:	31 d2                	xor    %edx,%edx
    7f32:	b9 22 40 00 00       	mov    $0x4022,%ecx
    7f37:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    7f3d:	45 31 c9             	xor    %r9d,%r9d
    7f40:	e8 4b b2 ff ff       	call   3190 <mmap@plt>
    7f45:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    7f49:	75 60                	jne    7fab <fwp_gc_init+0x19b>
    7f4b:	48 bb 00 00 00 00 04 	movabs $0x400000000,%rbx
    7f52:	00 00 00 
    7f55:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    7f5c:	31 ff                	xor    %edi,%edi
    7f5e:	31 d2                	xor    %edx,%edx
    7f60:	b9 22 40 00 00       	mov    $0x4022,%ecx
    7f65:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    7f6b:	45 31 c9             	xor    %r9d,%r9d
    7f6e:	e8 1d b2 ff ff       	call   3190 <mmap@plt>
    7f73:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    7f77:	75 32                	jne    7fab <fwp_gc_init+0x19b>
    7f79:	48 bb 00 00 00 00 01 	movabs $0x100000000,%rbx
    7f80:	00 00 00 
    7f83:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    7f8a:	31 ff                	xor    %edi,%edi
    7f8c:	31 d2                	xor    %edx,%edx
    7f8e:	b9 22 40 00 00       	mov    $0x4022,%ecx
    7f93:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    7f99:	45 31 c9             	xor    %r9d,%r9d
    7f9c:	e8 ef b1 ff ff       	call   3190 <mmap@plt>
    7fa1:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    7fa5:	0f 84 b5 01 00 00    	je     8160 <fwp_gc_init+0x350>
    7fab:	48 85 c0             	test   %rax,%rax
    7fae:	0f 84 0d 02 00 00    	je     81c1 <fwp_gc_init+0x3b1>
    7fb4:	48 89 05 05 23 01 00 	mov    %rax,0x12305(%rip)        # 1a2c0 <fwp_gc+0x1038>
    7fbb:	48 89 d9             	mov    %rbx,%rcx
    7fbe:	48 81 c9 00 00 01 00 	or     $0x10000,%rcx
    7fc5:	48 89 0d fc 22 01 00 	mov    %rcx,0x122fc(%rip)        # 1a2c8 <fwp_gc+0x1040>
    7fcc:	48 05 ff ff 00 00    	add    $0xffff,%rax
    7fd2:	48 25 00 00 ff ff    	and    $0xffffffffffff0000,%rax
    7fd8:	48 89 05 d9 22 01 00 	mov    %rax,0x122d9(%rip)        # 1a2b8 <fwp_gc+0x1030>
    7fdf:	48 c1 eb 10          	shr    $0x10,%rbx
    7fe3:	48 89 1d ee 22 01 00 	mov    %rbx,0x122ee(%rip)        # 1a2d8 <fwp_gc+0x1050>
    7fea:	48 69 f3 28 12 00 00 	imul   $0x1228,%rbx,%rsi
    7ff1:	48 89 35 10 23 01 00 	mov    %rsi,0x12310(%rip)        # 1a308 <fwp_gc+0x1080>
    7ff8:	31 ff                	xor    %edi,%edi
    7ffa:	31 d2                	xor    %edx,%edx
    7ffc:	b9 22 40 00 00       	mov    $0x4022,%ecx
    8001:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    8007:	45 31 c9             	xor    %r9d,%r9d
    800a:	e8 81 b1 ff ff       	call   3190 <mmap@plt>
    800f:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    8013:	0f 84 a8 01 00 00    	je     81c1 <fwp_gc_init+0x3b1>
    8019:	48 89 05 e0 22 01 00 	mov    %rax,0x122e0(%rip)        # 1a300 <fwp_gc+0x1078>
    8020:	48 8d 3d 46 ca 00 00 	lea    0xca46(%rip),%rdi        # 14a6d <exec_in_fp0+0x25d>
    8027:	e8 04 b0 ff ff       	call   3030 <getenv@plt>
    802c:	48 85 c0             	test   %rax,%rax
    802f:	74 2e                	je     805f <fwp_gc_init+0x24f>
    8031:	48 89 c3             	mov    %rax,%rbx
    8034:	48 8d 35 39 ca 00 00 	lea    0xca39(%rip),%rsi        # 14a74 <exec_in_fp0+0x264>
    803b:	48 89 c7             	mov    %rax,%rdi
    803e:	e8 8d b2 ff ff       	call   32d0 <strcmp@plt>
    8043:	85 c0                	test   %eax,%eax
    8045:	74 1f                	je     8066 <fwp_gc_init+0x256>
    8047:	48 8d 35 0f d7 00 00 	lea    0xd70f(%rip),%rsi        # 1575d <exec_in_fp0+0xf4d>
    804e:	48 89 df             	mov    %rbx,%rdi
    8051:	e8 7a b2 ff ff       	call   32d0 <strcmp@plt>
    8056:	31 c9                	xor    %ecx,%ecx
    8058:	85 c0                	test   %eax,%eax
    805a:	0f 95 c1             	setne  %cl
    805d:	eb 09                	jmp    8068 <fwp_gc_init+0x258>
    805f:	b9 01 00 00 00       	mov    $0x1,%ecx
    8064:	eb 02                	jmp    8068 <fwp_gc_init+0x258>
    8066:	31 c9                	xor    %ecx,%ecx
    8068:	89 0d 0a 22 01 00    	mov    %ecx,0x1220a(%rip)        # 1a278 <fwp_gc+0xff0>
    806e:	48 8d 3d 03 ca 00 00 	lea    0xca03(%rip),%rdi        # 14a78 <exec_in_fp0+0x268>
    8075:	e8 b6 af ff ff       	call   3030 <getenv@plt>
    807a:	31 c9                	xor    %ecx,%ecx
    807c:	48 85 c0             	test   %rax,%rax
    807f:	74 1b                	je     809c <fwp_gc_init+0x28c>
    8081:	80 38 00             	cmpb   $0x0,(%rax)
    8084:	74 16                	je     809c <fwp_gc_init+0x28c>
    8086:	48 8d 35 d0 d6 00 00 	lea    0xd6d0(%rip),%rsi        # 1575d <exec_in_fp0+0xf4d>
    808d:	48 89 c7             	mov    %rax,%rdi
    8090:	e8 3b b2 ff ff       	call   32d0 <strcmp@plt>
    8095:	31 c9                	xor    %ecx,%ecx
    8097:	85 c0                	test   %eax,%eax
    8099:	0f 95 c1             	setne  %cl
    809c:	89 0d e2 21 01 00    	mov    %ecx,0x121e2(%rip)        # 1a284 <fwp_gc+0xffc>
    80a2:	48 8d 3d c4 c9 00 00 	lea    0xc9c4(%rip),%rdi        # 14a6d <exec_in_fp0+0x25d>
    80a9:	e8 82 af ff ff       	call   3030 <getenv@plt>
    80ae:	48 85 c0             	test   %rax,%rax
    80b1:	74 18                	je     80cb <fwp_gc_init+0x2bb>
    80b3:	48 8d 35 cb c9 00 00 	lea    0xc9cb(%rip),%rsi        # 14a85 <exec_in_fp0+0x275>
    80ba:	48 89 c7             	mov    %rax,%rdi
    80bd:	e8 0e b2 ff ff       	call   32d0 <strcmp@plt>
    80c2:	31 c9                	xor    %ecx,%ecx
    80c4:	85 c0                	test   %eax,%eax
    80c6:	0f 95 c1             	setne  %cl
    80c9:	eb 05                	jmp    80d0 <fwp_gc_init+0x2c0>
    80cb:	b9 01 00 00 00       	mov    $0x1,%ecx
    80d0:	89 0d b2 21 01 00    	mov    %ecx,0x121b2(%rip)        # 1a288 <fwp_gc+0x1000>
    80d6:	c7 05 b0 21 01 00 01 	movl   $0x1,0x121b0(%rip)        # 1a290 <fwp_gc+0x1008>
    80dd:	00 00 00 
    80e0:	48 8d 3d a3 c9 00 00 	lea    0xc9a3(%rip),%rdi        # 14a8a <exec_in_fp0+0x27a>
    80e7:	e8 44 af ff ff       	call   3030 <getenv@plt>
    80ec:	31 c9                	xor    %ecx,%ecx
    80ee:	48 85 c0             	test   %rax,%rax
    80f1:	74 1b                	je     810e <fwp_gc_init+0x2fe>
    80f3:	80 38 00             	cmpb   $0x0,(%rax)
    80f6:	74 16                	je     810e <fwp_gc_init+0x2fe>
    80f8:	48 8d 35 5e d6 00 00 	lea    0xd65e(%rip),%rsi        # 1575d <exec_in_fp0+0xf4d>
    80ff:	48 89 c7             	mov    %rax,%rdi
    8102:	e8 c9 b1 ff ff       	call   32d0 <strcmp@plt>
    8107:	31 c9                	xor    %ecx,%ecx
    8109:	85 c0                	test   %eax,%eax
    810b:	0f 95 c1             	setne  %cl
    810e:	89 0d 78 21 01 00    	mov    %ecx,0x12178(%rip)        # 1a28c <fwp_gc+0x1004>
    8114:	48 8d 3d 7d c9 00 00 	lea    0xc97d(%rip),%rdi        # 14a98 <exec_in_fp0+0x288>
    811b:	e8 10 af ff ff       	call   3030 <getenv@plt>
    8120:	48 85 c0             	test   %rax,%rax
    8123:	74 11                	je     8136 <fwp_gc_init+0x326>
    8125:	48 89 c7             	mov    %rax,%rdi
    8128:	31 f6                	xor    %esi,%esi
    812a:	ba 0a 00 00 00       	mov    $0xa,%edx
    812f:	e8 ec b1 ff ff       	call   3320 <strtol@plt>
    8134:	eb 02                	jmp    8138 <fwp_gc_init+0x328>
    8136:	31 c0                	xor    %eax,%eax
    8138:	31 c9                	xor    %ecx,%ecx
    813a:	48 85 c0             	test   %rax,%rax
    813d:	48 0f 4f c8          	cmovg  %rax,%rcx
    8141:	48 89 0d 60 21 01 00 	mov    %rcx,0x12160(%rip)        # 1a2a8 <fwp_gc+0x1020>
    8148:	48 c7 05 45 23 01 00 	movq   $0x800000,0x12345(%rip)        # 1a498 <fwp_gc+0x1210>
    814f:	00 00 80 00 
    8153:	48 c7 05 2a 11 01 00 	movq   $0x800000,0x1112a(%rip)        # 19288 <fwp_gc>
    815a:	00 00 80 00 
    815e:	5b                   	pop    %rbx
    815f:	c3                   	ret
    8160:	be 00 00 01 40       	mov    $0x40010000,%esi
    8165:	31 ff                	xor    %edi,%edi
    8167:	31 d2                	xor    %edx,%edx
    8169:	b9 22 40 00 00       	mov    $0x4022,%ecx
    816e:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    8174:	45 31 c9             	xor    %r9d,%r9d
    8177:	e8 14 b0 ff ff       	call   3190 <mmap@plt>
    817c:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    8180:	74 0f                	je     8191 <fwp_gc_init+0x381>
    8182:	48 85 c0             	test   %rax,%rax
    8185:	74 3a                	je     81c1 <fwp_gc_init+0x3b1>
    8187:	bb 00 00 00 40       	mov    $0x40000000,%ebx
    818c:	e9 23 fe ff ff       	jmp    7fb4 <fwp_gc_init+0x1a4>
    8191:	be 00 00 01 10       	mov    $0x10010000,%esi
    8196:	31 ff                	xor    %edi,%edi
    8198:	31 d2                	xor    %edx,%edx
    819a:	b9 22 40 00 00       	mov    $0x4022,%ecx
    819f:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    81a5:	45 31 c9             	xor    %r9d,%r9d
    81a8:	e8 e3 af ff ff       	call   3190 <mmap@plt>
    81ad:	48 8d 48 01          	lea    0x1(%rax),%rcx
    81b1:	48 83 f9 02          	cmp    $0x2,%rcx
    81b5:	72 0a                	jb     81c1 <fwp_gc_init+0x3b1>
    81b7:	bb 00 00 00 10       	mov    $0x10000000,%ebx
    81bc:	e9 f3 fd ff ff       	jmp    7fb4 <fwp_gc_init+0x1a4>
    81c1:	48 8b 05 10 0e 01 00 	mov    0x10e10(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    81c8:	48 8b 08             	mov    (%rax),%rcx
    81cb:	48 8d 3d d4 c8 00 00 	lea    0xc8d4(%rip),%rdi        # 14aa6 <exec_in_fp0+0x296>
    81d2:	be 13 00 00 00       	mov    $0x13,%esi
    81d7:	ba 01 00 00 00       	mov    $0x1,%edx
    81dc:	e8 9f b2 ff ff       	call   3480 <fwrite@plt>
    81e1:	bf 66 00 00 00       	mov    $0x66,%edi
    81e6:	e8 75 b2 ff ff       	call   3460 <exit@plt>
    81eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000081f0 <fwp_gc_alloc_big>:
    81f0:	55                   	push   %rbp
    81f1:	41 57                	push   %r15
    81f3:	41 56                	push   %r14
    81f5:	41 55                	push   %r13
    81f7:	41 54                	push   %r12
    81f9:	53                   	push   %rbx
    81fa:	50                   	push   %rax
    81fb:	48 b8 01 00 00 00 00 	movabs $0x4000000000000001,%rax
    8202:	00 00 40 
    8205:	48 39 c7             	cmp    %rax,%rdi
    8208:	0f 83 4e 01 00 00    	jae    835c <fwp_gc_alloc_big+0x16c>
    820e:	89 f5                	mov    %esi,%ebp
    8210:	48 89 fb             	mov    %rdi,%rbx
    8213:	48 29 3d 6e 10 01 00 	sub    %rdi,0x1106e(%rip)        # 19288 <fwp_gc>
    821a:	79 05                	jns    8221 <fwp_gc_alloc_big+0x31>
    821c:	e8 6f 01 00 00       	call   8390 <fwp_gc_spent>
    8221:	4c 8d b3 ff ff 00 00 	lea    0xffff(%rbx),%r14
    8228:	49 c1 ee 10          	shr    $0x10,%r14
    822c:	4c 89 f7             	mov    %r14,%rdi
    822f:	e8 5c 03 00 00       	call   8590 <fwp_gc_chunks>
    8234:	48 8b 0d c5 20 01 00 	mov    0x120c5(%rip),%rcx        # 1a300 <fwp_gc+0x1078>
    823b:	4c 69 e0 28 12 00 00 	imul   $0x1228,%rax,%r12
    8242:	42 c6 04 21 02       	movb   $0x2,(%rcx,%r12,1)
    8247:	42 88 6c 21 01       	mov    %bpl,0x1(%rcx,%r12,1)
    824c:	66 42 c7 44 21 03 00 	movw   $0x100,0x3(%rcx,%r12,1)
    8253:	01 
    8254:	46 89 74 21 10       	mov    %r14d,0x10(%rcx,%r12,1)
    8259:	4a 89 5c 21 18       	mov    %rbx,0x18(%rcx,%r12,1)
    825e:	4e 8d 3c 21          	lea    (%rcx,%r12,1),%r15
    8262:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    8269:	42 80 bc 21 28 02 00 	cmpb   $0xff,0x228(%rcx,%r12,1)
    8270:	00 ff 
    8272:	0f 84 d1 00 00 00    	je     8349 <fwp_gc_alloc_big+0x159>
    8278:	41 c6 07 00          	movb   $0x0,(%r15)
    827c:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    8283:	0f 82 9a 00 00 00    	jb     8323 <fwp_gc_alloc_big+0x133>
    8289:	49 83 fe 03          	cmp    $0x3,%r14
    828d:	ba 02 00 00 00       	mov    $0x2,%edx
    8292:	49 0f 43 d6          	cmovae %r14,%rdx
    8296:	48 8b 0d 63 20 01 00 	mov    0x12063(%rip),%rcx        # 1a300 <fwp_gc+0x1078>
    829d:	48 ff ca             	dec    %rdx
    82a0:	be 01 00 00 00       	mov    $0x1,%esi
    82a5:	48 81 fb 01 00 02 00 	cmp    $0x20001,%rbx
    82ac:	72 59                	jb     8307 <fwp_gc_alloc_big+0x117>
    82ae:	49 8d 3c 0c          	lea    (%r12,%rcx,1),%rdi
    82b2:	48 81 c7 60 24 00 00 	add    $0x2460,%rdi
    82b9:	49 89 d0             	mov    %rdx,%r8
    82bc:	49 83 e0 fe          	and    $0xfffffffffffffffe,%r8
    82c0:	49 f7 d8             	neg    %r8
    82c3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    82ca:	84 00 00 00 00 00 
    82d0:	c6 87 c8 ed ff ff 03 	movb   $0x3,-0x1238(%rdi)
    82d7:	c6 87 cc ed ff ff 01 	movb   $0x1,-0x1234(%rdi)
    82de:	89 87 d8 ed ff ff    	mov    %eax,-0x1228(%rdi)
    82e4:	c6 47 f0 03          	movb   $0x3,-0x10(%rdi)
    82e8:	c6 47 f4 01          	movb   $0x1,-0xc(%rdi)
    82ec:	89 07                	mov    %eax,(%rdi)
    82ee:	48 81 c7 50 24 00 00 	add    $0x2450,%rdi
    82f5:	4d 8d 0c 30          	lea    (%r8,%rsi,1),%r9
    82f9:	49 83 c1 02          	add    $0x2,%r9
    82fd:	48 83 c6 02          	add    $0x2,%rsi
    8301:	49 83 f9 01          	cmp    $0x1,%r9
    8305:	75 c9                	jne    82d0 <fwp_gc_alloc_big+0xe0>
    8307:	f6 c2 01             	test   $0x1,%dl
    830a:	74 17                	je     8323 <fwp_gc_alloc_big+0x133>
    830c:	4c 01 e1             	add    %r12,%rcx
    830f:	48 69 d6 28 12 00 00 	imul   $0x1228,%rsi,%rdx
    8316:	c6 04 11 03          	movb   $0x3,(%rcx,%rdx,1)
    831a:	c6 44 11 04 01       	movb   $0x1,0x4(%rcx,%rdx,1)
    831f:	89 44 11 10          	mov    %eax,0x10(%rcx,%rdx,1)
    8323:	48 c1 e0 10          	shl    $0x10,%rax
    8327:	48 03 05 8a 1f 01 00 	add    0x11f8a(%rip),%rax        # 1a2b8 <fwp_gc+0x1030>
    832e:	48 89 c7             	mov    %rax,%rdi
    8331:	31 f6                	xor    %esi,%esi
    8333:	48 89 da             	mov    %rbx,%rdx
    8336:	48 83 c4 08          	add    $0x8,%rsp
    833a:	5b                   	pop    %rbx
    833b:	41 5c                	pop    %r12
    833d:	41 5d                	pop    %r13
    833f:	41 5e                	pop    %r14
    8341:	41 5f                	pop    %r15
    8343:	5d                   	pop    %rbp
    8344:	e9 c7 ae ff ff       	jmp    3210 <memset@plt>
    8349:	4c 89 ff             	mov    %r15,%rdi
    834c:	49 89 c5             	mov    %rax,%r13
    834f:	e8 3c e2 ff ff       	call   6590 <fwp_rc_forget_slot>
    8354:	4c 89 e8             	mov    %r13,%rax
    8357:	e9 1c ff ff ff       	jmp    8278 <fwp_gc_alloc_big+0x88>
    835c:	48 8b 05 75 0c 01 00 	mov    0x10c75(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    8363:	48 8b 08             	mov    (%rax),%rcx
    8366:	48 8d 3d 39 c7 00 00 	lea    0xc739(%rip),%rdi        # 14aa6 <exec_in_fp0+0x296>
    836d:	be 13 00 00 00       	mov    $0x13,%esi
    8372:	ba 01 00 00 00       	mov    $0x1,%edx
    8377:	e8 04 b1 ff ff       	call   3480 <fwrite@plt>
    837c:	bf 66 00 00 00       	mov    $0x66,%edi
    8381:	e8 da b0 ff ff       	call   3460 <exit@plt>
    8386:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    838d:	00 00 00 

0000000000008390 <fwp_gc_spent>:
    8390:	50                   	push   %rax
    8391:	83 3d dc 1e 01 00 00 	cmpl   $0x0,0x11edc(%rip)        # 1a274 <fwp_gc+0xfec>
    8398:	75 05                	jne    839f <fwp_gc_spent+0xf>
    839a:	e8 71 fa ff ff       	call   7e10 <fwp_gc_init>
    839f:	8b 05 d7 1e 01 00    	mov    0x11ed7(%rip),%eax        # 1a27c <fwp_gc+0xff4>
    83a5:	85 c0                	test   %eax,%eax
    83a7:	74 6d                	je     8416 <fwp_gc_spent+0x86>
    83a9:	48 8b 0d f8 1e 01 00 	mov    0x11ef8(%rip),%rcx        # 1a2a8 <fwp_gc+0x1020>
    83b0:	48 85 c9             	test   %rcx,%rcx
    83b3:	74 61                	je     8416 <fwp_gc_spent+0x86>
    83b5:	48 8b 05 f4 1e 01 00 	mov    0x11ef4(%rip),%rax        # 1a2b0 <fwp_gc+0x1028>
    83bc:	48 ff c0             	inc    %rax
    83bf:	48 89 05 ea 1e 01 00 	mov    %rax,0x11eea(%rip)        # 1a2b0 <fwp_gc+0x1028>
    83c6:	48 39 c8             	cmp    %rcx,%rax
    83c9:	7c 10                	jl     83db <fwp_gc_spent+0x4b>
    83cb:	48 c7 05 da 1e 01 00 	movq   $0x0,0x11eda(%rip)        # 1a2b0 <fwp_gc+0x1028>
    83d2:	00 00 00 00 
    83d6:	e8 45 03 00 00       	call   8720 <fwp_gc_collect>
    83db:	48 8b 05 b6 20 01 00 	mov    0x120b6(%rip),%rax        # 1a498 <fwp_gc+0x1210>
    83e2:	48 2b 05 9f 0e 01 00 	sub    0x10e9f(%rip),%rax        # 19288 <fwp_gc>
    83e9:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    83ee:	f2 0f 58 05 7a 20 01 	addsd  0x1207a(%rip),%xmm0        # 1a470 <fwp_gc+0x11e8>
    83f5:	00 
    83f6:	f2 0f 11 05 72 20 01 	movsd  %xmm0,0x12072(%rip)        # 1a470 <fwp_gc+0x11e8>
    83fd:	00 
    83fe:	48 c7 05 8f 20 01 00 	movq   $0x0,0x1208f(%rip)        # 1a498 <fwp_gc+0x1210>
    8405:	00 00 00 00 
    8409:	48 c7 05 74 0e 01 00 	movq   $0x0,0x10e74(%rip)        # 19288 <fwp_gc>
    8410:	00 00 00 00 
    8414:	58                   	pop    %rax
    8415:	c3                   	ret
    8416:	85 c0                	test   %eax,%eax
    8418:	74 06                	je     8420 <fwp_gc_spent+0x90>
    841a:	58                   	pop    %rax
    841b:	e9 00 03 00 00       	jmp    8720 <fwp_gc_collect>
    8420:	48 8b 05 71 20 01 00 	mov    0x12071(%rip),%rax        # 1a498 <fwp_gc+0x1210>
    8427:	48 2b 05 5a 0e 01 00 	sub    0x10e5a(%rip),%rax        # 19288 <fwp_gc>
    842e:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    8433:	f2 0f 58 05 35 20 01 	addsd  0x12035(%rip),%xmm0        # 1a470 <fwp_gc+0x11e8>
    843a:	00 
    843b:	f2 0f 11 05 2d 20 01 	movsd  %xmm0,0x1202d(%rip)        # 1a470 <fwp_gc+0x11e8>
    8442:	00 
    8443:	48 c7 05 4a 20 01 00 	movq   $0x800000,0x1204a(%rip)        # 1a498 <fwp_gc+0x1210>
    844a:	00 00 80 00 
    844e:	48 c7 05 2f 0e 01 00 	movq   $0x800000,0x10e2f(%rip)        # 19288 <fwp_gc>
    8455:	00 00 80 00 
    8459:	58                   	pop    %rax
    845a:	c3                   	ret
    845b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000008460 <fwp_gc_refill>:
    8460:	55                   	push   %rbp
    8461:	41 57                	push   %r15
    8463:	41 56                	push   %r14
    8465:	41 55                	push   %r13
    8467:	41 54                	push   %r12
    8469:	53                   	push   %rbx
    846a:	50                   	push   %rax
    846b:	89 d5                	mov    %edx,%ebp
    846d:	41 89 f7             	mov    %esi,%r15d
    8470:	48 89 fb             	mov    %rdi,%rbx
    8473:	bf 01 00 00 00       	mov    $0x1,%edi
    8478:	e8 13 01 00 00       	call   8590 <fwp_gc_chunks>
    847d:	49 89 c6             	mov    %rax,%r14
    8480:	4c 8b 25 79 1e 01 00 	mov    0x11e79(%rip),%r12        # 1a300 <fwp_gc+0x1078>
    8487:	48 8d 05 fa 0d 01 00 	lea    0x10dfa(%rip),%rax        # 19288 <fwp_gc>
    848e:	4d 69 ee 28 12 00 00 	imul   $0x1228,%r14,%r13
    8495:	43 c6 04 2c 01       	movb   $0x1,(%r12,%r13,1)
    849a:	43 88 6c 2c 01       	mov    %bpl,0x1(%r12,%r13,1)
    849f:	47 88 7c 2c 02       	mov    %r15b,0x2(%r12,%r13,1)
    84a4:	43 c6 44 2c 04 01    	movb   $0x1,0x4(%r12,%r13,1)
    84aa:	44 89 f9             	mov    %r15d,%ecx
    84ad:	8b 8c 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%ecx
    84b4:	43 89 4c 2c 08       	mov    %ecx,0x8(%r12,%r13,1)
    84b9:	b8 00 00 01 00       	mov    $0x10000,%eax
    84be:	31 d2                	xor    %edx,%edx
    84c0:	f7 f1                	div    %ecx
    84c2:	43 89 44 2c 0c       	mov    %eax,0xc(%r12,%r13,1)
    84c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    84cc:	48 01 c8             	add    %rcx,%rax
    84cf:	48 0f ba e0 20       	bt     $0x20,%rax
    84d4:	73 07                	jae    84dd <fwp_gc_refill+0x7d>
    84d6:	31 d2                	xor    %edx,%edx
    84d8:	48 f7 f1             	div    %rcx
    84db:	eb 04                	jmp    84e1 <fwp_gc_refill+0x81>
    84dd:	31 d2                	xor    %edx,%edx
    84df:	f7 f1                	div    %ecx
    84e1:	43 89 44 2c 20       	mov    %eax,0x20(%r12,%r13,1)
    84e6:	48 83 3d b2 27 01 00 	cmpq   $0x0,0x127b2(%rip)        # 1aca0 <fwp_gc+0x1a18>
    84ed:	00 
    84ee:	74 2e                	je     851e <fwp_gc_refill+0xbe>
    84f0:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    84f4:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    84fb:	31 ed                	xor    %ebp,%ebp
    84fd:	eb 0d                	jmp    850c <fwp_gc_refill+0xac>
    84ff:	90                   	nop
    8500:	48 ff c5             	inc    %rbp
    8503:	48 81 fd 00 10 00 00 	cmp    $0x1000,%rbp
    850a:	74 12                	je     851e <fwp_gc_refill+0xbe>
    850c:	41 80 3c 2f ff       	cmpb   $0xff,(%r15,%rbp,1)
    8511:	75 ed                	jne    8500 <fwp_gc_refill+0xa0>
    8513:	49 8d 3c 2f          	lea    (%r15,%rbp,1),%rdi
    8517:	e8 74 e0 ff ff       	call   6590 <fwp_rc_forget_slot>
    851c:	eb e2                	jmp    8500 <fwp_gc_refill+0xa0>
    851e:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    8522:	49 83 c7 08          	add    $0x8,%r15
    8526:	4b 8d 3c 2c          	lea    (%r12,%r13,1),%rdi
    852a:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    8531:	ba 00 10 00 00       	mov    $0x1000,%edx
    8536:	31 f6                	xor    %esi,%esi
    8538:	e8 d3 ac ff ff       	call   3210 <memset@plt>
    853d:	49 c1 e6 10          	shl    $0x10,%r14
    8541:	4c 03 35 70 1d 01 00 	add    0x11d70(%rip),%r14        # 1a2b8 <fwp_gc+0x1030>
    8548:	83 3d 3d 1d 01 00 00 	cmpl   $0x0,0x11d3d(%rip)        # 1a28c <fwp_gc+0x1004>
    854f:	74 0f                	je     8560 <fwp_gc_refill+0x100>
    8551:	ba 00 00 01 00       	mov    $0x10000,%edx
    8556:	4c 89 f7             	mov    %r14,%rdi
    8559:	31 f6                	xor    %esi,%esi
    855b:	e8 b0 ac ff ff       	call   3210 <memset@plt>
    8560:	41 8b 07             	mov    (%r15),%eax
    8563:	49 8d 0c 06          	lea    (%r14,%rax,1),%rcx
    8567:	48 89 4b 08          	mov    %rcx,0x8(%rbx)
    856b:	41 8b 4f 04          	mov    0x4(%r15),%ecx
    856f:	48 0f af c8          	imul   %rax,%rcx
    8573:	4c 01 f1             	add    %r14,%rcx
    8576:	48 89 4b 10          	mov    %rcx,0x10(%rbx)
    857a:	4c 89 f0             	mov    %r14,%rax
    857d:	48 83 c4 08          	add    $0x8,%rsp
    8581:	5b                   	pop    %rbx
    8582:	41 5c                	pop    %r12
    8584:	41 5d                	pop    %r13
    8586:	41 5e                	pop    %r14
    8588:	41 5f                	pop    %r15
    858a:	5d                   	pop    %rbp
    858b:	c3                   	ret
    858c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000008590 <fwp_gc_chunks>:
    8590:	41 57                	push   %r15
    8592:	41 56                	push   %r14
    8594:	53                   	push   %rbx
    8595:	48 89 fb             	mov    %rdi,%rbx
    8598:	31 d2                	xor    %edx,%edx
    859a:	48 83 ff 01          	cmp    $0x1,%rdi
    859e:	0f 95 c2             	setne  %dl
    85a1:	48 8d 0d e0 0c 01 00 	lea    0x10ce0(%rip),%rcx        # 19288 <fwp_gc>
    85a8:	48 8b 84 d1 68 10 00 	mov    0x1068(%rcx,%rdx,8),%rax
    85af:	00 
    85b0:	4c 8b 35 29 1d 01 00 	mov    0x11d29(%rip),%r14        # 1a2e0 <fwp_gc+0x1058>
    85b7:	48 89 c7             	mov    %rax,%rdi
    85ba:	4c 29 f7             	sub    %r14,%rdi
    85bd:	73 63                	jae    8622 <fwp_gc_chunks+0x92>
    85bf:	48 8d 34 d5 68 10 00 	lea    0x1068(,%rdx,8),%rsi
    85c6:	00 
    85c7:	4c 69 c0 28 12 00 00 	imul   $0x1228,%rax,%r8
    85ce:	4c 03 05 2b 1d 01 00 	add    0x11d2b(%rip),%r8        # 1a300 <fwp_gc+0x1078>
    85d5:	31 d2                	xor    %edx,%edx
    85d7:	45 31 c9             	xor    %r9d,%r9d
    85da:	eb 16                	jmp    85f2 <fwp_gc_chunks+0x62>
    85dc:	0f 1f 40 00          	nopl   0x0(%rax)
    85e0:	45 31 c9             	xor    %r9d,%r9d
    85e3:	48 ff ca             	dec    %rdx
    85e6:	49 81 c0 28 12 00 00 	add    $0x1228,%r8
    85ed:	48 39 d7             	cmp    %rdx,%rdi
    85f0:	74 33                	je     8625 <fwp_gc_chunks+0x95>
    85f2:	41 80 38 00          	cmpb   $0x0,(%r8)
    85f6:	75 e8                	jne    85e0 <fwp_gc_chunks+0x50>
    85f8:	49 ff c1             	inc    %r9
    85fb:	49 39 d9             	cmp    %rbx,%r9
    85fe:	75 e3                	jne    85e3 <fwp_gc_chunks+0x53>
    8600:	48 ff c0             	inc    %rax
    8603:	48 89 c7             	mov    %rax,%rdi
    8606:	48 29 d7             	sub    %rdx,%rdi
    8609:	48 89 3c 0e          	mov    %rdi,(%rsi,%rcx,1)
    860d:	48 29 1d 54 1e 01 00 	sub    %rbx,0x11e54(%rip)        # 1a468 <fwp_gc+0x11e0>
    8614:	48 29 d8             	sub    %rbx,%rax
    8617:	48 29 d0             	sub    %rdx,%rax
    861a:	49 89 c6             	mov    %rax,%r14
    861d:	e9 ca 00 00 00       	jmp    86ec <fwp_gc_chunks+0x15c>
    8622:	45 31 c9             	xor    %r9d,%r9d
    8625:	4c 29 0d 3c 1e 01 00 	sub    %r9,0x11e3c(%rip)        # 1a468 <fwp_gc+0x11e0>
    862c:	4d 29 ce             	sub    %r9,%r14
    862f:	4c 01 f3             	add    %r14,%rbx
    8632:	48 8b 3d af 1c 01 00 	mov    0x11caf(%rip),%rdi        # 1a2e8 <fwp_gc+0x1060>
    8639:	48 39 df             	cmp    %rbx,%rdi
    863c:	0f 83 8f 00 00 00    	jae    86d1 <fwp_gc_chunks+0x141>
    8642:	4c 8b 3d 8f 1c 01 00 	mov    0x11c8f(%rip),%r15        # 1a2d8 <fwp_gc+0x1050>
    8649:	49 39 df             	cmp    %rbx,%r15
    864c:	0f 82 a3 00 00 00    	jb     86f5 <fwp_gc_chunks+0x165>
    8652:	48 8d 43 40          	lea    0x40(%rbx),%rax
    8656:	4c 39 f8             	cmp    %r15,%rax
    8659:	4c 0f 42 f8          	cmovb  %rax,%r15
    865d:	4c 89 fe             	mov    %r15,%rsi
    8660:	48 29 fe             	sub    %rdi,%rsi
    8663:	48 c1 e7 10          	shl    $0x10,%rdi
    8667:	48 03 3d 4a 1c 01 00 	add    0x11c4a(%rip),%rdi        # 1a2b8 <fwp_gc+0x1030>
    866e:	48 c1 e6 10          	shl    $0x10,%rsi
    8672:	ba 03 00 00 00       	mov    $0x3,%edx
    8677:	e8 84 ad ff ff       	call   3400 <mprotect@plt>
    867c:	85 c0                	test   %eax,%eax
    867e:	75 75                	jne    86f5 <fwp_gc_chunks+0x165>
    8680:	bf 1e 00 00 00       	mov    $0x1e,%edi
    8685:	e8 96 ad ff ff       	call   3420 <sysconf@plt>
    868a:	48 8b 0d 6f 1c 01 00 	mov    0x11c6f(%rip),%rcx        # 1a300 <fwp_gc+0x1078>
    8691:	48 69 3d 4c 1c 01 00 	imul   $0x1228,0x11c4c(%rip),%rdi        # 1a2e8 <fwp_gc+0x1060>
    8698:	28 12 00 00 
    869c:	48 01 cf             	add    %rcx,%rdi
    869f:	49 69 d7 28 12 00 00 	imul   $0x1228,%r15,%rdx
    86a6:	48 01 ca             	add    %rcx,%rdx
    86a9:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    86ad:	48 ff ce             	dec    %rsi
    86b0:	48 f7 d8             	neg    %rax
    86b3:	48 21 c7             	and    %rax,%rdi
    86b6:	48 21 c6             	and    %rax,%rsi
    86b9:	48 29 fe             	sub    %rdi,%rsi
    86bc:	ba 03 00 00 00       	mov    $0x3,%edx
    86c1:	e8 3a ad ff ff       	call   3400 <mprotect@plt>
    86c6:	85 c0                	test   %eax,%eax
    86c8:	75 2b                	jne    86f5 <fwp_gc_chunks+0x165>
    86ca:	4c 89 3d 17 1c 01 00 	mov    %r15,0x11c17(%rip)        # 1a2e8 <fwp_gc+0x1060>
    86d1:	48 89 1d 08 1c 01 00 	mov    %rbx,0x11c08(%rip)        # 1a2e0 <fwp_gc+0x1058>
    86d8:	48 c1 e3 10          	shl    $0x10,%rbx
    86dc:	48 3b 1d ed 1b 01 00 	cmp    0x11bed(%rip),%rbx        # 1a2d0 <fwp_gc+0x1048>
    86e3:	76 07                	jbe    86ec <fwp_gc_chunks+0x15c>
    86e5:	48 89 1d e4 1b 01 00 	mov    %rbx,0x11be4(%rip)        # 1a2d0 <fwp_gc+0x1048>
    86ec:	4c 89 f0             	mov    %r14,%rax
    86ef:	5b                   	pop    %rbx
    86f0:	41 5e                	pop    %r14
    86f2:	41 5f                	pop    %r15
    86f4:	c3                   	ret
    86f5:	48 8b 05 dc 08 01 00 	mov    0x108dc(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    86fc:	48 8b 08             	mov    (%rax),%rcx
    86ff:	48 8d 3d a0 c3 00 00 	lea    0xc3a0(%rip),%rdi        # 14aa6 <exec_in_fp0+0x296>
    8706:	be 13 00 00 00       	mov    $0x13,%esi
    870b:	ba 01 00 00 00       	mov    $0x1,%edx
    8710:	e8 6b ad ff ff       	call   3480 <fwrite@plt>
    8715:	bf 66 00 00 00       	mov    $0x66,%edi
    871a:	e8 41 ad ff ff       	call   3460 <exit@plt>
    871f:	90                   	nop

0000000000008720 <fwp_gc_collect>:
    8720:	55                   	push   %rbp
    8721:	48 89 e5             	mov    %rsp,%rbp
    8724:	41 57                	push   %r15
    8726:	41 56                	push   %r14
    8728:	41 55                	push   %r13
    872a:	41 54                	push   %r12
    872c:	53                   	push   %rbx
    872d:	48 81 ec a8 01 00 00 	sub    $0x1a8,%rsp
    8734:	83 3d 45 1b 01 00 00 	cmpl   $0x0,0x11b45(%rip)        # 1a280 <fwp_gc+0xff8>
    873b:	0f 85 a5 04 00 00    	jne    8be6 <fwp_gc_collect+0x4c6>
    8741:	c7 05 35 1b 01 00 01 	movl   $0x1,0x11b35(%rip)        # 1a280 <fwp_gc+0xff8>
    8748:	00 00 00 
    874b:	48 8d b5 20 ff ff ff 	lea    -0xe0(%rbp),%rsi
    8752:	bf 01 00 00 00       	mov    $0x1,%edi
    8757:	e8 d4 a9 ff ff       	call   3130 <clock_gettime@plt>
    875c:	48 8b 05 35 1d 01 00 	mov    0x11d35(%rip),%rax        # 1a498 <fwp_gc+0x1210>
    8763:	48 2b 05 1e 0b 01 00 	sub    0x10b1e(%rip),%rax        # 19288 <fwp_gc>
    876a:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    876f:	f2 0f 58 05 f9 1c 01 	addsd  0x11cf9(%rip),%xmm0        # 1a470 <fwp_gc+0x11e8>
    8776:	00 
    8777:	f2 0f 11 05 f1 1c 01 	movsd  %xmm0,0x11cf1(%rip)        # 1a470 <fwp_gc+0x11e8>
    877e:	00 
    877f:	83 3d 02 1b 01 00 00 	cmpl   $0x0,0x11b02(%rip)        # 1a288 <fwp_gc+0x1000>
    8786:	0f 94 c0             	sete   %al
    8789:	83 3d 00 1b 01 00 00 	cmpl   $0x0,0x11b00(%rip)        # 1a290 <fwp_gc+0x1008>
    8790:	41 0f 95 c4          	setne  %r12b
    8794:	41 08 c4             	or     %al,%r12b
    8797:	41 80 fc 01          	cmp    $0x1,%r12b
    879b:	0f 85 8f 00 00 00    	jne    8830 <fwp_gc_collect+0x110>
    87a1:	48 8b 05 38 1b 01 00 	mov    0x11b38(%rip),%rax        # 1a2e0 <fwp_gc+0x1058>
    87a8:	48 85 c0             	test   %rax,%rax
    87ab:	0f 84 c4 01 00 00    	je     8975 <fwp_gc_collect+0x255>
    87b1:	48 8b 15 48 1b 01 00 	mov    0x11b48(%rip),%rdx        # 1a300 <fwp_gc+0x1078>
    87b8:	31 db                	xor    %ebx,%ebx
    87ba:	41 89 df             	mov    %ebx,%r15d
    87bd:	4d 89 fe             	mov    %r15,%r14
    87c0:	48 89 c1             	mov    %rax,%rcx
    87c3:	48 89 d0             	mov    %rdx,%rax
    87c6:	eb 2a                	jmp    87f2 <fwp_gc_collect+0xd2>
    87c8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    87cf:	00 
    87d0:	42 c6 44 38 03 00    	movb   $0x0,0x3(%rax,%r15,1)
    87d6:	48 89 ca             	mov    %rcx,%rdx
    87d9:	4c 89 f6             	mov    %r14,%rsi
    87dc:	48 ff c6             	inc    %rsi
    87df:	49 81 c7 28 12 00 00 	add    $0x1228,%r15
    87e6:	49 89 f6             	mov    %rsi,%r14
    87e9:	48 39 ce             	cmp    %rcx,%rsi
    87ec:	0f 83 83 01 00 00    	jae    8975 <fwp_gc_collect+0x255>
    87f2:	42 0f b6 14 38       	movzbl (%rax,%r15,1),%edx
    87f7:	83 fa 02             	cmp    $0x2,%edx
    87fa:	74 d4                	je     87d0 <fwp_gc_collect+0xb0>
    87fc:	83 fa 01             	cmp    $0x1,%edx
    87ff:	75 d5                	jne    87d6 <fwp_gc_collect+0xb6>
    8801:	4a 8d 3c 38          	lea    (%rax,%r15,1),%rdi
    8805:	48 83 c7 28          	add    $0x28,%rdi
    8809:	42 8b 44 38 0c       	mov    0xc(%rax,%r15,1),%eax
    880e:	83 c0 3f             	add    $0x3f,%eax
    8811:	c1 e8 03             	shr    $0x3,%eax
    8814:	83 e0 f8             	and    $0xfffffff8,%eax
    8817:	89 c2                	mov    %eax,%edx
    8819:	89 de                	mov    %ebx,%esi
    881b:	e8 f0 a9 ff ff       	call   3210 <memset@plt>
    8820:	48 8b 05 d9 1a 01 00 	mov    0x11ad9(%rip),%rax        # 1a300 <fwp_gc+0x1078>
    8827:	48 8b 0d b2 1a 01 00 	mov    0x11ab2(%rip),%rcx        # 1a2e0 <fwp_gc+0x1058>
    882e:	eb a6                	jmp    87d6 <fwp_gc_collect+0xb6>
    8830:	44 88 65 d7          	mov    %r12b,-0x29(%rbp)
    8834:	48 8d bd 50 fe ff ff 	lea    -0x1b0(%rbp),%rdi
    883b:	e8 70 aa ff ff       	call   32b0 <_setjmp@plt>
    8840:	48 c7 05 3d 1c 01 00 	movq   $0x0,0x11c3d(%rip)        # 1a488 <fwp_gc+0x1200>
    8847:	00 00 00 00 
    884b:	e8 10 08 00 00       	call   9060 <fwp_gc_mark_all>
    8850:	48 83 3d 88 1a 01 00 	cmpq   $0x0,0x11a88(%rip)        # 1a2e0 <fwp_gc+0x1058>
    8857:	00 
    8858:	0f 84 53 01 00 00    	je     89b1 <fwp_gc_collect+0x291>
    885e:	31 c0                	xor    %eax,%eax
    8860:	eb 25                	jmp    8887 <fwp_gc_collect+0x167>
    8862:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8869:	1f 84 00 00 00 00 00 
    8870:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
    8874:	48 ff c1             	inc    %rcx
    8877:	48 89 c8             	mov    %rcx,%rax
    887a:	48 3b 0d 5f 1a 01 00 	cmp    0x11a5f(%rip),%rcx        # 1a2e0 <fwp_gc+0x1058>
    8881:	0f 83 2a 01 00 00    	jae    89b1 <fwp_gc_collect+0x291>
    8887:	48 8b 1d 72 1a 01 00 	mov    0x11a72(%rip),%rbx        # 1a300 <fwp_gc+0x1078>
    888e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    8892:	48 69 c0 28 12 00 00 	imul   $0x1228,%rax,%rax
    8899:	80 7c 03 01 02       	cmpb   $0x2,0x1(%rbx,%rax,1)
    889e:	75 d0                	jne    8870 <fwp_gc_collect+0x150>
    88a0:	0f b6 0c 03          	movzbl (%rbx,%rax,1),%ecx
    88a4:	83 f9 02             	cmp    $0x2,%ecx
    88a7:	0f 84 9f 00 00 00    	je     894c <fwp_gc_collect+0x22c>
    88ad:	83 f9 01             	cmp    $0x1,%ecx
    88b0:	75 be                	jne    8870 <fwp_gc_collect+0x150>
    88b2:	8b 4c 03 0c          	mov    0xc(%rbx,%rax,1),%ecx
    88b6:	83 c1 3f             	add    $0x3f,%ecx
    88b9:	83 f9 40             	cmp    $0x40,%ecx
    88bc:	72 b2                	jb     8870 <fwp_gc_collect+0x150>
    88be:	4c 8b 7d c0          	mov    -0x40(%rbp),%r15
    88c2:	49 c1 e7 10          	shl    $0x10,%r15
    88c6:	4c 03 3d eb 19 01 00 	add    0x119eb(%rip),%r15        # 1a2b8 <fwp_gc+0x1030>
    88cd:	c1 e9 06             	shr    $0x6,%ecx
    88d0:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    88d4:	4c 8d 2c 03          	lea    (%rbx,%rax,1),%r13
    88d8:	49 83 c5 08          	add    $0x8,%r13
    88dc:	31 c9                	xor    %ecx,%ecx
    88de:	41 89 cc             	mov    %ecx,%r12d
    88e1:	48 01 c3             	add    %rax,%rbx
    88e4:	48 89 5d 98          	mov    %rbx,-0x68(%rbp)
    88e8:	eb 1a                	jmp    8904 <fwp_gc_collect+0x1e4>
    88ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    88f0:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    88f4:	48 ff c0             	inc    %rax
    88f7:	49 89 c4             	mov    %rax,%r12
    88fa:	48 3b 45 90          	cmp    -0x70(%rbp),%rax
    88fe:	0f 84 6c ff ff ff    	je     8870 <fwp_gc_collect+0x150>
    8904:	48 8b 45 98          	mov    -0x68(%rbp),%rax
    8908:	4c 89 65 b0          	mov    %r12,-0x50(%rbp)
    890c:	4e 8b 64 e0 28       	mov    0x28(%rax,%r12,8),%r12
    8911:	4d 85 e4             	test   %r12,%r12
    8914:	74 da                	je     88f0 <fwp_gc_collect+0x1d0>
    8916:	4c 8b 75 b0          	mov    -0x50(%rbp),%r14
    891a:	49 c1 e6 06          	shl    $0x6,%r14
    891e:	66 90                	xchg   %ax,%ax
    8920:	f3 49 0f bc c4       	tzcnt  %r12,%rax
    8925:	4c 09 f0             	or     %r14,%rax
    8928:	49 8d 5c 24 ff       	lea    -0x1(%r12),%rbx
    892d:	41 8b 4d 00          	mov    0x0(%r13),%ecx
    8931:	89 ce                	mov    %ecx,%esi
    8933:	48 0f af c6          	imul   %rsi,%rax
    8937:	48 89 c7             	mov    %rax,%rdi
    893a:	4c 01 ff             	add    %r15,%rdi
    893d:	e8 4e 13 00 00       	call   9c90 <fwp_gc_push>
    8942:	4c 21 e3             	and    %r12,%rbx
    8945:	49 89 dc             	mov    %rbx,%r12
    8948:	75 d6                	jne    8920 <fwp_gc_collect+0x200>
    894a:	eb a4                	jmp    88f0 <fwp_gc_collect+0x1d0>
    894c:	80 7c 03 03 00       	cmpb   $0x0,0x3(%rbx,%rax,1)
    8951:	0f 84 19 ff ff ff    	je     8870 <fwp_gc_collect+0x150>
    8957:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
    895b:	48 c1 e7 10          	shl    $0x10,%rdi
    895f:	48 03 3d 52 19 01 00 	add    0x11952(%rip),%rdi        # 1a2b8 <fwp_gc+0x1030>
    8966:	48 8b 74 03 18       	mov    0x18(%rbx,%rax,1),%rsi
    896b:	e8 20 13 00 00       	call   9c90 <fwp_gc_push>
    8970:	e9 fb fe ff ff       	jmp    8870 <fwp_gc_collect+0x150>
    8975:	48 8d bd 50 fe ff ff 	lea    -0x1b0(%rbp),%rdi
    897c:	e8 2f a9 ff ff       	call   32b0 <_setjmp@plt>
    8981:	48 c7 05 fc 1a 01 00 	movq   $0x0,0x11afc(%rip)        # 1a488 <fwp_gc+0x1200>
    8988:	00 00 00 00 
    898c:	e8 cf 06 00 00       	call   9060 <fwp_gc_mark_all>
    8991:	e8 0a 08 00 00       	call   91a0 <fwp_gc_finalize>
    8996:	e8 35 09 00 00       	call   92d0 <fwp_gc_sweep>
    899b:	48 8b 05 be 1a 01 00 	mov    0x11abe(%rip),%rax        # 1a460 <fwp_gc+0x11d8>
    89a2:	48 ff c0             	inc    %rax
    89a5:	48 89 05 b4 1a 01 00 	mov    %rax,0x11ab4(%rip)        # 1a460 <fwp_gc+0x11d8>
    89ac:	e9 0d 01 00 00       	jmp    8abe <fwp_gc_collect+0x39e>
    89b1:	48 8b 05 70 1a 01 00 	mov    0x11a70(%rip),%rax        # 1a428 <fwp_gc+0x11a0>
    89b8:	48 85 c0             	test   %rax,%rax
    89bb:	74 3a                	je     89f7 <fwp_gc_collect+0x2d7>
    89bd:	31 db                	xor    %ebx,%ebx
    89bf:	90                   	nop
    89c0:	48 8b 0d 59 1a 01 00 	mov    0x11a59(%rip),%rcx        # 1a420 <fwp_gc+0x1198>
    89c7:	48 ff c8             	dec    %rax
    89ca:	48 89 05 57 1a 01 00 	mov    %rax,0x11a57(%rip)        # 1a428 <fwp_gc+0x11a0>
    89d1:	48 c1 e0 04          	shl    $0x4,%rax
    89d5:	48 8b 3c 01          	mov    (%rcx,%rax,1),%rdi
    89d9:	48 8b 74 01 08       	mov    0x8(%rcx,%rax,1),%rsi
    89de:	48 01 fe             	add    %rdi,%rsi
    89e1:	89 da                	mov    %ebx,%edx
    89e3:	e8 88 0f 00 00       	call   9970 <fwp_gc_scan>
    89e8:	48 8b 0d 39 1a 01 00 	mov    0x11a39(%rip),%rcx        # 1a428 <fwp_gc+0x11a0>
    89ef:	48 89 c8             	mov    %rcx,%rax
    89f2:	48 85 c9             	test   %rcx,%rcx
    89f5:	75 c9                	jne    89c0 <fwp_gc_collect+0x2a0>
    89f7:	83 3d 8e 18 01 00 00 	cmpl   $0x0,0x1188e(%rip)        # 1a28c <fwp_gc+0x1004>
    89fe:	44 0f b6 65 d7       	movzbl -0x29(%rbp),%r12d
    8a03:	0f 84 93 00 00 00    	je     8a9c <fwp_gc_collect+0x37c>
    8a09:	4c 8b 35 d0 18 01 00 	mov    0x118d0(%rip),%r14        # 1a2e0 <fwp_gc+0x1058>
    8a10:	4c 89 f7             	mov    %r14,%rdi
    8a13:	48 c1 e7 09          	shl    $0x9,%rdi
    8a17:	e8 24 a9 ff ff       	call   3340 <malloc@plt>
    8a1c:	48 89 c3             	mov    %rax,%rbx
    8a1f:	49 83 fe 01          	cmp    $0x1,%r14
    8a23:	4c 89 f7             	mov    %r14,%rdi
    8a26:	48 83 d7 00          	adc    $0x0,%rdi
    8a2a:	48 89 bd 40 ff ff ff 	mov    %rdi,-0xc0(%rbp)
    8a31:	e8 0a a9 ff ff       	call   3340 <malloc@plt>
    8a36:	48 89 5d c8          	mov    %rbx,-0x38(%rbp)
    8a3a:	48 85 db             	test   %rbx,%rbx
    8a3d:	0f 84 ea 05 00 00    	je     902d <fwp_gc_collect+0x90d>
    8a43:	48 85 c0             	test   %rax,%rax
    8a46:	0f 84 e1 05 00 00    	je     902d <fwp_gc_collect+0x90d>
    8a4c:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
    8a50:	48 89 4d a0          	mov    %rcx,-0x60(%rbp)
    8a54:	49 89 c5             	mov    %rax,%r13
    8a57:	4d 85 f6             	test   %r14,%r14
    8a5a:	74 2a                	je     8a86 <fwp_gc_collect+0x366>
    8a5c:	4c 89 6d b8          	mov    %r13,-0x48(%rbp)
    8a60:	48 8b 0d 99 18 01 00 	mov    0x11899(%rip),%rcx        # 1a300 <fwp_gc+0x1078>
    8a67:	49 83 fe 01          	cmp    $0x1,%r14
    8a6b:	4c 89 b5 48 ff ff ff 	mov    %r14,-0xb8(%rbp)
    8a72:	48 89 8d 70 ff ff ff 	mov    %rcx,-0x90(%rbp)
    8a79:	0f 85 79 01 00 00    	jne    8bf8 <fwp_gc_collect+0x4d8>
    8a7f:	31 c0                	xor    %eax,%eax
    8a81:	e9 f8 01 00 00       	jmp    8c7e <fwp_gc_collect+0x55e>
    8a86:	e8 d5 05 00 00       	call   9060 <fwp_gc_mark_all>
    8a8b:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
    8a8f:	e8 bc a5 ff ff       	call   3050 <free@plt>
    8a94:	4c 89 ef             	mov    %r13,%rdi
    8a97:	e8 b4 a5 ff ff       	call   3050 <free@plt>
    8a9c:	e8 ff 06 00 00       	call   91a0 <fwp_gc_finalize>
    8aa1:	e8 2a 08 00 00       	call   92d0 <fwp_gc_sweep>
    8aa6:	48 8b 05 b3 19 01 00 	mov    0x119b3(%rip),%rax        # 1a460 <fwp_gc+0x11d8>
    8aad:	48 ff c0             	inc    %rax
    8ab0:	48 89 05 a9 19 01 00 	mov    %rax,0x119a9(%rip)        # 1a460 <fwp_gc+0x11d8>
    8ab7:	48 ff 05 e2 17 01 00 	incq   0x117e2(%rip)        # 1a2a0 <fwp_gc+0x1018>
    8abe:	48 89 c1             	mov    %rax,%rcx
    8ac1:	48 8b 05 88 19 01 00 	mov    0x11988(%rip),%rax        # 1a450 <fwp_gc+0x11c8>
    8ac8:	48 3b 05 89 19 01 00 	cmp    0x11989(%rip),%rax        # 1a458 <fwp_gc+0x11d0>
    8acf:	76 07                	jbe    8ad8 <fwp_gc_collect+0x3b8>
    8ad1:	48 89 05 80 19 01 00 	mov    %rax,0x11980(%rip)        # 1a458 <fwp_gc+0x11d0>
    8ad8:	45 84 e4             	test   %r12b,%r12b
    8adb:	74 0b                	je     8ae8 <fwp_gc_collect+0x3c8>
    8add:	48 89 05 b4 17 01 00 	mov    %rax,0x117b4(%rip)        # 1a298 <fwp_gc+0x1010>
    8ae4:	31 d2                	xor    %edx,%edx
    8ae6:	eb 2d                	jmp    8b15 <fwp_gc_collect+0x3f5>
    8ae8:	48 8b 15 a9 17 01 00 	mov    0x117a9(%rip),%rdx        # 1a298 <fwp_gc+0x1010>
    8aef:	48 89 d6             	mov    %rdx,%rsi
    8af2:	48 d1 ee             	shr    $1,%rsi
    8af5:	48 01 d6             	add    %rdx,%rsi
    8af8:	48 81 fe 01 00 00 01 	cmp    $0x1000001,%rsi
    8aff:	ba 00 00 00 01       	mov    $0x1000000,%edx
    8b04:	48 0f 43 d6          	cmovae %rsi,%rdx
    8b08:	31 f6                	xor    %esi,%esi
    8b0a:	48 39 d0             	cmp    %rdx,%rax
    8b0d:	0f 97 c2             	seta   %dl
    8b10:	40 88 d6             	mov    %dl,%sil
    8b13:	89 f2                	mov    %esi,%edx
    8b15:	f6 c1 07             	test   $0x7,%cl
    8b18:	b9 01 00 00 00       	mov    $0x1,%ecx
    8b1d:	0f 45 ca             	cmovne %edx,%ecx
    8b20:	48 83 3d 80 17 01 00 	cmpq   $0x0,0x11780(%rip)        # 1a2a8 <fwp_gc+0x1020>
    8b27:	00 
    8b28:	0f 44 ca             	cmove  %edx,%ecx
    8b2b:	89 0d 5f 17 01 00    	mov    %ecx,0x1175f(%rip)        # 1a290 <fwp_gc+0x1008>
    8b31:	83 3d 50 17 01 00 00 	cmpl   $0x0,0x11750(%rip)        # 1a288 <fwp_gc+0x1000>
    8b38:	0f 94 c1             	sete   %cl
    8b3b:	48 d3 e0             	shl    %cl,%rax
    8b3e:	f2 48 0f 2c 0d 41 19 	cvttsd2si 0x11941(%rip),%rcx        # 1a488 <fwp_gc+0x1200>
    8b45:	01 00 
    8b47:	48 01 c1             	add    %rax,%rcx
    8b4a:	48 81 f9 01 00 80 00 	cmp    $0x800001,%rcx
    8b51:	b8 00 00 80 00       	mov    $0x800000,%eax
    8b56:	48 0f 4d c1          	cmovge %rcx,%rax
    8b5a:	48 89 05 37 19 01 00 	mov    %rax,0x11937(%rip)        # 1a498 <fwp_gc+0x1210>
    8b61:	48 89 05 20 07 01 00 	mov    %rax,0x10720(%rip)        # 19288 <fwp_gc>
    8b68:	48 8d b5 30 ff ff ff 	lea    -0xd0(%rbp),%rsi
    8b6f:	bf 01 00 00 00       	mov    $0x1,%edi
    8b74:	e8 b7 a5 ff ff       	call   3130 <clock_gettime@plt>
    8b79:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    8b80:	48 8b 8d 38 ff ff ff 	mov    -0xc8(%rbp),%rcx
    8b87:	48 2b 85 20 ff ff ff 	sub    -0xe0(%rbp),%rax
    8b8e:	f2 48 0f 2a c8       	cvtsi2sd %rax,%xmm1
    8b93:	f2 0f 59 0d 15 b6 00 	mulsd  0xb615(%rip),%xmm1        # 141b0 <_IO_stdin_used+0x1b0>
    8b9a:	00 
    8b9b:	48 2b 8d 28 ff ff ff 	sub    -0xd8(%rbp),%rcx
    8ba2:	0f 57 c0             	xorps  %xmm0,%xmm0
    8ba5:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    8baa:	f2 0f 5e 05 06 b6 00 	divsd  0xb606(%rip),%xmm0        # 141b8 <_IO_stdin_used+0x1b8>
    8bb1:	00 
    8bb2:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
    8bb6:	f2 0f 10 0d ba 18 01 	movsd  0x118ba(%rip),%xmm1        # 1a478 <fwp_gc+0x11f0>
    8bbd:	00 
    8bbe:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
    8bc2:	f2 0f 11 0d ae 18 01 	movsd  %xmm1,0x118ae(%rip)        # 1a478 <fwp_gc+0x11f0>
    8bc9:	00 
    8bca:	66 0f 2e 05 ae 18 01 	ucomisd 0x118ae(%rip),%xmm0        # 1a480 <fwp_gc+0x11f8>
    8bd1:	00 
    8bd2:	76 08                	jbe    8bdc <fwp_gc_collect+0x4bc>
    8bd4:	f2 0f 11 05 a4 18 01 	movsd  %xmm0,0x118a4(%rip)        # 1a480 <fwp_gc+0x11f8>
    8bdb:	00 
    8bdc:	c7 05 9a 16 01 00 00 	movl   $0x0,0x1169a(%rip)        # 1a280 <fwp_gc+0xff8>
    8be3:	00 00 00 
    8be6:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    8bed:	5b                   	pop    %rbx
    8bee:	41 5c                	pop    %r12
    8bf0:	41 5d                	pop    %r13
    8bf2:	41 5e                	pop    %r14
    8bf4:	41 5f                	pop    %r15
    8bf6:	5d                   	pop    %rbp
    8bf7:	c3                   	ret
    8bf8:	49 83 e6 fe          	and    $0xfffffffffffffffe,%r14
    8bfc:	4c 89 75 88          	mov    %r14,-0x78(%rbp)
    8c00:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    8c04:	48 8d 98 00 02 00 00 	lea    0x200(%rax),%rbx
    8c0b:	4c 8d a1 50 12 00 00 	lea    0x1250(%rcx),%r12
    8c12:	31 c0                	xor    %eax,%eax
    8c14:	89 c1                	mov    %eax,%ecx
    8c16:	41 bd 00 02 00 00    	mov    $0x200,%r13d
    8c1c:	4c 8b 75 b8          	mov    -0x48(%rbp),%r14
    8c20:	49 89 cf             	mov    %rcx,%r15
    8c23:	48 8d bb 00 fe ff ff 	lea    -0x200(%rbx),%rdi
    8c2a:	49 8d b4 24 d8 ed ff 	lea    -0x1228(%r12),%rsi
    8c31:	ff 
    8c32:	4c 89 ea             	mov    %r13,%rdx
    8c35:	e8 f6 a6 ff ff       	call   3330 <memcpy@plt>
    8c3a:	41 0f b6 84 24 b3 ed 	movzbl -0x124d(%r12),%eax
    8c41:	ff ff 
    8c43:	43 88 04 3e          	mov    %al,(%r14,%r15,1)
    8c47:	48 89 df             	mov    %rbx,%rdi
    8c4a:	4c 89 e6             	mov    %r12,%rsi
    8c4d:	4c 89 ea             	mov    %r13,%rdx
    8c50:	e8 db a6 ff ff       	call   3330 <memcpy@plt>
    8c55:	41 0f b6 44 24 db    	movzbl -0x25(%r12),%eax
    8c5b:	43 88 44 3e 01       	mov    %al,0x1(%r14,%r15,1)
    8c60:	49 83 c7 02          	add    $0x2,%r15
    8c64:	48 81 c3 00 04 00 00 	add    $0x400,%rbx
    8c6b:	49 81 c4 50 24 00 00 	add    $0x2450,%r12
    8c72:	4c 89 f8             	mov    %r15,%rax
    8c75:	4c 89 f9             	mov    %r15,%rcx
    8c78:	4c 39 7d 88          	cmp    %r15,-0x78(%rbp)
    8c7c:	75 a2                	jne    8c20 <fwp_gc_collect+0x500>
    8c7e:	48 89 c3             	mov    %rax,%rbx
    8c81:	4c 8b bd 48 ff ff ff 	mov    -0xb8(%rbp),%r15
    8c88:	44 89 f8             	mov    %r15d,%eax
    8c8b:	41 f6 c7 01          	test   $0x1,%r15b
    8c8f:	44 0f b6 65 d7       	movzbl -0x29(%rbp),%r12d
    8c94:	48 8b 95 70 ff ff ff 	mov    -0x90(%rbp),%rdx
    8c9b:	74 37                	je     8cd4 <fwp_gc_collect+0x5b4>
    8c9d:	48 89 df             	mov    %rbx,%rdi
    8ca0:	48 c1 e7 09          	shl    $0x9,%rdi
    8ca4:	48 03 7d c8          	add    -0x38(%rbp),%rdi
    8ca8:	4c 69 f3 28 12 00 00 	imul   $0x1228,%rbx,%r14
    8caf:	4a 8d 34 32          	lea    (%rdx,%r14,1),%rsi
    8cb3:	48 83 c6 28          	add    $0x28,%rsi
    8cb7:	49 89 d5             	mov    %rdx,%r13
    8cba:	ba 00 02 00 00       	mov    $0x200,%edx
    8cbf:	e8 6c a6 ff ff       	call   3330 <memcpy@plt>
    8cc4:	4c 89 ea             	mov    %r13,%rdx
    8cc7:	43 0f b6 44 35 03    	movzbl 0x3(%r13,%r14,1),%eax
    8ccd:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
    8cd1:	88 04 19             	mov    %al,(%rcx,%rbx,1)
    8cd4:	45 31 ed             	xor    %r13d,%r13d
    8cd7:	45 89 ee             	mov    %r13d,%r14d
    8cda:	4c 89 f3             	mov    %r14,%rbx
    8cdd:	4c 89 f9             	mov    %r15,%rcx
    8ce0:	48 89 d0             	mov    %rdx,%rax
    8ce3:	eb 29                	jmp    8d0e <fwp_gc_collect+0x5ee>
    8ce5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    8cec:	00 00 00 00 
    8cf0:	42 c6 44 30 03 00    	movb   $0x0,0x3(%rax,%r14,1)
    8cf6:	48 89 ca             	mov    %rcx,%rdx
    8cf9:	48 89 de             	mov    %rbx,%rsi
    8cfc:	48 ff c6             	inc    %rsi
    8cff:	49 81 c6 28 12 00 00 	add    $0x1228,%r14
    8d06:	48 89 f3             	mov    %rsi,%rbx
    8d09:	48 39 ce             	cmp    %rcx,%rsi
    8d0c:	73 3f                	jae    8d4d <fwp_gc_collect+0x62d>
    8d0e:	42 0f b6 14 30       	movzbl (%rax,%r14,1),%edx
    8d13:	83 fa 02             	cmp    $0x2,%edx
    8d16:	74 d8                	je     8cf0 <fwp_gc_collect+0x5d0>
    8d18:	83 fa 01             	cmp    $0x1,%edx
    8d1b:	75 d9                	jne    8cf6 <fwp_gc_collect+0x5d6>
    8d1d:	4a 8d 3c 30          	lea    (%rax,%r14,1),%rdi
    8d21:	48 83 c7 28          	add    $0x28,%rdi
    8d25:	42 8b 44 30 0c       	mov    0xc(%rax,%r14,1),%eax
    8d2a:	83 c0 3f             	add    $0x3f,%eax
    8d2d:	c1 e8 03             	shr    $0x3,%eax
    8d30:	83 e0 f8             	and    $0xfffffff8,%eax
    8d33:	89 c2                	mov    %eax,%edx
    8d35:	44 89 ee             	mov    %r13d,%esi
    8d38:	e8 d3 a4 ff ff       	call   3210 <memset@plt>
    8d3d:	48 8b 05 bc 15 01 00 	mov    0x115bc(%rip),%rax        # 1a300 <fwp_gc+0x1078>
    8d44:	48 8b 0d 95 15 01 00 	mov    0x11595(%rip),%rcx        # 1a2e0 <fwp_gc+0x1058>
    8d4b:	eb a9                	jmp    8cf6 <fwp_gc_collect+0x5d6>
    8d4d:	e8 0e 03 00 00       	call   9060 <fwp_gc_mark_all>
    8d52:	48 8b 05 a7 15 01 00 	mov    0x115a7(%rip),%rax        # 1a300 <fwp_gc+0x1078>
    8d59:	48 8d 78 28          	lea    0x28(%rax),%rdi
    8d5d:	31 d2                	xor    %edx,%edx
    8d5f:	89 d6                	mov    %edx,%esi
    8d61:	4c 8b 45 a0          	mov    -0x60(%rbp),%r8
    8d65:	4c 8b 6d b8          	mov    -0x48(%rbp),%r13
    8d69:	eb 35                	jmp    8da0 <fwp_gc_collect+0x680>
    8d6b:	4d 85 db             	test   %r11,%r11
    8d6e:	0f 85 c8 00 00 00    	jne    8e3c <fwp_gc_collect+0x71c>
    8d74:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    8d7b:	00 00 00 00 00 
    8d80:	48 89 f1             	mov    %rsi,%rcx
    8d83:	48 ff c1             	inc    %rcx
    8d86:	49 81 c0 00 02 00 00 	add    $0x200,%r8
    8d8d:	48 81 c7 28 12 00 00 	add    $0x1228,%rdi
    8d94:	48 89 ce             	mov    %rcx,%rsi
    8d97:	4c 39 f9             	cmp    %r15,%rcx
    8d9a:	0f 84 eb fc ff ff    	je     8a8b <fwp_gc_collect+0x36b>
    8da0:	48 69 ce 28 12 00 00 	imul   $0x1228,%rsi,%rcx
    8da7:	44 0f b6 0c 08       	movzbl (%rax,%rcx,1),%r9d
    8dac:	41 83 f9 02          	cmp    $0x2,%r9d
    8db0:	74 5e                	je     8e10 <fwp_gc_collect+0x6f0>
    8db2:	41 83 f9 01          	cmp    $0x1,%r9d
    8db6:	75 c8                	jne    8d80 <fwp_gc_collect+0x660>
    8db8:	44 8b 4c 08 0c       	mov    0xc(%rax,%rcx,1),%r9d
    8dbd:	41 83 c1 3f          	add    $0x3f,%r9d
    8dc1:	41 83 f9 40          	cmp    $0x40,%r9d
    8dc5:	72 b9                	jb     8d80 <fwp_gc_collect+0x660>
    8dc7:	41 c1 e9 06          	shr    $0x6,%r9d
    8dcb:	49 c7 c6 c0 ff ff ff 	mov    $0xffffffffffffffc0,%r14
    8dd2:	89 d3                	mov    %edx,%ebx
    8dd4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    8ddb:	00 00 00 00 00 
    8de0:	4d 89 f2             	mov    %r14,%r10
    8de3:	4d 8b 1c d8          	mov    (%r8,%rbx,8),%r11
    8de7:	49 f7 d3             	not    %r11
    8dea:	4c 23 1c df          	and    (%rdi,%rbx,8),%r11
    8dee:	48 ff c3             	inc    %rbx
    8df1:	49 83 c2 40          	add    $0x40,%r10
    8df5:	4c 39 cb             	cmp    %r9,%rbx
    8df8:	0f 83 6d ff ff ff    	jae    8d6b <fwp_gc_collect+0x64b>
    8dfe:	4d 89 d6             	mov    %r10,%r14
    8e01:	4d 85 db             	test   %r11,%r11
    8e04:	74 da                	je     8de0 <fwp_gc_collect+0x6c0>
    8e06:	e9 60 ff ff ff       	jmp    8d6b <fwp_gc_collect+0x64b>
    8e0b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8e10:	80 7c 08 03 00       	cmpb   $0x0,0x3(%rax,%rcx,1)
    8e15:	0f 84 65 ff ff ff    	je     8d80 <fwp_gc_collect+0x660>
    8e1b:	41 80 7c 35 00 00    	cmpb   $0x0,0x0(%r13,%rsi,1)
    8e21:	0f 85 59 ff ff ff    	jne    8d80 <fwp_gc_collect+0x660>
    8e27:	49 89 f7             	mov    %rsi,%r15
    8e2a:	49 c1 e7 10          	shl    $0x10,%r15
    8e2e:	4c 03 3d 83 14 01 00 	add    0x11483(%rip),%r15        # 1a2b8 <fwp_gc+0x1030>
    8e35:	48 8b 5c 08 18       	mov    0x18(%rax,%rcx,1),%rbx
    8e3a:	eb 20                	jmp    8e5c <fwp_gc_collect+0x73c>
    8e3c:	f3 4d 0f bc fb       	tzcnt  %r11,%r15
    8e41:	48 c1 e6 10          	shl    $0x10,%rsi
    8e45:	48 03 35 6c 14 01 00 	add    0x1146c(%rip),%rsi        # 1a2b8 <fwp_gc+0x1030>
    8e4c:	4d 01 d7             	add    %r10,%r15
    8e4f:	8b 7c 08 08          	mov    0x8(%rax,%rcx,1),%edi
    8e53:	89 fb                	mov    %edi,%ebx
    8e55:	4c 0f af fb          	imul   %rbx,%r15
    8e59:	49 01 f7             	add    %rsi,%r15
    8e5c:	48 8b 15 75 01 01 00 	mov    0x10175(%rip),%rdx        # 18fd8 <stderr@GLIBC_2.2.5>
    8e63:	48 8b 3a             	mov    (%rdx),%rdi
    8e66:	0f b6 4c 08 01       	movzbl 0x1(%rax,%rcx,1),%ecx
    8e6b:	48 8d 35 48 bc 00 00 	lea    0xbc48(%rip),%rsi        # 14aba <exec_in_fp0+0x2aa>
    8e72:	45 31 f6             	xor    %r14d,%r14d
    8e75:	44 89 f0             	mov    %r14d,%eax
    8e78:	4c 89 fa             	mov    %r15,%rdx
    8e7b:	49 89 d8             	mov    %rbx,%r8
    8e7e:	44 88 75 d6          	mov    %r14b,-0x2a(%rbp)
    8e82:	e8 69 a4 ff ff       	call   32f0 <fprintf@plt>
    8e87:	48 89 de             	mov    %rbx,%rsi
    8e8a:	4c 01 fe             	add    %r15,%rsi
    8e8d:	44 89 f0             	mov    %r14d,%eax
    8e90:	48 89 c1             	mov    %rax,%rcx
    8e93:	48 89 b5 50 ff ff ff 	mov    %rsi,-0xb0(%rbp)
    8e9a:	eb 24                	jmp    8ec0 <fwp_gc_collect+0x7a0>
    8e9c:	0f 1f 40 00          	nopl   0x0(%rax)
    8ea0:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
    8ea4:	48 ff c2             	inc    %rdx
    8ea7:	48 89 f8             	mov    %rdi,%rax
    8eaa:	48 05 00 00 01 00    	add    $0x10000,%rax
    8eb0:	48 89 d1             	mov    %rdx,%rcx
    8eb3:	48 3b 95 40 ff ff ff 	cmp    -0xc0(%rbp),%rdx
    8eba:	0f 84 68 01 00 00    	je     9028 <fwp_gc_collect+0x908>
    8ec0:	48 89 c7             	mov    %rax,%rdi
    8ec3:	48 8b 05 36 14 01 00 	mov    0x11436(%rip),%rax        # 1a300 <fwp_gc+0x1078>
    8eca:	48 89 4d a8          	mov    %rcx,-0x58(%rbp)
    8ece:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    8ed5:	80 3c 08 01          	cmpb   $0x1,(%rax,%rcx,1)
    8ed9:	75 c5                	jne    8ea0 <fwp_gc_collect+0x780>
    8edb:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    8ee0:	74 be                	je     8ea0 <fwp_gc_collect+0x780>
    8ee2:	8b 54 08 0c          	mov    0xc(%rax,%rcx,1),%edx
    8ee6:	85 d2                	test   %edx,%edx
    8ee8:	74 b6                	je     8ea0 <fwp_gc_collect+0x780>
    8eea:	4c 8d 0c 08          	lea    (%rax,%rcx,1),%r9
    8eee:	49 ff c1             	inc    %r9
    8ef1:	48 8b 4d a8          	mov    -0x58(%rbp),%rcx
    8ef5:	48 89 c8             	mov    %rcx,%rax
    8ef8:	48 c1 e0 10          	shl    $0x10,%rax
    8efc:	48 89 85 60 ff ff ff 	mov    %rax,-0xa0(%rbp)
    8f03:	31 c0                	xor    %eax,%eax
    8f05:	41 89 c5             	mov    %eax,%r13d
    8f08:	48 89 c8             	mov    %rcx,%rax
    8f0b:	48 c1 e0 09          	shl    $0x9,%rax
    8f0f:	49 89 c0             	mov    %rax,%r8
    8f12:	4c 03 45 c8          	add    -0x38(%rbp),%r8
    8f16:	89 d0                	mov    %edx,%eax
    8f18:	48 89 bd 58 ff ff ff 	mov    %rdi,-0xa8(%rbp)
    8f1f:	4c 89 85 68 ff ff ff 	mov    %r8,-0x98(%rbp)
    8f26:	eb 35                	jmp    8f5d <fwp_gc_collect+0x83d>
    8f28:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    8f2f:	00 
    8f30:	41 8b 41 0b          	mov    0xb(%r9),%eax
    8f34:	48 8b bd 58 ff ff ff 	mov    -0xa8(%rbp),%rdi
    8f3b:	4c 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%r8
    8f42:	4c 8b ad 78 ff ff ff 	mov    -0x88(%rbp),%r13
    8f49:	4c 89 e9             	mov    %r13,%rcx
    8f4c:	48 ff c1             	inc    %rcx
    8f4f:	89 c2                	mov    %eax,%edx
    8f51:	49 89 cd             	mov    %rcx,%r13
    8f54:	48 39 d1             	cmp    %rdx,%rcx
    8f57:	0f 83 43 ff ff ff    	jae    8ea0 <fwp_gc_collect+0x780>
    8f5d:	4c 89 e9             	mov    %r13,%rcx
    8f60:	48 c1 e9 06          	shr    $0x6,%rcx
    8f64:	49 8b 0c c8          	mov    (%r8,%rcx,8),%rcx
    8f68:	4c 0f a3 e9          	bt     %r13,%rcx
    8f6c:	73 db                	jae    8f49 <fwp_gc_collect+0x829>
    8f6e:	41 8b 49 07          	mov    0x7(%r9),%ecx
    8f72:	41 89 cc             	mov    %ecx,%r12d
    8f75:	49 83 fc 08          	cmp    $0x8,%r12
    8f79:	72 ce                	jb     8f49 <fwp_gc_collect+0x829>
    8f7b:	4c 8b 35 36 13 01 00 	mov    0x11336(%rip),%r14        # 1a2b8 <fwp_gc+0x1030>
    8f82:	48 8b 8d 60 ff ff ff 	mov    -0xa0(%rbp),%rcx
    8f89:	4c 01 f1             	add    %r14,%rcx
    8f8c:	48 89 4d 80          	mov    %rcx,-0x80(%rbp)
    8f90:	45 89 e0             	mov    %r12d,%r8d
    8f93:	4c 89 ad 78 ff ff ff 	mov    %r13,-0x88(%rbp)
    8f9a:	4d 0f af e5          	imul   %r13,%r12
    8f9e:	49 01 fe             	add    %rdi,%r14
    8fa1:	4d 01 e6             	add    %r12,%r14
    8fa4:	31 c0                	xor    %eax,%eax
    8fa6:	89 c3                	mov    %eax,%ebx
    8fa8:	eb 1e                	jmp    8fc8 <fwp_gc_collect+0x8a8>
    8faa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8fb0:	44 89 c0             	mov    %r8d,%eax
    8fb3:	48 89 d9             	mov    %rbx,%rcx
    8fb6:	48 ff c1             	inc    %rcx
    8fb9:	c1 e8 03             	shr    $0x3,%eax
    8fbc:	48 89 cb             	mov    %rcx,%rbx
    8fbf:	48 39 c1             	cmp    %rax,%rcx
    8fc2:	0f 83 68 ff ff ff    	jae    8f30 <fwp_gc_collect+0x810>
    8fc8:	49 8b 04 de          	mov    (%r14,%rbx,8),%rax
    8fcc:	4c 39 f8             	cmp    %r15,%rax
    8fcf:	72 df                	jb     8fb0 <fwp_gc_collect+0x890>
    8fd1:	48 39 f0             	cmp    %rsi,%rax
    8fd4:	73 da                	jae    8fb0 <fwp_gc_collect+0x890>
    8fd6:	48 8b 05 fb ff 00 00 	mov    0xfffb(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    8fdd:	48 8b 38             	mov    (%rax),%rdi
    8fe0:	41 0f b6 09          	movzbl (%r9),%ecx
    8fe4:	48 8b 45 80          	mov    -0x80(%rbp),%rax
    8fe8:	4a 8d 14 20          	lea    (%rax,%r12,1),%rdx
    8fec:	66 42 0f 10 04 20    	movupd (%rax,%r12,1),%xmm0
    8ff2:	4a 8b 44 20 10       	mov    0x10(%rax,%r12,1),%rax
    8ff7:	48 89 e6             	mov    %rsp,%rsi
    8ffa:	48 89 46 10          	mov    %rax,0x10(%rsi)
    8ffe:	66 0f 11 06          	movupd %xmm0,(%rsi)
    9002:	48 8d 35 0b bb 00 00 	lea    0xbb0b(%rip),%rsi        # 14b14 <exec_in_fp0+0x304>
    9009:	4d 89 cd             	mov    %r9,%r13
    900c:	49 89 d9             	mov    %rbx,%r9
    900f:	0f b6 45 d6          	movzbl -0x2a(%rbp),%eax
    9013:	e8 d8 a2 ff ff       	call   32f0 <fprintf@plt>
    9018:	4d 89 e9             	mov    %r13,%r9
    901b:	48 8b b5 50 ff ff ff 	mov    -0xb0(%rbp),%rsi
    9022:	45 8b 45 07          	mov    0x7(%r13),%r8d
    9026:	eb 88                	jmp    8fb0 <fwp_gc_collect+0x890>
    9028:	e8 43 a0 ff ff       	call   3070 <abort@plt>
    902d:	48 8b 05 a4 ff 00 00 	mov    0xffa4(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    9034:	48 8b 08             	mov    (%rax),%rcx
    9037:	48 8d 3d 68 ba 00 00 	lea    0xba68(%rip),%rdi        # 14aa6 <exec_in_fp0+0x296>
    903e:	be 13 00 00 00       	mov    $0x13,%esi
    9043:	ba 01 00 00 00       	mov    $0x1,%edx
    9048:	e8 33 a4 ff ff       	call   3480 <fwrite@plt>
    904d:	bf 66 00 00 00       	mov    $0x66,%edi
    9052:	e8 09 a4 ff ff       	call   3460 <exit@plt>
    9057:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    905e:	00 00 

0000000000009060 <fwp_gc_mark_all>:
    9060:	41 57                	push   %r15
    9062:	41 56                	push   %r14
    9064:	41 55                	push   %r13
    9066:	41 54                	push   %r12
    9068:	53                   	push   %rbx
    9069:	e8 f2 08 00 00       	call   9960 <fwp_gc_sp>
    906e:	48 85 c0             	test   %rax,%rax
    9071:	74 56                	je     90c9 <fwp_gc_mark_all+0x69>
    9073:	48 8b 35 96 12 01 00 	mov    0x11296(%rip),%rsi        # 1a310 <fwp_gc+0x1088>
    907a:	48 89 f1             	mov    %rsi,%rcx
    907d:	48 29 c1             	sub    %rax,%rcx
    9080:	76 47                	jbe    90c9 <fwp_gc_mark_all+0x69>
    9082:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    9087:	f2 0f 58 05 f9 13 01 	addsd  0x113f9(%rip),%xmm0        # 1a488 <fwp_gc+0x1200>
    908e:	00 
    908f:	f2 0f 11 05 f1 13 01 	movsd  %xmm0,0x113f1(%rip)        # 1a488 <fwp_gc+0x1200>
    9096:	00 
    9097:	48 89 c7             	mov    %rax,%rdi
    909a:	ba 01 00 00 00       	mov    $0x1,%edx
    909f:	eb 23                	jmp    90c4 <fwp_gc_mark_all+0x64>
    90a1:	48 8b 0d 78 13 01 00 	mov    0x11378(%rip),%rcx        # 1a420 <fwp_gc+0x1198>
    90a8:	48 ff c8             	dec    %rax
    90ab:	48 89 05 76 13 01 00 	mov    %rax,0x11376(%rip)        # 1a428 <fwp_gc+0x11a0>
    90b2:	48 c1 e0 04          	shl    $0x4,%rax
    90b6:	48 8b 3c 01          	mov    (%rcx,%rax,1),%rdi
    90ba:	48 8b 74 01 08       	mov    0x8(%rcx,%rax,1),%rsi
    90bf:	48 01 fe             	add    %rdi,%rsi
    90c2:	31 d2                	xor    %edx,%edx
    90c4:	e8 a7 08 00 00       	call   9970 <fwp_gc_scan>
    90c9:	48 8b 05 58 13 01 00 	mov    0x11358(%rip),%rax        # 1a428 <fwp_gc+0x11a0>
    90d0:	48 85 c0             	test   %rax,%rax
    90d3:	75 cc                	jne    90a1 <fwp_gc_mark_all+0x41>
    90d5:	83 3d 3c 13 01 00 00 	cmpl   $0x0,0x1133c(%rip)        # 1a418 <fwp_gc+0x1190>
    90dc:	0f 8e b2 00 00 00    	jle    9194 <fwp_gc_mark_all+0x134>
    90e2:	4c 8d 25 37 12 01 00 	lea    0x11237(%rip),%r12        # 1a320 <fwp_gc+0x1098>
    90e9:	45 31 ed             	xor    %r13d,%r13d
    90ec:	48 8d 1d 95 01 01 00 	lea    0x10195(%rip),%rbx        # 19288 <fwp_gc>
    90f3:	4c 8d 35 ae 1b 01 00 	lea    0x11bae(%rip),%r14        # 1aca8 <fc13>
    90fa:	eb 21                	jmp    911d <fwp_gc_mark_all+0xbd>
    90fc:	0f 1f 40 00          	nopl   0x0(%rax)
    9100:	4c 89 fe             	mov    %r15,%rsi
    9103:	31 d2                	xor    %edx,%edx
    9105:	e8 66 08 00 00       	call   9970 <fwp_gc_scan>
    910a:	49 ff c5             	inc    %r13
    910d:	48 63 05 04 13 01 00 	movslq 0x11304(%rip),%rax        # 1a418 <fwp_gc+0x1190>
    9114:	49 83 c4 10          	add    $0x10,%r12
    9118:	49 39 c5             	cmp    %rax,%r13
    911b:	7d 6b                	jge    9188 <fwp_gc_mark_all+0x128>
    911d:	49 8b 7c 24 f8       	mov    -0x8(%r12),%rdi
    9122:	49 8b 04 24          	mov    (%r12),%rax
    9126:	4c 8d 3c 07          	lea    (%rdi,%rax,1),%r15
    912a:	0f 57 c0             	xorps  %xmm0,%xmm0
    912d:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    9132:	f2 0f 58 05 4e 13 01 	addsd  0x1134e(%rip),%xmm0        # 1a488 <fwp_gc+0x1200>
    9139:	00 
    913a:	f2 0f 11 05 46 13 01 	movsd  %xmm0,0x11346(%rip)        # 1a488 <fwp_gc+0x1200>
    9141:	00 
    9142:	48 39 df             	cmp    %rbx,%rdi
    9145:	77 b9                	ja     9100 <fwp_gc_mark_all+0xa0>
    9147:	4d 39 f7             	cmp    %r14,%r15
    914a:	72 b4                	jb     9100 <fwp_gc_mark_all+0xa0>
    914c:	48 89 de             	mov    %rbx,%rsi
    914f:	31 d2                	xor    %edx,%edx
    9151:	e8 1a 08 00 00       	call   9970 <fwp_gc_scan>
    9156:	4c 89 f7             	mov    %r14,%rdi
    9159:	eb a5                	jmp    9100 <fwp_gc_mark_all+0xa0>
    915b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    9160:	48 8b 0d b9 12 01 00 	mov    0x112b9(%rip),%rcx        # 1a420 <fwp_gc+0x1198>
    9167:	48 ff c8             	dec    %rax
    916a:	48 89 05 b7 12 01 00 	mov    %rax,0x112b7(%rip)        # 1a428 <fwp_gc+0x11a0>
    9171:	48 c1 e0 04          	shl    $0x4,%rax
    9175:	48 8b 3c 01          	mov    (%rcx,%rax,1),%rdi
    9179:	48 8b 74 01 08       	mov    0x8(%rcx,%rax,1),%rsi
    917e:	48 01 fe             	add    %rdi,%rsi
    9181:	31 d2                	xor    %edx,%edx
    9183:	e8 e8 07 00 00       	call   9970 <fwp_gc_scan>
    9188:	48 8b 05 99 12 01 00 	mov    0x11299(%rip),%rax        # 1a428 <fwp_gc+0x11a0>
    918f:	48 85 c0             	test   %rax,%rax
    9192:	75 cc                	jne    9160 <fwp_gc_mark_all+0x100>
    9194:	5b                   	pop    %rbx
    9195:	41 5c                	pop    %r12
    9197:	41 5d                	pop    %r13
    9199:	41 5e                	pop    %r14
    919b:	41 5f                	pop    %r15
    919d:	c3                   	ret
    919e:	66 90                	xchg   %ax,%ax

00000000000091a0 <fwp_gc_finalize>:
    91a0:	48 8b 0d 99 12 01 00 	mov    0x11299(%rip),%rcx        # 1a440 <fwp_gc+0x11b8>
    91a7:	48 85 c9             	test   %rcx,%rcx
    91aa:	0f 84 10 01 00 00    	je     92c0 <fwp_gc_finalize+0x120>
    91b0:	41 56                	push   %r14
    91b2:	53                   	push   %rbx
    91b3:	50                   	push   %rax
    91b4:	48 8b 35 7d 12 01 00 	mov    0x1127d(%rip),%rsi        # 1a438 <fwp_gc+0x11b0>
    91bb:	4c 8b 05 f6 10 01 00 	mov    0x110f6(%rip),%r8        # 1a2b8 <fwp_gc+0x1030>
    91c2:	4c 8b 0d 17 11 01 00 	mov    0x11117(%rip),%r9        # 1a2e0 <fwp_gc+0x1058>
    91c9:	31 db                	xor    %ebx,%ebx
    91cb:	eb 0f                	jmp    91dc <fwp_gc_finalize+0x3c>
    91cd:	0f 1f 00             	nopl   (%rax)
    91d0:	48 ff c3             	inc    %rbx
    91d3:	48 39 cb             	cmp    %rcx,%rbx
    91d6:	0f 83 dd 00 00 00    	jae    92b9 <fwp_gc_finalize+0x119>
    91dc:	49 89 da             	mov    %rbx,%r10
    91df:	49 c1 e2 04          	shl    $0x4,%r10
    91e3:	4a 8b 3c 16          	mov    (%rsi,%r10,1),%rdi
    91e7:	48 89 f8             	mov    %rdi,%rax
    91ea:	4c 29 c0             	sub    %r8,%rax
    91ed:	4c 89 ca             	mov    %r9,%rdx
    91f0:	48 c1 e2 10          	shl    $0x10,%rdx
    91f4:	48 39 d0             	cmp    %rdx,%rax
    91f7:	73 d7                	jae    91d0 <fwp_gc_finalize+0x30>
    91f9:	4c 8b 1d 00 11 01 00 	mov    0x11100(%rip),%r11        # 1a300 <fwp_gc+0x1078>
    9200:	4d 85 db             	test   %r11,%r11
    9203:	74 cb                	je     91d0 <fwp_gc_finalize+0x30>
    9205:	48 c1 e8 10          	shr    $0x10,%rax
    9209:	48 69 d0 28 12 00 00 	imul   $0x1228,%rax,%rdx
    9210:	41 0f b6 04 13       	movzbl (%r11,%rdx,1),%eax
    9215:	3c 03                	cmp    $0x3,%al
    9217:	75 16                	jne    922f <fwp_gc_finalize+0x8f>
    9219:	41 8b 44 13 10       	mov    0x10(%r11,%rdx,1),%eax
    921e:	48 69 d0 28 12 00 00 	imul   $0x1228,%rax,%rdx
    9225:	41 0f b6 04 13       	movzbl (%r11,%rdx,1),%eax
    922a:	49 01 d3             	add    %rdx,%r11
    922d:	eb 03                	jmp    9232 <fwp_gc_finalize+0x92>
    922f:	49 01 d3             	add    %rdx,%r11
    9232:	4e 8b 74 16 08       	mov    0x8(%rsi,%r10,1),%r14
    9237:	3c 01                	cmp    $0x1,%al
    9239:	74 13                	je     924e <fwp_gc_finalize+0xae>
    923b:	0f b6 c0             	movzbl %al,%eax
    923e:	83 f8 02             	cmp    $0x2,%eax
    9241:	75 35                	jne    9278 <fwp_gc_finalize+0xd8>
    9243:	41 0f b6 53 03       	movzbl 0x3(%r11),%edx
    9248:	85 d2                	test   %edx,%edx
    924a:	75 84                	jne    91d0 <fwp_gc_finalize+0x30>
    924c:	eb 2a                	jmp    9278 <fwp_gc_finalize+0xd8>
    924e:	0f b7 c7             	movzwl %di,%eax
    9251:	31 d2                	xor    %edx,%edx
    9253:	41 f7 73 08          	divl   0x8(%r11)
    9257:	89 c2                	mov    %eax,%edx
    9259:	c1 ea 03             	shr    $0x3,%edx
    925c:	81 e2 f8 1f 00 00    	and    $0x1ff8,%edx
    9262:	4d 8b 5c 13 28       	mov    0x28(%r11,%rdx,1),%r11
    9267:	31 d2                	xor    %edx,%edx
    9269:	49 0f a3 c3          	bt     %rax,%r11
    926d:	0f 92 c2             	setb   %dl
    9270:	85 d2                	test   %edx,%edx
    9272:	0f 85 58 ff ff ff    	jne    91d0 <fwp_gc_finalize+0x30>
    9278:	49 01 f2             	add    %rsi,%r10
    927b:	48 ff c9             	dec    %rcx
    927e:	48 89 0d bb 11 01 00 	mov    %rcx,0x111bb(%rip)        # 1a440 <fwp_gc+0x11b8>
    9285:	48 c1 e1 04          	shl    $0x4,%rcx
    9289:	0f 10 04 0e          	movups (%rsi,%rcx,1),%xmm0
    928d:	41 0f 11 02          	movups %xmm0,(%r10)
    9291:	41 ff d6             	call   *%r14
    9294:	48 8b 35 9d 11 01 00 	mov    0x1119d(%rip),%rsi        # 1a438 <fwp_gc+0x11b0>
    929b:	4c 8b 05 16 10 01 00 	mov    0x11016(%rip),%r8        # 1a2b8 <fwp_gc+0x1030>
    92a2:	4c 8b 0d 37 10 01 00 	mov    0x11037(%rip),%r9        # 1a2e0 <fwp_gc+0x1058>
    92a9:	48 8b 0d 90 11 01 00 	mov    0x11190(%rip),%rcx        # 1a440 <fwp_gc+0x11b8>
    92b0:	48 39 cb             	cmp    %rcx,%rbx
    92b3:	0f 82 23 ff ff ff    	jb     91dc <fwp_gc_finalize+0x3c>
    92b9:	48 83 c4 08          	add    $0x8,%rsp
    92bd:	5b                   	pop    %rbx
    92be:	41 5e                	pop    %r14
    92c0:	c3                   	ret
    92c1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    92c8:	0f 1f 84 00 00 00 00 
    92cf:	00 

00000000000092d0 <fwp_gc_sweep>:
    92d0:	55                   	push   %rbp
    92d1:	41 57                	push   %r15
    92d3:	41 56                	push   %r14
    92d5:	41 55                	push   %r13
    92d7:	41 54                	push   %r12
    92d9:	53                   	push   %rbx
    92da:	48 83 ec 28          	sub    $0x28,%rsp
    92de:	48 8d 3d ab ff 00 00 	lea    0xffab(%rip),%rdi        # 19290 <fwp_gc+0x8>
    92e5:	31 ed                	xor    %ebp,%ebp
    92e7:	ba 40 0b 00 00       	mov    $0xb40,%edx
    92ec:	31 f6                	xor    %esi,%esi
    92ee:	e8 1d 9f ff ff       	call   3210 <memset@plt>
    92f3:	48 83 3d e5 0f 01 00 	cmpq   $0x0,0x10fe5(%rip)        # 1a2e0 <fwp_gc+0x1058>
    92fa:	00 
    92fb:	0f 84 0f 05 00 00    	je     9810 <fwp_gc_sweep+0x540>
    9301:	31 c0                	xor    %eax,%eax
    9303:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    9308:	49 b9 55 55 55 55 55 	movabs $0x5555555555555555,%r9
    930f:	55 55 55 
    9312:	49 ba 33 33 33 33 33 	movabs $0x3333333333333333,%r10
    9319:	33 33 33 
    931c:	49 bb 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r11
    9323:	0f 0f 0f 
    9326:	49 bc 01 01 01 01 01 	movabs $0x101010101010101,%r12
    932d:	01 01 01 
    9330:	66 0f 6f 2d 88 ad 00 	movdqa 0xad88(%rip),%xmm5        # 140c0 <_IO_stdin_used+0xc0>
    9337:	00 
    9338:	66 0f 6f 35 90 ad 00 	movdqa 0xad90(%rip),%xmm6        # 140d0 <_IO_stdin_used+0xd0>
    933f:	00 
    9340:	66 0f 6f 3d 98 ad 00 	movdqa 0xad98(%rip),%xmm7        # 140e0 <_IO_stdin_used+0xe0>
    9347:	00 
    9348:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    934d:	31 ed                	xor    %ebp,%ebp
    934f:	45 31 ed             	xor    %r13d,%r13d
    9352:	eb 22                	jmp    9376 <fwp_gc_sweep+0xa6>
    9354:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    935b:	00 00 00 00 00 
    9360:	48 ff c5             	inc    %rbp
    9363:	49 ff c5             	inc    %r13
    9366:	48 8b 05 73 0f 01 00 	mov    0x10f73(%rip),%rax        # 1a2e0 <fwp_gc+0x1058>
    936d:	49 39 c5             	cmp    %rax,%r13
    9370:	0f 83 a3 04 00 00    	jae    9819 <fwp_gc_sweep+0x549>
    9376:	48 8b 1d 83 0f 01 00 	mov    0x10f83(%rip),%rbx        # 1a300 <fwp_gc+0x1078>
    937d:	4d 69 f5 28 12 00 00 	imul   $0x1228,%r13,%r14
    9384:	42 0f b6 04 33       	movzbl (%rbx,%r14,1),%eax
    9389:	85 c0                	test   %eax,%eax
    938b:	74 d3                	je     9360 <fwp_gc_sweep+0x90>
    938d:	83 f8 01             	cmp    $0x1,%eax
    9390:	74 2e                	je     93c0 <fwp_gc_sweep+0xf0>
    9392:	83 f8 02             	cmp    $0x2,%eax
    9395:	75 cc                	jne    9363 <fwp_gc_sweep+0x93>
    9397:	46 8b 64 33 10       	mov    0x10(%rbx,%r14,1),%r12d
    939c:	42 80 7c 33 03 00    	cmpb   $0x0,0x3(%rbx,%r14,1)
    93a2:	74 50                	je     93f4 <fwp_gc_sweep+0x124>
    93a4:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    93a9:	4a 03 44 33 18       	add    0x18(%rbx,%r14,1),%rax
    93ae:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    93b3:	e9 fb 03 00 00       	jmp    97b3 <fwp_gc_sweep+0x4e3>
    93b8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    93bf:	00 
    93c0:	4a 8d 04 33          	lea    (%rbx,%r14,1),%rax
    93c4:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    93c9:	46 8b 7c 33 0c       	mov    0xc(%rbx,%r14,1),%r15d
    93ce:	4d 85 ff             	test   %r15,%r15
    93d1:	0f 84 b5 02 00 00    	je     968c <fwp_gc_sweep+0x3bc>
    93d7:	49 8d 57 3f          	lea    0x3f(%r15),%rdx
    93db:	48 89 d0             	mov    %rdx,%rax
    93de:	48 c1 e8 06          	shr    $0x6,%rax
    93e2:	41 81 ff c1 00 00 00 	cmp    $0xc1,%r15d
    93e9:	73 48                	jae    9433 <fwp_gc_sweep+0x163>
    93eb:	31 d2                	xor    %edx,%edx
    93ed:	31 c9                	xor    %ecx,%ecx
    93ef:	e9 1b 01 00 00       	jmp    950f <fwp_gc_sweep+0x23f>
    93f4:	4e 8d 3c 33          	lea    (%rbx,%r14,1),%r15
    93f8:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    93ff:	42 80 bc 33 28 02 00 	cmpb   $0xff,0x228(%rbx,%r14,1)
    9406:	00 ff 
    9408:	0f 84 d8 03 00 00    	je     97e6 <fwp_gc_sweep+0x516>
    940e:	41 c6 07 00          	movb   $0x0,(%r15)
    9412:	4d 85 e4             	test   %r12,%r12
    9415:	0f 84 95 03 00 00    	je     97b0 <fwp_gc_sweep+0x4e0>
    941b:	48 8b 05 de 0e 01 00 	mov    0x10ede(%rip),%rax        # 1a300 <fwp_gc+0x1078>
    9422:	41 83 fc 04          	cmp    $0x4,%r12d
    9426:	0f 83 15 03 00 00    	jae    9741 <fwp_gc_sweep+0x471>
    942c:	31 c9                	xor    %ecx,%ecx
    942e:	e9 45 03 00 00       	jmp    9778 <fwp_gc_sweep+0x4a8>
    9433:	89 c1                	mov    %eax,%ecx
    9435:	83 e1 fc             	and    $0xfffffffc,%ecx
    9438:	4a 8d 34 33          	lea    (%rbx,%r14,1),%rsi
    943c:	48 83 c6 38          	add    $0x38,%rsi
    9440:	48 c1 ea 03          	shr    $0x3,%rdx
    9444:	83 e2 e0             	and    $0xffffffe0,%edx
    9447:	66 0f ef c0          	pxor   %xmm0,%xmm0
    944b:	31 ff                	xor    %edi,%edi
    944d:	66 0f ef c9          	pxor   %xmm1,%xmm1
    9451:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9458:	0f 1f 84 00 00 00 00 
    945f:	00 
    9460:	f3 0f 6f 5c 3e f0    	movdqu -0x10(%rsi,%rdi,1),%xmm3
    9466:	f3 0f 6f 14 3e       	movdqu (%rsi,%rdi,1),%xmm2
    946b:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    946f:	66 0f 71 d4 01       	psrlw  $0x1,%xmm4
    9474:	66 0f db e5          	pand   %xmm5,%xmm4
    9478:	66 0f f8 dc          	psubb  %xmm4,%xmm3
    947c:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    9480:	66 0f db e6          	pand   %xmm6,%xmm4
    9484:	66 0f 71 d3 02       	psrlw  $0x2,%xmm3
    9489:	66 0f db de          	pand   %xmm6,%xmm3
    948d:	66 0f fc dc          	paddb  %xmm4,%xmm3
    9491:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    9495:	66 0f 71 d4 04       	psrlw  $0x4,%xmm4
    949a:	66 0f fc e3          	paddb  %xmm3,%xmm4
    949e:	66 0f db e7          	pand   %xmm7,%xmm4
    94a2:	66 41 0f f6 e0       	psadbw %xmm8,%xmm4
    94a7:	66 0f d4 c4          	paddq  %xmm4,%xmm0
    94ab:	66 0f 6f da          	movdqa %xmm2,%xmm3
    94af:	66 0f 71 d3 01       	psrlw  $0x1,%xmm3
    94b4:	66 0f db dd          	pand   %xmm5,%xmm3
    94b8:	66 0f f8 d3          	psubb  %xmm3,%xmm2
    94bc:	66 0f 6f da          	movdqa %xmm2,%xmm3
    94c0:	66 0f db de          	pand   %xmm6,%xmm3
    94c4:	66 0f 71 d2 02       	psrlw  $0x2,%xmm2
    94c9:	66 0f db d6          	pand   %xmm6,%xmm2
    94cd:	66 0f fc d3          	paddb  %xmm3,%xmm2
    94d1:	66 0f 6f da          	movdqa %xmm2,%xmm3
    94d5:	66 0f 71 d3 04       	psrlw  $0x4,%xmm3
    94da:	66 0f fc da          	paddb  %xmm2,%xmm3
    94de:	66 0f db df          	pand   %xmm7,%xmm3
    94e2:	66 41 0f f6 d8       	psadbw %xmm8,%xmm3
    94e7:	66 0f d4 cb          	paddq  %xmm3,%xmm1
    94eb:	48 83 c7 20          	add    $0x20,%rdi
    94ef:	48 39 fa             	cmp    %rdi,%rdx
    94f2:	0f 85 68 ff ff ff    	jne    9460 <fwp_gc_sweep+0x190>
    94f8:	66 0f d4 c8          	paddq  %xmm0,%xmm1
    94fc:	66 0f 70 c1 ee       	pshufd $0xee,%xmm1,%xmm0
    9501:	66 0f d4 c1          	paddq  %xmm1,%xmm0
    9505:	66 48 0f 7e c2       	movq   %xmm0,%rdx
    950a:	48 39 c8             	cmp    %rcx,%rax
    950d:	74 51                	je     9560 <fwp_gc_sweep+0x290>
    950f:	4a 8d 34 33          	lea    (%rbx,%r14,1),%rsi
    9513:	48 83 c6 28          	add    $0x28,%rsi
    9517:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    951e:	00 00 
    9520:	48 8b 3c ce          	mov    (%rsi,%rcx,8),%rdi
    9524:	49 89 f8             	mov    %rdi,%r8
    9527:	49 d1 e8             	shr    $1,%r8
    952a:	4d 21 c8             	and    %r9,%r8
    952d:	4c 29 c7             	sub    %r8,%rdi
    9530:	49 89 f8             	mov    %rdi,%r8
    9533:	4d 21 d0             	and    %r10,%r8
    9536:	48 c1 ef 02          	shr    $0x2,%rdi
    953a:	4c 21 d7             	and    %r10,%rdi
    953d:	4c 01 c7             	add    %r8,%rdi
    9540:	49 89 f8             	mov    %rdi,%r8
    9543:	49 c1 e8 04          	shr    $0x4,%r8
    9547:	49 01 f8             	add    %rdi,%r8
    954a:	4d 21 d8             	and    %r11,%r8
    954d:	4d 0f af c4          	imul   %r12,%r8
    9551:	49 c1 e8 38          	shr    $0x38,%r8
    9555:	4c 01 c2             	add    %r8,%rdx
    9558:	48 ff c1             	inc    %rcx
    955b:	48 39 c8             	cmp    %rcx,%rax
    955e:	75 c0                	jne    9520 <fwp_gc_sweep+0x250>
    9560:	48 85 d2             	test   %rdx,%rdx
    9563:	0f 84 23 01 00 00    	je     968c <fwp_gc_sweep+0x3bc>
    9569:	42 8b 44 33 08       	mov    0x8(%rbx,%r14,1),%eax
    956e:	48 0f af d0          	imul   %rax,%rdx
    9572:	48 01 54 24 08       	add    %rdx,0x8(%rsp)
    9577:	4d 85 ff             	test   %r15,%r15
    957a:	0f 84 e3 fd ff ff    	je     9363 <fwp_gc_sweep+0x93>
    9580:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
    9585:	42 0f b6 44 33 01    	movzbl 0x1(%rbx,%r14,1),%eax
    958b:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    9592:	4d 89 ec             	mov    %r13,%r12
    9595:	49 c1 e4 10          	shl    $0x10,%r12
    9599:	4c 03 25 18 0d 01 00 	add    0x10d18(%rip),%r12        # 1a2b8 <fwp_gc+0x1030>
    95a0:	48 8d 0d e1 fc 00 00 	lea    0xfce1(%rip),%rcx        # 19288 <fwp_gc>
    95a7:	48 01 c8             	add    %rcx,%rax
    95aa:	4a 8d 0c 33          	lea    (%rbx,%r14,1),%rcx
    95ae:	48 83 c1 08          	add    $0x8,%rcx
    95b2:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
    95b7:	42 0f b6 4c 33 02    	movzbl 0x2(%rbx,%r14,1),%ecx
    95bd:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    95c1:	48 8d 2c c8          	lea    (%rax,%rcx,8),%rbp
    95c5:	48 83 c5 08          	add    $0x8,%rbp
    95c9:	4d 01 fe             	add    %r15,%r14
    95cc:	4c 01 f3             	add    %r14,%rbx
    95cf:	48 81 c3 27 02 00 00 	add    $0x227,%rbx
    95d6:	49 ff cf             	dec    %r15
    95d9:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    95de:	eb 23                	jmp    9603 <fwp_gc_sweep+0x333>
    95e0:	80 3b ff             	cmpb   $0xff,(%rbx)
    95e3:	74 78                	je     965d <fwp_gc_sweep+0x38d>
    95e5:	c6 03 00             	movb   $0x0,(%rbx)
    95e8:	48 8b 45 00          	mov    0x0(%rbp),%rax
    95ec:	48 f7 d0             	not    %rax
    95ef:	49 89 06             	mov    %rax,(%r14)
    95f2:	4c 89 75 00          	mov    %r14,0x0(%rbp)
    95f6:	48 ff cb             	dec    %rbx
    95f9:	49 83 c7 ff          	add    $0xffffffffffffffff,%r15
    95fd:	0f 83 37 01 00 00    	jae    973a <fwp_gc_sweep+0x46a>
    9603:	4c 89 f8             	mov    %r15,%rax
    9606:	48 c1 e8 06          	shr    $0x6,%rax
    960a:	48 8b 44 c1 28       	mov    0x28(%rcx,%rax,8),%rax
    960f:	4c 0f a3 f8          	bt     %r15,%rax
    9613:	72 e1                	jb     95f6 <fwp_gc_sweep+0x326>
    9615:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    961a:	8b 10                	mov    (%rax),%edx
    961c:	4d 89 fe             	mov    %r15,%r14
    961f:	4c 0f af f2          	imul   %rdx,%r14
    9623:	4d 01 e6             	add    %r12,%r14
    9626:	83 3d 5f 0c 01 00 00 	cmpl   $0x0,0x10c5f(%rip)        # 1a28c <fwp_gc+0x1004>
    962d:	74 b1                	je     95e0 <fwp_gc_sweep+0x310>
    962f:	4c 89 f7             	mov    %r14,%rdi
    9632:	31 f6                	xor    %esi,%esi
    9634:	e8 d7 9b ff ff       	call   3210 <memset@plt>
    9639:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    963e:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    9643:	66 0f 6f 3d 95 aa 00 	movdqa 0xaa95(%rip),%xmm7        # 140e0 <_IO_stdin_used+0xe0>
    964a:	00 
    964b:	66 0f 6f 35 7d aa 00 	movdqa 0xaa7d(%rip),%xmm6        # 140d0 <_IO_stdin_used+0xd0>
    9652:	00 
    9653:	66 0f 6f 2d 65 aa 00 	movdqa 0xaa65(%rip),%xmm5        # 140c0 <_IO_stdin_used+0xc0>
    965a:	00 
    965b:	eb 83                	jmp    95e0 <fwp_gc_sweep+0x310>
    965d:	48 89 df             	mov    %rbx,%rdi
    9660:	e8 2b cf ff ff       	call   6590 <fwp_rc_forget_slot>
    9665:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    966a:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    966f:	66 0f 6f 3d 69 aa 00 	movdqa 0xaa69(%rip),%xmm7        # 140e0 <_IO_stdin_used+0xe0>
    9676:	00 
    9677:	66 0f 6f 35 51 aa 00 	movdqa 0xaa51(%rip),%xmm6        # 140d0 <_IO_stdin_used+0xd0>
    967e:	00 
    967f:	66 0f 6f 2d 39 aa 00 	movdqa 0xaa39(%rip),%xmm5        # 140c0 <_IO_stdin_used+0xc0>
    9686:	00 
    9687:	e9 59 ff ff ff       	jmp    95e5 <fwp_gc_sweep+0x315>
    968c:	48 83 3d 0c 16 01 00 	cmpq   $0x0,0x1160c(%rip)        # 1aca0 <fwp_gc+0x1a18>
    9693:	00 
    9694:	74 38                	je     96ce <fwp_gc_sweep+0x3fe>
    9696:	4e 8d 3c 33          	lea    (%rbx,%r14,1),%r15
    969a:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    96a1:	45 31 e4             	xor    %r12d,%r12d
    96a4:	eb 16                	jmp    96bc <fwp_gc_sweep+0x3ec>
    96a6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    96ad:	00 00 00 
    96b0:	49 ff c4             	inc    %r12
    96b3:	49 81 fc 00 10 00 00 	cmp    $0x1000,%r12
    96ba:	74 12                	je     96ce <fwp_gc_sweep+0x3fe>
    96bc:	43 80 3c 27 ff       	cmpb   $0xff,(%r15,%r12,1)
    96c1:	75 ed                	jne    96b0 <fwp_gc_sweep+0x3e0>
    96c3:	4b 8d 3c 27          	lea    (%r15,%r12,1),%rdi
    96c7:	e8 c4 ce ff ff       	call   6590 <fwp_rc_forget_slot>
    96cc:	eb e2                	jmp    96b0 <fwp_gc_sweep+0x3e0>
    96ce:	4a 8d 3c 33          	lea    (%rbx,%r14,1),%rdi
    96d2:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    96d9:	ba 00 10 00 00       	mov    $0x1000,%edx
    96de:	31 f6                	xor    %esi,%esi
    96e0:	e8 2b 9b ff ff       	call   3210 <memset@plt>
    96e5:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    96ea:	c6 00 00             	movb   $0x0,(%rax)
    96ed:	48 ff c5             	inc    %rbp
    96f0:	49 b9 55 55 55 55 55 	movabs $0x5555555555555555,%r9
    96f7:	55 55 55 
    96fa:	49 ba 33 33 33 33 33 	movabs $0x3333333333333333,%r10
    9701:	33 33 33 
    9704:	49 bb 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r11
    970b:	0f 0f 0f 
    970e:	49 bc 01 01 01 01 01 	movabs $0x101010101010101,%r12
    9715:	01 01 01 
    9718:	66 0f 6f 2d a0 a9 00 	movdqa 0xa9a0(%rip),%xmm5        # 140c0 <_IO_stdin_used+0xc0>
    971f:	00 
    9720:	66 0f 6f 35 a8 a9 00 	movdqa 0xa9a8(%rip),%xmm6        # 140d0 <_IO_stdin_used+0xd0>
    9727:	00 
    9728:	66 0f 6f 3d b0 a9 00 	movdqa 0xa9b0(%rip),%xmm7        # 140e0 <_IO_stdin_used+0xe0>
    972f:	00 
    9730:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    9735:	e9 29 fc ff ff       	jmp    9363 <fwp_gc_sweep+0x93>
    973a:	48 8b 6c 24 18       	mov    0x18(%rsp),%rbp
    973f:	eb 78                	jmp    97b9 <fwp_gc_sweep+0x4e9>
    9741:	4a 8d 14 30          	lea    (%rax,%r14,1),%rdx
    9745:	44 89 e6             	mov    %r12d,%esi
    9748:	83 e6 fc             	and    $0xfffffffc,%esi
    974b:	31 c9                	xor    %ecx,%ecx
    974d:	0f 1f 00             	nopl   (%rax)
    9750:	c6 02 00             	movb   $0x0,(%rdx)
    9753:	c6 82 28 12 00 00 00 	movb   $0x0,0x1228(%rdx)
    975a:	c6 82 50 24 00 00 00 	movb   $0x0,0x2450(%rdx)
    9761:	c6 82 78 36 00 00 00 	movb   $0x0,0x3678(%rdx)
    9768:	48 83 c1 04          	add    $0x4,%rcx
    976c:	48 81 c2 a0 48 00 00 	add    $0x48a0,%rdx
    9773:	48 39 ce             	cmp    %rcx,%rsi
    9776:	75 d8                	jne    9750 <fwp_gc_sweep+0x480>
    9778:	44 89 e2             	mov    %r12d,%edx
    977b:	83 e2 03             	and    $0x3,%edx
    977e:	74 30                	je     97b0 <fwp_gc_sweep+0x4e0>
    9780:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    9787:	4c 01 f1             	add    %r14,%rcx
    978a:	48 01 c8             	add    %rcx,%rax
    978d:	48 69 ca 28 12 00 00 	imul   $0x1228,%rdx,%rcx
    9794:	31 d2                	xor    %edx,%edx
    9796:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    979d:	00 00 00 
    97a0:	c6 04 10 00          	movb   $0x0,(%rax,%rdx,1)
    97a4:	48 81 c2 28 12 00 00 	add    $0x1228,%rdx
    97ab:	48 39 d1             	cmp    %rdx,%rcx
    97ae:	75 f0                	jne    97a0 <fwp_gc_sweep+0x4d0>
    97b0:	4c 01 e5             	add    %r12,%rbp
    97b3:	4d 01 e5             	add    %r12,%r13
    97b6:	49 ff cd             	dec    %r13
    97b9:	49 b9 55 55 55 55 55 	movabs $0x5555555555555555,%r9
    97c0:	55 55 55 
    97c3:	49 ba 33 33 33 33 33 	movabs $0x3333333333333333,%r10
    97ca:	33 33 33 
    97cd:	49 bb 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r11
    97d4:	0f 0f 0f 
    97d7:	49 bc 01 01 01 01 01 	movabs $0x101010101010101,%r12
    97de:	01 01 01 
    97e1:	e9 7d fb ff ff       	jmp    9363 <fwp_gc_sweep+0x93>
    97e6:	4c 89 ff             	mov    %r15,%rdi
    97e9:	e8 a2 cd ff ff       	call   6590 <fwp_rc_forget_slot>
    97ee:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    97f3:	66 0f 6f 3d e5 a8 00 	movdqa 0xa8e5(%rip),%xmm7        # 140e0 <_IO_stdin_used+0xe0>
    97fa:	00 
    97fb:	66 0f 6f 35 cd a8 00 	movdqa 0xa8cd(%rip),%xmm6        # 140d0 <_IO_stdin_used+0xd0>
    9802:	00 
    9803:	66 0f 6f 2d b5 a8 00 	movdqa 0xa8b5(%rip),%xmm5        # 140c0 <_IO_stdin_used+0xc0>
    980a:	00 
    980b:	e9 fe fb ff ff       	jmp    940e <fwp_gc_sweep+0x13e>
    9810:	31 c0                	xor    %eax,%eax
    9812:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    9817:	31 c0                	xor    %eax,%eax
    9819:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    981e:	48 89 15 2b 0c 01 00 	mov    %rdx,0x10c2b(%rip)        # 1a450 <fwp_gc+0x11c8>
    9825:	48 89 2d 3c 0c 01 00 	mov    %rbp,0x10c3c(%rip)        # 1a468 <fwp_gc+0x11e0>
    982c:	48 81 fa 01 00 00 01 	cmp    $0x1000001,%rdx
    9833:	b9 00 00 00 01       	mov    $0x1000000,%ecx
    9838:	48 0f 43 ca          	cmovae %rdx,%rcx
    983c:	48 c1 e9 10          	shr    $0x10,%rcx
    9840:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9844:	f3 0f 7f 05 a4 0a 01 	movdqu %xmm0,0x10aa4(%rip)        # 1a2f0 <fwp_gc+0x1068>
    984b:	00 
    984c:	48 29 cd             	sub    %rcx,%rbp
    984f:	0f 86 fc 00 00 00    	jbe    9951 <fwp_gc_sweep+0x681>
    9855:	48 85 c0             	test   %rax,%rax
    9858:	0f 84 f3 00 00 00    	je     9951 <fwp_gc_sweep+0x681>
    985e:	48 85 ed             	test   %rbp,%rbp
    9861:	0f 84 ea 00 00 00    	je     9951 <fwp_gc_sweep+0x681>
    9867:	48 8b 0d 92 0a 01 00 	mov    0x10a92(%rip),%rcx        # 1a300 <fwp_gc+0x1078>
    986e:	66 90                	xchg   %ax,%ax
    9870:	48 8d 58 ff          	lea    -0x1(%rax),%rbx
    9874:	48 69 d3 28 12 00 00 	imul   $0x1228,%rbx,%rdx
    987b:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
    987f:	0f 85 bb 00 00 00    	jne    9940 <fwp_gc_sweep+0x670>
    9885:	4c 8d 75 ff          	lea    -0x1(%rbp),%r14
    9889:	80 7c 11 04 00       	cmpb   $0x0,0x4(%rcx,%rdx,1)
    988e:	0f 84 a9 00 00 00    	je     993d <fwp_gc_sweep+0x66d>
    9894:	48 01 ca             	add    %rcx,%rdx
    9897:	48 83 c2 04          	add    $0x4,%rdx
    989b:	c6 02 00             	movb   $0x0,(%rdx)
    989e:	be 01 00 00 00       	mov    $0x1,%esi
    98a3:	48 85 db             	test   %rbx,%rbx
    98a6:	74 72                	je     991a <fwp_gc_sweep+0x64a>
    98a8:	4d 85 f6             	test   %r14,%r14
    98ab:	74 6d                	je     991a <fwp_gc_sweep+0x64a>
    98ad:	ba 02 00 00 00       	mov    $0x2,%edx
    98b2:	48 29 c2             	sub    %rax,%rdx
    98b5:	48 69 c0 28 12 00 00 	imul   $0x1228,%rax,%rax
    98bc:	48 01 c1             	add    %rax,%rcx
    98bf:	48 81 c1 b4 db ff ff 	add    $0xffffffffffffdbb4,%rcx
    98c6:	bf 02 00 00 00       	mov    $0x2,%edi
    98cb:	48 29 ef             	sub    %rbp,%rdi
    98ce:	b8 01 00 00 00       	mov    $0x1,%eax
    98d3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    98da:	84 00 00 00 00 00 
    98e0:	80 79 fc 00          	cmpb   $0x0,-0x4(%rcx)
    98e4:	75 31                	jne    9917 <fwp_gc_sweep+0x647>
    98e6:	80 39 00             	cmpb   $0x0,(%rcx)
    98e9:	74 2c                	je     9917 <fwp_gc_sweep+0x647>
    98eb:	48 ff cb             	dec    %rbx
    98ee:	4c 8d 04 02          	lea    (%rdx,%rax,1),%r8
    98f2:	49 ff ce             	dec    %r14
    98f5:	c6 01 00             	movb   $0x0,(%rcx)
    98f8:	48 8d 70 01          	lea    0x1(%rax),%rsi
    98fc:	49 83 f8 01          	cmp    $0x1,%r8
    9900:	74 18                	je     991a <fwp_gc_sweep+0x64a>
    9902:	48 01 f8             	add    %rdi,%rax
    9905:	48 81 c1 d8 ed ff ff 	add    $0xffffffffffffedd8,%rcx
    990c:	48 83 f8 01          	cmp    $0x1,%rax
    9910:	48 89 f0             	mov    %rsi,%rax
    9913:	75 cb                	jne    98e0 <fwp_gc_sweep+0x610>
    9915:	eb 03                	jmp    991a <fwp_gc_sweep+0x64a>
    9917:	48 89 c6             	mov    %rax,%rsi
    991a:	48 89 df             	mov    %rbx,%rdi
    991d:	48 c1 e7 10          	shl    $0x10,%rdi
    9921:	48 03 3d 90 09 01 00 	add    0x10990(%rip),%rdi        # 1a2b8 <fwp_gc+0x1030>
    9928:	48 c1 e6 10          	shl    $0x10,%rsi
    992c:	ba 04 00 00 00       	mov    $0x4,%edx
    9931:	e8 ba 9a ff ff       	call   33f0 <madvise@plt>
    9936:	48 8b 0d c3 09 01 00 	mov    0x109c3(%rip),%rcx        # 1a300 <fwp_gc+0x1078>
    993d:	4c 89 f5             	mov    %r14,%rbp
    9940:	48 89 d8             	mov    %rbx,%rax
    9943:	48 85 db             	test   %rbx,%rbx
    9946:	74 09                	je     9951 <fwp_gc_sweep+0x681>
    9948:	48 85 ed             	test   %rbp,%rbp
    994b:	0f 85 1f ff ff ff    	jne    9870 <fwp_gc_sweep+0x5a0>
    9951:	48 83 c4 28          	add    $0x28,%rsp
    9955:	5b                   	pop    %rbx
    9956:	41 5c                	pop    %r12
    9958:	41 5d                	pop    %r13
    995a:	41 5e                	pop    %r14
    995c:	41 5f                	pop    %r15
    995e:	5d                   	pop    %rbp
    995f:	c3                   	ret

0000000000009960 <fwp_gc_sp>:
    9960:	55                   	push   %rbp
    9961:	48 89 e5             	mov    %rsp,%rbp
    9964:	48 89 e8             	mov    %rbp,%rax
    9967:	5d                   	pop    %rbp
    9968:	c3                   	ret
    9969:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000009970 <fwp_gc_scan>:
    9970:	55                   	push   %rbp
    9971:	41 57                	push   %r15
    9973:	41 56                	push   %r14
    9975:	41 55                	push   %r13
    9977:	41 54                	push   %r12
    9979:	53                   	push   %rbx
    997a:	50                   	push   %rax
    997b:	49 89 ff             	mov    %rdi,%r15
    997e:	49 83 c7 07          	add    $0x7,%r15
    9982:	49 83 e7 f8          	and    $0xfffffffffffffff8,%r15
    9986:	49 8d 47 08          	lea    0x8(%r15),%rax
    998a:	48 39 f0             	cmp    %rsi,%rax
    998d:	76 0f                	jbe    999e <fwp_gc_scan+0x2e>
    998f:	48 83 c4 08          	add    $0x8,%rsp
    9993:	5b                   	pop    %rbx
    9994:	41 5c                	pop    %r12
    9996:	41 5d                	pop    %r13
    9998:	41 5e                	pop    %r14
    999a:	41 5f                	pop    %r15
    999c:	5d                   	pop    %rbp
    999d:	c3                   	ret
    999e:	89 d3                	mov    %edx,%ebx
    99a0:	49 89 f6             	mov    %rsi,%r14
    99a3:	4c 8b 25 0e 09 01 00 	mov    0x1090e(%rip),%r12        # 1a2b8 <fwp_gc+0x1030>
    99aa:	4c 8b 2d 2f 09 01 00 	mov    0x1092f(%rip),%r13        # 1a2e0 <fwp_gc+0x1058>
    99b1:	49 c1 e5 10          	shl    $0x10,%r13
    99b5:	eb 29                	jmp    99e0 <fwp_gc_scan+0x70>
    99b7:	4d 01 d0             	add    %r10,%r8
    99ba:	41 80 78 03 00       	cmpb   $0x0,0x3(%r8)
    99bf:	0f 84 a6 02 00 00    	je     9c6b <fwp_gc_scan+0x2fb>
    99c5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    99cc:	00 00 00 00 
    99d0:	49 8d 47 08          	lea    0x8(%r15),%rax
    99d4:	49 83 c7 10          	add    $0x10,%r15
    99d8:	4d 39 f7             	cmp    %r14,%r15
    99db:	49 89 c7             	mov    %rax,%r15
    99de:	77 af                	ja     998f <fwp_gc_scan+0x1f>
    99e0:	49 8b 2f             	mov    (%r15),%rbp
    99e3:	48 89 e8             	mov    %rbp,%rax
    99e6:	4c 29 e0             	sub    %r12,%rax
    99e9:	4c 39 e8             	cmp    %r13,%rax
    99ec:	0f 83 de 00 00 00    	jae    9ad0 <fwp_gc_scan+0x160>
    99f2:	48 8b 3d bf 08 01 00 	mov    0x108bf(%rip),%rdi        # 1a2b8 <fwp_gc+0x1030>
    99f9:	49 89 e9             	mov    %rbp,%r9
    99fc:	49 29 f9             	sub    %rdi,%r9
    99ff:	48 8b 05 da 08 01 00 	mov    0x108da(%rip),%rax        # 1a2e0 <fwp_gc+0x1058>
    9a06:	48 c1 e0 10          	shl    $0x10,%rax
    9a0a:	49 39 c1             	cmp    %rax,%r9
    9a0d:	0f 83 6d 01 00 00    	jae    9b80 <fwp_gc_scan+0x210>
    9a13:	4c 8b 05 e6 08 01 00 	mov    0x108e6(%rip),%r8        # 1a300 <fwp_gc+0x1078>
    9a1a:	4d 85 c0             	test   %r8,%r8
    9a1d:	0f 84 5d 01 00 00    	je     9b80 <fwp_gc_scan+0x210>
    9a23:	4c 89 c8             	mov    %r9,%rax
    9a26:	48 c1 e8 10          	shr    $0x10,%rax
    9a2a:	4c 69 d0 28 12 00 00 	imul   $0x1228,%rax,%r10
    9a31:	43 0f b6 0c 10       	movzbl (%r8,%r10,1),%ecx
    9a36:	83 f9 03             	cmp    $0x3,%ecx
    9a39:	0f 84 0c 01 00 00    	je     9b4b <fwp_gc_scan+0x1db>
    9a3f:	83 f9 02             	cmp    $0x2,%ecx
    9a42:	0f 84 f7 00 00 00    	je     9b3f <fwp_gc_scan+0x1cf>
    9a48:	83 f9 01             	cmp    $0x1,%ecx
    9a4b:	0f 85 2f 01 00 00    	jne    9b80 <fwp_gc_scan+0x210>
    9a51:	43 8b 4c 10 08       	mov    0x8(%r8,%r10,1),%ecx
    9a56:	0f b7 c5             	movzwl %bp,%eax
    9a59:	31 d2                	xor    %edx,%edx
    9a5b:	48 89 0c 24          	mov    %rcx,(%rsp)
    9a5f:	f7 f1                	div    %ecx
    9a61:	43 3b 44 10 0c       	cmp    0xc(%r8,%r10,1),%eax
    9a66:	0f 83 14 01 00 00    	jae    9b80 <fwp_gc_scan+0x210>
    9a6c:	ba 01 00 00 00       	mov    $0x1,%edx
    9a71:	89 c1                	mov    %eax,%ecx
    9a73:	48 d3 e2             	shl    %cl,%rdx
    9a76:	4b 8d 34 10          	lea    (%r8,%r10,1),%rsi
    9a7a:	41 89 c3             	mov    %eax,%r11d
    9a7d:	41 c1 eb 06          	shr    $0x6,%r11d
    9a81:	4a 8b 4c de 28       	mov    0x28(%rsi,%r11,8),%rcx
    9a86:	48 0f a3 c1          	bt     %rax,%rcx
    9a8a:	0f 82 f0 00 00 00    	jb     9b80 <fwp_gc_scan+0x210>
    9a90:	4a 8d 34 de          	lea    (%rsi,%r11,8),%rsi
    9a94:	48 83 c6 28          	add    $0x28,%rsi
    9a98:	48 09 d1             	or     %rdx,%rcx
    9a9b:	48 89 0e             	mov    %rcx,(%rsi)
    9a9e:	43 80 7c 10 01 01    	cmpb   $0x1,0x1(%r8,%r10,1)
    9aa4:	0f 84 d6 00 00 00    	je     9b80 <fwp_gc_scan+0x210>
    9aaa:	49 81 e1 00 00 ff ff 	and    $0xffffffffffff0000,%r9
    9ab1:	4c 01 cf             	add    %r9,%rdi
    9ab4:	48 8b 34 24          	mov    (%rsp),%rsi
    9ab8:	48 0f af c6          	imul   %rsi,%rax
    9abc:	48 01 f8             	add    %rdi,%rax
    9abf:	48 89 c7             	mov    %rax,%rdi
    9ac2:	e9 b1 00 00 00       	jmp    9b78 <fwp_gc_scan+0x208>
    9ac7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    9ace:	00 00 
    9ad0:	85 db                	test   %ebx,%ebx
    9ad2:	0f 84 f8 fe ff ff    	je     99d0 <fwp_gc_scan+0x60>
    9ad8:	4c 39 e8             	cmp    %r13,%rax
    9adb:	0f 85 ef fe ff ff    	jne    99d0 <fwp_gc_scan+0x60>
    9ae1:	48 ff cd             	dec    %rbp
    9ae4:	48 8b 3d cd 07 01 00 	mov    0x107cd(%rip),%rdi        # 1a2b8 <fwp_gc+0x1030>
    9aeb:	49 89 e9             	mov    %rbp,%r9
    9aee:	49 29 f9             	sub    %rdi,%r9
    9af1:	48 8b 05 e8 07 01 00 	mov    0x107e8(%rip),%rax        # 1a2e0 <fwp_gc+0x1058>
    9af8:	48 c1 e0 10          	shl    $0x10,%rax
    9afc:	49 39 c1             	cmp    %rax,%r9
    9aff:	0f 83 cb fe ff ff    	jae    99d0 <fwp_gc_scan+0x60>
    9b05:	4c 8b 05 f4 07 01 00 	mov    0x107f4(%rip),%r8        # 1a300 <fwp_gc+0x1078>
    9b0c:	4d 85 c0             	test   %r8,%r8
    9b0f:	0f 84 bb fe ff ff    	je     99d0 <fwp_gc_scan+0x60>
    9b15:	4c 89 c8             	mov    %r9,%rax
    9b18:	48 c1 e8 10          	shr    $0x10,%rax
    9b1c:	4c 69 d0 28 12 00 00 	imul   $0x1228,%rax,%r10
    9b23:	43 0f b6 0c 10       	movzbl (%r8,%r10,1),%ecx
    9b28:	83 f9 03             	cmp    $0x3,%ecx
    9b2b:	0f 84 20 01 00 00    	je     9c51 <fwp_gc_scan+0x2e1>
    9b31:	83 f9 02             	cmp    $0x2,%ecx
    9b34:	0f 85 a3 00 00 00    	jne    9bdd <fwp_gc_scan+0x26d>
    9b3a:	e9 78 fe ff ff       	jmp    99b7 <fwp_gc_scan+0x47>
    9b3f:	4d 01 d0             	add    %r10,%r8
    9b42:	41 80 78 03 00       	cmpb   $0x0,0x3(%r8)
    9b47:	75 37                	jne    9b80 <fwp_gc_scan+0x210>
    9b49:	eb 16                	jmp    9b61 <fwp_gc_scan+0x1f1>
    9b4b:	43 8b 44 10 10       	mov    0x10(%r8,%r10,1),%eax
    9b50:	48 69 c8 28 12 00 00 	imul   $0x1228,%rax,%rcx
    9b57:	49 01 c8             	add    %rcx,%r8
    9b5a:	41 80 78 03 00       	cmpb   $0x0,0x3(%r8)
    9b5f:	75 1f                	jne    9b80 <fwp_gc_scan+0x210>
    9b61:	41 c6 40 03 01       	movb   $0x1,0x3(%r8)
    9b66:	41 80 78 01 01       	cmpb   $0x1,0x1(%r8)
    9b6b:	74 13                	je     9b80 <fwp_gc_scan+0x210>
    9b6d:	48 c1 e0 10          	shl    $0x10,%rax
    9b71:	48 01 c7             	add    %rax,%rdi
    9b74:	49 8b 70 18          	mov    0x18(%r8),%rsi
    9b78:	e8 13 01 00 00       	call   9c90 <fwp_gc_push>
    9b7d:	0f 1f 00             	nopl   (%rax)
    9b80:	85 db                	test   %ebx,%ebx
    9b82:	0f 84 48 fe ff ff    	je     99d0 <fwp_gc_scan+0x60>
    9b88:	48 ff cd             	dec    %rbp
    9b8b:	48 8b 3d 26 07 01 00 	mov    0x10726(%rip),%rdi        # 1a2b8 <fwp_gc+0x1030>
    9b92:	49 89 e9             	mov    %rbp,%r9
    9b95:	49 29 f9             	sub    %rdi,%r9
    9b98:	48 8b 05 41 07 01 00 	mov    0x10741(%rip),%rax        # 1a2e0 <fwp_gc+0x1058>
    9b9f:	48 c1 e0 10          	shl    $0x10,%rax
    9ba3:	49 39 c1             	cmp    %rax,%r9
    9ba6:	0f 83 24 fe ff ff    	jae    99d0 <fwp_gc_scan+0x60>
    9bac:	4c 8b 05 4d 07 01 00 	mov    0x1074d(%rip),%r8        # 1a300 <fwp_gc+0x1078>
    9bb3:	4d 85 c0             	test   %r8,%r8
    9bb6:	0f 84 14 fe ff ff    	je     99d0 <fwp_gc_scan+0x60>
    9bbc:	4c 89 c8             	mov    %r9,%rax
    9bbf:	48 c1 e8 10          	shr    $0x10,%rax
    9bc3:	4c 69 d0 28 12 00 00 	imul   $0x1228,%rax,%r10
    9bca:	43 0f b6 0c 10       	movzbl (%r8,%r10,1),%ecx
    9bcf:	83 f9 03             	cmp    $0x3,%ecx
    9bd2:	74 7d                	je     9c51 <fwp_gc_scan+0x2e1>
    9bd4:	83 f9 02             	cmp    $0x2,%ecx
    9bd7:	0f 84 da fd ff ff    	je     99b7 <fwp_gc_scan+0x47>
    9bdd:	83 f9 01             	cmp    $0x1,%ecx
    9be0:	0f 85 ea fd ff ff    	jne    99d0 <fwp_gc_scan+0x60>
    9be6:	43 8b 74 10 08       	mov    0x8(%r8,%r10,1),%esi
    9beb:	0f b7 c5             	movzwl %bp,%eax
    9bee:	31 d2                	xor    %edx,%edx
    9bf0:	f7 f6                	div    %esi
    9bf2:	43 3b 44 10 0c       	cmp    0xc(%r8,%r10,1),%eax
    9bf7:	0f 83 d3 fd ff ff    	jae    99d0 <fwp_gc_scan+0x60>
    9bfd:	ba 01 00 00 00       	mov    $0x1,%edx
    9c02:	89 c1                	mov    %eax,%ecx
    9c04:	48 d3 e2             	shl    %cl,%rdx
    9c07:	4b 8d 0c 10          	lea    (%r8,%r10,1),%rcx
    9c0b:	41 89 c3             	mov    %eax,%r11d
    9c0e:	41 c1 eb 06          	shr    $0x6,%r11d
    9c12:	4a 8b 6c d9 28       	mov    0x28(%rcx,%r11,8),%rbp
    9c17:	48 0f a3 c5          	bt     %rax,%rbp
    9c1b:	0f 82 af fd ff ff    	jb     99d0 <fwp_gc_scan+0x60>
    9c21:	4a 8d 0c d9          	lea    (%rcx,%r11,8),%rcx
    9c25:	48 83 c1 28          	add    $0x28,%rcx
    9c29:	48 09 d5             	or     %rdx,%rbp
    9c2c:	48 89 29             	mov    %rbp,(%rcx)
    9c2f:	43 80 7c 10 01 01    	cmpb   $0x1,0x1(%r8,%r10,1)
    9c35:	0f 84 95 fd ff ff    	je     99d0 <fwp_gc_scan+0x60>
    9c3b:	49 81 e1 00 00 ff ff 	and    $0xffffffffffff0000,%r9
    9c42:	4c 01 cf             	add    %r9,%rdi
    9c45:	48 0f af c6          	imul   %rsi,%rax
    9c49:	48 01 f8             	add    %rdi,%rax
    9c4c:	48 89 c7             	mov    %rax,%rdi
    9c4f:	eb 35                	jmp    9c86 <fwp_gc_scan+0x316>
    9c51:	43 8b 44 10 10       	mov    0x10(%r8,%r10,1),%eax
    9c56:	48 69 c8 28 12 00 00 	imul   $0x1228,%rax,%rcx
    9c5d:	49 01 c8             	add    %rcx,%r8
    9c60:	41 80 78 03 00       	cmpb   $0x0,0x3(%r8)
    9c65:	0f 85 65 fd ff ff    	jne    99d0 <fwp_gc_scan+0x60>
    9c6b:	41 c6 40 03 01       	movb   $0x1,0x3(%r8)
    9c70:	41 80 78 01 01       	cmpb   $0x1,0x1(%r8)
    9c75:	0f 84 55 fd ff ff    	je     99d0 <fwp_gc_scan+0x60>
    9c7b:	48 c1 e0 10          	shl    $0x10,%rax
    9c7f:	48 01 c7             	add    %rax,%rdi
    9c82:	49 8b 70 18          	mov    0x18(%r8),%rsi
    9c86:	e8 05 00 00 00       	call   9c90 <fwp_gc_push>
    9c8b:	e9 40 fd ff ff       	jmp    99d0 <fwp_gc_scan+0x60>

0000000000009c90 <fwp_gc_push>:
    9c90:	41 56                	push   %r14
    9c92:	53                   	push   %rbx
    9c93:	50                   	push   %rax
    9c94:	48 89 f3             	mov    %rsi,%rbx
    9c97:	49 89 fe             	mov    %rdi,%r14
    9c9a:	48 8b 0d 87 07 01 00 	mov    0x10787(%rip),%rcx        # 1a428 <fwp_gc+0x11a0>
    9ca1:	48 8b 05 78 07 01 00 	mov    0x10778(%rip),%rax        # 1a420 <fwp_gc+0x1198>
    9ca8:	48 3b 0d 81 07 01 00 	cmp    0x10781(%rip),%rcx        # 1a430 <fwp_gc+0x11a8>
    9caf:	75 36                	jne    9ce7 <fwp_gc_push+0x57>
    9cb1:	48 8d 14 09          	lea    (%rcx,%rcx,1),%rdx
    9cb5:	48 85 c9             	test   %rcx,%rcx
    9cb8:	be 00 10 00 00       	mov    $0x1000,%esi
    9cbd:	48 0f 45 f2          	cmovne %rdx,%rsi
    9cc1:	48 89 35 68 07 01 00 	mov    %rsi,0x10768(%rip)        # 1a430 <fwp_gc+0x11a8>
    9cc8:	48 c1 e6 04          	shl    $0x4,%rsi
    9ccc:	48 89 c7             	mov    %rax,%rdi
    9ccf:	e8 ac 96 ff ff       	call   3380 <realloc@plt>
    9cd4:	48 89 05 45 07 01 00 	mov    %rax,0x10745(%rip)        # 1a420 <fwp_gc+0x1198>
    9cdb:	48 85 c0             	test   %rax,%rax
    9cde:	74 29                	je     9d09 <fwp_gc_push+0x79>
    9ce0:	48 8b 0d 41 07 01 00 	mov    0x10741(%rip),%rcx        # 1a428 <fwp_gc+0x11a0>
    9ce7:	48 89 ca             	mov    %rcx,%rdx
    9cea:	48 c1 e2 04          	shl    $0x4,%rdx
    9cee:	4c 89 34 10          	mov    %r14,(%rax,%rdx,1)
    9cf2:	48 89 5c 10 08       	mov    %rbx,0x8(%rax,%rdx,1)
    9cf7:	48 ff c1             	inc    %rcx
    9cfa:	48 89 0d 27 07 01 00 	mov    %rcx,0x10727(%rip)        # 1a428 <fwp_gc+0x11a0>
    9d01:	48 83 c4 08          	add    $0x8,%rsp
    9d05:	5b                   	pop    %rbx
    9d06:	41 5e                	pop    %r14
    9d08:	c3                   	ret
    9d09:	48 8b 05 c8 f2 00 00 	mov    0xf2c8(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    9d10:	48 8b 08             	mov    (%rax),%rcx
    9d13:	48 8d 3d 8c ad 00 00 	lea    0xad8c(%rip),%rdi        # 14aa6 <exec_in_fp0+0x296>
    9d1a:	be 13 00 00 00       	mov    $0x13,%esi
    9d1f:	ba 01 00 00 00       	mov    $0x1,%edx
    9d24:	e8 57 97 ff ff       	call   3480 <fwrite@plt>
    9d29:	bf 66 00 00 00       	mov    $0x66,%edi
    9d2e:	e8 2d 97 ff ff       	call   3460 <exit@plt>
    9d33:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9d3a:	84 00 00 00 00 00 

0000000000009d40 <fwp_closure_drop>:
    9d40:	41 57                	push   %r15
    9d42:	41 56                	push   %r14
    9d44:	53                   	push   %rbx
    9d45:	48 81 ec 30 02 00 00 	sub    $0x230,%rsp
    9d4c:	48 89 f8             	mov    %rdi,%rax
    9d4f:	48 2b 05 62 05 01 00 	sub    0x10562(%rip),%rax        # 1a2b8 <fwp_gc+0x1030>
    9d56:	48 8b 0d 83 05 01 00 	mov    0x10583(%rip),%rcx        # 1a2e0 <fwp_gc+0x1058>
    9d5d:	48 c1 e1 10          	shl    $0x10,%rcx
    9d61:	48 39 c8             	cmp    %rcx,%rax
    9d64:	0f 83 91 00 00 00    	jae    9dfb <fwp_closure_drop+0xbb>
    9d6a:	48 89 fe             	mov    %rdi,%rsi
    9d6d:	48 8b 0d 8c 05 01 00 	mov    0x1058c(%rip),%rcx        # 1a300 <fwp_gc+0x1078>
    9d74:	48 89 c2             	mov    %rax,%rdx
    9d77:	48 c1 ea 10          	shr    $0x10,%rdx
    9d7b:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    9d82:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
    9d86:	48 25 ff ff 00 00    	and    $0xffff,%rax
    9d8c:	75 13                	jne    9da1 <fwp_closure_drop+0x61>
    9d8e:	40 80 ff 02          	cmp    $0x2,%dil
    9d92:	75 0d                	jne    9da1 <fwp_closure_drop+0x61>
    9d94:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    9d98:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    9d9f:	eb 20                	jmp    9dc1 <fwp_closure_drop+0x81>
    9da1:	40 80 ff 01          	cmp    $0x1,%dil
    9da5:	75 54                	jne    9dfb <fwp_closure_drop+0xbb>
    9da7:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    9dab:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    9daf:	48 0f af c1          	imul   %rcx,%rax
    9db3:	48 c1 e8 20          	shr    $0x20,%rax
    9db7:	48 01 c7             	add    %rax,%rdi
    9dba:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    9dc1:	0f b6 07             	movzbl (%rdi),%eax
    9dc4:	85 c0                	test   %eax,%eax
    9dc6:	74 33                	je     9dfb <fwp_closure_drop+0xbb>
    9dc8:	83 f8 01             	cmp    $0x1,%eax
    9dcb:	75 1f                	jne    9dec <fwp_closure_drop+0xac>
    9dcd:	64 48 8b 3c 25 f8 ff 	mov    %fs:0xfffffffffffffff8,%rdi
    9dd4:	ff ff 
    9dd6:	48 85 ff             	test   %rdi,%rdi
    9dd9:	74 2d                	je     9e08 <fwp_closure_drop+0xc8>
    9ddb:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    9de2:	5b                   	pop    %rbx
    9de3:	41 5e                	pop    %r14
    9de5:	41 5f                	pop    %r15
    9de7:	e9 44 01 00 00       	jmp    9f30 <fwp_closure_drop_push>
    9dec:	3d ff 00 00 00       	cmp    $0xff,%eax
    9df1:	0f 84 e7 00 00 00    	je     9ede <fwp_closure_drop+0x19e>
    9df7:	fe c8                	dec    %al
    9df9:	88 07                	mov    %al,(%rdi)
    9dfb:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    9e02:	5b                   	pop    %rbx
    9e03:	41 5e                	pop    %r14
    9e05:	41 5f                	pop    %r15
    9e07:	c3                   	ret
    9e08:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
    9e0f:	00 00 
    9e11:	4c 8d b0 f8 ff ff ff 	lea    -0x8(%rax),%r14
    9e18:	48 8d 5c 24 30       	lea    0x30(%rsp),%rbx
    9e1d:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    9e22:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    9e29:	00 00 
    9e2b:	48 c7 44 24 28 40 00 	movq   $0x40,0x28(%rsp)
    9e32:	00 00 
    9e34:	48 ff 05 05 0f 01 00 	incq   0x10f05(%rip)        # 1ad40 <measured_scopes>
    9e3b:	48 8b 05 06 0f 01 00 	mov    0x10f06(%rip),%rax        # 1ad48 <fwp_cleanups>
    9e42:	48 89 04 24          	mov    %rax,(%rsp)
    9e46:	48 8d 05 c3 01 00 00 	lea    0x1c3(%rip),%rax        # a010 <fwp_closure_drop_release>
    9e4d:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    9e52:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    9e57:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    9e5c:	49 89 e7             	mov    %rsp,%r15
    9e5f:	4c 89 3d e2 0e 01 00 	mov    %r15,0x10ee2(%rip)        # 1ad48 <fwp_cleanups>
    9e66:	49 89 3e             	mov    %rdi,(%r14)
    9e69:	e8 c2 00 00 00       	call   9f30 <fwp_closure_drop_push>
    9e6e:	66 90                	xchg   %ax,%ax
    9e70:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    9e75:	48 85 c0             	test   %rax,%rax
    9e78:	74 31                	je     9eab <fwp_closure_drop+0x16b>
    9e7a:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    9e7f:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    9e83:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
    9e88:	48 8b 7c c1 f8       	mov    -0x8(%rcx,%rax,8),%rdi
    9e8d:	48 8b 05 5c 0e 01 00 	mov    0x10e5c(%rip),%rax        # 1acf0 <fwp_fns>
    9e94:	8b 0f                	mov    (%rdi),%ecx
    9e96:	48 c1 e1 05          	shl    $0x5,%rcx
    9e9a:	48 8b 44 08 18       	mov    0x18(%rax,%rcx,1),%rax
    9e9f:	48 85 c0             	test   %rax,%rax
    9ea2:	74 4b                	je     9eef <fwp_closure_drop+0x1af>
    9ea4:	31 f6                	xor    %esi,%esi
    9ea6:	ff 50 08             	call   *0x8(%rax)
    9ea9:	eb c5                	jmp    9e70 <fwp_closure_drop+0x130>
    9eab:	4c 39 3d 96 0e 01 00 	cmp    %r15,0x10e96(%rip)        # 1ad48 <fwp_cleanups>
    9eb2:	75 69                	jne    9f1d <fwp_closure_drop+0x1dd>
    9eb4:	48 8b 04 24          	mov    (%rsp),%rax
    9eb8:	48 89 05 89 0e 01 00 	mov    %rax,0x10e89(%rip)        # 1ad48 <fwp_cleanups>
    9ebf:	49 c7 06 00 00 00 00 	movq   $0x0,(%r14)
    9ec6:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    9ecb:	48 39 df             	cmp    %rbx,%rdi
    9ece:	0f 84 27 ff ff ff    	je     9dfb <fwp_closure_drop+0xbb>
    9ed4:	e8 77 91 ff ff       	call   3050 <free@plt>
    9ed9:	e9 1d ff ff ff       	jmp    9dfb <fwp_closure_drop+0xbb>
    9ede:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    9ee5:	5b                   	pop    %rbx
    9ee6:	41 5e                	pop    %r14
    9ee8:	41 5f                	pop    %r15
    9eea:	e9 61 01 00 00       	jmp    a050 <fwp_rc_wide_drop>
    9eef:	e8 4c c7 ff ff       	call   6640 <fwp_flush>
    9ef4:	48 8b 05 dd f0 00 00 	mov    0xf0dd(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    9efb:	48 8b 38             	mov    (%rax),%rdi
    9efe:	48 8d 35 49 ab 00 00 	lea    0xab49(%rip),%rsi        # 14a4e <exec_in_fp0+0x23e>
    9f05:	48 8d 15 60 ac 00 00 	lea    0xac60(%rip),%rdx        # 14b6c <exec_in_fp0+0x35c>
    9f0c:	31 c0                	xor    %eax,%eax
    9f0e:	e8 dd 93 ff ff       	call   32f0 <fprintf@plt>
    9f13:	bf 65 00 00 00       	mov    $0x65,%edi
    9f18:	e8 43 95 ff ff       	call   3460 <exit@plt>
    9f1d:	e8 4e 91 ff ff       	call   3070 <abort@plt>
    9f22:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9f29:	1f 84 00 00 00 00 00 

0000000000009f30 <fwp_closure_drop_push>:
    9f30:	55                   	push   %rbp
    9f31:	41 57                	push   %r15
    9f33:	41 56                	push   %r14
    9f35:	41 55                	push   %r13
    9f37:	41 54                	push   %r12
    9f39:	53                   	push   %rbx
    9f3a:	50                   	push   %rax
    9f3b:	48 89 f3             	mov    %rsi,%rbx
    9f3e:	49 89 fe             	mov    %rdi,%r14
    9f41:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    9f45:	4c 3b 6f 10          	cmp    0x10(%rdi),%r13
    9f49:	75 59                	jne    9fa4 <fwp_closure_drop_push+0x74>
    9f4b:	4c 89 e8             	mov    %r13,%rax
    9f4e:	48 c1 e8 3c          	shr    $0x3c,%rax
    9f52:	75 6e                	jne    9fc2 <fwp_closure_drop_push+0x92>
    9f54:	4c 89 ef             	mov    %r13,%rdi
    9f57:	48 c1 e7 04          	shl    $0x4,%rdi
    9f5b:	e8 e0 93 ff ff       	call   3340 <malloc@plt>
    9f60:	48 85 c0             	test   %rax,%rax
    9f63:	74 7c                	je     9fe1 <fwp_closure_drop_push+0xb1>
    9f65:	49 89 c7             	mov    %rax,%r15
    9f68:	4a 8d 2c 6d 00 00 00 	lea    0x0(,%r13,2),%rbp
    9f6f:	00 
    9f70:	4d 8b 26             	mov    (%r14),%r12
    9f73:	4a 8d 14 ed 00 00 00 	lea    0x0(,%r13,8),%rdx
    9f7a:	00 
    9f7b:	48 89 c7             	mov    %rax,%rdi
    9f7e:	4c 89 e6             	mov    %r12,%rsi
    9f81:	e8 aa 93 ff ff       	call   3330 <memcpy@plt>
    9f86:	49 8d 46 18          	lea    0x18(%r14),%rax
    9f8a:	49 39 c4             	cmp    %rax,%r12
    9f8d:	74 0c                	je     9f9b <fwp_closure_drop_push+0x6b>
    9f8f:	4c 89 e7             	mov    %r12,%rdi
    9f92:	e8 b9 90 ff ff       	call   3050 <free@plt>
    9f97:	4d 8b 6e 08          	mov    0x8(%r14),%r13
    9f9b:	4d 89 3e             	mov    %r15,(%r14)
    9f9e:	49 89 6e 10          	mov    %rbp,0x10(%r14)
    9fa2:	eb 03                	jmp    9fa7 <fwp_closure_drop_push+0x77>
    9fa4:	4d 8b 3e             	mov    (%r14),%r15
    9fa7:	49 8d 45 01          	lea    0x1(%r13),%rax
    9fab:	49 89 46 08          	mov    %rax,0x8(%r14)
    9faf:	4b 89 1c ef          	mov    %rbx,(%r15,%r13,8)
    9fb3:	48 83 c4 08          	add    $0x8,%rsp
    9fb7:	5b                   	pop    %rbx
    9fb8:	41 5c                	pop    %r12
    9fba:	41 5d                	pop    %r13
    9fbc:	41 5e                	pop    %r14
    9fbe:	41 5f                	pop    %r15
    9fc0:	5d                   	pop    %rbp
    9fc1:	c3                   	ret
    9fc2:	e8 79 c6 ff ff       	call   6640 <fwp_flush>
    9fc7:	48 8b 05 0a f0 00 00 	mov    0xf00a(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    9fce:	48 8b 38             	mov    (%rax),%rdi
    9fd1:	48 8d 35 76 aa 00 00 	lea    0xaa76(%rip),%rsi        # 14a4e <exec_in_fp0+0x23e>
    9fd8:	48 8d 15 bb ab 00 00 	lea    0xabbb(%rip),%rdx        # 14b9a <exec_in_fp0+0x38a>
    9fdf:	eb 1d                	jmp    9ffe <fwp_closure_drop_push+0xce>
    9fe1:	e8 5a c6 ff ff       	call   6640 <fwp_flush>
    9fe6:	48 8b 05 eb ef 00 00 	mov    0xefeb(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    9fed:	48 8b 38             	mov    (%rax),%rdi
    9ff0:	48 8d 35 57 aa 00 00 	lea    0xaa57(%rip),%rsi        # 14a4e <exec_in_fp0+0x23e>
    9ff7:	48 8d 15 b6 ab 00 00 	lea    0xabb6(%rip),%rdx        # 14bb4 <exec_in_fp0+0x3a4>
    9ffe:	31 c0                	xor    %eax,%eax
    a000:	e8 eb 92 ff ff       	call   32f0 <fprintf@plt>
    a005:	bf 65 00 00 00       	mov    $0x65,%edi
    a00a:	e8 51 94 ff ff       	call   3460 <exit@plt>
    a00f:	90                   	nop

000000000000a010 <fwp_closure_drop_release>:
    a010:	41 56                	push   %r14
    a012:	53                   	push   %rbx
    a013:	50                   	push   %rax
    a014:	48 89 fb             	mov    %rdi,%rbx
    a017:	64 48 c7 04 25 f8 ff 	movq   $0x0,%fs:0xfffffffffffffff8
    a01e:	ff ff 00 00 00 00 
    a024:	48 8b 3f             	mov    (%rdi),%rdi
    a027:	4c 8d 73 18          	lea    0x18(%rbx),%r14
    a02b:	4c 39 f7             	cmp    %r14,%rdi
    a02e:	74 05                	je     a035 <fwp_closure_drop_release+0x25>
    a030:	e8 1b 90 ff ff       	call   3050 <free@plt>
    a035:	4c 89 33             	mov    %r14,(%rbx)
    a038:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
    a03f:	00 
    a040:	48 83 c4 08          	add    $0x8,%rsp
    a044:	5b                   	pop    %rbx
    a045:	41 5e                	pop    %r14
    a047:	c3                   	ret
    a048:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a04f:	00 

000000000000a050 <fwp_rc_wide_drop>:
    a050:	53                   	push   %rbx
    a051:	48 89 f8             	mov    %rdi,%rax
    a054:	48 c1 e8 11          	shr    $0x11,%rax
    a058:	31 f8                	xor    %edi,%eax
    a05a:	89 c1                	mov    %eax,%ecx
    a05c:	c1 e9 09             	shr    $0x9,%ecx
    a05f:	31 c1                	xor    %eax,%ecx
    a061:	0f b6 c1             	movzbl %cl,%eax
    a064:	48 8d 0d 1d f2 00 00 	lea    0xf21d(%rip),%rcx        # 19288 <fwp_gc>
    a06b:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    a072:	00 
    a073:	48 85 c0             	test   %rax,%rax
    a076:	74 16                	je     a08e <fwp_rc_wide_drop+0x3e>
    a078:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a07f:	00 
    a080:	48 39 38             	cmp    %rdi,(%rax)
    a083:	74 37                	je     a0bc <fwp_rc_wide_drop+0x6c>
    a085:	48 8b 40 10          	mov    0x10(%rax),%rax
    a089:	48 85 c0             	test   %rax,%rax
    a08c:	75 f2                	jne    a080 <fwp_rc_wide_drop+0x30>
    a08e:	e8 ad c5 ff ff       	call   6640 <fwp_flush>
    a093:	48 8b 05 3e ef 00 00 	mov    0xef3e(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    a09a:	48 8b 38             	mov    (%rax),%rdi
    a09d:	48 8d 35 aa a9 00 00 	lea    0xa9aa(%rip),%rsi        # 14a4e <exec_in_fp0+0x23e>
    a0a4:	48 8d 15 7c a9 00 00 	lea    0xa97c(%rip),%rdx        # 14a27 <exec_in_fp0+0x217>
    a0ab:	31 c0                	xor    %eax,%eax
    a0ad:	e8 3e 92 ff ff       	call   32f0 <fprintf@plt>
    a0b2:	bf 65 00 00 00       	mov    $0x65,%edi
    a0b7:	e8 a4 93 ff ff       	call   3460 <exit@plt>
    a0bc:	48 8b 48 08          	mov    0x8(%rax),%rcx
    a0c0:	48 ff c9             	dec    %rcx
    a0c3:	48 89 48 08          	mov    %rcx,0x8(%rax)
    a0c7:	48 81 f9 fe 00 00 00 	cmp    $0xfe,%rcx
    a0ce:	75 0b                	jne    a0db <fwp_rc_wide_drop+0x8b>
    a0d0:	48 89 fb             	mov    %rdi,%rbx
    a0d3:	e8 b8 c4 ff ff       	call   6590 <fwp_rc_forget_slot>
    a0d8:	c6 03 fe             	movb   $0xfe,(%rbx)
    a0db:	5b                   	pop    %rbx
    a0dc:	c3                   	ret
    a0dd:	0f 1f 00             	nopl   (%rax)

000000000000a0e0 <fwp_rc_wide_dup>:
    a0e0:	41 56                	push   %r14
    a0e2:	53                   	push   %rbx
    a0e3:	50                   	push   %rax
    a0e4:	48 89 fb             	mov    %rdi,%rbx
    a0e7:	48 89 f8             	mov    %rdi,%rax
    a0ea:	48 c1 e8 11          	shr    $0x11,%rax
    a0ee:	31 d8                	xor    %ebx,%eax
    a0f0:	89 c1                	mov    %eax,%ecx
    a0f2:	c1 e9 09             	shr    $0x9,%ecx
    a0f5:	31 c1                	xor    %eax,%ecx
    a0f7:	0f b6 c1             	movzbl %cl,%eax
    a0fa:	48 8d 0d 87 f1 00 00 	lea    0xf187(%rip),%rcx        # 19288 <fwp_gc>
    a101:	4c 8d 34 c1          	lea    (%rcx,%rax,8),%r14
    a105:	49 81 c6 18 12 00 00 	add    $0x1218,%r14
    a10c:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    a113:	00 
    a114:	48 85 c0             	test   %rax,%rax
    a117:	74 1a                	je     a133 <fwp_rc_wide_dup+0x53>
    a119:	48 39 18             	cmp    %rbx,(%rax)
    a11c:	74 22                	je     a140 <fwp_rc_wide_dup+0x60>
    a11e:	66 90                	xchg   %ax,%ax
    a120:	49 89 c6             	mov    %rax,%r14
    a123:	48 8b 40 10          	mov    0x10(%rax),%rax
    a127:	48 85 c0             	test   %rax,%rax
    a12a:	74 0e                	je     a13a <fwp_rc_wide_dup+0x5a>
    a12c:	48 39 18             	cmp    %rbx,(%rax)
    a12f:	75 ef                	jne    a120 <fwp_rc_wide_dup+0x40>
    a131:	eb 09                	jmp    a13c <fwp_rc_wide_dup+0x5c>
    a133:	80 3b fe             	cmpb   $0xfe,(%rbx)
    a136:	74 16                	je     a14e <fwp_rc_wide_dup+0x6e>
    a138:	eb 6d                	jmp    a1a7 <fwp_rc_wide_dup+0xc7>
    a13a:	31 c0                	xor    %eax,%eax
    a13c:	49 83 c6 10          	add    $0x10,%r14
    a140:	80 3b fe             	cmpb   $0xfe,(%rbx)
    a143:	75 41                	jne    a186 <fwp_rc_wide_dup+0xa6>
    a145:	48 85 c0             	test   %rax,%rax
    a148:	0f 85 a2 00 00 00    	jne    a1f0 <fwp_rc_wide_dup+0x110>
    a14e:	bf 18 00 00 00       	mov    $0x18,%edi
    a153:	e8 e8 91 ff ff       	call   3340 <malloc@plt>
    a158:	48 85 c0             	test   %rax,%rax
    a15b:	74 69                	je     a1c6 <fwp_rc_wide_dup+0xe6>
    a15d:	48 89 18             	mov    %rbx,(%rax)
    a160:	48 c7 40 08 ff 00 00 	movq   $0xff,0x8(%rax)
    a167:	00 
    a168:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
    a16f:	00 
    a170:	49 89 06             	mov    %rax,(%r14)
    a173:	c6 03 ff             	movb   $0xff,(%rbx)
    a176:	48 8d 05 23 0b 01 00 	lea    0x10b23(%rip),%rax        # 1aca0 <fwp_gc+0x1a18>
    a17d:	48 8b 0d 1c 0b 01 00 	mov    0x10b1c(%rip),%rcx        # 1aca0 <fwp_gc+0x1a18>
    a184:	eb 13                	jmp    a199 <fwp_rc_wide_dup+0xb9>
    a186:	48 85 c0             	test   %rax,%rax
    a189:	74 1c                	je     a1a7 <fwp_rc_wide_dup+0xc7>
    a18b:	48 8b 48 08          	mov    0x8(%rax),%rcx
    a18f:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
    a193:	74 7a                	je     a20f <fwp_rc_wide_dup+0x12f>
    a195:	48 83 c0 08          	add    $0x8,%rax
    a199:	48 ff c1             	inc    %rcx
    a19c:	48 89 08             	mov    %rcx,(%rax)
    a19f:	48 83 c4 08          	add    $0x8,%rsp
    a1a3:	5b                   	pop    %rbx
    a1a4:	41 5e                	pop    %r14
    a1a6:	c3                   	ret
    a1a7:	e8 94 c4 ff ff       	call   6640 <fwp_flush>
    a1ac:	48 8b 05 25 ee 00 00 	mov    0xee25(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    a1b3:	48 8b 38             	mov    (%rax),%rdi
    a1b6:	48 8d 35 91 a8 00 00 	lea    0xa891(%rip),%rsi        # 14a4e <exec_in_fp0+0x23e>
    a1bd:	48 8d 15 63 a8 00 00 	lea    0xa863(%rip),%rdx        # 14a27 <exec_in_fp0+0x217>
    a1c4:	eb 66                	jmp    a22c <fwp_rc_wide_dup+0x14c>
    a1c6:	48 8b 05 0b ee 00 00 	mov    0xee0b(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    a1cd:	48 8b 08             	mov    (%rax),%rcx
    a1d0:	48 8d 3d cf a8 00 00 	lea    0xa8cf(%rip),%rdi        # 14aa6 <exec_in_fp0+0x296>
    a1d7:	be 13 00 00 00       	mov    $0x13,%esi
    a1dc:	ba 01 00 00 00       	mov    $0x1,%edx
    a1e1:	e8 9a 92 ff ff       	call   3480 <fwrite@plt>
    a1e6:	bf 66 00 00 00       	mov    $0x66,%edi
    a1eb:	e8 70 92 ff ff       	call   3460 <exit@plt>
    a1f0:	e8 4b c4 ff ff       	call   6640 <fwp_flush>
    a1f5:	48 8b 05 dc ed 00 00 	mov    0xeddc(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    a1fc:	48 8b 38             	mov    (%rax),%rdi
    a1ff:	48 8d 35 48 a8 00 00 	lea    0xa848(%rip),%rsi        # 14a4e <exec_in_fp0+0x23e>
    a206:	48 8d 15 b5 a9 00 00 	lea    0xa9b5(%rip),%rdx        # 14bc2 <exec_in_fp0+0x3b2>
    a20d:	eb 1d                	jmp    a22c <fwp_rc_wide_dup+0x14c>
    a20f:	e8 2c c4 ff ff       	call   6640 <fwp_flush>
    a214:	48 8b 05 bd ed 00 00 	mov    0xedbd(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    a21b:	48 8b 38             	mov    (%rax),%rdi
    a21e:	48 8d 35 29 a8 00 00 	lea    0xa829(%rip),%rsi        # 14a4e <exec_in_fp0+0x23e>
    a225:	48 8d 15 bb a9 00 00 	lea    0xa9bb(%rip),%rdx        # 14be7 <exec_in_fp0+0x3d7>
    a22c:	31 c0                	xor    %eax,%eax
    a22e:	e8 bd 90 ff ff       	call   32f0 <fprintf@plt>
    a233:	bf 65 00 00 00       	mov    $0x65,%edi
    a238:	e8 23 92 ff ff       	call   3460 <exit@plt>
    a23d:	0f 1f 00             	nopl   (%rax)

000000000000a240 <fwp_alloc_init>:
    a240:	53                   	push   %rbx
    a241:	48 ff 05 e0 0a 01 00 	incq   0x10ae0(%rip)        # 1ad28 <measured_calls>
    a248:	48 01 3d e1 0a 01 00 	add    %rdi,0x10ae1(%rip)        # 1ad30 <measured_bytes>
    a24f:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    a256:	0f 87 f2 00 00 00    	ja     a34e <fwp_alloc_init+0x10e>
    a25c:	48 8d 77 0f          	lea    0xf(%rdi),%rsi
    a260:	48 c1 ee 04          	shr    $0x4,%rsi
    a264:	48 8d 05 1d f0 00 00 	lea    0xf01d(%rip),%rax        # 19288 <fwp_gc>
    a26b:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    a272:	00 
    a273:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    a27a:	4c 8b 05 07 f0 00 00 	mov    0xf007(%rip),%r8        # 19288 <fwp_gc>
    a281:	4d 89 c1             	mov    %r8,%r9
    a284:	49 29 d1             	sub    %rdx,%r9
    a287:	4c 89 0d fa ef 00 00 	mov    %r9,0xeffa(%rip)        # 19288 <fwp_gc>
    a28e:	0f 88 ba 00 00 00    	js     a34e <fwp_alloc_init+0x10e>
    a294:	4c 8d 0c 49          	lea    (%rcx,%rcx,2),%r9
    a298:	4e 8d 14 c8          	lea    (%rax,%r9,8),%r10
    a29c:	49 83 c2 08          	add    $0x8,%r10
    a2a0:	49 8b 1a             	mov    (%r10),%rbx
    a2a3:	48 85 db             	test   %rbx,%rbx
    a2a6:	74 35                	je     a2dd <fwp_alloc_init+0x9d>
    a2a8:	48 8b 03             	mov    (%rbx),%rax
    a2ab:	48 f7 d0             	not    %rax
    a2ae:	49 89 02             	mov    %rax,(%r10)
    a2b1:	81 e7 f8 7f 00 00    	and    $0x7ff8,%edi
    a2b7:	48 39 d7             	cmp    %rdx,%rdi
    a2ba:	0f 83 af 00 00 00    	jae    a36f <fwp_alloc_init+0x12f>
    a2c0:	48 8d 04 3b          	lea    (%rbx,%rdi,1),%rax
    a2c4:	48 f7 d7             	not    %rdi
    a2c7:	48 01 d7             	add    %rdx,%rdi
    a2ca:	48 83 e7 f8          	and    $0xfffffffffffffff8,%rdi
    a2ce:	48 83 c7 08          	add    $0x8,%rdi
    a2d2:	48 89 fa             	mov    %rdi,%rdx
    a2d5:	48 89 c7             	mov    %rax,%rdi
    a2d8:	e9 8b 00 00 00       	jmp    a368 <fwp_alloc_init+0x128>
    a2dd:	4a 8b 5c c8 10       	mov    0x10(%rax,%r9,8),%rbx
    a2e2:	4e 8b 54 c8 18       	mov    0x18(%rax,%r9,8),%r10
    a2e7:	49 29 da             	sub    %rbx,%r10
    a2ea:	49 39 d2             	cmp    %rdx,%r10
    a2ed:	72 2f                	jb     a31e <fwp_alloc_init+0xde>
    a2ef:	4a 8d 0c c8          	lea    (%rax,%r9,8),%rcx
    a2f3:	48 83 c1 10          	add    $0x10,%rcx
    a2f7:	4c 8d 0c 13          	lea    (%rbx,%rdx,1),%r9
    a2fb:	4c 89 09             	mov    %r9,(%rcx)
    a2fe:	48 85 db             	test   %rbx,%rbx
    a301:	75 ae                	jne    a2b1 <fwp_alloc_init+0x71>
    a303:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    a30a:	00 
    a30b:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    a312:	49 29 d0             	sub    %rdx,%r8
    a315:	4c 89 05 6c ef 00 00 	mov    %r8,0xef6c(%rip)        # 19288 <fwp_gc>
    a31c:	78 30                	js     a34e <fwp_alloc_init+0x10e>
    a31e:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    a322:	48 8b 5c c8 08       	mov    0x8(%rax,%rcx,8),%rbx
    a327:	48 85 db             	test   %rbx,%rbx
    a32a:	74 10                	je     a33c <fwp_alloc_init+0xfc>
    a32c:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    a330:	48 83 c0 08          	add    $0x8,%rax
    a334:	48 8b 0b             	mov    (%rbx),%rcx
    a337:	48 f7 d1             	not    %rcx
    a33a:	eb 26                	jmp    a362 <fwp_alloc_init+0x122>
    a33c:	48 8b 5c c8 10       	mov    0x10(%rax,%rcx,8),%rbx
    a341:	48 8b 74 c8 18       	mov    0x18(%rax,%rcx,8),%rsi
    a346:	48 29 de             	sub    %rbx,%rsi
    a349:	48 39 d6             	cmp    %rdx,%rsi
    a34c:	73 08                	jae    a356 <fwp_alloc_init+0x116>
    a34e:	31 f6                	xor    %esi,%esi
    a350:	5b                   	pop    %rbx
    a351:	e9 ca d9 ff ff       	jmp    7d20 <fwp_gc_alloc_slow>
    a356:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    a35a:	48 83 c0 10          	add    $0x10,%rax
    a35e:	48 8d 0c 13          	lea    (%rbx,%rdx,1),%rcx
    a362:	48 89 08             	mov    %rcx,(%rax)
    a365:	48 89 df             	mov    %rbx,%rdi
    a368:	31 f6                	xor    %esi,%esi
    a36a:	e8 a1 8e ff ff       	call   3210 <memset@plt>
    a36f:	48 89 d8             	mov    %rbx,%rax
    a372:	5b                   	pop    %rbx
    a373:	c3                   	ret
    a374:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    a37b:	00 00 00 00 00 

000000000000a380 <fwp_rc_cleanup_cell>:
    a380:	48 89 f8             	mov    %rdi,%rax
    a383:	48 8b 3f             	mov    (%rdi),%rdi
    a386:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    a38d:	48 85 ff             	test   %rdi,%rdi
    a390:	75 0e                	jne    a3a0 <fwp_rc_free_obj>
    a392:	c3                   	ret
    a393:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a39a:	84 00 00 00 00 00 

000000000000a3a0 <fwp_rc_free_obj>:
    a3a0:	48 89 f8             	mov    %rdi,%rax
    a3a3:	48 2b 05 0e ff 00 00 	sub    0xff0e(%rip),%rax        # 1a2b8 <fwp_gc+0x1030>
    a3aa:	48 8b 0d 2f ff 00 00 	mov    0xff2f(%rip),%rcx        # 1a2e0 <fwp_gc+0x1058>
    a3b1:	48 c1 e1 10          	shl    $0x10,%rcx
    a3b5:	48 39 c8             	cmp    %rcx,%rax
    a3b8:	0f 83 b8 01 00 00    	jae    a576 <fwp_rc_free_obj+0x1d6>
    a3be:	55                   	push   %rbp
    a3bf:	41 57                	push   %r15
    a3c1:	41 56                	push   %r14
    a3c3:	53                   	push   %rbx
    a3c4:	50                   	push   %rax
    a3c5:	48 8b 1d 34 ff 00 00 	mov    0xff34(%rip),%rbx        # 1a300 <fwp_gc+0x1078>
    a3cc:	48 89 c1             	mov    %rax,%rcx
    a3cf:	48 c1 e9 10          	shr    $0x10,%rcx
    a3d3:	4c 69 f1 28 12 00 00 	imul   $0x1228,%rcx,%r14
    a3da:	42 0f b6 2c 33       	movzbl (%rbx,%r14,1),%ebp
    a3df:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a3e5:	75 1a                	jne    a401 <fwp_rc_free_obj+0x61>
    a3e7:	40 80 fd 02          	cmp    $0x2,%bpl
    a3eb:	75 14                	jne    a401 <fwp_rc_free_obj+0x61>
    a3ed:	4a 8d 04 33          	lea    (%rbx,%r14,1),%rax
    a3f1:	48 05 28 02 00 00    	add    $0x228,%rax
    a3f7:	80 38 01             	cmpb   $0x1,(%rax)
    a3fa:	74 32                	je     a42e <fwp_rc_free_obj+0x8e>
    a3fc:	e9 6b 01 00 00       	jmp    a56c <fwp_rc_free_obj+0x1cc>
    a401:	40 80 fd 01          	cmp    $0x1,%bpl
    a405:	0f 85 61 01 00 00    	jne    a56c <fwp_rc_free_obj+0x1cc>
    a40b:	4a 8d 0c 33          	lea    (%rbx,%r14,1),%rcx
    a40f:	42 8b 54 33 20       	mov    0x20(%rbx,%r14,1),%edx
    a414:	48 0f af c2          	imul   %rdx,%rax
    a418:	48 c1 e8 20          	shr    $0x20,%rax
    a41c:	48 01 c8             	add    %rcx,%rax
    a41f:	48 05 28 02 00 00    	add    $0x228,%rax
    a425:	80 38 01             	cmpb   $0x1,(%rax)
    a428:	0f 85 3e 01 00 00    	jne    a56c <fwp_rc_free_obj+0x1cc>
    a42e:	8b 0d 7c 08 01 00    	mov    0x1087c(%rip),%ecx        # 1acb0 <fwp_reuse_verify>
    a434:	85 c9                	test   %ecx,%ecx
    a436:	0f 88 c3 00 00 00    	js     a4ff <fwp_rc_free_obj+0x15f>
    a43c:	85 c9                	test   %ecx,%ecx
    a43e:	0f 84 fd 00 00 00    	je     a541 <fwp_rc_free_obj+0x1a1>
    a444:	42 80 7c 33 01 01    	cmpb   $0x1,0x1(%rbx,%r14,1)
    a44a:	75 0d                	jne    a459 <fwp_rc_free_obj+0xb9>
    a44c:	40 80 fd 02          	cmp    $0x2,%bpl
    a450:	75 22                	jne    a474 <fwp_rc_free_obj+0xd4>
    a452:	4a 8b 54 33 18       	mov    0x18(%rbx,%r14,1),%rdx
    a457:	eb 20                	jmp    a479 <fwp_rc_free_obj+0xd9>
    a459:	c7 07 ad de 00 00    	movl   $0xdead,(%rdi)
    a45f:	8b 47 04             	mov    0x4(%rdi),%eax
    a462:	48 85 c0             	test   %rax,%rax
    a465:	0f 84 01 01 00 00    	je     a56c <fwp_rc_free_obj+0x1cc>
    a46b:	83 f8 04             	cmp    $0x4,%eax
    a46e:	73 26                	jae    a496 <fwp_rc_free_obj+0xf6>
    a470:	31 c9                	xor    %ecx,%ecx
    a472:	eb 6a                	jmp    a4de <fwp_rc_free_obj+0x13e>
    a474:	42 8b 54 33 08       	mov    0x8(%rbx,%r14,1),%edx
    a479:	48 89 fb             	mov    %rdi,%rbx
    a47c:	be dd 00 00 00       	mov    $0xdd,%esi
    a481:	e8 8a 8d ff ff       	call   3210 <memset@plt>
    a486:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    a48d:	c6 43 08 00          	movb   $0x0,0x8(%rbx)
    a491:	e9 d6 00 00 00       	jmp    a56c <fwp_rc_free_obj+0x1cc>
    a496:	89 c1                	mov    %eax,%ecx
    a498:	83 e1 fc             	and    $0xfffffffc,%ecx
    a49b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    a4a2:	00 
    a4a3:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    a4a7:	31 f6                	xor    %esi,%esi
    a4a9:	66 0f 28 05 3f 9c 00 	movapd 0x9c3f(%rip),%xmm0        # 140f0 <_IO_stdin_used+0xf0>
    a4b0:	00 
    a4b1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a4b8:	0f 1f 84 00 00 00 00 
    a4bf:	00 
    a4c0:	66 0f 11 44 37 08    	movupd %xmm0,0x8(%rdi,%rsi,1)
    a4c6:	66 0f 11 44 37 18    	movupd %xmm0,0x18(%rdi,%rsi,1)
    a4cc:	48 83 c6 20          	add    $0x20,%rsi
    a4d0:	48 39 f2             	cmp    %rsi,%rdx
    a4d3:	75 eb                	jne    a4c0 <fwp_rc_free_obj+0x120>
    a4d5:	48 39 c1             	cmp    %rax,%rcx
    a4d8:	0f 84 8e 00 00 00    	je     a56c <fwp_rc_free_obj+0x1cc>
    a4de:	48 ba ef be ad de ef 	movabs $0xdeadbeefdeadbeef,%rdx
    a4e5:	be ad de 
    a4e8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a4ef:	00 
    a4f0:	48 89 54 cf 08       	mov    %rdx,0x8(%rdi,%rcx,8)
    a4f5:	48 ff c1             	inc    %rcx
    a4f8:	48 39 c8             	cmp    %rcx,%rax
    a4fb:	75 f3                	jne    a4f0 <fwp_rc_free_obj+0x150>
    a4fd:	eb 6d                	jmp    a56c <fwp_rc_free_obj+0x1cc>
    a4ff:	49 89 ff             	mov    %rdi,%r15
    a502:	48 8d 3d f7 a6 00 00 	lea    0xa6f7(%rip),%rdi        # 14c00 <exec_in_fp0+0x3f0>
    a509:	e8 22 8b ff ff       	call   3030 <getenv@plt>
    a50e:	31 c9                	xor    %ecx,%ecx
    a510:	48 85 c0             	test   %rax,%rax
    a513:	74 1b                	je     a530 <fwp_rc_free_obj+0x190>
    a515:	80 38 00             	cmpb   $0x0,(%rax)
    a518:	74 16                	je     a530 <fwp_rc_free_obj+0x190>
    a51a:	48 8d 35 3c b2 00 00 	lea    0xb23c(%rip),%rsi        # 1575d <exec_in_fp0+0xf4d>
    a521:	48 89 c7             	mov    %rax,%rdi
    a524:	e8 a7 8d ff ff       	call   32d0 <strcmp@plt>
    a529:	31 c9                	xor    %ecx,%ecx
    a52b:	85 c0                	test   %eax,%eax
    a52d:	0f 95 c1             	setne  %cl
    a530:	89 0d 7a 07 01 00    	mov    %ecx,0x1077a(%rip)        # 1acb0 <fwp_reuse_verify>
    a536:	4c 89 ff             	mov    %r15,%rdi
    a539:	85 c9                	test   %ecx,%ecx
    a53b:	0f 85 03 ff ff ff    	jne    a444 <fwp_rc_free_obj+0xa4>
    a541:	48 8b 1d 40 ed 00 00 	mov    0xed40(%rip),%rbx        # 19288 <fwp_gc>
    a548:	e8 33 00 00 00       	call   a580 <fwp_mem_free>
    a54d:	48 8b 05 34 ed 00 00 	mov    0xed34(%rip),%rax        # 19288 <fwp_gc>
    a554:	48 29 d8             	sub    %rbx,%rax
    a557:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    a55c:	f2 0f 58 05 2c ff 00 	addsd  0xff2c(%rip),%xmm0        # 1a490 <fwp_gc+0x1208>
    a563:	00 
    a564:	f2 0f 11 05 24 ff 00 	movsd  %xmm0,0xff24(%rip)        # 1a490 <fwp_gc+0x1208>
    a56b:	00 
    a56c:	48 83 c4 08          	add    $0x8,%rsp
    a570:	5b                   	pop    %rbx
    a571:	41 5e                	pop    %r14
    a573:	41 5f                	pop    %r15
    a575:	5d                   	pop    %rbp
    a576:	c3                   	ret
    a577:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    a57e:	00 00 

000000000000a580 <fwp_mem_free>:
    a580:	48 85 ff             	test   %rdi,%rdi
    a583:	0f 84 17 02 00 00    	je     a7a0 <fwp_mem_free+0x220>
    a589:	48 8b 05 28 fd 00 00 	mov    0xfd28(%rip),%rax        # 1a2b8 <fwp_gc+0x1030>
    a590:	48 89 f9             	mov    %rdi,%rcx
    a593:	48 29 c1             	sub    %rax,%rcx
    a596:	48 8b 15 43 fd 00 00 	mov    0xfd43(%rip),%rdx        # 1a2e0 <fwp_gc+0x1058>
    a59d:	48 c1 e2 10          	shl    $0x10,%rdx
    a5a1:	48 39 d1             	cmp    %rdx,%rcx
    a5a4:	0f 83 f6 01 00 00    	jae    a7a0 <fwp_mem_free+0x220>
    a5aa:	41 57                	push   %r15
    a5ac:	41 56                	push   %r14
    a5ae:	41 55                	push   %r13
    a5b0:	41 54                	push   %r12
    a5b2:	53                   	push   %rbx
    a5b3:	4c 8b 25 46 fd 00 00 	mov    0xfd46(%rip),%r12        # 1a300 <fwp_gc+0x1078>
    a5ba:	4d 85 e4             	test   %r12,%r12
    a5bd:	0f 84 d4 01 00 00    	je     a797 <fwp_mem_free+0x217>
    a5c3:	49 89 cf             	mov    %rcx,%r15
    a5c6:	49 c1 ef 10          	shr    $0x10,%r15
    a5ca:	4d 69 f7 28 12 00 00 	imul   $0x1228,%r15,%r14
    a5d1:	43 0f b6 14 34       	movzbl (%r12,%r14,1),%edx
    a5d6:	83 fa 02             	cmp    $0x2,%edx
    a5d9:	0f 84 b9 00 00 00    	je     a698 <fwp_mem_free+0x118>
    a5df:	83 fa 01             	cmp    $0x1,%edx
    a5e2:	0f 85 af 01 00 00    	jne    a797 <fwp_mem_free+0x217>
    a5e8:	47 0f b6 4c 34 01    	movzbl 0x1(%r12,%r14,1),%r9d
    a5ee:	47 0f b6 44 34 02    	movzbl 0x2(%r12,%r14,1),%r8d
    a5f4:	43 8b 74 34 08       	mov    0x8(%r12,%r14,1),%esi
    a5f9:	0f b7 c7             	movzwl %di,%eax
    a5fc:	31 d2                	xor    %edx,%edx
    a5fe:	f7 f6                	div    %esi
    a600:	48 c7 c2 fe ff ff ff 	mov    $0xfffffffffffffffe,%rdx
    a607:	89 c1                	mov    %eax,%ecx
    a609:	48 d3 c2             	rol    %cl,%rdx
    a60c:	4b 8d 0c 34          	lea    (%r12,%r14,1),%rcx
    a610:	41 89 c2             	mov    %eax,%r10d
    a613:	41 c1 ea 03          	shr    $0x3,%r10d
    a617:	41 81 e2 f8 1f 00 00 	and    $0x1ff8,%r10d
    a61e:	49 21 54 0a 28       	and    %rdx,0x28(%r10,%rcx,1)
    a623:	49 69 d1 c0 03 00 00 	imul   $0x3c0,%r9,%rdx
    a62a:	4c 8d 3d 57 ec 00 00 	lea    0xec57(%rip),%r15        # 19288 <fwp_gc>
    a631:	49 01 d7             	add    %rdx,%r15
    a634:	4f 8d 2c 40          	lea    (%r8,%r8,2),%r13
    a638:	4d 01 e6             	add    %r12,%r14
    a63b:	49 83 c6 08          	add    $0x8,%r14
    a63f:	48 8d 1c 08          	lea    (%rax,%rcx,1),%rbx
    a643:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    a64a:	80 bc 08 28 02 00 00 	cmpb   $0xff,0x228(%rax,%rcx,1)
    a651:	ff 
    a652:	0f 84 49 01 00 00    	je     a7a1 <fwp_mem_free+0x221>
    a658:	4f 8d 3c ef          	lea    (%r15,%r13,8),%r15
    a65c:	49 83 c7 08          	add    $0x8,%r15
    a660:	c6 03 00             	movb   $0x0,(%rbx)
    a663:	83 3d 22 fc 00 00 00 	cmpl   $0x0,0xfc22(%rip)        # 1a28c <fwp_gc+0x1004>
    a66a:	74 12                	je     a67e <fwp_mem_free+0xfe>
    a66c:	89 f2                	mov    %esi,%edx
    a66e:	48 89 fb             	mov    %rdi,%rbx
    a671:	31 f6                	xor    %esi,%esi
    a673:	e8 98 8b ff ff       	call   3210 <memset@plt>
    a678:	48 89 df             	mov    %rbx,%rdi
    a67b:	41 8b 36             	mov    (%r14),%esi
    a67e:	49 8b 07             	mov    (%r15),%rax
    a681:	48 f7 d0             	not    %rax
    a684:	48 89 07             	mov    %rax,(%rdi)
    a687:	49 89 3f             	mov    %rdi,(%r15)
    a68a:	89 f0                	mov    %esi,%eax
    a68c:	48 01 05 f5 eb 00 00 	add    %rax,0xebf5(%rip)        # 19288 <fwp_gc>
    a693:	e9 ff 00 00 00       	jmp    a797 <fwp_mem_free+0x217>
    a698:	48 81 e1 00 00 ff ff 	and    $0xffffffffffff0000,%rcx
    a69f:	48 01 c8             	add    %rcx,%rax
    a6a2:	48 39 f8             	cmp    %rdi,%rax
    a6a5:	0f 85 ec 00 00 00    	jne    a797 <fwp_mem_free+0x217>
    a6ab:	4b 8b 44 34 18       	mov    0x18(%r12,%r14,1),%rax
    a6b0:	48 01 05 d1 eb 00 00 	add    %rax,0xebd1(%rip)        # 19288 <fwp_gc>
    a6b7:	43 c6 44 34 03 00    	movb   $0x0,0x3(%r12,%r14,1)
    a6bd:	4b 8d 1c 34          	lea    (%r12,%r14,1),%rbx
    a6c1:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    a6c8:	43 80 bc 34 28 02 00 	cmpb   $0xff,0x228(%r12,%r14,1)
    a6cf:	00 ff 
    a6d1:	0f 84 e0 00 00 00    	je     a7b7 <fwp_mem_free+0x237>
    a6d7:	c6 03 00             	movb   $0x0,(%rbx)
    a6da:	43 8b 44 34 10       	mov    0x10(%r12,%r14,1),%eax
    a6df:	48 85 c0             	test   %rax,%rax
    a6e2:	0f 84 88 00 00 00    	je     a770 <fwp_mem_free+0x1f0>
    a6e8:	48 8b 0d 11 fc 00 00 	mov    0xfc11(%rip),%rcx        # 1a300 <fwp_gc+0x1078>
    a6ef:	89 c2                	mov    %eax,%edx
    a6f1:	83 e2 03             	and    $0x3,%edx
    a6f4:	83 f8 04             	cmp    $0x4,%eax
    a6f7:	73 04                	jae    a6fd <fwp_mem_free+0x17d>
    a6f9:	31 f6                	xor    %esi,%esi
    a6fb:	eb 3b                	jmp    a738 <fwp_mem_free+0x1b8>
    a6fd:	4a 8d 3c 31          	lea    (%rcx,%r14,1),%rdi
    a701:	41 89 c0             	mov    %eax,%r8d
    a704:	41 83 e0 fc          	and    $0xfffffffc,%r8d
    a708:	31 f6                	xor    %esi,%esi
    a70a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    a710:	c6 07 00             	movb   $0x0,(%rdi)
    a713:	c6 87 28 12 00 00 00 	movb   $0x0,0x1228(%rdi)
    a71a:	c6 87 50 24 00 00 00 	movb   $0x0,0x2450(%rdi)
    a721:	c6 87 78 36 00 00 00 	movb   $0x0,0x3678(%rdi)
    a728:	48 83 c6 04          	add    $0x4,%rsi
    a72c:	48 81 c7 a0 48 00 00 	add    $0x48a0,%rdi
    a733:	49 39 f0             	cmp    %rsi,%r8
    a736:	75 d8                	jne    a710 <fwp_mem_free+0x190>
    a738:	48 85 d2             	test   %rdx,%rdx
    a73b:	74 33                	je     a770 <fwp_mem_free+0x1f0>
    a73d:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    a744:	4c 01 f6             	add    %r14,%rsi
    a747:	48 01 f1             	add    %rsi,%rcx
    a74a:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a751:	31 f6                	xor    %esi,%esi
    a753:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a75a:	84 00 00 00 00 00 
    a760:	c6 04 31 00          	movb   $0x0,(%rcx,%rsi,1)
    a764:	48 81 c6 28 12 00 00 	add    $0x1228,%rsi
    a76b:	48 39 f2             	cmp    %rsi,%rdx
    a76e:	75 f0                	jne    a760 <fwp_mem_free+0x1e0>
    a770:	48 01 05 f1 fc 00 00 	add    %rax,0xfcf1(%rip)        # 1a468 <fwp_gc+0x11e0>
    a777:	4c 3b 3d 7a fb 00 00 	cmp    0xfb7a(%rip),%r15        # 1a2f8 <fwp_gc+0x1070>
    a77e:	73 07                	jae    a787 <fwp_mem_free+0x207>
    a780:	4c 89 3d 71 fb 00 00 	mov    %r15,0xfb71(%rip)        # 1a2f8 <fwp_gc+0x1070>
    a787:	4c 3b 3d 62 fb 00 00 	cmp    0xfb62(%rip),%r15        # 1a2f0 <fwp_gc+0x1068>
    a78e:	73 07                	jae    a797 <fwp_mem_free+0x217>
    a790:	4c 89 3d 59 fb 00 00 	mov    %r15,0xfb59(%rip)        # 1a2f0 <fwp_gc+0x1068>
    a797:	5b                   	pop    %rbx
    a798:	41 5c                	pop    %r12
    a79a:	41 5d                	pop    %r13
    a79c:	41 5e                	pop    %r14
    a79e:	41 5f                	pop    %r15
    a7a0:	c3                   	ret
    a7a1:	49 89 fc             	mov    %rdi,%r12
    a7a4:	48 89 df             	mov    %rbx,%rdi
    a7a7:	e8 e4 bd ff ff       	call   6590 <fwp_rc_forget_slot>
    a7ac:	4c 89 e7             	mov    %r12,%rdi
    a7af:	41 8b 36             	mov    (%r14),%esi
    a7b2:	e9 a1 fe ff ff       	jmp    a658 <fwp_mem_free+0xd8>
    a7b7:	48 89 df             	mov    %rbx,%rdi
    a7ba:	e8 d1 bd ff ff       	call   6590 <fwp_rc_forget_slot>
    a7bf:	e9 13 ff ff ff       	jmp    a6d7 <fwp_mem_free+0x157>
    a7c4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    a7cb:	00 00 00 00 00 

000000000000a7d0 <fwp_rc_free_arr>:
    a7d0:	48 89 f8             	mov    %rdi,%rax
    a7d3:	48 2b 05 de fa 00 00 	sub    0xfade(%rip),%rax        # 1a2b8 <fwp_gc+0x1030>
    a7da:	48 8b 0d ff fa 00 00 	mov    0xfaff(%rip),%rcx        # 1a2e0 <fwp_gc+0x1058>
    a7e1:	48 c1 e1 10          	shl    $0x10,%rcx
    a7e5:	48 39 c8             	cmp    %rcx,%rax
    a7e8:	0f 83 e9 00 00 00    	jae    a8d7 <fwp_rc_free_arr+0x107>
    a7ee:	53                   	push   %rbx
    a7ef:	48 8b 0d 0a fb 00 00 	mov    0xfb0a(%rip),%rcx        # 1a300 <fwp_gc+0x1078>
    a7f6:	48 89 c2             	mov    %rax,%rdx
    a7f9:	48 c1 ea 10          	shr    $0x10,%rdx
    a7fd:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a804:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a808:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a80e:	75 1a                	jne    a82a <fwp_rc_free_arr+0x5a>
    a810:	40 80 fe 02          	cmp    $0x2,%sil
    a814:	75 14                	jne    a82a <fwp_rc_free_arr+0x5a>
    a816:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    a81a:	48 05 28 02 00 00    	add    $0x228,%rax
    a820:	80 38 01             	cmpb   $0x1,(%rax)
    a823:	74 31                	je     a856 <fwp_rc_free_arr+0x86>
    a825:	e9 ac 00 00 00       	jmp    a8d6 <fwp_rc_free_arr+0x106>
    a82a:	40 80 fe 01          	cmp    $0x1,%sil
    a82e:	0f 85 a2 00 00 00    	jne    a8d6 <fwp_rc_free_arr+0x106>
    a834:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a838:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a83c:	48 0f af c1          	imul   %rcx,%rax
    a840:	48 c1 e8 20          	shr    $0x20,%rax
    a844:	48 01 f0             	add    %rsi,%rax
    a847:	48 05 28 02 00 00    	add    $0x228,%rax
    a84d:	80 38 01             	cmpb   $0x1,(%rax)
    a850:	0f 85 80 00 00 00    	jne    a8d6 <fwp_rc_free_arr+0x106>
    a856:	8b 0d 54 04 01 00    	mov    0x10454(%rip),%ecx        # 1acb0 <fwp_reuse_verify>
    a85c:	85 c9                	test   %ecx,%ecx
    a85e:	78 0d                	js     a86d <fwp_rc_free_arr+0x9d>
    a860:	85 c9                	test   %ecx,%ecx
    a862:	74 47                	je     a8ab <fwp_rc_free_arr+0xdb>
    a864:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    a86b:	eb 69                	jmp    a8d6 <fwp_rc_free_arr+0x106>
    a86d:	48 89 fb             	mov    %rdi,%rbx
    a870:	48 8d 3d 89 a3 00 00 	lea    0xa389(%rip),%rdi        # 14c00 <exec_in_fp0+0x3f0>
    a877:	e8 b4 87 ff ff       	call   3030 <getenv@plt>
    a87c:	31 c9                	xor    %ecx,%ecx
    a87e:	48 85 c0             	test   %rax,%rax
    a881:	74 1b                	je     a89e <fwp_rc_free_arr+0xce>
    a883:	80 38 00             	cmpb   $0x0,(%rax)
    a886:	74 16                	je     a89e <fwp_rc_free_arr+0xce>
    a888:	48 8d 35 ce ae 00 00 	lea    0xaece(%rip),%rsi        # 1575d <exec_in_fp0+0xf4d>
    a88f:	48 89 c7             	mov    %rax,%rdi
    a892:	e8 39 8a ff ff       	call   32d0 <strcmp@plt>
    a897:	31 c9                	xor    %ecx,%ecx
    a899:	85 c0                	test   %eax,%eax
    a89b:	0f 95 c1             	setne  %cl
    a89e:	89 0d 0c 04 01 00    	mov    %ecx,0x1040c(%rip)        # 1acb0 <fwp_reuse_verify>
    a8a4:	48 89 df             	mov    %rbx,%rdi
    a8a7:	85 c9                	test   %ecx,%ecx
    a8a9:	75 b9                	jne    a864 <fwp_rc_free_arr+0x94>
    a8ab:	48 8b 1d d6 e9 00 00 	mov    0xe9d6(%rip),%rbx        # 19288 <fwp_gc>
    a8b2:	e8 c9 fc ff ff       	call   a580 <fwp_mem_free>
    a8b7:	48 8b 05 ca e9 00 00 	mov    0xe9ca(%rip),%rax        # 19288 <fwp_gc>
    a8be:	48 29 d8             	sub    %rbx,%rax
    a8c1:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    a8c6:	f2 0f 58 05 c2 fb 00 	addsd  0xfbc2(%rip),%xmm0        # 1a490 <fwp_gc+0x1208>
    a8cd:	00 
    a8ce:	f2 0f 11 05 ba fb 00 	movsd  %xmm0,0xfbba(%rip)        # 1a490 <fwp_gc+0x1208>
    a8d5:	00 
    a8d6:	5b                   	pop    %rbx
    a8d7:	c3                   	ret
    a8d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a8df:	00 

000000000000a8e0 <fwp_owner_release6>:
    a8e0:	48 8b 3f             	mov    (%rdi),%rdi
    a8e3:	eb 0b                	jmp    a8f0 <fwp_drop2>
    a8e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a8ec:	00 00 00 00 

000000000000a8f0 <fwp_drop2>:
    a8f0:	53                   	push   %rbx
    a8f1:	48 89 f8             	mov    %rdi,%rax
    a8f4:	48 2b 05 bd f9 00 00 	sub    0xf9bd(%rip),%rax        # 1a2b8 <fwp_gc+0x1030>
    a8fb:	48 8b 0d de f9 00 00 	mov    0xf9de(%rip),%rcx        # 1a2e0 <fwp_gc+0x1058>
    a902:	48 c1 e1 10          	shl    $0x10,%rcx
    a906:	48 39 c8             	cmp    %rcx,%rax
    a909:	0f 83 9c 00 00 00    	jae    a9ab <fwp_drop2+0xbb>
    a90f:	48 8b 0d ea f9 00 00 	mov    0xf9ea(%rip),%rcx        # 1a300 <fwp_gc+0x1078>
    a916:	48 89 c2             	mov    %rax,%rdx
    a919:	48 c1 ea 10          	shr    $0x10,%rdx
    a91d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a924:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a928:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a92e:	75 20                	jne    a950 <fwp_drop2+0x60>
    a930:	40 80 fe 02          	cmp    $0x2,%sil
    a934:	75 1a                	jne    a950 <fwp_drop2+0x60>
    a936:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    a93a:	48 05 28 02 00 00    	add    $0x228,%rax
    a940:	eb 2d                	jmp    a96f <fwp_drop2+0x7f>
    a942:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a949:	1f 84 00 00 00 00 00 
    a950:	40 80 fe 01          	cmp    $0x1,%sil
    a954:	75 55                	jne    a9ab <fwp_drop2+0xbb>
    a956:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a95a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a95e:	48 0f af c1          	imul   %rcx,%rax
    a962:	48 c1 e8 20          	shr    $0x20,%rax
    a966:	48 01 f0             	add    %rsi,%rax
    a969:	48 05 28 02 00 00    	add    $0x228,%rax
    a96f:	0f b6 08             	movzbl (%rax),%ecx
    a972:	85 c9                	test   %ecx,%ecx
    a974:	74 35                	je     a9ab <fwp_drop2+0xbb>
    a976:	83 f9 01             	cmp    $0x1,%ecx
    a979:	75 32                	jne    a9ad <fwp_drop2+0xbd>
    a97b:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    a97f:	79 3a                	jns    a9bb <fwp_drop2+0xcb>
    a981:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    a985:	e8 46 fe ff ff       	call   a7d0 <fwp_rc_free_arr>
    a98a:	48 89 d8             	mov    %rbx,%rax
    a98d:	48 2b 05 24 f9 00 00 	sub    0xf924(%rip),%rax        # 1a2b8 <fwp_gc+0x1030>
    a994:	48 8b 0d 45 f9 00 00 	mov    0xf945(%rip),%rcx        # 1a2e0 <fwp_gc+0x1058>
    a99b:	48 c1 e1 10          	shl    $0x10,%rcx
    a99f:	48 89 df             	mov    %rbx,%rdi
    a9a2:	48 39 c8             	cmp    %rcx,%rax
    a9a5:	0f 82 64 ff ff ff    	jb     a90f <fwp_drop2+0x1f>
    a9ab:	5b                   	pop    %rbx
    a9ac:	c3                   	ret
    a9ad:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    a9b3:	74 0c                	je     a9c1 <fwp_drop2+0xd1>
    a9b5:	fe c9                	dec    %cl
    a9b7:	88 08                	mov    %cl,(%rax)
    a9b9:	5b                   	pop    %rbx
    a9ba:	c3                   	ret
    a9bb:	5b                   	pop    %rbx
    a9bc:	e9 0f fe ff ff       	jmp    a7d0 <fwp_rc_free_arr>
    a9c1:	48 89 c7             	mov    %rax,%rdi
    a9c4:	5b                   	pop    %rbx
    a9c5:	e9 86 f6 ff ff       	jmp    a050 <fwp_rc_wide_drop>
    a9ca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000a9d0 <fwp_owner_release7>:
    a9d0:	48 8b 3f             	mov    (%rdi),%rdi
    a9d3:	e9 18 ff ff ff       	jmp    a8f0 <fwp_drop2>
    a9d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a9df:	00 

000000000000a9e0 <fwp_owner_release8>:
    a9e0:	48 8b 3f             	mov    (%rdi),%rdi
    a9e3:	e9 08 ff ff ff       	jmp    a8f0 <fwp_drop2>
    a9e8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a9ef:	00 

000000000000a9f0 <fwp_owner_release9>:
    a9f0:	48 8b 3f             	mov    (%rdi),%rdi
    a9f3:	e9 f8 fe ff ff       	jmp    a8f0 <fwp_drop2>
    a9f8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a9ff:	00 

000000000000aa00 <fwp_owned_entry5>:
    aa00:	48 0f be 0f          	movsbq (%rdi),%rcx
    aa04:	48 0f be 47 08       	movsbq 0x8(%rdi),%rax
    aa09:	48 01 c8             	add    %rcx,%rax
    aa0c:	48 0f be c8          	movsbq %al,%rcx
    aa10:	48 39 c1             	cmp    %rax,%rcx
    aa13:	75 01                	jne    aa16 <fwp_owned_entry5+0x16>
    aa15:	c3                   	ret
    aa16:	53                   	push   %rbx
    aa17:	48 83 ec 60          	sub    $0x60,%rsp
    aa1b:	48 8d 15 f6 a1 00 00 	lea    0xa1f6(%rip),%rdx        # 14c18 <exec_in_fp0+0x408>
    aa22:	48 8d 0d ec a1 00 00 	lea    0xa1ec(%rip),%rcx        # 14c15 <exec_in_fp0+0x405>
    aa29:	48 89 e3             	mov    %rsp,%rbx
    aa2c:	be 60 00 00 00       	mov    $0x60,%esi
    aa31:	48 89 df             	mov    %rbx,%rdi
    aa34:	31 c0                	xor    %eax,%eax
    aa36:	e8 95 87 ff ff       	call   31d0 <snprintf@plt>
    aa3b:	e8 00 bc ff ff       	call   6640 <fwp_flush>
    aa40:	48 8b 05 91 e5 00 00 	mov    0xe591(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    aa47:	48 8b 38             	mov    (%rax),%rdi
    aa4a:	48 8d 35 fd 9f 00 00 	lea    0x9ffd(%rip),%rsi        # 14a4e <exec_in_fp0+0x23e>
    aa51:	48 89 da             	mov    %rbx,%rdx
    aa54:	31 c0                	xor    %eax,%eax
    aa56:	e8 95 88 ff ff       	call   32f0 <fprintf@plt>
    aa5b:	bf 65 00 00 00       	mov    $0x65,%edi
    aa60:	e8 fb 89 ff ff       	call   3460 <exit@plt>
    aa65:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    aa6c:	00 00 00 00 

000000000000aa70 <fwp_caps5>:
    aa70:	85 f6                	test   %esi,%esi
    aa72:	0f 84 28 f9 ff ff    	je     a3a0 <fwp_rc_free_obj>
    aa78:	c3                   	ret
    aa79:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000aa80 <fwp_args5>:
    aa80:	c3                   	ret
    aa81:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    aa88:	0f 1f 84 00 00 00 00 
    aa8f:	00 

000000000000aa90 <fwp_owned_entry12>:
    aa90:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    aa94:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    aa99:	0f 59 c8             	mulps  %xmm0,%xmm1
    aa9c:	66 0f 7e c8          	movd   %xmm1,%eax
    aaa0:	c3                   	ret
    aaa1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    aaa8:	0f 1f 84 00 00 00 00 
    aaaf:	00 

000000000000aab0 <fwp_caps12>:
    aab0:	85 f6                	test   %esi,%esi
    aab2:	0f 84 e8 f8 ff ff    	je     a3a0 <fwp_rc_free_obj>
    aab8:	c3                   	ret
    aab9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000aac0 <fwp_args12>:
    aac0:	c3                   	ret
    aac1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    aac8:	0f 1f 84 00 00 00 00 
    aacf:	00 

000000000000aad0 <fwp_owned_entry13>:
    aad0:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    aad4:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    aad9:	0f 58 c8             	addps  %xmm0,%xmm1
    aadc:	66 0f 7e c8          	movd   %xmm1,%eax
    aae0:	c3                   	ret
    aae1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    aae8:	0f 1f 84 00 00 00 00 
    aaef:	00 

000000000000aaf0 <fwp_caps13>:
    aaf0:	85 f6                	test   %esi,%esi
    aaf2:	0f 84 a8 f8 ff ff    	je     a3a0 <fwp_rc_free_obj>
    aaf8:	c3                   	ret
    aaf9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000ab00 <fwp_args13>:
    ab00:	c3                   	ret
    ab01:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ab08:	0f 1f 84 00 00 00 00 
    ab0f:	00 

000000000000ab10 <fwp_owned_entry20>:
    ab10:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    ab14:	f2 0f 59 47 08       	mulsd  0x8(%rdi),%xmm0
    ab19:	66 48 0f 7e c0       	movq   %xmm0,%rax
    ab1e:	c3                   	ret
    ab1f:	90                   	nop

000000000000ab20 <fwp_caps20>:
    ab20:	85 f6                	test   %esi,%esi
    ab22:	0f 84 78 f8 ff ff    	je     a3a0 <fwp_rc_free_obj>
    ab28:	c3                   	ret
    ab29:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000ab30 <fwp_args20>:
    ab30:	c3                   	ret
    ab31:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ab38:	0f 1f 84 00 00 00 00 
    ab3f:	00 

000000000000ab40 <fwp_owned_entry21>:
    ab40:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    ab44:	f2 0f 58 47 08       	addsd  0x8(%rdi),%xmm0
    ab49:	66 48 0f 7e c0       	movq   %xmm0,%rax
    ab4e:	c3                   	ret
    ab4f:	90                   	nop

000000000000ab50 <fwp_caps21>:
    ab50:	85 f6                	test   %esi,%esi
    ab52:	0f 84 48 f8 ff ff    	je     a3a0 <fwp_rc_free_obj>
    ab58:	c3                   	ret
    ab59:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000ab60 <fwp_args21>:
    ab60:	c3                   	ret
    ab61:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ab68:	0f 1f 84 00 00 00 00 
    ab6f:	00 

000000000000ab70 <fwp_segv>:
    ab70:	48 8b 05 f1 01 01 00 	mov    0x101f1(%rip),%rax        # 1ad68 <fwp_main_stack_top>
    ab77:	48 85 c0             	test   %rax,%rax
    ab7a:	74 22                	je     ab9e <fwp_segv+0x2e>
    ab7c:	48 8b 4e 10          	mov    0x10(%rsi),%rcx
    ab80:	48 2b 05 e9 01 01 00 	sub    0x101e9(%rip),%rax        # 1ad70 <fwp_main_stack_size>
    ab87:	48 8d 90 00 00 f0 ff 	lea    -0x100000(%rax),%rdx
    ab8e:	48 39 ca             	cmp    %rcx,%rdx
    ab91:	77 0b                	ja     ab9e <fwp_segv+0x2e>
    ab93:	48 05 00 00 10 00    	add    $0x100000,%rax
    ab99:	48 39 c8             	cmp    %rcx,%rax
    ab9c:	77 07                	ja     aba5 <fwp_segv+0x35>
    ab9e:	31 f6                	xor    %esi,%esi
    aba0:	e9 3b 87 ff ff       	jmp    32e0 <signal@plt>
    aba5:	50                   	push   %rax
    aba6:	e8 95 ba ff ff       	call   6640 <fwp_flush>
    abab:	48 8d 35 0e 9c 00 00 	lea    0x9c0e(%rip),%rsi        # 147c0 <fwp_segv.msg>
    abb2:	ba 1a 00 00 00       	mov    $0x1a,%edx
    abb7:	bf 02 00 00 00       	mov    $0x2,%edi
    abbc:	e8 7f 85 ff ff       	call   3140 <write@plt>
    abc1:	bf 65 00 00 00       	mov    $0x65,%edi
    abc6:	e8 d5 84 ff ff       	call   30a0 <_exit@plt>
    abcb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000abd0 <fwp_str_lossy>:
    abd0:	55                   	push   %rbp
    abd1:	41 57                	push   %r15
    abd3:	41 56                	push   %r14
    abd5:	41 55                	push   %r13
    abd7:	41 54                	push   %r12
    abd9:	53                   	push   %rbx
    abda:	48 83 ec 28          	sub    $0x28,%rsp
    abde:	49 89 f6             	mov    %rsi,%r14
    abe1:	48 89 fb             	mov    %rdi,%rbx
    abe4:	48 85 f6             	test   %rsi,%rsi
    abe7:	0f 84 47 01 00 00    	je     ad34 <fwp_str_lossy+0x164>
    abed:	31 c0                	xor    %eax,%eax
    abef:	eb 1b                	jmp    ac0c <fwp_str_lossy+0x3c>
    abf1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    abf8:	0f 1f 84 00 00 00 00 
    abff:	00 
    ac00:	48 ff c0             	inc    %rax
    ac03:	4c 39 f0             	cmp    %r14,%rax
    ac06:	0f 83 28 01 00 00    	jae    ad34 <fwp_str_lossy+0x164>
    ac0c:	0f b6 3c 03          	movzbl (%rbx,%rax,1),%edi
    ac10:	40 84 ff             	test   %dil,%dil
    ac13:	79 eb                	jns    ac00 <fwp_str_lossy+0x30>
    ac15:	8d 4f 3e             	lea    0x3e(%rdi),%ecx
    ac18:	80 f9 1e             	cmp    $0x1e,%cl
    ac1b:	73 11                	jae    ac2e <fwp_str_lossy+0x5e>
    ac1d:	b9 80 00 00 00       	mov    $0x80,%ecx
    ac22:	be 01 00 00 00       	mov    $0x1,%esi
    ac27:	ba 1f 00 00 00       	mov    $0x1f,%edx
    ac2c:	eb 36                	jmp    ac64 <fwp_str_lossy+0x94>
    ac2e:	89 f9                	mov    %edi,%ecx
    ac30:	80 e1 f0             	and    $0xf0,%cl
    ac33:	80 f9 e0             	cmp    $0xe0,%cl
    ac36:	75 11                	jne    ac49 <fwp_str_lossy+0x79>
    ac38:	b9 00 08 00 00       	mov    $0x800,%ecx
    ac3d:	be 02 00 00 00       	mov    $0x2,%esi
    ac42:	ba 0f 00 00 00       	mov    $0xf,%edx
    ac47:	eb 1b                	jmp    ac64 <fwp_str_lossy+0x94>
    ac49:	8d 4f 10             	lea    0x10(%rdi),%ecx
    ac4c:	80 f9 04             	cmp    $0x4,%cl
    ac4f:	0f 87 52 01 00 00    	ja     ada7 <fwp_str_lossy+0x1d7>
    ac55:	b9 00 00 01 00       	mov    $0x10000,%ecx
    ac5a:	be 03 00 00 00       	mov    $0x3,%esi
    ac5f:	ba 07 00 00 00       	mov    $0x7,%edx
    ac64:	89 f6                	mov    %esi,%esi
    ac66:	4c 8d 04 30          	lea    (%rax,%rsi,1),%r8
    ac6a:	4d 39 f0             	cmp    %r14,%r8
    ac6d:	0f 83 34 01 00 00    	jae    ada7 <fwp_str_lossy+0x1d7>
    ac73:	44 0f b6 44 03 01    	movzbl 0x1(%rbx,%rax,1),%r8d
    ac79:	45 89 c1             	mov    %r8d,%r9d
    ac7c:	41 83 e1 c0          	and    $0xffffffc0,%r9d
    ac80:	41 81 f9 80 00 00 00 	cmp    $0x80,%r9d
    ac87:	0f 85 1a 01 00 00    	jne    ada7 <fwp_str_lossy+0x1d7>
    ac8d:	21 fa                	and    %edi,%edx
    ac8f:	8d 7e 01             	lea    0x1(%rsi),%edi
    ac92:	41 89 d1             	mov    %edx,%r9d
    ac95:	41 c1 e1 06          	shl    $0x6,%r9d
    ac99:	41 83 e0 3f          	and    $0x3f,%r8d
    ac9d:	45 09 c8             	or     %r9d,%r8d
    aca0:	83 ff 02             	cmp    $0x2,%edi
    aca3:	75 05                	jne    acaa <fwp_str_lossy+0xda>
    aca5:	44 89 c7             	mov    %r8d,%edi
    aca8:	eb 58                	jmp    ad02 <fwp_str_lossy+0x132>
    acaa:	0f b6 54 03 02       	movzbl 0x2(%rbx,%rax,1),%edx
    acaf:	41 89 d1             	mov    %edx,%r9d
    acb2:	41 83 e1 c0          	and    $0xffffffc0,%r9d
    acb6:	41 81 f9 80 00 00 00 	cmp    $0x80,%r9d
    acbd:	0f 85 e4 00 00 00    	jne    ada7 <fwp_str_lossy+0x1d7>
    acc3:	45 89 c1             	mov    %r8d,%r9d
    acc6:	41 c1 e1 06          	shl    $0x6,%r9d
    acca:	83 e2 3f             	and    $0x3f,%edx
    accd:	44 09 ca             	or     %r9d,%edx
    acd0:	83 ff 03             	cmp    $0x3,%edi
    acd3:	75 07                	jne    acdc <fwp_str_lossy+0x10c>
    acd5:	89 d7                	mov    %edx,%edi
    acd7:	44 89 c2             	mov    %r8d,%edx
    acda:	eb 26                	jmp    ad02 <fwp_str_lossy+0x132>
    acdc:	0f b6 7c 03 03       	movzbl 0x3(%rbx,%rax,1),%edi
    ace1:	41 89 f8             	mov    %edi,%r8d
    ace4:	41 83 e0 c0          	and    $0xffffffc0,%r8d
    ace8:	41 81 f8 80 00 00 00 	cmp    $0x80,%r8d
    acef:	0f 85 b2 00 00 00    	jne    ada7 <fwp_str_lossy+0x1d7>
    acf5:	41 89 d0             	mov    %edx,%r8d
    acf8:	41 c1 e0 06          	shl    $0x6,%r8d
    acfc:	83 e7 3f             	and    $0x3f,%edi
    acff:	44 09 c7             	or     %r8d,%edi
    ad02:	83 e2 e0             	and    $0xffffffe0,%edx
    ad05:	81 fa 60 03 00 00    	cmp    $0x360,%edx
    ad0b:	0f 84 96 00 00 00    	je     ada7 <fwp_str_lossy+0x1d7>
    ad11:	39 cf                	cmp    %ecx,%edi
    ad13:	0f 82 8e 00 00 00    	jb     ada7 <fwp_str_lossy+0x1d7>
    ad19:	81 ff ff ff 10 00    	cmp    $0x10ffff,%edi
    ad1f:	0f 87 82 00 00 00    	ja     ada7 <fwp_str_lossy+0x1d7>
    ad25:	48 01 f0             	add    %rsi,%rax
    ad28:	48 ff c0             	inc    %rax
    ad2b:	4c 39 f0             	cmp    %r14,%rax
    ad2e:	0f 82 d8 fe ff ff    	jb     ac0c <fwp_str_lossy+0x3c>
    ad34:	49 8d 56 09          	lea    0x9(%r14),%rdx
    ad38:	48 ff 05 e9 ff 00 00 	incq   0xffe9(%rip)        # 1ad28 <measured_calls>
    ad3f:	48 01 15 ea ff 00 00 	add    %rdx,0xffea(%rip)        # 1ad30 <measured_bytes>
    ad46:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    ad4d:	0f 87 01 02 00 00    	ja     af54 <fwp_str_lossy+0x384>
    ad53:	49 8d 4e 18          	lea    0x18(%r14),%rcx
    ad57:	48 c1 e9 04          	shr    $0x4,%rcx
    ad5b:	48 8d 05 26 e5 00 00 	lea    0xe526(%rip),%rax        # 19288 <fwp_gc>
    ad62:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    ad69:	00 
    ad6a:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    ad71:	48 29 0d 10 e5 00 00 	sub    %rcx,0xe510(%rip)        # 19288 <fwp_gc>
    ad78:	0f 88 d6 01 00 00    	js     af54 <fwp_str_lossy+0x384>
    ad7e:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    ad82:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    ad86:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    ad8d:	4c 8b 3f             	mov    (%rdi),%r15
    ad90:	4d 85 ff             	test   %r15,%r15
    ad93:	0f 84 a3 01 00 00    	je     af3c <fwp_str_lossy+0x36c>
    ad99:	49 8b 07             	mov    (%r15),%rax
    ad9c:	48 f7 d0             	not    %rax
    ad9f:	48 89 07             	mov    %rax,(%rdi)
    ada2:	e9 cf 01 00 00       	jmp    af76 <fwp_str_lossy+0x3a6>
    ada7:	0f 57 c0             	xorps  %xmm0,%xmm0
    adaa:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    adaf:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    adb6:	00 00 
    adb8:	31 ed                	xor    %ebp,%ebp
    adba:	4c 8d 7c 24 10       	lea    0x10(%rsp),%r15
    adbf:	4c 8d 64 24 0f       	lea    0xf(%rsp),%r12
    adc4:	eb 30                	jmp    adf6 <fwp_str_lossy+0x226>
    adc6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    adcd:	00 00 00 
    add0:	88 44 24 0f          	mov    %al,0xf(%rsp)
    add4:	ba 01 00 00 00       	mov    $0x1,%edx
    add9:	4c 89 ff             	mov    %r15,%rdi
    addc:	4c 89 e6             	mov    %r12,%rsi
    addf:	e8 2c 1f 00 00       	call   cd10 <buf_put>
    ade4:	48 ff c5             	inc    %rbp
    ade7:	49 89 ed             	mov    %rbp,%r13
    adea:	4c 89 ed             	mov    %r13,%rbp
    aded:	4d 39 f5             	cmp    %r14,%r13
    adf0:	0f 83 37 01 00 00    	jae    af2d <fwp_str_lossy+0x35d>
    adf6:	0f b6 04 2b          	movzbl (%rbx,%rbp,1),%eax
    adfa:	84 c0                	test   %al,%al
    adfc:	79 d2                	jns    add0 <fwp_str_lossy+0x200>
    adfe:	8d 48 20             	lea    0x20(%rax),%ecx
    ae01:	80 f9 e1             	cmp    $0xe1,%cl
    ae04:	77 34                	ja     ae3a <fwp_str_lossy+0x26a>
    ae06:	89 c2                	mov    %eax,%edx
    ae08:	80 e2 f0             	and    $0xf0,%dl
    ae0b:	80 fa e0             	cmp    $0xe0,%dl
    ae0e:	0f 85 d5 00 00 00    	jne    aee9 <fwp_str_lossy+0x319>
    ae14:	3c e0                	cmp    $0xe0,%al
    ae16:	40 0f 94 c6          	sete   %sil
    ae1a:	40 c0 e6 05          	shl    $0x5,%sil
    ae1e:	40 80 ce 80          	or     $0x80,%sil
    ae22:	31 ff                	xor    %edi,%edi
    ae24:	3c ed                	cmp    $0xed,%al
    ae26:	40 0f 95 c7          	setne  %dil
    ae2a:	c1 e7 05             	shl    $0x5,%edi
    ae2d:	81 cf 9f 00 00 00    	or     $0x9f,%edi
    ae33:	b8 02 00 00 00       	mov    $0x2,%eax
    ae38:	eb 0d                	jmp    ae47 <fwp_str_lossy+0x277>
    ae3a:	bf bf 00 00 00       	mov    $0xbf,%edi
    ae3f:	40 b6 80             	mov    $0x80,%sil
    ae42:	b8 01 00 00 00       	mov    $0x1,%eax
    ae47:	31 d2                	xor    %edx,%edx
    ae49:	4c 8d 6d 01          	lea    0x1(%rbp),%r13
    ae4d:	4d 39 f5             	cmp    %r14,%r13
    ae50:	73 7e                	jae    aed0 <fwp_str_lossy+0x300>
    ae52:	46 0f b6 04 2b       	movzbl (%rbx,%r13,1),%r8d
    ae57:	41 38 f0             	cmp    %sil,%r8b
    ae5a:	72 74                	jb     aed0 <fwp_str_lossy+0x300>
    ae5c:	44 39 c7             	cmp    %r8d,%edi
    ae5f:	72 6f                	jb     aed0 <fwp_str_lossy+0x300>
    ae61:	4c 8d 6d 02          	lea    0x2(%rbp),%r13
    ae65:	be 01 00 00 00       	mov    $0x1,%esi
    ae6a:	80 f9 e1             	cmp    $0xe1,%cl
    ae6d:	77 44                	ja     aeb3 <fwp_str_lossy+0x2e3>
    ae6f:	4d 39 f5             	cmp    %r14,%r13
    ae72:	73 3f                	jae    aeb3 <fwp_str_lossy+0x2e3>
    ae74:	42 0f b6 0c 2b       	movzbl (%rbx,%r13,1),%ecx
    ae79:	80 e1 c0             	and    $0xc0,%cl
    ae7c:	80 f9 80             	cmp    $0x80,%cl
    ae7f:	75 32                	jne    aeb3 <fwp_str_lossy+0x2e3>
    ae81:	4c 8d 6d 03          	lea    0x3(%rbp),%r13
    ae85:	4d 39 f5             	cmp    %r14,%r13
    ae88:	0f 93 c1             	setae  %cl
    ae8b:	80 f2 01             	xor    $0x1,%dl
    ae8e:	be 02 00 00 00       	mov    $0x2,%esi
    ae93:	08 ca                	or     %cl,%dl
    ae95:	75 1c                	jne    aeb3 <fwp_str_lossy+0x2e3>
    ae97:	0f b6 4c 2b 03       	movzbl 0x3(%rbx,%rbp,1),%ecx
    ae9c:	80 e1 c0             	and    $0xc0,%cl
    ae9f:	31 f6                	xor    %esi,%esi
    aea1:	80 f9 80             	cmp    $0x80,%cl
    aea4:	0f 94 c1             	sete   %cl
    aea7:	75 04                	jne    aead <fwp_str_lossy+0x2dd>
    aea9:	4c 8d 6d 04          	lea    0x4(%rbp),%r13
    aead:	40 88 ce             	mov    %cl,%sil
    aeb0:	83 ce 02             	or     $0x2,%esi
    aeb3:	39 c6                	cmp    %eax,%esi
    aeb5:	75 19                	jne    aed0 <fwp_str_lossy+0x300>
    aeb7:	48 8d 34 2b          	lea    (%rbx,%rbp,1),%rsi
    aebb:	4c 89 ea             	mov    %r13,%rdx
    aebe:	48 29 ea             	sub    %rbp,%rdx
    aec1:	4c 89 ff             	mov    %r15,%rdi
    aec4:	eb 19                	jmp    aedf <fwp_str_lossy+0x30f>
    aec6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    aecd:	00 00 00 
    aed0:	ba 03 00 00 00       	mov    $0x3,%edx
    aed5:	4c 89 ff             	mov    %r15,%rdi
    aed8:	48 8d 35 4c a7 00 00 	lea    0xa74c(%rip),%rsi        # 1562b <exec_in_fp0+0xe1b>
    aedf:	e8 2c 1e 00 00       	call   cd10 <buf_put>
    aee4:	e9 01 ff ff ff       	jmp    adea <fwp_str_lossy+0x21a>
    aee9:	8d 50 10             	lea    0x10(%rax),%edx
    aeec:	80 fa 04             	cmp    $0x4,%dl
    aeef:	77 28                	ja     af19 <fwp_str_lossy+0x349>
    aef1:	3c f0                	cmp    $0xf0,%al
    aef3:	40 0f 94 c6          	sete   %sil
    aef7:	bf 8f 00 00 00       	mov    $0x8f,%edi
    aefc:	3c f4                	cmp    $0xf4,%al
    aefe:	74 05                	je     af05 <fwp_str_lossy+0x335>
    af00:	bf bf 00 00 00       	mov    $0xbf,%edi
    af05:	40 c0 e6 04          	shl    $0x4,%sil
    af09:	40 80 ce 80          	or     $0x80,%sil
    af0d:	b8 03 00 00 00       	mov    $0x3,%eax
    af12:	b2 01                	mov    $0x1,%dl
    af14:	e9 30 ff ff ff       	jmp    ae49 <fwp_str_lossy+0x279>
    af19:	ba 03 00 00 00       	mov    $0x3,%edx
    af1e:	4c 89 ff             	mov    %r15,%rdi
    af21:	48 8d 35 03 a7 00 00 	lea    0xa703(%rip),%rsi        # 1562b <exec_in_fp0+0xe1b>
    af28:	e9 b2 fe ff ff       	jmp    addf <fwp_str_lossy+0x20f>
    af2d:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    af32:	e8 c9 1e 00 00       	call   ce00 <buf_to_str>
    af37:	49 89 c7             	mov    %rax,%r15
    af3a:	eb 5c                	jmp    af98 <fwp_str_lossy+0x3c8>
    af3c:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    af43:	00 
    af44:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    af4b:	00 
    af4c:	4c 29 ff             	sub    %r15,%rdi
    af4f:	48 39 cf             	cmp    %rcx,%rdi
    af52:	73 12                	jae    af66 <fwp_str_lossy+0x396>
    af54:	48 89 d7             	mov    %rdx,%rdi
    af57:	be 01 00 00 00       	mov    $0x1,%esi
    af5c:	e8 bf cd ff ff       	call   7d20 <fwp_gc_alloc_slow>
    af61:	49 89 c7             	mov    %rax,%r15
    af64:	eb 1a                	jmp    af80 <fwp_str_lossy+0x3b0>
    af66:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    af6a:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    af70:	4c 01 f9             	add    %r15,%rcx
    af73:	48 89 08             	mov    %rcx,(%rax)
    af76:	4c 89 ff             	mov    %r15,%rdi
    af79:	31 f6                	xor    %esi,%esi
    af7b:	e8 90 82 ff ff       	call   3210 <memset@plt>
    af80:	4d 89 37             	mov    %r14,(%r15)
    af83:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    af87:	48 89 de             	mov    %rbx,%rsi
    af8a:	4c 89 f2             	mov    %r14,%rdx
    af8d:	e8 9e 83 ff ff       	call   3330 <memcpy@plt>
    af92:	43 c6 44 37 08 00    	movb   $0x0,0x8(%r15,%r14,1)
    af98:	4c 89 f8             	mov    %r15,%rax
    af9b:	48 83 c4 28          	add    $0x28,%rsp
    af9f:	5b                   	pop    %rbx
    afa0:	41 5c                	pop    %r12
    afa2:	41 5d                	pop    %r13
    afa4:	41 5e                	pop    %r14
    afa6:	41 5f                	pop    %r15
    afa8:	5d                   	pop    %rbp
    afa9:	c3                   	ret
    afaa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000afb0 <fwp_alloc_leaf>:
    afb0:	53                   	push   %rbx
    afb1:	48 89 fa             	mov    %rdi,%rdx
    afb4:	48 ff 05 6d fd 00 00 	incq   0xfd6d(%rip)        # 1ad28 <measured_calls>
    afbb:	48 01 3d 6e fd 00 00 	add    %rdi,0xfd6e(%rip)        # 1ad30 <measured_bytes>
    afc2:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    afc9:	77 61                	ja     b02c <fwp_alloc_leaf+0x7c>
    afcb:	48 8d 4a 0f          	lea    0xf(%rdx),%rcx
    afcf:	48 c1 e9 04          	shr    $0x4,%rcx
    afd3:	48 8d 05 ae e2 00 00 	lea    0xe2ae(%rip),%rax        # 19288 <fwp_gc>
    afda:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    afe1:	00 
    afe2:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    afe9:	48 29 0d 98 e2 00 00 	sub    %rcx,0xe298(%rip)        # 19288 <fwp_gc>
    aff0:	78 3a                	js     b02c <fwp_alloc_leaf+0x7c>
    aff2:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    aff6:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    affa:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    b001:	48 8b 1f             	mov    (%rdi),%rbx
    b004:	48 85 db             	test   %rbx,%rbx
    b007:	74 0b                	je     b014 <fwp_alloc_leaf+0x64>
    b009:	48 8b 03             	mov    (%rbx),%rax
    b00c:	48 f7 d0             	not    %rax
    b00f:	48 89 07             	mov    %rax,(%rdi)
    b012:	eb 36                	jmp    b04a <fwp_alloc_leaf+0x9a>
    b014:	48 8b 9c f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%rbx
    b01b:	00 
    b01c:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    b023:	00 
    b024:	48 29 df             	sub    %rbx,%rdi
    b027:	48 39 cf             	cmp    %rcx,%rdi
    b02a:	73 0e                	jae    b03a <fwp_alloc_leaf+0x8a>
    b02c:	48 89 d7             	mov    %rdx,%rdi
    b02f:	be 01 00 00 00       	mov    $0x1,%esi
    b034:	5b                   	pop    %rbx
    b035:	e9 e6 cc ff ff       	jmp    7d20 <fwp_gc_alloc_slow>
    b03a:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    b03e:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    b044:	48 01 d9             	add    %rbx,%rcx
    b047:	48 89 08             	mov    %rcx,(%rax)
    b04a:	48 89 df             	mov    %rbx,%rdi
    b04d:	31 f6                	xor    %esi,%esi
    b04f:	e8 bc 81 ff ff       	call   3210 <memset@plt>
    b054:	48 89 d8             	mov    %rbx,%rax
    b057:	5b                   	pop    %rbx
    b058:	c3                   	ret
    b059:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000b060 <fwp_pipe_write>:
    b060:	55                   	push   %rbp
    b061:	41 57                	push   %r15
    b063:	41 56                	push   %r14
    b065:	41 55                	push   %r13
    b067:	41 54                	push   %r12
    b069:	53                   	push   %rbx
    b06a:	48 83 ec 48          	sub    $0x48,%rsp
    b06e:	48 89 f3             	mov    %rsi,%rbx
    b071:	49 89 fe             	mov    %rdi,%r14
    b074:	8b 05 26 fd 01 00    	mov    0x1fd26(%rip),%eax        # 2ada0 <fwp_po_kind>
    b07a:	83 f8 01             	cmp    $0x1,%eax
    b07d:	0f 84 cc 02 00 00    	je     b34f <fwp_pipe_write+0x2ef>
    b083:	83 f8 02             	cmp    $0x2,%eax
    b086:	0f 85 4e 03 00 00    	jne    b3da <fwp_pipe_write+0x37a>
    b08c:	48 85 db             	test   %rbx,%rbx
    b08f:	0f 84 0d 04 00 00    	je     b4a2 <fwp_pipe_write+0x442>
    b095:	f6 05 1c fd 02 00 01 	testb  $0x1,0x2fd1c(%rip)        # 3adb8 <fwp_po_gone>
    b09c:	0f 85 00 04 00 00    	jne    b4a2 <fwp_pipe_write+0x442>
    b0a2:	4c 8b 2d 07 fd 02 00 	mov    0x2fd07(%rip),%r13        # 3adb0 <fwp_po_ring>
    b0a9:	49 8d 85 00 10 00 00 	lea    0x1000(%r13),%rax
    b0b0:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    b0b5:	49 8d 85 c0 00 00 00 	lea    0xc0(%r13),%rax
    b0bc:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    b0c1:	49 8d 85 00 01 00 00 	lea    0x100(%r13),%rax
    b0c8:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    b0cd:	0f 1f 00             	nopl   (%rax)
    b0d0:	49 8b 6d 40          	mov    0x40(%r13),%rbp
    b0d4:	4d 8b bd 80 00 00 00 	mov    0x80(%r13),%r15
    b0db:	4d 8b 65 08          	mov    0x8(%r13),%r12
    b0df:	49 29 ef             	sub    %rbp,%r15
    b0e2:	4d 01 e7             	add    %r12,%r15
    b0e5:	0f 84 b5 00 00 00    	je     b1a0 <fwp_pipe_write+0x140>
    b0eb:	4c 39 fb             	cmp    %r15,%rbx
    b0ee:	48 89 5c 24 38       	mov    %rbx,0x38(%rsp)
    b0f3:	4c 0f 42 fb          	cmovb  %rbx,%r15
    b0f7:	49 8d 7c 24 ff       	lea    -0x1(%r12),%rdi
    b0fc:	48 21 ef             	and    %rbp,%rdi
    b0ff:	49 29 fc             	sub    %rdi,%r12
    b102:	4d 39 e7             	cmp    %r12,%r15
    b105:	4d 0f 42 e7          	cmovb  %r15,%r12
    b109:	48 8b 5c 24 28       	mov    0x28(%rsp),%rbx
    b10e:	48 01 df             	add    %rbx,%rdi
    b111:	4c 89 f6             	mov    %r14,%rsi
    b114:	4c 89 e2             	mov    %r12,%rdx
    b117:	e8 14 82 ff ff       	call   3330 <memcpy@plt>
    b11c:	4c 89 74 24 40       	mov    %r14,0x40(%rsp)
    b121:	4b 8d 34 26          	lea    (%r14,%r12,1),%rsi
    b125:	4c 89 fa             	mov    %r15,%rdx
    b128:	4c 29 e2             	sub    %r12,%rdx
    b12b:	48 89 df             	mov    %rbx,%rdi
    b12e:	e8 fd 81 ff ff       	call   3330 <memcpy@plt>
    b133:	4c 01 fd             	add    %r15,%rbp
    b136:	49 89 6d 40          	mov    %rbp,0x40(%r13)
    b13a:	0f ae f0             	mfence
    b13d:	41 8b 85 c4 00 00 00 	mov    0xc4(%r13),%eax
    b144:	85 c0                	test   %eax,%eax
    b146:	74 2b                	je     b173 <fwp_pipe_write+0x113>
    b148:	48 8b 74 24 20       	mov    0x20(%rsp),%rsi
    b14d:	f0 ff 06             	lock incl (%rsi)
    b150:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    b157:	bf ca 00 00 00       	mov    $0xca,%edi
    b15c:	ba 01 00 00 00       	mov    $0x1,%edx
    b161:	b9 ff ff ff 7f       	mov    $0x7fffffff,%ecx
    b166:	45 31 c0             	xor    %r8d,%r8d
    b169:	45 31 c9             	xor    %r9d,%r9d
    b16c:	31 c0                	xor    %eax,%eax
    b16e:	e8 8d 81 ff ff       	call   3300 <syscall@plt>
    b173:	4c 8b 74 24 40       	mov    0x40(%rsp),%r14
    b178:	4d 01 fe             	add    %r15,%r14
    b17b:	48 8b 5c 24 38       	mov    0x38(%rsp),%rbx
    b180:	4c 29 fb             	sub    %r15,%rbx
    b183:	48 85 db             	test   %rbx,%rbx
    b186:	0f 84 16 03 00 00    	je     b4a2 <fwp_pipe_write+0x442>
    b18c:	f6 05 25 fc 02 00 01 	testb  $0x1,0x2fc25(%rip)        # 3adb8 <fwp_po_gone>
    b193:	0f 84 37 ff ff ff    	je     b0d0 <fwp_pipe_write+0x70>
    b199:	e9 04 03 00 00       	jmp    b4a2 <fwp_pipe_write+0x442>
    b19e:	66 90                	xchg   %ax,%ax
    b1a0:	44 8b 25 1d fb 00 00 	mov    0xfb1d(%rip),%r12d        # 1acc4 <fwp_po_sock>
    b1a7:	8b 0d 1b fb 00 00    	mov    0xfb1b(%rip),%ecx        # 1acc8 <fwp_ring_spin>
    b1ad:	85 c9                	test   %ecx,%ecx
    b1af:	78 09                	js     b1ba <fwp_pipe_write+0x15a>
    b1b1:	85 c9                	test   %ecx,%ecx
    b1b3:	75 22                	jne    b1d7 <fwp_pipe_write+0x177>
    b1b5:	e9 96 00 00 00       	jmp    b250 <fwp_pipe_write+0x1f0>
    b1ba:	bf 54 00 00 00       	mov    $0x54,%edi
    b1bf:	e8 5c 82 ff ff       	call   3420 <sysconf@plt>
    b1c4:	31 c9                	xor    %ecx,%ecx
    b1c6:	48 83 f8 02          	cmp    $0x2,%rax
    b1ca:	0f 9d c1             	setge  %cl
    b1cd:	89 0d f5 fa 00 00    	mov    %ecx,0xfaf5(%rip)        # 1acc8 <fwp_ring_spin>
    b1d3:	85 c9                	test   %ecx,%ecx
    b1d5:	74 79                	je     b250 <fwp_pipe_write+0x1f0>
    b1d7:	49 8b 85 80 00 00 00 	mov    0x80(%r13),%rax
    b1de:	49 2b 45 40          	sub    0x40(%r13),%rax
    b1e2:	49 03 45 08          	add    0x8(%r13),%rax
    b1e6:	75 9b                	jne    b183 <fwp_pipe_write+0x123>
    b1e8:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    b1ee:	31 ed                	xor    %ebp,%ebp
    b1f0:	eb 26                	jmp    b218 <fwp_pipe_write+0x1b8>
    b1f2:	48 05 50 c3 00 00    	add    $0xc350,%rax
    b1f8:	48 89 c5             	mov    %rax,%rbp
    b1fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    b200:	41 ff c7             	inc    %r15d
    b203:	49 8b 85 80 00 00 00 	mov    0x80(%r13),%rax
    b20a:	49 2b 45 40          	sub    0x40(%r13),%rax
    b20e:	49 03 45 08          	add    0x8(%r13),%rax
    b212:	0f 85 6b ff ff ff    	jne    b183 <fwp_pipe_write+0x123>
    b218:	f3 90                	pause
    b21a:	41 f6 c7 3f          	test   $0x3f,%r15b
    b21e:	75 e0                	jne    b200 <fwp_pipe_write+0x1a0>
    b220:	e8 2b 80 ff ff       	call   3250 <sched_yield@plt>
    b225:	bf 01 00 00 00       	mov    $0x1,%edi
    b22a:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    b22f:	e8 fc 7e ff ff       	call   3130 <clock_gettime@plt>
    b234:	48 69 44 24 10 00 ca 	imul   $0x3b9aca00,0x10(%rsp),%rax
    b23b:	9a 3b 
    b23d:	48 03 44 24 18       	add    0x18(%rsp),%rax
    b242:	48 85 ed             	test   %rbp,%rbp
    b245:	74 ab                	je     b1f2 <fwp_pipe_write+0x192>
    b247:	48 39 e8             	cmp    %rbp,%rax
    b24a:	7e b4                	jle    b200 <fwp_pipe_write+0x1a0>
    b24c:	0f 1f 40 00          	nopl   0x0(%rax)
    b250:	41 8b 8d 00 01 00 00 	mov    0x100(%r13),%ecx
    b257:	b8 01 00 00 00       	mov    $0x1,%eax
    b25c:	41 87 85 04 01 00 00 	xchg   %eax,0x104(%r13)
    b263:	0f ae f0             	mfence
    b266:	49 8b 85 80 00 00 00 	mov    0x80(%r13),%rax
    b26d:	49 2b 45 40          	sub    0x40(%r13),%rax
    b271:	49 03 45 08          	add    0x8(%r13),%rax
    b275:	0f 85 c4 00 00 00    	jne    b33f <fwp_pipe_write+0x2df>
    b27b:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    b282:	00 00 
    b284:	48 c7 44 24 18 00 e1 	movq   $0x5f5e100,0x18(%rsp)
    b28b:	f5 05 
    b28d:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    b294:	bf ca 00 00 00       	mov    $0xca,%edi
    b299:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    b29e:	31 d2                	xor    %edx,%edx
    b2a0:	4c 8d 44 24 10       	lea    0x10(%rsp),%r8
    b2a5:	45 31 c9             	xor    %r9d,%r9d
    b2a8:	31 c0                	xor    %eax,%eax
    b2aa:	e8 51 80 ff ff       	call   3300 <syscall@plt>
    b2af:	41 c7 85 04 01 00 00 	movl   $0x0,0x104(%r13)
    b2b6:	00 00 00 00 
    b2ba:	49 8b 8d 80 00 00 00 	mov    0x80(%r13),%rcx
    b2c1:	49 2b 4d 40          	sub    0x40(%r13),%rcx
    b2c5:	49 03 4d 08          	add    0x8(%r13),%rcx
    b2c9:	0f 85 b4 fe ff ff    	jne    b183 <fwp_pipe_write+0x123>
    b2cf:	48 85 c0             	test   %rax,%rax
    b2d2:	0f 84 78 ff ff ff    	je     b250 <fwp_pipe_write+0x1f0>
    b2d8:	e8 a3 7d ff ff       	call   3080 <__errno_location@plt>
    b2dd:	83 38 6e             	cmpl   $0x6e,(%rax)
    b2e0:	0f 85 6a ff ff ff    	jne    b250 <fwp_pipe_write+0x1f0>
    b2e6:	44 89 64 24 10       	mov    %r12d,0x10(%rsp)
    b2eb:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%rsp)
    b2f2:	00 
    b2f3:	be 01 00 00 00       	mov    $0x1,%esi
    b2f8:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    b2fd:	31 d2                	xor    %edx,%edx
    b2ff:	e8 bc 80 ff ff       	call   33c0 <poll@plt>
    b304:	85 c0                	test   %eax,%eax
    b306:	0f 8e 44 ff ff ff    	jle    b250 <fwp_pipe_write+0x1f0>
    b30c:	f6 44 24 16 18       	testb  $0x18,0x16(%rsp)
    b311:	75 20                	jne    b333 <fwp_pipe_write+0x2d3>
    b313:	ba 01 00 00 00       	mov    $0x1,%edx
    b318:	44 89 e7             	mov    %r12d,%edi
    b31b:	48 8d 74 24 0f       	lea    0xf(%rsp),%rsi
    b320:	b9 42 00 00 00       	mov    $0x42,%ecx
    b325:	e8 36 7d ff ff       	call   3060 <recv@plt>
    b32a:	48 85 c0             	test   %rax,%rax
    b32d:	0f 85 1d ff ff ff    	jne    b250 <fwp_pipe_write+0x1f0>
    b333:	c6 05 7e fa 02 00 01 	movb   $0x1,0x2fa7e(%rip)        # 3adb8 <fwp_po_gone>
    b33a:	e9 44 fe ff ff       	jmp    b183 <fwp_pipe_write+0x123>
    b33f:	41 c7 85 04 01 00 00 	movl   $0x0,0x104(%r13)
    b346:	00 00 00 00 
    b34a:	e9 34 fe ff ff       	jmp    b183 <fwp_pipe_write+0x123>
    b34f:	4c 8b 3d 52 fa 01 00 	mov    0x1fa52(%rip),%r15        # 2ada8 <fwp_po_len>
    b356:	49 8d 04 1f          	lea    (%r15,%rbx,1),%rax
    b35a:	48 3d 01 00 01 00    	cmp    $0x10001,%rax
    b360:	0f 82 b1 00 00 00    	jb     b417 <fwp_pipe_write+0x3b7>
    b366:	4d 85 ff             	test   %r15,%r15
    b369:	0f 84 9a 00 00 00    	je     b409 <fwp_pipe_write+0x3a9>
    b36f:	80 3d 42 fa 02 00 00 	cmpb   $0x0,0x2fa42(%rip)        # 3adb8 <fwp_po_gone>
    b376:	0f 85 8d 00 00 00    	jne    b409 <fwp_pipe_write+0x3a9>
    b37c:	8b 2d 42 f9 00 00    	mov    0xf942(%rip),%ebp        # 1acc4 <fwp_po_sock>
    b382:	4c 8d 25 27 fa 01 00 	lea    0x1fa27(%rip),%r12        # 2adb0 <fwp_po_buf>
    b389:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    b390:	89 ef                	mov    %ebp,%edi
    b392:	4c 89 e6             	mov    %r12,%rsi
    b395:	4c 89 fa             	mov    %r15,%rdx
    b398:	b9 00 40 00 00       	mov    $0x4000,%ecx
    b39d:	e8 fe 7d ff ff       	call   31a0 <send@plt>
    b3a2:	48 85 c0             	test   %rax,%rax
    b3a5:	78 19                	js     b3c0 <fwp_pipe_write+0x360>
    b3a7:	74 59                	je     b402 <fwp_pipe_write+0x3a2>
    b3a9:	49 01 c4             	add    %rax,%r12
    b3ac:	49 29 c7             	sub    %rax,%r15
    b3af:	eb 19                	jmp    b3ca <fwp_pipe_write+0x36a>
    b3b1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b3b8:	0f 1f 84 00 00 00 00 
    b3bf:	00 
    b3c0:	e8 bb 7c ff ff       	call   3080 <__errno_location@plt>
    b3c5:	83 38 04             	cmpl   $0x4,(%rax)
    b3c8:	75 38                	jne    b402 <fwp_pipe_write+0x3a2>
    b3ca:	4d 85 ff             	test   %r15,%r15
    b3cd:	74 3a                	je     b409 <fwp_pipe_write+0x3a9>
    b3cf:	f6 05 e2 f9 02 00 01 	testb  $0x1,0x2f9e2(%rip)        # 3adb8 <fwp_po_gone>
    b3d6:	74 b8                	je     b390 <fwp_pipe_write+0x330>
    b3d8:	eb 2f                	jmp    b409 <fwp_pipe_write+0x3a9>
    b3da:	48 8b 05 cf db 00 00 	mov    0xdbcf(%rip),%rax        # 18fb0 <stdout@GLIBC_2.2.5>
    b3e1:	48 8b 08             	mov    (%rax),%rcx
    b3e4:	be 01 00 00 00       	mov    $0x1,%esi
    b3e9:	4c 89 f7             	mov    %r14,%rdi
    b3ec:	48 89 da             	mov    %rbx,%rdx
    b3ef:	48 83 c4 48          	add    $0x48,%rsp
    b3f3:	5b                   	pop    %rbx
    b3f4:	41 5c                	pop    %r12
    b3f6:	41 5d                	pop    %r13
    b3f8:	41 5e                	pop    %r14
    b3fa:	41 5f                	pop    %r15
    b3fc:	5d                   	pop    %rbp
    b3fd:	e9 7e 80 ff ff       	jmp    3480 <fwrite@plt>
    b402:	c6 05 af f9 02 00 01 	movb   $0x1,0x2f9af(%rip)        # 3adb8 <fwp_po_gone>
    b409:	48 c7 05 94 f9 01 00 	movq   $0x0,0x1f994(%rip)        # 2ada8 <fwp_po_len>
    b410:	00 00 00 00 
    b414:	45 31 ff             	xor    %r15d,%r15d
    b417:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    b41e:	72 5a                	jb     b47a <fwp_pipe_write+0x41a>
    b420:	80 3d 91 f9 02 00 00 	cmpb   $0x0,0x2f991(%rip)        # 3adb8 <fwp_po_gone>
    b427:	75 79                	jne    b4a2 <fwp_pipe_write+0x442>
    b429:	8b 2d 95 f8 00 00    	mov    0xf895(%rip),%ebp        # 1acc4 <fwp_po_sock>
    b42f:	90                   	nop
    b430:	89 ef                	mov    %ebp,%edi
    b432:	4c 89 f6             	mov    %r14,%rsi
    b435:	48 89 da             	mov    %rbx,%rdx
    b438:	b9 00 40 00 00       	mov    $0x4000,%ecx
    b43d:	e8 5e 7d ff ff       	call   31a0 <send@plt>
    b442:	48 85 c0             	test   %rax,%rax
    b445:	78 19                	js     b460 <fwp_pipe_write+0x400>
    b447:	74 52                	je     b49b <fwp_pipe_write+0x43b>
    b449:	49 01 c6             	add    %rax,%r14
    b44c:	48 29 c3             	sub    %rax,%rbx
    b44f:	eb 19                	jmp    b46a <fwp_pipe_write+0x40a>
    b451:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b458:	0f 1f 84 00 00 00 00 
    b45f:	00 
    b460:	e8 1b 7c ff ff       	call   3080 <__errno_location@plt>
    b465:	83 38 04             	cmpl   $0x4,(%rax)
    b468:	75 31                	jne    b49b <fwp_pipe_write+0x43b>
    b46a:	48 85 db             	test   %rbx,%rbx
    b46d:	74 33                	je     b4a2 <fwp_pipe_write+0x442>
    b46f:	f6 05 42 f9 02 00 01 	testb  $0x1,0x2f942(%rip)        # 3adb8 <fwp_po_gone>
    b476:	74 b8                	je     b430 <fwp_pipe_write+0x3d0>
    b478:	eb 28                	jmp    b4a2 <fwp_pipe_write+0x442>
    b47a:	48 8d 3d 2f f9 01 00 	lea    0x1f92f(%rip),%rdi        # 2adb0 <fwp_po_buf>
    b481:	4c 01 ff             	add    %r15,%rdi
    b484:	4c 89 f6             	mov    %r14,%rsi
    b487:	48 89 da             	mov    %rbx,%rdx
    b48a:	e8 a1 7e ff ff       	call   3330 <memcpy@plt>
    b48f:	49 01 df             	add    %rbx,%r15
    b492:	4c 89 3d 0f f9 01 00 	mov    %r15,0x1f90f(%rip)        # 2ada8 <fwp_po_len>
    b499:	eb 07                	jmp    b4a2 <fwp_pipe_write+0x442>
    b49b:	c6 05 16 f9 02 00 01 	movb   $0x1,0x2f916(%rip)        # 3adb8 <fwp_po_gone>
    b4a2:	48 83 c4 48          	add    $0x48,%rsp
    b4a6:	5b                   	pop    %rbx
    b4a7:	41 5c                	pop    %r12
    b4a9:	41 5d                	pop    %r13
    b4ab:	41 5e                	pop    %r14
    b4ad:	41 5f                	pop    %r15
    b4af:	5d                   	pop    %rbp
    b4b0:	c3                   	ret
    b4b1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b4b8:	0f 1f 84 00 00 00 00 
    b4bf:	00 

000000000000b4c0 <fwp_pipe_flush>:
    b4c0:	55                   	push   %rbp
    b4c1:	41 56                	push   %r14
    b4c3:	53                   	push   %rbx
    b4c4:	8b 05 d6 f8 01 00    	mov    0x1f8d6(%rip),%eax        # 2ada0 <fwp_po_kind>
    b4ca:	85 c0                	test   %eax,%eax
    b4cc:	74 7c                	je     b54a <fwp_pipe_flush+0x8a>
    b4ce:	83 f8 01             	cmp    $0x1,%eax
    b4d1:	0f 85 9d 00 00 00    	jne    b574 <fwp_pipe_flush+0xb4>
    b4d7:	48 8b 1d ca f8 01 00 	mov    0x1f8ca(%rip),%rbx        # 2ada8 <fwp_po_len>
    b4de:	48 85 db             	test   %rbx,%rbx
    b4e1:	0f 84 82 00 00 00    	je     b569 <fwp_pipe_flush+0xa9>
    b4e7:	80 3d ca f8 02 00 00 	cmpb   $0x0,0x2f8ca(%rip)        # 3adb8 <fwp_po_gone>
    b4ee:	75 79                	jne    b569 <fwp_pipe_flush+0xa9>
    b4f0:	8b 2d ce f7 00 00    	mov    0xf7ce(%rip),%ebp        # 1acc4 <fwp_po_sock>
    b4f6:	4c 8d 35 b3 f8 01 00 	lea    0x1f8b3(%rip),%r14        # 2adb0 <fwp_po_buf>
    b4fd:	0f 1f 00             	nopl   (%rax)
    b500:	89 ef                	mov    %ebp,%edi
    b502:	4c 89 f6             	mov    %r14,%rsi
    b505:	48 89 da             	mov    %rbx,%rdx
    b508:	b9 00 40 00 00       	mov    $0x4000,%ecx
    b50d:	e8 8e 7c ff ff       	call   31a0 <send@plt>
    b512:	48 85 c0             	test   %rax,%rax
    b515:	78 19                	js     b530 <fwp_pipe_flush+0x70>
    b517:	74 49                	je     b562 <fwp_pipe_flush+0xa2>
    b519:	49 01 c6             	add    %rax,%r14
    b51c:	48 29 c3             	sub    %rax,%rbx
    b51f:	eb 19                	jmp    b53a <fwp_pipe_flush+0x7a>
    b521:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b528:	0f 1f 84 00 00 00 00 
    b52f:	00 
    b530:	e8 4b 7b ff ff       	call   3080 <__errno_location@plt>
    b535:	83 38 04             	cmpl   $0x4,(%rax)
    b538:	75 28                	jne    b562 <fwp_pipe_flush+0xa2>
    b53a:	48 85 db             	test   %rbx,%rbx
    b53d:	74 2a                	je     b569 <fwp_pipe_flush+0xa9>
    b53f:	f6 05 72 f8 02 00 01 	testb  $0x1,0x2f872(%rip)        # 3adb8 <fwp_po_gone>
    b546:	74 b8                	je     b500 <fwp_pipe_flush+0x40>
    b548:	eb 1f                	jmp    b569 <fwp_pipe_flush+0xa9>
    b54a:	48 8b 05 5f da 00 00 	mov    0xda5f(%rip),%rax        # 18fb0 <stdout@GLIBC_2.2.5>
    b551:	48 8b 38             	mov    (%rax),%rdi
    b554:	e8 f7 7d ff ff       	call   3350 <fflush@plt>
    b559:	5b                   	pop    %rbx
    b55a:	41 5e                	pop    %r14
    b55c:	5d                   	pop    %rbp
    b55d:	e9 5e 50 00 00       	jmp    105c0 <fwp_pipe_poll>
    b562:	c6 05 4f f8 02 00 01 	movb   $0x1,0x2f84f(%rip)        # 3adb8 <fwp_po_gone>
    b569:	48 c7 05 34 f8 01 00 	movq   $0x0,0x1f834(%rip)        # 2ada8 <fwp_po_len>
    b570:	00 00 00 00 
    b574:	5b                   	pop    %rbx
    b575:	41 5e                	pop    %r14
    b577:	5d                   	pop    %rbp
    b578:	c3                   	ret
    b579:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000b580 <fwp_exec_call>:
    b580:	41 57                	push   %r15
    b582:	41 56                	push   %r14
    b584:	41 55                	push   %r13
    b586:	41 54                	push   %r12
    b588:	53                   	push   %rbx
    b589:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
    b590:	48 89 f3             	mov    %rsi,%rbx
    b593:	49 89 fe             	mov    %rdi,%r14
    b596:	48 8b 05 2b f8 02 00 	mov    0x2f82b(%rip),%rax        # 3adc8 <fwp_handlers>
    b59d:	48 89 84 24 e8 00 00 	mov    %rax,0xe8(%rsp)
    b5a4:	00 
    b5a5:	48 c7 84 24 00 01 00 	movq   $0x0,0x100(%rsp)
    b5ac:	00 00 00 00 00 
    b5b1:	48 8b 05 90 f7 00 00 	mov    0xf790(%rip),%rax        # 1ad48 <fwp_cleanups>
    b5b8:	48 89 84 24 08 01 00 	mov    %rax,0x108(%rsp)
    b5bf:	00 
    b5c0:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
    b5c5:	48 89 3d fc f7 02 00 	mov    %rdi,0x2f7fc(%rip)        # 3adc8 <fwp_handlers>
    b5cc:	e8 df 7c ff ff       	call   32b0 <_setjmp@plt>
    b5d1:	85 c0                	test   %eax,%eax
    b5d3:	0f 85 d1 00 00 00    	jne    b6aa <fwp_exec_call+0x12a>
    b5d9:	48 ff 05 48 f7 00 00 	incq   0xf748(%rip)        # 1ad28 <measured_calls>
    b5e0:	48 83 05 48 f7 00 00 	addq   $0x8,0xf748(%rip)        # 1ad30 <measured_bytes>
    b5e7:	08 
    b5e8:	48 8d 05 99 dc 00 00 	lea    0xdc99(%rip),%rax        # 19288 <fwp_gc>
    b5ef:	0f b6 0d 7b e8 00 00 	movzbl 0xe87b(%rip),%ecx        # 19e71 <fwp_gc+0xbe9>
    b5f6:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    b5fd:	48 29 15 84 dc 00 00 	sub    %rdx,0xdc84(%rip)        # 19288 <fwp_gc>
    b604:	78 3a                	js     b640 <fwp_exec_call+0xc0>
    b606:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    b60a:	48 8d 34 c8          	lea    (%rax,%rcx,8),%rsi
    b60e:	48 81 c6 88 07 00 00 	add    $0x788,%rsi
    b615:	4c 8b 3e             	mov    (%rsi),%r15
    b618:	4d 85 ff             	test   %r15,%r15
    b61b:	74 0b                	je     b628 <fwp_exec_call+0xa8>
    b61d:	49 8b 07             	mov    (%r15),%rax
    b620:	48 f7 d0             	not    %rax
    b623:	48 89 06             	mov    %rax,(%rsi)
    b626:	eb 3d                	jmp    b665 <fwp_exec_call+0xe5>
    b628:	4c 8b bc c8 90 07 00 	mov    0x790(%rax,%rcx,8),%r15
    b62f:	00 
    b630:	48 8b b4 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%rsi
    b637:	00 
    b638:	4c 29 fe             	sub    %r15,%rsi
    b63b:	48 39 d6             	cmp    %rdx,%rsi
    b63e:	73 14                	jae    b654 <fwp_exec_call+0xd4>
    b640:	bf 08 00 00 00       	mov    $0x8,%edi
    b645:	be 02 00 00 00       	mov    $0x2,%esi
    b64a:	e8 d1 c6 ff ff       	call   7d20 <fwp_gc_alloc_slow>
    b64f:	48 89 c7             	mov    %rax,%rdi
    b652:	eb 1e                	jmp    b672 <fwp_exec_call+0xf2>
    b654:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    b658:	48 05 90 07 00 00    	add    $0x790,%rax
    b65e:	49 8d 0c 17          	lea    (%r15,%rdx,1),%rcx
    b662:	48 89 08             	mov    %rcx,(%rax)
    b665:	4c 89 ff             	mov    %r15,%rdi
    b668:	31 f6                	xor    %esi,%esi
    b66a:	e8 a1 7b ff ff       	call   3210 <memset@plt>
    b66f:	4c 89 ff             	mov    %r15,%rdi
    b672:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    b679:	be 01 00 00 00       	mov    $0x1,%esi
    b67e:	4c 89 f2             	mov    %r14,%rdx
    b681:	e8 ba b7 ff ff       	call   6e40 <fwp_apply>
    b686:	48 8b 8c 24 e8 00 00 	mov    0xe8(%rsp),%rcx
    b68d:	00 
    b68e:	48 89 0d 33 f7 02 00 	mov    %rcx,0x2f733(%rip)        # 3adc8 <fwp_handlers>
    b695:	31 c9                	xor    %ecx,%ecx
    b697:	89 0b                	mov    %ecx,(%rbx)
    b699:	48 81 c4 10 01 00 00 	add    $0x110,%rsp
    b6a0:	5b                   	pop    %rbx
    b6a1:	41 5c                	pop    %r12
    b6a3:	41 5d                	pop    %r13
    b6a5:	41 5e                	pop    %r14
    b6a7:	41 5f                	pop    %r15
    b6a9:	c3                   	ret
    b6aa:	48 8b 84 24 e8 00 00 	mov    0xe8(%rsp),%rax
    b6b1:	00 
    b6b2:	48 89 05 0f f7 02 00 	mov    %rax,0x2f70f(%rip)        # 3adc8 <fwp_handlers>
    b6b9:	48 8b 3d 38 f6 00 00 	mov    0xf638(%rip),%rdi        # 1acf8 <fwp_prog_out>
    b6c0:	48 85 ff             	test   %rdi,%rdi
    b6c3:	74 05                	je     b6ca <fwp_exec_call+0x14a>
    b6c5:	e8 86 7c ff ff       	call   3350 <fflush@plt>
    b6ca:	48 8b 05 df d8 00 00 	mov    0xd8df(%rip),%rax        # 18fb0 <stdout@GLIBC_2.2.5>
    b6d1:	48 8b 38             	mov    (%rax),%rdi
    b6d4:	e8 77 7c ff ff       	call   3350 <fflush@plt>
    b6d9:	4c 8b b4 24 f0 00 00 	mov    0xf0(%rsp),%r14
    b6e0:	00 
    b6e1:	4c 8b bc 24 f8 00 00 	mov    0xf8(%rsp),%r15
    b6e8:	00 
    b6e9:	e8 d2 fd ff ff       	call   b4c0 <fwp_pipe_flush>
    b6ee:	4c 8b 2d e3 d8 00 00 	mov    0xd8e3(%rip),%r13        # 18fd8 <stderr@GLIBC_2.2.5>
    b6f5:	49 8b 7d 00          	mov    0x0(%r13),%rdi
    b6f9:	48 8d 35 f9 9f 00 00 	lea    0x9ff9(%rip),%rsi        # 156f9 <exec_in_fp0+0xee9>
    b700:	48 8d 15 83 92 00 00 	lea    0x9283(%rip),%rdx        # 1498a <exec_in_fp0+0x17a>
    b707:	31 c0                	xor    %eax,%eax
    b709:	e8 e2 7b ff ff       	call   32f0 <fprintf@plt>
    b70e:	41 83 3f 10          	cmpl   $0x10,(%r15)
    b712:	75 20                	jne    b734 <fwp_exec_call+0x1b4>
    b714:	49 8b 7f 08          	mov    0x8(%r15),%rdi
    b718:	48 85 ff             	test   %rdi,%rdi
    b71b:	74 17                	je     b734 <fwp_exec_call+0x1b4>
    b71d:	48 8d 35 da 9f 00 00 	lea    0x9fda(%rip),%rsi        # 156fe <exec_in_fp0+0xeee>
    b724:	e8 a7 7b ff ff       	call   32d0 <strcmp@plt>
    b729:	85 c0                	test   %eax,%eax
    b72b:	75 07                	jne    b734 <fwp_exec_call+0x1b4>
    b72d:	41 83 7f 10 02       	cmpl   $0x2,0x10(%r15)
    b732:	74 6b                	je     b79f <fwp_exec_call+0x21f>
    b734:	4d 8b 65 00          	mov    0x0(%r13),%r12
    b738:	0f 57 c0             	xorps  %xmm0,%xmm0
    b73b:	0f 29 04 24          	movaps %xmm0,(%rsp)
    b73f:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    b746:	00 00 
    b748:	48 89 e7             	mov    %rsp,%rdi
    b74b:	4c 89 f6             	mov    %r14,%rsi
    b74e:	4c 89 fa             	mov    %r15,%rdx
    b751:	b9 01 00 00 00       	mov    $0x1,%ecx
    b756:	e8 e5 51 00 00       	call   10940 <fwp_write>
    b75b:	48 8b 3c 24          	mov    (%rsp),%rdi
    b75f:	48 85 ff             	test   %rdi,%rdi
    b762:	75 23                	jne    b787 <fwp_exec_call+0x207>
    b764:	31 c0                	xor    %eax,%eax
    b766:	89 c7                	mov    %eax,%edi
    b768:	e8 e3 78 ff ff       	call   3050 <free@plt>
    b76d:	49 8b 75 00          	mov    0x0(%r13),%rsi
    b771:	bf 0a 00 00 00       	mov    $0xa,%edi
    b776:	e8 c5 7a ff ff       	call   3240 <fputc@plt>
    b77b:	b9 01 00 00 00       	mov    $0x1,%ecx
    b780:	31 c0                	xor    %eax,%eax
    b782:	e9 10 ff ff ff       	jmp    b697 <fwp_exec_call+0x117>
    b787:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    b78c:	be 01 00 00 00       	mov    $0x1,%esi
    b791:	4c 89 e1             	mov    %r12,%rcx
    b794:	e8 e7 7c ff ff       	call   3480 <fwrite@plt>
    b799:	48 8b 3c 24          	mov    (%rsp),%rdi
    b79d:	eb c9                	jmp    b768 <fwp_exec_call+0x1e8>
    b79f:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    b7a3:	48 8b 17             	mov    (%rdi),%rdx
    b7a6:	48 83 c7 08          	add    $0x8,%rdi
    b7aa:	49 8b 4d 00          	mov    0x0(%r13),%rcx
    b7ae:	be 01 00 00 00       	mov    $0x1,%esi
    b7b3:	e8 c8 7c ff ff       	call   3480 <fwrite@plt>
    b7b8:	eb b3                	jmp    b76d <fwp_exec_call+0x1ed>
    b7ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000b7c0 <fwp_emit_result>:
    b7c0:	41 57                	push   %r15
    b7c2:	41 56                	push   %r14
    b7c4:	53                   	push   %rbx
    b7c5:	48 83 ec 30          	sub    $0x30,%rsp
    b7c9:	48 89 fb             	mov    %rdi,%rbx
    b7cc:	83 3d ad f5 01 00 00 	cmpl   $0x0,0x1f5ad(%rip)        # 2ad80 <fwp_exec_binary_out>
    b7d3:	0f 84 3e 01 00 00    	je     b917 <fwp_emit_result+0x157>
    b7d9:	0f 57 c0             	xorps  %xmm0,%xmm0
    b7dc:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    b7e1:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    b7e8:	00 00 
    b7ea:	88 5c 24 0b          	mov    %bl,0xb(%rsp)
    b7ee:	4c 8d 7c 24 10       	lea    0x10(%rsp),%r15
    b7f3:	4c 8d 74 24 0b       	lea    0xb(%rsp),%r14
    b7f8:	ba 01 00 00 00       	mov    $0x1,%edx
    b7fd:	4c 89 ff             	mov    %r15,%rdi
    b800:	4c 89 f6             	mov    %r14,%rsi
    b803:	e8 08 15 00 00       	call   cd10 <buf_put>
    b808:	88 7c 24 0b          	mov    %bh,0xb(%rsp)
    b80c:	ba 01 00 00 00       	mov    $0x1,%edx
    b811:	4c 89 ff             	mov    %r15,%rdi
    b814:	4c 89 f6             	mov    %r14,%rsi
    b817:	e8 f4 14 00 00       	call   cd10 <buf_put>
    b81c:	89 d8                	mov    %ebx,%eax
    b81e:	c1 e8 10             	shr    $0x10,%eax
    b821:	88 44 24 0b          	mov    %al,0xb(%rsp)
    b825:	ba 01 00 00 00       	mov    $0x1,%edx
    b82a:	4c 89 ff             	mov    %r15,%rdi
    b82d:	4c 89 f6             	mov    %r14,%rsi
    b830:	e8 db 14 00 00       	call   cd10 <buf_put>
    b835:	89 d8                	mov    %ebx,%eax
    b837:	c1 e8 18             	shr    $0x18,%eax
    b83a:	88 44 24 0b          	mov    %al,0xb(%rsp)
    b83e:	ba 01 00 00 00       	mov    $0x1,%edx
    b843:	4c 89 ff             	mov    %r15,%rdi
    b846:	4c 89 f6             	mov    %r14,%rsi
    b849:	e8 c2 14 00 00       	call   cd10 <buf_put>
    b84e:	48 89 d8             	mov    %rbx,%rax
    b851:	48 c1 e8 20          	shr    $0x20,%rax
    b855:	88 44 24 0b          	mov    %al,0xb(%rsp)
    b859:	ba 01 00 00 00       	mov    $0x1,%edx
    b85e:	4c 89 ff             	mov    %r15,%rdi
    b861:	4c 89 f6             	mov    %r14,%rsi
    b864:	e8 a7 14 00 00       	call   cd10 <buf_put>
    b869:	48 89 d8             	mov    %rbx,%rax
    b86c:	48 c1 e8 28          	shr    $0x28,%rax
    b870:	88 44 24 0b          	mov    %al,0xb(%rsp)
    b874:	ba 01 00 00 00       	mov    $0x1,%edx
    b879:	4c 89 ff             	mov    %r15,%rdi
    b87c:	4c 89 f6             	mov    %r14,%rsi
    b87f:	e8 8c 14 00 00       	call   cd10 <buf_put>
    b884:	48 89 d8             	mov    %rbx,%rax
    b887:	48 c1 e8 30          	shr    $0x30,%rax
    b88b:	88 44 24 0b          	mov    %al,0xb(%rsp)
    b88f:	ba 01 00 00 00       	mov    $0x1,%edx
    b894:	4c 89 ff             	mov    %r15,%rdi
    b897:	4c 89 f6             	mov    %r14,%rsi
    b89a:	e8 71 14 00 00       	call   cd10 <buf_put>
    b89f:	48 c1 eb 38          	shr    $0x38,%rbx
    b8a3:	88 5c 24 0b          	mov    %bl,0xb(%rsp)
    b8a7:	ba 01 00 00 00       	mov    $0x1,%edx
    b8ac:	4c 89 ff             	mov    %r15,%rdi
    b8af:	4c 89 f6             	mov    %r14,%rsi
    b8b2:	e8 59 14 00 00       	call   cd10 <buf_put>
    b8b7:	c6 44 24 0b 01       	movb   $0x1,0xb(%rsp)
    b8bc:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
    b8c1:	89 5c 24 0c          	mov    %ebx,0xc(%rsp)
    b8c5:	48 8d 7c 24 0b       	lea    0xb(%rsp),%rdi
    b8ca:	be 05 00 00 00       	mov    $0x5,%esi
    b8cf:	e8 8c f7 ff ff       	call   b060 <fwp_pipe_write>
    b8d4:	4c 8b 74 24 10       	mov    0x10(%rsp),%r14
    b8d9:	48 85 db             	test   %rbx,%rbx
    b8dc:	74 0b                	je     b8e9 <fwp_emit_result+0x129>
    b8de:	4c 89 f7             	mov    %r14,%rdi
    b8e1:	48 89 de             	mov    %rbx,%rsi
    b8e4:	e8 77 f7 ff ff       	call   b060 <fwp_pipe_write>
    b8e9:	4c 89 f7             	mov    %r14,%rdi
    b8ec:	e8 5f 77 ff ff       	call   3050 <free@plt>
    b8f1:	83 3d c8 f3 00 00 00 	cmpl   $0x0,0xf3c8(%rip)        # 1acc0 <fwp_po_listen>
    b8f8:	0f 88 84 00 00 00    	js     b982 <fwp_emit_result+0x1c2>
    b8fe:	8b 05 cc f4 02 00    	mov    0x2f4cc(%rip),%eax        # 3add0 <fwp_po_frames>
    b904:	ff c0                	inc    %eax
    b906:	89 05 c4 f4 02 00    	mov    %eax,0x2f4c4(%rip)        # 3add0 <fwp_po_frames>
    b90c:	a8 3f                	test   $0x3f,%al
    b90e:	75 72                	jne    b982 <fwp_emit_result+0x1c2>
    b910:	e8 ab 4c 00 00       	call   105c0 <fwp_pipe_poll>
    b915:	eb 6b                	jmp    b982 <fwp_emit_result+0x1c2>
    b917:	4c 8b 3d 92 d6 00 00 	mov    0xd692(%rip),%r15        # 18fb0 <stdout@GLIBC_2.2.5>
    b91e:	4d 8b 37             	mov    (%r15),%r14
    b921:	0f 57 c0             	xorps  %xmm0,%xmm0
    b924:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    b929:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    b930:	00 00 
    b932:	48 8d 15 87 d2 00 00 	lea    0xd287(%rip),%rdx        # 18bc0 <d2>
    b939:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    b93e:	48 89 de             	mov    %rbx,%rsi
    b941:	b9 01 00 00 00       	mov    $0x1,%ecx
    b946:	e8 f5 4f 00 00       	call   10940 <fwp_write>
    b94b:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    b950:	48 85 ff             	test   %rdi,%rdi
    b953:	74 19                	je     b96e <fwp_emit_result+0x1ae>
    b955:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
    b95a:	be 01 00 00 00       	mov    $0x1,%esi
    b95f:	4c 89 f1             	mov    %r14,%rcx
    b962:	e8 19 7b ff ff       	call   3480 <fwrite@plt>
    b967:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    b96c:	eb 02                	jmp    b970 <fwp_emit_result+0x1b0>
    b96e:	31 ff                	xor    %edi,%edi
    b970:	e8 db 76 ff ff       	call   3050 <free@plt>
    b975:	49 8b 37             	mov    (%r15),%rsi
    b978:	bf 0a 00 00 00       	mov    $0xa,%edi
    b97d:	e8 be 78 ff ff       	call   3240 <fputc@plt>
    b982:	48 83 c4 30          	add    $0x30,%rsp
    b986:	5b                   	pop    %rbx
    b987:	41 5e                	pop    %r14
    b989:	41 5f                	pop    %r15
    b98b:	c3                   	ret
    b98c:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000b990 <fwp_read_exact>:
    b990:	55                   	push   %rbp
    b991:	41 57                	push   %r15
    b993:	41 56                	push   %r14
    b995:	41 55                	push   %r13
    b997:	41 54                	push   %r12
    b999:	53                   	push   %rbx
    b99a:	48 83 ec 48          	sub    $0x48,%rsp
    b99e:	49 89 f7             	mov    %rsi,%r15
    b9a1:	49 89 fe             	mov    %rdi,%r14
    b9a4:	45 31 ed             	xor    %r13d,%r13d
    b9a7:	48 85 f6             	test   %rsi,%rsi
    b9aa:	0f 84 b8 00 00 00    	je     ba68 <fwp_read_exact+0xd8>
    b9b0:	8b 05 d2 f3 01 00    	mov    0x1f3d2(%rip),%eax        # 2ad88 <fwp_in_npend>
    b9b6:	8b 0d d0 f3 01 00    	mov    0x1f3d0(%rip),%ecx        # 2ad8c <fwp_in_ppos>
    b9bc:	39 c1                	cmp    %eax,%ecx
    b9be:	0f 8d a4 00 00 00    	jge    ba68 <fwp_read_exact+0xd8>
    b9c4:	48 98                	cltq
    b9c6:	48 63 f1             	movslq %ecx,%rsi
    b9c9:	48 89 f2             	mov    %rsi,%rdx
    b9cc:	48 f7 d2             	not    %rdx
    b9cf:	48 01 c2             	add    %rax,%rdx
    b9d2:	49 8d 4f ff          	lea    -0x1(%r15),%rcx
    b9d6:	48 39 ca             	cmp    %rcx,%rdx
    b9d9:	48 0f 43 d1          	cmovae %rcx,%rdx
    b9dd:	48 ff c2             	inc    %rdx
    b9e0:	48 83 fa 20          	cmp    $0x20,%rdx
    b9e4:	72 16                	jb     b9fc <fwp_read_exact+0x6c>
    b9e6:	48 8d 3d 97 f3 01 00 	lea    0x1f397(%rip),%rdi        # 2ad84 <fwp_in_pend>
    b9ed:	4d 89 f0             	mov    %r14,%r8
    b9f0:	49 29 f0             	sub    %rsi,%r8
    b9f3:	49 29 f8             	sub    %rdi,%r8
    b9f6:	49 83 f8 20          	cmp    $0x20,%r8
    b9fa:	73 2e                	jae    ba2a <fwp_read_exact+0x9a>
    b9fc:	45 31 ed             	xor    %r13d,%r13d
    b9ff:	48 89 f1             	mov    %rsi,%rcx
    ba02:	48 8d 15 7b f3 01 00 	lea    0x1f37b(%rip),%rdx        # 2ad84 <fwp_in_pend>
    ba09:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    ba10:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    ba14:	48 ff c1             	inc    %rcx
    ba17:	43 88 34 2e          	mov    %sil,(%r14,%r13,1)
    ba1b:	49 ff c5             	inc    %r13
    ba1e:	4d 39 fd             	cmp    %r15,%r13
    ba21:	73 3f                	jae    ba62 <fwp_read_exact+0xd2>
    ba23:	48 39 c1             	cmp    %rax,%rcx
    ba26:	7c e8                	jl     ba10 <fwp_read_exact+0x80>
    ba28:	eb 38                	jmp    ba62 <fwp_read_exact+0xd2>
    ba2a:	49 89 d5             	mov    %rdx,%r13
    ba2d:	49 83 e5 e0          	and    $0xffffffffffffffe0,%r13
    ba31:	4a 8d 0c 2e          	lea    (%rsi,%r13,1),%rcx
    ba35:	48 01 fe             	add    %rdi,%rsi
    ba38:	48 83 c6 10          	add    $0x10,%rsi
    ba3c:	31 ff                	xor    %edi,%edi
    ba3e:	66 90                	xchg   %ax,%ax
    ba40:	0f 10 44 3e f0       	movups -0x10(%rsi,%rdi,1),%xmm0
    ba45:	0f 10 0c 3e          	movups (%rsi,%rdi,1),%xmm1
    ba49:	41 0f 11 04 3e       	movups %xmm0,(%r14,%rdi,1)
    ba4e:	41 0f 11 4c 3e 10    	movups %xmm1,0x10(%r14,%rdi,1)
    ba54:	48 83 c7 20          	add    $0x20,%rdi
    ba58:	49 39 fd             	cmp    %rdi,%r13
    ba5b:	75 e3                	jne    ba40 <fwp_read_exact+0xb0>
    ba5d:	4c 39 ea             	cmp    %r13,%rdx
    ba60:	75 a0                	jne    ba02 <fwp_read_exact+0x72>
    ba62:	89 0d 24 f3 01 00    	mov    %ecx,0x1f324(%rip)        # 2ad8c <fwp_in_ppos>
    ba68:	4c 89 74 24 28       	mov    %r14,0x28(%rsp)
    ba6d:	4c 89 7c 24 38       	mov    %r15,0x38(%rsp)
    ba72:	eb 34                	jmp    baa8 <fwp_read_exact+0x118>
    ba74:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    ba7b:	00 00 00 00 00 
    ba80:	48 8b 05 31 d5 00 00 	mov    0xd531(%rip),%rax        # 18fb8 <stdin@GLIBC_2.2.5>
    ba87:	48 8b 08             	mov    (%rax),%rcx
    ba8a:	be 01 00 00 00       	mov    $0x1,%esi
    ba8f:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    ba94:	48 89 da             	mov    %rbx,%rdx
    ba97:	e8 54 76 ff ff       	call   30f0 <fread@plt>
    ba9c:	49 01 c5             	add    %rax,%r13
    ba9f:	48 85 c0             	test   %rax,%rax
    baa2:	0f 84 db 03 00 00    	je     be83 <fwp_read_exact+0x4f3>
    baa8:	4c 89 fb             	mov    %r15,%rbx
    baab:	4c 29 eb             	sub    %r13,%rbx
    baae:	0f 86 e0 03 00 00    	jbe    be94 <fwp_read_exact+0x504>
    bab4:	4b 8d 04 2e          	lea    (%r14,%r13,1),%rax
    bab8:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    babd:	8b 05 11 f3 02 00    	mov    0x2f311(%rip),%eax        # 3add4 <fwp_pi_kind>
    bac3:	83 f8 01             	cmp    $0x1,%eax
    bac6:	0f 84 64 02 00 00    	je     bd30 <fwp_read_exact+0x3a0>
    bacc:	83 f8 02             	cmp    $0x2,%eax
    bacf:	75 af                	jne    ba80 <fwp_read_exact+0xf0>
    bad1:	4c 8b 3d 00 f3 02 00 	mov    0x2f300(%rip),%r15        # 3add8 <fwp_pi_ring>
    bad8:	4d 8b 77 40          	mov    0x40(%r15),%r14
    badc:	49 8b 87 80 00 00 00 	mov    0x80(%r15),%rax
    bae3:	49 39 c6             	cmp    %rax,%r14
    bae6:	0f 85 94 02 00 00    	jne    bd80 <fwp_read_exact+0x3f0>
    baec:	49 8d 87 c0 00 00 00 	lea    0xc0(%r15),%rax
    baf3:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    baf8:	eb 25                	jmp    bb1f <fwp_read_exact+0x18f>
    bafa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    bb00:	41 c7 87 c4 00 00 00 	movl   $0x0,0xc4(%r15)
    bb07:	00 00 00 00 
    bb0b:	4d 8b 77 40          	mov    0x40(%r15),%r14
    bb0f:	49 8b 87 80 00 00 00 	mov    0x80(%r15),%rax
    bb16:	49 39 c6             	cmp    %rax,%r14
    bb19:	0f 85 61 02 00 00    	jne    bd80 <fwp_read_exact+0x3f0>
    bb1f:	41 8b 87 40 01 00 00 	mov    0x140(%r15),%eax
    bb26:	85 c0                	test   %eax,%eax
    bb28:	74 11                	je     bb3b <fwp_read_exact+0x1ab>
    bb2a:	49 8b 47 40          	mov    0x40(%r15),%rax
    bb2e:	49 3b 87 80 00 00 00 	cmp    0x80(%r15),%rax
    bb35:	0f 84 48 03 00 00    	je     be83 <fwp_read_exact+0x4f3>
    bb3b:	44 8b 25 8a f1 00 00 	mov    0xf18a(%rip),%r12d        # 1accc <fwp_pi_sock>
    bb42:	8b 0d 80 f1 00 00    	mov    0xf180(%rip),%ecx        # 1acc8 <fwp_ring_spin>
    bb48:	85 c9                	test   %ecx,%ecx
    bb4a:	78 14                	js     bb60 <fwp_read_exact+0x1d0>
    bb4c:	85 c9                	test   %ecx,%ecx
    bb4e:	75 31                	jne    bb81 <fwp_read_exact+0x1f1>
    bb50:	e9 3b 01 00 00       	jmp    bc90 <fwp_read_exact+0x300>
    bb55:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    bb5c:	00 00 00 00 
    bb60:	bf 54 00 00 00       	mov    $0x54,%edi
    bb65:	e8 b6 78 ff ff       	call   3420 <sysconf@plt>
    bb6a:	31 c9                	xor    %ecx,%ecx
    bb6c:	48 83 f8 02          	cmp    $0x2,%rax
    bb70:	0f 9d c1             	setge  %cl
    bb73:	89 0d 4f f1 00 00    	mov    %ecx,0xf14f(%rip)        # 1acc8 <fwp_ring_spin>
    bb79:	85 c9                	test   %ecx,%ecx
    bb7b:	0f 84 0f 01 00 00    	je     bc90 <fwp_read_exact+0x300>
    bb81:	49 8b 47 40          	mov    0x40(%r15),%rax
    bb85:	49 3b 87 80 00 00 00 	cmp    0x80(%r15),%rax
    bb8c:	0f 85 79 ff ff ff    	jne    bb0b <fwp_read_exact+0x17b>
    bb92:	41 8b 87 40 01 00 00 	mov    0x140(%r15),%eax
    bb99:	85 c0                	test   %eax,%eax
    bb9b:	0f 85 6a ff ff ff    	jne    bb0b <fwp_read_exact+0x17b>
    bba1:	bd 01 00 00 00       	mov    $0x1,%ebp
    bba6:	45 31 f6             	xor    %r14d,%r14d
    bba9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    bbb0:	f3 90                	pause
    bbb2:	40 f6 c5 3f          	test   $0x3f,%bpl
    bbb6:	75 48                	jne    bc00 <fwp_read_exact+0x270>
    bbb8:	e8 93 76 ff ff       	call   3250 <sched_yield@plt>
    bbbd:	bf 01 00 00 00       	mov    $0x1,%edi
    bbc2:	48 8d 74 24 18       	lea    0x18(%rsp),%rsi
    bbc7:	e8 64 75 ff ff       	call   3130 <clock_gettime@plt>
    bbcc:	48 69 44 24 18 00 ca 	imul   $0x3b9aca00,0x18(%rsp),%rax
    bbd3:	9a 3b 
    bbd5:	48 03 44 24 20       	add    0x20(%rsp),%rax
    bbda:	4d 85 f6             	test   %r14,%r14
    bbdd:	74 0a                	je     bbe9 <fwp_read_exact+0x259>
    bbdf:	4c 39 f0             	cmp    %r14,%rax
    bbe2:	7e 1c                	jle    bc00 <fwp_read_exact+0x270>
    bbe4:	e9 a7 00 00 00       	jmp    bc90 <fwp_read_exact+0x300>
    bbe9:	48 05 50 c3 00 00    	add    $0xc350,%rax
    bbef:	49 89 c6             	mov    %rax,%r14
    bbf2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    bbf9:	1f 84 00 00 00 00 00 
    bc00:	49 8b 47 40          	mov    0x40(%r15),%rax
    bc04:	49 3b 87 80 00 00 00 	cmp    0x80(%r15),%rax
    bc0b:	0f 85 fa fe ff ff    	jne    bb0b <fwp_read_exact+0x17b>
    bc11:	ff c5                	inc    %ebp
    bc13:	41 8b 87 40 01 00 00 	mov    0x140(%r15),%eax
    bc1a:	85 c0                	test   %eax,%eax
    bc1c:	74 92                	je     bbb0 <fwp_read_exact+0x220>
    bc1e:	e9 e8 fe ff ff       	jmp    bb0b <fwp_read_exact+0x17b>
    bc23:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    bc2a:	84 00 00 00 00 00 
    bc30:	48 85 c0             	test   %rax,%rax
    bc33:	74 5b                	je     bc90 <fwp_read_exact+0x300>
    bc35:	e8 46 74 ff ff       	call   3080 <__errno_location@plt>
    bc3a:	83 38 6e             	cmpl   $0x6e,(%rax)
    bc3d:	75 51                	jne    bc90 <fwp_read_exact+0x300>
    bc3f:	44 89 64 24 18       	mov    %r12d,0x18(%rsp)
    bc44:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%rsp)
    bc4b:	00 
    bc4c:	be 01 00 00 00       	mov    $0x1,%esi
    bc51:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    bc56:	31 d2                	xor    %edx,%edx
    bc58:	e8 63 77 ff ff       	call   33c0 <poll@plt>
    bc5d:	85 c0                	test   %eax,%eax
    bc5f:	7e 2f                	jle    bc90 <fwp_read_exact+0x300>
    bc61:	f6 44 24 1e 18       	testb  $0x18,0x1e(%rsp)
    bc66:	0f 85 17 02 00 00    	jne    be83 <fwp_read_exact+0x4f3>
    bc6c:	ba 01 00 00 00       	mov    $0x1,%edx
    bc71:	44 89 e7             	mov    %r12d,%edi
    bc74:	48 8d 74 24 17       	lea    0x17(%rsp),%rsi
    bc79:	b9 42 00 00 00       	mov    $0x42,%ecx
    bc7e:	e8 dd 73 ff ff       	call   3060 <recv@plt>
    bc83:	48 85 c0             	test   %rax,%rax
    bc86:	0f 84 f7 01 00 00    	je     be83 <fwp_read_exact+0x4f3>
    bc8c:	0f 1f 40 00          	nopl   0x0(%rax)
    bc90:	41 8b 8f c0 00 00 00 	mov    0xc0(%r15),%ecx
    bc97:	b8 01 00 00 00       	mov    $0x1,%eax
    bc9c:	41 87 87 c4 00 00 00 	xchg   %eax,0xc4(%r15)
    bca3:	0f ae f0             	mfence
    bca6:	49 8b 47 40          	mov    0x40(%r15),%rax
    bcaa:	49 3b 87 80 00 00 00 	cmp    0x80(%r15),%rax
    bcb1:	0f 85 49 fe ff ff    	jne    bb00 <fwp_read_exact+0x170>
    bcb7:	41 8b 87 40 01 00 00 	mov    0x140(%r15),%eax
    bcbe:	85 c0                	test   %eax,%eax
    bcc0:	0f 85 3a fe ff ff    	jne    bb00 <fwp_read_exact+0x170>
    bcc6:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
    bccd:	00 00 
    bccf:	48 c7 44 24 20 00 e1 	movq   $0x5f5e100,0x20(%rsp)
    bcd6:	f5 05 
    bcd8:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    bcdf:	bf ca 00 00 00       	mov    $0xca,%edi
    bce4:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
    bce9:	31 d2                	xor    %edx,%edx
    bceb:	4c 8d 44 24 18       	lea    0x18(%rsp),%r8
    bcf0:	45 31 c9             	xor    %r9d,%r9d
    bcf3:	31 c0                	xor    %eax,%eax
    bcf5:	e8 06 76 ff ff       	call   3300 <syscall@plt>
    bcfa:	41 c7 87 c4 00 00 00 	movl   $0x0,0xc4(%r15)
    bd01:	00 00 00 00 
    bd05:	49 8b 4f 40          	mov    0x40(%r15),%rcx
    bd09:	49 3b 8f 80 00 00 00 	cmp    0x80(%r15),%rcx
    bd10:	0f 85 f5 fd ff ff    	jne    bb0b <fwp_read_exact+0x17b>
    bd16:	41 8b 8f 40 01 00 00 	mov    0x140(%r15),%ecx
    bd1d:	85 c9                	test   %ecx,%ecx
    bd1f:	0f 84 0b ff ff ff    	je     bc30 <fwp_read_exact+0x2a0>
    bd25:	e9 e1 fd ff ff       	jmp    bb0b <fwp_read_exact+0x17b>
    bd2a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    bd30:	4c 8b 35 a9 f0 02 00 	mov    0x2f0a9(%rip),%r14        # 3ade0 <fwp_pi_pos>
    bd37:	48 8b 05 aa f0 02 00 	mov    0x2f0aa(%rip),%rax        # 3ade8 <fwp_pi_len>
    bd3e:	49 39 c6             	cmp    %rax,%r14
    bd41:	0f 85 00 01 00 00    	jne    be47 <fwp_read_exact+0x4b7>
    bd47:	4c 8d 35 a2 f0 02 00 	lea    0x2f0a2(%rip),%r14        # 3adf0 <fwp_pi_buf>
    bd4e:	66 90                	xchg   %ax,%ax
    bd50:	8b 3d 76 ef 00 00    	mov    0xef76(%rip),%edi        # 1accc <fwp_pi_sock>
    bd56:	ba 00 00 01 00       	mov    $0x10000,%edx
    bd5b:	4c 89 f6             	mov    %r14,%rsi
    bd5e:	31 c9                	xor    %ecx,%ecx
    bd60:	e8 fb 72 ff ff       	call   3060 <recv@plt>
    bd65:	48 85 c0             	test   %rax,%rax
    bd68:	0f 89 cd 00 00 00    	jns    be3b <fwp_read_exact+0x4ab>
    bd6e:	e8 0d 73 ff ff       	call   3080 <__errno_location@plt>
    bd73:	83 38 04             	cmpl   $0x4,(%rax)
    bd76:	74 d8                	je     bd50 <fwp_read_exact+0x3c0>
    bd78:	e9 06 01 00 00       	jmp    be83 <fwp_read_exact+0x4f3>
    bd7d:	0f 1f 00             	nopl   (%rax)
    bd80:	49 29 c6             	sub    %rax,%r14
    bd83:	49 39 de             	cmp    %rbx,%r14
    bd86:	4c 0f 43 f3          	cmovae %rbx,%r14
    bd8a:	49 8b 5f 08          	mov    0x8(%r15),%rbx
    bd8e:	48 8d 4b ff          	lea    -0x1(%rbx),%rcx
    bd92:	48 21 c1             	and    %rax,%rcx
    bd95:	48 29 cb             	sub    %rcx,%rbx
    bd98:	49 39 de             	cmp    %rbx,%r14
    bd9b:	49 0f 42 de          	cmovb  %r14,%rbx
    bd9f:	4d 8d a7 00 10 00 00 	lea    0x1000(%r15),%r12
    bda6:	49 8d 34 0f          	lea    (%r15,%rcx,1),%rsi
    bdaa:	48 81 c6 00 10 00 00 	add    $0x1000,%rsi
    bdb1:	48 8b 6c 24 30       	mov    0x30(%rsp),%rbp
    bdb6:	48 89 ef             	mov    %rbp,%rdi
    bdb9:	48 89 da             	mov    %rbx,%rdx
    bdbc:	e8 6f 75 ff ff       	call   3330 <memcpy@plt>
    bdc1:	48 01 dd             	add    %rbx,%rbp
    bdc4:	4c 89 f2             	mov    %r14,%rdx
    bdc7:	48 29 da             	sub    %rbx,%rdx
    bdca:	48 89 ef             	mov    %rbp,%rdi
    bdcd:	4c 89 e6             	mov    %r12,%rsi
    bdd0:	e8 5b 75 ff ff       	call   3330 <memcpy@plt>
    bdd5:	49 8b 8f 80 00 00 00 	mov    0x80(%r15),%rcx
    bddc:	4c 01 f1             	add    %r14,%rcx
    bddf:	49 89 8f 80 00 00 00 	mov    %rcx,0x80(%r15)
    bde6:	0f ae f0             	mfence
    bde9:	41 8b 8f 04 01 00 00 	mov    0x104(%r15),%ecx
    bdf0:	85 c9                	test   %ecx,%ecx
    bdf2:	74 35                	je     be29 <fwp_read_exact+0x499>
    bdf4:	f0 41 ff 87 00 01 00 	lock incl 0x100(%r15)
    bdfb:	00 
    bdfc:	49 81 c7 00 01 00 00 	add    $0x100,%r15
    be03:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    be0a:	bf ca 00 00 00       	mov    $0xca,%edi
    be0f:	4c 89 fe             	mov    %r15,%rsi
    be12:	ba 01 00 00 00       	mov    $0x1,%edx
    be17:	b9 ff ff ff 7f       	mov    $0x7fffffff,%ecx
    be1c:	45 31 c0             	xor    %r8d,%r8d
    be1f:	45 31 c9             	xor    %r9d,%r9d
    be22:	31 c0                	xor    %eax,%eax
    be24:	e8 d7 74 ff ff       	call   3300 <syscall@plt>
    be29:	4c 89 f0             	mov    %r14,%rax
    be2c:	4c 8b 7c 24 38       	mov    0x38(%rsp),%r15
    be31:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    be36:	e9 61 fc ff ff       	jmp    ba9c <fwp_read_exact+0x10c>
    be3b:	74 46                	je     be83 <fwp_read_exact+0x4f3>
    be3d:	48 89 05 a4 ef 02 00 	mov    %rax,0x2efa4(%rip)        # 3ade8 <fwp_pi_len>
    be44:	45 31 f6             	xor    %r14d,%r14d
    be47:	4c 29 f0             	sub    %r14,%rax
    be4a:	48 39 d8             	cmp    %rbx,%rax
    be4d:	48 0f 43 c3          	cmovae %rbx,%rax
    be51:	48 8d 0d 98 ef 02 00 	lea    0x2ef98(%rip),%rcx        # 3adf0 <fwp_pi_buf>
    be58:	4a 8d 34 31          	lea    (%rcx,%r14,1),%rsi
    be5c:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    be61:	48 89 c2             	mov    %rax,%rdx
    be64:	48 89 c3             	mov    %rax,%rbx
    be67:	e8 c4 74 ff ff       	call   3330 <memcpy@plt>
    be6c:	48 89 d8             	mov    %rbx,%rax
    be6f:	49 01 de             	add    %rbx,%r14
    be72:	4c 89 35 67 ef 02 00 	mov    %r14,0x2ef67(%rip)        # 3ade0 <fwp_pi_pos>
    be79:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    be7e:	e9 19 fc ff ff       	jmp    ba9c <fwp_read_exact+0x10c>
    be83:	31 c0                	xor    %eax,%eax
    be85:	48 83 c4 48          	add    $0x48,%rsp
    be89:	5b                   	pop    %rbx
    be8a:	41 5c                	pop    %r12
    be8c:	41 5d                	pop    %r13
    be8e:	41 5e                	pop    %r14
    be90:	41 5f                	pop    %r15
    be92:	5d                   	pop    %rbp
    be93:	c3                   	ret
    be94:	b8 01 00 00 00       	mov    $0x1,%eax
    be99:	eb ea                	jmp    be85 <fwp_read_exact+0x4f5>
    be9b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000bea0 <fwp_stdin_name_len>:
    bea0:	41 57                	push   %r15
    bea2:	41 56                	push   %r14
    bea4:	53                   	push   %rbx
    bea5:	48 83 ec 10          	sub    $0x10,%rsp
    bea9:	48 89 fb             	mov    %rdi,%rbx
    beac:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    beb3:	49 c7 c6 f9 ff ff ff 	mov    $0xfffffffffffffff9,%r14
    beba:	4c 8d 7c 24 0f       	lea    0xf(%rsp),%r15
    bebf:	90                   	nop
    bec0:	be 01 00 00 00       	mov    $0x1,%esi
    bec5:	4c 89 ff             	mov    %r15,%rdi
    bec8:	e8 c3 fa ff ff       	call   b990 <fwp_read_exact>
    becd:	85 c0                	test   %eax,%eax
    becf:	74 38                	je     bf09 <fwp_stdin_name_len+0x69>
    bed1:	0f b6 44 24 0f       	movzbl 0xf(%rsp),%eax
    bed6:	49 83 fe 38          	cmp    $0x38,%r14
    beda:	75 07                	jne    bee3 <fwp_stdin_name_len+0x43>
    bedc:	89 c1                	mov    %eax,%ecx
    bede:	80 e1 7e             	and    $0x7e,%cl
    bee1:	75 1f                	jne    bf02 <fwp_stdin_name_len+0x62>
    bee3:	49 83 c6 07          	add    $0x7,%r14
    bee7:	89 c2                	mov    %eax,%edx
    bee9:	83 e2 7f             	and    $0x7f,%edx
    beec:	44 89 f1             	mov    %r14d,%ecx
    beef:	48 d3 e2             	shl    %cl,%rdx
    bef2:	48 0b 13             	or     (%rbx),%rdx
    bef5:	48 89 13             	mov    %rdx,(%rbx)
    bef8:	84 c0                	test   %al,%al
    befa:	79 11                	jns    bf0d <fwp_stdin_name_len+0x6d>
    befc:	49 83 fe 38          	cmp    $0x38,%r14
    bf00:	76 be                	jbe    bec0 <fwp_stdin_name_len+0x20>
    bf02:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    bf07:	eb 13                	jmp    bf1c <fwp_stdin_name_len+0x7c>
    bf09:	31 c0                	xor    %eax,%eax
    bf0b:	eb 0f                	jmp    bf1c <fwp_stdin_name_len+0x7c>
    bf0d:	31 c0                	xor    %eax,%eax
    bf0f:	48 81 fa 01 00 10 00 	cmp    $0x100001,%rdx
    bf16:	83 d0 ff             	adc    $0xffffffff,%eax
    bf19:	83 c8 01             	or     $0x1,%eax
    bf1c:	48 83 c4 10          	add    $0x10,%rsp
    bf20:	5b                   	pop    %rbx
    bf21:	41 5e                	pop    %r14
    bf23:	41 5f                	pop    %r15
    bf25:	c3                   	ret
    bf26:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    bf2d:	00 00 00 

000000000000bf30 <fwp_pipe_in_offer>:
    bf30:	55                   	push   %rbp
    bf31:	41 56                	push   %r14
    bf33:	53                   	push   %rbx
    bf34:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
    bf3b:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
    bf42:	00 
    bf43:	31 ff                	xor    %edi,%edi
    bf45:	e8 76 75 ff ff       	call   34c0 <fstat@plt>
    bf4a:	85 c0                	test   %eax,%eax
    bf4c:	0f 85 29 01 00 00    	jne    c07b <fwp_pipe_in_offer+0x14b>
    bf52:	b8 00 f0 00 00       	mov    $0xf000,%eax
    bf57:	23 84 24 98 00 00 00 	and    0x98(%rsp),%eax
    bf5e:	3d 00 10 00 00       	cmp    $0x1000,%eax
    bf63:	0f 85 12 01 00 00    	jne    c07b <fwp_pipe_in_offer+0x14b>
    bf69:	bf 01 00 00 00       	mov    $0x1,%edi
    bf6e:	be 01 00 08 00       	mov    $0x80001,%esi
    bf73:	31 d2                	xor    %edx,%edx
    bf75:	e8 76 75 ff ff       	call   34f0 <socket@plt>
    bf7a:	85 c0                	test   %eax,%eax
    bf7c:	0f 88 f9 00 00 00    	js     c07b <fwp_pipe_in_offer+0x14b>
    bf82:	89 c3                	mov    %eax,%ebx
    bf84:	0f 57 c0             	xorps  %xmm0,%xmm0
    bf87:	0f 11 44 24 70       	movups %xmm0,0x70(%rsp)
    bf8c:	0f 11 44 24 64       	movups %xmm0,0x64(%rsp)
    bf91:	0f 11 44 24 54       	movups %xmm0,0x54(%rsp)
    bf96:	0f 11 44 24 44       	movups %xmm0,0x44(%rsp)
    bf9b:	0f 11 44 24 34       	movups %xmm0,0x34(%rsp)
    bfa0:	0f 11 44 24 24       	movups %xmm0,0x24(%rsp)
    bfa5:	0f 11 44 24 14       	movups %xmm0,0x14(%rsp)
    bfaa:	66 c7 44 24 12 01 00 	movw   $0x1,0x12(%rsp)
    bfb1:	48 8d 7c 24 15       	lea    0x15(%rsp),%rdi
    bfb6:	48 8b 8c 24 80 00 00 	mov    0x80(%rsp),%rcx
    bfbd:	00 
    bfbe:	4c 8b 84 24 88 00 00 	mov    0x88(%rsp),%r8
    bfc5:	00 
    bfc6:	48 8d 15 f3 96 00 00 	lea    0x96f3(%rip),%rdx        # 156c0 <exec_in_fp0+0xeb0>
    bfcd:	be 6b 00 00 00       	mov    $0x6b,%esi
    bfd2:	31 c0                	xor    %eax,%eax
    bfd4:	e8 f7 71 ff ff       	call   31d0 <snprintf@plt>
    bfd9:	89 c5                	mov    %eax,%ebp
    bfdb:	83 c5 03             	add    $0x3,%ebp
    bfde:	48 8d 3d c7 96 00 00 	lea    0x96c7(%rip),%rdi        # 156ac <exec_in_fp0+0xe9c>
    bfe5:	e8 46 70 ff ff       	call   3030 <getenv@plt>
    bfea:	48 85 c0             	test   %rax,%rax
    bfed:	74 36                	je     c025 <fwp_pipe_in_offer+0xf5>
    bfef:	49 89 c6             	mov    %rax,%r14
    bff2:	48 8d 35 c1 96 00 00 	lea    0x96c1(%rip),%rsi        # 156ba <exec_in_fp0+0xeaa>
    bff9:	48 89 c7             	mov    %rax,%rdi
    bffc:	e8 cf 72 ff ff       	call   32d0 <strcmp@plt>
    c001:	c7 44 24 0c 46 57 50 	movl   $0x54505746,0xc(%rsp)
    c008:	54 
    c009:	85 c0                	test   %eax,%eax
    c00b:	74 27                	je     c034 <fwp_pipe_in_offer+0x104>
    c00d:	48 8d 35 6b 97 00 00 	lea    0x976b(%rip),%rsi        # 1577f <exec_in_fp0+0xf6f>
    c014:	4c 89 f7             	mov    %r14,%rdi
    c017:	e8 b4 72 ff ff       	call   32d0 <strcmp@plt>
    c01c:	83 f8 01             	cmp    $0x1,%eax
    c01f:	b0 02                	mov    $0x2,%al
    c021:	1c 00                	sbb    $0x0,%al
    c023:	eb 0a                	jmp    c02f <fwp_pipe_in_offer+0xff>
    c025:	c7 44 24 0c 46 57 50 	movl   $0x54505746,0xc(%rsp)
    c02c:	54 
    c02d:	b0 02                	mov    $0x2,%al
    c02f:	45 31 f6             	xor    %r14d,%r14d
    c032:	eb 05                	jmp    c039 <fwp_pipe_in_offer+0x109>
    c034:	31 c0                	xor    %eax,%eax
    c036:	41 b6 01             	mov    $0x1,%r14b
    c039:	88 44 24 10          	mov    %al,0x10(%rsp)
    c03d:	48 8d 74 24 12       	lea    0x12(%rsp),%rsi
    c042:	89 df                	mov    %ebx,%edi
    c044:	89 ea                	mov    %ebp,%edx
    c046:	e8 25 74 ff ff       	call   3470 <connect@plt>
    c04b:	85 c0                	test   %eax,%eax
    c04d:	75 25                	jne    c074 <fwp_pipe_in_offer+0x144>
    c04f:	48 8d 74 24 0c       	lea    0xc(%rsp),%rsi
    c054:	ba 05 00 00 00       	mov    $0x5,%edx
    c059:	89 df                	mov    %ebx,%edi
    c05b:	b9 00 40 00 00       	mov    $0x4000,%ecx
    c060:	e8 3b 71 ff ff       	call   31a0 <send@plt>
    c065:	48 83 f8 05          	cmp    $0x5,%rax
    c069:	0f 94 c0             	sete   %al
    c06c:	41 f6 d6             	not    %r14b
    c06f:	41 84 c6             	test   %al,%r14b
    c072:	75 13                	jne    c087 <fwp_pipe_in_offer+0x157>
    c074:	89 df                	mov    %ebx,%edi
    c076:	e8 b5 71 ff ff       	call   3230 <close@plt>
    c07b:	48 81 c4 10 01 00 00 	add    $0x110,%rsp
    c082:	5b                   	pop    %rbx
    c083:	41 5e                	pop    %r14
    c085:	5d                   	pop    %rbp
    c086:	c3                   	ret
    c087:	89 1d 3f ec 00 00    	mov    %ebx,0xec3f(%rip)        # 1accc <fwp_pi_sock>
    c08d:	eb ec                	jmp    c07b <fwp_pipe_in_offer+0x14b>
    c08f:	90                   	nop

000000000000c090 <fwp_decode>:
    c090:	55                   	push   %rbp
    c091:	41 57                	push   %r15
    c093:	41 56                	push   %r14
    c095:	41 55                	push   %r13
    c097:	41 54                	push   %r12
    c099:	53                   	push   %rbx
    c09a:	48 83 ec 38          	sub    $0x38,%rsp
    c09e:	8b 06                	mov    (%rsi),%eax
    c0a0:	45 31 e4             	xor    %r12d,%r12d
    c0a3:	48 83 f8 15          	cmp    $0x15,%rax
    c0a7:	0f 87 f3 00 00 00    	ja     c1a0 <fwp_decode+0x110>
    c0ad:	48 89 d5             	mov    %rdx,%rbp
    c0b0:	49 89 f7             	mov    %rsi,%r15
    c0b3:	49 89 fe             	mov    %rdi,%r14
    c0b6:	48 8d 0d 23 81 00 00 	lea    0x8123(%rip),%rcx        # 141e0 <_IO_stdin_used+0x1e0>
    c0bd:	48 63 14 81          	movslq (%rcx,%rax,4),%rdx
    c0c1:	48 01 ca             	add    %rcx,%rdx
    c0c4:	ff e2                	jmp    *%rdx
    c0c6:	31 c9                	xor    %ecx,%ecx
    c0c8:	83 f8 0a             	cmp    $0xa,%eax
    c0cb:	0f 95 c1             	setne  %cl
    c0ce:	4c 8d 04 8d 04 00 00 	lea    0x4(,%rcx,4),%r8
    c0d5:	00 
    c0d6:	49 8b 46 08          	mov    0x8(%r14),%rax
    c0da:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    c0de:	48 29 f8             	sub    %rdi,%rax
    c0e1:	4c 39 c0             	cmp    %r8,%rax
    c0e4:	0f 82 b6 00 00 00    	jb     c1a0 <fwp_decode+0x110>
    c0ea:	49 8b 16             	mov    (%r14),%rdx
    c0ed:	4a 8d 04 07          	lea    (%rdi,%r8,1),%rax
    c0f1:	49 89 46 10          	mov    %rax,0x10(%r14)
    c0f5:	44 89 c6             	mov    %r8d,%esi
    c0f8:	83 e6 03             	and    $0x3,%esi
    c0fb:	49 83 f8 04          	cmp    $0x4,%r8
    c0ff:	73 08                	jae    c109 <fwp_decode+0x79>
    c101:	45 31 d2             	xor    %r10d,%r10d
    c104:	45 31 c9             	xor    %r9d,%r9d
    c107:	eb 5e                	jmp    c167 <fwp_decode+0xd7>
    c109:	41 83 e0 fc          	and    $0xfffffffc,%r8d
    c10d:	4c 8d 1c 17          	lea    (%rdi,%rdx,1),%r11
    c111:	49 83 c3 03          	add    $0x3,%r11
    c115:	b8 18 00 00 00       	mov    $0x18,%eax
    c11a:	45 31 d2             	xor    %r10d,%r10d
    c11d:	45 31 c9             	xor    %r9d,%r9d
    c120:	43 0f b6 5c 13 fd    	movzbl -0x3(%r11,%r10,1),%ebx
    c126:	8d 48 e8             	lea    -0x18(%rax),%ecx
    c129:	48 d3 e3             	shl    %cl,%rbx
    c12c:	47 0f b6 74 13 fe    	movzbl -0x2(%r11,%r10,1),%r14d
    c132:	8d 48 f0             	lea    -0x10(%rax),%ecx
    c135:	49 d3 e6             	shl    %cl,%r14
    c138:	47 0f b6 7c 13 ff    	movzbl -0x1(%r11,%r10,1),%r15d
    c13e:	8d 48 f8             	lea    -0x8(%rax),%ecx
    c141:	49 d3 e7             	shl    %cl,%r15
    c144:	4c 09 cb             	or     %r9,%rbx
    c147:	4d 09 f7             	or     %r14,%r15
    c14a:	49 09 df             	or     %rbx,%r15
    c14d:	47 0f b6 0c 13       	movzbl (%r11,%r10,1),%r9d
    c152:	89 c1                	mov    %eax,%ecx
    c154:	49 d3 e1             	shl    %cl,%r9
    c157:	4d 09 f9             	or     %r15,%r9
    c15a:	49 83 c2 04          	add    $0x4,%r10
    c15e:	48 83 c0 20          	add    $0x20,%rax
    c162:	4d 39 d0             	cmp    %r10,%r8
    c165:	75 b9                	jne    c120 <fwp_decode+0x90>
    c167:	48 85 f6             	test   %rsi,%rsi
    c16a:	74 2a                	je     c196 <fwp_decode+0x106>
    c16c:	4a 8d 0c d5 00 00 00 	lea    0x0(,%r10,8),%rcx
    c173:	00 
    c174:	4c 01 d7             	add    %r10,%rdi
    c177:	48 01 fa             	add    %rdi,%rdx
    c17a:	31 c0                	xor    %eax,%eax
    c17c:	0f 1f 40 00          	nopl   0x0(%rax)
    c180:	0f b6 3c 02          	movzbl (%rdx,%rax,1),%edi
    c184:	48 d3 e7             	shl    %cl,%rdi
    c187:	49 09 f9             	or     %rdi,%r9
    c18a:	48 ff c0             	inc    %rax
    c18d:	48 83 c1 08          	add    $0x8,%rcx
    c191:	48 39 c6             	cmp    %rax,%rsi
    c194:	75 ea                	jne    c180 <fwp_decode+0xf0>
    c196:	4c 89 4d 00          	mov    %r9,0x0(%rbp)
    c19a:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    c1a0:	44 89 e0             	mov    %r12d,%eax
    c1a3:	48 83 c4 38          	add    $0x38,%rsp
    c1a7:	5b                   	pop    %rbx
    c1a8:	41 5c                	pop    %r12
    c1aa:	41 5d                	pop    %r13
    c1ac:	41 5e                	pop    %r14
    c1ae:	41 5f                	pop    %r15
    c1b0:	5d                   	pop    %rbp
    c1b1:	c3                   	ret
    c1b2:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    c1b7:	4c 89 f7             	mov    %r14,%rdi
    c1ba:	e8 81 69 00 00       	call   12b40 <rd_leb>
    c1bf:	85 c0                	test   %eax,%eax
    c1c1:	74 dd                	je     c1a0 <fwp_decode+0x110>
    c1c3:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
    c1c8:	49 8b 4e 08          	mov    0x8(%r14),%rcx
    c1cc:	49 39 cd             	cmp    %rcx,%r13
    c1cf:	77 cf                	ja     c1a0 <fwp_decode+0x110>
    c1d1:	49 8b 46 10          	mov    0x10(%r14),%rax
    c1d5:	48 29 c1             	sub    %rax,%rcx
    c1d8:	4c 39 e9             	cmp    %r13,%rcx
    c1db:	72 c3                	jb     c1a0 <fwp_decode+0x110>
    c1dd:	48 89 eb             	mov    %rbp,%rbx
    c1e0:	49 8b 2e             	mov    (%r14),%rbp
    c1e3:	48 01 c5             	add    %rax,%rbp
    c1e6:	4c 01 e8             	add    %r13,%rax
    c1e9:	49 89 46 10          	mov    %rax,0x10(%r14)
    c1ed:	41 83 3f 0c          	cmpl   $0xc,(%r15)
    c1f1:	75 0f                	jne    c202 <fwp_decode+0x172>
    c1f3:	48 89 ef             	mov    %rbp,%rdi
    c1f6:	4c 89 ee             	mov    %r13,%rsi
    c1f9:	e8 d2 08 00 00       	call   cad0 <fwp_valid_utf8>
    c1fe:	85 c0                	test   %eax,%eax
    c200:	74 9e                	je     c1a0 <fwp_decode+0x110>
    c202:	48 89 ef             	mov    %rbp,%rdi
    c205:	4c 89 ee             	mov    %r13,%rsi
    c208:	e8 23 0a 00 00       	call   cc30 <fwp_str_new>
    c20d:	48 89 03             	mov    %rax,(%rbx)
    c210:	eb 88                	jmp    c19a <fwp_decode+0x10a>
    c212:	49 8b 46 10          	mov    0x10(%r14),%rax
    c216:	49 39 46 08          	cmp    %rax,0x8(%r14)
    c21a:	74 84                	je     c1a0 <fwp_decode+0x110>
    c21c:	49 8b 0e             	mov    (%r14),%rcx
    c21f:	48 8d 50 01          	lea    0x1(%rax),%rdx
    c223:	49 89 56 10          	mov    %rdx,0x10(%r14)
    c227:	48 0f be 04 01       	movsbq (%rcx,%rax,1),%rax
    c22c:	48 89 45 00          	mov    %rax,0x0(%rbp)
    c230:	e9 65 ff ff ff       	jmp    c19a <fwp_decode+0x10a>
    c235:	49 8b 76 08          	mov    0x8(%r14),%rsi
    c239:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    c23d:	48 89 f2             	mov    %rsi,%rdx
    c240:	48 29 ca             	sub    %rcx,%rdx
    c243:	48 83 fa 08          	cmp    $0x8,%rdx
    c247:	0f 82 53 ff ff ff    	jb     c1a0 <fwp_decode+0x110>
    c24d:	49 8b 16             	mov    (%r14),%rdx
    c250:	48 8d 79 08          	lea    0x8(%rcx),%rdi
    c254:	49 89 7e 10          	mov    %rdi,0x10(%r14)
    c258:	48 29 fe             	sub    %rdi,%rsi
    c25b:	48 83 fe 08          	cmp    $0x8,%rsi
    c25f:	0f 82 3b ff ff ff    	jb     c1a0 <fwp_decode+0x110>
    c265:	48 8b 3c 0a          	mov    (%rdx,%rcx,1),%rdi
    c269:	48 8d 71 10          	lea    0x10(%rcx),%rsi
    c26d:	49 89 76 10          	mov    %rsi,0x10(%r14)
    c271:	48 8b 74 0a 08       	mov    0x8(%rdx,%rcx,1),%rsi
    c276:	83 f8 04             	cmp    $0x4,%eax
    c279:	0f 85 e7 03 00 00    	jne    c666 <fwp_decode+0x5d6>
    c27f:	e8 dc 3b 00 00       	call   fe60 <fwp_box_i128>
    c284:	48 89 45 00          	mov    %rax,0x0(%rbp)
    c288:	e9 0d ff ff ff       	jmp    c19a <fwp_decode+0x10a>
    c28d:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    c292:	49 8b 6f 38          	mov    0x38(%r15),%rbp
    c296:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    c29b:	4c 89 f7             	mov    %r14,%rdi
    c29e:	e8 9d 68 00 00       	call   12b40 <rd_leb>
    c2a3:	85 c0                	test   %eax,%eax
    c2a5:	0f 84 f5 fe ff ff    	je     c1a0 <fwp_decode+0x110>
    c2ab:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
    c2b0:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    c2b7:	ff ff 1f 
    c2ba:	49 39 c5             	cmp    %rax,%r13
    c2bd:	0f 87 dd fe ff ff    	ja     c1a0 <fwp_decode+0x110>
    c2c3:	45 31 e4             	xor    %r12d,%r12d
    c2c6:	48 89 ef             	mov    %rbp,%rdi
    c2c9:	31 f6                	xor    %esi,%esi
    c2cb:	e8 50 6a 00 00       	call   12d20 <fwp_wire_empty_inner>
    c2d0:	85 c0                	test   %eax,%eax
    c2d2:	75 0a                	jne    c2de <fwp_decode+0x24e>
    c2d4:	4d 3b 6e 08          	cmp    0x8(%r14),%r13
    c2d8:	0f 87 c2 fe ff ff    	ja     c1a0 <fwp_decode+0x110>
    c2de:	41 83 3f 11          	cmpl   $0x11,(%r15)
    c2e2:	0f 85 fe 02 00 00    	jne    c5e6 <fwp_decode+0x556>
    c2e8:	49 8b 77 38          	mov    0x38(%r15),%rsi
    c2ec:	4c 89 ef             	mov    %r13,%rdi
    c2ef:	e8 dc 91 ff ff       	call   54d0 <fwp_array_new_packed>
    c2f4:	49 89 c4             	mov    %rax,%r12
    c2f7:	4d 85 ed             	test   %r13,%r13
    c2fa:	0f 84 2e 04 00 00    	je     c72e <fwp_decode+0x69e>
    c300:	31 ed                	xor    %ebp,%ebp
    c302:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    c307:	eb 11                	jmp    c31a <fwp_decode+0x28a>
    c309:	49 89 44 ec 08       	mov    %rax,0x8(%r12,%rbp,8)
    c30e:	48 ff c5             	inc    %rbp
    c311:	49 39 ed             	cmp    %rbp,%r13
    c314:	0f 84 14 04 00 00    	je     c72e <fwp_decode+0x69e>
    c31a:	49 8b 77 38          	mov    0x38(%r15),%rsi
    c31e:	4c 89 f7             	mov    %r14,%rdi
    c321:	48 89 da             	mov    %rbx,%rdx
    c324:	e8 67 fd ff ff       	call   c090 <fwp_decode>
    c329:	85 c0                	test   %eax,%eax
    c32b:	0f 84 f2 05 00 00    	je     c923 <fwp_decode+0x893>
    c331:	49 83 3c 24 00       	cmpq   $0x0,(%r12)
    c336:	0f 88 ef 05 00 00    	js     c92b <fwp_decode+0x89b>
    c33c:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    c341:	49 8b 4f 38          	mov    0x38(%r15),%rcx
    c345:	48 85 c9             	test   %rcx,%rcx
    c348:	74 bf                	je     c309 <fwp_decode+0x279>
    c34a:	8b 09                	mov    (%rcx),%ecx
    c34c:	83 f9 0a             	cmp    $0xa,%ecx
    c34f:	77 b8                	ja     c309 <fwp_decode+0x279>
    c351:	ba 84 04 00 00       	mov    $0x484,%edx
    c356:	0f a3 ca             	bt     %ecx,%edx
    c359:	72 1c                	jb     c377 <fwp_decode+0x2e7>
    c35b:	ba 21 00 00 00       	mov    $0x21,%edx
    c360:	0f a3 ca             	bt     %ecx,%edx
    c363:	72 19                	jb     c37e <fwp_decode+0x2ee>
    c365:	ba 42 00 00 00       	mov    $0x42,%edx
    c36a:	0f a3 ca             	bt     %ecx,%edx
    c36d:	73 9a                	jae    c309 <fwp_decode+0x279>
    c36f:	66 41 89 44 6c 08    	mov    %ax,0x8(%r12,%rbp,2)
    c375:	eb 97                	jmp    c30e <fwp_decode+0x27e>
    c377:	41 89 44 ac 08       	mov    %eax,0x8(%r12,%rbp,4)
    c37c:	eb 90                	jmp    c30e <fwp_decode+0x27e>
    c37e:	41 88 44 2c 08       	mov    %al,0x8(%r12,%rbp,1)
    c383:	eb 89                	jmp    c30e <fwp_decode+0x27e>
    c385:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    c38a:	4c 89 f7             	mov    %r14,%rdi
    c38d:	e8 ae 67 00 00       	call   12b40 <rd_leb>
    c392:	85 c0                	test   %eax,%eax
    c394:	0f 84 06 fe ff ff    	je     c1a0 <fwp_decode+0x110>
    c39a:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    c39f:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
    c3a4:	49 63 47 10          	movslq 0x10(%r15),%rax
    c3a8:	49 39 c5             	cmp    %rax,%r13
    c3ab:	0f 83 ef fd ff ff    	jae    c1a0 <fwp_decode+0x110>
    c3b1:	49 8b 47 28          	mov    0x28(%r15),%rax
    c3b5:	4a 63 1c a8          	movslq (%rax,%r13,4),%rbx
    c3b9:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    c3c0:	00 
    c3c1:	e8 aa b8 ff ff       	call   7c70 <fwp_alloc>
    c3c6:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    c3cb:	89 d8                	mov    %ebx,%eax
    c3cd:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    c3d2:	48 85 db             	test   %rbx,%rbx
    c3d5:	7e 40                	jle    c417 <fwp_decode+0x387>
    c3d7:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    c3dc:	48 8d 1c c5 00 00 00 	lea    0x0(,%rax,8),%rbx
    c3e3:	00 
    c3e4:	45 31 e4             	xor    %r12d,%r12d
    c3e7:	31 ed                	xor    %ebp,%ebp
    c3e9:	49 8b 47 30          	mov    0x30(%r15),%rax
    c3ed:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    c3f1:	48 8b 34 28          	mov    (%rax,%rbp,1),%rsi
    c3f5:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    c3fa:	48 8d 14 28          	lea    (%rax,%rbp,1),%rdx
    c3fe:	4c 89 f7             	mov    %r14,%rdi
    c401:	e8 8a fc ff ff       	call   c090 <fwp_decode>
    c406:	85 c0                	test   %eax,%eax
    c408:	0f 84 92 fd ff ff    	je     c1a0 <fwp_decode+0x110>
    c40e:	48 83 c5 08          	add    $0x8,%rbp
    c412:	48 39 eb             	cmp    %rbp,%rbx
    c415:	75 d2                	jne    c3e9 <fwp_decode+0x359>
    c417:	44 89 ef             	mov    %r13d,%edi
    c41a:	48 8b 74 24 28       	mov    0x28(%rsp),%rsi
    c41f:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
    c424:	e8 27 0d 00 00       	call   d150 <fwp_data>
    c429:	e9 e8 04 00 00       	jmp    c916 <fwp_decode+0x886>
    c42e:	41 b8 01 00 00 00    	mov    $0x1,%r8d
    c434:	e9 9d fc ff ff       	jmp    c0d6 <fwp_decode+0x46>
    c439:	41 b8 02 00 00 00    	mov    $0x2,%r8d
    c43f:	e9 92 fc ff ff       	jmp    c0d6 <fwp_decode+0x46>
    c444:	49 8b 4e 08          	mov    0x8(%r14),%rcx
    c448:	49 8b 46 10          	mov    0x10(%r14),%rax
    c44c:	48 29 c1             	sub    %rax,%rcx
    c44f:	48 83 f9 02          	cmp    $0x2,%rcx
    c453:	0f 82 47 fd ff ff    	jb     c1a0 <fwp_decode+0x110>
    c459:	49 8b 0e             	mov    (%r14),%rcx
    c45c:	48 8d 50 02          	lea    0x2(%rax),%rdx
    c460:	49 89 56 10          	mov    %rdx,0x10(%r14)
    c464:	0f b6 14 01          	movzbl (%rcx,%rax,1),%edx
    c468:	0f b6 44 01 01       	movzbl 0x1(%rcx,%rax,1),%eax
    c46d:	48 c1 e0 38          	shl    $0x38,%rax
    c471:	48 c1 e2 30          	shl    $0x30,%rdx
    c475:	48 09 c2             	or     %rax,%rdx
    c478:	48 c1 fa 30          	sar    $0x30,%rdx
    c47c:	48 89 55 00          	mov    %rdx,0x0(%rbp)
    c480:	e9 15 fd ff ff       	jmp    c19a <fwp_decode+0x10a>
    c485:	49 8b 4e 08          	mov    0x8(%r14),%rcx
    c489:	49 8b 46 10          	mov    0x10(%r14),%rax
    c48d:	48 29 c1             	sub    %rax,%rcx
    c490:	48 83 f9 04          	cmp    $0x4,%rcx
    c494:	0f 82 06 fd ff ff    	jb     c1a0 <fwp_decode+0x110>
    c49a:	49 8b 0e             	mov    (%r14),%rcx
    c49d:	48 8d 50 04          	lea    0x4(%rax),%rdx
    c4a1:	49 89 56 10          	mov    %rdx,0x10(%r14)
    c4a5:	0f b6 14 01          	movzbl (%rcx,%rax,1),%edx
    c4a9:	0f b6 74 01 01       	movzbl 0x1(%rcx,%rax,1),%esi
    c4ae:	0f b6 7c 01 02       	movzbl 0x2(%rcx,%rax,1),%edi
    c4b3:	0f b6 44 01 03       	movzbl 0x3(%rcx,%rax,1),%eax
    c4b8:	48 c1 e0 38          	shl    $0x38,%rax
    c4bc:	48 c1 e7 30          	shl    $0x30,%rdi
    c4c0:	48 c1 e6 28          	shl    $0x28,%rsi
    c4c4:	48 c1 e2 20          	shl    $0x20,%rdx
    c4c8:	48 09 f2             	or     %rsi,%rdx
    c4cb:	48 09 fa             	or     %rdi,%rdx
    c4ce:	48 09 c2             	or     %rax,%rdx
    c4d1:	48 c1 fa 20          	sar    $0x20,%rdx
    c4d5:	48 89 55 00          	mov    %rdx,0x0(%rbp)
    c4d9:	e9 bc fc ff ff       	jmp    c19a <fwp_decode+0x10a>
    c4de:	41 b8 04 00 00 00    	mov    $0x4,%r8d
    c4e4:	e9 ed fb ff ff       	jmp    c0d6 <fwp_decode+0x46>
    c4e9:	49 8b 7f 40          	mov    0x40(%r15),%rdi
    c4ed:	31 f6                	xor    %esi,%esi
    c4ef:	e8 2c 68 00 00       	call   12d20 <fwp_wire_empty_inner>
    c4f4:	85 c0                	test   %eax,%eax
    c4f6:	0f 95 c3             	setne  %bl
    c4f9:	eb 02                	jmp    c4fd <fwp_decode+0x46d>
    c4fb:	b3 01                	mov    $0x1,%bl
    c4fd:	4d 8b 6f 38          	mov    0x38(%r15),%r13
    c501:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    c506:	4c 89 f7             	mov    %r14,%rdi
    c509:	e8 32 66 00 00       	call   12b40 <rd_leb>
    c50e:	85 c0                	test   %eax,%eax
    c510:	0f 84 8a fc ff ff    	je     c1a0 <fwp_decode+0x110>
    c516:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    c51b:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
    c520:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    c527:	ff ff 1f 
    c52a:	48 39 c5             	cmp    %rax,%rbp
    c52d:	0f 87 6d fc ff ff    	ja     c1a0 <fwp_decode+0x110>
    c533:	45 31 e4             	xor    %r12d,%r12d
    c536:	4c 89 ef             	mov    %r13,%rdi
    c539:	31 f6                	xor    %esi,%esi
    c53b:	e8 e0 67 00 00       	call   12d20 <fwp_wire_empty_inner>
    c540:	85 c0                	test   %eax,%eax
    c542:	0f 84 2c 01 00 00    	je     c674 <fwp_decode+0x5e4>
    c548:	48 83 fd 02          	cmp    $0x2,%rbp
    c54c:	0f 93 c0             	setae  %al
    c54f:	84 d8                	test   %bl,%al
    c551:	0f 85 49 fc ff ff    	jne    c1a0 <fwp_decode+0x110>
    c557:	e9 22 01 00 00       	jmp    c67e <fwp_decode+0x5ee>
    c55c:	49 63 7f 10          	movslq 0x10(%r15),%rdi
    c560:	48 85 ff             	test   %rdi,%rdi
    c563:	74 74                	je     c5d9 <fwp_decode+0x549>
    c565:	48 c1 e7 03          	shl    $0x3,%rdi
    c569:	48 ff 05 b8 e7 00 00 	incq   0xe7b8(%rip)        # 1ad28 <measured_calls>
    c570:	48 01 3d b9 e7 00 00 	add    %rdi,0xe7b9(%rip)        # 1ad30 <measured_bytes>
    c577:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    c57e:	0f 87 9b 01 00 00    	ja     c71f <fwp_decode+0x68f>
    c584:	48 8d 4f 0f          	lea    0xf(%rdi),%rcx
    c588:	48 c1 e9 04          	shr    $0x4,%rcx
    c58c:	48 8d 05 f5 cc 00 00 	lea    0xccf5(%rip),%rax        # 19288 <fwp_gc>
    c593:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    c59a:	00 
    c59b:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    c5a2:	48 29 15 df cc 00 00 	sub    %rdx,0xccdf(%rip)        # 19288 <fwp_gc>
    c5a9:	0f 88 70 01 00 00    	js     c71f <fwp_decode+0x68f>
    c5af:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    c5b3:	48 8d 34 c8          	lea    (%rax,%rcx,8),%rsi
    c5b7:	48 81 c6 88 07 00 00 	add    $0x788,%rsi
    c5be:	4c 8b 2e             	mov    (%rsi),%r13
    c5c1:	4d 85 ed             	test   %r13,%r13
    c5c4:	0f 84 3d 01 00 00    	je     c707 <fwp_decode+0x677>
    c5ca:	49 8b 45 00          	mov    0x0(%r13),%rax
    c5ce:	48 f7 d0             	not    %rax
    c5d1:	48 89 06             	mov    %rax,(%rsi)
    c5d4:	e9 80 01 00 00       	jmp    c759 <fwp_decode+0x6c9>
    c5d9:	48 c7 45 00 00 00 00 	movq   $0x0,0x0(%rbp)
    c5e0:	00 
    c5e1:	e9 b4 fb ff ff       	jmp    c19a <fwp_decode+0x10a>
    c5e6:	4a 8d 3c ed 08 00 00 	lea    0x8(,%r13,8),%rdi
    c5ed:	00 
    c5ee:	48 ff 05 33 e7 00 00 	incq   0xe733(%rip)        # 1ad28 <measured_calls>
    c5f5:	48 01 3d 34 e7 00 00 	add    %rdi,0xe734(%rip)        # 1ad30 <measured_bytes>
    c5fc:	49 81 fd ff 07 00 00 	cmp    $0x7ff,%r13
    c603:	0f 87 6c 02 00 00    	ja     c875 <fwp_decode+0x7e5>
    c609:	4a 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%rcx
    c610:	00 
    c611:	48 83 c1 17          	add    $0x17,%rcx
    c615:	48 c1 e9 04          	shr    $0x4,%rcx
    c619:	48 8d 05 68 cc 00 00 	lea    0xcc68(%rip),%rax        # 19288 <fwp_gc>
    c620:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    c627:	00 
    c628:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    c62f:	48 29 15 52 cc 00 00 	sub    %rdx,0xcc52(%rip)        # 19288 <fwp_gc>
    c636:	0f 88 39 02 00 00    	js     c875 <fwp_decode+0x7e5>
    c63c:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    c640:	48 8d 34 c8          	lea    (%rax,%rcx,8),%rsi
    c644:	48 81 c6 88 07 00 00 	add    $0x788,%rsi
    c64b:	4c 8b 26             	mov    (%rsi),%r12
    c64e:	4d 85 e4             	test   %r12,%r12
    c651:	0f 84 06 02 00 00    	je     c85d <fwp_decode+0x7cd>
    c657:	49 8b 04 24          	mov    (%r12),%rax
    c65b:	48 f7 d0             	not    %rax
    c65e:	48 89 06             	mov    %rax,(%rsi)
    c661:	e9 74 02 00 00       	jmp    c8da <fwp_decode+0x84a>
    c666:	e8 45 37 00 00       	call   fdb0 <fwp_box_u128>
    c66b:	48 89 45 00          	mov    %rax,0x0(%rbp)
    c66f:	e9 26 fb ff ff       	jmp    c19a <fwp_decode+0x10a>
    c674:	49 3b 6e 08          	cmp    0x8(%r14),%rbp
    c678:	0f 87 22 fb ff ff    	ja     c1a0 <fwp_decode+0x110>
    c67e:	84 db                	test   %bl,%bl
    c680:	75 0a                	jne    c68c <fwp_decode+0x5fc>
    c682:	49 3b 6e 08          	cmp    0x8(%r14),%rbp
    c686:	0f 87 14 fb ff ff    	ja     c1a0 <fwp_decode+0x110>
    c68c:	4c 8d 25 fd e6 01 00 	lea    0x1e6fd(%rip),%r12        # 2ad90 <fwp_empty_map>
    c693:	48 85 ed             	test   %rbp,%rbp
    c696:	0f 84 9f 00 00 00    	je     c73b <fwp_decode+0x6ab>
    c69c:	4c 8d 6c 24 20       	lea    0x20(%rsp),%r13
    c6a1:	48 8d 5c 24 30       	lea    0x30(%rsp),%rbx
    c6a6:	eb 1b                	jmp    c6c3 <fwp_decode+0x633>
    c6a8:	31 f6                	xor    %esi,%esi
    c6aa:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    c6af:	49 8b 4f 38          	mov    0x38(%r15),%rcx
    c6b3:	4c 89 e2             	mov    %r12,%rdx
    c6b6:	e8 35 33 00 00       	call   f9f0 <fwp_p_map_insert>
    c6bb:	49 89 c4             	mov    %rax,%r12
    c6be:	48 ff cd             	dec    %rbp
    c6c1:	74 78                	je     c73b <fwp_decode+0x6ab>
    c6c3:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
    c6ca:	00 00 
    c6cc:	49 8b 77 38          	mov    0x38(%r15),%rsi
    c6d0:	4c 89 f7             	mov    %r14,%rdi
    c6d3:	4c 89 ea             	mov    %r13,%rdx
    c6d6:	e8 b5 f9 ff ff       	call   c090 <fwp_decode>
    c6db:	85 c0                	test   %eax,%eax
    c6dd:	0f 84 40 02 00 00    	je     c923 <fwp_decode+0x893>
    c6e3:	41 83 3f 12          	cmpl   $0x12,(%r15)
    c6e7:	75 bf                	jne    c6a8 <fwp_decode+0x618>
    c6e9:	49 8b 77 40          	mov    0x40(%r15),%rsi
    c6ed:	4c 89 f7             	mov    %r14,%rdi
    c6f0:	48 89 da             	mov    %rbx,%rdx
    c6f3:	e8 98 f9 ff ff       	call   c090 <fwp_decode>
    c6f8:	85 c0                	test   %eax,%eax
    c6fa:	0f 84 23 02 00 00    	je     c923 <fwp_decode+0x893>
    c700:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    c705:	eb a3                	jmp    c6aa <fwp_decode+0x61a>
    c707:	4c 8b ac c8 90 07 00 	mov    0x790(%rax,%rcx,8),%r13
    c70e:	00 
    c70f:	48 8b b4 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%rsi
    c716:	00 
    c717:	4c 29 ee             	sub    %r13,%rsi
    c71a:	48 39 d6             	cmp    %rdx,%rsi
    c71d:	73 29                	jae    c748 <fwp_decode+0x6b8>
    c71f:	be 02 00 00 00       	mov    $0x2,%esi
    c724:	e8 f7 b5 ff ff       	call   7d20 <fwp_gc_alloc_slow>
    c729:	49 89 c5             	mov    %rax,%r13
    c72c:	eb 35                	jmp    c763 <fwp_decode+0x6d3>
    c72e:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    c733:	4c 89 20             	mov    %r12,(%rax)
    c736:	e9 5f fa ff ff       	jmp    c19a <fwp_decode+0x10a>
    c73b:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    c740:	4c 89 20             	mov    %r12,(%rax)
    c743:	e9 52 fa ff ff       	jmp    c19a <fwp_decode+0x10a>
    c748:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    c74c:	48 05 90 07 00 00    	add    $0x790,%rax
    c752:	4a 8d 0c 2a          	lea    (%rdx,%r13,1),%rcx
    c756:	48 89 08             	mov    %rcx,(%rax)
    c759:	4c 89 ef             	mov    %r13,%rdi
    c75c:	31 f6                	xor    %esi,%esi
    c75e:	e8 ad 6a ff ff       	call   3210 <memset@plt>
    c763:	41 8b 5f 10          	mov    0x10(%r15),%ebx
    c767:	85 db                	test   %ebx,%ebx
    c769:	7e 4a                	jle    c7b5 <fwp_decode+0x725>
    c76b:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    c770:	45 31 e4             	xor    %r12d,%r12d
    c773:	4c 89 6c 24 18       	mov    %r13,0x18(%rsp)
    c778:	4c 89 ed             	mov    %r13,%rbp
    c77b:	45 31 ed             	xor    %r13d,%r13d
    c77e:	66 90                	xchg   %ax,%ax
    c780:	49 8b 47 20          	mov    0x20(%r15),%rax
    c784:	4a 8b 34 e8          	mov    (%rax,%r13,8),%rsi
    c788:	4c 89 f7             	mov    %r14,%rdi
    c78b:	48 89 ea             	mov    %rbp,%rdx
    c78e:	e8 fd f8 ff ff       	call   c090 <fwp_decode>
    c793:	85 c0                	test   %eax,%eax
    c795:	0f 84 05 fa ff ff    	je     c1a0 <fwp_decode+0x110>
    c79b:	49 ff c5             	inc    %r13
    c79e:	49 63 5f 10          	movslq 0x10(%r15),%rbx
    c7a2:	48 83 c5 08          	add    $0x8,%rbp
    c7a6:	49 39 dd             	cmp    %rbx,%r13
    c7a9:	7c d5                	jl     c780 <fwp_decode+0x6f0>
    c7ab:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    c7b0:	4c 8b 6c 24 18       	mov    0x18(%rsp),%r13
    c7b5:	85 db                	test   %ebx,%ebx
    c7b7:	0f 84 95 00 00 00    	je     c852 <fwp_decode+0x7c2>
    c7bd:	41 89 de             	mov    %ebx,%r14d
    c7c0:	4a 8d 3c f5 08 00 00 	lea    0x8(,%r14,8),%rdi
    c7c7:	00 
    c7c8:	e8 73 da ff ff       	call   a240 <fwp_alloc_init>
    c7cd:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    c7d3:	89 58 04             	mov    %ebx,0x4(%rax)
    c7d6:	83 fb 08             	cmp    $0x8,%ebx
    c7d9:	72 14                	jb     c7ef <fwp_decode+0x75f>
    c7db:	48 89 c1             	mov    %rax,%rcx
    c7de:	4c 29 e9             	sub    %r13,%rcx
    c7e1:	48 83 c1 08          	add    $0x8,%rcx
    c7e5:	48 83 f9 20          	cmp    $0x20,%rcx
    c7e9:	0f 83 95 00 00 00    	jae    c884 <fwp_decode+0x7f4>
    c7ef:	31 c9                	xor    %ecx,%ecx
    c7f1:	4c 89 f6             	mov    %r14,%rsi
    c7f4:	48 89 ca             	mov    %rcx,%rdx
    c7f7:	48 83 e6 03          	and    $0x3,%rsi
    c7fb:	74 15                	je     c812 <fwp_decode+0x782>
    c7fd:	48 89 ca             	mov    %rcx,%rdx
    c800:	49 8b 7c d5 00       	mov    0x0(%r13,%rdx,8),%rdi
    c805:	48 89 7c d0 08       	mov    %rdi,0x8(%rax,%rdx,8)
    c80a:	48 ff c2             	inc    %rdx
    c80d:	48 ff ce             	dec    %rsi
    c810:	75 ee                	jne    c800 <fwp_decode+0x770>
    c812:	4c 29 f1             	sub    %r14,%rcx
    c815:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    c819:	0f 87 a1 00 00 00    	ja     c8c0 <fwp_decode+0x830>
    c81f:	49 8b 4c d5 00       	mov    0x0(%r13,%rdx,8),%rcx
    c824:	48 89 4c d0 08       	mov    %rcx,0x8(%rax,%rdx,8)
    c829:	49 8b 4c d5 08       	mov    0x8(%r13,%rdx,8),%rcx
    c82e:	48 89 4c d0 10       	mov    %rcx,0x10(%rax,%rdx,8)
    c833:	49 8b 4c d5 10       	mov    0x10(%r13,%rdx,8),%rcx
    c838:	48 89 4c d0 18       	mov    %rcx,0x18(%rax,%rdx,8)
    c83d:	49 8b 4c d5 18       	mov    0x18(%r13,%rdx,8),%rcx
    c842:	48 89 4c d0 20       	mov    %rcx,0x20(%rax,%rdx,8)
    c847:	48 83 c2 04          	add    $0x4,%rdx
    c84b:	49 39 d6             	cmp    %rdx,%r14
    c84e:	75 cf                	jne    c81f <fwp_decode+0x78f>
    c850:	eb 6e                	jmp    c8c0 <fwp_decode+0x830>
    c852:	31 c0                	xor    %eax,%eax
    c854:	48 89 45 00          	mov    %rax,0x0(%rbp)
    c858:	e9 3d f9 ff ff       	jmp    c19a <fwp_decode+0x10a>
    c85d:	4c 8b a4 c8 90 07 00 	mov    0x790(%rax,%rcx,8),%r12
    c864:	00 
    c865:	48 8b b4 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%rsi
    c86c:	00 
    c86d:	4c 29 e6             	sub    %r12,%rsi
    c870:	48 39 d6             	cmp    %rdx,%rsi
    c873:	73 54                	jae    c8c9 <fwp_decode+0x839>
    c875:	be 02 00 00 00       	mov    $0x2,%esi
    c87a:	e8 a1 b4 ff ff       	call   7d20 <fwp_gc_alloc_slow>
    c87f:	49 89 c4             	mov    %rax,%r12
    c882:	eb 60                	jmp    c8e4 <fwp_decode+0x854>
    c884:	44 89 f1             	mov    %r14d,%ecx
    c887:	83 e1 fc             	and    $0xfffffffc,%ecx
    c88a:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
    c891:	00 
    c892:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    c896:	31 f6                	xor    %esi,%esi
    c898:	41 0f 10 44 35 00    	movups 0x0(%r13,%rsi,1),%xmm0
    c89e:	41 0f 10 4c 35 10    	movups 0x10(%r13,%rsi,1),%xmm1
    c8a4:	0f 11 44 30 08       	movups %xmm0,0x8(%rax,%rsi,1)
    c8a9:	0f 11 4c 30 18       	movups %xmm1,0x18(%rax,%rsi,1)
    c8ae:	48 83 c6 20          	add    $0x20,%rsi
    c8b2:	48 39 f2             	cmp    %rsi,%rdx
    c8b5:	75 e1                	jne    c898 <fwp_decode+0x808>
    c8b7:	4c 39 f1             	cmp    %r14,%rcx
    c8ba:	0f 85 31 ff ff ff    	jne    c7f1 <fwp_decode+0x761>
    c8c0:	48 89 45 00          	mov    %rax,0x0(%rbp)
    c8c4:	e9 d1 f8 ff ff       	jmp    c19a <fwp_decode+0x10a>
    c8c9:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    c8cd:	48 05 90 07 00 00    	add    $0x790,%rax
    c8d3:	49 8d 0c 14          	lea    (%r12,%rdx,1),%rcx
    c8d7:	48 89 08             	mov    %rcx,(%rax)
    c8da:	4c 89 e7             	mov    %r12,%rdi
    c8dd:	31 f6                	xor    %esi,%esi
    c8df:	e8 2c 69 ff ff       	call   3210 <memset@plt>
    c8e4:	4d 85 ed             	test   %r13,%r13
    c8e7:	74 22                	je     c90b <fwp_decode+0x87b>
    c8e9:	4c 89 e5             	mov    %r12,%rbp
    c8ec:	4c 89 eb             	mov    %r13,%rbx
    c8ef:	49 8b 77 38          	mov    0x38(%r15),%rsi
    c8f3:	4c 89 f7             	mov    %r14,%rdi
    c8f6:	48 89 ea             	mov    %rbp,%rdx
    c8f9:	e8 92 f7 ff ff       	call   c090 <fwp_decode>
    c8fe:	85 c0                	test   %eax,%eax
    c900:	74 21                	je     c923 <fwp_decode+0x893>
    c902:	48 83 c5 08          	add    $0x8,%rbp
    c906:	48 ff cb             	dec    %rbx
    c909:	75 e4                	jne    c8ef <fwp_decode+0x85f>
    c90b:	4c 89 e7             	mov    %r12,%rdi
    c90e:	4c 89 ee             	mov    %r13,%rsi
    c911:	e8 4a 00 00 00       	call   c960 <fwp_list_from>
    c916:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    c91b:	48 89 01             	mov    %rax,(%rcx)
    c91e:	e9 77 f8 ff ff       	jmp    c19a <fwp_decode+0x10a>
    c923:	45 31 e4             	xor    %r12d,%r12d
    c926:	e9 75 f8 ff ff       	jmp    c1a0 <fwp_decode+0x110>
    c92b:	e8 10 9d ff ff       	call   6640 <fwp_flush>
    c930:	48 8b 05 a1 c6 00 00 	mov    0xc6a1(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    c937:	48 8b 38             	mov    (%rax),%rdi
    c93a:	48 8d 35 0d 81 00 00 	lea    0x810d(%rip),%rsi        # 14a4e <exec_in_fp0+0x23e>
    c941:	48 8d 15 36 90 00 00 	lea    0x9036(%rip),%rdx        # 1597e <exec_in_fp0+0x116e>
    c948:	31 c0                	xor    %eax,%eax
    c94a:	e8 a1 69 ff ff       	call   32f0 <fprintf@plt>
    c94f:	bf 65 00 00 00       	mov    $0x65,%edi
    c954:	e8 07 6b ff ff       	call   3460 <exit@plt>
    c959:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000c960 <fwp_list_from>:
    c960:	55                   	push   %rbp
    c961:	41 57                	push   %r15
    c963:	41 56                	push   %r14
    c965:	41 55                	push   %r13
    c967:	41 54                	push   %r12
    c969:	53                   	push   %rbx
    c96a:	48 83 ec 18          	sub    $0x18,%rsp
    c96e:	48 89 fb             	mov    %rdi,%rbx
    c971:	48 85 f6             	test   %rsi,%rsi
    c974:	0f 84 41 01 00 00    	je     cabb <fwp_list_from+0x15b>
    c97a:	49 89 f6             	mov    %rsi,%r14
    c97d:	45 31 ff             	xor    %r15d,%r15d
    c980:	4c 8d 2d 01 c9 00 00 	lea    0xc901(%rip),%r13        # 19288 <fwp_gc>
    c987:	eb 3d                	jmp    c9c6 <fwp_list_from+0x66>
    c989:	bf 18 00 00 00       	mov    $0x18,%edi
    c98e:	31 f6                	xor    %esi,%esi
    c990:	e8 8b b3 ff ff       	call   7d20 <fwp_gc_alloc_slow>
    c995:	49 89 c7             	mov    %rax,%r15
    c998:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c99f:	00 
    c9a0:	48 b8 01 00 00 00 02 	movabs $0x200000001,%rax
    c9a7:	00 00 00 
    c9aa:	49 89 07             	mov    %rax,(%r15)
    c9ad:	49 89 6f 08          	mov    %rbp,0x8(%r15)
    c9b1:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    c9b6:	49 89 47 10          	mov    %rax,0x10(%r15)
    c9ba:	48 89 e0             	mov    %rsp,%rax
    c9bd:	49 ff ce             	dec    %r14
    c9c0:	0f 84 f8 00 00 00    	je     cabe <fwp_list_from+0x15e>
    c9c6:	4a 8b 6c f3 f8       	mov    -0x8(%rbx,%r14,8),%rbp
    c9cb:	48 89 2c 24          	mov    %rbp,(%rsp)
    c9cf:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
    c9d4:	48 ff 05 4d e3 00 00 	incq   0xe34d(%rip)        # 1ad28 <measured_calls>
    c9db:	48 83 05 4d e3 00 00 	addq   $0x18,0xe34d(%rip)        # 1ad30 <measured_bytes>
    c9e2:	18 
    c9e3:	0f b6 05 88 d4 00 00 	movzbl 0xd488(%rip),%eax        # 19e72 <fwp_gc+0xbea>
    c9ea:	41 8b 94 85 48 0b 00 	mov    0xb48(%r13,%rax,4),%edx
    c9f1:	00 
    c9f2:	48 8b 0d 8f c8 00 00 	mov    0xc88f(%rip),%rcx        # 19288 <fwp_gc>
    c9f9:	48 29 d1             	sub    %rdx,%rcx
    c9fc:	48 89 0d 85 c8 00 00 	mov    %rcx,0xc885(%rip)        # 19288 <fwp_gc>
    ca03:	78 84                	js     c989 <fwp_list_from+0x29>
    ca05:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
    ca09:	48 8d 34 c5 08 00 00 	lea    0x8(,%rax,8),%rsi
    ca10:	00 
    ca11:	4c 01 ee             	add    %r13,%rsi
    ca14:	4c 8b 3e             	mov    (%rsi),%r15
    ca17:	4d 85 ff             	test   %r15,%r15
    ca1a:	74 34                	je     ca50 <fwp_list_from+0xf0>
    ca1c:	49 8b 07             	mov    (%r15),%rax
    ca1f:	48 f7 d0             	not    %rax
    ca22:	48 89 06             	mov    %rax,(%rsi)
    ca25:	83 fa 19             	cmp    $0x19,%edx
    ca28:	0f 82 72 ff ff ff    	jb     c9a0 <fwp_list_from+0x40>
    ca2e:	49 8d 7f 18          	lea    0x18(%r15),%rdi
    ca32:	48 83 c2 e7          	add    $0xffffffffffffffe7,%rdx
    ca36:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    ca3a:	48 83 c2 08          	add    $0x8,%rdx
    ca3e:	31 f6                	xor    %esi,%esi
    ca40:	e8 cb 67 ff ff       	call   3210 <memset@plt>
    ca45:	e9 56 ff ff ff       	jmp    c9a0 <fwp_list_from+0x40>
    ca4a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    ca50:	4d 8b 7c c5 10       	mov    0x10(%r13,%rax,8),%r15
    ca55:	49 8b 74 c5 18       	mov    0x18(%r13,%rax,8),%rsi
    ca5a:	48 89 f7             	mov    %rsi,%rdi
    ca5d:	4c 29 ff             	sub    %r15,%rdi
    ca60:	48 39 d7             	cmp    %rdx,%rdi
    ca63:	73 0e                	jae    ca73 <fwp_list_from+0x113>
    ca65:	4d 89 fc             	mov    %r15,%r12
    ca68:	48 39 d7             	cmp    %rdx,%rdi
    ca6b:	0f 82 18 ff ff ff    	jb     c989 <fwp_list_from+0x29>
    ca71:	eb 2d                	jmp    caa0 <fwp_list_from+0x140>
    ca73:	48 8d 3c c5 10 00 00 	lea    0x10(,%rax,8),%rdi
    ca7a:	00 
    ca7b:	4c 01 ef             	add    %r13,%rdi
    ca7e:	4d 8d 24 17          	lea    (%r15,%rdx,1),%r12
    ca82:	4c 89 27             	mov    %r12,(%rdi)
    ca85:	4d 85 ff             	test   %r15,%r15
    ca88:	75 9b                	jne    ca25 <fwp_list_from+0xc5>
    ca8a:	48 89 0d f7 c7 00 00 	mov    %rcx,0xc7f7(%rip)        # 19288 <fwp_gc>
    ca91:	4c 29 e6             	sub    %r12,%rsi
    ca94:	48 89 f7             	mov    %rsi,%rdi
    ca97:	48 39 d7             	cmp    %rdx,%rdi
    ca9a:	0f 82 e9 fe ff ff    	jb     c989 <fwp_list_from+0x29>
    caa0:	49 8d 0c 14          	lea    (%r12,%rdx,1),%rcx
    caa4:	49 89 4c c5 10       	mov    %rcx,0x10(%r13,%rax,8)
    caa9:	4c 89 e7             	mov    %r12,%rdi
    caac:	31 f6                	xor    %esi,%esi
    caae:	e8 5d 67 ff ff       	call   3210 <memset@plt>
    cab3:	4d 89 e7             	mov    %r12,%r15
    cab6:	e9 e5 fe ff ff       	jmp    c9a0 <fwp_list_from+0x40>
    cabb:	45 31 ff             	xor    %r15d,%r15d
    cabe:	4c 89 f8             	mov    %r15,%rax
    cac1:	48 83 c4 18          	add    $0x18,%rsp
    cac5:	5b                   	pop    %rbx
    cac6:	41 5c                	pop    %r12
    cac8:	41 5d                	pop    %r13
    caca:	41 5e                	pop    %r14
    cacc:	41 5f                	pop    %r15
    cace:	5d                   	pop    %rbp
    cacf:	c3                   	ret

000000000000cad0 <fwp_valid_utf8>:
    cad0:	48 85 f6             	test   %rsi,%rsi
    cad3:	0f 84 48 01 00 00    	je     cc21 <fwp_valid_utf8+0x151>
    cad9:	53                   	push   %rbx
    cada:	31 c9                	xor    %ecx,%ecx
    cadc:	eb 0e                	jmp    caec <fwp_valid_utf8+0x1c>
    cade:	66 90                	xchg   %ax,%ax
    cae0:	48 ff c1             	inc    %rcx
    cae3:	48 39 f1             	cmp    %rsi,%rcx
    cae6:	0f 83 2e 01 00 00    	jae    cc1a <fwp_valid_utf8+0x14a>
    caec:	44 0f b6 14 0f       	movzbl (%rdi,%rcx,1),%r10d
    caf1:	45 84 d2             	test   %r10b,%r10b
    caf4:	79 ea                	jns    cae0 <fwp_valid_utf8+0x10>
    caf6:	41 8d 42 3e          	lea    0x3e(%r10),%eax
    cafa:	3c 1e                	cmp    $0x1e,%al
    cafc:	73 12                	jae    cb10 <fwp_valid_utf8+0x40>
    cafe:	ba 80 00 00 00       	mov    $0x80,%edx
    cb03:	b8 01 00 00 00       	mov    $0x1,%eax
    cb08:	41 b8 1f 00 00 00    	mov    $0x1f,%r8d
    cb0e:	eb 37                	jmp    cb47 <fwp_valid_utf8+0x77>
    cb10:	44 89 d0             	mov    %r10d,%eax
    cb13:	24 f0                	and    $0xf0,%al
    cb15:	3c e0                	cmp    $0xe0,%al
    cb17:	75 12                	jne    cb2b <fwp_valid_utf8+0x5b>
    cb19:	ba 00 08 00 00       	mov    $0x800,%edx
    cb1e:	b8 02 00 00 00       	mov    $0x2,%eax
    cb23:	41 b8 0f 00 00 00    	mov    $0xf,%r8d
    cb29:	eb 1c                	jmp    cb47 <fwp_valid_utf8+0x77>
    cb2b:	41 8d 42 10          	lea    0x10(%r10),%eax
    cb2f:	3c 04                	cmp    $0x4,%al
    cb31:	0f 87 f0 00 00 00    	ja     cc27 <fwp_valid_utf8+0x157>
    cb37:	ba 00 00 01 00       	mov    $0x10000,%edx
    cb3c:	b8 03 00 00 00       	mov    $0x3,%eax
    cb41:	41 b8 07 00 00 00    	mov    $0x7,%r8d
    cb47:	41 89 c1             	mov    %eax,%r9d
    cb4a:	4e 8d 1c 09          	lea    (%rcx,%r9,1),%r11
    cb4e:	31 c0                	xor    %eax,%eax
    cb50:	49 39 f3             	cmp    %rsi,%r11
    cb53:	0f 83 c6 00 00 00    	jae    cc1f <fwp_valid_utf8+0x14f>
    cb59:	44 0f b6 5c 0f 01    	movzbl 0x1(%rdi,%rcx,1),%r11d
    cb5f:	44 89 db             	mov    %r11d,%ebx
    cb62:	83 e3 c0             	and    $0xffffffc0,%ebx
    cb65:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
    cb6b:	0f 85 ae 00 00 00    	jne    cc1f <fwp_valid_utf8+0x14f>
    cb71:	45 21 d0             	and    %r10d,%r8d
    cb74:	45 8d 51 01          	lea    0x1(%r9),%r10d
    cb78:	44 89 c3             	mov    %r8d,%ebx
    cb7b:	c1 e3 06             	shl    $0x6,%ebx
    cb7e:	41 83 e3 3f          	and    $0x3f,%r11d
    cb82:	41 09 db             	or     %ebx,%r11d
    cb85:	41 83 fa 02          	cmp    $0x2,%r10d
    cb89:	75 0d                	jne    cb98 <fwp_valid_utf8+0xc8>
    cb8b:	45 89 da             	mov    %r11d,%r10d
    cb8e:	41 39 d2             	cmp    %edx,%r10d
    cb91:	73 62                	jae    cbf5 <fwp_valid_utf8+0x125>
    cb93:	e9 87 00 00 00       	jmp    cc1f <fwp_valid_utf8+0x14f>
    cb98:	44 0f b6 44 0f 02    	movzbl 0x2(%rdi,%rcx,1),%r8d
    cb9e:	44 89 c3             	mov    %r8d,%ebx
    cba1:	83 e3 c0             	and    $0xffffffc0,%ebx
    cba4:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
    cbaa:	75 73                	jne    cc1f <fwp_valid_utf8+0x14f>
    cbac:	44 89 db             	mov    %r11d,%ebx
    cbaf:	c1 e3 06             	shl    $0x6,%ebx
    cbb2:	41 83 e0 3f          	and    $0x3f,%r8d
    cbb6:	41 09 d8             	or     %ebx,%r8d
    cbb9:	41 83 fa 03          	cmp    $0x3,%r10d
    cbbd:	75 0d                	jne    cbcc <fwp_valid_utf8+0xfc>
    cbbf:	45 89 c2             	mov    %r8d,%r10d
    cbc2:	45 89 d8             	mov    %r11d,%r8d
    cbc5:	41 39 d2             	cmp    %edx,%r10d
    cbc8:	73 2b                	jae    cbf5 <fwp_valid_utf8+0x125>
    cbca:	eb 53                	jmp    cc1f <fwp_valid_utf8+0x14f>
    cbcc:	44 0f b6 54 0f 03    	movzbl 0x3(%rdi,%rcx,1),%r10d
    cbd2:	45 89 d3             	mov    %r10d,%r11d
    cbd5:	41 83 e3 c0          	and    $0xffffffc0,%r11d
    cbd9:	41 81 fb 80 00 00 00 	cmp    $0x80,%r11d
    cbe0:	75 3d                	jne    cc1f <fwp_valid_utf8+0x14f>
    cbe2:	45 89 c3             	mov    %r8d,%r11d
    cbe5:	41 c1 e3 06          	shl    $0x6,%r11d
    cbe9:	41 83 e2 3f          	and    $0x3f,%r10d
    cbed:	45 09 da             	or     %r11d,%r10d
    cbf0:	41 39 d2             	cmp    %edx,%r10d
    cbf3:	72 2a                	jb     cc1f <fwp_valid_utf8+0x14f>
    cbf5:	41 81 fa ff ff 10 00 	cmp    $0x10ffff,%r10d
    cbfc:	77 21                	ja     cc1f <fwp_valid_utf8+0x14f>
    cbfe:	41 83 e0 e0          	and    $0xffffffe0,%r8d
    cc02:	41 81 f8 60 03 00 00 	cmp    $0x360,%r8d
    cc09:	74 14                	je     cc1f <fwp_valid_utf8+0x14f>
    cc0b:	4c 01 c9             	add    %r9,%rcx
    cc0e:	48 ff c1             	inc    %rcx
    cc11:	48 39 f1             	cmp    %rsi,%rcx
    cc14:	0f 82 d2 fe ff ff    	jb     caec <fwp_valid_utf8+0x1c>
    cc1a:	b8 01 00 00 00       	mov    $0x1,%eax
    cc1f:	5b                   	pop    %rbx
    cc20:	c3                   	ret
    cc21:	b8 01 00 00 00       	mov    $0x1,%eax
    cc26:	c3                   	ret
    cc27:	31 c0                	xor    %eax,%eax
    cc29:	5b                   	pop    %rbx
    cc2a:	c3                   	ret
    cc2b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000cc30 <fwp_str_new>:
    cc30:	41 57                	push   %r15
    cc32:	41 56                	push   %r14
    cc34:	53                   	push   %rbx
    cc35:	49 89 f6             	mov    %rsi,%r14
    cc38:	48 89 fb             	mov    %rdi,%rbx
    cc3b:	48 8d 56 09          	lea    0x9(%rsi),%rdx
    cc3f:	48 ff 05 e2 e0 00 00 	incq   0xe0e2(%rip)        # 1ad28 <measured_calls>
    cc46:	48 01 15 e3 e0 00 00 	add    %rdx,0xe0e3(%rip)        # 1ad30 <measured_bytes>
    cc4d:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    cc54:	77 61                	ja     ccb7 <fwp_str_new+0x87>
    cc56:	49 8d 4e 18          	lea    0x18(%r14),%rcx
    cc5a:	48 c1 e9 04          	shr    $0x4,%rcx
    cc5e:	48 8d 05 23 c6 00 00 	lea    0xc623(%rip),%rax        # 19288 <fwp_gc>
    cc65:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    cc6c:	00 
    cc6d:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    cc74:	48 29 0d 0d c6 00 00 	sub    %rcx,0xc60d(%rip)        # 19288 <fwp_gc>
    cc7b:	78 3a                	js     ccb7 <fwp_str_new+0x87>
    cc7d:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    cc81:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    cc85:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    cc8c:	4c 8b 3f             	mov    (%rdi),%r15
    cc8f:	4d 85 ff             	test   %r15,%r15
    cc92:	74 0b                	je     cc9f <fwp_str_new+0x6f>
    cc94:	49 8b 07             	mov    (%r15),%rax
    cc97:	48 f7 d0             	not    %rax
    cc9a:	48 89 07             	mov    %rax,(%rdi)
    cc9d:	eb 3a                	jmp    ccd9 <fwp_str_new+0xa9>
    cc9f:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    cca6:	00 
    cca7:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    ccae:	00 
    ccaf:	4c 29 ff             	sub    %r15,%rdi
    ccb2:	48 39 cf             	cmp    %rcx,%rdi
    ccb5:	73 12                	jae    ccc9 <fwp_str_new+0x99>
    ccb7:	48 89 d7             	mov    %rdx,%rdi
    ccba:	be 01 00 00 00       	mov    $0x1,%esi
    ccbf:	e8 5c b0 ff ff       	call   7d20 <fwp_gc_alloc_slow>
    ccc4:	49 89 c7             	mov    %rax,%r15
    ccc7:	eb 1a                	jmp    cce3 <fwp_str_new+0xb3>
    ccc9:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    cccd:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    ccd3:	4c 01 f9             	add    %r15,%rcx
    ccd6:	48 89 08             	mov    %rcx,(%rax)
    ccd9:	4c 89 ff             	mov    %r15,%rdi
    ccdc:	31 f6                	xor    %esi,%esi
    ccde:	e8 2d 65 ff ff       	call   3210 <memset@plt>
    cce3:	4d 89 37             	mov    %r14,(%r15)
    cce6:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    ccea:	48 89 de             	mov    %rbx,%rsi
    cced:	4c 89 f2             	mov    %r14,%rdx
    ccf0:	e8 3b 66 ff ff       	call   3330 <memcpy@plt>
    ccf5:	43 c6 44 37 08 00    	movb   $0x0,0x8(%r15,%r14,1)
    ccfb:	4c 89 f8             	mov    %r15,%rax
    ccfe:	5b                   	pop    %rbx
    ccff:	41 5e                	pop    %r14
    cd01:	41 5f                	pop    %r15
    cd03:	c3                   	ret
    cd04:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    cd0b:	00 00 00 00 00 

000000000000cd10 <buf_put>:
    cd10:	41 57                	push   %r15
    cd12:	41 56                	push   %r14
    cd14:	41 54                	push   %r12
    cd16:	53                   	push   %rbx
    cd17:	50                   	push   %rax
    cd18:	49 89 fe             	mov    %rdi,%r14
    cd1b:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    cd1f:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
    cd23:	0f 84 a2 00 00 00    	je     cdcb <buf_put+0xbb>
    cd29:	48 89 d3             	mov    %rdx,%rbx
    cd2c:	48 c7 c0 fe ff ff ff 	mov    $0xfffffffffffffffe,%rax
    cd33:	48 29 f8             	sub    %rdi,%rax
    cd36:	48 39 d0             	cmp    %rdx,%rax
    cd39:	0f 82 8c 00 00 00    	jb     cdcb <buf_put+0xbb>
    cd3f:	48 8d 04 3b          	lea    (%rbx,%rdi,1),%rax
    cd43:	48 ff c0             	inc    %rax
    cd46:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    cd4a:	48 39 c8             	cmp    %rcx,%rax
    cd4d:	76 30                	jbe    cd7f <buf_put+0x6f>
    cd4f:	48 85 c9             	test   %rcx,%rcx
    cd52:	41 bf 40 00 00 00    	mov    $0x40,%r15d
    cd58:	4c 0f 45 f9          	cmovne %rcx,%r15
    cd5c:	49 89 f4             	mov    %rsi,%r12
    cd5f:	49 39 c7             	cmp    %rax,%r15
    cd62:	73 23                	jae    cd87 <buf_put+0x77>
    cd64:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    cd6b:	00 00 00 00 00 
    cd70:	4d 85 ff             	test   %r15,%r15
    cd73:	78 0f                	js     cd84 <buf_put+0x74>
    cd75:	4d 01 ff             	add    %r15,%r15
    cd78:	49 39 c7             	cmp    %rax,%r15
    cd7b:	72 f3                	jb     cd70 <buf_put+0x60>
    cd7d:	eb 08                	jmp    cd87 <buf_put+0x77>
    cd7f:	49 8b 06             	mov    (%r14),%rax
    cd82:	eb 21                	jmp    cda5 <buf_put+0x95>
    cd84:	49 89 c7             	mov    %rax,%r15
    cd87:	49 8b 3e             	mov    (%r14),%rdi
    cd8a:	4c 89 fe             	mov    %r15,%rsi
    cd8d:	e8 ee 65 ff ff       	call   3380 <realloc@plt>
    cd92:	48 85 c0             	test   %rax,%rax
    cd95:	74 34                	je     cdcb <buf_put+0xbb>
    cd97:	49 89 06             	mov    %rax,(%r14)
    cd9a:	4d 89 7e 10          	mov    %r15,0x10(%r14)
    cd9e:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    cda2:	4c 89 e6             	mov    %r12,%rsi
    cda5:	48 01 c7             	add    %rax,%rdi
    cda8:	48 89 da             	mov    %rbx,%rdx
    cdab:	e8 80 65 ff ff       	call   3330 <memcpy@plt>
    cdb0:	49 03 5e 08          	add    0x8(%r14),%rbx
    cdb4:	49 89 5e 08          	mov    %rbx,0x8(%r14)
    cdb8:	49 8b 06             	mov    (%r14),%rax
    cdbb:	c6 04 18 00          	movb   $0x0,(%rax,%rbx,1)
    cdbf:	48 83 c4 08          	add    $0x8,%rsp
    cdc3:	5b                   	pop    %rbx
    cdc4:	41 5c                	pop    %r12
    cdc6:	41 5e                	pop    %r14
    cdc8:	41 5f                	pop    %r15
    cdca:	c3                   	ret
    cdcb:	48 8b 05 06 c2 00 00 	mov    0xc206(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    cdd2:	48 8b 08             	mov    (%rax),%rcx
    cdd5:	48 8d 3d ca 7c 00 00 	lea    0x7cca(%rip),%rdi        # 14aa6 <exec_in_fp0+0x296>
    cddc:	be 13 00 00 00       	mov    $0x13,%esi
    cde1:	ba 01 00 00 00       	mov    $0x1,%edx
    cde6:	e8 95 66 ff ff       	call   3480 <fwrite@plt>
    cdeb:	bf 66 00 00 00       	mov    $0x66,%edi
    cdf0:	e8 6b 66 ff ff       	call   3460 <exit@plt>
    cdf5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    cdfc:	00 00 00 00 

000000000000ce00 <buf_to_str>:
    ce00:	41 57                	push   %r15
    ce02:	41 56                	push   %r14
    ce04:	41 55                	push   %r13
    ce06:	41 54                	push   %r12
    ce08:	53                   	push   %rbx
    ce09:	48 89 fb             	mov    %rdi,%rbx
    ce0c:	4c 8b 2f             	mov    (%rdi),%r13
    ce0f:	4c 8b 77 08          	mov    0x8(%rdi),%r14
    ce13:	49 8d 56 09          	lea    0x9(%r14),%rdx
    ce17:	48 ff 05 0a df 00 00 	incq   0xdf0a(%rip)        # 1ad28 <measured_calls>
    ce1e:	48 01 15 0b df 00 00 	add    %rdx,0xdf0b(%rip)        # 1ad30 <measured_bytes>
    ce25:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    ce2c:	77 61                	ja     ce8f <buf_to_str+0x8f>
    ce2e:	49 8d 4e 18          	lea    0x18(%r14),%rcx
    ce32:	48 c1 e9 04          	shr    $0x4,%rcx
    ce36:	48 8d 05 4b c4 00 00 	lea    0xc44b(%rip),%rax        # 19288 <fwp_gc>
    ce3d:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    ce44:	00 
    ce45:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    ce4c:	48 29 0d 35 c4 00 00 	sub    %rcx,0xc435(%rip)        # 19288 <fwp_gc>
    ce53:	78 3a                	js     ce8f <buf_to_str+0x8f>
    ce55:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    ce59:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    ce5d:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    ce64:	4c 8b 3f             	mov    (%rdi),%r15
    ce67:	4d 85 ff             	test   %r15,%r15
    ce6a:	74 0b                	je     ce77 <buf_to_str+0x77>
    ce6c:	49 8b 07             	mov    (%r15),%rax
    ce6f:	48 f7 d0             	not    %rax
    ce72:	48 89 07             	mov    %rax,(%rdi)
    ce75:	eb 3a                	jmp    ceb1 <buf_to_str+0xb1>
    ce77:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    ce7e:	00 
    ce7f:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    ce86:	00 
    ce87:	4c 29 ff             	sub    %r15,%rdi
    ce8a:	48 39 cf             	cmp    %rcx,%rdi
    ce8d:	73 12                	jae    cea1 <buf_to_str+0xa1>
    ce8f:	48 89 d7             	mov    %rdx,%rdi
    ce92:	be 01 00 00 00       	mov    $0x1,%esi
    ce97:	e8 84 ae ff ff       	call   7d20 <fwp_gc_alloc_slow>
    ce9c:	49 89 c7             	mov    %rax,%r15
    ce9f:	eb 1a                	jmp    cebb <buf_to_str+0xbb>
    cea1:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    cea5:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    ceab:	4c 01 f9             	add    %r15,%rcx
    ceae:	48 89 08             	mov    %rcx,(%rax)
    ceb1:	4c 89 ff             	mov    %r15,%rdi
    ceb4:	31 f6                	xor    %esi,%esi
    ceb6:	e8 55 63 ff ff       	call   3210 <memset@plt>
    cebb:	4d 85 ed             	test   %r13,%r13
    cebe:	4c 8d 25 c5 82 00 00 	lea    0x82c5(%rip),%r12        # 1518a <exec_in_fp0+0x97a>
    cec5:	4d 0f 45 e5          	cmovne %r13,%r12
    cec9:	4d 89 37             	mov    %r14,(%r15)
    cecc:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    ced0:	4c 89 e6             	mov    %r12,%rsi
    ced3:	4c 89 f2             	mov    %r14,%rdx
    ced6:	e8 55 64 ff ff       	call   3330 <memcpy@plt>
    cedb:	43 c6 44 37 08 00    	movb   $0x0,0x8(%r15,%r14,1)
    cee1:	48 8b 3b             	mov    (%rbx),%rdi
    cee4:	e8 67 61 ff ff       	call   3050 <free@plt>
    cee9:	4c 89 f8             	mov    %r15,%rax
    ceec:	5b                   	pop    %rbx
    ceed:	41 5c                	pop    %r12
    ceef:	41 5d                	pop    %r13
    cef1:	41 5e                	pop    %r14
    cef3:	41 5f                	pop    %r15
    cef5:	c3                   	ret
    cef6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    cefd:	00 00 00 

000000000000cf00 <fwp_strf>:
    cf00:	55                   	push   %rbp
    cf01:	41 57                	push   %r15
    cf03:	41 56                	push   %r14
    cf05:	41 55                	push   %r13
    cf07:	41 54                	push   %r12
    cf09:	53                   	push   %rbx
    cf0a:	48 81 ec d8 00 00 00 	sub    $0xd8,%rsp
    cf11:	48 89 74 24 28       	mov    %rsi,0x28(%rsp)
    cf16:	48 89 54 24 30       	mov    %rdx,0x30(%rsp)
    cf1b:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
    cf20:	4c 89 44 24 40       	mov    %r8,0x40(%rsp)
    cf25:	4c 89 4c 24 48       	mov    %r9,0x48(%rsp)
    cf2a:	84 c0                	test   %al,%al
    cf2c:	74 37                	je     cf65 <fwp_strf+0x65>
    cf2e:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
    cf33:	0f 29 4c 24 60       	movaps %xmm1,0x60(%rsp)
    cf38:	0f 29 54 24 70       	movaps %xmm2,0x70(%rsp)
    cf3d:	0f 29 9c 24 80 00 00 	movaps %xmm3,0x80(%rsp)
    cf44:	00 
    cf45:	0f 29 a4 24 90 00 00 	movaps %xmm4,0x90(%rsp)
    cf4c:	00 
    cf4d:	0f 29 ac 24 a0 00 00 	movaps %xmm5,0xa0(%rsp)
    cf54:	00 
    cf55:	0f 29 b4 24 b0 00 00 	movaps %xmm6,0xb0(%rsp)
    cf5c:	00 
    cf5d:	0f 29 bc 24 c0 00 00 	movaps %xmm7,0xc0(%rsp)
    cf64:	00 
    cf65:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    cf6a:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    cf6f:	48 8d ac 24 10 01 00 	lea    0x110(%rsp),%rbp
    cf76:	00 
    cf77:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    cf7c:	49 bd 08 00 00 00 30 	movabs $0x3000000008,%r13
    cf83:	00 00 00 
    cf86:	4c 89 2c 24          	mov    %r13,(%rsp)
    cf8a:	48 8d 15 a8 86 00 00 	lea    0x86a8(%rip),%rdx        # 15639 <exec_in_fp0+0xe29>
    cf91:	48 89 e1             	mov    %rsp,%rcx
    cf94:	31 ff                	xor    %edi,%edi
    cf96:	31 f6                	xor    %esi,%esi
    cf98:	e8 73 61 ff ff       	call   3110 <vsnprintf@plt>
    cf9d:	48 63 d8             	movslq %eax,%rbx
    cfa0:	48 ff 05 81 dd 00 00 	incq   0xdd81(%rip)        # 1ad28 <measured_calls>
    cfa7:	4c 8d 7b 01          	lea    0x1(%rbx),%r15
    cfab:	4c 01 3d 7e dd 00 00 	add    %r15,0xdd7e(%rip)        # 1ad30 <measured_bytes>
    cfb2:	4c 8d 25 cf c2 00 00 	lea    0xc2cf(%rip),%r12        # 19288 <fwp_gc>
    cfb9:	49 81 ff 00 40 00 00 	cmp    $0x4000,%r15
    cfc0:	77 5c                	ja     d01e <fwp_strf+0x11e>
    cfc2:	48 8d 43 10          	lea    0x10(%rbx),%rax
    cfc6:	48 c1 e8 04          	shr    $0x4,%rax
    cfca:	42 0f b6 8c 20 e8 0b 	movzbl 0xbe8(%rax,%r12,1),%ecx
    cfd1:	00 00 
    cfd3:	41 8b 84 8c 48 0b 00 	mov    0xb48(%r12,%rcx,4),%eax
    cfda:	00 
    cfdb:	48 29 05 a6 c2 00 00 	sub    %rax,0xc2a6(%rip)        # 19288 <fwp_gc>
    cfe2:	78 3a                	js     d01e <fwp_strf+0x11e>
    cfe4:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    cfe8:	49 8d 14 cc          	lea    (%r12,%rcx,8),%rdx
    cfec:	48 81 c2 c8 03 00 00 	add    $0x3c8,%rdx
    cff3:	4c 8b 32             	mov    (%rdx),%r14
    cff6:	4d 85 f6             	test   %r14,%r14
    cff9:	74 0b                	je     d006 <fwp_strf+0x106>
    cffb:	49 8b 06             	mov    (%r14),%rax
    cffe:	48 f7 d0             	not    %rax
    d001:	48 89 02             	mov    %rax,(%rdx)
    d004:	eb 3b                	jmp    d041 <fwp_strf+0x141>
    d006:	4d 8b b4 cc d0 03 00 	mov    0x3d0(%r12,%rcx,8),%r14
    d00d:	00 
    d00e:	49 8b 94 cc d8 03 00 	mov    0x3d8(%r12,%rcx,8),%rdx
    d015:	00 
    d016:	4c 29 f2             	sub    %r14,%rdx
    d019:	48 39 c2             	cmp    %rax,%rdx
    d01c:	73 12                	jae    d030 <fwp_strf+0x130>
    d01e:	4c 89 ff             	mov    %r15,%rdi
    d021:	be 01 00 00 00       	mov    $0x1,%esi
    d026:	e8 f5 ac ff ff       	call   7d20 <fwp_gc_alloc_slow>
    d02b:	49 89 c6             	mov    %rax,%r14
    d02e:	eb 1e                	jmp    d04e <fwp_strf+0x14e>
    d030:	49 8d 0c cc          	lea    (%r12,%rcx,8),%rcx
    d034:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
    d03b:	4c 01 f0             	add    %r14,%rax
    d03e:	48 89 01             	mov    %rax,(%rcx)
    d041:	4c 89 f7             	mov    %r14,%rdi
    d044:	31 f6                	xor    %esi,%esi
    d046:	4c 89 fa             	mov    %r15,%rdx
    d049:	e8 c2 61 ff ff       	call   3210 <memset@plt>
    d04e:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    d053:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    d058:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    d05d:	4c 89 2c 24          	mov    %r13,(%rsp)
    d061:	48 8d 15 d1 85 00 00 	lea    0x85d1(%rip),%rdx        # 15639 <exec_in_fp0+0xe29>
    d068:	48 89 e1             	mov    %rsp,%rcx
    d06b:	4c 89 f7             	mov    %r14,%rdi
    d06e:	4c 89 fe             	mov    %r15,%rsi
    d071:	e8 9a 60 ff ff       	call   3110 <vsnprintf@plt>
    d076:	48 8d 53 09          	lea    0x9(%rbx),%rdx
    d07a:	48 ff 05 a7 dc 00 00 	incq   0xdca7(%rip)        # 1ad28 <measured_calls>
    d081:	48 01 15 a8 dc 00 00 	add    %rdx,0xdca8(%rip)        # 1ad30 <measured_bytes>
    d088:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    d08f:	77 5c                	ja     d0ed <fwp_strf+0x1ed>
    d091:	48 8d 43 18          	lea    0x18(%rbx),%rax
    d095:	48 c1 e8 04          	shr    $0x4,%rax
    d099:	42 0f b6 8c 20 e8 0b 	movzbl 0xbe8(%rax,%r12,1),%ecx
    d0a0:	00 00 
    d0a2:	41 8b 84 8c 48 0b 00 	mov    0xb48(%r12,%rcx,4),%eax
    d0a9:	00 
    d0aa:	48 29 05 d7 c1 00 00 	sub    %rax,0xc1d7(%rip)        # 19288 <fwp_gc>
    d0b1:	78 3a                	js     d0ed <fwp_strf+0x1ed>
    d0b3:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    d0b7:	49 8d 34 cc          	lea    (%r12,%rcx,8),%rsi
    d0bb:	48 81 c6 c8 03 00 00 	add    $0x3c8,%rsi
    d0c2:	4c 8b 3e             	mov    (%rsi),%r15
    d0c5:	4d 85 ff             	test   %r15,%r15
    d0c8:	74 0b                	je     d0d5 <fwp_strf+0x1d5>
    d0ca:	49 8b 07             	mov    (%r15),%rax
    d0cd:	48 f7 d0             	not    %rax
    d0d0:	48 89 06             	mov    %rax,(%rsi)
    d0d3:	eb 3b                	jmp    d110 <fwp_strf+0x210>
    d0d5:	4d 8b bc cc d0 03 00 	mov    0x3d0(%r12,%rcx,8),%r15
    d0dc:	00 
    d0dd:	49 8b b4 cc d8 03 00 	mov    0x3d8(%r12,%rcx,8),%rsi
    d0e4:	00 
    d0e5:	4c 29 fe             	sub    %r15,%rsi
    d0e8:	48 39 c6             	cmp    %rax,%rsi
    d0eb:	73 12                	jae    d0ff <fwp_strf+0x1ff>
    d0ed:	48 89 d7             	mov    %rdx,%rdi
    d0f0:	be 01 00 00 00       	mov    $0x1,%esi
    d0f5:	e8 26 ac ff ff       	call   7d20 <fwp_gc_alloc_slow>
    d0fa:	49 89 c7             	mov    %rax,%r15
    d0fd:	eb 1b                	jmp    d11a <fwp_strf+0x21a>
    d0ff:	49 8d 0c cc          	lea    (%r12,%rcx,8),%rcx
    d103:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
    d10a:	4c 01 f8             	add    %r15,%rax
    d10d:	48 89 01             	mov    %rax,(%rcx)
    d110:	4c 89 ff             	mov    %r15,%rdi
    d113:	31 f6                	xor    %esi,%esi
    d115:	e8 f6 60 ff ff       	call   3210 <memset@plt>
    d11a:	49 89 1f             	mov    %rbx,(%r15)
    d11d:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    d121:	4c 89 f6             	mov    %r14,%rsi
    d124:	48 89 da             	mov    %rbx,%rdx
    d127:	e8 04 62 ff ff       	call   3330 <memcpy@plt>
    d12c:	41 c6 44 1f 08 00    	movb   $0x0,0x8(%r15,%rbx,1)
    d132:	4c 89 f8             	mov    %r15,%rax
    d135:	48 81 c4 d8 00 00 00 	add    $0xd8,%rsp
    d13c:	5b                   	pop    %rbx
    d13d:	41 5c                	pop    %r12
    d13f:	41 5d                	pop    %r13
    d141:	41 5e                	pop    %r14
    d143:	41 5f                	pop    %r15
    d145:	5d                   	pop    %rbp
    d146:	c3                   	ret
    d147:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    d14e:	00 00 

000000000000d150 <fwp_data>:
    d150:	55                   	push   %rbp
    d151:	41 57                	push   %r15
    d153:	41 56                	push   %r14
    d155:	53                   	push   %rbx
    d156:	50                   	push   %rax
    d157:	89 fd                	mov    %edi,%ebp
    d159:	85 f6                	test   %esi,%esi
    d15b:	0f 84 a1 00 00 00    	je     d202 <fwp_data+0xb2>
    d161:	48 89 d3             	mov    %rdx,%rbx
    d164:	41 89 f6             	mov    %esi,%r14d
    d167:	4a 8d 3c f5 08 00 00 	lea    0x8(,%r14,8),%rdi
    d16e:	00 
    d16f:	41 89 f7             	mov    %esi,%r15d
    d172:	e8 c9 d0 ff ff       	call   a240 <fwp_alloc_init>
    d177:	89 28                	mov    %ebp,(%rax)
    d179:	44 89 78 04          	mov    %r15d,0x4(%rax)
    d17d:	41 83 ff 08          	cmp    $0x8,%r15d
    d181:	72 10                	jb     d193 <fwp_data+0x43>
    d183:	48 89 c1             	mov    %rax,%rcx
    d186:	48 29 d9             	sub    %rbx,%rcx
    d189:	48 83 c1 08          	add    $0x8,%rcx
    d18d:	48 83 f9 20          	cmp    $0x20,%rcx
    d191:	73 73                	jae    d206 <fwp_data+0xb6>
    d193:	31 c9                	xor    %ecx,%ecx
    d195:	4c 89 f6             	mov    %r14,%rsi
    d198:	48 89 ca             	mov    %rcx,%rdx
    d19b:	48 83 e6 03          	and    $0x3,%rsi
    d19f:	74 20                	je     d1c1 <fwp_data+0x71>
    d1a1:	48 89 ca             	mov    %rcx,%rdx
    d1a4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    d1ab:	00 00 00 00 00 
    d1b0:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    d1b4:	48 89 7c d0 08       	mov    %rdi,0x8(%rax,%rdx,8)
    d1b9:	48 ff c2             	inc    %rdx
    d1bc:	48 ff ce             	dec    %rsi
    d1bf:	75 ef                	jne    d1b0 <fwp_data+0x60>
    d1c1:	4c 29 f1             	sub    %r14,%rcx
    d1c4:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    d1c8:	77 7b                	ja     d245 <fwp_data+0xf5>
    d1ca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    d1d0:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    d1d4:	48 89 4c d0 08       	mov    %rcx,0x8(%rax,%rdx,8)
    d1d9:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    d1de:	48 89 4c d0 10       	mov    %rcx,0x10(%rax,%rdx,8)
    d1e3:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    d1e8:	48 89 4c d0 18       	mov    %rcx,0x18(%rax,%rdx,8)
    d1ed:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    d1f2:	48 89 4c d0 20       	mov    %rcx,0x20(%rax,%rdx,8)
    d1f7:	48 83 c2 04          	add    $0x4,%rdx
    d1fb:	49 39 d6             	cmp    %rdx,%r14
    d1fe:	75 d0                	jne    d1d0 <fwp_data+0x80>
    d200:	eb 43                	jmp    d245 <fwp_data+0xf5>
    d202:	89 e8                	mov    %ebp,%eax
    d204:	eb 3f                	jmp    d245 <fwp_data+0xf5>
    d206:	44 89 f1             	mov    %r14d,%ecx
    d209:	83 e1 fc             	and    $0xfffffffc,%ecx
    d20c:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
    d213:	00 
    d214:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    d218:	31 f6                	xor    %esi,%esi
    d21a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    d220:	0f 10 04 33          	movups (%rbx,%rsi,1),%xmm0
    d224:	0f 10 4c 33 10       	movups 0x10(%rbx,%rsi,1),%xmm1
    d229:	0f 11 44 30 08       	movups %xmm0,0x8(%rax,%rsi,1)
    d22e:	0f 11 4c 30 18       	movups %xmm1,0x18(%rax,%rsi,1)
    d233:	48 83 c6 20          	add    $0x20,%rsi
    d237:	48 39 f2             	cmp    %rsi,%rdx
    d23a:	75 e4                	jne    d220 <fwp_data+0xd0>
    d23c:	4c 39 f1             	cmp    %r14,%rcx
    d23f:	0f 85 50 ff ff ff    	jne    d195 <fwp_data+0x45>
    d245:	48 83 c4 08          	add    $0x8,%rsp
    d249:	5b                   	pop    %rbx
    d24a:	41 5e                	pop    %r14
    d24c:	41 5f                	pop    %r15
    d24e:	5d                   	pop    %rbp
    d24f:	c3                   	ret

000000000000d250 <tp_value>:
    d250:	55                   	push   %rbp
    d251:	41 57                	push   %r15
    d253:	41 56                	push   %r14
    d255:	41 55                	push   %r13
    d257:	41 54                	push   %r12
    d259:	53                   	push   %rbx
    d25a:	48 81 ec d8 01 00 00 	sub    $0x1d8,%rsp
    d261:	49 89 cc             	mov    %rcx,%r12
    d264:	85 d2                	test   %edx,%edx
    d266:	0f 84 99 00 00 00    	je     d305 <tp_value+0xb5>
    d26c:	83 3e 0c             	cmpl   $0xc,(%rsi)
    d26f:	0f 85 90 00 00 00    	jne    d305 <tp_value+0xb5>
    d275:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    d279:	4c 8b 7f 10          	mov    0x10(%rdi),%r15
    d27d:	4c 89 e5             	mov    %r12,%rbp
    d280:	4c 8b 27             	mov    (%rdi),%r12
    d283:	4d 01 fc             	add    %r15,%r12
    d286:	4d 29 fd             	sub    %r15,%r13
    d289:	0f 85 ea 00 00 00    	jne    d379 <tp_value+0x129>
    d28f:	49 8d 55 09          	lea    0x9(%r13),%rdx
    d293:	48 ff 05 8e da 00 00 	incq   0xda8e(%rip)        # 1ad28 <measured_calls>
    d29a:	48 01 15 8f da 00 00 	add    %rdx,0xda8f(%rip)        # 1ad30 <measured_bytes>
    d2a1:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    d2a8:	0f 87 38 02 00 00    	ja     d4e6 <tp_value+0x296>
    d2ae:	49 8d 4d 18          	lea    0x18(%r13),%rcx
    d2b2:	48 c1 e9 04          	shr    $0x4,%rcx
    d2b6:	48 8d 05 cb bf 00 00 	lea    0xbfcb(%rip),%rax        # 19288 <fwp_gc>
    d2bd:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    d2c4:	00 
    d2c5:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    d2cc:	48 29 0d b5 bf 00 00 	sub    %rcx,0xbfb5(%rip)        # 19288 <fwp_gc>
    d2d3:	0f 88 0d 02 00 00    	js     d4e6 <tp_value+0x296>
    d2d9:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    d2dd:	4c 8d 04 f0          	lea    (%rax,%rsi,8),%r8
    d2e1:	49 81 c0 c8 03 00 00 	add    $0x3c8,%r8
    d2e8:	4d 8b 30             	mov    (%r8),%r14
    d2eb:	4d 85 f6             	test   %r14,%r14
    d2ee:	0f 84 d6 01 00 00    	je     d4ca <tp_value+0x27a>
    d2f4:	48 89 fb             	mov    %rdi,%rbx
    d2f7:	49 8b 06             	mov    (%r14),%rax
    d2fa:	48 f7 d0             	not    %rax
    d2fd:	49 89 00             	mov    %rax,(%r8)
    d300:	e9 de 04 00 00       	jmp    d7e3 <tp_value+0x593>
    d305:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    d309:	4c 8b 7f 10          	mov    0x10(%rdi),%r15
    d30d:	4d 39 ef             	cmp    %r13,%r15
    d310:	73 2e                	jae    d340 <tp_value+0xf0>
    d312:	48 8b 07             	mov    (%rdi),%rax
    d315:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    d31c:	00 00 00 
    d31f:	90                   	nop
    d320:	46 0f b6 04 38       	movzbl (%rax,%r15,1),%r8d
    d325:	49 83 f8 20          	cmp    $0x20,%r8
    d329:	77 15                	ja     d340 <tp_value+0xf0>
    d32b:	4c 0f a3 c1          	bt     %r8,%rcx
    d32f:	73 0f                	jae    d340 <tp_value+0xf0>
    d331:	49 ff c7             	inc    %r15
    d334:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    d338:	4d 39 fd             	cmp    %r15,%r13
    d33b:	75 e3                	jne    d320 <tp_value+0xd0>
    d33d:	4d 89 ef             	mov    %r13,%r15
    d340:	8b 06                	mov    (%rsi),%eax
    d342:	45 31 f6             	xor    %r14d,%r14d
    d345:	48 83 f8 15          	cmp    $0x15,%rax
    d349:	0f 87 c8 04 00 00    	ja     d817 <tp_value+0x5c7>
    d34f:	48 8d 0d e2 6e 00 00 	lea    0x6ee2(%rip),%rcx        # 14238 <_IO_stdin_used+0x238>
    d356:	4c 63 04 81          	movslq (%rcx,%rax,4),%r8
    d35a:	49 01 c8             	add    %rcx,%r8
    d35d:	41 ff e0             	jmp    *%r8
    d360:	4c 89 e2             	mov    %r12,%rdx
    d363:	48 81 c4 d8 01 00 00 	add    $0x1d8,%rsp
    d36a:	5b                   	pop    %rbx
    d36b:	41 5c                	pop    %r12
    d36d:	41 5d                	pop    %r13
    d36f:	41 5e                	pop    %r14
    d371:	41 5f                	pop    %r15
    d373:	5d                   	pop    %rbp
    d374:	e9 e7 16 00 00       	jmp    ea60 <tp_int>
    d379:	31 c0                	xor    %eax,%eax
    d37b:	eb 0f                	jmp    d38c <tp_value+0x13c>
    d37d:	0f 1f 00             	nopl   (%rax)
    d380:	48 ff c0             	inc    %rax
    d383:	4c 39 e8             	cmp    %r13,%rax
    d386:	0f 83 03 ff ff ff    	jae    d28f <tp_value+0x3f>
    d38c:	45 0f b6 04 04       	movzbl (%r12,%rax,1),%r8d
    d391:	45 84 c0             	test   %r8b,%r8b
    d394:	79 ea                	jns    d380 <tp_value+0x130>
    d396:	41 8d 48 3e          	lea    0x3e(%r8),%ecx
    d39a:	80 f9 1e             	cmp    $0x1e,%cl
    d39d:	73 11                	jae    d3b0 <tp_value+0x160>
    d39f:	b9 80 00 00 00       	mov    $0x80,%ecx
    d3a4:	be 01 00 00 00       	mov    $0x1,%esi
    d3a9:	ba 1f 00 00 00       	mov    $0x1f,%edx
    d3ae:	eb 38                	jmp    d3e8 <tp_value+0x198>
    d3b0:	44 89 c1             	mov    %r8d,%ecx
    d3b3:	80 e1 f0             	and    $0xf0,%cl
    d3b6:	80 f9 e0             	cmp    $0xe0,%cl
    d3b9:	75 11                	jne    d3cc <tp_value+0x17c>
    d3bb:	b9 00 08 00 00       	mov    $0x800,%ecx
    d3c0:	be 02 00 00 00       	mov    $0x2,%esi
    d3c5:	ba 0f 00 00 00       	mov    $0xf,%edx
    d3ca:	eb 1c                	jmp    d3e8 <tp_value+0x198>
    d3cc:	41 8d 48 10          	lea    0x10(%r8),%ecx
    d3d0:	80 f9 04             	cmp    $0x4,%cl
    d3d3:	0f 87 8c 15 00 00    	ja     e965 <tp_value+0x1715>
    d3d9:	b9 00 00 01 00       	mov    $0x10000,%ecx
    d3de:	be 03 00 00 00       	mov    $0x3,%esi
    d3e3:	ba 07 00 00 00       	mov    $0x7,%edx
    d3e8:	89 f6                	mov    %esi,%esi
    d3ea:	4c 8d 0c 30          	lea    (%rax,%rsi,1),%r9
    d3ee:	45 31 f6             	xor    %r14d,%r14d
    d3f1:	4d 39 e9             	cmp    %r13,%r9
    d3f4:	0f 83 1d 04 00 00    	jae    d817 <tp_value+0x5c7>
    d3fa:	45 0f b6 4c 04 01    	movzbl 0x1(%r12,%rax,1),%r9d
    d400:	45 89 ca             	mov    %r9d,%r10d
    d403:	41 83 e2 c0          	and    $0xffffffc0,%r10d
    d407:	41 81 fa 80 00 00 00 	cmp    $0x80,%r10d
    d40e:	0f 85 03 04 00 00    	jne    d817 <tp_value+0x5c7>
    d414:	44 21 c2             	and    %r8d,%edx
    d417:	44 8d 46 01          	lea    0x1(%rsi),%r8d
    d41b:	41 89 d2             	mov    %edx,%r10d
    d41e:	41 c1 e2 06          	shl    $0x6,%r10d
    d422:	41 83 e1 3f          	and    $0x3f,%r9d
    d426:	45 09 d1             	or     %r10d,%r9d
    d429:	41 83 f8 02          	cmp    $0x2,%r8d
    d42d:	75 05                	jne    d434 <tp_value+0x1e4>
    d42f:	45 89 c8             	mov    %r9d,%r8d
    d432:	eb 5d                	jmp    d491 <tp_value+0x241>
    d434:	41 0f b6 54 04 02    	movzbl 0x2(%r12,%rax,1),%edx
    d43a:	41 89 d2             	mov    %edx,%r10d
    d43d:	41 83 e2 c0          	and    $0xffffffc0,%r10d
    d441:	41 81 fa 80 00 00 00 	cmp    $0x80,%r10d
    d448:	0f 85 c9 03 00 00    	jne    d817 <tp_value+0x5c7>
    d44e:	45 89 ca             	mov    %r9d,%r10d
    d451:	41 c1 e2 06          	shl    $0x6,%r10d
    d455:	83 e2 3f             	and    $0x3f,%edx
    d458:	44 09 d2             	or     %r10d,%edx
    d45b:	41 83 f8 03          	cmp    $0x3,%r8d
    d45f:	75 08                	jne    d469 <tp_value+0x219>
    d461:	41 89 d0             	mov    %edx,%r8d
    d464:	44 89 ca             	mov    %r9d,%edx
    d467:	eb 28                	jmp    d491 <tp_value+0x241>
    d469:	45 0f b6 44 04 03    	movzbl 0x3(%r12,%rax,1),%r8d
    d46f:	45 89 c1             	mov    %r8d,%r9d
    d472:	41 83 e1 c0          	and    $0xffffffc0,%r9d
    d476:	41 81 f9 80 00 00 00 	cmp    $0x80,%r9d
    d47d:	0f 85 94 03 00 00    	jne    d817 <tp_value+0x5c7>
    d483:	41 89 d1             	mov    %edx,%r9d
    d486:	41 c1 e1 06          	shl    $0x6,%r9d
    d48a:	41 83 e0 3f          	and    $0x3f,%r8d
    d48e:	45 09 c8             	or     %r9d,%r8d
    d491:	83 e2 e0             	and    $0xffffffe0,%edx
    d494:	81 fa 60 03 00 00    	cmp    $0x360,%edx
    d49a:	0f 84 77 03 00 00    	je     d817 <tp_value+0x5c7>
    d4a0:	41 39 c8             	cmp    %ecx,%r8d
    d4a3:	0f 82 6e 03 00 00    	jb     d817 <tp_value+0x5c7>
    d4a9:	41 81 f8 ff ff 10 00 	cmp    $0x10ffff,%r8d
    d4b0:	0f 87 61 03 00 00    	ja     d817 <tp_value+0x5c7>
    d4b6:	48 01 f0             	add    %rsi,%rax
    d4b9:	48 ff c0             	inc    %rax
    d4bc:	4c 39 e8             	cmp    %r13,%rax
    d4bf:	0f 82 c7 fe ff ff    	jb     d38c <tp_value+0x13c>
    d4c5:	e9 c5 fd ff ff       	jmp    d28f <tp_value+0x3f>
    d4ca:	4c 8b b4 f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r14
    d4d1:	00 
    d4d2:	4c 8b 84 f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%r8
    d4d9:	00 
    d4da:	4d 29 f0             	sub    %r14,%r8
    d4dd:	49 39 c8             	cmp    %rcx,%r8
    d4e0:	0f 83 ea 02 00 00    	jae    d7d0 <tp_value+0x580>
    d4e6:	48 89 fb             	mov    %rdi,%rbx
    d4e9:	48 89 d7             	mov    %rdx,%rdi
    d4ec:	be 01 00 00 00       	mov    $0x1,%esi
    d4f1:	e8 2a a8 ff ff       	call   7d20 <fwp_gc_alloc_slow>
    d4f6:	49 89 c6             	mov    %rax,%r14
    d4f9:	e9 ef 02 00 00       	jmp    d7ed <tp_value+0x59d>
    d4fe:	f3 0f 6f 46 38       	movdqu 0x38(%rsi),%xmm0
    d503:	66 0f 7f 44 24 50    	movdqa %xmm0,0x50(%rsp)
    d509:	31 c9                	xor    %ecx,%ecx
    d50b:	83 f8 13             	cmp    $0x13,%eax
    d50e:	0f 94 c1             	sete   %cl
    d511:	66 0f ef c0          	pxor   %xmm0,%xmm0
    d515:	66 0f 7f 44 24 60    	movdqa %xmm0,0x60(%rsp)
    d51b:	48 c7 44 24 70 00 00 	movq   $0x0,0x70(%rsp)
    d522:	00 00 
    d524:	89 4c 24 78          	mov    %ecx,0x78(%rsp)
    d528:	48 8d 0d 3e 81 00 00 	lea    0x813e(%rip),%rcx        # 1566d <exec_in_fp0+0xe5d>
    d52f:	48 8d 05 7b 74 00 00 	lea    0x747b(%rip),%rax        # 149b1 <exec_in_fp0+0x1a1>
    d536:	48 0f 44 c1          	cmove  %rcx,%rax
    d53a:	4d 39 ef             	cmp    %r13,%r15
    d53d:	73 31                	jae    d570 <tp_value+0x320>
    d53f:	48 8b 0f             	mov    (%rdi),%rcx
    d542:	48 ba 00 26 00 00 01 	movabs $0x100002600,%rdx
    d549:	00 00 00 
    d54c:	0f 1f 40 00          	nopl   0x0(%rax)
    d550:	46 0f b6 04 39       	movzbl (%rcx,%r15,1),%r8d
    d555:	49 83 f8 20          	cmp    $0x20,%r8
    d559:	77 15                	ja     d570 <tp_value+0x320>
    d55b:	4c 0f a3 c2          	bt     %r8,%rdx
    d55f:	73 0f                	jae    d570 <tp_value+0x320>
    d561:	49 ff c7             	inc    %r15
    d564:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    d568:	4d 39 fd             	cmp    %r15,%r13
    d56b:	75 e3                	jne    d550 <tp_value+0x300>
    d56d:	4d 89 ef             	mov    %r13,%r15
    d570:	4d 29 fd             	sub    %r15,%r13
    d573:	45 31 f6             	xor    %r14d,%r14d
    d576:	49 83 fd 03          	cmp    $0x3,%r13
    d57a:	0f 82 97 02 00 00    	jb     d817 <tp_value+0x5c7>
    d580:	48 8b 0f             	mov    (%rdi),%rcx
    d583:	42 0f b7 14 39       	movzwl (%rcx,%r15,1),%edx
    d588:	66 33 10             	xor    (%rax),%dx
    d58b:	42 0f b6 4c 39 02    	movzbl 0x2(%rcx,%r15,1),%ecx
    d591:	32 48 02             	xor    0x2(%rax),%cl
    d594:	0f b6 c1             	movzbl %cl,%eax
    d597:	66 09 d0             	or     %dx,%ax
    d59a:	0f 85 77 02 00 00    	jne    d817 <tp_value+0x5c7>
    d5a0:	48 89 f3             	mov    %rsi,%rbx
    d5a3:	49 83 c7 03          	add    $0x3,%r15
    d5a7:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    d5ab:	48 8d 35 8d 81 00 00 	lea    0x818d(%rip),%rsi        # 1573f <exec_in_fp0+0xf2f>
    d5b2:	48 8d 15 c9 73 00 00 	lea    0x73c9(%rip),%rdx        # 14982 <exec_in_fp0+0x172>
    d5b9:	48 8d 0d 50 23 00 00 	lea    0x2350(%rip),%rcx        # f910 <tp_kv_item>
    d5c0:	4c 8d 44 24 50       	lea    0x50(%rsp),%r8
    d5c5:	e8 e6 1f 00 00       	call   f5b0 <tp_list_of>
    d5ca:	85 c0                	test   %eax,%eax
    d5cc:	0f 84 dc 0a 00 00    	je     e0ae <tp_value+0xe5e>
    d5d2:	48 83 7c 24 68 00    	cmpq   $0x0,0x68(%rsp)
    d5d8:	0f 84 c3 0d 00 00    	je     e3a1 <tp_value+0x1151>
    d5de:	48 8d 05 ab d7 01 00 	lea    0x1d7ab(%rip),%rax        # 2ad90 <fwp_empty_map>
    d5e5:	45 31 f6             	xor    %r14d,%r14d
    d5e8:	48 8b 4c 24 60       	mov    0x60(%rsp),%rcx
    d5ed:	4a 8b 3c f1          	mov    (%rcx,%r14,8),%rdi
    d5f1:	4a 8b 74 f1 08       	mov    0x8(%rcx,%r14,8),%rsi
    d5f6:	48 8b 4b 38          	mov    0x38(%rbx),%rcx
    d5fa:	48 89 c2             	mov    %rax,%rdx
    d5fd:	e8 ee 23 00 00       	call   f9f0 <fwp_p_map_insert>
    d602:	49 83 c6 02          	add    $0x2,%r14
    d606:	4c 3b 74 24 68       	cmp    0x68(%rsp),%r14
    d60b:	72 db                	jb     d5e8 <tp_value+0x398>
    d60d:	e9 96 0d 00 00       	jmp    e3a8 <tp_value+0x1158>
    d612:	66 0f ef c0          	pxor   %xmm0,%xmm0
    d616:	f3 0f 7f 44 24 68    	movdqu %xmm0,0x68(%rsp)
    d61c:	f3 0f 7f 44 24 58    	movdqu %xmm0,0x58(%rsp)
    d622:	48 c7 44 24 78 00 00 	movq   $0x0,0x78(%rsp)
    d629:	00 00 
    d62b:	48 8b 4e 38          	mov    0x38(%rsi),%rcx
    d62f:	48 89 4c 24 50       	mov    %rcx,0x50(%rsp)
    d634:	83 f8 11             	cmp    $0x11,%eax
    d637:	75 6c                	jne    d6a5 <tp_value+0x455>
    d639:	4d 39 ef             	cmp    %r13,%r15
    d63c:	73 32                	jae    d670 <tp_value+0x420>
    d63e:	48 8b 07             	mov    (%rdi),%rax
    d641:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    d648:	00 00 00 
    d64b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    d650:	42 0f b6 14 38       	movzbl (%rax,%r15,1),%edx
    d655:	48 83 fa 20          	cmp    $0x20,%rdx
    d659:	77 15                	ja     d670 <tp_value+0x420>
    d65b:	48 0f a3 d1          	bt     %rdx,%rcx
    d65f:	73 0f                	jae    d670 <tp_value+0x420>
    d661:	49 ff c7             	inc    %r15
    d664:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    d668:	4d 39 fd             	cmp    %r15,%r13
    d66b:	75 e3                	jne    d650 <tp_value+0x400>
    d66d:	4d 89 ef             	mov    %r13,%r15
    d670:	4d 29 fd             	sub    %r15,%r13
    d673:	45 31 f6             	xor    %r14d,%r14d
    d676:	49 83 fd 05          	cmp    $0x5,%r13
    d67a:	0f 82 97 01 00 00    	jb     d817 <tp_value+0x5c7>
    d680:	48 8b 07             	mov    (%rdi),%rax
    d683:	b9 61 72 72 61       	mov    $0x61727261,%ecx
    d688:	42 33 0c 38          	xor    (%rax,%r15,1),%ecx
    d68c:	42 0f b6 44 38 04    	movzbl 0x4(%rax,%r15,1),%eax
    d692:	83 f0 79             	xor    $0x79,%eax
    d695:	09 c8                	or     %ecx,%eax
    d697:	0f 85 7a 01 00 00    	jne    d817 <tp_value+0x5c7>
    d69d:	49 83 c7 05          	add    $0x5,%r15
    d6a1:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    d6a5:	48 89 f3             	mov    %rsi,%rbx
    d6a8:	48 8d 35 42 72 00 00 	lea    0x7242(%rip),%rsi        # 148f1 <exec_in_fp0+0xe1>
    d6af:	48 8d 15 ed 81 00 00 	lea    0x81ed(%rip),%rdx        # 158a3 <exec_in_fp0+0x1093>
    d6b6:	48 8d 0d 13 22 00 00 	lea    0x2213(%rip),%rcx        # f8d0 <tp_elem_item>
    d6bd:	4c 8d 44 24 50       	lea    0x50(%rsp),%r8
    d6c2:	e8 e9 1e 00 00       	call   f5b0 <tp_list_of>
    d6c7:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
    d6cc:	85 c0                	test   %eax,%eax
    d6ce:	0f 84 2a 05 00 00    	je     dbfe <tp_value+0x9ae>
    d6d4:	48 8b 74 24 68       	mov    0x68(%rsp),%rsi
    d6d9:	e8 82 f2 ff ff       	call   c960 <fwp_list_from>
    d6de:	49 89 c6             	mov    %rax,%r14
    d6e1:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
    d6e6:	e8 95 ce ff ff       	call   a580 <fwp_mem_free>
    d6eb:	83 3b 11             	cmpl   $0x11,(%rbx)
    d6ee:	0f 85 4a 10 00 00    	jne    e73e <tp_value+0x14ee>
    d6f4:	4c 8b 7b 38          	mov    0x38(%rbx),%r15
    d6f8:	4d 85 f6             	test   %r14,%r14
    d6fb:	0f 84 e5 0a 00 00    	je     e1e6 <tp_value+0xf96>
    d701:	31 ff                	xor    %edi,%edi
    d703:	4c 89 f0             	mov    %r14,%rax
    d706:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    d70d:	00 00 00 
    d710:	48 ff c7             	inc    %rdi
    d713:	48 8b 40 10          	mov    0x10(%rax),%rax
    d717:	48 85 c0             	test   %rax,%rax
    d71a:	75 f4                	jne    d710 <tp_value+0x4c0>
    d71c:	4c 89 fe             	mov    %r15,%rsi
    d71f:	e8 ac 7d ff ff       	call   54d0 <fwp_array_new_packed>
    d724:	b9 04 00 00 00       	mov    $0x4,%ecx
    d729:	ba 84 04 00 00       	mov    $0x484,%edx
    d72e:	be 21 00 00 00       	mov    $0x21,%esi
    d733:	bf 42 00 00 00       	mov    $0x42,%edi
    d738:	4d 89 f0             	mov    %r14,%r8
    d73b:	eb 15                	jmp    d752 <tp_value+0x502>
    d73d:	4c 89 4c c8 e8       	mov    %r9,-0x18(%rax,%rcx,8)
    d742:	4d 8b 40 10          	mov    0x10(%r8),%r8
    d746:	48 ff c1             	inc    %rcx
    d749:	4d 85 c0             	test   %r8,%r8
    d74c:	0f 84 9e 0a 00 00    	je     e1f0 <tp_value+0xfa0>
    d752:	48 83 38 00          	cmpq   $0x0,(%rax)
    d756:	0f 88 cb 12 00 00    	js     ea27 <tp_value+0x17d7>
    d75c:	4d 8b 48 08          	mov    0x8(%r8),%r9
    d760:	4d 85 ff             	test   %r15,%r15
    d763:	74 d8                	je     d73d <tp_value+0x4ed>
    d765:	45 8b 17             	mov    (%r15),%r10d
    d768:	41 83 fa 0a          	cmp    $0xa,%r10d
    d76c:	77 cf                	ja     d73d <tp_value+0x4ed>
    d76e:	44 0f a3 d2          	bt     %r10d,%edx
    d772:	72 13                	jb     d787 <tp_value+0x537>
    d774:	44 0f a3 d6          	bt     %r10d,%esi
    d778:	72 14                	jb     d78e <tp_value+0x53e>
    d77a:	44 0f a3 d7          	bt     %r10d,%edi
    d77e:	73 bd                	jae    d73d <tp_value+0x4ed>
    d780:	66 44 89 0c 48       	mov    %r9w,(%rax,%rcx,2)
    d785:	eb bb                	jmp    d742 <tp_value+0x4f2>
    d787:	44 89 4c 88 f8       	mov    %r9d,-0x8(%rax,%rcx,4)
    d78c:	eb b4                	jmp    d742 <tp_value+0x4f2>
    d78e:	44 88 4c 08 04       	mov    %r9b,0x4(%rax,%rcx,1)
    d793:	eb ad                	jmp    d742 <tp_value+0x4f2>
    d795:	49 89 f7             	mov    %rsi,%r15
    d798:	48 8d 74 24 50       	lea    0x50(%rsp),%rsi
    d79d:	ba 80 00 00 00       	mov    $0x80,%edx
    d7a2:	e8 49 20 00 00       	call   f7f0 <tp_token>
    d7a7:	45 31 f6             	xor    %r14d,%r14d
    d7aa:	48 83 f8 7f          	cmp    $0x7f,%rax
    d7ae:	77 67                	ja     d817 <tp_value+0x5c7>
    d7b0:	8b 54 24 50          	mov    0x50(%rsp),%edx
    d7b4:	81 fa 69 6e 66 00    	cmp    $0x666e69,%edx
    d7ba:	0f 85 0c 04 00 00    	jne    dbcc <tp_value+0x97c>
    d7c0:	f2 0f 10 05 f8 69 00 	movsd  0x69f8(%rip),%xmm0        # 141c0 <_IO_stdin_used+0x1c0>
    d7c7:	00 
    d7c8:	4c 89 f9             	mov    %r15,%rcx
    d7cb:	e9 f5 08 00 00       	jmp    e0c5 <tp_value+0xe75>
    d7d0:	48 89 fb             	mov    %rdi,%rbx
    d7d3:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    d7d7:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    d7dd:	4c 01 f1             	add    %r14,%rcx
    d7e0:	48 89 08             	mov    %rcx,(%rax)
    d7e3:	4c 89 f7             	mov    %r14,%rdi
    d7e6:	31 f6                	xor    %esi,%esi
    d7e8:	e8 23 5a ff ff       	call   3210 <memset@plt>
    d7ed:	4d 89 2e             	mov    %r13,(%r14)
    d7f0:	49 8d 7e 08          	lea    0x8(%r14),%rdi
    d7f4:	4c 89 e6             	mov    %r12,%rsi
    d7f7:	4c 89 ea             	mov    %r13,%rdx
    d7fa:	e8 31 5b ff ff       	call   3330 <memcpy@plt>
    d7ff:	43 c6 44 2e 08 00    	movb   $0x0,0x8(%r14,%r13,1)
    d805:	4c 89 75 00          	mov    %r14,0x0(%rbp)
    d809:	48 8b 43 08          	mov    0x8(%rbx),%rax
    d80d:	48 89 43 10          	mov    %rax,0x10(%rbx)
    d811:	41 be 01 00 00 00    	mov    $0x1,%r14d
    d817:	44 89 f0             	mov    %r14d,%eax
    d81a:	48 81 c4 d8 01 00 00 	add    $0x1d8,%rsp
    d821:	5b                   	pop    %rbx
    d822:	41 5c                	pop    %r12
    d824:	41 5d                	pop    %r13
    d826:	41 5e                	pop    %r14
    d828:	41 5f                	pop    %r15
    d82a:	5d                   	pop    %rbp
    d82b:	c3                   	ret
    d82c:	85 d2                	test   %edx,%edx
    d82e:	0f 85 49 fa ff ff    	jne    d27d <tp_value+0x2d>
    d834:	4c 89 e6             	mov    %r12,%rsi
    d837:	48 81 c4 d8 01 00 00 	add    $0x1d8,%rsp
    d83e:	5b                   	pop    %rbx
    d83f:	41 5c                	pop    %r12
    d841:	41 5d                	pop    %r13
    d843:	41 5e                	pop    %r14
    d845:	41 5f                	pop    %r15
    d847:	5d                   	pop    %rbp
    d848:	e9 e3 18 00 00       	jmp    f130 <tp_quoted>
    d84d:	66 0f ef c0          	pxor   %xmm0,%xmm0
    d851:	66 0f 7f 44 24 70    	movdqa %xmm0,0x70(%rsp)
    d857:	66 0f 7f 44 24 60    	movdqa %xmm0,0x60(%rsp)
    d85d:	66 0f 7f 44 24 50    	movdqa %xmm0,0x50(%rsp)
    d863:	4d 39 ef             	cmp    %r13,%r15
    d866:	73 38                	jae    d8a0 <tp_value+0x650>
    d868:	48 8b 07             	mov    (%rdi),%rax
    d86b:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    d872:	00 00 00 
    d875:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    d87c:	00 00 00 00 
    d880:	42 0f b6 14 38       	movzbl (%rax,%r15,1),%edx
    d885:	48 83 fa 20          	cmp    $0x20,%rdx
    d889:	77 15                	ja     d8a0 <tp_value+0x650>
    d88b:	48 0f a3 d1          	bt     %rdx,%rcx
    d88f:	73 0f                	jae    d8a0 <tp_value+0x650>
    d891:	49 ff c7             	inc    %r15
    d894:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    d898:	4d 39 fd             	cmp    %r15,%r13
    d89b:	75 e3                	jne    d880 <tp_value+0x630>
    d89d:	4d 89 ef             	mov    %r13,%r15
    d8a0:	4d 29 fd             	sub    %r15,%r13
    d8a3:	45 31 f6             	xor    %r14d,%r14d
    d8a6:	49 83 fd 05          	cmp    $0x5,%r13
    d8aa:	72 1d                	jb     d8c9 <tp_value+0x679>
    d8ac:	48 8b 07             	mov    (%rdi),%rax
    d8af:	b9 62 79 74 65       	mov    $0x65747962,%ecx
    d8b4:	42 33 0c 38          	xor    (%rax,%r15,1),%ecx
    d8b8:	42 0f b6 44 38 04    	movzbl 0x4(%rax,%r15,1),%eax
    d8be:	83 f0 73             	xor    $0x73,%eax
    d8c1:	09 c8                	or     %ecx,%eax
    d8c3:	0f 84 43 07 00 00    	je     e00c <tp_value+0xdbc>
    d8c9:	31 ff                	xor    %edi,%edi
    d8cb:	e8 b0 cc ff ff       	call   a580 <fwp_mem_free>
    d8d0:	e9 42 ff ff ff       	jmp    d817 <tp_value+0x5c7>
    d8d5:	48 89 f3             	mov    %rsi,%rbx
    d8d8:	48 8d 74 24 50       	lea    0x50(%rsp),%rsi
    d8dd:	ba 00 01 00 00       	mov    $0x100,%edx
    d8e2:	e8 09 1f 00 00       	call   f7f0 <tp_token>
    d8e7:	45 31 f6             	xor    %r14d,%r14d
    d8ea:	48 83 f8 02          	cmp    $0x2,%rax
    d8ee:	0f 82 23 ff ff ff    	jb     d817 <tp_value+0x5c7>
    d8f4:	80 7c 24 50 30       	cmpb   $0x30,0x50(%rsp)
    d8f9:	0f 85 18 ff ff ff    	jne    d817 <tp_value+0x5c7>
    d8ff:	80 7c 24 51 74       	cmpb   $0x74,0x51(%rsp)
    d904:	0f 85 0d ff ff ff    	jne    d817 <tp_value+0x5c7>
    d90a:	48 8d 48 fe          	lea    -0x2(%rax),%rcx
    d90e:	48 63 53 48          	movslq 0x48(%rbx),%rdx
    d912:	48 39 d1             	cmp    %rdx,%rcx
    d915:	0f 87 fc fe ff ff    	ja     d817 <tp_value+0x5c7>
    d91b:	48 83 f8 03          	cmp    $0x3,%rax
    d91f:	0f 82 d3 08 00 00    	jb     e1f8 <tp_value+0xfa8>
    d925:	ba 02 00 00 00       	mov    $0x2,%edx
    d92a:	31 c9                	xor    %ecx,%ecx
    d92c:	e9 0a 02 00 00       	jmp    db3b <tp_value+0x8eb>
    d931:	48 8d 74 24 50       	lea    0x50(%rsp),%rsi
    d936:	ba 10 00 00 00       	mov    $0x10,%edx
    d93b:	e8 b0 1e 00 00       	call   f7f0 <tp_token>
    d940:	8b 44 24 50          	mov    0x50(%rsp),%eax
    d944:	89 c1                	mov    %eax,%ecx
    d946:	81 f1 2b 31 00 00    	xor    $0x312b,%ecx
    d94c:	0f b6 54 24 52       	movzbl 0x52(%rsp),%edx
    d951:	66 09 ca             	or     %cx,%dx
    d954:	41 be 01 00 00 00    	mov    $0x1,%r14d
    d95a:	0f 84 de 0d 00 00    	je     e73e <tp_value+0x14ee>
    d960:	66 83 f8 31          	cmp    $0x31,%ax
    d964:	0f 84 d4 0d 00 00    	je     e73e <tp_value+0x14ee>
    d96a:	45 31 f6             	xor    %r14d,%r14d
    d96d:	66 83 f8 30          	cmp    $0x30,%ax
    d971:	0f 84 c7 0d 00 00    	je     e73e <tp_value+0x14ee>
    d977:	b8 2d 31 00 00       	mov    $0x312d,%eax
    d97c:	33 44 24 50          	xor    0x50(%rsp),%eax
    d980:	0f b6 4c 24 52       	movzbl 0x52(%rsp),%ecx
    d985:	66 09 c1             	or     %ax,%cx
    d988:	0f 85 89 fe ff ff    	jne    d817 <tp_value+0x5c7>
    d98e:	49 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%r14
    d995:	e9 a4 0d 00 00       	jmp    e73e <tp_value+0x14ee>
    d99a:	48 8b 6e 08          	mov    0x8(%rsi),%rbp
    d99e:	48 85 ed             	test   %rbp,%rbp
    d9a1:	4c 89 64 24 18       	mov    %r12,0x18(%rsp)
    d9a6:	0f 84 5f 02 00 00    	je     dc0b <tp_value+0x9bb>
    d9ac:	48 89 f3             	mov    %rsi,%rbx
    d9af:	49 89 fe             	mov    %rdi,%r14
    d9b2:	48 8d 35 b8 7c 00 00 	lea    0x7cb8(%rip),%rsi        # 15671 <exec_in_fp0+0xe61>
    d9b9:	48 89 ef             	mov    %rbp,%rdi
    d9bc:	e8 0f 59 ff ff       	call   32d0 <strcmp@plt>
    d9c1:	85 c0                	test   %eax,%eax
    d9c3:	0f 84 06 05 00 00    	je     decf <tp_value+0xc7f>
    d9c9:	48 89 d8             	mov    %rbx,%rax
    d9cc:	44 8b 63 10          	mov    0x10(%rbx),%r12d
    d9d0:	4d 39 ef             	cmp    %r13,%r15
    d9d3:	73 30                	jae    da05 <tp_value+0x7b5>
    d9d5:	4c 89 f1             	mov    %r14,%rcx
    d9d8:	49 8b 16             	mov    (%r14),%rdx
    d9db:	48 be 00 26 00 00 01 	movabs $0x100002600,%rsi
    d9e2:	00 00 00 
    d9e5:	42 0f b6 3c 3a       	movzbl (%rdx,%r15,1),%edi
    d9ea:	48 83 ff 20          	cmp    $0x20,%rdi
    d9ee:	77 15                	ja     da05 <tp_value+0x7b5>
    d9f0:	48 0f a3 fe          	bt     %rdi,%rsi
    d9f4:	73 0f                	jae    da05 <tp_value+0x7b5>
    d9f6:	49 ff c7             	inc    %r15
    d9f9:	4c 89 79 10          	mov    %r15,0x10(%rcx)
    d9fd:	4d 39 fd             	cmp    %r15,%r13
    da00:	75 e3                	jne    d9e5 <tp_value+0x795>
    da02:	4d 89 ef             	mov    %r13,%r15
    da05:	48 83 c0 10          	add    $0x10,%rax
    da09:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    da0e:	48 89 ef             	mov    %rbp,%rdi
    da11:	e8 5a 57 ff ff       	call   3170 <strlen@plt>
    da16:	4d 29 fd             	sub    %r15,%r13
    da19:	49 39 c5             	cmp    %rax,%r13
    da1c:	72 1c                	jb     da3a <tp_value+0x7ea>
    da1e:	49 8b 3e             	mov    (%r14),%rdi
    da21:	4c 01 ff             	add    %r15,%rdi
    da24:	48 89 ee             	mov    %rbp,%rsi
    da27:	49 89 c5             	mov    %rax,%r13
    da2a:	48 89 c2             	mov    %rax,%rdx
    da2d:	e8 3e 59 ff ff       	call   3370 <bcmp@plt>
    da32:	85 c0                	test   %eax,%eax
    da34:	0f 84 58 0b 00 00    	je     e592 <tp_value+0x1342>
    da3a:	4c 89 f7             	mov    %r14,%rdi
    da3d:	48 89 de             	mov    %rbx,%rsi
    da40:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    da45:	49 63 c4             	movslq %r12d,%rax
    da48:	48 8d 04 c5 08 00 00 	lea    0x8(,%rax,8),%rax
    da4f:	00 
    da50:	4c 8b 25 d1 d2 00 00 	mov    0xd2d1(%rip),%r12        # 1ad28 <measured_calls>
    da57:	49 ff c4             	inc    %r12
    da5a:	4c 89 25 c7 d2 00 00 	mov    %r12,0xd2c7(%rip)        # 1ad28 <measured_calls>
    da61:	4c 8b 2d c8 d2 00 00 	mov    0xd2c8(%rip),%r13        # 1ad30 <measured_bytes>
    da68:	49 01 c5             	add    %rax,%r13
    da6b:	4c 89 2d be d2 00 00 	mov    %r13,0xd2be(%rip)        # 1ad30 <measured_bytes>
    da72:	4c 8d 35 0f b8 00 00 	lea    0xb80f(%rip),%r14        # 19288 <fwp_gc>
    da79:	48 3d 00 40 00 00    	cmp    $0x4000,%rax
    da7f:	0f 87 79 06 00 00    	ja     e0fe <tp_value+0xeae>
    da85:	48 8d 48 0f          	lea    0xf(%rax),%rcx
    da89:	48 c1 e9 04          	shr    $0x4,%rcx
    da8d:	42 0f b6 8c 31 e8 0b 	movzbl 0xbe8(%rcx,%r14,1),%ecx
    da94:	00 00 
    da96:	41 8b 94 8e 48 0b 00 	mov    0xb48(%r14,%rcx,4),%edx
    da9d:	00 
    da9e:	48 29 15 e3 b7 00 00 	sub    %rdx,0xb7e3(%rip)        # 19288 <fwp_gc>
    daa5:	0f 88 53 06 00 00    	js     e0fe <tp_value+0xeae>
    daab:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    daaf:	4d 8d 04 ce          	lea    (%r14,%rcx,8),%r8
    dab3:	49 81 c0 88 07 00 00 	add    $0x788,%r8
    daba:	4d 8b 08             	mov    (%r8),%r9
    dabd:	4d 85 c9             	test   %r9,%r9
    dac0:	0f 84 1c 06 00 00    	je     e0e2 <tp_value+0xe92>
    dac6:	48 89 f5             	mov    %rsi,%rbp
    dac9:	48 89 fb             	mov    %rdi,%rbx
    dacc:	49 8b 01             	mov    (%r9),%rax
    dacf:	48 f7 d0             	not    %rax
    dad2:	49 89 00             	mov    %rax,(%r8)
    dad5:	e9 40 07 00 00       	jmp    e21a <tp_value+0xfca>
    dada:	48 8b 07             	mov    (%rdi),%rax
    dadd:	4d 39 ef             	cmp    %r13,%r15
    dae0:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    dae5:	89 54 24 08          	mov    %edx,0x8(%rsp)
    dae9:	73 77                	jae    db62 <tp_value+0x912>
    daeb:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    daf2:	00 00 00 
    daf5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    dafc:	00 00 00 00 
    db00:	46 0f b6 04 38       	movzbl (%rax,%r15,1),%r8d
    db05:	49 83 f8 20          	cmp    $0x20,%r8
    db09:	77 57                	ja     db62 <tp_value+0x912>
    db0b:	4c 0f a3 c1          	bt     %r8,%rcx
    db0f:	73 51                	jae    db62 <tp_value+0x912>
    db11:	49 ff c7             	inc    %r15
    db14:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    db18:	4d 39 fd             	cmp    %r15,%r13
    db1b:	75 e3                	jne    db00 <tp_value+0x8b0>
    db1d:	48 89 f5             	mov    %rsi,%rbp
    db20:	4d 89 ef             	mov    %r13,%r15
    db23:	e9 19 02 00 00       	jmp    dd41 <tp_value+0xaf1>
    db28:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    db2c:	48 ff c9             	dec    %rcx
    db2f:	48 ff c2             	inc    %rdx
    db32:	48 39 d0             	cmp    %rdx,%rax
    db35:	0f 84 bf 06 00 00    	je     e1fa <tp_value+0xfaa>
    db3b:	0f b6 74 14 50       	movzbl 0x50(%rsp,%rdx,1),%esi
    db40:	83 fe 30             	cmp    $0x30,%esi
    db43:	74 17                	je     db5c <tp_value+0x90c>
    db45:	83 fe 2d             	cmp    $0x2d,%esi
    db48:	74 de                	je     db28 <tp_value+0x8d8>
    db4a:	83 fe 2b             	cmp    $0x2b,%esi
    db4d:	0f 85 12 0e 00 00    	jne    e965 <tp_value+0x1715>
    db53:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    db57:	48 ff c1             	inc    %rcx
    db5a:	eb d3                	jmp    db2f <tp_value+0x8df>
    db5c:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    db60:	eb cd                	jmp    db2f <tp_value+0x8df>
    db62:	4d 39 ef             	cmp    %r13,%r15
    db65:	0f 83 cb 01 00 00    	jae    dd36 <tp_value+0xae6>
    db6b:	49 b8 03 00 00 00 00 	movabs $0x4000000000003,%r8
    db72:	00 04 00 
    db75:	4c 89 f9             	mov    %r15,%rcx
    db78:	eb 16                	jmp    db90 <tp_value+0x940>
    db7a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    db80:	48 ff c1             	inc    %rcx
    db83:	48 89 4f 10          	mov    %rcx,0x10(%rdi)
    db87:	49 39 cd             	cmp    %rcx,%r13
    db8a:	0f 84 ae 01 00 00    	je     dd3e <tp_value+0xaee>
    db90:	44 0f b6 0c 08       	movzbl (%rax,%rcx,1),%r9d
    db95:	45 8d 51 d0          	lea    -0x30(%r9),%r10d
    db99:	41 80 fa 0a          	cmp    $0xa,%r10b
    db9d:	72 e1                	jb     db80 <tp_value+0x930>
    db9f:	45 89 ca             	mov    %r9d,%r10d
    dba2:	41 80 e2 df          	and    $0xdf,%r10b
    dba6:	41 80 c2 bf          	add    $0xbf,%r10b
    dbaa:	41 80 fa 1a          	cmp    $0x1a,%r10b
    dbae:	72 d0                	jb     db80 <tp_value+0x930>
    dbb0:	45 0f b6 c9          	movzbl %r9b,%r9d
    dbb4:	41 83 c1 d3          	add    $0xffffffd3,%r9d
    dbb8:	41 83 f9 32          	cmp    $0x32,%r9d
    dbbc:	77 06                	ja     dbc4 <tp_value+0x974>
    dbbe:	4d 0f a3 c8          	bt     %r9,%r8
    dbc2:	72 bc                	jb     db80 <tp_value+0x930>
    dbc4:	48 89 f5             	mov    %rsi,%rbp
    dbc7:	e9 78 01 00 00       	jmp    dd44 <tp_value+0xaf4>
    dbcc:	b9 2d 69 6e 66       	mov    $0x666e692d,%ecx
    dbd1:	33 4c 24 50          	xor    0x50(%rsp),%ecx
    dbd5:	0f b6 74 24 54       	movzbl 0x54(%rsp),%esi
    dbda:	09 ce                	or     %ecx,%esi
    dbdc:	4c 89 f9             	mov    %r15,%rcx
    dbdf:	0f 84 d8 04 00 00    	je     e0bd <tp_value+0xe6d>
    dbe5:	81 fa 4e 61 4e 00    	cmp    $0x4e614e,%edx
    dbeb:	0f 85 38 05 00 00    	jne    e129 <tp_value+0xed9>
    dbf1:	f2 0f 10 05 d7 65 00 	movsd  0x65d7(%rip),%xmm0        # 141d0 <_IO_stdin_used+0x1d0>
    dbf8:	00 
    dbf9:	e9 c7 04 00 00       	jmp    e0c5 <tp_value+0xe75>
    dbfe:	e8 7d c9 ff ff       	call   a580 <fwp_mem_free>
    dc03:	45 31 f6             	xor    %r14d,%r14d
    dc06:	e9 0c fc ff ff       	jmp    d817 <tp_value+0x5c7>
    dc0b:	4c 63 66 10          	movslq 0x10(%rsi),%r12
    dc0f:	4d 85 e4             	test   %r12,%r12
    dc12:	0f 84 8f 05 00 00    	je     e1a7 <tp_value+0xf57>
    dc18:	4c 8d 7e 10          	lea    0x10(%rsi),%r15
    dc1c:	83 7e 48 00          	cmpl   $0x0,0x48(%rsi)
    dc20:	0f 84 1f fe ff ff    	je     da45 <tp_value+0x7f5>
    dc26:	48 89 f3             	mov    %rsi,%rbx
    dc29:	49 c1 e4 03          	shl    $0x3,%r12
    dc2d:	49 89 fd             	mov    %rdi,%r13
    dc30:	4c 89 e7             	mov    %r12,%rdi
    dc33:	e8 38 a0 ff ff       	call   7c70 <fwp_alloc>
    dc38:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    dc3d:	48 8d 35 3d 7a 00 00 	lea    0x7a3d(%rip),%rsi        # 15681 <exec_in_fp0+0xe71>
    dc44:	4d 89 ec             	mov    %r13,%r12
    dc47:	4c 89 ef             	mov    %r13,%rdi
    dc4a:	e8 c1 18 00 00       	call   f510 <tp_eat>
    dc4f:	85 c0                	test   %eax,%eax
    dc51:	0f 84 c0 fb ff ff    	je     d817 <tp_value+0x5c7>
    dc57:	41 83 3f 00          	cmpl   $0x0,(%r15)
    dc5b:	4c 89 e7             	mov    %r12,%rdi
    dc5e:	0f 8e 9e 00 00 00    	jle    dd02 <tp_value+0xab2>
    dc64:	45 31 ed             	xor    %r13d,%r13d
    dc67:	48 bd 00 26 00 00 01 	movabs $0x100002600,%rbp
    dc6e:	00 00 00 
    dc71:	4d 85 ed             	test   %r13,%r13
    dc74:	74 54                	je     dcca <tp_value+0xa7a>
    dc76:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
    dc7a:	48 8b 47 10          	mov    0x10(%rdi),%rax
    dc7e:	48 39 c8             	cmp    %rcx,%rax
    dc81:	73 27                	jae    dcaa <tp_value+0xa5a>
    dc83:	48 8b 17             	mov    (%rdi),%rdx
    dc86:	0f b6 34 02          	movzbl (%rdx,%rax,1),%esi
    dc8a:	48 83 fe 20          	cmp    $0x20,%rsi
    dc8e:	77 1a                	ja     dcaa <tp_value+0xa5a>
    dc90:	48 0f a3 f5          	bt     %rsi,%rbp
    dc94:	73 14                	jae    dcaa <tp_value+0xa5a>
    dc96:	48 ff c0             	inc    %rax
    dc99:	48 89 47 10          	mov    %rax,0x10(%rdi)
    dc9d:	45 31 f6             	xor    %r14d,%r14d
    dca0:	48 39 c1             	cmp    %rax,%rcx
    dca3:	75 e1                	jne    dc86 <tp_value+0xa36>
    dca5:	e9 6d fb ff ff       	jmp    d817 <tp_value+0x5c7>
    dcaa:	45 31 f6             	xor    %r14d,%r14d
    dcad:	48 39 c1             	cmp    %rax,%rcx
    dcb0:	0f 84 61 fb ff ff    	je     d817 <tp_value+0x5c7>
    dcb6:	48 8b 0f             	mov    (%rdi),%rcx
    dcb9:	80 3c 01 2c          	cmpb   $0x2c,(%rcx,%rax,1)
    dcbd:	0f 85 54 fb ff ff    	jne    d817 <tp_value+0x5c7>
    dcc3:	48 ff c0             	inc    %rax
    dcc6:	48 89 47 10          	mov    %rax,0x10(%rdi)
    dcca:	48 8b 43 20          	mov    0x20(%rbx),%rax
    dcce:	4a 8b 34 e8          	mov    (%rax,%r13,8),%rsi
    dcd2:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    dcd7:	4a 8d 0c e8          	lea    (%rax,%r13,8),%rcx
    dcdb:	45 31 f6             	xor    %r14d,%r14d
    dcde:	4c 89 e7             	mov    %r12,%rdi
    dce1:	31 d2                	xor    %edx,%edx
    dce3:	e8 68 f5 ff ff       	call   d250 <tp_value>
    dce8:	85 c0                	test   %eax,%eax
    dcea:	0f 84 27 fb ff ff    	je     d817 <tp_value+0x5c7>
    dcf0:	4c 89 e7             	mov    %r12,%rdi
    dcf3:	49 ff c5             	inc    %r13
    dcf6:	49 63 07             	movslq (%r15),%rax
    dcf9:	49 39 c5             	cmp    %rax,%r13
    dcfc:	0f 8c 6f ff ff ff    	jl     dc71 <tp_value+0xa21>
    dd02:	48 8d 35 39 7a 00 00 	lea    0x7a39(%rip),%rsi        # 15742 <exec_in_fp0+0xf32>
    dd09:	e8 02 18 00 00       	call   f510 <tp_eat>
    dd0e:	41 be 00 00 00 00    	mov    $0x0,%r14d
    dd14:	85 c0                	test   %eax,%eax
    dd16:	0f 84 fb fa ff ff    	je     d817 <tp_value+0x5c7>
    dd1c:	41 8b 3f             	mov    (%r15),%edi
    dd1f:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    dd24:	e8 87 1f 00 00       	call   fcb0 <fwp_record>
    dd29:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    dd2e:	48 89 01             	mov    %rax,(%rcx)
    dd31:	e9 db fa ff ff       	jmp    d811 <tp_value+0x5c1>
    dd36:	48 89 f5             	mov    %rsi,%rbp
    dd39:	4c 89 f9             	mov    %r15,%rcx
    dd3c:	eb 06                	jmp    dd44 <tp_value+0xaf4>
    dd3e:	48 89 f5             	mov    %rsi,%rbp
    dd41:	4c 89 e9             	mov    %r13,%rcx
    dd44:	4c 89 64 24 18       	mov    %r12,0x18(%rsp)
    dd49:	4c 29 f9             	sub    %r15,%rcx
    dd4c:	48 81 f9 ff 00 00 00 	cmp    $0xff,%rcx
    dd53:	41 be ff 00 00 00    	mov    $0xff,%r14d
    dd59:	4c 0f 42 f1          	cmovb  %rcx,%r14
    dd5d:	4c 01 f8             	add    %r15,%rax
    dd60:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    dd65:	48 89 c6             	mov    %rax,%rsi
    dd68:	4c 89 f2             	mov    %r14,%rdx
    dd6b:	e8 c0 55 ff ff       	call   3330 <memcpy@plt>
    dd70:	42 c6 44 34 50 00    	movb   $0x0,0x50(%rsp,%r14,1)
    dd76:	44 8b 6d 10          	mov    0x10(%rbp),%r13d
    dd7a:	45 85 ed             	test   %r13d,%r13d
    dd7d:	7e 3d                	jle    ddbc <tp_value+0xb6c>
    dd7f:	49 89 ef             	mov    %rbp,%r15
    dd82:	48 8b 5d 18          	mov    0x18(%rbp),%rbx
    dd86:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    dd8b:	45 31 e4             	xor    %r12d,%r12d
    dd8e:	4c 8d 74 24 50       	lea    0x50(%rsp),%r14
    dd93:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    dd9a:	84 00 00 00 00 00 
    dda0:	4a 8b 3c e3          	mov    (%rbx,%r12,8),%rdi
    dda4:	4c 89 f6             	mov    %r14,%rsi
    dda7:	e8 24 55 ff ff       	call   32d0 <strcmp@plt>
    ddac:	85 c0                	test   %eax,%eax
    ddae:	41 0f 44 ec          	cmove  %r12d,%ebp
    ddb2:	49 ff c4             	inc    %r12
    ddb5:	4d 39 e5             	cmp    %r12,%r13
    ddb8:	75 e6                	jne    dda0 <tp_value+0xb50>
    ddba:	eb 08                	jmp    ddc4 <tp_value+0xb74>
    ddbc:	49 89 ef             	mov    %rbp,%r15
    ddbf:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    ddc4:	83 7c 24 08 00       	cmpl   $0x0,0x8(%rsp)
    ddc9:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    ddce:	74 60                	je     de30 <tp_value+0xbe0>
    ddd0:	85 ed                	test   %ebp,%ebp
    ddd2:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
    ddd7:	79 5c                	jns    de35 <tp_value+0xbe5>
    ddd9:	49 8b 7f 08          	mov    0x8(%r15),%rdi
    dddd:	45 31 f6             	xor    %r14d,%r14d
    dde0:	48 85 ff             	test   %rdi,%rdi
    dde3:	0f 84 2e fa ff ff    	je     d817 <tp_value+0x5c7>
    dde9:	48 8d 35 63 78 00 00 	lea    0x7863(%rip),%rsi        # 15653 <exec_in_fp0+0xe43>
    ddf0:	e8 db 54 ff ff       	call   32d0 <strcmp@plt>
    ddf5:	85 c0                	test   %eax,%eax
    ddf7:	0f 85 1a fa ff ff    	jne    d817 <tp_value+0x5c7>
    ddfd:	4c 89 fe             	mov    %r15,%rsi
    de00:	8b 44 24 50          	mov    0x50(%rsp),%eax
    de04:	89 c2                	mov    %eax,%edx
    de06:	81 f2 74 72 75 65    	xor    $0x65757274,%edx
    de0c:	0f b6 7c 24 54       	movzbl 0x54(%rsp),%edi
    de11:	09 d7                	or     %edx,%edi
    de13:	ba 01 00 00 00       	mov    $0x1,%edx
    de18:	0f 44 ea             	cmove  %edx,%ebp
    de1b:	35 66 61 6c 73       	xor    $0x736c6166,%eax
    de20:	0f b7 54 24 54       	movzwl 0x54(%rsp),%edx
    de25:	83 f2 65             	xor    $0x65,%edx
    de28:	09 c2                	or     %eax,%edx
    de2a:	75 0c                	jne    de38 <tp_value+0xbe8>
    de2c:	31 ed                	xor    %ebp,%ebp
    de2e:	eb 10                	jmp    de40 <tp_value+0xbf0>
    de30:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
    de35:	4c 89 fe             	mov    %r15,%rsi
    de38:	85 ed                	test   %ebp,%ebp
    de3a:	0f 88 25 0b 00 00    	js     e965 <tp_value+0x1715>
    de40:	48 8b 46 28          	mov    0x28(%rsi),%rax
    de44:	41 89 ee             	mov    %ebp,%r14d
    de47:	4e 63 3c b0          	movslq (%rax,%r14,4),%r15
    de4b:	45 89 fa             	mov    %r15d,%r10d
    de4e:	4a 8d 3c fd 08 00 00 	lea    0x8(,%r15,8),%rdi
    de55:	00 
    de56:	48 ff 05 cb ce 00 00 	incq   0xcecb(%rip)        # 1ad28 <measured_calls>
    de5d:	48 01 3d cc ce 00 00 	add    %rdi,0xcecc(%rip)        # 1ad30 <measured_bytes>
    de64:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    de6b:	4c 89 54 24 20       	mov    %r10,0x20(%rsp)
    de70:	0f 87 1a 03 00 00    	ja     e190 <tp_value+0xf40>
    de76:	48 8d 57 0f          	lea    0xf(%rdi),%rdx
    de7a:	48 c1 ea 04          	shr    $0x4,%rdx
    de7e:	48 8d 05 03 b4 00 00 	lea    0xb403(%rip),%rax        # 19288 <fwp_gc>
    de85:	44 0f b6 84 02 e8 0b 	movzbl 0xbe8(%rdx,%rax,1),%r8d
    de8c:	00 00 
    de8e:	42 8b 94 80 48 0b 00 	mov    0xb48(%rax,%r8,4),%edx
    de95:	00 
    de96:	48 29 15 eb b3 00 00 	sub    %rdx,0xb3eb(%rip)        # 19288 <fwp_gc>
    de9d:	0f 88 ed 02 00 00    	js     e190 <tp_value+0xf40>
    dea3:	4f 8d 04 40          	lea    (%r8,%r8,2),%r8
    dea7:	4e 8d 0c c0          	lea    (%rax,%r8,8),%r9
    deab:	49 81 c1 88 07 00 00 	add    $0x788,%r9
    deb2:	4d 8b 19             	mov    (%r9),%r11
    deb5:	4d 85 db             	test   %r11,%r11
    deb8:	0f 84 b6 02 00 00    	je     e174 <tp_value+0xf24>
    debe:	48 89 f3             	mov    %rsi,%rbx
    dec1:	49 8b 03             	mov    (%r11),%rax
    dec4:	48 f7 d0             	not    %rax
    dec7:	49 89 01             	mov    %rax,(%r9)
    deca:	e9 0b 05 00 00       	jmp    e3da <tp_value+0x118a>
    decf:	48 8d 74 24 50       	lea    0x50(%rsp),%rsi
    ded4:	ba 80 00 00 00       	mov    $0x80,%edx
    ded9:	4c 89 f7             	mov    %r14,%rdi
    dedc:	e8 0f 19 00 00       	call   f7f0 <tp_token>
    dee1:	49 89 c4             	mov    %rax,%r12
    dee4:	4c 8d 34 04          	lea    (%rsp,%rax,1),%r14
    dee8:	49 83 c6 50          	add    $0x50,%r14
    deec:	31 db                	xor    %ebx,%ebx
    deee:	eb 0d                	jmp    defd <tp_value+0xcad>
    def0:	48 ff c3             	inc    %rbx
    def3:	48 83 fb 06          	cmp    $0x6,%rbx
    def7:	0f 84 68 0a 00 00    	je     e965 <tp_value+0x1715>
    defd:	49 89 df             	mov    %rbx,%r15
    df00:	49 c1 e7 04          	shl    $0x4,%r15
    df04:	48 8d 05 35 ad 00 00 	lea    0xad35(%rip),%rax        # 18c40 <tp_value.units>
    df0b:	49 8b 2c 07          	mov    (%r15,%rax,1),%rbp
    df0f:	48 89 ef             	mov    %rbp,%rdi
    df12:	e8 59 52 ff ff       	call   3170 <strlen@plt>
    df17:	4d 89 e5             	mov    %r12,%r13
    df1a:	49 29 c5             	sub    %rax,%r13
    df1d:	76 d1                	jbe    def0 <tp_value+0xca0>
    df1f:	4c 89 f7             	mov    %r14,%rdi
    df22:	48 29 c7             	sub    %rax,%rdi
    df25:	48 89 ee             	mov    %rbp,%rsi
    df28:	e8 a3 53 ff ff       	call   32d0 <strcmp@plt>
    df2d:	85 c0                	test   %eax,%eax
    df2f:	75 bf                	jne    def0 <tp_value+0xca0>
    df31:	48 8d bc 24 50 01 00 	lea    0x150(%rsp),%rdi
    df38:	00 
    df39:	48 8d 74 24 50       	lea    0x50(%rsp),%rsi
    df3e:	4c 89 ea             	mov    %r13,%rdx
    df41:	e8 ea 53 ff ff       	call   3330 <memcpy@plt>
    df46:	42 c6 84 2c 50 01 00 	movb   $0x0,0x150(%rsp,%r13,1)
    df4d:	00 00 
    df4f:	0f b6 b4 24 50 01 00 	movzbl 0x150(%rsp),%esi
    df56:	00 
    df57:	8d 46 d5             	lea    -0x2b(%rsi),%eax
    df5a:	31 c9                	xor    %ecx,%ecx
    df5c:	a8 fd                	test   $0xfd,%al
    df5e:	0f 94 c1             	sete   %cl
    df61:	49 39 cd             	cmp    %rcx,%r13
    df64:	74 8a                	je     def0 <tp_value+0xca0>
    df66:	76 1c                	jbe    df84 <tp_value+0xd34>
    df68:	0f b6 94 0c 50 01 00 	movzbl 0x150(%rsp,%rcx,1),%edx
    df6f:	00 
    df70:	80 c2 c6             	add    $0xc6,%dl
    df73:	80 fa f6             	cmp    $0xf6,%dl
    df76:	0f 82 74 ff ff ff    	jb     def0 <tp_value+0xca0>
    df7c:	48 ff c1             	inc    %rcx
    df7f:	49 39 cd             	cmp    %rcx,%r13
    df82:	75 e4                	jne    df68 <tp_value+0xd18>
    df84:	31 c9                	xor    %ecx,%ecx
    df86:	a8 fd                	test   $0xfd,%al
    df88:	0f 94 c1             	sete   %cl
    df8b:	44 0f b6 94 0c 50 01 	movzbl 0x150(%rsp,%rcx,1),%r10d
    df92:	00 00 
    df94:	45 31 f6             	xor    %r14d,%r14d
    df97:	45 84 d2             	test   %r10b,%r10b
    df9a:	0f 84 21 06 00 00    	je     e5c1 <tp_value+0x1371>
    dfa0:	48 8d 84 24 50 01 00 	lea    0x150(%rsp),%rax
    dfa7:	00 
    dfa8:	48 01 c1             	add    %rax,%rcx
    dfab:	48 ff c1             	inc    %rcx
    dfae:	31 c0                	xor    %eax,%eax
    dfb0:	bf 0a 00 00 00       	mov    $0xa,%edi
    dfb5:	49 b9 00 00 00 00 00 	movabs $0x8000000000000000,%r9
    dfbc:	00 00 80 
    dfbf:	45 31 c0             	xor    %r8d,%r8d
    dfc2:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    dfc7:	48 f7 e7             	mul    %rdi
    dfca:	4f 8d 04 80          	lea    (%r8,%r8,4),%r8
    dfce:	4a 8d 14 42          	lea    (%rdx,%r8,2),%rdx
    dfd2:	45 0f be c2          	movsbl %r10b,%r8d
    dfd6:	41 83 c0 d0          	add    $0xffffffd0,%r8d
    dfda:	4d 63 d0             	movslq %r8d,%r10
    dfdd:	4d 89 d0             	mov    %r10,%r8
    dfe0:	49 c1 f8 3f          	sar    $0x3f,%r8
    dfe4:	4c 01 d0             	add    %r10,%rax
    dfe7:	49 11 d0             	adc    %rdx,%r8
    dfea:	49 39 c1             	cmp    %rax,%r9
    dfed:	ba 00 00 00 00       	mov    $0x0,%edx
    dff2:	4c 19 c2             	sbb    %r8,%rdx
    dff5:	0f 8c 6a 09 00 00    	jl     e965 <tp_value+0x1715>
    dffb:	44 0f b6 11          	movzbl (%rcx),%r10d
    dfff:	48 ff c1             	inc    %rcx
    e002:	45 84 d2             	test   %r10b,%r10b
    e005:	75 c0                	jne    dfc7 <tp_value+0xd77>
    e007:	e9 bf 05 00 00       	jmp    e5cb <tp_value+0x137b>
    e00c:	49 83 c7 05          	add    $0x5,%r15
    e010:	4c 89 7f 10          	mov    %r15,0x10(%rdi)
    e014:	48 8d 35 d6 68 00 00 	lea    0x68d6(%rip),%rsi        # 148f1 <exec_in_fp0+0xe1>
    e01b:	48 8d 15 81 78 00 00 	lea    0x7881(%rip),%rdx        # 158a3 <exec_in_fp0+0x1093>
    e022:	48 8d 0d 87 17 00 00 	lea    0x1787(%rip),%rcx        # f7b0 <tp_byte_item>
    e029:	4c 8d 44 24 50       	lea    0x50(%rsp),%r8
    e02e:	e8 7d 15 00 00       	call   f5b0 <tp_list_of>
    e033:	85 c0                	test   %eax,%eax
    e035:	74 77                	je     e0ae <tp_value+0xe5e>
    e037:	66 0f ef c0          	pxor   %xmm0,%xmm0
    e03b:	66 0f 7f 84 24 50 01 	movdqa %xmm0,0x150(%rsp)
    e042:	00 00 
    e044:	48 c7 84 24 60 01 00 	movq   $0x0,0x160(%rsp)
    e04b:	00 00 00 00 00 
    e050:	48 83 7c 24 68 00    	cmpq   $0x0,0x68(%rsp)
    e056:	74 36                	je     e08e <tp_value+0xe3e>
    e058:	31 db                	xor    %ebx,%ebx
    e05a:	4c 8d b4 24 50 01 00 	lea    0x150(%rsp),%r14
    e061:	00 
    e062:	4c 8d 7c 24 38       	lea    0x38(%rsp),%r15
    e067:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
    e06c:	0f b6 04 d8          	movzbl (%rax,%rbx,8),%eax
    e070:	88 44 24 38          	mov    %al,0x38(%rsp)
    e074:	ba 01 00 00 00       	mov    $0x1,%edx
    e079:	4c 89 f7             	mov    %r14,%rdi
    e07c:	4c 89 fe             	mov    %r15,%rsi
    e07f:	e8 8c ec ff ff       	call   cd10 <buf_put>
    e084:	48 ff c3             	inc    %rbx
    e087:	48 3b 5c 24 68       	cmp    0x68(%rsp),%rbx
    e08c:	72 d9                	jb     e067 <tp_value+0xe17>
    e08e:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
    e093:	e8 e8 c4 ff ff       	call   a580 <fwp_mem_free>
    e098:	48 8d bc 24 50 01 00 	lea    0x150(%rsp),%rdi
    e09f:	00 
    e0a0:	e8 5b ed ff ff       	call   ce00 <buf_to_str>
    e0a5:	49 89 04 24          	mov    %rax,(%r12)
    e0a9:	e9 63 f7 ff ff       	jmp    d811 <tp_value+0x5c1>
    e0ae:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
    e0b3:	e8 c8 c4 ff ff       	call   a580 <fwp_mem_free>
    e0b8:	e9 5a f7 ff ff       	jmp    d817 <tp_value+0x5c7>
    e0bd:	f2 0f 10 05 03 61 00 	movsd  0x6103(%rip),%xmm0        # 141c8 <_IO_stdin_used+0x1c8>
    e0c4:	00 
    e0c5:	83 39 0a             	cmpl   $0xa,(%rcx)
    e0c8:	f2 0f 5a c8          	cvtsd2ss %xmm0,%xmm1
    e0cc:	66 0f 7e c9          	movd   %xmm1,%ecx
    e0d0:	66 48 0f 7e c0       	movq   %xmm0,%rax
    e0d5:	48 0f 44 c1          	cmove  %rcx,%rax
    e0d9:	49 89 04 24          	mov    %rax,(%r12)
    e0dd:	e9 2f f7 ff ff       	jmp    d811 <tp_value+0x5c1>
    e0e2:	4d 8b 8c ce 90 07 00 	mov    0x790(%r14,%rcx,8),%r9
    e0e9:	00 
    e0ea:	4d 8b 84 ce 98 07 00 	mov    0x798(%r14,%rcx,8),%r8
    e0f1:	00 
    e0f2:	4d 29 c8             	sub    %r9,%r8
    e0f5:	49 39 d0             	cmp    %rdx,%r8
    e0f8:	0f 83 05 01 00 00    	jae    e203 <tp_value+0xfb3>
    e0fe:	48 89 f5             	mov    %rsi,%rbp
    e101:	48 89 fb             	mov    %rdi,%rbx
    e104:	48 89 c7             	mov    %rax,%rdi
    e107:	be 02 00 00 00       	mov    $0x2,%esi
    e10c:	e8 0f 9c ff ff       	call   7d20 <fwp_gc_alloc_slow>
    e111:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    e116:	4c 8b 25 0b cc 00 00 	mov    0xcc0b(%rip),%r12        # 1ad28 <measured_calls>
    e11d:	4c 8b 2d 0c cc 00 00 	mov    0xcc0c(%rip),%r13        # 1ad30 <measured_bytes>
    e124:	e9 00 01 00 00       	jmp    e229 <tp_value+0xfd9>
    e129:	48 85 c0             	test   %rax,%rax
    e12c:	40 0f 95 c6          	setne  %sil
    e130:	80 c2 d5             	add    $0xd5,%dl
    e133:	f6 c2 fd             	test   $0xfd,%dl
    e136:	0f 94 c2             	sete   %dl
    e139:	40 20 f2             	and    %sil,%dl
    e13c:	0f b6 f2             	movzbl %dl,%esi
    e13f:	41 b0 01             	mov    $0x1,%r8b
    e142:	48 89 f7             	mov    %rsi,%rdi
    e145:	48 39 f0             	cmp    %rsi,%rax
    e148:	0f 86 70 02 00 00    	jbe    e3be <tp_value+0x116e>
    e14e:	0f b6 54 3c 50       	movzbl 0x50(%rsp,%rdi,1),%edx
    e153:	44 8d 4a d0          	lea    -0x30(%rdx),%r9d
    e157:	41 80 f9 09          	cmp    $0x9,%r9b
    e15b:	0f 87 0f 05 00 00    	ja     e670 <tp_value+0x1420>
    e161:	48 ff c7             	inc    %rdi
    e164:	48 39 f8             	cmp    %rdi,%rax
    e167:	75 e5                	jne    e14e <tp_value+0xefe>
    e169:	48 89 c7             	mov    %rax,%rdi
    e16c:	48 89 c2             	mov    %rax,%rdx
    e16f:	e9 fc 07 00 00       	jmp    e970 <tp_value+0x1720>
    e174:	4e 8b 9c c0 90 07 00 	mov    0x790(%rax,%r8,8),%r11
    e17b:	00 
    e17c:	4e 8b 8c c0 98 07 00 	mov    0x798(%rax,%r8,8),%r9
    e183:	00 
    e184:	4d 29 d9             	sub    %r11,%r9
    e187:	49 39 d1             	cmp    %rdx,%r9
    e18a:	0f 83 36 02 00 00    	jae    e3c6 <tp_value+0x1176>
    e190:	48 89 f3             	mov    %rsi,%rbx
    e193:	be 02 00 00 00       	mov    $0x2,%esi
    e198:	e8 83 9b ff ff       	call   7d20 <fwp_gc_alloc_slow>
    e19d:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    e1a2:	e9 42 02 00 00       	jmp    e3e9 <tp_value+0x1199>
    e1a7:	48 8d 35 d3 74 00 00 	lea    0x74d3(%rip),%rsi        # 15681 <exec_in_fp0+0xe71>
    e1ae:	49 89 ff             	mov    %rdi,%r15
    e1b1:	e8 5a 13 00 00       	call   f510 <tp_eat>
    e1b6:	85 c0                	test   %eax,%eax
    e1b8:	0f 84 59 f6 ff ff    	je     d817 <tp_value+0x5c7>
    e1be:	48 8d 35 7d 75 00 00 	lea    0x757d(%rip),%rsi        # 15742 <exec_in_fp0+0xf32>
    e1c5:	4c 89 ff             	mov    %r15,%rdi
    e1c8:	e8 43 13 00 00       	call   f510 <tp_eat>
    e1cd:	85 c0                	test   %eax,%eax
    e1cf:	0f 84 42 f6 ff ff    	je     d817 <tp_value+0x5c7>
    e1d5:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    e1da:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    e1e1:	e9 2b f6 ff ff       	jmp    d811 <tp_value+0x5c1>
    e1e6:	31 ff                	xor    %edi,%edi
    e1e8:	4c 89 fe             	mov    %r15,%rsi
    e1eb:	e8 e0 72 ff ff       	call   54d0 <fwp_array_new_packed>
    e1f0:	49 89 c6             	mov    %rax,%r14
    e1f3:	e9 46 05 00 00       	jmp    e73e <tp_value+0x14ee>
    e1f8:	31 c9                	xor    %ecx,%ecx
    e1fa:	49 89 0c 24          	mov    %rcx,(%r12)
    e1fe:	e9 0e f6 ff ff       	jmp    d811 <tp_value+0x5c1>
    e203:	48 89 f5             	mov    %rsi,%rbp
    e206:	48 89 fb             	mov    %rdi,%rbx
    e209:	49 8d 04 ce          	lea    (%r14,%rcx,8),%rax
    e20d:	48 05 90 07 00 00    	add    $0x790,%rax
    e213:	49 8d 0c 11          	lea    (%r9,%rdx,1),%rcx
    e217:	48 89 08             	mov    %rcx,(%rax)
    e21a:	4c 89 4c 24 20       	mov    %r9,0x20(%rsp)
    e21f:	4c 89 cf             	mov    %r9,%rdi
    e222:	31 f6                	xor    %esi,%esi
    e224:	e8 e7 4f ff ff       	call   3210 <memset@plt>
    e229:	49 63 07             	movslq (%r15),%rax
    e22c:	48 8d 50 01          	lea    0x1(%rax),%rdx
    e230:	49 ff c4             	inc    %r12
    e233:	4c 89 25 ee ca 00 00 	mov    %r12,0xcaee(%rip)        # 1ad28 <measured_calls>
    e23a:	4a 8d 0c 28          	lea    (%rax,%r13,1),%rcx
    e23e:	48 ff c1             	inc    %rcx
    e241:	48 89 0d e8 ca 00 00 	mov    %rcx,0xcae8(%rip)        # 1ad30 <measured_bytes>
    e248:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    e24f:	77 5d                	ja     e2ae <tp_value+0x105e>
    e251:	48 83 c0 10          	add    $0x10,%rax
    e255:	48 c1 e8 04          	shr    $0x4,%rax
    e259:	42 0f b6 8c 30 e8 0b 	movzbl 0xbe8(%rax,%r14,1),%ecx
    e260:	00 00 
    e262:	41 8b 84 8e 48 0b 00 	mov    0xb48(%r14,%rcx,4),%eax
    e269:	00 
    e26a:	48 29 05 17 b0 00 00 	sub    %rax,0xb017(%rip)        # 19288 <fwp_gc>
    e271:	78 3b                	js     e2ae <tp_value+0x105e>
    e273:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    e277:	49 8d 34 ce          	lea    (%r14,%rcx,8),%rsi
    e27b:	48 81 c6 c8 03 00 00 	add    $0x3c8,%rsi
    e282:	4c 8b 26             	mov    (%rsi),%r12
    e285:	4d 85 e4             	test   %r12,%r12
    e288:	74 0c                	je     e296 <tp_value+0x1046>
    e28a:	49 8b 04 24          	mov    (%r12),%rax
    e28e:	48 f7 d0             	not    %rax
    e291:	48 89 06             	mov    %rax,(%rsi)
    e294:	eb 3b                	jmp    e2d1 <tp_value+0x1081>
    e296:	4d 8b a4 ce d0 03 00 	mov    0x3d0(%r14,%rcx,8),%r12
    e29d:	00 
    e29e:	49 8b b4 ce d8 03 00 	mov    0x3d8(%r14,%rcx,8),%rsi
    e2a5:	00 
    e2a6:	4c 29 e6             	sub    %r12,%rsi
    e2a9:	48 39 c6             	cmp    %rax,%rsi
    e2ac:	73 12                	jae    e2c0 <tp_value+0x1070>
    e2ae:	48 89 d7             	mov    %rdx,%rdi
    e2b1:	be 01 00 00 00       	mov    $0x1,%esi
    e2b6:	e8 65 9a ff ff       	call   7d20 <fwp_gc_alloc_slow>
    e2bb:	49 89 c4             	mov    %rax,%r12
    e2be:	eb 1b                	jmp    e2db <tp_value+0x108b>
    e2c0:	49 8d 0c ce          	lea    (%r14,%rcx,8),%rcx
    e2c4:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
    e2cb:	4c 01 e0             	add    %r12,%rax
    e2ce:	48 89 01             	mov    %rax,(%rcx)
    e2d1:	4c 89 e7             	mov    %r12,%rdi
    e2d4:	31 f6                	xor    %esi,%esi
    e2d6:	e8 35 4f ff ff       	call   3210 <memset@plt>
    e2db:	49 63 17             	movslq (%r15),%rdx
    e2de:	48 ff c2             	inc    %rdx
    e2e1:	45 31 f6             	xor    %r14d,%r14d
    e2e4:	4c 89 e7             	mov    %r12,%rdi
    e2e7:	31 f6                	xor    %esi,%esi
    e2e9:	e8 22 4f ff ff       	call   3210 <memset@plt>
    e2ee:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    e2f2:	48 8b 43 10          	mov    0x10(%rbx),%rax
    e2f6:	48 39 c8             	cmp    %rcx,%rax
    e2f9:	73 2e                	jae    e329 <tp_value+0x10d9>
    e2fb:	48 8b 13             	mov    (%rbx),%rdx
    e2fe:	48 be 00 26 00 00 01 	movabs $0x100002600,%rsi
    e305:	00 00 00 
    e308:	0f b6 3c 02          	movzbl (%rdx,%rax,1),%edi
    e30c:	48 83 ff 20          	cmp    $0x20,%rdi
    e310:	77 17                	ja     e329 <tp_value+0x10d9>
    e312:	48 0f a3 fe          	bt     %rdi,%rsi
    e316:	73 11                	jae    e329 <tp_value+0x10d9>
    e318:	48 ff c0             	inc    %rax
    e31b:	48 89 43 10          	mov    %rax,0x10(%rbx)
    e31f:	48 39 c1             	cmp    %rax,%rcx
    e322:	75 e4                	jne    e308 <tp_value+0x10b8>
    e324:	e9 ee f4 ff ff       	jmp    d817 <tp_value+0x5c7>
    e329:	48 39 c1             	cmp    %rax,%rcx
    e32c:	0f 84 e5 f4 ff ff    	je     d817 <tp_value+0x5c7>
    e332:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
    e337:	48 8b 0b             	mov    (%rbx),%rcx
    e33a:	80 3c 01 7b          	cmpb   $0x7b,(%rcx,%rax,1)
    e33e:	0f 85 d3 f4 ff ff    	jne    d817 <tp_value+0x5c7>
    e344:	48 ff c0             	inc    %rax
    e347:	48 89 43 10          	mov    %rax,0x10(%rbx)
    e34b:	48 8d 35 30 66 00 00 	lea    0x6630(%rip),%rsi        # 14982 <exec_in_fp0+0x172>
    e352:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
    e357:	48 89 df             	mov    %rbx,%rdi
    e35a:	e8 b1 11 00 00       	call   f510 <tp_eat>
    e35f:	85 c0                	test   %eax,%eax
    e361:	0f 84 e0 03 00 00    	je     e747 <tp_value+0x14f7>
    e367:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    e36c:	8b 38                	mov    (%rax),%edi
    e36e:	85 ff                	test   %edi,%edi
    e370:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
    e375:	48 8b 74 24 20       	mov    0x20(%rsp),%rsi
    e37a:	7e 18                	jle    e394 <tp_value+0x1144>
    e37c:	45 31 f6             	xor    %r14d,%r14d
    e37f:	31 c0                	xor    %eax,%eax
    e381:	41 80 3c 04 00       	cmpb   $0x0,(%r12,%rax,1)
    e386:	0f 84 8b f4 ff ff    	je     d817 <tp_value+0x5c7>
    e38c:	48 ff c0             	inc    %rax
    e38f:	48 39 c7             	cmp    %rax,%rdi
    e392:	75 ed                	jne    e381 <tp_value+0x1131>
    e394:	e8 17 19 00 00       	call   fcb0 <fwp_record>
    e399:	48 89 03             	mov    %rax,(%rbx)
    e39c:	e9 70 f4 ff ff       	jmp    d811 <tp_value+0x5c1>
    e3a1:	48 8d 05 e8 c9 01 00 	lea    0x1c9e8(%rip),%rax        # 2ad90 <fwp_empty_map>
    e3a8:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
    e3ad:	48 89 c3             	mov    %rax,%rbx
    e3b0:	e8 cb c1 ff ff       	call   a580 <fwp_mem_free>
    e3b5:	49 89 1c 24          	mov    %rbx,(%r12)
    e3b9:	e9 53 f4 ff ff       	jmp    d811 <tp_value+0x5c1>
    e3be:	48 89 f2             	mov    %rsi,%rdx
    e3c1:	e9 aa 05 00 00       	jmp    e970 <tp_value+0x1720>
    e3c6:	48 89 f3             	mov    %rsi,%rbx
    e3c9:	4a 8d 04 c0          	lea    (%rax,%r8,8),%rax
    e3cd:	48 05 90 07 00 00    	add    $0x790,%rax
    e3d3:	49 8d 0c 13          	lea    (%r11,%rdx,1),%rcx
    e3d7:	48 89 08             	mov    %rcx,(%rax)
    e3da:	4c 89 5c 24 08       	mov    %r11,0x8(%rsp)
    e3df:	4c 89 df             	mov    %r11,%rdi
    e3e2:	31 f6                	xor    %esi,%esi
    e3e4:	e8 27 4e ff ff       	call   3210 <memset@plt>
    e3e9:	4c 89 7c 24 28       	mov    %r15,0x28(%rsp)
    e3ee:	45 85 ff             	test   %r15d,%r15d
    e3f1:	0f 8e 60 01 00 00    	jle    e557 <tp_value+0x1307>
    e3f7:	48 89 d8             	mov    %rbx,%rax
    e3fa:	31 db                	xor    %ebx,%ebx
    e3fc:	49 bf 00 26 00 00 01 	movabs $0x100002600,%r15
    e403:	00 00 00 
    e406:	4c 89 74 24 30       	mov    %r14,0x30(%rsp)
    e40b:	48 8b 48 30          	mov    0x30(%rax),%rcx
    e40f:	4a 8b 0c f1          	mov    (%rcx,%r14,8),%rcx
    e413:	48 8b 34 d9          	mov    (%rcx,%rbx,8),%rsi
    e417:	49 8b 7d 08          	mov    0x8(%r13),%rdi
    e41b:	49 8b 55 10          	mov    0x10(%r13),%rdx
    e41f:	48 39 fa             	cmp    %rdi,%rdx
    e422:	73 2c                	jae    e450 <tp_value+0x1200>
    e424:	49 8b 4d 00          	mov    0x0(%r13),%rcx
    e428:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    e42f:	00 
    e430:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    e435:	49 83 f8 20          	cmp    $0x20,%r8
    e439:	77 15                	ja     e450 <tp_value+0x1200>
    e43b:	4d 0f a3 c7          	bt     %r8,%r15
    e43f:	73 0f                	jae    e450 <tp_value+0x1200>
    e441:	48 ff c2             	inc    %rdx
    e444:	49 89 55 10          	mov    %rdx,0x10(%r13)
    e448:	48 39 d7             	cmp    %rdx,%rdi
    e44b:	75 e3                	jne    e430 <tp_value+0x11e0>
    e44d:	48 89 fa             	mov    %rdi,%rdx
    e450:	83 3e 10             	cmpl   $0x10,(%rsi)
    e453:	75 0b                	jne    e460 <tp_value+0x1210>
    e455:	48 83 7e 08 00       	cmpq   $0x0,0x8(%rsi)
    e45a:	0f 84 b4 00 00 00    	je     e514 <tp_value+0x12c4>
    e460:	45 31 c0             	xor    %r8d,%r8d
    e463:	49 89 c4             	mov    %rax,%r12
    e466:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    e46b:	48 8d 0c d8          	lea    (%rax,%rbx,8),%rcx
    e46f:	48 39 fa             	cmp    %rdi,%rdx
    e472:	73 10                	jae    e484 <tp_value+0x1234>
    e474:	49 8b 45 00          	mov    0x0(%r13),%rax
    e478:	80 3c 10 28          	cmpb   $0x28,(%rax,%rdx,1)
    e47c:	0f 95 c0             	setne  %al
    e47f:	44 08 c0             	or     %r8b,%al
    e482:	74 35                	je     e4b9 <tp_value+0x1269>
    e484:	45 31 f6             	xor    %r14d,%r14d
    e487:	4c 89 ef             	mov    %r13,%rdi
    e48a:	31 d2                	xor    %edx,%edx
    e48c:	e8 bf ed ff ff       	call   d250 <tp_value>
    e491:	85 c0                	test   %eax,%eax
    e493:	4c 89 e0             	mov    %r12,%rax
    e496:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    e49b:	0f 84 76 f3 ff ff    	je     d817 <tp_value+0x5c7>
    e4a1:	48 ff c3             	inc    %rbx
    e4a4:	48 3b 5c 24 20       	cmp    0x20(%rsp),%rbx
    e4a9:	4c 8b 74 24 30       	mov    0x30(%rsp),%r14
    e4ae:	0f 85 57 ff ff ff    	jne    e40b <tp_value+0x11bb>
    e4b4:	e9 9e 00 00 00       	jmp    e557 <tp_value+0x1307>
    e4b9:	48 ff c2             	inc    %rdx
    e4bc:	49 89 55 10          	mov    %rdx,0x10(%r13)
    e4c0:	45 31 f6             	xor    %r14d,%r14d
    e4c3:	4c 89 ef             	mov    %r13,%rdi
    e4c6:	31 d2                	xor    %edx,%edx
    e4c8:	e8 83 ed ff ff       	call   d250 <tp_value>
    e4cd:	85 c0                	test   %eax,%eax
    e4cf:	0f 84 42 f3 ff ff    	je     d817 <tp_value+0x5c7>
    e4d5:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
    e4da:	49 8b 55 08          	mov    0x8(%r13),%rdx
    e4de:	49 8b 4d 10          	mov    0x10(%r13),%rcx
    e4e2:	48 39 d1             	cmp    %rdx,%rcx
    e4e5:	4c 89 e0             	mov    %r12,%rax
    e4e8:	73 3d                	jae    e527 <tp_value+0x12d7>
    e4ea:	49 8b 75 00          	mov    0x0(%r13),%rsi
    e4ee:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    e4f3:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
    e4f7:	48 83 ff 20          	cmp    $0x20,%rdi
    e4fb:	77 2f                	ja     e52c <tp_value+0x12dc>
    e4fd:	49 0f a3 ff          	bt     %rdi,%r15
    e501:	73 29                	jae    e52c <tp_value+0x12dc>
    e503:	48 ff c1             	inc    %rcx
    e506:	49 89 4d 10          	mov    %rcx,0x10(%r13)
    e50a:	48 39 ca             	cmp    %rcx,%rdx
    e50d:	75 e4                	jne    e4f3 <tp_value+0x12a3>
    e50f:	e9 03 f3 ff ff       	jmp    d817 <tp_value+0x5c7>
    e514:	83 7e 10 00          	cmpl   $0x0,0x10(%rsi)
    e518:	74 35                	je     e54f <tp_value+0x12ff>
    e51a:	83 7e 48 00          	cmpl   $0x0,0x48(%rsi)
    e51e:	41 0f 95 c0          	setne  %r8b
    e522:	e9 3c ff ff ff       	jmp    e463 <tp_value+0x1213>
    e527:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    e52c:	48 39 ca             	cmp    %rcx,%rdx
    e52f:	0f 84 e2 f2 ff ff    	je     d817 <tp_value+0x5c7>
    e535:	49 8b 55 00          	mov    0x0(%r13),%rdx
    e539:	80 3c 0a 29          	cmpb   $0x29,(%rdx,%rcx,1)
    e53d:	0f 85 d4 f2 ff ff    	jne    d817 <tp_value+0x5c7>
    e543:	48 ff c1             	inc    %rcx
    e546:	49 89 4d 10          	mov    %rcx,0x10(%r13)
    e54a:	e9 52 ff ff ff       	jmp    e4a1 <tp_value+0x1251>
    e54f:	41 b0 01             	mov    $0x1,%r8b
    e552:	e9 0c ff ff ff       	jmp    e463 <tp_value+0x1213>
    e557:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
    e55c:	45 85 ff             	test   %r15d,%r15d
    e55f:	0f 84 d9 01 00 00    	je     e73e <tp_value+0x14ee>
    e565:	48 8b 5c 24 20       	mov    0x20(%rsp),%rbx
    e56a:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    e571:	00 
    e572:	e8 c9 bc ff ff       	call   a240 <fwp_alloc_init>
    e577:	49 89 c6             	mov    %rax,%r14
    e57a:	89 28                	mov    %ebp,(%rax)
    e57c:	44 89 78 04          	mov    %r15d,0x4(%rax)
    e580:	41 83 ff 08          	cmp    $0x8,%r15d
    e584:	73 1b                	jae    e5a1 <tp_value+0x1351>
    e586:	31 c0                	xor    %eax,%eax
    e588:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    e58d:	e9 53 01 00 00       	jmp    e6e5 <tp_value+0x1495>
    e592:	4d 01 fd             	add    %r15,%r13
    e595:	4c 89 f7             	mov    %r14,%rdi
    e598:	4d 89 6e 10          	mov    %r13,0x10(%r14)
    e59c:	e9 9c f4 ff ff       	jmp    da3d <tp_value+0x7ed>
    e5a1:	4c 89 f0             	mov    %r14,%rax
    e5a4:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    e5a9:	48 29 f8             	sub    %rdi,%rax
    e5ac:	48 83 c0 08          	add    $0x8,%rax
    e5b0:	48 83 f8 20          	cmp    $0x20,%rax
    e5b4:	0f 83 f3 00 00 00    	jae    e6ad <tp_value+0x145d>
    e5ba:	31 c0                	xor    %eax,%eax
    e5bc:	e9 24 01 00 00       	jmp    e6e5 <tp_value+0x1495>
    e5c1:	31 c0                	xor    %eax,%eax
    e5c3:	45 31 c0             	xor    %r8d,%r8d
    e5c6:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    e5cb:	48 89 c1             	mov    %rax,%rcx
    e5ce:	48 f7 d9             	neg    %rcx
    e5d1:	bf 00 00 00 00       	mov    $0x0,%edi
    e5d6:	4c 19 c7             	sbb    %r8,%rdi
    e5d9:	40 80 fe 2d          	cmp    $0x2d,%sil
    e5dd:	49 0f 45 f8          	cmovne %r8,%rdi
    e5e1:	48 0f 45 c8          	cmovne %rax,%rcx
    e5e5:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    e5ec:	ff ff 7f 
    e5ef:	48 39 c8             	cmp    %rcx,%rax
    e5f2:	b8 00 00 00 00       	mov    $0x0,%eax
    e5f7:	48 19 f8             	sbb    %rdi,%rax
    e5fa:	0f 8c 17 f2 ff ff    	jl     d817 <tp_value+0x5c7>
    e600:	48 8d 05 39 a6 00 00 	lea    0xa639(%rip),%rax        # 18c40 <tp_value.units>
    e607:	49 8b 74 07 08       	mov    0x8(%r15,%rax,1),%rsi
    e60c:	48 89 c8             	mov    %rcx,%rax
    e60f:	48 f7 e6             	mul    %rsi
    e612:	48 0f af fe          	imul   %rsi,%rdi
    e616:	48 c1 fe 3f          	sar    $0x3f,%rsi
    e61a:	48 0f af f1          	imul   %rcx,%rsi
    e61e:	48 01 d7             	add    %rdx,%rdi
    e621:	48 01 f7             	add    %rsi,%rdi
    e624:	48 b9 00 00 00 00 00 	movabs $0x8000000000000000,%rcx
    e62b:	00 00 80 
    e62e:	48 01 c1             	add    %rax,%rcx
    e631:	48 83 d7 ff          	adc    $0xffffffffffffffff,%rdi
    e635:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
    e639:	0f 85 d8 f1 ff ff    	jne    d817 <tp_value+0x5c7>
    e63f:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    e644:	bf 10 00 00 00       	mov    $0x10,%edi
    e649:	48 89 c3             	mov    %rax,%rbx
    e64c:	e8 ef bb ff ff       	call   a240 <fwp_alloc_init>
    e651:	48 b9 00 00 00 00 01 	movabs $0x100000000,%rcx
    e658:	00 00 00 
    e65b:	48 89 08             	mov    %rcx,(%rax)
    e65e:	48 89 58 08          	mov    %rbx,0x8(%rax)
    e662:	48 8d 4c 24 38       	lea    0x38(%rsp),%rcx
    e667:	49 89 04 24          	mov    %rax,(%r12)
    e66b:	e9 a1 f1 ff ff       	jmp    d811 <tp_value+0x5c1>
    e670:	80 fa 2e             	cmp    $0x2e,%dl
    e673:	0f 85 f4 02 00 00    	jne    e96d <tp_value+0x171d>
    e679:	48 8d 57 01          	lea    0x1(%rdi),%rdx
    e67d:	48 39 c2             	cmp    %rax,%rdx
    e680:	73 1b                	jae    e69d <tp_value+0x144d>
    e682:	44 0f b6 44 14 50    	movzbl 0x50(%rsp,%rdx,1),%r8d
    e688:	41 80 c0 d0          	add    $0xd0,%r8b
    e68c:	41 80 f8 09          	cmp    $0x9,%r8b
    e690:	77 0b                	ja     e69d <tp_value+0x144d>
    e692:	48 ff c2             	inc    %rdx
    e695:	48 39 c2             	cmp    %rax,%rdx
    e698:	72 e8                	jb     e682 <tp_value+0x1432>
    e69a:	48 89 c2             	mov    %rax,%rdx
    e69d:	4c 8d 42 ff          	lea    -0x1(%rdx),%r8
    e6a1:	49 39 f8             	cmp    %rdi,%r8
    e6a4:	41 0f 94 c0          	sete   %r8b
    e6a8:	e9 c3 02 00 00       	jmp    e970 <tp_value+0x1720>
    e6ad:	89 d8                	mov    %ebx,%eax
    e6af:	83 e0 fc             	and    $0xfffffffc,%eax
    e6b2:	48 8d 0c dd 00 00 00 	lea    0x0(,%rbx,8),%rcx
    e6b9:	00 
    e6ba:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    e6be:	31 d2                	xor    %edx,%edx
    e6c0:	f3 0f 6f 04 17       	movdqu (%rdi,%rdx,1),%xmm0
    e6c5:	0f 10 4c 17 10       	movups 0x10(%rdi,%rdx,1),%xmm1
    e6ca:	f3 41 0f 7f 44 16 08 	movdqu %xmm0,0x8(%r14,%rdx,1)
    e6d1:	41 0f 11 4c 16 18    	movups %xmm1,0x18(%r14,%rdx,1)
    e6d7:	48 83 c2 20          	add    $0x20,%rdx
    e6db:	48 39 d1             	cmp    %rdx,%rcx
    e6de:	75 e0                	jne    e6c0 <tp_value+0x1470>
    e6e0:	48 39 d8             	cmp    %rbx,%rax
    e6e3:	74 59                	je     e73e <tp_value+0x14ee>
    e6e5:	48 89 da             	mov    %rbx,%rdx
    e6e8:	48 89 c1             	mov    %rax,%rcx
    e6eb:	48 83 e2 03          	and    $0x3,%rdx
    e6ef:	74 14                	je     e705 <tp_value+0x14b5>
    e6f1:	48 89 c1             	mov    %rax,%rcx
    e6f4:	48 8b 34 cf          	mov    (%rdi,%rcx,8),%rsi
    e6f8:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    e6fd:	48 ff c1             	inc    %rcx
    e700:	48 ff ca             	dec    %rdx
    e703:	75 ef                	jne    e6f4 <tp_value+0x14a4>
    e705:	48 29 d8             	sub    %rbx,%rax
    e708:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    e70c:	77 30                	ja     e73e <tp_value+0x14ee>
    e70e:	48 8b 04 cf          	mov    (%rdi,%rcx,8),%rax
    e712:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    e717:	48 8b 44 cf 08       	mov    0x8(%rdi,%rcx,8),%rax
    e71c:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    e721:	48 8b 44 cf 10       	mov    0x10(%rdi,%rcx,8),%rax
    e726:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    e72b:	48 8b 44 cf 18       	mov    0x18(%rdi,%rcx,8),%rax
    e730:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    e735:	48 83 c1 04          	add    $0x4,%rcx
    e739:	48 39 cb             	cmp    %rcx,%rbx
    e73c:	75 d0                	jne    e70e <tp_value+0x14be>
    e73e:	4d 89 34 24          	mov    %r14,(%r12)
    e742:	e9 ca f0 ff ff       	jmp    d811 <tp_value+0x5c1>
    e747:	4c 89 64 24 40       	mov    %r12,0x40(%rsp)
    e74c:	49 bf 00 26 00 00 01 	movabs $0x100002600,%r15
    e753:	00 00 00 
    e756:	41 b8 ff 00 00 00    	mov    $0xff,%r8d
    e75c:	4c 8d 4c 24 50       	lea    0x50(%rsp),%r9
    e761:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    e766:	48 89 6c 24 48       	mov    %rbp,0x48(%rsp)
    e76b:	4c 8b 21             	mov    (%rcx),%r12
    e76e:	4c 8b 69 08          	mov    0x8(%rcx),%r13
    e772:	48 8b 71 10          	mov    0x10(%rcx),%rsi
    e776:	4c 39 ee             	cmp    %r13,%rsi
    e779:	73 2a                	jae    e7a5 <tp_value+0x1555>
    e77b:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
    e780:	41 0f b6 04 34       	movzbl (%r12,%rsi,1),%eax
    e785:	48 83 f8 20          	cmp    $0x20,%rax
    e789:	77 1f                	ja     e7aa <tp_value+0x155a>
    e78b:	49 0f a3 c7          	bt     %rax,%r15
    e78f:	73 19                	jae    e7aa <tp_value+0x155a>
    e791:	48 ff c6             	inc    %rsi
    e794:	48 89 71 10          	mov    %rsi,0x10(%rcx)
    e798:	49 39 f5             	cmp    %rsi,%r13
    e79b:	75 e3                	jne    e780 <tp_value+0x1530>
    e79d:	4c 89 eb             	mov    %r13,%rbx
    e7a0:	4c 89 ee             	mov    %r13,%rsi
    e7a3:	eb 55                	jmp    e7fa <tp_value+0x15aa>
    e7a5:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
    e7aa:	48 bf 03 00 00 00 00 	movabs $0x4000000000003,%rdi
    e7b1:	00 04 00 
    e7b4:	48 89 f3             	mov    %rsi,%rbx
    e7b7:	4c 39 ee             	cmp    %r13,%rsi
    e7ba:	72 0e                	jb     e7ca <tp_value+0x157a>
    e7bc:	eb 3c                	jmp    e7fa <tp_value+0x15aa>
    e7be:	48 ff c3             	inc    %rbx
    e7c1:	48 89 59 10          	mov    %rbx,0x10(%rcx)
    e7c5:	49 39 dd             	cmp    %rbx,%r13
    e7c8:	74 2d                	je     e7f7 <tp_value+0x15a7>
    e7ca:	41 0f b6 04 1c       	movzbl (%r12,%rbx,1),%eax
    e7cf:	8d 50 d0             	lea    -0x30(%rax),%edx
    e7d2:	80 fa 0a             	cmp    $0xa,%dl
    e7d5:	72 e7                	jb     e7be <tp_value+0x156e>
    e7d7:	89 c2                	mov    %eax,%edx
    e7d9:	80 e2 df             	and    $0xdf,%dl
    e7dc:	80 c2 bf             	add    $0xbf,%dl
    e7df:	80 fa 1a             	cmp    $0x1a,%dl
    e7e2:	72 da                	jb     e7be <tp_value+0x156e>
    e7e4:	0f b6 c0             	movzbl %al,%eax
    e7e7:	83 c0 d3             	add    $0xffffffd3,%eax
    e7ea:	83 f8 32             	cmp    $0x32,%eax
    e7ed:	77 0b                	ja     e7fa <tp_value+0x15aa>
    e7ef:	48 0f a3 c7          	bt     %rax,%rdi
    e7f3:	72 c9                	jb     e7be <tp_value+0x156e>
    e7f5:	eb 03                	jmp    e7fa <tp_value+0x15aa>
    e7f7:	4c 89 eb             	mov    %r13,%rbx
    e7fa:	48 89 dd             	mov    %rbx,%rbp
    e7fd:	48 29 f5             	sub    %rsi,%rbp
    e800:	48 81 fd ff 00 00 00 	cmp    $0xff,%rbp
    e807:	49 0f 43 e8          	cmovae %r8,%rbp
    e80b:	4c 01 e6             	add    %r12,%rsi
    e80e:	4c 89 cf             	mov    %r9,%rdi
    e811:	48 89 ea             	mov    %rbp,%rdx
    e814:	e8 17 4b ff ff       	call   3330 <memcpy@plt>
    e819:	c6 44 2c 50 00       	movb   $0x0,0x50(%rsp,%rbp,1)
    e81e:	45 8b 3e             	mov    (%r14),%r15d
    e821:	45 85 ff             	test   %r15d,%r15d
    e824:	48 8b 44 24 48       	mov    0x48(%rsp),%rax
    e829:	0f 8e 36 01 00 00    	jle    e965 <tp_value+0x1715>
    e82f:	4c 89 6c 24 28       	mov    %r13,0x28(%rsp)
    e834:	4c 89 64 24 30       	mov    %r12,0x30(%rsp)
    e839:	4c 8b 60 18          	mov    0x18(%rax),%r12
    e83d:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    e842:	45 31 f6             	xor    %r14d,%r14d
    e845:	4c 8d 6c 24 50       	lea    0x50(%rsp),%r13
    e84a:	4b 8b 3c f4          	mov    (%r12,%r14,8),%rdi
    e84e:	4c 89 ee             	mov    %r13,%rsi
    e851:	e8 7a 4a ff ff       	call   32d0 <strcmp@plt>
    e856:	85 c0                	test   %eax,%eax
    e858:	41 0f 44 ee          	cmove  %r14d,%ebp
    e85c:	49 ff c6             	inc    %r14
    e85f:	4d 39 f7             	cmp    %r14,%r15
    e862:	75 e6                	jne    e84a <tp_value+0x15fa>
    e864:	85 ed                	test   %ebp,%ebp
    e866:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    e86b:	48 8b 44 24 48       	mov    0x48(%rsp),%rax
    e870:	49 bf 00 26 00 00 01 	movabs $0x100002600,%r15
    e877:	00 00 00 
    e87a:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    e87f:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
    e884:	0f 88 db 00 00 00    	js     e965 <tp_value+0x1715>
    e88a:	48 39 fb             	cmp    %rdi,%rbx
    e88d:	73 21                	jae    e8b0 <tp_value+0x1660>
    e88f:	0f b6 14 1e          	movzbl (%rsi,%rbx,1),%edx
    e893:	48 83 fa 20          	cmp    $0x20,%rdx
    e897:	77 17                	ja     e8b0 <tp_value+0x1660>
    e899:	49 0f a3 d7          	bt     %rdx,%r15
    e89d:	73 11                	jae    e8b0 <tp_value+0x1660>
    e89f:	48 ff c3             	inc    %rbx
    e8a2:	48 89 59 10          	mov    %rbx,0x10(%rcx)
    e8a6:	48 39 df             	cmp    %rbx,%rdi
    e8a9:	75 e4                	jne    e88f <tp_value+0x163f>
    e8ab:	e9 b5 00 00 00       	jmp    e965 <tp_value+0x1715>
    e8b0:	48 39 df             	cmp    %rbx,%rdi
    e8b3:	0f 84 ac 00 00 00    	je     e965 <tp_value+0x1715>
    e8b9:	80 3c 1e 3d          	cmpb   $0x3d,(%rsi,%rbx,1)
    e8bd:	0f 85 a2 00 00 00    	jne    e965 <tp_value+0x1715>
    e8c3:	48 ff c3             	inc    %rbx
    e8c6:	48 89 59 10          	mov    %rbx,0x10(%rcx)
    e8ca:	48 8b 40 20          	mov    0x20(%rax),%rax
    e8ce:	89 eb                	mov    %ebp,%ebx
    e8d0:	48 8b 34 d8          	mov    (%rax,%rbx,8),%rsi
    e8d4:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    e8d9:	48 8d 0c d8          	lea    (%rax,%rbx,8),%rcx
    e8dd:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    e8e2:	31 d2                	xor    %edx,%edx
    e8e4:	e8 67 e9 ff ff       	call   d250 <tp_value>
    e8e9:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    e8ee:	85 c0                	test   %eax,%eax
    e8f0:	74 73                	je     e965 <tp_value+0x1715>
    e8f2:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
    e8f7:	c6 04 18 01          	movb   $0x1,(%rax,%rbx,1)
    e8fb:	48 8b 51 08          	mov    0x8(%rcx),%rdx
    e8ff:	48 8b 41 10          	mov    0x10(%rcx),%rax
    e903:	48 39 d0             	cmp    %rdx,%rax
    e906:	73 21                	jae    e929 <tp_value+0x16d9>
    e908:	48 8b 31             	mov    (%rcx),%rsi
    e90b:	0f b6 3c 06          	movzbl (%rsi,%rax,1),%edi
    e90f:	48 83 ff 20          	cmp    $0x20,%rdi
    e913:	77 14                	ja     e929 <tp_value+0x16d9>
    e915:	49 0f a3 ff          	bt     %rdi,%r15
    e919:	73 0e                	jae    e929 <tp_value+0x16d9>
    e91b:	48 ff c0             	inc    %rax
    e91e:	48 89 41 10          	mov    %rax,0x10(%rcx)
    e922:	48 39 c2             	cmp    %rax,%rdx
    e925:	75 e4                	jne    e90b <tp_value+0x16bb>
    e927:	eb 12                	jmp    e93b <tp_value+0x16eb>
    e929:	48 39 c2             	cmp    %rax,%rdx
    e92c:	74 0d                	je     e93b <tp_value+0x16eb>
    e92e:	48 8b 11             	mov    (%rcx),%rdx
    e931:	80 3c 02 7d          	cmpb   $0x7d,(%rdx,%rax,1)
    e935:	0f 84 db 00 00 00    	je     ea16 <tp_value+0x17c6>
    e93b:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    e940:	48 8d 35 3c 6d 00 00 	lea    0x6d3c(%rip),%rsi        # 15683 <exec_in_fp0+0xe73>
    e947:	e8 c4 0b 00 00       	call   f510 <tp_eat>
    e94c:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    e951:	85 c0                	test   %eax,%eax
    e953:	74 10                	je     e965 <tp_value+0x1715>
    e955:	41 b8 ff 00 00 00    	mov    $0xff,%r8d
    e95b:	4c 8d 4c 24 50       	lea    0x50(%rsp),%r9
    e960:	e9 06 fe ff ff       	jmp    e76b <tp_value+0x151b>
    e965:	45 31 f6             	xor    %r14d,%r14d
    e968:	e9 aa ee ff ff       	jmp    d817 <tp_value+0x5c7>
    e96d:	48 89 fa             	mov    %rdi,%rdx
    e970:	48 39 f7             	cmp    %rsi,%rdi
    e973:	75 09                	jne    e97e <tp_value+0x172e>
    e975:	45 84 c0             	test   %r8b,%r8b
    e978:	0f 85 99 ee ff ff    	jne    d817 <tp_value+0x5c7>
    e97e:	48 39 c2             	cmp    %rax,%rdx
    e981:	73 5b                	jae    e9de <tp_value+0x178e>
    e983:	0f b6 74 14 50       	movzbl 0x50(%rsp,%rdx,1),%esi
    e988:	83 ce 20             	or     $0x20,%esi
    e98b:	83 fe 65             	cmp    $0x65,%esi
    e98e:	75 4e                	jne    e9de <tp_value+0x178e>
    e990:	48 8d 72 01          	lea    0x1(%rdx),%rsi
    e994:	48 39 c6             	cmp    %rax,%rsi
    e997:	73 16                	jae    e9af <tp_value+0x175f>
    e999:	0f b6 7c 34 50       	movzbl 0x50(%rsp,%rsi,1),%edi
    e99e:	83 ff 2d             	cmp    $0x2d,%edi
    e9a1:	74 05                	je     e9a8 <tp_value+0x1758>
    e9a3:	83 ff 2b             	cmp    $0x2b,%edi
    e9a6:	75 07                	jne    e9af <tp_value+0x175f>
    e9a8:	48 83 c2 02          	add    $0x2,%rdx
    e9ac:	48 89 d6             	mov    %rdx,%rsi
    e9af:	48 39 c6             	cmp    %rax,%rsi
    e9b2:	0f 83 5f ee ff ff    	jae    d817 <tp_value+0x5c7>
    e9b8:	48 89 f2             	mov    %rsi,%rdx
    e9bb:	0f b6 7c 14 50       	movzbl 0x50(%rsp,%rdx,1),%edi
    e9c0:	40 80 c7 d0          	add    $0xd0,%dil
    e9c4:	40 80 ff 09          	cmp    $0x9,%dil
    e9c8:	77 0b                	ja     e9d5 <tp_value+0x1785>
    e9ca:	48 ff c2             	inc    %rdx
    e9cd:	48 39 d0             	cmp    %rdx,%rax
    e9d0:	75 e9                	jne    e9bb <tp_value+0x176b>
    e9d2:	48 89 c2             	mov    %rax,%rdx
    e9d5:	48 39 f2             	cmp    %rsi,%rdx
    e9d8:	0f 84 39 ee ff ff    	je     d817 <tp_value+0x5c7>
    e9de:	48 39 c2             	cmp    %rax,%rdx
    e9e1:	0f 85 30 ee ff ff    	jne    d817 <tp_value+0x5c7>
    e9e7:	83 39 0a             	cmpl   $0xa,(%rcx)
    e9ea:	75 19                	jne    ea05 <tp_value+0x17b5>
    e9ec:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    e9f1:	31 f6                	xor    %esi,%esi
    e9f3:	e8 08 48 ff ff       	call   3200 <strtof@plt>
    e9f8:	66 0f 7e c0          	movd   %xmm0,%eax
    e9fc:	49 89 04 24          	mov    %rax,(%r12)
    ea00:	e9 0c ee ff ff       	jmp    d811 <tp_value+0x5c1>
    ea05:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    ea0a:	31 f6                	xor    %esi,%esi
    ea0c:	e8 ef 46 ff ff       	call   3100 <strtod@plt>
    ea11:	e9 b2 ed ff ff       	jmp    d7c8 <tp_value+0x578>
    ea16:	48 ff c0             	inc    %rax
    ea19:	48 89 41 10          	mov    %rax,0x10(%rcx)
    ea1d:	4c 8b 64 24 40       	mov    0x40(%rsp),%r12
    ea22:	e9 40 f9 ff ff       	jmp    e367 <tp_value+0x1117>
    ea27:	e8 14 7c ff ff       	call   6640 <fwp_flush>
    ea2c:	48 8b 05 a5 a5 00 00 	mov    0xa5a5(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
    ea33:	48 8b 38             	mov    (%rax),%rdi
    ea36:	48 8d 35 11 60 00 00 	lea    0x6011(%rip),%rsi        # 14a4e <exec_in_fp0+0x23e>
    ea3d:	48 8d 15 3a 6f 00 00 	lea    0x6f3a(%rip),%rdx        # 1597e <exec_in_fp0+0x116e>
    ea44:	31 c0                	xor    %eax,%eax
    ea46:	e8 a5 48 ff ff       	call   32f0 <fprintf@plt>
    ea4b:	bf 65 00 00 00       	mov    $0x65,%edi
    ea50:	e8 0b 4a ff ff       	call   3460 <exit@plt>
    ea55:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    ea5c:	00 00 00 00 

000000000000ea60 <tp_int>:
    ea60:	55                   	push   %rbp
    ea61:	41 57                	push   %r15
    ea63:	41 56                	push   %r14
    ea65:	41 55                	push   %r13
    ea67:	41 54                	push   %r12
    ea69:	53                   	push   %rbx
    ea6a:	48 81 ec b8 00 00 00 	sub    $0xb8,%rsp
    ea71:	49 89 d6             	mov    %rdx,%r14
    ea74:	49 89 f4             	mov    %rsi,%r12
    ea77:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
    ea7c:	ba 80 00 00 00       	mov    $0x80,%edx
    ea81:	e8 6a 0d 00 00       	call   f7f0 <tp_token>
    ea86:	45 31 d2             	xor    %r10d,%r10d
    ea89:	48 83 f8 7f          	cmp    $0x7f,%rax
    ea8d:	0f 87 fa 00 00 00    	ja     eb8d <tp_int+0x12d>
    ea93:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    ea98:	e8 d3 46 ff ff       	call   3170 <strlen@plt>
    ea9d:	49 89 c5             	mov    %rax,%r13
    eaa0:	48 ff 05 81 c2 00 00 	incq   0xc281(%rip)        # 1ad28 <measured_calls>
    eaa7:	48 8d 50 09          	lea    0x9(%rax),%rdx
    eaab:	48 01 15 7e c2 00 00 	add    %rdx,0xc27e(%rip)        # 1ad30 <measured_bytes>
    eab2:	48 8d 3d cf a7 00 00 	lea    0xa7cf(%rip),%rdi        # 19288 <fwp_gc>
    eab9:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    eac0:	77 5e                	ja     eb20 <tp_int+0xc0>
    eac2:	4c 89 e8             	mov    %r13,%rax
    eac5:	48 83 c0 18          	add    $0x18,%rax
    eac9:	48 c1 e8 04          	shr    $0x4,%rax
    eacd:	0f b6 8c 38 e8 0b 00 	movzbl 0xbe8(%rax,%rdi,1),%ecx
    ead4:	00 
    ead5:	8b 84 8f 48 0b 00 00 	mov    0xb48(%rdi,%rcx,4),%eax
    eadc:	48 29 05 a5 a7 00 00 	sub    %rax,0xa7a5(%rip)        # 19288 <fwp_gc>
    eae3:	78 3b                	js     eb20 <tp_int+0xc0>
    eae5:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    eae9:	48 8d 34 cf          	lea    (%rdi,%rcx,8),%rsi
    eaed:	48 81 c6 c8 03 00 00 	add    $0x3c8,%rsi
    eaf4:	48 8b 2e             	mov    (%rsi),%rbp
    eaf7:	48 85 ed             	test   %rbp,%rbp
    eafa:	74 0c                	je     eb08 <tp_int+0xa8>
    eafc:	48 8b 45 00          	mov    0x0(%rbp),%rax
    eb00:	48 f7 d0             	not    %rax
    eb03:	48 89 06             	mov    %rax,(%rsi)
    eb06:	eb 3b                	jmp    eb43 <tp_int+0xe3>
    eb08:	48 8b ac cf d0 03 00 	mov    0x3d0(%rdi,%rcx,8),%rbp
    eb0f:	00 
    eb10:	48 8b b4 cf d8 03 00 	mov    0x3d8(%rdi,%rcx,8),%rsi
    eb17:	00 
    eb18:	48 29 ee             	sub    %rbp,%rsi
    eb1b:	48 39 c6             	cmp    %rax,%rsi
    eb1e:	73 12                	jae    eb32 <tp_int+0xd2>
    eb20:	48 89 d7             	mov    %rdx,%rdi
    eb23:	be 01 00 00 00       	mov    $0x1,%esi
    eb28:	e8 f3 91 ff ff       	call   7d20 <fwp_gc_alloc_slow>
    eb2d:	48 89 c5             	mov    %rax,%rbp
    eb30:	eb 1b                	jmp    eb4d <tp_int+0xed>
    eb32:	48 8d 0c cf          	lea    (%rdi,%rcx,8),%rcx
    eb36:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
    eb3d:	48 01 e8             	add    %rbp,%rax
    eb40:	48 89 01             	mov    %rax,(%rcx)
    eb43:	48 89 ef             	mov    %rbp,%rdi
    eb46:	31 f6                	xor    %esi,%esi
    eb48:	e8 c3 46 ff ff       	call   3210 <memset@plt>
    eb4d:	4c 89 6d 00          	mov    %r13,0x0(%rbp)
    eb51:	4c 8d 7d 08          	lea    0x8(%rbp),%r15
    eb55:	48 8d 5c 24 30       	lea    0x30(%rsp),%rbx
    eb5a:	4c 89 ff             	mov    %r15,%rdi
    eb5d:	48 89 de             	mov    %rbx,%rsi
    eb60:	4c 89 ea             	mov    %r13,%rdx
    eb63:	e8 c8 47 ff ff       	call   3330 <memcpy@plt>
    eb68:	42 c6 44 2d 08 00    	movb   $0x0,0x8(%rbp,%r13,1)
    eb6e:	4c 8b 5d 00          	mov    0x0(%rbp),%r11
    eb72:	4d 85 db             	test   %r11,%r11
    eb75:	74 13                	je     eb8a <tp_int+0x12a>
    eb77:	41 0f b6 3f          	movzbl (%r15),%edi
    eb7b:	8d 47 d5             	lea    -0x2b(%rdi),%eax
    eb7e:	31 c9                	xor    %ecx,%ecx
    eb80:	a8 fd                	test   $0xfd,%al
    eb82:	0f 94 c1             	sete   %cl
    eb85:	49 39 cb             	cmp    %rcx,%r11
    eb88:	75 18                	jne    eba2 <tp_int+0x142>
    eb8a:	45 31 d2             	xor    %r10d,%r10d
    eb8d:	44 89 d0             	mov    %r10d,%eax
    eb90:	48 81 c4 b8 00 00 00 	add    $0xb8,%rsp
    eb97:	5b                   	pop    %rbx
    eb98:	41 5c                	pop    %r12
    eb9a:	41 5d                	pop    %r13
    eb9c:	41 5e                	pop    %r14
    eb9e:	41 5f                	pop    %r15
    eba0:	5d                   	pop    %rbp
    eba1:	c3                   	ret
    eba2:	45 8b 04 24          	mov    (%r12),%r8d
    eba6:	41 8b 74 24 48       	mov    0x48(%r12),%esi
    ebab:	76 18                	jbe    ebc5 <tp_int+0x165>
    ebad:	0f 1f 00             	nopl   (%rax)
    ebb0:	41 0f b6 14 0f       	movzbl (%r15,%rcx,1),%edx
    ebb5:	80 c2 c6             	add    $0xc6,%dl
    ebb8:	80 fa f6             	cmp    $0xf6,%dl
    ebbb:	72 cd                	jb     eb8a <tp_int+0x12a>
    ebbd:	48 ff c1             	inc    %rcx
    ebc0:	49 39 cb             	cmp    %rcx,%r11
    ebc3:	75 eb                	jne    ebb0 <tp_int+0x150>
    ebc5:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
    ebca:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    ebcf:	48 89 74 24 18       	mov    %rsi,0x18(%rsp)
    ebd4:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    ebd9:	31 db                	xor    %ebx,%ebx
    ebdb:	a8 fd                	test   $0xfd,%al
    ebdd:	0f 94 c3             	sete   %bl
    ebe0:	45 31 e4             	xor    %r12d,%r12d
    ebe3:	41 be 00 00 00 00    	mov    $0x0,%r14d
    ebe9:	49 39 db             	cmp    %rbx,%r11
    ebec:	0f 86 bf 00 00 00    	jbe    ecb1 <tp_int+0x251>
    ebf2:	bd 0a 00 00 00       	mov    $0xa,%ebp
    ebf7:	49 b8 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r8
    ebfe:	cc cc cc 
    ec01:	49 ba cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r10
    ec08:	cc cc cc 
    ec0b:	45 31 e4             	xor    %r12d,%r12d
    ec0e:	45 31 f6             	xor    %r14d,%r14d
    ec11:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ec18:	0f 1f 84 00 00 00 00 
    ec1f:	00 
    ec20:	4d 89 f1             	mov    %r14,%r9
    ec23:	4c 89 e1             	mov    %r12,%rcx
    ec26:	4c 89 e0             	mov    %r12,%rax
    ec29:	48 f7 e5             	mul    %rbp
    ec2c:	4b 8d 34 b6          	lea    (%r14,%r14,4),%rsi
    ec30:	48 8d 14 72          	lea    (%rdx,%rsi,2),%rdx
    ec34:	41 0f be 34 1f       	movsbl (%r15,%rbx,1),%esi
    ec39:	83 c6 d0             	add    $0xffffffd0,%esi
    ec3c:	48 63 f6             	movslq %esi,%rsi
    ec3f:	49 89 f6             	mov    %rsi,%r14
    ec42:	49 c1 fe 3f          	sar    $0x3f,%r14
    ec46:	49 89 c4             	mov    %rax,%r12
    ec49:	49 01 f4             	add    %rsi,%r12
    ec4c:	49 11 d6             	adc    %rdx,%r14
    ec4f:	4c 89 f6             	mov    %r14,%rsi
    ec52:	4c 0f a4 e6 3f       	shld   $0x3f,%r12,%rsi
    ec57:	4d 89 f5             	mov    %r14,%r13
    ec5a:	49 d1 ed             	shr    $1,%r13
    ec5d:	48 89 f7             	mov    %rsi,%rdi
    ec60:	4c 01 ef             	add    %r13,%rdi
    ec63:	48 83 d7 00          	adc    $0x0,%rdi
    ec67:	48 89 f8             	mov    %rdi,%rax
    ec6a:	49 f7 e0             	mul    %r8
    ec6d:	48 c1 ea 02          	shr    $0x2,%rdx
    ec71:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    ec75:	48 29 c7             	sub    %rax,%rdi
    ec78:	48 29 fe             	sub    %rdi,%rsi
    ec7b:	49 83 dd 00          	sbb    $0x0,%r13
    ec7f:	48 89 f7             	mov    %rsi,%rdi
    ec82:	49 0f af fa          	imul   %r10,%rdi
    ec86:	48 89 f0             	mov    %rsi,%rax
    ec89:	49 f7 e0             	mul    %r8
    ec8c:	48 01 fa             	add    %rdi,%rdx
    ec8f:	4d 0f af e8          	imul   %r8,%r13
    ec93:	49 01 d5             	add    %rdx,%r13
    ec96:	4d 31 cd             	xor    %r9,%r13
    ec99:	48 31 c8             	xor    %rcx,%rax
    ec9c:	4c 09 e8             	or     %r13,%rax
    ec9f:	0f 85 e5 fe ff ff    	jne    eb8a <tp_int+0x12a>
    eca5:	48 ff c3             	inc    %rbx
    eca8:	49 39 db             	cmp    %rbx,%r11
    ecab:	0f 85 6f ff ff ff    	jne    ec20 <tp_int+0x1c0>
    ecb1:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
    ecb6:	41 83 f8 09          	cmp    $0x9,%r8d
    ecba:	75 71                	jne    ed2d <tp_int+0x2cd>
    ecbc:	80 7c 24 10 2d       	cmpb   $0x2d,0x10(%rsp)
    ecc1:	4c 8d 0d c0 a5 00 00 	lea    0xa5c0(%rip),%r9        # 19288 <fwp_gc>
    ecc8:	75 0f                	jne    ecd9 <tp_int+0x279>
    ecca:	45 31 d2             	xor    %r10d,%r10d
    eccd:	4c 89 e0             	mov    %r12,%rax
    ecd0:	4c 09 f0             	or     %r14,%rax
    ecd3:	0f 85 b4 fe ff ff    	jne    eb8d <tp_int+0x12d>
    ecd9:	48 ff 05 48 c0 00 00 	incq   0xc048(%rip)        # 1ad28 <measured_calls>
    ece0:	48 83 05 48 c0 00 00 	addq   $0x10,0xc048(%rip)        # 1ad30 <measured_bytes>
    ece7:	10 
    ece8:	0f b6 0d 82 b1 00 00 	movzbl 0xb182(%rip),%ecx        # 19e71 <fwp_gc+0xbe9>
    ecef:	41 8b 84 89 48 0b 00 	mov    0xb48(%r9,%rcx,4),%eax
    ecf6:	00 
    ecf7:	48 29 05 8a a5 00 00 	sub    %rax,0xa58a(%rip)        # 19288 <fwp_gc>
    ecfe:	0f 88 d7 00 00 00    	js     eddb <tp_int+0x37b>
    ed04:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    ed08:	49 8d 14 c9          	lea    (%r9,%rcx,8),%rdx
    ed0c:	48 81 c2 c8 03 00 00 	add    $0x3c8,%rdx
    ed13:	4c 8b 3a             	mov    (%rdx),%r15
    ed16:	4d 85 ff             	test   %r15,%r15
    ed19:	0f 84 a4 00 00 00    	je     edc3 <tp_int+0x363>
    ed1f:	49 8b 07             	mov    (%r15),%rax
    ed22:	48 f7 d0             	not    %rax
    ed25:	48 89 02             	mov    %rax,(%rdx)
    ed28:	e9 d9 00 00 00       	jmp    ee06 <tp_int+0x3a6>
    ed2d:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    ed32:	40 80 ff 2d          	cmp    $0x2d,%dil
    ed36:	0f 94 c1             	sete   %cl
    ed39:	48 b8 00 00 00 00 00 	movabs $0x8000000000000000,%rax
    ed40:	00 00 80 
    ed43:	4c 89 f2             	mov    %r14,%rdx
    ed46:	48 31 c2             	xor    %rax,%rdx
    ed49:	4c 09 e2             	or     %r12,%rdx
    ed4c:	0f 95 c2             	setne  %dl
    ed4f:	45 31 d2             	xor    %r10d,%r10d
    ed52:	4c 89 e6             	mov    %r12,%rsi
    ed55:	48 f7 de             	neg    %rsi
    ed58:	48 89 c6             	mov    %rax,%rsi
    ed5b:	4c 19 f6             	sbb    %r14,%rsi
    ed5e:	4c 8d 0d 23 a5 00 00 	lea    0xa523(%rip),%r9        # 19288 <fwp_gc>
    ed65:	0f 82 22 fe ff ff    	jb     eb8d <tp_int+0x12d>
    ed6b:	08 d1                	or     %dl,%cl
    ed6d:	0f 84 1a fe ff ff    	je     eb8d <tp_int+0x12d>
    ed73:	45 31 d2             	xor    %r10d,%r10d
    ed76:	4d 89 e7             	mov    %r12,%r15
    ed79:	49 f7 df             	neg    %r15
    ed7c:	bb 00 00 00 00       	mov    $0x0,%ebx
    ed81:	4c 19 f3             	sbb    %r14,%rbx
    ed84:	40 80 ff 2d          	cmp    $0x2d,%dil
    ed88:	4d 0f 45 fc          	cmovne %r12,%r15
    ed8c:	49 0f 45 de          	cmovne %r14,%rbx
    ed90:	41 83 f8 14          	cmp    $0x14,%r8d
    ed94:	0f 87 f3 fd ff ff    	ja     eb8d <tp_int+0x12d>
    ed9a:	44 89 c1             	mov    %r8d,%ecx
    ed9d:	48 8d 15 ec 54 00 00 	lea    0x54ec(%rip),%rdx        # 14290 <_IO_stdin_used+0x290>
    eda4:	48 63 0c 8a          	movslq (%rdx,%rcx,4),%rcx
    eda8:	48 01 d1             	add    %rdx,%rcx
    edab:	ff e1                	jmp    *%rcx
    edad:	4c 89 f8             	mov    %r15,%rax
    edb0:	48 83 c0 80          	add    $0xffffffffffffff80,%rax
    edb4:	48 83 d3 ff          	adc    $0xffffffffffffffff,%rbx
    edb8:	48 3d 00 ff ff ff    	cmp    $0xffffffffffffff00,%rax
    edbe:	e9 93 01 00 00       	jmp    ef56 <tp_int+0x4f6>
    edc3:	4d 8b bc c9 d0 03 00 	mov    0x3d0(%r9,%rcx,8),%r15
    edca:	00 
    edcb:	49 8b 94 c9 d8 03 00 	mov    0x3d8(%r9,%rcx,8),%rdx
    edd2:	00 
    edd3:	4c 29 fa             	sub    %r15,%rdx
    edd6:	48 39 c2             	cmp    %rax,%rdx
    edd9:	73 1a                	jae    edf5 <tp_int+0x395>
    eddb:	bf 10 00 00 00       	mov    $0x10,%edi
    ede0:	be 01 00 00 00       	mov    $0x1,%esi
    ede5:	4c 89 cb             	mov    %r9,%rbx
    ede8:	e8 33 8f ff ff       	call   7d20 <fwp_gc_alloc_slow>
    eded:	49 89 d9             	mov    %rbx,%r9
    edf0:	49 89 c7             	mov    %rax,%r15
    edf3:	eb 18                	jmp    ee0d <tp_int+0x3ad>
    edf5:	49 8d 0c c9          	lea    (%r9,%rcx,8),%rcx
    edf9:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
    ee00:	4c 01 f8             	add    %r15,%rax
    ee03:	48 89 01             	mov    %rax,(%rcx)
    ee06:	0f 57 c0             	xorps  %xmm0,%xmm0
    ee09:	41 0f 11 07          	movups %xmm0,(%r15)
    ee0d:	4d 89 27             	mov    %r12,(%r15)
    ee10:	4d 89 77 08          	mov    %r14,0x8(%r15)
    ee14:	4c 89 7c 24 28       	mov    %r15,0x28(%rsp)
    ee19:	48 ff 05 08 bf 00 00 	incq   0xbf08(%rip)        # 1ad28 <measured_calls>
    ee20:	48 83 05 08 bf 00 00 	addq   $0x10,0xbf08(%rip)        # 1ad30 <measured_bytes>
    ee27:	10 
    ee28:	0f b6 05 42 b0 00 00 	movzbl 0xb042(%rip),%eax        # 19e71 <fwp_gc+0xbe9>
    ee2f:	41 8b 94 81 48 0b 00 	mov    0xb48(%r9,%rax,4),%edx
    ee36:	00 
    ee37:	48 8b 0d 4a a4 00 00 	mov    0xa44a(%rip),%rcx        # 19288 <fwp_gc>
    ee3e:	48 29 d1             	sub    %rdx,%rcx
    ee41:	48 89 0d 40 a4 00 00 	mov    %rcx,0xa440(%rip)        # 19288 <fwp_gc>
    ee48:	78 7f                	js     eec9 <tp_int+0x469>
    ee4a:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
    ee4e:	49 8d 34 c1          	lea    (%r9,%rax,8),%rsi
    ee52:	48 83 c6 08          	add    $0x8,%rsi
    ee56:	4c 8b 36             	mov    (%rsi),%r14
    ee59:	4d 85 f6             	test   %r14,%r14
    ee5c:	74 2b                	je     ee89 <tp_int+0x429>
    ee5e:	49 8b 06             	mov    (%r14),%rax
    ee61:	48 f7 d0             	not    %rax
    ee64:	48 89 06             	mov    %rax,(%rsi)
    ee67:	83 fa 11             	cmp    $0x11,%edx
    ee6a:	0f 82 80 00 00 00    	jb     eef0 <tp_int+0x490>
    ee70:	49 8d 7e 10          	lea    0x10(%r14),%rdi
    ee74:	48 83 c2 ef          	add    $0xffffffffffffffef,%rdx
    ee78:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    ee7c:	48 83 c2 08          	add    $0x8,%rdx
    ee80:	31 f6                	xor    %esi,%esi
    ee82:	e8 89 43 ff ff       	call   3210 <memset@plt>
    ee87:	eb 67                	jmp    eef0 <tp_int+0x490>
    ee89:	4d 8b 74 c1 10       	mov    0x10(%r9,%rax,8),%r14
    ee8e:	49 8b 74 c1 18       	mov    0x18(%r9,%rax,8),%rsi
    ee93:	48 89 f7             	mov    %rsi,%rdi
    ee96:	4c 29 f7             	sub    %r14,%rdi
    ee99:	48 39 d7             	cmp    %rdx,%rdi
    ee9c:	73 05                	jae    eea3 <tp_int+0x443>
    ee9e:	4d 89 f4             	mov    %r14,%r12
    eea1:	eb 21                	jmp    eec4 <tp_int+0x464>
    eea3:	49 8d 3c c1          	lea    (%r9,%rax,8),%rdi
    eea7:	48 83 c7 10          	add    $0x10,%rdi
    eeab:	4d 8d 24 16          	lea    (%r14,%rdx,1),%r12
    eeaf:	4c 89 27             	mov    %r12,(%rdi)
    eeb2:	4d 85 f6             	test   %r14,%r14
    eeb5:	75 b0                	jne    ee67 <tp_int+0x407>
    eeb7:	48 89 0d ca a3 00 00 	mov    %rcx,0xa3ca(%rip)        # 19288 <fwp_gc>
    eebe:	4c 29 e6             	sub    %r12,%rsi
    eec1:	48 89 f7             	mov    %rsi,%rdi
    eec4:	48 39 d7             	cmp    %rdx,%rdi
    eec7:	73 11                	jae    eeda <tp_int+0x47a>
    eec9:	bf 10 00 00 00       	mov    $0x10,%edi
    eece:	31 f6                	xor    %esi,%esi
    eed0:	e8 4b 8e ff ff       	call   7d20 <fwp_gc_alloc_slow>
    eed5:	49 89 c6             	mov    %rax,%r14
    eed8:	eb 16                	jmp    eef0 <tp_int+0x490>
    eeda:	49 8d 0c 14          	lea    (%r12,%rdx,1),%rcx
    eede:	49 89 4c c1 10       	mov    %rcx,0x10(%r9,%rax,8)
    eee3:	4c 89 e7             	mov    %r12,%rdi
    eee6:	31 f6                	xor    %esi,%esi
    eee8:	e8 23 43 ff ff       	call   3210 <memset@plt>
    eeed:	4d 89 e6             	mov    %r12,%r14
    eef0:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
    eef7:	00 00 00 
    eefa:	49 89 06             	mov    %rax,(%r14)
    eefd:	4d 89 7e 08          	mov    %r15,0x8(%r14)
    ef01:	48 8d 44 24 28       	lea    0x28(%rsp),%rax
    ef06:	49 8b 46 08          	mov    0x8(%r14),%rax
    ef0a:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    ef0f:	48 89 01             	mov    %rax,(%rcx)
    ef12:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    ef18:	e9 70 fc ff ff       	jmp    eb8d <tp_int+0x12d>
    ef1d:	4c 89 f8             	mov    %r15,%rax
    ef20:	48 05 00 00 00 80    	add    $0xffffffff80000000,%rax
    ef26:	48 83 d3 ff          	adc    $0xffffffffffffffff,%rbx
    ef2a:	48 b9 00 00 00 00 ff 	movabs $0xffffffff00000000,%rcx
    ef31:	ff ff ff 
    ef34:	48 39 c8             	cmp    %rcx,%rax
    ef37:	eb 1d                	jmp    ef56 <tp_int+0x4f6>
    ef39:	45 31 d2             	xor    %r10d,%r10d
    ef3c:	b8 ff 00 00 00       	mov    $0xff,%eax
    ef41:	eb 2a                	jmp    ef6d <tp_int+0x50d>
    ef43:	4c 89 f8             	mov    %r15,%rax
    ef46:	48 05 00 80 ff ff    	add    $0xffffffffffff8000,%rax
    ef4c:	48 83 d3 ff          	adc    $0xffffffffffffffff,%rbx
    ef50:	48 3d 00 00 ff ff    	cmp    $0xffffffffffff0000,%rax
    ef56:	48 83 db ff          	sbb    $0xffffffffffffffff,%rbx
    ef5a:	0f 82 2d fc ff ff    	jb     eb8d <tp_int+0x12d>
    ef60:	e9 af fe ff ff       	jmp    ee14 <tp_int+0x3b4>
    ef65:	45 31 d2             	xor    %r10d,%r10d
    ef68:	b8 ff ff 00 00       	mov    $0xffff,%eax
    ef6d:	4c 39 f8             	cmp    %r15,%rax
    ef70:	b8 00 00 00 00       	mov    $0x0,%eax
    ef75:	48 19 d8             	sbb    %rbx,%rax
    ef78:	0f 82 0f fc ff ff    	jb     eb8d <tp_int+0x12d>
    ef7e:	e9 91 fe ff ff       	jmp    ee14 <tp_int+0x3b4>
    ef83:	4c 89 f8             	mov    %r15,%rax
    ef86:	48 c1 e8 20          	shr    $0x20,%rax
    ef8a:	48 09 d8             	or     %rbx,%rax
    ef8d:	0f 85 fa fb ff ff    	jne    eb8d <tp_int+0x12d>
    ef93:	e9 7c fe ff ff       	jmp    ee14 <tp_int+0x3b4>
    ef98:	4c 89 f9             	mov    %r15,%rcx
    ef9b:	48 01 c1             	add    %rax,%rcx
    ef9e:	48 83 d3 ff          	adc    $0xffffffffffffffff,%rbx
    efa2:	48 83 fb ff          	cmp    $0xffffffffffffffff,%rbx
    efa6:	0f 85 e1 fb ff ff    	jne    eb8d <tp_int+0x12d>
    efac:	e9 63 fe ff ff       	jmp    ee14 <tp_int+0x3b4>
    efb1:	48 ff 05 70 bd 00 00 	incq   0xbd70(%rip)        # 1ad28 <measured_calls>
    efb8:	48 83 05 70 bd 00 00 	addq   $0x10,0xbd70(%rip)        # 1ad30 <measured_bytes>
    efbf:	10 
    efc0:	0f b6 05 aa ae 00 00 	movzbl 0xaeaa(%rip),%eax        # 19e71 <fwp_gc+0xbe9>
    efc7:	41 8b 8c 81 48 0b 00 	mov    0xb48(%r9,%rax,4),%ecx
    efce:	00 
    efcf:	48 29 0d b2 a2 00 00 	sub    %rcx,0xa2b2(%rip)        # 19288 <fwp_gc>
    efd6:	0f 88 87 00 00 00    	js     f063 <tp_int+0x603>
    efdc:	48 8d 14 40          	lea    (%rax,%rax,2),%rdx
    efe0:	49 8d 34 d1          	lea    (%r9,%rdx,8),%rsi
    efe4:	48 81 c6 c8 03 00 00 	add    $0x3c8,%rsi
    efeb:	48 8b 06             	mov    (%rsi),%rax
    efee:	48 85 c0             	test   %rax,%rax
    eff1:	74 54                	je     f047 <tp_int+0x5e7>
    eff3:	48 8b 08             	mov    (%rax),%rcx
    eff6:	48 f7 d1             	not    %rcx
    eff9:	48 89 0e             	mov    %rcx,(%rsi)
    effc:	e9 12 01 00 00       	jmp    f113 <tp_int+0x6b3>
    f001:	45 31 d2             	xor    %r10d,%r10d
    f004:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    f009:	85 c9                	test   %ecx,%ecx
    f00b:	7e 31                	jle    f03e <tp_int+0x5de>
    f00d:	8d 41 ff             	lea    -0x1(%rcx),%eax
    f010:	83 f8 4f             	cmp    $0x4f,%eax
    f013:	bf 4f 00 00 00       	mov    $0x4f,%edi
    f018:	0f 42 f8             	cmovb  %eax,%edi
    f01b:	ff c7                	inc    %edi
    f01d:	89 fe                	mov    %edi,%esi
    f01f:	83 e6 07             	and    $0x7,%esi
    f022:	83 f9 08             	cmp    $0x8,%ecx
    f025:	73 56                	jae    f07d <tp_int+0x61d>
    f027:	b8 01 00 00 00       	mov    $0x1,%eax
    f02c:	31 c9                	xor    %ecx,%ecx
    f02e:	eb 72                	jmp    f0a2 <tp_int+0x642>
    f030:	48 85 db             	test   %rbx,%rbx
    f033:	0f 85 54 fb ff ff    	jne    eb8d <tp_int+0x12d>
    f039:	e9 d6 fd ff ff       	jmp    ee14 <tp_int+0x3b4>
    f03e:	31 d2                	xor    %edx,%edx
    f040:	31 c9                	xor    %ecx,%ecx
    f042:	e9 90 00 00 00       	jmp    f0d7 <tp_int+0x677>
    f047:	49 8b 84 d1 d0 03 00 	mov    0x3d0(%r9,%rdx,8),%rax
    f04e:	00 
    f04f:	49 8b b4 d1 d8 03 00 	mov    0x3d8(%r9,%rdx,8),%rsi
    f056:	00 
    f057:	48 29 c6             	sub    %rax,%rsi
    f05a:	48 39 ce             	cmp    %rcx,%rsi
    f05d:	0f 83 9f 00 00 00    	jae    f102 <tp_int+0x6a2>
    f063:	bf 10 00 00 00       	mov    $0x10,%edi
    f068:	be 01 00 00 00       	mov    $0x1,%esi
    f06d:	4d 89 ce             	mov    %r9,%r14
    f070:	e8 ab 8c ff ff       	call   7d20 <fwp_gc_alloc_slow>
    f075:	4d 89 f1             	mov    %r14,%r9
    f078:	e9 9c 00 00 00       	jmp    f119 <tp_int+0x6b9>
    f07d:	81 e7 f8 00 00 00    	and    $0xf8,%edi
    f083:	b8 01 00 00 00       	mov    $0x1,%eax
    f088:	31 c9                	xor    %ecx,%ecx
    f08a:	41 b8 a1 19 00 00    	mov    $0x19a1,%r8d
    f090:	49 f7 e0             	mul    %r8
    f093:	48 69 c9 a1 19 00 00 	imul   $0x19a1,%rcx,%rcx
    f09a:	48 01 d1             	add    %rdx,%rcx
    f09d:	83 c7 f8             	add    $0xfffffff8,%edi
    f0a0:	75 ee                	jne    f090 <tp_int+0x630>
    f0a2:	85 f6                	test   %esi,%esi
    f0a4:	74 13                	je     f0b9 <tp_int+0x659>
    f0a6:	bf 03 00 00 00       	mov    $0x3,%edi
    f0ab:	48 f7 e7             	mul    %rdi
    f0ae:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    f0b2:	48 01 d1             	add    %rdx,%rcx
    f0b5:	ff ce                	dec    %esi
    f0b7:	75 f2                	jne    f0ab <tp_int+0x64b>
    f0b9:	48 83 c0 ff          	add    $0xffffffffffffffff,%rax
    f0bd:	48 83 d1 ff          	adc    $0xffffffffffffffff,%rcx
    f0c1:	48 89 ca             	mov    %rcx,%rdx
    f0c4:	48 c1 ea 3f          	shr    $0x3f,%rdx
    f0c8:	48 01 c2             	add    %rax,%rdx
    f0cb:	48 83 d1 00          	adc    $0x0,%rcx
    f0cf:	48 0f ac ca 01       	shrd   $0x1,%rcx,%rdx
    f0d4:	48 d1 f9             	sar    $1,%rcx
    f0d7:	48 89 d0             	mov    %rdx,%rax
    f0da:	48 f7 d8             	neg    %rax
    f0dd:	be 00 00 00 00       	mov    $0x0,%esi
    f0e2:	48 19 ce             	sbb    %rcx,%rsi
    f0e5:	4c 39 fa             	cmp    %r15,%rdx
    f0e8:	48 19 d9             	sbb    %rbx,%rcx
    f0eb:	0f 8c 9c fa ff ff    	jl     eb8d <tp_int+0x12d>
    f0f1:	49 39 c7             	cmp    %rax,%r15
    f0f4:	48 19 f3             	sbb    %rsi,%rbx
    f0f7:	0f 8d 17 fd ff ff    	jge    ee14 <tp_int+0x3b4>
    f0fd:	e9 8b fa ff ff       	jmp    eb8d <tp_int+0x12d>
    f102:	49 8d 14 d1          	lea    (%r9,%rdx,8),%rdx
    f106:	48 81 c2 d0 03 00 00 	add    $0x3d0,%rdx
    f10d:	48 01 c1             	add    %rax,%rcx
    f110:	48 89 0a             	mov    %rcx,(%rdx)
    f113:	0f 57 c0             	xorps  %xmm0,%xmm0
    f116:	0f 11 00             	movups %xmm0,(%rax)
    f119:	4c 89 38             	mov    %r15,(%rax)
    f11c:	48 89 58 08          	mov    %rbx,0x8(%rax)
    f120:	49 89 c7             	mov    %rax,%r15
    f123:	e9 ec fc ff ff       	jmp    ee14 <tp_int+0x3b4>
    f128:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    f12f:	00 

000000000000f130 <tp_quoted>:
    f130:	55                   	push   %rbp
    f131:	41 57                	push   %r15
    f133:	41 56                	push   %r14
    f135:	41 55                	push   %r13
    f137:	41 54                	push   %r12
    f139:	53                   	push   %rbx
    f13a:	48 83 ec 28          	sub    $0x28,%rsp
    f13e:	48 89 f3             	mov    %rsi,%rbx
    f141:	49 89 ff             	mov    %rdi,%r15
    f144:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    f148:	48 8b 6f 10          	mov    0x10(%rdi),%rbp
    f14c:	4c 39 ed             	cmp    %r13,%rbp
    f14f:	73 33                	jae    f184 <tp_quoted+0x54>
    f151:	49 8b 07             	mov    (%r15),%rax
    f154:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    f15b:	00 00 00 
    f15e:	66 90                	xchg   %ax,%ax
    f160:	0f b6 14 28          	movzbl (%rax,%rbp,1),%edx
    f164:	48 83 fa 20          	cmp    $0x20,%rdx
    f168:	77 1a                	ja     f184 <tp_quoted+0x54>
    f16a:	48 0f a3 d1          	bt     %rdx,%rcx
    f16e:	73 14                	jae    f184 <tp_quoted+0x54>
    f170:	48 ff c5             	inc    %rbp
    f173:	49 89 6f 10          	mov    %rbp,0x10(%r15)
    f177:	49 39 ed             	cmp    %rbp,%r13
    f17a:	75 e4                	jne    f160 <tp_quoted+0x30>
    f17c:	45 31 f6             	xor    %r14d,%r14d
    f17f:	e9 f6 01 00 00       	jmp    f37a <tp_quoted+0x24a>
    f184:	45 31 f6             	xor    %r14d,%r14d
    f187:	4c 39 ed             	cmp    %r13,%rbp
    f18a:	0f 83 ea 01 00 00    	jae    f37a <tp_quoted+0x24a>
    f190:	49 8b 07             	mov    (%r15),%rax
    f193:	80 3c 28 22          	cmpb   $0x22,(%rax,%rbp,1)
    f197:	0f 85 dd 01 00 00    	jne    f37a <tp_quoted+0x24a>
    f19d:	48 ff c5             	inc    %rbp
    f1a0:	49 89 6f 10          	mov    %rbp,0x10(%r15)
    f1a4:	0f 57 c0             	xorps  %xmm0,%xmm0
    f1a7:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    f1ac:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    f1b3:	00 00 
    f1b5:	45 31 f6             	xor    %r14d,%r14d
    f1b8:	4c 39 ed             	cmp    %r13,%rbp
    f1bb:	0f 83 a6 01 00 00    	jae    f367 <tp_quoted+0x237>
    f1c1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    f1c8:	0f 1f 84 00 00 00 00 
    f1cf:	00 
    f1d0:	4d 8b 27             	mov    (%r15),%r12
    f1d3:	48 8d 4d 01          	lea    0x1(%rbp),%rcx
    f1d7:	49 89 4f 10          	mov    %rcx,0x10(%r15)
    f1db:	41 0f b6 04 2c       	movzbl (%r12,%rbp,1),%eax
    f1e0:	83 f8 5c             	cmp    $0x5c,%eax
    f1e3:	74 3b                	je     f220 <tp_quoted+0xf0>
    f1e5:	83 f8 22             	cmp    $0x22,%eax
    f1e8:	0f 84 9e 01 00 00    	je     f38c <tp_quoted+0x25c>
    f1ee:	88 44 24 0f          	mov    %al,0xf(%rsp)
    f1f2:	ba 01 00 00 00       	mov    $0x1,%edx
    f1f7:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    f1fc:	48 8d 74 24 0f       	lea    0xf(%rsp),%rsi
    f201:	e8 0a db ff ff       	call   cd10 <buf_put>
    f206:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    f20a:	49 8b 6f 10          	mov    0x10(%r15),%rbp
    f20e:	4c 39 ed             	cmp    %r13,%rbp
    f211:	72 bd                	jb     f1d0 <tp_quoted+0xa0>
    f213:	e9 58 01 00 00       	jmp    f370 <tp_quoted+0x240>
    f218:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    f21f:	00 
    f220:	4c 39 e9             	cmp    %r13,%rcx
    f223:	0f 83 47 01 00 00    	jae    f370 <tp_quoted+0x240>
    f229:	48 8d 45 02          	lea    0x2(%rbp),%rax
    f22d:	49 89 47 10          	mov    %rax,0x10(%r15)
    f231:	41 0f b6 4c 2c 01    	movzbl 0x1(%r12,%rbp,1),%ecx
    f237:	8d 51 a4             	lea    -0x5c(%rcx),%edx
    f23a:	83 fa 19             	cmp    $0x19,%edx
    f23d:	77 17                	ja     f256 <tp_quoted+0x126>
    f23f:	48 8d 35 9e 50 00 00 	lea    0x509e(%rip),%rsi        # 142e4 <_IO_stdin_used+0x2e4>
    f246:	48 63 0c 96          	movslq (%rsi,%rdx,4),%rcx
    f24a:	48 01 f1             	add    %rsi,%rcx
    f24d:	ff e1                	jmp    *%rcx
    f24f:	c6 44 24 0f 5c       	movb   $0x5c,0xf(%rsp)
    f254:	eb 9c                	jmp    f1f2 <tp_quoted+0xc2>
    f256:	83 f9 22             	cmp    $0x22,%ecx
    f259:	0f 84 c2 00 00 00    	je     f321 <tp_quoted+0x1f1>
    f25f:	83 f9 30             	cmp    $0x30,%ecx
    f262:	0f 85 08 01 00 00    	jne    f370 <tp_quoted+0x240>
    f268:	c6 44 24 0f 00       	movb   $0x0,0xf(%rsp)
    f26d:	eb 83                	jmp    f1f2 <tp_quoted+0xc2>
    f26f:	c6 44 24 0f 09       	movb   $0x9,0xf(%rsp)
    f274:	e9 79 ff ff ff       	jmp    f1f2 <tp_quoted+0xc2>
    f279:	c6 44 24 0f 0d       	movb   $0xd,0xf(%rsp)
    f27e:	e9 6f ff ff ff       	jmp    f1f2 <tp_quoted+0xc2>
    f283:	c6 44 24 0f 0a       	movb   $0xa,0xf(%rsp)
    f288:	e9 65 ff ff ff       	jmp    f1f2 <tp_quoted+0xc2>
    f28d:	4c 39 e8             	cmp    %r13,%rax
    f290:	0f 83 da 00 00 00    	jae    f370 <tp_quoted+0x240>
    f296:	41 80 3c 04 7b       	cmpb   $0x7b,(%r12,%rax,1)
    f29b:	0f 85 cf 00 00 00    	jne    f370 <tp_quoted+0x240>
    f2a1:	48 8d 45 03          	lea    0x3(%rbp),%rax
    f2a5:	49 89 47 10          	mov    %rax,0x10(%r15)
    f2a9:	4c 39 e8             	cmp    %r13,%rax
    f2ac:	0f 83 be 00 00 00    	jae    f370 <tp_quoted+0x240>
    f2b2:	e8 29 42 ff ff       	call   34e0 <__ctype_b_loc@plt>
    f2b7:	48 8b 08             	mov    (%rax),%rcx
    f2ba:	48 8d 55 04          	lea    0x4(%rbp),%rdx
    f2be:	49 8d 3c 2c          	lea    (%r12,%rbp,1),%rdi
    f2c2:	48 83 c7 03          	add    $0x3,%rdi
    f2c6:	49 29 ed             	sub    %rbp,%r13
    f2c9:	49 83 c5 fd          	add    $0xfffffffffffffffd,%r13
    f2cd:	31 c0                	xor    %eax,%eax
    f2cf:	31 f6                	xor    %esi,%esi
    f2d1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    f2d8:	0f 1f 84 00 00 00 00 
    f2df:	00 
    f2e0:	44 0f b6 04 07       	movzbl (%rdi,%rax,1),%r8d
    f2e5:	42 f6 44 41 01 10    	testb  $0x10,0x1(%rcx,%r8,2)
    f2eb:	74 3e                	je     f32b <tp_quoted+0x1fb>
    f2ed:	4c 8d 04 02          	lea    (%rdx,%rax,1),%r8
    f2f1:	4d 89 47 10          	mov    %r8,0x10(%r15)
    f2f5:	44 0f be 04 07       	movsbl (%rdi,%rax,1),%r8d
    f2fa:	c1 e6 04             	shl    $0x4,%esi
    f2fd:	45 8d 48 d0          	lea    -0x30(%r8),%r9d
    f301:	45 89 c2             	mov    %r8d,%r10d
    f304:	41 83 ca 20          	or     $0x20,%r10d
    f308:	41 83 c2 a9          	add    $0xffffffa9,%r10d
    f30c:	41 83 f8 3a          	cmp    $0x3a,%r8d
    f310:	45 0f 4c d1          	cmovl  %r9d,%r10d
    f314:	44 01 d6             	add    %r10d,%esi
    f317:	48 ff c0             	inc    %rax
    f31a:	49 39 c5             	cmp    %rax,%r13
    f31d:	75 c1                	jne    f2e0 <tp_quoted+0x1b0>
    f31f:	eb 4f                	jmp    f370 <tp_quoted+0x240>
    f321:	c6 44 24 0f 22       	movb   $0x22,0xf(%rsp)
    f326:	e9 c7 fe ff ff       	jmp    f1f2 <tp_quoted+0xc2>
    f32b:	85 c0                	test   %eax,%eax
    f32d:	74 41                	je     f370 <tp_quoted+0x240>
    f32f:	41 80 f8 7d          	cmp    $0x7d,%r8b
    f333:	75 3b                	jne    f370 <tp_quoted+0x240>
    f335:	81 fe ff ff 10 00    	cmp    $0x10ffff,%esi
    f33b:	77 33                	ja     f370 <tp_quoted+0x240>
    f33d:	89 f1                	mov    %esi,%ecx
    f33f:	81 e1 00 f8 ff ff    	and    $0xfffff800,%ecx
    f345:	81 f9 00 d8 00 00    	cmp    $0xd800,%ecx
    f34b:	74 23                	je     f370 <tp_quoted+0x240>
    f34d:	48 01 e8             	add    %rbp,%rax
    f350:	48 83 c0 04          	add    $0x4,%rax
    f354:	49 89 47 10          	mov    %rax,0x10(%r15)
    f358:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    f35d:	e8 ae 0b 00 00       	call   ff10 <fwp_utf8_put>
    f362:	e9 9f fe ff ff       	jmp    f206 <tp_quoted+0xd6>
    f367:	31 ff                	xor    %edi,%edi
    f369:	e8 e2 3c ff ff       	call   3050 <free@plt>
    f36e:	eb 0a                	jmp    f37a <tp_quoted+0x24a>
    f370:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    f375:	e8 d6 3c ff ff       	call   3050 <free@plt>
    f37a:	44 89 f0             	mov    %r14d,%eax
    f37d:	48 83 c4 28          	add    $0x28,%rsp
    f381:	5b                   	pop    %rbx
    f382:	41 5c                	pop    %r12
    f384:	41 5d                	pop    %r13
    f386:	41 5e                	pop    %r14
    f388:	41 5f                	pop    %r15
    f38a:	5d                   	pop    %rbp
    f38b:	c3                   	ret
    f38c:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    f391:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    f396:	48 85 ff             	test   %rdi,%rdi
    f399:	48 8d 0d ea 5d 00 00 	lea    0x5dea(%rip),%rcx        # 1518a <exec_in_fp0+0x97a>
    f3a0:	48 0f 45 cf          	cmovne %rdi,%rcx
    f3a4:	48 85 c0             	test   %rax,%rax
    f3a7:	0f 84 3e 01 00 00    	je     f4eb <tp_quoted+0x3bb>
    f3ad:	31 d2                	xor    %edx,%edx
    f3af:	eb 0c                	jmp    f3bd <tp_quoted+0x28d>
    f3b1:	48 ff c2             	inc    %rdx
    f3b4:	48 39 c2             	cmp    %rax,%rdx
    f3b7:	0f 83 2e 01 00 00    	jae    f4eb <tp_quoted+0x3bb>
    f3bd:	44 0f b6 14 11       	movzbl (%rcx,%rdx,1),%r10d
    f3c2:	45 84 d2             	test   %r10b,%r10b
    f3c5:	79 ea                	jns    f3b1 <tp_quoted+0x281>
    f3c7:	41 8d 72 3e          	lea    0x3e(%r10),%esi
    f3cb:	40 80 fe 1e          	cmp    $0x1e,%sil
    f3cf:	73 13                	jae    f3e4 <tp_quoted+0x2b4>
    f3d1:	be 80 00 00 00       	mov    $0x80,%esi
    f3d6:	41 b9 01 00 00 00    	mov    $0x1,%r9d
    f3dc:	41 b8 1f 00 00 00    	mov    $0x1f,%r8d
    f3e2:	eb 3f                	jmp    f423 <tp_quoted+0x2f3>
    f3e4:	44 89 d6             	mov    %r10d,%esi
    f3e7:	40 80 e6 f0          	and    $0xf0,%sil
    f3eb:	40 80 fe e0          	cmp    $0xe0,%sil
    f3ef:	75 13                	jne    f404 <tp_quoted+0x2d4>
    f3f1:	be 00 08 00 00       	mov    $0x800,%esi
    f3f6:	41 b9 02 00 00 00    	mov    $0x2,%r9d
    f3fc:	41 b8 0f 00 00 00    	mov    $0xf,%r8d
    f402:	eb 1f                	jmp    f423 <tp_quoted+0x2f3>
    f404:	41 8d 72 10          	lea    0x10(%r10),%esi
    f408:	40 80 fe 04          	cmp    $0x4,%sil
    f40c:	0f 87 f1 00 00 00    	ja     f503 <tp_quoted+0x3d3>
    f412:	be 00 00 01 00       	mov    $0x10000,%esi
    f417:	41 b9 03 00 00 00    	mov    $0x3,%r9d
    f41d:	41 b8 07 00 00 00    	mov    $0x7,%r8d
    f423:	45 89 c9             	mov    %r9d,%r9d
    f426:	4e 8d 1c 0a          	lea    (%rdx,%r9,1),%r11
    f42a:	49 39 c3             	cmp    %rax,%r11
    f42d:	0f 83 d0 00 00 00    	jae    f503 <tp_quoted+0x3d3>
    f433:	44 0f b6 5c 11 01    	movzbl 0x1(%rcx,%rdx,1),%r11d
    f439:	44 89 dd             	mov    %r11d,%ebp
    f43c:	83 e5 c0             	and    $0xffffffc0,%ebp
    f43f:	81 fd 80 00 00 00    	cmp    $0x80,%ebp
    f445:	0f 85 b8 00 00 00    	jne    f503 <tp_quoted+0x3d3>
    f44b:	45 21 d0             	and    %r10d,%r8d
    f44e:	45 8d 51 01          	lea    0x1(%r9),%r10d
    f452:	44 89 c5             	mov    %r8d,%ebp
    f455:	c1 e5 06             	shl    $0x6,%ebp
    f458:	41 83 e3 3f          	and    $0x3f,%r11d
    f45c:	41 09 eb             	or     %ebp,%r11d
    f45f:	41 83 fa 02          	cmp    $0x2,%r10d
    f463:	75 05                	jne    f46a <tp_quoted+0x33a>
    f465:	45 89 da             	mov    %r11d,%r10d
    f468:	eb 57                	jmp    f4c1 <tp_quoted+0x391>
    f46a:	44 0f b6 44 11 02    	movzbl 0x2(%rcx,%rdx,1),%r8d
    f470:	44 89 c5             	mov    %r8d,%ebp
    f473:	83 e5 c0             	and    $0xffffffc0,%ebp
    f476:	81 fd 80 00 00 00    	cmp    $0x80,%ebp
    f47c:	0f 85 81 00 00 00    	jne    f503 <tp_quoted+0x3d3>
    f482:	44 89 dd             	mov    %r11d,%ebp
    f485:	c1 e5 06             	shl    $0x6,%ebp
    f488:	41 83 e0 3f          	and    $0x3f,%r8d
    f48c:	41 09 e8             	or     %ebp,%r8d
    f48f:	41 83 fa 03          	cmp    $0x3,%r10d
    f493:	75 08                	jne    f49d <tp_quoted+0x36d>
    f495:	45 89 c2             	mov    %r8d,%r10d
    f498:	45 89 d8             	mov    %r11d,%r8d
    f49b:	eb 24                	jmp    f4c1 <tp_quoted+0x391>
    f49d:	44 0f b6 54 11 03    	movzbl 0x3(%rcx,%rdx,1),%r10d
    f4a3:	45 89 d3             	mov    %r10d,%r11d
    f4a6:	41 83 e3 c0          	and    $0xffffffc0,%r11d
    f4aa:	41 81 fb 80 00 00 00 	cmp    $0x80,%r11d
    f4b1:	75 50                	jne    f503 <tp_quoted+0x3d3>
    f4b3:	45 89 c3             	mov    %r8d,%r11d
    f4b6:	41 c1 e3 06          	shl    $0x6,%r11d
    f4ba:	41 83 e2 3f          	and    $0x3f,%r10d
    f4be:	45 09 da             	or     %r11d,%r10d
    f4c1:	41 83 e0 e0          	and    $0xffffffe0,%r8d
    f4c5:	41 81 f8 60 03 00 00 	cmp    $0x360,%r8d
    f4cc:	74 35                	je     f503 <tp_quoted+0x3d3>
    f4ce:	41 39 f2             	cmp    %esi,%r10d
    f4d1:	72 30                	jb     f503 <tp_quoted+0x3d3>
    f4d3:	41 81 fa ff ff 10 00 	cmp    $0x10ffff,%r10d
    f4da:	77 27                	ja     f503 <tp_quoted+0x3d3>
    f4dc:	4c 01 ca             	add    %r9,%rdx
    f4df:	48 ff c2             	inc    %rdx
    f4e2:	48 39 c2             	cmp    %rax,%rdx
    f4e5:	0f 82 d2 fe ff ff    	jb     f3bd <tp_quoted+0x28d>
    f4eb:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    f4f0:	e8 0b d9 ff ff       	call   ce00 <buf_to_str>
    f4f5:	48 89 03             	mov    %rax,(%rbx)
    f4f8:	41 be 01 00 00 00    	mov    $0x1,%r14d
    f4fe:	e9 77 fe ff ff       	jmp    f37a <tp_quoted+0x24a>
    f503:	e8 48 3b ff ff       	call   3050 <free@plt>
    f508:	e9 6f fc ff ff       	jmp    f17c <tp_quoted+0x4c>
    f50d:	0f 1f 00             	nopl   (%rax)

000000000000f510 <tp_eat>:
    f510:	55                   	push   %rbp
    f511:	41 57                	push   %r15
    f513:	41 56                	push   %r14
    f515:	41 54                	push   %r12
    f517:	53                   	push   %rbx
    f518:	49 89 f6             	mov    %rsi,%r14
    f51b:	48 89 fb             	mov    %rdi,%rbx
    f51e:	4c 8b 67 08          	mov    0x8(%rdi),%r12
    f522:	4c 8b 7f 10          	mov    0x10(%rdi),%r15
    f526:	4d 39 e7             	cmp    %r12,%r15
    f529:	73 35                	jae    f560 <tp_eat+0x50>
    f52b:	48 8b 03             	mov    (%rbx),%rax
    f52e:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    f535:	00 00 00 
    f538:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    f53f:	00 
    f540:	42 0f b6 14 38       	movzbl (%rax,%r15,1),%edx
    f545:	48 83 fa 20          	cmp    $0x20,%rdx
    f549:	77 15                	ja     f560 <tp_eat+0x50>
    f54b:	48 0f a3 d1          	bt     %rdx,%rcx
    f54f:	73 0f                	jae    f560 <tp_eat+0x50>
    f551:	49 ff c7             	inc    %r15
    f554:	4c 89 7b 10          	mov    %r15,0x10(%rbx)
    f558:	4d 39 fc             	cmp    %r15,%r12
    f55b:	75 e3                	jne    f540 <tp_eat+0x30>
    f55d:	4d 89 e7             	mov    %r12,%r15
    f560:	4c 89 f7             	mov    %r14,%rdi
    f563:	e8 08 3c ff ff       	call   3170 <strlen@plt>
    f568:	4d 29 fc             	sub    %r15,%r12
    f56b:	31 ed                	xor    %ebp,%ebp
    f56d:	49 39 c4             	cmp    %rax,%r12
    f570:	72 24                	jb     f596 <tp_eat+0x86>
    f572:	48 8b 3b             	mov    (%rbx),%rdi
    f575:	4c 01 ff             	add    %r15,%rdi
    f578:	4c 89 f6             	mov    %r14,%rsi
    f57b:	49 89 c6             	mov    %rax,%r14
    f57e:	48 89 c2             	mov    %rax,%rdx
    f581:	e8 ea 3d ff ff       	call   3370 <bcmp@plt>
    f586:	85 c0                	test   %eax,%eax
    f588:	75 0c                	jne    f596 <tp_eat+0x86>
    f58a:	4d 01 f7             	add    %r14,%r15
    f58d:	4c 89 7b 10          	mov    %r15,0x10(%rbx)
    f591:	bd 01 00 00 00       	mov    $0x1,%ebp
    f596:	89 e8                	mov    %ebp,%eax
    f598:	5b                   	pop    %rbx
    f599:	41 5c                	pop    %r12
    f59b:	41 5e                	pop    %r14
    f59d:	41 5f                	pop    %r15
    f59f:	5d                   	pop    %rbp
    f5a0:	c3                   	ret
    f5a1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    f5a8:	0f 1f 84 00 00 00 00 
    f5af:	00 

000000000000f5b0 <tp_list_of>:
    f5b0:	55                   	push   %rbp
    f5b1:	41 57                	push   %r15
    f5b3:	41 56                	push   %r14
    f5b5:	41 55                	push   %r13
    f5b7:	41 54                	push   %r12
    f5b9:	53                   	push   %rbx
    f5ba:	48 83 ec 18          	sub    $0x18,%rsp
    f5be:	4d 89 c6             	mov    %r8,%r14
    f5c1:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
    f5c6:	49 89 f7             	mov    %rsi,%r15
    f5c9:	48 89 fb             	mov    %rdi,%rbx
    f5cc:	48 8b 6f 08          	mov    0x8(%rdi),%rbp
    f5d0:	4c 8b 67 10          	mov    0x10(%rdi),%r12
    f5d4:	49 39 ec             	cmp    %rbp,%r12
    f5d7:	48 89 14 24          	mov    %rdx,(%rsp)
    f5db:	73 33                	jae    f610 <tp_list_of+0x60>
    f5dd:	48 8b 03             	mov    (%rbx),%rax
    f5e0:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    f5e7:	00 00 00 
    f5ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    f5f0:	42 0f b6 34 20       	movzbl (%rax,%r12,1),%esi
    f5f5:	48 83 fe 20          	cmp    $0x20,%rsi
    f5f9:	77 15                	ja     f610 <tp_list_of+0x60>
    f5fb:	48 0f a3 f1          	bt     %rsi,%rcx
    f5ff:	73 0f                	jae    f610 <tp_list_of+0x60>
    f601:	49 ff c4             	inc    %r12
    f604:	4c 89 63 10          	mov    %r12,0x10(%rbx)
    f608:	4c 39 e5             	cmp    %r12,%rbp
    f60b:	75 e3                	jne    f5f0 <tp_list_of+0x40>
    f60d:	49 89 ec             	mov    %rbp,%r12
    f610:	4c 89 ff             	mov    %r15,%rdi
    f613:	e8 58 3b ff ff       	call   3170 <strlen@plt>
    f618:	49 89 c5             	mov    %rax,%r13
    f61b:	48 89 e9             	mov    %rbp,%rcx
    f61e:	4c 29 e1             	sub    %r12,%rcx
    f621:	31 c0                	xor    %eax,%eax
    f623:	4c 39 e9             	cmp    %r13,%rcx
    f626:	72 1d                	jb     f645 <tp_list_of+0x95>
    f628:	4c 89 74 24 08       	mov    %r14,0x8(%rsp)
    f62d:	4c 8b 33             	mov    (%rbx),%r14
    f630:	4b 8d 3c 26          	lea    (%r14,%r12,1),%rdi
    f634:	4c 89 fe             	mov    %r15,%rsi
    f637:	4c 89 ea             	mov    %r13,%rdx
    f63a:	e8 31 3d ff ff       	call   3370 <bcmp@plt>
    f63f:	85 c0                	test   %eax,%eax
    f641:	74 11                	je     f654 <tp_list_of+0xa4>
    f643:	31 c0                	xor    %eax,%eax
    f645:	48 83 c4 18          	add    $0x18,%rsp
    f649:	5b                   	pop    %rbx
    f64a:	41 5c                	pop    %r12
    f64c:	41 5d                	pop    %r13
    f64e:	41 5e                	pop    %r14
    f650:	41 5f                	pop    %r15
    f652:	5d                   	pop    %rbp
    f653:	c3                   	ret
    f654:	4d 01 e5             	add    %r12,%r13
    f657:	4c 89 6b 10          	mov    %r13,0x10(%rbx)
    f65b:	49 bc 00 26 00 00 01 	movabs $0x100002600,%r12
    f662:	00 00 00 
    f665:	49 39 ed             	cmp    %rbp,%r13
    f668:	73 28                	jae    f692 <tp_list_of+0xe2>
    f66a:	48 8b 3c 24          	mov    (%rsp),%rdi
    f66e:	66 90                	xchg   %ax,%ax
    f670:	43 0f b6 04 2e       	movzbl (%r14,%r13,1),%eax
    f675:	48 83 f8 20          	cmp    $0x20,%rax
    f679:	77 1b                	ja     f696 <tp_list_of+0xe6>
    f67b:	49 0f a3 c4          	bt     %rax,%r12
    f67f:	73 15                	jae    f696 <tp_list_of+0xe6>
    f681:	49 ff c5             	inc    %r13
    f684:	4c 89 6b 10          	mov    %r13,0x10(%rbx)
    f688:	4c 39 ed             	cmp    %r13,%rbp
    f68b:	75 e3                	jne    f670 <tp_list_of+0xc0>
    f68d:	49 89 ed             	mov    %rbp,%r13
    f690:	eb 04                	jmp    f696 <tp_list_of+0xe6>
    f692:	48 8b 3c 24          	mov    (%rsp),%rdi
    f696:	e8 d5 3a ff ff       	call   3170 <strlen@plt>
    f69b:	4c 29 ed             	sub    %r13,%rbp
    f69e:	48 39 c5             	cmp    %rax,%rbp
    f6a1:	48 8b 34 24          	mov    (%rsp),%rsi
    f6a5:	72 19                	jb     f6c0 <tp_list_of+0x110>
    f6a7:	49 89 c7             	mov    %rax,%r15
    f6aa:	4d 01 ee             	add    %r13,%r14
    f6ad:	4c 89 f7             	mov    %r14,%rdi
    f6b0:	48 89 c2             	mov    %rax,%rdx
    f6b3:	e8 b8 3c ff ff       	call   3370 <bcmp@plt>
    f6b8:	85 c0                	test   %eax,%eax
    f6ba:	0f 84 da 00 00 00    	je     f79a <tp_list_of+0x1ea>
    f6c0:	48 89 df             	mov    %rbx,%rdi
    f6c3:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    f6c8:	ff 54 24 10          	call   *0x10(%rsp)
    f6cc:	85 c0                	test   %eax,%eax
    f6ce:	0f 84 6f ff ff ff    	je     f643 <tp_list_of+0x93>
    f6d4:	4c 8b 6b 08          	mov    0x8(%rbx),%r13
    f6d8:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    f6dc:	4d 39 ee             	cmp    %r13,%r14
    f6df:	73 31                	jae    f712 <tp_list_of+0x162>
    f6e1:	48 8b 03             	mov    (%rbx),%rax
    f6e4:	48 8b 2c 24          	mov    (%rsp),%rbp
    f6e8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    f6ef:	00 
    f6f0:	42 0f b6 0c 30       	movzbl (%rax,%r14,1),%ecx
    f6f5:	48 83 f9 20          	cmp    $0x20,%rcx
    f6f9:	77 1b                	ja     f716 <tp_list_of+0x166>
    f6fb:	49 0f a3 cc          	bt     %rcx,%r12
    f6ff:	73 15                	jae    f716 <tp_list_of+0x166>
    f701:	49 ff c6             	inc    %r14
    f704:	4c 89 73 10          	mov    %r14,0x10(%rbx)
    f708:	4d 39 f5             	cmp    %r14,%r13
    f70b:	75 e3                	jne    f6f0 <tp_list_of+0x140>
    f70d:	4d 89 ee             	mov    %r13,%r14
    f710:	eb 04                	jmp    f716 <tp_list_of+0x166>
    f712:	48 8b 2c 24          	mov    (%rsp),%rbp
    f716:	48 89 ef             	mov    %rbp,%rdi
    f719:	e8 52 3a ff ff       	call   3170 <strlen@plt>
    f71e:	49 89 c7             	mov    %rax,%r15
    f721:	4c 89 e8             	mov    %r13,%rax
    f724:	4c 29 f0             	sub    %r14,%rax
    f727:	4c 39 f8             	cmp    %r15,%rax
    f72a:	72 15                	jb     f741 <tp_list_of+0x191>
    f72c:	48 8b 3b             	mov    (%rbx),%rdi
    f72f:	4c 01 f7             	add    %r14,%rdi
    f732:	48 89 ee             	mov    %rbp,%rsi
    f735:	4c 89 fa             	mov    %r15,%rdx
    f738:	e8 33 3c ff ff       	call   3370 <bcmp@plt>
    f73d:	85 c0                	test   %eax,%eax
    f73f:	74 6a                	je     f7ab <tp_list_of+0x1fb>
    f741:	4d 39 f5             	cmp    %r14,%r13
    f744:	76 2c                	jbe    f772 <tp_list_of+0x1c2>
    f746:	48 8b 03             	mov    (%rbx),%rax
    f749:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    f750:	42 0f b6 0c 30       	movzbl (%rax,%r14,1),%ecx
    f755:	48 83 f9 20          	cmp    $0x20,%rcx
    f759:	77 17                	ja     f772 <tp_list_of+0x1c2>
    f75b:	49 0f a3 cc          	bt     %rcx,%r12
    f75f:	73 11                	jae    f772 <tp_list_of+0x1c2>
    f761:	49 ff c6             	inc    %r14
    f764:	4c 89 73 10          	mov    %r14,0x10(%rbx)
    f768:	4d 39 f5             	cmp    %r14,%r13
    f76b:	75 e3                	jne    f750 <tp_list_of+0x1a0>
    f76d:	e9 d1 fe ff ff       	jmp    f643 <tp_list_of+0x93>
    f772:	4d 39 f5             	cmp    %r14,%r13
    f775:	b8 00 00 00 00       	mov    $0x0,%eax
    f77a:	0f 84 c5 fe ff ff    	je     f645 <tp_list_of+0x95>
    f780:	48 8b 0b             	mov    (%rbx),%rcx
    f783:	42 80 3c 31 2c       	cmpb   $0x2c,(%rcx,%r14,1)
    f788:	0f 85 b7 fe ff ff    	jne    f645 <tp_list_of+0x95>
    f78e:	49 ff c6             	inc    %r14
    f791:	4c 89 73 10          	mov    %r14,0x10(%rbx)
    f795:	e9 26 ff ff ff       	jmp    f6c0 <tp_list_of+0x110>
    f79a:	4d 01 ef             	add    %r13,%r15
    f79d:	4c 89 7b 10          	mov    %r15,0x10(%rbx)
    f7a1:	b8 01 00 00 00       	mov    $0x1,%eax
    f7a6:	e9 9a fe ff ff       	jmp    f645 <tp_list_of+0x95>
    f7ab:	4d 01 f7             	add    %r14,%r15
    f7ae:	eb ed                	jmp    f79d <tp_list_of+0x1ed>

000000000000f7b0 <tp_byte_item>:
    f7b0:	53                   	push   %rbx
    f7b1:	48 83 ec 10          	sub    $0x10,%rsp
    f7b5:	48 89 f3             	mov    %rsi,%rbx
    f7b8:	48 8d 35 e1 94 00 00 	lea    0x94e1(%rip),%rsi        # 18ca0 <tp_byte_item.u8d>
    f7bf:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    f7c4:	e8 97 f2 ff ff       	call   ea60 <tp_int>
    f7c9:	85 c0                	test   %eax,%eax
    f7cb:	74 14                	je     f7e1 <tp_byte_item+0x31>
    f7cd:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    f7d2:	48 89 df             	mov    %rbx,%rdi
    f7d5:	e8 e6 07 00 00       	call   ffc0 <tp_push>
    f7da:	b8 01 00 00 00       	mov    $0x1,%eax
    f7df:	eb 02                	jmp    f7e3 <tp_byte_item+0x33>
    f7e1:	31 c0                	xor    %eax,%eax
    f7e3:	48 83 c4 10          	add    $0x10,%rsp
    f7e7:	5b                   	pop    %rbx
    f7e8:	c3                   	ret
    f7e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000f7f0 <tp_token>:
    f7f0:	41 57                	push   %r15
    f7f2:	41 56                	push   %r14
    f7f4:	41 54                	push   %r12
    f7f6:	53                   	push   %rbx
    f7f7:	50                   	push   %rax
    f7f8:	49 89 f6             	mov    %rsi,%r14
    f7fb:	48 89 fb             	mov    %rdi,%rbx
    f7fe:	48 8b 37             	mov    (%rdi),%rsi
    f801:	48 8b 47 08          	mov    0x8(%rdi),%rax
    f805:	4c 8b 67 10          	mov    0x10(%rdi),%r12
    f809:	49 39 c4             	cmp    %rax,%r12
    f80c:	73 37                	jae    f845 <tp_token+0x55>
    f80e:	48 b9 00 26 00 00 01 	movabs $0x100002600,%rcx
    f815:	00 00 00 
    f818:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    f81f:	00 
    f820:	42 0f b6 3c 26       	movzbl (%rsi,%r12,1),%edi
    f825:	48 83 ff 20          	cmp    $0x20,%rdi
    f829:	77 1a                	ja     f845 <tp_token+0x55>
    f82b:	48 0f a3 f9          	bt     %rdi,%rcx
    f82f:	73 14                	jae    f845 <tp_token+0x55>
    f831:	49 ff c4             	inc    %r12
    f834:	4c 89 63 10          	mov    %r12,0x10(%rbx)
    f838:	4c 39 e0             	cmp    %r12,%rax
    f83b:	75 e3                	jne    f820 <tp_token+0x30>
    f83d:	49 89 c4             	mov    %rax,%r12
    f840:	48 89 c1             	mov    %rax,%rcx
    f843:	eb 49                	jmp    f88e <tp_token+0x9e>
    f845:	49 39 c4             	cmp    %rax,%r12
    f848:	73 41                	jae    f88b <tp_token+0x9b>
    f84a:	48 8d 3d fb 4a 00 00 	lea    0x4afb(%rip),%rdi        # 1434c <_IO_stdin_used+0x34c>
    f851:	4c 89 e1             	mov    %r12,%rcx
    f854:	eb 1c                	jmp    f872 <tp_token+0x82>
    f856:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    f85d:	00 00 00 
    f860:	41 83 f8 7d          	cmp    $0x7d,%r8d
    f864:	74 28                	je     f88e <tp_token+0x9e>
    f866:	48 ff c1             	inc    %rcx
    f869:	48 89 4b 10          	mov    %rcx,0x10(%rbx)
    f86d:	48 39 c8             	cmp    %rcx,%rax
    f870:	74 ce                	je     f840 <tp_token+0x50>
    f872:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
    f877:	45 8d 48 f7          	lea    -0x9(%r8),%r9d
    f87b:	41 83 f9 54          	cmp    $0x54,%r9d
    f87f:	77 df                	ja     f860 <tp_token+0x70>
    f881:	4e 63 04 8f          	movslq (%rdi,%r9,4),%r8
    f885:	49 01 f8             	add    %rdi,%r8
    f888:	41 ff e0             	jmp    *%r8
    f88b:	4c 89 e1             	mov    %r12,%rcx
    f88e:	4c 29 e1             	sub    %r12,%rcx
    f891:	4c 8d 7a ff          	lea    -0x1(%rdx),%r15
    f895:	48 39 d1             	cmp    %rdx,%rcx
    f898:	4c 0f 42 f9          	cmovb  %rcx,%r15
    f89c:	4c 01 e6             	add    %r12,%rsi
    f89f:	4c 89 f7             	mov    %r14,%rdi
    f8a2:	4c 89 fa             	mov    %r15,%rdx
    f8a5:	e8 86 3a ff ff       	call   3330 <memcpy@plt>
    f8aa:	43 c6 04 3e 00       	movb   $0x0,(%r14,%r15,1)
    f8af:	48 8b 43 10          	mov    0x10(%rbx),%rax
    f8b3:	4c 29 e0             	sub    %r12,%rax
    f8b6:	48 83 c4 08          	add    $0x8,%rsp
    f8ba:	5b                   	pop    %rbx
    f8bb:	41 5c                	pop    %r12
    f8bd:	41 5e                	pop    %r14
    f8bf:	41 5f                	pop    %r15
    f8c1:	c3                   	ret
    f8c2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    f8c9:	1f 84 00 00 00 00 00 

000000000000f8d0 <tp_elem_item>:
    f8d0:	55                   	push   %rbp
    f8d1:	53                   	push   %rbx
    f8d2:	50                   	push   %rax
    f8d3:	48 89 f3             	mov    %rsi,%rbx
    f8d6:	48 8b 36             	mov    (%rsi),%rsi
    f8d9:	31 ed                	xor    %ebp,%ebp
    f8db:	48 89 e1             	mov    %rsp,%rcx
    f8de:	31 d2                	xor    %edx,%edx
    f8e0:	e8 6b d9 ff ff       	call   d250 <tp_value>
    f8e5:	85 c0                	test   %eax,%eax
    f8e7:	74 11                	je     f8fa <tp_elem_item+0x2a>
    f8e9:	48 8b 34 24          	mov    (%rsp),%rsi
    f8ed:	48 89 df             	mov    %rbx,%rdi
    f8f0:	e8 cb 06 00 00       	call   ffc0 <tp_push>
    f8f5:	bd 01 00 00 00       	mov    $0x1,%ebp
    f8fa:	89 e8                	mov    %ebp,%eax
    f8fc:	48 83 c4 08          	add    $0x8,%rsp
    f900:	5b                   	pop    %rbx
    f901:	5d                   	pop    %rbp
    f902:	c3                   	ret
    f903:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    f90a:	84 00 00 00 00 00 

000000000000f910 <tp_kv_item>:
    f910:	55                   	push   %rbp
    f911:	41 56                	push   %r14
    f913:	53                   	push   %rbx
    f914:	48 83 ec 10          	sub    $0x10,%rsp
    f918:	48 89 f3             	mov    %rsi,%rbx
    f91b:	49 89 fe             	mov    %rdi,%r14
    f91e:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
    f925:	00 
    f926:	48 8b 36             	mov    (%rsi),%rsi
    f929:	31 ed                	xor    %ebp,%ebp
    f92b:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    f930:	31 d2                	xor    %edx,%edx
    f932:	e8 19 d9 ff ff       	call   d250 <tp_value>
    f937:	85 c0                	test   %eax,%eax
    f939:	74 26                	je     f961 <tp_kv_item+0x51>
    f93b:	83 7b 28 00          	cmpl   $0x0,0x28(%rbx)
    f93f:	74 2b                	je     f96c <tp_kv_item+0x5c>
    f941:	45 31 f6             	xor    %r14d,%r14d
    f944:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    f949:	48 89 df             	mov    %rbx,%rdi
    f94c:	e8 6f 06 00 00       	call   ffc0 <tp_push>
    f951:	48 89 df             	mov    %rbx,%rdi
    f954:	4c 89 f6             	mov    %r14,%rsi
    f957:	e8 64 06 00 00       	call   ffc0 <tp_push>
    f95c:	bd 01 00 00 00       	mov    $0x1,%ebp
    f961:	89 e8                	mov    %ebp,%eax
    f963:	48 83 c4 10          	add    $0x10,%rsp
    f967:	5b                   	pop    %rbx
    f968:	41 5e                	pop    %r14
    f96a:	5d                   	pop    %rbp
    f96b:	c3                   	ret
    f96c:	49 8b 4e 08          	mov    0x8(%r14),%rcx
    f970:	49 8b 46 10          	mov    0x10(%r14),%rax
    f974:	48 39 c8             	cmp    %rcx,%rax
    f977:	73 37                	jae    f9b0 <tp_kv_item+0xa0>
    f979:	49 8b 16             	mov    (%r14),%rdx
    f97c:	48 be 00 26 00 00 01 	movabs $0x100002600,%rsi
    f983:	00 00 00 
    f986:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    f98d:	00 00 00 
    f990:	0f b6 3c 02          	movzbl (%rdx,%rax,1),%edi
    f994:	48 83 ff 20          	cmp    $0x20,%rdi
    f998:	77 16                	ja     f9b0 <tp_kv_item+0xa0>
    f99a:	48 0f a3 fe          	bt     %rdi,%rsi
    f99e:	73 10                	jae    f9b0 <tp_kv_item+0xa0>
    f9a0:	48 ff c0             	inc    %rax
    f9a3:	49 89 46 10          	mov    %rax,0x10(%r14)
    f9a7:	48 39 c1             	cmp    %rax,%rcx
    f9aa:	75 e4                	jne    f990 <tp_kv_item+0x80>
    f9ac:	31 ed                	xor    %ebp,%ebp
    f9ae:	eb b1                	jmp    f961 <tp_kv_item+0x51>
    f9b0:	31 ed                	xor    %ebp,%ebp
    f9b2:	48 39 c1             	cmp    %rax,%rcx
    f9b5:	74 aa                	je     f961 <tp_kv_item+0x51>
    f9b7:	49 8b 0e             	mov    (%r14),%rcx
    f9ba:	80 3c 01 3a          	cmpb   $0x3a,(%rcx,%rax,1)
    f9be:	75 a1                	jne    f961 <tp_kv_item+0x51>
    f9c0:	48 ff c0             	inc    %rax
    f9c3:	49 89 46 10          	mov    %rax,0x10(%r14)
    f9c7:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    f9cb:	31 ed                	xor    %ebp,%ebp
    f9cd:	48 89 e1             	mov    %rsp,%rcx
    f9d0:	4c 89 f7             	mov    %r14,%rdi
    f9d3:	31 d2                	xor    %edx,%edx
    f9d5:	e8 76 d8 ff ff       	call   d250 <tp_value>
    f9da:	85 c0                	test   %eax,%eax
    f9dc:	74 83                	je     f961 <tp_kv_item+0x51>
    f9de:	4c 8b 34 24          	mov    (%rsp),%r14
    f9e2:	e9 5d ff ff ff       	jmp    f944 <tp_kv_item+0x34>
    f9e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    f9ee:	00 00 

000000000000f9f0 <fwp_p_map_insert>:
    f9f0:	55                   	push   %rbp
    f9f1:	41 57                	push   %r15
    f9f3:	41 56                	push   %r14
    f9f5:	41 55                	push   %r13
    f9f7:	41 54                	push   %r12
    f9f9:	53                   	push   %rbx
    f9fa:	48 83 ec 28          	sub    $0x28,%rsp
    f9fe:	49 89 d7             	mov    %rdx,%r15
    fa01:	49 89 f8             	mov    %rdi,%r8
    fa04:	48 8b 1a             	mov    (%rdx),%rbx
    fa07:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
    fa0c:	8b 01                	mov    (%rcx),%eax
    fa0e:	83 f8 04             	cmp    $0x4,%eax
    fa11:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
    fa16:	72 61                	jb     fa79 <fwp_p_map_insert+0x89>
    fa18:	83 c0 fb             	add    $0xfffffffb,%eax
    fa1b:	83 f8 04             	cmp    $0x4,%eax
    fa1e:	0f 83 b7 00 00 00    	jae    fadb <fwp_p_map_insert+0xeb>
    fa24:	48 85 db             	test   %rbx,%rbx
    fa27:	0f 84 1d 01 00 00    	je     fb4a <fwp_p_map_insert+0x15a>
    fa2d:	45 31 e4             	xor    %r12d,%r12d
    fa30:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    fa37:	ff ff 1f 
    fa3a:	48 89 d9             	mov    %rbx,%rcx
    fa3d:	eb 0d                	jmp    fa4c <fwp_p_map_insert+0x5c>
    fa3f:	90                   	nop
    fa40:	48 89 d1             	mov    %rdx,%rcx
    fa43:	49 39 cc             	cmp    %rcx,%r12
    fa46:	0f 83 04 01 00 00    	jae    fb50 <fwp_p_map_insert+0x160>
    fa4c:	4a 8d 34 21          	lea    (%rcx,%r12,1),%rsi
    fa50:	48 89 f2             	mov    %rsi,%rdx
    fa53:	48 d1 ea             	shr    $1,%rdx
    fa56:	48 21 c6             	and    %rax,%rsi
    fa59:	49 8b 74 f7 08       	mov    0x8(%r15,%rsi,8),%rsi
    fa5e:	4c 39 c6             	cmp    %r8,%rsi
    fa61:	41 0f 95 c6          	setne  %r14b
    fa65:	74 6f                	je     fad6 <fwp_p_map_insert+0xe6>
    fa67:	73 d7                	jae    fa40 <fwp_p_map_insert+0x50>
    fa69:	48 ff c2             	inc    %rdx
    fa6c:	49 89 d4             	mov    %rdx,%r12
    fa6f:	49 39 cc             	cmp    %rcx,%r12
    fa72:	72 d8                	jb     fa4c <fwp_p_map_insert+0x5c>
    fa74:	e9 d7 00 00 00       	jmp    fb50 <fwp_p_map_insert+0x160>
    fa79:	48 85 db             	test   %rbx,%rbx
    fa7c:	0f 84 c8 00 00 00    	je     fb4a <fwp_p_map_insert+0x15a>
    fa82:	45 31 e4             	xor    %r12d,%r12d
    fa85:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    fa8c:	ff ff 1f 
    fa8f:	48 89 d9             	mov    %rbx,%rcx
    fa92:	eb 18                	jmp    faac <fwp_p_map_insert+0xbc>
    fa94:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    fa9b:	00 00 00 00 00 
    faa0:	48 89 d1             	mov    %rdx,%rcx
    faa3:	49 39 cc             	cmp    %rcx,%r12
    faa6:	0f 83 a4 00 00 00    	jae    fb50 <fwp_p_map_insert+0x160>
    faac:	4a 8d 34 21          	lea    (%rcx,%r12,1),%rsi
    fab0:	48 89 f2             	mov    %rsi,%rdx
    fab3:	48 d1 ea             	shr    $1,%rdx
    fab6:	48 21 c6             	and    %rax,%rsi
    fab9:	49 8b 74 f7 08       	mov    0x8(%r15,%rsi,8),%rsi
    fabe:	4c 39 c6             	cmp    %r8,%rsi
    fac1:	41 0f 95 c6          	setne  %r14b
    fac5:	74 0f                	je     fad6 <fwp_p_map_insert+0xe6>
    fac7:	7d d7                	jge    faa0 <fwp_p_map_insert+0xb0>
    fac9:	48 ff c2             	inc    %rdx
    facc:	49 89 d4             	mov    %rdx,%r12
    facf:	49 39 cc             	cmp    %rcx,%r12
    fad2:	72 d8                	jb     faac <fwp_p_map_insert+0xbc>
    fad4:	eb 7a                	jmp    fb50 <fwp_p_map_insert+0x160>
    fad6:	49 89 d4             	mov    %rdx,%r12
    fad9:	eb 75                	jmp    fb50 <fwp_p_map_insert+0x160>
    fadb:	48 85 db             	test   %rbx,%rbx
    fade:	74 6a                	je     fb4a <fwp_p_map_insert+0x15a>
    fae0:	45 31 e4             	xor    %r12d,%r12d
    fae3:	48 89 d8             	mov    %rbx,%rax
    fae6:	48 89 5c 24 08       	mov    %rbx,0x8(%rsp)
    faeb:	eb 13                	jmp    fb00 <fwp_p_map_insert+0x110>
    faed:	0f 1f 00             	nopl   (%rax)
    faf0:	48 89 d8             	mov    %rbx,%rax
    faf3:	49 89 e8             	mov    %rbp,%r8
    faf6:	49 39 c4             	cmp    %rax,%r12
    faf9:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    fafe:	73 50                	jae    fb50 <fwp_p_map_insert+0x160>
    fb00:	49 89 c5             	mov    %rax,%r13
    fb03:	4c 01 e0             	add    %r12,%rax
    fb06:	48 89 c3             	mov    %rax,%rbx
    fb09:	48 d1 eb             	shr    $1,%rbx
    fb0c:	48 b9 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rcx
    fb13:	ff ff 1f 
    fb16:	48 21 c8             	and    %rcx,%rax
    fb19:	49 8b 7c c7 08       	mov    0x8(%r15,%rax,8),%rdi
    fb1e:	4c 89 c5             	mov    %r8,%rbp
    fb21:	4c 89 c6             	mov    %r8,%rsi
    fb24:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    fb29:	e8 d2 05 00 00       	call   10100 <fwp_cmp>
    fb2e:	85 c0                	test   %eax,%eax
    fb30:	41 0f 95 c6          	setne  %r14b
    fb34:	0f 84 5b 01 00 00    	je     fc95 <fwp_p_map_insert+0x2a5>
    fb3a:	79 b4                	jns    faf0 <fwp_p_map_insert+0x100>
    fb3c:	48 ff c3             	inc    %rbx
    fb3f:	49 89 dc             	mov    %rbx,%r12
    fb42:	49 89 e8             	mov    %rbp,%r8
    fb45:	4c 89 e8             	mov    %r13,%rax
    fb48:	eb ac                	jmp    faf6 <fwp_p_map_insert+0x106>
    fb4a:	41 b6 01             	mov    $0x1,%r14b
    fb4d:	45 31 e4             	xor    %r12d,%r12d
    fb50:	41 0f b6 ee          	movzbl %r14b,%ebp
    fb54:	48 01 dd             	add    %rbx,%rbp
    fb57:	48 89 e9             	mov    %rbp,%rcx
    fb5a:	48 c1 e1 04          	shl    $0x4,%rcx
    fb5e:	48 8d 79 08          	lea    0x8(%rcx),%rdi
    fb62:	48 ff 05 bf b1 00 00 	incq   0xb1bf(%rip)        # 1ad28 <measured_calls>
    fb69:	48 01 3d c0 b1 00 00 	add    %rdi,0xb1c0(%rip)        # 1ad30 <measured_bytes>
    fb70:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    fb77:	4c 89 44 24 18       	mov    %r8,0x18(%rsp)
    fb7c:	77 62                	ja     fbe0 <fwp_p_map_insert+0x1f0>
    fb7e:	48 83 c1 17          	add    $0x17,%rcx
    fb82:	48 c1 e9 04          	shr    $0x4,%rcx
    fb86:	48 8d 05 fb 96 00 00 	lea    0x96fb(%rip),%rax        # 19288 <fwp_gc>
    fb8d:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    fb94:	00 
    fb95:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    fb9c:	48 29 15 e5 96 00 00 	sub    %rdx,0x96e5(%rip)        # 19288 <fwp_gc>
    fba3:	78 3b                	js     fbe0 <fwp_p_map_insert+0x1f0>
    fba5:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    fba9:	48 8d 34 c8          	lea    (%rax,%rcx,8),%rsi
    fbad:	48 81 c6 88 07 00 00 	add    $0x788,%rsi
    fbb4:	4c 8b 2e             	mov    (%rsi),%r13
    fbb7:	4d 85 ed             	test   %r13,%r13
    fbba:	74 0c                	je     fbc8 <fwp_p_map_insert+0x1d8>
    fbbc:	49 8b 45 00          	mov    0x0(%r13),%rax
    fbc0:	48 f7 d0             	not    %rax
    fbc3:	48 89 06             	mov    %rax,(%rsi)
    fbc6:	eb 38                	jmp    fc00 <fwp_p_map_insert+0x210>
    fbc8:	4c 8b ac c8 90 07 00 	mov    0x790(%rax,%rcx,8),%r13
    fbcf:	00 
    fbd0:	48 8b b4 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%rsi
    fbd7:	00 
    fbd8:	4c 29 ee             	sub    %r13,%rsi
    fbdb:	48 39 d6             	cmp    %rdx,%rsi
    fbde:	73 0f                	jae    fbef <fwp_p_map_insert+0x1ff>
    fbe0:	be 02 00 00 00       	mov    $0x2,%esi
    fbe5:	e8 36 81 ff ff       	call   7d20 <fwp_gc_alloc_slow>
    fbea:	49 89 c5             	mov    %rax,%r13
    fbed:	eb 1b                	jmp    fc0a <fwp_p_map_insert+0x21a>
    fbef:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    fbf3:	48 05 90 07 00 00    	add    $0x790,%rax
    fbf9:	4a 8d 0c 2a          	lea    (%rdx,%r13,1),%rcx
    fbfd:	48 89 08             	mov    %rcx,(%rax)
    fc00:	4c 89 ef             	mov    %r13,%rdi
    fc03:	31 f6                	xor    %esi,%esi
    fc05:	e8 06 36 ff ff       	call   3210 <memset@plt>
    fc0a:	49 89 6d 00          	mov    %rbp,0x0(%r13)
    fc0e:	49 8d 6d 08          	lea    0x8(%r13),%rbp
    fc12:	49 83 c7 08          	add    $0x8,%r15
    fc16:	45 84 f6             	test   %r14b,%r14b
    fc19:	74 48                	je     fc63 <fwp_p_map_insert+0x273>
    fc1b:	4d 89 e6             	mov    %r12,%r14
    fc1e:	49 c1 e6 04          	shl    $0x4,%r14
    fc22:	48 89 ef             	mov    %rbp,%rdi
    fc25:	4c 89 fe             	mov    %r15,%rsi
    fc28:	4c 89 f2             	mov    %r14,%rdx
    fc2b:	e8 00 37 ff ff       	call   3330 <memcpy@plt>
    fc30:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    fc35:	4b 89 44 35 08       	mov    %rax,0x8(%r13,%r14,1)
    fc3a:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    fc3f:	4b 89 44 35 10       	mov    %rax,0x10(%r13,%r14,1)
    fc44:	49 8d 3c 2e          	lea    (%r14,%rbp,1),%rdi
    fc48:	48 83 c7 10          	add    $0x10,%rdi
    fc4c:	4d 01 fe             	add    %r15,%r14
    fc4f:	4c 29 e3             	sub    %r12,%rbx
    fc52:	48 c1 e3 04          	shl    $0x4,%rbx
    fc56:	4c 89 f6             	mov    %r14,%rsi
    fc59:	48 89 da             	mov    %rbx,%rdx
    fc5c:	e8 cf 36 ff ff       	call   3330 <memcpy@plt>
    fc61:	eb 20                	jmp    fc83 <fwp_p_map_insert+0x293>
    fc63:	48 c1 e3 04          	shl    $0x4,%rbx
    fc67:	48 89 ef             	mov    %rbp,%rdi
    fc6a:	4c 89 fe             	mov    %r15,%rsi
    fc6d:	48 89 da             	mov    %rbx,%rdx
    fc70:	e8 bb 36 ff ff       	call   3330 <memcpy@plt>
    fc75:	49 c1 e4 04          	shl    $0x4,%r12
    fc79:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    fc7e:	4b 89 44 25 10       	mov    %rax,0x10(%r13,%r12,1)
    fc83:	4c 89 e8             	mov    %r13,%rax
    fc86:	48 83 c4 28          	add    $0x28,%rsp
    fc8a:	5b                   	pop    %rbx
    fc8b:	41 5c                	pop    %r12
    fc8d:	41 5d                	pop    %r13
    fc8f:	41 5e                	pop    %r14
    fc91:	41 5f                	pop    %r15
    fc93:	5d                   	pop    %rbp
    fc94:	c3                   	ret
    fc95:	49 89 dc             	mov    %rbx,%r12
    fc98:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    fc9d:	49 89 e8             	mov    %rbp,%r8
    fca0:	e9 ab fe ff ff       	jmp    fb50 <fwp_p_map_insert+0x160>
    fca5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    fcac:	00 00 00 00 

000000000000fcb0 <fwp_record>:
    fcb0:	85 ff                	test   %edi,%edi
    fcb2:	0f 84 aa 00 00 00    	je     fd62 <fwp_record+0xb2>
    fcb8:	55                   	push   %rbp
    fcb9:	41 56                	push   %r14
    fcbb:	53                   	push   %rbx
    fcbc:	48 89 f3             	mov    %rsi,%rbx
    fcbf:	41 89 fe             	mov    %edi,%r14d
    fcc2:	4a 8d 04 f5 08 00 00 	lea    0x8(,%r14,8),%rax
    fcc9:	00 
    fcca:	89 fd                	mov    %edi,%ebp
    fccc:	48 89 c7             	mov    %rax,%rdi
    fccf:	e8 6c a5 ff ff       	call   a240 <fwp_alloc_init>
    fcd4:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    fcda:	89 68 04             	mov    %ebp,0x4(%rax)
    fcdd:	83 fd 08             	cmp    $0x8,%ebp
    fce0:	72 10                	jb     fcf2 <fwp_record+0x42>
    fce2:	48 89 c1             	mov    %rax,%rcx
    fce5:	48 29 d9             	sub    %rbx,%rcx
    fce8:	48 83 c1 08          	add    $0x8,%rcx
    fcec:	48 83 f9 20          	cmp    $0x20,%rcx
    fcf0:	73 73                	jae    fd65 <fwp_record+0xb5>
    fcf2:	31 c9                	xor    %ecx,%ecx
    fcf4:	4c 89 f6             	mov    %r14,%rsi
    fcf7:	48 89 ca             	mov    %rcx,%rdx
    fcfa:	48 83 e6 03          	and    $0x3,%rsi
    fcfe:	74 21                	je     fd21 <fwp_record+0x71>
    fd00:	48 89 ca             	mov    %rcx,%rdx
    fd03:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    fd0a:	84 00 00 00 00 00 
    fd10:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    fd14:	48 89 7c d0 08       	mov    %rdi,0x8(%rax,%rdx,8)
    fd19:	48 ff c2             	inc    %rdx
    fd1c:	48 ff ce             	dec    %rsi
    fd1f:	75 ef                	jne    fd10 <fwp_record+0x60>
    fd21:	4c 29 f1             	sub    %r14,%rcx
    fd24:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    fd28:	77 7b                	ja     fda5 <fwp_record+0xf5>
    fd2a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    fd30:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    fd34:	48 89 4c d0 08       	mov    %rcx,0x8(%rax,%rdx,8)
    fd39:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    fd3e:	48 89 4c d0 10       	mov    %rcx,0x10(%rax,%rdx,8)
    fd43:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    fd48:	48 89 4c d0 18       	mov    %rcx,0x18(%rax,%rdx,8)
    fd4d:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    fd52:	48 89 4c d0 20       	mov    %rcx,0x20(%rax,%rdx,8)
    fd57:	48 83 c2 04          	add    $0x4,%rdx
    fd5b:	49 39 d6             	cmp    %rdx,%r14
    fd5e:	75 d0                	jne    fd30 <fwp_record+0x80>
    fd60:	eb 43                	jmp    fda5 <fwp_record+0xf5>
    fd62:	31 c0                	xor    %eax,%eax
    fd64:	c3                   	ret
    fd65:	44 89 f1             	mov    %r14d,%ecx
    fd68:	83 e1 fc             	and    $0xfffffffc,%ecx
    fd6b:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
    fd72:	00 
    fd73:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    fd77:	31 f6                	xor    %esi,%esi
    fd79:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    fd80:	0f 10 04 33          	movups (%rbx,%rsi,1),%xmm0
    fd84:	0f 10 4c 33 10       	movups 0x10(%rbx,%rsi,1),%xmm1
    fd89:	0f 11 44 30 08       	movups %xmm0,0x8(%rax,%rsi,1)
    fd8e:	0f 11 4c 30 18       	movups %xmm1,0x18(%rax,%rsi,1)
    fd93:	48 83 c6 20          	add    $0x20,%rsi
    fd97:	48 39 f2             	cmp    %rsi,%rdx
    fd9a:	75 e4                	jne    fd80 <fwp_record+0xd0>
    fd9c:	4c 39 f1             	cmp    %r14,%rcx
    fd9f:	0f 85 4f ff ff ff    	jne    fcf4 <fwp_record+0x44>
    fda5:	5b                   	pop    %rbx
    fda6:	41 5e                	pop    %r14
    fda8:	5d                   	pop    %rbp
    fda9:	c3                   	ret
    fdaa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000fdb0 <fwp_box_u128>:
    fdb0:	41 56                	push   %r14
    fdb2:	53                   	push   %rbx
    fdb3:	50                   	push   %rax
    fdb4:	48 ff 05 6d af 00 00 	incq   0xaf6d(%rip)        # 1ad28 <measured_calls>
    fdbb:	48 83 05 6d af 00 00 	addq   $0x10,0xaf6d(%rip)        # 1ad30 <measured_bytes>
    fdc2:	10 
    fdc3:	48 8d 0d be 94 00 00 	lea    0x94be(%rip),%rcx        # 19288 <fwp_gc>
    fdca:	0f b6 05 a0 a0 00 00 	movzbl 0xa0a0(%rip),%eax        # 19e71 <fwp_gc+0xbe9>
    fdd1:	8b 94 81 48 0b 00 00 	mov    0xb48(%rcx,%rax,4),%edx
    fdd8:	48 29 15 a9 94 00 00 	sub    %rdx,0x94a9(%rip)        # 19288 <fwp_gc>
    fddf:	78 3a                	js     fe1b <fwp_box_u128+0x6b>
    fde1:	4c 8d 04 40          	lea    (%rax,%rax,2),%r8
    fde5:	4e 8d 0c c1          	lea    (%rcx,%r8,8),%r9
    fde9:	49 81 c1 c8 03 00 00 	add    $0x3c8,%r9
    fdf0:	49 8b 01             	mov    (%r9),%rax
    fdf3:	48 85 c0             	test   %rax,%rax
    fdf6:	74 0b                	je     fe03 <fwp_box_u128+0x53>
    fdf8:	48 8b 08             	mov    (%rax),%rcx
    fdfb:	48 f7 d1             	not    %rcx
    fdfe:	49 89 09             	mov    %rcx,(%r9)
    fe01:	eb 46                	jmp    fe49 <fwp_box_u128+0x99>
    fe03:	4a 8b 84 c1 d0 03 00 	mov    0x3d0(%rcx,%r8,8),%rax
    fe0a:	00 
    fe0b:	4e 8b 8c c1 d8 03 00 	mov    0x3d8(%rcx,%r8,8),%r9
    fe12:	00 
    fe13:	49 29 c1             	sub    %rax,%r9
    fe16:	49 39 d1             	cmp    %rdx,%r9
    fe19:	73 1d                	jae    fe38 <fwp_box_u128+0x88>
    fe1b:	48 89 fb             	mov    %rdi,%rbx
    fe1e:	bf 10 00 00 00       	mov    $0x10,%edi
    fe23:	49 89 f6             	mov    %rsi,%r14
    fe26:	be 01 00 00 00       	mov    $0x1,%esi
    fe2b:	e8 f0 7e ff ff       	call   7d20 <fwp_gc_alloc_slow>
    fe30:	4c 89 f6             	mov    %r14,%rsi
    fe33:	48 89 df             	mov    %rbx,%rdi
    fe36:	eb 17                	jmp    fe4f <fwp_box_u128+0x9f>
    fe38:	4a 8d 0c c1          	lea    (%rcx,%r8,8),%rcx
    fe3c:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
    fe43:	48 01 c2             	add    %rax,%rdx
    fe46:	48 89 11             	mov    %rdx,(%rcx)
    fe49:	0f 57 c0             	xorps  %xmm0,%xmm0
    fe4c:	0f 11 00             	movups %xmm0,(%rax)
    fe4f:	48 89 70 08          	mov    %rsi,0x8(%rax)
    fe53:	48 89 38             	mov    %rdi,(%rax)
    fe56:	48 83 c4 08          	add    $0x8,%rsp
    fe5a:	5b                   	pop    %rbx
    fe5b:	41 5e                	pop    %r14
    fe5d:	c3                   	ret
    fe5e:	66 90                	xchg   %ax,%ax

000000000000fe60 <fwp_box_i128>:
    fe60:	41 56                	push   %r14
    fe62:	53                   	push   %rbx
    fe63:	50                   	push   %rax
    fe64:	48 ff 05 bd ae 00 00 	incq   0xaebd(%rip)        # 1ad28 <measured_calls>
    fe6b:	48 83 05 bd ae 00 00 	addq   $0x10,0xaebd(%rip)        # 1ad30 <measured_bytes>
    fe72:	10 
    fe73:	48 8d 0d 0e 94 00 00 	lea    0x940e(%rip),%rcx        # 19288 <fwp_gc>
    fe7a:	0f b6 05 f0 9f 00 00 	movzbl 0x9ff0(%rip),%eax        # 19e71 <fwp_gc+0xbe9>
    fe81:	8b 94 81 48 0b 00 00 	mov    0xb48(%rcx,%rax,4),%edx
    fe88:	48 29 15 f9 93 00 00 	sub    %rdx,0x93f9(%rip)        # 19288 <fwp_gc>
    fe8f:	78 3a                	js     fecb <fwp_box_i128+0x6b>
    fe91:	4c 8d 04 40          	lea    (%rax,%rax,2),%r8
    fe95:	4e 8d 0c c1          	lea    (%rcx,%r8,8),%r9
    fe99:	49 81 c1 c8 03 00 00 	add    $0x3c8,%r9
    fea0:	49 8b 01             	mov    (%r9),%rax
    fea3:	48 85 c0             	test   %rax,%rax
    fea6:	74 0b                	je     feb3 <fwp_box_i128+0x53>
    fea8:	48 8b 08             	mov    (%rax),%rcx
    feab:	48 f7 d1             	not    %rcx
    feae:	49 89 09             	mov    %rcx,(%r9)
    feb1:	eb 46                	jmp    fef9 <fwp_box_i128+0x99>
    feb3:	4a 8b 84 c1 d0 03 00 	mov    0x3d0(%rcx,%r8,8),%rax
    feba:	00 
    febb:	4e 8b 8c c1 d8 03 00 	mov    0x3d8(%rcx,%r8,8),%r9
    fec2:	00 
    fec3:	49 29 c1             	sub    %rax,%r9
    fec6:	49 39 d1             	cmp    %rdx,%r9
    fec9:	73 1d                	jae    fee8 <fwp_box_i128+0x88>
    fecb:	48 89 fb             	mov    %rdi,%rbx
    fece:	bf 10 00 00 00       	mov    $0x10,%edi
    fed3:	49 89 f6             	mov    %rsi,%r14
    fed6:	be 01 00 00 00       	mov    $0x1,%esi
    fedb:	e8 40 7e ff ff       	call   7d20 <fwp_gc_alloc_slow>
    fee0:	4c 89 f6             	mov    %r14,%rsi
    fee3:	48 89 df             	mov    %rbx,%rdi
    fee6:	eb 17                	jmp    feff <fwp_box_i128+0x9f>
    fee8:	4a 8d 0c c1          	lea    (%rcx,%r8,8),%rcx
    feec:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
    fef3:	48 01 c2             	add    %rax,%rdx
    fef6:	48 89 11             	mov    %rdx,(%rcx)
    fef9:	0f 57 c0             	xorps  %xmm0,%xmm0
    fefc:	0f 11 00             	movups %xmm0,(%rax)
    feff:	48 89 70 08          	mov    %rsi,0x8(%rax)
    ff03:	48 89 38             	mov    %rdi,(%rax)
    ff06:	48 83 c4 08          	add    $0x8,%rsp
    ff0a:	5b                   	pop    %rbx
    ff0b:	41 5e                	pop    %r14
    ff0d:	c3                   	ret
    ff0e:	66 90                	xchg   %ax,%ax

000000000000ff10 <fwp_utf8_put>:
    ff10:	50                   	push   %rax
    ff11:	83 fe 7f             	cmp    $0x7f,%esi
    ff14:	77 0f                	ja     ff25 <fwp_utf8_put+0x15>
    ff16:	40 88 74 24 04       	mov    %sil,0x4(%rsp)
    ff1b:	ba 01 00 00 00       	mov    $0x1,%edx
    ff20:	e9 8e 00 00 00       	jmp    ffb3 <fwp_utf8_put+0xa3>
    ff25:	89 f0                	mov    %esi,%eax
    ff27:	81 fe ff 07 00 00    	cmp    $0x7ff,%esi
    ff2d:	77 1d                	ja     ff4c <fwp_utf8_put+0x3c>
    ff2f:	c1 e8 06             	shr    $0x6,%eax
    ff32:	0c c0                	or     $0xc0,%al
    ff34:	88 44 24 04          	mov    %al,0x4(%rsp)
    ff38:	40 80 e6 3f          	and    $0x3f,%sil
    ff3c:	40 80 ce 80          	or     $0x80,%sil
    ff40:	40 88 74 24 05       	mov    %sil,0x5(%rsp)
    ff45:	ba 02 00 00 00       	mov    $0x2,%edx
    ff4a:	eb 67                	jmp    ffb3 <fwp_utf8_put+0xa3>
    ff4c:	81 fe ff ff 00 00    	cmp    $0xffff,%esi
    ff52:	77 2a                	ja     ff7e <fwp_utf8_put+0x6e>
    ff54:	c1 e8 0c             	shr    $0xc,%eax
    ff57:	0c e0                	or     $0xe0,%al
    ff59:	88 44 24 04          	mov    %al,0x4(%rsp)
    ff5d:	89 f0                	mov    %esi,%eax
    ff5f:	c1 e8 06             	shr    $0x6,%eax
    ff62:	24 3f                	and    $0x3f,%al
    ff64:	0c 80                	or     $0x80,%al
    ff66:	88 44 24 05          	mov    %al,0x5(%rsp)
    ff6a:	40 80 e6 3f          	and    $0x3f,%sil
    ff6e:	40 80 ce 80          	or     $0x80,%sil
    ff72:	40 88 74 24 06       	mov    %sil,0x6(%rsp)
    ff77:	ba 03 00 00 00       	mov    $0x3,%edx
    ff7c:	eb 35                	jmp    ffb3 <fwp_utf8_put+0xa3>
    ff7e:	c1 e8 12             	shr    $0x12,%eax
    ff81:	0c f0                	or     $0xf0,%al
    ff83:	88 44 24 04          	mov    %al,0x4(%rsp)
    ff87:	89 f0                	mov    %esi,%eax
    ff89:	c1 e8 0c             	shr    $0xc,%eax
    ff8c:	24 3f                	and    $0x3f,%al
    ff8e:	0c 80                	or     $0x80,%al
    ff90:	88 44 24 05          	mov    %al,0x5(%rsp)
    ff94:	89 f0                	mov    %esi,%eax
    ff96:	c1 e8 06             	shr    $0x6,%eax
    ff99:	24 3f                	and    $0x3f,%al
    ff9b:	0c 80                	or     $0x80,%al
    ff9d:	88 44 24 06          	mov    %al,0x6(%rsp)
    ffa1:	40 80 e6 3f          	and    $0x3f,%sil
    ffa5:	40 80 ce 80          	or     $0x80,%sil
    ffa9:	40 88 74 24 07       	mov    %sil,0x7(%rsp)
    ffae:	ba 04 00 00 00       	mov    $0x4,%edx
    ffb3:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
    ffb8:	e8 53 cd ff ff       	call   cd10 <buf_put>
    ffbd:	58                   	pop    %rax
    ffbe:	c3                   	ret
    ffbf:	90                   	nop

000000000000ffc0 <tp_push>:
    ffc0:	55                   	push   %rbp
    ffc1:	41 57                	push   %r15
    ffc3:	41 56                	push   %r14
    ffc5:	41 55                	push   %r13
    ffc7:	41 54                	push   %r12
    ffc9:	53                   	push   %rbx
    ffca:	50                   	push   %rax
    ffcb:	48 89 f3             	mov    %rsi,%rbx
    ffce:	49 89 fe             	mov    %rdi,%r14
    ffd1:	4c 8b 7f 18          	mov    0x18(%rdi),%r15
    ffd5:	4c 3b 7f 20          	cmp    0x20(%rdi),%r15
    ffd9:	75 7d                	jne    10058 <tp_push+0x98>
    ffdb:	4b 8d 04 3f          	lea    (%r15,%r15,1),%rax
    ffdf:	4d 85 ff             	test   %r15,%r15
    ffe2:	41 bd 08 00 00 00    	mov    $0x8,%r13d
    ffe8:	4c 0f 45 e8          	cmovne %rax,%r13
    ffec:	4d 89 6e 20          	mov    %r13,0x20(%r14)
    fff0:	4d 8b 66 10          	mov    0x10(%r14),%r12
    fff4:	49 c1 e5 03          	shl    $0x3,%r13
    fff8:	48 ff 05 29 ad 00 00 	incq   0xad29(%rip)        # 1ad28 <measured_calls>
    ffff:	4c 01 2d 2a ad 00 00 	add    %r13,0xad2a(%rip)        # 1ad30 <measured_bytes>
   10006:	49 81 fd 00 40 00 00 	cmp    $0x4000,%r13
   1000d:	77 67                	ja     10076 <tp_push+0xb6>
   1000f:	4c 89 e9             	mov    %r13,%rcx
   10012:	48 c1 e9 04          	shr    $0x4,%rcx
   10016:	48 8d 05 6b 92 00 00 	lea    0x926b(%rip),%rax        # 19288 <fwp_gc>
   1001d:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
   10024:	00 
   10025:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
   1002c:	48 29 15 55 92 00 00 	sub    %rdx,0x9255(%rip)        # 19288 <fwp_gc>
   10033:	78 41                	js     10076 <tp_push+0xb6>
   10035:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
   10039:	48 8d 34 c8          	lea    (%rax,%rcx,8),%rsi
   1003d:	48 81 c6 88 07 00 00 	add    $0x788,%rsi
   10044:	48 8b 2e             	mov    (%rsi),%rbp
   10047:	48 85 ed             	test   %rbp,%rbp
   1004a:	74 12                	je     1005e <tp_push+0x9e>
   1004c:	48 8b 45 00          	mov    0x0(%rbp),%rax
   10050:	48 f7 d0             	not    %rax
   10053:	48 89 06             	mov    %rax,(%rsi)
   10056:	eb 46                	jmp    1009e <tp_push+0xde>
   10058:	49 8b 6e 10          	mov    0x10(%r14),%rbp
   1005c:	eb 78                	jmp    100d6 <tp_push+0x116>
   1005e:	48 8b ac c8 90 07 00 	mov    0x790(%rax,%rcx,8),%rbp
   10065:	00 
   10066:	48 8b b4 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%rsi
   1006d:	00 
   1006e:	48 29 ee             	sub    %rbp,%rsi
   10071:	48 39 d6             	cmp    %rdx,%rsi
   10074:	73 17                	jae    1008d <tp_push+0xcd>
   10076:	4c 89 ef             	mov    %r13,%rdi
   10079:	be 02 00 00 00       	mov    $0x2,%esi
   1007e:	e8 9d 7c ff ff       	call   7d20 <fwp_gc_alloc_slow>
   10083:	48 89 c5             	mov    %rax,%rbp
   10086:	4d 85 e4             	test   %r12,%r12
   10089:	75 22                	jne    100ad <tp_push+0xed>
   1008b:	eb 41                	jmp    100ce <tp_push+0x10e>
   1008d:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
   10091:	48 05 90 07 00 00    	add    $0x790,%rax
   10097:	48 8d 0c 2a          	lea    (%rdx,%rbp,1),%rcx
   1009b:	48 89 08             	mov    %rcx,(%rax)
   1009e:	48 89 ef             	mov    %rbp,%rdi
   100a1:	31 f6                	xor    %esi,%esi
   100a3:	e8 68 31 ff ff       	call   3210 <memset@plt>
   100a8:	4d 85 e4             	test   %r12,%r12
   100ab:	74 21                	je     100ce <tp_push+0x10e>
   100ad:	49 c1 e7 03          	shl    $0x3,%r15
   100b1:	4d 39 ef             	cmp    %r13,%r15
   100b4:	4d 0f 43 fd          	cmovae %r13,%r15
   100b8:	48 89 ef             	mov    %rbp,%rdi
   100bb:	4c 89 e6             	mov    %r12,%rsi
   100be:	4c 89 fa             	mov    %r15,%rdx
   100c1:	e8 6a 32 ff ff       	call   3330 <memcpy@plt>
   100c6:	4c 89 e7             	mov    %r12,%rdi
   100c9:	e8 b2 a4 ff ff       	call   a580 <fwp_mem_free>
   100ce:	49 89 6e 10          	mov    %rbp,0x10(%r14)
   100d2:	4d 8b 7e 18          	mov    0x18(%r14),%r15
   100d6:	49 8d 47 01          	lea    0x1(%r15),%rax
   100da:	49 89 46 18          	mov    %rax,0x18(%r14)
   100de:	4a 89 5c fd 00       	mov    %rbx,0x0(%rbp,%r15,8)
   100e3:	48 83 c4 08          	add    $0x8,%rsp
   100e7:	5b                   	pop    %rbx
   100e8:	41 5c                	pop    %r12
   100ea:	41 5d                	pop    %r13
   100ec:	41 5e                	pop    %r14
   100ee:	41 5f                	pop    %r15
   100f0:	5d                   	pop    %rbp
   100f1:	c3                   	ret
   100f2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   100f9:	1f 84 00 00 00 00 00 

0000000000010100 <fwp_cmp>:
   10100:	55                   	push   %rbp
   10101:	41 57                	push   %r15
   10103:	41 56                	push   %r14
   10105:	41 55                	push   %r13
   10107:	41 54                	push   %r12
   10109:	53                   	push   %rbx
   1010a:	48 83 ec 28          	sub    $0x28,%rsp
   1010e:	48 89 f3             	mov    %rsi,%rbx
   10111:	49 89 fe             	mov    %rdi,%r14
   10114:	44 8b 2a             	mov    (%rdx),%r13d
   10117:	49 83 fd 15          	cmp    $0x15,%r13
   1011b:	77 25                	ja     10142 <fwp_cmp+0x42>
   1011d:	49 89 d7             	mov    %rdx,%r15
   10120:	48 8d 05 79 43 00 00 	lea    0x4379(%rip),%rax        # 144a0 <_IO_stdin_used+0x4a0>
   10127:	4a 63 0c a8          	movslq (%rax,%r13,4),%rcx
   1012b:	48 01 c1             	add    %rax,%rcx
   1012e:	ff e1                	jmp    *%rcx
   10130:	31 c9                	xor    %ecx,%ecx
   10132:	49 39 de             	cmp    %rbx,%r14
   10135:	0f 9f c1             	setg   %cl
   10138:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   1013d:	0f 4d c1             	cmovge %ecx,%eax
   10140:	eb 10                	jmp    10152 <fwp_cmp+0x52>
   10142:	31 c9                	xor    %ecx,%ecx
   10144:	49 39 de             	cmp    %rbx,%r14
   10147:	0f 97 c1             	seta   %cl
   1014a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   1014f:	0f 43 c1             	cmovae %ecx,%eax
   10152:	48 83 c4 28          	add    $0x28,%rsp
   10156:	5b                   	pop    %rbx
   10157:	41 5c                	pop    %r12
   10159:	41 5d                	pop    %r13
   1015b:	41 5e                	pop    %r14
   1015d:	41 5f                	pop    %r15
   1015f:	5d                   	pop    %rbp
   10160:	c3                   	ret
   10161:	4d 8b 3e             	mov    (%r14),%r15
   10164:	4c 8b 23             	mov    (%rbx),%r12
   10167:	49 83 c6 08          	add    $0x8,%r14
   1016b:	48 83 c3 08          	add    $0x8,%rbx
   1016f:	4d 39 e7             	cmp    %r12,%r15
   10172:	4c 89 e2             	mov    %r12,%rdx
   10175:	49 0f 42 d7          	cmovb  %r15,%rdx
   10179:	4c 89 f7             	mov    %r14,%rdi
   1017c:	48 89 de             	mov    %rbx,%rsi
   1017f:	e8 ec 30 ff ff       	call   3270 <memcmp@plt>
   10184:	85 c0                	test   %eax,%eax
   10186:	0f 84 bb 03 00 00    	je     10547 <fwp_cmp+0x447>
   1018c:	c1 f8 1f             	sar    $0x1f,%eax
   1018f:	83 c8 01             	or     $0x1,%eax
   10192:	eb be                	jmp    10152 <fwp_cmp+0x52>
   10194:	49 8b 06             	mov    (%r14),%rax
   10197:	48 8b 2b             	mov    (%rbx),%rbp
   1019a:	48 39 e8             	cmp    %rbp,%rax
   1019d:	48 89 2c 24          	mov    %rbp,(%rsp)
   101a1:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
   101a6:	48 0f 42 e8          	cmovb  %rax,%rbp
   101aa:	48 85 ed             	test   %rbp,%rbp
   101ad:	74 56                	je     10205 <fwp_cmp+0x105>
   101af:	49 8b 47 38          	mov    0x38(%r15),%rax
   101b3:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
   101b8:	41 bc 10 00 00 00    	mov    $0x10,%r12d
   101be:	eb 09                	jmp    101c9 <fwp_cmp+0xc9>
   101c0:	49 83 c4 10          	add    $0x10,%r12
   101c4:	48 ff cd             	dec    %rbp
   101c7:	74 3c                	je     10205 <fwp_cmp+0x105>
   101c9:	4b 8b 7c 26 f8       	mov    -0x8(%r14,%r12,1),%rdi
   101ce:	4a 8b 74 23 f8       	mov    -0x8(%rbx,%r12,1),%rsi
   101d3:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
   101d8:	e8 23 ff ff ff       	call   10100 <fwp_cmp>
   101dd:	85 c0                	test   %eax,%eax
   101df:	0f 85 6d ff ff ff    	jne    10152 <fwp_cmp+0x52>
   101e5:	41 83 fd 12          	cmp    $0x12,%r13d
   101e9:	75 d5                	jne    101c0 <fwp_cmp+0xc0>
   101eb:	4b 8b 3c 26          	mov    (%r14,%r12,1),%rdi
   101ef:	4a 8b 34 23          	mov    (%rbx,%r12,1),%rsi
   101f3:	49 8b 57 40          	mov    0x40(%r15),%rdx
   101f7:	e8 04 ff ff ff       	call   10100 <fwp_cmp>
   101fc:	85 c0                	test   %eax,%eax
   101fe:	74 c0                	je     101c0 <fwp_cmp+0xc0>
   10200:	e9 4d ff ff ff       	jmp    10152 <fwp_cmp+0x52>
   10205:	31 c9                	xor    %ecx,%ecx
   10207:	48 8b 04 24          	mov    (%rsp),%rax
   1020b:	48 39 44 24 08       	cmp    %rax,0x8(%rsp)
   10210:	e9 32 ff ff ff       	jmp    10147 <fwp_cmp+0x47>
   10215:	49 8b 16             	mov    (%r14),%rdx
   10218:	49 8b 4e 08          	mov    0x8(%r14),%rcx
   1021c:	48 8b 3b             	mov    (%rbx),%rdi
   1021f:	48 8b 73 08          	mov    0x8(%rbx),%rsi
   10223:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   10228:	48 39 fa             	cmp    %rdi,%rdx
   1022b:	49 89 c8             	mov    %rcx,%r8
   1022e:	49 19 f0             	sbb    %rsi,%r8
   10231:	0f 82 1b ff ff ff    	jb     10152 <fwp_cmp+0x52>
   10237:	48 39 d7             	cmp    %rdx,%rdi
   1023a:	48 19 ce             	sbb    %rcx,%rsi
   1023d:	0f 92 c0             	setb   %al
   10240:	0f b6 c0             	movzbl %al,%eax
   10243:	e9 0a ff ff ff       	jmp    10152 <fwp_cmp+0x52>
   10248:	44 89 f1             	mov    %r14d,%ecx
   1024b:	c1 f9 1f             	sar    $0x1f,%ecx
   1024e:	d1 e9                	shr    $1,%ecx
   10250:	44 31 f1             	xor    %r14d,%ecx
   10253:	89 da                	mov    %ebx,%edx
   10255:	c1 fa 1f             	sar    $0x1f,%edx
   10258:	d1 ea                	shr    $1,%edx
   1025a:	31 da                	xor    %ebx,%edx
   1025c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   10261:	39 d1                	cmp    %edx,%ecx
   10263:	0f 8c e9 fe ff ff    	jl     10152 <fwp_cmp+0x52>
   10269:	eb 28                	jmp    10293 <fwp_cmp+0x193>
   1026b:	4c 89 f1             	mov    %r14,%rcx
   1026e:	48 c1 f9 3f          	sar    $0x3f,%rcx
   10272:	48 d1 e9             	shr    $1,%rcx
   10275:	4c 31 f1             	xor    %r14,%rcx
   10278:	48 89 da             	mov    %rbx,%rdx
   1027b:	48 c1 fa 3f          	sar    $0x3f,%rdx
   1027f:	48 d1 ea             	shr    $1,%rdx
   10282:	48 31 da             	xor    %rbx,%rdx
   10285:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   1028a:	48 39 d1             	cmp    %rdx,%rcx
   1028d:	0f 8c bf fe ff ff    	jl     10152 <fwp_cmp+0x52>
   10293:	0f 9f c0             	setg   %al
   10296:	0f b6 c0             	movzbl %al,%eax
   10299:	e9 b4 fe ff ff       	jmp    10152 <fwp_cmp+0x52>
   1029e:	49 8b 16             	mov    (%r14),%rdx
   102a1:	49 8b 4e 08          	mov    0x8(%r14),%rcx
   102a5:	48 8b 3b             	mov    (%rbx),%rdi
   102a8:	48 8b 73 08          	mov    0x8(%rbx),%rsi
   102ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   102b1:	48 39 fa             	cmp    %rdi,%rdx
   102b4:	49 89 c8             	mov    %rcx,%r8
   102b7:	49 19 f0             	sbb    %rsi,%r8
   102ba:	0f 8c 92 fe ff ff    	jl     10152 <fwp_cmp+0x52>
   102c0:	48 39 d7             	cmp    %rdx,%rdi
   102c3:	48 19 ce             	sbb    %rcx,%rsi
   102c6:	0f 9c c0             	setl   %al
   102c9:	0f b6 c0             	movzbl %al,%eax
   102cc:	e9 81 fe ff ff       	jmp    10152 <fwp_cmp+0x52>
   102d1:	4d 85 f6             	test   %r14,%r14
   102d4:	0f 94 c0             	sete   %al
   102d7:	74 44                	je     1031d <fwp_cmp+0x21d>
   102d9:	48 85 db             	test   %rbx,%rbx
   102dc:	74 3f                	je     1031d <fwp_cmp+0x21d>
   102de:	4d 8b 7f 38          	mov    0x38(%r15),%r15
   102e2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   102e9:	1f 84 00 00 00 00 00 
   102f0:	49 8b 7e 08          	mov    0x8(%r14),%rdi
   102f4:	48 8b 73 08          	mov    0x8(%rbx),%rsi
   102f8:	4c 89 fa             	mov    %r15,%rdx
   102fb:	e8 00 fe ff ff       	call   10100 <fwp_cmp>
   10300:	85 c0                	test   %eax,%eax
   10302:	0f 85 4a fe ff ff    	jne    10152 <fwp_cmp+0x52>
   10308:	4d 8b 76 10          	mov    0x10(%r14),%r14
   1030c:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
   10310:	4d 85 f6             	test   %r14,%r14
   10313:	0f 94 c0             	sete   %al
   10316:	74 05                	je     1031d <fwp_cmp+0x21d>
   10318:	48 85 db             	test   %rbx,%rbx
   1031b:	75 d3                	jne    102f0 <fwp_cmp+0x1f0>
   1031d:	48 85 db             	test   %rbx,%rbx
   10320:	0f 95 c1             	setne  %cl
   10323:	08 c1                	or     %al,%cl
   10325:	80 f1 01             	xor    $0x1,%cl
   10328:	0f b6 c9             	movzbl %cl,%ecx
   1032b:	84 c0                	test   %al,%al
   1032d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   10332:	0f 44 c1             	cmove  %ecx,%eax
   10335:	48 85 db             	test   %rbx,%rbx
   10338:	0f 44 c1             	cmove  %ecx,%eax
   1033b:	e9 12 fe ff ff       	jmp    10152 <fwp_cmp+0x52>
   10340:	45 8b 67 10          	mov    0x10(%r15),%r12d
   10344:	45 85 e4             	test   %r12d,%r12d
   10347:	0f 8e 5d 02 00 00    	jle    105aa <fwp_cmp+0x4aa>
   1034d:	4d 8b 7f 20          	mov    0x20(%r15),%r15
   10351:	45 31 ed             	xor    %r13d,%r13d
   10354:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
   1035b:	00 00 00 00 00 
   10360:	4b 8b 7c ee 08       	mov    0x8(%r14,%r13,8),%rdi
   10365:	4a 8b 74 eb 08       	mov    0x8(%rbx,%r13,8),%rsi
   1036a:	4b 8b 14 ef          	mov    (%r15,%r13,8),%rdx
   1036e:	e8 8d fd ff ff       	call   10100 <fwp_cmp>
   10373:	85 c0                	test   %eax,%eax
   10375:	0f 85 d7 fd ff ff    	jne    10152 <fwp_cmp+0x52>
   1037b:	49 ff c5             	inc    %r13
   1037e:	31 c0                	xor    %eax,%eax
   10380:	4d 39 ec             	cmp    %r13,%r12
   10383:	75 db                	jne    10360 <fwp_cmp+0x260>
   10385:	e9 c8 fd ff ff       	jmp    10152 <fwp_cmp+0x52>
   1038a:	49 8b 06             	mov    (%r14),%rax
   1038d:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
   10394:	ff ff 7f 
   10397:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
   1039c:	4c 21 e0             	and    %r12,%rax
   1039f:	4c 8b 2b             	mov    (%rbx),%r13
   103a2:	4d 21 ec             	and    %r13,%r12
   103a5:	4c 39 e0             	cmp    %r12,%rax
   103a8:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
   103ad:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
   103b2:	4c 0f 42 e0          	cmovb  %rax,%r12
   103b6:	4d 85 e4             	test   %r12,%r12
   103b9:	0f 84 51 01 00 00    	je     10510 <fwp_cmp+0x410>
   103bf:	4d 8b 7f 38          	mov    0x38(%r15),%r15
   103c3:	49 8d 46 08          	lea    0x8(%r14),%rax
   103c7:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
   103cc:	48 8d 43 08          	lea    0x8(%rbx),%rax
   103d0:	48 89 04 24          	mov    %rax,(%rsp)
   103d4:	31 ed                	xor    %ebp,%ebp
   103d6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   103dd:	00 00 00 
   103e0:	b8 08 00 00 00       	mov    $0x8,%eax
   103e5:	4d 85 ff             	test   %r15,%r15
   103e8:	74 14                	je     103fe <fwp_cmp+0x2fe>
   103ea:	41 8b 0f             	mov    (%r15),%ecx
   103ed:	48 83 f9 0a          	cmp    $0xa,%rcx
   103f1:	77 0b                	ja     103fe <fwp_cmp+0x2fe>
   103f3:	48 8d 05 96 44 00 00 	lea    0x4496(%rip),%rax        # 14890 <exec_in_fp0+0x80>
   103fa:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
   103fe:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
   10403:	48 83 7c 24 10 00    	cmpq   $0x0,0x10(%rsp)
   10409:	79 04                	jns    1040f <fwp_cmp+0x30f>
   1040b:	49 8b 4e 10          	mov    0x10(%r14),%rcx
   1040f:	48 89 c2             	mov    %rax,%rdx
   10412:	48 0f af d5          	imul   %rbp,%rdx
   10416:	48 83 f8 08          	cmp    $0x8,%rax
   1041a:	74 2b                	je     10447 <fwp_cmp+0x347>
   1041c:	48 83 f8 02          	cmp    $0x2,%rax
   10420:	74 15                	je     10437 <fwp_cmp+0x337>
   10422:	48 83 f8 01          	cmp    $0x1,%rax
   10426:	75 2d                	jne    10455 <fwp_cmp+0x355>
   10428:	0f b6 04 11          	movzbl (%rcx,%rdx,1),%eax
   1042c:	41 8b 0f             	mov    (%r15),%ecx
   1042f:	85 c9                	test   %ecx,%ecx
   10431:	48 0f be f8          	movsbq %al,%rdi
   10435:	eb 2a                	jmp    10461 <fwp_cmp+0x361>
   10437:	0f b7 04 11          	movzwl (%rcx,%rdx,1),%eax
   1043b:	41 8b 0f             	mov    (%r15),%ecx
   1043e:	83 f9 01             	cmp    $0x1,%ecx
   10441:	48 0f bf f8          	movswq %ax,%rdi
   10445:	eb 1a                	jmp    10461 <fwp_cmp+0x361>
   10447:	48 8b 3c 11          	mov    (%rcx,%rdx,1),%rdi
   1044b:	4d 85 ff             	test   %r15,%r15
   1044e:	74 4b                	je     1049b <fwp_cmp+0x39b>
   10450:	41 8b 0f             	mov    (%r15),%ecx
   10453:	eb 10                	jmp    10465 <fwp_cmp+0x365>
   10455:	8b 04 11             	mov    (%rcx,%rdx,1),%eax
   10458:	41 8b 0f             	mov    (%r15),%ecx
   1045b:	83 f9 02             	cmp    $0x2,%ecx
   1045e:	48 63 f8             	movslq %eax,%rdi
   10461:	48 0f 45 f8          	cmovne %rax,%rdi
   10465:	83 f9 0a             	cmp    $0xa,%ecx
   10468:	77 31                	ja     1049b <fwp_cmp+0x39b>
   1046a:	b8 84 04 00 00       	mov    $0x484,%eax
   1046f:	0f a3 c8             	bt     %ecx,%eax
   10472:	72 20                	jb     10494 <fwp_cmp+0x394>
   10474:	b8 01 00 00 00       	mov    $0x1,%eax
   10479:	ba 21 00 00 00       	mov    $0x21,%edx
   1047e:	0f a3 ca             	bt     %ecx,%edx
   10481:	72 1d                	jb     104a0 <fwp_cmp+0x3a0>
   10483:	b8 42 00 00 00       	mov    $0x42,%eax
   10488:	0f a3 c8             	bt     %ecx,%eax
   1048b:	73 0e                	jae    1049b <fwp_cmp+0x39b>
   1048d:	b8 02 00 00 00       	mov    $0x2,%eax
   10492:	eb 0c                	jmp    104a0 <fwp_cmp+0x3a0>
   10494:	b8 04 00 00 00       	mov    $0x4,%eax
   10499:	eb 05                	jmp    104a0 <fwp_cmp+0x3a0>
   1049b:	b8 08 00 00 00       	mov    $0x8,%eax
   104a0:	48 8b 0c 24          	mov    (%rsp),%rcx
   104a4:	4d 85 ed             	test   %r13,%r13
   104a7:	79 04                	jns    104ad <fwp_cmp+0x3ad>
   104a9:	48 8b 4b 10          	mov    0x10(%rbx),%rcx
   104ad:	48 89 c2             	mov    %rax,%rdx
   104b0:	48 0f af d5          	imul   %rbp,%rdx
   104b4:	48 83 f8 01          	cmp    $0x1,%rax
   104b8:	74 1e                	je     104d8 <fwp_cmp+0x3d8>
   104ba:	83 f8 02             	cmp    $0x2,%eax
   104bd:	74 0b                	je     104ca <fwp_cmp+0x3ca>
   104bf:	83 f8 08             	cmp    $0x8,%eax
   104c2:	75 22                	jne    104e6 <fwp_cmp+0x3e6>
   104c4:	48 8b 34 11          	mov    (%rcx,%rdx,1),%rsi
   104c8:	eb 2a                	jmp    104f4 <fwp_cmp+0x3f4>
   104ca:	41 83 3f 01          	cmpl   $0x1,(%r15)
   104ce:	0f b7 04 11          	movzwl (%rcx,%rdx,1),%eax
   104d2:	48 0f bf f0          	movswq %ax,%rsi
   104d6:	eb 18                	jmp    104f0 <fwp_cmp+0x3f0>
   104d8:	41 83 3f 00          	cmpl   $0x0,(%r15)
   104dc:	0f b6 04 11          	movzbl (%rcx,%rdx,1),%eax
   104e0:	48 0f be f0          	movsbq %al,%rsi
   104e4:	eb 0a                	jmp    104f0 <fwp_cmp+0x3f0>
   104e6:	41 83 3f 02          	cmpl   $0x2,(%r15)
   104ea:	8b 04 11             	mov    (%rcx,%rdx,1),%eax
   104ed:	48 63 f0             	movslq %eax,%rsi
   104f0:	48 0f 45 f0          	cmovne %rax,%rsi
   104f4:	4c 89 fa             	mov    %r15,%rdx
   104f7:	e8 04 fc ff ff       	call   10100 <fwp_cmp>
   104fc:	85 c0                	test   %eax,%eax
   104fe:	0f 85 4e fc ff ff    	jne    10152 <fwp_cmp+0x52>
   10504:	48 ff c5             	inc    %rbp
   10507:	49 39 ec             	cmp    %rbp,%r12
   1050a:	0f 85 d0 fe ff ff    	jne    103e0 <fwp_cmp+0x2e0>
   10510:	31 c9                	xor    %ecx,%ecx
   10512:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
   10517:	48 3b 44 24 20       	cmp    0x20(%rsp),%rax
   1051c:	e9 26 fc ff ff       	jmp    10147 <fwp_cmp+0x47>
   10521:	49 81 fe ff 0f 00 00 	cmp    $0xfff,%r14
   10528:	77 27                	ja     10551 <fwp_cmp+0x451>
   1052a:	44 89 f0             	mov    %r14d,%eax
   1052d:	48 81 fb ff 0f 00 00 	cmp    $0xfff,%rbx
   10534:	76 27                	jbe    1055d <fwp_cmp+0x45d>
   10536:	8b 0b                	mov    (%rbx),%ecx
   10538:	39 c8                	cmp    %ecx,%eax
   1053a:	74 27                	je     10563 <fwp_cmp+0x463>
   1053c:	0f 97 c0             	seta   %al
   1053f:	0f b6 c8             	movzbl %al,%ecx
   10542:	e9 03 fc ff ff       	jmp    1014a <fwp_cmp+0x4a>
   10547:	31 c9                	xor    %ecx,%ecx
   10549:	4d 39 e7             	cmp    %r12,%r15
   1054c:	e9 f6 fb ff ff       	jmp    10147 <fwp_cmp+0x47>
   10551:	41 8b 06             	mov    (%r14),%eax
   10554:	48 81 fb ff 0f 00 00 	cmp    $0xfff,%rbx
   1055b:	77 d9                	ja     10536 <fwp_cmp+0x436>
   1055d:	89 d9                	mov    %ebx,%ecx
   1055f:	39 c8                	cmp    %ecx,%eax
   10561:	75 d9                	jne    1053c <fwp_cmp+0x43c>
   10563:	49 8b 4f 28          	mov    0x28(%r15),%rcx
   10567:	89 c0                	mov    %eax,%eax
   10569:	44 8b 24 81          	mov    (%rcx,%rax,4),%r12d
   1056d:	45 85 e4             	test   %r12d,%r12d
   10570:	7e 38                	jle    105aa <fwp_cmp+0x4aa>
   10572:	49 8b 4f 30          	mov    0x30(%r15),%rcx
   10576:	4c 8b 3c c1          	mov    (%rcx,%rax,8),%r15
   1057a:	45 31 ed             	xor    %r13d,%r13d
   1057d:	0f 1f 00             	nopl   (%rax)
   10580:	4b 8b 7c ee 08       	mov    0x8(%r14,%r13,8),%rdi
   10585:	4a 8b 74 eb 08       	mov    0x8(%rbx,%r13,8),%rsi
   1058a:	4b 8b 14 ef          	mov    (%r15,%r13,8),%rdx
   1058e:	e8 6d fb ff ff       	call   10100 <fwp_cmp>
   10593:	85 c0                	test   %eax,%eax
   10595:	0f 85 b7 fb ff ff    	jne    10152 <fwp_cmp+0x52>
   1059b:	49 ff c5             	inc    %r13
   1059e:	31 c0                	xor    %eax,%eax
   105a0:	4d 39 ec             	cmp    %r13,%r12
   105a3:	75 db                	jne    10580 <fwp_cmp+0x480>
   105a5:	e9 a8 fb ff ff       	jmp    10152 <fwp_cmp+0x52>
   105aa:	31 c0                	xor    %eax,%eax
   105ac:	e9 a1 fb ff ff       	jmp    10152 <fwp_cmp+0x52>
   105b1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   105b8:	0f 1f 84 00 00 00 00 
   105bf:	00 

00000000000105c0 <fwp_pipe_poll>:
   105c0:	83 3d f9 a6 00 00 00 	cmpl   $0x0,0xa6f9(%rip)        # 1acc0 <fwp_po_listen>
   105c7:	0f 88 b1 01 00 00    	js     1077e <fwp_pipe_poll+0x1be>
   105cd:	55                   	push   %rbp
   105ce:	41 57                	push   %r15
   105d0:	41 56                	push   %r14
   105d2:	53                   	push   %rbx
   105d3:	48 83 ec 38          	sub    $0x38,%rsp
   105d7:	48 8d 74 24 28       	lea    0x28(%rsp),%rsi
   105dc:	bf 01 00 00 00       	mov    $0x1,%edi
   105e1:	e8 4a 2b ff ff       	call   3130 <clock_gettime@plt>
   105e6:	4c 69 74 24 28 00 ca 	imul   $0x3b9aca00,0x28(%rsp),%r14
   105ed:	9a 3b 
   105ef:	4c 03 74 24 30       	add    0x30(%rsp),%r14
   105f4:	4c 3b 35 c5 a7 02 00 	cmp    0x2a7c5(%rip),%r14        # 3adc0 <fwp_po_next_check>
   105fb:	0f 8c 73 01 00 00    	jl     10774 <fwp_pipe_poll+0x1b4>
   10601:	49 8d 86 40 42 0f 00 	lea    0xf4240(%r14),%rax
   10608:	48 89 05 b1 a7 02 00 	mov    %rax,0x2a7b1(%rip)        # 3adc0 <fwp_po_next_check>
   1060f:	8b 3d ab a6 00 00    	mov    0xa6ab(%rip),%edi        # 1acc0 <fwp_po_listen>
   10615:	31 f6                	xor    %esi,%esi
   10617:	31 d2                	xor    %edx,%edx
   10619:	e8 12 2e ff ff       	call   3430 <accept@plt>
   1061e:	85 c0                	test   %eax,%eax
   10620:	0f 88 10 01 00 00    	js     10736 <fwp_pipe_poll+0x176>
   10626:	89 c3                	mov    %eax,%ebx
   10628:	8b 3d 92 a6 00 00    	mov    0xa692(%rip),%edi        # 1acc0 <fwp_po_listen>
   1062e:	e8 fd 2b ff ff       	call   3230 <close@plt>
   10633:	c7 05 83 a6 00 00 ff 	movl   $0xffffffff,0xa683(%rip)        # 1acc0 <fwp_po_listen>
   1063a:	ff ff ff 
   1063d:	89 df                	mov    %ebx,%edi
   1063f:	be 02 00 00 00       	mov    $0x2,%esi
   10644:	ba 01 00 00 00       	mov    $0x1,%edx
   10649:	31 c0                	xor    %eax,%eax
   1064b:	e8 d0 2a ff ff       	call   3120 <fcntl@plt>
   10650:	89 df                	mov    %ebx,%edi
   10652:	be 03 00 00 00       	mov    $0x3,%esi
   10657:	31 c0                	xor    %eax,%eax
   10659:	e8 c2 2a ff ff       	call   3120 <fcntl@plt>
   1065e:	25 ff f7 ff ff       	and    $0xfffff7ff,%eax
   10663:	89 df                	mov    %ebx,%edi
   10665:	be 04 00 00 00       	mov    $0x4,%esi
   1066a:	89 c2                	mov    %eax,%edx
   1066c:	31 c0                	xor    %eax,%eax
   1066e:	e8 ad 2a ff ff       	call   3120 <fcntl@plt>
   10673:	c7 44 24 24 0c 00 00 	movl   $0xc,0x24(%rsp)
   1067a:	00 
   1067b:	89 5c 24 1c          	mov    %ebx,0x1c(%rsp)
   1067f:	c7 44 24 20 01 00 00 	movl   $0x1,0x20(%rsp)
   10686:	00 
   10687:	48 8d 4c 24 28       	lea    0x28(%rsp),%rcx
   1068c:	4c 8d 44 24 24       	lea    0x24(%rsp),%r8
   10691:	89 df                	mov    %ebx,%edi
   10693:	be 01 00 00 00       	mov    $0x1,%esi
   10698:	ba 11 00 00 00       	mov    $0x11,%edx
   1069d:	e8 fe 2b ff ff       	call   32a0 <getsockopt@plt>
   106a2:	85 c0                	test   %eax,%eax
   106a4:	0f 85 c3 00 00 00    	jne    1076d <fwp_pipe_poll+0x1ad>
   106aa:	8b 6c 24 2c          	mov    0x2c(%rsp),%ebp
   106ae:	e8 cd 2a ff ff       	call   3180 <getuid@plt>
   106b3:	39 c5                	cmp    %eax,%ebp
   106b5:	0f 85 b2 00 00 00    	jne    1076d <fwp_pipe_poll+0x1ad>
   106bb:	48 8d 7c 24 1c       	lea    0x1c(%rsp),%rdi
   106c0:	be 01 00 00 00       	mov    $0x1,%esi
   106c5:	ba e8 03 00 00       	mov    $0x3e8,%edx
   106ca:	e8 f1 2c ff ff       	call   33c0 <poll@plt>
   106cf:	85 c0                	test   %eax,%eax
   106d1:	0f 8e 96 00 00 00    	jle    1076d <fwp_pipe_poll+0x1ad>
   106d7:	48 8d 74 24 0f       	lea    0xf(%rsp),%rsi
   106dc:	ba 05 00 00 00       	mov    $0x5,%edx
   106e1:	89 df                	mov    %ebx,%edi
   106e3:	31 c9                	xor    %ecx,%ecx
   106e5:	e8 76 29 ff ff       	call   3060 <recv@plt>
   106ea:	48 85 c0             	test   %rax,%rax
   106ed:	7e 7e                	jle    1076d <fwp_pipe_poll+0x1ad>
   106ef:	49 89 c6             	mov    %rax,%r14
   106f2:	4c 8d 7c 24 1c       	lea    0x1c(%rsp),%r15
   106f7:	49 83 fe 04          	cmp    $0x4,%r14
   106fb:	77 59                	ja     10756 <fwp_pipe_poll+0x196>
   106fd:	be 01 00 00 00       	mov    $0x1,%esi
   10702:	4c 89 ff             	mov    %r15,%rdi
   10705:	ba e8 03 00 00       	mov    $0x3e8,%edx
   1070a:	e8 b1 2c ff ff       	call   33c0 <poll@plt>
   1070f:	85 c0                	test   %eax,%eax
   10711:	7e 5a                	jle    1076d <fwp_pipe_poll+0x1ad>
   10713:	4a 8d 34 34          	lea    (%rsp,%r14,1),%rsi
   10717:	48 83 c6 0f          	add    $0xf,%rsi
   1071b:	ba 05 00 00 00       	mov    $0x5,%edx
   10720:	4c 29 f2             	sub    %r14,%rdx
   10723:	89 df                	mov    %ebx,%edi
   10725:	31 c9                	xor    %ecx,%ecx
   10727:	e8 34 29 ff ff       	call   3060 <recv@plt>
   1072c:	49 01 c6             	add    %rax,%r14
   1072f:	48 85 c0             	test   %rax,%rax
   10732:	7f c3                	jg     106f7 <fwp_pipe_poll+0x137>
   10734:	eb 37                	jmp    1076d <fwp_pipe_poll+0x1ad>
   10736:	4c 3b 35 5b a6 01 00 	cmp    0x1a65b(%rip),%r14        # 2ad98 <fwp_po_give_up>
   1073d:	7e 35                	jle    10774 <fwp_pipe_poll+0x1b4>
   1073f:	8b 3d 7b a5 00 00    	mov    0xa57b(%rip),%edi        # 1acc0 <fwp_po_listen>
   10745:	e8 e6 2a ff ff       	call   3230 <close@plt>
   1074a:	c7 05 6c a5 00 00 ff 	movl   $0xffffffff,0xa56c(%rip)        # 1acc0 <fwp_po_listen>
   10751:	ff ff ff 
   10754:	eb 1e                	jmp    10774 <fwp_pipe_poll+0x1b4>
   10756:	81 7c 24 0f 46 57 50 	cmpl   $0x54505746,0xf(%rsp)
   1075d:	54 
   1075e:	75 0d                	jne    1076d <fwp_pipe_poll+0x1ad>
   10760:	0f b6 44 24 13       	movzbl 0x13(%rsp),%eax
   10765:	8d 48 fd             	lea    -0x3(%rax),%ecx
   10768:	80 f9 fd             	cmp    $0xfd,%cl
   1076b:	77 12                	ja     1077f <fwp_pipe_poll+0x1bf>
   1076d:	89 df                	mov    %ebx,%edi
   1076f:	e8 bc 2a ff ff       	call   3230 <close@plt>
   10774:	48 83 c4 38          	add    $0x38,%rsp
   10778:	5b                   	pop    %rbx
   10779:	41 5e                	pop    %r14
   1077b:	41 5f                	pop    %r15
   1077d:	5d                   	pop    %rbp
   1077e:	c3                   	ret
   1077f:	89 1d 3f a5 00 00    	mov    %ebx,0xa53f(%rip)        # 1acc4 <fwp_po_sock>
   10785:	bb 01 00 00 00       	mov    $0x1,%ebx
   1078a:	3c 02                	cmp    $0x2,%al
   1078c:	75 10                	jne    1079e <fwp_pipe_poll+0x1de>
   1078e:	e8 4d 00 00 00       	call   107e0 <fwp_po_make_ring>
   10793:	83 f8 01             	cmp    $0x1,%eax
   10796:	bb 02 00 00 00       	mov    $0x2,%ebx
   1079b:	83 db 00             	sbb    $0x0,%ebx
   1079e:	c7 44 24 14 02 01 00 	movl   $0x102,0x14(%rsp)
   107a5:	00 
   107a6:	c6 44 24 18 00       	movb   $0x0,0x18(%rsp)
   107ab:	88 5c 24 19          	mov    %bl,0x19(%rsp)
   107af:	4c 8b 35 fa 87 00 00 	mov    0x87fa(%rip),%r14        # 18fb0 <stdout@GLIBC_2.2.5>
   107b6:	49 8b 0e             	mov    (%r14),%rcx
   107b9:	48 8d 7c 24 14       	lea    0x14(%rsp),%rdi
   107be:	be 01 00 00 00       	mov    $0x1,%esi
   107c3:	ba 06 00 00 00       	mov    $0x6,%edx
   107c8:	e8 b3 2c ff ff       	call   3480 <fwrite@plt>
   107cd:	49 8b 3e             	mov    (%r14),%rdi
   107d0:	e8 7b 2b ff ff       	call   3350 <fflush@plt>
   107d5:	89 1d c5 a5 01 00    	mov    %ebx,0x1a5c5(%rip)        # 2ada0 <fwp_po_kind>
   107db:	eb 97                	jmp    10774 <fwp_pipe_poll+0x1b4>
   107dd:	0f 1f 00             	nopl   (%rax)

00000000000107e0 <fwp_po_make_ring>:
   107e0:	55                   	push   %rbp
   107e1:	41 57                	push   %r15
   107e3:	41 56                	push   %r14
   107e5:	53                   	push   %rbx
   107e6:	48 83 ec 68          	sub    $0x68,%rsp
   107ea:	48 8d 35 e7 4e 00 00 	lea    0x4ee7(%rip),%rsi        # 156d8 <exec_in_fp0+0xec8>
   107f1:	31 ed                	xor    %ebp,%ebp
   107f3:	bf 3f 01 00 00       	mov    $0x13f,%edi
   107f8:	ba 01 00 00 00       	mov    $0x1,%edx
   107fd:	31 c0                	xor    %eax,%eax
   107ff:	e8 fc 2a ff ff       	call   3300 <syscall@plt>
   10804:	48 89 c3             	mov    %rax,%rbx
   10807:	85 db                	test   %ebx,%ebx
   10809:	78 17                	js     10822 <fwp_po_make_ring+0x42>
   1080b:	be 00 10 10 00       	mov    $0x101000,%esi
   10810:	89 df                	mov    %ebx,%edi
   10812:	e8 c9 29 ff ff       	call   31e0 <ftruncate@plt>
   10817:	85 c0                	test   %eax,%eax
   10819:	74 14                	je     1082f <fwp_po_make_ring+0x4f>
   1081b:	89 df                	mov    %ebx,%edi
   1081d:	e8 0e 2a ff ff       	call   3230 <close@plt>
   10822:	89 e8                	mov    %ebp,%eax
   10824:	48 83 c4 68          	add    $0x68,%rsp
   10828:	5b                   	pop    %rbx
   10829:	41 5e                	pop    %r14
   1082b:	41 5f                	pop    %r15
   1082d:	5d                   	pop    %rbp
   1082e:	c3                   	ret
   1082f:	be 00 10 10 00       	mov    $0x101000,%esi
   10834:	31 ff                	xor    %edi,%edi
   10836:	ba 03 00 00 00       	mov    $0x3,%edx
   1083b:	b9 01 00 00 00       	mov    $0x1,%ecx
   10840:	41 89 d8             	mov    %ebx,%r8d
   10843:	45 31 c9             	xor    %r9d,%r9d
   10846:	e8 45 29 ff ff       	call   3190 <mmap@plt>
   1084b:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
   1084f:	74 ca                	je     1081b <fwp_po_make_ring+0x3b>
   10851:	49 89 c6             	mov    %rax,%r14
   10854:	48 b8 46 57 50 53 01 	movabs $0x153505746,%rax
   1085b:	00 00 00 
   1085e:	49 89 06             	mov    %rax,(%r14)
   10861:	49 c7 46 08 00 00 10 	movq   $0x100000,0x8(%r14)
   10868:	00 
   10869:	c6 44 24 07 53       	movb   $0x53,0x7(%rsp)
   1086e:	48 8d 44 24 07       	lea    0x7(%rsp),%rax
   10873:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   10878:	48 c7 44 24 28 01 00 	movq   $0x1,0x28(%rsp)
   1087f:	00 00 
   10881:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
   10888:	00 00 
   1088a:	0f 57 c0             	xorps  %xmm0,%xmm0
   1088d:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
   10892:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
   10897:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
   1089c:	48 c7 44 24 60 00 00 	movq   $0x0,0x60(%rsp)
   108a3:	00 00 
   108a5:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
   108aa:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
   108af:	48 c7 44 24 48 01 00 	movq   $0x1,0x48(%rsp)
   108b6:	00 00 
   108b8:	48 8d 44 24 08       	lea    0x8(%rsp),%rax
   108bd:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
   108c2:	48 c7 44 24 58 18 00 	movq   $0x18,0x58(%rsp)
   108c9:	00 00 
   108cb:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
   108d2:	00 00 00 
   108d5:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
   108da:	48 c7 44 24 08 14 00 	movq   $0x14,0x8(%rsp)
   108e1:	00 00 
   108e3:	89 5c 24 18          	mov    %ebx,0x18(%rsp)
   108e7:	8b 3d d7 a3 00 00    	mov    0xa3d7(%rip),%edi        # 1acc4 <fwp_po_sock>
   108ed:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
   108f2:	ba 00 40 00 00       	mov    $0x4000,%edx
   108f7:	e8 c4 27 ff ff       	call   30c0 <sendmsg@plt>
   108fc:	49 89 c7             	mov    %rax,%r15
   108ff:	89 df                	mov    %ebx,%edi
   10901:	e8 2a 29 ff ff       	call   3230 <close@plt>
   10906:	49 83 ff 01          	cmp    $0x1,%r15
   1090a:	75 11                	jne    1091d <fwp_po_make_ring+0x13d>
   1090c:	4c 89 35 9d a4 02 00 	mov    %r14,0x2a49d(%rip)        # 3adb0 <fwp_po_ring>
   10913:	bd 01 00 00 00       	mov    $0x1,%ebp
   10918:	e9 05 ff ff ff       	jmp    10822 <fwp_po_make_ring+0x42>
   1091d:	be 00 10 10 00       	mov    $0x101000,%esi
   10922:	4c 89 f7             	mov    %r14,%rdi
   10925:	e8 66 2a ff ff       	call   3390 <munmap@plt>
   1092a:	31 ed                	xor    %ebp,%ebp
   1092c:	e9 f1 fe ff ff       	jmp    10822 <fwp_po_make_ring+0x42>
   10931:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   10938:	0f 1f 84 00 00 00 00 
   1093f:	00 

0000000000010940 <fwp_write>:
   10940:	55                   	push   %rbp
   10941:	41 57                	push   %r15
   10943:	41 56                	push   %r14
   10945:	41 55                	push   %r13
   10947:	41 54                	push   %r12
   10949:	53                   	push   %rbx
   1094a:	48 81 ec 78 02 00 00 	sub    $0x278,%rsp
   10951:	8b 02                	mov    (%rdx),%eax
   10953:	48 83 f8 19          	cmp    $0x19,%rax
   10957:	0f 87 36 12 00 00    	ja     11b93 <fwp_write+0x1253>
   1095d:	49 89 d7             	mov    %rdx,%r15
   10960:	49 89 f6             	mov    %rsi,%r14
   10963:	48 89 fd             	mov    %rdi,%rbp
   10966:	48 8d 15 8b 3b 00 00 	lea    0x3b8b(%rip),%rdx        # 144f8 <_IO_stdin_used+0x4f8>
   1096d:	48 63 34 82          	movslq (%rdx,%rax,4),%rsi
   10971:	48 01 d6             	add    %rdx,%rsi
   10974:	48 89 3c 24          	mov    %rdi,(%rsp)
   10978:	ff e6                	jmp    *%rsi
   1097a:	48 8d 15 85 4d 00 00 	lea    0x4d85(%rip),%rdx        # 15706 <exec_in_fp0+0xef6>
   10981:	eb 07                	jmp    1098a <fwp_write+0x4a>
   10983:	48 8d 15 44 4d 00 00 	lea    0x4d44(%rip),%rdx        # 156ce <exec_in_fp0+0xebe>
   1098a:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
   1098f:	be 00 02 00 00       	mov    $0x200,%esi
   10994:	4c 89 ff             	mov    %r15,%rdi
   10997:	4c 89 f1             	mov    %r14,%rcx
   1099a:	31 c0                	xor    %eax,%eax
   1099c:	e8 2f 28 ff ff       	call   31d0 <snprintf@plt>
   109a1:	4c 89 ff             	mov    %r15,%rdi
   109a4:	e8 c7 27 ff ff       	call   3170 <strlen@plt>
   109a9:	48 89 ef             	mov    %rbp,%rdi
   109ac:	4c 89 fe             	mov    %r15,%rsi
   109af:	e9 d7 11 00 00       	jmp    11b8b <fwp_write+0x124b>
   109b4:	83 f8 13             	cmp    $0x13,%eax
   109b7:	48 8d 05 79 4d 00 00 	lea    0x4d79(%rip),%rax        # 15737 <exec_in_fp0+0xf27>
   109be:	48 8d 35 77 4d 00 00 	lea    0x4d77(%rip),%rsi        # 1573c <exec_in_fp0+0xf2c>
   109c5:	48 0f 44 f0          	cmove  %rax,%rsi
   109c9:	ba 04 00 00 00       	mov    $0x4,%edx
   109ce:	48 89 ef             	mov    %rbp,%rdi
   109d1:	e8 3a c3 ff ff       	call   cd10 <buf_put>
   109d6:	49 83 3e 00          	cmpq   $0x0,(%r14)
   109da:	0f 84 c3 00 00 00    	je     10aa3 <fwp_write+0x163>
   109e0:	49 8b 57 38          	mov    0x38(%r15),%rdx
   109e4:	49 8b 76 08          	mov    0x8(%r14),%rsi
   109e8:	48 8b 1c 24          	mov    (%rsp),%rbx
   109ec:	48 89 df             	mov    %rbx,%rdi
   109ef:	31 c9                	xor    %ecx,%ecx
   109f1:	e8 4a ff ff ff       	call   10940 <fwp_write>
   109f6:	41 83 3f 12          	cmpl   $0x12,(%r15)
   109fa:	75 26                	jne    10a22 <fwp_write+0xe2>
   109fc:	48 8d 35 f8 4c 00 00 	lea    0x4cf8(%rip),%rsi        # 156fb <exec_in_fp0+0xeeb>
   10a03:	ba 02 00 00 00       	mov    $0x2,%edx
   10a08:	48 89 df             	mov    %rbx,%rdi
   10a0b:	e8 00 c3 ff ff       	call   cd10 <buf_put>
   10a10:	49 8b 76 10          	mov    0x10(%r14),%rsi
   10a14:	49 8b 57 40          	mov    0x40(%r15),%rdx
   10a18:	48 89 df             	mov    %rbx,%rdi
   10a1b:	31 c9                	xor    %ecx,%ecx
   10a1d:	e8 1e ff ff ff       	call   10940 <fwp_write>
   10a22:	49 83 3e 02          	cmpq   $0x2,(%r14)
   10a26:	72 7b                	jb     10aa3 <fwp_write+0x163>
   10a28:	49 8d 5e 20          	lea    0x20(%r14),%rbx
   10a2c:	bd 01 00 00 00       	mov    $0x1,%ebp
   10a31:	4c 8d 25 20 4c 00 00 	lea    0x4c20(%rip),%r12        # 15658 <exec_in_fp0+0xe48>
   10a38:	eb 12                	jmp    10a4c <fwp_write+0x10c>
   10a3a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   10a40:	48 ff c5             	inc    %rbp
   10a43:	48 83 c3 10          	add    $0x10,%rbx
   10a47:	49 3b 2e             	cmp    (%r14),%rbp
   10a4a:	73 57                	jae    10aa3 <fwp_write+0x163>
   10a4c:	ba 02 00 00 00       	mov    $0x2,%edx
   10a51:	4c 8b 2c 24          	mov    (%rsp),%r13
   10a55:	4c 89 ef             	mov    %r13,%rdi
   10a58:	4c 89 e6             	mov    %r12,%rsi
   10a5b:	e8 b0 c2 ff ff       	call   cd10 <buf_put>
   10a60:	48 8b 73 f8          	mov    -0x8(%rbx),%rsi
   10a64:	49 8b 57 38          	mov    0x38(%r15),%rdx
   10a68:	4c 89 ef             	mov    %r13,%rdi
   10a6b:	31 c9                	xor    %ecx,%ecx
   10a6d:	e8 ce fe ff ff       	call   10940 <fwp_write>
   10a72:	41 83 3f 12          	cmpl   $0x12,(%r15)
   10a76:	75 c8                	jne    10a40 <fwp_write+0x100>
   10a78:	ba 02 00 00 00       	mov    $0x2,%edx
   10a7d:	4c 8b 2c 24          	mov    (%rsp),%r13
   10a81:	4c 89 ef             	mov    %r13,%rdi
   10a84:	48 8d 35 70 4c 00 00 	lea    0x4c70(%rip),%rsi        # 156fb <exec_in_fp0+0xeeb>
   10a8b:	e8 80 c2 ff ff       	call   cd10 <buf_put>
   10a90:	48 8b 33             	mov    (%rbx),%rsi
   10a93:	49 8b 57 40          	mov    0x40(%r15),%rdx
   10a97:	4c 89 ef             	mov    %r13,%rdi
   10a9a:	31 c9                	xor    %ecx,%ecx
   10a9c:	e8 9f fe ff ff       	call   10940 <fwp_write>
   10aa1:	eb 9d                	jmp    10a40 <fwp_write+0x100>
   10aa3:	c6 44 24 70 7d       	movb   $0x7d,0x70(%rsp)
   10aa8:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   10aad:	ba 01 00 00 00       	mov    $0x1,%edx
   10ab2:	48 8b 3c 24          	mov    (%rsp),%rdi
   10ab6:	e9 d3 10 00 00       	jmp    11b8e <fwp_write+0x124e>
   10abb:	4d 8b 67 08          	mov    0x8(%r15),%r12
   10abf:	4d 85 e4             	test   %r12,%r12
   10ac2:	0f 84 bf 06 00 00    	je     11187 <fwp_write+0x847>
   10ac8:	48 8d 35 a2 4b 00 00 	lea    0x4ba2(%rip),%rsi        # 15671 <exec_in_fp0+0xe61>
   10acf:	4c 89 e7             	mov    %r12,%rdi
   10ad2:	e8 f9 27 ff ff       	call   32d0 <strcmp@plt>
   10ad7:	85 c0                	test   %eax,%eax
   10ad9:	0f 84 46 0b 00 00    	je     11625 <fwp_write+0xce5>
   10adf:	4d 8d 6f 10          	lea    0x10(%r15),%r13
   10ae3:	4c 89 e7             	mov    %r12,%rdi
   10ae6:	e8 85 26 ff ff       	call   3170 <strlen@plt>
   10aeb:	48 89 ef             	mov    %rbp,%rdi
   10aee:	4c 89 e6             	mov    %r12,%rsi
   10af1:	48 89 c2             	mov    %rax,%rdx
   10af4:	e8 17 c2 ff ff       	call   cd10 <buf_put>
   10af9:	c6 44 24 70 20       	movb   $0x20,0x70(%rsp)
   10afe:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   10b03:	ba 01 00 00 00       	mov    $0x1,%edx
   10b08:	48 89 ef             	mov    %rbp,%rdi
   10b0b:	e8 00 c2 ff ff       	call   cd10 <buf_put>
   10b10:	31 db                	xor    %ebx,%ebx
   10b12:	e9 8f 06 00 00       	jmp    111a6 <fwp_write+0x866>
   10b17:	49 81 fe ff 0f 00 00 	cmp    $0xfff,%r14
   10b1e:	0f 87 10 05 00 00    	ja     11034 <fwp_write+0x6f4>
   10b24:	44 89 f0             	mov    %r14d,%eax
   10b27:	e9 0b 05 00 00       	jmp    11037 <fwp_write+0x6f7>
   10b2c:	66 49 0f 6e ce       	movq   %r14,%xmm1
   10b31:	66 0f 2e c9          	ucomisd %xmm1,%xmm1
   10b35:	0f 8a e2 11 00 00    	jp     11d1d <fwp_write+0x13dd>
   10b3b:	66 0f 28 05 bd 35 00 	movapd 0x35bd(%rip),%xmm0        # 14100 <_IO_stdin_used+0x100>
   10b42:	00 
   10b43:	66 0f 54 c1          	andpd  %xmm1,%xmm0
   10b47:	66 0f 2e 05 71 36 00 	ucomisd 0x3671(%rip),%xmm0        # 141c0 <_IO_stdin_used+0x1c0>
   10b4e:	00 
   10b4f:	0f 82 76 08 00 00    	jb     113cb <fwp_write+0xa8b>
   10b55:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
   10b59:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
   10b5d:	e9 65 04 00 00       	jmp    10fc7 <fwp_write+0x687>
   10b62:	c6 44 24 70 3c       	movb   $0x3c,0x70(%rsp)
   10b67:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   10b6c:	ba 01 00 00 00       	mov    $0x1,%edx
   10b71:	48 89 ef             	mov    %rbp,%rdi
   10b74:	e8 97 c1 ff ff       	call   cd10 <buf_put>
   10b79:	4d 8b 77 08          	mov    0x8(%r15),%r14
   10b7d:	e9 92 04 00 00       	jmp    11014 <fwp_write+0x6d4>
   10b82:	48 8d 35 8d 4b 00 00 	lea    0x4b8d(%rip),%rsi        # 15716 <exec_in_fp0+0xf06>
   10b89:	ba 08 00 00 00       	mov    $0x8,%edx
   10b8e:	48 89 ef             	mov    %rbp,%rdi
   10b91:	e9 6c 0d 00 00       	jmp    11902 <fwp_write+0xfc2>
   10b96:	49 8d 76 08          	lea    0x8(%r14),%rsi
   10b9a:	49 8b 16             	mov    (%r14),%rdx
   10b9d:	85 c9                	test   %ecx,%ecx
   10b9f:	0f 84 23 07 00 00    	je     112c8 <fwp_write+0x988>
   10ba5:	48 89 ef             	mov    %rbp,%rdi
   10ba8:	e9 55 0d 00 00       	jmp    11902 <fwp_write+0xfc2>
   10bad:	4d 8b 0e             	mov    (%r14),%r9
   10bb0:	4d 8b 46 08          	mov    0x8(%r14),%r8
   10bb4:	4c 89 c8             	mov    %r9,%rax
   10bb7:	4c 09 c0             	or     %r8,%rax
   10bba:	0f 84 21 07 00 00    	je     112e1 <fwp_write+0x9a1>
   10bc0:	31 ff                	xor    %edi,%edi
   10bc2:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
   10bc9:	cc cc cc 
   10bcc:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
   10bd3:	cc cc cc 
   10bd6:	4c 89 c3             	mov    %r8,%rbx
   10bd9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   10be0:	4c 89 c1             	mov    %r8,%rcx
   10be3:	4c 0f a4 c9 3f       	shld   $0x3f,%r9,%rcx
   10be8:	48 d1 eb             	shr    $1,%rbx
   10beb:	48 89 ce             	mov    %rcx,%rsi
   10bee:	48 01 de             	add    %rbx,%rsi
   10bf1:	48 83 d6 00          	adc    $0x0,%rsi
   10bf5:	48 89 f0             	mov    %rsi,%rax
   10bf8:	49 f7 e2             	mul    %r10
   10bfb:	48 c1 ea 02          	shr    $0x2,%rdx
   10bff:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   10c03:	48 29 c6             	sub    %rax,%rsi
   10c06:	48 29 f1             	sub    %rsi,%rcx
   10c09:	48 83 db 00          	sbb    $0x0,%rbx
   10c0d:	48 89 ce             	mov    %rcx,%rsi
   10c10:	49 0f af f3          	imul   %r11,%rsi
   10c14:	48 89 c8             	mov    %rcx,%rax
   10c17:	49 f7 e2             	mul    %r10
   10c1a:	48 01 f2             	add    %rsi,%rdx
   10c1d:	49 0f af da          	imul   %r10,%rbx
   10c21:	48 01 d3             	add    %rdx,%rbx
   10c24:	48 89 c1             	mov    %rax,%rcx
   10c27:	48 01 c1             	add    %rax,%rcx
   10c2a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
   10c2e:	44 89 ca             	mov    %r9d,%edx
   10c31:	29 ca                	sub    %ecx,%edx
   10c33:	80 ca 30             	or     $0x30,%dl
   10c36:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
   10c3a:	48 ff c7             	inc    %rdi
   10c3d:	49 83 f9 0a          	cmp    $0xa,%r9
   10c41:	49 83 d8 00          	sbb    $0x0,%r8
   10c45:	49 89 c1             	mov    %rax,%r9
   10c48:	49 89 d8             	mov    %rbx,%r8
   10c4b:	73 93                	jae    10be0 <fwp_write+0x2a0>
   10c4d:	85 ff                	test   %edi,%edi
   10c4f:	0f 8f 96 06 00 00    	jg     112eb <fwp_write+0x9ab>
   10c55:	e9 ab 00 00 00       	jmp    10d05 <fwp_write+0x3c5>
   10c5a:	4d 8b 06             	mov    (%r14),%r8
   10c5d:	4d 8b 4e 08          	mov    0x8(%r14),%r9
   10c61:	4d 85 c9             	test   %r9,%r9
   10c64:	0f 88 a3 06 00 00    	js     1130d <fwp_write+0x9cd>
   10c6a:	4c 89 c0             	mov    %r8,%rax
   10c6d:	4c 09 c8             	or     %r9,%rax
   10c70:	0f 84 cc 09 00 00    	je     11642 <fwp_write+0xd02>
   10c76:	31 ff                	xor    %edi,%edi
   10c78:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
   10c7f:	cc cc cc 
   10c82:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
   10c89:	cc cc cc 
   10c8c:	4c 89 cb             	mov    %r9,%rbx
   10c8f:	90                   	nop
   10c90:	4c 89 c9             	mov    %r9,%rcx
   10c93:	4c 0f a4 c1 3f       	shld   $0x3f,%r8,%rcx
   10c98:	48 d1 eb             	shr    $1,%rbx
   10c9b:	48 89 ce             	mov    %rcx,%rsi
   10c9e:	48 01 de             	add    %rbx,%rsi
   10ca1:	48 83 d6 00          	adc    $0x0,%rsi
   10ca5:	48 89 f0             	mov    %rsi,%rax
   10ca8:	49 f7 e2             	mul    %r10
   10cab:	48 c1 ea 02          	shr    $0x2,%rdx
   10caf:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   10cb3:	48 29 c6             	sub    %rax,%rsi
   10cb6:	48 29 f1             	sub    %rsi,%rcx
   10cb9:	48 83 db 00          	sbb    $0x0,%rbx
   10cbd:	48 89 ce             	mov    %rcx,%rsi
   10cc0:	49 0f af f3          	imul   %r11,%rsi
   10cc4:	48 89 c8             	mov    %rcx,%rax
   10cc7:	49 f7 e2             	mul    %r10
   10cca:	48 01 f2             	add    %rsi,%rdx
   10ccd:	49 0f af da          	imul   %r10,%rbx
   10cd1:	48 01 d3             	add    %rdx,%rbx
   10cd4:	48 89 c1             	mov    %rax,%rcx
   10cd7:	48 01 c1             	add    %rax,%rcx
   10cda:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
   10cde:	44 89 c2             	mov    %r8d,%edx
   10ce1:	29 ca                	sub    %ecx,%edx
   10ce3:	80 ca 30             	or     $0x30,%dl
   10ce6:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
   10cea:	48 ff c7             	inc    %rdi
   10ced:	49 83 f8 0a          	cmp    $0xa,%r8
   10cf1:	49 83 d9 00          	sbb    $0x0,%r9
   10cf5:	49 89 c0             	mov    %rax,%r8
   10cf8:	49 89 d9             	mov    %rbx,%r9
   10cfb:	73 93                	jae    10c90 <fwp_write+0x350>
   10cfd:	85 ff                	test   %edi,%edi
   10cff:	0f 8f 47 09 00 00    	jg     1164c <fwp_write+0xd0c>
   10d05:	31 c0                	xor    %eax,%eax
   10d07:	e9 67 0e 00 00       	jmp    11b73 <fwp_write+0x1233>
   10d0c:	c6 44 24 70 5b       	movb   $0x5b,0x70(%rsp)
   10d11:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   10d16:	ba 01 00 00 00       	mov    $0x1,%edx
   10d1b:	48 89 ef             	mov    %rbp,%rdi
   10d1e:	e8 ed bf ff ff       	call   cd10 <buf_put>
   10d23:	4d 85 f6             	test   %r14,%r14
   10d26:	0f 84 f6 0c 00 00    	je     11a22 <fwp_write+0x10e2>
   10d2c:	49 8b 57 38          	mov    0x38(%r15),%rdx
   10d30:	49 8b 76 08          	mov    0x8(%r14),%rsi
   10d34:	48 89 ef             	mov    %rbp,%rdi
   10d37:	31 c9                	xor    %ecx,%ecx
   10d39:	e8 02 fc ff ff       	call   10940 <fwp_write>
   10d3e:	49 8b 5e 10          	mov    0x10(%r14),%rbx
   10d42:	48 85 db             	test   %rbx,%rbx
   10d45:	0f 84 d7 0c 00 00    	je     11a22 <fwp_write+0x10e2>
   10d4b:	4c 8d 35 06 49 00 00 	lea    0x4906(%rip),%r14        # 15658 <exec_in_fp0+0xe48>
   10d52:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   10d59:	1f 84 00 00 00 00 00 
   10d60:	ba 02 00 00 00       	mov    $0x2,%edx
   10d65:	48 89 ef             	mov    %rbp,%rdi
   10d68:	4c 89 f6             	mov    %r14,%rsi
   10d6b:	e8 a0 bf ff ff       	call   cd10 <buf_put>
   10d70:	48 8b 73 08          	mov    0x8(%rbx),%rsi
   10d74:	49 8b 57 38          	mov    0x38(%r15),%rdx
   10d78:	48 89 ef             	mov    %rbp,%rdi
   10d7b:	31 c9                	xor    %ecx,%ecx
   10d7d:	e8 be fb ff ff       	call   10940 <fwp_write>
   10d82:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
   10d86:	48 85 db             	test   %rbx,%rbx
   10d89:	75 d5                	jne    10d60 <fwp_write+0x420>
   10d8b:	e9 92 0c 00 00       	jmp    11a22 <fwp_write+0x10e2>
   10d90:	4d 63 67 48          	movslq 0x48(%r15),%r12
   10d94:	44 89 e3             	mov    %r12d,%ebx
   10d97:	49 8d 54 24 03       	lea    0x3(%r12),%rdx
   10d9c:	48 ff 05 85 9f 00 00 	incq   0x9f85(%rip)        # 1ad28 <measured_calls>
   10da3:	48 01 15 86 9f 00 00 	add    %rdx,0x9f86(%rip)        # 1ad30 <measured_bytes>
   10daa:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
   10db1:	0f 87 59 08 00 00    	ja     11610 <fwp_write+0xcd0>
   10db7:	49 8d 4c 24 12       	lea    0x12(%r12),%rcx
   10dbc:	48 c1 e9 04          	shr    $0x4,%rcx
   10dc0:	48 8d 05 c1 84 00 00 	lea    0x84c1(%rip),%rax        # 19288 <fwp_gc>
   10dc7:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
   10dce:	00 
   10dcf:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
   10dd6:	48 29 0d ab 84 00 00 	sub    %rcx,0x84ab(%rip)        # 19288 <fwp_gc>
   10ddd:	0f 88 2d 08 00 00    	js     11610 <fwp_write+0xcd0>
   10de3:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
   10de7:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
   10deb:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
   10df2:	4c 8b 3f             	mov    (%rdi),%r15
   10df5:	4d 85 ff             	test   %r15,%r15
   10df8:	0f 84 f6 07 00 00    	je     115f4 <fwp_write+0xcb4>
   10dfe:	49 8b 07             	mov    (%r15),%rax
   10e01:	48 f7 d0             	not    %rax
   10e04:	48 89 07             	mov    %rax,(%rdi)
   10e07:	e9 2f 0a 00 00       	jmp    1183b <fwp_write+0xefb>
   10e0c:	49 83 fe ff          	cmp    $0xffffffffffffffff,%r14
   10e10:	48 8d 05 4d 48 00 00 	lea    0x484d(%rip),%rax        # 15664 <exec_in_fp0+0xe54>
   10e17:	48 8d 0d 3f 49 00 00 	lea    0x493f(%rip),%rcx        # 1575d <exec_in_fp0+0xf4d>
   10e1e:	48 0f 44 c8          	cmove  %rax,%rcx
   10e22:	49 83 fe 01          	cmp    $0x1,%r14
   10e26:	4c 8d 35 34 48 00 00 	lea    0x4834(%rip),%r14        # 15661 <exec_in_fp0+0xe51>
   10e2d:	4c 0f 45 f1          	cmovne %rcx,%r14
   10e31:	4c 89 f7             	mov    %r14,%rdi
   10e34:	e8 37 23 ff ff       	call   3170 <strlen@plt>
   10e39:	48 89 ef             	mov    %rbp,%rdi
   10e3c:	4c 89 f6             	mov    %r14,%rsi
   10e3f:	e9 bb 0a 00 00       	jmp    118ff <fwp_write+0xfbf>
   10e44:	48 8d 35 e5 48 00 00 	lea    0x48e5(%rip),%rsi        # 15730 <exec_in_fp0+0xf20>
   10e4b:	ba 06 00 00 00       	mov    $0x6,%edx
   10e50:	48 89 ef             	mov    %rbp,%rdi
   10e53:	e8 b8 be ff ff       	call   cd10 <buf_put>
   10e58:	49 8b 36             	mov    (%r14),%rsi
   10e5b:	48 8d 04 75 00 00 00 	lea    0x0(,%rsi,2),%rax
   10e62:	00 
   10e63:	48 85 c0             	test   %rax,%rax
   10e66:	0f 84 b6 0b 00 00    	je     11a22 <fwp_write+0x10e2>
   10e6c:	49 8b 57 38          	mov    0x38(%r15),%rdx
   10e70:	b8 08 00 00 00       	mov    $0x8,%eax
   10e75:	48 85 d2             	test   %rdx,%rdx
   10e78:	74 13                	je     10e8d <fwp_write+0x54d>
   10e7a:	8b 0a                	mov    (%rdx),%ecx
   10e7c:	48 83 f9 0a          	cmp    $0xa,%rcx
   10e80:	77 0b                	ja     10e8d <fwp_write+0x54d>
   10e82:	48 8d 05 07 3a 00 00 	lea    0x3a07(%rip),%rax        # 14890 <exec_in_fp0+0x80>
   10e89:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
   10e8d:	4d 8d 6e 08          	lea    0x8(%r14),%r13
   10e91:	4c 89 e9             	mov    %r13,%rcx
   10e94:	48 85 f6             	test   %rsi,%rsi
   10e97:	79 04                	jns    10e9d <fwp_write+0x55d>
   10e99:	49 8b 4e 10          	mov    0x10(%r14),%rcx
   10e9d:	48 83 f8 01          	cmp    $0x1,%rax
   10ea1:	0f 84 76 0a 00 00    	je     1191d <fwp_write+0xfdd>
   10ea7:	48 83 f8 08          	cmp    $0x8,%rax
   10eab:	0f 84 67 0a 00 00    	je     11918 <fwp_write+0xfd8>
   10eb1:	48 83 f8 02          	cmp    $0x2,%rax
   10eb5:	0f 85 6e 0a 00 00    	jne    11929 <fwp_write+0xfe9>
   10ebb:	83 3a 01             	cmpl   $0x1,(%rdx)
   10ebe:	0f b7 01             	movzwl (%rcx),%eax
   10ec1:	48 0f bf f0          	movswq %ax,%rsi
   10ec5:	e9 67 0a 00 00       	jmp    11931 <fwp_write+0xff1>
   10eca:	48 8d 35 55 48 00 00 	lea    0x4855(%rip),%rsi        # 15726 <exec_in_fp0+0xf16>
   10ed1:	ba 06 00 00 00       	mov    $0x6,%edx
   10ed6:	48 89 ef             	mov    %rbp,%rdi
   10ed9:	e8 32 be ff ff       	call   cd10 <buf_put>
   10ede:	49 83 3e 00          	cmpq   $0x0,(%r14)
   10ee2:	0f 84 a5 00 00 00    	je     10f8d <fwp_write+0x64d>
   10ee8:	41 0f b6 4e 08       	movzbl 0x8(%r14),%ecx
   10eed:	48 8d 15 39 48 00 00 	lea    0x4839(%rip),%rdx        # 1572d <exec_in_fp0+0xf1d>
   10ef4:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
   10ef9:	be 00 02 00 00       	mov    $0x200,%esi
   10efe:	4c 89 ff             	mov    %r15,%rdi
   10f01:	31 c0                	xor    %eax,%eax
   10f03:	e8 c8 22 ff ff       	call   31d0 <snprintf@plt>
   10f08:	4c 89 ff             	mov    %r15,%rdi
   10f0b:	e8 60 22 ff ff       	call   3170 <strlen@plt>
   10f10:	48 89 ef             	mov    %rbp,%rdi
   10f13:	4c 89 fe             	mov    %r15,%rsi
   10f16:	48 89 c2             	mov    %rax,%rdx
   10f19:	e8 f2 bd ff ff       	call   cd10 <buf_put>
   10f1e:	49 83 3e 02          	cmpq   $0x2,(%r14)
   10f22:	72 69                	jb     10f8d <fwp_write+0x64d>
   10f24:	bb 09 00 00 00       	mov    $0x9,%ebx
   10f29:	4c 8d 3d 28 47 00 00 	lea    0x4728(%rip),%r15        # 15658 <exec_in_fp0+0xe48>
   10f30:	4c 8d 25 f6 47 00 00 	lea    0x47f6(%rip),%r12        # 1572d <exec_in_fp0+0xf1d>
   10f37:	4c 8d 6c 24 70       	lea    0x70(%rsp),%r13
   10f3c:	0f 1f 40 00          	nopl   0x0(%rax)
   10f40:	ba 02 00 00 00       	mov    $0x2,%edx
   10f45:	48 89 ef             	mov    %rbp,%rdi
   10f48:	4c 89 fe             	mov    %r15,%rsi
   10f4b:	e8 c0 bd ff ff       	call   cd10 <buf_put>
   10f50:	41 0f b6 0c 1e       	movzbl (%r14,%rbx,1),%ecx
   10f55:	be 00 02 00 00       	mov    $0x200,%esi
   10f5a:	4c 89 ef             	mov    %r13,%rdi
   10f5d:	4c 89 e2             	mov    %r12,%rdx
   10f60:	31 c0                	xor    %eax,%eax
   10f62:	e8 69 22 ff ff       	call   31d0 <snprintf@plt>
   10f67:	4c 89 ef             	mov    %r13,%rdi
   10f6a:	e8 01 22 ff ff       	call   3170 <strlen@plt>
   10f6f:	48 89 ef             	mov    %rbp,%rdi
   10f72:	4c 89 ee             	mov    %r13,%rsi
   10f75:	48 89 c2             	mov    %rax,%rdx
   10f78:	e8 93 bd ff ff       	call   cd10 <buf_put>
   10f7d:	48 8d 43 01          	lea    0x1(%rbx),%rax
   10f81:	48 83 c3 f9          	add    $0xfffffffffffffff9,%rbx
   10f85:	49 3b 1e             	cmp    (%r14),%rbx
   10f88:	48 89 c3             	mov    %rax,%rbx
   10f8b:	72 b3                	jb     10f40 <fwp_write+0x600>
   10f8d:	c6 44 24 20 5d       	movb   $0x5d,0x20(%rsp)
   10f92:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
   10f97:	e9 90 0a 00 00       	jmp    11a2c <fwp_write+0x10ec>
   10f9c:	66 41 0f 6e ce       	movd   %r14d,%xmm1
   10fa1:	0f 2e c9             	ucomiss %xmm1,%xmm1
   10fa4:	0f 8a 73 0d 00 00    	jp     11d1d <fwp_write+0x13dd>
   10faa:	0f 28 05 5f 31 00 00 	movaps 0x315f(%rip),%xmm0        # 14110 <_IO_stdin_used+0x110>
   10fb1:	0f 54 c1             	andps  %xmm1,%xmm0
   10fb4:	0f 2e 05 49 30 00 00 	ucomiss 0x3049(%rip),%xmm0        # 14004 <_IO_stdin_used+0x4>
   10fbb:	0f 82 6e 04 00 00    	jb     1142f <fwp_write+0xaef>
   10fc1:	0f 57 c0             	xorps  %xmm0,%xmm0
   10fc4:	0f 2e c8             	ucomiss %xmm0,%xmm1
   10fc7:	48 8d 05 be 46 00 00 	lea    0x46be(%rip),%rax        # 1568c <exec_in_fp0+0xe7c>
   10fce:	48 8d 35 b6 46 00 00 	lea    0x46b6(%rip),%rsi        # 1568b <exec_in_fp0+0xe7b>
   10fd5:	48 0f 47 f0          	cmova  %rax,%rsi
   10fd9:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   10fde:	e8 cd 20 ff ff       	call   30b0 <strcpy@plt>
   10fe3:	e9 90 0b 00 00       	jmp    11b78 <fwp_write+0x1238>
   10fe8:	48 8d 35 1c 47 00 00 	lea    0x471c(%rip),%rsi        # 1570b <exec_in_fp0+0xefb>
   10fef:	ba 0a 00 00 00       	mov    $0xa,%edx
   10ff4:	48 89 ef             	mov    %rbp,%rdi
   10ff7:	e9 06 09 00 00       	jmp    11902 <fwp_write+0xfc2>
   10ffc:	48 8d 35 1c 47 00 00 	lea    0x471c(%rip),%rsi        # 1571f <exec_in_fp0+0xf0f>
   11003:	ba 06 00 00 00       	mov    $0x6,%edx
   11008:	48 89 ef             	mov    %rbp,%rdi
   1100b:	e8 00 bd ff ff       	call   cd10 <buf_put>
   11010:	49 83 c6 10          	add    $0x10,%r14
   11014:	4c 89 f7             	mov    %r14,%rdi
   11017:	e8 54 21 ff ff       	call   3170 <strlen@plt>
   1101c:	48 89 ef             	mov    %rbp,%rdi
   1101f:	4c 89 f6             	mov    %r14,%rsi
   11022:	48 89 c2             	mov    %rax,%rdx
   11025:	e8 e6 bc ff ff       	call   cd10 <buf_put>
   1102a:	c6 44 24 70 3e       	movb   $0x3e,0x70(%rsp)
   1102f:	e9 f3 09 00 00       	jmp    11a27 <fwp_write+0x10e7>
   11034:	41 8b 06             	mov    (%r14),%eax
   11037:	49 8b 4f 18          	mov    0x18(%r15),%rcx
   1103b:	41 89 c5             	mov    %eax,%r13d
   1103e:	4e 8b 24 e9          	mov    (%rcx,%r13,8),%r12
   11042:	4c 89 e7             	mov    %r12,%rdi
   11045:	e8 26 21 ff ff       	call   3170 <strlen@plt>
   1104a:	48 89 ef             	mov    %rbp,%rdi
   1104d:	4c 89 e6             	mov    %r12,%rsi
   11050:	48 89 c2             	mov    %rax,%rdx
   11053:	e8 b8 bc ff ff       	call   cd10 <buf_put>
   11058:	49 8b 47 28          	mov    0x28(%r15),%rax
   1105c:	42 83 3c a8 00       	cmpl   $0x0,(%rax,%r13,4)
   11061:	0f 8e 2c 0b 00 00    	jle    11b93 <fwp_write+0x1253>
   11067:	45 31 e4             	xor    %r12d,%r12d
   1106a:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
   1106f:	4c 89 6c 24 68       	mov    %r13,0x68(%rsp)
   11074:	eb 3c                	jmp    110b2 <fwp_write+0x772>
   11076:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   1107d:	00 00 00 
   11080:	48 8b 2c 24          	mov    (%rsp),%rbp
   11084:	48 89 ef             	mov    %rbp,%rdi
   11087:	48 89 de             	mov    %rbx,%rsi
   1108a:	4c 89 ea             	mov    %r13,%rdx
   1108d:	31 c9                	xor    %ecx,%ecx
   1108f:	e8 ac f8 ff ff       	call   10940 <fwp_write>
   11094:	49 ff c4             	inc    %r12
   11097:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
   1109c:	49 8b 47 28          	mov    0x28(%r15),%rax
   110a0:	4c 8b 6c 24 68       	mov    0x68(%rsp),%r13
   110a5:	4a 63 04 a8          	movslq (%rax,%r13,4),%rax
   110a9:	49 39 c4             	cmp    %rax,%r12
   110ac:	0f 8d e1 0a 00 00    	jge    11b93 <fwp_write+0x1253>
   110b2:	4b 8b 5c e6 08       	mov    0x8(%r14,%r12,8),%rbx
   110b7:	49 8b 47 30          	mov    0x30(%r15),%rax
   110bb:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
   110bf:	4e 8b 2c e0          	mov    (%rax,%r12,8),%r13
   110c3:	c6 44 24 70 20       	movb   $0x20,0x70(%rsp)
   110c8:	ba 01 00 00 00       	mov    $0x1,%edx
   110cd:	48 89 ef             	mov    %rbp,%rdi
   110d0:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   110d5:	e8 36 bc ff ff       	call   cd10 <buf_put>
   110da:	41 8b 45 00          	mov    0x0(%r13),%eax
   110de:	48 83 f8 10          	cmp    $0x10,%rax
   110e2:	77 9c                	ja     11080 <fwp_write+0x740>
   110e4:	48 8d 0d 75 34 00 00 	lea    0x3475(%rip),%rcx        # 14560 <_IO_stdin_used+0x560>
   110eb:	48 63 04 81          	movslq (%rcx,%rax,4),%rax
   110ef:	48 01 c8             	add    %rcx,%rax
   110f2:	ff e0                	jmp    *%rax
   110f4:	48 89 d9             	mov    %rbx,%rcx
   110f7:	48 c1 e9 3f          	shr    $0x3f,%rcx
   110fb:	85 c9                	test   %ecx,%ecx
   110fd:	74 81                	je     11080 <fwp_write+0x740>
   110ff:	c6 44 24 70 28       	movb   $0x28,0x70(%rsp)
   11104:	ba 01 00 00 00       	mov    $0x1,%edx
   11109:	48 8b 2c 24          	mov    (%rsp),%rbp
   1110d:	48 89 ef             	mov    %rbp,%rdi
   11110:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
   11115:	4c 89 fe             	mov    %r15,%rsi
   11118:	e8 f3 bb ff ff       	call   cd10 <buf_put>
   1111d:	48 89 ef             	mov    %rbp,%rdi
   11120:	48 89 de             	mov    %rbx,%rsi
   11123:	4c 89 ea             	mov    %r13,%rdx
   11126:	31 c9                	xor    %ecx,%ecx
   11128:	e8 13 f8 ff ff       	call   10940 <fwp_write>
   1112d:	c6 44 24 70 29       	movb   $0x29,0x70(%rsp)
   11132:	ba 01 00 00 00       	mov    $0x1,%edx
   11137:	48 89 ef             	mov    %rbp,%rdi
   1113a:	4c 89 fe             	mov    %r15,%rsi
   1113d:	e8 ce bb ff ff       	call   cd10 <buf_put>
   11142:	e9 4d ff ff ff       	jmp    11094 <fwp_write+0x754>
   11147:	31 c9                	xor    %ecx,%ecx
   11149:	48 81 fb 00 10 00 00 	cmp    $0x1000,%rbx
   11150:	0f 93 c1             	setae  %cl
   11153:	eb a6                	jmp    110fb <fwp_write+0x7bb>
   11155:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
   11159:	eb 9c                	jmp    110f7 <fwp_write+0x7b7>
   1115b:	89 d9                	mov    %ebx,%ecx
   1115d:	c1 e9 1f             	shr    $0x1f,%ecx
   11160:	eb 99                	jmp    110fb <fwp_write+0x7bb>
   11162:	49 8b 7d 08          	mov    0x8(%r13),%rdi
   11166:	48 85 ff             	test   %rdi,%rdi
   11169:	0f 84 11 ff ff ff    	je     11080 <fwp_write+0x740>
   1116f:	48 8d 35 fb 44 00 00 	lea    0x44fb(%rip),%rsi        # 15671 <exec_in_fp0+0xe61>
   11176:	e8 55 21 ff ff       	call   32d0 <strcmp@plt>
   1117b:	31 c9                	xor    %ecx,%ecx
   1117d:	85 c0                	test   %eax,%eax
   1117f:	0f 95 c1             	setne  %cl
   11182:	e9 74 ff ff ff       	jmp    110fb <fwp_write+0x7bb>
   11187:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
   1118c:	0f 84 a7 08 00 00    	je     11a39 <fwp_write+0x10f9>
   11192:	4d 8d 6f 10          	lea    0x10(%r15),%r13
   11196:	4d 85 e4             	test   %r12,%r12
   11199:	0f 94 c0             	sete   %al
   1119c:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
   111a1:	0f 95 c3             	setne  %bl
   111a4:	20 c3                	and    %al,%bl
   111a6:	84 db                	test   %bl,%bl
   111a8:	b8 28 00 00 00       	mov    $0x28,%eax
   111ad:	b9 7b 00 00 00       	mov    $0x7b,%ecx
   111b2:	0f 45 c8             	cmovne %eax,%ecx
   111b5:	88 4c 24 70          	mov    %cl,0x70(%rsp)
   111b9:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   111be:	ba 01 00 00 00       	mov    $0x1,%edx
   111c3:	48 89 ef             	mov    %rbp,%rdi
   111c6:	e8 45 bb ff ff       	call   cd10 <buf_put>
   111cb:	41 83 7d 00 00       	cmpl   $0x0,0x0(%r13)
   111d0:	0f 8e da 00 00 00    	jle    112b0 <fwp_write+0x970>
   111d6:	84 db                	test   %bl,%bl
   111d8:	75 31                	jne    1120b <fwp_write+0x8cb>
   111da:	49 8b 47 18          	mov    0x18(%r15),%rax
   111de:	4c 8b 20             	mov    (%rax),%r12
   111e1:	4c 89 e7             	mov    %r12,%rdi
   111e4:	e8 87 1f ff ff       	call   3170 <strlen@plt>
   111e9:	48 89 ef             	mov    %rbp,%rdi
   111ec:	4c 89 e6             	mov    %r12,%rsi
   111ef:	48 89 c2             	mov    %rax,%rdx
   111f2:	e8 19 bb ff ff       	call   cd10 <buf_put>
   111f7:	48 8d 35 46 45 00 00 	lea    0x4546(%rip),%rsi        # 15744 <exec_in_fp0+0xf34>
   111fe:	ba 03 00 00 00       	mov    $0x3,%edx
   11203:	48 89 ef             	mov    %rbp,%rdi
   11206:	e8 05 bb ff ff       	call   cd10 <buf_put>
   1120b:	49 8b 76 08          	mov    0x8(%r14),%rsi
   1120f:	49 8b 47 20          	mov    0x20(%r15),%rax
   11213:	48 8b 10             	mov    (%rax),%rdx
   11216:	48 89 ef             	mov    %rbp,%rdi
   11219:	31 c9                	xor    %ecx,%ecx
   1121b:	e8 20 f7 ff ff       	call   10940 <fwp_write>
   11220:	41 83 7f 10 02       	cmpl   $0x2,0x10(%r15)
   11225:	0f 8c 85 00 00 00    	jl     112b0 <fwp_write+0x970>
   1122b:	41 bd 01 00 00 00    	mov    $0x1,%r13d
   11231:	4c 8d 25 20 44 00 00 	lea    0x4420(%rip),%r12        # 15658 <exec_in_fp0+0xe48>
   11238:	eb 29                	jmp    11263 <fwp_write+0x923>
   1123a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   11240:	4b 8b 74 ee 08       	mov    0x8(%r14,%r13,8),%rsi
   11245:	49 8b 47 20          	mov    0x20(%r15),%rax
   11249:	4a 8b 14 e8          	mov    (%rax,%r13,8),%rdx
   1124d:	48 89 ef             	mov    %rbp,%rdi
   11250:	31 c9                	xor    %ecx,%ecx
   11252:	e8 e9 f6 ff ff       	call   10940 <fwp_write>
   11257:	49 ff c5             	inc    %r13
   1125a:	49 63 47 10          	movslq 0x10(%r15),%rax
   1125e:	49 39 c5             	cmp    %rax,%r13
   11261:	7d 4d                	jge    112b0 <fwp_write+0x970>
   11263:	ba 02 00 00 00       	mov    $0x2,%edx
   11268:	48 89 ef             	mov    %rbp,%rdi
   1126b:	4c 89 e6             	mov    %r12,%rsi
   1126e:	e8 9d ba ff ff       	call   cd10 <buf_put>
   11273:	84 db                	test   %bl,%bl
   11275:	75 c9                	jne    11240 <fwp_write+0x900>
   11277:	49 8b 47 18          	mov    0x18(%r15),%rax
   1127b:	4a 8b 2c e8          	mov    (%rax,%r13,8),%rbp
   1127f:	48 89 ef             	mov    %rbp,%rdi
   11282:	e8 e9 1e ff ff       	call   3170 <strlen@plt>
   11287:	48 8b 3c 24          	mov    (%rsp),%rdi
   1128b:	48 89 ee             	mov    %rbp,%rsi
   1128e:	48 8b 2c 24          	mov    (%rsp),%rbp
   11292:	48 89 c2             	mov    %rax,%rdx
   11295:	e8 76 ba ff ff       	call   cd10 <buf_put>
   1129a:	ba 03 00 00 00       	mov    $0x3,%edx
   1129f:	48 89 ef             	mov    %rbp,%rdi
   112a2:	48 8d 35 9b 44 00 00 	lea    0x449b(%rip),%rsi        # 15744 <exec_in_fp0+0xf34>
   112a9:	e8 62 ba ff ff       	call   cd10 <buf_put>
   112ae:	eb 90                	jmp    11240 <fwp_write+0x900>
   112b0:	84 db                	test   %bl,%bl
   112b2:	b8 29 00 00 00       	mov    $0x29,%eax
   112b7:	b9 7d 00 00 00       	mov    $0x7d,%ecx
   112bc:	0f 45 c8             	cmovne %eax,%ecx
   112bf:	88 4c 24 70          	mov    %cl,0x70(%rsp)
   112c3:	e9 5f 07 00 00       	jmp    11a27 <fwp_write+0x10e7>
   112c8:	48 89 ef             	mov    %rbp,%rdi
   112cb:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
   112d2:	5b                   	pop    %rbx
   112d3:	41 5c                	pop    %r12
   112d5:	41 5d                	pop    %r13
   112d7:	41 5e                	pop    %r14
   112d9:	41 5f                	pop    %r15
   112db:	5d                   	pop    %rbp
   112dc:	e9 4f 0a 00 00       	jmp    11d30 <fwp_escape>
   112e1:	c6 44 24 20 30       	movb   $0x30,0x20(%rsp)
   112e6:	bf 01 00 00 00       	mov    $0x1,%edi
   112eb:	89 f8                	mov    %edi,%eax
   112ed:	48 83 f8 08          	cmp    $0x8,%rax
   112f1:	73 0a                	jae    112fd <fwp_write+0x9bd>
   112f3:	31 c9                	xor    %ecx,%ecx
   112f5:	48 89 c2             	mov    %rax,%rdx
   112f8:	e9 7a 04 00 00       	jmp    11777 <fwp_write+0xe37>
   112fd:	83 f8 20             	cmp    $0x20,%eax
   11300:	0f 83 68 03 00 00    	jae    1166e <fwp_write+0xd2e>
   11306:	31 c9                	xor    %ecx,%ecx
   11308:	e9 10 04 00 00       	jmp    1171d <fwp_write+0xddd>
   1130d:	31 ff                	xor    %edi,%edi
   1130f:	49 f7 d8             	neg    %r8
   11312:	41 ba 00 00 00 00    	mov    $0x0,%r10d
   11318:	4d 19 ca             	sbb    %r9,%r10
   1131b:	c6 44 24 70 2d       	movb   $0x2d,0x70(%rsp)
   11320:	49 b9 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r9
   11327:	cc cc cc 
   1132a:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
   11331:	cc cc cc 
   11334:	4c 89 d3             	mov    %r10,%rbx
   11337:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   1133e:	00 00 
   11340:	4c 89 d1             	mov    %r10,%rcx
   11343:	4c 0f a4 c1 3f       	shld   $0x3f,%r8,%rcx
   11348:	48 d1 eb             	shr    $1,%rbx
   1134b:	48 89 ce             	mov    %rcx,%rsi
   1134e:	48 01 de             	add    %rbx,%rsi
   11351:	48 83 d6 00          	adc    $0x0,%rsi
   11355:	48 89 f0             	mov    %rsi,%rax
   11358:	49 f7 e1             	mul    %r9
   1135b:	48 c1 ea 02          	shr    $0x2,%rdx
   1135f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   11363:	48 29 c6             	sub    %rax,%rsi
   11366:	48 29 f1             	sub    %rsi,%rcx
   11369:	48 83 db 00          	sbb    $0x0,%rbx
   1136d:	48 89 ce             	mov    %rcx,%rsi
   11370:	49 0f af f3          	imul   %r11,%rsi
   11374:	48 89 c8             	mov    %rcx,%rax
   11377:	49 f7 e1             	mul    %r9
   1137a:	48 01 f2             	add    %rsi,%rdx
   1137d:	49 0f af d9          	imul   %r9,%rbx
   11381:	48 01 d3             	add    %rdx,%rbx
   11384:	48 89 c1             	mov    %rax,%rcx
   11387:	48 01 c1             	add    %rax,%rcx
   1138a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
   1138e:	44 89 c2             	mov    %r8d,%edx
   11391:	29 ca                	sub    %ecx,%edx
   11393:	80 ca 30             	or     $0x30,%dl
   11396:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
   1139a:	48 ff c7             	inc    %rdi
   1139d:	49 83 f8 0a          	cmp    $0xa,%r8
   113a1:	49 83 da 00          	sbb    $0x0,%r10
   113a5:	49 89 c0             	mov    %rax,%r8
   113a8:	49 89 da             	mov    %rbx,%r10
   113ab:	73 93                	jae    11340 <fwp_write+0xa00>
   113ad:	85 ff                	test   %edi,%edi
   113af:	0f 8e 98 06 00 00    	jle    11a4d <fwp_write+0x110d>
   113b5:	89 f8                	mov    %edi,%eax
   113b7:	48 83 f8 08          	cmp    $0x8,%rax
   113bb:	0f 83 e4 07 00 00    	jae    11ba5 <fwp_write+0x1265>
   113c1:	31 c9                	xor    %ecx,%ecx
   113c3:	48 89 c2             	mov    %rax,%rdx
   113c6:	e9 fc 08 00 00       	jmp    11cc7 <fwp_write+0x1387>
   113cb:	bd 01 00 00 00       	mov    $0x1,%ebp
   113d0:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   113d5:	0f 29 4c 24 10       	movaps %xmm1,0x10(%rsp)
   113da:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   113e0:	4c 89 f7             	mov    %r14,%rdi
   113e3:	66 0f 28 c1          	movapd %xmm1,%xmm0
   113e7:	89 ee                	mov    %ebp,%esi
   113e9:	e8 b2 15 00 00       	call   129a0 <fwp_format_g>
   113ee:	4c 89 f7             	mov    %r14,%rdi
   113f1:	31 f6                	xor    %esi,%esi
   113f3:	e8 08 1d ff ff       	call   3100 <strtod@plt>
   113f8:	66 0f 28 4c 24 10    	movapd 0x10(%rsp),%xmm1
   113fe:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
   11402:	75 06                	jne    1140a <fwp_write+0xaca>
   11404:	0f 8b 9e 03 00 00    	jnp    117a8 <fwp_write+0xe68>
   1140a:	ff c5                	inc    %ebp
   1140c:	83 fd 12             	cmp    $0x12,%ebp
   1140f:	75 cf                	jne    113e0 <fwp_write+0xaa0>
   11411:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11416:	4c 89 f7             	mov    %r14,%rdi
   11419:	66 0f 28 c1          	movapd %xmm1,%xmm0
   1141d:	be 11 00 00 00       	mov    $0x11,%esi
   11422:	e8 79 15 00 00       	call   129a0 <fwp_format_g>
   11427:	4c 89 f7             	mov    %r14,%rdi
   1142a:	e9 7e 03 00 00       	jmp    117ad <fwp_write+0xe6d>
   1142f:	0f 57 c0             	xorps  %xmm0,%xmm0
   11432:	f3 0f 5a c1          	cvtss2sd %xmm1,%xmm0
   11436:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   1143b:	4c 89 f7             	mov    %r14,%rdi
   1143e:	f2 0f 11 44 24 10    	movsd  %xmm0,0x10(%rsp)
   11444:	be 01 00 00 00       	mov    $0x1,%esi
   11449:	0f 29 0c 24          	movaps %xmm1,(%rsp)
   1144d:	e8 4e 15 00 00       	call   129a0 <fwp_format_g>
   11452:	4c 89 f7             	mov    %r14,%rdi
   11455:	31 f6                	xor    %esi,%esi
   11457:	e8 a4 1d ff ff       	call   3200 <strtof@plt>
   1145c:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   11460:	75 06                	jne    11468 <fwp_write+0xb28>
   11462:	0f 8b 6f 01 00 00    	jnp    115d7 <fwp_write+0xc97>
   11468:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   1146d:	4c 89 f7             	mov    %r14,%rdi
   11470:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   11476:	be 02 00 00 00       	mov    $0x2,%esi
   1147b:	e8 20 15 00 00       	call   129a0 <fwp_format_g>
   11480:	4c 89 f7             	mov    %r14,%rdi
   11483:	31 f6                	xor    %esi,%esi
   11485:	e8 76 1d ff ff       	call   3200 <strtof@plt>
   1148a:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   1148e:	75 06                	jne    11496 <fwp_write+0xb56>
   11490:	0f 8b 41 01 00 00    	jnp    115d7 <fwp_write+0xc97>
   11496:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   1149b:	4c 89 f7             	mov    %r14,%rdi
   1149e:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   114a4:	be 03 00 00 00       	mov    $0x3,%esi
   114a9:	e8 f2 14 00 00       	call   129a0 <fwp_format_g>
   114ae:	4c 89 f7             	mov    %r14,%rdi
   114b1:	31 f6                	xor    %esi,%esi
   114b3:	e8 48 1d ff ff       	call   3200 <strtof@plt>
   114b8:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   114bc:	75 06                	jne    114c4 <fwp_write+0xb84>
   114be:	0f 8b 13 01 00 00    	jnp    115d7 <fwp_write+0xc97>
   114c4:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   114c9:	4c 89 f7             	mov    %r14,%rdi
   114cc:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   114d2:	be 04 00 00 00       	mov    $0x4,%esi
   114d7:	e8 c4 14 00 00       	call   129a0 <fwp_format_g>
   114dc:	4c 89 f7             	mov    %r14,%rdi
   114df:	31 f6                	xor    %esi,%esi
   114e1:	e8 1a 1d ff ff       	call   3200 <strtof@plt>
   114e6:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   114ea:	75 06                	jne    114f2 <fwp_write+0xbb2>
   114ec:	0f 8b e5 00 00 00    	jnp    115d7 <fwp_write+0xc97>
   114f2:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   114f7:	4c 89 f7             	mov    %r14,%rdi
   114fa:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   11500:	be 05 00 00 00       	mov    $0x5,%esi
   11505:	e8 96 14 00 00       	call   129a0 <fwp_format_g>
   1150a:	4c 89 f7             	mov    %r14,%rdi
   1150d:	31 f6                	xor    %esi,%esi
   1150f:	e8 ec 1c ff ff       	call   3200 <strtof@plt>
   11514:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   11518:	75 06                	jne    11520 <fwp_write+0xbe0>
   1151a:	0f 8b b7 00 00 00    	jnp    115d7 <fwp_write+0xc97>
   11520:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11525:	4c 89 f7             	mov    %r14,%rdi
   11528:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   1152e:	be 06 00 00 00       	mov    $0x6,%esi
   11533:	e8 68 14 00 00       	call   129a0 <fwp_format_g>
   11538:	4c 89 f7             	mov    %r14,%rdi
   1153b:	31 f6                	xor    %esi,%esi
   1153d:	e8 be 1c ff ff       	call   3200 <strtof@plt>
   11542:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   11546:	75 06                	jne    1154e <fwp_write+0xc0e>
   11548:	0f 8b 89 00 00 00    	jnp    115d7 <fwp_write+0xc97>
   1154e:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11553:	4c 89 f7             	mov    %r14,%rdi
   11556:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   1155c:	be 07 00 00 00       	mov    $0x7,%esi
   11561:	e8 3a 14 00 00       	call   129a0 <fwp_format_g>
   11566:	4c 89 f7             	mov    %r14,%rdi
   11569:	31 f6                	xor    %esi,%esi
   1156b:	e8 90 1c ff ff       	call   3200 <strtof@plt>
   11570:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   11574:	75 02                	jne    11578 <fwp_write+0xc38>
   11576:	7b 5f                	jnp    115d7 <fwp_write+0xc97>
   11578:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   1157d:	4c 89 f7             	mov    %r14,%rdi
   11580:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   11586:	be 08 00 00 00       	mov    $0x8,%esi
   1158b:	e8 10 14 00 00       	call   129a0 <fwp_format_g>
   11590:	4c 89 f7             	mov    %r14,%rdi
   11593:	31 f6                	xor    %esi,%esi
   11595:	e8 66 1c ff ff       	call   3200 <strtof@plt>
   1159a:	0f 28 0c 24          	movaps (%rsp),%xmm1
   1159e:	0f 2e c1             	ucomiss %xmm1,%xmm0
   115a1:	75 02                	jne    115a5 <fwp_write+0xc65>
   115a3:	7b 32                	jnp    115d7 <fwp_write+0xc97>
   115a5:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   115aa:	4c 89 f7             	mov    %r14,%rdi
   115ad:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   115b3:	be 09 00 00 00       	mov    $0x9,%esi
   115b8:	e8 e3 13 00 00       	call   129a0 <fwp_format_g>
   115bd:	4c 89 f7             	mov    %r14,%rdi
   115c0:	31 f6                	xor    %esi,%esi
   115c2:	e8 39 1c ff ff       	call   3200 <strtof@plt>
   115c7:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
   115cb:	0f 85 2c 07 00 00    	jne    11cfd <fwp_write+0x13bd>
   115d1:	0f 8a 26 07 00 00    	jp     11cfd <fwp_write+0x13bd>
   115d7:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   115dc:	be 2e 00 00 00       	mov    $0x2e,%esi
   115e1:	e8 ca 1b ff ff       	call   31b0 <strchr@plt>
   115e6:	48 85 c0             	test   %rax,%rax
   115e9:	0f 85 89 05 00 00    	jne    11b78 <fwp_write+0x1238>
   115ef:	e9 d0 01 00 00       	jmp    117c4 <fwp_write+0xe84>
   115f4:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
   115fb:	00 
   115fc:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
   11603:	00 
   11604:	4c 29 ff             	sub    %r15,%rdi
   11607:	48 39 cf             	cmp    %rcx,%rdi
   1160a:	0f 83 1b 02 00 00    	jae    1182b <fwp_write+0xeeb>
   11610:	48 89 d7             	mov    %rdx,%rdi
   11613:	be 01 00 00 00       	mov    $0x1,%esi
   11618:	e8 03 67 ff ff       	call   7d20 <fwp_gc_alloc_slow>
   1161d:	49 89 c7             	mov    %rax,%r15
   11620:	e9 20 02 00 00       	jmp    11845 <fwp_write+0xf05>
   11625:	49 8b 76 08          	mov    0x8(%r14),%rsi
   11629:	48 89 f2             	mov    %rsi,%rdx
   1162c:	48 c1 fa 3f          	sar    $0x3f,%rdx
   11630:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11635:	4c 89 f7             	mov    %r14,%rdi
   11638:	e8 33 08 00 00       	call   11e70 <fwp_fmt_duration>
   1163d:	e9 3b 05 00 00       	jmp    11b7d <fwp_write+0x123d>
   11642:	c6 44 24 20 30       	movb   $0x30,0x20(%rsp)
   11647:	bf 01 00 00 00       	mov    $0x1,%edi
   1164c:	89 f8                	mov    %edi,%eax
   1164e:	48 83 f8 08          	cmp    $0x8,%rax
   11652:	73 0a                	jae    1165e <fwp_write+0xd1e>
   11654:	31 c9                	xor    %ecx,%ecx
   11656:	48 89 c2             	mov    %rax,%rdx
   11659:	e9 f2 04 00 00       	jmp    11b50 <fwp_write+0x1210>
   1165e:	83 f8 20             	cmp    $0x20,%eax
   11661:	0f 83 f2 03 00 00    	jae    11a59 <fwp_write+0x1119>
   11667:	31 c9                	xor    %ecx,%ecx
   11669:	e9 92 04 00 00       	jmp    11b00 <fwp_write+0x11c0>
   1166e:	89 fa                	mov    %edi,%edx
   11670:	83 e2 1f             	and    $0x1f,%edx
   11673:	48 89 c1             	mov    %rax,%rcx
   11676:	48 29 d1             	sub    %rdx,%rcx
   11679:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
   11680:	00 
   11681:	66 0f ef c0          	pxor   %xmm0,%xmm0
   11685:	49 89 c0             	mov    %rax,%r8
   11688:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   1168f:	00 
   11690:	f3 42 0f 6f 0c 04    	movdqu (%rsp,%r8,1),%xmm1
   11696:	f3 42 0f 6f 54 04 10 	movdqu 0x10(%rsp,%r8,1),%xmm2
   1169d:	66 0f 6f da          	movdqa %xmm2,%xmm3
   116a1:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   116a5:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   116aa:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   116af:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   116b4:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   116b8:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   116bd:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   116c2:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   116c7:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   116cb:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   116cf:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   116d3:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   116d8:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   116dd:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   116e2:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   116e6:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   116eb:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   116f0:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   116f5:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   116f9:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
   116fe:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
   11702:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
   11706:	48 83 c6 20          	add    $0x20,%rsi
   1170a:	4c 39 c2             	cmp    %r8,%rdx
   1170d:	75 81                	jne    11690 <fwp_write+0xd50>
   1170f:	48 85 d2             	test   %rdx,%rdx
   11712:	0f 84 5b 04 00 00    	je     11b73 <fwp_write+0x1233>
   11718:	83 fa 08             	cmp    $0x8,%edx
   1171b:	72 5a                	jb     11777 <fwp_write+0xe37>
   1171d:	89 fa                	mov    %edi,%edx
   1171f:	83 e2 07             	and    $0x7,%edx
   11722:	48 89 c6             	mov    %rax,%rsi
   11725:	48 29 ce             	sub    %rcx,%rsi
   11728:	48 8d 3c 0c          	lea    (%rsp,%rcx,1),%rdi
   1172c:	48 83 c7 70          	add    $0x70,%rdi
   11730:	48 89 c1             	mov    %rax,%rcx
   11733:	48 29 d1             	sub    %rdx,%rcx
   11736:	66 0f ef c0          	pxor   %xmm0,%xmm0
   1173a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   11740:	f3 0f 7e 4c 34 18    	movq   0x18(%rsp,%rsi,1),%xmm1
   11746:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   1174a:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   1174f:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   11754:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   11759:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   1175d:	66 0f d6 0f          	movq   %xmm1,(%rdi)
   11761:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
   11765:	48 83 c7 08          	add    $0x8,%rdi
   11769:	48 39 f2             	cmp    %rsi,%rdx
   1176c:	75 d2                	jne    11740 <fwp_write+0xe00>
   1176e:	48 85 d2             	test   %rdx,%rdx
   11771:	0f 84 fc 03 00 00    	je     11b73 <fwp_write+0x1233>
   11777:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
   1177c:	48 01 f2             	add    %rsi,%rdx
   1177f:	48 ff ca             	dec    %rdx
   11782:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   11789:	1f 84 00 00 00 00 00 
   11790:	0f b6 32             	movzbl (%rdx),%esi
   11793:	40 88 74 0c 70       	mov    %sil,0x70(%rsp,%rcx,1)
   11798:	48 ff c1             	inc    %rcx
   1179b:	48 ff ca             	dec    %rdx
   1179e:	48 39 c8             	cmp    %rcx,%rax
   117a1:	75 ed                	jne    11790 <fwp_write+0xe50>
   117a3:	e9 cb 03 00 00       	jmp    11b73 <fwp_write+0x1233>
   117a8:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   117ad:	be 2e 00 00 00       	mov    $0x2e,%esi
   117b2:	e8 f9 19 ff ff       	call   31b0 <strchr@plt>
   117b7:	48 85 c0             	test   %rax,%rax
   117ba:	48 8b 2c 24          	mov    (%rsp),%rbp
   117be:	0f 85 b4 03 00 00    	jne    11b78 <fwp_write+0x1238>
   117c4:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   117c9:	be 65 00 00 00       	mov    $0x65,%esi
   117ce:	e8 dd 19 ff ff       	call   31b0 <strchr@plt>
   117d3:	48 85 c0             	test   %rax,%rax
   117d6:	0f 85 9c 03 00 00    	jne    11b78 <fwp_write+0x1238>
   117dc:	48 8d 35 a9 3e 00 00 	lea    0x3ea9(%rip),%rsi        # 1568c <exec_in_fp0+0xe7c>
   117e3:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   117e8:	e8 e3 1c ff ff       	call   34d0 <strstr@plt>
   117ed:	48 85 c0             	test   %rax,%rax
   117f0:	0f 85 82 03 00 00    	jne    11b78 <fwp_write+0x1238>
   117f6:	48 8d 35 93 3e 00 00 	lea    0x3e93(%rip),%rsi        # 15690 <exec_in_fp0+0xe80>
   117fd:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   11802:	e8 c9 1c ff ff       	call   34d0 <strstr@plt>
   11807:	48 85 c0             	test   %rax,%rax
   1180a:	0f 85 68 03 00 00    	jne    11b78 <fwp_write+0x1238>
   11810:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
   11815:	e8 56 19 ff ff       	call   3170 <strlen@plt>
   1181a:	66 c7 44 04 70 2e 30 	movw   $0x302e,0x70(%rsp,%rax,1)
   11821:	c6 44 04 72 00       	movb   $0x0,0x72(%rsp,%rax,1)
   11826:	e9 4d 03 00 00       	jmp    11b78 <fwp_write+0x1238>
   1182b:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
   1182f:	48 05 d0 03 00 00    	add    $0x3d0,%rax
   11835:	4c 01 f9             	add    %r15,%rcx
   11838:	48 89 08             	mov    %rcx,(%rax)
   1183b:	4c 89 ff             	mov    %r15,%rdi
   1183e:	31 f6                	xor    %esi,%esi
   11840:	e8 cb 19 ff ff       	call   3210 <memset@plt>
   11845:	66 41 c7 07 30 74    	movw   $0x7430,(%r15)
   1184b:	85 db                	test   %ebx,%ebx
   1184d:	0f 8e 98 00 00 00    	jle    118eb <fwp_write+0xfab>
   11853:	44 89 e1             	mov    %r12d,%ecx
   11856:	48 f7 d9             	neg    %rcx
   11859:	4a 8d 34 3b          	lea    (%rbx,%r15,1),%rsi
   1185d:	48 ff c6             	inc    %rsi
   11860:	31 ff                	xor    %edi,%edi
   11862:	49 b8 56 55 55 55 55 	movabs $0x5555555555555556,%r8
   11869:	55 55 55 
   1186c:	eb 2e                	jmp    1189c <fwp_write+0xf5c>
   1186e:	66 90                	xchg   %ax,%ax
   11870:	41 b2 30             	mov    $0x30,%r10b
   11873:	44 88 14 3e          	mov    %r10b,(%rsi,%rdi,1)
   11877:	48 85 d2             	test   %rdx,%rdx
   1187a:	0f 95 c2             	setne  %dl
   1187d:	4d 85 f6             	test   %r14,%r14
   11880:	41 0f 98 c2          	sets   %r10b
   11884:	41 20 d2             	and    %dl,%r10b
   11887:	41 0f b6 d2          	movzbl %r10b,%edx
   1188b:	48 29 d0             	sub    %rdx,%rax
   1188e:	4c 01 c8             	add    %r9,%rax
   11891:	48 ff cf             	dec    %rdi
   11894:	49 89 c6             	mov    %rax,%r14
   11897:	48 39 f9             	cmp    %rdi,%rcx
   1189a:	74 4f                	je     118eb <fwp_write+0xfab>
   1189c:	4c 89 f0             	mov    %r14,%rax
   1189f:	49 f7 e8             	imul   %r8
   118a2:	48 89 d0             	mov    %rdx,%rax
   118a5:	48 c1 e8 3f          	shr    $0x3f,%rax
   118a9:	48 01 d0             	add    %rdx,%rax
   118ac:	4c 8d 0c 40          	lea    (%rax,%rax,2),%r9
   118b0:	4c 89 f2             	mov    %r14,%rdx
   118b3:	4c 29 ca             	sub    %r9,%rdx
   118b6:	49 f7 d9             	neg    %r9
   118b9:	4d 01 f1             	add    %r14,%r9
   118bc:	49 83 c1 03          	add    $0x3,%r9
   118c0:	48 83 fa fd          	cmp    $0xfffffffffffffffd,%rdx
   118c4:	4c 0f 42 ca          	cmovb  %rdx,%r9
   118c8:	4d 85 c9             	test   %r9,%r9
   118cb:	74 a3                	je     11870 <fwp_write+0xf30>
   118cd:	49 83 f9 01          	cmp    $0x1,%r9
   118d1:	75 0d                	jne    118e0 <fwp_write+0xfa0>
   118d3:	41 b2 2b             	mov    $0x2b,%r10b
   118d6:	45 31 c9             	xor    %r9d,%r9d
   118d9:	eb 98                	jmp    11873 <fwp_write+0xf33>
   118db:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   118e0:	41 b2 2d             	mov    $0x2d,%r10b
   118e3:	41 b9 01 00 00 00    	mov    $0x1,%r9d
   118e9:	eb 88                	jmp    11873 <fwp_write+0xf33>
   118eb:	43 c6 44 27 02 00    	movb   $0x0,0x2(%r15,%r12,1)
   118f1:	4c 89 ff             	mov    %r15,%rdi
   118f4:	e8 77 18 ff ff       	call   3170 <strlen@plt>
   118f9:	48 89 ef             	mov    %rbp,%rdi
   118fc:	4c 89 fe             	mov    %r15,%rsi
   118ff:	48 89 c2             	mov    %rax,%rdx
   11902:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
   11909:	5b                   	pop    %rbx
   1190a:	41 5c                	pop    %r12
   1190c:	41 5d                	pop    %r13
   1190e:	41 5e                	pop    %r14
   11910:	41 5f                	pop    %r15
   11912:	5d                   	pop    %rbp
   11913:	e9 f8 b3 ff ff       	jmp    cd10 <buf_put>
   11918:	48 8b 31             	mov    (%rcx),%rsi
   1191b:	eb 18                	jmp    11935 <fwp_write+0xff5>
   1191d:	83 3a 00             	cmpl   $0x0,(%rdx)
   11920:	0f b6 01             	movzbl (%rcx),%eax
   11923:	48 0f be f0          	movsbq %al,%rsi
   11927:	eb 08                	jmp    11931 <fwp_write+0xff1>
   11929:	83 3a 02             	cmpl   $0x2,(%rdx)
   1192c:	8b 01                	mov    (%rcx),%eax
   1192e:	48 63 f0             	movslq %eax,%rsi
   11931:	48 0f 45 f0          	cmovne %rax,%rsi
   11935:	48 8b 2c 24          	mov    (%rsp),%rbp
   11939:	48 89 ef             	mov    %rbp,%rdi
   1193c:	31 c9                	xor    %ecx,%ecx
   1193e:	e8 fd ef ff ff       	call   10940 <fwp_write>
   11943:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
   1194a:	ff ff 7f 
   1194d:	48 ff c8             	dec    %rax
   11950:	49 85 06             	test   %rax,(%r14)
   11953:	0f 84 c9 00 00 00    	je     11a22 <fwp_write+0x10e2>
   11959:	bb 01 00 00 00       	mov    $0x1,%ebx
   1195e:	4c 8d 25 f3 3c 00 00 	lea    0x3cf3(%rip),%r12        # 15658 <exec_in_fp0+0xe48>
   11965:	eb 39                	jmp    119a0 <fwp_write+0x1060>
   11967:	83 3a 01             	cmpl   $0x1,(%rdx)
   1196a:	0f b7 04 31          	movzwl (%rcx,%rsi,1),%eax
   1196e:	48 0f bf f0          	movswq %ax,%rsi
   11972:	48 0f 45 f0          	cmovne %rax,%rsi
   11976:	48 8b 2c 24          	mov    (%rsp),%rbp
   1197a:	48 89 ef             	mov    %rbp,%rdi
   1197d:	31 c9                	xor    %ecx,%ecx
   1197f:	e8 bc ef ff ff       	call   10940 <fwp_write>
   11984:	48 ff c3             	inc    %rbx
   11987:	49 8b 06             	mov    (%r14),%rax
   1198a:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
   11991:	ff ff 7f 
   11994:	48 21 c8             	and    %rcx,%rax
   11997:	48 39 c3             	cmp    %rax,%rbx
   1199a:	0f 83 82 00 00 00    	jae    11a22 <fwp_write+0x10e2>
   119a0:	ba 02 00 00 00       	mov    $0x2,%edx
   119a5:	48 89 ef             	mov    %rbp,%rdi
   119a8:	4c 89 e6             	mov    %r12,%rsi
   119ab:	e8 60 b3 ff ff       	call   cd10 <buf_put>
   119b0:	49 8b 57 38          	mov    0x38(%r15),%rdx
   119b4:	b8 08 00 00 00       	mov    $0x8,%eax
   119b9:	48 85 d2             	test   %rdx,%rdx
   119bc:	74 13                	je     119d1 <fwp_write+0x1091>
   119be:	8b 0a                	mov    (%rdx),%ecx
   119c0:	48 83 f9 0a          	cmp    $0xa,%rcx
   119c4:	77 0b                	ja     119d1 <fwp_write+0x1091>
   119c6:	48 8d 05 c3 2e 00 00 	lea    0x2ec3(%rip),%rax        # 14890 <exec_in_fp0+0x80>
   119cd:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
   119d1:	49 83 3e 00          	cmpq   $0x0,(%r14)
   119d5:	4c 89 e9             	mov    %r13,%rcx
   119d8:	79 04                	jns    119de <fwp_write+0x109e>
   119da:	49 8b 4e 10          	mov    0x10(%r14),%rcx
   119de:	48 89 c6             	mov    %rax,%rsi
   119e1:	48 0f af f3          	imul   %rbx,%rsi
   119e5:	48 83 f8 01          	cmp    $0x1,%rax
   119e9:	74 19                	je     11a04 <fwp_write+0x10c4>
   119eb:	48 83 f8 02          	cmp    $0x2,%rax
   119ef:	0f 84 72 ff ff ff    	je     11967 <fwp_write+0x1027>
   119f5:	48 83 f8 08          	cmp    $0x8,%rax
   119f9:	75 19                	jne    11a14 <fwp_write+0x10d4>
   119fb:	48 8b 34 31          	mov    (%rcx,%rsi,1),%rsi
   119ff:	e9 72 ff ff ff       	jmp    11976 <fwp_write+0x1036>
   11a04:	83 3a 00             	cmpl   $0x0,(%rdx)
   11a07:	0f b6 04 31          	movzbl (%rcx,%rsi,1),%eax
   11a0b:	48 0f be f0          	movsbq %al,%rsi
   11a0f:	e9 5e ff ff ff       	jmp    11972 <fwp_write+0x1032>
   11a14:	83 3a 02             	cmpl   $0x2,(%rdx)
   11a17:	8b 04 31             	mov    (%rcx,%rsi,1),%eax
   11a1a:	48 63 f0             	movslq %eax,%rsi
   11a1d:	e9 50 ff ff ff       	jmp    11972 <fwp_write+0x1032>
   11a22:	c6 44 24 70 5d       	movb   $0x5d,0x70(%rsp)
   11a27:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
   11a2c:	ba 01 00 00 00       	mov    $0x1,%edx
   11a31:	48 89 ef             	mov    %rbp,%rdi
   11a34:	e9 55 01 00 00       	jmp    11b8e <fwp_write+0x124e>
   11a39:	48 8d 35 01 3d 00 00 	lea    0x3d01(%rip),%rsi        # 15741 <exec_in_fp0+0xf31>
   11a40:	ba 02 00 00 00       	mov    $0x2,%edx
   11a45:	48 89 ef             	mov    %rbp,%rdi
   11a48:	e9 b5 fe ff ff       	jmp    11902 <fwp_write+0xfc2>
   11a4d:	31 c0                	xor    %eax,%eax
   11a4f:	c6 44 04 71 00       	movb   $0x0,0x71(%rsp,%rax,1)
   11a54:	e9 1f 01 00 00       	jmp    11b78 <fwp_write+0x1238>
   11a59:	89 fa                	mov    %edi,%edx
   11a5b:	83 e2 1f             	and    $0x1f,%edx
   11a5e:	48 89 c1             	mov    %rax,%rcx
   11a61:	48 29 d1             	sub    %rdx,%rcx
   11a64:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
   11a6b:	00 
   11a6c:	66 0f ef c0          	pxor   %xmm0,%xmm0
   11a70:	49 89 c0             	mov    %rax,%r8
   11a73:	f3 42 0f 6f 0c 04    	movdqu (%rsp,%r8,1),%xmm1
   11a79:	f3 42 0f 6f 54 04 10 	movdqu 0x10(%rsp,%r8,1),%xmm2
   11a80:	66 0f 6f da          	movdqa %xmm2,%xmm3
   11a84:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   11a88:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   11a8d:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   11a92:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   11a97:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   11a9b:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   11aa0:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   11aa5:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   11aaa:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   11aae:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   11ab2:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   11ab6:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   11abb:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   11ac0:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   11ac5:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   11ac9:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   11ace:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   11ad3:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   11ad8:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   11adc:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
   11ae1:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
   11ae5:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
   11ae9:	48 83 c6 20          	add    $0x20,%rsi
   11aed:	4c 39 c2             	cmp    %r8,%rdx
   11af0:	75 81                	jne    11a73 <fwp_write+0x1133>
   11af2:	48 85 d2             	test   %rdx,%rdx
   11af5:	0f 84 78 00 00 00    	je     11b73 <fwp_write+0x1233>
   11afb:	83 fa 08             	cmp    $0x8,%edx
   11afe:	72 50                	jb     11b50 <fwp_write+0x1210>
   11b00:	89 fa                	mov    %edi,%edx
   11b02:	83 e2 07             	and    $0x7,%edx
   11b05:	48 89 c6             	mov    %rax,%rsi
   11b08:	48 29 ce             	sub    %rcx,%rsi
   11b0b:	48 8d 3c 0c          	lea    (%rsp,%rcx,1),%rdi
   11b0f:	48 83 c7 70          	add    $0x70,%rdi
   11b13:	48 89 c1             	mov    %rax,%rcx
   11b16:	48 29 d1             	sub    %rdx,%rcx
   11b19:	66 0f ef c0          	pxor   %xmm0,%xmm0
   11b1d:	f3 0f 7e 4c 34 18    	movq   0x18(%rsp,%rsi,1),%xmm1
   11b23:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   11b27:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   11b2c:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   11b31:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   11b36:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   11b3a:	66 0f d6 0f          	movq   %xmm1,(%rdi)
   11b3e:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
   11b42:	48 83 c7 08          	add    $0x8,%rdi
   11b46:	48 39 f2             	cmp    %rsi,%rdx
   11b49:	75 d2                	jne    11b1d <fwp_write+0x11dd>
   11b4b:	48 85 d2             	test   %rdx,%rdx
   11b4e:	74 23                	je     11b73 <fwp_write+0x1233>
   11b50:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
   11b55:	48 01 f2             	add    %rsi,%rdx
   11b58:	48 ff ca             	dec    %rdx
   11b5b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   11b60:	0f b6 32             	movzbl (%rdx),%esi
   11b63:	40 88 74 0c 70       	mov    %sil,0x70(%rsp,%rcx,1)
   11b68:	48 ff c1             	inc    %rcx
   11b6b:	48 ff ca             	dec    %rdx
   11b6e:	48 39 c8             	cmp    %rcx,%rax
   11b71:	75 ed                	jne    11b60 <fwp_write+0x1220>
   11b73:	c6 44 04 70 00       	movb   $0x0,0x70(%rsp,%rax,1)
   11b78:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11b7d:	4c 89 f7             	mov    %r14,%rdi
   11b80:	e8 eb 15 ff ff       	call   3170 <strlen@plt>
   11b85:	48 89 ef             	mov    %rbp,%rdi
   11b88:	4c 89 f6             	mov    %r14,%rsi
   11b8b:	48 89 c2             	mov    %rax,%rdx
   11b8e:	e8 7d b1 ff ff       	call   cd10 <buf_put>
   11b93:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
   11b9a:	5b                   	pop    %rbx
   11b9b:	41 5c                	pop    %r12
   11b9d:	41 5d                	pop    %r13
   11b9f:	41 5e                	pop    %r14
   11ba1:	41 5f                	pop    %r15
   11ba3:	5d                   	pop    %rbp
   11ba4:	c3                   	ret
   11ba5:	83 f8 20             	cmp    $0x20,%eax
   11ba8:	73 07                	jae    11bb1 <fwp_write+0x1271>
   11baa:	31 c9                	xor    %ecx,%ecx
   11bac:	e9 b6 00 00 00       	jmp    11c67 <fwp_write+0x1327>
   11bb1:	89 fe                	mov    %edi,%esi
   11bb3:	89 fa                	mov    %edi,%edx
   11bb5:	83 e2 1f             	and    $0x1f,%edx
   11bb8:	48 89 c1             	mov    %rax,%rcx
   11bbb:	48 29 d1             	sub    %rdx,%rcx
   11bbe:	4c 8d 04 34          	lea    (%rsp,%rsi,1),%r8
   11bc2:	49 83 c0 10          	add    $0x10,%r8
   11bc6:	48 29 d6             	sub    %rdx,%rsi
   11bc9:	45 31 c9             	xor    %r9d,%r9d
   11bcc:	66 0f ef c0          	pxor   %xmm0,%xmm0
   11bd0:	f3 41 0f 6f 48 f0    	movdqu -0x10(%r8),%xmm1
   11bd6:	f3 41 0f 6f 10       	movdqu (%r8),%xmm2
   11bdb:	66 0f 6f da          	movdqa %xmm2,%xmm3
   11bdf:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   11be3:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   11be8:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   11bed:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   11bf2:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   11bf6:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   11bfb:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   11c00:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   11c05:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   11c09:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   11c0d:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   11c11:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   11c16:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   11c1b:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   11c20:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   11c24:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   11c29:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   11c2e:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   11c33:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   11c37:	f3 42 0f 7f 54 0c 71 	movdqu %xmm2,0x71(%rsp,%r9,1)
   11c3e:	f3 42 0f 7f 8c 0c 81 	movdqu %xmm1,0x81(%rsp,%r9,1)
   11c45:	00 00 00 
   11c48:	49 83 c1 20          	add    $0x20,%r9
   11c4c:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
   11c50:	4c 39 ce             	cmp    %r9,%rsi
   11c53:	0f 85 77 ff ff ff    	jne    11bd0 <fwp_write+0x1290>
   11c59:	48 85 d2             	test   %rdx,%rdx
   11c5c:	0f 84 91 00 00 00    	je     11cf3 <fwp_write+0x13b3>
   11c62:	83 fa 08             	cmp    $0x8,%edx
   11c65:	72 60                	jb     11cc7 <fwp_write+0x1387>
   11c67:	48 89 ce             	mov    %rcx,%rsi
   11c6a:	41 89 f8             	mov    %edi,%r8d
   11c6d:	89 fa                	mov    %edi,%edx
   11c6f:	83 e2 07             	and    $0x7,%edx
   11c72:	48 89 c1             	mov    %rax,%rcx
   11c75:	48 29 d1             	sub    %rdx,%rcx
   11c78:	49 89 f1             	mov    %rsi,%r9
   11c7b:	49 f7 d9             	neg    %r9
   11c7e:	49 01 e1             	add    %rsp,%r9
   11c81:	49 83 c1 20          	add    $0x20,%r9
   11c85:	4d 01 c1             	add    %r8,%r9
   11c88:	49 83 c1 f8          	add    $0xfffffffffffffff8,%r9
   11c8c:	49 29 d0             	sub    %rdx,%r8
   11c8f:	66 0f ef c0          	pxor   %xmm0,%xmm0
   11c93:	f3 41 0f 7e 09       	movq   (%r9),%xmm1
   11c98:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   11c9c:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   11ca1:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   11ca6:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   11cab:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   11caf:	66 0f d6 4c 34 71    	movq   %xmm1,0x71(%rsp,%rsi,1)
   11cb5:	48 83 c6 08          	add    $0x8,%rsi
   11cb9:	49 83 c1 f8          	add    $0xfffffffffffffff8,%r9
   11cbd:	49 39 f0             	cmp    %rsi,%r8
   11cc0:	75 d1                	jne    11c93 <fwp_write+0x1353>
   11cc2:	48 85 d2             	test   %rdx,%rdx
   11cc5:	74 2c                	je     11cf3 <fwp_write+0x13b3>
   11cc7:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
   11ccc:	48 01 f2             	add    %rsi,%rdx
   11ccf:	48 ff ca             	dec    %rdx
   11cd2:	89 fe                	mov    %edi,%esi
   11cd4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
   11cdb:	00 00 00 00 00 
   11ce0:	0f b6 3a             	movzbl (%rdx),%edi
   11ce3:	40 88 7c 0c 71       	mov    %dil,0x71(%rsp,%rcx,1)
   11ce8:	48 ff c1             	inc    %rcx
   11ceb:	48 ff ca             	dec    %rdx
   11cee:	48 39 ce             	cmp    %rcx,%rsi
   11cf1:	75 ed                	jne    11ce0 <fwp_write+0x13a0>
   11cf3:	c6 44 04 71 00       	movb   $0x0,0x71(%rsp,%rax,1)
   11cf8:	e9 7b fe ff ff       	jmp    11b78 <fwp_write+0x1238>
   11cfd:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
   11d02:	4c 89 f7             	mov    %r14,%rdi
   11d05:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
   11d0b:	be 09 00 00 00       	mov    $0x9,%esi
   11d10:	e8 8b 0c 00 00       	call   129a0 <fwp_format_g>
   11d15:	4c 89 f7             	mov    %r14,%rdi
   11d18:	e9 bf f8 ff ff       	jmp    115dc <fwp_write+0xc9c>
   11d1d:	c7 44 24 70 4e 61 4e 	movl   $0x4e614e,0x70(%rsp)
   11d24:	00 
   11d25:	e9 4e fe ff ff       	jmp    11b78 <fwp_write+0x1238>
   11d2a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000011d30 <fwp_escape>:
   11d30:	55                   	push   %rbp
   11d31:	41 57                	push   %r15
   11d33:	41 56                	push   %r14
   11d35:	41 55                	push   %r13
   11d37:	41 54                	push   %r12
   11d39:	53                   	push   %rbx
   11d3a:	48 83 ec 18          	sub    $0x18,%rsp
   11d3e:	49 89 d6             	mov    %rdx,%r14
   11d41:	49 89 f7             	mov    %rsi,%r15
   11d44:	48 89 fb             	mov    %rdi,%rbx
   11d47:	c6 04 24 22          	movb   $0x22,(%rsp)
   11d4b:	48 89 e6             	mov    %rsp,%rsi
   11d4e:	ba 01 00 00 00       	mov    $0x1,%edx
   11d53:	e8 b8 af ff ff       	call   cd10 <buf_put>
   11d58:	4d 85 f6             	test   %r14,%r14
   11d5b:	0f 84 de 00 00 00    	je     11e3f <fwp_escape+0x10f>
   11d61:	48 89 e5             	mov    %rsp,%rbp
   11d64:	4c 8d 2d 39 28 00 00 	lea    0x2839(%rip),%r13        # 145a4 <_IO_stdin_used+0x5a4>
   11d6b:	45 31 e4             	xor    %r12d,%r12d
   11d6e:	eb 21                	jmp    11d91 <fwp_escape+0x61>
   11d70:	ba 02 00 00 00       	mov    $0x2,%edx
   11d75:	48 89 df             	mov    %rbx,%rdi
   11d78:	48 8d 35 ec 39 00 00 	lea    0x39ec(%rip),%rsi        # 1576b <exec_in_fp0+0xf5b>
   11d7f:	90                   	nop
   11d80:	e8 8b af ff ff       	call   cd10 <buf_put>
   11d85:	49 ff c4             	inc    %r12
   11d88:	4d 39 e6             	cmp    %r12,%r14
   11d8b:	0f 84 ae 00 00 00    	je     11e3f <fwp_escape+0x10f>
   11d91:	43 0f b6 04 27       	movzbl (%r15,%r12,1),%eax
   11d96:	0f b6 c8             	movzbl %al,%ecx
   11d99:	8d 51 f7             	lea    -0x9(%rcx),%edx
   11d9c:	83 fa 19             	cmp    $0x19,%edx
   11d9f:	77 1f                	ja     11dc0 <fwp_escape+0x90>
   11da1:	49 63 54 95 00       	movslq 0x0(%r13,%rdx,4),%rdx
   11da6:	4c 01 ea             	add    %r13,%rdx
   11da9:	ff e2                	jmp    *%rdx
   11dab:	ba 02 00 00 00       	mov    $0x2,%edx
   11db0:	48 89 df             	mov    %rbx,%rdi
   11db3:	48 8d 35 ae 39 00 00 	lea    0x39ae(%rip),%rsi        # 15768 <exec_in_fp0+0xf58>
   11dba:	eb c4                	jmp    11d80 <fwp_escape+0x50>
   11dbc:	0f 1f 40 00          	nopl   0x0(%rax)
   11dc0:	83 f9 5c             	cmp    $0x5c,%ecx
   11dc3:	75 11                	jne    11dd6 <fwp_escape+0xa6>
   11dc5:	ba 02 00 00 00       	mov    $0x2,%edx
   11dca:	48 89 df             	mov    %rbx,%rdi
   11dcd:	48 8d 35 8e 39 00 00 	lea    0x398e(%rip),%rsi        # 15762 <exec_in_fp0+0xf52>
   11dd4:	eb aa                	jmp    11d80 <fwp_escape+0x50>
   11dd6:	3c 20                	cmp    $0x20,%al
   11dd8:	72 39                	jb     11e13 <fwp_escape+0xe3>
   11dda:	3c 7f                	cmp    $0x7f,%al
   11ddc:	74 35                	je     11e13 <fwp_escape+0xe3>
   11dde:	88 04 24             	mov    %al,(%rsp)
   11de1:	ba 01 00 00 00       	mov    $0x1,%edx
   11de6:	48 89 df             	mov    %rbx,%rdi
   11de9:	48 89 ee             	mov    %rbp,%rsi
   11dec:	eb 92                	jmp    11d80 <fwp_escape+0x50>
   11dee:	ba 02 00 00 00       	mov    $0x2,%edx
   11df3:	48 89 df             	mov    %rbx,%rdi
   11df6:	48 8d 35 62 39 00 00 	lea    0x3962(%rip),%rsi        # 1575f <exec_in_fp0+0xf4f>
   11dfd:	eb 81                	jmp    11d80 <fwp_escape+0x50>
   11dff:	ba 02 00 00 00       	mov    $0x2,%edx
   11e04:	48 89 df             	mov    %rbx,%rdi
   11e07:	48 8d 35 57 39 00 00 	lea    0x3957(%rip),%rsi        # 15765 <exec_in_fp0+0xf55>
   11e0e:	e9 6d ff ff ff       	jmp    11d80 <fwp_escape+0x50>
   11e13:	be 10 00 00 00       	mov    $0x10,%esi
   11e18:	48 89 ef             	mov    %rbp,%rdi
   11e1b:	48 8d 15 4c 39 00 00 	lea    0x394c(%rip),%rdx        # 1576e <exec_in_fp0+0xf5e>
   11e22:	31 c0                	xor    %eax,%eax
   11e24:	e8 a7 13 ff ff       	call   31d0 <snprintf@plt>
   11e29:	48 89 ef             	mov    %rbp,%rdi
   11e2c:	e8 3f 13 ff ff       	call   3170 <strlen@plt>
   11e31:	48 89 df             	mov    %rbx,%rdi
   11e34:	48 89 ee             	mov    %rbp,%rsi
   11e37:	48 89 c2             	mov    %rax,%rdx
   11e3a:	e9 41 ff ff ff       	jmp    11d80 <fwp_escape+0x50>
   11e3f:	c6 04 24 22          	movb   $0x22,(%rsp)
   11e43:	48 89 e6             	mov    %rsp,%rsi
   11e46:	ba 01 00 00 00       	mov    $0x1,%edx
   11e4b:	48 89 df             	mov    %rbx,%rdi
   11e4e:	e8 bd ae ff ff       	call   cd10 <buf_put>
   11e53:	48 83 c4 18          	add    $0x18,%rsp
   11e57:	5b                   	pop    %rbx
   11e58:	41 5c                	pop    %r12
   11e5a:	41 5d                	pop    %r13
   11e5c:	41 5e                	pop    %r14
   11e5e:	41 5f                	pop    %r15
   11e60:	5d                   	pop    %rbp
   11e61:	c3                   	ret
   11e62:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   11e69:	1f 84 00 00 00 00 00 

0000000000011e70 <fwp_fmt_duration>:
   11e70:	41 57                	push   %r15
   11e72:	41 56                	push   %r14
   11e74:	41 54                	push   %r12
   11e76:	53                   	push   %rbx
   11e77:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
   11e7e:	48 89 f0             	mov    %rsi,%rax
   11e81:	48 09 d0             	or     %rdx,%rax
   11e84:	0f 84 bf 02 00 00    	je     12149 <fwp_fmt_duration+0x2d9>
   11e8a:	49 89 d0             	mov    %rdx,%r8
   11e8d:	48 b9 1d 3f c2 25 d6 	movabs $0xd2fe1d625c23f1d,%rcx
   11e94:	e1 2f 0d 
   11e97:	48 0f af ce          	imul   %rsi,%rcx
   11e9b:	49 b9 0d b1 f3 e4 99 	movabs $0x1c52799e4f3b10d,%r9
   11ea2:	27 c5 01 
   11ea5:	48 89 f0             	mov    %rsi,%rax
   11ea8:	49 f7 e1             	mul    %r9
   11eab:	48 01 ca             	add    %rcx,%rdx
   11eae:	4d 0f af c8          	imul   %r8,%r9
   11eb2:	49 01 d1             	add    %rdx,%r9
   11eb5:	48 b9 00 a0 34 52 a3 	movabs $0x6baf6aa35234a000,%rcx
   11ebc:	6a af 6b 
   11ebf:	48 01 c1             	add    %rax,%rcx
   11ec2:	48 b8 37 f9 ff e2 04 	movabs $0x4e2fff937,%rax
   11ec9:	00 00 00 
   11ecc:	4c 11 c8             	adc    %r9,%rax
   11ecf:	48 89 c2             	mov    %rax,%rdx
   11ed2:	48 0f ac ca 0d       	shrd   $0xd,%rcx,%rdx
   11ed7:	48 0f a4 c8 33       	shld   $0x33,%rcx,%rax
   11edc:	48 b9 4a 23 35 aa f6 	movabs $0x9376baf6aa35234a,%rcx
   11ee3:	ba 76 93 
   11ee6:	48 39 c1             	cmp    %rax,%rcx
   11ee9:	b8 ff 2f 4e 00       	mov    $0x4e2fff,%eax
   11eee:	48 19 d0             	sbb    %rdx,%rax
   11ef1:	0f 83 70 02 00 00    	jae    12167 <fwp_fmt_duration+0x2f7>
   11ef7:	48 b9 b3 b2 61 36 8c 	movabs $0xc5ce3b8c3661b2b3,%rcx
   11efe:	3b ce c5 
   11f01:	49 b9 c3 5f 47 6a 04 	movabs $0x1a8d52046a475fc3,%r9
   11f08:	52 8d 1a 
   11f0b:	48 89 f0             	mov    %rsi,%rax
   11f0e:	49 f7 e1             	mul    %r9
   11f11:	48 0f af ce          	imul   %rsi,%rcx
   11f15:	48 01 ca             	add    %rcx,%rdx
   11f18:	4d 0f af c8          	imul   %r8,%r9
   11f1c:	49 01 d1             	add    %rdx,%r9
   11f1f:	48 b9 00 a8 16 d1 91 	movabs $0x4f473f91d116a800,%rcx
   11f26:	3f 47 4f 
   11f29:	48 01 c1             	add    %rax,%rcx
   11f2c:	48 b8 3f 9a ff 4c 49 	movabs $0x494cff9a3f,%rax
   11f33:	00 00 00 
   11f36:	4c 11 c8             	adc    %r9,%rax
   11f39:	48 89 c2             	mov    %rax,%rdx
   11f3c:	48 0f ac ca 0b       	shrd   $0xb,%rcx,%rdx
   11f41:	48 0f a4 c8 35       	shld   $0x35,%rcx,%rax
   11f46:	48 b9 ab 45 74 e4 cf 	movabs $0x8fd3d1cfe47445ab,%rcx
   11f4d:	d1 d3 8f 
   11f50:	48 39 c8             	cmp    %rcx,%rax
   11f53:	48 81 da e6 3f 53 12 	sbb    $0x12533fe6,%rdx
   11f5a:	0f 82 27 02 00 00    	jb     12187 <fwp_fmt_duration+0x317>
   11f60:	48 b9 7e 78 b9 2f 37 	movabs $0x97157d372fb9787e,%rcx
   11f67:	7d 15 97 
   11f6a:	48 0f af ce          	imul   %rsi,%rcx
   11f6e:	49 b9 6d 9c 2e 3a 42 	movabs $0x8e47ce423a2e9c6d,%r9
   11f75:	ce 47 8e 
   11f78:	48 89 f0             	mov    %rsi,%rax
   11f7b:	49 f7 e1             	mul    %r9
   11f7e:	48 01 ca             	add    %rcx,%rdx
   11f81:	4d 0f af c8          	imul   %r8,%r9
   11f85:	49 01 d1             	add    %rdx,%r9
   11f88:	48 b9 00 46 54 40 8b 	movabs $0xa52cb98b40544600,%rcx
   11f8f:	b9 2c a5 
   11f92:	48 01 c1             	add    %rax,%rcx
   11f95:	48 b8 b5 09 fa 82 4b 	movabs $0x44b82fa09b5,%rax
   11f9c:	04 00 00 
   11f9f:	4c 11 c8             	adc    %r9,%rax
   11fa2:	48 89 c2             	mov    %rax,%rdx
   11fa5:	48 0f ac ca 09       	shrd   $0x9,%rcx,%rdx
   11faa:	48 0f a4 c8 37       	shld   $0x37,%rcx,%rax
   11faf:	48 b9 47 54 40 8b b9 	movabs $0xb5a52cb98b405447,%rcx
   11fb6:	2c a5 b5 
   11fb9:	48 39 c8             	cmp    %rcx,%rax
   11fbc:	48 b8 09 fa 82 4b 04 	movabs $0x44b82fa09,%rax
   11fc3:	00 00 00 
   11fc6:	48 19 c2             	sbb    %rax,%rdx
   11fc9:	0f 82 0d 03 00 00    	jb     122dc <fwp_fmt_duration+0x46c>
   11fcf:	48 b9 cb d5 8f 4d f2 	movabs $0xc57e23f24d8fd5cb,%rcx
   11fd6:	23 7e c5 
   11fd9:	48 0f af ce          	imul   %rsi,%rcx
   11fdd:	49 b9 39 61 c2 68 56 	movabs $0x790fb65668c26139,%r9
   11fe4:	b6 0f 79 
   11fe7:	48 89 f0             	mov    %rsi,%rax
   11fea:	49 f7 e1             	mul    %r9
   11fed:	48 01 ca             	add    %rcx,%rdx
   11ff0:	4d 0f af c8          	imul   %r8,%r9
   11ff4:	49 01 d1             	add    %rdx,%r9
   11ff7:	48 b9 00 0b 27 69 fe 	movabs $0xa6d698fe69270b00,%rcx
   11ffe:	98 d6 a6 
   12001:	48 01 c1             	add    %rax,%rcx
   12004:	48 b8 b1 bd 16 f4 de 	movabs $0x218def416bdb1,%rax
   1200b:	18 02 00 
   1200e:	4c 11 c8             	adc    %r9,%rax
   12011:	48 89 c2             	mov    %rax,%rdx
   12014:	48 0f ac ca 06       	shrd   $0x6,%rcx,%rdx
   12019:	48 0f a4 c8 3a       	shld   $0x3a,%rcx,%rax
   1201e:	48 b9 59 38 49 f3 c7 	movabs $0x8d36b4c7f3493859,%rcx
   12025:	b4 36 8d 
   12028:	48 39 c8             	cmp    %rcx,%rax
   1202b:	48 b8 ed b5 a0 f7 c6 	movabs $0x10c6f7a0b5ed,%rax
   12032:	10 00 00 
   12035:	48 19 c2             	sbb    %rax,%rdx
   12038:	0f 82 ad 02 00 00    	jb     122eb <fwp_fmt_duration+0x47b>
   1203e:	48 b9 5a 64 3b df 4f 	movabs $0x6e978d4fdf3b645a,%rcx
   12045:	8d 97 6e 
   12048:	48 0f af ce          	imul   %rsi,%rcx
   1204c:	49 b9 d5 78 e9 26 31 	movabs $0x1cac083126e978d5,%r9
   12053:	08 ac 1c 
   12056:	48 89 f0             	mov    %rsi,%rax
   12059:	49 f7 e1             	mul    %r9
   1205c:	48 01 ca             	add    %rcx,%rdx
   1205f:	4d 0f af c8          	imul   %r8,%r9
   12063:	49 01 d1             	add    %rdx,%r9
   12066:	48 b9 48 62 10 58 39 	movabs $0x76c8b43958106248,%rcx
   1206d:	b4 c8 76 
   12070:	48 01 c1             	add    %rax,%rcx
   12073:	48 b8 be 9f 1a 2f dd 	movabs $0x10624dd2f1a9fbe,%rax
   1207a:	24 06 01 
   1207d:	4c 11 c8             	adc    %r9,%rax
   12080:	48 89 c2             	mov    %rax,%rdx
   12083:	48 0f ac ca 03       	shrd   $0x3,%rcx,%rdx
   12088:	48 0f a4 c8 3d       	shld   $0x3d,%rcx,%rax
   1208d:	48 b9 93 18 04 56 0e 	movabs $0x9db22d0e56041893,%rcx
   12094:	2d b2 9d 
   12097:	48 39 c8             	cmp    %rcx,%rax
   1209a:	48 b8 ef a7 c6 4b 37 	movabs $0x4189374bc6a7ef,%rax
   120a1:	89 41 00 
   120a4:	48 19 c2             	sbb    %rax,%rdx
   120a7:	0f 82 4d 02 00 00    	jb     122fa <fwp_fmt_duration+0x48a>
   120ad:	4d 85 c0             	test   %r8,%r8
   120b0:	0f 88 d6 06 00 00    	js     1278c <fwp_fmt_duration+0x91c>
   120b6:	45 31 d2             	xor    %r10d,%r10d
   120b9:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
   120c0:	cc cc cc 
   120c3:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
   120ca:	cc cc cc 
   120cd:	4d 89 c6             	mov    %r8,%r14
   120d0:	4c 89 c1             	mov    %r8,%rcx
   120d3:	48 0f a4 f1 3f       	shld   $0x3f,%rsi,%rcx
   120d8:	49 d1 ee             	shr    $1,%r14
   120db:	49 89 c9             	mov    %rcx,%r9
   120de:	4d 01 f1             	add    %r14,%r9
   120e1:	49 83 d1 00          	adc    $0x0,%r9
   120e5:	4c 89 c8             	mov    %r9,%rax
   120e8:	49 f7 e3             	mul    %r11
   120eb:	48 c1 ea 02          	shr    $0x2,%rdx
   120ef:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   120f3:	49 29 c1             	sub    %rax,%r9
   120f6:	4c 29 c9             	sub    %r9,%rcx
   120f9:	49 83 de 00          	sbb    $0x0,%r14
   120fd:	49 89 c9             	mov    %rcx,%r9
   12100:	4c 0f af cb          	imul   %rbx,%r9
   12104:	48 89 c8             	mov    %rcx,%rax
   12107:	49 f7 e3             	mul    %r11
   1210a:	4c 01 ca             	add    %r9,%rdx
   1210d:	4d 0f af f3          	imul   %r11,%r14
   12111:	49 01 d6             	add    %rdx,%r14
   12114:	48 89 c1             	mov    %rax,%rcx
   12117:	48 01 c1             	add    %rax,%rcx
   1211a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
   1211e:	89 f2                	mov    %esi,%edx
   12120:	29 ca                	sub    %ecx,%edx
   12122:	80 ca 30             	or     $0x30,%dl
   12125:	42 88 54 14 40       	mov    %dl,0x40(%rsp,%r10,1)
   1212a:	49 ff c2             	inc    %r10
   1212d:	48 83 fe 0a          	cmp    $0xa,%rsi
   12131:	49 83 d8 00          	sbb    $0x0,%r8
   12135:	48 89 c6             	mov    %rax,%rsi
   12138:	4d 89 f0             	mov    %r14,%r8
   1213b:	73 93                	jae    120d0 <fwp_fmt_duration+0x260>
   1213d:	45 85 d2             	test   %r10d,%r10d
   12140:	7f 12                	jg     12154 <fwp_fmt_duration+0x2e4>
   12142:	31 c0                	xor    %eax,%eax
   12144:	e9 79 01 00 00       	jmp    122c2 <fwp_fmt_duration+0x452>
   12149:	c6 44 24 40 30       	movb   $0x30,0x40(%rsp)
   1214e:	41 ba 01 00 00 00    	mov    $0x1,%r10d
   12154:	44 89 d0             	mov    %r10d,%eax
   12157:	48 83 f8 08          	cmp    $0x8,%rax
   1215b:	73 1e                	jae    1217b <fwp_fmt_duration+0x30b>
   1215d:	31 c9                	xor    %ecx,%ecx
   1215f:	48 89 c2             	mov    %rax,%rdx
   12162:	e9 3d 01 00 00       	jmp    122a4 <fwp_fmt_duration+0x434>
   12167:	49 89 fe             	mov    %rdi,%r14
   1216a:	48 ba 00 a0 b8 30 46 	movabs $0x34630b8a000,%rdx
   12171:	03 00 00 
   12174:	31 c0                	xor    %eax,%eax
   12176:	e9 8c 01 00 00       	jmp    12307 <fwp_fmt_duration+0x497>
   1217b:	83 f8 20             	cmp    $0x20,%eax
   1217e:	73 1e                	jae    1219e <fwp_fmt_duration+0x32e>
   12180:	31 c9                	xor    %ecx,%ecx
   12182:	e9 c3 00 00 00       	jmp    1224a <fwp_fmt_duration+0x3da>
   12187:	49 89 fe             	mov    %rdi,%r14
   1218a:	48 ba 00 58 47 f8 0d 	movabs $0xdf8475800,%rdx
   12191:	00 00 00 
   12194:	b8 01 00 00 00       	mov    $0x1,%eax
   12199:	e9 69 01 00 00       	jmp    12307 <fwp_fmt_duration+0x497>
   1219e:	44 89 d2             	mov    %r10d,%edx
   121a1:	83 e2 1f             	and    $0x1f,%edx
   121a4:	48 89 c1             	mov    %rax,%rcx
   121a7:	48 29 d1             	sub    %rdx,%rcx
   121aa:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
   121af:	66 0f ef c0          	pxor   %xmm0,%xmm0
   121b3:	49 89 c0             	mov    %rax,%r8
   121b6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   121bd:	00 00 00 
   121c0:	f3 42 0f 6f 4c 04 20 	movdqu 0x20(%rsp,%r8,1),%xmm1
   121c7:	f3 42 0f 6f 54 04 30 	movdqu 0x30(%rsp,%r8,1),%xmm2
   121ce:	66 0f 6f da          	movdqa %xmm2,%xmm3
   121d2:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   121d6:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   121db:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   121e0:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   121e5:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   121e9:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   121ee:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   121f3:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   121f8:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   121fc:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   12200:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12204:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12209:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   1220e:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12213:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   12217:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   1221c:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12221:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12226:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   1222a:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
   1222f:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
   12233:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
   12237:	48 83 c6 20          	add    $0x20,%rsi
   1223b:	4c 39 c2             	cmp    %r8,%rdx
   1223e:	75 80                	jne    121c0 <fwp_fmt_duration+0x350>
   12240:	48 85 d2             	test   %rdx,%rdx
   12243:	74 7d                	je     122c2 <fwp_fmt_duration+0x452>
   12245:	83 fa 08             	cmp    $0x8,%edx
   12248:	72 5a                	jb     122a4 <fwp_fmt_duration+0x434>
   1224a:	44 89 d2             	mov    %r10d,%edx
   1224d:	83 e2 07             	and    $0x7,%edx
   12250:	48 89 c6             	mov    %rax,%rsi
   12253:	48 29 ce             	sub    %rcx,%rsi
   12256:	4c 8d 04 0c          	lea    (%rsp,%rcx,1),%r8
   1225a:	48 89 c1             	mov    %rax,%rcx
   1225d:	48 29 d1             	sub    %rdx,%rcx
   12260:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12264:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
   1226b:	00 00 00 00 00 
   12270:	f3 0f 7e 4c 34 38    	movq   0x38(%rsp,%rsi,1),%xmm1
   12276:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   1227a:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   1227f:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12284:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12289:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   1228d:	66 41 0f d6 08       	movq   %xmm1,(%r8)
   12292:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
   12296:	49 83 c0 08          	add    $0x8,%r8
   1229a:	48 39 f2             	cmp    %rsi,%rdx
   1229d:	75 d1                	jne    12270 <fwp_fmt_duration+0x400>
   1229f:	48 85 d2             	test   %rdx,%rdx
   122a2:	74 1e                	je     122c2 <fwp_fmt_duration+0x452>
   122a4:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
   122a9:	48 01 f2             	add    %rsi,%rdx
   122ac:	48 ff ca             	dec    %rdx
   122af:	90                   	nop
   122b0:	0f b6 32             	movzbl (%rdx),%esi
   122b3:	40 88 34 0c          	mov    %sil,(%rsp,%rcx,1)
   122b7:	48 ff c1             	inc    %rcx
   122ba:	48 ff ca             	dec    %rdx
   122bd:	48 39 c8             	cmp    %rcx,%rax
   122c0:	75 ee                	jne    122b0 <fwp_fmt_duration+0x440>
   122c2:	c6 04 04 00          	movb   $0x0,(%rsp,%rax,1)
   122c6:	48 8d 35 ad 34 00 00 	lea    0x34ad(%rip),%rsi        # 1577a <exec_in_fp0+0xf6a>
   122cd:	48 89 e2             	mov    %rsp,%rdx
   122d0:	31 c0                	xor    %eax,%eax
   122d2:	e8 79 11 ff ff       	call   3450 <sprintf@plt>
   122d7:	e9 a1 04 00 00       	jmp    1277d <fwp_fmt_duration+0x90d>
   122dc:	49 89 fe             	mov    %rdi,%r14
   122df:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
   122e4:	b8 02 00 00 00       	mov    $0x2,%eax
   122e9:	eb 1c                	jmp    12307 <fwp_fmt_duration+0x497>
   122eb:	49 89 fe             	mov    %rdi,%r14
   122ee:	ba 40 42 0f 00       	mov    $0xf4240,%edx
   122f3:	b8 03 00 00 00       	mov    $0x3,%eax
   122f8:	eb 0d                	jmp    12307 <fwp_fmt_duration+0x497>
   122fa:	49 89 fe             	mov    %rdi,%r14
   122fd:	ba e8 03 00 00       	mov    $0x3e8,%edx
   12302:	b8 04 00 00 00       	mov    $0x4,%eax
   12307:	31 c9                	xor    %ecx,%ecx
   12309:	c1 e0 04             	shl    $0x4,%eax
   1230c:	48 8d 1d ed 69 00 00 	lea    0x69ed(%rip),%rbx        # 18d00 <fwp_fmt_duration.units>
   12313:	48 01 c3             	add    %rax,%rbx
   12316:	48 89 f7             	mov    %rsi,%rdi
   12319:	4c 89 c6             	mov    %r8,%rsi
   1231c:	e8 ef 0e 00 00       	call   13210 <__divti3>
   12321:	48 89 c1             	mov    %rax,%rcx
   12324:	48 89 d6             	mov    %rdx,%rsi
   12327:	48 85 d2             	test   %rdx,%rdx
   1232a:	0f 88 b0 00 00 00    	js     123e0 <fwp_fmt_duration+0x570>
   12330:	48 89 c8             	mov    %rcx,%rax
   12333:	48 09 f0             	or     %rsi,%rax
   12336:	0f 84 61 01 00 00    	je     1249d <fwp_fmt_duration+0x62d>
   1233c:	45 31 d2             	xor    %r10d,%r10d
   1233f:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
   12346:	cc cc cc 
   12349:	49 bf cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r15
   12350:	cc cc cc 
   12353:	49 89 f4             	mov    %rsi,%r12
   12356:	4c 89 f7             	mov    %r14,%rdi
   12359:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   12360:	49 89 f0             	mov    %rsi,%r8
   12363:	49 0f a4 c8 3f       	shld   $0x3f,%rcx,%r8
   12368:	49 d1 ec             	shr    $1,%r12
   1236b:	4d 89 c1             	mov    %r8,%r9
   1236e:	4d 01 e1             	add    %r12,%r9
   12371:	49 83 d1 00          	adc    $0x0,%r9
   12375:	4c 89 c8             	mov    %r9,%rax
   12378:	49 f7 e3             	mul    %r11
   1237b:	48 c1 ea 02          	shr    $0x2,%rdx
   1237f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   12383:	49 29 c1             	sub    %rax,%r9
   12386:	4d 29 c8             	sub    %r9,%r8
   12389:	49 83 dc 00          	sbb    $0x0,%r12
   1238d:	4d 89 c1             	mov    %r8,%r9
   12390:	4d 0f af cf          	imul   %r15,%r9
   12394:	4c 89 c0             	mov    %r8,%rax
   12397:	49 f7 e3             	mul    %r11
   1239a:	4c 01 ca             	add    %r9,%rdx
   1239d:	4d 0f af e3          	imul   %r11,%r12
   123a1:	49 01 d4             	add    %rdx,%r12
   123a4:	48 89 c2             	mov    %rax,%rdx
   123a7:	48 01 c2             	add    %rax,%rdx
   123aa:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
   123ae:	41 89 c8             	mov    %ecx,%r8d
   123b1:	41 29 d0             	sub    %edx,%r8d
   123b4:	41 80 c8 30          	or     $0x30,%r8b
   123b8:	46 88 44 14 40       	mov    %r8b,0x40(%rsp,%r10,1)
   123bd:	49 ff c2             	inc    %r10
   123c0:	48 83 f9 0a          	cmp    $0xa,%rcx
   123c4:	48 83 de 00          	sbb    $0x0,%rsi
   123c8:	48 89 c1             	mov    %rax,%rcx
   123cb:	4c 89 e6             	mov    %r12,%rsi
   123ce:	73 90                	jae    12360 <fwp_fmt_duration+0x4f0>
   123d0:	45 85 d2             	test   %r10d,%r10d
   123d3:	0f 8f d2 00 00 00    	jg     124ab <fwp_fmt_duration+0x63b>
   123d9:	31 c0                	xor    %eax,%eax
   123db:	e9 12 02 00 00       	jmp    125f2 <fwp_fmt_duration+0x782>
   123e0:	45 31 c0             	xor    %r8d,%r8d
   123e3:	48 f7 d9             	neg    %rcx
   123e6:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   123ec:	49 19 f1             	sbb    %rsi,%r9
   123ef:	c6 04 24 2d          	movb   $0x2d,(%rsp)
   123f3:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
   123fa:	cc cc cc 
   123fd:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
   12404:	cc cc cc 
   12407:	4d 89 cf             	mov    %r9,%r15
   1240a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   12410:	4c 89 ce             	mov    %r9,%rsi
   12413:	48 0f a4 ce 3f       	shld   $0x3f,%rcx,%rsi
   12418:	49 d1 ef             	shr    $1,%r15
   1241b:	48 89 f7             	mov    %rsi,%rdi
   1241e:	4c 01 ff             	add    %r15,%rdi
   12421:	48 83 d7 00          	adc    $0x0,%rdi
   12425:	48 89 f8             	mov    %rdi,%rax
   12428:	49 f7 e2             	mul    %r10
   1242b:	48 c1 ea 02          	shr    $0x2,%rdx
   1242f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   12433:	48 29 c7             	sub    %rax,%rdi
   12436:	48 29 fe             	sub    %rdi,%rsi
   12439:	49 83 df 00          	sbb    $0x0,%r15
   1243d:	48 89 f7             	mov    %rsi,%rdi
   12440:	49 0f af fb          	imul   %r11,%rdi
   12444:	48 89 f0             	mov    %rsi,%rax
   12447:	49 f7 e2             	mul    %r10
   1244a:	48 01 fa             	add    %rdi,%rdx
   1244d:	4d 0f af fa          	imul   %r10,%r15
   12451:	49 01 d7             	add    %rdx,%r15
   12454:	48 89 c2             	mov    %rax,%rdx
   12457:	48 01 c2             	add    %rax,%rdx
   1245a:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
   1245e:	89 ce                	mov    %ecx,%esi
   12460:	29 d6                	sub    %edx,%esi
   12462:	40 80 ce 30          	or     $0x30,%sil
   12466:	42 88 74 04 40       	mov    %sil,0x40(%rsp,%r8,1)
   1246b:	49 ff c0             	inc    %r8
   1246e:	48 83 f9 0a          	cmp    $0xa,%rcx
   12472:	49 83 d9 00          	sbb    $0x0,%r9
   12476:	48 89 c1             	mov    %rax,%rcx
   12479:	4d 89 f9             	mov    %r15,%r9
   1247c:	73 92                	jae    12410 <fwp_fmt_duration+0x5a0>
   1247e:	45 85 c0             	test   %r8d,%r8d
   12481:	4c 89 f7             	mov    %r14,%rdi
   12484:	7e 44                	jle    124ca <fwp_fmt_duration+0x65a>
   12486:	44 89 c0             	mov    %r8d,%eax
   12489:	48 83 f8 08          	cmp    $0x8,%rax
   1248d:	0f 83 68 01 00 00    	jae    125fb <fwp_fmt_duration+0x78b>
   12493:	31 c9                	xor    %ecx,%ecx
   12495:	48 89 c2             	mov    %rax,%rdx
   12498:	e9 97 02 00 00       	jmp    12734 <fwp_fmt_duration+0x8c4>
   1249d:	c6 44 24 40 30       	movb   $0x30,0x40(%rsp)
   124a2:	41 ba 01 00 00 00    	mov    $0x1,%r10d
   124a8:	4c 89 f7             	mov    %r14,%rdi
   124ab:	44 89 d0             	mov    %r10d,%eax
   124ae:	48 83 f8 08          	cmp    $0x8,%rax
   124b2:	73 0a                	jae    124be <fwp_fmt_duration+0x64e>
   124b4:	31 c9                	xor    %ecx,%ecx
   124b6:	48 89 c2             	mov    %rax,%rdx
   124b9:	e9 16 01 00 00       	jmp    125d4 <fwp_fmt_duration+0x764>
   124be:	83 f8 20             	cmp    $0x20,%eax
   124c1:	73 0e                	jae    124d1 <fwp_fmt_duration+0x661>
   124c3:	31 c9                	xor    %ecx,%ecx
   124c5:	e9 b0 00 00 00       	jmp    1257a <fwp_fmt_duration+0x70a>
   124ca:	31 c0                	xor    %eax,%eax
   124cc:	e9 93 02 00 00       	jmp    12764 <fwp_fmt_duration+0x8f4>
   124d1:	44 89 d2             	mov    %r10d,%edx
   124d4:	83 e2 1f             	and    $0x1f,%edx
   124d7:	48 89 c1             	mov    %rax,%rcx
   124da:	48 29 d1             	sub    %rdx,%rcx
   124dd:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
   124e2:	66 0f ef c0          	pxor   %xmm0,%xmm0
   124e6:	49 89 c0             	mov    %rax,%r8
   124e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   124f0:	f3 42 0f 6f 4c 04 20 	movdqu 0x20(%rsp,%r8,1),%xmm1
   124f7:	f3 42 0f 6f 54 04 30 	movdqu 0x30(%rsp,%r8,1),%xmm2
   124fe:	66 0f 6f da          	movdqa %xmm2,%xmm3
   12502:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12506:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   1250b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   12510:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12515:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   12519:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   1251e:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   12523:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   12528:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   1252c:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   12530:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12534:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12539:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   1253e:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12543:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   12547:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   1254c:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12551:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12556:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   1255a:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
   1255f:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
   12563:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
   12567:	48 83 c6 20          	add    $0x20,%rsi
   1256b:	4c 39 c2             	cmp    %r8,%rdx
   1256e:	75 80                	jne    124f0 <fwp_fmt_duration+0x680>
   12570:	48 85 d2             	test   %rdx,%rdx
   12573:	74 7d                	je     125f2 <fwp_fmt_duration+0x782>
   12575:	83 fa 08             	cmp    $0x8,%edx
   12578:	72 5a                	jb     125d4 <fwp_fmt_duration+0x764>
   1257a:	44 89 d2             	mov    %r10d,%edx
   1257d:	83 e2 07             	and    $0x7,%edx
   12580:	48 89 c6             	mov    %rax,%rsi
   12583:	48 29 ce             	sub    %rcx,%rsi
   12586:	4c 8d 04 0c          	lea    (%rsp,%rcx,1),%r8
   1258a:	48 89 c1             	mov    %rax,%rcx
   1258d:	48 29 d1             	sub    %rdx,%rcx
   12590:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12594:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
   1259b:	00 00 00 00 00 
   125a0:	f3 0f 7e 4c 34 38    	movq   0x38(%rsp,%rsi,1),%xmm1
   125a6:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   125aa:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   125af:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   125b4:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   125b9:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   125bd:	66 41 0f d6 08       	movq   %xmm1,(%r8)
   125c2:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
   125c6:	49 83 c0 08          	add    $0x8,%r8
   125ca:	48 39 f2             	cmp    %rsi,%rdx
   125cd:	75 d1                	jne    125a0 <fwp_fmt_duration+0x730>
   125cf:	48 85 d2             	test   %rdx,%rdx
   125d2:	74 1e                	je     125f2 <fwp_fmt_duration+0x782>
   125d4:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
   125d9:	48 01 f2             	add    %rsi,%rdx
   125dc:	48 ff ca             	dec    %rdx
   125df:	90                   	nop
   125e0:	0f b6 32             	movzbl (%rdx),%esi
   125e3:	40 88 34 0c          	mov    %sil,(%rsp,%rcx,1)
   125e7:	48 ff c1             	inc    %rcx
   125ea:	48 ff ca             	dec    %rdx
   125ed:	48 39 c8             	cmp    %rcx,%rax
   125f0:	75 ee                	jne    125e0 <fwp_fmt_duration+0x770>
   125f2:	c6 04 04 00          	movb   $0x0,(%rsp,%rax,1)
   125f6:	e9 6e 01 00 00       	jmp    12769 <fwp_fmt_duration+0x8f9>
   125fb:	83 f8 20             	cmp    $0x20,%eax
   125fe:	73 07                	jae    12607 <fwp_fmt_duration+0x797>
   12600:	31 c9                	xor    %ecx,%ecx
   12602:	e9 bd 00 00 00       	jmp    126c4 <fwp_fmt_duration+0x854>
   12607:	44 89 c6             	mov    %r8d,%esi
   1260a:	44 89 c2             	mov    %r8d,%edx
   1260d:	83 e2 1f             	and    $0x1f,%edx
   12610:	48 89 c1             	mov    %rax,%rcx
   12613:	48 29 d1             	sub    %rdx,%rcx
   12616:	4c 8d 0c 34          	lea    (%rsp,%rsi,1),%r9
   1261a:	49 83 c1 30          	add    $0x30,%r9
   1261e:	48 29 d6             	sub    %rdx,%rsi
   12621:	45 31 d2             	xor    %r10d,%r10d
   12624:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12628:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   1262f:	00 
   12630:	f3 41 0f 6f 49 f0    	movdqu -0x10(%r9),%xmm1
   12636:	f3 41 0f 6f 11       	movdqu (%r9),%xmm2
   1263b:	66 0f 6f da          	movdqa %xmm2,%xmm3
   1263f:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12643:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12648:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   1264d:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12652:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   12656:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   1265b:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   12660:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   12665:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   12669:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   1266d:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   12671:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12676:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   1267b:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   12680:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   12684:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   12689:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   1268e:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12693:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   12697:	f3 42 0f 7f 54 14 01 	movdqu %xmm2,0x1(%rsp,%r10,1)
   1269e:	f3 42 0f 7f 4c 14 11 	movdqu %xmm1,0x11(%rsp,%r10,1)
   126a5:	49 83 c2 20          	add    $0x20,%r10
   126a9:	49 83 c1 e0          	add    $0xffffffffffffffe0,%r9
   126ad:	4c 39 d6             	cmp    %r10,%rsi
   126b0:	0f 85 7a ff ff ff    	jne    12630 <fwp_fmt_duration+0x7c0>
   126b6:	48 85 d2             	test   %rdx,%rdx
   126b9:	0f 84 a5 00 00 00    	je     12764 <fwp_fmt_duration+0x8f4>
   126bf:	83 fa 08             	cmp    $0x8,%edx
   126c2:	72 70                	jb     12734 <fwp_fmt_duration+0x8c4>
   126c4:	48 89 ce             	mov    %rcx,%rsi
   126c7:	45 89 c1             	mov    %r8d,%r9d
   126ca:	44 89 c2             	mov    %r8d,%edx
   126cd:	83 e2 07             	and    $0x7,%edx
   126d0:	48 89 c1             	mov    %rax,%rcx
   126d3:	48 29 d1             	sub    %rdx,%rcx
   126d6:	49 89 f2             	mov    %rsi,%r10
   126d9:	49 f7 da             	neg    %r10
   126dc:	49 01 e2             	add    %rsp,%r10
   126df:	49 83 c2 40          	add    $0x40,%r10
   126e3:	4d 01 ca             	add    %r9,%r10
   126e6:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
   126ea:	49 29 d1             	sub    %rdx,%r9
   126ed:	66 0f ef c0          	pxor   %xmm0,%xmm0
   126f1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   126f8:	0f 1f 84 00 00 00 00 
   126ff:	00 
   12700:	f3 41 0f 7e 0a       	movq   (%r10),%xmm1
   12705:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   12709:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   1270e:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   12713:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12718:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   1271c:	66 0f d6 4c 34 01    	movq   %xmm1,0x1(%rsp,%rsi,1)
   12722:	48 83 c6 08          	add    $0x8,%rsi
   12726:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
   1272a:	49 39 f1             	cmp    %rsi,%r9
   1272d:	75 d1                	jne    12700 <fwp_fmt_duration+0x890>
   1272f:	48 85 d2             	test   %rdx,%rdx
   12732:	74 30                	je     12764 <fwp_fmt_duration+0x8f4>
   12734:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
   12739:	48 01 f2             	add    %rsi,%rdx
   1273c:	48 ff ca             	dec    %rdx
   1273f:	44 89 c6             	mov    %r8d,%esi
   12742:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   12749:	1f 84 00 00 00 00 00 
   12750:	44 0f b6 02          	movzbl (%rdx),%r8d
   12754:	44 88 44 0c 01       	mov    %r8b,0x1(%rsp,%rcx,1)
   12759:	48 ff c1             	inc    %rcx
   1275c:	48 ff ca             	dec    %rdx
   1275f:	48 39 ce             	cmp    %rcx,%rsi
   12762:	75 ec                	jne    12750 <fwp_fmt_duration+0x8e0>
   12764:	c6 44 04 01 00       	movb   $0x0,0x1(%rsp,%rax,1)
   12769:	48 8b 0b             	mov    (%rbx),%rcx
   1276c:	48 8d 35 02 30 00 00 	lea    0x3002(%rip),%rsi        # 15775 <exec_in_fp0+0xf65>
   12773:	48 89 e2             	mov    %rsp,%rdx
   12776:	31 c0                	xor    %eax,%eax
   12778:	e8 d3 0c ff ff       	call   3450 <sprintf@plt>
   1277d:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
   12784:	5b                   	pop    %rbx
   12785:	41 5c                	pop    %r12
   12787:	41 5e                	pop    %r14
   12789:	41 5f                	pop    %r15
   1278b:	c3                   	ret
   1278c:	45 31 c9             	xor    %r9d,%r9d
   1278f:	48 f7 de             	neg    %rsi
   12792:	41 ba 00 00 00 00    	mov    $0x0,%r10d
   12798:	4d 19 c2             	sbb    %r8,%r10
   1279b:	c6 04 24 2d          	movb   $0x2d,(%rsp)
   1279f:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
   127a6:	cc cc cc 
   127a9:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
   127b0:	cc cc cc 
   127b3:	4d 89 d6             	mov    %r10,%r14
   127b6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   127bd:	00 00 00 
   127c0:	4c 89 d1             	mov    %r10,%rcx
   127c3:	48 0f a4 f1 3f       	shld   $0x3f,%rsi,%rcx
   127c8:	49 d1 ee             	shr    $1,%r14
   127cb:	49 89 c8             	mov    %rcx,%r8
   127ce:	4d 01 f0             	add    %r14,%r8
   127d1:	49 83 d0 00          	adc    $0x0,%r8
   127d5:	4c 89 c0             	mov    %r8,%rax
   127d8:	49 f7 e3             	mul    %r11
   127db:	48 c1 ea 02          	shr    $0x2,%rdx
   127df:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   127e3:	49 29 c0             	sub    %rax,%r8
   127e6:	4c 29 c1             	sub    %r8,%rcx
   127e9:	49 83 de 00          	sbb    $0x0,%r14
   127ed:	49 89 c8             	mov    %rcx,%r8
   127f0:	4c 0f af c3          	imul   %rbx,%r8
   127f4:	48 89 c8             	mov    %rcx,%rax
   127f7:	49 f7 e3             	mul    %r11
   127fa:	4c 01 c2             	add    %r8,%rdx
   127fd:	4d 0f af f3          	imul   %r11,%r14
   12801:	49 01 d6             	add    %rdx,%r14
   12804:	48 89 c1             	mov    %rax,%rcx
   12807:	48 01 c1             	add    %rax,%rcx
   1280a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
   1280e:	89 f2                	mov    %esi,%edx
   12810:	29 ca                	sub    %ecx,%edx
   12812:	80 ca 30             	or     $0x30,%dl
   12815:	42 88 54 0c 40       	mov    %dl,0x40(%rsp,%r9,1)
   1281a:	49 ff c1             	inc    %r9
   1281d:	48 83 fe 0a          	cmp    $0xa,%rsi
   12821:	49 83 da 00          	sbb    $0x0,%r10
   12825:	48 89 c6             	mov    %rax,%rsi
   12828:	4d 89 f2             	mov    %r14,%r10
   1282b:	73 93                	jae    127c0 <fwp_fmt_duration+0x950>
   1282d:	45 85 c9             	test   %r9d,%r9d
   12830:	7e 13                	jle    12845 <fwp_fmt_duration+0x9d5>
   12832:	44 89 c8             	mov    %r9d,%eax
   12835:	48 83 f8 08          	cmp    $0x8,%rax
   12839:	73 11                	jae    1284c <fwp_fmt_duration+0x9dc>
   1283b:	31 c9                	xor    %ecx,%ecx
   1283d:	48 89 c2             	mov    %rax,%rdx
   12840:	e9 29 01 00 00       	jmp    1296e <fwp_fmt_duration+0xafe>
   12845:	31 c0                	xor    %eax,%eax
   12847:	e9 48 01 00 00       	jmp    12994 <fwp_fmt_duration+0xb24>
   1284c:	83 f8 20             	cmp    $0x20,%eax
   1284f:	73 07                	jae    12858 <fwp_fmt_duration+0x9e8>
   12851:	31 c9                	xor    %ecx,%ecx
   12853:	e9 b5 00 00 00       	jmp    1290d <fwp_fmt_duration+0xa9d>
   12858:	44 89 ce             	mov    %r9d,%esi
   1285b:	44 89 ca             	mov    %r9d,%edx
   1285e:	83 e2 1f             	and    $0x1f,%edx
   12861:	48 89 c1             	mov    %rax,%rcx
   12864:	48 29 d1             	sub    %rdx,%rcx
   12867:	4c 8d 04 34          	lea    (%rsp,%rsi,1),%r8
   1286b:	49 83 c0 30          	add    $0x30,%r8
   1286f:	48 29 d6             	sub    %rdx,%rsi
   12872:	45 31 d2             	xor    %r10d,%r10d
   12875:	66 0f ef c0          	pxor   %xmm0,%xmm0
   12879:	f3 41 0f 6f 48 f0    	movdqu -0x10(%r8),%xmm1
   1287f:	f3 41 0f 6f 10       	movdqu (%r8),%xmm2
   12884:	66 0f 6f da          	movdqa %xmm2,%xmm3
   12888:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   1288c:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   12891:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   12896:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   1289b:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
   1289f:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
   128a4:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
   128a9:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
   128ae:	66 0f 67 d3          	packuswb %xmm3,%xmm2
   128b2:	66 0f 6f d9          	movdqa %xmm1,%xmm3
   128b6:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
   128ba:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
   128bf:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
   128c4:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
   128c9:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
   128cd:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   128d2:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   128d7:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   128dc:	66 0f 67 cb          	packuswb %xmm3,%xmm1
   128e0:	f3 42 0f 7f 54 14 01 	movdqu %xmm2,0x1(%rsp,%r10,1)
   128e7:	f3 42 0f 7f 4c 14 11 	movdqu %xmm1,0x11(%rsp,%r10,1)
   128ee:	49 83 c2 20          	add    $0x20,%r10
   128f2:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
   128f6:	4c 39 d6             	cmp    %r10,%rsi
   128f9:	0f 85 7a ff ff ff    	jne    12879 <fwp_fmt_duration+0xa09>
   128ff:	48 85 d2             	test   %rdx,%rdx
   12902:	0f 84 8c 00 00 00    	je     12994 <fwp_fmt_duration+0xb24>
   12908:	83 fa 08             	cmp    $0x8,%edx
   1290b:	72 61                	jb     1296e <fwp_fmt_duration+0xafe>
   1290d:	48 89 ce             	mov    %rcx,%rsi
   12910:	45 89 c8             	mov    %r9d,%r8d
   12913:	44 89 ca             	mov    %r9d,%edx
   12916:	83 e2 07             	and    $0x7,%edx
   12919:	48 89 c1             	mov    %rax,%rcx
   1291c:	48 29 d1             	sub    %rdx,%rcx
   1291f:	49 89 f2             	mov    %rsi,%r10
   12922:	49 f7 da             	neg    %r10
   12925:	49 01 e2             	add    %rsp,%r10
   12928:	49 83 c2 40          	add    $0x40,%r10
   1292c:	4d 01 c2             	add    %r8,%r10
   1292f:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
   12933:	49 29 d0             	sub    %rdx,%r8
   12936:	66 0f ef c0          	pxor   %xmm0,%xmm0
   1293a:	f3 41 0f 7e 0a       	movq   (%r10),%xmm1
   1293f:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
   12943:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
   12948:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
   1294d:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
   12952:	66 0f 67 c9          	packuswb %xmm1,%xmm1
   12956:	66 0f d6 4c 34 01    	movq   %xmm1,0x1(%rsp,%rsi,1)
   1295c:	48 83 c6 08          	add    $0x8,%rsi
   12960:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
   12964:	49 39 f0             	cmp    %rsi,%r8
   12967:	75 d1                	jne    1293a <fwp_fmt_duration+0xaca>
   12969:	48 85 d2             	test   %rdx,%rdx
   1296c:	74 26                	je     12994 <fwp_fmt_duration+0xb24>
   1296e:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
   12973:	48 01 f2             	add    %rsi,%rdx
   12976:	48 ff ca             	dec    %rdx
   12979:	44 89 ce             	mov    %r9d,%esi
   1297c:	0f 1f 40 00          	nopl   0x0(%rax)
   12980:	44 0f b6 02          	movzbl (%rdx),%r8d
   12984:	44 88 44 0c 01       	mov    %r8b,0x1(%rsp,%rcx,1)
   12989:	48 ff c1             	inc    %rcx
   1298c:	48 ff ca             	dec    %rdx
   1298f:	48 39 ce             	cmp    %rcx,%rsi
   12992:	75 ec                	jne    12980 <fwp_fmt_duration+0xb10>
   12994:	c6 44 04 01 00       	movb   $0x0,0x1(%rsp,%rax,1)
   12999:	e9 28 f9 ff ff       	jmp    122c6 <fwp_fmt_duration+0x456>
   1299e:	66 90                	xchg   %ax,%ax

00000000000129a0 <fwp_format_g>:
   129a0:	55                   	push   %rbp
   129a1:	41 57                	push   %r15
   129a3:	41 56                	push   %r14
   129a5:	41 55                	push   %r13
   129a7:	41 54                	push   %r12
   129a9:	53                   	push   %rbx
   129aa:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   129b1:	89 f5                	mov    %esi,%ebp
   129b3:	48 89 fb             	mov    %rdi,%rbx
   129b6:	ff cd                	dec    %ebp
   129b8:	48 8d 15 89 2d 00 00 	lea    0x2d89(%rip),%rdx        # 15748 <exec_in_fp0+0xf38>
   129bf:	4c 8d 64 24 50       	lea    0x50(%rsp),%r12
   129c4:	be 40 00 00 00       	mov    $0x40,%esi
   129c9:	4c 89 e7             	mov    %r12,%rdi
   129cc:	89 e9                	mov    %ebp,%ecx
   129ce:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
   129d4:	b0 01                	mov    $0x1,%al
   129d6:	e8 f5 07 ff ff       	call   31d0 <snprintf@plt>
   129db:	4c 89 e7             	mov    %r12,%rdi
   129de:	be 65 00 00 00       	mov    $0x65,%esi
   129e3:	e8 c8 07 ff ff       	call   31b0 <strchr@plt>
   129e8:	49 89 c7             	mov    %rax,%r15
   129eb:	48 8d 78 01          	lea    0x1(%rax),%rdi
   129ef:	45 31 ed             	xor    %r13d,%r13d
   129f2:	31 f6                	xor    %esi,%esi
   129f4:	ba 0a 00 00 00       	mov    $0xa,%edx
   129f9:	e8 22 09 ff ff       	call   3320 <strtol@plt>
   129fe:	49 89 c6             	mov    %rax,%r14
   12a01:	83 c0 ef             	add    $0xffffffef,%eax
   12a04:	83 f8 e9             	cmp    $0xffffffe9,%eax
   12a07:	77 5f                	ja     12a68 <fwp_format_g+0xc8>
   12a09:	4d 29 e7             	sub    %r12,%r15
   12a0c:	4c 8d 6c 24 10       	lea    0x10(%rsp),%r13
   12a11:	4c 89 ef             	mov    %r13,%rdi
   12a14:	4c 89 e6             	mov    %r12,%rsi
   12a17:	4c 89 fa             	mov    %r15,%rdx
   12a1a:	e8 11 09 ff ff       	call   3330 <memcpy@plt>
   12a1f:	42 c6 44 3c 10 00    	movb   $0x0,0x10(%rsp,%r15,1)
   12a25:	4c 89 ef             	mov    %r13,%rdi
   12a28:	be 2e 00 00 00       	mov    $0x2e,%esi
   12a2d:	e8 7e 07 ff ff       	call   31b0 <strchr@plt>
   12a32:	48 85 c0             	test   %rax,%rax
   12a35:	0f 84 a8 00 00 00    	je     12ae3 <fwp_format_g+0x143>
   12a3b:	4d 85 ff             	test   %r15,%r15
   12a3e:	0f 84 9f 00 00 00    	je     12ae3 <fwp_format_g+0x143>
   12a44:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
   12a4b:	00 00 00 00 00 
   12a50:	42 0f b6 44 3c 0f    	movzbl 0xf(%rsp,%r15,1),%eax
   12a56:	83 f8 30             	cmp    $0x30,%eax
   12a59:	75 7d                	jne    12ad8 <fwp_format_g+0x138>
   12a5b:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
   12a61:	49 ff cf             	dec    %r15
   12a64:	75 ea                	jne    12a50 <fwp_format_g+0xb0>
   12a66:	eb 7b                	jmp    12ae3 <fwp_format_g+0x143>
   12a68:	44 29 f5             	sub    %r14d,%ebp
   12a6b:	85 ed                	test   %ebp,%ebp
   12a6d:	44 0f 4f ed          	cmovg  %ebp,%r13d
   12a71:	48 8d 15 df 2c 00 00 	lea    0x2cdf(%rip),%rdx        # 15757 <exec_in_fp0+0xf47>
   12a78:	be 90 01 00 00       	mov    $0x190,%esi
   12a7d:	48 89 df             	mov    %rbx,%rdi
   12a80:	44 89 e9             	mov    %r13d,%ecx
   12a83:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
   12a89:	b0 01                	mov    $0x1,%al
   12a8b:	e8 40 07 ff ff       	call   31d0 <snprintf@plt>
   12a90:	48 89 df             	mov    %rbx,%rdi
   12a93:	e8 d8 06 ff ff       	call   3170 <strlen@plt>
   12a98:	49 89 c6             	mov    %rax,%r14
   12a9b:	48 89 df             	mov    %rbx,%rdi
   12a9e:	be 2e 00 00 00       	mov    $0x2e,%esi
   12aa3:	e8 08 07 ff ff       	call   31b0 <strchr@plt>
   12aa8:	48 85 c0             	test   %rax,%rax
   12aab:	74 69                	je     12b16 <fwp_format_g+0x176>
   12aad:	4d 85 f6             	test   %r14,%r14
   12ab0:	74 64                	je     12b16 <fwp_format_g+0x176>
   12ab2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   12ab9:	1f 84 00 00 00 00 00 
   12ac0:	42 0f b6 44 33 ff    	movzbl -0x1(%rbx,%r14,1),%eax
   12ac6:	83 f8 30             	cmp    $0x30,%eax
   12ac9:	75 5d                	jne    12b28 <fwp_format_g+0x188>
   12acb:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
   12ad1:	49 ff ce             	dec    %r14
   12ad4:	75 ea                	jne    12ac0 <fwp_format_g+0x120>
   12ad6:	eb 3e                	jmp    12b16 <fwp_format_g+0x176>
   12ad8:	83 f8 2e             	cmp    $0x2e,%eax
   12adb:	75 06                	jne    12ae3 <fwp_format_g+0x143>
   12add:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
   12ae3:	44 89 f0             	mov    %r14d,%eax
   12ae6:	c1 e8 1f             	shr    $0x1f,%eax
   12ae9:	44 8d 04 45 2b 00 00 	lea    0x2b(,%rax,2),%r8d
   12af0:	00 
   12af1:	45 89 f1             	mov    %r14d,%r9d
   12af4:	41 f7 d9             	neg    %r9d
   12af7:	45 0f 48 ce          	cmovs  %r14d,%r9d
   12afb:	48 8d 15 4b 2c 00 00 	lea    0x2c4b(%rip),%rdx        # 1574d <exec_in_fp0+0xf3d>
   12b02:	48 8d 4c 24 10       	lea    0x10(%rsp),%rcx
   12b07:	be 90 01 00 00       	mov    $0x190,%esi
   12b0c:	48 89 df             	mov    %rbx,%rdi
   12b0f:	31 c0                	xor    %eax,%eax
   12b11:	e8 ba 06 ff ff       	call   31d0 <snprintf@plt>
   12b16:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
   12b1d:	5b                   	pop    %rbx
   12b1e:	41 5c                	pop    %r12
   12b20:	41 5d                	pop    %r13
   12b22:	41 5e                	pop    %r14
   12b24:	41 5f                	pop    %r15
   12b26:	5d                   	pop    %rbp
   12b27:	c3                   	ret
   12b28:	83 f8 2e             	cmp    $0x2e,%eax
   12b2b:	75 e9                	jne    12b16 <fwp_format_g+0x176>
   12b2d:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
   12b33:	eb e1                	jmp    12b16 <fwp_format_g+0x176>
   12b35:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   12b3c:	00 00 00 00 

0000000000012b40 <rd_leb>:
   12b40:	48 c7 06 00 00 00 00 	movq   $0x0,(%rsi)
   12b47:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   12b4b:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   12b4f:	75 03                	jne    12b54 <rd_leb+0x14>
   12b51:	31 c0                	xor    %eax,%eax
   12b53:	c3                   	ret
   12b54:	48 8b 0f             	mov    (%rdi),%rcx
   12b57:	48 8d 42 01          	lea    0x1(%rdx),%rax
   12b5b:	48 89 47 10          	mov    %rax,0x10(%rdi)
   12b5f:	0f b6 04 11          	movzbl (%rcx,%rdx,1),%eax
   12b63:	83 e0 7f             	and    $0x7f,%eax
   12b66:	48 09 06             	or     %rax,(%rsi)
   12b69:	b8 01 00 00 00       	mov    $0x1,%eax
   12b6e:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   12b72:	78 01                	js     12b75 <rd_leb+0x35>
   12b74:	c3                   	ret
   12b75:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   12b79:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   12b7d:	74 d2                	je     12b51 <rd_leb+0x11>
   12b7f:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   12b83:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   12b87:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   12b8c:	41 83 e0 7f          	and    $0x7f,%r8d
   12b90:	41 c1 e0 07          	shl    $0x7,%r8d
   12b94:	4c 09 06             	or     %r8,(%rsi)
   12b97:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   12b9b:	79 d7                	jns    12b74 <rd_leb+0x34>
   12b9d:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   12ba1:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   12ba5:	74 aa                	je     12b51 <rd_leb+0x11>
   12ba7:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   12bab:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   12baf:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   12bb4:	41 83 e0 7f          	and    $0x7f,%r8d
   12bb8:	41 c1 e0 0e          	shl    $0xe,%r8d
   12bbc:	4c 09 06             	or     %r8,(%rsi)
   12bbf:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   12bc3:	79 af                	jns    12b74 <rd_leb+0x34>
   12bc5:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   12bc9:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   12bcd:	74 82                	je     12b51 <rd_leb+0x11>
   12bcf:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   12bd3:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   12bd7:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   12bdc:	41 83 e0 7f          	and    $0x7f,%r8d
   12be0:	41 c1 e0 15          	shl    $0x15,%r8d
   12be4:	4c 09 06             	or     %r8,(%rsi)
   12be7:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   12beb:	79 87                	jns    12b74 <rd_leb+0x34>
   12bed:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   12bf1:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   12bf5:	0f 84 56 ff ff ff    	je     12b51 <rd_leb+0x11>
   12bfb:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   12bff:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   12c03:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   12c08:	41 83 e0 7f          	and    $0x7f,%r8d
   12c0c:	49 c1 e0 1c          	shl    $0x1c,%r8
   12c10:	4c 09 06             	or     %r8,(%rsi)
   12c13:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   12c17:	0f 89 57 ff ff ff    	jns    12b74 <rd_leb+0x34>
   12c1d:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   12c21:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   12c25:	0f 84 26 ff ff ff    	je     12b51 <rd_leb+0x11>
   12c2b:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   12c2f:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   12c33:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   12c38:	41 83 e0 7f          	and    $0x7f,%r8d
   12c3c:	49 c1 e0 23          	shl    $0x23,%r8
   12c40:	4c 09 06             	or     %r8,(%rsi)
   12c43:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   12c47:	0f 89 27 ff ff ff    	jns    12b74 <rd_leb+0x34>
   12c4d:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   12c51:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   12c55:	0f 84 f6 fe ff ff    	je     12b51 <rd_leb+0x11>
   12c5b:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   12c5f:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   12c63:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   12c68:	41 83 e0 7f          	and    $0x7f,%r8d
   12c6c:	49 c1 e0 2a          	shl    $0x2a,%r8
   12c70:	4c 09 06             	or     %r8,(%rsi)
   12c73:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   12c77:	0f 89 f7 fe ff ff    	jns    12b74 <rd_leb+0x34>
   12c7d:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   12c81:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   12c85:	0f 84 c6 fe ff ff    	je     12b51 <rd_leb+0x11>
   12c8b:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   12c8f:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   12c93:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   12c98:	41 83 e0 7f          	and    $0x7f,%r8d
   12c9c:	49 c1 e0 31          	shl    $0x31,%r8
   12ca0:	4c 09 06             	or     %r8,(%rsi)
   12ca3:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   12ca7:	0f 89 c7 fe ff ff    	jns    12b74 <rd_leb+0x34>
   12cad:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   12cb1:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   12cb5:	0f 84 96 fe ff ff    	je     12b51 <rd_leb+0x11>
   12cbb:	4c 8d 42 01          	lea    0x1(%rdx),%r8
   12cbf:	4c 89 47 10          	mov    %r8,0x10(%rdi)
   12cc3:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
   12cc8:	41 83 e0 7f          	and    $0x7f,%r8d
   12ccc:	49 c1 e0 38          	shl    $0x38,%r8
   12cd0:	4c 09 06             	or     %r8,(%rsi)
   12cd3:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   12cd7:	0f 89 97 fe ff ff    	jns    12b74 <rd_leb+0x34>
   12cdd:	48 8b 57 10          	mov    0x10(%rdi),%rdx
   12ce1:	48 39 57 08          	cmp    %rdx,0x8(%rdi)
   12ce5:	0f 84 66 fe ff ff    	je     12b51 <rd_leb+0x11>
   12ceb:	48 8d 42 01          	lea    0x1(%rdx),%rax
   12cef:	48 89 47 10          	mov    %rax,0x10(%rdi)
   12cf3:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
   12cf7:	b8 00 00 00 00       	mov    $0x0,%eax
   12cfc:	40 f6 c7 7e          	test   $0x7e,%dil
   12d00:	0f 85 6e fe ff ff    	jne    12b74 <rd_leb+0x34>
   12d06:	48 c1 e7 3f          	shl    $0x3f,%rdi
   12d0a:	48 09 3e             	or     %rdi,(%rsi)
   12d0d:	31 c0                	xor    %eax,%eax
   12d0f:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   12d13:	0f 99 c0             	setns  %al
   12d16:	c3                   	ret
   12d17:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   12d1e:	00 00 

0000000000012d20 <fwp_wire_empty_inner>:
   12d20:	31 c0                	xor    %eax,%eax
   12d22:	48 85 ff             	test   %rdi,%rdi
   12d25:	0f 84 a0 00 00 00    	je     12dcb <fwp_wire_empty_inner+0xab>
   12d2b:	83 3f 10             	cmpl   $0x10,(%rdi)
   12d2e:	0f 85 97 00 00 00    	jne    12dcb <fwp_wire_empty_inner+0xab>
   12d34:	41 57                	push   %r15
   12d36:	41 56                	push   %r14
   12d38:	41 54                	push   %r12
   12d3a:	53                   	push   %rbx
   12d3b:	48 83 ec 18          	sub    $0x18,%rsp
   12d3f:	48 85 f6             	test   %rsi,%rsi
   12d42:	74 1a                	je     12d5e <fwp_wire_empty_inner+0x3e>
   12d44:	48 89 f1             	mov    %rsi,%rcx
   12d47:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   12d4e:	00 00 
   12d50:	48 39 39             	cmp    %rdi,(%rcx)
   12d53:	74 6b                	je     12dc0 <fwp_wire_empty_inner+0xa0>
   12d55:	48 8b 49 08          	mov    0x8(%rcx),%rcx
   12d59:	48 85 c9             	test   %rcx,%rcx
   12d5c:	75 f2                	jne    12d50 <fwp_wire_empty_inner+0x30>
   12d5e:	48 89 7c 24 08       	mov    %rdi,0x8(%rsp)
   12d63:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
   12d68:	44 8b 77 10          	mov    0x10(%rdi),%r14d
   12d6c:	45 85 f6             	test   %r14d,%r14d
   12d6f:	7e 46                	jle    12db7 <fwp_wire_empty_inner+0x97>
   12d71:	4c 8b 7f 20          	mov    0x20(%rdi),%r15
   12d75:	49 8b 3f             	mov    (%r15),%rdi
   12d78:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
   12d7d:	e8 9e ff ff ff       	call   12d20 <fwp_wire_empty_inner>
   12d82:	85 c0                	test   %eax,%eax
   12d84:	74 38                	je     12dbe <fwp_wire_empty_inner+0x9e>
   12d86:	b9 01 00 00 00       	mov    $0x1,%ecx
   12d8b:	48 8d 5c 24 08       	lea    0x8(%rsp),%rbx
   12d90:	49 89 cc             	mov    %rcx,%r12
   12d93:	49 39 ce             	cmp    %rcx,%r14
   12d96:	74 15                	je     12dad <fwp_wire_empty_inner+0x8d>
   12d98:	4b 8b 3c e7          	mov    (%r15,%r12,8),%rdi
   12d9c:	48 89 de             	mov    %rbx,%rsi
   12d9f:	e8 7c ff ff ff       	call   12d20 <fwp_wire_empty_inner>
   12da4:	49 8d 4c 24 01       	lea    0x1(%r12),%rcx
   12da9:	85 c0                	test   %eax,%eax
   12dab:	75 e3                	jne    12d90 <fwp_wire_empty_inner+0x70>
   12dad:	31 c0                	xor    %eax,%eax
   12daf:	4d 39 f4             	cmp    %r14,%r12
   12db2:	0f 93 c0             	setae  %al
   12db5:	eb 09                	jmp    12dc0 <fwp_wire_empty_inner+0xa0>
   12db7:	b8 01 00 00 00       	mov    $0x1,%eax
   12dbc:	eb 02                	jmp    12dc0 <fwp_wire_empty_inner+0xa0>
   12dbe:	31 c0                	xor    %eax,%eax
   12dc0:	48 83 c4 18          	add    $0x18,%rsp
   12dc4:	5b                   	pop    %rbx
   12dc5:	41 5c                	pop    %r12
   12dc7:	41 5e                	pop    %r14
   12dc9:	41 5f                	pop    %r15
   12dcb:	c3                   	ret
   12dcc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000012dd0 <fwp_gc_find_data>:
   12dd0:	0f b7 77 18          	movzwl 0x18(%rdi),%esi
   12dd4:	48 85 f6             	test   %rsi,%rsi
   12dd7:	0f 84 be 00 00 00    	je     12e9b <fwp_gc_find_data+0xcb>
   12ddd:	53                   	push   %rbx
   12dde:	48 8b 07             	mov    (%rdi),%rax
   12de1:	4c 8b 47 10          	mov    0x10(%rdi),%r8
   12de5:	48 6b ce 38          	imul   $0x38,%rsi,%rcx
   12de9:	45 31 c9             	xor    %r9d,%r9d
   12dec:	48 8d 15 95 64 00 00 	lea    0x6495(%rip),%rdx        # 19288 <fwp_gc>
   12df3:	41 bb 01 00 00 00    	mov    $0x1,%r11d
   12df9:	45 31 d2             	xor    %r10d,%r10d
   12dfc:	eb 0b                	jmp    12e09 <fwp_gc_find_data+0x39>
   12dfe:	66 90                	xchg   %ax,%ax
   12e00:	49 83 c1 38          	add    $0x38,%r9
   12e04:	4c 39 c9             	cmp    %r9,%rcx
   12e07:	74 22                	je     12e2b <fwp_gc_find_data+0x5b>
   12e09:	43 83 3c 08 01       	cmpl   $0x1,(%r8,%r9,1)
   12e0e:	75 f0                	jne    12e00 <fwp_gc_find_data+0x30>
   12e10:	4b 8b 5c 08 10       	mov    0x10(%r8,%r9,1),%rbx
   12e15:	48 01 c3             	add    %rax,%rbx
   12e18:	48 39 d3             	cmp    %rdx,%rbx
   12e1b:	77 e3                	ja     12e00 <fwp_gc_find_data+0x30>
   12e1d:	4b 03 5c 08 28       	add    0x28(%r8,%r9,1),%rbx
   12e22:	48 39 d3             	cmp    %rdx,%rbx
   12e25:	45 0f 47 d3          	cmova  %r11d,%r10d
   12e29:	eb d5                	jmp    12e00 <fwp_gc_find_data+0x30>
   12e2b:	31 c0                	xor    %eax,%eax
   12e2d:	45 85 d2             	test   %r10d,%r10d
   12e30:	0f 95 c0             	setne  %al
   12e33:	74 6e                	je     12ea3 <fwp_gc_find_data+0xd3>
   12e35:	66 85 f6             	test   %si,%si
   12e38:	74 69                	je     12ea3 <fwp_gc_find_data+0xd3>
   12e3a:	8b 05 d8 75 00 00    	mov    0x75d8(%rip),%eax        # 1a418 <fwp_gc+0x1190>
   12e40:	48 8b 77 10          	mov    0x10(%rdi),%rsi
   12e44:	45 31 c0             	xor    %r8d,%r8d
   12e47:	eb 10                	jmp    12e59 <fwp_gc_find_data+0x89>
   12e49:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   12e50:	49 83 c0 38          	add    $0x38,%r8
   12e54:	4c 39 c1             	cmp    %r8,%rcx
   12e57:	74 45                	je     12e9e <fwp_gc_find_data+0xce>
   12e59:	42 83 3c 06 01       	cmpl   $0x1,(%rsi,%r8,1)
   12e5e:	75 f0                	jne    12e50 <fwp_gc_find_data+0x80>
   12e60:	42 f6 44 06 04 02    	testb  $0x2,0x4(%rsi,%r8,1)
   12e66:	74 e8                	je     12e50 <fwp_gc_find_data+0x80>
   12e68:	83 f8 10             	cmp    $0x10,%eax
   12e6b:	74 31                	je     12e9e <fwp_gc_find_data+0xce>
   12e6d:	4e 8b 4c 06 10       	mov    0x10(%rsi,%r8,1),%r9
   12e72:	4c 03 0f             	add    (%rdi),%r9
   12e75:	4c 63 d0             	movslq %eax,%r10
   12e78:	49 c1 e2 04          	shl    $0x4,%r10
   12e7c:	4d 89 8c 12 90 10 00 	mov    %r9,0x1090(%r10,%rdx,1)
   12e83:	00 
   12e84:	4e 8b 4c 06 28       	mov    0x28(%rsi,%r8,1),%r9
   12e89:	4d 89 8c 12 98 10 00 	mov    %r9,0x1098(%r10,%rdx,1)
   12e90:	00 
   12e91:	ff c0                	inc    %eax
   12e93:	89 05 7f 75 00 00    	mov    %eax,0x757f(%rip)        # 1a418 <fwp_gc+0x1190>
   12e99:	eb b5                	jmp    12e50 <fwp_gc_find_data+0x80>
   12e9b:	31 c0                	xor    %eax,%eax
   12e9d:	c3                   	ret
   12e9e:	b8 01 00 00 00       	mov    $0x1,%eax
   12ea3:	5b                   	pop    %rbx
   12ea4:	c3                   	ret
   12ea5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   12eac:	00 00 00 00 

0000000000012eb0 <fwp_gc_report>:
   12eb0:	55                   	push   %rbp
   12eb1:	41 57                	push   %r15
   12eb3:	41 56                	push   %r14
   12eb5:	41 55                	push   %r13
   12eb7:	41 54                	push   %r12
   12eb9:	53                   	push   %rbx
   12eba:	48 81 ec 58 01 00 00 	sub    $0x158,%rsp
   12ec1:	48 8b 05 d0 75 00 00 	mov    0x75d0(%rip),%rax        # 1a498 <fwp_gc+0x1210>
   12ec8:	48 8b 0d b9 63 00 00 	mov    0x63b9(%rip),%rcx        # 19288 <fwp_gc>
   12ecf:	48 29 c8             	sub    %rcx,%rax
   12ed2:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
   12ed7:	f2 0f 58 05 91 75 00 	addsd  0x7591(%rip),%xmm0        # 1a470 <fwp_gc+0x11e8>
   12ede:	00 
   12edf:	f2 0f 11 44 24 48    	movsd  %xmm0,0x48(%rsp)
   12ee5:	f2 0f 11 05 83 75 00 	movsd  %xmm0,0x7583(%rip)        # 1a470 <fwp_gc+0x11e8>
   12eec:	00 
   12eed:	48 89 0d a4 75 00 00 	mov    %rcx,0x75a4(%rip)        # 1a498 <fwp_gc+0x1210>
   12ef4:	48 8b 05 dd 60 00 00 	mov    0x60dd(%rip),%rax        # 18fd8 <stderr@GLIBC_2.2.5>
   12efb:	48 8b 28             	mov    (%rax),%rbp
   12efe:	48 8b 1d 5b 75 00 00 	mov    0x755b(%rip),%rbx        # 1a460 <fwp_gc+0x11d8>
   12f05:	4c 8b 3d 94 73 00 00 	mov    0x7394(%rip),%r15        # 1a2a0 <fwp_gc+0x1018>
   12f0c:	f2 0f 10 05 7c 75 00 	movsd  0x757c(%rip),%xmm0        # 1a490 <fwp_gc+0x1208>
   12f13:	00 
   12f14:	f2 0f 11 44 24 30    	movsd  %xmm0,0x30(%rsp)
   12f1a:	48 8b 05 af 73 00 00 	mov    0x73af(%rip),%rax        # 1a2d0 <fwp_gc+0x1048>
   12f21:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
   12f26:	48 8b 05 23 75 00 00 	mov    0x7523(%rip),%rax        # 1a450 <fwp_gc+0x11c8>
   12f2d:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   12f32:	4c 8b 35 1f 75 00 00 	mov    0x751f(%rip),%r14        # 1a458 <fwp_gc+0x11d0>
   12f39:	f2 0f 10 05 37 75 00 	movsd  0x7537(%rip),%xmm0        # 1a478 <fwp_gc+0x11f0>
   12f40:	00 
   12f41:	f2 0f 11 44 24 40    	movsd  %xmm0,0x40(%rsp)
   12f47:	f2 0f 10 05 31 75 00 	movsd  0x7531(%rip),%xmm0        # 1a480 <fwp_gc+0x11f8>
   12f4e:	00 
   12f4f:	f2 0f 11 44 24 38    	movsd  %xmm0,0x38(%rsp)
   12f55:	48 8d 3d 10 2a 00 00 	lea    0x2a10(%rip),%rdi        # 1596c <exec_in_fp0+0x115c>
   12f5c:	48 8d 35 09 28 00 00 	lea    0x2809(%rip),%rsi        # 1576c <exec_in_fp0+0xf5c>
   12f63:	e8 a8 04 ff ff       	call   3410 <fopen@plt>
   12f68:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
   12f6f:	48 85 c0             	test   %rax,%rax
   12f72:	74 4b                	je     12fbf <fwp_gc_report+0x10f>
   12f74:	49 89 c5             	mov    %rax,%r13
   12f77:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
   12f7c:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
   12f81:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
   12f86:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
   12f8b:	be 00 01 00 00       	mov    $0x100,%esi
   12f90:	48 89 c2             	mov    %rax,%rdx
   12f93:	e8 f8 02 ff ff       	call   3290 <fgets@plt>
   12f98:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
   12f9f:	48 85 c0             	test   %rax,%rax
   12fa2:	0f 85 f1 00 00 00    	jne    13099 <fwp_gc_report+0x1e9>
   12fa8:	4c 89 ef             	mov    %r13,%rdi
   12fab:	e8 a0 01 ff ff       	call   3150 <fclose@plt>
   12fb0:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
   12fb5:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
   12fba:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
   12fbf:	66 49 0f 6e c6       	movq   %r14,%xmm0
   12fc4:	66 0f 6f 0d 54 11 00 	movdqa 0x1154(%rip),%xmm1        # 14120 <_IO_stdin_used+0x120>
   12fcb:	00 
   12fcc:	66 0f 62 c1          	punpckldq %xmm1,%xmm0
   12fd0:	66 0f 28 15 58 11 00 	movapd 0x1158(%rip),%xmm2        # 14130 <_IO_stdin_used+0x130>
   12fd7:	00 
   12fd8:	66 0f 5c c2          	subpd  %xmm2,%xmm0
   12fdc:	66 0f 28 e0          	movapd %xmm0,%xmm4
   12fe0:	66 0f 15 e0          	unpckhpd %xmm0,%xmm4
   12fe4:	f2 0f 58 e0          	addsd  %xmm0,%xmm4
   12fe8:	f2 0f 10 35 e8 11 00 	movsd  0x11e8(%rip),%xmm6        # 141d8 <_IO_stdin_used+0x1d8>
   12fef:	00 
   12ff0:	f2 0f 59 e6          	mulsd  %xmm6,%xmm4
   12ff4:	f3 0f 7e 6c 24 20    	movq   0x20(%rsp),%xmm5
   12ffa:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
   12ffe:	66 0f 5c ea          	subpd  %xmm2,%xmm5
   13002:	66 0f 28 dd          	movapd %xmm5,%xmm3
   13006:	66 0f 15 dd          	unpckhpd %xmm5,%xmm3
   1300a:	f2 0f 58 dd          	addsd  %xmm5,%xmm3
   1300e:	f2 0f 59 de          	mulsd  %xmm6,%xmm3
   13012:	f3 0f 7e 6c 24 28    	movq   0x28(%rsp),%xmm5
   13018:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
   1301c:	66 0f 5c ea          	subpd  %xmm2,%xmm5
   13020:	66 0f 28 d5          	movapd %xmm5,%xmm2
   13024:	66 0f 15 d5          	unpckhpd %xmm5,%xmm2
   13028:	f2 0f 58 d5          	addsd  %xmm5,%xmm2
   1302c:	f2 0f 59 d6          	mulsd  %xmm6,%xmm2
   13030:	f2 0f 10 44 24 48    	movsd  0x48(%rsp),%xmm0
   13036:	f2 0f 10 4c 24 30    	movsd  0x30(%rsp),%xmm1
   1303c:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
   13040:	f2 0f 59 ce          	mulsd  %xmm6,%xmm1
   13044:	f2 0f 59 c6          	mulsd  %xmm6,%xmm0
   13048:	83 3d 2d 72 00 00 00 	cmpl   $0x0,0x722d(%rip)        # 1a27c <fwp_gc+0xff4>
   1304f:	48 8d 05 04 29 00 00 	lea    0x2904(%rip),%rax        # 1595a <exec_in_fp0+0x114a>
   13056:	4c 8d 0d 2d 21 00 00 	lea    0x212d(%rip),%r9        # 1518a <exec_in_fp0+0x97a>
   1305d:	4c 0f 44 c8          	cmove  %rax,%r9
   13061:	48 8d 35 3d 28 00 00 	lea    0x283d(%rip),%rsi        # 158a5 <exec_in_fp0+0x1095>
   13068:	48 89 ef             	mov    %rbp,%rdi
   1306b:	48 89 da             	mov    %rbx,%rdx
   1306e:	4c 89 f9             	mov    %r15,%rcx
   13071:	f2 0f 10 6c 24 40    	movsd  0x40(%rsp),%xmm5
   13077:	f2 0f 10 74 24 38    	movsd  0x38(%rsp),%xmm6
   1307d:	4d 89 e0             	mov    %r12,%r8
   13080:	b0 07                	mov    $0x7,%al
   13082:	e8 69 02 ff ff       	call   32f0 <fprintf@plt>
   13087:	48 81 c4 58 01 00 00 	add    $0x158,%rsp
   1308e:	5b                   	pop    %rbx
   1308f:	41 5c                	pop    %r12
   13091:	41 5d                	pop    %r13
   13093:	41 5e                	pop    %r14
   13095:	41 5f                	pop    %r15
   13097:	5d                   	pop    %rbp
   13098:	c3                   	ret
   13099:	48 8d 6c 24 56       	lea    0x56(%rsp),%rbp
   1309e:	41 bf 56 6d 48 57    	mov    $0x57486d56,%r15d
   130a4:	48 8d 5c 24 50       	lea    0x50(%rsp),%rbx
   130a9:	eb 1e                	jmp    130c9 <fwp_gc_report+0x219>
   130ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   130b0:	48 89 df             	mov    %rbx,%rdi
   130b3:	be 00 01 00 00       	mov    $0x100,%esi
   130b8:	4c 89 ea             	mov    %r13,%rdx
   130bb:	e8 d0 01 ff ff       	call   3290 <fgets@plt>
   130c0:	48 85 c0             	test   %rax,%rax
   130c3:	0f 84 df fe ff ff    	je     12fa8 <fwp_gc_report+0xf8>
   130c9:	8b 44 24 50          	mov    0x50(%rsp),%eax
   130cd:	44 31 f8             	xor    %r15d,%eax
   130d0:	0f b6 4c 24 54       	movzbl 0x54(%rsp),%ecx
   130d5:	83 f1 4d             	xor    $0x4d,%ecx
   130d8:	09 c1                	or     %eax,%ecx
   130da:	75 d4                	jne    130b0 <fwp_gc_report+0x200>
   130dc:	80 7c 24 55 3a       	cmpb   $0x3a,0x55(%rsp)
   130e1:	75 cd                	jne    130b0 <fwp_gc_report+0x200>
   130e3:	48 89 ef             	mov    %rbp,%rdi
   130e6:	31 f6                	xor    %esi,%esi
   130e8:	ba 0a 00 00 00       	mov    $0xa,%edx
   130ed:	e8 2e 02 ff ff       	call   3320 <strtol@plt>
   130f2:	49 89 c4             	mov    %rax,%r12
   130f5:	eb b9                	jmp    130b0 <fwp_gc_report+0x200>
   130f7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   130fe:	00 00 

0000000000013100 <fwp_owner_release0>:
   13100:	48 8b 3f             	mov    (%rdi),%rdi
   13103:	eb 0b                	jmp    13110 <fwp_drop0>
   13105:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   1310c:	00 00 00 00 

0000000000013110 <fwp_drop0>:
   13110:	53                   	push   %rbx
   13111:	48 89 f8             	mov    %rdi,%rax
   13114:	48 2b 05 9d 71 00 00 	sub    0x719d(%rip),%rax        # 1a2b8 <fwp_gc+0x1030>
   1311b:	48 8b 0d be 71 00 00 	mov    0x71be(%rip),%rcx        # 1a2e0 <fwp_gc+0x1058>
   13122:	48 c1 e1 10          	shl    $0x10,%rcx
   13126:	48 39 c8             	cmp    %rcx,%rax
   13129:	0f 83 9c 00 00 00    	jae    131cb <fwp_drop0+0xbb>
   1312f:	48 8b 0d ca 71 00 00 	mov    0x71ca(%rip),%rcx        # 1a300 <fwp_gc+0x1078>
   13136:	48 89 c2             	mov    %rax,%rdx
   13139:	48 c1 ea 10          	shr    $0x10,%rdx
   1313d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
   13144:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
   13148:	48 25 ff ff 00 00    	and    $0xffff,%rax
   1314e:	75 20                	jne    13170 <fwp_drop0+0x60>
   13150:	40 80 fe 02          	cmp    $0x2,%sil
   13154:	75 1a                	jne    13170 <fwp_drop0+0x60>
   13156:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
   1315a:	48 05 28 02 00 00    	add    $0x228,%rax
   13160:	eb 2d                	jmp    1318f <fwp_drop0+0x7f>
   13162:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   13169:	1f 84 00 00 00 00 00 
   13170:	40 80 fe 01          	cmp    $0x1,%sil
   13174:	75 55                	jne    131cb <fwp_drop0+0xbb>
   13176:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
   1317a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
   1317e:	48 0f af c1          	imul   %rcx,%rax
   13182:	48 c1 e8 20          	shr    $0x20,%rax
   13186:	48 01 f0             	add    %rsi,%rax
   13189:	48 05 28 02 00 00    	add    $0x228,%rax
   1318f:	0f b6 08             	movzbl (%rax),%ecx
   13192:	85 c9                	test   %ecx,%ecx
   13194:	74 35                	je     131cb <fwp_drop0+0xbb>
   13196:	83 f9 01             	cmp    $0x1,%ecx
   13199:	75 32                	jne    131cd <fwp_drop0+0xbd>
   1319b:	48 83 3f 00          	cmpq   $0x0,(%rdi)
   1319f:	79 3a                	jns    131db <fwp_drop0+0xcb>
   131a1:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
   131a5:	e8 26 76 ff ff       	call   a7d0 <fwp_rc_free_arr>
   131aa:	48 89 d8             	mov    %rbx,%rax
   131ad:	48 2b 05 04 71 00 00 	sub    0x7104(%rip),%rax        # 1a2b8 <fwp_gc+0x1030>
   131b4:	48 8b 0d 25 71 00 00 	mov    0x7125(%rip),%rcx        # 1a2e0 <fwp_gc+0x1058>
   131bb:	48 c1 e1 10          	shl    $0x10,%rcx
   131bf:	48 89 df             	mov    %rbx,%rdi
   131c2:	48 39 c8             	cmp    %rcx,%rax
   131c5:	0f 82 64 ff ff ff    	jb     1312f <fwp_drop0+0x1f>
   131cb:	5b                   	pop    %rbx
   131cc:	c3                   	ret
   131cd:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
   131d3:	74 0c                	je     131e1 <fwp_drop0+0xd1>
   131d5:	fe c9                	dec    %cl
   131d7:	88 08                	mov    %cl,(%rax)
   131d9:	5b                   	pop    %rbx
   131da:	c3                   	ret
   131db:	5b                   	pop    %rbx
   131dc:	e9 ef 75 ff ff       	jmp    a7d0 <fwp_rc_free_arr>
   131e1:	48 89 c7             	mov    %rax,%rdi
   131e4:	5b                   	pop    %rbx
   131e5:	e9 66 6e ff ff       	jmp    a050 <fwp_rc_wide_drop>
   131ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000131f0 <fwp_owner_release1>:
   131f0:	48 8b 3f             	mov    (%rdi),%rdi
   131f3:	e9 18 ff ff ff       	jmp    13110 <fwp_drop0>
   131f8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   131ff:	00 

0000000000013200 <fwp_owner_release2>:
   13200:	48 8b 3f             	mov    (%rdi),%rdi
   13203:	e9 08 ff ff ff       	jmp    13110 <fwp_drop0>
   13208:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   1320f:	00 

0000000000013210 <__divti3>:
   13210:	f3 0f 1e fa          	endbr64
   13214:	55                   	push   %rbp
   13215:	49 89 f8             	mov    %rdi,%r8
   13218:	49 89 d2             	mov    %rdx,%r10
   1321b:	49 89 cb             	mov    %rcx,%r11
   1321e:	31 ff                	xor    %edi,%edi
   13220:	48 89 e5             	mov    %rsp,%rbp
   13223:	41 56                	push   %r14
   13225:	53                   	push   %rbx
   13226:	48 85 f6             	test   %rsi,%rsi
   13229:	79 13                	jns    1323e <__divti3+0x2e>
   1322b:	45 31 c9             	xor    %r9d,%r9d
   1322e:	49 f7 d8             	neg    %r8
   13231:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
   13238:	49 19 f1             	sbb    %rsi,%r9
   1323b:	4c 89 ce             	mov    %r9,%rsi
   1323e:	4c 89 da             	mov    %r11,%rdx
   13241:	4d 85 db             	test   %r11,%r11
   13244:	0f 88 f6 00 00 00    	js     13340 <__divti3+0x130>
   1324a:	4d 89 d6             	mov    %r10,%r14
   1324d:	75 31                	jne    13280 <__divti3+0x70>
   1324f:	4c 39 f6             	cmp    %r14,%rsi
   13252:	0f 83 b8 00 00 00    	jae    13310 <__divti3+0x100>
   13258:	48 89 f2             	mov    %rsi,%rdx
   1325b:	31 f6                	xor    %esi,%esi
   1325d:	4c 89 c0             	mov    %r8,%rax
   13260:	49 f7 f6             	div    %r14
   13263:	48 89 f2             	mov    %rsi,%rdx
   13266:	48 85 ff             	test   %rdi,%rdi
   13269:	74 0a                	je     13275 <__divti3+0x65>
   1326b:	48 f7 d8             	neg    %rax
   1326e:	48 83 d2 00          	adc    $0x0,%rdx
   13272:	48 f7 da             	neg    %rdx
   13275:	5b                   	pop    %rbx
   13276:	41 5e                	pop    %r14
   13278:	5d                   	pop    %rbp
   13279:	c3                   	ret
   1327a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   13280:	4c 39 de             	cmp    %r11,%rsi
   13283:	0f 82 d5 00 00 00    	jb     1335e <__divti3+0x14e>
   13289:	4d 0f bd d3          	bsr    %r11,%r10
   1328d:	41 83 f2 3f          	xor    $0x3f,%r10d
   13291:	44 89 d1             	mov    %r10d,%ecx
   13294:	b8 40 00 00 00       	mov    $0x40,%eax
   13299:	4c 89 f3             	mov    %r14,%rbx
   1329c:	4d 89 f1             	mov    %r14,%r9
   1329f:	48 d3 e2             	shl    %cl,%rdx
   132a2:	49 63 ca             	movslq %r10d,%rcx
   132a5:	49 89 f3             	mov    %rsi,%r11
   132a8:	48 29 c8             	sub    %rcx,%rax
   132ab:	89 c1                	mov    %eax,%ecx
   132ad:	48 d3 eb             	shr    %cl,%rbx
   132b0:	44 89 d1             	mov    %r10d,%ecx
   132b3:	49 d3 e1             	shl    %cl,%r9
   132b6:	89 c1                	mov    %eax,%ecx
   132b8:	48 09 d3             	or     %rdx,%rbx
   132bb:	4c 89 c2             	mov    %r8,%rdx
   132be:	49 d3 eb             	shr    %cl,%r11
   132c1:	44 89 d1             	mov    %r10d,%ecx
   132c4:	48 d3 e6             	shl    %cl,%rsi
   132c7:	89 c1                	mov    %eax,%ecx
   132c9:	48 d3 ea             	shr    %cl,%rdx
   132cc:	48 89 d0             	mov    %rdx,%rax
   132cf:	4c 89 da             	mov    %r11,%rdx
   132d2:	48 09 f0             	or     %rsi,%rax
   132d5:	48 f7 f3             	div    %rbx
   132d8:	49 89 d3             	mov    %rdx,%r11
   132db:	48 89 c6             	mov    %rax,%rsi
   132de:	49 f7 e1             	mul    %r9
   132e1:	49 39 d3             	cmp    %rdx,%r11
   132e4:	0f 82 be 00 00 00    	jb     133a8 <__divti3+0x198>
   132ea:	44 89 d1             	mov    %r10d,%ecx
   132ed:	49 d3 e0             	shl    %cl,%r8
   132f0:	49 39 c0             	cmp    %rax,%r8
   132f3:	73 09                	jae    132fe <__divti3+0xee>
   132f5:	49 39 d3             	cmp    %rdx,%r11
   132f8:	0f 84 aa 00 00 00    	je     133a8 <__divti3+0x198>
   132fe:	48 89 f0             	mov    %rsi,%rax
   13301:	31 f6                	xor    %esi,%esi
   13303:	e9 5b ff ff ff       	jmp    13263 <__divti3+0x53>
   13308:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   1330f:	00 
   13310:	4d 85 f6             	test   %r14,%r14
   13313:	75 0d                	jne    13322 <__divti3+0x112>
   13315:	b8 01 00 00 00       	mov    $0x1,%eax
   1331a:	31 d2                	xor    %edx,%edx
   1331c:	49 f7 f6             	div    %r14
   1331f:	49 89 c6             	mov    %rax,%r14
   13322:	48 89 f0             	mov    %rsi,%rax
   13325:	31 d2                	xor    %edx,%edx
   13327:	49 f7 f6             	div    %r14
   1332a:	48 89 c6             	mov    %rax,%rsi
   1332d:	4c 89 c0             	mov    %r8,%rax
   13330:	49 f7 f6             	div    %r14
   13333:	e9 2b ff ff ff       	jmp    13263 <__divti3+0x53>
   13338:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   1333f:	00 
   13340:	49 f7 da             	neg    %r10
   13343:	48 f7 d7             	not    %rdi
   13346:	49 83 d3 00          	adc    $0x0,%r11
   1334a:	4d 89 d6             	mov    %r10,%r14
   1334d:	49 f7 db             	neg    %r11
   13350:	4c 89 da             	mov    %r11,%rdx
   13353:	0f 84 f6 fe ff ff    	je     1324f <__divti3+0x3f>
   13359:	4c 39 de             	cmp    %r11,%rsi
   1335c:	73 12                	jae    13370 <__divti3+0x160>
   1335e:	31 f6                	xor    %esi,%esi
   13360:	31 c0                	xor    %eax,%eax
   13362:	e9 fc fe ff ff       	jmp    13263 <__divti3+0x53>
   13367:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   1336e:	00 00 
   13370:	49 0f bd c3          	bsr    %r11,%rax
   13374:	48 83 f0 3f          	xor    $0x3f,%rax
   13378:	41 89 c2             	mov    %eax,%r10d
   1337b:	85 c0                	test   %eax,%eax
   1337d:	0f 85 0e ff ff ff    	jne    13291 <__divti3+0x81>
   13383:	49 39 f3             	cmp    %rsi,%r11
   13386:	72 0d                	jb     13395 <__divti3+0x185>
   13388:	31 f6                	xor    %esi,%esi
   1338a:	31 c0                	xor    %eax,%eax
   1338c:	4d 39 f0             	cmp    %r14,%r8
   1338f:	0f 82 ce fe ff ff    	jb     13263 <__divti3+0x53>
   13395:	31 f6                	xor    %esi,%esi
   13397:	b8 01 00 00 00       	mov    $0x1,%eax
   1339c:	e9 c2 fe ff ff       	jmp    13263 <__divti3+0x53>
   133a1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   133a8:	48 8d 46 ff          	lea    -0x1(%rsi),%rax
   133ac:	31 f6                	xor    %esi,%esi
   133ae:	e9 b0 fe ff ff       	jmp    13263 <__divti3+0x53>
   133b3:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   133ba:	00 00 00 
   133bd:	0f 1f 00             	nopl   (%rax)

00000000000133c0 <atexit>:
   133c0:	f3 0f 1e fa          	endbr64
   133c4:	48 8b 15 ad 5e 00 00 	mov    0x5ead(%rip),%rdx        # 19278 <__dso_handle>
   133cb:	31 f6                	xor    %esi,%esi
   133cd:	e9 6e 00 ff ff       	jmp    3440 <__cxa_atexit@plt>

Disassembly of section .fini:

00000000000133d4 <_fini>:
   133d4:	f3 0f 1e fa          	endbr64
   133d8:	48 83 ec 08          	sub    $0x8,%rsp
   133dc:	48 83 c4 08          	add    $0x8,%rsp
   133e0:	c3                   	ret
