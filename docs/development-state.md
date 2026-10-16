# Session handoff

Updated 2026-10-16. Accepted #147 is `c9127d2d`, with nine production jobs
and docs passing at `71c612d0`; its tree and one-line message were verified.
The only open PR is [#148](https://github.com/e6qu/fun-with-pipes/pull/148),
root branch `record-moves-and-utilities`, final head
`93b1741abcf5ab2a61460746c0077564e0328c0e`.
[Production 38825629531](https://github.com/e6qu/fun-with-pipes/actions/runs/38825629531)
has six passing jobs; Linux ARM/AMD and Intel macOS stress remain running.
[Documentation 38825487182](https://github.com/e6qu/fun-with-pipes/actions/runs/38825487182)
passes. Keep that head unchanged. Ignore canceled old-head and skipped draft jobs.

Standing authorization: fix failures, require all nine production jobs and docs
for the exact head, squash merge with an explicit subject of at most 80 characters
and empty body, then continue. No attribution or trailers. JIT is excluded.

## Roadmap status

[PLAN.md](../PLAN.md) defines completion; none of the seven whole areas is done.

| Step | Status | Next concrete work |
|---|---|---|
| 1 | In progress | Accept record ownership, then process and terminal boundaries |
| 2 | In progress | Attribute remaining functional intermediates to allocation sites |
| 3 | In progress | Diagnose measured CPU costs with retained native instructions |
| 4 | In progress | Profile derivative allocations before selecting another optimization |
| 5 | Pending | Broaden CPU kernels; resolve runtime OpenCL compilation under no-JIT policy |
| 6 | In progress | Preserve repeated comparable measurements and regression criteria |
| 7 | In progress | Accept process composition and real terminal checks across six hosts |

Next: finish #148's final-head gate and merge when it passes. Finish this
process/terminal batch's six-host checks, transfer only its diff after `81d113aa`
onto #148's accepted squash, refresh PLAN/history/handoff and open the next
combined PR. Require its own full production/docs gate. Keep one open PR.

## Process and terminal batch

This worktree is `/private/tmp/fwp-process-utilities`, branch
`owned-process-utilities`, based on `81d113aa`. Only the diff after that anchor
belongs to the next delivery; never replay the old parent preparation. Preserve
root's local progress notes when integrating. No process PR is open.

The batch owns argument scratch, pipe endpoints, child resources, capture
buffers, copied strings and their result record. It rejects NUL arguments before
OS calls, reports read/wait failures, retries interrupted waits, preserves closed
standard descriptors and closes/reaps on unwinding. Windows retains its existing
reader/handle cleanup with protected result construction. Calls are synchronous;
this does not prove cancellation/deadline responsiveness while waiting for a child.
POSIX children regain normal SIGPIPE behavior. Parent input writes preserve the
host's signal handler/mask and previously pending signal without global ignores.

Secret terminal input restores echo on success and traps. Windows interpretation
uses console APIs for echo and width. The public tty descriptor is I32; internal
C words are checked before narrowing. Tty/width results are immediate scalars with
explicit ownership contracts. Portable CLI tests use native executable suffixes
and directly connected processes. Production Windows runs these added regressions.

Tests compare raw interpretation with native tracing/ARC at O1/O2, stress/reuse,
Unicode/quoted arguments, 64 KiB per output stream and 200 KiB input, early exit,
missing commands, partial construction and OS failures. A maintained shell tool
runs 64 times, retaining then releasing captured results. Real pseudo-terminals
or private Windows consoles test echo restoration; deliberately missing cleanup,
counts or signal preservation must fail.

## Validation and current repair

[Six-host run 38831045963](https://github.com/e6qu/fun-with-pipes/actions/runs/38831045963)
tests source `6e122959`. All six hosts passed process, signal, CLI and real
terminal restoration tests; their only failure was the missing `term.is-tty`
ownership contract. That repair and an explicit width comparison are published
at `8926a2fb`; [rerun 38833152028](https://github.com/e6qu/fun-with-pipes/actions/runs/38833152028)
is queued/running. Later changes only add the verified allocation profiling
script/workflow/report and documentation, without changing runtime/compiler/tests.
This remains an acceptance task until the combined rerun passes.

Earlier native evidence: all three process tests and repaired CLI cases passed
all six hosts at `7e9e5bd8` in
[38829032952](https://github.com/e6qu/fun-with-pipes/actions/runs/38829032952).
Terminal cleanup/negative controls and interpreter console checks passed both
Windows architectures and terminal cleanup both macOS architectures. That run's
I32 literal and Linux feature-declaration fixture errors are repaired. The first
Windows probe's closed-handle marker and CLI path errors were also repaired.
Canceled `38830176031` is not validation. The final PR still needs full acceptance.

Focused local checks use `python3 scripts/local-guard.py COMMAND...`. Latest
`cargo fmt --all -- --check` passes (1.30 s); primitive inventory passes (0.96 s):
259 contracts, six scalar signatures, 94 review declarations, 19 templates and
84 review symbols. Accepted-compiler probes with edited current POSIX C pass
signal/failure/negative controls (8.78 s), repeated calls (3.39 s), maintained
shell composition (4.32 s) and real terminal cleanup (3.63 s). These are mechanism
checks, not changed-compiler acceptance. No full local build or benchmark was run.
Scripts/logs are under `/private/tmp/fwp-process-*` and `/private/tmp/fwp-terminal-*`.

## Derivative evidence and following preparation

Four-host repeated comparison
[38828198160](https://github.com/e6qu/fun-with-pipes/actions/runs/38828198160)
at `48aa61dc` compares current paired tape storage against the documented old
separate-allocation control. Four-host interleaved-layout trial
[38829628017](https://github.com/e6qu/fun-with-pipes/actions/runs/38829628017)
at `aff0e087` changes generated experimental C only. Both pass correctness/profile
checks. Raw repeated samples, compiler/hardware, hashes and actual ARM64/AMD64
functions are retained in the two 2026-10-16 reports under `docs/measurements`.
[Benchmarks](benchmarks.md) explains timing scope and mixed/slower results.
Neither comparison is C/Rust parity; production layout remains unchanged.

The repeated 512-derivative case makes 25,184,777 managed allocations and
10,492,416 retains. All four hosts pass allocation-site profiling in
[38832271631](https://github.com/e6qu/fun-with-pipes/actions/runs/38832271631)
at `507ec27`. The report verifies source/binary hashes and exact agreement with
aggregate counts/peak/final memory (guarded retention check: 0.13 s). Mapped list
nodes account for 41.65% of requests. This diagnostic and its report are now
included in this process delivery, avoiding a separate measurement-only PR.

Following compiler preparation remains `/private/tmp/fwp-ad-allocation-sites`,
branch `profile-ad-allocations`. Its next-change anchor is `cfdf4d79`: only changes
after that commit belong to the subsequent delivery. Earlier diagnostic changes
are included here. Its handoff specifies direct construction for numeric
`map f | array.from-list`, preserving callback/effect/trap order and measuring
allocation/timing differences. No implementation is accepted yet. Keep one PR.

The draft transfer patch/body are `/private/tmp/fwp-process-delivery.patch` and
`/private/tmp/fwp-process-pr-body.md`; refresh them after the current repair.
