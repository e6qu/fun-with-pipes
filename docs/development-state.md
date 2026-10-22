# Session handoff

The [plan](../PLAN.md) remains open in all seven areas. Current work removes
avoidable ownership operations while preserving simple pipes, immutable values,
checked arithmetic and failure/cancellation cleanup. JIT is excluded.

## Current delivery: borrow array-generation captures

Main is verified #196 squash `abc2636d164632ea25ab5709455ab193a3df9479`.
[History](roadmap-history.md#array-owner-moves-and-copied-callback-strings-pr-196)
records its nine passing production jobs, documentation and inspected evidence.
The merge's tree, parent and one-line message were verified. Redundant same-tree
production run `39792888252` was cancelled; documentation was preserved.

Branch `array-capture-ownership`, worktree `/private/tmp/fwp-capture-delivery`,
contains [PR #197](https://github.com/e6qu/fun-with-pipes/pull/197), published at
`0367e81941a213b96de14dbe175143ff0a121f77`. Production run `39793823991` and
documentation run `39793823875` are active; inspect the audit receipt for exact
job states (running versus queued). Do not republish or change this head
while gates run. Publication receipt: `/private/tmp/fwp-capture-delivery-publication.json`. Preparation `a23cbe6c95d63969f5df285718af64f56eb480fd`
was applied onto #196's merge and verified as an identical tree before updating
this handoff and history. Compiler/runtime/native-test files remain unchanged.
The integration receipt is `/private/tmp/fwp-capture-delivery-integration.json`.

The compiler lets eligible known numeric `array.generate` callbacks borrow values
kept alive by their caller. It also removes temporary parameter-record and
last-read alias owners. Escaping values still acquire owners; recursive callbacks
and resource scopes keep their ordinary convention. Tests preserve count/capture
preparation order, shared inputs, state, errors, yields and partial-array cleanup.
No new syntax, wrapper or ownership-IR convention was added.

The batch also reports all count/storage budget failures across benchmark inputs,
keeps independent audits running after a failed check, and repairs a macOS shell
assignment that could hide `xcrun` failure. Incorrect output, broken cleanup,
invalid raw traces and tool failures still stop immediately. An earlier proposal
to move the early cleanup assertion was rejected by automatic review; that
assertion remains unchanged, with no approval pending.

**Next:** run `/private/tmp/fwp-audit-197-final.py` and inspect every final-head
gate. Fix all failures together. Publication and merge are authorized;
require all nine production jobs and documentation for the exact commit, verified
against the PR's completed successful checks. GitHub's workflow summary can lag;
retain its actual state separately. Squash-merge with an explicit one-line subject
of at most 80 characters and empty body, then verify tree, parent and message.
Focused preparation alone never authorizes merge. Ready helpers
`/private/tmp/fwp-merge-197.py` and `fwp-after-merge-197.py` have not run. Do not open another PR while
this delivery is active; independent preparation may continue.

## Accepted focused evidence

| Check | Source/run | Result |
|---|---|---|
| Native ownership and width | Compiler `80d8f27e1bf57e4665503d6d1ed1af261f7dc672`, run `39783028890` | Five native hosts and width job pass; original AMD64 native checks pass but a new unit fixture fails |
| Corrected AMD64 fixture/audits | `3e5763b69ed075516bcbadf5d18dcb2a12f98078`, run `39789349262` | Passes, including all 179 compiler unit tests; production code is unchanged |
| Numerical comparison | `d1467854766fd93fa6e6c768d42f35e83fec3c1a`, run `39786472473` | Both numerical jobs pass; 132 images inspected; workflow summary still reports running in the last audit |

The [ownership report](measurements/array-capture-borrows.md) retains all 558
inspected native images, twelve WASI modules and complete-log audits. Deliberately
broken controls add retains, leak owners or omit partial releases. The extra
O0/O2 effect-order tests execute in logs, outside the saved-image count.

The failed unit fixture used a list type deliberately excluded from direct
borrowing but expected alias removal. Its correction checks eligible numeric
arrays and verifies excluded list aliases still acquire owners, including escapes.
The original failure and corrected job remain separate in the evidence; nothing
was waived. The combined preparation verifies unchanged production code.

## Numerical result and remaining gaps

The [comparison](measurements/array-capture-descent.md) measures packed fwp against
its rebuilt previous compiler, AD/list fwp and C/Rust implementations. For 129
coordinates and 199 updates, retains fall 25,671 → zero on both Linux hosts.
Allocation requests stay at 459, requested bytes at 216,925 and managed peak at
7,200 bytes. Managed/raw storage ends at zero, with no tracing collections.

Largest new/old median ratios are 0.7216 AMD64 and 0.7983 ARM64; new/C is
2.3300/2.3754 and new/Rust 2.0138/1.9761. AMD64's one-update identical-code control
differs by 10%; ARM64's one-update candidate is 0.8% slower. No general speed claim
or timing budget. The update frame shrinks 112 → 96 bytes while instruction
sections grow 144/112 bytes. Actual instructions and dynamic-frame qualifiers
remain in the data. Earlier failed count requirements are preserved in the report.

After delivery, separate remaining dynamic calls, bounds checks and output costs
before selecting another numerical optimization. Establish stable repeated timing
controls and a per-input budget. Continue the ownership boundaries and finite
application suite in the plan; zero retains here do not finish GC removal.

## Independent preparation: scalar helper call costs

Branch `measure-descent-call-costs`, worktree `/private/tmp/fwp-descent-call-costs`,
starts at #197 head `0367e819`. It does not change the compiler. A new
`scripts/measure-descent-call-costs.py` compares saved packed-descent C with an
explicit inline hint and forced-inline edit to helper `w36`, plus two byte-identical
controls and the existing C/Rust peers. The `descent-call-costs` workflow suite
runs on native Linux AMD64/ARM64 without a Rust compiler build of fwp.

`docs/measurements/descent-call-protocol.md` records the experiment before timing:
all six prior inputs, 56 samples/two warmups, balanced ordering seed 20261022.
The 129×199 decision case needs both identical-code controls within 2%, candidate
median at most 0.95 of unchanged fwp, and instruction bytes at most 1.02, with
identical outputs and managed/raw profiles for every case. Require two independent
runs on matching CPU models for both architectures before selecting any compiler
rule. A failed timing screen is diagnostic evidence, not a waived correctness test.

A bounded local Clang counterfactual preserves output/count/storage and removes
four static helper call sites while adding 144 instruction bytes. It is not a
timing or GCC claim. The first diagnostic script misread the raw-profile JSON path;
the corrected check passes in 2.43s. Evidence:
`/private/tmp/fwp-descent-inline-diagnosis-checked/report.json`.
Guarded `fwp-check-descent-call-probe.py` passes 72 saved-source edits, Python syntax,
workflow and docs in 6.74s. Full diagnostic timing stays on GitHub. Preparation
publication is next; do not open another PR while #197 is active.

## Resume files and validation

Paths below are under `/private/tmp/`. Publication helpers already ran for the
preparation sources; do not repeat those mutations. The delivery has its own
integration/publication records. Query its branch/PR before publishing again.

| Purpose | Files |
|---|---|
| #196 acceptance/merge | `fwp-196-final-acceptance.json`, `fwp-196-merge-runs.json` |
| Prepared batch | `fwp-array-capture-final-preparation.json`, `fwp-capture-preparation-acceptance.json` |
| Original compiler checks | `fwp-array-captures-publication.json`, `fwp-array-captures-acceptance.json` |
| Corrected fixture | `fwp-capture-test-repair-publication.json`, `fwp-capture-test-repair-acceptance.json` |
| Numerical checks | `fwp-capture-reporting-publication.json`, `fwp-capture-descent-acceptance.json` |
| Artifacts | `fwp-array-captures-evidence/80d8f27e1bf5/`, `fwp-capture-descent-evidence/d1467854766f/` |

Guarded preparation checks pass: format/workflow/docs/baseline reconstruction
8.24s on the delivery checkout; new report links/counts/provenance 0.25s; budget controls 0.14s. Native and
numerical artifact inspection is complete; do not repeat downloads without a
new reason. Saved-interpreter checks do not verify new C generation.

Keep local checks serial under `python3 scripts/local-guard.py`; full builds,
suites and benchmarks stay on GitHub. Preserve 64 GiB free disk, targets below
2 GiB, sampled workload RSS below 1 GiB and the 180-second deadline. Never raise
limits automatically. Earlier cleanup removed only completed archives and clean
inactive worktrees; preserve remaining receipts, branches and modified worktrees.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and limit ARC at remaining boundaries |
| 2 | In progress | Extend proved borrowing and remove functional overhead |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels |
| 6 | In progress | Stabilize comparisons and set workload budgets |
| 7 | In progress | Complete the finite application acceptance suite |
