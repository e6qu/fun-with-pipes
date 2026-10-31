import ReturnedCallable

let arguments = CommandLine.arguments
precondition(arguments.count == 2)
if arguments[1] == "success" {
    for kind in Int32(0)..<2 {
        for count: Int64 in [0, 1, 16, 4096] {
            let callable = returnedMake(kind, 7)
            var checksum: Int64 = 0
            for input in Int64(0)..<count {
                let result = callable(input)
                precondition(result == Int64(kind + 1) * (7 + input))
                precondition(result == returnedDirect(kind, 7, input))
                checksum += result
            }
            print("\(kind) \(count) \(checksum) \(MemoryLayout.size(ofValue: callable)) \(MemoryLayout.alignment(ofValue: callable))")
        }
    }
} else {
    let direct = arguments[1].hasPrefix("direct-")
    let name = direct ? String(arguments[1].dropFirst(7)) : arguments[1]
    let cases: [String: (Int32, Int64, Int64)] = [
        "add-max": (0, Int64.max, 1), "add-min": (0, Int64.min, -1),
        "composition-add": (1, Int64.max, 1),
        "mul-max": (1, Int64.max / 2 + 1, 0),
        "mul-min": (1, Int64.min / 2 - 1, 0), "invalid-kind": (2, 7, 0),
    ]
    guard let (kind, capture, input) = cases[name] else { fatalError("unknown case") }
    let result = direct ? returnedDirect(kind, capture, input) : returnedMake(kind, capture)(input)
    print("unexpected result \(result)")
}
