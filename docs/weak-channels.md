# Weak channel references

Implemented and verified in [PR #215](roadmap-history.md#weak-channels-and-retained-callbacks-pr-215).
Weak links let a queue refer back to itself without owning itself. They do not
remove tracing from the compiler or make every cyclic design safe.

## Operations and lifetime

A strong channel value owns its queue. `WeakChannel[a]` observes the identity of
a channel carrying `a`, without owning that queue or its messages. It owns only
small metadata that records whether the target still exists. Equality compares
target identity, including after expiration: two downgrades of one channel stay
equal, and references to different channels stay unequal. Comparing, displaying or
duplicating a weak handle does not inspect or duplicate its payload. Runtime
identities cannot be encoded, decoded or canonically hashed; use explicit
application keys when data must cross a serialization boundary. It is not a weak
reference to arbitrary values; no general boxing or shared-value wrapper is added.

```fwp
channel.downgrade : Channel[a] -> WeakChannel[a] ! {Async}
channel.upgrade : WeakChannel[a] -> Option[Channel[a]] ! {Async}
```

Both operations borrow their input. Downgrade returns an owned weak value.
Upgrade returns `Some channel` with an independent strong owner, or `None` if
the target has expired. The `Async` effect prevents treating a liveness observation
as a pure, freely movable calculation. Neither operation suspends.

Closing a channel stops sends but does not expire weak references: owners may
still drain its queue. Final strong release expires the target **before** any
queued value is destroyed. A successful upgrade keeps the channel alive until
that acquired owner is released. Failure to upgrade never resurrects a target.

Weak observation preserves original function-frame lifetimes for channel owners
and possible captured owners, including after inlining. It must not depend on
whether native last-use optimization ran. Programs with no weak channels retain
their existing lifetime optimization. A temporary passed directly to downgrade
does not gain an independent lasting owner from that operation.

For example, `alive` returns `True`: its input remains owned through the original
function call. `expired` returns only a weak value, so upgrading its result after
the call returns gives `None`.

```fwp
word-channel : I64 -> Channel[I64] ! {Async}
word-channel = channel.make

alive : Channel[I64] -> Bool ! {Async}
alive = channel.downgrade | channel.upgrade | option.is-some

expired : () -> WeakChannel[I64] ! {Async}
expired = const 1 | word-channel | channel.downgrade
```

`const 1` constructs a function that ignores its input and returns `1`; here that
number is the queue capacity. `option.is-some` returns whether an `Option` holds
a value. The [executable fixture](../tests/fixtures/weak_channels.fwp) checks
these lifetimes before and after optimization.

## Cycle checks

A queued callback may hold a weak link to its receiving channel. Its weak value
does not own the target's payload, callbacks or tasks. Upgrade restores a genuine
strong owner, so ordinary capture/store checks apply to its result.

The initial proof treats the upgraded channel's producer as unknown. It may be
used directly, but cannot be captured in a queued owner unless the existing rules
prove the relationship safe. This is deliberate conservative rejection, not an
empty capture set or a claim of exact target inference. Function-bearing channel
captures remain rejected even when obtained through upgrade. More precision must
pass G2's compiler-scaling measurements before adoption.

An internal graph edge that is weak does not make an independently strong edge
safe. Wrapped, returned and nested acquired owners must retain the same checks.
The [negative fixture](../tests/fixtures/weak_channel_cycle.fwp) attempts to store
an acquired strong channel in its own queued callback and must fail compilation.

## Runtime representation

When a generated program uses weak channels, its channel structure has one
nullable metadata pointer. The first downgrade allocates one control object;
later downgrades reuse it. Programs without the feature omit that field.
The control object has one owner held by the live channel plus one per weak
value. The channel's final release clears the target, releases that metadata
owner, then destroys queued values and the channel itself. The control object
is freed after its last owner disappears. It may outlive the payload, but cannot
keep that payload alive. Address reuse cannot change an expired control object
back into a live one.

These operations use the existing serialized scheduler: native tasks execute on
one event loop, and interpreter tasks hold the scheduler baton. Upgrade does not
yield between checking the target and retaining it. This is not an arbitrary
OS-thread sharing API. External retention needs a separate registration and
active-call protocol; weak channels do not supply one implicitly.

Weak channels use the ordinary counted ownership model. Their metadata stores
an identity and expiration state without owning the target; no scan can turn
that address into a strong edge. Allocator/static-pool and WASI checks passed
with #215. G5 must pass them again on the collector-free implementation.

## Required evidence and remaining work

The tests in [queued_functions.rs](../tests/queued_functions.rs) cover
raw/optimized interpretation versus native O1/O2, close versus expiration,
returned weak captures, attempted cycle recreation, repeated metadata cleanup,
actual address reuse, identity equality, allocation failure, language error and
task cancellation. A native reference-count overflow during upgrade must release
the unfinished `Some` cell without releasing the borrowed target. A control that
omits that construction cleanup must fail its allocation-balance check.
Dynamic/static native storage and WASI JSPI/Asyncify cases
are included. Deliberately omitting expiration or the channel's
metadata release must fail independently. The runtime probe checks expiration
before dereferencing a deliberately invalid target.

All production gates passed for #215. Further proof precision must respect
[G2's measured analysis budgets](measurements/ownership-analysis.md). Count savings alone are not a timing
improvement; [the benchmark guide](benchmarks.md) explains the distinction.
