// Native ARC target, weak registrations, owned array payloads and thrown errors.
#if os(Linux)
import Glibc
#else
import Darwin
#endif

final class Target { var inbox: [[Int64]] = [] }
struct Pending { let payload: [Int64]; weak var target: Target? }
struct Stats {
    var calls: Int64 = 0, cancelled: Int64 = 0, expired: Int64 = 0, errors: Int64 = 0
    var sent: Int64 = 0, received: Int64 = 0, sum: Int64 = 0, receivedSum: Int64 = 0
}
enum CallbackFailure: Error { case delivered }
func callback(_ active: Target, _ payload: consuming [Int64], _ fail: Bool, _ stats: inout Stats) throws {
    stats.calls += 1
    stats.sum += payload.reduce(0, +)
    active.inbox.append(payload)
    stats.sent += 1
    if fail { throw CallbackFailure.delivered }
}
func dispatch(_ pending: consuming [Pending?], _ mode: Int, _ stats: inout Stats) {
    var queue = consume pending
    for index in queue.indices {
        let entry = queue[index]!
        queue[index] = nil
        if mode == 1 && index % 4 == 0 { stats.cancelled += 1; continue }
        guard let active = entry.target else { stats.expired += 1; continue }
        do {
            try callback(active, entry.payload, mode == 3 && index == queue.count / 2, &stats)
        } catch CallbackFailure.delivered {
            stats.errors += 1
            break
        } catch { preconditionFailure("unexpected callback error") }
    }
}
func runCase(_ population: Int, _ mode: Int) {
    var stats = Stats()
    var owner: Target? = Target()
    owner!.inbox.reserveCapacity(population)
    let pending: [Pending?] = (0..<population).map { index in
        Pending(payload: (0..<16).map { Int64(index + $0) }, target: owner!)
    }
    if mode == 2 { owner = nil }
    dispatch(consume pending, mode, &stats)
    if let target = owner {
        for payload in target.inbox {
            stats.received += 1
            stats.receivedSum += payload.reduce(0, +)
        }
    }
    owner = nil
    print("{\"population\":\(population),\"mode\":\(mode),\"calls\":\(stats.calls),\"cancelled\":\(stats.cancelled),\"expired\":\(stats.expired),\"errors\":\(stats.errors),\"sent\":\(stats.sent),\"received\":\(stats.received),\"sum\":\(stats.sum),\"received_sum\":\(stats.receivedSum)}")
}
if CommandLine.arguments.count != 1 {
    Array("expected no arguments\n".utf8).withUnsafeBufferPointer { data in
        _ = write(STDERR_FILENO, data.baseAddress, data.count)
    }
    exit(2)
}
for population in [64, 4096] { for mode in 0..<4 { runCase(population, mode) } }
