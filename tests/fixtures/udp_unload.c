/* Host calls finish only after all library calls have returned. */
void setup(uintptr_t *descriptor) {
    fwp_lib_init();
    intptr_t budget=fwp_gc.budget;
    for(int i=0;i<32;i++) if(!probe(i)) exit(247);
    if(fwp_gc.ncollect || fwp_gc.enabled) exit(248);
    if(!fwp_reuse_verify && fwp_gc.budget<budget) exit(248);
    V address=fwp_rc_fresh(fwp_cstr("127.0.0.1:0"));
    V handle=fwp_p_udp_bind(address,NULL);
    *descriptor=(uintptr_t)SOCK(handle)->fd;
    /* This owner intentionally survives until library unload. */
    V released=fwp_p_udp_bind(address,NULL);
    fwp_udp_dup(released);
    fwp_p_sock_close(released);
    fwp_udp_drop(released); fwp_udp_drop(released);
    fwp_rc_free_obj(address);
}
