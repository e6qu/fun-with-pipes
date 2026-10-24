#!/usr/bin/env python3
"""Check disk samples suspend the workload and errors keep stopping it."""
import ast
import os
from pathlib import Path
import shutil
import signal
import subprocess
import sys
import tempfile
from types import SimpleNamespace
import unittest
from unittest.mock import Mock


class DiskSampling(unittest.TestCase):
    def run_guard(self, mode):
        with tempfile.TemporaryDirectory(prefix="fwp-guard-test-") as tmp:
            root = Path(tmp)
            (root / "scripts").mkdir()
            (root / "bin").mkdir()
            guard = root / "scripts/local-guard.py"
            shutil.copy2(Path(os.environ.get("FWP_GUARD_TEST_SOURCE",
                                          str(Path(__file__).with_name("local-guard.py")))), guard)
            sampler = root / "bin/du"
            sampler.write_text(r"""#!/usr/bin/env python3
import os, subprocess, sys
# The sampler and guarded command are children of the same guard process.
rows = subprocess.check_output(['ps', '-axo', 'pid=,ppid=,state='], text=True)
children = [state for line in rows.splitlines()
            for pid, parent, state in [line.split()]
            if int(parent) == os.getppid() and int(pid) != os.getpid()]
if not children or any('T' not in state for state in children):
    sys.stderr.write('workload was not suspended during disk sampling\n')
    sys.exit(9)
mode = os.environ['FWP_GUARD_TEST_MODE']
if mode == 'error':
    sys.stderr.write('injected sampler failure\n')
    sys.exit(7)
if mode == 'oversize':
    print(2 * 1024**2 + 1, sys.argv[-1])
    sys.exit(0)
os.execv('/usr/bin/du', ['du', *sys.argv[1:]])
""")
            sampler.chmod(0o755)
            marker = root / "completed"
            workload = "import pathlib,time; time.sleep(0.4); pathlib.Path(%r).write_text('done')" % str(marker)
            env = dict(os.environ, PATH=str(root / "bin") + os.pathsep + os.environ['PATH'],
                       FWP_GUARD_TEST_MODE=mode)
            result = subprocess.run([sys.executable, str(guard), sys.executable, '-c', workload],
                                    env=env, capture_output=True, text=True, timeout=10)
            return result, marker.exists()

    def test_sample_suspends_then_resumes_workload(self):
        result, completed = self.run_guard('normal')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertTrue(completed)

    def test_sampling_error_stops_workload(self):
        result, completed = self.run_guard('error')
        self.assertEqual(result.returncode, 1, result.stderr)
        self.assertIn('injected sampler failure', result.stderr)
        self.assertFalse(completed)

    def test_target_limit_still_stops_workload(self):
        result, completed = self.run_guard('oversize')
        self.assertEqual(result.returncode, 1, result.stderr)
        self.assertIn('target exceeded 2 GiB', result.stderr)
        self.assertFalse(completed)


class SignalExitRace(unittest.TestCase):
    def stop_function(self, child, tracked, killpg, kill):
        path = Path(os.environ.get("FWP_GUARD_TEST_SOURCE",
                                   str(Path(__file__).with_name("local-guard.py"))))
        tree = ast.parse(path.read_text())
        function, = [node for node in tree.body
                     if isinstance(node, ast.FunctionDef) and node.name == "stop"]
        namespace = dict(child=child, tracked=tracked,
                         os=SimpleNamespace(killpg=killpg, kill=kill),
                         subprocess=subprocess)
        exec(compile(ast.Module(body=[function], type_ignores=[]), str(path), "exec"),
             namespace)
        return namespace["stop"]

    def test_exiting_group_is_reaped_before_reporting_permission_failure(self):
        for sig in [signal.SIGSTOP, signal.SIGCONT, signal.SIGKILL]:
            with self.subTest(signal=sig):
                child = Mock(pid=100)
                child.poll.return_value = None
                def finish(timeout):
                    self.assertEqual(timeout, 0.1)
                    child.poll.return_value = 0
                    return 0
                child.wait.side_effect = finish
                killpg = Mock(side_effect=PermissionError("exiting group"))
                kill = Mock()
                self.stop_function(child, {100}, killpg, kill)(sig)
                child.wait.assert_called_once_with(timeout=0.1)
                killpg.assert_called_once_with(100, sig)
                kill.assert_not_called()

    def test_exiting_parent_does_not_skip_tracked_descendants(self):
        child = Mock(pid=100)
        child.poll.return_value = None
        def finish(timeout):
            child.poll.return_value = 0
            return 0
        child.wait.side_effect = finish
        killpg = Mock(side_effect=PermissionError("exiting group"))
        kill = Mock()
        self.stop_function(child, {100, 101}, killpg, kill)(signal.SIGKILL)
        kill.assert_called_once_with(101, signal.SIGKILL)

    def test_live_permission_failure_still_stops_guard(self):
        child = Mock(pid=100)
        child.poll.return_value = None
        child.wait.side_effect = subprocess.TimeoutExpired("workload", 0.1)
        error = PermissionError("live group")
        killpg = Mock(side_effect=error)
        kill = Mock()
        with self.assertRaises(PermissionError) as raised:
            self.stop_function(child, {100}, killpg, kill)(signal.SIGSTOP)
        self.assertIs(raised.exception, error)
        child.wait.assert_called_once_with(timeout=0.1)
        kill.assert_not_called()


if __name__ == '__main__':
    unittest.main()
