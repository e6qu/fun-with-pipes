# Tape operation records: production verification

PR #267 passes all nine production jobs, documentation and the complete
log/artifact audit. The user merged it at `621653b6394f49dc229a2956b6b61476c82c9aac`.
Its tree equals the tested head; its squash subject is one line, 65 characters,
with no body or trailers. The later [runtime report](../tape-record-results.md)
preserves all 32 missed speed targets; [#268](followup-268/README.md) delivered
the completed measurements and audits.

| Record | Identity |
|---|---|
| Tested source | `6ca44feb58ce155c42eae792beb480d59894ad7f` |
| Production run | [42319670701](https://github.com/e6qu/fun-with-pipes/actions/runs/42319670701), attempt 1 |
| Documentation job | `128240880945` |
| Complete audit | [42369305486](https://github.com/e6qu/fun-with-pipes/actions/runs/42369305486), job `128393918868` |
| Audit tool source | `621653b6394f49dc229a2956b6b61476c82c9aac` |
| Retained artifact | `13573122126`, 1,164,641 bytes |
| Archive SHA-256 | `9dc097fc7abda0bf07cd53e598300edad0a20f790c756704d4da31461398460c` |

[The archive](production-audit.zip) contains all ten job logs, their job/audit
records, eight native target-log archives and Windows probe logs. Its issue list
is empty. Local guarded verification checks the outer archive, source, job
success, all ten complete job-log hashes and 1,456 target/probe-log hashes.
[The verification index](verified.json) lists counts and job IDs by host.
[Artifact metadata](artifact.json), [audit job](audit-job.json) and its
[complete log](audit.log.gz) preserve the source of this evidence.

[Focused allocation and cleanup checks](../tape-record-checks-2026-11-06/README.md)
also pass. These establish correctness and artifact identity, not a speedup.
The [frozen measurement contract](../tape-operation-records.md) specifies the
separate runtime/compiler comparisons and original-executable checks.
