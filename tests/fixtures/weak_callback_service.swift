// Native ARC target, weak registrations, owned array payloads and thrown errors.

final class Target { var inbox: [[Int64]] = [] }
struct Pending { let payload: [Int64]; weak var target: Target? }
public struct Stats {
    public var calls: Int64 = 0, cancelled: Int64 = 0, expired: Int64 = 0, errors: Int64 = 0
    public var sent: Int64 = 0, received: Int64 = 0, sum: Int64 = 0, receivedSum: Int64 = 0
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
public func serviceRun(_ population: Int, _ mode: Int) -> Stats {
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
    return stats
}
