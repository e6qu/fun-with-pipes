# List iteration compared with its previous definition

Historical measurements at the revisions named below. Counts and timings are
observations of those programs, not current compiler budgets. Commands refer
to the recorded measurement revision. Read [measurement terms](../benchmarks.md)
for timing and memory boundaries; [the plan](../../PLAN.md) owns remaining work.

`each` calls a supplied function for every list element and returns `()`, meaning
no result. Its previous definition used `map`, which builds a list of results,
then discarded that list. The replacement walks the input with `fold`, keeping
only a running value of `()`. Both must perform the same calls in the same order.

The comparison counts elements using integer state:

```fwp
main = range 0 3 | run-state 0 (each (const (add 1) | modify)) | .1 | echo
```

`|` sends a result to the next function. `range 0 3` produces three integers.
`const (add 1)` ignores each integer and supplies the increment function to
`modify`, which updates the current state. `run-state 0` starts that state at zero
and returns `(result, final-state)`. Positions start at zero, so `.1` selects the
final count and `echo` prints `3`.

[`measure-list-each.py`](../../scripts/measure-list-each.py) compares both definitions
at 10,000, 100,000 and 1,000,000 elements on Linux runners. It records seven samples
in alternating order after a warmup. Timing includes process startup, input
construction, updates, printing and cleanup. Both use the same C compiler and
`-O2`, with tracing disabled and ordinary freeing enabled. The report also records
peak process memory, build commands/times and binary sizes. Separate 32/128-element
tests count allocations without contaminating timed executables with counters.

The [accepted comparison](service-context-iteration-2026-10-16.json)
at `20f0f5f0` passes the focused checks on all six native hosts. At one million
elements, the Linux medians are:

| Host | Previous definition | Current definition | Less elapsed time | Peak memory, previous/current |
|---|---:|---:|---:|---:|
| AMD64 | 56.93 ms | 27.30 ms | 52.1% | 79,216 / 37,648 KiB |
| ARM64 | 66.70 ms | 32.80 ms | 50.8% | 77,496 / 35,632 KiB |

Separate instrumented runs show one fewer allocation and 32 fewer requested
bytes per element: a 24-byte result node and eight bytes of temporary array space.
The input list still allocates. Actual binaries contain checked increments with
no per-element callback dispatch in the counting loop. Finding the current state
owner and conditional cleanup still cost work; this is not a zero-cost state claim.

The [earlier comparison](service-context-iteration-baseline-2026-10-16.json)
retains the initial regression: removing the result list alone made the million-
element program 16.6% slower on AMD64 and 11.8% slower on ARM64. Specializing the
known callbacks and keeping their captured values outside loops resolved that
regression. These comparisons are between fwp definitions, not against C/Rust.
They establish results for this workload and these runners, not every use of `each`.

To reproduce the six-host service and iteration measurements, dispatch
`.github/workflows/numerics.yml` with `suite=context-owners` on the source branch.
The tests upload counts, generated C, executables, environment details and Linux
timing samples. Once all six native jobs pass,
[`collect-service-measurements.py`](../../scripts/collect-service-measurements.py)
checks the run and creates the report. Supply its exact commit with `--head`,
the workflow number with `--run`, a download directory with `--artifacts`, a
report path with `--output`, and `--capture-requests 1 --each-comparison` for the
current implementation. It uses authenticated `gh`; it does not run downloaded
executables. Local collection goes through the repository's resource guard.
