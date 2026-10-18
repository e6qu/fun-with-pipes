// Exercise the real loader with tiny executable WebAssembly modules. No C
// compiler, WASI SDK or simulated WebAssembly implementation is involved.
import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";

const loader = await readFile(new URL("../../runtime/wasm/loader.js", import.meta.url), "utf8");
const fibers = await readFile(new URL("../../web/fibers.js", import.meta.url), "utf8");
const { run } = await import("data:text/javascript;base64," + Buffer.from(loader + "\n" + fibers).toString("base64"));
const text = (value) => [value.length, ...new TextEncoder().encode(value)];
const section = (kind, bytes) => [kind, bytes.length, ...bytes];

// Both modules have one imported fd_write, one memory page and an exported
// _start. The first writes "hello\n" using an iovec at address 0. The second
// calls _start recursively until the engine reports stack exhaustion.
// All section lengths here fit in a single unsigned LEB128 byte.
function program(recursive, fd = 1) {
  const body = recursive ? [0, 0x10, 1, 0x0b] : [
    0, 0x41, fd, 0x41, 0, 0x41, 1, 0x41, 8, 0x10, 0, 0x1a, 0x0b,
  ];
  return new Uint8Array([
    0, 0x61, 0x73, 0x6d, 1, 0, 0, 0,
    ...section(1, [2, 0x60, 4, 0x7f, 0x7f, 0x7f, 0x7f, 1, 0x7f, 0x60, 0, 0]),
    ...section(2, [1, ...text("wasi_snapshot_preview1"), ...text("fd_write"), 0, 0]),
    ...section(3, [1, 1]),
    ...section(5, [1, 0, 1]),
    ...section(7, [2, ...text("memory"), 2, 0, ...text("_start"), 0, 1]),
    ...section(10, [1, body.length, ...body]),
    ...section(11, [2, 0, 0x41, 0, 0x0b, 8, 16, 0, 0, 0, 6, 0, 0, 0,
      0, 0x41, 16, 0x0b, ...text("hello\n")]),
  ]);
}
const bytes = program(false);
assert(WebAssembly.validate(bytes));
const lines = [];
assert.equal(await run({ bytes, stdout: (line) => lines.push(line) }), 0);
assert.deepEqual(lines, ["hello"]);
for (const [fd, sink] of [[1, "stdout"], [2, "stderr"]]) {
  for (const stopped of [new Error("sink failed"), new RangeError("host range"), "host string", undefined]) {
    let calls = 0;
    await assert.rejects(run({ bytes: program(false, fd), [sink]: () => { if (++calls === 1) throw stopped; } }), (error) => Object.is(error, stopped));
    assert.equal(calls, 1, "a failing sink must not be called again during trap reporting");
  }
}
const errors = [];
const overflow = program(true);
assert(WebAssembly.validate(overflow));
assert.equal(await run({ bytes: overflow, stderr: (line) => errors.push(line) }), 101);
assert.deepEqual(errors, ["fwp: trap: stack overflow"]);
console.log("host exceptions and actual WebAssembly stack overflow stay distinct");
