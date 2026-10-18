# Session handoff

## Next action

PR #167 is merged as `e8e22f1901e5396e1bf3555073ebeb9d5c65da41`, with the same
Git tree as tested head `7cb899faa86d3cafb1192529d7fd357e7067ca4b`. All nine
production jobs, documentation, four terminal probes and tools/browser checks
passed and their completed logs were audited. Duplicate queued post-merge runs
`39151593383` and `39151593381` were cancelled after checking tree identity.
[Delivery history](roadmap-history.md#interactive-tools-and-cached-map-borrows-pr-167)
records the acceptance links and limitations.

Current branch: `ownership-tail-recursion`, based on that merge.
[PR #168](https://github.com/e6qu/fun-with-pipes/pull/168).
Next: run the expanded focused language suite for the complete CI repair,
then require all nine production jobs plus documentation on that exact head.
Keep the PR draft during the focused repair check to avoid repeating full gates
before the compiler and every previously failing target pass. Do not merge yet.

## Current batch and CI repair

PR #168 adds eligible self-tail frame reuse, cycle-proof diagnostics and lesson
23's callback/channel/cancellation/graph examples. Default tracing removal and
all seven roadmap areas remain unfinished.

All eleven jobs at `8c9f1c8095f9df1d84f1c61c00fa10cd652c5155` were audited:
production `39153169076`, focused `39153117778`, docs `39153113800`.
The eight production execution jobs and focused job fail. Benchmarks, docs,
eleven Python SDK tests and the real browser pass. Logs are preserved in
`/private/tmp/fwp-pr168-8c9f`. Distinct failures and repairs:

- The typed-loop rewrite hid record/variant fields and wide-number operations
  from native representation selection. It broke both wide-worker tests, record
  conversion coverage and variant-alias coverage. The repair proves eligible
  self calls after fusion without changing their expression trees. Interpreter
  and native execution reuse the existing frame directly; native count insertion
  and record/variant/wide-worker selection keep their original inputs. Arguments
  are prepared before overwrite, reuse tokens retire before the jump, and entry
  cancellation checks remain. REPL function-ID remapping preserves these proofs.
- Native scheduler root storage survived executable shutdown. Lesson 23 exposed
  it through the ARC ledger (1536 bytes on Linux, 768 on Windows). The repair
  drains remaining tasks, releases native scheduler/root storage and keeps the
  existing library/fiber shutdown paths. A negative control must detect omission.
- ARC rejects reuse verification because it intentionally retains freed storage.
  The recursion harness now enables all three stress/verification controls only
  for tracing. ARC verifies real reclamation through its allocation ledger.
- Raw preemption coverage exceeded the stack in an unoptimized Rust build. Its
  independent scheduling reference now uses 200 recursive calls, while ordinary
  coverage keeps 4000 and dedicated tail-recursion coverage keeps 200000.

The expanded focused job includes every failing target plus task ownership,
reuse, scheduling, REPL/debugger and numerical/tool checks. The runner-only
recursion comparison retains actual binaries/disassembly, stack-use estimates,
allocations/live bytes and repeated timing against an explicit fwp loop. Earlier
measurement results describe the superseded rewrite and cannot validate this
repair. No C/Rust parity or universal tail-call guarantee is claimed.

## Local checks

All checks use `python3 scripts/local-guard.py`; no local compiler build or full
suite. The exact CI-generated lesson-23 C was downloaded from the macOS ARM64
ownership artifact. A diagnostic reproduced the retained scheduler root; a
focused C build with the repaired runtime shutdown passes the ARC ledger and
prints the four expected lines. Commands:

- `cc -O1 -std=gnu11 /private/tmp/fwp-arc-shutdown-fixed.c -o /private/tmp/fwp-arc-shutdown-fixed -lm -lpthread`: pass, 0.98 seconds.
- `env FWP_GC_STRESS=0 FWP_GC_VERIFY=0 FWP_REUSE_VERIFY=0 /private/tmp/fwp-arc-shutdown-fixed`: pass, 0.50 seconds.
- `cargo fmt --all`: pass, 1.42 seconds after the final test edits.
- `/private/tmp/fwp-doc-audit.py`: all 60 Markdown sets and tutorial copies pass, 0.37 seconds.
- `/private/tmp/fwp-python-import-audit.py`: all 72 Python files, top-level imports, empty initializers and AGENTS length pass, 0.37 seconds.
- `scripts/check-roadmap.py`: roadmap links, anchors, handoff and commit subjects pass.

This verifies the isolated shutdown repair on this host, not the current Rust
compiler or the cross-platform change. Those require runner acceptance.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Ownership/cycle contracts, tracing removal and limited ARC |
| 2 | In progress | Functional intermediates, copies and eligible tail recursion |
| 3 | In progress | Equivalent-work C/Rust gaps and machine-code costs |
| 4 | In progress | Derivative precision, speed and storage |
| 5 | In progress | CPU kernels and ahead-of-time device execution |
| 6 | In progress | Reproducible comparisons and regression budgets |
| 7 | In progress | Representative larger applications |

The seven project work areas in [PLAN.md](../PLAN.md) remain open. Default tracing
removal is unfinished. JIT is excluded. After this delivery, the next substantial
work is the next ownership/performance gap selected from representative programs
and the measured results of this batch. Do not repeat this batch as a new task.
