"""Account for DWARF user stacks directly, including unmatched samples."""
import json
import re
import subprocess

from compiler_scaling import ROOT
from process_wait import run_capture


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


def attribute(samples, flat):
    assert len(samples) == sum(row['samples'] for row in flat), 'stack sample count differs from flat report'
    assert sum(sample['period'] for sample in samples) == sum(row['period'] for row in flat), 'stack periods differ from flat report'
    groups = {}
    unresolved = 0
    unavailable = 0
    for sample in samples:
        frames = sample['frames']
        if frames:
            leaf = frames[0]
            parent = next((frame['symbol'] for frame in frames
                           if re.search(r'::infer::Infer>?::check_(binding|effects)\b', frame['symbol'])), '[other]')
            key = (parent, leaf['dso'], leaf['symbol'])
        else:
            # perf can emit a sample header with an empty unwind cursor. Keep
            # its period, but do not invent an instruction, symbol or caller.
            unavailable += 1
            key = ('[unavailable]', '[unavailable]', '[no decoded frame]')
        row = groups.setdefault(key, dict(parent=key[0], dso=key[1], symbol=key[2], samples=0, period=0))
        row['samples'] += 1
        row['period'] += sample['period']
        if any(frame['symbol'] == '[unknown]' or re.fullmatch(r'(0x)?[0-9a-f]+', frame['symbol']) for frame in frames):
            unresolved += 1
    rows = sorted(groups.values(), key=lambda row: (-row['period'], row['parent'], row['symbol']))
    total = sum(row['period'] for row in rows)
    for row in rows:
        row['overheadPercent'] = row['period'] * 100 / total
    assert any(re.search(r'::infer::Infer>?::check_binding\b', row['parent']) for row in rows), 'no decoded body-checking caller stacks'
    return dict(samples=len(samples), period=total, samplesWithUnknownFrames=unresolved,
                samplesWithoutFrames=unavailable, rows=rows)


def thread_periods(text):
    threads = {}
    for line in text.splitlines():
        if not line.strip():
            continue
        sample = re.fullmatch(r'\s*(\d+)\s+(\d+)\s+cpu-clock:u:\s*', line)
        assert sample is not None, f'unexpected thread sample: {line}'
        tid, period = int(sample[1]), int(sample[2])
        assert tid > 0 and period > 0
        threads.setdefault(tid, []).append(period)
    assert threads, 'missing thread samples'
    return threads


def decode(recording, output, perf, demangler, environment, deadline, flat, commands):
    def run(command, role, input_data):
        entry = dict(role=role, command=command)
        commands.append(entry)
        try:
            result = run_capture(command, env=environment, cwd=ROOT, input_data=input_data,
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

    # No IP field means no stack unwinding. Enumerate every recorded sample
    # before starting a separate decoder process for each sampled thread.
    census = run([str(perf), 'script', '--input', str(recording), '--hide-call-graph',
                  '--fields', 'tid,period,event'], 'thread-samples', None)
    threads = thread_periods(census)
    assert sum(len(periods) for periods in threads.values()) == sum(row['samples'] for row in flat)
    assert sum(sum(periods) for periods in threads.values()) == sum(row['period'] for row in flat)
    (output/'threads.json').write_text(json.dumps(threads, indent=2)+'\n')
    samples = []
    for tid, periods in threads.items():
        role = f'user-stacks-{tid}'
        command = [str(perf), 'script', '--input', str(recording), '--tid', str(tid),
                   '--inline', '--max-stack', '512', '--fields', 'period,event,ip,sym,dso']
        raw_text = run(command, role, None)
        raw = stacks(raw_text)
        assert [sample['period'] for sample in raw] == periods, 'thread decoder lost or reordered samples'
        decoded_text = run([str(demangler), '--no-strip-underscore', '--format=rust'],
                           role+'.demangled', raw_text)
        decoded = stacks(decoded_text)
        assert len(decoded) == len(raw)
        for original, sample in zip(raw, decoded):
            assert original['period'] == sample['period'] and len(original['frames']) == len(sample['frames'])
            assert all(a['ip'] == b['ip'] and a['dso'] == b['dso'] for a, b in zip(original['frames'], sample['frames']))
        samples.extend(decoded)
    return attribute(samples, flat)
