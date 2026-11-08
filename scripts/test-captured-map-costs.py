#!/usr/bin/env python3
"""Check captured-map measurement inputs and the isolated compiler reference."""
import importlib.util
from pathlib import Path
import struct
import tempfile
import unittest

from borrowed_array_reference import CAPTURED_DISABLED, CAPTURED_SELECTION, captured_reference_source
from captured_map_costs import cases, driver, expected, program, raw_program


SPEC = importlib.util.spec_from_file_location('audit', Path(__file__).with_name('audit-captured-maps.py'))
AUDIT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(AUDIT)


class CapturedMapCosts(unittest.TestCase):
    def test_reference_disables_only_partial_callback_selection(self):
        source = Path('src/cgen/owned_numeric.rs').read_text()
        reference = captured_reference_source(source)
        self.assertEqual(reference.replace(CAPTURED_DISABLED, CAPTURED_SELECTION), source)
        self.assertIn('Expr::Func(step) => (*step, 0),', reference)
        for broken in (source + CAPTURED_SELECTION, reference, source.replace(CAPTURED_SELECTION, '')):
            with self.assertRaises(AssertionError):
                captured_reference_source(broken)

    def test_inputs_cover_both_applications_sizes_update_counts_and_aliases(self):
        rows = list(cases())
        self.assertEqual(len(rows), 48)
        self.assertEqual(len({row['name'] for row in rows}), 48)
        self.assertEqual({row['sharing'] for row in rows}, {0, 1, 2})
        self.assertEqual(expected('pixels', 17, 199), list(range(199, 216)))
        words = [struct.unpack('>Q', struct.pack('>d', value))[0] for value in (49.75, 50.75)]
        self.assertEqual(expected('sensor', 2, 199), words)
        self.assertEqual(expected('pixels', 0, 199), [])
        with self.assertRaises(AssertionError):
            expected('pixels', 17, 256)

    def test_independent_checksum_and_native_image_checks(self):
        case = dict(kind='pixels', count=3, updates=1, repeats=1)
        self.assertEqual(AUDIT.checksum(case), 1 ^ 2 ^ 3)
        self.assertIn('measure 1u8 1u8 1', raw_program(case))
        case['updates'] = 2
        self.assertEqual(AUDIT.checksum(case), 2 ^ 3 ^ 4)
        with tempfile.TemporaryDirectory() as folder:
            path = Path(folder) / 'image'
            data = bytearray(64)
            data[:6] = b'\x7fELF\x02\x01'
            data[18:20] = (183).to_bytes(2, 'little')
            path.write_bytes(data)
            self.assertEqual(len(AUDIT.native_hash(path, 'aarch64')), 64)
            with self.assertRaises(AssertionError):
                AUDIT.native_hash(path, 'x86_64')
            for invalid in (data[:32], b'not an executable' * 8):
                path.write_bytes(invalid)
                with self.assertRaises(AssertionError):
                    AUDIT.native_hash(path, 'aarch64')

    def test_driver_requires_the_declared_entry_and_keeps_coefficients_opaque(self):
        generated = '/* measure : */\nstatic V f0(V l0, V l1, V l2, V l3) {}\nint main(int argc, char **argv) {}'
        for case in cases():
            text = driver(generated, case)
            self.assertIn('f0(scale, offset, updates, input)', text)
            self.assertIn('"+r"(scale)', text)
            self.assertIn('fwp_rc_free_arr(alias)', text)
            self.assertIn('fwp_heap.live != initial', text)
        with self.assertRaises(AssertionError):
            driver(generated.replace('V l2, V l3', 'V l2'), next(cases()))
        self.assertIn('value * scale + offset', program('sensor'))
        self.assertIn('Array[U8]', program('pixels'))


if __name__ == '__main__':
    unittest.main()
