# Documentation map

Start with the [tutorials](tutorials/README.md). Lessons 1–5 introduce the notation
used by the application lessons. Use the guides below for a specific task.

## Write and run programs

| Task | Guide |
|---|---|
| Look up syntax, types, effects or a compiler command | [Language reference](reference.md) |
| Find a library operation | [Standard library](stdlib.md) |
| Understand a term through an example | [Terminology](terminology.md) |
| Run an application example | [Examples and prerequisites](../examples/README.md) |
| Try expressions or work in cells | [REPL](repl.md), [notebooks](notebooks.md) |
| Step through code or inspect emitted C/machine instructions | [Debugger and Python SDK](debugging.md) |
| Build commands, web routes or application tools | [Interface overview](interfaces.md), [CLI](cli.md), [REST/OpenAPI](rest.md), [MCP](mcp.md) |
| Run concurrent work or communicate over a network | [Tasks/channels](concurrency.md), [TLS](tls.md), [existing split-service support](services.md) |
| Connect executable stages | [Typed process protocol](protocol.md) |
| Calculate derivatives or use arrays/matrices | [Numerics](numerics.md), [floating-point formats](float-formats.md) |

## Understand memory and performance

| Question | Authoritative explanation |
|---|---|
| Who keeps a value alive? | [Ownership](ownership.md) |
| Why is a lifetime rejected? | [Accepted and rejected examples](ownership-admission.md) |
| How do weak links and C callbacks work? | [Weak channels](weak-channels.md), [retained callbacks](retained-callbacks.md) |
| When can a whole tree share one lifetime? | [Scoped parser storage](parser-workspace.md) |
| What is measured, and compared with what? | [Benchmarks and overhead](benchmarks.md) |
| What do convenient function forms cost? | [Calls and recursion](functional-costs.md) |

Tracing GC is removed. Reducing ARC, heap traffic and runtime remains measured,
pattern-specific work. Zero retains does not mean zero allocations or C/Rust
performance. [Design limits](design-limits.md) explain those boundaries.

## Work on the compiler

| Purpose | Document |
|---|---|
| Build, test and contribute | [Contributing](../CONTRIBUTING.md) |
| Find the next milestone | [PLAN.md](../PLAN.md) |
| Resume the current task and checks | [Development state](development-state.md) |
| Understand parsing, macros, desugaring and compilation order | [Compiler pipeline](compiler-pipeline.md) |
| Find implementation responsibilities and invariants | [Architecture](design.md) |
| Understand the selected memory model | [Ownership design](gc-removal-design.md) |
| Check runtime argument/result obligations | [Primitive contracts](primitive-ownership.md) |
| Verify lifetime and application behavior | [Ownership checks](ownership-diagnostics.md), [application acceptance](application-acceptance.md) |
| Find past results and source identities | [Delivery history](roadmap-history.md), [measurement index](measurements/README.md), [preparation records](preparation-records.md) |

The plan owns future work; the handoff owns current status. Reference guides
describe implemented behavior. Dated reports preserve the original experiment,
including slower results and failed controls. Read their source and timing scope
before comparing numbers across reports.
