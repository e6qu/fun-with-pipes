# Gradient-call verification

**Not yet verified.** [PR #259](https://github.com/e6qu/fun-with-pipes/pull/259)
groups scoped input borrowing, numeric fold fields, direct backward seeds and
consumed coordinate scratch. The [contract](../gradient-call-storage.md) fixes
selection rules, failure controls and measurement requirements.

## Compiler repair

Source `73261bf2d26a3c12078bc5951cba60752d38df8c`,
[run 41956890550](https://github.com/e6qu/fun-with-pipes/actions/runs/41956890550):
macOS lint and build both failed with Rust E0509. The constant proof moved a
record's shared contents out of `Value`, which has a destructor. Borrow those
contents while the value remains alive; correct the same pattern in its unit test.

The [full-log audit](compile-repair/audit.json) finds exactly that error twice,
no compiler warnings and no executed native targets. The digest-checked diagnostic
archive, full log and job metadata are retained beside it. The Linux jobs and
docs had no assigned runner when this known-failing batch was cancelled.
A repaired build still needs all grouped native checks; this audit is not a pass.

## Grouped repair

Source `68f71c14226ac03818c842da0b8017ad98754c7b`,
[run 41957591695](https://github.com/e6qu/fun-with-pipes/actions/runs/41957591695):
all three compilers build, but the focused gate fails. All 75 native target logs
were audited: each host passes 22 targets and fails the same three. Unit tests
could not compile; they did not run.

| Failure | Cause and repair |
|---|---|
| Gradient input still retained | `length` borrowed its list but lacked the separate no-escape contract. Native length only traverses links; the interpreter returns a count. Record that contract and check its propagation through worker and scope. Continuing-owner, escape and dynamic-call exclusions remain required. |
| Two lint errors | Iterate paired scope/worker parameter slots instead of indexing ranges; require distinct entries with equal arity. |
| Unit compilation | Update the missed `backward_owned` test caller to explicit list seeds. |
| Packed-window ownership test | The internal fold now returns fields: expect three allocations, and inject final allocation failure before the remaining export-result box. Keep alias, cancellation and deliberately added allocation controls. |
| Scoped-input fixture | An Async callback cannot enter a pure AD scope. Yield outside the callback, then inject failure/cancellation after tape creation with the scope active. |
| Owned-tape token fixtures | `ad.tape-owned` takes a list of weights, not an integer count. Use `[0.0f128]` and `[]`; retain invalid-root and empty-tape expectations. |

The [macOS](grouped-repair/mac-audit.json),
[Linux ARM64](grouped-repair/arm-audit.json) and
[Linux AMD64](grouped-repair/amd-audit.json) audits retain full target results and
diagnostic context. Beside each are digest-checked artifact receipts, complete
job logs, and archives of every target log and probe status. Documentation
[run 41957597604](https://github.com/e6qu/fun-with-pipes/actions/runs/41957597604)
passes; its full log contains only the expected runner negative controls.

These are repairs awaiting runner verification, not passing acceptance evidence.
Compiler diagnostics will now upload before the native queue completes.
