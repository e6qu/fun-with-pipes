# GCC leaves the recording helper out of line

The append helper checks a tape and records one derivative operation. Inlining
would put its body at the call site, allowing GCC to specialize known arguments.
This diagnostic checks whether that already happens; it does not time execution.

**All 72 rebuilt executables match the originally measured bytes.** Native
ARM64/GCC 13.3 and AMD64/GCC 15.2 ran the [frozen diagnostic](../recording-call-costs.md)
at `7d68bcea91b27023f0408ca7543058eb6f592873`, contract `4e7ff3ef`.
[Run 42155555677](https://github.com/e6qu/fun-with-pipes/actions/runs/42155555677)
passes both jobs: ARM64 `127688745853`, AMD64 `127688745884`.

## Finding

For every case and result form, across the previous candidate, lookup reference
and lookup candidate:

- GCC reports no successful inlining of `fwp_p_ad_push`, the scalar append helper.
- Its final missed-inlining reports cite `max-inline-insns-auto`, the compiler's
  automatic size limit. The generated forwarding wrapper is already inlined.
- The lookup reference gets a constant-specialized append helper; the candidate's
  selected calls still pass their local lookup state into the general helper.
- The same broad decisions occur on both architectures. They do **not** explain
  why only some measured cases slow down, or establish a slowdown's root cause.

For example, in the 129-coordinate/199-update current-result candidate, GCC leaves
all six direct append calls in worker `w120` out of line. The reference's wrapper
calls also reach an out-of-line append body. Removing the wrapper again would not
remove that runtime call. The next candidate will explicitly inline the scalar
append body, keeping every check and the existing cold growth/recovery callees.
Its speed, stack and compilation costs still need measurement.

## Evidence

| Native architecture | Complete bundle | Original metadata | Decisions |
|---|---|---|---|
| ARM64 | [aarch64.zip](aarch64.zip) | [artifact](aarch64-artifact.json) | [all 36 cases](aarch64-decisions.json) |
| AMD64 | [x86_64.zip](x86_64.zip) | [artifact](x86_64-artifact.json) | [all 36 cases](x86_64-decisions.json) |

Each bundle contains the original audited session/report identities and all C,
commands, compiler stdout/stderr, GCC reports, rebuilt images, stack reports and
hashes. Complete job logs are retained alongside it. All 72 source/image/report
hashes and compilation results were checked; neither job has unexpected diagnostics.
The local bounded audit took 0.12 seconds. Its first attempt passed text to the
byte-oriented log scanner; correcting that helper input completed the audit.
No compiler or timing workload was repeated.

Counts in the decision JSON are report entries, **not** executed calls or timings.
GCC's internal cost estimates are not observed nanoseconds. Original
[runtime misses](../recording-lookup-time-2026-11-06/README.md) remain unchanged.
