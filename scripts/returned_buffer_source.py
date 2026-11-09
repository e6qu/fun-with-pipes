"""Expose existing owned fwp entries to a separate buffer caller.

This changes executable dispatch, not the generated array operations. Ordinary
runtime setup/teardown remain. Diagnostic cleanup checks are separately selected.
"""
import re


def replace_once(code, before, after):
    if code.count(before) != 1:
        raise ValueError(f"changed returned-buffer boundary: {before!r}")
    return code.replace(before, after)


def boundary(code):
    identities = {}
    for name in ('make', 'scan', 'release'):
        entries = re.findall(r'\{1, e(\d+), "buffer-' + name
                             + r'", &fwp_owned_info(\d+)\}', code)
        if len(entries) != 1 or entries[0][0] != entries[0][1]:
            raise ValueError(f"missing unary owned buffer entry: {name}")
        identities[name] = entries[0][0]
        if f'static V fwp_owned_entry{entries[0][0]}(V *a) {{' not in code:
            raise ValueError(f"missing owned buffer definition: {name}")
    marker = 'static void *fwp_main_thread(void *arg) {'
    code = replace_once(code, marker,
        '#if BUFFER_DIAGNOSTIC == 1\nstatic size_t buffer_baseline;\n#endif\n'
        'int returned_buffer_observe(int, char **);\n' + marker)
    code = replace_once(code,
        '    fwp_exit_code = fwp_exec(&exec_spec0, fwp_argc, fwp_argv);',
        '#if BUFFER_DIAGNOSTIC == 1\n    buffer_baseline = fwp_heap.live;\n#endif\n'
        '    fwp_exit_code = returned_buffer_observe(fwp_argc, fwp_argv);')
    return code + f'''
#include "returned_buffer_peer.h"
ReturnedBuffer returned_buffer_make(int64_t length) {{
    V input = (V)length;
    return fwp_owned_entry{identities['make']}(&input);
}}
int64_t returned_buffer_scan(ReturnedBuffer value) {{
    /* The caller keeps an owner. The exported unary entry consumes another. */
    fwp_rc_dup(value);
    return (int64_t)fwp_owned_entry{identities['scan']}(&value);
}}
void returned_buffer_release(ReturnedBuffer value) {{
    (void)fwp_owned_entry{identities['release']}(&value);
}}
#if BUFFER_SHARED == 1
ReturnedBuffer returned_buffer_alias(ReturnedBuffer value) {{
    fwp_rc_dup(value);
    return value;
}}
#endif
#if BUFFER_DIAGNOSTIC == 1
int returned_buffer_clean(void) {{
    return fwp_heap.live == buffer_baseline && !fwp_cleanups &&
        !fwp_state_len && !fwp_state_owners;
}}
#endif
'''
