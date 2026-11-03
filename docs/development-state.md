# Current work

**Next:** audit the completed ARM64 runtime observations with report run
`41654788718`, then finish AMD64 host qualification and measurements in
`41654861200`. Keep every measured miss and rejected host. Publish the follow-up
as the sole draft PR after rebasing onto PR #252's verified squash; run the final
platform matrix only after the measurement audit is complete.

## Checkout and sources

- Worktree/branch: `.worktrees/direct-array-callbacks` / `direct-array-callbacks`.
  Scratch: `.worktrees/gradient-work`. Leave the detached primary checkout's
  recovery edits alone.
- Contract `776e8d98`, tag `roadmap/direct-array-callbacks-protocol-2026-11-03`,
  precedes implementation `8537e7a9`. Repairs: `36bfee09`, `5e921fb8`.
- Frozen measurements: `e649da78c41dab8fa6f191d7670b1efba79811b0`, tag
  `roadmap/scalar-array-map-measurement-2026-11-03`. Implementation trees equal
  focused-tested `5e921fb8517d59cfa0ef452c2c2264ffa00be325`. Rebase the working
  branch, never the frozen tag. The reference disables only direct scalar
  array-map selection; both builds keep the gradient-array implementation.
- PR #252 merged as `3034a9d047c2bef44744c6ffc1807146570ced57`. Its tree equals
  tested `e2d55aa81a7830cf7379570944ed7f307c55f7af`; its 64-character single-line
  subject has no body/trailers. All nine production jobs `41635110882` and docs
  `41635092370` pass; all full/target logs are audited and
  [retained](measurements/gradient-array-storage-2026-11-03/platforms/final-gates.json).
  Duplicate same-tree main run `41652287872` was cancelled with no failed steps.

## Roadmap status

The [direct-call contract](measurements/direct-array-callbacks.md) selects known,
closed ordinary-scalar callbacks. The implementation uses existing array
accessors, caller-owner protection and partial-array cleanup. No layout, API or
syntax changes. The separate [storage review](measurements/remaining-gradient-storage.md)
records possible future work; it selects no further implementation.

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Keep the pre-implementation contract and limits fixed |
| 2 | Verified | Three hosts pass; 24 targets, 72 selections and 762 native images audited |
| 3 | In progress | Compiler limits pass; audit both completed ARM sessions and obtain two qualified AMD sessions |
| 4 | In progress | Publish the sole follow-up draft, then final nine production jobs plus docs and verified squash |

## Verification and repairs

[Native evidence](measurements/direct-array-callbacks-2026-11-03/README.md)
retains both failures and the complete passing run:

- `41638033527` at `8537e7a9`: all hosts failed compilation on an unescaped C
  brace in a Rust format string. Fixed the brace and early artifact creation;
  CI retains lint/build logs and runs native targets whenever compilation works.
- `41640932807` at `36bfee09`: 39 tests passed and one failed per host. The new
  inspection expected exported names in a main-only build. The repair requests
  exports separately, keeps ordinary main execution and saves C before assertions.
  All ten cleanup observations per host passed even in the failed attempt.
- `41646433358` at `5e921fb8`: GCC ARM64/AMD64 and Clang ARM64 pass 40 tests,
  24 selection checks, eight semantic executions and ten cleanup observations
  per host. Every full/target log, image identity and cross-host output is audited.

[Compiler costs](measurements/direct-array-analysis-2026-11-03/README.md) pass in
`41649281445`: all 480 commands and source/reference identities audited. Maximum
elapsed increase 0.688%, peak RSS increase 0.185%, identical-copy difference 1.288%.
This measures fwp-to-C compilation, not generated-program execution.

## Runtime observations

Original run `41649285227` completed both ARM64 sessions. Each misses five 5%
speed goals: both forms of 3/199 and 3/1999, plus 129/199 history. These are
completed observations, not retries to schedule. Raw audit run `41654788718`
reads saved artifacts without executing binaries. Other runtime/memory claims
remain provisional until that audit passes.

AMD64 has no measured session yet. Runs `41649285227`, `41650921950` and
`41651545947` rejected six hosts before building/timing: five EPYC 9V74 and one
9V45, against required EPYC 7763. All six qualification records and logs are
audited in `../gradient-work/direct-host-rejections/RUN`. The next pair is
`41654861200`, using the same frozen tag and focused prerequisite. Do not change
the frozen CPU requirement or treat host rejection as a timing outcome.

## Local checks and helpers

Use `python3 scripts/local-guard.py` serially. Full builds, suites, benchmarks and
large regeneration run on GitHub. Keep 64 GiB free, target data below 2 GiB,
sampled RSS below 1 GiB and the 180-second deadline. Last free space about 86 GiB.
No local compiler build is running.

Passing focused checks: reference controls 3, budgets 17, compiler-analysis 7,
patch auditing 15, comparison groups 12, retention 3; predecessor reference
reconstruction 6 (0.60s). Formatting, workflow lint and docs pass. The standalone
production initializer-format check passes (0.84s); this is not native verification.

Scratch helpers run under the guard:

- `collect-direct.py --run 41646433358 --source 5e921fb8517d59cfa0ef452c2c2264ffa00be325 --output ../gradient-work/direct-export-repaired`
- `audit-direct-analysis.py x86_64` or `aarch64`: completed in 42.39s/45.14s;
  `retain-direct-analysis.py`: completed in 0.14s.
- `audit-direct-rejected-hosts.py --run RUN`: only early AMD host rejections.
- `collect-252.py`: all ten audits complete, final Linux collection 5.42s.
  `retain-gradient-delivery.py --merge 3034a9d047c2bef44744c6ffc1807146570ced57`
  already verified and retained the merge/gates (0.13s); do not repeat into its
  nonempty output directory.
