"""Read CPU-clock recordings without dropping unresolved samples or stack frames."""
import re
import subprocess

from process_wait import run_capture

CORE_REGISTERS = {
    'aarch64': [f'x{i}' for i in range(30)] + ['lr', 'sp', 'pc'],
    'x86_64': ['ax', 'bx', 'cx', 'dx', 'si', 'di', 'bp', 'sp', 'ip'] + [f'r{i}' for i in range(8, 16)],
}
REGISTER_WARNING = ('WARNING: The use of --call-graph=dwarf may require all the user registers, '
    'specifying a subset with --user-regs may render DWARF unwinding unreliable, '
    'so the minimal registers set (IP, SP) is explicitly forced.')


def recording_messages(text):
    # perf emits this warning for every explicit register list, even a complete
    # general-register set. Keep it visible; validate that set before recording.
    for line in text.splitlines():
        assert line == REGISTER_WARNING or re.fullmatch(
            r'\[ perf record: (Woken up \d+ times to write data|Captured and wrote .+) \]', line), line
        assert not re.search(r'lost|throttl|error', line, re.I), line


def histogram(text, parent):
    """Read explicitly selected perf TSV fields, keeping unresolved samples."""
    lost = re.findall(r'^# Total Lost Samples:\s*(\d+)\s*$', text, re.M)
    assert lost == ['0'], 'missing loss accounting or lost samples'
    headers = [line for line in text.splitlines() if line.startswith('# Overhead\t')]
    assert len(headers) == 1, 'missing or duplicate histogram header'
    columns = [' '.join(part.split()) for part in headers[0][2:].split('\t')]
    expected = ['Overhead', 'Samples', 'Period'] + (['Parent symbol'] if parent else []) + ['Shared Object', 'Symbol']
    assert columns == expected or columns == expected + ['IPC [IPC Coverage]'], columns
    has_ipc = len(columns) != len(expected)
    keys = ['overheadPercent', 'samples', 'period'] + (['parent'] if parent else []) + ['dso', 'symbol']
    rows = []
    for line in text.splitlines():
        if not line.strip() or line.lstrip().startswith('#'):
            continue
        values = [part.strip() for part in line.split('\t')]
        if has_ipc:
            assert values.pop().split() == ['-', '-'], 'software-clock reports must not claim instruction counts'
        assert len(values) == len(keys), f'unexpected perf row: {line}'
        row = dict(zip(keys, values))
        row['overheadPercent'] = float(row['overheadPercent'].removesuffix('%'))
        row['samples'] = int(row['samples'])
        row['period'] = int(row['period'])
        assert 0 <= row['overheadPercent'] <= 100 and row['samples'] > 0 and row['period'] > 0
        rows.append(row)
    assert rows, 'perf returned no samples'
    period = re.findall(r'^# Event count \(approx\.\):\s*(\d+)\s*$', text, re.M)
    assert len(period) == 1 and sum(row['period'] for row in rows) == int(period[0]), 'event total differs from retained rows'
    return rows


def stacks(text):
    samples = []
    current = None
    for line in text.splitlines():
        if not line.strip():
            continue
        header = re.fullmatch(r'\s*(\d+)\s+cpu-clock:u:\s*(.*)', line)
        if header:
            current = dict(period=int(header[1]), frames=[])
            assert current['period'] > 0
            samples.append(current)
            line = header[2]
            if not line:
                continue
        frame = re.fullmatch(r'\s*([0-9a-f]+)\s+(.+)\s+\((.+)\)\s*', line)
        assert current is not None and frame is not None, f'unexpected stack line: {line}'
        current['frames'].append(dict(ip=frame[1], symbol=frame[2], dso=frame[3]))
    assert samples, 'no samples'
    assert all(len(sample['frames']) < 512 for sample in samples), 'stack depth reached decoding limit'
    return samples


def unknown_frame(frame):
    symbol = frame['symbol']
    if symbol == '[unknown]' or re.fullmatch(r'0x[0-9a-f]+', symbol):
        return True
    # Generated C functions such as f1 and named C functions such as add are
    # valid hexadecimal strings. A bare address must match the recorded IP.
    return bool(re.fullmatch(r'[0-9a-f]+', symbol) and int(symbol, 16) == int(frame['ip'], 16))


def decode(recording, output, *, perf, symbol_command, environment, deadline, flat, commands, attribution, cwd):
    def run(command, role, input_data):
        entry = dict(role=role, command=command)
        commands.append(entry)
        try:
            result = run_capture(command, env=environment, cwd=cwd, input_data=input_data,
                input_stream=subprocess.DEVNULL if input_data is None else None,
                text=True, encoding='utf-8', timeout=deadline, check=False)
        except subprocess.TimeoutExpired as error:
            entry['timeoutSeconds'] = error.timeout
            (output/(role+'.timeout.stdout')).write_bytes(error.output or b'')
            (output/(role+'.timeout.stderr')).write_bytes(error.stderr or b'')
            raise
        entry['status'] = result.returncode
        (output/(role+'.txt')).write_text(result.stdout)
        (output/(role+'.stderr')).write_text(result.stderr)
        assert result.returncode == 0 and not result.stderr, entry
        return result.stdout

    command = [str(perf), 'script', '--input', str(recording), '--inline', '--max-stack', '512',
               '--fields', 'period,event,ip,sym,dso']
    raw_text = run(command, 'user-stacks', None)
    raw = stacks(raw_text)
    decoded_text = run(list(map(str, symbol_command)),
                       'user-stacks.demangled', raw_text)
    samples = stacks(decoded_text)
    assert len(samples) == len(raw)
    for original, sample in zip(raw, samples):
        assert original['period'] == sample['period'] and len(original['frames']) == len(sample['frames'])
        assert all(a['ip'] == b['ip'] and a['dso'] == b['dso'] for a, b in zip(original['frames'], sample['frames']))
    return attribution(samples, flat)
