# Eager captures in derivative programs

The comparison was published in `8a495a72` before implementation. A candidate
is now implemented; verification and measurements are pending. This is not a
speed claim.
[The earlier scalar-recording experiment](descent-costs.md#scalar-recording-results-allocation-reduction-retained-speed-goal-open)
keeps its allocation reduction and failed timing result. Its limits are unchanged.

## Cost and proposed change

A partial application supplies some arguments now and returns a function waiting
for the rest. For example, `add (calculate ())` must evaluate `calculate ()` when
the function is made, even if that function is called later. It must not repeat
that calculation, move it past another effect, or delay a failure.

The optimizer substitutes a function used once when its captured expressions can
safely move. Computed captures often prevent this, leaving temporary closures and
runtime dispatch. A diagnostic of the retained three-coordinate, one-update
Rosenbrock C program at `98b252a8` counted 111 visits to owned dispatch and 22
partial-application allocations per solve. All 512 complete outputs matched the
ordinary executable. This is a local Clang O2 operation count, not a timing or GCC
result, and it does not count every possible dispatch convention.

The proposed change binds complete eager capture computations at their original
point, once, in left-to-right order. It reuses the existing `bind_captures` helper
in `src/opt.rs`, already used to specialize known callbacks. The resulting known
partial application can then be substituted without moving its computations.
This should expose existing direct-call and callback specialization opportunities.
Do not raise inlining limits, add AD-specific wrappers, or change runtime APIs.

Only descend through known unsaturated applications. Do not enter an arbitrary
call returning a function. Keep original resource anchors; reject transformations
that cannot preserve observable cleanup or determine capture types. Rejection
must discard all newly prepared bindings/locals and leave the expression intact.

## Correctness requirements

Compare unoptimized interpretation, optimized interpretation and native GCC and
Clang O1/O2. Cover eager effects before input evaluation; two distinct failures
where the first must win; captures evaluated once; nested closures; aggregate
captures; unknown and saturated function-producing calls; and observable resource
or weak-channel lifetimes. Add structural checks that accepted examples expose
known calls, while rejected lifetime cases remain untransformed.

Preserve numerical operations and their order. Do not include F64 conversion
elimination: current raw/native NaN payload behavior does not justify an
all-engine bitwise-identity claim. Preserve mixed/stale-node and tape-full
rejection, exceptional/cancelled cleanup, workspace reuse and nested derivatives.
Use the existing test targets where possible; full builds and suites run on CI.

## Comparison fixed before implementation

Use [the repeated scalar-recording protocol](descent-costs.md#fixed-scalar-recording-acceptance-rules):
all six coordinate/update cases, current-result and retained-history programs,
complete output checks, two independent sessions on each matching Neoverse-N2
and EPYC 7763 host, identical compiler settings, explicit workspace/stack/reuse
settings, all 98 timing rounds and every individual process observation.

Build candidate and reference compilers from the same source. The reference
reverts only this experiment's eager-capture transformation to the existing
constant-only transformation. Both keep scalar recording's no-escape proof.
Archive that exact patch, source/file hashes, toolchains and both compiler hashes;
reject missing, partial or different reference changes. Keep C/Rust explicit
formulas as contextual peers; they do less work than general differentiation.

For each case and form, require all of these without changing limits afterward:

- Candidate/reference median whole-solve time is at most **0.95** with updates
  and **1.02** with zero updates. The identical-code control stays within **2%**;
  an unstable control makes the session inconclusive, not accepted.
- Managed allocation requests fall for every case with updates and do not rise
  with zero updates. Retains and peak managed charge do not increase. Every
  managed/raw ledger ends at zero. Raw tape profiles and release checkpoints
  match the reference; no retained dead scopes or enlarged workspace cache.
- Instruction sections grow by at most **1,024 bytes**, and the largest reported
  static frame grows by at most **128 bytes**, for each ordinary program.
  Retain all frame entries and whole binary sizes, not only the maximum.
- Complete outputs, operation/trap order, precision and lifetime controls pass.
  Counters and optional phase diagnostics are separate from timed executables.

Audit all failed criteria after preserving every observation. A failed candidate
must remain failed in the report; do not infer a speedup from fewer closures or
rewrite the earlier rejected scalar-recording result. This experiment can close
only its named D2 budget. Final delivery still requires all nine production jobs,
documentation and both compiler-analysis hosts on the final commit.
