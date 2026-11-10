#!/usr/bin/env python3
"""Reject biased schedules, noisy copies, incomplete work and fabricated service durations."""
import copy
import unittest

from nested_resource_timing import LABELS, order, summarize
from weak_callback_timing import ROUNDS


class Timing(unittest.TestCase):
    def samples(self, ratio):
        return [dict(round=r, position=p, label=label,
                     ns=dict(service=int(10_000_000 * (ratio if label.startswith('candidate') else 1)),
                             process=20_000_000))
                for r in range(ROUNDS) for p, label in enumerate(order(r))]

    def test_balanced_positions_and_distinct_population_targets(self):
        for label in LABELS:
            self.assertEqual([sum(order(r)[p] == label for r in range(ROUNDS)) for p in range(4)], [4] * 4)
        self.assertTrue(summarize(self.samples(.89), 4096)['service']['timingTargetMet'])
        self.assertFalse(summarize(self.samples(.91), 4096)['service']['timingTargetMet'])
        self.assertTrue(summarize(self.samples(1.01), 64)['service']['timingTargetMet'])
        self.assertFalse(summarize(self.samples(1.021), 64)['service']['timingTargetMet'])

    def test_copy_noise_and_short_work_do_not_qualify(self):
        rows = self.samples(.8)
        for row in rows:
            if row['label'] == 'reference-copy':
                row['ns']['service'] = 10_300_000
        result = summarize(rows, 4096)['service']
        self.assertFalse(result['qualified'])
        self.assertFalse(result['timingTargetMet'])
        self.assertFalse(summarize(self.samples(.1), 4096)['service']['qualified'])

    def test_schedule_and_duration_corruption_are_rejected(self):
        rows = self.samples(.8)
        for bad in (rows[:-1], rows + rows, list(reversed(rows))):
            with self.assertRaises(AssertionError):
                summarize(bad, 4096)
        for field, value in (('service', -1), ('service', True), ('service', 20_000_001), ('process', 0)):
            bad = copy.deepcopy(rows)
            bad[0]['ns'][field] = value
            with self.subTest(field=field, value=value), self.assertRaises(AssertionError):
                summarize(bad, 4096)


if __name__ == '__main__':
    unittest.main()
