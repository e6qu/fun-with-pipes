# Session handoff

## Next action

[PR #175](https://github.com/e6qu/fun-with-pipes/pull/175) is the only active PR.
Keep its head `6511a50f` stable while production run `39363423392` finishes.
Documentation `39363423384`, the benchmark gate and regular ARM64 macOS pass.
The complete macOS log has no failed/ignored Rust tests; its 11 SDK tests pass. All eight focused
ownership jobs in `39362626916` pass, as do both count jobs in `39362629293`.
Those focused runs use `f3c6f8d9`: compiler, runtime and integration-test source
are identical to the final PR head. The later repair restores the frozen
inventory, explicitly audits consuming channel sends and registers the new test
in native CI. Do not merge any superseded head or count cancelled jobs as passes.

Require all nine production jobs and documentation on the exact final head.
Audit completed logs, fix every failure, then squash merge with an explicit
one-line subject of at most 80 characters and empty body. Verify the merged
message and identical tree before cancelling redundant post-merge production.
The primary worktree `/Users/zardoz/projects/fun-with-pipes` holds that delivery.

This worktree, `/private/tmp/fwp-channel-transfers`, holds the separate
`flatten-channel-loop-state` preparation. Current implementation is `75da96b8`.
Next: audit its ownership run `39366497033` and count run `39366501786`, including
all failed tests, generated C and actual machine code. Do not open a second PR.
After #175 is accepted, apply only this branch's difference from `6511a50f` to a
fresh branch from accepted main, update the plan/history, and run full acceptance.

## Candidate

The measured channel programs allocated a tuple each time they advanced their
loop state. `tap` or a branch hid the next record from existing field-by-field
loop lowering. Carrying `Again` through a match exposes each terminal record,
while preserving the action, patterns, evaluation order and resource boundaries.
Every arm must end in a record; existing shape checks still decide eligibility.
Whole-value uses retain their established representation. There is no new syntax
or runtime helper. See [the example and loop-only results](measurements/channel-loop-state.md).

Inspection also found generic dispatch of a known `string.length` callback.
The optimizer now propagates capture-free function aliases, exposing direct
calls. Arity-zero constants remain at their original evaluation point because
they can allocate or trap. A new regression checks repeated calls and interpreter
agreement; focused CI also covers constant evaluation order, temporary cleanup
and callback effects. Both Linux count runs are now audited; full acceptance remains pending.

## Evidence

- Loop-only implementation `16adc74b`, count run `39363807189`: both Linux
  architectures pass. The audited report has 180 samples and 20 ordinary binaries.
  Each of five cases saves one allocation per additional message; fresh/closed
  cases save one retain, shared cases two. Every ARC profile ends with zero
  charged storage. These are counts, not timings or C/Rust comparisons.
- The comparison uses integrated baseline `f3c6f8d9`, run `39362629293`, not a
  mixture of binaries from before and after collector exclusion. Both have GCC
  O2 with LTO disabled. The report includes file/code sizes and loop stack frames.
- Loop-only ownership `39364385408`: Linux and Windows on both architectures,
  ARM64 macOS and both WASI hosts pass; their complete logs are audited. Intel
  macOS also passes; all eight complete logs pass a guarded audit in 0.22s. Native hosts have 47 integration tests plus all compiler
  units; each WASI host has 18 checks, with none ignored or filtered.
- Resource-field runs `39365324259` (AMD64) and `39365327202` (ARM64) at
  `cc850204` pass with GCC. Each has 37 tests across 21 targets, none ignored or
  filtered. Both complete logs are audited. Compiler implementation matches the
  loop-only measured revision; comments, import placement and workflow differ.
- Alias implementation `75da96b8`: focused `39366497033` and counts
  `39366501786` now passes both hosts: 180 samples and 20 ordinary binaries
  audited in 1.55s. All count/memory metrics match the loop-only revision; the
  fresh-text dispatch disappears and its exchange frame drops by 48 bytes on
  each architecture. Details are in the linked report. Ownership passes Linux,
  Windows and ARM64 macOS plus both WASI hosts; Intel macOS remains running.

## Local checks

Use `python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py COMMAND...`
for serial bounded checks. No local full compiler or generated native build was
run. Free disk is near the 64 GiB floor; use runners for heavy work.

Guarded raw interpretation checks the tapped/branched loop's output and retained
initial alias (0.82s); the documentation example prints `hello`, `hello!`, then
`hello!!` (0.86s). `scripts/summarize-channel-costs.py` audits the baseline and
loop-only reports in 1.54s/1.61s. ELF inspection confirms smaller code sections
on both hosts, even where linker alignment enlarges the executable file.
`/private/tmp/fwp-audit-loop-fields.py` verifies both 37-test logs in 0.23s.
After the alias change, guarded `cargo fmt --all` and
`python3 scripts/check-roadmap.py` pass in 1.48s and 2.54s. The handoff rewrite
initially removed the required seven-row status table; restoring it passes the
audit in 2.43s. A guarded `du` inventory returned its sizes but stopped with
`Operation not permitted` while controlling the system utility; it was not retried
and no limit was changed. Three redundant, audited baseline/transfer/tap download
directories were removed; their reports and GitHub artifacts remain. Integrated
baseline and candidate binaries are retained locally for comparison.

## Accepted work and remaining goals

[PR #174](https://github.com/e6qu/fun-with-pipes/pull/174), accepted as
`3ec71969089a7ab95ff065f7b611c74534fbe326`, remains the base until #175 merges.
[History](roadmap-history.md#numeric-hashing-and-integer-output-pr-174) retains
its checks, measured improvements and remaining C/Rust gaps. The queued-function
proof, consuming sends and `tap` tuple removal are all in #175; do not reopen
old preparation branches as new work.

## Roadmap status

All seven areas in [PLAN.md](../PLAN.md) remain open.

| Step | Status | Work |
|---|---|---|
| 1 | In progress | Ownership and GC removal |
| 2 | In progress | Functional overhead |
| 3 | In progress | Machine performance |
| 4 | In progress | Autodiff |
| 5 | In progress | Numerical kernels |
| 6 | In progress | Reproducible comparisons |
| 7 | In progress | Larger applications |

 Persistent subscriptions,
resource captures, resource-owning tail frames and mutual recursion need further
proofs. JIT is excluded. Follow [AGENTS.md](../AGENTS.md): one active PR, all
final-head gates, bounded local work and one-line commits without trailers.

## Incidental test-reporting repair

The ARM64 macOS production log exposes five Linux resident-memory tests that
returned early but appeared as passes. The preparation now marks those tests
ignored outside Linux with the exact `/proc` requirement, and rejects missing
or failing C compilers instead of silently passing GC checks. A Unix import is
moved to the file's import block. Repair `bd9eb989` is published; `gc-checks` run `39368181540` is pending
on both Linux/macOS architectures; the full stress golden suite still runs on macOS. Historical
macOS passes do not establish the Linux-only resident-memory measurements.
