#!/usr/bin/env python3
"""Reject missing attribution, hidden leaks and incorrect service outputs."""
import copy
import json
import unittest

from weak_callback_service import expected
from weak_callback_profiles import allocation_kind, check_costs, decode_case, decode_profiler_status


class Records(unittest.TestCase):
    def test_result(self):
        row = expected(64, 3)
        self.assertEqual(decode_case(json.dumps(row), 64, 3), row)
        for key in row:
            changed = dict(row)
            changed[key] = True if row[key] == 1 else row[key] + 1
            with self.assertRaises(AssertionError):
                decode_case(json.dumps(changed), 64, 3)

    def test_attribution(self):
        self.assertEqual(allocation_kind('main;service_run;malloc', 'c'), 'service')
        self.assertEqual(allocation_kind('main;printf;malloc', 'c'), 'outside')
        self.assertEqual(allocation_kind('_RNvCsabcd_21weak_callback_service11service_run;malloc', 'rs'), 'service')
        self.assertEqual(allocation_kind('$s19WeakCallbackService10serviceRunyAA5StatsVSi_SitF;swift_allocObject', 'swift'), 'service')
        self.assertEqual(allocation_kind('$s19WeakCallbackService10serviceRunyAA5StatsVSi_SitF;swift_getGenericMetadata;malloc', 'swift'), 'type-metadata')

    def test_profiler_statistics_are_validated(self):
        text = 'heaptrack stats:\n\tallocations:          \t70\n\tleaked allocations:   \t1\n\ttemporary allocations:\t0\n'
        self.assertEqual(decode_profiler_status(text, 70), dict(allocations=70,
            unreleasedAllocationCount=1, temporaryAllocationCount=0))
        for changed in (text + 'warning: unwinding incomplete\n', text.replace('70', '69'),
                        text.replace('\t1\n', '\t71\n'), text.replace('\t0\n', '\t71\n')):
            with self.subTest(changed=changed), self.assertRaises(AssertionError):
                decode_profiler_status(changed, 70)

    def test_release(self):
        ordinary = dict(service=dict(allocations=68, peak=9776, leaked=0),
                        **{'type-metadata': dict(allocations=0, peak=0, leaked=0)})
        check_costs(ordinary, 'c', 64, 'ordinary')
        for variant, leaked in (('omitted-payload-release', 8192), ('omitted-registration-release', 16)):
            changed = copy.deepcopy(ordinary)
            changed['service']['leaked'] = leaked
            check_costs(changed, 'c', 64, variant)
            with self.assertRaises(AssertionError):
                check_costs(changed, 'c', 64, 'ordinary')
        for field, value in (('allocations', 0), ('peak', 0), ('leaked', 1)):
            changed = copy.deepcopy(ordinary)
            changed['service'][field] = value
            with self.assertRaises(AssertionError):
                check_costs(changed, 'c', 64, 'ordinary')


if __name__ == '__main__':
    unittest.main()
