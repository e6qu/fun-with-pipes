# Next: implement N1's four kernel baseline cases

**Next:** review and publish the prepared four-case runner, then dispatch
`kernel-baselines` with `native_runner=all`, `comparison_session=both`. Audit
all results/rejections under the [frozen protocol](measurements/kernel-baselines.md).
Compiler/runtime optimizations are unchanged. No second PR while #227 is active.

Worktree `/private/tmp/fwp-kernel-baselines`, branch `numerical-kernel-baselines`,
based on #227 final head `56528ffb`. The active delivery is still #227 in
`/private/tmp/fwp-ad-captures`; monitor native `40901634818`, docs `40901634737`
and G2 `40901630875`. Merge only after all gates pass and full logs are audited.
Its handoff owns final D2 delivery. Merge main here after that verified merge.

N1 protocol adds 262,145 array elements and 257×259 by 259×255 matrices to the
existing small cases. It keeps eight calculation rounds, ordered arithmetic and
separate kernel/allocation-inclusive/process timers. Four labels include a
byte-identical fwp control. Two independent sessions per matching native host,
all outputs, memory and code/stack evidence are required before choosing N2.

The older numerical runner remains the separately documented short experiment
used by solvers/library/performance/iteration workflows and emitted-C controls.
The new N1 runner has its own repeated-host protocol and explicit configuration;
it reuses the existing C/Rust/native harness formulas without changing those
older invocations. No compiler compatibility adapter is introduced.
Historical numerical prose now names all four old labels: C, Rust, tracing fwp
and ARC fwp. Source a3d8f16e verifies eight four-label batches, forty samples per
label. The current three-label runner has six batches. No observation changed.

`scripts/numerical-baselines.py` implements the exact integer result oracle and
balanced process schedule. Six small-input and altered-evidence control tests pass through the local
guard. An initially overstrict test assumed cross-round predecessor counts were
balanced; only the declared within-round pairs have that guarantee. The corrected
test checks fifteen occurrences of each within-round pair and the protocol keeps
the boundary limitation explicit. No measurements or acceptance limits changed.

`measure-kernel-baselines.py` is prepared with four exact shapes, full result-bit
verification, profile-only counters, a deliberately leaked-owner control, separate
RSS, ELF sections, frame reports and persistent partial command/round records.
The workflow requires explicit host/session selection and preserves rejections
before building. Workflow lint passes. Native generation and runtime assumptions
remain unverified until GitHub checks; do not call preparation a passing baseline.

No compiler change, native build or new measurement has run for N1. Guard limits
stay unchanged. Current #227 evidence is already audited as documented there.
No subagents. Local work remains serial; full builds/suites/benchmarks on CI.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain GC-free lifetime and cycle checks |
| 2 | Verified | Maintain A1–A6; sharing still uses ARC |
| 3 | Verified | Maintain F1–F3's stated call/recursion scope |
| 4 | Verified | Selected decimal cost delivered; loop gap remains recorded |
| 5 | In progress | #227 final D2 delivery; D1/D3 verified |
| 6 | In progress | N1 baselines before N2 optimization |
| 7 | In progress | Broader B1/B2 comparisons |
| 8 | Pending | V1–V2 application validation |
