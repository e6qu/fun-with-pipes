# Current costs of automatic derivatives

This is the D1 measurement plan, not a performance result. It refreshes the
[older descent comparisons](descent-peers.md) with the current compiler, before
D2 chooses a representation change. No earlier fwp executable or generated-C
archive is required.

## What the programs compute

Rosenbrock's function penalizes each adjacent pair of coordinates `x, y` by
`100 * (y - x*x)^2 + (1 - x)^2`. A derivative tells us how that sum changes when
one coordinate changes. Each update subtracts `0.001 * derivative` from every
coordinate. Initial coordinates alternate -1.2 and 1.0. The output is the complete
final vector; all entries must be finite.

The six existing cases are 3 coordinates with 0, 1, 199 and 1,999 updates, and
33 or 129 coordinates with 199 updates. An update means one derivative evaluation
and one new vector. The history implementation therefore stores `updates + 1`
vectors, including the initial one. Zero updates still construct and print the
initial vector; it is not a measurement of process startup alone.

| Program | Derivative calculation | Storage during descent |
|---|---|---|
| fwp AD, history | Record local derivatives, then traverse them in reverse | Immutable lists; retain every vector until the final selection |
| fwp AD, current | Same automatic derivative | Immutable lists; retain only current weights |
| fwp explicit list | Handwritten formula | Immutable lists and intermediate list/pair values |
| fwp explicit packed | Handwritten formula | One new packed array per update; reads previous array |
| C explicit | Handwritten formula | Two reused contiguous buffers |
| Rust explicit | Handwritten formula | Two reused contiguous buffers |

A seventh timing label runs an exact copy of the fwp AD-current executable.
It checks whether execution order or host variation changes the measured time
of identical code. It is not another implementation.

C/Rust do not implement general automatic differentiation. Ratios against them
include recording and reverse traversal, collection representation, allocation,
formatting and runtime startup/teardown. The packed fwp formula may recompute an
edge residual while C/Rust compute it once and add to two coordinates. Explain
these differences; do not label the entire ratio “compiler overhead.”

## Measurements and controls

Build every program from current source in the same native Linux job on ARM64 or
AMD64. Use GCC O2, no fast math, `-ffp-contract=off`, no LTO, an explicit baseline
architecture and stack-usage output. Rust uses opt-level 2, checked arithmetic,
one codegen unit, generic CPU and no LTO. Record actual CPU, available processors,
compiler versions, flags, source hashes and executable hashes.

Run two warmups and 56 measured rounds. Each fourteen-round block balances every
position and ordered adjacent pair within its seven-entry rows, using the
existing Williams schedule and explicit seed 20261029. Cross-round boundaries
are not exactly balanced; retain every actual order. Use a 180-second timeout
per process and preserve incomplete results and diagnostics if a command fails.
Collect two independent sessions per architecture. These establish new descent
baselines; they do not change the CPU-counting budgets or claim a speedup.

Check each fwp program against its raw interpreter output, and all implementations
against the independent Python analytic derivative with absolute and relative
tolerance 1e-10. Each implementation's timed output must repeat exactly. Preserve
all samples and slow/noisy cases. Report medians and identical-code variation
separately for each case and session; do not pool hosts or select quieter runs.

Timing includes fresh-process launch, input construction, every update, complete
output and teardown. Compilation and observers are separate. Record generated C,
actual native image identities, instruction/file sizes and GCC stack estimates.
Do not infer memory safety from an instruction listing.

For each fwp form, separately observe managed allocation requests/bytes, retains,
peak/live charge, and raw derivative registry/parent/weight/adjoint storage.
Verify each backward traversal retires its tape, idle workspace is bounded by
512 KiB, and physical raw storage is zero after shutdown. Compare enabled and
disabled workspace reuse with explicit settings. Keep leak and omitted-observation
controls; instrumentation must not be used as ordinary execution timing.

## Separating costs before selecting D2

1. Compare AD-history and AD-current to quantify retaining old vectors. Compare
   explicit list/packed forms to expose representation costs, retaining their
   different arithmetic work in the explanation.
2. In a separate diagnostic image, time tape setup, forward work with recording,
   reverse setup/traversal, derivative-result construction and retirement. Forward
   time includes the objective and collection work; it is not pure append cost.
   Record operation counts and allocation changes at these boundaries. Compare
   this image with ordinary execution in 12 alternating paired rounds after two
   warmups to show the observer's own effect. Very
   short phases may round to zero at the host clock's resolution; do not treat
   that as zero computation cost.
3. Refresh the [output diagnostic](descent-output-protocol.md) for packed fwp and
   C/Rust: full vector formatting versus a shared checksum consumer, with exact
   result bits verified separately. Do not call zero-update time “output cost.”
4. Select D2 only after these observations identify a removable cost. Write its
   per-size storage/time limits before measuring a candidate. Preserve failure,
   cancellation and nested-scope cleanup; recomputation may replay only pure work.
5. D3 checks F64/F128 analytic and numerical derivatives, nesting, branch-domain
   boundaries and checkpointed work. State tolerances and domains explicitly;
   neither derivatives at discontinuities nor constant storage for arbitrary AD
   are promised.

The [implementation plan](../../PLAN.md#5-differentiation) owns acceptance and
[the handoff](../development-state.md) owns the current action. No D1 result has
been collected for this refresh yet.
