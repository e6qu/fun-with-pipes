# Session handoff

## Next action

[PR #175](https://github.com/e6qu/fun-with-pipes/pull/175) is the only active PR.
The remote branch `queued-function-delivery` is at `6b246748`; production
`39359123801` is running and documentation `39359123712` passed. Local work fixes
another failure exposed by original production `39353280539` at `d1df84d9`:
GCC at `-O0` retained unused tracing routines in ARC binaries. Do not merge either
head. Next: validate the preprocessing repair with GCC, audit remaining completed
jobs, then publish all known repairs together and require new full acceptance.

Require all nine production jobs and documentation on the final PR head before
squash merge. Use an explicit one-line subject, at most 80 characters, and empty
body. Verify the merged tree/message before cancelling redundant post-merge CI.

## Queued-function delivery

Checked ARC admits known functions with proved immutable captures: numbers,
strings, containers and other proved functions. Captured channels, tasks, files,
connections and streams remain rejected, even when a particular program might
be safe. There is no new syntax. Runtime guards also remove tracing code from
ARC builds before C optimization. See
[the worked example and limits](ownership.md#next-proof-functions-stored-in-channels).

The proof follows captures, returns, queues and caught errors. Calls use the
receiver's State/autodiff scope. Aggregate fields and queues of the same concrete
type merge conservatively; incompatible callable types are filtered, while
unknown sources remain unknown. External function-bearing queues are rejected.

Empty origin sets mean no possible incoming function, as with mapping an empty
function collection. Non-returning traps/exits likewise produce no function.
These differ from an unmodeled producer, which remains unknown and rejected.
Structural comparison of recursive record types now visits each type pair once.
The old compiler exceeded the local 1 GiB guard on that reproducer; do not retry
it locally. Its repaired native regression passed on focused runners.

## Current checks and failures

- Production `39353280539` at `d1df84d9`: benchmarks passed. Regular macOS ARM64
  found one failure in `autodiff_nested`; stress ARM64 found three checkpoint
  failures and one F128 precision failure. All five reject `rev._vjp` because
  a trapping branch was treated as an unknown function producer. Both complete
  logs were audited. Intel macOS reports the same failures across its two jobs;
  Windows ARM64 reports all five. Linux ARM64 reports those five plus the
  `queued_functions` binary-symbol failure: GCC keeps unused collectors at
  `-O0`. All completed logs are audited. Linux AMD64 and Windows AMD64 remain
  running. Documentation `39353280537` passed.
- Repair `fd1275ea`: focused macOS ARM64 `39357056381` and Linux AMD64
  `39357061326` each pass 158 checks: 145 units, eight queue cases, one generated
  entry, three checkpoint tests and one precision test. None ignored; the entry
  filter deliberately excludes five other tests, which remain production gates.
- Precision run `39357198059` at the repair passes all 27 checks on Linux and
  macOS, each on ARM64 and AMD64. It includes all three
  failed autodiff targets, nested derivatives, tape cleanup, wrong-input cases,
  float formats and generated library documentation. Complete finished logs were
  audited. These focused runs do not replace final production acceptance.
- `6b246748` production: benchmarks passed; other jobs continue. The newly found
  GCC binary issue is expected here too. Local repair removes tracing functions
  with preprocessor guards, preserving typed finalizers and scheduler helpers.
  ARC checks now include O0/O1/O2, and ordinary tracing supplies a positive symbol
  control. Focused Linux ownership jobs now explicitly use GCC, matching production.

Existing checks compare raw interpretation with native ARC/stressed tracing,
exercise closed/undrained queues, aliases, cancelled transfers and failed receive
allocation, and inspect actual ARC binaries for collector removal. WASI checks
physical allocations and JSPI/Asyncify. Cleanup results are not speed claims.
Earlier compiler source `c04f01fb` and its focused checks are preserved by
`roadmap/revision-queued-functions-c04f01fb`; superseded preparation details remain
in that snapshot, rather than competing with this handoff.

## Independent next delivery

`measure-channel-transfers`, worktree `/private/tmp/fwp-channel-transfers`, follows
[the measured protocol](https://github.com/e6qu/fun-with-pipes/blob/measure-channel-transfers/docs/measurements/channel-transfer-protocol.md).
It also fixes later-stage effects leaking into stored callback types.
Baseline `2b56fd1c`, run `39354805966`, passed both Linux architectures. Transfer
source `34568f3d`, counts run `39356051237`, removes one retain per fresh message:
text 4 → 3; functions 5 → 4. Shared totals, allocations and peak charge are
unchanged. Binary-size changes and an extra 16 bytes in the inspected ARM64
exchange frame are recorded; no timing/C-or-Rust parity claim is made.

All six native jobs in `39356046321` failed only two stale test expectations;
other 26 integration cases passed. Both WASI jobs passed all 14 checks. Every
complete log was audited. Combined repair `5d083f3f` includes those corrections
and the primary non-returning proof fix. Run `39357985210` passes all 38 integration
checks on each native host and 18 on each WASI host. Only one stale contract unit
assertion fails; it is fixed and its standalone check passes locally. All eight
logs are audited. Count run `39357990574` reproduces all 180 samples and binary
sizes on both Linux hosts. Preparation `f0747ab2` adds a narrow alias removal
after `tap`, preserving its action before the continuation. Its counts run
`39360310385` passes both hosts; artifacts still need comparison. Expanded loop
cleanup run `39360304008` continues. Review found the new ARC test enabled
incompatible stress flags; local correction keeps them only on tracing runs.
Bring the primary collector-exclusion repair into this preparation before its
next validation batch. The preparation's handoff has the detailed next action.
Keep this preparation separate until PR #175 is accepted; keep one active PR.

## Local work and accepted base

Local checks use `python3 scripts/local-guard.py COMMAND...`, unchanged limits.
`cargo fmt --all -- --check` and `python3 scripts/check-roadmap.py` pass under
the guard. Guarded interpretation of the minimal
trapping-branch regression prints `Some 3`; old ARC emission reproduces rejection.
Guarded `/private/tmp/fwp-check-arc-preprocessing.py` passes C syntax and symbol
exclusion/control checks in 0.63s, without producing a binary. Reports audit
downloaded data; no local compiler rebuild, generated native build or timing
run was performed. Free disk is close to the 64 GiB floor: avoid large downloads,
monitor the guard and move additional heavy analysis to runners.

[PR #174](https://github.com/e6qu/fun-with-pipes/pull/174) is accepted as
`3ec71969089a7ab95ff065f7b611c74534fbe326`, after all nine jobs and docs passed.
Its merge tree and one-line message were verified. [History](roadmap-history.md#numeric-hashing-and-integer-output-pr-174)
retains its measurements and remaining C/Rust gaps. The old
`prove-queued-function-ownership` worktree is historical; do not resume it.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Ownership contracts, tracing removal and limited ARC |
| 2 | In progress | Functional intermediates, copies and eligible tail recursion |
| 3 | In progress | Equivalent-work C/Rust gaps and machine-code costs |
| 4 | In progress | Derivative precision, speed and storage |
| 5 | In progress | CPU kernels and ahead-of-time device execution |
| 6 | In progress | Reproducible comparisons and regression budgets |
| 7 | In progress | Representative larger applications |

All seven areas in [PLAN.md](../PLAN.md) remain open. Persistent subscriptions,
resource captures, resource-owning tail frames and mutual recursion need further
proofs. JIT is excluded. Follow [AGENTS.md](../AGENTS.md): one active PR, all
final-head gates, bounded local work and one-line commits without trailers.
