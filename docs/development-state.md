# Session handoff

## Next action

[PR #167](https://github.com/e6qu/fun-with-pipes/pull/167) is ready for its final
acceptance run after repair checkpoint `94420ae2`. All currently reported
failures are repaired; remaining old-head jobs must still be audited.
Production run `39129847428` at
`f957980acfb93e3699e55085def1ffd70f4c18b4` remains intact.
Focused terminal run `39132990289` passes on both Linux architectures; both
Mac architectures expose the terminal-drain defect described below.
Language/SDK/browser run `39132992668` passes, including the UTF-8 repair.
New terminal run `39133970673` and language run `39133975063` check `94420ae2`.
Next: audit the repaired terminal probes and all nine production jobs plus docs
at the final PR head; fix any new failures in this PR. Squash merge only after
all final-head gates pass, with one subject of at most 80 characters and an empty body.

Docs run `39129847367` failed because the handoff cleanup removed the required
roadmap-status table and `Next:` marker. Both are restored in `763e245b`.
The restored roadmap audit passes (3.01 s), as do tutorial/library documentation
harnesses (1.08 s) and eight native-runner scheduling checks (1.08 s).
SDK review also found locale-dependent text reads in C/disassembly reports:
the published repair explicitly uses UTF-8 and adds Unicode source to the existing
real-object comparison test. The updated focused suite passes; final production
acceptance still needs a new run.
Focused run `39129853485` now passes: 22 Rust checks, nine Python tests and the
installed-package browser test, with clean logs and reviewed desktop/mobile images.
Benchmark, ARM64 macOS GC and Windows AMD64 gates pass; four production jobs
remain running and both regular macOS jobs failed. The Mac GC log has 293 passed,
zero failed and 15 ignored checks. Windows AMD64 has 363 passed, zero failed
and six ignored checks. Audit logs and metadata are in `/private/tmp/fwp-final-f957`.
Each regular macOS job fails only its terminal interruption test: 468 Rust
checks and the other eight Python tests pass on each host. The test sent SIGINT after a fixed
0.3-second delay. Waiting for actual program output fixes interruption in the
native Mac probe. Its next failure, waiting for exit, had the same cause: macOS
waits for the PTY peer to consume output before restoring terminal mode.
A native stack sample confirms `tcsetattr`/`TCSADRAIN`; draining output while
reaping fixes the test against the unchanged CI-built compiler (guarded PASS,
2.82 s). No timeout or assertion was weakened.

The expanded test separately reproduces a real bug: querying
`signal.shutdown-requested` replaces the REPL's interrupt handler. The old CI
compiler fails after the second loop starts (guarded negative control, 23.33 s).
The published repair routes Ctrl-C to the active terminal session and preserves
standalone graceful shutdown. A scope guard clears terminal state on exit.
This Rust repair still needs remote compilation and the full enhanced test.
Focused terminal jobs use the production O1 profile on Linux/macOS ARM64/AMD64
and preserve failed compilers for diagnosis.
An additional standalone test checks normal cleanup after both SIGINT and
SIGTERM. It passes against the old CI-built Mac compiler (0.51 s under the
guard); the final run must preserve that behavior with the signal repair.

Python initializers are empty and imports stay at the top, using defining
modules directly; [AGENTS.md](../AGENTS.md) records these rules. The installed
package's browser assets and launcher pass the `f957980a` focused run. These
results do not replace final-head production acceptance.

Do not restart passing CI solely to record run IDs: fold bookkeeping into a
necessary repair or retain the local handoff until acceptance. Full Linux gates
require the actual WASI float probe; the focused runner's optional probe alone
does not establish WASI execution. Cross-target disassembly never establishes
execution on that target.

## What this PR implements

- Cached numeric-map borrowing across proven non-suspending reads, eliminating
  repeated retain/release operations. Unknown calls, escaping values and reentrant
  destruction remain checked. Initializer timing and cleanup are preserved.
  Direct tuple/variant results retain their correct representation.
- Infix `==`, `!=`, `<`, `<=`, `>` and `>=`, below arithmetic and above pipes.
  Operands evaluate left to right; ambiguous comparison chains are rejected.
- Inverse trig, hyperbolic functions, logarithm/exponential variants, `atan2` and
  `hypot` across the existing float formats without narrowing. These are scalar
  operations; they do not extend the differentiation traits.
- A persistent interpreter [REPL](repl.md): history, completion, multiline input,
  type inspection, loading/saving, interruption and reset, without replaying old
  effects. JSON protocol input stays separate from program input, including tasks.
- A local browser [notebook](notebooks.md): code/Markdown cells, dependencies,
  stale-result tracking, explicit reruns, interruption and source-only save/open.
  Tests use actual Chromium on desktop/mobile layouts. The package must be
  installed explicitly. No Jupyter kernel or automatic replay is implemented.
- An interpreter [debugger and Python SDK](debugging.md): function/source-line
  breakpoints, stepping, frames, typed values, raw float bits, events and input
  files. Tutorial output matches raw interpretation. Inspection is read-only;
  native-process debugging and foreign-C stepping are not implemented.
- C/machine-code comparison through the same SDK, with explicit targets and
  O0/O1/O2/O3 (optional Os/Oz/Og). Reports retain generated C, source locations,
  actual instruction encodings, compiler commands/versions and binary hashes.
  Focused CI inspects native AMD64 and cross ARM64 objects at all four levels.
- Revised tutorials, [parser/compiler guide](compiler-pipeline.md), ownership and
  tail-recursion proposals, benchmark methods and historical explanations.
  Examples introduce notation and show why their output follows. Proposed weak
  references and guaranteed tail recursion are not presented as implemented APIs.

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
work is cycle-safe ownership contracts and eligible tail-recursion elimination,
selected and checked against representative programs.

## Cached-map measurements

The workload builds 500,000 entries and makes two million queries. Eight variants
compare retained/borrowed access, joined/separate map storage and tracing/ARC.
Each has 24 fresh-process samples in balanced rotating order. Timing includes
startup, map construction, lookups, output and teardown; profiling is separate.
This compares fwp revisions, not fwp with C/Rust.

[Run 39128516933](https://github.com/e6qu/fun-with-pipes/actions/runs/39128516933)
at `e1fb8ba3375f5765ef1448ed5c58fa1322d37c1f` passed all five jobs. Audit checked
80 actual ELF/source/profile records and 60 focused tests. On the original
Xeon 8573C, the retained joined layout reproduces the old slowdown: 1.0425 times
the separate-layout time. Joined borrowing takes 0.9336 times the retained joined
time, and 0.9733 times the old separate-layout time: 2.67% faster overall.
The paired-bootstrap 95% interval for that overall ratio is 0.9659–0.9882.

Retains fall from 2,000,001 to one; allocation/live-byte counts are unchanged,
and final charged bytes are zero. Joined borrowing improves both modes on every
measured host. Preserve the slower comparisons too: separate-layout borrowing
has slower cells, and Neoverse N2's combined ARC comparison is 1.0174.
[The benchmark guide](benchmarks.md#rechecking-the-original-xeon-slowdown) explains
all comparisons and links raw reports. This settles the named map regression,
not all layout or performance goals.

Earlier integrated run `39125883230` at `085626f3` also passed all five jobs,
80 binary/source/profile records and 60 checks, including Intel 8370C/6973P-C.
Repeat run `39129855448` at `f957980a` passes all five jobs and 60 checks.
Audit verified all 80 binaries/profiles and generated C; all match earlier
same-architecture artifacts byte for byte. Two more Xeon samples give combined
tracing ratios 0.9731 and 0.9702. All raw faster/slower results are retained in
[the repeat report](measurements/cached-map-repeat-2026-10-18.json).
Audits `/private/tmp/fwp-audit-map-borrow-f957.py` (31.90 s) and
`/private/tmp/fwp-compare-map-programs.py` (0.15 s) pass through the unchanged guard.

## Local evidence and workspaces

Root `/Users/zardoz/projects/fun-with-pipes`, branch `clarify-docs-and-benchmarks`,
is based on accepted PR #166 merge `de678a7d42af803948835cfbc43b4862b63164da`.
[History](roadmap-history.md#numeric-map-and-set-construction-pr-166) records its
nine production jobs and docs: 3,670 passed, zero failed, 72 ignored. This PR has
not merged. The shared local `target/debug/fwp` is the older preparation compiler
`774d838c8afccddf01cb2d3c0de498857c0d6f86`, not the current branch compiler.

All local checks use `python3 scripts/local-guard.py COMMAND...`, serially,
with unchanged limits. Recent results:

- `python3 /private/tmp/fwp-python-import-audit.py`: 71 Python files compile,
  imports at the top, empty initializers, AGENTS under 100 lines; PASS, 0.33 s.
- `python3 /private/tmp/fwp-audit-map-borrow-e1.py`: actual map evidence audit;
  PASS, 35.83 s. Raw artifacts: `/private/tmp/fwp-map-borrow-e1`.
- `python3 /private/tmp/fwp-xeon-confidence.py`: paired-bootstrap calculation
  from retained samples; PASS, 0.26 s. No new benchmark execution locally.
- `cargo fmt --all -- --check`: PASS, 1.38 s.
- `python3 /private/tmp/fwp-doc-audit.py`: Markdown links/tutorial copies;
  PASS, 0.39 s. `scripts/check-roadmap.py`: 106 immutable preparation anchors,
  seven roadmap areas and commit subjects; PASS, 2.70 s.
- `python3 scripts/check-primitive-inventory.py`: PASS, 1.39 s; 394 declarations,
  371 contracts, 19 IR templates, three flat scalars and one reviewed symbol.
- JavaScript syntax: PASS, 0.21 s. `git diff --check` passes.

Earlier guarded tutorial/native checks used the explicitly identified preparation
compiler; remote focused checks above validate the integrated compiler. Earlier
build, terminal-harness and process-cleanup failures were repaired and rerun;
there is no known outstanding failure at `63a0b99b`.

Full builds, tests and benchmarks belong on GitHub. A prior guard permission error
passed unchanged on retry; do not bypass enforcement. A prior disk refusal was
resolved by deleting verified regenerable disassembly while retaining binaries,
sources and reports; manifest `/private/tmp/fwp-regenerable-disassembly-cleanup.json`.
