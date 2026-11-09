"""Frozen paired timing summaries for structured-gradient method comparisons."""
import random
import statistics

PHASES = ('constructionNs', 'computationNs', 'releaseNs', 'processNs')


def order(methods, round_number):
    labels = [label for method in methods for label in (method, method + '-copy')]
    offset = round_number % len(labels)
    return labels[offset:] + labels[:offset]


def interval(ratios):
    assert len(ratios) == 24 and all(value > 0 for value in ratios)
    rng = random.Random(0)
    estimates = sorted(statistics.median(ratios[rng.randrange(24)] for _ in range(24))
                       for _ in range(2000))
    return [estimates[49], estimates[1949]]


def summarize(rows, methods, repeats, reference):
    assert reference in methods
    expected = {(round_number, role) for round_number in range(-2, 24)
                for role in order(methods, round_number)}
    selected = {(row['round'], row['role']): row for row in rows}
    assert len(selected) == len(rows) and set(selected) == expected
    assert all(row['initialLiveBytes'] == row['finalLiveBytes'] for row in rows)
    assert all(row[phase] > 0 for row in rows for phase in PHASES)
    roles = order(methods, 0)
    for role in roles:
        assert len({row['checksum'] for row in rows if row['role'] == role}) == 1
    for method in methods:
        assert selected[0, method]['checksum'] == selected[0, method + '-copy']['checksum']
    medians = {role: {phase: statistics.median(selected[r, role][phase] / repeats for r in range(24))
                      for phase in PHASES} for role in roles}
    copies = {}
    for method in methods:
        ratios = [selected[r, method + '-copy']['computationNs'] / selected[r, method]['computationNs']
                  for r in range(24)]
        median = statistics.median(ratios)
        copies[method] = dict(ratio=median, qualified=1 / 1.02 <= median <= 1.02)
    comparisons = {}
    for method in methods:
        if method == reference:
            continue
        ratios = [selected[r, method]['computationNs'] / selected[r, reference]['computationNs']
                  for r in range(24)]
        bounds = interval(ratios)
        qualified = copies[method]['qualified'] and copies[reference]['qualified']
        direction = 'inconclusive'
        if qualified and bounds[1] < 1:
            direction = 'faster'
        elif qualified and bounds[0] > 1:
            direction = 'slower'
        comparisons[method] = dict(reference=reference, ratio=statistics.median(ratios),
            interval95=bounds, copyQualified=qualified, direction=direction)
    return dict(medianNsPerGradient=medians, identicalCopies=copies) | {
        'vsReverse' if reference == 'reverse' else 'vsBaseline': comparisons}
