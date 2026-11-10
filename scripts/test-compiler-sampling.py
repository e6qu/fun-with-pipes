#!/usr/bin/env python3
"""Keep unmatched and unresolved samples; reject malformed CPU reports."""
from contextlib import ExitStack, redirect_stdout
import io
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

import compiler_sampling
from compiler_sampling import REGISTER_WARNING, histogram, recording_messages


class CompilerSamplingTests(unittest.TestCase):
    def test_application_results_survive_sample_iteration_and_child_failure(self):
        for failed in (False, True):
            with self.subTest(failed=failed), tempfile.TemporaryDirectory() as temporary:
                root = Path(temporary)
                compiler = root/'fwp'
                compiler.write_bytes(b'compiler identity')
                output = root/'results'
                attempted = []

                def child(command, **settings):
                    if 'build' in command:
                        destination = Path(command[-1])
                        attempted.append(destination.parent.name)
                        if failed and destination.parent.name == 'words':
                            return subprocess.CompletedProcess(command, 2, b'', b'deliberate child failure')
                        destination.write_bytes(b'int main(void) { return 0; }\n')
                        usage = Path(command[command.index('/usr/bin/time')+3])
                        usage.write_text('Maximum resident set size (kbytes): 1234\nUser time (seconds): 0.10\nSystem time (seconds): 0.01\n')
                        return subprocess.CompletedProcess(command, 0, b'', b'')
                    if 'report' in command:
                        parent = '--parent' in command
                        heading = '# Overhead\tSamples\tPeriod\t'+('Parent symbol\t' if parent else '')+'Shared Object\tSymbol\tIPC   [IPC Coverage]\n'
                        caller = '<fwp::infer::Infer>::check_binding\t' if parent else ''
                        text = '# Total Lost Samples: 0\n# Event count (approx.): 7000\n'+heading+'100%\t7\t7000\t'+caller+'fwp\t[.] clone\t- -\n'
                        return subprocess.CompletedProcess(command, 0, text, '')
                    self.assertIn('--format=rust', command)
                    return subprocess.CompletedProcess(command, 0, settings['input_data'], '')

                arguments = ['compiler_sampling.py', '--compiler', str(compiler), '--perf', '/perf',
                    '--time', '/usr/bin/time', '--cc', 'gcc', '--cpu', '0', '--frequency', '997',
                    '--stack-bytes', '32768', '--ring-bytes', '262144', '--user-registers',
                    ','.join(compiler_sampling.CORE_REGISTERS['aarch64']), '--demangler', '/c++filt',
                    '--deadline', '120', '--output', str(output)]
                with ExitStack() as stack:
                    stack.enter_context(patch.dict(os.environ, GITHUB_ACTIONS='true', CARGO_PROFILE_RELEASE_DEBUG='2'))
                    stack.enter_context(patch.object(sys, 'argv', arguments))
                    stack.enter_context(patch.object(compiler_sampling.platform, 'system', return_value='Linux'))
                    stack.enter_context(patch.object(compiler_sampling.platform, 'machine', return_value='aarch64'))
                    stack.enter_context(patch.object(compiler_sampling.platform, 'platform', return_value='test kernel'))
                    stack.enter_context(patch.object(os, 'sched_getaffinity', return_value={0}, create=True))
                    stack.enter_context(patch.object(os, 'sched_setaffinity', create=True))
                    stack.enter_context(patch.object(subprocess, 'check_output', return_value='test identity\n'))
                    stack.enter_context(patch.object(compiler_sampling, 'run_capture', side_effect=child))
                    stack.enter_context(redirect_stdout(io.StringIO()))
                    if failed:
                        with self.assertRaises(AssertionError):
                            compiler_sampling.main()
                    else:
                        compiler_sampling.main()
                report = json.loads((output/'summary.json').read_text())
                self.assertEqual(set(attempted), set(compiler_sampling.APPLICATIONS))
                self.assertEqual(report['failures'], ['words'] if failed else [])
                for name, application in report['applications'].items():
                    self.assertEqual(application['correct'], not (failed and name == 'words'))
                    if application['correct']:
                        self.assertEqual(application['all-symbols']['samples'], 7)
                        self.assertEqual(application['checking-parents']['samples'], 7)

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
