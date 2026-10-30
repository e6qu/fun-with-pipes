# Unique buffer compared with C and Rust

This is the next B1 comparison, in preparation. No timings have been collected
and no speed or memory-parity claim is accepted by this document. The existing
[A5 result](unique-array-storage.md) establishes removed count operations, not
execution time relative to another language.

## Work that must match

Use the existing [buffer fixture](../../tests/fixtures/unique_buffer_costs.fwp).
`unique(n)` constructs the integers from zero through `n - 1`, passes the array
to a borrowing helper, reads its length again, and releases it. The helper adds
the length to the first element, or zero for an empty array. For nonnegative `n`, the result is `2*n`. Negative lengths produce an
empty array and result zero, matching `array.generate`.
`callback(n)` uses the known `read` callback and returns `max(n, 0)`. Both inputs are
runtime lengths; neither entry may return or retain the array. A third entry,
`scan(n)`, constructs the same array and adds every element with checked arithmetic.
Its result is `m*(m-1)/2`, where `m = max(n, 0)`. The harness appends this entry
to a copy of the original fixture, preserving the frozen A5 fixture. Current fwp
emission gives this full-read control ordinary counted storage. It is not evidence
that A5 already supports arbitrary folds.

Write C and Rust versions with the same sequence: allocate one integer buffer,
initialize every element, borrow it for those reads, then release it. Use checked
integer arithmetic. Empty Rust buffers may need no allocation; fwp still needs
its array representation. Report that difference. Let each production compiler
optimize its source normally. If a compiler eliminates the buffer or a read,
report that result rather than adding a hidden barrier to force allocation.

Keep the shared-array and unknown-callback ownership tests as correctness
controls. They must continue to reject the unique representation; they are not
silently substituted for the known-callback timing workload.

The three C/Rust peers pass 420 Clang/Rust O1/O2 checks through
`scripts/check-unique-buffer-peers.py`: exact outputs,
negative/empty lengths, repeated calls, oversized allocation rejection and invalid
arguments. These are local peer checks, not GCC validation.
The fwp harness also passes 42 raw/optimized interpreter comparisons and 84 native
Clang O1/O2 executions at the same seven lengths, including the two negative
cases. It replaces only the CLI call and preserves production startup/cleanup.
The first harness check incorrectly counted proof markers in all exported
functions; the repaired check inspects the selected entry: one marker for the
restricted examples, none for the counted scan. Each executable selects its entry
at compilation (`BUFFER_ENTRY` for C, `buffer_entry` for Rust); no extra runtime
mode branch is added to the peers.

These checks use the verified macOS ARM64 package from source `570b777a`, artifact
`12986056870`; compiler SHA-256
`f5aa27bedfc8701a17b1c40722bc218a1a376f2fe28679bbe9393244e5951282`.
Compiler/runtime/library/build inputs match this preparation branch exactly.
This avoids a local compiler build; it is not a dependency on an older fwp API.
The harness makes each call's input and result opaque to the compiler, using C
inline assembly and Rust `black_box`; neither prevents optimization inside the
buffer operation. Their overhead belongs in the eventual timing scope.

## Implementation tasks before measurement

1. Add C/Rust peers and compare results at lengths 0, 16, 4,096 and 262,144.
   Verify raw/optimized fwp and native O1/O2 results. Check negative lengths, malformed arguments and
   allocation failure separately from timing; preserve the existing recovery,
   cancellation and physical-free controls. Save all sources and build commands.
2. Add explicit repeated-call harnesses for each language. Pass length and repeat
   count at runtime, validate every result and return an aggregate checksum.
   Keep compiler-visible work comparable; explain any barrier needed to prevent
   the harness itself from dropping calls. Use ordinary binaries for timing.
3. In separate diagnostic binaries, attribute construction, borrowed reads and
   destruction, and count payload allocations, allocator metadata and ownership
   operations. Require zero live payload after every call and after shutdown.
   Deliberately omitted frees/count operations must fail the appropriate check.
   Instrumented timings cannot stand in for production timings.
4. Record whole-process elapsed/CPU time, maximum resident memory, executable/code
   sizes, and compiler stack reports. At declared checkpoints record process
   virtual and resident storage separately from requested payload and allocator
   metadata. Do not relabel virtual size or requested bytes as committed memory.
   Identify any memory or Rust stack field the available tools cannot establish.
5. Publish the complete execution schedule, repeat counts, host/toolchain rules,
   identical-copy controls, statistic and treatment of unstable observations
   before starting the four sessions: two each on Linux ARM64 and AMD64.
   Every measured language needs its own identical-copy control. Keep all raw
   outputs, durations and failed observations, and independently reconstruct the
   report. Set later optimization budgets from these baseline results.

The peer programs and repeated-call harness pass the focused checks above.
Phase and allocation observers also pass the focused checks below.
The next action is native GCC verification, process-memory checkpoints, and the
runner plus independent evidence verifier before collecting the four sessions. This preparation does not authorize an unchanged numerical rerun,
change D2/N1 limits, or complete the other B1 comparisons.

## Baseline schedule

Use two independent sessions on each of the existing qualified Linux ARM64 and
AMD64 hosts. Each of the three entries has four length/call-count cases: 0/65,536,
16/65,536, 4,096/256 and 262,144/4. Each nonempty case therefore initializes
1,048,576 elements per process if construction remains in the optimized program.
Do not hide compiler-eliminated construction or count it as executed work.

Every language has a byte-identical executable copy: six labels in all. Use seed
20261030, two unmeasured warmup rounds, then 36 measured rounds with twelve fresh
processes per label per round. `unique-buffer-baselines.py` fixes the ordering.
Each label occupies every process position equally; every ordered predecessor
pair, including a label following itself, occurs 71 times within rounds. Record
between-round transitions too; those are not claimed to be balanced. This gives
432 measured processes per label per case per session, with every observation
retained. Do not increase counts after seeing a result.

Report median complete round totals, all three identical-copy ratios and both
fwp/peer ratios for each case and session. Whole-child timings include startup,
argument parsing, repeated calls, checksum checks, output and process cleanup.
Compilation and artifact writes are outside that timer. Separate diagnostic
programs own the construction/read/release and storage observations. Their
measurements cannot replace the ordinary binaries' timings.

These are descriptive baselines. Derive and publish workload-specific future
change budgets from the repeated observations before selecting an optimization.
An unstable copy control stays explicit and cannot establish a speed improvement.
D2/N1's existing failures and limits are unchanged. Collection still requires
the remaining process-memory observations, runner, evidence verifier and native GCC
checks; no baseline session has run.


## Diagnostic checks implemented

Separate phase programs put clocks around construction, reads, release and any
remaining arithmetic. fwp's last addition can occur after freeing the array;
`tailNs` records it rather than incorrectly charging it to the read phase. Clock
calls and observer output change execution costs. These programs explain statement
boundaries; they cannot establish an ordinary-program speedup. Clang/Rust O1/O2
checks pass 72 executions with 216 phase records and reject 144 damaged results.
The C clock joins the existing success/failure checks: all six helpers pass 48
executions, including failed reads with untouched timestamps and omitted guards.

Separate storage programs observe C allocation/free calls and Rust's system
allocator requests only while the buffer operation is active. fwp reuses the
existing managed-allocation, ownership-site and count-metadata observers. Each
call must restore its starting live-buffer charge. All 72 focused executions
pass, including 18 deliberately omitted releases that exit 225. The C/Rust
observers report requested bytes; fwp additionally reports size-class charges
and cached count bytes. None of these fields proves that libc or the OS returned
pages after a free. OS resident/virtual checkpoints and ordinary-program memory
observations remain to be implemented.

The current local checks use Clang on macOS ARM64. `buffer-peer-checks` in the
numerical evidence workflow builds the current compiler and runs the same
controls with GCC on both Linux architectures. It retains original/generated
sources, diagnostic executables and every captured command result, including
partial failures. This focused workflow does not run baseline timings or replace
final-head production validation.


## Focused GCC evidence

Run `41090130137` passes on both native Linux architectures at
`44e7724d2114f4f4799348cf98684f55b6a4b635`. ARM job `124181555909`
retains artifact `12992943369`; AMD job `124181555372` retains `12993378149`.
Both complete logs have no errors or warnings. Each archive has 107 files and
60 native executables; headers match the host architecture. Audits checked all
136 native, 90 phase and 108 storage command records, including all 18 expected
leak failures. Peer argument checks retain their summary in this first run;
the checker now requires an explicit output directory and retains all 432 build/
execution records, both input sources and twelve executables for subsequent runs.

For three 4,096-element calls, the fwp allocation observer records three requests
and 98,328 requested bytes for each entry, with zero final live charge. The unique
and known-callback entries have no ownership-helper entries or count metadata.
The scan has 12,288 ineffective retain entries and 12,288 ineffective release
entries, plus the three array owners' effective operations. Its one count byte
remains cached for reuse. These are instrumented operations; ordinary compilation
may eliminate no-op checks. They do not establish a timing penalty.

## Process memory preparation

The next diagnostic uses one call per process. It records entry to `main`, completed
construction, release, return from the operation and the point before process exit.
For fwp, the last checkpoint follows joining its runtime thread. It is not an
observation after the OS destroys the process, and allocator reservations may
still exist. Rust releases the CLI argument vector before that last checkpoint.

Virtual size comes from `status`; resident, proportional, anonymous, swapped and
HugeTLB storage come from `smaps_rollup`. The two reads are sequential, not one
atomic snapshot. The observer's 8 KiB stack buffer, code and I/O affect these
diagnostic snapshots. Ordinary-program peak resident storage is a separate
measurement. RSS/PSS exclude the separately reported HugeTLB fields, as described
in the [Linux process-memory documentation](https://www.kernel.org/doc/html/v6.15/filesystems/proc.html).
The local parser/compile check is not Linux execution evidence. Actual checkpoint
runs, ordinary peak memory, static stack reports and complete baseline collection
remain required.


## Compiler settings and stack reports

Ordinary programs use GCC O2 and Rust optimization level 2, with link-time
optimization disabled. C uses checked integer operations, `-fno-fast-math` and
`-ffp-contract=off`. Rust explicitly selects checked overflow, 16 code-generation
units, no debug information and unwinding panics. Its maintained checks use the
same settings. These selections are recorded rather than relying on changing
[compiler defaults](https://doc.rust-lang.org/rustc/codegen-options/index.html).
ARM64 uses `armv8-a`/Rust `generic`; AMD64 uses `x86-64` for both compilers.
The baseline hosts remain Neoverse-N2 and AMD EPYC 7763 with the existing exact
GCC/Rust qualification requirements.

C emits per-function `.su` stack reports. Rust 1.99.1 emits final frame sizes
through `-C remark=prolog-epilog`, using the production settings in a separate
build. Its instruction bytes must match the ordinary binary before using the
report. These are [LLVM's compiler-generated frame sizes](https://llvm.org/docs/doxygen/PrologEpilogInserter_8cpp_source.html),
not estimates from disassembly. The parser retains the expected missing-source-location
warning caused by `debuginfo=0` and rejects all other warnings or unknown records.
Reported frames exclude prebuilt libraries and do not establish total active-call
stack usage or all target-specific storage outside the adjusted frame. Dynamic C
frames remain labelled dynamic.

The first builder used `-stack-size-section`, but Rust's explicit target setting
disables that section unless its unstable option is enabled. Both GCC-host runs
therefore returned empty reports, which the checker correctly rejected. The repair
uses stable compiler remarks; it does not change compilers or enable unstable features.

All source files, commands, ordinary/copy binaries, section sizes and raw stack
reports are retained. Each language's copy must be byte-identical. Rust normally
links much of its standard library into its executable; C and fwp use external
libc code. Executable bytes and whole-process memory therefore describe different
boundaries, and the report must state that distinction. The new builder/parser
controls are implemented; native stack-report verification is pending. No timing
session starts before the complete evidence path is verified.

## Focused repair before baseline collection

Run `41097911057` at `230b1e54` failed the memory and stack-report steps on both
architectures. The complete logs and partial artifacts (`12995829431` AMD64,
`12997202090` ARM64) were audited: peer, native, phase, storage and clock checks
passed; both failures are confined to the two new observers. Docs run `41097913940`
passed and its full log was audited. No timing session ran.

Linux's `VmSize` uses a tab after the colon. The parser now accepts spaces and
tabs before the decimal value, while rejecting signed values, wrong units,
duplicates and overflow. Local checks pass 38 parser controls and compile all
18 diagnostic programs with production Rust 1.99.1; Linux execution still needs
native CI. Phase and storage checks now include the largest declared length,
262,144: locally 90 phase executions, 270 events, 180 damaged-record rejections,
and 90 storage executions including 18 intentional leak failures pass.
