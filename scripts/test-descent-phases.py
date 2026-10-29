#!/usr/bin/env python3
"""Check phase attribution, zero work, and rejected incomplete/nested observations."""
import argparse
import importlib.util
import json
from pathlib import Path
import subprocess
import tempfile
import unittest

SPEC = importlib.util.spec_from_file_location('phases', Path(__file__).with_name('descent-phases.py'))
PHASES = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PHASES)


class DescentPhases(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.directory = tempfile.TemporaryDirectory(prefix='fwp-descent-phases-')
        cls.addClassCleanup(cls.directory.cleanup)
        root = Path(cls.directory.name)
        source = root / 'probe.c'
        source.write_text('#define _POSIX_C_SOURCE 200809L\n#include <stdint.h>\n'
                          '#include <stdio.h>\n#include <stdlib.h>\n#include <string.h>\n#include <time.h>\n' +
                          (PHASES.ROOT / 'tests/fixtures/descent_phases.c').read_text() + r'''
int main(int argc, char **argv) {
    if (argc != 2) return 234;
    descent_phase_init();
    if (!strcmp(argv[1], "zero")) return 0;
    descent_phase_step(DESCENT_SETUP);
    if (!strcmp(argv[1], "nested")) descent_phase_step(DESCENT_SETUP);
    if (!strcmp(argv[1], "incomplete")) return 0;
    if (!strcmp(argv[1], "omitted")) descent_phase_step(DESCENT_REVERSE_SETUP);
    for (int phase = DESCENT_FORWARD; phase <= DESCENT_PHASES; phase++)
        descent_phase_step(phase);
    descent_inputs = 3;
    descent_nodes = 8;
    return 0;
}
''')
        cls.binary = root / 'probe'
        subprocess.run([cls.cc, '-std=c11', '-O2', '-Wall', '-Wextra', '-Werror',
                        str(source), '-o', str(cls.binary)], check=True, capture_output=True, timeout=30)

    def execute(self, mode):
        return subprocess.run([str(self.binary), mode], capture_output=True, timeout=10)

    def test_complete_and_zero_update_observations(self):
        for mode, updates in [('normal', 1), ('zero', 0)]:
            with self.subTest(mode=mode):
                result = self.execute(mode)
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertEqual(result.stdout, b'')
                PHASES.check(json.loads(result.stderr), 3, updates)

    def test_missing_nested_and_unfinished_phases_fail(self):
        for mode in ['nested', 'incomplete', 'omitted']:
            with self.subTest(mode=mode):
                result = self.execute(mode)
                self.assertEqual(result.returncode, 233)
                self.assertIn(b'incomplete or unsupported phase sequence', result.stderr)
                self.assertNotIn(b'derivativePhases', result.stderr)

    def test_runtime_sites_are_unique_and_required(self):
        runtime = (PHASES.ROOT / 'runtime/fwp_rt_kernel.c').read_text()
        source = runtime + '\nstatic void *fwp_main_thread(void *arg) {\n    fwp_init_consts();\n}\n'
        measured = PHASES.instrument(source)
        self.assertIn('descent_phase_step(DESCENT_RETIRE);', measured)
        self.assertEqual(measured.count('    descent_phase_init();'), 1)
        missing = source.replace('    V r = fwp_arr_new((size_t)tp.leaves);', '')
        with self.assertRaisesRegex(ValueError, 'Expected one derivative phase site'):
            PHASES.instrument(missing)

    def test_changed_counts_or_missing_phase_cannot_pass(self):
        original = json.loads(self.execute('normal').stderr)
        for defect in ['updates', 'inputs', 'nodes', 'phase', 'negative']:
            row = json.loads(json.dumps(original))
            values = row['derivativePhases']
            if defect in ['updates', 'inputs', 'nodes']:
                values[defect] = 0
            elif defect == 'phase':
                del values['nanoseconds']['reverseTraversal']
            else:
                values['nanoseconds']['setup'] = -1
            with self.subTest(defect=defect), self.assertRaises(AssertionError):
                PHASES.check(row, 3, 1)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--cc', required=True)
    args = parser.parse_args()
    DescentPhases.cc = args.cc
    unittest.main(argv=[__file__])
