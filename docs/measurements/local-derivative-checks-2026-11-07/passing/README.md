# Local derivative correctness passes on three native hosts

[Run 42413370794](https://github.com/e6qu/fun-with-pipes/actions/runs/42413370794),
source `0ddde8224c3ab39e9ef4d9770483a72372b17c42`, passes all three focused checks:
Linux ARM64/AMD64 with GCC and macOS ARM64 with Clang. Formatting also passes.

Each host checks six numerical/alias examples, a failing callback and a case
where both neighboring callbacks fail. The latter must report the preceding
edge's error first. Native `-O2` behavior agrees with the unoptimized interpreter.
The [nine saved probes](index.json) include C, executable, stdout, stderr and
exit status; the ZIPs also contain source/compiler identities and full semantic
logs. Separate compressed files retain complete job logs. A guarded check verified
all outputs, source identities, formatting and absence of tape calls (0.20 s).

## What the generated C shows

The generic gradient helper still constructs records for `Dual` inputs and
calls its supplied function through `fwp_apply_owned`. The edge worker itself
returns its two scalar fields directly. The C contains no derivative tape calls.

That is a reason to inspect dispatch and record allocation, not proof of their
elapsed cost. This probe deliberately exercises several different callbacks.
The complete-solve candidate instead supplies one known edge function; its
compiler output and measured allocation counters must be reviewed separately.
Do not assume either path is allocation-free, or infer a speedup from no tape.

The later [runtime sessions](../../computed-numeric-time-2026-11-07/README.md)
and [final delivery](../../computed-numeric-delivery-2026-11-08/README.md) are
recorded separately. These focused checks alone establish no timing improvement.
