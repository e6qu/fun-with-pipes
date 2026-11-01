# Separating repeated work from process-startup noise

The [direct-call comparison](direct-call-entries.md) found differences of up to
22% between byte-identical executables in short runs. This experiment asks whether
repeating complete solves in one process makes the timing controls dependable,
and whether the apparent slowdowns remain. It does not replace those single-solve
results or change the language/compiler.

## Work and source edits

Use the inspected generated C and peer sources from run `39806328073`, compiler
source `e681dc447039cd1ce5fbf4a27add9e96f9238275`, verified by archive/source hashes.
Each process performs **512 independent complete solves** of the same input:
3 coordinates with 0, 1, 199 or 1,999 updates; 33 or 129 coordinates with 199 updates.
Each solve creates its original input, performs every update, prints the complete
result and releases its values. Do not concatenate update counts: every solve
starts again from the original vector.

For this saved fwp program only, replace the single cached main invocation with
512 direct calls to its numerical entry. Require that it has no other cached
top-level computations and no constant initialization work. Runtime initialization
and final teardown occur once per process.

In C and Rust, name the original main
body `workload` and call it 512 times, preserving error returns. The compiler may
optimize the harness under the same O2 flags; inspect its generated machine code.
No derivative, arithmetic, bounds check, allocation or output statement is edited.
Every output must equal the accepted complete single-solve output repeated 512 times.

The six timed entries are old packed fwp, new packed fwp, one byte-identical copy
of each, explicit C and explicit Rust. AD and list-fwp costs remain in the original
comparison; this experiment diagnoses the packed compiler change only. Existing
buffer-allocation and formatting differences remain explicit costs of each peer.

## Timing and controls

Run on native Linux AMD64 and ARM64 with GCC O2, baseline architecture, no fast-math
or floating contraction, and Rust O2/generic CPU/checked overflow/no LTO. Record
CPU models, compiler versions and full commands. Four warmups precede **48 samples**
per entry. A six-round schedule balances each position and every ordered adjacent
pair within the block; shuffle blocks with seed 20261022.

Cross-block boundaries
are not balanced. Time the whole process, including all output, initialization and
teardown; compilation and instrumented profiles are separate. Dividing by 512 is
amortized per-solve time, not the startup cost of a standalone program.

Both identical-code ratios must lie within 0.98–1.02 for a case to have stable
controls. Preserve every failing control and slowdown. Compare at least two
independent runs on matching CPU models before claiming a repeatable compiler
speed change. Stable controls in one run do not establish a speed improvement;
this protocol sets no optimization speed target.

Separate old/new fwp profiles must match each other exactly, retain zero counts,
end with zero managed/raw storage and perform no tracing collections. Each managed
peak must stay within its corresponding single-solve peak; requests/bytes must not
exceed 512 times that single-solve profile. Verify repeated output and raw storage
before timing. Fail immediately on incorrect output, broken cleanup or tool errors.
Save all binaries, instructions, GCC static/dynamic frames, process RSS and commands.
These are repeated-process-work measurements, not a claim of pure arithmetic time.

## Storage between solves

Profiled runs now record managed live bytes and raw derivative bytes immediately
after every complete solve, before the next solve starts. Both must be zero for
this pure explicit-derivative program. These observations are excluded from timing;
the timed executable keeps the original workload and repeated output.

The 33-coordinate, 199-update case has two additional controls for each compiler.
One allocates a small owned string before the loop and deliberately retains it
until final cleanup. The between-solve observer must detect its live storage on
the first solve and exit with status 225.

The other makes the same delayed release
but omits the between-solve observer: it must complete with zero final storage.
Together they show why a clean exit alone cannot establish bounded idle storage.
The observer checks every solve, not selected samples. The raw-storage check here
covers this explicit numerical program; it is not evidence for arbitrary AD tapes.

These controls add four untimed images in that case: 52 images per host across
all six inputs. The initial run at `b9ff767c5ab3642ac4bc26ae2ae6153f20560d3b`
predates these observations and has 48 images per host. Preserve that distinction
in reports; its final-only profiles do not verify the new observer.
