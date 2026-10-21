# Session handoff

## Next action

Next: finish the grouped integer-counting comparison and repair verification in
[draft PR #182](https://github.com/e6qu/fun-with-pipes/pull/182), branch
`investigate-native-counting-costs`. All four failed/completed focused jobs have now been audited in full.
Publish the combined repair and matched comparison. The working tree adds matched C/Rust peers, ordinary inline
hints, independent report audits and a binary-protocol assertion repair. These
changes are not yet published or verified natively.

The first new boundary test mistakenly compared binary protocol output with
plain-text expected lengths. It now reads typed I64 frames and compares their
payloads with Rust decimal-format lengths, preserving protocol coverage. All four focused logs confirm only that assertion failure and the consequent
missing-binary inspection failure; every other target passed. The recorded 113
signed I64 frames from each first-run failure pass independent protocol/decimal
checks in `/private/tmp/fwp-check-length-protocol.py` (0.13s). Native verification
of the repair still runs on GitHub.

Then run suite `integer-counting` on GitHub: it now combines the five relevant
integer tests, twelve binary inspections and the matched measurement on both hosts. Audit
all logs, every timing sample and actual generated instructions before marking
the PR ready. Require nine production jobs plus documentation on the final head;
squash-merge with an explicit one-line subject of at most 80 characters and an
empty body, without trailers or attribution. Standing authorization applies.

## Current implementation and evidence

The [measurement guide](measurements/integer-counting.md) explains the workload,
comparisons, timing scope and limits. The candidate counts decimal digits in
groups of 16, 8, 4, 2 and 1 instead of repeatedly dividing by ten. Signed values
use unsigned magnitude, including I64's minimum, then add the sign. No lookup
table or heap storage is added. Existing checked arithmetic and trap order remain.
Boundary inputs cover both sides of every representable power of ten, both signs,
and unsigned extremes; native/interpreter verification is still pending repair.

| Preparation | Source | Measurement / focused checks / documentation |
|---|---|---|
| Shared counting loop, not selected | `995d3ecfd451700ec93e0fc1b326f8be0503bad5` | `39525618134` passed / `39525621027` failed: assertion and missing binaries / `39525810747` passed |
| Grouped counting, before inline hints | `5852017124334bb199ff653741b068f9b8c9f979` | `39526333980` passed / `39526336925` failed: same assertion and missing binaries / `39526267015` passed |

Both measurement runs and documentation logs are audited clean. The shared-loop
candidate was 1–4% slower in median child CPU time on AMD64 and 2–3% slower on
ARM64 than the unchanged rebuild. Grouped counting reduced CPU medians by
16–19% on EPYC 9V74 and 13–14% on Neoverse-N2, across four pinned CPUs each.
All samples are kept in the linked reports; old C/Rust still use a different
algorithm, so those ratios are not language-overhead measurements.

Actual grouped binaries contain two counting-helper calls per iteration on both
architectures. The next experiment adds an unhinted grouped control and C/Rust
with the same algorithm to measure ordinary inline hints and remaining overhead.
No forced inlining or universal speed claim is made.

Current artifacts: `/private/tmp/fwp-counting-costs` and
`/private/tmp/fwp-grouped-counting-costs`. Full-log receipts:
`/private/tmp/fwp-counting-preparation-audit.json` and
`/private/tmp/fwp-grouped-counting-audit.json`; audit scripts use the same stems.
The report validator is `scripts/summarize-integer-counting.py`, with explicit
`--comparison legacy` for the first experiments and `matched` for the next.
It verifies source replacement, binary/disassembly hashes, every sample/median,
ratios, zero managed storage counts and the injected-allocation control.

Saved baseline inputs come from `62ed104504b9e9a032434223120785e3cc37a47f`, focused
run `39469883481`, tag `roadmap/revision-record-borrows-62ed1045`. The first new
experiment is preserved by `roadmap/revision-integer-loop-995d3ecf`. All generated
source, binaries, disassembly and raw samples remain in the artifacts.

The contributor guide's obsolete claim of no third-party Rust crates is corrected
to match existing Rustyline/ctrlc dependencies. Historical benchmark reports remain
tied to their actual source and algorithm; current peers are updated together.

## Accepted base and remaining goals

[PR #181](roadmap-history.md#temporary-channel-borrows-and-failure-cleanup-pr-181)
passed all nine production gates and documentation at `2038c926`. Its squash
merge `c98da7a5b3d859fee69120cf3452dcdecc904979` has the identical tested tree
`2fc33e8e7b238402acfc30efe3aee753ac4a018c`. Receipt:
`/private/tmp/fwp-181-acceptance.json`. The one-line 59-character message has no
body or trailers. Duplicate production run `39503544541` was cancelled; duplicate
documentation `39503544342` passed.

All seven roadmap areas remain open. Default native execution still includes
tracing GC; JIT is excluded. Retained resources, persistent subscriptions,
resource-owning tail frames and mutual recursion need further proofs. Earlier
identical binaries had variable AMD64 CPU time; its cause remains unresolved.
Do not infer that a new algorithm explains that historical variation.

## Local checks and resources

Use `python3 scripts/local-guard.py` for local checks: 64 GiB free disk, target
below 2 GiB, sampled aggregate RSS below 1 GiB and 180 seconds. Full builds,
native compilation, full suites and benchmarks run on GitHub. No limits were
raised. Recent free space is about 66 GiB; recheck before downloading artifacts.

Guarded checks: Python syntax/helper selection/whitespace 0.13s; focused Rust
formatting 0.25s; documentation 3.31s; first/grouped report audits 0.58/0.59s;
artifact downloads 8.62/8.05/17.61s. Full-log audits took 4–7s each. The sandboxed
guard initially could not inspect `ps`; its approved invocation passed. Direct
Git launches previously hit OS process-group signal permissions; Python-supervised
Git passed under the same guard. No checks or guard limits were bypassed.

Prior authorized cleanup reclaimed 6.553 GiB of obsolete generated downloads after
verifying remote recovery artifacts. Sources, reports, logs and current evidence
were preserved. Recovery manifests: `/private/tmp/fwp-disk-cleanup-2026-10-20.json`,
`/private/tmp/fwp-disk-cleanup-second-2026-10-20.json` and
`/private/tmp/fwp-disk-cleanup-extra-generated-2026-10-20.json`.
Some older Rust artifacts are `*.codex-archive.gz`; preserve them and compare
decoded bytes explicitly when needed, without assuming raw files exist.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing; prove retained ownership and cleanup. |
| 2 | In progress | Eliminate avoidable functional allocations and count traffic. |
| 3 | In progress | Resolve measured machine-code and performance gaps. |
| 4 | In progress | Improve differentiation time, memory and precision. |
| 5 | In progress | Validate numerical kernels and ahead-of-time GPU policy. |
| 6 | In progress | Establish equivalent-work comparisons and budgets. |
| 7 | In progress | Validate larger programs and bounded live memory. |
