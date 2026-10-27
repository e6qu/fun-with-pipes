/* A native allocator probe, called before generated task/constant setup.
 * Each child process selects its case explicitly; no language API is added. */
static void arc_metadata_probe(void) {
    const char *kind = getenv("FWP_METADATA_CASE");
    if (!kind) exit(51);
    size_t before = fwp_heap.live;
    int reuse = 0;
    if (!strcmp(kind, "plain")) {
        size_t sizes[] = {16, 257, HEAP_MAX_SMALL, HEAP_MAX_SMALL + 16};
        for (size_t i = 0; i < sizeof sizes / sizeof *sizes; ++i) {
            V value = fwp_rc_fresh(PTR(fwp_alloc_leaf(sizes[i])));
            for (unsigned j = 0; j < 300; ++j) fwp_rc_dup(value);
            if (fwp_rc_unique(value) || !fwp_heap.rc_wide_len) exit(52);
            for (unsigned j = 0; j < 300; ++j)
                if (fwp_rc_release_last(value)) exit(53);
            if (fwp_rc_unique(value) != 1 || fwp_heap.rc_wide_len) exit(54);
            fwp_rc_free_obj(value);
        }
        if (fwp_heap.live != before) exit(55);
    } else {
        if (!strcmp(kind, "object")) {
            V value = fwp_rc_fresh(PTR(fwp_alloc_leaf(64)));
            reuse = fwp_rc_unique(value);
            fwp_rc_free_obj(value);
        } else if (!strcmp(kind, "array")) {
            V value = fwp_rc_fresh(PTR(fwp_alloc(128)));
            reuse = fwp_rc_unique_mut(value);
            fwp_rc_free_arr(value);
        } else if (!strcmp(kind, "file")) {
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
        } else if (!strcmp(kind, "socket")) {
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
    if (fwp_heap.rc_wide_len || fwp_heap.live != before) exit(63);
    printf("%zu %zu %zu %zu %d\n", HEAP_CHUNK, sizeof(heap_chunk),
           sizeof(((heap_chunk *)0)->rc), fwp_heap.live - before, reuse);
    exit(0);
}
