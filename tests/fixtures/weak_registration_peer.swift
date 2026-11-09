// Native weak references and a serial registration; no ARC count claims.
import Glibc

func require(_ condition: Bool, _ line: Int) {
    if condition { return }
    let bytes = Array("lifetime check failed at Swift line \(line)\n".utf8)
    bytes.withUnsafeBytes { data in
        _ = write(STDERR_FILENO, data.baseAddress, data.count)
    }
    exit(79)
}

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
    // The outside owner must survive until the weak lookup acquires its owner.
    guard let active = withExtendedLifetime(outside, { registration.target }) else { return false }
    // Keep the acquired owner through the entire callback, including reentry.
    return withExtendedLifetime(active) {
        counts.calls += 1
        require(active.identity == 7, #line)
        registration.cancelled = true
        outside = nil
        require(counts.destroyed == 0, #line)
        require(!dispatch(&registration, &outside, counts), #line)
        guard let nested = registration.target else { preconditionFailure("lost active owner") }
        require(nested.identity == 7, #line)
        require(counts.destroyed == 0, #line)
        return true
    }
}

func run() {
    let counts = Counts()
    var registration = Registration(target: nil, cancelled: true)
    require(registration.target == nil, #line)
    var owner: Target? = Target(7, counts)
    registration.target = owner
    require(!dispatch(&registration, &owner, counts), #line)
    require(counts.calls == 0 && counts.destroyed == 0, #line)
    registration.cancelled = false
    require(dispatch(&registration, &owner, counts), #line)
    require(owner == nil && counts.calls == 1 && counts.destroyed == 1, #line)
    require(!dispatch(&registration, &owner, counts), #line)
    registration.cancelled = false
    require(!dispatch(&registration, &owner, counts), #line)
    for identity in 0..<64 {
        let replacement = Target(identity, counts)
        withExtendedLifetime(replacement) {
            require(registration.target == nil, #line)
        }
    }
    require(counts.destroyed == 65, #line)
    owner = Target(9, counts)
    registration.target = owner
    do {
        _ = try dispatchError(&registration, &owner, counts)
        preconditionFailure("callback error was lost")
    } catch CallbackError.failed {
        require(owner == nil && counts.calls == 2 && counts.destroyed == 66, #line)
    } catch {
        preconditionFailure("unexpected callback error")
    }
    require(registration.target == nil, #line)
    do {
        let entered = try dispatchError(&registration, &owner, counts)
        require(!entered && counts.calls == 2, #line)
    } catch {
        preconditionFailure("expired callback was entered")
    }
    queuedChecks()
    print("calls=2 destroyed=66 expired=1 cancelled=1 error=1 queue=1")
}

enum CallbackError: Error { case failed }

func callbackError(_ acquired: Target, _ outside: inout Target?, _ counts: Counts) throws {
    require(acquired.identity == 9, #line)
    counts.calls += 1
    outside = nil
    require(counts.destroyed == 65 && acquired.identity == 9, #line)
    throw CallbackError.failed
}

func dispatchError(_ registration: inout Registration, _ outside: inout Target?, _ counts: Counts) throws -> Bool {
    guard let acquired = withExtendedLifetime(outside, { registration.target }) else { return false }
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
    guard let held = withExtendedLifetime(outside, { entry.target }) else { return }
    try withExtendedLifetime(held) {
        counts.calls += 1
        require(held.identity == 17 && entry.payload.value == 11, #line)
        outside = nil
        require(counts.destroyed == 0 && held.identity == 17, #line)
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
            withExtendedLifetime(owner) {
                queue[0] = nil
                require(counts.disposed == 1 && counts.destroyed == 0, #line)
            }
            owner = nil
            require(counts.destroyed == 1, #line)
        }
        do {
            try drainQueue(&queue, &owner, counts)
            require(cancelled && counts.calls == 0, #line)
        } catch CallbackError.failed {
            require(!cancelled && counts.calls == 1, #line)
        } catch {
            preconditionFailure("unexpected queued callback error")
        }
        require(queue.isEmpty && owner == nil, #line)
        require(counts.destroyed == 1 && counts.disposed == 2, #line)
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
