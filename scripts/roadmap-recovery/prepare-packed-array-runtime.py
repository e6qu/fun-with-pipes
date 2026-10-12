"""Prepare packed helpers and descriptor-directed typed array operations."""
from pathlib import Path
import re
BASE=Path('/private/tmp/fwp-numeric-representation-phase2-candidate-source/runtime');OUT=Path('/private/tmp/fwp-packed-array-runtime-draft');OUT.mkdir(exist_ok=True)
s=(BASE/'fwp_rt.c').read_text().replace('#include <stdint.h>','#include <stdint.h>\n#include <stddef.h>')
helper=Path('/private/tmp/fwp-packed-array-helpers-draft.c').read_text();anchor='static int fwp_is_signed_kind';at=s.index(anchor);s=s[:at]+helper+'\n'+s[at:];(OUT/'fwp_rt.c').write_text(s)
s=(BASE/'fwp_rt_prims.c').read_text();s=s.replace('static size_t fwp_count_arg(V n) { return (int64_t)n < 0 ? 0 : (size_t)(int64_t)n; }', 'static size_t fwp_count_arg(V n) { uint64_t count = (int64_t)n < 0 ? 0 : n; return count > SIZE_MAX ? SIZE_MAX : (size_t)count; }');a=s.index('/* Typed array boundaries:');b=s.index('/* ------------------------------------------------------------ maps, sets */',a);part=s[a:b]
# Every typed boundary carries the same monomorphic element descriptor.
part=part.replace('static V fwp_array_typed_new(size_t n)', 'static V fwp_array_typed_new(size_t n, const fwp_desc *elem)').replace('return fwp_rc_fresh(fwp_arr_new(n));','return fwp_rc_fresh(fwp_array_new_packed(n, elem));')
part=part.replace('void (*dup)(V)) {','void (*dup)(V), const fwp_desc *elem) {').replace('void (*drop_array)(V)) {','void (*drop_array)(V), const fwp_desc *elem) {').replace('static V fwp_p_array_generate_typed(V n, V f)', 'static V fwp_p_array_generate_typed(V n, V f, const fwp_desc *elem)').replace('static V fwp_p_array_map_typed(V f, V a)', 'static V fwp_p_array_map_typed(V f, V a, const fwp_desc *elem, const fwp_desc *input)').replace('static V fwp_p_array_fold_typed(V f, V z, V a)', 'static V fwp_p_array_fold_typed(V f, V z, V a, const fwp_desc *elem)')
part=part.replace('fwp_array_typed_new(n + extra)','fwp_array_typed_new(n + extra, elem)').replace('fwp_array_typed_new(fwp_list_len(xs))','fwp_array_typed_new(fwp_list_len(xs), elem)').replace('fwp_array_typed_new(count)','fwp_array_typed_new(count, elem)').replace('fwp_array_typed_new(n + m)','fwp_array_typed_new(n + m, elem)')
part=part.replace('fwp_array_typed_copy(a, 0, unique ? NULL : dup)','fwp_array_typed_copy(a, 0, unique ? NULL : dup, elem)').replace('fwp_array_typed_copy(a, capacity - n, unique ? NULL : dup)','fwp_array_typed_copy(a, capacity - n, unique ? NULL : dup, elem)').replace('fwp_array_typed_copy(a, 0, dup)','fwp_array_typed_copy(a, 0, dup, elem)')
part=part.replace('ARR(a)->len','fwp_array_len(a)').replace('ARR(b)->len','fwp_array_len(b)').replace('ARR(result)->len = n + 1;','fwp_array_set_len(result, n + 1);').replace('fwp_array_len(a) = 0;','fwp_array_set_len(a, 0);').replace('fwp_array_len(a) = n + 1;','fwp_array_set_len(a, n + 1);').replace('ARR(result)->len','fwp_array_len(result)')
part=part.replace('int unique = fwp_rc_unique_mut(a);','int unique = fwp_array_is_view(a) ? 0 : fwp_rc_unique_mut(a);')
part=part.replace('fwp_rc_capacity(a)', 'fwp_array_capacity(a, elem)')
part=part.replace('sizeof(fwp_arr) + (n + 1) * sizeof(V)','sizeof(fwp_arr) + (n + 1) * fwp_array_stride(elem)')
# Stores are explicit byte-width writes, never incompatible V lvalues.
part=re.sub(r'ARR\((result|a)\)->d\[([^\]]+)\] = ([^;]+);',lambda m:'fwp_array_store('+m[1]+', '+m[2]+', '+m[3]+', elem);',part)
part=re.sub(r'ARR\((a|b|result)\)->d\[([^\]]+)\]',lambda m:'fwp_array_load('+m[1]+', '+m[2]+', elem)',part)
# Map's source element can differ from its output element.
start=part.index('static V fwp_p_array_map_typed');end=part.index('static V fwp_p_array_fold_typed',start)
part=part[:start]+part[start:end].replace('fwp_array_load(a, i, elem)','fwp_array_load(a, i, input)')+part[end:]
# Sort uses the existing three word scratch buffers and writes back naturally.
part=part.replace('memcpy(keys, ARR(result)->d, n * sizeof(V));\n        fwp_msort(keys, ARR(result)->d, n, elem, tk, tv);','for (size_t i = 0; i < n; i++) keys[i] = fwp_array_load(result, i, elem);\n        fwp_msort(keys, keys, n, elem, tk, tv);\n        for (size_t i = 0; i < n; i++) fwp_array_store(result, i, keys[i], elem);')
# Numeric slices retain the original owning backing allocation, flattening views.
old='    V result = fwp_array_typed_new(count, elem);\n    for (size_t i = 0; i < count; i++) {\n        V value = fwp_array_load(a, first + i, elem);'
new='''#if FWP_PACKED_ARRAYS
    if (fwp_array_should_view(a, count, elem)) {
        V owner = fwp_array_owner(a);
        const unsigned char *data = fwp_array_data(a) + first * fwp_array_stride(elem);
        fwp_array_view *view = (fwp_array_view *)fwp_alloc_init(sizeof *view);
        view->len = FWP_ARRAY_VIEW_FLAG | count; view->owner = owner; view->data = data;
        fwp_rc_dup(owner);
        V result = fwp_rc_fresh(PTR(view));
        FWP_KEEP_ALIVE(a); return result;
    }
#endif
    V result = fwp_array_typed_new(count, elem);
    for (size_t i = 0; i < count; i++) {
        V value = fwp_array_load(a, first + i, elem);'''
assert old in part;part=part.replace(old,new)
assert not re.search(r'ARR\([^)]*\)->d',part), 'Unconverted typed array access'
s=s[:a]+part+s[b:];(OUT/'fwp_rt_prims.c').write_text(s);Path('/private/tmp/fwp-packed-array-typed-core-draft.c').write_text(s)
s=(BASE/'fwp_rt_gc.c').read_text().replace('ARR(v)->len = 0;', 'memset((void *)(uintptr_t)v, 0, sizeof(uint64_t));');s += r'''
/* Numeric arrays may use pointer-free leaf slots. Keep generic reuse's
 * scanned-slot restriction so record constructors cannot acquire leaf storage. */
static inline size_t fwp_array_capacity(V v, const fwp_desc *elem) {
    if (fwp_array_is_view(v)) return 0;
    size_t capacity = fwp_rc_capacity(v);
    if (capacity || !fwp_array_numeric(elem)) return capacity;
#if FWP_GC
    uintptr_t off = (uintptr_t)v - (uintptr_t)fwp_gc.base;
    if (off >= fwp_gc.top << GC_SHIFT) return 0;
    gc_chunk *m = &fwp_gc.meta[off >> GC_SHIFT];
    if (m->type == GC_SMALL && m->leaf == 1 && (off & (GC_CHUNK - 1)) % m->slot == 0) return m->slot;
#else
    (void)v;
#endif
    return 0;
}
'''
(OUT/'fwp_rt_gc.c').write_text(s)
print('Prepared packed array helpers and typed boundaries; integration and runner checks pending')
