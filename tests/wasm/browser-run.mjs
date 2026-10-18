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
  v8.setFlagsFromString(process.env.FWP_NO_JSPI ? "--no-experimental-wasm-jspi" : "--experimental-wasm-jspi");
  const worker = new Worker(new URL(import.meta.url), { workerData: { js: process.argv[2], env: process.env } });
  worker.on("message", ({ out, err, code }) => {
    process.stdout.write(out, () => process.stderr.write(err, () => process.exit(code)));
  });
  worker.on("error", (e) => {
    console.error(e);
    process.exit(1);
  });
} else {
  const { js, env } = workerData;
  const { run } = await import(pathToFileURL(js).href);
  const bytes = await readFile(js.replace(/\.js$/, ".wasm"));
  const lines = [];
  const errors = [];
  const code = await run({
    bytes,
    stdout: (line) => lines.push(line),
    stderr: (line) => errors.push(line),
    env: { ...env, FWP_SEED: "42" },
  });
  parentPort.postMessage({ out: lines.map((l) => l + "\n").join(""), err: errors.map((l) => l + "\n").join(""), code });
}
