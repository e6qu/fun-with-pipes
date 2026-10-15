# Project plan

The language and compiler work listed below is complete through
[PR #141](https://github.com/e6qu/fun-with-pipes/pull/141), merged as `41f30475`.
The current task is a complete documentation review for readers who are new to
this project. [The session handoff](docs/development-state.md) records progress,
checks and the next action. [Delivery history](docs/roadmap-history.md) keeps the
links proving which changes passed tests and merged.

## Direction

Keep the language simple to read as a sequence of pipes. Preserve strong type
checking, explicit generic signatures, immutable values, declared external
actions and the order in which operations run or fail. Prefer improvements
inside the compiler over extra syntax users must learn.

Reduce unnecessary memory allocation and runtime work. Reference counting is
supported for a checked subset of programs; universal collector-free execution
is not a completed feature. A feature described as “zero-cost” needs a specific
comparison showing that it adds no runtime work. [Benchmarks](docs/benchmarks.md)
explain actual comparisons and remaining overhead.

## Platform objective and current evidence

| Operating system | AMD64 (x86-64) | ARM64 |
|---|---|---|
| Linux | Native programs and compiler package tested | Native programs and compiler package tested |
| macOS | Native programs and compiler package tested | Native programs and compiler package tested |
| Windows | Native programs and compiler package tested | Native programs and compiler package tested |

Each combination has its own compiler binary. Tests run on that processor and
operating system, including execution of a packaged compiler outside the checkout.
A C toolchain is needed to compile native programs; encrypted networking needs
OpenSSL 3. This matrix does not promise every cross-compilation combination.

## Completed implementation work

| Step | Delivered work | What it means |
|---|---|---|
| 1 | Documentation and session notes | A single plan and handoff record what is done and what still needs work. |
| 2 | Reference-counted memory | More kinds of values and resources can release memory without tracing garbage collection. |
| 3 | Less intermediate work | Eligible array pipelines, loops and numeric calls avoid temporary objects or indirect calls. |
| 4 | Derivatives of derivatives | Automatic differentiation supports nested derivatives and optional recomputation to save history storage. |
| 5 | Additional floating-point formats | F16, BF16 and F128 have their declared rounding and arithmetic behavior. |
| 6 | Windows on both processor families | Native programs and packaged compilers pass on AMD64 and ARM64. |
| 7 | Smaller derivative workspaces | Backward differentiation avoids storage and scans that cannot affect the requested result. |
| 8 | Less recorded derivative data | Operation records no longer reserve unused entries for original inputs. |
| 9 | Fewer bookkeeping reallocations | The table of active derivative recordings grows in larger chunks and preserves reusable buffers. |
| 10 | Less bookkeeping search | Creating a derivative recording skips table entries already known to be unavailable. |
| 11 | Fewer derivative-buffer allocations | Parent-index buffers share a block, as do numeric derivative buffers; payload sizes are unchanged. |

The measurement and memory guides state the limits. Some values still need heap
objects, some callbacks still use indirect calls, and the compiler rejects
programs with unproved memory lifetimes in checked reference-counting mode.
There is no claim that every fwp program matches C or Rust speed.

## Current work

| Step | Work | Done when |
|---|---|---|
| 12 | Rewrite documentation for new readers | All guides, tutorials, examples, generated library docs and tracking docs have been reviewed; new terms are introduced; benchmark baselines and overhead are explicit; links, examples and required CI pass |

Cover the whole documentation set in one pull request:

1. Give readers a clear starting point and explain recurring vocabulary.
2. Explain each tutorial's prerequisites, new notation, program and output.
3. Add an example-application guide and explain unfamiliar features in examples.
4. Rewrite technical guides around purpose, behavior and limits; retain precise
   implementation details where maintainers need them.
5. Explain each benchmark's baseline, measured work, overhead and limitations.
   Separate C/Rust comparisons from comparisons between fwp implementations.
6. Remove outdated next actions and unsupported claims; preserve historical
   evidence through clearly labeled archive links and unchanged preparation IDs.
7. Run focused documentation checks locally and the complete required checks on
   GitHub, then publish and squash-merge under the existing authorization.

## Syntax decisions to preserve

`x | f` passes a value to a function; `f | g` combines two functions. Arguments
come before the data being transformed. Calls use prefix notation, such as
`add 1`; pipes remain between stages. Parentheses delimit nested arguments.
Keep both `if` and `match`, explicit `const` for constant functions, and `()`
for the unit value. Tuple positions start at zero. Iteration and state helpers
remain library functions. No new colon application or indentation-based argument
groups are planned.

## Delivery rules

Follow [AGENTS.md](AGENTS.md) and [Contributing](CONTRIBUTING.md). All nine
production jobs and the documentation audit must pass for the exact commit
being merged. A skipped or cancelled job is not a passing check. Squash messages
have one line, at most 80 characters, with no body or attribution trailers.

Local checks use `python3 scripts/local-guard.py COMMAND...`. Full builds, full
suites, benchmarks and large regeneration run on GitHub. Keep the guard's fixed
limits: at least 64 GiB free disk, generated target data below 2 GiB, sampled
workload resident memory below 1 GiB and a 180-second deadline.
