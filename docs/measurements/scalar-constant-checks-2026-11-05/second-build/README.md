# Second scalar-constant build: borrow the test result

Run `42035958930`, source `b35c1c9968bfd72d37c0a05cb938012fa6b48b3a`.
All three hosts build the compiler and pass 296 unit tests, the primitive inventory,
nine reference/observer control groups, and selection checks in three complete
programs. Four ignored unit tests remain explicitly reported.

All-target lint and native test compilation fail with E0509 in the new
`caf_ownership` probe: it moves a record field out of `Value`, which has a
custom destructor. Borrow that record field with `ref`; preserve its owner.
No integration executable ran because their shared build failed.

All three full logs and six artifact digests were inspected. The preflight and
final artifacts have identical member hashes for each host; retain one archive
per host here and identities of all six. Formatting logs are empty. Scheduler
panic messages come from the passing deliberate-panic unit control; they are not
unresolved failures. The remaining diagnostics all report the same E0509 error.
