// Loader for an fwp program compiled with `fwp build --target wasm32-browser`.
// It provides the small part of WASI that fwp programs use: standard
// streams, arguments, environment, clocks and random numbers. Files and
// sockets are not available. Tasks run where the engine has JavaScript
// Promise Integration (JSPI: Chrome and Edge 137 and later); the fiber
// switching that this needs (web/fibers.js) is appended to this file.
//
//   <script type="module">
//     import { run } from "./program.js";
//     const code = await run({ stdout: line => console.log(line) });
//   </script>
//
// Options: stdout/stderr (called once per line), args, env (an object),
// stdin (a string), bytes (the module, instead of fetching it). Resolves to
// the exit code.

const WASM = "__FWP_WASM__";

class Exit {
  constructor(code) {
    this.code = code;
  }
}

export async function run(opts = {}) {
  const sinks = {
    1: opts.stdout || ((line) => console.log(line)),
    2: opts.stderr || ((line) => console.error(line)),
  };
  const args = [WASM, ...(opts.args || [])];
  const env = Object.entries(opts.env || {}).map(([k, v]) => `${k}=${v}`);
  const stdin = new TextEncoder().encode(opts.stdin || "");
  let stdinPos = 0;
  let bytes = opts.bytes;
  if (!bytes) {
    const res = await fetch(new URL(WASM, import.meta.url));
    bytes = await res.arrayBuffer();
  }

  let memory;
  const pending = { 1: [], 2: [] };
  const decoder = new TextDecoder();
  const emit = (fd, final) => {
    const buf = pending[fd];
    let start = 0;
    for (let i = 0; i < buf.length; i++) {
      if (buf[i] === 10) {
        sinks[fd](decoder.decode(new Uint8Array(buf.slice(start, i))));
        start = i + 1;
      }
    }
    pending[fd] = buf.slice(start);
    if (final && pending[fd].length) {
      sinks[fd](decoder.decode(new Uint8Array(pending[fd])));
      pending[fd] = [];
    }
  };
  const view = () => new DataView(memory.buffer);
  const u8 = () => new Uint8Array(memory.buffer);
  const putStrings = (list, ptrs, buf) => {
    const v = view();
    const enc = new TextEncoder();
    for (const s of list) {
      v.setUint32(ptrs, buf, true);
      ptrs += 4;
      const b = enc.encode(s + "\0");
      u8().set(b, buf);
      buf += b.length;
    }
    return 0;
  };
  const sizes = (list, countPtr, sizePtr) => {
    const enc = new TextEncoder();
    view().setUint32(countPtr, list.length, true);
    view().setUint32(sizePtr, list.reduce((n, s) => n + enc.encode(s).length + 1, 0), true);
    return 0;
  };

  const ENOSYS = 52;
  const EBADF = 8;
  const impl = {
    args_sizes_get: (c, s) => sizes(args, c, s),
    args_get: (p, b) => putStrings(args, p, b),
    environ_sizes_get: (c, s) => sizes(env, c, s),
    environ_get: (p, b) => putStrings(env, p, b),
    fd_write(fd, iovs, n, written) {
      if (fd !== 1 && fd !== 2) return EBADF;
      const v = view();
      let total = 0;
      for (let i = 0; i < n; i++) {
        const p = v.getUint32(iovs + 8 * i, true);
        const len = v.getUint32(iovs + 8 * i + 4, true);
        for (const b of u8().subarray(p, p + len)) pending[fd].push(b);
        total += len;
      }
      emit(fd, false);
      v.setUint32(written, total, true);
      return 0;
    },
    fd_read(fd, iovs, n, read) {
      if (fd !== 0) return EBADF;
      const v = view();
      let total = 0;
      for (let i = 0; i < n && stdinPos < stdin.length; i++) {
        const p = v.getUint32(iovs + 8 * i, true);
        const len = v.getUint32(iovs + 8 * i + 4, true);
        const chunk = stdin.subarray(stdinPos, stdinPos + len);
        u8().set(chunk, p);
        stdinPos += chunk.length;
        total += chunk.length;
      }
      v.setUint32(read, total, true);
      return 0;
    },
    fd_fdstat_get(fd, p) {
      if (fd > 2) return EBADF;
      const v = view();
      v.setUint8(p, 2); // character device
      v.setUint16(p + 2, 0, true);
      v.setBigUint64(p + 8, 0xffffffffn, true);
      v.setBigUint64(p + 16, 0xffffffffn, true);
      return 0;
    },
    fd_prestat_get: () => EBADF,
    fd_close: () => 0,
    fd_seek: () => 70,
    clock_time_get(id, _precision, p) {
      const ns = id === 0 ? BigInt(Date.now()) * 1000000n : BigInt(Math.round(performance.now() * 1e6));
      view().setBigUint64(p, ns, true);
      return 0;
    },
    random_get(p, len) {
      crypto.getRandomValues(u8().subarray(p, p + len));
      return 0;
    },
    proc_exit(code) {
      throw new Exit(code);
    },
  };
  // pointers and sizes are unsigned (memory may grow beyond 2 GiB, where
  // i32 arguments arrive negative)
  const unsigned = (f) => (...args) => f(...args.map((a) => (typeof a === "number" && a < 0 ? a >>> 0 : a)));
  const wasi = new Proxy(impl, {
    get: (t, k) => (t[k] ? (k === "proc_exit" ? t[k] : unsigned(t[k])) : () => ENOSYS),
  });

  const { instance } = await WebAssembly.instantiate(bytes, { wasi_snapshot_preview1: wasi });
  memory = instance.exports.memory;
  const start = await fibers(instance);
  let code = 0;
  try {
    await start();
  } catch (e) {
    if (e instanceof RangeError) {
      // the engine's stack ran out: a trap, as in native programs
      instance.exports.fwp_fiber_flush?.();
      emit(1, true);
      sinks[2]("fwp: trap: stack overflow");
      code = 101;
    } else if (e instanceof Exit) {
      code = e.code;
    } else {
      throw e;
    }
  }
  emit(1, true);
  emit(2, true);
  return code;
}
