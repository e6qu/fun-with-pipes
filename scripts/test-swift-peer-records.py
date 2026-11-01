"""Reject incomplete observations and expose identical-program timing noise."""
import copy
import contextlib
import hashlib
import io
import json
import importlib.util
from pathlib import Path
import tarfile
import tempfile
from types import SimpleNamespace
import unittest

SPEC = importlib.util.spec_from_file_location("swift_peers", Path(__file__).with_name("measure-swift-peers.py"))
PEERS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PEERS)


class Records(unittest.TestCase):
    def samples(self):
        return [dict(round=r, position=p, label=label, elapsedNs=1000)
                for r in range(PEERS.ROUNDS) for p, label in enumerate(PEERS.order(r))]

    def test_complete_original_evidence_is_retained_and_auditable(self):
        root = Path(__file__).resolve().parent.parent / "docs/measurements"
        path = root / "swift-peers-2026-10-31.tar.xz"
        self.assertEqual(hashlib.sha256(path.read_bytes()).hexdigest(),
                         "8ddb06a630969718322cacd10e3a3472f7e0da1c5da97106b8c0090806604118")
        summary = json.loads((root / "swift-peers-2026-10-31.json").read_text())
        with tempfile.TemporaryDirectory(prefix="fwp-swift-archive-") as temporary:
            directory = Path(temporary)
            with tarfile.open(path, "r:xz") as archive:
                archive.extractall(directory, filter="data")
            self.assertEqual({p.name for p in directory.iterdir()},
                             {f"swift-peers-{arch}-{session}" for arch in ("x86_64", "aarch64") for session in (1, 2)})
            for session in summary["sessions"]:
                arch, number = session["architecture"], session["session"]
                source = directory / f"swift-peers-{arch}-{number}" / "swift-peer-evidence"
                with contextlib.redirect_stdout(io.StringIO()):
                    PEERS.audit(SimpleNamespace(input=source, source=summary["source"], arch=arch))
                report = json.loads((source / "report.json").read_text())
                self.assertEqual(report["session"], number)
                for row in session["programs"]:
                    actual = report["programs"][row["program"]]
                    self.assertEqual(actual["summary"], {key: row[key] for key in actual["summary"]})
                    self.assertEqual(row["peakRssKiB"], {
                        lang: [sample["peakRssKiB"] for sample in actual["memory"][lang]]
                        for lang in PEERS.LANGUAGES})

    def test_retained_results_preserve_noise_and_different_hosts(self):
        path = Path(__file__).resolve().parent.parent / "docs/measurements/swift-peers-2026-10-31.json"
        raw = path.read_bytes()
        self.assertEqual(hashlib.sha256(raw).hexdigest(), "5ca6531c7cc3f96dd76b77ccc02eda1712fcee01ca22c33f9cd1124c4c2f7e0c")
        data = json.loads(raw)
        self.assertEqual(data["source"], "80a0504a97f7c96291e77be6e8f843d5cb8c7391")
        sessions = {(row["architecture"], row["session"]): row for row in data["sessions"]}
        self.assertEqual(set(sessions), {(arch, session) for arch in ("x86_64", "aarch64") for session in (1, 2)})
        self.assertNotEqual(sessions["x86_64", 1]["cpuModel"], sessions["x86_64", 2]["cpuModel"])
        self.assertEqual(sessions["aarch64", 1]["cpuModel"], sessions["aarch64", 2]["cpuModel"])
        failures = {}
        for key, session in sessions.items():
            self.assertEqual([row["program"] for row in session["programs"]], list(PEERS.PROGRAMS))
            failures[key] = set()
            for row in session["programs"]:
                medians = row["medianNs"]
                self.assertEqual(set(medians), set(PEERS.LABELS))
                copies = {lang: max(medians[lang], medians[lang + "-copy"]) / min(medians[lang], medians[lang + "-copy"])
                          for lang in PEERS.LANGUAGES}
                self.assertEqual(row["copyRatios"], copies)
                self.assertEqual(row["stable"], all(value <= 1.02 for value in copies.values()))
                self.assertEqual(row["fwpOverPeer"], {lang: medians["fwp"] / medians[lang] for lang in PEERS.LANGUAGES[:-1]})
                self.assertEqual(set(row["peakRssKiB"]), set(PEERS.LANGUAGES))
                for values in row["peakRssKiB"].values():
                    self.assertEqual(len(values), 3)
                    self.assertTrue(all(type(value) is int and value > 0 for value in values))
                if not row["stable"]:
                    failures[key].add(row["program"])
        self.assertEqual(failures, {
            ("aarch64", 1): {"map", "pipeline"}, ("aarch64", 2): {"map", "pipeline"},
            ("x86_64", 1): {"loop", "range-set", "strings"},
            ("x86_64", 2): {"range-set", "strings", "text-length"},
        })

    def test_balanced_positions_and_predecessors(self):
        positions = {label: [0] * 8 for label in PEERS.LABELS}
        previous = {}
        for r in range(8):
            labels = PEERS.order(r)
            self.assertEqual(set(labels), set(PEERS.LABELS))
            for p, label in enumerate(labels):
                positions[label][p] += 1
            for pair in zip(labels, labels[1:]):
                previous[pair] = previous.get(pair, 0) + 1
        self.assertTrue(all(counts == [1] * 8 for counts in positions.values()))
        self.assertEqual(len(previous), 56)
        self.assertEqual(set(previous.values()), {1})

    def test_noisy_swift_remains_inconclusive(self):
        samples = self.samples()
        self.assertTrue(PEERS.summarize(samples)["stable"])
        for row in samples:
            if row["label"] == "swift-copy":
                row["elapsedNs"] = 1030
        result = PEERS.summarize(samples)
        self.assertFalse(result["stable"])
        self.assertEqual(result["copyRatios"]["swift"], 1.03)
        self.assertEqual(result["fwpOverPeer"]["swift"], 1)

    def test_missing_reordered_and_invalid_samples_fail(self):
        original = self.samples()
        cases = [original[:-1], original + [original[0]]]
        swapped = copy.deepcopy(original)
        swapped[0], swapped[1] = swapped[1], swapped[0]
        cases.append(swapped)
        for value in (0, -1, float("nan"), True):
            invalid = copy.deepcopy(original)
            invalid[0]["elapsedNs"] = value
            cases.append(invalid)
        for rows in cases:
            with self.subTest(first=rows[0]), self.assertRaises(AssertionError):
                PEERS.summarize(rows)


if __name__ == "__main__":
    unittest.main()
