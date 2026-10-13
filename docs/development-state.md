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
| 3 | Pending | Broader producer/worker specialization and reduced boxing/closure allocation |
| 4 | Pending | Measured kernel/layout improvements, nested reverse mode and checkpointing |
| 5 | Pending | Actual F16/BF16/F128 representations and coordinated protocol migration |
| 6 | In progress | Windows ARM64/AMD64 runtime, full native validation and separate packages |

## Implementation and validation

Initial audit: the compiler's Rust scheduler, TLS and transport contain Unix
interfaces; the C runtime needs native Windows allocation, scheduling, socket,
process and loader support. Existing half/quad type names lower to F32/F64 in
monomorphization, descriptors and protocol decoding. Item 5 must change both
engines and protocol/storage together, rather than relabeling existing values.
The first native Windows probe
[38438260036](https://github.com/e6qu/fun-with-pipes/actions/runs/38438260036)
failed on both architectures at Unix socket imports and descriptor access.
The runner hosts are `aarch64-pc-windows-msvc` and `x86_64-pc-windows-msvc`.

Implemented, awaiting runner execution: scalar foreign-C ARC admission based
on actual ABI types, with managed-string/callback rejection and raw/native
reclamation controls; native socket handles and WSAPoll; shared Windows/POSIX
library loading for FFI, TLS and OpenCL; owned shim image/directory lifetimes;
Windows DLL suffix and OpenSSL LLP64 signatures/socket errors. Loader and TCP
readiness/shutdown unit tests exercise real OS operations. This does not yet
port the generated C runtime or establish Windows support.

Focused runner validation at `217d6da`:
[portability 38439707405](https://github.com/e6qu/fun-with-pipes/actions/runs/38439707405)
passed on macOS ARM64 and Linux ARM64; Intel macOS is running and Linux AMD64
queued. [Windows 38439695491](https://github.com/e6qu/fun-with-pipes/actions/runs/38439695491)
reached all-target checking on ARM64: the library compiled, then the Unix-only
example process-group harness failed. Native handle/loader execution has not
run yet. AMD64 is queued. The next patch ports that harness to Windows process
groups/tree cleanup and native PATH separators.

WebAssembly implementation in progress: value allocations now use reclaimable
libc storage; typed last-owner destruction removes count metadata before freeing
storage. Counted ownership is enabled for ordinary generated programs, while
unproved shared graphs remain retained. Disabled freeing preserves storage and
resource destruction still disposes metadata. The new test observes actual libc
free across 10,000 cycles and 300 aliases, including a missing-free negative
control and disabled-free control, on host and actual WASI. Full WASI goldens
must pass before accepting this change. File-specific shared headers and cyclic
runtime graphs remain separate boundaries, not collector-free claims.

Local guarded `cargo check --lib`, `cargo clippy --lib -- -D warnings`, formatting
and the roadmap audit passed (the audit now accepts `In progress`). An extracted
actual non-GC allocator probe passed ASan/UBSan with the 10,000-cycle/300-alias
workload; command: `python3 scripts/local-guard.py python3
/private/tmp/fwp-wasm-allocator-check.py`. Its first source concatenation failed
before execution and was corrected; this is not actual WASI evidence.
Production runs defer while the PR is a draft and start on `ready_for_review`;
skipped production jobs are not acceptance. Focused runner suites are `windows`,
`portability` and `wasm` in `numerics.yml`.

Use `python3 scripts/local-guard.py COMMAND...` for serial focused checks.
Full builds, suites, benchmarks and large regeneration stay on GitHub runners.
Retain disk/RSS/CPU/deadline limits. Do not run the stale local fwp executable
as an oracle for new code. Preserve raw interpreter/native agreement, exact-bit
fixtures, ownership negative controls, stress/reuse checks and measured assembly.

## Next action

Next: run the updated native Windows and portability probes, fix their failures,
and port the generated C runtime/resources. Continue additional ownership proofs
and WASM reclamation. Establish portable exact float arithmetic and explicit
protocol migration before changing representations. Items 3–5 remain pending;
all six acceptance rows in PLAN remain required.
Keep all six items in the same PR. Require full Linux/macOS and added Windows
acceptance plus docs on its final head before squash merge.
