"""Three explicit array drivers, their ownership controls and balanced schedule."""
import json
import re
import statistics

import array_consumption_setup as PREPARATION

BASELINE = PREPARATION.BASELINE
VERSIONS = ('original', 'observed', 'preparation-zero')
LABELS = tuple((program, version, copy) for program in ('fwp', 'reference')
               for version in VERSIONS for copy in (0, 1))
WALL_METRICS = ('constructionNs', 'kernelNs', 'allocationInclusiveNs')
OBSERVATIONS = ('kernelCpuNs', 'minorFaults', 'majorFaults', 'voluntarySwitches', 'involuntarySwitches')


def observed_source(original, elements, reducer):
    """Add the frozen observations without adding a preparation call or setup."""
    replace = PREPARATION.PHASES.replace_once
    source = PREPARATION.source(original, elements, reducer)
    preparation = replace(PREPARATION.PREPARATION, 'CONSTRUCT_DRIVER', PREPARATION.PHASES.DRIVER_CONSTRUCTION)
    preparation = replace(preparation, 'REDUCE_ENTRY', reducer)
    preparation = replace(preparation, 'EXPECTED_BITS', str(BASELINE.array_result(elements, 0)) + 'ULL')
    source = replace(source, preparation, '    puts("{\\"samples\\":[");\n')
    return replace(source, 'int main(int argc,char **argv){', 'int main(void){')


def missing_array_release(source):
    return PREPARATION.PHASES.replace_once(source,
        'static void fwp_rc_free_arr(V v) {\n    if (fwp_rc_last(v)) fwp_mem_free((void *)(uintptr_t)v);\n}',
        'static void fwp_rc_free_arr(V v) { (void)v; /* deliberate missing array destruction */ }')


def failed_clock(source, clock):
    assert clock in ('wall', 'cpu')
    if clock == 'wall':
        before = 'static uint64_t bench_clock(void){struct timespec t;if (clock_gettime(CLOCK_MONOTONIC, &t) != 0)'
        after = 'static uint64_t bench_clock(void){struct timespec t;if ((-1) != 0)'
    else:
        before = PREPARATION.CPU_CLOCK
        after = before.replace('clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &t)', '(-1)')
    return PREPARATION.PHASES.replace_once(source, before, after)


def check_output(raw, elements, version, profile, verification):
    assert version in VERSIONS and elements in (65537, 262145)
    if version == 'preparation-zero':
        return PREPARATION.check_output(raw, elements, 0, profile, verification)
    values = [[BASELINE.array_result(elements, r)] for r in range(8)]
    if verification:
        lines = re.findall(rb'^\d+:0:[0-9a-f]{16}\n', raw, re.M)
        assert b''.join(lines) == BASELINE.verification_output(values)
        raw = re.sub(rb'^\d+:0:[0-9a-f]{16}\n', b'', raw, flags=re.M)
    data = json.loads(raw)
    assert set(data) == {'samples'} and len(data['samples']) == (1 if verification else 5)
    for sample in data['samples']:
        assert sample['hash'] == BASELINE.result_hash(values)
        assert sample['liveChargedBytes'] == sample['allocationNs'] == sample['fillNs'] == 0
        assert all(type(sample[k]) is int and sample[k] > 0 for k in WALL_METRICS)
        assert sample['constructionNs'] + sample['kernelNs'] <= sample['allocationInclusiveNs']
        if version == 'original':
            assert not set(OBSERVATIONS) & sample.keys(), 'Original data must not invent missing observations'
        else:
            assert type(sample['kernelCpuNs']) is int and sample['kernelCpuNs'] > 0
            assert all(type(sample[k]) is int and sample[k] >= 0 for k in OBSERVATIONS[1:])
        assert sample['retains'] == sample['nonlastReleases'] == 0
        if profile:
            assert sample['requests'] == sample['releaseChecks'] == 8
            assert sample['requestedBytes'] == 8 * (8 * elements + 8)
            assert sample['peakChargedBytes'] == 8 * elements + 8
        else:
            assert all(sample[k] == 0 for k in ('requests', 'releaseChecks', 'requestedBytes', 'peakChargedBytes'))
    return data


def execution_order(round_index):
    assert type(round_index) is int and 0 <= round_index < 24
    order = (0, 1, 11, 2, 10, 3, 9, 4, 8, 5, 7, 6)
    return [LABELS[(role + round_index + block) % 12] for block in range(4) for role in order]


def summarize(records):
    assert len(records) == 26
    for i, record in enumerate(records):
        phase, number = ('warmup', i) if i < 2 else ('sample', i - 2)
        assert record['phase'] == phase and record['round'] == number and record['complete']
        assert [tuple(r['role']) for r in record['observations']] == execution_order(number)
    results = []
    for label in LABELS:
        rows = [r for record in records if record['phase'] == 'sample'
                for r in record['observations'] if tuple(r['role']) == label]
        assert len(rows) == 96
        metrics = {}
        for metric in WALL_METRICS + (() if label[1] == 'original' else OBSERVATIONS):
            positions = [statistics.median(row['output']['samples'][i][metric] for row in rows) for i in range(5)]
            differences = [row['output']['samples'][0][metric] - row['output']['samples'][4][metric] for row in rows]
            totals = [sum(sample[metric] for row in record['observations'] if tuple(row['role']) == label
                          for sample in row['output']['samples']) for record in records if record['phase'] == 'sample']
            metrics[metric] = dict(samplePositionMedians=positions,
                firstMinusLastMedian=statistics.median(differences), roundTotals=totals,
                medianRoundTotal=statistics.median(totals))
        results.append(dict(role=list(label), processes=len(rows), metrics=metrics))
    lookup = {tuple(row['role']): row['metrics'] for row in results}
    copies, comparisons, failed_copies = [], [], []
    for program in ('fwp', 'reference'):
        for version in VERSIONS:
            ratios = {}
            for metric in WALL_METRICS + (() if version == 'original' else ('kernelCpuNs',)):
                values = [lookup[(program, version, copy)][metric]['medianRoundTotal'] for copy in (0, 1)]
                assert min(values) > 0
                ratio = max(values) / min(values)
                ratios[metric] = ratio
                if ratio > 1.02:
                    failed_copies.append(dict(program=program, version=version, metric=metric, ratio=ratio, limit=1.02))
            copies.append(dict(program=program, version=version, ratios=ratios))
        for copy in (0, 1):
            for before, after in (('original', 'observed'), ('observed', 'preparation-zero')):
                ratios = {metric: lookup[(program, after, copy)][metric]['medianRoundTotal'] /
                          lookup[(program, before, copy)][metric]['medianRoundTotal'] for metric in WALL_METRICS}
                comparisons.append(dict(program=program, copy=copy, before=before, after=after, ratios=ratios))
    return dict(roles=results, identicalRatios=copies, versionComparisons=comparisons, failedCopyLimits=failed_copies)
