#!/usr/bin/env python3
"""Check the six-label schedule's counts, positions and preceding processes."""
from collections import Counter
import importlib.util
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location('unique_buffer_baselines', Path(__file__).with_name('unique-buffer-baselines.py'))
BASELINE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(BASELINE)


class BufferSchedule(unittest.TestCase):
    def test_each_language_and_its_copy_get_equal_positions_and_predecessors(self):
        orders = [BASELINE.execution_order(i, BASELINE.SEED, BASELINE.PROCESSES)
                  for i in range(BASELINE.ROUNDS)]
        for order in orders:
            self.assertEqual(len(order), 72)
            self.assertEqual(Counter(order), {label: 12 for label in BASELINE.LABELS})
        for position in range(72):
            self.assertEqual(Counter(order[position] for order in orders),
                             {label: 6 for label in BASELINE.LABELS})
        pairs = Counter(pair for order in orders for pair in zip(order, order[1:]))
        self.assertEqual(pairs, {(a, b): 71 for a in BASELINE.LABELS for b in BASELINE.LABELS})
        # Between-round transitions are retained in evidence but not balanced.
        self.assertEqual(sum(pairs.values()), 36 * 71)

    def test_changed_counts_and_incomplete_rotation_range_are_rejected(self):
        for count in [0, 1, 6, 18, 24]:
            with self.subTest(count=count), self.assertRaises(AssertionError):
                BASELINE.execution_order(0, BASELINE.SEED, count)
        for index in [-1, 36, 72]:
            with self.subTest(index=index), self.assertRaises(AssertionError):
                BASELINE.execution_order(index, BASELINE.SEED, BASELINE.PROCESSES)


if __name__ == '__main__':
    unittest.main()
