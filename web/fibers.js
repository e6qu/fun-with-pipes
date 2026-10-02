// Tasks for fwp programs compiled to WebAssembly, and for fwp.wasm (the
// WebAssembly build of fwp itself): each task runs on its own stack, and
// a task that waits (for a timer, a channel or another task) is suspended
// with JavaScript Promise Integration (JSPI). The scheduling decisions are
// made inside the module; this file only switches stacks:
//
//   const run = await fibers(instance);
//   await run(); // runs _start; rejects with what it threw
//
// The module exports
//   fwp_fiber_hooks() -> address of { u32 switch, u32 idle, u32 sp }: table
//                     slots of the hooks below, written here (0: no hooks)
//   fwp_fiber_stack(id) -> the initial stack pointer of a new fiber
//   fwp_fiber_entry(id) -> runs fiber `id`; returns the fiber to resume next
//   __stack_pointer, __indirect_function_table (growable)
// and calls, through the table,
//   switch(to) -> 0: suspend the calling fiber and resume (or start) `to`
//   idle(ms)   -> 0: suspend the whole program for `ms` milliseconds
//                    (every task is waiting for a timer)
//   sp()       -> the stack pointer
// Fiber 0 is the one that runs _start.
//
// A module without fwp_fiber_hooks (a program without tasks), or an engine
// without JSPI, runs _start directly; a module that then starts a task
// reports that tasks are unavailable. JSPI exists in two forms: the
// standard one (WebAssembly.Suspending and WebAssembly.promising: Chrome
// and Edge 137 and later, and other engines as they ship it) and an
// earlier one (WebAssembly.Function with an explicit suspender: node 22
// with --experimental-wasm-jspi). Both are supported.
//
// The hooks are installed into the module's function table rather than
// imported, so that the module needs no imports beyond WASI and still
// runs under other WASI runtimes (wasmtime), only without tasks. They are
// small WebAssembly functions (a module assembled below) that call the
// suspending JavaScript functions, and save and restore the module's stack
// pointer around a suspension: each fiber has its own region of linear
// memory for its stack.

const leb = (n) => {
  const out = [];
  do {
    let b = n & 0x7f;
    n >>>= 7;
    if (n) b |= 0x80;
    out.push(b);
  } while (n);
  return out;
};
const name = (s) => [...leb(s.length), ...new TextEncoder().encode(s)];
const vec = (items) => [...leb(items.length), ...items.flat()];
const section = (id, body) => [id, ...leb(body.length), ...body];
const [I32, F64, EXTERN] = [0x7f, 0x7c, 0x6f];
const functype = (params, results) => [0x60, ...vec(params.map((p) => [p])), ...vec(results.map((r) => [r]))];
const [LOCAL_GET, LOCAL_SET, GLOBAL_GET, GLOBAL_SET, CALL, I32_CONST, END] = [0x20, 0x21, 0x23, 0x24, 0x10, 0x41, 0x0b];

// The hook module. Imports: the suspending `switch` and `idle`, the
// program's _start and fwp_fiber_entry, and its stack pointer (global 0).
// Exports: switch, idle, sp (for the table), start and entry (to be made
// promising). With the earlier JSPI (`explicit`), the suspender is a
// first parameter: start and entry keep it in global 1, from which switch
// and idle pass it on, restoring it after they resume (another fiber may
// have run meanwhile).
function hookModule(explicit) {
  const S = explicit ? [EXTERN] : [];
  const SUSPENDER = 1;
  const types = [
    functype([...S, I32], [I32]), // 0: switch (imported)
    functype([...S, F64], [I32]), // 1: idle (imported)
    functype([], []), // 2: _start
    functype([I32], [I32]), // 3: fwp_fiber_entry, switch
    functype([F64], [I32]), // 4: idle
    functype([...S], [I32]), // 5: start
    functype([...S, I32, I32], [I32]), // 6: entry (id, stack pointer)
    functype([], [I32]), // 7: sp
  ];
  const imp = (field, kind, desc) => [...name("fwp"), ...name(field), kind, ...desc];
  const imports = [
    imp("switch", 0, leb(0)),
    imp("idle", 0, leb(1)),
    imp("start", 0, leb(2)),
    imp("entry", 0, leb(3)),
    imp("sp", 3, [I32, 1]),
  ];
  const body = (locals, code) => {
    const b = [...vec(locals), ...code, END];
    return [...leb(b.length), ...b];
  };
  // call an imported suspending function with the stack pointer (and the
  // suspender) saved in locals and restored afterwards
  const suspending = (fn) =>
    explicit
      ? body(
          [
            [1, I32],
            [1, EXTERN],
          ],
          [
            GLOBAL_GET, 0, LOCAL_SET, 1,
            GLOBAL_GET, SUSPENDER, LOCAL_SET, 2,
            LOCAL_GET, 2, LOCAL_GET, 0, CALL, fn,
            LOCAL_GET, 2, GLOBAL_SET, SUSPENDER,
            LOCAL_GET, 1, GLOBAL_SET, 0,
          ],
        )
      : body([[1, I32]], [GLOBAL_GET, 0, LOCAL_SET, 1, LOCAL_GET, 0, CALL, fn, LOCAL_GET, 1, GLOBAL_SET, 0]);
  const code = explicit
    ? [
        suspending(0),
        suspending(1),
        body([], [LOCAL_GET, 0, GLOBAL_SET, SUSPENDER, CALL, 2, I32_CONST, 0]),
        body([], [LOCAL_GET, 0, GLOBAL_SET, SUSPENDER, LOCAL_GET, 2, GLOBAL_SET, 0, LOCAL_GET, 1, CALL, 3]),
      ]
    : [
        suspending(0),
        suspending(1),
        body([], [CALL, 2, I32_CONST, 0]),
        body([], [LOCAL_GET, 1, GLOBAL_SET, 0, LOCAL_GET, 0, CALL, 3]),
      ];
  const exp = (field, i) => [...name(field), 0, ...leb(i)];
  return new Uint8Array([
    0, 0x61, 0x73, 0x6d, 1, 0, 0, 0,
    ...section(1, vec(types)),
    ...section(2, vec(imports)),
    ...section(3, vec([3, 4, 5, 6, 7].map(leb))),
    ...(explicit ? section(6, vec([[EXTERN, 1, 0xd0, EXTERN, END]])) : []),
    ...section(7, vec([exp("switch", 4), exp("idle", 5), exp("start", 6), exp("entry", 7), exp("sp", 8)])),
    ...section(10, vec([...code, body([], [GLOBAL_GET, 0])])),
  ]);
}

// Which JSPI the engine provides: "standard", "explicit" or null.
export function jspi() {
  const W = globalThis.WebAssembly;
  if (typeof W.Suspending === "function" && typeof W.promising === "function") return "standard";
  if (typeof W.Suspender === "function" && typeof W.Function === "function") return "explicit";
  return null;
}

// Prepare `instance` (a WASI command whose memory the WASI layer already
// knows) and return a function that runs its _start, resolving when it
// returns and rejecting with what it throws (proc_exit's exception, a
// trap), in whichever fiber that happens.
export async function fibers(instance) {
  const ex = instance.exports;
  const kind = jspi();
  const direct = async () => {
    ex._start();
  };
  if (!kind || !ex.fwp_fiber_hooks || !ex.__indirect_function_table || !ex.__stack_pointer) return direct;
  const explicit = kind === "explicit";

  let current = 0;
  const suspended = new Map(); // fiber -> resolves its pending switch
  let settled = false;
  let finish;
  const done = new Promise((resolve, reject) => {
    finish = {
      resolve: () => {
        settled = true;
        suspended.clear();
        resolve();
      },
      reject: (e) => {
        settled = true;
        suspended.clear();
        reject(e);
      },
    };
  });
  let entry;
  const resume = (to) => {
    if (settled) return;
    current = to;
    const wake = suspended.get(to);
    if (wake) {
      suspended.delete(to);
      wake(0);
    } else {
      entry(to, ex.fwp_fiber_stack(to)).then(resume, finish.reject);
    }
  };
  // Runs while the calling fiber is still on the stack: the switch happens
  // once it has suspended.
  const switchTo = (to) =>
    new Promise((wake) => {
      suspended.set(current, wake);
      queueMicrotask(() => resume(to));
    });
  // (setTimeout fires at once for delays beyond 2^31 - 1 ms; the module
  // waits again when it wakes early)
  const idle = (ms) => new Promise((wake) => setTimeout(() => wake(0), Math.min(Math.max(0, ms), 2 ** 31 - 1)));

  const suspendingFn = (f, param) =>
    explicit
      ? new WebAssembly.Function({ parameters: ["externref", param], results: ["i32"] }, f, { suspending: "first" })
      : new WebAssembly.Suspending(f);
  const promisingFn = (f, params) =>
    explicit
      ? new WebAssembly.Function({ parameters: params, results: ["externref"] }, f, { promising: "first" })
      : WebAssembly.promising(f);
  const { instance: hooks } = await WebAssembly.instantiate(hookModule(explicit), {
    fwp: {
      switch: suspendingFn(switchTo, "i32"),
      idle: suspendingFn(idle, "f64"),
      start: ex._start,
      entry: ex.fwp_fiber_entry,
      sp: ex.__stack_pointer,
    },
  });
  const start = promisingFn(hooks.exports.start, []);
  entry = promisingFn(hooks.exports.entry, ["i32", "i32"]);
  const table = ex.__indirect_function_table;
  const slot = table.grow(3);
  table.set(slot, hooks.exports.switch);
  table.set(slot + 1, hooks.exports.idle);
  table.set(slot + 2, hooks.exports.sp);
  const at = ex.fwp_fiber_hooks();
  const view = new DataView(ex.memory.buffer);
  view.setUint32(at, slot, true);
  view.setUint32(at + 4, slot + 1, true);
  view.setUint32(at + 8, slot + 2, true);
  return () => {
    start().then(finish.resolve, finish.reject);
    return done;
  };
}
