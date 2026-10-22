# Session handoff

## Current delivery

Main is `f74c9d2998d595b4a3c15ee4a225a49963c1a6ea`, the verified squash merge of
[PR #194](https://github.com/e6qu/fun-with-pipes/pull/194). All nine production
jobs and documentation passed. Its files, parent and single-line message were
verified; redundant same-tree push CI was cancelled. Evidence:
`/private/tmp/fwp-194-final-acceptance.json` and [history](roadmap-history.md).

[PR #195](https://github.com/e6qu/fun-with-pipes/pull/195) is the sole active PR,
at `a284eb0a338cae4efdd9534fd2d67c60a4f04e82`, branch `native-command-ownership`,
worktree `/private/tmp/fwp-native-command-delivery`. Final production run
`39753716407` has passed benchmarks and regular/GC-stress ARM macOS; both Linux,
both Intel macOS and both Windows jobs are still running without failed steps.
Documentation run `39753716342` passes. Preserve this head while gates finish.

This delivery adds explicit native ARC selection across commands, recovers native
tests after root failures, releases error messages and pending task/state owners,
repairs concurrent executable publication and Windows server/cache cleanup, and
records derivative workspace measurements. Tracing remains the default. Child
traps/exits remain process-fatal in both engines.

Focused source `3a56acd7bf9003df61293bd71abd01bc1c0d4c60`, run `39752987389`,
passes all six native hosts: 23 integration tests each and 176 AMD64 Linux unit
tests. All 84 actual binaries were independently inspected, including generated
C, instructions, cleanup controls and tracing-code exclusion in ARC. Earlier
Windows monitor quoting/cache/process failures and fixture errors are repaired;
failed-run receipts are retained, not counted as support. The derivative report
also has both Linux jobs and all 104 image inspections accepted at `be8d87f0e56c`.
Do not repeat accepted measurements/downloads.

**Next:** audit all final-head jobs; fix every failure together. Once all nine
production jobs and documentation pass, use the prepared merge helpers below.
They verify acceptance, squash with one subject of at most 80 characters and
empty body, and verify the resulting files, parent and message. Continue the
next combined batch afterwards. Publication and merge are already authorized.

## Next combined batch

Branch `compare-derivative-descent`, worktree `/private/tmp/fwp-ad-comparison`,
is based on #195's head. No second PR is open. After #195 merges, replay its
prepared commits onto the identical merge tree and verify files before updating
delivery docs. Preparation contains:

- **Accepted C/Rust comparison**, source `018581d6c0711b6a0eba81ed9fdb3e7c41973576`,
  run `39755925964`: both Linux jobs and 72 actual image inspections pass. Four
  programs compute the same Rosenbrock descent: reverse AD, explicit fwp, explicit
  C and explicit Rust. At 129 coordinates/199 updates, explicit fwp takes
  6.38×/6.91× C time on AMD64/ARM64; AD adds another 5.60×/6.56× relative to
  explicit fwp. C/Rust reuse flat buffers while fwp uses lists; these are complete
  implementation comparisons, not isolated compiler overhead. Exact samples,
  counts and limits are in the prepared `docs/measurements/descent-peers.md` and
  its data. F64 values already fit inline; investigate containers and closures.
- **Copied C callback inputs**, published at
  `6d8ef30bb428e1c0743de4a28fba62b7f3149b36`, run `39758960569`: checked ARC now
  admits copied strings for synchronous callbacks. Returned managed addresses
  and struct-valued callback arguments remain unsupported. Cases retain copies
  after C mutates buffers, nest callbacks, suspend, cancel and fail partway
  through input conversion. A deliberately omitted input owner must fail cleanup.
  Four C interop tests now fail explicitly on missing compilers. Four native
  hosts and the 32-bit interpreter/WASI job pass; Intel Mac and AMD64 Linux remain
  pending. Audit full logs and inspect every native host's artifacts before acceptance.
  The audit's command-echo false positive was fixed without excluding actual failures.
- **Packed-array comparison**, being prepared locally: explicit derivatives read
  checked indices from immutable `Array[F64]` and generate a new packed output
  array each update. This uses existing language features, not a compiler change.
  Compare all five forms together at the same six sizes; 40 samples rotate/reverse
  execution order. For cases with at least 199 updates, require fewer managed
  allocation requests and no higher managed peak than the explicit-list form.
  Require the original fwp forms to reproduce accepted memory profiles exactly.
  Report retains, all timings and remaining gaps; no speed threshold is claimed.
  Local oracle checks pass; native measurements remain required on both Linux hosts.

The accepted comparison report, plan/application updates, packed fixture and
measurement workflow are local edits awaiting the next preparation commit.
Keep the frozen four-way measurements intact when recording the new experiment.

## Checks and resource limits

Run focused local checks serially through
`python3 scripts/local-guard.py python3 SCRIPT`. Recent passing checks:

| Script under `/private/tmp/` | Result |
|---|---|
| `fwp-ready-native-delivery.py` | 6.60s; formatting, workflow, docs and lossless derivative-data reconstruction |
| `fwp-check-callback-inputs.py` | 1.36s; saved-interpreter callback and partial-conversion examples |
| `fwp-ready-callback-inputs.py` | 7.46s; formatting, workflow, frozen primitive inventory and docs |
| `fwp-check-descent-report.py` | 2.82s; links, exact accepted samples and 72 image records |
| `fwp-check-packed-descent.py` | 4.76s; independent oracle at boundary indices and multiple sizes, formatting/workflow |

Saved-interpreter checks do not verify new compiler behavior. Full builds, suites
and measurements run on GitHub. Preserve 64 GiB free disk, generated targets below
2 GiB, sampled RSS below 1 GiB and the 180-second guard deadline. Never raise limits.
The guard previously refused below 64 GiB; 411 MiB of completed-delivery downloaded
archives were removed, preserving reports/hashes/receipts and all current evidence.
Cleanup receipt: `/private/tmp/fwp-completed-archive-cleanup-20261022.json`.

## Resume files

| Purpose | Local path under `/private/tmp/` |
|---|---|
| #195 publication and final audit | `fwp-native-command-delivery-publication.json`, `fwp-audit-195-final.py` |
| #195 acceptance | `fwp-195-final-acceptance.json` |
| Ready merge/postmerge helpers, not yet run | `fwp-merge-195.py`, `fwp-after-merge-195.py` |
| Six-host command acceptance and images | `fwp-native-commands-acceptance.json`, `fwp-native-command-evidence/3a56acd7bf90/` |
| Accepted derivative workspace | `fwp-ad-memory-acceptance.json`, `fwp-ad-memory-evidence/be8d87f0e56c/inspection.json` |
| Four-way comparison source and accepted evidence | `fwp-ad-comparison-preparation.json`, `fwp-descent-peers-acceptance.json`, `fwp-descent-peers-evidence/018581d6c071/` |
| Callback source/run and audit | `fwp-callback-input-publication.json`, `fwp-audit-callback-inputs.py` |
| Callback image inspector | `fwp-inspect-callback-inputs.py --host HOST` |

The primary checkout is detached at #194 with this handoff as its only edit;
run guarded checks there. Prepared delivery and older measurement worktrees
preserve their exact sources. Do not modify accepted source heads.

## Roadmap status

| Step | Status | Area |
|---|---|---|
| 1 | In progress | Remove tracing; limit ARC. |
| 2 | In progress | Remove avoidable functional costs. |
| 3 | In progress | Meet measured machine-level budgets. |
| 4 | In progress | Improve autodiff time, memory and precision. |
| 5 | In progress | Validate CPU numerical kernels. |
| 6 | In progress | Establish comparable measurements and budgets. |
| 7 | In progress | Complete the finite application suite. |

All seven [plan](../PLAN.md) areas remain open. Retained foreign callbacks,
host owners and cyclic data remain ownership work. A completed batch does not
finish these goals. Continue substantial related batches with one active PR.
JIT is excluded.
