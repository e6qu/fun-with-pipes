#if os(Linux)
import Glibc
#else
import Darwin
#endif
import WeakCallbackService

func fail(_ text: String, _ status: Int32) -> Never {
    Array((text + "\n").utf8).withUnsafeBufferPointer { data in _ = write(STDERR_FILENO, data.baseAddress, data.count) }
    exit(status)
}
func number(_ text: String) -> Int64 {
    guard !text.isEmpty, text.utf8.allSatisfy({ $0>=48 && $0<=57 }), let value=Int64(text) else { fail("invalid integer",2) }
    return value
}
func expected(_ population: Int64, _ mode: Int64) -> (Int64,Int64,Int64,Int64,Int64,Int64,Int64,Int64) {
    var calls:Int64=0, cancelled:Int64=0, expired:Int64=0, sum:Int64=0
    for index in 0..<population {
        if mode==2 { expired+=1; continue }
        if mode==1 && index%4==0 { cancelled+=1; continue }
        if mode==3 && index>population/2 { continue }
        calls+=1; sum+=16*index+120
    }
    return (calls,cancelled,expired,mode==3 ? 1 : 0,calls,calls,sum,sum)
}
let arguments=CommandLine.arguments
if arguments.count != 4 { fail("expected population mode batches",2) }
let population=number(arguments[1]), mode=number(arguments[2]), batches=number(arguments[3])
if ![64,4096].contains(population) || !(0..<4).contains(mode) || ![1,16,64,256,1024,4096,16384].contains(batches) {
    fail("invalid experiment arguments",2)
}
let want=expected(population,mode)
var total_calls:Int64=0
var total_cancelled:Int64=0
var total_expired:Int64=0
var total_errors:Int64=0
var total_sent:Int64=0
var total_received:Int64=0
var total_sum:Int64=0
var total_received_sum:Int64=0
var elapsed:UInt64=0
for _ in Int64(0)..<batches {
    let before=callable_phase_clock()
    let stats=serviceRun(Int(population),Int(mode))
    let after=callable_phase_clock()
    if after<before { fail("clock moved backwards",77) }
    elapsed+=after-before
    if stats.calls != want.0 { fail("incorrect service result",4) }
    if stats.cancelled != want.1 { fail("incorrect service result",4) }
    if stats.expired != want.2 { fail("incorrect service result",4) }
    if stats.errors != want.3 { fail("incorrect service result",4) }
    if stats.sent != want.4 { fail("incorrect service result",4) }
    if stats.received != want.5 { fail("incorrect service result",4) }
    if stats.sum != want.6 { fail("incorrect service result",4) }
    if stats.receivedSum != want.7 { fail("incorrect service result",4) }
    total_calls+=stats.calls
    total_cancelled+=stats.cancelled
    total_expired+=stats.expired
    total_errors+=stats.errors
    total_sent+=stats.sent
    total_received+=stats.received
    total_sum+=stats.sum
    total_received_sum+=stats.receivedSum
}
print("{\"population\":\(population),\"mode\":\(mode),\"batches\":\(batches),\"calls\":\(total_calls),\"cancelled\":\(total_cancelled),\"expired\":\(total_expired),\"errors\":\(total_errors),\"sent\":\(total_sent),\"received\":\(total_received),\"sum\":\(total_sum),\"received_sum\":\(total_received_sum),\"serviceNs\":\(elapsed)}")
