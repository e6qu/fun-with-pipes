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
Focused results follow below. [The handoff](../development-state.md) tracks
full final-head production validation.

## Read the recording fixture

[The fixture](../../tests/fixtures/ad_typed_recording.fwp) manually constructs an
identity-derivative chain to isolate recording costs. Its `WEIGHT_*` names are
replaced by the test harness with F128 or nested `Rev[F64]` types/constants.
They are test placeholders, not new language syntax.

| Local name | What its initializer does | Value used afterward |
|---|---|---|
| `base` | Register the input values with `ad.tape-owned` | ID of the first input node, not its numeric value |
| `final` | Loop 256 times, recording one weight-1 edge each time | Last node ID |
| `result` | Run backward from `[final]` with seed `[WEIGHT_ONE]` | Input derivatives: `[WEIGHT_ONE]` |

```text
let base = create the tape input
in (let final = record the chain
    in (let result = calculate the derivatives
        in check the input alias, then select result or trap))
```

This is an explanation of nesting, not runnable source. Each `in` belongs to
the preceding `let`; `in let final` means the first binding's body is another
binding. The last body returns the saved derivative list only if the input
still equals `[WEIGHT_ONE]`. That checks preservation of the caller's alias.
See [local names](../terminology.md#local-names) for a small runnable calculation.

The loop carries `(remaining, node)`. `Again` decrements the count and records
the next node; at zero, `Stop node` supplies `final`. Every edge has derivative
weight one, so a final seed of one propagates back to one at the input.

## Focused results

[Run 41290359214](https://github.com/e6qu/fun-with-pipes/actions/runs/41290359214)
passes at `c5acb7d980a0efba9505b5edc4a37802337cad4f` on Linux ARM64 (GCC 13.3),
Linux AMD64 (GCC 15.2) and macOS ARM64 (Clang 23.1.4). Each host passes eight
derivative/cleanup targets, ownership unit checks and the frozen primitive audit.
The [retained observations](typed-derivative-owners-2026-11-01.json.gz) include
compiler identities, outputs/statuses, image/source hashes and static-frame reports.

- Both weight types, O1/O2 and workspace off/on: 256 recording calls;
  stack off uses 256 heap argument records, stack on uses zero.
- All six adjoint modes: zero initialization retains; result retains are
  `2, 3, 3, 2, 0, 3`, solely for independently owned shared-zero results.
- All positive cases return to zero final charge or their stated baseline.
  Extra-owner and borrowed-zero-drop controls fail with 188 and 187 respectively.
  The nested suite also checks missing cleanup during result transfer.
- Thirty reported images match their source hashes and native architecture;
  all 84 saved typed-probe outcomes match their expected status.

Whole-process charged storage for the recording fixtures agrees across these hosts:

| Weight type | Stack off → on: cumulative charged bytes | Peak charged bytes | Final charged bytes |
|---|---:|---:|---:|
| F128 | 30,608 → 18,320 | 11,056 → 11,056 | 0 → 0 |
| Nested `Rev[F64]` | 96,384 → 43,056 | 31,680 → 31,664 | 0 → 0 |

These are allocator-charge counters, not requested payload bytes or process RAM.
The stack switch affects other eligible records too; do not attribute the entire
nested reduction to the 256 counted outer records. The dedicated record counter
isolates those records. The six-mode ledger's process peak stays 1,504 charged
bytes; it is cumulative across modes, not a reset per-mode peak.

Instrumented executable file sizes, with stack storage off → on:

| Host | F128 O1 / O2 bytes | Nested O1 / O2 bytes |
|---|---|---|
| macOS ARM64 | 148,112 → 148,112 / 164,496 → 164,496 | 89,360 → 89,296 / 89,248 → 89,200 |
| Linux ARM64 | 156,224 → 156,224 / 155,872 → 155,832 | 79,568 → 79,464 / 79,264 → 79,200 |
| Linux AMD64 | 134,336 → 130,240 / 146,440 → 146,400 | 82,120 → 77,920 / 85,968 → 81,808 |

Largest reported function frames stay unchanged per comparison: macOS 720 bytes;
Linux ARM64 704; Linux AMD64 688 at O1 and 720 at O2. Individual frames remain in
the record. These are separately compiled static estimates, not maximum stack
usage of the running process. File sizes include linking/layout costs and are
not instruction counts. There is no elapsed-time measurement in this batch.

The first run, `41289222076` at `5f1741624834da7ded8e4990ef3bc3245ac8aacd`,
failed both new probes on all hosts. Existing targets passed. Repairs:

| Probe fault | Repair |
|---|---|
| Fault-injection text matched four constructors | Match the specific guarded result transfer; require exactly one site. |
| Heap counter queried mutable-buffer capacity | Use heap membership; immutable records deliberately have no such capacity. |

No runtime change or acceptance relaxation was needed. Counts now print before
assertions so failed observations remain visible. Full final-head production
validation remains required; this focused result covers three of the six hosts.
