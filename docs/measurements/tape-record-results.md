# Tape records: measured results

**All 32 long-case comparisons miss the required 5% speed improvement.**
The compiler-cost comparisons pass. The runtime archive audit is pending; keep
these results and do not repeat unchanged timings for a passing outcome.

## What was compared

Both programs use compiler source `621653b6394f49dc229a2956b6b61476c82c9aac`.
Only the runtime tape section differs:

- **Candidate:** one 24-byte record per numeric operation, in one buffer.
- **Reference:** the #266 layout, with parent and weight columns in two buffers.

Each runs the same Rosenbrock gradient updates. The six inputs are 3 coordinates
with 0, 1, 199 or 1,999 updates, plus 33 or 129 coordinates with 199 updates.
The current form returns final coordinates; the history form computes successive
values and selects the last. Unused history may be optimized away.

Each session measures both forms with two warmups and 98 balanced rounds;
each sample uses seven fresh processes. See the [frozen contract](tape-operation-records.md)
for batch sizes, flags, allocation checks and timing scope. Small cases check
regression; the four positive long cases × two forms × four sessions give the
32 speed targets.

## Runtime

[Producer run 42369288345](https://github.com/e6qu/fun-with-pipes/actions/runs/42369288345)
completed every session. All four jobs report failures only at the final speed
acceptance check. No small-case or identical-copy failure appears in those lists.
The [complete archive audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42370476364)
must verify the full observations before acceptance.

Negative elapsed-time change means faster; positive means slower.

| Session / actual CPU | Long-case elapsed-time change | Targets meeting 5% |
|---|---|---|
| ARM64 1, Neoverse-N2 | −3.58% to −0.71% | 0/8 |
| ARM64 2, Neoverse-N2 | −3.54% to −1.19% | 0/8 |
| AMD64 1, EPYC 7763 | −2.90% to +1.35% | 0/8 |
| AMD64 2, EPYC 9V74 | −2.06% to +0.96% | 0/8 |

ARM64 used GCC 13.3.0; AMD64 used GCC 15.2.0. The separate C/Rust programs
calculate handwritten derivatives. Their absolute times, process memory and
ratios remain in the producer archives and must be tabulated after the audit.
The table above compares two fwp layouts; it does not establish C/Rust parity.
Fewer growth requests alone establish neither a speedup nor lower process RAM.

## Compiler cost

[Run 42369286155](https://github.com/e6qu/fun-with-pipes/actions/runs/42369286155)
passes both architectures. Its [complete archive audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42369871217)
passes all 14 comparisons: seven workloads per architecture, 336 scheduled
compiler commands and six untimed checks each. It verifies source/reference
files, images, commands, samples and host qualification.

The workloads cover field transfer, the autodiff tutorial, zero-update and
33/129-coordinate derivatives, repeated scopes and a large scoped worker.
The compiler emits C at the production settings; this measures compiler work,
not execution speed of the emitted program. Each version has two identical
copies. Copy variation must stay within 2%; compiler time and peak resident
memory must stay within 5% of the reference.

| Native host | Compiler elapsed-time change | Largest peak-RSS increase | Result |
|---|---|---|---|
| ARM64, Neoverse-N2 | −0.114% to +0.273% | 0.055% | All seven pass |
| AMD64, EPYC 9V74 | −0.424% to +1.290% | 0.168% | All seven pass |

Audit artifact `13573526746` contains the complete reports and 1,081 retained
observation files per architecture. Its SHA-256 is
`7feefbf33963f2c62ca4ee46929c6b8e28862d6b74aee71de899c1c29f780acc`.
[All compiler records are retained](tape-record-analysis-2026-11-07/README.md);
the archive digest and 2,162 observation-file hashes pass local verification.

## Remaining acceptance

- Finish runtime archive auditing and retain all samples, counts and misses.
- Report absolute C/Rust costs, allocation traffic, live storage, process memory,
  executable size and stack usage; distinguish each quantity.
- Verify original measured executables and final follow-up PR gates.
- Use the saved phase/work records and source paths before proposing another
  optimization. This layout does not close its speed target or earlier misses.
