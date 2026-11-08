#!/usr/bin/env python3
"""Reject altered reference boundaries, wrong schedules and misleading timing controls."""
from collections import Counter
import importlib.util
from pathlib import Path
import unittest

from borrowed_array_reference import DISABLED, SELECTION, reference_source

SPEC = importlib.util.spec_from_file_location('costs', Path(__file__).with_name('measure-borrowed-arrays.py'))
COSTS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(COSTS)


class Costs(unittest.TestCase):
    def test_only_selection_changes(self):
        source = 'prefix\n' + SELECTION + '\nsuffix\n'
        result = reference_source(source)
        self.assertEqual(result, 'prefix\n' + DISABLED + '\nsuffix\n')
        for invalid in ('no selection', source * 2, result):
            with self.assertRaises(AssertionError):
                reference_source(invalid)

    def test_all_inputs_and_controls_are_present(self):
        cases = list(COSTS.programs())
        self.assertEqual(len(cases), 18)
        self.assertEqual(len({case['name'] for case in cases}), 18)
        self.assertEqual({case['count'] for case in cases if case['kind'] == 'array'},
                         {0, 16, 65537, 262145})
        for kind in ('local', 'manual'):
            self.assertEqual({(case['count'], case['updates']) for case in cases if case['kind'] == kind},
                             {(3, 0), (3, 1), (3, 199), (33, 199), (129, 199)})

    def test_negative_zero_oracle_keeps_its_bits(self):
        self.assertEqual(COSTS.words([-0.0, 0.0], False), [1 << 63, 0])

    def test_roles_have_equal_position_counts(self):
        for position in range(4):
            self.assertEqual(Counter(COSTS.order(i)[position] for i in range(24)),
                             Counter({role: 6 for role in COSTS.ROLES}))

    def test_copy_noise_is_not_a_speed_pass(self):
        rows = []
        for number in range(24):
            for role in COSTS.order(number):
                value = {'candidate': 80, 'candidate-copy': 83,
                         'reference': 100, 'reference-copy': 100}[role]
                rows.append(dict(round=number, role=role, constructionNs=10,
                                 computationNs=value, releaseNs=10, loopNs=value + 20,
                                 processNs=200))
        result = COSTS.summarize(rows)
        self.assertEqual(result['ratios']['computationNs'], 0.8)
        self.assertFalse(result['computationQualified'])
        self.assertTrue(result['processQualified'])
        with self.assertRaises(AssertionError):
            COSTS.summarize(rows[:-1])

    def test_driver_does_not_change_measured_entry_body(self):
        generated = '/* measure : Array[F64] -> F64 */\nstatic V f7(V a) { return a; }\nint main(int argc, char **argv) { return 0; }'
        case = next(case for case in COSTS.programs() if case['name'] == 'array-16')
        result = COSTS.driver(generated, case, case['expected'])
        self.assertIn('static V f7(V a) { return a; }', result)
        self.assertIn('V result = f7(input);', result)
        self.assertNotIn('MEASURE_ENTRY', result)
        self.assertNotIn('INPUT_VALUE', result)
        for invalid in (generated * 2, generated.replace('/* measure :', '/* other :')):
            with self.assertRaises(AssertionError):
                COSTS.driver(invalid, case, case['expected'])


if __name__ == '__main__':
    unittest.main()
