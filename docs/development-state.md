# Session handoff

Updated 2026-10-17 UTC. All seven work areas in [PLAN.md](../PLAN.md) remain open.

## Current delivery

Branch `own-client-requests`, [PR #157](https://github.com/e6qu/fun-with-pipes/pull/157),
starts at accepted #156 merge `29302bae30f6dbfae63166bb9171c7da5b237789`.
It combines finished-request cleanup, compiler field transfers and service TLS
settings construction fixes. No syntax changes. Final evidence and documentation
are complete. Next: push this revision, mark the PR ready and require all nine production
jobs plus documentation at its exact final head before authorized squash merge.
Use an explicit one-line subject of at most 80 characters and an empty body;
verify the resulting tree, parent and complete message. One delivery PR at a time.

#156 passed production `38996879616` and docs `38996879603` at `d19ab045`.
Its verified acceptance is in [the history](roadmap-history.md); the private
merge record is `/private/tmp/fwp156-merge-record.json`. Duplicate production
`39001824256` was canceled. Do not rerun accepted gates without a new reason.

## Focused evidence retained for #157

| Component | Exact measured source | Six-platform run | Retained source tag |
|---|---|---|---|
| Original repeated calls | `ac95632b8c77cc8c52f35a451f3c7451d0e29b06` | `38997585835` | `evidence/repeated-remote-baseline-20261017` |
| Request cleanup | `997b23a9aa392a3cde8fb8bd5026c348545c06b2` | `39000228402` | `evidence/remote-request-ownership-20261017` |
| Combined compiler/runtime change | `d7a161d1328f78c54870688c6dd30cf24fa22aa0` | `39001772549` | `evidence/remote-projection-moves-20261017` |

All six jobs pass in each run. Combined Intel Mac tests passed initially but
artifact upload timed out; the failed job's retry passed at the same source.
The report and raw checkpoints are
[remote-projection-moves-2026-10-17.json](measurements/remote-projection-moves-2026-10-17.json).
The collector verifies exact revisions, job logs, all output/control checks and
comparison bounds. It includes static review of actual Linux ARM64/AMD64 binaries.
The delivery's Mac test-schedule correction is additional CI metadata, not a
change to the measured compiler/runtime. Documentation `39002352493` passed it.

Every created request/message releases; final managed bytes remain constant over
1/16/256 batches in full, partial and retained-reader modes. Request cleanup adds
one retain per call; the compiler then removes 24.6%/19.5%/14.3% of retains for
256 full/partial/retained batches. Allocation requests and bytes stay unchanged.
Final pooled-client bytes are Linux AMD64 6,240, ARM64 19,296; either Mac 2,240;
Windows AMD64 3,392, ARM64 3,008. Reusable connections and detached tasks are
still alive at this sample. Other raw buffers, TLS/OS/process/server memory and
timing are excluded. See [the guide](benchmarks.md#memory-left-behind-by-repeated-remote-calls)
for inputs, comparison stages and remaining costs. This is not checked ARC.

## Next preparation: closed connection and I/O task storage

Worktree `/private/tmp/fwp-client-connection-owners`, branch
`own-client-connections`, is independent preparation for the next delivery.
Its own handoff is current. Do not open a second PR while #157 remains active.
The frozen baseline `4103b0a09f06cae69721c29151571ba9e9a621b9` passed all six
native jobs in `39002767125`; tag `evidence/closed-remote-baseline-20261017`
and report `docs/measurements/closed-remote-baseline-2026-10-17.json` in that
worktree preserve it. All connections close and I/O tasks finish, yet each adds
managed storage: Linux AMD64 3,904 bytes, ARM64 12,608; either Mac 1,600;
Windows AMD64 2,368, ARM64 2,112. Raw TLS/OS/process storage and timing are excluded.

The candidate separates socket liveness from shared connection storage and gives
client I/O tasks one scheduler owner, without task retain/release operations.
First Linux run `39003608985` at `4d595abf` found two fixture defects: a mutation
matched two release sites, and a C-task probe omitted its cancellation check.
Repairs plus connection-overflow/last-owner controls are in `c4747dc7`, running
Linux `connection-repeat` in `39003964943`. Inspect and fix failures, then run
all six hosts and compare with the baseline. Pooled reuse, startup failure,
shared readers, cancellation, physical release, stress/reuse and binary review
remain acceptance requirements. Server/HTTP and pending sender values remain open.

## Local checks and continuing work

All native builds/execution run on GitHub. Use the root `scripts/local-guard.py`
with its fixed limits for focused local work. Formatting passed in 1.06–1.16s;
documentation audits in 2.55–2.60s. Seven mocked native-runner selection tests
passed in 0.89s. Combined evidence collection passed in 22.05s, closed-baseline
collection in 28.43s; static Linux inspection took 0.15s per architecture.
No downloaded executable ran locally. The final documentation audit passed in
2.55s after restoring the required roadmap status table and next-action marker.

Pending sender iterators, retained server callbacks/channels, host re-entry,
remaining numerical/network ownership, cycle policy and all seven roadmap work
areas remain open. Audit unused callback fields before adding owners. Fatal
allocation paths using `exit` on task stacks need repair without weakening library
unload checks. Remote calls remain excluded from checked ARC. JIT is permanently
excluded. Historical preparation anchors are evidence, not additional tasks.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Typed stream and external owners; remove tracing |
| 2 | In progress | Remove intermediate storage and unnecessary reference counts |
| 3 | In progress | Reduce equivalent-work C/Rust gaps |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Repeated, comparable performance measurements |
| 7 | In progress | Larger representative applications |
