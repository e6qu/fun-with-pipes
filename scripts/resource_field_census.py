"""Describe original lifetime holders without changing the C they emit."""
import json
import re

from weak_callback_service import replace_once, unique_fields

PREFIX = 'FWP_RESOURCE_FIELDS '
HOLD_COUNTERS = ('plainHolds', 'plainRetains', 'plainDrops', 'plainDecrements')
MARKER = '        assert!(!protection.is_empty(), "empty original resource region");'
OBSERVER = r'''
        let observed_fields: Vec<_> = entries.iter().enumerate().map(|(slot, (_, ty))| {
            let mut name = String::new();
            crate::json::escape(&format!("{ty:?}"), &mut name);
            format!("{{\"slot\":{slot},\"observable\":{},\"type\":{name}}}", self.g.resource_type(ty))
        }).collect();
        eprintln!("FWP_RESOURCE_FIELDS {{\"function\":{},\"context\":{id},\"variable\":\"{ctx}\",\"node\":\"{node}\",\"variants\":{},\"fields\":[{}]}}",
            self.me, variants.len(), observed_fields.join(","));
'''


def instrument(source):
    assert PREFIX not in source
    return replace_once(source, MARKER, MARKER + OBSERVER)


def decode(stderr):
    rows = []
    contexts = set()
    for line in stderr.splitlines():
        assert line.startswith(PREFIX), line
        row = json.loads(line[len(PREFIX):], object_pairs_hook=unique_fields)
        assert set(row) == {'function', 'context', 'variable', 'node', 'variants', 'fields'}
        for key in ('function', 'context', 'variants'):
            assert type(row[key]) is int and row[key] >= 0
        assert row['context'] not in contexts, 'repeated cleanup context'
        contexts.add(row['context'])
        for key in ('variable', 'node'):
            assert isinstance(row[key], str) and re.fullmatch(r't[0-9]+', row[key])
        assert type(row['fields']) is list
        assert row['fields'] or row['variants'] > 0
        for slot, field in enumerate(row['fields']):
            assert set(field) == {'slot', 'observable', 'type'}
            assert type(field['slot']) is int and field['slot'] == slot
            assert type(field['observable']) is bool
            assert isinstance(field['type'], str) and field['type']
        rows.append(row)
    return rows


def validate_contexts(source, rows):
    """Reject ordinary cleanup records mislabeled as original lifetime holders."""
    for row in rows:
        context, variable, node = row['context'], row['variable'], row['node']
        declaration = f'fwp_owner_ctx{context} {variable} = '
        release = f'static void fwp_owner_release{context}(void *arg) '
        original = (f'/* original resource frame */ fwp_cleanup_pop(&{node}); '
                    f'fwp_owner_release{context}(&{variable});')
        assert source.count(declaration) == 1, ('context declaration', context)
        assert source.count(release) == 1, ('release definition', context)
        assert original in source, ('not an original resource frame', context)
    return {
        'frames': len(rows),
        'fields': sum(len(row['fields']) for row in rows),
        'plainFields': sum(not field['observable'] for row in rows for field in row['fields']),
        'variants': sum(row['variants'] for row in rows),
    }


def observe_holds(source, rows, extra_pair):
    """Attribute executed holds in an already count-instrumented service build.

    Release counters include child decrements when a held aggregate dies. They
    must not be interpreted as a count of matching parent-only releases.
    """
    assert type(extra_pair) is bool
    validate_contexts(source, rows)
    assert 'observed_retains++' in source and 'observed_decrements++' in source
    assert 'observed_plainHolds' not in source
    selected = []
    for row in rows:
        for field in row['fields']:
            if field['observable']:
                continue
            context, variable, slot = row['context'], row['variable'], field['slot']
            release_pattern = re.compile(
                rf'(static void fwp_owner_release{context}\(void \*arg\) \{{)([^\n]+)(\}}\n)')
            releases = list(release_pattern.finditer(source))
            assert len(releases) == 1, ('missing release body', context)
            release = releases[0]
            calls = re.findall(rf'\b([a-zA-Z_][a-zA-Z_0-9]*)\(c->v{slot}\);', release[2])
            assert len(calls) == 1, ('missing typed field drop', context, slot)
            drop = calls[0]

            def counted_drop(value):
                return ('{ uint64_t plain_before = observed_decrements; observed_plainDrops++; '
                        f'{drop}({value}); '
                        'observed_plainDecrements += observed_decrements - plain_before; }')

            updated = replace_once(release[2], f'{drop}(c->v{slot});', counted_drop(f'c->v{slot}'))
            source = source[:release.start()] + release[1] + updated + release[3] + source[release.end():]
            declaration = f'fwp_owner_ctx{context} {variable} = '
            position = source.index(declaration)
            start = source.rfind('\nstatic ', 0, position) + 1
            end = source.index('\n}\n', position) + 3
            body = source[start:end]
            assert re.match(r'static [^\n]+\{\n', body), ('missing containing worker', context)
            target = rf'{variable}\.v{slot}'
            holds = re.compile(rf'fwp_rc_dup\((?P<value>[^\n;]+)\); '
                               rf'(?P<old>{drop}\({target}\); )?{target} = (?P=value);')

            def count_hold(match):
                value = match['value']
                result = ('{ uint64_t plain_before = observed_retains; observed_plainHolds++; '
                          f'fwp_rc_dup({value}); '
                          'observed_plainRetains += observed_retains - plain_before; } ')
                if match['old']:
                    result += counted_drop(f'{variable}.v{slot}') + ' '
                result += f'{variable}.v{slot} = {value};'
                if extra_pair:
                    result += (f' {{ uint8_t *plain_slot = fwp_rc_slot({value}); '
                               'if (!observed_extraPair && plain_slot && *plain_slot && *plain_slot < 200) { '
                               'uint64_t plain_before = observed_retains; observed_extraPair = 1; '
                               f'observed_plainHolds++; fwp_rc_dup({value}); '
                               'observed_plainRetains += observed_retains - plain_before; '
                               + counted_drop(value) + ' } }')
                return result

            body, sites = holds.subn(count_hold, body)
            assert sites > 0, ('missing field initialization', context, slot)
            source = source[:start] + body + source[end:]
            selected.append(dict(context=context, slot=slot, holdSites=sites, drop=drop))
    assert selected, 'no eligible original-frame fields'
    globals_ = ('\nstatic uint64_t ' + ', '.join('observed_' + key for key in HOLD_COUNTERS)
                + ';\nstatic int observed_extraPair;')
    source = replace_once(source, 'typedef uint64_t V;', 'typedef uint64_t V;' + globals_)
    prefix, bridge = source.split('ServiceStats service_run(size_t population, int mode) {')
    reset = '    ' + ' = '.join('observed_' + key for key in HOLD_COUNTERS) + ' = 0;\n    observed_extraPair = 0;\n'
    bridge = replace_once(bridge, '    size_t baseline = fwp_heap.live;',
                          reset + '    size_t baseline = fwp_heap.live;')
    fields = ','.join(f'\\"{key}\\":%llu' for key in HOLD_COUNTERS)
    values = ', '.join('(unsigned long long)observed_' + key for key in HOLD_COUNTERS)
    report = f'    fprintf(stderr, "FWP_PLAIN_HOLDS {{{fields}}}\\n", {values});\n'
    bridge = replace_once(bridge, '    return result;', report + '    return result;')
    return prefix + 'ServiceStats service_run(size_t population, int mode) {' + bridge, selected
