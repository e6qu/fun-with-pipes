# Intel macOS test-log upload failure

[Production run 41796687665](https://github.com/e6qu/fun-with-pipes/actions/runs/41796687665),
attempt 1, tested `19b91c059d223614124773ab6e356824514f69f1`.
Intel macOS job `126462341475` failed only at **Publish individual regular test logs**:

```text
Failed to CreateArtifact: Unable to make request: ENOTFOUND
```

The runner could not resolve the artifact-service endpoint. All 128 regular test
targets completed successfully, matching the ARM64 assignment. The full log has
132 passing test summaries; later native inspection and packaging steps passed.
The separate per-target archive was not published. This remains a failed gate.

The other eight production jobs and documentation passed their complete log
audits. Only this Intel job was retried, on the same source, as job
`126506098945`. Do not describe the retry as a compiler repair. Delivery still
requires its passing result and full log/target audit.

[Audit](audit.json), [job record](job.json), [full log](job.log.gz).
