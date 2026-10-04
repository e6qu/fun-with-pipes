# Benchmarks

`bench/<name>/` holds one program three times: `main.fwp`, `main.c` and
`main.rs`, which print the same output. `tests/bench.rs` builds them with
`fwp build -O2`, `cc -O2` and `rustc -O`, checks that the three agree,
and reports the best of three runs of each:

```
cargo test --release --test bench -- --ignored --nocapture
```

The table goes to standard output, to `target/bench.md`, and in CI (the
`bench` job) to the job's summary. Timings are not asserted, because
shared machines are too noisy for that; the outputs are.

| Benchmark | What it measures |
|---|---|
| `fib` | naive recursion: calls and integer arithmetic (`fib 35`) |
| `loop` | a `loop` over a pair of integers, 100 million iterations |
| `map` | an ordered map built from 500 000 pairs, then 2 million lookups |
| `pipeline` | `range \| map \| filter \| sum` over a million elements, 20 times |
| `strings` | formatting two numbers, concatenating, measuring, 2 million times |

On a 4-core x86-64 machine (GCC 13, Rust 1.99):

| benchmark | C (cc -O2) | Rust (rustc -O) | fwp (fwp build -O2) | fwp / C |
|---|--:|--:|--:|--:|
| fib | 19 ms | 33 ms | 10 ms | 0.5× |
| loop | 88 ms | 90 ms | 119 ms | 1.3× |
| map | 543 ms | 407 ms | 599 ms | 1.1× |
| pipeline | 40 ms | 25 ms | 32 ms | 0.8× |
| strings | 155 ms | 160 ms | 16 ms | 0.1× |

What the numbers say:

- `fib` and `loop` are close to C: functions compile to C functions with
  typed arithmetic, a known `loop` runs as a C loop with its state in
  locals, and the optimizer inlines small recursive calls a few levels
  deep (which, with GCC's own inlining, is why `fib` beats the C version
  here). Integer arithmetic is checked for overflow in fwp, not in C. A
  program without tasks has no safe points, so its loops count nothing
  per iteration (`loop` took 227 ms while they did).
- `map` is fwp's sorted-array map against C's sorted array and Rust's
  B-tree. Integer keys are compared inline. The optimizer turns `key |
  flip map.get table` into direct calls: a closure used once is
  substituted where it is applied (after binding the constants it
  captures, so they are still evaluated first), and a tuple built only to
  be matched is never built, and a `match` on `map.get` branches on
  whether the key was found instead of allocating a `Some`
  (`lookup_match` in `src/cgen.rs`). What remains is the binary search's
  cache misses, which C pays too. It took 1016 ms before these changes.
- `pipeline` runs as one loop. `range | map | filter | sum` is fused
  (`src/fuse.rs`), so no list is built, and the loop keeps its state in
  C locals. Before fusion, each stage built a list of a million cells
  (1.8 GB allocated over the run), and the benchmark took 1882 ms, 44
  times as long as C. The outer `range 0 20 | map one-round | sum` is
  fused too, with the inner pipeline fused inside its step.
- `strings` builds no string at all. `string.length` of a `concat` is the
  sum of the parts' lengths, and `string.length` of an integer's `show`
  is its count of digits (`length_without_string` in `src/cgen.rs`).
  The stages are total, so `map line | sum` is fused too. C and Rust
  format into a buffer and measure it. Before these changes, fwp built
  a string per number and per concatenation and took 631 ms (4.1×).
  Integers are now shown without going through a type descriptor, which
  helps every `show` of an integer.

The benchmarks also found a bug: `map.from-list` and `set.from-list`
inserted pairs one by one into a sorted array, copying it each time, so
building a map of 500 000 entries never finished; they now sort once.
