# Baselines for the remaining CPU gaps

This is the current B1/P1 work in [the plan](../../PLAN.md). Before changing the
compiler, measure two programs against their checked C/Rust implementations:

| Program | Work in every implementation | Question |
|---|---|---|
| `loop` | Count down from 100,000,000; add `(i * 3) % 7` each step | Does the recorded gap against Rust persist? |
| `text-length` | For 2,000,000 indices, count decimal digits in `i` and `3 * i`, plus one separator | Does the recorded gap against C persist? |

Signed arithmetic is checked in all three. The digit-counting peers avoid string
formatting, matching the work fwp can produce after eliminating temporary text.
[Peer controls](checked-peers.md) test overflow order and allocation failures.
Different generated instructions and runtime startup still contribute to elapsed
time; these are complete-program comparisons, not a universal language tax.

## Collect first, freeze second

The `cpu-baselines` runner suite builds the existing seven-peer comparison and
keeps its binary, output, arithmetic and memory audits. It adds repeated timing
only for the two programs above. Two independent jobs run on each Linux
architecture. Each job uses GCC O2, Rust optimized, counted ownership and no
link-time optimization. Execution explicitly allows all CPUs assigned to the
runner; it does not pin a core or fix CPU frequency. Compiler versions and flags are copied from the build
record, not guessed from the host. No previous fwp executable is needed to build.

Each program gets two warmups per variant, then 32 samples per variant. Order
rotates through C, Rust, fwp and a second execution of the **same fwp executable**.
That last variant is the noise control: identical code should take similar time.
The timer encloses process creation, runtime startup, all work, output and cleanup.
Compilation, JSON writes and memory profiling are outside the timer. Every sample
retains its status, output, error output, order, duration and binary hash.

Two stability checks are fixed before the run:

- The ratio between the two fwp medians must be at most 1.03.
- For each round, divide the longer identical-code time by the shorter. The
  nearest-rank 95th percentile of these ratios must be at most 1.10. This catches
  large variation that a ratio of medians could hide.

These are measurement-quality limits, not claims that every program may regress
by 3% or 10%. An unstable session is **inconclusive** and cannot set a budget.
Keep the failed observations and repair the measurement before proceeding.

[`cpu-baselines.py`](../../scripts/cpu-baselines.py) freezes a table only when all
four sessions are complete and stable. Each architecture's two sessions must use
the same CPU model, compiler versions, settings and source inputs. For each
program/host, let `d` be the larger session's 95th-percentile control deviation
from 1. The future candidate/baseline median ratio may be at most `1 + 2d`, and
its new identical-code control must stay within `1 + d`. For example, observed
control variation of 1.2% gives a 2.4% regression limit. These thresholds are
chosen from baseline evidence and committed **before** a candidate is measured;
they are never silently recomputed from candidate results.

Future speedup claims need baseline and candidate executions in the same job.
The two independent sessions establish repeatability and limits; comparing their
wall times directly does not isolate a compiler change. A changed CPU model or
benchmark contract requires a new, explicitly reviewed baseline.

## Memory and retained evidence

Three separate runs of each actual executable record peak process RSS. Separate
instrumented fwp binaries record managed allocation requests, requested bytes,
retains, peak managed charge and final charge. An injected leak must be detected.
These counts exclude raw runtime buffers, stacks and C/Rust allocation counts.
Instrumented images are never timed. Their compiler stack reports are retained,
but do not describe the uninstrumented executable's frame sizes. Actual timed
text sizes, binary hashes and source hashes remain linked to their original audit.

The reader rejects missing samples, changed order/output/status, false statistics,
changed binaries, duplicate sessions, different inputs/toolchains, missing memory
or stack records, and hidden inconclusive controls. Synthetic corruption tests
run in the documentation gate. Full platform tests remain separate acceptance
requirements; a baseline record is not a correctness test of all fwp programs.

## Status

The collector and rejection controls are implemented. The four native sessions
and frozen budget table are pending. No fresh ratio or compiler speedup is claimed.
