import os
from pathlib import Path
import tempfile
import unittest

from fwp_tools import Debugger, Disassembler, Target
from fwp_tools.notebook import Kernel

FWP = os.environ["FWP_TEST_BIN"]


class Tools(unittest.TestCase):
    def test_debugger_controls_typed_values_and_streams_events(self):
        with tempfile.TemporaryDirectory() as directory:
            source = Path(directory) / "program.fwp"
            source.write_text("increment : I64 -> I64\nincrement = add 1\nmain = 41 | increment | echo\n")
            events = []
            with Debugger(source, fwp=FWP) as debugger:
                debugger.on("*", events.append)
                debugger.break_at("increment")
                debugger.continue_()
                self.assertEqual(debugger.inspect(0)["value"]["display"], "41")
                self.assertEqual(debugger.stack()[-1]["function"], "increment")
                debugger.trace("call", "expression", "value", "bind", "return", "error")
                debugger.return_()
                debugger.continue_()
                self.assertTrue(debugger.finished)
            self.assertTrue(any(e["event"] == "expression" for e in events))
            self.assertTrue(any(e["event"] == "value" for e in events))
            self.assertEqual("".join(e["text"] for e in events if e["event"] == "output"), "42\n")

    def test_source_line_breakpoints_and_float_bits(self):
        with tempfile.TemporaryDirectory() as directory:
            source = Path(directory) / "source.fwp"
            source.write_text("square : F64 -> F64\nsquare = fork mul id id\nmain = 3.0 | square | echo\n")
            with Debugger(source, fwp=FWP) as debugger:
                debugger.break_at("source.fwp:2")
                stopped = debugger.continue_()
                self.assertEqual(stopped["reason"]["location"]["line"], 2)
                self.assertEqual(debugger.inspect(0)["value"]["float_bits"], "4008000000000000")
                debugger.clear("source.fwp:2")
                debugger.continue_()
                self.assertTrue(debugger.finished)

    def test_program_input_is_separate_from_debugger_commands(self):
        with tempfile.TemporaryDirectory() as directory:
            source = Path(directory) / "program.fwp"
            source.write_text("main = read-all () | echo\n")
            data = Path(directory) / "input.txt"
            data.write_text("input for the program")
            events = []
            with Debugger(source, fwp=FWP, input_file=data) as debugger:
                debugger.on("output", events.append)
                debugger.continue_()
                self.assertEqual(debugger.last_event["status"], 0)
            self.assertEqual("".join(e["text"] for e in events), "input for the program\n")

    def test_notebook_replaces_definitions_and_never_replays_other_expressions(self):
        with tempfile.TemporaryDirectory() as directory:
            kernel = Kernel(FWP, directory)
            document = {"cells": [
                {"id": "definition", "kind": "code", "source": "value = 7"},
                {"id": "effect", "kind": "code", "source": '"once" | echo'},
                {"id": "result", "kind": "code", "source": "value + 1"},
            ]}
            try:
                result = kernel.run(document, ["effect", "result"])
                self.assertEqual(result["results"]["effect"]["stdout"], "once\n")
                self.assertEqual(result["results"]["result"]["result"]["value"], "8")
                self.assertEqual(result["dependencies"]["result"], ["definition"])
                document["cells"][0]["source"] = "value = 20"
                result = kernel.run(document, ["result"])
                self.assertNotIn("effect", result["results"])
                self.assertEqual(result["results"]["result"]["result"]["value"], "21")
                document["cells"].append({"id": "duplicate", "kind": "code", "source": "value = 2"})
                with self.assertRaisesRegex(ValueError, "defined in two cells"):
                    kernel.run(document, ["result"])
            finally:
                process = kernel.process
                kernel.interrupt()
                if process is not None:
                    self.assertIsNotNone(process.poll())
                    self.assertTrue(process.stdin.closed and process.stdout.closed)

    def test_notebook_input_cannot_consume_protocol_and_errors_leave_session_usable(self):
        with tempfile.TemporaryDirectory() as directory:
            kernel = Kernel(FWP, directory)
            try:
                for primitive in ("read-all", "read-lines", "read-line", "term.read-secret"):
                    reply = kernel._request("submit", primitive + " ()", allow_error=True)
                    self.assertIn("session commands", reply["error"])
                    reply = kernel._request("submit", "6 * 7")
                    self.assertEqual(reply["result"]["value"], "42")
            finally:
                kernel.interrupt()

    def test_disassembly_compares_c_and_instruction_encodings_at_four_levels(self):
        with tempfile.TemporaryDirectory() as directory:
            source = Path(directory) / "program.fwp"
            source.write_text("main = 41 | add 1 | echo\n")
            targets = [Target("native", os.environ.get("CC", "cc"), "native")]
            if os.environ.get("FWP_CROSS_CC"):
                targets.append(Target("aarch64-linux", os.environ["FWP_CROSS_CC"], "aarch64-linux-gnu"))
            report = Disassembler(fwp=FWP, llvm_objdump=os.environ.get("FWP_OBJDUMP", "llvm-objdump")).compare(
                source, Path(directory) / "report", targets=targets)
            self.assertFalse(report["executed"])
            self.assertEqual(len(report["variants"]), 4 * len(targets))
            for target in report["targets"]:
                self.assertIn("Generated by fwp", target["generated_c"])
                self.assertIn(target["fwp_target"], target["emit_command"])
            for variant in report["variants"]:
                self.assertTrue(variant["instructions"])
                self.assertTrue(any(i["c_line"] is not None for i in variant["instructions"]))
                self.assertTrue(all(i["encoding"] for i in variant["instructions"]))
                if variant["target"] == "aarch64-linux":
                    self.assertIn("aarch64", variant["text"])


if __name__ == "__main__":
    unittest.main()
