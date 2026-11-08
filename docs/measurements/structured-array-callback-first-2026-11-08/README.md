# First array-callback candidate: allocation target missed

Source `b0a2becabf7acc474a410002df6a8f88d2c1ddb4`,
[run 42501889779](https://github.com/e6qu/fun-with-pipes/actions/runs/42501889779).
All three hosts pass gradient outputs, numeric proofs, map/generate order,
unknown callbacks, unwinding, F128 and nested derivatives. All fail the same
neighbor-local allocation limit: **768 requests over 32 calls**, versus a
256-request limit (`n=3`, eight per call). Final managed storage is zero.

| Host | Job |
|---|---|
| AMD GCC | `128796236394` |
| ARM GCC | `128796236592` |
| macOS Clang | `128796236348` |

All complete logs are retained and reviewed. The driver originally stopped at
this count assertion, so later independent-local and negative controls did not
run. The repair collects all allocation misses before failing the job.

Generated C explains the miss: `array.generate-fn` still calls the original
large coordinate worker with a function-valued edge argument. The worker exceeds
the ordinary 40-node inlining limit. Adding the array primitive to small-callback
specialization alone cannot expose that argument inside the worker.

The repair reuses the existing bounded known-function worker pass. It copies
one worker for the closed function argument, retaining ordinary inlining limits
and all other argument/resource boundaries. For arrays, the now-known closed
function parameter can be omitted: constructing that value has no effects or
captured owners. This also stops treating the edge as an escaping function value,
which otherwise prevents internal numeric-parameter lowering. The initial
forwarding-only array wrappers are removed: ordinary native array lowering
already calls the specialized worker directly.

No candidate timing run occurred. Original acceptance remains unchanged in
[the contract](../structured-autodiff.md#selected-change-known-array-callbacks).
The repair still needs focused and final native verification.

`amd.zip` is unchanged artifact `13625508268` (10,860,232 bytes), SHA-256
`a332ca1aeeeb0ad3925ad2b8e308cf1c08c85371c81af0cff92d4fa38faa09b8`.
It retains actual generated sources, native images, logs and observations.

## Repair check: invalid resource fixture

[Run 42503655664](https://github.com/e6qu/fun-with-pipes/actions/runs/42503655664)
at `f243db4bba63fdeb41f38d4a42d73664e6e69c59` stops at a new proof test on
all three hosts. The fixture incorrectly labels an integer as a resource owner;
the compiler rejects that invalid input. The other seven proof tests pass.
Later native checks did not run, so this gives no allocation or speed result.

`3203b635a813538350cefb90f13f09f9a641ee8b` corrects the fixture to use a File
parameter and validates the input before specialization. The workflow now runs
independent checks after an earlier failure, preserving a failing overall result.
[`worker-repair-checks.json`](worker-repair-checks.json) identifies the complete
reviewed logs and hashes. No unexpected compiler warnings occurred.

## Known worker: remaining numeric-input boxes

At `3203b635a813538350cefb90f13f09f9a641ee8b`, both Linux architectures pass
all proof, semantic, ordering, cleanup, F128, nested-AD and negative controls in
[run 42504579188](https://github.com/e6qu/fun-with-pipes/actions/runs/42504579188).
Independent-local `n=16` meets its 34-request limit. Neighbor-local `n=3` falls
from 24 to **16 requests per call**, still above its limit of 8. Both workspace
settings reclaim all managed and raw storage. macOS remained queued and was
cancelled when this source was superseded; it establishes no native result.

The known edge is now called directly, but its two `Dual` inputs remain heap
objects. Checked array access introduces an `Option[F64]` binding; the numeric
input proof accepts only scalar bindings. The next repair permits nonresource
data bindings while preserving the complete argument expression and its scope.
Possible resources, channels and captured-function owners remain excluded.
No timing run occurred and the original allocation limit is unchanged.

[`partial-worker-checks.json`](partial-worker-checks.json) records both complete
logs and the unchanged ARM archive, including generated C and native images.
