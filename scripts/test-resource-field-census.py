#!/usr/bin/env python3
"""Reject stale compiler hooks and ordinary-owner misclassification."""
import json
from pathlib import Path
import unittest

from resource_field_census import MARKER, PREFIX, decode, instrument, observe_holds, validate_contexts

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

    def test_reused_temporary_names_do_not_count_another_workers_owners(self):
        row = dict(function=2, context=8, variable='t4', node='t5', variants=0,
                   fields=[dict(slot=0, observable=False, type='Array[I64]')])
        other = '''static V other(V x) {
    fwp_owner_ctx9 t4 = {0};
    fwp_rc_dup(x); t4.v0 = x;
    return x;
}
'''
        source = '''typedef uint64_t V;
static void counters(void) { observed_retains++; observed_decrements++; }
static void fwp_owner_release8(void *arg) { fwp_owner_ctx8 *c = arg; drop_array(c->v0); }
static V worker(V x) {
    fwp_owner_ctx8 t4 = {0};
    fwp_rc_dup(x); t4.v0 = x;
    /* original resource frame */ fwp_cleanup_pop(&t5); fwp_owner_release8(&t4);
    return x;
}
''' + other + '''ServiceStats service_run(size_t population, int mode) {
    size_t baseline = fwp_heap.live;
    return result;
}
'''
        for control in (False, True):
            with self.subTest(control=control):
                observed, selected = observe_holds(source, [row], control)
                self.assertIn(other, observed)
                self.assertEqual(selected, [dict(context=8, slot=0, holdSites=1, drop='drop_array')])
                self.assertIn('FWP_PLAIN_HOLDS', observed)
                self.assertEqual('observed_extraPair = 1;' in observed, control)
        with self.assertRaisesRegex(AssertionError, 'missing field initialization'):
            observe_holds(source.replace('fwp_rc_dup(x); t4.v0 = x;', 't4.v0 = x;'), [row], False)


if __name__ == '__main__':
    unittest.main()
