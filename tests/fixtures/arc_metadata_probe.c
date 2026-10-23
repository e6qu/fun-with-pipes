/* A native allocator probe, called before generated task/constant setup.
 * Each child process selects its case explicitly; no language API is added. */
static void arc_metadata_probe(void) {
    const char *kind = getenv("FWP_METADATA_CASE");
    if (!kind) exit(51);
    intptr_t before = fwp_gc.budget;
    int reuse = 0;
    if (!strcmp(kind, "plain")) {
        size_t sizes[] = {16, 257, GC_MAX_SMALL, GC_MAX_SMALL + 16};
        for (size_t i = 0; i < sizeof sizes / sizeof *sizes; ++i) {
            V value = fwp_rc_fresh(PTR(fwp_alloc_leaf(sizes[i])));
            for (unsigned j = 0; j < 300; ++j) fwp_rc_dup(value);
            if (fwp_rc_unique(value) || !fwp_gc.rc_wide_len) exit(52);
            for (unsigned j = 0; j < 300; ++j)
                if (fwp_rc_release_last(value)) exit(53);
            if (fwp_rc_unique(value) != 1 || !fwp_rc_young(value) || fwp_gc.rc_wide_len) exit(54);
            fwp_rc_free_obj(value);
        }
        if (fwp_gc.budget != before) exit(55);
    } else {
#ifdef _WIN32
        if (_putenv_s("FWP_REUSE_VERIFY", "1")) exit(56);
#else
        if (setenv("FWP_REUSE_VERIFY", "1", 1)) exit(56);
#endif
        if (!strcmp(kind, "late-object")) {
            V value = fwp_rc_fresh(PTR(fwp_alloc_leaf(64)));
            reuse = fwp_rc_unique(value);
            fwp_rc_free_obj(value);
        } else if (!strcmp(kind, "late-array")) {
            V value = fwp_rc_fresh(PTR(fwp_alloc(128)));
            reuse = fwp_rc_unique_mut(value);
            fwp_rc_free_arr(value);
        } else if (!strcmp(kind, "late-file")) {
            const char *path = getenv("FWP_METADATA_FILE");
            if (!path) exit(57);
            FILE *stream = fopen(path, "w+b");
            if (!stream) exit(58);
            fwp_file *file = fwp_alloc_leaf(sizeof *file + 1);
            file->f = stream;
            file->refs = 1;
            file->path[0] = 0;
            V value = fwp_rc_fresh(PTR(file));
            fwp_file_dup(value);
            fwp_file_drop(value);
            if (file->refs != 1) exit(59);
            fwp_file_drop(value);
        } else if (!strcmp(kind, "late-socket")) {
            fwp_socket_t descriptor = fwp_socket_open(AF_INET, SOCK_STREAM, 0);
            if (descriptor == FWP_INVALID_SOCKET) exit(60);
            V value = fwp_sock_new(descriptor, 1);
            fwp_sock_dup(value);
            fwp_sock_drop(value);
            if (SOCK(value)->refs != 1) exit(61);
            fwp_sock_drop(value);
            fwp_sockets_finish();
        } else {
            exit(62);
        }
    }
    size_t marks = 0;
#ifndef FWP_ARC_ONLY
    marks = sizeof(((gc_chunk *)0)->bits);
#endif
    if (fwp_gc.ncollect || fwp_gc.rc_wide_len) exit(63);
    printf("%zu %zu %zu %zu %lld %d\n", GC_CHUNK, sizeof(gc_chunk), marks,
           sizeof(((gc_chunk *)0)->rc), (long long)(before - fwp_gc.budget), reuse);
    exit(0);
}
