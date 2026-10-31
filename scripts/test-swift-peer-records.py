"""Reject incomplete observations and expose identical-program timing noise."""
import copy
import importlib.util
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location("swift_peers", Path(__file__).with_name("measure-swift-peers.py"))
PEERS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PEERS)


class Records(unittest.TestCase):
    def samples(self):
        return [dict(round=r, position=p, label=label, elapsedNs=1000)
                for r in range(PEERS.ROUNDS) for p, label in enumerate(PEERS.order(r))]

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
