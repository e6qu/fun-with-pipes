# HTTP correctness with nested resource borrowing

**Linux ARM64 and AMD64 checks pass. Sustained-load and speed claims are separate.**
Source `cd661ff84b88736ceec83c75e0e2ecf7e6de551d`.
[Run 42793407188](https://github.com/e6qu/fun-with-pipes/actions/runs/42793407188).

The maintained API server passes on both hosts:

- Complete expected responses with two connections in a one-second driver check;
  no failed requests or setup errors.
- Physical memory/socket cleanup, cancellation and endpoint allocation observation.
- A broken allocation counter must be rejected.
- Slow clients, actual write pressure and partial-response cleanup.
- Driver controls for correct/wrong response bytes, incomplete replies and timeout.

All four selected native HTTP tests pass, as do the driver unit and fault controls.
Both complete job logs contain no compiler warning or failed test. The short
driver check is not a throughput comparison or a memory-growth measurement: it
has only one process-memory sample per host. [Sustained load](../../benchmarks.md#sustained-service-load)
uses the unchanged longer protocol separately.

| Host | Job | Full artifact |
|---|---|---|
| ARM64 | `129752322335` | `13753640881` |
| AMD64 | `129752322565` | `13753159743` |

[ARM reports](arm-reports.zip), [AMD reports](amd-reports.zip),
[ARM log](arm-job.log.gz), [AMD log](amd-job.log.gz), [run receipt](run.json) and
[artifact metadata](artifacts.json) retain source/toolchain identities and the
successful short trial. Only the small reports were downloaded; complete native
artifacts remain on GitHub and were not archive-hash-verified locally.

[Static selection](../nested-resource-counts-2026-11-10/README.md) finds 1,310
borrowed parameter sites in HTTP. This establishes that the common proof is used;
it does not establish an HTTP speedup. [The contract](../nested-resource-owners.md)
keeps those claims separate.
