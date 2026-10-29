# Test whether checked arithmetic hides useful numeric bounds

**Historical experiment; neither candidate was adopted.**

The current integer-loop machine code keeps its state in registers and makes no
heap request in the measured scope. Yet it still checks subtraction and
multiplication on every iteration, although the starting bound makes those
particular overflows impossible. A possible cause is lost information between
GCC's checked-arithmetic builtin and its returned result. This is a hypothesis,
not permission to remove overflow checks.

## Candidate and safety condition

The existing signed multiplication code checks for overflow, then returns `x*y`.
The compiler can retain more information about that expression than about the
builtin's output variable. This experiment tries the same form for subtraction,
and separately for both addition and subtraction:

```c
int64_t x = (int64_t)l1, y = (int64_t)l0, r;
if (__builtin_sub_overflow(x, y, &r)) fwp_trap_overflow("I64");
return (V)(x - y);
```

The check must terminate execution on overflow. Only its successful continuation
may evaluate `x-y`. Both operands are already evaluated values; the change must
not reorder user effects or traps. The experiment edits saved generated C for
I64/ISize wrappers only. It does not change the compiler or other integer widths.
An experiment result alone cannot establish full semantic or platform acceptance.

## Measurement fixed before results

Use the same seven [complete programs](../benchmarks.md#what-each-program-actually-does)
and explicit ARC/O2 settings. Rebuild the unchanged generated C, copy its exact
binary as an identical control, and compile both expression candidates with the
same GCC flags. Retain all source, commands, binaries and compiler stack reports.

On every CPU allowed to the Linux runner, warm each executable twice and take
32 samples per variant. Rotate and reverse order so all four variants occupy
each position equally. Verify output on every run. Keep every sample. Record
complete-process elapsed time and child user+system CPU time separately;
startup, output and shutdown are included, compilation excluded. CPU placement
does not control frequency or virtualization load. Different CPUs within one
runner are not independent machines.

The screen requires, for both time measures on every measured CPU:

- Identical-control ratios within 3% of the unchanged binary. Otherwise that
  result is inconclusive.
- At least 5% less time for `loop` on both native architectures.
- No more than 3% extra time in any of the other six programs.

An inconclusive or failed screen does not fail correctness CI, and does not
justify a compiler rule. Review the actual machine code and stack/code-size
costs before selecting any candidate. Full language/native tests remain required
if an implementation change follows. This compares fwp with unchanged fwp;
it cannot establish parity with C/Rust or isolate universal language overhead.

## Historical reproduction

This experiment is closed; its runner command is removed from the current
workflow. The old reader required the retired `memory: arc` report schema.
Use the [original source and workflow](https://github.com/e6qu/fun-with-pipes/tree/18ac20729402002fdea691ac6a5d5b4aab42678e)
when reviewing how the recorded experiment ran. Its
[collector](https://github.com/e6qu/fun-with-pipes/blob/18ac20729402002fdea691ac6a5d5b4aab42678e/scripts/measure-checked-bounds.py)
and [subsequent review reader](https://github.com/e6qu/fun-with-pipes/blob/2520d136b7036ab878cac0ef48947b581c81b84a/scripts/inspect-checked-bounds.py)
remain available at their original revisions; they are not maintained current commands.
The [reviewed result](checked-bounds-results.md) fails the combined two-host
screen. No arithmetic compiler change was selected. New work uses the
[frozen CPU limits](cpu-baselines.md), without resetting the old verdict.
