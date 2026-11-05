# Current work

**Next:** finish the exact scalar constant group locally while parent PR #260
completes production verification. Do not publish another PR or start native
measurements until #260 is verified and merged. Parent monitoring continues in
`.worktrees/packed-pair-storage`; its handoff has exact gates and audit steps.

## Branch and scope

- Branch/worktree: `scalar-constant-lowering`.
- Preparation commit: `4bad4992` (before code edits).
- [Frozen contract](measurements/scalar-constant-lowering.md).
- Parent tested source: `ba3f0d8793dc3bbd3c21f94d06a1bca2896b6d45`.
- Parent production: `42024634729`; documentation `42024602934` passes.
  Benchmark job passes; eight native platform jobs still run. Full audit and
  authorized squash merge remain. No parent source edits or new push.

## Implementation in progress

General numeric constant proof is extracted from `src/cgen/fold_fields.rs` to
`src/cgen/constant_values.rs`; packed-fold seed lowering uses the same proof.
A new pass substitutes immediate scalar references and returns proofs for
root/export cache entries. It does not execute arbitrary user code or alter
runtime tape checks. Unit controls and the existing cache-ownership probe are
being updated. Compiler code is unverified. The branch can publish a format-only runner request;
it does not build or execute native programs. A second PR still waits for #260.

No builds or tests ran on this worktree. Local disk is about 17 GiB free, below the 64 GiB
reserve: no builds, tests or large artifact downloads. Do not bypass the guard.
Use focused GitHub checks after the parent merges and the grouped work is ready.
Before publication, update PLAN.md, this handoff, design, compiler-pipeline docs,
reference construction/control scripts, focused workflow and existing callers.

Keep all earlier timing misses explicit. No new native measurements have run.

## Format-only workflow repair

Request `42030505657` at bdc4a525 started no jobs: numerics.yml was 512,034
bytes, above GitHub's 512,000-byte limit. The exact annotation and source are in
[the failure receipt](measurements/scalar-constant-checks-2026-11-05/format-startup.json).
Format and four maintenance/audit jobs now live in a reusable workflow; commands
and explicit inputs are preserved. Reissue formatting after this source repair.
