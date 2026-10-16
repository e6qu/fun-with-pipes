/* Host calls finish only after all library calls have returned. */
void setup(uintptr_t *descriptor) {
    fwp_lib_init();
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
