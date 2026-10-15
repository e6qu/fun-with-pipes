# Session handoff

Updated 2026-10-15. The user requested continued development after PR #137.
[PR #138](https://github.com/e6qu/fun-with-pipes/pull/138), branch
`autodiff-operation-storage`, removes input placeholders from numeric and
managed AD parent/derivative buffers. Publication, fixes and squash merge after
all final-head gates remain authorized.

## Roadmap status

| Step | Status | Delivered scope |
|---|---|---|
| 1 | Verified | Streamlined docs and session handoff |
| 2 | Verified | Expanded typed collector-free ownership |
| 3 | Verified | Array producer fusion, numeric tail loops and wide workers |
| 4 | Verified | Nested reverse AD, checkpointing and lifetime controls |
| 5 | Verified | Actual F16/BF16/F128 and protocol v2 |
| 6 | Verified | Native Windows ARM64/AMD64 and standalone packages |
| 7 | Verified | Seeded-prefix adjoint bounds and four-host memory/binary evidence; PR #137 merged with all gates |
| 8 | Implemented | Operation-only AD metadata, partial weight-retain cleanup, regression controls and measured evidence |

## Accepted baseline

[PR #137](https://github.com/e6qu/fun-with-pipes/pull/137) merged as `38da1401`,
tree-identical to `37104959`. All nine [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38604595248)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38604594927)
pass. [The prefix report](measurements/ad-prefix-2026-10-14.json) records its
specific 98,304-byte peak tape reduction and absence of a consistent speedup.
Historical preparation anchors are not work to replay.

## Current implementation and evidence

Both runtimes now index parent/weight metadata relative to the input count.
Node tokens, parent values and adjoints retain their original absolute indices.
Input-only tapes need no operation buffers; existing cached buffers remain
subject to the 512 KiB budget. Managed backward callback order is unchanged.
A related native cleanup fix protects the first retained derivative if retaining
the second fails. Cold input-only tapes allocate no operation metadata.

Guarded checks pass: formatting, all-target clippy, five interpreter tape tests,
native operation-storage/actual second-retain controls, managed unwind and
cancellation, allocator/index/generation/unwind controls, and raw language
outputs. The exact commands use `python3 scripts/local-guard.py` before cargo or
fwp; all stayed within the fixed limits.

The first focused AD run exposed three fixtures that still assumed input
metadata: scope release, library unload and checkpoint capacity. Scope/library
fixtures now record real operations, preserving their omission controls;
checkpoint capacity now asserts exactly 4,096 operations. CI also exposed a
stack-lifetime error in the new deliberately leaking probe; its descriptor now
has static lifetime so shutdown remains valid. These corrected tests pass locally:
scope release (9.31s), library unload (4.87s), checkpoint bounds (7.09s) and native
operation/retain controls (4.01s). No compiler/runtime source changed after the
measured `31b9d8d2` head. Full production CI must verify the corrected fixtures.

[Focused WASM](https://github.com/e6qu/fun-with-pipes/actions/runs/38664966403)
passes on Linux AMD64 and ARM64 at `31b9d8d2`, including actual WASI semantics and
physical reclamation controls. The AD run is not a passing gate: its measurement
steps succeed independently of the fixture failures.
[All four measurement reports](measurements/ad-operations-2026-10-15.json) are
recorded with verified source/binary/disassembly hashes. Native tape peaks fall
131,176 → 32,872 bytes for identity VJP, 262,248 → 163,944 for mapped VJP and
28,920 → 16,632 for the nested gradient. The latter also reduces managed storage.
Mapped/native requests rise 10 → 30 and nested requests 19 → 21 because smaller
cold buffers grow geometrically. All final storage is reclaimed without GC;
process timings show no consistent speedup. Native instructions on all four hosts
show register operation offsets and hoisted backward metadata-base adjustments.

Final fixture clippy passes (0.73s); guarded four-host aggregation/hash verification
passes (0.16s). Final production CI must accept the corrected fixtures on every
required host before this PR can merge.

## Boundaries

Numeric prefix bounds trim an unused suffix, not holes in the active prefix.
Checked native ARC still rejects unproved cycles, mutable/retained graphs and
State/AD lifetimes. Service/remote/library/WASM executable ARC admission remains
outside the earlier bundle. Generic wide values and some lazy producers can
allocate. No universal collector-free execution or speedup is claimed.

## Next action

Next: inspect PR #138's current head, checks and merge state. If open, require
all nine exact-head production jobs plus documentation, fix any failures, and
squash merge with one line of at most 80 characters and an empty body. If merged
with those passing gates, step 8 is complete; no implementation task remains
from this follow-up. Keep work in this PR and do not replay historical anchors.

Use `python3 scripts/local-guard.py` for focused serial local checks; preserve
64 GiB free disk, target below 2 GiB, sampled aggregate RSS below 1 GiB and the
180-second deadline. Full builds, suites and measurements belong on GitHub.
