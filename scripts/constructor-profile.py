"""Count heap constructors by their source callers in diagnostic native C.

Extend the existing derivative observer; never change production C. A source
site must have one tag/field shape per phase. Reject mixed shapes explicitly
instead of attributing them to a misleading aggregate or allocating a table.
"""
from bisect import bisect_right
import importlib.util
from pathlib import Path
import re

SPEC = importlib.util.spec_from_file_location('profile', Path(__file__).with_name('derivative-ownership-profile.py'))
PROFILE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PROFILE)
SUMMARY = PROFILE.ARC.module('summarize-arc-costs')
SIGNATURES = {
    'fwp_data': 'uint32_t tag, uint32_t n, const V *f',
    'fwp_record': 'uint32_t n, const V *f',
    'fwp_tuple2': 'V a, V b',
    'fwp_some': 'V x',
    'fwp_cons': 'V x, V xs',
    'fwp_map_finish_protected': 'fwp_map_owner *owner, fwp_cleanup *cleanup',
}
FORWARDS = {('fwp_record', 'fwp_data'), ('fwp_tuple2', 'fwp_record'),
            ('fwp_some', 'fwp_data'), ('fwp_cons', 'fwp_data'),
            ('fwp_map_finish_protected', 'fwp_data')}
CONTROL = '''
        V fields[2]={2,3};
        V record=fwp_rc_fresh(fwp_record(2,fields)); fwp_rc_free_obj(record);
        V cell=fwp_rc_fresh(fwp_cons(2,0)); fwp_rc_free_obj(cell);
        V some=fwp_rc_fresh(fwp_some(2)); fwp_rc_free_obj(some);
        V pair=fwp_rc_fresh(fwp_tuple2(2,3)); fwp_rc_free_obj(pair);
        V data=fwp_rc_fresh(fwp_data(9,1,fields)); fwp_rc_free_obj(data);
        V *items=(V *)fwp_mem_alloc(sizeof(V)); items[0]=2;
        fwp_map_owner owner={items,1,0,NULL,fwp_rc_free_obj}; fwp_cleanup cleanup;
        fwp_map_protect(&owner,&cleanup);
        V mapped=fwp_map_finish_protected(&owner,&cleanup); fwp_rc_free_obj(mapped);
        if(fwp_data(5,0,NULL)!=5 || fwp_record(0,NULL)!=0) abort();
'''


def check_control(profile, rows, sites):
    expected = {'fwp_record': (0, 2), 'fwp_cons': (1, 2), 'fwp_some': (1, 1),
                'fwp_tuple2': (0, 2), 'fwp_data': (9, 1),
                'fwp_map_finish_protected': (1, 2)}
    for phase, name in enumerate(PROFILE.PHASES):
        repeat = phase + 1
        selected = [row for row in rows if row['phase'] == name]
        assert len(selected) == len(expected), (name, selected)
        observed = {}
        for row in selected:
            site = sites[row['site']]
            assert site['caller'] == 'fwp_main_thread', site
            constructor = site['constructor']
            assert constructor not in observed and row['requests'] == repeat, row
            observed[constructor] = (row['tag'], row['fields'])
        assert observed == expected, observed
        assert profile['phases'][name]['requests'] == 7 * repeat
        assert profile['phases'][name]['requestedBytes'] == 136 * repeat


def control_variants(code, sites):
    data_sites = [site for site in sites if site['constructor'] == 'fwp_data'
                  and 'V data=' in site['source']]
    assert len(data_sites) == 7, data_sites
    # The second phase executes twice, allowing a same-site mixed-shape control.
    data = data_sites[1]
    call = f'fwp_data({data["id"]}, 9,1,fields)'
    line, = [line for line in code.splitlines() if call in line]
    leaked, count = re.subn(r'fwp_rc_free_obj_profile\(\d+, data\);', '', line)
    assert count == 1, line
    return {
        'complete': code,
        'missing-hit': PROFILE.RAW.replace_once(code, 'row->requests++;', ''),
        'wrong-phase': PROFILE.RAW.replace_once(code,
            '&constructor_counts[derivative_phase][site]', '&constructor_counts[0][site]'),
        'unknown-site': PROFILE.RAW.replace_once(code, call,
            f'fwp_data({len(sites)}, 9,1,fields)'),
        'mixed-shape': PROFILE.RAW.replace_once(code, call,
            f'fwp_data({data["id"]}, 9+repeat,1,fields)'),
        'leak': PROFILE.RAW.replace_once(code, line, leaked),
    }


def caller_at(functions, starts, line):
    index = bisect_right(starts, line) - 1
    if index < 0 or line > functions[index][1]:
        raise ValueError(f'unresolved constructor caller at line {line}')
    return functions[index][2]


def instrument(source):
    masked = PROFILE.ARC.OWNERSHIP.mask_c(source)
    functions = SUMMARY.caller_lines(source)
    function_starts = [row[0] for row in functions]
    starts = [0] + [m.end() for m in re.finditer('\n', source)]
    lines = source.splitlines()
    definitions, sites, edits, edges = {}, [], [], []
    for name, signature in SIGNATURES.items():
        matches = list(re.finditer(r'static (?:inline )?V ' + name +
                                  r'\(' + re.escape(signature) + r'\) \{', masked))
        if len(matches) != 1:
            raise ValueError(f'expected one constructor definition: {name}')
        match, = matches
        definitions[name] = (masked.index(name, match.start()), match.end())
    pattern = r'\b(' + '|'.join(SIGNATURES) + r')\b'
    for match in re.finditer(pattern, masked):
        name = match[0]
        opening = re.match(r'\s*\(', masked[match.end():])
        if opening is None:
            raise ValueError(f'unsupported constructor reference: {name}')
        end = match.end() + opening.end()
        if match.start() == definitions[name][0]:
            argument = 'size_t constructor_site'
        else:
            line = bisect_right(starts, match.start())
            caller = caller_at(functions, function_starts, line)
            if caller in SIGNATURES:
                edges.append((caller, name))
                argument = 'constructor_site'
            else:
                argument = str(len(sites))
                sites.append(dict(id=len(sites), constructor=name, caller=caller,
                                  line=line, source=lines[line - 1].strip()))
        edits.append((end, argument + ', '))
    if len(edges) != len(FORWARDS) or set(edges) != FORWARDS:
        raise ValueError(f'changed constructor forwarding: {edges}')
    if not sites:
        raise ValueError('no constructor call sites')
    code = source
    for offset, text in reversed(edits):
        code = code[:offset] + text + code[offset:]
    # A rejected observer must stop before indexing its table. Flush explicitly
    # and bypass atexit: the phase observer otherwise overwrites status 234 with
    # its own unfinished-sequence status, hiding which control rejected the run.
    declarations = f'''
typedef struct {{ uint64_t requests, bytes; uint32_t tag, fields; }} constructor_row;
static constructor_row constructor_counts[7][{len(sites)}];
static void constructor_hit(size_t site, uint32_t tag, uint32_t fields, size_t bytes) {{
    if (!iteration_active) return;
    if (derivative_phase >= 7 || site >= {len(sites)}) {{
        fputs("invalid constructor site or phase\\n", stderr); fflush(stderr); _Exit(234);
    }}
    constructor_row *row = &constructor_counts[derivative_phase][site];
    if (row->requests && (row->tag != tag || row->fields != fields)) {{
        fputs("mixed constructor shape\\n", stderr); fflush(stderr); _Exit(234);
    }}
    row->tag=tag; row->fields=fields; row->requests++; row->bytes+=bytes;
}}
'''
    code = PROFILE.RAW.replace_once(code, 'static size_t derivative_phase;',
                                   'static size_t derivative_phase;\n' + declarations)
    code = PROFILE.RAW.replace_once(code, '    if (n == 0) return tag;',
        '    if (n == 0) return tag;\n'
        '    constructor_hit(constructor_site,tag,n,sizeof(fwp_obj)+n*sizeof(V));')
    report = f'''
    for (size_t phase=0; phase<7; phase++) {{
        for (size_t site=0; site<{len(sites)}; site++) {{
            constructor_row *row=&constructor_counts[phase][site];
            if(row->requests) fprintf(stderr,"constructor-allocation\\t%zu\\t%zu\\t%u\\t%u\\t%llu\\t%llu\\n",
                phase,site,row->tag,row->fields,(unsigned long long)row->requests,
                (unsigned long long)row->bytes);
        }}
    }}
'''
    code = PROFILE.RAW.replace_once(code, '    iteration_active=0;',
                                   '    iteration_active=0;' + report)
    return code, sites


def data_allocator_sites(source, sites):
    functions = SUMMARY.caller_lines(source)
    starts = [row[0] for row in functions]
    selected = {site['id'] for site in sites if
                caller_at(functions, starts, site['line']) == 'fwp_data'}
    if len(selected) != 1:
        raise ValueError(f'expected one shared constructor allocator: {selected}')
    return selected


def parse(stderr, sites, allocator_sites, profile_sites, dimensions, updates, workspace):
    remaining, rows = [], {}
    for line in stderr.decode().splitlines():
        fields = line.split('\t')
        if fields[0] != 'constructor-allocation':
            remaining.append(line)
            continue
        assert len(fields) == 7, line
        phase, site, tag, count, requests, size = map(int, fields[1:])
        assert 0 <= phase < 7 and 0 <= site < len(sites), line
        assert sites[site]['id'] == site and (phase, site) not in rows, line
        assert 0 <= tag < 2**32 and 0 < count < 2**32 and requests > 0, line
        assert size == requests * (8 + 8 * count), line
        rows[phase, site] = dict(phase=PROFILE.PHASES[phase], site=site, tag=tag,
                                fields=count, requests=requests, requestedBytes=size)
    profile = PROFILE.parse(('\n'.join(remaining) + '\n').encode(), profile_sites,
                            dimensions, updates, workspace)
    for phase, name in enumerate(PROFILE.PHASES):
        expected = [row for row in profile['allocations'] if
                    row['phase'] == name and row['site'] in allocator_sites]
        actual = [row for (p, _), row in rows.items() if p == phase]
        for field in ('requests', 'requestedBytes'):
            assert sum(row[field] for row in actual) == sum(row[field] for row in expected), (name, field)
    return profile, [row for _, row in sorted(rows.items())]
