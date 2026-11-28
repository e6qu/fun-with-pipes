# Remove unnecessary resource-lifetime holds

**Native focused checks, service and HTTP attribution pass.** The selected proof
meets every service timing and repaired compiler-cost limit; four original
process-RSS limits remain open. [Results and diagnosis](resource-value-costs-2026-11-27/README.md)
preserve those misses. Final delivery gates are separate. The original field investigation's
baseline is PR #276's verified compiler tree,
`b2bbd0389d227ea097ea1239d8d02ec6346f4be7`; the selected extension uses #278 below.
[Its original timing and RSS limits remain open](nested-resource-time-2026-11-10/README.md).

## The extra work to measure

An ordinary owner keeps a value alive until its last use. A resource-lifetime
record also preserves when a file closes or a weak channel expires. Today, a
mixed record can make that second record retain plain data too:

```text
input: (callback, array of numbers)
ordinary owners: callback + array       ← required while the call uses them
lifetime holds: callback + array        ← does the array need this extra hold?
```

A callback can capture a channel; keep its lifetime hold unless its actual captures
prove otherwise. A number array cannot close a file or own a channel. Its ordinary
owner must remain even if the extra lifetime hold is unnecessary.

Current service C contains this pattern in worker `w40`, original holder 78:
its second field holds a plain state/payload record, while its first is a closure.
This source observation does not establish how often it runs or a speedup.

## Ordered work and completion checks

1. **Identify the holders.** A separate diagnostic compiler reports context IDs,
   field types and the existing resource classification. Require byte-identical C
   against ordinary compilation on four applications, the exported service and
   twelve growing inputs. Match every reported holder to its original-lifetime
   cleanup marker; reject an ordinary cleanup context mislabeled as one. Native
   Linux ARM64/AMD64 must agree. Variants and opaque containers remain excluded.
2. **Count executed work.** In separate untimed native builds, count selected hold
   attempts, successful reference-count increments and releases. Preserve total
   counts, allocation requests, live bytes and physical cleanup. Run all service
   modes at 64/4,096 messages at GCC O1/O2, plus HTTP requests and shutdown. An actual
   added hold/release must change the intended counters. Retain source patches,
   C/binaries, commands, raw results and failures. Static counts are not timings.
3. **Select and freeze the change.** Use those counts to decide whether narrowing
   fields removes enough work to pursue. Freeze ordinary time, memory and compiler
   cost targets before changing production code. If this cost is negligible,
   select another measured cost; do not ship an unmeasured micro-optimization.
4. **Prove lifetimes and measure the result.** Field-only selections require
   separately represented fields; value selections require surviving enclosing
   owners and actual constructor/capture evidence. Keep unknown closures and
   opaque containers. Preserve ordinary owners,
   returned aliases, first-trap order, weak expiry, cancellation and failure cleanup.
   Test values with no spare owner, stack aggregates, branches, escaping fields,
   initialization failures and reuse. Empty runtime frames must still restore
   compiler scope state. Compare ordinary builds separately from all observers.
5. **Deliver together.** Bundle the proven change, controls, measurements and docs
   in one normal PR. Run focused checks during development, then one complete final
   production/docs/log-audit gate. Preserve earlier missed/noisy acceptance results.

The initial diagnostic uses `resource_field_census.py` and the explicit
`--kind plain-fields` mode of `inspect-nested-resource-analysis.py`. Its census
reports emitted field slots; dynamic operation counts are a separate next step.
There is no new source syntax or runtime setting.

[Initial census](resource-field-census-2026-11-10/README.md): both hosts identify
five plain service slots and twenty HTTP slots, with unchanged emitted C. These
site counts do not justify a speedup. [Executed service counts](resource-field-holds-2026-11-10/README.md)
find only 1.35–1.70% of successful retains in these fields. Child decrements are
not all removable operations; secondary reuse benefits are unmeasured.

A standalone field-only change is not selected. The next section records the
executed HTTP/callable/frame attribution and freezes the selected scope before
production changes. Arrow types alone still do not establish captures.

## Selected extension: carry enclosing lifetime protection through values

Frozen on 2026-11-27, before implementation, against ordinary reference
`5a9047178b88c801f37a279dfeca55b0e190bf07` (#278). The source-cost census uses the
unchanged saved service/HTTP C from `9b24e6965dd4c7cfb6e88163a34722e0b99ec901`.
Before comparing performance, require the freshly built reference to reproduce
those two saved C files; any mismatch needs explanation, not silent substitution.

[Native run 46063375647](https://github.com/e6qu/fun-with-pipes/actions/runs/46063375647)
at preparation `041db877` passes ARM64 job `140722747603` and AMD64 job
`140722747215`. Each host reconstructs 44 executions and 12 native binaries:
all eight service cases, fixed 64/256-request HTTP sessions, GCC O1/O2, separate
baseline/attribution builds and actual extra-owner/release controls. Every HTTP
reply is checked; graceful shutdown restores initial charged live bytes and
leaves no active task or cleanup frame. Altered service and HTTP summaries are
rejected even after their checksums are refreshed. These are untimed counts,
not throughput measurements or TLS coverage.

At O2, full delivery of 4,096 messages performs 606,259 cleanup registrations,
of which 131,082 belong to original lifetime frames (21.6%). Those frames cause
77,832 of 290,826 successful retains (26.8%). Direct callable fields hold
function 30 8,193 times with two captures, and function 51 8,192 times with one
capture. Saved C identifies function 30's two integer captures and function 51's
captured callback; the latter must remain protected unless its actual value is
proved safe. A callback's arrow type does not establish this.

The 256-request HTTP process performs 764,066 cleanup registrations, including
186,012 original-frame registrations (24.3%). Original fields cause 88,910 of
285,113 successful retains (31.2%); plain fields contribute only 257 (0.09%),
and direct callable fields contribute 17,416 (6.1%). Of 48,161 direct callable
hold attempts, 24,838 hold capture-free closures. A hold attempt on static storage
need not increment a count. These totals include startup, requests and shutdown;
typed release counts include child destruction and are not all removable work.

The selected proof extends the existing native `resource_borrows` scan. Track
which active original frame protects a value's observable resources, not just
whether one currently does. Preserve that evidence through immutable record
construction, exact aliases/projections, and a known unsaturated function's
actual supplied captures. Returned values may carry protection only from frames
that remain active after the expression exits. Merge branch results only when
every path has surviving protection. Plain data needs no observable lifetime
owner. Keep nullary/saturated factories, unknown applications, opaque containers,
updated records, rebound locals and loop/tail-rebinding bodies conservative.
Remove only proved inner parameter anchors; preserve ordinary owners, binding
anchors, input evaluation/trap order, interpreter/debugger metadata and ticks.

### Correctness and measurement acceptance

- Compare raw interpretation, optimized interpretation and native O1/O2 on
  service delivery/cancellation/expiry/error, files and weak channels. Test
  stack/heap records, shared inputs, returned aliases, branch joins, unknown
  factories/captures, failed initialization and reused local/loop boundaries.
  A deliberately omitted necessary owner must change the lifetime oracle.
- Require at least 10% fewer cleanup registrations and 5% fewer successful
  retains in every 4,096-message service mode against #278. Preserve allocation
  requests and peak charged bytes; every call must fully release its storage.
  Verify selected construction/return paths in HTTP and its existing physical
  cleanup, cancellation, slow-client and sustained-load controls. No HTTP speedup
  is inferred from the service or operation census.
- Ordinary complete service time must fall at least 5% for each large mode in
  two independent sessions on each native Linux architecture; small cases may
  grow by at most 2%. Use existing balanced 16-round schedules, 50 ms pilots,
  5 ms minimum work and 2% identical-copy qualification. Keep observers separate.
  Record contemporary C/Rust/Swift peers with their representation differences.
- Ordinary process peak RSS may grow at most 5%; record KiB, stack frames,
  executable bytes and managed storage separately. Compiler emit-C time may
  grow at most 2% and RSS at most 5% on four applications and twelve growth inputs,
  in two sessions with existing copy controls. Keep proof traversal counts bounded
  by the actual emission tree and cache per-type classification within that scan.
- Preserve all failed/noisy outcomes. Do not rerun unchanged timings to pass.
  Existing #270–#276 acceptance gaps remain separate. Run the nine final native
  production jobs, documentation and complete-log audit on the final PR head.

The first preparation run `46062709945` failed before useful attribution: its
service report hook was not restricted to the exported bridge, and its direct
HTTP link omitted OpenSSL libraries. The corrected preparation fixes both and
adds independent raw reconstruction; the failed run remains diagnostic evidence.
