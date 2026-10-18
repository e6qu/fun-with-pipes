# Preparation: measure cached-map borrow costs

The authoritative live handoff is
`/Users/zardoz/projects/fun-with-pipes/docs/development-state.md`.
PR #166 now contains the joined-buffer repair at `91c8923f`; its full production
and collection checks are running. This preparation does not change the compiler,
runtime or language tests. Do not treat this experiment as an implemented optimization.

Next: publish and audit the `map-borrow` measurement on four AMD64 hosts and one
ARM64 host, using verified source `93cb93a0` from successful run `39106005017`.
The measurement compares both map layouts, each with ordinary retained reads or
a scoped borrow only inside this maintained program's numeric query loop.
The program initializes and owns its table before the loop; the loop cannot
suspend or invoke callbacks. A runtime guard rejects an uninitialized cache.
Initial evaluation, checked arithmetic, lookup and failure order remain intact.
The compiler will need its own proof before any general transformation is adopted;
its current ownership tests explicitly cover reentrant initialization and cached
value replacement. A synchronous callback contract alone is insufficient.

A tiny eight-entry/sixteen-query preflight agrees with the raw interpreter in
both memory modes and both storage layouts. Retains fall from 17 to one, while
allocation requests, peak storage and zero final charge remain identical.
Initial preflight passes in 9.64 seconds under the root guard; guard-rejection
negative controls are included in the final preflight. No full benchmark runs
locally. The experiment compiles native O2 programs on CI, records actual code,
CPU/compiler identity, profiles and 24 balanced samples per variant.

Second replay `39109637834` reproduces the original tracing slowdown on the same
Xeon 8573C: ordinary joined/separate ratio 1.0436, while construction is 0.8997.
The diagnostic executable instead has ratio 0.9815, with query medians
395.091/391.982 ms. Instrumentation changes the program, so this suggests
code-placement sensitivity without proving a mechanism or eliminating the real
ordinary-program regression. Three accompanying EPYC hosts improve. All four
jobs and 64 binary identities pass independent audit (24.69 s guarded).
Data: `/private/tmp/fwp-map-replay-two`; do not call the Xeon issue fixed.

Standing publication and squash-merge authorization remains conditional on all
nine exact-head production jobs, documentation and affected evidence passing.
Commits have one line, at most 80 characters, no body/trailers/attribution.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Ownership and tracing removal |
| 2 | In progress | Functional intermediates, copies and unnecessary counts |
| 3 | In progress | Controlled C/Rust gaps and actual machine code |
| 4 | In progress | Differentiation precision, speed and memory |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Repeated, equivalent-work comparisons |
| 7 | In progress | Representative applications and browser execution |


All seven [PLAN.md](../PLAN.md) areas remain open: ownership/GC removal;
functional costs; machine performance; differentiation; numerical kernels;
dependable measurement; larger programs. Cached-value retain requests are measured
remaining work; removing them needs a lifetime proof preserving reentrant
initialization and failure order. JIT is excluded, not deferred. A completed
delivery does not complete the language's memory or performance goals.
