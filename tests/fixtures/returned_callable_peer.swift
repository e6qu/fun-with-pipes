// Compile separately from the caller. Return an ordinary escaping Swift closure;
// do not box it behind an extra class or copy fwp's heap representation.
public func returnedMake(_ kind: Int32, _ capture: Int64) -> (Int64) -> Int64 {
    switch kind {
    case 0: return { input in capture + input }
    case 1: return { input in 2 * (capture + input) }
    default: fatalError("invalid callable kind")
    }
}

public func returnedDirect(_ kind: Int32, _ capture: Int64, _ input: Int64) -> Int64 {
    switch kind {
    case 0: return capture + input
    case 1: return 2 * (capture + input)
    default: fatalError("invalid callable kind")
    }
}
