#!/usr/bin/env python3
"""Reject unused consuming helpers and the recorded complete-solve selection gap."""
import importlib.util
from pathlib import Path
import unittest
import zipfile

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('selection', ROOT / 'scripts/inspect-iteration-storage.py')
SELECTION = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(SELECTION)

PROGRAM = '''/* ---- program ---- */
/* main : Unit */
static V f0(void) {
    return fwp_loop_fields7(PTR(&fc3));
}
static inline V fwp_loop_fields7(V callback) {
    return fs7(callback);
}
static inline __attribute__((always_inline)) int fs7(V callback) {
    return fwp_apply(callback);
}
/* worker : T */
static V f3(V input) {
    return f12(f11(input));
}
/* consumed-scalar-array-map : T */
static V f11(V input) {
    return input;
}
/* consumed-scalar-array-list-zip : T */
static V f12(V input) {
    return input;
}
/* consumed-scalar-array-map : T */
static V f99(V input) {
    return input;
}
'''


class Selection(unittest.TestCase):
    def test_live_loop_and_used_closure_reach_both_operations(self):
        self.assertEqual(SELECTION.consuming_calls(PROGRAM), {
            'consumed-scalar-array-map': ['f11'],
            'consumed-scalar-array-list-zip': ['f12'],
        })

    def test_unused_helpers_and_unreached_callbacks_do_not_count(self):
        for source in (PROGRAM.replace('f12(f11(input))', 'input'),
                       PROGRAM.replace('PTR(&fc3)', 'FWP_UNIT')):
            self.assertFalse(any(SELECTION.consuming_calls(source).values()))

    def test_direct_borrowed_callbacks_reach_only_the_used_worker(self):
        for kind in ('fold', 'array'):
            callback = f'fwp_borrowed_{kind}0'
            source = PROGRAM.replace('fwp_loop_fields7(PTR(&fc3))', 'fwp_hof0()')
            source += f'''static V fwp_hof0(void) {{
    return {callback}(0);
}}
static V {callback}(V *args) {{
    return f3(args[0]);
}}
'''
            with self.subTest(kind=kind):
                self.assertEqual(SELECTION.consuming_calls(source), {
                    'consumed-scalar-array-map': ['f11'],
                    'consumed-scalar-array-list-zip': ['f12'],
                })
                unused = source.replace(f'return {callback}(0);', 'return 0;')
                self.assertFalse(any(SELECTION.consuming_calls(unused).values()))

    def test_saved_complete_programs_expose_the_original_gap(self):
        with zipfile.ZipFile(ROOT / 'docs/measurements/owned-numeric-selection-2026-11-04/source.zip') as archive:
            for host in ('arm', 'amd'):
                for form in ('current-large', 'descent-large'):
                    code = archive.read(host + '/selection/' + form + '-optimized.c').decode()
                    found = SELECTION.consuming_calls(code)
                    self.assertFalse(found['consumed-scalar-array-map'])
                    self.assertEqual(bool(found['consumed-scalar-array-list-zip']), form == 'descent-large')
                    self.assertFalse(all(found.values()), 'the old implementation must not pass full selection')


if __name__ == '__main__':
    unittest.main()
