// Drive a `--target wasm32-browser` build with node, as a page would:
// `node browser-run.mjs program.js` prints the lines the program writes.
// It runs in a worker; tasks need JavaScript Promise Integration (on by
// default in node 24), or a build with --wasm-async=asyncify.
import { readFile } from "node:fs/promises";
import { pathToFileURL } from "node:url";
import { Worker, isMainThread, parentPort, workerData } from "node:worker_threads";
import v8 from "node:v8";
import process from "node:process";

if (isMainThread) {
  const worker = new Worker(new URL(import.meta.url), { workerData: { js: process.argv[2] } });
  worker.on("message", ({ out, code }) => {
    process.stdout.write(out, () => process.exit(code));
  });
  worker.on("error", (e) => {
    console.error(e);
    process.exit(1);
  });
} else {
  const { js } = workerData;
  const { run } = await import(pathToFileURL(js).href);
  const bytes = await readFile(js.replace(/\.js$/, ".wasm"));
  const lines = [];
  const code = await run({
    bytes,
    stdout: (line) => lines.push(line),
    stderr: (line) => lines.push("stderr: " + line),
    env: { FWP_SEED: "42" },
  });
  parentPort.postMessage({ out: lines.map((l) => l + "\n").join(""), code });
}
