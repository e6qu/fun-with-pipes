# Final-iteration source review and cleanup reproduction

This is preparation evidence, not a performance result. The
[implementation contract](../final-iteration-storage.md) defines the next group.

## Actual compiler output

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

## Fresh optional-result cleanup

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
The added `retain_unwind_ownership` regression must verify its actual O1/O2 output
and a deliberately omitted-cleanup control across the native matrix.
