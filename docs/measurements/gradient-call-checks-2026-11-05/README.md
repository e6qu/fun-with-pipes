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
