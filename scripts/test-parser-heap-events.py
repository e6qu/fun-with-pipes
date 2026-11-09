#!/usr/bin/env python3
"""Check independent allocation balance, resize overlap and region boundaries."""
import copy
import unittest

from parser_heap_events import check_events


def sample():
    rows = []
    phase = 0
    live = peak = nodes = 0

    def checkpoint():
        rows.append(dict(event='checkpoint', phase=phase, heapLive=64 + live,
                         heapPeak=64 + peak, nodes=nodes, regionHeader=24))

    def allocation(kind, address, requested, charged):
        nonlocal live, peak
        live += charged if kind == 'allocate' else -charged
        peak = max(peak, live)
        rows.append(dict(event=kind, phase=phase, address=address, requested=requested,
                         charged=charged, heapLive=64 + live))

    def resize(kind, fresh):
        rows.append(dict(event=kind, phase=phase, old=4096, fresh=fresh, before=16, after=32))

    def region(kind, node, size, used):
        rows.append(dict(event=kind, phase=phase, block=8192, node=node,
                         bytes=size, used=used, capacity=232))

    checkpoint()
    allocation('allocate', 4096, 16, 16)
    resize('resize-begin', 0)
    allocation('allocate', 4112, 32, 32)
    resize('resize-copy', 4112)
    allocation('release', 4096, 0, 16)
    resize('resize-end', 4112)
    phase = 1
    checkpoint()
    allocation('allocate', 8192, 256, 256)
    region('block', 0, 24, 0)
    for offset, size in ((0, 16), (16, 16), (32, 24)):
        region('node', 8192 + 24 + offset, size, offset + size)
        nodes += 1
    phase = 2
    checkpoint()
    phase = 3
    checkpoint()
    region('block-release', 0, 24, 56)
    allocation('release', 8192, 0, 256)
    allocation('release', 4112, 0, 32)
    phase = 4
    checkpoint()
    return rows


class HeapEvents(unittest.TestCase):
    def test_slots_regions_and_real_resize_overlap_are_separate(self):
        result = check_events(sample(), 3)
        self.assertEqual((result['peakRequestedBytes'], result['peakChargedBytes']), (288, 288))
        self.assertEqual((result['regionRequestedBytes'], result['regionNodeBytes'], result['regionUnusedBytes']),
                         (256, 56, 176))
        self.assertEqual(result['resizes'][0]['chargedAtCopy'], 48)

    def test_missing_or_wrong_charge_is_not_accepted_as_runtime_balance(self):
        for mode in ('missing', 'wrong'):
            rows = sample()
            if mode == 'missing':
                del rows[1]
            else:
                rows[1]['charged'] += 16
            with self.subTest(mode=mode), self.assertRaises(AssertionError):
                check_events(rows, 3)

    def test_region_node_must_stay_inside_its_live_block(self):
        for key, delta in (('node', 8), ('bytes', 8), ('used', 8), ('capacity', 8)):
            rows = sample()
            next(row for row in rows if row['event'] == 'node')[key] += delta
            with self.subTest(key=key), self.assertRaises(AssertionError):
                check_events(rows, 3)

    def test_logical_release_does_not_prove_physical_release(self):
        rows = sample()
        rows = [row for row in rows if not (row['event'] == 'release' and row['address'] == 8192)]
        # Keep the changed stream internally consistent with an actual missing
        # free; only the final outstanding allocation proves the failure.
        rows[-2]['heapLive'] += 256
        rows[-1]['heapLive'] += 256
        with self.assertRaisesRegex(AssertionError, 'allocations remain live'):
            check_events(rows, 3)

    def test_old_resize_storage_must_exist_until_copy(self):
        rows = copy.deepcopy(sample())
        copy_index = next(i for i, row in enumerate(rows) if row['event'] == 'resize-copy')
        rows[copy_index], rows[copy_index + 1] = rows[copy_index + 1], rows[copy_index]
        with self.assertRaises(AssertionError):
            check_events(rows, 3)


if __name__ == '__main__':
    unittest.main()
