#!/usr/bin/env python3
"""Check the exact reference edit and reject broken live-worker observers."""
import importlib.util
from pathlib import Path
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('reference', ROOT / 'scripts/prepare-recording-lookup-reference.py')
REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REFERENCE)
SPEC = importlib.util.spec_from_file_location('selection', ROOT / 'scripts/check-recording-lookup-selection.py')
SELECTION = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(SELECTION)
CURRENT = {name: (ROOT / name).read_text() for name in REFERENCE.EDITS}


class RecordingLookupReference(unittest.TestCase):
    def test_counts_keep_parent_capacity_and_node_work(self):
        for n, updates, solves in ((3, 0, 32768), (3, 1, 512), (3, 199, 32),
                                  (3, 1999, 4), (33, 199, 32), (129, 199, 8)):
            pairs = (n - 1) * updates * solves
            for enabled in (False, True):
                observed = dict(lookups=(3 if enabled else 8) * pairs,
                                parents=8 * pairs, capacities=8 * pairs, nodes=8 * pairs)
                SELECTION.check_counts(observed, n, updates, solves, enabled)
                for field in observed:
                    for delta in (-1, 1):
                        changed = dict(observed)
                        changed[field] += delta
                        with self.subTest(field=field), self.assertRaises(AssertionError):
                            SELECTION.check_counts(changed, n, updates, solves, enabled)

    def test_counter_sites_are_unique_and_only_scalar_push_is_changed(self):
        source = (ROOT / 'runtime/fwp_rt_kernel.c').read_text()
        source += '    /* Ownership observation point: before runtime teardown. */\n'
        result = SELECTION.instrument(source)
        for field in ('lookups', 'parents', 'capacities', 'nodes'):
            self.assertEqual(result.count('recording_' + field + '++;'), 1)
        for marker in ('        t = fwp_tape_of(id);', '    t->len = idx + 1;'):
            for changed in (source.replace(marker, ''), source.replace(marker, marker * 2)):
                with self.assertRaises(AssertionError):
                    SELECTION.instrument(changed)
        self.assertEqual(source[source.index('/* the adjoints'):],
                         result[result.index('/* the adjoints'):].replace(
                             result[result.index('    fprintf(stderr, "{'):result.index('    /* Ownership observation point:')], ''))

    def test_reversible_edit_preserves_prior_optimizations(self):
        reference = REFERENCE.reference_sources(CURRENT)
        for name, (before, after) in REFERENCE.EDITS.items():
            self.assertEqual(reference[name].replace(after, before), CURRENT[name])
            self.assertEqual(reference[name].count(after), 1)
        for setting in ('SCALAR_CONSTANT_VALUES', 'PACKED_PAIR_REUSE', 'GRADIENT_CALL_STORAGE'):
            self.assertIn(f'const {setting}: bool = true;', reference['src/cgen.rs'])
        self.assertIn('runtime/fwp_rt_kernel.c', REFERENCE.PRESERVED)
        self.assertIn('src/cgen/recording.rs', REFERENCE.PRESERVED)

    def test_missing_duplicate_or_disabled_selection_is_rejected(self):
        for name, (before, after) in REFERENCE.EDITS.items():
            for defect in ('', before + before, after, before[1:]):
                with self.subTest(defect=defect), self.assertRaises(AssertionError):
                    REFERENCE.reference_sources({name: CURRENT[name].replace(before, defect)})
        with self.assertRaises(AssertionError):
            REFERENCE.reference_sources({})

    def test_observer_requires_live_complete_initialized_worker(self):
        body = SELECTION.STATE + '\n' + 'fwp_p_ad_push(a, b, c, d, &recording);\n' * 6
        with patch.object(SELECTION.SCALAR, 'check', return_value={}):
            for text, reached, enabled, passes in [
                (body, {'w1'}, True, True), ('return 0;', {'w1'}, False, True),
                (body, set(), True, False), (body, {'w1'}, False, False),
                (body.replace(SELECTION.STATE, ''), {'w1'}, True, False),
                (body.replace('d, &recording', 'd, NULL', 1), {'w1'}, True, False),
                (body.replace('{-1, NULL}', '{0, NULL}'), {'w1'}, True, False),
            ]:
                with self.subTest(enabled=enabled, text=text), patch.object(
                        SELECTION.SCALAR.PAIR.STORAGE, 'reachable_bodies', return_value=({'w1': text}, reached)):
                    if passes:
                        self.assertEqual(SELECTION.check(text, enabled)['enabled'], enabled)
                    else:
                        with self.assertRaises(AssertionError):
                            SELECTION.check(text, enabled)


if __name__ == '__main__':
    unittest.main()
