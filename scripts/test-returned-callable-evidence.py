"""Recheck the retained native baseline and reject corrupted evidence."""
import base64
import gzip
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location(
    "callable_evidence", Path(__file__).with_name("check-returned-callable-evidence.py"))
EVIDENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(EVIDENCE)
SOURCE = "7d7cf98bc62944d6c040293f4d17543c3bb51470"
TAG = "roadmap/returned-callables-baseline-2026-10-31"


class CallableEvidence(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        payload = (ROOT / "docs/measurements/returned-callables-baseline-2026-10-31.json.gz").read_bytes()
        assert hashlib.sha256(payload).hexdigest() == "bd77ee227a214f4466530e1980c0941c05a58da8733f7bcecbf45afdd4167bcc"
        cls.archive = json.loads(gzip.decompress(payload))
        assert cls.archive["source"] == SOURCE and cls.archive["run"] == 41175225918
        assert subprocess.check_output(["git", "rev-parse", TAG], text=True).strip() == SOURCE
        cls.scratch = tempfile.TemporaryDirectory(prefix="fwp-callable-evidence-")
        cls.addClassCleanup(cls.scratch.cleanup)
        cls.directory = Path(cls.scratch.name)
        assert set(cls.archive["hosts"]) == {"linux-arm", "linux-amd", "mac-arm"}
        for host, record in cls.archive["hosts"].items():
            target = cls.directory / host
            target.mkdir()
            for name, data in record["files"].items():
                path = Path(name)
                assert not path.is_absolute() and ".." not in path.parts
                (target / path).parent.mkdir(parents=True, exist_ok=True)
                (target / path).write_bytes(base64.b64decode(data, validate=True))

    def test_all_three_complete_native_baselines(self):
        for host, machine, job, artifact in (("linux-arm", "aarch64", 124461279399, 13032995375),
                                             ("linux-amd", "x86_64", 124461279547, 13032730842),
                                             ("mac-arm", "aarch64", 124461279553, 13032589018)):
            with self.subTest(host=host):
                record = self.archive["hosts"][host]
                self.assertEqual(record["job"]["id"], job)
                self.assertEqual(record["job"]["head_sha"], SOURCE)
                self.assertEqual(record["job"]["conclusion"], "success")
                self.assertEqual(record["artifact"]["id"], artifact)
                self.assertEqual(record["artifact"]["workflow_run"]["head_sha"], SOURCE)
                log = base64.b64decode(record["log"], validate=True)
                self.assertEqual(hashlib.sha256(log).hexdigest(), record["logAudit"]["logSha256"])
                self.assertEqual(record["logAudit"]["unexpectedDiagnostics"], [])
                self.assertEqual(EVIDENCE.audit(self.directory / host, SOURCE, machine), record["audit"])

    def test_changed_summary_does_not_override_raw_records(self):
        path = self.directory / "linux-arm/report.json"
        original = path.read_bytes()
        changes = (
            lambda report: report.update(source="0" * 40),
            lambda report: report["programs"].pop("fwp-O2"),
            lambda report: report["programs"]["fwp-O2"].update(binaryBytes=1),
            lambda report: report["programs"]["fwp-O2"]["code"].update(workerDecodedBytes=0),
            lambda report: report["programs"]["fwp-O2-profile"]["phases"]["success"][0].update(requestedBytes=0),
            lambda report: report["programs"]["rust-O2"]["rustFrames"].clear(),
            lambda report: report["programs"]["fwp-O2"]["controls"]["omit-release"].update(status=0),
        )
        for change in changes:
            report = json.loads(original)
            change(report)
            path.write_text(json.dumps(report))
            try:
                with self.assertRaises(AssertionError):
                    EVIDENCE.audit(path.parent, SOURCE, "aarch64")
            finally:
                path.write_bytes(original)

    def test_changed_binary_source_and_command_outcomes_fail(self):
        folder = self.directory / "linux-arm"
        for name in ("fwp-O2/callable", "fwp-O2/callable.c", "fixtures/returned_callable_peer.fwp"):
            path = folder / name
            original = path.read_bytes()
            path.write_bytes(original + b"changed")
            try:
                with self.subTest(name=name), self.assertRaises(AssertionError):
                    EVIDENCE.audit(folder, SOURCE, "aarch64")
            finally:
                path.write_bytes(original)
        path = folder / "commands.jsonl"
        original = path.read_bytes()
        for damage in ("status", "warning", "duplicate"):
            rows = [json.loads(line) for line in original.splitlines()]
            if damage == "status":
                rows[0]["status"] = 1
            elif damage == "warning":
                rows[0]["stderr"] = base64.b64encode(b"warning: unexpected\n").decode()
            else:
                rows.append(rows[0])
            path.write_text("".join(json.dumps(row) + "\n" for row in rows))
            try:
                with self.subTest(damage=damage), self.assertRaises(AssertionError):
                    EVIDENCE.audit(folder, SOURCE, "aarch64")
            finally:
                path.write_bytes(original)


if __name__ == "__main__":
    unittest.main()
