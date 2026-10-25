# Current work

**Next:** finish final-head validation of [PR #214](https://github.com/e6qu/fun-with-pipes/pull/214),
then publish the prepared ownership fault matrix as the next substantial PR.
The preparation is `/private/tmp/fwp-ownership-fault-matrix`, branch
`ownership-fault-matrix`, based on #214's `1591ec72553a1168bc52d5745d1865059c15fede`.
Do not publish a second active PR or restart passing gates to add these changes.

## Delivery in progress

PR #214 adds the live-allocation ledger and collector-setting inventory.
[Production 40187394961](https://github.com/e6qu/fun-with-pipes/actions/runs/40187394961)
was running without reported failures when checked on October 25.
Its regular macOS ARM64 job, benchmark and [documentation 40187394939](https://github.com/e6qu/fun-with-pipes/actions/runs/40187394939)
passed. Seven platform jobs remain; these are not completed acceptance claims.
The watcher `/private/tmp/fwp-214-merge-when-green.py` requires all nine production
jobs and documentation for the exact head, then squash-merges with the single line
`Check native ownership without retaining freed storage` and empty body.
It verifies the resulting message and tree. Status:
`/private/tmp/fwp-214-merge-status.json`. Stop it before a repair push; do not start
a competing merger. Keep auditing every failed job and completed target together.

## Prepared group

[The diagnostic guide](ownership-diagnostics.md#borrow-child-and-reuse-fault-matrix)
maps capture, typed-argument, reuse-token, variant-payload and stack-child faults
to their observers. ARC probes check live allocation identities as well as physical
bytes. Stack children now have 8/1,024-round dynamic/static checks; a missing release
must fail. Duplicate closure destruction must stop before accessing dead metadata.
Existing tracing/poisoning cases remain. Windows now includes `stack_ownership`;
native probe paths explicitly end in `.exe`. An added file-owner probe checks
actual OS closure, shutdown deregistration and byte reclamation separately over
8/1,024 rounds. It has independent missing-close/registration/free controls.

The source review also found null empty-argument slices used in pointer arithmetic
and a zero-byte `memcpy`. The C runtime now forms pointers only for nonempty cleanup
spans and copies only nonempty arguments. The callback fixture explicitly enables
error-handler cleanup. Restoring either old pointer calculation must fail a Unix
Clang sanitizer check; restoring the unconditional copy must fail a portable copy
observer. This is a source-level repair, not an explanation of the old Intel abort.

## Focused checks

All commands use `python3 scripts/local-guard.py`, serially. No full local build,
corpus or benchmark was run. The verified #213 compiler remains at
`/private/tmp/fwp-compiler-213/fwp-macos-arm64/fwp`, SHA-256
`faf994ee0067f5249da86877a7f450efe7cedcfdd433084ebee046319fff47fa`.

- Extracted stack tests: three passed, including dynamic/static O1/O2 faults and
  the original tracing controls. Evidence: `/private/tmp/fwp-stack-matrix-evidence`.
- Extracted callback test: passed O1/O2 ARC/tracing controls and both restored-null
  pointer faults. The temporary harness applies exactly the three candidate runtime
  edits to C emitted by #213; it does not rebuild the candidate compiler. Evidence:
  `/private/tmp/fwp-callback-matrix-evidence`; extraction script:
  `/private/tmp/extract-callback-tests.py`.
- Extracted reuse-token test: success, failure, omitted cleanup and omitted release
  passed O1/O2. Evidence: `/private/tmp/fwp-token-matrix-evidence`.
- Twelve saved variant C probes from #213's macOS ARM64 artifact `12594186700`
  pass after applying the new test instrumentation. Their native settings are
  O1/O2 for aliases and O0/O2 for payload moves. This does not compile the changed
  Rust generator target. Evidence: `/private/tmp/fwp-variant-matrix-evidence`;
  checker: `/private/tmp/check-variant-ledger.rs`.

The new ARC file-owner test also passed locally at O1/O2 for both repeat counts
and all three deliberately broken controls. Evidence:
`/private/tmp/fwp-file-matrix-evidence`. Incidental file-test fixes move an inline
Rust import to the top and give native executables explicit `.exe` paths.

Formatting, whitespace, Windows workflow lint and documentation audit passed.
The audit checked 158 link sets, 106 immutable preparation pairs/tags and eight
roadmap steps.

Full compiler/test-target compilation, GCC, Windows, WASI and integrated platform
coverage remain for the preparation's own final-head CI. Do not cite #214's gates
as validation of these later changes. Required gates and merge rules are in
[AGENTS.md](../AGENTS.md) and [CONTRIBUTING.md](../CONTRIBUTING.md).

## Remaining decisions and preserved work

The cycle-policy question remains unanswered: retain current ARC restrictions with
scopes/IDs when deleting tracing, or first add an explicit cycle-breaking API.
Do not infer an answer from silence. Independent G4 work continues: finish the
WASI/external-resource mapping, including cancellation and external callback entry.
Neither this matrix nor a zero byte balance proves arbitrary raw borrows safe.

Preserve [the unexplained Intel macOS compiler-abort evidence](measurements/compiler-abort.md).
Investigate recurrence from source lifetimes and inputs, without allocator-cookie
or disassembly-led experiments. The primary checkout remains detached at #209;
its operational handoff and untracked abort report must be preserved. Prior worktrees
and immutable preparation records are evidence, not a backlog to repeat.

## Roadmap status

Concrete unfinished tasks and acceptance criteria live in [PLAN.md](../PLAN.md).

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | G2–G3: settle remaining graph policy; G4 complete diagnostic replacements; G5 delete tracing |
| 2 | In progress | A2–A5: account for residual counts, remove redundant ownership work/boxes, prove count-free unique storage |
| 3 | In progress | F1–F3: cost fixtures, proved tail-frame extensions and mutual-recursion decision |
| 4 | In progress | P1–P3: checked comparisons and per-workload CPU budgets |
| 5 | In progress | D1–D3: AD recording/workspace costs and precision/nesting checks |
| 6 | In progress | N1–N2: accuracy and performance budgets for selected CPU kernels |
| 7 | In progress | B1–B2: repeated baselines and enforced evidence/budget rules |
| 8 | In progress | V1–V2: execute the finite application acceptance matrix |
