// Native weak references and a serial registration; no ARC count claims.
import Glibc

final class Counts {
    var calls = 0
    var destroyed = 0
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
    print("calls=1 destroyed=65 expired=1 cancelled=1")
}

if CommandLine.arguments.count != 1 {
    let bytes = Array("expected no arguments\n".utf8)
    bytes.withUnsafeBytes { data in
        _ = write(STDERR_FILENO, data.baseAddress, data.count)
    }
    exit(2)
}
run()
