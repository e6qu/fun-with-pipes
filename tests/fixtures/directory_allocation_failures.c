/* Included after the generated runtime. Fault injection calls either its
 * recoverable trap boundary or its terminal managed-heap OOM handler. */
static jmp_buf directory_failure;
static int recover_directory_failure(void) { return 1; }
static void check_directory_storage(size_t bytes, size_t allocations) {
    if (probe_opened != probe_closed) {
        fprintf(stderr,"directory handles remain open\n"); _Exit(241);
    }
    if (fwp_heap.live != bytes || owner_ledger_live != allocations || fwp_cleanups) {
        fprintf(stderr,"directory owners remain live\n"); _Exit(242);
    }
}
static void release_test_path(V path) {
    if (!fwp_rc_release_last(path)) _Exit(243);
    fwp_rc_free_obj(path);
}
int main(int argc, char **argv) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0 ||
        _setmode(_fileno(stderr), _O_BINARY) < 0) return 244;
#endif
    fwp_heap_start(); fwp_fns=fwp_fn_table; fwp_init_consts();
    size_t baseline_bytes=fwp_heap.live, baseline_allocations=owner_ledger_live;
    if (REPORT(fwp_rc_fresh(fwp_cstr("tree"))) != EXPECTED) return 1;
    check_directory_storage(baseline_bytes, baseline_allocations);
    if (argc == 2) {
        probe_stage=atoi(argv[1]);
        if (probe_stage<1 || probe_stage>4) return 2;
        V path=fwp_rc_fresh(fwp_cstr("tree"));
        probe_phase=0; probe_allocations=0;
        probe_fatal=1; probe_active=1;
        REPORT(path);
        return 3; /* Every named boundary must reach the production OOM exit. */
    }
    if (argc != 1) return 4;
    unsigned recovered=0;
    for (volatile int repeat=0;repeat<4;repeat++) {
        for (volatile int alias=0;alias<2;alias++) {
            for (volatile int stage=1;stage<=4;stage++) {
                /* Omission controls target a populated builder, before growth. */
                if ((PROBE_OMIT_MAP || PROBE_OMIT_CLOSE) && stage!=3) continue;
                V path=fwp_rc_fresh(fwp_cstr("tree"));
                if (alias) fwp_rc_dup(path);
                probe_stage=stage; probe_phase=0; probe_allocations=0; probe_hit=0;
                fwp_trap_recover=recover_directory_failure;
                fwp_trap_jb=&directory_failure; fwp_trap_cleanup=NULL;
                probe_active=1;
                if (!setjmp(directory_failure)) { REPORT(path); return 5; }
                probe_active=0;
                fwp_trap_recover=NULL; fwp_trap_jb=NULL; fwp_trap_cleanup=NULL;
                if (!probe_hit || strcmp(fwp_trap_msg,"directory allocation boundary")) return 6;
                if (alias) {
                    if (!fwp_rc_slot(path) || *fwp_rc_slot(path)!=1 || STR(path)->len!=4) return 7;
                    release_test_path(path);
                }
                check_directory_storage(baseline_bytes, baseline_allocations);
                recovered++;
                if (REPORT(fwp_rc_fresh(fwp_cstr("tree"))) != EXPECTED) return 8;
                check_directory_storage(baseline_bytes, baseline_allocations);
            }
        }
    }
    if (recovered!=32) return 9;
    puts("32 directory allocation-boundary traps and retries preserve owners");
    return 0;
}
