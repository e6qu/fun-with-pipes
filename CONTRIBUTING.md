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
accepted evidence; [preparation commits](docs/preparation-records.md) are historical
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
  (Debian/Ubuntu: `clang-18 llvm-18 lld-18 wasi-libc libclang-rt-18-dev-wasm32 libc++-18-dev-wasm32`), the
  matching LLVM 18 executables on `PATH` (`/usr/lib/llvm-18/bin`) and
  `FWP_WASM_CC=/usr/bin/clang-18`. CI uses `scripts/setup-wasi-linux.sh` to keep
  compiler, linker and runtime libraries aligned. Also install the
  `wasm32-wasip1` Rust target (`rustup target add wasm32-wasip1`), node 24,
  and binaryen's `wasm-opt` (`npm install -g binaryen`).
- Optional, for the cross-compilation tests: an aarch64 C compiler and
  qemu (`gcc-aarch64-linux-gnu libc6-dev-arm64-cross qemu-user`). Tests
  that need a missing tool skip themselves.

Build release binaries on GitHub runners with `cargo build --release`.
With the resulting `fwp` binary available, run `fwp run examples/hello.fwp`.
Use the bounded guard below for focused local checks.

## Before you open a pull request

Use `python3 scripts/local-guard.py COMMAND...` for serial, focused local checks.
Its fixed limits are 1 GiB sampled aggregate RSS, 2 GiB generated target data,
64 GiB free disk and 180 seconds. If refused, move the workload to GitHub.
Full builds, suites, benchmarks and large regeneration belong on runners.

Run `python3 scripts/local-guard.py python3 scripts/check-roadmap.py` for Markdown
links, plan/handoff agreement and preparation identities. A clean clone needs
full history and the immutable `roadmap/preparation-*` tags, fetched without
force. Referenced pre-amend revisions need remote retention tags; local objects
alone do not make a fresh clone reproducible. This audit checks commit messages
and ancestry, not whether a linked CI job passed.

CI requires these checks with the supported tools installed:

```sh
cargo fmt --all -- --check
cargo clippy --all-targets -- -D warnings
cargo clippy --target wasm32-wasip1 -- -D warnings
cargo test --all-targets
```

Production builds the compiler/test harness at Rust O1, with debug assertions and
overflow checks enabled. Tests still select their explicit generated-C levels.
Use the same production compilers for focused probes: Clang success does not
verify GCC behavior. Running saved generated C also does not compile/lint the
Rust test that produces it or verify artifact export.

All **nine production jobs and documentation** must pass for the exact final head:

| Jobs | Coverage |
|---|---|
| Linux AMD64 and ARM64 | Native suite, full golden corpus and the declared WebAssembly tests |
| macOS AMD64 and ARM64, regular and ownership jobs | Four jobs whose explicit test assignments together cover each architecture |
| Windows AMD64 and ARM64 | Two native jobs, including library/TLS/packaging checks |
| C/Rust benchmarks | Equivalent-output checks, paired arithmetic controls and retained measurements |
| Documentation audit | Links, immutable records, tutorial copies and test-runner/evidence controls |

A skip, cancelled job, emulated execution or draft-PR skip is not a passing gate.
Draft PRs use dispatched focused checks; marking ready starts the full matrix.
Before a repair push, audit every failed job and completed target, then batch all
known fixes. Preserve a passing final head while its remaining gates run.

### Focused runner checks

[The `ownership-analysis` suite](.github/workflows/numerics.yml) runs
only the paired compiler-analysis experiment on Linux and Intel macOS. Use it
when updating [G2 evidence](docs/measurements/ownership-analysis.md); it does not
replace the production correctness gates.

`Numerical and ownership evidence` in `.github/workflows/numerics.yml` exposes
named suites; use that workflow's inputs and the relevant measurement protocol.
Each suite declares its own host matrix. Where it supports `native_runner`, a
selected host narrows that matrix and `all` uses the suite’s complete matrix.
Functional probes run on two Linux hosts; analysis runs on Linux and Intel macOS.
The `kernels` and `queued-sockets` suites also include their declared WebAssembly
jobs. None of these selections replaces the nine production acceptance jobs.

For `server-entries`, `server_entry_part=all` runs five parts per selected host.
`checks` runs both functional jobs (entry/codec and REST API); `api` runs the API
job alone. Unchanged measurements retain their original source IDs and must be
checked for applicable source equivalence. `server-recheck` requires a full
`source_revision`: record that tested checkout separately from workflow source.

Run explicit integration targets on a runner with:

```sh
python scripts/run-native-tests.py --targets aot std_tests --idle-timeout 600 --logs command-tests
```

The runner audits the Cargo target inventory and rejects unknown/repeated names.
Production Linux runs two executables at a time with one harness thread each;
macOS/Windows use their declared assignments. The production idle timeout is
1,800 seconds. Only completed test cases renew it. A timeout kills the process
group/tree, records failure and lets remaining targets run. Synthetic stuck-child
controls check that behavior. Keep every test's log and artifacts, including
partial results on failure; a completed test step cannot turn a cancelled job
into a pass.

Production/focused jobs fetch locked Cargo dependencies first, then compile/test
offline. A fetch failure is a failed job. Windows caches use exact architecture
and setup-script keys. The dependency-only workflow populates main's caches after
setup changes; keep it running when cancelling duplicate postmerge CI. Restored
libraries still require architecture and execution checks. It is not a compiler
acceptance gate.

### Contract and evidence checks

Before changing primitive contracts, run this on a runner or through the local
guard if it fits:

```sh
python3 scripts/check-primitive-inventory.py --baseline tests/fixtures/primitive-inventory-baseline.json --output /tmp/fwp-inventory.json
```

The reader uses the actual ownership module. The audit compares declarations,
symbols and aliases with the frozen baseline and preserves failed observations.
It does not replace alias, failure, cancellation and runtime cleanup tests.
New test targets also need the native shard-coverage check; do not omit them
from a platform to shorten its gate.

For memory/representation changes, keep actual C/binaries, source/toolchain IDs,
complete measurements and independent review. Deliberately broken controls must
fail their intended observer. Require the complete golden corpus, reuse and physical-release controls, and
[ownership checks](PLAN.md#1-remove-tracing-gc) for failures and cancellation.
Optional-tool skips do not establish platform support.

The separate benchmark job runs
`CC=gcc FWP_LTO=0 cargo test --release --test bench benchmarks -- --ignored --exact --nocapture`.
It fails on different program results, but currently reports rather than gates
on timing. [The benchmark guide](docs/benchmarks.md) defines what each comparison
includes; [B1–B2](PLAN.md#7-reproducible-comparisons) define the remaining budgets.

## Rules the code follows

Generated-C probes must preserve platform setup before system headers. Add
instrumentation after an existing type or function declaration; do not prepend
headers ahead of the runtime's Windows API definitions. Use plain stable labels
for artifact filenames: Rust debug formatting adds quotes to strings, which
Windows paths and GitHub artifact uploads reject.
Give native probe executables an explicit `.exe` suffix on every platform and
use that same path for compilation, execution, inspection and copying. Windows
can infer the suffix when launching a program; symbol readers and file APIs cannot.

- **Leave encountered code healthier.** Fix discovered bugs and issues even
  when they are outside the current roadmap item. Preserve semantic regression
  controls and record validation in the handoff. Group coherent fixes without
  weakening the required CI gates or discarding the roadmap's priorities.
- **Dependencies.** The compiler uses Rust's standard library; native terminal
  editing and interrupt handling also use Rustyline and ctrlc, declared in
  `Cargo.toml`. Numerical support includes a vendored BSD-licensed
  [SoftFloat core](vendor/softfloat/README.md) for
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
  OpenSSL for TLS.
- **Compare the execution engines.** For shared language features, compare
  the interpreter (`src/interp.rs`) and generated C (`src/cgen.rs`,
  `runtime/*.c`): stdout, stderr, exit status and cleanup must agree.
  Host interfaces and debugger execution have documented capability limits;
  do not claim that every interface exists in both engines. Optimizer changes also need an unoptimized
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
| Features | `tests/*.rs` | the protocol, HTTP, TLS, gRPC, REST, CLI, FFI, memory ownership, the cache, the formatter, the language server, the browser build, … |

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

Native values have checked owners. The allocator in `runtime/fwp_rt_heap.c`
provides three initialization policies: `fwp_alloc_init` expects the caller to
fill a value before publishing it, `fwp_alloc_leaf` zeroes requested bytes, and
`fwp_alloc` zeroes mutable storage including its slot padding. These policies
choose storage and initialization; they do not discover roots or collect cycles.

Generated cleanup releases values by their types. A runtime call must follow its
contract in `src/ownership.rs`: some arguments borrow, others transfer owners.
[Primitive ownership](docs/primitive-ownership.md) explains callback obligations.
Check aliases, construction failures, cancellation and physical release together;
[ownership diagnostics](docs/ownership-diagnostics.md) gives the fault controls.
The copy control `FWP_NO_REUSE` retains counts and cleanup while disabling
in-place reuse in generated C.

`FWP_ALLOC_STATS=1` reports allocation and live-storage bytes separately from
whole-process RSS. Keep the strict report parser and failure controls in sync.
Full suites run on GitHub. Preserve the verified collector-free native targets
and binary-absence checks; see the handoff.

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
generated programs outside the checkout. The archive includes its
manifest and requirements: a system C toolchain for native compilation and
OpenSSL 3 for TLS. `iteration-evidence-*` retains C/disassembly and paired
measurements; `ownership-evidence-*` retains ARC and workspace controls.
