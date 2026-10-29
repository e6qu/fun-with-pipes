#!/usr/bin/env python3
"""Exact finite kernel oracles and balanced process schedules for N1."""
from collections import Counter
import math
import random
import struct

LABELS = ['c', 'rust', 'fwp', 'fwp-identical']


def execution_order(round_index, seed):
    """Four occurrences per label; sixteen rotations balance every position."""
    assert type(round_index) is int and round_index >= 0
    assert type(seed) is int
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
        {(a, b): 1 for a in LABELS for b in LABELS})
    offset = round_index % len(cycle)
    return cycle[offset:] + cycle[:offset]


def bits(value):
    return struct.unpack('<Q', struct.pack('<d', value))[0]


def array_result(elements, round_index):
    """Sum exact quarter-valued terms without using the timed reduction loop."""
    assert type(elements) is int and 0 <= elements <= 262145
    assert type(round_index) is int and 0 <= round_index < 8
    if elements == 0:
        return bits(-0.0)
    blocks, tail = divmod(elements, 19)
    residues = blocks * sum(range(19)) + sum((i + round_index) % 19 for i in range(tail))
    numerator = elements * 4 + 3 * (residues - 9 * elements)
    return bits(numerator / 4)


def matrix_result(rows, inner, columns, round_index):
    """Integer products with denominator 32; periodic inputs share exact sums."""
    assert all(type(n) is int and 0 < n <= 259 for n in [rows, inner, columns])
    assert type(round_index) is int and 0 <= round_index < 8
    period = math.lcm(19, 13 // math.gcd(columns, 13))
    blocks, tail = divmod(inner, period)
    table = {}
    for a in range(19):
        for b in range(13):
            products = [((a + q) % 19 - 9) * ((q * columns + b) % 13 - 6)
                        for q in range(period)]
            numerator = blocks * sum(products) + sum(products[:tail])
            table[a, b] = bits(numerator / 32)
    return [table[(i * inner + round_index) % 19, (j + round_index) % 13]
            for i in range(rows) for j in range(columns)]


def result_hash(rounds):
    value = 1469598103934665603
    for values in rounds:
        for item in values:
            assert type(item) is int and 0 <= item < 2**64
            value = ((value ^ item) * 1099511628211) % 2**64
    return f'{value:016x}'


def verification_output(rounds):
    return ''.join(f'{r}:{i}:{value:016x}\n'
                   for r, values in enumerate(rounds)
                   for i, value in enumerate(values)).encode()
