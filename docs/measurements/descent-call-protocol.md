# Measuring the remaining numerical helper call

The [borrowed-capture experiment](array-capture-descent.md) removes all retains
from packed gradient descent, but its largest case still takes 2.33–2.38 times
the C implementation's time. Saved GCC machine code calls a scalar derivative
helper inside the array-generation loop. This experiment asks whether removing
that call is worth a compiler change. It does not change fwp's compiler.

The [first result](descent-call-costs.md) did not meet the declared speed target;
no inlining rule was selected. The protocol below remains the original decision
rule, rather than a target adjusted after seeing measurements.

Inlining places a function's operations at its call site. Besides removing the
call, this may let the C compiler share loads and simplify bounds checks using
facts from the surrounding loop. It can also enlarge code and make instruction
caches less effective. We need both measurements before adopting a rule.

## Inputs and exact edits

The workflow uses the saved C and Rust sources from numerical run `39786472473`,
source `d1467854766fd93fa6e6c768d42f35e83fec3c1a`. It verifies the retained archive
and source hashes before compiling. No fwp build is needed for this diagnostic.

There are seven timed entries:

- The current packed fwp program's unchanged generated C.
- The same C with `inline` added to the named helper's declaration and definition.
- The same C with `inline` and `always_inline`, requiring GCC to inline that helper.
- A byte-identical copy of the unchanged executable under another filename.
- A byte-identical copy of the forced-inline executable under another filename.
- The accepted explicit C derivative program.
- The accepted explicit Rust derivative program.

The helper name `w36` is an explicit experiment input tied to the saved source,
not a compiler API or a general rule for choosing functions. The script requires
its exact scalar signature and edits only its declaration/definition. Arithmetic,
array checks, failure paths and all other source remain intact. Its result
contributes the right-hand part of the coordinate derivative.

Cases are 3 coordinates with 0, 1, 199 and 1,999 updates, plus 33 and 129 coordinates
with 199 updates. Every peer must reproduce its own complete accepted output.
The existing [comparison](descent-peers.md) explains the derivative and independent
oracle. C/Rust reuse two buffers while fwp creates an immutable array per update;
formatting also differs. C/Rust ratios include these implementation differences.

## Timing and storage

Linux AMD64 and ARM64 jobs rebuild every entry together using GCC O2 and explicit
baseline architecture, without fast-math or floating-point contraction. Rust uses
O2, generic CPU, checked overflow and no link-time optimization. Record hardware,
compiler versions, commands and compile times. No emulation establishes native
measurements.

Timing includes process startup, initialization, all updates, full output and
teardown. Compilation and instrumented profiles are excluded. Two warmups precede
56 samples per entry. The existing fourteen-round schedule balances positions and
ordered adjacent pairs within rounds, with shuffle seed 20261022. Cross-round
boundaries are not balanced. Preserve every sample and order.

Separate profiles for all three fwp variants must exactly reproduce the accepted
managed counts and raw derivative storage. Any output or storage mismatch fails
the job. Save actual binaries, disassembly, section sizes, process RSS and GCC
frame estimates, including dynamic-frame qualifiers. Inspect the artifacts before
using the result; a static call-site count is not a dynamic call count.

## Decision rule, recorded before measurement

The decision case is **129 coordinates × 199 updates**. An inline candidate only
passes the initial screen if:

- Both unchanged-code controls have median ratios within 0.98–1.02.
- Its median is at most 0.95 of the unchanged fwp executable's median.
- Its instruction-section size is at most 1.02 of the unchanged executable's size.
- All correctness and storage requirements pass for every input.

Require the screen on both architectures in two independent runs, matching CPU
models between repeats, before selecting a compiler optimization. One run is not
acceptance. A slower or inconclusive diagnostic is retained and does not justify
relaxing requirements. Report every smaller case, including regressions. No
universal timing threshold or C/Rust parity claim follows from this experiment.
If short-process noise defeats the controls, establish a longer equivalent-work
protocol before making a speed claim; do not silently change these inputs.

A bounded local Clang diagnostic preserved output and storage while forced
inlining removed four static call sites and added 144 instruction bytes. That
motivates this GCC experiment; it is not Linux timing or compiler-change evidence.
