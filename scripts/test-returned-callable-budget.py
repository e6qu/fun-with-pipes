"""Reject missing cost reductions and excessive code/frame/storage costs."""
import base64
import copy
import gzip
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
import tempfile
import unittest


SPEC = importlib.util.spec_from_file_location(
    "callable_budget", Path(__file__).with_name("check-returned-callable-budget.py"))
BUDGET = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(BUDGET)


class CallableBudget(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.baselines = {host: BUDGET.baseline(host) for host in BUDGET.MACHINES}

    def candidate(self, host):
        result = copy.deepcopy(self.baselines[host])
        for level in (1, 2):
            phases = result["programs"][f"fwp-O{level}-profile"]["phases"]
            for rows in phases.values():
                for row in rows:
                    if row["phase"] == 1:
                        row.update(retains=0, releases=0, applications=row["calls"])
        return result

    def test_unchanged_baseline_fails_but_required_reduction_passes(self):
        for host, reference in self.baselines.items():
            with self.subTest(host=host):
                self.assertFalse(BUDGET.compare(reference, reference)["accepted"])
                self.assertTrue(BUDGET.compare(reference, self.candidate(host))["accepted"])

    def test_reject_each_failed_budget(self):
        for host, reference in self.baselines.items():
            for damage in ("worker", "text", "largestFrame", "borrowedFrames", "counts", "storage"):
                candidate = self.candidate(host)
                program = candidate["programs"]["fwp-O2"]
                if damage == "worker":
                    program["code"]["workerDecodedBytes"] *= 2
                elif damage == "text":
                    program["sections"] = "\n.text 9999999 0\n"
                elif damage == "largestFrame":
                    program["cFrames"].append(dict(location="probe.c:1:large", bytes=999999, kind="static"))
                elif damage == "borrowedFrames":
                    program["cFrames"].append(dict(location="probe.c:1:fwp_apply_borrowed.clone", bytes=65, kind="static"))
                else:
                    row = candidate["programs"]["fwp-O2-profile"]["phases"]["success"][4]
                    row["applications" if damage == "counts" else "finalCountBytes"] += 1
                with self.subTest(host=host, damage=damage):
                    result = BUDGET.compare(reference, candidate)
                    self.assertFalse(result["accepted"])
                    self.assertFalse(result["levels"]["fwp-O2"]["checks"][damage])

    def test_missing_frames_or_phases_cannot_pass(self):
        for damage in ("frames", "phase"):
            candidate = self.candidate("linux-amd")
            if damage == "frames":
                candidate["programs"]["fwp-O2"]["cFrames"] = []
            else:
                candidate["programs"]["fwp-O2-profile"]["phases"]["success"].pop()
            with self.subTest(damage=damage), self.assertRaises((AssertionError, ValueError)):
                BUDGET.compare(self.baselines["linux-amd"], candidate)

    def test_complete_rejected_candidates_keep_every_decision(self):
        cases = [
            ("returned-callables-rejected-2026-10-31", "1f92902205c5da0269d1a0b20a2550736baff475",
             "74d301f87b3a2e22760b367cf28727e0bd227681730359e5c20c4ce176b6b6ee", 41177534238),
            ("returned-callables-copy-rejected-2026-10-31", "dacaf253d02b40bb18b0b39977afa69b3c2001f7",
             "a1677216c686061b2002c20d4fd617f7ddb1b4d55f058d6049ad086cc2e31aea", 41179056746),
        ]
        for name, source, digest, run in cases:
            with self.subTest(source=source):
                self.check_rejection(name, source, digest, run)

    def check_rejection(self, name, source, digest, run):
        payload = (BUDGET.ROOT / "docs/measurements" / (name + ".json.gz")).read_bytes()
        self.assertEqual(hashlib.sha256(payload).hexdigest(), digest)
        archive = json.loads(gzip.decompress(payload))
        self.assertEqual(archive["source"], source)
        self.assertEqual(archive["run"], run)
        self.assertEqual(subprocess.check_output([
            "git", "rev-parse", "roadmap/" + name], text=True).strip(), source)
        self.assertEqual(set(archive["hosts"]), set(BUDGET.MACHINES))
        with tempfile.TemporaryDirectory(prefix="fwp-callable-rejection-") as scratch:
            for host, row in archive["hosts"].items():
                folder = Path(scratch) / host
                for name, data in row["files"].items():
                    relative = Path(name)
                    self.assertFalse(relative.is_absolute())
                    self.assertNotIn("..", relative.parts)
                    path = folder / relative
                    path.parent.mkdir(parents=True, exist_ok=True)
                    path.write_bytes(base64.b64decode(data, validate=True))
                self.assertEqual(BUDGET.EVIDENCE.audit(folder, source, BUDGET.MACHINES[host]), row["audit"])
                observed = BUDGET.compare(self.baselines[host], json.loads((folder / "report.json").read_text()))
                self.assertEqual(observed, {key: value for key, value in row["budget"].items() if key != "evidenceAudit"})
                failures = [(label, key) for label, result in observed["levels"].items()
                            for key, passed in result["checks"].items() if not passed]
                self.assertEqual(failures, [("fwp-O1", "text")] if host == "linux-arm" else [])
                self.assertEqual(row["job"]["head_sha"], source)
                self.assertEqual(row["job"]["conclusion"], "failure" if failures else "success")
                self.assertEqual(row["logAudit"]["unexpectedDiagnostics"], [])
                self.assertEqual(hashlib.sha256(base64.b64decode(row["log"], validate=True)).hexdigest(),
                                 row["logAudit"]["logSha256"])

    def test_linker_maps_preserve_the_original_images(self):
        payload = (BUDGET.ROOT / "docs/measurements/returned-callable-link-2026-10-31.json.gz").read_bytes()
        self.assertEqual(hashlib.sha256(payload).hexdigest(),
                         "7d2f425d6f2d0c64d3dc97a8d649181cd74a12d2fa1da18036710cc56c912538")
        archive = json.loads(gzip.decompress(payload))
        self.assertEqual(archive["job"]["conclusion"], "success")
        self.assertEqual(archive["job"]["id"], 124471094949)
        self.assertEqual(archive["run"], 41178567613)
        self.assertEqual(archive["artifact"]["workflow_run"]["head_sha"], archive["source"])
        files = {name: base64.b64decode(data, validate=True) for name, data in archive["files"].items()}
        for label in ("baseline", "candidate"):
            report = json.loads(files[label + "/report.json"])
            commands = json.loads(files[label + "/commands.json"])
            self.assertEqual(len(commands), 7)
            self.assertTrue(all(row["status"] == 0 for row in commands))
            for row in commands:
                if "-###" in row["command"]:
                    self.assertIn("--fix-cortex-a53-843419", row["stderr"])
                else:
                    self.assertEqual(row["stderr"], "")
            for level in (1, 2):
                name = f"fwp-O{level}"
                self.assertEqual(hashlib.sha256(files[label + "/" + name]).hexdigest(),
                                 report["programs"][name]["binarySha256"])
                self.assertTrue(report["programs"][name]["identical"])
        self.assertNotIn(b" .text.stub ", files["baseline/fwp-O1.map"])
        self.assertIn(b".text.stub     0x00000000000074d0       0x10 linker stubs", files["candidate/fwp-O1.map"])
        self.assertIn(b".text          0x00000000000084d0      0x380", files["candidate/fwp-O1.map"])


if __name__ == "__main__":
    unittest.main()
