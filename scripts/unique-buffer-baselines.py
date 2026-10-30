#!/usr/bin/env python3
"""Frozen process ordering for the unique-buffer peer baseline."""
import base64
from collections import Counter
import hashlib
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


def execution_order(round_index, seed, processes):
    """Balance all positions and within-round predecessor pairs over 36 rounds."""
    assert type(round_index) is int and 0 <= round_index < ROUNDS
    assert type(seed) is int
    assert type(processes) is int and processes == PROCESSES
    rng = random.Random(seed)
    edges = {label: rng.sample(LABELS, len(LABELS)) for label in LABELS}
    stack, circuit = [LABELS[0]], []
    while stack:
        if edges[stack[-1]]:
            stack.append(edges[stack[-1]].pop())
        else:
            circuit.append(stack.pop())
    circuit.reverse()
    assert circuit[0] == circuit[-1]
    cycle = circuit[:-1]
    assert Counter(zip(cycle, cycle[1:] + cycle[:1])) == Counter(
        {(left, right): 1 for left in LABELS for right in LABELS})
    offset = round_index
    return (cycle[offset:] + cycle[:offset]) * (processes // len(LABELS))


def expected_output(entry, length, calls):
    assert entry in ENTRIES and (length, calls) in CASES
    value = length * (length - 1) // 2 if entry == 'scan' else length * (2 if entry == 'unique' else 1)
    checksum = value * calls
    assert 0 <= checksum <= 2**63 - 1
    return f'{checksum}\n'.encode()


def summarize_case(rows, entry, length, calls):
    """Reconstruct a complete fixed schedule; retain warmups but exclude their times."""
    expected = expected_output(entry, length, calls)
    expected_hash = hashlib.sha256(expected).hexdigest()
    empty_hash = hashlib.sha256(b'').hexdigest()
    assert len(rows) == (WARMUPS + ROUNDS) * len(LABELS) * PROCESSES
    elapsed = {label: [] for label in LABELS}
    cpu = {label: [] for label in LABELS}
    cursor = 0
    for warmup, rounds in [(True, WARMUPS), (False, ROUNDS)]:
        for round_index in range(rounds):
            wall_totals = dict.fromkeys(LABELS, 0)
            cpu_totals = dict.fromkeys(LABELS, 0)
            for position, label in enumerate(execution_order(round_index, SEED, PROCESSES)):
                row = rows[cursor]
                cursor += 1
                for key, value in dict(entry=entry, length=length, calls=calls, warmup=warmup,
                                       round=round_index, position=position, label=label).items():
                    assert type(row[key]) is type(value) and row[key] == value, (key, row)
                assert type(row['status']) is int and row['status'] == 0 and row['timedOut'] is False and row['spawnError'] is None, row
                assert base64.b64decode(row['stdoutBase64'], validate=True) == expected, row
                assert base64.b64decode(row['stderrBase64'], validate=True) == b'', row
                assert row['stdoutSha256'] == expected_hash and row['stderrSha256'] == empty_hash, row
                for field in ['elapsedNs', 'userNs', 'systemNs']:
                    assert type(row[field]) is int and row[field] >= 0, row
                assert row['elapsedNs'] > 0, row
                wall_totals[label] += row['elapsedNs']
                cpu_totals[label] += row['userNs'] + row['systemNs']
            if not warmup:
                for label in LABELS:
                    elapsed[label].append(wall_totals[label])
                    cpu[label].append(cpu_totals[label])
    medians = {label: statistics.median(values) for label, values in elapsed.items()}
    return dict(roundElapsedNs=elapsed, roundCpuNs=cpu,
                medianRoundElapsedNs=medians,
                medianRoundCpuNs={label: statistics.median(values) for label, values in cpu.items()},
                identicalElapsedRatios={label: medians[label + '-identical'] / medians[label]
                                       for label in ['c', 'rust', 'fwp']},
                fwpPeerElapsedRatios={label: medians['fwp'] / medians[label] for label in ['c', 'rust']},
                decision='descriptive-baseline; no optimization accepted')
