# Session handoff

All seven areas of [PLAN.md](../PLAN.md) remain open. Continue grouped deliveries;
JIT is excluded. Ownership, borrowing and removal of tracing remain the priority.

## Accepted baseline

The user merged [PR #197](https://github.com/e6qu/fun-with-pipes/pull/197) as
`b94710c9212cbbfc3e39409835e539b371069b36`. All nine production jobs
(`39793823991`) and documentation (`39793823875`) passed for exact head
`0367e81941a213b96de14dbe175143ff0a121f77`. Complete logs were audited; the
merge has the same tree, expected sole parent and one-line message under 80
characters without trailers. Do not merge it again. Receipts:
`/private/tmp/fwp-197-final-acceptance.json`, `/private/tmp/fwp-197-user-merge.json`.
No duplicate main production run was present at the merge check.

[Borrowed array captures](measurements/array-capture-descent.md) remove the
largest numerical case's remaining 25,671 retains, with unchanged 459 requests
and 7,200-byte managed peak. This does not complete GC removal or C/Rust parity.
[History](roadmap-history.md#borrowed-array-captures-pr-197) preserves acceptance.

## Current combined delivery

Branch `direct-call-entries`, worktree `/private/tmp/fwp-direct-entry-delivery`,
is based on #197's verified merge. The numerical preparation head is
`927c6b1852a69748ae613291d89774bb8ae31121`; this delivery includes the grouped
repairs and completed reports below. Publication records the final head and PR
in `/private/tmp/fwp-direct-callback-delivery-publication.json`. Preparation was integrated as `105bda29`;
`/private/tmp/fwp-direct-entry-integration.json` verifies its complete tree.
The old `/private/tmp/fwp-descent-call-costs` preparation is inactive.

This delivery combines the explicitly approved tasks:

- Emit generic call adapters only for function values and external dispatch;
  preserve service and transport-created iterator entries.
- Keep eligible `array.generate`, `fold` and `fold-right` captures in local
  values. Preserve evaluation order, typed cleanup and lifetime barriers.
- Test repeated/stored callbacks, ordinary application, empty inputs, errors,
  cancellation and ordering, including deliberately broken ownership controls.
- Observe managed/raw live storage after every repeated solve. Demonstrate that
  final-only checks miss a deliberately delayed release.
- Report complete C/Rust work and remaining costs clearly, preserving all slower
  cases, timing-control failures and actual machine-code evidence.

The [design](design.md) explains capture eligibility. Escapes, aliases, ordinary
calls, resource scopes and recursive tail frames keep their representation.
Stack-disabled compilation keeps it too. These are preparation changes until
final production gates pass.

## Completed evidence and failures

The [adapter-only comparison](measurements/direct-call-entries.md), source
`e681dc447039cd1ce5fbf4a27add9e96f9238275`, passed numerical run `39806328073`:
132 inspected executables, smaller code, no demonstrated timing improvement.
All six native jobs in `39806320364` failed one new test's invalid ARC stress
setting. Their other tests produced 714 inspected native images; twelve executed
WASI modules also passed inspection. Failed jobs are not accepted deliveries.
The first repair, `b9ff767c`, still enabled prohibited ARC reuse verification;
run `39812255716` failed that test. Both failure histories are retained.

Expanded source `927c6b18` passed both numerical jobs in `39816519529`.
[All 132 images](measurements/callback-locals.md) are inspected. Largest-case
instructions fall to 33,570 bytes on AMD64 and 31,612 on ARM64, with one generic
entry left. Allocation/count/storage budgets remain unchanged. AMD64's largest
new/old time is 1.3209 with a 17.5% identical-copy difference: no speed claim.

Expanded native run `39816514377` completed with three failures across two
out of seventeen integration targets. Both new array tests request prohibited
ARC reuse verification. The right-fold unwind test instruments an owned adapter
that the new compiler removes. Other integration targets, clippy, 179 unit tests,
contract/coverage audits and missing-compiler controls passed. The caught gRPC
startup-timeout panic is a passing negative control, recorded separately.
Auditor/receipt: `/private/tmp/fwp-audit-expanded-captures.py`,
`/private/tmp/fwp-expanded-captures-acceptance.json`. All failures were audited.

The grouped repair disables tracing/reuse verification in ARC-only tests while
retaining them in tracing tests. It instruments the actual borrowed right-fold
body and preserves all cleanup/cancellation/injected-failure assertions. Production
CI now saves array/callback/fold-unwind binaries for inspection on every native
host, avoiding another six-host preparation run. The repaired tests have not yet
run with the new compiler; do not count the earlier failed jobs as acceptance.

[Initial repeated-work measurements](measurements/descent-batches.md), run
`39812251121`, pass with 96 inspected images. The largest complete solve takes
9.81–12.00× C time and 12.30–17.13× Rust time. Formula evaluation, buffers,
checked indexing and formatting differ; these are not isolated compiler costs.
[The observer run](measurements/descent-observers.md), `39816523757`, passes
with 104 inspected images. All 512 per-solve observations are zero; delayed
release fails 225 while the final-only control succeeds. C/Rust/fwp machine loops
retain full repeated computation. This run rebuilds saved adapter-only sources,
not the new capture-local compiler. Both runs retain failed timing controls.

The earlier [inline experiment](measurements/descent-call-costs.md) passed both
hosts in `39798044726`, with 120 inspected images. Neither candidate met the
predeclared 5% speed screen. No inlining rule was selected.

## Next action

**Next:** publish the checked combined delivery, then audit all nine exact-head
production jobs plus documentation. Consult the publication receipt before
creating a PR or dispatching work again. Inspect its saved capture/unwind binaries; fix every failure
together. Squash merge is authorized after acceptance: explicit subject at most
80 characters, empty body, no trailers. Verify tree/parent/message and continue
PLAN.md in substantial groups. No permission question is pending.

Bounded checks use `python3 scripts/local-guard.py COMMAND...` in the delivery
worktree. `/private/tmp/fwp-check-expanded-preparation.py` passed source edits,
observer transforms, formatting, docs, workflow and budget controls (7.44s).
The grouped repair also passed Rust formatting, production workflow lint,
new-report links and native shard/failure controls (15.57s); see
`/private/tmp/fwp-check-combined-repair.py`. Earlier six two-solve C controls
passed (3.06s); the fixture's saved-interpreter check passed (0.37s). A saved ARC
binary accepted the corrected environment and rejected each forbidden option
(0.25s). These focused checks do not replace new-compiler CI.

## Local resources

Keep checks serial/low priority; full builds, suites and timing run on GitHub.
Preserve 64 GiB free disk, targets below 2 GiB and sampled aggregate RSS below
1 GiB per workload; never raise the guard's 180-second deadline. Latest free space
is about 66 GiB. The earlier guard refusal was resolved by removing two verified
clean, inactive worktrees; modified worktrees and evidence were preserved.
Receipts: `/private/tmp/fwp-clean-worktrees-20261022-second.json` and
`/private/tmp/fwp-clean-worktrees-20261022-third.json`. Do not rerun publication,
integration or cleanup helpers with existing receipts.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and limit ARC at remaining boundaries |
| 2 | In progress | Extend borrowing and remove functional overhead |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels |
| 6 | In progress | Stabilize comparisons and set workload budgets |
| 7 | In progress | Complete the application acceptance suite |
