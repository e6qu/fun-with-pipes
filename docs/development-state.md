# Current work

**Next:** publish the shared-proof visibility repair and rerun focused checks while PR #260
completes production verification. Do not publish another PR or start native
measurements until #260 is verified and merged. Parent monitoring continues in
`.worktrees/packed-pair-storage`; its handoff has exact gates and audit steps.

## Roadmap status

| Step | Status | Work |
|---|---|---|
| 1 | Implemented | Shared bounded numeric proof; compiler/unit verification pending. |
| 2 | Implemented | Scalar substitutions and direct root cache entries; not yet validated. |
| 3 | In progress | Formatting passes; all three first builds fail on shared-field visibility. Repair prepared. |
| 4 | Pending | Reference controls started; census, compiler costs, runtime and audits remain. |
| 5 | Pending | Parent #260 must merge before another PR; this group still needs final verification. |

## Branch and scope

- Branch/worktree: `scalar-constant-lowering`.
- Preparation commit: `4bad4992` (before code edits).
- [Frozen contract](measurements/scalar-constant-lowering.md).
- Parent tested source: `ba3f0d8793dc3bbd3c21f94d06a1bca2896b6d45`.
- Parent production: `42024634729`; documentation `42024602934` passes.
  Benchmark, all four macOS jobs and Windows AMD64 pass; three native jobs still run. Full audit and
  authorized squash merge remain. No parent source edits or new push.

## Implementation in progress

General numeric constant proof is extracted from `src/cgen/fold_fields.rs` to
`src/cgen/constant_values.rs`; packed-fold seed lowering uses the same proof.
A new pass substitutes immediate scalar references and returns proofs for
root/export cache entries. It does not execute arbitrary user code or alter
runtime tape checks. Unit controls and the existing cache-ownership probe are
being updated. Compiler code is unverified. A second PR still waits for #260.

Focused correctness request `42034673196` failed at
`d99dbacd4f0f7d24e938bde1cb17956d184804bf` on all three hosts; see the repair below.
No local builds or tests ran. Local disk is about 17 GiB free, below the 64 GiB
reserve: no builds, tests or large artifact downloads. Do not bypass the guard.
The grouped compiler change is ready for focused correctness checks on its
separate branch. Those can proceed while #260 finishes; performance measurement
and a second PR still require its verified merge.
PLAN.md, design and compiler-pipeline docs now describe the new group.
Reference construction and core census/runtime/compiler budget helpers accept
`scalar-constant`. Their new controls have not run. Remaining measurement setup:
wire scalar census/analysis/time/report workflow choices, frozen parent count
reconciliation and all artifact auditors; verify changed recorded-source callers.
The `scalar-constant-checks` choice uses the existing 25-target focused matrix.
Complete-program scalar selection and negative controls are now included in
that matrix. The count and timing artifact auditors accept the new comparison;
measurement workflow wiring and parent reconciliation remain unfinished.

Keep all earlier timing misses explicit. No new native measurements have run.

## Format-only workflow repair

Request `42030505657` at bdc4a525 started no jobs: numerics.yml was 512,034
bytes, above GitHub's 512,000-byte limit. The exact annotation and source are in
[the failure receipt](measurements/scalar-constant-checks-2026-11-05/format-startup.json).
Format and four maintenance/audit jobs now live in a reusable workflow; commands
and explicit inputs are preserved. Repair request `42031076546` passes at `5a68795746616da117e2858bb30c050485e1f3f0`.
Artifact `13416296986` (4,143 bytes), SHA-256
`af500d3754945698f713d8ef8ecbe7ed641c42959f2c985e7d977a3a6c6bc30f`,
was checked against the exact source and applied. Rustfmt 1.10.0-stable
(58cf8f9c35, 2026-10-13); no compilation or tests. A workflow-size regression
check is prepared for the documentation audit.

Formatting of the added root-entry probe passes at request `42032825443`,
source `d1032469fd1740f3642b67d01b505ed8533ccceb`, job `127263294058`.
Artifact `13417091621` (991 bytes), SHA-256
`4620fab7816fa87c53a053438ce2024e3a1f362bdce49a83528878718eb48e00`,
was verified and applied. The visibility repair below is the only later Rust edit.

## First focused build repair

Run `42034673196` fails on all three hosts with the same five E0616 field-privacy
errors. Formatting passes; compiler/unit/native targets cannot run. Every full
job log and all six artifacts were inspected and retained in
[first-build evidence](measurements/scalar-constant-checks-2026-11-05/first-build/README.md).
The shared proof's immutable `program` reference is now visible to sibling C
backend modules. Memoized values remain private. Rerun the focused group after
this repair is committed; the parent production run remains unaffected.
