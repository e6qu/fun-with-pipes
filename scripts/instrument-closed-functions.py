#!/usr/bin/env python3
"""Count executed partial applications capturing only named, capture-free functions.

This instruments already allocation-counted native C for a runner experiment.
It changes no language definitions and makes no timing or code-size claim.
"""
import argparse
import json
import re
from pathlib import Path

p = argparse.ArgumentParser(description=__doc__)
p.add_argument('--input', type=Path, required=True)
p.add_argument('--output', type=Path, required=True)
p.add_argument('--sites', type=Path, required=True)
a = p.parse_args()
code = a.input.read_text()
table_start = code.index('static const fwp_fninfo fwp_fn_table[] = {')
table_end = code.index('\n};', table_start)
functions = re.findall(r'^\s*\{(\d+), [^,]+, "((?:\\.|[^"\\])*)", [^}]+\},$',
                       code[table_start:table_end], re.M)
assert functions and 'static int client_active;' in code
pattern = re.compile(r'fwp_apply_owned\(PTR\(&fc(\d+)\), (\d+), \(V\[\]\)\{(PTR\(&fc\d+\)(?:,\s*PTR\(&fc\d+\))*)\}\)')
sites = []
def instrument(match):
    function, n = int(match[1]), int(match[2])
    captures = [int(i) for i in re.findall(r'fc(\d+)', match[3])]
    assert len(captures) == n and function < len(functions)
    if not 0 < n < int(functions[function][0]):
        return match[0]
    if any(int(functions[i][0]) == 0 for i in captures):
        return match[0]
    site = len(sites)
    sites.append({'site':site, 'input_line':code.count('\n',0,match.start())+1,
                  'function':function, 'name':functions[function][1], 'arity':int(functions[function][0]),
                  'captures':[{'function':i,'name':functions[i][1]} for i in captures],
                  'expression':match[0]})
    return f'(client_active ? (closed_function_counts[{site}]++, 0) : 0, {match[0]})'
measured = pattern.sub(instrument, code)
assert sites, 'no eligible function-only partial applications found'
declaration = 'typedef uint64_t V;'
assert measured.count(declaration)==1
measured = measured.replace(declaration, declaration + f'\nstatic uint64_t closed_function_counts[{len(sites)}];')
finish = '''
static void closed_function_profile_finish(void) {
    const char *path = getenv("FWP_CLOSED_PROFILE");
    if (!path || !*path) { fprintf(stderr,"missing FWP_CLOSED_PROFILE\\n"); exit(2); }
    FILE *out = fopen(path, "w");
    if (!out) { perror("closed function profile"); exit(2); }
    fputs("site\\tcalls\\trequested_payload_bytes\\n",out);
'''
for site in sites:
    i, n = site['site'], len(site['captures'])
    finish += f'    fprintf(out,"{i}\\t%llu\\t%zu\\n",(unsigned long long)closed_function_counts[{i}],sizeof(fwp_clo)+{n}*sizeof(V));\n'
finish += '    if(fclose(out)) { perror("closed function profile"); exit(2); }\n}\n'
marker = 'static void client_measure_end(void) {'
assert measured.count(marker)==1
measured = measured.replace(marker, finish + '\n' + marker)
marker = '    client_active = 0;'
assert measured.count(marker)==1
measured = measured.replace(marker, marker + '\n    closed_function_profile_finish();')
a.output.write_text(measured)
a.sites.write_text(json.dumps({'input':a.input.name,'sites':sites,
    'scope':'Executed underapplications whose supplied values are literal capture-free function references. Other partial applications are excluded. Counts cover the same interval as managed-allocation counters; no timings are inferred.'},indent=2)+'\n')
print(f'{len(sites)} eligible source sites instrumented; runtime counts remain to be measured')
