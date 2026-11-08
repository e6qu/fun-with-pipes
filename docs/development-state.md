# Current work

**Next:** finish the exact-head nine-job production CI and documentation for
PR #269, audit every completed job, fix all failures together, then squash-merge.
The PR is now ready for review. Draft status had skipped CI; use normal PRs
unless the user explicitly requests a draft.

## Branch and current sources

[PR #269](https://github.com/e6qu/fun-with-pipes/pull/269), branch
`tape-record-evidence`, worktree `.worktrees/recording-capacity-gate`.
The root worktree has unrelated changes; do not modify/reset it.

- Measured runtime/compiler repair: `8b24da94a4e54c023f5e4b2341896d97dff092b9`.
- Compiler-cost source: `8389403c566230680b61949e6e5e6837293215bf`; same native sources/tests.
- Frozen compiler reference: `f1cc94cf4e013369cccb8a836bd745f41e5d757c`.
- Original runtime contract: `524524bd3`; revised computed-input proof: `250cf62a0`.
  [Exact boundaries](measurements/direct-numeric-workers.md).

The compiler binds each computed numeric input once, in original scopes and
left-to-right order, then passes its numeric fields. No function cloning, new
syntax or public API. The local derivative helper stays in
`tests/fixtures/descent_local_ad.fwp`; frozen timing acceptance remains open.

## Roadmap status

| Step | Status | Evidence and remaining work |
|---|---|---|
| 1 | Verified | GCC ARM64/AMD64 and Clang ARM64 pass nine compiler proofs, mixed ownership at O1/O2 and local derivative values/traps. All 21 native images retained. Full platforms remain step 4. |
| 2 | Implemented | All six cases match handwritten-array allocation/retain counts, with no extra managed peak and zero tape/final storage. Qualified long solves are 48–65% faster than reverse AD. One AMD copy control remains inconclusive. |
| 3 | Implemented | All fourteen compiler comparisons meet 5% time/RSS limits; two AMD copy controls remain inconclusive. Complete audits pass. Retain the compiler reduction; no public helper promotion or timing waiver. |
| 4 | In progress | Complete final-head nine production jobs, documentation and log audit; then authorized squash merge. |

## Completed measurements and audits

[Runtime results](measurements/computed-numeric-time-2026-11-07/README.md),
producer `42417868388`: ARM jobs `128541267023`, `128541267002` and AMD1
`128541267009` pass. AMD2 `128541266975` fails only the 3/199 identical-copy
control (2.0845% versus 2%). All four complete observation audits pass.
Retention run `42419504241`, job `128544674265`, passes and preserves all process
observations, native images, logs and the miss. No timing was repeated.

The largest process drops from 409,297 to 1,745 managed requests: 407,552 temporary
input records removed. Its elapsed time is 56–59% lower than reverse AD, but
still 4.2–5.7 times handwritten C's time. Both fwp array versions share much of
that gap; its cause is not yet established. Do not attribute it to ARC or caches
without measurement. Requested traffic and live memory remain separate metrics.

[Compiler results](measurements/computed-numeric-analysis-2026-11-07/README.md),
producer `42418398638`: ARM job `128541365464` passes; AMD `128541365535` fails
only field-transfer candidate-copy (2.41%) and tutorial reference-copy (3.35%)
controls. Every time/RSS comparison stays within 5%. Complete audit job
`128542895551` passes; all 336 commands plus six preflights per host are retained.

[Focused native evidence](measurements/computed-numeric-inputs-2026-11-07/README.md)
passes: ARM `128539754453`, AMD `128539755075`, Mac `128539754700`.
Actual emitted local-edge takes four doubles. No new production source changes
follow these focused tests and measurements.

## Earlier evidence and repairs

The [first prototype](measurements/local-derivative-time-2026-11-07/README.md)
retains five timing misses and its original allocation cost. Complete retention
run `42418518671`, job `128541726131`, passes without repeating timings.

The [failed cloning hypothesis](measurements/numeric-input-diagnosis-2026-11-07/README.md)
at `9cb7497f3`, run `42417084281`, failed actual-edge selection on all hosts.
Computed arguments were the blocker. Cloning was removed before the passing repair.
Earlier formatting and native probe results remain
[here](measurements/local-derivative-checks-2026-11-07/README.md).

[PLAN.md](../PLAN.md#completed-work-carried-in-this-pr) links the corrected layout
audits, original image reproductions, compiler comparisons and #268 production
audit. These older gates do not verify this compiler change.
[Earlier timing misses](measurements/unmet-comparisons.md) remain evidence,
not a queue of unchanged reruns.

## Local checks and delivery

Guarded checks pass: five measurement controls (0.13 s), eleven compiler-cost
controls (3.44 s), Rust formatting, workflow validation, retention-script syntax,
21 native image/header/hash checks, four runtime report archives and 144 peer
rows, all complete observation archive digests and compiler audit summaries.
Each remaining check took 0.13–0.36 s. Sparse-checkout link prerequisites were
restored from tracked files. Full builds, suites, benchmarks and large audits
stay on GitHub. Last free disk: 89 GiB; minimum 64 GiB. Never bypass guard limits.

Documentation at `45e22bdd4` passed run `42419425639`; final-head docs are still
required. Do not count draft-skipped production jobs as passes. Hosted slots
can be busy: wait for queued jobs rather than restarting or inferring billing.
Audit completed targets and diagnostics before a repair push. Supply an explicit
one-line squash subject <=80 characters and an empty body, without trailers or
attribution; verify the resulting tree/message. Continue the plan after delivery.
