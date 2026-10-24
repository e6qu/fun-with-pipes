# Checked arithmetic experiment: no compiler change selected

Both candidates speed up the measured integer loop, but neither meets the full
predeclared screen. ARM64 passes; AMD64 has unstable identical-code controls
and some results beyond the allowed slowdown. The compiler remains unchanged.
An inconclusive measurement is not a correctness failure, and it does not
justify weakening the screen.

The [protocol](checked-bounds-protocol.md) was fixed before the run. It compares
unchanged fwp generated C, an exact binary copy, a subtraction-return expression,
and a combined addition/subtraction expression. All existing overflow checks
remain. This is fwp versus fwp, not overhead against C or Rust.

[Run 40077293691](https://github.com/e6qu/fun-with-pipes/actions/runs/40077293691)
passes output checks on both native Linux hosts at
`18ac20729402002fdea691ac6a5d5b4aab42678e`, retained by
`roadmap/revision-checked-bounds-18ac20729402`. AMD64 reports EPYC 9V74; ARM64
reports Neoverse-N2. GCC 13.3.0 compiles all variants at O2, with checked ARC,
`-ffp-contract=off` and no link-time optimization. The measurement explicitly
uses every allowed CPU: four IDs on each virtual runner.

There are two warmups and 32 complete-process samples per variant, program and
CPU. Order rotates and reverses; each variant occupies every position eight
times. Elapsed time and child user+system CPU time are separate. Startup,
calculation, output and shutdown are included; compilation is excluded.
[All samples, images, stack reports and verdicts](checked-bounds-2026-10-24.json)
remain available, including noisy and slower rows.

## Loop results and failed acceptance

These are ranges of per-CPU median reductions relative to unchanged fwp on the
same CPU. A positive percentage means less time. They are observations within
these sessions, not a general speedup claim.

| Host | Changed return expression | Elapsed reduction | Child CPU reduction |
|---|---|---:|---:|
| AMD64 | Subtraction | 14.6–16.5% | 14.8–16.6% |
| AMD64 | Addition and subtraction | 11.9–14.1% | 12.0–14.5% |
| ARM64 | Subtraction | 10.3–10.4% | 10.3–10.4% |
| ARM64 | Addition and subtraction | 10.2–10.3% | 10.2–10.3% |

All eight loop cases have stable identical-code controls and exceed the required
5% reduction in both time measures. The other programs still matter. On AMD64,
`fib` CPU 2, `pipeline` CPU 0 and `text-length` CPUs 1–3 exceed the control's 3%
noise allowance in at least one measure. The combined candidate also exceeds
the 3% slowdown limit for `text-length` CPU 0 child CPU time. Those rows remain
failed or inconclusive; they are not discarded. All seven ARM64 programs pass
on all four CPU IDs.

## Code size and stack cost

Independent review inspects 56 actual experiment images, including fourteen
exact-copy controls, plus 42 baseline C/Rust/fwp images. It verifies source edits
are restricted to the intended successful return expressions, checks native ELF
images, and recomputes every median, ordering check and screen verdict. No
downloaded program is run during this review.

For the subtraction-only candidate, the loop instruction section shrinks by
48 bytes on AMD64 and 32 on ARM64. Its main runtime-thread frame remains
288 and 304 bytes respectively. The Fibonacci instruction section grows by
1,328 bytes on AMD64 and 1,024 on ARM64; its main runtime-thread frame falls
from 320 to 256 and 272 bytes respectively. These are compiler-reported frames
for those functions, not maximum recursion-stack usage. Instruction-section sizes
include padding; whole-file sizes also include linker metadata and other data.
Both candidates' complete size/frame records are retained in the data file.

Any further experiment must retain these results and predeclare its sampling
rules. Adoption still needs stable measurements, overflow/effect-order checks
and full native acceptance. No arithmetic compiler rule is added by this work.
