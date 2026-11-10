# Application workflow verification

**Passes on Linux ARM64 and AMD64.** This checks three maintained programs through
the tools; it does not measure compiler speed or HTTP throughput. Follow the
[walkthroughs](../../application-workflows.md) or the [remaining protocol](../application-tooling.md).

Source: `cafc157a0076bec270324b9c2c116f5fc376f889`.
[Native run](https://github.com/e6qu/fun-with-pipes/actions/runs/42707776942).
[Documentation passes](https://github.com/e6qu/fun-with-pipes/actions/runs/42707378584)
at `fb8cd1565b3ae801cb035a5c627aeccacf15c55b`; the subsequent change grants the
reusable workflow permission to read its previous artifacts.

| Check | ARM64 | AMD64 |
|---|---|---|
| Word counts, numerical minimization, queued callbacks | Pass | Pass |
| Raw/optimized interpreter, native O1/O2, scripted REPL | Pass | Pass |
| Notebook edits/errors, debugger inputs/results | Pass | Pass |
| Generated C and actual objects at O0/O1/O2/O3 | Pass | Pass |
| Eight integer-output tests, including decimal boundaries/canaries | Pass | Pass |
| Real notebook browser, save/reopen and explicit effects | Not run | Pass |

Inspection retains 12 object summaries per host. Those objects are not executed
by inspection; native O1/O2 execution is checked separately. No macOS or Windows
application claim follows from these focused Linux jobs. Final delivery gates
remain required for the assembled milestone.

## Repairs and original evidence

- Scripted REPL input requires `--stream`; terminal `--no-history` was incorrect.
- The formatter puts the short word-count entry pipeline on one line.
- GCC O3 warned about the integer formatter's unbounded decimal loop. A 128-bit
  value needs at most 39 decimal digits; the loop now exposes that bound and
  duration formatting has 41 bytes for sign/digits/terminator. No actual overflow
  was demonstrated. Independent signed/unsigned limits, powers of ten and buffer
  canaries pass at all four optimization levels, with warnings treated as errors.
- Historical word-count comparisons now read their recorded Git source.
- The workflow caller now explicitly grants artifact-read permission.

[The first run](https://github.com/e6qu/fun-with-pipes/actions/runs/42704406738)
and its documentation failure are retained as compressed complete logs here.
`original-compiler-diagnostics.json` preserves both hosts' original O3 warnings.
The passing ARM log intentionally prints those two old warnings while auditing
the earlier artifacts; neither is a new diagnostic. All completed native steps
and complete logs were inspected, with no unresolved diagnostic.

## Files and scope

- `audit.json`: source, runs, jobs, artifacts and complete-log digests.
- `arm/` and `amd/`: complete job logs, job/artifact metadata, toolchains,
  test logs and code summaries. AMD64 also retains the browser transcript.
- `files.json`: byte counts and SHA-256 for the retained evidence files.
- Full generated C, native objects, instruction reports and browser screenshots
  remain in artifacts `13715565238` (ARM64) and `13715201175` (AMD64). Their ZIP
  digests are recorded in each host's `artifact.json`; those complete archives
  are not duplicated here. Compact extracted reports were CRC-checked.

The application checks precede compiler-phase reporting. They do not verify
changes made after their recorded source.
