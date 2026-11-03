# Private gradient arrays: verification

**Status:** corrected native checks and all 96 allocation observations pass in
[PR #252](https://github.com/e6qu/fun-with-pipes/pull/252). Both complete job logs
and every target log are audited. Compiler/runtime measurements and the final
platform matrix remain; no elapsed-speed gain is claimed yet.
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
passes at `f00fb9dc` on ARM64 and AMD64. It checks both engines,
GCC/Clang O1/O2, cleanup faults, typed/nested derivatives and all 96 allocation
observations across six sizes, current/history outputs and workspace modes.

Each host passes 19 selection units and 72 integration-test executions across
16 GCC/Clang targets. All 525 saved native images per host have matching ELF
architecture headers. The repaired recording fixture passes every configuration;
F128 with stack storage at O1 now charges 18,288 cumulative bytes against the
unchanged 18,320-byte limit. All 16 array-map/zip fault outcomes and 72 typed
recording/owner outcomes per host match their expected statuses.

- [Job/artifact identities and coverage](verified/summary.json).
- [ARM64 counts and source attribution](verified/aarch64-counts.json.gz), [controls](verified/aarch64-controls.json.gz), [targets](verified/aarch64-targets.json.gz), [full log](verified/aarch64-job.log.gz).
- [AMD64 counts and source attribution](verified/x86_64-counts.json.gz), [controls](verified/x86_64-controls.json.gz), [targets](verified/x86_64-targets.json.gz), [full log](verified/x86_64-job.log.gz).

### Allocation result

Both hosts, O1/O2 and workspace settings report the same reduction. One complete
129-coordinate, 199-update solve returning only the final coordinates has:

| Metric | Before | After | Change |
|---|---:|---:|---:|
| Allocation requests | 105,203 | 79,731 | −25,472 (24.2%) |
| Requested bytes | 3,736,014 | 3,326,870 | −409,144 (11.0%) |
| Retains | 995 | 995 | unchanged |
| Peak managed storage | 14,976 bytes | 14,976 bytes | unchanged |
| Final managed storage | 0 | 0 | unchanged |

The history form saves the same requests/bytes. Its peak remains 838,432 bytes
because it retains earlier coordinate lists. These are fwp allocation counters,
not process RSS; raw derivative buffers are checked separately and unchanged.
Zero-update counts stay unchanged. No reported largest stack frame grows; code
size changes by −368…+4,768 bytes on ARM64 and −528…+1,360 on AMD64. Code size is
reported separately from performance acceptance.

The removed group has 25,671 gradient-list cells / 616,104 bytes. The replacement
adds 199 conversion arrays of 1,040 bytes each (206,960 bytes). Scaling replaces
199 existing private buffers with equally sized typed arrays. The zip scratch
and coordinate-list output stay. Allocator-site records distinguish the new
leaf arrays from the old generic buffer allocation; constructor records identify
the removed list group. The net saving is 616,104 − 206,960 = 409,144 bytes.

The three remaining large constructor groups are input derivative records,
their input list and the updated-coordinate list, each still 25,671 requests /
616,104 bytes. They need separate alias/lifetime proofs; this result does not
prove they can be removed.

For `d` coordinates and `u` updates, the constructor audit requires exactly
`d*u` fewer gradient-list cells. Replacement arrays count against the total
saving: at least `(d-1)*u` fewer requests and `(16*d-8)*u` fewer requested bytes.
Retains and peak managed storage must not grow; final storage must be zero.
Counts do not establish an elapsed-time improvement.

### Next comparison

Compiler and runtime measurements compare two compilers built from the same
source, frozen by `roadmap/gradient-array-measurement-2026-11-03`. A frozen patch removes the complete grouped change from the reference:
internal result containers, direct map/zip consumption and interpreter/native
support together. Independent checks reconstruct all seven changed sources and
verify saved patches and binary identities. Timings cover complete equivalent
solves; C/Rust explicit derivatives are separate algorithm comparisons. Final
nine-job platform validation and documentation remain required before merge.
