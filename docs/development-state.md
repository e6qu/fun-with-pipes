# Session handoff

## Next action

Next: finish [PR #180](https://github.com/e6qu/fun-with-pipes/pull/180) at
`64cfa0081dab2f6b19b6157e844c49481749a605`. Production run `39457866569` and
documentation `39457866666` check that exact source. Documentation passes; all
nine production jobs are running without reported failures. Audit with
`python3 scripts/local-guard.py python3 /private/tmp/fwp-audit-180.py`; receipt
`/private/tmp/fwp-180-acceptance.json`. Require all nine production jobs and docs. Audit every completed
job's full log and fix all failures. Squash-merge only after all gates pass, with
an explicit one-line subject of at most 80 characters and an empty body; verify
the merged tree and message. Keep one active PR. All seven roadmap areas remain
open; default native execution still includes tracing GC.

## Current delivery

The branch starts at accepted PR #179's merge and contains:

- **Borrow function-channel handles.** A continuing caller owner keeps the queue
  and native callback context alive. Capture, cycle and scope checks remain.
  Tests cover aliases, generic consuming entries, context destruction, failed
  queued calls and a deliberately leaked-owner control.
- **Count integer text without building it.** `show | string.length` and eligible
  concatenations count characters directly for integers up to 64 bits. Effects,
  traps, Unicode counts and shared strings keep their semantics. Tests compare
  the unoptimized interpreter with native O0/O2, ARC and tracing execution.
- **Compare equivalent calculations.** `text-length` adds direct digit-counting
  C/Rust peers with checked multiplication/sums. Existing `strings` peers still
  format text. Reports include repeated times, managed allocation counts, whole
  process memory, binary size and inspected machine code.

Measured compiler/test source `37de5ba40970f7729bf735b347527f5628117dc0` is tagged
`roadmap/revision-scalar-text-37de5ba4`. Focused
[run 39446896772](https://github.com/e6qu/fun-with-pipes/actions/runs/39446896772)
passes 205 checks per Linux host: 154 compiler tests, 49 integrations, channel
measurement and seven-program C/Rust comparison. Both complete logs are clean.
Receipt: `/private/tmp/fwp-scalar-text-audit.json`.
Artifacts: `/private/tmp/fwp-scalar-text-costs`.

Memory measurement source `fd1c1ec0292fa3c49a8f4f3cf37e76cb420058d6` is tagged
`roadmap/revision-scalar-memory-fd1c1ec0`. Its
[run 39455802373](https://github.com/e6qu/fun-with-pipes/actions/runs/39455802373)
passes on both native Linux architectures, reusing the exact timed binaries.
Both full logs and all saved inputs, binaries, generated instrumentation, RSS
samples and allocation controls are audited. Receipt:
`/private/tmp/fwp-scalar-memory-audit.json`; artifacts:
`/private/tmp/fwp-scalar-text-memory`. There are no known unresolved failures.
These focused runs do not replace final production acceptance.

[Integer-text results](measurements/integer-text.md) retain the +8.9% AMD64 and
+3.6% ARM64 time gaps versus direct C counting. fwp has zero measured managed
requests after initialization, but peak process memory exceeds the C median by
356/288 KiB respectively. No universal speed or zero-heap claim follows.
[Channel results](measurements/function-channel-borrows.md) remove one retain
per fresh-function message, with unchanged allocations and peak charged storage.
All 180 profiles and 20 binaries are audited; the combined change's 100 saved
C/binary/disassembly files match earlier channel-only source `d8c62e17`.
That source's focused run `39440052683` passes 199 checks per host and is tagged
`roadmap/revision-function-channel-borrows-d8c62e17`.

The original preparation remains at `/private/tmp/fwp-direct-borrows`, branch
`borrow-function-channel-handles`. Its four post-#179 commits were transplanted
onto accepted main; measured objects remain available through remote tags.
Use the root checkout for this delivery. The old worktree's handoff is obsolete.

## Isolated alias preparation

Worktree `/private/tmp/fwp-local-channel-aliases`, branch
`borrow-local-channel-aliases`, starts at PR #180's final head. The ownership pass
can replace temporary aliases in borrowed call arguments when the same source
storage is used afterward. It keeps effects and traps in place and distinguishes
record fields. Consuming/unknown calls, escapes and resource scopes are excluded.
No new IR form or surface syntax is introduced. Existing sequence lowering and
its verifier protect the original owner through argument evaluation and cleanup.

Four unit checks cover continuing owners, different fields, independent branches,
escapes, unknown/consuming calls and resource scopes. A native channel-context
probe checks owner counts at the call, aliases and destruction at O0/O2 under GC
stress/verification and reuse poisoning; an injected extra retain must fail.
These changes are implemented but not yet verified by compilation or execution.
Initial run `39458970390` was cancelled during setup before tests: review found
the native fixture must mark its manually built record as fresh owned storage.
That fixture is corrected; the compiler change is unchanged.
Run the existing `channel-costs` focused suite on both Linux GCC hosts, inspect
all logs and fix every failure. Compare all five channel programs against the
PR #180 report; do not claim the closed-function retain is removed until measured.
Local guarded formatting passes (1.77s); no local build or native compilation.

## Accepted baseline

[PR #179](https://github.com/e6qu/fun-with-pipes/pull/179) passed all nine
production jobs in `39438167856` and documentation in `39438167895` at
`63a129f25cfb9a3b940baf7786036265bfdf831d`. Complete logs are clean.
Merge `2f2e3fa1baa3b8b298781d109bb4d6eb11a822d7` has the same tree and a verified
one-line message without trailers. Receipt:
`/private/tmp/fwp-179-combined-acceptance.json`. Only duplicate post-merge
production `39456604708` was cancelled; post-merge documentation passed.
See [history](roadmap-history.md#matched-payload-moves-and-direct-call-borrows-pr-179).

## Local checks and next investigation

No local builds, full suites or native compilations. Use
`python3 scripts/local-guard.py COMMAND...` serially. Guarded report audits pass:
`python3 /private/tmp/fwp-audit-memory-artifacts.py` (0.62s),
`python3 scripts/summarize-scalar-text.py` with explicit run/source/artifact/output
arguments (1.95s), and channel-report audit (1.68s). `python3 scripts/check-roadmap.py` passes (3.26s);
`cargo fmt --all -- --check` passes (1.64s). About 69 GiB free; root target is 4 KiB. Preserve the fixed
64 GiB free disk, 2 GiB target, 1 GiB aggregate RSS and 180-second limits.

While final production runs, investigate the closed-function channel's remaining
retain: inlining leaves an owned temporary alias of a channel field while the
original owner continues into the next loop state. Establish every-path lifetime
and failure cleanup before removing it; do not prolong a resource lifetime or
borrow through an owner that can be consumed. No change for this case is implemented.
Use the five-program channel protocol and current reports as the baseline.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing; prove retained ownership and cleanup. |
| 2 | In progress | Eliminate avoidable functional allocations and count traffic. |
| 3 | In progress | Resolve measured machine-code and performance gaps. |
| 4 | In progress | Improve differentiation time, memory and precision. |
| 5 | In progress | Validate numerical kernels and ahead-of-time GPU policy. |
| 6 | In progress | Establish equivalent-work comparisons and budgets. |
| 7 | In progress | Validate larger programs and bounded live memory. |

Persistent subscriptions, resource captures, resource-owning tail frames and
mutual recursion need further proofs. Captured-channel eligibility needs
provenance as well as payload types. JIT is excluded. Follow [PLAN.md](../PLAN.md)
and [AGENTS.md](../AGENTS.md); completed batches do not complete the roadmap.
