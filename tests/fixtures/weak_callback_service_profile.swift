#if os(Linux)
import Glibc
#else
import Darwin
#endif
import WeakCallbackService

let arguments = CommandLine.arguments
if arguments.count != 3 || !["64", "4096"].contains(arguments[1])
    || !["0", "1", "2", "3"].contains(arguments[2]) {
    Array("expected population 64|4096 and mode 0|1|2|3\n".utf8).withUnsafeBufferPointer { data in
        _ = write(STDERR_FILENO, data.baseAddress, data.count)
    }
    exit(2)
}
let population = Int(arguments[1])!
let mode = Int(arguments[2])!
let stats = serviceRun(population, mode)
print("{\"population\":\(population),\"mode\":\(mode),\"calls\":\(stats.calls),\"cancelled\":\(stats.cancelled),\"expired\":\(stats.expired),\"errors\":\(stats.errors),\"sent\":\(stats.sent),\"received\":\(stats.received),\"sum\":\(stats.sum),\"received_sum\":\(stats.receivedSum)}")
