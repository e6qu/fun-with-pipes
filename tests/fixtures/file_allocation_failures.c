/* Recovery occurs outside the generated entry, after its actual cleanup stack
 * has unwound. Terminal exhaustion is observed in separate subprocesses. */
static jmp_buf read_failure;
static int recover_read_failure(void) { return 1; }
static void check_read_storage(size_t bytes, size_t allocations) {
    if (read_opened != read_closed) {
        fprintf(stderr,"file read handles remain open\n"); _Exit(241);
    }
    if (read_raw) {
        fprintf(stderr,"file read scratch remains live\n"); _Exit(242);
    }
    if (fwp_heap.live != bytes || owner_ledger_live != allocations || fwp_cleanups) {
        fprintf(stderr,"file read owners remain live\n"); _Exit(243);
    }
}
static void release_read_path(V path) {
    if (!fwp_rc_release_last(path)) _Exit(244);
    fwp_rc_free_obj(path);
}
int main(int argc, char **argv) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0 ||
        _setmode(_fileno(stderr), _O_BINARY) < 0) return 245;
#endif
    fwp_heap_start(); fwp_fns=fwp_fn_table; fwp_init_consts();
    size_t baseline_bytes=fwp_heap.live, baseline_allocations=owner_ledger_live;
    if (READ_PAIR(fwp_rc_fresh(fwp_cstr("input"))) != UINT64_C(300000)) return 1;
    check_read_storage(baseline_bytes, baseline_allocations);
    if (argc == 3) {
        read_stage=atoi(argv[1]); read_target=atoi(argv[2]);
        if (read_stage<1 || read_stage>3 || read_target<1 || read_target>2) return 2;
        V path=fwp_rc_fresh(fwp_cstr("input"));
        read_number=0; read_fatal=1; read_active=1;
        READ_PAIR(path);
        return 3;
    }
    if (argc != 1) return 4;
    unsigned recovered=0;
    for (volatile int repeat=0;repeat<4;repeat++) {
        for (volatile int alias=0;alias<2;alias++) {
            for (read_target=1;read_target<=2;read_target++) {
                for (read_stage=1;read_stage<=3;read_stage++) {
                    /* Fault while the second read holds a populated scratch
                     * buffer; the first result is also live in the text case. */
                    if ((READ_OMIT_CLOSE || READ_OMIT_RAW || READ_OMIT_OWNER) &&
                        (read_target!=2 || read_stage!=2)) continue;
                    V path=fwp_rc_fresh(fwp_cstr("input"));
                    if (alias) fwp_rc_dup(path);
                    read_number=0; read_hit=0;
                    fwp_trap_recover=recover_read_failure;
                    fwp_trap_jb=&read_failure; fwp_trap_cleanup=NULL;
                    read_active=1;
                    if (!setjmp(read_failure)) { READ_PAIR(path); return 5; }
                    read_active=0;
                    fwp_trap_recover=NULL; fwp_trap_jb=NULL; fwp_trap_cleanup=NULL;
                    if (!read_hit || strcmp(fwp_trap_msg,"file read allocation boundary")) return 6;
                    if (alias) {
                        if (!fwp_rc_slot(path) || *fwp_rc_slot(path)!=1 || STR(path)->len!=5 ||
                            memcmp(STR(path)->d,"input",5)) return 7;
                        release_read_path(path);
                    }
                    check_read_storage(baseline_bytes, baseline_allocations);
                    recovered++;
                    if (READ_PAIR(fwp_rc_fresh(fwp_cstr("input"))) != UINT64_C(300000)) return 8;
                    check_read_storage(baseline_bytes, baseline_allocations);
                }
            }
        }
    }
    if (recovered!=48) return 9;
    puts("48 file read allocation-boundary traps and retries preserve owners");
    return 0;
}
