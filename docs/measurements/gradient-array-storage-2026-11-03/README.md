# Private gradient arrays: verification

**Status:** implementation under review in
[PR #252](https://github.com/e6qu/fun-with-pipes/pull/252). The corrected native
run is in progress. No new allocation or elapsed-time result is accepted yet.
The [frozen contract](../gradient-array-storage.md) defines the requirements.

## What changes

For `x*x + y*y` at `[1.0, 2.0]`, the gradient is `[2.0, 4.0]`. A step that
subtracts one quarter of that gradient returns `[0.5, 1.0]`.

```text
Before: derivative array → gradient list → scaled buffer → zip → new coordinates
After:  derivative array → converted array → scaled array → zip → new coordinates
```

Public gradient helpers still return lists. The compiler removes a private list
only when one numeric map/zip consumes it. Shared values, unknown callbacks and
unproved lifetimes keep their ordinary owners. Map callbacks finish before zip
begins; aliases and partial-result cleanup must remain valid.

## First run: two test assumptions failed

[Run 41618374217](https://github.com/e6qu/fun-with-pipes/actions/runs/41618374217)
tested `aed66f26`, retained by `roadmap/gradient-array-first-attempt-2026-11-03`.
Both native Linux builds, all-target lint and selection units pass. All 16
GCC/Clang integration-target logs per host were audited. Two tests fail in each
compiler/architecture combination:

| Failure | Cause | Repair |
|---|---|---|
| F128 recording charge is 18,352 bytes against 18,320 | Building the expected comparison array adds 32 bytes before recording | Build that expected array explicitly at compile time; keep every recording limit |
| Nested cleanup injection cannot find stage 5 | The probe searches for the removed list builder; stage 12 also uses its old reverse-loop index | Inject at the completed array-slot transfer and protected input-owner transfer; retain all failure/cancellation modes |

The recording harness now collects all configuration failures before reporting.
The corrected run also tests array map/zip cleanup with deliberately omitted
buffer, scratch and partial-list releases. These controls must fail as expected.

- [Artifact identities, every target result and diagnostics](first-attempt/summary.json).
- [ARM64 target logs](first-attempt/aarch64-targets.json.gz) and [full job](first-attempt/aarch64-job.log.gz).
- [AMD64 target logs](first-attempt/x86_64-targets.json.gz) and [full job](first-attempt/x86_64-job.log.gz).

## Corrected run and measurement boundaries

[Run 41626196812](https://github.com/e6qu/fun-with-pipes/actions/runs/41626196812)
tests `f00fb9dc` on ARM64 and AMD64. Results remain pending. It checks both engines,
GCC/Clang O1/O2, cleanup faults, typed/nested derivatives and all 96 allocation
observations across six sizes, current/history outputs and workspace modes.

For `d` coordinates and `u` updates, the constructor audit requires exactly
`d*u` fewer gradient-list cells. Replacement arrays count against the total
saving: at least `(d-1)*u` fewer requests and `(16*d-8)*u` fewer requested bytes.
Retains and peak managed storage must not grow; final storage must be zero.
Counts do not establish an elapsed-time improvement.

Compiler and runtime measurements compare two compilers built from the same
source. A frozen patch removes the complete grouped change from the reference:
internal result containers, direct map/zip consumption and interpreter/native
support together. Independent checks reconstruct all seven changed sources and
verify saved patches and binary identities. Timings cover complete equivalent
solves; C/Rust explicit derivatives are separate algorithm comparisons. Final
nine-job platform validation and documentation remain required before merge.
