# Packed derivative inputs: native correctness

[PR #257](https://github.com/e6qu/fun-with-pipes/pull/257) is verified delivery.
Its [nine final production gates and documentation](platforms/final-gates.json)
pass at `519fc966`; every full and target log is retained and audited. Squash
`30c2bad9` has the exact same tree and the required one-line message.

[Run 41840527818](https://github.com/e6qu/fun-with-pipes/actions/runs/41840527818)
passes at `ba23c6ea7226c31f626839530035e717f3ce05c7`. This verifies the compiler
and cleanup change; performance and final production coverage remain pending.
[Earlier failures](../packed-input-selection-2026-11-04/README.md) remain retained.

| Host | Job | Audited result |
|---|---|---|
| Linux ARM64, GCC | 126610608861 | [Audit](arm/verified.json) |
| Linux AMD64, GCC | 126610609022 | [Audit](amd/verified.json) |
| macOS ARM64, Clang | 126610608502 | [Audit](mac/verified.json) |

Every host passes:

- 277 compiler unit checks (four existing ignored tests), primitive contracts,
  lint, formatting and all twelve real-gradient/source controls.
- 93 integration tests across fifteen targets, including autodiff scopes,
  precision, workspace, callback effects and ownership cleanup.
- 34 new native images at O1/O2: both window orders, normal/disabled reuse,
  omitted frees, corrupted input, extra allocation, F32/F64 bits and one-field
  records. Both interpreters and ordinary native programs agree on values.
- Exact allocation counts at the exported test boundary: two buffers, one
  exported result box and one internal fold box only for two or more inputs.
  The deliberately extra allocation is rejected with status 248; missing frees
  return 90 and corrupt values return 241. These are required observer controls.

Each full audit checks 642 native image machine types, all artifact hashes,
655 saved statuses and every target log. Each host directory retains 262 files
in `controls.zip`: all target/step logs, the 34 new probes, selection evidence
and compiler-cost inputs. `retained-files.json` records their hashes;
`audit.json` inventories the complete downloaded artifact, whose identity is
in `artifact.json`. No unexplained failures or compiler warnings remain.

[Documentation](docs-audit.json) also passes in run `41840511498`, job
`126610537046`, at the same source. Its [full log](docs-job.log.gz) contains the
intentional failing-test control that checks the CI runner's failure reporting.

## Compiler-cost fixture repair before timing

Compilation alone did not establish the intended workload. Generated C showed:

- The repeated fixture reached only `scope0`; executable builds do not root
  every unused export. It therefore tested one call instead of 64.
- Both entry points used a constant input. The conservative type check could
  specialize an unused helper while leaving the live call unchanged. A name
  in function metadata did not prove a live specialization.
- The large function expression becomes a shared helper containing 5,120
  dynamic callback calls. Its small wrapper may specialize; it is not itself
  an oversized body. The separate unit test checks direct size-limit rejection.

The corrected entry explicitly calls all 64 functions and obtains its value
from the number of input lines. Compiler benchmarks emit C without executing
these programs. Before any timed command, candidate and reference now compile
both fixtures and verify actual scope-call counts, live specialization entries
and the single large body. Failures and timeouts retain both fixture results.

The corrected inputs type-check, and the new checker rejects both original
CI outputs (0.59s). An intermediate function-valued `main` was rejected locally;
the final entry is a value, as the language requires. Nine driver controls pass
(1.98s), including omitted calls, dead metadata, duplicated work and timeout
output. Production verification of the corrected fixtures is still pending in
the untimed comparison checks. No performance sample has run; the seven-case
schedule and acceptance limits are unchanged.

## Collection

AMD64 collection took 27.37s; ARM64 artifacts completed before the interrupted
terminal session was resumed. macOS collection took 26.86s. Independent audits
took 0.97s/0.83s/0.94s for AMD64/ARM64/macOS. Linux retention took 2.24s.
All ran serially through the fixed local guard. Full builds/tests ran on GitHub.
