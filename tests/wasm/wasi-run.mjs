// Run a WASI module with node: `node wasi-run.mjs program.wasm [args...]`.
// Standard streams, arguments and environment are passed through; the
// current directory is preopened as ".". The module runs in a worker with
// a large stack, since deep recursion uses the engine's native stack.
// Tasks run as fibers (web/fibers.js): JavaScript Promise Integration is
// switched on for the worker (node 22 has it behind a flag), unless
// FWP_NO_JSPI=1.
import { readFile } from "node:fs/promises";
import { writeSync } from "node:fs";
import { WASI } from "node:wasi";
import { Worker, isMainThread, parentPort, workerData } from "node:worker_threads";
import v8 from "node:v8";
import process from "node:process";

if (isMainThread) {
  if (!process.env.FWP_NO_JSPI) v8.setFlagsFromString("--experimental-wasm-jspi");
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
  const { fibers } = await import(new URL("../../web/fibers.js", import.meta.url));
  const wasi = new WASI({
    version: "preview1",
    args: workerData.args,
    env: workerData.env,
    preopens: { ".": "." },
    returnOnExit: true,
  });
  class Exit {
    constructor(code) {
      this.code = code;
    }
  }
  const imports = wasi.getImportObject();
  // proc_exit may be called from any fiber: it ends the run with an
  // exception that web/fibers.js passes on
  imports.wasi_snapshot_preview1 = {
    ...imports.wasi_snapshot_preview1,
    proc_exit: (code) => {
      throw new Exit(code);
    },
  };
  const module = await WebAssembly.compile(await readFile(workerData.args[0]));
  const instance = await WebAssembly.instantiate(module, imports);
  // node:wasi only needs the memory; _start is run by web/fibers.js
  wasi.initialize({ exports: { memory: instance.exports.memory } });
  const start = await fibers(instance);
  let code = 0;
  try {
    await start();
  } catch (e) {
    if (e instanceof RangeError) {
      // the engine's stack ran out (in a task: the stacks that JSPI gives
      // fibers are smaller than the worker's)
      instance.exports.fwp_fiber_flush?.();
      writeSync(2, "fwp: trap: stack overflow\n");
      code = 101;
    } else if (e instanceof Exit) {
      code = e.code;
    } else {
      throw e;
    }
  }
  parentPort.postMessage(code);
}
