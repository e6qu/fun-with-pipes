#!/usr/bin/env python3
"""Reject inconsistent slot counts, lost owners and malformed census records."""
import copy
import importlib.util
import json
from pathlib import Path
import unittest

from weak_operation_census import COSTS, decode_output

SPEC = importlib.util.spec_from_file_location('weak_census', Path(__file__).with_name('check-weak-operation-census.py'))
COLLECTOR = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(COLLECTOR)


class WeakCensus(unittest.TestCase):
    def observation(self):
        phases = [dict(zip(COSTS, values)) for values in (
            (1, 128, 0, 0, 128, 128), (1, 16, 0, 0, 144, 144),
            (1, 16, 1, 16, 144, 160), (0, 0, 0, 0, 16, 144),
            (0, 0, 0, 0, 16, 16), (0, 0, 0, 0, 0, 16))]
        return dict(population=1, lookups=1, live=1, expired=0, phases=phases)

    def test_complete_observation_and_unallocated_result(self):
        row = self.observation()
        self.assertEqual(decode_output(json.dumps(row, separators=(',', ':')) + '\n', 1, 1), row)
        row['phases'][2] = dict(zip(COSTS, (0, 0, 0, 0, 144, 144)))
        self.assertEqual(decode_output(json.dumps(row, separators=(',', ':')) + '\n', 1, 1), row)

    def test_inconsistent_observations(self):
        for phase, field, value in ((2, 'allocations', 0), (2, 'someAllocations', 2),
                                    (2, 'someSlotBytes', 17), (2, 'liveBytes', 0),
                                    (4, 'liveBytes', 0), (5, 'liveBytes', 1),
                                    (2, 'peakLiveBytes', 143)):
            row = self.observation()
            row['phases'][phase][field] = value
            with self.subTest(phase=phase, field=field), self.assertRaises(AssertionError):
                decode_output(json.dumps(row, separators=(',', ':')) + '\n', 1, 1)
        for field in COSTS:
            for value in (-1, True, 1.5):
                row = self.observation()
                row['phases'][0][field] = value
                with self.assertRaises(AssertionError):
                    decode_output(json.dumps(row, separators=(',', ':')) + '\n', 1, 1)

    def test_missing_duplicate_or_wrong_result(self):
        good = self.observation()
        for key, value in (('population', True), ('live', 0), ('expired', 1), ('phases', good['phases'][:-1])):
            row = copy.deepcopy(good)
            row[key] = value
            with self.assertRaises(AssertionError):
                decode_output(json.dumps(row, separators=(',', ':')) + '\n', 1, 1)
        text = json.dumps(good, separators=(',', ':')) + '\n'
        with self.assertRaises(AssertionError):
            decode_output(text.replace('{', '{"expired":0,', 1), 1, 1)


if __name__ == '__main__':
    unittest.main()
