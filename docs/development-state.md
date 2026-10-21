# Session handoff

## Next action

Next: audit [PR #191](https://github.com/e6qu/fun-with-pipes/pull/191) at
`12be5afcee7c81f1b98ffed2081d698e1124b000`: production `39688998592`,
documentation `39688998567` and focused Linux GCC `39688997806`.
Use `/private/tmp/fwp-audit-191-final.py` and `/private/tmp/fwp-audit-191-gcc.py`.
Documentation, C/Rust benchmarks and the focused GCC check pass with full logs
audited. Eight other production jobs are running. Fix every observed failure together, then
require nine production jobs, documentation and the focused check for the exact
head before squash merge. Continue all seven open plan areas afterward.
Publication receipt: `/private/tmp/fwp-combined-publication.json`.

## Independent application preparation

Branch `application-baselines`, worktree `/private/tmp/fwp-application-baselines`,
is preparing the next substantial batch while #191 runs. No second PR is open.
Source `74263bccf8e2e67865e1863e2c04a296a97877bb`, immutable tag
`roadmap/revision-wordfreq-74263bccf8e2`, passes both Linux word-frequency jobs
in `39690307737`; full logs are audited. Eight executed binaries are independently
inspected in `/private/tmp/fwp-application-evidence/74263bccf8e2/inspection.json`.
The [baseline](measurements/wordfreq.md) retains all samples: for 65,536 words,
fwp ARC takes 3.29–3.52× C time and 2.45–2.54× Rust time, with 397,353 allocation
requests, 138,250 retains and zero final managed charge. The C/Rust peers combine
normalization into one pass; this is not a pure language-overhead measurement.

The worktree additionally prepares the [descent comparison](application-acceptance.md#descent-with-and-without-a-saved-history):
the same Rosenbrock gradient and 199 updates, with saved history versus current
weights, at 3/33/129 dimensions. The runner workflow is prepared but not launched.
Four small local cases match the prior verified interpreter and an independent
analytic derivative. No native result or improvement is claimed yet.

The next optimization investigation is unchanged text: lower/upper/trim and
replacement can avoid copies when bytes are unchanged. No compiler/runtime change
has been made for this yet. Preserve original aliases and cleanup, consider
consumed leaf ownership to avoid redundant retain/release pairs, and compare the
same-host saved baseline C against any candidate. Count all additional sharing.
Full builds and measurements remain on runners.

Guarded local checks: `fwp-check-wordfreq-peers.py` passes nine C/Rust/interpreter
cases; `fwp-check-ad-application.py` passes four paired descent cases;
`fwp-inspect-wordfreq.py` verifies eight actual binaries;
`fwp-check-application-preparation.py` covers formatting, workflow, Python and docs.
All use the primary `python3 scripts/local-guard.py python3 SCRIPT`. An early peer
mistakenly treated vertical tab/form feed as word separators; the peers and docs
now match both language engines' explicit space/tab/CR/LF behavior.

## Delivery preparation

Branch `task-results-cpu`, worktree `/private/tmp/fwp-task-results-cpu`, has the
combined changes committed on #190's verified squash merge
`a2b9130fa1811c32e8807ba8cf61a8647fbcba60`. PR #191 is the only active delivery.
Preparation receipt: `/private/tmp/fwp-combined-delivery-preparation.json`.
It combines await fields, State/Jacobian repairs, C-buffer cleanup, CPU contracts,
removal of runtime OpenCL compilation and preparation of C bridges before effects.
The only merge conflict was this handoff. Guarded integration checks pass:
compiler/runtime/library/tests equal `2cefc648` exactly; formatting, workflow lint,
primitive inventory and documentation links pass. Preserve all immutable tags.

The completed CPU preparation remains on `native-kernel-contracts`, worktree
`/private/tmp/fwp-native-kernel-contracts`. Its current source is `2cefc648`, tag
`roadmap/revision-cpu-modes-2cefc6482618`; publication
`/private/tmp/fwp-cpu-modes-publication.json`. Keep any further code repairs in
sync with the combined delivery; do not overwrite the original measured sources.

[PR #190](https://github.com/e6qu/fun-with-pipes/pull/190) passed all nine
production jobs in `39673092514` and documentation `39673088884` at
`4cdf8afa8647cfdaecbc338429bf8a1c1a158210`. Every full log is audited.
Squash merge `a2b9130fa1811c32e8807ba8cf61a8647fbcba60` has the identical tree,
expected parent and one-line message without body or trailers. Receipt:
`/private/tmp/fwp-190-final-acceptance.json`. Redundant same-tree post-merge
production `39688181299` was cancelled. Post-merge documentation
`39688181354` also passes; retain its full-log audit with the publication receipt.
The primary checkout is detached at that merge, with only its handoff dirty.


## Evidence and resolved failures

Await source `f2b5d400fedaca3a24208cd3bcdf08f2ebe51c61`, tag
`roadmap/revision-await-fields-f2b5d400feda`, passes all six native and both WASM
jobs in `39678830873`. Every full log is audited. Independent inspection covers
204 native binaries and 64 await modules. The [report](measurements/task-await-fields.md)
records 134 → 100 allocation requests and 544 fewer requested bytes, with
unchanged retains and peak storage. It makes no timing or C/Rust parity claim.
Raw evidence and inspection receipts: `/private/tmp/fwp-task-await-evidence/f2b5d400feda`.
Duplicate download archives were removed only after their hashes were checked;
extracted binaries, C, symbols and results remain. Do not rerun completed inspectors.

Earlier await failures were an ineffective WASM missing-State control and a
Windows observer inserted before platform headers. Both are repaired at the
accepted source without relaxing ownership checks. Their full logs are audited.
State partial captures keep creation scopes; Jacobian output counting releases
its own tape scope; all 27 tape observations must execute. C-interop copies results
before freeing raw buffers, including nested callbacks; missing frees must fail.

CPU source `4ce0f3aa`, run `39678998800`, failed on obsolete private helper calls
and an effectful constant. Follow-up `245fefda`, run `39682721876`, passes both WASM
jobs and all executed Linux targets, but failed on an unused import and Rust
format-string escaping. Both runs are fully audited. Source `4d482aa6`, run
`39685395310`, fixes those; its complete Linux log fails only because the worker
test enabled forbidden GC/reuse verification on ARC. Both WASM jobs pass and their full logs are audited. The passing `2cefc648` repair selects all settings explicitly by
memory mode and removes a redundant internal thread clamp. Clamping to fewer
work blocks remains normal worker allocation.

The strict Linux corpus executes 81/86 programs, with two explicit rejections
and three compile-error checks. Its artifact variable is fixed and a nonempty
report is now required. These counts alone are not complete platform acceptance.
Windows production now runs `numerics`. A named-host `kernels` probe omits WASM;
`native_runner=all` and production retain complete coverage. No test skip is a pass.

## Checks and resource limits

Use the primary `python3 scripts/local-guard.py python3 SCRIPT` for serial local
checks. Full Rust builds, suites and benchmarks stay on GitHub runners.

- `fwp-check-combined-delivery.py`: code equality with `2cefc648`, formatting,
  both workflow files, primitive inventory and docs pass on the staged delivery.
- `fwp-check-cpu-contracts.py`: formatting, generated library docs, workflow lint,
  frozen primitive inventory and documentation checks pass on the preparation.
- `fwp-check-kernel-schedule.py`: eleven runner tests pass; every native integration
  target has exactly one macOS shard assignment.
- `fwp-check-cpu-worker-example.py`: current-library examples pass raw interpretation;
  the complete numerics Rust test harness compiles without building fwp.
- `fwp-probe-cpu-worker-limits.py`: 56 current-C cases pass on macOS ARM64, using
  prior-compiler private-helper metadata: both operations, seven counts, ARC/tracing,
  O0/O2. This does not establish the new public API/compiler or other platforms.
- `fwp-probe-foreign-preparation.py`: reproduces the old interpreter compiling
  after a file effect; its launcher control exits 88. The new regression, FFI,
  callbacks, REPL and debugger tests pass in the audited Linux preflight.

Preserve 64 GiB free disk, generated target below 2 GiB, sampled aggregate RSS
below 1 GiB and the guard's 180-second deadline. Never raise or bypass limits.
Fix every encountered failure. Every commit has one line ≤80 characters, no body,
trailers or attribution. Final-head gates are required before the authorized squash.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and prove remaining ownership boundaries. |
| 2 | In progress | Eliminate avoidable functional allocations and count traffic. |
| 3 | In progress | Resolve measured machine-code and performance gaps. |
| 4 | In progress | Improve differentiation time, memory and precision. |
| 5 | In progress | Validate CPU numerical kernels and remove runtime compilation. |
| 6 | In progress | Establish equivalent-work comparisons and budgets. |
| 7 | In progress | Validate larger programs and bounded live memory. |
