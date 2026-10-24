# Numerical output after removing temporary lists

These measurements compare complete fwp, C and Rust programs. They do not
measure an isolated language overhead or prove a before/after speedup. The
[array change](array-text.md) reduces heap requests; the comparison below shows
what still costs time. Final delivery and the startup-stack repair remain open.

## Programs and timing

Each program performs gradient-descent updates on a vector of numbers. It uses
an explicit gradient formula; this experiment does not record an autodiff tape.
An input is written `coordinates:updates`: `129:199` means 129 numbers and 199
updates. Every coordinate is consumed, including in the checksum version.

- Full output formats the final array and writes it. fwp formats the array
  directly, with no output list. fwp searches decimal precision until the
  printed value reads back identically; C uses `printf("%.17g")`, and Rust uses
  its ordinary display formatting. Checks compare parsed values, not identical
  cross-language strings. Formatting algorithm differences belong in the ratios.
- The checksum version sends every final coordinate through the same external
  C consumer. It still includes checked indexing, storage, cleanup, callbacks
  and process startup. It is not pure arithmetic time.
- C and Rust reuse two numerical buffers. fwp preserves immutable updates.
  Complete-process timing includes startup and output; constant-array
  initialization happens once per process. Compilation is measured separately.

The [protocol](descent-output-protocol.md) specifies compiler flags and all
controls. Inputs `3:0` and `3:1` repeat 32,768 solves per process; the other four
repeat 4,096. Each executable has four warmups and 48 measured samples, with
explicit randomized order. A byte-identical executable copy must have a median
within 2%; otherwise that mode is inconclusive. No slower row is removed.

## Recorded runs

Both runs use AMD EPYC 9V45 and ARM Neoverse-N2 hosts with GCC 13.3 and Rust
1.99.1. Complete environments, commands, samples, allocation probes, code sizes,
frame reports and process RSS are in the [raw record](array-output-2026-10-24.json).

- First: source `41f6438cf6fb04137aa8b97a05deb460df4702e3`,
  [run 40045991255](https://github.com/e6qu/fun-with-pipes/actions/runs/40045991255).
  Both numerical jobs passed, but a separate iterator failure prevented general
  acceptance of this compiler source.
- Repeat: source `6516169a07680a8579c9a534436f78cdd057b25f`,
  [run 40049587794](https://github.com/e6qu/fun-with-pipes/actions/runs/40049587794).
  Compiler/runtime files match six-host passing `dbef97e1a9e8`. This revision
  adds explicit build deadlines and command journals; it predates the stack repair.

Each job passed independent inspection of 169 saved binaries, their source
hashes, machine architecture, consumer calls and lifetime controls. That is 676
files across these four jobs, not 676 unique source programs.

## Complete-program ratios

A ratio of 2 means twice the peer time, or 100% more time. Ratios below 1 mean
less time. “Inconclusive” applies only to the named mode; its observed number
is retained but is not accepted evidence of a performance difference.

| Run / CPU | Input | Full / C | Full / Rust | Checksum / C | Checksum / Rust | Copy control |
|---|---|---:|---:|---:|---:|---|
| first / AMD64 | 3:0 | 2.202 | 1.066 | 0.901 | 0.882 | pass |
| first / AMD64 | 3:1 | 17.683 | 9.052 | 1.142 | 1.106 | checksum inconclusive |
| first / AMD64 | 3:199 | 5.390 | 4.343 | 2.001 | 1.899 | pass |
| first / AMD64 | 3:1999 | 2.335 | 2.041 | 1.915 | 1.886 | pass |
| first / AMD64 | 33:199 | 9.172 | 9.082 | 1.757 | 1.825 | pass |
| first / AMD64 | 129:199 | 8.535 | 9.313 | 1.573 | 1.673 | pass |
| first / ARM64 | 3:0 | 1.808 | 1.904 | 0.710 | 0.807 | pass |
| first / ARM64 | 3:1 | 17.324 | 16.493 | 1.038 | 1.107 | pass |
| first / ARM64 | 3:199 | 7.347 | 6.491 | 2.650 | 2.632 | pass |
| first / ARM64 | 3:1999 | 3.495 | 3.143 | 2.857 | 2.903 | pass |
| first / ARM64 | 33:199 | 7.470 | 8.074 | 1.402 | 1.390 | pass |
| first / ARM64 | 129:199 | 7.192 | 8.289 | 1.189 | 1.187 | pass |
| repeat / AMD64 | 3:0 | 2.117 | 1.047 | 0.878 | 0.878 | pass |
| repeat / AMD64 | 3:1 | 18.430 | 9.324 | 1.245 | 1.171 | checksum inconclusive |
| repeat / AMD64 | 3:199 | 5.534 | 4.408 | 2.023 | 1.934 | pass |
| repeat / AMD64 | 3:1999 | 2.345 | 2.055 | 1.921 | 1.887 | pass |
| repeat / AMD64 | 33:199 | 9.320 | 9.281 | 1.757 | 1.822 | pass |
| repeat / AMD64 | 129:199 | 8.619 | 8.933 | 1.593 | 1.695 | pass |
| repeat / ARM64 | 3:0 | 1.813 | 1.906 | 0.719 | 0.803 | checksum inconclusive |
| repeat / ARM64 | 3:1 | 17.433 | 16.534 | 1.034 | 1.107 | pass |
| repeat / ARM64 | 3:199 | 7.412 | 6.503 | 2.683 | 2.659 | pass |
| repeat / ARM64 | 3:1999 | 3.501 | 3.148 | 2.858 | 2.905 | pass |
| repeat / ARM64 | 33:199 | 7.476 | 8.088 | 1.406 | 1.394 | pass |
| repeat / ARM64 | 129:199 | 7.194 | 8.271 | 1.189 | 1.187 | pass |

## Storage and compilation costs

For `129:199`, every host/run records 200 managed requests per solve with full
output and 199 with the checksum, zero reference-count increments and zero
retained managed bytes. Peak charged managed storage is 4,352 / 2,560 bytes.
These figures exclude static input arrays, text-buffer capacity, runtime metadata
and C library allocations. Separate text-lifetime controls check buffer cleanup.
C/Rust buffer observations cover two 129-element F64 buffers: 2,064 bytes.
The memory scopes differ, so these are not interchangeable total-memory figures.

The repeat records 121 build commands per host. AMD64 takes 17.99 seconds total
wall time, with a longest command of 0.500 seconds; ARM64 takes 27.36 seconds,
longest 0.747 seconds. These are harness/compiler commands in this experiment,
not a clean build of the Rust compiler itself. Host scheduling affects wall time.
An earlier ARM64 run exceeded the former 60-second compiler deadline before its
largest timing input. Its failed C was identical to a successful source. The
repair records diagnostics and uses explicit 180-second build and 60-second
execution deadlines; it also kills compiler children on timeout.

The [array report](array-text.md#startup-stack-repair) explains the Clang frame
issue found during binary review. The new repair needs its own six-host evidence.
Fewer requests and these repeated observations do not complete the performance
roadmap; output formatting and smaller-case checksum costs remain substantial.
