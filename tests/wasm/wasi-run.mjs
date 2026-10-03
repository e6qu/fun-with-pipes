// Run a WASI module with node: `node wasi-run.mjs program.wasm [args...]`.
// Standard streams, arguments and environment are passed through; the
// current directory is preopened as ".". The module runs in a worker with
// a large stack, since deep recursion uses the engine's native stack.
// Tasks run as fibers (web/fibers.js), with JavaScript Promise Integration
// (on by default in node 24); FWP_NO_JSPI=1 switches it off for the
// worker.
import { readFile } from "node:fs/promises";
import { writeSync } from "node:fs";
import { WASI } from "node:wasi";
import { Worker, isMainThread, parentPort, workerData } from "node:worker_threads";
import v8 from "node:v8";
import process from "node:process";

if (isMainThread) {
  // node:wasi's functions are "fast API" functions, which optimized code
  // calls directly; when one of them allocates (fd_write does), V8 may
  // collect garbage in the middle of such a call and then crash walking
  // the stack (node 22: a segmentation fault; node 24: the fatal error
  // "Check failed: isolate_->IsOnCentralStack()"; both more likely the
  // more the program switches fibers). Plain API calls are safe.
  v8.setFlagsFromString("--no-turbo-fast-api-calls");
  // JSPI is on by default in node 24 (node 22 needs the flag);
  // FWP_NO_JSPI=1 turns it off, as an engine without it
  v8.setFlagsFromString(process.env.FWP_NO_JSPI ? "--no-experimental-wasm-jspi" : "--experimental-wasm-jspi");
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
  // WASI's 32-bit arguments are unsigned, but WebAssembly passes i32s to
  // JavaScript as signed numbers: node 24 rejects the negative ones (an
  // address beyond 2 GiB, as the stacks of thousands of tasks reach) with
  // EFAULT, so they are made unsigned here
  const unsigned = {};
  for (const [name, f] of Object.entries(imports.wasi_snapshot_preview1))
    unsigned[name] = (...a) => f(...a.map((x) => (typeof x === "number" && x < 0 ? x >>> 0 : x)));
  imports.wasi_snapshot_preview1 = {
    ...unsigned,
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
