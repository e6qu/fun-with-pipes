/* Runtime helpers for LLVM's WebAssembly setjmp/longjmp lowering
 * (-mllvm -wasm-enable-sjlj), compiled separately from the program.
 * __wasm_longjmp itself is in longjmp.S. */

#include <stdint.h>
#include <stdlib.h>

typedef struct { uintptr_t id; uint32_t label; } fwp_sj_entry;
static uint32_t fwp_temp_ret0;
static uintptr_t fwp_setjmp_id;
uint32_t getTempRet0(void) { return fwp_temp_ret0; }
fwp_sj_entry *saveSetjmp(uintptr_t *env, uint32_t label, fwp_sj_entry *table, uint32_t size) {
    for (uint32_t i = 0; i < size; i++) {
        if (table[i].id == 0) {
            *env = ++fwp_setjmp_id;
            table[i].id = fwp_setjmp_id;
            table[i].label = label;
            table[i + 1].id = 0;
            fwp_temp_ret0 = size;
            return table;
        }
    }
    size *= 2;
    table = (fwp_sj_entry *)realloc(table, sizeof(fwp_sj_entry) * (size + 1));
    return saveSetjmp(env, label, table, size);
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
