static const fwp_desc socket_leaf_type={.kind=K_STR,.drop=fwp_rc_free_obj};
static const fwp_desc *const socket_tuple_fields[]={&socket_leaf_type,&socket_leaf_type};
static const fwp_desc socket_tuple_type={.kind=K_RECORD,.n=2,.fields=socket_tuple_fields};
static jmp_buf socket_jump;
static int socket_recover(void) { return 1; }
int main(void) {
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns=fwp_fn_table; fwp_init_consts();
    if(fwp_sockets_init()) return 246;
    fwp_sock handle={.fd=0,.kind=2,.refs=1};
    V address=fwp_cstr("127.0.0.1:9"), data=fwp_cstr("x");
    for(int operation=0;operation<3;operation++) {
        for(socket_mode=0;socket_mode<(operation==2?1:3);socket_mode++) {
            fwp_trap_recover=socket_recover; fwp_trap_jb=&socket_jump;
            fwp_trap_cleanup=fwp_cleanups; socket_inject=1;
            if(!setjmp(socket_jump)) {
                if(operation==0) (void)fwp_tcp_read(64,PTR(&handle),0,NULL);
                else if(operation==1) (void)fwp_p_udp_recv_from(64,PTR(&handle),NULL,&socket_tuple_type);
                else (void)fwp_p_udp_send_to(address,data,PTR(&handle),NULL);
                return 247;
            }
            socket_inject=0; fwp_trap_recover=NULL; fwp_trap_jb=NULL;
            if(socket_native_live || socket_resolver_live || fwp_cleanups) {
                fprintf(stderr,"socket operation %d mode %d: native buffers %d, resolver results %d\n",
                        operation,socket_mode,socket_native_live,socket_resolver_live);
                return 248;
            }
        }
    }
    socket_mode=3;
    if(fwp_tcp_read(64,PTR(&handle),1,NULL)!=0 || socket_native_live || fwp_cleanups) return 247;
    puts("socket cancellation, result allocation, native allocation and timeout: no native storage remains");
    return 0;
}
