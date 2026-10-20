# fwp, C and Rust: complete-program elapsed time

Source commit: `67f233467bc68fe9a690373af219253d45f4e3f8`. Host: `linux/x86_64`.

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
| fib | 20.485 ms | 29.257 ms | 13.060 ms | 0.638× (-36.2%) | 0.446× (-55.4%) |
| loop | 94.552 ms | 125.804 ms | 130.751 ms | 1.383× (+38.3%) | 1.039× (+3.9%) |
| map | 383.139 ms | 311.028 ms | 337.452 ms | 0.881× (-11.9%) | 1.085× (+8.5%) |
| pipeline | 29.622 ms | 15.258 ms | 17.258 ms | 0.583× (-41.7%) | 1.131× (+13.1%) |
| range-set | 12.591 ms | 12.448 ms | 13.335 ms | 1.059× (+5.9%) | 1.071× (+7.1%) |
| strings | 167.054 ms | 165.972 ms | 193.283 ms | 1.157× (+15.7%) | 1.165× (+16.5%) |

## Raw elapsed samples

All samples below are milliseconds, in execution order.

| Program | C | Rust | fwp |
|---|---|---|---|
| fib | 20.416 ms, 20.560 ms, 20.499 ms, 20.170 ms, 20.471 ms, 20.641 ms | 29.061 ms, 29.292 ms, 29.565 ms, 28.971 ms, 29.410 ms, 29.221 ms | 13.525 ms, 12.666 ms, 13.454 ms, 12.107 ms, 13.561 ms, 12.248 ms |
| loop | 94.603 ms, 94.629 ms, 94.522 ms, 94.403 ms, 94.582 ms, 94.305 ms | 125.779 ms, 125.836 ms, 125.805 ms, 125.804 ms, 126.491 ms, 125.719 ms | 134.000 ms, 130.135 ms, 131.360 ms, 127.087 ms, 130.453 ms, 131.049 ms |
| map | 383.426 ms, 385.380 ms, 382.851 ms, 382.612 ms, 386.027 ms, 382.339 ms | 312.198 ms, 311.219 ms, 309.916 ms, 310.838 ms, 311.222 ms, 309.358 ms | 339.308 ms, 336.134 ms, 333.324 ms, 336.960 ms, 348.531 ms, 337.943 ms |
| pipeline | 32.455 ms, 29.486 ms, 29.758 ms, 26.289 ms, 25.564 ms, 29.888 ms | 15.100 ms, 15.697 ms, 16.026 ms, 15.366 ms, 15.151 ms, 14.917 ms | 17.300 ms, 22.302 ms, 16.492 ms, 17.043 ms, 17.216 ms, 26.177 ms |
| range-set | 12.540 ms, 12.885 ms, 12.723 ms, 12.062 ms, 12.642 ms, 12.305 ms | 12.338 ms, 12.865 ms, 12.558 ms, 12.107 ms, 12.711 ms, 12.108 ms | 13.392 ms, 12.921 ms, 12.865 ms, 13.535 ms, 13.278 ms, 13.832 ms |
| strings | 167.214 ms, 167.332 ms, 166.724 ms, 167.508 ms, 166.493 ms, 166.894 ms | 165.768 ms, 166.000 ms, 165.944 ms, 166.331 ms, 165.804 ms, 166.197 ms | 204.301 ms, 202.854 ms, 190.408 ms, 190.433 ms, 189.837 ms, 196.133 ms |

## Compilation and binary size

One build per implementation; elapsed time includes compiler startup and linking.
The fwp compiler itself is already built. Binary sizes include each toolchain's
runtime and linking choices; they are not executable-code sizes alone.

| Program | C build | Rust build | fwp build | C bytes | Rust bytes | fwp bytes |
|---|---:|---:|---:|---:|---:|---:|
| fib | 68.883 ms | 56.314 ms | 813.764 ms | 15992 | 4537784 | 39256 |
| loop | 37.215 ms | 59.590 ms | 1110.957 ms | 15968 | 4537896 | 61648 |
| map | 50.873 ms | 166.355 ms | 1307.361 ms | 16120 | 4543344 | 70768 |
| pipeline | 47.658 ms | 96.233 ms | 1170.150 ms | 16048 | 4538088 | 62168 |
| range-set | 46.881 ms | 81.269 ms | 946.018 ms | 16048 | 4537696 | 52416 |
| strings | 40.609 ms | 68.069 ms | 1180.938 ms | 16112 | 4540016 | 61976 |

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
