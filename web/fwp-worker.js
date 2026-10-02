// Runs fwp.wasm off the page's thread, so a long program does not freeze
// the page. Messages in: { id, args, files, stdin }, where files maps
// paths to text. Messages out: { id, fd, text } for each piece of output,
// then { id, code, files } when fwp exits (files: the file system after
// the run, as text). On start it posts { ready: true } once fwp.wasm is
// compiled, or { ready: false, error }.
import { MemFS, runWasi } from "./wasi.js";

const module = (async () => {
  const res = await fetch(new URL("./fwp.wasm", import.meta.url));
  if (!res.ok) {
    throw new Error(`cannot load fwp.wasm (${res.status}): build it with scripts/build-playground.sh`);
  }
  return WebAssembly.compile(await res.arrayBuffer());
})();
module.then(
  () => self.postMessage({ ready: true }),
  (e) => self.postMessage({ ready: false, error: String(e.message || e) }),
);

self.onmessage = async ({ data: { id, args, files, stdin } }) => {
  try {
    const fs = new MemFS(files);
    const { code } = await runWasi(await module, {
      args: ["fwp", ...args],
      fs,
      stdin,
      stdout: (text) => self.postMessage({ id, fd: 1, text }),
      stderr: (text) => self.postMessage({ id, fd: 2, text }),
    });
    const decoder = new TextDecoder();
    const out = {};
    for (const [path, data] of Object.entries(fs.files())) out[path] = decoder.decode(data);
    self.postMessage({ id, code, files: out });
  } catch (e) {
    self.postMessage({ id, fd: 2, text: `${e}\n` });
    self.postMessage({ id, code: -1, files });
  }
};
