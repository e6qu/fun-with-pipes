import Glibc
import ReturnedBuffer

func fail(_ text: String, _ status: Int32) -> Never {
    let bytes = Array((text + "\n").utf8)
    bytes.withUnsafeBytes { data in
        _ = write(STDERR_FILENO, data.baseAddress, data.count)
    }
    exit(status)
}

func number(_ text: String) -> Int64 {
    let digits = text.first == "-" ? text.dropFirst() : text[...]
    guard !digits.isEmpty, digits.utf8.allSatisfy({ $0 >= 48 && $0 <= 57 }),
          let value = Int64(text) else { fail("invalid integer", 2) }
    return value
}

func run() {
    let args = CommandLine.arguments
    if args.count != 4 { fail("expected length population batches", 2) }
    let length = number(args[1]), population = number(args[2]), batches = number(args[3])
    let required: Int64
    switch length {
    case 0, 16: required = 4096
    case 4096: required = 256
    case 262144: required = 4
    default: required = -1
    }
    if required == -1 || population != required || ![16, 64, 256, 1024].contains(batches) {
        fail("invalid experiment arguments", 2)
    }
    // Allocate slots once; each initialize/move pair owns one native Array.
    let first = UnsafeMutablePointer<[Int64]>.allocate(capacity: Int(population))
    #if BUFFER_SHARED
    let second = UnsafeMutablePointer<[Int64]>.allocate(capacity: Int(population))
    #endif
    var checksum: Int64 = 0
    var construction: UInt64 = 0, reading: UInt64 = 0, releasing: UInt64 = 0
    for _ in Int64(0)..<batches {
        let t0 = callable_phase_clock()
        for index in 0..<Int(population) {
            let value = bufferMake(length)
            #if BUFFER_SHARED
            second.advanced(by: index).initialize(to: bufferAlias(value))
            #endif
            first.advanced(by: index).initialize(to: consume value)
        }
        let t1 = callable_phase_clock()
        for index in 0..<Int(population) { checksum += bufferScan(first[index]) }
        let t2 = callable_phase_clock()
        for index in 0..<Int(population) { bufferRelease(first.advanced(by: index).move()) }
        let t3 = callable_phase_clock()
        #if BUFFER_SHARED
        for index in 0..<Int(population) { checksum += bufferScan(second[index]) }
        let t4 = callable_phase_clock()
        for index in 0..<Int(population) { bufferRelease(second.advanced(by: index).move()) }
        let t5 = callable_phase_clock()
        if t4 < t3 || t5 < t4 { fail("clock moved backwards", 77) }
        reading += t4 - t3
        releasing += t5 - t4
        #endif
        if t1 < t0 || t2 < t1 || t3 < t2 { fail("clock moved backwards", 77) }
        construction += t1 - t0
        reading += t2 - t1
        releasing += t3 - t2
    }
    first.deallocate()
    #if BUFFER_SHARED
    second.deallocate()
    let owners: Int64 = 2
    #else
    let owners: Int64 = 1
    #endif
    let expected = length * (length - 1) / 2 * population * batches * owners
    if checksum != expected { fail("incorrect result", 4) }
    print("{\"checksum\":\(checksum),\"construction\":\(construction),\"reading\":\(reading),\"release\":\(releasing)}")
}
run()
