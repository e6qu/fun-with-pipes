#!/usr/bin/env python3
"""Reject endpoint-only resize evidence and avoid duplicate nested-return costs."""
import copy
import unittest

from parser_native_allocator import check_parser_events


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
            record('internal-enter', function='mremap_chunk', chunk=old, adjustedBytes=size + 16)
            record('internal-return', function='mremap_chunk', pointer=address, chunk=new)
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


if __name__ == '__main__':
    unittest.main()
