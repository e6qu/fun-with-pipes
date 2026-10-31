"""Check paired observations and zero-work agreement independently of copies."""
import copy
import unittest

from callable_context import ROUNDS, order
from callable_paired import parse, summarize


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


if __name__ == "__main__":
    unittest.main()
