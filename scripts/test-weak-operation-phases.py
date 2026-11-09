#!/usr/bin/env python3
"""Reject misleading live/expired counts and malformed phase observations."""
import importlib.util
import json
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location('weak_operation_checks', Path(__file__).with_name('check-weak-operation-phases.py'))
CHECKS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CHECKS)


class WeakResults(unittest.TestCase):
    def row(self):
        return dict(live=1024, expired=0, **{phase: 100 for phase in CHECKS.PHASES})

    def test_exact_result(self):
        row = self.row()
        self.assertEqual(CHECKS.decode_output(json.dumps(row, separators=(',', ':')) + '\n', 64, 16, 1), row)

    def test_wrong_counts_cannot_cancel_each_other(self):
        row = self.row()
        row.update(live=1023, expired=1)
        with self.assertRaises(AssertionError):
            CHECKS.decode_output(json.dumps(row, separators=(',', ':')) + '\n', 64, 16, 1)

    def test_malformed_or_missing_observations(self):
        variants = []
        for field in ('live', 'expired', *CHECKS.PHASES):
            for value in (-1, True, 1.5):
                row = self.row()
                row[field] = value
                variants.append(json.dumps(row, separators=(',', ':')) + '\n')
            row = self.row()
            del row[field]
            variants.append(json.dumps(row, separators=(',', ':')) + '\n')
        valid = json.dumps(self.row(), separators=(',', ':')) + '\n'
        variants += [valid.replace('"live":1024', '"live":0,"live":1024'), valid + '\n']
        for value in variants:
            with self.subTest(value=value), self.assertRaises(AssertionError):
                CHECKS.decode_output(value, 64, 16, 1)


if __name__ == '__main__':
    unittest.main()
