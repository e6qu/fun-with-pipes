#!/usr/bin/env python3
"""Reject altered numeric observations and preserve failed acceptance limits."""
import copy
import gzip
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
import tarfile
import unittest

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('array_evidence', ROOT / 'scripts/check-array-list-evidence.py')
CHECK = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CHECK)
SOURCE = 'dc0a6407b5e5aa23517a86db71a3221a418cc7d6'
REPORT = json.loads(gzip.decompress((ROOT / 'docs/measurements/array-list-first-2026-10-31-amd-2.json.gz').read_bytes()))


class Evidence(unittest.TestCase):
    def test_retained_reports_preserve_both_failed_and_repaired_decisions(self):
        archives = [
            ('dc0a6407', SOURCE, 'array-lists-first',
             {('x86_64', 2): 20, ('aarch64', 2): 20},
             '0fb471b4743980b3c5a886513fa273cd9e8042d40282e62e80715b24a493a293'),
            ('9a2e954e', '9a2e954e1526b510f11025aa256dda74692cac53', 'array-lists-repaired',
             {('x86_64', 2): 0, ('aarch64', 2): 0},
             'a83aa024e11318cb2f65af151ec70271089b0449226f8093408ae0761e22c607'),
            ('9d47a5fc', '9d47a5fcfb5c9342d9fca9da2a8c162f5ac1d38c', 'swift-allocations',
             {('x86_64', 1): 1, ('x86_64', 2): 0, ('aarch64', 1): 0, ('aarch64', 2): 0},
             '095c3ff58d5901c31cd94f26ac3309eaa1c05c652d063460689793d866ce884c'),
            ('f7f5309c', 'f7f5309c2de142149adc47e35da081c90c1adcc6', 'array-lists-pure-constructors',
             {('x86_64', 1): 0, ('x86_64', 2): 1, ('aarch64', 1): 0, ('aarch64', 2): 0},
             'fe662ed86f19b06476c1806ba47c0843aaf4463dcc8fcea9dc59f626769e087d'),
        ]
        for short, source, tag, expected, checksum in archives:
            with self.subTest(source=source):
                path = ROOT / f'docs/measurements/array-lists-{short}.tar.xz'
                self.assertEqual(hashlib.sha256(path.read_bytes()).hexdigest(), checksum)
                self.assertEqual(subprocess.check_output(
                    ['git', 'rev-parse', f'roadmap/{tag}-2026-11-01'],
                    cwd=ROOT, text=True).strip(), source)
                audits, reports = {}, {}
                with tarfile.open(path, 'r|xz') as archive:
                    for member in archive:
                        relative = Path(member.name)
                        self.assertFalse(relative.is_absolute() or '..' in relative.parts)
                        if not member.isfile():
                            self.assertTrue(member.isdir())
                            continue
                        if relative.name.startswith('audit-') and relative.suffix == '.json':
                            record = json.load(archive.extractfile(member))
                            audits[(record['architecture'], record['session'])] = record
                        elif relative.name == 'comparison.json':
                            raw = archive.extractfile(member).read()
                            report = json.loads(raw)
                            reports[(report['machine'], report['configuration']['session'])] = (report, CHECK.digest(raw))
                self.assertEqual(set(reports), set(expected))
                self.assertEqual(set(audits), set(reports))
                for key, (report, raw_hash) in reports.items():
                    CHECK.GROUPS.check_report(report, source, 'array-lists')
                    decision = CHECK.GROUPS.DESCENT.paired_budget_failures(report['results'], 'array-lists')
                    audit = audits[key]
                    self.assertEqual((audit['source'], audit['session']), (source, key[1]))
                    self.assertEqual(audit['files']['comparison.json']['sha256'], raw_hash)
                    self.assertEqual(audit['budgetFailures'], decision)
                    self.assertEqual(len(decision), expected[key])
                    self.assertEqual(audit['decision'], 'not-accepted' if expected[key] else 'accepted')

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

    def test_repeated_outputs_match_the_analytic_oracle(self):
        expected = REPORT['results']['3-1']['oracle']
        output = (json.dumps(expected) + '\n').encode() * 2
        CHECK.GROUPS.DESCENT.verify(output, expected, 2)
        wrong = [expected[0] + 1, *expected[1:]]
        for changed in (b'', output[:-1].splitlines()[0],
                        (json.dumps(wrong) + '\n').encode() * 2,
                        b'[NaN, 0, 0]\n' * 2):
            with self.subTest(changed=changed), self.assertRaises(AssertionError):
                CHECK.GROUPS.DESCENT.verify(changed, expected, 2)

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
