# Paired matrix columns: time and memory

Generated from all four retained sessions; [protocol and timing boundaries](../matrix-calculation-costs.md).
fwp computes two adjacent output columns together; reference uses the original scalar loop.
Both use the same compiler output with only that loop changed. C and Rust do equivalent work.
Inputs are built by the C driver; inclusive costs do not measure source-compiled array construction.

## Time

Times are milliseconds per calculation: the median complete round total divided by
its number of calculations. Ratios use the same totals. A ratio of 1.30 means 30%
more time than that peer. **Noise** means either identical-copy control exceeded
2% for that case and scope; retain the observation but do not accept a speed claim.

### Calculation only

| Host/session | Case | fwp ms | C ms | Rust ms | fwp/C | fwp/Rust | fwp/reference | Copy controls fwp/reference | Status |
|---|---|---:|---:|---:|---:|---:|---:|---|---|
| ARM64/1 | matrix-65-67-63 | 0.0899 | 0.1277 | 0.0957 | 0.7038 | 0.9396 | 0.6647 | 1.0002/1.0002 | Copy controls pass |
| ARM64/1 | matrix-257-259-255 | 5.7062 | 8.0631 | 6.3067 | 0.7077 | 0.9048 | 0.6700 | 1.0005/1.0000 | Copy controls pass |
| ARM64/2 | matrix-65-67-63 | 0.0899 | 0.1277 | 0.0956 | 0.7037 | 0.9403 | 0.6645 | 1.0000/1.0001 | Copy controls pass |
| ARM64/2 | matrix-257-259-255 | 5.7124 | 8.0664 | 6.3284 | 0.7082 | 0.9027 | 0.6704 | 1.0003/1.0005 | Copy controls pass |
| AMD64/1 | matrix-65-67-63 | 0.1230 | 0.0882 | 0.1000 | 1.3954 | 1.2307 | 0.7023 | 1.0181/1.0267 | Noise |
| AMD64/1 | matrix-257-259-255 | 6.3204 | 5.5514 | 6.5547 | 1.1385 | 0.9643 | 0.6916 | 1.0060/1.0003 | Copy controls pass |
| AMD64/2 | matrix-65-67-63 | 0.1256 | 0.0876 | 0.0996 | 1.4339 | 1.2616 | 0.6998 | 1.0624/1.0830 | Noise |
| AMD64/2 | matrix-257-259-255 | 6.3209 | 5.5428 | 6.5543 | 1.1404 | 0.9644 | 0.6923 | 1.0003/1.0032 | Copy controls pass |

### Allocation through cleanup

| Host/session | Case | fwp ms | C ms | Rust ms | fwp/C | fwp/Rust | fwp/reference | Copy controls fwp/reference | Status |
|---|---|---:|---:|---:|---:|---:|---:|---|---|
| ARM64/1 | matrix-65-67-63 | 0.1115 | 0.1428 | 0.1071 | 0.7811 | 1.0414 | 0.7112 | 1.0002/1.0002 | Copy controls pass |
| ARM64/1 | matrix-257-259-255 | 6.0512 | 8.7114 | 6.6702 | 0.6946 | 0.9072 | 0.6830 | 1.0003/1.0001 | Copy controls pass |
| ARM64/2 | matrix-65-67-63 | 0.1115 | 0.1428 | 0.1071 | 0.7808 | 1.0416 | 0.7109 | 1.0004/1.0002 | Copy controls pass |
| ARM64/2 | matrix-257-259-255 | 6.0567 | 8.7489 | 6.7050 | 0.6923 | 0.9033 | 0.6832 | 1.0004/1.0004 | Copy controls pass |
| AMD64/1 | matrix-65-67-63 | 0.1449 | 0.1032 | 0.1146 | 1.4036 | 1.2649 | 0.7346 | 1.0182/1.0261 | Noise |
| AMD64/1 | matrix-257-259-255 | 6.6204 | 6.4135 | 7.0424 | 1.0323 | 0.9401 | 0.7013 | 1.0059/1.0002 | Copy controls pass |
| AMD64/2 | matrix-65-67-63 | 0.1478 | 0.1026 | 0.1142 | 1.4413 | 1.2947 | 0.7323 | 1.0611/1.0802 | Noise |
| AMD64/2 | matrix-257-259-255 | 6.6151 | 6.3945 | 7.0387 | 1.0345 | 0.9398 | 0.7015 | 1.0000/1.0026 | Copy controls pass |

## Memory

Ranges include both architectures, both sessions and all five profile samples.
Requests and requested bytes are divided by eight calculations per sample.
Peak storage is **not** divided: it is the highest simultaneous storage observed.
C/Rust count payload; fwp/reference count managed allocator charge including metadata.
These columns are different accounting boundaries, not total process memory.

| Case | Program | Requests/calculation | Requested KiB/calculation | Peak payload or charge KiB | Effective retains/calculation | Final live bytes |
|---|---|---:|---:|---:|---:|---:|
| matrix-65-67-63 | c | 3.000 | 98.992 | 98.992 | Not instrumented | 0.000 |
| matrix-65-67-63 | rust | 3.000 | 98.992 | 98.992 | Not instrumented | 0.000 |
| matrix-65-67-63 | fwp | 5.000 | 99.078 | 99.016 | 0.000 | 0.000 |
| matrix-65-67-63 | reference | 5.000 | 99.078 | 99.016 | 0.000 | 0.000 |
| matrix-257-259-255 | c | 3.000 | 1,547.992 | 1,547.992 | Not instrumented | 0.000 |
| matrix-257-259-255 | rust | 3.000 | 1,547.992 | 1,547.992 | Not instrumented | 0.000 |
| matrix-257-259-255 | fwp | 5.000 | 1,548.078 | 1,548.016 | 0.000 | 0.000 |
| matrix-257-259-255 | reference | 5.000 | 1,548.078 | 1,548.016 | 0.000 | 0.000 |

## Process memory and code

RSS is the separate whole-process maximum, including runtime and system pages.
Code is the executable text section, not file size. Ranges include both sessions.
GCC frame estimates and every raw profile remain in the reports; they do not measure
stack high-water usage. Rust frame sizes are not measured.

| Host | Case | Program | Peak RSS MiB | Code bytes |
|---|---|---|---:|---:|
| aarch64 | matrix-65-67-63 | c | 1.480 | 2,228.000 |
| aarch64 | matrix-65-67-63 | rust | 1.723–1.832 | 226,732.000 |
| aarch64 | matrix-65-67-63 | fwp | 1.586–1.961 | 83,852.000 |
| aarch64 | matrix-65-67-63 | reference | 1.898–1.953 | 83,724.000 |
| aarch64 | matrix-257-259-255 | c | 2.941–2.945 | 2,228.000 |
| aarch64 | matrix-257-259-255 | rust | 3.160–3.223 | 226,732.000 |
| aarch64 | matrix-257-259-255 | fwp | 3.461 | 83,916.000 |
| aarch64 | matrix-257-259-255 | reference | 3.398 | 83,788.000 |
| x86_64 | matrix-65-67-63 | c | 1.633 | 3,249.000 |
| x86_64 | matrix-65-67-63 | rust | 2.191 | 251,667.000 |
| x86_64 | matrix-65-67-63 | fwp | 1.934–2.309 | 91,618.000 |
| x86_64 | matrix-65-67-63 | reference | 2.297–2.305 | 91,298.000 |
| x86_64 | matrix-257-259-255 | c | 3.105–3.113 | 3,249.000 |
| x86_64 | matrix-257-259-255 | rust | 3.574–3.691 | 251,667.000 |
| x86_64 | matrix-257-259-255 | fwp | 3.742–3.809 | 91,618.000 |
| x86_64 | matrix-257-259-255 | reference | 3.738–3.742 | 91,298.000 |

## Every missed limit

[aarch64, session 1](https://github.com/e6qu/fun-with-pipes/actions/runs/41418956333/job/125189611110), source `8b9827521d0546ddd7eaace299492f9bd45b7af5`:

- All declared rules pass.

[aarch64, session 2](https://github.com/e6qu/fun-with-pipes/actions/runs/41418956333/job/125189611219), source `8b9827521d0546ddd7eaace299492f9bd45b7af5`:

- All declared rules pass.

[x86_64, session 1](https://github.com/e6qu/fun-with-pipes/actions/runs/41420961312/job/125196124849), source `8b9827521d0546ddd7eaace299492f9bd45b7af5`:

- copy: matrix-65-67-63 / reference, kernelNs: 1.026661 exceeds 1.02.
- copy: matrix-65-67-63 / reference, allocationInclusiveNs: 1.026085 exceeds 1.02.

[x86_64, session 2](https://github.com/e6qu/fun-with-pipes/actions/runs/41418956333/job/125189610999), source `8b9827521d0546ddd7eaace299492f9bd45b7af5`:

- copy: matrix-65-67-63 / fwp, kernelNs: 1.062429 exceeds 1.02.
- copy: matrix-65-67-63 / fwp, allocationInclusiveNs: 1.061051 exceeds 1.02.
- copy: matrix-65-67-63 / reference, kernelNs: 1.082951 exceeds 1.02.
- copy: matrix-65-67-63 / reference, allocationInclusiveNs: 1.080225 exceeds 1.02.

3 preceding host/check failures are retained in [the index](index.json),
with their complete logs. None supplied a timing result.
