/* Move every native allocation, poison its old address, and retain exact sizes. */
static struct { void *pointer; size_t bytes; } pair_allocations[16];
static size_t pair_calls, pair_moved;
static jmp_buf pair_recovered;
static V pair_parameters, pair_inputs, pair_base;
static int pair_recover(void) { return 1; }
static void *pair_realloc(void *old, size_t bytes) {
    size_t i=0;
    if (old) { while (i<16 && pair_allocations[i].pointer!=old) i++; }
    else { while (i<16 && pair_allocations[i].pointer) i++; }
    if (i==16) abort();
    void *next=malloc(bytes); if (!next) abort();
    memset(next,0xa5,bytes);
    if (old) {
        size_t before=pair_allocations[i].bytes;
        memcpy(next,old,before<bytes?before:bytes);
        memset(old,0xdd,before); free(old);
    }
    pair_allocations[i].pointer=next; pair_allocations[i].bytes=bytes;
    pair_calls++;
    return next;
}
static void pair_free(void *p) {
    if (!p) return;
    size_t i=0; while (i<16 && pair_allocations[i].pointer!=p) i++;
    if (i==16) abort(); /* Interior pointers must never own an allocation. */
    memset(p,0xdd,pair_allocations[i].bytes); free(p);
    memset(&pair_allocations[i],0,sizeof pair_allocations[i]);
}
static void *pair_move(void *to, const void *from, size_t bytes) {
    pair_moved+=bytes;
    return memmove(to,from,bytes);
}
static size_t pair_bytes(void *p) {
    for (size_t i=0;i<16;i++) if (pair_allocations[i].pointer==p) return pair_allocations[i].bytes;
    abort();
}
static V pair_weight(int64_t i, int side) {
    /* Copy payloads and negative zero without performing floating arithmetic. */
    return side ? UINT64_C(0x8000000000000000)+(V)i : UINT64_C(0x7ff8000000000000)+(V)i;
}
static int pair_check(fwp_tape *t) {
    if (t->pb!=t->pa+t->cap || pair_bytes(t->pa)<(size_t)t->cap*8 ||
        (uintptr_t)t->pa%_Alignof(int32_t) || (uintptr_t)t->pb%_Alignof(int32_t)) return 211;
    if (!t->owned && (t->db!=t->da+t->cap || pair_bytes(t->da)!=(size_t)t->cap*16 ||
        (uintptr_t)t->da%_Alignof(double) || (uintptr_t)t->db%_Alignof(double))) return 212;
    for (int64_t i=0;i<t->len-t->leaves;i++) {
        if (t->pa[i]!=(int32_t)i || t->pb[i]!=-(int32_t)i-1) return 211;
        if (!t->owned && (fwp_from_f64(t->da[i])!=pair_weight(i,0) ||
                         fwp_from_f64(t->db[i])!=pair_weight(i,1))) return 212;
    }
    return 0;
}
static int pair_fill(fwp_tape *t, int64_t count) {
    for (int64_t i=t->len-t->leaves;i<count;i++) {
        int64_t old=t->cap;
        size_t calls=pair_calls, moved=pair_moved;
        fwp_tape_reserve(t,i+1);
        if (pair_calls-calls!=(old==t->cap?0:(t->owned?1:2))) return 214;
        int status=pair_check(t); if (status) return status;
        if (pair_moved-moved!=(old==t->cap?0:(size_t)i*(t->owned?4:12))) return 213;
        t->pa[i]=(int32_t)i; t->pb[i]=-(int32_t)i-1;
        if (!t->owned) { t->da[i]=fwp_f64(pair_weight(i,0));t->db[i]=fwp_f64(pair_weight(i,1)); }
        t->len++;
    }
    return pair_check(t);
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    fwp_tape_scope scope={-1};fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup,fwp_tape_scope_release,&scope);
    for (int managed=0;managed<=1;managed++) {
        if (managed) {
            static const fwp_desc element={.kind=K_I64};
            pair_parameters=fwp_record(4,(V[4]){0,0,0,0});
            pair_inputs=fwp_cons(0,0);
            pair_base=fwp_p_ad_tape_owned(pair_parameters,pair_inputs,&element);
        } else pair_base=fwp_p_ad_tape(1);
        fwp_tape *t=fwp_tape_of((int64_t)pair_base>>32);
        int status=pair_fill(t,7);if (status) return status;
        /* Explicit over-reservation moves only initialized metadata. */
        size_t moved=pair_moved;
        fwp_tape_reserve(t,129);
        status=pair_check(t);if (status) return status;
        if (pair_moved-moved!=7*(size_t)(managed?4:12)) return 213;
        if (managed) {
            fwp_trap_recover=pair_recover;fwp_trap_jb=&pair_recovered;
            fwp_trap_cleanup=fwp_cleanups;pair_fail_weights=1;
            if (!setjmp(pair_recovered)) {fwp_tape_reserve(t,257);return 215;}
            if (strcmp(fwp_trap_msg,"paired weight growth control") || t->cap!=256 ||
                t->pb!=t->pa+256 || t->owned->cap!=256 || !t->live) return 216;
            for (int64_t i=0;i<7;i++) if (t->pa[i]!=i || t->pb[i]!=-i-1) return 216;
            pair_fail_weights=0;
        }
        int64_t count=fwp_tape_limit()<1025?fwp_tape_limit():1025;
        status=pair_fill(t,count);if (status) return status;
        fwp_tape_unlink_scope(t);fwp_tape_retire(t);fwp_tape_finish();
        for (size_t i=0;i<16;i++) if (pair_allocations[i].pointer) return 217;
    }
    fwp_cleanup_pop(&cleanup);
    if (fwp_cleanups || fwp_owned_tapes || scope.head!=-1) return 218;
#if !FWP_ARC_ONLY
    if (!fwp_gc.armed || !fwp_gc.ncollect) return 219;
#endif
    puts("paired metadata preserves aligned values across moving growth and traps");
    return 0;
}
