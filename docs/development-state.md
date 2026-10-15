# Session handoff

Updated 2026-10-15. This is preparation branch `checked-console-ownership` in
`/private/tmp/fwp-console-ownership`, based on `7a463be9` of the numerical
precision preparation. No PR is open for this branch.
[PR #146](https://github.com/e6qu/fun-with-pipes/pull/146) is the only active
PR, at `930645e6`; production
[38796862558](https://github.com/e6qu/fun-with-pipes/actions/runs/38796862558)
is running after fixing Windows test-host CRLF output. Never merge until all
nine production jobs and documentation pass for the final commit.

Standing authorization covers roadmap fixes, publication and squash merges,
with exactly one-line commit messages of at most 80 characters, no body,
trailers or attribution. Keep one active delivery PR and bundle coherent work.

## Roadmap status

| Step | Status | Next concrete work |
|---|---|---|
| 1 | In progress | Validate C boundaries and solver scratch/result ownership |
| 2 | In progress | Remove measured closure, container and call costs |
| 3 | In progress | Diagnose remaining Intel array and matrix wrapper overhead |
| 4 | In progress | Investigate sustained derivative timing differences |
| 5 | Pending | Broaden CPU kernels and resolve runtime OpenCL compilation |
| 6 | In progress | Preserve comparable C/Rust measurements and profiles |
| 7 | In progress | Extend numerical and long-running application coverage |



## Prepared console ownership batch

Admit `read-all`, `read-line`, `read-lines`, `args` and `env.get` to checked ARC. `read-lines`
previously left its temporary whole-input string to GC; now it releases that
copy after making the returned lines. Protect the external input buffer until
UTF-8 conversion completes, the string while constructing `Some`, and partial
line/argument lists. The existing `lines` primitive uses the same protected list
builder and returns an already-owned tree. Preserve immutable copies, input
order, invalid UTF-8 replacement, CRLF rules and end-of-input behavior.
No new syntax, fallback or public wrapper is introduced.

Acceptance: raw interpreter/native agreement for empty, multiline, CRLF,
invalid UTF-8 and embedded-NUL input; repeated calls with no retained charge;
injected failure at each string/node/buffer allocation; forced GC/reuse tests;
negative controls omitting the input-string free and the external-buffer free.
Check both tracing and ARC at O1/O2 on all maintained native targets.
Environment listing and other IO remain unreviewed; keep a negative ARC test
for `env.vars`. The old negative `read-all` assertion is replaced by positive
console tests, not silently removed from coverage.

Input storage is not free: `read-all` materializes the entire stream and
`read-lines` copies its lines. `each-line` and `fold-lines` read one line at a
time; their retained state and callbacks determine additional live storage.
This batch establishes ownership, not a timing or zero-allocation claim.

## Checks and limits

All local checks use `python3 scripts/local-guard.py COMMAND...`, serially
within the fixed limits. No compiler rebuild or full local gate was run.

- Current primitive inventory passes (1.31 s): 236 explicit contracts,
  10 flat scalar signatures, 113 declarations needing review, 19 lowered
  templates and 103 distinct unreviewed symbols. The updated check passed
  in 0.61 s. The baseline is unchanged.
- Existing-compiler C with edited runtime passes 128 calls per operation,
  forced collection off/on, every injected allocation failure and preserved
  borrowed input ownership. The extended probe counts outstanding C input
  buffers separately from managed bytes (2.31 s). Omitting input-string release
  fails with 205; omitting buffer release fails with 211.
- Harness metadata and all five raw interpreter fixtures pass (3.75 s),
  including Unicode/empty process arguments. Formatting passes (0.98 s) and
  the roadmap/documentation audit passes (2.51 s). Full changed-compiler
  validation remains required.

A focused interpreter/native probe also exposed an environment lookup bug:
`"FWP_ENV_COPY\0suffix"` returned the prefix variable natively, but `None` in
the interpreter (guarded reproduction, 2.51 s). Native lookup now rejects the
zero byte, protects the copied string during `Some` construction, and preserves
it after the environment changes. The redundant Windows option wrapper is
removed; the existing UTF-16 conversion helper remains. The extended runtime
probe passes both collection modes and leak controls (2.36 s); harness metadata
passes (3.72 s). The original console run has passed Linux AMD64/ARM64 and ARM
macOS; Intel macOS is still running. The environment addition requires its own
updated four-host run and final production coverage.

## Delivery order

The preceding solver batch lives in `/private/tmp/fwp-linear-algebra`, branch
`checked-linear-algebra`. Run
[38795634707](https://github.com/e6qu/fun-with-pipes/actions/runs/38795634707)
at `ec1ff14b` has passed AMD64/ARM64 Linux and ARM64 macOS; Intel macOS is running.
Its later `6af4f207` changes only handoff/source comments. It owns six solver
workspaces/partial results, bounds QR output and borrows invariant F64 array data.

F128 precision lives in `/private/tmp/fwp-quad-grad`, branch
`quad-gradient-precision`, based on solver commit `3e5d86ad`. Run
[38797434546](https://github.com/e6qu/fun-with-pipes/actions/runs/38797434546)
at `7a463be9` is running. It preserves F128 weights/seeds/adjoints with the existing
typed tape protocol. Its own handoff distinguishes bounded probes from runner
acceptance and explains boxing/reference-count costs.

## Next action

Next: publish and monitor the focused console evidence run. Monitor and fix #146 first. After it merges, rebase only solver commits
after `c10b1ccd` onto its accepted squash commit, then bring only precision
commits after `3e5d86ad` into that branch for one substantial numerical PR.
Keep this console batch separate unless validation justifies a coherent combined
delivery; its own commits begin after `7a463be9`. Record results in the live
handoff and run full exact-head CI before every merge. The unexplained Intel
compiler abort in the preceding numerical evidence remains unresolved.
