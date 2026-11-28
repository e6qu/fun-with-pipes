"""Observe one GNU-time child at exec/exit; preserve counter and mapping scopes."""
import ctypes
import hashlib
import json
import os
from pathlib import Path
import re
import signal
import subprocess
import time

from nested_resource_memory import categories, fast_counters
from parser_process_memory import mappings, summary

CONT = 7
SETOPTIONS = 0x4200
GETEVENTMSG = 0x4201
OPTIONS = 2 | 4 | 8 | 16 | 64 | (1 << 20)
EVENTS = {1: 'fork', 2: 'vfork', 3: 'clone', 4: 'exec', 6: 'exit-stop'}
WALL = 0x40000000
LIBC = ctypes.CDLL(None, use_errno=True)
LIBC.ptrace.argtypes = (ctypes.c_uint, ctypes.c_int, ctypes.c_void_p, ctypes.c_void_p)
LIBC.ptrace.restype = ctypes.c_long


def trace(request, pid, data=0):
    result = LIBC.ptrace(request, pid, None, data)
    if result == -1:
        number = ctypes.get_errno()
        raise OSError(number, os.strerror(number))
    return result


def snapshot(pid, folder, index):
    raw = {}
    files = {}
    for name in ('smaps', 'status', 'statm'):
        with Path(f'/proc/{pid}/{name}').open() as stream:
            raw[name] = stream.read(4 * 1024 * 1024 + 1)
        assert len(raw[name]) <= 4 * 1024 * 1024
        path = folder / f'{index}-{name}.txt'
        path.write_text(raw[name])
        files[name] = dict(file=path.name, sha256=hashlib.sha256(raw[name].encode()).hexdigest())
    assert re.search(r'^State:\s+t\b', raw['status'], re.M), 'tracee is not stopped'
    assert re.search(r'^Threads:\s+1$', raw['status'], re.M), 'requires a single-threaded tracee'
    executable = os.readlink(f'/proc/{pid}/exe')
    with Path(f'/proc/{pid}/exe').open('rb') as stream:
        executable_hash = hashlib.file_digest(stream, 'sha256').hexdigest()
    rows = mappings(raw['smaps'])
    return dict(files=files, executable=executable, executableSha256=executable_hash, metrics=summary(rows),
                categories=categories(rows, Path(executable)),
                fast=fast_counters(raw['status'], raw['statm'], os.sysconf('SC_PAGE_SIZE')))


def observe(launcher, command, environment, folder, timeout=30):
    """Trace GNU time and its one child. Reject extra processes/threads explicitly."""
    assert 0 < timeout <= 30
    folder.mkdir(parents=True, exist_ok=False)
    record = dict(command=list(map(str, command)), events=[], failure=None, cleanup=[])
    live = set()
    known = set()
    reaped = set()
    initial_stops = set()
    deadline = time.monotonic() + timeout
    child = None
    with (folder / 'stdout.txt').open('wb') as output, (folder / 'stderr.txt').open('wb') as errors:
        try:
            child = subprocess.Popen([str(launcher), str(os.getpid()), *record['command']],
                                     env=environment, stdin=subprocess.DEVNULL,
                                     stdout=output, stderr=errors, start_new_session=True)
            record['root'] = child.pid
            live.add(child.pid)
            known.add(child.pid)
            configured = False
            forks = 0
            while live:
                assert time.monotonic() < deadline, 'exec memory deadline'
                assert len(record['events']) < 128, 'exec memory event limit'
                pid, status, usage = os.wait4(-1, os.WNOHANG | WALL)
                if not pid:
                    time.sleep(.001)
                    continue
                known.add(pid)
                event = dict(index=len(record['events']), pid=pid, rawStatus=status,
                             wait4PeakRssKiB=usage.ru_maxrss)
                record['events'].append(event)
                if os.WIFEXITED(status) or os.WIFSIGNALED(status):
                    event.update(kind='reaped', status=os.waitstatus_to_exitcode(status))
                    live.discard(pid)
                    reaped.add(pid)
                    if pid == child.pid:
                        child.returncode = event['status']
                    continue
                assert os.WIFSTOPPED(status), 'unknown wait state'
                live.add(pid)
                stop = os.WSTOPSIG(status)
                kind = status >> 16
                event.update(kind=EVENTS.get(kind, 'signal'), signal=stop)
                if not configured:
                    assert pid == child.pid and stop == signal.SIGSTOP and kind == 0
                    trace(SETOPTIONS, pid, OPTIONS)
                    configured = True
                    event['kind'] = 'launcher-stop'
                elif kind in (1, 2, 3):
                    new_pid = ctypes.c_ulong()
                    trace(GETEVENTMSG, pid, ctypes.byref(new_pid))
                    event['child'] = new_pid.value
                    known.add(new_pid.value)
                    if new_pid.value not in reaped:
                        live.add(new_pid.value)
                    forks += 1
                    assert forks == 1 and pid == child.pid and kind in (1, 2), 'unexpected process or thread'
                    record['target'] = new_pid.value
                elif kind == 6:
                    exit_status = ctypes.c_ulong()
                    trace(GETEVENTMSG, pid, ctypes.byref(exit_status))
                    event['exitStatus'] = exit_status.value
                elif kind:
                    assert kind == 4, 'unknown ptrace event'
                if stop == signal.SIGSTOP and not kind:
                    assert pid not in initial_stops, 'unexpected repeated SIGSTOP'
                    initial_stops.add(pid)
                if kind or stop == signal.SIGSTOP:
                    event['snapshot'] = snapshot(pid, folder, event['index'])
                # Suppress only protocol stops. Ordinary signals keep their meaning.
                trace(CONT, pid, 0 if kind or stop == signal.SIGSTOP else stop)
            assert forks == 1 and child.returncode == 0, 'launcher or timed process failed'
            record['status'] = child.returncode
        except BaseException as error:
            record['failure'] = str(error)
            raise
        finally:
            if child is not None and live:
                try:
                    os.killpg(child.pid, signal.SIGKILL)
                except ProcessLookupError:
                    pass
                for pid in live:
                    try:
                        os.kill(pid, signal.SIGKILL)
                    except ProcessLookupError:
                        pass
                cleanup_deadline = time.monotonic() + 5
                while live and time.monotonic() < cleanup_deadline:
                    try:
                        pid, status = os.waitpid(-1, os.WNOHANG | WALL)
                    except ChildProcessError:
                        live.clear()
                        break
                    if not pid:
                        time.sleep(.001)
                        continue
                    if os.WIFSTOPPED(status):
                        try:
                            trace(CONT, pid, signal.SIGKILL)
                        except ProcessLookupError:
                            pass
                    else:
                        record['cleanup'].append(pid)
                        live.discard(pid)
                        if pid == child.pid:
                            child.returncode = os.waitstatus_to_exitcode(status)
                record['unreaped'] = sorted(live)
            record['known'] = sorted(known)
            (folder / 'observation.json').write_text(json.dumps(record, indent=2) + '\n')
            assert not live, 'exec memory cleanup left a live tracee'
    return record
