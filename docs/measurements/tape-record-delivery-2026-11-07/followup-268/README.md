# PR #268: production verification

All nine production jobs and documentation pass for
`74d49922a0246fede5f579a455bdb971def5d5ab`. The user merge
`96efba2a9d743a3109ae417f05301ab50a63019c` has the same tree and a one-line
squash subject without a body or trailers.

- Production run: [42372334679](https://github.com/e6qu/fun-with-pipes/actions/runs/42372334679), attempt 1.
- Documentation job: `128398200623`.
- Complete audit: [42388428687](https://github.com/e6qu/fun-with-pipes/actions/runs/42388428687), job `128450677075`.
- Audit tool source: `96efba2a9d743a3109ae417f05301ab50a63019c`.

[The retained archive](production-audit.zip) has no audit issues. Its digest,
ten complete job-log hashes and 1,456 target/probe-log hashes pass bounded local
verification (0.13 seconds). [Artifact metadata](artifact.json), the
[verification index](verified.json) and [full audit log](audit.log.gz) identify
every input. Runtime measurement acceptance remains separate.
