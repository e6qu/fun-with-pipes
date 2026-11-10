"""Observe actual service ownership calls in separate, untimed native builds."""
import json

from weak_callback_service import replace_once, unique_fields

COUNTERS = ('pushes', 'pops', 'unwinds', 'dupCalls', 'dropCalls', 'releaseCalls',
            'retains', 'decrements', 'requests', 'requestedBytes')
MEMORY = ('initialLiveBytes', 'finalLiveBytes', 'peakChargedBytes')


def instrument(source):
    source = replace_once(source, 'typedef uint64_t V;',
        'typedef uint64_t V;\nstatic uint64_t ' + ', '.join('observed_' + key for key in COUNTERS) + ';')
    for marker, count in (
        ('static void fwp_cleanup_push(fwp_cleanup *c, void (*release)(void *), void *arg) {', 'pushes'),
        ('static void fwp_cleanup_pop(fwp_cleanup *c) {', 'pops'),
        ('        c->release(c->arg);', 'unwinds'),
        ('static inline void fwp_rc_dup(V v) {', 'dupCalls'),
        ('static inline void fwp_rc_drop(V v) {', 'dropCalls'),
        ('static inline int fwp_rc_release_last(V v) {', 'releaseCalls'),
        ('static inline void fwp_rc_dup(V v) {\n    observed_dupCalls++;\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {', 'retains'),
        ('static inline void fwp_rc_drop_slot(uint8_t *slot) {', 'decrements'),
    ):
        source = replace_once(source, marker, marker + '\n    observed_' + count + '++;')
    for marker, addition in (
        ('static inline void *fwp_heap_alloc(size_t n, int kind) {',
         '\n    if (kind != 0) { observed_requests++; observed_requestedBytes += n; }'),
        ('static inline void *fwp_alloc_init(size_t n) {',
         '\n    observed_requests++; observed_requestedBytes += n;'),
    ):
        source = replace_once(source, marker, marker + addition)
    source = replace_once(source, '    size_t baseline = fwp_heap.live;',
        '    size_t baseline = fwp_heap.live;\n'
        '    fwp_cleanup *cleanup_baseline = fwp_cleanups;\n'
        '    ' + ' = '.join('observed_' + key for key in COUNTERS) + ' = 0;\n'
        '    fwp_heap.peak = baseline;')
    fields = [f'\\"{key}\\":%llu' for key in (*COUNTERS, *MEMORY)]
    values = ['observed_' + key for key in COUNTERS] + ['baseline', 'fwp_heap.live', 'fwp_heap.peak']
    report = ('    if (fwp_cleanups != cleanup_baseline) { fputs("service cleanup stack changed\\n", stderr); exit(80); }\n'
              '    fprintf(stderr, "{' + ','.join(fields) + '}\\n",\n        '
              + ', '.join('(unsigned long long)' + value for value in values) + ');\n')
    marker = '    if (fwp_heap.live != baseline) { fputs("service storage not released\\n", stderr); exit(79); }\n'
    return replace_once(source, marker, marker + report)


def decode(text):
    row = json.loads(text, object_pairs_hook=unique_fields)
    assert set(row) == {*COUNTERS, *MEMORY}
    assert all(type(value) is int and value >= 0 for value in row.values())
    assert row['initialLiveBytes'] == row['finalLiveBytes'] <= row['peakChargedBytes']
    assert row['pushes'] == row['pops'] + row['unwinds'] > 0
    assert 0 < row['retains'] <= row['dupCalls']
    assert 0 < row['decrements'] <= row['dropCalls'] + row['releaseCalls']
    assert 0 < row['requests'] <= row['requestedBytes']
    return row


def compare(reference, candidate):
    for key in ('requests', 'requestedBytes', 'peakChargedBytes'):
        assert candidate[key] <= reference[key], (key, reference, candidate)
    return dict(cleanupReduction=1 - candidate['pushes'] / reference['pushes'],
                cleanupTargetMet=candidate['pushes'] <= reference['pushes'] * .8,
                delta={key: candidate[key] - reference[key] for key in (*COUNTERS, *MEMORY)})
