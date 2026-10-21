# Session handoff

## Next action

Next: finish the handler inference repair discovered while testing socket queues,
then complete focused and production validation for [PR #184](https://github.com/e6qu/fun-with-pipes/pull/184).
Branch `prove-retained-resource-ownership` is based on accepted merge
`447a18f8b1ac4b7faa2c655fa2ea7a24d4e0c44c`; published head is `f448c3b7`.

All six native socket jobs in `39563352313` have passed their test steps (last
Intel macOS artifact upload was finishing). Five complete logs and 20 saved
binaries have been audited; finish the sixth and generate the evidence report.
The repair stays in this PR: `attempt (apply ())` incorrectly retained Error in
its result type because argument weakening inserted the handled label into a
temporary row, losing its relationship to the callback input. The same pattern
can affect State handlers and returned records. `src/infer.rs::argument_type`
now preserves labels where the callee shares the remaining row with its output;
this is structural, not a special case for named handlers. New `call_effects`
checks cover aliases, records, State, native/interpreter agreement, and rejection
of unrelated IO effects. Probe `39566088635` completed with four `call_effects` failures: two came from
ambiguous pipe grouping in the new deferred-function example; two exposed the
need to distinguish produced functions from accepted callbacks. Other unit and
socket/resource targets passed. Both causes are repaired locally: use an explicit
application for the function-valued record field, and follow input/output
direction through function types and actual record/variant fields. A new
`Consumer` record control passes in the accepted compiler and must keep passing.
The revised changes are not yet remotely tested. Publish with
`suite=queued-sockets,native_runner=ubuntu-latest` for early feedback, then use
all platforms and the full nine production gates before merge. Existing source
acceptance and missing-effect rejection tests must keep passing.

The audit found that `src/infer.rs::check_effects` already rejects partial
applications capturing `File`: reusable functions cannot consume a single-use
file repeatedly. Preserve that rule. Socket handles are shared values instead;
their runtime headers cannot own callbacks or queues, and their final owner
closes the descriptor. `src/arc_scope.rs` now admits `UdpSocket`, `Listener` and
`Conn` captures while preserving other mutable-owner rejections. See the
[queued-function contract](ownership.md#functions-stored-in-channels).

`tests/queued_functions.rs` adds a 64-round socket regression, native owner
counters, descriptor-close checks, complete ARC teardown and deliberately
omitted queue-release/socket-close controls. It covers received callbacks called
twice, closed and undrained queues, aliases, caught failure, blocked senders and
cancellation during UDP receive, TCP accept and TCP read. Unit tests preserve
rejection through mixed records and recursive containers.

Focused `queued-sockets` run `39563352313` tests published head `2121a9b5`.
Audit every failure, then require all nine production gates and docs at the final
head. Use `/private/tmp/fwp-audit-184-sockets.py` to retain complete job logs. This focused option retains six native platforms and tests the
changed queue proof alongside socket/resource cleanup. The broader `channel-proof`
run `39561654177` at `9232cdf4e790dbe2b728cb0e5d96c1a55ab4fd4d` is still finishing.
Both WASI jobs passed; the completed Linux AMD64 job found only the new fixture's
three task-effect errors. Those are repaired together: handle IoError with
`attempt` before spawning, and declare the existing task callback effect set.
Continue auditing every other job; receipt `/private/tmp/fwp-184-focused.json`.
No new native socket queue support is verified yet.

For lightweight local source checks, the accepted PR #183 macOS ARM64 compiler
is `/private/tmp/fwp-183-macos-compiler/fwp-macos-arm64/fwp`. Both its artifact
archive and executable hashes were verified against GitHub/manifest metadata;
receipts are beside it. It predates this ARC eligibility change, so use it only
for unchanged source semantics, formatting and tracing C emission. Under
`scripts/local-guard.py`, `check tests/fixtures/queued_sockets.fwp` passes;
`run --interp` with and without `FWP_NO_OPT=1` matches the expected 64-round output
(10.31s and 10.30s). Tracing `build --emit-c` passes without compiling C locally.
The generated C is `/private/tmp/fwp-184-sockets-baseline.c`; instrumentation sites
are unique. This is not native execution evidence for the candidate compiler.

`cargo fmt --all -- --check`, `git diff --check`, the primitive inventory (394
declarations, 384 symbols, 40 aliases), doc links and all 11 native-runner tooling
tests pass under the guard; the combined last check took 12.86s. An initial
wrong-edition formatter invocation was corrected before this run; obsolete
focused run `39561434828` is cancelled. Read [PLAN.md](../PLAN.md),
[ownership](ownership.md) and relevant [design](design.md) sections before edits.

## Accepted delivery

[PR #183](roadmap-history.md#checked-product-bounds-pr-183) is squash-merged.
All nine production jobs in `39543123372` and documentation `39543123369` passed
at `3606d072d0f708b600f44050ab9cafe1390bceee`. Every complete log was audited clean.
Merge `447a18f8b1ac4b7faa2c655fa2ea7a24d4e0c44c` has the identical tested tree
`40b47a0670c38bc0b05c6dbd1afefd3ad5f7d7c5`. Its verified message is exactly
`Preserve numeric bounds after checked multiplication`: one line, 52 characters, no body,
trailers or attribution. Receipt: `/private/tmp/fwp-183-final-acceptance.json`.
The redundant post-merge production run `39557406360` was cancelled after tree
verification; post-merge documentation `39557406176` passed.

The [measurement guide](measurements/checked-products.md) and
[raw report](measurements/checked-products-2026-10-21.json) retain the comparisons,
binary evidence and limits. O2 counting loops improve, but matched C remains
faster, AMD64 timings vary by CPU and O0/O1 emit an extra product. Tracing remains
in the measured binaries. These results do not finish a roadmap work area.

## Evidence and local resources

Measured source `b57e2dcda716ebd27007d01aaf5e4e79d22518b6` remains available through
`roadmap/revision-checked-product-b57e2dcd`. Focused run `39536765734` passed on
both Linux architectures, including actual compiler C/instruction equality,
runtime-input and sanitizer controls. Receipts: `/private/tmp/fwp-range-native-audit.json`
and `/private/tmp/fwp-compiled-range-audited.json`; complete artifacts:
`/private/tmp/fwp-compiled-range-costs`. Immutable baseline inputs share hardlinks
with `/private/tmp/fwp-integer-range-costs`. The older handoff is preserved at
`/private/tmp/fwp-183-pre-merge-handoff.md`; detailed delivery history belongs in
[the history index](roadmap-history.md), not a competing next-action list.

Use `python3 scripts/local-guard.py` for serial local checks. Full builds, native
execution, full suites and measurements run on GitHub. Preserve 64 GiB free disk,
target data below 2 GiB, sampled aggregate RSS below 1 GiB and the 180-second
deadline. No limits were raised. The final log audit passed in 18.26s; merge
verification passed in 9.34s. Recheck free space before downloading artifacts.
The merged-status documentation and next handoff pass `python3 scripts/check-roadmap.py`
and `git diff --check` under the guard (3.78s).

Authorized cleanup manifests are `/private/tmp/fwp-disk-cleanup-2026-10-20.json`,
`/private/tmp/fwp-disk-cleanup-second-2026-10-20.json`,
`/private/tmp/fwp-disk-cleanup-extra-generated-2026-10-20.json` and
`/private/tmp/fwp-disk-cleanup-2026-10-21.json`. The earliest counting artifact
trees are partial; restore their verified remote artifacts before binary audits.
Current matched/range evidence and sources remain intact.

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
