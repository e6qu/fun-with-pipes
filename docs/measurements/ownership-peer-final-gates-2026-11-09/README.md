# Final ownership-comparison delivery

[PR #273](https://github.com/e6qu/fun-with-pipes/pull/273) was squash-merged as
`8887114f6ad3be3cd42d37b976ec208e27e4a5a2`. Its tree matches verified source
`0f3c0b94a1afa5b1e2c9b12435a2905532b0d072`, retained by tag
`roadmap/ownership-peer-delivery-2026-11-09`.

All final gates pass:

| Gate | Exact-source run |
|---|---|
| Nine production jobs | [42689448177](https://github.com/e6qu/fun-with-pipes/actions/runs/42689448177), attempt 1 |
| Documentation | [42689448429](https://github.com/e6qu/fun-with-pipes/actions/runs/42689448429), job `129404997478` |
| Complete-log audit | [42704685230](https://github.com/e6qu/fun-with-pipes/actions/runs/42704685230), job `129458290946` |

Production covers native Linux, macOS and Windows on ARM64/AMD64, both macOS
ownership jobs, and C/Rust benchmarks. The audit verifies:

- 257 target logs per Linux host;
- 131 regular and 126 ownership target logs per macOS architecture;
- 57 primary target logs per Windows host, plus every retained Windows test log
  and all 155 started native targets per host matched to successful completions;
- benchmark/documentation main logs, exact source IDs and artifact digests.

There are no unresolved diagnostics. The [complete audit archive](audit.zip)
matches the size and SHA-256 in [artifact identity](artifact.json). It contains
all ten passing audit reports, main logs, target archives and source receipts.
The [audit runner log](audit-job.log.gz) is retained too. The squash commit
message was verified as one line, under 80 characters, with no body or trailers.

This completes milestone 4's delivery gates. It does not turn earlier missed or
noisy timing targets into successes. The [comparison guide](../ownership-peers.md)
keeps actual results and limits; the [roadmap](../../../PLAN.md) moves on to
application workflows, compiler costs and sustained service load.
