static int io_collect, io_events, io_fail_at;
static jmp_buf io_failure;
static int io_recover(void) { return 1; }
static void io_event(void) {
#if !FWP_ARC_ONLY
    if (io_collect) fwp_heap_collect();
#endif
    if (++io_events == io_fail_at) fwp_trap("I/O error construction probe");
}
static V io_string(const char *text) { io_event(); return fwp_cstr(text); }
static V io_record(size_t count, const V *fields) { io_event(); return fwp_record(count,fields); }
static int io_drop_error(V error) {
    if (*fwp_rc_slot(error)!=1) return 231;
    for (int i=0;i<2;i++) {
        V text=OBJ(error)->f[i];
        if (*fwp_rc_slot(text)!=1) return 231;
        if (!fwp_rc_release_last(text)) return 231;
        fwp_rc_free_obj(text);
    }
    if (!fwp_rc_release_last(error)) return 231;
    fwp_rc_free_obj(error);
    return 0;
}
int main(void) {
    fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();
#if FWP_ARC_ONLY
    const int collect_limit=0;
#else
    const int collect_limit=1;
#endif
    for(io_collect=0;io_collect<=collect_limit;io_collect++) {
        size_t live_bytes=fwp_heap.live;
        for(int repeat=0;repeat<128;repeat++) {
            fwp_handler handler={0};handler.prev=fwp_handlers;handler.cleanup=fwp_cleanups;
            fwp_handlers=&handler;io_events=0;
            if(!setjmp(handler.jb)){fwp_io_error("read","missing",NULL);return 230;}
            fwp_handlers=handler.prev;
            if(io_events!=3 || fwp_cleanups!=handler.cleanup)return 233;
            if(STR(OBJ(handler.value)->f[0])->len!=4 || STR(OBJ(handler.value)->f[1])->len!=7)return 234;
            int status=io_drop_error(handler.value);if(status)return status;
            handler.value=0;
            if(!io_collect && fwp_heap.live!=live_bytes)return 232;
        }
        for(int repeat=0;repeat<128;repeat++) {
            io_events=0;fEXERCISE(FWP_UNIT);
            if(io_events!=3 || fwp_cleanups)return 239;
            if(!io_collect && fwp_heap.live!=live_bytes)return 240;
        }
        fwp_trap_recover=io_recover;fwp_trap_jb=&io_failure;fwp_trap_cleanup=fwp_cleanups;
        for(io_fail_at=1;io_fail_at<=3;io_fail_at++) {
            io_events=0;
            if(!setjmp(io_failure)){fwp_io_error("read","missing",NULL);return 236;}
            if(fwp_cleanups!=fwp_trap_cleanup)return 237;
            if(!io_collect && fwp_heap.live!=live_bytes)return 235;
        }
        io_fail_at=0;fwp_trap_recover=0;fwp_trap_jb=0;fwp_trap_cleanup=0;
    }
#if !FWP_ARC_ONLY
    if(!fwp_heap.ncollect)return 238;
#endif
    return 0;
}
