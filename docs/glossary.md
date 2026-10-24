# Terms used in these docs

This page explains recurring terms. Guides introduce the terms needed for their
examples where they first appear; this is a lookup page, not a prerequisite to
reading the tutorials.

## Reading a program

| Term | Meaning in fwp |
|---|---|
| Pipe | `x \| f` passes `x` to `f`. Between functions, `f \| g` makes a function that runs `f` and then `g`. |
| Data-last | Configuration arguments come first, and the value being transformed comes last: `10 \| sub 3` gives `7`. |
| Curried function | A function receives arguments one at a time. `add 3` is a function still waiting for the number to add to. |
| Partial application | Supplying some of a function's arguments to make a function waiting for the rest. |
| Tacit function | A definition that combines functions without naming their input, such as `double = mul 2`. |
| Combinator | An ordinary function that connects other functions. `both f g` applies both to one input and returns their two results. |
| Callback | A function passed to another operation to be called later or for each element, such as `mul 2` in `map (mul 2)`. |
| Constant function | A function that ignores its input and returns a chosen value. `const 7` returns `7` for every input; the value `7` alone is not a function. |
| Unit | The value `()`, used when there is no meaningful input or result. It is not the empty list `[]`. |
| Tuple / projection | A tuple groups values by position, such as `(3, "cat")`. A projection selects one: `.0` is the first, `.1` the second. |
| Record / field | A record groups values by name, such as `{ age = 3 }`. `.age` selects that field. |
| Variant / constructor | A type with named alternatives, such as `Option[T]`, whose values are `None` or `Some value`. A constructor makes one alternative. |
| Pattern / arm | A pattern describes a value's shape in `match`; its arm is the expression after `->`. In fwp, `_` captures an argument for that expression. |
| Immutable value | A value whose meaning cannot change after creation. An update returns a new logical value, even if the compiler can safely reuse its storage. |

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

## Memory and processors

| Term | Meaning |
|---|---|
| Heap allocation | Asking the memory allocator for a block whose lifetime is managed separately from an ordinary function call. |
| Stack / stack frame | Storage associated with active calls. A frame holds a call's local data and saved machine state. |
| Ownership / lifetime | Responsibility for keeping a value alive and eventually releasing its storage; the lifetime is how long that storage remains valid. |
| Borrow / retain / release | Use an existing value temporarily without taking ownership; add an owning reference; remove an owning reference. |
| Alias | Another reference to the same storage. Sharing a value does not permit changing its observable contents. |
| Owning cycle | A loop of references that keep each other alive. Counting alone cannot reclaim it; recursive types and shared values need not form cycles. |
| Weak reference | A non-owning way to find an object that may already have been destroyed. A public weak-handle API is under consideration, not implemented in fwp. |
| ARC (automatic reference counting) | Track owning references and release an object after the last is removed. Counting alone does not reclaim reference cycles. |
| GC (garbage collection) | Find objects no longer reachable by the program and reclaim them. A tracing collector follows references from live roots. |
| Root | A value the collector starts from, such as a live value held by an active call. |
| Generational collector | A collector that checks recently allocated objects separately from older objects for some collections. |
| Register / spill | A small CPU storage location used directly by instructions; a spill stores a value in memory when it cannot remain in a register. |
| CPU cache / cache locality | Small fast memory near the processor; locality means accessing nearby or recently used data that can benefit from it. |
| Alignment / padding | Placing data at addresses suitable for its machine type; padding is unused space inserted to meet layout requirements. |
| Payload / allocator overhead | Bytes holding the requested program data; additional bytes used by the allocator to manage those blocks. These are different measurements. |
| Zero-cost abstraction | A design aim that a language feature adds no extra runtime work compared with an equivalent lower-level implementation. It must be demonstrated for a specific case, not assumed for all fwp code. |

## Numerical programming

A **scalar** is one number. A **vector** is an ordered group of numbers, a
**matrix** is a rectangular grid, and a **tensor** generalizes these arrays to
more dimensions. A **kernel** is the computation applied to such data, rather
than the whole program that loads, allocates and prints it.

A **derivative** measures how an output changes near an input. A **gradient**
groups the derivatives of one scalar output with respect to several inputs.
A **Jacobian** is the table of derivatives for several outputs and inputs.
**Automatic differentiation (AD, or autodiff)** applies differentiation rules
to the operations the program executes; it is not finite-difference sampling.

**Forward mode** carries a derivative alongside each value. **Reverse mode**
records operations and works backward from chosen output weights. The record is
called a **tape**; an **adjoint** is a derivative accumulated during that backward
pass. A **seed** is the initial derivative weight, often `1`. A **vector-Jacobian
product (VJP)** combines derivatives of several outputs using a supplied list of
weights. **Checkpointing** saves selected intermediate values and recomputes
other operations later to reduce stored history, at the cost of extra work.

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
**GC stress** requests collection unusually often to expose missing live roots.

**CI** is the automated build/test service. A **gate** is a required passing
check before merge. **Final head** means the exact Git commit being merged;
a passing older commit or a skipped job does not satisfy that check.
