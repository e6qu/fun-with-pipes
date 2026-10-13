# Session handoff

Updated 2026-10-13. The user authorized all six remaining directions in
[PLAN](../PLAN.md) as one combined PR, including Windows ARM64/AMD64 and real
half/quad formats. Branch: `ownership-formats-windows`, [draft PR #134](https://github.com/e6qu/fun-with-pipes/pull/134). Publication, fixes and
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
at `fb199e7`. File-specific shared headers and cyclic graphs remain outstanding.

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

Windows Rust APIs now use native socket handles/WSAPoll and owned Windows/POSIX
libraries for FFI, TLS and OpenCL. Both native architectures passed all-target
compilation, actual TCP readiness/EOF and DLL load/call/unload tests, and compiler
linking at `fb199e7`. Full interpreter goldens at `277bf4a` in
[38441636861](https://github.com/e6qu/fun-with-pipes/actions/runs/38441636861)
failed: checkout CRLF changed expected output bytes; OS error wording differed;
the Unix signal fixture assumed Unix process status; forcing raw mode conflicted
with goldens for optimized deep recursion/preemption. Prepared fixes enforce LF
text checkout, normalize known Windows I/O errors, retain Unix signal coverage
in a Unix-specific raw/native test, and use normal optimizer settings for the
full golden harness. Explicit raw/native semantic controls remain required.
Generated C exit status is now explicitly modulo 256 on every OS. Windows full
interpreter goldens need rerunning; generated C runtime and PE packaging remain
unported. Native LLVM-MinGW UCRT toolchains are pinned by asset SHA-256.

The exact-format bootstrap vendors the selected BSD-licensed Berkeley SoftFloat
3e binary16/binary128 core. Cargo builds the same C source exposed for native
and actual wasm32 tests; binary packages include both project and vendor
licenses. Local bit-level controls pass for 113-bit precision, ties-even,
subnormals, canonical arithmetic NaNs, raw payload preservation and direct
quad-to-half narrowing without double rounding. CI must validate the Rust/C ABI
on all six platforms and WASM. This core alone changes no language representation:
F16/BF16 still lower to F32 and F128 to F64. BF16, exact decimal text/literals,
transcendentals, descriptors/arrays/ABI and versioned protocol migration remain.

Local checks passed under `python3 scripts/local-guard.py`: `cargo fmt --all`,
`cargo check --lib`, `cargo clippy --lib --test cli --test softfloat_core -- -D
warnings`, and `python3 /private/tmp/fwp-test-softfloat-core.py` (four standalone
arithmetic tests linked against the actual built C core). Earlier extracted
non-GC allocator ASan/UBSan probe and roadmap audit passed. Full builds, suites,
benchmarks and large regeneration stay on GitHub runners. Do not use the stale
local fwp executable as an oracle. Preserve disk/RSS/CPU/deadline limits.
Production CI defers draft PRs; skipped jobs are not acceptance. Focused suites
are `windows`, `portability`, `wasm` and `iteration` in `numerics.yml`.

## Next action

Next: publish the Windows golden fixes and exact-format core; run `windows`,
`portability` and `wasm`, fixing all failures. Then continue generated C Windows
runtime/resources and PE packages, actual floating representations/text/protocol,
broader ownership/worker proofs, and nested reverse mode/checkpointing with
measured layout improvements. Item 4 remains pending. All six acceptance rows
in PLAN remain required in this same PR. Require full Linux/macOS and added
Windows acceptance plus docs on the final head before squash merge.
