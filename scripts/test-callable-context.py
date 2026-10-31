"""Check phase-context observations without relaxing the original experiment."""
import copy
import hashlib
import json
from pathlib import Path
import tempfile
import unittest
import zipfile

from callable_context import LABELS, ROUNDS, audit, durations, order, summarize


class ContextRecords(unittest.TestCase):
    def rows(self):
        return [dict(round=r, position=p, label=label,
                     ns=dict(construction=10_000_000, invocation=20_000_000,
                             release=10_000_000, process=50_000_000))
                for r in range(ROUNDS) for p, label in enumerate(order(r))]

    def test_positions_and_predecessors_are_balanced(self):
        positions = {label: [0] * 4 for label in LABELS}
        pairs = {}
        for r in range(4):
            labels = order(r)
            for p, label in enumerate(labels):
                positions[label][p] += 1
            for pair in zip(labels, labels[1:]):
                pairs[pair] = pairs.get(pair, 0) + 1
        self.assertTrue(all(row == [1] * 4 for row in positions.values()))
        self.assertEqual(len(pairs), 12)
        self.assertEqual(set(pairs.values()), {1})

    def test_zero_one_and_sixteen_calls_have_distinct_checksums(self):
        for kind in (0, 1):
            for passes in (0, 1, 16):
                n = 4096
                expected = (kind + 1) * 256 * (passes * (n * (n - 1) // 2 + 7 * n) + n * passes * (passes - 1) // 2)
                self.assertEqual(durations(f"{expected} 10 20 30", kind, passes),
                                 dict(construction=10, invocation=20, release=30))
                with self.assertRaises(AssertionError):
                    durations(f"{expected+1} 10 20 30", kind, passes)

    def test_noisy_or_too_short_phase_is_inconclusive(self):
        rows = self.rows()
        self.assertTrue(summarize(rows)["construction"]["qualified"])
        for row in rows:
            if row["label"] == "current-copy":
                row["ns"]["construction"] = 11_000_000
        self.assertFalse(summarize(rows)["construction"]["qualified"])
        rows = self.rows()
        for row in rows:
            row["ns"]["invocation"] = 1000
        self.assertFalse(summarize(rows)["invocation"]["qualified"])

    def test_damaged_records_and_impossible_elapsed_time_fail(self):
        rows = self.rows()
        for damaged in (rows[1:], [rows[1], rows[0], *rows[2:]]):
            with self.assertRaises(AssertionError):
                summarize(damaged)
        for value in (0, -1, True, float("nan"), 100_000_000):
            damaged = copy.deepcopy(rows)
            damaged[0]["ns"]["construction"] = value
            with self.subTest(value=value), self.assertRaises(AssertionError):
                summarize(damaged)

    def test_retained_arm_study_and_semantic_damage(self):
        source = "dfb6ff8e8aac215009e9a9cf48a8bce492ef4eae"
        path = Path(__file__).resolve().parent.parent / "docs/measurements/callable-context-arm64-2026-10-31.zip"
        self.assertEqual(hashlib.sha256(path.read_bytes()).hexdigest(),
                         "15bc07df76af81c35489ef04cff37a95b84da8632295b3772e62cf29c39c6c0e")
        with zipfile.ZipFile(path) as archive, tempfile.TemporaryDirectory() as directory:
            archive.extractall(directory)
            folder = Path(directory) / "context"
            report = audit(folder, source, "aarch64")
            self.assertIn("Neoverse-N2", report["cpu"])
            for session in report["sessions"]:
                for case in session["cases"]:
                    self.assertTrue(case["summary"]["construction"]["qualified"])
                    self.assertLessEqual(abs(case["summary"]["construction"]["currentOverReference"] - 1), 0.006)
                    self.assertEqual(case["summary"]["invocation"]["qualified"], case["passes"] != 0)
            manifest = json.loads((folder / "manifest.json").read_text())
            for damage in ("missing-warmup", "reused-command", "wrong-invocation"):
                damaged = copy.deepcopy(report)
                first = damaged["sessions"][0]["cases"][0]
                if damage == "missing-warmup":
                    first["warmups"].pop()
                elif damage == "reused-command":
                    first["warmups"][1] = first["warmups"][0]
                else:
                    first["samples"][0]["command"] += 1
                (folder / "report.json").write_text(json.dumps(damaged))
                # Keep the file digest valid to exercise semantic rejection too.
                manifest["report.json"] = hashlib.sha256((folder / "report.json").read_bytes()).hexdigest()
                (folder / "manifest.json").write_text(json.dumps(manifest))
                with self.subTest(damage=damage), self.assertRaises(AssertionError):
                    audit(folder, source, "aarch64")

    def test_retained_amd_study_preserves_host_mismatch_and_failed_controls(self):
        source = "dfb6ff8e8aac215009e9a9cf48a8bce492ef4eae"
        path = Path(__file__).resolve().parent.parent / "docs/measurements/callable-context-amd64-2026-10-31.zip"
        self.assertEqual(hashlib.sha256(path.read_bytes()).hexdigest(),
                         "81e4d9e2d068bb51f59e4e26222c7aab90dfcebaa494a66a9e3f256690bbe080")
        with zipfile.ZipFile(path) as archive, tempfile.TemporaryDirectory() as directory:
            archive.extractall(directory)
            report = audit(Path(directory) / "context", source, "x86_64")
            self.assertIn("AMD EPYC 9V74", report["cpu"])
            original = json.loads((path.parent / "callable-phases-2026-10-31.json").read_text())
            for session in original["sessions"]:
                if session["architecture"] == "x86_64":
                    self.assertIn("Intel(R) Xeon(R) Platinum 8370C", session["cpu"])
            decisions = [phase["qualified"] for session in report["sessions"]
                         for case in session["cases"] for phase in case["summary"].values()]
            self.assertEqual(sum(decisions), 32)
            self.assertEqual(len(decisions) - sum(decisions), 16)
            zero = report["sessions"][1]["cases"][3]
            self.assertEqual((zero["kind"], zero["passes"]), (1, 0))
            control = zero["summary"]["construction"]
            self.assertTrue(control["qualified"])
            # Copies pass but the two identical-work modes differ by over 2%.
            self.assertGreater(1 / control["currentOverReference"], 1.02)
            release = report["sessions"][1]["cases"][2]["summary"]["release"]
            self.assertTrue(release["qualified"])
            self.assertGreater(release["currentOverReference"], 1.02)


if __name__ == "__main__":
    unittest.main()
