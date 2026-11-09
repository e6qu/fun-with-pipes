#!/usr/bin/env python3
"""Keep service delivery independent from callbacks and preserve error boundaries."""
import json
from pathlib import Path
import unittest

from weak_callback_service import CASES, decode_output, expected, variants


class ServiceResults(unittest.TestCase):
    def test_delivery_and_error_boundaries(self):
        self.assertEqual(expected(64, 0)['sum'], 39936)
        self.assertEqual(expected(64, 1)['calls'], 48)
        self.assertEqual(expected(64, 3)['calls'], 33)
        self.assertEqual(expected(64, 3)['sum'], 12408)
        rows = [expected(*case) for case in CASES]
        self.assertEqual(decode_output('\n'.join(map(json.dumps, rows))), rows)
        for field in ('received', 'received_sum', 'cancelled', 'expired', 'errors', 'sent'):
            changed = [dict(row) for row in rows]
            changed[0][field] += 1
            with self.assertRaises(AssertionError):
                decode_output('\n'.join(map(json.dumps, changed)))

    def test_malformed_or_incomplete_records(self):
        output = '\n'.join(json.dumps(expected(*case)) for case in CASES)
        for changed in (output + '\n' + output, output.splitlines()[0],
                        output.replace('"calls": 64', '"calls": true', 1),
                        output.replace('"calls": 64', '"calls": 64, "calls": 64', 1)):
            with self.assertRaises(AssertionError):
                decode_output(changed)

    def test_faults_change_actual_operations(self):
        fixtures = Path(__file__).resolve().parent.parent / 'tests/fixtures'
        for language in ('c', 'rs', 'swift', 'fwp'):
            source = (fixtures / ('weak_callback_service.' + language)).read_text()
            changed = variants(language, source)
            self.assertEqual(len(changed), 4 if language == 'c' else 2)
            self.assertEqual(len(set(changed.values())), len(changed))


if __name__ == '__main__':
    unittest.main()
