# Remove the redundant cleanup record before accepting pair reuse

Declared before the repair. Original measured source:
`a1f189478abadf0da30d8386bee2bc234e0668cf`, runtime run
[42005111118](https://github.com/e6qu/fun-with-pipes/actions/runs/42005111118).

## Observed problem

Three complete runtime sessions report 23 missed 5% speed targets and one stack
failure. AMD64 session 1, 33 coordinates/199 updates, current-result form has a
928-byte largest static frame; the allocating reference has 720 bytes. The allowed
increase is 128 bytes, so the limit is 848 bytes. This is a structural acceptance
failure, not an accepted timing miss. Original samples and failures remain.

AMD64 session 2 never measured: runs 42005111118, 42008084704, 42008513001 and
42009708231 rejected EPYC 9V74/9V45 before building; the frozen host is EPYC 7763.
Stop requesting the old candidate: repair its stack cost first.

## Source change to test

The generated helper protects the input with an owner/cleanup record, creates a
second owner/cleanup record for the same buffer, then clears the first owner.
Only one allocation needs protection on the reuse path. Keep the first owner
through mapping and return it directly. The allocating path still needs two
protected allocations, including when `FWP_NO_REUSE` is explicitly enabled.

This removes redundant source-level cleanup storage and an owner transfer.
It is a candidate explanation for the stack growth, not proof of the compiler's
frame decisions. Do not infer a cause from disassembly or relax the stack limit.

## Verification sequence

1. Update source-selection controls and native cleanup cases together. Confirm
   failure/cancellation, aliases, unequal widths, empty inputs, bits and no-reuse
   on the three focused hosts at production settings.
2. Compile the same six complete workloads and both forms with GCC O2 on both
   architectures. Record actual stack usage before requesting runtime timing.
   Require the existing reference +128-byte bound. Keep emitted C and images.
3. Recheck exact counts/phase peaks and compiler costs for the changed source.
4. Only then collect two qualified runtime sessions per architecture, preserving
   every outcome. The source change justifies a new experiment; it does not erase
   the first experiment's 23 timing misses or stack failure.
5. Retain audits and pass all nine final production jobs plus documentation.

All original proof, numerical, cleanup and measurement limits remain unchanged.

## What the stack comparison establishes

GCC's `.su` report lists a byte count and a qualifier for each function:

- `static`: the frame has a fixed size.
- `dynamic,bounded`: GCC can bound its variable-size storage.
- `dynamic`: the byte count covers only the known portion.

The frozen rule compares the largest reported byte count against reference +128,
retaining every entry. It does **not** bound total call-chain stack use or the
variable portion of a `dynamic` entry. The existing function dispatcher uses an
argument array sized by function arity; reuse does not change that source.
The saved-data audit lists dynamic entries explicitly rather than treating their
reported numbers as total frame sizes. See [GCC's stack report documentation](https://gcc.gnu.org/onlinedocs/gnat_ugn/Static-Stack-Usage-Analysis.html).

Run 42015900941 passes both architectures at 373955e8: all 12 largest reported
counts equal their references. The formerly failing AMD64 33/199 current case
is 720 bytes rather than 928. Full saved-data audit and timing remain separate
requirements.
