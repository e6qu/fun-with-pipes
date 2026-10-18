# Contributing to fwp

This guide explains how to change the compiler, test it and submit a pull request.
Learn the source language through the [tutorials](docs/tutorials/README.md); use
[compiler design](docs/design.md) to find the implementation and
[the glossary](docs/glossary.md) to look up unfamiliar terms.
The [compiler pipeline](docs/compiler-pipeline.md) maps parsing, expansion,
desugaring and execution to source files. [Design limits](docs/design-limits.md)
separate measurable goals from promises the compiler cannot make.

Before work, read [the plan](PLAN.md) and [session handoff](docs/development-state.md)
to avoid repeating completed tasks. The handoff records actual checks, unresolved
failures and one next action. [Delivery history](docs/roadmap-history.md) preserves
accepted evidence; [preparation commits](docs/roadmap-queue.md) are historical
identities, not a backlog to execute again.

## Setting up

You need:

- Rust (stable), with `rustfmt` and `clippy`.
- A C compiler (`cc`; GCC or clang). Native programs, and most tests,
  are built with it.
- OpenSSL 3 with headers (`libssl-dev`), for TLS.
- On macOS: Xcode command line tools (`xcode-select --install`), and
  OpenSSL 3 from Homebrew (`brew install openssl@3`). Set `FWP_OPENSSL_DIR`
  to the output of `brew --prefix openssl@3` for native TLS builds and the
  interpreter. CI uses Apple Clang on Apple Silicon and Intel.
- On Windows: the native setup in `scripts/setup-windows.ps1` selects SDK-aware
  Clang for the Rust MSVC build and LLVM-MinGW for generated programs. This
  runner script uses GitHub CLI and `GH_TOKEN` to fetch a pinned release asset,
  checks its SHA-256 digest and stops if setup fails. Workflow steps supply the
  token; native tests require successful toolchain setup.
  `scripts/setup-windows-tls.ps1` supplies matching OpenSSL dependencies. The
  [Windows workflow](.github/workflows/windows.yml) records the full runner setup.
- Optional, for the WebAssembly tests: clang with a WASI sysroot and lld
  (Debian/Ubuntu: `clang llvm lld wasi-libc libclang-rt-18-dev-wasm32 libc++-18-dev-wasm32`), the
  `wasm32-wasip1` Rust target (`rustup target add wasm32-wasip1`), node 24,
  and binaryen's `wasm-opt` (`npm install -g binaryen`).
- Optional, for the cross-compilation tests: an aarch64 C compiler and
  qemu (`gcc-aarch64-linux-gnu libc6-dev-arm64-cross qemu-user`). Tests
  that need a missing tool skip themselves.

Build release binaries on GitHub runners with `cargo build --release`.
With the resulting `fwp` binary available, run `fwp run examples/hello.fwp`.
Use the bounded guard below for focused local checks.

## Before you open a pull request

Run focused checks locally through `python3 scripts/local-guard.py COMMAND...`,
serially and at low priority, with sampled resource monitoring. Stop at 1 GiB aggregate RSS, 2 GiB generated target
data, less than 64 GiB free disk or a 180-second workload deadline.
Full builds, full test gates, large evidence regeneration and benchmarks
belong on GitHub runners. A local refusal moves that work to CI; do not
raise limits to complete it. See [AGENTS.md](AGENTS.md) for session rules.

Audit the handoff and tracked Markdown links with
`python3 scripts/local-guard.py python3 scripts/check-roadmap.py`. A clean clone
needs full history and the immutable `roadmap/preparation-*` tags; fetch them
without force before checking. The audit verifies tag identity, ancestry, queue
order and whole commit messages. It also checks that plan and handoff step numbers agree and statuses use the
defined values. It does not establish that a recorded CI run passed; verify that
run separately against the actual commit being merged.
CI checks the actual PR head and fetches review
heads so merged preparation references remain available.
Retain any pre-amend revision referenced by a frozen documentation snapshot
under a remote revision tag before publication. A local object alone does not
prove that a fresh CI clone can resolve the recorded head.

During a combined delivery, draft PRs use explicitly dispatched focused checks.
Marking the PR ready runs the complete production matrix; every final-head
production job must pass before merge. Draft skips are never acceptance gates. For an
early native probe in `numerics.yml`, `native_runner` selects one runner instead
of the suite's matrix. Use `all` for complete evidence; report collectors still
require every expected native host. This does not change production acceptance.
For the `server-entries` suite, `server_entry_part=all` runs five parts on
each selected host. An explicit `checks` selection runs two jobs: entry/codec
checks and the larger REST API checks. Splitting them keeps the existing
25-minute limit without dropping tests. `api` runs only that API job. Neither
selection repeats unchanged memory measurements. Retain their original source
and verify that compiler/runtime/library and measurement behavior still match;
this selector does not reduce the required production matrix.
A `server-recheck` requires the full 40-character `source_revision`. It runs both
functional parts from that exact checkout and records it separately from the
workflow revision. Use it to repair a focused job's scheduling while preserving
a healthy production head. Audit both replacement jobs; a cancelled original
job is not a pass. All nine production jobs and docs still require the actual
PR head.

Windows dependency setup uses an exact cache key for each architecture and setup
script. The [dependency-only workflow](.github/workflows/windows-dependencies.yml)
builds and validates these dependencies on `main` after setup changes merge, so
later branches can reuse them. It also supports manual dispatch after cache
eviction. GitHub permits reuse from the default branch, but not between sibling
branches; see its [cache access rules](https://docs.github.com/en/actions/reference/workflows-and-actions/dependency-caching#restrictions-for-accessing-a-cache).
This workflow does not run compiler tests and is not a production acceptance
gate. Keep it running when cancelling duplicate postmerge production CI.
Native test jobs still validate restored libraries and their architecture.

CI runs these, and all of them must pass:

```
cargo fmt --all -- --check
cargo clippy --all-targets -- -D warnings
cargo clippy --target wasm32-wasip1 -- -D warnings
cargo test --all-targets
```

A separate CI job runs the C/Rust comparison
(`cargo test --release --test bench benchmarks -- --ignored --exact --nocapture`). It
reports times without failing on them, but it does fail when fwp, C and
Rust print different results.

All nine exact-head production jobs and the roadmap documentation audit are
required before merging: Linux ARM64/AMD64, bench, regular macOS arm64/x86-64 and separate
GC stress jobs on both macOS architectures, plus native Windows ARM64/AMD64.
The supported platform matrix is Linux, macOS and Windows on ARM64 and AMD64,
with separate binaries. The reusable Windows workflow runs both native Windows
architectures. Preserve the complete matrix for each accepted revision; see
[the platform matrix](PLAN.md#platform-objective-and-current-evidence).
Linux builds every Cargo test target once, then runs two test executables at a
time with one harness thread each. All Linux stress tests remain enabled. Each
executable has an uploaded log, and any failure fails the job. The runner checks
that Cargo produced every requested executable before starting tests. This
scheduling change passed PR #154's complete acceptance matrix; that establishes
coverage, not a measured speedup.

For each macOS architecture, the two jobs use the explicit integration-target
lists in `scripts/macos-test-shards.json`, read by `scripts/run-native-tests.py`.
List order is execution priority: long targets start early so one worker is less
likely to wait for the other's final target. The ordering comes from recorded
CI target times; [the scheduling estimate](docs/measurements/ci-scheduling-2026-10-18.json)
is a simulation using those times, not a measured speedup for the new order.
New targets must be assigned deliberately; adding one must not move unrelated
tests between jobs. Remove obsolete entries when deleting targets. The runner
rejects missing, duplicate, obsolete or unknown targets. Unit, example and
benchmark targets run in regular; the GC job also runs its separate stress suite.
Both ordinary shards skip `golden_programs_under_gc_stress` so that dedicated
stress invocation runs exactly once. Each shard builds its selected test
executables once, verifies Cargo produced every requested target, then runs two
executables concurrently with one harness thread each. Tests keep their existing
internal workers. Every executable gets a separate uploaded log; any failed test
fails the job after the remaining targets run. This avoids leaving the runner
idle between the many single-test executables. Target assignments stay fixed.
The macOS CI deadline is 150 minutes: the original PR #164 Intel GC job reached
90 minutes with 82 of 122 targets complete, two interrupted and 38 unstarted.
The larger deadline prevents losing another full run on a slow host; it does
not make tests faster or relax any assertion. Local resource limits remain
unchanged. Every delivery still requires its own complete passing matrix.

The documentation job verifies the real Cargo target set, artifact coverage,
assignment stability, concurrent execution and failure propagation. The stress
queue starts its two longest measured programs first; [the observed timings](docs/measurements/gc-stress-scheduling-2026-10-16.json)
explain that ordering without claiming a measured total-CI speedup.
[Recorded timings](docs/measurements/macos-shards-2026-10-16.json) explain the
initial balance, including the GC job's separate workload; estimates are not
passing gates or promises about future runner speed.
Optional-tool skips are not platform coverage. Some older memory suites
still require Linux `/proc` or `strace`; Darwin-specific regressions in
`tests/macos.rs` assert that collection is armed and really runs, rather
than accepting a stress variable with collection disabled.

Production CI builds the Rust compiler and test harnesses at optimization level 1
with debug assertions and overflow checks explicitly enabled. The measured selected tests run faster with this setting, while initial builds
take longer; see the [profile comparison](docs/measurements/ci-compiler-profiles-2026-10-16.json).
PR #152 passed the complete matrix within existing limits. This setting does not
change test cases, generated-C flags, stress settings or local Cargo defaults,
and does not guarantee the duration of future runs. [Cargo's profile settings](https://doc.rust-lang.org/cargo/reference/profiles.html)
define these independent switches.

CI runs a primitive inventory at the exact source commit
before the regular Linux and ARM/Intel macOS gates. Its standalone Rust reader
uses the actual ownership module; the Python audit compares declarations with
the immutable `tests/fixtures/primitive-inventory-baseline.json` baseline and
preserves observed rows on failure.
Run it through the local guard when its limits permit, or on GitHub:
`python3 scripts/check-primitive-inventory.py --baseline tests/fixtures/primitive-inventory-baseline.json --output /tmp/fwp-inventory.json`.
Inventory agreement
does not substitute for runtime alias/unwind controls or full CI.

## Rules the code follows

Generated-C probes must preserve platform setup before system headers. Add
instrumentation after an existing type or function declaration; do not prepend
headers ahead of the runtime's Windows API definitions. Use plain stable labels
for artifact filenames: Rust debug formatting adds quotes to strings, which
Windows paths and GitHub artifact uploads reject.

- **Leave encountered code healthier.** Fix discovered bugs and issues even
  when they are outside the current roadmap item. Preserve semantic regression
  controls and record validation in the handoff. Group coherent fixes without
  weakening the required CI gates or discarding the roadmap's priorities.
- **No third-party crates.** fwp depends only on Rust's standard library,
  with a vendored BSD-licensed [SoftFloat core](vendor/softfloat/README.md) for
  exact arithmetic and a scoped [gdtoa core](vendor/gdtoa/README.md) for exact
  decimal conversion under its Lucent license, plus Boost-licensed
  [TLFloat templates](vendor/tlfloat/README.md) for format-specific transcendental
  functions. Their licenses and the recorded
  source modifications accompany distributions.
  Building the compiler requires C11, C++20 headers/compiler support and an
  archiver. `CC` and `AR` select the C toolchain; `CXX` can select the C++ compiler
  separately. `CC_<target_with_underscores>` and `CXX_<target_with_underscores>`
  select compilers for a Rust
  target independently of the generated-program `CC`. Windows CI uses SDK-aware
  Clang for the Rust MSVC core and LLVM-MinGW for generated programs.
  The math object uses fixed-size integer storage and links without a C++ runtime.
  HTTP/2, gzip, protobuf, JSON and YAML are implemented here.
  The C runtime uses the C library, pthreads,
  OpenSSL (for TLS) and the OpenCL loader (for devices, loaded when used).
- **The interpreter is the reference.** Every feature works in both
  engines, the interpreter (`src/interp.rs`) and the C backend
  (`src/cgen.rs`, `runtime/*.c`), and the two agree byte for byte on
  stdout, stderr and the exit code. A change to one engine comes with the
  same change to the other. Optimizer changes also need an unoptimized
  reference: `FWP_NO_OPT=1 fwp run --interp program.fwp`, or interpretation
  of the original typed IR before the pass. Ordinary `--interp` also uses
  the optimizer, so agreement between optimized engines alone can miss
  a shared evaluation-order bug. Check observable traps as well as values.
- **Generics are explicit.** In `lib/` and in examples, every generic
  definition has a signature, because the compiler rejects a definition
  without one that would be generic. Generics select concrete code and trait methods at compile time, avoiding
  runtime method-table dispatch. Boxing, allocation and indirect calls can still
  exist at other boundaries
  ([docs/design.md](docs/design.md#generics)).
- **Measure abstraction costs.** Aim to remove extra runtime work introduced by
  convenient source constructs. Do not claim every abstraction is free: name the
  baseline, inspect generated code and measure equivalent workloads. The
  benchmarks in `bench/` show specific complete-program comparisons
  ([docs/benchmarks.md](docs/benchmarks.md)).
- **Errors say what to do.** A diagnostic points at the cause and, where
  there is one, gives the fix (the signature to write or the unsupported operation to replace).

## Tests

| Kind | Where | What it checks |
|---|---|---|
| Golden programs | `tests/run/*.fwp` with `.out` (and optional `.in`) | each program, interpreted and compiled natively (`tests/golden_run.rs`), with static memory (`tests/static_memory.rs`) and in WebAssembly where available |
| Type-check snapshots | `tests/check/*.fwp` with `.out` | inferred types, warnings and error messages |
| Parse and lint snapshots | `tests/parse/`, `tests/lint/` | the parser and `fwp lint` |
| Standard library | `test "…" = …` in `lib/*.fwp` | `fwp test --std` |
| Tutorials and examples | `docs/tutorials/*/`, `examples/` | each tutorial runs in both engines and prints its `main.out`, and its README shows only code from the program; the examples type-check |
| Features | `tests/*.rs` | the protocol, HTTP, TLS, gRPC, REST, CLI, FFI, the GC, the cache, the formatter, the language server, the browser build, … |

A snapshot is stored expected output. After an intended behavior change, regenerate
only the relevant snapshot and inspect the difference; blessing output does not
prove it correct. For the generated library reference, the focused command is:

```
python3 scripts/local-guard.py env FWP_BLESS=1 cargo test --test stdlib_doc
git diff docs/stdlib.md
```

`docs/stdlib.md` is generated from the comments and signatures in
`lib/*.fwp`. Edit those sources and the generator, never the output by hand.
Other snapshot targets use the same environment setting with their focused test;
full suites and large regeneration run on GitHub, not through a larger local limit. A declaration
with a `# internal` comment line above it, or a name with a part starting
with `_`, is left out.

To add a golden test, write `tests/run/name.fwp` and bless its `.out`.
Then check the output by reading it: a blessed file is only as right as
the person who reviewed it.

## Common changes

### A primitive

Primitives are the functions the standard library cannot write in fwp.
Each one is implemented in both engines:

1. Declare it in the module it belongs to: `foreign "fwp" name : Type`
   in `lib/<module>.fwp`, with a doc comment and a `test`.
2. Implement it in the interpreter (`src/prims_std.rs`, or the module for
   its area: `src/web.rs`, `src/linalg.rs`, …).
3. Implement it in C: a mapping in `src/cgen.rs` and, where needed, a
   function in `runtime/fwp_rt*.c`.
4. Add a golden program that uses it, so both engines are compared.

### Memory in the C runtime

Native tracing mode combines counted owners with a generational collector
(`runtime/fwp_rt_gc.c`). A young object has not survived collection; an old one
has. Minor collection avoids retracing immutable old objects, so its allocator
rules matter. Checked ARC excludes tracing but still uses allocator metadata.
Objects come in three kinds, and the generated code must use the right
allocator:

- `fwp_alloc_init`: values that are complete when allocated (records,
  variants, list cells). Compute every field first, allocate, then fill
  the object at once. Never write to it after that: an old object must
  never point to a young one.
- `fwp_alloc_leaf`: memory that holds no values (string bytes, numbers).
- `fwp_alloc`: memory filled after it is allocated (arrays, maps,
  partial applications). Every minor collection scans these.

`FWP_GC_VERIFY=1` checks each minor collection against a full trace, and
`FWP_GC_STRESS=1` collects at every allocation to expose missing roots.
Run the golden tests with both after you change the runtime or the code
generator.

Records and variants that compiled code allocates are updated in place
when they have a single reference (`fwp_rc_*` in runtime/fwp_rt_gc.c).
A runtime call must follow its contract in `src/ownership.rs`: some arguments
borrow, others transfer owners, and unproved retention promotes a graph to
runtime sharing with `fwp_rc_share`. Do not apply the shared policy to every
primitive indiscriminately. [Primitive ownership](docs/primitive-ownership.md)
explains the modes and callback obligations. `FWP_REUSE_VERIFY=1` poisons what would be reused, and
tests/reuse.rs runs every golden program that way.

### A benchmark

Add `bench/<name>/main.fwp`, `main.c` and `main.rs`, three programs that
compute the same result and print the same output. Check algorithms, data
structures, overflow behavior and eliminated work too: matching output alone
does not make timing an isolated language-overhead measurement. Record inputs,
hardware, compiler versions, flags, timing samples and timing scope. Run the
benchmark on GitHub. Then update
[docs/benchmarks.md](docs/benchmarks.md) with the results and an
explanation of any gap.

## Documentation

Write for a reader who knows programming but has not worked on this project.
Introduce a term or symbol before using it; do not make a glossary link carry the
whole explanation. Give the purpose and prerequisites first, then explain the
example's input, steps, output and limitations. Distinguish runnable programs,
tested terminal transcripts and incomplete reference fragments.

Use precise technical names when needed, followed by their meaning. Prefer
“a separate heap object” before “boxing,” and explain what an ownership boundary
transfers. Remove obsolete next actions instead of accumulating status paragraphs.
Keep historical test IDs and measurements in the evidence index, not in every
user guide. Preserve original measurement files rather than relabeling old data
as current results.

A user-visible change updates the reference, relevant guide and tutorials together.
Tutorial README source copies must match their files, and outputs must remain
explained as well as tested. Generated library docs come from source comments.
Comments can also become CLI help, MCP descriptions and OpenAPI documents;
when those comments change, regenerate the affected fixtures and run their
focused comparison tests without `FWP_BLESS` afterward.
For performance, name both implementations, equivalent work, timing scope and
extra cost as a ratio or percentage; state when a comparison cannot isolate
language overhead. “Fewer allocations” does not by itself mean “faster.”

## Commits and pull requests

Write the description for someone who has not followed the implementation.
Start with the problem and what changes for a program or its author. Explain a
concrete before/after example when it helps. Introduce necessary terms in place:
for example, explain that a reference count records how many owners still use a
value before discussing changes to that count. A list of internal function names
or compiler passes is not an explanation of the change.

Summarize validation and remaining limits separately from the changes. For a
benchmark, name the programs being compared, input sizes, what the timer includes,
and how to read the reported ratio. Keep source hashes, job IDs, failure history
and individual timing samples in linked evidence. State whether full CI is still
running. Rewrite the description around the final change before merging.

- Work on a branch and open a pull request against `main`.
- Pull requests are merged by **squash**. The title says what changed;
  the description explains why and how it was checked. Supply the
  squash subject explicitly and leave the commit body empty.
- Bundle related roadmap work and fixes discovered while testing into a
  reviewable delivery. Keep one delivery PR open at a time; avoid repeated
  full test cycles for fragments of the same change.
- Every commit message is exactly one line, at most 80 characters, with
  no body, trailers or AI attribution. When authorized to merge, wait
  for passing CI and squash-merge with an explicitly supplied subject
  and empty body; ordinary Git author metadata only.

## Vendored code and licenses

fwp is under the MIT license ([LICENSE](LICENSE)). Code or documentation
copied from another project ("vendored") keeps its own license:

- Put it in a file or directory of its own, with the original license
  text and copyright notice next to it.
- Say where it came from: the project, its URL, and the version or
  commit it was taken from. Note any changes made to it here.
- Only vendor what is under a license compatible with MIT, and say so in
  the pull request.

Contributions are accepted under the project's MIT license.

Native CI publishes `fwp-{Linux,macOS,Windows}-{ARM64,X64}` artifacts containing one
compiler archive for that OS/architecture. `scripts/package-native.py` checks
ELF/Mach-O/PE machine types (the native executable formats) and executes a copied compiler, raw interpreter and
tracing/ARC generated programs outside the checkout. The archive includes its
manifest and requirements: a system C toolchain for native compilation and
OpenSSL 3 for TLS. `iteration-evidence-*` retains C/disassembly and paired
measurements; `ownership-evidence-*` retains ARC and workspace controls.
