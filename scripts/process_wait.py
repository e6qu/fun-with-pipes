"""Bound captured child processes without adding polling sleeps to POSIX timings.

A Windows timeout uses the kernel wait. POSIX measurements run serially in the
main thread and reserve SIGALRM while communicating, then restore its state.
"""
import math
import os
import signal
import subprocess
import threading

WAIT_POLICY = 'windows-kernel' if os.name == 'nt' else 'posix-alarm'


def communicate(child, timeout, input_data):
    """Capture through exit with an explicit deadline, without timed waitpid polling."""
    if not math.isfinite(timeout) or timeout <= 0:
        raise ValueError('a finite positive child deadline is required')
    if os.name == 'nt':
        return child.communicate(input=input_data, timeout=timeout)
    if os.name != 'posix' or threading.current_thread() is not threading.main_thread():
        raise RuntimeError('POSIX measurement deadlines require the main thread')
    previous_mask = signal.pthread_sigmask(signal.SIG_BLOCK, {signal.SIGALRM})
    if (signal.SIGALRM in previous_mask or signal.SIGALRM in signal.sigpending()
            or signal.getitimer(signal.ITIMER_REAL) != (0.0, 0.0)):
        signal.pthread_sigmask(signal.SIG_SETMASK, previous_mask)
        raise RuntimeError('measurement cannot take an already active or blocked SIGALRM')

    def deadline(signum, frame):
        raise subprocess.TimeoutExpired(child.args, timeout)

    previous_handler = signal.signal(signal.SIGALRM, deadline)
    completed = False
    pending = False
    try:
        signal.setitimer(signal.ITIMER_REAL, timeout)
        signal.pthread_sigmask(signal.SIG_SETMASK, previous_mask)
        result = child.communicate(input=input_data)
        completed = True
    finally:
        # Block and drain a deadline already pending before restoring the old
        # handler: it must never arrive later under SIG_DFL or another owner.
        signal.pthread_sigmask(signal.SIG_BLOCK, {signal.SIGALRM})
        signal.setitimer(signal.ITIMER_REAL, 0.0)
        pending = signal.SIGALRM in signal.sigpending()
        if pending:
            signal.sigwait({signal.SIGALRM})
        signal.signal(signal.SIGALRM, previous_handler)
        signal.pthread_sigmask(signal.SIG_SETMASK, previous_mask)
    if completed and pending:
        raise subprocess.TimeoutExpired(child.args, timeout, output=result[0], stderr=result[1])
    return result


def run_capture(command, *, env, cwd, input_data, input_stream, text, encoding, timeout, check):
    """Run with explicit stream/environment settings; reap on deadline or cancellation."""
    if input_data is not None and input_stream is not None:
        raise ValueError('choose input bytes/text or an input stream, not both')
    if not math.isfinite(timeout) or timeout <= 0:
        raise ValueError('a finite positive child deadline is required')
    encoded_input = input_data.encode(encoding) if text and input_data is not None else input_data
    # Capture bytes even for text results so a deadline retains exact partial
    # output, including incomplete characters and original newline bytes.
    with subprocess.Popen(command, env=env, cwd=cwd,
            stdin=subprocess.PIPE if input_data is not None else input_stream,
            stdout=subprocess.PIPE, stderr=subprocess.PIPE, start_new_session=os.name == 'posix') as child:
        try:
            stdout, stderr = communicate(child, timeout, encoded_input)
        except BaseException as error:
            try:
                if child.returncode is None:
                    if os.name == 'posix':
                        os.killpg(child.pid, signal.SIGKILL)
                    else:
                        child.kill()
            except ProcessLookupError:
                pass
            stdout, stderr = child.communicate()
            if isinstance(error, subprocess.TimeoutExpired):
                error.output, error.stderr = stdout, stderr
            raise
        if text:
            stdout = stdout.decode(encoding).replace('\r\n', '\n').replace('\r', '\n')
            stderr = stderr.decode(encoding).replace('\r\n', '\n').replace('\r', '\n')
        result = subprocess.CompletedProcess(command, child.returncode, stdout, stderr)
        if check:
            result.check_returncode()
        return result
