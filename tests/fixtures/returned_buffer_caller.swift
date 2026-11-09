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
    if args.count != 3 { fail("expected length repeats", 2) }
    let length = number(args[1]), repeats = number(args[2])
    if length > 262144 { fail("length exceeds experiment bound", 2) }
    if repeats < 1 || repeats > 64 { fail("repeats outside experiment bound", 2) }
    let size = max(length, 0), expected = size * (size - 1) / 2
    var checksum: Int64 = 0
    for _ in Int64(0)..<repeats {
        let first = bufferMake(length)
        #if BUFFER_SHARED
        let second = bufferAlias(first)
        #endif
        let value = bufferScan(first)
        if value != expected { fail("incorrect result", 4) }
        checksum += value
        bufferRelease(consume first)
        #if BUFFER_SHARED
        let afterRelease = bufferScan(second)
        if afterRelease != expected { fail("incorrect result", 4) }
        checksum += afterRelease
        bufferRelease(consume second)
        #endif
    }
    print(checksum)
}
run()
