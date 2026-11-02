"""Schedule and decisions for the declared six-program kernel comparison."""
from collections import Counter
import statistics

LABELS = ('c', 'rust', 'fwp', 'fwp-identical', 'reference', 'reference-identical')
METRICS = ('kernelNs', 'allocationInclusiveNs')
BASE_ORDER = (0, 1, 5, 2, 4, 3)


def execution_order(round_index, processes):
    assert type(round_index) is int and 0 <= round_index < 18
    assert type(processes) is int and processes in (4, 256)
    return [LABELS[(role + round_index + block) % len(LABELS)]
            for block in range(processes) for role in BASE_ORDER]


def storage_label(label):
    assert label in LABELS
    return 'fwp' if label.startswith('reference') else label


def summarize(observations, processes, metrics):
    """Rebuild complete round totals; retain warmups but exclude them from medians."""
    assert metrics and len(set(metrics)) == len(metrics)
    assert len(observations) == 20
    totals = {label: {metric: [] for metric in metrics} for label in LABELS}
    adjacency = Counter()
    for position, record in enumerate(observations):
        phase, index = ('warmup', position) if position < 2 else ('sample', position - 2)
        assert record['phase'] == phase and record['round'] == index and record['complete']
        order = execution_order(index, processes)
        assert record['order'] == order
        assert [row['label'] for row in record['observations']] == order
        assert Counter(order) == Counter({label: processes for label in LABELS})
        if phase == 'sample':
            adjacency.update(zip(order, order[1:]))
            for label in LABELS:
                for metric in metrics:
                    totals[label][metric].append(sum(sample[metric]
                        for row in record['observations'] if row['label'] == label
                        for sample in row['samples']))
    medians = {label: {metric: statistics.median(values) for metric, values in scopes.items()}
               for label, scopes in totals.items()}
    assert all(value > 0 for scopes in medians.values() for value in scopes.values())
    controls = {label: {metric:
        max(medians[label][metric], medians[label + '-identical'][metric]) /
        min(medians[label][metric], medians[label + '-identical'][metric])
        for metric in metrics} for label in ('fwp', 'reference')}
    ratios = {peer: {metric: medians['fwp'][metric] / medians[peer][metric]
                    for metric in metrics} for peer in ('c', 'rust', 'reference')}
    return dict(totals=totals, medians=medians, identicalRatios=controls, ratios=ratios,
                withinRoundAdjacency=[dict(before=a, after=b, count=n)
                    for (a, b), n in sorted(adjacency.items())])


def decisions(results, speed_cases):
    """Unmet timing rules are observations, never permission to discard a case."""
    failures = []
    for case, row in results.items():
        for label, scopes in row['identicalRatios'].items():
            for metric, ratio in scopes.items():
                if ratio > 1.02:
                    failures.append(dict(kind='copy', case=case, label=label,
                                         metric=metric, ratio=ratio, limit=1.02))
        for metric, ratio in row['ratios']['reference'].items():
            limit = 0.95 if case in speed_cases and metric == 'kernelNs' else 1.02
            if ratio > limit:
                failures.append(dict(kind='speed', case=case, metric=metric,
                                     ratio=ratio, limit=limit))
        current, reference = row['profiles']['fwp'], row['profiles']['reference']
        assert len(current) == len(reference) == 5
        for index, (left, right) in enumerate(zip(current, reference)):
            for metric in ('requests', 'requestedBytes', 'retains', 'peakChargedBytes'):
                if left[metric] > right[metric]:
                    failures.append(dict(kind='memory', case=case, sample=index, metric=metric,
                                         current=left[metric], reference=right[metric]))
    return failures
