/* Called by both a statically linked host and a dynamically loading host. */
static jmp_buf arc_failure;
static int arc_recover(void) { return 1; }

static int arc_library_call(void) {
    char text[] = "abcd";
    if (pointer_id(text) != text || optional_pointer(text) != text || optional_pointer(NULL)) return 206;
    struct fwp_c_PointerText pointers = pointer_text((struct fwp_c_PointerText){text, text});
    if (pointers.pointer != text || strcmp(pointers.text, "abcd")) return 207;
    text[0] = 'Z';
    if (strcmp(pointers.text, "abcd") || ((char *)pointers.pointer)[0] != 'Z') return 208;
    fwp_release_pointer_text(pointers);
    text[0] = 'a';
    void *manual = allocate_text(text);
    const char *copied = copy_pointer(manual);
    release_text(manual);
    if (strcmp(copied, "abcd")) return 209;
    fwp_release_copy_pointer(copied);
    struct fwp_c_Summary result = summarize((struct fwp_c_Input){7, text});
    if (result.count != 4 || result.value != 7.0) return 181;
    if (text_length("h\xc3\xa9llo") != 5 || slope(3.0) != 6.0 || pipeline(10) != 55)
        return 182;
    unsigned long long before = fwp_library_test_retains, boxes = fwp_library_test_boxes;
    const char *held = keep_text(text);
    if (fwp_library_test_retains != before) return 202;
    struct fwp_c_Words words = twin(text);
    if (fwp_library_test_retains - before != 1) return 202;
    if (fwp_library_test_boxes != boxes) return 205;
    if (*fwp_rc_slot(PTR(held) - offsetof(fwp_str, d)) != 1) return 200;
    if (words.left != words.right || *fwp_rc_slot(PTR(words.left) - offsetof(fwp_str, d)) != 2) return 201;
    struct fwp_c_Words first = saved(), second = saved();
    fwp_release_saved(first);
    if (strcmp(second.left, "cachecache") || strcmp(second.right, "cachecache")) return 196;
    fwp_release_saved(second);
    text[0] = 'z';
    if (strcmp(held, "abcd") || strcmp(words.left, "abcd") || strcmp(words.right, "abcd") || words.count != 4) return 197;
    fwp_release_keep_text(held); fwp_release_twin(words);
    if (result.count != 4 || result.value != 7.0) return 183;
    return 0;
}

#ifdef _WIN32
__declspec(dllexport)
#endif
int fwp_test_probe(void) {
#ifdef _WIN32
    /* Test output uses the same exact bytes as the interpreter. */
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 188;
#endif
    fwp_lib_init();
    int result = arc_library_call();
    if (result) return result;
    size_t live_bytes = fwp_heap.live;
    double freed = fwp_heap.freed;
    fwp_cleanup *boundary = fwp_cleanups;
    for (int i = 0; i < 256; ++i) {
        result = arc_library_call();
        if (result) return result;
    }
    fwp_trap_recover = arc_recover;
    fwp_trap_jb = &arc_failure;
    fwp_trap_cleanup = boundary;
    if (!setjmp(arc_failure)) { (void)crash("owned before failure"); return 184; }
    if (!setjmp(arc_failure)) { (void)return_nul("owned before NUL"); return 198; }
    if (!setjmp(arc_failure)) { (void)pair_nul("first field must survive conversion failure"); return 199; }
    struct fwp_c_Words sample = saved();
    fwp_library_fail_value = PTR(sample.left) - offsetof(fwp_str, d);
    fwp_release_saved(sample); fwp_library_fail_seen = 0;
    if (!setjmp(arc_failure)) { (void)saved(); return 203; }
    fwp_library_fail_value = 0;
    sample = saved();
    if (strcmp(sample.left, "cachecache") || strcmp(sample.right, "cachecache") ||
        *fwp_rc_slot(PTR(sample.left) - offsetof(fwp_str, d)) != 4) return 204;
    fwp_release_saved(sample);
    fwp_trap_recover = 0;
    fwp_trap_jb = 0;
    fwp_trap_cleanup = 0;
    if (fwp_cleanups != boundary) return 185;
    if (fwp_heap.live > live_bytes || fwp_heap.freed <= freed) return 186;
    fprintf(stderr, "library result retains: keep=0 twin=1; result boxes: keep=0 twin=0\n");
    printf("%lld\n%lld\n%.1f\n%lld\n", (long long)text_length("h\xc3\xa9llo"),
        (long long)summarize((struct fwp_c_Input){7, "abcd"}).count,
        slope(3.0), (long long)pipeline(10));
    const char *held = keep_text("owned"); puts(held); fwp_release_keep_text(held);
    struct fwp_c_Words words = twin("twice"); puts(words.right); fwp_release_twin(words);
    words = shared(); puts(words.left); fwp_release_shared(words);
    return 0;
}

static void fwp_test_finished(void) {
    const char *path = getenv("FWP_ARC_LIBRARY_REPORT");
    if (!path) return;
    FILE *file = fopen(path, "ab");
    if (!file) abort();
    /* Called after typed globals and tapes finish, before the arena is freed. */
    fprintf(file, "%zu\n", fwp_heap.live);
    if (fclose(file)) abort();
}
