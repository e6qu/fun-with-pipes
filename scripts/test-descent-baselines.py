#!/usr/bin/env python3
"""Reject incomplete or relabeled derivative observations."""
import copy
import gzip
import importlib.util
import json
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('baselines', ROOT / 'scripts/check-descent-baselines.py')
CHECK = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CHECK)
SOURCE = '21a1de329c8e4cec1b9ba7cd284c9be876facf5c'
REPORT = json.loads(gzip.decompress((ROOT / 'docs/measurements/descent-baseline-2026-10-29-arm-1.json.gz').read_bytes()))


class Completeness(unittest.TestCase):
    def test_original_observations(self):
        CHECK.check_report(REPORT, SOURCE)

    def test_missing_case(self):
        report = copy.deepcopy(REPORT)
        del report['results']['3-0']
        with self.assertRaises(AssertionError):
            CHECK.check_report(report, SOURCE)

    def test_changed_timing_claim(self):
        report = copy.deepcopy(REPORT)
        report['results']['129-199']['ratios']['fwp-ad']['c-explicit'] = 1.0
        with self.assertRaises(AssertionError):
            CHECK.check_report(report, SOURCE)

    def test_missing_phase(self):
        report = copy.deepcopy(REPORT)
        report['results']['3-1']['phaseObservations']['fwp-ad']['observations'].pop()
        with self.assertRaises(AssertionError):
            CHECK.check_report(report, SOURCE)

    def test_unobserved_release_failure(self):
        report = copy.deepcopy(REPORT)
        report['results']['3-1']['controls']['missing-parent-free']['status'] = 0
        with self.assertRaises(AssertionError):
            CHECK.check_report(report, SOURCE)

    def test_retained_storage(self):
        report = copy.deepcopy(REPORT)
        report['results']['129-199']['fwpProfiles']['fwp-ad']['rawDerivativeStorage']['finalBytes'] = 8
        with self.assertRaises(AssertionError):
            CHECK.check_report(report, SOURCE)


if __name__ == '__main__':
    unittest.main()
