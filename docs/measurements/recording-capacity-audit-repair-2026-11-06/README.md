# Reference patch audit repair

[Compiler audit 42181226529](https://github.com/e6qu/fun-with-pipes/actions/runs/42181226529)
failed for both architectures at the reference-patch check. The two producer
jobs in run `42179974129` passed. Their complete logs contain no unexpected
diagnostics. This is an audit defect; it does not establish numerical acceptance.

The checker compared Git's patch text with Python difflib's output. Both describe
the exact same source change, but align repeated closing braces differently:
Git's second hunk starts at line 278; difflib's starts at 276. Requiring identical
hunk placement rejected the correctly reconstructed runtime.

The repair checks the named file, hunk positions/counts and every context/deleted
line, reconstructs the output, then requires exact equality with the independently
derived reference source. Wrong paths, altered source, missing/extra lines,
overlapping hunks and malformed newline markers remain rejected. The complete
reference test now uses Git's actual diff, matching the producer.

The saved compiler and runtime results will be audited with the repaired checker;
no compiler or runtime timing is repeated. The source/runtime transformation is
unchanged. The [contract](../recording-capacity.md) and frozen limits still apply.

[Artifact identity](artifact.json), [job](job.json), [full log](job.log.gz) and
`failed-audit.zip` retain the original failed audit. Its digest is verified.
