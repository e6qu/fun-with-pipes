/* Host calls finish only after all library calls have returned. */
#ifdef _WIN32
__declspec(dllexport)
#endif
void setup(uintptr_t *descriptor) {
    fwp_lib_init();
    size_t live_bytes=fwp_heap.live;
    for(int i=0;i<32;i++) if(!probe(i)) exit(247);
    if(fwp_heap.live > live_bytes) exit(248);
    V address=fwp_rc_fresh(fwp_cstr("127.0.0.1:0"));
    V handle=fwp_p_udp_bind(address,NULL);
    *descriptor=(uintptr_t)SOCK(handle)->fd;
    /* This owner intentionally survives until library unload. */
    V released=fwp_p_udp_bind(address,NULL);
    fwp_sock_dup(released);
    fwp_p_sock_close(released);
    fwp_sock_drop(released); fwp_sock_drop(released);
    fwp_rc_free_obj(address);
}
