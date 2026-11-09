#!/usr/bin/env python3
"""Reject biased pilots, reordered pairs and unsupported timing conclusions."""
from collections import Counter
import copy
import importlib.util
import json
from pathlib import Path
import unittest

from weak_callback_service import expected
from weak_callback_timing import BATCHES, DURATIONS, LABELS, ROUNDS, decode_output
from weak_callback_timing import order, select_pilot, summarize

SPEC = importlib.util.spec_from_file_location('weak_timing', Path(__file__).with_name('measure-weak-callback-service.py'))
MEASUREMENT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MEASUREMENT)


class ServiceTiming(unittest.TestCase):
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
            want = expected(64, 0)
            row = {key: value if key in ('population', 'mode') else value * batches for key, value in want.items()}
            row.update(batches=batches, serviceNs=duration)
            return dict(batches=batches, stdout=json.dumps(row, separators=(',', ':')) + '\n')

        good = [trial(16, 1), trial(64, 50_000_000)]
        self.assertEqual(select_pilot(good, 64, 0), 64)
        self.assertEqual(select_pilot([trial(batch, 1) for batch in BATCHES], 64, 0), 16384)
        for bad in ([], good[:1], good + [trial(256, 60_000_000)],
                    [trial(64, 50_000_000)], [trial(16, 50_000_000), trial(64, 50_000_000)]):
            with self.subTest(bad=bad), self.assertRaises(AssertionError):
                select_pilot(bad, 64, 0)

    def test_durations_have_independent_noise_limits(self):
        rows = [dict(round=round_number, position=position, label=label,
                     ns=dict(service=10_000_000, process=100_000_000))
                for round_number in range(ROUNDS) for position, label in enumerate(order(round_number))]
        self.assertTrue(all(row['peerQualified']['swift'] for row in summarize(rows).values()))
        noisy = copy.deepcopy(rows)
        for row in noisy:
            if row['label'] == 'swift-copy':
                row['ns']['service'] = 10_300_000
        result = summarize(noisy)
        self.assertFalse(result['service']['peerQualified']['swift'])
        self.assertTrue(result['service']['peerQualified']['c'])
        self.assertTrue(result['process']['peerQualified']['swift'])
        for duration in DURATIONS:
            for invalid in (-1, True, 1.5):
                bad = copy.deepcopy(rows)
                bad[0]['ns'][duration] = invalid
                with self.subTest(duration=duration, value=invalid), self.assertRaises(AssertionError):
                    summarize(bad)
        for bad in (rows[:-1], rows + rows, list(reversed(rows))):
            with self.assertRaises(AssertionError):
                summarize(bad)
        rows[0]['ns']['process'] = 1
        with self.assertRaises(AssertionError):
            summarize(rows)

    def test_complete_result_fields_and_batch_totals(self):
        row = expected(64, 3) | dict(batches=1, serviceNs=10)
        self.assertEqual(decode_output(json.dumps(row), 64, 3, 1), row)
        for key in row:
            changed = dict(row)
            changed[key] = True if key == 'serviceNs' else row[key] + 1
            with self.subTest(key=key), self.assertRaises(AssertionError):
                decode_output(json.dumps(changed), 64, 3, 1)


if __name__ == '__main__':
    unittest.main()
