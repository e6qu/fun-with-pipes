#!/usr/bin/env python3
"""Reject invalid compiler phase accounting and check independent case families."""
import copy
import json
from pathlib import Path
import tempfile
import unittest

from compiler_scaling import FAMILIES, cases, profile, program, resources


class CompilerScalingTests(unittest.TestCase):
    def test_distinct_families_and_independent_results(self):
        self.assertEqual(len(list(cases())), 12)
        for family, sizes in FAMILIES.items():
            previous = 0
            for size in sizes:
                source, expected = program(family, size)
                self.assertGreater(len(source), previous)
                previous = len(source)
                if family == 'definitions':
                    self.assertEqual(source.count(' : I64 -> I64'), size)
                    self.assertEqual(list(map(int, expected.split())), list(range(1, size + 1)))
                elif family == 'generic':
                    self.assertEqual(source.count('| keep |'), size)
                    for index in range(size):
                        self.assertIn(f'{{field{index} = {index}}}', source)
                    self.assertEqual(list(map(int, expected.split())), list(range(size)))
                else:
                    self.assertEqual(source.count('let '), size)
                    self.assertEqual(int(expected), size - 1)

    def test_profile_controls(self):
        parent = dict(id=0, phase='front-end', parent=None, start_ns=1, end_ns=8,
                      inclusive_ns=7, exclusive_ns=4, counts={})
        child = dict(id=1, phase='parse-input', parent=0, start_ns=2, end_ns=5,
                     inclusive_ns=3, exclusive_ns=3, counts={'source_bytes': 20})
        valid = dict(format='fwp-compile-profile', version=1, status=0, wall_ns=10,
                     unassigned_ns=3, phases=[parent, child])
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / 'report.json'
            path.write_text(json.dumps(valid))
            self.assertEqual(profile(path, 0), valid)
            for label, change in (
                ('double counted child', lambda x: x['phases'][0].update(exclusive_ns=7)),
                ('child outside parent', lambda x: x['phases'][1].update(start_ns=0, end_ns=3)),
                ('future parent', lambda x: x['phases'][0].update(parent=1)),
                ('lost time', lambda x: x.update(unassigned_ns=2)),
                ('wrong exit', lambda x: x.update(status=1)),
                ('debug compiler', lambda x: x['phases'][1].update(phase='debug-ownership-verification')),
            ):
                with self.subTest(label=label):
                    invalid = copy.deepcopy(valid)
                    change(invalid)
                    path.write_text(json.dumps(invalid))
                    with self.assertRaises(AssertionError):
                        profile(path, 0)

    def test_resource_scope(self):
        text = '\tMaximum resident set size (kbytes): 1234\n\tUser time (seconds): 0.10\n\tSystem time (seconds): 0.03\n'
        self.assertEqual(resources(text), dict(maxRssKiB=1234, userSeconds=.1, systemSeconds=.03))
        with self.assertRaises(ValueError):
            resources('')


if __name__ == '__main__':
    unittest.main()
