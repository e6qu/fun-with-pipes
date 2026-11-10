#!/usr/bin/env python3
"""Reject stale compiler hooks and ordinary-owner misclassification."""
import json
from pathlib import Path
import unittest

from resource_field_census import MARKER, PREFIX, decode, instrument, validate_contexts

ROOT = Path(__file__).resolve().parent.parent


class FieldCensus(unittest.TestCase):
    def test_observer_requires_the_exact_original_frame_boundary(self):
        source = (ROOT / 'src/cgen.rs').read_text()
        observed = instrument(source)
        self.assertEqual(observed.count(PREFIX), 1)
        self.assertIn('self.g.resource_type(ty)', observed)
        with self.assertRaises(AssertionError):
            instrument(observed)
        with self.assertRaises(AssertionError):
            instrument(source.replace(MARKER, ''))

    def test_reject_incomplete_duplicate_and_malformed_reports(self):
        row = dict(function=2, context=8, variable='t4', node='t5', variants=0,
                   fields=[dict(slot=0, observable=False, type='Array[I64]')])
        encoded = PREFIX + json.dumps(row) + '\n'
        self.assertEqual(decode(encoded), [row])
        for malformed in (encoded * 2, encoded + 'unexpected warning\n',
                          PREFIX + json.dumps(row | {'context': True}),
                          PREFIX + json.dumps(row | {'fields': []}),
                          PREFIX + json.dumps(row | {'variable': 't4; abort()'}),
                          PREFIX + json.dumps(row | {'fields': [row['fields'][0] | {'slot': True}]})):
            with self.subTest(malformed=malformed), self.assertRaises(AssertionError):
                decode(malformed)

    def test_reject_an_ordinary_owner_with_an_identical_field(self):
        row = dict(function=2, context=8, variable='t4', node='t5', variants=0,
                   fields=[dict(slot=0, observable=False, type='Array[I64]')])
        declaration = 'fwp_owner_ctx8 t4 = {0};\n'
        release = 'static void fwp_owner_release8(void *arg) {}\n'
        ending = 'fwp_cleanup_pop(&t5); fwp_owner_release8(&t4);'
        ordinary = release + declaration + ending
        with self.assertRaisesRegex(AssertionError, 'not an original resource frame'):
            validate_contexts(ordinary, [row])
        original = release + declaration + '/* original resource frame */ ' + ending
        self.assertEqual(validate_contexts(original, [row]),
                         dict(frames=1, fields=1, plainFields=1, variants=0))
        with self.assertRaises(AssertionError):
            validate_contexts(original + declaration, [row])


if __name__ == '__main__':
    unittest.main()
