# Intel macOS artifact upload failure

[Job 126186525953](https://github.com/e6qu/fun-with-pipes/actions/runs/41713252299/job/126186525953)
tested `8bf9c65bc247bbd94903d0a31fb0823d1e335391`. The full golden corpus, all
126 ownership targets, executable inspection and archive verification passed.
The final archive, manifest and crash-report uploads each failed DNS lookup:
`Failed to CreateArtifact: Unable to make request: ENOTFOUND`.

The individual target logs had already uploaded successfully. They and the full
job log are retained here with source/job/artifact identities and hashes in
`diagnosis.json`. This is an upload failure, not a failing native test. No source
change is justified by it. The job still must pass before merge.

GitHub rejected an immediate job retry with HTTP 403 because the containing
workflow was still running. Retry only this job on the unchanged commit after
the other jobs finish. Keep this failed attempt and audit the retry's complete
logs; the [handoff](../../../development-state.md) records the current state.
