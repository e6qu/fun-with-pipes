#!/usr/bin/env python3
"""Frozen process ordering for the unique-buffer peer baseline."""
import base64
from collections import Counter
import hashlib
import json
from pathlib import Path
import random
import statistics

LABELS = ('c', 'c-identical', 'rust', 'rust-identical', 'fwp', 'fwp-identical')
ENTRIES = ('unique', 'callback', 'scan')
# Length and calls per process: nonempty cases initialize 1,048,576 elements.
CASES = ((0, 65536), (16, 65536), (4096, 256), (262144, 4))
ROUNDS = 36
WARMUPS = 2
PROCESSES = 12
SEED = 20261030
COPY_CONTROL_MAX = 1.02


def execution_order(round_index, seed, processes, labels):
    """Balance all positions and within-round predecessor pairs over 36 rounds."""
    assert type(round_index) is int and 0 <= round_index < ROUNDS
    assert type(seed) is int
    assert type(processes) is int and processes == PROCESSES
    assert len(labels) == 6 and len(set(labels)) == 6
    rng = random.Random(seed)
    edges = {label: rng.sample(labels, len(labels)) for label in labels}
    stack, circuit = [labels[0]], []
    while stack:
        if edges[stack[-1]]:
            stack.append(edges[stack[-1]].pop())
        else:
            circuit.append(stack.pop())
    circuit.reverse()
    assert circuit[0] == circuit[-1]
    cycle = circuit[:-1]
    assert Counter(zip(cycle, cycle[1:] + cycle[:1])) == Counter(
        {(left, right): 1 for left in labels for right in labels})
    offset = round_index
    return (cycle[offset:] + cycle[:offset]) * (processes // len(labels))


def expected_output(entry, length, calls):
    assert entry in ENTRIES and (length, calls) in CASES
    value = length * (length - 1) // 2 if entry == 'scan' else length * (2 if entry == 'unique' else 1)
    checksum = value * calls
    assert 0 <= checksum <= 2**63 - 1
    return f'{checksum}\n'.encode()


def round_totals(rows, entry, length, calls, labels):
    """Reconstruct a complete fixed schedule; retain warmups but exclude their times."""
    expected_output(entry, length, calls)
    assert len(rows) == (WARMUPS + ROUNDS) * len(labels) * PROCESSES
    elapsed = {label: [] for label in labels}
    cpu = {label: [] for label in labels}
    cursor = 0
    for warmup, rounds in [(True, WARMUPS), (False, ROUNDS)]:
        for round_index in range(rounds):
            wall_totals = dict.fromkeys(labels, 0)
            cpu_totals = dict.fromkeys(labels, 0)
            for position, label in enumerate(execution_order(round_index, SEED, PROCESSES, labels)):
                row = rows[cursor]
                cursor += 1
                for key, value in dict(entry=entry, length=length, calls=calls, warmup=warmup,
                                       round=round_index, position=position, label=label).items():
                    assert type(row[key]) is type(value) and row[key] == value, (key, row)
                check_result(row, entry, length, calls)
                wall_totals[label] += row['elapsedNs']
                cpu_totals[label] += row['userNs'] + row['systemNs']
            if not warmup:
                for label in labels:
                    elapsed[label].append(wall_totals[label])
                    cpu[label].append(cpu_totals[label])
    return elapsed, cpu


def summarize_case(rows, entry, length, calls):
    elapsed, cpu = round_totals(rows, entry, length, calls, LABELS)
    medians = {label: statistics.median(values) for label, values in elapsed.items()}
    copy_ratios = {label: medians[label + '-identical'] / medians[label] for label in ['c', 'rust', 'fwp']}
    return dict(roundElapsedNs=elapsed, roundCpuNs=cpu,
                copyControlLimit=COPY_CONTROL_MAX,
                copyControlPassed=all(max(ratio, 1 / ratio) <= COPY_CONTROL_MAX for ratio in copy_ratios.values()),
                medianRoundElapsedNs=medians,
                medianRoundCpuNs={label: statistics.median(values) for label, values in cpu.items()},
                identicalElapsedRatios=copy_ratios,
                fwpPeerElapsedRatios={label: medians['fwp'] / medians[label] for label in ['c', 'rust']},
                decision='descriptive-baseline; no optimization accepted')


def check_result(row, entry, length, calls):
    expected = expected_output(entry, length, calls)
    assert type(row['status']) is int and row['status'] == 0, row
    assert row['timedOut'] is False and row['interrupted'] is False and row['spawnError'] is None, row
    assert base64.b64decode(row['stdoutBase64'], validate=True) == expected, row
    assert base64.b64decode(row['stderrBase64'], validate=True) == b'', row
    assert row['stdoutSha256'] == hashlib.sha256(expected).hexdigest(), row
    assert row['stderrSha256'] == hashlib.sha256(b'').hexdigest(), row
    assert type(row['elapsedNs']) is int and row['elapsedNs'] > 0, row
    assert all(type(row[key]) is int and row[key] >= 0 for key in ['userNs', 'systemNs']), row


def check_host(qualification, source, machine):
    hosts = {
        'aarch64': dict(cpu='Neoverse-N2', cVersion='gcc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0'),
        'x86_64': dict(cpu='AMD EPYC 7763 64-Core Processor', cVersion='gcc (Ubuntu 15.2.0-16ubuntu1) 15.2.0'),
    }
    expected = dict(system='Linux', machine=machine, processors=4,
                    rustVersion='rustc 1.99.1 (58cf8f9c3 2026-10-13)', **hosts[machine])
    assert qualification['source'] == source
    assert qualification['qualified'] is True and qualification['failures'] == []
    assert qualification['actual'] == qualification['expected'] == expected


def check_programs(folder, source, machine):
    record = json.loads((folder / 'programs.json').read_text())
    assert record['source'] == source and record['machine'] == machine
    assert list(record['entries']) == list(ENTRIES)
    for entry in ENTRIES:
        peers = record['entries'][entry]
        assert list(peers) == list(LABELS)
        for label, metadata in peers.items():
            paths = [Path(metadata[key]) for key in ['binary', 'source']]
            assert all(not path.is_absolute() and '..' not in path.parts for path in paths)
            image, input_bytes = [(folder / path).read_bytes() for path in paths]
            assert image[:6] == b'\x7fELF\x02\x01'
            assert int.from_bytes(image[18:20], 'little') == {'x86_64': 62, 'aarch64': 183}[machine]
            assert hashlib.sha256(image).hexdigest() == metadata['sha256'] and len(image) == metadata['bytes']
            assert hashlib.sha256(input_bytes).hexdigest() == metadata['sourceSha256']
            assert metadata['sections']['.text'] > 0 and metadata['frames']
            assert all(type(row['bytes']) is int and row['bytes'] >= 0 for row in metadata['frames'])
        for language in ['c', 'rust', 'fwp']:
            assert peers[language]['sha256'] == peers[language + '-identical']['sha256']
    return record
