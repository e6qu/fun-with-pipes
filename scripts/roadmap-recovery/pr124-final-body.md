Resource and network operations now retain borrowed metadata and release owned files, channels, HTTP/2 and gRPC contexts through errors and task cancellation. Typed State scopes retain stored values, own get/results and release replaced values across normal and nonlocal exits, including escaping closures.

The bundle also fixes AD tape bounds and cleanup, list callback ownership, compiler failure diagnostics and executable-cache lifetime. Two effect-inference fixes preserve stored callback effects and reject missing IO; autodiff formatting and the roadmap parser are repaired.

Validation: combined runner preflight38173831552 passes 71 library units, type snapshots, positive/negative effect controls, formatting, stdlib docs and State ownership controls. State tests compare raw interpretation with native O1/O2, stack on/off and GC/reuse verification. Full six-job Linux/macOS matrix38174221614 is running on 1aadb8a075e1737d0e6a4db96eae5d675f6fb404; its exact-head documentation audit passes. All six jobs must pass before squash.

Tracing remains a fallback for unmodeled ownership. Earlier allocation counters cover a subset of allocator paths; corrected runner measurements are pending and no total-allocation or tracing-free claim is made.
