# Session handoff

Updated 2026-10-15. The only open delivery is
[PR #146](https://github.com/e6qu/fun-with-pipes/pull/146), head `19b14d0b`,
in `/Users/zardoz/projects/fun-with-pipes`. Its
[production run](https://github.com/e6qu/fun-with-pipes/actions/runs/38803349673)
is running. Both Windows production jobs now pass; Linux/macOS gates remain running. The synthetic test task now has
its actual stack-scan boundary. Omitting that boundary reproduced string loss
under forced collection; production task initialization was already correct.
Earlier Windows probe CRLF output is repaired too.

This branch, `checked-linear-algebra` in `/private/tmp/fwp-linear-algebra`,
prepares the next substantial delivery. Its original parent is `c10b1ccd`.
It now combines solver ownership, array borrowing, F128 gradient precision,
console ownership, environment-name and filesystem-path repairs. No PR is open for it.

Standing authorization covers fixes, publication and squash merges after all
nine production jobs and documentation pass for the final commit. Use exactly
one line of at most 80 characters and an explicitly empty commit body, without
trailers or attribution. Keep one active delivery PR. Failing tests are work to
fix; queued CI prevents merging, not preparation.

## Roadmap status

[PLAN.md](../PLAN.md) defines project completion; none of its seven work areas
is complete. JIT is excluded. Preserve single-argument curried functions,
explicit `curry`/`uncurry`, infix precedence and tacit data-last pipes.

| Step | Status | Next concrete work |
|---|---|---|
| 1 | In progress | Validate checked boundaries, solver and console ownership; then extend remaining runtime and deployment contracts |
| 2 | In progress | Measure remaining record, closure and call costs in representative programs |
| 3 | In progress | Reduce measured numerical gaps and sharing costs without changing arithmetic order |
| 4 | In progress | Deliver F128 precision; investigate sustained differentiation timing and memory scaling |
| 5 | Pending | Broaden CPU kernels and resolve runtime OpenCL compilation under the no-JIT policy |
| 6 | In progress | Preserve equivalent C/Rust comparisons, raw samples and memory profiles |
| 7 | In progress | Extend numerical, collection-heavy and long-running applications |

## Combined delivery

**Solvers:** LU solve, determinant, inverse, Cholesky, QR and conjugate gradient
now own scratch and partial results. A stack record tracks five scratch buffers
and two partial outputs. Cleanup covers normal, singular and trapped exits.
QR independently bounds its square output before multiplying or allocating;
zero input rows previously bypassed that capacity check. Preserve algorithms,
input aliases, floating-point order and scheduling points.

**Array loops:** borrow F64 array data once only when every `Again` passes the
same array parameter and the body reads it directly. Changing-array loops retain
per-read selection. Bounds checks, slices, ownership and task behavior remain.

**F128 gradients:** use the existing typed tape operations for seeds, weights and
adjoints, retaining low bits and the exponent range instead of narrowing through
F64. Other scalar formats retain their existing accumulation rules. Boxes and
reference counts still have costs; this is not a zero-allocation claim.

**Console and environment:** checked ARC now covers copied `read-all`,
`read-line`, `read-lines`, `args` and `env.get` results. Protect external input
buffers, strings during option construction and partial lists. `read-lines`
releases its whole-input copy after copying lines. Native environment lookup
now returns `None` for a name containing a zero byte, matching the interpreter;
previously it incorrectly looked up the prefix. Environment listing remains
unreviewed and has an explicit rejection test. Whole-stream reading still
materializes the stream; streaming helpers keep their existing behavior.

## Validation and measurement

- [Solver run 38795634707](https://github.com/e6qu/fun-with-pipes/actions/runs/38795634707)
  passed all four Linux/macOS hosts at `ec1ff14b`: formatting, Clippy, solver and
  array regressions, QR limits, existing unwind tests, inventory and measurements.
  The prior QR fixture incorrectly used ARC-ineligible `read-all`; it now passes
  dimensions through a checked function entry. No ownership check was weakened.
- [Precision run 38797434546](https://github.com/e6qu/fun-with-pipes/actions/runs/38797434546)
  passed all four hosts at `7a463be9`, including low bits, extreme exponents,
  seeded, nested and checkpointed gradients, cleanup controls and regressions.
- [Console run 38802310868](https://github.com/e6qu/fun-with-pipes/actions/runs/38802310868)
  at `f81970a1` passed all four Linux/macOS hosts, including the environment fix.
  The earlier partial console run was superseded and canceled.
- All new tests are included in production Windows acceptance. Combined final-head
  production coverage, including Windows, remains required before delivery.

[Array measurements](measurements/numerical-array-borrows-2026-10-15.json)
retain equivalent C/Rust timings and two paired internal comparisons
([first](https://github.com/e6qu/fun-with-pipes/actions/runs/38800569111),
[repeat](https://github.com/e6qu/fun-with-pipes/actions/runs/38801692547)).
Both paired runs passed all four hosts. Intel macOS ARC cached/per-read kernel
ratios repeat at 0.704/0.707; Linux ARM64 at 0.965/0.967. ARM macOS ARC changes
direction (0.968/1.021), and tracing is slower (1.046/1.009). The latter loop
removes address selection without adding spills but retains length reloads around
root-liveness fences. Keep slower cases; no universal speedup is established.
All profiles and result hashes match. Cross-run matrix variation includes an
11% slower Linux result with byte-identical executables. The baseline is the
`candidate` section of #146's report, which arrives with the parent rebase.

[F128 profiles](measurements/f128-gradient-precision-2026-10-15.json) contain
32 host/mode/optimization/reuse combinations: 2,843 managed requests and 143,082
requested bytes for the complete ten-check fixture, including output and 65
repeated gradients. ARC ends with zero charged bytes and collections. These are
not per-gradient timing, peak live memory or whole-process allocation measures.

## Local checks and unresolved limits

All local workloads use `python3 scripts/local-guard.py COMMAND...`, serially
within fixed limits. Full compiler builds, suites and timing stay on runners.
Existing-compiler probes check runtime behavior; they do not validate new
compiler proof rules. Negative controls must fail when releases are omitted.

Solver scratch/partial-result and missing-free probes passed at O1/O2 (6.00 s);
QR overflow passed without huge allocation (1.85 s). Array runtime probes passed
(5.14 s). Console probes cover 128 repeated calls, forced collection, every
injected allocation failure and separately counted C input buffers; omitted
string/buffer release fails with 205/211 (2.36 s). Raw environment lookup
reproduced prefix truncation before the fix (2.51 s). Metadata checks passed.

Combined formatting and documentation audit passed (1.10/2.53 s). Paired report
recording passed (0.13 s); repeat download passed (6.39 s). Combined standard-library documentation and inventory checks pass (1.11/0.49 s).
The handoff audit initially required its literal `Next:` marker; restoring it
passes the audit (2.40 s).
The inventory is 236 explicit contracts, 10 flat scalar signatures, 113 declarations
needing review and 19 lowered templates; the frozen baseline is unchanged.

A preceding Intel macOS compiler SIGABRT in U128 division by zero did not recur
on its unchanged retry; its cause remains unknown. Preserve future crash reports.
Do not describe the abort as repaired or a skipped/queued job as passing.

## Filesystem path repair

The reproduced zero-byte path-truncation repair and Windows test fixes are now
combined. Native file operations reject invalid paths before OS access, preserve
prefix/destination files and parent directories, and match interpreter diagnostics.
The preparation `/private/tmp/fwp-path-validation` passed all six hosts at
`135fa6f5` in [run 38806367846](https://github.com/e6qu/fun-with-pipes/actions/runs/38806367846).
Its earlier run exposed portability defects in old file probes; native handle
checks and escaped Windows paths repair those without skipping assertions.

Caught I/O error ownership is prepared separately in
`/private/tmp/fwp-filesystem-ownership`, branch `checked-filesystem-ownership`,
based on path commit `135fa6f5`. A probe reproduced 64 retained charged bytes per
small caught error because the runtime had left the record and strings uncounted.
The repair counts and protects construction; 128 runtime and compiled catches,
all three construction failures and omitted-ownership controls pass locally.
[Six-platform run 38808012610](https://github.com/e6qu/fun-with-pipes/actions/runs/38808012610)
is queued at `aa6ad15`. Combine only commits after `135fa6f5` once it passes,
so this known leak is repaired before the next delivery.

## Next: validate and publish the combined delivery

Focused numerical/console checks and combined documentation/inventory checks
pass. Finish the caught-error repair checks, monitor #146 and fix failures. Once #146's exact final-head gate passes,
squash merge it, verify its one-line message and tree, then rebase only this
branch's commits after `c10b1ccd` onto the accepted squash commit. The precision
and console implementations are already combined: do not cherry-pick them again.
Reconcile the parent Windows workflow changes, refresh this handoff and open one
substantial PR for the combined delivery. Run its full final-head gate and fix
failures before merging. Continue with remaining ownership and measured costs.

Original preparation worktrees `/private/tmp/fwp-quad-grad` and
`/private/tmp/fwp-console-ownership` retain evidence anchors; this file is the
live handoff for their combined delivery.
