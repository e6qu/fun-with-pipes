# Initial capacity checks: formatting repair

[Run 42173870504](https://github.com/e6qu/fun-with-pipes/actions/runs/42173870504)
at `4e8fbfd9411b097d54e7ea89202416f53f75a8b7` failed on all three hosts because
one Rust test statement needed line wrapping. Clippy and all 25 native targets
per host passed. This is a failed run, not a passing-source correctness gate.

The [complete audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42176157617)
retains those failures and checks every target log, compiler diagnostic, image
header and observation. Each host supplies 864 native images and 880 probe
observations. Its only findings are the three job failures and their matching
format-step exit diagnostics. The full log/record hashes and each format diff
were checked locally; no native test failure was hidden behind formatting.

The repair wraps `early_shortcut` in `tests/autodiff_capacity_bounds.rs`;
the focused local format check passes. The corrected source must pass a new
three-host run before measurements. No production algorithm change is required
by this finding. The initial source remains reachable through
`evidence/recording-capacity-initial-2026-11-06` after rebasing onto PR #263.

[Summary](summary.json), [artifact](artifact.json), `audit.zip`,
[audit job](audit-job.json) and [complete audit log](audit-job.log.gz) preserve
all results and failures.
