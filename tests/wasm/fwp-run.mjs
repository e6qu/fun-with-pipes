// Run fwp.wasm, the WebAssembly build of fwp itself, under node:
//
//   node fwp-run.mjs (wasi|shim) fwp.wasm [fwp arguments...]
//
// `wasi` uses node:wasi with the current directory preopened as ".".
// `shim` uses the playground's own WASI (web/wasi.js): the files of the
// current directory (recursively, without hidden directories and
// `target`) are copied into its in-memory file system first, as the
// playground does with its editor's contents.
// Standard input, standard output, standard error and the exit code are
// passed through; FWP_SHOW_FILE=path prints that file of the in-memory
// file system after the run. The module runs in a worker with a large
// stack, since deep recursion uses the engine's stack.
//
// Tasks run as fibers (web/fibers.js), with JavaScript Promise Integration
// (on by default in node 24); since fwp's main task is a fiber too,
// fibers get the stack size of the worker. FWP_NO_JSPI=1 runs fwp as an engine without JSPI would (no
// tasks).
import { readFile, readdir, stat } from "node:fs/promises";
import { WASI } from "node:wasi";
import { Worker, isMainThread, parentPort, workerData } from "node:worker_threads";
import { readFileSync, writeSync } from "node:fs";
import v8 from "node:v8";
import process from "node:process";

if (isMainThread) {
  const [mode, wasm, ...args] = process.argv.slice(2);
  // The stacks of fibers (the whole run of fwp, since its main task is one)
  // have the size of the worker's stack, up to 256 MiB (node reserves one
  // for each task).
  const stackMb = Number(process.env.FWP_STACK_MB || 512);
  // FWP_NO_JSPI=1: as an engine without JavaScript Promise Integration
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
  // the size of JSPI stacks: node 22 takes it from
  // --wasm-stack-switching-stack-size, node 24 from --stack-size (which
  // the worker's own limit overrides for its main stack)
  v8.setFlagsFromString(`--wasm-stack-switching-stack-size=${Math.min(stackMb, 256) * 1024}`);
  v8.setFlagsFromString(`--stack-size=${Math.min(stackMb, 256) * 1024}`);
  const worker = new Worker(new URL(import.meta.url), {
    workerData: { mode, wasm, args, env: process.env, stdin: mode === "shim" ? readFileSync(0) : null },
    resourceLimits: { stackSizeMb: stackMb },
    stdin: false,
  });
  worker.on("message", (code) => process.exit(code));
  worker.on("error", (e) => {
    console.error(e);
    process.exit(1);
  });
} else {
  const { mode, wasm, args, env, stdin } = workerData;
  const module = await WebAssembly.compile(await readFile(wasm));
  const argv = ["fwp", ...args];
  let code;
  if (mode === "wasi") {
    const wasi = new WASI({
      version: "preview1",
      args: argv,
      env,
      preopens: { ".": "." },
      returnOnExit: true,
      stdin: 0,
    });
    // node:wasi's functions are wrapped in JavaScript ones: called
    // directly from a deep WebAssembly stack, node crashes. WASI's 32-bit
    // arguments are unsigned, which node 24 needs them to be (WebAssembly
    // passes them signed: an address beyond 2 GiB would fail).
    const direct = wasi.getImportObject().wasi_snapshot_preview1;
    const wrapped = {};
    for (const [name, f] of Object.entries(direct))
      wrapped[name] = (...a) => f(...a.map((x) => (typeof x === "number" && x < 0 ? x >>> 0 : x)));
    // proc_exit may be called from any fiber: it ends the run with an
    // exception that web/fibers.js passes on
    class Exit {
      constructor(code) {
        this.code = code;
      }
    }
    wrapped.proc_exit = (c) => {
      throw new Exit(c);
    };
    const instance = await WebAssembly.instantiate(module, { wasi_snapshot_preview1: wrapped });
    // node:wasi only needs the memory; _start is run by web/fibers.js
    wasi.initialize({ exports: { memory: instance.exports.memory } });
    const { fibers } = await import(new URL("../../web/fibers.js", import.meta.url));
    const start = await fibers(instance);
    code = 0;
    try {
      await start();
    } catch (e) {
      if (e instanceof RangeError) {
        // the engine's stack ran out, as web/wasi.js reports it
        writeSync(2, "fwp: trap: stack overflow\n");
        code = 101;
      } else if (e instanceof Exit) {
        code = e.code;
      } else {
        throw e;
      }
    }
  } else {
    const { MemFS, runWasi } = await import(new URL("../../web/wasi.js", import.meta.url));
    const files = {};
    const walk = async (dir) => {
      for (const name of await readdir(dir)) {
        if (name.startsWith(".") || name === "target") continue;
        const path = dir === "." ? name : `${dir}/${name}`;
        const st = await stat(path);
        if (st.isDirectory()) await walk(path);
        else if (st.size < 1 << 20) files[path] = new Uint8Array(await readFile(path));
      }
    };
    await walk(".");
    const r = await runWasi(module, {
      args: argv,
      env: env.FWP_SEED === undefined ? {} : { FWP_SEED: env.FWP_SEED },
      fs: new MemFS(files),
      stdin: new Uint8Array(stdin),
      stdout: (t) => writeSync(1, t),
      stderr: (t) => writeSync(2, t),
    });
    code = r.code;
    if (env.FWP_SHOW_FILE) {
      writeSync(1, `--- ${env.FWP_SHOW_FILE}\n${r.fs.readText(env.FWP_SHOW_FILE)}`);
    }
  }
  parentPort.postMessage(code);
}
