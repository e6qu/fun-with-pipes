"""Reject missing scalar-closure attribution and ineffective release controls."""
import importlib.util
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location('closure_profiles', Path(__file__).with_name('profile-swift-closures.py'))
PROFILE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PROFILE)


class ClosureRecords(unittest.TestCase):
    def test_release_requires_observed_factory_allocations_and_real_leaks(self):
        ordinary = dict(allocations=32, peak=128, leaked=0)
        omitted = dict(allocations=32, peak=128, leaked=1024)
        PROFILE.check_release(ordinary, omitted)
        for field, value in [('allocations', 0), ('allocations', 31), ('leaked', 0),
                             ('leaked', -1), ('allocations', True), ('peak', '128')]:
            changed = dict(omitted, **{field: value})
            with self.subTest(field=field, value=value), self.assertRaises(AssertionError):
                PROFILE.check_release(ordinary, changed)
        with self.assertRaises(AssertionError):
            PROFILE.check_release(dict(ordinary, leaked=1), omitted)
        with self.assertRaises(AssertionError):
            PROFILE.check_release(dict(ordinary, allocations=0), dict(omitted, allocations=0))

    def test_factory_peak_is_not_a_separate_whole_process_peak(self):
        # Global heap peak can precede the maximum of this one allocation stack.
        PROFILE.check_release(dict(allocations=32, peak=2048, leaked=0),
                              dict(allocations=32, peak=0, leaked=1024))


if __name__ == '__main__':
    unittest.main()
