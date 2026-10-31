import ReturnedCallable

let arguments = CommandLine.arguments
precondition(arguments.count == 5)
precondition(arguments[1] == "0" || arguments[1] == "1")
precondition(arguments[2] == "4096" && arguments[3] == "256" && arguments[4] == "16")
let kind = Int32(arguments[1])!
let population = 4096
let cycles = 256
let passes = 16
var construction: UInt64 = 0
var invocation: UInt64 = 0
var destruction: UInt64 = 0
var checksum: Int64 = 0
for _ in 0..<cycles {
    let start = callable_phase_clock()
    // Explicit native storage lets deinitialize delimit release precisely.
    // All slots are initialized before use, then destroyed exactly once.
    let values = UnsafeMutablePointer<(Int64) -> Int64>.allocate(capacity: population)
    for i in 0..<population {
        values.advanced(by: i).initialize(to: returnedMake(kind, Int64(i + 7)))
    }
    let made = callable_phase_clock()
    for pass in 0..<passes {
        for i in 0..<population { checksum += values[i](Int64(pass)) }
    }
    let called = callable_phase_clock()
    values.deinitialize(count: population)
    values.deallocate()
    let released = callable_phase_clock()
    precondition(made >= start && called >= made && released >= called)
    construction += made - start
    invocation += called - made
    destruction += released - called
}
let expected = Int64(kind + 1) * Int64(cycles) *
    (Int64(passes) * (Int64(population) * Int64(population - 1) / 2 + 7 * Int64(population)) +
     Int64(population) * Int64(passes) * Int64(passes - 1) / 2)
precondition(checksum == expected)
print("\(checksum) \(construction) \(invocation) \(destruction)")
