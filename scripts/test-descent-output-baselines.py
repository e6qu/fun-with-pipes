#!/usr/bin/env python3
"""Prevent noisy output comparisons or failed cleanup from becoming passing claims."""
import copy
import gzip
import importlib.util
import json
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('output_baselines', ROOT / 'scripts/check-descent-output-baselines.py')
CHECK = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CHECK)
SOURCE = '21a1de329c8e4cec1b9ba7cd284c9be876facf5c'
REPORT = json.loads(gzip.decompress((ROOT / 'docs/measurements/descent-output-current-2026-10-29-amd-1.json.gz').read_bytes()))


class Controls(unittest.TestCase):
    def test_original_with_visible_noise(self):
        CHECK.check_report(REPORT, SOURCE)
        self.assertFalse(REPORT['results']['3-0']['controlsWithinBound']['sink'])

    def test_noise_must_not_be_reclassified(self):
        report = copy.deepcopy(REPORT)
        report['results']['3-0']['controlsWithinBound']['sink'] = True
        with self.assertRaises(AssertionError):
            CHECK.check_report(report, SOURCE)

    def test_budget_must_not_be_relaxed(self):
        report = copy.deepcopy(REPORT)
        report['configuration']['control_max_difference'] = .10
        with self.assertRaises(AssertionError):
            CHECK.check_report(report, SOURCE)

    def test_missing_release_control_is_rejected(self):
        report = copy.deepcopy(REPORT)
        del report['results']['33-199']['controls']['c-sink-missing-release']
        with self.assertRaises(AssertionError):
            CHECK.check_report(report, SOURCE)

    def test_changed_result_consumption_is_rejected(self):
        report = copy.deepcopy(REPORT)
        control = report['results']['33-199']['controls']['fwp-sink']
        control['omittedLast'] = control['expected']
        with self.assertRaises(AssertionError):
            CHECK.check_report(report, SOURCE)


if __name__ == '__main__':
    unittest.main()
