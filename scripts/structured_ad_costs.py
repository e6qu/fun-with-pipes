"""Programs and independent oracles for complete structured-gradient comparisons."""
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parent.parent
METHODS = {
    'neighbors': ('reverse', 'forward', 'local'),
    'independent': ('reverse', 'forward', 'local', 'tensor'),
    'dense': ('reverse', 'forward'),
}
SIZES = {'neighbors': (0, 1, 3, 33, 129), 'independent': (0, 1, 16, 129),
         'dense': (0, 1, 3, 9, 33)}


def cases():
    for family, sizes in SIZES.items():
        for count in sizes:
            yield dict(name=f'{family}-{count}', family=family, count=count,
                       repeats=32 if count <= 3 else 1, methods=METHODS[family])


def inputs(family, count):
    if family == 'neighbors':
        return [-1.2 if i % 2 == 0 else 1.0 for i in range(count)]
    if family == 'independent':
        values = (-1.25, -0.5, 0.0, 0.5, 1.25)
        return [values[i % 5] for i in range(count)]
    assert family == 'dense'
    return [((7 * j + 3) % 17 - 8) / 8 for j in range(count)]


def matrix(count):
    return [[((17 * i + 13 * j + 5) % 31 - 15) / 16 for j in range(count)]
            for i in range(count)]


def expected(family, count):
    values = inputs(family, count)
    if family == 'neighbors':
        result = [0.0] * count
        for i, (x, y) in enumerate(zip(values, values[1:])):
            distance = y - x * x
            result[i] += -400.0 * x * distance + 2.0 * (x - 1.0)
            result[i + 1] += 200.0 * distance
        return result
    if family == 'independent':
        return [4.0 * x * (x * x - 1.0) for x in values]
    assert family == 'dense'
    weights = matrix(count)
    projections = [sum(a * x for a, x in zip(row, values)) for row in weights]
    return [sum(weights[i][j] * projections[i] for i in range(count))
            for j in range(count)]


def program(family, method):
    assert method in METHODS[family]
    operation = {
        ('neighbors', 'reverse'): 'grad neighbours',
        ('neighbors', 'forward'): 'gradient neighbours',
        ('neighbors', 'local'): 'array.from-list | local-gradient edge | array.to-list',
        ('independent', 'reverse'): 'grad independent',
        ('independent', 'forward'): 'gradient independent',
        ('independent', 'local'): 'independent-local',
        ('independent', 'tensor'): 'independent-tensor',
        ('dense', 'reverse'): 'grad (dense weights)',
        ('dense', 'forward'): 'gradient (dense weights)',
    }[family, method]
    definitions = '\n'.join((ROOT / 'tests/fixtures' / name).read_text()
                            for name in ('descent_local_ad.fwp', 'structured_ad_objectives.fwp'))
    return definitions + f'''\nexport measure : List[List[F64]] -> List[F64] -> List[F64]
measure = fn weights -> fn values -> values | {operation}
'''


def raw_program(case, method):
    weights = repr(matrix(case['count'])) if case['family'] == 'dense' else '[]'
    return program(case['family'], method) + f"main = {inputs(case['family'], case['count'])!r} | measure {weights} | echo\n"


def entry_and_drops(generated):
    marker = '/* measure :'
    assert generated.count(marker) == 1, 'require the named measured export'
    body = generated.split(marker)[1]
    definition = re.match(r'[^\n]*\nstatic V [fw](\d+)\(', body)
    assert definition, 'missing measured entry definition'
    entry = re.search(r'static V (f' + definition[1] + r')\(([^)]*)\)', body)
    assert entry and entry[2] == 'V l0, V l1', 'require the declared two-argument entry'
    drops = []
    for kind in ('List[F64]', 'List[List[F64]]'):
        matches = re.findall(r'/\* ' + re.escape(kind) + r' \*/\nstatic void (fwp_drop\d+)\(V v\)', generated)
        assert len(matches) == 1, (kind, matches)
        drops.append(matches[0])
    return entry[1], *drops


def driver(generated, case):
    entry, values_drop, matrix_drop = entry_and_drops(generated)
    harness = (ROOT / 'tests/fixtures/structured_ad_timing.c').read_text()
    substitutions = dict(OBJECTIVE=str(('neighbors', 'independent', 'dense').index(case['family'])),
        INPUT_COUNT=str(case['count']), REPEAT_COUNT=str(case['repeats']),
        EXPECTED_VALUES=', '.join(repr(value) for value in expected(case['family'], case['count'])) or '0.0',
        MEASURE_ENTRY=entry, DROP_VALUES=values_drop, DROP_MATRIX=matrix_drop)
    for token, value in substitutions.items():
        assert token in harness, token
        harness = harness.replace(token, value)
    marker = 'int main(int argc, char **argv)'
    assert generated.count(marker) == 1
    return generated.replace(marker, 'int original_main(int argc, char **argv)') + '\n' + harness
