# Initial ownership-comparison production gates

All nine production jobs and documentation pass for
`7645384bb336acc728deebf24eae96280a45163f`. This is an **earlier PR #273 head**,
not acceptance of later returned-buffer or timing work.

- [Production 42578853160](https://github.com/e6qu/fun-with-pipes/actions/runs/42578853160): Linux ARM64/AMD64, regular and ownership macOS ARM64/AMD64, Windows ARM64/AMD64, and benchmarks.
- [Documentation 42578853071](https://github.com/e6qu/fun-with-pipes/actions/runs/42578853071): job `129032587978`.
- [Complete-log audit 42590693699](https://github.com/e6qu/fun-with-pipes/actions/runs/42590693699): job `129071304611`.

The audit checks 257 target logs per Linux host, 131 per regular macOS host,
126 per ownership macOS host, and 57 per Windows host. It also matches all 155
started Windows targets per host to successful retained records and checks the
benchmark/documentation main logs. No unexpected failure or compiler diagnostic
was found. OpenSSL already-installed notices and named scheduler panic controls
remain visible in their original logs.

The complete [audit archive](audit.zip) matches the digest and size in
[artifact identity](artifact.json); its full runner log is also retained.
Later changes still require their own exact-head production/documentation gates
and complete-log audit. Cancelled intermediate matrices are not passes.
