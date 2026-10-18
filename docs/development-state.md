# Session handoff

## Next action

[PR #167](https://github.com/e6qu/fun-with-pipes/pull/167) is still open.
Published acceptance head: `2f3e87cd26e0b28225fcb60faa1473a3e8ac8478`.
The user then requested explicit settings and no compatibility machinery.
The working tree applies that requirement to the new tools:

- SDK callers supply compiler/tool paths, input choice, timeout, target settings
  and optimization levels. Two internal forwarding helpers are removed.
- Notebook startup requires Python, working directory and port; port 0 explicitly
  requests an available port. The browser test now uses the actual fwp launcher.
- REPL users select terminal history, no history, scripted input or JSON mode.
  No environment-derived history path or silent terminal-to-stream conversion.
  JSON requests require command/source fields; malformed requests cannot run code.
- A dead notebook interpreter reports failure; another explicit cell run starts
  a fresh session. Effects are never automatically retried.
- Examples, tests, CI toolchain settings, PLAN and AGENTS match these interfaces.
  Backward compatibility remains unnecessary; no adapters are included.

Next: complete focused validation of these changes, publish one combined commit,
then require all nine production jobs, docs, terminal probes and tools/browser
checks at that new exact head before squash merge. Use one commit subject of at
most 80 characters and an empty body. Keep the earlier run intact for its results.

### Current evidence

At `2f3e87cd`, production run `39134575726` has eight passing jobs; Linux AMD64
is still running. Linux ARM64 reports 756 Rust passes, zero failures and 15 ignored
checks. Each regular Mac reports 468 Rust passes and ten Python passes, with no
failures/skips. Each Mac GC job reports 293 passes and 15 ignored checks. Windows
ARM64/AMD64 each report 363 Rust passes and six ignored checks; eight Python tests
run and two POSIX terminal tests are skipped. Packaging and binary evidence pass.
Documentation `39134575677`, all four terminal jobs `39134597819`, and the tools/
package/browser job `39134602773` pass. The latter runs 22 Rust and ten Python
checks, native/cross-target O0–O3 disassembly and actual Chromium. All terminal
probes run both interruption/recovery and standalone shutdown tests with no skips.
These results precede the explicit-settings changes; they do not verify them.

The earlier full run at `f957980a` is completely audited: seven jobs passed;
both regular Mac jobs failed only the repaired terminal test. Across platforms,
3,762 Rust test executions passed, none failed, and 72 were ignored. Local logs:
`/private/tmp/fwp-final-f957` and `/private/tmp/fwp-final-2f3e`.

Repairs already verified remotely: restore the handoff's required status table
and Next marker; wait for real terminal output before sending SIGINT and drain
the PTY while waiting for exit; route scheduler SIGINT to the active REPL after
`signal.shutdown-requested` installs its handler; use UTF-8 for disassembly reports.
The enhanced terminal test reproduces the signal bug on the old compiler and
passes on all four native Linux/Mac targets after repair. Standalone SIGINT and
SIGTERM still clean up normally.

Focused local checks for the explicit-settings changes use the fixed guard:

- `python3 scripts/local-guard.py cargo fmt --all`: pass, 1.55 seconds.
- `python3 scripts/local-guard.py python3 /private/tmp/fwp-python-import-audit.py`:
  pass, 0.27 seconds; 71 Python files, top-level imports, empty initializers and
  AGENTS under 100 lines.
- `python3 scripts/local-guard.py env PYTHONDONTWRITEBYTECODE=1
  PYTHONPATH=sdk/python:sdk/python/tests
  FWP_TEST_BIN=/private/tmp/fwp-terminal-763-mac/fwp python3
  -W error::ResourceWarning -m unittest
  test_tools.Tools.test_dead_notebook_process_requires_an_explicit_new_run
  test_tools.Tools.test_notebook_replaces_definitions_and_never_replays_other_expressions
  test_tools.Tools.test_notebook_input_cannot_consume_protocol_and_errors_leave_session_usable
  test_tools.Tools.test_debugger_controls_typed_values_and_streams_events -v`:
  four passes, 7.96 seconds. This uses the earlier CI-built compiler to check
  Python changes; it does not validate new Rust code. No local compiler rebuild.
- The same guarded SDK invocation with explicit `CC=cc` and
  `FWP_OBJDUMP=/Library/Developer/CommandLineTools/usr/bin/llvm-objdump`, selecting
  `test_tools.Tools.test_disassembly_compares_c_and_instruction_encodings_at_four_levels`:
  pass, 1.46 seconds; actual ARM64 C/object instructions at O0/O1/O2/O3.
- Guarded `scripts/check-roadmap.py`: pass, 3.01 seconds; 59 link sets, 106
  preparation anchors and seven work areas. Guarded `/private/tmp/fwp-doc-audit.py`:
  pass, 0.38 seconds; all tutorial copies/outputs and historical evidence links.

Full Linux acceptance must execute the WASI float probe. Cross-target disassembly
establishes binary inspection, never native execution. Do not restart passing CI
solely for bookkeeping; fold it into required repairs or keep a local handoff.

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
