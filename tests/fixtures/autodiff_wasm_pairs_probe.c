/* Exercise actual wasm32 size_t arithmetic without allocating giant buffers. */
static int wasm_pair_calls;
static void *wasm_pair_realloc(void *old,size_t bytes) {
    if (old) exit(222);
    wasm_pair_calls++;
    if (wasm_pair_calls==1) {
        if (bytes!=UINT32_C(2147483640)) exit(222);
        /* No metadata is initialized or moved before the second call fails. */
        return malloc(8);
    }
    if (wasm_pair_calls!=2 || bytes!=UINT32_C(4294967280)) exit(222);
    puts("paired wasm32 allocation sizes do not wrap");
    return NULL;
}
int main(void) {
    if (sizeof(size_t)!=4 || fwp_tape_limit()!=268435455) return 221;
    V base=fwp_p_ad_tape(0);
    fwp_tape_reserve(fwp_tape_of((int64_t)base>>32),fwp_tape_limit());
    return 223;
}
