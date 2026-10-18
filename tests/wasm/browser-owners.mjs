// Exercise the generated loader's public run() boundary. Each invocation owns
// a separate instance; output callbacks receive copied JavaScript strings.
import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import { pathToFileURL } from "node:url";

const loader = process.argv[2];
const { run } = await import(pathToFileURL(loader).href);
const bytes = await readFile(loader.replace(/\.js$/, ".wasm"));
const expected = await readFile(process.argv[3], "utf8");
const env = { FWP_GC: "off", FWP_GC_STRESS: "0", FWP_GC_VERIFY: "0", FWP_REUSE_VERIFY: "0" };
const saved = [];
async function invoke(onLine) {
  const output = [];
  const errors = [];
  const code = await run({ bytes, env,
    stdout: (line) => { output.push(line); onLine?.(line); },
    stderr: (line) => errors.push(line),
  });
  assert.equal(code, 0);
  assert.deepEqual(errors, []);
  assert.equal(output.map((line) => line + "\n").join(""), expected);
  saved.push(output);
}

await invoke();
await invoke();
await Promise.all([invoke(), invoke()]);
let nested;
await invoke(() => { nested ??= invoke(); });
await nested;
const stopped = new Error("host output sink stopped");
await assert.rejects(invoke(() => { throw stopped; }), (error) => error === stopped);
await invoke();
// Earlier output remains valid after other instances have finished or failed.
for (const output of saved) assert.equal(output.map((line) => line + "\n").join(""), expected);
console.log("sequential, concurrent, reentrant and throwing sinks pass");
