#!/usr/bin/env python3
"""Reject missing internal allocation/free evidence despite matching endpoints."""
import copy
import unittest

from parser_allocator_observation import check_observation


def observation():
    events = []
    for case, size, result in ((1, 72, 4096), (2, 8192, 16384), (3, 4096, 4096), (4, (1 << 64) - 1, 0)):
        events.append(dict(case=case, kind='resize-enter', pointer=4096, requested=size))
        if case == 2:
            events.extend([
                dict(case=case, kind='arena-resize-enter', oldChunk=4080, oldChunkBytes=144, adjustedNewBytes=8208),
                dict(case=case, kind='internal-allocation-enter', requested=8200),
                dict(case=case, kind='internal-allocation-return', pointer=16384),
                dict(case=case, kind='internal-free-enter', chunk=4080, releasesOld=True),
            ])
        events.append(dict(case=case, kind='resize-return', pointer=result))
    return dict(exitCode=0, errors=[], events=events,
                objects=[dict(path='/lib/libc.so.6', buildId='abc', debugOwner=None),
                         dict(path='/debug/abc.debug', buildId='abc', debugOwner='/lib/libc.so.6')],
                sourceLocations=[dict(function='_int_realloc', file='/malloc/malloc.c', line=1)])


class AllocatorObservation(unittest.TestCase):
    def test_real_overlap_boundary_required(self):
        report = observation()
        self.assertEqual(check_observation(report)['movingExternalRequestedOverlapBytes'], 8320)
        for removed in ('internal-allocation-enter', 'internal-allocation-return', 'internal-free-enter', 'arena-resize-enter'):
            changed = copy.deepcopy(report)
            changed['events'] = [row for row in changed['events'] if row['kind'] != removed]
            with self.assertRaises(AssertionError):
                check_observation(changed)
        changed = copy.deepcopy(report)
        changed['events'][5], changed['events'][6] = changed['events'][6], changed['events'][5]
        with self.assertRaises(AssertionError):
            check_observation(changed)

    def test_debug_identity_and_failed_execution(self):
        report = observation()
        report['objects'][1]['buildId'] = 'different'
        with self.assertRaises(AssertionError):
            check_observation(report)
        report = observation()
        report['errors'] = ['optimized argument unavailable']
        with self.assertRaises(AssertionError):
            check_observation(report)
        report = observation()
        report['events'][-1]['pointer'] = 8192
        with self.assertRaises(AssertionError):
            check_observation(report)


if __name__ == '__main__':
    unittest.main()
