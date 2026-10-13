# Session handoff

Updated 2026-10-13. The user authorized all six remaining directions in
[PLAN](../PLAN.md) as one combined PR, including Windows ARM64/AMD64 and real
half/quad formats. Branch: `ownership-formats-windows`. Publication, fixes and
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
| 2 | Pending | Broader proved ownership, retained/foreign/protocol contexts, cycle policy and WASM reclamation |
| 3 | Pending | Broader producer/worker specialization and reduced boxing/closure allocation |
| 4 | Pending | Measured kernel/layout improvements, nested reverse mode and checkpointing |
| 5 | Pending | Actual F16/BF16/F128 representations and coordinated protocol migration |
| 6 | Pending | Windows ARM64/AMD64 runtime, full native validation and separate packages |

## Implementation and validation

Initial audit: the compiler's Rust scheduler, TLS and transport contain Unix
interfaces; the C runtime needs native Windows allocation, scheduling, socket,
process and loader support. Existing half/quad type names lower to F32/F64 in
monomorphization, descriptors and protocol decoding. Item 5 must change both
engines and protocol/storage together, rather than relabeling existing values.
No implementation or Windows runner result for this bundle is accepted yet.
The existing evidence workflow now has a `windows` suite using native AMD64
and ARM64 runners. Production runs defer while this PR is a draft and start
on `ready_for_review`; all final-head production jobs remain mandatory. This
avoids restarting full suites on each preparatory change.

Use `python3 scripts/local-guard.py COMMAND...` for serial focused checks.
Full builds, suites, benchmarks and large regeneration stay on GitHub runners.
Retain disk/RSS/CPU/deadline limits. Do not run the stale local fwp executable
as an oracle for new code. Preserve raw interpreter/native agreement, exact-bit
fixtures, ownership negative controls, stress/reuse checks and measured assembly.

## Next action

Next: publish one draft PR with this six-item scope and early native Windows
compile probes; implement the additional ownership contracts while runner
failures identify porting work. Establish a portable exact float representation
and explicit protocol migration before changing format defaults. Record actual
checks and outstanding failures here after meaningful implementation progress.
Keep all six items in the same PR. Require full Linux/macOS and added Windows
acceptance plus docs on its final head before squash merge.
