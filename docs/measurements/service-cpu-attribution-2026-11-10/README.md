# Queued service: ownership and cleanup dominate identified CPU work

Both native replays pass all sixteen profiles and independently reconstruct all
32 peer/case outputs, calibration choices, sample periods and attribution rows.
No program was rerun. The reader repair changes only profiler symbol parsing;
the original unpatched reader still reproduces the defect.

## What the samples show

The service builds and dispatches 4,096 messages with 16 integers per payload,
then checks received values and releases storage. [The protocol](../service-cpu-costs.md)
defines cancellation, expiration and handled errors. Each peer's batch length was
chosen independently: these percentages cannot supply peer elapsed-time ratios.

| fwp case | ARM64 ownership operations | AMD64 ownership operations | ARM64 cleanup push/pop leaf | AMD64 cleanup push/pop leaf |
|---|---:|---:|---:|---:|
| Delivered | 42.08% | 49.64% | 25.60% | 12.08% |
| Cancelled | 40.94% | 50.27% | 27.43% | 11.82% |
| Expired | 42.75% | 50.60% | 31.81% | 13.86% |
| Handled error | 39.64% | 48.41% | 26.47% | 13.86% |

Ownership includes locating and changing counts and checking the last owner.
Cleanup push/pop registers and removes the callbacks that release live values on
failure. Its leaf column counts samples actually inside those two functions;
it is a subset of the reader's remaining-operation category. The columns use
different attribution rules and must not be summed into a claimed total speedup.

For example, fwp's generated match worker `w40` contains nested original-lifetime
frames. Each inner frame retains values already protected by an outer frame,
registers cleanup, then removes cleanup and releases its extra owners on return.
These frames keep resource disposal and weak expiration at the source program's
boundaries. Removing them requires proving another live owner covers the same
value for the whole inner scope; simply dropping cleanup would be incorrect.

The identified cost suggests **borrowing nested lifetime protection from an
already active enclosing frame**, before changing channel representation or
adding language syntax. The candidate must preserve weak expiration, errors,
cancellation, cleanup order and ordinary ownership. HTTP request/connection handling also has observable resource lifetimes;
selection in its generated code and a shared speedup remain to be verified. [The candidate contract](../nested-resource-owners.md) defines the
next implementation and its acceptance tests.

## Limits and peers

- fwp's unnamed leaf work is 0.15–0.70% on ARM64 and 0.19–0.32% on AMD64.
  Almost every stack nevertheless contains an unnamed libc ancestor. “A stack
  contains an unknown frame” does not mean its sampled leaf is unknown.
- One ARM64 handled-error sample has no decoded frame; it remains visible.
- Inlining erased the source construction/dispatch/drain boundaries in fwp.
  The reader assigns 99.73–100% to remaining service work, not guessed phases.
- For full delivery, unnamed leaf work is 43.12%/50.27% in C,
  45.00%/48.17% in Rust, and 9.79%/12.50% in Swift (ARM64/AMD64).
  These limit peer attribution. Known Swift weak/reference-count operations
  are visible, but neither their CPU shares nor fwp's are operation counts.
- The reader's allocation category recognizes a limited explicit symbol set;
  unrecognized operations, including some inline allocation helpers, remain
  unclassified. Its small percentage does not prove allocation is cheap.
- [The earlier ordinary comparison](../weak-callback-time-2026-11-09/README.md)
  establishes the 19–20× C / 5–7× Swift gap. This profile does not update that ratio.

## Verification and retained records

Recording source `fac4a47440fb02667ddbf385dba959ae8f91a310`, run `42772697088`;
decoder source `65719f7fc2277a5b97c5a790df941fea6c5eb4d7`, tag
`roadmap/service-cpu-software-clock-2026-11-10`,
[replay run 42781360626](https://github.com/e6qu/fun-with-pipes/actions/runs/42781360626).

| Host | Job | Artifact | Result |
|---|---|---|---|
| ARM64 | `129711934407` | `13746173266` | 32 cases / 16 profiles pass |
| AMD64 | `129711935132` | `13747030196` | 32 cases / 16 profiles pass |

[ARM archive](arm-replay.zip) and [AMD archive](amd-replay.zip) retain the raw and
demangled stacks, full summaries, original summaries and GNU defect controls.
They also retain the one-condition source patch, perf build log, enabled unwind
features and executable hash. Both whole-archive sizes, SHA-256 digests and all
ZIP CRCs were verified; guarded local reconstruction also passes both archives.
The original reader produces 115 ARM / 121 AMD sentinel errors in these controls.
Those diagnostic counts can vary by reader exchange; they are not sample totals.

[ARM summary](arm-summary.json), [AMD summary](amd-summary.json),
[symbol map](function-names.json),
[matching generated C](original.c.gz), [artifact metadata](artifacts.json) and
[file hashes](files.json) retain the inputs. Generated C and the symbol map match
the original recording manifest. Complete [ARM](arm-job.log.gz) and
[AMD](amd-job.log.gz) logs show no compiler or replay diagnostics. Package notices
concern optional manual pages. The artifact-download action emits a deprecated
Node Buffer warning; the next workflow uses an explicitly verified API download.
[Earlier failed decoder/build attempts](../service-decoder-replay-2026-11-10/README.md)
remain separate evidence.

Reproduce either summary with [summarize-service-cpu.py](../../../scripts/summarize-service-cpu.py),
using the extracted `service-cpu-replayed` folder, retained symbol map and the
explicit recording/decoder source and architecture shown above. It first audits
the raw records, then reports all leaf and classified periods without dropping
unknown samples.
