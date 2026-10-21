# Session handoff

## Next action

Next: run the controlled [integer-counting comparison](measurements/integer-counting.md)
and focused scalar-text correctness suite on GitHub from branch
`investigate-native-counting-costs`, based on accepted merge `c98da7a5`.
The candidate counts decimal digits in groups of 16, 8, 4, 2 and 1; no speed
benefit is yet established. The earlier shared-loop candidate was 1–4% slower
than an unchanged rebuild on AMD64 and is not selected as an improvement. The experiment compares saved C/Rust/fwp, rebuilt unchanged fwp and
the candidate on every allowed CPU, preserving all samples and generated code.
Boundary tests now cover both sides of all signed/unsigned decimal transitions.
[Draft PR #182](https://github.com/e6qu/fun-with-pipes/pull/182) groups this work.
Preparation `995d3ecfd451700ec93e0fc1b326f8be0503bad5` has controlled measurement
run `39525618134`, focused scalar-text run `39525621027` and documentation run
`39525810747`. Measurement and documentation passed; focused checks are
still running. Both measurement logs are audited clean, as is documentation.
Saved artifacts: `/private/tmp/fwp-counting-costs`; full-log receipt:
`/private/tmp/fwp-counting-preparation-audit.json`. Production run `39525810735` is intentionally skipped for
the draft; it is not acceptance. Audit all completed jobs and retained samples
before marking the PR ready. Require all nine final-head production gates and
documentation before squash merge. Keep its subject one line, at most 80
characters, with an explicit empty body and no trailers or attribution.
The contributor guide's obsolete claim of no third-party Rust crates is also
corrected to match the existing Rustyline/ctrlc dependencies in Cargo.toml.
Local Python syntax passed in 0.12s and focused Rust formatting in 0.13s under
the unchanged guard. The first sandboxed guard invocation could not read `ps`;
its approved invocation passed. Native builds and execution remain on GitHub.

All seven roadmap areas remain open. Default native execution still includes
tracing GC; JIT is excluded. Retained resources, persistent subscriptions,
resource-owning tail frames and mutual recursion need further proofs.

## Accepted delivery

[PR #181](https://github.com/e6qu/fun-with-pipes/pull/181) passed all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39488574062)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/39488538767)
at `2038c926246cfcf8f741df7fdf0324fefc568b58`. Every complete log was audited;
none contains a failed step, test error or panic. Acceptance and merge receipt:
`/private/tmp/fwp-181-acceptance.json`.

Squash merge `c98da7a5b3d859fee69120cf3452dcdecc904979` has the same tree
`2fc33e8e7b238402acfc30efe3aee753ac4a018c` and one parent, accepted PR #180's
merge `fe491a97`. Its verified message is exactly:

`Borrow temporary channel names and preserve failure cleanup`

That is one line, 59 characters, with no body or trailers. Both remote and fetched
Git trees were checked. The guarded merge/verification took 9.31s; the local
base/tree check and branch switch took 0.13s. Post-merge documentation
`39503544342` already passed. Duplicate production `39503544541`
was cancelled after verifying the identical tree; all nine duplicate jobs are
confirmed cancelled. The accepted PR checks remain successful.

## What this batch establishes

- Temporary channel aliases borrow their continuing owner through bindings,
  matches and borrowing calculations inside record fields. Stored aliases,
  consuming/unknown calls, different-field evidence and resource scopes remain
  excluded from the proof.
- Changed error payload/type fields and task-scope child metadata remain valid
  across C `longjmp`, using volatile fields without new heap objects.
- Native tests cover return, failure and cancellation at O0/O2/O3, independent
  aliases, callback-context destruction, GC/reuse verification and deliberately
  broken cleanup. Another test fails after spawning 65 children and verifies
  interpreter/native output and complete cleanup over four repetitions.
- [Measured Linux counts](measurements/channel-local-borrows.md): closed-function
  retains 1→0 and shared-text retains 3→2 per message. Allocations and peak charge
  are unchanged; ARC finishes with zero charge and no collections. ARC frames
  shrink 424→344 / 416→352 bytes for closed sends and 552→456 / 512→432 for shared
  text (AMD64 / ARM64). No channel execution-time improvement is claimed.

## Evidence for the next measurement

Focused source `62ed104504b9e9a032434223120785e3cc37a47f`, tag
`roadmap/revision-record-borrows-62ed1045`, passes 217 checks per Linux GCC host
in run `39469883481`. Artifacts: `/private/tmp/fwp-record-alias-costs`;
receipt: `/private/tmp/fwp-record-alias-audit.json`. All 180 channel profiles,
20 ordinary binaries and seven C/Rust/fwp comparisons are audited.

The final-head production benchmark is saved in `/private/tmp/fwp-181-benchmarks`;
its audited report is `/private/tmp/fwp-181-benchmark-report.json`. All 21
C/Rust/fwp executables match the focused source byte for byte, as do the seven
generated C files. Sources, samples and medians pass. On EPYC 7763, decimal-counting
C/Rust/fwp medians are 13.022/14.809/14.852 ms; fwp samples span 13.703–22.504 ms.
Some saved focused Rust executables are now `*.codex-archive.gz`; their decoded
bytes were compared explicitly without restoring files. Do not delete current
evidence or assume archived paths are still ordinary executables.

[Saved-binary repeats](measurements/local-borrows-repeat-2026-10-20.json) use
measurement source `373aa1902c7329be58c15fadbd782a5ec79c97c0`, tagged
`roadmap/revision-borrow-repeat-373aa190`, run `39468533196`, and binaries from
`b15488ad` / run `39465380125`. Both hosts' complete logs and artifacts pass:
24 balanced timing rounds, two warmups, three separate RSS/count samples,
source/binary hashes and an injected-allocation control. On EPYC 7763, fwp is
53.9% above C in median elapsed time and 55.3% above C in child CPU time; the
spread therefore cannot be explained by descheduling alone. Neoverse-N2 gaps
are 3.7% elapsed and 3.8% CPU. Artifacts: `/private/tmp/fwp-alias-repeat-memory`;
receipt: `/private/tmp/fwp-alias-repeat-audit.json`. The cause remains unresolved.

## Local checks and resources

Use `python3 scripts/local-guard.py` for every local check: 64 GiB free disk,
target below 2 GiB, sampled aggregate RSS below 1 GiB and 180 seconds. Full
builds, suites, native compilation and benchmarks run on GitHub. Root target is
4 KiB. Guarded audits paused whenever the reserve failed and resumed only after
recovery; no limits were raised and no unrelated process was stopped.

The user's cleanup request reclaimed 6.553 GiB of old generated downloads only
after verifying their GitHub artifacts were available. Sources, reports, logs
and current evidence were preserved. Recovery manifests are under `/private/tmp`:
`fwp-disk-cleanup-2026-10-20.json`, `fwp-disk-cleanup-second-2026-10-20.json`,
and `fwp-disk-cleanup-extra-generated-2026-10-20.json`.

Recent guarded checks: final log audit 4.63s; final-head benchmark audit 0.35s;
comparison of all 21 executables, including compressed Rust artifacts, 0.14s.
A first generated-C comparison used a pre-cleanup source; correcting its source
resolved that audit-only mismatch. Historical checks are in the accepted receipt
and [delivery evidence](roadmap-history.md#temporary-channel-borrows-and-failure-cleanup-pr-181).
The acceptance updates pass `python3 scripts/local-guard.py python3
scripts/check-roadmap.py` in 2.67s: 72 link sets, 106 historical tag pairs,
seven roadmap steps and commit messages. The whitespace check also passed
in 0.13s under the unchanged guard with Python supervising Git; a direct Git
launch had hit an OS process-group signal permission error.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing; prove retained ownership and cleanup. |
| 2 | In progress | Eliminate avoidable functional allocations and count traffic. |
| 3 | In progress | Resolve measured machine-code and performance gaps. |
| 4 | In progress | Improve differentiation time, memory and precision. |
| 5 | In progress | Validate numerical kernels and ahead-of-time GPU policy. |
| 6 | In progress | Establish equivalent-work comparisons and budgets. |
| 7 | In progress | Validate larger programs and bounded live memory. |
