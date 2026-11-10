"""Sample the observer's own unchanged child; page walks are not transient peaks."""
import hashlib
import json
import os
from pathlib import Path
import re
import signal
import subprocess
import time

from parser_process_memory import mappings, summary


def fast_counters(status, statm, page_bytes):
    result = {}
    for key in ('VmHWM', 'VmRSS', 'RssAnon', 'RssFile', 'RssShmem'):
        values = re.findall(r'^' + key + r':\s*([0-9]+) kB$', status, re.M)
        assert len(values) == 1, (key, values)
        result[key + 'KiB'] = int(values[0])
    fields = statm.split()
    assert len(fields) == 7 and all(value.isdecimal() for value in fields)
    assert page_bytes > 0 and page_bytes % 1024 == 0
    result['statmResidentKiB'] = int(fields[1]) * (page_bytes // 1024)
    return result


def categories(rows, executable):
    groups = {name: [] for name in ('heap', 'stack', 'executable', 'otherFiles', 'otherMappings')}
    for row in rows:
        name = row['name']
        key = ('heap' if name == '[heap]' else 'stack' if name.startswith('[stack')
               else 'executable' if name == str(executable)
               else 'otherFiles' if name.startswith('/') else 'otherMappings')
        groups[key].append(row)
    return {key: summary(value) for key, value in groups.items()}


def observe(command, environment, folder, interval, timeout, limit):
    assert interval == .05 and timeout == 30 and limit == 600
    folder.mkdir(parents=True, exist_ok=False)
    deadline = time.monotonic() + timeout
    snapshots = []
    record = dict(command=list(map(str, command)), snapshots=snapshots, failure=None)
    with (folder / 'stdout.txt').open('wb') as output, (folder / 'stderr.txt').open('wb') as errors:
        child = subprocess.Popen(record['command'], env=environment, stdin=subprocess.DEVNULL,
                                 stdout=output, stderr=errors)
        record['pid'] = child.pid

        def event():
            pid, status, usage = os.wait4(child.pid, os.WNOHANG | os.WUNTRACED)
            if not pid:
                return None
            if os.WIFSTOPPED(status):
                assert os.WSTOPSIG(status) == signal.SIGSTOP
                return 'stopped'
            assert os.WIFEXITED(status) or os.WIFSIGNALED(status)
            child.returncode = os.waitstatus_to_exitcode(status)
            # Linux retains pre-exec usage: this is whole-child, not fwp-only RSS.
            record.update(status=child.returncode, wait4PeakRssKiB=usage.ru_maxrss)
            return 'exited'

        try:
            while child.returncode is None:
                time.sleep(interval)
                state = event()
                if state == 'exited':
                    break
                assert state is None, 'unexpected stop outside the observer protocol'
                assert time.monotonic() < deadline, 'memory observation deadline'
                assert len(snapshots) < limit, 'memory snapshot limit'
                try:
                    os.kill(child.pid, signal.SIGSTOP)
                except ProcessLookupError:
                    # A normal exit can race the requested stop. Reap it below.
                    pass
                while True:
                    state = event()
                    if state is not None:
                        break
                    assert time.monotonic() < deadline, 'child did not stop or exit'
                    time.sleep(.005)
                if state == 'exited':
                    break
                snapshot = dict(index=len(snapshots), files={})
                raw = {}
                for name in ('smaps', 'status', 'statm'):
                    with Path(f'/proc/{child.pid}/{name}').open() as stream:
                        raw[name] = stream.read(4 * 1024 * 1024 + 1)
                    assert len(raw[name]) <= 4 * 1024 * 1024
                    file = folder / f'{snapshot["index"]}-{name}.txt'
                    file.write_text(raw[name])
                    snapshot['files'][name] = dict(file=file.name, sha256=hashlib.sha256(raw[name].encode()).hexdigest())
                assert re.search(r'^State:\s+T\b', raw['status'], re.M), 'child must be stopped'
                rows = mappings(raw['smaps'])
                snapshot.update(metrics=summary(rows), categories=categories(rows, Path(command[0]).resolve()),
                                fast=fast_counters(raw['status'], raw['statm'], os.sysconf('SC_PAGE_SIZE')))
                snapshots.append(snapshot)
                os.kill(child.pid, signal.SIGCONT)
            assert len(snapshots) >= 2, 'insufficient snapshots'
        except BaseException as error:
            record['failure'] = str(error)
            raise
        finally:
            if child.returncode is None:
                try:
                    os.kill(child.pid, signal.SIGKILL)
                except ProcessLookupError:
                    pass
                _, status, usage = os.wait4(child.pid, 0)
                child.returncode = os.waitstatus_to_exitcode(status)
                record.update(status=child.returncode, wait4PeakRssKiB=usage.ru_maxrss)
            (folder / 'observation.json').write_text(json.dumps(record, indent=2) + '\n')
    record.update(stdout=(folder / 'stdout.txt').read_text(), stderr=(folder / 'stderr.txt').read_text())
    return record
