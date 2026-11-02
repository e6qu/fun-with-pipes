# Verification and retained evidence

Return to [results](README.md), [baseline](baseline.md) or [frozen requirements](protocol.md).

## Checkpoints

| Source / run | Result |
|---|---|
| `bb2e5b29` / `41497441785` | Baseline: both GCC hosts; all 96 observations audited |
| `15aa4c0a` | Protocol published before compiler edits |
| `229ea441` / `41505591902` | Initial compiler: all 96 frozen count limits pass |
| `0c5b9827` / `41507658382` | First cleanup controls pass GCC/Clang O1/O2 on both hosts |
| `76069cfa` / `41509110166` | Expanded boxed-input fixture crashes; cause and repair below |
| `a4f3200c` / `41511493637` | Repaired controls, all counts and binary audits pass |

Immutable tags retain the original sources:

- `roadmap/derivative-temporary-storage-protocol-2026-11-02`
- `roadmap/derivative-temporary-storage-counts-2026-11-02`
- `roadmap/derivative-temporary-storage-runner-2026-11-02`

## Repaired native checks

Full source: `a4f3200c9b97b955c3f3603788eacbfac19fde4e`.
ARM64 job `125504181040` and AMD64 job `125504181455` each pass 40 tests across
nine GCC/Clang target logs, with no warnings or errors. Coverage includes:

- Raw/optimized interpreter versus native order and results; empty/singleton
  inputs, unequal zip inputs and aliases.
- Scalar and boxed callback input owners; map, between-stage and fold failures;
  cancellation; buffer and final-result allocation failures.
- Nine selection exclusions; related autodiff, worker-preparation and zip-unwind
  regressions.
- Actual physical buffer release: eight ordinary and eight deliberately broken
  native probe binaries per architecture. Each ordinary probe completes all
  modes and returns zero. Each missing-release probe differs only by the omitted
  destructor and returns 90. Architectures, outputs, checked buffer sizes and
  protected callback owners are independently audited.

[Verified counts](verified-counts.json.gz), [artifact identities](verified-artifacts.json)
and `verified-arm64-job.log.gz` / `verified-amd64-job.log.gz` retain this source's
results. Full archive replay passes all 96 observations and binary/frame limits.
All 48 case C sources plus four observer-control sources are byte-identical to
the initial implementation; all observations also agree. The compiler repair
skips use scans for unrelated `let` bindings without changing selected programs.
These focused Linux checks do not replace the full final platform matrix.

## Fixture failure and repair

Expanded run `41509110166` failed only its new boxed-input probe under GCC and
Clang on both architectures. Each host had 38 passes and two instances of that
failure. Scalar probes and all other targets passed.

The boxed callback prints its input to keep the record observable. Its standalone
C driver bypassed executable startup and left `fwp_prog_out` null; `fwrite` crashed
before the intended failure. The repair explicitly sets `fwp_prog_out = stdout`.
The exact failed source with that one-line change passes a guarded local macOS
ARM64 Clang O1 compile/run. The repaired Linux runs independently verify GCC and
Clang. No production allocator change was needed.

[Failure artifact identities](expanded-failure-artifacts.json),
`expanded-failure-arm64.log.gz` and `expanded-failure-amd64.log.gz` preserve both
failed jobs. Initial successful evidence remains in [candidate counts](candidate-counts.json.gz),
[candidate artifacts](candidate-artifacts.json) and `candidate-*-job.log.gz`.

## Reproduce

The [timing tables](timing.md) link each measured run's compressed reports and
audit index. The index retains every file's hash, complete job-log identity,
source revision, reference patch and original acceptance result. Each run's
`report-artifacts.json` also identifies the independent report workflow and its
full retained archive. CPU-only rejections remain beside measured outcomes.

`packed-records-report` downloads and audits the complete native evidence on
GitHub without executing saved binaries. Its compact output is digest-checked
locally; report medians, balanced orders, counts and timing limits are recomputed.
These audits preserve a failed performance limit as failed.

All four sessions are retained. Reproduce the published tables with:

```sh
python3 scripts/report-packed-records.py \
  --directory docs/measurements/derivative-temporary-storage-2026-11-02 \
  --source a4f3200c9b97b955c3f3603788eacbfac19fde4e --mode check
```

Use `--mode write` to regenerate them. The documentation gate checks this exact
output and rejects missing/duplicate sessions, changed payloads, source/binary
identity mismatches and erased failures. Five regression tests exercise those
checks' payload, timing-decision and artifact-identity failures.

Download the archives identified by `verified-artifacts.json` and verify their
SHA-256 digests. Recompute all observations and acceptance limits with:

```sh
python3 scripts/summarize-derivative-forward-costs.py \
  --arm64 ARM64.zip --amd64 AMD64.zip \
  --source a4f3200c9b97b955c3f3603788eacbfac19fde4e --run 41511493637 \
  --comparison packed-records \
  --baseline docs/measurements/derivative-temporary-storage-2026-11-02/baseline.json.gz \
  --output verified-counts.json.gz
```

For the baseline, use source `bb2e5b29fa6f53b3f187c3fba3fd15d38ff4085b`, run
`41497441785`, `--comparison baseline`, and omit `--baseline`. Its callback-box
audit uses `scripts/summarize-derivative-callback-boxes.py` with explicit
`--accumulator direct-fields`; #239's historical representation instead requires
`boxed-each-step`. Wrong layouts must fail.

`scripts/prepare-packed-records-reference.py` replaces only the packed-record
lowering call with a clone of the preceding representation. The disabled branch
remains type-checked; there is no runtime setting. Both compilers keep the older
record-fold optimizations. The runner saves the exact patch, source hashes and
compiler identity. The archive auditor reconstructs the patch as data without
executing saved code. Dispatch `packed-records-time` with an explicit native host
and session; `packed-records-report` independently audits all completed outcomes.
