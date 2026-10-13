# Session handoff

Updated 2026-10-13. The user authorized all six remaining directions in
[PLAN](../PLAN.md) as one combined PR, including Windows ARM64/AMD64 and real
half/quad formats. Branch: `ownership-formats-windows`, [PR #134](https://github.com/e6qu/fun-with-pipes/pull/134). Publication, fixes and
squash merge after passing final-head CI are authorized. Commit messages have
one line, at most 80 characters, with no body, trailers or attribution.

## Accepted baseline

[PR #133](https://github.com/e6qu/fun-with-pipes/pull/133) merged as
`d14ec10d24765c2686dc4cfb0798012611c02a61`; its tree
`e3d3f8aa5ddee7843fe9e00c85cf0ffb5b2304a0` equals tested head
`70de849771aff10a3af938746c82f9b975bc989b`. All seven
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38423073356),
[four preflight jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38423088702),
[PR docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38423073506) and
[merged docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38435135341)
passed. The squash message is one 60-character line. Old delivery/evidence
branches were removed. Linux/macOS ARM64/AMD64 packages are accepted; no
Windows or true half/quad support is claimed by that baseline.
[History](roadmap-history.md) preserves earlier measurements and source heads.

## Active bundle

| Step | Status | Scope |
|---|---|---|
| 1 | Implemented | Accepted merge recorded; stale seven-step retry instructions replaced by this handoff |
| 2 | In progress | Broader proved ownership, retained/foreign/protocol contexts, cycle policy and WASM reclamation |
| 3 | In progress | Broader producer/worker specialization and reduced boxing/closure allocation |
| 4 | Pending | Measured kernel/layout improvements, nested reverse mode and checkpointing |
| 5 | In progress | Actual F16/BF16/F128 representations and coordinated protocol migration |
| 6 | In progress | Windows ARM64/AMD64 runtime, full native validation and separate packages |

## Implementation and validation

Scalar foreign-C ARC admission uses the actual ABI classifier and rejects
managed strings, pointers and callbacks. Raw/native reclamation controls passed
on all four Linux/macOS targets in [portability 38439707405](https://github.com/e6qu/fun-with-pipes/actions/runs/38439707405)
at `217d6da`. Retained callbacks, protocols and cyclic runtime graphs still need
proofs; this is not general collector-free execution.

WASM allocations use reclaimable libc storage. Typed last-owner destruction
removes count metadata before freeing storage; unproved shared graphs remain
retained. Physical-free observation across 10,000 cycles and 300 aliases, missing
free and disabled-free controls, resource destruction and full actual WASI
goldens passed on both Linux architectures in [38440780537](https://github.com/e6qu/fun-with-pipes/actions/runs/38440780537)
at `fb199e7`. Unproved shared headers and cyclic graphs remain retained.

Direct `iter.iterate` fusion preserves eager lookahead, effect/trap order,
early stopping and owned String captures. Compiler checks, raw/native ownership
regressions and allocation/instruction evidence passed on all four Linux/macOS
targets in [38441649508](https://github.com/e6qu/fun-with-pipes/actions/runs/38441649508)
at `277bf4a`. The 1,000-element probe uses 6 allocation requests versus 8,006
unfused and 4,005 with only consumer fusion; the fused worker has no dynamic
consumer calls, tail calls or state-record construction. All variants retain
the 64-byte CLI baseline. [Permanent measurements](measurements/iterate-producer.json)
record hardware, toolchains, flags, source hashes, memory and process timings;
startup-inclusive timings do not establish a speedup.

Windows Rust APIs use native socket handles/WSAPoll and owned Windows/POSIX
libraries for FFI, TLS and OpenCL. Both native architectures passed all-target
compilation, actual TCP readiness/EOF and DLL load/call/unload tests, compiler
linking, the exact-format Rust/C core and **all interpreter golden outputs and
statuses** in [38444619376](https://github.com/e6qu/fun-with-pipes/actions/runs/38444619376)
at `106e7a2`. LF checkout, common OS errors, the portable child-exit fixture and
normal golden optimizer settings fixed earlier failures. Unix signal behavior
retains a separate explicit raw/native control. Native LLVM-MinGW UCRT toolchains
are pinned by asset SHA-256. This does not yet establish generated C support.

The generated C allocator now has Windows virtual reservation/commit/reset/release,
monotonic timing, working-set accounting and PE writable-section roots for the
image containing the runtime. A focused native test observes actual commitment,
alias counts, reclamation and unload; a missing-image-root control must fail.
The probes, bfloat core and interpreter goldens passed on both native Windows
architectures in [38446144465](https://github.com/e6qu/fun-with-pipes/actions/runs/38446144465)
at `6f7b105`. Compiler/ownership/allocator regressions passed all four Linux/macOS
targets in [38446150831](https://github.com/e6qu/fun-with-pipes/actions/runs/38446150831)
at the same head. Full generated C task contexts, resources/networking and PE
packages remain outstanding. Linux root-range overflow now traps instead of silently losing roots.

File header reclamation now follows proved WASM ownership after stream close,
including count disposal when physical freeing is disabled. Tests observe libc
free without reading dead headers and reject a deliberate omitted-free variant.
Actual WASI resource/free controls, bfloat arithmetic and full goldens passed
on both Linux architectures in [38446752701](https://github.com/e6qu/fun-with-pipes/actions/runs/38446752701)
at `4437af0`. Its explicit LLVM installation fixed the earlier missing-archiver
failure; the superseded queued run was cancelled, not accepted. The old bump-allocator size fixture was
stale after libc allocation replaced the bump allocator; its replacement checks
actual zero-size handling, alignment, zeroed storage, unchanged request sizes
and allocation failure with omitted-check controls under ASan/UBSan.

The exact-format bootstrap vendors the BSD-licensed SoftFloat 3e arithmetic
core and a Lucent-licensed scoped gdtoa decimal core, with provenance hashes,
a patch against upstream and binary license packaging. Binary16/bfloat16/binary128
arithmetic, direct narrowing, ties-even, subnormals and canonical arithmetic NaNs
have bit-level controls. Raw bit constructors preserve payloads. Decimal parsing
rounds directly to the requested format; formatting supplies shortest round-trip
digits. Per-call contexts use 4 KiB stack scratch and release overflow blocks on
success or allocation failure, without thread registries or retained caches.
Three decimal corrections cover subnormal double rounding, normalized exponent
adjustment and an unsigned exponent-bit shift. The new decimal core still needs
runner acceptance; the public language representations remain F16/BF16 as F32
and F128 as F64 until the coordinated migration is implemented and verified.
Transcendentals, literal/value integration, descriptors/arrays/ABI and versioned
protocol migration remain outstanding.

Local checks passed under `python3 scripts/local-guard.py`: formatting, focused
clippy for the affected compiler and integration targets, and standalone core
checks. `python3 /private/tmp/fwp-test-softfloat-core.py` passed 11 tests including
all non-NaN half/bfloat text round-trips, quad bit patterns and boundary goldens,
independent Rust F32/F64 decimal oracles and concurrent conversion scopes.
`python3 /private/tmp/fwp-float-text-check.py` passed the actual shared C core
under ASan/UBSan, allocation-failure controls and an omitted-release leak control.
`python3 /private/tmp/fwp-native-allocator-check.py` passed allocator/image-root
controls. The repository tests preserve these controls for native/WASI CI.
Full builds, suites, benchmarks and large regeneration stay on GitHub runners.
Do not use the stale local fwp executable as an oracle. Preserve disk/RSS/CPU/
deadline limits. PR #134 is now ready for review, so pushes run full production CI. Skipped jobs
are not acceptance; unfinished implementation still prevents merging.

## Next action

Next: validate the CI integration fixes. Decimal runs at `367227a` exposed
Windows MSVC compilation through a MinGW driver without SDK headers
([38449712876](https://github.com/e6qu/fun-with-pipes/actions/runs/38449712876))
and native loader references in the actual WASI Rust test binary
([38449735363](https://github.com/e6qu/fun-with-pipes/actions/runs/38449735363)).
Full CI at `4437af0` also rejected Cargo's new build-script metadata in the
macOS test sharder and found an unused WASM loader variant. Fixes select a
target-specific SDK-aware C compiler, exclude the native loader on WASM with
an explicit unsupported foreign-call diagnostic, and accept build scripts as
Cargo-managed dependencies without removing any test targets. Guarded shard
regressions (3 tests), formatting and library clippy passed locally. All runner
failures remain unresolved until the corrected code passes; the earlier focused
successes are not final-head acceptance.

Then integrate the exact formats with language values/literals,
native arrays/workers and protocol versioning. Continue the generated C Windows
task/resource/network port and PE packaging, broader ownership/worker proofs,
and nested reverse mode/checkpointing with measured layout improvements.
Item 4 remains pending. All six acceptance rows in PLAN remain required in this
same PR. Require full Linux/macOS and added Windows acceptance plus docs on the
final head before squash merge.
