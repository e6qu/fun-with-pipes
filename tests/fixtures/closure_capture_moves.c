/* Count effective retains of the two captured strings before callee entry.
 * The language body owns its inputs; its ordinary/error/trap exits exercise
 * the generated cleanup, including scalar words that resemble heap pointers. */
static jmp_buf capture_failed;
static int recover_capture(void) { return 1; }
static V capture_text(const char *text) { return fwp_rc_fresh(fwp_cstr(text)); }
static V capture_argument(V scalar, V text) { return fwp_rc_fresh(fwp_tuple2(scalar, text)); }
static void check_capture_result(V result) {
    if (STR(result)->len != 15 || memcmp(STR(result)->d,"tailsecondfirst",15)) _Exit(203);
    fwp_rc_free_obj(result);
}
int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 253;
#endif
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns=fwp_fn_table; fwp_init_consts();
    for(int round=0;round<32;round++){
    for (volatile int mode=0; mode<12; mode++) {
        int shared=mode%2, partial=(mode%4)/2, failure=mode/4;
        double before=fwp_gc.total_alloc+(double)(fwp_gc.budget_given-fwp_gc.budget);
        V scalar=capture_text("bits");
        capture_first=capture_text("first"); capture_second=capture_text("second");
        V function=fwp_rc_fresh(fwp_pap(ID,partial?1:2,(V[]){capture_first,capture_second}));
        V alias=0;
        if(shared){alias=function;fwp_rc_dup(alias);}
        int partial_retains=0;
        if(partial) {
            capture_retains=0;capture_measuring=1;
            function=fwp_apply_owned(function,1,&capture_second);
            capture_measuring=0;
            partial_retains=capture_retains;
            if(capture_retains!=(shared?1:0))return 201;
        }
        V argument=capture_argument(failure==1?0:scalar,capture_text("tail"));
        fwp_handler handler;
        handler.prev=fwp_handlers;handler.state_depth=fwp_state_len;handler.cleanup=fwp_cleanups;
        fwp_handlers=&handler;
        fwp_trap_recover=recover_capture;fwp_trap_jb=&capture_failed;fwp_trap_cleanup=fwp_cleanups;
        capture_retains=0;capture_measuring=1;capture_trap=failure==2;
        volatile int outcome=0;
        if(!setjmp(capture_failed)) {
            if(!setjmp(handler.jb)) check_capture_result(fwp_apply_owned(function,1,&argument));
            else {outcome=1;if(handler.desc->drop)handler.desc->drop(handler.value);}
        } else outcome=2;
        capture_measuring=0;capture_trap=0;
        fwp_handlers=handler.prev;fwp_trap_recover=0;fwp_trap_jb=0;fwp_trap_cleanup=0;
        if(outcome!=failure||fwp_cleanups)return 204;
        if(capture_retains!=(!partial&&shared?2:0))return 201;
        if(shared) {
            if(CLO(alias)->n!=(uint32_t)(partial?1:2))return 202;
            V tail=capture_argument(scalar,capture_text("tail"));
            if(partial) {
                V second=capture_text("second");
                check_capture_result(fwp_apply_owned(alias,2,(V[]){second,tail}));
            } else check_capture_result(fwp_apply_owned(alias,1,&tail));
        }
        if(!fwp_rc_last(scalar)||STR(scalar)->len!=4||memcmp(STR(scalar)->d,"bits",4))return 205;
        fwp_rc_free_obj(scalar);
        double after=fwp_gc.total_alloc+(double)(fwp_gc.budget_given-fwp_gc.budget);
#ifdef FWP_ARC_ONLY
        if(before!=after||fwp_gc.rc_wide_len||fwp_gc.ncollect)return 206;
#else
        if(!fwp_gc.enabled&&!fwp_reuse_verify&&(before!=after||fwp_gc.ncollect))return 206;
#endif
        if(round==31)printf("%d\t%d\t%d\t%.0f\n", mode, partial_retains, capture_retains, after-before);
    }
    }
    return 0;
}
