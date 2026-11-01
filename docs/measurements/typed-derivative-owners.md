# Fewer owners in typed reverse derivatives

This protocol is fixed before implementation. The baseline is merged PR #236,
`658123c7c09aa8991ca69cbb82643e68244edc95`; its complete platform gates pass.
The [tape example](../terminology.md#tape-and-backward-pass) explains the terms.
The work concerns F128 and nested reverse calculations, whose weights and
adjoints are language values. Ordinary F64 tape arithmetic is unchanged.

## Three selected costs

1. `ad.push-owned` receives a temporary four-field record. It reads parent IDs
   and separately retains weight values; it never saves the record pointer.
   Allow the existing borrowed stack-record representation while keeping every
   child alive through growth, retention and failure.
2. Backward setup currently retains the tape's zero once per adjoint slot.
   Keep one owner in the tape and let slots containing that exact value borrow
   it. Other slots own their values. Normalize an independently owned callback
   result equal to that exact value by releasing the returned owner; do not
   compare numerical values or skip arithmetic/callbacks.
3. Building the output list currently retains each input adjoint and later drops
   the array's owner. Move a distinct owned adjoint into its list cell instead.
   A borrowed zero still needs one result owner. Protect the transferred value
   on the unwind chain until cell allocation succeeds.

For example, 256 typed operations need 256 calls to recording. Removing their
outer argument records saves 256 requests of 40 bytes each on a 64-bit target:
four eight-byte fields and an eight-byte header. Weight objects still have their
own required ownership. A tape with 257 adjoint slots needs no 257 additional
zero owners; one tape owner keeps that same immutable zero alive. If the final
input derivative owns a distinct value, returning it needs no extra retain.

## Count and safety acceptance

Use existing `ad_tape_ownership` and `autodiff_nested` targets. Compare raw
interpretation and native production GCC/Clang at O1/O2. Use explicit stack
storage on/off and workspace reuse on/off; retain generated C, binaries and
observations through the existing ownership-artifact mechanism.

- A 256-operation typed-recording fixture must remove exactly 256 heap argument
  records with stack storage enabled. Check F128 and nested weights, correct
  results, retained caller aliases and complete teardown. The disabled setting
  is a representation control, not an older compiler or compatibility mode.
- A deterministic typed-tape probe records initialization and result-transfer
  retains separately. Require no per-slot zero retains and no extra retain for
  transferring a distinct owned result. Returning a borrowed zero acquires one
  owner. Include empty inputs, untouched slots, repeated seeds, both parents
  equal, existing-argument returns and callbacks returning the shared zero.
- Check releases on ordinary return, failure and cancellation. Cover mixed/stale
  nodes, tape-full rejection, second-weight retention failure, nested callbacks,
  and failure immediately before/after a result-cell allocation. Every managed
  and raw ledger returns to baseline; no active tapes or cleanup entries remain.
- Broken controls must demonstrate that the observers detect retaining an extra
  result owner, dropping a borrowed zero and omitting transferred-value cleanup.
  Require each injection site to match exactly once; a source-string mismatch
  must fail preparation instead of silently running an unmodified control.
- Audit primitive declarations against the frozen inventory. The new nonescape
  fact changes no signature or child ownership contract. Preserve all current
  precision, checkpoint, nested-derivative and scope tests.

Report requests, requested bytes, retain operations, peak/final managed charge
and raw workspace storage separately where each observer measures them. Do not
call a nonzero allocator cache a leak or a zero ledger whole-process zero memory.
Retain actual native images and their instruction/stack reports when making a
representation claim. Do not infer execution speed from counts or code size.

## Timing and delivery

This batch selects count and lifetime requirements, not a new elapsed-time
acceptance threshold. It does not resolve D2's earlier F64 Rosenbrock speed goal,
N1/N2 kernel timings, or noisy identical-copy controls. If timing is added,
declare its workload, reference-only calibration, hosts, samples, boundaries
and limits before running the candidate; retain every failed observation.

Run focused checks together after all three changes are implemented. Then require
the exact final head's nine production jobs and documentation. Full builds,
suites and benchmarks run on GitHub; local work stays under the resource guard.
Results are pending until their source IDs, logs and retained observations are
recorded here and in [the handoff](../development-state.md).
