# Complete-gradient method comparison

All four sessions and their evidence audits pass at source
`04ddc0ac5d296ec895364236c4120341d7328e41`, [run 42500492246](https://github.com/e6qu/fun-with-pipes/actions/runs/42500492246).
This compares **fwp methods with other fwp methods**, not fwp with C/Rust/Swift.
[The frozen contract](../structured-autodiff.md) defines formulas, inputs,
complete-gradient boundaries, settings and the original noise rule.

| Session | CPU | Failed identical-copy controls | Verified job |
|---|---|---|---|
| arm1 | Neoverse-N2 | 16/41 | [job 128791969735](https://github.com/e6qu/fun-with-pipes/actions/runs/42500492246/job/128791969735) |
| arm2 | Neoverse-N2 | 17/41 | [job 128791969927](https://github.com/e6qu/fun-with-pipes/actions/runs/42500492246/job/128791969927) |
| amd1 | AMD EPYC 9V45 96-Core Processor | 24/41 | [job 128791970017](https://github.com/e6qu/fun-with-pipes/actions/runs/42500492246/job/128791970017) |
| amd2 | AMD EPYC 9V74 80-Core Processor | 20/41 | [job 128791969912](https://github.com/e6qu/fun-with-pipes/actions/runs/42500492246/job/128791969912) |

Each session covers 14 inputs and 41 method/input combinations. Timing uses
ordinary binaries, two warmups and 24 paired rounds; each call includes all
conversions and gradient assembly. Input construction, release and process
elapsed time are separate. Sessions 1 also measure storage, compiler time/RSS,
process RSS, image size and stack frames in separate executions.

## What the results support

- On the 129-input neighboring objective, qualified sessions show local forward
  AD taking 0.43× reverse AD's computation time on AMD session 2 and 0.48× on ARM
  session 1. The other two sessions fail copy controls: no four-session claim.
- Independent per-element forward AD takes 0.63× reverse time on ARM session 1.
  The other three sessions fail copy controls. Tensor AD is not automatically
  faster: AMD session 1's qualified 129-input result takes 3.18× reverse time.
- Dense 33-by-33 coupling favors reverse mode: forward takes 12.28× its time on
  AMD session 2 and 15.24–15.28× in both ARM sessions. AMD session 1 is inconclusive.
- Small, sub-microsecond calls often fail the 2% copy-noise limit. Original
  inconclusive results remain retained; no unchanged timing reruns are required.
- CPU models differ between AMD sessions; ratios stay within each session.

## Storage and the selected next change

Both architectures report the same counts below, with workspace reuse enabled.
Requests include ordinary input construction, computation and output storage;
raw tape storage is separate. These are per complete call (`n=129`, one repeat).

| Objective/method | Managed requests | Managed peak bytes | Raw tape peak bytes |
|---|---:|---:|---:|
| Neighbors, reverse | 900 | 9,536 | 33,888 |
| Neighbors, local forward | 1,284 | 9,536 | 0 |
| Independent, reverse | 519 | 14,944 | 29,824 |
| Independent, local forward | 518 | 9,536 | 0 |
| Independent, tensor | 1,718 | 30,304 | 0 |

Every managed observation returns to its initial baseline after real constant
cleanup; raw tape buffers reach zero after real shutdown, with reuse on and off.
Managed peak and raw peak occur at potentially different times; do not add them
and call the sum an observed total peak. Common runtime initialization is outside
the managed window; RSS is not interchangeable with these counters.

Generated C explains a removable cost: `derivative loss` remains an indirect
callback inside `array.map`, constructing `Dual` records. The neighboring
`array.generate` similarly passes a known edge function through an indirect
call. The optimizer's existing higher-order specialization handles list
operations but omits these array primitives. Extend that existing proof rather
than introducing new public syntax/API. [Candidate acceptance](../structured-autodiff.md#selected-change-known-array-callbacks)
is frozen before the compiler change.

## Reproduce the evidence

For each session, `*-artifact.json` records GitHub's original archive ID, size,
SHA-256 and source. The unchanged ZIP retains commands, sources, generated C,
actual native binaries, samples, resource reports, safety receipts and audits.
Adjacent JSON files are readable copies of the reports; `.log.gz` retains the
complete job log. All archive digests were checked locally.

The runner's `scripts/audit-structured-ad.py` reconstructs every source, command,
sample and summary and checks native image identity. Its negative controls reject
missing samples, altered arithmetic flags, wrong architecture, invented ratios,
and (session 1) unreleased memory, then restore the original bytes before upload.
All four complete logs were reviewed without unexpected diagnostics.
