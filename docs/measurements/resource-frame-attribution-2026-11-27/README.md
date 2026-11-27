# Executed lifetime frames, callable captures and HTTP holds

**Whole original frames account for substantial executed work; plain HTTP fields
do not.** Both native Linux hosts agree on all retained counts. This census
selects the [value-protection extension](../resource-field-costs.md#selected-extension-carry-enclosing-lifetime-protection-through-values);
it does not measure time or establish a speedup.

| Complete workload | All cleanup registrations | Original-frame registrations | All successful retains | Original-field retains | Plain-field retains |
|---|---:|---:|---:|---:|---:|
| Service: 4,096 messages, delivery, 16-integer payload | 606,259 | 131,082 (21.6%) | 290,826 | 77,832 (26.8%) | 4,098 (1.41%) |
| HTTP: startup, 256 item requests, graceful shutdown | 764,066 | 186,012 (24.3%) | 285,113 | 88,910 (31.2%) | 257 (0.09%) |

A lifetime frame preserves when resources close or weak targets expire. Its
registration is separate from an ordinary last-use owner. A hold attempt can
refer to static/stack storage and perform no count increment. Typed destruction
can release children; its inclusive decrement count is not all removable work.

Direct callable fields in the service hold function 30 8,193 times, with two
captures, and function 51 8,192 times, with one capture. The saved C identifies
the former's two integer captures and the latter's captured callback. The HTTP
process makes 48,161 direct callable hold attempts, including 24,838 capture-free
closures; 17,416 attempts increment a reference count. These observations do not
classify callbacks hidden inside opaque aggregates or establish a static proof.

Each host runs 44 executions and verifies 12 actual native images. The service
uses 64/4,096 messages in delivery, cancellation, expiration and handled-error
modes. HTTP uses 64/256 synchronous `GET /items/42` requests over one persistent
loopback connection, checking every complete response before SIGTERM shutdown.
GCC O1/O2 builds have no LTO. Baseline counters and attributed counters are
separate builds; an actual extra plain-field retain/release changes each selected
counter by exactly one. Service totals remain identical under attribution.
Every execution restores initial charged live bytes; HTTP also requires no
remaining task or cleanup frame. The census covers cleartext HTTP, not TLS load.

The [original run](https://github.com/e6qu/fun-with-pipes/actions/runs/46063375647)
uses tool source `041db8772962f0e15ff44d70b56f1142fc8aa103`, retained by
`roadmap/resource-frame-attribution-preparation-2026-11-27`. Its input C and exact
context/type classifications come from compiler census
`9b24e6965dd4c7cfb6e88163a34722e0b99ec901`. Both native jobs pass their image,
raw-command, reply, live-memory and actual-extra-owner audits, and reject altered
service/HTTP summaries with recomputed checksums. GCC versions and machine
identities are retained in each compressed report.

[The review export](https://github.com/e6qu/fun-with-pipes/actions/runs/46065853405)
verifies the complete original archives and reruns the native-image/raw auditor
on runners. The original ARM64 archive is `15229648038` (10,020,405 bytes,
SHA-256 `dd9b6ebb888841db899ba61b90e957d729c7ee4e26ba1e6578d96830311c6c03`);
AMD64 is `15230615554` (10,114,896 bytes,
SHA-256 `e4fbfa7cccf5c4e143eeb8340211ccd4007657c65517c70efcd470cd1f07213e`).
Native images remain in those archives; none was built or executed locally.

Run `python3 read.py` in this directory to reconstruct the small retained raw
records and all HTTP replies. The reader checks their hashes against the original
manifest and requires agreement between hosts. Binary identity verification is
the runner audit's evidence, not a claim made by the small retained reader.

The first preparation run `46062709945` failed on an overly broad service report
hook and missing OpenSSL link libraries. Both causes were repaired before this
passing run. No production ownership change is included in the census source.
