"""Allocator attribution must detect incomplete traces and omitted release."""
import copy
import importlib.util
from pathlib import Path
import tempfile
import unittest

SPEC = importlib.util.spec_from_file_location('swift_allocations', Path(__file__).with_name('profile-swift-allocations.py'))
PROFILE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PROFILE)


class AllocationRecords(unittest.TestCase):
    def test_unwinding_must_walk_callers_with_the_selected_library(self):
        record = dict(selectedLibrary='/chosen/libunwind.so.8', selected=dict(
            libraries='libunwind.so.8 => /chosen/libunwind.so.8',
            observation=dict(frames=4, steps=3, stepStatus=0, contextStatus=0, initStatus=0, pageBytes=4096)))
        PROFILE.check_unwinding(record)
        for key, value in [('frames', 0), ('steps', 0), ('stepStatus', -10), ('initStatus', -1)]:
            changed = copy.deepcopy(record)
            changed['selected']['observation'][key] = value
            with self.subTest(key=key), self.assertRaises(AssertionError):
                PROFILE.check_unwinding(changed)
        record['selected']['libraries'] = 'libunwind.so.8 => /system/libunwind.so.8'
        with self.assertRaises(AssertionError):
            PROFILE.check_unwinding(record)

    def test_recompute_and_reject_incomplete_stack_counts(self):
        with tempfile.TemporaryDirectory() as temporary:
            folder = Path(temporary)
            (folder / 'allocations.txt').write_text('calls to allocation functions: 7 (100/s)\n')
            (folder / 'allocations.stacks').write_text('main;allocate_control 3\nruntime;malloc 4\n')
            (folder / 'peak.stacks').write_text('main;allocate_control 3145731\nruntime;malloc 100\n')
            (folder / 'leaked.stacks').write_text('main;allocate_control 0\nruntime;malloc 20\n')
            result = PROFILE.summarize(folder)
            self.assertEqual(result['totals'], dict(allocations=7, peak=3145831, leaked=20))
            self.assertEqual(result['control'], dict(allocations=3, peak=3145731, leaked=0))
            for damaged in ('main;allocate_control 3\n', '', 'main;allocate_control -3\n', 'main;allocate_control nan\n'):
                (folder / 'allocations.stacks').write_text(damaged)
                with self.subTest(damaged=damaged), self.assertRaises(AssertionError):
                    PROFILE.summarize(folder)

    def test_omitted_release_and_missing_allocations_cannot_pass(self):
        ordinary = dict(control=dict(allocations=3, peak=3145731, leaked=0))
        omitted = dict(control=dict(allocations=3, peak=3145731, leaked=1048578))
        PROFILE.check_control(ordinary, omitted)
        for key, value in [('allocations', 2), ('peak', 3145730), ('leaked', 0)]:
            changed = copy.deepcopy(omitted)
            changed['control'][key] = value
            with self.subTest(key=key), self.assertRaises(AssertionError):
                PROFILE.check_control(ordinary, changed)
        with self.assertRaises(AssertionError):
            PROFILE.check_control(omitted, omitted)


if __name__ == '__main__':
    unittest.main()
