#!/usr/bin/env python3
"""Keep published timing normalization and memory peaks distinct."""
import importlib.util
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location('reporter', Path(__file__).with_name('report-current-kernels.py'))
REPORT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REPORT)


class CurrentKernelReport(unittest.TestCase):
    def test_round_totals_are_normalized_by_actual_calculation_count(self):
        row = dict(medians=dict(fwp=dict(kernelNs=81920)))
        self.assertEqual(REPORT.time_per_calculation(row, 'array-65537', 'kernelNs', 'fwp'), 512)
        self.assertEqual(REPORT.time_per_calculation(row, 'matrix-65-67-63', 'kernelNs', 'fwp'), 8)

    def test_total_requests_and_simultaneous_peak_use_different_divisors(self):
        self.assertEqual(REPORT.span([8192, 8192], 8 * 1024), '1.000')
        self.assertEqual(REPORT.span([8192, 16384], 1024), '8.000–16.000')
        self.assertEqual(REPORT.span([0, 0], 1), '0.000')


if __name__ == '__main__':
    unittest.main()
