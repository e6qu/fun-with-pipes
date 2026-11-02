# Paired derivative timings

Read the [storage change and allocation results](README.md) first. These
measurements compare the same fwp source with only packed temporary storage
enabled or disabled. Every completed session and rejected CPU remains below.

## Measurement scope

- Each table time is the median of 98 samples. A sample sums seven fresh
  processes; each process repeats the complete solve and prints every result.
- Startup, repeated solves, formatting and shutdown are timed. Compilation
  and observers are excluded. This is not isolated derivative-kernel time.
- Initial coordinates alternate -1.2 and 1.0; each update subtracts 0.001
  times the gradient. Every repeated solve starts from the original values.
- Current keeps only the latest vector; history keeps all vectors. C/Rust
  use explicit derivative formulas and two reusable buffers, without general
  autodiff. Ratios against them include algorithm, allocation and formatting
  differences; they are not pure compiler overhead.
- fwp captures its initial immutable input once per process. C/Rust call
  their input-initializing workload each solve. Equal initialization work
  is not claimed; zero updates still include construction and printing.
- fwp uses workspace reuse, packed arrays, stack storage and array fusion.
  GCC uses `-O2 -std=gnu11 -fno-fast-math -ffp-contract=off`, reuse enabled,
  and `-march=armv8-a` or `-march=x86-64`. LTO is off. Rust uses optimization
  level 2, checked overflow, one codegen unit, generic CPU and no LTO.

| Coordinates / updates | Solves per process |
|---|---|
| 3 / 0 | 32,768 |
| 3 / 1 | 512 |
| 3 / 199 | 32 |
| 3 / 1,999 | 4 |
| 33 / 199 | 32 |
| 129 / 199 | 8 |

A candidate/reference ratio below 1 is faster. All cases require at most
1.02; cases with at least 199 updates require at most 0.95. **Copy difference**
is `100 * (max(candidate/copy, copy/candidate) - 1)` and must not exceed 2%.
C/Rust columns are current-form fwp elapsed time divided by peer time.
For example, 10× means ten times the elapsed time, or 900% extra time.

RSS is a separate process high-water observation in KiB, not managed live
bytes or allocation traffic. Do not add these measures. A single RSS result
includes runtime/library/allocator pages and does not establish a memory
regression or saving by itself. Frame sizes are compiler-reported maxima,
not total stack high-water marks. Full commands, samples, profiles, source
and binary identities are in the linked compressed reports.

## ARM64, session 1

Run [41514265188](https://github.com/e6qu/fun-with-pipes/actions/runs/41514265188); [report](timing/41514265188/aarch64-1.json.gz); [audit and identities](timing/41514265188/index.json.gz).

CPU: Neoverse-N2. C: gcc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0. Rust: rustc 1.99.1 (58cf8f9c3 2026-10-13).

| Coordinates / updates | Current ms | History ms | Current/ref | History/ref | Copy difference | Current/C | Current/Rust |
|---|---|---|---|---|---|---|---|
| 3 / 0 | 286.778 | 302.134 | 0.99788 | 0.99861 | 0.042% | 1.83× | 1.75× |
| 3 / 1 | 58.045 | 58.551 | 0.99155 | 0.99357 | 0.034% | 7.40× | 6.26× |
| 3 / 199 | 52.325 | 54.993 | 0.94792 | 0.94882 | 0.711% | 8.43× | 6.85× |
| 3 / 1999 | 58.574 | 63.040 | 0.93945 | 0.94387 | 0.090% | 10.49× | 8.79× |
| 33 / 199 | 335.535 | 342.784 | 0.87577 | 0.86929 | 0.063% | 28.40× | 26.61× |
| 129 / 199 | 321.421 | 335.471 | 0.86957 | 0.85805 | 0.025% | 26.35× | 26.30× |

| Coordinates / updates | Current/reference RSS KiB | History/reference RSS KiB | C/Rust RSS KiB | Current/reference instruction bytes | Current/reference largest reported frame bytes |
|---|---|---|---|---|---|
| 3 / 0 | 2848 / 2784 | 2852 / 2852 | 1372 / 1636 | 37692 / 37660 | 704 / 704 |
| 3 / 1 | 1376 / 1440 | 1380 / 1444 | 1384 / 1748 | 38780 / 38748 | 704 / 704 |
| 3 / 199 | 1440 / 1376 | 1380 / 1380 | 1384 / 1620 | 38812 / 38780 | 704 / 704 |
| 3 / 1999 | 1428 / 1372 | 1764 / 1828 | 1384 / 1760 | 38812 / 38780 | 704 / 704 |
| 33 / 199 | 1892 / 1828 | 2216 / 2024 | 1384 / 1636 | 43676 / 43628 | 848 / 848 |
| 129 / 199 | 1880 / 1896 | 2732 / 2796 | 1384 / 1760 | 47084 / 47068 | 2240 / 2240 |

All frozen limits pass in this session.

## ARM64, session 2

Run [41514265188](https://github.com/e6qu/fun-with-pipes/actions/runs/41514265188); [report](timing/41514265188/aarch64-2.json.gz); [audit and identities](timing/41514265188/index.json.gz).

CPU: Neoverse-N2. C: gcc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0. Rust: rustc 1.99.1 (58cf8f9c3 2026-10-13).

| Coordinates / updates | Current ms | History ms | Current/ref | History/ref | Copy difference | Current/C | Current/Rust |
|---|---|---|---|---|---|---|---|
| 3 / 0 | 287.985 | 303.229 | 0.99903 | 0.99877 | 0.014% | 1.82× | 1.72× |
| 3 / 1 | 58.436 | 58.746 | 0.99573 | 0.99441 | 0.102% | 7.33× | 6.14× |
| 3 / 199 | 51.789 | 54.617 | 0.94367 | 0.94733 | 0.534% | 8.67× | 7.13× |
| 3 / 1999 | 59.648 | 64.208 | 0.94243 | 0.94535 | 0.012% | 9.74× | 8.08× |
| 33 / 199 | 335.460 | 342.565 | 0.87583 | 0.86888 | 0.025% | 28.43× | 26.40× |
| 129 / 199 | 321.740 | 335.992 | 0.86955 | 0.85805 | 0.052% | 26.10× | 25.89× |

| Coordinates / updates | Current/reference RSS KiB | History/reference RSS KiB | C/Rust RSS KiB | Current/reference instruction bytes | Current/reference largest reported frame bytes |
|---|---|---|---|---|---|
| 3 / 0 | 2848 / 2912 | 2980 / 2788 | 1384 / 1636 | 37692 / 37660 | 704 / 704 |
| 3 / 1 | 1440 / 1440 | 1380 / 1428 | 1384 / 1760 | 38780 / 38748 | 704 / 704 |
| 3 / 199 | 1376 / 1376 | 1380 / 1444 | 1384 / 1636 | 38812 / 38780 | 704 / 704 |
| 3 / 1999 | 1376 / 1372 | 1828 / 1756 | 1384 / 1636 | 38812 / 38780 | 704 / 704 |
| 33 / 199 | 1828 / 1828 | 2212 / 2084 | 1376 / 1632 | 43676 / 43628 | 848 / 848 |
| 129 / 199 | 1896 / 1892 | 2796 / 2660 | 1384 / 1636 | 47084 / 47068 | 2240 / 2240 |

All frozen limits pass in this session.

## AMD64, session 1

Run [41518220615](https://github.com/e6qu/fun-with-pipes/actions/runs/41518220615); [report](timing/41518220615/x86_64-1.json.gz); [audit and identities](timing/41518220615/index.json.gz).

CPU: AMD EPYC 7763 64-Core Processor. C: gcc (Ubuntu 15.2.0-16ubuntu1) 15.2.0. Rust: rustc 1.99.1 (58cf8f9c3 2026-10-13).

| Coordinates / updates | Current ms | History ms | Current/ref | History/ref | Copy difference | Current/C | Current/Rust |
|---|---|---|---|---|---|---|---|
| 3 / 0 | 334.988 | 348.707 | 1.01759 | 1.01815 | 0.044% | 2.40× | 1.53× |
| 3 / 1 | 71.160 | 71.022 | 1.00031 | 0.99199 | 0.741% | 7.84× | 5.59× |
| 3 / 199 | 61.783 | 63.865 | 0.94887 | 0.91923 | 0.440% | 8.50× | 7.00× |
| 3 / 1999 | 70.026 | 74.107 | 0.94513 | 0.92220 | 0.029% | 9.69× | 8.27× |
| 33 / 199 | 371.646 | 391.358 | 0.89460 | 0.90248 | 0.091% | 33.32× | 31.34× |
| 129 / 199 | 362.616 | 378.104 | 0.88485 | 0.87696 | 0.125% | 33.59× | 31.57× |

| Coordinates / updates | Current/reference RSS KiB | History/reference RSS KiB | C/Rust RSS KiB | Current/reference instruction bytes | Current/reference largest reported frame bytes |
|---|---|---|---|---|---|
| 3 / 0 | 3324 / 3428 | 3136 / 3200 | 1544 / 2152 | 39378 / 38770 | 720 / 720 |
| 3 / 1 | 2104 / 1832 | 2112 / 2176 | 1544 / 2188 | 40722 / 40114 | 720 / 720 |
| 3 / 199 | 2300 / 2172 | 2176 / 2108 | 1544 / 2136 | 40754 / 40146 | 720 / 720 |
| 3 / 1999 | 2172 / 2104 | 2560 / 2496 | 1544 / 2276 | 40754 / 40146 | 720 / 720 |
| 33 / 199 | 2304 / 2108 | 2568 / 2432 | 1544 / 2288 | 45442 / 44802 | 768 / 768 |
| 129 / 199 | 2184 / 2352 | 3084 / 3212 | 1544 / 2192 | 50354 / 49730 | 2208 / 2208 |

All frozen limits pass in this session.

## AMD64, session 2

Run [41514265188](https://github.com/e6qu/fun-with-pipes/actions/runs/41514265188); [report](timing/41514265188/x86_64-2.json.gz); [audit and identities](timing/41514265188/index.json.gz).

CPU: AMD EPYC 7763 64-Core Processor. C: gcc (Ubuntu 15.2.0-16ubuntu1) 15.2.0. Rust: rustc 1.99.1 (58cf8f9c3 2026-10-13).

| Coordinates / updates | Current ms | History ms | Current/ref | History/ref | Copy difference | Current/C | Current/Rust |
|---|---|---|---|---|---|---|---|
| 3 / 0 | 333.921 | 349.115 | 1.01446 | 1.02024 | 0.011% | 2.36× | 1.48× |
| 3 / 1 | 70.525 | 69.539 | 1.00882 | 0.98913 | 0.008% | 7.74× | 5.62× |
| 3 / 199 | 61.853 | 64.299 | 0.94614 | 0.93989 | 0.640% | 8.31× | 6.92× |
| 3 / 1999 | 69.214 | 72.890 | 0.94898 | 0.91248 | 0.983% | 9.70× | 8.42× |
| 33 / 199 | 369.968 | 389.591 | 0.89355 | 0.89645 | 0.135% | 31.41× | 30.04× |
| 129 / 199 | 361.073 | 380.191 | 0.88111 | 0.87680 | 0.391% | 32.12× | 30.38× |

| Coordinates / updates | Current/reference RSS KiB | History/reference RSS KiB | C/Rust RSS KiB | Current/reference instruction bytes | Current/reference largest reported frame bytes |
|---|---|---|---|---|---|
| 3 / 0 | 3128 / 3428 | 3200 / 3200 | 1540 / 2152 | 39378 / 38770 | 720 / 720 |
| 3 / 1 | 2172 / 2172 | 2176 / 1960 | 1540 / 2156 | 40722 / 40114 | 720 / 720 |
| 3 / 199 | 2172 / 2172 | 1772 / 2176 | 1544 / 2312 | 40754 / 40146 | 720 / 720 |
| 3 / 1999 | 2108 / 2172 | 2496 / 2496 | 1544 / 2256 | 40754 / 40146 | 720 / 720 |
| 33 / 199 | 2304 / 2112 | 2440 / 2564 | 1544 / 2148 | 45442 / 44802 | 768 / 768 |
| 129 / 199 | 2120 / 2100 | 3020 / 3212 | 1544 / 2188 | 50354 / 49730 | 2208 / 2208 |

Failed limits (retained without rounding or threshold changes):

- `3-0`, `fwp-ad-history`: candidate/reference time `1.020242816737252` > `1.02`.

## Host rejections and remaining work

These jobs stopped before building or timing because their CPU differed
from the frozen AMD EPYC 7763. They are not measured sessions.

| Run | Observed CPU | Retained evidence |
|---|---|---|
| [41514265188](https://github.com/e6qu/fun-with-pipes/actions/runs/41514265188) | AMD EPYC 9V74 80-Core Processor | [Index/log identity](timing/41514265188/index.json.gz) |
| [41514783218](https://github.com/e6qu/fun-with-pipes/actions/runs/41514783218) | AMD EPYC 9V45 96-Core Processor | [Index/log identity](timing/41514783218/index.json.gz) |
| [41515994738](https://github.com/e6qu/fun-with-pipes/actions/runs/41515994738) | AMD EPYC 9V74 80-Core Processor | [Index/log identity](timing/41515994738/index.json.gz) |
| [41517608442](https://github.com/e6qu/fun-with-pipes/actions/runs/41517608442) | AMD EPYC 9V45 96-Core Processor | [Index/log identity](timing/41517608442/index.json.gz) |

All four required sessions are complete. No completed session is repeated to seek a pass. The full production matrix
and the separate D2 requirements remain; fewer allocations do not close them.
