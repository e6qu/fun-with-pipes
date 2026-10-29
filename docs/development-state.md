# Next: deliver the verified eager-capture comparison

**Next:** complete all nine production jobs, documentation and both G2 hosts
on the published final head of this single active PR; audit all completed
logs, repair any failures together, then squash-merge with a one-line subject
under 80 characters and empty body. D2's selected budget is measured and accepted;
final platform delivery is still required. After merge, begin N1's four kernel
sizes and declare repeated-host budgets before any N2 optimization.

Worktree `/private/tmp/fwp-ad-captures`, branch `ad-eager-captures`. PR #226 is
merged by the user as `cdf881067dd87610badad56ed15cc5ecfbf66e17`; its tree matches
final head `02e4ee21`. All nine production jobs (`40876750803`), docs
(`40876747233`) and both G2 hosts (`40876750730`) pass and their full logs are
audited. No additional failure was found. Duplicate post-merge run `40899114681`
was cancelled after checking tree equality. [History](roadmap-history.md#derivative-allocation-and-accuracy-pr-226)
records counts and source IDs; the final G2 samples are now retained.

## Included work and evidence

The compiler binds computed arguments once, in their original order, for known
partial functions used once. Existing specialization removes temporary closures.
Unknown/saturated producers keep their bindings; observable captures reject the
whole transformation and discard prepared locals. Inlining limits and runtime
APIs are unchanged. [The experiment](measurements/eager-captures.md) explains this
with examples, the exact reference and measured remaining costs.

Preparation `8a495a72` fixes the comparison before implementation `89d0dfa1`.
Focused run `40871650124` passes 299 tests/18 summaries, lint and the interpreter
corpus on Linux ARM64/AMD64 and ARM macOS; all three full logs are audited.
Production compiler/runtime/library/tests remain identical after merging #226.

All four paired sessions are audited: `40876515001` at `4ffeb0d2` (ARM 1/2,
AMD 2) and `40878172336` at `8703104d` (AMD 1). Same measured code, scripts and
reference; the latter commit only selects the replacement session explicitly.
Original AMD 1 received EPYC 9V45 instead of 7763 and was rejected before timing;
its complete rejection remains. Accepted measurements include 368 binaries,
320 stack reports, every process observation/output and workspace-on/off cleanup.
All frozen limits pass; updated solves take 13–72% less time, while the largest
current-result case still takes 44–58 times handwritten C's time. Do not describe
that ratio as pure language overhead or relabel scalar-recording's failed speed
result. D3's finite accuracy/depth matrix is verified by #226.

The comparison archive and rejection controls retain actual per-session sources
and runners. Missing sessions, altered samples, relabeled source/run identities,
changed reference or measured-source hashes fail. The earlier four rejected
scalar-recording sessions still retain every timing failure. Workflow selection
requires an explicit session and rejects unsupported hosts instead of skipping
all checks. There is no default timing session.

## Local validation and resource state

No local Rust build or full suite was run. Every check uses
`python3 scripts/local-guard.py COMMAND...`, serially with fixed limits:

- `/private/tmp/fwp-audit-production-log.py` audits all eight final #226 native
  logs; benchmark/docs/G2 logs were already audited. All pass.
- `/private/tmp/fwp-audit-captures.py arm-1|arm-2|amd-1|amd-2` independently
  checks outputs, all rounds, binaries/stack, memory, reference and full logs;
  each session passes in under two seconds.
- `python3 scripts/test-descent-groups.py`: 11 tests pass, including the four
  accepted sessions, original rejected sessions and changed-evidence controls.
- `actionlint .github/workflows/numerics.yml .github/workflows/roadmap.yml` and
  `rustfmt --check src/opt.rs tests/inline_caf_ownership.rs` pass.
- `python3 scripts/check-roadmap.py`: 178 document link sets, 106 preparation
  pairs/tags, eight roadmap steps and commit messages pass. Prior guarded
  reference/budget controls also pass; their implementation is unchanged.

The guard previously refused below 64 GiB free. Thirteen obsolete worktrees were
removed, preserving branches, all evidence and both modified handoffs under
`/private/tmp/fwp-obsolete-checkout-handoffs`. This recovered about 4 GiB; audits
then resumed under unchanged limits. Active worktrees and the primary checkout's
untracked `docs/measurements/compiler-abort.md` were preserved.

No compiler-abort recurrence is known. Its original cause remains unexplained;
diagnose any recurrence from source/input, not allocator/disassembly speculation.
F64 conversion elimination is excluded: raw/native NaN payload differences do
not justify an all-engine bitwise identity.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain GC-free lifetime and cycle checks |
| 2 | Verified | Maintain A1–A6; sharing still uses ARC |
| 3 | Verified | Maintain F1–F3's stated call/recursion scope |
| 4 | Verified | Selected decimal cost delivered; loop gap remains recorded |
| 5 | In progress | D1/D3 verified; deliver D2's accepted eager-capture change |
| 6 | Pending | N1–N2 numerical kernels |
| 7 | In progress | Broader B1/B2 comparisons |
| 8 | Pending | V1–V2 application validation |
