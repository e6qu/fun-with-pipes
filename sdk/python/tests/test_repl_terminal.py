"""Real terminal editing checks on POSIX; Windows SDK tests remain native."""
import os
from pathlib import Path
import re
import signal
import tempfile
import time
import unittest


@unittest.skipUnless(os.name == "posix", "this terminal harness uses POSIX PTYs")
class Terminal(unittest.TestCase):
    def test_completion_history_multiline_and_interrupt(self):
        import fcntl
        import pty
        import select
        import struct
        import termios

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
                send(":paste\rforever : I64 -> I64\rforever = loop (add 1 | Again)\r:end\r")
                expect("In [7]:")
                send("0 | forever\r")
                time.sleep(0.3)
                os.kill(pid, signal.SIGINT)
                expect("interrupted")
                expect("In [8]:")
                send("1 + 2\r")
                expect("Out[8]: 3")
                expect("In [9]:")
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
                    time.sleep(0.02)
                self.assertIn("alpha = 7", history.read_text())
                self.assertIn("alpha | add 1", history.read_text())
            finally:
                if pid is not None:
                    os.kill(pid, signal.SIGKILL)
                    os.waitpid(pid, 0)
                os.close(terminal)
