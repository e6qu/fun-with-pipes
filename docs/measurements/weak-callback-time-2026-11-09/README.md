# Complete callback service: time and memory

**fwp remains substantially slower on this service.** Delivering 4,096 messages
with 16-integer payloads takes 6.47 ms on ARM64 and 7.78–7.84 ms on AMD64.
That is 20.22–20.23× / 18.65–18.79× C's time, respectively, and
5.12× / 6.64–6.70× Swift's time. All copy-noise controls qualify in both sessions.
This establishes a representative optimization target; it does not establish
that weak-reference counting alone causes the gap.

## What the comparison includes

Each call builds a pending queue, dispatches messages, checks delivery or handles
a cancellation/expiration/error, and releases all service-owned data. C uses
explicit owners; Rust uses `Rc`/`Weak`, vectors and `RefCell`; Swift uses weak
references and arrays; fwp uses channels, weak channel references, arrays and a
pending list. The same payloads and observable results do not imply identical
queue layouts or synchronization work. fwp's ordinary owning entry and result
record are included. ARC-operation counts remain unmeasured.

- **Service time:** construction, dispatch and complete cleanup. No profiling or
  allocation counters run in these builds.
- **Process time:** adds launch, initialization, result checks, output and exit.
- **Peak RSS:** separately observed resident process pages, including runtime and
  libraries. This is not the sum of live service allocation requests.

The [frozen protocol](../weak-callback-time.md) specifies eight cases, a C-only
pilot, two sessions, balanced ordering, 16 measured rounds and identical executable
copies. No sample was rerun. [All raw samples and derived tables](summary.json)
retain service/process results, copy ratios, RSS and compile costs.

## Timing results

Cells show `fwp service median / peer service median`, spanning the two sessions.
For example, **5.12× means about 412% more time** for this service. Every comparison
passes its 5 ms minimum and 2% identical-copy limit in both sessions.
“Cancelled” cancels every fourth message; “expired” drops the target before
dispatch; “handled error” raises an error after the middle payload is delivered.

| Host | Messages / case | fwp / C | fwp / Rust | fwp / Swift |
|---|---|---|---|---|
| AMD64 | 64 / delivered | 39.71–39.73× | 34.69–34.76× | 8.47–8.48× |
| AMD64 | 64 / cancelled | 37.86–37.99× | 33.74–33.85× | 8.27–8.28× |
| AMD64 | 64 / expired | 42.86–42.93× | 40.68–40.78× | 8.98–8.99× |
| AMD64 | 64 / handled error | 25.50–25.75× | 23.26–23.34× | 5.97–5.99× |
| AMD64 | 4,096 / delivered | 18.65–18.79× | 15.54–15.66× | 6.64–6.70× |
| AMD64 | 4,096 / cancelled | 18.75–19.26× | 17.86–18.38× | 6.75–6.95× |
| AMD64 | 4,096 / expired | 16.23–16.33× | 16.00–16.01× | 6.33–6.34× |
| AMD64 | 4,096 / handled error | 16.40–16.51× | 15.90–15.97× | 5.28–5.30× |
| ARM64 | 64 / delivered | 35.60–35.60× | 31.53–31.53× | 5.96–6.03× |
| ARM64 | 64 / cancelled | 33.73–33.75× | 30.79–30.83× | 5.83–5.84× |
| ARM64 | 64 / expired | 37.77–37.78× | 37.46–37.47× | 6.88–6.88× |
| ARM64 | 64 / handled error | 22.52–22.53× | 21.32–21.33× | 4.24–4.25× |
| ARM64 | 4,096 / delivered | 20.22–20.23× | 17.21–17.28× | 5.12–5.12× |
| ARM64 | 4,096 / cancelled | 20.32–20.35× | 19.27–19.35× | 5.22–5.26× |
| ARM64 | 4,096 / expired | 18.81–18.95× | 18.94–18.95× | 5.60–5.61× |
| ARM64 | 4,096 / handled error | 16.00–16.02× | 15.87–15.89× | 3.91–3.92× |

For full delivery at 4,096 messages, complete-process ratios are 19.98–20.01× C,
17.01–17.08× Rust and 5.07× Swift on ARM64; 18.48–18.60× C, 15.39–15.50× Rust and
6.55–6.61× Swift on AMD64. Startup therefore does not explain the large gap.

## Memory and build costs

Six ordinary peak-RSS observations per implementation (three per session),
4,096-message full delivery; ranges are **KiB**, not requested allocation bytes:

| Host | C | Rust | Swift | fwp |
|---|---|---|---|---|
| ARM64 | 1,624–1,696 | 2,452–2,548 | 8,876–8,912 | 2,832–3,096 |
| AMD64 | 1,948–2,036 | 2,740–2,940 | 9,416–9,704 | 3,192–3,424 |

fwp uses less resident process memory than Swift here, but more than C/Rust.
[Separate service allocation profiles](../weak-callback-profiles-2026-11-09/README.md)
identify payload, metadata and release costs; fwp's
[physical allocation ledger](../weak-callback-service-2026-11-09/README.md) measures
its own allocator. Do not subtract these unlike scopes to estimate ARC cost.

These single build observations include the service and caller, without LTO.
fwp also includes source-to-C compilation. Peak compiler RSS is the maximum
across commands, not their sum; the common clock object's build is separate.

| Host / implementation | Build seconds | Peak compiler RSS (KiB) | Executable bytes |
|---|---|---|---|
| AMD64 / C | 0.13 | 27,396 | 16,744 |
| AMD64 / Rust | 0.31 | 215,656 | 4,557,536 |
| AMD64 / Swift | 1.41 | 150,784 | 54,656 |
| AMD64 / fwp | 2.90 | 100,796 | 168,544 |
| ARM64 / C | 0.10 | 27,940 | 71,312 |
| ARM64 / Rust | 0.35 | 187,340 | 4,627,688 |
| ARM64 / Swift | 1.20 | 145,268 | 93,040 |
| ARM64 / fwp | 2.61 | 110,988 | 157,576 |

Executable size includes the recorded toolchain's linking/symbol choices; it is
not the optimization priority or a measure of runtime memory. Retained frame
information does not establish maximum dynamic stack use.

## Verification and identities

Source `069e76ed8282f543a9e61d1415cad93425b35f41`, tag
`roadmap/weak-callback-time-repair-2026-11-09`,
[run 42675215554](https://github.com/e6qu/fun-with-pipes/actions/runs/42675215554).

| Host | Hardware | Job / artifact |
|---|---|---|
| AMD64 | AMD EPYC 7763 | `129354672051` / `13700674134` |
| ARM64 | Neoverse N2 | `129354672223` / `13700694287` |

GCC 13.3.0 and Rust 1.99.1 at O2, Swift 6.4.2 at O with whole-module optimization;
no cross-module LTO. Explicit generic architecture targets and complete commands
remain in the reports/artifacts. Both hosts pass 28 builds, 178 result/fault checks,
64 invalid arguments, two interpreter modes, both timing sessions, the raw-journal
audit and all six changed-evidence controls. [Documentation passes](https://github.com/e6qu/fun-with-pipes/actions/runs/42675219991).

Compressed timing reports retain all samples, pilots, copy qualifications and RSS;
controls and complete native logs are also retained under [file hashes](files.json).
Original artifacts retain full command journals, source, binaries and frame/section
records. The runner audits these before accepting results. The earlier failed
verification below collected no timing samples.

## First native checks

Source `0fa6d394b285e973e717d71889a5026a71100fd3`, tag
`roadmap/weak-callback-time-2026-11-09`, [run 42672736829](https://github.com/e6qu/fun-with-pipes/actions/runs/42672736829), attempt 2:

| Host | Job / artifact | Completed builds / result checks | Failures |
|---|---|---|---|
| AMD64 | `129350479470` / `13700060870` | 18 / 108 | Both generated fwp descriptors rejected |
| ARM64 | `129350479632` / `13698787984` | 14 / 74 | Same descriptors; four ordinary/missing-delivery Rust links |

All completed C/Swift checks pass. AMD64 Rust checks pass; ARM64's two
backward-clock Rust builds pass. Both fwp interpreter modes pass on each host.
The logs retain 48 AMD64 and 32 ARM64 invalid-argument checks. No other native
failure was found in the complete command journals.

Two harness defects explain the failures:

- The descriptor reader expected a shortened record declaration. Actual emitted
  declarations include field order and ownership functions. The reader now
  requires that real shape, including trivially owned `I64` fields; it still
  derives offsets from the field-name table and rejects incompatible types.
- Rust's raw clock-object link argument appeared after system libraries. On
  ARM64 the clock's stack-protection reference then lacked its required library.
  Linking the clock through Rust's native static-library mechanism fixes library
  ordering. Stack protection remains enabled; the clock code is unchanged.

The repaired reader accepts both retained generated sources. Focused local Rust
caller checks pass with the static clock archive. The repaired native checks now pass on both architectures. [Docs pass](https://github.com/e6qu/fun-with-pipes/actions/runs/42672743140),
attempt 2, job `129350483940`.

Attempt 1 of both workflows ended before creating jobs with GitHub internal
server errors. Retrying the exact source discarded no measurements. Complete
native logs include only the optional g++ manual-page notice outside the failures
above. [File identities](files.json) cover the compressed reports, command journals,
actual generated sources and complete logs. The [handoff](../../development-state.md)
owns current run status and remaining work.
