"""Expose current owned weak-operation entries to a separate native caller."""
import re


def once(source, before, after):
    if source.count(before) != 1:
        raise ValueError('changed weak-operation boundary: ' + before)
    return source.replace(before, after)


def boundary(source):
    entries = {}
    for name in ('make', 'downgrade', 'lookup', 'release-owner', 'release-weak'):
        matches = re.findall(r'\{1, e(\d+), "reference-' + name + r'", &fwp_owned_info(\d+)\}', source)
        if len(matches) != 1 or matches[0][0] != matches[0][1]:
            raise ValueError('missing unary owned reference entry: ' + name)
        entries[name] = matches[0][0]
        if f'static V fwp_owned_entry{entries[name]}(V *a) {{' not in source:
            raise ValueError('missing owned reference definition: ' + name)
    source = once(source, 'static void *fwp_main_thread(void *arg) {',
                  '#if REFERENCE_DIAGNOSTIC == 1\nstatic size_t reference_baseline;\n#endif\n'
                  'int reference_observe(int, char **);\nstatic void *fwp_main_thread(void *arg) {')
    source = once(source, '    fwp_exit_code = fwp_exec(&exec_spec0, fwp_argc, fwp_argv);',
                  '    fwp_tasks_init();\n'
                  '#if REFERENCE_DIAGNOSTIC == 1\n    reference_baseline = fwp_heap.live;\n#endif\n'
                  '    fwp_exit_code = reference_observe(fwp_argc, fwp_argv);')
    return source + f'''
#include "weak_operation_peer.h"
#if REFERENCE_DIAGNOSTIC == 1
int reference_clean(void) {{
    return fwp_heap.live == reference_baseline && !fwp_cleanups && !fwp_state_len && !fwp_state_owners;
}}
#endif
ReferenceOwner reference_make(int64_t input) {{
    V argument = (V)input;
    return fwp_owned_entry{entries['make']}(&argument);
}}
ReferenceWeak reference_downgrade(ReferenceOwner owner) {{
    /* The exported unary entry consumes an owner; the caller keeps its own. */
    fwp_rc_dup(owner);
    return fwp_owned_entry{entries['downgrade']}(&owner);
}}
int reference_lookup(ReferenceWeak weak) {{
    fwp_rc_dup(weak);
    return fwp_owned_entry{entries['lookup']}(&weak) == FWP_TRUE;
}}
void reference_release_owner(ReferenceOwner owner) {{
    (void)fwp_owned_entry{entries['release-owner']}(&owner);
}}
void reference_release_weak(ReferenceWeak weak) {{
    (void)fwp_owned_entry{entries['release-weak']}(&weak);
}}
'''
