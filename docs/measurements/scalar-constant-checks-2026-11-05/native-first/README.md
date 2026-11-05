# Native cache probe: preserve a computed scalar

Run `42037640087` tests `943f749e69aaca1a052f59806c0520cdfefa859c` on
GCC Linux ARM64/AMD64 and Clang macOS ARM64. All hosts pass formatting, all-target
lint, 296 compiler units, primitive contracts and complete-program selection.
The new exact-bit/root probes pass at O1/O2, including signed zero and NaN payloads.

Each host completes all 25 native targets: 24 pass; `caf_ownership` has three
passing tests and one failing observer. The test expects a runtime character-length
operation on literal text, but `scalar_text::lower` already folds that operation.
The new scalar pass then correctly replaces its cached result. Fix the test to
use `string.byte-length`, which remains a computed scalar at this boundary.
Keep the strict one-operation assertion, cache owners and all broken controls.

Audit `42043247325` records all 25 target logs, 814 native images and 830 probe
observations per host. Its failure correctly reports the original failed probe;
all nine findings are that target, its job status and its diagnostics across
three hosts. No other failure or warning was found. The verified `audit.zip`
retains those reports/logs and original artifact identities. The repair still
needs a passing focused run; this archive is not an acceptance result.
