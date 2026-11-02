"""Fixed preparation and observation code for the array-consumption diagnostic."""
import json
import re
import statistics

import array_construction_phases as PHASES

BASELINE = PHASES.MEASURE.BASELINE
LABELS = tuple((program, passes) for program in
    ('fwp', 'fwp-identical', 'reference', 'reference-identical') for passes in (0, 1024))
CPU_CLOCK = r'''static uint64_t bench_setup_cpu_clock(void) {
    struct timespec t;
    if (clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &t) != 0) {
        fputs("process CPU clock failed\n", stderr); exit(1);
    }
    return (uint64_t)t.tv_sec*1000000000+(uint64_t)t.tv_nsec;
}
'''
USAGE = r'''static void bench_setup_usage(struct rusage *usage) {
    if (getrusage(RUSAGE_SELF, usage) != 0) {
        fputs("getrusage failed\n", stderr); exit(1);
    }
}
static uint64_t bench_kernel_cpu_ns;
'''
PREPARATION = r'''    if (argc!=2 || (strcmp(argv[1],"0") && strcmp(argv[1],"1024"))) {
        fputs("usage: PROGRAM 0|1024\n",stderr); return 64;
    }
    const size_t prepare_passes=!strcmp(argv[1],"1024")?1024:0;
    bench_calls=bench_bytes=bench_retains=bench_nonlast_releases=bench_release_checks=0;
    bench_peak_charge=0;bench_initial_charge=fwp_heap.live;
    volatile uint64_t prepare_hash=1469598103934665603ULL;
    uint64_t prepare_cpu_started=bench_setup_cpu_clock(),prepare_started=bench_clock();
    if(prepare_passes) {
        const size_t round=0;
        CONSTRUCT_DRIVER
        bench_sample_live();
        for(size_t pass=0;pass<prepare_passes;pass++) {
            __asm__ volatile("" : "+r"(input) :: "memory");
            fwp_rc_dup(input); /* caller retains its independent array owner */
            V prepared=REDUCE_ENTRY(input);
            if(prepared!=EXPECTED_BITS) {fwp_rc_free_arr(input);fputs("preparation result differs\n",stderr);return 245;}
            prepare_hash=(prepare_hash^prepared)*1099511628211ULL;
        }
        fwp_rc_free_arr(input); /* preparation-final-release control */
    }
    uint64_t prepare_elapsed=bench_clock()-prepare_started;
    uint64_t prepare_cpu=bench_setup_cpu_clock()-prepare_cpu_started;
    if(fwp_heap.live!=bench_initial_charge || fwp_cleanups) {
        fputs("preparation retained storage or cleanup\n",stderr); return 246;
    }
    printf("{\"preparation\":{\"passes\":%zu,\"hash\":\"%016llx\",\"wallNs\":%llu,\"cpuNs\":%llu,\"requests\":%llu,\"requestedBytes\":%llu,\"peakChargedBytes\":%zu,\"liveChargedBytes\":%zu,\"retains\":%llu,\"nonlastReleases\":%llu,\"releaseChecks\":%llu},\"samples\":[\n",prepare_passes,(unsigned long long)prepare_hash,(unsigned long long)prepare_elapsed,(unsigned long long)prepare_cpu,(unsigned long long)bench_calls,(unsigned long long)bench_bytes,bench_peak_charge,fwp_heap.live-bench_initial_charge,(unsigned long long)bench_retains,(unsigned long long)bench_nonlast_releases,(unsigned long long)bench_release_checks);
'''


def source(original, elements, reducer):
    assert elements in (65537, 262145) and re.fullmatch('f[0-9]+', reducer)
    replace = PHASES.replace_once
    prep = replace(PREPARATION, 'CONSTRUCT_DRIVER', PHASES.DRIVER_CONSTRUCTION)
    prep = replace(prep, 'REDUCE_ENTRY', reducer)
    prep = replace(prep, 'EXPECTED_BITS', str(BASELINE.array_result(elements, 0)) + 'ULL')
    result = '#include <sys/resource.h>\n' + original
    marker = 'static uint64_t bench_clock(void){'
    result = replace(result, marker, CPU_CLOCK + USAGE + marker)
    result = replace(result, 'int main(void){', 'int main(int argc,char **argv){')
    result = replace(result, '    puts("{\\"samples\\":[");\n', prep)
    result = replace(result, 'bench_kernel_ns=0;', 'bench_kernel_ns=bench_kernel_cpu_ns=0;')
    marker = '        uint64_t hash=1469598103934665603ULL,start=bench_clock();'
    result = replace(result, marker,
        '        struct rusage usage_before,usage_after;bench_setup_usage(&usage_before);\n' + marker)
    consume = f'uint64_t before=bench_clock();V result={reducer}(input);bench_kernel_ns+=bench_clock()-before;'
    result = replace(result, consume, 'uint64_t cpu_before=bench_setup_cpu_clock();' + consume
        + 'bench_kernel_cpu_ns+=bench_setup_cpu_clock()-cpu_before;')
    marker = '        uint64_t elapsed=bench_clock()-start;'
    result = replace(result, marker, marker + '\n        bench_setup_usage(&usage_after);')
    result = replace(result, '\\"kernelNs\\":%llu,',
        '\\"kernelNs\\":%llu,\\"kernelCpuNs\\":%llu,\\"minorFaults\\":%ld,\\"majorFaults\\":%ld,\\"voluntarySwitches\\":%ld,\\"involuntarySwitches\\":%ld,')
    result = replace(result, '(unsigned long long)bench_kernel_ns,(unsigned long long)bench_construction_ns,',
        '(unsigned long long)bench_kernel_ns,(unsigned long long)bench_kernel_cpu_ns,'
        'usage_after.ru_minflt-usage_before.ru_minflt,usage_after.ru_majflt-usage_before.ru_majflt,'
        'usage_after.ru_nvcsw-usage_before.ru_nvcsw,usage_after.ru_nivcsw-usage_before.ru_nivcsw,'
        '(unsigned long long)bench_construction_ns,')
    return result


def check_output(raw, elements, passes, profile, verification):
    assert elements in (65537, 262145) and passes in (0, 1024)
    values = [[BASELINE.array_result(elements, r)] for r in range(8)]
    if verification:
        lines = re.findall(rb'^\d+:0:[0-9a-f]{16}\n', raw, re.M)
        assert b''.join(lines) == BASELINE.verification_output(values)
        raw = re.sub(rb'^\d+:0:[0-9a-f]{16}\n', b'', raw, flags=re.M)
    data = json.loads(raw)
    assert set(data) == {'preparation', 'samples'}
    prep = data['preparation']
    expected = BASELINE.result_hash([[values[0][0]]] * passes)
    assert prep['passes'] == passes and prep['hash'] == expected
    assert prep['liveChargedBytes'] == 0 and prep['wallNs'] > 0 and prep['cpuNs'] > 0
    if profile:
        count = int(passes != 0)
        assert prep['requests'] == count
        assert prep['requestedBytes'] == prep['peakChargedBytes'] == count * (8 * elements + 8)
        assert prep['retains'] == prep['nonlastReleases'] == passes
        assert prep['releaseChecks'] == passes + count
    else:
        assert all(prep[key] == 0 for key in ('requests', 'requestedBytes', 'peakChargedBytes',
            'retains', 'nonlastReleases', 'releaseChecks'))
    assert len(data['samples']) == (1 if verification else 5)
    for sample in data['samples']:
        assert sample['hash'] == BASELINE.result_hash(values)
        assert sample['liveChargedBytes'] == 0
        assert sample['allocationNs'] == sample['fillNs'] == 0
        for key in ('kernelNs', 'kernelCpuNs', 'constructionNs', 'allocationInclusiveNs'):
            assert type(sample[key]) is int and sample[key] > 0
        assert sample['kernelNs'] + sample['constructionNs'] <= sample['allocationInclusiveNs']
        for key in ('minorFaults', 'majorFaults', 'voluntarySwitches', 'involuntarySwitches'):
            assert type(sample[key]) is int and sample[key] >= 0
        if profile:
            assert sample['requests'] == sample['releaseChecks'] == 8
            assert sample['requestedBytes'] == 8 * (8 * elements + 8)
            assert sample['peakChargedBytes'] == 8 * elements + 8
            assert sample['retains'] == sample['nonlastReleases'] == 0
        else:
            assert all(sample[key] == 0 for key in ('requests', 'requestedBytes', 'peakChargedBytes',
                'retains', 'nonlastReleases', 'releaseChecks'))
    return data


def execution_order(round_index):
    assert type(round_index) is int and 0 <= round_index < 16
    order = (0, 1, 7, 2, 6, 3, 5, 4)
    return [LABELS[(role + round_index + block) % 8] for block in range(4) for role in order]


def summarize(records):
    assert len(records) == 18
    for i, record in enumerate(records):
        phase, index = ('warmup', i) if i < 2 else ('sample', i - 2)
        assert record['phase'] == phase and record['round'] == index and record['complete']
        assert [tuple(row['role']) for row in record['observations']] == execution_order(index)
    results = []
    for program, passes in LABELS:
        rows = [row for record in records if record['phase'] == 'sample'
                for row in record['observations'] if tuple(row['role']) == (program, passes)]
        assert len(rows) == 64
        metrics = {}
        for metric in ('constructionNs', 'kernelNs', 'kernelCpuNs', 'allocationInclusiveNs',
                       'minorFaults', 'majorFaults', 'voluntarySwitches', 'involuntarySwitches'):
            positions = [statistics.median(row['output']['samples'][i][metric] for row in rows) for i in range(5)]
            differences = [row['output']['samples'][0][metric] - row['output']['samples'][4][metric] for row in rows]
            totals = [sum(sample[metric] for row in record['observations'] if tuple(row['role']) == (program, passes)
                          for sample in row['output']['samples']) for record in records if record['phase'] == 'sample']
            metrics[metric] = dict(samplePositionMedians=positions,
                firstMinusLastMedian=statistics.median(differences), roundTotals=totals,
                medianRoundTotal=statistics.median(totals))
        results.append(dict(program=program, preparationPasses=passes, processes=len(rows), metrics=metrics))
    lookup = {(row['program'], row['preparationPasses']): row['metrics'] for row in results}
    copies, preparation = [], []
    for program in ('fwp', 'reference'):
        for passes in (0, 1024):
            ratios = {}
            for metric in ('constructionNs', 'kernelNs', 'kernelCpuNs', 'allocationInclusiveNs'):
                values = [lookup[(role, passes)][metric]['medianRoundTotal']
                          for role in (program, program + '-identical')]
                assert min(values) > 0
                ratios[metric] = max(values) / min(values)
            copies.append(dict(program=program, preparationPasses=passes, ratios=ratios))
    for program in ('fwp', 'fwp-identical', 'reference', 'reference-identical'):
        ratios = {metric: lookup[(program, 1024)][metric]['medianRoundTotal'] /
                  lookup[(program, 0)][metric]['medianRoundTotal']
                  for metric in ('constructionNs', 'kernelNs', 'kernelCpuNs', 'allocationInclusiveNs')}
        preparation.append(dict(program=program, preparedOverUnprepared=ratios))
    return dict(roles=results, identicalRatios=copies, preparationComparisons=preparation)


def clock_source(pairs):
    assert pairs == 10000
    return r'''#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
''' + CPU_CLOCK + r'''static uint64_t bench_setup_wall_clock(void) {
    struct timespec t;
    if(clock_gettime(CLOCK_MONOTONIC,&t)!=0) {
        fputs("wall clock failed\n",stderr);exit(1);
    }
    return (uint64_t)t.tv_sec*1000000000+(uint64_t)t.tv_nsec;
}
int main(void) {
    uint64_t wall=0,cpu=0;
    for(size_t i=0;i<''' + str(pairs) + r''';i++) {
        uint64_t c=bench_setup_cpu_clock(),w=bench_setup_wall_clock();
        __asm__ volatile("" ::: "memory");
        wall+=bench_setup_wall_clock()-w;cpu+=bench_setup_cpu_clock()-c;
    }
    printf("{\"pairs\":%u,\"wallNs\":%llu,\"cpuNs\":%llu}\n",''' + str(pairs) + r''',
        (unsigned long long)wall,(unsigned long long)cpu);
    return 0;
}
'''
