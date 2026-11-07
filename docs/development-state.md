# Current work

**Next:** monitor the four runtime sessions in `42417868388` and compiler costs in
`42418398638`; audit every completed result before deciding the next change.
Keep PR #269 draft until this substantial batch is ready for final platform gates.

## Branch and current sources

[PR #269](https://github.com/e6qu/fun-with-pipes/pull/269), branch
`tape-record-evidence`, worktree `.worktrees/recording-capacity-gate`.
The root worktree has unrelated changes; do not modify/reset it.

- Runtime source: `8b24da94a4e54c023f5e4b2341896d97dff092b9`.
- Compiler-cost source: `8389403c5`; same native sources and tests.
- Frozen baseline for compiler costs: `f1cc94cf4e013369cccb8a836bd745f41e5d757c`.
- Original local-derivative contract: `524524bd3`; revised computed-input proof:
  `250cf62a0`. [Exact boundaries](measurements/direct-numeric-workers.md).

The repair binds each computed numeric input once before reading its fields.
It preserves original scopes and left-to-right evaluation, with no function
cloning. The prototype remains in `tests/fixtures/descent_local_ad.fwp`; no
public derivative API has been added and no timing acceptance is claimed.

## Roadmap status

| Step | Status | Evidence and remaining work |
|---|---|---|
| 1 | Verified | Three focused native jobs pass nine compiler proofs, mixed ownership at O1/O2 and local derivative values/traps. The actual edge selects four numeric fields. Full platform coverage remains step 4. |
| 2 | In progress | Four changed-program runtime sessions are measuring; exact request/retain parity with handwritten arrays and the frozen timing limits remain required. |
| 3 | In progress | Seven-case compiler comparison and complete audit are running. Public interface depends on verified runtime acceptance. |
| 4 | Pending | Final-head nine production jobs, documentation and complete audits; then authorized squash merge. |

## Running jobs

Runtime producer `42417868388`:

| Host/session | Job |
|---|---|
| AMD1 | `128541267009` |
| AMD2 | `128541266975` |
| ARM1 | `128541267023` |
| ARM2 | `128541267002` |

The [21 native probe images and complete logs](measurements/computed-numeric-inputs-2026-11-07/README.md)
are verified and retained. Its passing native prerequisites are ARM `128539754453`, AMD `128539755075` and
Mac `128539754700`. Compiler producer `42418398638` has ARM job `128541365464`
and AMD job `128541365535`; the workflow audits both afterward. ARM passes all
limits. AMD stays within every 5% time/RSS budget, but copy variation is 2.41%
for field-transfer and 3.35% for the tutorial; retain both inconclusive timings.
Complete compiler audit job `128542895551` is queued.

Original-observation retention run `42418518671`, job `128541726131`, repacks and
re-audits all four initial prototype sessions. It does not repeat timings.
After the new runtime run completes, dispatch `local-derivative-audit` with its
run ID, exact source and `numeric_representation=numeric` to retain all files.

## Results and repaired failures

[First prototype results](measurements/local-derivative-time-2026-11-07/README.md),
run `42413370794`, source `0ddde8224c3ab39e9ef4d9770483a72372b17c42`:
all four complete observation audits pass. Five timing misses remain. Largest
solves are 24–31% faster than ordinary reverse AD but make 407,552 extra managed
requests versus handwritten fwp arrays. These equal two Dual inputs per edge.

[Failed hypothesis](measurements/numeric-input-diagnosis-2026-11-07/README.md),
source `9cb7497f3`, run `42417084281`: all hosts pass nine unit tests and fail
only actual-edge selection. Computed arguments, not function-value references,
block the call. Integration tests and timings were skipped. Full logs are
retained. Speculative worker cloning was removed before the passing repair.

The first prototype's formatting failure and repaired native probes are retained
[here](measurements/local-derivative-checks-2026-11-07/README.md).
Two links to a moved plan heading were repaired; docs `42415160614` and
`42417087519` pass. Final-head docs remain required.

## Completed carried evidence

[PLAN.md](../PLAN.md#completed-work-carried-in-this-pr) links the corrected four
layout audits, 48 original image reproductions, fourteen compiler comparisons
and #268's complete production audit. Earlier misses remain in
[unmet comparisons](measurements/unmet-comparisons.md). These are evidence,
not a reason to repeat unchanged measurements.

## Local checks and delivery

Guarded checks: five local-derivative measurement controls (0.13 s), eleven
compiler-cost controls (3.44 s), Rust formatting (0.13 s), workflow validation
(0.13 s), retention-script syntax (0.13 s), and all four original archive/report
hashes plus 144 peer rows (0.25 s). Earlier historical reader controls pass.
The plan link check initially lacked two sparse-checkout docs; restoring their
tracked files fixes the setup and all current plan/handoff links pass (0.13 s).
Full builds, suites, benchmarks and large retention stay on GitHub. Last free
disk check: 89 GiB; minimum 64 GiB. Stop on guard refusal, never raise limits.

Hosted slots can be busy: do not restart queued work or infer billing. Keep one
active PR. Final-head nine production jobs, docs and audits gate merging.
Supply an explicit squash subject <=80 characters with an empty body, no
trailers/attribution; verify the resulting tree/message. Continue the plan after
verified delivery. Do not treat smaller allocation counts as a timing pass.
