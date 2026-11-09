#!/usr/bin/env python3
"""Reject endpoint-only resize evidence and avoid duplicate nested-return costs."""
import copy
import unittest

from parser_native_allocator import check_allocation_events, check_parser_events


def observation(path, duplicate, omit_release):
    events = []
    phase = serial = 0

    def record(kind, **values):
        events.append(dict(kind=kind, phase=phase, operation=None if kind == 'checkpoint' else serial,
                           thread=[1, 1, 0], **values))

    def layout(address, size, mapped):
        return dict(address=address, bytes=size + 16, mapped=mapped)

    def acquire(address, size, mapped):
        nonlocal serial
        serial += 1
        block = layout(address, size, mapped)
        record('api-enter', function='__libc_malloc', requested=size)
        record('internal-enter', function='_int_malloc', requested=size)
        record('internal-return', function='_int_malloc', pointer=address + 16, chunk=block)
        record('api-return', function='__libc_malloc', pointer=address + 16, chunk=block)
        return block

    def resize(old, size, address, selected_path):
        nonlocal serial
        serial += 1
        new = layout(address, size, old['mapped'])
        record('api-enter', function='__libc_realloc', pointer=old['address'] + 16, chunk=old, requested=size)
        if selected_path == 'mapped':
            mapping = dict(address=old['address'], oldBytes=old['bytes'], newBytes=new['bytes'], flags=1)
            record('internal-enter', function='__mremap', mapping=mapping)
            record('internal-return', function='__mremap', pointer=address, chunk=None, mapping=mapping)
        elif selected_path in ('move', 'retry'):
            if selected_path == 'retry':
                record('internal-enter', function='_int_realloc', chunk=old, oldBytes=old['bytes'], adjustedBytes=size + 16)
                record('internal-return', function='_int_realloc', pointer=0, chunk=None)
            record('internal-enter', function='_int_malloc', requested=size)
            record('internal-return', function='_int_malloc', pointer=address + 16, chunk=new)
            if duplicate:
                record('internal-return', function='__libc_malloc', pointer=address + 16, chunk=new)
            record('internal-enter', function='_int_free', chunk=old)
        record('api-return', function='__libc_realloc', pointer=address + 16, chunk=new)
        return new

    def release(block):
        nonlocal serial
        serial += 1
        record('api-enter', function='__libc_free', pointer=block['address'] + 16, chunk=block)
        record('internal-enter', function='munmap_chunk' if block['mapped'] else '_int_free', chunk=block)
        record('api-return', function='__libc_free', pointer=None, chunk=None)

    record('checkpoint')
    tokens = acquire(4096, 128, False)
    tokens = resize(tokens, 256, 4096, 'in-place')
    phase = 1
    record('checkpoint')
    nodes = acquire(8192, 192, path == 'mapped')
    nodes = resize(nodes, 384, 8192 if path == 'in-place' else 16384, path)
    phase = 2
    record('checkpoint')
    phase = 3
    record('checkpoint')
    if not omit_release:
        release(nodes)
    release(tokens)
    phase = 4
    record('checkpoint')
    return dict(events=events, exitCode=0, errors=[], chunkHeaderBytes=16,
        sourceLocations=[dict(file='/malloc/malloc.c', line=1)],
        objects=[dict(path='/lib/libc.so.6', buildId='abc', debugOwner=None),
                 dict(path='/debug/abc.debug', buildId='abc', debugOwner='/lib/libc.so.6')])


class NativeAllocator(unittest.TestCase):
    def test_actual_overlap_and_nested_returns(self):
        for duplicate in (False, True):
            result = check_parser_events(observation('move', duplicate, False), 16)
            self.assertEqual(result['endpointRequestedPeakBytes'], 640)
            self.assertEqual(result['requestedPeakWithObservedResizeOverlapBytes'], 832)
            self.assertEqual(result['observedOwnedChunkPeakBytes'], 880)
            self.assertEqual(result['operations'][3]['path'], 'arena-move')

    def test_remap_and_in_place_do_not_invent_overlap(self):
        for path in ('mapped', 'in-place'):
            result = check_parser_events(observation(path, False, False), 16)
            self.assertEqual(result['requestedPeakWithObservedResizeOverlapBytes'], 640)
            self.assertEqual(result['observedOwnedChunkPeakBytes'], 672)

    def test_retry_replacement_uses_actual_allocation_before_release(self):
        result = check_parser_events(observation('retry', True, False), 16)
        self.assertEqual(result['operations'][3]['path'], 'arena-retry-copy')
        self.assertEqual(result['observedOwnedChunkPeakBytes'], 880)

    def test_failed_remap_then_copy_counts_both_live_allocations(self):
        report = observation('move', False, False)
        for row in report['events']:
            if row.get('chunk') is not None and row['chunk']['address'] == 8192:
                row['chunk']['mapped'] = True
            if row['operation'] == 4 and row.get('function') == '_int_free':
                row['function'] = 'munmap_chunk'
        start = next(i for i, row in enumerate(report['events'])
                     if row['operation'] == 4 and row['kind'] == 'api-enter')
        original = report['events'][start]
        mapping = dict(address=8192, oldBytes=208, newBytes=400, flags=1)
        report['events'][start + 1:start + 1] = [
            dict(original, kind='internal-enter', function='__mremap', mapping=mapping),
            dict(original, kind='internal-return', function='__mremap', pointer=(1 << 64) - 1, chunk=None, mapping=mapping),
        ]
        result = check_parser_events(report, 16)
        self.assertEqual(result['operations'][3]['path'], 'mapped-copy')
        self.assertEqual(result['requestedPeakWithObservedResizeOverlapBytes'], 832)
        self.assertEqual(result['observedOwnedChunkPeakBytes'], 880)
        del report['events'][start + 2]
        with self.assertRaisesRegex(AssertionError, 'mapped resize lacks its actual return'):
            check_parser_events(report, 16)

    def test_allocator_metadata_cannot_be_counted_as_parser_storage(self):
        report = observation('move', False, False)
        extra = dict(report['events'][2], kind='internal-return', pointer=65552,
                     chunk=dict(address=65536, bytes=656, mapped=False))
        report['events'].insert(3, extra)
        with self.assertRaisesRegex(AssertionError, 'unattributed allocator-internal storage'):
            check_parser_events(report, 16)

    def test_missing_and_reordered_internal_events(self):
        original = observation('move', False, False)
        for kind in ('internal-return', 'internal-enter'):
            changed = copy.deepcopy(original)
            changed['events'] = [row for row in changed['events']
                                 if not (row['operation'] == 4 and row['kind'] == kind)]
            with self.subTest(kind=kind), self.assertRaises(AssertionError):
                check_parser_events(changed, 16)
        changed = copy.deepcopy(original)
        indices = [index for index, row in enumerate(changed['events'])
                   if row['operation'] == 4 and (row['kind'] == 'internal-return' or row.get('function') == '_int_free')]
        first, second = indices
        changed['events'][first], changed['events'][second] = changed['events'][second], changed['events'][first]
        with self.assertRaisesRegex(AssertionError, 'allocation-before-release'):
            check_parser_events(changed, 16)

    def test_missing_release_and_changed_vector_work(self):
        with self.assertRaisesRegex(AssertionError, 'allocations remain live'):
            check_parser_events(observation('move', False, True), 16)
        with self.assertRaisesRegex(AssertionError, 'vector ledger'):
            check_parser_events(observation('move', False, False), 8)

    def test_control_thread_transfer_does_not_relax_parser_contract(self):
        report = observation('retry', True, False)
        for row in report['events']:
            if row['phase'] >= 1:
                row['thread'] = [1, 2, 0]
        expected = [[0, 128], [128, 256], [0, 192], [192, 384], [384, 0], [256, 0]]
        result = check_allocation_events(report, expected, 2)
        self.assertEqual(result['operations'][3]['path'], 'arena-retry-copy')
        with self.assertRaises(AssertionError):
            check_parser_events(report, 16)
        next(row for row in report['events'] if row['kind'] == 'internal-return')['thread'] = [1, 2, 0]
        with self.assertRaises(AssertionError):
            check_allocation_events(report, expected, 2)


if __name__ == '__main__':
    unittest.main()
