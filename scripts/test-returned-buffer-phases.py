"""Reject malformed phase records before deriving any performance result."""
from collections import Counter
import copy
import importlib.util
import json
from pathlib import Path
import unittest

from returned_buffer_phases import BATCHES, LABELS, PHASES, ROUNDS, decode_output, order, select_pilot, summarize

# Import the collector too: CI must catch syntax/import errors before any pilot.
SPEC = importlib.util.spec_from_file_location('buffer_measurement', Path(__file__).with_name('measure-returned-buffers.py'))
MEASUREMENT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MEASUREMENT)


class PhaseRecords(unittest.TestCase):
    def test_balanced_positions_and_predecessors(self):
        for block in (0, 8):
            positions = Counter()
            pairs = Counter()
            for round_number in range(block, block + 8):
                labels = order(round_number)
                self.assertEqual(set(labels), set(LABELS))
                positions.update(enumerate(labels))
                pairs.update(zip(labels, labels[1:]))
            self.assertEqual(set(positions.values()), {1})
            self.assertEqual(set(pairs), {(a, b) for a in LABELS for b in LABELS if a != b})
            self.assertEqual(set(pairs.values()), {1})

    def test_first_qualifying_pilot_and_cap(self):
        def trial(batches, construction):
            row = dict(checksum=120 * 4096 * batches, construction=construction, reading=0, release=0)
            return dict(batches=batches, stdout=json.dumps(row, separators=(',', ':')) + '\n')

        good = [trial(16, 1), trial(64, 50_000_000)]
        self.assertEqual(select_pilot(good, 16, 4096, 0), 64)
        capped = [trial(batch, 1) for batch in BATCHES]
        self.assertEqual(select_pilot(capped, 16, 4096, 0), 1024)
        for bad in ([], good[:1], good + [trial(256, 60_000_000)],
                    [trial(64, 50_000_000)], [trial(16, 50_000_000), trial(64, 50_000_000)]):
            with self.subTest(bad=bad), self.assertRaises(AssertionError):
                select_pilot(bad, 16, 4096, 0)

    def test_noisy_or_short_release_does_not_qualify_or_hide_reading(self):
        rows = [dict(round=round_number, position=position, label=label,
                     ns=dict(construction=10_000_000, reading=20_000_000,
                             release=0, process=40_000_000))
                for round_number in range(ROUNDS) for position, label in enumerate(order(round_number))]
        summary = summarize(rows)
        self.assertTrue(summary['reading']['peerQualified']['swift'])
        self.assertFalse(summary['release']['peerQualified']['swift'])
        self.assertIsNone(summary['release']['copyRatios']['swift'])
        noisy = copy.deepcopy(rows)
        for row in noisy:
            if row['label'] == 'swift-copy':
                row['ns']['reading'] = 20_500_000
        summary = summarize(noisy)
        self.assertFalse(summary['reading']['peerQualified']['swift'])
        self.assertTrue(summary['reading']['peerQualified']['c'])
        for phase in PHASES:
            damaged = copy.deepcopy(rows)
            damaged[0]['ns'][phase] = -1
            with self.assertRaises(AssertionError):
                summarize(damaged)
        for damaged in (rows[:-1], list(reversed(rows)), rows + rows):
            with self.assertRaises(AssertionError):
                summarize(damaged)

    def test_exact_checksum_and_nonnegative_integer_phases(self):
        for shared in (0, 1):
            valid = dict(checksum=7864320 * (shared + 1), construction=10, reading=20, release=0)
            text = json.dumps(valid, separators=(',', ':')) + '\n'
            self.assertEqual(decode_output(text, 16, 4096, 16, shared), valid)
            for key in valid:
                for value in (-1, True, 1.0, '1', None):
                    damaged = dict(valid, **{key: value})
                    with self.subTest(shared=shared, key=key, value=value), self.assertRaises(AssertionError):
                        decode_output(json.dumps(damaged, separators=(',', ':')) + '\n', 16, 4096, 16, shared)
            for damaged in (dict(valid, checksum=1), dict(valid, process=20),
                            {key: value for key, value in valid.items() if key != 'release'}):
                with self.assertRaises(AssertionError):
                    decode_output(json.dumps(damaged, separators=(',', ':')) + '\n', 16, 4096, 16, shared)
            with self.assertRaises(AssertionError):
                decode_output(text.replace('{', '{"release":0,', 1), 16, 4096, 16, shared)
            with self.assertRaises((AssertionError, ValueError)):
                decode_output(text + text, 16, 4096, 16, shared)


if __name__ == '__main__':
    unittest.main()
