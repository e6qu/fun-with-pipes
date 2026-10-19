# fwp, C and Rust: complete-program elapsed time

Historical measurement from PR #174 before its C aliasing repair and direct
integer output. Both Linux production jobs failed a separate captured-tuple hash
test at this source; these benchmark results are not acceptance evidence.
All samples are retained, including slower results. The pipeline C and all three
pipeline executables match PR #173 byte for byte despite the timing change.

Source commit: `d8554041b5e2f97faa806a3515ea8f2537e48f0e`. Host: `linux/x86_64`.

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
| fib | 20.341 ms | 29.206 ms | 14.408 ms | 0.708× (-29.2%) | 0.493× (-50.7%) |
| loop | 94.367 ms | 125.571 ms | 126.942 ms | 1.345× (+34.5%) | 1.011× (+1.1%) |
| map | 383.958 ms | 311.720 ms | 331.949 ms | 0.865× (-13.5%) | 1.065× (+6.5%) |
| pipeline | 29.109 ms | 15.142 ms | 26.089 ms | 0.896× (-10.4%) | 1.723× (+72.3%) |
| range-set | 12.229 ms | 12.161 ms | 12.879 ms | 1.053× (+5.3%) | 1.059× (+5.9%) |
| strings | 166.828 ms | 166.201 ms | 196.684 ms | 1.179× (+17.9%) | 1.183× (+18.3%) |

## Raw elapsed samples

All samples below are milliseconds, in execution order.

| Program | C | Rust | fwp |
|---|---|---|---|
| fib | 20.530 ms, 20.711 ms, 20.343 ms, 20.145 ms, 20.283 ms, 20.339 ms | 29.224 ms, 29.215 ms, 29.064 ms, 29.534 ms, 29.198 ms, 29.052 ms | 15.205 ms, 18.879 ms, 14.455 ms, 13.767 ms, 14.361 ms, 13.302 ms |
| loop | 94.157 ms, 94.226 ms, 94.422 ms, 94.536 ms, 94.311 ms, 94.484 ms | 125.503 ms, 125.515 ms, 125.627 ms, 125.695 ms, 125.730 ms, 125.392 ms | 133.847 ms, 126.410 ms, 127.159 ms, 126.281 ms, 136.650 ms, 126.725 ms |
| map | 381.635 ms, 384.454 ms, 381.969 ms, 383.537 ms, 384.379 ms, 390.903 ms | 308.698 ms, 310.490 ms, 312.364 ms, 314.424 ms, 315.726 ms, 311.076 ms | 331.277 ms, 336.248 ms, 332.157 ms, 331.740 ms, 339.529 ms, 325.915 ms |
| pipeline | 28.589 ms, 30.298 ms, 28.754 ms, 29.464 ms, 30.527 ms, 26.660 ms | 15.178 ms, 16.042 ms, 14.858 ms, 15.020 ms, 15.498 ms, 15.106 ms | 17.381 ms, 15.664 ms, 26.836 ms, 25.517 ms, 26.662 ms, 26.982 ms |
| range-set | 12.494 ms, 12.589 ms, 12.324 ms, 11.837 ms, 12.134 ms, 12.090 ms | 12.187 ms, 12.215 ms, 12.135 ms, 11.866 ms, 12.435 ms, 12.075 ms | 14.329 ms, 12.882 ms, 12.659 ms, 12.876 ms, 12.841 ms, 14.173 ms |
| strings | 166.251 ms, 166.737 ms, 166.918 ms, 167.225 ms, 167.040 ms, 166.553 ms | 166.239 ms, 166.684 ms, 168.829 ms, 165.930 ms, 166.000 ms, 166.162 ms | 195.536 ms, 193.752 ms, 204.355 ms, 199.705 ms, 197.831 ms, 193.411 ms |

## Compilation and binary size

One build per implementation; elapsed time includes compiler startup and linking.
The fwp compiler itself is already built. Binary sizes include each toolchain's
runtime and linking choices; they are not executable-code sizes alone.

| Program | C build | Rust build | fwp build | C bytes | Rust bytes | fwp bytes |
|---|---:|---:|---:|---:|---:|---:|
| fib | 67.176 ms | 56.482 ms | 1044.210 ms | 15992 | 4537784 | 56624 |
| loop | 36.763 ms | 57.001 ms | 1134.120 ms | 15968 | 4537896 | 61696 |
| map | 49.070 ms | 163.250 ms | 1319.939 ms | 16120 | 4543344 | 74912 |
| pipeline | 46.809 ms | 94.573 ms | 1205.316 ms | 16048 | 4538088 | 66312 |
| range-set | 46.415 ms | 80.906 ms | 993.278 ms | 16048 | 4537696 | 56456 |
| strings | 39.788 ms | 65.799 ms | 1170.867 ms | 16112 | 4540016 | 61920 |

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
