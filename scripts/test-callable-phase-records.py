"""Preserve workload identity and reject noisy, short or damaged phase records."""
import copy
import hashlib
import json
import importlib.util
from pathlib import Path
import unittest
import zipfile

SPEC = importlib.util.spec_from_file_location("phases", Path(__file__).with_name("measure-callable-phases.py"))
PHASE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PHASE)


class PhaseRecords(unittest.TestCase):
    def samples(self):
        return [dict(round=r, position=p, label=label,
                     ns=dict(construction=10_000_000, invocation=100_000_000,
                             release=10_000_000, process=130_000_000))
                for r in range(PHASE.ROUNDS) for p, label in enumerate(PHASE.order(r))]

    def test_schedule_balances_positions_and_predecessors(self):
        positions = {label: [0] * 10 for label in PHASE.LABELS}
        predecessors = {}
        for r in range(10):
            row = PHASE.order(r)
            self.assertEqual(set(row), set(PHASE.LABELS))
            for p, label in enumerate(row):
                positions[label][p] += 1
            for pair in zip(row, row[1:]):
                predecessors[pair] = predecessors.get(pair, 0) + 1
        self.assertTrue(all(row == [1] * 10 for row in positions.values()))
        self.assertEqual(len(predecessors), 90)
        self.assertEqual(set(predecessors.values()), {1})

    def test_noise_and_short_phase_cannot_qualify(self):
        rows = self.samples()
        self.assertTrue(PHASE.summarize(rows)["invocation"]["candidateQualified"])
        for row in rows:
            if row["label"] == "reference-copy":
                row["ns"]["invocation"] = 103_000_000
        self.assertFalse(PHASE.summarize(rows)["invocation"]["candidateQualified"])
        rows = self.samples()
        for row in rows:
            row["ns"]["release"] = 1000
        self.assertFalse(PHASE.summarize(rows)["release"]["candidateQualified"])

    def test_cheap_peer_release_does_not_hide_candidate_result(self):
        rows = self.samples()
        for row in rows:
            if row["label"].startswith("c"):
                row["ns"]["release"] = 1000
        result = PHASE.summarize(rows)["release"]
        self.assertTrue(result["candidateQualified"])
        self.assertFalse(result["peerQualified"]["c"])

    def test_missing_reordered_impossible_and_noninteger_times_fail(self):
        rows = self.samples()
        for damaged in (rows[:-1], [rows[1], rows[0], *rows[2:]]):
            with self.assertRaises(AssertionError):
                PHASE.summarize(damaged)
        for bad in (0, -1, True, float("nan"), 200_000_000):
            damaged = copy.deepcopy(rows)
            damaged[0]["ns"]["invocation"] = bad
            with self.subTest(value=bad), self.assertRaises(AssertionError):
                PHASE.summarize(damaged)

    def test_wrong_checksum_and_output_shape_fail(self):
        n, cycles, passes = PHASE.INPUT
        checksum = cycles * (passes * (n * (n - 1) // 2 + 7 * n) + n * passes * (passes - 1) // 2)
        output = f"{checksum} 10 20 30\n"
        self.assertEqual(PHASE.parse_output(output, 0), dict(construction=10, invocation=20, release=30))
        for text in (output + output, output.replace(" 10", " 0"), "0 10 20 30\n"):
            with self.assertRaises(AssertionError):
                PHASE.parse_output(text, 0)
        with self.assertRaises(AssertionError):
            PHASE.parse_output(output, 1)

    def test_first_results_keep_failed_and_inconclusive_phases(self):
        path = PHASE.ROOT / "docs/measurements/callable-phases-2026-10-31.json"
        self.assertEqual(hashlib.sha256(path.read_bytes()).hexdigest(), "c475a20e3f86e4fff8f2a599b0c191d46090a02cea45564a102946ad7ce8ae98")
        data = json.loads(path.read_text())
        self.assertEqual(data["source"], "dfb6ff8e8aac215009e9a9cf48a8bce492ef4eae")
        sessions = {(row["architecture"], row["session"]): row for row in data["sessions"]}
        self.assertEqual(set(sessions), {(arch, i) for arch in ("aarch64", "x86_64") for i in (1, 2)})
        for arch in ("aarch64", "x86_64"):
            model = lambda row: [line for line in row["cpu"].splitlines() if line.startswith("Model name:")]
            self.assertEqual(model(sessions[arch, 1]), model(sessions[arch, 2]))
        outcomes = []
        for session in sessions.values():
            self.assertEqual([row["kind"] for row in session["cases"]], [0, 1])
            for case in session["cases"]:
                self.assertEqual(set(case["phases"]), set(PHASE.PHASES))
                for phase, row in case["phases"].items():
                    medians = row["medianNs"]
                    self.assertEqual(set(medians), set(PHASE.LABELS))
                    copies = {p: max(medians[p], medians[p + "-copy"]) / min(medians[p], medians[p + "-copy"])
                              for p in PHASE.PEERS}
                    self.assertEqual(row["copyRatios"], copies)
                    self.assertEqual(row["fwpOverPeer"], {p: medians["fwp"] / medians[p] for p in PHASE.PEERS[:-1]})
                    qualified = all(copies[p] <= 1.02 for p in ("reference", "fwp")) and all(
                        medians[p] >= 5_000_000 for p in ("reference", "reference-copy", "fwp", "fwp-copy"))
                    self.assertEqual(row["candidateQualified"], qualified)
                    self.assertEqual(row["withinBudget"],
                                     row["fwpOverPeer"]["reference"] <= (0.95 if phase == "invocation" else 1.02) if qualified else None)
                    if session["architecture"] == "aarch64":
                        self.assertIs(row["withinBudget"], True)
                    outcomes.append(row["withinBudget"])
                memory = case["memory"]
                self.assertLessEqual(max(v["peakRssKiB"] for v in memory["fwp"]),
                                     max(v["peakRssKiB"] for v in memory["reference"]) + 1024)
        self.assertEqual(sum(v is True for v in outcomes), 26)
        self.assertEqual(sum(v is False for v in outcomes), 3)
        self.assertEqual(sum(v is None for v in outcomes), 3)

    def test_complete_compiler_reports_preserve_identical_constructor_bodies(self):
        artifacts = {
            "amd64": (62, "6b1db9f6bc396ca1ae36fbb898b81457a9c470563fd0e0ac2e565c76bc495f5b"),
            "arm64": (183, "70a16a4006f5e669ad32fe43a7c2e2c1e36ea0d923eb2f917dddc09a8de4cd80"),
        }
        names = ("returned_make", "fwp_heap_alloc", "fwp_heap_alloc_slow",
                 "fwp_heap_refill", "fwp_rc_forget_slot", "fwp_mem_free")
        for arch, (machine, expected) in artifacts.items():
            path = PHASE.ROOT / f"docs/measurements/callable-construction-{arch}-2026-10-31.zip"
            self.assertEqual(hashlib.sha256(path.read_bytes()).hexdigest(), expected)
            with zipfile.ZipFile(path) as archive:
                report = json.loads(archive.read("report.json"))
                self.assertEqual(report["source"], "dfb6ff8e8aac215009e9a9cf48a8bce492ef4eae")
                self.assertEqual(report["session"], 2)
                functions = {}
                for peer in ("reference", "fwp"):
                    obj = archive.read(peer + ".o")
                    self.assertEqual(obj[:6], b"\x7fELF\x02\x01")
                    self.assertEqual(int.from_bytes(obj[16:18], "little"), 1)
                    self.assertEqual(int.from_bytes(obj[18:20], "little"), machine)
                    records = report["results"][peer]
                    self.assertEqual(hashlib.sha256(obj).hexdigest(), records["objectSha256"])
                    for extension, field in (("inline", "inlineSha256"), ("optimized", "optimizedSha256")):
                        data = archive.read(peer + "." + extension + ".txt")
                        self.assertEqual(hashlib.sha256(data).hexdigest(), records[field])
                    text = archive.read(peer + ".optimized.txt").decode()
                    functions[peer] = {section.split(" ", 1)[0]: section for section in text.split(";; Function ")[1:]}
                for name in names:
                    self.assertIn(name, functions["reference"])
                    self.assertIn(name, functions["fwp"])
                    self.assertEqual(functions["reference"][name], functions["fwp"][name])

    def test_reference_requires_exactly_one_real_guard(self):
        runtime = (PHASE.ROOT / "runtime/fwp_rt_heap.c").read_text()
        ref = PHASE.reference(runtime)
        self.assertEqual(ref, runtime.replace(PHASE.FAST_PATH, "if (0) {", 1))
        for code in (runtime.replace(PHASE.FAST_PATH, "if (1) {"), runtime + PHASE.FAST_PATH):
            with self.assertRaises(ValueError):
                PHASE.reference(code)


if __name__ == "__main__":
    unittest.main()
