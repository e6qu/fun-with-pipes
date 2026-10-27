"""Attribute native ownership operations to generated-C call sites.

This changes only diagnostic C, never the shipped runtime. Counts describe the
instrumented execution; use the separately compiled ordinary binary for size or
timing claims. Function-pointer calls keep their ABI and have explicit sites.
"""

from bisect import bisect_right
import re


OPERATIONS = ('fresh', 'dup', 'drop', 'release_last', 'unique', 'unique_mut',
              'last', 'free_obj', 'free_arr')


def mask_c(code):
    """Preserve offsets/newlines while excluding comments and quoted text."""
    return re.sub(r'/\*[\s\S]*?\*/|//[^\n]*|"(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\'',
                  lambda match: re.sub(r'[^\n]', ' ', match[0]), code)


def function_end(code, opening):
    masked = mask_c(code)
    depth = 1
    for position in range(opening + 1, len(code)):
        depth += (masked[position] == '{') - (masked[position] == '}')
        if depth == 0:
            return position + 1
    raise ValueError('unterminated C function')


def instrument(code):
    """Extend measure-iteration's native profile; return C and site metadata."""
    assert code.count('static int iteration_active;') == 1
    masked = mask_c(code)
    lines = code.splitlines()
    starts = [0] + [match.end() for match in re.finditer('\n', code)]
    sites, edits, definitions = [], [], {}

    def site(operation, offset, indirect):
        number = len(sites)
        line = bisect_right(starts, offset)
        sites.append(dict(id=number, operation=operation, line=line,
                          indirect=indirect, source=lines[line - 1].strip()))
        return number

    # The inactive WASI definitions have `value`, native definitions have `v`.
    # Leave inactive definitions alone; neither WASI nor arbitrary C is an
    # accepted input for this native-only measurement.
    for operation in OPERATIONS:
        name = 'fwp_rc_' + operation
        definition = re.compile(r'static (?:inline )?(void|int|V) ' + name + r'\(V v\) \{')
        matches = list(definition.finditer(masked))
        assert len(matches) == 1, (operation, len(matches))
        definition_match, = matches
        opening = definition_match.end() - 1
        end = function_end(code, opening)
        signature = code[definition_match.start():opening]
        renamed = signature.replace(name + '(V v)', name + '_profile(size_t profile_site, V v)')
        body = code[opening:end]
        body = body.replace('{', '{\n    ownership_hit(profile_site, 0);', 1)
        if operation == 'fresh':
            body = body.replace('if (c) {', 'if (c) {\n        ownership_hit(profile_site, 1);', 1)
        elif operation == 'dup':
            body = body.replace('if (c && *c) {', 'if (c && *c) {\n        ownership_hit(profile_site, 1);', 1)
        elif operation == 'drop':
            old = 'if (c && *c > 1) fwp_rc_drop_slot(c);'
            assert body.count(old) == 1
            body = body.replace(old, 'if (c && *c > 1) { ownership_hit(profile_site, 1); fwp_rc_drop_slot(c); }')
        elif operation == 'release_last':
            old = 'if (*c == 1) return 1;'
            assert body.count(old) == 1
            body = body.replace(old, 'ownership_hit(profile_site, 1);\n    if (*c == 1) { ownership_hit(profile_site, 2); return 1; }')
        elif operation in ('unique', 'unique_mut'):
            assert body.count('return 1;') == 1
            body = body.replace('return 1;', 'ownership_hit(profile_site, 1); return 1;')
        elif operation == 'last':
            old = 'return c && *c == 1;'
            assert body.count(old) == 1
            body = body.replace(old, 'int result = c && *c == 1;\n    if (result) ownership_hit(profile_site, 1);\n    return result;')
        else:
            old = 'if (fwp_rc_last(v)) fwp_mem_free((void *)(uintptr_t)v);'
            assert body.count(old) == 1
            body = body.replace(old, 'if (fwp_rc_last(v)) { ownership_hit(profile_site, 1); fwp_mem_free((void *)(uintptr_t)v); }')
        definitions[operation] = (len(edits), definition_match[1])
        edits.append((definition_match.start(), end, renamed + body))

    # Preserve each function-pointer construction's identity as well as its ABI.
    # A single per-operation indirect bucket would merge map keys, sort keys and
    # copied list elements, losing the ownership attribution this report needs.
    for match in re.finditer(r'\bfwp_rc_(' + '|'.join(OPERATIONS) + r')\b(?!\s*\()', masked):
        operation = match[1]
        number = site(operation, match.start(), True)
        index, result_type = definitions[operation]
        helper = f'ownership_indirect_{number}'
        returns = 'return ' if result_type != 'void' else ''
        wrapper = (f'\nstatic {result_type} {helper}(V value) {{ '
                   f'{returns}fwp_rc_{operation}_profile({number}, value); }}')
        start, end, text = edits[index]
        edits[index] = (start, end, text + wrapper)
        edits.append((match.start(), match.end(), helper))

    # Rewrite direct calls, including calls between the profiled helpers. Apply
    # them inside replacement bodies as well, using sites in the original input.
    calls = []
    for match in re.finditer(r'\bfwp_rc_(' + '|'.join(OPERATIONS) + r')\(', masked):
        if re.match(r'V (?:v|value)\)', masked[match.end():]):
            continue
        number = site(match[1], match.start(), False)
        calls.append((match.start(), match.end(), match[0][:-1] + f'_profile({number}, '))
    for start, end, replacement in reversed(calls):
        enclosing = [i for i, (a, b, _) in enumerate(edits) if a <= start < b]
        if enclosing:
            index, = enclosing
            a, b, text = edits[index]
            original = code[start:end]
            # These helper bodies contain at most one call to each other helper.
            assert text.count(original) == 1, (original, text)
            edits[index] = (a, b, text.replace(original, replacement, 1))
        else:
            edits.append((start, end, replacement))
    for start, end, replacement in sorted(edits, reverse=True):
        code = code[:start] + replacement + code[end:]
    declaration = f'''static uint64_t ownership_counts[{len(sites)}][3];
static void ownership_hit(size_t site, size_t field) {{
    if (iteration_active) ownership_counts[site][field]++;
}}
'''
    code = code.replace('static int iteration_active;', 'static int iteration_active;\n' + declaration, 1)
    marker = '    iteration_active=0;'
    assert code.count(marker) == 1
    code = code.replace(marker, marker + f'''
    for (size_t site=0; site<{len(sites)}; site++) {{
        if (ownership_counts[site][0])
            fprintf(stderr, "ownership-site\\t%zu\\t%llu\\t%llu\\t%llu\\n", site,
                (unsigned long long)ownership_counts[site][0],
                (unsigned long long)ownership_counts[site][1],
                (unsigned long long)ownership_counts[site][2]);
    }}
''', 1)
    return code, sites
