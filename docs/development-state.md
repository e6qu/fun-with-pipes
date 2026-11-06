# Current work

**Next:** implement the combined [numeric call/loop contract](measurements/recording-context-scopes.md),
starting with the bounded proof and explicit internal worker arguments. Update
all direct-call paths and selected pair-map/fold loops together, then run one
focused native batch. No production code changed or new measurement dispatched.

Branch `recording-context-scopes`, worktree `.worktrees/recording-capacity-gate`.
Base `d992a5734a12cf976c1ca20f75e9829a18bde0cc`. No active PR; open one coherent
draft after the combined implementation and controls are ready.

## Plan status

| Step | Status | Next result |
|---|---|---|
| 1 | Prepared | Commit the contract and verified #264 delivery before production edits. |
| 2 | Next | Bounded numeric proof, explicit context forwarding, pair-map/fold scopes and failure controls. |
| 3 | Pending | Focused GCC/Clang checks, reference controls, one combined measurement batch and complete audits. |
| 4 | Pending | Nine exact-head jobs/docs, complete final audit and verified squash merge. |

## Verified delivery: PR #264

[Delivery receipt](measurements/recording-capacity-delivery-2026-11-06/README.md)
retains complete logs, archive identities and the actual merge message/tree.

- Tested head `d453662e4226dbf613b5c8accc467a67fa12a359`.
- Merge `d992a5734a12cf976c1ca20f75e9829a18bde0cc`; identical tested/merged tree
  `7f2f64e1e45114c0e8b42a324254fe7f7f4939b3`.
- Exact squash subject `Inline derivative tape capacity checks`: 38 characters,
  one line, empty body and no trailers.
- All nine production jobs `42186095529` attempt 1 pass. Docs
  `42186063070` / `127786559808` passes. Every complete producer log reviewed.
- Complete audit `42197602289` / `127824662178` passes. Artifact `13493958793`,
  1,162,047 bytes, SHA-256
  `32800cd03a63f4c7d94aa5fa0017b85ee44e7e3910787d141c7ed4d2e35a0049`.
  All ten source receipts and every retained log hash verified (guard 0.13s).
- Duplicate postmerge runs `42201736811` / `42201737242` confirmed cancelled
  after tree equality. Initial receipt attempt correctly refused while the CI
  cancellation was pending; retention passed once cancellation completed.
- Long gains 1.86–14.02%; 17/32 meet 5%. Fifteen targets and one AMD64 copy limit
  stay open. Allocation/validation/live storage/maximum frames unchanged;
  all compiler comparisons pass. Every older missed limit stays in PLAN.md.

## Implementation map

- `src/cgen/recording.rs`: closed numeric proof, depth 64/expression 4096/type 32
  bounds, rejects lifecycle/reentry/ticks. Current admission counts direct pushes.
- `src/cgen.rs`: `Abi::sig`, worker/boxed entries, `FnGen::call`, `expr_fields`
  and other direct worker calls; packed pair-map/fold generation. Forwarding must
  cover all these callers. Reconcile uncounted proof with ownership lowering.
- `tests/ad_tape_scopes.rs` and `fixtures/ad_recording_lookup_probe.c`: existing
  O0/O1/O2 lookup, parent/trap order, ID-switch, reuse and unwind controls.
- Reference selector disables only new scopes, preserving previous lookup reuse,
  append inlining and capacity inlining. No old compiler binary dependency.
- Read-only source notes: `/tmp/fwp-capacity-next-source-review.md`; initial
  contract draft `/tmp/fwp-recording-context-contract-draft.md`. The committed
  contract governs implementation; neither scratch file is acceptance evidence.

Use the local guard for serial focused checks. Full builds/tests/benchmarks and
large audits run on GitHub. Last free space 76 GiB. No native build/full suite or
benchmark ran locally. Current delivery scratch: `../gradient-work/capacity-*`;
one-shot retention helper `/tmp/fwp-retain-capacity-delivery.py` already ran.
