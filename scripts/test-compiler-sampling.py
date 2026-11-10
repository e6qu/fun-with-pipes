#!/usr/bin/env python3
"""Keep unmatched and unresolved samples; reject malformed CPU reports."""
import unittest

from compiler_sampling import REGISTER_WARNING, histogram, recording_messages


class CompilerSamplingTests(unittest.TestCase):
    def test_recording_diagnostics_remain_strict(self):
        recording_messages(REGISTER_WARNING+'\n[ perf record: Woken up 1 times to write data ]\n')
        recording_messages('[ perf record: Captured and wrote 0.100 MB output.data (10 samples) ]\n')
        for text in ('WARNING: lost samples', '[ perf record: Captured and wrote LOST samples ]',
                     'Error: permission denied', 'WARNING: other unwind error'):
            with self.subTest(text=text), self.assertRaises(AssertionError):
                recording_messages(text)

    def test_unresolved_and_unmatched_samples_are_retained(self):
        prefix = '# Total Lost Samples: 0\n# Event count (approx.): 10000\n'
        text = (prefix+'# Overhead\tSamples\tPeriod\tParent symbol\tShared Object\tSymbol\n'
                '60.00%\t6\t6000\tfwp::infer::Infer::check_binding\tfwp\t[.] infer_expr\n'
                '40.00%\t4\t4000\t[other]\t[unknown]\t[.] 0x1234\n')
        rows = histogram(text, True)
        self.assertEqual(sum(row['samples'] for row in rows), 10)
        self.assertEqual(sum(row['period'] for row in rows), 10000)
        self.assertEqual(rows[1]['parent'], '[other]')
        self.assertEqual(rows[1]['symbol'], '[.] 0x1234')
        plain = prefix+'# Overhead\tSamples\tPeriod\tShared Object\tSymbol\n100.00%\t10\t10000\tfwp\t[.] infer_expr\n'
        self.assertEqual(histogram(plain, False)[0]['samples'], 10)
        with_ipc = plain.replace('Object\tSymbol\n', 'Object\tSymbol\tIPC   [IPC Coverage]\n').replace('infer_expr\n', 'infer_expr\t-      -\n')
        self.assertEqual(histogram(with_ipc, False), histogram(plain, False))
        for invalid in (plain.replace('Samples: 0', 'Samples: 1'), plain.replace('approx.): 10000', 'approx.): 9999'),
                        with_ipc.replace('-      -', '1.00 [100%]'), with_ipc.replace('IPC   [IPC Coverage]', 'Other')):
            with self.assertRaises(AssertionError):
                histogram(invalid, False)

    def test_invalid_reports_fail(self):
        for text in ('', '# header only\n', '100.00%\t1\t1\tfwp\n',
                     'nan\t1\t1\tfwp\tsymbol', '101%\t1\t1\tfwp\tsymbol',
                     '1%\t0\t1\tfwp\tsymbol', '1%\t1\t0\tfwp\tsymbol',
                     '1%\t-1\t1\tfwp\tsymbol', 'warning: lost samples'):
            with self.subTest(text=text), self.assertRaises((AssertionError, ValueError)):
                histogram(text, False)


if __name__ == '__main__':
    unittest.main()
