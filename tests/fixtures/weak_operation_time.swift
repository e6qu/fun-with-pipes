import Glibc
import WeakOperation

func fail(_ text: String, _ status: Int32) -> Never {
    let bytes = Array((text + "\n").utf8)
    bytes.withUnsafeBytes { data in _ = write(STDERR_FILENO, data.baseAddress, data.count) }
    exit(status)
}
func number(_ text: String) -> Int64 {
    guard !text.isEmpty, text.utf8.allSatisfy({ $0 >= 48 && $0 <= 57 }),
          let value = Int64(text) else { fail("invalid integer", 2) }
    return value
}
func run() {
    let args = CommandLine.arguments
    if args.count != 4 { fail("expected population lookups batches", 2) }
    let population = number(args[1]), lookups = number(args[2]), batches = number(args[3])
    if ![1, 64, 4096].contains(population) || ![1, 16, 64].contains(lookups)
        || ![1, 16, 64, 256, 1024].contains(batches) { fail("invalid experiment arguments", 2) }
    let owners = UnsafeMutablePointer<ReferenceTarget>.allocate(capacity: Int(population))
    let weak = UnsafeMutablePointer<ReferenceWeak>.allocate(capacity: Int(population))
    var live: Int64 = 0, expired: Int64 = 0
    var targetCreation: UInt64 = 0, weakCreation: UInt64 = 0, liveLookup: UInt64 = 0
    var ownerRelease: UInt64 = 0, expiredLookup: UInt64 = 0, weakRelease: UInt64 = 0
    for _ in Int64(0)..<batches {
        let t0 = callable_phase_clock()
        for index in 0..<Int(population) { owners.advanced(by: index).initialize(to: referenceMake(1)) }
        let t1 = callable_phase_clock()
        for index in 0..<Int(population) { weak.advanced(by: index).initialize(to: referenceDowngrade(owners[index])) }
        let t2 = callable_phase_clock()
        for _ in Int64(0)..<lookups { for index in 0..<Int(population) { live += referenceLookup(weak[index]) ? 1 : 0 } }
        let t3 = callable_phase_clock()
        for index in 0..<Int(population) { referenceReleaseOwner(owners.advanced(by: index).move()) }
        let t4 = callable_phase_clock()
        for _ in Int64(0)..<lookups { for index in 0..<Int(population) { expired += referenceLookup(weak[index]) ? 1 : 0 } }
        let t5 = callable_phase_clock()
        for index in 0..<Int(population) { referenceReleaseWeak(weak.advanced(by: index).move()) }
        let t6 = callable_phase_clock()
        if t1 < t0 || t2 < t1 || t3 < t2 || t4 < t3 || t5 < t4 || t6 < t5 {
            fail("clock moved backwards", 77)
        }
        targetCreation += t1 - t0
        weakCreation += t2 - t1
        liveLookup += t3 - t2
        ownerRelease += t4 - t3
        expiredLookup += t5 - t4
        weakRelease += t6 - t5
    }
    owners.deallocate(); weak.deallocate()
    if live != population * lookups * batches || expired != 0 { fail("incorrect result", 4) }
    print("{\"live\":\(live),\"expired\":\(expired),\"targetCreation\":\(targetCreation),\"weakCreation\":\(weakCreation),\"liveLookup\":\(liveLookup),\"ownerRelease\":\(ownerRelease),\"expiredLookup\":\(expiredLookup),\"weakRelease\":\(weakRelease)}")
}
run()
