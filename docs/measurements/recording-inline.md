# Inline scalar derivative recording

Historical protocol for [PR #263](recording-inline-delivery-2026-11-06/README.md),
whose final production and documentation gates pass. The [native GCC diagnostic](recording-call-analysis-2026-11-06/README.md)
reproduces all 72 original images and shows that the scalar append body stays out
of line in every saved version/workload. The generated forwarding wrapper is
already inlined. This motivates testing the body itself; it does not establish
that call overhead caused the previous slowdown.

## Change and safety boundary

Mark the existing `fwp_p_ad_push` implementation `static inline` with
`__attribute__((always_inline))`, as already used by fwp's direct functional
primitives. Keep one implementation and the same explicit lookup-state argument.
Do not add a wrapper, alternate ABI, runtime setting or new language syntax.
Apply this to ordinary and proved-state F64 calls; typed/F128 recording is unchanged.

Inlining substitutes the same body at the call site. It does not prove any new
lifetime fact or justify removing a check. Preserve:

- Inactive-parent handling, mixed/expired/invalid-tape and representation checks.
- Parent indices, full-tape checks, capacity checks, growth and failure cleanup.
- Exact weight bits, evaluation/trap/write order and recorded node counts.
- Existing worker selection, task/reentry exclusions and local state lifetime.

Keep allocation/growth and recovery implementations unchanged. GCC may simplify
known arguments within the inlined body under the existing no-fast-math and
contraction-off settings. Measure code size and reported stack frames, since
inlining can increase both even when it removes calls.

## Reference and checks

Create the reference from the same source by replacing only the helper's
`static inline __attribute__((always_inline))` declaration with `static`.
Verify that unique edit and all other source identities. Both versions retain
lookup reuse and every earlier optimization. No dependency on an older fwp build.

Update every declaration-sensitive native probe and instrumentation reader.
Retain negative controls for omitted validation, changed trap order, stale tape
state and broken observers. Compare the inline and ordinary declarations at
production O1/O2, plus an O0 direct-recording control. Preserve nested/typed/wide
derivatives, ownership, tasks/cancellation, cleanup and the golden corpus.
Focused native checks ran on Linux ARM64/AMD64 and macOS ARM64, followed by all
nine production jobs, documentation and complete audits. The linked delivery
retains their source identities and the original missed timing limits.

## Frozen measurement limits

Use the [lookup protocol's](recording-lookups.md#verification-and-acceptance)
six coordinate/update/repetition cases, both result forms, explicit workspace
policies, GCC O1/O2 memory/work census and seven compiler inputs with 48 samples
each. Retain the same qualified Neoverse-N2/EPYC 7763 hosts, two sessions per
architecture, GCC O2, no fast math/contraction/LTO, two warmups and 98 balanced
rounds of seven fresh processes. Do not tune these after seeing results.

- Long solves: at least 5% faster than the same-source non-forced reference.
- Small solves and identical-copy variation: at most 2%.
- Compiler time/RSS: at most 5% growth, with the existing copy qualification.
- Identical allocation/retain/node/parent/capacity/lookup counts, no larger
  managed/raw peak, and zero final storage. Both versions use three lookups per
  pair/update; this change targets calls, not another lookup-count reduction.
- At most 128 additional bytes in the largest reported frame. Retain dynamic
  frame qualifications; this is not a bound on total call-stack consumption.
- Retain native compile elapsed time, executable/instruction size, process RSS,
  full compiler reports and C/Rust peer results with their algorithm differences.

No new timing batch until the related implementation and focused controls are
ready. Run each qualified session once; replace only hosts rejected before
building/timing. Audit every case and preserve misses. The standing policy may
retain verified work reductions with timing goals open, never failed semantics
or memory safety. This comparison cannot close an earlier failed comparison.
