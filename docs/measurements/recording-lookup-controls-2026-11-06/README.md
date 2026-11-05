# Measurement controls

[Run 42123056112](https://github.com/e6qu/fun-with-pipes/actions/runs/42123056112),
job `127580112855`, passes all eleven control suites: 97 tests. They check reference
isolation, recording counters, allocation/stack/time limits and retained evidence,
including deliberately broken inputs that the audit must reject.

The [receipt](audit.json) records the source and scripts-tree identity, test counts
and full-log digest. [Job metadata](job.json) and the [complete log](job.log.gz)
are retained. Every diagnostic was reviewed; none remain. These are checks of the
measurement tools, not runtime speed or platform-support results.

Follow the [lookup protocol](../recording-lookups.md) and
[current handoff](../../development-state.md) for the remaining native checks
and measurements.
