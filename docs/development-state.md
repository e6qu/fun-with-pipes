# Session handoff

## Current delivery comes first

This is a preparation checkout at `/private/tmp/fwp-integer-range-probe`, branch
`preserve-checked-product-ranges`, based on the current PR head `817805a1`. It is not a second
PR. [PR #182](https://github.com/e6qu/fun-with-pipes/pull/182) is active in the main
checkout, `/Users/zardoz/projects/fun-with-pipes`. Its handoff is authoritative
for delivery status. This preparation now includes the PR's U32 repair. The active production run is
`39533108586`; focused and documentation checks pass. Do not merge or publish a
second PR before this delivery is accepted.

Next: run and audit the prepared candidate's focused checks while PR #182 runs.
Once PR #182 passes all nine production gates and documentation and is squash
merged, rebase this preparation from `817805a1` onto the accepted merge. Preserve its
compiler fixes and current handoff. Then finish verifying the range-preserving multiplication candidate below in the next
coherent batch.

## Completed experiment

Measurement source `7a8803762e240998605c6442afbbb33ed8157133` is preserved by
`roadmap/revision-integer-range-7a880376`. Run `39530460995` passed on Linux AMD64
and ARM64; both complete logs are audited clean in
`/private/tmp/fwp-range-counting-audit.json`. That measurement source did not
change compiler code.

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
change. The original preparation is preserved on branch
`investigate-integer-range-information` at `ca72a9cde7e3ef4eb6e7d911110e8937a3f419b2`.
The active branch contains only its new changes above `817805a1`.

## Candidate implementation and remaining checks

The local candidate changes the returned expression for signed 64-bit
multiplication (I64 and ISize), after its existing overflow check. A new scalar regression uses runtime CLI operands,
independent i128 expectations for both types, both memory modes and native builds
at O0/O1/O2/O3.
The focused `integer-counting` suite includes these scalar tests and now requires
actual compiler-produced C to match the measured range candidate exactly. It also
builds, executes and saves the real compiler-produced binary, exact output and
disassembly. The report audit uses explicit `--comparison compiled-range` to
check this source, instruction section and all twelve semantic/control binaries;
`--comparison range` remains for the historical measurement-only run. The
old measurement-only `integer-range` option is removed; its original source/run
remain preserved.

Its UBSan controls check the actual emitted primitive at O1/O2/O3 and deliberately
remove the overflow check to prove the sanitizer detects the unsafe product.
Guarded formatting, whitespace and documentation checks pass; native
execution is still pending. The ISize extension also passes formatting (0.13s).
Do not claim this implementation is accepted or publish another PR before #182.

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

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing; prove retained ownership and cleanup. |
| 2 | In progress | Eliminate avoidable functional allocations and count traffic. |
| 3 | In progress | Resolve measured machine-code and performance gaps. |
| 4 | In progress | Improve differentiation time, memory and precision. |
| 5 | In progress | Validate numerical kernels and ahead-of-time GPU policy. |
| 6 | In progress | Establish equivalent-work comparisons and budgets. |
| 7 | In progress | Validate larger programs and bounded live memory. |
