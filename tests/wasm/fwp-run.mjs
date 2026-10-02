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
// file system after the run. The module runs in a worker with a large stack, since
// deep recursion uses the engine's stack.
import { readFile, readdir, stat } from "node:fs/promises";
import { WASI } from "node:wasi";
import { Worker, isMainThread, parentPort, workerData } from "node:worker_threads";
import { readFileSync, writeSync } from "node:fs";
import process from "node:process";

if (isMainThread) {
  const [mode, wasm, ...args] = process.argv.slice(2);
  const worker = new Worker(new URL(import.meta.url), {
    workerData: { mode, wasm, args, env: process.env, stdin: mode === "shim" ? readFileSync(0) : null },
    resourceLimits: { stackSizeMb: Number(process.env.FWP_STACK_MB || 512) },
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
    // directly from a deep WebAssembly stack, node 22 crashes.
    const direct = wasi.getImportObject().wasi_snapshot_preview1;
    const wrapped = {};
    for (const [name, f] of Object.entries(direct)) wrapped[name] = (...a) => f(...a);
    const instance = await WebAssembly.instantiate(module, { wasi_snapshot_preview1: wrapped });
    code = wasi.start(instance);
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
