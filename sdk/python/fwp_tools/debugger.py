"""Synchronous control with streamed instrumentation events from fwp debug.

Commands execute only while stopped. Event callbacks must return before execution
can continue; they must not recursively issue debugger commands. Values are typed
snapshots, not live handles, and inspecting them does not execute fwp code.
"""
from __future__ import annotations

import json
import queue
import subprocess
import threading
from pathlib import Path
from typing import Callable


class DebuggerError(RuntimeError):
    pass


class Debugger:
    def __init__(self, source: str | Path, *, fwp: str,
                 input_file: str | Path | None, timeout: float):
        """Start paused at main. timeout bounds each protocol read, in seconds."""
        if timeout <= 0:
            raise ValueError("timeout must be positive")
        command = [fwp, "debug", "--json"]
        if input_file is not None:
            command += ["--input", str(input_file)]
        command += [str(source)]
        self._process = subprocess.Popen(command, stdin=subprocess.PIPE,
                                         stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                                         text=True, encoding="utf-8", bufsize=1)
        self._queue = queue.Queue()
        self._callbacks: dict[str, list[Callable[[dict], None]]] = {}
        self._timeout = timeout
        self._request_id = 0
        self._in_callback = False
        self._closed = False
        self.stopped = False
        self.finished = False
        self.last_event = None
        self.diagnostics = ""
        self._readers = []
        for stream, kind in [(self._process.stdout, "protocol"), (self._process.stderr, "stderr")]:
            reader = threading.Thread(target=self._read_stream, args=(stream, kind), daemon=True)
            reader.start()
            self._readers.append(reader)
        try:
            self.wait()
        except DebuggerError as error:
            self.close()
            raise DebuggerError(f"{error}\n{self.diagnostics}".rstrip()) from error
        except BaseException:
            self.close()
            raise

    def _read_stream(self, stream, kind):
        try:
            for line in stream:
                if kind == "stderr":
                    self.diagnostics = (self.diagnostics + line)[-65536:]
                self._queue.put((kind, line))
        finally:
            self._queue.put((kind + "_eof", None))

    def on(self, event: str, callback: Callable[[dict], None]):
        """Subscribe to an event, or '*' for all. Enable execution events with trace()."""
        self._callbacks.setdefault(event, []).append(callback)
        return callback

    def off(self, event: str, callback):
        self._callbacks.get(event, []).remove(callback)

    def _dispatch(self, message):
        event = message.get("event")
        if event == "stopped":
            self.stopped = True
        elif event == "finished":
            self.stopped = False
            self.finished = True
        self.last_event = message
        self._in_callback = True
        try:
            for callback in self._callbacks.get(event, []) + self._callbacks.get("*", []):
                callback(message)
        finally:
            self._in_callback = False

    def _read(self):
        while True:
            try:
                kind, line = self._queue.get(timeout=self._timeout)
            except queue.Empty as error:
                raise TimeoutError("fwp debugger did not respond within the configured timeout") from error
            if kind == "stderr":
                self._dispatch({"event": "stderr", "text": line})
                continue
            if kind == "stderr_eof":
                continue
            if kind == "protocol_eof":
                raise DebuggerError(f"debugger closed its protocol stream (exit {self._process.poll()})")
            try:
                message = json.loads(line)
            except json.JSONDecodeError as error:
                raise DebuggerError(f"invalid debugger response: {line!r}") from error
            if not isinstance(message, dict):
                raise DebuggerError("debugger response must be an object")
            return message

    def request(self, command: str, argument: str):
        if self._closed or self.finished:
            raise DebuggerError("debugger is closed or finished")
        if self._in_callback:
            raise DebuggerError("event callbacks cannot issue control commands recursively")
        if not self.stopped:
            raise DebuggerError("pause at an execution event before issuing a command")
        self._request_id += 1
        request_id = self._request_id
        self._process.stdin.write(json.dumps({"id": request_id, "command": command,
                                             "argument": argument}) + "\n")
        self._process.stdin.flush()
        while True:
            message = self._read()
            if "event" in message:
                self._dispatch(message)
                continue
            if message.get("id") != request_id:
                raise DebuggerError(f"unexpected response id: {message}")
            if "error" in message:
                raise DebuggerError(message["error"])
            return message.get("result")

    def wait(self):
        """Consume events until a stop or completion; callbacks receive trace/output."""
        while True:
            message = self._read()
            if "event" not in message:
                raise DebuggerError(f"unexpected response while waiting: {message}")
            self._dispatch(message)
            if self.stopped or self.finished:
                return message

    def _resume(self, command):
        self.request(command, "")
        self.stopped = False
        return self.wait()

    def continue_(self):
        return self._resume("continue")

    def step(self):
        return self._resume("step")

    def next(self):
        return self._resume("next")

    def return_(self):
        return self._resume("return")

    def break_at(self, function: str):
        return self.request("break", function)

    def clear(self, function: str):
        return self.request("clear", function)

    def stack(self):
        return self.request("stack", "")

    def frame(self, index: int):
        return self.request("frame", str(index))

    def locals(self):
        return self.request("locals", "")

    def inspect(self, slot: int):
        return self.request("print", str(slot))

    def trace(self, *events: str):
        """Enable exactly the listed kinds; no arguments disables tracing."""
        return self.request("trace", " ".join(events))

    def close(self):
        if self._closed:
            return
        self._closed = True
        if self._process.poll() is None:
            self._process.terminate()
            try:
                self._process.wait(timeout=2)
            except subprocess.TimeoutExpired:
                self._process.kill()
                self._process.wait()
        for reader in self._readers:
            reader.join()
        for stream in [self._process.stdin, self._process.stdout, self._process.stderr]:
            stream.close()

    def __enter__(self):
        return self

    def __exit__(self, *_):
        self.close()
