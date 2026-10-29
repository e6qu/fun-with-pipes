# Next: verify mixed record-return repair in PR #227

**Next:** publish the complete repair batch and run the expanded `eager-captures`
focused suite on GCC ARM64/AMD64 and Clang ARM64. Preserve the earlier full run
to audit its remaining targets. Recheck the paired measurements after the C
generator repair; the earlier measurements remain evidence for their own sources.
Then require all nine production jobs, docs and both G2 hosts on the final head,
audit every log, and squash-merge with a one-line subject under 80 characters and
empty body. Keep #227 as the only active PR.

Worktree `/private/tmp/fwp-ad-captures`, branch `ad-eager-captures`. PR #226 is
merged by the user as `cdf881067dd87610badad56ed15cc5ecfbf66e17`; its tree matches
final head `02e4ee21`. All nine production jobs (`40876750803`), docs
(`40876747233`) and both G2 hosts (`40876750730`) pass and their full logs are
audited. No additional failure was found. Duplicate post-merge run `40899114681`
was cancelled after checking tree equality. [History](roadmap-history.md#derivative-allocation-and-accuracy-pr-226)
records counts and source IDs; the final G2 samples are now retained.

## Final-head checks and pending repair

Head `56528ffb` runs native `40901634818`, documentation `40901634737` and G2
`40901630875`. Both G2 jobs pass and their full logs and all 13,824 durations are
audited; identical-control maxima are 0.09% Linux and 0.37% Intel. Benchmark job
123545198571 passes with both tests/full log audited. ARM macOS ownership job
123545198764 also passes (363 tests/127 summaries, full log audited).

Regular ARM macOS job 123545198825 fails `secure_native` and
`secure_client_round_trip`: an authorized DELETE crashes instead of returning
204. All other completed target logs and the full job log were checked; no other
failure was found. Exact compiler `56528ffb` reproduces this with a small
`delete` function returning `RestReply[()]`: raw and optimized interpreters pass,
Clang O1 segfaults. Generated C returns a never-assigned boxed local.

Root cause: `expr_fields` can split a returned record into fields before a match,
but emitted that match as a boxed value when another arm failed or dynamically
returned a record. The repair emits each arm in the required field context.
Controls cover both authorization branches, mixed direct/dynamic records,
alias preservation and repeated exceptional cleanup at O1/O2. REST test cleanup
now preserves server exit/stderr diagnostics. These Rust changes are not yet
compiled or verified. Source, emitted C and logs remain under `/private/tmp`
with prefix `fwp-227-`; no disassembly was used to diagnose this failure.

Docs job 123545196798 fails its collection-count control: the new capture test
makes `inline_caf_ownership` seven tests, while its evidence table expected six.
Both the production table and synthetic fixture are repaired locally (53 total).
Eight controls pass, including rejection of the old six-test log. Audit every
remaining completed native target/diagnostic before pushing the repair batch.
The failed full docs log is `/private/tmp/fwp-227-docs-5652.log`; its earlier
intentional panic/timeout diagnostics belong to 20 passing runner controls.

N1 preparation is separate at `/private/tmp/fwp-kernel-baselines`, branch
`numerical-kernel-baselines`. Protocol `d0384af0`, corrected schedule `c17fe6e2`,
exact oracles `7a1d7e1c`, runner/workflow `f053da88`. Six local controls and docs
pass. Run `40906486080` has two passing ARM sessions and two AMD host rejections
before building; those logs/results still need independent audit. Preserve them
and check applicability after the compiler repair. No second PR.

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
At those measured sources, all frozen limits pass; updated solves take 13–72% less time, while the largest
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
