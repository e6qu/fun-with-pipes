#!/usr/bin/env python3
"""Verify exact scalar reference isolation and reject malformed selection edits."""
import importlib.util
from pathlib import Path
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('reference', ROOT / 'scripts/prepare-scalar-constant-reference.py')
REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REFERENCE)
CURRENT = {name: (ROOT / name).read_text() for name in REFERENCE.EDITS}
SPEC = importlib.util.spec_from_file_location('selection', ROOT / 'scripts/check-scalar-constant-selection.py')
SELECTION = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(SELECTION)


class ScalarConstantReference(unittest.TestCase):
    def test_selection_follows_cache_aliases_and_rejects_unused_entries(self):
        cached = """/* ---- program ---- */
static V caf1(void) { static int st; return f1(); }
static V caf2(void) { static int st; return f2(); }
/* main : F64 */
static V f0(void) {
    return caf1();
}
/* One[F64].one : F64 */
static V f1(void) {
    return caf2();
}
/* prim.one : F64 */
static V f2(void) {
    return 0x3ff0000000000000ULL;
}
"""
        literal = """/* ---- program ---- */
/* main : F64 */
static V f0(void) {
    return 0x3ff0000000000000ULL;
}
"""
        # Isolate scalar reachability here; real workflow probes separately
        # require the complete private pair storage proof on generated programs.
        with patch.object(SELECTION.PAIR, 'check', return_value={}):
            self.assertEqual(SELECTION.check(cached, 'cached')['cachedEntries'],
                {'One[F64].one': 'caf1', 'prim.one': 'caf2'})
            self.assertEqual(SELECTION.check(literal, 'literal')['cachedEntries'], {})
            for source, mode in ((cached, 'literal'), (literal, 'cached'),
                    (cached.replace('return caf1();', 'return 0;'), 'cached'),
                    (cached.replace('return caf2();', 'return 0;'), 'cached'),
                    (literal.replace('0x3ff0000000000000ULL', '0'), 'literal')):
                with self.subTest(mode=mode), self.assertRaises(AssertionError):
                    SELECTION.check(source, mode)

    def test_complete_reference_is_reversible_and_preserves_prior_work(self):
        restored = REFERENCE.reference_sources(CURRENT)
        for name, (candidate, reference) in REFERENCE.EDITS.items():
            self.assertEqual(restored[name].count(reference), 1)
            self.assertNotIn(candidate, restored[name])
            self.assertEqual(restored[name].replace(reference, candidate), CURRENT[name])
        for selection in ('owned_numeric::lower(&mut numeric_program);',
                          'packed_inputs::lower(&mut numeric_program);'):
            self.assertIn(selection, restored['src/cgen.rs'])
        self.assertIn('const GRADIENT_CALL_STORAGE: bool = true;', restored['src/cgen.rs'])
        self.assertIn('const PACKED_PAIR_REUSE: bool = true;', restored['src/cgen.rs'])
        self.assertIn('fold_fields::lower(&mut numeric_program);', restored['src/cgen.rs'])
        self.assertIn('src/cgen/constant_values.rs', REFERENCE.PRESERVED)
        self.assertIn('src/escape.rs', REFERENCE.PRESERVED)
        self.assertTrue(set(REFERENCE.PRESERVED).isdisjoint(REFERENCE.EDITS))

    def test_missing_duplicate_altered_and_partly_disabled_edits_fail(self):
        for name, (candidate, reference) in REFERENCE.EDITS.items():
            for defect in ('', candidate + candidate, candidate[1:], reference):
                changed = dict(CURRENT)
                changed[name] = changed[name].replace(candidate, defect)
                with self.subTest(path=name, defect=defect), self.assertRaises(AssertionError):
                    REFERENCE.reference_sources(changed)
            missing = dict(CURRENT)
            del missing[name]
            with self.assertRaises(AssertionError):
                REFERENCE.reference_sources(missing)

    def test_unrelated_changes_survive(self):
        for name in CURRENT:
            changed = dict(CURRENT)
            changed[name] += '\nUnrelated marker\n'
            reference = REFERENCE.reference_sources(changed)
            for path, (before, after) in REFERENCE.EDITS.items():
                self.assertEqual(reference[path].replace(after, before), changed[path])


if __name__ == '__main__':
    unittest.main()
