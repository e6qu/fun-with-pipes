/* Protocol callbacks have a consuming entry and an independent legacy entry.
 * Fail if decoding chooses the legacy entry or loses an argument/error owner. */
static int decoder_mode;
static jmp_buf decoder_trap;
static int recover_decoder(void) { return 1; }
static void drop_decoder_error(V value) {
    if (!fwp_rc_release_last(value)) return;
    fwp_rc_free_obj(OBJ(value)->f[1]);
    fwp_rc_free_obj(value);
}
static const fwp_desc decoder_error = {.kind=K_RECORD,.drop=drop_decoder_error};
static V decoder_entry(V *args) {
    if (decoder_mode == 0) return args[0];
    fwp_value_owner bytes = {args[0], fwp_rc_free_obj};
    fwp_cleanup cleanup;
    fwp_value_protect(&bytes, &cleanup);
    if (decoder_mode == 2) fwp_trap("decoder trap");
    V result = fwp_rc_fresh(fwp_tuple2(13, args[0]));
    (void)fwp_value_finish(&bytes, &cleanup); /* error owns the input string */
    fwp_fail(result, &decoder_error);
    return 0;
}
static V legacy_decoder_entry(V *args) { (void)args; _Exit(197); }
static void decoder_arguments(V *args, uint32_t start, uint32_t count) {
    if (start || count != 1) _Exit(198);
    fwp_rc_dup(args[0]);
}
static void decoder_drop_arguments(V *args, uint32_t start, uint32_t count) {
    if (start || count != 1) _Exit(198);
    fwp_rc_free_obj(args[0]);
}
static void decoder_captures(V function, int duplicate) {
    if (CLO(function)->n) _Exit(198);
    if (!duplicate) fwp_rc_free_obj(function);
}
static const fwp_owned_fninfo decoder_owned = {
    decoder_entry, decoder_captures, decoder_arguments, decoder_drop_arguments
};
static const fwp_fninfo decoder_functions[] = {
    {1, legacy_decoder_entry, "decoder", &decoder_owned}
};
int main(void) {
    fwp_lib_init(); fwp_gc_start(__builtin_frame_address(0)); fwp_tasks_init();
    fwp_fns = decoder_functions;
    double before = fwp_gc.total_alloc + (double)(fwp_gc.budget_given-fwp_gc.budget);
    V function = fwp_rc_fresh(fwp_pap(0, 0, 0));
    g_codec codec = {0}; codec.fn = function;
    for (decoder_mode = 0; decoder_mode < 3; decoder_mode++) {
        volatile int trapped = 0;
        fwp_trap_recover = recover_decoder; fwp_trap_jb = &decoder_trap;
        fwp_trap_cleanup = fwp_cleanups;
        if (!setjmp(decoder_trap)) {
            V result = 0; char *why = 0;
            int status = g_decode(&codec, (const unsigned char *)"bytes", 5, &result, &why);
            if (decoder_mode == 0) {
                if (status != G_DEC_OK || why || STR(result)->len != 5 || memcmp(STR(result)->d,"bytes",5)) return 190;
                fwp_rc_free_obj(result);
            } else {
                if (decoder_mode != 1 || status != G_DEC_BAD || !why || strcmp(why,"bytes")) return 191;
                free(why);
            }
        } else trapped = 1;
        fwp_trap_recover = 0; fwp_trap_jb = 0; fwp_trap_cleanup = 0;
        if (trapped != (decoder_mode == 2) || fwp_handlers || fwp_cleanups) return 192;
        if (!fwp_rc_last(function)) return 193;
        FWP_KEEP_ALIVE(function);
    }
    fwp_closure_drop(function);
    double after = fwp_gc.total_alloc + (double)(fwp_gc.budget_given-fwp_gc.budget);
    if (!fwp_gc.enabled && !fwp_reuse_verify && (after != before || fwp_gc.ncollect)) return 194;
    fwp_lib_finish(); return 0;
}
