#!/usr/bin/env python3
"""Reject relabeled hosts, changed timings and omitted derivative evidence."""
import copy
import gzip
import hashlib
import importlib.util
import json
from pathlib import Path
import statistics
import tempfile
import unittest

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('groups', ROOT / 'scripts/check-descent-groups.py')
CHECK = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CHECK)
SOURCE = 'b1ca235415d4d2caabdb4f568d9300cf50a59400'
REPORT = json.loads(gzip.decompress((ROOT / 'docs/measurements/descent-groups-2026-10-29-arm-1.json.gz').read_bytes()))
REPEATED_SOURCE = 'a31f24c4fdc215383cc61d95f6f6d743e66cb1a3'
REPEATED = json.loads(gzip.decompress((ROOT / 'docs/measurements/descent-repeated-2026-10-29-amd-2.json.gz').read_bytes()))

RECORDING_ARCHIVE = ROOT / 'docs/measurements/descent-recording-artifacts-2026-10-29.json'
CAPTURE_ARCHIVE = ROOT / 'docs/measurements/eager-captures-artifacts-2026-10-29.json'


class Evidence(unittest.TestCase):
    def test_eager_capture_comparison_preserves_all_four_sessions(self):
        CHECK.check_archive(CAPTURE_ARCHIVE, 'eager-captures')

    def test_eager_capture_archive_rejects_missing_or_changed_evidence(self):
        for change in ['session', 'source', 'run', 'reference', 'decision', 'copied-job', 'samples', 'source-hash']:
            with self.subTest(change=change), tempfile.TemporaryDirectory() as directory:
                archive = json.loads(CAPTURE_ARCHIVE.read_text())
                for session in archive['sessions'].values():
                    for kind in ['report', 'log']:
                        session[kind] = str(CAPTURE_ARCHIVE.parent / session[kind])
                session = archive['sessions']['arm-2']
                if change == 'session':
                    del archive['sessions']['arm-2']
                elif change == 'source':
                    session['source'] = 'changed'
                elif change == 'run':
                    session['run'] += 1
                elif change == 'reference':
                    session['referenceFiles']['fwp']['sha256'] = 'changed'
                elif change == 'decision':
                    archive['decision'] = 'not-accepted'
                elif change == 'copied-job':
                    session['job'] = archive['sessions']['arm-1']['job']
                else:
                    report = json.loads(gzip.decompress(Path(session['report']).read_bytes()))
                    if change == 'samples':
                        report['results']['3-1']['samplesNs']['fwp-ad'].pop()
                    else:
                        report['sourceHashes']['src/cgen.rs'] = 'changed'
                    raw = json.dumps(report).encode()
                    path = Path(directory) / 'report.json.gz'
                    path.write_bytes(gzip.compress(raw, mtime=0))
                    session['report'] = str(path)
                    session['reportBytes'] = len(raw)
                    session['reportSha256'] = hashlib.sha256(raw).hexdigest()
                    session['files']['comparison.json']['sha256'] = session['reportSha256']
                path = Path(directory) / 'index.json'
                path.write_text(json.dumps(archive))
                with self.assertRaises(AssertionError):
                    CHECK.check_archive(path, 'eager-captures')

    def test_rejected_recording_retains_all_four_sessions_and_failures(self):
        CHECK.check_archive(RECORDING_ARCHIVE, 'recording')

    def test_rejected_recording_cannot_be_relabeled_or_hide_failed_limits(self):
        for change in ['decision', 'failures', 'reference']:
            archive = json.loads(RECORDING_ARCHIVE.read_text())
            for session in archive['sessions'].values():
                for kind in ['report', 'log']:
                    session[kind] = str(RECORDING_ARCHIVE.parent / session[kind])
            if change == 'decision':
                archive['decision'] = 'accepted'
            elif change == 'failures':
                archive['sessions']['arm-1']['budgetFailures'] = []
            else:
                archive['sessions']['arm-1']['referenceFiles']['fwp']['sha256'] = 'changed'
            with tempfile.TemporaryDirectory() as directory:
                path = Path(directory) / 'index.json'
                path.write_text(json.dumps(archive))
                with self.assertRaises(AssertionError):
                    CHECK.check_archive(path, 'recording')

    def test_all_original_grouped_observations(self):
        CHECK.check_report(REPORT, SOURCE, 'grouped')

    def test_repeated_solve_baseline_meets_fixed_noise_limit(self):
        CHECK.check_report(REPEATED, REPEATED_SOURCE, 'repeated')

    def test_rejects_noisy_repeated_solve_control_even_with_consistent_medians(self):
        report = copy.deepcopy(REPEATED)
        row = report['results']['3-1']
        label = 'fwp-ad-identical'
        row['samplesNs'][label] = [value * 2 for value in row['samplesNs'][label]]
        row['medianNs'][label] = statistics.median(row['samplesNs'][label])
        for program, ratios in row['ratios'].items():
            for peer in ratios:
                ratios[peer] = row['medianNs'][program] / row['medianNs'][peer]
        with self.assertRaises(AssertionError):
            CHECK.check_report(report, REPEATED_SOURCE, 'repeated')

    def test_rejects_changed_cpu_even_if_expected_was_changed_too(self):
        report = copy.deepcopy(REPORT)
        for field in ['actual', 'expected']:
            report['qualification'][field]['cpu'] = 'Different CPU'
        with self.assertRaises(AssertionError):
            CHECK.check_report(report, SOURCE, 'grouped')

    def test_rejects_relabeling_process_groups_as_repeated_solves(self):
        with self.assertRaises(AssertionError):
            CHECK.check_report(REPORT, SOURCE, 'repeated')

    def test_rejects_omitted_noisy_round_and_changed_median(self):
        for field in ['orders', 'samplesNs']:
            report = copy.deepcopy(REPORT)
            row = report['results']['3-199']
            if field == 'orders':
                row[field].pop()
            else:
                row[field]['fwp-ad'].pop()
            with self.assertRaises(AssertionError):
                CHECK.check_report(report, SOURCE, 'grouped')
        report = copy.deepcopy(REPORT)
        report['results']['3-199']['medianNs']['fwp-ad'] = 1
        with self.assertRaises(AssertionError):
            CHECK.check_report(report, SOURCE, 'grouped')

    def test_rejects_missing_retirement_or_live_storage(self):
        for change in ['retirement', 'storage']:
            report = copy.deepcopy(REPORT)
            row = report['results']['129-199']
            if change == 'retirement':
                row['phaseObservations']['fwp-ad']['observations'].pop()
            else:
                row['fwpProfiles']['fwp-ad']['rawDerivativeStorage']['finalBytes'] = 8
            with self.assertRaises(AssertionError):
                CHECK.check_report(report, SOURCE, 'grouped')


if __name__ == '__main__':
    unittest.main()
