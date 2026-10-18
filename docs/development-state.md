# Session handoff

## Next action

Publish the final combined [PR #167](https://github.com/e6qu/fun-with-pipes/pull/167)
head without skipping CI. Run the nine production gates, documentation audit,
`numerics.yml` suite `language`, and suite `map-borrow` (baseline run
`39106005017`, baseline source `93cb93a0f717b317814ecfc162de0c2f516dbfbd`).
Audit every job and fix all failures together. Squash merge only after all
final-head gates pass, with one subject of at most 80 characters and an empty body.

The latest published checkpoint is `63a0b99b`; focused run
[39129005531](https://github.com/e6qu/fun-with-pipes/actions/runs/39129005531)
passed formatting, all-target Clippy, 22 Rust checks, nine Python integration
tests and real Chromium notebook execution. Its complete log was audited:
no failures or resource/leaked-process warnings. Terminal completion, history,
multiline entry and execution interruption pass. Imported type changes are
rejected before they can reinterpret stored REPL values; restoring the old module
leaves those values usable.

Local changes since that checkpoint empty Python package initializers, use direct
module imports, and move all imports to the top of files. These rules are in
[AGENTS.md](../AGENTS.md). The browser workflow now installs the actual Python
package in a virtual environment, testing packaged assets and the launcher.
It also includes the matching Xeon measurements below and clearer notebook text.
Those final changes still need remote acceptance.

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
The final-head audit should compare emitted C and actual binary hashes against
`e1fb8ba3` to establish whether its matching-Xeon measurement still describes
identical emitted programs. Do not infer that from source intent alone.

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
