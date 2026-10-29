#!/usr/bin/env python3
"""Reject missing sessions, changed results and self-consistent timing edits."""
import copy
import gzip
import importlib.util
import json
from pathlib import Path
import statistics
import tempfile
import unittest

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('kernel_evidence', ROOT / 'scripts/check-kernel-baselines.py')
CHECK = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CHECK)
ARCHIVE = ROOT / 'docs/measurements/kernel-baselines-artifacts-2026-10-29.json'
INDEX = json.loads(ARCHIVE.read_text())
SESSION = INDEX['sessions'][0]
REPORT = json.loads(gzip.decompress((ARCHIVE.parent / SESSION['report']).read_bytes()))


def check(report):
    CHECK.check_report(report, SESSION['source'], SESSION['architecture'], SESSION['session'])


class Evidence(unittest.TestCase):
    def test_failed_recheck_cannot_hide_its_noise_failures(self):
        path = ROOT / 'docs/measurements/kernel-recheck-2026-10-29-amd-2.json.gz'
        report = json.loads(gzip.decompress(path.read_bytes()))
        row = report['results']['matrix-65-67-63']
        expected = [dict(case='matrix-65-67-63', metric=metric,
                         ratio=row['identicalRatios'][metric], limit=1.02) for metric in CHECK.METRICS]
        self.assertEqual(report['failures'], expected)
        for hide_failures in [False, True]:
            changed = copy.deepcopy(report)
            if hide_failures:
                changed['failures'] = []
            with self.assertRaises(AssertionError):
                CHECK.check_report(changed, report['source'], 'amd64', 2)

    def test_initial_sessions_do_not_establish_complete_coverage(self):
        CHECK.check_archive(ARCHIVE, 'initial-arm')
        with self.assertRaises(AssertionError):
            CHECK.check_archive(ARCHIVE, 'complete')

    def test_changed_or_missing_measurements_fail(self):
        for change in ['case', 'round', 'sample', 'label', 'result', 'live-owner', 'timer', 'host']:
            with self.subTest(change=change):
                report = copy.deepcopy(REPORT)
                row = report['results']['array-65537']
                observation = row['observations'][2]['observations'][0]
                if change == 'case':
                    del report['results']['matrix-257-259-255']
                elif change == 'round':
                    row['observations'].pop()
                elif change == 'sample':
                    observation['samples'].pop()
                elif change == 'label':
                    observation['label'] = 'c' if observation['label'] != 'c' else 'rust'
                elif change == 'result':
                    observation['samples'][0]['hash'] = '0000000000000000'
                elif change == 'live-owner':
                    row['profiles']['fwp'][0]['liveChargedBytes'] = 8
                elif change == 'timer':
                    observation['samples'][0]['kernelNs'] = observation['samples'][0]['allocationInclusiveNs'] + 1
                else:
                    for field in ['actual', 'expected']:
                        report['qualification'][field]['cpu'] = 'Different CPU'
                with self.assertRaises(AssertionError):
                    check(report)

    def test_noise_fails_even_when_derived_totals_are_consistent(self):
        report = copy.deepcopy(REPORT)
        row = report['results']['array-65537']
        label = 'fwp-identical'
        for record in row['observations']:
            for observation in record['observations']:
                if observation['label'] == label:
                    for sample in observation['samples']:
                        for metric in CHECK.METRICS:
                            sample[metric] *= 2
        for metric in CHECK.METRICS:
            row['totals'][label][metric] = [v * 2 for v in row['totals'][label][metric]]
            row['medians'][label][metric] = statistics.median(row['totals'][label][metric])
            times = [row['medians'][l][metric] for l in ['fwp', label]]
            row['identicalRatios'][metric] = max(times) / min(times)
        with self.assertRaises(AssertionError):
            check(report)

    def test_archive_identity_and_raw_evidence_are_required(self):
        for change in ['missing-session', 'duplicate-job', 'source', 'log', 'binary', 'round', 'oracle']:
            with self.subTest(change=change), tempfile.TemporaryDirectory() as directory:
                archive = copy.deepcopy(INDEX)
                for session in archive['sessions']:
                    for kind in ['report', 'log']:
                        session[kind] = str(ARCHIVE.parent / session[kind])
                session = archive['sessions'][1]
                if change == 'missing-session':
                    archive['sessions'].pop()
                elif change == 'duplicate-job':
                    for key in ['job', 'jobMetadata']:
                        session[key] = archive['sessions'][0][key]
                elif change == 'source':
                    session['source'] = 'changed'
                elif change == 'log':
                    session['logSha256'] = 'changed'
                else:
                    name = {'binary': 'fwp-timing', 'round': 'sample-0.json', 'oracle': 'expected-values.txt'}[change]
                    session['files']['array-65537/' + name]['sha256'] = 'changed'
                path = Path(directory) / 'index.json'
                path.write_text(json.dumps(archive))
                with self.assertRaises(AssertionError):
                    CHECK.check_archive(path, 'initial-arm')


if __name__ == '__main__':
    unittest.main()
