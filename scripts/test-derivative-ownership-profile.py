#!/usr/bin/env python3
"""Reject lost/duplicated phase evidence and changed allocator/runtime hooks."""
import copy
import hashlib
import importlib.util
import io
import json
from pathlib import Path
import re
import unittest
import warnings
import zipfile

SPEC = importlib.util.spec_from_file_location('profile', Path(__file__).with_name('derivative-ownership-profile.py'))
PROFILE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PROFILE)
MEASURE = PROFILE.ARC.module('measure-derivative-forward-costs')
SUMMARY = PROFILE.ARC.module('summarize-derivative-forward-costs')


class Evidence(unittest.TestCase):
    def setUp(self):
        self.sites = dict(allocations=[dict(id=0)],
                          ownership=[dict(operation='dup'), dict(operation='release_last')])
        self.rows = [f'derivative-peak\t{phase}\t32' for phase in range(7)]
        self.rows += ['ownership-site\t0\t2\t2\t0', 'ownership-site\t1\t3\t3\t1',
                      'derivative-allocation\t2\t0\t1\t24',
                      'derivative-ownership\t2\t0\t2\t2\t0',
                      'derivative-ownership\t6\t1\t3\t3\t1']
        self.rows += [json.dumps(dict(requests=1, requestedBytes=24, retains=2,
                                     peakChargedBytes=32, finalChargedBytes=0)),
                      json.dumps(dict(derivativeVisits=dict(updates=1, inputs=3, nodes=16))),
                      json.dumps(dict(rawDerivativeStorage=dict(finalBytes=0, peakBytes=0,
                          beforeShutdownBytes=0, afterBackward=[dict(
                              registryBytes=0, workspaceBytes=0, otherBytes=0)])))]

    def parse(self, rows):
        return PROFILE.parse(('\n'.join(rows) + '\n').encode(), self.sites, 3, 1, False)

    def test_complete_profile(self):
        result = self.parse(self.rows)
        self.assertEqual(result['phases']['forwardWithRecording']['requests'], 1)
        self.assertEqual(result['phases']['retirement']['operations']['release_last']['last'], 1)

    def test_known_work_rejects_valid_but_wrong_phase_assignment(self):
        phases = {}
        for phase, name in enumerate(PROFILE.PHASES):
            repeat = phase + 1
            phases[name] = dict(requests=2 * repeat, requestedBytes=40 * repeat,
                peakChargedBytes=32, operations={op: dict(zip(
                    ('calls', 'effective', 'last'), (n * repeat for n in counts)))
                    for op, counts in MEASURE.CONTROL_OPERATIONS.items()})
        MEASURE.check_control(dict(phases=phases))
        changed = copy.deepcopy(phases)
        changed['setup'], changed['forwardWithRecording'] = changed['forwardWithRecording'], changed['setup']
        with self.assertRaises(AssertionError):
            MEASURE.check_control(dict(phases=changed))

    def test_every_row_is_required_and_cannot_repeat(self):
        for index in range(len(self.rows)):
            with self.subTest(index=index, defect='omission'), self.assertRaises(AssertionError):
                self.parse(self.rows[:index] + self.rows[index + 1:])
            with self.subTest(index=index, defect='duplicate'), self.assertRaises(AssertionError):
                self.parse(self.rows + self.rows[index:index + 1])

    def test_unknown_phase_site_and_impossible_fields(self):
        original = 'derivative-ownership\t2\t0\t2\t2\t0'
        for changed in ('derivative-ownership\t7\t0\t2\t2\t0',
                        'derivative-ownership\t-1\t0\t2\t2\t0',
                        'derivative-ownership\t2\t9\t2\t2\t0',
                        'derivative-ownership\t2\t0\t1\t2\t0',
                        'derivative-ownership\t2\t0\t2\t2\t1',
                        'derivative-ownership\t2\t0\t2\t-1\t0'):
            with self.subTest(changed=changed), self.assertRaises(AssertionError):
                self.parse([changed if row == original else row for row in self.rows])

    def test_changed_work_and_allocation_counts(self):
        for old, new in (('"nodes": 16', '"nodes": 15'),
                         ('"inputs": 3', '"inputs": 4'),
                         ('"updates": 1', '"updates": true'),
                         ('allocation\t2\t0\t1\t24', 'allocation\t2\t0\t1\t23'),
                         ('peak\t0\t32', 'peak\t0\t33')):
            with self.subTest(old=old), self.assertRaises(AssertionError):
                self.parse([row.replace(old, new) for row in self.rows])

    def test_allocator_sites_have_exact_source_locations(self):
        source = '''static void *fwp_alloc_init(size_t n);
static inline void *fwp_heap_alloc(size_t n, int kind) {
if(iteration_active && kind!=0){iteration_requests++;iteration_bytes+=n;}
return 0;
}
static inline void *fwp_alloc_init(size_t n) {
if(iteration_active){iteration_requests++;iteration_bytes+=n;}
return fwp_heap_alloc(n, 0);
}
static void use(void) { fwp_alloc_init(24); }
/* fwp_alloc_init(99); */
'''
        transformed, sites = PROFILE.allocation_sites(source)
        self.assertEqual(len(sites), 2)
        for site in sites:
            self.assertEqual(site['source'], source.splitlines()[site['line'] - 1].strip())
        self.assertIn('fwp_alloc_init_profile(size_t allocation_site, size_t n);', transformed)
        self.assertIn('/* fwp_alloc_init(99); */', transformed)
        with self.assertRaisesRegex(ValueError, 'unsupported allocator function pointer'):
            PROFILE.allocation_sites(source + 'void *p = fwp_alloc_init;\n')
        with self.assertRaises(ValueError):
            PROFILE.allocation_sites(source.replace('iteration_bytes+=n;', '', 1))

    def test_current_runtime_has_every_required_hook(self):
        cgen = (PROFILE.ARC.ROOT / 'src/cgen.rs').read_text()
        runtime = cgen[cgen.index('include_str!("../runtime/fwp_rt.c")'):]
        end = 'include_str!("../runtime/fwp_rt_kernel.c")'
        runtime = runtime[:runtime.index(end) + len(end)]
        paths = re.findall(r'include_str!\("\.\./(runtime/[^"\n]+)"\)', runtime)
        self.assertIn('runtime/fwp_rt_kernel.c', paths)
        source = '\n'.join((PROFILE.ARC.ROOT / path).read_text() for path in paths)
        source += ('\nstatic void *fwp_main_thread(void *arg) {\n    fwp_init_consts();\n'
                   '    /* Ownership observation point: before runtime teardown. */\n}\n')
        transformed, sites, bases = PROFILE.instrument(source)
        self.assertIn('descent_phase_step(DESCENT_RETIRE);', transformed)
        self.assertEqual(transformed.count('    descent_phase_init();'), 1)
        for key, basename in [('allocations', 'allocation-base.c'), ('ownership', 'ownership-base.c')]:
            lines = bases[basename].splitlines()
            for site in sites[key]:
                self.assertEqual(site['source'], lines[site['line'] - 1].strip())
        with self.assertRaises(ValueError):
            PROFILE.instrument(source.replace('    return (V)(id << 32);', ''))

    def test_archive_missing_extra_changed_and_duplicate_members_fail(self):
        report = dict(files={'ordinary.c': hashlib.sha256(b'original').hexdigest()})

        def check(entries):
            buffer = io.BytesIO()
            with warnings.catch_warnings():
                warnings.simplefilter('ignore', UserWarning)  # deliberately duplicate ZIP member
                with zipfile.ZipFile(buffer, 'w') as archive:
                    archive.writestr('report.json', json.dumps(report))
                    for name, data in entries:
                        archive.writestr(name, data)
            with zipfile.ZipFile(buffer) as archive:
                SUMMARY.verify_manifest(archive, report)

        check([('ordinary.c', b'original')])
        for entries in ([], [('ordinary.c', b'changed')],
                        [('ordinary.c', b'original'), ('extra.c', b'extra')],
                        [('ordinary.c', b'original'), ('ordinary.c', b'original')]):
            with self.subTest(entries=entries), self.assertRaises(AssertionError):
                check(entries)


if __name__ == '__main__':
    unittest.main()
