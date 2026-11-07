# Pass temporary numeric records as numbers

## Cost and hypothesis

The [local derivative experiment](local-derivative-time-2026-11-07/README.md)
allocates two temporary `Dual` records per neighboring edge. Each record contains
only a value and a derivative. Passing four numbers to the edge function could
remove 407,552 allocations from its largest measured process.

The compiler already flattens nested numeric parameters when **every** use permits
that representation. A function-value reference or an unsuitable caller excludes
the entire function. Investigate the actual optimized local-edge input before
claiming that this restriction explains the measured boxes.

## Proposed compiler change

Extend `src/cgen/numeric_parameters.rs`, keeping its existing field-use proof:

- If every use qualifies, retain the existing in-place transformation.
- Otherwise create at most one private numeric worker for that function and
  redirect only proved direct calls. Keep the original for function values,
  exports and other callers. The worker contains the calculation, not a wrapper.
- Preserve the two-level, two-to-eight machine-sized numeric-field boundary.
  Reject recursive functions and bodies that let the original records escape.
- Read only typed locals/fields at a changed call. Do not duplicate computation,
  reorder arithmetic, move traps or remove checked indexing. Ownership insertion
  still follows typed-IR validation.
- Bound analysis and additional bodies linearly in the input program. No new
  syntax, public API, implicit conversion or runtime ownership decision.

If the actual call fails a different proof, record that cause before extending
this boundary. Do not add speculative lifetime rules to force selection.

## Acceptance declared before implementation

1. Prove the measured edge reaches the changed rule. Test mixed direct/function
   uses, exported and unsuitable callers, aliases, repeated reads, recursive
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

This is a hypothesis and an acceptance contract, not delivered support.
