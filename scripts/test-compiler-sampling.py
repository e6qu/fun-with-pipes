#!/usr/bin/env python3
"""Keep unmatched and unresolved samples; reject malformed CPU reports."""
import unittest

from compiler_sampling import histogram


class CompilerSamplingTests(unittest.TestCase):
    def test_unresolved_and_unmatched_samples_are_retained(self):
        text = ('# Overhead\tSamples\tPeriod\tParent\tShared Object\tSymbol\n'
                '60.00%\t6\t6000\tfwp::infer::Infer::check_binding\tfwp\t[.] infer_expr\n'
                '40.00%\t4\t4000\t[other]\t[unknown]\t[.] 0x1234\n')
        rows = histogram(text, True)
        self.assertEqual(sum(row['samples'] for row in rows), 10)
        self.assertEqual(sum(row['period'] for row in rows), 10000)
        self.assertEqual(rows[1]['parent'], '[other]')
        self.assertEqual(rows[1]['symbol'], '[.] 0x1234')
        plain = '100.00%\t10\t10000\tfwp\t[.] infer_expr\n'
        self.assertEqual(histogram(plain, False)[0]['samples'], 10)

    def test_invalid_reports_fail(self):
        for text in ('', '# header only\n', '100.00%\t1\t1\tfwp\n',
                     'nan\t1\t1\tfwp\tsymbol', '101%\t1\t1\tfwp\tsymbol',
                     '1%\t0\t1\tfwp\tsymbol', '1%\t1\t0\tfwp\tsymbol',
                     '1%\t-1\t1\tfwp\tsymbol', 'warning: lost samples'):
            with self.subTest(text=text), self.assertRaises((AssertionError, ValueError)):
                histogram(text, False)


if __name__ == '__main__':
    unittest.main()
