"""Build an observable native boundary for the returned-callable comparison.

The ordinary variant only exposes existing invocation/destruction entries and
replaces the generated entry call. Counters belong to a separate diagnostic
variant; neither its code size nor its execution time describes production.
"""
import importlib.util
from pathlib import Path
import re


ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location(
    "ownership_profile", ROOT / "scripts/ownership-profile.py")
OWNERSHIP = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(OWNERSHIP)


def replace_once(code, old, new):
    if code.count(old) != 1:
        raise ValueError(f"changed callable boundary: {old!r}")
    return code.replace(old, new)


def boundary(code):
    identities = []
    for name in ("escaped-partial", "escaped-captured"):
        entries = re.findall(r'\{(\d+), e(\d+), "' + name
                             + r'", &fwp_owned_info(\d+)\}', code)
        if len(entries) != 1 or entries[0][0] not in ("1", "2") or entries[0][1] != entries[0][2]:
            raise ValueError(f"missing callable construction stage: {name}")
        identities.append((int(entries[0][0]), entries[0][1]))
    if len({identity for _, identity in identities}) != 2:
        raise ValueError("the two operations must have distinct typed entries")
    for signature in ("static V fwp_apply_borrowed(", "static void fwp_closure_drop("):
        code = replace_once(code, signature, signature.removeprefix("static "))
    thread = "static void *fwp_main_thread(void *arg) {"
    code = replace_once(code, thread,
                        "static size_t callable_baseline;\n"
                        "int returned_observe(int, char **);\n" + thread)
    code = replace_once(code,
                        "    fwp_exit_code = fwp_exec(&exec_spec0, fwp_argc, fwp_argv);",
                        "    callable_baseline = fwp_heap.live;\n"
                        "    fwp_exit_code = returned_observe(fwp_argc, fwp_argv);")
    extra = (ROOT / "tests/fixtures/returned_callable_fwp_boundary.c").read_text()
    for marker, (arity, identity) in zip(("PARTIAL", "CAPTURED"), identities, strict=True):
        if arity == 2:
            construct = f"fwp_rc_fresh(fwp_pap({identity}, 1, (V[]){{(V)capture}}))"
            direct = f"f{identity}((V)capture, (V)input)"
        else:
            construct = f"f{identity}((V)capture)"
            direct = f"fwp_apply_owned({construct}, 1, (V[]){{(V)input}})"
        extra = extra.replace(marker + "_MAKE", construct)
        extra = extra.replace(marker + "_DIRECT", direct)
    return code + "\n" + extra


def profile(code):
    declarations = (ROOT / "tests/fixtures/returned_callable_profile.c").read_text()
    code = replace_once(code, "typedef uint64_t V;", "typedef uint64_t V;\n" + declarations)
    # Observe successful allocations at their actual returns. Forwarding paths
    # are untouched, so slow-path allocation is counted exactly once.
    for signature, returns in (
        ("static __attribute__((noinline)) void *fwp_heap_alloc_big(size_t n, int leaf) {", 1),
        ("static __attribute__((noinline)) void *fwp_heap_alloc_slow(size_t n, int kind) {", 1),
        ("static inline void *fwp_heap_alloc(size_t n, int kind) {", 2),
        ("static inline void *fwp_alloc_init(size_t n) {", 1),
    ):
        if code.count(signature) != 1:
            raise ValueError(f"changed allocator: {signature}")
        start = code.index(signature)
        end = OWNERSHIP.function_end(code, start + len(signature) - 1)
        body = code[start:end]
        if body.count("return p;") != returns:
            raise ValueError(f"changed allocation return: {signature}")
        body = body.replace("return p;", "callable_allocated(p, n); return p;")
        code = code[:start] + body + code[end:]
    for marker, insertion in (
        ("static void fwp_mem_free(void *p) {\n    size_t ci;", "callable_freed(p);"),
        ("static V fwp_apply(V f, uint32_t n, V *args) {", "if(callable_active) callable_counts.applications++;"),
        ("static V fwp_apply_owned(V f, uint32_t n, V *args) {", "if(callable_active) callable_counts.applications++;"),
        ("static V fwp_apply_borrowed_span(V f, uint32_t n, V *args, uint32_t owned_start, uint32_t owned_len) {", "if(callable_active) callable_counts.applications++;"),
        ("static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {", "if(callable_active) callable_counts.retains++;"),
        ("static inline int fwp_rc_release_last(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (!c || !*c) return 0;", "if(callable_active) callable_counts.releases++;"),
        ("if (c && *c > 1) fwp_rc_drop_slot(c);", ""),
    ):
        if insertion:
            code = replace_once(code, marker, marker + "\n    " + insertion)
        else:
            code = replace_once(code, marker,
                                "if (c && *c > 1) { if(callable_active) callable_counts.releases++; fwp_rc_drop_slot(c); }")
    code += "\n" + (ROOT / "tests/fixtures/returned_callable_phases.c").read_text()
    return code
