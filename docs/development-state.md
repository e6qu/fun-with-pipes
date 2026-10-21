# Session handoff

## Current delivery comes first

This is a preparation checkout at `/private/tmp/fwp-integer-range-probe`, branch
`investigate-integer-range-information`, based on `080b0ff6`. It is not a second
PR. [PR #182](https://github.com/e6qu/fun-with-pipes/pull/182) is active in the main
checkout, `/Users/zardoz/projects/fun-with-pipes`. Its handoff is authoritative
for delivery status. The PR now includes a U32 multiplication repair absent from
this preparation base. The earlier `080b0ff6` production run was cancelled.
Do not merge or publish a second PR from this older base.

Once PR #182 passes all nine production gates and documentation and is squash
merged, transplant this preparation onto that accepted merge. Preserve its
compiler fixes and current handoff. Then implement and test the range-preserving
multiplication candidate below in the next coherent batch.

## Completed experiment

Measurement source `7a8803762e240998605c6442afbbb33ed8157133` is preserved by
`roadmap/revision-integer-range-7a880376`. Run `39530460995` passed on Linux AMD64
and ARM64; both complete logs are audited clean in
`/private/tmp/fwp-range-counting-audit.json`. Compiler code is unchanged.

The ninth variant changes only generated I64 multiplication: it keeps
`__builtin_mul_overflow(x, y, &r)` and the overflow trap, then returns `x*y`
instead of `r`. That expression is reached only when the mathematical product
fits I64. In this workload GCC recovers loop bounds from the expression and
removes sign/large-number cases; it also carries `3*i` as an induction variable.
The source check remains; this is not permission to weaken checked arithmetic.

Nine controls run for 54 balanced rounds plus two warmups on each of four
allowed CPUs per runner. Both hosts use GCC 13.3.0. Against the grouped/inlined
fwp control in the same session, child CPU medians fall roughly 10–15% on EPYC
9V74 and 18% on Neoverse-N2. Matched C remains faster. This is two runner
sessions, not a universal speed guarantee. Compare the exact per-CPU ratios
before writing final performance claims.

Artifacts: `/private/tmp/fwp-integer-range-costs`. Independent sample, source,
binary and GCC-dump audit: `/private/tmp/fwp-integer-range-audited.json`. The
validator is `scripts/summarize-integer-counting.py --comparison range`; guarded
validation passed in 0.48s after correcting its explicit compiler-flag check.
All timed outputs and separate managed-storage controls pass; native semantic
preflight was explicitly skipped, so this experiment cannot accept a compiler
change. The validator is published in `30e5ac65`.

## Next implementation and checks

Preserve the existing overflow test before exposing the safe I64 product.
Add runtime-input tests for zero, both signs, I64 extrema and values immediately
around overflow boundaries. Compare the unoptimized interpreter with optimized
native execution, including effects before and after a trap. Use GCC and Clang,
ARC/tracing, optimization levels and sanitizers; constant folding must not hide
unsafe intermediate arithmetic. Check ordinary unbounded multiplication too:
a bounded benchmark does not establish costs for arbitrary operands.

Measure actual compiler-produced C and binaries against the saved experiment
and matched C/Rust peers. Inspect both instruction streams, stack use and code
size, preserve all samples and report remaining gaps. Only then select the
compiler change and run the full acceptance matrix. Follow [PLAN.md](../PLAN.md)
for all seven remaining work areas; ownership and removing tracing remain the
primary project objective. JIT is excluded.

Local work remains serial and guarded: 64 GiB free disk, target below 2 GiB,
aggregate RSS below 1 GiB and 180 seconds. Full builds, native compilation,
full tests and measurements run on GitHub; do not raise or bypass guard limits.
