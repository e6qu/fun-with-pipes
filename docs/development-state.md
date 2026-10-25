# Current work

**Next:** complete G2's weak-reference contract and six acceptance examples in
[the accepted ownership direction](gc-removal-design.md#six-implementation-examples),
including target types, acquisition/expiration, final-release ordering and stores
that could recreate a cycle. Then implement G3's first complete weak path.
The user accepted this direction on October 25: reject unproved owning cycles,
infer moves/borrows, use ARC for sharing, add weak links for selected objects and
use regions for bounded work. Preserve returned functions and partial application.
Current APIs and layouts are replaceable; the weak API is not implemented.
Worktree `/private/tmp/fwp-ownership-fault-matrix`, branch `ownership-fault-matrix`,
starts from preparation `517de6e1e77c05ce7dc3577e21258ea605363168` on #214's head.
G3 and G4 must be in the same PR. Keep it draft until both and all other included
changes are complete. During development run only checks justified by a changed
contract or specific issue; do not rerun passing suites or full CI per edit.
Then perform one consolidated local validation under the existing resource guard
and the full final-head CI matrix. Record any workloads moved to CI because they
cannot fit local limits. Add tests with the code; defer broad execution, not
coverage. Include G5 in the same group where practical.

The follow-on publisher PID 46922 was stopped on October 25 at the user's request
to consolidate this work. Its status is `stopped-for-combined-gc-removal` in
`/private/tmp/fwp-fault-matrix-delivery-status.json`. Do not restart the old script:
it would prematurely publish and merge the earlier preparation. The separate
#214 watcher may finish its existing validation and verified merge.

## Delivery in progress

PR #214 adds the live-allocation ledger and collector-setting inventory.
[Production 40187394961](https://github.com/e6qu/fun-with-pipes/actions/runs/40187394961)
was running without reported failures when checked on October 25.
At the last recorded check, 12:53 UTC, all four macOS jobs, Linux ARM64,
Windows ARM64, benchmark and
[documentation 40187394939](https://github.com/e6qu/fun-with-pipes/actions/runs/40187394939)
passed. Linux AMD64 and Windows AMD64 were running. Read the watcher status
for later results; running jobs are not completed acceptance claims.
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

The accepted-direction revision updates the plan, ownership/design/feasibility
guides, admission and diagnostic instructions, benchmark protocol, README and
recursion tutorial together. It removes the pending broad cycle-policy decision.
Exact weak API semantics remain G2 work. Guarded
`python3 scripts/local-guard.py python3 scripts/check-roadmap.py` passed: 159 doc
link sets, 106 immutable preparation pairs/tags, eight roadmap steps and commit
messages. `git diff --cached --check` passed; AGENTS.md has 99 lines. No compiler
build or comparative benchmark was run for this documentation revision.

Full compiler/test-target compilation, GCC, Windows, WASI and integrated platform
coverage remain for the preparation's own final-head CI. Do not cite #214's gates
as validation of these later changes. Required gates and merge rules are in
[AGENTS.md](../AGENTS.md) and [CONTRIBUTING.md](../CONTRIBUTING.md).

## Implementation direction and preserved work

The ownership direction is accepted, not pending another policy question. G2
must turn its six examples into precise contracts and establish analysis-scaling
budgets. G3 implements weak access and ownership rules; G4 closes diagnostics;
G5 deletes tracing. Finish the combined GC-removal batch before chasing every
remaining ARC operation. Afterward, baseline and implement the count-free buffer
(A5); use measurements to order other count/box work and the parser workspace
(A6). General region inference is not a prerequisite for GC removal.
Do not automatically weaken captures or present another language's performance
claims as verified fwp behavior. Ask only about concrete new semantic tradeoffs
if an example cannot meet the accepted contract.
G4 still needs the finite WASI/external-resource mapping, including cancellation
and external callback entry; it must not displace the GC-removal design work.
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
| 1 | In progress | Direction accepted; G2 specifies weak semantics/examples; G3 implements them; G4 closes diagnostics; G5 deletes tracing |
| 2 | In progress | A2–A6: baseline residual costs, count-free unique buffer, measured count/box removal and scoped parser workspace |
| 3 | In progress | F1–F3: cost fixtures, proved tail-frame extensions and mutual-recursion decision |
| 4 | In progress | P1–P3: checked comparisons and per-workload CPU budgets |
| 5 | In progress | D1–D3: AD recording/workspace costs and precision/nesting checks |
| 6 | In progress | N1–N2: accuracy and performance budgets for selected CPU kernels |
| 7 | In progress | B1–B2: repeated baselines and enforced evidence/budget rules |
| 8 | In progress | V1–V2: execute the finite application acceptance matrix |
