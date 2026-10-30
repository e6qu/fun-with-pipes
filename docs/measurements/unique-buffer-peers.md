# Buffer costs compared with C and Rust

This report retains the original baseline and scalar-fold experiment. The
[current full-buffer comparison](buffer-current.md) uses the repaired waiting
method and the newer compiler; its failed controls also remain explicit.

Four native sessions at `fadebf713e0854d6d132fc6e3666f275b214fc17` retain
131,328 ordinary process observations and 288 separate peak-memory observations.
All outputs, files and reconstructed summaries pass their audits. **Only 13 of 48
case/session combinations meet the declared 2% identical-copy control.** The other
35 are descriptive observations, not evidence of a stable speed advantage.

The 4,096-element scan passes all four sessions' controls. fwp takes **10.1–14.4×
C's elapsed time** and **8.0–9.8× Rust's** for this workload. This is a concrete
remaining gap after GC removal; it does not identify the responsible instructions.
No optimization is accepted by this baseline report. D2/N1's failures are unchanged.

## What the programs do

Each function receives one signed length. Negative lengths produce an empty array.
For a positive length `n`, it constructs the integers `0` through `n - 1`, uses
them as below, and releases the array. Integer calculations remain checked.
A **borrow** lets a function read a value without creating another owner.

| Entry | Work after construction | Result for length 4 |
|---|---|---|
| `unique` | Borrow the array to read its length and first element, then read the length again | `8` |
| `callback` | Pass the array to a known borrowing function that reads length and first element | `4` |
| `scan` | Add every element using a left fold, starting at zero | `6` (`0 + 1 + 2 + 3`) |

The first element is zero; both borrowed reads handle an empty array explicitly.
A fold repeatedly combines the current total with the next element. fwp's scan is
`flip array.generate id | array.fold add 0`: `flip` swaps the first two arguments so `id` can be bound as the
generator before the pipe supplies the length. `id` returns each index unchanged;
the second pipe then sums the generated array. The scan is appended to a copy of the frozen
[unique-buffer fixture](../../tests/fixtures/unique_buffer_costs.fwp).

The [C peer](../../tests/fixtures/unique_buffer_peer.c) and
[Rust peer](../../tests/fixtures/unique_buffer_peer.rs) perform the same checked
work. Each entry is selected at compilation. At runtime every call checks its
result and contributes to a checked checksum, printed once before exit. C inline
assembly and Rust `black_box` make each call's argument/result opaque; they do not
force allocation or prevent optimization inside the operation. Compiler-eliminated
work must not be counted as executed work.

## Hosts, builds and collection

| Host | CPU / available CPUs | C compiler | Rust |
|---|---|---|---|
| Linux ARM64 | Neoverse-N2 / 4 | GCC 13.3.0, Ubuntu `6ubuntu2~24.04.1` | 1.99.1 (`58cf8f9c3`) |
| Linux AMD64 | AMD EPYC 7763 / 4 | GCC 15.2.0, Ubuntu `16ubuntu1` | Same |

C uses GNU C11, O2, no fast math, no floating-point contraction, no link-time
optimization and compiler stack reports. Rust uses optimization level 2, checked
overflow, 16 code-generation units, no crate debug information, unwinding panics
and no link-time optimization. Targets are `armv8-a`/Rust `generic`, and `x86-64`
for both AMD64 compilers. Exact commands, versions, generated C and executables
are retained. Each language's control is a byte-identical executable with the
same filename length. No earlier fwp compiler is needed to build the language.

| Length | Calls per fresh process | Elements constructed if retained by optimization |
|---|---|---|
| 0 | 65,536 | 0 |
| 16 | 65,536 | 1,048,576 |
| 4,096 | 256 | 1,048,576 |
| 262,144 | 4 | 1,048,576 |

Order is unique, callback, scan; lengths follow the table. Six labels (three
languages and their copies) use seed 20261030, two warmup rounds and 36 measured
rounds, with twelve fresh processes per label/round. Every label occupies every
position equally. Each ordered preceding/following pair occurs 71 times within
rounds; transitions between rounds are retained but not claimed balanced. Each
case/session has 432 measured processes per label. No count was increased after
observing results, and no numerical failure was retried.

Elapsed time starts before spawning and ends after collecting output and exit
status: it includes launch/capture costs, startup, argument parsing, checked work,
output and cleanup. Compilation and artifact writes are outside the timer. Child
user/system CPU uses serial `RUSAGE_CHILDREN` differences and excludes the Python
parent. One child runs at a time, unpinned across the four qualified CPUs, with a
45-second deadline and exactly `PATH=/usr/bin:/bin`, `LANG=C`, `LC_ALL=C`, `TZ=UTC`.
Timeout, cancellation, spawn failure or changed output stops collection and keeps
the attempted record. Separate GNU `time` runs measure maximum resident KiB.

The statistic is the median of the 36 complete round totals. The tables divide
that median by twelve to express milliseconds per process. Ranges below span the
two session medians; they are **not confidence intervals**. A copy control passes
only when `max(copy/original, original/copy) <= 1.02` for all three languages.
A passing collection/verifier does not override a failed timing control.

## Elapsed results

Each row keeps both sessions, including failed controls. `fwp/C` and `fwp/Rust`
are elapsed-time ratios: 2 means fwp takes twice as long. “Controls” lists passing
sessions; a dash means neither. Only `scan / 4,096` passes on both architectures
in both sessions. Full per-session ratios and CPU medians are in the
[artifact index](buffer-baseline-artifacts-2026-10-30.json).

### ARM64

| Entry / length | C ms | Rust ms | fwp ms | fwp/C | fwp/Rust | Controls |
|---|---|---|---|---|---|---|
| unique / 0 | 0.920–0.938 | 1.131–1.182 | 1.769–1.888 | 1.92–2.01 | 1.56–1.60 | — |
| unique / 16 | 1.824–1.949 | 3.003–3.106 | 2.109–2.293 | 1.16–1.18 | 0.70–0.74 | — |
| unique / 4096 | 1.072–1.074 | 1.574–1.622 | 1.501–1.556 | 1.40–1.45 | 0.95–0.96 | — |
| unique / 262144 | 2.479–2.582 | 3.074–3.102 | 2.160–2.357 | 0.87–0.91 | 0.70–0.76 | — |
| callback / 0 | 0.868–0.975 | 1.075–1.204 | 1.646–1.788 | 1.83–1.90 | 1.49–1.53 | 2 |
| callback / 16 | 1.768–1.893 | 2.988–3.062 | 2.097–2.264 | 1.19–1.20 | 0.70–0.74 | 1 |
| callback / 4096 | 1.072–1.268 | 1.589–1.865 | 1.449–1.732 | 1.35–1.37 | 0.91–0.93 | — |
| callback / 262144 | 2.403–2.733 | 2.963–3.262 | 2.175–2.457 | 0.90–0.91 | 0.73–0.75 | — |
| scan / 0 | 0.852–0.955 | 1.138–1.313 | 2.475–2.602 | 2.73–2.91 | 1.98–2.18 | — |
| scan / 16 | 2.118–2.196 | 3.144–3.229 | 17.069–17.153 | 7.81–8.06 | 5.31–5.43 | 1, 2 |
| scan / 4096 | 1.460–1.553 | 1.869–1.974 | 15.537–15.692 | 10.10–10.64 | 7.95–8.31 | 1, 2 |
| scan / 262144 | 2.879–3.041 | 3.262–3.419 | 16.472–16.694 | 5.49–5.72 | 4.88–5.05 | 1, 2 |

### AMD64

| Entry / length | C ms | Rust ms | fwp ms | fwp/C | fwp/Rust | Controls |
|---|---|---|---|---|---|---|
| unique / 0 | 1.082–1.106 | 1.631–1.727 | 1.934–1.956 | 1.77–1.79 | 1.12–1.20 | — |
| unique / 16 | 1.365–1.429 | 2.886–2.892 | 2.056–2.419 | 1.51–1.69 | 0.71–0.84 | — |
| unique / 4096 | 0.970–1.058 | 1.742–1.808 | 1.773–1.787 | 1.69–1.83 | 0.99–1.02 | — |
| unique / 262144 | 2.796–2.948 | 3.848–4.047 | 2.624–2.652 | 0.89–0.95 | 0.65–0.69 | — |
| callback / 0 | 1.062–1.118 | 1.678–1.689 | 1.979–2.023 | 1.77–1.91 | 1.17–1.21 | — |
| callback / 16 | 1.369–1.426 | 2.926–3.009 | 2.023–2.051 | 1.44–1.48 | 0.68–0.69 | — |
| callback / 4096 | 1.063–1.074 | 1.743–1.775 | 1.693–1.709 | 1.59–1.59 | 0.96–0.97 | — |
| callback / 262144 | 2.851–2.919 | 3.847–3.906 | 2.652–2.988 | 0.93–1.02 | 0.68–0.78 | — |
| scan / 0 | 1.097–1.205 | 1.749–1.805 | 2.473–2.515 | 2.05–2.29 | 1.37–1.44 | 2 |
| scan / 16 | 1.786–1.884 | 2.864–2.977 | 22.504–22.593 | 11.99–12.60 | 7.59–7.86 | 1 |
| scan / 4096 | 1.355–1.470 | 1.997–2.109 | 19.547–19.822 | 13.48–14.42 | 9.40–9.79 | 1, 2 |
| scan / 262144 | 3.109–3.305 | 3.825–4.038 | 21.109–21.443 | 6.49–6.79 | 5.31–5.52 | 2 |

The worst copy discrepancy is about 15.2%, despite byte-identical programs.
The source of the instability in the short cases is not established. Do not
attribute it to allocation, instruction layout or scheduling without a controlled
experiment. Those rows cannot set a speed budget until their measurement is repaired.
The stable scan case takes 15.537–15.692 ms in fwp on ARM64 and 19.547–19.822 ms on
AMD64; C takes 1.460–1.553 and 1.355–1.470 ms, respectively.

## Allocation and ownership observations

These are **separate instrumented programs**, not ordinary timing executables.
For each nonempty call, C/Rust request `8 × length` payload bytes; fwp requests
those bytes plus an eight-byte array header. At length 4,096, all three request one
allocation per call: 32,768 bytes for C/Rust, 32,776 for fwp. Peak live requested
bytes equal those amounts. Every call ends with zero live payload. These are
requested sizes, not malloc header size or OS memory returned by `free`.

Unique/callback fwp performs no counted-owner operations and requests no count
slots in these diagnostics. Across three scan calls, fwp records:

- Three effective owner creations and three effective final releases.
- 12,288 retain-helper entries and 12,288 release-helper entries that change no count.
- One requested count byte still cached after the calls; zero live array payload.

These observations point to work worth investigating. Instrumentation can prevent
ordinary optimization, so they do not prove that all these helper calls survive
in the measured program or explain its timing gap. Per-site records are retained.
The 40-byte chunk-header layout and eight-byte count pointer are recorded separately;
they are not charged once per element or claimed to be the full allocator cost.
General libc/Rust allocator bookkeeping is not isolated by these observers.

## Process memory and virtual reservations

GNU `time` runs of the ordinary 4,096-element scan report these peak resident ranges
across two sessions and both identical copies. Each process performs 256 calls.

| Host | C KiB | Rust KiB | fwp KiB |
|---|---|---|---|
| ARM64 | 1,372–1,384 | 1,796–1,872 | 1,396–1,664 |
| AMD64 | 1,704–1,844 | 2,172–2,232 | 2,072–2,332 |

Resident memory includes startup and mapped libraries; it is not the same as live
payload. In separate one-call diagnostic processes, `/proc/self/status` supplies
virtual size and `/proc/self/smaps_rollup` supplies resident, proportional,
anonymous, swap and HugeTLB KiB at entry, construction, release, return and exit.
The two kernel files are not an atomic snapshot. Observer code, its 8 KiB stack
buffer and I/O affect the process. [Kernel documentation](https://www.kernel.org/doc/html/v6.15/filesystems/proc.html)
explains why HugeTLB fields are separate from ordinary resident/proportional totals.

At construction, fwp reports about **65.1 GiB of virtual address space**, but about
1.5–1.9 MiB resident in the 4,096-element scan. The source reserves a 64 GiB heap
address range plus metadata ([heap initialization](../../runtime/fwp_rt_heap.c));
the generated native entry also requests a 1 GiB worker-stack reservation
([C emission](../../src/cgen.rs)). These are not 65 GiB of physically occupied RAM.
Returning an array's storage need not return pages immediately to the OS. The large
virtual reservation remains a separate cost; GC removal does not remove it.

## Code and stack costs

These are ordinary scan executables from session 1; session 2 reports the same
sizes. Files are unstripped. Rust links prebuilt standard-library code and retains
about 4.1 MB of debug sections from those libraries even with crate `debuginfo=0`;
C/fwp use external libc. Whole-file sizes therefore compare different linking and
metadata boundaries and are not an intrinsic language-size ranking.

| Host / language | Whole file bytes | `.text` bytes | Largest reported frame bytes |
|---|---|---|---|
| ARM64 / c | 70,864 | 1,064 | 80 (static) |
| ARM64 / rust | 4,628,144 | 224,540 | 224 (compiler remark) |
| ARM64 / fwp | 76,144 | 16,780 | 592 (static) |
| AMD64 / c | 16,432 | 1,020 | 80 (static) |
| AMD64 / rust | 4,552,184 | 247,971 | 200 (compiler remark) |
| AMD64 / fwp | 46,176 | 18,162 | 576 (dynamic) |

C's `.su` records and Rust 1.99.1's `prolog-epilog` remarks describe frames from
compiled sources, excluding prebuilt libraries. Rust's separate reporting build
must have the same `.text` bytes as its ordinary executable. Dynamic C frame
entries remain dynamic: their reported number is not a total stack upper bound.
None of these maxima measures simultaneously active calls or all target-specific
space outside the adjusted frame. No stack-saving claim follows from them alone.

## Verification, failures and reproduction

Focused source `6eca1176`, run `41102080961`, passes on both architectures with
complete log/artifact audits. Each host verifies 420 C/Rust argument/result cases,
42 raw/optimized interpreter comparisons, 84 native O1/O2 executions, 90 phase
cases with 180 damaged-result controls, 90 storage cases including 18 intentional
leaks, 38 memory-parser controls, 72 Linux memory executions, compiler frames and
nine numerical-consumer result sets. Six timer helpers pass 48 failure/success
controls. Real subprocess tests cover timeout, cancellation and spawn failure.
Eleven rehashed damaged-evidence controls reject incomplete or false records;
synthetic observations cannot validate as observed measurements.

Earlier runs remain failed and retained:

| Run / source | Failure | Repair |
|---|---|---|
| `41097911057` / `230b1e54` | Linux values contain tabs; Rust's LLVM section option emits no stack records | Accept horizontal whitespace before strict decimal values; use stable compiler remarks |
| `41100000646` / `2acbfb41` | objcopy rewrites its input without an output; a late C object leaves an ARM64 stack-guard dependency unresolved | Supply an explicit inspection output and verify inputs unchanged; link C through native static archives before system libraries |

The late-object fix covers both numerical-output callers too, with untimed result
and cleanup checks. Stack protection remains enabled. No old numerical benchmark
was rerun. [Objcopy's file rules](https://sourceware.org/binutils/docs/binutils/objcopy.html)
and [Rust's native library option](https://doc.rust-lang.org/rustc/command-line-arguments.html#-l-link-the-generated-crate-to-a-native-library)
explain the command-level repairs. All earlier passing and failing evidence is kept.

The [artifact index](buffer-baseline-artifacts-2026-10-30.json) records run/job/artifact
IDs, archive hashes, exact hosts and every per-session result. In each downloaded
artifact, `observed/` contains a manifest, all raw observations, binaries, generated
sources and compiler reports. Reconstruct it with the matching source's
`check-buffer-baselines.py --input observed --source REVISION --machine ARCH
--session NUMBER --origin observed --wait-policy timed-polling` (current verifier).
The verifier checks every file and exact build
settings, then recomputes summaries from the complete ordered records.

## Next accepted workload and budget

Only the **4,096-element scan, 256 calls/process** currently has passing controls
in all four sessions. Before selecting an optimization, freeze this budget:

| Requirement | Candidate acceptance |
|---|---|
| Correctness | Preserve checked arithmetic, callback/trap order, aliasing, cancellation and cleanup; raw interpreter, optimized interpreter and native O1/O2 agree |
| Elapsed time | At least 10% less than unchanged fwp in every paired session; no C/Rust parity claim follows |
| Copy controls | Maximum/minimum median within each identical-code family at most 1.02; a failure is inconclusive, never a retry |
| Payload and counts | At most one payload request and 32,776 requested/peak live bytes per call; zero final payload; no increase above one cached count byte |
| Code | At most 5% `.text` growth versus matched unchanged fwp on each architecture |
| Stack | No larger compiler-reported fixed frame component or new dynamic stack requirement; preserve scope/cleanup proofs, without inventing a whole-stack bound |

The 10% target is over six times the largest copy discrepancy (about 1.62%) in
this accepted case, and tests a meaningful reduction in its large remaining gap.
It is a workload-specific target, not a universal performance rule.

A candidate comparison keeps two independent sessions per architecture, length
4,096, 256 calls/process, two warmup rounds, 36 measured rounds, twelve processes
per label and seed 20261030. Its six equal-length executable labels are three
byte-identical unchanged copies and three byte-identical candidate copies. Use
the same balanced position/predecessor schedule. Compare medians of each round's
family totals; retain all individual copies and require their control limit.
Compiler flags, host qualification, environment and ordinary/diagnostic separation
stay fixed. The original comparison results follow. The 35 failed baseline
combinations remain open measurement work.

## Scalar folds: cost reductions retained, timing acceptance open

The scan calls `array.fold add 0`. Previously, each element went through the
runtime's general function-call dispatcher even though `add` and both numeric
argument types were known. The candidate emits a loop calling that existing
numeric entry directly. It preserves the initial-value/input evaluation order,
left-to-right folding and the caller's array cleanup. Captured or unknown
callbacks, nonnumeric values and F128 retain their existing implementation.

The first native checks at `89fda951` pass buffer results, overflow order and
failure cleanup. Both hosts expose one faulty test assumption: a callback called
“unknown” was statically known and its function was inlined away. The repaired
fixture selects its callback through input and checks the generic dispatch body.
The repaired tests pass on both native GCC hosts. Additional view, mixed-element
and cancellation controls pass at `4b5c49ce`; raw/optimized interpretation and
native O1/O2 agree. Final production-platform gates remain required.

For three 4,096-element calls, diagnostics remove 12,288 ineffective duplicate
and release entries each. Payload remains three requests, 98,328 requested bytes,
32,776 peak bytes and zero final bytes; one cached count byte remains. `.text`
shrinks from 16,780 to 10,588 bytes on ARM and 18,162 to 11,090 on AMD. Largest
reported frame components shrink from 592/576 to 368/320 bytes. The existing AMD
bounded dynamic reporting frame remains; there is no new dynamic frame.

The paired experiment uses `scan-comparison.py collect` and its independent
`check` command. It verifies the reference binaries from session 1 by hash and
rechecks both build records and all 2,736 ordered process observations. Three
identical copies per implementation share the existing six-label schedule.
Synthetic evidence tests check balance and retain slow/noisy results; the repaired
protocol also rejects a changed waiting method. These controls do not establish
candidate performance.

Three sessions at `8c8c6363` completed with all 2,736 attempts and independently
audited native, storage, build and timing records:

| Host / session | New/old elapsed ratio | Old-copy spread | New-copy spread | Timing decision |
|---|---:|---:|---:|---|
| ARM64 / 1 | 0.242776 | 0.165% | 0.670% | Pass |
| ARM64 / 2 | 0.239186 | 0.144% | 1.319% | Pass |
| AMD64 / 1 | 0.150563 | 0.921% | 3.881% | Inconclusive: exceeds 2% |

Spread is `(largest copy median / smallest copy median - 1) × 100`. The elapsed
ratio compares median round totals for the three-copy families; it is not a
C/Rust comparison. Both AMD session-2 attempts received EPYC 9V45 instead of
the required EPYC 7763 and stopped before building or timing. They supply no
performance observations. The [paired artifact index](scalar-fold-artifacts-2026-10-30.json)
retains all three measured sessions and both host rejections.

The user accepted the verified dispatch/count-call and code-size reductions,
leaving timing acceptance open. Neither the failed control nor the missing fourth
session becomes a pass. The compiler/runtime are unchanged by the waiting repair
below, and all published limits remain in force.

## Waiting repair, declared before new measurements

The original Python harness calls `communicate(timeout=...)`. On POSIX, once
output closes, CPython's timed process wait can poll with increasing sleeps.
Those sleeps fall inside our whole-process timer. A deterministic synthetic
child that closes output before exiting reproduces 1 ms and 2 ms sleeps with
the original method. [CPython 3.14.4's implementation](https://github.com/python/cpython/blob/v3.14.4/Lib/subprocess.py#L1879-L1916)
matches the version recorded in these sessions. This proves avoidable harness
delay; it does not prove that it explains every failed timing control.

`scripts/process_wait.py` uses a blocking captured wait with a POSIX alarm
deadline. It requires serial execution in the main thread and an unused,
unblocked alarm; it restores the prior handler and signal mask. Windows retains
its kernel-backed timeout. Timeout and cancellation still kill/reap the child,
and failed compiler builds stop their descendants. Lifecycle tests reject an
injected timed-wait call and verify that this rejection also reaps the child.
They do not assume every Python version polls: [CPython 3.15](https://github.com/python/cpython/blob/v3.15.0/Lib/subprocess.py)
can use kernel waits. The initial negative control made that assumption and
hung on the macOS runner after its deadline, because its context manager waited
for an unreleased child. The repaired control uses the tested kill/reap path;
CI reports the Python version and bounds the standalone check to two minutes.

The declared repair runs two new independent sessions per architecture with **only this waiting
method changed**: the same reference and candidate compiler behavior, native
toolchains, inputs, counts, balanced order, environment, timing boundary and
acceptance limits. Whole-process timing still includes spawn and cleanup. New
configuration records name `waitPolicy=posix-alarm`; the verifier requires explicit
`--wait-policy posix-alarm`. Original archives stay unchanged and are checked with
`--wait-policy timed-polling`. Do not combine samples across these protocols or
repeat a measured failed control. A new failure remains inconclusive.

### Repaired comparison results

All four sessions at `df23cbcb` are complete and independently audited. Each
archive retains 212 files, 2,736 ordinary attempts, all native/build records,
and the separate storage controls. Both O1/O2 storage observations and all code/
reported-frame budgets pass. The candidate compiler/runtime and benchmark inputs
are unchanged from the original paired source.

| Host / session | New/old elapsed ratio | Old-copy spread | New-copy spread | Timing decision |
|---|---:|---:|---:|---|
| ARM64 / 1 | 0.220954 | 0.184% | 0.266% | Pass |
| ARM64 / 2 | 0.232689 | 0.018% | 0.310% | Pass |
| AMD64 / 1 | 0.151352 | 1.122% | 1.770% | Pass |
| AMD64 / 2 | 0.150930 | 0.873% | 2.040% | Inconclusive: exceeds 2% |

The failed ratio is **1.0203993797184912**, above **1.02**; rounding does not make
it a pass. The [repaired artifact index](scalar-fold-wait-repair-artifacts-2026-10-30.json)
retains every session. The polling defect is repaired, but this experiment does
not resolve all variation. **Timing acceptance remains open**, with verified
cost reductions retained as agreed. Do not rerun this unchanged experiment,
increase counts or loosen the limit. D2/N1 and the other buffer cases retain
their separate incomplete measurements; this result does not accept them.
