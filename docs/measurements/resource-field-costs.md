# Keep only necessary fields in resource-lifetime records

**Both native compiler and service-operation censuses pass.**
No production optimization is implemented yet. Baseline: PR #276's verified
compiler tree, merged as `b2bbd0389d227ea097ea1239d8d02ec6346f4be7`.
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
4. **Prove lifetimes and measure the result.** Select only separately represented
   fields. Keep unknown closures and opaque containers. Preserve ordinary owners,
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

A standalone field-only change is not selected. Before freezing a production
change, count HTTP execution and attribute callable-field holds and whole-frame
setup in the same saved programs. A possible combined proof would need actual
closure constructor origins/captures, not arrow input/output types. Keep nullary
constructors, unknown captures and unproved branch/loop boundaries conservative.
