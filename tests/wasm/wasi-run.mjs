// Run a WASI module with node: `node wasi-run.mjs program.wasm [args...]`.
// Standard streams, arguments and environment are passed through; the
// current directory is preopened as ".". The module runs in a worker with
// a large stack, since deep recursion uses the engine's native stack.
import { readFile } from "node:fs/promises";
import { WASI } from "node:wasi";
import { Worker, isMainThread, parentPort, workerData } from "node:worker_threads";
import process from "node:process";

if (isMainThread) {
  const worker = new Worker(new URL(import.meta.url), {
    workerData: { args: process.argv.slice(2), env: process.env },
    resourceLimits: { stackSizeMb: 1024 },
    stdin: false,
  });
  worker.on("message", (code) => process.exit(code));
  worker.on("error", (e) => {
    console.error(e);
    process.exit(1);
  });
} else {
  const wasi = new WASI({
    version: "preview1",
    args: workerData.args,
    env: workerData.env,
    preopens: { ".": "." },
    returnOnExit: true,
  });
  const module = await WebAssembly.compile(await readFile(workerData.args[0]));
  const instance = await WebAssembly.instantiate(module, wasi.getImportObject());
  parentPort.postMessage(wasi.start(instance));
}
