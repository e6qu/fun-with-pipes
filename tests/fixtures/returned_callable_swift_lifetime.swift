#if os(Linux)
import Glibc
#elseif os(macOS)
import Darwin
#endif

// A separate ownership control with a reference capture. It does not measure
// allocations or ARC operations in the scalar-capture benchmark.
final class Capture {
    let value: Int64
    init(_ value: Int64) { self.value = value }
}
weak var witness: Capture?
var leaked: ((Int64) -> Int64)?
@MainActor func make() -> (Int64) -> Int64 {
    let capture = Capture(7)
    witness = capture
    return { capture.value + $0 }
}
precondition(CommandLine.arguments.count == 2)
precondition(["release", "omit-release"].contains(CommandLine.arguments[1]))
var callable: ((Int64) -> Int64)? = make()
precondition(witness != nil && callable!(3) == 10)
if CommandLine.arguments[1] == "omit-release" { leaked = callable }
callable = nil
if witness != nil { exit(78) }
print("released")
