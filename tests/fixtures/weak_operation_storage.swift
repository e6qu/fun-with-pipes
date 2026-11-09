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
    if args.count != 3 { fail("expected population stage", 2) }
    let population = number(args[1]), stage = number(args[2])
    if ![64, 4096].contains(population) || stage > 3 { fail("invalid experiment arguments", 2) }
    let owners = UnsafeMutablePointer<ReferenceTarget>.allocate(capacity: Int(population))
    let weak = UnsafeMutablePointer<ReferenceWeak>.allocate(capacity: Int(population))
    var live: Int64 = 0, expired: Int64 = 0
    for index in 0..<Int(population) { owners.advanced(by: index).initialize(to: referenceMake(1)) }
    if stage >= 1 {
        for index in 0..<Int(population) { weak.advanced(by: index).initialize(to: referenceDowngrade(owners[index])) }
        for index in 0..<Int(population) { live += referenceLookup(weak[index]) ? 1 : 0 }
    }
    if stage >= 2 {
        for index in 0..<Int(population) { referenceReleaseOwner(owners.advanced(by: index).move()) }
        for index in 0..<Int(population) { expired += referenceLookup(weak[index]) ? 1 : 0 }
    }
    if stage >= 3 {
        for index in 0..<Int(population) { referenceReleaseWeak(weak.advanced(by: index).move()) }
    }
    // Stages 0..2 deliberately omit destruction of the remaining initialized
    // values. Free only the caller slots; heaptrack measures their native owners.
    owners.deallocate(); weak.deallocate()
    if live != (stage >= 1 ? population : 0) || expired != 0 { fail("incorrect result", 4) }
    print("{\"population\":\(population),\"stage\":\(stage),\"live\":\(live),\"expired\":\(expired)}")
}
run()
