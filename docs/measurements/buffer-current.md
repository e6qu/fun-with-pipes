# Buffer comparison after direct scalar folds

All four sessions retain their complete results. **25 of 48 case controls fail**; no workload passes all four sessions. These measurements do not establish stable speed relative to C or Rust. The independently verified dispatch, count-call and code-size reductions remain valid.

Source: `3ca66b543bb8764527fe2a5142119831df15cfb7`. The three operations, four lengths, inputs, sample counts, compiler flags and 2% copy limit match the original buffer protocol. The captured wait uses `posix-alarm`; original timed-polling observations remain separate.

Each entry constructs the integers from zero through length minus one, uses them,
then releases storage. `unique` reads the length twice and the first element;
`callback` passes the array to a known function that reads its length and first
element; `scan` sums all elements from left to right with checked addition.
For length four their results are 8, 4 and 6. Empty arrays have no first element,
so these reads use zero explicitly.

A copy control compares each language's executable with a byte-identical copy.
Their median elapsed times must differ by at most 2%; all three languages must
pass for a case/session to qualify. This checks measurement stability, not
program correctness. The collected outputs and independent evidence audits pass
even when a timing control fails.

For the programs, exact flags, sample schedule and timing boundaries, see the [original protocol](unique-buffer-peers.md#what-the-programs-do). The [complete index](buffer-wait-repair-artifacts-2026-10-30.json) retains all 131,328 process observations through their archive identities, plus 288 separate resident-memory observations, code/stack records and four wrong-CPU rejections before timing.

The tables show median round time divided by twelve, in milliseconds per process. Each range spans two session medians, not a confidence interval. Ratios greater than one mean fwp takes longer. Controls list passing sessions; a dash means neither.

## ARM64

| Entry / length | C ms | Rust ms | fwp ms | fwp/C | fwp/Rust | Controls |
|---|---|---|---|---|---|---|
| unique / 0 | 0.806–0.839 | 1.005–1.046 | 1.666–1.688 | 2.012–2.067 | 1.614–1.658 | — |
| unique / 16 | 1.770–1.845 | 2.822–2.934 | 2.051–2.138 | 1.159–1.159 | 0.727–0.729 | 1, 2 |
| unique / 4096 | 0.959–1.031 | 1.418–1.494 | 1.324–1.374 | 1.333–1.379 | 0.920–0.933 | 1 |
| unique / 262144 | 2.265–2.341 | 2.755–2.857 | 1.996–2.090 | 0.881–0.893 | 0.725–0.731 | 1, 2 |
| callback / 0 | 0.811–0.814 | 1.020–1.033 | 1.571–1.606 | 1.939–1.973 | 1.522–1.574 | 1, 2 |
| callback / 16 | 1.765–1.783 | 2.919–2.945 | 2.043–2.050 | 1.149–1.158 | 0.696–0.700 | 1, 2 |
| callback / 4096 | 1.005–1.036 | 1.469–1.498 | 1.362–1.382 | 1.314–1.375 | 0.909–0.941 | 1 |
| callback / 262144 | 2.281–2.374 | 2.769–2.894 | 2.036–2.158 | 0.892–0.909 | 0.735–0.746 | 1, 2 |
| scan / 0 | 0.779–0.820 | 1.030–1.091 | 2.292–2.343 | 2.859–2.942 | 2.148–2.225 | 1, 2 |
| scan / 16 | 2.075–2.157 | 3.081–3.151 | 4.344–4.409 | 2.044–2.094 | 1.399–1.410 | 1, 2 |
| scan / 4096 | 1.403–1.470 | 1.785–1.869 | 3.476–3.548 | 2.414–2.477 | 1.899–1.947 | 1, 2 |
| scan / 262144 | 2.717–2.859 | 3.079–3.249 | 4.229–4.391 | 1.536–1.556 | 1.352–1.373 | 1, 2 |

## AMD64

| Entry / length | C ms | Rust ms | fwp ms | fwp/C | fwp/Rust | Controls |
|---|---|---|---|---|---|---|
| unique / 0 | 1.023–1.025 | 1.667–1.671 | 1.953–1.977 | 1.908–1.929 | 1.169–1.186 | 1, 2 |
| unique / 16 | 1.401–1.449 | 2.766–2.770 | 2.063–2.082 | 1.436–1.473 | 0.746–0.752 | — |
| unique / 4096 | 0.984–0.985 | 1.755–1.775 | 1.531–1.588 | 1.555–1.613 | 0.863–0.905 | — |
| unique / 262144 | 2.871–2.878 | 3.696–3.735 | 2.537–2.562 | 0.884–0.890 | 0.679–0.693 | — |
| callback / 0 | 0.997–1.006 | 1.668–1.678 | 1.929–2.048 | 1.917–2.053 | 1.150–1.227 | — |
| callback / 16 | 1.388–1.403 | 2.744–2.794 | 2.020–2.187 | 1.440–1.576 | 0.723–0.797 | — |
| callback / 4096 | 0.984–0.997 | 1.776–1.777 | 1.570–1.622 | 1.596–1.627 | 0.883–0.913 | — |
| callback / 262144 | 2.873–2.876 | 3.713–3.756 | 2.531–2.556 | 0.881–0.889 | 0.674–0.688 | — |
| scan / 0 | 1.019–1.031 | 1.660–1.673 | 2.287–2.321 | 2.244–2.252 | 1.378–1.387 | — |
| scan / 16 | 1.809–1.886 | 3.024–3.199 | 4.140–4.476 | 2.194–2.474 | 1.294–1.480 | — |
| scan / 4096 | 1.443–1.535 | 2.137–2.211 | 2.799–2.888 | 1.824–2.002 | 1.266–1.351 | 1 |
| scan / 262144 | 3.231–3.262 | 4.058–4.180 | 4.086–4.090 | 1.254–1.265 | 0.979–1.007 | — |

## What this permits next

The 4,096-element scan takes 2.41–2.48 times C on ARM64 and 1.82–2.00 times C
on AMD64 in these observations. ARM's two controls pass; AMD session 2 fails
C's copy control at 1.0269 against the unchanged 1.02 limit. These ranges are
not a qualified four-session speed comparison. The parent-wait repair removes
a demonstrated harness delay; it does not resolve all timing variation.

The measured source allocates an array, fills it, then sums it. The later
[array-removal change](generated-array-folds.md) eliminates that intermediate
under explicit semantic and storage requirements. Its report owns current
verification status. Keep timing acceptance separate and open;
do not retry the failed sessions, increase their counts or relax their limits.
