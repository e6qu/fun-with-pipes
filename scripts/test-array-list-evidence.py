#!/usr/bin/env python3
"""Reject altered numeric observations and preserve failed acceptance limits."""
import copy
import gzip
import importlib.util
import json
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('array_evidence', ROOT / 'scripts/check-array-list-evidence.py')
CHECK = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CHECK)
SOURCE = 'dc0a6407b5e5aa23517a86db71a3221a418cc7d6'
REPORT = json.loads(gzip.decompress((ROOT / 'docs/measurements/array-list-first-2026-10-31-amd-2.json.gz').read_bytes()))


class Evidence(unittest.TestCase):
    def test_original_rejected_report_is_auditable_without_claiming_acceptance(self):
        CHECK.GROUPS.check_report(REPORT, SOURCE, 'array-lists')
        failures = CHECK.GROUPS.DESCENT.paired_budget_failures(REPORT['results'], 'array-lists')
        self.assertEqual(len(failures), 20)
        self.assertEqual({row['metric'] for row in failures}, {'requests', 'requestedBytes'})
        self.assertEqual({row['case'] for row in failures}, {'3-1', '3-199', '3-1999', '33-199', '129-199'})

    def test_missing_round_changed_median_or_relabeled_host_cannot_pass(self):
        for changed in ('round', 'median', 'host', 'protocol'):
            report = copy.deepcopy(REPORT)
            if changed == 'round':
                report['results']['3-1']['orders'].pop()
            elif changed == 'median':
                report['results']['3-1']['medianNs']['fwp-ad'] = 1
            elif changed == 'host':
                report['qualification']['actual']['cpu'] = 'replacement'
                report['qualification']['expected']['cpu'] = 'replacement'
            else:
                report['configuration']['comparison'] = 'scalar-recording'
            with self.subTest(changed=changed), self.assertRaises(AssertionError):
                CHECK.GROUPS.check_report(report, SOURCE, 'array-lists')

    def test_round_recomputes_totals_and_rejects_bad_process_observations(self):
        record = dict(complete=True, order=['a', 'b', 'a'], totalsNs=dict(a=8, b=4), observations=[
            dict(label=label, elapsedNs=4, status=0, stdoutSha256=label,
                 stderrSha256=CHECK.digest(b''), outputMatches=True) for label in ['a', 'b', 'a']])
        self.assertEqual(CHECK.check_round(record, record['order'], dict(a='a', b='b')), dict(a=8, b=4))
        for key, value in [('status', 1), ('elapsedNs', 0), ('stdoutSha256', 'wrong'), ('outputMatches', False)]:
            damaged = copy.deepcopy(record)
            damaged['observations'][0][key] = value
            with self.subTest(key=key), self.assertRaises(AssertionError):
                CHECK.check_round(damaged, record['order'], dict(a='a', b='b'))
        record['totalsNs']['a'] = 4
        with self.assertRaises(AssertionError):
            CHECK.check_round(record, record['order'], dict(a='a', b='b'))


if __name__ == '__main__':
    unittest.main()
