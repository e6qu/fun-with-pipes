#!/usr/bin/env python3
"""Frozen process ordering for the unique-buffer peer baseline."""
from collections import Counter
import random

LABELS = ('c', 'c-identical', 'rust', 'rust-identical', 'fwp', 'fwp-identical')
ENTRIES = ('unique', 'callback', 'scan')
# Length and calls per process: nonempty cases initialize 1,048,576 elements.
CASES = ((0, 65536), (16, 65536), (4096, 256), (262144, 4))
ROUNDS = 36
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
