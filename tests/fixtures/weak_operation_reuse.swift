import Glibc
import WeakOperation

func fail(_ text: String, _ status: Int32) -> Never {
    let bytes = Array((text + "\n").utf8)
    bytes.withUnsafeBytes { data in _ = write(STDERR_FILENO, data.baseAddress, data.count) }
    exit(status)
}
func run() {
    if CommandLine.arguments.count != 1 { fail("expected no arguments", 2) }
    var reused = 0, expired = 0, replacementLive = 0
    for _ in 0..<1024 {
        let owner = referenceMake(1)
        let address = UInt(bitPattern: Unmanaged.passUnretained(owner).toOpaque())
        let weak = referenceDowngrade(owner)
        if !referenceLookup(weak) { fail("weak reuse check failed", 79) }
        referenceReleaseOwner(consume owner)
        if referenceLookup(weak) { fail("weak reuse check failed", 79) }
        let replacement = referenceMake(1)
        if UInt(bitPattern: Unmanaged.passUnretained(replacement).toOpaque()) == address { reused += 1 }
        let revived = referenceLookup(weak)
        if revived { fail("weak reuse check failed", 79) }
        expired += 1
        let current = referenceDowngrade(replacement)
        if !referenceLookup(current) { fail("weak reuse check failed", 79) }
        replacementLive += 1
        referenceReleaseOwner(consume replacement)
        if referenceLookup(current) { fail("weak reuse check failed", 79) }
        referenceReleaseWeak(consume current)
        referenceReleaseWeak(consume weak)
    }
    if reused == 0 { fail("weak reuse check failed", 79) }
    print("{\"rounds\":1024,\"reused\":\(reused),\"expired\":\(expired),\"replacementLive\":\(replacementLive)}")
}
run()
