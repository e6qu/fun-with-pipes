"""Run maintained applications through user-facing execution tools."""
import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest

from fwp_tools.debugger import Debugger
from fwp_tools.notebook import Kernel

FWP = os.environ["FWP_TEST_BIN"]


class Applications(unittest.TestCase):
    def execution_outputs(self, source, directory, environment, input_text):
        outputs = []
        for raw in (False, True):
            result = subprocess.run([FWP, "run", "--interp", str(source)], input=input_text,
                env=environment | ({"FWP_NO_OPT": "1"} if raw else {}),
                capture_output=True, text=True, encoding="utf-8", timeout=120)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(result.stderr, "")
            outputs.append(("raw" if raw else "optimized", result.stdout))
        for level in ("-O1", "-O2"):
            binary = Path(directory) / (source.stem + level + ".exe")
            build = subprocess.run([FWP, "build", str(source), level, "-o", str(binary)],
                env=environment, capture_output=True, text=True, encoding="utf-8", timeout=120)
            self.assertEqual(build.returncode, 0, build.stderr)
            self.assertEqual(build.stderr, "")
            result = subprocess.run([str(binary)], input=input_text, capture_output=True,
                text=True, encoding="utf-8", timeout=120)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(result.stderr, "")
            outputs.append((level, result.stdout))
        return outputs

    def test_numerical_application_across_execution_tools(self):
        root = Path(__file__).resolve().parents[3]
        lesson = root / "docs/tutorials/20-autodiff-and-devices/main.fwp"
        definitions = lesson.read_text(encoding="utf-8").split("\nloss :", 1)[0]
        self.assertIn("descend =", definitions)
        inputs = "start : List[F64]\nstart = [-1.2, 1.0, 0.5]"
        # Separate rows keep the loss, gradient and updated inputs identifiable.
        computation = "[rosenbrock start | json.write | print,\n" + \
            "grad rosenbrock start | json.write | print,\n" + \
            "descend start | json.write | print] | ignore"
        program = definitions + "\n" + inputs + "\nmain = " + computation + "\n"
        environment = dict(os.environ)
        environment.pop("FWP_NO_OPT", None)
        environment["FWP_LTO"] = "0"
        with tempfile.TemporaryDirectory() as directory:
            source = Path(directory) / "minimize.fwp"
            source.write_text(program, encoding="utf-8")
            outputs = self.execution_outputs(source, directory, environment, "")
            kernel = Kernel(FWP, directory)
            document = {"cells": [
                {"id": "functions", "kind": "code", "source": definitions},
                {"id": "input", "kind": "code", "source": inputs},
                {"id": "compute", "kind": "code", "source": computation},
            ]}
            try:
                reply = kernel.run(document, ["compute"])
                outputs.append(("notebook", reply["results"]["compute"]["stdout"]))
                self.assertEqual(reply["dependencies"]["compute"], ["functions", "input"])
                document["cells"][1]["source"] = "start = 7"
                reply = kernel.run(document, ["compute"])
                self.assertIn("error", reply["results"]["compute"])
                self.assertEqual(reply["results"]["compute"]["stdout"], "")
                document["cells"][1]["source"] = "start : List[F64]\nstart = [1.0, 1.0, 1.0]"
                reply = kernel.run(document, ["compute"])
                rows = [json.loads(line) for line in reply["results"]["compute"]["stdout"].splitlines()]
                self.assertEqual(rows, [0.0, [0.0, 0.0, 0.0], [1.0, 1.0, 1.0]])
            finally:
                kernel.interrupt()
            result = subprocess.run([FWP, "repl", "--no-history"],
                input=f":load {source}\nrosenbrock start | round | eq 49.0\n:quit\n",
                env=environment, capture_output=True, text=True, encoding="utf-8", timeout=120)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(result.stderr, "")
            # The full precision results are checked below, outside REPL prompts.
            self.assertIn("True", result.stdout)
            events = []
            with Debugger(source, fwp=FWP, input_file=None, timeout=30) as debugger:
                debugger.on("output", events.append)
                debugger.break_at("descend")
                debugger.continue_()
                self.assertEqual(json.loads(debugger.inspect(0)["value"]["display"]), [-1.2, 1.0, 0.5])
                debugger.clear("descend")
                while not debugger.finished:
                    debugger.continue_()
                self.assertEqual(debugger.last_event["status"], 0)
            outputs.append(("debugger", "".join(event["text"] for event in events)))
            for tool, output in outputs:
                with self.subTest(tool=tool):
                    rows = [json.loads(line) for line in output.splitlines()]
                    self.assertEqual(len(rows), 3)
                    self.assertAlmostEqual(rows[0], 49.2, delta=1e-12)
                    for actual, expected in zip(rows[1:], ([-215.6, 112.0, -100.0], [-0.9844, 0.888, 0.6])):
                        self.assertEqual(len(actual), len(expected))
                        for value, reference in zip(actual, expected):
                            self.assertAlmostEqual(value, reference, delta=1e-12)

    def test_callback_application_delivery_cancellation_and_errors(self):
        root = Path(__file__).resolve().parents[3]
        fixture = root / "tests/fixtures/weak_callback_service.fwp"
        program = fixture.read_text(encoding="utf-8")
        self.assertEqual(program.count("\nmain ="), 1)
        definitions = program.split("\nmain =", 1)[0]
        computation = "[(64, 0), (64, 1), (64, 2), (64, 3)] | each (service | json.write | print)"
        expected = []
        for mode in range(4):
            delivered = [i for i in range(64) if
                (mode == 0 or mode == 1 and i % 4 != 0 or mode == 3 and i <= 32)]
            checksum = sum(sum(range(i, i + 16)) for i in delivered)
            expected.append({"population": 64, "mode": mode, "calls": len(delivered),
                "cancelled": 16 if mode == 1 else 0, "expired": 64 if mode == 2 else 0,
                "errors": 1 if mode == 3 else 0, "sent": len(delivered),
                "received": len(delivered), "sum": checksum, "received_sum": checksum})
        environment = dict(os.environ)
        environment.pop("FWP_NO_OPT", None)
        environment["FWP_LTO"] = "0"
        with tempfile.TemporaryDirectory() as directory:
            source = Path(directory) / "callbacks.fwp"
            source.write_text(definitions + "\nmain = " + computation + "\n", encoding="utf-8")
            outputs = self.execution_outputs(source, directory, environment, "")
            result = subprocess.run([FWP, "repl", "--no-history"],
                input=f":load {source}\n(64, 1) | service | .sum | eq 30336\n:quit\n",
                env=environment, capture_output=True, text=True, encoding="utf-8", timeout=120)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(result.stderr, "")
            self.assertIn("True", result.stdout)
            kernel = Kernel(FWP, directory)
            document = {"cells": [
                {"id": "functions", "kind": "code", "source": definitions},
                {"id": "input", "kind": "code", "source": "configuration = (64, 0)"},
                {"id": "compute", "kind": "code", "source":
                    "configuration | service | json.write | print"},
            ]}
            try:
                for mode in range(4):
                    document["cells"][1]["source"] = f"configuration = (64, {mode})"
                    reply = kernel.run(document, ["compute"])
                    self.assertEqual(json.loads(reply["results"]["compute"]["stdout"]), expected[mode])
                    self.assertIn("input", reply["dependencies"]["compute"])
                document["cells"][1]["source"] = 'configuration = "wrong type"'
                reply = kernel.run(document, ["compute"])
                self.assertIn("error", reply["results"]["compute"])
                self.assertEqual(reply["results"]["compute"]["stdout"], "")
                document["cells"][1]["source"] = "configuration = (64, 0)"
                reply = kernel.run(document, ["compute"])
                self.assertEqual(json.loads(reply["results"]["compute"]["stdout"]), expected[0])
            finally:
                kernel.interrupt()
            events = []
            with Debugger(source, fwp=FWP, input_file=None, timeout=30) as debugger:
                debugger.on("output", events.append)
                debugger.break_at("service")
                debugger.continue_()
                self.assertEqual(debugger.inspect(0)["value"]["display"], "(64, 0)")
                debugger.clear("service")
                while not debugger.finished:
                    debugger.continue_()
                self.assertEqual(debugger.last_event["status"], 0)
            outputs.append(("debugger", "".join(event["text"] for event in events)))
            for tool, output in outputs:
                with self.subTest(tool=tool):
                    self.assertEqual([json.loads(line) for line in output.splitlines()], expected)

    def test_word_count_application_across_native_notebook_and_debugger(self):
        root = Path(__file__).resolve().parents[3]
        source = root / "examples/wordfreq.fwp"
        text = (root / "tests/run/wordfreq.in").read_text(encoding="utf-8")
        expected = (root / "tests/run/wordfreq.out").read_text(encoding="utf-8")
        program = source.read_text(encoding="utf-8")
        self.assertEqual(program.count("\nmain ="), 1)
        definitions = program.split("\nmain =", 1)[0]
        environment = dict(os.environ)
        environment.pop("FWP_NO_OPT", None)
        environment["FWP_LTO"] = "0"
        with self.subTest(tool="terminal repl"):
            result = subprocess.run([FWP, "repl", "--no-history"],
                cwd=root, input=':load examples/wordfreq.fwp\n"hello Hello." | count-words\n:quit\n',
                env=environment, capture_output=True, text=True, encoding="utf-8", timeout=120)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(result.stderr, "")
            self.assertIn('[("hello", 2)]', result.stdout)
        with tempfile.TemporaryDirectory() as directory:
            for tool, output in self.execution_outputs(source, directory, environment, text):
                with self.subTest(tool=tool):
                    self.assertEqual(output, expected)
            with self.subTest(tool="notebook"):
                kernel = Kernel(FWP, directory)
                document = {"cells": [
                    {"id": "functions", "kind": "code", "source": definitions},
                    {"id": "input", "kind": "code", "source": "text = " + json.dumps(text)},
                    {"id": "counts", "kind": "code", "source":
                        'text | count-words | each (format "{}: {}" | print)'},
                ]}
                try:
                    reply = kernel.run(document, ["counts"])
                    self.assertEqual(reply["results"]["counts"]["stdout"], expected)
                    self.assertEqual(reply["dependencies"]["counts"], ["functions", "input"])
                    document["cells"][1]["source"] = "text = 7"
                    reply = kernel.run(document, ["counts"])
                    self.assertIn("error", reply["results"]["counts"])
                    self.assertEqual(reply["results"]["counts"]["stdout"], "")
                    document["cells"][1]["source"] = "text = " + json.dumps(text + "fox\n")
                    reply = kernel.run(document, ["counts"])
                    self.assertEqual(reply["results"]["counts"]["stdout"],
                        "fox: 4\nthe: 4\ndog: 3\na: 2\nlazy: 2\n")
                finally:
                    kernel.interrupt()
            with self.subTest(tool="debugger"):
                input_file = Path(directory) / "words.txt"
                input_file.write_text(text, encoding="utf-8", newline="")
                events = []
                with Debugger(source, fwp=FWP, input_file=input_file, timeout=30) as debugger:
                    debugger.on("output", events.append)
                    debugger.break_at("count-words")
                    debugger.continue_()
                    self.assertEqual(debugger.inspect(0)["value"]["display"], json.dumps(text))
                    debugger.clear("count-words")
                    while not debugger.finished:
                        debugger.continue_()
                    self.assertEqual(debugger.last_event["status"], 0)
                self.assertEqual("".join(event["text"] for event in events), expected)
