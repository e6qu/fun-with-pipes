/* Runtime helpers for LLVM's WebAssembly setjmp/longjmp lowering
 * (-mllvm -wasm-enable-sjlj), compiled separately from the program.
 * __wasm_longjmp itself is in longjmp.S. */

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct { uintptr_t id; uint32_t label; } fwp_sj_entry;
static uint32_t fwp_temp_ret0;
static uintptr_t fwp_setjmp_id;
uint32_t getTempRet0(void) { return fwp_temp_ret0; }
fwp_sj_entry *saveSetjmp(uintptr_t *env, uint32_t label, fwp_sj_entry *table, uint32_t size) {
    for (uint32_t i = 0; i < size; i++) {
        if (table[i].id == 0) {
            if (fwp_setjmp_id == UINTPTR_MAX) {
                fputs("fwp: WebAssembly return-state identifiers exhausted\n", stderr);
                abort();
            }
            *env = ++fwp_setjmp_id;
            table[i].id = fwp_setjmp_id;
            table[i].label = label;
            table[i + 1].id = 0;
            fwp_temp_ret0 = size;
            return table;
        }
    }
    if (!size || size > UINT32_MAX / 2 ||
        (size_t)size > (SIZE_MAX / sizeof(fwp_sj_entry) - 1) / 2) {
        fputs("fwp: WebAssembly return-state table too large\n", stderr);
        abort();
    }
    size *= 2;
    fwp_sj_entry *grown = realloc(table, sizeof(fwp_sj_entry) * ((size_t)size + 1));
    if (!grown) {
        fputs("fwp: cannot grow WebAssembly return-state table\n", stderr);
        abort();
    }
    return saveSetjmp(env, label, grown, size);
}
uint32_t testSetjmp(uintptr_t id, fwp_sj_entry *table, uint32_t size) {
    for (uint32_t i = 0; i < size; i++) {
        if (table[i].id == 0) break;
        if (table[i].id == id) return table[i].label;
    }
    return 0;
}
static struct { void *env; int val; } fwp_lj_args;
void *fwp_lj_prepare(void *env, int val) {
    fwp_lj_args.env = env;
    fwp_lj_args.val = val ? val : 1;
    return &fwp_lj_args;
}
