#!/usr/bin/env python3
"""Check disk samples suspend the workload and errors keep stopping it."""
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest


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


if __name__ == '__main__':
    unittest.main()
