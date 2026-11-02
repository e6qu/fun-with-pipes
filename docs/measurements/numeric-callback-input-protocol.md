# Numeric callback input requirements

Freeze this document before implementation under
`roadmap/numeric-callback-input-protocol-2026-11-03`. This is stage 2 of the
[same ARC batch](derivative-owner-transfers.md), following the verified
[complete-field transfers](field-owner-transfer-protocol.md).

## What changes

The derivative mapper forwards two records, each containing a number and an
operation ID, to a function that only reads those fields. Passing the four
numbers directly can avoid temporary ownership of both record boxes:

```text
Before: lists own x,y → retain x,y → callback → read x.value,x.id,y.value,y.id
After:  lists own x,y → read those four numbers → callback
```

This is an internal representation change. Source functions remain curried and
single-argument; ordinary inference, source types and arithmetic stay unchanged.
No new function wrapper, implicit conversion or runtime ownership guess.

## Bounded selection and lifetime proof

- Start with internal functions of one nested-record argument. Allow exactly
  two record levels and two to eight machine-sized numeric leaves. Reject
  strings, arrays, functions, resources, variants, wide boxed numbers and deeper
  records. Keep the existing eight-field direct-call limit.
- Prove every use of the argument and its record aliases is a numeric leaf read.
  Repeated/reordered/unused numeric reads are allowed. Reject whole-record return,
  storage, capture, unknown use, updates, resource frames and tracing boundaries.
- Require only known saturated direct callers. Reject function-value references,
  constants containing its closure, public/named/service/test/main entries,
  cached values, special runtime-body references and recursive functions.
- At every caller, require the outer argument record to contain only plain local
  or field reads. Extract leaves in original field order; never duplicate a call,
  allocation, checked operation or effect. Rewrite all callers together with the
  callee's internal parameter type, aliases and leaf reads. Check typed IR after
  rewriting and before ownership insertion.
- The forwarding mapper then reads each flat numeric input field directly.
  Its existing direct-call ABI can pass those numbers without a boxed owner.
  Packed-map preparation may skip argument retains only for these proved numeric
  fields. Existing owning parameters still use their required preparation.
- The input lists remain owned throughout eager mapping. No borrowed box enters
  the numeric worker, and numeric bits own no children. Protect the result buffer
  before any callback; preserve callback entry ticks, checked arithmetic, effects,
  failure order and seed/map/fold order. Keep ordinary boxed/function-value entry
  cleanup wherever those entries still exist.

Prefer rewriting within an already-owned lowering program over another whole
program clone. Build function-reference/call information once; do not scan the
whole program for each candidate. Bound leaf-path work by eight fields and depth
two. Use linear graph analysis for recursion; no per-function reachability loop.
Analysis must be proportional to expression nodes plus call edges, with the
fixed field bound. Record deterministic visit counts on 32/128/512-function
synthetic IR inputs to reject accidental repeated whole-function scans.

## Required correctness controls

Compare raw/optimized interpretation and native GCC/Clang O1/O2. Include:

- direct forwarding and multiple callers; mixed numeric fields, reordered,
  repeated and unused reads; named records and tuples;
- equal input lists, repeated element boxes, retained aliases, empty/unequal
  inputs and callbacks that record derivative work;
- every selection exclusion, including escaping/functions-as-values, exported
  entries, effects in argument expressions, nested/wide/resource types and
  recursive calls;
- entry and continuation traps, actual cancellation, buffer/result allocation
  failure, exact owner counts and physical release; deliberately broken cleanup
  must fail;
- no wrapper or extra dispatch in saved generated C; native image identity and
  code/stack measurements on both architectures.

## Counts, compilation cost and timing

Use stage 1 source `ceecb569c6748a226ec6ddebc417dc16351490e9` and its
[96 audited observations](field-owner-transfer-checks-2026-11-03/verified-counts.json.gz)
as the incremental baseline. With `p=(coordinates-1)*updates`, remove at least
another `2*p` retains and attribute both mapper-input sites. The combined saving
against `a4f3200c` must be at least `3*p`. Attribute any additional savings.

Do not increase managed allocations, requested bytes, peak managed storage or
raw tape/workspace storage. Preserve output and derivative work; final storage
must be zero. Zero-update counts remain unchanged. Report instruction bytes;
maximum static-frame growth remains 128 bytes.

The same-source comparison compiler disables only this numeric-parameter rewrite
and its newly eligible numeric-input preparation; stage 1 stays enabled. Compare
explicit `build --memory dynamic --emit-c -O2` compilations of the existing field-transfer fixture,
the autodiff tutorial, and the 3/0, 33/199 and 129/199 current-only derivative
programs generated by the existing count driver. Save exact input hashes,
compiler images, commands, toolchains, elapsed samples and peak RSS. Use ten
balanced four-process rounds with two identical reference copies and two
identical candidate copies, after two warmups per copy. Alternate the orders
`candidate1, reference1, reference2, candidate2` and
`reference2, candidate2, candidate1, reference1` for five rounds each. Build both
compilers at the production Rust O1 settings, with assertions/overflow checks
enabled; record all environment settings and set `FWP_LTO=0`. Require identical-copy
medians within 2%, candidate/reference median at most 1.05 and peak RSS at most
1.05 times reference. Report failed/noisy cases; do not rerun unchanged samples
to obtain a pass. Deterministic analysis bounds remain mandatory regardless of
timing resolution.

After the combined implementation is complete, use the existing whole-solve
timing driver, two qualified sessions per architecture, unchanged 2% copy and
regression limits and 5% large-case improvement requirement. Retain every sample,
rejected host and failed limit. Then run one complete final platform matrix for
the substantial PR. Fewer retains alone do not establish speedup or C/Rust parity.
