# Current work

**Next:** publish and dispatch recording-context-diagnostic against run
`42209117885` / source `b9de738671732289a6263a8db3c1a36e54a8cfd9`. It rebuilds the
saved AMD64 probe, reproduces exit 92 and prints the retained-storage counters.
Inspect that source/result before repairing ownership or the harness. No timing
session has run; do not dispatch measurements while the release check fails.

Branch `recording-context-scopes`, worktree `.worktrees/recording-capacity-gate`.
Base `d992a5734a12cf976c1ca20f75e9829a18bde0cc`.
[PR #265](https://github.com/e6qu/fun-with-pipes/pull/265) is the only active PR,
draft. First tested head `eab39aa9169d9245ba39eed0cb5cdd50f98f834a`;
Reference preparer `5bfdc2c23`; combined repair/current remote head
`b9de738671732289a6263a8db3c1a36e54a8cfd9`.

| Current run | Check | Last status |
|---|---|---|
| `42209117885` | All three hosts: only the new loop release probe fails | Failed |
| `42209127591` / `127863148988` | Sixteen suites, 121 controls; full log clean | Passed |
| `42209137797` / `127863168674` | Eight emitted-C comparisons; full log clean | Passed |
| `42209102269` / `127863034359` | Roadmap documentation | Passed |

Draft production run `42209102490` skipped; it is not an acceptance gate.

## Roadmap status

| Step | Status | Next result |
|---|---|---|
| 1 | Verified | Contract and #264 delivery committed as `5dc8efd02` before production edits. |
| 2 | Implemented | Call forwarding and loop scopes; verify tightened admission and repaired probes. |
| 3 | In progress | Focused GCC/Clang checks, reference controls, one measurement batch and complete audits. |
| 4 | Pending | Nine exact-head production jobs/docs, complete audit and verified squash merge. |

## Current native failure

All 75 target results reviewed: 24/25 targets pass on each host. ad_tape_scopes
has six passes and one failure: recording_context returns 92 in the first O1,
reuse-enabled/workspace-disabled probe. That code checks final heap/registry
release. It does not yet identify which counter differs; no cause is established.
The earlier nested-call probe and all preflight checks now pass on all hosts.

Current jobs: AMD `127863094516`, ARM `127863094512`, mac `127863094225`.
Complete logs: `/tmp/fwp-context-{amd,arm,mac}-second-job.log`.
The saved AMD artifact `13498354483` is 172,055,631 bytes; keep its full download
and diagnostic rebuild on a runner. The diagnostic must reproduce the original
failure before reporting counters; its success is not a passing safety gate.
Small completed reference/tool evidence is in
[the verification record](measurements/recording-context-checks-2026-11-06/README.md).

## First focused run and repairs

Run `42204680001`, suite gradient-call-checks: AMD `127848244993`,
mac `127848245176`, ARM `127848245215`. All failed; complete logs reviewed.
All 75 native target results were audited: 24/25 pass on each host;
ad_tape_scopes has five passes and two new probe failures on each.

| Failure | Repair in this batch |
|---|---|
| Clippy: exported_probe.rs loaded twice in ad_tape_scopes. | Declare it once in the parent; import it into both test modules. No suppression. |
| Nested-call mutation expected `= w5(`, but scalar calls include a result cast. | Match the explicit callee and borrowed argument. Keep the broken-forwarding control. |
| Loop fixture used map, which does not select PackedRecordPairs. | Use the required indexed range-zip producer. Point values are indices; the fold returns (length−1)². Keep selection and runtime assertions. |
| Docs `42204664978` / `127848184855`: wrong handoff heading/status labels. | Restore Roadmap status and the supported labels. Other docs controls passed. |

All three compiler unit logs: 304 passed, zero failed, four existing runner-only
tests ignored. Formatting, builds, primitive inventory, source-reference and
common selection checks pass. Preflight artifact hashes/source verified:
AMD `13497750861`, mac `13496669557`, ARM `13496624934`.
Full logs are `/tmp/fwp-context-{amd,mac,arm}-first-job.log`; preflight ZIPs use
`/tmp/fwp-context-preflight-{amd,mac,arm}.zip`.

## Implementation and safety

[The frozen contract](measurements/recording-context-scopes.md) governs this group.
`src/cgen/recording.rs` keeps the depth 64/expression 4096/type 32 proof limits.
Only repeated recording workers and selected pair-map/fold callbacks seed state;
their proved numeric callees borrow it. Standalone single-append functions gain
no state. Task ticks, lifecycle operations, reentry and unknown calls reject it.

`AD_RECORDING_SCOPES` enables explicit internal worker arguments. Ordinary entries
start fresh state; map/fold scopes remain separate. Ownership lowering can only
release plain numeric fields here, not invoke user cleanup. Every tape-ID change
still validates. The disabled reference preserves the earlier direct-push rule,
local declarations and calls. No runtime wrapper or public setting was added.

Existing tape probes cover nested calls, O0/O1/O2, ID changes, retired slots,
weights, parent/trap order, reuse and unwind. The new loop module covers empty,
singleton and growing buffers, input aliases, alternating IDs, map/fold traps,
workspace/reuse settings, and deliberate lost-scope/ID failures. New admission
unit tests cover useful roots, standalone exclusion and zero-argument calls.
These latest changes have not yet passed native validation.

## Comparison tools

New protocol `recording-context` is integrated with census, compiler/runtime
producers, budgets, full readers, native-image plans and workflows. The reference
changes only AD_RECORDING_SCOPES; earlier lookup/append/capacity changes stay on.
The actual-source observer passes on nine saved optimized C files from the first
run: two loop scopes, six direct map appends, one shared nested/fold append site,
and forwarding. This verifies emitted selection, not runtime lookup counts or
the later admission refinement.

New recording-context-parent runner check builds the delivered source and the
same-source disabled reference. Eight raw/optimized direct, nested, loop and
branch examples must emit byte-identical C. No old compiled binary is required.
All eight comparisons pass with a clean complete job log. Focused artifact audit
now reads the context results.

Incidental repair: check-descent-groups accepted recording-capacity but omitted
its reference metadata contract. It and check-array-list-evidence now share one
explicit contract; all four complete capacity-reference controls pass.

Guarded local results: new reference 5, capacity reference 4, native plan 6,
descent budgets 23, allocation budgets 9, census 10, measurement safety 3;
Rust formatting, Python syntax, handoff and workflow-size checks pass. Actionlint
syntax/expressions pass with shellcheck/pyflakes disabled. Missing sparse fixture
files were restored unchanged before budget/census checks passed. The scratch
saved-C check first lacked scripts on sys.path; corrected invocation passes.
No native build, full suite, benchmark or large audit ran locally. Last free space
75 GiB. Workflow size 508,518 bytes, below 512,000. Use the repository local guard;
do not rerun one-shot `/tmp/fwp-context-*` edit scripts.

## Previous verified delivery

[PR #264 receipt](measurements/recording-capacity-delivery-2026-11-06/README.md)
retains logs and archive identities. Tested `d453662e4226dbf613b5c8accc467a67fa12a359`,
merged `d992a5734a12cf976c1ca20f75e9829a18bde0cc`, identical tree
`7f2f64e1e45114c0e8b42a324254fe7f7f4939b3`. Squash subject
`Inline derivative tape capacity checks`, one line, empty body.
Nine jobs `42186095529` attempt 1, docs `42186063070` / `127786559808`, and full
audit `42197602289` / `127824662178` pass. Duplicate postmerge CI/docs were
confirmed cancelled after tree equality. Do not repeat these checks.

Long gains 1.86–14.02%; 17/32 meet 5%. Fifteen speed targets and one AMD64 copy
limit remain open. Allocations, validation, live storage and maximum frames are
unchanged; compiler comparisons pass. Preserve every earlier miss in PLAN.md.
