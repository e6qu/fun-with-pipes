static int byte_left;
static jmp_buf byte_jump;
static int byte_recover(void) { return 1; }
static void byte_allocation(void) {
    if(byte_left>0 && !--byte_left) fwp_trap("injected byte allocation failure");
}
static void byte_leaf_drop(V value) {
    if(fwp_rc_release_last(value)) fwp_rc_resource_free_obj(value);
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns=fwp_fn_table; fwp_init_consts();
    intptr_t initial_budget=fwp_gc.budget;
    for(int which=0;which<16;which++) {
        V raw=fwp_rc_fresh(fwp_cstr("hello hello hello")), input=raw;
        if(which<2) input=fwp_rc_fresh(fwp_p_zlib_gzip(raw));
        if(which==2) input=fwp_rc_fresh(fwp_p_zlib_deflate(raw));
        if(which==3) input=fwp_rc_fresh(fwp_str_new("\x78\x01\x03\x00\x00\x00\x00\x00",8));
        if(which==4) input=fwp_rc_fresh(fwp_p_ws_frame(FWP_TRUE,1,raw));
        if(which==5 || which==8) input=fwp_rc_fresh(fwp_str_new("\xff",1));
        if(which==6) input=fwp_rc_fresh(fwp_str_new("\x03\xe8ok",4));
        if(which==7) input=fwp_rc_fresh(fwp_p_ws_deflate(raw));
        if(byte_buffers_live) return 249;
        int failures=0, completed=0;
        for(int allocation=1;allocation<64;allocation++) {
            intptr_t budget=fwp_gc.budget;
            fwp_trap_recover=byte_recover; fwp_trap_jb=&byte_jump;
            fwp_trap_cleanup=fwp_cleanups; byte_left=allocation;
            if(!setjmp(byte_jump)) {
                V result; const fwp_desc *type=NULL;
                switch(which) {
                case 0: case 1: type=GZIP_RESULT; result=fwp_p_zlib_gunzip(which==0?100:1,input,type); break;
                case 2: case 3: type=DEFLATE_RESULT; result=fwp_p_zlib_inflate(100,input,type); break;
                case 4: case 5: type=FRAME_RESULT; result=fwp_p_ws_parse(100,0,input,type); break;
                case 6: type=CLOSE_RESULT; result=fwp_p_ws_close_parse(input,type); break;
                case 7: case 8: type=WS_RESULT; result=fwp_p_ws_inflate(100,input,type); break;
                case 9: result=fwp_p_zlib_gzip(input); break;
                case 10: result=fwp_p_zlib_gzip_chunk(input); break;
                case 11: result=fwp_p_zlib_deflate(input); break;
                case 12: result=fwp_p_ws_deflate(input); break;
                case 13: result=fwp_p_ws_accept(input); break;
                case 14: result=fwp_p_ws_key(); break;
                default: result=fwp_p_ws_close_payload(1000,input); break;
                }
                byte_left=0;
                if(type) type->drop(result); else byte_leaf_drop(fwp_rc_fresh(result));
                completed=1;
            } else failures++;
            byte_left=0; fwp_trap_recover=NULL; fwp_trap_jb=NULL;
            if(fwp_cleanups || fwp_gc.budget!=budget || byte_buffers_live) {
                fprintf(stderr,"byte case %d allocation %d: charged delta %lld, native buffers %d, cleanup pending %d\n",which,allocation,(long long)(budget-fwp_gc.budget),byte_buffers_live,fwp_cleanups!=NULL);
                return 248;
            }
            if(!fwp_rc_last(input)) return 249;
            if(completed) break;
        }
        if(!completed || failures<1) return 247;
        printf("byte case %d: %d managed allocation failures checked; final charged delta 0; native buffers 0\n",which,failures);
        if(input!=raw) byte_leaf_drop(input);
        byte_leaf_drop(raw);
        if(fwp_gc.budget!=initial_budget) return 248;
    }
    return 0;
}
