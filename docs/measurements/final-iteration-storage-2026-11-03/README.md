# Final iteration values: native verification

All three focused hosts pass at `bb5433b688c26c60f0b2561a59420deb0f0e95ed`,
tag `roadmap/final-iteration-measurement-2026-11-04`.
[Run 41726742943](https://github.com/e6qu/fun-with-pipes/actions/runs/41726742943)
checks Linux GCC on ARM64/AMD64 and macOS Clang on ARM64. Runtime measurements
and the full delivery matrix are separate gates, not established by this report.
The [contract](../final-iteration-storage.md) was frozen before implementation.

## What changes

```fwp
0 | iterate 3 (add 1) | last
```

The count includes the initial value: `iterate` produces `[0, 1, 2]`, and `last`
returns `Some 2`. Previously, `last` reversed that list before reading its head.
Now it walks directly to the final node. If an eligible numeric iteration has
no other consumer, the compiler keeps only its current value:

```text
Before:  build [0, 1, 2] → copy [2, 1, 0] → Some 2
After:   current 0 → current 1 → current 2 → Some 2
```

Shared histories remain lists. Resources and other unsupported iteration states
are excluded from this rewrite; ordinary `last` still supports their lists.

## Verified allocation counts

These totals cover the scalar identity control, including list nodes, temporary
pointer storage and the returned option. They exclude caller-owned inputs.

| Positive count k | Original reverse/head | Direct last, history retained | Selected current-value loop |
|---|---:|---:|---:|
| 1 | 4 | 3 | 1 |
| 4 | 10 | 6 | 1 |
| 64 | 130 | 66 | 1 |
| General | 2k + 2 | k + 2 | 1 |

The selected loop removes 2k list nodes and one temporary pointer buffer.
Negative/zero counts allocate none. These are allocation observations, not speed
or peak-memory claims. Wide-number callback costs are reported separately.

## Checks and retained evidence

Each host passes:

- 268 compiler unit tests (four ignored), 46 integration tests across nine targets,
  formatting, Clippy and the unchanged primitive-contract baseline.
- Twelve raw/optimized selection checks, including the real gradient program.
  Shared histories and the already-current-value loop remain unselected.
- 418 native execution/image observations plus eleven interpreter/inventory
  statuses. Checks cover O1/O2, aliases, captured values, slices, reuse settings,
  exact bits, callback/effect order, count limits, failure and cancellation.
- Cleanup controls, including intentionally omitted cleanup, and generic `last`
  over files. Generated optional wrappers are released if retaining a child fails.
- Generated library docs and the collections tutorial in both execution modes.

[Index](native/index.json) and [acceptance audit](native/acceptance.json.gz) retain
the source, jobs and cross-host count agreement. Per-host `*-observations.json.gz`
records identify every checked file and native image, including ELF/Mach-O
architecture headers. `*-targets-and-controls.zip` retains target logs, inputs,
typed intermediate forms, generated C and execution transcripts; identical C is
stored once by hash. Full job logs are retained alongside them. Native executable
bytes remain in the original CI artifacts; these compact archives retain their
audited identities, not executable copies.

All earlier failures remain recorded: [private test import](compile-repair/README.md),
[missing list layouts](layout-repair/README.md), and
[omitted scratch-buffer count](count-repair/README.md). The passing batch includes
all three repairs.

## Preparation: compiler output before implementation

[Run 41698313044](https://github.com/e6qu/fun-with-pipes/actions/runs/41698313044)
at `13df096288aad41300f41d76f9a4f6c58440b192` compiles six sources in raw and
optimized modes on Linux ARM64 with production Rust settings. All 12 compilations
and the full-log audit pass. No program was timed or executed by this inspection.

- Scalar and numeric-list programs retain an `iterate` call, a `reverse` call,
  and a match that returns the reversed list's head as an option.
- The real 129-coordinate/199-update gradient program has the same structure.
  The history is held by one local before `reverse`; only the final item escapes.
- The shared-history control uses the history twice: once in the returned pair,
  once for `last`. A transformation must preserve that returned history.
- The current-value gradient program already uses a loop without this history.

[Archive](review/evidence.zip) contains every source, raw/optimized typed IR and
C file, command/status and hash manifest. [Audit](review/audit.json),
[artifact identity](review/artifact.json), [job](review/job.json) and
[complete log](review/job.log.gz) establish its source and results.

## Preparation: fresh optional-result cleanup

The C generator's existing `FreshOuter` path allocates a result wrapper before
retaining its borrowed child. A deliberately saturated reference count makes that
retain trap. The wrapper had no cleanup registration at that point.

A small Clang O2 source-level reproduction finds one leaked 16-byte allocation.
Registering the wrapper with the existing cleanup mechanism reduces this to zero.
Both observations explicitly reclaim their test inputs and finish with no extra
charged storage or wide-count metadata. No host exhaustion is attempted.

| Version | Storage left immediately after the trap | Evidence |
|---|---:|---|
| Original emission | 1 block / 16 charged bytes | [Report](cleanup/report.json), [C](cleanup/probe.c.gz) |
| Protected wrapper | 0 blocks / 0 charged bytes | [Report](cleanup/protected-report.json), [C](cleanup/protected.c.gz) |

These probes use retained runtime C from `beddd406` and reproduce the generator's
emission explicitly. They do not substitute for testing the repaired Rust generator.
The added `retain_unwind_ownership` regression now passes with actual O1/O2 output
and deliberately omitted-cleanup controls on all three focused hosts. The full
delivery matrix still must verify the final PR head.
