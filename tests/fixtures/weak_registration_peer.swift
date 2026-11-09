// Native weak references and a serial registration; no ARC count claims.
import Glibc

final class Counts {
    var calls = 0
    var destroyed = 0
    var disposed = 0
}

final class Target {
    let identity: Int
    let counts: Counts
    init(_ identity: Int, _ counts: Counts) {
        self.identity = identity
        self.counts = counts
    }
    deinit { counts.destroyed += 1 }
}

struct Registration {
    weak var target: Target?
    var cancelled: Bool
}

func dispatch(_ registration: inout Registration, _ outside: inout Target?, _ counts: Counts) -> Bool {
    if registration.cancelled { return false }
    guard let active = registration.target else { return false }
    // Keep the acquired owner through the entire callback, including reentry.
    return withExtendedLifetime(active) {
        counts.calls += 1
        precondition(active.identity == 7)
        registration.cancelled = true
        outside = nil
        precondition(counts.destroyed == 0)
        precondition(!dispatch(&registration, &outside, counts))
        guard let nested = registration.target else { preconditionFailure("lost active owner") }
        precondition(nested.identity == 7)
        precondition(counts.destroyed == 0)
        return true
    }
}

func run() {
    let counts = Counts()
    var registration = Registration(target: nil, cancelled: true)
    precondition(registration.target == nil)
    var owner: Target? = Target(7, counts)
    registration.target = owner
    precondition(!dispatch(&registration, &owner, counts))
    precondition(counts.calls == 0 && counts.destroyed == 0)
    registration.cancelled = false
    precondition(dispatch(&registration, &owner, counts))
    precondition(owner == nil && counts.calls == 1 && counts.destroyed == 1)
    precondition(!dispatch(&registration, &owner, counts))
    registration.cancelled = false
    precondition(!dispatch(&registration, &owner, counts))
    for identity in 0..<64 {
        let replacement = Target(identity, counts)
        withExtendedLifetime(replacement) {
            precondition(registration.target == nil)
        }
    }
    precondition(counts.destroyed == 65)
    owner = Target(9, counts)
    registration.target = owner
    do {
        _ = try dispatchError(&registration, &owner, counts)
        preconditionFailure("callback error was lost")
    } catch CallbackError.failed {
        precondition(owner == nil && counts.calls == 2 && counts.destroyed == 66)
    } catch {
        preconditionFailure("unexpected callback error")
    }
    precondition(registration.target == nil)
    do {
        let entered = try dispatchError(&registration, &owner, counts)
        precondition(!entered && counts.calls == 2)
    } catch {
        preconditionFailure("expired callback was entered")
    }
    queuedChecks()
    print("calls=2 destroyed=66 expired=1 cancelled=1 error=1 queue=1")
}

enum CallbackError: Error { case failed }

func callbackError(_ acquired: Target, _ outside: inout Target?, _ counts: Counts) throws {
    precondition(acquired.identity == 9)
    counts.calls += 1
    outside = nil
    precondition(counts.destroyed == 65 && acquired.identity == 9)
    throw CallbackError.failed
}

func dispatchError(_ registration: inout Registration, _ outside: inout Target?, _ counts: Counts) throws -> Bool {
    guard let acquired = registration.target else { return false }
    return try withExtendedLifetime(acquired) {
        try callbackError(acquired, &outside, counts)
        return true
    }
}

final class Payload {
    let value = 11
    let counts: Counts
    init(_ counts: Counts) { self.counts = counts }
    deinit { counts.disposed += 1 }
}

struct Pending {
    weak var target: Target?
    let payload: Payload
}

func queuedDispatch(_ entry: consuming Pending, _ outside: inout Target?, _ counts: Counts) throws {
    guard let held = entry.target else { return }
    try withExtendedLifetime(held) {
        counts.calls += 1
        precondition(held.identity == 17 && entry.payload.value == 11)
        outside = nil
        precondition(counts.destroyed == 0 && held.identity == 17)
        throw CallbackError.failed
    }
}

func drainQueue(_ queue: inout [Pending?], _ outside: inout Target?, _ counts: Counts) throws {
    // Callback failure discards remaining payloads and weak registrations.
    defer { queue.removeAll() }
    for index in queue.indices {
        guard let entry = queue[index] else { continue }
        queue[index] = nil
        try queuedDispatch(consume entry, &outside, counts)
    }
}

func queuedChecks() {
    for cancelled in [true, false] {
        let counts = Counts()
        var owner: Target? = Target(17, counts)
        var queue: [Pending?] = [Pending(target: owner, payload: Payload(counts)),
                                 Pending(target: owner, payload: Payload(counts))]
        if cancelled {
            queue[0] = nil
            precondition(counts.disposed == 1 && counts.destroyed == 0)
            owner = nil
            precondition(counts.destroyed == 1)
        }
        do {
            try drainQueue(&queue, &owner, counts)
            precondition(cancelled && counts.calls == 0)
        } catch CallbackError.failed {
            precondition(!cancelled && counts.calls == 1)
        } catch {
            preconditionFailure("unexpected queued callback error")
        }
        precondition(queue.isEmpty && owner == nil)
        precondition(counts.destroyed == 1 && counts.disposed == 2)
    }
}

if CommandLine.arguments.count != 1 {
    let bytes = Array("expected no arguments\n".utf8)
    bytes.withUnsafeBytes { data in
        _ = write(STDERR_FILENO, data.baseAddress, data.count)
    }
    exit(2)
}
run()
