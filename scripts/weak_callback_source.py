"""Expose the verified unary service entry to the same separate C timing caller."""
import re

from weak_callback_service import expected, replace_once


def boundary(source):
    entries = re.findall(r'\{1, e(\d+), "service", &fwp_owned_info(\d+)\}', source)
    if len(entries) != 1 or entries[0][0] != entries[0][1]:
        raise ValueError('missing unary owning service entry')
    entry = entries[0][0]
    if f'static V fwp_owned_entry{entry}(V *a) {{' not in source:
        raise ValueError('missing owning service definition')
    # Derive offsets from the emitted descriptor; never assume record field order.
    fields = set(expected(64, 0))
    descriptors = []
    for identifier, text in re.findall(r'static const char \*const d(\d+)_n\[\] = \{([^}]+)\};', source):
        names = re.findall(r'"([a-z_]+)"', text)
        if len(names) == len(fields) and set(names) == fields:
            descriptors.append((identifier, names))
    if len(descriptors) != 1:
        raise ValueError('missing or ambiguous service result descriptor')
    descriptor, names = descriptors[0]
    if not re.search(r'static const fwp_desc d' + descriptor + r' = \{K_RECORD, "ServiceResult", 10, d'
                     + descriptor + r'_n, d' + descriptor + r'_f, \.width = 0, \.order = d'
                     + descriptor + r'_o, \.dup = fwp_rc_dup, \.drop = fwp_drop\d+\};', source):
        raise ValueError('service result is not an ordinary record')
    types = re.findall(r'static const fwp_desc \*const d' + descriptor + r'_f\[\] = \{([^}]+)\};', source)
    if len(types) != 1:
        raise ValueError('missing service field types')
    types = re.findall(r'&d(\d+)', types[0])
    if len(types) != 10 or len(set(types)) != 1:
        raise ValueError('service result is not ten uniform integers')
    if not re.search(r'static const fwp_desc d' + types[0]
                     + r' = \{K_I64, "I64", \.width = 0, \.dup = NULL, \.drop = NULL\};', source):
        raise ValueError('service result contains non-I64 fields')
    source = replace_once(source, 'static void *fwp_main_thread(void *arg) {',
                          'int service_observe(int, char **);\nstatic void *fwp_main_thread(void *arg) {')
    source = replace_once(source, '    fwp_exit_code = fwp_exec(&exec_spec0, fwp_argc, fwp_argv);',
                          '    fwp_tasks_init();\n    fwp_exit_code = service_observe(fwp_argc, fwp_argv);')
    assignments = ', '.join('(int64_t)OBJ(output)->f[' + str(names.index(name)) + ']'
                            for name in ('calls', 'cancelled', 'expired', 'errors', 'sent', 'received', 'sum', 'received_sum'))
    return source + f'''
#include "weak_callback_service.h"
ServiceStats service_run(size_t population, int mode) {{
#if SERVICE_DIAGNOSTIC == 1
    size_t baseline = fwp_heap.live;
#endif
    V argument = fwp_rc_fresh(fwp_tuple2((V)population, (V)mode));
    V output = fwp_owned_entry{entry}(&argument);
    if (output < 4096 || OBJ(output)->tag != 0 || OBJ(output)->n != 10 ||
        OBJ(output)->f[{names.index('population')}] != population || OBJ(output)->f[{names.index('mode')}] != (V)mode) {{
        fputs("incorrect service result shape\\n", stderr); exit(4);
    }}
    ServiceStats result = {{{assignments}}};
    /* All fields are verified immediate I64 values; only the record owns storage. */
    fwp_rc_free_obj(output);
#if SERVICE_DIAGNOSTIC == 1
    if (fwp_heap.live != baseline) {{ fputs("service storage not released\\n", stderr); exit(79); }}
#endif
    return result;
}}
'''
