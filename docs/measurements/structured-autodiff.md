# Structured gradients: what locality buys

Milestone 3 starts from verified [PR #271](captured-map-delivery-2026-11-08/README.md),
merge `b76306b20a1d7727917ef6184c9a8716967ceb89`. Build the compiler from this
branch's source; no previous fwp binary is a build dependency. This contract
precedes measurement code and observations. No new public operation is selected yet.

A **gradient** contains one derivative per input. For `x*x + y*y` at `[2, 3]`,
it is `[4, 6]`. General reverse AD records operations, then walks that record
backward. Forward AD carries a value and derivative together. A **local term**
uses only a small part of the input: differentiating it can avoid evaluating
unrelated terms. This helps only when the objective has that structure.

## Equivalent work

Every method returns the entire gradient, in input order, as `List[F64]`.
The measured call includes conversions, output assembly and combining any
separate contributions. No method may substitute an analytic derivative for AD.
Independent analytic formulas check correctness outside the timed call.

| Objective | Formula | Dimensions | Methods |
|---|---|---|---|
| Neighbors | Sum `100*(y-x*x)^2 + (1-x)^2` over adjacent coordinates | 0, 1, 3, 33, 129 | Reverse `grad`; repeated-direction forward `gradient`; experimental local pair forward AD |
| Independent | Sum `(x*x-1)^2` | 0, 1, 16, 129 | `grad`; `gradient`; `array.map (derivative loss)`; existing tensor AD |
| Dense | `0.5 * sum (A*x)^2`, square matrix | 0, 1, 3, 9, 33 | `grad`; `gradient` |

- Neighbor inputs alternate `-1.2` and `1.0`, as in the earlier descent study.
  This comparison computes one gradient, not a 199-update solve.
- Independent inputs repeat `[-1.25, -0.5, 0.0, 0.5, 1.25]`.
- Dense input `x[j] = (((7*j+3) % 17)-8)/8`; matrix
  `A[i,j] = (((17*i+13*j+5) % 31)-15)/16`. Generate them as ordinary F64 values
  before timing, with exactly `n` rows of `n` elements. Matrix constants become
  AD scalars inside the objective; that required conversion remains timed.
- Counts are runtime parameters. Supply data through the native driver; do not
  compile a constant input/output into the measured entry.

There are 41 method/input combinations. Each small call (`n <= 3`) repeats 32
times per observation; all other calls repeat once. These counts are fixed,
not calibrated to the result. Two warmups precede 24 rounds. Rotate method order
by round, interleaving a byte-identical second executable for every method.
Check every repeated result and release it before the next call.

## What existing methods can express

| Method | Work and limit |
|---|---|
| `grad objective` | Evaluate once while recording, then accumulate backward. Recording consumes storage; one pass does not imply lower elapsed time. |
| `gradient objective` | Evaluate once per input direction. Linear objectives become quadratic work; the dense objective becomes cubic work. Measure these costs rather than inferring a speed ratio. |
| Local pair forward AD | Evaluate each affected edge with one input seeded at a time. Add the preceding edge's second partial before the following edge's first partial. Empty/singleton inputs have no edges. |
| Independent forward AD | Existing `derivative` and `array.map` suffice; no new wrapper is needed. |
| Tensor AD | Existing nodes describe elementwise arithmetic. The quartic expression has four occurrences of the input leaf; sum all four returned contributions to obtain the same single gradient. Include that work. |

Current tensor nodes do not express a complete differentiable shift/matrix
calculation. Do not fill those missing cells with handwritten derivatives or
describe elementwise tensor AD as general matrix AD. Dense coupling also has
no bounded-neighborhood shortcut. Preserve general AD for this case.

For a possible reusable pair operation, also check the distinct edge formula
`(y-x)^2` and a runtime scalar capture. At `[-1.25, 0.5, 0.75]`, the squared-edge
sum has gradient `[-3.5, 3.0, 0.5]`. Two formulas establish useful expressiveness,
not performance acceptance by themselves. The helper remains a fixture until
its lifetime, effect and measured-benefit requirements are met.

## Timing and storage boundaries

```text
construct ordinary input/matrix and caller alias
    → complete gradient call → inspect result and unchanged alias
    → release result → release input/matrix
```

Record construction, complete computation and release separately. Output checks
are outside those intervals; whole-process elapsed time includes them and is a
separate metric. A caller alias stays alive through the call. Compare it with its
original data afterwards. Empty calls still obey the same lifetime boundaries.

The native driver uses an explicit 64 MiB process stack limit and matching runtime
stack guard. Common runtime initialization is outside the three phase timers;
whole-process time includes it and shutdown. Pure global constants may initialize
on the first call (dense forward AD creates a cached zero `Dual`). Keep their
normal lifetime: report retained managed bytes after the call, require repeated
identical calls not to grow that amount, and include final constant destruction
in release time. After that destruction, managed storage must equal its initial
baseline exactly. This distinguishes a live constant from a leak without hiding
either cost. Use ordinary binaries for timing. In separate executions record managed requests,
requested bytes, actual retain/release outcomes, managed peak/final storage and
raw tape/workspace capacity. Distinguish charged storage from RSS. Report process
RSS, compiler time/RSS, code size and stack estimates too. Verify observers with
deliberately missing/doubled events; instrumentation must preserve outputs.

## Correctness and measurement policy

- Require complete output length and finite values. Compare every coordinate
  with analytic derivatives using absolute plus relative tolerance
  `1e-10 + 1e-10*abs(expected)`. Small binary-rational examples also require exact
  outputs. Different accumulation orders are not claimed to be bitwise equal.
- Compare raw interpretation and native GCC/Clang. Cover empty/singleton inputs,
  aliases, repeated calls and objective traps. Prove final storage returns to
  its pre-call baseline; retain cancellation/cleanup coverage for any changed path.
- Keep general reverse, nested differentiation and F128 verification. An F64-only
  structured operation cannot narrow those existing features.
- Use two sessions each on native Linux ARM64 and AMD64. Record each CPU model;
  do not pool different models. Require four available CPUs and use one pinned
  CPU for ordinary timing. Keep model/affinity visible for every observation.
- Use Rust 1.99.1; ARM GCC 13.3.0 and AMD GCC 15.2.0, strict `-O2`,
  `-ffp-contract=off -fno-fast-math -fno-lto`, architecture baselines `armv8-a`
  and `x86-64`, and `-fstack-usage`. Set stack storage, packed arrays, numeric
  fusion, direct returns, frame fields and AD workspace reuse explicitly on; LTO
  explicitly off. Run memory cleanup controls with workspace reuse off too.
- Report the median of 24 per-round time ratios. Form a 95% paired bootstrap
  interval from 2,000 resamples of those 24 rounds, Python `Random(0)` per
  comparison; use sorted bootstrap medians at indices 49 and 1,949.
- A comparison qualifies only if each identical-copy median ratio is within
  `[1/1.02, 1.02]` and its paired interval resolves the claimed direction. Retain every
  sample and inconclusive result. Do not repeat unchanged sessions to obtain a pass.

This first comparison diagnoses method costs; it does not have a universal
language-overhead target. Before implementing a chosen improvement, add its
specific transformation, exclusions and controls here. Require at least 10%
less computation on two affected nontrivial inputs in both sessions on both
architectures, no qualified guard regression above 2%, and explicit memory and
compiler-cost tradeoffs. Misses remain misses. A smaller executable or fewer
requests alone cannot satisfy the timing rule.

Finish the same PR with implementation, examples/tutorials, retained observations,
all nine final-head production jobs, documentation and a complete evidence audit.
Peer-language ownership comparisons follow in [milestone 4](../../PLAN.md#milestones).
