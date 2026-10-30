#!/usr/bin/env python3
"""Resource observations must describe reaped children and reject invalid deltas."""
import importlib.util
from pathlib import Path
import resource
import subprocess
import sys
from types import SimpleNamespace
import unittest

SPEC = importlib.util.spec_from_file_location('timing_resources', Path(__file__).with_name('observe-timing-resources.py'))
OBSERVE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(OBSERVE)


class ResourceObservations(unittest.TestCase):
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
