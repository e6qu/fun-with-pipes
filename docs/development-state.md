# Session handoff

Updated 2026-10-15. This is preparation branch `quad-gradient-precision` in
`/private/tmp/fwp-quad-grad`, based on `3e5d86ad` of `checked-linear-algebra`.
No PR is open for this branch. [PR #146](https://github.com/e6qu/fun-with-pipes/pull/146)
is the active delivery; its Windows line-ending fixture repair is `930645e6`.
Production run [38796862558](https://github.com/e6qu/fun-with-pipes/actions/runs/38796862558)
and documentation must pass for that exact head before squash merge.

Standing authorization covers fixes, publication and squash merge after all nine
production jobs and documentation pass for the final commit. Commit messages
are exactly one line, at most 80 characters, without body, trailers or attribution.
Keep one active delivery PR. Queued CI gates merging, not preparation work.

## Roadmap status

| Step | Status | Next concrete work |
|---|---|---|
| 1 | In progress | Validate C boundaries and solver scratch/result ownership |
| 2 | In progress | Remove measured closure, container and call costs |
| 3 | In progress | Diagnose remaining Intel array and matrix wrapper overhead |
| 4 | In progress | Investigate sustained derivative timing differences |
| 5 | Pending | Broaden CPU kernels and resolve runtime OpenCL compilation |
| 6 | In progress | Preserve comparable C/Rust measurements and profiles |
| 7 | In progress | Extend numerical and long-running application coverage |


## Current preparation: preserve F128 gradients

The previous F128 reverse implementation converted local derivatives, seeds and
adjoints through F64. A coefficient distinguishable from 1 in F128 became 1 in
reverse mode, although forward mode preserved it. The existing scalar protocol
now selects typed F128 tape values and arithmetic. F16/BF16/F32/F64 keep F64
accumulation; nested reverse levels keep their existing typed arithmetic.
There is no new syntax or runtime tape implementation.

Acceptance: compare raw interpreter and native tracing/checked ARC at O1/O2,
with workspace reuse off/on. Cover low mantissa bits, extreme finite exponents,
accumulated small terms, seed precision, nested derivatives, checkpoint replay
and repeated calls. Verify that all private tapes are released, ARC collections
and final retained charges are zero, and an omitted tape free is detected.
Existing nested/checkpoint/scope/cancellation/capacity/library regressions remain
required. Native Windows runs include the new regression too.

Preserving precision has costs: F128 values can need boxes, reference counts
and typed arithmetic callbacks. The probe records managed allocation requests,
requested bytes, final charged delta and collections. These counts exclude
unmanaged tape registry allocation and linked-library/host allocation; they are
not whole-process memory or timing measurements. Do not call this a speedup or
claim a complete C/Rust overhead comparison. Four-host runner artifacts will
retain emitted C, profiles and compiler/platform metadata.

## Validation and unresolved work

All local work uses `python3 scripts/local-guard.py COMMAND...`, serially within
the fixed limits. No local full compiler build or full gate was run.

- The source probe loads edited `lib/autodiff.fwp` into the existing compiler
  library. Raw interpretation passes ten precision cases; tracing/ARC C emission
  succeeds (3.45 s). This checks the library change, not the pending parent
  compiler changes.
- The native O1 probe passes tracing GC/reuse verification, checked ARC with no
  collections or retained charge, and the missing-free control. The first
  nine-case version passed in 5.50 s; the ten-case rerun passed in 6.20 s.
- Regression harness metadata passes. Standard-library documentation regenerated
  with the standalone focused test (0.76 s); its first invocation lacked the
  compile-time manifest path, corrected before regeneration.
- Full four-host `precision` workflow and final production gates remain required.
  No runtime or platform claim is verified by a queued job.

The preceding solver batch owns six linear-algebra workspaces and partial
results, bounds QR output size and borrows invariant F64 array data once per
loop. Repaired focused run
[38795634707](https://github.com/e6qu/fun-with-pipes/actions/runs/38795634707)
is queued at `ec1ff14b`. Its first expanded run exposed an ARC-ineligible
`read-all` in a QR fixture; the repaired fixture uses an explicit function entry.
The details remain in `/private/tmp/fwp-linear-algebra/docs/development-state.md`.

## Next action

Next: finish the precision probe and runner validation while monitoring #146 and
the solver run. Fix failures rather than treating them as roadmap blockers.
After #146 merges, rebase only solver commits after `c10b1ccd` onto its accepted
squash commit. Before delivering this precision change, rebase only its commits
after `3e5d86ad` onto the accepted numerical parent; do not replay parent commits.
Update this live handoff with actual results, download profiles and explain
remaining costs before making acceptance claims. Preserve the unexplained Intel
compiler abort recorded in the parent history; its unchanged rerun passed but
its cause remains unresolved.
