#!/usr/bin/env python3
"""Reject altered reference boundaries, wrong schedules and misleading timing controls."""
from collections import Counter
import importlib.util
from pathlib import Path
import unittest

from borrowed_array_reference import (
    DISABLED, FRESH_DISABLED, FRESH_SELECTION, SELECTION,
    fresh_reference_source, reference_source,
)

SPEC = importlib.util.spec_from_file_location('costs', Path(__file__).with_name('measure-borrowed-arrays.py'))
COSTS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(COSTS)
BUILDER_SPEC = importlib.util.spec_from_file_location('builder', Path(__file__).with_name('diagnose-array-builder.py'))
BUILDER = importlib.util.module_from_spec(BUILDER_SPEC)
BUILDER_SPEC.loader.exec_module(BUILDER)


class Costs(unittest.TestCase):
    def test_fresh_output_change_has_a_narrow_precondition(self):
        source = '''static const fwp_desc d0 = {K_F64, "F64", .width = 0, .dup = NULL, .drop = NULL};
static V fwp_hof0(V count) {
    fwp_array_builder result = {fwp_array_typed_new(n, &d0), 0, &d0};
    fwp_cleanup cleanup; fwp_array_builder_protect(&result, &cleanup);
    for (size_t index = 0; index < n; index++) {
        V value = callback(index);
        fwp_array_store_owned(result.value, index, value, &d0);
        result.filled++;
    }
    return fwp_array_builder_finish(&result, &cleanup);
}
'''
        changed, count = BUILDER.direct_stores(source)
        self.assertEqual(count, 1)
        self.assertIn('V value = callback(index);', changed)
        self.assertIn('fwp_array_builder_finish(&result, &cleanup)', changed)
        self.assertIn('memcpy(result_data + index * sizeof value, &value, sizeof value);', changed)
        self.assertNotIn('result.filled++', changed)
        for invalid in (source.replace('K_F64', 'K_F128'),
                        source.replace('.drop = NULL', '.drop = drop_value'),
                        source.replace('result.filled++;', 'result.filled += 2;')):
            with self.assertRaises(AssertionError):
                BUILDER.direct_stores(invalid)
        self.assertEqual(BUILDER.direct_stores('unchanged loop'), ('unchanged loop', 0))

    def test_only_selection_changes(self):
        source = 'prefix\n' + SELECTION + '\nsuffix\n'
        result = reference_source(source)
        self.assertEqual(result, 'prefix\n' + DISABLED + '\nsuffix\n')
        for invalid in ('no selection', source * 2, result):
            with self.assertRaises(AssertionError):
                reference_source(invalid)

    def test_fresh_output_reference_changes_only_selection(self):
        source = 'prefix\n' + FRESH_SELECTION + '    && exact_type;\nsuffix\n'
        self.assertEqual(fresh_reference_source(source),
                         source.replace(FRESH_SELECTION, FRESH_DISABLED))
        for invalid in ('missing selection', source * 2, fresh_reference_source(source)):
            with self.assertRaises(AssertionError):
                fresh_reference_source(invalid)

    def test_all_inputs_and_controls_are_present(self):
        cases = list(COSTS.programs())
        self.assertEqual(len(cases), 18)
        self.assertEqual(len({case['name'] for case in cases}), 18)
        self.assertEqual({case['count'] for case in cases if case['kind'] == 'array'},
                         {0, 16, 65537, 262145})
        for kind in ('local', 'manual'):
            self.assertEqual({(case['count'], case['updates']) for case in cases if case['kind'] == kind},
                             {(3, 0), (3, 1), (3, 199), (33, 199), (129, 199)})

    def test_each_transformation_requires_its_own_emitted_selection(self):
        case = dict(kind='array', updates=0)
        for mode, selected in (
            ('array-metadata', 'static V fwp_borrowed_array0(V *args, const unsigned char *data)'),
            ('fresh-array', 'memcpy(result_data + index * sizeof value, &value, sizeof value);'),
        ):
            COSTS.check_selection(dict(candidate=selected, reference='ordinary'), case, mode)
            for candidate, reference in (('ordinary', 'ordinary'), (selected, selected)):
                with self.assertRaises(AssertionError):
                    COSTS.check_selection(dict(candidate=candidate, reference=reference), case, mode)
        with self.assertRaises(AssertionError):
            COSTS.check_selection(dict(candidate='different', reference='loop'), dict(kind='loop'), 'fresh-array')

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
        damaged = [dict(row) for row in rows]
        damaged[0]['round'] = 1
        with self.assertRaises(AssertionError):
            COSTS.summarize(damaged)
        damaged = [dict(row) for row in rows]
        damaged[0]['computationNs'] = float('nan')
        with self.assertRaises(AssertionError):
            COSTS.summarize(damaged)

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
