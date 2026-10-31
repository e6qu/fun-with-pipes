/* All count reads below name live values. Released values are observed only
 * through the address ledger, never through their object or count slots. */
static void require_wide(int condition) { if (!condition) _Exit(239); }
static void widen(V value) { for (int i = 0; i < 600; i++) fwp_rc_dup(value); }
static size_t count_wide(V value) {
    uint8_t *slot = fwp_rc_slot(value);
    heap_rc_wide **entry = fwp_rc_wide_link(slot);
    return *entry ? (*entry)->count : *slot;
}
static V wide_entry(V *args) { return args[0]; }
static void wide_args(V *args, uint32_t start, uint32_t n) {
    if (!start && n) fwp_rc_dup(args[0]);
}
static void wide_caps(V f, int duplicate) {
    if (duplicate) fwp_rc_dup(CLO(f)->a[0]);
    else { DROP_LEAF(CLO(f)->a[0]); fwp_rc_free_obj(f); }
}
static void wide_drop_args(V *args, uint32_t start, uint32_t n) {
    if (!start && n) DROP_LEAF(args[0]);
}
static const fwp_owned_fninfo wide_owned = {wide_entry, wide_caps, wide_args, wide_drop_args};
static const fwp_fninfo wide_functions[] = {{1, wide_entry, "wide", &wide_owned}};
int main(int argc, char **argv) {
#ifdef _WIN32
    if (_setmode(_fileno(stderr), _O_BINARY) < 0) return 253;
#endif
    require_wide(argc == 2);
    fwp_heap_start();
    fwp_fns = wide_functions;
    size_t live_bytes = fwp_heap.live;
    if (!strcmp(argv[1], "oom")) wide_fail = 1;
    int rounds = atoi(argv[1]);
    if (rounds == 0) rounds = 1;
    for (int round = 0; round < rounds; round++) {
        V leaf = fwp_rc_fresh(fwp_cstr("wide capture"));
        widen(leaf);
        require_wide(count_wide(leaf) == 601 && wide_live == 1 && fwp_heap.rc_wide_len == 1);
        if (!strcmp(argv[1], "overflow")) {
            (*fwp_rc_wide_link(fwp_rc_slot(leaf)))->count = SIZE_MAX;
            fwp_rc_dup(leaf);
            _Exit(239);
        }
        for (int i = 0; i < 600; i++) DROP_LEAF(leaf);
        require_wide(count_wide(leaf) == 1 && !wide_live && !fwp_heap.rc_wide_len);
        require_wide(STR(leaf)->len == 12 && !memcmp(STR(leaf)->d, "wide capture", 12));
        fwp_clo *closure = fwp_alloc_init(sizeof *closure + sizeof(V));
        closure->fn = 0; closure->n = 1; closure->a[0] = leaf;
        V function = fwp_rc_fresh(PTR(closure));
        widen(function);
        require_wide(count_wide(function) == 601 && wide_live == 1);
        for (int i = 0; i < 600; i++) fwp_closure_drop(function);
        require_wide(count_wide(function) == 1 && count_wide(leaf) == 1 && !wide_live);
        fwp_closure_drop(function);
        require_wide(!owner_ledger_live && fwp_heap.live == live_bytes && !fwp_heap.rc_wide_len);
        /* An interior alias belongs to the same live allocation and count. */
        V record = fwp_rc_fresh(fwp_record(2, (V[]){7, 8}));
        V interior = PTR(&OBJ(record)->f[1]);
        require_wide(fwp_rc_slot(interior) == fwp_rc_slot(record));
        widen(record);
        require_wide(count_wide(interior) == 601 && wide_live == 1);
        for (int i = 0; i < 600; i++) fwp_rc_drop(record);
        require_wide(count_wide(record) == 1 && !wide_live && OBJ(record)->f[1] == 8);
        fwp_rc_free_obj(record);
        require_wide(!owner_ledger_live && fwp_heap.live == live_bytes);
        /* Scratch storage owns its aliases as a group. Its explicit release
         * removes side metadata; an address reused later starts at one. */
        record = fwp_rc_fresh(fwp_record(1, (V[]){0}));
        widen(record);
        uintptr_t released_address = (uintptr_t)record;
        fwp_mem_free(OBJ(record));
        require_wide(!owner_ledger_live && !wide_live && !fwp_heap.rc_wide_len);
        record = fwp_rc_fresh(fwp_record(1, (V[]){9}));
        require_wide((uintptr_t)record == released_address && count_wide(record) == 1);
        require_wide(OBJ(record)->f[0] == 9);
        fwp_rc_free_obj(record);
        require_wide(!owner_ledger_live && fwp_heap.live == live_bytes);
        char bytes[20000] = {0};
        V big = fwp_rc_fresh(fwp_str_new(bytes, sizeof bytes));
        widen(big);
        require_wide(count_wide(big) == 601 && wide_live == 1);
        for (int i = 0; i < 601; i++) DROP_LEAF(big);
        require_wide(!owner_ledger_live && !wide_live && !fwp_heap.rc_wide_len && fwp_heap.live == live_bytes);
    }
    owner_ledger_finish();
    return 0;
}
