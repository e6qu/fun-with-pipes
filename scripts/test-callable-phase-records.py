"""Preserve workload identity and reject noisy, short or damaged phase records."""
import copy
import importlib.util
from pathlib import Path
import unittest

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

    def test_reference_requires_exactly_one_real_guard(self):
        runtime = (PHASE.ROOT / "runtime/fwp_rt_heap.c").read_text()
        ref = PHASE.reference(runtime)
        self.assertEqual(ref, runtime.replace(PHASE.FAST_PATH, "if (0) {", 1))
        for code in (runtime.replace(PHASE.FAST_PATH, "if (1) {"), runtime + PHASE.FAST_PATH):
            with self.assertRaises(ValueError):
                PHASE.reference(code)


if __name__ == "__main__":
    unittest.main()
