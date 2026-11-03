# Documentation checkout and evidence-check timeouts

Both cancelled jobs exhausted a five-minute **whole-job** budget. Completed
checks passed; later checks were skipped, so neither run is a passing gate.

| Run / source | Observed cost | Outcome and complete evidence |
|---|---|---|
| [41681546983](https://github.com/e6qu/fun-with-pipes/actions/runs/41681546983) / `602f449c` | Initial full-history fetch took 4m14s | Cancelled during buffer controls. [Job](job.json), [log](job.log.gz) |
| [41684788290](https://github.com/e6qu/fun-with-pipes/actions/runs/41684788290) / `c88139ab` | `blob:none` checkout took 46s; review heads took 13s. Reading historical source later added individual network fetches. | Cancelled after the packed-record report printed success. [Job](filtered-current-job.json), [log](filtered-current-job.log.gz) |

The packed-record check grew from about two seconds in the
[previous passing job](previous-job.json) to 35 seconds. Its source-hash audit
reads historical files through separate `git show` calls; a blobless clone must
fetch missing contents. Other historical-source controls also took longer.
The native-runner tests' deliberate child failures are expected controls, not
unreported test failures.

[The workflow](../../../../.github/workflows/roadmap.yml) now uses
[`blob:limit=1m`](https://git-scm.com/docs/git-rev-list)
for checkout and review heads. This fetches historical files smaller than 1 MiB
together, covering the checked compiler/runtime/tooling sources; large old
evidence blobs remain available on demand. Full ancestry, tags and the current
tree remain available. The largest source file in the packed-record reference
is 527,354 bytes.

The CI job gets ten minutes for setup and validation: the observed 4m14s fetch
plus normal three-to-four-minute controls already exceed five minutes. No test,
source-hash check or performance acceptance limit is removed. Local guard limits
are unchanged. The identity-map reference control is also included in this gate.
[Run 41689453129](https://github.com/e6qu/fun-with-pipes/actions/runs/41689453129)
at `24f86ddf` passes all 62 steps. The packed-record check returned to three
seconds. Checkout itself took 5m27s and review-head fetching 24s; this is not a
claim of uniformly faster network setup. The larger whole-job budget allowed
all checks to finish. [Job](verified-job.json), [full log](verified-job.log.gz)
and [audit with step timings](verified-audit.json) retain the successful result.
The full-log audit finds only the three expected child-failure diagnostics.
