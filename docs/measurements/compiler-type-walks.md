# Avoid temporary copies while checking types

**Investigation; no compiler optimization implemented yet.** The CPU recordings
described in [checking costs](compiler-checking.md) show type cloning, resolution
and allocation/freeing among the larger costs. Caller-report verification is
still pending. Count the relevant copies before selecting a change.

## What is copied?

The compiler represents a type as a tree. For example, `I64 -> List[I64]` has a
function node, an input type and a result containing an element type. Cloning that
tree copies its nested nodes, strings and buffers.

Two existing traversals are candidates for borrowing:

- `free_vars` finds unresolved type variables, in their first-appearance order.
  Inspecting a type need not produce a copy of it.
- `zonk` substitutes resolved variables throughout a type and returns a new type.
  It needs that output, but may not need temporary copies of every subtree on
  the way to producing it.

Both currently call `resolve`, which returns an owned type. This is a hypothesis
about removable copies, not proof of their cost or of a safe replacement.

## Count the existing work

`suite=compiler-type-walks` builds an ordinary release compiler and a diagnostic
copy from the same source on native Linux ARM64 and AMD64.
[The observer](../../scripts/type_walk_probe.py) changes only `types.rs` and the
optional compilation report in a separate checkout. Nothing is added to shipped
fwp. Its manual `Clone` implementation performs the same field copies and counts:

| Counter | Meaning |
|---|---|
| `type_clones` | Every cloned `Type` node during the reported compilation |
| `free_vars_clones`, `zonk_clones` | Those nodes cloned while the named walk is active |
| `free_vars_visits`, `zonk_visits` | Calls to the walks, including recursive calls |

Counters use checked arithmetic and scope cleanup; the report requires both
active-walk depths to return to zero. Counts describe nodes, not allocated bytes.
If walks nest, their clone categories can overlap; do not add them as disjoint
totals. These instrumented builds do not measure ordinary compiler speed.

Use the same four original applications as the CPU probe. Ordinary and observed
compilers must emit identical C for each. Retain the observer patch, source and
compiler hashes, all counts, compiler phases, errors and process memory. Any
missing application or unexpected source change fails verification.

## Acceptance before changing a walk

If counts identify substantial copying, freeze the candidate against that source:

1. Preserve inferred signatures, diagnostics and their locations, macros,
   effects, nominal record constraints and generated C. Test bound-variable
   chains, nested constructor applications, open rows, variable ordering and
   rejected recursive types. Following variable chains must remain iterative.
2. Remove the demonstrated temporary copies; report remaining copies and any
   new work. Do not skip checking, cache user-dependent results or change the
   language/API to hide the cost.
3. Compare ordinary candidate/reference compilation, without debug metadata,
   counters or the phase reporter. Use four original applications and the twelve
   existing growth cases, one warmup and eight balanced paired rounds, two
   sessions per native architecture, with the existing 2% identical-copy control.
4. Target at least 5% less complete emit-C time for word counting and queued
   callbacks. Numerical/HTTP compilation and growth cases must not regress by
   more than 2%; process peak RSS must not grow by more than 5%. Retain every
   noisy or missed comparison. Compiler gains imply no runtime speedup.
5. Run affected correctness checks during development; run all nine production
   jobs, documentation and the complete-log audit once the coherent change is
   ready. Original roadmap timing misses remain open.
