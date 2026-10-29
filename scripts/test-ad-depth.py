#!/usr/bin/env python3
"""Reject omitted derivative cases, missing typed cleanup and changed evidence."""
import copy
import gzip
import importlib.util
import json
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('depth_checks', ROOT / 'scripts/check-ad-depth.py')
CHECK = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CHECK)
ARCHIVE = json.loads((ROOT / 'docs/measurements/ad-depth-recording-artifacts-2026-10-29.json').read_text())
SESSION = ARCHIVE['sessions']['arm']
REPORT = json.loads(gzip.decompress((ROOT / 'docs/measurements' / SESSION['report']).read_bytes()))


class DepthEvidence(unittest.TestCase):
    def test_original_complete_report(self):
        CHECK.check_report(REPORT, SESSION['files'], ARCHIVE['source'], 'aarch64')

    def test_reuse_follows_c_configuration_not_an_unused_environment_variable(self):
        report = copy.deepcopy(REPORT)
        del report['settings']['FWP_REUSE']
        report['cflags'].append('-UFWP_NO_REUSE')
        CHECK.check_report(report, SESSION['files'], ARCHIVE['source'], 'aarch64')
        report['cflags'].append('-DFWP_NO_REUSE=1')
        with self.assertRaises(AssertionError):
            CHECK.check_report(report, SESSION['files'], ARCHIVE['source'], 'aarch64')

    def test_omitted_case_and_typed_retirement_are_rejected(self):
        for missing in ['case', 'retirement']:
            report = copy.deepcopy(REPORT)
            if missing == 'case':
                del report['results']['F128-depth3-n128']
            else:
                report['results']['F128-depth1-n1']['programs']['ad']['raw']['rawDerivativeStorage']['afterBackward'] = []
            with self.assertRaises(AssertionError):
                CHECK.check_report(report, SESSION['files'], ARCHIVE['source'], 'aarch64')

    def test_live_storage_in_either_ledger_is_rejected(self):
        for ledger in ['managed', 'raw']:
            report = copy.deepcopy(REPORT)
            program = report['results']['F128-depth3-n128']['programs']['ad']
            if ledger == 'managed':
                program['managed']['finalChargedBytes'] = 8
            else:
                program['raw']['rawDerivativeStorage']['finalBytes'] = 8
            with self.assertRaises(AssertionError):
                CHECK.check_report(report, SESSION['files'], ARCHIVE['source'], 'aarch64')

    def test_changed_image_or_timed_output_is_rejected(self):
        for name in ['F64-depth1-n1-ad', 'F64-depth1-n1-ad-sample-11.stdout']:
            files = copy.deepcopy(SESSION['files'])
            files[name]['sha256'] = 'changed'
            with self.assertRaises(AssertionError):
                CHECK.check_report(REPORT, files, ARCHIVE['source'], 'aarch64')


if __name__ == '__main__':
    unittest.main()
