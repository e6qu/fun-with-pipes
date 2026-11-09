#!/usr/bin/env python3
"""Reject biased pilots, reordered pairs and unsupported timing conclusions."""
from collections import Counter
import copy
import importlib.util
import json
from pathlib import Path
import unittest

from weak_operation_phases import BATCHES, DURATIONS, LABELS, PHASES, ROUNDS
from weak_operation_phases import order, select_pilot, summarize

SPEC = importlib.util.spec_from_file_location('weak_timing', Path(__file__).with_name('measure-weak-operations.py'))
MEASUREMENT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MEASUREMENT)


class WeakTiming(unittest.TestCase):
    def test_balanced_positions_and_predecessors(self):
        for block in (0, 8):
            positions, pairs = Counter(), Counter()
            for round_number in range(block, block + 8):
                labels = order(round_number)
                self.assertEqual(set(labels), set(LABELS))
                positions.update(enumerate(labels))
                pairs.update(zip(labels, labels[1:]))
            self.assertEqual(set(positions.values()), {1})
            self.assertEqual(set(pairs), {(a, b) for a in LABELS for b in LABELS if a != b})
            self.assertEqual(set(pairs.values()), {1})

    def test_c_only_pilot_stops_at_first_threshold_or_cap(self):
        def trial(batches, duration):
            row = dict(live=64 * 16 * batches, expired=0, **{phase: 0 for phase in PHASES})
            row['liveLookup'] = duration
            return dict(batches=batches, stdout=json.dumps(row, separators=(',', ':')) + '\n')

        good = [trial(16, 1), trial(64, 50_000_000)]
        self.assertEqual(select_pilot(good, 64, 16), 64)
        self.assertEqual(select_pilot([trial(batch, 1) for batch in BATCHES], 64, 16), 1024)
        for bad in ([], good[:1], good + [trial(256, 60_000_000)],
                    [trial(64, 50_000_000)], [trial(16, 50_000_000), trial(64, 50_000_000)]):
            with self.subTest(bad=bad), self.assertRaises(AssertionError):
                select_pilot(bad, 64, 16)

    def test_each_phase_needs_its_own_duration_and_copy_control(self):
        rows = [dict(round=round_number, position=position, label=label,
                     ns={**{phase: 10_000_000 for phase in PHASES}, 'process': 100_000_000})
                for round_number in range(ROUNDS) for position, label in enumerate(order(round_number))]
        self.assertTrue(all(row['peerQualified']['swift'] for row in summarize(rows).values()))
        noisy = copy.deepcopy(rows)
        for row in noisy:
            row['ns']['weakRelease'] = 0
            if row['label'] == 'swift-copy':
                row['ns']['liveLookup'] = 10_300_000
        result = summarize(noisy)
        self.assertFalse(result['liveLookup']['peerQualified']['swift'])
        self.assertTrue(result['liveLookup']['peerQualified']['c'])
        self.assertFalse(result['weakRelease']['peerQualified']['c'])
        self.assertIsNone(result['weakRelease']['copyRatios']['c'])
        self.assertTrue(result['expiredLookup']['peerQualified']['swift'])
        for phase in DURATIONS:
            for invalid in (-1, True, 1.5):
                bad = copy.deepcopy(rows)
                bad[0]['ns'][phase] = invalid
                with self.subTest(phase=phase, value=invalid), self.assertRaises(AssertionError):
                    summarize(bad)
        for bad in (rows[:-1], rows + rows, list(reversed(rows))):
            with self.assertRaises(AssertionError):
                summarize(bad)
        rows[0]['ns']['process'] = 1
        with self.assertRaises(AssertionError):
            summarize(rows)


if __name__ == '__main__':
    unittest.main()
