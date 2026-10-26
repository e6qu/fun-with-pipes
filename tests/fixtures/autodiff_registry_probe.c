/* Always move the registry: scope links and tokens must use stable slot indices. */
static size_t registry_bytes, registry_requests;
static void *registry_realloc(void *old, size_t bytes) {
    if (bytes > 0xffff * sizeof(fwp_tape)) abort();
    void *next = malloc(bytes);
    if (!next) abort();
    memset(next, 0xa5, bytes);
    if (old) memcpy(next, old, registry_bytes);
    free(old);
    registry_bytes = bytes;
    registry_requests++;
    return next;
}
static void registry_free(void *p) { free(p); registry_bytes = 0; }
static size_t registry_adj_requests;
static void *registry_calloc(size_t n, size_t bytes) {
    registry_adj_requests++;
    return calloc(n, bytes);
}
static int registry_recover(void) { return 1; }
static jmp_buf registry_trap;
int main(void) {
    fwp_heap_start();
#ifdef FWP_ARC_ONLY
    if (fwp_heap.armed) return 200;
#else
    if (!fwp_heap.enabled || !fwp_heap.stress || !fwp_heap.verify) return 201;
#endif
    fwp_tape_scope scope = {-1};
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_tape_scope_release, &scope);
    V empty = fwp_rc_fresh(fwp_arr_new(0));
    V base = fwp_p_ad_tape(0);
    V result = fwp_rc_fresh(fwp_p_ad_backward(base, empty, empty));
    if (ARR(result)->len || registry_adj_requests) return 202;
    if (fwp_tape_next_slot != 0) return 206;
    fwp_rc_free_arr(result);
    /* Create the empty tape before another tape fills the shared cache. */
    base = fwp_p_ad_tape(0);
    V warm = fwp_p_ad_tape(1);
    V outputs = fwp_rc_fresh(fwp_arr_new(1)), seeds = fwp_rc_fresh(fwp_arr_new(1));
    ARR(outputs)->d[0] = warm; ARR(seeds)->d[0] = fwp_from_f64(1.0);
    result = fwp_rc_fresh(fwp_p_ad_backward(warm, outputs, seeds));
    if (ARR(result)->len != 1 || fwp_f64(ARR(result)->d[0]) != 1.0) return 203;
    fwp_rc_free_arr(result);
    double *cached = fwp_tape_workspace.adj;
    size_t cached_bytes = fwp_tape_cached_bytes, adj_requests = registry_adj_requests;
    result = fwp_rc_fresh(fwp_p_ad_backward(base, empty, empty));
    if (ARR(result)->len || registry_adj_requests != adj_requests ||
        fwp_tape_workspace.adj != cached || fwp_tape_cached_bytes != cached_bytes) return 204;
    fwp_rc_free_arr(result); fwp_rc_free_arr(empty); fwp_rc_free_arr(outputs); fwp_rc_free_arr(seeds);
    /* Managed backward releases its slot before any user scalar callback. */
    static const fwp_desc element = {.kind=K_I64};
    static const fwp_desc list_type = {.elem=&element};
    V parameters = fwp_rc_fresh(fwp_record(4, (V[4]){0,0,0,0}));
    base = fwp_p_ad_tape_owned(parameters, 0, &element);
    if (fwp_p_ad_backward_owned(base, 0, 0, &list_type) || fwp_tape_next_slot != 0) return 207;
    fwp_rc_free_obj(parameters);
    fwp_cleanup_pop(&cleanup); fwp_tape_scope_release(&scope);
    fwp_tape_finish();
    if (fwp_ntapes || fwp_tapes_cap || fwp_tapes || registry_bytes || fwp_tape_next_slot) return 196;
    registry_requests = 0;
    registry_scans = 0;
    scope.head = -1;
    fwp_cleanup_push(&cleanup, fwp_tape_scope_release, &scope);
    for (int i = 0; i < 257; i++) {
        int64_t base = (int64_t)fwp_p_ad_tape(0), id = base >> 32;
        if ((id & 0xffff) != i + 1 || (id >> 16) != 1) return 190;
        fwp_tape *t = fwp_tape_of(id);
        if (t->pa || t->pb || t->da || t->db || t->adj || t->cap || t->adjcap || t->owned) return 191;
        if (fwp_ntapes != i + 1 || fwp_tapes_cap < fwp_ntapes || fwp_tapes_cap >= 2 * fwp_ntapes) return 192;
    }
    if (registry_requests != 10 || fwp_tapes_cap != 512) return 193;
    if (registry_scans) return 205;
    /* Release holes out of order: selection must still choose the lowest. */
    fwp_tape_unlink_scope(&fwp_tapes[200]);
    fwp_tape_retire(&fwp_tapes[200]);
    fwp_tape_unlink_scope(&fwp_tapes[4]);
    fwp_tape_retire(&fwp_tapes[4]);
    int64_t reused = (int64_t)fwp_p_ad_tape(0) >> 32;
    if ((reused & 0xffff) != 5 || (reused >> 16) != 2 || registry_requests != 10) return 194;
    reused = (int64_t)fwp_p_ad_tape(0) >> 32;
    if ((reused & 0xffff) != 201 || (reused >> 16) != 2) return 194;
    if (registry_scans != 195) return 205;
    fwp_cleanup_pop(&cleanup);
    fwp_tape_scope_release(&scope);
    for (int i = 0; i < 257; i++) if (fwp_tapes[i].live || fwp_tapes[i].scope) return 195;
    fwp_tape_finish();
    if (fwp_ntapes || fwp_tapes_cap || fwp_tapes || registry_bytes || fwp_tape_next_slot) return 196;

    /* Exercise the real doubling clamp and token exhaustion with a small
     * bounded registry, without quadratic creation of 65,535 live tapes. */
    fwp_tapes = registry_realloc(NULL, 32768 * sizeof(fwp_tape));
    fwp_ntapes = fwp_tapes_cap = 32768;
    memset(fwp_tapes, 0, registry_bytes);
    for (int i = 0; i < 32768; i++) fwp_tapes[i].gen = 32767;
    scope.head = -1;
    fwp_cleanup_push(&cleanup, fwp_tape_scope_release, &scope);
    int64_t last = (int64_t)fwp_p_ad_tape(0) >> 32;
    if ((last & 0xffff) != 32769 || fwp_tapes_cap != 0xffff || fwp_ntapes != 32769) return 197;
    memset(fwp_tapes + fwp_ntapes, 0, (size_t)(fwp_tapes_cap - fwp_ntapes) * sizeof(fwp_tape));
    for (int64_t i = fwp_ntapes; i < fwp_tapes_cap; i++) fwp_tapes[i].gen = 32767;
    fwp_ntapes = fwp_tapes_cap;
    size_t requests = registry_requests;
    fwp_trap_recover = registry_recover; fwp_trap_jb = &registry_trap; fwp_trap_cleanup = fwp_cleanups;
    if (!setjmp(registry_trap)) { fwp_p_ad_tape(0); return 198; }
    if (strcmp(fwp_trap_msg, "autodiff: too many grad computations at once") || registry_requests != requests) return 199;
    fwp_trap_recover = 0; fwp_trap_jb = 0; fwp_trap_cleanup = 0;
    fwp_cleanup_pop(&cleanup); fwp_tape_scope_release(&scope);
    fwp_tape_finish();
    if (registry_bytes || fwp_tapes_cap || fwp_ntapes || fwp_tapes || fwp_tape_next_slot) return 196;
    puts("bounded registry growth preserves tokens, relocation and scope release");
    return 0;
}
