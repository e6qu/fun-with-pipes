#!/usr/bin/env python3
"""Reject ambiguous source attribution and inconsistent constructor evidence."""
import importlib.util
import json
from pathlib import Path
import re
import unittest

SPEC = importlib.util.spec_from_file_location('constructor', Path(__file__).with_name('constructor-profile.py'))
CONSTRUCTOR = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CONSTRUCTOR)
PROFILE = CONSTRUCTOR.PROFILE
MEASURE = PROFILE.ARC.module('measure-derivative-forward-costs')


def runtime_source():
    cgen = (PROFILE.ARC.ROOT / 'src/cgen.rs').read_text()
    source = cgen[cgen.index('include_str!("../runtime/fwp_rt.c")'):]
    end = 'include_str!("../runtime/fwp_rt_kernel.c")'
    source = source[:source.index(end) + len(end)]
    paths = re.findall(r'include_str!\("\.\./(runtime/[^"\n]+)"\)', source)
    return '\n'.join((PROFILE.ARC.ROOT / path).read_text() for path in paths) + (
        '\nstatic void *fwp_main_thread(void *arg) {\n    fwp_init_consts();\n'
        '    /* Ownership observation point: before runtime teardown. */\n}\n')


class Attribution(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.source, cls.profile_sites, cls.bases = PROFILE.instrument(runtime_source())
        cls.code, cls.sites = CONSTRUCTOR.instrument(cls.source)

    def test_runtime_calls_have_exact_known_callers(self):
        self.assertGreater(len(self.sites), 100)
        lines = self.source.splitlines()
        self.assertTrue(any(site['caller'] == 'fwp_k_map_owned' for site in self.sites))
        self.assertTrue(any(site['caller'] == 'fwp_p_array_set_typed' for site in self.sites))
        for site in self.sites:
            self.assertEqual(site['source'], lines[site['line'] - 1].strip())
            self.assertNotIn(site['caller'], CONSTRUCTOR.SIGNATURES)
        self.assertIn('fwp_record(constructor_site, 2, f)', self.code)
        self.assertIn('if (n == 0) return tag;\n    constructor_hit(', self.code)
        self.assertEqual(len(CONSTRUCTOR.data_allocator_sites(
            self.bases['allocation-base.c'], self.profile_sites['allocations'])), 1)

    def test_comments_and_strings_are_not_calls(self):
        tail = '\n/* fwp_cons(x, xs) */\nstatic void comment(void) { puts("fwp_data("); }\n'
        code, sites = CONSTRUCTOR.instrument(self.source + tail)
        self.assertEqual(sites, self.sites)
        self.assertTrue(code.endswith(tail))

    def test_unknown_reference_caller_and_forwarding_fail(self):
        for source, message in (
            (self.source + '\nvoid *p = fwp_cons;\n', 'unsupported constructor reference'),
            (self.source + '\nV global = fwp_cons(1, 0);\n', 'unresolved constructor caller'),
            (self.source.replace('return fwp_record(2, f);', 'return fwp_data(0, 2, f);'),
             'changed constructor forwarding')):
            with self.subTest(message=message), self.assertRaisesRegex(ValueError, message):
                CONSTRUCTOR.instrument(source)

    def test_native_controls_cover_every_phase_and_have_distinct_defects(self):
        source = MEASURE.control_source(runtime_source(), CONSTRUCTOR.CONTROL)
        detailed, _, _ = PROFILE.instrument(source)
        code, sites = CONSTRUCTOR.instrument(detailed)
        variants = CONSTRUCTOR.control_variants(code, sites)
        self.assertEqual(len(set(variants.values())), 6)
        self.assertEqual(variants['complete'], code)
        rows, phases = [], {}
        for phase, name in enumerate(PROFILE.PHASES):
            calls = [site for site in sites if site['caller'] == 'fwp_main_thread']
            # Each phase emits six heap constructors and two immediate values.
            selected = calls[8 * phase:8 * phase + 6]
            self.assertEqual(len(selected), 6)
            for site, (tag, fields) in zip(selected, ((0, 2), (1, 2), (1, 1), (0, 2), (9, 1), (1, 2))):
                rows.append(dict(phase=name, site=site['id'], tag=tag, fields=fields,
                                 requests=phase + 1, requestedBytes=(phase + 1) * (8 + 8 * fields)))
            phases[name] = dict(requests=7 * (phase + 1), requestedBytes=136 * (phase + 1))
        CONSTRUCTOR.check_control(dict(phases=phases), rows, sites)
        rows[0]['site'] = rows[1]['site']
        with self.assertRaises(AssertionError):
            CONSTRUCTOR.check_control(dict(phases=phases), rows, sites)


class Counts(unittest.TestCase):
    def setUp(self):
        self.sites = [dict(id=0)]
        self.profile_sites = dict(allocations=[dict(id=0)], ownership=[])
        self.constructor = 'constructor-allocation\t0\t0\t1\t2\t1\t24'
        self.rows = [self.constructor, 'derivative-allocation\t0\t0\t1\t24']
        self.rows += [f'derivative-peak\t{phase}\t{32 if phase == 0 else 0}' for phase in range(7)]
        self.rows += [json.dumps(dict(requests=1, requestedBytes=24, retains=0,
                                     peakChargedBytes=32, finalChargedBytes=0)),
                      json.dumps(dict(derivativeVisits=dict(updates=0, inputs=0, nodes=0))),
                      json.dumps(dict(rawDerivativeStorage=dict(finalBytes=0, peakBytes=0,
                          beforeShutdownBytes=0, afterBackward=[])))]

    def parse(self, rows):
        return CONSTRUCTOR.parse(('\n'.join(rows) + '\n').encode(), self.sites, {0},
                                 self.profile_sites, 3, 0, False)

    def test_complete_counts(self):
        profile, rows = self.parse(self.rows)
        self.assertEqual(profile['totals']['managed']['requests'], 1)
        self.assertEqual(rows, [dict(phase='outside', site=0, tag=1, fields=2,
                                    requests=1, requestedBytes=24)])

    def test_missing_duplicate_wrong_site_phase_shape_and_bytes_fail(self):
        for changed in (None, self.constructor + '\n' + self.constructor,
                        'constructor-allocation\t0\t1\t1\t2\t1\t24',
                        'constructor-allocation\t1\t0\t1\t2\t1\t24',
                        'constructor-allocation\t7\t0\t1\t2\t1\t24',
                        'constructor-allocation\t0\t0\t1\t0\t1\t8',
                        'constructor-allocation\t0\t0\t1\t2\t1\t23',
                        'constructor-allocation\t0\t0\t1\t2\t0\t0'):
            rows = self.rows[1:] if changed is None else [changed] + self.rows[1:]
            with self.subTest(changed=changed), self.assertRaises(AssertionError):
                self.parse(rows)

    def test_managed_leak_fails(self):
        with self.assertRaises(AssertionError):
            self.parse([row.replace('"finalChargedBytes": 0', '"finalChargedBytes": 32')
                        for row in self.rows])


if __name__ == '__main__':
    unittest.main()
