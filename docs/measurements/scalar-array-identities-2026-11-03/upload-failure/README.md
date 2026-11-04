# Intel macOS artifact upload failure

[Job 126186525953](https://github.com/e6qu/fun-with-pipes/actions/runs/41713252299/job/126186525953)
tested `8bf9c65bc247bbd94903d0a31fb0823d1e335391`. The full golden corpus, all
126 ownership targets, executable inspection and archive verification passed.
The final archive, manifest and crash-report uploads each failed DNS lookup:
`Failed to CreateArtifact: Unable to make request: ENOTFOUND`.

The individual target logs had already uploaded successfully. They and the full
job log are retained here with source/job/artifact identities and hashes in
`diagnosis.json`. This is an upload failure, not a failing native test. No source
change was justified by it.

After the containing workflow finished, only this job was retried on the same
commit. Attempt 2, job `126246098084`, passes the corpus, all 126 targets, native
inspection, archive verification and uploads. Its full/target logs are audited
in [the final gate records](../platforms/final-gates.json). GitHub retained two
archives with the same name; the audit selects artifact `13281382483`, whose ID
is printed in the passing job's upload log. The failed attempt remains here.
