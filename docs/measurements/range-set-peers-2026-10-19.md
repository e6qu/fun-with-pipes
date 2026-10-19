# fwp, C and Rust: complete-program elapsed time

Source commit: `3e4d0a372a79461d5482503b4d1b454ed7b7e347`. Host: `linux/x86_64`.

Each executable has one warmup and six measured runs. Orders rotate
C/Rust/fwp, Rust/fwp/C, fwp/C/Rust, twice; each implementation occupies
every position twice. The table uses the median. Samples include startup, input
construction, computation, allocation and output; compilation is excluded.
These runs use native fwp, not the interpreter or checked ARC mode.

A ratio above 1 means fwp took longer. The percentage is
`(fwp / baseline - 1) * 100`, not a separately measured language cost.
Matching output does not imply equal work: maps use sorted pairs in
all three but sorting implementations differ; pipelines can remove collections, and
fwp can remove string formatting when only its length is needed.
fwp checks integer overflow; the C and optimized Rust baselines do not
provide the same overflow guarantees. No allocation or peak-memory
counters are collected by this comparison. See docs/benchmarks.md.

The measured executables and source inputs are retained in `target/bench-evidence`.
Generated fwp C is emitted separately after timing with the same compiler/settings;
that extra emission is excluded from execution and compilation timings.

C compiler (`cc -O2`):

```text
cc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0
Copyright (C) 2023 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```

Rust compiler (`rustc -O`):

```text
rustc 1.99.1 (58cf8f9c3 2026-10-13)
binary: rustc
commit-hash: 58cf8f9c35b355199727627d07ae34a4e2846d67
commit-date: 2026-10-13
host: x86_64-unknown-linux-gnu
release: 1.99.1
LLVM version: 23.1.1
```

fwp build flags: `--gc tracing -O2`; fwp compiles through the system C toolchain.

| Program | C | Rust | fwp | fwp / C (extra time) | fwp / Rust (extra time) |
|---|--:|--:|--:|--:|--:|
| fib | 20.334 ms | 29.151 ms | 14.575 ms | 0.717× (-28.3%) | 0.500× (-50.0%) |
| loop | 94.453 ms | 125.624 ms | 127.136 ms | 1.346× (+34.6%) | 1.012× (+1.2%) |
| map | 382.165 ms | 310.826 ms | 335.033 ms | 0.877× (-12.3%) | 1.078× (+7.8%) |
| pipeline | 25.995 ms | 15.000 ms | 16.983 ms | 0.653× (-34.7%) | 1.132× (+13.2%) |
| range-set | 12.260 ms | 12.165 ms | 13.009 ms | 1.061× (+6.1%) | 1.069× (+6.9%) |
| strings | 166.996 ms | 165.890 ms | 197.851 ms | 1.185× (+18.5%) | 1.193× (+19.3%) |

## Raw elapsed samples

All samples below are milliseconds, in execution order.

| Program | C | Rust | fwp |
|---|---|---|---|
| fib | 20.252 ms, 20.323 ms, 20.345 ms, 20.255 ms, 20.600 ms, 20.392 ms | 29.085 ms, 29.259 ms, 29.216 ms, 28.898 ms, 29.275 ms, 29.060 ms | 13.212 ms, 14.053 ms, 13.097 ms, 15.097 ms, 18.869 ms, 17.744 ms |
| loop | 94.506 ms, 94.539 ms, 94.474 ms, 94.304 ms, 94.413 ms, 94.431 ms | 125.659 ms, 125.805 ms, 125.527 ms, 125.488 ms, 125.885 ms, 125.588 ms | 127.135 ms, 125.986 ms, 127.668 ms, 126.127 ms, 133.557 ms, 127.138 ms |
| map | 382.386 ms, 382.008 ms, 382.322 ms, 384.583 ms, 381.962 ms, 381.409 ms | 309.363 ms, 310.976 ms, 310.675 ms, 311.564 ms, 313.884 ms, 309.889 ms | 327.285 ms, 338.071 ms, 335.254 ms, 328.449 ms, 334.812 ms, 335.978 ms |
| pipeline | 29.360 ms, 29.082 ms, 25.714 ms, 26.277 ms, 24.390 ms, 25.025 ms | 15.603 ms, 16.155 ms, 14.828 ms, 14.923 ms, 15.049 ms, 14.952 ms | 16.050 ms, 17.602 ms, 17.521 ms, 16.444 ms, 26.431 ms, 15.915 ms |
| range-set | 12.409 ms, 12.200 ms, 12.788 ms, 11.866 ms, 12.260 ms, 12.261 ms | 12.404 ms, 12.280 ms, 12.049 ms, 11.925 ms, 12.419 ms, 12.002 ms | 15.837 ms, 12.630 ms, 13.396 ms, 12.792 ms, 12.822 ms, 13.196 ms |
| strings | 167.070 ms, 167.438 ms, 167.550 ms, 166.599 ms, 166.143 ms, 166.922 ms | 165.828 ms, 165.952 ms, 165.455 ms, 166.005 ms, 171.315 ms, 165.638 ms | 202.730 ms, 203.369 ms, 201.288 ms, 193.049 ms, 194.414 ms, 193.374 ms |

## Compilation and binary size

One build per implementation; elapsed time includes compiler startup and linking.
The fwp compiler itself is already built. Binary sizes include each toolchain's
runtime and linking choices; they are not executable-code sizes alone.

| Program | C build | Rust build | fwp build | C bytes | Rust bytes | fwp bytes |
|---|---:|---:|---:|---:|---:|---:|
| fib | 75.467 ms | 56.658 ms | 1136.564 ms | 15992 | 4537784 | 56624 |
| loop | 36.850 ms | 57.488 ms | 1151.863 ms | 15968 | 4537896 | 61696 |
| map | 51.317 ms | 165.036 ms | 1346.915 ms | 16120 | 4543344 | 74912 |
| pipeline | 47.229 ms | 94.756 ms | 1226.280 ms | 16048 | 4538088 | 66312 |
| range-set | 49.984 ms | 83.335 ms | 1096.087 ms | 16048 | 4537696 | 56664 |
| strings | 39.339 ms | 66.420 ms | 1163.566 ms | 16112 | 4540016 | 61920 |

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
