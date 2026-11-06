# Capacity comparison measurement controls

[Run 42173881295](https://github.com/e6qu/fun-with-pipes/actions/runs/42173881295),
job `127747768088`, passes at source
`4e8fbfd9411b097d54e7ea89202416f53f75a8b7`: 15 suites, 114 tests.
The complete log has no unexpected diagnostic. The downloaded archive digest,
every retained suite result and source identity were verified locally.

These controls check reference reconstruction, source inventories, corrupted
artifacts, failed limits, work/memory budgets and evidence retention. They do not
establish native correctness or a performance improvement. The
[corrected native checks](../recording-capacity-checks-2026-11-06/README.md) pass.
After the patch-reader repair, [15 suites / 116 tests](../recording-capacity-repair-controls-2026-11-06/README.md)
pass, including the full historical archive checks.

`controls.zip` contains every suite log; [counts](counts.json),
[artifact identity](artifact.json), [job metadata](job.json) and the
[complete job log](job.log.gz) retain the verification inputs.
