# Current work

**Next:** run the longer small-case measurements, audit all four sessions, publish
the report, then start the complete final-head production/documentation/G2 gates.
Keep monitoring on a timer; repair failures before merging.

[Draft PR #221](https://github.com/e6qu/fun-with-pipes/pull/221) uses
`/private/tmp/fwp-parser-workspace`, branch `scoped-parser-workspace`, based on
verified #220 squash `56d5aac63a9963ae6b16574f10d6dc3087a08d8a`.
A6 is implemented, but complete platform acceptance is pending.
[The lifetime contract](parser-workspace.md) and
[measurement protocol](measurements/parser-workspace.md) define its scope.

## Current source and checks

The compiler/runtime source is `ca56023eb362259cf2099c9c9d477b20b3cf6793`.
The pending change only lengthens the small timing sample and updates tools/docs.
Do not repeat the passing focused compiler suite for that sampling-only change;
the final-head full matrix is still required.

- Native Linux ARM64/AMD64 run `40650396700` passed: 211 units, six allocator
  tests, six parser tests, two record tests, Clippy and actual WASI O1/O2 checks.
  All logs and 26 actual native/WASI probes per host were independently audited:
  outputs, statuses, physical cleanup, deliberate mutations and binary targets.
- Measurement run `40650400349` passed three sessions. AMD64 session 1 rejected
  its identical-binary small-case control at 10.08%, above the fixed 10% limit.
  That candidate timing was correctly absent. Every other runtime/scale row
  passed; all four artifacts were independently audited, including the rejection.
- Increase only small-case repetitions from 32,768 to 131,072. Keep the 10%
  control limit, six samples, two warmups and all other inputs unchanged. Do not
  drop the rejected observation or claim a speed result from it. The writer and
  auditor now require the explicit small-case setting. Ten evidence controls pass.
- Earlier run `40642686229` at `ec36e79f` passed all four measurements with the
  growing-payload policy. Its audit exposed rounding after adding block headers.
  Current whole-block sizing removes that waste; requested and rounded block
  bytes match on both hosts, and all four cases match prior fwp's peak live slots.
- No full local compiler build, suite or benchmark ran. Guarded Clang O1/O2
  controls cover block boundaries, medium/large oversized nodes, subsequent
  growth, nested owners, every allocation failure and omitted cleanup. Small
  generated-C/peer controls check values, malformed input and checked overflow.
  Workflows, documentation links and formatting pass their focused checks.

## Implemented scope

Selected recursive variants contain only integers and links. One invocation owns
aligned blocks; allocation helpers receive its context explicitly, while readers
need none. Public recursive calls start separate owners. Escaping/cached trees,
unknown or captured uses, managed node fields and self-tail roots keep ordinary
ownership. Strings and token lists retain their existing owners.

Whole blocks grow through 256/512/1,024/2,048/4,096 bytes, including headers.
Oversized nodes receive their checked exact requested size. Completed helper
clones obey an actual expression/local growth limit; unsupported candidates do
not change language semantics. Cancellation is observed after the tree exists,
and the missing-free mutation must leave detectable live storage.

The comparison builds the same prefix-expression trees in previous fwp, current
fwp and explicit C/Rust arenas. Peers borrow token slices; fwp owns its tokens.
Report their substantial remaining timing gap, allocated bytes, code/stack costs
and compiler RSS honestly. Fewer count operations do not imply fewer bytes.

## Repairs and retained evidence

All encountered failures were audited across every job before batching repairs:

- Guard tests depended on host disk capacity. Their copied subprocesses now
  control disk readings; the real 64 GiB guard and other limits are unchanged.
- Linux mixed unversioned Clang 21 with LLVM 18 WASI libraries. One shared setup
  pins and preflights compiler, linker and libraries together; both hosts pass.
- The first measurement adapter missed the baseline's unboxed scalar worker and
  public bridge. The repaired adapter checks and times the public entry.
- Compiler-scale commands initially selected empty `main`, omitting exports.
  They now select exports explicitly; both writer and auditor require every
  expected root. The old compiler-scale observations are invalid.

Current evidence is in `/private/tmp/fwp-221-ca560-checks` and
`/private/tmp/fwp-221-ca560-measurements`. Preserve the earlier policy samples in
`/private/tmp/fwp-221-ec36-measurements`, `/private/tmp/fwp-221-ec36-published.json`
and `/private/tmp/fwp-221-a55-measurements`; distinguish their source and limits.
No detached merger runs.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain collector-free ownership and cycle checks |
| 2 | In progress | A6 measurement and full platform acceptance |
| 3 | Pending | Functional calls and recursion fixtures/optimizations |
| 4 | Pending | Close named CPU performance gaps |
| 5 | Pending | Derivative storage, timing and precision |
| 6 | Pending | CPU numerical kernels |
| 7 | In progress | Extend fixed comparison budgets and audit controls |
| 8 | Pending | Larger-program correctness, cleanup and scale matrix |

## Recovery

GC removal is verified in #217; A1–A5 are verified through #220. A6 needs the
remaining measurement and final platform gates. Roadmap steps 3–8 remain open.
[History](roadmap-history.md) owns completed delivery IDs; [PLAN.md](../PLAN.md)
owns the next tasks. The original intermittent Intel compiler abort remains
unexplained; preserve its evidence and investigate source/input on recurrence.

The primary checkout remains detached at #209 with a recovery pointer and an
untracked compiler-abort report; preserve both. Disk is about 75 GiB free. Keep
the fixed 64 GiB/2 GiB/1 GiB/180-second local limits and use `local-guard.py`.

Publication and squash merge are authorized after all final-head gates pass:
one line <=80 characters, empty body, no trailers/attribution. Verify the merged
tree and message, then continue the plan in the next substantial PR.
