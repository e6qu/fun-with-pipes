# Current numerical costs

Generated from all four retained sessions; [protocol and timing boundaries](../current-kernel-costs.md).
No production compiler change is introduced by this measurement batch.

## Time

Times are milliseconds per calculation: the median complete round total divided by
its number of calculations. Ratios use the same totals. A ratio of 1.30 means 30%
more time than that peer. **Noise** means either identical-copy control exceeded
2% for that case and scope; retain the observation but do not accept a speed claim.

### Calculation only

| Host/session | Case | fwp ms | C ms | Rust ms | fwp/C | fwp/Rust | fwp/reference | Copy controls fwp/reference | Status |
|---|---|---:|---:|---:|---:|---:|---:|---|---|
| ARM64/1 | array-65537 | 0.0393 | 0.0401 | 0.0408 | 0.9785 | 0.9624 | 1.0023 | 1.0025/1.0027 | Copy controls pass |
| ARM64/1 | array-262145 | 0.1578 | 0.1700 | 0.1649 | 0.9282 | 0.9570 | 0.9966 | 1.0020/1.0022 | Copy controls pass |
| ARM64/1 | matrix-65-67-63 | 0.1353 | 0.1277 | 0.0956 | 1.0595 | 1.4150 | 1.0002 | 1.0002/1.0003 | Copy controls pass |
| ARM64/1 | matrix-257-259-255 | 8.5412 | 8.0825 | 6.3848 | 1.0568 | 1.3377 | 1.0008 | 1.0004/1.0008 | Copy controls pass |
| ARM64/2 | array-65537 | 0.0391 | 0.0402 | 0.0408 | 0.9717 | 0.9566 | 0.9981 | 1.0024/1.0004 | Copy controls pass |
| ARM64/2 | array-262145 | 0.1576 | 0.1696 | 0.1644 | 0.9289 | 0.9587 | 1.0014 | 1.0004/1.0018 | Copy controls pass |
| ARM64/2 | matrix-65-67-63 | 0.1353 | 0.1277 | 0.0958 | 1.0597 | 1.4132 | 1.0007 | 1.0001/1.0002 | Copy controls pass |
| ARM64/2 | matrix-257-259-255 | 8.5162 | 8.0588 | 6.3258 | 1.0568 | 1.3463 | 1.0001 | 1.0004/1.0001 | Copy controls pass |
| AMD64/1 | array-65537 | 0.0712 | 0.0634 | 0.0638 | 1.1235 | 1.1156 | 0.3420 | 1.0214/1.0028 | Noise |
| AMD64/1 | array-262145 | 0.2552 | 0.2511 | 0.2500 | 1.0163 | 1.0208 | 0.3100 | 1.0240/1.0011 | Noise |
| AMD64/1 | matrix-65-67-63 | 0.1724 | 0.0876 | 0.0993 | 1.9690 | 1.7361 | 0.9993 | 1.0172/1.0107 | Copy controls pass |
| AMD64/1 | matrix-257-259-255 | 9.1021 | 5.5323 | 6.5218 | 1.6453 | 1.3956 | 0.9978 | 1.0066/1.0019 | Copy controls pass |
| AMD64/2 | array-65537 | 0.0692 | 0.0634 | 0.0634 | 1.0905 | 1.0913 | 0.3328 | 1.0319/1.0018 | Noise |
| AMD64/2 | array-262145 | 0.2583 | 0.2507 | 0.2515 | 1.0304 | 1.0271 | 0.3134 | 1.0078/1.0008 | Copy controls pass |
| AMD64/2 | matrix-65-67-63 | 0.1674 | 0.0876 | 0.0992 | 1.9108 | 1.6875 | 0.9756 | 1.0456/1.0152 | Noise |
| AMD64/2 | matrix-257-259-255 | 9.1341 | 5.5328 | 6.5334 | 1.6509 | 1.3981 | 0.9987 | 1.0008/1.0020 | Copy controls pass |

### Allocation through cleanup

| Host/session | Case | fwp ms | C ms | Rust ms | fwp/C | fwp/Rust | fwp/reference | Copy controls fwp/reference | Status |
|---|---|---:|---:|---:|---:|---:|---:|---|---|
| ARM64/1 | array-65537 | 0.1588 | 0.1276 | 0.0990 | 1.2451 | 1.6051 | 1.0009 | 1.0003/1.0001 | Copy controls pass |
| ARM64/1 | array-262145 | 0.6825 | 0.5240 | 0.4003 | 1.3024 | 1.7049 | 0.9984 | 1.0003/1.0012 | Copy controls pass |
| ARM64/1 | matrix-65-67-63 | 0.1570 | 0.1428 | 0.1071 | 1.0991 | 1.4654 | 1.0002 | 1.0004/1.0002 | Copy controls pass |
| ARM64/1 | matrix-257-259-255 | 8.8897 | 8.7874 | 6.7679 | 1.0116 | 1.3135 | 1.0007 | 1.0004/1.0007 | Copy controls pass |
| ARM64/2 | array-65537 | 0.1582 | 0.1273 | 0.0986 | 1.2426 | 1.6053 | 1.0008 | 1.0010/1.0002 | Copy controls pass |
| ARM64/2 | array-262145 | 0.6821 | 0.5221 | 0.3984 | 1.3065 | 1.7123 | 1.0024 | 1.0016/1.0008 | Copy controls pass |
| ARM64/2 | matrix-65-67-63 | 0.1569 | 0.1428 | 0.1072 | 1.0991 | 1.4639 | 1.0005 | 1.0002/1.0001 | Copy controls pass |
| ARM64/2 | matrix-257-259-255 | 8.8621 | 8.7133 | 6.6923 | 1.0171 | 1.3242 | 1.0002 | 1.0004/1.0002 | Copy controls pass |
| AMD64/1 | array-65537 | 0.1754 | 0.1362 | 0.1367 | 1.2876 | 1.2829 | 0.5741 | 1.0263/1.0291 | Noise |
| AMD64/1 | array-262145 | 0.6079 | 0.5393 | 0.5387 | 1.1271 | 1.1284 | 0.5157 | 1.0282/1.0004 | Noise |
| AMD64/1 | matrix-65-67-63 | 0.1942 | 0.1025 | 0.1139 | 1.8950 | 1.7048 | 0.9993 | 1.0168/1.0106 | Copy controls pass |
| AMD64/1 | matrix-257-259-255 | 9.3929 | 6.3874 | 7.0006 | 1.4705 | 1.3417 | 0.9977 | 1.0066/1.0019 | Copy controls pass |
| AMD64/2 | array-65537 | 0.1673 | 0.1362 | 0.1364 | 1.2287 | 1.2265 | 0.5446 | 1.0615/1.0023 | Noise |
| AMD64/2 | array-262145 | 0.6165 | 0.5393 | 0.5389 | 1.1432 | 1.1440 | 0.5232 | 1.0108/1.0084 | Copy controls pass |
| AMD64/2 | matrix-65-67-63 | 0.1886 | 0.1024 | 0.1137 | 1.8413 | 1.6585 | 0.9762 | 1.0441/1.0145 | Noise |
| AMD64/2 | matrix-257-259-255 | 9.4257 | 6.3858 | 7.0101 | 1.4760 | 1.3446 | 0.9986 | 1.0008/1.0019 | Copy controls pass |

## Memory

Ranges include both architectures, both sessions and all five profile samples.
Requests and requested bytes are divided by eight calculations per sample.
Peak storage is **not** divided: it is the highest simultaneous storage observed.
C/Rust count payload; fwp/reference count managed allocator charge including metadata.
These columns are different accounting boundaries, not total process memory.

| Case | Program | Requests/calculation | Requested KiB/calculation | Peak payload or charge KiB | Effective retains/calculation | Final live bytes |
|---|---|---:|---:|---:|---:|---:|
| array-65537 | c | 1.000 | 512.008 | 512.008 | Not instrumented | 0.000 |
| array-65537 | rust | 1.000 | 512.008 | 512.008 | Not instrumented | 0.000 |
| array-65537 | fwp | 1.000 | 512.016 | 512.016 | 0.000 | 0.000 |
| array-65537 | reference | 1.000 | 512.016 | 512.016 | 0.000 | 0.000 |
| array-262145 | c | 1.000 | 2,048.008 | 2,048.008 | Not instrumented | 0.000 |
| array-262145 | rust | 1.000 | 2,048.008 | 2,048.008 | Not instrumented | 0.000 |
| array-262145 | fwp | 1.000 | 2,048.016 | 2,048.016 | 0.000 | 0.000 |
| array-262145 | reference | 1.000 | 2,048.016 | 2,048.016 | 0.000 | 0.000 |
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
| aarch64 | array-65537 | c | 1.945 | 2,228.000 |
| aarch64 | array-65537 | rust | 2.316 | 226,732.000 |
| aarch64 | array-65537 | fwp | 2.289–2.305 | 59,788.000 |
| aarch64 | array-65537 | reference | 2.242–2.305 | 59,788.000 |
| aarch64 | array-262145 | c | 3.445 | 2,228.000 |
| aarch64 | array-262145 | rust | 3.707–3.816 | 226,732.000 |
| aarch64 | array-262145 | fwp | 3.742 | 59,852.000 |
| aarch64 | array-262145 | reference | 3.738–3.805 | 59,852.000 |
| aarch64 | matrix-65-67-63 | c | 1.480 | 2,228.000 |
| aarch64 | matrix-65-67-63 | rust | 1.707–1.723 | 226,732.000 |
| aarch64 | matrix-65-67-63 | fwp | 1.898–1.949 | 83,724.000 |
| aarch64 | matrix-65-67-63 | reference | 1.898 | 83,724.000 |
| aarch64 | matrix-257-259-255 | c | 2.945 | 2,228.000 |
| aarch64 | matrix-257-259-255 | rust | 3.223 | 226,732.000 |
| aarch64 | matrix-257-259-255 | fwp | 3.383–3.461 | 83,788.000 |
| aarch64 | matrix-257-259-255 | reference | 3.383–3.461 | 83,788.000 |
| x86_64 | array-65537 | c | 2.062–2.113 | 3,249.000 |
| x86_64 | array-65537 | rust | 2.629–2.734 | 251,667.000 |
| x86_64 | array-65537 | fwp | 2.586 | 65,346.000 |
| x86_64 | array-65537 | reference | 2.645–2.773 | 65,346.000 |
| x86_64 | array-262145 | c | 3.609–3.613 | 3,249.000 |
| x86_64 | array-262145 | rust | 4.188 | 251,667.000 |
| x86_64 | array-262145 | fwp | 4.211 | 65,346.000 |
| x86_64 | array-262145 | reference | 4.086–4.148 | 65,346.000 |
| x86_64 | matrix-65-67-63 | c | 1.633 | 3,249.000 |
| x86_64 | matrix-65-67-63 | rust | 2.117–2.191 | 251,667.000 |
| x86_64 | matrix-65-67-63 | fwp | 2.305 | 91,298.000 |
| x86_64 | matrix-65-67-63 | reference | 2.234–2.297 | 91,298.000 |
| x86_64 | matrix-257-259-255 | c | 3.113 | 3,249.000 |
| x86_64 | matrix-257-259-255 | rust | 3.574–3.695 | 251,667.000 |
| x86_64 | matrix-257-259-255 | fwp | 3.777–3.805 | 91,298.000 |
| x86_64 | matrix-257-259-255 | reference | 3.742 | 91,298.000 |

## Every missed limit

[aarch64, session 1](https://github.com/e6qu/fun-with-pipes/actions/runs/41405696866/job/125147087471), source `9f6d0f7c31c9334cf04d0f7e773f5e543b831edf`:

- speed: array-65537, kernelNs: 1.002254 exceeds 0.95.
- speed: array-262145, kernelNs: 0.996644 exceeds 0.95.

[aarch64, session 2](https://github.com/e6qu/fun-with-pipes/actions/runs/41404044761/job/125141953515), source `b9da15a1a323ae3f5d3ff247e0b6b4c59ab73528`:

- speed: array-65537, kernelNs: 0.998140 exceeds 0.95.
- speed: array-262145, kernelNs: 1.001410 exceeds 0.95.

[x86_64, session 1](https://github.com/e6qu/fun-with-pipes/actions/runs/41405696866/job/125147087334), source `9f6d0f7c31c9334cf04d0f7e773f5e543b831edf`:

- copy: array-65537 / fwp, kernelNs: 1.021368 exceeds 1.02.
- copy: array-65537 / fwp, allocationInclusiveNs: 1.026316 exceeds 1.02.
- copy: array-65537 / reference, allocationInclusiveNs: 1.029148 exceeds 1.02.
- copy: array-262145 / fwp, kernelNs: 1.024040 exceeds 1.02.
- copy: array-262145 / fwp, allocationInclusiveNs: 1.028177 exceeds 1.02.

[x86_64, session 2](https://github.com/e6qu/fun-with-pipes/actions/runs/41405063750/job/125145128971), source `b9da15a1a323ae3f5d3ff247e0b6b4c59ab73528`:

- copy: array-65537 / fwp, kernelNs: 1.031869 exceeds 1.02.
- copy: array-65537 / fwp, allocationInclusiveNs: 1.061509 exceeds 1.02.
- copy: matrix-65-67-63 / fwp, kernelNs: 1.045592 exceeds 1.02.
- copy: matrix-65-67-63 / fwp, allocationInclusiveNs: 1.044130 exceeds 1.02.

7 preceding host/check failures are retained in [the index](index.json),
with their complete logs. None supplied a timing result.
