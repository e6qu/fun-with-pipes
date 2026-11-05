# Scalar constants: allocation and stack checks

**Both hosts and the complete saved-data audit pass.** Replacing proved numeric
constants removes generated cache reads while preserving measured allocation,
derivative work and stack costs. It does not save additional heap storage.

Compare two fwp compilers at `76690b385514c58ad94c5591da3553fa48218535`:
scalar replacement enabled versus disabled. Both retain the earlier private
pair-buffer reuse. This is not a comparison with C, Rust or Swift.

- [Census](https://github.com/e6qu/fun-with-pipes/actions/runs/42072583890): Linux ARM64/AMD64, GCC O2
  for 12 repeated-solve cases; 24 fresh cases per compiler at O1/O2.
- [Audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42074145465): verifies commands, outputs,
  source/compiler identities, exact counts, phase profiles and native image headers.
- Inputs: 3 coordinates with 0, 1, 199 or 1,999 updates; 33 or 129 coordinates
  with 199 updates. Both final-result and history forms, with derivative workspace
  reuse explicitly enabled and disabled. The [protocol](../scalar-constant-lowering.md)
  defines repetitions and limits.

## Memory and work are unchanged

For 129 coordinates and 199 updates, on both architectures:

| Metric | Cached reference | Direct constants |
|---|---:|---:|
| One fresh solve: managed allocation requests | 528 | 528 |
| One fresh solve: requested bytes | 625,222 | 625,222 |
| One fresh solve: peak charged bytes | 7,200 | 7,200 |
| Eight repeated solves: managed requests | 4,361 | 4,361 |
| Eight repeated solves: requested bytes | 5,005,064 | 5,005,064 |
| Eight repeated solves: peak charged bytes | 11,584 | 11,584 |
| Repeated solves with workspace reuse: peak raw derivative bytes | 33,904 | 33,904 |

All cases preserve request/byte/retain counts and derivative work; final managed
and raw storage is zero. The reference reconciles with the saved PR #260 candidate
counts and phase profiles. These storage counters do not measure whole-process
RAM, which is recorded separately during timing.

## Stack costs are unchanged

All 12 cases have equal candidate/reference maximum reported frame sizes.
Selected GCC O2 observations (names give coordinates, updates and result form):

| Case | ARM64 bytes | AMD64 bytes |
|---|---:|---:|
| 3-1-current | 704 | 720 |
| 33-199-current | 704 | 720 |
| 33-199-history | 816 | 768 |
| 129-199-current | 2,240 | 2,192 |
| 129-199-history | 2,240 | 2,192 |

These are individual reported frame sizes, not total call-stack bounds. History
programs include GCC `dynamic` entries; their known bytes and qualifiers agree,
but GCC does not bound their variable portion. No part of the allowed 128-byte
frame increase is used.

## Evidence

[Retention](retention.json) records the audit archive identity and digest.
Each host folder contains the full log, original artifact identity, audited
reports, parent reconciliation, a hash inventory and compact observations.
Original artifacts retain generated C and executable bytes. The
[first observer failure](../scalar-constant-checks-2026-11-05/census-observer/README.md)
remains separate; its parser repair changed no compiler code or measurement limit.

[Compiler costs](../scalar-constant-analysis-2026-11-05/README.md) pass.
[Runtime results](../scalar-constant-time-2026-11-05/README.md) retain 27 missed
speed targets. [Final production verification and delivery](../scalar-constant-delivery-2026-11-05/README.md)
are complete.
