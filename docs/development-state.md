# Current work

**Next:** monitor all three hosts in focused run `42213041403` at
`49371e06f5bba4598273a1b807140775dde64c57`. The repaired fixture requires a real
recovery boundary. All hosts are running; no failed step has appeared. Reference
comparison `42213046373` and docs `42213039124` pass, complete logs reviewed.
After native checks pass, audit every result before dispatching the measurement
batch. No timing session has run.

Branch `recording-context-scopes`, worktree `.worktrees/recording-capacity-gate`.
Base `d992a5734a12cf976c1ca20f75e9829a18bde0cc`.
[PR #265](https://github.com/e6qu/fun-with-pipes/pull/265) is the only active PR,
draft. First tested head `eab39aa9169d9245ba39eed0cb5cdd50f98f834a`;
Reference preparer `5bfdc2c23`; combined compiler repair
`b9de738671732289a6263a8db3c1a36e54a8cfd9`; `13aa113ae` added only the diagnostic and retained reference/tool checks.
Native repair source `49371e06f5bba4598273a1b807140775dde64c57` repairs the fixture.
The pagination repair changes only audit tools and verification records.
The native-source docs replacement passes. The latest audit-tool/docs commit
requires its own docs gate; no native source changed after `49371e06f`.

| Current repair run | Check | Last status |
|---|---|---|
| `42213041403` | Native checks: AMD `127876137274`, ARM `127876137456`, mac `127876137522` | Running |
| `42213046373` / `127876155092` | Eight raw/optimized reference C comparisons | Passed |
| `42213039124` / `127876122034` | Native-repair documentation; full log clean | Passed |

Earlier results at compiler source `b9de738671732289a6263a8db3c1a36e54a8cfd9`:

| Run | Check | Result |
|---|---|---|
| `42209117885` | All three hosts: only the new loop release probe fails | Failed |
| `42209127591` / `127863148988` | Sixteen suites, 121 controls; full log clean | Passed |
| `42209137797` / `127863168674` | Eight emitted-C comparisons; full log clean | Passed |
| `42209102269` / `127863034359` | Roadmap documentation | Passed |

Draft production runs `42209102490` and `42213039217` skipped; neither is an
acceptance gate. All final-head production jobs remain required.

## Roadmap status

| Step | Status | Next result |
|---|---|---|
| 1 | Verified | Contract and #264 delivery committed as `5dc8efd02` before production edits. |
| 2 | Implemented | Call forwarding and loop scopes; verify tightened admission and repaired probes. |
| 3 | In progress | Focused GCC/Clang checks, reference controls, one measurement batch and complete audits. |
| 4 | Pending | Nine exact-head production jobs/docs, complete audit and verified squash merge. |

## Repair awaiting native verification

All 75 target results reviewed: 24/25 targets pass on each host. ad_tape_scopes
has six passes and one failure: the new loop probe returns 92 at O1, reuse on,
workspace off. Jobs: AMD `127863094516`, ARM `127863094512`, mac `127863094225`.
Complete logs: `/tmp/fwp-context-{amd,arm,mac}-second-job.log`.

Diagnostic `42211595925` / `127871298573` reproduces the original 92 before
instrumentation. At count=4, invalid-parent mode=2, alias=0: managed live=208,
baseline=0; registry/capacity/cache/wide counts are zero. Artifact `13499112406`,
378,998 bytes, hash `3234f7efa56548fe0090b1913bb299ad51a18dff8033710eb85e26f33fdde69d`,
verified locally; source `/tmp/fwp-context-failed.c`.

Root cause: the fixture's main had no recoverable boundary and generated
FWP_UNWIND=0. The C harness installed longjmp recovery anyway. Cleanup generation
in src/cgen.rs and runtime value protection correctly omit exceptional frames in
that mode. The test now uses attempt in main and requires FWP_UNWIND=1 before
injecting traps. Keep all storage/alias/count assertions. The release failure
also prints its case and counters for future diagnostics. No production compiler
or runtime change is justified by this harness error. Verification is pending.

Small completed reference/tool evidence is in
[the verification record](measurements/recording-context-checks-2026-11-06/README.md).
The full 172 MB failed artifact stayed on a runner; only the 379 KB diagnostic
was downloaded. No disassembly or timing was used to diagnose this failure.

Earlier failures, repairs and their job IDs are retained in
[the verification record](measurements/recording-context-checks-2026-11-06/README.md#earlier-failures-and-repairs).

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
Source review confirms that both loop states start after setup and allocation.
The proof excludes callbacks that can invalidate registry entries, and boxed
entries start fresh state. This review does not replace native validation.

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
75 GiB. Workflow size 508,579 bytes, below 512,000. Use the repository local guard;
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

## Audit pagination repair

The actual focused run has 128 jobs. The focused and production artifact auditors previously read only
one 100-job page; today's three native jobs happen to be on that page. They now
read every page, rejecting truncated, duplicate or changing listings. All six
production-audit controls pass under the local guard (0.13 s); the guarded actual
metadata check reads all 128 jobs (2.63 s). No artifacts were downloaded for it.
Affected census, compiler-cost, diagnostic and HTTP artifact readers are also
repaired. Shared pagination logic takes an explicit request function; imports
come from its defining module. Six controls and Python/embedded-program syntax
pass; Actionlint syntax/expressions pass with shellcheck/pyflakes disabled. Docs CI also runs these
controls; this tool-only repair needs no repeated native build.

Changed document links, handoff steps and workflow sizes pass under the guard
(0.13 s). Whitespace checks pass. The earlier 121-control CI record stays tied to
its original source; it does not include the two new pagination controls.

## Queue observations

The repair runs queued at 11:49 UTC began receiving runners around 12:29 UTC.
All three native hosts are now active; the reference/docs jobs passed. The cause
of the queue delay is unknown. Do not restart completed or active native work.
An unrelated October 16 run `38888712709` on owned-cpu-kernels is inconsistently
listed in_progress, but all 24 job records are complete (six failed, others
skipped). It has no reference in the current plan/handoff/history/queue and no
associated PR. Normal and force-cancel endpoints both returned HTTP 409,
"not in progress". No jobs/artifacts were deleted. This is not evidence that the
old run causes the current queue delay; keep monitoring the active repair runs.
