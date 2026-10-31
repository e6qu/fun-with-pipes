"""Protect the binary measurements and frozen State range acceptance limits."""
import importlib.util
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location('state_range_size', Path(__file__).with_name('check-state-range-size.py'))
SIZE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(SIZE)


class StateRangeSizeTests(unittest.TestCase):
    def test_counts_workers_and_clones_once_but_not_shared_runtime(self):
        text = '''00000010 00000010 t f1
00000010 00000010 t w1
00000020 00000008 t fwp_loop_fields2.constprop.0
00000028 00000008 t e3
00000030 00000020 t fwp_heap_alloc
00000050 00000008 d fwp_fn_table
'''
        symbols = SIZE.worker_symbols(text, 'f1')
        self.assertEqual(SIZE.worker_bytes(symbols), 32)
        self.assertEqual(set(symbols), {'f1', 'w1', 'fwp_loop_fields2.constprop.0', 'e3'})
        with self.assertRaisesRegex(AssertionError, 'missing entry'):
            SIZE.worker_symbols(text, 'f9')
        with self.assertRaises(AssertionError):
            SIZE.worker_symbols(text + '00000024 00000008 t f4\n', 'f1')

    def test_code_and_frame_fail_independently_without_rounding(self):
        reference = dict(workerBytes=1000, largestFrameBytes=128)
        self.assertEqual(SIZE.limits(reference, dict(workerBytes=1050, largestFrameBytes=192)),
                         dict(code=True, stack=True))
        self.assertEqual(SIZE.limits(reference, dict(workerBytes=1051, largestFrameBytes=128)),
                         dict(code=False, stack=True))
        self.assertEqual(SIZE.limits(reference, dict(workerBytes=900, largestFrameBytes=193)),
                         dict(code=True, stack=False))


if __name__ == '__main__':
    unittest.main()
