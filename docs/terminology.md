# Terminology: explanations and worked examples

Use this page to look up the language, compiler, memory, numerical and measurement
terms used in this repository. Examples explain the work behind the words.
Tutorials must still introduce unfamiliar concepts where they first use them;
reading this whole guide is not a prerequisite.

- [Reading a program](#reading-a-program) and [types and actions](#types-and-actions)
- [Compilation](#execution-and-compilation) and [parsing and macros](#parsing-and-macros)
- [Memory and processors](#memory-and-processors)
- [Numerical programming](#numerical-programming), including [a tape worked example](#tape-and-backward-pass)
- [Networking and tools](#networking-and-tools)
- [Tests and measurements](#tests-and-measurements)

Definitions describe concepts; they do not promise that every possible
optimization is implemented. [Design limits](design-limits.md) and the linked
implementation guides describe fwp's supported cases.

## Reading a program

| Term | Meaning in fwp |
|---|---|
| Pipe | `x \| f` passes `x` to `f`. Between functions, `f \| g` makes a function that runs `f` and then `g`. |
| Data-last | Configuration arguments come first, and the value being transformed comes last: `10 \| sub 3` gives `7`. |
| Curried function | A function receives arguments one at a time. `add 3` is a function still waiting for the number to add to. |
| Partial application | Supplying some of a function's arguments to make a function waiting for the rest. |
| Tacit function | A definition that combines functions without naming their input, such as `double = mul 2`. |
| Named input | `fn x -> x * 2` names its one input `x`. A tuple pattern such as `fn (x, y) -> x + y` still receives one tuple argument. |
| Local binding / scope | `let x = 3 in x + x` evaluates the value once, then uses its name in the body after `in`. The name is immutable and only visible in that body. |
| Capture | A function keeps a value from its surrounding scope. In `let n = 3 in fn x -> x + n`, the returned function captures `n`. |
| Combinator | An ordinary function that connects other functions. `both f g` applies both to one input and returns their two results. |
| Callback | A function passed to another operation to be called later or for each element, such as `mul 2` in `map (mul 2)`. |
| Constant function | A function that ignores its input and returns a chosen value. `const 7` returns `7` for every input; the value `7` alone is not a function. |
| Unit | The value `()`, used when there is no meaningful input or result. It is not the empty list `[]`. |
| Tuple / projection | A tuple groups values by position, such as `(3, "cat")`. A projection selects one: `.0` is the first, `.1` the second. |
| Record / field | A record groups values by name, such as `{ age = 3 }`. `.age` selects that field. |
| Variant / constructor | A type with named alternatives, such as `Option[T]`, whose values are `None` or `Some value`. A constructor makes one alternative. |
| Pattern / arm | A pattern names or selects parts of an input. A match arm is the expression after `->`. A match `_` hole forwards an argument to that expression. In `fn`, `let` and record-field patterns, `_` discards the input. |
| Immutable value | A value whose meaning cannot change after creation. An update returns a new logical value, even if the compiler can safely reuse its storage. |

### Following a small program

```fwp
energy : I64 -> I64
energy = fn x -> let square = x * x in square + square
```

`energy 3` returns `18`. `fn` introduces a function with one named input.
The **initializer** `x * x` runs once, producing `9`. The **body** after `in`
adds that saved value to itself. **Strict evaluation** means the initializer
still runs if its name is unused: an overflow there still stops the computation.
`let` does not declare a function and does not introduce mutable storage.

In `let x = 3 in let x = x + 1 in x`, the inner initializer reads the outer
`x`, then the inner body sees `4`. This is **shadowing**, not assignment.
**Lexical scope** means the text enclosing a name determines which binding it
refers to; a caller's unrelated variable with the same spelling cannot change it.

`let offset = 3 in fn x -> x + offset` returns a **closure**: a function together
with the captured value `offset`. Its **environment** is the storage, if needed,
for captures. A nonescaping closure is used only within its known lifetime; an
escaping closure may be returned or stored for later use. The compiler may
eliminate the environment when it can prove no separate storage is needed.

**Destructuring** names pieces of one value: `fn (x, y) -> x + y` takes one tuple.
A **refutable pattern** can fail to match, such as `Some x` when the value is
`None`; it belongs in `match`. An **irrefutable pattern**, such as a tuple of
names of the known tuple type, cannot fail. `{ x, y }` is **field shorthand**
for `{ x = x, y = y }`; it does not infer extra fields.

See [lesson 1](tutorials/01-pipes-and-functions/README.md) and
[local expressions](reference.md#local-bindings-and-named-functions).

## Types and actions

| Term | Meaning |
|---|---|
| Type / signature | A type describes values, such as `String`. A signature describes a definition: `String -> I64` takes a string and returns a 64-bit integer. |
| Type inference | The compiler deduces a type from how a value is constructed and used. It still checks the type before execution. |
| Generic / type variable | A definition written for multiple types. In `a -> a`, `a` stands for a type chosen at each use. fwp requires an explicit generic signature. |
| Trait / implementation | A trait lists operations a type must provide. An `impl` supplies them for a particular type. `where Eq[a]` requires equality comparison for `a`. |
| Structural / nominal type | Structural compatibility depends on fields; a nominal type also has a declared name. The reference describes where matching shapes can be converted. |
| Effect / handler | An effect is an action listed after `!`, such as `IO` or `Error[String]`. A handler supplies its meaning or handles its outcome; `attempt` turns a recoverable error into `Ok` or `Err`. |
| Pure | Has no declared external action. Pure code can still allocate memory, take time, or hit a runtime check. |
| Trap / unwind | A trap stops execution after an invalid runtime operation, such as integer overflow. Unwinding means leaving interrupted calls and releasing their resources. A trap is distinct from a recoverable `Error` effect. |
| Affine resource | A handle whose use is restricted so it cannot be duplicated freely, for example a resource that must be closed once. |

For example, `energy : I64 -> I64` promises an integer result for an integer
input. **Strong typing** prevents using a String as that integer without an
explicit supported conversion. **Static checking** performs this check before
execution; it does not eliminate dynamic checks such as division by zero.
Ordinary inference can discover types without annotations. **Polymorphism**
means a definition can be used at multiple types; fwp requires an explicit generic
signature for that promise. A local `let` does not automatically generalize its
value into a new polymorphic definition.

**State** is information carried between operations. `run-state` gives its body
one scoped state value; `get`, `put` and `modify` access that handler's state.
This does not make ordinary values mutable. **Mutation** changes storage;
**uniqueness** can let the implementation mutate storage while preserving the
language's immutable meaning because no other observer can see the old contents.

**Cancellation** interrupts a task that is no longer wanted. **Cleanup** releases
its resources even when it stops before returning normally. **Exception safety**,
as used in ownership reports, means those guarantees survive an interrupted
operation; it does not mean fwp traps and recoverable errors are the same feature.
See [effects](reference.md#effects) and [ownership](ownership.md).

## Execution and compilation

| Term | Meaning |
|---|---|
| Native executable | Machine code for a particular operating system and processor. fwp currently produces C and asks a C compiler to produce that code. |
| Interpreter | An execution engine that evaluates the compiler's checked internal program instead of emitting a native executable. |
| Ahead-of-time (AOT) compilation | Producing machine code before running it. `fwp run` uses this by default and caches the result. |
| Intermediate representation (IR) | The compiler's internal description of a program, between source text and generated code. |
| Specialization / monomorphization | Making a version of a generic function for a particular type during compilation. This removes runtime selection of trait methods at those calls. |
| Boxing / unboxing | Putting a value in a separate heap object and referring to it by an address, or using its fields directly without that object. |
| Inlining | Putting a called function's operations into the caller so a separate call is unnecessary. |
| Fusion | Combining stages such as `map`, `filter` and `sum` into one traversal when doing so preserves their observable behavior. |
| Tail call | A call whose result is returned with no remaining work, including required cleanup. It can permit frame reuse; fwp does not yet guarantee it for arbitrary recursion. |
| Backend | The compiler part that turns its internal program into executable code or another language, currently C for native fwp programs. |
| ABI (application binary interface) | The rules compiled code uses to pass arguments, return results and lay out data when calling other compiled code. |
| FFI (foreign function interface) | The facility for calling code written in another language, such as C. |
| WebAssembly / WASM | A portable instruction format executed by a host such as a browser or a WebAssembly runtime. WASI is a system-interface convention for facilities such as files. |

A **frontend** reads and checks source; a **backend** produces target code.
**Lowering** replaces a high-level operation with simpler internal operations.
For example, a known call to `energy 3` can be inlined to the operations
`3 * 3` and then addition, after which **constant folding** may compute `18`
during compilation. That is permitted only if the same effects and traps occur
in the same order. **Dead-code elimination** removes unused work only when
removing it is unobservable; an unused trapping initializer is not dead work.

A **direct call** names the target function in generated code. **Indirect dispatch**
selects or obtains a target at runtime, as with an unknown callback. A **worker**
in compiler documentation is a specialized internal function entry, not a thread.
For a record `(x, y)`, a worker may receive the two fields directly;
**scalar replacement** removes a temporary aggregate whose separate fields suffice.
**Escape analysis** checks whether a value can outlive the proposed storage;
**liveness analysis** checks where its value can still be needed. A failed proof
keeps the required ordinary representation; it is not proof that the program is unsafe.

A **call stage** is the work executed after a particular argument is supplied.
For `fn x -> let offset = x + 1 in fn y -> y + offset`, computing `offset`
belongs to the first stage. An optimizer must not delay its possible overflow
until the second argument arrives. **Saturation** means supplying all arguments
expected by a particular entry; a **partial application** supplies fewer.
A source function still takes one argument at a time even if the internal ABI
uses a multi-field or multi-argument entry.

A **tail-recursive** function calls itself with nothing left to do afterward.
A supported self-tail call can replace the current call frame. In contrast,
`1 + recurse (...)` still has an addition to perform and is not a tail call.
**Mutual recursion** involves functions calling one another; fwp's self-tail
optimization does not promise constant stack use for that general case.

A **target** identifies an operating system, processor architecture and relevant
binary conventions. ARM64/AArch64 and AMD64/x86-64 are two instruction sets.
**Cross-compilation** produces code for a different target than the build host;
**emulation** runs another target's instructions through a translation engine.
Neither proves that a program runs correctly on the actual target hardware.
**O0, O1, O2 and O3** name C compiler optimization levels, not levels of language
correctness. **LTO** allows optimization across separately compiled units.
**PGO** uses execution profiles to guide optimization; support depends on the
selected toolchain. **JIT** means compiling during program execution; it is
excluded from fwp. `fwp run` compiling before launching a program is AOT.

See [the compilation pipeline](compiler-pipeline.md),
[representations](design.md#runtime-representation-and-c-safety) and
[tail calls](design.md#tail-calls-and-recursion).

## Parsing and macros

Consider `2 + 3 * 4`. A **lexer** separates its characters into **tokens**:
`2`, `+`, `3`, `*`, `4`. A **parser** determines their structure. **Precedence**
groups it as `2 + (3 * 4)`, producing `14`. **Associativity** chooses grouping
at the same precedence: `20 - 6 - 2` means `(20 - 6) - 2`, producing `12`.
The **AST**, or abstract syntax tree, records this structure. It is not machine code.

| Term | Concrete meaning |
|---|---|
| Grammar | Rules for assembling tokens into declarations, expressions and patterns. A valid token sequence can still fail later type checking. |
| Recursive descent | Parser functions call one another to recognize smaller constructs: parsing parentheses invokes expression parsing again. |
| Top-down / predictive parsing | Start with the construct being expected, then select its parts using upcoming tokens. |
| Lookahead | Inspect upcoming tokens before choosing a rule, without consuming them yet. |
| LL(k) | Read left to right, derive the leftmost unfinished rule, using up to `k` tokens of lookahead. fwp is LL-style; it has no maintained proof of an LL(k) grammar. |
| FIRST / FOLLOW | Sets of tokens that can begin a grammar rule or occur after it; these help establish whether predictive choices are unambiguous. |
| LR / LALR | Bottom-up parser families that combine recognized pieces using parsing states and shift/reduce decisions. fwp does not use generated LR tables. |
| Precedence climbing | Parse an operator's right side with a minimum allowed binding strength; this puts `3 * 4` inside the addition above. This is fwp's infix strategy. |
| Pratt parser | A related expression-parsing approach organized around token-specific prefix/infix handlers. fwp's dedicated application/atom routines are not a general Pratt framework. |
| PEG / packrat | PEG rules select ordered alternatives. Packrat memoizes parsing results to avoid repeated work. These are distinct concepts, and neither describes fwp's implementation. |
| Backtracking | Undo an attempted parse and try another alternative. fwp's successful parser does not search alternatives this way. |
| Layout-sensitive | Line starts and indentation help delimit constructs. Indenting continuation lines is not arbitrary implicit function application. |
| Context-free grammar | Rules describe syntactic forms without inspecting surrounding declarations. fwp's implementation also uses column and validation rules; a grammar fragment is not a classification proof for the entire frontend. |
| Desugaring | Translate convenient syntax into simpler existing operations. For example, field shorthand `{ x }` means `{ x = x }`. |
| Macro expansion | Execute a macro during compilation to produce replacement syntax, then check the resulting program. |
| Quote / unquote | Quote represents source structure as a syntax value; unquote inserts prepared syntax into it. Neither means concatenating source strings. |
| Hygiene | Introduced names do not accidentally capture names in inserted user code. A macro's private `temp` must not replace the caller's `temp`. |
| Compile-time evaluation | Evaluate an expression while compiling; `comptime` and macro execution have their own rules and checked types. |
| Source span / source map | A span locates source text; a map connects generated operations back to those locations for diagnostics and debugging. |

[The parser guide](compiler-pipeline.md#what-kind-of-parser-is-this) gives the
implementation's precise classification and limits.
[The macro lesson](tutorials/11-comptime-and-macros/README.md) provides runnable examples.

## Memory and processors

| Term | Meaning |
|---|---|
| Heap allocation | Asking the memory allocator for a block whose lifetime is managed separately from an ordinary function call. |
| Stack / stack frame | Storage associated with active calls. A frame holds a call's local data and saved machine state. |
| Ownership / lifetime | Responsibility for keeping a value alive and eventually releasing its storage; the lifetime is how long that storage remains valid. |
| Borrow / retain / release | Use an existing value temporarily without taking ownership; add an owning reference; remove an owning reference. |
| Alias | Another reference to the same storage. Sharing a value does not permit changing its observable contents. |
| Owning cycle | A loop of references that keep each other alive. Counting alone cannot reclaim it; recursive types and shared values need not form cycles. |
| Weak reference | A non-owning way to find an object that may already have been destroyed. `WeakChannel[a]` observes a channel without owning it; explicit upgrade returns `Some channel` or `None`. See [weak channels](weak-channels.md). |
| ARC (automatic reference counting) | Track owning references and release an object after the last is removed. Counting alone does not reclaim reference cycles. |
| GC / tracing collector | Garbage collection is automatic reclamation of unused storage. In this project, “remove GC” means remove tracing: following references from live roots to find unreachable objects. ARC remains automatic memory management. Tracing has been removed from fwp. |
| Root | A starting point for a reachability or lifetime argument, such as an active call or an exported entry. Historical “GC root” specifically means a value from which a collector starts tracing. |
| Generational collector | A tracing collector that checks young objects separately from older ones. This appears in historical evidence, not as a current fwp runtime component. |
| Register / spill | A small CPU storage location used directly by instructions; a spill stores a value in memory when it cannot remain in a register. |
| CPU cache / cache locality | Small fast memory near the processor; locality means accessing nearby or recently used data that can benefit from it. |
| Alignment / padding | Placing data at addresses suitable for its machine type; padding is unused space inserted to meet layout requirements. |
| Payload / allocator overhead | Bytes holding the requested program data; additional bytes used by the allocator to manage those blocks. These are different measurements. |
| Zero-cost abstraction | A design aim that a language feature adds no extra runtime work compared with an equivalent lower-level implementation. It must be demonstrated for a specific case, not assumed for all fwp code. |

### Following an owner

Suppose `a` owns a dynamically created String. Passing it temporarily to a reader
can **borrow** it: `a` keeps it alive while the reader runs. Saving it in another
long-lived value may require **retaining** a second owner. Once neither owner
needs it, their releases allow its storage to be freed. A **move** transfers the
existing ownership responsibility rather than adding another owner. These are
implementation decisions; writing two source names does not necessarily execute
a retain instruction.

For a returned closure that captures this String, the closure must keep it alive
after the creating call returns. Putting that captured storage in a departed
stack frame would cause a **use-after-free**: reading storage whose lifetime ended.
The compiler must prove such an escape cannot happen before choosing stack storage.
A **region** or **arena** groups allocations under one lifetime; freeing that group
is safe only when none of its values remain in use outside it. fwp's scoped parser
region is one proven case, not automatic region inference for every program.

An **owning cycle** could be A owning B while B owns A. Dropping the outside
references leaves each count nonzero. A weak edge does not keep its target alive,
but accessing it requires checking whether the target still exists. fwp exposes
specific weak-channel operations; it does not promise arbitrary Swift-style weak
references or general cycle reclamation. **Structural sharing** means immutable
values reuse some storage; it does not itself imply a cycle.

**Reuse** can overwrite uniquely owned storage when the old logical value can
no longer be observed. A **copy-on-write** strategy copies shared storage before
changing it. **Retention** means storage remains alive; a **leak** is unwanted
storage that never becomes reclaimable through the intended lifecycle. A bounded
**workspace cache** deliberately keeps a stated amount for reuse and must release
it at shutdown. **Peak memory** and **total allocated bytes** answer different
questions even when there is no leak.

### Layout and the CPU

A list of separately allocated cells involves **pointer chasing**: load a cell,
read its next address, then load another cell. A **contiguous buffer** puts elements
next to each other. Reading consecutive elements can benefit from cache locality.
A **cache line** is a block the CPU transfers between memory and cache; its size
is hardware-dependent. **SIMD** executes an operation across several numeric
lanes in one instruction when the target and semantics permit it.

An aligned record may contain **padding** between fields. For example, a one-byte
flag followed by an eight-byte integer may need seven intervening bytes on an
ABI that aligns the integer to eight bytes. That is an illustrative layout,
not a promise about every fwp record. A boxed record also needs allocator/header
storage. **Unboxed** does not mean “no memory”: separate fields may occupy
registers, stack slots or an enclosing object.

A **spill** happens when a value is stored in memory because it cannot stay in a
CPU register. Register allocation is primarily the C compiler's responsibility
in fwp's current backend. Fewer source variables do not prove fewer spills.
**Undefined behavior** in generated C means violating C's rules, such as accessing
freed storage or using an incompatible typed pointer; apparent success at O0
does not establish safety at O2. **Strict aliasing** constrains which pointer
types may access an object. Representation tests therefore check supported
compilers and optimization settings, not just the shape of emitted C.

See [ownership](ownership.md), [weak channels](weak-channels.md) and
[memory layout](design.md#runtime-representation-and-c-safety).

## Numerical programming

A **scalar** is one number, such as `3`. A **vector** is an ordered collection,
such as `[3, 4]`; a **matrix** is a rectangular grid. A **tensor** generalizes
arrays to more dimensions; its **shape** gives those dimensions. A 2×3 matrix
has six elements. A **kernel** is the calculation on that data, separated from
other work such as loading files or printing results. **Reduction** combines
many elements into one value: summing `[3, 4]` gives `7`.

### Derivatives and gradients

For `y = x * x + 2`, the **derivative** describes how quickly `y` changes near a
particular `x`. At `x = 3`, its value is `6`: increasing `x` by a small amount
changes `y` by approximately six times that amount. For an increase of `0.01`,
the exact output increase is `0.0601`, close to `6 * 0.01 = 0.06`.
The derivative describes the local rate, not an exact prediction for a finite step.

A **partial derivative** varies one input while holding the others fixed.
For `z = x * y + x`, at `(x, y) = (3, 4)`, the output is `15`.
The derivative with respect to `x` is `y + 1 = 5`; with respect to `y`, it is
`x = 3`. The **gradient** collects them in input order: `[5, 3]`.
A **Jacobian** has one such row for each output. A **Hessian** contains the
second derivatives of a scalar output: how its gradient changes with its inputs.
For `x * x + 2`, the first derivative is `2*x` and the second derivative is `2`.

**Automatic differentiation (AD, or autodiff)** computes derivatives by applying
local differentiation rules to executed operations. The **chain rule** connects
those rules: if `y` changes twice as fast as `u`, and `u` three times as fast as
`x`, that path contributes `2 * 3 = 6` to `dy/dx`. Contributions from multiple
paths add. This differs from **finite differences**, which estimate a derivative
by running the function at nearby inputs and dividing the output change by the
input change. It also differs from **symbolic differentiation**, which rewrites
an expression into another formula.

### Tape and backward pass

A **tape** records dependencies and local derivative weights during one forward
execution. It is not a video of execution, a log of every instruction, or a GC
heap. To calculate `y = x * x + 2` at `x = 3`, introduce `u` for the multiplication:

| Step | Ordinary calculation | Result | Dependency information for derivatives |
|---|---|---:|---|
| Input | `x` | 3 | One input whose derivative is wanted. |
| Multiply | `u = x * x` | 9 | Two edges to `x`, each with local derivative weight `3`. |
| Add | `y = u + 2` | 11 | One edge to `u`, with weight `1`; `2` is constant. |

The result column explains the calculation; fwp need not save every one of these
results. Its ordinary floating tape stores parent indices and local weights.
A **node** identifies an input or recorded operation. A **parent** is an earlier
node that an operation depends on; an **edge** is that dependency with its weight.
A **leaf** here is an input node. The two edges of `x * x` have the same parent,
but both contributions matter.

The **forward pass** computes the output `11` while preparing this record.
The **backward pass** walks dependencies in the opposite direction:

1. Give the output `y` a **seed** of `1`: the derivative of `y` with respect to
   itself is one. Other accumulated weights start at zero.
2. The addition contributes `1 * 1 = 1` to `u`.
3. The multiplication contributes `1 * 3 = 3` to `x` through each of its two
   inputs. Add both contributions: `3 + 3 = 6`.
4. Return the input gradient `[6]`.

An **adjoint** is one accumulated backward derivative weight. In this example,
`y` and `u` have adjoint `1`, and `x` finishes with adjoint `6`. The **primal**
is the ordinary value: `x` has primal `3`, while its adjoint is `6`.
They answer different questions and must not be substituted for one another.

Here is a complete fwp program computing that gradient:

```fwp
objective : List[t] -> t where Ring[t], FromFloat[t], Dup[t]
objective = head | option.unwrap-or zero | fn x -> x * x + 2.0

main = [3.0] | grad objective | echo
```

It prints `[6.0]`. `head` obtains the first input; `option.unwrap-or zero` supplies
zero for an empty list. The signature keeps the formula generic so `grad` can
apply it to derivative-carrying numbers. `Ring`, `FromFloat` and `Dup` require
arithmetic, floating-literal construction and permitted value duplication.
`grad` receives a function and a list of inputs, then returns a list of derivatives.
The formula is written once; the programmer does not write its derivative.

A **tape scope** bounds how long recorded nodes may be used. A **stale node**
refers to a tape that has already ended; **mixed nodes** belong to unrelated tapes.
fwp rejects those uses rather than reading invalid storage. **Retirement** ends
a tape's use; its permitted raw buffers may enter a bounded workspace cache.
**Raw buffers** contain numeric storage outside managed object counters; they
still need owners and physical release.

For ordinary F16/BF16/F32/F64 reverse calculations, fwp accumulates weights in F64.
A **typed** or **owned tape** holds language values, needed for F128 precision and
nested derivatives. It must keep those values and its arithmetic callbacks alive.
“Owned” describes their memory responsibility, not a different differentiation rule.

### Other differentiation terms

**Forward mode** carries a derivative alongside each value as the calculation
proceeds. Starting with `(x, dx) = (3, 1)`, multiplication produces
`(u, du) = (9, 1*3 + 3*1) = (9, 6)`, and adding the constant produces `(11, 6)`.
This value/derivative pair is a **dual number**. No reverse traversal is needed
for that input direction. Multiple independent input directions can require
multiple forward evaluations; reverse mode instead propagates from outputs.
In fwp, `derivative`, `gradient` and `jacobian` are forward-mode helpers;
`grad` and `rev.jacobian` use reverse mode.

A **vector-Jacobian product (VJP)** weights several outputs before combining their
derivatives. For outputs `[x*x, 3*x]` at `x = 2`, derivatives are `[4, 3]`.
Seeds `[2, 5]` give `2*4 + 5*3 = 23`. Seeds choose the output combination; they
are not guesses about the input gradient. A **Jacobian-vector product (JVP)**
propagates an input direction forward: direction `2` gives output changes `[8, 6]`
in this example. This defines the term; it is not a promise of a `jvp` API.

**Nested differentiation** differentiates a derivative calculation, for example
to obtain the second derivative `2` above. Inner reverse arithmetic can itself
be recorded by an enclosing tape. **Checkpointing** saves selected intermediate
states and recomputes others when needed: less retained history, more execution.
**Stop-gradient** keeps a value while treating its dependency as constant for
that derivative. **Gradient descent** repeatedly subtracts a step size times a
gradient to seek a lower objective value; it is an algorithm using AD, not AD itself.
**Rosenbrock** in our benchmarks names the objective
`sum(100*(y - x*x)^2 + (1 - x)^2)` over adjacent coordinates.

### Precision and arithmetic order

F16, BF16, F32, F64 and F128 are floating formats with different precision and
ranges. A floating value has a sign, an exponent controlling scale, and a
**significand** carrying significant digits. **Rounding** selects a representable
result when the exact mathematical answer cannot fit. **NaN** represents results
such as invalid arithmetic; it is not equal to itself under ordinary floating
comparison. **Infinity** represents an unbounded floating result; signed zeros
can also behave differently in later operations.

**Reassociation** changes grouping, such as `(a+b)+c` to `a+(b+c)`.
With finite precision these can differ. **Fused multiply-add (FMA)** calculates
`a*b+c` with one final rounding instead of two; it can likewise change exact bits.
**Fast math** permits transformations that relax ordinary floating guarantees.
fwp's exact-order comparisons do not enable it to gain a better benchmark.
**Checked integer arithmetic** traps on an unsupported overflow instead of
silently wrapping. **Bitwise equality** requires identical representations;
a **tolerance** permits a stated numerical difference. Neither means universally
correct derivatives at discontinuities: differentiating the executed branch of
an absolute-value calculation at zero does not define a unique smooth derivative.

See [numerics](numerics.md), [the autodiff lesson](tutorials/20-autodiff-and-devices/README.md)
and [derivative measurements](measurements/descent-costs.md).

## Networking and tools

- **HTTP** is the request/response protocol used by web clients and servers.
  An **endpoint** is a route a client can call; its **handler** is the function
  that processes the request. **REST** is a style of arranging such routes.
- **JSON** is a text format for values such as objects, lists and numbers.
  A **schema** describes which values are allowed. **OpenAPI** describes an
  HTTP API's routes, inputs and outputs in a machine-readable document.
- **TLS** encrypts a connection and checks the peer's identity using certificates.
  HTTPS is HTTP over TLS. **ALPN** lets peers choose an application protocol
  during the TLS handshake. **h2** is HTTP/2 over TLS; **h2c** is unencrypted HTTP/2.
- **WebSocket** keeps a connection open for messages in both directions.
  **gRPC** represents calls between processes as messages carried over HTTP/2.
- **MCP (Model Context Protocol)** lets applications discover and call tools.
  fwp can expose exported functions as those tools.
- **CLI** means command-line interface. **stdin**, **stdout** and **stderr** are
  a process's standard input, standard output and error-output streams.
- A **task** is a unit of concurrent work. A **channel** is a queue for sending
  values between tasks. **Backpressure** makes a producer wait when its consumer
  cannot keep up. A **deadline** limits how long work may continue.

A **protocol** defines how participants communicate, including message forms and
lifetime rules; two supported protocols are alternatives, not fallbacks of one
another. **Serialization** converts values to a transfer/storage representation;
**deserialization** constructs values from it. A **codec** performs those conversions.
**Framing** tells a receiver where messages end; a network read need not return a
whole message. A **stream** delivers a sequence incrementally. A **subscription**
keeps a source active until its consumer finishes or cancels.

A **REPL** repeatedly reads an expression, evaluates it, prints its result and
waits for another. A notebook **cell** is one editable unit of code or text.
**Reactive dependencies** connect cells so changes can identify which results
need recomputation. Neither interface implies a JIT. A **debugger** pauses and
inspects execution; a **breakpoint** selects a pause location, and **stepping**
advances by a chosen unit. **Instrumentation** adds observations such as counters
or events; it can change timing. An **SDK** is a programming interface for driving
a tool, such as the Python debugger API. **LSP**, the Language Server Protocol,
connects editor features such as navigation and diagnostics to a language tool.

**Disassembly** translates machine instructions into readable instruction names.
It is different from emitted C, which is the compiler's input to the C toolchain.
A **symbol** names an entry or object in a binary; an **instruction section** is
an executable part of that binary. A **stack report** estimates selected static
frames, not total memory for every recursive path. Such evidence helps verify
representation claims; it does not by itself prove memory safety or speed.

See [interfaces](interfaces.md), [REPL](repl.md), [notebooks](notebooks.md) and
[debugging](debugging.md) for supported commands and settings.

## Tests and measurements

A **baseline** is the implementation a result is compared with. A **control**
is a deliberately changed version used to isolate one behavior. Neither word
implies C or Rust: many compiler experiments compare fwp with another fwp build.

**Elapsed time** is the time measured by a clock. **Overhead relative to a
baseline** is the extra cost: for time, `(fwp time / baseline time - 1) × 100%`.
A ratio of `1.25×` means 25% longer; `0.80×` means 20% shorter. Equivalent output
alone does not prove equivalent algorithms or work.

An **allocation count** counts requests, not bytes. **Cumulative requested
bytes** add every request, including growth; **peak live bytes** are the largest
amount held at once. **Process RSS** is operating-system resident memory and
includes more than the language's heap counters. Do not interchange these.

A **golden test** compares output with a checked-in expected result. A
**regression test** checks that a repaired behavior stays correct. A **negative
control** deliberately introduces a defect and checks that the test detects it.
**GC stress**, in historical reports, requested frequent tracing collections to
expose missing live roots. Current checks observe owners and physical releases.

**CI** is the automated build/test service. A **gate** is a required passing
check before merge. **Final head** means the exact Git commit being merged;
a passing older commit or a skipped job does not satisfy that check.


### Reading a benchmark without mixing its costs

Suppose the same input takes C **10 ms** and fwp **12 ms**, measured over the same
work. The time ratio is `12 / 10 = 1.2`; the extra elapsed time is **20%**.
If the implementations use different algorithms, the ratio still describes those
programs, but cannot isolate language or ARC overhead. Our explicit C/Rust
derivative formulas do less work than general reverse-mode AD.

A **timing boundary** states what the clock includes. A kernel-only timer might
exclude input construction and output formatting; a whole-process timer includes
startup and teardown. A **phase** is a separately measured part, such as forward
recording or backward traversal. Phase clocks can perturb the run, so their
instrumented totals need not equal an ordinary executable's time.

**Latency** is time for one operation; **throughput** is completed operations per
unit time. **Warmups** are declared preliminary runs, separate from measured
samples. A **round** is one scheduled set of observations; a **session** is a
separate run of the declared experiment. A **median** is the middle sorted value,
not a guarantee about the worst case. **Noise** is variation unrelated to the
intended implementation change, such as host scheduling. **Host qualification**
checks declared CPU/toolchain requirements before collecting comparable results.

An **identical-copy control** runs the same executable under two measurement
labels. If those appear 4% different under a fixed 2% limit, the experiment is
**inconclusive** at that resolution. It does not establish a 4% compiler change.
A **same-source reference** changes only the optimization being studied in a
copy of the current source. An **acceptance budget** is a limit fixed before
observing candidate results; changing it afterward does not turn a failed
measurement into a pass. **D2** in retained reports names the derivative speed
goal; **N1/N2** name numerical baseline/optimization work, not language features.

For memory, suppose a program allocates and frees a 1 MiB block 100 times in
sequence. That is **100 requests**, **100 MiB cumulative requested bytes**, but
approximately **1 MiB peak live payload**. The allocator may charge headers and
rounding as well. **Managed charge** is fwp's allocator accounting, while raw
buffers and foreign libraries can have separate accounting. **RSS** includes
resident code, stacks and other process memory too. **High-water mark** means a
peak; independent peaks cannot simply be added as if they occurred together.

A **ledger** records acquisitions and releases; a **zero final delta** means its
measured storage returns to its starting level. It does not prove zero peak usage
or cover memory outside that ledger. **Physical release** means the underlying
owner/allocation is actually released, not merely that a logical object is unused;
it does not guarantee an immediate drop in OS-reported RSS.

A **negative control** might deliberately retain one owner. The cleanup test must
then fail, demonstrating that its observer can see that leak. A **fixture** is a
fixed input/program used by a test. A **shard** is one assigned subset of tests;
passing it is not passing the whole suite. An **artifact** is retained evidence,
such as source, generated C, a binary, log or raw observations. A **source ID** is
the exact revision that produced it; old measurements do not describe current
code automatically. A **squash merge** combines a PR's changes into one commit;
its tree must match the verified candidate even though its commit ID changes.

See [benchmark boundaries](benchmarks.md#reading-a-result),
[memory measurements](benchmarks.md#understanding-memory-measurements) and
[retained reports](measurements/README.md).
