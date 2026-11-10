# Executed extra lifetime holds in the queued service

Both native Linux jobs pass [run 42833961349](https://github.com/e6qu/fun-with-pipes/actions/runs/42833961349).
Observer source: `b4b11d4a9f545b03a6af4b03f37612fb15650c9c`. The input C comes from
[the verified census](../resource-field-census-2026-11-10/README.md), compiler source
`9b24e6965dd4c7cfb6e88163a34722e0b99ec901`.

The five plain field slots cause **1.35–1.70% of successful reference-count
increments** in the large service cases. This is a small direct contribution;
it does not establish a substantial speedup from removing these holds. Secondary
reuse benefits remain unmeasured. No production optimization is implemented here.

| 4,096-message case | Extra hold increments | All increments | Share |
|---|---:|---:|---:|
| Full delivery | 4,098 | 290,826 | 1.41% |
| Cancellation | 4,098 | 278,538 | 1.47% |
| Expired receiver | 4,098 | 241,670 | 1.70% |
| Handled callback error | 2,051 | 151,627 | 1.35% |

The 64-message cases execute 66 holds, except handled error, which executes 35.
Every result agrees across GCC O1/O2 and ARM64/AMD64.

## What was counted

The service constructs queued payloads, dispatches or cancels them, handles weak
receiver expiration/errors, drains delivered values and releases results. Each
execution handles one complete service call. Separate diagnostic builds count
actual successful increments, decrements and cleanup operations; they are not timed.

The observer matches exact original-lifetime context IDs and field slots. It does
not infer them from disassembly or confuse them with ordinary argument owners.
For full delivery, the selected releases perform 16,384 decrements. That includes
children freed when a record dies: those child releases still need to happen and
are **not** 16,384 removable operations. Removing a hold may move cleanup earlier.

## Verification and limits

Each host completes 34 executions and audits six actual native binaries:

- Baseline counters and field-attributed counters agree on all eight service cases
  at both optimization levels, including allocation requests and charged heap.
- Each call restores its original live bytes and cleanup stack; outputs match the
  independent service oracle.
- Adding one actual extra hold/release changes exactly one selected hold, retain,
  drop and decrement, with the corresponding total-count changes and no storage
  change. Both optimization levels detect it.
- The audit reconstructs every command result and checks saved binary hashes and
  native image headers. A changed summary is rejected even after its checksum is
  refreshed. Complete logs have no unexpected failures or compiler warnings.

Jobs: ARM64 `129891087787`, AMD64 `129891088346`. Artifacts: `13773605170` and
`13772393529`. Both runners verify the input archive's source, size, SHA-256 and
member CRCs. Small raw reports, command logs and control failures are retained
here; their downloaded members pass CRC checks. Full C, binaries and manifests
remain in GitHub artifacts and were audited on runners, not downloaded locally.

Reconstruct the retained raw counter data:

```sh
python3 scripts/local-guard.py python3 docs/measurements/resource-field-holds-2026-11-10/read.py
```

HTTP execution counts, concrete closure captures, ordinary time and compiler-cost
measurements remain open. [The investigation](../resource-field-costs.md) records
how these results guide the next proof; site counts alone do not select it.
