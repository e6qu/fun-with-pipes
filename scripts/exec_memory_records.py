"""Reconstruct lifecycle observations from raw proc files and GNU-time output."""
import hashlib
import json
import os
from pathlib import Path
import re
import signal

from nested_resource_memory import categories, fast_counters
from parser_process_memory import mappings, summary


def review(folder, expected_hashes, page_bytes):
    row = json.loads((folder / 'observation.json').read_text())
    assert row['failure'] is None and row['status'] == 0 and not row['cleanup']
    root, target = row['root'], row['target']
    assert root != target and {root, target}.issubset(row['known']), 'process identity mismatch'
    forks = [event for event in row['events'] if event['kind'] in ('fork', 'vfork')]
    assert len(forks) == 1 and forks[0]['pid'] == root and forks[0]['child'] == target
    assert forks[0]['kind'] in ('fork', 'vfork')
    for index, event in enumerate(row['events']):
        assert event['index'] == index and event['pid'] in row['known'], 'process identity mismatch'
        status = event['rawStatus']
        if event['kind'] == 'reaped':
            assert os.WIFEXITED(status) and os.WEXITSTATUS(status) == event['status'] == 0
            continue
        assert os.WIFSTOPPED(status) and os.WSTOPSIG(status) == event['signal']
        task_path = folder / event['taskFile']
        assert task_path.resolve().is_relative_to(folder.resolve())
        task = task_path.read_bytes()
        assert hashlib.sha256(task).hexdigest() == event['taskSha256']
        assert re.search(r'^Pid:\s+' + str(event['pid']) + r'$', task.decode(), re.M), 'process identity mismatch'
        assert re.search(r'^Tgid:\s+' + str(event['tgid']) + r'$', task.decode(), re.M), 'process identity mismatch'
        assert event['tgid'] in (root, target), 'process identity mismatch'
        assert event['pid'] == root or event['tgid'] == target
        kind = status >> 16
        assert event['kind'] == {1: 'fork', 2: 'vfork', 3: 'clone', 4: 'exec', 6: 'exit-stop'}.get(
            kind, 'launcher-stop' if index == 0 else 'signal')
        if 'snapshot' not in event:
            assert event['pid'] not in (root, target) or kind == 3 or (kind == 0 and event['signal'] != signal.SIGSTOP)
            continue
        snap = event['snapshot']
        raw = {}
        for name, record in snap['files'].items():
            path = folder / record['file']
            assert path.resolve().is_relative_to(folder.resolve())
            data = path.read_bytes()
            assert hashlib.sha256(data).hexdigest() == record['sha256']
            raw[name] = data.decode()
        assert set(raw) == {'smaps', 'status', 'statm'}
        assert re.search(r'^Tgid:\s+' + str(event['pid']) + r'$', raw['status'], re.M), 'process identity mismatch'
        assert re.search(r'^State:\s+t\b', raw['status'], re.M)
        assert re.search(r'^Threads:\s+1$', raw['status'], re.M)
        rows = mappings(raw['smaps'])
        assert snap['metrics'] == summary(rows), 'page walk mismatch'
        assert snap['categories'] == categories(rows, Path(snap['executable'])), 'mapping category mismatch'
        assert snap['fast'] == fast_counters(raw['status'], raw['statm'], page_bytes), 'counter mismatch'
    target_events = [event for event in row['events'] if event['pid'] == target]
    execs = [event for event in target_events if event['kind'] == 'exec']
    assert [event['snapshot']['executableSha256'] for event in execs] == expected_hashes, 'executable identity mismatch'
    final, = [event for event in target_events if event['kind'] == 'exit-stop']
    reaped, = [event for event in target_events if event['kind'] == 'reaped']
    parent, = [event for event in row['events'] if event['pid'] == root and event['kind'] == 'reaped']
    assert final['exitStatus'] == reaped['rawStatus'] == 0
    assert final['index'] < reaped['index'] < parent['index']
    threads = set(row['known']) - {root, target}
    clones = [event for event in row['events'] if event['kind'] == 'clone']
    assert {event['child'] for event in clones} == threads
    for pid in threads:
        stopped = [event for event in row['events'] if event['pid'] == pid and event['kind'] == 'exit-stop']
        gone = [event for event in row['events'] if event['pid'] == pid and event['kind'] == 'reaped']
        assert len(stopped) == len(gone) == 1 and gone[0]['index'] < final['index'], 'worker did not finish before process snapshot'
    assert final['snapshot']['executableSha256'] == expected_hashes[-1]
    before = [event['snapshot'] for event in target_events
              if event['index'] < execs[0]['index'] and 'snapshot' in event]
    assert len(before) == 1, 'missing timed-child pre-exec snapshot'
    rss = int((folder / 'rss.txt').read_text())
    assert rss > 0 and rss == reaped['wait4PeakRssKiB'], 'GNU time and child wait4 disagree'
    terminal = final['snapshot']
    return dict(gnuTimePeakKiB=rss, childWait4PeakKiB=reaped['wait4PeakRssKiB'],
                parentWait4PeakKiB=parent['wait4PeakRssKiB'],
                preExecHwmKiB=before[0]['fast']['VmHWMKiB'],
                startupHwmKiB=execs[0]['snapshot']['fast']['VmHWMKiB'],
                terminalHwmKiB=terminal['fast']['VmHWMKiB'],
                terminalResidentKiB=terminal['metrics']['residentKiB'],
                lifetimeMinusTerminalHwmKiB=rss - terminal['fast']['VmHWMKiB'],
                terminalFastMinusWalkKiB=terminal['fast']['VmRSSKiB'] - terminal['metrics']['residentKiB'],
                execCount=len(execs), workerThreads=len(threads), categories=terminal['categories'])


def validate_transient(row):
    assert row['gnuTimePeakKiB'] > 30 * 1024 and row['terminalHwmKiB'] > 30 * 1024, 'touch-control-missing'
    assert row['terminalResidentKiB'] < 8 * 1024, 'unmap-control-missing'
