"""Check paired observations and zero-work agreement independently of copies."""
import copy
import hashlib
import json
from pathlib import Path
import tempfile
import unittest
import zipfile

from callable_context import ROUNDS, order
from callable_paired import audit, parse, summarize


class PairedRecords(unittest.TestCase):
    def rows(self):
        return [dict(round=r, position=p, label=label, ns=dict(
            reference=dict(construction=10_000_000, invocation=20_000_000, release=10_000_000),
            current=dict(construction=10_000_000, invocation=20_000_000, release=10_000_000),
            process=90_000_000)) for r in range(ROUNDS) for p, label in enumerate(order(r))]

    def test_zero_work_must_agree_even_when_copies_agree(self):
        rows = self.rows()
        result = summarize(rows, 0)["construction"]
        self.assertTrue(result["qualified"])
        self.assertTrue(result["identicalWorkWithinLimit"])
        for row in rows:
            row["ns"]["current"]["construction"] = 9_700_000
        result = summarize(rows, 0)["construction"]
        self.assertTrue(result["qualified"])
        self.assertFalse(result["identicalWorkWithinLimit"])
        self.assertIsNone(summarize(rows, 16)["construction"]["identicalWorkWithinLimit"])

    def test_noisy_copy_or_short_mode_cannot_qualify(self):
        for problem in ("copy", "short"):
            rows = self.rows()
            for row in rows:
                if row["label"] == "current-copy":
                    row["ns"]["current"]["construction"] = 12_000_000 if problem == "copy" else 1000
            self.assertFalse(summarize(rows, 0)["construction"]["qualified"])

    def test_each_mode_must_produce_its_own_exact_checksum(self):
        for kind in (0, 1):
            for passes in (0, 1, 16):
                n = 4096
                expected = (kind + 1) * 256 * (passes * (n * (n - 1) // 2 + 7 * n) + n * passes * (passes - 1) // 2)
                text = f"{expected} 10 20 30 {expected} 40 50 60"
                self.assertEqual(parse(text, kind, passes)["current"]["release"], 60)
                with self.assertRaises(AssertionError):
                    parse(f"{expected} 10 20 30 {expected+1} 40 50 60", kind, passes)
        with self.assertRaises(AssertionError):
            parse("0 10 20 30", 0, 0)

    def test_missing_or_damaged_samples_fail(self):
        rows = self.rows()
        for damaged in (rows[1:], [rows[1], rows[0], *rows[2:]]):
            with self.assertRaises(AssertionError):
                summarize(damaged, 16)
        for value in (0, -1, True, float("nan"), 100_000_000):
            damaged = copy.deepcopy(rows)
            damaged[0]["ns"]["current"]["construction"] = value
            with self.subTest(value=value), self.assertRaises(AssertionError):
                summarize(damaged, 16)

    def test_retained_arm_pairs_preserve_zero_call_agreement_and_order_effects(self):
        path = Path(__file__).resolve().parent.parent / "docs/measurements/callable-paired-arm64-2026-10-31.zip"
        self.assertEqual(hashlib.sha256(path.read_bytes()).hexdigest(),
                         "841f81dcf696dbc6caaba9c1bfdf2b56556b03d50d0a064960f8b962b37554f4")
        with zipfile.ZipFile(path) as archive, tempfile.TemporaryDirectory() as directory:
            archive.extractall(directory)
            report = audit(Path(directory) / "paired", "dfb6ff8e8aac215009e9a9cf48a8bce492ef4eae", "aarch64")
            self.assertTrue(report["matchesOriginalCpu"])
            self.assertEqual(report["cpuModel"], "Neoverse-N2")
            decisions = [phase["qualified"] for session in report["sessions"]
                         for case in session["cases"] for phase in case["summary"].values()]
            self.assertEqual(sum(decisions), 32)
            self.assertEqual(len(decisions) - sum(decisions), 4)
            for session in report["sessions"]:
                for case in session["cases"]:
                    if case["passes"] == 0:
                        for phase in ("construction", "release"):
                            self.assertTrue(case["summary"][phase]["identicalWorkWithinLimit"])
                    ratios = case["summary"]["construction"]["pairedCurrentOverReference"]
                    for label in ("reference", "reference-copy"):
                        self.assertLess(ratios[label], 1)
                    for label in ("current", "current-copy"):
                        self.assertGreater(ratios[label], 1)


    def test_retained_amd_pairs_preserve_short_phases_and_host_mismatch(self):
        path = Path(__file__).resolve().parent.parent / "docs/measurements/callable-paired-amd64-2026-10-31.zip"
        self.assertEqual(hashlib.sha256(path.read_bytes()).hexdigest(),
                         "4a21351c257610abc8e59b999af1c1252b29c44adf3f9cfd64eeeab314137cd8")
        source = "dfb6ff8e8aac215009e9a9cf48a8bce492ef4eae"
        with zipfile.ZipFile(path) as archive, tempfile.TemporaryDirectory() as directory:
            archive.extractall(directory)
            folder = Path(directory) / "paired"
            report = audit(folder, source, "x86_64")
            self.assertFalse(report["matchesOriginalCpu"])
            self.assertIn("AMD EPYC 9V45", report["cpuModel"])
            self.assertIn("Intel(R) Xeon(R) Platinum 8370C", report["originalCpuModel"])
            decisions = [phase["qualified"] for session in report["sessions"]
                         for case in session["cases"] for phase in case["summary"].values()]
            self.assertEqual(sum(decisions), 19)
            self.assertEqual(len(decisions) - sum(decisions), 17)
            for session in report["sessions"]:
                for case in session["cases"]:
                    construction = case["summary"]["construction"]
                    self.assertFalse(construction["qualified"])
                    self.assertLess(min(v for m in construction["medianNs"].values() for v in m.values()), 5_000_000)
                    self.assertIsNone(construction["identicalWorkWithinLimit"])
                    self.assertEqual(case["summary"]["invocation"]["qualified"], case["passes"] != 0)
            release = report["sessions"][1]["cases"][3]["summary"]["release"]
            self.assertFalse(release["qualified"])
            self.assertIsNone(release["identicalWorkWithinLimit"])
            self.assertGreater(max(v for m in release["copyRatios"].values() for v in m.values()), 1.02)
            manifest = json.loads((folder / "manifest.json").read_text())
            for damage in ("missing-warmup", "reused-command", "wrong-sample", "wrong-host", "promoted-result"):
                damaged = copy.deepcopy(report)
                case = damaged["sessions"][0]["cases"][0]
                if damage == "missing-warmup":
                    case["warmups"].pop()
                elif damage == "reused-command":
                    case["warmups"][1] = case["warmups"][0]
                elif damage == "wrong-sample":
                    case["samples"][0]["command"] += 1
                elif damage == "wrong-host":
                    damaged["matchesOriginalCpu"] = True
                else:
                    case["summary"]["construction"]["qualified"] = True
                (folder / "report.json").write_text(json.dumps(damaged))
                # Valid file hashes must not conceal invalid observations.
                manifest["report.json"] = hashlib.sha256((folder / "report.json").read_bytes()).hexdigest()
                (folder / "manifest.json").write_text(json.dumps(manifest))
                with self.subTest(damage=damage), self.assertRaises(AssertionError):
                    audit(folder, source, "x86_64")


if __name__ == "__main__":
    unittest.main()
