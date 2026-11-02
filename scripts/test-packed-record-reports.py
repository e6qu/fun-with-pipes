#!/usr/bin/env python3
"""Keep rejected timings, payload identities and published tables honest."""
import copy
import gzip
import importlib.util
import json
from pathlib import Path
import tempfile
import unittest

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('packed_reports', ROOT / 'scripts/report-packed-records.py')
REPORTS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REPORTS)
DIRECTORY = ROOT / 'docs/measurements/derivative-temporary-storage-2026-11-02'
FOLDER = DIRECTORY / 'timing/41514265188'
INDEX = json.loads(gzip.decompress((FOLDER / 'index.json.gz').read_bytes()))
SOURCE = INDEX['source']


class PackedReports(unittest.TestCase):
    def test_all_original_measured_outcomes_are_preserved(self):
        for label, session in INDEX['sessions'].items():
            if 'report' not in session:
                continue
            report = json.loads(REPORTS.payload(FOLDER, session, 'report'))
            checked = REPORTS.measured_session(FOLDER, label, session, SOURCE, report['sourceHashes'])
            self.assertEqual(checked, report)
            self.assertEqual(len(session['audit']['budgetFailures']), int(label == 'x86_64-2'))

    def test_failed_limit_cannot_be_removed_or_marked_accepted(self):
        original = INDEX['sessions']['x86_64-2']
        report = json.loads(REPORTS.payload(FOLDER, original, 'report'))
        for mutation in ['failures', 'decision', 'job']:
            session = copy.deepcopy(original)
            if mutation == 'failures':
                session['audit']['budgetFailures'] = []
            elif mutation == 'decision':
                session['decision'] = session['audit']['decision'] = 'accepted'
            else:
                session['job']['conclusion'] = 'success'
            with self.subTest(mutation=mutation), self.assertRaises(AssertionError):
                REPORTS.measured_session(FOLDER, 'x86_64-2', session, SOURCE, report['sourceHashes'])

    def test_binary_and_reference_identity_cannot_drift(self):
        original = INDEX['sessions']['aarch64-1']
        report = json.loads(REPORTS.payload(FOLDER, original, 'report'))
        for mutation in ['binary', 'patch', 'reference']:
            session = copy.deepcopy(original)
            if mutation == 'binary':
                session['audit']['files']['3-0/fwp-ad']['sha256'] = '0' * 64
            elif mutation == 'patch':
                session['referencePatch'] += '\nchanged\n'
            else:
                session['audit']['referenceFiles']['fwp']['sha256'] = '0' * 64
            with self.subTest(mutation=mutation), self.assertRaises(AssertionError):
                REPORTS.measured_session(FOLDER, 'aarch64-1', session, SOURCE, report['sourceHashes'])

    def test_payload_path_size_and_digest_are_checked(self):
        original = INDEX['sessions']['aarch64-1']
        for mutation in ['path', 'size', 'digest']:
            session = copy.deepcopy(original)
            if mutation == 'path':
                session['log'] = '../' + session['log']
            elif mutation == 'size':
                session['logBytes'] += 1
            else:
                session['logSha256'] = '0' * 64
            with self.subTest(mutation=mutation), self.assertRaises(AssertionError):
                REPORTS.payload(FOLDER, session, 'log')

    def test_changed_median_fails_even_with_updated_payload_hashes(self):
        session = copy.deepcopy(INDEX['sessions']['aarch64-1'])
        report = json.loads(REPORTS.payload(FOLDER, session, 'report'))
        report['results']['3-0']['medianNs']['fwp-ad'] += 1
        raw = json.dumps(report).encode()
        session['reportBytes'] = len(raw)
        session['reportSha256'] = REPORTS.CHECK.digest(raw)
        session['audit']['files']['comparison.json'] = dict(bytes=len(raw), sha256=session['reportSha256'])
        with tempfile.TemporaryDirectory() as temporary:
            folder = Path(temporary)
            (folder / session['report']).write_bytes(gzip.compress(raw))
            with self.assertRaises(AssertionError):
                REPORTS.measured_session(folder, 'aarch64-1', session, SOURCE, report['sourceHashes'])


if __name__ == '__main__':
    unittest.main()
