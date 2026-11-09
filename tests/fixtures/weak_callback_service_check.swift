#if os(Linux)
import Glibc
#else
import Darwin
#endif
import WeakCallbackService

if CommandLine.arguments.count != 1 {
    Array("expected no arguments\n".utf8).withUnsafeBufferPointer { data in
        _ = write(STDERR_FILENO, data.baseAddress, data.count)
    }
    exit(2)
}
for population in [64, 4096] {
    for mode in 0..<4 {
        let stats = serviceRun(population, mode)
        print("{\"population\":\(population),\"mode\":\(mode),\"calls\":\(stats.calls),\"cancelled\":\(stats.cancelled),\"expired\":\(stats.expired),\"errors\":\(stats.errors),\"sent\":\(stats.sent),\"received\":\(stats.received),\"sum\":\(stats.sum),\"received_sum\":\(stats.receivedSum)}")
    }
}
