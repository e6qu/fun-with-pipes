#!/usr/bin/env python3
"""Reject inconsistent counts and changed observation boundaries before native measurement."""
import gzip
import json
from pathlib import Path
import unittest

from nested_resource_counts import compare, decode, instrument
from weak_callback_source import boundary

ROOT = Path(__file__).resolve().parent.parent


class Counts(unittest.TestCase):
    def test_instrument_real_retained_service_and_reject_changed_boundaries(self):
        path = ROOT / 'docs/measurements/service-cpu-attribution-2026-11-10/original.c.gz'
        original = boundary(gzip.decompress(path.read_bytes()).decode())
        observed = instrument(original)
        for name in ('pushes', 'pops', 'unwinds', 'dupCalls', 'dropCalls', 'releaseCalls', 'retains', 'decrements'):
            self.assertEqual(observed.count('observed_' + name + '++;'), 1)
        for marker in ('static inline void fwp_rc_dup(V v) {', '    size_t baseline = fwp_heap.live;'):
            with self.subTest(marker=marker), self.assertRaises(AssertionError):
                instrument(original.replace(marker, marker + marker))
        with self.assertRaises(AssertionError):
            instrument(observed)

    def test_counts_require_balanced_cleanup_and_physical_release(self):
        row = dict(pushes=100, pops=90, unwinds=10, dupCalls=80, dropCalls=25,
                   releaseCalls=40, retains=70, decrements=60, requests=10, requestedBytes=100,
                   initialLiveBytes=16, finalLiveBytes=16, peakChargedBytes=116)
        self.assertEqual(decode(json.dumps(row)), row)
        for field, value in (('pushes', 99), ('finalLiveBytes', 32), ('retains', 81),
                             ('decrements', 66), ('requests', 0), ('peakChargedBytes', 0),
                             ('pops', True)):
            with self.subTest(field=field), self.assertRaises(AssertionError):
                decode(json.dumps(row | {field: value}))
        candidate = row | dict(pushes=80, pops=70)
        self.assertTrue(compare(row, candidate)['cleanupTargetMet'])
        self.assertFalse(compare(row, row)['cleanupTargetMet'])
        for field in ('requests', 'requestedBytes', 'peakChargedBytes'):
            with self.subTest(field=field), self.assertRaises(AssertionError):
                compare(row, candidate | {field: row[field] + 1})


if __name__ == '__main__':
    unittest.main()
