"""Check phase-context observations without relaxing the original experiment."""
import copy
import unittest

from callable_context import LABELS, ROUNDS, durations, order, summarize


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


if __name__ == "__main__":
    unittest.main()
