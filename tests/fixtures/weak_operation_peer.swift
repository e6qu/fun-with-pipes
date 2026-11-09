// Native class and native weak field; clients compile in a separate module.
public final class ReferenceTarget {
    public let identity: Int64
    init(_ input: Int64) { identity = input }
}
public struct ReferenceWeak {
    weak var target: ReferenceTarget?
}
public func referenceMake(_ input: Int64) -> ReferenceTarget {
    precondition(input == 1)
    return ReferenceTarget(input)
}
public func referenceDowngrade(_ owner: borrowing ReferenceTarget) -> ReferenceWeak {
    ReferenceWeak(target: copy owner)
}
public func referenceLookup(_ weak: borrowing ReferenceWeak) -> Bool {
    guard let acquired = weak.target else { return false }
    return withExtendedLifetime(acquired) { true }
}
public func referenceReleaseOwner(_ owner: consuming ReferenceTarget) {
    withExtendedLifetime(owner) {}
}
public func referenceReleaseWeak(_ weak: consuming ReferenceWeak) {
    withExtendedLifetime(weak) {}
}
