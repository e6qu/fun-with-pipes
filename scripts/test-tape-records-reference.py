"""Keep the layout comparison isolated and reject changed reference bytes."""
import copy
import hashlib
import importlib.util
from pathlib import Path
import subprocess
import unittest

ROOT = Path(__file__).resolve().parents[1]
SPEC = importlib.util.spec_from_file_location('records_reference', ROOT / 'scripts/prepare-tape-records-reference.py')
REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REFERENCE)
SPEC = importlib.util.spec_from_file_location('storage', ROOT / 'scripts/ad-storage-profile.py')
STORAGE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(STORAGE)
SPEC = importlib.util.spec_from_file_location('evidence', ROOT / 'scripts/check-array-list-evidence.py')
EVIDENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(EVIDENCE)


class TapeReference(unittest.TestCase):
    def setUp(self):
        self.name = 'runtime/fwp_rt_kernel.c'
        self.current = (ROOT / self.name).read_text()
        self.frozen = (ROOT / REFERENCE.REFERENCE_PATH).read_text()

    def test_reference_matches_declared_revision(self):
        original = subprocess.check_output(['git', 'show', REFERENCE.BASELINE + ':' + self.name], cwd=ROOT, text=True)
        tape = original[original.index(REFERENCE.START):original.index(REFERENCE.END)]
        self.assertEqual(self.frozen, tape)
        self.assertEqual(hashlib.sha256(tape.encode()).hexdigest(), REFERENCE.REFERENCE_SHA256)

    def test_only_tape_section_changes(self):
        for source in (self.current, '/* new unrelated prefix */\n' + self.current + '\n/* new unrelated suffix */'):
            actual = REFERENCE.reference_sources({self.name: source})[self.name]
            self.assertEqual(actual[:actual.index(REFERENCE.START)], source[:source.index(REFERENCE.START)])
            self.assertEqual(actual[actual.index(REFERENCE.END):], source[source.index(REFERENCE.END):])
            self.assertEqual(actual[actual.index(REFERENCE.START):actual.index(REFERENCE.END)], self.frozen)
        self.assertIn('src/cgen.rs', REFERENCE.PRESERVED)
        self.assertIn('src/numerics.rs', REFERENCE.PRESERVED)
        self.assertNotIn(self.name, REFERENCE.PRESERVED)

    def test_missing_duplicate_or_wrong_layout_rejected(self):
        for marker in (REFERENCE.START, REFERENCE.END,
                       'typedef struct { int32_t pa, pb; double da, db; } fwp_tape_op;',
                       'realloc(t->ops, (size_t)cap * sizeof(fwp_tape_op))',
                       'realloc(t->parents, (size_t)cap * sizeof(fwp_tape_parents))'):
            with self.subTest(marker=marker), self.assertRaises(AssertionError):
                REFERENCE.replace_tape(self.current.replace(marker, ''), self.frozen)
        for marker in (REFERENCE.START, REFERENCE.END):
            with self.assertRaises(AssertionError):
                REFERENCE.replace_tape(self.current + marker, self.frozen)
        with self.assertRaises(AssertionError):
            REFERENCE.reference_sources({})

    def test_modified_frozen_source_rejected(self):
        for source in ('', self.frozen + '\n', self.frozen.replace('memmove', 'memcpy')):
            with self.assertRaises(AssertionError):
                REFERENCE.replace_tape(self.current, source)

    def test_observer_requires_every_allocation_and_cleanup_site(self):
        for layout, source, fields in [('records', self.current, ('ops', 'parents', 'adj')),
                                      ('columns', self.frozen, ('pa', 'da', 'adj'))]:
            source += '\niteration_active=1;\n    iteration_active=0;\n'
            observed = STORAGE.instrument(source, layout)
            self.assertIn('ad_raw_before_shutdown=ad_raw_total()', observed)
            for owner in ('b', 't'):
                for field in fields:
                    self.assertIn(f'ad_raw_free({owner}->{field});', observed)
                    with self.subTest(layout=layout, field=field), self.assertRaises(ValueError):
                        STORAGE.instrument(source.replace(f'free({owner}->{field});', ''), layout)
            for field in fields[:2]:
                with self.assertRaises(ValueError):
                    STORAGE.instrument(source.replace(f'realloc(t->{field},', 'missing('), layout)
            with self.assertRaises(ValueError):
                STORAGE.instrument(source, 'columns' if layout == 'records' else 'records')
        with self.assertRaises(ValueError):
            STORAGE.instrument(self.current, 'unknown')

    def test_historical_observer_labels_remain_exact(self):
        original = subprocess.check_output(['git', 'show', REFERENCE.BASELINE + ':tests/fixtures/ad_raw_storage_probe.c'], cwd=ROOT, text=True)
        current = (ROOT / 'tests/fixtures/ad_raw_storage_probe.c').read_text()
        self.assertEqual(current.replace('AD_OPERATIONS', 'AD_PARTIALS').replace('"operations"', '"partials"'), original)

    def test_archive_reader_uses_literal_data(self):
        preparation = (ROOT / 'scripts/prepare-tape-records-reference.py').read_text()
        current = {self.name: self.current}
        expected = REFERENCE.reference_sources(current)
        self.assertEqual(EVIDENCE.recorded_tape_reference(current,
            preparation + '\nraise RuntimeError("never execute saved code")\n', self.frozen), expected)
        for modified in (preparation + '\nREFERENCE_SHA256 = "duplicate"\n',
                         preparation.replace('BASELINE =', 'MISSING =', 1),
                         preparation.replace(REFERENCE.REFERENCE_SHA256, '0' * 64)):
            with self.assertRaises(AssertionError):
                EVIDENCE.recorded_tape_reference(current, modified, self.frozen)
        transformation, paths, preserved = EVIDENCE.GROUPS.reference_contract('tape-records')
        self.assertEqual(paths, REFERENCE.EDITS)
        self.assertEqual(preserved, set(REFERENCE.PRESERVED))
        self.assertEqual(transformation, 'contiguous numeric operation records and typed parent pairs')

    def test_raw_storage_counts_detect_lost_savings_and_leaks(self):
        block = lambda requests, size: dict(requests=requests, requestedBytes=size, peakBytes=size)
        current = dict(kinds=dict(registry=block(1, 88), parents=block(0, 0),
                                  operations=block(1, 1536), adjoints=block(1, 512)),
                       peakBytes=2136, beforeShutdownBytes=2136, finalBytes=0)
        reference = dict(kinds=dict(registry=block(1, 104), parents=block(1, 512),
                                    partials=block(1, 1024), adjoints=block(1, 512)),
                         peakBytes=2152, beforeShutdownBytes=2152, finalBytes=0)
        self.assertEqual(STORAGE.record_layout_failures(current, reference), [])
        for kind in current['kinds']:
            for field in current['kinds'][kind]:
                changed = copy.deepcopy(current)
                changed['kinds'][kind][field] += 100
                with self.subTest(kind=kind, field=field):
                    self.assertTrue(STORAGE.record_layout_failures(changed, reference))
        for field in ('peakBytes', 'beforeShutdownBytes', 'finalBytes'):
            changed = copy.deepcopy(current)
            changed[field] += 100
            self.assertTrue(STORAGE.record_layout_failures(changed, reference))
        reference['finalBytes'] = 1
        self.assertTrue(STORAGE.record_layout_failures(current, reference))


if __name__ == '__main__':
    unittest.main()
