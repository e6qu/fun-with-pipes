# Pass temporary numeric records as numbers

## Cost and hypothesis

The [local derivative experiment](local-derivative-time-2026-11-07/README.md)
allocates two temporary `Dual` records per neighboring edge. Each record contains
only a value and a derivative. Passing four numbers to the edge function could
remove 407,552 allocations from its largest measured process.

The source regression at `9cb7497f3` establishes the cause: every direct
local-edge argument contains scalar `let` bindings around constructed `Dual`
records. The second input also contains the checked next-coordinate read.
These are not pure local/field reads. All three native hosts fail only that
selection assertion; nine other unit checks pass. Native integration tests and
measurements were not reached. [Complete logs](numeric-input-diagnosis-2026-11-07/README.md)
retain this failed hypothesis.

## Revised compiler change

Remove the unneeded worker-cloning experiment. Extend the existing all-callers
numeric-parameter rule only for computed numeric record constructors:

- Accept scalar `let` bindings ending in a record of pure numeric local/field
  reads, as well as the already accepted pure record inputs.
- At the call, bind each computed input once to a fresh typed local, in original
  left-to-right order. Read its numeric fields for the existing flattened call.
  Keep each input expression intact inside its binding: no scope lifting,
  repeated computation, moved traps or changed floating-point operations.
- Existing native field-only local handling can keep these records as numbers.
  Verify this in allocation counters and the actual emitted program.
- Preserve the two-level, two-to-eight machine-sized field limit. Function values,
  entries, unsuitable callers, recursive functions and escaping records still
  exclude the transformation. Do not clone functions or broaden lifetime rules.
- Bound analysis and added bindings linearly in the program size. No new syntax,
  public API, implicit conversion or runtime ownership decision.

This revision is frozen before replacing the failed implementation. The original
runtime limits and cost expectations below remain unchanged.

## Acceptance declared before implementation

1. Prove the measured edge reaches the changed rule. Test computed inputs and original lexical scopes, direct/function-value
   exclusion, exported and unsuitable callers, aliases, repeated reads, recursive
   exclusion, effect/trap order and linear analysis growth. Compare original
   typed IR or unoptimized interpretation with generated execution.
2. Check GCC ARM64/AMD64 and Clang ARM64 at production settings. Run existing
   numeric-input ownership controls as well as the local derivative probes.
   Preserve cleanup and shared inputs, including failures.
3. Require local forward AD to match the handwritten array program's managed
   allocation request count on all six frozen cases, with zero tape activity,
   unchanged retain counts, no increase in peak managed bytes and zero final
   live storage. Save C and native images; four numeric arguments must replace
   the measured edge's two input boxes.
4. Repeat the **changed program** under the existing seven-label, six-case,
   two-session-per-architecture protocol. Keep its original 20% long-case,
   2% small-case and 2% copy-control limits. Retain the first prototype's misses.
   Counts alone do not qualify the API.
5. Compare compiler costs with `f1cc94cf4e013369cccb8a836bd745f41e5d757c`
   on the existing representative compiler corpus. Require no case above 5%
   extra median compilation time or peak RSS. Record code size and stack use;
   performance is the priority. Retain every observation and source identity.
6. Complete the final nine native production jobs, documentation and audits.

## Implementation and results

The repair is implemented at `8b24da94a4e54c023f5e4b2341896d97dff092b9`.
[Three focused native jobs](computed-numeric-inputs-2026-11-07/README.md) pass.
[All six workloads](computed-numeric-time-2026-11-07/README.md) meet the exact
allocation/retain and live-storage requirements. The largest process removes
407,552 requests and takes 56–59% less time than ordinary reverse AD.

One runtime and two [compiler copy controls](computed-numeric-analysis-2026-11-07/README.md)
exceed the frozen noise limit. Their timing conclusions remain open; all fourteen
compiler comparisons stay within the 5% time/RSS limits. Complete observation
audits pass and retain every miss. No unchanged measurement was repeated.
Keep the compiler reduction; the local derivative helper remains a fixture,
not a public API. Final nine-job production coverage and documentation still
gate delivery.
