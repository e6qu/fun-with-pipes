# Fresh F64 output: timing and memory results

**ARM64 confirms the speed target; AMD64 acceptance remains open.** Both ARM64
sessions reduce large-map computation by 26–31%, with all computation-copy
controls passing. AMD64 has 13/12 failed computation controls and one qualified
zero-update result 3.38% slower. Its two sessions used different CPU models.
Do not pool them or treat the successful audit as a timing pass.

The candidate writes directly into a fresh F64 result and omits its unnecessary
initialized-prefix counter. The reference disables only that compiler selection.
Allocation, input reads, callback order and cleanup stay unchanged.
[The protocol](../shared-loop-array-costs.md#selected-production-scope) fixes
inputs, 2 warmups, 24 rotated rounds, strict GCC O2 settings and 2% copy limits.

## Computation time

Percent change is `(candidate / reference - 1) × 100`: negative means less time.
`*` means a failed identical-copy control; that number is **inconclusive**.
Construction and final-result release are outside this timer; consumed inputs
and intermediates are released inside it. Whole-process results remain in the
[complete report](summary.json), separately qualified.

| Input | ARM1 N2 | ARM2 N2 | AMD1 9V45 | AMD2 7763 |
|---|---:|---:|---:|---:|
| loop-0 | -0.01% | -0.11% | -0.89% | +0.43% |
| loop-16 | +0.42% | +0.56% | +3.23%* | +0.29% |
| loop-1000000 | -0.08% | +0.04% | +0.22% | +1.34%* |
| loop-100000000 | -0.00% | -0.01% | -0.53% | -0.10% |
| array-0 | -0.40% | +0.14% | -0.07%* | -7.17% |
| array-16 | -9.30% | -9.43% | -4.63%* | +2.19%* |
| array-65537 | -31.28% | -31.31% | -22.10%* | -17.89%* |
| array-262145 | -26.13% | -26.71% | -10.26%* | -14.75%* |
| manual-3-0 | +0.02% | -0.06% | -0.67% | +3.38% |
| manual-3-1 | -2.05% | -2.43% | -12.07%* | -4.41%* |
| manual-3-199 | -4.31% | -4.42% | -14.27%* | +29.24%* |
| manual-33-199 | -12.84% | -11.65% | -7.78%* | -7.53%* |
| manual-129-199 | -12.49% | -13.49% | -1.71%* | -11.49%* |
| local-3-0 | -0.11% | -0.07% | -0.84% | -4.01%* |
| local-3-1 | -0.58% | -0.54% | -5.13%* | -10.30%* |
| local-3-199 | -0.44% | -1.74% | -8.17%* | +31.18%* |
| local-33-199 | +0.18% | -0.87% | -1.11%* | +0.36%* |
| local-129-199 | -0.92% | -0.34% | -7.09%* | -3.87% |

`manual` uses explicit coordinate derivatives; `local` uses the experimental local
forward-derivative helper. The final two numbers are coordinates and updates.
The zero-update case returns its input through the loop entry. AMD2 measured
about 29–30 ns per call including the clock boundary: the 3.38% miss is retained,
not a demonstrated cause of slower useful work. Its emitted translation units
are not identical, so no identical-code claim is made for candidate/reference.

## Memory

Separate instrumented runs give the same candidate/reference counts on both
architectures. Counts below are per invocation; peak live storage includes
allocator rounding. All cases have zero retains and return to zero live storage.
RSS is a separate, single whole-process observation, not managed storage.

| Input | Requests/call | Requested bytes/call | Peak live managed bytes | ARM RSS KiB | AMD RSS KiB |
|---|---:|---:|---:|---:|---:|
| loop-100000000 | 0 | 0 | 0 | 1,772 | 2,268 |
| array-65537 | 2 | 1,048,608 | 1,048,608 | 2,424 | 2,648 |
| array-262145 | 2 | 4,194,336 | 4,194,336 | 5,496 | 5,912 |
| manual-129-199 | 200 | 208,000 | 2,560 | 1,408 | 1,684 |
| local-129-199 | 200 | 208,000 | 2,560 | 1,468 | 1,752 |

These counters cover the driver repetitions, including input construction and
result release, after constant initialization. They exclude allocator metadata,
native libraries and process startup. The change removes bookkeeping, not heap
requests or owners. The 200 derivative requests are one initial array and one
result array per update; zero retains does not mean zero heap use.

## Compiler, code and stack costs

These are separate single observations, not repeated compiler-speed comparisons.
C emission includes fwp parsing/checking/lowering; C compilation uses the ordinary
O2 driver. Both include their process launch. The complete report retains time
and peak RSS for candidate and reference on every input.

| Host / 129-coordinate input | fwp emit ms | C compile ms | fwp peak RSS KiB | C peak RSS KiB | Ordinary image bytes |
|---|---:|---:|---:|---:|---:|
| aarch64-1 / manual-129-199 | 329.9 | 1692.8 | 42,756 | 95,100 | 147,984 |
| aarch64-1 / local-129-199 | 342.4 | 1734.8 | 45,108 | 95,160 | 147,976 |
| x86_64-1 / manual-129-199 | 242.8 | 1250.5 | 44,276 | 105,124 | 117,928 |
| x86_64-1 / local-129-199 | 241.9 | 1259.0 | 46,688 | 105,616 | 117,944 |

Largest reported frames are unchanged for the large inputs: ARM64 reports
976 bytes for the array program and 1,344 for either derivative program, all
static. AMD64 reports 992 and 1,344 bytes, marked dynamic/bounded. All ordinary
`.su` files are retained. These are individual compiled-function estimates, not
whole-call-chain or task-stack bounds.

## Sources and audit

Measured source `066175c3ad47cf8d226a1dc2b16fba55eba71b7d`,
[run 42440117133](https://github.com/e6qu/fun-with-pipes/actions/runs/42440117133).
The executable compiler change is `f21bf1390`; later edits changed documentation
and evidence tools. GCC is 13.3 on N2 and 15.2 on both AMD models; exact versions,
flags, affinity, reference patch and source/image hashes are in the report.

[Complete audit 42441970817](https://github.com/e6qu/fun-with-pipes/actions/runs/42441970817)
checks all 72 cases and 7,976 timing/build commands, plus 216 separate resource
commands on each first-session host. It verifies exact output words, cleanup,
source isolation, copied/native images, every raw sample and recomputed result.
[Audit archive](audit.zip), [artifact receipt](artifact.json) and
[full log](audit.log.gz) retain that evidence. Original large source/image
artifacts remain identified in the report. No downloaded binary ran locally.

The [CPU-placement diagnostic](../shared-loop-array-costs.md#cpu-placement-diagnostic-after-the-production-comparison)
investigates measurement stability; it cannot replace these failed limits.
[PLAN.md](../../../PLAN.md) owns milestone acceptance.

### Placement-diagnostic preflight repair

[Initial diagnostic run 42442853547](https://github.com/e6qu/fun-with-pipes/actions/runs/42442853547)
passes all 13 control tests, then stops at host qualification before downloading
or running an image. Its guard incorrectly required four *visible system CPUs*,
where the contract requires four *assigned CPUs*. The repair uses the affinity
set and records both counts and CPU models before rejection. Unknown models and
wrong assigned counts still fail. The missing-artifact upload error was secondary
and is fixed by retaining that preflight record. The original guard did not log
its hardware values, so its exact failing comparison cannot be reconstructed.
[Complete failed log](affinity-preflight.log.gz) is retained; no timing was taken.
