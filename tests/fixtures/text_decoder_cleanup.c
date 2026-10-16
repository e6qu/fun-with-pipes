static int decoder_left;
static jmp_buf decoder_jump;
static int decoder_recover(void) { return 1; }
static void decoder_allocation(void) {
    if(decoder_left>0 && !--decoder_left) fwp_trap("injected decoder allocation failure");
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns=fwp_fn_table; fwp_init_consts();
    const char *inputs[]={"a%20b%C3%BC", "https://example.com/path?q=1", "GET / HTTP/1.1\r\nA: 1\r\nB: 2", "HTTP/1.1 200 OK\r\nA: 1\r\nB: 2", "GET / HTTP/1.1\r\nInvalid\r\nB: 2"};
    const fwp_desc *types[]={URL_OPTION,URL_PARTS,HTTP_REQUEST,HTTP_RESPONSE,HTTP_REQUEST};
    for(int which=0;which<5;which++) {
        V input=fwp_rc_fresh(fwp_cstr(inputs[which]));
        int failures=0,completed=0;
        for(int allocation=1;allocation<64;allocation++) {
            intptr_t budget=fwp_gc.budget;
            fwp_trap_recover=decoder_recover; fwp_trap_jb=&decoder_jump;
            fwp_trap_cleanup=fwp_cleanups;
            decoder_left=allocation;
            if(!setjmp(decoder_jump)) {
                V result;
                if(which==0) result=fwp_p_url_decode(input,0,types[which]);
                else if(which==1) result=fwp_p_url_split(input,types[which]);
                else if(which==3) result=fwp_p_parse_response_head(input,types[which]);
                else result=fwp_p_parse_request_head(input,types[which]);
                decoder_left=0;
                types[which]->drop(result);
                completed=1;
            } else failures++;
            decoder_left=0; fwp_trap_recover=NULL; fwp_trap_jb=NULL;
            if(fwp_cleanups || fwp_gc.budget!=budget) return 248;
            if(!fwp_rc_last(input)) return 249;
            if(completed) break;
        }
        if(!completed || failures<3) return 247;
        fwp_rc_drop(input);
    }
    return 0;
}
