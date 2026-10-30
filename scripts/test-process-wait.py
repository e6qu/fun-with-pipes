#!/usr/bin/env python3
"""Check bounded child lifetimes and detect polling inside a measured wait."""
import os
from pathlib import Path
import signal
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

from process_wait import run_capture


class ProcessWait(unittest.TestCase):
    def run_child(self, source, timeout):
        return run_capture([sys.executable, '-c', source], env=dict(os.environ), cwd=None,
            input_data=None, input_stream=None, text=False, encoding='utf-8', timeout=timeout, check=False)

    def test_results_and_explicit_failure_keep_both_streams(self):
        for status in [0, 7]:
            result = self.run_child(f'import os, sys; os.write(1, b"out\\n"); os.write(2, b"err\\n"); sys.exit({status})', 5)
            self.assertEqual((result.returncode, result.stdout, result.stderr), (status, b'out\n', b'err\n'))
        with self.assertRaises(subprocess.CalledProcessError) as caught:
            run_capture([sys.executable, '-c', 'import os; os.write(1, b"failed\\n"); raise SystemExit(9)'],
                env=dict(os.environ), cwd=None, input_data=None, input_stream=None,
                text=False, encoding='utf-8', timeout=5, check=True)
        self.assertEqual(caught.exception.stdout, b'failed\n')

    def test_input_text_stream_and_directory_are_explicit(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / 'input'
            path.write_bytes('λ\n'.encode())
            for streamed in [False, True]:
                with path.open('rb') as stream:
                    result = run_capture([sys.executable, '-c', 'import sys; print(open("input", encoding="utf-8").read(), end=""); print(sys.stdin.read(), end="")'],
                        env=dict(os.environ, PYTHONIOENCODING='utf-8'), cwd=directory, input_data=None if streamed else 'λ\n',
                        input_stream=stream if streamed else None, text=True, encoding='utf-8', timeout=5, check=True)
                self.assertEqual(result.stdout, 'λ\nλ\n')

    def test_deadline_retains_partial_output(self):
        with self.assertRaises(subprocess.TimeoutExpired) as caught:
            self.run_child('import os, time; os.write(1, b"started\\n"); time.sleep(60)', 0.5)
        self.assertEqual(caught.exception.stdout, b'started\n')

    def test_deadline_after_output_closes_still_reaps(self):
        with self.assertRaises(subprocess.TimeoutExpired) as caught:
            self.run_child('import os, time; os.close(1); os.close(2); time.sleep(60)', 0.5)
        self.assertEqual(caught.exception.stdout, b'')

    def test_text_deadline_keeps_raw_incomplete_characters(self):
        with self.assertRaises(subprocess.TimeoutExpired) as caught:
            run_capture([sys.executable, '-c',
                'import os, time; os.write(1, bytes([13, 10, 206])); time.sleep(60)'],
                env=dict(os.environ), cwd=None, input_data=None, input_stream=None,
                text=True, encoding='utf-8', timeout=0.5, check=False)
        self.assertEqual(caught.exception.stdout, b'\r\n\xce')

    def test_cancellation_reaps_the_child(self):
        communicate = subprocess.Popen.communicate
        children = []

        def interrupted(child, *args, **kwargs):
            if not children:
                children.append(child)
                raise KeyboardInterrupt
            return communicate(child, *args, **kwargs)

        with patch.object(subprocess.Popen, 'communicate', interrupted), self.assertRaises(KeyboardInterrupt):
            self.run_child('import time; time.sleep(60)', 5)
        self.assertIsNotNone(children[0].returncode)
        if os.name == 'posix':
            with self.assertRaises(ChildProcessError):
                os.waitpid(children[0].pid, os.WNOHANG)

    @unittest.skipUnless(os.name == 'posix', 'POSIX signal ownership')
    def test_signal_handler_mask_and_timer_are_restored(self):
        def previous(signum, frame):
            raise AssertionError('a completed measurement left a live timer')

        original = signal.signal(signal.SIGALRM, previous)
        mask = signal.pthread_sigmask(signal.SIG_BLOCK, set())
        try:
            for source, timeout in [('print("done")', 5), ('import time; time.sleep(60)', 0.1)]:
                try:
                    self.run_child(source, timeout)
                except subprocess.TimeoutExpired:
                    pass
                self.assertIs(signal.getsignal(signal.SIGALRM), previous)
                self.assertEqual(signal.getitimer(signal.ITIMER_REAL), (0.0, 0.0))
                self.assertEqual(signal.pthread_sigmask(signal.SIG_BLOCK, set()), mask)
                self.assertNotIn(signal.SIGALRM, signal.sigpending())
        finally:
            signal.signal(signal.SIGALRM, original)

    @unittest.skipUnless(os.name == 'posix', 'POSIX signal ownership')
    def test_existing_timer_and_blocked_signal_are_rejected(self):
        signal.setitimer(signal.ITIMER_REAL, 10)
        try:
            with self.assertRaisesRegex(RuntimeError, 'already active or blocked'):
                self.run_child('import time; time.sleep(60)', 5)
            self.assertGreater(signal.getitimer(signal.ITIMER_REAL)[0], 0)
        finally:
            signal.setitimer(signal.ITIMER_REAL, 0)
        mask = signal.pthread_sigmask(signal.SIG_BLOCK, {signal.SIGALRM})
        try:
            with self.assertRaisesRegex(RuntimeError, 'already active or blocked'):
                self.run_child('import time; time.sleep(60)', 5)
            self.assertIn(signal.SIGALRM, signal.pthread_sigmask(signal.SIG_BLOCK, set()))
        finally:
            signal.pthread_sigmask(signal.SIG_SETMASK, mask)

    @unittest.skipUnless(os.name == 'posix', 'POSIX waitpid polling control')
    def test_eof_before_exit_uses_no_polling_sleep(self):
        with tempfile.TemporaryDirectory() as directory:
            release = Path(directory) / 'release'
            source = ('import os, time\nfrom pathlib import Path\np=Path(' + repr(str(release)) + ')\n'
                      'os.close(1)\nos.close(2)\nwhile not p.exists():\n time.sleep(0.001)\n')
            wait = subprocess.Popen.wait
            observed = []

            def blocking(child, timeout=None):
                observed.append(timeout)
                self.assertIsNone(timeout, 'measurement must use the blocking wait')
                release.write_text('exit')
                return wait(child, timeout=timeout)

            with patch.object(subprocess.Popen, 'wait', blocking), patch.object(subprocess.time, 'sleep', side_effect=AssertionError('polling sleep')):
                result = self.run_child(source, 5)
            self.assertEqual(result.returncode, 0)
            self.assertTrue(observed)
            # Restore the unwanted timed communicate call and prove the check
            # rejects it. Do not require a particular stdlib sleep: Python 3.15
            # can wait through kqueue/pidfd instead of polling. Use run_capture
            # so a failing control kills and reaps the child before context exit.
            release.unlink()
            observed.clear()
            children = []

            def timed_communicate(child, timeout, input_data):
                children.append(child)
                return child.communicate(input=input_data, timeout=timeout)

            with patch('process_wait.communicate', timed_communicate), patch.object(subprocess.Popen, 'wait', blocking):
                with self.assertRaisesRegex(AssertionError, 'measurement must use the blocking wait'):
                    self.run_child(source, 5)
            self.assertTrue(any(timeout is not None for timeout in observed))
            self.assertIsNotNone(children[0].returncode)
            with self.assertRaises(ChildProcessError):
                os.waitpid(children[0].pid, os.WNOHANG)

    def test_invalid_deadline_and_conflicting_input_are_rejected(self):
        for deadline in [0, -1, float('inf'), float('nan')]:
            with self.assertRaises(ValueError):
                self.run_child('raise AssertionError("must not start")', deadline)
        with self.assertRaises(ValueError):
            run_capture([sys.executable, '-c', 'raise AssertionError("must not start")'],
                env=dict(os.environ), cwd=None, input_data=b'x', input_stream=subprocess.DEVNULL,
                text=False, encoding='utf-8', timeout=5, check=True)


if __name__ == '__main__':
    print(f'Process wait controls: {sys.version}', flush=True)
    unittest.main()
