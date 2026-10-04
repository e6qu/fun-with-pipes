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
| fib | 19 ms | 32 ms | 10 ms | 0.6× |
| loop | 90 ms | 93 ms | 221 ms | 2.5× |
| map | 513 ms | 414 ms | 1017 ms | 2.0× |
| pipeline | 41 ms | 25 ms | 53 ms | 1.3× |
| strings | 156 ms | 158 ms | 19 ms | 0.1× |

What the numbers say:

- `fib` and `loop` are close to C: functions compile to C functions with
  typed arithmetic, a known `loop` runs as a C loop with its state in
  locals, and the optimizer inlines small recursive calls a few levels
  deep (which, with GCC's own inlining, is why `fib` beats the C version
  here). Integer arithmetic is checked for overflow in fwp, not in C.
- `map` is fwp's sorted-array map against C's sorted array and Rust's
  B-tree: twice the time, mostly the generic comparison of keys.
- `pipeline` runs as one loop. `range | map | filter | sum` is fused
  (`src/fuse.rs`), so no list is built, and the loop keeps its state in
  C locals. Before fusion, each stage built a list of a million cells
  (1.8 GB allocated over the run), and the benchmark took 1882 ms, 44
  times as long as C. What remains is fwp's overflow checks.
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
