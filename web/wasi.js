// A small WASI (preview 1) for running fwp.wasm, the WebAssembly build of
// the fwp compiler and interpreter, in a browser or under node. It provides
// what fwp uses: arguments, environment, clocks, random numbers, standard
// streams and an in-memory file system, preopened as "." and "/". Sockets
// and processes do not exist; their calls return ENOSYS.
//
//   import { MemFS, runWasi } from "./wasi.js";
//   const fs = new MemFS({ "main.fwp": "main = print \"hi\"\n" });
//   const { code } = await runWasi(module, {
//     args: ["fwp", "run", "main.fwp"],
//     fs,
//     stdin: "",
//     stdout: (text) => ..., stderr: (text) => ...,
//   });
//
// `module` is a WebAssembly.Module (or bytes). Each run instantiates it
// afresh. A run that exhausts the engine's stack reports
// `fwp: trap: stack overflow` and exit code 101, as fwp does.

const E = {
  SUCCESS: 0,
  BADF: 8,
  EXIST: 20,
  INVAL: 28,
  ISDIR: 31,
  NOENT: 44,
  NOSYS: 52,
  NOTDIR: 54,
  NOTEMPTY: 55,
  SPIPE: 70,
};

const FILETYPE = { CHAR: 2, DIR: 3, FILE: 4 };
const OFLAGS = { CREAT: 1, DIRECTORY: 2, EXCL: 4, TRUNC: 8 };
const FDFLAGS_APPEND = 1;

const encoder = new TextEncoder();

function bytesOf(x) {
  if (x instanceof Uint8Array) return x;
  if (x instanceof ArrayBuffer) return new Uint8Array(x);
  return encoder.encode(String(x ?? ""));
}

let nextIno = 1n;

class FileNode {
  constructor(data) {
    this.data = bytesOf(data);
    this.ino = nextIno++;
    this.mtime = BigInt(Date.now()) * 1000000n;
  }
  get size() {
    return this.data.length;
  }
}

class DirNode {
  constructor() {
    this.entries = new Map();
    this.ino = nextIno++;
    this.mtime = BigInt(Date.now()) * 1000000n;
  }
}

// An in-memory file system: `new MemFS({ "dir/a.fwp": "text" })`.
export class MemFS {
  constructor(files = {}) {
    this.root = new DirNode();
    for (const [path, data] of Object.entries(files)) this.writeFile(path, data);
  }

  // The parts of a path, with "." and ".." resolved below the root.
  static parts(path) {
    const out = [];
    for (const p of String(path).split("/")) {
      if (p === "" || p === ".") continue;
      if (p === "..") out.pop();
      else out.push(p);
    }
    return out;
  }

  lookup(path, from = this.root) {
    let node = from;
    for (const p of MemFS.parts(path)) {
      if (!(node instanceof DirNode)) return null;
      node = node.entries.get(p);
      if (!node) return null;
    }
    return node;
  }

  mkdirs(parts, from = this.root) {
    let node = from;
    for (const p of parts) {
      let next = node.entries.get(p);
      if (!next) {
        next = new DirNode();
        node.entries.set(p, next);
      }
      if (!(next instanceof DirNode)) throw new Error(`not a directory: ${p}`);
      node = next;
    }
    return node;
  }

  writeFile(path, data) {
    const parts = MemFS.parts(path);
    const name = parts.pop();
    const dir = this.mkdirs(parts);
    dir.entries.set(name, new FileNode(data));
  }

  readFile(path) {
    const node = this.lookup(path);
    return node instanceof FileNode ? node.data : null;
  }

  readText(path) {
    const data = this.readFile(path);
    return data === null ? null : new TextDecoder().decode(data);
  }

  // Every file, as { path: Uint8Array }.
  files() {
    const out = {};
    const walk = (dir, prefix) => {
      for (const [name, node] of dir.entries) {
        if (node instanceof DirNode) walk(node, prefix + name + "/");
        else out[prefix + name] = node.data;
      }
    };
    walk(this.root, "");
    return out;
  }
}

class Exit {
  constructor(code) {
    this.code = code;
  }
}

// An open file description.
class Handle {
  constructor(node, { append = false, preopen = null } = {}) {
    this.node = node;
    this.pos = 0;
    this.append = append;
    this.preopen = preopen;
  }
}

// Run `module` (a WebAssembly.Module, or the bytes of one) to completion.
// Resolves to { code, fs }.
export async function runWasi(module, opts = {}) {
  if (!(module instanceof WebAssembly.Module)) module = await WebAssembly.compile(module);
  const args = opts.args || ["fwp"];
  const env = Object.entries(opts.env || {}).map(([k, v]) => `${k}=${v}`);
  const fs = opts.fs || new MemFS();
  const stdin = bytesOf(opts.stdin);
  let stdinPos = 0;
  const decoders = { 1: new TextDecoder(), 2: new TextDecoder() };
  const sinks = {
    1: opts.stdout || ((t) => globalThis.process?.stdout.write(t)),
    2: opts.stderr || ((t) => globalThis.process?.stderr.write(t)),
  };
  const output = (fd, bytes) => {
    const text = decoders[fd].decode(bytes, { stream: true });
    if (text) sinks[fd](text);
  };

  const fds = new Map([
    [3, new Handle(fs.root, { preopen: "." })],
    [4, new Handle(fs.root, { preopen: "/" })],
  ]);
  let nextFd = 5;

  let memory;
  const view = () => new DataView(memory.buffer);
  const u8 = () => new Uint8Array(memory.buffer);
  const str = (ptr, len) => new TextDecoder().decode(u8().subarray(ptr, ptr + len));
  const iovecs = (iovs, n) => {
    const v = view();
    const out = [];
    for (let i = 0; i < n; i++) {
      out.push([v.getUint32(iovs + 8 * i, true), v.getUint32(iovs + 8 * i + 4, true)]);
    }
    return out;
  };
  const putStrings = (list, ptrs, buf) => {
    for (const s of list) {
      view().setUint32(ptrs, buf, true);
      ptrs += 4;
      const b = encoder.encode(s + "\0");
      u8().set(b, buf);
      buf += b.length;
    }
    return E.SUCCESS;
  };
  const sizes = (list, countPtr, sizePtr) => {
    view().setUint32(countPtr, list.length, true);
    const total = list.reduce((n, s) => n + encoder.encode(s).length + 1, 0);
    view().setUint32(sizePtr, total, true);
    return E.SUCCESS;
  };
  const dirOf = (fd) => {
    const h = fds.get(fd);
    if (!h) return [null, E.BADF];
    if (!(h.node instanceof DirNode)) return [null, E.NOTDIR];
    return [h.node, E.SUCCESS];
  };
  // The directory and final name of `path` below directory `fd`.
  const parentOf = (fd, ptr, len) => {
    const [dir, err] = dirOf(fd);
    if (err) return [null, null, err];
    const parts = MemFS.parts(str(ptr, len));
    const name = parts.pop();
    const parent = fs.lookup(parts.join("/"), dir);
    if (!parent) return [null, null, E.NOENT];
    if (!(parent instanceof DirNode)) return [null, null, E.NOTDIR];
    return [parent, name, E.SUCCESS];
  };
  const filestat = (node, ptr) => {
    const v = view();
    const dir = node instanceof DirNode;
    v.setBigUint64(ptr, 0n, true);
    v.setBigUint64(ptr + 8, node.ino, true);
    v.setUint8(ptr + 16, dir ? FILETYPE.DIR : FILETYPE.FILE);
    v.setBigUint64(ptr + 24, 1n, true);
    v.setBigUint64(ptr + 32, BigInt(dir ? 0 : node.size), true);
    v.setBigUint64(ptr + 40, node.mtime, true);
    v.setBigUint64(ptr + 48, node.mtime, true);
    v.setBigUint64(ptr + 56, node.mtime, true);
    return E.SUCCESS;
  };
  const now = (id) =>
    id === 0
      ? BigInt(Date.now()) * 1000000n
      : BigInt(Math.round(performance.now() * 1e6));

  const wasi = {
    args_sizes_get: (c, s) => sizes(args, c, s),
    args_get: (p, b) => putStrings(args, p, b),
    environ_sizes_get: (c, s) => sizes(env, c, s),
    environ_get: (p, b) => putStrings(env, p, b),

    clock_res_get(_id, p) {
      view().setBigUint64(p, 1000n, true);
      return E.SUCCESS;
    },
    clock_time_get(id, _precision, p) {
      view().setBigUint64(p, now(id), true);
      return E.SUCCESS;
    },
    random_get(p, len) {
      for (let off = 0; off < len; off += 65536) {
        crypto.getRandomValues(u8().subarray(p + off, p + Math.min(len, off + 65536)));
      }
      return E.SUCCESS;
    },
    proc_exit(code) {
      throw new Exit(code);
    },
    sched_yield: () => E.SUCCESS,

    fd_write(fd, iovs, n, written) {
      let total = 0;
      const h = fds.get(fd);
      if (fd !== 1 && fd !== 2 && !(h && h.node instanceof FileNode)) return E.BADF;
      for (const [p, len] of iovecs(iovs, n)) {
        const bytes = u8().slice(p, p + len);
        if (fd === 1 || fd === 2) {
          output(fd, bytes);
        } else {
          const node = h.node;
          if (h.append) h.pos = node.data.length;
          const end = h.pos + bytes.length;
          if (end > node.data.length) {
            const grown = new Uint8Array(end);
            grown.set(node.data);
            node.data = grown;
          }
          node.data.set(bytes, h.pos);
          h.pos = end;
          node.mtime = now(0);
        }
        total += len;
      }
      view().setUint32(written, total, true);
      return E.SUCCESS;
    },
    fd_read(fd, iovs, n, read) {
      let total = 0;
      if (fd === 0) {
        for (const [p, len] of iovecs(iovs, n)) {
          const chunk = stdin.subarray(stdinPos, stdinPos + len);
          u8().set(chunk, p);
          stdinPos += chunk.length;
          total += chunk.length;
          if (chunk.length < len) break;
        }
      } else {
        const h = fds.get(fd);
        if (!h) return E.BADF;
        if (!(h.node instanceof FileNode)) return E.ISDIR;
        for (const [p, len] of iovecs(iovs, n)) {
          const chunk = h.node.data.subarray(h.pos, h.pos + len);
          u8().set(chunk, p);
          h.pos += chunk.length;
          total += chunk.length;
          if (chunk.length < len) break;
        }
      }
      view().setUint32(read, total, true);
      return E.SUCCESS;
    },
    fd_seek(fd, offset, whence, out) {
      const h = fds.get(fd);
      if (fd <= 2) return E.SPIPE;
      if (!h || !(h.node instanceof FileNode)) return E.BADF;
      const base = [0, h.pos, h.node.data.length][whence];
      if (base === undefined) return E.INVAL;
      const pos = base + Number(offset);
      if (pos < 0) return E.INVAL;
      h.pos = pos;
      view().setBigUint64(out, BigInt(pos), true);
      return E.SUCCESS;
    },
    fd_tell(fd, out) {
      const h = fds.get(fd);
      if (!h) return fd <= 2 ? E.SPIPE : E.BADF;
      view().setBigUint64(out, BigInt(h.pos), true);
      return E.SUCCESS;
    },
    fd_close(fd) {
      if (fd <= 2) return E.SUCCESS;
      if (!fds.has(fd) || fds.get(fd).preopen) return E.BADF;
      fds.delete(fd);
      return E.SUCCESS;
    },
    fd_sync: () => E.SUCCESS,
    fd_datasync: () => E.SUCCESS,
    fd_advise: () => E.SUCCESS,
    fd_fdstat_set_flags: () => E.SUCCESS,
    fd_fdstat_get(fd, p) {
      const v = view();
      let type;
      if (fd <= 2) type = FILETYPE.CHAR;
      else if (fds.has(fd)) type = fds.get(fd).node instanceof DirNode ? FILETYPE.DIR : FILETYPE.FILE;
      else return E.BADF;
      v.setUint8(p, type);
      v.setUint16(p + 2, fds.get(fd)?.append ? FDFLAGS_APPEND : 0, true);
      v.setBigUint64(p + 8, 0xffffffffffffffffn, true);
      v.setBigUint64(p + 16, 0xffffffffffffffffn, true);
      return E.SUCCESS;
    },
    fd_filestat_get(fd, p) {
      if (fd <= 2) {
        u8().fill(0, p, p + 64);
        view().setUint8(p + 16, FILETYPE.CHAR);
        return E.SUCCESS;
      }
      const h = fds.get(fd);
      if (!h) return E.BADF;
      return filestat(h.node, p);
    },
    fd_filestat_set_size(fd, size) {
      const h = fds.get(fd);
      if (!h || !(h.node instanceof FileNode)) return E.BADF;
      const data = new Uint8Array(Number(size));
      data.set(h.node.data.subarray(0, data.length));
      h.node.data = data;
      return E.SUCCESS;
    },
    fd_prestat_get(fd, p) {
      const h = fds.get(fd);
      if (!h || !h.preopen) return E.BADF;
      view().setUint8(p, 0);
      view().setUint32(p + 4, encoder.encode(h.preopen).length, true);
      return E.SUCCESS;
    },
    fd_prestat_dir_name(fd, p, len) {
      const h = fds.get(fd);
      if (!h || !h.preopen) return E.BADF;
      u8().set(encoder.encode(h.preopen).subarray(0, len), p);
      return E.SUCCESS;
    },
    fd_readdir(fd, buf, len, cookie, used) {
      const [dir, err] = dirOf(fd);
      if (err) return err;
      const entries = [...dir.entries];
      let off = 0;
      for (let i = Number(cookie); i < entries.length && off < len; i++) {
        const [name, node] = entries[i];
        const nameBytes = encoder.encode(name);
        const ent = new Uint8Array(24 + nameBytes.length);
        const dv = new DataView(ent.buffer);
        dv.setBigUint64(0, BigInt(i + 1), true);
        dv.setBigUint64(8, node.ino, true);
        dv.setUint32(16, nameBytes.length, true);
        dv.setUint8(20, node instanceof DirNode ? FILETYPE.DIR : FILETYPE.FILE);
        ent.set(nameBytes, 24);
        const n = Math.min(ent.length, len - off);
        u8().set(ent.subarray(0, n), buf + off);
        off += n;
      }
      view().setUint32(used, off, true);
      return E.SUCCESS;
    },

    path_open(fd, _dirflags, ptr, len, oflags, _rights, _inheriting, fdflags, out) {
      const [parent, name, err] = parentOf(fd, ptr, len);
      if (err) return err;
      let node = name === undefined ? parent : parent.entries.get(name);
      if (node && oflags & OFLAGS.CREAT && oflags & OFLAGS.EXCL) return E.EXIST;
      if (!node) {
        if (!(oflags & OFLAGS.CREAT)) return E.NOENT;
        node = new FileNode(new Uint8Array(0));
        parent.entries.set(name, node);
      }
      if (oflags & OFLAGS.DIRECTORY && !(node instanceof DirNode)) return E.NOTDIR;
      if (oflags & OFLAGS.TRUNC) {
        if (node instanceof DirNode) return E.ISDIR;
        node.data = new Uint8Array(0);
      }
      const h = new Handle(node, { append: (fdflags & FDFLAGS_APPEND) !== 0 });
      const n = nextFd++;
      fds.set(n, h);
      view().setUint32(out, n, true);
      return E.SUCCESS;
    },
    path_filestat_get(fd, _flags, ptr, len, out) {
      const [dir, err] = dirOf(fd);
      if (err) return err;
      const node = fs.lookup(str(ptr, len), dir);
      if (!node) return E.NOENT;
      return filestat(node, out);
    },
    path_create_directory(fd, ptr, len) {
      const [parent, name, err] = parentOf(fd, ptr, len);
      if (err) return err;
      if (parent.entries.has(name)) return E.EXIST;
      parent.entries.set(name, new DirNode());
      return E.SUCCESS;
    },
    path_unlink_file(fd, ptr, len) {
      const [parent, name, err] = parentOf(fd, ptr, len);
      if (err) return err;
      const node = parent.entries.get(name);
      if (!node) return E.NOENT;
      if (node instanceof DirNode) return E.ISDIR;
      parent.entries.delete(name);
      return E.SUCCESS;
    },
    path_remove_directory(fd, ptr, len) {
      const [parent, name, err] = parentOf(fd, ptr, len);
      if (err) return err;
      const node = parent.entries.get(name);
      if (!node) return E.NOENT;
      if (!(node instanceof DirNode)) return E.NOTDIR;
      if (node.entries.size) return E.NOTEMPTY;
      parent.entries.delete(name);
      return E.SUCCESS;
    },
    path_rename(fd, ptr, len, fd2, ptr2, len2) {
      const [from, name, err] = parentOf(fd, ptr, len);
      if (err) return err;
      const [to, name2, err2] = parentOf(fd2, ptr2, len2);
      if (err2) return err2;
      const node = from.entries.get(name);
      if (!node) return E.NOENT;
      from.entries.delete(name);
      to.entries.set(name2, node);
      return E.SUCCESS;
    },

    // Only clock subscriptions (sleeps) are meaningful here: wait them out.
    poll_oneoff(inPtr, outPtr, n, nevents) {
      const v = view();
      let wait = 0n;
      for (let i = 0; i < n; i++) {
        const s = inPtr + 48 * i;
        if (v.getUint8(s + 8) === 0) {
          const timeout = v.getBigUint64(s + 24, true);
          const abs = (v.getUint16(s + 40, true) & 1) !== 0;
          const rel = abs ? timeout - now(v.getUint32(s + 16, true)) : timeout;
          if (rel > wait) wait = rel;
        }
      }
      const until = performance.now() + Number(wait) / 1e6;
      while (performance.now() < until) {
        // busy wait: a worker has no other way to block
      }
      for (let i = 0; i < n; i++) {
        const s = inPtr + 48 * i;
        const e = outPtr + 32 * i;
        v.setBigUint64(e, v.getBigUint64(s, true), true);
        v.setUint16(e + 8, 0, true);
        v.setUint8(e + 10, v.getUint8(s + 8));
      }
      v.setUint32(nevents, n, true);
      return E.SUCCESS;
    },
  };

  // Anything else (sockets, links, signals) is not supported.
  const imports = {};
  for (const { module: m, name } of WebAssembly.Module.imports(module)) {
    imports[m] ??= {};
    imports[m][name] = wasi[name] || (() => E.NOSYS);
  }

  const instance = await WebAssembly.instantiate(module, imports);
  memory = instance.exports.memory;
  let code = 0;
  try {
    instance.exports._start();
  } catch (e) {
    if (e instanceof Exit) {
      code = e.code;
    } else if (e instanceof RangeError) {
      // the engine's stack, not fwp's own, ran out
      sinks[2]("fwp: trap: stack overflow\n");
      code = 101;
    } else if (e instanceof WebAssembly.RuntimeError) {
      sinks[2](`fwp: aborted (${e.message})\n`);
      code = 134;
    } else {
      throw e;
    }
  }
  for (const fd of [1, 2]) {
    const rest = decoders[fd].decode();
    if (rest) sinks[fd](rest);
  }
  return { code, fs };
}
