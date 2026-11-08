# PR #233 whole-program baseline

Historical source-specific results. The [benchmark overview](../benchmarks.md)
now uses the #269 snapshot; these observations have not been rerun.


Source: `fd19b9e4`, same tree as merged `73a6b20d`;
[production job](https://github.com/e6qu/fun-with-pipes/actions/runs/41174213818/job/124458289963).

| Setting | Recorded value |
|---|---|
| Host | Linux AMD64, AMD EPYC 7763, four available CPUs |
| Compilers | GCC 15.2.0, Rust 1.99.1; C/fwp O2, Rust optimized, no fwp LTO |
| Samples | One warmup, six rotated measured runs |
| Timed | Whole process: startup, construction, computation, output, cleanup |
| Excluded | Compilation |
| Qualification | One CI snapshot; no identical-code controls or second session |

These observations are not stable speed guarantees or language-wide overhead.
Inputs and implementation differences are [below](../benchmarks.md#what-each-program-actually-does).

| Program | C ms | Rust ms | fwp ms | fwp extra time vs C / Rust |
|---|---:|---:|---:|---:|
| Fibonacci, 35 | 48.979 | 44.537 | 15.658 | −68.0% / −64.8% |
| Checked loop, 100 million steps | 126.882 | 107.275 | 158.734 | +25.1% / +48.0% |
| Sorted map, 500,000 pairs / 2 million lookups | 411.124 | 338.409 | 363.642 | −11.5% / +7.5% |
| Map/filter/sum, 20 × 1 million elements | 35.613 | 22.612 | 14.226 | −60.1% / −37.1% |
| Ordered million-key set and hash | 15.183 | 15.400 | 17.563 | +15.7% / +14.0% |
| Format strings then count characters | 146.610 | 156.296 | 6.487 | −95.6% / −95.8% |
| Count characters directly | 3.806 | 7.110 | 5.171 | +35.8% / −27.3% |

The pipeline peers materialize collections that fwp eliminates. In `strings`,
fwp avoids formatting that C/Rust still perform; `text-length` supplies the more
direct comparison. Sorting implementations also differ. These differences belong
to the results; they must not be presented as isolated ARC or dispatch costs.

Three separate GNU-time runs of the same executables measure peak **resident
memory**, the RAM occupied by the process, including runtime and mapped libraries:

| Program | C peak KiB | Rust peak KiB | fwp peak KiB |
|---|---:|---:|---:|
| Fibonacci | 1,544 | 2,040–2,212 | 2,060–2,064 |
| Checked loop | 1,544 | 2,116–2,228 | 2,060–2,192 |
| Sorted map | 16,880 | 9,908–9,980 | 17,688–17,816 |
| Map/filter/sum | 13,316–13,320 | 9,956–9,968 | 2,064 |
| Ordered set/hash | 9,348–9,352 | 9,820–9,976 | 9,868–10,000 |
| Strings | 1,544 | 2,044–2,284 | 2,064–2,192 |
| Direct character count | 1,544 | 2,120–2,244 | 1,680–2,064 |

Separate fwp profiles report zero managed requests/retains for Fibonacci, loop,
pipeline and both character-count programs. The map makes four requests totaling
24,000,032 bytes, peaks at 16,000,008 charged bytes and performs one retain. The
set makes one 8,000,008-byte request with no retains. All seven finish with zero
managed charge; deliberate leaks are detected.

These counters exclude raw runtime
buffers, stacks and allocator metadata. **Allocated bytes over time, live payload,
resident RAM and reserved virtual addresses are different measurements.** The
[buffer report](unique-buffer-peers.md#process-memory-and-virtual-reservations)
records about 65.1 GiB reserved virtually with only 1.5–1.9 MiB resident in its
small diagnostic; the reservation is not that much occupied RAM.

The [benchmark overview](../benchmarks.md) links later derivative and Swift
measurements. They do not refresh the source-specific observations on this page.

