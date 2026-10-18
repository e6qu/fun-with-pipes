"""Local notebook application backed by fwp's checked interpreter sessions."""
from __future__ import annotations

import argparse
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from importlib.resources import files
import json
from pathlib import Path
import subprocess
import threading
import tempfile


class Kernel:
    def __init__(self, fwp, directory):
        self.fwp, self.directory = fwp, directory
        self.process = None
        self.diagnostics = None
        self.process_lock = threading.RLock()
        self.lock = threading.Lock()
        self.fingerprint = None
        self.signatures = ""

    def interrupt(self):
        with self.process_lock:
            process, diagnostics = self.process, self.diagnostics
            self.process = self.diagnostics = None
            self.fingerprint = None
        if process is not None:
            if process.poll() is None:
                process.kill()
            process.wait()
            for stream in [process.stdin, process.stdout, diagnostics]:
                if stream is not None:
                    stream.close()

    def _request(self, command, source="", *, allow_error=False):
        with self.process_lock:
            if self.process is not None and self.process.poll() is not None:
                self.interrupt()
            if self.process is None:
                self.diagnostics = tempfile.TemporaryFile(mode="w+t", encoding="utf-8")
                try:
                    self.process = subprocess.Popen([self.fwp, "repl", "--json"], cwd=self.directory,
                        stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=self.diagnostics,
                        text=True, encoding="utf-8", bufsize=1)
                except BaseException:
                    self.diagnostics.close()
                    self.diagnostics = None
                    raise
                self.fingerprint = None
            process, diagnostics = self.process, self.diagnostics
        process.stdin.write(json.dumps({"command": command, "source": source}) + "\n")
        process.stdin.flush()
        line = process.stdout.readline()
        if not line:
            raise RuntimeError("The notebook session stopped. Run a cell to start a new session.")
        reply = json.loads(line)
        diagnostics.seek(0)
        compile_output = diagnostics.read()
        diagnostics.seek(0)
        diagnostics.truncate()
        if compile_output:
            reply["compile_output"] = compile_output
        if "error" in reply and not allow_error:
            raise RuntimeError(reply["error"] + ("\nCompile-time output:\n" + compile_output if compile_output else ""))
        return reply

    def run(self, document, selected):
        with self.lock:
            cells = document.get("cells")
            if not isinstance(cells, list) or not all(isinstance(c, dict) for c in cells):
                raise ValueError("Notebook cells must be a list of objects.")
            if len(cells) > 500:
                raise ValueError("This notebook supports at most 500 cells.")
            ids = [c.get("id") for c in cells]
            if any(not isinstance(i, str) or not i for i in ids) or len(set(ids)) != len(ids):
                raise ValueError("Every cell needs a distinct nonempty id.")
            if any(c.get("kind") not in {"code", "markdown"} or not isinstance(c.get("source"), str) for c in cells):
                raise ValueError("Every cell needs code/markdown kind and source text.")
            if not isinstance(selected, list) or not all(i in ids for i in selected):
                raise ValueError("Run only cells that exist in this notebook.")
            code = [c for c in cells if c["kind"] == "code" and c["source"].strip()]
            analyses = {c["id"]: self._request("analyze", c["source"])["result"] for c in code}
            owners = {}
            for identity, info in analyses.items():
                for name in info["defines"]:
                    if name in owners:
                        raise ValueError(f"{name} is defined in two cells. Keep one definition.")
                    owners[name] = identity
                if any(name == "it" or name.startswith("out") and name[3:].isdigit() for name in info["uses"]):
                    raise ValueError("Notebook cells use named definitions, not REPL it/outN results. Name the calculation in a code cell.")
            context = [identity for identity, info in analyses.items() if info["global_context"]]
            dependencies = {identity: sorted({owners[name] for name in info["uses"] if name in owners and owners[name] != identity}
                | (set(context) - {identity} if not info["global_context"] else set())) for identity, info in analyses.items()}
            fingerprint = [(c["id"], c["source"]) for c in code]
            reset = fingerprint != self.fingerprint
            if reset:
                self._request("reset")
                definitions = "\n\n".join(c["source"] for c in code if analyses[c["id"]]["kind"] == "definitions")
                self.signatures = self._request("submit", definitions)["result"]["signatures"] if definitions.strip() else ""
                self.fingerprint = fingerprint
            results = {}
            for cell in code:
                identity = cell["id"]
                if identity not in selected:
                    continue
                info = analyses[identity]
                if info["kind"] == "definitions":
                    results[identity] = {"stdout": "", "result": {"value": None, "signatures": self.signatures}}
                else:
                    # An expression is run only when explicitly selected. Changing
                    # another cell never silently repeats its external effects.
                    results[identity] = self._request("submit", cell["source"], allow_error=True)
            return {"results": results, "dependencies": dependencies, "analysis": analyses, "reset": reset}


def serve(fwp, directory, port):
    kernel = Kernel(fwp, directory)
    assets = files("fwp_tools").joinpath("static")

    class Handler(BaseHTTPRequestHandler):
        def log_message(self, *_):
            pass

        def send(self, status, body, content_type="application/json"):
            data = body.encode() if isinstance(body, str) else body
            self.send_response(status)
            self.send_header("Content-Type", content_type + "; charset=utf-8")
            self.send_header("Content-Length", str(len(data)))
            self.send_header("Cache-Control", "no-store")
            self.send_header("X-Content-Type-Options", "nosniff")
            self.send_header("Content-Security-Policy", "default-src 'self'; script-src 'self'; style-src 'self'; img-src 'self' data:; frame-ancestors 'none'; base-uri 'none'")
            self.end_headers()
            self.wfile.write(data)

        def same_origin(self):
            expected = f"127.0.0.1:{self.server.server_port}"
            return self.headers.get("Host") == expected and self.headers.get("Origin", f"http://{expected}") == f"http://{expected}"

        def do_GET(self):
            if not self.same_origin():
                self.send(403, '{"error":"Use the printed local notebook address."}')
                return
            names = {"/": ("notebook.html", "text/html"), "/notebook.js": ("notebook.js", "text/javascript"),
                     "/notebook.css": ("notebook.css", "text/css")}
            if self.path not in names:
                self.send(404, '{"error":"Not found"}')
                return
            name, kind = names[self.path]
            self.send(200, assets.joinpath(name).read_bytes(), kind)

        def do_POST(self):
            if not self.same_origin() or self.headers.get("Content-Type") != "application/json":
                self.send(403, '{"error":"Notebook requests need same-origin JSON."}')
                return
            try:
                length = int(self.headers.get("Content-Length", "0"))
                if not 0 < length <= 2 * 1024 * 1024:
                    raise ValueError("Request size must be between 1 byte and 2 MiB.")
                request = json.loads(self.rfile.read(length))
                if self.path == "/interrupt":
                    kernel.interrupt()
                    response = {"stopped": True}
                elif self.path == "/run":
                    response = kernel.run(request["document"], request["cells"])
                else:
                    self.send(404, '{"error":"Not found"}')
                    return
                self.send(200, json.dumps(response))
            except (ValueError, RuntimeError, KeyError, OSError) as error:
                self.send(400, json.dumps({"error": str(error)}))

    server = ThreadingHTTPServer(("127.0.0.1", port), Handler)
    print(f"fwp notebook: http://127.0.0.1:{server.server_port}\nWorking directory: {directory}\nCtrl-C stops the server.", flush=True)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        kernel.interrupt()
        server.server_close()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--fwp", default="fwp", help="fwp compiler executable")
    parser.add_argument("--directory", type=Path, default=Path.cwd(), help="working directory for notebook code and imports")
    parser.add_argument("--port", type=int, default=0, help="local port; 0 asks the OS for an unused port")
    args = parser.parse_args()
    serve(args.fwp, args.directory.resolve(), args.port)


if __name__ == "__main__":
    main()
