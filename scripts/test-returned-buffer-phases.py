"""Reject malformed phase records before deriving any performance result."""
import json
import unittest

from returned_buffer_phases import decode_output


class PhaseRecords(unittest.TestCase):
    def test_exact_checksum_and_nonnegative_integer_phases(self):
        for shared in (0, 1):
            valid = dict(checksum=7864320 * (shared + 1), construction=10, reading=20, release=0)
            text = json.dumps(valid, separators=(',', ':')) + '\n'
            self.assertEqual(decode_output(text, 16, 4096, 16, shared), valid)
            for key in valid:
                for value in (-1, True, 1.0, '1', None):
                    damaged = dict(valid, **{key: value})
                    with self.subTest(shared=shared, key=key, value=value), self.assertRaises(AssertionError):
                        decode_output(json.dumps(damaged, separators=(',', ':')) + '\n', 16, 4096, 16, shared)
            for damaged in (dict(valid, checksum=1), dict(valid, process=20),
                            {key: value for key, value in valid.items() if key != 'release'}):
                with self.assertRaises(AssertionError):
                    decode_output(json.dumps(damaged, separators=(',', ':')) + '\n', 16, 4096, 16, shared)
            with self.assertRaises(AssertionError):
                decode_output(text.replace('{', '{"release":0,', 1), 16, 4096, 16, shared)
            with self.assertRaises((AssertionError, ValueError)):
                decode_output(text + text, 16, 4096, 16, shared)


if __name__ == '__main__':
    unittest.main()
