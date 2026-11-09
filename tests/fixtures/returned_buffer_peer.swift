// No @inlinable bodies: clients use a separately compiled native Array factory.
import Glibc

public func bufferMake(_ input: Int64) -> [Int64] {
    let length = max(input, 0)
    var values: [Int64] = []
    values.reserveCapacity(Int(length))
    for index in Int64(0)..<length { values.append(index) }
    return values
}

public func bufferScan(_ values: borrowing [Int64]) -> Int64 {
    var sum: Int64 = 0
    for value in values {
        let (next, overflow) = sum.addingReportingOverflow(value)
        if overflow {
            let bytes = Array("integer overflow\n".utf8)
            bytes.withUnsafeBytes { data in
                _ = write(STDERR_FILENO, data.baseAddress, data.count)
            }
            exit(3)
        }
        sum = next
    }
    return sum
}

public func bufferAlias(_ values: borrowing [Int64]) -> [Int64] { values }

public func bufferRelease(_ values: consuming [Int64]) {
    withExtendedLifetime(values) {}
}
