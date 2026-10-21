# Session handoff

## Next action

Next: finish accepting [PR #182](https://github.com/e6qu/fun-with-pipes/pull/182)
before opening another PR. Its unchanged final head is
`817805a18bd97e90090b36e7baf589d011048fd6`, production run `39533108586`,
documentation `39532459370`. The main checkout's handoff and
`/private/tmp/fwp-182-final-acceptance.json` hold its current status.
The merge helper `/private/tmp/fwp-merge-182.py` rechecks all nine production
jobs and documentation, then verifies the squash tree and exact one-line message.

This preparation checkout is `/private/tmp/fwp-integer-range-probe`, branch
`preserve-checked-product-ranges`, based on `817805a1` and including its U32 fix.
After #182 merges, rebase this branch from that head onto the accepted squash
commit, update this handoff and history, and publish the coherent next PR.
No second PR exists yet. Do not mistake focused acceptance for the full matrix.

## Prepared change and evidence

Signed I64/ISize multiplication keeps its overflow check, then exposes the
proven-safe product expression to C optimization. The [measurement guide](measurements/checked-products.md)
explains the workload, comparisons, instructions, tests and tradeoffs. The
[raw report](measurements/checked-products-2026-10-21.json) retains every sample.

Source `b57e2dcda716ebd27007d01aaf5e4e79d22518b6` is preserved by published tag
`roadmap/revision-checked-product-b57e2dcd`. Focused run `39536765734` passes
on both Linux architectures; complete logs are audited clean in
`/private/tmp/fwp-range-native-audit.json`. Each job passes formatting, Clippy,
five integer-output tests, four scalar-trap tests, twelve counting and fourteen
scalar binary inspections, and the nine-way measurement. Actual compiler C
matches the measured candidate byte-for-byte, and its instruction section and
output match on both hosts. Full production/documentation acceptance is pending.

The signed test covers 173 runtime operand pairs for each of I64 and ISize,
unoptimized interpretation, ARC/tracing at O0/O1/O2/O3, effect/trap order and
O1/O2/O3 undefined-behavior sanitizer checks. Removing the overflow guard must
produce a signed-overflow diagnostic. Saved ordinary binaries confirm that
O2/O3 reuse the checked product; O0/O1 emit an extra product. Document this
cost; the measured O2 benefit is not a claim about every optimization level.

On EPYC 7763/N2, O2 child CPU medians fall 14.6–29.0% / 17.9–18.3% relative
to grouped fwp on the same CPUs. C remains faster. AMD64 varies substantially
by CPU ID, including mixed comparisons with Rust; its cause is unresolved.
Instruction sections shrink 64/112 bytes; AMD64's normal 40-byte frame
disappears. Managed counters remain zero after initialization, with a working
16-byte allocation control. Tracing code remains in the binaries.

Artifacts: `/private/tmp/fwp-compiled-range-costs`; download manifest:
`download-audit.json` there. Byte-identical immutable baseline inputs share
hardlinks with `/private/tmp/fwp-integer-range-costs`; both artifact trees are
complete. Independent source/binary/sample audit passed in 0.60s:
`/private/tmp/fwp-compiled-range-audited.json`. Ordinary instruction inspection
and timing-ratio review passed in 0.13s with `/private/tmp/fwp-range-review.py`.
The first schema-inspection command used a dict operation on a list and failed;
the corrected inspection and independent report audit pass.
Documentation, immutable-tag, commit-message and whitespace checks pass under
the guard (2.56s): `python3 scripts/check-roadmap.py` and `git diff --cached --check`.
The first handoff check caught a missing roadmap-status table; it was restored
before the passing rerun. The readable guide and report do not change compiler
or test code from the focused source.

## Earlier preparation

The original saved-C experiment `7a8803762e240998605c6442afbbb33ed8157133`
is retained by `roadmap/revision-integer-range-7a880376`. Measurement-only run
`39530460995` passed on both hosts, but skipped native semantic preflight and
did not modify the compiler. Audit: `/private/tmp/fwp-range-counting-audit.json`;
artifacts/report: `/private/tmp/fwp-integer-range-costs` and
`/private/tmp/fwp-integer-range-audited.json`. Use `--comparison range` for it;
use `--comparison compiled-range` for the implemented candidate.

Preparation run `39535767609` at `40d01bcc` was cancelled while both jobs were
queued; no tests ran. Its replacement above includes complete scalar artifacts.
The old preparation branch remains at `ca72a9cde7e3ef4eb6e7d911110e8937a3f419b2`.

## Resources and remaining project work

Use `python3 scripts/local-guard.py` for serial local checks. Full builds,
native execution, complete suites and measurements belong on GitHub runners.
Keep 64 GiB free, generated target below 2 GiB, sampled aggregate RSS below
1 GiB and the 180-second deadline. Latest artifact download left about 65.3 GiB;
recheck before more downloads. No limits were raised or checks bypassed.

On October 21, authorized cleanup removed 304.74 MiB of obsolete binaries and
disassembly after verifying remote recovery artifacts. Manifest:
`/private/tmp/fwp-disk-cleanup-2026-10-21.json`. The first two counting artifact
trees are now partial; restore their remote artifacts before another binary
audit. Current matched/range evidence and source files were preserved.

All seven [plan](../PLAN.md) work areas remain open. Ownership and removal of
tracing are primary; default native execution still includes tracing. Retained
resources, persistent subscriptions, resource-owning tail frames and mutual
recursion need further proofs. Do not let microbenchmarks displace representative
applications or claim a completed memory/performance roadmap. JIT is excluded.

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
