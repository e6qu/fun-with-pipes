# fwp, C and Rust: complete-program elapsed time

Source commit: `e7965762490c89d2a39f5937fe8322291ea906fc`. Host: `linux/x86_64`.

Each executable has one warmup and six measured runs. Orders rotate
C/Rust/fwp, Rust/fwp/C, fwp/C/Rust, twice; each implementation occupies
every position twice. The table uses the median. Samples include startup, input
construction, computation, allocation and output; compilation is excluded.
Native fwp ownership: counted. ARC releases a value when its last
owner releases it. There is no tracing collector. The interpreter is not timed.

A ratio above 1 means fwp took longer. The percentage is
`(fwp / baseline - 1) * 100`, not a separately measured language cost.
Matching output does not imply equal work: maps use sorted pairs in
all three but sorting implementations differ; pipelines can remove collections, and
fwp can remove string formatting when only its length is needed.
Arithmetic contract: checked signed I64 calculations in all three peers.
C uses overflow builtins; Rust uses checked operations. Loop/index increments
have fixed bounds; range-set hashes deliberately wrap modulo 2^64. Failure
messages differ and are outside the timed fixed-input runs. text-length
counts decimal digits directly in C/Rust without constructing text.
No allocation or peak-memory
counters are collected by this comparison. See docs/benchmarks.md.

The measured executables and source inputs are retained in `target/bench-evidence`.
Generated fwp C is emitted separately after timing with the same compiler/settings;
that extra emission is excluded from execution and compilation timings.

C compiler (`gcc -std=c11 -O2 -ffp-contract=off`):

```text
gcc (Ubuntu 15.2.0-16ubuntu1) 15.2.0
Copyright (C) 2025 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```

Rust compiler (`rustc --edition=2021 -O`):

```text
rustc 1.99.1 (58cf8f9c3 2026-10-13)
binary: rustc
commit-hash: 58cf8f9c35b355199727627d07ae34a4e2846d67
commit-date: 2026-10-13
host: x86_64-unknown-linux-gnu
release: 1.99.1
LLVM version: 23.1.1
```

fwp build flags: `-O2`, `FWP_LTO=0`; generated C is compiled
as one source file, without link-time optimization.

| Program | C | Rust | fwp | fwp / C (extra time) | fwp / Rust (extra time) |
|---|--:|--:|--:|--:|--:|
| fib | 48.670 ms | 44.245 ms | 15.278 ms | 0.314× (-68.6%) | 0.345× (-65.5%) |
| loop | 128.769 ms | 106.924 ms | 159.768 ms | 1.241× (+24.1%) | 1.494× (+49.4%) |
| map | 395.800 ms | 320.880 ms | 355.184 ms | 0.897× (-10.3%) | 1.107× (+10.7%) |
| pipeline | 33.987 ms | 21.335 ms | 18.988 ms | 0.559× (-44.1%) | 0.890× (-11.0%) |
| range-set | 14.458 ms | 14.659 ms | 16.634 ms | 1.150× (+15.0%) | 1.135× (+13.5%) |
| strings | 145.941 ms | 155.598 ms | 4.804 ms | 0.033× (-96.7%) | 0.031× (-96.9%) |
| text-length | 3.595 ms | 6.787 ms | 4.851 ms | 1.349× (+34.9%) | 0.715× (-28.5%) |

## Raw elapsed samples

All samples below are milliseconds, in execution order.

| Program | C | Rust | fwp |
|---|---|---|---|
| fib | 48.599 ms, 48.764 ms, 48.671 ms, 48.692 ms, 48.550 ms, 48.669 ms | 44.052 ms, 44.124 ms, 44.285 ms, 44.296 ms, 44.568 ms, 44.205 ms | 15.524 ms, 16.223 ms, 13.246 ms, 15.032 ms, 15.816 ms, 13.989 ms |
| loop | 127.717 ms, 126.864 ms, 130.125 ms, 126.686 ms, 130.597 ms, 129.821 ms | 106.886 ms, 107.044 ms, 106.821 ms, 106.961 ms, 107.055 ms, 106.683 ms | 161.151 ms, 159.671 ms, 160.261 ms, 157.576 ms, 159.865 ms, 156.842 ms |
| map | 396.086 ms, 396.630 ms, 396.551 ms, 395.514 ms, 393.256 ms, 395.037 ms | 320.280 ms, 322.028 ms, 318.321 ms, 323.810 ms, 318.816 ms, 321.481 ms | 351.963 ms, 348.666 ms, 358.404 ms, 348.755 ms, 359.102 ms, 359.159 ms |
| pipeline | 36.312 ms, 31.318 ms, 35.254 ms, 34.335 ms, 33.638 ms, 32.621 ms | 21.317 ms, 21.188 ms, 21.417 ms, 21.303 ms, 21.505 ms, 21.352 ms | 18.983 ms, 19.773 ms, 19.189 ms, 17.290 ms, 18.994 ms, 16.971 ms |
| range-set | 14.395 ms, 14.459 ms, 14.458 ms, 14.211 ms, 14.614 ms, 14.938 ms | 14.510 ms, 14.950 ms, 14.521 ms, 14.409 ms, 14.902 ms, 14.797 ms | 17.302 ms, 16.257 ms, 15.812 ms, 16.713 ms, 17.660 ms, 16.554 ms |
| strings | 145.705 ms, 146.130 ms, 147.742 ms, 145.891 ms, 142.348 ms, 145.992 ms | 155.900 ms, 155.549 ms, 155.455 ms, 155.647 ms, 155.380 ms, 156.589 ms | 5.867 ms, 4.412 ms, 4.653 ms, 4.955 ms, 7.271 ms, 4.477 ms |
| text-length | 3.631 ms, 3.708 ms, 3.611 ms, 3.541 ms, 3.576 ms, 3.579 ms | 6.748 ms, 7.037 ms, 6.844 ms, 6.708 ms, 6.816 ms, 6.759 ms | 4.848 ms, 4.779 ms, 4.855 ms, 7.833 ms, 5.032 ms, 4.158 ms |

## Compilation and binary size

One build per implementation; elapsed time includes compiler startup and linking.
The fwp compiler itself is already built. Binary sizes include each toolchain's
runtime and linking choices; they are not executable-code sizes alone.

| Program | C build | Rust build | fwp build | C bytes | Rust bytes | fwp bytes |
|---|---:|---:|---:|---:|---:|---:|
| fib | 41.592 ms | 68.402 ms | 740.364 ms | 16032 | 4538088 | 27808 |
| loop | 41.587 ms | 76.398 ms | 638.706 ms | 16048 | 4537912 | 27752 |
| map | 53.008 ms | 183.150 ms | 842.070 ms | 16112 | 4543424 | 36976 |
| pipeline | 51.796 ms | 112.711 ms | 636.515 ms | 16040 | 4538360 | 27752 |
| range-set | 47.275 ms | 96.322 ms | 695.297 ms | 16040 | 4537688 | 28064 |
| strings | 42.748 ms | 83.401 ms | 636.957 ms | 16104 | 4540160 | 27752 |
| text-length | 48.911 ms | 74.897 ms | 637.680 ms | 16032 | 4537976 | 27760 |

## Processor

```text
Architecture:                            x86_64
CPU op-mode(s):                          32-bit, 64-bit
Address sizes:                           48 bits physical, 48 bits virtual
Byte Order:                              Little Endian
CPU(s):                                  4
On-line CPU(s) list:                     0-3
Vendor ID:                               AuthenticAMD
Model name:                              AMD EPYC 7763 64-Core Processor
CPU family:                              25
Model:                                   1
Thread(s) per core:                      2
Core(s) per socket:                      2
Socket(s):                               1
Stepping:                                1
BogoMIPS:                                4890.86
Flags:                                   fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl tsc_reliable nonstop_tsc cpuid extd_apicid aperfmperf tsc_known_freq pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand hypervisor lahf_lm cmp_legacy svm cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw topoext vmmcall fsgsbase bmi1 avx2 smep bmi2 erms invpcid rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves user_shstk clzero xsaveerptr rdpru arat npt nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold v_vmsave_vmload umip vaes vpclmulqdq rdpid fsrm
Virtualization:                          AMD-V
Hypervisor vendor:                       Microsoft
Virtualization type:                     full
L1d cache:                               64 KiB (2 instances)
L1i cache:                               64 KiB (2 instances)
L2 cache:                                1 MiB (2 instances)
L3 cache:                                32 MiB (1 instance)
NUMA node(s):                            1
NUMA node0 CPU(s):                       0-3
Vulnerability Gather data sampling:      Not affected
Vulnerability Ghostwrite:                Not affected
Vulnerability Indirect target selection: Not affected
Vulnerability Itlb multihit:             Not affected
Vulnerability L1tf:                      Not affected
Vulnerability Mds:                       Not affected
Vulnerability Meltdown:                  Not affected
Vulnerability Mmio stale data:           Not affected
Vulnerability Old microcode:             Not affected
Vulnerability Reg file data sampling:    Not affected
Vulnerability Retbleed:                  Not affected
Vulnerability Spec rstack overflow:      Vulnerable: Safe RET, no microcode
Vulnerability Spec store bypass:         Vulnerable
Vulnerability Spectre v1:                Mitigation; usercopy/swapgs barriers and __user pointer sanitization
Vulnerability Spectre v2:                Mitigation; Retpolines; STIBP disabled; RSB filling; PBRSB-eIBRS Not affected; BHI Not affected
Vulnerability Srbds:                     Not affected
Vulnerability Tsa:                       Vulnerable: No microcode
Vulnerability Tsx async abort:           Not affected
Vulnerability Vmscape:                   Not affected
```
