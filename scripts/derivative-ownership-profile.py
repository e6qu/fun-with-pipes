"""Add scalar derivative phases to the existing allocation/ownership observers.

Source sites refer to the saved input of each rewrite, not the final C file.
This diagnostic accepts generated native C and complete, nonnested F64 tapes.
"""
from bisect import bisect_right
import importlib.util
import json
from pathlib import Path
import re

SPEC = importlib.util.spec_from_file_location('arc', Path(__file__).with_name('measure-arc-costs.py'))
ARC = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(ARC)
PHASE = ARC.module('descent-phases')
RAW = ARC.module('ad-storage-profile')
PHASES = ('outside',) + PHASE.PHASES
COUNT_OBSERVER = (PHASE.ROOT / 'tests/fixtures/descent_phase_counts.c').read_text()


def allocation_sites(code):
    """Pass explicit site IDs to the two existing counted allocator entries."""
    masked = ARC.OWNERSHIP.mask_c(code)
    starts = [0] + [match.end() for match in re.finditer('\n', code)]
    lines, sites, edits = code.splitlines(), [], []
    for name in ('fwp_heap_alloc', 'fwp_alloc_init'):
        signature = ('size_t n, int kind' if name == 'fwp_heap_alloc' else 'size_t n')
        assert code.count(f'static inline void *{name}({signature}) {{') == 1
        for match in re.finditer(r'\b' + name + r'\b', masked):
            tail = masked[match.end():]
            opening = re.match(r'\s*\(', tail)
            if opening is None:
                raise ValueError(f'unsupported allocator function pointer: {name}')
            end = match.end() + opening.end()
            if re.match(r'size_t n\b', masked[end:]):
                # Include the early prototype and inactive WASI declaration.
                replacement = name + '_profile(size_t allocation_site, '
            else:
                line = bisect_right(starts, match.start())
                replacement = name + f'_profile({len(sites)}, '
                sites.append(dict(id=len(sites), allocator=name, line=line,
                                  source=lines[line - 1].strip()))
            edits.append((match.start(), end, replacement))
    for start, end, replacement in sorted(edits, reverse=True):
        code = code[:start] + replacement + code[end:]
    for marker in ('if(iteration_active && kind!=0){iteration_requests++;iteration_bytes+=n;',
                   'if(iteration_active){iteration_requests++;iteration_bytes+=n;'):
        code = RAW.replace_once(code, marker, marker +
                                'derivative_allocation_hit(allocation_site,n);')
    return code, sites


def instrument(source):
    """Return diagnostic C, site tables and the exact source for each site table."""
    allocation_base = RAW.instrument(ARC.PROFILE.instrument(source))
    ownership_base, allocations = allocation_sites(allocation_base)
    code, ownership = ARC.OWNERSHIP.instrument(ownership_base)
    declarations = f'''
static size_t derivative_phase;
static double derivative_peak[7];
static uint64_t derivative_allocations[7][{len(allocations)}][2];
static uint64_t derivative_ownership[7][{len(ownership)}][3];
static void derivative_allocation_hit(size_t site, size_t bytes) {{
    derivative_allocations[derivative_phase][site][0]++;
    derivative_allocations[derivative_phase][site][1]+=bytes;
}}
'''
    code = RAW.replace_once(code, 'static int iteration_active;',
                            'static int iteration_active;\n' + declarations)
    code = RAW.replace_once(code, 'if (iteration_active) ownership_counts[site][field]++;',
                            'if (iteration_active) { ownership_counts[site][field]++; '
                            'derivative_ownership[derivative_phase][site][field]++; }')
    code = RAW.replace_once(code, 'if(live>iteration_peak)iteration_peak=live;',
                            'if(live>iteration_peak)iteration_peak=live;'
                            'if(live>derivative_peak[derivative_phase])'
                            'derivative_peak[derivative_phase]=live;')
    report = f'''
    for (size_t phase=0; phase<7; phase++) {{
        fprintf(stderr,"derivative-peak\\t%zu\\t%.0f\\n",phase,derivative_peak[phase]);
        for (size_t site=0; site<{len(allocations)}; site++) {{
            uint64_t *row=derivative_allocations[phase][site];
            if(row[0]) fprintf(stderr,"derivative-allocation\\t%zu\\t%zu\\t%llu\\t%llu\\n",
                phase,site,(unsigned long long)row[0],(unsigned long long)row[1]);
        }}
        for (size_t site=0; site<{len(ownership)}; site++) {{
            uint64_t *row=derivative_ownership[phase][site];
            if(row[0]) fprintf(stderr,"derivative-ownership\\t%zu\\t%zu\\t%llu\\t%llu\\t%llu\\n",
                phase,site,(unsigned long long)row[0],(unsigned long long)row[1],
                (unsigned long long)row[2]);
        }}
    }}
'''
    code = RAW.replace_once(code, '    iteration_active=0;', '    iteration_active=0;' + report)
    code = PHASE.instrument(code, COUNT_OBSERVER)
    return code, dict(allocations=allocations, ownership=ownership), {
        'allocation-base.c': allocation_base, 'ownership-base.c': ownership_base}


def parse(stderr, sites, dimensions, updates, workspace):
    """Require every phase/site sum to match the independently retained totals."""
    flat, documents, peaks, allocations, owners = [], {}, {}, {}, {}
    for line in stderr.decode().splitlines():
        fields = line.split('\t')
        kind = fields[0]
        if kind == 'ownership-site':
            flat.append(line)
        elif kind == 'derivative-peak':
            assert len(fields) == 3, line
            phase, peak = map(int, fields[1:])
            assert 0 <= phase < 7 and phase not in peaks and peak >= 0, line
            peaks[phase] = peak
        elif kind in ('derivative-allocation', 'derivative-ownership'):
            allocation = kind == 'derivative-allocation'
            assert len(fields) == (5 if allocation else 6), line
            phase, site, *counts = map(int, fields[1:])
            table, metadata = ((allocations, sites['allocations']) if allocation
                               else (owners, sites['ownership']))
            assert 0 <= phase < 7 and 0 <= site < len(metadata), line
            assert (phase, site) not in table and counts[0] > 0, line
            assert all(n >= 0 for n in counts), line
            if not allocation:
                assert counts[2] <= counts[1] <= counts[0], line
                assert not counts[2] or metadata[site]['operation'] == 'release_last', line
            table[phase, site] = counts
        else:
            row = json.loads(line)
            if set(row) == {'derivativeVisits'} or set(row) == {'rawDerivativeStorage'}:
                key, = row
                assert key not in documents, line
                documents[key] = row[key]
            else:
                flat.append(line)
    assert set(documents) == {'derivativeVisits', 'rawDerivativeStorage'}
    visits = documents['derivativeVisits']
    assert all(type(n) is int for n in visits.values())
    assert visits == dict(updates=updates, inputs=dimensions * updates,
                         nodes=8 * (dimensions - 1) * updates), visits
    RAW.check_profile(documents['rawDerivativeStorage'], updates, workspace)
    totals = ARC.parse_profile(('\n'.join(flat) + '\n').encode(), sites['ownership'])
    assert set(peaks) == set(range(7)), peaks
    assert max(peaks.values()) == totals['managed']['peakChargedBytes']
    assert sum(row[0] for row in allocations.values()) == totals['managed']['requests']
    assert sum(row[1] for row in allocations.values()) == totals['managed']['requestedBytes']
    flat_sites = {row['site']: [row['calls'], row['effective'], row['last']]
                  for row in totals['sites']}
    sums = {}
    for (_, site), counts in owners.items():
        target = sums.setdefault(site, [0, 0, 0])
        for field, n in enumerate(counts):
            target[field] += n
    assert sums == flat_sites, (sums, flat_sites)
    phases = {}
    for index, name in enumerate(PHASES):
        operations = {op: dict(calls=0, effective=0, last=0) for op in ARC.OWNERSHIP.OPERATIONS}
        for (phase, site), counts in owners.items():
            if phase == index:
                target = operations[sites['ownership'][site]['operation']]
                for field, n in zip(('calls', 'effective', 'last'), counts):
                    target[field] += n
        phase_allocations = [row for (phase, _), row in allocations.items() if phase == index]
        phases[name] = dict(requests=sum(row[0] for row in phase_allocations),
                            requestedBytes=sum(row[1] for row in phase_allocations),
                            peakChargedBytes=peaks[index], operations=operations)
        if not updates and index:
            assert not any(phases[name][key] for key in ('requests', 'requestedBytes', 'peakChargedBytes'))
            assert not any(n for row in operations.values() for n in row.values())
    return dict(totals=totals, phases=phases, visits=visits,
                raw=documents['rawDerivativeStorage'],
                allocations=[dict(phase=PHASES[phase], site=site, requests=row[0], requestedBytes=row[1])
                             for (phase, site), row in sorted(allocations.items())],
                ownership=[dict(phase=PHASES[phase], site=site, calls=row[0], effective=row[1], last=row[2])
                           for (phase, site), row in sorted(owners.items())])
