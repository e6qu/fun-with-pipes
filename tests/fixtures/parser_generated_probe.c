/* Insert declarations after V, preserving platform setup and system headers. */
static uintptr_t parser_starts[256], parser_ends[256];
static size_t parser_blocks, parser_allocations, parser_failure, parser_nodes;
static void parser_link_operation(V value) {
    for (size_t i = 0; i < parser_blocks; i++)
        if (value >= parser_starts[i] && value < parser_ends[i]) exit(251);
}
static void parser_add_block(void *data, size_t capacity) {
    if (parser_blocks == 256) exit(250);
    parser_starts[parser_blocks] = (uintptr_t)data;
    parser_ends[parser_blocks++] = (uintptr_t)data + capacity;
}
static void parser_remove_block(void *data) {
    for (size_t i = 0; i < parser_blocks; i++) {
        if (parser_starts[i] == (uintptr_t)data) {
            parser_blocks--;
            parser_starts[i] = parser_starts[parser_blocks];
            parser_ends[i] = parser_ends[parser_blocks];
            return;
        }
    }
    exit(250);
}
/* GENERATED-PARSER-MAIN */
static int parser_case_inner(const char *text, int64_t expected, int parse_error,
                       size_t failure, size_t *allocations) {
    V input = fwp_rc_fresh(fwp_cstr(text));
    fwp_rc_dup(input); /* The caller deliberately keeps an independent alias. */
    fwp_handler handler = {0};
    handler.prev = fwp_handlers; handler.state_depth = fwp_state_len;
    handler.cleanup = fwp_cleanups; fwp_handlers = &handler;
    parser_allocations = parser_nodes = 0; parser_failure = failure;
    if (!setjmp(handler.jb)) {
        V result = @entry@(input);
        if (failure || parse_error || (int64_t)result != expected) return 244;
        if (!parser_nodes || !parser_allocations) return 245;
    } else {
        if (!failure && !parse_error) return 246;
        if (failure && parser_allocations != failure) return 246;
        if (handler.desc && handler.desc->drop) handler.desc->drop(handler.value);
    }
    fwp_handlers = handler.prev;
    if (fwp_cleanups != handler.cleanup || parser_blocks) return 247;
    if (!fwp_rc_slot(input) || *fwp_rc_slot(input) != 1 || strcmp(STR(input)->d, text)) return 249;
    if (!fwp_rc_release_last(input)) return 249;
    fwp_rc_free_obj(input);
    *allocations = parser_allocations;
    return 0;
}
/* Check after the handler frame returns: WASI return-state storage belongs
 * to that frame and is released on function exit, independently of the tree. */
static int parser_case(const char *text, int64_t expected, int parse_error,
                       size_t failure, size_t *allocations) {
    size_t baseline = @storage@;
    @save_counts@
    int status = parser_case_inner(text, expected, parse_error, failure, allocations);
    if (status) return status;
    if (@storage@ != baseline) return 248;
    @check_counts@
    return 0;
}
static size_t parser_leaves, parser_length;
static int64_t parser_expected;
static char parser_text[65536];
static void parser_input(unsigned depth) {
    if (depth == 1) {
        int value = (int)(parser_leaves++ % 17) - 8;
        parser_expected += value;
        parser_length += (size_t)snprintf(parser_text + parser_length,
            sizeof parser_text - parser_length, "%d ", value);
    } else {
        parser_text[parser_length++] = '+'; parser_text[parser_length++] = ' ';
        parser_input(depth - 1); parser_input(depth - 1);
    }
}
int main(void) {
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    fwp_budget = INT32_MAX;
    const unsigned depths[] = {@depths@};
    for (size_t shape = 0; shape < sizeof depths / sizeof depths[0]; shape++) {
        parser_leaves = parser_length = 0; parser_expected = 0;
        parser_input(depths[shape]);
        parser_text[parser_length] = 0;
        size_t allocations = 0;
        for (size_t repeat = 0; repeat < 16; repeat++) {
            int status = parser_case(parser_text, parser_expected, 0, 0, &allocations);
            if (status) return status;
        }
        size_t observed = allocations;
        for (size_t fail = 1; fail <= observed; fail++) {
            int status = parser_case(parser_text, 0, 0, fail, &allocations);
            if (status) return status;
        }
    }
    const char *errors[] = {"+ 1", "+ 1 invalid", "1 2"};
    for (size_t error = 0; error < sizeof errors / sizeof errors[0]; error++) {
        size_t allocations = 0;
        int status = parser_case(errors[error], 0, 1, 0, &allocations);
        if (status) return status;
    }
    return 0;
}
