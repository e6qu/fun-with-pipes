# Tape layout: compiler time and memory

All fourteen workload comparisons pass the frozen 5% time/memory and 2%
identical-copy limits. The [complete archive audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42369871217)
verified 336 scheduled commands and six untimed checks on each architecture.
[The results](../tape-record-results.md#compiler-cost) explain the workloads,
settings and observed ranges.

Both measured versions use source `621653b6394f49dc229a2956b6b61476c82c9aac`;
only the tape section differs. The compiler emits C; this measures compilation,
not execution of that C. ARM64 uses Neoverse-N2; AMD64 uses EPYC 9V74.

For each architecture, the files retain:

- `*-report.json.gz`: every sample, time/RSS summary and generated-source hash.
- `*-records.zip` and `*-retained-files.json`: 1,081 observation files and hashes.
- `*-audit.json`, `*-job.log.gz`, `*-reference.json`: job outcome, full log and reference identity.
- `*-host.zip` and `*-host-artifact.json`: qualified CPU/compiler evidence.

[Artifact metadata](artifact.json) identifies the complete audit archive.
Its SHA-256 and all 2,162 retained file hashes pass bounded local verification
(0.13 seconds). There are no compiler-cost acceptance failures. The separate
[runtime speed targets](../tape-record-results.md#runtime) remain unmet.
