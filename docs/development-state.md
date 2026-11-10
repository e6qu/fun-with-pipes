# Current work

**Next:** publish the combined build-dependency/audit repair and replay all saved queued-service
profiles on native Linux ARM64/AMD64. Verify every result, sample count, period,
source hash and diagnostic before selecting a service optimization. Then freeze
its correctness/time/memory/compiler-cost contract and deliver it with these
measurement repairs in one substantial normal PR.

## Verified delivery

[PR #275](https://github.com/e6qu/fun-with-pipes/pull/275) is merged as
`13d31fc4041a664129ed5674845750836faa0a84`. Its tree equals verified head
`a232e1e35062a37aa013975ac77bbd8cb4620663`; its message is one line, 49 characters,
with an empty body and no trailers. [All final gates and the merge receipt](measurements/compiler-borrowed-final-gates-2026-11-10/README.md)
are retained: production `42767361217`, docs `42767360650`, complete-log audit
`42778134759`. All ten audit reports match the exact passing head; the complete
archive's size, SHA-256 and every CRC pass. Duplicate main runs `42779270202` and
`42779270047` were cancelled after verifying equal trees.

[Borrowed types](measurements/compiler-borrowed-types-2026-11-10/README.md) remove
29–32% of type copies while preserving C and diagnostics. [Ordinary compilation](measurements/compiler-type-time-2026-11-10/README.md)
takes 11–14% less time for word counting and 8–10% less for callbacks. All complete
applications and memory limits pass. Four AMD64 growth comparisons remain noisy
under the frozen 2% copy-control limit; do not rerun unchanged measurements.

## Queued-service CPU attribution

Worktree `.worktrees/service-cpu-costs`, branch `service-cpu-costs`, rebased onto
the verified squash. No delivery PR yet. Immutable identities:

- Protocol `8fcea595d`, tag `roadmap/service-cpu-protocol-2026-11-10`.
- Original observations `fac4a47440fb02667ddbf385dba959ae8f91a310`, tag
  `roadmap/service-cpu-observation-2026-11-10`.
- Failed LLVM reader `47f185f7d33743933c1b0f63d1d647c095822efc`, tag
  `roadmap/service-cpu-llvm-decoding-2026-11-10`.

[First run `42772697088`](measurements/service-cpu-first-2026-11-10/README.md)
verifies every output in 32 peer/case combinations per host. Exactly three fwp
profiles per host fail decoding: delivered, cancelled and handled error. ARM
job/artifact `129683968936`/`13743108949`; AMD `129683968550`/`13744145167`.
All recordings and matching binaries are saved; do not rerun their workloads.

[LLVM replay `42776958064`](measurements/service-decoder-replay-2026-11-10/README.md)
fails all sixteen profiles per host because LLVM 18's probe response is incompatible
with perf 6.8. Both complete logs, archives and diagnostics are retained. The
unpatched GNU control confirms the underlying bug: short inline names such as
`f100` are mistaken for zero-address end markers (149 ARM / 96 AMD errors).

First patched-reader run `42780083932` fails on both hosts before decoding because
the Swift image lacks `make`. Complete logs are retained with the decoder diagnosis.
The combined repair installs it explicitly and adds independent reconstruction of
all saved outputs, pilot choices, periods and attribution. Four guarded collection/
replay controls pass, including altered-period, wrong-phase and skipped-pilot faults.
The test exposed differing unresolved/resolved temporary paths on macOS; matching
the actual retained recording path fixes that without changing source identities.

Run `42780806078` at `830e0b6e9` reaches perf configuration, then both hosts stop
because hardware-event database generation expects `python`. Disable that unused
database explicitly (`NO_JEVENTS=1`) and BPF skeletons (`BUILD_BPF_SKEL=0`); the
saved recordings use software CPU-clock events. Both complete logs are retained.

The repair builds Linux perf source
`e8f897f4afef0031fe618a8e94127a0934896aba` with exactly one condition changed:
require the `0x` prefix before reading an end marker. GNU addr2line stays explicit.
Require libdw unwind features; retain patch, build log and binary hash. Replay all
profiles; the original packaged reader must still reproduce its defect. No
compiler rebuild, program execution or new measurement belongs in this replay.
Dispatch `numerics.yml`, `suite=service-cpu-replay`, new immutable
`service_cpu_tag`, `evidence_run=42772697088`, and
`source_revision=fac4a47440fb02667ddbf385dba959ae8f91a310`.

[Shared compiler-reader replay `42772707168`](measurements/service-reader-replay-2026-11-10/README.md)
already passes both hosts. Every attribution row/count/period equals the previous
verified reader. No compiler rebuild or timing rerun was required.

Follow the [service protocol](measurements/service-cpu-costs.md). Unknown frames
remain visible; samples are neither ARC counts nor elapsed-time ratios. Select a
runtime change only after attribution. Check the same mechanism in HTTP before
claiming a shared improvement. Keep the public gradient API unchanged.

## Roadmap status

| Step | Status | Delivered | Remaining |
|---|---|---|---|
| 1 | In progress | #270 docs and fresh F64 stores | Original AMD timing acceptance |
| 2 | In progress | #271 captured maps and empty-owner transfer | Original noisy timing acceptance |
| 3 | In progress | #272 structured gradients and known callbacks; all gates | Original AMD timing acceptance |
| 4 | Verified | #273 ownership/peer comparisons and parser cleanup; all gates | Recorded comparison limits apply |
| 5 | Verified | #274 applications, compiler reports/growth, HTTP load; all gates | Recorded observation limits apply |
| 6 | In progress | #275 borrowed types; application speed/memory targets; all gates | Four noisy growth comparisons |
| 7 | In progress | Correct service recordings; shared-reader controls | Repaired attribution, selected runtime change, measured acceptance and final delivery |

## Local checks and preservation

Prior guarded controls pass: five compiler-reader, five service-reader and three
collection/raw-record controls. The latter check replay source/hash/output integrity.
The marker repair passes all four affected collection/replay controls, actionlint, and
the docs audit (457 link sets, 106 preparation anchors, seven milestones). No local native builds.

Use `python3 scripts/local-guard.py` serially: 64 GiB free disk, target data <2 GiB,
sampled RSS <1 GiB, 180 seconds. Last free space: about 112 GiB. Preserve unrelated
root changes, old worktrees and stash `451bbf713d451f2d62d80fd7676839404875846a`.
The pre-rebase service backup is `540b0682408d751afb6e439d58a3b887bdcba373`.
