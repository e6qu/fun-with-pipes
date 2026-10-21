# Session handoff

## Next action

Next: publish the Windows observer repair and run the full focused matrix again.
Keep auditing the preceding `39675022652` run at `82970103` to its end. The two
Windows ownership batches fail on the same header-order error; ARM64's complete
log confirms its inspector fails only because the four buffer probes were never
built. Linux/macOS batches and both WASM jobs have no failure so far; Intel macOS
is still running. Preserve the failed-source receipt. Keep this group separate
until PR #190 merges; only one delivery PR. All seven plan areas remain open.

Worktree `/private/tmp/fwp-task-await-fields`, branch `task-await-fields`.
The publication receipt is `/private/tmp/fwp-task-await-full-publication.json`;
it records the exact source, immutable tag and run. Auditor:
`/private/tmp/fwp-audit-task-await-full.py`. Final production acceptance
will still require nine jobs and documentation after the preceding PR merges.

## Changes in this group

- Immediate `task.await | match` passes tag/payload fields directly, removing a
  temporary Some box. Escaping options keep their representation; shared results
  keep required owners. Cancellation and retain failures preserve existing order.
- Partial applications created inside/outside State handlers keep separate saved
  argument summaries. An escaped function is still checked where it is called.
  This repairs two individually valid folds being rejected when combined.
- `rev.jacobian` counts outputs in its own tape scope, then computes rows in their
  existing scopes. Repeated Jacobians with deliberately unused tapes must release
  them before each print. The observer must run for all 27 printed checks.
- The ARC example suite rejects unexpected exclusions instead of silently counting
  them. Six explicitly excluded programs remain: GPU operations, foreign pointers, and an
  intentionally invalid cross-task derivative program. These are not tested support.
- The C-interop example now frees raw sorting/formatting buffers after copying its
  results, including buffers allocated by nested qsort callbacks. A separate
  physical-buffer counter detects omitted frees. Raw pointers remain outside
  checked ARC; this fixes the existing example without relaxing that policy.

[The await comparison](measurements/task-await-fields.md) describes the input,
control, expected counts and limits. Sixteen string tasks are awaited twice;
integer and F128 results add two reads, giving 34 restored Some boxes in the
matched control. Cancellation and an escaping option have no count difference.
This is a comparison of two fwp representations, not elapsed time or C/Rust parity.
The focused artifact inventory includes 34 native binaries per host: the prior
22 controls, eight await comparisons, and four raw-buffer controls.

## Verified preflight and remaining checks

Source `bed604ef5275e6600028bd5f3892c927b6653cad` passed all three jobs in
`39670240111`: Linux AMD64 and both WebAssembly hosts. Every complete log is
audited. Publication `/private/tmp/fwp-task-await-repair-publication.json`, audit
`/private/tmp/fwp-audit-task-await-repair.py`, receipt
`/private/tmp/fwp-task-await-repair-acceptance.json`. Compiler units, the new State
regression, Jacobian cleanup, stricter corpus, 30-binary inspector and transport
checks pass. The corpus executes 77 of 86 programs, rejects six with the stated
reasons, and verifies three expected compile errors; the accepted parent executed
75. This source predates the raw-buffer repair and required observer
call count; those additional changes need the next matrix.

The preceding `82905d6b` preflight is fully audited: Linux passed; both WASM hosts
failed only eight ineffective missing-State controls each. The await fixture
creates no State storage. Its corrected control omits cached task-result cleanup
instead; that repair passes at `bed604ef`. Preserve the failed-source receipt;
do not count the old run as acceptance.

No new Rust compiler was built locally. Guarded checks from the primary workspace:

- `/private/tmp/fwp-check-await-fields.py` and
  `/private/tmp/fwp-validate-await-preparation.py`: formatting, raw interpretation,
  frozen primitive inventory, eleven native-runner checks, workflow/docs checks.
- `/private/tmp/fwp-probe-await-fields.py`: matching task runtime transplanted into
  prior-compiler metadata, macOS ARM64 O0 GC/reuse checks; omitted retain exits 26.
- `/private/tmp/fwp-check-scope-repairs.py`: all 27 derivative outputs under raw
  interpretation, formatting and generated library docs.
- `/private/tmp/fwp-probe-interop-buffer-repair.py`: golden raw interpretation and
  macOS ARM64 O0 native GC/reuse checks; repaired code exits 0, omitted frees 211.
- `/private/tmp/fwp-check-final-scope-batch.py`: formatting, both changed workflows,
  inspector syntax, documentation links and diff checks.

Each command is run as `python3 scripts/local-guard.py python3 SCRIPT` from the
primary workspace. The prior verified compiler is
`/private/tmp/fwp-check-compiler-fc138650/fwp`. Local probes do not establish the
remaining platform evidence. Full builds, suites and benchmarks stay on runners.

## Preceding delivery

[PR #190](https://github.com/e6qu/fun-with-pipes/pull/190) is the sole active PR,
worktree `/private/tmp/fwp-task-channel-owners`, final head
`4cdf8afa8647cfdaecbc338429bf8a1c1a158210`. All eight focused jobs passed at
`bf78c7ab`, with complete log audits and inspection of 132 native binaries and
64 task-channel WebAssembly modules. Final production `39673092514` has the
benchmark job passed and eight native jobs running. Documentation `39673088884`
passed. Audit `/private/tmp/fwp-audit-190-final.py`; merge only after all exact-head
gates pass using `/private/tmp/fwp-merge-190.py`. Its publication/receipt paths
are `/private/tmp/fwp-task-channel-corrected-publication.json` and
`/private/tmp/fwp-190-final-acceptance.json`.

After merging #190, retain the measured source tags, rebase this branch onto the
verified merge, resolve the handoff to this group's actual status, and open the
next substantial PR. The auxiliary Cargo argument-order repair is already present
in both branches. Preserve the separate callback baseline `521a1600`: its 10 → 5
retains result does not measure the new await fields. PR #189 is already accepted
and merged as `030fa337`; do not restart its completed work.

## Resource and delivery rules

Use the primary resource guard for serial checks: 64 GiB free disk, target below
2 GiB, sampled aggregate RSS below 1 GiB and a 180-second deadline. Never raise
limits or bypass a refusal. Fix all observed failures together before publishing
repairs; preserve healthy running heads. Squash only after exact-head nine
production jobs and docs pass, with one line ≤80 characters, empty body, no
trailers or attribution. Continue the plan after every accepted merge.

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

## Current full-matrix repair

The raw-buffer observer now follows the runtime's platform headers, with an
assertion that its insertion point occurs exactly once. It no longer causes
Windows headers to choose an older API before fwp selects Windows 10. Both
Windows ownership logs were inspected, not just the first failure. Full job
logs remain required. Guarded static checks and the macOS O0 probe pass; the
missing-free control still exits 211. This repair needs native Windows CI.

Separate worktree `/private/tmp/fwp-native-kernel-contracts` prepares removal of
runtime OpenCL compilation and explicit CPU worker limits. It has no PR; its
handoff records its own checks. Do not mix that work into this running source.
