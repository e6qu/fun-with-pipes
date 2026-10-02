// The playground page: an editor for main.fwp, and buttons that run the
// fwp compiler and interpreter (fwp.wasm, in a worker) on it.

const $ = (id) => document.getElementById(id);
const source = $("source");
const stdin = $("stdin");
const output = $("output");
const status = $("status");
const examples = $("examples");
const buttons = ["run", "check", "format", "test"].map($);

const HELLO = `# Edit the program and press Run (Ctrl+Enter).
greet = format "hello, {}!" | print

main = ["world", "fwp"] | each greet
`;

let worker;
let running = false;
let nextId = 1;
const pending = new Map();

// fwp runs in a worker, so that the page stays responsive and a program
// that does not stop can be stopped (by replacing the worker).
function startWorker() {
  worker = new Worker(new URL("./fwp-worker.js", import.meta.url), { type: "module" });
  worker.onmessage = ({ data }) => {
    if ("ready" in data) {
      if (!data.ready) status.textContent = data.error;
      else if (status.textContent.startsWith("loading")) status.textContent = "ready";
      buttons.forEach((b) => (b.disabled = !data.ready || running));
      return;
    }
    const job = pending.get(data.id);
    if (!job) return;
    if ("text" in data) {
      job.onOutput(data.fd, data.text);
    } else {
      pending.delete(data.id);
      job.resolve(data);
    }
  };
}

$("stop").onclick = () => {
  worker.terminate();
  for (const job of pending.values()) job.resolve({ code: "stopped", files: {} });
  pending.clear();
  startWorker();
};

// Run fwp with `args`; output goes to `onOutput(fd, text)`.
function fwp(args, { files = {}, input = "", onOutput = () => {} } = {}) {
  const id = nextId++;
  return new Promise((resolve) => {
    pending.set(id, { resolve, onOutput });
    worker.postMessage({ id, args, files, stdin: input });
  });
}

function clear() {
  output.textContent = "";
}

function show(text, cls) {
  const span = document.createElement("span");
  if (cls) span.className = cls;
  span.textContent = text;
  output.append(span);
  output.scrollTop = output.scrollHeight;
}

const toOutput = (fd, text) => show(text, fd === 2 ? "err" : null);

async function busy(label, f) {
  running = true;
  buttons.forEach((b) => (b.disabled = true));
  $("stop").disabled = false;
  status.textContent = `${label}…`;
  const start = performance.now();
  try {
    const code = await f();
    const ms = Math.round(performance.now() - start);
    status.textContent = code === "stopped" ? `${label}: stopped` : `${label}: exit ${code} · ${ms} ms`;
  } finally {
    running = false;
    buttons.forEach((b) => (b.disabled = false));
    $("stop").disabled = true;
  }
}

function files() {
  return { "main.fwp": source.value };
}

$("run").onclick = () =>
  busy("run", async () => {
    clear();
    const r = await fwp(["run", "main.fwp"], { files: files(), input: stdin.value, onOutput: toOutput });
    if (r.code !== 0) show(r.code === "stopped" ? "stopped\n" : `exit ${r.code}\n`, "note");
    return r.code;
  });

$("check").onclick = () =>
  busy("check", async () => {
    clear();
    const r = await fwp(["check", "main.fwp"], { files: files(), onOutput: toOutput });
    if (r.code === 0) show("no errors\n", "note");
    return r.code;
  });

$("test").onclick = () =>
  busy("test", async () => {
    clear();
    const r = await fwp(["test", "main.fwp"], { files: files(), onOutput: toOutput });
    return r.code;
  });

// `fwp fmt -` formats standard input to standard output.
$("format").onclick = () =>
  busy("format", async () => {
    let formatted = "";
    let errors = "";
    const r = await fwp(["fmt", "-"], {
      input: source.value,
      onOutput: (fd, text) => (fd === 1 ? (formatted += text) : (errors += text)),
    });
    if (r.code === "stopped") return r.code;
    if (r.code === 0) {
      if (formatted !== source.value) {
        source.value = formatted;
        save();
      }
    } else {
      clear();
      show(errors, "err");
    }
    return r.code;
  });

// Ctrl+Enter runs; Tab indents with four spaces.
source.addEventListener("keydown", (e) => {
  if (e.key === "Enter" && (e.ctrlKey || e.metaKey)) {
    e.preventDefault();
    if (!buttons[0].disabled) $("run").click();
  } else if (e.key === "Tab" && !e.shiftKey) {
    e.preventDefault();
    document.execCommand("insertText", false, "    ") ||
      source.setRangeText("    ", source.selectionStart, source.selectionEnd, "end");
  }
});

// The editor's contents survive a reload (in this browser only).
function save() {
  try {
    localStorage.setItem("fwp-playground-source", source.value);
    localStorage.setItem("fwp-playground-stdin", stdin.value);
  } catch {
    // storage unavailable: nothing to remember
  }
}
source.addEventListener("input", save);
stdin.addEventListener("input", save);

async function fetchText(path) {
  try {
    const res = await fetch(path);
    return res.ok ? await res.text() : null;
  } catch {
    return null;
  }
}

// Examples (web/examples/, made by scripts/build-playground.sh). A
// tutorial is titled by its first line ("# 10. WebAssembly").
async function loadExamples() {
  const index = await fetchText("examples/index.txt");
  const entries = (index || "")
    .split("\n")
    .filter(Boolean)
    .map((line) => line.split(" "));
  const inputs = new Map(entries);
  examples.append(new Option("Examples…", ""));
  examples.append(new Option("hello (built in)", "#hello"));
  for (const [name] of entries) examples.append(new Option(name, name));
  examples.onchange = async () => {
    const name = examples.value;
    if (!name) return;
    if (name === "#hello") {
      source.value = HELLO;
      stdin.value = "";
    } else {
      const text = await fetchText(`examples/${name}.fwp`);
      if (text === null) return;
      source.value = text;
      const input = inputs.get(name);
      stdin.value = (input && (await fetchText(`examples/${input}`))) || "";
    }
    clear();
    save();
  };
  for (const option of examples.options) {
    if (!/^\d/.test(option.value)) continue;
    fetchText(`examples/${option.value}.fwp`).then((text) => {
      const first = (text || "").split("\n")[0];
      if (/^# \d+\. /.test(first)) option.textContent = first.slice(2);
    });
  }
}

buttons.forEach((b) => (b.disabled = true));
startWorker();
let saved = null;
try {
  saved = localStorage.getItem("fwp-playground-source");
  stdin.value = localStorage.getItem("fwp-playground-stdin") || "";
} catch {
  // storage unavailable
}
source.value = saved || HELLO;
loadExamples();
