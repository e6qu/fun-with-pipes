# Shared tape access: production verification

The compiler change merged in #265 passes all nine production jobs and docs.
The complete log/artifact audit also passes. Later measurement-only PR #266 was
merged by the user; its separate production run is still pending.

| Record | Identity |
|---|---|
| Tested compiler source | `e187b92d75bf936bc7191ea11eeca0c573005399` |
| Production run | [42248510976](https://github.com/e6qu/fun-with-pipes/actions/runs/42248510976), attempt 1 |
| Documentation job | `127996978359` |
| Complete audit | [42288455657](https://github.com/e6qu/fun-with-pipes/actions/runs/42288455657), job `128135316320` |
| Audit tool source | `ef0a54a1da660fcc4c4e094e96c30c1adbe0fb5d` |
| Compact archive | Artifact `13538558028`, 1,163,134 bytes |
| Archive SHA-256 | `c576b264684ab4692eaa9ac8c1584695ce088f553dd1bf42a2317917e40403eb` |

[The retained archive](production-audit.zip) contains all ten job logs, their job
and audit records, eight native target-log archives, and Windows probe logs.
The issue list is empty. Local guarded verification checked the archive digest,
source and success status, ten complete job-log hashes and 1,456 target/probe-log
hashes. [The verification index](verified.json) gives counts and job IDs per host.
The complete audit log contains no compiler or test failure.

The [48 original measured images](../recording-context-images-2026-11-06/README.md)
also reproduce exactly. These checks establish correctness and artifact identity;
they do not close the [recorded speed targets](../recording-context-time-2026-11-06/README.md).
