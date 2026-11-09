"""Read Linux mapping snapshots at explicit, stopped-process checkpoints.

Mapping size, resident pages and allocation requests are different quantities.
This observer makes no claim about committed bytes or allocator-internal peaks.
"""
import hashlib
import json
import os
from pathlib import Path
import platform
import re
import select
import signal
import subprocess
import time

HEADER = re.compile(r'^([0-9a-f]+)-([0-9a-f]+)\s+([r-][w-][x-][ps])\s+[0-9a-f]+\s+[0-9a-f]+:[0-9a-f]+\s+[0-9]+(?:\s+(.*))?$')
FIELDS = ('Size', 'Rss', 'Pss', 'Private_Clean', 'Private_Dirty', 'Anonymous', 'Swap')
CONTROL_NAME = '[anon:fwp-parser-control]'
CONTROL_KIB = 16 * 1024


def mappings(text):
    rows = []
    current = None
    for line in text.splitlines():
        header = HEADER.fullmatch(line)
        if header:
            start, end = int(header[1], 16), int(header[2], 16)
            if start >= end or (rows and start < rows[-1]['end']):
                raise ValueError('overlapping or empty memory mapping')
            current = dict(start=start, end=end, permissions=header[3], name=header[4] or '', fields={}, flags=None)
            rows.append(current)
            continue
        key, separator, value = line.partition(':')
        if not separator or current is None or not re.fullmatch(r'[A-Za-z_]+', key):
            raise ValueError('mapping field without a valid header')
        if key == 'VmFlags':
            flags = value.split()
            if current['flags'] is not None or len(set(flags)) != len(flags) or not all(re.fullmatch(r'[a-z]{2}', flag) for flag in flags):
                raise ValueError('malformed or duplicate mapping flags')
            current['flags'] = flags
            continue
        if key not in FIELDS:
            continue
        match = re.fullmatch(r'\s*([0-9]+) kB', value)
        if not match or key in current['fields']:
            raise ValueError('malformed or duplicate mapping field: ' + key)
        current['fields'][key] = int(match[1])
    if not rows:
        raise ValueError('empty memory mapping snapshot')
    for row in rows:
        if row['flags'] is None:
            raise ValueError('missing memory mapping flags')
        if set(row['fields']) != set(FIELDS):
            raise ValueError('missing memory mapping fields')
        if row['fields']['Size'] * 1024 != row['end'] - row['start']:
            raise ValueError('mapping size disagrees with its address range')
    return rows


def summary(rows):
    totals = {field: sum(row['fields'][field] for row in rows) for field in FIELDS}
    return dict(mappedKiB=totals['Size'], residentKiB=totals['Rss'],
                proportionalKiB=totals['Pss'], privateKiB=totals['Private_Clean'] + totals['Private_Dirty'],
                anonymousKiB=totals['Anonymous'], swapKiB=totals['Swap'],
                noAccessKiB=sum(row['fields']['Size'] for row in rows if row['permissions'][:3] == '---'))


def accounting(rows):
    """Mapping extents marked by the kernel; not guaranteed or resident RAM."""
    return dict(accountableMappingKiB=sum(row['fields']['Size'] for row in rows if 'ac' in row['flags']),
                noReserveMappingKiB=sum(row['fields']['Size'] for row in rows if 'nr' in row['flags']))


def check_kernel_accounting(record):
    """Reject invalid policy/system counters before interpreting mapping flags."""
    assert isinstance(record, dict) and isinstance(record['kernel'], str) and record['kernel']
    policy, system = record['policy'], record['system']
    assert set(policy) == {'overcommit_memory', 'overcommit_ratio', 'overcommit_kbytes'}
    assert all(type(value) is int and value >= 0 for value in policy.values())
    assert policy['overcommit_memory'] in (0, 1, 2), 'invalid overcommit mode'
    assert set(system) == {'CommitLimitKiB', 'Committed_ASKiB'}
    assert all(type(value) is int and value >= 0 for value in system.values())


def kernel_accounting():
    fields = {}
    for line in Path('/proc/meminfo').read_text().splitlines():
        key, _, value = line.partition(':')
        if key in ('CommitLimit', 'Committed_AS'):
            match = re.fullmatch(r'\s*([0-9]+) kB', value)
            if not match or key + 'KiB' in fields:
                raise ValueError('invalid system commit accounting')
            fields[key + 'KiB'] = int(match[1])
    if set(fields) != {'CommitLimitKiB', 'Committed_ASKiB'}:
        raise ValueError('missing system commit accounting')
    policy = {key: int(Path('/proc/sys/vm/' + key).read_text())
              for key in ('overcommit_memory', 'overcommit_ratio', 'overcommit_kbytes')}
    if policy['overcommit_memory'] not in (0, 1, 2):
        raise ValueError('unknown overcommit policy')
    record = dict(kernel=platform.release(), policy=policy, system=fields,
                  scope='System-wide commit quantities; not a per-process reservation or guaranteed RAM')
    check_kernel_accounting(record)
    return record


def read_exact(stream, count, deadline):
    poller = select.poll()
    poller.register(stream, select.POLLIN | select.POLLHUP | select.POLLERR)
    data = b''
    while len(data) < count:
        remaining = deadline - time.monotonic()
        if remaining <= 0 or not poller.poll(max(1, int(remaining * 1000))):
            raise TimeoutError('child did not send its memory checkpoint')
        piece = os.read(stream.fileno(), count - len(data))
        if not piece:
            raise ValueError('child exited before its memory checkpoint')
        data += piece
    return data


def wait_stopped(process, deadline):
    while time.monotonic() < deadline:
        pid, status = os.waitpid(process.pid, os.WNOHANG | os.WUNTRACED)
        if pid:
            if os.WIFSTOPPED(status) and os.WSTOPSIG(status) == signal.SIGSTOP:
                return
            if os.WIFEXITED(status) or os.WIFSIGNALED(status):
                process.returncode = os.waitstatus_to_exitcode(status)
            raise ValueError('child exited or stopped unexpectedly before memory observation')
        time.sleep(0.01)
    raise TimeoutError('child did not stop for its memory checkpoint')


def checkpoint_process(command, environment, folder, phases, timeout):
    """Observe one child; preserve raw snapshots and always reap it, including failure."""
    folder.mkdir(parents=True, exist_ok=False)
    deadline = time.monotonic() + timeout
    records = []
    messages = []
    failure = None
    with (folder / 'stderr.txt').open('wb') as errors:
        process = subprocess.Popen(list(map(str, command)), env=environment, stdin=subprocess.PIPE,
                                   stdout=subprocess.PIPE, stderr=errors)
        try:
            for phase in range(phases):
                message = read_exact(process.stdout, 2, deadline)
                messages.append(message.hex())
                if message != f'{phase}\n'.encode():
                    raise ValueError(f'missing, repeated or out-of-order memory checkpoint: {message!r}')
                wait_stopped(process, deadline)
                with Path(f'/proc/{process.pid}/smaps').open(encoding='utf-8') as source:
                    raw = source.read(4 * 1024 * 1024 + 1)
                path = folder / f'phase-{phase}.smaps'
                path.write_text(raw)
                if len(raw) > 4 * 1024 * 1024:
                    raise ValueError('memory snapshot exceeds the fixed reader limit')
                memory = mappings(raw)
                records.append(dict(phase=phase, file=path.name, sha256=hashlib.sha256(raw.encode()).hexdigest(),
                                    metrics=summary(memory), accounting=accounting(memory)))
                policy = kernel_accounting()
                policy_path = folder / f'phase-{phase}.accounting.json'
                policy_path.write_text(json.dumps(policy, indent=2) + '\n')
                records[-1]['kernelAccountingFile'] = policy_path.name
                records[-1]['kernelAccountingSha256'] = hashlib.sha256(policy_path.read_bytes()).hexdigest()
                process.stdin.write(b'\n')
                process.stdin.flush()
                os.kill(process.pid, signal.SIGCONT)
            remaining = deadline - time.monotonic()
            if remaining <= 0:
                raise TimeoutError('child exceeded its memory observation deadline')
            output, _ = process.communicate(timeout=remaining)
            if len(output) > 65536:
                raise ValueError('unexpectedly large parser result')
            return dict(command=list(map(str, command)), status=process.returncode,
                        stdout=output.decode(), stderr=(folder / 'stderr.txt').read_text(),
                        snapshots=records)
        except Exception as error:
            failure = str(error)
            raise
        finally:
            terminated = process.poll() is None
            if terminated:
                process.kill()
            process.wait(timeout=5)
            for stream in (process.stdin, process.stdout):
                if stream and not stream.closed:
                    stream.close()
            (folder / 'observation.json').write_text(json.dumps(dict(
                command=list(map(str, command)), status=process.returncode, terminatedByObserver=terminated,
                checkpointMessagesHex=messages, snapshots=records, failure=failure, timeoutSeconds=timeout), indent=2) + '\n')


def validate_mapping_control(result, folder):
    if result['status'] != 0 or result['stderr'] or result['stdout'] != '{"control":1}\n':
        raise ValueError('mapping control execution failed')
    if [row['phase'] for row in result['snapshots']] != list(range(5)):
        raise ValueError('mapping control checkpoint sequence changed')
    observed = []
    for snapshot in result['snapshots']:
        raw = (folder / snapshot['file']).read_text()
        if hashlib.sha256(raw.encode()).hexdigest() != snapshot['sha256']:
            raise ValueError('mapping control snapshot changed')
        rows = mappings(raw)
        if summary(rows) != snapshot['metrics']:
            raise ValueError('mapping control summary changed')
        observed.append([row for row in rows if row['name'] == CONTROL_NAME])
    if observed[0]:
        raise ValueError('mapping control was present before reservation')
    for phase in (1, 2, 3):
        if len(observed[phase]) != 1 or observed[phase][0]['fields']['Size'] != CONTROL_KIB:
            raise ValueError('mapping control reservation changed')
    reserved, writable, touched = (observed[phase][0] for phase in (1, 2, 3))
    if len({(row['start'], row['end']) for row in (reserved, writable, touched)}) != 1:
        raise ValueError('mapping control address changed between checkpoints')
    if reserved['permissions'] != '---p' or reserved['fields']['Rss'] != 0:
        raise ValueError('mapping control reservation is not untouched')
    if writable['permissions'] != 'rw-p' or writable['fields']['Rss'] != 0:
        raise ValueError('mapping control writable state is not untouched')
    if touched['permissions'] != 'rw-p' or touched['fields']['Rss'] != CONTROL_KIB:
        raise ValueError('touch-control-missing')
    if touched['fields']['Private_Dirty'] != CONTROL_KIB or touched['fields']['Swap'] != 0:
        raise ValueError('mapping control touched pages are not private and resident')
    if observed[4]:
        raise ValueError('unmap-control-missing')
