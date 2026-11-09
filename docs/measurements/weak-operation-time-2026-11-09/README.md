# Weak-reference time and process memory

The measured fwp API boundary is much slower than C/Rust for repeated weak
lookups. Swift comparisons depend on the host and phase. This experiment includes
fwp's channel representation and owning function entry, whereas the native peers
borrow their arguments. It measures those real APIs, **not isolated ARC cost**.

[The frozen protocol](../weak-operation-time.md) specifies matched work, separate
modules, six phases, a C-only repetition pilot and two sessions per native host.
No callback or message delivery occurs here. Each table range below contains the
two session ratios; both sessions pass the 5 ms minimum and 2% identical-copy limit.
`fwp / peer = 2` means twice the elapsed time, or 100% extra time.

## Repeated lookup: 4,096 targets, 64 lookups each

Each process repeats the complete lifetime 256 times: 67,108,864 successful
lookups and the same number after target expiration.

| Host / phase | fwp / C | fwp / Rust | fwp / Swift |
|---|---:|---:|---:|
| ARM64 live lookup | 55.65–55.69 | Inconclusive | Inconclusive |
| ARM64 expired lookup | 29.23–29.26 | 13.06–13.09 | 1.90–1.94 |
| ARM64 complete process | 35.47–35.50 | 18.31–18.65 | Inconclusive |
| AMD64 live lookup | 43.11–43.18 | 20.32–20.36 | 0.476–0.478 |
| AMD64 expired lookup | 13.41–13.43 | 5.375–5.379 | 1.129–1.132 |
| AMD64 complete process | 24.20–24.27 | 11.91–11.95 | 0.547–0.549 |

The ARM64 Rust/Swift live-lookup copies differ by more than 2%; their raw ratios
remain recorded but do not qualify. AMD64 fwp live lookup takes about 52% less
time than Swift, yet expired lookup takes about 13% longer. Neither establishes
general language parity or service throughput.

## Construction and release matter too

For 4,096 targets with one lookup each, both sessions qualify:

| Host / phase | fwp / C | fwp / Rust | fwp / Swift |
|---|---:|---:|---:|
| ARM64 complete process | 4.537–4.545 | 5.636–5.642 | 0.753–0.754 |
| AMD64 complete process | 4.15–4.17 | 4.98–5.00 | 0.452–0.454 |
| ARM64 release strong owners | 3.285–3.288 | 11.49–11.60 | 0.423 |
| AMD64 release strong owners | 3.227–3.231 | 10.44–10.49 | 0.310 |

Every single-target phase/process comparison is too short or noisy. For 64
targets with 16 lookups, ARM64 complete-process time is 6.9–8.4% above Swift;
AMD64's complete-process comparison does not qualify. The retained reports include
all construction/lookup/release observations, including every failed limit.

## Memory and build costs

Ordinary largest-case peak RSS across three samples per session, in KiB:

| Host | C | Rust | Swift | fwp |
|---|---:|---:|---:|---:|
| ARM64 | 1,692–1,772 | 1,892–2,004 | 8,828 | 2,172–2,188 |
| AMD64 | 1,964–2,140 | 2,152–2,476 | 9,280–9,808 | 2,452–2,592 |

RSS includes libraries, runtime and caller storage. The separate
[allocation census](../weak-operation-census-2026-11-09/README.md) finds one
temporary 16-byte `Some` cell per successful fwp lookup and none per expired
lookup. Therefore that cell alone cannot explain the expired-lookup gap.

The fwp images contain 78,816 bytes on ARM64 and 61,144 on AMD64; C contains
71,424/16,880, Swift 81,368/35,008 and Rust 4,633,608/4,561,840. Linking and included
runtime/symbol content differ; image size is not working memory or speed.
Section and unwind reports are retained, but maximum dynamic stack use remains
unmeasured. One fwp C-emission observation takes 0.31/0.35 seconds with
42,308/43,100 KiB peak RSS; generated-C compilation/linking adds 0.78 seconds on
each host. These single build observations do not establish compiler scaling.

## Reproduction and verification

Source `031e6f794b1786d094e26d3fbbc16ef49c448082`, tag
`roadmap/weak-operation-time-2026-11-09`; GCC 13.3 O2, Rust 1.99.1 O2 and
Swift 6.4.2 O with whole-module optimization, no cross-module LTO.

| Host | Native job | Artifact |
|---|---|---|
| ARM Neoverse N2 | [129265753053](https://github.com/e6qu/fun-with-pipes/actions/runs/42647816522/job/129265753053) | `13692248877` |
| Intel Xeon Platinum 8370C | [129265753017](https://github.com/e6qu/fun-with-pipes/actions/runs/42647816522/job/129265753017) | `13693343388` |

Both jobs pass same-source phase correctness (36 builds, 252 native checks, two
interpreter checks), timing reconstruction and all six changed-evidence controls.
The 1,024 timing samples and 96 RSS observations per host are retained. Downloaded
timing samples reproduce every reported median/qualification from raw commands.
[Docs](https://github.com/e6qu/fun-with-pipes/actions/runs/42647826087) passes.
Complete logs contain only the optional g++ manual-page installation notice and
expected fault controls. [files.json](files.json) hashes reports, command journals
and full logs. No unchanged measurements were repeated to improve qualification.
