#!/usr/bin/env python3
"""Resource observations must describe reaped children and reject invalid deltas."""
from collections import Counter
import importlib.util
import os
from pathlib import Path
import resource
import subprocess
import sys
import tempfile
from types import SimpleNamespace
import unittest

SPEC = importlib.util.spec_from_file_location('timing_resources', Path(__file__).with_name('observe-timing-resources.py'))
OBSERVE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(OBSERVE)


class ResourceObservations(unittest.TestCase):
    def test_equal_bytes_are_not_enough_to_establish_a_shared_file(self):
        with tempfile.TemporaryDirectory() as directory:
            named, equal = [Path(directory) / name for name in ['candidate-reference.exe', 'slot0exe']]
            named.write_bytes(b'unchanged diagnostic program')
            os.link(named, equal)
            identity = OBSERVE.validate_links(named, equal)
            self.assertEqual(identity['inode'], named.stat().st_ino)
            self.assertEqual(equal.read_bytes(), named.read_bytes())
            equal.unlink()
            equal.write_bytes(named.read_bytes())
            with self.assertRaisesRegex(AssertionError, 'not the same executable'):
                OBSERVE.validate_links(named, equal)
            equal.unlink()
            equal.symlink_to(named)
            with self.assertRaises(AssertionError):
                OBSERVE.validate_links(named, equal)

    def test_every_role_receives_both_policies_in_balanced_first_positions(self):
        first, observations = Counter(), Counter()
        for index in range(16):
            policies = OBSERVE.naming_order('paired', index)
            self.assertEqual(set(policies), {'named', 'equal'})
            first[policies[0]] += 1
            for policy in policies:
                for label in OBSERVE.DIAGNOSTIC.SCHEDULE.execution_order(index, 20261029, 4):
                    observations[policy, label] += 1
        self.assertEqual(first, Counter(named=8, equal=8))
        self.assertEqual(observations, Counter({(policy, label): 64
            for policy in ['named', 'equal'] for label in OBSERVE.DIAGNOSTIC.SCHEDULE.LABELS}))
        for selection, index in [('implicit', 0), ('paired', -1), ('named', True)]:
            with self.subTest(selection=selection, index=index), self.assertRaises(AssertionError):
                OBSERVE.naming_order(selection, index)

    def test_reaped_child_records_cpu_and_faults(self):
        before = resource.getrusage(resource.RUSAGE_CHILDREN)
        subprocess.run([sys.executable, '-c', 'print(sum(range(10000)))'], capture_output=True, check=True)
        actual = OBSERVE.resource_delta(before, resource.getrusage(resource.RUSAGE_CHILDREN))
        self.assertGreater(actual['userSeconds'] + actual['systemSeconds'], 0)
        self.assertGreater(actual['minorFaults'], 0)

    def test_counter_reset_is_rejected_instead_of_becoming_negative_work(self):
        for field in OBSERVE.FIELDS.values():
            before = SimpleNamespace(**dict.fromkeys(OBSERVE.FIELDS.values(), 2))
            after = SimpleNamespace(**dict.fromkeys(OBSERVE.FIELDS.values(), 2))
            setattr(after, field, 1)
            with self.subTest(field=field), self.assertRaises(AssertionError):
                OBSERVE.resource_delta(before, after)


if __name__ == '__main__':
    unittest.main()
