# Session handoff

## Next action

Next: finish the grouped task-record work on `compact-task-records`, based on
user merge `ffcf04763990356fb3cb3913d6414082e00aa178` of PR #188. Open one PR
for its needed fixes, compact task flags, removal of ARC's tracing-only stack
marker and the matched native measurements. Use the primary workspace.
The first publication will open one draft PR and dispatch the six-native and
two-WebAssembly focused matrices. Publication details will be recorded in
`/private/tmp/fwp-task-record-publication.json`.

## Changes and validation

Task flags now use individual boolean bytes, grouped beside the ownership kind.
ARC omits the collector's saved stack marker and its switch-time write; tracing
keeps both. The live-task list remains because cancellation and shutdown use it.
[The measurement method](measurements/task-records.md) names inputs, counters,
comparison layouts and limitations. New arc_tasks checks retain all actual
binaries and compare output with raw interpretation; existing stress, reuse,
register-root, cancellation, static-memory and library-unload checks remain.
There are no new native execution results for this group yet. Guarded formatting, workflow structure, native target assignment
and documentation checks passed; full execution belongs on GitHub.

PR #188's focused runs at `71ef0268ca1a2f279036b4b6e57b81e2c8ad288f` are
`39630720224` (native) and `39630724707` (WebAssembly). Both Windows jobs failed:
the standalone C probe writes CRLF, while its exact-byte assertion expected LF.
The probe returned success; its assertion stopped later variants and caused the
artifact inventory to fail. The test and local binary inspector now expect the
actual Windows C output. Do not call the failed run acceptance. All eight focused logs are now audited: four native jobs and both WebAssembly
jobs passed; the two Windows jobs share this failure.

Audit with `/private/tmp/fwp-audit-task-cancellation.py` through the local guard.
It uses the saved publication/acceptance files under `/private/tmp`; preserve
that failed-source receipt before creating new-source runs. The user's merge
record is `/private/tmp/fwp-188-merge-record.json`. Original full production run
`39635039734` is pending; merge-push runs `39635064120` and `39635064137` duplicate
its tree. Preserve original full-run coverage and audit all completed logs.

The full production audit also found a macOS ARM64 registry DNS failure before
compilation. Its original log is `/private/tmp/fwp-188-119343104377.log`.
Production and the two focused suites now cache the lockfile's registry sources,
fetch with explicit network limits, then set Cargo offline for builds/tests.
No alternate registry, unpinned dependency or skipped check is introduced.
Run `/private/tmp/fwp-audit-188-final.py` to track all remaining original full jobs.

The earlier cancellation-only source `b37f5948d07128455a76e177f66448240bb47389`
passed all eight focused jobs; its immutable tag and raw report remain unchanged.
The newer source is preserved by `roadmap/revision-task-cancellation-71ef0268ca1a`.
The completed #187 receipt is `/private/tmp/fwp-187-final-acceptance.json`;
its verified merge is `eb9ba7e828a5ab8ef0f7579b7f6fe1263e752c8c`.
Do not repeat those merges or overwrite historical measurements.

## Delivery

Keep one substantial PR at a time, incorporating related work and every known
fix. Native execution and full gates run on GitHub. Use the local guard for
serial focused checks, preserving 64 GiB free disk, 2 GiB target, 1 GiB sampled
aggregate RSS and 180 seconds. No local native compilation or full suite.
Require all nine production jobs plus documentation for the final PR commit.
Then squash-merge with an explicit one-line subject of at most 80 characters,
an empty body and no attribution/trailers; verify message, parent and tested tree.
Continue to the next substantial roadmap group and keep this handoff current.

## Roadmap status

All seven areas in [PLAN.md](../PLAN.md) remain open. These changes reduce task
heap storage and unnecessary collector work; they do not finish tracing removal,
eliminate ARC, prove a general speedup or establish C/Rust performance parity.
The next ownership work must preserve failure/cancellation cleanup and measure
representative programs before choosing an optimization.

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing; prove retained ownership and cleanup. |
| 2 | In progress | Eliminate avoidable functional allocations and count traffic. |
| 3 | In progress | Resolve measured machine-code and performance gaps. |
| 4 | In progress | Improve differentiation time, memory and precision. |
| 5 | In progress | Validate numerical kernels and ahead-of-time GPU policy. |
| 6 | In progress | Establish equivalent-work comparisons and budgets. |
| 7 | In progress | Validate larger programs and bounded live memory. |
