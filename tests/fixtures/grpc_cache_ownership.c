/* Exercise cache ownership without network timing. Aliases may retain any of
 * the position, optional-result or tuple wrappers. No collection is needed. */
static void drop_text_position(V value) { g_cell_drop(value, fwp_rc_free_obj); }
static void drop_text_pair(V value) {
    if (!fwp_rc_release_last(value)) return;
    V next = OBJ(value)->f[1];
    fwp_rc_free_obj(OBJ(value)->f[0]);
    fwp_rc_free_obj(value);
    drop_text_position(next);
}
static void drop_text_result(V value) {
    if (!fwp_rc_release_last(value)) return;
    V pair = OBJ(value)->f[0];
    fwp_rc_free_obj(value);
    drop_text_pair(pair);
}
static void check_text_pair(V pair) {
    for (;;) {
        V text = OBJ(pair)->f[0];
        if (STR(text)->len != 5 || memcmp(STR(text)->d, "value", 5)) _Exit(173);
        g_cell *next = (g_cell *)(uintptr_t)OBJ(pair)->f[1];
        if (!next->forced) {
            if (!next->src || strcmp(next->src->what, "owned")) _Exit(174);
            return;
        }
        if (next->memo == FWP_NONE) _Exit(174);
        pair = OBJ(next->memo)->f[0];
    }
}
static jmp_buf cache_failed;
static int recover_cache_failure(void) { return 1; }
static int check_terminal_read(int failure, int shared) {
    fwp_tasks_init();
    size_t initial_live = fwp_heap.live;
    g_server server = {0}; server.module = "cache-owners";
    g_conn *connection = g_conn_new(FWP_INVALID_SOCKET, "", "queued", &server);
    fwp_rc_fresh(PTR(connection)); fwp_rc_dup(PTR(connection)); /* fixture and source */
    g_stream *stream = g_stream_new(connection, 1);
    fwp_rc_fresh(PTR(stream)); fwp_rc_dup(PTR(stream)); fwp_rc_dup(PTR(stream)); /* list, source, fixture */
    stream->remote_end = 1;
    if (failure) stream->bad = strdup("deliberate receive failure");
    g_incoming *source = g_incoming_new("owned", 5);
    source->c = connection; source->s = stream;
    V cell = PTR(g_cell_new(source));
    if (shared) fwp_rc_dup(cell);
    cache_releases = 0; cache_observe = 1;
    cache_stack_low = UINTPTR_MAX; cache_stack_high = 0;
    fwp_trap_recover = recover_cache_failure; fwp_trap_jb = &cache_failed;
    fwp_trap_cleanup = fwp_cleanups;
    volatile int trapped = 0;
    if (!setjmp(cache_failed)) {
        if (fwp_p_grpc_force(cell, drop_text_position) != FWP_NONE) return 177;
    } else trapped = 1;
    fwp_trap_recover = 0; fwp_trap_jb = 0; fwp_trap_cleanup = 0;
    if (trapped != failure || fwp_cleanups) return 178;
    if (shared) {
        g_cell *kept = (g_cell *)(uintptr_t)cell;
        if (failure) {
            if (kept->forced || kept->src != source || source->reader || source->read_waiters.head) return 179;
            if (cache_releases) return 180;
        } else if (!kept->forced || kept->memo != FWP_NONE || cache_releases != 1) return 181;
        drop_text_position(cell);
    }
    cache_observe = 0;
    if (cache_releases != 2) return 182;
    g_unlink(connection, stream); g_stream_drop(stream); g_conn_drop(connection);
    if (fwp_heap.live != initial_live) return 183;
    return 0;
}
int main(int argc, char **argv) {
    if (argc != 3) return 170;
    int count = atoi(argv[1]), mode = atoi(argv[2]);
    if (count < 1 || count > 16384 || mode < 0 || mode > 10) return 170;
    fwp_lib_init(); fwp_heap_start();
    size_t initial_live = fwp_heap.live;
    if (mode >= 7) {
        int status = check_terminal_read((mode-7)%2, (mode-7)/2);
        fwp_lib_finish(); return status;
    }
    g_server server = {0}; server.module = "cache-owners";
    g_conn *connection = g_conn_new(FWP_INVALID_SOCKET, "", "queued", &server);
    fwp_rc_fresh(PTR(connection)); fwp_rc_dup(PTR(connection)); /* fixture and source */
    g_stream *stream = g_stream_new(connection, 1);
    fwp_rc_fresh(PTR(stream)); fwp_rc_dup(PTR(stream)); fwp_rc_dup(PTR(stream)); /* list, source, fixture */
    double before = (double)fwp_heap.live;
    g_incoming *source = g_incoming_new("owned", 5);
    source->c = connection; source->s = stream;
    V root = PTR(g_cell_new(source)), alias = 0;
    for (int i = 0; i < count; i++) {
        V text = fwp_rc_fresh(fwp_cstr("value"));
        V pair = fwp_rc_fresh(fwp_tuple2(text, root));
        V result = fwp_rc_fresh(fwp_some(pair));
        g_cell *cell = g_cell_new(0);
        cell->forced = 1; cell->memo = result;
        root = PTR(cell);
        if (i == count/2 && mode >= 2 && mode <= 4) {
            alias = mode == 2 ? root : mode == 3 ? result : pair;
            fwp_rc_dup(alias);
        }
    }
    cache_releases = 0; cache_observe = 1;
    cache_stack_low = UINTPTR_MAX; cache_stack_high = 0;
    if (mode == 1) { alias = root; fwp_rc_dup(alias); }
    if (mode == 5 || mode == 6) {
        if (mode == 5) fwp_rc_dup(root);
        V result = fwp_p_grpc_force(root, drop_text_position);
        if (mode == 5) drop_text_position(root);
        check_text_pair(OBJ(result)->f[0]);
        drop_text_result(result);
    } else {
        drop_text_position(root);
        if (alias) {
            V result = mode <= 2 ? ((g_cell *)(uintptr_t)alias)->memo : alias;
            V pair = mode == 4 ? result : OBJ(result)->f[0];
            check_text_pair(pair);
            if (mode <= 2) drop_text_position(alias);
            else if (mode == 3) drop_text_result(alias);
            else drop_text_pair(alias);
        }
    }
    cache_observe = 0;
    if (cache_releases != (size_t)(4*count+2) || fwp_cleanups) return 171;
    double after = (double)fwp_heap.live;
    if (after != before) return 172;
    g_unlink(connection, stream); g_stream_drop(stream); g_conn_drop(connection);
    if (fwp_heap.live != initial_live) return 183;
    printf("%d\t%d\t%zu\t%llu\n", count, mode, cache_releases,
        (unsigned long long)(cache_stack_high-cache_stack_low));
    fwp_lib_finish();
    return 0;
}
