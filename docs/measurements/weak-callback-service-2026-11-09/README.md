# Queued callback service correctness

All four languages deliver the expected arrays and handle cancellation,
expiration and callback errors on native Linux ARM64/AMD64. The independent
receiver check rejects every missing-delivery variant. C's counters reject
actual omitted payload and weak-registration releases.

[The program and cases](../weak-callback-service.md) use 64/4,096 messages, each
containing 16 integers. For example, the 64-message error case delivers messages
0–32 before stopping: 33 payloads totaling 12,408 on both callback and receiver.
It disposes of messages 33–63 without calling them.

Source `afafdef5b7db33ba825ec786b05d5bc0eafadb21`, tag
`roadmap/weak-callback-service-2026-11-09`:

| Native job | Artifact | Checks |
|---|---|---|
| [ARM64 129293781908](https://github.com/e6qu/fun-with-pipes/actions/runs/42655781850/job/129293781908) | `13693355473` | 20 native builds/executions; four interpreter executions |
| [AMD64 129293782208](https://github.com/e6qu/fun-with-pipes/actions/runs/42655781850/job/129293782208) | `13692477006` | Same |

- Eight ordinary builds cover C/Rust/fwp O1/O2 and Swift `-Onone`/`-O`.
- Eight builds omit the actual enqueue. Callback counts stay correct but received
  counts/checksums become zero, and the ordinary oracle rejects them.
- Four C builds omit actual payload/registration releases and fail with status 79.
- Raw and optimized fwp interpretation each check ordinary and missing-delivery
  programs. Ordinary and missing-delivery executions report all eight cases.
- Six native extra-argument executions fail with status 2.

[Docs 42655786989](https://github.com/e6qu/fun-with-pipes/actions/runs/42655786989)
passes. Every downloaded result reproduces its raw command output. Complete
native logs contain the package installer's optional missing manual-page notice;
there are no compiler warnings or unexpected failures. [files.json](files.json)
hashes the retained reports, commands and full logs.

These first runs precede the fwp physical-allocation-ledger regression below.
Subsequent [peer allocation profiles](../weak-callback-profiles-2026-11-09/README.md)
and [complete-service timings](../weak-callback-time-2026-11-09/README.md) supply
those separate measurements.

The first ledger extension (`79c5c5318`, [run 42657535238](https://github.com/e6qu/fun-with-pipes/actions/runs/42657535238))
failed to compile its Rust test on both architectures: it referenced `serde_json`,
which is not a repository dependency. All three diagnostics per host have that
cause; neither job executed tests. Complete failed logs are retained here. The
repair uses the existing `fwp::json::Json` parser and checks exact integer fields
and duplicate keys, without adding a dependency.

Repair `cf6a0a12e`, tag `roadmap/weak-callback-ownership-json-2026-11-09`, passes:

| Native job | Artifact | Checks |
|---|---|---|
| [ARM64 129304147207](https://github.com/e6qu/fun-with-pipes/actions/runs/42658708144/job/129304147207) | `13693692270` | Both channel tests; eight service ledger builds and two actual omitted-weak faults |
| [AMD64 129304147132](https://github.com/e6qu/fun-with-pipes/actions/runs/42658708144/job/129304147132) | `13694425421` | Same |

The eight builds combine raw/optimized fwp, dynamic/static memory and O1/O2.
All produce the independent expected results and finish with zero registered
allocations and zero charged live bytes. Omitting actual weak release produces
status 205 in both control builds. Downloaded outputs/statuses reproduce every
case. [Docs](https://github.com/e6qu/fun-with-pipes/actions/runs/42658713471) also
passes. Complete failed/repaired logs and per-build outputs are retained here.
