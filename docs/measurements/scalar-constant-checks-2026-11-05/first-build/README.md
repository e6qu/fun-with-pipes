# First scalar-constant build: visibility repair

Run `42034673196`, source `d99dbacd4f0f7d24e938bde1cb17956d184804bf`.
All three hosts pass Rust formatting, then fail library compilation and linting.
Every error is E0616: the packed-fold caller reads the shared proof's private
`program` field at five sites. Native targets and compiler unit tests do not run.

The repair makes that immutable program reference visible within the C backend;
the proof's memoization remains private. All three full job logs and all six
artifact archives are retained. Their hashes and source identities agree; every
format log is empty and both compiler logs have the same five E0616 errors.
No failure was hidden and no passing semantic verification is claimed.
