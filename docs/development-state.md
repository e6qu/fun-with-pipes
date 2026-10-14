# Session handoff

Updated 2026-10-14. The user requested continued development after PR #136.
[PR #137](https://github.com/e6qu/fun-with-pipes/pull/137), branch
`autodiff-active-prefix`, implements the bounded numeric backward-pass follow-up.
Publication, fixes and squash merge after all final-head gates remain authorized.

## Roadmap status

| Step | Status | Delivered scope |
|---|---|---|
| 1 | Verified | Streamlined docs and session handoff |
| 2 | Verified | Expanded typed collector-free ownership |
| 3 | Verified | Array producer fusion, numeric tail loops and wide workers |
| 4 | Verified | Nested reverse AD, checkpointing and lifetime controls |
| 5 | Verified | Actual F16/BF16/F128 and protocol v2 |
| 6 | Verified | Native Windows ARM64/AMD64 and standalone packages |
| 7 | Implemented | Seeded-prefix adjoint bounds, amortized workspace growth and four-host memory/binary evidence; final delivery follows PR #137's checks and merge |

## Accepted baseline

[PR #136](https://github.com/e6qu/fun-with-pipes/pull/136) merged as `2684241d`,
tree-identical to `26f2c68a`. All nine production jobs and docs pass; see
[the acceptance record](roadmap-history.md#pr-136-merge-acceptance).
Historical preparation anchors are not work to replay.

## Current implementation and evidence

Numeric backward passes retain every input adjoint and the tape prefix through
the last seeded output. Parent indices precede children, so later nodes cannot
contribute. Both engines preserve validation and arithmetic order. Detached
buffers remain protected before validation; invalid outputs allocate no new
adjoints. Later failure/cancellation still releases all allocated buffers.
A reused adjoint workspace grows geometrically; a cold one allocates the needed
prefix. Forward recording and managed nested-tape propagation are unchanged.

[Focused AD 38601394373](https://github.com/e6qu/fun-with-pipes/actions/runs/38601394373)
passes all four Linux/macOS hosts at `920f5aa9`: native and interpreter tests,
nested AD, scope/unwind/cancellation controls, workspace reuse, deliberate
full-storage/full-scan regressions, and checkpoint/prefix measurements.
[Focused WASM 38601399062](https://github.com/e6qu/fun-with-pipes/actions/runs/38601399062)
passes both Linux hosts, including CLI/browser semantics and physical
reclamation controls. Both runs test the
current compiler/runtime. The evidence closeout adds docs/report hashes and
strengthens successful-language-case stderr assertions; it does not alter runtime
or compiler sources. Final production checks also exercise the stricter assertion.

[Four-host evidence](measurements/ad-prefix-2026-10-14.json) records 12,291 tape
nodes with a three-input prefix. Peak tape storage falls 491,648 → 393,344 bytes;
requested tape bytes fall 883,328 → 785,024 while request count stays 38.
Managed allocations/retains/peak are unchanged; all measured storage is reclaimed
without GC. Seven-sample process timings show no consistent speedup. The report
retains hardware/compiler/flags, samples and source/binary/disassembly hashes.
Native disassembly on all four hosts confirms the computed prefix controls
adjoint allocation and reverse-loop bounds. Forward work remains unchanged.

Local checks through `python3 scripts/local-guard.py` pass: formatting, clippy
(17.21s after refinement), four interpreter tape tests (13.52s), current-runtime
C syntax (0.26s), current formatter AST/idempotence, Python syntax, workflow lint,
and the roadmap/link/commit audit. Aggregating and hash-checking the runner
reports passes (0.15s); no measurements were regenerated locally. Final evidence
closeout formatting (1.14s) and clippy (0.61s) pass. Initial runs
38600695264/38600698982 were cancelled while queued before the growth refinement;
they do not count as evidence.

## Boundaries

This change trims an unused suffix, not holes within the active prefix. Existing
larger cached buffers stay within the fixed workspace budget. Checked native ARC
still rejects unproved cycles, mutable/retained graphs and State/AD lifetimes.
Service/remote/library/WASM executable ARC admission remains outside the earlier
bundle. Generic wide values and some lazy producers can allocate. No universal
collector-free execution, allocation reduction or speedup is claimed.

## Next action

Next: inspect PR #137's current head, checks and merge state. If it is open,
finish all nine exact-head production jobs plus docs, fix any failure, and
squash merge with one line of at most 80 characters and an empty body. At a session restart, inspect that PR first. If merged with those passing
gates, this follow-up is complete; no implementation task remains from step 7.
Keep its work in this PR and do not replay historical preparation entries.

Use `python3 scripts/local-guard.py COMMAND...` for serial local checks; preserve
64 GiB free disk, target below 2 GiB, sampled aggregate RSS below 1 GiB and the
180-second deadline. Full builds, suites and measurements belong on GitHub.
