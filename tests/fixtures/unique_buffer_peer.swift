// Native Swift Array peer for the complete-operation buffer comparison.
// The C input/result barriers preserve repeated calls, not heap allocations.
// Timing peers must use the same external barriers before comparing costs.
import Glibc

#if BUFFER_UNIQUE && !BUFFER_CALLBACK && !BUFFER_SCAN
let entry = "unique"
#elseif BUFFER_CALLBACK && !BUFFER_UNIQUE && !BUFFER_SCAN
let entry = "callback"
#elseif BUFFER_SCAN && !BUFFER_UNIQUE && !BUFFER_CALLBACK
let entry = "scan"
#else
#error("Select exactly one of BUFFER_UNIQUE, BUFFER_CALLBACK or BUFFER_SCAN")
#endif

func fail(_ message: String, _ status: Int32) -> Never {
    let bytes = Array((message + "\n").utf8)
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

func add(_ left: Int64, _ right: Int64) -> Int64 {
    let (value, overflow) = left.addingReportingOverflow(right)
    if overflow { fail("integer overflow", 3) }
    return value
}

func readBuffer(_ values: [Int64]) -> Int64 {
    add(Int64(values.count), values.first ?? 0)
}

func work(_ input: Int64) -> Int64 {
    let count = max(input, 0)
    if count > Int64(Int.max / MemoryLayout<Int64>.stride) {
        fail("array too large", 3)
    }
    var values: [Int64] = []
    values.reserveCapacity(Int(count))
    for index in Int64(0)..<count { values.append(index) }
    #if BUFFER_SCAN
    var result: Int64 = 0
    for value in values { result = add(result, value) }
    return result
    #elseif BUFFER_UNIQUE
    return add(readBuffer(values), Int64(values.count))
    #else
    return readBuffer(values)
    #endif
}

let arguments = CommandLine.arguments
if arguments.count != 4 { fail("expected entry length repeats", 2) }
if arguments[1] != entry { fail("invalid entry", 2) }
let length = number(arguments[2])
let repeats = number(arguments[3])
if repeats <= 0 { fail("repeats must be positive", 2) }
let count = max(length, 0)
// Divide before multiplication, and retain overflow as an invalid result.
// This oracle must not wrap or reject a negative length before work normalizes it.
let left: UInt64
let right: UInt64
#if BUFFER_SCAN
left = UInt64(count % 2 == 0 ? count / 2 : count)
right = UInt64(count == 0 ? 0 : (count % 2 == 0 ? count - 1 : (count - 1) / 2))
#elseif BUFFER_UNIQUE
left = UInt64(count)
right = 2
#else
left = UInt64(count)
right = 1
#endif
let (expected, expectedOverflow) = left.multipliedReportingOverflow(by: right)
var checksum: Int64 = 0
for _ in Int64(0)..<repeats {
    let result = buffer_peer_opaque(work(buffer_peer_opaque(length)))
    if expectedOverflow || result < 0 || UInt64(result) != expected {
        fail("incorrect result", 4)
    }
    checksum = add(checksum, result)
}
print(checksum)
