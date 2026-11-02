"""Exact construction/consumption timer boundaries for materialized arrays."""
import importlib.util
from pathlib import Path

SPEC = importlib.util.spec_from_file_location('kernel_measurement', Path(__file__).with_name('measure-kernel-baselines.py'))
MEASURE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MEASURE)
replace_once = MEASURE.replace_once
METRICS = ('constructionNs', 'kernelNs', 'allocationInclusiveNs')
DRIVER_CONSTRUCTION = '''V input=fwp_rc_fresh(fwp_array_new_packed(elements,&scalar));
            for(size_t i=0;i<elements;i++)fwp_array_store(input,i,fwp_from_f64(((double)(int)((i+round)%19)-9.0)/4.0),&scalar);'''


def native_source(generated, reduce, constructor, dimensions, role, profile, verification, phases):
    assert role in ('fwp', 'reference') and (not phases or profile)
    source = MEASURE.native_source(generated, reduce, dimensions, False, profile, verification)
    source = replace_once(source, 'static uint64_t bench_kernel_ns,',
                          'static uint64_t bench_construction_ns,bench_allocation_ns,bench_fill_ns,bench_kernel_ns,')
    source = replace_once(source, 'bench_peak_charge=0;bench_kernel_ns=0;',
                          'bench_peak_charge=0;bench_kernel_ns=0;bench_construction_ns=bench_allocation_ns=bench_fill_ns=0;')
    construction = DRIVER_CONSTRUCTION if role == 'reference' else f'V input={constructor}(round,elements);'
    if phases and role == 'reference':
        allocation, filling = construction.split('\n', 1)
        construction = ('uint64_t allocation_started=bench_clock();' + allocation
            + '\n__asm__ volatile("" : "+r"(input) :: "memory");bench_allocation_ns+=bench_clock()-allocation_started;\n'
            + 'uint64_t fill_started=bench_clock();' + filling
            + '\n__asm__ volatile("" : "+r"(input) :: "memory");bench_fill_ns+=bench_clock()-fill_started;')
    source = replace_once(source, DRIVER_CONSTRUCTION,
        'uint64_t construction_started=bench_clock();' + construction
        + '\n__asm__ volatile("" : "+r"(input) :: "memory");bench_construction_ns+=bench_clock()-construction_started;')
    source = replace_once(source, '\\"kernelNs\\":%llu,',
        '\\"kernelNs\\":%llu,\\"constructionNs\\":%llu,\\"allocationNs\\":%llu,\\"fillNs\\":%llu,')
    source = replace_once(source, '(unsigned long long)bench_kernel_ns,(unsigned long long)hash,',
        '(unsigned long long)bench_kernel_ns,(unsigned long long)bench_construction_ns,'
        '(unsigned long long)bench_allocation_ns,(unsigned long long)bench_fill_ns,(unsigned long long)hash,')
    if phases and role == 'fwp':
        start = source.index('static V fwp_p_array_generate_typed(')
        end = source.index('\n}', start) + 2
        body = source[start:end]
        body = replace_once(body, '    fwp_array_builder result = {',
                            '    uint64_t allocation_started=bench_clock();\n    fwp_array_builder result = {')
        body = replace_once(body, '    fwp_cleanup cleanup;',
                            '    __asm__ volatile("" : "+r"(result.value) :: "memory");\n    bench_allocation_ns+=bench_clock()-allocation_started;\n    fwp_cleanup cleanup;')
        body = replace_once(body, '    for (size_t i = 0;',
                            '    uint64_t fill_started=bench_clock();\n    for (size_t i = 0;')
        body = replace_once(body, '    return fwp_array_builder_finish(',
                            '    __asm__ volatile("" : "+r"(result.value) :: "memory");\n    bench_fill_ns+=bench_clock()-fill_started;\n    return fwp_array_builder_finish(')
        source = source[:start] + body + source[end:]
    return source


def peer_source(original, language, dimensions, verification):
    source = MEASURE.configured_peer(original, language, dimensions, verification)
    if language == 'c':
        source = replace_once(source, 'uint64_t kernel_ns=0,hash=', 'uint64_t construction_ns=0,kernel_ns=0,hash=')
        source = replace_once(source, 'double *a=allocate(elements*8);',
                              'uint64_t construction_started=now_ns();double *a=allocate(elements*8);')
        source = replace_once(source, '__asm__ volatile("" : "+r"(a) :: "memory");',
                              '__asm__ volatile("" : "+r"(a) :: "memory");construction_ns+=now_ns()-construction_started;')
        source = replace_once(source, '\\"kernelNs\\":%llu,', '\\"kernelNs\\":%llu,\\"constructionNs\\":%llu,')
        source = replace_once(source, '(unsigned long long)kernel_ns,(unsigned long long)hash,',
                              '(unsigned long long)kernel_ns,(unsigned long long)construction_ns,(unsigned long long)hash,')
    else:
        assert language == 'rust'
        source = replace_once(source, 'let mut kernel_ns=0u128;', 'let mut kernel_ns=0u128;let mut construction_ns=0u128;')
        source = replace_once(source, 'let input:Vec<f64>=', 'let construction_started=Instant::now();let input:Vec<f64>=')
        source = replace_once(source, 'let before=Instant::now();let value=consume_array(',
                              'let input=black_box(input);construction_ns+=construction_started.elapsed().as_nanos();let before=Instant::now();let value=consume_array(')
        source = replace_once(source, '\\"kernelNs\\":{},', '\\"kernelNs\\":{},\\"constructionNs\\":{},')
        source = replace_once(source, 'elapsed,kernel_ns,hash,', 'elapsed,kernel_ns,construction_ns,hash,')
    return source


def check_samples(raw, expected_hash, label, profile, phases):
    assert not phases or label in ('fwp', 'reference')
    samples = MEASURE.check_samples(raw, expected_hash, 'fwp' if label.startswith('reference') else label, profile)
    for sample in samples:
        assert type(sample['constructionNs']) is int and sample['constructionNs'] > 0
        assert sample['constructionNs'] + sample['kernelNs'] <= sample['allocationInclusiveNs']
        if label in ('fwp', 'fwp-identical', 'reference', 'reference-identical'):
            if phases:
                assert all(type(sample[key]) is int and sample[key] > 0 for key in ('allocationNs', 'fillNs'))
                assert 0 < sample['allocationNs'] + sample['fillNs'] <= sample['constructionNs']
            else:
                assert sample['allocationNs'] == sample['fillNs'] == 0
    return samples
