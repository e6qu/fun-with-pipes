"""Attribute original lifetime frames and their concrete callable values in saved C.

These observers are deliberately separate from ordinary timing builds. Typed
destruction can release children; decrement counts are inclusive, not a promise
that every counted decrement can be removed.
"""
import json
import re

from resource_field_census import validate_contexts
from weak_callback_service import replace_once, unique_fields

PREFIX = 'FWP_RESOURCE_WORK '
FIELD_COUNTS = ('holds', 'retains', 'drops', 'decrements')
FRAME_COUNTS = ('pushes', 'pops', 'releases')


def instrument(source, rows, extra_pair=False):
    validate_contexts(source, rows)
    assert 'observed_retains++' in source and 'observed_decrements++' in source
    assert 'resource_work_' not in source
    fields = []
    frames = []
    functions = [int(n) for n in re.findall(r'\{\d+, e(\d+), "', source)]
    assert functions
    function_count = max(functions) + 1
    for index, row in enumerate(rows):
        context, variable, node = (row[key] for key in ('context', 'variable', 'node'))
        declaration = f'fwp_owner_ctx{context} {variable} = '
        position = source.index(declaration)
        start = source.rfind('\nstatic ', 0, position) + 1
        end = source.index('\n}\n', position) + 3
        body = source[start:end]
        assert re.match(r'static [^\n]+\{\n', body)
        push = f'fwp_cleanup_push(&{node}, fwp_owner_release{context}, &{variable});'
        pop = f'fwp_cleanup_pop(&{node});'
        assert body.count(push) == body.count(pop) == 2
        frames.append(dict(context=context, function=row['function'], variants=row['variants']))
        body = body.replace(push, f'resource_work_frames[{index}][0]++; ' + push)
        body = body.replace(pop, f'resource_work_frames[{index}][1]++; ' + pop)
        source = source[:start] + body + source[end:]
        release_marker = f'static void fwp_owner_release{context}(void *arg) {{'
        source = replace_once(source, release_marker,
                              release_marker + f' resource_work_frames[{index}][2]++;')
        for field in row['fields']:
            slot = field['slot']
            field_index = len(fields)
            release_pattern = re.compile(re.escape(release_marker) + r'([^\n]+)\}\n')
            release, = release_pattern.finditer(source)
            drop, = re.findall(rf'\b([a-zA-Z_][a-zA-Z_0-9]*)\(c->v{slot}\);', release[1])
            counter = f'resource_work_fields[{field_index}]'

            def counted_drop(value):
                return (f'{{ uint64_t work_before = observed_decrements; {counter}[2]++; '
                        f'{drop}({value}); {counter}[3] += observed_decrements - work_before; }}')

            updated = replace_once(release[0], f'{drop}(c->v{slot});', counted_drop(f'c->v{slot}'))
            source = source[:release.start()] + updated + source[release.end():]
            position = source.index(declaration)
            start = source.rfind('\nstatic ', 0, position) + 1
            end = source.index('\n}\n', position) + 3
            body = source[start:end]
            target = rf'{variable}\.v{slot}'
            holds = re.compile(rf'(?P<dup>fwp_(?:rc|file|sock)_dup)\((?P<value>[^\n;]+)\); '
                               rf'(?P<old>{drop}\({target}\); )?{target} = (?P=value);')
            callable_ = field['type'].startswith('Fun(')

            def count_hold(match):
                value, dup = match['value'], match['dup']
                result = (f'{{ uint64_t work_before = observed_retains; {counter}[0]++; '
                          f'{dup}({value}); {counter}[1] += observed_retains - work_before; }} ')
                if callable_:
                    result += (f'{{ V work_value = {value}; if (work_value) {{ '
                               f'if (CLO(work_value)->fn >= {function_count}) abort(); '
                               'resource_work_closures[CLO(work_value)->fn][0]++; '
                               'resource_work_closures[CLO(work_value)->fn][1] += CLO(work_value)->n; '
                               'if (!CLO(work_value)->n) resource_work_closures[CLO(work_value)->fn][2]++; } } ')
                if match['old']:
                    result += counted_drop(f'{variable}.v{slot}') + ' '
                result += f'{variable}.v{slot} = {value};'
                # One real counted extra owner, immediately released, in a
                # plain field. No synthetic addition to the reported totals.
                if extra_pair and not field['observable']:
                    assert dup == 'fwp_rc_dup'
                    result += (f' {{ uint8_t *work_slot = fwp_rc_slot({value}); '
                               'if (!resource_work_extra && work_slot && *work_slot && *work_slot < 200) { '
                               f'resource_work_extra = 1; uint64_t work_before = observed_retains; {counter}[0]++; '
                               f'{dup}({value}); {counter}[1] += observed_retains - work_before; '
                               + counted_drop(value) + ' } }')
                return result

            body, sites = holds.subn(count_hold, body)
            assert sites > 0, ('missing initialization', context, slot)
            source = source[:start] + body + source[end:]
            fields.append(dict(context=context, slot=slot, sites=sites, drop=drop,
                               observable=field['observable'], callable=callable_, type=field['type']))
    declarations = (f'\nstatic uint64_t resource_work_frames[{len(frames)}][3];\n'
                    f'static uint64_t resource_work_fields[{len(fields)}][4];\n'
                    f'static uint64_t resource_work_closures[{function_count}][3];\n'
                    'static int resource_work_extra;\n')
    source = replace_once(source, 'typedef uint64_t V;', 'typedef uint64_t V;' + declarations)
    helper = r'''
static void resource_work_report(void) {
    fprintf(stderr, "FWP_RESOURCE_WORK {\"frames\":[");
    for (size_t i = 0; i < sizeof resource_work_frames / sizeof *resource_work_frames; i++) {
        uint64_t *r = resource_work_frames[i];
        fprintf(stderr, "%s[%llu,%llu,%llu]", i ? "," : "", (unsigned long long)r[0], (unsigned long long)r[1], (unsigned long long)r[2]);
    }
    fprintf(stderr, "],\"fields\":[");
    for (size_t i = 0; i < sizeof resource_work_fields / sizeof *resource_work_fields; i++) {
        uint64_t *r = resource_work_fields[i];
        fprintf(stderr, "%s[%llu,%llu,%llu,%llu]", i ? "," : "", (unsigned long long)r[0], (unsigned long long)r[1], (unsigned long long)r[2], (unsigned long long)r[3]);
    }
    fprintf(stderr, "],\"closures\":[");
    int comma = 0;
    for (size_t i = 0; i < sizeof resource_work_closures / sizeof *resource_work_closures; i++) {
        uint64_t *r = resource_work_closures[i];
        if (r[0]) { fprintf(stderr, "%s[%zu,%llu,%llu,%llu]", comma ? "," : "", i, (unsigned long long)r[0], (unsigned long long)r[1], (unsigned long long)r[2]); comma = 1; }
    }
    fprintf(stderr, "]}\n");
}
'''
    source = replace_once(source, 'static void *fwp_main_thread(void *arg) {',
                          helper + '\nstatic void *fwp_main_thread(void *arg) {')
    return source, dict(frames=frames, fields=fields, functionCount=function_count)


def decode(line, selected):
    assert line.startswith(PREFIX)
    result = json.loads(line[len(PREFIX):], object_pairs_hook=unique_fields)
    assert set(result) == {'frames', 'fields', 'closures'}
    for name, width in (('frames', 3), ('fields', 4), ('closures', 4)):
        assert type(result[name]) is list
        if name != 'closures':
            assert len(result[name]) == len(selected[name])
        for row in result[name]:
            assert type(row) is list and len(row) == width
            assert all(type(value) is int and value >= 0 for value in row)
    assert len({row[0] for row in result['closures']}) == len(result['closures'])
    assert all(row[0] < selected['functionCount'] and row[1] > 0 and row[3] <= row[1]
               for row in result['closures'])
    assert all(retains <= holds for holds, retains, _, _ in result['fields'])
    return result
