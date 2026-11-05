# First pair-reuse runtime comparison: stack repair required

The original implementation does **not** meet acceptance. Three measured sessions
miss 23 of the 24 required 5% gains. AMD64 33/199 current also exceeds the stack
limit: 928 bytes versus a 720-byte reference, with only 128 bytes of growth allowed.
Copy controls and small-case regression limits pass. Counts and cleanup pass.
The [single-owner repair](../packed-pair-cleanup-repair.md) addresses redundant
cleanup storage before further timing; these original results remain unchanged.

## Compared work

Source `a1f189478abadf0da30d8386bee2bc234e0668cf`; the reference disables only
pair-buffer reuse. Both compilers keep consuming ownership and record/reverse
the same derivatives. This measures one storage change, not fwp versus C overhead.

Each case lists coordinates/updates. “Current” loops to the final coordinates;
“history” requests successive vectors and selects the last. The compiler can
remove unused history. Every solve starts from the same initial values.
Two warmups precede 98 balanced rounds, with seven fresh processes per sample.
Each process repeats the complete solver, prints every result and exits. Timing
includes launch, solving, formatting and teardown; it excludes compilation,
observers, output checking and recording samples. Startup is amortized, and
zero-update cases still construct and print values.

Native GCC O2 uses checked arithmetic, no fast math, no floating-point contraction,
no LTO, and the frozen ARM64/AMD64 instruction targets. Hosts are Neoverse-N2
and EPYC 7763. The raw reports retain exact compilers, settings and commands.
C/Rust peers use manually written derivatives and two reusable contiguous buffers;
fwp records and reverses operations. Their ratios include different algorithms,
storage and initialization work and cannot isolate language or ARC overhead.

## Timing and memory

Ratios are reuse / allocating reference: 0.9600 means 4% less elapsed time.
Long cases require at most 0.9500. Only AMD64 session 1 current 3/1999 qualifies
(5.06% faster). Other long-case gains range from a small slowdown to 4.13% faster.

| Case | ARM1 current | ARM1 history | ARM2 current | ARM2 history | AMD1 current | AMD1 history |
|---|---:|---:|---:|---:|---:|---:|
| 3-0 | 1.0030 | 1.0034 | 1.0023 | 1.0000 | 0.9912 | 0.9880 |
| 3-1 | 0.9845 | 0.9976 | 0.9884 | 0.9959 | 1.0033 | 0.9921 |
| 3-199 | 0.9657 | 0.9666 | 0.9587 | 0.9611 | 0.9816 | 0.9774 |
| 3-1999 | 0.9747 | 0.9671 | 0.9641 | 0.9816 | 0.9494 | 0.9730 |
| 33-199 | 0.9948 | 0.9974 | 0.9974 | 0.9975 | 0.9984 | 1.0035 |
| 129-199 | 0.9954 | 0.9999 | 0.9958 | 0.9980 | 0.9908 | 0.9962 |

The [allocation census](../packed-pair-census-2026-11-05.md) verifies fewer
requests and lower managed peak storage in the largest case. Whole-process RSS
is mixed: candidate/reference ratios span 0.8381–1.0727 across these observations.
RSS includes allocator/runtime/OS costs and is measured separately from timing;
these are not universal RAM-saving claims. Reports retain stack entries, native
instruction/file sizes, raw storage and phase observations alongside the counts.

## Evidence and host rejections

[Original run 42005111118](https://github.com/e6qu/fun-with-pipes/actions/runs/42005111118)
contains all three measured sessions and the first rejected AMD64 session-2 host.
[Audit 42009905049](https://github.com/e6qu/fun-with-pipes/actions/runs/42009905049)
passes: outputs, profiles, source/reference isolation and every acceptance failure
match the original reports. Audit success does not mean the optimization passes.
[The index](index.json), compressed reports and complete logs retain all outcomes.

[Replacement-host records](replacement-hosts.json) preserve runs 42008084704,
42008513001 and 42009708231. All four rejected hosts were EPYC 9V74/9V45;
none built or timed a compiler. No old-candidate session is requested again.
The second qualified AMD64 session is missing, not assumed to pass.

[Summary artifact 13406641674](https://github.com/e6qu/fun-with-pipes/actions/runs/42009905049/artifacts/13406641674):
789,122 bytes, SHA-256
`82c3cd701d3d5f13a0316ccba1264a5b62211ed12802d8881e98c6354542d44f`.
[Complete retained data 13407465033](https://github.com/e6qu/fun-with-pipes/actions/runs/42009905049/artifacts/13407465033):
41,258,810 bytes, SHA-256
`84173ff40d31d49ed22eee223766c888518ede793e50a60af26741ed1edb5256`.
Large C/native archives remain on GitHub; their file hashes are in the index.
