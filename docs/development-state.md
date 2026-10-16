# Session handoff

Updated 2026-10-16. [PLAN.md](../PLAN.md) defines completion; no whole roadmap
area is finished. [Delivery history](roadmap-history.md) preserves accepted work.

## Active delivery

[PR #151](https://github.com/e6qu/fun-with-pipes/pull/151), branch
`wasi-hash-delivery` in `/private/tmp/fwp-wasi-delivery`, remains the only open PR.
It adds synchronous WASI ARC, streaming structural hashing and eligible callback
pipeline fusion. Its final gate at `796f5a4c` did not pass: Intel macOS GC job
`116844933823` in run `38861611494` exceeded the 90-minute limit. GitHub's check
annotation confirms that cause. No failing assertion was reported before timeout.
Six production jobs and docs `38861611496` passed; incomplete/canceled jobs are
not acceptance. Never merge that run or count a focused skip as support.

The current repair replaces alternating sorted target names with explicit lists
in `scripts/macos-test-shards.json`. Adding a target previously shifted many
existing targets to the other job. All 219 current integration targets now have
one assignment; unit/example/bench targets remain in regular and GC stress stays
in its separate invocation. The real Cargo target set is checked for missing,
duplicate, obsolete or unknown entries. No test or job was removed, and neither
job's 90-minute limit was raised.

[Recorded target timings](measurements/macos-shards-2026-10-16.json) from completed
#150/#151 and focused jobs guide the fixed initial assignment. Estimated regular
and GC loads are 84.18/83.25 minutes including observed overhead. Those estimates
are not passing CI or guaranteed future times. Local guarded coverage/stability/
failure-propagation checks pass (0.25 s). The repair still needs fresh full gates
and docs for the exact final head; query the PR head and checks after publication.

Next: publish the CI repair, cancel only superseded failed-run work, and fix any
new failures. Squash merge #151 only when all nine production jobs and docs pass
for its final head. Verify the merged tree, parent and exact one-line message.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Complete deployment and primitive ownership; remove tracing |
| 2 | In progress | Deliver borrowed hash fields, direct arrays and vector owners |
| 3 | In progress | Reduce measured vector and other C/Rust gaps |
| 4 | In progress | Reduce derivative recording costs and validate scaling |
| 5 | In progress | Improve measured lane kernels and resolve runtime OpenCL compilation |
| 6 | In progress | Retain comparable timing, allocation and machine-code evidence |
| 7 | In progress | Extend maintained applications across deployment boundaries |

## Implementation evidence

Native and actual WASI focused checks passed before full-gate publication. WASI
uses counted synchronous owners with physical-free controls, fresh numeric boxes,
wide reference counts and checked startup modes. Browser/service host re-entry
remains excluded. Native-library plus WASM generation is rejected explicitly.

Structural hashing streams the existing canonical typed bytes into FNV-1a.
The independent interpreter retains buffered encoding. Native/WASI fixtures cover
all widths, float bits, Unicode/NUL text, containers/views and aliases. Restoring
the old buffer must fail the no-allocation control. Known callback captures remain
eager and ordered; unknown forwarding wrappers do not receive the fusion proof.
Hash/bitwise loop fusion preserves effects, first traps and resource frames.

Four-host source/binary/assembly comparisons and paired CPU repeats are retained
in [benchmarks](benchmarks.md). They show lower small-workload counts and CPU time,
while preserving slower elapsed samples and remaining C/Rust gaps. Large timing
is mostly unchanged. The allocation test now counts both `fwp_alloc_init` and the
nonduplicated slow allocation path; old benchmark profiles already did so.
The CI repair changes scheduling only, not compiler/runtime sources.

## Following combined batch

The main workspace `/Users/zardoz/projects/fun-with-pipes` is on
`owned-numerics-delivery`, prepared and published as `9b4f9d46`, based on old #151
head `796f5a4c`. It already combines hash/range and vector preparations; do not
replay those branches again. Propagate the CI repair there with its two additional
integration targets, keeping existing assignments stable. After #151 merges,
transfer only the combined delta onto its verified squash and open one substantial
PR with fresh complete gates.

That batch's hash/range revision `ac72124c` passes six native checks
`38864599295`, both WASI jobs `38864602220`, costs `38864604854`, and two paired
runs `38866837452` / `38867789225`. Hash workloads use two managed requests, zero
retains and zero final charged memory. Some timing regressions did not repeat;
all samples and C/Rust overhead remain visible.

Vector runtime `637b3eb2` passes six native jobs `38867603162` and both WASI jobs
`38867607803`. Four-host costs `38869050349` at `6be8f245` establish a remaining
allocation/performance gap: three vector constructions per mapped input plus
range/result lists. Checked ARC four-lane CPU is about 11.2 times C on Linux ARM64,
despite zero retains and complete cleanup. Its next optimization must target
measured storage/representation costs without changing effects, trap order or
numeric rules. The main worktree handoff retains the full details and report links.

## Working rules

Standing authorization covers fixes, publication and passing-CI squash merge.
Every commit is exactly one line, at most 80 characters, with no body, trailers
or attribution. Use `python3 scripts/local-guard.py` for bounded serial local
checks. Full builds, suites and measurements run on GitHub. The earlier local
optimizer probe was stopped by the guard; no process remained and no limit was
raised. Do not restart it. JIT is excluded. Default tracing, broader deployment
ownership, derivative scaling and representative applications remain unfinished.
