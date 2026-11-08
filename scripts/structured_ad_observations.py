"""Separate managed-owner and raw-tape observers for structured gradients."""
import importlib.util
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('iteration_observer', ROOT / 'scripts/measure-iteration.py')
MANAGED = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MANAGED)
RAW_SPEC = importlib.util.spec_from_file_location('raw_ad_observer', ROOT / 'scripts/ad-storage-profile.py')
RAW = importlib.util.module_from_spec(RAW_SPEC)
RAW_SPEC.loader.exec_module(RAW)


def replace_once(source, before, after):
    assert source.count(before) == 1, ('observation site changed', before)
    return source.replace(before, after)


def instrument(source):
    source = replace_once(source, 'typedef uint64_t V;', '''typedef uint64_t V;
static int iteration_active;
static uint64_t iteration_requests, iteration_bytes, iteration_retains;
static uint64_t observed_dup_calls, observed_drop_calls, observed_drop_changes;
static uint64_t observed_release_calls, observed_shared_releases, observed_last_owners, observed_uncounted;
static double iteration_start_charge, iteration_peak;
static void iteration_sample(void);
''')
    source = MANAGED.wrap(source, 'static inline void *fwp_heap_alloc(size_t n, int kind) {',
                          'fwp_heap_alloc', 'n, kind',
                          'if(iteration_active && kind!=0){iteration_requests++;iteration_bytes+=n;}')
    source = MANAGED.wrap(source, 'static inline void *fwp_alloc_init(size_t n) {',
                          'fwp_alloc_init', 'n',
                          'if(iteration_active){iteration_requests++;iteration_bytes+=n;}')
    source = replace_once(source, 'static inline void fwp_rc_dup(V v) {\n',
                          'static inline void fwp_rc_dup(V v) {\nif(iteration_active)observed_dup_calls++;\n')
    marker = 'uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {'
    source = replace_once(source, marker, marker + '\nif(iteration_active)iteration_retains++;')
    marker = '''static inline void fwp_rc_drop(V v) {
    uint8_t *c = fwp_rc_slot(v);
    if (c && *c > 1) fwp_rc_drop_slot(c);
}'''
    source = replace_once(source, marker, '''static inline void fwp_rc_drop(V v) {
    if(iteration_active)observed_drop_calls++;
    uint8_t *c = fwp_rc_slot(v);
    if (c && *c > 1) { if(iteration_active)observed_drop_changes++; fwp_rc_drop_slot(c); }
}''')
    marker = '''static inline int fwp_rc_release_last(V v) {
    uint8_t *c = fwp_rc_slot(v);
    if (!c || !*c) return 0;
    if (*c == 1) return 1;
    fwp_rc_drop_slot(c);
    return 0;
}'''
    source = replace_once(source, marker, '''static inline int fwp_rc_release_last(V v) {
    if(iteration_active)observed_release_calls++;
    uint8_t *c = fwp_rc_slot(v);
    if (!c || !*c) { if(iteration_active)observed_uncounted++; return 0; }
    if (*c == 1) { if(iteration_active)observed_last_owners++; return 1; }
    if(iteration_active)observed_shared_releases++;
    fwp_rc_drop_slot(c);
    return 0;
}''')
    helpers = '''static void iteration_sample(void) {
    if(iteration_active) {
        double charge=(double)fwp_heap.live-iteration_start_charge;
        if(charge>iteration_peak)iteration_peak=charge;
    }
}
'''
    source = replace_once(source, '/* Complete-gradient call:', helpers + '\n/* Complete-gradient call:')
    source = replace_once(source, '    /* Structured gradient observer starts here. */',
                          '    iteration_start_charge=(double)fwp_heap.live;iteration_active=1;\n')
    source = replace_once(source, '    /* Structured gradient observer stops here. */', '''    iteration_active=0;
    fprintf(stderr,"{\\"requests\\":%llu,\\"requestedBytes\\":%llu,\\"retainCalls\\":%llu,\\"retains\\":%llu,\\"dropCalls\\":%llu,\\"dropChanges\\":%llu,\\"releaseCalls\\":%llu,\\"sharedReleases\\":%llu,\\"lastOwners\\":%llu,\\"uncountedReleases\\":%llu,\\"peakChargedBytes\\":%.0f,\\"finalChargedBytes\\":%.0f}\\n",
        (unsigned long long)iteration_requests,(unsigned long long)iteration_bytes,
        (unsigned long long)observed_dup_calls,(unsigned long long)iteration_retains,
        (unsigned long long)observed_drop_calls,(unsigned long long)observed_drop_changes,
        (unsigned long long)observed_release_calls,(unsigned long long)observed_shared_releases,
        (unsigned long long)observed_last_owners,(unsigned long long)observed_uncounted,
        iteration_peak,(double)fwp_heap.live-iteration_start_charge);
''')
    return RAW.instrument(source, 'records')


def check_reports(managed, raw, count, repeats, method, workspace):
    assert managed['finalChargedBytes'] == 0 and raw['finalBytes'] == 0
    assert managed['peakChargedBytes'] >= 0
    assert managed['retains'] <= managed['retainCalls']
    assert managed['dropChanges'] <= managed['dropCalls']
    assert managed['releaseCalls'] == sum(managed[key] for key in
        ('sharedReleases', 'lastOwners', 'uncountedReleases'))
    assert method in ('reverse', 'forward', 'local', 'tensor')
    RAW.check_profile(raw, repeats if method == 'reverse' else 0, workspace and count > 0)


def stack_report(text, entry):
    frames = []
    for line in text.splitlines():
        location, size, kind = line.rsplit('\t', 2)
        assert size.isdigit() and kind in ('static', 'dynamic,bounded', 'dynamic'), line
        frames.append(dict(function=location.rsplit(':', 1)[1], bytes=int(size), kind=kind))
    main, = [frame for frame in frames if frame['function'] == 'main']
    selected = [frame for frame in frames if frame['function'] == entry or frame['function'].startswith(entry + '.')]
    return dict(main=main, entryFrames=selected, maximumAnyFrameBytes=max(frame['bytes'] for frame in frames),
                frameCount=len(frames))
