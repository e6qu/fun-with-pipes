#!/usr/bin/env python3
"""Reject incomplete or inconsistent ownership-operation evidence."""

import copy
import importlib.util
import json
from pathlib import Path
import unittest


SPEC = importlib.util.spec_from_file_location(
    'arc_costs', Path(__file__).with_name('measure-arc-costs.py'))
ARC = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(ARC)
SUMMARY = ARC.module('summarize-arc-costs')


class Evidence(unittest.TestCase):
    def setUp(self):
        self.sites = [dict(operation='dup'), dict(operation='release_last')]
        self.managed = dict(requests=1, requestedBytes=16, retains=2,
                            peakChargedBytes=16, finalChargedBytes=0)
        self.rows = ['ownership-site\t0\t3\t2\t0', 'ownership-site\t1\t3\t3\t1']

    def evidence(self, rows, managed):
        return ('\n'.join(rows + [json.dumps(managed)]) + '\n').encode()

    def test_complete_counts(self):
        result = ARC.parse_profile(self.evidence(self.rows, self.managed), self.sites)
        self.assertEqual(result['operations']['dup'], dict(calls=3, effective=2, last=0))
        self.assertEqual(result['operations']['release_last'], dict(calls=3, effective=3, last=1))

    def test_missing_retain_site(self):
        with self.assertRaises(AssertionError):
            ARC.parse_profile(self.evidence(self.rows[1:], self.managed), self.sites)

    def test_missing_release_site(self):
        with self.assertRaises(AssertionError):
            ARC.parse_profile(self.evidence(self.rows[:1], self.managed), self.sites)

    def test_duplicate_unknown_and_impossible_rows(self):
        for rows in (self.rows + self.rows[:1], ['ownership-site\t2\t1\t1\t0'],
                     ['ownership-site\t0\t1\t2\t0'], ['ownership-site\t0\t2\t2\t1'],
                     ['ownership-site\t0\t0\t0\t0']):
            with self.subTest(rows=rows), self.assertRaises(AssertionError):
                ARC.parse_profile(self.evidence(rows, self.managed), self.sites)

    def test_leak_and_missing_or_duplicate_summary(self):
        leaking = copy.copy(self.managed)
        leaking['finalChargedBytes'] = 16
        for raw in (self.evidence(self.rows, leaking), '\n'.join(self.rows).encode(),
                    self.evidence(self.rows + [json.dumps(self.managed)], self.managed)):
            with self.subTest(raw=raw), self.assertRaises(AssertionError):
                ARC.parse_profile(raw, self.sites)

    def test_comments_and_strings_do_not_create_calls_or_braces(self):
        code = 'static void f() { /* } fwp_rc_dup(v) */ puts("} fwp_rc_dup(v)"); }'
        masked = ARC.OWNERSHIP.mask_c(code)
        self.assertEqual(len(masked), len(code))
        self.assertNotIn('fwp_rc_dup', masked)
        self.assertEqual(ARC.OWNERSHIP.function_end(code, code.index('{')), len(code))

    def test_function_boundaries_exclude_global_descriptors_and_handle_cpp(self):
        code = ('static void first(void) { return; }\n'
                'static int descriptor = 0;\n'
                'static void second(int n) {\n'
                '#ifdef _WIN32\n    if (n) {\n#else\n    if (n != 0) {\n#endif\n'
                '        descriptor++;\n    }\n}\n')
        self.assertEqual(SUMMARY.caller_lines(code), [(1, 1, 'first'), (3, 11, 'second')])

    def test_comparison_checks_attempts_and_preserves_effective_owners(self):
        old = ARC.parse_profile(self.evidence(self.rows, self.managed), self.sites)
        old['operations']['dup']['calls'] = 19
        old['operations']['release_last']['calls'] = 19
        case = dict(sourceSha256='same', inputs={'16': old})
        baseline = dict(hosts={'x86_64': dict(cases={'buffer-unique': case})})
        current = copy.deepcopy(old)
        current['operations']['dup']['calls'] -= 16
        current['operations']['release_last']['calls'] -= 16
        report = dict(machine='x86_64', cases={'buffer-unique': dict(sourceSha256='same', inputs={'16': [current]})})
        self.assertEqual(ARC.comparison_failures(report, baseline, 'compare'), [])
        current['operations']['dup']['effective'] -= 1
        current['managed']['requests'] += 1
        self.assertEqual(len(ARC.comparison_failures(report, baseline, 'compare')), 2)

    def test_unique_array_comparison_requires_the_declared_count_saving(self):
        baseline = json.loads((ARC.ROOT / 'docs/measurements/arc-residual-candidate-2026-10-27.json').read_text())
        cases = baseline['hosts']['x86_64']['cases']
        report = dict(machine='x86_64', cases={})
        for name, case in cases.items():
            current = dict(sourceSha256=case['sourceSha256'], inputs={})
            for label, profile in case['inputs'].items():
                profile = copy.deepcopy(profile)
                if name in ('buffer-unique', 'buffer-callback'):
                    for operation in ('fresh', 'release_last', 'last', 'free_arr'):
                        profile['operations'][operation]['calls'] -= 1
                        profile['operations'][operation]['effective'] -= 1
                    profile['operations']['release_last']['last'] -= 1
                current['inputs'][label] = [profile]
            report['cases'][name] = current
        self.assertEqual(ARC.comparison_failures(report, baseline, 'unique-arrays'), [])
        self.assertTrue(ARC.comparison_failures(report, baseline, 'compare'))
        report['cases']['buffer-unique']['inputs']['16'][0]['operations']['fresh']['calls'] += 1
        self.assertEqual(len(ARC.comparison_failures(report, baseline, 'unique-arrays')), 1)

    def test_sort_key_budget_preserves_allocations_and_required_owners(self):
        baseline = json.loads((ARC.ROOT / 'docs/measurements/unique-array-storage-2026-10-27.json').read_text())
        cases = baseline['hosts']['x86_64']['cases']
        report = dict(machine='x86_64', cases={})
        for name, case in cases.items():
            current = dict(sourceSha256=case['sourceSha256'], inputs={},
                           countMetadata={label: [copy.deepcopy(value)]
                                          for label, value in case['countMetadata'].items()})
            for label, profile in case['inputs'].items():
                profile = copy.deepcopy(profile)
                if name == 'wordfreq':
                    words = int(label.split('-')[1])
                    profile['managed']['retains'] -= 2 * words
                    for operation in ('dup', 'release_last'):
                        profile['operations'][operation]['effective'] -= 2 * words
                        profile['operations'][operation]['calls'] -= 6 * words
                    profile['operations']['release_last']['calls'] -= 2
                    profile['operations']['last']['calls'] -= 3 * words
                current['inputs'][label] = [profile]
            report['cases'][name] = current
        self.assertEqual(ARC.comparison_failures(report, baseline, 'sort-keys'), [])
        original = copy.deepcopy(report)
        for category, field, delta in (('managed', 'requestedBytes', 8),
                                        ('managed', 'retains', -1),
                                        ('dup', 'effective', -1),
                                        ('release_last', 'last', -1),
                                        ('last', 'effective', -1)):
            changed = copy.deepcopy(original)
            profile = changed['cases']['wordfreq']['inputs']['4096-256'][0]
            target = profile['managed'] if category == 'managed' else profile['operations'][category]
            target[field] += delta
            self.assertTrue(ARC.comparison_failures(changed, baseline, 'sort-keys'))
        changed = copy.deepcopy(original)
        changed['cases']['wordfreq']['countMetadata']['4096-256'][0]['requestedCountBytes'] += 1
        self.assertTrue(ARC.comparison_failures(changed, baseline, 'sort-keys'))
        changed = copy.deepcopy(original)
        changed['cases']['wordfreq']['inputs']['4096-256'][0]['operations']['fresh']['calls'] += 1
        self.assertTrue(ARC.comparison_failures(changed, baseline, 'sort-keys'))

    def test_metadata_accounting_and_missing_observations(self):
        metadata = dict(allocationRequests=1, requestedCountBytes=16, releasedCountBytes=0,
                        initialCountBytes=4, finalCountBytes=20, peakCountBytes=20,
                        chunkHeaderBytes=40, countPointerBytes=8)
        raw = lambda value: (json.dumps(value) + '\n' + json.dumps(self.managed) + '\n').encode()
        self.assertEqual(ARC.parse_metadata(raw(metadata)), (metadata, self.managed))
        for field, value in (('allocationRequests', 0), ('requestedCountBytes', 0),
                             ('releasedCountBytes', 1), ('finalCountBytes', 19),
                             ('peakCountBytes', 19), ('chunkHeaderBytes', 4128)):
            broken = dict(metadata, **{field: value})
            with self.subTest(field=field), self.assertRaises(AssertionError):
                ARC.parse_metadata(raw(broken))
        with self.assertRaises(AssertionError):
            ARC.parse_metadata(raw(metadata) + b'{}\n')


if __name__ == '__main__':
    unittest.main()
