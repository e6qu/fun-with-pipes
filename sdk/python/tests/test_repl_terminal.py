"""Real terminal editing checks on POSIX; Windows SDK tests remain native."""
import errno
import os
from pathlib import Path
import re
import select
import signal
import struct
import subprocess
import tempfile
import time
import unittest

# These standard-library modules exist only on POSIX hosts.
if os.name == "posix":
    import fcntl
    import pty
    import termios


@unittest.skipUnless(os.name == "posix", "this terminal harness uses POSIX PTYs")
class Terminal(unittest.TestCase):
    def test_standalone_signals_allow_graceful_shutdown(self):
        # The REPL handler must not turn ordinary shutdown polling into a trap.
        with tempfile.TemporaryDirectory() as directory:
            source = Path(directory) / "shutdown.fwp"
            source.write_text('''main =
    signal.shutdown-requested ()
    | const ()
    | tap (const "ready" | eprint)
    | loop (if signal.shutdown-requested (const (Stop ())) (const (Again ())))
    | const "stopped"
    | echo
''', encoding="utf-8")
            for requested in (signal.SIGINT, signal.SIGTERM):
                with self.subTest(signal=requested):
                    with subprocess.Popen(
                        [os.environ["FWP_TEST_BIN"], "run", "--interp", str(source)],
                        stdin=subprocess.DEVNULL, stdout=subprocess.PIPE,
                        stderr=subprocess.PIPE,
                    ) as process:
                        try:
                            self.assertTrue(select.select([process.stderr], [], [], 20)[0],
                                            "shutdown program did not start")
                            ready = process.stderr.readline()
                            if not ready:
                                _, errors = process.communicate(timeout=20)
                                self.fail(f"shutdown program exited before readiness: {errors.decode()}")
                            self.assertEqual(ready, b"ready\n")
                            process.send_signal(requested)
                            output, errors = process.communicate(timeout=20)
                            self.assertEqual(process.returncode, 0, errors.decode())
                            self.assertEqual((output, errors), (b"stopped\n", b""))
                        finally:
                            if process.poll() is None:
                                process.kill()
                                process.communicate()

    def test_completion_history_multiline_and_interrupt(self):
        self.assertTrue(Path(os.environ["FWP_TEST_BIN"]).is_file(), "build fwp before terminal checks")
        with tempfile.TemporaryDirectory() as directory:
            history = Path(directory) / "history"
            pid, terminal = pty.fork()
            if pid == 0:
                os.environ["TERM"] = "xterm-256color"
                os.execv(os.environ["FWP_TEST_BIN"], [os.environ["FWP_TEST_BIN"], "repl", "--history", str(history)])
            fcntl.ioctl(terminal, termios.TIOCSWINSZ, struct.pack("HHHH", 40, 120, 0, 0))
            pending = ""
            def expect(text):
                nonlocal pending
                end = time.monotonic() + 20
                while text not in pending:
                    remaining = end - time.monotonic()
                    self.assertGreater(remaining, 0, f"missing {text!r}: {pending!r}")
                    if select.select([terminal], [], [], remaining)[0]:
                        data = os.read(terminal, 65536)
                        self.assertTrue(data, pending)
                        pending += re.sub(r"\x1b\[[0-?]*[ -/]*[@-~]", "", data.decode("utf-8", "replace"))
                pending = pending.split(text, 1)[1]
            def send(text):
                os.write(terminal, text.encode())
            try:
                expect("In [1]:")
                send("alpha = 7\r")
                expect("In [2]:")
                send("alph\t | add 1\r")
                expect("Out[2]: 8")
                expect("In [3]:")
                send("\x1b[A\r")
                expect("Out[3]: 8")
                expect("In [4]:")
                send("(2 +\r3)\r")
                expect("Out[4]: 5")
                expect("In [5]:")
                send("unfinished\x03")
                expect("In [5]:")
                send("6 * 7\r")
                expect("Out[5]: 42")
                expect("In [6]:")
                send(":paste\r")
                expect("...:")
                for line in ["forever : I64 -> I64", "forever = loop (add 1 | Again)"]:
                    send(line + "\r")
                    expect(line)
                    expect("\r\n")
                    expect("...:")
                send(":end\r")
                expect("In [7]:")
                # Wait for actual evaluation, not a guessed delay after input.
                # Interrupting editing/checking exercises a different path.
                send('0 | tap (const "loop started" | echo) | forever\r')
                expect("\r\nloop started\r\n")
                os.kill(pid, signal.SIGINT)
                expect("interrupted")
                expect("In [8]:")
                # The shutdown API installs its own handler. It must not disable
                # interruption of later REPL evaluations.
                send("signal.shutdown-requested ()\r")
                expect("Out[8]: False")
                expect("In [9]:")
                send('0 | tap (const "loop started" | echo) | forever\r')
                expect("\r\nloop started\r\n")
                os.kill(pid, signal.SIGINT)
                expect("interrupted")
                expect("In [10]:")
                send("1 + 2\r")
                expect("Out[10]: 3")
                expect("In [11]:")
                send(":quit\r")
                # Reap with a deadline: a terminal cleanup bug must fail, not hang.
                end = time.monotonic() + 10
                while True:
                    finished, status = os.waitpid(pid, os.WNOHANG)
                    if finished:
                        pid = None
                        self.assertEqual(os.waitstatus_to_exitcode(status), 0)
                        break
                    self.assertLess(time.monotonic(), end, "REPL did not exit")
                    # macOS TCSADRAIN waits for the PTY peer to consume output
                    # before restoring terminal mode. Keep reading while reaping.
                    if select.select([terminal], [], [], 0.02)[0]:
                        try:
                            os.read(terminal, 65536)
                        except OSError as error:
                            if error.errno != errno.EIO:  # Linux PTY end-of-file.
                                raise
                self.assertIn("alpha = 7", history.read_text())
                self.assertIn("alpha | add 1", history.read_text())
            finally:
                if pid is not None:
                    os.kill(pid, signal.SIGKILL)
                    os.waitpid(pid, 0)
                os.close(terminal)
