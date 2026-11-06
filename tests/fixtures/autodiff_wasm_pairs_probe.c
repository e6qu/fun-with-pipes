/* Exercise actual wasm32 byte calculations without allocating a giant buffer. */
static void *wasm_pair_realloc(void *old,size_t bytes) {
    if (old || bytes!=UINT32_C(2147483640)) exit(222);
    puts("wasm32 operation record allocation fits PTRDIFF_MAX");
    return NULL;
}
int main(void) {
    if (sizeof(size_t)!=4 || sizeof(fwp_tape_op)!=24 || fwp_tape_limit()!=268435455) return 221;
    fwp_tape_scope scope={-1}; fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup,fwp_tape_scope_release,&scope);
    V base=fwp_p_ad_tape(0);
    fwp_tape_reserve(fwp_tape_of((int64_t)base>>32),PTRDIFF_MAX/sizeof(fwp_tape_op));
    return 223;
}
